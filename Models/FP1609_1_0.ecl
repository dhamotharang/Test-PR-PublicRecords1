import Std, risk_indicators, riskwise, riskwisefcra, ut, easi, Models;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1609_1_0(dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons)
									 := FUNCTION
									
		FP_DEBUG := False;
		
		isFCRA := False;

	#if(FP_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
Integer seq;
Integer	 sysdate;
String	 iv_add_apt;
Integer	 rv_p88_phn_dst_to_inp_add;
String1	 add_ec3;
String1	 add_ec4;
Integer	 rv_f03_input_add_not_most_rec;
Integer	 rv_c19_add_prison_hist;
Integer	 rv_f01_inp_addr_address_score;
Integer	 rv_d30_derog_count;
Integer	 rv_d32_criminal_count;
String3	 rv_d32_criminal_x_felony;
Real	 _criminal_last_date;
Real	 _felony_last_date;
Real	 rv_d31_attr_bankruptcy_recency;
String	 rv_d33_eviction_recency;
Real	 rv_d33_eviction_count;
Real	 rv_d34_unrel_lien60_count;
String	 iv_d34_liens_unrel_x_rel;
Integer	 rv_c20_m_bureau_adl_fs;
Integer	 nf_m_bureau_adl_fs_all;
Integer	 _src_bureau_adl_fseen_notu;
Integer	 nf_m_bureau_adl_fs_notu;
Real	 _header_first_seen;
Integer	 rv_c10_m_hdr_fs;
Decimal21_1	 rv_c12_source_profile;
Integer	 _in_dob;
Real	 yr_in_dob;
Integer	 yr_in_dob_int;
Integer	 rv_c13_max_lres;
Integer	 rv_c14_addrs_5yr;
Integer	 rv_c14_addrs_10yr;
Integer	 rv_c14_addrs_per_adl_c6;
Integer	 rv_c14_addrs_15yr;
String	 rv_a43_rec_vehx_level;
Integer	 rv_email_count;
Integer	 rv_email_domain_isp_count;
Integer	 rv_e57_prof_license_br_flag;
Integer	 rv_i61_inq_collection_recency;
Integer	 rv_i60_inq_banking_count12;
Integer	 rv_i60_inq_hiriskcred_count12;
Integer	 rv_i60_inq_prepaidcards_recency;
Integer	 rv_i60_inq_retpymt_count12;
Integer	 rv_l79_adls_per_addr_curr;
Integer	 rv_l79_adls_per_apt_addr;
Integer	 rv_l79_adls_per_addr_c6;
Integer	 rv_l79_adls_per_sfd_addr_c6;
Integer	 rv_c13_attr_addrs_recency;
Boolean	 rv_truedid;
Boolean	 iv_addrpop;
Boolean	 iv_fnamepop;
Boolean	 iv_lnamepop;
Boolean	 iv_hphnpop;
String	 iv_ssnlength;
Boolean	 iv_dobpop;
Boolean	 ssnpop;
Boolean	 iv_rv5_deceased;
Integer	 iv_full_name_non_phn_src_ct;
String	 iv_full_name_ver_sources;
Integer	 iv_addr_non_phn_src_ct;
String	 iv_c22_addr_ver_sources;
Integer	 iv_dob_src_ct;
Boolean	 _nap_ver;
Boolean	 _inf_ver;
Integer	 rv_c13_inp_addr_lres;
Integer	 rv_c12_inp_addr_source_count;
String	 mortgage_type;
Boolean	 mortgage_present;
Integer	 iv_prv_addr_lres;
Integer	 iv_c14_addrs_per_adl;
Integer	 rv_i60_inq_other_count12;
Integer	 rv_i62_inq_num_names_per_adl;
Integer	 rv_i62_inq_phones_per_adl;
Integer	 br_first_seen_char;
Integer	 _br_first_seen;
Integer	 iv_br_source_count;
String	 rv_e58_br_dead_bus_x_active_phn;
Unicode	 br_company_title1;
Unicode	 br_company_title2;
Integer	 iv_d34_liens_unrel_lt_ct;
Boolean	 major_medical;
Boolean	 major_science;
Boolean	 major_liberal;
Boolean	 major_business;
Boolean	 major_unknown;
String	 iv_college_major;
Integer	 sum_dols;
Real	 pct_offline_dols;
Real	 pct_retail_dols;
Real	 pct_online_dols;
Integer	 num_dob_match_level;
Integer	 nas_summary_ver;
Integer	 nap_summary_ver;
Integer	 infutor_nap_ver;
Integer	 dob_ver;
Integer	 sufficiently_verified;
String	 add_ec1;
Integer	 addr_validation_problem;
Integer	 phn_validation_problem;
Integer	 validation_problem;
Integer	 tot_liens;
Integer	 tot_liens_w_type;
Integer	 has_derog;
String	 rv_4seg_riskview_5_0;
Real	 _src_bureau_adl_fseen;
Integer	 nf_bus_addr_match_count;
Integer	 nf_bus_phone_match;
String	 adl_util_i;
String	 adl_util_c;
String	 adl_util_m;
String	 nf_util_adl_summary;
Integer	 nf_util_adl_count;
String	 inp_util_i;
String	 inp_util_c;
String	 inp_util_m;
String	 nf_util_add_input_summary;
String	 curr_util_i;
String	 curr_util_c;
String	 curr_util_m;
String	 nf_util_add_curr_summary;
Integer	 add_input_nhood_prop_sum;
Integer	 add_curr_nhood_prop_sum;
Integer	 nf_phone_ver_experian;
Integer	 nf_addrs_per_ssn;
Integer	 nf_phones_per_addr_curr;
Integer	 nf_phones_per_apt_addr_curr;
Integer	 nf_phones_per_sfd_addr_c6;
Integer	 nf_inq_count;
Integer	 nf_inq_count24;
Integer	 nf_inq_banking_count;
Integer	 nf_inq_banking_count24;
Integer	 nf_inq_communications_count;
Integer	 nf_inq_communications_count24;
Integer	 nf_inq_highriskcredit_count;
Integer	 nf_inq_highriskcredit_count_week;
Integer	 nf_inq_other_count;
Integer	 nf_inq_other_count24;
Integer	 nf_inq_prepaidcards_count;
Integer	 nf_inq_prepaidcards_count24;
Integer	 nf_inq_retail_count;
Integer	 nf_inq_retailpayments_count24;
Integer	 nf_inq_per_addr;
Integer	 nf_inq_per_apt_addr;
Integer	 nf_inq_per_sfd_addr;
Integer	 nf_inq_lnames_per_sfd_addr;
Integer	 nf_inq_ssns_per_addr;
Integer	 nf_inq_ssns_per_sfd_addr;
Integer	 nf_inq_per_phone;
Integer	 _inq_banko_am_first_seen;
Integer	 nf_mos_inq_banko_am_fseen;
Integer	 _inq_banko_am_last_seen;
Integer	 _inq_banko_cm_first_seen;
Integer	 _inq_banko_cm_last_seen;
Integer	 nf_mos_inq_banko_cm_lseen;
Integer	 _inq_banko_om_first_seen;
Integer	 _inq_banko_om_last_seen;
Integer	 nf_mos_inq_banko_om_lseen;
Boolean	 nf_email_src_aw;
String	 email_src_aw_fseen;
Integer	 _email_src_aw_fseen;
String	 email_src_aw_lseen;
Integer	 _email_src_aw_lseen;
Integer	 em_aw_pos;
Boolean	 nf_email_src_ib;
String	 email_src_ib_fseen;
Integer	 _email_src_ib_fseen;
String	 email_src_ib_lseen;
Integer	 _email_src_ib_lseen;
Integer	 em_ib_pos;
Boolean	 nf_email_src_m1;
String	 email_src_m1_fseen;
Integer	 _email_src_m1_fseen;
String	 email_src_m1_lseen;
Integer	 _email_src_m1_lseen;
Integer	 em_m1_pos;
Boolean	 nf_email_src_et;
String	 email_src_et_fseen;
Integer	 _email_src_et_fseen;
String	 email_src_et_lseen;
Integer	 _email_src_et_lseen;
Integer	 em_et_pos;
Boolean	 nf_email_src_wa;
String	 email_src_wa_fseen;
Integer	 _email_src_wa_fseen;
String	 email_src_wa_lseen;
Integer	 _email_src_wa_lseen;
Integer	 em_wa_pos;
Boolean	 nf_email_src_dg;
String	 email_src_dg_fseen;
Integer	 _email_src_dg_fseen;
String	 email_src_dg_lseen;
Integer	 _email_src_dg_lseen;
Integer	 em_dg_pos;
Boolean	 nf_email_src_sc;
String	 email_src_sc_fseen;
Integer	 _email_src_sc_fseen;
String	 email_src_sc_lseen;
Integer	 _email_src_sc_lseen;
Integer	 em_sc_pos;
Integer	 nf_attr_arrests;
Integer	 nf_attr_arrest_recency;
Integer	 nf_vf_hi_risk_ct;
Integer	 nf_vf_lexid_phn_lo_risk_ct;
Integer	 nf_vf_altlexid_phn_hi_risk_ct;
Integer	 nf_vf_lexid_addr_hi_risk_ct;
Integer	 nf_vf_lexid_ssn_hi_risk_ct;
Integer	 _liens_unrel_cj_first_seen;
Integer	 _liens_unrel_cj_last_seen;
Integer	 nf_liens_unrel_cj_total_amt;
Integer	 _liens_rel_cj_first_seen;
Integer	 _liens_rel_cj_last_seen;
Integer	 nf_mos_liens_rel_cj_lseen;
Integer	 _liens_unrel_ft_first_seen;
Integer	 nf_mos_liens_unrel_ft_fseen;
Integer	 _liens_unrel_ft_last_seen;
Integer	 _liens_rel_ft_first_seen;
Integer	 _liens_rel_ft_last_seen;
Integer	 _liens_unrel_fc_first_seen;
Integer	 _liens_unrel_fc_last_seen;
Integer	 _liens_rel_fc_first_seen;
Integer	 _liens_rel_fc_last_seen;
Integer	 _liens_unrel_lt_first_seen;
Integer	 nf_mos_liens_unrel_lt_fseen;
Integer	 _liens_unrel_lt_last_seen;
Integer	 _liens_rel_lt_first_seen;
Integer	 _liens_rel_lt_last_seen;
Integer	 _liens_unrel_o_first_seen;
Integer	 _liens_unrel_o_last_seen;
Integer	 _liens_rel_o_first_seen;
Integer	 _liens_rel_o_last_seen;
Integer	 nf_liens_rel_o_total_amt;
Integer	 _liens_unrel_ot_first_seen;
Integer	 _liens_unrel_ot_last_seen;
Integer	 _liens_rel_ot_first_seen;
Integer	 _liens_rel_ot_last_seen;
Integer	 _liens_unrel_sc_first_seen;
Integer	 nf_mos_liens_unrel_sc_fseen;
Integer	 _liens_unrel_sc_last_seen;
Integer	 nf_mos_liens_unrel_sc_lseen;
Integer	 nf_liens_unrel_sc_total_amt;
Integer	 _liens_rel_sc_first_seen;
Integer	 _liens_rel_sc_last_seen;
Integer	 _liens_unrel_st_first_seen;
Integer	 nf_mos_liens_unrel_st_fseen;
Integer	 _liens_unrel_st_last_seen;
Integer	 nf_liens_unrel_st_total_amt;
Integer	 _liens_rel_st_first_seen;
Integer	 _liens_rel_st_last_seen;
Integer	 _foreclosure_last_date;
Integer	 iv_estimated_income;
String	 nf_historic_x_current_ct;
Integer current_count;
Integer historical_count;
Integer	 _acc_last_seen;
Integer	 _prof_license_ix_sanct_fs;
Integer _prof_license_ix_sanct_ls;
Integer	 nf_fp_idverrisktype;
Integer	 nf_fp_idveraddressnotcurrent;
Integer	 nf_fp_sourcerisktype;
Integer	 nf_fp_varrisktype;
Integer	 nf_fp_srchunvrfdssncount;
Integer	 nf_fp_srchunvrfdphonecount;
Integer	 nf_fp_srchfraudsrchcount;
Integer	 nf_fp_srchfraudsrchcountmo;
Integer	 nf_fp_srchfraudsrchcountwk;
Integer	 nf_fp_srchcomponentrisktype;
Integer	 nf_fp_srchssnsrchcountmo;
Integer	 nf_fp_srchaddrsrchcount;
Integer	 nf_fp_srchaddrsrchcountmo;
Integer	 nf_fp_srchaddrsrchcountwk;
Integer	 nf_fp_srchphonesrchcountmo;
Integer	 nf_fp_srchphonesrchcountwk;
Integer	 nf_fp_prevaddrlenofres;
Integer	 nf_fp_prevaddroccupantowned;
Integer	 nf_pb_retail_combo_cnt;
Integer	 nf_pb_retail_combo_max;
Integer	 bureau_adl_eq_fseen_pos;
String	 bureau_adl_fseen_eq;
Integer	 _bureau_adl_fseen_eq;
Integer	 bureau_adl_en_fseen_pos;
String	 bureau_adl_fseen_en;
Integer	 _bureau_adl_fseen_en;
Integer	 bureau_adl_ts_fseen_pos;
String	 bureau_adl_fseen_ts;
Integer	 _bureau_adl_fseen_ts;
Integer	 bureau_adl_tu_fseen_pos;
String	 bureau_adl_fseen_tu;
Integer	 _bureau_adl_fseen_tu;
Integer	 bureau_adl_tn_fseen_pos;
String	 bureau_adl_fseen_tn;
Integer	 _bureau_adl_fseen_tn;
Integer	 _src_bureau_adl_fseen_all;
Integer	 credit_bureau_oldest;
Integer	 num_sources;
Boolean	 bureau_;
Boolean	 behavioral_;
Boolean	 government_;
String	 nf_source_type;
Integer	 nf_inq_per_add_nas_479;
Boolean	 _add_not_ver;
Integer	 lic_adl_d_count_pos;
Integer	 lic_adl_count_d;
Integer	 lic_adl_dl_count_pos;
Integer	 lic_adl_count_dl;
Real	 _src_vehx_adl_count;
Integer	 voter_adl_v_count_pos;
Integer	 iv_src_voter_adl_count;
Integer	 vote_adl_vo_lseen_pos;
String	 vote_adl_lseen_vo;
Integer	 _vote_adl_lseen_vo;
Integer _src_vote_adl_lseen;
Integer	 iv_mos_src_voter_adl_lseen;
Real	 final_score_0;
Real	 final_score_1;
Real	 final_score_2;
Real	 final_score_3;
Real	 final_score_4;
Real	 final_score_5;
Real	 final_score_6;
Real	 final_score_7;
Real	 final_score_8;
Real	 final_score_9;
Real	 final_score_10;
Real	 final_score_11;
Real	 final_score_12;
Real	 final_score_13;
Real	 final_score_14;
Real	 final_score_15;
Real	 final_score_16;
Real	 final_score_17;
Real	 final_score_18;
Real	 final_score_19;
Real	 final_score_20;
Real	 final_score_21;
Real	 final_score_22;
Real	 final_score_23;
Real	 final_score_24;
Real	 final_score_25;
Real	 final_score_26;
Real	 final_score_27;
Real	 final_score_28;
Real	 final_score_29;
Real	 final_score_30;
Real	 final_score_31;
Real	 final_score_32;
Real	 final_score_33;
Real	 final_score_34;
Real	 final_score_35;
Real	 final_score_36;
Real	 final_score_37;
Real	 final_score_38;
Real	 final_score_39;
Real	 final_score_40;
Real	 final_score_41;
Real	 final_score_42;
Real	 final_score_43;
Real	 final_score_44;
Real	 final_score_45;
Real	 final_score_46;
Real	 final_score_47;
Real	 final_score_48;
Real	 final_score_49;
Real	 final_score_50;
Real	 final_score_51;
Real	 final_score_52;
Real	 final_score_53;
Real	 final_score_54;
Real	 final_score_55;
Real	 final_score_56;
Real	 final_score_57;
Real	 final_score_58;
Real	 final_score_59;
Real	 final_score_60;
Real	 final_score_61;
Real	 final_score_62;
Real	 final_score_63;
Real	 final_score_64;
Real	 final_score_65;
Real	 final_score_66;
Real	 final_score_67;
Real	 final_score_68;
Real	 final_score_69;
Real	 final_score_70;
Real	 final_score_71;
Real	 final_score_72;
Real	 final_score_73;
Real	 final_score_74;
Real	 final_score_75;
Real	 final_score_76;
Real	 final_score_77;
Real	 final_score_78;
Real	 final_score_79;
Real	 final_score_80;
Real	 final_score_81;
Real	 final_score_82;
Real	 final_score_83;
Real	 final_score_84;
Real	 final_score_85;
Real	 final_score_86;
Real	 final_score_87;
Real	 final_score_88;
Real	 final_score_89;
Real	 final_score_90;
Real	 final_score_91;
Real	 final_score_92;
Real	 final_score_93;
Real	 final_score_94;
Real	 final_score_95;
Real	 final_score_96;
Real	 final_score_97;
Real	 final_score_98;
Real	 final_score_99;
Real	 final_score_100;
Real	 final_score_101;
Real	 final_score_102;
Real	 final_score_103;
Real	 final_score_104;
Real	 final_score_105;
Real	 final_score_106;
Real	 final_score_107;
Real	 final_score_108;
Real	 final_score_109;
Real	 final_score_110;
Real	 final_score_111;
Real	 final_score_112;
Real	 final_score_113;
Real	 final_score_114;
Real	 final_score_115;
Real	 final_score_116;
Real	 final_score_117;
Real	 final_score_118;
Real	 final_score_119;
Real	 final_score_120;
Real	 final_score_121;
Real	 final_score_122;
Real	 final_score_123;
Real	 final_score_124;
Real	 final_score_125;
Real	 final_score_126;
Real	 final_score_127;
Real	 final_score_128;
Real	 final_score_129;
Real	 final_score_130;
Real	 final_score_131;
Real	 final_score_132;
Real	 final_score_133;
Real	 final_score_134;
Real	 final_score_135;
Real	 final_score_136;
Real	 final_score_137;
Real	 final_score_138;
Real	 final_score_139;
Real	 final_score_140;
Real	 final_score_141;
Real	 final_score_142;
Real	 final_score_143;
Real	 final_score_144;
Real	 final_score_145;
Real	 final_score_146;
Real	 final_score_147;
Real	 final_score_148;
Real	 final_score_149;
Real	 final_score_150;
Real	 final_score_151;
Real	 final_score_152;
Real	 final_score_153;
Real	 final_score_154;
Real	 final_score_155;
Real	 final_score_156;
Real	 final_score_157;
Real	 final_score_158;
Real	 final_score_159;
Real	 final_score_160;
Real	 final_score_161;
Real	 final_score_162;
Real	 final_score_163;
Real	 final_score_164;
Real	 final_score_165;
Real	 final_score_166;
Real	 final_score_167;
Real	 final_score_168;
Real	 final_score_169;
Real	 final_score_170;
Real	 final_score_171;
Real	 final_score_172;
Real	 final_score_173;
Real	 final_score_174;
Real	 final_score_175;
Real	 final_score_176;
Real	 final_score_177;
Real	 final_score_178;
Real	 final_score_179;
Real	 final_score_180;
Real	 final_score_181;
Real	 final_score_182;
Real	 final_score_183;
Real	 final_score_184;
Real	 final_score_185;
Real	 final_score_186;
Real	 final_score_187;
Real	 final_score_188;
Real	 final_score_189;
Real	 final_score_190;
Real	 final_score_191;
Real	 final_score_192;
Real	 final_score_193;
Real	 final_score_194;
Real	 final_score_195;
Real	 final_score_196;
Real	 final_score_197;
Real	 final_score_198;
Real	 final_score_199;
Real	 final_score_200;
Real	 final_score_201;
Real	 final_score_202;
Real	 final_score_203;
Real	 final_score_204;
Real	 final_score_205;
Real	 final_score_206;
Real	 final_score_207;
Real	 final_score_208;
Real	 final_score_209;
Real	 final_score_210;
Real	 final_score_211;
Real	 final_score_212;
Real	 final_score_213;
Real	 final_score_214;
Real	 final_score_215;
Real	 final_score_216;
Real	 final_score_217;
Real	 final_score_218;
Real	 final_score_219;
Real	 final_score_220;
Real	 final_score_221;
Real	 final_score_222;
Real	 final_score_223;
Real	 final_score_224;
Real	 final_score_225;
Real	 final_score_226;
Real	 final_score_227;
Real	 final_score_228;
Real	 final_score_229;
Real	 final_score_230;
Real	 final_score_231;
Real	 final_score_232;
Real	 final_score_233;
Real	 final_score_234;
Real	 final_score_235;
Real	 final_score_236;
Real	 final_score_237;
Real	 final_score_238;
Real	 final_score_239;
Real	 final_score_240;
Real	 final_score_241;
Real	 final_score_242;
Real	 final_score_243;
Real	 final_score_244;
Real	 final_score_245;
Real	 final_score_246;
Real	 final_score_247;
Real	 final_score_248;
Real	 final_score_249;
Real	 final_score_250;
Real	 final_score_251;
Real	 final_score_252;
Real	 final_score_253;
Real	 final_score_254;
Real	 final_score_255;
Real	 final_score_256;
Real	 final_score_257;
Real	 final_score_258;
Real	 final_score_259;
Real	 final_score_260;
Real	 final_score_261;
Real	 final_score_262;
Real	 final_score_263;
Real	 final_score_264;
Real	 final_score_265;
Real	 final_score_266;
Real	 final_score_267;
Real	 final_score_268;
Real	 final_score_269;
Real	 final_score_270;
Real	 final_score_271;
Real	 final_score_272;
Real	 final_score_273;
Real	 final_score_274;
Real	 final_score_275;
Real	 final_score_276;
Real	 final_score_277;
Real	 final_score_278;
Real	 final_score_279;
Real	 final_score_280;
Real	 final_score_281;
Real	 final_score_282;
Real	 final_score_283;
Real	 final_score_284;
Real	 final_score_285;
Real	 final_score_286;
Real	 final_score_287;
Real	 final_score_288;
Real	 final_score_289;
Real	 final_score_290;
Real	 final_score_291;
Real	 final_score_292;
Real	 final_score_293;
Real	 final_score_294;
Real	 final_score_295;
Real	 final_score_296;
Real	 final_score_297;
Real	 final_score_298;
Real	 final_score_299;
Real	 final_score_300;
Real	 final_score_301;
Real	 final_score_302;
Real	 final_score_303;
Real	 final_score_304;
Real	 final_score_305;
Real	 final_score_306;
Real	 final_score_307;
Real	 final_score_308;
Real	 final_score_309;
Real	 final_score_310;
Real	 final_score_311;
Real	 final_score_312;
Real	 final_score_313;
Real	 final_score_314;
Real	 final_score_315;
Real	 final_score_316;
Real	 final_score_317;
Real	 final_score_318;
Real	 final_score_319;
Real	 final_score_320;
Real	 final_score_321;
Real	 final_score_322;
Real	 final_score_323;
Real	 final_score_324;
Real	 final_score_325;
Real	 final_score_326;
Real	 final_score_327;
Real	 final_score_328;
Real	 final_score_329;
Real	 final_score_330;
Real	 final_score_331;
Real	 final_score_332;
Real	 final_score_333;
Real	 final_score_334;
Real	 final_score_335;
Real	 final_score_336;
Real	 final_score_337;
Real	 final_score_338;
Real	 final_score_339;
Real	 final_score_340;
Real	 final_score_341;
Real	 final_score_342;
Real	 final_score_343;
Real	 final_score_344;
Real	 final_score_345;
Real	 final_score_346;
Real	 final_score_347;
Real	 final_score_348;
Real	 final_score_349;
Real	 final_score_350;
Real	 final_score_351;
Real	 final_score_352;
Real	 final_score_353;
Real	 final_score_354;
Real	 final_score_355;
Real	 final_score_356;
Real	 final_score_357;
Real	 final_score_358;
Real	 final_score_359;
Real	 final_score_360;
Real	 final_score_361;
Real	 final_score_362;
Real	 final_score_363;
Real	 final_score_364;
Real	 final_score_365;
Real	 final_score_366;
Real	 final_score_367;
Real	 final_score_368;
Real	 final_score_369;
Real	 final_score_370;
Real	 final_score_371;
Real	 final_score_372;
Real	 final_score_373;
Real	 final_score_374;
Real	 final_score_375;
Real	 final_score_376;
Real	 final_score_377;
Real	 final_score_378;
Real	 final_score_379;
Real	 final_score_380;
Real	 final_score_381;
Real	 final_score_382;
Real	 final_score_383;
Real	 final_score_384;
Real	 final_score_385;
Real	 final_score_386;
Real	 final_score_387;
Real	 final_score_388;
Real	 final_score_389;
Real	 final_score_390;
Real	 final_score_391;
Real	 final_score_392;
Real	 final_score_393;
Real	 final_score_394;
Real	 final_score_395;
Real	 final_score;
Integer	 base;
Integer	 pts;
Real lgt;
Integer	 fp1609_1_0_nooverrides;
Boolean	 or_decsssn;
Boolean	 or_ssnpriordob;
Boolean	 or_prisonaddr;
Boolean	 or_prisonphone;
Boolean	 or_hraddr;
Boolean	 or_hrphone;
Boolean	 or_invalidssn;
Boolean	 or_invalidaddr;
Boolean	 or_invalidphone;
Integer	 fp1609_1_0_score;
Integer	 fp1609_1_0;
String   college_code;
String   college_major;
Boolean	 _ver_src_ds;
Boolean	 _ver_src_de;
Boolean	 _ver_src_eq;
Boolean	 _ver_src_en;
Boolean	 _ver_src_tn;
Boolean	 _ver_src_tu;
Real	 _credit_source_cnt;
Real	 _ver_src_cnt;
Boolean	 _bureauonly;
Boolean	 _derog;
Boolean	 _deceased;
Boolean	 _ssnpriortodob;
Boolean	 _inputmiskeys;
Boolean	 _multiplessns;
Integer	 _hh_strikes;
Integer hh_members_ct;
Integer hh_payday_loan_users;
Integer rel_felony_count;
Integer	 stolenid;
Integer	 manipulatedid;
Integer	 manipulatedidpt2;
Integer	 syntheticid;
Integer	 suspiciousactivity;
Integer	 vulnerablevictim;
Integer	 friendlyfraud;
Integer	 stolenc_fp1609_1_0;
Integer	 manip2c_fp1609_1_0;
Integer	 synthc_fp1609_1_0;
Integer	 suspactc_fp1609_1_0;
Integer	 vulnvicc_fp1609_1_0;
Integer	 friendlyc_fp1609_1_0;
Integer	 custstolidindex;
Integer	 custmanipidindex;
Integer	 custsynthidindex;
Integer	 custsuspactindex;
Integer	 custvulnvicindex;
Integer	 custfriendfrdindex;

	

			models.layouts.layout_fp1109;
			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
    layout_debug doModel( clam le, easi.Key_Easi_Census rt ) := TRANSFORM
  #else
    models.layouts.layout_fp1109 doModel( clam le, easi.Key_Easi_Census rt ) := TRANSFORM
		
  #end	

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	truedid         := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range   := le.shell_input.sec_range;
	out_z5          := le.shell_input.z5;
	out_addr_type   := le.shell_input.addr_type;
	out_addr_status                  := le.shell_input.addr_status;
	in_dob          := le.shell_input.dob;
	nas_summary     := le.iid.nas_summary;
	nap_summary     := le.iid.nap_summary;
	nap_type        := le.iid.nap_type;
	rc_ssndod       := le.ssn_verification.validation.deceasedDate;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_hriskaddrflag                 := le.iid.hriskaddrflag;
	rc_decsflag     := le.iid.decsflag;
	rc_ssndobflag   := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnvalflag   := le.iid.socsvalflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_dwelltype    := le.iid.dwelltype;
	rc_addrcount    := le.iid.addrcount;
	rc_phoneaddrcount                := le.iid.phoneaddrcount;
	rc_phoneaddr_addrcount           := le.iid.phoneaddr_addrcount;
	rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
	rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_hrisksic     := le.iid.hrisksic;
	rc_hrisksicphone                 := le.iid.hrisksicphone;
	rc_disthphoneaddr                := le.iid.disthphoneaddr;
	rc_phonetype    := le.iid.phonetype;
	rc_ziptypeflag                   := le.iid.ziptypeflag;
	combo_dobcount                   := le.iid.combo_dobcount;
	hdr_source_profile               := le.source_profile;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	voter_avail                      := le.available_sources.voter;
	bus_addr_match_count             := le.business_header_address_summary.bus_addr_match_cnt;
	bus_phone_match                  := le.business_header_address_summary.bus_phone_match;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	source_count                     := le.name_verification.source_count;
	fname_eda_sourced_type           := le.name_verification.fname_eda_sourced_type;
	lname_eda_sourced_type           := le.name_verification.lname_eda_sourced_type;
	util_adl_type_list               := le.utility.utili_adl_type;
	util_adl_count                   := le.utility.utili_adl_count;
	util_add_input_type_list         := le.utility.utili_addr1_type;
	util_add_curr_type_list          := le.utility.utili_addr2_type;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_lres                   := le.lres;
	add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind;
	add_input_source_count           := le.address_verification.input_address_information.source_count;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_mortgage_date          := le.address_verification.input_address_information.mortgage_date;
	add_input_mortgage_type          := le.address_verification.input_address_information.mortgage_type;
	add_input_nhood_bus_ct           := le.addr_risk_summary.N_Business_Count;
	add_input_nhood_sfd_ct           := le.addr_risk_summary.N_SFD_Count;
	add_input_nhood_mfd_ct           := le.addr_risk_summary.N_MFD_Count;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_mortgage_date           := le.address_verification.address_history_1.mortgage_date;
	add_curr_mortgage_type           := le.address_verification.address_history_1.mortgage_type;
	add_curr_nhood_bus_ct            := le.addr_risk_summary2.N_Business_Count;
	add_curr_nhood_sfd_ct            := le.addr_risk_summary2.N_SFD_Count;
	add_curr_nhood_mfd_ct            := le.addr_risk_summary2.N_MFD_Count;
	add_curr_pop                     := le.addrPop2;
	add_prev_lres                    := le.lres3;
	add_prev_pop                     := le.addrPop3;
	max_lres                         := le.other_address_info.max_lres;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	addrs_prison_history             := le.other_address_info.isprison;
	telcordia_type                   := le.phone_verification.telcordia_type;
	phone_ver_experian               := le.Experian_Phone_Verification;
	header_first_seen                := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	adls_per_ssn                     := le.SSN_Verification.adlPerSSN_count;
	addrs_per_ssn                    := if(isFCRA, 0, le.velocity_counters.addrs_per_ssn );
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	ssns_per_addr_curr               := le.velocity_counters.ssns_per_addr_current;
	phones_per_addr_curr             := le.velocity_counters.phones_per_addr_current;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
	lnames_per_adl_c6                := if(isFCRA, 0, le.velocity_counters.lnames_per_adl180);
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	phones_per_addr_c6               := if(isFCRA, 0, le.velocity_counters.phones_per_addr_created_6months );
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	inq_count                        := le.acc_logs.inquiries.counttotal;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count24                      := le.acc_logs.inquiries.count24;
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
	inq_communications_count24       := le.acc_logs.communications.count24;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count_week    := if(isFCRA, 0, le.acc_logs.highriskcredit.countweek);
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_other_count                  := le.acc_logs.other.counttotal;
	inq_other_count12                := le.acc_logs.other.count12;
	inq_other_count24                := le.acc_logs.other.count24;
	inq_prepaidcards_count           := le.acc_logs.prepaidcards.counttotal;
	inq_prepaidcards_count01         := le.acc_logs.prepaidcards.count01;
	inq_prepaidcards_count03         := le.acc_logs.prepaidcards.count03;
	inq_prepaidcards_count06         := le.acc_logs.prepaidcards.count06;
	inq_prepaidcards_count12         := le.acc_logs.prepaidcards.count12;
	inq_prepaidcards_count24         := le.acc_logs.prepaidcards.count24;
	inq_retail_count                 := le.acc_logs.retail.counttotal;
	inq_retailpayments_count12       := le.acc_logs.retailpayments.count12;
	inq_retailpayments_count24       := le.acc_logs.retailpayments.count24;
	inq_lnamesperadl                 := if(isFCRA, 0, le.acc_logs.inquirylnamesperadl);
	inq_fnamesperadl                 := le.acc_logs.inquiryfnamesperadl;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	inq_peraddr                      := if(isFCRA, 0, le.acc_logs.inquiryPerAddr );
	inq_lnamesperaddr                := if(isFCRA, 0, le.acc_logs.inquiryLNamesPerAddr );
	inq_ssnsperaddr                  := if(isFCRA, 0, le.acc_logs.inquirySSNsPerAddr );
	inq_perphone                     := if(isFCRA, 0, le.acc_logs.inquiryPerPhone );
	inq_banko_am_first_seen          := le.acc_logs.am_first_seen_date;
	inq_banko_am_last_seen           := le.acc_logs.am_last_seen_date;
	inq_banko_cm_first_seen          := le.acc_logs.cm_first_seen_date;
	inq_banko_cm_last_seen           := le.acc_logs.cm_last_seen_date;
	inq_banko_om_first_seen          := le.acc_logs.om_first_seen_date;
	inq_banko_om_last_seen           := le.acc_logs.om_last_seen_date;
	pb_number_of_sources             := le.ibehavior.number_of_sources;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	pb_offline_dollars               := le.ibehavior.offline_dollars;
	pb_online_dollars                := le.ibehavior.online_dollars;
	pb_retail_dollars                := le.ibehavior.retail_dollars;
	br_company_title                 := le.employment.company_title;
	br_first_seen                    := le.employment.first_seen_date;
	br_dead_business_count           := le.employment.dead_business_ct;
	br_active_phone_count            := le.employment.business_active_phone_ct;
	br_source_count                  := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count                    := le.impulse.count;
	stl_inq_count24                  := le.impulse.count24;
	email_count                      := le.email_summary.email_ct;
	email_domain_isp_count           := le.email_summary.email_domain_isp_ct;
	ver_email_sources                := le.email_summary.reverse_email.ver_sources;
	ver_email_sources_first_seen     := le.email_summary.reverse_email.ver_sources_first_seen_date;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_arrests    := le.bjl.arrests_count;
	attr_arrests30                   := le.bjl.arrests_count30;
	attr_arrests90                   := le.bjl.arrests_count90;
	attr_arrests180                  := le.bjl.arrests_count180;
	attr_arrests12                   := le.bjl.arrests_count12;
	attr_arrests24                   := le.bjl.arrests_count24;
	attr_arrests36                   := le.bjl.arrests_count36;
	attr_arrests60                   := le.bjl.arrests_count60;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
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
	vf_hi_risk_ct   := le.virtual_fraud.hi_risk_ct;
	vf_lexid_phone_lo_risk_ct        := le.virtual_fraud.lexid_phone_lo_risk_ct;
	vf_altlexid_phone_hi_risk_ct     := le.virtual_fraud.altlexid_phone_hi_risk_ct;
	vf_lexid_addr_hi_risk_ct         := le.virtual_fraud.lexid_addr_hi_risk_ct;
	vf_lexid_ssn_hi_risk_ct          := le.virtual_fraud.lexid_ssn_hi_risk_ct;
	fp_idverrisktype                 := le.fdattributesv2.idverrisklevel;
	fp_idveraddressnotcurrent        := le.fdattributesv2.idveraddressnotcurrent;
	fp_sourcerisktype                := le.fdattributesv2.sourcerisklevel;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_srchunvrfdssncount            := le.fdattributesv2.searchunverifiedssncountyear;
	fp_srchunvrfdphonecount          := le.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcount            := le.fdattributesv2.searchfraudsearchcount;
	fp_srchfraudsrchcountmo          := le.fdattributesv2.searchfraudsearchcountmonth;
	fp_srchfraudsrchcountwk          := le.fdattributesv2.searchfraudsearchcountweek;
	fp_srchcomponentrisktype         := le.fdattributesv2.searchcomponentrisklevel;
	fp_srchssnsrchcountmo            := le.fdattributesv2.searchssnsearchcountmonth;
	fp_srchaddrsrchcount             := le.fdattributesv2.searchaddrsearchcount;
	fp_srchaddrsrchcountmo           := le.fdattributesv2.searchaddrsearchcountmonth;
	fp_srchaddrsrchcountwk           := le.fdattributesv2.searchaddrsearchcountweek;
	fp_srchphonesrchcountmo          := le.fdattributesv2.searchphonesearchcountmonth;
	fp_srchphonesrchcountwk          := le.fdattributesv2.searchphonesearchcountweek;
	fp_prevaddrlenofres              := le.fdattributesv2.prevaddrlenofres;
	fp_prevaddroccupantowned         := le.fdattributesv2.prevaddroccupantowned;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_dismissed_recent_count        := le.bjl.bk_dismissed_recent_count;
	bk_dismissed_historical_count    := le.bjl.bk_dismissed_historical_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_recent_released_count      := le.bjl.liens_recent_released_count;
	liens_historical_released_count  := le.bjl.liens_historical_released_count;
	liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
	liens_unrel_cj_first_seen        := le.liens.liens_unreleased_civil_judgment.earliest_filing_date;
	liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	liens_unrel_cj_total_amount      := le.liens.liens_unreleased_civil_judgment.total_amount;
	liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
	liens_rel_cj_first_seen          := le.liens.liens_released_civil_judgment.earliest_filing_date;
	liens_rel_cj_last_seen           := le.liens.liens_released_civil_judgment.most_recent_filing_date;
	liens_unrel_ft_ct                := le.liens.liens_unreleased_federal_tax.count;
	liens_unrel_ft_first_seen        := le.liens.liens_unreleased_federal_tax.earliest_filing_date;
	liens_unrel_ft_last_seen         := le.liens.liens_unreleased_federal_tax.most_recent_filing_date;
	liens_rel_ft_ct                  := le.liens.liens_released_federal_tax.count;
	liens_rel_ft_first_seen          := le.liens.liens_released_federal_tax.earliest_filing_date;
	liens_rel_ft_last_seen           := le.liens.liens_released_federal_tax.most_recent_filing_date;
	liens_unrel_fc_ct                := le.liens.liens_unreleased_foreclosure.count;
	liens_unrel_fc_first_seen        := le.liens.liens_unreleased_foreclosure.earliest_filing_date;
	liens_unrel_fc_last_seen         := le.liens.liens_unreleased_foreclosure.most_recent_filing_date;
	liens_rel_fc_ct                  := le.liens.liens_released_foreclosure.count;
	liens_rel_fc_first_seen          := le.liens.liens_released_foreclosure.earliest_filing_date;
	liens_rel_fc_last_seen           := le.liens.liens_released_foreclosure.most_recent_filing_date;
	liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
	liens_unrel_lt_first_seen        := le.liens.liens_unreleased_landlord_tenant.earliest_filing_date;
	liens_unrel_lt_last_seen         := le.liens.liens_unreleased_landlord_tenant.most_recent_filing_date;
	liens_rel_lt_ct                  := le.liens.liens_released_landlord_tenant.count;
	liens_rel_lt_first_seen          := le.liens.liens_released_landlord_tenant.earliest_filing_date;
	liens_rel_lt_last_seen           := le.liens.liens_released_landlord_tenant.most_recent_filing_date;
	liens_unrel_o_ct                 := le.liens.liens_unreleased_other_lj.count;
	liens_unrel_o_first_seen         := le.liens.liens_unreleased_other_lj.earliest_filing_date;
	liens_unrel_o_last_seen          := le.liens.liens_unreleased_other_lj.most_recent_filing_date;
	liens_rel_o_ct                   := le.liens.liens_released_other_lj.count;
	liens_rel_o_first_seen           := le.liens.liens_released_other_lj.earliest_filing_date;
	liens_rel_o_last_seen            := le.liens.liens_released_other_lj.most_recent_filing_date;
	liens_rel_o_total_amount         := le.liens.liens_released_other_lj.total_amount;
	liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
	liens_unrel_ot_first_seen        := le.liens.liens_unreleased_other_tax.earliest_filing_date;
	liens_unrel_ot_last_seen         := le.liens.liens_unreleased_other_tax.most_recent_filing_date;
	liens_rel_ot_ct                  := le.liens.liens_released_other_tax.count;
	liens_rel_ot_first_seen          := le.liens.liens_released_other_tax.earliest_filing_date;
	liens_rel_ot_last_seen           := le.liens.liens_released_other_tax.most_recent_filing_date;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	liens_unrel_sc_first_seen        := le.liens.liens_unreleased_small_claims.earliest_filing_date;
	liens_unrel_sc_last_seen         := le.liens.liens_unreleased_small_claims.most_recent_filing_date;
	liens_unrel_sc_total_amount      := le.liens.liens_unreleased_small_claims.total_amount;
	liens_rel_sc_ct                  := le.liens.liens_released_small_claims.count;
	liens_rel_sc_first_seen          := le.liens.liens_released_small_claims.earliest_filing_date;
	liens_rel_sc_last_seen           := le.liens.liens_released_small_claims.most_recent_filing_date;
	liens_unrel_st_ct                := le.liens.liens_unreleased_suits.count;
	liens_unrel_st_first_seen        := le.liens.liens_unreleased_suits.earliest_filing_date;
	liens_unrel_st_last_seen         := le.liens.liens_unreleased_suits.most_recent_filing_date;
	liens_unrel_st_total_amount      := le.liens.liens_unreleased_suits.total_amount;
	liens_rel_st_ct                  := le.liens.liens_released_suits.count;
	liens_rel_st_first_seen          := le.liens.liens_released_suits.earliest_filing_date;
	liens_rel_st_last_seen           := le.liens.liens_released_suits.most_recent_filing_date;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_count    := le.bjl.felony_count;
	felony_last_date                 := le.bjl.last_felony_date;
	foreclosure_last_date            := le.bjl.last_foreclosure_date;
	hh_members_ct   := le.hhid_summary.hh_members_ct;
	hh_payday_loan_users             := le.hhid_summary.hh_payday_loan_users;
	hh_members_w_derog               := le.hhid_summary.hh_members_w_derog;
	hh_criminals    := le.hhid_summary.hh_criminals;
	rel_felony_count                 := le.relatives.relative_felony_count;
	current_count   := le.vehicles.current_count;
	historical_count                 := le.vehicles.historical_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	acc_last_seen   := le.accident_data.acc.datelastaccident;
	college_date_first_seen          := (unsigned)le.student.date_first_seen;
	college_code    := le.student.college_code;
	college_major   := le.student.college_major;
	prof_license_flag                := le.professional_license.professional_license_flag;
	prof_license_ix_sanct_fs         := le.professional_license.sanctions_date_first_seen;
	prof_license_ix_sanct_ls         := le.professional_license.sanctions_date_last_seen;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age    := le.inferred_age;
	estimated_income                 := le.estimated_income;



	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */

import Std;

NULL := -999999999;

INTEGER contains_i( string haystack, string needle ) :=(INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

BOOLEAN indexw(string source, string target, string delim) := __common__(
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim));

sysdate := __common__( common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01')));

iv_add_apt := __common__( if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0'));

rv_p88_phn_dst_to_inp_add := __common__( if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr));

add_ec1_1 := __common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1]);

add_ec3 := __common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3]);

add_ec4 := __common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4]);

rv_f03_input_add_not_most_rec := __common__( if(not(truedid and add_input_pop), NULL, (Integer)rc_input_addr_not_most_recent));

rv_c19_add_prison_hist := __common__( if(not(truedid), NULL, (integer)addrs_prison_history));

rv_f01_inp_addr_address_score := __common__( if(not(add_input_pop and truedid), NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999)));

rv_d30_derog_count := __common__( if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999)));

rv_d32_criminal_count := __common__( if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999)));

rv_d32_criminal_x_felony := __common__( if(not(truedid), '', trim((String)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((String)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT)));

_criminal_last_date := __common__( common.sas_date((string)(criminal_last_date)));

_felony_last_date := __common__( common.sas_date((string)(felony_last_date)));

rv_d31_attr_bankruptcy_recency := __common__( map(
    not(truedid)             => NULL,
    (Boolean)attr_bankruptcy_count30  => 1,
    (Boolean)attr_bankruptcy_count90  => 3,
    (Boolean)attr_bankruptcy_count180 => 6,
    (Boolean)attr_bankruptcy_count12  => 12,
    (Boolean)attr_bankruptcy_count24  => 24,
    (Boolean)attr_bankruptcy_count36  => 36,
    (Boolean)attr_bankruptcy_count60  => 60,
    (Boolean)bankrupt                 => 99,
    filing_count > 0         => 99,
               0));

rv_d33_eviction_recency := __common__( map(
    not(truedid)              => '  ',
    (Boolean)attr_eviction_count90                      => '03',
    (Boolean)attr_eviction_count180                     => '06',
    (Boolean)attr_eviction_count12                      => '12',
    (boolean)attr_eviction_count24 and attr_eviction_count >= 2 => '24',
    (Boolean)attr_eviction_count24                      => '25',
    (boolean)attr_eviction_count36 and attr_eviction_count >= 2 => '36',
    (Boolean)attr_eviction_count36                      => '37',
    (boolean)attr_eviction_count60 and attr_eviction_count >= 2 => '60',
    (Boolean)attr_eviction_count60                      => '61',
    attr_eviction_count >= 2                   => '98',
    attr_eviction_count >= 1                   => '99',
                '00'));

rv_d33_eviction_count := __common__( if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999)));

rv_d34_unrel_lien60_count := __common__( if(not(truedid), NULL, min(if(attr_num_unrel_liens60 = NULL, -NULL, attr_num_unrel_liens60), 999)));

iv_d34_liens_unrel_x_rel := __common__( if(not(truedid), '   ', trim((String)min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((String)min(if(if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) = NULL, -NULL, if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count)))), 2), LEFT, RIGHT)));

bureau_adl_eq_fseen_pos_6 := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

bureau_adl_fseen_eq_6 := __common__( if(bureau_adl_eq_fseen_pos_6 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_6, ',')));

_bureau_adl_fseen_eq_6 := __common__( common.sas_date((string)(bureau_adl_fseen_eq_6)));

_src_bureau_adl_fseen_1 := __common__( min(if(_bureau_adl_fseen_eq_6 = NULL, -NULL, _bureau_adl_fseen_eq_6), 999999));

rv_c20_m_bureau_adl_fs := __common__( map(
    not(truedid)    => NULL,
    _src_bureau_adl_fseen_1 = 999999 => -1,
      min(if(if ((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12)))), 999)));

bureau_adl_eq_fseen_pos_5 := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

bureau_adl_fseen_eq_5 := __common__( if(bureau_adl_eq_fseen_pos_5 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_5, ',')));

_bureau_adl_fseen_eq_5 := __common__( common.sas_date((string)(bureau_adl_fseen_eq_5)));

bureau_adl_en_fseen_pos_5 := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E'));

bureau_adl_fseen_en_5 := __common__( if(bureau_adl_en_fseen_pos_5 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos_5, ',')));

_bureau_adl_fseen_en_5 := __common__( common.sas_date((string)(bureau_adl_fseen_en_5)));

bureau_adl_ts_fseen_pos_4 := __common__( Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E'));

bureau_adl_fseen_ts_4 := __common__( if(bureau_adl_ts_fseen_pos_4 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos_4, ',')));

_bureau_adl_fseen_ts_4 := __common__( common.sas_date((string)(bureau_adl_fseen_ts_4)));

bureau_adl_tu_fseen_pos_4 := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E'));

bureau_adl_fseen_tu_4 := __common__( if(bureau_adl_tu_fseen_pos_4 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos_4, ',')));

_bureau_adl_fseen_tu_4 := __common__( common.sas_date((string)(bureau_adl_fseen_tu_4)));

bureau_adl_tn_fseen_pos_4 := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E'));

bureau_adl_fseen_tn_4 := __common__( if(bureau_adl_tn_fseen_pos_4 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos_4, ',')));

_bureau_adl_fseen_tn_4 := __common__( common.sas_date((string)(bureau_adl_fseen_tn_4)));

_src_bureau_adl_fseen_all_3 := __common__( min(if(_bureau_adl_fseen_tn_4 = NULL, -NULL, _bureau_adl_fseen_tn_4), if(_bureau_adl_fseen_ts_4 = NULL, -NULL, _bureau_adl_fseen_ts_4), if(_bureau_adl_fseen_tu_4 = NULL, -NULL, _bureau_adl_fseen_tu_4), if(_bureau_adl_fseen_en_5 = NULL, -NULL, _bureau_adl_fseen_en_5), if(_bureau_adl_fseen_eq_5 = NULL, -NULL, _bureau_adl_fseen_eq_5), 999999));

nf_m_bureau_adl_fs_all := __common__( map(
    not(truedid)        => NULL,
    _src_bureau_adl_fseen_all_3 = 999999 => -1,
          if ((sysdate - _src_bureau_adl_fseen_all_3) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all_3) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all_3) / (365.25 / 12)))));

bureau_adl_eq_fseen_pos_4 := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

bureau_adl_fseen_eq_4 := __common__( if(bureau_adl_eq_fseen_pos_4 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_4, ',')));

_bureau_adl_fseen_eq_4 := __common__( common.sas_date((string)(bureau_adl_fseen_eq_4)));

bureau_adl_en_fseen_pos_4 := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E'));

bureau_adl_fseen_en_4 := __common__( if(bureau_adl_en_fseen_pos_4 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos_4, ',')));

_bureau_adl_fseen_en_4 := __common__( common.sas_date((string)(bureau_adl_fseen_en_4)));

bureau_adl_ts_fseen_pos_3 := __common__( Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E'));

bureau_adl_fseen_ts_3 := __common__( if(bureau_adl_ts_fseen_pos_3 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos_3, ',')));

_bureau_adl_fseen_ts_3 := __common__( common.sas_date((string)(bureau_adl_fseen_ts_3)));

bureau_adl_tu_fseen_pos_3 := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E'));

bureau_adl_fseen_tu_3 := __common__( if(bureau_adl_tu_fseen_pos_3 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos_3, ',')));

_bureau_adl_fseen_tu_3 := __common__( common.sas_date((string)(bureau_adl_fseen_tu_3)));

bureau_adl_tn_fseen_pos_3 := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E'));

bureau_adl_fseen_tn_3 := __common__( if(bureau_adl_tn_fseen_pos_3 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos_3, ',')));

_bureau_adl_fseen_tn_3 := __common__( common.sas_date((string)(bureau_adl_fseen_tn_3)));

_src_bureau_adl_fseen_notu := __common__( min(if(_bureau_adl_fseen_en_4 = NULL, -NULL, _bureau_adl_fseen_en_4), if(_bureau_adl_fseen_eq_4 = NULL, -NULL, _bureau_adl_fseen_eq_4), 999999));

nf_m_bureau_adl_fs_notu := __common__( map(
    not(truedid)       => NULL,
    _src_bureau_adl_fseen_notu = 999999 => -1,
         if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)))));

_header_first_seen := __common__( common.sas_date((string)(header_first_seen)));

rv_c10_m_hdr_fs := __common__( map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => -1,
                min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999)));

rv_c12_source_profile := __common__( if(not(truedid), NULL, hdr_source_profile));

_in_dob := __common__( common.sas_date((string)(in_dob)));

yr_in_dob := __common__( if(_in_dob = NULL, -1, (sysdate - _in_dob) / 365.25));

yr_in_dob_int := __common__( if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob)));

rv_c13_max_lres := __common__( if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999)));

rv_c14_addrs_5yr := __common__( map(
    not(truedid)     => NULL,
    not add_curr_pop => -1,
                        min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999)));

rv_c14_addrs_10yr := __common__( map(
	    not(truedid)     => NULL,
	    (integer)add_curr_pop = 0 => -1,
	                        min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999)));

rv_c14_addrs_per_adl_c6 := __common__( if(not(truedid), NULL, min(if(addrs_per_adl_c6 = NULL, -NULL, addrs_per_adl_c6), 999)));

rv_c14_addrs_15yr := __common__( if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999)));

rv_a43_rec_vehx_level := __common__( map(
    not(truedid)                  => '  ',
    attr_num_aircraft > 0 and watercraft_count > 0 => 'AW',
    attr_num_aircraft > 0         => 'AO',
    watercraft_count > 0          => trim('W', LEFT, RIGHT) + trim((String)min(if(watercraft_count = NULL, -NULL, watercraft_count), 3), LEFT, RIGHT),
                    'XX'));

rv_email_count := __common__( if(not(truedid), NULL, min(if(email_count = NULL, -NULL, email_count), 999)));

rv_email_domain_isp_count := __common__( if(not(truedid), NULL, min(if(email_domain_ISP_count = NULL, -NULL, email_domain_ISP_count), 999)));

rv_e57_prof_license_br_flag := if(not(truedid), NULL, (integer)(((integer)prof_license_flag + (integer)br_source_count) > 0));

rv_i61_inq_collection_recency := __common__( map(
    not(truedid)           => NULL,
    (Boolean)inq_collection_count01 => 1,
    (Boolean)inq_collection_count03 => 3,
    (Boolean)inq_collection_count06 => 6,
    (Boolean)inq_collection_count12 => 12,
    (Boolean)inq_collection_count24 => 24,
    (Boolean)inq_collection_count   => 99,
             0));

rv_i60_inq_banking_count12 := __common__( if(not(truedid), NULL, min(if(inq_banking_count12 = NULL, -NULL, inq_banking_count12), 999)));

rv_i60_inq_hiriskcred_count12 := __common__( if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999)));

rv_i60_inq_prepaidcards_recency := __common__( map(
    not(truedid)             => NULL,
    (Boolean)inq_PrepaidCards_count01 => 1,
    (Boolean)inq_PrepaidCards_count03 => 3,
    (Boolean)inq_PrepaidCards_count06 => 6,
    (Boolean)inq_PrepaidCards_count12 => 12,
    (Boolean)inq_PrepaidCards_count24 => 24,
    (Boolean)inq_PrepaidCards_count   => 99,
               0));

rv_i60_inq_retpymt_count12 := __common__( if(not(truedid), NULL, min(if(inq_retailpayments_count12 = NULL, -NULL, inq_retailpayments_count12), 999)));

rv_l79_adls_per_addr_curr := __common__( if(not(addrpop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999)));

rv_l79_adls_per_apt_addr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '0' => -1,
       min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999)));

rv_l79_adls_per_addr_c6 := __common__( if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999)));

rv_l79_adls_per_sfd_addr_c6 := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '1' => -1,
       min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999)));

rv_c13_attr_addrs_recency := __common__( map(
    not(truedid)      => NULL,
    (Boolean)attr_addrs_last30 => 1,
    (Boolean)attr_addrs_last90 => 3,
    (Boolean)attr_addrs_last12 => 12,
    (Boolean)attr_addrs_last24 => 24,
    (Boolean)attr_addrs_last36 => 36,
    (Boolean)addrs_5yr         => 60,
    (Boolean)addrs_10yr        => 120,
    (Boolean)addrs_15yr        => 180,
    (Integer)addrs_per_adl > 0 => 999,
        0));

rv_truedid := __common__( truedid);

iv_addrpop := __common__( addrpop);

iv_fnamepop := __common__( fnamepop);

iv_lnamepop := __common__( lnamepop);

iv_hphnpop := __common__( hphnpop);

iv_ssnlength := __common__( ssnlength);

iv_dobpop := __common__( dobpop);

ssnpop := __common__( ssnlength = '9');

iv_rv5_deceased := __common__( rc_decsflag = '1' or rc_ssndod != 0 or (Integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0 or (Integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',') > 0);

iv_full_name_non_phn_src_ct := __common__( if(not(truedid and fnamepop and lnamepop), NULL, min(if(source_count = NULL, -NULL, source_count), 999)));

iv_full_name_ver_sources := __common__( map(
    not((hphnpop or addrpop) and lnamepop and fnamepop)          => '             ',
    source_count > 0 and not(fname_eda_sourced_type = '') and not(lname_eda_sourced_type = '') => 'PHN & NONPHN ',
    source_count > 0                            => 'NONPHN ONLY  ',
    not(fname_eda_sourced_type = '') and not(lname_eda_sourced_type = '')     => 'PHN ONLY     ',
                 'NAME NOT VERD'));

iv_addr_non_phn_src_ct := __common__( if(not(truedid and add_input_pop), NULL, min(if(rc_addrcount = NULL, -NULL, rc_addrcount), 999)));

iv_c22_addr_ver_sources := __common__( map(
    not(truedid and add_input_pop)           => '             ',
    rc_addrcount > 0 and (rc_phoneaddrcount > 0 or rc_phoneaddr_addrcount > 0) => 'PHN & NONPHN ',
    rc_addrcount > 0                         => 'NONPHN ONLY  ',
    rc_phoneaddrcount > 0 or rc_phoneaddr_addrcount > 0       => 'PHN ONLY     ',
              'ADDR NOT VERD'));

iv_dob_src_ct := __common__( if(not(truedid and dobpop), NULL, min(if(combo_dobcount = NULL, -NULL, combo_dobcount), 999)));

_nap_ver := __common__( (nap_summary in [6, 10, 11, 12]));

_inf_ver := __common__( (infutor_nap in [6, 10, 11, 12]));

rv_c13_inp_addr_lres := __common__( if(not(add_input_pop and truedid), NULL, min(if(add_input_lres = NULL, -NULL, add_input_lres), 999)));

rv_c12_inp_addr_source_count := __common__( if(not(add_input_pop and truedid), NULL, min(if(add_input_source_count = NULL, -NULL, add_input_source_count), 999)));

mortgage_type_1 := __common__( add_input_mortgage_type);

mortgage_present_1 := __common__( not((add_input_mortgage_date in [0, NULL])));

mortgage_type := __common__( if(truedid and add_curr_pop, add_curr_mortgage_type, mortgage_type_1));

mortgage_present := __common__( if(truedid and add_curr_pop, not((add_curr_mortgage_date in [0, NULL])), mortgage_present_1));

iv_prv_addr_lres := __common__( if(not(truedid and add_prev_pop), NULL, min(if(add_prev_lres = NULL, -NULL, add_prev_lres), 999)));

iv_c14_addrs_per_adl := __common__( if(not(truedid), NULL, min(if(addrs_per_adl = NULL, -NULL, addrs_per_adl), 999)));

rv_i60_inq_other_count12 := __common__( if(not(truedid), NULL, min(if(inq_other_count12 = NULL, -NULL, inq_other_count12), 999)));

rv_i62_inq_num_names_per_adl := __common__( if(not(truedid), NULL, max(inq_fnamesperadl, inq_lnamesperadl)));

rv_i62_inq_phones_per_adl := __common__( if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999)));

br_first_seen_char := __common__( br_first_seen);

_br_first_seen := __common__( common.sas_date((string)(br_first_seen_char)));

iv_br_source_count := __common__( if(not(truedid), NULL, min(if(br_source_count = NULL, -NULL, br_source_count), 999)));

rv_e58_br_dead_bus_x_active_phn := __common__( if(not(truedid), '   ', trim((String)min(if(br_dead_business_count = NULL, -NULL, br_dead_business_count), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((String)min(if(br_active_phone_count = NULL, -NULL, br_active_phone_count), 3), LEFT, RIGHT)));


br_company_title1 := __common__( REGEXREPLACE(u'[^A-Za-z0-9]', br_company_title,  ' '));
br_company_title2 := __common__( REGEXREPLACE(u' *',           br_company_title1, ' '));

iv_d34_liens_unrel_lt_ct := __common__( if(not(truedid), NULL, min(if(liens_unrel_LT_ct = NULL, -NULL, liens_unrel_LT_ct), 999)));

major_medical := __common__( contains_i(StringLib.StringToUpperCase(college_major), 'A') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'E') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'L') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'Q') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'T') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'V') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '040') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '041') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '044') > 0);

major_science := __common__( contains_i(StringLib.StringToUpperCase(college_major), 'D') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'H') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'M') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'N') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '046') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '006') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '022') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '026') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '029') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '031') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '036') > 0);

major_liberal := __common__( contains_i(StringLib.StringToUpperCase(college_major), 'C') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'F') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'I') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'J') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'K') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'O') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'W') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'Y') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '007') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '013') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '015') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '027') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '032') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '033') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '035') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '037') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '038') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '039') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '042') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '043') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '003') > 0);

major_business := __common__( contains_i(StringLib.StringToUpperCase(college_major), 'B') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'G') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'P') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'R') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'S') > 0 or contains_i(StringLib.StringToUpperCase(college_major), 'Z') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '009') > 0 or contains_i(StringLib.StringToUpperCase(college_major), '045') > 0);

major_unknown := __common__( contains_i(StringLib.StringToUpperCase(college_major), 'U') > 0);

iv_college_major := __common__( map(
    not(truedid)                => '                ',
    major_medical               => 'MEDICAL         ',
    major_science               => 'SCIENCE         ',
    major_liberal               => 'LIBERAL ARTS    ',
    major_business              => 'BUSINESS        ',
    major_unknown               => 'UNCLASSIFIED    ',
    not(college_code = '')    => 'UNCLASSIFIED    ',
    not(((String)college_date_first_seen in [ '0', ' '])) => 'NO COLLEGE FOUND',
                  'NO AMS FOUND'));

sum_dols := __common__(__common__( if(pb_offline_dollars='' and pb_online_dollars = '' and pb_retail_dollars='', NULL, sum(if((integer)pb_offline_dollars = NULL, 0, (integer)pb_offline_dollars), 
if((integer)pb_online_dollars = NULL, 0, (integer)pb_online_dollars), if((integer)pb_retail_dollars = NULL, 0, (integer)pb_retail_dollars)))));

pct_online_dols := __common__( if(sum_dols > 0, (real)pb_online_dollars / sum_dols, -1));

pct_offline_dols := __common__( if(sum_dols > 0, (real)pb_offline_dollars / sum_dols, -1));

pct_retail_dols := __common__( if(sum_dols > 0, (real)pb_retail_dollars / sum_dols, -1));

num_dob_match_level := __common__( (integer)input_dob_match_level);

nas_summary_ver := __common__( if(ssnlength > '0' and (nas_summary in [8, 9, 10, 11, 12]) or (nas_summary in [2, 4, 7]) and add_input_isbestmatch, 1, 0));

nap_summary_ver := __common__( if(hphnpop and (nap_summary in [9, 10, 11, 12]), 1, 0));

infutor_nap_ver := __common__( if(hphnpop and (infutor_nap in [9, 10, 11, 12]), 1, 0));

dob_ver := __common__( if(dobpop and num_dob_match_level >= 5, 1, 0));

sufficiently_verified := __common__( map(
    (boolean)(integer)nas_summary_ver and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver)          => 1,
    (boolean)(integer)nas_summary_ver and ((boolean)(integer)dob_ver or not(dobpop))      => 1,
    ((boolean)(integer)dob_ver or not(dobpop)) and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver) => 1,
                         0));

add_ec1 := __common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1]);

addr_validation_problem := __common__( if(add_ec1 = 'E' and not(rc_addrvalflag = 'N') or rc_hriskaddrflag = '4' or rc_addrcommflag = '2' or (add_input_advo_res_or_bus in ['B', 'D']) or not(out_z5 = '') and (rc_hriskaddrflag = '2' or rc_ziptypeflag = '2') or add_input_advo_vacancy = 'Y', 1, 0));

phn_validation_problem := __common__( if(rc_hphonetypeflag = 'A' or rc_hriskphoneflag = '2' or rc_hphonetypeflag = '2' or (telcordia_type in ['02', '56', '61']) or rc_phonevalflag = '0' or rc_hphonevalflag = '0' or rc_phonetype = '5' or rc_hriskphoneflag = '6' or rc_hphonetypeflag = '5' or rc_hphonevalflag = '3' or rc_addrcommflag = '1', 1, 0));

validation_problem := __common__( if(adls_per_ssn >= 5 or ssns_per_adl >= 4 or invalid_ssns_per_adl >= 1 or adls_per_addr_curr >= 8 or ssns_per_addr_curr >= 7 or rc_hrisksic = '2225' or rc_hrisksicphone = '2225' or (boolean)(integer)addr_validation_problem or (boolean)(integer)phn_validation_problem, 1, 0));

tot_liens := __common__( liens_historical_unreleased_ct +
    liens_recent_unreleased_count +
    liens_recent_released_count +
    liens_historical_released_count);

tot_liens_w_type := __common__( liens_unrel_LT_ct +
    liens_rel_LT_ct +
    liens_unrel_SC_ct +
    liens_rel_SC_ct +
    liens_unrel_CJ_ct +
    liens_rel_CJ_ct +
    liens_unrel_FT_ct +
    liens_rel_FT_ct +
    liens_unrel_OT_ct +
    liens_rel_OT_ct +
    liens_unrel_ST_ct +
    liens_rel_ST_ct +
    liens_unrel_FC_ct +
    liens_rel_FC_ct +
    liens_unrel_O_ct +
    liens_rel_O_ct);

has_derog := __common__( if(felony_count > 0 or criminal_count > 0 or stl_inq_count24 > 0 or attr_eviction_count > 0 or liens_unrel_CJ_ct > 0 or liens_rel_CJ_ct > 0 or liens_unrel_SC_ct > 0 or liens_rel_SC_ct > 0 or liens_unrel_FC_ct > 0 or liens_rel_FC_ct > 0 or liens_unrel_O_ct > 0 or liens_rel_O_ct > 0 or tot_liens - tot_liens_w_type > 0 or bk_dismissed_recent_count > 0 or bk_dismissed_historical_count > 0, 1, 0));

rv_4seg_riskview_5_0 := __common__( map(
    (Integer)truedid = 0          => '0 TRUEDID = 0     ',
    not((boolean)sufficiently_verified)                    => '1 VER/VAL PROBLEMS',
    (boolean)sufficiently_verified and (boolean)(integer)validation_problem => '1 VER/VAL PROBLEMS',
    (Boolean)has_derog            => '2 DEROG           ',
    add_input_naprop = 4 or property_owned_total > 0       => '3 OWNER           ',
                            '4 OTHER           '));

bureau_adl_eq_fseen_pos_3 := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

bureau_adl_en_fseen_pos_3 := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'));

bureau_adl_fseen_eq_3 := __common__( if(bureau_adl_eq_fseen_pos_3 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_3, ',')));

_bureau_adl_fseen_eq_3 := __common__( common.sas_date((string)(bureau_adl_fseen_eq_3)));

bureau_adl_fseen_en_3 := __common__( if(bureau_adl_en_fseen_pos_3 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos_3, ',')));

_bureau_adl_fseen_en_3 := __common__( common.sas_date((string)(bureau_adl_fseen_en_3)));

_src_bureau_adl_fseen := __common__( min(if(_bureau_adl_fseen_eq_3 = NULL, -NULL, _bureau_adl_fseen_eq_3), if(_bureau_adl_fseen_eq_3 = NULL, -NULL, _bureau_adl_fseen_eq_3), 999999));

nf_bus_addr_match_count := __common__( if(not(addrpop), NULL, bus_addr_match_count));

nf_bus_phone_match := __common__( if(not(addrpop), NULL, bus_phone_match));

adl_util_i := __common__( if(contains_i(StringLib.StringToUpperCase(util_adl_type_list), '1') > 0 , 'I', ' '));

adl_util_c := __common__( if(contains_i(StringLib.StringToUpperCase(util_adl_type_list), '2') > 0 , 'C', ' '));

adl_util_m := __common__( if(contains_i(StringLib.StringToUpperCase(util_adl_type_list), 'Z') > 0 , 'M', ' '));

nf_util_adl_summary := __common__( if(not(truedid), '', '|' + (string)adl_util_i + (string)adl_util_c + (string)adl_util_m + '|'));

nf_util_adl_count := __common__( if(not(truedid), NULL, util_adl_count));

inp_util_i := __common__( if(contains_i(StringLib.StringToUpperCase(util_add_input_type_list), '1') > 0, 'I', ' '));

inp_util_c := __common__( if(contains_i(StringLib.StringToUpperCase(util_add_input_type_list), '2') > 0, 'C', ' '));

inp_util_m := __common__( if(contains_i(StringLib.StringToUpperCase(util_add_input_type_list), 'Z') > 0, 'M', ' '));

nf_util_add_input_summary := __common__( if(not(addrpop), '', '|' + (string)inp_util_i + (string)inp_util_c + (string)inp_util_m + '|'));

curr_util_i := __common__( if(contains_i(StringLib.StringToUpperCase(util_add_curr_type_list), '1') > 0, 'I', ' '));

curr_util_c := __common__( if(contains_i(StringLib.StringToUpperCase(util_add_curr_type_list), '2') > 0, 'C', ' '));

curr_util_m := __common__( if(contains_i(StringLib.StringToUpperCase(util_add_curr_type_list), 'Z') > 0, 'M', ' '));

nf_util_add_curr_summary := __common__( if(not(truedid) and add_curr_pop, '', '|' + (string)curr_util_i + (string)curr_util_c + (string)curr_util_m + '|'));

add_input_nhood_prop_sum_3 := __common__( if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))));

add_input_nhood_prop_sum_2 := __common__( if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))));

add_input_nhood_prop_sum_1 := __common__( if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))));

add_input_nhood_prop_sum := __common__( if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))));

add_curr_nhood_prop_sum_3 := __common__( if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))));

add_curr_nhood_prop_sum_2 := __common__( if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))));

add_curr_nhood_prop_sum_1 := __common__( if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))));

add_curr_nhood_prop_sum := __common__( if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))));

nf_phone_ver_experian := __common__( if(not(truedid), NULL, (Integer)trim(phone_ver_experian, LEFT)));

nf_addrs_per_ssn := __common__( if(not(ssnlength > '0'), NULL, min(if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn), 999)));

nf_phones_per_addr_curr := __common__( if(not(addrpop), NULL, min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999)));

nf_phones_per_apt_addr_curr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '0' => -1,
       min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999)));

nf_phones_per_sfd_addr_c6 := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '1' => -1,
       min(if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6), 999)));

nf_inq_count := __common__( if(not(truedid), NULL, min(if(inq_count = NULL, -NULL, inq_count), 999)));

nf_inq_count24 := __common__( if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999)));

nf_inq_banking_count := __common__( if(not(truedid), NULL, min(if(inq_Banking_count = NULL, -NULL, inq_Banking_count), 999)));

nf_inq_banking_count24 := __common__( if(not(truedid), NULL, min(if(inq_Banking_count24 = NULL, -NULL, inq_Banking_count24), 999)));

nf_inq_communications_count := __common__( if(not(truedid), NULL, min(if(inq_Communications_count = NULL, -NULL, inq_Communications_count), 999)));

nf_inq_communications_count24 := __common__( if(not(truedid), NULL, min(if(inq_Communications_count24 = NULL, -NULL, inq_Communications_count24), 999)));

nf_inq_highriskcredit_count := __common__( if(not(truedid), NULL, min(if(inq_HighRiskCredit_count = NULL, -NULL, inq_HighRiskCredit_count), 999)));

nf_inq_highriskcredit_count_week := __common__( if(not(truedid), NULL, min(if(inq_HighRiskCredit_count_week = NULL, -NULL, inq_HighRiskCredit_count_week), 999)));

nf_inq_other_count := __common__( if(not(truedid), NULL, min(if(inq_Other_count = NULL, -NULL, inq_Other_count), 999)));

nf_inq_other_count24 := __common__( if(not(truedid), NULL, min(if(inq_Other_count24 = NULL, -NULL, inq_Other_count24), 999)));

nf_inq_prepaidcards_count := __common__( if(not(truedid), NULL, min(if(inq_PrepaidCards_count = NULL, -NULL, inq_PrepaidCards_count), 999)));

nf_inq_prepaidcards_count24 := __common__( if(not(truedid), NULL, min(if(inq_PrepaidCards_count24 = NULL, -NULL, inq_PrepaidCards_count24), 999)));

nf_inq_retail_count := __common__( if(not(truedid), NULL, min(if(inq_Retail_count = NULL, -NULL, inq_Retail_count), 999)));

nf_inq_retailpayments_count24 := __common__( if(not(truedid), NULL, min(if(inq_RetailPayments_count24 = NULL, -NULL, inq_RetailPayments_count24), 999)));

nf_inq_per_addr := __common__( if(not(addrpop), NULL, min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999)));

nf_inq_per_apt_addr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '0' => -1,
       min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999)));

nf_inq_per_sfd_addr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '1' => -1,
       min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999)));

nf_inq_lnames_per_sfd_addr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '1' => -1,
       min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999)));

nf_inq_ssns_per_addr := __common__( if(not(addrpop), NULL, min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999)));

nf_inq_ssns_per_sfd_addr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '1' => -1,
       min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999)));

nf_inq_per_phone := __common__( if(not(hphnpop), NULL, min(if(inq_perphone = NULL, -NULL, inq_perphone), 999)));

_inq_banko_am_first_seen := __common__( common.sas_date((string)(Inq_banko_am_first_seen)));

nf_mos_inq_banko_am_fseen := __common__( map(
    not(truedid)   => NULL,
    _inq_banko_am_first_seen = NULL => -1,
                      min(if(if ((sysdate - _inq_banko_am_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_am_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_am_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_am_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_am_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_am_first_seen) / (365.25 / 12)))), 999)));

_inq_banko_am_last_seen := __common__( common.sas_date((string)(Inq_banko_am_last_seen)));

_inq_banko_cm_first_seen := __common__( common.sas_date((string)(Inq_banko_cm_first_seen)));

_inq_banko_cm_last_seen := __common__( common.sas_date((string)(Inq_banko_cm_last_seen)));

nf_mos_inq_banko_cm_lseen := __common__( map(
    not(truedid)                   => NULL,
    _inq_banko_cm_last_seen = NULL => -1,
                     min(if(if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)))), 999)));

_inq_banko_om_first_seen := __common__( common.sas_date((string)(Inq_banko_om_first_seen)));

_inq_banko_om_last_seen := __common__( common.sas_date((string)(Inq_banko_om_last_seen)));

nf_mos_inq_banko_om_lseen := __common__( map(
    not(truedid)                   => NULL,
    _inq_banko_om_last_seen = NULL => -1,
                     min(if(if ((sysdate - _inq_banko_om_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_om_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)))), 999)));

nf_email_src_aw := __common__( Models.Common.findw_cpp(ver_email_sources, 'AW' , ', ', 'E') > 0);

em_aw_pos_2 := __common__( Models.Common.findw_cpp(ver_email_sources, 'AW' , ', ', 'E'));

email_src_aw_fseen := __common__( if(em_aw_pos_2 = 0, '', Models.Common.getw(ver_email_sources_first_seen, em_aw_pos_2)));

_email_src_aw_fseen := __common__( common.sas_date((string)(email_src_aw_fseen)));

em_aw_pos_1 := __common__( Models.Common.findw_cpp(ver_email_sources, 'AW' , ', ', 'E'));

email_src_aw_lseen := __common__( if(em_aw_pos_1 = 0, '', Models.Common.getw(ver_email_sources_first_seen, em_aw_pos_1)));

_email_src_aw_lseen := __common__( common.sas_date((string)(email_src_aw_lseen)));

em_aw_pos := __common__( Models.Common.findw_cpp(ver_email_sources, 'AW' , ', ', 'E'));

nf_email_src_ib := __common__( Models.Common.findw_cpp(ver_email_sources, 'IB' , ', ', 'E') > 0);

em_ib_pos_2 := __common__( Models.Common.findw_cpp(ver_email_sources, 'IB' , ', ', 'E'));

email_src_ib_fseen := __common__( if(em_ib_pos_2 = 0, '', Models.Common.getw(ver_email_sources_first_seen, em_ib_pos_2)));

_email_src_ib_fseen := __common__( common.sas_date((string)(email_src_ib_fseen)));

em_ib_pos_1 := __common__( Models.Common.findw_cpp(ver_email_sources, 'IB' , ', ', 'E'));

email_src_ib_lseen := __common__( if(em_ib_pos_1 = 0, '', Models.Common.getw(ver_email_sources_first_seen, em_ib_pos_1)));

_email_src_ib_lseen := __common__( common.sas_date((string)(email_src_ib_lseen)));

em_ib_pos := __common__( Models.Common.findw_cpp(ver_email_sources, 'IB' , ', ', 'E'));

nf_email_src_m1 := __common__( Models.Common.findw_cpp(ver_email_sources, 'M1' , ', ', 'E') > 0);

em_m1_pos_2 := __common__( Models.Common.findw_cpp(ver_email_sources, 'M1' , ', ', 'E'));

email_src_m1_fseen := __common__( if(em_m1_pos_2 = 0, '', Models.Common.getw(ver_email_sources_first_seen, em_m1_pos_2)));

_email_src_m1_fseen := __common__( common.sas_date((string)(email_src_m1_fseen)));

em_m1_pos_1 := __common__( Models.Common.findw_cpp(ver_email_sources, 'M1' , ', ', 'E'));

email_src_m1_lseen := __common__( if(em_m1_pos_1 = 0, '', Models.Common.getw(ver_email_sources_first_seen, em_m1_pos_1)));

_email_src_m1_lseen := __common__( common.sas_date((string)(email_src_m1_lseen)));

em_m1_pos := __common__( Models.Common.findw_cpp(ver_email_sources, 'M1' , ', ', 'E'));

nf_email_src_et := __common__( Models.Common.findw_cpp(ver_email_sources, 'ET' , ', ', 'E') > 0);

em_et_pos_2 := __common__( Models.Common.findw_cpp(ver_email_sources, 'ET' , ', ', 'E'));

email_src_et_fseen := __common__( if(em_et_pos_2 = 0, '', Models.Common.getw(ver_email_sources_first_seen, em_et_pos_2)));

_email_src_et_fseen := __common__( common.sas_date((string)(email_src_et_fseen)));

em_et_pos_1 := __common__( Models.Common.findw_cpp(ver_email_sources, 'ET' , ', ', 'E'));

email_src_et_lseen := __common__( if(em_et_pos_1 = 0, '', Models.Common.getw(ver_email_sources_first_seen, em_et_pos_1)));

_email_src_et_lseen := __common__( common.sas_date((string)(email_src_et_lseen)));

em_et_pos := __common__( Models.Common.findw_cpp(ver_email_sources, 'ET' , ', ', 'E'));

nf_email_src_wa := __common__( Models.Common.findw_cpp(ver_email_sources, 'W@' , ', ', 'E') > 0);

em_wa_pos_2 := __common__( Models.Common.findw_cpp(ver_email_sources, 'W@' , ', ', 'E'));

email_src_wa_fseen := __common__( if(em_wa_pos_2 = 0, '', Models.Common.getw(ver_email_sources_first_seen, em_wa_pos_2)));

_email_src_wa_fseen := __common__( common.sas_date((string)(email_src_wa_fseen)));

em_wa_pos_1 := __common__( Models.Common.findw_cpp(ver_email_sources, 'W@' , ', ', 'E'));

email_src_wa_lseen := __common__( if(em_wa_pos_1 = 0, '', Models.Common.getw(ver_email_sources_first_seen, em_wa_pos_1)));

_email_src_wa_lseen := __common__( common.sas_date((string)(email_src_wa_lseen)));

em_wa_pos := __common__( Models.Common.findw_cpp(ver_email_sources, 'W@' , ', ', 'E'));

nf_email_src_dg := __common__( Models.Common.findw_cpp(ver_email_sources, 'DG' , ', ', 'E') > 0);

em_dg_pos_2 := __common__( Models.Common.findw_cpp(ver_email_sources, 'DG' , ', ', 'E'));

email_src_dg_fseen := __common__( if(em_dg_pos_2 = 0, '', Models.Common.getw(ver_email_sources_first_seen, em_dg_pos_2)));

_email_src_dg_fseen := __common__( common.sas_date((string)(email_src_dg_fseen)));

em_dg_pos_1 := __common__( Models.Common.findw_cpp(ver_email_sources, 'DG' , ', ', 'E'));

email_src_dg_lseen := __common__( if(em_dg_pos_1 = 0, '', Models.Common.getw(ver_email_sources_first_seen, em_dg_pos_1)));

_email_src_dg_lseen := __common__( common.sas_date((string)(email_src_dg_lseen)));

em_dg_pos := __common__( Models.Common.findw_cpp(ver_email_sources, 'DG' , ', ', 'E'));

nf_email_src_sc := __common__( Models.Common.findw_cpp(ver_email_sources, 'SC' , ', ', 'E') > 0);

em_sc_pos_2 := __common__( Models.Common.findw_cpp(ver_email_sources, 'SC' , ', ', 'E'));

email_src_sc_fseen := __common__( if(em_sc_pos_2 = 0, '', Models.Common.getw(ver_email_sources_first_seen, em_sc_pos_2)));

_email_src_sc_fseen := __common__( common.sas_date((string)(email_src_sc_fseen)));

em_sc_pos_1 := __common__( Models.Common.findw_cpp(ver_email_sources, 'SC' , ', ', 'E'));

email_src_sc_lseen := __common__( if(em_sc_pos_1 = 0, '', Models.Common.getw(ver_email_sources_first_seen, em_sc_pos_1)));

_email_src_sc_lseen := __common__( common.sas_date((string)(email_src_sc_lseen)));

em_sc_pos := __common__( Models.Common.findw_cpp(ver_email_sources, 'SC' , ', ', 'E'));

nf_attr_arrests := __common__( if(not(truedid), NULL, min(if(attr_arrests = NULL, -NULL, attr_arrests), 999)));

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

nf_vf_hi_risk_ct := __common__( if(not(truedid), NULL, min(if(vf_hi_risk_ct = NULL, -NULL, vf_hi_risk_ct), 999)));

nf_vf_lexid_phn_lo_risk_ct := __common__( if(not(truedid), NULL, min(if(vf_LexID_phone_lo_risk_ct = NULL, -NULL, vf_LexID_phone_lo_risk_ct), 999)));

nf_vf_altlexid_phn_hi_risk_ct := __common__( if(not(truedid), NULL, min(if(vf_AltLexID_phone_hi_risk_ct = NULL, -NULL, vf_AltLexID_phone_hi_risk_ct), 999)));

nf_vf_lexid_addr_hi_risk_ct := __common__( if(not(truedid), NULL, min(if(vf_LexID_addr_hi_risk_ct = NULL, -NULL, vf_LexID_addr_hi_risk_ct), 999)));

nf_vf_lexid_ssn_hi_risk_ct := __common__( if(not(truedid), NULL, min(if(vf_LexID_ssn_hi_risk_ct = NULL, -NULL, vf_LexID_ssn_hi_risk_ct), 999)));

_liens_unrel_cj_first_seen := __common__( common.sas_date((string)(liens_unrel_CJ_first_seen)));

_liens_unrel_cj_last_seen := __common__( common.sas_date((string)(liens_unrel_CJ_last_seen)));

nf_liens_unrel_cj_total_amt := __common__( if(not(truedid), NULL, liens_unrel_CJ_total_amount));

_liens_rel_cj_first_seen := __common__( common.sas_date((string)(liens_rel_CJ_first_seen)));

_liens_rel_cj_last_seen := __common__( common.sas_date((string)(liens_rel_CJ_last_seen)));

nf_mos_liens_rel_cj_lseen := __common__( map(
    not(truedid)                   => NULL,
    _liens_rel_cj_last_seen = NULL => -1,
                     min(if(if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)))), 999)));

_liens_unrel_ft_first_seen := __common__( common.sas_date((string)(liens_unrel_FT_first_seen)));

nf_mos_liens_unrel_ft_fseen := __common__( map(
    not(truedid)     => NULL,
    _liens_unrel_ft_first_seen = NULL => -1,
       min(if(if ((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)))), 999)));

_liens_unrel_ft_last_seen := __common__( common.sas_date((string)(liens_unrel_FT_last_seen)));

_liens_rel_ft_first_seen := __common__( common.sas_date((string)(liens_rel_FT_first_seen)));

_liens_rel_ft_last_seen := __common__( common.sas_date((string)(liens_rel_FT_last_seen)));

_liens_unrel_fc_first_seen := __common__( common.sas_date((string)(liens_unrel_FC_first_seen)));

_liens_unrel_fc_last_seen := __common__( common.sas_date((string)(liens_unrel_FC_last_seen)));

_liens_rel_fc_first_seen := __common__( common.sas_date((string)(liens_rel_FC_first_seen)));

_liens_rel_fc_last_seen := __common__( common.sas_date((string)(liens_rel_FC_last_seen)));

_liens_unrel_lt_first_seen := __common__( common.sas_date((string)(liens_unrel_LT_first_seen)));

nf_mos_liens_unrel_lt_fseen := __common__( map(
    not(truedid)     => NULL,
    _liens_unrel_lt_first_seen = NULL => -1,
       min(if(if ((sysdate - _liens_unrel_lt_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_lt_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_lt_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_lt_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_lt_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_lt_first_seen) / (365.25 / 12)))), 999)));

_liens_unrel_lt_last_seen := __common__( common.sas_date((string)(liens_unrel_LT_last_seen)));

_liens_rel_lt_first_seen := __common__( common.sas_date((string)(liens_rel_LT_first_seen)));

_liens_rel_lt_last_seen := __common__( common.sas_date((string)(liens_rel_LT_last_seen)));

_liens_unrel_o_first_seen := __common__( common.sas_date((string)(liens_unrel_O_first_seen)));

_liens_unrel_o_last_seen := __common__( common.sas_date((string)(liens_unrel_O_last_seen)));

_liens_rel_o_first_seen := __common__( common.sas_date((string)(liens_rel_O_first_seen)));

_liens_rel_o_last_seen := __common__( common.sas_date((string)(liens_rel_O_last_seen)));

nf_liens_rel_o_total_amt := __common__( if(not(truedid), NULL, liens_rel_O_total_amount));

_liens_unrel_ot_first_seen := __common__( common.sas_date((string)(liens_unrel_OT_first_seen)));

_liens_unrel_ot_last_seen := __common__( common.sas_date((string)(liens_unrel_OT_last_seen)));

_liens_rel_ot_first_seen := __common__( common.sas_date((string)(liens_rel_OT_first_seen)));

_liens_rel_ot_last_seen := __common__( common.sas_date((string)(liens_rel_OT_last_seen)));

_liens_unrel_sc_first_seen := __common__( common.sas_date((string)(liens_unrel_SC_first_seen)));

nf_mos_liens_unrel_sc_fseen := __common__( map(
    not(truedid)     => NULL,
    _liens_unrel_sc_first_seen = NULL => -1,
       min(if(if ((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)))), 999)));

_liens_unrel_sc_last_seen := __common__( common.sas_date((string)(liens_unrel_SC_last_seen)));

nf_mos_liens_unrel_sc_lseen := __common__( map(
    not(truedid)    => NULL,
    _liens_unrel_sc_last_seen = NULL => -1,
      min(if(if ((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12)))), 999)));

nf_liens_unrel_sc_total_amt := __common__( if(not(truedid), NULL, liens_unrel_SC_total_amount));

_liens_rel_sc_first_seen := __common__( common.sas_date((string)(liens_rel_SC_first_seen)));

_liens_rel_sc_last_seen := __common__( common.sas_date((string)(liens_rel_SC_last_seen)));

_liens_unrel_st_first_seen := __common__( common.sas_date((string)(liens_unrel_ST_first_seen)));

nf_mos_liens_unrel_st_fseen := __common__( map(
    not(truedid)     => NULL,
    _liens_unrel_st_first_seen = NULL => -1,
       min(if(if ((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)))), 999)));

_liens_unrel_st_last_seen := __common__( common.sas_date((string)(liens_unrel_ST_last_seen)));

nf_liens_unrel_st_total_amt := __common__( if(not(truedid), NULL, liens_unrel_ST_total_amount));

_liens_rel_st_first_seen := __common__( common.sas_date((string)(liens_rel_ST_first_seen)));

_liens_rel_st_last_seen := __common__( common.sas_date((string)(liens_rel_ST_last_seen)));

_foreclosure_last_date := __common__( common.sas_date((string)(foreclosure_last_date)));

iv_estimated_income := __common__( if(not(truedid), NULL, estimated_income));

nf_historic_x_current_ct := __common__( if(not(truedid), '', trim((String)min(if(historical_count = NULL, -NULL, historical_count), 3), LEFT, RIGHT) 
+ trim('-', LEFT, RIGHT) + trim((String)min(if(current_count = NULL, -NULL, current_count), 3), LEFT, RIGHT)));

_acc_last_seen := __common__( common.sas_date((string)(acc_last_seen)));

_prof_license_ix_sanct_fs := __common__( common.sas_date((string)(Prof_license_IX_sanct_fs)));

_prof_license_ix_sanct_ls := __common__( common.sas_date((string)(Prof_license_IX_sanct_ls)));

nf_fp_idverrisktype := __common__( map(
    not(truedid)            => NULL,
    fp_idverrisktype = '' => NULL,
              (Integer)trim(fp_idverrisktype, LEFT)));

nf_fp_idveraddressnotcurrent_1 := __common__( if(not(truedid), NULL, NULL));

nf_fp_idveraddressnotcurrent := __common__( if(fp_idveraddressnotcurrent = '', NULL, (Integer)trim(fp_idveraddressnotcurrent, LEFT)));

nf_fp_sourcerisktype := __common__( map(
    not(truedid)             => NULL,
    fp_sourcerisktype = '' => NULL,
               (Integer)trim(fp_sourcerisktype, LEFT)));

nf_fp_varrisktype := __common__( map(
    not(truedid)          => NULL,
    fp_varrisktype = '' => NULL,
            (Integer)trim(fp_varrisktype, LEFT)));

nf_fp_srchunvrfdssncount := __common__( if(not(truedid), NULL, min(if(fp_srchunvrfdssncount = '', -NULL, (Integer)fp_srchunvrfdssncount), 999)));

nf_fp_srchunvrfdphonecount := __common__( if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = '', -NULL, (Integer)fp_srchunvrfdphonecount), 999)));

nf_fp_srchfraudsrchcount := __common__( if(not(truedid), NULL, min(if(fp_srchfraudsrchcount = '', -NULL, (Integer)fp_srchfraudsrchcount), 999)));

nf_fp_srchfraudsrchcountmo := __common__( if(not(truedid), NULL, min(if(fp_srchfraudsrchcountmo = '', -NULL, (Integer)fp_srchfraudsrchcountmo), 999)));

nf_fp_srchfraudsrchcountwk := __common__( if(not(truedid), NULL, min(if(fp_srchfraudsrchcountwk = '', -NULL, (Integer)fp_srchfraudsrchcountwk), 999)));

nf_fp_srchcomponentrisktype := __common__( map(
    not(truedid)   => NULL,
    fp_srchcomponentrisktype = '' => NULL,
                      (Integer)trim(fp_srchcomponentrisktype, LEFT)));

nf_fp_srchssnsrchcountmo := __common__( if(not(truedid), NULL, min(if(fp_srchssnsrchcountmo = '', -NULL, (Integer)fp_srchssnsrchcountmo), 999)));

nf_fp_srchaddrsrchcount := __common__( if(not(truedid), NULL, min(if(fp_srchaddrsrchcount = '', -NULL, (Integer)fp_srchaddrsrchcount), 999)));

nf_fp_srchaddrsrchcountmo := __common__( if(not(truedid), NULL, min(if(fp_srchaddrsrchcountmo = '', -NULL, (Integer)fp_srchaddrsrchcountmo), 999)));

nf_fp_srchaddrsrchcountwk := __common__( if(not(truedid), NULL, min(if(fp_srchaddrsrchcountwk = '', -NULL, (Integer)fp_srchaddrsrchcountwk), 999)));

nf_fp_srchphonesrchcountmo := __common__( if(not(truedid), NULL, min(if(fp_srchphonesrchcountmo = '', -NULL, (Integer)fp_srchphonesrchcountmo), 999)));

nf_fp_srchphonesrchcountwk := __common__( if(not(truedid), NULL, min(if(fp_srchphonesrchcountwk = '', -NULL, (Integer)fp_srchphonesrchcountwk), 999)));

nf_fp_prevaddrlenofres := __common__( if(not(truedid), NULL, min(if(fp_prevaddrlenofres = '', -NULL, (Integer)fp_prevaddrlenofres), 999)));

nf_fp_prevaddroccupantowned := __common__( map(
    not(truedid)   => NULL,
    fp_prevaddroccupantowned = '' => NULL,
                      (Integer)trim(fp_prevaddroccupantowned, LEFT)));

nf_pb_retail_combo_cnt := __common__( if(not(truedid), NULL, if((String)max((Integer)pb_total_orders, inq_Retail_count) = '', NULL, sum((Integer)if(pb_total_orders = '', '0', (String)(Integer)pb_total_orders), if(inq_Retail_count = NULL, 0, inq_Retail_count)))));

nf_pb_retail_combo_max := __common__( if(not(truedid), NULL, max((integer)pb_total_orders, inq_Retail_count)));

bureau_adl_eq_fseen_pos_2 := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

bureau_adl_fseen_eq_2 := __common__( if(bureau_adl_eq_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_2, ',')));

_bureau_adl_fseen_eq_2 := __common__( common.sas_date((string)(bureau_adl_fseen_eq_2)));

bureau_adl_en_fseen_pos_2 := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E'));

bureau_adl_fseen_en_2 := __common__( if(bureau_adl_en_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos_2, ',')));

_bureau_adl_fseen_en_2 := __common__( common.sas_date((string)(bureau_adl_fseen_en_2)));

bureau_adl_ts_fseen_pos_2 := __common__( Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E'));

bureau_adl_fseen_ts_2 := __common__( if(bureau_adl_ts_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos_2, ',')));

_bureau_adl_fseen_ts_2 := __common__( common.sas_date((string)(bureau_adl_fseen_ts_2)));

bureau_adl_tu_fseen_pos_2 := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E'));

bureau_adl_fseen_tu_2 := __common__( if(bureau_adl_tu_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos_2, ',')));

_bureau_adl_fseen_tu_2 := __common__( common.sas_date((string)(bureau_adl_fseen_tu_2)));

bureau_adl_tn_fseen_pos_2 := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E'));

bureau_adl_fseen_tn_2 := __common__( if(bureau_adl_tn_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos_2, ',')));

_bureau_adl_fseen_tn_2 := __common__( common.sas_date((string)(bureau_adl_fseen_tn_2)));

_src_bureau_adl_fseen_all_2 := __common__( min(if(_bureau_adl_fseen_tn_2 = NULL, -NULL, _bureau_adl_fseen_tn_2), if(_bureau_adl_fseen_ts_2 = NULL, -NULL, _bureau_adl_fseen_ts_2), if(_bureau_adl_fseen_tu_2 = NULL, -NULL, _bureau_adl_fseen_tu_2), if(_bureau_adl_fseen_en_2 = NULL, -NULL, _bureau_adl_fseen_en_2), if(_bureau_adl_fseen_eq_2 = NULL, -NULL, _bureau_adl_fseen_eq_2), 999999));

credit_bureau_oldest_2 := __common__( map(
    not(truedid)        => NULL,
    _src_bureau_adl_fseen_all_2 = 999999 => -1,
          if ((sysdate - _src_bureau_adl_fseen_all_2) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all_2) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all_2) / (365.25 / 12)))));

num_sources_2 := __common__( (integer)(contains_i(ver_sources, 'EB') > 0) +
    (integer)(contains_i(ver_sources, 'EM') > 0) +
    (integer)(contains_i(ver_sources, 'E1') > 0) +
    (integer)(contains_i(ver_sources, 'E2') > 0) +
    (integer)(contains_i(ver_sources, 'E3') > 0) +
    (integer)(contains_i(ver_sources, 'P ') > 0) +
    (integer)(contains_i(ver_sources, 'PL') > 0) +
    (integer)(contains_i(ver_sources, 'SL') > 0) +
    (integer)(contains_i(ver_sources, 'V ') > 0) +
    (integer)(contains_i(ver_sources, 'VO') > 0) +
    (integer)(contains_i(ver_sources, 'W ') > 0) +
    (integer)(contains_i(ver_sources, 'D ') > 0 or (Boolean)contains_i(ver_sources, 'DL')));

bureau_adl_eq_fseen_pos_1 := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

bureau_adl_fseen_eq_1 := __common__( if(bureau_adl_eq_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_1, ',')));

_bureau_adl_fseen_eq_1 := __common__( common.sas_date((string)(bureau_adl_fseen_eq_1)));

bureau_adl_en_fseen_pos_1 := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E'));

bureau_adl_fseen_en_1 := __common__( if(bureau_adl_en_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos_1, ',')));

_bureau_adl_fseen_en_1 := __common__( common.sas_date((string)(bureau_adl_fseen_en_1)));

bureau_adl_ts_fseen_pos_1 := __common__( Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E'));

bureau_adl_fseen_ts_1 := __common__( if(bureau_adl_ts_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos_1, ',')));

_bureau_adl_fseen_ts_1 := __common__( common.sas_date((string)(bureau_adl_fseen_ts_1)));

bureau_adl_tu_fseen_pos_1 := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E'));

bureau_adl_fseen_tu_1 := __common__( if(bureau_adl_tu_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos_1, ',')));

_bureau_adl_fseen_tu_1 := __common__( common.sas_date((string)(bureau_adl_fseen_tu_1)));

bureau_adl_tn_fseen_pos_1 := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E'));

bureau_adl_fseen_tn_1 := __common__( if(bureau_adl_tn_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos_1, ',')));

_bureau_adl_fseen_tn_1 := __common__( common.sas_date((string)(bureau_adl_fseen_tn_1)));

_src_bureau_adl_fseen_all_1 := __common__( min(if(_bureau_adl_fseen_tn_1 = NULL, -NULL, _bureau_adl_fseen_tn_1), if(_bureau_adl_fseen_ts_1 = NULL, -NULL, _bureau_adl_fseen_ts_1), if(_bureau_adl_fseen_tu_1 = NULL, -NULL, _bureau_adl_fseen_tu_1), if(_bureau_adl_fseen_en_1 = NULL, -NULL, _bureau_adl_fseen_en_1), if(_bureau_adl_fseen_eq_1 = NULL, -NULL, _bureau_adl_fseen_eq_1), 999999));

credit_bureau_oldest_1 := __common__( map(
    not(truedid)        => NULL,
    _src_bureau_adl_fseen_all_1 = 999999 => -1,
          if ((sysdate - _src_bureau_adl_fseen_all_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all_1) / (365.25 / 12)))));

num_sources_1 := __common__( (integer)(contains_i(ver_sources, 'EB') > 0) +
    (integer)(contains_i(ver_sources, 'EM') > 0) +
    (integer)(contains_i(ver_sources, 'E1') > 0) +
    (integer)(contains_i(ver_sources, 'E2') > 0) +
    (integer)(contains_i(ver_sources, 'E3') > 0) +
    (integer)(contains_i(ver_sources, 'P ') > 0) +
    (integer)(contains_i(ver_sources, 'PL') > 0) +
    (integer)(contains_i(ver_sources, 'SL') > 0) +
    (integer)(contains_i(ver_sources, 'V ') > 0) +
    (integer)(contains_i(ver_sources, 'VO') > 0) +
    (integer)(contains_i(ver_sources, 'W ') > 0) +
    (integer)(contains_i(ver_sources, 'D ') > 0 or (Boolean)contains_i(ver_sources, 'DL')));

bureau_adl_eq_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

bureau_adl_fseen_eq := __common__( if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ',')));

_bureau_adl_fseen_eq := __common__( common.sas_date((string)(bureau_adl_fseen_eq)));

bureau_adl_en_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E'));

bureau_adl_fseen_en := __common__( if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ',')));

_bureau_adl_fseen_en := __common__( common.sas_date((string)(bureau_adl_fseen_en)));

bureau_adl_ts_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E'));

bureau_adl_fseen_ts := __common__( if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos, ',')));

_bureau_adl_fseen_ts := __common__( common.sas_date((string)(bureau_adl_fseen_ts)));

bureau_adl_tu_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E'));

bureau_adl_fseen_tu := __common__( if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos, ',')));

_bureau_adl_fseen_tu := __common__( common.sas_date((string)(bureau_adl_fseen_tu)));

bureau_adl_tn_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E'));

bureau_adl_fseen_tn := __common__( if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos, ',')));

_bureau_adl_fseen_tn := __common__( common.sas_date((string)(bureau_adl_fseen_tn)));

_src_bureau_adl_fseen_all := __common__( min(if(_bureau_adl_fseen_tn = NULL, -NULL, _bureau_adl_fseen_tn), if(_bureau_adl_fseen_ts = NULL, -NULL, _bureau_adl_fseen_ts), if(_bureau_adl_fseen_tu = NULL, -NULL, _bureau_adl_fseen_tu), if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999));

credit_bureau_oldest := __common__( map(
    not(truedid)      => NULL,
    _src_bureau_adl_fseen_all = 999999 => -1,
        if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)))));

num_sources := __common__( (integer)(contains_i(ver_sources, 'CY') > 0) +
    (integer)(contains_i(ver_sources, 'PL') > 0) +
    (integer)(contains_i(ver_sources, 'SL') > 0) +
    (integer)(contains_i(ver_sources, 'WP') > 0) +
    (integer)(contains_i(ver_sources, 'AK') > 0) +
    (integer)(contains_i(ver_sources, 'AM') > 0) +
    (integer)(contains_i(ver_sources, 'AR') > 0) +
    (integer)(contains_i(ver_sources, 'BA') > 0) +
    (integer)(contains_i(ver_sources, 'CG') > 0) +
    (integer)(contains_i(ver_sources, 'DA') > 0) +
    (integer)(contains_i(ver_sources, 'D ') > 0) +
    (integer)(contains_i(ver_sources, 'DL') > 0) +
    (integer)(contains_i(ver_sources, 'DS') > 0) +
    (integer)(contains_i(ver_sources, 'DE') > 0) +
    (integer)(contains_i(ver_sources, 'EB') > 0) +
    (integer)(contains_i(ver_sources, 'EM') > 0) +
    (integer)(contains_i(ver_sources, 'E1') > 0) +
    (integer)(contains_i(ver_sources, 'E2') > 0) +
    (integer)(contains_i(ver_sources, 'E3') > 0) +
    (integer)(contains_i(ver_sources, 'E4') > 0) +
    (integer)(contains_i(ver_sources, 'FE') > 0) +
    (integer)(contains_i(ver_sources, 'FF') > 0) +
    (integer)(contains_i(ver_sources, 'FR') > 0) +
    (integer)(contains_i(ver_sources, 'L2') > 0) +
    (integer)(contains_i(ver_sources, 'LI') > 0) +
    (integer)(contains_i(ver_sources, 'MW') > 0) +
    (integer)(contains_i(ver_sources, 'NT') > 0) +
    (integer)(contains_i(ver_sources, 'P ') > 0) +
    (integer)(contains_i(ver_sources, 'V ') > 0) +
    (integer)(contains_i(ver_sources, 'VO') > 0) +
    (integer)(contains_i(ver_sources, 'W ') > 0));

bureau_ := __common__( contains_i(ver_sources, 'EN') > 0 or contains_i(ver_sources, 'EQ') > 0 or contains_i(ver_sources, 'TN') > 0 or contains_i(ver_sources, 'TS') > 0 or contains_i(ver_sources, 'TU') > 0);

behavioral_ := __common__( contains_i(ver_sources, 'CY') > 0 or contains_i(ver_sources, 'PL') > 0 or contains_i(ver_sources, 'SL') > 0 or contains_i(ver_sources, 'WP') > 0);

government_ := __common__( contains_i(ver_sources, 'AK') > 0 or contains_i(ver_sources, 'AM') > 0 or contains_i(ver_sources, 'AR') > 0 or contains_i(ver_sources, 'BA') > 0 or contains_i(ver_sources, 'CG') > 0 or contains_i(ver_sources, 'DA') > 0 or contains_i(ver_sources, 'D ') > 0 or contains_i(ver_sources, 'DL') > 0 or contains_i(ver_sources, 'DS') > 0 or contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'EB') > 0 or contains_i(ver_sources, 'EM') > 0 or contains_i(ver_sources, 'E1') > 0 or contains_i(ver_sources, 'E2') > 0 or contains_i(ver_sources, 'E3') > 0 or contains_i(ver_sources, 'E4') > 0 or contains_i(ver_sources, 'FE') > 0 or contains_i(ver_sources, 'FF') > 0 or contains_i(ver_sources, 'FR') > 0 or contains_i(ver_sources, 'L2') > 0 or contains_i(ver_sources, 'LI') > 0 or contains_i(ver_sources, 'MW') > 0 or contains_i(ver_sources, 'NT') > 0 or contains_i(ver_sources, 'P ') > 0 or contains_i(ver_sources, 'V ') > 0 or contains_i(ver_sources, 'VO') > 0 or contains_i(ver_sources, 'W ') > 0);

nf_source_type := __common__( map(
    not(truedid)                     => ' ',
    bureau_ and behavioral_ and government_           => 'Bureau Behavioral and Government',
    not(bureau_) and behavioral_ and government_      => 'Behavioral and Government',
    bureau_ and not(behavioral_) and government_      => 'Bureau and Government',
    bureau_ and behavioral_ and not(government_)      => 'Bureau and Behavioral',
    not(bureau_) and not(behavioral_) and government_ => 'Government Only',
    not(bureau_) and behavioral_ and not(government_) => 'Behavioral Only',
    bureau_ and not(behavioral_) and not(government_) => 'Bureau Only',
                       'None'));

_add_not_ver_2 := __common__( (nas_summary in [4, 7, 9]));

_add_not_ver_1 := __common__( (nas_summary in [4, 7, 9]));

nf_inq_per_add_nas_479 := __common__( map(
    not(truedid and ssnlength > '0' or addrpop) => NULL,
    not(_add_not_ver_1)      => -1,
               min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999)));

_add_not_ver := __common__( (nas_summary in [4, 7, 9]));

lic_adl_d_count_pos := __common__( Models.Common.findw_cpp(ver_sources, 'D' , ', ', 'E'));

lic_adl_count_d := __common__( if(lic_adl_d_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, lic_adl_d_count_pos, ',')));

lic_adl_dl_count_pos := __common__( Models.Common.findw_cpp(ver_sources, 'DL' , ', ', 'E'));

lic_adl_count_dl := __common__( if(lic_adl_dl_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, lic_adl_dl_count_pos, ',')));

_src_vehx_adl_count := __common__( max(if(max(lic_adl_count_d, lic_adl_count_dl) = NULL, NULL, sum(if(lic_adl_count_d = NULL, 0, lic_adl_count_d), if(lic_adl_count_dl = NULL, 0, lic_adl_count_dl))), (real)0));

voter_adl_v_count_pos := __common__( Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'));

iv_src_voter_adl_count := __common__( map(
    not(truedid)              => NULL,
    not(voter_avail)          => -1,
    voter_adl_v_count_pos = 0 => 0,
                (integer)Models.Common.getw(ver_sources_count, voter_adl_v_count_pos, ',')));

vote_adl_vo_lseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'));

vote_adl_lseen_vo := __common__( if(vote_adl_vo_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, vote_adl_vo_lseen_pos, ',')));

_vote_adl_lseen_vo := __common__( common.sas_date((string)(vote_adl_lseen_vo)));

_src_vote_adl_lseen := __common__( _vote_adl_lseen_vo);

iv_mos_src_voter_adl_lseen := __common__( map(
    not(truedid)               => NULL,
    not(voter_avail)           => -1,
    _src_vote_adl_lseen = NULL => -1,
                 if ((sysdate - _src_vote_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_vote_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_vote_adl_lseen) / (365.25 / 12)))));

_ver_src_ds_1 := __common__( Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0);

_ver_src_de_1 := __common__( Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0);

_ver_src_eq_1 := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0);

_ver_src_en_1 := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0);

_ver_src_tn_1 := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0);

_ver_src_tu_1 := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0);

_credit_source_cnt_1 := __common__( (integer)_ver_src_eq_1 +
    (integer)_ver_src_en_1 +
    (integer)_ver_src_tn_1 +
    (integer)_ver_src_tu_1);

_ver_src_cnt_1 := __common__( Models.Common.countw((string)(ver_sources)));

_bureauonly_1 := __common__( _credit_source_cnt_1 > 0 AND _credit_source_cnt_1 = _ver_src_cnt_1 AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6])));

_derog_1 := __common__( felony_count > 0 OR (Integer)addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2);

_deceased_1 := __common__( rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds_1 OR _ver_src_de_1);

_ssnpriortodob_1 := __common__( rc_ssndobflag = '1' OR rc_pwssndobflag = '1');

_inputmiskeys_1 := __common__( rc_ssnmiskeyflag or rc_addrmiskeyflag or (Integer)add_input_house_number_match = 0);

_multiplessns_1 := __common__( ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1);

_hh_strikes_1 := __common__( hh_members_w_derog > 0 + hh_criminals AND 0 + hh_criminals > 0 + hh_payday_loan_users AND 0 + hh_payday_loan_users > 0);

final_score_0 := __common__( -1.5289802822);

final_score_1 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 1.5 => -0.0072617093,
    nf_inq_communications_count > 1.5       => 0.0260511149,
    nf_inq_communications_count = NULL      => 0.0005950069,
             0.0005950069));

final_score_2 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 1.5 => -0.0078369309,
    nf_inq_communications_count > 1.5       => 0.0315097471,
    nf_inq_communications_count = NULL      => 0.0015608994,
             0.0015608994));

final_score_3 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 6.5 => -0.0027844923,
    nf_inq_communications_count > 6.5       => 0.0717282957,
    nf_inq_communications_count = NULL      => -0.0002375451,
             -0.0002375451));

final_score_4 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 5.5 => -0.0025912698,
    nf_inq_communications_count > 5.5       => 0.0505009501,
    nf_inq_communications_count = NULL      => 0.0001378019,
             0.0001378019));

final_score_5 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 2.5 => -0.0049433133,
    nf_inq_communications_count > 2.5       => 0.0316752668,
    nf_inq_communications_count = NULL      => 0.0004639698,
             0.0004639698));

final_score_6 := __common__( map(
    NULL < nf_inq_communications_count24 AND nf_inq_communications_count24 <= 1.5 => -0.0044056308,
    nf_inq_communications_count24 > 1.5         => 0.0299004287,
    nf_inq_communications_count24 = NULL        => -0.0014069276,
                 -0.0014069276));

final_score_7 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 9.5 => -0.0023951200,
    nf_inq_communications_count > 9.5       => 0.0831103411,
    nf_inq_communications_count = NULL      => -0.0012462729,
             -0.0012462729));

final_score_8 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 4.5 => -0.0039872141,
    nf_inq_communications_count > 4.5       => 0.0366038798,
    nf_inq_communications_count = NULL      => -0.0011173507,
             -0.0011173507));

final_score_9 := __common__( map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype <= 2.5 => -0.0088081965,
    nf_fp_varrisktype > 2.5              => 0.0163219175,
    nf_fp_varrisktype = NULL             => -0.0000151155,
          -0.0000151155));

final_score_10 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 2.5 => -0.0047564027,
    nf_inq_communications_count > 2.5       => 0.0235161674,
    nf_inq_communications_count = NULL      => -0.0005878218,
             -0.0005878218));

final_score_11 := __common__( map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian <= 0.5 => 0.0171251743,
    nf_phone_ver_experian > 0.5                  => -0.0065257911,
    nf_phone_ver_experian = NULL                 => 0.0011562992,
                  0.0011562992));

final_score_12 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 9.5 => -0.0026632646,
    nf_inq_communications_count > 9.5       => 0.0790333948,
    nf_inq_communications_count = NULL      => -0.0016616360,
             -0.0016616360));

final_score_13 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 1.5 => -0.0054696998,
    nf_inq_communications_count > 1.5       => 0.0214629249,
    nf_inq_communications_count = NULL      => 0.0007741716,
             0.0007741716));

final_score_14 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 1.5 => -0.0067001354,
    nf_inq_communications_count > 1.5       => 0.0200519923,
    nf_inq_communications_count = NULL      => -0.0003531783,
             -0.0003531783));

final_score_15 := __common__( map(
    NULL < nf_pb_retail_combo_cnt AND nf_pb_retail_combo_cnt <= 0.5 => 0.0170532478,
    nf_pb_retail_combo_cnt > 0.5                   => -0.0079272153,
    nf_pb_retail_combo_cnt = NULL                  => -0.0024567317,
                    -0.0024567317));

final_score_16 := __common__( map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype <= 3.5 => -0.0045874787,
    nf_fp_varrisktype > 3.5              => 0.0226335016,
    nf_fp_varrisktype = NULL             => 0.0008354093,
          0.0008354093));

final_score_17 := __common__( map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian <= 0.5 => 0.0136465585,
    nf_phone_ver_experian > 0.5                  => -0.0070323989,
    nf_phone_ver_experian = NULL                 => -0.0002581181,
                  -0.0002581181));

final_score_18 := __common__( map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype <= 2.5 => -0.0078566361,
    nf_fp_varrisktype > 2.5              => 0.0182381032,
    nf_fp_varrisktype = NULL             => 0.0012591625,
          0.0012591625));

final_score_19 := __common__( map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype <= 2.5 => -0.0075229894,
    nf_fp_varrisktype > 2.5              => 0.0133790271,
    nf_fp_varrisktype = NULL             => -0.0001948792,
          -0.0001948792));

final_score_20 := __common__( map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype <= 4.5 => -0.0060342447,
    nf_fp_varrisktype > 4.5              => 0.0239849922,
    nf_fp_varrisktype = NULL             => -0.0026509130,
          -0.0026509130));

final_score_21 := __common__( map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype <= 4.5 => -0.0059537719,
    nf_fp_varrisktype > 4.5              => 0.0248863529,
    nf_fp_varrisktype = NULL             => -0.0025981732,
          -0.0025981732));

final_score_22 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 1.5 => -0.0054315087,
    nf_inq_communications_count > 1.5       => 0.0155009114,
    nf_inq_communications_count = NULL      => -0.0006141846,
             -0.0006141846));

final_score_23 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 5.5 => -0.0024264450,
    nf_inq_communications_count > 5.5       => 0.0342048634,
    nf_inq_communications_count = NULL      => -0.0007253302,
             -0.0007253302));

final_score_24 := __common__( map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian <= 0.5 => 0.0141582997,
    nf_phone_ver_experian > 0.5                  => -0.0072472453,
    nf_phone_ver_experian = NULL                 => -0.0003634007,
                  -0.0003634007));

final_score_25 := __common__( map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype <= 2.5 => -0.0075770035,
    nf_fp_varrisktype > 2.5              => 0.0139951721,
    nf_fp_varrisktype = NULL             => -0.0000823259,
          -0.0000823259));

final_score_26 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 1.5 => -0.0057722629,
    nf_inq_communications_count > 1.5       => 0.0155312793,
    nf_inq_communications_count = NULL      => -0.0006339574,
             -0.0006339574));

final_score_27 := __common__( map(
    NULL < nf_attr_arrest_recency AND nf_attr_arrest_recency <= 79.5 => 0.0633255723,
    nf_attr_arrest_recency > 79.5                   => 0.0328464376,
    nf_attr_arrest_recency = NULL                   => -0.0015141562,
                     -0.0000216304));

final_score_28 := __common__( map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian <= 0.5 => 0.0123718837,
    nf_phone_ver_experian > 0.5                  => -0.0068852489,
    nf_phone_ver_experian = NULL                 => -0.0006839698,
                  -0.0006839698));

final_score_29 := __common__( map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct <= 3.5 => 0.0134661480,
    iv_addr_non_phn_src_ct > 3.5                   => -0.0062983783,
    iv_addr_non_phn_src_ct = NULL                  => -0.0012813690,
                    -0.0012813690));

final_score_30 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 4.5 => -0.0026409025,
    nf_inq_communications_count > 4.5       => 0.0294687227,
    nf_inq_communications_count = NULL      => -0.0001905855,
             -0.0001905855));

final_score_31 := __common__( map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count <= 3.5 => 0.0113269078,
    rv_c12_inp_addr_source_count > 3.5        => -0.0061120238,
    rv_c12_inp_addr_source_count = NULL       => -0.0028832700,
               -0.0028832700));

final_score_32 := __common__( map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian <= 0.5 => 0.0124789267,
    nf_phone_ver_experian > 0.5                  => -0.0055742810,
    nf_phone_ver_experian = NULL                 => 0.0002935413,
                  0.0002935413));

final_score_33 := __common__( map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype <= 2.5 => -0.0056280624,
    nf_fp_varrisktype > 2.5              => 0.0131607137,
    nf_fp_varrisktype = NULL             => 0.0008873410,
          0.0008873410));

final_score_34 := __common__( map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-0', '2-2', '3-0', '3-2']) => -0.0007077607,
    (rv_d32_criminal_x_felony in ['1-1', '2-1', '3-1', '3-3'])               => 0.0494447547,
    rv_d32_criminal_x_felony = ''        => 0.0011831822,
            0.0011831822));

final_score_35 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 1.5 => -0.0039742538,
    nf_inq_communications_count > 1.5       => 0.0154343013,
    nf_inq_communications_count = NULL      => 0.0006931139,
             0.0006931139));

final_score_36 := __common__( map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian <= 0.5 => 0.0114315345,
    nf_phone_ver_experian > 0.5                  => -0.0065715419,
    nf_phone_ver_experian = NULL                 => -0.0006597685,
                  -0.0006597685));

final_score_37 := __common__( map(
    NULL < nf_fp_sourcerisktype AND nf_fp_sourcerisktype <= 6.5 => -0.0042193018,
    nf_fp_sourcerisktype > 6.5                 => 0.0314613522,
    nf_fp_sourcerisktype = NULL                => -0.0017614563,
                -0.0017614563));

final_score_38 := __common__( map(
    NULL < nf_vf_altlexid_phn_hi_risk_ct AND nf_vf_altlexid_phn_hi_risk_ct <= 0.5 => -0.0016119283,
    nf_vf_altlexid_phn_hi_risk_ct > 0.5         => 0.0625722663,
    nf_vf_altlexid_phn_hi_risk_ct = NULL        => -0.0007829348,
                 -0.0007829348));

final_score_39 := __common__( map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 41.5 => 0.0739874662,
    rv_c20_m_bureau_adl_fs > 41.5                   => -0.0011511600,
    rv_c20_m_bureau_adl_fs = NULL                   => -0.0003571315,
                     -0.0003571315));

final_score_40 := __common__( map(
    NULL < nf_pb_retail_combo_cnt AND nf_pb_retail_combo_cnt <= 1.5 => 0.0074910868,
    nf_pb_retail_combo_cnt > 1.5                   => -0.0099249845,
    nf_pb_retail_combo_cnt = NULL                  => -0.0012248993,
                    -0.0012248993));

final_score_41 := __common__( map(
    NULL < nf_pb_retail_combo_cnt AND nf_pb_retail_combo_cnt <= 0.5 => 0.0169269942,
    nf_pb_retail_combo_cnt > 0.5                   => -0.0038649228,
    nf_pb_retail_combo_cnt = NULL                  => 0.0006711008,
                    0.0006711008));

final_score_42 := __common__( map(
    NULL < rv_i60_inq_prepaidcards_recency AND rv_i60_inq_prepaidcards_recency <= 6 => -0.0037922859,
    rv_i60_inq_prepaidcards_recency > 6           => 0.0203180293,
    rv_i60_inq_prepaidcards_recency = NULL        => -0.0005909946,
                   -0.0005909946));

final_score_43 := __common__( map(
    NULL < rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add <= 0.5 => -0.0104246682,
    rv_p88_phn_dst_to_inp_add > 0.5                      => 0.0010164850,
    rv_p88_phn_dst_to_inp_add = NULL                     => 0.0111159805,
                          -0.0019010088));

final_score_44 := __common__( map(
    NULL < nf_inq_other_count24 AND nf_inq_other_count24 <= 0.5 => -0.0129326304,
    nf_inq_other_count24 > 0.5                 => 0.0070436035,
    nf_inq_other_count24 = NULL                => -0.0005601861,
                -0.0005601861));

final_score_45 := __common__( map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct <= 5.5 => 0.0054502682,
    iv_addr_non_phn_src_ct > 5.5                   => -0.0092968418,
    iv_addr_non_phn_src_ct = NULL                  => -0.0008931365,
                    -0.0008931365));

final_score_46 := __common__( map(
    NULL < nf_fp_srchssnsrchcountmo AND nf_fp_srchssnsrchcountmo <= 4.5 => -0.0024398982,
    nf_fp_srchssnsrchcountmo > 4.5                     => 0.0643483927,
    nf_fp_srchssnsrchcountmo = NULL                    => -0.0012726058,
                        -0.0012726058));

final_score_47 := __common__( map(
    NULL < rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add <= 691.5 => -0.0024879114,
    rv_p88_phn_dst_to_inp_add > 691.5                      => 0.0316238166,
    rv_p88_phn_dst_to_inp_add = NULL      => 0.0145151303,
                            0.0023824549));

final_score_48 := __common__( map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype <= 4.5 => -0.0032056529,
    nf_fp_varrisktype > 4.5              => 0.0211349186,
    nf_fp_varrisktype = NULL             => -0.0005861679,
          -0.0005861679));

final_score_49 := __common__( map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl <= 11.5 => -0.0038720270,
    iv_c14_addrs_per_adl > 11.5                 => 0.0214557230,
    iv_c14_addrs_per_adl = NULL                 => -0.0006928392,
                 -0.0006928392));

final_score_50 := __common__( map(
    NULL < rv_i60_inq_other_count12 AND rv_i60_inq_other_count12 <= 0.5 => -0.0075940006,
    rv_i60_inq_other_count12 > 0.5                     => 0.0099025439,
    rv_i60_inq_other_count12 = NULL                    => 0.0005301286,
                        0.0005301286));

final_score_51 := __common__( map(
    NULL < nf_vf_altlexid_phn_hi_risk_ct AND nf_vf_altlexid_phn_hi_risk_ct <= 0.5 => -0.0027301298,
    nf_vf_altlexid_phn_hi_risk_ct > 0.5         => 0.0703054408,
    nf_vf_altlexid_phn_hi_risk_ct = NULL        => -0.0018057496,
                 -0.0018057496));

final_score_52 := __common__( map(
    NULL < nf_vf_lexid_addr_hi_risk_ct AND nf_vf_lexid_addr_hi_risk_ct <= 0.5 => -0.0026273247,
    nf_vf_lexid_addr_hi_risk_ct > 0.5       => 0.0241207126,
    nf_vf_lexid_addr_hi_risk_ct = NULL      => -0.0006105799,
             -0.0006105799));

final_score_53 := __common__( map(
    NULL < nf_fp_srchfraudsrchcountmo AND nf_fp_srchfraudsrchcountmo <= 4.5 => -0.0024465807,
    nf_fp_srchfraudsrchcountmo > 4.5      => 0.0593422842,
    nf_fp_srchfraudsrchcountmo = NULL                      => -0.0012211231,
                            -0.0012211231));

final_score_54 := __common__( map(
    NULL < nf_fp_sourcerisktype AND nf_fp_sourcerisktype <= 6.5 => -0.0017141817,
    nf_fp_sourcerisktype > 6.5                 => 0.0290969931,
    nf_fp_sourcerisktype = NULL                => 0.0004524489,
                0.0004524489));

final_score_55 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 1.5 => -0.0045218216,
    nf_inq_communications_count > 1.5       => 0.0130417340,
    nf_inq_communications_count = NULL      => -0.0003439492,
             -0.0003439492));

final_score_56 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 1.5 => -0.0047943076,
    nf_inq_communications_count > 1.5       => 0.0135849956,
    nf_inq_communications_count = NULL      => -0.0004572140,
             -0.0004572140));

final_score_57 := __common__( map(
    NULL < nf_pb_retail_combo_cnt AND nf_pb_retail_combo_cnt <= 0.5 => 0.0141656693,
    nf_pb_retail_combo_cnt > 0.5                   => -0.0051844533,
    nf_pb_retail_combo_cnt = NULL                  => -0.0010120357,
                    -0.0010120357));

final_score_58 := __common__( map(
    NULL < nf_fp_srchaddrsrchcountwk AND nf_fp_srchaddrsrchcountwk <= 0.5 => -0.0015089257,
    nf_fp_srchaddrsrchcountwk > 0.5                      => 0.0211537403,
    nf_fp_srchaddrsrchcountwk = NULL                     => 0.0016749631,
                          0.0016749631));

final_score_59 := __common__( map(
    (rv_d32_criminal_x_felony in ['0-0', '2-2'])         => -0.0076589003,
    (rv_d32_criminal_x_felony in ['1-0', '1-1', '2-0', '2-1', '3-0', '3-1', '3-2', '3-3']) => 0.0109221290,
    rv_d32_criminal_x_felony = ''                      => -0.0005556009,
                          -0.0005556009));

final_score_60 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 5.5 => -0.0018507129,
    nf_inq_communications_count > 5.5       => 0.0256295105,
    nf_inq_communications_count = NULL      => -0.0004704277,
             -0.0004704277));

final_score_61 := __common__( map(
    NULL < nf_fp_srchaddrsrchcountmo AND nf_fp_srchaddrsrchcountmo <= 4.5 => -0.0008118701,
    nf_fp_srchaddrsrchcountmo > 4.5                      => 0.0557272152,
    nf_fp_srchaddrsrchcountmo = NULL                     => 0.0002944256,
                          0.0002944256));

final_score_62 := __common__( map(
    NULL < nf_pb_retail_combo_cnt AND nf_pb_retail_combo_cnt <= 0.5 => 0.0126777623,
    nf_pb_retail_combo_cnt > 0.5                   => -0.0044076721,
    nf_pb_retail_combo_cnt = NULL                  => -0.0007931456,
                    -0.0007931456));

final_score_63 := __common__( map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 10.5 => 0.0112840912,
    rv_c13_inp_addr_lres > 10.5                 => -0.0037672541,
    rv_c13_inp_addr_lres = NULL                 => -0.0007708117,
                 -0.0007708117));

final_score_64 := __common__( map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian <= 0.5 => 0.0096886753,
    nf_phone_ver_experian > 0.5                  => -0.0064030385,
    nf_phone_ver_experian = NULL                 => -0.0011783744,
                  -0.0011783744));

final_score_65 := __common__( map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct <= 3.5 => 0.0109044571,
    iv_addr_non_phn_src_ct > 3.5                   => -0.0040975750,
    iv_addr_non_phn_src_ct = NULL                  => -0.0001394162,
                    -0.0001394162));

final_score_66 := __common__( map(
    NULL < nf_inq_per_addr AND nf_inq_per_addr <= 7.5 => -0.0038648872,
    nf_inq_per_addr > 7.5            => 0.0123346354,
    nf_inq_per_addr = NULL           => -0.0007724830,
                       -0.0007724830));

final_score_67 := __common__( map(
    NULL < rv_i60_inq_other_count12 AND rv_i60_inq_other_count12 <= 0.5 => -0.0067922119,
    rv_i60_inq_other_count12 > 0.5                     => 0.0093384793,
    rv_i60_inq_other_count12 = NULL                    => 0.0006786235,
                        0.0006786235));

final_score_68 := __common__( map(
    NULL < nf_pb_retail_combo_cnt AND nf_pb_retail_combo_cnt <= 0.5 => 0.0152753757,
    nf_pb_retail_combo_cnt > 0.5                   => -0.0041544857,
    nf_pb_retail_combo_cnt = NULL                  => -0.0001037461,
                    -0.0001037461));

final_score_69 := __common__( map(
    NULL < nf_inq_other_count AND nf_inq_other_count <= 2.5 => -0.0064352150,
    nf_inq_other_count > 2.5               => 0.0090071538,
    nf_inq_other_count = NULL              => 0.0016002974,
            0.0016002974));

final_score_70 := __common__( map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres <= 36.5 => 0.0295109198,
    rv_c13_max_lres > 36.5            => -0.0024984872,
    rv_c13_max_lres = NULL            => -0.0009664772,
                        -0.0009664772));

final_score_71 := __common__( map(
    NULL < iv_dob_src_ct AND iv_dob_src_ct <= 3.5 => 0.0187587764,
    iv_dob_src_ct > 3.5          => -0.0028433160,
    iv_dob_src_ct = NULL         => 0.0002149134,
                   0.0002149134));

final_score_72 := __common__( map(
    NULL < rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add <= 3.5 => -0.0066708858,
    rv_p88_phn_dst_to_inp_add > 3.5                      => 0.0052464375,
    rv_p88_phn_dst_to_inp_add = NULL                     => 0.0095268843,
                          -0.0003464604));

final_score_73 := __common__( map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr <= 5.5 => -0.0040466268,
    rv_c14_addrs_10yr > 5.5              => 0.0139498348,
    rv_c14_addrs_10yr = NULL             => -0.0004891321,
          -0.0004891321));

final_score_74 := __common__( map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-0', '2-1', '2-2', '3-0', '3-2']) => -0.0008102459,
    (rv_d32_criminal_x_felony in ['1-1', '3-1', '3-3'])            => 0.0349349263,
    rv_d32_criminal_x_felony = ''               => 0.0003835915,
                   0.0003835915));

final_score_75 := __common__( map(
    NULL < nf_fp_srchssnsrchcountmo AND nf_fp_srchssnsrchcountmo <= 5.5 => -0.0014340392,
    nf_fp_srchssnsrchcountmo > 5.5                     => 0.0674361355,
    nf_fp_srchssnsrchcountmo = NULL                    => -0.0007961860,
                        -0.0007961860));

final_score_76 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 2.5 => -0.0013882874,
    nf_inq_communications_count > 2.5       => 0.0163670527,
    nf_inq_communications_count = NULL      => 0.0012276305,
             0.0012276305));

final_score_77 := __common__( map(
    NULL < rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add <= 579.5 => -0.0020043938,
    rv_p88_phn_dst_to_inp_add > 579.5                      => 0.0240494403,
    rv_p88_phn_dst_to_inp_add = NULL      => 0.0118663206,
                            0.0020073685));

final_score_78 := __common__( map(
    NULL < nf_inq_ssns_per_sfd_addr AND nf_inq_ssns_per_sfd_addr <= 3.5 => -0.0022655567,
    nf_inq_ssns_per_sfd_addr > 3.5                     => 0.0283358602,
    nf_inq_ssns_per_sfd_addr = NULL                    => -0.0008519480,
                        -0.0008519480));

final_score_79 := __common__( map(
    NULL < iv_estimated_income AND iv_estimated_income <= 25500 => 0.0299775395,
    iv_estimated_income > 25500                => -0.0023854674,
    iv_estimated_income = NULL                 => -0.0010514327,
                -0.0010514327));

final_score_80 := __common__( map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-0', '2-2', '3-0', '3-2']) => -0.0010013226,
    (rv_d32_criminal_x_felony in ['1-1', '2-1', '3-1', '3-3'])               => 0.0359675789,
    rv_d32_criminal_x_felony = ''        => 0.0003734343,
            0.0003734343));

final_score_81 := __common__( map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 63.5 => 0.0412354660,
    rv_c20_m_bureau_adl_fs > 63.5                   => 0.0009103578,
    rv_c20_m_bureau_adl_fs = NULL                   => 0.0021149560,
                     0.0021149560));

final_score_82 := __common__( map(
    NULL < nf_pb_retail_combo_cnt AND nf_pb_retail_combo_cnt <= 0.5 => 0.0136908879,
    nf_pb_retail_combo_cnt > 0.5                   => -0.0038784416,
    nf_pb_retail_combo_cnt = NULL                  => -0.0002027921,
                    -0.0002027921));

final_score_83 := __common__( map(
    NULL < nf_inq_other_count24 AND nf_inq_other_count24 <= 2.5 => -0.0030008196,
    nf_inq_other_count24 > 2.5                 => 0.0143140712,
    nf_inq_other_count24 = NULL                => 0.0013612227,
                0.0013612227));

final_score_84 := __common__( map(
    NULL < nf_inq_count AND nf_inq_count <= 32.5 => -0.0024344554,
    nf_inq_count > 32.5         => 0.0274909245,
    nf_inq_count = NULL         => -0.0013023969,
                  -0.0013023969));

final_score_85 := __common__( map(
    NULL < rv_d33_eviction_count AND rv_d33_eviction_count <= 4.5 => -0.0030940620,
    rv_d33_eviction_count > 4.5                  => 0.0222791071,
    rv_d33_eviction_count = NULL                 => -0.0012336939,
                  -0.0012336939));

final_score_86 := __common__( map(
    NULL < nf_inq_per_addr AND nf_inq_per_addr <= 7.5 => -0.0044427796,
    nf_inq_per_addr > 7.5            => 0.0134263578,
    nf_inq_per_addr = NULL           => -0.0010119052,
                       -0.0010119052));

final_score_87 := __common__( map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian <= -0.5 => 0.0351462948,
    nf_phone_ver_experian > -0.5                  => -0.0003810495,
    nf_phone_ver_experian = NULL                  => 0.0006852808,
                   0.0006852808));

final_score_88 := __common__( map(
    NULL < nf_bus_phone_match AND nf_bus_phone_match <= 1.5 => -0.0044870430,
    nf_bus_phone_match > 1.5               => 0.0074554269,
    nf_bus_phone_match = NULL              => 0.0517784458,
            -0.0005380400));

final_score_89 := __common__( map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres <= 19.5 => 0.0746341372,
    rv_c13_max_lres > 19.5            => 0.0011415662,
    rv_c13_max_lres = NULL            => 0.0016592546,
                        0.0016592546));

final_score_90 := __common__( map(
    NULL < rv_i60_inq_other_count12 AND rv_i60_inq_other_count12 <= 0.5 => -0.0066841814,
    rv_i60_inq_other_count12 > 0.5                     => 0.0083367345,
    rv_i60_inq_other_count12 = NULL                    => 0.0002942245,
                        0.0002942245));

final_score_91 := __common__( map(
    NULL < nf_attr_arrest_recency AND nf_attr_arrest_recency <= 79.5 => 0.0511976637,
    nf_attr_arrest_recency > 79.5                   => 0.0170389849,
    nf_attr_arrest_recency = NULL                   => -0.0010643647,
                     -0.0000826180));

final_score_92 := __common__( map(
    NULL < iv_estimated_income AND iv_estimated_income <= 28500 => 0.0249099073,
    iv_estimated_income > 28500                => -0.0008755139,
    iv_estimated_income = NULL                 => 0.0014588303,
                0.0014588303));

final_score_93 := __common__( map(
    NULL < nf_vf_hi_risk_ct AND nf_vf_hi_risk_ct <= 4.5 => -0.0015899825,
    nf_vf_hi_risk_ct > 4.5             => 0.0512295453,
    nf_vf_hi_risk_ct = NULL            => -0.0010663347,
                         -0.0010663347));

final_score_94 := __common__( map(
    NULL < nf_fp_sourcerisktype AND nf_fp_sourcerisktype <= 6.5 => -0.0023277191,
    nf_fp_sourcerisktype > 6.5                 => 0.0209853144,
    nf_fp_sourcerisktype = NULL                => -0.0006642402,
                -0.0006642402));

final_score_95 := __common__( map(
    NULL < nf_m_bureau_adl_fs_notu AND nf_m_bureau_adl_fs_notu <= 84.5 => 0.0259863067,
    nf_m_bureau_adl_fs_notu > 84.5                    => -0.0006766023,
    nf_m_bureau_adl_fs_notu = NULL                    => 0.0007669864,
                       0.0007669864));

final_score_96 := __common__( map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 6.5 => 0.0110030356,
    rv_c13_inp_addr_lres > 6.5                 => -0.0028285001,
    rv_c13_inp_addr_lres = NULL                => -0.0007544043,
                -0.0007544043));

final_score_97 := __common__( map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 8.5 => 0.0099705935,
    rv_c13_inp_addr_lres > 8.5                 => -0.0032419679,
    rv_c13_inp_addr_lres = NULL                => 0.0553434590,
                -0.0006085743));

final_score_98 := __common__( map(
    NULL < nf_m_bureau_adl_fs_notu AND nf_m_bureau_adl_fs_notu <= 56.5 => 0.0459252836,
    nf_m_bureau_adl_fs_notu > 56.5                    => -0.0005181794,
    nf_m_bureau_adl_fs_notu = NULL                    => 0.0001844998,
                       0.0001844998));

final_score_99 := __common__( map(
    NULL < iv_br_source_count AND iv_br_source_count <= 4.5 => 0.0004770993,
    iv_br_source_count > 4.5               => 0.0643336042,
    iv_br_source_count = NULL              => 0.0013265207,
            0.0013265207));

final_score_100 := __common__( map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs <= 267.5 => 0.0060928782,
    rv_c10_m_hdr_fs > 267.5            => -0.0074898136,
    rv_c10_m_hdr_fs = NULL             => -0.0009209168,
                         -0.0009209168));

final_score_101 := __common__( map(
    NULL < nf_fp_srchphonesrchcountmo AND nf_fp_srchphonesrchcountmo <= 0.5 => -0.0047305463,
    nf_fp_srchphonesrchcountmo > 0.5      => 0.0101513000,
    nf_fp_srchphonesrchcountmo = NULL                      => 0.0000384796,
                            0.0000384796));

final_score_102 := __common__( map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-3', '2-0', '2-3', '3-0', '3-1']) => -0.0031951146,
    (rv_e58_br_dead_bus_x_active_phn in ['1-2', '2-1', '2-2', '3-2', '3-3'])         => 0.0800913259,
    rv_e58_br_dead_bus_x_active_phn = ''                          => -0.0026300924,
                    -0.0026300924));

final_score_103 := __common__( map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 55.5 => 0.0341865685,
    rv_c20_m_bureau_adl_fs > 55.5                   => -0.0021157117,
    rv_c20_m_bureau_adl_fs = NULL                   => -0.0013579342,
                     -0.0013579342));

final_score_104 := __common__( map(
    NULL < nf_fp_srchssnsrchcountmo AND nf_fp_srchssnsrchcountmo <= 5.5 => -0.0005244797,
    nf_fp_srchssnsrchcountmo > 5.5                     => 0.0584321998,
    nf_fp_srchssnsrchcountmo = NULL                    => -0.0000091376,
                        -0.0000091376));

final_score_105 := __common__( map(
    NULL < nf_inq_other_count AND nf_inq_other_count <= 1.5 => -0.0097452575,
    nf_inq_other_count > 1.5               => 0.0036356790,
    nf_inq_other_count = NULL              => -0.0008636260,
            -0.0008636260));

final_score_106 := __common__( map(
    NULL < nf_fp_idverrisktype AND nf_fp_idverrisktype <= 1.5 => -0.0066312214,
    nf_fp_idverrisktype > 1.5                => 0.0093309096,
    nf_fp_idverrisktype = NULL               => -0.0011709856,
              -0.0011709856));

final_score_107 := __common__( map(
    NULL < nf_attr_arrest_recency AND nf_attr_arrest_recency <= 79.5 => 0.0553125493,
    nf_attr_arrest_recency > 79.5                   => 0.0192884792,
    nf_attr_arrest_recency = NULL                   => 0.0002119815,
                     0.0012142022));

final_score_108 := __common__( map(
    NULL < nf_fp_srchcomponentrisktype AND nf_fp_srchcomponentrisktype <= 1.5 => -0.0036098555,
    nf_fp_srchcomponentrisktype > 1.5       => 0.0105819174,
    nf_fp_srchcomponentrisktype = NULL      => 0.0006510095,
             0.0006510095));

final_score_109 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 6.5 => -0.0028058819,
    nf_inq_communications_count > 6.5       => 0.0221786001,
    nf_inq_communications_count = NULL      => -0.0019095045,
             -0.0019095045));

final_score_110 := __common__( map(
    NULL < nf_bus_addr_match_count AND nf_bus_addr_match_count <= 63.5 => -0.0001798994,
    nf_bus_addr_match_count > 63.5                    => 0.0764420646,
    nf_bus_addr_match_count = NULL                    => 0.0003229354,
                       0.0003229354));

final_score_111 := __common__( map(
    (rv_d32_criminal_x_felony in ['0-0', '2-0', '2-2'])            => -0.0044285284,
    (rv_d32_criminal_x_felony in ['1-0', '1-1', '2-1', '3-0', '3-1', '3-2', '3-3']) => 0.0108794353,
    rv_d32_criminal_x_felony = ''               => 0.0005875953,
                   0.0005875953));

final_score_112 := __common__( map(
    NULL < nf_fp_sourcerisktype AND nf_fp_sourcerisktype <= 6.5 => -0.0015629690,
    nf_fp_sourcerisktype > 6.5                 => 0.0179956170,
    nf_fp_sourcerisktype = NULL                => -0.0001571797,
                -0.0001571797));

final_score_113 := __common__( map(
    NULL < nf_inq_count AND nf_inq_count <= 28.5 => 0.0001649832,
    nf_inq_count > 28.5         => 0.0236974709,
    nf_inq_count = NULL         => 0.0014817221,
                  0.0014817221));

final_score_114 := __common__( map(
    NULL < nf_attr_arrests AND nf_attr_arrests <= 0.5 => -0.0009589020,
    nf_attr_arrests > 0.5            => 0.0308123264,
    nf_attr_arrests = NULL           => 0.0001683839,
                       0.0001683839));

final_score_115 := __common__( map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr <= 1.5 => -0.0075523502,
    rv_c14_addrs_5yr > 1.5             => 0.0070378541,
    rv_c14_addrs_5yr = NULL            => -0.0015506653,
                         -0.0015506653));

final_score_116 := __common__( map(
    NULL < rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add <= 3.5 => -0.0064428457,
    rv_p88_phn_dst_to_inp_add > 3.5                      => 0.0072730659,
    rv_p88_phn_dst_to_inp_add = NULL                     => 0.0060371865,
                          -0.0008030670));

final_score_117 := __common__( map(
    NULL < nf_fp_srchfraudsrchcountwk AND nf_fp_srchfraudsrchcountwk <= 0.5 => -0.0026660194,
    nf_fp_srchfraudsrchcountwk > 0.5      => 0.0152204828,
    nf_fp_srchfraudsrchcountwk = NULL                      => 0.0003769028,
                            0.0003769028));

final_score_118 := __common__( map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian <= -0.5 => 0.0355012425,
    nf_phone_ver_experian > -0.5                  => -0.0000535281,
    nf_phone_ver_experian = NULL                  => 0.0009991565,
                   0.0009991565));

final_score_119 := __common__( map(
    NULL < nf_inq_other_count24 AND nf_inq_other_count24 <= 2.5 => -0.0057602954,
    nf_inq_other_count24 > 2.5                 => 0.0076802044,
    nf_inq_other_count24 = NULL                => -0.0024711775,
                -0.0024711775));

final_score_120 := __common__( map(
    NULL < iv_estimated_income AND iv_estimated_income <= 120500 => 0.0018702545,
    iv_estimated_income > 120500                => 0.0743815331,
    iv_estimated_income = NULL                  => 0.0026175009,
                 0.0026175009));

final_score_121 := __common__( map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-0', '2-1', '3-0']) => -0.0006268643,
    (rv_d32_criminal_x_felony in ['1-1', '2-2', '3-1', '3-2', '3-3']) => 0.0325624746,
    rv_d32_criminal_x_felony = ''                  => 0.0006851213,
                      0.0006851213));

final_score_122 := __common__( map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-0', '2-1', '2-2', '3-0', '3-2']) => -0.0016762184,
    (rv_d32_criminal_x_felony in ['1-1', '3-1', '3-3'])            => 0.0274844262,
    rv_d32_criminal_x_felony = ''               => -0.0007100295,
                   -0.0007100295));

final_score_123 := __common__( map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-0', '2-2', '3-0', '3-2']) => -0.0018072416,
    (rv_d32_criminal_x_felony in ['1-1', '2-1', '3-1', '3-3'])               => 0.0278106408,
    rv_d32_criminal_x_felony = ''        => -0.0007022698,
            -0.0007022698));

final_score_124 := __common__( map(
    NULL < nf_inq_per_add_nas_479 AND nf_inq_per_add_nas_479 <= 1.5 => -0.0003647811,
    nf_inq_per_add_nas_479 > 1.5                   => 0.0464865497,
    nf_inq_per_add_nas_479 = NULL                  => 0.0003929553,
                    0.0003929553));

final_score_125 := __common__( map(
    NULL < nf_vf_lexid_ssn_hi_risk_ct AND nf_vf_lexid_ssn_hi_risk_ct <= 1.5 => -0.0037834138,
    nf_vf_lexid_ssn_hi_risk_ct > 1.5      => 0.0271284198,
    nf_vf_lexid_ssn_hi_risk_ct = NULL                      => -0.0025091978,
                            -0.0025091978));

final_score_126 := __common__( map(
    NULL < nf_vf_altlexid_phn_hi_risk_ct AND nf_vf_altlexid_phn_hi_risk_ct <= 0.5 => -0.0015339791,
    nf_vf_altlexid_phn_hi_risk_ct > 0.5         => 0.0415428779,
    nf_vf_altlexid_phn_hi_risk_ct = NULL        => -0.0009608198,
                 -0.0009608198));

final_score_127 := __common__( map(
    NULL < nf_inq_prepaidcards_count AND nf_inq_prepaidcards_count <= 1.5 => -0.0009132420,
    nf_inq_prepaidcards_count > 1.5                      => 0.0252168668,
    nf_inq_prepaidcards_count = NULL                     => 0.0003344579,
                          0.0003344579));

final_score_128 := __common__( map(
    NULL < nf_fp_prevaddroccupantowned AND nf_fp_prevaddroccupantowned <= 0.5 => -0.0018594131,
    nf_fp_prevaddroccupantowned > 0.5       => 0.0322971981,
    nf_fp_prevaddroccupantowned = NULL      => -0.0005537527,
             -0.0005537527));

final_score_129 := __common__( map(
    NULL < nf_fp_srchphonesrchcountmo AND nf_fp_srchphonesrchcountmo <= 3.5 => -0.0004910868,
    nf_fp_srchphonesrchcountmo > 3.5      => 0.0420787907,
    nf_fp_srchphonesrchcountmo = NULL                      => 0.0005641352,
                            0.0005641352));

final_score_130 := __common__( map(
    NULL < nf_inq_other_count AND nf_inq_other_count <= 1.5 => -0.0065341434,
    nf_inq_other_count > 1.5               => 0.0069164157,
    nf_inq_other_count = NULL              => 0.0022919085,
            0.0022919085));

final_score_131 := __common__( map(
    NULL < iv_estimated_income AND iv_estimated_income <= 119500 => -0.0019607664,
    iv_estimated_income > 119500                => 0.0772531015,
    iv_estimated_income = NULL                  => -0.0011032275,
                 -0.0011032275));

final_score_132 := __common__( map(
    (iv_c22_addr_ver_sources in ['ADDR NOT VERD', 'NONPHN ONLY', 'PHN & NONPHN']) => -0.0015080422,
    (iv_c22_addr_ver_sources in ['PHN ONLY'])                    => 0.0312199183,
    iv_c22_addr_ver_sources = ''              => 0.0100467644,
                 -0.0006026702));

final_score_133 := __common__( map(
    NULL < nf_inq_ssns_per_addr AND nf_inq_ssns_per_addr <= 2.5 => -0.0010962166,
    nf_inq_ssns_per_addr > 2.5                 => 0.0122714869,
    nf_inq_ssns_per_addr = NULL                => 0.0335488162,
                0.0012847413));

final_score_134 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 6.5 => -0.0010646721,
    nf_inq_communications_count > 6.5       => 0.0210988272,
    nf_inq_communications_count = NULL      => -0.0002522610,
             -0.0002522610));

final_score_135 := __common__( map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian <= 0.5 => 0.0085711630,
    nf_phone_ver_experian > 0.5                  => -0.0044374889,
    nf_phone_ver_experian = NULL                 => -0.0002194755,
                  -0.0002194755));

final_score_136 := __common__( map(
    NULL < rv_d31_attr_bankruptcy_recency AND rv_d31_attr_bankruptcy_recency <= 79.5 => 0.0049963843,
    rv_d31_attr_bankruptcy_recency > 79.5          => -0.0144764317,
    rv_d31_attr_bankruptcy_recency = NULL          => 0.0008869521,
                    0.0008869521));

final_score_137 := __common__( map(
    NULL < iv_d34_liens_unrel_lt_ct AND iv_d34_liens_unrel_lt_ct <= 1.5 => 0.0008035623,
    iv_d34_liens_unrel_lt_ct > 1.5                     => 0.0750419797,
    iv_d34_liens_unrel_lt_ct = NULL                    => 0.0013846091,
                        0.0013846091));

final_score_138 := __common__( map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '1-1', '2-1', '3-0', '3-2']) => -0.0031747744,
    (rv_d32_criminal_x_felony in ['2-0', '2-2', '3-1', '3-3'])               => 0.0181067959,
    rv_d32_criminal_x_felony = ''        => -0.0012062639,
            -0.0012062639));

final_score_139 := __common__( map(
    NULL < nf_fp_srchcomponentrisktype AND nf_fp_srchcomponentrisktype <= 5.5 => -0.0009003872,
    nf_fp_srchcomponentrisktype > 5.5       => 0.0238608965,
    nf_fp_srchcomponentrisktype = NULL      => 0.0003854936,
             0.0003854936));

final_score_140 := __common__( map(
    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency <= 18 => 0.0092899389,
    rv_c13_attr_addrs_recency > 18                      => -0.0041820360,
    rv_c13_attr_addrs_recency = NULL                    => -0.0009256351,
                         -0.0009256351));

final_score_141 := __common__( map(
    NULL < nf_m_bureau_adl_fs_notu AND nf_m_bureau_adl_fs_notu <= 56.5 => 0.0472888343,
    nf_m_bureau_adl_fs_notu > 56.5                    => -0.0009818197,
    nf_m_bureau_adl_fs_notu = NULL                    => -0.0002388068,
                       -0.0002388068));

final_score_142 := __common__( map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian <= 0.5 => 0.0098377209,
    nf_phone_ver_experian > 0.5                  => -0.0033986352,
    nf_phone_ver_experian = NULL                 => 0.0008119906,
                  0.0008119906));

final_score_143 := __common__( map(
    NULL < rv_i60_inq_prepaidcards_recency AND rv_i60_inq_prepaidcards_recency <= 9 => -0.0023551279,
    rv_i60_inq_prepaidcards_recency > 9           => 0.0179857570,
    rv_i60_inq_prepaidcards_recency = NULL        => 0.0002296108,
                   0.0002296108));

final_score_144 := __common__( map(
    NULL < nf_inq_count AND nf_inq_count <= 27.5 => -0.0031038629,
    nf_inq_count > 27.5         => 0.0208349589,
    nf_inq_count = NULL         => -0.0015360497,
                  -0.0015360497));

final_score_145 := __common__( map(
    NULL < nf_vf_lexid_addr_hi_risk_ct AND nf_vf_lexid_addr_hi_risk_ct <= 0.5 => -0.0016371950,
    nf_vf_lexid_addr_hi_risk_ct > 0.5       => 0.0209180764,
    nf_vf_lexid_addr_hi_risk_ct = NULL      => 0.0000663665,
             0.0000663665));

final_score_146 := __common__( map(
    NULL < nf_pb_retail_combo_cnt AND nf_pb_retail_combo_cnt <= 0.5 => 0.0105489560,
    nf_pb_retail_combo_cnt > 0.5                   => -0.0029460178,
    nf_pb_retail_combo_cnt = NULL                  => -0.0000857945,
                    -0.0000857945));

final_score_147 := __common__( map(
    NULL < nf_pb_retail_combo_cnt AND nf_pb_retail_combo_cnt <= 1.5 => 0.0047714973,
    nf_pb_retail_combo_cnt > 1.5                   => -0.0090198126,
    nf_pb_retail_combo_cnt = NULL                  => -0.0021412506,
                    -0.0021412506));

final_score_148 := __common__( map(
    NULL < nf_fp_srchphonesrchcountmo AND nf_fp_srchphonesrchcountmo <= 0.5 => -0.0031914279,
    nf_fp_srchphonesrchcountmo > 0.5      => 0.0099609800,
    nf_fp_srchphonesrchcountmo = NULL                      => 0.0009776760,
                            0.0009776760));

final_score_149 := __common__( map(
    NULL < nf_inq_per_addr AND nf_inq_per_addr <= 22.5 => -0.0012132584,
    nf_inq_per_addr > 22.5            => 0.0479653201,
    nf_inq_per_addr = NULL            => 0.0267017819,
                        -0.0004668491));

final_score_150 := __common__( map(
    NULL < nf_pb_retail_combo_cnt AND nf_pb_retail_combo_cnt <= 1.5 => 0.0079273189,
    nf_pb_retail_combo_cnt > 1.5                   => -0.0062311530,
    nf_pb_retail_combo_cnt = NULL                  => 0.0008563952,
                    0.0008563952));

final_score_151 := __common__( map(
    NULL < nf_fp_prevaddroccupantowned AND nf_fp_prevaddroccupantowned <= 0.5 => -0.0020074454,
    nf_fp_prevaddroccupantowned > 0.5       => 0.0345993218,
    nf_fp_prevaddroccupantowned = NULL      => -0.0006657861,
             -0.0006657861));

final_score_152 := __common__( map(
    NULL < nf_pb_retail_combo_cnt AND nf_pb_retail_combo_cnt <= 2.5 => 0.0011555899,
    nf_pb_retail_combo_cnt > 2.5                   => -0.0112766794,
    nf_pb_retail_combo_cnt = NULL                  => -0.0033149679,
                    -0.0033149679));

final_score_153 := __common__( map(
    NULL < nf_addrs_per_ssn AND nf_addrs_per_ssn <= 29.5 => -0.0027317951,
    nf_addrs_per_ssn > 29.5             => 0.0323720365,
    nf_addrs_per_ssn = NULL             => -0.0019581191,
         -0.0019581191));

final_score_154 := __common__( map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-3', '2-0', '2-3', '3-3']) => -0.0028554505,
    (rv_e58_br_dead_bus_x_active_phn in ['1-1', '1-2', '2-1', '2-2', '3-0', '3-1', '3-2'])               => 0.0506050760,
    rv_e58_br_dead_bus_x_active_phn = ''            => -0.0020044348,
                       -0.0020044348));

final_score_155 := __common__( map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl <= 1.5 => -0.0000024402,
    rv_i62_inq_num_names_per_adl > 1.5        => 0.0157851062,
    rv_i62_inq_num_names_per_adl = NULL       => 0.0026452887,
               0.0026452887));

final_score_156 := __common__( map(
    NULL < rv_i60_inq_retpymt_count12 AND rv_i60_inq_retpymt_count12 <= 0.5 => -0.0022171529,
    rv_i60_inq_retpymt_count12 > 0.5      => 0.0274871537,
    rv_i60_inq_retpymt_count12 = NULL                      => -0.0011283308,
                            -0.0011283308));

final_score_157 := __common__( map(
    NULL < nf_attr_arrest_recency AND nf_attr_arrest_recency <= 79.5 => 0.0457961041,
    nf_attr_arrest_recency > 79.5                   => 0.0040557322,
    nf_attr_arrest_recency = NULL                   => -0.0014666492,
                     -0.0008280810));

final_score_158 := __common__( map(
    NULL < nf_inq_count AND nf_inq_count <= 32.5 => -0.0011979989,
    nf_inq_count > 32.5         => 0.0265960950,
    nf_inq_count = NULL         => -0.0001539531,
                  -0.0001539531));

final_score_159 := __common__( map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian <= 0.5 => 0.0075660952,
    nf_phone_ver_experian > 0.5                  => -0.0045828971,
    nf_phone_ver_experian = NULL                 => -0.0006098311,
                  -0.0006098311));

final_score_160 := __common__( map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-2', '0-3', '2-2', '3-0', '3-3'])         => -0.0339506652,
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '1-0', '1-1', '1-2', '1-3', '2-0', '2-1', '2-3', '3-1', '3-2']) => 0.0019440796,
    rv_e58_br_dead_bus_x_active_phn = ''                          => 0.0004457338,
                    0.0004457338));

final_score_161 := __common__( map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 249.5 => 0.0063576618,
    rv_c20_m_bureau_adl_fs > 249.5                   => -0.0059275549,
    rv_c20_m_bureau_adl_fs = NULL                    => -0.0003008359,
                      -0.0003008359));

final_score_162 := __common__( map(
    NULL < iv_estimated_income AND iv_estimated_income <= 25500 => 0.0247266445,
    iv_estimated_income > 25500                => -0.0012263034,
    iv_estimated_income = NULL                 => -0.0000820174,
                -0.0000820174));

final_score_163 := __common__( map(
    NULL < rv_d34_unrel_lien60_count AND rv_d34_unrel_lien60_count <= 2.5 => -0.0017054804,
    rv_d34_unrel_lien60_count > 2.5                      => 0.0296795364,
    rv_d34_unrel_lien60_count = NULL                     => -0.0006000859,
                          -0.0006000859));

final_score_164 := __common__( map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-0', '3-0', '3-2', '3-3']) => -0.0015517084,
    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1'])               => 0.0281373822,
    rv_d32_criminal_x_felony = ''        => -0.0007539061,
            -0.0007539061));

final_score_165 := __common__( map(
    NULL < iv_estimated_income AND iv_estimated_income <= 120500 => -0.0000928597,
    iv_estimated_income > 120500                => 0.0654388284,
    iv_estimated_income = NULL                  => 0.0005567305,
                 0.0005567305));

final_score_166 := __common__( map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-3', '2-0', '2-2', '2-3', '3-0']) => -0.0011586808,
    (rv_e58_br_dead_bus_x_active_phn in ['1-2', '2-1', '3-1', '3-2', '3-3'])         => 0.0718651932,
    rv_e58_br_dead_bus_x_active_phn = ''                          => -0.0006536880,
                    -0.0006536880));

final_score_167 := __common__( map(
    (iv_d34_liens_unrel_x_rel in ['0-1', '1-1', '2-0', '2-1', '2-2', '3-2']) => -0.0087362943,
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-2', '1-0', '1-2', '3-0', '3-1']) => 0.0035198810,
    iv_d34_liens_unrel_x_rel = ''        => 0.0000112629,
            0.0000112629));

final_score_168 := __common__( map(
    NULL < nf_inq_count24 AND nf_inq_count24 <= 11.5 => -0.0010751707,
    nf_inq_count24 > 11.5           => 0.0192711167,
    nf_inq_count24 = NULL           => 0.0006979956,
                      0.0006979956));

final_score_169 := __common__( map(
    NULL < iv_estimated_income AND iv_estimated_income <= 25500 => 0.0245620280,
    iv_estimated_income > 25500                => -0.0009923391,
    iv_estimated_income = NULL                 => 0.0000945133,
                0.0000945133));

final_score_170 := __common__( map(
    NULL < nf_vf_hi_risk_ct AND nf_vf_hi_risk_ct <= 3.5 => -0.0035967747,
    nf_vf_hi_risk_ct > 3.5             => 0.0287864414,
    nf_vf_hi_risk_ct = NULL            => -0.0030856387,
                         -0.0030856387));

final_score_171 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 9.5 => -0.0010957500,
    nf_inq_communications_count > 9.5       => 0.0329736451,
    nf_inq_communications_count = NULL      => -0.0006247241,
             -0.0006247241));

final_score_172 := __common__( map(
    NULL < nf_fp_srchfraudsrchcountmo AND nf_fp_srchfraudsrchcountmo <= 4.5 => 0.0012534981,
    nf_fp_srchfraudsrchcountmo > 4.5      => 0.0325034773,
    nf_fp_srchfraudsrchcountmo = NULL                      => 0.0019506601,
                            0.0019506601));

final_score_173 := __common__( map(
    NULL < nf_inq_prepaidcards_count24 AND nf_inq_prepaidcards_count24 <= 0.5 => 0.0000414563,
    nf_inq_prepaidcards_count24 > 0.5       => 0.0535716858,
    nf_inq_prepaidcards_count24 = NULL      => 0.0004953391,
             0.0004953391));

final_score_174 := __common__( map(
    NULL < rv_d31_attr_bankruptcy_recency AND rv_d31_attr_bankruptcy_recency <= 79.5 => 0.0050811745,
    rv_d31_attr_bankruptcy_recency > 79.5          => -0.0115752344,
    rv_d31_attr_bankruptcy_recency = NULL          => 0.0016812423,
                    0.0016812423));

final_score_175 := __common__( map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 30.5 => -0.0000457147,
    rv_d30_derog_count > 30.5               => 0.0473094631,
    rv_d30_derog_count = NULL               => 0.0004855330,
             0.0004855330));

final_score_176 := __common__( map(
    NULL < nf_inq_other_count24 AND nf_inq_other_count24 <= 0.5 => -0.0086235795,
    nf_inq_other_count24 > 0.5                 => 0.0035799693,
    nf_inq_other_count24 = NULL                => -0.0010508842,
                -0.0010508842));

final_score_177 := __common__( map(
    NULL < nf_inq_count AND nf_inq_count <= 32.5 => -0.0018138363,
    nf_inq_count > 32.5         => 0.0255196678,
    nf_inq_count = NULL         => -0.0008080889,
                  -0.0008080889));

final_score_178 := __common__( map(
    NULL < nf_fp_srchunvrfdssncount AND nf_fp_srchunvrfdssncount <= 1.5 => -0.0013688994,
    nf_fp_srchunvrfdssncount > 1.5                     => 0.0338416443,
    nf_fp_srchunvrfdssncount = NULL                    => -0.0008361022,
                        -0.0008361022));

final_score_179 := __common__( map(
    NULL < nf_fp_idverrisktype AND nf_fp_idverrisktype <= 1.5 => -0.0044709509,
    nf_fp_idverrisktype > 1.5                => 0.0085919549,
    nf_fp_idverrisktype = NULL               => 0.0001112089,
              0.0001112089));

final_score_180 := __common__( map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 11.5 => -0.0021658451,
    rv_d30_derog_count > 11.5               => 0.0164431334,
    rv_d30_derog_count = NULL               => -0.0000026879,
             -0.0000026879));

final_score_181 := __common__( map(
    NULL < iv_dob_src_ct AND iv_dob_src_ct <= 8.5 => 0.0104420704,
    iv_dob_src_ct > 8.5          => -0.0022677911,
    iv_dob_src_ct = NULL         => 0.0014199756,
                   0.0014199756));

final_score_182 := __common__( map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-1', '2-2'])               => -0.0035579842,
    (rv_d32_criminal_x_felony in ['1-1', '2-0', '3-0', '3-1', '3-2', '3-3']) => 0.0094690673,
    rv_d32_criminal_x_felony = ''        => -0.0002855046,
            -0.0002855046));

final_score_183 := __common__( map(
    NULL < nf_m_bureau_adl_fs_all AND nf_m_bureau_adl_fs_all <= 370.5 => 0.0007060798,
    nf_m_bureau_adl_fs_all > 370.5                   => -0.0148950512,
    nf_m_bureau_adl_fs_all = NULL                    => -0.0021345591,
                      -0.0021345591));

final_score_184 := __common__( map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-2', '3-0', '3-2']) => -0.0010999848,
    (rv_d32_criminal_x_felony in ['2-1', '3-1', '3-3'])            => 0.0286010186,
    rv_d32_criminal_x_felony = ''               => -0.0001467628,
                   -0.0001467628));

final_score_185 := __common__( map(
    NULL < nf_vf_altlexid_phn_hi_risk_ct AND nf_vf_altlexid_phn_hi_risk_ct <= 0.5 => -0.0003124634,
    nf_vf_altlexid_phn_hi_risk_ct > 0.5         => 0.0414763117,
    nf_vf_altlexid_phn_hi_risk_ct = NULL        => 0.0003473020,
                 0.0003473020));

final_score_186 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 9.5 => 0.0000011552,
    nf_inq_communications_count > 9.5       => 0.0293167988,
    nf_inq_communications_count = NULL      => 0.0004103352,
             0.0004103352));

final_score_187 := __common__( map(
    NULL < nf_fp_srchcomponentrisktype AND nf_fp_srchcomponentrisktype <= 8.5 => -0.0003700050,
    nf_fp_srchcomponentrisktype > 8.5       => 0.0366622499,
    nf_fp_srchcomponentrisktype = NULL      => 0.0002242503,
             0.0002242503));

final_score_188 := __common__( map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl <= 11.5 => -0.0026898943,
    iv_c14_addrs_per_adl > 11.5                 => 0.0141439773,
    iv_c14_addrs_per_adl = NULL                 => -0.0005752297,
                 -0.0005752297));

final_score_189 := __common__( map(
    NULL < rv_i60_inq_other_count12 AND rv_i60_inq_other_count12 <= 0.5 => -0.0064319733,
    rv_i60_inq_other_count12 > 0.5                     => 0.0070285612,
    rv_i60_inq_other_count12 = NULL                    => -0.0002407595,
                        -0.0002407595));

final_score_190 := __common__( map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 5.5 => -0.0052146861,
    rv_d30_derog_count > 5.5               => 0.0075220491,
    rv_d30_derog_count = NULL              => -0.0012820156,
            -0.0012820156));

final_score_191 := __common__( map(
    NULL < nf_m_bureau_adl_fs_notu AND nf_m_bureau_adl_fs_notu <= 89.5 => 0.0195121155,
    nf_m_bureau_adl_fs_notu > 89.5                    => -0.0018968699,
    nf_m_bureau_adl_fs_notu = NULL                    => -0.0006986371,
                       -0.0006986371));

final_score_192 := __common__( map(
    NULL < nf_fp_prevaddroccupantowned AND nf_fp_prevaddroccupantowned <= 0.5 => -0.0016604841,
    nf_fp_prevaddroccupantowned > 0.5       => 0.0300919188,
    nf_fp_prevaddroccupantowned = NULL      => -0.0005005789,
             -0.0005005789));

final_score_193 := __common__( map(
    rv_d33_eviction_recency = ' '                    => 0.0016481127,
    NULL < (Real)rv_d33_eviction_recency AND (Real)rv_d33_eviction_recency <= 98.5 => 0.0030717118,
    (Real)rv_d33_eviction_recency > 98.5                    => -0.0231061237,
                       0.0016481127));

final_score_194 := __common__( map(
    (iv_d34_liens_unrel_x_rel in ['0-1', '1-1', '1-2', '2-2', '3-1', '3-2']) => -0.0105631711,
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-2', '1-0', '2-0', '2-1', '3-0']) => 0.0027526002,
    iv_d34_liens_unrel_x_rel = ''        => -0.0008920819,
            -0.0008920819));

final_score_195 := __common__( map(
    NULL < nf_mos_liens_unrel_sc_lseen AND nf_mos_liens_unrel_sc_lseen <= 168.5 => -0.0006693086,
    nf_mos_liens_unrel_sc_lseen > 168.5       => -0.0324702698,
    nf_mos_liens_unrel_sc_lseen = NULL        => -0.0015776704,
               -0.0015776704));

final_score_196 := __common__( map(
    NULL < rv_l79_adls_per_apt_addr AND rv_l79_adls_per_apt_addr <= 9.5 => 0.0011870508,
    rv_l79_adls_per_apt_addr > 9.5                     => -0.0426943579,
    rv_l79_adls_per_apt_addr = NULL                    => 0.0006865681,
                        0.0006865681));

final_score_197 := __common__( map(
    NULL < rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add <= 460 => -0.0029333873,
    rv_p88_phn_dst_to_inp_add > 460                      => 0.0437397076,
    rv_p88_phn_dst_to_inp_add = NULL                     => 0.0043861817,
                          -0.0003975911));

final_score_198 := __common__( map(
    (iv_d34_liens_unrel_x_rel in ['0-1', '1-1', '2-0', '2-1'])            => -0.0120188039,
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-2', '1-0', '1-2', '2-2', '3-0', '3-1', '3-2']) => 0.0042340121,
    iv_d34_liens_unrel_x_rel = ''                      => 0.0016004834,
                          0.0016004834));

final_score_199 := __common__( map(
    (iv_d34_liens_unrel_x_rel in ['0-0', '1-0', '1-1', '1-2', '2-0', '2-1', '2-2', '3-2']) => -0.0037210652,
    (iv_d34_liens_unrel_x_rel in ['0-1', '0-2', '3-0', '3-1'])            => 0.0109090593,
    iv_d34_liens_unrel_x_rel = ''                      => -0.0013864302,
                          -0.0013864302));

final_score_200 := __common__( map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr <= 6.5 => -0.0014959757,
    rv_c14_addrs_5yr > 6.5             => 0.0368569467,
    rv_c14_addrs_5yr = NULL            => -0.0009305641,
                         -0.0009305641));

final_score_201 := __common__( map(
    NULL < rv_i61_inq_collection_recency AND rv_i61_inq_collection_recency <= 2 => 0.0109028964,
    rv_i61_inq_collection_recency > 2         => -0.0034342271,
    rv_i61_inq_collection_recency = NULL      => -0.0011728334,
               -0.0011728334));

final_score_202 := __common__( map(
    NULL < nf_fp_srchcomponentrisktype AND nf_fp_srchcomponentrisktype <= 6.5 => 0.0012541631,
    nf_fp_srchcomponentrisktype > 6.5       => 0.0224971396,
    nf_fp_srchcomponentrisktype = NULL      => 0.0019857240,
             0.0019857240));

final_score_203 := __common__( map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec <= 0.5 => -0.0036075695,
    rv_f03_input_add_not_most_rec > 0.5         => 0.0097386982,
    rv_f03_input_add_not_most_rec = NULL        => -0.0014724467,
                 -0.0014724467));

final_score_204 := __common__( map(
    NULL < nf_liens_unrel_sc_total_amt AND nf_liens_unrel_sc_total_amt <= 8249.5 => -0.0011279773,
    nf_liens_unrel_sc_total_amt > 8249.5       => 0.0444074007,
    nf_liens_unrel_sc_total_amt = NULL         => -0.0005042050,
                -0.0005042050));

final_score_205 := __common__( map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => 0.0005978945,
    rv_c19_add_prison_hist > 0.5                   => 0.0485077011,
    rv_c19_add_prison_hist = NULL                  => 0.0010542974,
                    0.0010542974));

final_score_206 := __common__( map(
    NULL < nf_fp_sourcerisktype AND nf_fp_sourcerisktype <= 6.5 => -0.0034001625,
    nf_fp_sourcerisktype > 6.5                 => 0.0185560259,
    nf_fp_sourcerisktype = NULL                => -0.0019165589,
                -0.0019165589));

final_score_207 := __common__( map(
    NULL < iv_estimated_income AND iv_estimated_income <= 123500 => -0.0014861446,
    iv_estimated_income > 123500                => 0.0595322516,
    iv_estimated_income = NULL                  => -0.0010722447,
                 -0.0010722447));

final_score_208 := __common__( map(
    NULL < nf_inq_communications_count AND nf_inq_communications_count <= 10.5 => 0.0004057416,
    nf_inq_communications_count > 10.5       => 0.0466512083,
    nf_inq_communications_count = NULL       => 0.0007797105,
              0.0007797105));

final_score_209 := __common__( map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl <= 2.5 => -0.0012467597,
    rv_i62_inq_phones_per_adl > 2.5                      => 0.0192953275,
    rv_i62_inq_phones_per_adl = NULL                     => 0.0002299122,
                          0.0002299122));

final_score_210 := __common__( map(
    NULL < nf_inq_other_count AND nf_inq_other_count <= 1.5 => -0.0084968385,
    nf_inq_other_count > 1.5               => 0.0033133992,
    nf_inq_other_count = NULL              => -0.0006577624,
            -0.0006577624));

final_score_211 := __common__( map(
    NULL < rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add <= 149.5 => -0.0026751564,
    rv_p88_phn_dst_to_inp_add > 149.5                      => -0.0166275997,
    rv_p88_phn_dst_to_inp_add = NULL      => 0.0076939166,
                            -0.0001050899));

final_score_212 := __common__( map(
    NULL < iv_br_source_count AND iv_br_source_count <= 4.5 => 0.0003348859,
    iv_br_source_count > 4.5               => 0.0528101228,
    iv_br_source_count = NULL              => 0.0009648078,
            0.0009648078));

final_score_213 := __common__( map(
    NULL < rv_d32_criminal_count AND rv_d32_criminal_count <= 3.5 => -0.0014175789,
    rv_d32_criminal_count > 3.5                  => 0.0169278686,
    rv_d32_criminal_count = NULL                 => 0.0010832028,
                  0.0010832028));

final_score_214 := __common__( map(
    NULL < nf_mos_liens_unrel_sc_lseen AND nf_mos_liens_unrel_sc_lseen <= 167.5 => -0.0004695191,
    nf_mos_liens_unrel_sc_lseen > 167.5       => -0.0370071476,
    nf_mos_liens_unrel_sc_lseen = NULL        => -0.0014991509,
               -0.0014991509));

final_score_215 := __common__( map(
    NULL < rv_d31_attr_bankruptcy_recency AND rv_d31_attr_bankruptcy_recency <= 79.5 => 0.0028561219,
    rv_d31_attr_bankruptcy_recency > 79.5          => -0.0122452648,
    rv_d31_attr_bankruptcy_recency = NULL          => -0.0002922168,
                    -0.0002922168));

final_score_216 := __common__( map(
    NULL < nf_fp_sourcerisktype AND nf_fp_sourcerisktype <= 1.5 => 0.0298172096,
    nf_fp_sourcerisktype > 1.5                 => -0.0011242941,
    nf_fp_sourcerisktype = NULL                => 0.0000303601,
                0.0000303601));

final_score_217 := __common__( map(
    NULL < nf_fp_srchcomponentrisktype AND nf_fp_srchcomponentrisktype <= 1.5 => -0.0034488259,
    nf_fp_srchcomponentrisktype > 1.5       => 0.0072726206,
    nf_fp_srchcomponentrisktype = NULL      => -0.0002806489,
             -0.0002806489));

final_score_218 := __common__( map(
    NULL < rv_i61_inq_collection_recency AND rv_i61_inq_collection_recency <= 61.5 => 0.0054010322,
    rv_i61_inq_collection_recency > 61.5         => -0.0060122792,
    rv_i61_inq_collection_recency = NULL         => -0.0002594580,
                  -0.0002594580));

final_score_219 := __common__( map(
    NULL < nf_phones_per_addr_curr AND nf_phones_per_addr_curr <= 91.5 => -0.0005308705,
    nf_phones_per_addr_curr > 91.5                    => 0.0414778690,
    nf_phones_per_addr_curr = NULL                    => -0.0002223068,
                       -0.0002223068));

final_score_220 := __common__( map(
    NULL < nf_inq_banking_count24 AND nf_inq_banking_count24 <= 2.5 => -0.0014444468,
    nf_inq_banking_count24 > 2.5                   => 0.0350072062,
    nf_inq_banking_count24 = NULL                  => -0.0006170808,
                    -0.0006170808));

final_score_221 := __common__( map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 19.5 => -0.0006528895,
    rv_d30_derog_count > 19.5               => 0.0259599895,
    rv_d30_derog_count = NULL               => 0.0003539905,
             0.0003539905));

final_score_222 := __common__( map(
    NULL < nf_vf_lexid_phn_lo_risk_ct AND nf_vf_lexid_phn_lo_risk_ct <= 5.5 => -0.0019423175,
    nf_vf_lexid_phn_lo_risk_ct > 5.5      => 0.0359656815,
    nf_vf_lexid_phn_lo_risk_ct = NULL                      => -0.0010967308,
                            -0.0010967308));

final_score_223 := __common__( map(
    (iv_d34_liens_unrel_x_rel in ['1-1', '2-1'])                       => -0.0180491623,
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-0', '1-2', '2-0', '2-2', '3-0', '3-1', '3-2']) => 0.0013614639,
    iv_d34_liens_unrel_x_rel = ''                   => -0.0002084015,
                       -0.0002084015));

final_score_224 := __common__( map(
    (rv_d32_criminal_x_felony in ['0-0', '2-2', '3-2', '3-3'])               => -0.0037831498,
    (rv_d32_criminal_x_felony in ['1-0', '1-1', '2-0', '2-1', '3-0', '3-1']) => 0.0078289789,
    rv_d32_criminal_x_felony = ''        => 0.0004723583,
            0.0004723583));

final_score_225 := __common__( map(
    rv_d33_eviction_recency = ' '                   => -0.0016179963,
    NULL < (Real)rv_d33_eviction_recency AND (Real)rv_d33_eviction_recency <= 1.5 => -0.0048946067,
    (Real)rv_d33_eviction_recency > 1.5                    => 0.0067690913,   
                      -0.0016179963));

final_score_226 := __common__( map(
    NULL < nf_inq_prepaidcards_count AND nf_inq_prepaidcards_count <= 1.5 => -0.0022909594,
    nf_inq_prepaidcards_count > 1.5                      => 0.0178747557,
    nf_inq_prepaidcards_count = NULL                     => -0.0013149020,
                          -0.0013149020));

final_score_227 := __common__( map(
    (nf_historic_x_current_ct in ['1-0', '2-1', '2-2', '3-1', '3-2']) => -0.0065736250,
    (nf_historic_x_current_ct in ['0-0', '1-1', '2-0', '3-0', '3-3']) => 0.0049237429,
    nf_historic_x_current_ct = ''                  => 0.0015132270,
                      0.0015132270));

final_score_228 := __common__( map(
    (iv_c22_addr_ver_sources in ['ADDR NOT VERD', 'NONPHN ONLY', 'PHN & NONPHN']) => -0.0014845967,
    (iv_c22_addr_ver_sources in ['PHN ONLY'])                    => 0.0284846217,
    iv_c22_addr_ver_sources = ''              => -0.0006902414,
                 -0.0006902414));

final_score_229 := __common__( map(
    NULL < nf_bus_addr_match_count AND nf_bus_addr_match_count <= 75.5 => -0.0007178928,
    nf_bus_addr_match_count > 75.5                    => 0.0714785876,
    nf_bus_addr_match_count = NULL                    => 0.0247036999,
                       -0.0000614722));

final_score_230 := __common__( map(
    NULL < iv_estimated_income AND iv_estimated_income <= 34500 => 0.0103686651,
    iv_estimated_income > 34500                => -0.0038790376,
    iv_estimated_income = NULL                 => -0.0002599538,
                -0.0002599538));

final_score_231 := __common__( map(
    NULL < nf_fp_srchcomponentrisktype AND nf_fp_srchcomponentrisktype <= 1.5 => -0.0024017793,
    nf_fp_srchcomponentrisktype > 1.5       => 0.0080541545,
    nf_fp_srchcomponentrisktype = NULL      => 0.0007157718,
             0.0007157718));

final_score_232 := __common__( map(
    NULL < nf_pb_retail_combo_cnt AND nf_pb_retail_combo_cnt <= 1.5 => 0.0060177452,
    nf_pb_retail_combo_cnt > 1.5                   => -0.0059727529,
    nf_pb_retail_combo_cnt = NULL                  => -0.0000440047,
                    -0.0000440047));

final_score_233 := __common__( map(
    NULL < iv_estimated_income AND iv_estimated_income <= 118500 => -0.0001745781,
    iv_estimated_income > 118500                => 0.0484053598,
    iv_estimated_income = NULL                  => 0.0003513983,
                 0.0003513983));

final_score_234 := __common__( map(
    NULL < nf_inq_count AND nf_inq_count <= 26.5 => 0.0013086241,
    nf_inq_count > 26.5         => 0.0184083461,
    nf_inq_count = NULL         => 0.0025489953,
                  0.0025489953));

final_score_235 := __common__( map(
    NULL < nf_pb_retail_combo_cnt AND nf_pb_retail_combo_cnt <= 1.5 => 0.0041099378,
    nf_pb_retail_combo_cnt > 1.5                   => -0.0083125193,
    nf_pb_retail_combo_cnt = NULL                  => -0.0021969229,
                    -0.0021969229));

final_score_236 := __common__( map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-3', '2-0', '3-2', '3-3']) => -0.0000681425,
    (rv_e58_br_dead_bus_x_active_phn in ['1-2', '2-1', '2-2', '2-3', '3-0', '3-1'])            => 0.0551499579,
    rv_e58_br_dead_bus_x_active_phn = ''                   => 0.0004289933,
                              0.0004289933));

final_score_237 := __common__( map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen <= 22.5 => -0.0034450745,
    iv_mos_src_voter_adl_lseen > 22.5      => 0.0119308234,
    iv_mos_src_voter_adl_lseen = NULL      => -0.0011889267,
            -0.0011889267));

final_score_238 := __common__( map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 114.5 => -0.0046856568,
    iv_prv_addr_lres > 114.5             => 0.0068509902,
    iv_prv_addr_lres = NULL              => 0.0047716976,
          -0.0012214071));

final_score_239 := __common__( map(
    NULL < nf_pb_retail_combo_cnt AND nf_pb_retail_combo_cnt <= 0.5 => 0.0078955902,
    nf_pb_retail_combo_cnt > 0.5                   => -0.0033677623,
    nf_pb_retail_combo_cnt = NULL                  => -0.0009655210,
                    -0.0009655210));

final_score_240 := __common__( map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-0', '3-0', '3-2']) => -0.0013740297,
    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-3']) => 0.0263014502,
    rv_d32_criminal_x_felony = ''                  => -0.0003885848,
                      -0.0003885848));

final_score_241 := __common__( map(
    NULL < nf_mos_inq_banko_om_lseen AND nf_mos_inq_banko_om_lseen <= -0.5 => -0.0053880550,
    nf_mos_inq_banko_om_lseen > -0.5                      => 0.0057323519,
    nf_mos_inq_banko_om_lseen = NULL                      => -0.0008563369,
                           -0.0008563369));

final_score_242 := __common__( map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 5.5 => -0.0029553057,
    rv_d30_derog_count > 5.5               => 0.0075459593,
    rv_d30_derog_count = NULL              => 0.0003866287,
            0.0003866287));

final_score_243 := __common__( map(
    NULL < rv_i61_inq_collection_recency AND rv_i61_inq_collection_recency <= 61.5 => 0.0061809128,
    rv_i61_inq_collection_recency > 61.5         => -0.0048358837,
    rv_i61_inq_collection_recency = NULL         => 0.0007436602,
                  0.0007436602));

final_score_244 := __common__( map(
    NULL < nf_inq_per_addr AND nf_inq_per_addr <= 17.5 => 0.0008078355,
    nf_inq_per_addr > 17.5            => 0.0285299794,
    nf_inq_per_addr = NULL            => 0.0017016294,
                        0.0017016294));

final_score_245 := __common__( map(
    NULL < nf_vf_altlexid_phn_hi_risk_ct AND nf_vf_altlexid_phn_hi_risk_ct <= 0.5 => -0.0001966726,
    nf_vf_altlexid_phn_hi_risk_ct > 0.5         => 0.0426934214,
    nf_vf_altlexid_phn_hi_risk_ct = NULL        => 0.0003740017,
                 0.0003740017));

final_score_246 := __common__( map(
    NULL < nf_fp_srchphonesrchcountwk AND nf_fp_srchphonesrchcountwk <= 0.5 => -0.0008326560,
    nf_fp_srchphonesrchcountwk > 0.5      => 0.0120274826,
    nf_fp_srchphonesrchcountwk = NULL                      => 0.0010929262,
                            0.0010929262));

final_score_247 := __common__( map(
    NULL < iv_estimated_income AND iv_estimated_income <= 99500 => -0.0016835394,
    iv_estimated_income > 99500                => 0.0262630061,
    iv_estimated_income = NULL                 => -0.0005130225,
                -0.0005130225));

final_score_248 := __common__( map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl <= 2.5 => 0.0152218850,
    iv_c14_addrs_per_adl > 2.5                 => -0.0012960171,
    iv_c14_addrs_per_adl = NULL                => 0.0003200052,
                0.0003200052));

final_score_249 := __common__( map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 25.5 => 0.0005774933,
    rv_d30_derog_count > 25.5               => 0.0344241896,
    rv_d30_derog_count = NULL               => 0.0011736190,
             0.0011736190));

final_score_250 := __common__( map(
    NULL < nf_inq_per_sfd_addr AND nf_inq_per_sfd_addr <= 16.5 => -0.0024218640,
    nf_inq_per_sfd_addr > 16.5                => 0.0207032754,
    nf_inq_per_sfd_addr = NULL                => -0.0018036582,
               -0.0018036582));

final_score_251 := __common__( map(
    NULL < nf_inq_lnames_per_sfd_addr AND nf_inq_lnames_per_sfd_addr <= 4.5 => -0.0013044808,
    nf_inq_lnames_per_sfd_addr > 4.5      => 0.0492531403,
    nf_inq_lnames_per_sfd_addr = NULL                      => -0.0008737238,
                            -0.0008737238));

final_score_252 := __common__( map(
    NULL < nf_vf_hi_risk_ct AND nf_vf_hi_risk_ct <= 4.5 => -0.0019664474,
    nf_vf_hi_risk_ct > 4.5             => 0.0344594394,
    nf_vf_hi_risk_ct = NULL            => -0.0015436639,
                         -0.0015436639));

final_score_253 := __common__( map(
    NULL < iv_estimated_income AND iv_estimated_income <= 37500 => 0.0085566892,
    iv_estimated_income > 37500                => -0.0043312865,
    iv_estimated_income = NULL                 => 0.0000336430,
                0.0000336430));

final_score_254 := __common__( map(
    (nf_historic_x_current_ct in ['2-1'])                       => -0.0239487838,
    (nf_historic_x_current_ct in ['0-0', '1-0', '1-1', '2-0', '2-2', '3-0', '3-1', '3-2', '3-3']) => 0.0017028804,
    nf_historic_x_current_ct = ''           => 0.0006284826,
                0.0006284826));

final_score_255 := __common__( map(
    NULL < nf_mos_liens_unrel_st_fseen AND nf_mos_liens_unrel_st_fseen <= 177.5 => -0.0007022256,
    nf_mos_liens_unrel_st_fseen > 177.5       => -0.0324098403,
    nf_mos_liens_unrel_st_fseen = NULL        => -0.0018313906,
               -0.0018313906));

final_score_256 := __common__( map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 6.5 => 0.0011064387,
    rv_l79_adls_per_addr_c6 > 6.5                    => -0.0257221566,
    rv_l79_adls_per_addr_c6 = NULL                   => 0.0332150798,
                      0.0005831298));

final_score_257 := __common__( map(
    (nf_historic_x_current_ct in ['1-0', '3-0'])         => -0.0298719178,
    (nf_historic_x_current_ct in ['0-0', '1-1', '2-0', '2-1', '2-2', '3-1', '3-2', '3-3']) => -0.0001654720,
    nf_historic_x_current_ct = ''                      => -0.0015915054,
                          -0.0015915054));

final_score_258 := __common__( map(
    NULL < nf_inq_per_add_nas_479 AND nf_inq_per_add_nas_479 <= 1.5 => 0.0021562178,
    nf_inq_per_add_nas_479 > 1.5                   => 0.0334554534,
    nf_inq_per_add_nas_479 = NULL                  => 0.0026582791,
                    0.0026582791));

final_score_259 := __common__( map(
    NULL < rv_email_domain_isp_count AND rv_email_domain_isp_count <= 1.5 => 0.0059518804,
    rv_email_domain_isp_count > 1.5                      => -0.0048512681,
    rv_email_domain_isp_count = NULL                     => 0.0018028962,
                          0.0018028962));

final_score_260 := __common__( map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-2', '3-0', '3-2', '3-3']) => -0.0016161346,
    (rv_d32_criminal_x_felony in ['1-1', '2-0', '2-1', '3-1'])               => 0.0176979516,
    rv_d32_criminal_x_felony = ''        => 0.0000670760,
            0.0000670760));

final_score_261 := __common__( map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 2.5 => -0.0035169929,
    rv_l79_adls_per_addr_curr > 2.5                      => 0.0043551046,
    rv_l79_adls_per_addr_curr = NULL                     => 0.0011247055,
                          0.0011247055));

final_score_262 := __common__( map(
    NULL < nf_m_bureau_adl_fs_all AND nf_m_bureau_adl_fs_all <= 269.5 => 0.0043321175,
    nf_m_bureau_adl_fs_all > 269.5                   => -0.0075255001,
    nf_m_bureau_adl_fs_all = NULL                    => -0.0015819950,
                      -0.0015819950));

final_score_263 := __common__( map(
    NULL < nf_inq_banking_count24 AND nf_inq_banking_count24 <= 1.5 => -0.0037588616,
    nf_inq_banking_count24 > 1.5                   => 0.0195026556,
    nf_inq_banking_count24 = NULL                  => -0.0023385890,
                    -0.0023385890));

final_score_264 := __common__( map(
    NULL < nf_fp_srchunvrfdphonecount AND nf_fp_srchunvrfdphonecount <= 2.5 => -0.0007777989,
    nf_fp_srchunvrfdphonecount > 2.5      => 0.0161144684,
    nf_fp_srchunvrfdphonecount = NULL                      => 0.0002998683,
                            0.0002998683));

final_score_265 := __common__( map(
    (rv_4seg_riskview_5_0 in ['0 TRUEDID = 0', '3 OWNER', '4 OTHER']) => -0.0125132028,
    (rv_4seg_riskview_5_0 in ['1 VER/VAL PROBLEMS', '2 DEROG'])       => 0.0022386618,
    rv_4seg_riskview_5_0 = ''                      => -0.0009914348,
                      -0.0009914348));

final_score_266 := __common__( map(
    NULL < nf_pb_retail_combo_cnt AND nf_pb_retail_combo_cnt <= 2.5 => 0.0047793600,
    nf_pb_retail_combo_cnt > 2.5                   => -0.0077625209,
    nf_pb_retail_combo_cnt = NULL                  => 0.0001951766,
                    0.0001951766));

final_score_267 := __common__( map(
    NULL < nf_inq_per_add_nas_479 AND nf_inq_per_add_nas_479 <= 1.5 => -0.0009355149,
    nf_inq_per_add_nas_479 > 1.5                   => 0.0398708671,
    nf_inq_per_add_nas_479 = NULL                  => -0.0002861894,
                    -0.0002861894));

final_score_268 := __common__( map(
    NULL < iv_full_name_non_phn_src_ct AND iv_full_name_non_phn_src_ct <= 12.5 => -0.0001301573,
    iv_full_name_non_phn_src_ct > 12.5       => -0.0127012671,
    iv_full_name_non_phn_src_ct = NULL       => -0.0013982596,
              -0.0013982596));

final_score_269 := __common__( map(
    NULL < nf_inq_other_count AND nf_inq_other_count <= 1.5 => -0.0095000671,
    nf_inq_other_count > 1.5               => 0.0024685046,
    nf_inq_other_count = NULL              => -0.0015210193,
            -0.0015210193));

final_score_270 := __common__( map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr <= 11.5 => -0.0031281662,
    rv_c14_addrs_15yr > 11.5              => 0.0189829265,
    rv_c14_addrs_15yr = NULL              => -0.0020782787,
           -0.0020782787));

final_score_271 := __common__( map(
    NULL < nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount <= 6.5 => -0.0058085557,
    nf_fp_srchaddrsrchcount > 6.5                    => 0.0042604089,
    nf_fp_srchaddrsrchcount = NULL                   => -0.0004857319,
                      -0.0004857319));

final_score_272 := __common__( map(
    NULL < nf_fp_prevaddroccupantowned AND nf_fp_prevaddroccupantowned <= 0.5 => -0.0002447545,
    nf_fp_prevaddroccupantowned > 0.5       => 0.0235151407,
    nf_fp_prevaddroccupantowned = NULL      => 0.0006322574,
             0.0006322574));

final_score_273 := __common__( map(
    NULL < rv_email_count AND rv_email_count <= 9.5 => 0.0013092550,
    rv_email_count > 9.5           => -0.0134646564,
    rv_email_count = NULL          => -0.0007087862,
                     -0.0007087862));

final_score_274 := __common__( map(
    (rv_4seg_riskview_5_0 in ['4 OTHER'])                 => -0.0142134454,
    (rv_4seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '2 DEROG', '3 OWNER']) => 0.0021946954,
    rv_4seg_riskview_5_0 = ''          => 0.0003822677,
                           0.0003822677));

final_score_275 := __common__( map(
    NULL < iv_estimated_income AND iv_estimated_income <= 25500 => 0.0216908176,
    iv_estimated_income > 25500                => -0.0013284431,
    iv_estimated_income = NULL                 => -0.0003884524,
                -0.0003884524));

final_score_276 := __common__( map(
    NULL < nf_inq_other_count AND nf_inq_other_count <= 1.5 => -0.0085726881,
    nf_inq_other_count > 1.5               => 0.0032750010,
    nf_inq_other_count = NULL              => -0.0007654242,
            -0.0007654242));

final_score_277 := __common__( map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile <= 84.55 => 0.0005704361,
    rv_c12_source_profile > 84.55                  => 0.0517638389,
    rv_c12_source_profile = NULL                   => 0.0009978826,
                    0.0009978826));

final_score_278 := __common__( map(
    NULL < nf_phones_per_addr_curr AND nf_phones_per_addr_curr <= 3.5 => -0.0088398598,
    nf_phones_per_addr_curr > 3.5                    => 0.0025668407,
    nf_phones_per_addr_curr = NULL                   => -0.0005115617,
                      -0.0005115617));

final_score_279 := __common__( map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-1', '0-2', '0-3', '2-0', '2-1', '2-3', '3-0', '3-1']) => -0.0140772536,
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '1-0', '1-1', '1-2', '1-3', '2-2', '3-2', '3-3']) => 0.0026317665,
    rv_e58_br_dead_bus_x_active_phn = ''                      => 0.0005090868,
                0.0005090868));

final_score_280 := __common__( map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 11.5 => -0.0018916110,
    rv_d30_derog_count > 11.5               => 0.0146539519,
    rv_d30_derog_count = NULL               => 0.0001326146,
             0.0001326146));

final_score_281 := __common__( map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 17.5 => -0.0011044608,
    rv_l79_adls_per_addr_c6 > 17.5                    => -0.0601526161,
    rv_l79_adls_per_addr_c6 = NULL                    => -0.0015229123,
                       -0.0015229123));

final_score_282 := __common__( map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-0', '3-0', '3-2', '3-3']) => -0.0010555365,
    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1'])               => 0.0238072411,
    rv_d32_criminal_x_felony = ''        => -0.0003581462,
            -0.0003581462));

final_score_283 := __common__( map(
    NULL < rv_email_count AND rv_email_count <= 12.5 => 0.0003702964,
    rv_email_count > 12.5           => -0.0201139019,
    rv_email_count = NULL           => -0.0010272037,
                      -0.0010272037));

final_score_284 := __common__( map(
    (nf_source_type in ['Bureau and Behavioral', 'Bureau and Government', 'Bureau Behavioral and Government', 'None']) => 0.0011759492,
    (nf_source_type in ['Behavioral Only', 'Bureau Only', 'Government Only'])        => 0.0309157252,
    nf_source_type = ''                          => 0.0018704593,
                    0.0018704593));

final_score_285 := __common__( map(
    NULL < rv_c14_addrs_per_adl_c6 AND rv_c14_addrs_per_adl_c6 <= 0.5 => -0.0038724497,
    rv_c14_addrs_per_adl_c6 > 0.5                    => 0.0111205173,
    rv_c14_addrs_per_adl_c6 = NULL                   => -0.0018596953,
                      -0.0018596953));

final_score_286 := __common__( map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres <= 19.5 => 0.0488916149,
    rv_c13_max_lres > 19.5            => 0.0006209286,
    rv_c13_max_lres = NULL            => 0.0009609517,
                        0.0009609517));

final_score_287 := __common__( map(
    NULL < nf_liens_unrel_cj_total_amt AND nf_liens_unrel_cj_total_amt <= 13213.5 => 0.0031981161,
    nf_liens_unrel_cj_total_amt > 13213.5       => -0.0292674677,
    nf_liens_unrel_cj_total_amt = NULL          => 0.0021605387,
                 0.0021605387));

final_score_288 := __common__( map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen <= 14.5 => -0.0021819611,
    iv_mos_src_voter_adl_lseen > 14.5      => 0.0133642684,
    iv_mos_src_voter_adl_lseen = NULL      => 0.0006514482,
            0.0006514482));

final_score_289 := __common__( map(
    NULL < nf_fp_sourcerisktype AND nf_fp_sourcerisktype <= 5.5 => -0.0019240835,
    nf_fp_sourcerisktype > 5.5                 => 0.0100188679,
    nf_fp_sourcerisktype = NULL                => 0.0003261281,
                0.0003261281));

final_score_290 := __common__( map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres <= 20.5 => 0.0529257010,
    rv_c13_max_lres > 20.5            => 0.0008759679,
    rv_c13_max_lres = NULL            => 0.0012968735,
                        0.0012968735));

final_score_291 := __common__( map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 14.5 => 0.0023716513,
    rv_l79_adls_per_addr_c6 > 14.5                    => -0.0485256997,
    rv_l79_adls_per_addr_c6 = NULL                    => 0.0102845756,
                       0.0020193849));

final_score_292 := __common__( map(
    NULL < nf_fp_srchfraudsrchcount AND nf_fp_srchfraudsrchcount <= 52.5 => 0.0032973193,
    nf_fp_srchfraudsrchcount > 52.5                     => -0.0162391731,
    nf_fp_srchfraudsrchcount = NULL                     => 0.0019722931,
                         0.0019722931));

final_score_293 := __common__( map(
    NULL < nf_inq_per_sfd_addr AND nf_inq_per_sfd_addr <= 22.5 => -0.0003975568,
    nf_inq_per_sfd_addr > 22.5                => 0.0556840854,
    nf_inq_per_sfd_addr = NULL                => 0.0000362727,
               0.0000362727));

final_score_294 := __common__( map(
    NULL < nf_fp_idverrisktype AND nf_fp_idverrisktype <= 1.5 => -0.0037993204,
    nf_fp_idverrisktype > 1.5                => 0.0073812557,
    nf_fp_idverrisktype = NULL               => 0.0001628984,
              0.0001628984));

final_score_295 := __common__( map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 115.5 => -0.0038545308,
    iv_prv_addr_lres > 115.5             => 0.0089657589,
    iv_prv_addr_lres = NULL              => 0.0182029694,
          0.0001405416));

final_score_296 := __common__( map(
    NULL < nf_fp_srchphonesrchcountmo AND nf_fp_srchphonesrchcountmo <= 4.5 => -0.0028056868,
    nf_fp_srchphonesrchcountmo > 4.5      => 0.0383363871,
    nf_fp_srchphonesrchcountmo = NULL                      => -0.0023762849,
                            -0.0023762849));

final_score_297 := __common__( map(
    NULL < nf_fp_sourcerisktype AND nf_fp_sourcerisktype <= 6.5 => -0.0023594844,
    nf_fp_sourcerisktype > 6.5                 => 0.0152339856,
    nf_fp_sourcerisktype = NULL                => -0.0011498616,
                -0.0011498616));

final_score_298 := __common__( map(
    (rv_a43_rec_vehx_level in ['W1', 'XX'])             => -0.0009390157,
    (rv_a43_rec_vehx_level in ['AO', 'AW', 'W2', 'W3']) => 0.0623777209,
    rv_a43_rec_vehx_level = ''       => -0.0004846289,
                         -0.0004846289));

final_score_299 := __common__( map(
    NULL < nf_phones_per_sfd_addr_c6 AND nf_phones_per_sfd_addr_c6 <= 2.5 => -0.0001284486,
    nf_phones_per_sfd_addr_c6 > 2.5                      => 0.0597037011,
    nf_phones_per_sfd_addr_c6 = NULL                     => 0.0097583110,
                          0.0005368375));

final_score_300 := __common__( map(
    NULL < nf_mos_liens_unrel_sc_lseen AND nf_mos_liens_unrel_sc_lseen <= 150.5 => 0.0025875206,
    nf_mos_liens_unrel_sc_lseen > 150.5       => -0.0283974800,
    nf_mos_liens_unrel_sc_lseen = NULL        => 0.0014192669,
               0.0014192669));

final_score_301 := __common__( map(
    NULL < nf_phone_ver_experian AND nf_phone_ver_experian <= 0.5 => 0.0064425637,
    nf_phone_ver_experian > 0.5                  => -0.0038299470,
    nf_phone_ver_experian = NULL                 => -0.0004553636,
                  -0.0004553636));

final_score_302 := __common__( map(
    (iv_college_major in ['LIBERAL ARTS', 'NO AMS FOUND'])                      => -0.0023186274,
    (iv_college_major in ['BUSINESS', 'MEDICAL', 'NO COLLEGE FOUND', 'SCIENCE', 'UNCLASSIFIED']) => 0.0106412509,
    iv_college_major = ''                   => 0.0008515973,
               0.0008515973));

final_score_303 := __common__( map(
    NULL < iv_estimated_income AND iv_estimated_income <= 123500 => -0.0011824595,
    iv_estimated_income > 123500                => 0.0511177505,
    iv_estimated_income = NULL                  => -0.0008140521,
                 -0.0008140521));

final_score_304 := __common__( map(
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-1', '1-0', '1-1', '2-0', '2-1', '2-2', '3-2']) => -0.0015011200,
    (iv_d34_liens_unrel_x_rel in ['0-2', '1-2', '3-0', '3-1'])            => 0.0145724024,
    iv_d34_liens_unrel_x_rel = ''                      => 0.0009964097,
                          0.0009964097));

final_score_305 := __common__( map(
    NULL < nf_phones_per_apt_addr_curr AND nf_phones_per_apt_addr_curr <= 76.5 => -0.0014232292,
    nf_phones_per_apt_addr_curr > 76.5       => 0.0522130445,
    nf_phones_per_apt_addr_curr = NULL       => -0.0009093235,
              -0.0009093235));

final_score_306 := __common__( map(
    NULL < nf_inq_per_apt_addr AND nf_inq_per_apt_addr <= 11.5 => -0.0001659084,
    nf_inq_per_apt_addr > 11.5                => 0.0425853533,
    nf_inq_per_apt_addr = NULL                => 0.0004118114,
               0.0004118114));

final_score_307 := __common__( map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 108.5 => -0.0018397226,
    iv_prv_addr_lres > 108.5             => 0.0055617546,
    iv_prv_addr_lres = NULL              => 0.0423051907,
          0.0008356907));

final_score_308 := __common__( map(
    NULL < nf_inq_retail_count AND nf_inq_retail_count <= 3.5 => -0.0020783618,
    nf_inq_retail_count > 3.5                => 0.0338251111,
    nf_inq_retail_count = NULL               => -0.0013009060,
              -0.0013009060));

final_score_309 := __common__( map(
    NULL < nf_mos_liens_unrel_lt_fseen AND nf_mos_liens_unrel_lt_fseen <= 122.5 => -0.0010354466,
    nf_mos_liens_unrel_lt_fseen > 122.5       => 0.0448235958,
    nf_mos_liens_unrel_lt_fseen = NULL        => -0.0003413379,
               -0.0003413379));

final_score_310 := __common__( map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 114.5 => -0.0028037274,
    iv_prv_addr_lres > 114.5             => 0.0077687494,
    iv_prv_addr_lres = NULL              => 0.0249519132,
          0.0006513485));

final_score_311 := __common__( map(
    NULL < nf_fp_prevaddroccupantowned AND nf_fp_prevaddroccupantowned <= 0.5 => -0.0016311902,
    nf_fp_prevaddroccupantowned > 0.5       => 0.0240615496,
    nf_fp_prevaddroccupantowned = NULL      => -0.0006792348,
             -0.0006792348));

final_score_312 := __common__( map(
    NULL < nf_util_adl_count AND nf_util_adl_count <= 17.5 => -0.0007095919,
    nf_util_adl_count > 17.5              => 0.0207751716,
    nf_util_adl_count = NULL              => 0.0002546297,
           0.0002546297));

final_score_313 := __common__( map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 106.5 => -0.0012473329,
    rv_c13_inp_addr_lres > 106.5                 => 0.0105869429,
    rv_c13_inp_addr_lres = NULL                  => -0.0139195627,
                  0.0021021900));

final_score_314 := __common__( map(
    (iv_full_name_ver_sources in ['PHN & NONPHN', 'PHN ONLY'])     => 0.0007798538,
    (iv_full_name_ver_sources in ['NAME NOT VERD', 'NONPHN ONLY']) => 0.0025121306,
    iv_full_name_ver_sources = ''               => 0.0012211709,
                   0.0012211709));

final_score_315 := __common__( map(
    NULL < nf_inq_other_count AND nf_inq_other_count <= 25.5 => -0.0016390802,
    nf_inq_other_count > 25.5               => 0.0594655502,
    nf_inq_other_count = NULL               => -0.0011528576,
             -0.0011528576));

final_score_316 := __common__( map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec <= 0.5 => -0.0025258077,
    rv_f03_input_add_not_most_rec > 0.5         => 0.0091011298,
    rv_f03_input_add_not_most_rec = NULL        => -0.0006307084,
                 -0.0006307084));

final_score_317 := __common__( map(
    NULL < nf_fp_prevaddrlenofres AND nf_fp_prevaddrlenofres <= 49.5 => -0.0054090175,
    nf_fp_prevaddrlenofres > 49.5                   => 0.0046803845,
    nf_fp_prevaddrlenofres = NULL                   => -0.0001603174,
                     -0.0001603174));

final_score_318 := __common__( map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 113.5 => -0.0038833117,
    iv_prv_addr_lres > 113.5             => 0.0059407936,
    iv_prv_addr_lres = NULL              => 0.0222144405,
          -0.0007228098));

final_score_319 := __common__( map(
    (iv_full_name_ver_sources in ['PHN & NONPHN', 'PHN ONLY'])     => -0.0012775878,
    (iv_full_name_ver_sources in ['NAME NOT VERD', 'NONPHN ONLY']) => 0.0048391393,
    iv_full_name_ver_sources = ''               => 0.0002687489,
                   0.0002687489));

final_score_320 := __common__( map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 6.5 => -0.0022690404,
    rv_i60_inq_hiriskcred_count12 > 6.5         => 0.0149898200,
    rv_i60_inq_hiriskcred_count12 = NULL        => -0.0003641485,
                 -0.0003641485));

final_score_321 := __common__( map(
    NULL < iv_d34_liens_unrel_lt_ct AND iv_d34_liens_unrel_lt_ct <= 1.5 => -0.0017254715,
    iv_d34_liens_unrel_lt_ct > 1.5                     => 0.0514941115,
    iv_d34_liens_unrel_lt_ct = NULL                    => -0.0013436456,
                        -0.0013436456));

final_score_322 := __common__( map(
    NULL < nf_inq_banking_count AND nf_inq_banking_count <= 2.5 => -0.0003116074,
    nf_inq_banking_count > 2.5                 => 0.0128945329,
    nf_inq_banking_count = NULL                => 0.0016384775,
                0.0016384775));

final_score_323 := __common__( map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-3', '2-0', '3-3']) => -0.0023167700,
    (rv_e58_br_dead_bus_x_active_phn in ['1-1', '1-2', '2-1', '2-2', '2-3', '3-0', '3-1', '3-2']) => 0.0320447045,
    rv_e58_br_dead_bus_x_active_phn = ''                      => -0.0017518501,
                -0.0017518501));

final_score_324 := __common__( map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-3', '2-0', '2-3', '3-0', '3-1']) => -0.0017653147,
    (rv_e58_br_dead_bus_x_active_phn in ['1-2', '2-1', '2-2', '3-2', '3-3'])         => 0.0490087773,
    rv_e58_br_dead_bus_x_active_phn = ''                          => -0.0014209489,
                    -0.0014209489));

final_score_325 := __common__( map(
    NULL < nf_m_bureau_adl_fs_all AND nf_m_bureau_adl_fs_all <= 435.5 => 0.0008674956,
    nf_m_bureau_adl_fs_all > 435.5                   => -0.0260123197,
    nf_m_bureau_adl_fs_all = NULL                    => -0.0001249360,
                      -0.0001249360));

final_score_326 := __common__( map(
    NULL < nf_inq_highriskcredit_count_week AND nf_inq_highriskcredit_count_week <= 0.5 => -0.0020613033,
    nf_inq_highriskcredit_count_week > 0.5            => 0.0159685017,
    nf_inq_highriskcredit_count_week = NULL           => 0.0005281587,
                       0.0005281587));

final_score_327 := __common__( map(
    NULL < rv_email_domain_isp_count AND rv_email_domain_isp_count <= 5.5 => 0.0009970949,
    rv_email_domain_isp_count > 5.5                      => -0.0216265876,
    rv_email_domain_isp_count = NULL                     => -0.0004399383,
                          -0.0004399383));

final_score_328 := __common__( map(
    NULL < nf_inq_other_count AND nf_inq_other_count <= 1.5 => -0.0082298353,
    nf_inq_other_count > 1.5               => 0.0023268311,
    nf_inq_other_count = NULL              => -0.0012485252,
            -0.0012485252));

final_score_329 := __common__( map(
    NULL < nf_m_bureau_adl_fs_notu AND nf_m_bureau_adl_fs_notu <= 54.5 => 0.0320183185,
    nf_m_bureau_adl_fs_notu > 54.5                    => -0.0023879031,
    nf_m_bureau_adl_fs_notu = NULL                    => -0.0018672767,
                       -0.0018672767));

final_score_330 := __common__( map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 14.5 => 0.0016136214,
    rv_l79_adls_per_addr_c6 > 14.5                    => -0.0533693602,
    rv_l79_adls_per_addr_c6 = NULL                    => 0.0012168668,
                       0.0012168668));

final_score_331 := __common__( map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 16 => 0.0261773273,
    rv_f01_inp_addr_address_score > 16         => -0.0006809265,
    rv_f01_inp_addr_address_score = NULL       => -0.0063485116,
                0.0000897494));

final_score_332 := __common__( map(
    NULL < nf_mos_liens_unrel_ft_fseen AND nf_mos_liens_unrel_ft_fseen <= 16 => 0.0001163337,
    nf_mos_liens_unrel_ft_fseen > 16       => -0.0236216060,
    nf_mos_liens_unrel_ft_fseen = NULL                      => -0.0010388198,
            -0.0010388198));

final_score_333 := __common__( map(
    NULL < nf_inq_communications_count24 AND nf_inq_communications_count24 <= 4.5 => 0.0001550581,
    nf_inq_communications_count24 > 4.5         => 0.0288783587,
    nf_inq_communications_count24 = NULL        => 0.0004960208,
                 0.0004960208));

final_score_334 := __common__( map(
    NULL < iv_estimated_income AND iv_estimated_income <= 118500 => 0.0011994857,
    iv_estimated_income > 118500                => 0.0457742004,
    iv_estimated_income = NULL                  => 0.0016994760,
                 0.0016994760));

final_score_335 := __common__( map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr <= 6.5 => -0.0029632228,
    rv_c14_addrs_5yr > 6.5             => 0.0361088631,
    rv_c14_addrs_5yr = NULL            => -0.0023158444,
                         -0.0023158444));

final_score_336 := __common__( map(
    NULL < nf_inq_other_count AND nf_inq_other_count <= 25.5 => -0.0007155739,
    nf_inq_other_count > 25.5               => 0.0387566545,
    nf_inq_other_count = NULL               => -0.0003190492,
             -0.0003190492));

final_score_337 := __common__( map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr <= 6.5 => -0.0020013542,
    rv_c14_addrs_5yr > 6.5             => 0.0280796863,
    rv_c14_addrs_5yr = NULL            => -0.0015499816,
                         -0.0015499816));

final_score_338 := __common__( map(
    NULL < nf_fp_srchfraudsrchcountwk AND nf_fp_srchfraudsrchcountwk <= 0.5 => -0.0015424903,
    nf_fp_srchfraudsrchcountwk > 0.5      => 0.0110388293,
    nf_fp_srchfraudsrchcountwk = NULL                      => 0.0006662558,
                            0.0006662558));

final_score_339 := __common__( map(
    (nf_util_add_input_summary in ['|   |', '| C |', '| CM|', '|I  |', '|IC |', '|ICM|']) => -0.0005519886,
    (nf_util_add_input_summary in ['|  M|', '|I M|'])                    => 0.0182141664,
    nf_util_add_input_summary = ''                    => 0.0007286414,
                         0.0007286414));

final_score_340 := __common__( map(
    NULL < nf_fp_srchaddrsrchcountwk AND nf_fp_srchaddrsrchcountwk <= 2.5 => -0.0005366352,
    nf_fp_srchaddrsrchcountwk > 2.5                      => 0.0342047065,
    nf_fp_srchaddrsrchcountwk = NULL                     => 0.0001068909,
                          0.0001068909));

final_score_341 := __common__( map(
    NULL < nf_phones_per_addr_curr AND nf_phones_per_addr_curr <= 7.5 => -0.0037396823,
    nf_phones_per_addr_curr > 7.5                    => 0.0063175791,
    nf_phones_per_addr_curr = NULL                   => 0.0146916087,
                      0.0000986351));

final_score_342 := __common__( map(
    NULL < nf_fp_srchcomponentrisktype AND nf_fp_srchcomponentrisktype <= 1.5 => -0.0039396125,
    nf_fp_srchcomponentrisktype > 1.5       => 0.0071444995,
    nf_fp_srchcomponentrisktype = NULL      => -0.0006339009,
             -0.0006339009));

final_score_343 := __common__( map(
    (nf_util_add_curr_summary in ['|   |', '|  M|', '| C |', '| CM|', '|IC |', '|ICM|']) => -0.0023363005,
    (nf_util_add_curr_summary in ['|I  |', '|I M|'])                    => 0.0474393129,
    nf_util_add_curr_summary = ''                    => -0.0017585710,
                        -0.0017585710));

final_score_344 := __common__( map(
    NULL < nf_fp_srchfraudsrchcountwk AND nf_fp_srchfraudsrchcountwk <= 0.5 => -0.0031342694,
    nf_fp_srchfraudsrchcountwk > 0.5      => 0.0090192611,
    nf_fp_srchfraudsrchcountwk = NULL                      => -0.0010875426,
                            -0.0010875426));

final_score_345 := __common__( map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '3-0', '3-1', '3-3']) => -0.0019351967,
    (rv_d32_criminal_x_felony in ['1-1', '2-0', '2-1', '2-2', '3-2']) => 0.0191876699,
    rv_d32_criminal_x_felony = ''                  => -0.0002316953,
                      -0.0002316953));

final_score_346 := __common__( map(
    NULL < nf_vf_altlexid_phn_hi_risk_ct AND nf_vf_altlexid_phn_hi_risk_ct <= 0.5 => -0.0002410036,
    nf_vf_altlexid_phn_hi_risk_ct > 0.5         => 0.0347462424,
    nf_vf_altlexid_phn_hi_risk_ct = NULL        => 0.0002108275,
                 0.0002108275));

final_score_347 := __common__( map(
    NULL < rv_i60_inq_banking_count12 AND rv_i60_inq_banking_count12 <= 1.5 => -0.0013353240,
    rv_i60_inq_banking_count12 > 1.5      => 0.0237865458,
    rv_i60_inq_banking_count12 = NULL                      => -0.0006766368,
                            -0.0006766368));

final_score_348 := __common__( map(
    NULL < iv_full_name_non_phn_src_ct AND iv_full_name_non_phn_src_ct <= 3.5 => -0.0201449516,
    iv_full_name_non_phn_src_ct > 3.5       => 0.0008261104,
    iv_full_name_non_phn_src_ct = NULL      => 0.0002653869,
             0.0002653869));

final_score_349 := __common__( map(
    NULL < iv_estimated_income AND iv_estimated_income <= 120500 => -0.0011594193,
    iv_estimated_income > 120500                => 0.0584862426,
    iv_estimated_income = NULL                  => -0.0007003072,
                 -0.0007003072));

final_score_350 := __common__( map(
    NULL < nf_vf_altlexid_phn_hi_risk_ct AND nf_vf_altlexid_phn_hi_risk_ct <= 0.5 => -0.0000707363,
    nf_vf_altlexid_phn_hi_risk_ct > 0.5         => 0.0281843537,
    nf_vf_altlexid_phn_hi_risk_ct = NULL        => 0.0003346452,
                 0.0003346452));

final_score_351 := __common__( map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => -0.0009593871,
    rv_c19_add_prison_hist > 0.5                   => 0.0336238437,
    rv_c19_add_prison_hist = NULL                  => -0.0006209552,
                    -0.0006209552));

final_score_352 := __common__( map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl <= 1.5 => -0.0007820231,
    rv_i62_inq_num_names_per_adl > 1.5        => 0.0117068370,
    rv_i62_inq_num_names_per_adl = NULL       => 0.0013247083,
               0.0013247083));

final_score_353 := __common__( map(
    NULL < rv_i61_inq_collection_recency AND rv_i61_inq_collection_recency <= 61.5 => 0.0037227662,
    rv_i61_inq_collection_recency > 61.5         => -0.0055296044,
    rv_i61_inq_collection_recency = NULL         => -0.0008285695,
                  -0.0008285695));

final_score_354 := __common__( map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '2-0', '2-2', '2-3', '3-0', '3-3']) => 0.0014587527,
    (rv_e58_br_dead_bus_x_active_phn in ['1-2', '1-3', '2-1', '3-1', '3-2'])         => 0.0513299849,
    rv_e58_br_dead_bus_x_active_phn = ''                          => 0.0018619890,
                    0.0018619890));

final_score_355 := __common__( map(
    NULL < nf_inq_retail_count AND nf_inq_retail_count <= 1.5 => -0.0024108963,
    nf_inq_retail_count > 1.5                => 0.0181105640,
    nf_inq_retail_count = NULL               => -0.0006969808,
              -0.0006969808));

final_score_356 := __common__( map(
    NULL < nf_fp_srchssnsrchcountmo AND nf_fp_srchssnsrchcountmo <= 5.5 => 0.0001465153,
    nf_fp_srchssnsrchcountmo > 5.5                     => 0.0420180996,
    nf_fp_srchssnsrchcountmo = NULL                    => 0.0005180758,
                        0.0005180758));

final_score_357 := __common__( map(
    NULL < iv_estimated_income AND iv_estimated_income <= 121500 => -0.0010638437,
    iv_estimated_income > 121500                => 0.0446151901,
    iv_estimated_income = NULL                  => -0.0006646660,
                 -0.0006646660));

final_score_358 := __common__( map(
    NULL < nf_liens_unrel_st_total_amt AND nf_liens_unrel_st_total_amt <= 5796 => -0.0000716324,
    nf_liens_unrel_st_total_amt > 5796       => -0.0386477011,
    nf_liens_unrel_st_total_amt = NULL       => -0.0009473318,
              -0.0009473318));

final_score_359 := __common__( map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 31.5 => 0.0016657236,
    rv_d30_derog_count > 31.5               => 0.0482793882,
    rv_d30_derog_count = NULL               => 0.0020732283,
             0.0020732283));

final_score_360 := __common__( map(
    NULL < nf_mos_liens_unrel_sc_fseen AND nf_mos_liens_unrel_sc_fseen <= 203.5 => 0.0001528487,
    nf_mos_liens_unrel_sc_fseen > 203.5       => -0.0356889871,
    nf_mos_liens_unrel_sc_fseen = NULL        => -0.0008522373,
               -0.0008522373));

final_score_361 := __common__( map(
    NULL < nf_inq_banking_count AND nf_inq_banking_count <= 13.5 => -0.0014441122,
    nf_inq_banking_count > 13.5                 => 0.0377050249,
    nf_inq_banking_count = NULL                 => -0.0010968462,
                 -0.0010968462));

final_score_362 := __common__( map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-2', '0-3', '2-0', '2-2', '3-2'])         => -0.0259097876,
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '1-0', '1-1', '1-2', '1-3', '2-1', '2-3', '3-0', '3-1', '3-3']) => 0.0002402176,
    rv_e58_br_dead_bus_x_active_phn = ''                          => -0.0009232938,
                    -0.0009232938));

final_score_363 := __common__( map(
    (iv_full_name_ver_sources in ['NAME NOT VERD', 'PHN & NONPHN', 'PHN ONLY']) => -0.0006336163,
    (iv_full_name_ver_sources in ['NONPHN ONLY'])              => 0.0043838310,
    iv_full_name_ver_sources = ''           => 0.0006034011,
               0.0006034011));

final_score_364 := __common__( map(
    NULL < nf_phones_per_sfd_addr_c6 AND nf_phones_per_sfd_addr_c6 <= 2.5 => -0.0013381873,
    nf_phones_per_sfd_addr_c6 > 2.5                      => 0.0425205450,
    nf_phones_per_sfd_addr_c6 = NULL                     => 0.0023183708,
                          -0.0008853661));

final_score_365 := __common__( map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile <= 27.2 => -0.0198151861,
    rv_c12_source_profile > 27.2                  => 0.0012154687,
    rv_c12_source_profile = NULL                  => 0.0001950691,
                   0.0001950691));

final_score_366 := __common__( map(
    NULL < nf_liens_rel_o_total_amt AND nf_liens_rel_o_total_amt <= 486 => 0.0012831837,
    nf_liens_rel_o_total_amt > 486                     => -0.0404457034,
    nf_liens_rel_o_total_amt = NULL                    => 0.0003250253,
                        0.0003250253));

final_score_367 := __common__( map(
    (rv_e58_br_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-2', '1-3', '2-0', '2-2', '2-3', '3-0', '3-2']) => 0.0011047532,
    (rv_e58_br_dead_bus_x_active_phn in ['1-1', '2-1', '3-1', '3-3'])                       => 0.0425229905,
    rv_e58_br_dead_bus_x_active_phn = ''                => 0.0014938090,
                           0.0014938090));

final_score_368 := __common__( map(
    NULL < iv_estimated_income AND iv_estimated_income <= 27500 => 0.0164225993,
    iv_estimated_income > 27500                => -0.0014370346,
    iv_estimated_income = NULL                 => -0.0001486994,
                -0.0001486994));

final_score_369 := __common__( map(
    NULL < nf_mos_inq_banko_cm_lseen AND nf_mos_inq_banko_cm_lseen <= 47.5 => -0.0027749983,
    nf_mos_inq_banko_cm_lseen > 47.5                      => 0.0097800846,
    nf_mos_inq_banko_cm_lseen = NULL                      => -0.0001624272,
                           -0.0001624272));

final_score_370 := __common__( map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 2.5 => -0.0006593130,
    rv_l79_adls_per_sfd_addr_c6 > 2.5       => 0.0134807628,
    rv_l79_adls_per_sfd_addr_c6 = NULL      => 0.0006769325,
             0.0006769325));

final_score_371 := __common__( map(
    (iv_college_major in ['BUSINESS', 'LIBERAL ARTS', 'MEDICAL', 'NO AMS FOUND']) => -0.0031780608,
    (iv_college_major in ['NO COLLEGE FOUND', 'SCIENCE', 'UNCLASSIFIED'])         => 0.0101034568,
    iv_college_major = ''                     => -0.0001141617,
                 -0.0001141617));

final_score_372 := __common__( map(
    NULL < nf_vf_altlexid_phn_hi_risk_ct AND nf_vf_altlexid_phn_hi_risk_ct <= 0.5 => 0.0002844451,
    nf_vf_altlexid_phn_hi_risk_ct > 0.5         => 0.0357667623,
    nf_vf_altlexid_phn_hi_risk_ct = NULL        => 0.0007565553,
                 0.0007565553));

final_score_373 := __common__( map(
    NULL < rv_email_count AND rv_email_count <= 6.5 => 0.0021169301,
    rv_email_count > 6.5           => -0.0120131418,
    rv_email_count = NULL          => -0.0018357308,
                     -0.0018357308));

final_score_374 := __common__( map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres <= 478.5 => 0.0008628520,
    rv_c13_max_lres > 478.5            => 0.0823838593,
    rv_c13_max_lres = NULL             => 0.0014051911,
                         0.0014051911));

final_score_375 := __common__( map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres <= 26.5 => -0.0287177129,
    rv_c13_max_lres > 26.5            => 0.0027982223,
    rv_c13_max_lres = NULL            => 0.0021528588,
                        0.0021528588));

final_score_376 := __common__( map(
    NULL < nf_mos_liens_rel_cj_lseen AND nf_mos_liens_rel_cj_lseen <= 177.5 => -0.0021762939,
    nf_mos_liens_rel_cj_lseen > 177.5                      => 0.0275761466,
    nf_mos_liens_rel_cj_lseen = NULL      => -0.0013183490,
                            -0.0013183490));

final_score_377 := __common__( map(
    NULL < nf_fp_idverrisktype AND nf_fp_idverrisktype <= 1.5 => -0.0048021947,
    nf_fp_idverrisktype > 1.5                => 0.0070002922,
    nf_fp_idverrisktype = NULL               => -0.0006827927,
              -0.0006827927));

final_score_378 := __common__( map(
    NULL < nf_inq_retailpayments_count24 AND nf_inq_retailpayments_count24 <= 1.5 => 0.0000078490,
    nf_inq_retailpayments_count24 > 1.5         => 0.0389016208,
    nf_inq_retailpayments_count24 = NULL        => 0.0004491895,
                 0.0004491895));

final_score_379 := __common__( map(
    NULL < nf_pb_retail_combo_max AND nf_pb_retail_combo_max <= 4.5 => 0.0035737058,
    nf_pb_retail_combo_max > 4.5                   => -0.0096886423,
    nf_pb_retail_combo_max = NULL                  => 0.0009177757,
                    0.0009177757));

final_score_380 := __common__( map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => 0.0018652723,
    rv_c19_add_prison_hist > 0.5                   => 0.0463545109,
    rv_c19_add_prison_hist = NULL                  => 0.0023120796,
                    0.0023120796));

final_score_381 := __common__( map(
    NULL < iv_src_voter_adl_count AND iv_src_voter_adl_count <= -0.5 => -0.0033142517,
    iv_src_voter_adl_count > -0.5                   => 0.0069877650,
    iv_src_voter_adl_count = NULL                   => 0.0009495788,
                     0.0009495788));

final_score_382 := __common__( map(
    NULL < nf_vf_lexid_ssn_hi_risk_ct AND nf_vf_lexid_ssn_hi_risk_ct <= 4.5 => -0.0013510286,
    nf_vf_lexid_ssn_hi_risk_ct > 4.5      => 0.0424290051,
    nf_vf_lexid_ssn_hi_risk_ct = NULL                      => -0.0010425979,
                            -0.0010425979));

final_score_383 := __common__( map(
    (nf_util_adl_summary in ['|   |', '|  M|', '| C |', '| CM|', '|I  |', '|IC |', '|ICM|']) => 0.0001269483,
    (nf_util_adl_summary in ['|I M|'])                     => 0.0465435459,
    nf_util_adl_summary = ''            => 0.0005992894,
                            0.0005992894));

final_score_384 := __common__( map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl <= 2.5 => 0.0189111680,
    iv_c14_addrs_per_adl > 2.5                 => -0.0019107003,
    iv_c14_addrs_per_adl = NULL                => 0.0002078827,
                0.0002078827));

final_score_385 := __common__( map(
    (iv_d34_liens_unrel_x_rel in ['0-0', '1-1', '1-2', '2-0', '2-1', '2-2']) => -0.0039160647,
    (iv_d34_liens_unrel_x_rel in ['0-1', '0-2', '1-0', '3-0', '3-1', '3-2']) => 0.0060392151,
    iv_d34_liens_unrel_x_rel = ''        => -0.0001292664,
            -0.0001292664));

final_score_386 := __common__( map(
    NULL < nf_fp_prevaddroccupantowned AND nf_fp_prevaddroccupantowned <= 0.5 => -0.0024342658,
    nf_fp_prevaddroccupantowned > 0.5       => 0.0223651871,
    nf_fp_prevaddroccupantowned = NULL      => -0.0014897711,
             -0.0014897711));

final_score_387 := __common__( map(
    NULL < nf_phones_per_addr_curr AND nf_phones_per_addr_curr <= 7.5 => -0.0044025495,
    nf_phones_per_addr_curr > 7.5                    => 0.0065962445,
    nf_phones_per_addr_curr = NULL                   => -0.0002359679,
                      -0.0002359679));

final_score_388 := __common__( map(
    NULL < nf_fp_idveraddressnotcurrent AND nf_fp_idveraddressnotcurrent <= 1.5 => 0.0085310158,
    nf_fp_idveraddressnotcurrent > 1.5        => -0.0039602106,
    nf_fp_idveraddressnotcurrent = NULL       => -0.0014450237,
               -0.0014450237));

final_score_389 := __common__( map(
    NULL < rv_e57_prof_license_br_flag AND rv_e57_prof_license_br_flag <= 0.5 => 0.0048534714,
    rv_e57_prof_license_br_flag > 0.5       => -0.0052269989,
    rv_e57_prof_license_br_flag = NULL      => -0.0007093915,
             -0.0007093915));

final_score_390 := __common__( map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl <= 1.5 => -0.0023329419,
    rv_i62_inq_num_names_per_adl > 1.5        => 0.0118863472,
    rv_i62_inq_num_names_per_adl = NULL       => 0.0000724863,
               0.0000724863));

final_score_391 := __common__( map(
    NULL < nf_mos_inq_banko_am_fseen AND nf_mos_inq_banko_am_fseen <= 5 => -0.0000094353,
    nf_mos_inq_banko_am_fseen > 5                      => -0.0274571960,
    nf_mos_inq_banko_am_fseen = NULL                   => -0.0011695024,
                        -0.0011695024));

final_score_392 := __common__( map(
    NULL < nf_inq_per_phone AND nf_inq_per_phone <= 6.5 => -0.0031447941,
    nf_inq_per_phone > 6.5             => 0.0129470632,
    nf_inq_per_phone = NULL            => -0.0010210383,
                         -0.0010210383));

final_score_393 := __common__( map(
    NULL < nf_inq_highriskcredit_count AND nf_inq_highriskcredit_count <= 1.5 => 0.0080180728,
    nf_inq_highriskcredit_count > 1.5       => -0.0046315510,
    nf_inq_highriskcredit_count = NULL      => -0.0017686372,
             -0.0017686372));

final_score_394 := __common__( map(
    (nf_historic_x_current_ct in ['1-0', '1-1', '2-1', '2-2'])               => -0.0083880354,
    (nf_historic_x_current_ct in ['0-0', '2-0', '3-0', '3-1', '3-2', '3-3']) => 0.0035520716,
    nf_historic_x_current_ct = ''        => 0.0011328953,
            0.0011328953));

final_score_395 := __common__( map(
    NULL < nf_liens_rel_o_total_amt AND nf_liens_rel_o_total_amt <= 740.5 => 0.0007500164,
    nf_liens_rel_o_total_amt > 740.5                     => -0.0430224825,
    nf_liens_rel_o_total_amt = NULL                      => -0.0001748754,
                          -0.0001748754));

final_score := __common__( final_score_0 +
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
    final_score_132 +
    final_score_133 +
    final_score_134 +
    final_score_135 +
    final_score_136 +
    final_score_137 +
    final_score_138 +
    final_score_139 +
    final_score_140 +
    final_score_141 +
    final_score_142 +
    final_score_143 +
    final_score_144 +
    final_score_145 +
    final_score_146 +
    final_score_147 +
    final_score_148 +
    final_score_149 +
    final_score_150 +
    final_score_151 +
    final_score_152 +
    final_score_153 +
    final_score_154 +
    final_score_155 +
    final_score_156 +
    final_score_157 +
    final_score_158 +
    final_score_159 +
    final_score_160 +
    final_score_161 +
    final_score_162 +
    final_score_163 +
    final_score_164 +
    final_score_165 +
    final_score_166 +
    final_score_167 +
    final_score_168 +
    final_score_169 +
    final_score_170 +
    final_score_171 +
    final_score_172 +
    final_score_173 +
    final_score_174 +
    final_score_175 +
    final_score_176 +
    final_score_177 +
    final_score_178 +
    final_score_179 +
    final_score_180 +
    final_score_181 +
    final_score_182 +
    final_score_183 +
    final_score_184 +
    final_score_185 +
    final_score_186 +
    final_score_187 +
    final_score_188 +
    final_score_189 +
    final_score_190 +
    final_score_191 +
    final_score_192 +
    final_score_193 +
    final_score_194 +
    final_score_195 +
    final_score_196 +
    final_score_197 +
    final_score_198 +
    final_score_199 +
    final_score_200 +
    final_score_201 +
    final_score_202 +
    final_score_203 +
    final_score_204 +
    final_score_205 +
    final_score_206 +
    final_score_207 +
    final_score_208 +
    final_score_209 +
    final_score_210 +
    final_score_211 +
    final_score_212 +
    final_score_213 +
    final_score_214 +
    final_score_215 +
    final_score_216 +
    final_score_217 +
    final_score_218 +
    final_score_219 +
    final_score_220 +
    final_score_221 +
    final_score_222 +
    final_score_223 +
    final_score_224 +
    final_score_225 +
    final_score_226 +
    final_score_227 +
    final_score_228 +
    final_score_229 +
    final_score_230 +
    final_score_231 +
    final_score_232 +
    final_score_233 +
    final_score_234 +
    final_score_235 +
    final_score_236 +
    final_score_237 +
    final_score_238 +
    final_score_239 +
    final_score_240 +
    final_score_241 +
    final_score_242 +
    final_score_243 +
    final_score_244 +
    final_score_245 +
    final_score_246 +
    final_score_247 +
    final_score_248 +
    final_score_249 +
    final_score_250 +
    final_score_251 +
    final_score_252 +
    final_score_253 +
    final_score_254 +
    final_score_255 +
    final_score_256 +
    final_score_257 +
    final_score_258 +
    final_score_259 +
    final_score_260 +
    final_score_261 +
    final_score_262 +
    final_score_263 +
    final_score_264 +
    final_score_265 +
    final_score_266 +
    final_score_267 +
    final_score_268 +
    final_score_269 +
    final_score_270 +
    final_score_271 +
    final_score_272 +
    final_score_273 +
    final_score_274 +
    final_score_275 +
    final_score_276 +
    final_score_277 +
    final_score_278 +
    final_score_279 +
    final_score_280 +
    final_score_281 +
    final_score_282 +
    final_score_283 +
    final_score_284 +
    final_score_285 +
    final_score_286 +
    final_score_287 +
    final_score_288 +
    final_score_289 +
    final_score_290 +
    final_score_291 +
    final_score_292 +
    final_score_293 +
    final_score_294 +
    final_score_295 +
    final_score_296 +
    final_score_297 +
    final_score_298 +
    final_score_299 +
    final_score_300 +
    final_score_301 +
    final_score_302 +
    final_score_303 +
    final_score_304 +
    final_score_305 +
    final_score_306 +
    final_score_307 +
    final_score_308 +
    final_score_309 +
    final_score_310 +
    final_score_311 +
    final_score_312 +
    final_score_313 +
    final_score_314 +
    final_score_315 +
    final_score_316 +
    final_score_317 +
    final_score_318 +
    final_score_319 +
    final_score_320 +
    final_score_321 +
    final_score_322 +
    final_score_323 +
    final_score_324 +
    final_score_325 +
    final_score_326 +
    final_score_327 +
    final_score_328 +
    final_score_329 +
    final_score_330 +
    final_score_331 +
    final_score_332 +
    final_score_333 +
    final_score_334 +
    final_score_335 +
    final_score_336 +
    final_score_337 +
    final_score_338 +
    final_score_339 +
    final_score_340 +
    final_score_341 +
    final_score_342 +
    final_score_343 +
    final_score_344 +
    final_score_345 +
    final_score_346 +
    final_score_347 +
    final_score_348 +
    final_score_349 +
    final_score_350 +
    final_score_351 +
    final_score_352 +
    final_score_353 +
    final_score_354 +
    final_score_355 +
    final_score_356 +
    final_score_357 +
    final_score_358 +
    final_score_359 +
    final_score_360 +
    final_score_361 +
    final_score_362 +
    final_score_363 +
    final_score_364 +
    final_score_365 +
    final_score_366 +
    final_score_367 +
    final_score_368 +
    final_score_369 +
    final_score_370 +
    final_score_371 +
    final_score_372 +
    final_score_373 +
    final_score_374 +
    final_score_375 +
    final_score_376 +
    final_score_377 +
    final_score_378 +
    final_score_379 +
    final_score_380 +
    final_score_381 +
    final_score_382 +
    final_score_383 +
    final_score_384 +
    final_score_385 +
    final_score_386 +
    final_score_387 +
    final_score_388 +
    final_score_389 +
    final_score_390 +
    final_score_391 +
    final_score_392 +
    final_score_393 +
    final_score_394 +
    final_score_395);

base := __common__( 698);

pts := __common__( -43.25);

lgt := __common__( ln(0.1795 / (1 - 0.1795)));

fp1609_1_0_nooverrides := __common__( round(max((real)300, min(999, if(base + pts * (final_score - lgt) / ln(2) = NULL, -NULL, base + pts * (final_score - lgt) / ln(2))))));

or_decsssn := __common__( ssnlength > '0' and rc_decsflag = '1');

or_ssnpriordob := __common__( ssnlength > '0' and (String)dobpop = '1' and rc_ssndobflag = '1');

or_prisonaddr := __common__( (Integer)addrpop = 1 and (String)rc_hrisksic = '2225');

or_prisonphone := __common__( (Integer)hphnpop = 1 and (String)rc_hrisksicphone = '2225');

or_hraddr := __common__( (Integer)addrpop = 1 and rc_hriskaddrflag = '4' or rc_addrcommflag = '2');

or_hrphone := __common__( (Integer)hphnpop = 1 and (rc_hriskphoneflag = '6' or rc_hphonetypeflag = '5' or rc_hphonevalflag = '3' or rc_addrcommflag = '1'));

or_invalidssn := __common__( ssnlength > '0' and (rc_ssnvalflag = '1' or (rc_pwssnvalflag in ['1', '2', '3'])));

or_invalidaddr := __common__( (Integer)addrpop = 1 and rc_addrvalflag != 'V');

or_invalidphone := __common__( (Integer)hphnpop = 1 and (rc_phonevalflag = '0' or rc_hphonevalflag = '0'));

fp1609_1_0_score := __common__( map(
    or_decsssn or or_ssnpriordob or or_prisonaddr                 => min(if(fp1609_1_0_nooverrides = NULL, -NULL, fp1609_1_0_nooverrides), 670),
    or_prisonphone or or_hraddr or or_hrphone or or_invalidssn or or_invalidaddr or or_invalidphone => min(if(fp1609_1_0_nooverrides = NULL, -NULL, fp1609_1_0_nooverrides), 710),
                  fp1609_1_0_nooverrides));

fp1609_1_0 := __common__( fp1609_1_0_score);

_ver_src_ds := __common__( Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0);

_ver_src_de := __common__( Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0);

_ver_src_eq := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0);

_ver_src_en := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0);

_ver_src_tn := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0);

_ver_src_tu := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0);

_credit_source_cnt := __common__( (integer)_ver_src_eq +
    (integer)_ver_src_en +
    (integer)_ver_src_tn +
    (integer)_ver_src_tu);

_ver_src_cnt := __common__( Models.Common.countw((string)(ver_sources)));

_bureauonly := __common__( _credit_source_cnt > 0 AND _credit_source_cnt = _ver_src_cnt AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6])));

_derog := __common__( felony_count > 0 OR (Integer)addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2);

_deceased := __common__( rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de);

_ssnpriortodob := __common__( rc_ssndobflag = '1' OR rc_pwssndobflag = '1');

_inputmiskeys := __common__( rc_ssnmiskeyflag or rc_addrmiskeyflag or (Integer)add_input_house_number_match = 0);

_multiplessns := __common__( ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1);

_hh_strikes := __common__( if(hh_members_w_derog > 0, 1, 0) + 
                           if(hh_criminals > 0, 1, 0) +
                           if(hh_payday_loan_users > 0, 1, 0) );

stolenid := __common__( if(addrpop and (nas_summary in [4, 7, 9]) or fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9' or _deceased or _ssnpriortodob, 1, 0));

manipulatedid := __common__( if(_inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1), 1, 0));

manipulatedidpt2 := __common__( if(1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9', 1, 0));

syntheticid := __common__( if(fnamepop and lnamepop and addrpop and ssnlength = '9' and hphnpop and nap_summary <= 4 and nas_summary <= 4 or _ver_src_cnt = 0 or _bureauonly or (Integer)add_curr_pop = 0, 1, 0));

suspiciousactivity := __common__( if(_derog, 1, 0));

vulnerablevictim := __common__( if(0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70, 1, 0));

friendlyfraud := __common__( if(hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2), 1, 0));

stolenc_fp1609_1_0 := __common__( if((Boolean)(Integer)stolenid, fp1609_1_0, 299));

manip2c_fp1609_1_0 := __common__( if((boolean)(integer)manipulatedid or (boolean)(integer)manipulatedidpt2, fp1609_1_0, 299));

synthc_fp1609_1_0 := __common__( if((Boolean)(Integer)syntheticid, fp1609_1_0, 299));

suspactc_fp1609_1_0 := __common__( if((Boolean)suspiciousactivity, fp1609_1_0, 299));

vulnvicc_fp1609_1_0 := __common__( if((Boolean)vulnerablevictim, fp1609_1_0, 299));

friendlyc_fp1609_1_0 := __common__( if((Boolean)friendlyfraud, fp1609_1_0, 299));

custstolidindex := __common__( map(
    stolenc_fp1609_1_0 = 299               => 1,
    300 <= stolenc_fp1609_1_0 AND stolenc_fp1609_1_0 <= 590 => 9,
    590 < stolenc_fp1609_1_0 AND stolenc_fp1609_1_0 <= 610  => 8,
    610 < stolenc_fp1609_1_0 AND stolenc_fp1609_1_0 <= 630  => 7,
    630 < stolenc_fp1609_1_0 AND stolenc_fp1609_1_0 <= 650  => 6,
    650 < stolenc_fp1609_1_0 AND stolenc_fp1609_1_0 <= 680  => 5,
    680 < stolenc_fp1609_1_0 AND stolenc_fp1609_1_0 <= 700  => 4,
    700 < stolenc_fp1609_1_0 AND stolenc_fp1609_1_0 <= 720  => 3,
    720 < stolenc_fp1609_1_0 AND stolenc_fp1609_1_0 <= 999  => 2,
            99));

custmanipidindex := __common__( map(
    manip2c_fp1609_1_0 = 299               => 1,
    300 <= manip2c_fp1609_1_0 AND manip2c_fp1609_1_0 <= 600 => 9,
    600 < manip2c_fp1609_1_0 AND manip2c_fp1609_1_0 <= 630  => 8,
    630 < manip2c_fp1609_1_0 AND manip2c_fp1609_1_0 <= 650  => 7,
    650 < manip2c_fp1609_1_0 AND manip2c_fp1609_1_0 <= 670  => 6,
    670 < manip2c_fp1609_1_0 AND manip2c_fp1609_1_0 <= 690  => 5,
    690 < manip2c_fp1609_1_0 AND manip2c_fp1609_1_0 <= 700  => 4,
    700 < manip2c_fp1609_1_0 AND manip2c_fp1609_1_0 <= 720  => 3,
    720 < manip2c_fp1609_1_0 AND manip2c_fp1609_1_0 <= 999  => 2,
            99));

custsynthidindex := __common__( map(
    synthc_fp1609_1_0 = 299              => 1,
    300 <= synthc_fp1609_1_0 AND synthc_fp1609_1_0 <= 600 => 9,
    600 < synthc_fp1609_1_0 AND synthc_fp1609_1_0 <= 620  => 8,
    620 < synthc_fp1609_1_0 AND synthc_fp1609_1_0 <= 640  => 7,
    640 < synthc_fp1609_1_0 AND synthc_fp1609_1_0 <= 650  => 6,
    650 < synthc_fp1609_1_0 AND synthc_fp1609_1_0 <= 670  => 5,
    670 < synthc_fp1609_1_0 AND synthc_fp1609_1_0 <= 690  => 4,
    690 < synthc_fp1609_1_0 AND synthc_fp1609_1_0 <= 710  => 3,
    710 < synthc_fp1609_1_0 AND synthc_fp1609_1_0 <= 999  => 2,
          99));

custsuspactindex := __common__( map(
    suspactc_fp1609_1_0 = 299                => 1,
    300 <= suspactc_fp1609_1_0 AND suspactc_fp1609_1_0 <= 570 => 9,
    570 < suspactc_fp1609_1_0 AND suspactc_fp1609_1_0 <= 600  => 8,
    600 < suspactc_fp1609_1_0 AND suspactc_fp1609_1_0 <= 630  => 7,
    630 < suspactc_fp1609_1_0 AND suspactc_fp1609_1_0 <= 650  => 6,
    650 < suspactc_fp1609_1_0 AND suspactc_fp1609_1_0 <= 670  => 5,
    670 < suspactc_fp1609_1_0 AND suspactc_fp1609_1_0 <= 700  => 4,
    700 < suspactc_fp1609_1_0 AND suspactc_fp1609_1_0 <= 730  => 3,
    730 < suspactc_fp1609_1_0 AND suspactc_fp1609_1_0 <= 999  => 2,
              99));

custvulnvicindex := __common__( map(
    vulnvicc_fp1609_1_0 = 299                => 1,
    300 <= vulnvicc_fp1609_1_0 AND vulnvicc_fp1609_1_0 <= 610 => 9,
    610 < vulnvicc_fp1609_1_0 AND vulnvicc_fp1609_1_0 <= 640  => 8,
    640 < vulnvicc_fp1609_1_0 AND vulnvicc_fp1609_1_0 <= 670  => 7,
    670 < vulnvicc_fp1609_1_0 AND vulnvicc_fp1609_1_0 <= 690  => 6,
    690 < vulnvicc_fp1609_1_0 AND vulnvicc_fp1609_1_0 <= 700  => 5,
    700 < vulnvicc_fp1609_1_0 AND vulnvicc_fp1609_1_0 <= 730  => 4,
    730 < vulnvicc_fp1609_1_0 AND vulnvicc_fp1609_1_0 <= 750  => 3,
    750 < vulnvicc_fp1609_1_0 AND vulnvicc_fp1609_1_0 <= 999  => 2,
              99));

custfriendfrdindex := __common__( map(
    friendlyc_fp1609_1_0 = 299                 => 1,
    300 <= friendlyc_fp1609_1_0 AND friendlyc_fp1609_1_0 <= 590 => 9,
    590 < friendlyc_fp1609_1_0 AND friendlyc_fp1609_1_0 <= 610  => 8,
    610 < friendlyc_fp1609_1_0 AND friendlyc_fp1609_1_0 <= 630  => 7,
    630 < friendlyc_fp1609_1_0 AND friendlyc_fp1609_1_0 <= 650  => 6,
    650 < friendlyc_fp1609_1_0 AND friendlyc_fp1609_1_0 <= 670  => 5,
    670 < friendlyc_fp1609_1_0 AND friendlyc_fp1609_1_0 <= 700  => 4,
    700 < friendlyc_fp1609_1_0 AND friendlyc_fp1609_1_0 <= 730  => 3,
    730 < friendlyc_fp1609_1_0 AND friendlyc_fp1609_1_0 <= 999  => 2,
                99));





//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(FP_DEBUG)
		/* Model Input Variables */
		//self.seq	 												 := le.seq;
     self.sysdate                        := sysdate;
   self.iv_add_apt                       := iv_add_apt;
   self.rv_p88_phn_dst_to_inp_add        := rv_p88_phn_dst_to_inp_add;
   self.add_ec3                          := add_ec3;
   self.add_ec4                          := add_ec4;
   self.rv_f03_input_add_not_most_rec    := rv_f03_input_add_not_most_rec;
   self.rv_c19_add_prison_hist           := rv_c19_add_prison_hist;
   self.rv_f01_inp_addr_address_score    := rv_f01_inp_addr_address_score;
   self.rv_d30_derog_count               := rv_d30_derog_count;
   self.rv_d32_criminal_count            := rv_d32_criminal_count;
   self.rv_d32_criminal_x_felony         := rv_d32_criminal_x_felony;
   self._criminal_last_date              := _criminal_last_date;
   self._felony_last_date                := _felony_last_date;
   self.rv_d31_attr_bankruptcy_recency   := rv_d31_attr_bankruptcy_recency;
   self.rv_d33_eviction_recency          := rv_d33_eviction_recency;
   self.rv_d33_eviction_count            := rv_d33_eviction_count;
   self.rv_d34_unrel_lien60_count        := rv_d34_unrel_lien60_count;
   self.iv_d34_liens_unrel_x_rel         := iv_d34_liens_unrel_x_rel;
   self.rv_c20_m_bureau_adl_fs           := rv_c20_m_bureau_adl_fs;
   self.nf_m_bureau_adl_fs_all           := nf_m_bureau_adl_fs_all;
   self._src_bureau_adl_fseen_notu       := _src_bureau_adl_fseen_notu;
   self.nf_m_bureau_adl_fs_notu          := nf_m_bureau_adl_fs_notu;
   self._header_first_seen               := _header_first_seen;
   self.rv_c10_m_hdr_fs                  := rv_c10_m_hdr_fs;
   self.rv_c12_source_profile            := rv_c12_source_profile;
   self._in_dob                          := _in_dob;
   self.yr_in_dob                        := yr_in_dob;
   self.yr_in_dob_int                    := yr_in_dob_int;
   self.rv_c13_max_lres                  := rv_c13_max_lres;
   self.rv_c14_addrs_5yr                 := rv_c14_addrs_5yr;
   self.rv_c14_addrs_10yr                := rv_c14_addrs_10yr;
   self.rv_c14_addrs_per_adl_c6          := rv_c14_addrs_per_adl_c6;
   self.rv_c14_addrs_15yr                := rv_c14_addrs_15yr;
   self.rv_a43_rec_vehx_level            := rv_a43_rec_vehx_level;
   self.rv_email_count                   := rv_email_count;
   self.rv_email_domain_isp_count        := rv_email_domain_isp_count;
   self.rv_e57_prof_license_br_flag      := rv_e57_prof_license_br_flag;
   self.rv_i61_inq_collection_recency    := rv_i61_inq_collection_recency;
   self.rv_i60_inq_banking_count12       := rv_i60_inq_banking_count12;
   self.rv_i60_inq_hiriskcred_count12    := rv_i60_inq_hiriskcred_count12;
   self.rv_i60_inq_prepaidcards_recency  := rv_i60_inq_prepaidcards_recency;
   self.rv_i60_inq_retpymt_count12       := rv_i60_inq_retpymt_count12;
   self.rv_l79_adls_per_addr_curr        := rv_l79_adls_per_addr_curr;
   self.rv_l79_adls_per_apt_addr         := rv_l79_adls_per_apt_addr;
   self.rv_l79_adls_per_addr_c6          := rv_l79_adls_per_addr_c6;
   self.rv_l79_adls_per_sfd_addr_c6      := rv_l79_adls_per_sfd_addr_c6;
   self.rv_c13_attr_addrs_recency        := rv_c13_attr_addrs_recency;
   self.rv_truedid                       := rv_truedid;
   self.iv_addrpop                       := iv_addrpop;
   self.iv_fnamepop                      := iv_fnamepop;
   self.iv_lnamepop                      := iv_lnamepop;
   self.iv_hphnpop                       := iv_hphnpop;
   self.iv_ssnlength                     := iv_ssnlength;
   self.iv_dobpop                        := iv_dobpop;
   self.ssnpop                           := ssnpop;
   self.iv_rv5_deceased                  := iv_rv5_deceased;
   self.iv_full_name_non_phn_src_ct      := iv_full_name_non_phn_src_ct;
   self.iv_full_name_ver_sources         := iv_full_name_ver_sources;
   self.iv_addr_non_phn_src_ct           := iv_addr_non_phn_src_ct;
   self.iv_c22_addr_ver_sources          := iv_c22_addr_ver_sources;
   self.iv_dob_src_ct                    := iv_dob_src_ct;
   self._nap_ver                         := _nap_ver;
   self._inf_ver                         := _inf_ver;
   self.rv_c13_inp_addr_lres             := rv_c13_inp_addr_lres;
   self.rv_c12_inp_addr_source_count     := rv_c12_inp_addr_source_count;
   self.mortgage_type                    := mortgage_type;
   self.mortgage_present                 := mortgage_present;
   self.iv_prv_addr_lres                 := iv_prv_addr_lres;
   self.iv_c14_addrs_per_adl             := iv_c14_addrs_per_adl;
   self.rv_i60_inq_other_count12         := rv_i60_inq_other_count12;
   self.rv_i62_inq_num_names_per_adl     := rv_i62_inq_num_names_per_adl;
   self.rv_i62_inq_phones_per_adl        := rv_i62_inq_phones_per_adl;
   self.br_first_seen_char               := br_first_seen_char;
   self._br_first_seen                   := _br_first_seen;
   self.iv_br_source_count               := iv_br_source_count;
   self.rv_e58_br_dead_bus_x_active_phn  := rv_e58_br_dead_bus_x_active_phn;
   self.br_company_title1                := br_company_title1;
   self.br_company_title2                := br_company_title2;
   self.iv_d34_liens_unrel_lt_ct         := iv_d34_liens_unrel_lt_ct;
   self.major_medical                    := major_medical;
   self.major_science                    := major_science;
   self.major_liberal                    := major_liberal;
   self.major_business                   := major_business;
   self.major_unknown                    := major_unknown;
   self.iv_college_major                 := iv_college_major;
   self.sum_dols                         := sum_dols;
   self.pct_offline_dols                 := pct_offline_dols;
   self.pct_retail_dols                  := pct_retail_dols;
   self.pct_online_dols                  := pct_online_dols;
   self.num_dob_match_level              := num_dob_match_level;
   self.nas_summary_ver                  := nas_summary_ver;
   self.nap_summary_ver                  := nap_summary_ver;
   self.infutor_nap_ver                  := infutor_nap_ver;
   self.dob_ver                          := dob_ver;
   self.sufficiently_verified            := sufficiently_verified;
   self.add_ec1                          := add_ec1;
   self.addr_validation_problem          := addr_validation_problem;
   self.phn_validation_problem           := phn_validation_problem;
   self.validation_problem               := validation_problem;
   self.tot_liens                        := tot_liens;
   self.tot_liens_w_type                 := tot_liens_w_type;
   self.has_derog                        := has_derog;
   self.rv_4seg_riskview_5_0             := rv_4seg_riskview_5_0;
   self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
   self.nf_bus_addr_match_count          := nf_bus_addr_match_count;
   self.nf_bus_phone_match               := nf_bus_phone_match;
   self.adl_util_i                       := adl_util_i;
   self.adl_util_c                       := adl_util_c;
   self.adl_util_m                       := adl_util_m;
   self.nf_util_adl_summary              := nf_util_adl_summary;
   self.nf_util_adl_count                := nf_util_adl_count;
   self.inp_util_i                       := inp_util_i;
   self.inp_util_c                       := inp_util_c;
   self.inp_util_m                       := inp_util_m;
   self.nf_util_add_input_summary        := nf_util_add_input_summary;
   self.curr_util_i                      := curr_util_i;
   self.curr_util_c                      := curr_util_c;
   self.curr_util_m                      := curr_util_m;
   self.nf_util_add_curr_summary         := nf_util_add_curr_summary;
   self.add_input_nhood_prop_sum         := add_input_nhood_prop_sum;
   self.add_curr_nhood_prop_sum          := add_curr_nhood_prop_sum;
   self.nf_phone_ver_experian            := nf_phone_ver_experian;
   self.nf_addrs_per_ssn                 := nf_addrs_per_ssn;
   self.nf_phones_per_addr_curr          := nf_phones_per_addr_curr;
   self.nf_phones_per_apt_addr_curr      := nf_phones_per_apt_addr_curr;
   self.nf_phones_per_sfd_addr_c6        := nf_phones_per_sfd_addr_c6;
   self.nf_inq_count                     := nf_inq_count;
   self.nf_inq_count24                   := nf_inq_count24;
   self.nf_inq_banking_count             := nf_inq_banking_count;
   self.nf_inq_banking_count24           := nf_inq_banking_count24;
   self.nf_inq_communications_count      := nf_inq_communications_count;
   self.nf_inq_communications_count24    := nf_inq_communications_count24;
   self.nf_inq_highriskcredit_count      := nf_inq_highriskcredit_count;
   self.nf_inq_highriskcredit_count_week := nf_inq_highriskcredit_count_week;
   self.nf_inq_other_count               := nf_inq_other_count;
   self.nf_inq_other_count24             := nf_inq_other_count24;
   self.nf_inq_prepaidcards_count        := nf_inq_prepaidcards_count;
   self.nf_inq_prepaidcards_count24      := nf_inq_prepaidcards_count24;
   self.nf_inq_retail_count              := nf_inq_retail_count;
   self.nf_inq_retailpayments_count24    := nf_inq_retailpayments_count24;
   self.nf_inq_per_addr                  := nf_inq_per_addr;
   self.nf_inq_per_apt_addr              := nf_inq_per_apt_addr;
   self.nf_inq_per_sfd_addr              := nf_inq_per_sfd_addr;
   self.nf_inq_lnames_per_sfd_addr       := nf_inq_lnames_per_sfd_addr;
   self.nf_inq_ssns_per_addr             := nf_inq_ssns_per_addr;
   self.nf_inq_ssns_per_sfd_addr         := nf_inq_ssns_per_sfd_addr;
   self.nf_inq_per_phone                 := nf_inq_per_phone;
   self._inq_banko_am_first_seen         := _inq_banko_am_first_seen;
   self.nf_mos_inq_banko_am_fseen        := nf_mos_inq_banko_am_fseen;
   self._inq_banko_am_last_seen          := _inq_banko_am_last_seen;
   self._inq_banko_cm_first_seen         := _inq_banko_cm_first_seen;
   self._inq_banko_cm_last_seen          := _inq_banko_cm_last_seen;
   self.nf_mos_inq_banko_cm_lseen        := nf_mos_inq_banko_cm_lseen;
   self._inq_banko_om_first_seen         := _inq_banko_om_first_seen;
   self._inq_banko_om_last_seen          := _inq_banko_om_last_seen;
   self.nf_mos_inq_banko_om_lseen        := nf_mos_inq_banko_om_lseen;
   self.nf_email_src_aw                  := nf_email_src_aw;
   self.email_src_aw_fseen               := email_src_aw_fseen;
   self._email_src_aw_fseen              := _email_src_aw_fseen;
   self.email_src_aw_lseen               := email_src_aw_lseen;
   self._email_src_aw_lseen              := _email_src_aw_lseen;
   self.em_aw_pos                        := em_aw_pos;
   self.nf_email_src_ib                  := nf_email_src_ib;
   self.email_src_ib_fseen               := email_src_ib_fseen;
   self._email_src_ib_fseen              := _email_src_ib_fseen;
   self.email_src_ib_lseen               := email_src_ib_lseen;
   self._email_src_ib_lseen              := _email_src_ib_lseen;
   self.em_ib_pos                        := em_ib_pos;
   self.nf_email_src_m1                  := nf_email_src_m1;
   self.email_src_m1_fseen               := email_src_m1_fseen;
   self._email_src_m1_fseen              := _email_src_m1_fseen;
   self.email_src_m1_lseen               := email_src_m1_lseen;
   self._email_src_m1_lseen              := _email_src_m1_lseen;
   self.em_m1_pos                        := em_m1_pos;
   self.nf_email_src_et                  := nf_email_src_et;
   self.email_src_et_fseen               := email_src_et_fseen;
   self._email_src_et_fseen              := _email_src_et_fseen;
   self.email_src_et_lseen               := email_src_et_lseen;
   self._email_src_et_lseen              := _email_src_et_lseen;
   self.em_et_pos                        := em_et_pos;
   self.nf_email_src_wa                  := nf_email_src_wa;
   self.email_src_wa_fseen               := email_src_wa_fseen;
   self._email_src_wa_fseen              := _email_src_wa_fseen;
   self.email_src_wa_lseen               := email_src_wa_lseen;
   self._email_src_wa_lseen              := _email_src_wa_lseen;
   self.em_wa_pos                        := em_wa_pos;
   self.nf_email_src_dg                  := nf_email_src_dg;
   self.email_src_dg_fseen               := email_src_dg_fseen;
   self._email_src_dg_fseen              := _email_src_dg_fseen;
   self.email_src_dg_lseen               := email_src_dg_lseen;
   self._email_src_dg_lseen              := _email_src_dg_lseen;
   self.em_dg_pos                        := em_dg_pos;
   self.nf_email_src_sc                  := nf_email_src_sc;
   self.email_src_sc_fseen               := email_src_sc_fseen;
   self._email_src_sc_fseen              := _email_src_sc_fseen;
   self.email_src_sc_lseen               := email_src_sc_lseen;
   self._email_src_sc_lseen              := _email_src_sc_lseen;
   self.em_sc_pos                        := em_sc_pos;
   self.nf_attr_arrests                  := nf_attr_arrests;
   self.nf_attr_arrest_recency           := nf_attr_arrest_recency;
   self.nf_vf_hi_risk_ct                 := nf_vf_hi_risk_ct;
   self.nf_vf_lexid_phn_lo_risk_ct       := nf_vf_lexid_phn_lo_risk_ct;
   self.nf_vf_altlexid_phn_hi_risk_ct    := nf_vf_altlexid_phn_hi_risk_ct;
   self.nf_vf_lexid_addr_hi_risk_ct      := nf_vf_lexid_addr_hi_risk_ct;
   self.nf_vf_lexid_ssn_hi_risk_ct       := nf_vf_lexid_ssn_hi_risk_ct;
   self._liens_unrel_cj_first_seen       := _liens_unrel_cj_first_seen;
   self._liens_unrel_cj_last_seen        := _liens_unrel_cj_last_seen;
   self.nf_liens_unrel_cj_total_amt      := nf_liens_unrel_cj_total_amt;
   self._liens_rel_cj_first_seen         := _liens_rel_cj_first_seen;
   self._liens_rel_cj_last_seen          := _liens_rel_cj_last_seen;
   self.nf_mos_liens_rel_cj_lseen        := nf_mos_liens_rel_cj_lseen;
   self._liens_unrel_ft_first_seen       := _liens_unrel_ft_first_seen;
   self.nf_mos_liens_unrel_ft_fseen      := nf_mos_liens_unrel_ft_fseen;
   self._liens_unrel_ft_last_seen        := _liens_unrel_ft_last_seen;
   self._liens_rel_ft_first_seen         := _liens_rel_ft_first_seen;
   self._liens_rel_ft_last_seen          := _liens_rel_ft_last_seen;
   self._liens_unrel_fc_first_seen       := _liens_unrel_fc_first_seen;
   self._liens_unrel_fc_last_seen        := _liens_unrel_fc_last_seen;
   self._liens_rel_fc_first_seen         := _liens_rel_fc_first_seen;
   self._liens_rel_fc_last_seen          := _liens_rel_fc_last_seen;
   self._liens_unrel_lt_first_seen       := _liens_unrel_lt_first_seen;
   self.nf_mos_liens_unrel_lt_fseen      := nf_mos_liens_unrel_lt_fseen;
   self._liens_unrel_lt_last_seen        := _liens_unrel_lt_last_seen;
   self._liens_rel_lt_first_seen         := _liens_rel_lt_first_seen;
   self._liens_rel_lt_last_seen          := _liens_rel_lt_last_seen;
   self._liens_unrel_o_first_seen        := _liens_unrel_o_first_seen;
   self._liens_unrel_o_last_seen         := _liens_unrel_o_last_seen;
   self._liens_rel_o_first_seen          := _liens_rel_o_first_seen;
   self._liens_rel_o_last_seen           := _liens_rel_o_last_seen;
   self.nf_liens_rel_o_total_amt         := nf_liens_rel_o_total_amt;
   self._liens_unrel_ot_first_seen       := _liens_unrel_ot_first_seen;
   self._liens_unrel_ot_last_seen        := _liens_unrel_ot_last_seen;
   self._liens_rel_ot_first_seen         := _liens_rel_ot_first_seen;
   self._liens_rel_ot_last_seen          := _liens_rel_ot_last_seen;
   self._liens_unrel_sc_first_seen       := _liens_unrel_sc_first_seen;
   self.nf_mos_liens_unrel_sc_fseen      := nf_mos_liens_unrel_sc_fseen;
   self._liens_unrel_sc_last_seen        := _liens_unrel_sc_last_seen;
   self.nf_mos_liens_unrel_sc_lseen      := nf_mos_liens_unrel_sc_lseen;
   self.nf_liens_unrel_sc_total_amt      := nf_liens_unrel_sc_total_amt;
   self._liens_rel_sc_first_seen         := _liens_rel_sc_first_seen;
   self._liens_rel_sc_last_seen          := _liens_rel_sc_last_seen;
   self._liens_unrel_st_first_seen       := _liens_unrel_st_first_seen;
   self.nf_mos_liens_unrel_st_fseen      := nf_mos_liens_unrel_st_fseen;
   self._liens_unrel_st_last_seen        := _liens_unrel_st_last_seen;
   self.nf_liens_unrel_st_total_amt      := nf_liens_unrel_st_total_amt;
   self._liens_rel_st_first_seen         := _liens_rel_st_first_seen;
   self._liens_rel_st_last_seen          := _liens_rel_st_last_seen;
   self._foreclosure_last_date           := _foreclosure_last_date;
   self.iv_estimated_income              := iv_estimated_income;
   self.nf_historic_x_current_ct         := nf_historic_x_current_ct;
   self.current_count                    := current_count;
   self.historical_count                 := historical_count;
   self._acc_last_seen                   := _acc_last_seen;
   self._prof_license_ix_sanct_fs        := _prof_license_ix_sanct_fs;
   self._prof_license_ix_sanct_ls        := _prof_license_ix_sanct_ls;
   self.nf_fp_idverrisktype              := nf_fp_idverrisktype;
   self.nf_fp_idveraddressnotcurrent     := nf_fp_idveraddressnotcurrent;
   self.nf_fp_sourcerisktype             := nf_fp_sourcerisktype;
   self.nf_fp_varrisktype                := nf_fp_varrisktype;
   self.nf_fp_srchunvrfdssncount         := nf_fp_srchunvrfdssncount;
   self.nf_fp_srchunvrfdphonecount       := nf_fp_srchunvrfdphonecount;
   self.nf_fp_srchfraudsrchcount         := nf_fp_srchfraudsrchcount;
   self.nf_fp_srchfraudsrchcountmo       := nf_fp_srchfraudsrchcountmo;
   self.nf_fp_srchfraudsrchcountwk       := nf_fp_srchfraudsrchcountwk;
   self.nf_fp_srchcomponentrisktype      := nf_fp_srchcomponentrisktype;
   self.nf_fp_srchssnsrchcountmo         := nf_fp_srchssnsrchcountmo;
   self.nf_fp_srchaddrsrchcount          := nf_fp_srchaddrsrchcount;
   self.nf_fp_srchaddrsrchcountmo        := nf_fp_srchaddrsrchcountmo;
   self.nf_fp_srchaddrsrchcountwk        := nf_fp_srchaddrsrchcountwk;
   self.nf_fp_srchphonesrchcountmo       := nf_fp_srchphonesrchcountmo;
   self.nf_fp_srchphonesrchcountwk       := nf_fp_srchphonesrchcountwk;
   self.nf_fp_prevaddrlenofres           := nf_fp_prevaddrlenofres;
   self.nf_fp_prevaddroccupantowned      := nf_fp_prevaddroccupantowned;
   self.nf_pb_retail_combo_cnt           := nf_pb_retail_combo_cnt;
   self.nf_pb_retail_combo_max           := nf_pb_retail_combo_max;
   self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
   self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
   self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
   self.bureau_adl_en_fseen_pos          := bureau_adl_en_fseen_pos;
   self.bureau_adl_fseen_en              := bureau_adl_fseen_en;
   self._bureau_adl_fseen_en             := _bureau_adl_fseen_en;
   self.bureau_adl_ts_fseen_pos          := bureau_adl_ts_fseen_pos;
   self.bureau_adl_fseen_ts              := bureau_adl_fseen_ts;
   self._bureau_adl_fseen_ts             := _bureau_adl_fseen_ts;
   self.bureau_adl_tu_fseen_pos          := bureau_adl_tu_fseen_pos;
   self.bureau_adl_fseen_tu              := bureau_adl_fseen_tu;
   self._bureau_adl_fseen_tu             := _bureau_adl_fseen_tu;
   self.bureau_adl_tn_fseen_pos          := bureau_adl_tn_fseen_pos;
   self.bureau_adl_fseen_tn              := bureau_adl_fseen_tn;
   self._bureau_adl_fseen_tn             := _bureau_adl_fseen_tn;
   self._src_bureau_adl_fseen_all        := _src_bureau_adl_fseen_all;
   self.credit_bureau_oldest             := credit_bureau_oldest;
   self.num_sources                      := num_sources;
   self.bureau_                          := bureau_;
   self.behavioral_                      := behavioral_;
   self.government_                      := government_;
   self.nf_source_type                   := nf_source_type;
   self.nf_inq_per_add_nas_479           := nf_inq_per_add_nas_479;
   self._add_not_ver                     := _add_not_ver;
   self.lic_adl_d_count_pos              := lic_adl_d_count_pos;
   self.lic_adl_count_d                  := lic_adl_count_d;
   self.lic_adl_dl_count_pos             := lic_adl_dl_count_pos;
   self.lic_adl_count_dl                 := lic_adl_count_dl;
   self._src_vehx_adl_count              := _src_vehx_adl_count;
   self.voter_adl_v_count_pos            := voter_adl_v_count_pos;
   self.iv_src_voter_adl_count           := iv_src_voter_adl_count;
   self.vote_adl_vo_lseen_pos            := vote_adl_vo_lseen_pos;
   self.vote_adl_lseen_vo                := vote_adl_lseen_vo;
   self._vote_adl_lseen_vo               := _vote_adl_lseen_vo;
   self._src_vote_adl_lseen              := _src_vote_adl_lseen;
   self.iv_mos_src_voter_adl_lseen       := iv_mos_src_voter_adl_lseen;
   self.final_score_0                    := final_score_0;
   self.final_score_1                    := final_score_1;
   self.final_score_2                    := final_score_2;
   self.final_score_3                    := final_score_3;
   self.final_score_4                    := final_score_4;
   self.final_score_5                    := final_score_5;
   self.final_score_6                    := final_score_6;
   self.final_score_7                    := final_score_7;
   self.final_score_8                    := final_score_8;
   self.final_score_9                    := final_score_9;
   self.final_score_10                   := final_score_10;
   self.final_score_11                   := final_score_11;
   self.final_score_12                   := final_score_12;
   self.final_score_13                   := final_score_13;
   self.final_score_14                   := final_score_14;
   self.final_score_15                   := final_score_15;
   self.final_score_16                   := final_score_16;
   self.final_score_17                   := final_score_17;
   self.final_score_18                   := final_score_18;
   self.final_score_19                   := final_score_19;
   self.final_score_20                   := final_score_20;
   self.final_score_21                   := final_score_21;
   self.final_score_22                   := final_score_22;
   self.final_score_23                   := final_score_23;
   self.final_score_24                   := final_score_24;
   self.final_score_25                   := final_score_25;
   self.final_score_26                   := final_score_26;
   self.final_score_27                   := final_score_27;
   self.final_score_28                   := final_score_28;
   self.final_score_29                   := final_score_29;
   self.final_score_30                   := final_score_30;
   self.final_score_31                   := final_score_31;
   self.final_score_32                   := final_score_32;
   self.final_score_33                   := final_score_33;
   self.final_score_34                   := final_score_34;
   self.final_score_35                   := final_score_35;
   self.final_score_36                   := final_score_36;
   self.final_score_37                   := final_score_37;
   self.final_score_38                   := final_score_38;
   self.final_score_39                   := final_score_39;
   self.final_score_40                   := final_score_40;
   self.final_score_41                   := final_score_41;
   self.final_score_42                   := final_score_42;
   self.final_score_43                   := final_score_43;
   self.final_score_44                   := final_score_44;
   self.final_score_45                   := final_score_45;
   self.final_score_46                   := final_score_46;
   self.final_score_47                   := final_score_47;
   self.final_score_48                   := final_score_48;
   self.final_score_49                   := final_score_49;
   self.final_score_50                   := final_score_50;
   self.final_score_51                   := final_score_51;
   self.final_score_52                   := final_score_52;
   self.final_score_53                   := final_score_53;
   self.final_score_54                   := final_score_54;
   self.final_score_55                   := final_score_55;
   self.final_score_56                   := final_score_56;
   self.final_score_57                   := final_score_57;
   self.final_score_58                   := final_score_58;
   self.final_score_59                   := final_score_59;
   self.final_score_60                   := final_score_60;
   self.final_score_61                   := final_score_61;
   self.final_score_62                   := final_score_62;
   self.final_score_63                   := final_score_63;
   self.final_score_64                   := final_score_64;
   self.final_score_65                   := final_score_65;
   self.final_score_66                   := final_score_66;
   self.final_score_67                   := final_score_67;
   self.final_score_68                   := final_score_68;
   self.final_score_69                   := final_score_69;
   self.final_score_70                   := final_score_70;
   self.final_score_71                   := final_score_71;
   self.final_score_72                   := final_score_72;
   self.final_score_73                   := final_score_73;
   self.final_score_74                   := final_score_74;
   self.final_score_75                   := final_score_75;
   self.final_score_76                   := final_score_76;
   self.final_score_77                   := final_score_77;
   self.final_score_78                   := final_score_78;
   self.final_score_79                   := final_score_79;
   self.final_score_80                   := final_score_80;
   self.final_score_81                   := final_score_81;
   self.final_score_82                   := final_score_82;
   self.final_score_83                   := final_score_83;
   self.final_score_84                   := final_score_84;
   self.final_score_85                   := final_score_85;
   self.final_score_86                   := final_score_86;
   self.final_score_87                   := final_score_87;
   self.final_score_88                   := final_score_88;
   self.final_score_89                   := final_score_89;
   self.final_score_90                   := final_score_90;
   self.final_score_91                   := final_score_91;
   self.final_score_92                   := final_score_92;
   self.final_score_93                   := final_score_93;
   self.final_score_94                   := final_score_94;
   self.final_score_95                   := final_score_95;
   self.final_score_96                   := final_score_96;
   self.final_score_97                   := final_score_97;
   self.final_score_98                   := final_score_98;
   self.final_score_99                   := final_score_99;
   self.final_score_100                  := final_score_100;
   self.final_score_101                  := final_score_101;
   self.final_score_102                  := final_score_102;
   self.final_score_103                  := final_score_103;
   self.final_score_104                  := final_score_104;
   self.final_score_105                  := final_score_105;
   self.final_score_106                  := final_score_106;
   self.final_score_107                  := final_score_107;
   self.final_score_108                  := final_score_108;
   self.final_score_109                  := final_score_109;
   self.final_score_110                  := final_score_110;
   self.final_score_111                  := final_score_111;
   self.final_score_112                  := final_score_112;
   self.final_score_113                  := final_score_113;
   self.final_score_114                  := final_score_114;
   self.final_score_115                  := final_score_115;
   self.final_score_116                  := final_score_116;
   self.final_score_117                  := final_score_117;
   self.final_score_118                  := final_score_118;
   self.final_score_119                  := final_score_119;
   self.final_score_120                  := final_score_120;
   self.final_score_121                  := final_score_121;
   self.final_score_122                  := final_score_122;
   self.final_score_123                  := final_score_123;
   self.final_score_124                  := final_score_124;
   self.final_score_125                  := final_score_125;
   self.final_score_126                  := final_score_126;
   self.final_score_127                  := final_score_127;
   self.final_score_128                  := final_score_128;
   self.final_score_129                  := final_score_129;
   self.final_score_130                  := final_score_130;
   self.final_score_131                  := final_score_131;
   self.final_score_132                  := final_score_132;
   self.final_score_133                  := final_score_133;
   self.final_score_134                  := final_score_134;
   self.final_score_135                  := final_score_135;
   self.final_score_136                  := final_score_136;
   self.final_score_137                  := final_score_137;
   self.final_score_138                  := final_score_138;
   self.final_score_139                  := final_score_139;
   self.final_score_140                  := final_score_140;
   self.final_score_141                  := final_score_141;
   self.final_score_142                  := final_score_142;
   self.final_score_143                  := final_score_143;
   self.final_score_144                  := final_score_144;
   self.final_score_145                  := final_score_145;
   self.final_score_146                  := final_score_146;
   self.final_score_147                  := final_score_147;
   self.final_score_148                  := final_score_148;
   self.final_score_149                  := final_score_149;
   self.final_score_150                  := final_score_150;
   self.final_score_151                  := final_score_151;
   self.final_score_152                  := final_score_152;
   self.final_score_153                  := final_score_153;
   self.final_score_154                  := final_score_154;
   self.final_score_155                  := final_score_155;
   self.final_score_156                  := final_score_156;
   self.final_score_157                  := final_score_157;
   self.final_score_158                  := final_score_158;
   self.final_score_159                  := final_score_159;
   self.final_score_160                  := final_score_160;
   self.final_score_161                  := final_score_161;
   self.final_score_162                  := final_score_162;
   self.final_score_163                  := final_score_163;
   self.final_score_164                  := final_score_164;
   self.final_score_165                  := final_score_165;
   self.final_score_166                  := final_score_166;
   self.final_score_167                  := final_score_167;
   self.final_score_168                  := final_score_168;
   self.final_score_169                  := final_score_169;
   self.final_score_170                  := final_score_170;
   self.final_score_171                  := final_score_171;
   self.final_score_172                  := final_score_172;
   self.final_score_173                  := final_score_173;
   self.final_score_174                  := final_score_174;
   self.final_score_175                  := final_score_175;
   self.final_score_176                  := final_score_176;
   self.final_score_177                  := final_score_177;
   self.final_score_178                  := final_score_178;
   self.final_score_179                  := final_score_179;
   self.final_score_180                  := final_score_180;
   self.final_score_181                  := final_score_181;
   self.final_score_182                  := final_score_182;
   self.final_score_183                  := final_score_183;
   self.final_score_184                  := final_score_184;
   self.final_score_185                  := final_score_185;
   self.final_score_186                  := final_score_186;
   self.final_score_187                  := final_score_187;
   self.final_score_188                  := final_score_188;
   self.final_score_189                  := final_score_189;
   self.final_score_190                  := final_score_190;
   self.final_score_191                  := final_score_191;
   self.final_score_192                  := final_score_192;
   self.final_score_193                  := final_score_193;
   self.final_score_194                  := final_score_194;
   self.final_score_195                  := final_score_195;
   self.final_score_196                  := final_score_196;
   self.final_score_197                  := final_score_197;
   self.final_score_198                  := final_score_198;
   self.final_score_199                  := final_score_199;
   self.final_score_200                  := final_score_200;
   self.final_score_201                  := final_score_201;
   self.final_score_202                  := final_score_202;
   self.final_score_203                  := final_score_203;
   self.final_score_204                  := final_score_204;
   self.final_score_205                  := final_score_205;
   self.final_score_206                  := final_score_206;
   self.final_score_207                  := final_score_207;
   self.final_score_208                  := final_score_208;
   self.final_score_209                  := final_score_209;
   self.final_score_210                  := final_score_210;
   self.final_score_211                  := final_score_211;
   self.final_score_212                  := final_score_212;
   self.final_score_213                  := final_score_213;
   self.final_score_214                  := final_score_214;
   self.final_score_215                  := final_score_215;
   self.final_score_216                  := final_score_216;
   self.final_score_217                  := final_score_217;
   self.final_score_218                  := final_score_218;
   self.final_score_219                  := final_score_219;
   self.final_score_220                  := final_score_220;
   self.final_score_221                  := final_score_221;
   self.final_score_222                  := final_score_222;
   self.final_score_223                  := final_score_223;
   self.final_score_224                  := final_score_224;
   self.final_score_225                  := final_score_225;
   self.final_score_226                  := final_score_226;
   self.final_score_227                  := final_score_227;
   self.final_score_228                  := final_score_228;
   self.final_score_229                  := final_score_229;
   self.final_score_230                  := final_score_230;
   self.final_score_231                  := final_score_231;
   self.final_score_232                  := final_score_232;
   self.final_score_233                  := final_score_233;
   self.final_score_234                  := final_score_234;
   self.final_score_235                  := final_score_235;
   self.final_score_236                  := final_score_236;
   self.final_score_237                  := final_score_237;
   self.final_score_238                  := final_score_238;
   self.final_score_239                  := final_score_239;
   self.final_score_240                  := final_score_240;
   self.final_score_241                  := final_score_241;
   self.final_score_242                  := final_score_242;
   self.final_score_243                  := final_score_243;
   self.final_score_244                  := final_score_244;
   self.final_score_245                  := final_score_245;
   self.final_score_246                  := final_score_246;
   self.final_score_247                  := final_score_247;
   self.final_score_248                  := final_score_248;
   self.final_score_249                  := final_score_249;
   self.final_score_250                  := final_score_250;
   self.final_score_251                  := final_score_251;
   self.final_score_252                  := final_score_252;
   self.final_score_253                  := final_score_253;
   self.final_score_254                  := final_score_254;
   self.final_score_255                  := final_score_255;
   self.final_score_256                  := final_score_256;
   self.final_score_257                  := final_score_257;
   self.final_score_258                  := final_score_258;
   self.final_score_259                  := final_score_259;
   self.final_score_260                  := final_score_260;
   self.final_score_261                  := final_score_261;
   self.final_score_262                  := final_score_262;
   self.final_score_263                  := final_score_263;
   self.final_score_264                  := final_score_264;
   self.final_score_265                  := final_score_265;
   self.final_score_266                  := final_score_266;
   self.final_score_267                  := final_score_267;
   self.final_score_268                  := final_score_268;
   self.final_score_269                  := final_score_269;
   self.final_score_270                  := final_score_270;
   self.final_score_271                  := final_score_271;
   self.final_score_272                  := final_score_272;
   self.final_score_273                  := final_score_273;
   self.final_score_274                  := final_score_274;
   self.final_score_275                  := final_score_275;
   self.final_score_276                  := final_score_276;
   self.final_score_277                  := final_score_277;
   self.final_score_278                  := final_score_278;
   self.final_score_279                  := final_score_279;
   self.final_score_280                  := final_score_280;
   self.final_score_281                  := final_score_281;
   self.final_score_282                  := final_score_282;
   self.final_score_283                  := final_score_283;
   self.final_score_284                  := final_score_284;
   self.final_score_285                  := final_score_285;
   self.final_score_286                  := final_score_286;
   self.final_score_287                  := final_score_287;
   self.final_score_288                  := final_score_288;
   self.final_score_289                  := final_score_289;
   self.final_score_290                  := final_score_290;
   self.final_score_291                  := final_score_291;
   self.final_score_292                  := final_score_292;
   self.final_score_293                  := final_score_293;
   self.final_score_294                  := final_score_294;
   self.final_score_295                  := final_score_295;
   self.final_score_296                  := final_score_296;
   self.final_score_297                  := final_score_297;
   self.final_score_298                  := final_score_298;
   self.final_score_299                  := final_score_299;
   self.final_score_300                  := final_score_300;
   self.final_score_301                  := final_score_301;
   self.final_score_302                  := final_score_302;
   self.final_score_303                  := final_score_303;
   self.final_score_304                  := final_score_304;
   self.final_score_305                  := final_score_305;
   self.final_score_306                  := final_score_306;
   self.final_score_307                  := final_score_307;
   self.final_score_308                  := final_score_308;
   self.final_score_309                  := final_score_309;
   self.final_score_310                  := final_score_310;
   self.final_score_311                  := final_score_311;
   self.final_score_312                  := final_score_312;
   self.final_score_313                  := final_score_313;
   self.final_score_314                  := final_score_314;
   self.final_score_315                  := final_score_315;
   self.final_score_316                  := final_score_316;
   self.final_score_317                  := final_score_317;
   self.final_score_318                  := final_score_318;
   self.final_score_319                  := final_score_319;
   self.final_score_320                  := final_score_320;
   self.final_score_321                  := final_score_321;
   self.final_score_322                  := final_score_322;
   self.final_score_323                  := final_score_323;
   self.final_score_324                  := final_score_324;
   self.final_score_325                  := final_score_325;
   self.final_score_326                  := final_score_326;
   self.final_score_327                  := final_score_327;
   self.final_score_328                  := final_score_328;
   self.final_score_329                  := final_score_329;
   self.final_score_330                  := final_score_330;
   self.final_score_331                  := final_score_331;
   self.final_score_332                  := final_score_332;
   self.final_score_333                  := final_score_333;
   self.final_score_334                  := final_score_334;
   self.final_score_335                  := final_score_335;
   self.final_score_336                  := final_score_336;
   self.final_score_337                  := final_score_337;
   self.final_score_338                  := final_score_338;
   self.final_score_339                  := final_score_339;
   self.final_score_340                  := final_score_340;
   self.final_score_341                  := final_score_341;
   self.final_score_342                  := final_score_342;
   self.final_score_343                  := final_score_343;
   self.final_score_344                  := final_score_344;
   self.final_score_345                  := final_score_345;
   self.final_score_346                  := final_score_346;
   self.final_score_347                  := final_score_347;
   self.final_score_348                  := final_score_348;
   self.final_score_349                  := final_score_349;
   self.final_score_350                  := final_score_350;
   self.final_score_351                  := final_score_351;
   self.final_score_352                  := final_score_352;
   self.final_score_353                  := final_score_353;
   self.final_score_354                  := final_score_354;
   self.final_score_355                  := final_score_355;
   self.final_score_356                  := final_score_356;
   self.final_score_357                  := final_score_357;
   self.final_score_358                  := final_score_358;
   self.final_score_359                  := final_score_359;
   self.final_score_360                  := final_score_360;
   self.final_score_361                  := final_score_361;
   self.final_score_362                  := final_score_362;
   self.final_score_363                  := final_score_363;
   self.final_score_364                  := final_score_364;
   self.final_score_365                  := final_score_365;
   self.final_score_366                  := final_score_366;
   self.final_score_367                  := final_score_367;
   self.final_score_368                  := final_score_368;
   self.final_score_369                  := final_score_369;
   self.final_score_370                  := final_score_370;
   self.final_score_371                  := final_score_371;
   self.final_score_372                  := final_score_372;
   self.final_score_373                  := final_score_373;
   self.final_score_374                  := final_score_374;
   self.final_score_375                  := final_score_375;
   self.final_score_376                  := final_score_376;
   self.final_score_377                  := final_score_377;
   self.final_score_378                  := final_score_378;
   self.final_score_379                  := final_score_379;
   self.final_score_380                  := final_score_380;
   self.final_score_381                  := final_score_381;
   self.final_score_382                  := final_score_382;
   self.final_score_383                  := final_score_383;
   self.final_score_384                  := final_score_384;
   self.final_score_385                  := final_score_385;
   self.final_score_386                  := final_score_386;
   self.final_score_387                  := final_score_387;
   self.final_score_388                  := final_score_388;
   self.final_score_389                  := final_score_389;
   self.final_score_390                  := final_score_390;
   self.final_score_391                  := final_score_391;
   self.final_score_392                  := final_score_392;
   self.final_score_393                  := final_score_393;
   self.final_score_394                  := final_score_394;
   self.final_score_395                  := final_score_395;
   self.final_score                      := final_score;
   self.base                             := base;
   self.pts                              := pts;
   self.lgt                              := lgt;
   self.fp1609_1_0_nooverrides           := fp1609_1_0_nooverrides;
   self.or_decsssn                       := or_decsssn;
   self.or_ssnpriordob                   := or_ssnpriordob;
   self.or_prisonaddr                    := or_prisonaddr;
   self.or_prisonphone                   := or_prisonphone;
   self.or_hraddr                        := or_hraddr;
   self.or_hrphone                       := or_hrphone;
   self.or_invalidssn                    := or_invalidssn;
   self.or_invalidaddr                   := or_invalidaddr;
   self.or_invalidphone                  := or_invalidphone;
   self.fp1609_1_0_score                 := fp1609_1_0_score;
   self.fp1609_1_0                       := fp1609_1_0;
	 self.college_code										 := college_code;
	 self.college_major										 := college_major;
	 SELF.hh_members_ct                    := hh_members_ct;
	 SELF.hh_payday_loan_users             := hh_payday_loan_users;
	 SELF.rel_felony_count                 := rel_felony_count;
   self._ver_src_ds                      := _ver_src_ds;
   self._ver_src_de                      := _ver_src_de;
   self._ver_src_eq                      := _ver_src_eq;
   self._ver_src_en                      := _ver_src_en;
   self._ver_src_tn                      := _ver_src_tn;
   self._ver_src_tu                      := _ver_src_tu;
   self._credit_source_cnt               := _credit_source_cnt;
   self._ver_src_cnt                     := _ver_src_cnt;
   self._bureauonly                      := _bureauonly;
   self._derog                           := _derog;
   self._deceased                        := _deceased;
   self._ssnpriortodob                   := _ssnpriortodob;
   self._inputmiskeys                    := _inputmiskeys;
   self._multiplessns                    := _multiplessns;
   self._hh_strikes                      := _hh_strikes;
   self.stolenid                         := stolenid;
   self.manipulatedid                    := manipulatedid;
   self.manipulatedidpt2                 := manipulatedidpt2;
   self.syntheticid                      := syntheticid;
   self.suspiciousactivity               := suspiciousactivity;
   self.vulnerablevictim                 := vulnerablevictim;
   self.friendlyfraud                    := friendlyfraud;
   self.stolenc_fp1609_1_0               := stolenc_fp1609_1_0;
   self.manip2c_fp1609_1_0               := manip2c_fp1609_1_0;
   self.synthc_fp1609_1_0                := synthc_fp1609_1_0;
   self.suspactc_fp1609_1_0              := suspactc_fp1609_1_0;
   self.vulnvicc_fp1609_1_0              := vulnvicc_fp1609_1_0;
   self.friendlyc_fp1609_1_0             := friendlyc_fp1609_1_0;
   self.custstolidindex                  := custstolidindex;
   self.custmanipidindex                 := custmanipidindex;
   self.custsynthidindex                 := custsynthidindex;
   self.custsuspactindex                 := custsuspactindex;
   self.custvulnvicindex                 := custvulnvicindex;
   self.custfriendfrdindex               := custfriendfrdindex;
   self.clam														 := le;

#end

	self.seq := le.seq;
	self.StolenIdentityIndex := (string) custstolidindex;
	self.SyntheticIdentityIndex:= (string) custsynthidindex;
	self.ManipulatedIdentityIndex:= (string) custmanipidindex;
	self.VulnerableVictimIndex := (string) custvulnvicindex;
	self.FriendlyFraudIndex                := (string) custfriendfrdindex;
	self.SuspiciousActivityIndex := (string) custsuspactindex;
	ritmp :=  Models.fraudpoint3_reasons(le, blank_ip, num_reasons );
	reasons := Models.Common.checkFraudPointRC34(FP1609_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)FP1609_1_0;
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