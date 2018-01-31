import Std, risk_indicators, riskwise, riskwisefcra, ut, easi, Models;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1702_1_0(dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons)
									 := FUNCTION
									
		FP_DEBUG := false;
		
		isFCRA := False;

	#if(FP_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
	Integer seq;
  Integer	 sysdate;
  Integer	 f_phone_ver_experian_d;
  Boolean	 k_nap_phn_verd_d;
  Real	   f_rel_homeover500_count_d;
  Real	   f_phone_ver_insurance_d;
  real  	 r_c12_source_profile_d;
  Real	   r_a49_curr_avm_chg_1yr_i;
  Real	   f_addrchangeecontrajindex_d;
  Real	 		r_phn_cell_n;
  Real	 		f_prevaddrageoldest_d;
  Real	 		r_phn_pcs_n;
  Real		 r_a46_curr_avm_autoval_d;
  REAL	   r_wealth_index_d;
  Real	 	f_hh_lienholders_i;
  Real	 	k_inq_per_phone_i;
  REAL  	 f_idverrisktype_i;
  Real	 	 f_rel_homeover300_count_d;
  Real	 	 r_p88_phn_dst_to_inp_add_i;
  Real	 	 r_f03_address_match_d;
  Real	 	 r_c13_max_lres_d;
  Real		 r_c14_addr_stability_v2_d;
  Real		 r_l80_inp_avm_autoval_d;
  Real	 	 r_f00_dob_score_d;
  Real	 	f_hh_tot_derog_i;
  REAL  	 f_validationrisktype_i;
  REAL	 r_i61_inq_collection_recency_d;
  REAL	 r_c23_inp_addr_occ_index_d;
  REAL	 f_rel_under25miles_cnt_d;
  REAL	 r_p85_phn_disconnected_i;
  REAL	 r_f03_input_add_not_most_rec_i;
  String	 nf_seg_fraudpoint_3_0;
  REAL	 f_addrs_per_ssn_i;
  REAL	 k_inq_adls_per_phone_i;
  REAL	 _header_first_seen;
  REAL	 r_c10_m_hdr_fs_d;
  REAL	 f_rel_educationover12_count_d;
  REAL	 f_prevaddrlenofres_d;
  Integer	 k_inf_phn_verd_d;
  REAL	 f_bus_addr_match_count_d;
  REAL	 f_phones_per_addr_curr_i;
  REAL	 k_inq_per_ssn_i;
  REAL	 r_l79_adls_per_addr_c6_i;
  REAL	 k_inq_lnames_per_addr_i;
  REAL	 f_rel_under500miles_cnt_d;
  REAL	 r_d30_derog_count_i;
  REAL	 f_rel_under100miles_cnt_d;
  REAL	 r_d31_mostrec_bk_i;
  REAL	 r_c13_curr_addr_lres_d;
  REAL	 f_srchcomponentrisktype_i;
  REAL	 f_hh_bankruptcies_i;
  REAL	 r_f00_input_dob_match_level_d;
  REAL	 _src_bureau_adl_fseen_notu;
  REAL	 f_m_bureau_adl_fs_notu_d;
  REAL	 r_l79_adls_per_addr_curr_i;
  REAL	 r_e57_br_source_count_d;
  REAL	 r_f00_ssn_score_d;
  REAL	 f_srchunvrfdaddrcount_i;
  Integer	 bureau_adl_en_fseen_pos;
  String	 bureau_adl_fseen_en;
  REAL		 _bureau_adl_fseen_en;
  Integer	 bureau_adl_ts_fseen_pos;
  String	 		bureau_adl_fseen_ts;
  REAL	 _bureau_adl_fseen_ts;
  Integer	 bureau_adl_tu_fseen_pos;
  String 		bureau_adl_fseen_tu;
  REAL	 		_bureau_adl_fseen_tu;
  Integer	 bureau_adl_tn_fseen_pos;
  String	 		bureau_adl_fseen_tn;
  REAL	 	_bureau_adl_fseen_tn;
  REAL	 _src_bureau_adl_fseen_all;
  REAL	 f_m_bureau_adl_fs_all_d;
  REAL	 _liens_unrel_cj_first_seen;
  REAL	 f_mos_liens_unrel_cj_fseen_d;
  REAL	 f_recent_disconnects_i;
  REAL	 bureau_adl_eq_fseen_pos;
  String	 bureau_adl_fseen_eq;
  REAL	 _bureau_adl_fseen_eq;
  REAL	 _src_bureau_adl_fseen;
  REAL	 r_c21_m_bureau_adl_fs_d;
  REAL	 _liens_unrel_cj_last_seen;
  REAL	 f_mos_liens_unrel_cj_lseen_d;
  real	 r_a49_curr_avm_chg_1yr_pct_i;
  REAL	 r_f01_inp_addr_address_score_d;
  REAL	 f_srchunvrfdphonecount_i;
  String	 r_d31_bk_chapter_n;
  REAL	 f_rel_criminal_count_i;
  REAL	 f_srchvelocityrisktype_i;
  REAL	 f_rel_homeover200_count_d;
  Boolean	 k_inf_contradictory_i;
  REAL	 f_rel_incomeover50_count_d;
  Boolean	 k_inf_lname_verd_d;
  REAL	 k_inq_ssns_per_addr_i;
  REAL	 nf_number_non_bureau_sources;
  Integer	 k_inq_adls_per_addr_i;
  real	 r_c12_source_profile_index_d;
  Boolean	 _add_not_ver;
  Integer	 nf_inq_per_add_nas_479;
  Integer	 f_property_owners_ct_d;
  Integer	 f_inq_count24_i;
  Integer	 r_c12_num_nonderogs_d;
  Integer	 f_hh_members_w_derog_i;
  Integer	 f_rel_incomeover100_count_d;
  Integer	 f_dl_addrs_per_adl_i;
  Integer	 f_historical_count_d;
  Integer	 r_p85_phn_not_issued_i;
  Integer	 f_rel_homeover150_count_d;
  Integer	 f_hh_collections_ct_i;
  Integer	 k_inq_addrs_per_ssn_i;
  Integer	 f_assocsuspicousidcount_i;
  Integer	 f_bus_fname_verd_d;
  Integer	 _criminal_last_date;
  Integer	 r_d32_mos_since_crim_ls_d;
  Integer	 r_s66_adlperssn_count_i;
  Integer	 r_i60_inq_mortgage_recency_d;
  Integer	 f_hh_college_attendees_d;
  Integer	 r_i60_inq_retail_recency_d;
  Integer	 f_rel_homeover100_count_d;
  Integer	 r_c18_invalid_addrs_per_adl_i;
  Integer	 k_inq_per_addr_i;
  Integer	 f_rel_count_i;
  Integer	 r_i60_inq_banking_recency_d;
  Integer	 r_d34_unrel_liens_ct_i;
  Integer	 f_crim_rel_under100miles_cnt_i;
  Integer	 _acc_last_seen;
  Integer	 f_mos_acc_lseen_d;
  Integer	 r_i60_inq_hiriskcred_recency_d;
  Integer	 f_util_adl_count_n;
  String	 add_ec1;
  String	 add_ec3;
  String	 add_ec4;
  Integer	 r_l70_add_standardized_i;
  Integer	 f_rel_incomeover75_count_d;
  Integer	 f_accident_count_i;
  Integer	 f_phones_per_addr_c6_i;
  Integer	 f_varrisktype_i;
  Integer	 _liens_rel_ot_first_seen;
  Integer	 f_mos_liens_rel_ot_fseen_d;
  Integer	 f_crim_rel_under500miles_cnt_i;
  Integer	 r_l70_add_invalid_i;
  Integer	 f_divrisktype_i;
  Integer	 f_assoccredbureaucount_i;
  Boolean	 bureau_;
  Boolean	 behavioral_;
  Boolean	 government_;
  String	 nf_source_type;
  Integer	 r_c14_addrs_5yr_i;
  Integer	 f_prevaddrstatus_i;
  Integer	 f_assocrisktype_i;
  Integer	 f_rel_homeover50_count_d;
  Boolean	 k_nap_fname_verd_d;
  Integer	 f_rel_incomeover25_count_d;
  Integer	 f_inq_retail_count24_i;
  Integer	 k_inq_lnames_per_ssn_i;
  Integer	 f_current_count_d;
  Integer	 f_inq_other_count24_i;
  Integer	 r_e55_college_ind_d;
  Integer	 f_adl_util_misc_n;
  Integer	 f_curraddractivephonelist_d;
  Integer	 f_divaddrsuspidcountnew_i;
  Integer	 f_srchphonesrchcountwk_i;
  Integer	 f_accident_recency_d;
  Integer	 f_hh_members_ct_d;
  Integer	 f_hh_prof_license_holders_d;
  Integer	 f_vardobcount_i;
  Integer	 k_inq_adls_per_ssn_i;
  Integer	 f_srchphonesrchcountmo_i;
  Integer	 r_l77_add_po_box_i;
  Boolean	 k_nap_lname_verd_d;
  Integer	 r_i60_inq_retail_count12_i;
  Integer	 r_a41_prop_owner_inp_only_d;
  Integer	 f_addrs_per_ssn_c6_i;
  Integer	 r_a43_watercraft_cnt_d;
  Integer	 _liens_unrel_ot_last_seen;
  Integer	 f_mos_liens_unrel_ot_lseen_d;
  Integer	 r_a44_curr_add_naprop_d;
  Integer	 f_inq_quizprovider_count24_i;
  Integer	 f_rel_bankrupt_count_i;
  Integer	 r_i60_inq_count12_i;
  Integer	 r_s65_ssn_problem_i;
  Integer	 f_inputaddractivephonelist_d;
  Integer	 r_l71_add_business_i;
  Integer	 r_i60_inq_recency_d;
  Integer	 r_c14_addrs_15yr_i;
  Integer	 f_util_add_input_conv_n;
  Integer	 f_inq_retailpayments_count24_i;
  Boolean	 k_inf_addr_verd_d;
  Integer	 r_f04_curr_add_occ_index_d;
  Integer	 f_bus_lname_verd_d;
  Integer	 _liens_unrel_st_last_seen;
  Integer	 f_mos_liens_unrel_st_lseen_d;
  Integer	 r_d32_criminal_count_i;
  Integer	 f_crim_rel_under25miles_cnt_i;
  Integer	 r_i60_inq_auto_recency_d;
  Integer	 f_srchfraudsrchcountwk_i;
  Integer	 f_inq_mortgage_count24_i;
  Integer	 f_util_add_curr_conv_n;
  Integer	 r_c15_ssns_per_adl_c6_i;
  Integer	 f_bus_phone_match_d;
  Integer	 r_l78_no_phone_at_addr_vel_i;
  Integer	 r_l72_add_vacant_i;
  Integer	 f_srchcountwk_i;
  Integer	 _felony_last_date;
  Integer	 r_d32_mos_since_fel_ls_d;
  Integer	 r_d31_bk_filing_count_i;
  Integer	 r_i60_inq_retpymt_recency_d;
  Integer	 f_liens_unrel_ft_total_amt_i;
  Integer	 f_inq_banking_count24_i;
  Integer	 f_acc_damage_amt_total_i;
  REAL		 final_score_0;
  REAL		 Final_score_1;
  REAL		 final_score_2;
  REAL		 final_score_3;
  REAL		 final_score_4;
  REAL		 final_score_5;
  REAL		 final_score_6;
  REAL		 final_score_7;
  REAL		 final_score_8;
  REAL		 final_score_9;
  REAL		 final_score_10;
  REAL		 final_score_11;
  REAL		 final_score_12;
  REAL		 final_score_13;
  REAL		 final_score_14;
  REAL		 final_score_15;
  REAL		 final_score_16;
  REAL		 final_score_17;
  REAL		 final_score_18;
  REAL		 final_score_19;
  REAL		 final_score_20;
  REAL		 final_score_21;
  REAL		 final_score_22;
  REAL		 final_score_23;
  REAL		 final_score_24;
  REAL		 final_score_25;
  REAL		 final_score_26;
  REAL		 final_score_27;
  REAL		 final_score_28;
  REAL		 final_score_29;
  REAL		 final_score_30;
  REAL		 final_score_31;
  REAL		 final_score_32;
  REAL		 final_score_33;
  REAL		 final_score_34;
  REAL		 final_score_35;
  REAL		 final_score_36;
  REAL		 final_score_37;
  REAL		 final_score_38;
  REAL		 final_score_39;
  REAL		 final_score_40;
  REAL		 final_score_41;
  REAL		 final_score_42;
  REAL		 final_score_43;
  REAL		 final_score_44;
  REAL		 final_score_45;
  REAL		 final_score_46;
  REAL		 final_score_47;
  REAL		 final_score_48;
  REAL		 final_score_49;
  REAL		 final_score_50;
  REAL		 final_score_51;
  REAL		 final_score_52;
  REAL		 final_score_53;
  REAL		 final_score_54;
  REAL		 final_score_55;
  REAL		 final_score_56;
  REAL		 final_score_57;
  REAL		 final_score_58;
  REAL		 final_score_59;
  REAL		 final_score_60;
  REAL		 final_score_61;
  REAL		 final_score_62;
  REAL		 final_score_63;
  REAL		 final_score_64;
  REAL		 final_score_65;
  REAL		 final_score_66;
  REAL		 final_score_67;
  REAL		 final_score_68;
  REAL		 final_score_69;
  REAL		 final_score_70;
  REAL		 final_score_71;
  REAL		 final_score_72;
  REAL		 final_score_73;
  REAL		 final_score_74;
  REAL		 final_score_75;
  REAL		 final_score_76;
  REAL		 final_score_77;
  REAL		 final_score_78;
  REAL		 final_score_79;
  REAL		 final_score_80;
  REAL		 final_score_81;
  REAL		 final_score_82;
  REAL		 final_score_83;
  REAL		 final_score_84;
  REAL		 final_score_85;
  REAL		 final_score_86;
  REAL		 final_score_87;
  REAL		 final_score_88;
  REAL		 final_score_89;
  REAL		 final_score_90;
  REAL		 final_score_91;
  REAL		 final_score_92;
  REAL		 final_score_93;
  REAL		 final_score_94;
  REAL		 final_score_95;
  REAL		 final_score_96;
  REAL		 final_score_97;
  REAL		 final_score_98;
  REAL		 final_score_99;
  REAL		 final_score_100;
  REAL		 final_score_101;
  REAL		 final_score_102;
  REAL		 final_score_103;
  REAL		 final_score_104;
  REAL		 final_score_105;
  REAL		 final_score_106;
  REAL		 final_score_107;
  REAL		 final_score_108;
  REAL		 final_score_109;
  REAL		 final_score_110;
  REAL		 final_score_111;
  REAL		 final_score_112;
  REAL		 final_score_113;
  REAL		 final_score_114;
  REAL		 final_score_115;
  REAL		 final_score_116;
  REAL		 final_score_117;
  REAL		 final_score_118;
  REAL  	 final_score_119;
  REAL   	 final_score_120;
  REAL   	 final_score_121;
  REAL   	 final_score_122;
  REAL   	 final_score_123;
  REAL   	 final_score_124;
  REAL   	 final_score_125;
  REAL   	 final_score_126;
  REAL   	 final_score_127;
  REAL   	 final_score_128;
  REAL   	 final_score_129;
  REAL   	 final_score_130;
  REAL   	 final_score_131;
  REAL   	 final_score_132;
  REAL   	 final_score_133;
  REAL   	 final_score_134;
  REAL   	 final_score_135;
  REAL   	 final_score_136;
  REAL   	 final_score_137;
  REAL   	 final_score_138;
  REAL   	 final_score_139;
  REAL   	 final_score_140;
  REAL   	 final_score_141;
  REAL   	 final_score_142;
  REAL   	 final_score_143;
  REAL   	 final_score_144;
  REAL   	 final_score_145;
  REAL   	 final_score_146;
  REAL   	 final_score_147;
  REAL   	 final_score_148;
  REAL   	 final_score_149;
  REAL   	 final_score_150;
  REAL   	 final_score_151;
  REAL   	 final_score_152;
  REAL   	 final_score_153;
  REAL   	 final_score_154;
  REAL   	 final_score_155;
  REAL   	 final_score_156;
  REAL   	 final_score_157;
  REAL   	 final_score_158;
  REAL   	 final_score_159;
  REAL   	 final_score_160;
  REAL   	 final_score_161;
  REAL   	 final_score_162;
  REAL   	 final_score_163;
  REAL   	 final_score_164;
  REAL   	 final_score_165;
  REAL   	 final_score_166;
  REAL   	 final_score_167;
  REAL   	 final_score_168;
  REAL   	 final_score_169;
  REAL   	 final_score_170;
  REAL   	 final_score_171;
  REAL   	 final_score_172;
  REAL   	 final_score_173;
  REAL   	 final_score_174;
  REAL   	 final_score_175;
  REAL   	 final_score_176;
  REAL   	 final_score_177;
  REAL   	 final_score_178;
  REAL   	 final_score_179;
  REAL   	 final_score_180;
  REAL   	 final_score_181;
  REAL   	 final_score_182;
  REAL   	 final_score_183;
  REAL   	 final_score_184;
  REAL   	 final_score_185;
  REAL   	 final_score_186;
  REAL   	 final_score_187;
  REAL   	 final_score_188;
  REAL   	 final_score_189;
  REAL   	 final_score_190;
  REAL   	 final_score_191;
  REAL   	 final_score_192;
  REAL   	 final_score_193;
  REAL   	 final_score_194;
  REAL   	 final_score_195;
  REAL   	 final_score_196;
  REAL   	 final_score_197;
  REAL   	 final_score_198;
  REAL   	 final_score_199;
  REAL   	 final_score_200;
  REAL   	 final_score_201;
  REAL   	 final_score_202;
  REAL   	 final_score_203;
  REAL   	 final_score_204;
  REAL   	 final_score_205;
  REAL   	 final_score_206;
  REAL   	 final_score_207;
  REAL   	 final_score_208;
  REAL   	 final_score_209;
  REAL   	 final_score_210;
  REAL   	 final_score_211;
  REAL   	 final_score_212;
  REAL   	 final_score_213;
  REAL   	 final_score_214;
  REAL   	 final_score_215;
  REAL   	 final_score_216;
  REAL   	 final_score_217;
  REAL   	 final_score_218;
  REAL   	 final_score_219;
  REAL   	 final_score_220;
  REAL   	 final_score_221;
  REAL   	 final_score_222;
  REAL   	 final_score_223;
  REAL   	 final_score_224;
  REAL   	 final_score_225;
  REAL   	 final_score_226;
  REAL   	 final_score_227;
  REAL   	 final_score_228;
  REAL   	 final_score_229;
  REAL   	 final_score_230;
  REAL   	 final_score_231;
  REAL   	 final_score_232;
  REAL   	 final_score_233;
  REAL   	 final_score_234;
  REAL   	 final_score_235;
  REAL   	 final_score_236;
  REAL   	 final_score_237;
  REAL   	 final_score_238;
  REAL   	 final_score_239;
  REAL   	 final_score_240;
  REAL   	 final_score_241;
  REAL   	 final_score_242;
  REAL   	 final_score_243;
  REAL   	 final_score_244;
  REAL   	 final_score_245;
  REAL   	 final_score_246;
  REAL   	 final_score_247;
  REAL   	 final_score_248;
  REAL   	 final_score_249;
  REAL   	 final_score_250;
  REAL   	 final_score_251;
  REAL   	 final_score_252;
  REAL   	 final_score_253;
  REAL   	 final_score_254;
  REAL   	 final_score_255;
  REAL   	 final_score_256;
  REAL   	 final_score_257;
  REAL   	 final_score_258;
  REAL   	 final_score_259;
  REAL   	 final_score_260;
  REAL   	 final_score_261;
  REAL   	 final_score_262;
  REAL   	 final_score_263;
  REAL   	 final_score_264;
  REAL   	 final_score_265;
  REAL   	 final_score_266;
  REAL   	 final_score_267;
  REAL   	 final_score_268;
  REAL   	 final_score_269;
  REAL   	 final_score_270;
  REAL   	 final_score_271;
  REAL   	 final_score_272;
  REAL   	 final_score_273;
  REAL   	 final_score_274;
  REAL   	 final_score_275;
  REAL   	 final_score_276;
  REAL   	 final_score_277;
  REAL   	 final_score_278;
  REAL   	 final_score_279;
  REAL   	 final_score_280;
  REAL   	 final_score_281;
  REAL   	 final_score_282;
  REAL   	 final_score_283;
  REAL   	 final_score_284;
  REAL   	 final_score_285;
  REAL   	 final_score_286;
  REAL   	 final_score_287;
  REAL   	 final_score_288;
  REAL   	 final_score_289;
  REAL   	 final_score_290;
  REAL   	 final_score_291;
  REAL   	 final_score_292;
  REAL   	 final_score_293;
  REAL   	 final_score_294;
  REAL   	 final_score_295;
  REAL   	 final_score_296;
  REAL   	 final_score_297;
  REAL   	 final_score_298;
  REAL   	 final_score_299;
  REAL   	 final_score_300;
  REAL   	 final_score_301;
  REAL   	 final_score_302;
  REAL   	 final_score_303;
  REAL   	 final_score_304;
  REAL   	 final_score_305;
  REAL   	 final_score_306;
  REAL   	 final_score_307;
  REAL   	 final_score_308;
  REAL   	 final_score_309;
  REAL   	 final_score_310;
  REAL   	 final_score_311;
  REAL   	 final_score_312;
  REAL   	 final_score_313;
  REAL   	 final_score_314;
  REAL   	 final_score_315;
  REAL   	 final_score_316;
  REAL   	 final_score_317;
  REAL   	 final_score_318;
  REAL   	 final_score_319;
  REAL   	 final_score_320;
  REAL   	 final_score_321;
  REAL   	 final_score_322;
  REAL   	 final_score_323;
  REAL   	 final_score_324;
  REAL   	 final_score_325;
  REAL   	 final_score_326;
  REAL   	 final_score_327;
  REAL   	 final_score_328;
  REAL   	 final_score_329;
  REAL   	 final_score_330;
  REAL   	 final_score_331;
  REAL   	 final_score_332;
  REAL   	 final_score_333;
  REAL   	 final_score_334;
  REAL   	 final_score_335;
  REAL   	 final_score_336;
  REAL   	 final_score_337;
  REAL   	 final_score_338;
  REAL   	 final_score_339;
  REAL   	 final_score_340;
  REAL   	 final_score_341;
  REAL   	 final_score_342;
  REAL   	 final_score_343;
  REAL   	 final_score_344;
  REAL   	 final_score_345;
  REAL   	 final_score_346;
  REAL   	 final_score;
  Integer	 base;
  REAL	   odds;
  Integer	 point;
  Integer	 fp1702_1_0;
  Boolean	 _ver_src_ds;
  Boolean	 _ver_src_de;
  Boolean	 _ver_src_eq;
  Boolean	 _ver_src_en;
  Boolean	 _ver_src_tn;
  Boolean	 _ver_src_tu;
  Integer	 _credit_source_cnt;
  Integer	 _ver_src_cnt;
  Boolean	 _bureauonly;
  Boolean	 _derog;
  Boolean	 _deceased;
  Boolean	 _ssnpriortodob;
  Boolean	 _inputmiskeys;
  Boolean	 _multiplessns;
  Integer	 _hh_strikes;
  Integer	 stolenid;
  Integer	 manipulatedid;
  Integer	 manipulatedidpt2;
  Integer	 suspiciousactivity;
  Integer	 vulnerablevictim;
  Integer	 friendlyfraud;
  Boolean	 ver_src_ak;
  Boolean	 ver_src_am;
  Boolean	 ver_src_ar;
  Boolean	 ver_src_ba;
  Boolean	 ver_src_cg;
  Boolean	 ver_src_co;
  Boolean	 ver_src_cy;
  Boolean	 ver_src_da;
  Boolean	 ver_src_d;
  Boolean	 ver_src_dl;
  Boolean	 ver_src_ds;
  Boolean	 ver_src_de;
  Boolean	 ver_src_eb;
  Boolean	 ver_src_em;
  Boolean	 ver_src_e1;
  Boolean	 ver_src_e2;
  Boolean	 ver_src_e3;
  Boolean	 ver_src_e4;
  Boolean	 ver_src_en;
  Boolean	 ver_src_eq;
  Boolean	 ver_src_fe;
  Boolean	 ver_src_ff;
  Boolean	 ver_src_fr;
  Boolean	 ver_src_l2;
  Boolean	 ver_src_li;
  Boolean	 ver_src_mw;
  Boolean	 ver_src_nt;
  Boolean	 ver_src_p;
  Boolean	 ver_src_pl;
  Boolean	 ver_src_tn;
  Boolean	 ver_src_ts;
  Boolean	 ver_src_tu;
  Boolean	 ver_src_sl;
  Boolean	 ver_src_v;
  Boolean	 ver_src_vo;
  Boolean	 ver_src_w;
  Boolean	 ver_src_wp;
  Integer	 src_bureau;
  Integer	 src_behavioral;
  Integer	 src_inperson;
  Integer	 syntheticid2;
  Integer	 stolenc_fp1702_1_0;
  Integer	 manip2c_fp1702_1_0;
  Integer	 synth2c_fp1702_1_0;
  Integer	 suspactc_fp1702_1_0;
  Integer	 vulnvicc_fp1702_1_0;
  Integer	 friendlyc_fp1702_1_0;
  Integer	 custstolidindex;
  Integer	 custmanipidindex;
  Integer	 custsynthidindex;
  Integer	 custsuspactindex;
  Integer	 custvulnvicindex;
  Integer	 custfriendfrdindex;

			models.layouts.layout_fp1109;
			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layouts.layout_fp1109 doModel( clam le ) := TRANSFORM
		
  #end	

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
		truedid                          := le.truedid;
	out_z5                           := le.shell_input.z5;
	out_addr_type                    := le.shell_input.addr_type;
	out_addr_status                  := le.shell_input.addr_status;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_type                         := le.iid.nap_type;
	nap_status                       := le.iid.nap_status;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_pwphonezipflag                := le.iid.pwphonezipflag;
	rc_hriskaddrflag                 := le.iid.hriskaddrflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnvalflag                    := le.iid.socsvalflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
	rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
	rc_disthphoneaddr                := le.iid.disthphoneaddr;
	rc_ziptypeflag                   := le.iid.ziptypeflag;
	rc_zipclass                      := le.iid.zipclass;
	combo_ssnscore                   := le.iid.combo_ssnscore;
	combo_dobscore                   := le.iid.combo_dobscore;
	hdr_source_profile               := le.source_profile;
	hdr_source_profile_index         := le.source_profile_index;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	bus_addr_match_count             := le.business_header_address_summary.bus_addr_match_cnt;
	bus_name_match                   := le.business_header_address_summary.bus_name_match;
	bus_phone_match                  := le.business_header_address_summary.bus_phone_match;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	util_adl_type_list               := le.utility.utili_adl_type;
	util_adl_count                   := le.utility.utili_adl_count;
	util_add_input_type_list         := le.utility.utili_addr1_type;
	util_add_curr_type_list          := le.utility.utili_addr2_type;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
	add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	add_curr_isbestmatch             := le.address_verification.address_history_1.isbestmatch;
	add_curr_lres                    := le.lres2;
	add_curr_occ_index               := le.address_verification.currAddr_occupancy_index;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_avm_auto_val_2          := le.avm.address_history_1.avm_automated_valuation2;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	max_lres                         := le.other_address_info.max_lres;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	addrs_prison_history             := le.other_address_info.isprison;
	telcordia_type                   := le.phone_verification.telcordia_type;
	recent_disconnects               := if(isFCRA, 0, le.phone_verification.recent_disconnects);
	phone_ver_insurance              := le.insurance_phones_summary.Insurance_Phone_Verification;
	phone_ver_experian               := le.Experian_Phone_Verification;
	header_first_seen                := le.ssn_verification.header_first_seen;
	inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	adls_per_ssn                     := le.SSN_Verification.adlPerSSN_count;
	addrs_per_ssn                    := if(isFCRA, 0, le.velocity_counters.addrs_per_ssn );
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	phones_per_addr_curr             := le.velocity_counters.phones_per_addr_current;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	lnames_per_adl_c6                := if(isFCRA, 0, le.velocity_counters.lnames_per_adl180);
	addrs_per_ssn_c6                 := if(isFCRA, 0, le.velocity_counters.addrs_per_ssn_created_6months );
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	phones_per_addr_c6               := if(isFCRA, 0, le.velocity_counters.phones_per_addr_created_6months );
	dl_addrs_per_adl                 := le.velocity_counters.dl_addrs_per_adl;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	invalid_ssns_per_adl_c6          := le.velocity_counters.invalid_ssns_per_adl_created_6months;
	invalid_addrs_per_adl            := le.velocity_counters.invalid_addrs_per_adl;
	inq_count                        := le.acc_logs.inquiries.counttotal;
	inq_count01                      := le.acc_logs.inquiries.count01;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count06                      := le.acc_logs.inquiries.count06;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_count24                      := le.acc_logs.inquiries.count24;
	inq_auto_count                   := le.acc_logs.auto.counttotal;
	inq_auto_count01                 := le.acc_logs.auto.count01;
	inq_auto_count03                 := le.acc_logs.auto.count03;
	inq_auto_count06                 := le.acc_logs.auto.count06;
	inq_auto_count12                 := le.acc_logs.auto.count12;
	inq_auto_count24                 := le.acc_logs.auto.count24;
	inq_banking_count                := le.acc_logs.banking.counttotal;
	inq_banking_count01              := le.acc_logs.banking.count01;
	inq_banking_count03              := le.acc_logs.banking.count03;
	inq_banking_count06              := le.acc_logs.banking.count06;
	inq_banking_count12              := le.acc_logs.banking.count12;
	inq_banking_count24              := le.acc_logs.banking.count24;
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
	inq_mortgage_count               := le.acc_logs.mortgage.counttotal;
	inq_mortgage_count01             := le.acc_logs.mortgage.count01;
	inq_mortgage_count03             := le.acc_logs.mortgage.count03;
	inq_mortgage_count06             := le.acc_logs.mortgage.count06;
	inq_mortgage_count12             := le.acc_logs.mortgage.count12;
	inq_mortgage_count24             := le.acc_logs.mortgage.count24;
	inq_other_count24                := le.acc_logs.other.count24;
	inq_quizprovider_count24         := le.acc_logs.quizprovider.count24;
	inq_retail_count                 := le.acc_logs.retail.counttotal;
	inq_retail_count01               := le.acc_logs.retail.count01;
	inq_retail_count03               := le.acc_logs.retail.count03;
	inq_retail_count06               := le.acc_logs.retail.count06;
	inq_retail_count12               := le.acc_logs.retail.count12;
	inq_retail_count24               := le.acc_logs.retail.count24;
	inq_retailpayments_count         := le.acc_logs.retailpayments.counttotal;
	inq_retailpayments_count01       := le.acc_logs.retailpayments.count01;
	inq_retailpayments_count03       := le.acc_logs.retailpayments.count03;
	inq_retailpayments_count06       := le.acc_logs.retailpayments.count06;
	inq_retailpayments_count12       := le.acc_logs.retailpayments.count12;
	inq_retailpayments_count24       := le.acc_logs.retailpayments.count24;
	inq_perssn                       := if(isFCRA, 0, le.acc_logs.inquiryPerSSN );
	inq_adlsperssn                   := if(isFCRA, 0, le.acc_logs.inquiryADLsPerSSN );
	inq_lnamesperssn                 := if(isFCRA, 0, le.acc_logs.inquiryLNamesPerSSN );
	inq_addrsperssn                  := if(isFCRA, 0, le.acc_logs.inquiryAddrsPerSSN );
	inq_peraddr                      := if(isFCRA, 0, le.acc_logs.inquiryPerAddr );
	inq_adlsperaddr                  := if(isFCRA, 0, le.acc_logs.inquiryADLsPerAddr );
	inq_lnamesperaddr                := if(isFCRA, 0, le.acc_logs.inquiryLNamesPerAddr );
	inq_ssnsperaddr                  := if(isFCRA, 0, le.acc_logs.inquirySSNsPerAddr );
	inq_perphone                     := if(isFCRA, 0, le.acc_logs.inquiryPerPhone );
	inq_adlsperphone                 := if(isFCRA, 0, le.acc_logs.inquiryADLsPerPhone );
	br_source_count                  := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count                    := le.impulse.count;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	fp_idverrisktype                 := le.fdattributesv2.idverrisklevel;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_vardobcount                   := le.fdattributesv2.variationdobcount;
	fp_srchvelocityrisktype          := le.fdattributesv2.searchvelocityrisklevel;
	fp_srchcountwk                   := le.fdattributesv2.searchcountweek;
	fp_srchunvrfdaddrcount           := le.fdattributesv2.searchunverifiedaddrcountyear;
	fp_srchunvrfdphonecount          := le.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcountyr          := le.fdattributesv2.searchfraudsearchcountyear;
	fp_srchfraudsrchcountwk          := le.fdattributesv2.searchfraudsearchcountweek;
	fp_assocrisktype                 := le.fdattributesv2.assocrisklevel;
	fp_assocsuspicousidcount         := le.fdattributesv2.assocsuspicousidentitiescount;
	fp_assoccredbureaucount          := le.fdattributesv2.assoccreditbureauonlycount;
	fp_validationrisktype            := le.fdattributesv2.validationrisklevel;
	fp_divrisktype                   := le.fdattributesv2.divrisklevel;
	fp_divaddrsuspidcountnew         := le.fdattributesv2.divaddrsuspidentitycountnew;
	fp_srchcomponentrisktype         := le.fdattributesv2.searchcomponentrisklevel;
	fp_srchssnsrchcountmo            := le.fdattributesv2.searchssnsearchcountmonth;
	fp_srchaddrsrchcountmo           := le.fdattributesv2.searchaddrsearchcountmonth;
	fp_srchphonesrchcountmo          := le.fdattributesv2.searchphonesearchcountmonth;
	fp_srchphonesrchcountwk          := le.fdattributesv2.searchphonesearchcountweek;
	fp_inputaddractivephonelist      := le.fdattributesv2.inputaddractivephonelist;
	fp_addrchangeecontrajindex       := le.fdattributesv2.addrchangeecontrajectoryindex;
	fp_curraddractivephonelist       := le.fdattributesv2.curraddractivephonelist;
	fp_prevaddrageoldest             := le.fdattributesv2.prevaddrageoldest;
	fp_prevaddrlenofres              := le.fdattributesv2.prevaddrlenofres;
	fp_prevaddrstatus                := le.fdattributesv2.prevaddrstatus;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_chapter                       := le.bjl.bk_chapter;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_unrel_cj_first_seen        := le.liens.liens_unreleased_civil_judgment.earliest_filing_date;
	liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	liens_unrel_ft_total_amount      := le.liens.liens_unreleased_federal_tax.total_amount;
	liens_unrel_ot_last_seen         := le.liens.liens_unreleased_other_tax.most_recent_filing_date;
	liens_rel_ot_first_seen          := le.liens.liens_released_other_tax.earliest_filing_date;
	liens_unrel_st_last_seen         := le.liens.liens_unreleased_suits.most_recent_filing_date;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_count                     := le.bjl.felony_count;
	felony_last_date                 := le.bjl.last_felony_date;
	hh_members_ct                    := le.hhid_summary.hh_members_ct;
	hh_property_owners_ct            := le.hhid_summary.hh_property_owners_ct;
	hh_collections_ct                := le.hhid_summary.hh_collections_ct;
	hh_payday_loan_users             := le.hhid_summary.hh_payday_loan_users;
	hh_members_w_derog               := le.hhid_summary.hh_members_w_derog;
	hh_tot_derog                     := le.hhid_summary.hh_tot_derog;
	hh_bankruptcies                  := le.hhid_summary.hh_bankruptcies;
	hh_lienholders                   := le.hhid_summary.hh_lienholders;
	hh_prof_license_holders          := le.hhid_summary.hh_prof_license_holders;
	hh_criminals                     := le.hhid_summary.hh_criminals;
	hh_college_attendees             := le.hhid_summary.hh_college_attendees;
	rel_count                        := le.relatives.relative_count;
	rel_bankrupt_count               := le.relatives.relative_bankrupt_count;
	rel_criminal_count               := le.relatives.relative_criminal_count;
	rel_felony_count                 := le.relatives.relative_felony_count;
	crim_rel_within25miles           := le.relatives.criminal_relative_within25miles;
	crim_rel_within100miles          := le.relatives.criminal_relative_within100miles;
	crim_rel_within500miles          := le.relatives.criminal_relative_within500miles;
	rel_within25miles_count          := le.relatives.relative_within25miles_count;
	rel_within100miles_count         := le.relatives.relative_within100miles_count;
	rel_within500miles_count         := le.relatives.relative_within500miles_count;
	rel_incomeunder50_count          := le.relatives.relative_incomeunder50_count;
	rel_incomeunder75_count          := le.relatives.relative_incomeunder75_count;
	rel_incomeunder100_count         := le.relatives.relative_incomeunder100_count;
	rel_incomeover100_count          := le.relatives.relative_incomeover100_count;
	rel_homeunder100_count           := le.relatives.relative_homeunder100_count;
	rel_homeunder150_count           := le.relatives.relative_homeunder150_count;
	rel_homeunder200_count           := le.relatives.relative_homeunder200_count;
	rel_homeunder300_count           := le.relatives.relative_homeunder300_count;
	rel_homeunder500_count           := le.relatives.relative_homeunder500_count;
	rel_homeover500_count            := le.relatives.relative_homeover500_count;
	rel_educationover12_count        := le.relatives.relative_educationover12_count;
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
	college_file_type                := le.student.file_type2;
	college_attendance               := le.attended_college;
	wealth_index                     := le.wealth_indicator;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	addr_stability_v2                := le.addr_stability;

	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */
	 
	 NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


sysdate :=  common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01'));

f_phone_ver_experian_d := if(not(truedid) or phone_ver_experian = '-1', NULL, (integer)phone_ver_experian);

k_nap_phn_verd_d := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

f_rel_homeover500_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_homeover500_count);

f_phone_ver_insurance_d := if(not(truedid) or phone_ver_insurance = '-1', NULL, (integer)phone_ver_insurance);

r_c12_source_profile_d := if(not(truedid), NULL, round((real)hdr_source_profile,1));

r_a49_curr_avm_chg_1yr_i := map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => add_curr_avm_auto_val - add_curr_avm_auto_val_2,
                                                                 NULL);

f_addrchangeecontrajindex_d := if(not(truedid) or fp_addrchangeecontrajindex = '' or fp_addrchangeecontrajindex = '-1', NULL, (Integer)fp_addrchangeecontrajindex);

r_phn_cell_n_1 := if(not(hphnpop), NULL, NULL);

r_phn_cell_n := if(rc_hriskphoneflag = '1' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '1' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '04' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '55' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '60', 1, 0);

f_prevaddrageoldest_d := if(not(truedid), NULL, min(if(fp_prevaddrageoldest = '', -NULL, (Integer)fp_prevaddrageoldest), 999));

r_phn_pcs_n := map(
    not(hphnpop)                                                                                                                                                                                                                                                                                                                                                            => NULL,
    rc_hriskphoneflag = '3' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '3' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '64' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '65' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '66' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '67' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '68' => 1,
                                                                                                                                                                                                                                                                                                                                                                               0);

r_a46_curr_avm_autoval_d := map(
    not(add_curr_pop)         => NULL,
    add_curr_avm_auto_val = 0 => NULL,
                                 min(if(add_curr_avm_auto_val = NULL, -NULL, add_curr_avm_auto_val), 300000));

r_wealth_index_d := if(not(truedid), NULL, (integer)wealth_index);

f_hh_lienholders_i := if(not(truedid), NULL, min(if(hh_lienholders = NULL, -NULL, hh_lienholders), 999));

k_inq_per_phone_i := if(not(hphnpop), NULL, min(if(inq_perphone = NULL, -NULL, inq_perphone), 999));

f_idverrisktype_i := if(not(truedid) or fp_idverrisktype = '', NULL, (integer)fp_idverrisktype);

f_rel_homeover300_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

r_p88_phn_dst_to_inp_add_i := if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr);

r_f03_address_match_d := map(
    not(truedid)                                => NULL,
    add_input_isbestmatch                       => 4,
    not(add_input_pop) and add_curr_isbestmatch => 3,
    add_input_pop and add_curr_isbestmatch      => 2,
    add_curr_pop                                => 1,
    add_input_pop                               => 0,
                                                   NULL);

r_c13_max_lres_d := if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999));

r_c14_addr_stability_v2_d := 	map(
    not(truedid)          			=> NULL,
    addr_stability_v2 = '0' 		=> NULL,
																	(integer) addr_stability_v2);

r_l80_inp_avm_autoval_d := map(
    not(add_input_pop)         => NULL,
    add_input_avm_auto_val = 0 => NULL,
                                  min(if(add_input_avm_auto_val = NULL, -NULL, add_input_avm_auto_val), 300000));

r_f00_dob_score_d := if(not(truedid and dobpop) or combo_dobscore = 255, NULL, min(if(combo_dobscore = NULL, -NULL, combo_dobscore), 999));

f_hh_tot_derog_i := if(not(truedid), NULL, min(if(hh_tot_derog = NULL, -NULL, hh_tot_derog), 999));

f_validationrisktype_i := map(
    not(truedid)                 	=> NULL,
    fp_validationrisktype = '' 		=> NULL,
                                    (integer) fp_validationrisktype);

r_i61_inq_collection_recency_d := map(
    not(truedid)           => NULL,
    (boolean)inq_collection_count01 => 1,
    (boolean)inq_collection_count03 => 3,
    (boolean)inq_collection_count06 => 6,
    (boolean)inq_collection_count12 => 12,
    (boolean)inq_collection_count24 => 24,
    (boolean)inq_collection_count   => 99,
                              999);

r_c23_inp_addr_occ_index_d := if(not(add_input_pop and truedid), NULL, add_input_occ_index);

f_rel_under25miles_cnt_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_within25miles_count);

r_p85_phn_disconnected_i := map(
    not(hphnpop)                                                               => NULL,
    rc_hriskphoneflag = '5' or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D' => 1,
                                                                                0);

r_f03_input_add_not_most_rec_i := if(not(truedid and add_input_pop), NULL, (integer)rc_input_addr_not_most_recent);

_ver_src_ds_1 := Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0;

_ver_src_de_1 := Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0;

_ver_src_eq_1 := Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0;

_ver_src_en_1 := Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0;

_ver_src_tn_1 := Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0;

_ver_src_tu_1 := Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0;

_credit_source_cnt_1 := if(max((integer)_ver_src_eq_1, (integer)_ver_src_en_1, (integer)_ver_src_tn_1, (integer)_ver_src_tu_1) = NULL, NULL, sum((integer)_ver_src_eq_1, (integer)_ver_src_en_1, (integer)_ver_src_tn_1, (integer)_ver_src_tu_1));

_ver_src_cnt_1 := Models.Common.countw((string)(ver_sources));

_bureauonly_1 := _credit_source_cnt_1 > 0 AND _credit_source_cnt_1 = _ver_src_cnt_1 AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6]));

_derog_1 := felony_count > 0 OR (integer)addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2;

_deceased_1 := rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds_1 OR _ver_src_de_1;

_ssnpriortodob_1 := rc_ssndobflag = '1' OR rc_pwssndobflag = '1';

_inputmiskeys_1 := rc_ssnmiskeyflag or rc_addrmiskeyflag or add_input_house_number_match = FALSE;

_multiplessns_1 := ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1;

_hh_strikes_1 :=  sum((integer)(hh_members_w_derog > 0), (integer)(hh_criminals > 0), (integer)(hh_payday_loan_users > 0));

nf_seg_fraudpoint_3_0 := map(
    addrpop and (nas_summary in [4, 7, 9]) or fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9' or _deceased_1 or _ssnpriortodob_1 				=> '1: Stolen/Manip ID  ',
    _inputmiskeys_1 and (_multiplessns_1 or lnames_per_adl_c6 > 1)                                                                                                                                 					=> '1: Stolen/Manip ID  ',
    fnamepop and lnamepop and addrpop and ssnlength = '9' and hphnpop and nap_summary <= 4 and nas_summary <= 4 or _ver_src_cnt_1 = 0 or _bureauonly_1 or (not add_curr_pop)                        				=> '2: Synth ID         ',
    _derog_1                                                                                                                                                                                         				=> '3: Derog            ',
    Inq_count03 > 0 or Inq_count12 >= 4 or (integer)fp_srchfraudsrchcountyr >= 1 or (integer)fp_srchssnsrchcountmo >= 1 or (integer)fp_srchaddrsrchcountmo >= 1 or (integer)fp_srchphonesrchcountmo >= 1   => '4: Recent Activity  ',
    0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70                                                                                                                                 					 => '5: Vuln Vic/Friendly',
    hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes_1 >= 2 or rel_felony_count >= 2)                                                                                                					=> '5: Vuln Vic/Friendly',
																																																																																																						'6: Other            ');

f_addrs_per_ssn_i := if(not((integer)ssnlength > 0), NULL, min(if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn), 999));

k_inq_adls_per_phone_i := if(not(hphnpop), NULL, min(if(inq_adlsperphone = NULL, -NULL, inq_adlsperphone), 999));

_header_first_seen := common.sas_date((string)(header_first_seen));

r_c10_m_hdr_fs_d := map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => 1000,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));

f_rel_educationover12_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_educationover12_count);

f_prevaddrlenofres_d := if(not(truedid), NULL, min(if((integer)fp_prevaddrlenofres = NULL, -NULL, (integer)fp_prevaddrlenofres), 999));

k_inf_phn_verd_d := (Integer)(infutor_nap in [4, 6, 7, 9, 10, 11, 12]);

f_bus_addr_match_count_d := if(not(addrpop), NULL, bus_addr_match_count);

f_phones_per_addr_curr_i := if(not(add_curr_pop), NULL, min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999));

k_inq_per_ssn_i := if(not((integer)ssnlength > 0), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999));

r_l79_adls_per_addr_c6_i := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));

k_inq_lnames_per_addr_i := if(not(addrpop), NULL, min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999));

f_rel_under500miles_cnt_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count))));

r_d30_derog_count_i := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));

f_rel_under100miles_cnt_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_within25miles_count, rel_within100miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count))));

r_d31_mostrec_bk_i := map(
    not(truedid)                                    											=> NULL,
    contains_i(StringLib.StringToUpperCase(disposition), 'DISMISS') = 1  => 1,
    contains_i(StringLib.StringToUpperCase(disposition), 'DISCHARG') = 1 => 2,
    (integer)bankrupt = 1 or (integer)filing_count > 0                	=> 3,
																																						0);

r_c13_curr_addr_lres_d := if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999));

f_srchcomponentrisktype_i := map(
    not(truedid)                    => NULL,
    fp_srchcomponentrisktype = '' 	=> NULL,
                                       (integer)fp_srchcomponentrisktype);

f_hh_bankruptcies_i := if(not(truedid), NULL, min(if(hh_bankruptcies = NULL, -NULL, hh_bankruptcies), 999));

r_f00_input_dob_match_level_d := if(not(truedid and dobpop), NULL, (integer)input_dob_match_level);

bureau_adl_eq_fseen_pos_2 := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq_2 := if(bureau_adl_eq_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_2, ','));

_bureau_adl_fseen_eq_2 := common.sas_date((string)(bureau_adl_fseen_eq_2));

bureau_adl_en_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E');

bureau_adl_fseen_en_1 := if(bureau_adl_en_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos_1, ','));

_bureau_adl_fseen_en_1 := common.sas_date((string)(bureau_adl_fseen_en_1));

bureau_adl_ts_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E');

bureau_adl_fseen_ts_1 := if(bureau_adl_ts_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos_1, ','));

_bureau_adl_fseen_ts_1 := common.sas_date((string)(bureau_adl_fseen_ts_1));

bureau_adl_tu_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E');

bureau_adl_fseen_tu_1 := if(bureau_adl_tu_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos_1, ','));

_bureau_adl_fseen_tu_1 := common.sas_date((string)(bureau_adl_fseen_tu_1));

bureau_adl_tn_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E');

bureau_adl_fseen_tn_1 := if(bureau_adl_tn_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos_1, ','));

_bureau_adl_fseen_tn_1 := common.sas_date((string)(bureau_adl_fseen_tn_1));

_src_bureau_adl_fseen_notu := min(if(_bureau_adl_fseen_en_1 = NULL, -NULL, _bureau_adl_fseen_en_1), if(_bureau_adl_fseen_eq_2 = NULL, -NULL, _bureau_adl_fseen_eq_2), 999999);

f_m_bureau_adl_fs_notu_d := map(
    not(truedid)                        => NULL,
    _src_bureau_adl_fseen_notu = 999999 => 1000,
                                           min(if(if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)))), 999));

r_l79_adls_per_addr_curr_i := if(not(add_curr_pop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

r_e57_br_source_count_d := if(not(truedid), NULL, br_source_count);

r_f00_ssn_score_d := if(not(truedid and (integer)ssnlength > 0) or combo_ssnscore = 255, NULL, min(if(combo_ssnscore = NULL, -NULL, combo_ssnscore), 999));

f_srchunvrfdaddrcount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdaddrcount = '', -NULL, (integer)fp_srchunvrfdaddrcount), 999));

bureau_adl_eq_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq_1 := if(bureau_adl_eq_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_1, ','));

_bureau_adl_fseen_eq_1 := common.sas_date((string)(bureau_adl_fseen_eq_1));

bureau_adl_en_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E');

bureau_adl_fseen_en := if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ','));

_bureau_adl_fseen_en := common.sas_date((string)(bureau_adl_fseen_en));

bureau_adl_ts_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E');

bureau_adl_fseen_ts := if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos, ','));

_bureau_adl_fseen_ts := common.sas_date((string)(bureau_adl_fseen_ts));

bureau_adl_tu_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E');

bureau_adl_fseen_tu := if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos, ','));

_bureau_adl_fseen_tu := common.sas_date((string)(bureau_adl_fseen_tu));

bureau_adl_tn_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E');

bureau_adl_fseen_tn := if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos, ','));

_bureau_adl_fseen_tn := common.sas_date((string)(bureau_adl_fseen_tn));

_src_bureau_adl_fseen_all := min(if(_bureau_adl_fseen_tn = NULL, -NULL, _bureau_adl_fseen_tn), if(_bureau_adl_fseen_ts = NULL, -NULL, _bureau_adl_fseen_ts), if(_bureau_adl_fseen_tu = NULL, -NULL, _bureau_adl_fseen_tu), if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq_1 = NULL, -NULL, _bureau_adl_fseen_eq_1), 999999);

f_m_bureau_adl_fs_all_d := map(
    not(truedid)                       => NULL,
    _src_bureau_adl_fseen_all = 999999 => 1000,
                                          min(if(if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)))), 999));

_liens_unrel_cj_first_seen := common.sas_date((string)(liens_unrel_CJ_first_seen));

f_mos_liens_unrel_cj_fseen_d := map(
    not(truedid)                      => NULL,
    _liens_unrel_cj_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)))), 999));

f_recent_disconnects_i := if(not(hphnpop), NULL, min(if(recent_disconnects = NULL, -NULL, recent_disconnects), 999));

bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

_bureau_adl_fseen_eq := common.sas_date((string)(bureau_adl_fseen_eq));

_src_bureau_adl_fseen := min(if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

r_c21_m_bureau_adl_fs_d := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => 1000,
                                      min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999));

_liens_unrel_cj_last_seen := common.sas_date((string)(liens_unrel_CJ_last_seen));

f_mos_liens_unrel_cj_lseen_d := map(
    not(truedid)                     => NULL,
    _liens_unrel_cj_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)))), 999)));

r_a49_curr_avm_chg_1yr_pct_i := map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(round(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2/0.1)*0.1,1),
                                                                 NULL);

r_f01_inp_addr_address_score_d := if(not(truedid and add_input_pop) or add_input_address_score = 255, NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));

f_srchunvrfdphonecount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = '', -NULL, (integer)fp_srchunvrfdphonecount), 999));

r_d31_bk_chapter_n := map(
    not(truedid)                                 => '',
    not((bk_chapter in ['7', '11', '12', '13'])) => '',
                                                    trim(bk_chapter, LEFT));

f_rel_criminal_count_i := map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_criminal_count = NULL, -NULL, rel_criminal_count), 999));

f_srchvelocityrisktype_i := map(
    not(truedid)                   	=> NULL,
    fp_srchvelocityrisktype = '' 		=> NULL,
                                      (integer)fp_srchvelocityrisktype);

f_rel_homeover200_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

k_inf_contradictory_i := (infutor_nap in [1]);

f_rel_incomeover50_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count))));

k_inf_lname_verd_d := (infutor_nap in [2, 5, 7, 8, 9, 11, 12]);

k_inq_ssns_per_addr_i := if(not(addrpop), NULL, min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999));

nf_number_non_bureau_sources := if(not(truedid), NULL, if((integer)max((integer)contains_i(ver_sources, 'CY') > 0, 
(integer)contains_i(ver_sources, 'PL') > 0, (integer)contains_i(ver_sources, 'SL') > 0, 
(integer)contains_i(ver_sources, 'WP') > 0, (integer)contains_i(ver_sources, 'AK') > 0, 
(integer)contains_i(ver_sources, 'AM') > 0, (integer)contains_i(ver_sources, 'AR') > 0, 
(integer)contains_i(ver_sources, 'BA') > 0, (integer)contains_i(ver_sources, 'CG') > 0, 
(integer)contains_i(ver_sources, 'DA') > 0, (integer)contains_i(ver_sources, 'D ') > 0, 
(integer)contains_i(ver_sources, 'DL') > 0, (integer)contains_i(ver_sources, 'DS') > 0, 
(integer)contains_i(ver_sources, 'DE') > 0, (integer)contains_i(ver_sources, 'EB') > 0, 
(integer)contains_i(ver_sources, 'EM') > 0, (integer)contains_i(ver_sources, 'E1') > 0, 
(integer)contains_i(ver_sources, 'E2') > 0, (integer)contains_i(ver_sources, 'E3') > 0, 
(integer)contains_i(ver_sources, 'E4') > 0, (integer)contains_i(ver_sources, 'FE') > 0, 
(integer)contains_i(ver_sources, 'FF') > 0, (integer)contains_i(ver_sources, 'FR') > 0, 
(integer)contains_i(ver_sources, 'L2') > 0, (integer)contains_i(ver_sources, 'LI') > 0, 
(integer)contains_i(ver_sources, 'MW') > 0, (integer)contains_i(ver_sources, 'NT') > 0, 
(integer)contains_i(ver_sources, 'P ') > 0, (integer)contains_i(ver_sources, 'V ') > 0, 
(integer)contains_i(ver_sources, 'VO') > 0, (integer)contains_i(ver_sources, 'W ') > 0) = NULL, NULL, 
(Integer)sum((integer)contains_i(ver_sources, 'CY') > 0, (integer)contains_i(ver_sources, 'PL') > 0, 
(integer)contains_i(ver_sources, 'SL') > 0, (integer)contains_i(ver_sources, 'WP') > 0, 
(integer)contains_i(ver_sources, 'AK') > 0, (integer)contains_i(ver_sources, 'AM') > 0, 
(integer)contains_i(ver_sources, 'AR') > 0, (integer)contains_i(ver_sources, 'BA') > 0, 
(integer)contains_i(ver_sources, 'CG') > 0, (integer)contains_i(ver_sources, 'DA') > 0, 
(integer)contains_i(ver_sources, 'D ') > 0, (integer)contains_i(ver_sources, 'DL') > 0, 
(integer)contains_i(ver_sources, 'DS') > 0, (integer)contains_i(ver_sources, 'DE') > 0, 
(integer)contains_i(ver_sources, 'EB') > 0, (integer)contains_i(ver_sources, 'EM') > 0, 
(integer)contains_i(ver_sources, 'E1') > 0, (integer)contains_i(ver_sources, 'E2') > 0, 
(integer)contains_i(ver_sources, 'E3') > 0, (integer)contains_i(ver_sources, 'E4') > 0, 
(integer)contains_i(ver_sources, 'FE') > 0, (integer)contains_i(ver_sources, 'FF') > 0, 
(integer)contains_i(ver_sources, 'FR') > 0, (integer)contains_i(ver_sources, 'L2') > 0, 
(integer)contains_i(ver_sources, 'LI') > 0, (integer)contains_i(ver_sources, 'MW') > 0, 
(integer)contains_i(ver_sources, 'NT') > 0, (integer)contains_i(ver_sources, 'P ') > 0, 
(integer)contains_i(ver_sources, 'V ') > 0, (integer)contains_i(ver_sources, 'VO') > 0, 
(integer)contains_i(ver_sources, 'W ') > 0)));

k_inq_adls_per_addr_i := if(not(addrpop), NULL, min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999));

r_c12_source_profile_index_d := if(not(truedid), NULL, round(hdr_source_profile_index,1));

_add_not_ver := (nas_summary in [4, 7, 9]);

nf_inq_per_add_nas_479 := map(
    not(truedid and (integer)ssnlength > 0 or addrpop) 	=> NULL,
    not(_add_not_ver)                         					=> -1,
																												min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999));

f_property_owners_ct_d := if(not(truedid), NULL, min(if(hh_property_owners_ct = NULL, -NULL, hh_property_owners_ct), 999));

f_inq_count24_i := if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999));

r_c12_num_nonderogs_d := if(not(truedid), NULL, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 999));

f_hh_members_w_derog_i := if(not(truedid), NULL, min(if(hh_members_w_derog = NULL, -NULL, hh_members_w_derog), 999));

f_rel_incomeover100_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_incomeover100_count);

f_dl_addrs_per_adl_i := if(not(truedid), NULL, min(if(dl_addrs_per_adl = NULL, -NULL, dl_addrs_per_adl), 999));

f_historical_count_d := if(not(truedid), NULL, min(if(historical_count = NULL, -NULL, historical_count), 999));

r_p85_phn_not_issued_i := map(
    not(hphnpop)                 => NULL,
    (rc_pwphonezipflag in ['4']) => 1,
                                    0);

f_rel_homeover150_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_hh_collections_ct_i := if(not(truedid), NULL, min(if(hh_collections_ct = NULL, -NULL, hh_collections_ct), 999));

k_inq_addrs_per_ssn_i := if(not((integer)ssnlength > 0), NULL, min(if(inq_addrsperssn = NULL, -NULL, inq_addrsperssn), 999));

f_assocsuspicousidcount_i := if(not(truedid), NULL, min(if(fp_assocsuspicousidcount = '', -NULL, (integer)fp_assocsuspicousidcount), 999));

f_bus_fname_verd_d := if(not(addrpop), NULL, (integer)(bus_name_match in [2, 4]));

_criminal_last_date := common.sas_date((string)(criminal_last_date));

r_d32_mos_since_crim_ls_d := map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => 241,
                                  max(3, min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240)));

r_s66_adlperssn_count_i := map(
    not((integer)ssnlength > 0) => NULL,
    adls_per_ssn = 0   					=> 1,
																min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999));

r_i60_inq_mortgage_recency_d := map(
    not(truedid)         => NULL,
    (boolean)inq_mortgage_count01 => 1,
    (boolean)inq_mortgage_count03 => 3,
    (boolean)inq_mortgage_count06 => 6,
    (boolean)inq_mortgage_count12 => 12,
    (boolean)inq_mortgage_count24 => 24,
    (boolean)inq_mortgage_count   => 99,
                            999);

f_hh_college_attendees_d := if(not(truedid), NULL, min(if(hh_college_attendees = NULL, -NULL, hh_college_attendees), 999));

r_i60_inq_retail_recency_d := map(
    not(truedid)       => NULL,
    (boolean)inq_retail_count01 => 1,
    (boolean)inq_retail_count03 => 3,
    (boolean)inq_retail_count06 => 6,
    (boolean)inq_retail_count12 => 12,
    (boolean)inq_retail_count24 => 24,
    (boolean)inq_retail_count   => 99,
																999);

f_rel_homeover100_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

r_c18_invalid_addrs_per_adl_i := if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999));

k_inq_per_addr_i := if(not(addrpop), NULL, min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999));

f_rel_count_i := if(not(truedid), NULL, min(if(rel_count = NULL, -NULL, rel_count), 999));

r_i60_inq_banking_recency_d := map(
    not(truedid)        => NULL,
    (boolean)inq_banking_count01 => 1,
    (boolean)inq_banking_count03 => 3,
    (boolean)inq_banking_count06 => 6,
    (boolean)inq_banking_count12 => 12,
    (boolean)inq_banking_count24 => 24,
    (boolean)inq_banking_count   => 99,
                           999);

r_d34_unrel_liens_ct_i := if(not(truedid), NULL, min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 999));

f_crim_rel_under100miles_cnt_i := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(crim_rel_within25miles, crim_rel_within100miles) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles))));

_acc_last_seen := common.sas_date((string)(acc_last_seen));

f_mos_acc_lseen_d := map(
    not(truedid)          => NULL,
    _acc_last_seen = NULL => 1000,
                             max(3, min(if(if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12)))), 999)));

r_i60_inq_hiriskcred_recency_d := map(
    not(truedid)               => NULL,
    (boolean)inq_highRiskCredit_count01 => 1,
    (boolean)inq_highRiskCredit_count03 => 3,
    (boolean)inq_highRiskCredit_count06 => 6,
    (boolean)inq_highRiskCredit_count12 => 12,
    (boolean)inq_highRiskCredit_count24 => 24,
    (boolean)inq_highRiskCredit_count   => 99,
                                  999);

f_util_adl_count_n := if(not(truedid), NULL, util_adl_count);

add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];

add_ec3 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3];

add_ec4 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4];

r_l70_add_standardized_i := map(
    not(addrpop)                                         => NULL,
    trim(trim(add_ec1, LEFT), LEFT, RIGHT) = 'E'         => 2,
    add_ec1 = 'S' and (add_ec3 != '0' or add_ec4 != '0') => 1,
                                                            0);

f_rel_incomeover75_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count))));

f_accident_count_i := if(not(truedid), NULL, min(if(acc_count = NULL, -NULL, acc_count), 999));

f_phones_per_addr_c6_i := if(not(addrpop), NULL, min(if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6), 999));

f_varrisktype_i := map(
    not(truedid)          		=> NULL,
    fp_varrisktype = ''			 => NULL,
                             (integer)fp_varrisktype);

_liens_rel_ot_first_seen := common.sas_date((string)(liens_rel_OT_first_seen));

f_mos_liens_rel_ot_fseen_d := map(
    not(truedid)                    => NULL,
    _liens_rel_ot_first_seen = NULL => -1,
                                       min(if(if ((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)))), 999));

f_crim_rel_under500miles_cnt_i := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(crim_rel_within25miles, crim_rel_within100miles, crim_rel_within500miles) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles), if(crim_rel_within500miles = NULL, 0, crim_rel_within500miles))));

r_l70_add_invalid_i := map(
    not(addrpop)                                        => NULL,
    trim(trim(rc_addrvalflag, LEFT), LEFT, RIGHT) = 'N' => 1,
                                                           0);

f_divrisktype_i := map(
    not(truedid)          => NULL,
    fp_divrisktype = '' 	=> NULL,
                           (integer) fp_divrisktype);

f_assoccredbureaucount_i := if(not(truedid), NULL, min(if((integer)fp_assoccredbureaucount = NULL, -NULL, (integer)fp_assoccredbureaucount), 999));

bureau_ := contains_i(ver_sources, 'EN') > 0 or contains_i(ver_sources, 'EQ') > 0 or contains_i(ver_sources, 'TN') > 0 or contains_i(ver_sources, 'TS') > 0 or contains_i(ver_sources, 'TU') > 0;

behavioral_ := contains_i(ver_sources, 'CY') > 0 or contains_i(ver_sources, 'PL') > 0 or contains_i(ver_sources, 'SL') > 0 or contains_i(ver_sources, 'WP') > 0;

government_ := contains_i(ver_sources, 'AK') > 0 or contains_i(ver_sources, 'AM') > 0 or contains_i(ver_sources, 'AR') > 0 or contains_i(ver_sources, 'BA') > 0 or contains_i(ver_sources, 'CG') > 0 or contains_i(ver_sources, 'DA') > 0 or contains_i(ver_sources, 'D ') > 0 or contains_i(ver_sources, 'DL') > 0 or contains_i(ver_sources, 'DS') > 0 or contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'EB') > 0 or contains_i(ver_sources, 'EM') > 0 or contains_i(ver_sources, 'E1') > 0 or contains_i(ver_sources, 'E2') > 0 or contains_i(ver_sources, 'E3') > 0 or contains_i(ver_sources, 'E4') > 0 or contains_i(ver_sources, 'FE') > 0 or contains_i(ver_sources, 'FF') > 0 or contains_i(ver_sources, 'FR') > 0 or contains_i(ver_sources, 'L2') > 0 or contains_i(ver_sources, 'LI') > 0 or contains_i(ver_sources, 'MW') > 0 or contains_i(ver_sources, 'NT') > 0 or contains_i(ver_sources, 'P ') > 0 or contains_i(ver_sources, 'V ') > 0 or contains_i(ver_sources, 'VO') > 0 or contains_i(ver_sources, 'W ') > 0;

nf_source_type := map(
    not(truedid)                                      => ' ',
    bureau_ and behavioral_ and government_           => 'Bureau Behavioral and Government',
    not(bureau_) and behavioral_ and government_      => 'Behavioral and Government',
    bureau_ and not(behavioral_) and government_      => 'Bureau and Government',
    bureau_ and behavioral_ and not(government_)      => 'Bureau and Behavioral',
    not(bureau_) and not(behavioral_) and government_ => 'Government Only',
    not(bureau_) and behavioral_ and not(government_) => 'Behavioral Only',
    bureau_ and not(behavioral_) and not(government_) => 'Bureau Only',
                                                         'None');

r_c14_addrs_5yr_i := if(not(truedid), NULL, min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));

f_prevaddrstatus_i := map(
    not(truedid)            => NULL,
    fp_prevaddrstatus = '0' => 1,
    fp_prevaddrstatus = 'U' => 2,
    fp_prevaddrstatus = 'R' => 3,
                               NULL);

f_assocrisktype_i := map(
    not(truedid)            		=> NULL,
    fp_assocrisktype = '' 			=> NULL,
                               (integer)fp_assocrisktype);

f_rel_homeover50_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

k_nap_fname_verd_d := (nap_summary in [2, 3, 4, 8, 9, 10, 12]);

f_rel_incomeover25_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count, rel_incomeunder50_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count))));

f_inq_retail_count24_i := if(not(truedid), NULL, min(if(inq_Retail_count24 = NULL, -NULL, inq_Retail_count24), 999));

k_inq_lnames_per_ssn_i := if(not((integer)ssnlength > 0), NULL, min(if(inq_lnamesperssn = NULL, -NULL, inq_lnamesperssn), 999));

f_current_count_d := if(not(truedid), NULL, min(if(current_count = NULL, -NULL, current_count), 999));

f_inq_other_count24_i := if(not(truedid), NULL, min(if(inq_Other_count24 = NULL, -NULL, inq_Other_count24), 999));

r_e55_college_ind_d := map(
    not(truedid)                           => NULL,
    (college_file_type in ['H', 'C', 'A']) => 1,
    college_attendance                     => 1,
                                              0);

f_adl_util_misc_n := if(contains_i(StringLib.StringToUpperCase(util_adl_type_list), 'Z') > 0, 1, 0);

f_curraddractivephonelist_d := map(
    not(add_curr_pop)               			=> NULL,
    fp_curraddractivephonelist = '-1'		 => NULL,
																				(integer)fp_curraddractivephonelist);

f_divaddrsuspidcountnew_i := if(not(truedid), NULL, min(if(fp_divaddrsuspidcountnew = '', -NULL, (integer)fp_divaddrsuspidcountnew), 999));

f_srchphonesrchcountwk_i := if(not(truedid), NULL, min(if(fp_srchphonesrchcountwk = '', -NULL, (integer)fp_srchphonesrchcountwk), 999));

f_accident_recency_d := map(
    not(truedid)  => NULL,
    (boolean)acc_count_30  => 1,
    (boolean)acc_count_90  => 3,
    (boolean)acc_count_180 => 6,
    (boolean)acc_count_12  => 12,
    (boolean)acc_count_24  => 24,
    (boolean)acc_count_36  => 36,
    (boolean)acc_count_60  => 60,
    (boolean)acc_count     => 61,
                     62);

f_hh_members_ct_d := if(not(truedid), NULL, min(if(hh_members_ct = NULL, -NULL, hh_members_ct), 999));

f_hh_prof_license_holders_d := if(not(truedid), NULL, min(if(hh_prof_license_holders = NULL, -NULL, hh_prof_license_holders), 999));

f_vardobcount_i := if(not(truedid), NULL, min(if(fp_vardobcount = '', -NULL, (integer)fp_vardobcount), 999));

k_inq_adls_per_ssn_i := if(not((integer)ssnlength > 0), NULL, min(if(inq_adlsperssn = NULL, -NULL, inq_adlsperssn), 999));

f_srchphonesrchcountmo_i := if(not(truedid), NULL, min(if(fp_srchphonesrchcountmo = '', -NULL, (integer)fp_srchphonesrchcountmo), 999));

r_l77_add_po_box_i := map(
    not(addrpop or not(out_z5 = ''))                                                                                                                                                                                                                           => NULL,
    rc_hriskaddrflag = '1' or rc_ziptypeflag = '1' or StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'E' or StringLib.StringToUpperCase(trim(rc_zipclass, LEFT, RIGHT)) = 'P' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'P' => 1,
                                                                                                                                                                                                                                                                    0);

k_nap_lname_verd_d := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);

r_i60_inq_retail_count12_i := if(not(truedid), NULL, min(if(inq_retail_count12 = NULL, -NULL, inq_retail_count12), 999));

r_a41_prop_owner_inp_only_d := map(
    not(truedid)                                => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 => 1,
                                                   0);

f_addrs_per_ssn_c6_i := if(not((integer)ssnlength > 0), NULL, min(if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6), 999));

r_a43_watercraft_cnt_d := if(not(truedid), NULL, watercraft_count);

_liens_unrel_ot_last_seen := common.sas_date((string)(liens_unrel_OT_last_seen));

f_mos_liens_unrel_ot_lseen_d := map(
    not(truedid)                     => NULL,
    _liens_unrel_ot_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)))), 999)));

r_a44_curr_add_naprop_d := if(not(truedid and add_curr_pop), NULL, add_curr_naprop);

f_inq_quizprovider_count24_i := if(not(truedid), NULL, min(if(inq_QuizProvider_count24 = NULL, -NULL, inq_QuizProvider_count24), 999));

f_rel_bankrupt_count_i := map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 999));

r_i60_inq_count12_i := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));

r_s65_ssn_problem_i := map(
    not((integer)ssnlength > 0)                                                                                                                                                                                                                                                	=> NULL,
    dobpop and (rc_ssndobflag = '1' or rc_pwssndobflag = '1') or truedid and invalid_ssns_per_adl >= 2 or truedid and invalid_ssns_per_adl_c6 >= 1                                                                                                                        			=> 2,
    rc_decsflag = '1' or contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 or rc_ssnvalflag = '1' or (rc_pwssnvalflag in ['1', '2', '3']) or (inputssncharflag in ['1', '2', '3']) or truedid and invalid_ssns_per_adl >= 1                          			=> 1,
    rc_decsflag = '0' or dobpop and (rc_ssndobflag = '0' or rc_pwssndobflag = '0') or rc_ssnvalflag = '0' or (rc_pwssnvalflag in ['0', '4', '5']) or (inputssncharflag in ['0', '4', '5']) or truedid and invalid_ssns_per_adl = 0 or truedid and invalid_ssns_per_adl_c6 = 0 		=> 0,
																																																																																																																																								NULL);

f_inputaddractivephonelist_d := map(
    not(truedid)                     		 => NULL,
    fp_inputaddractivephonelist = '-1'	 => NULL,
																					 (integer) fp_inputaddractivephonelist);

r_l71_add_business_i := map(
    not(add_input_pop)                                                       => NULL,
    (trim(trim(add_input_advo_res_or_bus, LEFT), LEFT, RIGHT) in ['B', 'D']) => 1,
                                                                                0);

r_i60_inq_recency_d := map(
    not(truedid) => NULL,
    (boolean)inq_count01  => 1,
    (boolean)inq_count03  => 3,
    (boolean)inq_count06  => 6,
    (boolean)inq_count12  => 12,
    (boolean)inq_count24  => 24,
    (boolean)inq_count    => 99,
														999);

r_c14_addrs_15yr_i := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));

f_util_add_input_conv_n := if(contains_i(util_add_input_type_list, '2') > 0, 1, 0);

f_inq_retailpayments_count24_i := if(not(truedid), NULL, min(if(inq_RetailPayments_count24 = NULL, -NULL, inq_RetailPayments_count24), 999));

k_inf_addr_verd_d := (infutor_nap in [3, 5, 6, 8, 10, 11, 12]);

r_f04_curr_add_occ_index_d := if(not(truedid and add_curr_pop), NULL, add_curr_occ_index);

f_bus_lname_verd_d := if(not(addrpop), NULL, (integer)(bus_name_match in [3, 4]));

_liens_unrel_st_last_seen := common.sas_date((string)(liens_unrel_ST_last_seen));

f_mos_liens_unrel_st_lseen_d := map(
    not(truedid)                     => NULL,
    _liens_unrel_st_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)))), 999)));

r_d32_criminal_count_i := if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999));

f_crim_rel_under25miles_cnt_i := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     crim_rel_within25miles);

r_i60_inq_auto_recency_d := map(
    not(truedid)     => NULL,
    (boolean)inq_auto_count01 => 1,
    (boolean)inq_auto_count03 => 3,
    (boolean)inq_auto_count06 => 6,
    (boolean)inq_auto_count12 => 12,
    (boolean)inq_auto_count24 => 24,
    (boolean)inq_auto_count   => 99,
																999);

f_srchfraudsrchcountwk_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountwk = '', -NULL, (integer)fp_srchfraudsrchcountwk), 999));

f_inq_mortgage_count24_i := if(not(truedid), NULL, min(if(inq_Mortgage_count24 = NULL, -NULL, inq_Mortgage_count24), 999));

f_util_add_curr_conv_n := if(contains_i(util_add_curr_type_list, '2') > 0, 1, 0);

r_c15_ssns_per_adl_c6_i := map(
    not(truedid)        => NULL,
    ssns_per_adl_c6 = 0 => 1,
                           min(if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6), 999));

f_bus_phone_match_d := if(not(addrpop), NULL, if(bus_phone_match = 3, 1, 0));

r_l78_no_phone_at_addr_vel_i := map(
    not(addrpop)             => NULL,
    phones_per_addr_curr = 0 => 1,
                                0);

r_l72_add_vacant_i := map(
    not(add_input_pop)                                          => NULL,
    trim(trim(add_input_advo_vacancy, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                   0);

f_srchcountwk_i := if(not(truedid), NULL, min(if(fp_srchcountwk = '', -NULL, (integer)fp_srchcountwk), 999));

_felony_last_date := common.sas_date((string)(felony_last_date));

r_d32_mos_since_fel_ls_d := map(
    not(truedid)             => NULL,
    _felony_last_date = NULL => 241,
                                max(3, min(if(if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12)))), 240)));

r_d31_bk_filing_count_i := if(not(truedid), NULL, min(if(filing_count = NULL, -NULL, filing_count), 999));

r_i60_inq_retpymt_recency_d := map(
    not(truedid)               => NULL,
    (boolean)inq_retailpayments_count01 => 1,
    (boolean)inq_retailpayments_count03 => 3,
    (boolean)inq_retailpayments_count06 => 6,
    (boolean)inq_retailpayments_count12 => 12,
    (boolean)inq_retailpayments_count24 => 24,
    (boolean)inq_retailpayments_count   => 99,
                                  999);

f_liens_unrel_ft_total_amt_i := if(not(truedid), NULL, liens_unrel_FT_total_amount);

f_inq_banking_count24_i := if(not(truedid), NULL, min(if(inq_Banking_count24 = NULL, -NULL, inq_Banking_count24), 999));

f_acc_damage_amt_total_i := if(not(truedid), NULL, acc_damage_amt_total);

final_score_0 := -2.3024684001;

final_score_1_c183 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d <= 2.5 => 0.3353832529,
    r_f03_address_match_d > 2.5                                   => 0.0530189822,
    r_f03_address_match_d = NULL                                  => 0.1376158956,
                                                                     0.1376158956);

final_score_1_c182 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 182.5 => final_score_1_c183,
    f_prevaddrageoldest_d > 182.5                                   => 0.4719685833,
    f_prevaddrageoldest_d = NULL                                    => 0.1989294108,
                                                                       0.1989294108);

final_score_1_c181 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 4.5 => final_score_1_c182,
    r_wealth_index_d > 4.5                              => 0.5802013892,
    r_wealth_index_d = NULL                             => 0.2815614468,
                                                           0.2815614468);

final_score_1_c180 := map(
    NULL < (real)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d <= 0.5 						=> final_score_1_c181,
    (real)k_nap_phn_verd_d > 0.5                              									=> -0.0017361695,
    (real)k_nap_phn_verd_d = NULL                             									=> 0.1434769610,
																																										0.1434769610);

final_score_1 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_1_c180,
    f_phone_ver_experian_d > 0.5                                    => -0.0658039920,
    f_phone_ver_experian_d = NULL                                   => 0.0003700499,
                                                                       0.0008343146);

final_score_2_c187 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 0.5 => 0.0665385604,
    f_rel_homeover500_count_d > 0.5                                       => 0.2994143613,
    f_rel_homeover500_count_d = NULL                                      => 0.1235693688,
                                                                             0.1235693688);

final_score_2_c186 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 282234 => 0.1746532714,
    r_a46_curr_avm_autoval_d > 282234                                      => 0.4115353875,
    r_a46_curr_avm_autoval_d = NULL                                        => final_score_2_c187,
                                                                              0.1939683068);

final_score_2_c185 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_2_c186,
    f_phone_ver_insurance_d > 3.5                                     => -0.0303497402,
    f_phone_ver_insurance_d = NULL                                    => 0.1029587948,
                                                                         0.1029587948);

final_score_2_c188 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 4.5 => -0.0758124919,
    f_addrchangeecontrajindex_d > 4.5                                         => 0.1170474038,
    f_addrchangeecontrajindex_d = NULL                                        => -0.0368957558,
                                                                                 -0.0622284383);

final_score_2 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_2_c185,
    f_phone_ver_experian_d > 0.5                                    => final_score_2_c188,
    f_phone_ver_experian_d = NULL                                   => -0.0029366194,
                                                                       -0.0085506963);

final_score_3_c192 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 78.05 => 0.1115765143,
    r_c12_source_profile_d > 78.05                                    => 0.3342798631,
    r_c12_source_profile_d = NULL                                     => 0.1469718060,
                                                                         0.1469718060);

final_score_3_c193 := map(
    (nf_seg_fraudpoint_3_0 in ['2: Synth ID', '3: Derog'])                                                      => -0.0127583194,
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) => 0.1813498425,
    nf_seg_fraudpoint_3_0 = ''                                                                                	=> 0.1119434583,
                                                                                                                   0.1119434583);

final_score_3_c191 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 286638.5 => final_score_3_c192,
    r_a46_curr_avm_autoval_d > 286638.5                                      => 0.2945832563,
    r_a46_curr_avm_autoval_d = NULL                                          => final_score_3_c193,
                                                                                0.1543509320);

final_score_3_c190 := map(
    NULL < (real)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d <= 0.5 			=> final_score_3_c191,
    (real)k_nap_phn_verd_d > 0.5                              						=> -0.0095385414,
    (real)k_nap_phn_verd_d = NULL                             						=> 0.0745650362,
																																							0.0745650362);

final_score_3 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_3_c190,
    f_phone_ver_experian_d > 0.5                                    => -0.0620652862,
    f_phone_ver_experian_d = NULL                                   => -0.0105661595,
                                                                       -0.0175703943);

final_score_4_c197 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 78.5 => 0.0153547563,
    f_prevaddrageoldest_d > 78.5                                   => 0.1515147844,
    f_prevaddrageoldest_d = NULL                                   => 0.0803004656,
                                                                      0.0803004656);

final_score_4_c198 := map(
    NULL < f_mos_liens_unrel_cj_fseen_d AND f_mos_liens_unrel_cj_fseen_d <= 652.5 => 0.0133219004,
    f_mos_liens_unrel_cj_fseen_d > 652.5                                          => 0.2499224866,
    f_mos_liens_unrel_cj_fseen_d = NULL                                           => 0.2211313309,
                                                                                     0.2211313309);

final_score_4_c196 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 0.5 => final_score_4_c197,
    f_rel_homeover500_count_d > 0.5                                       => final_score_4_c198,
    f_rel_homeover500_count_d = NULL                                      => 0.1236250091,
                                                                             0.1236250091);

final_score_4_c195 := map(
    NULL < (real)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d <= 0.5 		=> final_score_4_c196,
    (real)k_nap_phn_verd_d > 0.5                              					=> -0.0043520208,
    (real)k_nap_phn_verd_d = NULL                             					=> 0.0610340405,
																																							0.0610340405);

final_score_4 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_4_c195,
    f_phone_ver_experian_d > 0.5                                    => -0.0599269810,
    f_phone_ver_experian_d = NULL                                   => -0.0074421673,
                                                                       -0.0200366196);

final_score_5_c203 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 3.5 => 0.1741562862,
    f_rel_homeover300_count_d > 3.5                                       => 0.2870366417,
    f_rel_homeover300_count_d = NULL                                      => 0.2144381873,
                                                                             0.2144381873);

final_score_5_c202 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => final_score_5_c203,
    f_hh_lienholders_i > 0.5                                => 0.0731732867,
    f_hh_lienholders_i = NULL                               => 0.1405385230,
                                                               0.1405385230);

final_score_5_c201 := map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d <= 3.5 => 0.0219024239,
    r_c14_addr_stability_v2_d > 3.5                                       => final_score_5_c202,
    r_c14_addr_stability_v2_d = NULL                                      => 0.0999387790,
                                                                             0.0999387790);

final_score_5_c200 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_5_c201,
    f_phone_ver_insurance_d > 3.5                                     => -0.0295474283,
    f_phone_ver_insurance_d = NULL                                    => 0.0465928484,
                                                                         0.0465928484);

final_score_5 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_5_c200,
    f_phone_ver_experian_d > 0.5                                    => -0.0563490357,
    f_phone_ver_experian_d = NULL                                   => -0.0061165501,
                                                                       -0.0212233300);

final_score_6_c206 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => -0.0447871116,
    f_validationrisktype_i > 1.5                                    => 0.2692345964,
    f_validationrisktype_i = NULL                                   => -0.0411242695,
                                                                       -0.0411242695);

final_score_6_c205 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 2.5 => final_score_6_c206,
    f_idverrisktype_i > 2.5                               => 0.1197394179,
    f_idverrisktype_i = NULL                              => -0.0305225702,
                                                             -0.0305225702);

final_score_6_c207 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.2084691763,
    f_phone_ver_experian_d > 0.5                                    => 0.1244839573,
    f_phone_ver_experian_d = NULL                                   => 0.1576581188,
                                                                       0.1576581188);

final_score_6_c208 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 1.5 => 0.0140504337,
    f_rel_homeover500_count_d > 1.5                                       => 0.1871037292,
    f_rel_homeover500_count_d = NULL                                      => -0.0349097871,
                                                                             0.0344287216);

final_score_6 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 4.5 => final_score_6_c205,
    f_addrchangeecontrajindex_d > 4.5                                         => final_score_6_c207,
    f_addrchangeecontrajindex_d = NULL                                        => final_score_6_c208,
                                                                                 -0.0117630329);

final_score_7_c213 := map(
    NULL < (real)k_inf_phn_verd_d AND (real)k_inf_phn_verd_d <= 0.5 			=> 0.1954131692,
    (real)k_inf_phn_verd_d > 0.5                              						=> 0.0457589859,
    (real)k_inf_phn_verd_d = NULL                             						=> 0.1465252692,
																																							0.1465252692);

final_score_7_c212 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => final_score_7_c213,
    r_phn_pcs_n > 0.5                         => -0.0088383517,
    r_phn_pcs_n = NULL                        => 0.0893623773,
                                                 0.0893623773);

final_score_7_c211 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_7_c212,
    f_phone_ver_experian_d > 0.5                                    => -0.0086335173,
    f_phone_ver_experian_d = NULL                                   => 0.0141023646,
                                                                       0.0201857718);

final_score_7_c210 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_7_c211,
    r_phn_cell_n > 0.5                          => -0.0566398481,
    r_phn_cell_n = NULL                         => -0.0234879498,
                                                   -0.0234879498);

final_score_7 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 5.5 => final_score_7_c210,
    f_addrchangeecontrajindex_d > 5.5                                         => 0.2303479493,
    f_addrchangeecontrajindex_d = NULL                                        => 0.0365532097,
                                                                                 -0.0090287039);

final_score_8_c216 := map(
    NULL < (real)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d <= 0.5 			=> 0.1282079249,
    (real)k_nap_phn_verd_d > 0.5                              						=> 0.0070148546,
    (real)k_nap_phn_verd_d = NULL                             						=> 0.0499961179,
																																								0.0499961179);

final_score_8_c215 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 75.05 => -0.0419080694,
    r_c12_source_profile_d > 75.05                                    => final_score_8_c216,
    r_c12_source_profile_d = NULL                                     => -0.0298894264,
                                                                         -0.0298894264);

final_score_8_c218 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => 0.2161256620,
    r_phn_pcs_n > 0.5                         => 0.0095012776,
    r_phn_pcs_n = NULL                        => 0.1581021614,
                                                 0.1581021614);

final_score_8_c217 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_8_c218,
    r_phn_cell_n > 0.5                          => 0.0185050717,
    r_phn_cell_n = NULL                         => 0.0856454073,
                                                   0.0856454073);

final_score_8 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 1.5 => final_score_8_c215,
    f_rel_homeover500_count_d > 1.5                                       => final_score_8_c217,
    f_rel_homeover500_count_d = NULL                                      => -0.0156815473,
                                                                             -0.0138866821);

final_score_9_c222 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 2.5 => -0.0070846461,
    f_idverrisktype_i > 2.5                               => 0.1103213232,
    f_idverrisktype_i = NULL                              => 0.0286502299,
                                                             0.0286502299);

final_score_9_c223 := map(
    NULL < f_hh_tot_derog_i AND f_hh_tot_derog_i <= 1.5 => 0.1813797964,
    f_hh_tot_derog_i > 1.5                              => 0.0631784587,
    f_hh_tot_derog_i = NULL                             => 0.1167384398,
                                                           0.1167384398);

final_score_9_c221 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 103.5 => final_score_9_c222,
    f_prevaddrageoldest_d > 103.5                                   => final_score_9_c223,
    f_prevaddrageoldest_d = NULL                                    => 0.0636123721,
                                                                       0.0636123721);

final_score_9_c220 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_9_c221,
    f_phone_ver_insurance_d > 3.5                                     => -0.0266018488,
    f_phone_ver_insurance_d = NULL                                    => 0.0267817957,
                                                                         0.0267817957);

final_score_9 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_9_c220,
    f_phone_ver_experian_d > 0.5                                    => -0.0498087160,
    f_phone_ver_experian_d = NULL                                   => 0.0066527017,
                                                                       -0.0214762293);

final_score_10_c226 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 2.5 => -0.0437493685,
    f_idverrisktype_i > 2.5                               => 0.0533576196,
    f_idverrisktype_i = NULL                              => -0.0289836911,
                                                             -0.0289836911);

final_score_10_c225 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => final_score_10_c226,
    f_validationrisktype_i > 1.5                                    => 0.1967535449,
    f_validationrisktype_i = NULL                                   => -0.0250528128,
                                                                       -0.0250528128);

final_score_10_c227 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 5.5 => 0.0617245303,
    f_addrchangeecontrajindex_d > 5.5                                         => 0.1693082003,
    f_addrchangeecontrajindex_d = NULL                                        => 0.1726643852,
                                                                                 0.0913526193);

final_score_10_c228 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 11081.5 => 0.0188039294,
    r_a49_curr_avm_chg_1yr_i > 11081.5                                      => 0.1529695555,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => -0.0279576543,
                                                                               -0.0203321811);

final_score_10 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 297926.5 => final_score_10_c225,
    r_l80_inp_avm_autoval_d > 297926.5                                     => final_score_10_c227,
    r_l80_inp_avm_autoval_d = NULL                                         => final_score_10_c228,
                                                                              -0.0101296787);

final_score_11_c233 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 37064 => 0.0613790935,
    r_a49_curr_avm_chg_1yr_i > 37064                                      => 0.2533812399,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => 0.0579098707,
                                                                             0.0833541598);

final_score_11_c232 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 4.5 => final_score_11_c233,
    r_p88_phn_dst_to_inp_add_i > 4.5                                        => 0.2041303548,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => 0.1434154895,
                                                                               0.1160109439);

final_score_11_c231 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => final_score_11_c232,
    r_phn_pcs_n > 0.5                         => 0.0036455212,
    r_phn_pcs_n = NULL                        => 0.0756595339,
                                                 0.0756595339);

final_score_11_c230 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_11_c231,
    r_phn_cell_n > 0.5                          => -0.0026525448,
    r_phn_cell_n = NULL                         => 0.0311184326,
                                                   0.0311184326);

final_score_11 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_11_c230,
    f_phone_ver_experian_d > 0.5                                    => -0.0464176862,
    f_phone_ver_experian_d = NULL                                   => 0.0055285378,
                                                                       -0.0190975824);

final_score_12_c235 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.0307830466,
    f_phone_ver_experian_d > 0.5                                    => -0.0610791399,
    f_phone_ver_experian_d = NULL                                   => -0.0064914286,
                                                                       -0.0312028905);

final_score_12_c237 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 0.5 => 0.1647341546,
    k_inq_adls_per_phone_i > 0.5                                    => 0.0183504001,
    k_inq_adls_per_phone_i = NULL                                   => 0.1259455480,
                                                                       0.1259455480);

final_score_12_c236 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_12_c237,
    r_phn_cell_n > 0.5                          => 0.0166133572,
    r_phn_cell_n = NULL                         => 0.0743489392,
                                                   0.0743489392);

final_score_12_c238 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 5.5 => -0.0256350466,
    r_wealth_index_d > 5.5                              => 0.1768576278,
    r_wealth_index_d = NULL                             => -0.0420119330,
                                                           -0.0224924224);

final_score_12 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 283746.5 => final_score_12_c235,
    r_a46_curr_avm_autoval_d > 283746.5                                      => final_score_12_c236,
    r_a46_curr_avm_autoval_d = NULL                                          => final_score_12_c238,
                                                                                -0.0148976196);

final_score_13_c241 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d <= 2.5 => 0.1096576569,
    r_f03_address_match_d > 2.5                                   => -0.0466439392,
    r_f03_address_match_d = NULL                                  => -0.0401999999,
                                                                     -0.0401999999);

final_score_13_c240 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 4.5 => final_score_13_c241,
    f_addrchangeecontrajindex_d > 4.5                                         => 0.0806524145,
    f_addrchangeecontrajindex_d = NULL                                        => 0.0145879199,
                                                                                 -0.0263347695);

final_score_13_c243 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.1514593023,
    f_phone_ver_experian_d > 0.5                                    => 0.1115257063,
    f_phone_ver_experian_d = NULL                                   => 0.1287156649,
                                                                       0.1287156649);

final_score_13_c242 := map(
    NULL < f_hh_tot_derog_i AND f_hh_tot_derog_i <= 2.5 => final_score_13_c243,
    f_hh_tot_derog_i > 2.5                              => -0.0035442164,
    f_hh_tot_derog_i = NULL                             => 0.0739207506,
                                                           0.0739207506);

final_score_13 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 75.05 => final_score_13_c240,
    r_c12_source_profile_d > 75.05                                    => final_score_13_c242,
    r_c12_source_profile_d = NULL                                     => -0.0753274997,
                                                                         -0.0137355507);

final_score_14_c247 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.1231153375,
    f_phone_ver_experian_d > 0.5                                    => 0.0648947094,
    f_phone_ver_experian_d = NULL                                   => 0.2164036145,
                                                                       0.1138175406);

final_score_14_c246 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => final_score_14_c247,
    f_hh_lienholders_i > 0.5                                => 0.0188628718,
    f_hh_lienholders_i = NULL                               => 0.0614864366,
                                                               0.0614864366);

final_score_14_c245 := map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d <= 3.5 => -0.0116254331,
    r_c14_addr_stability_v2_d > 3.5                                       => final_score_14_c246,
    r_c14_addr_stability_v2_d = NULL                                      => -0.0423592254,
                                                                             0.0270193549);

final_score_14_c248 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => 0.0054365016,
    r_phn_cell_n > 0.5                          => -0.0768529397,
    r_phn_cell_n = NULL                         => -0.0409432066,
                                                   -0.0409432066);

final_score_14 := map(
    NULL < (real)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d <= 0.5 			=> final_score_14_c245,
    (real)k_nap_phn_verd_d > 0.5                              						=> final_score_14_c248,
    (real)k_nap_phn_verd_d = NULL                            				 			=> -0.0197887237,
																																						-0.0197887237);

final_score_15_c252 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 4.5 => 0.0336760334,
    r_p88_phn_dst_to_inp_add_i > 4.5                                        => 0.1778465602,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => 0.1111788673,
                                                                               0.0501777989);

final_score_15_c251 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 39960 => final_score_15_c252,
    r_a49_curr_avm_chg_1yr_i > 39960                                      => 0.1636112205,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => 0.0488782839,
                                                                             0.0610247531);

final_score_15_c250 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => final_score_15_c251,
    r_phn_pcs_n > 0.5                         => -0.0407448453,
    r_phn_pcs_n = NULL                        => 0.0245822572,
                                                 0.0245822572);

final_score_15_c253 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 9.5 => -0.0443636304,
    k_inq_per_phone_i > 9.5                               => 0.2072559640,
    k_inq_per_phone_i = NULL                              => -0.0410218812,
                                                             -0.0410218812);

final_score_15 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_15_c250,
    r_phn_cell_n > 0.5                          => final_score_15_c253,
    r_phn_cell_n = NULL                         => -0.0126254368,
                                                   -0.0126254368);

final_score_16_c256 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 4.5 => 0.0140692133,
    k_inq_per_phone_i > 4.5                               => 0.2134016323,
    k_inq_per_phone_i = NULL                              => 0.0204746603,
                                                             0.0204746603);

final_score_16_c255 := map(
    NULL < 	(real)k_nap_phn_verd_d AND 	(real)k_nap_phn_verd_d <= 0.5 		=> final_score_16_c256,
    (real)k_nap_phn_verd_d > 0.5                              						=> -0.0488895900,
    (real)k_nap_phn_verd_d = NULL                             						=> -0.0282707507,
																																							-0.0282707507);

final_score_16_c258 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 70.5 => 0.0834606784,
    r_c12_source_profile_d > 70.5                                    => 0.1872456256,
    r_c12_source_profile_d = NULL                                    => 0.1078052956,
                                                                        0.1078052956);

final_score_16_c257 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => final_score_16_c258,
    f_hh_lienholders_i > 0.5                                => 0.0116045442,
    f_hh_lienholders_i = NULL                               => 0.0579870493,
                                                               0.0579870493);

final_score_16 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 1.5 => final_score_16_c255,
    f_rel_homeover500_count_d > 1.5                                       => final_score_16_c257,
    f_rel_homeover500_count_d = NULL                                      => -0.0257816977,
                                                                             -0.0166712430);

final_score_17_c260 := map(
    NULL < f_hh_tot_derog_i AND f_hh_tot_derog_i <= 1.5 => 0.1207672300,
    f_hh_tot_derog_i > 1.5                              => 0.0210521639,
    f_hh_tot_derog_i = NULL                             => 0.0631629089,
                                                           0.0631629089);

final_score_17_c263 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 71.35 => 0.0390248973,
    r_c12_source_profile_d > 71.35                                    => 0.1520790417,
    r_c12_source_profile_d = NULL                                     => 0.0664908121,
                                                                         0.0664908121);

final_score_17_c262 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_17_c263,
    f_phone_ver_experian_d > 0.5                                    => -0.0465831020,
    f_phone_ver_experian_d = NULL                                   => 0.0863576008,
                                                                       0.0117830675);

final_score_17_c261 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d <= 2.5 => final_score_17_c262,
    r_f03_address_match_d > 2.5                                   => -0.0415521453,
    r_f03_address_match_d = NULL                                  => -0.0211106930,
                                                                     -0.0288936479);

final_score_17 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 19498.5 => -0.0135624456,
    r_a49_curr_avm_chg_1yr_i > 19498.5                                      => final_score_17_c260,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => final_score_17_c261,
                                                                               -0.0106750464);

final_score_18_c268 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => -0.0068728847,
    f_validationrisktype_i > 1.5                                    => 0.1277147459,
    f_validationrisktype_i = NULL                                   => -0.0023530211,
                                                                       -0.0023530211);

final_score_18_c267 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 0.5 => final_score_18_c268,
    f_rel_homeover500_count_d > 0.5                                       => 0.0635258040,
    f_rel_homeover500_count_d = NULL                                      => -0.0237200681,
                                                                             0.0112152805);

final_score_18_c266 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 3.5 => final_score_18_c267,
    k_inq_per_phone_i > 3.5                               => 0.1610377913,
    k_inq_per_phone_i = NULL                              => 0.0189386472,
                                                             0.0189386472);

final_score_18_c265 := map(
    NULL < (real)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d <= 0.5 		=> final_score_18_c266,
    (real)k_nap_phn_verd_d > 0.5                              					=> -0.0362226163,
    (real)k_nap_phn_verd_d = NULL                             					=> -0.0193034053,
																																					-0.0193034053);

final_score_18 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 5.5 => final_score_18_c265,
    r_wealth_index_d > 5.5                              => 0.1202363675,
    r_wealth_index_d = NULL                             => -0.0370979265,
                                                           -0.0153843063);

final_score_19_c272 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.1210083421,
    f_phone_ver_experian_d > 0.5                                    => 0.0624132082,
    f_phone_ver_experian_d = NULL                                   => 0.0846463027,
                                                                       0.0846463027);

final_score_19_c271 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 71.35 => -0.0022352299,
    r_c12_source_profile_d > 71.35                                    => final_score_19_c272,
    r_c12_source_profile_d = NULL                                     => 0.0152185165,
                                                                         0.0152185165);

final_score_19_c270 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => -0.0396311324,
    r_i61_inq_collection_recency_d > 549                                            => final_score_19_c271,
    r_i61_inq_collection_recency_d = NULL                                           => -0.0194905954,
                                                                                       -0.0194905954);

final_score_19_c273 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => 0.1030832631,
    f_hh_lienholders_i > 0.5                                => 0.0029750753,
    f_hh_lienholders_i = NULL                               => 0.0530088468,
                                                               0.0530088468);

final_score_19 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 1.5 => final_score_19_c270,
    f_rel_homeover500_count_d > 1.5                                       => final_score_19_c273,
    f_rel_homeover500_count_d = NULL                                      => 0.0017881320,
                                                                             -0.0094531050);

final_score_20_c278 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 11.5 => 0.0209182318,
    r_p88_phn_dst_to_inp_add_i > 11.5                                        => 0.1224992537,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => 0.0788750120,
                                                                                0.0326918794);

final_score_20_c277 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => final_score_20_c278,
    r_f03_input_add_not_most_rec_i > 0.5                                            => 0.1377626965,
    r_f03_input_add_not_most_rec_i = NULL                                           => 0.0462438352,
                                                                                       0.0462438352);

final_score_20_c276 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => final_score_20_c277,
    r_phn_pcs_n > 0.5                         => -0.0430427583,
    r_phn_pcs_n = NULL                        => 0.0135131581,
                                                 0.0135131581);

final_score_20_c275 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_20_c276,
    r_phn_cell_n > 0.5                          => -0.0377420655,
    r_phn_cell_n = NULL                         => -0.0160005094,
                                                   -0.0160005094);

final_score_20 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 394.5 => final_score_20_c275,
    r_c13_max_lres_d > 394.5                              => 0.1497156066,
    r_c13_max_lres_d = NULL                               => -0.0250353467,
                                                             -0.0115082640);

final_score_21_c282 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 2.5 => 0.0221395143,
    k_inq_per_phone_i > 2.5                               => 0.1776645588,
    k_inq_per_phone_i = NULL                              => 0.0320288785,
                                                             0.0320288785);

final_score_21_c281 := map(
    NULL < (real)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d <= 0.5 		=> final_score_21_c282,
    (real)k_nap_phn_verd_d > 0.5                              					=> -0.0363753176,
    (real)k_nap_phn_verd_d = NULL                             					=> -0.0185020258,
																																						-0.0185020258);

final_score_21_c283 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 65.65 => 0.0244912613,
    r_c12_source_profile_d > 65.65                                    => 0.1183738959,
    r_c12_source_profile_d = NULL                                     => 0.0644666411,
                                                                         0.0644666411);

final_score_21_c280 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 40448 => final_score_21_c281,
    r_a49_curr_avm_chg_1yr_i > 40448                                      => final_score_21_c283,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => -0.0228856442,
                                                                             -0.0148316171);

final_score_21 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i <= 0.5 => final_score_21_c280,
    r_p85_phn_disconnected_i > 0.5                                      => 0.1272349554,
    r_p85_phn_disconnected_i = NULL                                     => -0.0112520700,
                                                                           -0.0112520700);

final_score_22_c285 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 3.5 => -0.0280993419,
    k_inq_lnames_per_addr_i > 3.5                                     => 0.1523723913,
    k_inq_lnames_per_addr_i = NULL                                    => -0.0246942148,
                                                                         -0.0246942148);

final_score_22_c287 := map(
    NULL < f_hh_bankruptcies_i AND f_hh_bankruptcies_i <= 0.5 => 0.1280521304,
    f_hh_bankruptcies_i > 0.5                                 => -0.0046296608,
    f_hh_bankruptcies_i = NULL                                => 0.0868012287,
                                                                 0.0868012287);

final_score_22_c288 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 98 => 0.1541513168,
    r_f00_dob_score_d > 98                               => 0.0039446696,
    r_f00_dob_score_d = NULL                             => 0.0086009779,
                                                            0.0086009779);

final_score_22_c286 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 4.5 => final_score_22_c287,
    f_rel_under25miles_cnt_d > 4.5                                      => final_score_22_c288,
    f_rel_under25miles_cnt_d = NULL                                     => 0.0304576623,
                                                                           0.0304576623);

final_score_22 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 115.5 => final_score_22_c285,
    f_prevaddrageoldest_d > 115.5                                   => final_score_22_c286,
    f_prevaddrageoldest_d = NULL                                    => -0.0521389580,
                                                                       -0.0060953011);

final_score_23_c290 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 98 => 0.1150889962,
    r_f00_dob_score_d > 98                               => -0.0249812303,
    r_f00_dob_score_d = NULL                             => -0.0233705666,
                                                            -0.0213373816);

final_score_23_c293 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 0.5 => 0.0154089276,
    f_rel_homeover500_count_d > 0.5                                       => 0.2117282877,
    f_rel_homeover500_count_d = NULL                                      => 0.0637218951,
                                                                             0.0637218951);

final_score_23_c292 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.1137834198,
    f_phone_ver_experian_d > 0.5                                    => final_score_23_c293,
    f_phone_ver_experian_d = NULL                                   => 0.0835428118,
                                                                       0.0835428118);

final_score_23_c291 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 0.5 => final_score_23_c292,
    r_d30_derog_count_i > 0.5                                 => 0.0123567419,
    r_d30_derog_count_i = NULL                                => 0.0352234923,
                                                                 0.0352234923);

final_score_23 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 71.1 => final_score_23_c290,
    r_c12_source_profile_d > 71.1                                    => final_score_23_c291,
    r_c12_source_profile_d = NULL                                    => -0.0282490395,
                                                                        -0.0087684854);

final_score_24_c296 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => 0.0645403859,
    f_phone_ver_insurance_d > 3.5                                     => 0.0031452173,
    f_phone_ver_insurance_d = NULL                                    => 0.0311762940,
                                                                         0.0311762940);

final_score_24_c295 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 5.5 => final_score_24_c296,
    r_l79_adls_per_addr_c6_i > 5.5                                      => 0.2181974638,
    r_l79_adls_per_addr_c6_i = NULL                                     => 0.0376689383,
                                                                           0.0376689383);

final_score_24_c298 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 1.5 => -0.0114066404,
    f_rel_homeover300_count_d > 1.5                                       => 0.0606533989,
    f_rel_homeover300_count_d = NULL                                      => 0.0161308797,
                                                                             0.0161308797);

final_score_24_c297 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 136.5 => -0.0406754034,
    f_prevaddrlenofres_d > 136.5                                  => final_score_24_c298,
    f_prevaddrlenofres_d = NULL                                   => -0.0241437858,
                                                                     -0.0241437858);

final_score_24 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d <= 2.5 => final_score_24_c295,
    r_f03_address_match_d > 2.5                                   => final_score_24_c297,
    r_f03_address_match_d = NULL                                  => -0.0412281762,
                                                                     -0.0131612193);

final_score_25_c300 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 98 => 0.1329363915,
    r_f00_dob_score_d > 98                               => -0.0116591135,
    r_f00_dob_score_d = NULL                             => -0.0079648491,
                                                            -0.0079648491);

final_score_25_c301 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 63.45 => 0.0250403049,
    r_c12_source_profile_d > 63.45                                    => 0.0972770595,
    r_c12_source_profile_d = NULL                                     => 0.0577452971,
                                                                         0.0577452971);

final_score_25_c303 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => 0.0029046606,
    r_c23_inp_addr_occ_index_d > 2                                        => 0.2833512613,
    r_c23_inp_addr_occ_index_d = NULL                                     => 0.1033348622,
                                                                             0.1033348622);

final_score_25_c302 := map(
    NULL < k_inq_adls_per_addr_i AND k_inq_adls_per_addr_i <= 3.5 => -0.0225087931,
    k_inq_adls_per_addr_i > 3.5                                   => final_score_25_c303,
    k_inq_adls_per_addr_i = NULL                                  => -0.0187482042,
                                                                     -0.0187482042);

final_score_25 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 42985.5 => final_score_25_c300,
    r_a49_curr_avm_chg_1yr_i > 42985.5                                      => final_score_25_c301,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => final_score_25_c302,
                                                                               -0.0090288550);

final_score_26_c305 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => 0.0087803698,
    f_hh_lienholders_i > 0.5                                => -0.0523012248,
    f_hh_lienholders_i = NULL                               => -0.0309984309,
                                                               -0.0309984309);

final_score_26_c307 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 0.5 => -0.0092008677,
    f_rel_homeover500_count_d > 0.5                                       => 0.0662300704,
    f_rel_homeover500_count_d = NULL                                      => -0.0402660806,
                                                                             0.0045478268);

final_score_26_c308 := map(
    NULL < r_d31_mostrec_bk_i AND r_d31_mostrec_bk_i <= 0.5 => 0.1233694524,
    r_d31_mostrec_bk_i > 0.5                                => -0.0112807703,
    r_d31_mostrec_bk_i = NULL                               => 0.0887804044,
                                                               0.0887804044);

final_score_26_c306 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 71.1 => final_score_26_c307,
    r_c12_source_profile_d > 71.1                                    => final_score_26_c308,
    r_c12_source_profile_d = NULL                                    => 0.0216649302,
                                                                        0.0216649302);

final_score_26 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => final_score_26_c305,
    r_i61_inq_collection_recency_d > 549                                            => final_score_26_c306,
    r_i61_inq_collection_recency_d = NULL                                           => -0.0317545643,
                                                                                       -0.0115268253);

final_score_27_c310 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => -0.0078240744,
    f_validationrisktype_i > 1.5                                    => 0.0925668934,
    f_validationrisktype_i = NULL                                   => -0.0058893734,
                                                                       -0.0058893734);

final_score_27_c312 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => 0.1153743533,
    r_phn_cell_n > 0.5                          => 0.0246502377,
    r_phn_cell_n = NULL                         => 0.0735274365,
                                                   0.0735274365);

final_score_27_c311 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 0.5 => final_score_27_c312,
    k_inq_adls_per_phone_i > 0.5                                    => -0.0236808171,
    k_inq_adls_per_phone_i = NULL                                   => 0.0458881179,
                                                                       0.0458881179);

final_score_27_c313 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 5.5 => -0.0213246220,
    r_wealth_index_d > 5.5                              => 0.0946696577,
    r_wealth_index_d = NULL                             => -0.0202942931,
                                                           -0.0189950889);

final_score_27 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 49826 => final_score_27_c310,
    r_a49_curr_avm_chg_1yr_i > 49826                                      => final_score_27_c311,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => final_score_27_c313,
                                                                             -0.0098546939);

final_score_28_c316 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i <= 0.5 => -0.0154356301,
    r_p85_phn_disconnected_i > 0.5                                      => 0.0900931086,
    r_p85_phn_disconnected_i = NULL                                     => -0.0131021012,
                                                                           -0.0131021012);

final_score_28_c317 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 52.5 => 0.0005885758,
    r_c13_max_lres_d > 52.5                              => 0.1975294900,
    r_c13_max_lres_d = NULL                              => 0.1127803261,
                                                            0.1127803261);

final_score_28_c315 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 6.5 => final_score_28_c316,
    r_l79_adls_per_addr_c6_i > 6.5                                      => final_score_28_c317,
    r_l79_adls_per_addr_c6_i = NULL                                     => -0.0113259309,
                                                                           -0.0113259309);

final_score_28_c318 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 409.5 => 0.0437105308,
    f_m_bureau_adl_fs_all_d > 409.5                                     => 0.1519729199,
    f_m_bureau_adl_fs_all_d = NULL                                      => 0.0688543105,
                                                                           0.0688543105);

final_score_28 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 283.5 => final_score_28_c315,
    f_prevaddrageoldest_d > 283.5                                   => final_score_28_c318,
    f_prevaddrageoldest_d = NULL                                    => 0.0143340928,
                                                                       -0.0053034563);

final_score_29_c322 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 3.5 => 0.0278512941,
    r_wealth_index_d > 3.5                              => 0.0951122994,
    r_wealth_index_d = NULL                             => 0.0650301499,
                                                           0.0650301499);

final_score_29_c321 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => final_score_29_c322,
    f_hh_lienholders_i > 0.5                                => 0.0109835093,
    f_hh_lienholders_i = NULL                               => 0.0358697627,
                                                               0.0358697627);

final_score_29_c320 := map(
    NULL < (real)k_inf_phn_verd_d AND (real)k_inf_phn_verd_d <= 0.5 		=> final_score_29_c321,
    (real)k_inf_phn_verd_d > 0.5                              					=> -0.0416828669,
    (real)k_inf_phn_verd_d = NULL                             					=> 0.0120643259,
																																				0.0120643259);

final_score_29_c323 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 178.5 => -0.0179726290,
    f_prevaddrageoldest_d > 178.5                                   => 0.1384161160,
    f_prevaddrageoldest_d = NULL                                    => -0.0534287212,
                                                                       -0.0060361986);

final_score_29 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_29_c320,
    f_phone_ver_experian_d > 0.5                                    => -0.0365578548,
    f_phone_ver_experian_d = NULL                                   => final_score_29_c323,
                                                                       -0.0194701551);

final_score_30_c328 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 0.5 => 0.0182110089,
    f_rel_homeover500_count_d > 0.5                                       => 0.0952267962,
    f_rel_homeover500_count_d = NULL                                      => 0.0231710679,
                                                                             0.0355072049);

final_score_30_c327 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 18058.5 => 0.0631592670,
    r_a49_curr_avm_chg_1yr_i > 18058.5                                      => 0.1131668885,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => final_score_30_c328,
                                                                               0.0601810987);

final_score_30_c326 := map(
    NULL < r_d31_mostrec_bk_i AND r_d31_mostrec_bk_i <= 0.5 => final_score_30_c327,
    r_d31_mostrec_bk_i > 0.5                                => -0.0248781973,
    r_d31_mostrec_bk_i = NULL                               => 0.0370420445,
                                                               0.0370420445);

final_score_30_c325 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => final_score_30_c326,
    r_phn_pcs_n > 0.5                         => -0.0319426563,
    r_phn_pcs_n = NULL                        => 0.0122014564,
                                                 0.0122014564);

final_score_30 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_30_c325,
    r_phn_cell_n > 0.5                          => -0.0287697303,
    r_phn_cell_n = NULL                         => -0.0110616235,
                                                   -0.0110616235);

final_score_31_c333 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 2.5 => -0.0054947830,
    f_srchunvrfdphonecount_i > 2.5                                      => 0.1980688799,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0031500706,
                                                                           -0.0031500706);

final_score_31_c332 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 3.5 => final_score_31_c333,
    f_rel_homeover500_count_d > 3.5                                       => 0.0664866194,
    f_rel_homeover500_count_d = NULL                                      => -0.0128848588,
                                                                             0.0018267429);

final_score_31_c331 := map(
    r_d31_bk_chapter_n != '' and NULL < (integer)r_d31_bk_chapter_n AND (integer)r_d31_bk_chapter_n <= 9 		=> -0.0564401444,
    (integer)r_d31_bk_chapter_n > 9                                					=> -0.0759961829,
    r_d31_bk_chapter_n = ''                             					=> final_score_31_c332,
																																							-0.0156150228);

final_score_31_c330 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 14.5 => final_score_31_c331,
    k_inq_per_phone_i > 14.5                               => 0.1678299279,
    k_inq_per_phone_i = NULL                               => -0.0144843597,
                                                              -0.0144843597);

final_score_31 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 98 => 0.1075299493,
    r_f00_dob_score_d > 98                               => final_score_31_c330,
    r_f00_dob_score_d = NULL                             => 0.0279829253,
                                                            -0.0098659181);

final_score_32_c335 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d <= 2.5 => 0.0661997646,
    r_f03_address_match_d > 2.5                                   => -0.0315170759,
    r_f03_address_match_d = NULL                                  => -0.0272668677,
                                                                     -0.0272668677);

final_score_32_c336 := map(
    NULL < f_hh_bankruptcies_i AND f_hh_bankruptcies_i <= 0.5 => 0.0561104125,
    f_hh_bankruptcies_i > 0.5                                 => -0.0251871629,
    f_hh_bankruptcies_i = NULL                                => 0.0295297800,
                                                                 0.0295297800);

final_score_32_c338 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => 0.0335229336,
    r_c23_inp_addr_occ_index_d > 2                                        => 0.1437579991,
    r_c23_inp_addr_occ_index_d = NULL                                     => 0.0766472995,
                                                                             0.0766472995);

final_score_32_c337 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 81.5 => -0.0124327325,
    f_prevaddrageoldest_d > 81.5                                   => final_score_32_c338,
    f_prevaddrageoldest_d = NULL                                   => -0.0343468706,
                                                                      0.0122811695);

final_score_32 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 3.5 => final_score_32_c335,
    f_addrchangeecontrajindex_d > 3.5                                         => final_score_32_c336,
    f_addrchangeecontrajindex_d = NULL                                        => final_score_32_c337,
                                                                                 -0.0119550092);

final_score_33_c343 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 0.5 => 0.0449530892,
    f_rel_homeover300_count_d > 0.5                                       => 0.0929906460,
    f_rel_homeover300_count_d = NULL                                      => 0.0007600571,
                                                                             0.0694406883);

final_score_33_c342 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 0.5 => final_score_33_c343,
    k_inq_per_phone_i > 0.5                               => 0.0029553252,
    k_inq_per_phone_i = NULL                              => 0.0484284448,
                                                             0.0484284448);

final_score_33_c341 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => final_score_33_c342,
    r_phn_pcs_n > 0.5                         => -0.0210711903,
    r_phn_pcs_n = NULL                        => 0.0240906158,
                                                 0.0240906158);

final_score_33_c340 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_33_c341,
    r_phn_cell_n > 0.5                          => -0.0183697560,
    r_phn_cell_n = NULL                         => -0.0000977072,
                                                   -0.0000977072);

final_score_33 := map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 190.5 => -0.0737273835,
    f_mos_liens_unrel_cj_lseen_d > 190.5                                          => final_score_33_c340,
    f_mos_liens_unrel_cj_lseen_d = NULL                                           => -0.0462803533,
                                                                                     -0.0125936143);

final_score_34_c348 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 88.5 => 0.0437873358,
    f_prevaddrageoldest_d > 88.5                                   => 0.1302505874,
    f_prevaddrageoldest_d = NULL                                   => 0.0768980694,
                                                                      0.0768980694);

final_score_34_c347 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 2.5 => 0.0104704479,
    f_idverrisktype_i > 2.5                               => final_score_34_c348,
    f_idverrisktype_i = NULL                              => 0.0239822157,
                                                             0.0239822157);

final_score_34_c346 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 4.5 => -0.0211449657,
    r_wealth_index_d > 4.5                              => final_score_34_c347,
    r_wealth_index_d = NULL                             => -0.0131609065,
                                                           -0.0131609065);

final_score_34_c345 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 3.5 => final_score_34_c346,
    k_inq_lnames_per_addr_i > 3.5                                     => 0.1072861008,
    k_inq_lnames_per_addr_i = NULL                                    => -0.0110027601,
                                                                         -0.0110027601);

final_score_34 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 407.5 => final_score_34_c345,
    r_c13_max_lres_d > 407.5                              => 0.1014827358,
    r_c13_max_lres_d = NULL                               => -0.0491919111,
                                                             -0.0088930993);

final_score_35_c353 := map(
    NULL < (real)k_inf_lname_verd_d AND (real)k_inf_lname_verd_d <= 0.5 		=> 0.0725586725,
    (real)k_inf_lname_verd_d > 0.5                                					=> -0.0122031368,
    (real)k_inf_lname_verd_d = NULL                               					=> 0.0539163556,
																																						0.0539163556);

final_score_35_c352 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 28.85 => -0.0347339780,
    r_c12_source_profile_d > 28.85                                    => final_score_35_c353,
    r_c12_source_profile_d = NULL                                     => 0.0390264084,
                                                                         0.0390264084);

final_score_35_c351 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => -0.0036599666,
    r_i61_inq_collection_recency_d > 549                                            => final_score_35_c352,
    r_i61_inq_collection_recency_d = NULL                                           => 0.0119410219,
                                                                                       0.0119410219);

final_score_35_c350 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_35_c351,
    f_phone_ver_experian_d > 0.5                                    => -0.0324398254,
    f_phone_ver_experian_d = NULL                                   => 0.0002435882,
                                                                       -0.0165639044);

final_score_35 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 504.5 => final_score_35_c350,
    r_c10_m_hdr_fs_d > 504.5                              => 0.1210193774,
    r_c10_m_hdr_fs_d = NULL                               => 0.0214063669,
                                                             -0.0143655173);

final_score_36_c358 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 8795.5 => -0.0158235192,
    r_a49_curr_avm_chg_1yr_i > 8795.5                                      => 0.0641733225,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => 0.0142529886,
                                                                              0.0201418435);

final_score_36_c357 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 4.5 => final_score_36_c358,
    k_inq_per_phone_i > 4.5                               => 0.1539775892,
    k_inq_per_phone_i = NULL                              => 0.0251001921,
                                                             0.0251001921);

final_score_36_c356 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 2.5 => 0.1001148116,
    f_rel_under25miles_cnt_d > 2.5                                      => final_score_36_c357,
    f_rel_under25miles_cnt_d = NULL                                     => 0.0393466660,
                                                                           0.0393466660);

final_score_36_c355 := map(
    NULL < r_c12_source_profile_index_d AND r_c12_source_profile_index_d <= 3.5 => -0.0181614899,
    r_c12_source_profile_index_d > 3.5                                          => final_score_36_c356,
    r_c12_source_profile_index_d = NULL                                         => 0.0122857142,
                                                                                   0.0122857142);

final_score_36 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 0.5 => final_score_36_c355,
    r_d30_derog_count_i > 0.5                                 => -0.0234280593,
    r_d30_derog_count_i = NULL                                => 0.0159315533,
                                                                 -0.0080493020);

final_score_37_c361 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => 0.0264406840,
    r_phn_cell_n > 0.5                          => -0.0241755170,
    r_phn_cell_n = NULL                         => -0.0030200977,
                                                   -0.0030200977);

final_score_37_c363 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 2.5 => 0.1036436871,
    r_d30_derog_count_i > 2.5                                 => 0.0108928620,
    r_d30_derog_count_i = NULL                                => 0.0838019365,
                                                                 0.0838019365);

final_score_37_c362 := map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i <= 3.5 => final_score_37_c363,
    f_rel_criminal_count_i > 3.5                                    => 0.0069188974,
    f_rel_criminal_count_i = NULL                                   => 0.0549889868,
                                                                       0.0549889868);

final_score_37_c360 := map(
    NULL < (real)k_inf_contradictory_i AND (real)k_inf_contradictory_i <= 0.5 		=> final_score_37_c361,
    (real)k_inf_contradictory_i > 0.5                                   					=> final_score_37_c362,
    (real)k_inf_contradictory_i = NULL                                  					=> 0.0140255825,
																																											0.0140255825);

final_score_37 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_37_c360,
    f_phone_ver_experian_d > 0.5                                    => -0.0279110292,
    f_phone_ver_experian_d = NULL                                   => 0.0045341661,
                                                                       -0.0125387257);

final_score_38_c368 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i <= 0.5 => 0.0016922894,
    r_p85_phn_disconnected_i > 0.5                                      => 0.0940227712,
    r_p85_phn_disconnected_i = NULL                                     => 0.0040139604,
                                                                           0.0040139604);

final_score_38_c367 := map(
    NULL < r_d34_unrel_liens_ct_i AND r_d34_unrel_liens_ct_i <= 0.5 => final_score_38_c368,
    r_d34_unrel_liens_ct_i > 0.5                                    => -0.0490189143,
    r_d34_unrel_liens_ct_i = NULL                                   => -0.0128942031,
                                                                       -0.0128942031);

final_score_38_c366 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 95 => 0.0797693426,
    r_f00_dob_score_d > 95                               => final_score_38_c367,
    r_f00_dob_score_d = NULL                             => -0.0006576732,
                                                            -0.0102874275);

final_score_38_c365 := map(
    NULL < f_recent_disconnects_i AND f_recent_disconnects_i <= 1.5 => final_score_38_c366,
    f_recent_disconnects_i > 1.5                                    => 0.1876816345,
    f_recent_disconnects_i = NULL                                   => -0.0092083150,
                                                                       -0.0092083150);

final_score_38 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 26.5 => final_score_38_c365,
    f_phones_per_addr_curr_i > 26.5                                      => 0.1695576686,
    f_phones_per_addr_curr_i = NULL                                      => -0.0314726615,
                                                                            -0.0081395297);

final_score_39_c371 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 10.5 => 0.0104850447,
    f_bus_addr_match_count_d > 10.5                                      => 0.1418200012,
    f_bus_addr_match_count_d = NULL                                      => 0.0149990121,
                                                                            0.0149990121);

final_score_39_c370 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => -0.0371515809,
    r_i61_inq_collection_recency_d > 549                                            => final_score_39_c371,
    r_i61_inq_collection_recency_d = NULL                                           => -0.0179091107,
                                                                                       -0.0179091107);

final_score_39_c373 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 3.5 => 0.0453175417,
    f_addrchangeecontrajindex_d > 3.5                                         => 0.1022878870,
    f_addrchangeecontrajindex_d = NULL                                        => 0.0133128512,
                                                                                 0.0263089092);

final_score_39_c372 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 3.5 => final_score_39_c373,
    k_inq_lnames_per_addr_i > 3.5                                     => 0.1477672963,
    k_inq_lnames_per_addr_i = NULL                                    => 0.0299610640,
                                                                         0.0299610640);

final_score_39 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 2.5 => final_score_39_c370,
    f_idverrisktype_i > 2.5                               => final_score_39_c372,
    f_idverrisktype_i = NULL                              => -0.0075764586,
                                                             -0.0082615299);

final_score_40_c377 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => 0.0425969907,
    r_c23_inp_addr_occ_index_d > 2                                        => 0.1774252533,
    r_c23_inp_addr_occ_index_d = NULL                                     => 0.0850026539,
                                                                             0.0850026539);

final_score_40_c376 := map(
    NULL < 	(real)k_nap_phn_verd_d AND 	(real)k_nap_phn_verd_d <= 0.5 		=> final_score_40_c377,
		(real)k_nap_phn_verd_d > 0.5                              			=> 0.0166969782,
    (real)k_nap_phn_verd_d = NULL                             			=> 0.0385103490,
																																				0.0385103490);

final_score_40_c375 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 1.5 => -0.0185889197,
    f_srchcomponentrisktype_i > 1.5                                       => final_score_40_c376,
    f_srchcomponentrisktype_i = NULL                                      => -0.0144797425,
                                                                             -0.0144797425);

final_score_40_c378 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 2.5 => 0.0196018077,
    f_rel_homeover300_count_d > 2.5                                       => 0.0664736391,
    f_rel_homeover300_count_d = NULL                                      => 0.0339719782,
                                                                             0.0339719782);

final_score_40 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 75.05 => final_score_40_c375,
    r_c12_source_profile_d > 75.05                                    => final_score_40_c378,
    r_c12_source_profile_d = NULL                                     => 0.0211585487,
                                                                         -0.0078632565);

final_score_41_c383 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 0.5 => 0.0738821857,
    k_inq_per_phone_i > 0.5                               => -0.0010139609,
    k_inq_per_phone_i = NULL                              => 0.0534810267,
                                                             0.0534810267);

final_score_41_c382 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => final_score_41_c383,
    f_hh_lienholders_i > 0.5                                => 0.0024002202,
    f_hh_lienholders_i = NULL                               => 0.0272001749,
                                                               0.0272001749);

final_score_41_c381 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => final_score_41_c382,
    r_phn_pcs_n > 0.5                         => -0.0343134632,
    r_phn_pcs_n = NULL                        => 0.0048977461,
                                                 0.0048977461);

final_score_41_c380 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_41_c381,
    r_phn_cell_n > 0.5                          => -0.0267554496,
    r_phn_cell_n = NULL                         => -0.0131743290,
                                                   -0.0131743290);

final_score_41 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 8.5 => final_score_41_c380,
    r_l79_adls_per_addr_c6_i > 8.5                                      => 0.1348784745,
    r_l79_adls_per_addr_c6_i = NULL                                     => -0.0121372916,
                                                                           -0.0121372916);

final_score_42_c388 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 42.5 => 0.0465218972,
    r_p88_phn_dst_to_inp_add_i > 42.5                                        => 0.1477817486,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => 0.0440739264,
                                                                                0.0523595363);

final_score_42_c387 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_42_c388,
    f_phone_ver_experian_d > 0.5                                    => 0.0256002647,
    f_phone_ver_experian_d = NULL                                   => 0.0612988585,
                                                                       0.0411768472);

final_score_42_c386 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 1.5 => final_score_42_c387,
    f_hh_lienholders_i > 1.5                                => -0.0202440081,
    f_hh_lienholders_i = NULL                               => 0.0259146953,
                                                               0.0259146953);

final_score_42_c385 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 1.5 => -0.0127479651,
    f_idverrisktype_i > 1.5                               => final_score_42_c386,
    f_idverrisktype_i = NULL                              => 0.0014050466,
                                                             0.0014050466);

final_score_42 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 38.5 => -0.0348967194,
    f_prevaddrageoldest_d > 38.5                                   => final_score_42_c385,
    f_prevaddrageoldest_d = NULL                                   => 0.0278605470,
                                                                      -0.0108028073);

final_score_43_c392 := map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 170.5 => -0.0415484849,
    f_mos_liens_unrel_cj_lseen_d > 170.5                                          => 0.0610409905,
    f_mos_liens_unrel_cj_lseen_d = NULL                                           => 0.0471514129,
                                                                                     0.0471514129);

final_score_43_c391 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 1.5 => 0.0139908714,
    f_rel_homeover300_count_d > 1.5                                       => final_score_43_c392,
    f_rel_homeover300_count_d = NULL                                      => -0.0345936120,
                                                                             0.0247582943);

final_score_43_c390 := map(
    NULL < (real)k_inf_lname_verd_d AND (real)k_inf_lname_verd_d <= 0.5 			=> final_score_43_c391,
    (real)k_inf_lname_verd_d > 0.5                                						=> -0.0425327701,
    (real)k_inf_lname_verd_d = NULL                              			 				=> 0.0111018281,
																																									0.0111018281);

final_score_43_c393 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i <= 0.5 => -0.0270877854,
    r_p85_phn_disconnected_i > 0.5                                      => 0.1287032288,
    r_p85_phn_disconnected_i = NULL                                     => -0.0250855839,
                                                                           -0.0250855839);

final_score_43 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_43_c390,
    f_phone_ver_insurance_d > 3.5                                     => final_score_43_c393,
    f_phone_ver_insurance_d = NULL                                    => 0.0226651394,
                                                                         -0.0099846377);

final_score_44_c397 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 250703.5 => 0.1410661844,
    r_l80_inp_avm_autoval_d > 250703.5                                     => 0.0058317214,
    r_l80_inp_avm_autoval_d = NULL                                         => 0.1102579006,
                                                                              0.0882841527);

final_score_44_c398 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 37.5 => 0.0148684494,
    r_p88_phn_dst_to_inp_add_i > 37.5                                        => 0.1146878618,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => 0.0393667717,
                                                                                0.0265992728);

final_score_44_c396 := map(
    NULL < nf_number_non_bureau_sources AND nf_number_non_bureau_sources <= 3.5 => final_score_44_c397,
    nf_number_non_bureau_sources > 3.5                                          => final_score_44_c398,
    nf_number_non_bureau_sources = NULL                                         => 0.0398140721,
                                                                                   0.0398140721);

final_score_44_c395 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 71.35 => 0.0013771063,
    r_c12_source_profile_d > 71.35                                    => final_score_44_c396,
    r_c12_source_profile_d = NULL                                     => 0.0006260275,
                                                                         0.0086707307);

final_score_44 := map(
    r_d31_bk_chapter_n != '' and NULL < (integer)r_d31_bk_chapter_n AND (integer)r_d31_bk_chapter_n <= 12 		=> -0.0390882562,
    (integer)r_d31_bk_chapter_n > 12                               						 	=> -0.0518344351,
    r_d31_bk_chapter_n = ''                              						=> final_score_44_c395,
																																										-0.0050083963);

final_score_45_c403 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 0.5 => -0.0041121879,
    f_rel_homeover500_count_d > 0.5                                       => 0.0405075075,
    f_rel_homeover500_count_d = NULL                                      => 0.0045153234,
                                                                             0.0045153234);

final_score_45_c402 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 10.5 => final_score_45_c403,
    f_rel_educationover12_count_d > 10.5                                           => -0.0299738144,
    f_rel_educationover12_count_d = NULL                                           => -0.0045966128,
                                                                                      -0.0110411054);

final_score_45_c401 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 21.5 => final_score_45_c402,
    f_bus_addr_match_count_d > 21.5                                      => 0.0984381300,
    f_bus_addr_match_count_d = NULL                                      => -0.0095374820,
                                                                            -0.0095374820);

final_score_45_c400 := map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i <= 0.5 => final_score_45_c401,
    r_p85_phn_not_issued_i > 0.5                                    => 0.1108056826,
    r_p85_phn_not_issued_i = NULL                                   => -0.0088492132,
                                                                       -0.0088492132);

final_score_45 := map(
    NULL < r_f00_input_dob_match_level_d AND r_f00_input_dob_match_level_d <= 1.5 => 0.1454839810,
    r_f00_input_dob_match_level_d > 1.5                                           => final_score_45_c400,
    r_f00_input_dob_match_level_d = NULL                                          => -0.0077781207,
                                                                                     -0.0078637051);

final_score_46_c407 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => -0.0205732940,
    r_c23_inp_addr_occ_index_d > 2                                        => 0.0241648202,
    r_c23_inp_addr_occ_index_d = NULL                                     => -0.0119464330,
                                                                             -0.0119464330);

final_score_46_c406 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 412.5 => final_score_46_c407,
    r_c13_max_lres_d > 412.5                              => 0.0743347053,
    r_c13_max_lres_d = NULL                               => -0.0100969322,
                                                             -0.0100969322);

final_score_46_c405 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 5.5 => final_score_46_c406,
    r_wealth_index_d > 5.5                              => 0.0564312192,
    r_wealth_index_d = NULL                             => 0.0280054256,
                                                           -0.0078949428);

final_score_46_c408 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 3.5 => 0.1612733157,
    f_inq_count24_i > 3.5                             => 0.0335125283,
    f_inq_count24_i = NULL                            => 0.0878900535,
                                                         0.0878900535);

final_score_46 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 9.5 => final_score_46_c405,
    k_inq_per_phone_i > 9.5                               => final_score_46_c408,
    k_inq_per_phone_i = NULL                              => -0.0066399622,
                                                             -0.0066399622);

final_score_47_c410 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 83.95 => -0.0085258840,
    r_c12_source_profile_d > 83.95                                    => 0.0861719283,
    r_c12_source_profile_d = NULL                                     => -0.0069181485,
                                                                         -0.0069181485);

final_score_47_c413 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 0.5 => 0.0201796474,
    f_rel_homeover300_count_d > 0.5                                       => 0.0956130421,
    f_rel_homeover300_count_d = NULL                                      => 0.0588334056,
                                                                             0.0588334056);

final_score_47_c412 := map(
    NULL < f_accident_recency_d AND f_accident_recency_d <= 61.5 => 0.1948332799,
    f_accident_recency_d > 61.5                                  => final_score_47_c413,
    f_accident_recency_d = NULL                                  => 0.0911533757,
                                                                    0.0911533757);

final_score_47_c411 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 75.05 => 0.0251215959,
    r_c12_source_profile_d > 75.05                                    => final_score_47_c412,
    r_c12_source_profile_d = NULL                                     => 0.0459093784,
                                                                         0.0459093784);

final_score_47 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 279.5 => final_score_47_c410,
    f_prevaddrageoldest_d > 279.5                                   => final_score_47_c411,
    f_prevaddrageoldest_d = NULL                                    => -0.0136263822,
                                                                       -0.0032009758);

final_score_48_c418 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 4.5 => 0.0898858529,
    f_rel_under500miles_cnt_d > 4.5                                       => -0.0043502774,
    f_rel_under500miles_cnt_d = NULL                                      => 0.0080065927,
                                                                             0.0080065927);

final_score_48_c417 := map(
    NULL < f_hh_collections_ct_i AND f_hh_collections_ct_i <= 0.5 => 0.1021536027,
    f_hh_collections_ct_i > 0.5                                   => final_score_48_c418,
    f_hh_collections_ct_i = NULL                                  => 0.0225627988,
                                                                     0.0225627988);

final_score_48_c416 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 1.5 => -0.0160427805,
    f_bus_addr_match_count_d > 1.5                                      => final_score_48_c417,
    f_bus_addr_match_count_d = NULL                                     => -0.0082053358,
                                                                           -0.0082053358);

final_score_48_c415 := map(
    NULL < nf_inq_per_add_nas_479 AND nf_inq_per_add_nas_479 <= 2.5 => final_score_48_c416,
    nf_inq_per_add_nas_479 > 2.5                                    => 0.1401934639,
    nf_inq_per_add_nas_479 = NULL                                   => -0.0072240006,
                                                                       -0.0072240006);

final_score_48 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 2.5 => final_score_48_c415,
    f_srchunvrfdphonecount_i > 2.5                                      => 0.1346315406,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0325228474,
                                                                           -0.0058394066);

final_score_49_c422 := map(
    NULL < r_d31_mostrec_bk_i AND r_d31_mostrec_bk_i <= 0.5 => 0.0895353351,
    r_d31_mostrec_bk_i > 0.5                                => -0.0016547246,
    r_d31_mostrec_bk_i = NULL                               => 0.0690557798,
                                                               0.0690557798);

final_score_49_c423 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 4.5 => 0.0164018379,
    r_wealth_index_d > 4.5                              => 0.0938171347,
    r_wealth_index_d = NULL                             => 0.0285598050,
                                                           0.0285598050);

final_score_49_c421 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 21046.5 => 0.0260988390,
    r_a49_curr_avm_chg_1yr_i > 21046.5                                      => final_score_49_c422,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => final_score_49_c423,
                                                                               0.0346250706);

final_score_49_c420 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => final_score_49_c421,
    r_phn_pcs_n > 0.5                         => -0.0242017314,
    r_phn_pcs_n = NULL                        => 0.0134077876,
                                                 0.0134077876);

final_score_49 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_49_c420,
    r_phn_cell_n > 0.5                          => -0.0175411476,
    r_phn_cell_n = NULL                         => -0.0040908704,
                                                   -0.0040908704);

final_score_50_c427 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 2.5 => -0.0015621949,
    f_phone_ver_insurance_d > 2.5                                     => 0.0556509442,
    f_phone_ver_insurance_d = NULL                                    => 0.0192541928,
                                                                         0.0192541928);

final_score_50_c426 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_50_c427,
    f_phone_ver_insurance_d > 3.5                                     => -0.0196620133,
    f_phone_ver_insurance_d = NULL                                    => -0.0027534105,
                                                                         -0.0027534105);

final_score_50_c428 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 7.5 => 0.1154660652,
    f_rel_under100miles_cnt_d > 7.5                                       => 0.0176696069,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0625582734,
                                                                             0.0625582734);

final_score_50_c425 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 4.5 => final_score_50_c426,
    f_bus_addr_match_count_d > 4.5                                      => final_score_50_c428,
    f_bus_addr_match_count_d = NULL                                     => 0.0033817556,
                                                                           0.0033817556);

final_score_50 := map(
    NULL < f_hh_bankruptcies_i AND f_hh_bankruptcies_i <= 0.5 => final_score_50_c425,
    f_hh_bankruptcies_i > 0.5                                 => -0.0311670028,
    f_hh_bankruptcies_i = NULL                                => -0.0293408864,
                                                                 -0.0102848700);

final_score_51_c430 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 7.5 => 0.1038718573,
    f_rel_under100miles_cnt_d > 7.5                                       => 0.0183828075,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0564703414,
                                                                             0.0564703414);

final_score_51_c432 := map(
    NULL < f_divrisktype_i AND f_divrisktype_i <= 6.5 => -0.0117531893,
    f_divrisktype_i > 6.5                             => 0.1148921150,
    f_divrisktype_i = NULL                            => -0.0109020478,
                                                         -0.0109020478);

final_score_51_c433 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 8.5 => 0.0615644437,
    f_rel_under25miles_cnt_d > 8.5                                      => 0.0017309365,
    f_rel_under25miles_cnt_d = NULL                                     => 0.0377800039,
                                                                           0.0377800039);

final_score_51_c431 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 78.75 => final_score_51_c432,
    r_c12_source_profile_d > 78.75                                    => final_score_51_c433,
    r_c12_source_profile_d = NULL                                     => -0.0076015697,
                                                                         -0.0076015697);

final_score_51 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 98 => final_score_51_c430,
    r_f00_dob_score_d > 98                               => final_score_51_c431,
    r_f00_dob_score_d = NULL                             => 0.0313848813,
                                                            -0.0048760053);

final_score_52_c437 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => -0.0245856480,
    r_i61_inq_collection_recency_d > 549                                            => 0.0221705977,
    r_i61_inq_collection_recency_d = NULL                                           => -0.0081577779,
                                                                                       -0.0081577779);

final_score_52_c436 := map(
    NULL < nf_inq_per_add_nas_479 AND nf_inq_per_add_nas_479 <= 0.5 => final_score_52_c437,
    nf_inq_per_add_nas_479 > 0.5                                    => 0.1123293373,
    nf_inq_per_add_nas_479 = NULL                                   => -0.0066147199,
                                                                       -0.0066147199);

final_score_52_c438 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 2.5 => -0.0120353442,
    f_srchunvrfdphonecount_i > 2.5                                      => 0.1216201417,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0099350628,
                                                                           -0.0099350628);

final_score_52_c435 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 186000 => final_score_52_c436,
    r_a49_curr_avm_chg_1yr_i > 186000                                      => 0.0940057853,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => final_score_52_c438,
                                                                              -0.0078347508);

final_score_52 := map(
    NULL < r_f00_input_dob_match_level_d AND r_f00_input_dob_match_level_d <= 1.5 => 0.1307269491,
    r_f00_input_dob_match_level_d > 1.5                                           => final_score_52_c435,
    r_f00_input_dob_match_level_d = NULL                                          => 0.0088910655,
                                                                                     -0.0068067371);

final_score_53_c441 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 4.5 => 0.0157349764,
    r_l79_adls_per_addr_c6_i > 4.5                                      => 0.1267614631,
    r_l79_adls_per_addr_c6_i = NULL                                     => 0.0212972501,
                                                                           0.0212972501);

final_score_53_c440 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 252.5 => final_score_53_c441,
    r_c13_max_lres_d > 252.5                              => 0.0871942340,
    r_c13_max_lres_d = NULL                               => 0.0311046608,
                                                             0.0311046608);

final_score_53_c443 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 20283 => -0.0198027969,
    r_a49_curr_avm_chg_1yr_i > 20283                                      => 0.0227252222,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => -0.0203364759,
                                                                             -0.0138444449);

final_score_53_c442 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 12.5 => final_score_53_c443,
    k_inq_per_phone_i > 12.5                               => 0.1261654095,
    k_inq_per_phone_i = NULL                               => -0.0128152955,
                                                              -0.0128152955);

final_score_53 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 2.5 => final_score_53_c440,
    f_rel_under25miles_cnt_d > 2.5                                      => final_score_53_c442,
    f_rel_under25miles_cnt_d = NULL                                     => -0.0164178443,
                                                                           -0.0059428670);

final_score_54_c447 := map(
    NULL < (real)k_inf_phn_verd_d AND (real)k_inf_phn_verd_d <= 0.5 		=> 0.1520422555,
    (real)k_inf_phn_verd_d > 0.5                              					=> 0.0118193506,
    (real)k_inf_phn_verd_d = NULL                             					=> 0.0926169352,
																																						0.0926169352);

final_score_54_c446 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 5.5 => 0.0263502400,
    f_bus_addr_match_count_d > 5.5                                      => final_score_54_c447,
    f_bus_addr_match_count_d = NULL                                     => 0.0330921995,
                                                                           0.0330921995);

final_score_54_c448 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 5.5 => -0.0221727372,
    f_rel_homeover300_count_d > 5.5                                       => 0.0256758291,
    f_rel_homeover300_count_d = NULL                                      => -0.0119309371,
                                                                             -0.0119309371);

final_score_54_c445 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 4.5 => final_score_54_c446,
    f_rel_under100miles_cnt_d > 4.5                                       => final_score_54_c448,
    f_rel_under100miles_cnt_d = NULL                                      => -0.0021432987,
                                                                             -0.0021432987);

final_score_54 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 38.5 => -0.0321351275,
    f_prevaddrageoldest_d > 38.5                                   => final_score_54_c445,
    f_prevaddrageoldest_d = NULL                                   => -0.0035903820,
                                                                      -0.0123593332);

final_score_55_c450 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 3.5 => -0.0130423778,
    r_e57_br_source_count_d > 3.5                                     => 0.0676628100,
    r_e57_br_source_count_d = NULL                                    => -0.0107031749,
                                                                         -0.0107031749);

final_score_55_c452 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 3.5 => 0.0062403199,
    k_inq_ssns_per_addr_i > 3.5                                   => 0.1087955628,
    k_inq_ssns_per_addr_i = NULL                                  => 0.0105340982,
                                                                     0.0105340982);

final_score_55_c453 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 7.5 => 0.1729480452,
    f_rel_educationover12_count_d > 7.5                                           => 0.0445872070,
    f_rel_educationover12_count_d = NULL                                          => 0.0859939290,
                                                                                     0.0859939290);

final_score_55_c451 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 0.5 => final_score_55_c452,
    f_bus_addr_match_count_d > 0.5                                      => final_score_55_c453,
    f_bus_addr_match_count_d = NULL                                     => 0.0215719398,
                                                                           0.0215719398);

final_score_55 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => final_score_55_c450,
    r_c23_inp_addr_occ_index_d > 2                                        => final_score_55_c451,
    r_c23_inp_addr_occ_index_d = NULL                                     => 0.0119438600,
                                                                             -0.0042278658);

final_score_56_c458 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 2.5 => 0.0690754201,
    r_l79_adls_per_addr_curr_i > 2.5                                        => 0.1569714975,
    r_l79_adls_per_addr_curr_i = NULL                                       => 0.0995699776,
                                                                               0.0995699776);

final_score_56_c457 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 9.5 => 0.0206332409,
    f_addrs_per_ssn_i > 9.5                               => final_score_56_c458,
    f_addrs_per_ssn_i = NULL                              => 0.0678850746,
                                                             0.0678850746);

final_score_56_c456 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_56_c457,
    f_phone_ver_experian_d > 0.5                                    => 0.0338733587,
    f_phone_ver_experian_d = NULL                                   => 0.0357012497,
                                                                       0.0472079633);

final_score_56_c455 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 5.5 => final_score_56_c456,
    f_rel_under25miles_cnt_d > 5.5                                      => 0.0063650994,
    f_rel_under25miles_cnt_d = NULL                                     => 0.0232435224,
                                                                           0.0232435224);

final_score_56 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 2.5 => -0.0128124722,
    f_idverrisktype_i > 2.5                               => final_score_56_c455,
    f_idverrisktype_i = NULL                              => -0.0008943956,
                                                             -0.0056068719);

final_score_57_c462 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 4.5 => 0.0114544533,
    f_rel_homeover500_count_d > 4.5                                       => 0.0672537224,
    f_rel_homeover500_count_d = NULL                                      => -0.0153327310,
                                                                             0.0130443271);

final_score_57_c461 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 3.5 => final_score_57_c462,
    r_e57_br_source_count_d > 3.5                                     => 0.1632453605,
    r_e57_br_source_count_d = NULL                                    => 0.0153425333,
                                                                         0.0153425333);

final_score_57_c463 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => 0.1991116404,
    r_phn_cell_n > 0.5                          => 0.0469944611,
    r_phn_cell_n = NULL                         => 0.1193673922,
                                                   0.1193673922);

final_score_57_c460 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => final_score_57_c461,
    f_srchunvrfdaddrcount_i > 0.5                                     => final_score_57_c463,
    f_srchunvrfdaddrcount_i = NULL                                    => 0.0187043845,
                                                                         0.0187043845);

final_score_57 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => -0.0181145300,
    r_i61_inq_collection_recency_d > 549                                            => final_score_57_c460,
    r_i61_inq_collection_recency_d = NULL                                           => -0.0083320823,
                                                                                       -0.0042920004);

final_score_58_c466 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 42184 => -0.0014544605,
    r_a49_curr_avm_chg_1yr_i > 42184                                      => 0.0388074715,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => -0.0147719925,
                                                                             -0.0050274240);

final_score_58_c468 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 158.5 => 0.0031900385,
    r_c10_m_hdr_fs_d > 158.5                              => 0.0943525811,
    r_c10_m_hdr_fs_d = NULL                               => 0.0615567955,
                                                             0.0615567955);

final_score_58_c467 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 10.5 => final_score_58_c468,
    f_rel_educationover12_count_d > 10.5                                           => 0.0056824048,
    f_rel_educationover12_count_d = NULL                                           => 0.0359510689,
                                                                                      0.0359510689);

final_score_58_c465 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => final_score_58_c466,
    r_f03_input_add_not_most_rec_i > 0.5                                            => final_score_58_c467,
    r_f03_input_add_not_most_rec_i = NULL                                           => 0.0009265453,
                                                                                       0.0009265453);

final_score_58 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 549 => -0.0472419949,
    r_i60_inq_hiriskcred_recency_d > 549                                            => final_score_58_c465,
    r_i60_inq_hiriskcred_recency_d = NULL                                           => -0.0160050595,
                                                                                       -0.0102371931);

final_score_59_c473 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 54.5 => -0.0007679102,
    f_prevaddrageoldest_d > 54.5                                   => 0.0386692177,
    f_prevaddrageoldest_d = NULL                                   => 0.0226780403,
                                                                      0.0226780403);

final_score_59_c472 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 5.5 => final_score_59_c473,
    k_inq_per_phone_i > 5.5                               => 0.1095660656,
    k_inq_per_phone_i = NULL                              => 0.0263692154,
                                                             0.0263692154);

final_score_59_c471 := map(
    NULL < (real)k_inf_lname_verd_d AND (real)k_inf_lname_verd_d <= 0.5 		=> final_score_59_c472,
    (real)k_inf_lname_verd_d > 0.5                                					=> -0.0299953988,
    (real)k_inf_lname_verd_d = NULL                               					=> 0.0125546812,
																																								0.0125546812);

final_score_59_c470 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_59_c471,
    f_phone_ver_experian_d > 0.5                                    => -0.0183256282,
    f_phone_ver_experian_d = NULL                                   => 0.0367673537,
                                                                       -0.0057298479);

final_score_59 := map(
    NULL < r_c12_source_profile_index_d AND r_c12_source_profile_index_d <= 1.5 => -0.0649620822,
    r_c12_source_profile_index_d > 1.5                                          => final_score_59_c470,
    r_c12_source_profile_index_d = NULL                                         => 0.0158557695,
                                                                                   -0.0094975021);

final_score_60_c477 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => -0.0042226984,
    f_srchunvrfdaddrcount_i > 0.5                                     => 0.1065396133,
    f_srchunvrfdaddrcount_i = NULL                                    => -0.0012325694,
                                                                         -0.0012325694);

final_score_60_c476 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 98 => 0.0669654104,
    r_f00_dob_score_d > 98                               => final_score_60_c477,
    r_f00_dob_score_d = NULL                             => 0.0006509776,
                                                            0.0006509776);

final_score_60_c478 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 0.5 => 0.0775467429,
    k_inq_adls_per_phone_i > 0.5                                    => -0.0450060321,
    k_inq_adls_per_phone_i = NULL                                   => 0.0438189834,
                                                                       0.0438189834);

final_score_60_c475 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 82275 => final_score_60_c476,
    r_a49_curr_avm_chg_1yr_i > 82275                                      => final_score_60_c478,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => -0.0082200383,
                                                                             -0.0030643733);

final_score_60 := map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i <= 0.5 => final_score_60_c475,
    r_p85_phn_not_issued_i > 0.5                                    => 0.1104169507,
    r_p85_phn_not_issued_i = NULL                                   => -0.0024624142,
                                                                       -0.0024624142);

final_score_61_c480 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 0.5 => -0.0159042576,
    f_rel_homeover500_count_d > 0.5                                       => 0.0199356331,
    f_rel_homeover500_count_d = NULL                                      => -0.0031875987,
                                                                             -0.0076315548);

final_score_61_c483 := map(
    NULL < (real)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d <= 0.5 			=> 0.1773605701,
    (real)k_nap_phn_verd_d > 0.5                              						=> 0.0979239025,
    (real)k_nap_phn_verd_d = NULL                             						=> 0.1330387636,
																																							0.1330387636);

final_score_61_c482 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 27.1 => -0.0093027134,
    r_c12_source_profile_d > 27.1                                    => final_score_61_c483,
    r_c12_source_profile_d = NULL                                    => 0.0855064212,
                                                                        0.0855064212);

final_score_61_c481 := map(
    NULL < nf_number_non_bureau_sources AND nf_number_non_bureau_sources <= 3.5 => final_score_61_c482,
    nf_number_non_bureau_sources > 3.5                                          => 0.0105862064,
    nf_number_non_bureau_sources = NULL                                         => 0.0420809684,
                                                                                   0.0420809684);

final_score_61 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 1.5 => final_score_61_c480,
    f_srchcomponentrisktype_i > 1.5                                       => final_score_61_c481,
    f_srchcomponentrisktype_i = NULL                                      => -0.0151971225,
                                                                             -0.0042158001);

final_score_62_c487 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 454.5 => -0.0102701318,
    f_m_bureau_adl_fs_all_d > 454.5                                     => 0.1107362994,
    f_m_bureau_adl_fs_all_d = NULL                                      => -0.0065943917,
                                                                           -0.0065943917);

final_score_62_c488 := map(
    NULL < (real)k_inf_phn_verd_d AND (real)k_inf_phn_verd_d <= 0.5 		=> 0.0520176063,
    (real)k_inf_phn_verd_d > 0.5                              					=> -0.0232853389,
    (real)k_inf_phn_verd_d = NULL                             					=> 0.0321436664,
																																						0.0321436664);

final_score_62_c486 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 2.5 => final_score_62_c487,
    f_phone_ver_insurance_d > 2.5                                     => final_score_62_c488,
    f_phone_ver_insurance_d = NULL                                    => 0.0078259936,
                                                                         0.0078259936);

final_score_62_c485 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_62_c486,
    f_phone_ver_insurance_d > 3.5                                     => -0.0247813344,
    f_phone_ver_insurance_d = NULL                                    => -0.0116953679,
                                                                         -0.0116953679);

final_score_62 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => final_score_62_c485,
    f_srchunvrfdaddrcount_i > 0.5                                     => 0.0773582189,
    f_srchunvrfdaddrcount_i = NULL                                    => -0.0183040592,
                                                                         -0.0087703890);

final_score_63_c493 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 1.5 => 0.0067832302,
    f_idverrisktype_i > 1.5                               => 0.0509595283,
    f_idverrisktype_i = NULL                              => 0.0274537530,
                                                             0.0274537530);

final_score_63_c492 := map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 0.5 => final_score_63_c493,
    f_hh_members_w_derog_i > 0.5                                    => -0.0062324442,
    f_hh_members_w_derog_i = NULL                                   => 0.0022064880,
                                                                       0.0022064880);

final_score_63_c491 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 3.5 => -0.0257157403,
    r_wealth_index_d > 3.5                              => final_score_63_c492,
    r_wealth_index_d = NULL                             => -0.0115335347,
                                                           -0.0115335347);

final_score_63_c490 := map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i <= 20.5 => final_score_63_c491,
    k_inq_per_addr_i > 20.5                              => 0.1080697647,
    k_inq_per_addr_i = NULL                              => -0.0107077352,
                                                            -0.0107077352);

final_score_63 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 80 => 0.0976938312,
    r_f00_dob_score_d > 80                               => final_score_63_c490,
    r_f00_dob_score_d = NULL                             => 0.0007097286,
                                                            -0.0096849522);

final_score_64_c495 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 102.5 => 0.0068174957,
    f_prevaddrlenofres_d > 102.5                                  => 0.1040361374,
    f_prevaddrlenofres_d = NULL                                   => 0.0480996763,
                                                                     0.0480996763);

final_score_64_c498 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 2.5 => 0.1148354317,
    f_rel_educationover12_count_d > 2.5                                           => 0.0203781193,
    f_rel_educationover12_count_d = NULL                                          => 0.0258917566,
                                                                                     0.0258917566);

final_score_64_c497 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 71.1 => -0.0064911416,
    r_c12_source_profile_d > 71.1                                    => final_score_64_c498,
    r_c12_source_profile_d = NULL                                    => 0.0006134359,
                                                                        0.0006134359);

final_score_64_c496 := map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 168.5 => -0.0599946350,
    f_mos_liens_unrel_cj_lseen_d > 168.5                                          => final_score_64_c497,
    f_mos_liens_unrel_cj_lseen_d = NULL                                           => -0.0092880004,
                                                                                     -0.0092880004);

final_score_64 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 98 => final_score_64_c495,
    r_f00_dob_score_d > 98                               => final_score_64_c496,
    r_f00_dob_score_d = NULL                             => 0.0007189425,
                                                            -0.0073819869);

final_score_65_c501 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 481.5 => -0.0053876637,
    f_m_bureau_adl_fs_all_d > 481.5                                     => 0.0693337805,
    f_m_bureau_adl_fs_all_d = NULL                                      => 0.0209389360,
                                                                           -0.0037758667);

final_score_65_c500 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 9.5 => final_score_65_c501,
    k_inq_per_phone_i > 9.5                               => 0.0763777423,
    k_inq_per_phone_i = NULL                              => -0.0026966708,
                                                             -0.0026966708);

final_score_65_c503 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 1.5 => 0.1603755247,
    r_d30_derog_count_i > 1.5                                 => 0.0240405082,
    r_d30_derog_count_i = NULL                                => 0.1011702785,
                                                                 0.1011702785);

final_score_65_c502 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 345.5 => 0.0293265387,
    f_m_bureau_adl_fs_notu_d > 345.5                                      => final_score_65_c503,
    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0520378469,
                                                                             0.0520378469);

final_score_65 := map(
    NULL < f_bus_fname_verd_d AND f_bus_fname_verd_d <= 0.5 => final_score_65_c500,
    f_bus_fname_verd_d > 0.5                                => final_score_65_c502,
    f_bus_fname_verd_d = NULL                               => -0.0003845993,
                                                               -0.0003845993);

final_score_66_c507 := map(
    NULL < (real)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d <= 0.5 		=> 0.1277656125,
    (real)k_nap_phn_verd_d > 0.5                              					=> 0.0342823617,
    (real)k_nap_phn_verd_d = NULL                             					=> 0.0715256889,
																																						0.0715256889);

final_score_66_c506 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 2.5 => 0.0046354288,
    f_srchcomponentrisktype_i > 2.5                                       => final_score_66_c507,
    f_srchcomponentrisktype_i = NULL                                      => 0.0066814710,
                                                                             0.0066814710);

final_score_66_c505 := map(
    (nf_seg_fraudpoint_3_0 in ['2: Synth ID', '3: Derog'])                                                      => -0.0342068756,
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) => final_score_66_c506,
    nf_seg_fraudpoint_3_0 = ''                                                                                => -0.0067133751,
                                                                                                                   -0.0067133751);

final_score_66_c508 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 0.5 => -0.0250647502,
    r_e57_br_source_count_d > 0.5                                     => 0.0922750229,
    r_e57_br_source_count_d = NULL                                    => 0.0498379113,
                                                                         0.0498379113);

final_score_66 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 5.5 => final_score_66_c505,
    r_wealth_index_d > 5.5                              => final_score_66_c508,
    r_wealth_index_d = NULL                             => -0.0434363766,
                                                           -0.0055110716);

final_score_67_c512 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 120.45 => 0.0073081319,
    r_a49_curr_avm_chg_1yr_pct_i > 120.45                                          => 0.0521910334,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => -0.0011275205,
                                                                                      0.0062680971);

final_score_67_c513 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 0.5 => 0.1703693990,
    k_inq_adls_per_phone_i > 0.5                                    => 0.0093908563,
    k_inq_adls_per_phone_i = NULL                                   => 0.0905292347,
                                                                       0.0905292347);

final_score_67_c511 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => final_score_67_c512,
    f_srchunvrfdaddrcount_i > 0.5                                     => final_score_67_c513,
    f_srchunvrfdaddrcount_i = NULL                                    => 0.0088059599,
                                                                         0.0088059599);

final_score_67_c510 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i <= 0.5 => final_score_67_c511,
    r_p85_phn_disconnected_i > 0.5                                      => 0.0922796446,
    r_p85_phn_disconnected_i = NULL                                     => 0.0109493500,
                                                                           0.0109493500);

final_score_67 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => final_score_67_c510,
    f_hh_lienholders_i > 0.5                                => -0.0195746313,
    f_hh_lienholders_i = NULL                               => -0.0507570872,
                                                               -0.0062072264);

final_score_68_c517 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 5.5 => 0.0661926884,
    f_rel_homeover200_count_d > 5.5                                       => 0.1635323874,
    f_rel_homeover200_count_d = NULL                                      => 0.1075287250,
                                                                             0.1075287250);

final_score_68_c516 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 62.6 => 0.0364456908,
    r_c12_source_profile_d > 62.6                                    => final_score_68_c517,
    r_c12_source_profile_d = NULL                                    => 0.0666764065,
                                                                        0.0666764065);

final_score_68_c515 := map(
    NULL < r_l70_add_invalid_i AND r_l70_add_invalid_i <= 0.5 => final_score_68_c516,
    r_l70_add_invalid_i > 0.5                                 => -0.0321064096,
    r_l70_add_invalid_i = NULL                                => 0.0411908612,
                                                                 0.0411908612);

final_score_68_c518 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 78.75 => -0.0098941957,
    r_c12_source_profile_d > 78.75                                    => 0.0349329235,
    r_c12_source_profile_d = NULL                                     => -0.0068630093,
                                                                         -0.0068630093);

final_score_68 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 95 => final_score_68_c515,
    r_f01_inp_addr_address_score_d > 95                                            => final_score_68_c518,
    r_f01_inp_addr_address_score_d = NULL                                          => -0.0096394579,
                                                                                      -0.0045032638);

final_score_69_c522 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 2.5 => -0.0151887132,
    f_bus_addr_match_count_d > 2.5                                      => 0.0252765582,
    f_bus_addr_match_count_d = NULL                                     => -0.0092523705,
                                                                           -0.0092523705);

final_score_69_c523 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.0803036994,
    f_phone_ver_experian_d > 0.5                                    => -0.0070984850,
    f_phone_ver_experian_d = NULL                                   => 0.1287292223,
                                                                       0.0296165156);

final_score_69_c521 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 5.5 => final_score_69_c522,
    k_inq_per_ssn_i > 5.5                             => final_score_69_c523,
    k_inq_per_ssn_i = NULL                            => -0.0062392950,
                                                         -0.0062392950);

final_score_69_c520 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 45 => -0.1138665749,
    r_f00_ssn_score_d > 45                               => final_score_69_c521,
    r_f00_ssn_score_d = NULL                             => -0.0072340126,
                                                            -0.0072340126);

final_score_69 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 32.5 => final_score_69_c520,
    f_phones_per_addr_curr_i > 32.5                                      => 0.1529861407,
    f_phones_per_addr_curr_i = NULL                                      => 0.0142259152,
                                                                            -0.0061553227);

final_score_70_c526 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 81.9 => 0.0025091643,
    r_c12_source_profile_d > 81.9                                    => 0.0978800812,
    r_c12_source_profile_d = NULL                                    => 0.0049055052,
                                                                        0.0049055052);

final_score_70_c528 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 338.5 => 0.1429867539,
    f_m_bureau_adl_fs_notu_d > 338.5                                      => 0.0083850521,
    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0972566886,
                                                                             0.0972566886);

final_score_70_c527 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 67 => 0.0281815230,
    r_c12_source_profile_d > 67                                    => final_score_70_c528,
    r_c12_source_profile_d = NULL                                  => 0.0464454651,
                                                                      0.0464454651);

final_score_70_c525 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => final_score_70_c526,
    r_c23_inp_addr_occ_index_d > 2                                        => final_score_70_c527,
    r_c23_inp_addr_occ_index_d = NULL                                     => 0.0122084182,
                                                                             0.0122084182);

final_score_70 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 7.5 => final_score_70_c525,
    f_rel_educationover12_count_d > 7.5                                           => -0.0133450418,
    f_rel_educationover12_count_d = NULL                                          => 0.0120777879,
                                                                                     -0.0035457977);

final_score_71_c532 := map(
    NULL < r_e55_college_ind_d AND r_e55_college_ind_d <= 0.5 => 0.0301089146,
    r_e55_college_ind_d > 0.5                                 => 0.0953155776,
    r_e55_college_ind_d = NULL                                => 0.0427225837,
                                                                 0.0427225837);

final_score_71_c533 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 3.5 => -0.0067792428,
    k_inq_per_ssn_i > 3.5                             => 0.0839930227,
    k_inq_per_ssn_i = NULL                            => 0.0017651759,
                                                         0.0017651759);

final_score_71_c531 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => final_score_71_c532,
    f_hh_lienholders_i > 0.5                                => final_score_71_c533,
    f_hh_lienholders_i = NULL                               => 0.0219098669,
                                                               0.0219098669);

final_score_71_c530 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 0.5 => final_score_71_c531,
    k_inq_adls_per_phone_i > 0.5                                    => -0.0316246209,
    k_inq_adls_per_phone_i = NULL                                   => 0.0053479848,
                                                                       0.0053479848);

final_score_71 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_71_c530,
    r_phn_cell_n > 0.5                          => -0.0192796689,
    r_phn_cell_n = NULL                         => -0.0086680398,
                                                   -0.0086680398);

final_score_72_c538 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 4.5 => 0.0884944875,
    f_rel_under25miles_cnt_d > 4.5                                      => 0.0414664349,
    f_rel_under25miles_cnt_d = NULL                                     => 0.0562972552,
                                                                           0.0562972552);

final_score_72_c537 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 110.5 => 0.0135650997,
    f_prevaddrlenofres_d > 110.5                                  => final_score_72_c538,
    f_prevaddrlenofres_d = NULL                                   => 0.0233015402,
                                                                     0.0233015402);

final_score_72_c536 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 0.5 => -0.1004240800,
    f_phone_ver_insurance_d > 0.5                                     => final_score_72_c537,
    f_phone_ver_insurance_d = NULL                                    => 0.0154353639,
                                                                         0.0154353639);

final_score_72_c535 := map(
    NULL < r_c12_num_nonderogs_d AND r_c12_num_nonderogs_d <= 2.5 => final_score_72_c536,
    r_c12_num_nonderogs_d > 2.5                                   => -0.0108646837,
    r_c12_num_nonderogs_d = NULL                                  => -0.0042910885,
                                                                     -0.0042910885);

final_score_72 := map(
    NULL < r_f00_input_dob_match_level_d AND r_f00_input_dob_match_level_d <= 2.5 => 0.1072418784,
    r_f00_input_dob_match_level_d > 2.5                                           => final_score_72_c535,
    r_f00_input_dob_match_level_d = NULL                                          => -0.0552067947,
                                                                                     -0.0040865784);

final_score_73_c543 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 32.5 => 0.0251936569,
    r_p88_phn_dst_to_inp_add_i > 32.5                                        => 0.0965505498,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => 0.0363267678,
                                                                                0.0342284935);

final_score_73_c542 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 19.5 => final_score_73_c543,
    f_rel_educationover12_count_d > 19.5                                           => -0.0312411572,
    f_rel_educationover12_count_d = NULL                                           => 0.0260688805,
                                                                                      0.0260688805);

final_score_73_c541 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_73_c542,
    f_phone_ver_experian_d > 0.5                                    => 0.0039006516,
    f_phone_ver_experian_d = NULL                                   => 0.0550777759,
                                                                       0.0144018071);

final_score_73_c540 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 5.5 => -0.0180088957,
    f_addrs_per_ssn_i > 5.5                               => final_score_73_c541,
    f_addrs_per_ssn_i = NULL                              => 0.0052240850,
                                                             0.0052240850);

final_score_73 := map(
    NULL < r_d31_mostrec_bk_i AND r_d31_mostrec_bk_i <= 0.5 => final_score_73_c540,
    r_d31_mostrec_bk_i > 0.5                                => -0.0360429766,
    r_d31_mostrec_bk_i = NULL                               => -0.0023169303,
                                                               -0.0060295271);

final_score_74_c546 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 1.5 => -0.0392281457,
    f_rel_homeover500_count_d > 1.5                                       => -0.1124953186,
    f_rel_homeover500_count_d = NULL                                      => -0.0513803499,
                                                                             -0.0513803499);

final_score_74_c548 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 0.5 => 0.0434426228,
    k_inq_adls_per_phone_i > 0.5                                    => -0.0103730533,
    k_inq_adls_per_phone_i = NULL                                   => 0.0285310562,
                                                                       0.0285310562);

final_score_74_c547 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => final_score_74_c548,
    r_phn_pcs_n > 0.5                         => -0.0156243985,
    r_phn_pcs_n = NULL                        => 0.0128740584,
                                                 0.0128740584);

final_score_74_c545 := map(
    NULL < r_i60_inq_retail_recency_d AND r_i60_inq_retail_recency_d <= 18 => final_score_74_c546,
    r_i60_inq_retail_recency_d > 18                                        => final_score_74_c547,
    r_i60_inq_retail_recency_d = NULL                                      => 0.0569264674,
                                                                              0.0085793577);

final_score_74 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_74_c545,
    r_phn_cell_n > 0.5                          => -0.0175004803,
    r_phn_cell_n = NULL                         => -0.0061538417,
                                                   -0.0061538417);

final_score_75_c551 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 2.5 => 0.0382532046,
    f_util_adl_count_n > 2.5                                => 0.1720435686,
    f_util_adl_count_n = NULL                               => 0.0819868290,
                                                               0.0819868290);

final_score_75_c550 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 1.5 => final_score_75_c551,
    f_historical_count_d > 1.5                                  => -0.0119451425,
    f_historical_count_d = NULL                                 => 0.0442689717,
                                                                   0.0442689717);

final_score_75_c553 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 1077 => -0.0148101830,
    r_p88_phn_dst_to_inp_add_i > 1077                                        => 0.0895835687,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => 0.0041353039,
                                                                                -0.0097588649);

final_score_75_c552 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 520.5 => final_score_75_c553,
    r_c13_max_lres_d > 520.5                              => 0.1117757596,
    r_c13_max_lres_d = NULL                               => -0.0090441556,
                                                             -0.0090441556);

final_score_75 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 85 => final_score_75_c550,
    r_f01_inp_addr_address_score_d > 85                                            => final_score_75_c552,
    r_f01_inp_addr_address_score_d = NULL                                          => 0.0166534603,
                                                                                      -0.0065469258);

final_score_76_c557 := map(
    NULL < r_i60_inq_banking_recency_d AND r_i60_inq_banking_recency_d <= 549 => 0.0376989703,
    r_i60_inq_banking_recency_d > 549                                         => 0.1375807239,
    r_i60_inq_banking_recency_d = NULL                                        => 0.0713201011,
                                                                                 0.0713201011);

final_score_76_c558 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 0.5 => 0.0245988811,
    r_p88_phn_dst_to_inp_add_i > 0.5                                        => 0.1623845422,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => 0.0986159975,
                                                                               0.0789390766);

final_score_76_c556 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 274883 => 0.0162873997,
    r_l80_inp_avm_autoval_d > 274883                                     => final_score_76_c557,
    r_l80_inp_avm_autoval_d = NULL                                       => final_score_76_c558,
                                                                            0.0477554147);

final_score_76_c555 := map(
    r_d31_bk_chapter_n != '' and NULL < (integer)r_d31_bk_chapter_n AND (integer)r_d31_bk_chapter_n <= 10 		=> -0.0252694353,
    (integer)r_d31_bk_chapter_n > 10                                						=> -0.0515952902,
    r_d31_bk_chapter_n = ''                              						=> final_score_76_c556,
																																										0.0167675910);

final_score_76 := map(
    NULL < r_i60_inq_mortgage_recency_d AND r_i60_inq_mortgage_recency_d <= 549 => final_score_76_c555,
    r_i60_inq_mortgage_recency_d > 549                                          => -0.0084109013,
    r_i60_inq_mortgage_recency_d = NULL                                         => 0.0417552599,
                                                                                   -0.0039386373);

final_score_77_c561 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 1.5 => 0.0930714981,
    r_c14_addrs_5yr_i > 1.5                               => -0.0482508311,
    r_c14_addrs_5yr_i = NULL                              => 0.0164959629,
                                                             0.0164959629);

final_score_77_c563 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 79 => 0.0665916171,
    f_prevaddrageoldest_d > 79                                   => 0.1465917285,
    f_prevaddrageoldest_d = NULL                                 => 0.0912217230,
                                                                    0.0912217230);

final_score_77_c562 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => 0.0242703061,
    r_c23_inp_addr_occ_index_d > 2                                        => final_score_77_c563,
    r_c23_inp_addr_occ_index_d = NULL                                     => 0.0565147241,
                                                                             0.0565147241);

final_score_77_c560 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 115075.5 => final_score_77_c561,
    r_l80_inp_avm_autoval_d > 115075.5                                     => final_score_77_c562,
    r_l80_inp_avm_autoval_d = NULL                                         => 0.0026253374,
                                                                              0.0217345830);

final_score_77 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => -0.0101002942,
    r_f03_input_add_not_most_rec_i > 0.5                                            => final_score_77_c560,
    r_f03_input_add_not_most_rec_i = NULL                                           => -0.0352904643,
                                                                                       -0.0056933445);

final_score_78_c568 := map(
    NULL < f_crim_rel_under500miles_cnt_i AND f_crim_rel_under500miles_cnt_i <= 1.5 => 0.0369910003,
    f_crim_rel_under500miles_cnt_i > 1.5                                            => 0.1506812437,
    f_crim_rel_under500miles_cnt_i = NULL                                           => 0.0908198502,
                                                                                       0.0908198502);

final_score_78_c567 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 12.5 => final_score_78_c568,
    f_rel_under500miles_cnt_d > 12.5                                       => -0.0037433440,
    f_rel_under500miles_cnt_d = NULL                                       => 0.0460802745,
                                                                              0.0460802745);

final_score_78_c566 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 2.5 => -0.0023315038,
    f_idverrisktype_i > 2.5                               => final_score_78_c567,
    f_idverrisktype_i = NULL                              => 0.0052840161,
                                                             0.0052840161);

final_score_78_c565 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 4.5 => 0.0582661273,
    f_rel_under100miles_cnt_d > 4.5                                       => final_score_78_c566,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0159377163,
                                                                             0.0159377163);

final_score_78 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 1.5 => -0.0050516772,
    f_bus_addr_match_count_d > 1.5                                      => final_score_78_c565,
    f_bus_addr_match_count_d = NULL                                     => -0.0009043592,
                                                                           -0.0009043592);

final_score_79_c571 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 95 => 0.0615745831,
    r_f01_inp_addr_address_score_d > 95                                            => 0.0026534430,
    r_f01_inp_addr_address_score_d = NULL                                          => 0.0061109501,
                                                                                      0.0061109501);

final_score_79_c573 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 5.5 => 0.1047370814,
    f_phones_per_addr_curr_i > 5.5                                      => -0.0234429661,
    f_phones_per_addr_curr_i = NULL                                     => 0.0562188025,
                                                                           0.0562188025);

final_score_79_c572 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 6.5 => 0.0317278999,
    f_rel_homeover200_count_d > 6.5                                       => final_score_79_c573,
    f_rel_homeover200_count_d = NULL                                      => 0.0405212359,
                                                                             0.0405212359);

final_score_79_c570 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 74.85 => final_score_79_c571,
    r_c12_source_profile_d > 74.85                                    => final_score_79_c572,
    r_c12_source_profile_d = NULL                                     => 0.0098317150,
                                                                         0.0098317150);

final_score_79 := map(
    NULL < f_dl_addrs_per_adl_i AND f_dl_addrs_per_adl_i <= 0.5 => final_score_79_c570,
    f_dl_addrs_per_adl_i > 0.5                                  => -0.0185505507,
    f_dl_addrs_per_adl_i = NULL                                 => -0.0131324611,
                                                                   -0.0032364595);

final_score_80_c576 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 16.5 => -0.0118390954,
    f_phones_per_addr_curr_i > 16.5                                      => 0.0636684730,
    f_phones_per_addr_curr_i = NULL                                      => -0.0105879271,
                                                                            -0.0105879271);

final_score_80_c577 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 282.5 => 0.0296923836,
    r_c13_curr_addr_lres_d > 282.5                                    => 0.1126897706,
    r_c13_curr_addr_lres_d = NULL                                     => 0.0435433165,
                                                                         0.0435433165);

final_score_80_c575 := map(
    NULL < f_bus_fname_verd_d AND f_bus_fname_verd_d <= 0.5 => final_score_80_c576,
    f_bus_fname_verd_d > 0.5                                => final_score_80_c577,
    f_bus_fname_verd_d = NULL                               => -0.0082851726,
                                                               -0.0082851726);

final_score_80_c578 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 165.5 => 0.0312842677,
    f_prevaddrlenofres_d > 165.5                                  => 0.1873145412,
    f_prevaddrlenofres_d = NULL                                   => 0.0565463119,
                                                                     0.0565463119);

final_score_80 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => final_score_80_c575,
    f_srchunvrfdaddrcount_i > 0.5                                     => final_score_80_c578,
    f_srchunvrfdaddrcount_i = NULL                                    => 0.0038898891,
                                                                         -0.0060010809);

final_score_81_c583 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 2.5 => 0.0165306873,
    f_srchcomponentrisktype_i > 2.5                                       => 0.1293162808,
    f_srchcomponentrisktype_i = NULL                                      => 0.0201999596,
                                                                             0.0201999596);

final_score_81_c582 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 23508 => 0.0010637045,
    r_a49_curr_avm_chg_1yr_i > 23508                                      => 0.0453598162,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => final_score_81_c583,
                                                                             0.0171337297);

final_score_81_c581 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => -0.0121169392,
    r_i61_inq_collection_recency_d > 549                                            => final_score_81_c582,
    r_i61_inq_collection_recency_d = NULL                                           => -0.0018523544,
                                                                                       -0.0018523544);

final_score_81_c580 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 30.5 => -0.0638759252,
    r_c13_max_lres_d > 30.5                              => final_score_81_c581,
    r_c13_max_lres_d = NULL                              => 0.0349737658,
                                                            -0.0045529386);

final_score_81 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 5.5 => final_score_81_c580,
    k_inq_ssns_per_addr_i > 5.5                                   => 0.1077807485,
    k_inq_ssns_per_addr_i = NULL                                  => -0.0039210467,
                                                                     -0.0039210467);

final_score_82_c586 := map(
    NULL < f_divrisktype_i AND f_divrisktype_i <= 5.5 => -0.0051337058,
    f_divrisktype_i > 5.5                             => 0.0838423911,
    f_divrisktype_i = NULL                            => 0.0127085933,
                                                         -0.0041298024);

final_score_82_c588 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 1.5 => -0.0518674342,
    r_p88_phn_dst_to_inp_add_i > 1.5                                        => 0.0399119907,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => -0.0004593386,
                                                                               -0.0004593386);

final_score_82_c587 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_82_c588,
    f_phone_ver_insurance_d > 3.5                                     => 0.1100151354,
    f_phone_ver_insurance_d = NULL                                    => 0.0353447553,
                                                                         0.0353447553);

final_score_82_c585 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i <= 0.5 => final_score_82_c586,
    r_p85_phn_disconnected_i > 0.5                                      => final_score_82_c587,
    r_p85_phn_disconnected_i = NULL                                     => -0.0031129823,
                                                                           -0.0031129823);

final_score_82 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 4.5 => final_score_82_c585,
    k_inq_lnames_per_addr_i > 4.5                                     => 0.0932879872,
    k_inq_lnames_per_addr_i = NULL                                    => -0.0024326252,
                                                                         -0.0024326252);

final_score_83_c591 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 2.5 => 0.0074427391,
    r_e57_br_source_count_d > 2.5                                     => 0.0720617408,
    r_e57_br_source_count_d = NULL                                    => 0.0100025256,
                                                                         0.0100025256);

final_score_83_c592 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 143.5 => 0.0344692758,
    f_prevaddrageoldest_d > 143.5                                   => 0.1410880476,
    f_prevaddrageoldest_d = NULL                                    => 0.0625592214,
                                                                       0.0625592214);

final_score_83_c590 := map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 7.5 => final_score_83_c591,
    f_rel_homeover150_count_d > 7.5                                       => final_score_83_c592,
    f_rel_homeover150_count_d = NULL                                      => 0.0140633699,
                                                                             0.0140633699);

final_score_83_c593 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 4.5 => -0.0508180390,
    f_addrs_per_ssn_i > 4.5                               => 0.1598737338,
    f_addrs_per_ssn_i = NULL                              => -0.0077035063,
                                                             -0.0077035063);

final_score_83 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 7.5 => final_score_83_c590,
    f_rel_educationover12_count_d > 7.5                                           => -0.0130305746,
    f_rel_educationover12_count_d = NULL                                          => final_score_83_c593,
                                                                                     -0.0032113341);

final_score_84_c597 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 3.5 => -0.0370526654,
    f_addrs_per_ssn_i > 3.5                               => 0.0279264285,
    f_addrs_per_ssn_i = NULL                              => 0.0150637760,
                                                             0.0150637760);

final_score_84_c598 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 3.5 => 0.1447281168,
    r_l79_adls_per_addr_curr_i > 3.5                                        => -0.0013384578,
    r_l79_adls_per_addr_curr_i = NULL                                       => 0.0848033683,
                                                                               0.0848033683);

final_score_84_c596 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 2.5 => final_score_84_c597,
    k_inq_per_phone_i > 2.5                               => final_score_84_c598,
    k_inq_per_phone_i = NULL                              => 0.0197724436,
                                                             0.0197724436);

final_score_84_c595 := map(
    NULL < (real)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d <= 0.5 		=> final_score_84_c596,
    (real)k_nap_phn_verd_d > 0.5                              					=> -0.0049849459,
    (real)k_nap_phn_verd_d = NULL                             					=> 0.0029863401,
																																						0.0029863401);

final_score_84 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 549 => -0.0351435397,
    r_i60_inq_hiriskcred_recency_d > 549                                            => final_score_84_c595,
    r_i60_inq_hiriskcred_recency_d = NULL                                           => 0.0145041878,
                                                                                       -0.0056044089);

final_score_85_c603 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.1445394334,
    f_phone_ver_experian_d > 0.5                                    => -0.0229995065,
    f_phone_ver_experian_d = NULL                                   => 0.0539036135,
                                                                       0.0539036135);

final_score_85_c602 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 75.5 => -0.0026080122,
    r_p88_phn_dst_to_inp_add_i > 75.5                                        => final_score_85_c603,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => -0.0007936560,
                                                                                -0.0001675245);

final_score_85_c601 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 237102 => -0.0141131381,
    r_a46_curr_avm_autoval_d > 237102                                      => -0.0613075162,
    r_a46_curr_avm_autoval_d = NULL                                        => final_score_85_c602,
                                                                              -0.0055092628);

final_score_85_c600 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 112750 => -0.0010470389,
    r_a49_curr_avm_chg_1yr_i > 112750                                      => -0.0487836069,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => final_score_85_c601,
                                                                              -0.0041674385);

final_score_85 := map(
    NULL < k_inq_adls_per_addr_i AND k_inq_adls_per_addr_i <= 5.5 => final_score_85_c600,
    k_inq_adls_per_addr_i > 5.5                                   => 0.0794517040,
    k_inq_adls_per_addr_i = NULL                                  => -0.0037236473,
                                                                     -0.0037236473);

final_score_86_c608 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 3.5 => 0.0313025850,
    r_l79_adls_per_addr_c6_i > 3.5                                      => 0.1030798813,
    r_l79_adls_per_addr_c6_i = NULL                                     => 0.0380846917,
                                                                           0.0380846917);

final_score_86_c607 := map(
    NULL < f_accident_count_i AND f_accident_count_i <= 1.5 => final_score_86_c608,
    f_accident_count_i > 1.5                                => 0.1271165942,
    f_accident_count_i = NULL                               => 0.0449382732,
                                                               0.0449382732);

final_score_86_c606 := map(
    NULL < f_crim_rel_under100miles_cnt_i AND f_crim_rel_under100miles_cnt_i <= 5.5 => final_score_86_c607,
    f_crim_rel_under100miles_cnt_i > 5.5                                            => -0.0537736485,
    f_crim_rel_under100miles_cnt_i = NULL                                           => 0.0315536058,
                                                                                       0.0315536058);

final_score_86_c605 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_86_c606,
    f_phone_ver_experian_d > 0.5                                    => -0.0103585580,
    f_phone_ver_experian_d = NULL                                   => 0.0096490456,
                                                                       0.0083933703);

final_score_86 := map(
    NULL < (real)k_inf_contradictory_i AND (real)k_inf_contradictory_i <= 0.5 			=> -0.0078167012,
    (real)k_inf_contradictory_i > 0.5                                   						=> final_score_86_c605,
    (real)k_inf_contradictory_i = NULL                                  						=> -0.0041674574,
																																												-0.0041674574);

final_score_87_c611 := map(
    NULL < nf_number_non_bureau_sources AND nf_number_non_bureau_sources <= 3.5 => 0.1769546924,
    nf_number_non_bureau_sources > 3.5                                          => 0.0323008466,
    nf_number_non_bureau_sources = NULL                                         => 0.0952418330,
                                                                                   0.0952418330);

final_score_87_c613 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 27.65 => -0.0424931818,
    r_c12_source_profile_d > 27.65                                    => 0.0043061917,
    r_c12_source_profile_d = NULL                                     => -0.0010572332,
                                                                         -0.0010572332);

final_score_87_c612 := map(
    NULL < f_recent_disconnects_i AND f_recent_disconnects_i <= 1.5 => final_score_87_c613,
    f_recent_disconnects_i > 1.5                                    => 0.0866208587,
    f_recent_disconnects_i = NULL                                   => -0.0005706145,
                                                                       -0.0005706145);

final_score_87_c610 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 95 => final_score_87_c611,
    r_f00_ssn_score_d > 95                               => final_score_87_c612,
    r_f00_ssn_score_d = NULL                             => 0.0007892371,
                                                            0.0007892371);

final_score_87 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 45 => -0.0879316340,
    r_f00_ssn_score_d > 45                               => final_score_87_c610,
    r_f00_ssn_score_d = NULL                             => 0.0057881762,
                                                            0.0000231973);

final_score_88_c618 := map(
    NULL < r_c12_source_profile_index_d AND r_c12_source_profile_index_d <= 2.5 => -0.0255520404,
    r_c12_source_profile_index_d > 2.5                                          => 0.0254550991,
    r_c12_source_profile_index_d = NULL                                         => 0.0141433738,
                                                                                   0.0141433738);

final_score_88_c617 := map(
    NULL < f_dl_addrs_per_adl_i AND f_dl_addrs_per_adl_i <= 0.5 => final_score_88_c618,
    f_dl_addrs_per_adl_i > 0.5                                  => -0.0158261201,
    f_dl_addrs_per_adl_i = NULL                                 => 0.0012521885,
                                                                   0.0012521885);

final_score_88_c616 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 5.5 => final_score_88_c617,
    f_srchvelocityrisktype_i > 5.5                                      => -0.0362383042,
    f_srchvelocityrisktype_i = NULL                                     => -0.0081317010,
                                                                           -0.0081317010);

final_score_88_c615 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 2.5 => final_score_88_c616,
    f_srchunvrfdphonecount_i > 2.5                                      => 0.0767244748,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0039501007,
                                                                           -0.0070484661);

final_score_88 := map(
    NULL < f_recent_disconnects_i AND f_recent_disconnects_i <= 1.5 => final_score_88_c615,
    f_recent_disconnects_i > 1.5                                    => 0.1007880210,
    f_recent_disconnects_i = NULL                                   => -0.0063963677,
                                                                       -0.0063963677);

final_score_89_c622 := map(
    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i <= 0.5 => 0.1101380286,
    k_inq_addrs_per_ssn_i > 0.5                                   => 0.0361482987,
    k_inq_addrs_per_ssn_i = NULL                                  => 0.0504032008,
                                                                     0.0504032008);

final_score_89_c621 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 5.5 => -0.0128813024,
    k_inq_per_phone_i > 5.5                               => final_score_89_c622,
    k_inq_per_phone_i = NULL                              => -0.0106867202,
                                                             -0.0106867202);

final_score_89_c623 := map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 1.5 => 0.0466705321,
    f_hh_members_w_derog_i > 1.5                                    => -0.0083478420,
    f_hh_members_w_derog_i = NULL                                   => 0.0183067697,
                                                                       0.0183067697);

final_score_89_c620 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 2.5 => final_score_89_c621,
    f_bus_addr_match_count_d > 2.5                                      => final_score_89_c623,
    f_bus_addr_match_count_d = NULL                                     => -0.0064305640,
                                                                           -0.0064305640);

final_score_89 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 45 => -0.0946568318,
    r_f00_ssn_score_d > 45                               => final_score_89_c620,
    r_f00_ssn_score_d = NULL                             => -0.0069479294,
                                                            -0.0072890372);

final_score_90_c628 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 1.5 => 0.1081493020,
    f_rel_educationover12_count_d > 1.5                                           => 0.0190102821,
    f_rel_educationover12_count_d = NULL                                          => 0.0239910751,
                                                                                     0.0239910751);

final_score_90_c627 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 5.5 => final_score_90_c628,
    f_rel_homeover300_count_d > 5.5                                       => 0.0786118785,
    f_rel_homeover300_count_d = NULL                                      => 0.0332002694,
                                                                             0.0332002694);

final_score_90_c626 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 10.5 => final_score_90_c627,
    f_rel_under100miles_cnt_d > 10.5                                       => -0.0178483108,
    f_rel_under100miles_cnt_d = NULL                                       => 0.0170745124,
                                                                              0.0170745124);

final_score_90_c625 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => final_score_90_c626,
    f_hh_lienholders_i > 0.5                                => -0.0203461996,
    f_hh_lienholders_i = NULL                               => -0.0042090934,
                                                               -0.0042090934);

final_score_90 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 189000 => final_score_90_c625,
    r_a49_curr_avm_chg_1yr_i > 189000                                      => 0.0794696232,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => -0.0034453333,
                                                                              -0.0033070702);

final_score_91_c632 := map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 1.5 => 0.0803297574,
    f_hh_members_w_derog_i > 1.5                                    => -0.0223982307,
    f_hh_members_w_derog_i = NULL                                   => 0.0411793515,
                                                                       0.0411793515);

final_score_91_c631 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 5.5 => -0.0000840826,
    r_wealth_index_d > 5.5                              => final_score_91_c632,
    r_wealth_index_d = NULL                             => 0.0012581376,
                                                           0.0012581376);

final_score_91_c633 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 74236 => 0.0184629776,
    r_a49_curr_avm_chg_1yr_i > 74236                                      => -0.0645466235,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => -0.0087023524,
                                                                             0.0021035271);

final_score_91_c630 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 54.5 => final_score_91_c631,
    r_p88_phn_dst_to_inp_add_i > 54.5                                        => 0.0803114540,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => final_score_91_c633,
                                                                                0.0032701062);

final_score_91 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 38.5 => -0.0254392517,
    f_prevaddrageoldest_d > 38.5                                   => final_score_91_c630,
    f_prevaddrageoldest_d = NULL                                   => 0.0461314412,
                                                                      -0.0061653495);

final_score_92_c638 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => 0.0275797310,
    r_f03_input_add_not_most_rec_i > 0.5                                            => 0.0749023762,
    r_f03_input_add_not_most_rec_i = NULL                                           => 0.0365398928,
                                                                                       0.0365398928);

final_score_92_c637 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 2.5 => -0.0006396653,
    f_phone_ver_insurance_d > 2.5                                     => final_score_92_c638,
    f_phone_ver_insurance_d = NULL                                    => 0.0134770638,
                                                                         0.0134770638);

final_score_92_c636 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_92_c637,
    f_phone_ver_insurance_d > 3.5                                     => -0.0131444958,
    f_phone_ver_insurance_d = NULL                                    => -0.0019467015,
                                                                         -0.0019467015);

final_score_92_c635 := map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 170.5 => -0.0592949980,
    f_mos_liens_unrel_cj_lseen_d > 170.5                                          => final_score_92_c636,
    f_mos_liens_unrel_cj_lseen_d = NULL                                           => 0.0040485902,
                                                                                     -0.0108887259);

final_score_92 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 15.5 => final_score_92_c635,
    k_inq_per_ssn_i > 15.5                             => 0.1119522331,
    k_inq_per_ssn_i = NULL                             => -0.0098635276,
                                                          -0.0098635276);

final_score_93_c640 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.0592198517,
    f_phone_ver_experian_d > 0.5                                    => -0.0112582448,
    f_phone_ver_experian_d = NULL                                   => 0.0194318338,
                                                                       0.0201637367);

final_score_93_c642 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 2.5 => -0.0054600813,
    f_srchcomponentrisktype_i > 2.5                                       => 0.0802882477,
    f_srchcomponentrisktype_i = NULL                                      => -0.0389259270,
                                                                             -0.0030580139);

final_score_93_c643 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.1398156692,
    f_phone_ver_experian_d > 0.5                                    => -0.0086505628,
    f_phone_ver_experian_d = NULL                                   => 0.0672569844,
                                                                       0.0672569844);

final_score_93_c641 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 3.5 => final_score_93_c642,
    k_inq_per_phone_i > 3.5                               => final_score_93_c643,
    k_inq_per_phone_i = NULL                              => 0.0017685767,
                                                             0.0017685767);

final_score_93 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 17.5 => -0.0065057377,
    r_p88_phn_dst_to_inp_add_i > 17.5                                        => final_score_93_c640,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => final_score_93_c641,
                                                                                -0.0027076772);

final_score_94_c647 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => 0.1345051626,
    r_phn_pcs_n > 0.5                         => -0.0227405912,
    r_phn_pcs_n = NULL                        => 0.0733090058,
                                                 0.0733090058);

final_score_94_c646 := map(
    NULL < f_hh_college_attendees_d AND f_hh_college_attendees_d <= 1.5 => 0.0063169012,
    f_hh_college_attendees_d > 1.5                                      => final_score_94_c647,
    f_hh_college_attendees_d = NULL                                     => 0.0096786364,
                                                                           0.0096786364);

final_score_94_c645 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_94_c646,
    r_phn_cell_n > 0.5                          => -0.0148175112,
    r_phn_cell_n = NULL                         => -0.0042722068,
                                                   -0.0042722068);

final_score_94_c648 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 2.5 => 0.0279355554,
    k_inq_lnames_per_addr_i > 2.5                                     => 0.1280407389,
    k_inq_lnames_per_addr_i = NULL                                    => 0.0455427082,
                                                                         0.0455427082);

final_score_94 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 2.5 => final_score_94_c645,
    f_srchcomponentrisktype_i > 2.5                                       => final_score_94_c648,
    f_srchcomponentrisktype_i = NULL                                      => -0.0058029986,
                                                                             -0.0024189562);

final_score_95_c650 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 43.5 => -0.0219705824,
    f_prevaddrageoldest_d > 43.5                                   => 0.0925528254,
    f_prevaddrageoldest_d = NULL                                   => 0.0498451379,
                                                                      0.0498451379);

final_score_95_c652 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.0393753450,
    f_phone_ver_experian_d > 0.5                                    => -0.0282469784,
    f_phone_ver_experian_d = NULL                                   => 0.0053413020,
                                                                       0.0023312838);

final_score_95_c651 := map(
    NULL < (real)k_inf_contradictory_i AND (real)k_inf_contradictory_i <= 0.5 		=> -0.0092133002,
    (real)k_inf_contradictory_i > 0.5                                   					=> final_score_95_c652,
    (real)k_inf_contradictory_i = NULL                                  					=> -0.0067005835,
																																										-0.0067005835);

final_score_95_c653 := map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 1.5 => -0.0371492735,
    r_s66_adlperssn_count_i > 1.5                                     => 0.0784188683,
    r_s66_adlperssn_count_i = NULL                                    => 0.0044759408,
                                                                         0.0044759408);

final_score_95 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 98 => final_score_95_c650,
    r_f00_dob_score_d > 98                               => final_score_95_c651,
    r_f00_dob_score_d = NULL                             => final_score_95_c653,
                                                            -0.0049946528);

final_score_96_c656 := map(
    NULL < f_inq_retail_count24_i AND f_inq_retail_count24_i <= 1.5 => 0.0088832435,
    f_inq_retail_count24_i > 1.5                                    => -0.0883854356,
    f_inq_retail_count24_i = NULL                                   => 0.0251862538,
                                                                       0.0038015921);

final_score_96_c658 := map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 1.5 => 0.0964303865,
    r_s66_adlperssn_count_i > 1.5                                     => 0.0346041008,
    r_s66_adlperssn_count_i = NULL                                    => 0.0633222276,
                                                                         0.0633222276);

final_score_96_c657 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => final_score_96_c658,
    r_phn_pcs_n > 0.5                         => -0.0128637108,
    r_phn_pcs_n = NULL                        => 0.0413567926,
                                                 0.0413567926);

final_score_96_c655 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '3: Derog', '4: Recent Activity', '6: Other']) => final_score_96_c656,
    (nf_seg_fraudpoint_3_0 in ['5: Vuln Vic/Friendly'])                                                            => final_score_96_c657,
    nf_seg_fraudpoint_3_0 = ''                                                                                   => 0.0103799669,
                                                                                                                      0.0103799669);

final_score_96 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_96_c655,
    r_phn_cell_n > 0.5                          => -0.0153497156,
    r_phn_cell_n = NULL                         => -0.0042154726,
                                                   -0.0042154726);

final_score_97_c663 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.0312260615,
    f_phone_ver_experian_d > 0.5                                    => -0.0250307151,
    f_phone_ver_experian_d = NULL                                   => 0.0045259109,
                                                                       -0.0029861620);

final_score_97_c662 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 2.5 => final_score_97_c663,
    f_rel_homeover300_count_d > 2.5                                       => 0.0298840640,
    f_rel_homeover300_count_d = NULL                                      => 0.0075837226,
                                                                             0.0075837226);

final_score_97_c661 := map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d <= 3.5 => -0.0111375445,
    r_c14_addr_stability_v2_d > 3.5                                       => final_score_97_c662,
    r_c14_addr_stability_v2_d = NULL                                      => -0.0002612609,
                                                                             -0.0002612609);

final_score_97_c660 := map(
    NULL < (real)k_inf_phn_verd_d AND (real)k_inf_phn_verd_d <= 0.5 				=> final_score_97_c661,
    (real)k_inf_phn_verd_d > 0.5                              							=> -0.0222843366,
    (real)k_inf_phn_verd_d = NULL                             							=> -0.0097788309,
																																								-0.0097788309);

final_score_97 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 4.5 => final_score_97_c660,
    r_c23_inp_addr_occ_index_d > 4.5                                        => -0.1248985867,
    r_c23_inp_addr_occ_index_d = NULL                                       => 0.0195011913,
                                                                               -0.0105846675);

final_score_98_c668 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 270322.5 => 0.0902691122,
    r_a46_curr_avm_autoval_d > 270322.5                                      => -0.0264484788,
    r_a46_curr_avm_autoval_d = NULL                                          => 0.0647067424,
                                                                                0.0512579194);

final_score_98_c667 := map(
    NULL < f_property_owners_ct_d AND f_property_owners_ct_d <= 2.5 => final_score_98_c668,
    f_property_owners_ct_d > 2.5                                    => 0.1350042029,
    f_property_owners_ct_d = NULL                                   => 0.0711879244,
                                                                       0.0711879244);

final_score_98_c666 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 5.5 => -0.0315238797,
    f_addrs_per_ssn_i > 5.5                               => final_score_98_c667,
    f_addrs_per_ssn_i = NULL                              => 0.0481927444,
                                                             0.0481927444);

final_score_98_c665 := map(
    NULL < f_mos_liens_unrel_cj_fseen_d AND f_mos_liens_unrel_cj_fseen_d <= 673.5 => -0.0739745028,
    f_mos_liens_unrel_cj_fseen_d > 673.5                                          => final_score_98_c666,
    f_mos_liens_unrel_cj_fseen_d = NULL                                           => 0.0239958064,
                                                                                     0.0239958064);

final_score_98 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 380.5 => -0.0034216187,
    r_c21_m_bureau_adl_fs_d > 380.5                                     => final_score_98_c665,
    r_c21_m_bureau_adl_fs_d = NULL                                      => 0.0206575140,
                                                                           -0.0012244663);

final_score_99_c672 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 3.5 => -0.0029893574,
    r_e57_br_source_count_d > 3.5                                     => 0.0776684022,
    r_e57_br_source_count_d = NULL                                    => -0.0005088438,
                                                                         -0.0005088438);

final_score_99_c671 := map(
    NULL < f_prevaddrstatus_i AND f_prevaddrstatus_i <= 2.5 => -0.0296623771,
    f_prevaddrstatus_i > 2.5                                => 0.0104285968,
    f_prevaddrstatus_i = NULL                               => final_score_99_c672,
                                                               -0.0077465454);

final_score_99_c670 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 80 => 0.0685568562,
    r_f00_dob_score_d > 80                               => final_score_99_c671,
    r_f00_dob_score_d = NULL                             => -0.0275697204,
                                                            -0.0075040846);

final_score_99_c673 := map(
    NULL < (real)k_nap_fname_verd_d AND (real)k_nap_fname_verd_d <= 0.5 		=> 0.1443321924,
    (real)k_nap_fname_verd_d > 0.5                                					=> 0.0182254444,
    (real)k_nap_fname_verd_d = NULL                               					=> 0.0394754766,
																																								0.0394754766);

final_score_99 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 2.5 => final_score_99_c670,
    f_srchcomponentrisktype_i > 2.5                                       => final_score_99_c673,
    f_srchcomponentrisktype_i = NULL                                      => -0.0106711693,
                                                                             -0.0057311096);

final_score_100_c675 := map(
    NULL < f_property_owners_ct_d AND f_property_owners_ct_d <= 0.5 => -0.0351352576,
    f_property_owners_ct_d > 0.5                                    => 0.0199951537,
    f_property_owners_ct_d = NULL                                   => 0.0103017645,
                                                                       0.0103017645);

final_score_100_c678 := map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i <= 3.5 => 0.0505299390,
    f_rel_criminal_count_i > 3.5                                    => -0.0727061159,
    f_rel_criminal_count_i = NULL                                   => 0.0065170623,
                                                                       0.0065170623);

final_score_100_c677 := map(
    NULL < f_phones_per_addr_c6_i AND f_phones_per_addr_c6_i <= 0.5 => final_score_100_c678,
    f_phones_per_addr_c6_i > 0.5                                    => 0.1183538678,
    f_phones_per_addr_c6_i = NULL                                   => 0.0457501352,
                                                                       0.0457501352);

final_score_100_c676 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 85 => final_score_100_c677,
    r_f01_inp_addr_address_score_d > 85                                            => -0.0052037098,
    r_f01_inp_addr_address_score_d = NULL                                          => 0.0048980051,
                                                                                      -0.0025513455);

final_score_100 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 104.05 => -0.0240756986,
    r_a49_curr_avm_chg_1yr_pct_i > 104.05                                          => final_score_100_c675,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => final_score_100_c676,
                                                                                      -0.0038501018);

final_score_101_c681 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 420 => -0.0009216023,
    f_prevaddrlenofres_d > 420                                  => 0.0747018661,
    f_prevaddrlenofres_d = NULL                                 => -0.0000089927,
                                                                   -0.0000089927);

final_score_101_c682 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 22.5 => 0.0176377055,
    r_p88_phn_dst_to_inp_add_i > 22.5                                        => 0.1122809213,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => 0.0618361322,
                                                                                0.0328570748);

final_score_101_c680 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 6.5 => final_score_101_c681,
    f_rel_homeover200_count_d > 6.5                                       => final_score_101_c682,
    f_rel_homeover200_count_d = NULL                                      => 0.0052100711,
                                                                             0.0052100711);

final_score_101_c683 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 3.5 => -0.0569906382,
    f_addrs_per_ssn_i > 3.5                               => 0.1026292195,
    f_addrs_per_ssn_i = NULL                              => -0.0146425127,
                                                             -0.0146425127);

final_score_101 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 9.5 => final_score_101_c680,
    f_rel_incomeover50_count_d > 9.5                                        => -0.0204418964,
    f_rel_incomeover50_count_d = NULL                                       => final_score_101_c683,
                                                                               -0.0034021172);

final_score_102_c686 := map(
    NULL < f_adl_util_misc_n AND f_adl_util_misc_n <= 0.5 => 0.0144734142,
    f_adl_util_misc_n > 0.5                               => -0.0264064621,
    f_adl_util_misc_n = NULL                              => 0.0003638364,
                                                             0.0003638364);

final_score_102_c688 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 2.5 => 0.0463331545,
    k_inq_ssns_per_addr_i > 2.5                                   => 0.1180641858,
    k_inq_ssns_per_addr_i = NULL                                  => 0.0529869380,
                                                                     0.0529869380);

final_score_102_c687 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 1.5 => final_score_102_c688,
    f_historical_count_d > 1.5                                  => 0.0051469898,
    f_historical_count_d = NULL                                 => 0.0303299081,
                                                                   0.0303299081);

final_score_102_c685 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => final_score_102_c686,
    r_c23_inp_addr_occ_index_d > 2                                        => final_score_102_c687,
    r_c23_inp_addr_occ_index_d = NULL                                     => 0.0062271683,
                                                                             0.0062271683);

final_score_102 := map(
    NULL < r_d34_unrel_liens_ct_i AND r_d34_unrel_liens_ct_i <= 0.5 => final_score_102_c685,
    r_d34_unrel_liens_ct_i > 0.5                                    => -0.0256589283,
    r_d34_unrel_liens_ct_i = NULL                                   => -0.0102475663,
                                                                       -0.0037159843);

final_score_103_c693 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 0.5 => 0.0448815938,
    f_rel_homeover300_count_d > 0.5                                       => 0.1357611259,
    f_rel_homeover300_count_d = NULL                                      => 0.1003289274,
                                                                             0.1003289274);

final_score_103_c692 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '3: Derog', '4: Recent Activity', '6: Other']) => 0.0240219978,
    (nf_seg_fraudpoint_3_0 in ['2: Synth ID', '5: Vuln Vic/Friendly'])                              => final_score_103_c693,
    nf_seg_fraudpoint_3_0 = ''                                                                    => 0.0428425762,
                                                                                                       0.0428425762);

final_score_103_c691 := map(
    NULL < r_c12_num_nonderogs_d AND r_c12_num_nonderogs_d <= 2.5 => final_score_103_c692,
    r_c12_num_nonderogs_d > 2.5                                   => 0.0094019745,
    r_c12_num_nonderogs_d = NULL                                  => 0.0182119636,
                                                                     0.0182119636);

final_score_103_c690 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 27.65 => -0.0280783355,
    r_c12_source_profile_d > 27.65                                    => final_score_103_c691,
    r_c12_source_profile_d = NULL                                     => 0.0073990042,
                                                                         0.0073990042);

final_score_103 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => -0.0151409051,
    r_i61_inq_collection_recency_d > 549                                            => final_score_103_c690,
    r_i61_inq_collection_recency_d = NULL                                           => -0.0021733375,
                                                                                       -0.0066257734);

final_score_104_c697 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => -0.0011143196,
    r_f03_input_add_not_most_rec_i > 0.5                                            => 0.0310172638,
    r_f03_input_add_not_most_rec_i = NULL                                           => 0.0035265399,
                                                                                       0.0035265399);

final_score_104_c696 := map(
    NULL < r_l77_add_po_box_i AND r_l77_add_po_box_i <= 0.5 => final_score_104_c697,
    r_l77_add_po_box_i > 0.5                                => -0.1001559601,
    r_l77_add_po_box_i = NULL                               => 0.0022489490,
                                                               0.0022489490);

final_score_104_c695 := map(
    NULL < r_d34_unrel_liens_ct_i AND r_d34_unrel_liens_ct_i <= 1.5 => final_score_104_c696,
    r_d34_unrel_liens_ct_i > 1.5                                    => -0.0443979994,
    r_d34_unrel_liens_ct_i = NULL                                   => -0.0064644366,
                                                                       -0.0064644366);

final_score_104_c698 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 3.5 => -0.0153408451,
    f_addrs_per_ssn_i > 3.5                               => 0.1180364476,
    f_addrs_per_ssn_i = NULL                              => 0.0207767970,
                                                             0.0207767970);

final_score_104 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 0.5 => 0.0765724014,
    f_rel_under100miles_cnt_d > 0.5                                       => final_score_104_c695,
    f_rel_under100miles_cnt_d = NULL                                      => final_score_104_c698,
                                                                             -0.0045472414);

final_score_105_c701 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 0.5 => 0.0343121009,
    k_inq_adls_per_phone_i > 0.5                                    => -0.0314567668,
    k_inq_adls_per_phone_i = NULL                                   => 0.0164507958,
                                                                       0.0164507958);

final_score_105_c700 := map(
    NULL < f_hh_collections_ct_i AND f_hh_collections_ct_i <= 0.5 => final_score_105_c701,
    f_hh_collections_ct_i > 0.5                                   => -0.0147935141,
    f_hh_collections_ct_i = NULL                                  => -0.0087295995,
                                                                     -0.0087295995);

final_score_105_c703 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 1.5 => 0.0071789975,
    f_srchcomponentrisktype_i > 1.5                                       => 0.0804537344,
    f_srchcomponentrisktype_i = NULL                                      => 0.0136188200,
                                                                             0.0136188200);

final_score_105_c702 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 2.5 => 0.0467797355,
    f_addrchangeecontrajindex_d > 2.5                                         => 0.1541239962,
    f_addrchangeecontrajindex_d = NULL                                        => final_score_105_c703,
                                                                                 0.0219264430);

final_score_105 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => final_score_105_c700,
    r_f03_input_add_not_most_rec_i > 0.5                                            => final_score_105_c702,
    r_f03_input_add_not_most_rec_i = NULL                                           => 0.0127747392,
                                                                                       -0.0039947643);

final_score_106_c706 := map(
    NULL < k_inq_adls_per_addr_i AND k_inq_adls_per_addr_i <= 0.5 => 0.0101649461,
    k_inq_adls_per_addr_i > 0.5                                   => -0.0201454876,
    k_inq_adls_per_addr_i = NULL                                  => -0.0070480626,
                                                                     -0.0070480626);

final_score_106_c705 := map(
    NULL < r_a43_watercraft_cnt_d AND r_a43_watercraft_cnt_d <= 1.5 => final_score_106_c706,
    r_a43_watercraft_cnt_d > 1.5                                    => 0.1009148999,
    r_a43_watercraft_cnt_d = NULL                                   => -0.0028464174,
                                                                       -0.0058562988);

final_score_106_c708 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 2.5 => 0.0112513959,
    k_inq_ssns_per_addr_i > 2.5                                   => 0.1205132994,
    k_inq_ssns_per_addr_i = NULL                                  => 0.0340283872,
                                                                     0.0340283872);

final_score_106_c707 := map(
    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i <= 0.5 => 0.1391423589,
    k_inq_addrs_per_ssn_i > 0.5                                   => final_score_106_c708,
    k_inq_addrs_per_ssn_i = NULL                                  => 0.0461974614,
                                                                     0.0461974614);

final_score_106 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 6.5 => final_score_106_c705,
    k_inq_per_ssn_i > 6.5                             => final_score_106_c707,
    k_inq_per_ssn_i = NULL                            => -0.0028197141,
                                                         -0.0028197141);

final_score_107_c711 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 0.5 => 0.1353799865,
    f_assocsuspicousidcount_i > 0.5                                       => 0.0288036005,
    f_assocsuspicousidcount_i = NULL                                      => 0.0561308790,
                                                                             0.0561308790);

final_score_107_c713 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 5.5 => 0.0026743218,
    f_addrchangeecontrajindex_d > 5.5                                         => 0.0454028930,
    f_addrchangeecontrajindex_d = NULL                                        => 0.0171972351,
                                                                                 0.0171972351);

final_score_107_c712 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 5.5 => 0.0020043681,
    r_wealth_index_d > 5.5                              => final_score_107_c713,
    r_wealth_index_d = NULL                             => 0.0024840511,
                                                           0.0024840511);

final_score_107_c710 := map(
    NULL < r_f00_input_dob_match_level_d AND r_f00_input_dob_match_level_d <= 7.5 => final_score_107_c711,
    r_f00_input_dob_match_level_d > 7.5                                           => final_score_107_c712,
    r_f00_input_dob_match_level_d = NULL                                          => 0.0042270888,
                                                                                     0.0042270888);

final_score_107 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 5.5 => -0.0241987003,
    f_addrs_per_ssn_i > 5.5                               => final_score_107_c710,
    f_addrs_per_ssn_i = NULL                              => -0.0023805344,
                                                             -0.0023805344);

final_score_108_c718 := map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i <= 3.5 => 0.0968235315,
    f_rel_criminal_count_i > 3.5                                    => 0.0088928799,
    f_rel_criminal_count_i = NULL                                   => 0.0625172546,
                                                                       0.0625172546);

final_score_108_c717 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 360.5 => final_score_108_c718,
    f_m_bureau_adl_fs_notu_d > 360.5                                      => -0.0636747805,
    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0481195056,
                                                                             0.0481195056);

final_score_108_c716 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 0.5 => -0.0067675145,
    f_rel_homeover300_count_d > 0.5                                       => final_score_108_c717,
    f_rel_homeover300_count_d = NULL                                      => 0.0233546439,
                                                                             0.0233546439);

final_score_108_c715 := map(
    NULL < (real)k_nap_lname_verd_d AND (real)k_nap_lname_verd_d <= 0.5 		=> final_score_108_c716,
    (real)k_nap_lname_verd_d > 0.5                                					=> -0.0065160013,
    (real)k_nap_lname_verd_d = NULL                               					=> -0.0037454953,
																																								-0.0037454953);

final_score_108 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 0.5 => -0.0795962541,
    f_phone_ver_insurance_d > 0.5                                     => final_score_108_c715,
    f_phone_ver_insurance_d = NULL                                    => 0.0112090573,
                                                                         -0.0053594996);

final_score_109_c723 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 3.5 => 0.0141731376,
    r_wealth_index_d > 3.5                              => 0.0969697049,
    r_wealth_index_d = NULL                             => 0.0666515501,
                                                           0.0666515501);

final_score_109_c722 := map(
    NULL < r_i60_inq_retail_recency_d AND r_i60_inq_retail_recency_d <= 61.5 => -0.0635182936,
    r_i60_inq_retail_recency_d > 61.5                                        => final_score_109_c723,
    r_i60_inq_retail_recency_d = NULL                                        => 0.0496728748,
                                                                                0.0496728748);

final_score_109_c721 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 85.5 => 0.0044953485,
    f_prevaddrlenofres_d > 85.5                                  => final_score_109_c722,
    f_prevaddrlenofres_d = NULL                                  => 0.0208059789,
                                                                    0.0208059789);

final_score_109_c720 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 3.5 => final_score_109_c721,
    f_rel_under500miles_cnt_d > 3.5                                       => -0.0087485569,
    f_rel_under500miles_cnt_d = NULL                                      => -0.0052341389,
                                                                             -0.0052341389);

final_score_109 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 12.5 => final_score_109_c720,
    f_rel_homeover500_count_d > 12.5                                       => 0.0918804398,
    f_rel_homeover500_count_d = NULL                                       => -0.0171293141,
                                                                              -0.0048323179);

final_score_110_c725 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 133599 => 0.0013079114,
    r_a49_curr_avm_chg_1yr_i > 133599                                      => -0.0698626834,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => 0.0004106269,
                                                                              0.0004106269);

final_score_110_c727 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => -0.0166291369,
    r_f03_input_add_not_most_rec_i > 0.5                                            => 0.0904456009,
    r_f03_input_add_not_most_rec_i = NULL                                           => -0.0145304186,
                                                                                       -0.0145304186);

final_score_110_c728 := map(
    NULL < f_srchphonesrchcountmo_i AND f_srchphonesrchcountmo_i <= 0.5 => -0.0066532735,
    f_srchphonesrchcountmo_i > 0.5                                      => 0.1280546413,
    f_srchphonesrchcountmo_i = NULL                                     => 0.0178222924,
                                                                           0.0039772394);

final_score_110_c726 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 5.5 => final_score_110_c727,
    f_addrchangeecontrajindex_d > 5.5                                         => 0.0640820125,
    f_addrchangeecontrajindex_d = NULL                                        => final_score_110_c728,
                                                                                 -0.0097129545);

final_score_110 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 187015.5 => final_score_110_c725,
    r_a49_curr_avm_chg_1yr_i > 187015.5                                      => 0.0850574008,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => final_score_110_c726,
                                                                                -0.0046527025);

final_score_111_c732 := map(
    NULL < f_hh_collections_ct_i AND f_hh_collections_ct_i <= 0.5 => 0.0616465519,
    f_hh_collections_ct_i > 0.5                                   => 0.0206257682,
    f_hh_collections_ct_i = NULL                                  => 0.0273137902,
                                                                     0.0273137902);

final_score_111_c731 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 85.5 => -0.0103092145,
    f_prevaddrageoldest_d > 85.5                                   => final_score_111_c732,
    f_prevaddrageoldest_d = NULL                                   => 0.0099540229,
                                                                      0.0099540229);

final_score_111_c730 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 100.95 => -0.0276783299,
    r_a49_curr_avm_chg_1yr_pct_i > 100.95                                          => final_score_111_c731,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => -0.0029907230,
                                                                                      -0.0029907230);

final_score_111_c733 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 9.5 => -0.1082491079,
    f_addrs_per_ssn_i > 9.5                               => 0.0077994863,
    f_addrs_per_ssn_i = NULL                              => -0.0510657427,
                                                             -0.0510657427);

final_score_111 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 112250 => final_score_111_c730,
    r_a49_curr_avm_chg_1yr_i > 112250                                      => final_score_111_c733,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => 0.0024573297,
                                                                              -0.0007750728);

final_score_112_c737 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 1.5 => 0.1562226450,
    r_c18_invalid_addrs_per_adl_i > 1.5                                           => 0.0465160375,
    r_c18_invalid_addrs_per_adl_i = NULL                                          => 0.0984348023,
                                                                                     0.0984348023);

final_score_112_c736 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_112_c737,
    f_phone_ver_experian_d > 0.5                                    => 0.0252968883,
    f_phone_ver_experian_d = NULL                                   => 0.0669186988,
                                                                       0.0669186988);

final_score_112_c735 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_112_c736,
    f_phone_ver_insurance_d > 3.5                                     => -0.0072787433,
    f_phone_ver_insurance_d = NULL                                    => 0.0211664655,
                                                                         0.0211664655);

final_score_112_c738 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 533 => -0.0038078467,
    r_c13_max_lres_d > 533                              => 0.0797754793,
    r_c13_max_lres_d = NULL                             => -0.0033066551,
                                                           -0.0033066551);

final_score_112 := map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d <= 29.5 => final_score_112_c735,
    f_mos_acc_lseen_d > 29.5                               => final_score_112_c738,
    f_mos_acc_lseen_d = NULL                               => 0.0278331841,
                                                              -0.0012751036);

final_score_113_c742 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 5.5 => -0.0051539893,
    r_e57_br_source_count_d > 5.5                                     => 0.0892837366,
    r_e57_br_source_count_d = NULL                                    => -0.0042844175,
                                                                         -0.0042844175);

final_score_113_c743 := map(
    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i <= 0.5 => 0.1352197084,
    k_inq_addrs_per_ssn_i > 0.5                                   => 0.0184158268,
    k_inq_addrs_per_ssn_i = NULL                                  => 0.0327904254,
                                                                     0.0327904254);

final_score_113_c741 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 5.5 => final_score_113_c742,
    k_inq_per_ssn_i > 5.5                             => final_score_113_c743,
    k_inq_per_ssn_i = NULL                            => -0.0014135600,
                                                         -0.0014135600);

final_score_113_c740 := map(
    NULL < f_mos_liens_rel_ot_fseen_d AND f_mos_liens_rel_ot_fseen_d <= 229.5 => final_score_113_c741,
    f_mos_liens_rel_ot_fseen_d > 229.5                                        => 0.1299289284,
    f_mos_liens_rel_ot_fseen_d = NULL                                         => -0.0004998855,
                                                                                 -0.0004998855);

final_score_113 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 471.5 => final_score_113_c740,
    r_c13_curr_addr_lres_d > 471.5                                    => -0.0705859108,
    r_c13_curr_addr_lres_d = NULL                                     => -0.0023207392,
                                                                         -0.0009605463);

final_score_114_c746 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 3.5 => 0.0109352935,
    r_c23_inp_addr_occ_index_d > 3.5                                        => -0.0865255431,
    r_c23_inp_addr_occ_index_d = NULL                                       => 0.0078867379,
                                                                               0.0078867379);

final_score_114_c747 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 3.5 => 0.0280845524,
    f_rel_homeover300_count_d > 3.5                                       => 0.0938316069,
    f_rel_homeover300_count_d = NULL                                      => 0.0413706693,
                                                                             0.0413706693);

final_score_114_c745 := map(
    NULL < (real)k_inf_contradictory_i AND (real)k_inf_contradictory_i <= 0.5 		=> final_score_114_c746,
    (real)k_inf_contradictory_i > 0.5                                   					=> final_score_114_c747,
    (real)k_inf_contradictory_i = NULL                                  					=> 0.0154761002,
																																											0.0154761002);

final_score_114_c748 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 22.5 => -0.0384799852,
    r_c21_m_bureau_adl_fs_d > 22.5                                     => 0.1521450028,
    r_c21_m_bureau_adl_fs_d = NULL                                     => 0.0014750235,
                                                                          0.0154029577);

final_score_114 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 7.5 => final_score_114_c745,
    f_rel_under500miles_cnt_d > 7.5                                       => -0.0067734039,
    f_rel_under500miles_cnt_d = NULL                                      => final_score_114_c748,
                                                                             0.0018519855);

final_score_115_c753 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 0.5 => 0.0081339784,
    f_rel_homeover300_count_d > 0.5                                       => 0.0478423437,
    f_rel_homeover300_count_d = NULL                                      => 0.0245243370,
                                                                             0.0245243370);

final_score_115_c752 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 2.5 => final_score_115_c753,
    f_rel_incomeover75_count_d > 2.5                                        => -0.0047779937,
    f_rel_incomeover75_count_d = NULL                                       => 0.0210970666,
                                                                               0.0111393778);

final_score_115_c751 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 0.5 => -0.0951090072,
    f_phone_ver_insurance_d > 0.5                                     => final_score_115_c752,
    f_phone_ver_insurance_d = NULL                                    => 0.0077976444,
                                                                         0.0077976444);

final_score_115_c750 := map(
    NULL < f_dl_addrs_per_adl_i AND f_dl_addrs_per_adl_i <= 0.5 => final_score_115_c751,
    f_dl_addrs_per_adl_i > 0.5                                  => -0.0184970210,
    f_dl_addrs_per_adl_i = NULL                                 => -0.0060849955,
                                                                   -0.0040574654);

final_score_115 := map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i <= 0.5 => final_score_115_c750,
    r_p85_phn_not_issued_i > 0.5                                    => 0.0773061009,
    r_p85_phn_not_issued_i = NULL                                   => -0.0035481878,
                                                                       -0.0035481878);

final_score_116_c756 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 4.5 => 0.0828812040,
    f_idverrisktype_i > 4.5                               => -0.0402594424,
    f_idverrisktype_i = NULL                              => 0.0672153822,
                                                             0.0672153822);

final_score_116_c758 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 2.5 => -0.0038469031,
    f_phones_per_addr_curr_i > 2.5                                      => 0.1067237894,
    f_phones_per_addr_curr_i = NULL                                     => 0.0531482992,
                                                                           0.0531482992);

final_score_116_c757 := map(
    NULL < f_rel_count_i AND f_rel_count_i <= 19.5 => final_score_116_c758,
    f_rel_count_i > 19.5                           => -0.0902734588,
    f_rel_count_i = NULL                           => 0.0232493008,
                                                      0.0232493008);

final_score_116_c755 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 2.5 => -0.0078459526,
    f_addrchangeecontrajindex_d > 2.5                                         => final_score_116_c756,
    f_addrchangeecontrajindex_d = NULL                                        => final_score_116_c757,
                                                                                 0.0201389760);

final_score_116 := map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i <= 0.5 => -0.0055335075,
    r_l70_add_standardized_i > 0.5                                      => final_score_116_c755,
    r_l70_add_standardized_i = NULL                                     => -0.0008164850,
                                                                           -0.0008164850);

final_score_117_c763 := map(
    NULL < f_dl_addrs_per_adl_i AND f_dl_addrs_per_adl_i <= 0.5 => 0.0507887735,
    f_dl_addrs_per_adl_i > 0.5                                  => -0.0171397492,
    f_dl_addrs_per_adl_i = NULL                                 => 0.0196103610,
                                                                   0.0196103610);

final_score_117_c762 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => -0.0101108045,
    r_c23_inp_addr_occ_index_d > 2                                        => final_score_117_c763,
    r_c23_inp_addr_occ_index_d = NULL                                     => -0.0030000874,
                                                                             -0.0030000874);

final_score_117_c761 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 146681 => -0.0049017345,
    r_a49_curr_avm_chg_1yr_i > 146681                                      => -0.0578373073,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => final_score_117_c762,
                                                                              -0.0043625273);

final_score_117_c760 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 26.5 => final_score_117_c761,
    f_phones_per_addr_curr_i > 26.5                                      => 0.0867142133,
    f_phones_per_addr_curr_i = NULL                                      => 0.0087923262,
                                                                            -0.0035787148);

final_score_117 := map(
    NULL < f_recent_disconnects_i AND f_recent_disconnects_i <= 1.5 => final_score_117_c760,
    f_recent_disconnects_i > 1.5                                    => 0.1056387662,
    f_recent_disconnects_i = NULL                                   => -0.0029588193,
                                                                       -0.0029588193);

final_score_118_c768 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 501.5 => -0.0054841038,
    r_c10_m_hdr_fs_d > 501.5                              => 0.0570619748,
    r_c10_m_hdr_fs_d = NULL                               => -0.0048149103,
                                                             -0.0048149103);

final_score_118_c767 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 4.5 => final_score_118_c768,
    k_inq_ssns_per_addr_i > 4.5                                   => 0.0506110432,
    k_inq_ssns_per_addr_i = NULL                                  => -0.0042407289,
                                                                     -0.0042407289);

final_score_118_c766 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 0.5 => 0.0811182506,
    f_rel_under100miles_cnt_d > 0.5                                       => final_score_118_c767,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0276839653,
                                                                             -0.0028169324);

final_score_118_c765 := map(
    NULL < r_s65_ssn_problem_i AND r_s65_ssn_problem_i <= 0.5 => final_score_118_c766,
    r_s65_ssn_problem_i > 0.5                                 => -0.0693533292,
    r_s65_ssn_problem_i = NULL                                => -0.0050157392,
                                                                 -0.0050157392);

final_score_118 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 520 => final_score_118_c765,
    r_c13_max_lres_d > 520                              => 0.0647825455,
    r_c13_max_lres_d = NULL                             => -0.0062305027,
                                                           -0.0045873925);

final_score_119_c773 := map(
    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i <= 0.5 => 0.0017296431,
    k_inq_addrs_per_ssn_i > 0.5                                   => 0.0860317027,
    k_inq_addrs_per_ssn_i = NULL                                  => 0.0318725307,
                                                                     0.0318725307);

final_score_119_c772 := map(
    NULL < f_assocrisktype_i AND f_assocrisktype_i <= 3.5 => final_score_119_c773,
    f_assocrisktype_i > 3.5                               => 0.1511929471,
    f_assocrisktype_i = NULL                              => 0.0615723723,
                                                             0.0615723723);

final_score_119_c771 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_119_c772,
    f_phone_ver_experian_d > 0.5                                    => -0.0237610856,
    f_phone_ver_experian_d = NULL                                   => 0.0265384301,
                                                                       0.0265384301);

final_score_119_c770 := map(
    NULL < (real)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d <= 0.5 	=> final_score_119_c771,
    (real)k_nap_phn_verd_d > 0.5                              				=> 0.0003012702,
    (real)k_nap_phn_verd_d = NULL                             				=> 0.0077766621,
																																					0.0077766621);

final_score_119 := map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d <= 144.5 => final_score_119_c770,
    f_mos_acc_lseen_d > 144.5                               => -0.0084316081,
    f_mos_acc_lseen_d = NULL                                => -0.0351884115,
                                                               -0.0060906922);

final_score_120_c777 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 4.5 => 0.1304267216,
    r_d32_mos_since_crim_ls_d > 4.5                                       => 0.0014032043,
    r_d32_mos_since_crim_ls_d = NULL                                      => 0.0027330472,
                                                                             0.0027330472);

final_score_120_c776 := map(
    NULL < f_inq_retail_count24_i AND f_inq_retail_count24_i <= 4.5 => final_score_120_c777,
    f_inq_retail_count24_i > 4.5                                    => -0.1086612476,
    f_inq_retail_count24_i = NULL                                   => 0.0017122659,
                                                                       0.0017122659);

final_score_120_c778 := map(
    NULL < nf_number_non_bureau_sources AND nf_number_non_bureau_sources <= 2.5 => -0.1307026834,
    nf_number_non_bureau_sources > 2.5                                          => -0.0328472775,
    nf_number_non_bureau_sources = NULL                                         => -0.0580930786,
                                                                                   -0.0580930786);

final_score_120_c775 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 7.5 => final_score_120_c776,
    f_assocsuspicousidcount_i > 7.5                                       => final_score_120_c778,
    f_assocsuspicousidcount_i = NULL                                      => -0.0047811311,
                                                                             0.0002499407);

final_score_120 := map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i <= 0.5 => final_score_120_c775,
    r_p85_phn_not_issued_i > 0.5                                    => 0.0755385170,
    r_p85_phn_not_issued_i = NULL                                   => 0.0007012248,
                                                                       0.0007012248);

final_score_121_c782 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 455.5 => 0.0162016051,
    r_c10_m_hdr_fs_d > 455.5                              => -0.0968145637,
    r_c10_m_hdr_fs_d = NULL                               => 0.0135058537,
                                                             0.0135058537);

final_score_121_c781 := map(
    NULL < f_bus_fname_verd_d AND f_bus_fname_verd_d <= 0.5 => final_score_121_c782,
    f_bus_fname_verd_d > 0.5                                => 0.0892197056,
    f_bus_fname_verd_d = NULL                               => 0.0169063239,
                                                               0.0169063239);

final_score_121_c780 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 501 => final_score_121_c781,
    r_c10_m_hdr_fs_d > 501                              => 0.0876792259,
    r_c10_m_hdr_fs_d = NULL                             => 0.0185117300,
                                                           0.0185117300);

final_score_121_c783 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 15.5 => -0.0046334425,
    f_phones_per_addr_curr_i > 15.5                                      => 0.0704419346,
    f_phones_per_addr_curr_i = NULL                                      => 0.0133679208,
                                                                            -0.0024119691);

final_score_121 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 103.95 => -0.0152779438,
    r_a49_curr_avm_chg_1yr_pct_i > 103.95                                          => final_score_121_c780,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => final_score_121_c783,
                                                                                      0.0001678941);

final_score_122_c787 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 10.5 => 0.0104590694,
    r_p88_phn_dst_to_inp_add_i > 10.5                                        => 0.1070077835,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => -0.0320398025,
                                                                                0.0056800923);

final_score_122_c786 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 2.5 => final_score_122_c787,
    f_rel_homeover300_count_d > 2.5                                       => 0.1121039802,
    f_rel_homeover300_count_d = NULL                                      => 0.0193736668,
                                                                             0.0193736668);

final_score_122_c785 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 263.5 => final_score_122_c786,
    r_c13_max_lres_d > 263.5                              => 0.0842731002,
    r_c13_max_lres_d = NULL                               => 0.0283136483,
                                                             0.0283136483);

final_score_122_c788 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 145645.5 => -0.0022987668,
    r_a49_curr_avm_chg_1yr_i > 145645.5                                      => -0.0485929892,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => -0.0060276156,
                                                                                -0.0047181554);

final_score_122 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 2.5 => final_score_122_c785,
    f_rel_educationover12_count_d > 2.5                                           => final_score_122_c788,
    f_rel_educationover12_count_d = NULL                                          => -0.0038662451,
                                                                                     -0.0023420876);

final_score_123_c791 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 50.5 => -0.0011655975,
    f_prevaddrlenofres_d > 50.5                                  => 0.0653924617,
    f_prevaddrlenofres_d = NULL                                  => 0.0423953964,
                                                                    0.0423953964);

final_score_123_c790 := map(
    r_d31_bk_chapter_n != '' and NULL < (integer)r_d31_bk_chapter_n AND (integer)r_d31_bk_chapter_n <= 10 			=> -0.0230274394,
    (integer)r_d31_bk_chapter_n > 10                                							=> -0.0205470876,
    r_d31_bk_chapter_n = ''                              							=> final_score_123_c791,
																																											0.0149649451);

final_score_123_c793 := map(
    NULL < (real)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d <= 0.5 		=> 0.0964604960,
    (real)k_nap_phn_verd_d > 0.5                              					=> -0.0070361104,
    (real)k_nap_phn_verd_d = NULL                             					=> 0.0241414388,
																																						0.0241414388);

final_score_123_c792 := map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d <= 25.5 => final_score_123_c793,
    f_mos_acc_lseen_d > 25.5                               => -0.0099641040,
    f_mos_acc_lseen_d = NULL                               => -0.0078684387,
                                                              -0.0078684387);

final_score_123 := map(
    NULL < r_i60_inq_mortgage_recency_d AND r_i60_inq_mortgage_recency_d <= 549 => final_score_123_c790,
    r_i60_inq_mortgage_recency_d > 549                                          => final_score_123_c792,
    r_i60_inq_mortgage_recency_d = NULL                                         => 0.0161611682,
                                                                                   -0.0040635706);

final_score_124_c796 := map(
    NULL < r_a41_prop_owner_inp_only_d AND r_a41_prop_owner_inp_only_d <= 0.5 => -0.0223204724,
    r_a41_prop_owner_inp_only_d > 0.5                                         => 0.0048821669,
    r_a41_prop_owner_inp_only_d = NULL                                        => -0.0053813067,
                                                                                 -0.0053813067);

final_score_124_c795 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 10.5 => final_score_124_c796,
    f_rel_homeover500_count_d > 10.5                                       => 0.0552408741,
    f_rel_homeover500_count_d = NULL                                       => 0.0012212197,
                                                                              -0.0046707023);

final_score_124_c798 := map(
    NULL < (real)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d <= 0.5 => 0.0943448739,
    (real)k_nap_phn_verd_d > 0.5                              => 0.0388131606,
    (real)k_nap_phn_verd_d = NULL                             => 0.0647625593,
                                                           0.0647625593);

final_score_124_c797 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 2.5 => final_score_124_c798,
    f_srchvelocityrisktype_i > 2.5                                      => 0.0231239954,
    f_srchvelocityrisktype_i = NULL                                     => 0.0298237343,
                                                                           0.0298237343);

final_score_124 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 1.5 => final_score_124_c795,
    f_srchcomponentrisktype_i > 1.5                                       => final_score_124_c797,
    f_srchcomponentrisktype_i = NULL                                      => -0.0378017564,
                                                                             -0.0025464430);

final_score_125_c803 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 385.5 => 0.1234201307,
    f_m_bureau_adl_fs_notu_d > 385.5                                      => -0.0170053942,
    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0548103994,
                                                                             0.0548103994);

final_score_125_c802 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 0.5 => 0.1635899490,
    f_inq_count24_i > 0.5                             => final_score_125_c803,
    f_inq_count24_i = NULL                            => 0.0957189480,
                                                         0.0957189480);

final_score_125_c801 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 78.5 => -0.0466427367,
    f_prevaddrageoldest_d > 78.5                                   => final_score_125_c802,
    f_prevaddrageoldest_d = NULL                                   => 0.0503843532,
                                                                      0.0503843532);

final_score_125_c800 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 2.5 => final_score_125_c801,
    r_l79_adls_per_addr_curr_i > 2.5                                        => -0.0084106746,
    r_l79_adls_per_addr_curr_i = NULL                                       => 0.0166758534,
                                                                               0.0166758534);

final_score_125 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 380.5 => -0.0049793013,
    f_m_bureau_adl_fs_notu_d > 380.5                                      => final_score_125_c800,
    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0151131008,
                                                                             -0.0033879475);

final_score_126_c807 := map(
    NULL < f_hh_collections_ct_i AND f_hh_collections_ct_i <= 0.5 => 0.1025192929,
    f_hh_collections_ct_i > 0.5                                   => 0.0117527214,
    f_hh_collections_ct_i = NULL                                  => 0.0319501086,
                                                                     0.0319501086);

final_score_126_c806 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 4.5 => final_score_126_c807,
    f_addrchangeecontrajindex_d > 4.5                                         => 0.0667101873,
    f_addrchangeecontrajindex_d = NULL                                        => 0.0805781952,
                                                                                 0.0424759199);

final_score_126_c808 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 10.5 => 0.0144603822,
    f_rel_incomeover50_count_d > 10.5                                        => -0.0264228761,
    f_rel_incomeover50_count_d = NULL                                        => 0.0112509832,
                                                                                0.0056336987);

final_score_126_c805 := map(
    NULL < r_i60_inq_mortgage_recency_d AND r_i60_inq_mortgage_recency_d <= 549 => final_score_126_c806,
    r_i60_inq_mortgage_recency_d > 549                                          => final_score_126_c808,
    r_i60_inq_mortgage_recency_d = NULL                                         => 0.0104401876,
                                                                                   0.0104401876);

final_score_126 := map(
    NULL < f_hh_bankruptcies_i AND f_hh_bankruptcies_i <= 0.5 => final_score_126_c805,
    f_hh_bankruptcies_i > 0.5                                 => -0.0202209646,
    f_hh_bankruptcies_i = NULL                                => -0.0560662026,
                                                                 -0.0020316777);

final_score_127_c812 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => -0.1228917819,
    r_phn_cell_n > 0.5                          => -0.0112033674,
    r_phn_cell_n = NULL                         => -0.0639935946,
                                                   -0.0639935946);

final_score_127_c811 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_127_c812,
    f_phone_ver_experian_d > 0.5                                    => -0.0195317347,
    f_phone_ver_experian_d = NULL                                   => -0.0077148759,
                                                                       -0.0299849712);

final_score_127_c810 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 274301.5 => -0.0102549525,
    r_l80_inp_avm_autoval_d > 274301.5                                     => final_score_127_c811,
    r_l80_inp_avm_autoval_d = NULL                                         => -0.0016174005,
                                                                              -0.0091989517);

final_score_127_c813 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 0.5 => 0.1020637448,
    f_rel_under100miles_cnt_d > 0.5                                       => 0.0102895929,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0115184384,
                                                                             0.0115184384);

final_score_127 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 7.5 => final_score_127_c810,
    f_addrs_per_ssn_i > 7.5                               => final_score_127_c813,
    f_addrs_per_ssn_i = NULL                              => 0.0041109495,
                                                             0.0041109495);

final_score_128_c818 := map(
    NULL < f_prevaddrstatus_i AND f_prevaddrstatus_i <= 2.5 => 0.0017373509,
    f_prevaddrstatus_i > 2.5                                => 0.0280133322,
    f_prevaddrstatus_i = NULL                               => 0.0571328538,
                                                               0.0407467668);

final_score_128_c817 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 0.5 => final_score_128_c818,
    k_inq_adls_per_phone_i > 0.5                                    => -0.0161970136,
    k_inq_adls_per_phone_i = NULL                                   => 0.0251512621,
                                                                       0.0251512621);

final_score_128_c816 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => final_score_128_c817,
    r_phn_pcs_n > 0.5                         => -0.0149779809,
    r_phn_pcs_n = NULL                        => 0.0109383433,
                                                 0.0109383433);

final_score_128_c815 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_128_c816,
    r_phn_cell_n > 0.5                          => -0.0104539531,
    r_phn_cell_n = NULL                         => -0.0012890112,
                                                   -0.0012890112);

final_score_128 := map(
    NULL < f_inq_retail_count24_i AND f_inq_retail_count24_i <= 0.5 => final_score_128_c815,
    f_inq_retail_count24_i > 0.5                                    => -0.0364892416,
    f_inq_retail_count24_i = NULL                                   => -0.0318534004,
                                                                       -0.0059909943);

final_score_129_c821 := map(
    NULL < f_rel_count_i AND f_rel_count_i <= 1.5 => 0.0859941568,
    f_rel_count_i > 1.5                           => -0.0184898465,
    f_rel_count_i = NULL                          => -0.0168772419,
                                                     -0.0168772419);

final_score_129_c820 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 284.5 => 0.0099533826,
    f_m_bureau_adl_fs_notu_d > 284.5                                      => final_score_129_c821,
    f_m_bureau_adl_fs_notu_d = NULL                                       => -0.0164039107,
                                                                             -0.0003970364);

final_score_129_c823 := map(
    NULL < r_c12_num_nonderogs_d AND r_c12_num_nonderogs_d <= 4.5 => 0.0810264656,
    r_c12_num_nonderogs_d > 4.5                                   => -0.0360590071,
    r_c12_num_nonderogs_d = NULL                                  => 0.0521027384,
                                                                     0.0521027384);

final_score_129_c822 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 2.5 => 0.0204634080,
    f_rel_homeover300_count_d > 2.5                                       => final_score_129_c823,
    f_rel_homeover300_count_d = NULL                                      => 0.0301156965,
                                                                             0.0301156965);

final_score_129 := map(
    NULL < f_bus_lname_verd_d AND f_bus_lname_verd_d <= 0.5 => final_score_129_c820,
    f_bus_lname_verd_d > 0.5                                => final_score_129_c822,
    f_bus_lname_verd_d = NULL                               => 0.0018520713,
                                                               0.0018520713);

final_score_130_c827 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => 0.0669149968,
    f_phone_ver_insurance_d > 3.5                                     => -0.0473135325,
    f_phone_ver_insurance_d = NULL                                    => 0.0291483828,
                                                                         0.0291483828);

final_score_130_c826 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_130_c827,
    f_phone_ver_experian_d > 0.5                                    => 0.0104672286,
    f_phone_ver_experian_d = NULL                                   => 0.0170074050,
                                                                       0.0170074050);

final_score_130_c825 := map(
    NULL < f_accident_count_i AND f_accident_count_i <= 1.5 => -0.0054849116,
    f_accident_count_i > 1.5                                => final_score_130_c826,
    f_accident_count_i = NULL                               => -0.0277542354,
                                                               -0.0043195860);

final_score_130_c828 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 2.5 => 0.1151082528,
    f_srchvelocityrisktype_i > 2.5                                      => 0.0219615926,
    f_srchvelocityrisktype_i = NULL                                     => 0.0428543014,
                                                                           0.0428543014);

final_score_130 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 5.5 => final_score_130_c825,
    k_inq_per_phone_i > 5.5                               => final_score_130_c828,
    k_inq_per_phone_i = NULL                              => -0.0026905705,
                                                             -0.0026905705);

final_score_131_c832 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= -0.5 => 0.1003938677,
    f_prevaddrageoldest_d > -0.5                                   => -0.0062009440,
    f_prevaddrageoldest_d = NULL                                   => -0.0054934009,
                                                                      -0.0054934009);

final_score_131_c831 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 10.5 => final_score_131_c832,
    k_inq_per_phone_i > 10.5                               => 0.0761725282,
    k_inq_per_phone_i = NULL                               => -0.0049596367,
                                                              -0.0049596367);

final_score_131_c830 := map(
    NULL < r_l77_add_po_box_i AND r_l77_add_po_box_i <= 0.5 => final_score_131_c831,
    r_l77_add_po_box_i > 0.5                                => -0.1178406887,
    r_l77_add_po_box_i = NULL                               => -0.0063647950,
                                                               -0.0063647950);

final_score_131_c833 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 19950 => -0.0070977182,
    r_a49_curr_avm_chg_1yr_i > 19950                                      => 0.1145319897,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => 0.0335049419,
                                                                             0.0318271937);

final_score_131 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 1.5 => final_score_131_c830,
    f_srchcomponentrisktype_i > 1.5                                       => final_score_131_c833,
    f_srchcomponentrisktype_i = NULL                                      => 0.0454770147,
                                                                             -0.0032024322);

final_score_132_c838 := map(
    NULL < f_bus_fname_verd_d AND f_bus_fname_verd_d <= 0.5 => 0.0047929667,
    f_bus_fname_verd_d > 0.5                                => 0.0828313723,
    f_bus_fname_verd_d = NULL                               => 0.0086566424,
                                                               0.0086566424);

final_score_132_c837 := map(
    NULL < f_accident_count_i AND f_accident_count_i <= 2.5 => final_score_132_c838,
    f_accident_count_i > 2.5                                => 0.1327942858,
    f_accident_count_i = NULL                               => 0.0128759360,
                                                               0.0128759360);

final_score_132_c836 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 9331.5 => -0.0198452365,
    r_a49_curr_avm_chg_1yr_i > 9331.5                                      => final_score_132_c837,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => -0.0015069286,
                                                                              -0.0026506533);

final_score_132_c835 := map(
    NULL < r_l71_add_business_i AND r_l71_add_business_i <= 0.5 => final_score_132_c836,
    r_l71_add_business_i > 0.5                                  => -0.0724156702,
    r_l71_add_business_i = NULL                                 => -0.0032463591,
                                                                   -0.0032463591);

final_score_132 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 14.5 => final_score_132_c835,
    k_inq_per_ssn_i > 14.5                             => 0.0737506149,
    k_inq_per_ssn_i = NULL                             => -0.0025461261,
                                                          -0.0025461261);

final_score_133_c842 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 2.5 => 0.0706259065,
    r_c18_invalid_addrs_per_adl_i > 2.5                                           => -0.0381131574,
    r_c18_invalid_addrs_per_adl_i = NULL                                          => 0.0368473888,
                                                                                     0.0368473888);

final_score_133_c841 := map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d <= 3.5 => -0.0734789784,
    r_c14_addr_stability_v2_d > 3.5                                       => final_score_133_c842,
    r_c14_addr_stability_v2_d = NULL                                      => 0.0094864497,
                                                                             0.0094864497);

final_score_133_c843 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 425 => -0.0251010625,
    r_c10_m_hdr_fs_d > 425                              => -0.0972892640,
    r_c10_m_hdr_fs_d = NULL                             => -0.0306479057,
                                                           -0.0306479057);

final_score_133_c840 := map(
    NULL < f_util_add_input_conv_n AND f_util_add_input_conv_n <= 0.5 => final_score_133_c841,
    f_util_add_input_conv_n > 0.5                                     => final_score_133_c843,
    f_util_add_input_conv_n = NULL                                    => -0.0203847903,
                                                                         -0.0203847903);

final_score_133 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 273348 => 0.0026181474,
    r_a46_curr_avm_autoval_d > 273348                                      => final_score_133_c840,
    r_a46_curr_avm_autoval_d = NULL                                        => 0.0032020861,
                                                                              -0.0001184348);

final_score_134_c846 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 4.5 => -0.0361501841,
    f_phones_per_addr_curr_i > 4.5                                      => 0.1552872885,
    f_phones_per_addr_curr_i = NULL                                     => 0.0631730234,
                                                                           0.0631730234);

final_score_134_c848 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => -0.0004627480,
    f_srchunvrfdaddrcount_i > 0.5                                     => 0.0467029876,
    f_srchunvrfdaddrcount_i = NULL                                    => 0.0011998013,
                                                                         0.0011998013);

final_score_134_c847 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 8.5 => final_score_134_c848,
    f_rel_incomeover75_count_d > 8.5                                        => -0.0300144269,
    f_rel_incomeover75_count_d = NULL                                       => 0.0025224946,
                                                                               -0.0016961229);

final_score_134_c845 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 95 => final_score_134_c846,
    r_f00_ssn_score_d > 95                               => final_score_134_c847,
    r_f00_ssn_score_d = NULL                             => -0.0008555847,
                                                            -0.0008555847);

final_score_134 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 45 => -0.0842331030,
    r_f00_ssn_score_d > 45                               => final_score_134_c845,
    r_f00_ssn_score_d = NULL                             => 0.0170400381,
                                                            -0.0013663579);

final_score_135_c851 := map(
    NULL < nf_inq_per_add_nas_479 AND nf_inq_per_add_nas_479 <= 2.5 => 0.0030384692,
    nf_inq_per_add_nas_479 > 2.5                                    => 0.0619559470,
    nf_inq_per_add_nas_479 = NULL                                   => 0.0034038846,
                                                                       0.0034038846);

final_score_135_c852 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 5.5 => -0.1021158949,
    f_rel_under500miles_cnt_d > 5.5                                       => -0.0080349547,
    f_rel_under500miles_cnt_d = NULL                                      => -0.0433153073,
                                                                             -0.0433153073);

final_score_135_c850 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 445.5 => final_score_135_c851,
    r_c13_max_lres_d > 445.5                              => final_score_135_c852,
    r_c13_max_lres_d = NULL                               => 0.0026590487,
                                                             0.0026590487);

final_score_135_c853 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 2.5 => -0.0731423093,
    k_inq_per_ssn_i > 2.5                             => -0.1194608960,
    k_inq_per_ssn_i = NULL                            => -0.0890766949,
                                                         -0.0890766949);

final_score_135 := map(
    NULL < r_i60_inq_retail_count12_i AND r_i60_inq_retail_count12_i <= 1.5 => final_score_135_c850,
    r_i60_inq_retail_count12_i > 1.5                                        => final_score_135_c853,
    r_i60_inq_retail_count12_i = NULL                                       => -0.0034799448,
                                                                               0.0003139983);

final_score_136_c858 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 1.5 => -0.0065324072,
    k_inq_per_ssn_i > 1.5                             => 0.0339160497,
    k_inq_per_ssn_i = NULL                            => 0.0154975559,
                                                         0.0154975559);

final_score_136_c857 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 6.5 => final_score_136_c858,
    f_rel_homeover300_count_d > 6.5                                       => 0.1174370798,
    f_rel_homeover300_count_d = NULL                                      => 0.0380334092,
                                                                             0.0380334092);

final_score_136_c856 := map(
    NULL < f_inq_mortgage_count24_i AND f_inq_mortgage_count24_i <= 0.5 => 0.0022504512,
    f_inq_mortgage_count24_i > 0.5                                      => final_score_136_c857,
    f_inq_mortgage_count24_i = NULL                                     => 0.0036167353,
                                                                           0.0036167353);

final_score_136_c855 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 4.5 => 0.1218529428,
    r_d32_mos_since_crim_ls_d > 4.5                                       => final_score_136_c856,
    r_d32_mos_since_crim_ls_d = NULL                                      => 0.0048359835,
                                                                             0.0048359835);

final_score_136 := map(
    NULL < f_hh_bankruptcies_i AND f_hh_bankruptcies_i <= 1.5 => final_score_136_c855,
    f_hh_bankruptcies_i > 1.5                                 => -0.0328809412,
    f_hh_bankruptcies_i = NULL                                => 0.0306052972,
                                                                 -0.0015360760);

final_score_137_c860 := map(
    NULL < f_srchphonesrchcountwk_i AND f_srchphonesrchcountwk_i <= 0.5 => 0.0084333625,
    f_srchphonesrchcountwk_i > 0.5                                      => 0.1342504133,
    f_srchphonesrchcountwk_i = NULL                                     => 0.0102410328,
                                                                           0.0102410328);

final_score_137_c861 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 385.5 => -0.0108622733,
    f_m_bureau_adl_fs_notu_d > 385.5                                      => -0.0669498026,
    f_m_bureau_adl_fs_notu_d = NULL                                       => -0.0147030498,
                                                                             -0.0147030498);

final_score_137_c863 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 21.5 => 0.1741755606,
    f_rel_educationover12_count_d > 21.5                                           => -0.0082447149,
    f_rel_educationover12_count_d = NULL                                           => 0.0821722912,
                                                                                      0.0821722912);

final_score_137_c862 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 16.5 => -0.0020762063,
    f_rel_homeover200_count_d > 16.5                                       => final_score_137_c863,
    f_rel_homeover200_count_d = NULL                                       => 0.0419575881,
                                                                              0.0017886854);

final_score_137 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 254617.5 => final_score_137_c860,
    r_l80_inp_avm_autoval_d > 254617.5                                     => final_score_137_c861,
    r_l80_inp_avm_autoval_d = NULL                                         => final_score_137_c862,
                                                                              0.0029149562);

final_score_138_c866 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 4.5 => 0.0029280202,
    f_phones_per_addr_curr_i > 4.5                                      => 0.1436933658,
    f_phones_per_addr_curr_i = NULL                                     => 0.0718859425,
                                                                           0.0718859425);

final_score_138_c868 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 381.5 => 0.0119938694,
    r_c21_m_bureau_adl_fs_d > 381.5                                     => 0.0605623418,
    r_c21_m_bureau_adl_fs_d = NULL                                      => 0.0157754873,
                                                                           0.0157754873);

final_score_138_c867 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 6.5 => final_score_138_c868,
    f_rel_under500miles_cnt_d > 6.5                                       => -0.0066814304,
    f_rel_under500miles_cnt_d = NULL                                      => -0.0004261298,
                                                                             -0.0004261298);

final_score_138_c865 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 95 => final_score_138_c866,
    r_f00_ssn_score_d > 95                               => final_score_138_c867,
    r_f00_ssn_score_d = NULL                             => 0.0006551804,
                                                            0.0006551804);

final_score_138 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 3.5 => -0.0239400098,
    f_addrs_per_ssn_i > 3.5                               => final_score_138_c865,
    f_addrs_per_ssn_i = NULL                              => -0.0022941498,
                                                             -0.0022941498);

final_score_139_c872 := map(
    NULL < (real)k_inf_phn_verd_d AND (real)k_inf_phn_verd_d <= 0.5 		=> 0.1302190866,
    (real)k_inf_phn_verd_d > 0.5                              					=> 0.0285033443,
    (real)k_inf_phn_verd_d = NULL                             					=> 0.0830660934,
																																						0.0830660934);

final_score_139_c871 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 303.5 => -0.0282256259,
    f_m_bureau_adl_fs_notu_d > 303.5                                      => final_score_139_c872,
    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0387267630,
                                                                             0.0387267630);

final_score_139_c870 := map(
    NULL < f_bus_fname_verd_d AND f_bus_fname_verd_d <= 0.5 => 0.0038628107,
    f_bus_fname_verd_d > 0.5                                => final_score_139_c871,
    f_bus_fname_verd_d = NULL                               => 0.0051660875,
                                                               0.0051660875);

final_score_139_c873 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 76342 => -0.0115773176,
    r_a49_curr_avm_chg_1yr_i > 76342                                      => -0.0782053951,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => -0.0248874191,
                                                                             -0.0210630929);

final_score_139 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 3.5 => final_score_139_c870,
    f_inq_count24_i > 3.5                             => final_score_139_c873,
    f_inq_count24_i = NULL                            => 0.0192867598,
                                                         -0.0019748397);

final_score_140_c877 := map(
    NULL < f_hh_bankruptcies_i AND f_hh_bankruptcies_i <= 0.5 => 0.0644076923,
    f_hh_bankruptcies_i > 0.5                                 => 0.0126376158,
    f_hh_bankruptcies_i = NULL                                => 0.0406944719,
                                                                 0.0406944719);

final_score_140_c878 := map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i <= 0.5 => -0.0179821828,
    r_l70_add_standardized_i > 0.5                                      => 0.0732474956,
    r_l70_add_standardized_i = NULL                                     => -0.0035283241,
                                                                           -0.0035283241);

final_score_140_c876 := map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 0.5 => final_score_140_c877,
    f_rel_incomeover100_count_d > 0.5                                         => final_score_140_c878,
    f_rel_incomeover100_count_d = NULL                                        => 0.0208877092,
                                                                                 0.0208877092);

final_score_140_c875 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 62.9 => -0.0047971944,
    r_c12_source_profile_d > 62.9                                    => final_score_140_c876,
    r_c12_source_profile_d = NULL                                    => 0.0045827885,
                                                                        0.0045827885);

final_score_140 := map(
    NULL < f_dl_addrs_per_adl_i AND f_dl_addrs_per_adl_i <= 0.5 => final_score_140_c875,
    f_dl_addrs_per_adl_i > 0.5                                  => -0.0180829808,
    f_dl_addrs_per_adl_i = NULL                                 => -0.0097601851,
                                                                   -0.0057202015);

final_score_141_c881 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 269.5 => 0.1839072781,
    r_c10_m_hdr_fs_d > 269.5                              => -0.0000015119,
    r_c10_m_hdr_fs_d = NULL                               => 0.0982308940,
                                                             0.0982308940);

final_score_141_c883 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 2.5 => 0.0658969119,
    f_srchvelocityrisktype_i > 2.5                                      => -0.0186828236,
    f_srchvelocityrisktype_i = NULL                                     => 0.0264644676,
                                                                           0.0264644676);

final_score_141_c882 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 85 => final_score_141_c883,
    r_f01_inp_addr_address_score_d > 85                                            => -0.0032464580,
    r_f01_inp_addr_address_score_d = NULL                                          => -0.0020367697,
                                                                                      -0.0020367697);

final_score_141_c880 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 95 => final_score_141_c881,
    r_f00_ssn_score_d > 95                               => final_score_141_c882,
    r_f00_ssn_score_d = NULL                             => -0.0006823158,
                                                            -0.0006823158);

final_score_141 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 45 => -0.0736127496,
    r_f00_ssn_score_d > 45                               => final_score_141_c880,
    r_f00_ssn_score_d = NULL                             => 0.0252553578,
                                                            -0.0010970298);

final_score_142_c888 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 5.5 => 0.0710488125,
    f_rel_under500miles_cnt_d > 5.5                                       => -0.0253884930,
    f_rel_under500miles_cnt_d = NULL                                      => 0.0078603165,
                                                                             0.0078603165);

final_score_142_c887 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 287500 => 0.0731110344,
    r_a46_curr_avm_autoval_d > 287500                                      => 0.0772218462,
    r_a46_curr_avm_autoval_d = NULL                                        => final_score_142_c888,
                                                                              0.0360897253);

final_score_142_c886 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 237.5 => final_score_142_c887,
    f_prevaddrageoldest_d > 237.5                                   => 0.1132951042,
    f_prevaddrageoldest_d = NULL                                    => 0.0432201584,
                                                                       0.0432201584);

final_score_142_c885 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 0.5 => final_score_142_c886,
    f_historical_count_d > 0.5                                  => 0.0014940514,
    f_historical_count_d = NULL                                 => 0.0172274619,
                                                                   0.0172274619);

final_score_142 := map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i <= 0.5 => -0.0010078891,
    r_l70_add_standardized_i > 0.5                                      => final_score_142_c885,
    r_l70_add_standardized_i = NULL                                     => 0.0022619714,
                                                                           0.0022619714);

final_score_143_c890 := map(
    NULL < f_curraddractivephonelist_d AND f_curraddractivephonelist_d <= 0.5 => 0.0058182802,
    f_curraddractivephonelist_d > 0.5                                         => -0.0016476035,
    f_curraddractivephonelist_d = NULL                                        => 0.0007865646,
                                                                                 0.0007865646);

final_score_143_c892 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 4.5 => 0.0922536556,
    f_addrchangeecontrajindex_d > 4.5                                         => -0.0375100943,
    f_addrchangeecontrajindex_d = NULL                                        => 0.0211090514,
                                                                                 0.0211090514);

final_score_143_c893 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 135.85 => 0.1397093242,
    r_a49_curr_avm_chg_1yr_pct_i > 135.85                                          => 0.0293032897,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => 0.0807252784,
                                                                                      0.0807252784);

final_score_143_c891 := map(
    NULL < r_i60_inq_banking_recency_d AND r_i60_inq_banking_recency_d <= 549 => final_score_143_c892,
    r_i60_inq_banking_recency_d > 549                                         => final_score_143_c893,
    r_i60_inq_banking_recency_d = NULL                                        => 0.0471688392,
                                                                                 0.0471688392);

final_score_143 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 84915 => final_score_143_c890,
    r_a49_curr_avm_chg_1yr_i > 84915                                      => final_score_143_c891,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => -0.0036470186,
                                                                             -0.0003815076);

final_score_144_c898 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '3: Derog', '4: Recent Activity']) => -0.0003623331,
    (nf_seg_fraudpoint_3_0 in ['5: Vuln Vic/Friendly', '6: Other'])                                    => 0.0966977757,
    nf_seg_fraudpoint_3_0 = ''                                                                       => 0.0394053504,
                                                                                                          0.0394053504);

final_score_144_c897 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 87250 => -0.0018767927,
    r_a49_curr_avm_chg_1yr_i > 87250                                      => final_score_144_c898,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => -0.0004525884,
                                                                             -0.0004525884);

final_score_144_c896 := map(
    NULL < nf_inq_per_add_nas_479 AND nf_inq_per_add_nas_479 <= 0.5 => final_score_144_c897,
    nf_inq_per_add_nas_479 > 0.5                                    => 0.0825207157,
    nf_inq_per_add_nas_479 = NULL                                   => 0.0006458761,
                                                                       0.0006458761);

final_score_144_c895 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 145500 => final_score_144_c896,
    r_a49_curr_avm_chg_1yr_i > 145500                                      => -0.0553721437,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => -0.0073117619,
                                                                              -0.0041668515);

final_score_144 := map(
    NULL < f_recent_disconnects_i AND f_recent_disconnects_i <= 1.5 => final_score_144_c895,
    f_recent_disconnects_i > 1.5                                    => 0.0802001131,
    f_recent_disconnects_i = NULL                                   => -0.0037103785,
                                                                       -0.0037103785);

final_score_145_c902 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 105.8 => 0.1781770752,
    r_a49_curr_avm_chg_1yr_pct_i > 105.8                                          => 0.0154667660,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                           => 0.0267351611,
                                                                                     0.0534634878);

final_score_145_c901 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => -0.0019477267,
    f_srchunvrfdaddrcount_i > 0.5                                     => final_score_145_c902,
    f_srchunvrfdaddrcount_i = NULL                                    => -0.0001923262,
                                                                         -0.0001923262);

final_score_145_c900 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 4.5 => final_score_145_c901,
    k_inq_lnames_per_addr_i > 4.5                                     => 0.0822838400,
    k_inq_lnames_per_addr_i = NULL                                    => 0.0003933251,
                                                                         0.0003933251);

final_score_145_c903 := map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 0.5 => 0.0306612665,
    f_rel_homeover150_count_d > 0.5                                       => -0.0631143152,
    f_rel_homeover150_count_d = NULL                                      => -0.0459420351,
                                                                             -0.0459420351);

final_score_145 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 3.5 => final_score_145_c900,
    r_c23_inp_addr_occ_index_d > 3.5                                        => final_score_145_c903,
    r_c23_inp_addr_occ_index_d = NULL                                       => 0.0117276866,
                                                                               -0.0010495150);

final_score_146_c907 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 206 => 0.1001103619,
    r_d32_mos_since_crim_ls_d > 206                                       => -0.0250089115,
    r_d32_mos_since_crim_ls_d = NULL                                      => 0.0147028579,
                                                                             0.0147028579);

final_score_146_c906 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '3: Derog', '4: Recent Activity', '5: Vuln Vic/Friendly']) => final_score_146_c907,
    (nf_seg_fraudpoint_3_0 in ['6: Other'])                                                                                    => 0.1072979830,
    nf_seg_fraudpoint_3_0 = ''                                                                                               => 0.0328333719,
                                                                                                                                  0.0328333719);

final_score_146_c905 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 27.5 => 0.0072728891,
    r_p88_phn_dst_to_inp_add_i > 27.5                                        => 0.0968935752,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => final_score_146_c906,
                                                                                0.0160286086);

final_score_146_c908 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 13.5 => -0.0074836982,
    f_rel_incomeover75_count_d > 13.5                                        => -0.0745085949,
    f_rel_incomeover75_count_d = NULL                                        => -0.0020427693,
                                                                                -0.0088737426);

final_score_146 := map(
    NULL < r_i60_inq_mortgage_recency_d AND r_i60_inq_mortgage_recency_d <= 549 => final_score_146_c905,
    r_i60_inq_mortgage_recency_d > 549                                          => final_score_146_c908,
    r_i60_inq_mortgage_recency_d = NULL                                         => 0.0169701675,
                                                                                   -0.0046398610);

final_score_147_c913 := map(
    NULL < r_e55_college_ind_d AND r_e55_college_ind_d <= 0.5 => 0.0334751376,
    r_e55_college_ind_d > 0.5                                 => 0.1961433971,
    r_e55_college_ind_d = NULL                                => 0.1309469915,
                                                                 0.1309469915);

final_score_147_c912 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => final_score_147_c913,
    r_phn_pcs_n > 0.5                         => 0.0020962907,
    r_phn_pcs_n = NULL                        => 0.0807170573,
                                                 0.0807170573);

final_score_147_c911 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_147_c912,
    r_phn_cell_n > 0.5                          => -0.0091128048,
    r_phn_cell_n = NULL                         => 0.0253344868,
                                                   0.0253344868);

final_score_147_c910 := map(
    NULL < f_hh_college_attendees_d AND f_hh_college_attendees_d <= 1.5 => -0.0018091093,
    f_hh_college_attendees_d > 1.5                                      => final_score_147_c911,
    f_hh_college_attendees_d = NULL                                     => 0.0327641560,
                                                                           0.0000961505);

final_score_147 := map(
    NULL < f_recent_disconnects_i AND f_recent_disconnects_i <= 1.5 => final_score_147_c910,
    f_recent_disconnects_i > 1.5                                    => 0.0633117871,
    f_recent_disconnects_i = NULL                                   => 0.0004817753,
                                                                       0.0004817753);

final_score_148_c918 := map(
    NULL < r_i60_inq_banking_recency_d AND r_i60_inq_banking_recency_d <= 18 => 0.1104336263,
    r_i60_inq_banking_recency_d > 18                                         => 0.0299637744,
    r_i60_inq_banking_recency_d = NULL                                       => 0.0439321261,
                                                                                0.0439321261);

final_score_148_c917 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 4.5 => 0.0134270186,
    r_wealth_index_d > 4.5                              => final_score_148_c918,
    r_wealth_index_d = NULL                             => 0.0196972171,
                                                           0.0196972171);

final_score_148_c916 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 0.5 => -0.0103950083,
    k_inq_per_ssn_i > 0.5                             => final_score_148_c917,
    k_inq_per_ssn_i = NULL                            => 0.0021266539,
                                                         0.0021266539);

final_score_148_c915 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 0.5 => final_score_148_c916,
    k_inq_adls_per_phone_i > 0.5                                    => -0.0238909148,
    k_inq_adls_per_phone_i = NULL                                   => -0.0065964823,
                                                                       -0.0065964823);

final_score_148 := map(
    NULL < k_inq_adls_per_ssn_i AND k_inq_adls_per_ssn_i <= 1.5 => final_score_148_c915,
    k_inq_adls_per_ssn_i > 1.5                                  => 0.0971724151,
    k_inq_adls_per_ssn_i = NULL                                 => -0.0058846782,
                                                                   -0.0058846782);

final_score_149_c920 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= -30950 => 0.1162637596,
    r_a49_curr_avm_chg_1yr_i > -30950                                      => -0.0247132268,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => -0.0198533852,
                                                                              -0.0186809071);

final_score_149_c923 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 108 => 0.0370583665,
    r_c21_m_bureau_adl_fs_d > 108                                     => 0.1593177538,
    r_c21_m_bureau_adl_fs_d = NULL                                    => 0.0924314522,
                                                                         0.0924314522);

final_score_149_c922 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '3: Derog', '4: Recent Activity']) => -0.0022651997,
    (nf_seg_fraudpoint_3_0 in ['2: Synth ID', '5: Vuln Vic/Friendly', '6: Other'])      => final_score_149_c923,
    nf_seg_fraudpoint_3_0 = ''                                                        => 0.0500054770,
                                                                                           0.0500054770);

final_score_149_c921 := map(
    (nf_source_type in ['Bureau and Behavioral', 'Bureau and Government', 'Bureau Behavioral and Government', 'Government Only']) => 0.0037178862,
    (nf_source_type in ['Behavioral and Government', 'Behavioral Only', 'Bureau Only', 'None'])                                   => final_score_149_c922,
    nf_source_type = ''                                                                                                         => 0.0050121959,
                                                                                                                                     0.0050121959);

final_score_149 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 5.5 => final_score_149_c920,
    f_addrs_per_ssn_i > 5.5                               => final_score_149_c921,
    f_addrs_per_ssn_i = NULL                              => -0.0004510808,
                                                             -0.0004510808);

final_score_150_c927 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 98250 => 0.0084955694,
    r_a49_curr_avm_chg_1yr_i > 98250                                      => -0.0549369026,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => 0.0104145043,
                                                                             0.0081865199);

final_score_150_c928 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 22.5 => 0.1426685104,
    f_rel_educationover12_count_d > 22.5                                           => 0.0096499728,
    f_rel_educationover12_count_d = NULL                                           => 0.0682807332,
                                                                                      0.0682807332);

final_score_150_c926 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 21.5 => final_score_150_c927,
    f_rel_under500miles_cnt_d > 21.5                                       => final_score_150_c928,
    f_rel_under500miles_cnt_d = NULL                                       => -0.0228800351,
                                                                              0.0100469673);

final_score_150_c925 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 3.5 => final_score_150_c926,
    r_e57_br_source_count_d > 3.5                                     => 0.0830697836,
    r_e57_br_source_count_d = NULL                                    => 0.0111262254,
                                                                         0.0111262254);

final_score_150 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => -0.0088315252,
    r_i61_inq_collection_recency_d > 549                                            => final_score_150_c925,
    r_i61_inq_collection_recency_d = NULL                                           => -0.0136742266,
                                                                                       -0.0015035982);

final_score_151_c931 := map(
    NULL < f_property_owners_ct_d AND f_property_owners_ct_d <= 1.5 => 0.0290319351,
    f_property_owners_ct_d > 1.5                                    => 0.1148238606,
    f_property_owners_ct_d = NULL                                   => 0.0680564211,
                                                                       0.0680564211);

final_score_151_c932 := map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i <= 4.5 => -0.0949670911,
    f_rel_criminal_count_i > 4.5                                    => 0.0618110461,
    f_rel_criminal_count_i = NULL                                   => -0.0191909915,
                                                                       -0.0191909915);

final_score_151_c930 := map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 10.5 => final_score_151_c931,
    f_rel_homeover50_count_d > 10.5                                      => final_score_151_c932,
    f_rel_homeover50_count_d = NULL                                      => 0.0275547209,
                                                                            0.0275547209);

final_score_151_c933 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 5.5 => -0.0538565201,
    f_addrs_per_ssn_i > 5.5                               => -0.0053286568,
    f_addrs_per_ssn_i = NULL                              => -0.0403465358,
                                                             -0.0403465358);

final_score_151 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 98 => final_score_151_c930,
    r_f00_dob_score_d > 98                               => 0.0029275126,
    r_f00_dob_score_d = NULL                             => final_score_151_c933,
                                                            0.0025960618);

final_score_152_c937 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 203.5 => 0.0180120568,
    r_d32_mos_since_crim_ls_d > 203.5                                       => -0.0097398985,
    r_d32_mos_since_crim_ls_d = NULL                                        => -0.0039421871,
                                                                               -0.0039421871);

final_score_152_c938 := map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 1.5 => -0.0473528034,
    r_s66_adlperssn_count_i > 1.5                                     => -0.1199330238,
    r_s66_adlperssn_count_i = NULL                                    => -0.0810176716,
                                                                         -0.0810176716);

final_score_152_c936 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 401.5 => final_score_152_c937,
    f_m_bureau_adl_fs_notu_d > 401.5                                      => final_score_152_c938,
    f_m_bureau_adl_fs_notu_d = NULL                                       => -0.0049276042,
                                                                             -0.0049276042);

final_score_152_c935 := map(
    NULL < r_f00_input_dob_match_level_d AND r_f00_input_dob_match_level_d <= 1.5 => 0.0867833465,
    r_f00_input_dob_match_level_d > 1.5                                           => final_score_152_c936,
    r_f00_input_dob_match_level_d = NULL                                          => -0.0044137897,
                                                                                     -0.0044137897);

final_score_152 := map(
    NULL < f_mos_liens_rel_ot_fseen_d AND f_mos_liens_rel_ot_fseen_d <= 236.5 => final_score_152_c935,
    f_mos_liens_rel_ot_fseen_d > 236.5                                        => 0.1289742432,
    f_mos_liens_rel_ot_fseen_d = NULL                                         => -0.0064575333,
                                                                                 -0.0036692539);

final_score_153_c943 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 8.5 => 0.0022766192,
    f_rel_homeover500_count_d > 8.5                                       => 0.0437242538,
    f_rel_homeover500_count_d = NULL                                      => -0.0066128125,
                                                                             0.0029168311);

final_score_153_c942 := map(
    NULL < f_current_count_d AND f_current_count_d <= 9.5 => final_score_153_c943,
    f_current_count_d > 9.5                               => 0.1293724061,
    f_current_count_d = NULL                              => 0.0038133788,
                                                             0.0038133788);

final_score_153_c941 := map(
    NULL < r_i60_inq_retail_count12_i AND r_i60_inq_retail_count12_i <= 1.5 => final_score_153_c942,
    r_i60_inq_retail_count12_i > 1.5                                        => -0.0864570223,
    r_i60_inq_retail_count12_i = NULL                                       => 0.0015533023,
                                                                               0.0015533023);

final_score_153_c940 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 501.5 => final_score_153_c941,
    r_c10_m_hdr_fs_d > 501.5                              => 0.1290904856,
    r_c10_m_hdr_fs_d = NULL                               => 0.0022848864,
                                                             0.0022848864);

final_score_153 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 530.5 => final_score_153_c940,
    r_c10_m_hdr_fs_d > 530.5                              => -0.0733844220,
    r_c10_m_hdr_fs_d = NULL                               => 0.0024358155,
                                                             0.0015679584);

final_score_154_c947 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 2.5 => -0.0314991744,
    f_phone_ver_insurance_d > 2.5                                     => 0.1247499185,
    f_phone_ver_insurance_d = NULL                                    => 0.0683423037,
                                                                         0.0683423037);

final_score_154_c946 := map(
    NULL < f_recent_disconnects_i AND f_recent_disconnects_i <= 0.5 => 0.0021495924,
    f_recent_disconnects_i > 0.5                                    => final_score_154_c947,
    f_recent_disconnects_i = NULL                                   => 0.0046633546,
                                                                       0.0046633546);

final_score_154_c948 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 3.5 => -0.0053555138,
    k_inq_lnames_per_addr_i > 3.5                                     => 0.0578884739,
    k_inq_lnames_per_addr_i = NULL                                    => -0.0041052817,
                                                                         -0.0041052817);

final_score_154_c945 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 170304 => final_score_154_c946,
    r_a49_curr_avm_chg_1yr_i > 170304                                      => 0.0498544723,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => final_score_154_c948,
                                                                              0.0003436837);

final_score_154 := map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 142.5 => -0.0507925212,
    f_mos_liens_unrel_cj_lseen_d > 142.5                                          => final_score_154_c945,
    f_mos_liens_unrel_cj_lseen_d = NULL                                           => 0.0340874414,
                                                                                     -0.0066308312);

final_score_155_c952 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 7.5 => 0.1033002588,
    f_rel_educationover12_count_d > 7.5                                           => 0.0207189337,
    f_rel_educationover12_count_d = NULL                                          => 0.0518859903,
                                                                                     0.0518859903);

final_score_155_c951 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 25.5 => -0.0385992691,
    f_prevaddrlenofres_d > 25.5                                  => final_score_155_c952,
    f_prevaddrlenofres_d = NULL                                  => 0.0288466224,
                                                                    0.0288466224);

final_score_155_c953 := map(
    NULL < f_assoccredbureaucount_i AND f_assoccredbureaucount_i <= 2.5 => -0.0039255939,
    f_assoccredbureaucount_i > 2.5                                      => 0.0879688382,
    f_assoccredbureaucount_i = NULL                                     => -0.0029668368,
                                                                           -0.0029668368);

final_score_155_c950 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 98 => final_score_155_c951,
    r_f00_dob_score_d > 98                               => final_score_155_c953,
    r_f00_dob_score_d = NULL                             => -0.0269439429,
                                                            -0.0024371597);

final_score_155 := map(
    NULL < f_crim_rel_under100miles_cnt_i AND f_crim_rel_under100miles_cnt_i <= 9.5 => final_score_155_c950,
    f_crim_rel_under100miles_cnt_i > 9.5                                            => -0.0670379185,
    f_crim_rel_under100miles_cnt_i = NULL                                           => 0.0178991766,
                                                                                       -0.0039683644);

final_score_156_c956 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 372.5 => -0.0008097044,
    r_c21_m_bureau_adl_fs_d > 372.5                                     => 0.0251485642,
    r_c21_m_bureau_adl_fs_d = NULL                                      => 0.0013119470,
                                                                           0.0013119470);

final_score_156_c957 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 2.5 => 0.1270979393,
    f_srchvelocityrisktype_i > 2.5                                      => -0.0117971240,
    f_srchvelocityrisktype_i = NULL                                     => 0.0592216188,
                                                                           0.0592216188);

final_score_156_c955 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 18.5 => final_score_156_c956,
    f_phones_per_addr_curr_i > 18.5                                      => final_score_156_c957,
    f_phones_per_addr_curr_i = NULL                                      => 0.0020115991,
                                                                            0.0020115991);

final_score_156_c958 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 2.5 => -0.1123733333,
    f_historical_count_d > 2.5                                  => 0.0091454535,
    f_historical_count_d = NULL                                 => -0.0592923248,
                                                                   -0.0592923248);

final_score_156 := map(
    NULL < f_property_owners_ct_d AND f_property_owners_ct_d <= 4.5 => final_score_156_c955,
    f_property_owners_ct_d > 4.5                                    => final_score_156_c958,
    f_property_owners_ct_d = NULL                                   => 0.0068379123,
                                                                       0.0008773349);

final_score_157_c963 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 0.5 => 0.1407137161,
    f_inq_count24_i > 0.5                             => 0.0384434468,
    f_inq_count24_i = NULL                            => 0.0699805343,
                                                         0.0699805343);

final_score_157_c962 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 7.5 => final_score_157_c963,
    f_rel_under100miles_cnt_d > 7.5                                       => 0.0129362875,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0245654244,
                                                                             0.0245654244);

final_score_157_c961 := map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i <= 4.5 => final_score_157_c962,
    k_inq_per_addr_i > 4.5                              => -0.0384801696,
    k_inq_per_addr_i = NULL                             => 0.0143027394,
                                                           0.0143027394);

final_score_157_c960 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 6.5 => -0.0066924438,
    f_rel_homeover300_count_d > 6.5                                       => final_score_157_c961,
    f_rel_homeover300_count_d = NULL                                      => -0.0011722544,
                                                                             -0.0035481133);

final_score_157 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 15.5 => final_score_157_c960,
    k_inq_per_ssn_i > 15.5                             => 0.0775567733,
    k_inq_per_ssn_i = NULL                             => -0.0028884436,
                                                          -0.0028884436);

final_score_158_c966 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => -0.0099440914,
    r_f03_input_add_not_most_rec_i > 0.5                                            => 0.0152671733,
    r_f03_input_add_not_most_rec_i = NULL                                           => -0.0061985186,
                                                                                       -0.0061985186);

final_score_158_c968 := map(
    NULL < r_d31_mostrec_bk_i AND r_d31_mostrec_bk_i <= 0.5 => 0.1235563437,
    r_d31_mostrec_bk_i > 0.5                                => -0.0172930569,
    r_d31_mostrec_bk_i = NULL                               => 0.0860537594,
                                                               0.0860537594);

final_score_158_c967 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 0.5 => final_score_158_c968,
    r_c14_addrs_5yr_i > 0.5                               => -0.0012448721,
    r_c14_addrs_5yr_i = NULL                              => 0.0377659605,
                                                             0.0377659605);

final_score_158_c965 := map(
    NULL < r_c12_num_nonderogs_d AND r_c12_num_nonderogs_d <= 5.5 => final_score_158_c966,
    r_c12_num_nonderogs_d > 5.5                                   => final_score_158_c967,
    r_c12_num_nonderogs_d = NULL                                  => -0.0035456144,
                                                                     -0.0035456144);

final_score_158 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 32.5 => final_score_158_c965,
    f_rel_homeover200_count_d > 32.5                                       => -0.1013848697,
    f_rel_homeover200_count_d = NULL                                       => -0.0059051553,
                                                                              -0.0042039025);

final_score_159_c973 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 286094 => 0.0559857646,
    r_a46_curr_avm_autoval_d > 286094                                      => -0.0201955859,
    r_a46_curr_avm_autoval_d = NULL                                        => 0.0012259776,
                                                                              0.0203209124);

final_score_159_c972 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_159_c973,
    f_phone_ver_experian_d > 0.5                                    => -0.0106603154,
    f_phone_ver_experian_d = NULL                                   => 0.0611067162,
                                                                       0.0099839302);

final_score_159_c971 := map(
    NULL < (real)k_inf_contradictory_i AND (real)k_inf_contradictory_i <= 0.5 			=> -0.0057517108,
    (real)k_inf_contradictory_i > 0.5                                   						=> final_score_159_c972,
    (real)k_inf_contradictory_i = NULL                                  						=> -0.0023198497,
																																												-0.0023198497);

final_score_159_c970 := map(
    NULL < f_addrs_per_ssn_c6_i AND f_addrs_per_ssn_c6_i <= 1.5 => final_score_159_c971,
    f_addrs_per_ssn_c6_i > 1.5                                  => 0.0929344619,
    f_addrs_per_ssn_c6_i = NULL                                 => -0.0012807533,
                                                                   -0.0012807533);

final_score_159 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 16.5 => final_score_159_c970,
    f_rel_incomeover50_count_d > 16.5                                        => -0.0394280664,
    f_rel_incomeover50_count_d = NULL                                        => -0.0106414706,
                                                                                -0.0048264336);

final_score_160_c977 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 2.5 => -0.0904932220,
    f_util_adl_count_n > 2.5                                => 0.0304161840,
    f_util_adl_count_n = NULL                               => -0.0473716856,
                                                               -0.0473716856);

final_score_160_c976 := map(
    NULL < r_l70_add_invalid_i AND r_l70_add_invalid_i <= 0.5 => 0.0035635059,
    r_l70_add_invalid_i > 0.5                                 => final_score_160_c977,
    r_l70_add_invalid_i = NULL                                => 0.0027134963,
                                                                 0.0027134963);

final_score_160_c975 := map(
    NULL < f_mos_liens_unrel_st_lseen_d AND f_mos_liens_unrel_st_lseen_d <= 224.5 => -0.0683468485,
    f_mos_liens_unrel_st_lseen_d > 224.5                                          => final_score_160_c976,
    f_mos_liens_unrel_st_lseen_d = NULL                                           => -0.0023506981,
                                                                                     -0.0023506981);

final_score_160_c978 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 10.5 => -0.0025861622,
    f_rel_under500miles_cnt_d > 10.5                                       => 0.1917050493,
    f_rel_under500miles_cnt_d = NULL                                       => 0.0908230741,
                                                                              0.0908230741);

final_score_160 := map(
    NULL < r_a43_watercraft_cnt_d AND r_a43_watercraft_cnt_d <= 1.5 => final_score_160_c975,
    r_a43_watercraft_cnt_d > 1.5                                    => final_score_160_c978,
    r_a43_watercraft_cnt_d = NULL                                   => -0.0146628573,
                                                                       -0.0014389338);

final_score_161_c983 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 110.5 => 0.0104159555,
    f_prevaddrlenofres_d > 110.5                                  => 0.0450049510,
    f_prevaddrlenofres_d = NULL                                   => 0.0177006893,
                                                                     0.0177006893);

final_score_161_c982 := map(
    NULL < nf_number_non_bureau_sources AND nf_number_non_bureau_sources <= 2.5 => final_score_161_c983,
    nf_number_non_bureau_sources > 2.5                                          => -0.0042362707,
    nf_number_non_bureau_sources = NULL                                         => 0.0005009302,
                                                                                   0.0005009302);

final_score_161_c981 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 8.5 => -0.0686379842,
    r_c21_m_bureau_adl_fs_d > 8.5                                     => final_score_161_c982,
    r_c21_m_bureau_adl_fs_d = NULL                                    => -0.0016140311,
                                                                         -0.0016140311);

final_score_161_c980 := map(
    NULL < f_inq_quizprovider_count24_i AND f_inq_quizprovider_count24_i <= 3.5 => final_score_161_c981,
    f_inq_quizprovider_count24_i > 3.5                                          => 0.1204845357,
    f_inq_quizprovider_count24_i = NULL                                         => -0.0006644635,
                                                                                   -0.0006644635);

final_score_161 := map(
    NULL < f_property_owners_ct_d AND f_property_owners_ct_d <= 5.5 => final_score_161_c980,
    f_property_owners_ct_d > 5.5                                    => -0.1356498936,
    f_property_owners_ct_d = NULL                                   => 0.0038576005,
                                                                       -0.0014940842);

final_score_162_c988 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 157.5 => 0.0522231539,
    r_c13_max_lres_d > 157.5                              => 0.2070643842,
    r_c13_max_lres_d = NULL                               => 0.1211593181,
                                                             0.1211593181);

final_score_162_c987 := map(
    NULL < k_inq_lnames_per_ssn_i AND k_inq_lnames_per_ssn_i <= 0.5 => final_score_162_c988,
    k_inq_lnames_per_ssn_i > 0.5                                    => 0.0219981892,
    k_inq_lnames_per_ssn_i = NULL                                   => 0.0334564598,
                                                                       0.0334564598);

final_score_162_c986 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 2.5 => -0.0022815396,
    k_inq_per_ssn_i > 2.5                             => final_score_162_c987,
    k_inq_per_ssn_i = NULL                            => 0.0032921150,
                                                         0.0032921150);

final_score_162_c985 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 6.5 => final_score_162_c986,
    f_inq_count24_i > 6.5                             => -0.0334759548,
    f_inq_count24_i = NULL                            => -0.0012974561,
                                                         -0.0012974561);

final_score_162 := map(
    NULL < f_current_count_d AND f_current_count_d <= 10.5 => final_score_162_c985,
    f_current_count_d > 10.5                               => 0.1434429482,
    f_current_count_d = NULL                               => 0.0114308509,
                                                              -0.0003873965);

final_score_163_c993 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 4.5 => 0.0141074946,
    f_rel_homeover300_count_d > 4.5                                       => 0.0488683401,
    f_rel_homeover300_count_d = NULL                                      => 0.0230223039,
                                                                             0.0230223039);

final_score_163_c992 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => final_score_163_c993,
    f_hh_lienholders_i > 0.5                                => -0.0073155591,
    f_hh_lienholders_i = NULL                               => 0.0055258644,
                                                               0.0055258644);

final_score_163_c991 := map(
    NULL < r_i60_inq_retail_recency_d AND r_i60_inq_retail_recency_d <= 61.5 => -0.0437501160,
    r_i60_inq_retail_recency_d > 61.5                                        => final_score_163_c992,
    r_i60_inq_retail_recency_d = NULL                                        => -0.0012089343,
                                                                                -0.0012089343);

final_score_163_c990 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => final_score_163_c991,
    f_validationrisktype_i > 1.5                                    => -0.0544776109,
    f_validationrisktype_i = NULL                                   => -0.0022264470,
                                                                       -0.0022264470);

final_score_163 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 195826.5 => final_score_163_c990,
    r_a49_curr_avm_chg_1yr_i > 195826.5                                      => -0.0574311346,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => -0.0022895692,
                                                                                -0.0025565944);

final_score_164_c996 := map(
    NULL < f_hh_college_attendees_d AND f_hh_college_attendees_d <= 1.5 => -0.0101718953,
    f_hh_college_attendees_d > 1.5                                      => 0.0582856970,
    f_hh_college_attendees_d = NULL                                     => -0.0057563474,
                                                                           -0.0057563474);

final_score_164_c995 := map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 8.5 => final_score_164_c996,
    f_rel_incomeover100_count_d > 8.5                                         => -0.0789725393,
    f_rel_incomeover100_count_d = NULL                                        => -0.0071666949,
                                                                                 -0.0071666949);

final_score_164_c998 := map(
    NULL < r_i60_inq_recency_d AND r_i60_inq_recency_d <= 4.5 => 0.1608934230,
    r_i60_inq_recency_d > 4.5                                 => 0.0305724364,
    r_i60_inq_recency_d = NULL                                => 0.0744187496,
                                                                 0.0744187496);

final_score_164_c997 := map(
    NULL < f_assoccredbureaucount_i AND f_assoccredbureaucount_i <= 1.5 => 0.0029636955,
    f_assoccredbureaucount_i > 1.5                                      => final_score_164_c998,
    f_assoccredbureaucount_i = NULL                                     => -0.0016787931,
                                                                           0.0058446156);

final_score_164 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= -84302 => 0.0805600763,
    r_a49_curr_avm_chg_1yr_i > -84302                                      => final_score_164_c995,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => final_score_164_c997,
                                                                              0.0004095946);

final_score_165_c1003 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.0209597650,
    f_phone_ver_experian_d > 0.5                                    => -0.0225074660,
    f_phone_ver_experian_d = NULL                                   => 0.0589342974,
                                                                       0.0047937142);

final_score_165_c1002 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 5.5 => -0.0342700945,
    f_addrs_per_ssn_i > 5.5                               => final_score_165_c1003,
    f_addrs_per_ssn_i = NULL                              => -0.0058443602,
                                                             -0.0058443602);

final_score_165_c1001 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 1193.5 => 0.0003680002,
    r_p88_phn_dst_to_inp_add_i > 1193.5                                        => 0.0858228228,
    r_p88_phn_dst_to_inp_add_i = NULL                                          => final_score_165_c1002,
                                                                                  -0.0006275626);

final_score_165_c1000 := map(
    NULL < f_hh_members_ct_d AND f_hh_members_ct_d <= 13.5 => final_score_165_c1001,
    f_hh_members_ct_d > 13.5                               => -0.0839101056,
    f_hh_members_ct_d = NULL                               => -0.0015617068,
                                                              -0.0015617068);

final_score_165 := map(
    NULL < r_f00_input_dob_match_level_d AND r_f00_input_dob_match_level_d <= 1.5 => 0.0756582192,
    r_f00_input_dob_match_level_d > 1.5                                           => final_score_165_c1000,
    r_f00_input_dob_match_level_d = NULL                                          => 0.0125926382,
                                                                                     -0.0009223296);

final_score_166_c1007 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 180.5 => -0.0001055718,
    f_prevaddrageoldest_d > 180.5                                   => -0.0463993364,
    f_prevaddrageoldest_d = NULL                                    => -0.0119085688,
                                                                       -0.0119085688);

final_score_166_c1006 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 272420 => -0.0012015347,
    r_a46_curr_avm_autoval_d > 272420                                      => final_score_166_c1007,
    r_a46_curr_avm_autoval_d = NULL                                        => 0.0062080035,
                                                                              0.0005079603);

final_score_166_c1008 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 3.5 => 0.1205029323,
    f_srchvelocityrisktype_i > 3.5                                      => -0.0558013786,
    f_srchvelocityrisktype_i = NULL                                     => 0.0553200005,
                                                                           0.0553200005);

final_score_166_c1005 := map(
    NULL < f_phones_per_addr_c6_i AND f_phones_per_addr_c6_i <= 5.5 => final_score_166_c1006,
    f_phones_per_addr_c6_i > 5.5                                    => final_score_166_c1008,
    f_phones_per_addr_c6_i = NULL                                   => 0.0013471764,
                                                                       0.0013471764);

final_score_166 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 534.5 => final_score_166_c1005,
    r_c13_max_lres_d > 534.5                              => 0.0624995393,
    r_c13_max_lres_d = NULL                               => -0.0159963561,
                                                             0.0014912409);

final_score_167_c1013 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 1.5 => 0.0744512429,
    k_inq_per_ssn_i > 1.5                             => 0.1671616786,
    k_inq_per_ssn_i = NULL                            => 0.1040881855,
                                                         0.1040881855);

final_score_167_c1012 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 323.5 => final_score_167_c1013,
    r_c13_curr_addr_lres_d > 323.5                                    => -0.0037250302,
    r_c13_curr_addr_lres_d = NULL                                     => 0.0666211814,
                                                                         0.0666211814);

final_score_167_c1011 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 136.5 => 0.0105857219,
    r_c13_curr_addr_lres_d > 136.5                                    => final_score_167_c1012,
    r_c13_curr_addr_lres_d = NULL                                     => 0.0381633826,
                                                                         0.0381633826);

final_score_167_c1010 := map(
    NULL < r_i60_inq_retail_recency_d AND r_i60_inq_retail_recency_d <= 549 => -0.0463155791,
    r_i60_inq_retail_recency_d > 549                                        => final_score_167_c1011,
    r_i60_inq_retail_recency_d = NULL                                       => 0.0176008913,
                                                                               0.0176008913);

final_score_167 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 372.5 => -0.0058872178,
    r_c21_m_bureau_adl_fs_d > 372.5                                     => final_score_167_c1010,
    r_c21_m_bureau_adl_fs_d = NULL                                      => -0.0228080040,
                                                                           -0.0041752202);

final_score_168_c1018 := map(
    NULL < f_rel_count_i AND f_rel_count_i <= 12.5 => 0.1151796965,
    f_rel_count_i > 12.5                           => 0.0128026180,
    f_rel_count_i = NULL                           => 0.0733086217,
                                                      0.0733086217);

final_score_168_c1017 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 248726 => 0.0279513905,
    r_l80_inp_avm_autoval_d > 248726                                     => final_score_168_c1018,
    r_l80_inp_avm_autoval_d = NULL                                       => 0.0190427385,
                                                                            0.0412615187);

final_score_168_c1016 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 6.5 => 0.0001315749,
    f_addrs_per_ssn_i > 6.5                               => final_score_168_c1017,
    f_addrs_per_ssn_i = NULL                              => 0.0293232463,
                                                             0.0293232463);

final_score_168_c1015 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 0.5 => final_score_168_c1016,
    k_inq_lnames_per_addr_i > 0.5                                     => -0.0053319644,
    k_inq_lnames_per_addr_i = NULL                                    => 0.0084702615,
                                                                         0.0084702615);

final_score_168 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 4646.5 => -0.0215949459,
    r_a49_curr_avm_chg_1yr_i > 4646.5                                      => final_score_168_c1015,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => 0.0048968958,
                                                                              0.0008134178);

final_score_169_c1023 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 297926.5 => -0.0217293892,
    r_l80_inp_avm_autoval_d > 297926.5                                     => 0.0482489126,
    r_l80_inp_avm_autoval_d = NULL                                         => -0.0101706108,
                                                                              -0.0100781692);

final_score_169_c1022 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => final_score_169_c1023,
    f_validationrisktype_i > 1.5                                    => 0.0509899292,
    f_validationrisktype_i = NULL                                   => -0.0088306084,
                                                                       -0.0088306084);

final_score_169_c1021 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 1.5 => 0.0466743887,
    f_rel_under100miles_cnt_d > 1.5                                       => final_score_169_c1022,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0159344856,
                                                                             -0.0038425056);

final_score_169_c1020 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 10.5 => 0.1018753730,
    r_d32_mos_since_crim_ls_d > 10.5                                       => final_score_169_c1021,
    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0223806837,
                                                                              -0.0013597722);

final_score_169 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 146481 => 0.0003981145,
    r_a49_curr_avm_chg_1yr_i > 146481                                      => -0.0583849600,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => final_score_169_c1020,
                                                                              -0.0010325008);

final_score_170_c1026 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 5.5 => -0.0094574854,
    f_addrchangeecontrajindex_d > 5.5                                         => 0.0502740575,
    f_addrchangeecontrajindex_d = NULL                                        => -0.0327007789,
                                                                                 -0.0112447583);

final_score_170_c1027 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 74.05 => -0.0338868324,
    r_c12_source_profile_d > 74.05                                    => -0.1109563769,
    r_c12_source_profile_d = NULL                                     => -0.0683221608,
                                                                         -0.0683221608);

final_score_170_c1025 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 422.5 => final_score_170_c1026,
    r_c10_m_hdr_fs_d > 422.5                              => final_score_170_c1027,
    r_c10_m_hdr_fs_d = NULL                               => -0.0149187659,
                                                             -0.0149187659);

final_score_170_c1028 := map(
    NULL < k_inq_adls_per_ssn_i AND k_inq_adls_per_ssn_i <= 1.5 => 0.0029866516,
    k_inq_adls_per_ssn_i > 1.5                                  => 0.1156872401,
    k_inq_adls_per_ssn_i = NULL                                 => 0.0038166693,
                                                                   0.0038166693);

final_score_170 := map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i <= 0.5 => final_score_170_c1025,
    f_rel_criminal_count_i > 0.5                                    => final_score_170_c1028,
    f_rel_criminal_count_i = NULL                                   => -0.0045553129,
                                                                       -0.0006162903);

final_score_171_c1032 := map(
    NULL < f_current_count_d AND f_current_count_d <= 4.5 => -0.0061645122,
    f_current_count_d > 4.5                               => 0.0971120584,
    f_current_count_d = NULL                              => -0.0005404092,
                                                             -0.0005404092);

final_score_171_c1031 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 78.85 => final_score_171_c1032,
    r_c12_source_profile_d > 78.85                                    => -0.0779835706,
    r_c12_source_profile_d = NULL                                     => -0.0050551170,
                                                                         -0.0050551170);

final_score_171_c1030 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 1262 => -0.0012346584,
    r_p88_phn_dst_to_inp_add_i > 1262                                        => 0.0895829255,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => final_score_171_c1031,
                                                                                -0.0016060627);

final_score_171_c1033 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 2.5 => -0.0981646540,
    f_phone_ver_insurance_d > 2.5                                     => -0.0131533662,
    f_phone_ver_insurance_d = NULL                                    => -0.0404409400,
                                                                         -0.0404409400);

final_score_171 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 3.5 => final_score_171_c1030,
    r_c23_inp_addr_occ_index_d > 3.5                                        => final_score_171_c1033,
    r_c23_inp_addr_occ_index_d = NULL                                       => -0.0085046938,
                                                                               -0.0028520198);

final_score_172_c1037 := map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i <= 1.5 => -0.0403985014,
    k_inq_per_addr_i > 1.5                              => 0.0080843068,
    k_inq_per_addr_i = NULL                             => -0.0189838335,
                                                           -0.0189838335);

final_score_172_c1036 := map(
    NULL < f_hh_members_ct_d AND f_hh_members_ct_d <= 5.5 => final_score_172_c1037,
    f_hh_members_ct_d > 5.5                               => 0.0645112064,
    f_hh_members_ct_d = NULL                              => 0.0103728701,
                                                             0.0103728701);

final_score_172_c1035 := map(
    NULL < r_i60_inq_mortgage_recency_d AND r_i60_inq_mortgage_recency_d <= 549 => 0.0953230138,
    r_i60_inq_mortgage_recency_d > 549                                          => final_score_172_c1036,
    r_i60_inq_mortgage_recency_d = NULL                                         => 0.0305004303,
                                                                                   0.0305004303);

final_score_172_c1038 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 8.5 => 0.0843720372,
    r_p88_phn_dst_to_inp_add_i > 8.5                                        => -0.0806931243,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => -0.0417150963,
                                                                               -0.0183138783);

final_score_172 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 6.5 => -0.0017368179,
    f_rel_homeover500_count_d > 6.5                                       => final_score_172_c1035,
    f_rel_homeover500_count_d = NULL                                      => final_score_172_c1038,
                                                                             -0.0012028450);

final_score_173_c1043 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 51.15 => 0.0091952210,
    r_c12_source_profile_d > 51.15                                    => 0.1045388754,
    r_c12_source_profile_d = NULL                                     => 0.0665677108,
                                                                         0.0665677108);

final_score_173_c1042 := map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i <= 0.5 => final_score_173_c1043,
    r_l70_add_standardized_i > 0.5                                      => -0.0049091697,
    r_l70_add_standardized_i = NULL                                     => 0.0350713943,
                                                                           0.0350713943);

final_score_173_c1041 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 95 => final_score_173_c1042,
    r_f01_inp_addr_address_score_d > 95                                            => 0.0011535694,
    r_f01_inp_addr_address_score_d = NULL                                          => 0.0027954004,
                                                                                      0.0027954004);

final_score_173_c1040 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 0.5 => -0.0190152715,
    f_assocsuspicousidcount_i > 0.5                                       => final_score_173_c1041,
    f_assocsuspicousidcount_i = NULL                                      => -0.0040533954,
                                                                             -0.0040533954);

final_score_173 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 6.5 => final_score_173_c1040,
    f_srchcomponentrisktype_i > 6.5                                       => -0.0861515521,
    f_srchcomponentrisktype_i = NULL                                      => -0.0330536449,
                                                                             -0.0049686602);

final_score_174_c1045 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 474.5 => -0.0049475546,
    r_c13_curr_addr_lres_d > 474.5                                    => -0.0791334860,
    r_c13_curr_addr_lres_d = NULL                                     => -0.0270125860,
                                                                         -0.0056357561);

final_score_174_c1048 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 5.5 => 0.1890515222,
    f_rel_under25miles_cnt_d > 5.5                                      => 0.0626374371,
    f_rel_under25miles_cnt_d = NULL                                     => 0.1140365706,
                                                                           0.1140365706);

final_score_174_c1047 := map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i <= 4.5 => final_score_174_c1048,
    f_rel_criminal_count_i > 4.5                                    => -0.0528530823,
    f_rel_criminal_count_i = NULL                                   => 0.0577315664,
                                                                       0.0577315664);

final_score_174_c1046 := map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 2.5 => 0.0105694775,
    f_rel_incomeover100_count_d > 2.5                                         => final_score_174_c1047,
    f_rel_incomeover100_count_d = NULL                                        => -0.0107702476,
                                                                                 0.0155054196);

final_score_174 := map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i <= 0.5 => final_score_174_c1045,
    r_l70_add_standardized_i > 0.5                                      => final_score_174_c1046,
    r_l70_add_standardized_i = NULL                                     => -0.0019029804,
                                                                           -0.0019029804);

final_score_175_c1053 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 5.5 => 0.1603460348,
    f_rel_incomeover50_count_d > 5.5                                        => 0.0091142542,
    f_rel_incomeover50_count_d = NULL                                       => 0.0153881722,
                                                                               0.0153881722);

final_score_175_c1052 := map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 12.5 => -0.0075352968,
    f_rel_homeover150_count_d > 12.5                                       => final_score_175_c1053,
    f_rel_homeover150_count_d = NULL                                       => 0.0537925458,
                                                                              -0.0027555298);

final_score_175_c1051 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 95 => 0.0467714726,
    r_f00_dob_score_d > 95                               => final_score_175_c1052,
    r_f00_dob_score_d = NULL                             => -0.0366394234,
                                                            -0.0023158744);

final_score_175_c1050 := map(
    NULL < r_f00_input_dob_match_level_d AND r_f00_input_dob_match_level_d <= 4.5 => -0.0922072631,
    r_f00_input_dob_match_level_d > 4.5                                           => final_score_175_c1051,
    r_f00_input_dob_match_level_d = NULL                                          => -0.0031062669,
                                                                                     -0.0031062669);

final_score_175 := map(
    NULL < r_f00_input_dob_match_level_d AND r_f00_input_dob_match_level_d <= 1.5 => 0.0639040008,
    r_f00_input_dob_match_level_d > 1.5                                           => final_score_175_c1050,
    r_f00_input_dob_match_level_d = NULL                                          => -0.0194588099,
                                                                                     -0.0028877981);

final_score_176_c1058 := map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 1.5 => -0.0956081818,
    r_s66_adlperssn_count_i > 1.5                                     => -0.0647605771,
    r_s66_adlperssn_count_i = NULL                                    => -0.0805533699,
                                                                         -0.0805533699);

final_score_176_c1057 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 4.5 => -0.0030045659,
    f_addrchangeecontrajindex_d > 4.5                                         => final_score_176_c1058,
    f_addrchangeecontrajindex_d = NULL                                        => -0.0409692936,
                                                                                 -0.0409692936);

final_score_176_c1056 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 170.5 => 0.0694154842,
    r_d32_mos_since_crim_ls_d > 170.5                                       => final_score_176_c1057,
    r_d32_mos_since_crim_ls_d = NULL                                        => -0.0181247618,
                                                                               -0.0181247618);

final_score_176_c1055 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 73480.5 => 0.0024273093,
    r_a49_curr_avm_chg_1yr_i > 73480.5                                      => final_score_176_c1056,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => 0.0014319380,
                                                                               0.0012128645);

final_score_176 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 31.5 => final_score_176_c1055,
    f_rel_under25miles_cnt_d > 31.5                                      => 0.0953566964,
    f_rel_under25miles_cnt_d = NULL                                      => 0.0241843613,
                                                                            0.0027400106);

final_score_177_c1061 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 0.5 => 0.0086438418,
    f_bus_addr_match_count_d > 0.5                                      => 0.0630285017,
    f_bus_addr_match_count_d = NULL                                     => 0.0167242898,
                                                                           0.0167242898);

final_score_177_c1060 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => -0.0048306815,
    r_c23_inp_addr_occ_index_d > 2                                        => final_score_177_c1061,
    r_c23_inp_addr_occ_index_d = NULL                                     => -0.0006686684,
                                                                             -0.0006686684);

final_score_177_c1063 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 37.5 => -0.0674663923,
    f_prevaddrlenofres_d > 37.5                                  => 0.0518130454,
    f_prevaddrlenofres_d = NULL                                  => -0.0124439420,
                                                                    -0.0124439420);

final_score_177_c1062 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 147.5 => final_score_177_c1063,
    f_prevaddrageoldest_d > 147.5                                   => -0.1205989883,
    f_prevaddrageoldest_d = NULL                                    => -0.0407702637,
                                                                       -0.0407702637);

final_score_177 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => final_score_177_c1060,
    f_validationrisktype_i > 1.5                                    => final_score_177_c1062,
    f_validationrisktype_i = NULL                                   => 0.0372792946,
                                                                       -0.0011896898);

final_score_178_c1068 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 61.5 => 0.1284289489,
    r_c13_curr_addr_lres_d > 61.5                                    => 0.0012999925,
    r_c13_curr_addr_lres_d = NULL                                    => 0.0615189719,
                                                                        0.0615189719);

final_score_178_c1067 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 95 => final_score_178_c1068,
    r_f00_ssn_score_d > 95                               => 0.0013088251,
    r_f00_ssn_score_d = NULL                             => 0.0020749773,
                                                            0.0020749773);

final_score_178_c1066 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 45 => -0.0702770770,
    r_f00_ssn_score_d > 45                               => final_score_178_c1067,
    r_f00_ssn_score_d = NULL                             => 0.0013712102,
                                                            0.0013712102);

final_score_178_c1065 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 11.5 => final_score_178_c1066,
    r_l79_adls_per_addr_curr_i > 11.5                                        => -0.0665471007,
    r_l79_adls_per_addr_curr_i = NULL                                        => 0.0009802116,
                                                                                0.0009802116);

final_score_178 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 0.5 => -0.0870235951,
    f_phone_ver_insurance_d > 0.5                                     => final_score_178_c1065,
    f_phone_ver_insurance_d = NULL                                    => 0.0344905642,
                                                                         -0.0006437866);

final_score_179_c1072 := map(
    NULL < f_dl_addrs_per_adl_i AND f_dl_addrs_per_adl_i <= 0.5 => 0.0056788021,
    f_dl_addrs_per_adl_i > 0.5                                  => -0.0210454684,
    f_dl_addrs_per_adl_i = NULL                                 => -0.0066767899,
                                                                   -0.0066767899);

final_score_179_c1071 := map(
    NULL < f_addrs_per_ssn_c6_i AND f_addrs_per_ssn_c6_i <= 1.5 => final_score_179_c1072,
    f_addrs_per_ssn_c6_i > 1.5                                  => 0.0781780582,
    f_addrs_per_ssn_c6_i = NULL                                 => -0.0058304066,
                                                                   -0.0058304066);

final_score_179_c1070 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 8.5 => final_score_179_c1071,
    f_varrisktype_i > 8.5                             => -0.0631194789,
    f_varrisktype_i = NULL                            => -0.0062842726,
                                                         -0.0062842726);

final_score_179_c1073 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 4.5 => -0.0149292728,
    r_p88_phn_dst_to_inp_add_i > 4.5                                        => -0.0265981069,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => -0.0976675602,
                                                                               -0.0338609731);

final_score_179 := map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 5.5 => final_score_179_c1070,
    f_rel_incomeover100_count_d > 5.5                                         => final_score_179_c1073,
    f_rel_incomeover100_count_d = NULL                                        => 0.0014567721,
                                                                                 -0.0074025385);

final_score_180_c1076 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 86964.5 => -0.0024736507,
    r_a49_curr_avm_chg_1yr_i > 86964.5                                      => 0.0890534671,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => -0.0006355734,
                                                                               -0.0006355734);

final_score_180_c1075 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 110862 => final_score_180_c1076,
    r_a49_curr_avm_chg_1yr_i > 110862                                      => -0.0440083478,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => -0.0000313939,
                                                                              -0.0009826277);

final_score_180_c1078 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 12.5 => -0.0284009125,
    f_addrs_per_ssn_i > 12.5                               => 0.0515197135,
    f_addrs_per_ssn_i = NULL                               => 0.0106713935,
                                                              0.0106713935);

final_score_180_c1077 := map(
    NULL < f_rel_bankrupt_count_i AND f_rel_bankrupt_count_i <= 0.5 => 0.1060089421,
    f_rel_bankrupt_count_i > 0.5                                    => final_score_180_c1078,
    f_rel_bankrupt_count_i = NULL                                   => 0.0400995654,
                                                                       0.0400995654);

final_score_180 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 83.95 => final_score_180_c1075,
    r_c12_source_profile_d > 83.95                                    => final_score_180_c1077,
    r_c12_source_profile_d = NULL                                     => -0.0201459175,
                                                                         -0.0003235534);

final_score_181_c1081 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 2.5 => 0.0076554015,
    k_inq_ssns_per_addr_i > 2.5                                   => 0.1172586333,
    k_inq_ssns_per_addr_i = NULL                                  => 0.0121596439,
                                                                     0.0121596439);

final_score_181_c1083 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 8.5 => 0.0852036366,
    f_rel_incomeover75_count_d > 8.5                                        => -0.0411413053,
    f_rel_incomeover75_count_d = NULL                                       => 0.0309805990,
                                                                               0.0309805990);

final_score_181_c1082 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 3.5 => 0.1345967935,
    f_phones_per_addr_curr_i > 3.5                                      => final_score_181_c1083,
    f_phones_per_addr_curr_i = NULL                                     => 0.0679268560,
                                                                           0.0679268560);

final_score_181_c1080 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 7.5 => final_score_181_c1081,
    f_rel_homeover300_count_d > 7.5                                       => final_score_181_c1082,
    f_rel_homeover300_count_d = NULL                                      => 0.0184745104,
                                                                             0.0184745104);

final_score_181 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 1.5 => final_score_181_c1080,
    f_srchvelocityrisktype_i > 1.5                                      => -0.0035759383,
    f_srchvelocityrisktype_i = NULL                                     => -0.0299310016,
                                                                           0.0000637117);

final_score_182_c1086 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 501.5 => 0.0014506112,
    f_m_bureau_adl_fs_all_d > 501.5                                     => 0.0568625457,
    f_m_bureau_adl_fs_all_d = NULL                                      => 0.0021113309,
                                                                           0.0021113309);

final_score_182_c1087 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 2.5 => -0.0885330134,
    f_historical_count_d > 2.5                                  => 0.0124247160,
    f_historical_count_d = NULL                                 => -0.0415354497,
                                                                   -0.0415354497);

final_score_182_c1085 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 23.5 => final_score_182_c1086,
    f_bus_addr_match_count_d > 23.5                                      => final_score_182_c1087,
    f_bus_addr_match_count_d = NULL                                      => 0.0015411702,
                                                                            0.0015411702);

final_score_182_c1088 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 1.5 => -0.0300885717,
    f_rel_homeover500_count_d > 1.5                                       => -0.1116663645,
    f_rel_homeover500_count_d = NULL                                      => -0.0427948193,
                                                                             -0.0427948193);

final_score_182 := map(
    NULL < f_inq_retail_count24_i AND f_inq_retail_count24_i <= 1.5 => final_score_182_c1085,
    f_inq_retail_count24_i > 1.5                                    => final_score_182_c1088,
    f_inq_retail_count24_i = NULL                                   => 0.0157420144,
                                                                       -0.0004175475);

final_score_183_c1092 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 1.5 => 0.0174306063,
    f_idverrisktype_i > 1.5                               => 0.1206971088,
    f_idverrisktype_i = NULL                              => 0.0649514747,
                                                             0.0649514747);

final_score_183_c1091 := map(
    NULL < f_srchphonesrchcountwk_i AND f_srchphonesrchcountwk_i <= 0.5 => 0.0039505673,
    f_srchphonesrchcountwk_i > 0.5                                      => final_score_183_c1092,
    f_srchphonesrchcountwk_i = NULL                                     => 0.0051036457,
                                                                           0.0051036457);

final_score_183_c1090 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 472.5 => final_score_183_c1091,
    r_c13_max_lres_d > 472.5                              => 0.0695381002,
    r_c13_max_lres_d = NULL                               => 0.0059702862,
                                                             0.0059702862);

final_score_183_c1093 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 4.5 => -0.0059495799,
    f_addrchangeecontrajindex_d > 4.5                                         => -0.0389670086,
    f_addrchangeecontrajindex_d = NULL                                        => -0.0356500097,
                                                                                 -0.0115520620);

final_score_183 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 2.5 => final_score_183_c1090,
    r_c18_invalid_addrs_per_adl_i > 2.5                                           => final_score_183_c1093,
    r_c18_invalid_addrs_per_adl_i = NULL                                          => 0.0551401567,
                                                                                     0.0003878675);

final_score_184_c1095 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 504.5 => 0.0088245416,
    r_c10_m_hdr_fs_d > 504.5                              => 0.0591407397,
    r_c10_m_hdr_fs_d = NULL                               => 0.0095636356,
                                                             0.0095636356);

final_score_184_c1097 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 4.5 => -0.0461294618,
    f_rel_educationover12_count_d > 4.5                                           => 0.0159683496,
    f_rel_educationover12_count_d = NULL                                          => 0.0098860288,
                                                                                     0.0098860288);

final_score_184_c1098 := map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d <= 5.5 => -0.1022415373,
    f_rel_incomeover25_count_d > 5.5                                        => -0.0264164979,
    f_rel_incomeover25_count_d = NULL                                       => -0.0394251214,
                                                                               -0.0394251214);

final_score_184_c1096 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 278245 => final_score_184_c1097,
    r_a46_curr_avm_autoval_d > 278245                                      => final_score_184_c1098,
    r_a46_curr_avm_autoval_d = NULL                                        => -0.0150882096,
                                                                              -0.0068114760);

final_score_184 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 2.5 => final_score_184_c1095,
    r_c18_invalid_addrs_per_adl_i > 2.5                                           => final_score_184_c1096,
    r_c18_invalid_addrs_per_adl_i = NULL                                          => -0.0397238698,
                                                                                     0.0034539676);

final_score_185_c1100 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => -0.0178035536,
    f_validationrisktype_i > 1.5                                    => -0.0941506207,
    f_validationrisktype_i = NULL                                   => -0.0205547993,
                                                                       -0.0205547993);

final_score_185_c1103 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '3: Derog', '4: Recent Activity']) => 0.0193891757,
    (nf_seg_fraudpoint_3_0 in ['2: Synth ID', '5: Vuln Vic/Friendly', '6: Other'])      => 0.1064172646,
    nf_seg_fraudpoint_3_0 = ''                                                          => 0.0593510532,
                                                                                           0.0593510532);

final_score_185_c1102 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 10.5 => final_score_185_c1103,
    f_rel_under500miles_cnt_d > 10.5                                       => -0.0064299468,
    f_rel_under500miles_cnt_d = NULL                                       => 0.0179272497,
                                                                              0.0179272497);

final_score_185_c1101 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 4.5 => 0.0016748748,
    f_rel_homeover500_count_d > 4.5                                       => final_score_185_c1102,
    f_rel_homeover500_count_d = NULL                                      => 0.0025128764,
                                                                             0.0025128764);

final_score_185 := map(
    (nf_source_type in ['Behavioral and Government', 'Behavioral Only', 'Bureau and Government', 'Bureau Only', 'Government Only', 'None']) => final_score_185_c1100,
    (nf_source_type in ['Bureau and Behavioral', 'Bureau Behavioral and Government'])                                                       => final_score_185_c1101,
    nf_source_type = ''                                                                                                                   => 0.0034905043,
                                                                                                                                               -0.0014161538);

final_score_186_c1106 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 5.5 => 0.0251778605,
    r_wealth_index_d > 5.5                              => 0.0876112847,
    r_wealth_index_d = NULL                             => 0.0275791461,
                                                           0.0275791461);

final_score_186_c1105 := map(
    NULL < k_inq_adls_per_addr_i AND k_inq_adls_per_addr_i <= 0.5 => final_score_186_c1106,
    k_inq_adls_per_addr_i > 0.5                                   => -0.0071338036,
    k_inq_adls_per_addr_i = NULL                                  => 0.0085390626,
                                                                     0.0085390626);

final_score_186_c1108 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 0.5 => -0.1069911455,
    r_d30_derog_count_i > 0.5                                 => -0.0232264727,
    r_d30_derog_count_i = NULL                                => -0.0531123610,
                                                                 -0.0531123610);

final_score_186_c1107 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 385.5 => -0.0049409624,
    r_c21_m_bureau_adl_fs_d > 385.5                                     => final_score_186_c1108,
    r_c21_m_bureau_adl_fs_d = NULL                                      => -0.0066904119,
                                                                           -0.0066904119);

final_score_186 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 5.5 => final_score_186_c1105,
    f_rel_under25miles_cnt_d > 5.5                                      => final_score_186_c1107,
    f_rel_under25miles_cnt_d = NULL                                     => -0.0239080729,
                                                                           -0.0011953287);

final_score_187_c1112 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => -0.0481407396,
    f_phone_ver_experian_d > 0.5                                    => -0.0351135446,
    f_phone_ver_experian_d = NULL                                   => -0.0215289365,
                                                                       -0.0379071712);

final_score_187_c1111 := map(
    NULL < r_i60_inq_mortgage_recency_d AND r_i60_inq_mortgage_recency_d <= 549 => 0.0149927273,
    r_i60_inq_mortgage_recency_d > 549                                          => final_score_187_c1112,
    r_i60_inq_mortgage_recency_d = NULL                                         => -0.0254808813,
                                                                                   -0.0254808813);

final_score_187_c1110 := map(
    (nf_source_type in ['Behavioral and Government', 'Behavioral Only', 'Bureau and Government', 'Bureau Behavioral and Government', 'Bureau Only']) => final_score_187_c1111,
    (nf_source_type in ['Bureau and Behavioral', 'Government Only', 'None'])                                                                         => 0.0638991981,
    nf_source_type = ''                                                                                                                            => -0.0194960462,
                                                                                                                                                        -0.0194960462);

final_score_187_c1113 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 497.5 => 0.0037736989,
    r_c10_m_hdr_fs_d > 497.5                              => 0.0880913843,
    r_c10_m_hdr_fs_d = NULL                               => 0.0382007213,
                                                             0.0056544728);

final_score_187 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 255347 => 0.0015289681,
    r_a46_curr_avm_autoval_d > 255347                                      => final_score_187_c1110,
    r_a46_curr_avm_autoval_d = NULL                                        => final_score_187_c1113,
                                                                              0.0002467346);

final_score_188_c1116 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 7.5 => -0.0334312633,
    f_addrs_per_ssn_i > 7.5                               => 0.0121437885,
    f_addrs_per_ssn_i = NULL                              => -0.0056039565,
                                                             -0.0056039565);

final_score_188_c1115 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 77167 => final_score_188_c1116,
    r_a49_curr_avm_chg_1yr_i > 77167                                      => -0.0680854710,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => -0.0159181978,
                                                                             -0.0136115020);

final_score_188_c1118 := map(
    NULL < k_inq_adls_per_addr_i AND k_inq_adls_per_addr_i <= 3.5 => 0.0038841885,
    k_inq_adls_per_addr_i > 3.5                                   => 0.0986999662,
    k_inq_adls_per_addr_i = NULL                                  => 0.0062778729,
                                                                     0.0062778729);

final_score_188_c1117 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 82916.5 => 0.0030886693,
    r_a49_curr_avm_chg_1yr_i > 82916.5                                      => 0.0556661666,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => final_score_188_c1118,
                                                                               0.0061079859);

final_score_188 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 2.5 => final_score_188_c1115,
    f_phone_ver_insurance_d > 2.5                                     => final_score_188_c1117,
    f_phone_ver_insurance_d = NULL                                    => -0.0213951524,
                                                                         0.0008582570);

final_score_189_c1121 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 11.5 => 0.0013268079,
    k_inq_per_phone_i > 11.5                               => 0.0546103621,
    k_inq_per_phone_i = NULL                               => 0.0018137907,
                                                              0.0018137907);

final_score_189_c1123 := map(
    NULL < r_i60_inq_banking_recency_d AND r_i60_inq_banking_recency_d <= 549 => 0.0826113595,
    r_i60_inq_banking_recency_d > 549                                         => -0.0420556310,
    r_i60_inq_banking_recency_d = NULL                                        => 0.0231467699,
                                                                                 0.0231467699);

final_score_189_c1122 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 7.5 => 0.0803332183,
    f_rel_educationover12_count_d > 7.5                                           => final_score_189_c1123,
    f_rel_educationover12_count_d = NULL                                          => 0.0432937571,
                                                                                     0.0432937571);

final_score_189_c1120 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 83.95 => final_score_189_c1121,
    r_c12_source_profile_d > 83.95                                    => final_score_189_c1122,
    r_c12_source_profile_d = NULL                                     => 0.0026441062,
                                                                         0.0026441062);

final_score_189 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 28.5 => final_score_189_c1120,
    f_phones_per_addr_curr_i > 28.5                                      => 0.0915477424,
    f_phones_per_addr_curr_i = NULL                                      => -0.0194356255,
                                                                            0.0028721430);

final_score_190_c1128 := map(
    (nf_seg_fraudpoint_3_0 in ['2: Synth ID', '3: Derog', '5: Vuln Vic/Friendly', '6: Other']) => -0.0032225657,
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '4: Recent Activity'])                    => 0.1247922340,
    nf_seg_fraudpoint_3_0 = ''                                                                 => 0.0426861900,
                                                                                                  0.0426861900);

final_score_190_c1127 := map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 0.5 => final_score_190_c1128,
    f_rel_incomeover100_count_d > 0.5                                         => 0.1211017413,
    f_rel_incomeover100_count_d = NULL                                        => 0.0731259821,
                                                                                 0.0731259821);

final_score_190_c1126 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 2.5 => 0.0030030885,
    r_l79_adls_per_addr_curr_i > 2.5                                        => final_score_190_c1127,
    r_l79_adls_per_addr_curr_i = NULL                                       => 0.0305595524,
                                                                               0.0305595524);

final_score_190_c1125 := map(
    NULL < r_f04_curr_add_occ_index_d AND r_f04_curr_add_occ_index_d <= 2 => final_score_190_c1126,
    r_f04_curr_add_occ_index_d > 2                                        => -0.0042660145,
    r_f04_curr_add_occ_index_d = NULL                                     => 0.0108712347,
                                                                             0.0108712347);

final_score_190 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => -0.0058387103,
    r_f03_input_add_not_most_rec_i > 0.5                                            => final_score_190_c1125,
    r_f03_input_add_not_most_rec_i = NULL                                           => 0.0248413155,
                                                                                       -0.0030253319);

final_score_191_c1133 := map(
    NULL < f_divaddrsuspidcountnew_i AND f_divaddrsuspidcountnew_i <= 0.5 => 0.1293930995,
    f_divaddrsuspidcountnew_i > 0.5                                       => -0.0002578648,
    f_divaddrsuspidcountnew_i = NULL                                      => 0.0785332357,
                                                                             0.0785332357);

final_score_191_c1132 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 1.5 => 0.0007919057,
    f_idverrisktype_i > 1.5                               => final_score_191_c1133,
    f_idverrisktype_i = NULL                              => 0.0435084315,
                                                             0.0435084315);

final_score_191_c1131 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 1.5 => 0.0023979891,
    k_inq_per_phone_i > 1.5                               => final_score_191_c1132,
    k_inq_per_phone_i = NULL                              => 0.0051539420,
                                                             0.0051539420);

final_score_191_c1130 := map(
    NULL < r_i60_inq_count12_i AND r_i60_inq_count12_i <= 0.5 => final_score_191_c1131,
    r_i60_inq_count12_i > 0.5                                 => -0.0122770186,
    r_i60_inq_count12_i = NULL                                => -0.0043377835,
                                                                 -0.0043377835);

final_score_191 := map(
    NULL < f_mos_liens_rel_ot_fseen_d AND f_mos_liens_rel_ot_fseen_d <= 227.5 => final_score_191_c1130,
    f_mos_liens_rel_ot_fseen_d > 227.5                                        => 0.0957078990,
    f_mos_liens_rel_ot_fseen_d = NULL                                         => 0.0032495385,
                                                                                 -0.0035930477);

final_score_192_c1137 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 10.5 => -0.0029066291,
    r_l79_adls_per_addr_curr_i > 10.5                                        => 0.0614813667,
    r_l79_adls_per_addr_curr_i = NULL                                        => -0.0023257770,
                                                                                -0.0023257770);

final_score_192_c1136 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 23.5 => final_score_192_c1137,
    f_phones_per_addr_curr_i > 23.5                                      => -0.0515883787,
    f_phones_per_addr_curr_i = NULL                                      => -0.0026956163,
                                                                            -0.0026956163);

final_score_192_c1138 := map(
    NULL < f_rel_count_i AND f_rel_count_i <= 8.5 => 0.1164430035,
    f_rel_count_i > 8.5                           => 0.0089889253,
    f_rel_count_i = NULL                          => 0.0346029788,
                                                     0.0346029788);

final_score_192_c1135 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 3.5 => final_score_192_c1136,
    r_e57_br_source_count_d > 3.5                                     => final_score_192_c1138,
    r_e57_br_source_count_d = NULL                                    => -0.0037898797,
                                                                         -0.0016784566);

final_score_192 := map(
    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i <= 3.5 => final_score_192_c1135,
    k_inq_addrs_per_ssn_i > 3.5                                   => 0.1052398606,
    k_inq_addrs_per_ssn_i = NULL                                  => -0.0011041771,
                                                                     -0.0011041771);

final_score_193_c1143 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 1.5 => 0.1443341259,
    f_srchvelocityrisktype_i > 1.5                                      => 0.0366877151,
    f_srchvelocityrisktype_i = NULL                                     => 0.0576341402,
                                                                           0.0576341402);

final_score_193_c1142 := map(
    NULL < f_assoccredbureaucount_i AND f_assoccredbureaucount_i <= 0.5 => 0.0086653585,
    f_assoccredbureaucount_i > 0.5                                      => final_score_193_c1143,
    f_assoccredbureaucount_i = NULL                                     => 0.0187421517,
                                                                           0.0187421517);

final_score_193_c1141 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 18.5 => -0.0021476695,
    r_p88_phn_dst_to_inp_add_i > 18.5                                        => 0.0384615230,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => final_score_193_c1142,
                                                                                0.0042318890);

final_score_193_c1140 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 10.5 => final_score_193_c1141,
    f_rel_homeover500_count_d > 10.5                                       => 0.0679691287,
    f_rel_homeover500_count_d = NULL                                       => 0.0050362572,
                                                                              0.0050362572);

final_score_193 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 20.5 => -0.0249912579,
    f_prevaddrlenofres_d > 20.5                                  => final_score_193_c1140,
    f_prevaddrlenofres_d = NULL                                  => 0.0185806880,
                                                                    -0.0017304417);

final_score_194_c1147 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 121 => 0.0619175715,
    r_a49_curr_avm_chg_1yr_pct_i > 121                                          => -0.0467648962,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                         => 0.0548986610,
                                                                                   0.0377197707);

final_score_194_c1146 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 6.5 => 0.0033702153,
    f_rel_homeover500_count_d > 6.5                                       => final_score_194_c1147,
    f_rel_homeover500_count_d = NULL                                      => 0.0041200887,
                                                                             0.0045526164);

final_score_194_c1145 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 5.5 => final_score_194_c1146,
    r_c18_invalid_addrs_per_adl_i > 5.5                                           => -0.0362124539,
    r_c18_invalid_addrs_per_adl_i = NULL                                          => -0.0188694775,
                                                                                     0.0000655743);

final_score_194_c1148 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 46.5 => 0.0149193549,
    r_c13_curr_addr_lres_d > 46.5                                    => -0.1079991593,
    r_c13_curr_addr_lres_d = NULL                                    => -0.0612757474,
                                                                        -0.0612757474);

final_score_194 := map(
    NULL < r_l70_add_invalid_i AND r_l70_add_invalid_i <= 0.5 => final_score_194_c1145,
    r_l70_add_invalid_i > 0.5                                 => final_score_194_c1148,
    r_l70_add_invalid_i = NULL                                => -0.0010640461,
                                                                 -0.0010640461);

final_score_195_c1152 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 224.5 => -0.0371789585,
    f_prevaddrlenofres_d > 224.5                                  => -0.1002290152,
    f_prevaddrlenofres_d = NULL                                   => -0.0491246717,
                                                                     -0.0491246717);

final_score_195_c1153 := map(
    (nf_seg_fraudpoint_3_0 in ['3: Derog', '4: Recent Activity'])                                        => -0.0328818538,
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '5: Vuln Vic/Friendly', '6: Other']) => 0.0907572951,
    nf_seg_fraudpoint_3_0 = ''                                                                            => 0.0031795646,
                                                                                                            0.0031795646);

final_score_195_c1151 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 13.5 => final_score_195_c1152,
    f_addrs_per_ssn_i > 13.5                               => final_score_195_c1153,
    f_addrs_per_ssn_i = NULL                               => -0.0343370865,
                                                              -0.0343370865);

final_score_195_c1150 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 272366 => -0.0079157918,
    r_l80_inp_avm_autoval_d > 272366                                     => final_score_195_c1151,
    r_l80_inp_avm_autoval_d = NULL                                       => -0.0041160730,
                                                                            -0.0101143599);

final_score_195 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 0.5 => 0.0090585008,
    k_inq_lnames_per_addr_i > 0.5                                     => final_score_195_c1150,
    k_inq_lnames_per_addr_i = NULL                                    => -0.0021863759,
                                                                         -0.0021863759);

final_score_196_c1156 := map(
    NULL < f_accident_count_i AND f_accident_count_i <= 2.5 => 0.0151418796,
    f_accident_count_i > 2.5                                => 0.1345567867,
    f_accident_count_i = NULL                               => 0.0184021574,
                                                               0.0184021574);

final_score_196_c1155 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= -1002.5 => -0.0274483511,
    r_a49_curr_avm_chg_1yr_i > -1002.5                                      => final_score_196_c1156,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => 0.0062748722,
                                                                               0.0062748722);

final_score_196_c1158 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => -0.0061372655,
    r_f03_input_add_not_most_rec_i > 0.5                                            => 0.1015905202,
    r_f03_input_add_not_most_rec_i = NULL                                           => -0.0039113740,
                                                                                       -0.0039113740);

final_score_196_c1157 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 5.5 => final_score_196_c1158,
    f_addrchangeecontrajindex_d > 5.5                                         => 0.0671246154,
    f_addrchangeecontrajindex_d = NULL                                        => -0.0039226806,
                                                                                 -0.0030472971);

final_score_196 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= -59961.5 => 0.0820076012,
    r_a49_curr_avm_chg_1yr_i > -59961.5                                      => final_score_196_c1155,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => final_score_196_c1157,
                                                                                0.0019580415);

final_score_197_c1163 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= -49672.5 => 0.1179619133,
    r_a49_curr_avm_chg_1yr_i > -49672.5                                      => 0.0102860490,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => 0.0081097796,
                                                                                0.0107192064);

final_score_197_c1162 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_197_c1163,
    f_phone_ver_insurance_d > 3.5                                     => -0.0079569360,
    f_phone_ver_insurance_d = NULL                                    => -0.0007097602,
                                                                         -0.0007097602);

final_score_197_c1161 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 0.5 => -0.0901586633,
    f_phone_ver_insurance_d > 0.5                                     => final_score_197_c1162,
    f_phone_ver_insurance_d = NULL                                    => -0.0022243332,
                                                                         -0.0022243332);

final_score_197_c1160 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 47.5 => final_score_197_c1161,
    f_rel_under500miles_cnt_d > 47.5                                       => -0.0973239442,
    f_rel_under500miles_cnt_d = NULL                                       => 0.0005305089,
                                                                              -0.0026974493);

final_score_197 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 532.5 => final_score_197_c1160,
    r_c10_m_hdr_fs_d > 532.5                              => -0.0548292562,
    r_c10_m_hdr_fs_d = NULL                               => -0.0411020446,
                                                             -0.0035710592);

final_score_198_c1167 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 90102.5 => -0.0079251741,
    r_a49_curr_avm_chg_1yr_i > 90102.5                                      => 0.0641190843,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => -0.0200370735,
                                                                               -0.0129205651);

final_score_198_c1166 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => final_score_198_c1167,
    r_i61_inq_collection_recency_d > 549                                            => 0.0137800363,
    r_i61_inq_collection_recency_d = NULL                                           => -0.0028847067,
                                                                                       -0.0028847067);

final_score_198_c1165 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 381.5 => final_score_198_c1166,
    f_m_bureau_adl_fs_notu_d > 381.5                                      => 0.0782972652,
    f_m_bureau_adl_fs_notu_d = NULL                                       => -0.0018780740,
                                                                             -0.0018780740);

final_score_198_c1168 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 256446 => -0.0141785888,
    r_l80_inp_avm_autoval_d > 256446                                     => -0.0769773064,
    r_l80_inp_avm_autoval_d = NULL                                       => 0.0053144462,
                                                                            -0.0224549865);

final_score_198 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 384.5 => final_score_198_c1165,
    f_m_bureau_adl_fs_notu_d > 384.5                                      => final_score_198_c1168,
    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0188928818,
                                                                             -0.0025866935);

final_score_199_c1171 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 6.5 => -0.0023276046,
    f_varrisktype_i > 6.5                             => 0.0496567803,
    f_varrisktype_i = NULL                            => -0.0013269312,
                                                         -0.0013269312);

final_score_199_c1170 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 4.5 => final_score_199_c1171,
    r_c23_inp_addr_occ_index_d > 4.5                                        => -0.1150464009,
    r_c23_inp_addr_occ_index_d = NULL                                       => -0.0023278692,
                                                                               -0.0023278692);

final_score_199_c1173 := map(
    NULL < (real)k_inf_addr_verd_d AND (real)k_inf_addr_verd_d <= 0.5 		=> 0.0482596857,
    (real)k_inf_addr_verd_d > 0.5                               					=> 0.2291595944,
    (real)k_inf_addr_verd_d = NULL                              					=> 0.1044792062,
																																							0.1044792062);

final_score_199_c1172 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_199_c1173,
    r_phn_cell_n > 0.5                          => -0.0136760517,
    r_phn_cell_n = NULL                         => 0.0315242818,
                                                   0.0315242818);

final_score_199 := map(
    NULL < f_hh_college_attendees_d AND f_hh_college_attendees_d <= 1.5 => final_score_199_c1170,
    f_hh_college_attendees_d > 1.5                                      => final_score_199_c1172,
    f_hh_college_attendees_d = NULL                                     => -0.0251362478,
                                                                           -0.0006800104);

final_score_200_c1176 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 213979 => -0.0096972771,
    r_a46_curr_avm_autoval_d > 213979                                      => -0.0377146230,
    r_a46_curr_avm_autoval_d = NULL                                        => -0.0017883553,
                                                                              -0.0126045474);

final_score_200_c1175 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 283.5 => 0.0048344285,
    r_c21_m_bureau_adl_fs_d > 283.5                                     => final_score_200_c1176,
    r_c21_m_bureau_adl_fs_d = NULL                                      => 0.0169181392,
                                                                           -0.0015178761);

final_score_200_c1178 := map(
    NULL < f_crim_rel_under100miles_cnt_i AND f_crim_rel_under100miles_cnt_i <= 0.5 => 0.0535957829,
    f_crim_rel_under100miles_cnt_i > 0.5                                            => -0.0174836508,
    f_crim_rel_under100miles_cnt_i = NULL                                           => 0.0064577753,
                                                                                       0.0064577753);

final_score_200_c1177 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 79.4 => final_score_200_c1178,
    r_c12_source_profile_d > 79.4                                    => 0.0962070102,
    r_c12_source_profile_d = NULL                                    => 0.0198973815,
                                                                        0.0198973815);

final_score_200 := map(
    NULL < f_bus_fname_verd_d AND f_bus_fname_verd_d <= 0.5 => final_score_200_c1175,
    f_bus_fname_verd_d > 0.5                                => final_score_200_c1177,
    f_bus_fname_verd_d = NULL                               => -0.0006211221,
                                                               -0.0006211221);

final_score_201_c1182 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 4.5 => 0.0595673336,
    f_inq_count24_i > 4.5                             => -0.0451348100,
    f_inq_count24_i = NULL                            => 0.0293911700,
                                                         0.0293911700);

final_score_201_c1181 := map(
    NULL < f_accident_count_i AND f_accident_count_i <= 1.5 => -0.0030677909,
    f_accident_count_i > 1.5                                => final_score_201_c1182,
    f_accident_count_i = NULL                               => -0.0010026961,
                                                               -0.0010026961);

final_score_201_c1183 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 33.5 => -0.0753696691,
    r_c21_m_bureau_adl_fs_d > 33.5                                     => 0.0690181879,
    r_c21_m_bureau_adl_fs_d = NULL                                     => -0.0281840949,
                                                                          -0.0281840949);

final_score_201_c1180 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 0.5 => 0.0983424879,
    f_rel_under500miles_cnt_d > 0.5                                       => final_score_201_c1181,
    f_rel_under500miles_cnt_d = NULL                                      => final_score_201_c1183,
                                                                             -0.0007801739);

final_score_201 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 45 => -0.0774269564,
    r_f00_ssn_score_d > 45                               => final_score_201_c1180,
    r_f00_ssn_score_d = NULL                             => 0.0285790491,
                                                            -0.0011826153);

final_score_202_c1186 := map(
    NULL < (real)k_nap_lname_verd_d AND (real)k_nap_lname_verd_d <= 0.5 		=> 0.0240943014,
    (real)k_nap_lname_verd_d > 0.5                                					=> -0.0053064014,
    (real)k_nap_lname_verd_d = NULL                               					=> -0.0025317939,
																																								-0.0025317939);

final_score_202_c1185 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 501.5 => final_score_202_c1186,
    f_m_bureau_adl_fs_all_d > 501.5                                     => 0.0511241215,
    f_m_bureau_adl_fs_all_d = NULL                                      => -0.0002119881,
                                                                           -0.0018754708);

final_score_202_c1188 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 11.5 => -0.0414337603,
    f_addrs_per_ssn_i > 11.5                               => 0.0350492931,
    f_addrs_per_ssn_i = NULL                               => -0.0029210171,
                                                              -0.0029210171);

final_score_202_c1187 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 253.5 => 0.0901345078,
    r_c10_m_hdr_fs_d > 253.5                              => final_score_202_c1188,
    r_c10_m_hdr_fs_d = NULL                               => 0.0326351333,
                                                             0.0326351333);

final_score_202 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i <= 0.5 => final_score_202_c1185,
    r_p85_phn_disconnected_i > 0.5                                      => final_score_202_c1187,
    r_p85_phn_disconnected_i = NULL                                     => -0.0010114242,
                                                                           -0.0010114242);

final_score_203_c1192 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 1.5 => 0.0669198830,
    f_rel_educationover12_count_d > 1.5                                           => -0.0167502797,
    f_rel_educationover12_count_d = NULL                                          => -0.0137533022,
                                                                                     -0.0137533022);

final_score_203_c1193 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => -0.0609028682,
    f_phone_ver_experian_d > 0.5                                    => -0.0437606813,
    f_phone_ver_experian_d = NULL                                   => -0.0517210580,
                                                                       -0.0517210580);

final_score_203_c1191 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => final_score_203_c1192,
    r_f03_input_add_not_most_rec_i > 0.5                                            => final_score_203_c1193,
    r_f03_input_add_not_most_rec_i = NULL                                           => -0.0184264228,
                                                                                       -0.0184264228);

final_score_203_c1190 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 247.5 => 0.0026792186,
    r_c13_max_lres_d > 247.5                              => final_score_203_c1191,
    r_c13_max_lres_d = NULL                               => -0.0013248699,
                                                             -0.0013248699);

final_score_203 := map(
    NULL < f_mos_liens_rel_ot_fseen_d AND f_mos_liens_rel_ot_fseen_d <= 232.5 => final_score_203_c1190,
    f_mos_liens_rel_ot_fseen_d > 232.5                                        => 0.0882421089,
    f_mos_liens_rel_ot_fseen_d = NULL                                         => 0.0166275774,
                                                                                 -0.0006194252);

final_score_204_c1196 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 393.5 => -0.0053485398,
    f_prevaddrlenofres_d > 393.5                                  => 0.0532502471,
    f_prevaddrlenofres_d = NULL                                   => -0.0047492120,
                                                                     -0.0047492120);

final_score_204_c1198 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => 0.1236261200,
    f_phone_ver_insurance_d > 3.5                                     => 0.0631862799,
    f_phone_ver_insurance_d = NULL                                    => 0.0876039753,
                                                                         0.0876039753);

final_score_204_c1197 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 2.5 => final_score_204_c1198,
    f_varrisktype_i > 2.5                             => -0.0490999314,
    f_varrisktype_i = NULL                            => 0.0432675731,
                                                         0.0432675731);

final_score_204_c1195 := map(
    NULL < f_phones_per_addr_c6_i AND f_phones_per_addr_c6_i <= 4.5 => final_score_204_c1196,
    f_phones_per_addr_c6_i > 4.5                                    => final_score_204_c1197,
    f_phones_per_addr_c6_i = NULL                                   => -0.0037917745,
                                                                       -0.0037917745);

final_score_204 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 478.5 => final_score_204_c1195,
    r_c13_curr_addr_lres_d > 478.5                                    => -0.0706236373,
    r_c13_curr_addr_lres_d = NULL                                     => -0.0407114727,
                                                                         -0.0045125028);

final_score_205_c1201 := map(
    NULL < r_l78_no_phone_at_addr_vel_i AND r_l78_no_phone_at_addr_vel_i <= 0.5 => -0.0049583861,
    r_l78_no_phone_at_addr_vel_i > 0.5                                          => -0.0626041204,
    r_l78_no_phone_at_addr_vel_i = NULL                                         => -0.0068345634,
                                                                                   -0.0068345634);

final_score_205_c1200 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 445.5 => final_score_205_c1201,
    r_c13_curr_addr_lres_d > 445.5                                    => 0.0693292917,
    r_c13_curr_addr_lres_d = NULL                                     => -0.0058407405,
                                                                         -0.0058407405);

final_score_205_c1203 := map(
    NULL < (real)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d <= 0.5 => 0.1292370388,
    (real)k_nap_phn_verd_d > 0.5                              => 0.0418581631,
    (real)k_nap_phn_verd_d = NULL                             => 0.0725221785,
                                                           0.0725221785);

final_score_205_c1202 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 7.5 => final_score_205_c1203,
    f_rel_educationover12_count_d > 7.5                                           => -0.0068123393,
    f_rel_educationover12_count_d = NULL                                          => 0.0227887206,
                                                                                     0.0227887206);

final_score_205 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 135.35 => final_score_205_c1200,
    r_a49_curr_avm_chg_1yr_pct_i > 135.35                                          => final_score_205_c1202,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => 0.0008574211,
                                                                                      -0.0009136883);

final_score_206_c1208 := map(
    NULL < r_c12_num_nonderogs_d AND r_c12_num_nonderogs_d <= 3.5 => 0.0155892527,
    r_c12_num_nonderogs_d > 3.5                                   => -0.0138064448,
    r_c12_num_nonderogs_d = NULL                                  => -0.0015242233,
                                                                     -0.0015242233);

final_score_206_c1207 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 398.5 => final_score_206_c1208,
    f_prevaddrlenofres_d > 398.5                                  => 0.0655015352,
    f_prevaddrlenofres_d = NULL                                   => -0.0001161191,
                                                                     -0.0001161191);

final_score_206_c1206 := map(
    NULL < f_property_owners_ct_d AND f_property_owners_ct_d <= 4.5 => final_score_206_c1207,
    f_property_owners_ct_d > 4.5                                    => -0.0768133686,
    f_property_owners_ct_d = NULL                                   => -0.0021730628,
                                                                       -0.0021730628);

final_score_206_c1205 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 4.5 => final_score_206_c1206,
    r_e57_br_source_count_d > 4.5                                     => 0.0811002197,
    r_e57_br_source_count_d = NULL                                    => -0.0005142716,
                                                                         -0.0005142716);

final_score_206 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 186515.5 => final_score_206_c1205,
    r_a49_curr_avm_chg_1yr_i > 186515.5                                      => 0.0699804794,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => 0.0002796898,
                                                                                0.0003031999);

final_score_207_c1211 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => 0.0056308363,
    r_f03_input_add_not_most_rec_i > 0.5                                            => 0.0868480963,
    r_f03_input_add_not_most_rec_i = NULL                                           => 0.0067978961,
                                                                                       0.0067978961);

final_score_207_c1213 := map(
    NULL < r_i60_inq_auto_recency_d AND r_i60_inq_auto_recency_d <= 549 => 0.0109737895,
    r_i60_inq_auto_recency_d > 549                                      => 0.0967755501,
    r_i60_inq_auto_recency_d = NULL                                     => 0.0465945204,
                                                                           0.0465945204);

final_score_207_c1212 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 2.5 => -0.0156360270,
    k_inq_per_phone_i > 2.5                               => final_score_207_c1213,
    k_inq_per_phone_i = NULL                              => -0.0076855506,
                                                             -0.0076855506);

final_score_207_c1210 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 5.5 => final_score_207_c1211,
    f_addrchangeecontrajindex_d > 5.5                                         => -0.0325551481,
    f_addrchangeecontrajindex_d = NULL                                        => final_score_207_c1212,
                                                                                 0.0039735189);

final_score_207 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 11.5 => final_score_207_c1210,
    f_rel_homeover300_count_d > 11.5                                       => -0.0314774332,
    f_rel_homeover300_count_d = NULL                                       => 0.0196499327,
                                                                              0.0025054809);

final_score_208_c1217 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 4.5 => 0.1015412342,
    f_rel_under500miles_cnt_d > 4.5                                       => 0.0312746952,
    f_rel_under500miles_cnt_d = NULL                                      => 0.0431597783,
                                                                             0.0431597783);

final_score_208_c1216 := map(
    (nf_seg_fraudpoint_3_0 in ['2: Synth ID', '3: Derog', '4: Recent Activity', '6: Other']) => final_score_208_c1217,
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '5: Vuln Vic/Friendly'])                => 0.1462471304,
    nf_seg_fraudpoint_3_0 = ''                                                               => 0.0550029806,
                                                                                                0.0550029806);

final_score_208_c1218 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 11.5 => 0.0027012686,
    f_rel_homeover300_count_d > 11.5                                       => -0.1295824678,
    f_rel_homeover300_count_d = NULL                                       => -0.0062358235,
                                                                              -0.0062358235);

final_score_208_c1215 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 0.5 => final_score_208_c1216,
    k_inq_adls_per_phone_i > 0.5                                    => final_score_208_c1218,
    k_inq_adls_per_phone_i = NULL                                   => 0.0155403906,
                                                                       0.0155403906);

final_score_208 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 3.5 => -0.0050795167,
    k_inq_per_ssn_i > 3.5                             => final_score_208_c1215,
    k_inq_per_ssn_i = NULL                            => -0.0019923430,
                                                         -0.0019923430);

final_score_209_c1222 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 62.65 => -0.0190604450,
    r_c12_source_profile_d > 62.65                                    => 0.0351972635,
    r_c12_source_profile_d = NULL                                     => -0.0090973336,
                                                                         -0.0090973336);

final_score_209_c1221 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 98 => 0.0388125121,
    r_f00_dob_score_d > 98                               => final_score_209_c1222,
    r_f00_dob_score_d = NULL                             => 0.0636812167,
                                                            -0.0061272283);

final_score_209_c1223 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 0.5 => -0.0607625183,
    r_e57_br_source_count_d > 0.5                                     => -0.0117345890,
    r_e57_br_source_count_d = NULL                                    => -0.0278587841,
                                                                         -0.0278587841);

final_score_209_c1220 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 277.5 => final_score_209_c1221,
    r_c21_m_bureau_adl_fs_d > 277.5                                     => final_score_209_c1223,
    r_c21_m_bureau_adl_fs_d = NULL                                      => -0.0148106618,
                                                                           -0.0148106618);

final_score_209 := map(
    NULL < f_crim_rel_under500miles_cnt_i AND f_crim_rel_under500miles_cnt_i <= 1.5 => final_score_209_c1220,
    f_crim_rel_under500miles_cnt_i > 1.5                                            => 0.0058161135,
    f_crim_rel_under500miles_cnt_i = NULL                                           => 0.0239165959,
                                                                                       -0.0035224756);

final_score_210_c1226 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 7.5 => 0.1093355562,
    f_rel_under500miles_cnt_d > 7.5                                       => 0.0123696228,
    f_rel_under500miles_cnt_d = NULL                                      => 0.0507323586,
                                                                             0.0507323586);

final_score_210_c1227 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 1.5 => -0.0348455416,
    f_rel_under25miles_cnt_d > 1.5                                      => 0.0118410897,
    f_rel_under25miles_cnt_d = NULL                                     => 0.0084957204,
                                                                           0.0084957204);

final_score_210_c1228 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i <= 0.5 => -0.0064554568,
    r_p85_phn_disconnected_i > 0.5                                      => 0.0526725343,
    r_p85_phn_disconnected_i = NULL                                     => -0.0053074671,
                                                                           -0.0053074671);

final_score_210_c1225 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= -31944 => final_score_210_c1226,
    r_a49_curr_avm_chg_1yr_i > -31944                                      => final_score_210_c1227,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => final_score_210_c1228,
                                                                              0.0020662199);

final_score_210 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 5.5 => final_score_210_c1225,
    r_l79_adls_per_addr_curr_i > 5.5                                        => -0.0255876117,
    r_l79_adls_per_addr_curr_i = NULL                                       => -0.0463547237,
                                                                               -0.0012584043);

final_score_211_c1232 := map(
    NULL < k_inq_adls_per_ssn_i AND k_inq_adls_per_ssn_i <= 0.5 => 0.0985772539,
    k_inq_adls_per_ssn_i > 0.5                                  => -0.0085659202,
    k_inq_adls_per_ssn_i = NULL                                 => 0.0508435962,
                                                                   0.0508435962);

final_score_211_c1231 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 39864.5 => 0.0007119600,
    r_a49_curr_avm_chg_1yr_i > 39864.5                                      => final_score_211_c1232,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => 0.0028151025,
                                                                               0.0028151025);

final_score_211_c1233 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 8.5 => -0.0027546576,
    k_inq_per_phone_i > 8.5                               => 0.0669282601,
    k_inq_per_phone_i = NULL                              => -0.0015089451,
                                                             -0.0015089451);

final_score_211_c1230 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 48308.5 => final_score_211_c1231,
    r_a49_curr_avm_chg_1yr_i > 48308.5                                      => -0.0238832318,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => final_score_211_c1233,
                                                                               -0.0011439428);

final_score_211 := map(
    NULL < r_f00_input_dob_match_level_d AND r_f00_input_dob_match_level_d <= 3.5 => 0.0728190478,
    r_f00_input_dob_match_level_d > 3.5                                           => final_score_211_c1230,
    r_f00_input_dob_match_level_d = NULL                                          => 0.0288389213,
                                                                                     -0.0003246207);

final_score_212_c1238 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 18.5 => -0.0717748609,
    f_prevaddrageoldest_d > 18.5                                   => 0.0301386652,
    f_prevaddrageoldest_d = NULL                                   => 0.0131147354,
                                                                      0.0131147354);

final_score_212_c1237 := map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i <= 3.5 => final_score_212_c1238,
    k_inq_per_addr_i > 3.5                              => -0.0358721526,
    k_inq_per_addr_i = NULL                             => 0.0018690498,
                                                           0.0018690498);

final_score_212_c1236 := map(
    NULL < f_rel_count_i AND f_rel_count_i <= 9.5 => 0.0720157752,
    f_rel_count_i > 9.5                           => final_score_212_c1237,
    f_rel_count_i = NULL                          => 0.0101500737,
                                                     0.0101500737);

final_score_212_c1235 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 6.5 => -0.0056516908,
    f_rel_homeover300_count_d > 6.5                                       => final_score_212_c1236,
    f_rel_homeover300_count_d = NULL                                      => -0.0087943862,
                                                                             -0.0034778216);

final_score_212 := map(
    NULL < f_srchphonesrchcountmo_i AND f_srchphonesrchcountmo_i <= 2.5 => final_score_212_c1235,
    f_srchphonesrchcountmo_i > 2.5                                      => -0.0771573592,
    f_srchphonesrchcountmo_i = NULL                                     => -0.0004287963,
                                                                           -0.0040546597);

final_score_213_c1240 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 111.5 => 0.0194976073,
    r_c13_max_lres_d > 111.5                              => 0.1448382444,
    r_c13_max_lres_d = NULL                               => 0.0478766195,
                                                             0.0478766195);

final_score_213_c1242 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 11.5 => 0.0001565580,
    r_l79_adls_per_addr_curr_i > 11.5                                        => -0.0721270612,
    r_l79_adls_per_addr_curr_i = NULL                                        => -0.0003166505,
                                                                                -0.0003166505);

final_score_213_c1243 := map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 11.5 => -0.1208140175,
    f_rel_homeover50_count_d > 11.5                                      => -0.0139235535,
    f_rel_homeover50_count_d = NULL                                      => -0.0663790590,
                                                                            -0.0663790590);

final_score_213_c1241 := map(
    NULL < nf_inq_per_add_nas_479 AND nf_inq_per_add_nas_479 <= 0.5 => final_score_213_c1242,
    nf_inq_per_add_nas_479 > 0.5                                    => final_score_213_c1243,
    nf_inq_per_add_nas_479 = NULL                                   => -0.0011091511,
                                                                       -0.0011091511);

final_score_213 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 0.5 => final_score_213_c1240,
    f_prevaddrlenofres_d > 0.5                                  => final_score_213_c1241,
    f_prevaddrlenofres_d = NULL                                 => 0.0249564457,
                                                                   0.0006504667);

final_score_214_c1248 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 3.5 => 0.0129082187,
    r_wealth_index_d > 3.5                              => 0.0744553073,
    r_wealth_index_d = NULL                             => 0.0446020245,
                                                           0.0446020245);

final_score_214_c1247 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 2.5 => final_score_214_c1248,
    f_rel_homeover500_count_d > 2.5                                       => 0.1096404629,
    f_rel_homeover500_count_d = NULL                                      => 0.0515195281,
                                                                             0.0515195281);

final_score_214_c1246 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 42.5 => -0.0161171135,
    f_prevaddrlenofres_d > 42.5                                  => final_score_214_c1247,
    f_prevaddrlenofres_d = NULL                                  => 0.0255105696,
                                                                    0.0255105696);

final_score_214_c1245 := map(
    NULL < f_crim_rel_under500miles_cnt_i AND f_crim_rel_under500miles_cnt_i <= 5.5 => final_score_214_c1246,
    f_crim_rel_under500miles_cnt_i > 5.5                                            => -0.0244068411,
    f_crim_rel_under500miles_cnt_i = NULL                                           => 0.0094128443,
                                                                                       0.0094128443);

final_score_214 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 0.5 => -0.0067060030,
    r_d32_criminal_count_i > 0.5                                    => final_score_214_c1245,
    r_d32_criminal_count_i = NULL                                   => 0.0504442594,
                                                                       -0.0022503181);

final_score_215_c1253 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 1.5 => 0.0425894290,
    f_rel_homeover500_count_d > 1.5                                       => -0.0775474059,
    f_rel_homeover500_count_d = NULL                                      => 0.0298514278,
                                                                             0.0298514278);

final_score_215_c1252 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 297268.5 => final_score_215_c1253,
    r_l80_inp_avm_autoval_d > 297268.5                                     => 0.0550679117,
    r_l80_inp_avm_autoval_d = NULL                                         => 0.0029580988,
                                                                              0.0182904126);

final_score_215_c1251 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => -0.0005119261,
    r_f03_input_add_not_most_rec_i > 0.5                                            => final_score_215_c1252,
    r_f03_input_add_not_most_rec_i = NULL                                           => 0.0022717062,
                                                                                       0.0022717062);

final_score_215_c1250 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 454.5 => final_score_215_c1251,
    r_c13_curr_addr_lres_d > 454.5                                    => -0.0631308068,
    r_c13_curr_addr_lres_d = NULL                                     => -0.0191280805,
                                                                         0.0016108378);

final_score_215 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 2.5 => final_score_215_c1250,
    k_inq_adls_per_phone_i > 2.5                                    => -0.0633105675,
    k_inq_adls_per_phone_i = NULL                                   => 0.0009427521,
                                                                       0.0009427521);

final_score_216_c1257 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => 0.0226282680,
    r_phn_pcs_n > 0.5                         => -0.0254507129,
    r_phn_pcs_n = NULL                        => 0.0054261728,
                                                 0.0054261728);

final_score_216_c1256 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_216_c1257,
    r_phn_cell_n > 0.5                          => -0.0093989026,
    r_phn_cell_n = NULL                         => -0.0029939656,
                                                   -0.0029939656);

final_score_216_c1258 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 9.5 => 0.0056767172,
    f_rel_homeover100_count_d > 9.5                                       => 0.1062422939,
    f_rel_homeover100_count_d = NULL                                      => 0.0566953513,
                                                                             0.0566953513);

final_score_216_c1255 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 2.5 => final_score_216_c1256,
    f_srchunvrfdphonecount_i > 2.5                                      => final_score_216_c1258,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0022792469,
                                                                           -0.0022792469);

final_score_216 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 33.5 => -0.0463124232,
    r_c21_m_bureau_adl_fs_d > 33.5                                     => final_score_216_c1255,
    r_c21_m_bureau_adl_fs_d = NULL                                     => -0.0275280129,
                                                                          -0.0055371868);

final_score_217_c1262 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 15.5 => -0.0142734894,
    f_rel_under500miles_cnt_d > 15.5                                       => -0.1008867735,
    f_rel_under500miles_cnt_d = NULL                                       => -0.0356497113,
                                                                              -0.0356497113);

final_score_217_c1261 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 67623.5 => -0.0017669417,
    r_a49_curr_avm_chg_1yr_i > 67623.5                                      => final_score_217_c1262,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => -0.0040238815,
                                                                               -0.0040238815);

final_score_217_c1263 := map(
    NULL < f_hh_collections_ct_i AND f_hh_collections_ct_i <= 1.5 => 0.1380790082,
    f_hh_collections_ct_i > 1.5                                   => -0.0040180268,
    f_hh_collections_ct_i = NULL                                  => 0.0587414970,
                                                                     0.0587414970);

final_score_217_c1260 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => final_score_217_c1261,
    f_srchunvrfdaddrcount_i > 0.5                                     => final_score_217_c1263,
    f_srchunvrfdaddrcount_i = NULL                                    => -0.0022541810,
                                                                         -0.0022541810);

final_score_217 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 185500 => final_score_217_c1260,
    r_a49_curr_avm_chg_1yr_i > 185500                                      => 0.0677828599,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => 0.0006447384,
                                                                              -0.0003009179);

final_score_218_c1268 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 2.5 => 0.0987901018,
    f_rel_incomeover50_count_d > 2.5                                        => 0.0234908831,
    f_rel_incomeover50_count_d = NULL                                       => 0.0309511756,
                                                                               0.0309511756);

final_score_218_c1267 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 3.5 => 0.0054903916,
    f_addrchangeecontrajindex_d > 3.5                                         => final_score_218_c1268,
    f_addrchangeecontrajindex_d = NULL                                        => -0.0093414452,
                                                                                 0.0074151795);

final_score_218_c1266 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 0.5 => final_score_218_c1267,
    k_inq_ssns_per_addr_i > 0.5                                   => -0.0113305678,
    k_inq_ssns_per_addr_i = NULL                                  => -0.0021152086,
                                                                     -0.0021152086);

final_score_218_c1265 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 4.5 => final_score_218_c1266,
    k_inq_lnames_per_addr_i > 4.5                                     => 0.0588129574,
    k_inq_lnames_per_addr_i = NULL                                    => -0.0017234193,
                                                                         -0.0017234193);

final_score_218 := map(
    NULL < f_divaddrsuspidcountnew_i AND f_divaddrsuspidcountnew_i <= 4.5 => final_score_218_c1265,
    f_divaddrsuspidcountnew_i > 4.5                                       => -0.0604337924,
    f_divaddrsuspidcountnew_i = NULL                                      => 0.0261977726,
                                                                             -0.0017834495);

final_score_219_c1270 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 73703.5 => 0.0020670643,
    r_a49_curr_avm_chg_1yr_i > 73703.5                                      => -0.0783329075,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => 0.0006523731,
                                                                               0.0006523731);

final_score_219_c1273 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 1.5 => 0.1572177243,
    f_assocsuspicousidcount_i > 1.5                                       => 0.0558009870,
    f_assocsuspicousidcount_i = NULL                                      => 0.1037434447,
                                                                             0.1037434447);

final_score_219_c1272 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 3.5 => -0.0023642693,
    f_rel_incomeover75_count_d > 3.5                                        => final_score_219_c1273,
    f_rel_incomeover75_count_d = NULL                                       => 0.0612425347,
                                                                               0.0612425347);

final_score_219_c1271 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 257.5 => final_score_219_c1272,
    r_c13_max_lres_d > 257.5                              => -0.0413251152,
    r_c13_max_lres_d = NULL                               => 0.0364482888,
                                                             0.0364482888);

final_score_219 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 85562.5 => final_score_219_c1270,
    r_a49_curr_avm_chg_1yr_i > 85562.5                                      => final_score_219_c1271,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => -0.0009629566,
                                                                               0.0006938876);

final_score_220_c1276 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 2.5 => 0.0978005785,
    f_addrchangeecontrajindex_d > 2.5                                         => 0.1009457345,
    f_addrchangeecontrajindex_d = NULL                                        => 0.0993731565,
                                                                                 0.0993731565);

final_score_220_c1275 := map(
    NULL < f_vardobcount_i AND f_vardobcount_i <= 1.5 => 0.0120996814,
    f_vardobcount_i > 1.5                             => final_score_220_c1276,
    f_vardobcount_i = NULL                            => 0.0310249185,
                                                         0.0310249185);

final_score_220_c1277 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 0.5 => -0.0192068791,
    f_assocsuspicousidcount_i > 0.5                                       => 0.0051197518,
    f_assocsuspicousidcount_i = NULL                                      => -0.0018196583,
                                                                             -0.0018196583);

final_score_220_c1278 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 16.5 => -0.0321409483,
    r_c10_m_hdr_fs_d > 16.5                              => 0.0979305725,
    r_c10_m_hdr_fs_d = NULL                              => -0.0009950439,
                                                            0.0058245603);

final_score_220 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 2.5 => final_score_220_c1275,
    f_rel_educationover12_count_d > 2.5                                           => final_score_220_c1277,
    f_rel_educationover12_count_d = NULL                                          => final_score_220_c1278,
                                                                                     0.0007665040);

final_score_221_c1283 := map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 3.5 => -0.0706659141,
    f_rel_homeover150_count_d > 3.5                                       => 0.1370497323,
    f_rel_homeover150_count_d = NULL                                      => 0.0327343857,
                                                                             0.0327343857);

final_score_221_c1282 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => 0.1036996853,
    f_phone_ver_insurance_d > 3.5                                     => final_score_221_c1283,
    f_phone_ver_insurance_d = NULL                                    => 0.0660615474,
                                                                         0.0660615474);

final_score_221_c1281 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 3.5 => final_score_221_c1282,
    f_historical_count_d > 3.5                                  => -0.0271742293,
    f_historical_count_d = NULL                                 => 0.0354708452,
                                                                   0.0354708452);

final_score_221_c1280 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 1.5 => final_score_221_c1281,
    f_rel_under100miles_cnt_d > 1.5                                       => 0.0061559695,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0076414182,
                                                                             0.0076414182);

final_score_221 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 50.65 => -0.0189139094,
    r_c12_source_profile_d > 50.65                                    => final_score_221_c1280,
    r_c12_source_profile_d = NULL                                     => 0.0226764065,
                                                                         -0.0007203337);

final_score_222_c1287 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 0.5 => 0.0992453261,
    k_inq_per_ssn_i > 0.5                             => -0.0043594856,
    k_inq_per_ssn_i = NULL                            => 0.0373753149,
                                                         0.0373753149);

final_score_222_c1286 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 79083 => -0.0146480844,
    r_a49_curr_avm_chg_1yr_i > 79083                                      => final_score_222_c1287,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => -0.0089058980,
                                                                             -0.0089058980);

final_score_222_c1288 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 1.5 => -0.0027235038,
    f_rel_homeover500_count_d > 1.5                                       => -0.1093861850,
    f_rel_homeover500_count_d = NULL                                      => -0.0558335525,
                                                                             -0.0558335525);

final_score_222_c1285 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 138.85 => final_score_222_c1286,
    r_a49_curr_avm_chg_1yr_pct_i > 138.85                                          => final_score_222_c1288,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => -0.0464753709,
                                                                                      -0.0184907235);

final_score_222 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 225875.5 => 0.0111544081,
    r_a46_curr_avm_autoval_d > 225875.5                                      => final_score_222_c1285,
    r_a46_curr_avm_autoval_d = NULL                                          => -0.0000636630,
                                                                                0.0010600679);

final_score_223_c1293 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => 0.1631641303,
    r_phn_pcs_n > 0.5                         => 0.1548735314,
    r_phn_pcs_n = NULL                        => 0.1589989969,
                                                 0.1589989969);

final_score_223_c1292 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 285.5 => final_score_223_c1293,
    r_c10_m_hdr_fs_d > 285.5                              => -0.0028654272,
    r_c10_m_hdr_fs_d = NULL                               => 0.0888138807,
                                                             0.0888138807);

final_score_223_c1291 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_223_c1292,
    r_phn_cell_n > 0.5                          => -0.0025613628,
    r_phn_cell_n = NULL                         => 0.0337330020,
                                                   0.0337330020);

final_score_223_c1290 := map(
    NULL < f_hh_college_attendees_d AND f_hh_college_attendees_d <= 1.5 => -0.0002068427,
    f_hh_college_attendees_d > 1.5                                      => final_score_223_c1291,
    f_hh_college_attendees_d = NULL                                     => 0.0016276902,
                                                                           0.0016276902);

final_score_223 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 2.5 => final_score_223_c1290,
    f_hh_lienholders_i > 2.5                                => -0.0427439168,
    f_hh_lienholders_i = NULL                               => 0.0065862971,
                                                               -0.0017913983);

final_score_224_c1296 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 2.5 => 0.0942955506,
    f_srchvelocityrisktype_i > 2.5                                      => 0.0250865770,
    f_srchvelocityrisktype_i = NULL                                     => 0.0583871266,
                                                                           0.0583871266);

final_score_224_c1297 := map(
    NULL < f_assoccredbureaucount_i AND f_assoccredbureaucount_i <= 0.5 => -0.0274112072,
    f_assoccredbureaucount_i > 0.5                                      => 0.0810164670,
    f_assoccredbureaucount_i = NULL                                     => -0.0025950141,
                                                                           -0.0025950141);

final_score_224_c1295 := map(
    NULL < (real)k_nap_fname_verd_d AND (real)k_nap_fname_verd_d <= 0.5 	=> final_score_224_c1296,
    (real)k_nap_fname_verd_d > 0.5                                				=> final_score_224_c1297,
   (real) k_nap_fname_verd_d = NULL                              			 		=> 0.0204486206,
																																							0.0204486206);

final_score_224_c1298 := map(
    NULL < f_srchfraudsrchcountwk_i AND f_srchfraudsrchcountwk_i <= 0.5 => -0.0030104632,
    f_srchfraudsrchcountwk_i > 0.5                                      => 0.0740064011,
    f_srchfraudsrchcountwk_i = NULL                                     => -0.0014091096,
                                                                           -0.0014091096);

final_score_224 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 95 => final_score_224_c1295,
    r_f01_inp_addr_address_score_d > 95                                            => final_score_224_c1298,
    r_f01_inp_addr_address_score_d = NULL                                          => 0.0205352985,
                                                                                      -0.0001270475);

final_score_225_c1303 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 3.5 => 0.1626909761,
    f_inq_count24_i > 3.5                             => -0.0010017853,
    f_inq_count24_i = NULL                            => 0.0765017262,
                                                         0.0765017262);

final_score_225_c1302 := map(
    NULL < f_srchphonesrchcountwk_i AND f_srchphonesrchcountwk_i <= 0.5 => -0.0026955280,
    f_srchphonesrchcountwk_i > 0.5                                      => final_score_225_c1303,
    f_srchphonesrchcountwk_i = NULL                                     => -0.0015048476,
                                                                           -0.0015048476);

final_score_225_c1301 := map(
    NULL < f_inq_quizprovider_count24_i AND f_inq_quizprovider_count24_i <= 3.5 => final_score_225_c1302,
    f_inq_quizprovider_count24_i > 3.5                                          => 0.1124028614,
    f_inq_quizprovider_count24_i = NULL                                         => -0.0005964706,
                                                                                   -0.0005964706);

final_score_225_c1300 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 27.35 => -0.0424763193,
    r_c12_source_profile_d > 27.35                                    => final_score_225_c1301,
    r_c12_source_profile_d = NULL                                     => -0.0052953068,
                                                                         -0.0052953068);

final_score_225 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 424.5 => final_score_225_c1300,
    f_m_bureau_adl_fs_notu_d > 424.5                                      => -0.0761262989,
    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0046271284,
                                                                             -0.0057969839);

final_score_226_c1305 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 249950 => -0.0098705605,
    r_l80_inp_avm_autoval_d > 249950                                     => -0.0345505535,
    r_l80_inp_avm_autoval_d = NULL                                       => 0.0065416222,
                                                                            -0.0069562590);

final_score_226_c1307 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 0.5 => -0.0896872898,
    f_rel_homeover100_count_d > 0.5                                       => 0.0064807691,
    f_rel_homeover100_count_d = NULL                                      => 0.0050104105,
                                                                             0.0050104105);

final_score_226_c1308 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => 0.1014948199,
    f_inq_other_count24_i > 0.5                                   => -0.0213361200,
    f_inq_other_count24_i = NULL                                  => 0.0585200263,
                                                                     0.0585200263);

final_score_226_c1306 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 317.5 => final_score_226_c1307,
    r_c13_curr_addr_lres_d > 317.5                                    => final_score_226_c1308,
    r_c13_curr_addr_lres_d = NULL                                     => 0.0067101851,
                                                                         0.0067101851);

final_score_226 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 7.5 => final_score_226_c1305,
    f_addrs_per_ssn_i > 7.5                               => final_score_226_c1306,
    f_addrs_per_ssn_i = NULL                              => 0.0018164350,
                                                             0.0018164350);

final_score_227_c1313 := map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i <= 1.5 => 0.0934617980,
    f_rel_criminal_count_i > 1.5                                    => -0.0010328109,
    f_rel_criminal_count_i = NULL                                   => 0.0345196162,
                                                                       0.0345196162);

final_score_227_c1312 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 3.5 => 0.0042419311,
    r_e57_br_source_count_d > 3.5                                     => final_score_227_c1313,
    r_e57_br_source_count_d = NULL                                    => 0.0049904738,
                                                                         0.0049904738);

final_score_227_c1311 := map(
    NULL < r_d34_unrel_liens_ct_i AND r_d34_unrel_liens_ct_i <= 0.5 => final_score_227_c1312,
    r_d34_unrel_liens_ct_i > 0.5                                    => -0.0212292660,
    r_d34_unrel_liens_ct_i = NULL                                   => -0.0034131585,
                                                                       -0.0034131585);

final_score_227_c1310 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 14.5 => final_score_227_c1311,
    k_inq_per_phone_i > 14.5                               => 0.0628714304,
    k_inq_per_phone_i = NULL                               => -0.0030004776,
                                                              -0.0030004776);

final_score_227 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 31.5 => final_score_227_c1310,
    f_rel_under25miles_cnt_d > 31.5                                      => 0.0828741194,
    f_rel_under25miles_cnt_d = NULL                                      => -0.0040383785,
                                                                            -0.0021631782);

final_score_228_c1317 := map(
    NULL < f_rel_bankrupt_count_i AND f_rel_bankrupt_count_i <= 0.5 => 0.0321898726,
    f_rel_bankrupt_count_i > 0.5                                    => 0.0074631777,
    f_rel_bankrupt_count_i = NULL                                   => 0.0146668180,
                                                                       0.0146668180);

final_score_228_c1316 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 33645 => -0.0587169160,
    r_l80_inp_avm_autoval_d > 33645                                     => final_score_228_c1317,
    r_l80_inp_avm_autoval_d = NULL                                      => -0.0039175765,
                                                                           0.0047184122);

final_score_228_c1315 := map(
    NULL < r_i60_inq_retail_recency_d AND r_i60_inq_retail_recency_d <= 549 => -0.0188337257,
    r_i60_inq_retail_recency_d > 549                                        => final_score_228_c1316,
    r_i60_inq_retail_recency_d = NULL                                       => -0.0019331926,
                                                                               -0.0019331926);

final_score_228_c1318 := map(
    NULL < r_c14_addrs_15yr_i AND r_c14_addrs_15yr_i <= 1.5 => 0.1265882302,
    r_c14_addrs_15yr_i > 1.5                                => 0.0166290140,
    r_c14_addrs_15yr_i = NULL                               => 0.0361439602,
                                                               0.0361439602);

final_score_228 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 19.5 => final_score_228_c1315,
    f_rel_homeover200_count_d > 19.5                                       => final_score_228_c1318,
    f_rel_homeover200_count_d = NULL                                       => 0.0116691456,
                                                                              -0.0004003715);

final_score_229_c1321 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 6.5 => 0.1307096572,
    f_rel_incomeover50_count_d > 6.5                                        => 0.0149186837,
    f_rel_incomeover50_count_d = NULL                                       => 0.0642370613,
                                                                               0.0642370613);

final_score_229_c1322 := map(
    NULL < f_hh_college_attendees_d AND f_hh_college_attendees_d <= 0.5 => -0.0036773043,
    f_hh_college_attendees_d > 0.5                                      => 0.0299382716,
    f_hh_college_attendees_d = NULL                                     => 0.0042945848,
                                                                           0.0042945848);

final_score_229_c1320 := map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d <= 13.5 => final_score_229_c1321,
    f_mos_acc_lseen_d > 13.5                               => final_score_229_c1322,
    f_mos_acc_lseen_d = NULL                               => 0.0063187277,
                                                              0.0063187277);

final_score_229_c1323 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 325.5 => -0.0127278571,
    r_c13_curr_addr_lres_d > 325.5                                    => -0.0774778573,
    r_c13_curr_addr_lres_d = NULL                                     => -0.0147889110,
                                                                         -0.0147889110);

final_score_229 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => final_score_229_c1320,
    f_inq_other_count24_i > 0.5                                   => final_score_229_c1323,
    f_inq_other_count24_i = NULL                                  => -0.0224861680,
                                                                     -0.0023294529);

final_score_230_c1326 := map(
    NULL < f_liens_unrel_ft_total_amt_i AND f_liens_unrel_ft_total_amt_i <= 57649 => 0.0047561885,
    f_liens_unrel_ft_total_amt_i > 57649                                          => 0.1108461922,
    f_liens_unrel_ft_total_amt_i = NULL                                           => 0.0053626944,
                                                                                     0.0053626944);

final_score_230_c1328 := map(
    NULL < f_property_owners_ct_d AND f_property_owners_ct_d <= 2.5 => -0.0259461196,
    f_property_owners_ct_d > 2.5                                    => 0.1038411463,
    f_property_owners_ct_d = NULL                                   => 0.0310733906,
                                                                       0.0310733906);

final_score_230_c1327 := map(
    NULL < f_curraddractivephonelist_d AND f_curraddractivephonelist_d <= 0.5 => 0.1014293142,
    f_curraddractivephonelist_d > 0.5                                         => final_score_230_c1328,
    f_curraddractivephonelist_d = NULL                                        => 0.0531101598,
                                                                                 0.0531101598);

final_score_230_c1325 := map(
    NULL < f_hh_prof_license_holders_d AND f_hh_prof_license_holders_d <= 1.5 => final_score_230_c1326,
    f_hh_prof_license_holders_d > 1.5                                         => final_score_230_c1327,
    f_hh_prof_license_holders_d = NULL                                        => 0.0062967152,
                                                                                 0.0062967152);

final_score_230 := map(
    NULL < f_crim_rel_under100miles_cnt_i AND f_crim_rel_under100miles_cnt_i <= 10.5 => final_score_230_c1325,
    f_crim_rel_under100miles_cnt_i > 10.5                                            => -0.0695366210,
    f_crim_rel_under100miles_cnt_i = NULL                                            => -0.0085964118,
                                                                                        0.0039269988);

final_score_231_c1330 := map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d <= 7.5 => 0.1565034128,
    f_mos_acc_lseen_d > 7.5                               => -0.0218993210,
    f_mos_acc_lseen_d = NULL                              => -0.0180169168,
                                                             -0.0180169168);

final_score_231_c1332 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 1.5 => 0.0699463361,
    f_rel_under100miles_cnt_d > 1.5                                       => -0.0024350948,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0073113737,
                                                                             0.0073113737);

final_score_231_c1331 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 12.5 => final_score_231_c1332,
    f_phones_per_addr_curr_i > 12.5                                      => 0.0744546699,
    f_phones_per_addr_curr_i = NULL                                      => 0.0106122731,
                                                                            0.0106122731);

final_score_231_c1333 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 10.5 => 0.0033427924,
    f_rel_homeover500_count_d > 10.5                                       => 0.0635870057,
    f_rel_homeover500_count_d = NULL                                       => 0.0157251318,
                                                                              0.0043294134);

final_score_231 := map(
    NULL < f_prevaddrstatus_i AND f_prevaddrstatus_i <= 2.5 => final_score_231_c1330,
    f_prevaddrstatus_i > 2.5                                => final_score_231_c1331,
    f_prevaddrstatus_i = NULL                               => final_score_231_c1333,
                                                               -0.0015299071);

final_score_232_c1337 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 49.5 => 0.0286695860,
    f_prevaddrageoldest_d > 49.5                                   => 0.1451693548,
    f_prevaddrageoldest_d = NULL                                   => 0.0890505637,
                                                                      0.0890505637);

final_score_232_c1336 := map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 1.5 => final_score_232_c1337,
    f_hh_members_w_derog_i > 1.5                                    => -0.0113005476,
    f_hh_members_w_derog_i = NULL                                   => 0.0448686751,
                                                                       0.0448686751);

final_score_232_c1335 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => -0.0014984703,
    f_srchunvrfdaddrcount_i > 0.5                                     => final_score_232_c1336,
    f_srchunvrfdaddrcount_i = NULL                                    => 0.0000058563,
                                                                         0.0000058563);

final_score_232_c1338 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 2.5 => -0.0800800945,
    f_phone_ver_insurance_d > 2.5                                     => -0.0101623864,
    f_phone_ver_insurance_d = NULL                                    => -0.0318730604,
                                                                         -0.0318730604);

final_score_232 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 3.5 => final_score_232_c1335,
    r_c23_inp_addr_occ_index_d > 3.5                                        => final_score_232_c1338,
    r_c23_inp_addr_occ_index_d = NULL                                       => -0.0303233933,
                                                                               -0.0013143409);

final_score_233_c1342 := map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 2.5 => 0.0030554272,
    r_s66_adlperssn_count_i > 2.5                                     => -0.0212686870,
    r_s66_adlperssn_count_i = NULL                                    => -0.0013097539,
                                                                         -0.0013097539);

final_score_233_c1341 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 6.5 => 0.0826074712,
    r_d32_mos_since_crim_ls_d > 6.5                                       => final_score_233_c1342,
    r_d32_mos_since_crim_ls_d = NULL                                      => -0.0001896467,
                                                                             -0.0001896467);

final_score_233_c1343 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 4.5 => -0.0469824122,
    f_addrs_per_ssn_i > 4.5                               => 0.0535324148,
    f_addrs_per_ssn_i = NULL                              => -0.0240928971,
                                                             -0.0240928971);

final_score_233_c1340 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 16.5 => final_score_233_c1341,
    f_rel_incomeover50_count_d > 16.5                                        => -0.0383966089,
    f_rel_incomeover50_count_d = NULL                                        => final_score_233_c1343,
                                                                                -0.0040472861);

final_score_233 := map(
    NULL < nf_inq_per_add_nas_479 AND nf_inq_per_add_nas_479 <= 2.5 => final_score_233_c1340,
    nf_inq_per_add_nas_479 > 2.5                                    => 0.0502332828,
    nf_inq_per_add_nas_479 = NULL                                   => -0.0036498795,
                                                                       -0.0036498795);

final_score_234_c1346 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 6.5 => 0.1384240323,
    f_rel_under100miles_cnt_d > 6.5                                       => 0.0241090167,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0794561057,
                                                                             0.0794561057);

final_score_234_c1345 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 71.5 => 0.0013159379,
    f_prevaddrageoldest_d > 71.5                                   => final_score_234_c1346,
    f_prevaddrageoldest_d = NULL                                   => 0.0250141855,
                                                                      0.0250141855);

final_score_234_c1348 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 361.5 => -0.0531048647,
    f_m_bureau_adl_fs_all_d > 361.5                                     => 0.0350879575,
    f_m_bureau_adl_fs_all_d = NULL                                      => -0.0333749269,
                                                                           -0.0333749269);

final_score_234_c1347 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 26609.5 => 0.0089797402,
    r_a49_curr_avm_chg_1yr_i > 26609.5                                      => final_score_234_c1348,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => 0.0052857669,
                                                                               0.0026005888);

final_score_234 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 40.5 => -0.0065621126,
    r_p88_phn_dst_to_inp_add_i > 40.5                                        => final_score_234_c1345,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => final_score_234_c1347,
                                                                                -0.0031009255);

final_score_235_c1353 := map(
    NULL < r_c12_num_nonderogs_d AND r_c12_num_nonderogs_d <= 3.5 => 0.0978571700,
    r_c12_num_nonderogs_d > 3.5                                   => -0.0237196027,
    r_c12_num_nonderogs_d = NULL                                  => 0.0249111064,
                                                                     0.0249111064);

final_score_235_c1352 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 363.5 => 0.1937476885,
    r_c13_max_lres_d > 363.5                              => final_score_235_c1353,
    r_c13_max_lres_d = NULL                               => 0.0685236250,
                                                             0.0685236250);

final_score_235_c1351 := map(
    (nf_seg_fraudpoint_3_0 in ['5: Vuln Vic/Friendly', '6: Other'])                                    => -0.0141363189,
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '3: Derog', '4: Recent Activity']) => final_score_235_c1352,
    nf_seg_fraudpoint_3_0 = ''                                                                       => 0.0315134524,
                                                                                                          0.0315134524);

final_score_235_c1350 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 342.5 => -0.0080701110,
    r_c13_max_lres_d > 342.5                              => final_score_235_c1351,
    r_c13_max_lres_d = NULL                               => -0.0047949956,
                                                             -0.0047949956);

final_score_235 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 185500 => final_score_235_c1350,
    r_a49_curr_avm_chg_1yr_i > 185500                                      => 0.0621060513,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => -0.0047384679,
                                                                              -0.0043670018);

final_score_236_c1358 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 0.5 => 0.1464808312,
    r_d30_derog_count_i > 0.5                                 => -0.0065196347,
    r_d30_derog_count_i = NULL                                => 0.0648805827,
                                                                 0.0648805827);

final_score_236_c1357 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => 0.0111281617,
    r_c23_inp_addr_occ_index_d > 2                                        => final_score_236_c1358,
    r_c23_inp_addr_occ_index_d = NULL                                     => 0.0240172857,
                                                                             0.0240172857);

final_score_236_c1356 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 38833.5 => 0.1248173310,
    r_l80_inp_avm_autoval_d > 38833.5                                     => -0.0075827945,
    r_l80_inp_avm_autoval_d = NULL                                        => final_score_236_c1357,
                                                                             0.0088610260);

final_score_236_c1355 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 380.5 => final_score_236_c1356,
    f_m_bureau_adl_fs_notu_d > 380.5                                      => 0.0882621352,
    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0131372489,
                                                                             0.0131372489);

final_score_236 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 1.5 => -0.0069577884,
    k_inq_lnames_per_addr_i > 1.5                                     => final_score_236_c1355,
    k_inq_lnames_per_addr_i = NULL                                    => -0.0035700498,
                                                                         -0.0035700498);

final_score_237_c1361 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 1.5 => 0.0285657885,
    f_rel_homeover500_count_d > 1.5                                       => -0.0865098968,
    f_rel_homeover500_count_d = NULL                                      => 0.0172838586,
                                                                             0.0172838586);

final_score_237_c1362 := map(
    NULL < f_adl_util_misc_n AND f_adl_util_misc_n <= 0.5 => 0.1050140033,
    f_adl_util_misc_n > 0.5                               => -0.0180499940,
    f_adl_util_misc_n = NULL                              => 0.0570323725,
                                                             0.0570323725);

final_score_237_c1363 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 302.5 => 0.0216650075,
    r_c13_max_lres_d > 302.5                              => -0.1010767554,
    r_c13_max_lres_d = NULL                               => 0.0128917705,
                                                             0.0128917705);

final_score_237_c1360 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 297500 => final_score_237_c1361,
    r_l80_inp_avm_autoval_d > 297500                                     => final_score_237_c1362,
    r_l80_inp_avm_autoval_d = NULL                                       => final_score_237_c1363,
                                                                            0.0188991530);

final_score_237 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => -0.0058751760,
    r_f03_input_add_not_most_rec_i > 0.5                                            => final_score_237_c1360,
    r_f03_input_add_not_most_rec_i = NULL                                           => -0.0610178141,
                                                                                       -0.0027107040);

final_score_238_c1368 := map(
    NULL < f_crim_rel_under100miles_cnt_i AND f_crim_rel_under100miles_cnt_i <= 6.5 => 0.0703903941,
    f_crim_rel_under100miles_cnt_i > 6.5                                            => -0.0445257227,
    f_crim_rel_under100miles_cnt_i = NULL                                           => 0.0453090171,
                                                                                       0.0453090171);

final_score_238_c1367 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 103.65 => -0.0147866026,
    r_a49_curr_avm_chg_1yr_pct_i > 103.65                                          => final_score_238_c1368,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => 0.0133632575,
                                                                                      0.0159501663);

final_score_238_c1366 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 346.5 => final_score_238_c1367,
    r_c13_max_lres_d > 346.5                              => -0.1148708230,
    r_c13_max_lres_d = NULL                               => 0.0115917545,
                                                             0.0115917545);

final_score_238_c1365 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 408.5 => final_score_238_c1366,
    f_m_bureau_adl_fs_all_d > 408.5                                     => 0.0896833758,
    f_m_bureau_adl_fs_all_d = NULL                                      => 0.0146051260,
                                                                           0.0146051260);

final_score_238 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 210.5 => final_score_238_c1365,
    r_d32_mos_since_crim_ls_d > 210.5                                       => -0.0069343218,
    r_d32_mos_since_crim_ls_d = NULL                                        => 0.0198386291,
                                                                               -0.0021356799);

final_score_239_c1372 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 77.35 => -0.0366423423,
    r_c12_source_profile_d > 77.35                                    => -0.1218176317,
    r_c12_source_profile_d = NULL                                     => -0.0625461674,
                                                                         -0.0625461674);

final_score_239_c1371 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 247.5 => 0.0016794734,
    r_c13_max_lres_d > 247.5                              => final_score_239_c1372,
    r_c13_max_lres_d = NULL                               => -0.0108681342,
                                                             -0.0108681342);

final_score_239_c1370 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 17.5 => -0.0106993503,
    r_p88_phn_dst_to_inp_add_i > 17.5                                        => 0.0361173720,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => final_score_239_c1371,
                                                                                -0.0066001786);

final_score_239_c1373 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 3.5 => 0.0171123734,
    k_inq_ssns_per_addr_i > 3.5                                   => 0.1089316157,
    k_inq_ssns_per_addr_i = NULL                                  => 0.0226912640,
                                                                     0.0226912640);

final_score_239 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_239_c1370,
    f_phone_ver_experian_d > 0.5                                    => -0.0036110693,
    f_phone_ver_experian_d = NULL                                   => final_score_239_c1373,
                                                                       -0.0017148606);

final_score_240_c1375 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 14.5 => 0.0058114991,
    f_rel_educationover12_count_d > 14.5                                           => -0.0319422278,
    f_rel_educationover12_count_d = NULL                                           => -0.0036561121,
                                                                                      -0.0036561121);

final_score_240_c1378 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 390.5 => 0.1422048324,
    f_m_bureau_adl_fs_all_d > 390.5                                     => 0.0216953139,
    f_m_bureau_adl_fs_all_d = NULL                                      => 0.0807945024,
                                                                           0.0807945024);

final_score_240_c1377 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 3.5 => final_score_240_c1378,
    r_l79_adls_per_addr_curr_i > 3.5                                        => -0.0474166043,
    r_l79_adls_per_addr_curr_i = NULL                                       => 0.0410466357,
                                                                               0.0410466357);

final_score_240_c1376 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 381.5 => -0.0059671112,
    r_c21_m_bureau_adl_fs_d > 381.5                                     => final_score_240_c1377,
    r_c21_m_bureau_adl_fs_d = NULL                                      => 0.0048419659,
                                                                           -0.0033361054);

final_score_240 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 153791.5 => final_score_240_c1375,
    r_a49_curr_avm_chg_1yr_i > 153791.5                                      => -0.0531263038,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => final_score_240_c1376,
                                                                                -0.0039125986);

final_score_241_c1381 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 9.5 => 0.0000378889,
    f_assocsuspicousidcount_i > 9.5                                       => -0.0723270230,
    f_assocsuspicousidcount_i = NULL                                      => -0.0007659004,
                                                                             -0.0007659004);

final_score_241_c1383 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => -0.0346826165,
    r_i61_inq_collection_recency_d > 549                                            => -0.0983035253,
    r_i61_inq_collection_recency_d = NULL                                           => -0.0638766266,
                                                                                       -0.0638766266);

final_score_241_c1382 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 1.5 => 0.0161079703,
    f_rel_homeover200_count_d > 1.5                                       => final_score_241_c1383,
    f_rel_homeover200_count_d = NULL                                      => -0.0371382599,
                                                                             -0.0371382599);

final_score_241_c1380 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 425.5 => final_score_241_c1381,
    r_c13_max_lres_d > 425.5                              => final_score_241_c1382,
    r_c13_max_lres_d = NULL                               => -0.0014507643,
                                                             -0.0014507643);

final_score_241 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 12.5 => final_score_241_c1380,
    r_l79_adls_per_addr_curr_i > 12.5                                        => -0.0873656589,
    r_l79_adls_per_addr_curr_i = NULL                                        => -0.0303810814,
                                                                                -0.0022546202);

final_score_242_c1388 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 0.5 => -0.0894755268,
    f_phone_ver_insurance_d > 0.5                                     => 0.0020642619,
    f_phone_ver_insurance_d = NULL                                    => -0.0001554141,
                                                                         -0.0001554141);

final_score_242_c1387 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 5.5 => final_score_242_c1388,
    f_rel_homeover500_count_d > 5.5                                       => 0.0604708218,
    f_rel_homeover500_count_d = NULL                                      => 0.0007454554,
                                                                             0.0007454554);

final_score_242_c1386 := map(
    NULL < f_assocrisktype_i AND f_assocrisktype_i <= 3.5 => final_score_242_c1387,
    f_assocrisktype_i > 3.5                               => 0.0424953197,
    f_assocrisktype_i = NULL                              => 0.0065527801,
                                                             0.0065527801);

final_score_242_c1385 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 498.5 => final_score_242_c1386,
    r_c13_max_lres_d > 498.5                              => 0.0721534303,
    r_c13_max_lres_d = NULL                               => 0.0071735898,
                                                             0.0071735898);

final_score_242 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 9.5 => final_score_242_c1385,
    f_rel_incomeover50_count_d > 9.5                                        => -0.0178897458,
    f_rel_incomeover50_count_d = NULL                                       => 0.0072643051,
                                                                               -0.0006093025);

final_score_243_c1391 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 31.5 => 0.0031500881,
    f_rel_under25miles_cnt_d > 31.5                                      => 0.0799572888,
    f_rel_under25miles_cnt_d = NULL                                      => 0.0403479444,
                                                                            0.0045673575);

final_score_243_c1393 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => -0.0957133953,
    f_phone_ver_experian_d > 0.5                                    => -0.0027493807,
    f_phone_ver_experian_d = NULL                                   => -0.0407922915,
                                                                       -0.0407922915);

final_score_243_c1392 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 8.5 => final_score_243_c1393,
    f_rel_homeover300_count_d > 8.5                                       => 0.0276653761,
    f_rel_homeover300_count_d = NULL                                      => -0.0180150161,
                                                                             -0.0180150161);

final_score_243_c1390 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 5.5 => final_score_243_c1391,
    r_wealth_index_d > 5.5                              => final_score_243_c1392,
    r_wealth_index_d = NULL                             => 0.0193912266,
                                                           0.0040693654);

final_score_243 := map(
    NULL < f_recent_disconnects_i AND f_recent_disconnects_i <= 1.5 => final_score_243_c1390,
    f_recent_disconnects_i > 1.5                                    => 0.0573878406,
    f_recent_disconnects_i = NULL                                   => 0.0043719899,
                                                                       0.0043719899);

final_score_244_c1396 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 7.5 => 0.0895300313,
    f_rel_educationover12_count_d > 7.5                                           => 0.0285281395,
    f_rel_educationover12_count_d = NULL                                          => 0.0349737680,
                                                                                     0.0349737680);

final_score_244_c1398 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 11.5 => 0.0122699710,
    f_addrs_per_ssn_i > 11.5                               => 0.1744323169,
    f_addrs_per_ssn_i = NULL                               => 0.0903481376,
                                                              0.0903481376);

final_score_244_c1397 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 11.5 => final_score_244_c1398,
    f_rel_homeover100_count_d > 11.5                                       => -0.0230631051,
    f_rel_homeover100_count_d = NULL                                       => 0.0170841048,
                                                                              0.0170841048);

final_score_244_c1395 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 4.5 => final_score_244_c1396,
    f_addrchangeecontrajindex_d > 4.5                                         => -0.0634394451,
    f_addrchangeecontrajindex_d = NULL                                        => final_score_244_c1397,
                                                                                 0.0286988736);

final_score_244 := map(
    NULL < f_assocrisktype_i AND f_assocrisktype_i <= 3.5 => -0.0007874076,
    f_assocrisktype_i > 3.5                               => final_score_244_c1395,
    f_assocrisktype_i = NULL                              => -0.0042784645,
                                                             0.0052928063);

final_score_245_c1403 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 7.5 => 0.0129369465,
    k_inq_per_ssn_i > 7.5                             => 0.0977641807,
    k_inq_per_ssn_i = NULL                            => 0.0141621891,
                                                         0.0141621891);

final_score_245_c1402 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 1.5 => final_score_245_c1403,
    f_srchcomponentrisktype_i > 1.5                                       => 0.0951055768,
    f_srchcomponentrisktype_i = NULL                                      => 0.0163867557,
                                                                             0.0163867557);

final_score_245_c1401 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 4.5 => final_score_245_c1402,
    f_srchvelocityrisktype_i > 4.5                                      => -0.0121071461,
    f_srchvelocityrisktype_i = NULL                                     => 0.0084111431,
                                                                           0.0084111431);

final_score_245_c1400 := map(
    NULL < f_dl_addrs_per_adl_i AND f_dl_addrs_per_adl_i <= 0.5 => final_score_245_c1401,
    f_dl_addrs_per_adl_i > 0.5                                  => -0.0108639514,
    f_dl_addrs_per_adl_i = NULL                                 => -0.0002516805,
                                                                   -0.0002516805);

final_score_245 := map(
    NULL < f_mos_liens_rel_ot_fseen_d AND f_mos_liens_rel_ot_fseen_d <= 227.5 => final_score_245_c1400,
    f_mos_liens_rel_ot_fseen_d > 227.5                                        => 0.0946454888,
    f_mos_liens_rel_ot_fseen_d = NULL                                         => -0.0069133843,
                                                                                 0.0002841752);

final_score_246_c1408 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 10916 => -0.0073684239,
    r_a49_curr_avm_chg_1yr_i > 10916                                      => 0.0325991772,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => 0.0073450952,
                                                                             0.0102441951);

final_score_246_c1407 := map(
    NULL < nf_number_non_bureau_sources AND nf_number_non_bureau_sources <= 3.5 => final_score_246_c1408,
    nf_number_non_bureau_sources > 3.5                                          => -0.0061382379,
    nf_number_non_bureau_sources = NULL                                         => -0.0006631236,
                                                                                   -0.0006631236);

final_score_246_c1406 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 2.5 => final_score_246_c1407,
    f_srchunvrfdphonecount_i > 2.5                                      => 0.0695666709,
    f_srchunvrfdphonecount_i = NULL                                     => 0.0000612143,
                                                                           0.0000612143);

final_score_246_c1405 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 11.5 => final_score_246_c1406,
    r_l79_adls_per_addr_curr_i > 11.5                                        => -0.0777191828,
    r_l79_adls_per_addr_curr_i = NULL                                        => -0.0003908733,
                                                                                -0.0003908733);

final_score_246 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 0.5 => -0.0782277274,
    f_rel_under500miles_cnt_d > 0.5                                       => final_score_246_c1405,
    f_rel_under500miles_cnt_d = NULL                                      => 0.0210132764,
                                                                             -0.0003137932);

final_score_247_c1412 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => -0.1115424405,
    r_phn_cell_n > 0.5                          => -0.0307838381,
    r_phn_cell_n = NULL                         => -0.0715629344,
                                                   -0.0715629344);

final_score_247_c1411 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 1.5 => -0.0169017316,
    f_rel_homeover500_count_d > 1.5                                       => final_score_247_c1412,
    f_rel_homeover500_count_d = NULL                                      => -0.0373490704,
                                                                             -0.0373490704);

final_score_247_c1410 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 43084 => 0.0014118538,
    r_a49_curr_avm_chg_1yr_i > 43084                                      => final_score_247_c1411,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => -0.0083468526,
                                                                             -0.0066094802);

final_score_247_c1413 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 95 => 0.0647870091,
    r_f00_ssn_score_d > 95                               => 0.0072346463,
    r_f00_ssn_score_d = NULL                             => 0.0078940455,
                                                            0.0078940455);

final_score_247 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 8.5 => final_score_247_c1410,
    f_addrs_per_ssn_i > 8.5                               => final_score_247_c1413,
    f_addrs_per_ssn_i = NULL                              => 0.0018103544,
                                                             0.0018103544);

final_score_248_c1417 := map(
    NULL < f_phones_per_addr_c6_i AND f_phones_per_addr_c6_i <= 0.5 => -0.0091326592,
    f_phones_per_addr_c6_i > 0.5                                    => -0.0415628042,
    f_phones_per_addr_c6_i = NULL                                   => -0.0162212950,
                                                                       -0.0162212950);

final_score_248_c1418 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 369.5 => 0.0097016008,
    r_c13_curr_addr_lres_d > 369.5                                    => 0.0800167005,
    r_c13_curr_addr_lres_d = NULL                                     => 0.0125919823,
                                                                         0.0125919823);

final_score_248_c1416 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '3: Derog', '6: Other']) => final_score_248_c1417,
    (nf_seg_fraudpoint_3_0 in ['4: Recent Activity', '5: Vuln Vic/Friendly'])                => final_score_248_c1418,
    nf_seg_fraudpoint_3_0 = ''                                                             		=> -0.0025680669,
                                                                                                -0.0025680669);

final_score_248_c1415 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 173290.5 => final_score_248_c1416,
    r_a49_curr_avm_chg_1yr_i > 173290.5                                      => 0.0507547463,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => -0.0028929186,
                                                                                -0.0024051237);

final_score_248 := map(
    NULL < f_inq_retailpayments_count24_i AND f_inq_retailpayments_count24_i <= 1.5 => final_score_248_c1415,
    f_inq_retailpayments_count24_i > 1.5                                            => 0.1244403779,
    f_inq_retailpayments_count24_i = NULL                                           => -0.0324138958,
                                                                                       -0.0017280301);

final_score_249_c1422 := map(
    NULL < f_crim_rel_under500miles_cnt_i AND f_crim_rel_under500miles_cnt_i <= 3.5 => 0.0766117293,
    f_crim_rel_under500miles_cnt_i > 3.5                                            => -0.0307481185,
    f_crim_rel_under500miles_cnt_i = NULL                                           => 0.0379621841,
                                                                                       0.0379621841);

final_score_249_c1421 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 154.95 => -0.0051025455,
    r_a49_curr_avm_chg_1yr_pct_i > 154.95                                          => final_score_249_c1422,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => 0.0010409498,
                                                                                      -0.0008839540);

final_score_249_c1420 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 45 => -0.0737667754,
    r_f00_ssn_score_d > 45                               => final_score_249_c1421,
    r_f00_ssn_score_d = NULL                             => -0.0016018542,
                                                            -0.0016018542);

final_score_249_c1423 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => -0.0959059857,
    f_phone_ver_experian_d > 0.5                                    => -0.0242317722,
    f_phone_ver_experian_d = NULL                                   => -0.0508048650,
                                                                       -0.0508048650);

final_score_249 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 429.5 => final_score_249_c1420,
    r_c13_max_lres_d > 429.5                              => final_score_249_c1423,
    r_c13_max_lres_d = NULL                               => 0.0063092311,
                                                             -0.0023549766);

final_score_250_c1428 := map(
    NULL < f_property_owners_ct_d AND f_property_owners_ct_d <= 1.5 => 0.0011686850,
    f_property_owners_ct_d > 1.5                                    => 0.1131090908,
    f_property_owners_ct_d = NULL                                   => 0.0576132116,
                                                                       0.0576132116);

final_score_250_c1427 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 72.5 => -0.0197929780,
    f_prevaddrageoldest_d > 72.5                                   => final_score_250_c1428,
    f_prevaddrageoldest_d = NULL                                   => 0.0076774893,
                                                                      0.0076774893);

final_score_250_c1426 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 72.15 => final_score_250_c1427,
    r_c12_source_profile_d > 72.15                                    => -0.0623546847,
    r_c12_source_profile_d = NULL                                     => -0.0057673266,
                                                                         -0.0057673266);

final_score_250_c1425 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 5.5 => -0.0019851413,
    f_addrchangeecontrajindex_d > 5.5                                         => -0.0534246429,
    f_addrchangeecontrajindex_d = NULL                                        => final_score_250_c1426,
                                                                                 -0.0033566542);

final_score_250 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 170804 => final_score_250_c1425,
    r_a49_curr_avm_chg_1yr_i > 170804                                      => 0.0504232258,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => 0.0022020919,
                                                                              0.0000406699);

final_score_251_c1433 := map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 4.5 => 0.1009578024,
    f_rel_homeover150_count_d > 4.5                                       => 0.0263451045,
    f_rel_homeover150_count_d = NULL                                      => 0.0568805502,
                                                                             0.0568805502);

final_score_251_c1432 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 2.5 => -0.0319074874,
    f_phone_ver_insurance_d > 2.5                                     => final_score_251_c1433,
    f_phone_ver_insurance_d = NULL                                    => 0.0268676924,
                                                                         0.0268676924);

final_score_251_c1431 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i <= 0.5 => -0.0018855419,
    r_p85_phn_disconnected_i > 0.5                                      => final_score_251_c1432,
    r_p85_phn_disconnected_i = NULL                                     => -0.0012169350,
                                                                           -0.0012169350);

final_score_251_c1430 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 474.5 => final_score_251_c1431,
    r_c13_curr_addr_lres_d > 474.5                                    => -0.0518945932,
    r_c13_curr_addr_lres_d = NULL                                     => -0.0015868267,
                                                                         -0.0015065764);

final_score_251 := map(
    NULL < r_l77_add_po_box_i AND r_l77_add_po_box_i <= 0.5 => final_score_251_c1430,
    r_l77_add_po_box_i > 0.5                                => -0.1105161247,
    r_l77_add_po_box_i = NULL                               => -0.0028082347,
                                                               -0.0028082347);

final_score_252_c1438 := map(
    NULL < r_c12_num_nonderogs_d AND r_c12_num_nonderogs_d <= 3.5 => 0.0273718997,
    r_c12_num_nonderogs_d > 3.5                                   => 0.0015389039,
    r_c12_num_nonderogs_d = NULL                                  => 0.0148040844,
                                                                     0.0148040844);

final_score_252_c1437 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 0.5 => -0.0064386039,
    f_rel_homeover300_count_d > 0.5                                       => final_score_252_c1438,
    f_rel_homeover300_count_d = NULL                                      => 0.0148337070,
                                                                             0.0047696967);

final_score_252_c1436 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 549 => -0.0239703090,
    r_i60_inq_hiriskcred_recency_d > 549                                            => final_score_252_c1437,
    r_i60_inq_hiriskcred_recency_d = NULL                                           => -0.0015572567,
                                                                                       -0.0015572567);

final_score_252_c1435 := map(
    NULL < f_mos_liens_unrel_st_lseen_d AND f_mos_liens_unrel_st_lseen_d <= 258.5 => -0.0671811591,
    f_mos_liens_unrel_st_lseen_d > 258.5                                          => final_score_252_c1436,
    f_mos_liens_unrel_st_lseen_d = NULL                                           => 0.0023796416,
                                                                                     -0.0061988502);

final_score_252 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 4.5 => final_score_252_c1435,
    k_inq_lnames_per_addr_i > 4.5                                     => -0.0500714181,
    k_inq_lnames_per_addr_i = NULL                                    => -0.0065457517,
                                                                         -0.0065457517);

final_score_253_c1443 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 1.5 => 0.1392505695,
    f_historical_count_d > 1.5                                  => 0.0287268660,
    f_historical_count_d = NULL                                 => 0.0820994236,
                                                                   0.0820994236);

final_score_253_c1442 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => final_score_253_c1443,
    f_inq_other_count24_i > 0.5                                   => -0.0083542039,
    f_inq_other_count24_i = NULL                                  => 0.0507691169,
                                                                     0.0507691169);

final_score_253_c1441 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 5.5 => -0.0195088655,
    f_rel_under500miles_cnt_d > 5.5                                       => final_score_253_c1442,
    f_rel_under500miles_cnt_d = NULL                                      => 0.0282321548,
                                                                             0.0282321548);

final_score_253_c1440 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 391.5 => 0.0014027486,
    r_c13_max_lres_d > 391.5                              => final_score_253_c1441,
    r_c13_max_lres_d = NULL                               => 0.0067268523,
                                                             0.0022175624);

final_score_253 := map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i <= 0.5 => final_score_253_c1440,
    r_p85_phn_not_issued_i > 0.5                                    => 0.0464104449,
    r_p85_phn_not_issued_i = NULL                                   => 0.0025129317,
                                                                       0.0025129317);

final_score_254_c1446 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => -0.0979740533,
    f_phone_ver_experian_d > 0.5                                    => -0.0146765684,
    f_phone_ver_experian_d = NULL                                   => -0.0429130039,
                                                                       -0.0429130039);

final_score_254_c1445 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 430.5 => 0.0002164432,
    r_c10_m_hdr_fs_d > 430.5                              => final_score_254_c1446,
    r_c10_m_hdr_fs_d = NULL                               => -0.0005466346,
                                                             -0.0005466346);

final_score_254_c1448 := map(
    NULL < f_vardobcount_i AND f_vardobcount_i <= 1.5 => 0.0406370133,
    f_vardobcount_i > 1.5                             => 0.1410875281,
    f_vardobcount_i = NULL                            => 0.0835158898,
                                                         0.0835158898);

final_score_254_c1447 := map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 0.5 => final_score_254_c1448,
    f_rel_incomeover100_count_d > 0.5                                         => -0.0223248906,
    f_rel_incomeover100_count_d = NULL                                        => 0.0336004429,
                                                                                 0.0336004429);

final_score_254 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 441.5 => final_score_254_c1445,
    f_m_bureau_adl_fs_all_d > 441.5                                     => final_score_254_c1447,
    f_m_bureau_adl_fs_all_d = NULL                                      => -0.0040976439,
                                                                           0.0005763310);

final_score_255_c1451 := map(
    NULL < r_f00_input_dob_match_level_d AND r_f00_input_dob_match_level_d <= 4.5 => -0.0756018547,
    r_f00_input_dob_match_level_d > 4.5                                           => -0.0022090919,
    r_f00_input_dob_match_level_d = NULL                                          => -0.0031529828,
                                                                                     -0.0031529828);

final_score_255_c1453 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.0992378602,
    f_phone_ver_experian_d > 0.5                                    => -0.0101088626,
    f_phone_ver_experian_d = NULL                                   => 0.0429405376,
                                                                       0.0429405376);

final_score_255_c1452 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 2.5 => -0.0001553819,
    k_inq_per_phone_i > 2.5                               => final_score_255_c1453,
    k_inq_per_phone_i = NULL                              => 0.0043467480,
                                                             0.0043467480);

final_score_255_c1450 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 946 => final_score_255_c1451,
    r_p88_phn_dst_to_inp_add_i > 946                                        => 0.0613093537,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => final_score_255_c1452,
                                                                               -0.0008660073);

final_score_255 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 35.5 => final_score_255_c1450,
    f_bus_addr_match_count_d > 35.5                                      => 0.0835850932,
    f_bus_addr_match_count_d = NULL                                      => -0.0003639625,
                                                                            -0.0003639625);

final_score_256_c1457 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 216261.5 => 0.0141592830,
    r_a46_curr_avm_autoval_d > 216261.5                                      => -0.1077400488,
    r_a46_curr_avm_autoval_d = NULL                                          => 0.0260139961,
                                                                                0.0172803708);

final_score_256_c1458 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 8.5 => 0.1158784252,
    f_rel_incomeover50_count_d > 8.5                                        => 0.0224486042,
    f_rel_incomeover50_count_d = NULL                                       => 0.0670842160,
                                                                               0.0670842160);

final_score_256_c1456 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 4.5 => final_score_256_c1457,
    r_wealth_index_d > 4.5                              => final_score_256_c1458,
    r_wealth_index_d = NULL                             => 0.0242740142,
                                                           0.0242740142);

final_score_256_c1455 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 50398.5 => 0.0220344366,
    r_a49_curr_avm_chg_1yr_i > 50398.5                                      => -0.0656925086,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => final_score_256_c1456,
                                                                               0.0198253620);

final_score_256 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => -0.0080298802,
    r_c23_inp_addr_occ_index_d > 2                                        => final_score_256_c1455,
    r_c23_inp_addr_occ_index_d = NULL                                     => -0.0150768074,
                                                                             -0.0027957670);

final_score_257_c1461 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 27 => 0.1507476686,
    r_c13_curr_addr_lres_d > 27                                    => 0.0108512967,
    r_c13_curr_addr_lres_d = NULL                                  => 0.0627981113,
                                                                      0.0627981113);

final_score_257_c1462 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 1.5 => 0.0404853987,
    f_rel_educationover12_count_d > 1.5                                           => -0.0020764846,
    f_rel_educationover12_count_d = NULL                                          => -0.0144515761,
                                                                                     -0.0007187712);

final_score_257_c1460 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 95 => final_score_257_c1461,
    r_f00_ssn_score_d > 95                               => final_score_257_c1462,
    r_f00_ssn_score_d = NULL                             => 0.0002618505,
                                                            0.0002618505);

final_score_257_c1463 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => -0.0171824160,
    f_validationrisktype_i > 1.5                                    => -0.1100898031,
    f_validationrisktype_i = NULL                                   => -0.0288770521,
                                                                       -0.0288770521);

final_score_257 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 4.5 => final_score_257_c1460,
    f_idverrisktype_i > 4.5                               => final_score_257_c1463,
    f_idverrisktype_i = NULL                              => 0.0005136327,
                                                             -0.0012827171);

final_score_258_c1467 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 1.5 => -0.0113690903,
    f_varrisktype_i > 1.5                             => 0.1246221461,
    f_varrisktype_i = NULL                            => 0.0685796481,
                                                         0.0685796481);

final_score_258_c1466 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 2.5 => final_score_258_c1467,
    k_inq_per_phone_i > 2.5                               => -0.0159174914,
    k_inq_per_phone_i = NULL                              => 0.0296820536,
                                                             0.0296820536);

final_score_258_c1465 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 5.5 => 0.0010693610,
    k_inq_per_ssn_i > 5.5                             => final_score_258_c1466,
    k_inq_per_ssn_i = NULL                            => 0.0021411910,
                                                         0.0021411910);

final_score_258_c1468 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 3.5 => -0.1149702921,
    f_rel_incomeover50_count_d > 3.5                                        => -0.0191867815,
    f_rel_incomeover50_count_d = NULL                                       => -0.0372653439,
                                                                               -0.0372653439);

final_score_258 := map(
    NULL < r_i60_inq_count12_i AND r_i60_inq_count12_i <= 5.5 => final_score_258_c1465,
    r_i60_inq_count12_i > 5.5                                 => final_score_258_c1468,
    r_i60_inq_count12_i = NULL                                => -0.0143244734,
                                                                 -0.0010783291);

final_score_259_c1471 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 92 => 0.0280211019,
    r_f00_dob_score_d > 92                               => 0.0032740487,
    r_f00_dob_score_d = NULL                             => -0.0318343811,
                                                            0.0033779581);

final_score_259_c1473 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 3.5 => -0.0141235738,
    r_l79_adls_per_addr_curr_i > 3.5                                        => -0.1092304164,
    r_l79_adls_per_addr_curr_i = NULL                                       => -0.0628003042,
                                                                               -0.0628003042);

final_score_259_c1472 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 0.5 => 0.0099251573,
    k_inq_lnames_per_addr_i > 0.5                                     => final_score_259_c1473,
    k_inq_lnames_per_addr_i = NULL                                    => -0.0344793312,
                                                                         -0.0344793312);

final_score_259_c1470 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 7.5 => final_score_259_c1471,
    f_rel_homeover500_count_d > 7.5                                       => final_score_259_c1472,
    f_rel_homeover500_count_d = NULL                                      => 0.0095278482,
                                                                             0.0026379938);

final_score_259 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 6.5 => final_score_259_c1470,
    f_srchcomponentrisktype_i > 6.5                                       => -0.0983781088,
    f_srchcomponentrisktype_i = NULL                                      => -0.0055690933,
                                                                             0.0018685358);

final_score_260_c1476 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 259.5 => -0.0019510187,
    r_c13_curr_addr_lres_d > 259.5                                    => 0.0233763911,
    r_c13_curr_addr_lres_d = NULL                                     => 0.0003736519,
                                                                         0.0003736519);

final_score_260_c1477 := map(
    NULL < nf_number_non_bureau_sources AND nf_number_non_bureau_sources <= 1.5 => -0.1047078012,
    nf_number_non_bureau_sources > 1.5                                          => -0.0259084927,
    nf_number_non_bureau_sources = NULL                                         => -0.0326208513,
                                                                                   -0.0326208513);

final_score_260_c1475 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 19.5 => final_score_260_c1476,
    f_rel_homeover100_count_d > 19.5                                       => final_score_260_c1477,
    f_rel_homeover100_count_d = NULL                                       => -0.0125788404,
                                                                              -0.0028495296);

final_score_260_c1478 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 0.5 => -0.0195145225,
    k_inq_per_ssn_i > 0.5                             => 0.0879011775,
    k_inq_per_ssn_i = NULL                            => 0.0073394025,
                                                         0.0073394025);

final_score_260 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 80 => 0.0732794090,
    r_f00_dob_score_d > 80                               => final_score_260_c1475,
    r_f00_dob_score_d = NULL                             => final_score_260_c1478,
                                                            -0.0020641129);

final_score_261_c1483 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.1205323671,
    f_phone_ver_experian_d > 0.5                                    => 0.0892391417,
    f_phone_ver_experian_d = NULL                                   => 0.1040270988,
                                                                       0.1040270988);

final_score_261_c1482 := map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d <= 13.5 => final_score_261_c1483,
    f_rel_incomeover25_count_d > 13.5                                        => 0.0343529469,
    f_rel_incomeover25_count_d = NULL                                        => 0.0793830932,
                                                                                0.0793830932);

final_score_261_c1481 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 45.5 => -0.0021748342,
    f_prevaddrlenofres_d > 45.5                                  => final_score_261_c1482,
    f_prevaddrlenofres_d = NULL                                  => 0.0410731683,
                                                                    0.0410731683);

final_score_261_c1480 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 0.5 => final_score_261_c1481,
    k_inq_adls_per_phone_i > 0.5                                    => -0.0091464885,
    k_inq_adls_per_phone_i = NULL                                   => 0.0087629199,
                                                                       0.0087629199);

final_score_261 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 3.5 => -0.0041602038,
    k_inq_per_ssn_i > 3.5                             => final_score_261_c1480,
    k_inq_per_ssn_i = NULL                            => -0.0021827638,
                                                         -0.0021827638);

final_score_262_c1487 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 499.5 => -0.0006832533,
    r_c13_max_lres_d > 499.5                              => 0.0622712185,
    r_c13_max_lres_d = NULL                               => -0.0002404607,
                                                             -0.0002404607);

final_score_262_c1488 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 298173 => -0.0084949004,
    r_a46_curr_avm_autoval_d > 298173                                      => -0.1114320841,
    r_a46_curr_avm_autoval_d = NULL                                        => 0.0012896351,
                                                                              -0.0249713954);

final_score_262_c1486 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 386.5 => final_score_262_c1487,
    f_m_bureau_adl_fs_notu_d > 386.5                                      => final_score_262_c1488,
    f_m_bureau_adl_fs_notu_d = NULL                                       => -0.0011311822,
                                                                             -0.0011311822);

final_score_262_c1485 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 8.5 => final_score_262_c1486,
    r_l79_adls_per_addr_c6_i > 8.5                                      => 0.0543435466,
    r_l79_adls_per_addr_c6_i = NULL                                     => -0.0007219840,
                                                                           -0.0007219840);

final_score_262 := map(
    NULL < f_mos_liens_unrel_ot_lseen_d AND f_mos_liens_unrel_ot_lseen_d <= 8.5 => 0.2175765638,
    f_mos_liens_unrel_ot_lseen_d > 8.5                                          => final_score_262_c1485,
    f_mos_liens_unrel_ot_lseen_d = NULL                                         => 0.0201371625,
                                                                                   0.0006483410);

final_score_263_c1492 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= -51632.5 => 0.0772325026,
    r_a49_curr_avm_chg_1yr_i > -51632.5                                      => 0.0106093834,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => -0.0074842031,
                                                                                0.0007956890);

final_score_263_c1491 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 23.5 => final_score_263_c1492,
    f_bus_addr_match_count_d > 23.5                                      => 0.0836263462,
    f_bus_addr_match_count_d = NULL                                      => 0.0016575588,
                                                                            0.0016575588);

final_score_263_c1493 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 0.5 => 0.0900726222,
    f_prevaddrlenofres_d > 0.5                                  => -0.0209622011,
    f_prevaddrlenofres_d = NULL                                 => -0.0186633976,
                                                                   -0.0186633976);

final_score_263_c1490 := map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 1.5 => final_score_263_c1491,
    f_hh_members_w_derog_i > 1.5                                    => final_score_263_c1493,
    f_hh_members_w_derog_i = NULL                                   => -0.0076817097,
                                                                       -0.0076817097);

final_score_263 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 5.5 => final_score_263_c1490,
    r_e57_br_source_count_d > 5.5                                     => 0.0582925218,
    r_e57_br_source_count_d = NULL                                    => -0.0446805047,
                                                                         -0.0074006998);

final_score_264_c1496 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 18.5 => 0.0256877697,
    f_phones_per_addr_curr_i > 18.5                                      => -0.0823902797,
    f_phones_per_addr_curr_i = NULL                                      => 0.0236935654,
                                                                            0.0236935654);

final_score_264_c1495 := map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 1.5 => final_score_264_c1496,
    f_hh_members_w_derog_i > 1.5                                    => -0.0070547334,
    f_hh_members_w_derog_i = NULL                                   => 0.0115199138,
                                                                       0.0115199138);

final_score_264_c1498 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 0.5 => -0.0238894302,
    f_rel_homeover500_count_d > 0.5                                       => -0.0966888398,
    f_rel_homeover500_count_d = NULL                                      => -0.0515626399,
                                                                             -0.0515626399);

final_score_264_c1497 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 131.95 => 0.0023489866,
    r_a49_curr_avm_chg_1yr_pct_i > 131.95                                          => final_score_264_c1498,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => -0.0125796272,
                                                                                      -0.0084774079);

final_score_264 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 1.5 => final_score_264_c1495,
    r_c18_invalid_addrs_per_adl_i > 1.5                                           => final_score_264_c1497,
    r_c18_invalid_addrs_per_adl_i = NULL                                          => -0.0218126636,
                                                                                     0.0010802916);

final_score_265_c1501 := map(
    NULL < f_hh_college_attendees_d AND f_hh_college_attendees_d <= 0.5 => 0.0090101223,
    f_hh_college_attendees_d > 0.5                                      => 0.0941919885,
    f_hh_college_attendees_d = NULL                                     => 0.0210608163,
                                                                           0.0210608163);

final_score_265_c1500 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 64846 => -0.0060067586,
    r_a49_curr_avm_chg_1yr_i > 64846                                      => final_score_265_c1501,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => -0.0024895483,
                                                                             -0.0029989061);

final_score_265_c1503 := map(
    NULL < r_i60_inq_recency_d AND r_i60_inq_recency_d <= 61.5 => -0.0133584372,
    r_i60_inq_recency_d > 61.5                                 => 0.0810203538,
    r_i60_inq_recency_d = NULL                                 => 0.0107449357,
                                                                  0.0107449357);

final_score_265_c1502 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 0.5 => 0.1084936566,
    r_c18_invalid_addrs_per_adl_i > 0.5                                           => final_score_265_c1503,
    r_c18_invalid_addrs_per_adl_i = NULL                                          => 0.0288416583,
                                                                                     0.0288416583);

final_score_265 := map(
    NULL < f_bus_phone_match_d AND f_bus_phone_match_d <= 0.5 => final_score_265_c1500,
    f_bus_phone_match_d > 0.5                                 => final_score_265_c1502,
    f_bus_phone_match_d = NULL                                => -0.0017483346,
                                                                 -0.0017483346);

final_score_266_c1508 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 15.5 => -0.0494502273,
    f_rel_under500miles_cnt_d > 15.5                                       => 0.0267567970,
    f_rel_under500miles_cnt_d = NULL                                       => -0.0331201507,
                                                                              -0.0331201507);

final_score_266_c1507 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 359.5 => -0.0021750007,
    r_c13_curr_addr_lres_d > 359.5                                    => final_score_266_c1508,
    r_c13_curr_addr_lres_d = NULL                                     => -0.0029867102,
                                                                         -0.0029867102);

final_score_266_c1506 := map(
    NULL < r_l72_add_vacant_i AND r_l72_add_vacant_i <= 0.5 => final_score_266_c1507,
    r_l72_add_vacant_i > 0.5                                => 0.1325384734,
    r_l72_add_vacant_i = NULL                               => -0.0022103793,
                                                               -0.0022103793);

final_score_266_c1505 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 13.5 => final_score_266_c1506,
    k_inq_per_ssn_i > 13.5                             => 0.0661003277,
    k_inq_per_ssn_i = NULL                             => -0.0016196798,
                                                          -0.0016196798);

final_score_266 := map(
    NULL < f_inq_banking_count24_i AND f_inq_banking_count24_i <= 6.5 => final_score_266_c1505,
    f_inq_banking_count24_i > 6.5                                     => 0.1008078108,
    f_inq_banking_count24_i = NULL                                    => 0.0215900052,
                                                                         -0.0007334770);

final_score_267_c1512 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 6.5 => -0.0290573489,
    f_rel_under100miles_cnt_d > 6.5                                       => 0.0778302895,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0403154080,
                                                                             0.0403154080);

final_score_267_c1511 := map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d <= 60.5 => final_score_267_c1512,
    f_mos_acc_lseen_d > 60.5                               => -0.0282797064,
    f_mos_acc_lseen_d = NULL                               => -0.0208214638,
                                                              -0.0208214638);

final_score_267_c1513 := map(
    NULL < f_phones_per_addr_c6_i AND f_phones_per_addr_c6_i <= 2.5 => -0.0055826825,
    f_phones_per_addr_c6_i > 2.5                                    => 0.1394537041,
    f_phones_per_addr_c6_i = NULL                                   => -0.0008741202,
                                                                       -0.0008741202);

final_score_267_c1510 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_267_c1511,
    f_phone_ver_experian_d > 0.5                                    => final_score_267_c1513,
    f_phone_ver_experian_d = NULL                                   => 0.0047050717,
                                                                       -0.0059968542);

final_score_267 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 2.5 => final_score_267_c1510,
    f_util_adl_count_n > 2.5                                => 0.0127027942,
    f_util_adl_count_n = NULL                               => 0.0476061389,
                                                               0.0016720377);

final_score_268_c1515 := map(
    NULL < f_srchphonesrchcountmo_i AND f_srchphonesrchcountmo_i <= 2.5 => -0.0002454418,
    f_srchphonesrchcountmo_i > 2.5                                      => -0.0855990677,
    f_srchphonesrchcountmo_i = NULL                                     => -0.0009615905,
                                                                           -0.0009615905);

final_score_268_c1517 := map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 7.5 => -0.0655873694,
    f_rel_homeover150_count_d > 7.5                                       => 0.0358927577,
    f_rel_homeover150_count_d = NULL                                      => -0.0150510812,
                                                                             -0.0150510812);

final_score_268_c1518 := map(
    (nf_seg_fraudpoint_3_0 in ['4: Recent Activity', '5: Vuln Vic/Friendly'])                => 0.0131458184,
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '3: Derog', '6: Other']) => 0.1133439165,
    nf_seg_fraudpoint_3_0 = ''                                                               => 0.0609527541,
                                                                                                0.0609527541);

final_score_268_c1516 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 11.5 => final_score_268_c1517,
    f_addrs_per_ssn_i > 11.5                               => final_score_268_c1518,
    f_addrs_per_ssn_i = NULL                               => 0.0267783677,
                                                              0.0267783677);

final_score_268 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 5.5 => final_score_268_c1515,
    r_wealth_index_d > 5.5                              => final_score_268_c1516,
    r_wealth_index_d = NULL                             => -0.0285519220,
                                                           -0.0004068930);

final_score_269_c1520 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 0.5 => 0.0576601890,
    k_inq_per_ssn_i > 0.5                             => -0.0089405605,
    k_inq_per_ssn_i = NULL                            => 0.0191397555,
                                                         0.0191397555);

final_score_269_c1523 := map(
    NULL < r_a44_curr_add_naprop_d AND r_a44_curr_add_naprop_d <= 2.5 => 0.0127234049,
    r_a44_curr_add_naprop_d > 2.5                                     => 0.1116760409,
    r_a44_curr_add_naprop_d = NULL                                    => 0.0510276511,
                                                                         0.0510276511);

final_score_269_c1522 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 2.5 => -0.0262643467,
    r_l79_adls_per_addr_curr_i > 2.5                                        => final_score_269_c1523,
    r_l79_adls_per_addr_curr_i = NULL                                       => 0.0003958423,
                                                                               0.0013093617);

final_score_269_c1521 := map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 1.5 => final_score_269_c1522,
    r_s66_adlperssn_count_i > 1.5                                     => -0.0327436858,
    r_s66_adlperssn_count_i = NULL                                    => -0.0152914990,
                                                                         -0.0152914990);

final_score_269 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 5.5 => 0.0003320846,
    f_addrchangeecontrajindex_d > 5.5                                         => final_score_269_c1520,
    f_addrchangeecontrajindex_d = NULL                                        => final_score_269_c1521,
                                                                                 -0.0017807209);

final_score_270_c1528 := map(
    NULL < f_prevaddrstatus_i AND f_prevaddrstatus_i <= 2.5 => -0.0149799656,
    f_prevaddrstatus_i > 2.5                                => 0.0244417997,
    f_prevaddrstatus_i = NULL                               => 0.0252438780,
                                                               0.0136029634);

final_score_270_c1527 := map(
    NULL < r_i60_inq_retail_recency_d AND r_i60_inq_retail_recency_d <= 549 => -0.0200855304,
    r_i60_inq_retail_recency_d > 549                                        => final_score_270_c1528,
    r_i60_inq_retail_recency_d = NULL                                       => 0.0040349366,
                                                                               0.0040349366);

final_score_270_c1526 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_270_c1527,
    r_phn_cell_n > 0.5                          => -0.0130464445,
    r_phn_cell_n = NULL                         => -0.0056780239,
                                                   -0.0056780239);

final_score_270_c1525 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 0.5 => -0.0730308884,
    r_c13_curr_addr_lres_d > 0.5                                    => final_score_270_c1526,
    r_c13_curr_addr_lres_d = NULL                                   => 0.0070218789,
                                                                       -0.0063489845);

final_score_270 := map(
    NULL < k_inq_adls_per_addr_i AND k_inq_adls_per_addr_i <= 5.5 => final_score_270_c1525,
    k_inq_adls_per_addr_i > 5.5                                   => 0.0555100863,
    k_inq_adls_per_addr_i = NULL                                  => -0.0060042835,
                                                                     -0.0060042835);

final_score_271_c1532 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 4.5 => -0.0382147308,
    f_assocsuspicousidcount_i > 4.5                                       => 0.0759552091,
    f_assocsuspicousidcount_i = NULL                                      => -0.0240625571,
                                                                             -0.0240625571);

final_score_271_c1533 := map(
    NULL < r_c12_num_nonderogs_d AND r_c12_num_nonderogs_d <= 3.5 => 0.0729361482,
    r_c12_num_nonderogs_d > 3.5                                   => -0.0242462815,
    r_c12_num_nonderogs_d = NULL                                  => 0.0359462960,
                                                                     0.0359462960);

final_score_271_c1531 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 193.5 => final_score_271_c1532,
    f_prevaddrlenofres_d > 193.5                                  => final_score_271_c1533,
    f_prevaddrlenofres_d = NULL                                   => -0.0086879484,
                                                                     -0.0086879484);

final_score_271_c1530 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 0.5 => final_score_271_c1531,
    k_inq_per_phone_i > 0.5                               => -0.0713341406,
    k_inq_per_phone_i = NULL                              => -0.0311836265,
                                                             -0.0311836265);

final_score_271 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 33016.5 => 0.0040474175,
    r_a49_curr_avm_chg_1yr_i > 33016.5                                      => final_score_271_c1530,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => 0.0079304130,
                                                                               0.0028538549);

final_score_272_c1536 := map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 25.5 => 0.0049576213,
    f_rel_homeover150_count_d > 25.5                                       => 0.0893492893,
    f_rel_homeover150_count_d = NULL                                       => 0.0074519563,
                                                                              0.0074519563);

final_score_272_c1535 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 389.5 => final_score_272_c1536,
    r_c10_m_hdr_fs_d > 389.5                              => 0.0954003880,
    r_c10_m_hdr_fs_d = NULL                               => 0.0137642581,
                                                             0.0137642581);

final_score_272_c1538 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 369.5 => -0.0291969777,
    r_c21_m_bureau_adl_fs_d > 369.5                                     => -0.1074388121,
    r_c21_m_bureau_adl_fs_d = NULL                                      => -0.0351755896,
                                                                           -0.0351755896);

final_score_272_c1537 := map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i <= 4.5 => -0.0044170335,
    k_inq_per_addr_i > 4.5                              => final_score_272_c1538,
    k_inq_per_addr_i = NULL                             => -0.0088206672,
                                                           -0.0088206672);

final_score_272 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 206.5 => final_score_272_c1535,
    r_d32_mos_since_crim_ls_d > 206.5                                       => final_score_272_c1537,
    r_d32_mos_since_crim_ls_d = NULL                                        => -0.0105692011,
                                                                               -0.0041139713);

final_score_273_c1542 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 293553.5 => -0.0150120228,
    r_l80_inp_avm_autoval_d > 293553.5                                     => -0.0908199651,
    r_l80_inp_avm_autoval_d = NULL                                         => -0.0172179589,
                                                                              -0.0203335997);

final_score_273_c1541 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 2.5 => final_score_273_c1542,
    f_rel_homeover100_count_d > 2.5                                       => 0.0060409284,
    f_rel_homeover100_count_d = NULL                                      => 0.0162298832,
                                                                             0.0031692601);

final_score_273_c1540 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 85.95 => final_score_273_c1541,
    r_c12_source_profile_d > 85.95                                    => 0.0648778276,
    r_c12_source_profile_d = NULL                                     => 0.0020241433,
                                                                         0.0037106793);

final_score_273_c1543 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 17489 => 0.0092534147,
    r_a49_curr_avm_chg_1yr_i > 17489                                      => -0.1010665703,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => -0.0345086750,
                                                                             -0.0341233226);

final_score_273 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 15.5 => final_score_273_c1540,
    f_bus_addr_match_count_d > 15.5                                      => final_score_273_c1543,
    f_bus_addr_match_count_d = NULL                                      => 0.0028193338,
                                                                            0.0028193338);

final_score_274_c1545 := map(
    NULL < r_l70_add_invalid_i AND r_l70_add_invalid_i <= 0.5 => -0.0057085303,
    r_l70_add_invalid_i > 0.5                                 => -0.0599302651,
    r_l70_add_invalid_i = NULL                                => -0.0066254236,
                                                                 -0.0066254236);

final_score_274_c1548 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 1.5 => 0.1506488174,
    f_assocsuspicousidcount_i > 1.5                                       => 0.0236704457,
    f_assocsuspicousidcount_i = NULL                                      => 0.0830302536,
                                                                             0.0830302536);

final_score_274_c1547 := map(
    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i <= 1.5 => final_score_274_c1548,
    k_inq_addrs_per_ssn_i > 1.5                                   => 0.0070634988,
    k_inq_addrs_per_ssn_i = NULL                                  => 0.0430016174,
                                                                     0.0430016174);

final_score_274_c1546 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 2.5 => -0.0541246738,
    f_phone_ver_insurance_d > 2.5                                     => final_score_274_c1547,
    f_phone_ver_insurance_d = NULL                                    => 0.0272556216,
                                                                         0.0272556216);

final_score_274 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 5.5 => final_score_274_c1545,
    k_inq_per_phone_i > 5.5                               => final_score_274_c1546,
    k_inq_per_phone_i = NULL                              => -0.0054949771,
                                                             -0.0054949771);

final_score_275_c1552 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => 0.0139609922,
    f_phone_ver_insurance_d > 3.5                                     => -0.0084709826,
    f_phone_ver_insurance_d = NULL                                    => -0.0072634886,
                                                                         0.0001221396);

final_score_275_c1551 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 3.5 => final_score_275_c1552,
    k_inq_lnames_per_addr_i > 3.5                                     => 0.0779164885,
    k_inq_lnames_per_addr_i = NULL                                    => 0.0008990558,
                                                                         0.0008990558);

final_score_275_c1553 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 4.5 => -0.0136411954,
    r_e57_br_source_count_d > 4.5                                     => -0.1241156961,
    r_e57_br_source_count_d = NULL                                    => -0.0153752511,
                                                                         -0.0153752511);

final_score_275_c1550 := map(
    NULL < f_adl_util_misc_n AND f_adl_util_misc_n <= 0.5 => final_score_275_c1551,
    f_adl_util_misc_n > 0.5                               => final_score_275_c1553,
    f_adl_util_misc_n = NULL                              => -0.0048184259,
                                                             -0.0048184259);

final_score_275 := map(
    NULL < nf_inq_per_add_nas_479 AND nf_inq_per_add_nas_479 <= 1.5 => final_score_275_c1550,
    nf_inq_per_add_nas_479 > 1.5                                    => -0.0494534527,
    nf_inq_per_add_nas_479 = NULL                                   => -0.0052162552,
                                                                       -0.0052162552);

final_score_276_c1558 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 1.5 => 0.1202281525,
    f_srchvelocityrisktype_i > 1.5                                      => 0.0425278122,
    f_srchvelocityrisktype_i = NULL                                     => 0.0652267880,
                                                                           0.0652267880);

final_score_276_c1557 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 3.5 => 0.0435702893,
    f_addrchangeecontrajindex_d > 3.5                                         => final_score_276_c1558,
    f_addrchangeecontrajindex_d = NULL                                        => 0.0026828479,
                                                                                 0.0424544092);

final_score_276_c1556 := map(
    NULL < k_inq_lnames_per_ssn_i AND k_inq_lnames_per_ssn_i <= 0.5 => final_score_276_c1557,
    k_inq_lnames_per_ssn_i > 0.5                                    => -0.0129331177,
    k_inq_lnames_per_ssn_i = NULL                                   => 0.0252871903,
                                                                       0.0252871903);

final_score_276_c1555 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_276_c1556,
    r_phn_cell_n > 0.5                          => -0.0053269207,
    r_phn_cell_n = NULL                         => 0.0081851651,
                                                   0.0081851651);

final_score_276 := map(
    NULL < r_i60_inq_banking_recency_d AND r_i60_inq_banking_recency_d <= 549 => -0.0070243641,
    r_i60_inq_banking_recency_d > 549                                         => final_score_276_c1555,
    r_i60_inq_banking_recency_d = NULL                                        => -0.0128009026,
                                                                                 0.0002238843);

final_score_277_c1561 := map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 0.5 => 0.1200499246,
    f_rel_incomeover100_count_d > 0.5                                         => -0.0047691608,
    f_rel_incomeover100_count_d = NULL                                        => 0.0567901156,
                                                                                 0.0567901156);

final_score_277_c1560 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 440.5 => -0.0041372660,
    f_m_bureau_adl_fs_all_d > 440.5                                     => final_score_277_c1561,
    f_m_bureau_adl_fs_all_d = NULL                                      => -0.0014574543,
                                                                           -0.0014574543);

final_score_277_c1562 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 62.75 => 0.0185188480,
    r_c12_source_profile_d > 62.75                                    => -0.1307376527,
    r_c12_source_profile_d = NULL                                     => -0.0456103710,
                                                                         -0.0456103710);

final_score_277_c1563 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 78.85 => 0.0005283015,
    r_c12_source_profile_d > 78.85                                    => 0.0424052455,
    r_c12_source_profile_d = NULL                                     => 0.0149364482,
                                                                         0.0027862778);

final_score_277 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 114858.5 => final_score_277_c1560,
    r_a49_curr_avm_chg_1yr_i > 114858.5                                      => final_score_277_c1562,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => final_score_277_c1563,
                                                                                0.0002328076);

final_score_278_c1568 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 0.5 => 0.0666454696,
    k_inq_per_phone_i > 0.5                               => -0.0162796526,
    k_inq_per_phone_i = NULL                              => 0.0354902493,
                                                             0.0354902493);

final_score_278_c1567 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 2.5 => -0.0065422099,
    f_rel_homeover300_count_d > 2.5                                       => final_score_278_c1568,
    f_rel_homeover300_count_d = NULL                                      => 0.0055077276,
                                                                             0.0055077276);

final_score_278_c1566 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 2.5 => final_score_278_c1567,
    f_srchcomponentrisktype_i > 2.5                                       => 0.0870087136,
    f_srchcomponentrisktype_i = NULL                                      => 0.0092711914,
                                                                             0.0092711914);

final_score_278_c1565 := map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i <= 0.5 => -0.0042283259,
    r_l70_add_standardized_i > 0.5                                      => final_score_278_c1566,
    r_l70_add_standardized_i = NULL                                     => -0.0017823802,
                                                                           -0.0017823802);

final_score_278 := map(
    NULL < f_recent_disconnects_i AND f_recent_disconnects_i <= 1.5 => final_score_278_c1565,
    f_recent_disconnects_i > 1.5                                    => -0.0691898203,
    f_recent_disconnects_i = NULL                                   => -0.0021470926,
                                                                       -0.0021470926);

final_score_279_c1571 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 16.5 => -0.0327059364,
    f_addrs_per_ssn_i > 16.5                               => 0.0408567321,
    f_addrs_per_ssn_i = NULL                               => -0.0258960032,
                                                              -0.0258960032);

final_score_279_c1573 := map(
    NULL < f_hh_members_ct_d AND f_hh_members_ct_d <= 8.5 => 0.0669481917,
    f_hh_members_ct_d > 8.5                               => -0.0543153259,
    f_hh_members_ct_d = NULL                              => 0.0539716529,
                                                             0.0539716529);

final_score_279_c1572 := map(
    NULL < f_hh_college_attendees_d AND f_hh_college_attendees_d <= 0.5 => 0.0033640255,
    f_hh_college_attendees_d > 0.5                                      => final_score_279_c1573,
    f_hh_college_attendees_d = NULL                                     => 0.0164318359,
                                                                           0.0164318359);

final_score_279_c1570 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 403.5 => final_score_279_c1571,
    r_a49_curr_avm_chg_1yr_i > 403.5                                      => final_score_279_c1572,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => 0.0039674001,
                                                                             0.0036174810);

final_score_279 := map(
    r_d31_bk_chapter_n != '' and NULL < (integer)r_d31_bk_chapter_n AND (integer)r_d31_bk_chapter_n <= 12 		=> -0.0280202938,
    (integer)r_d31_bk_chapter_n > 12                                						=> -0.0509431203,
    r_d31_bk_chapter_n = ''                              						=> final_score_279_c1570,
																																										-0.0060283400);

final_score_280_c1577 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 5.5 => -0.0022737337,
    f_addrchangeecontrajindex_d > 5.5                                         => -0.0320992825,
    f_addrchangeecontrajindex_d = NULL                                        => -0.0008847105,
                                                                                 -0.0025849545);

final_score_280_c1578 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '4: Recent Activity', '6: Other']) => -0.0097938013,
    (nf_seg_fraudpoint_3_0 in ['3: Derog', '5: Vuln Vic/Friendly'])                                    => 0.0942581337,
    nf_seg_fraudpoint_3_0 = ''	                                                                       => 0.0408749670,
                                                                                                          0.0408749670);

final_score_280_c1576 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 10.5 => final_score_280_c1577,
    f_rel_homeover500_count_d > 10.5                                       => final_score_280_c1578,
    f_rel_homeover500_count_d = NULL                                       => -0.0111656518,
                                                                              -0.0021897417);

final_score_280_c1575 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 546.5 => final_score_280_c1576,
    f_m_bureau_adl_fs_all_d > 546.5                                     => 0.0759899377,
    f_m_bureau_adl_fs_all_d = NULL                                      => -0.0017683560,
                                                                           -0.0017683560);

final_score_280 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 27.5 => final_score_280_c1575,
    f_phones_per_addr_curr_i > 27.5                                      => -0.0639596704,
    f_phones_per_addr_curr_i = NULL                                      => -0.0258043391,
                                                                            -0.0023641137);

final_score_281_c1582 := map(
    NULL < f_current_count_d AND f_current_count_d <= 9.5 => 0.0023399073,
    f_current_count_d > 9.5                               => 0.1187446530,
    f_current_count_d = NULL                              => 0.0031885205,
                                                             0.0031885205);

final_score_281_c1581 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 394.5 => final_score_281_c1582,
    f_m_bureau_adl_fs_notu_d > 394.5                                      => -0.0590636756,
    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0023144160,
                                                                             0.0023144160);

final_score_281_c1583 := map(
    NULL < f_hh_bankruptcies_i AND f_hh_bankruptcies_i <= 0.5 => -0.1382182671,
    f_hh_bankruptcies_i > 0.5                                 => -0.0172496049,
    f_hh_bankruptcies_i = NULL                                => -0.0483387504,
                                                                 -0.0483387504);

final_score_281_c1580 := map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 4.5 => final_score_281_c1581,
    f_hh_members_w_derog_i > 4.5                                    => final_score_281_c1583,
    f_hh_members_w_derog_i = NULL                                   => -0.0239481825,
                                                                       0.0004052679);

final_score_281 := map(
    NULL < f_recent_disconnects_i AND f_recent_disconnects_i <= 1.5 => final_score_281_c1580,
    f_recent_disconnects_i > 1.5                                    => 0.0545791049,
    f_recent_disconnects_i = NULL                                   => 0.0007098736,
                                                                       0.0007098736);

final_score_282_c1586 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 15.5 => 0.0063997432,
    f_rel_under25miles_cnt_d > 15.5                                      => 0.1375252362,
    f_rel_under25miles_cnt_d = NULL                                      => 0.0227402030,
                                                                            0.0227402030);

final_score_282_c1588 := map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 0.5 => 0.0655115992,
    f_hh_members_w_derog_i > 0.5                                    => -0.0431065332,
    f_hh_members_w_derog_i = NULL                                   => -0.0164076131,
                                                                       -0.0164076131);

final_score_282_c1587 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 2.5 => final_score_282_c1588,
    f_bus_addr_match_count_d > 2.5                                      => 0.0896339638,
    f_bus_addr_match_count_d = NULL                                     => -0.0040662287,
                                                                           -0.0040662287);

final_score_282_c1585 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= -11671.5 => 0.1566666431,
    r_a49_curr_avm_chg_1yr_i > -11671.5                                      => final_score_282_c1586,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => final_score_282_c1587,
                                                                                0.0161377142);

final_score_282 := map(
    NULL < r_i60_inq_retpymt_recency_d AND r_i60_inq_retpymt_recency_d <= 549 => final_score_282_c1585,
    r_i60_inq_retpymt_recency_d > 549                                         => -0.0031944470,
    r_i60_inq_retpymt_recency_d = NULL                                        => 0.0244325700,
                                                                                 -0.0003694713);

final_score_283_c1592 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 11.5 => -0.0371858878,
    f_rel_homeover100_count_d > 11.5                                       => 0.0677689655,
    f_rel_homeover100_count_d = NULL                                       => -0.0101974970,
                                                                              -0.0101974970);

final_score_283_c1591 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 277125.5 => -0.0096433087,
    r_a46_curr_avm_autoval_d > 277125.5                                      => -0.0754367264,
    r_a46_curr_avm_autoval_d = NULL                                          => final_score_283_c1592,
                                                                                -0.0232504154);

final_score_283_c1590 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 417.5 => 0.0018648971,
    r_c10_m_hdr_fs_d > 417.5                              => final_score_283_c1591,
    r_c10_m_hdr_fs_d = NULL                               => 0.0003132405,
                                                             0.0003132405);

final_score_283_c1593 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 24.5 => 0.1196981764,
    f_prevaddrageoldest_d > 24.5                                   => -0.0013990980,
    f_prevaddrageoldest_d = NULL                                   => 0.0560802534,
                                                                      0.0560802534);

final_score_283 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 2.5 => final_score_283_c1590,
    f_srchunvrfdphonecount_i > 2.5                                      => final_score_283_c1593,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0024703075,
                                                                           0.0009257758);

final_score_284_c1598 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => -0.0596875832,
    f_phone_ver_experian_d > 0.5                                    => -0.0136085925,
    f_phone_ver_experian_d = NULL                                   => -0.0307643990,
                                                                       -0.0307643990);

final_score_284_c1597 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 2.5 => final_score_284_c1598,
    f_srchvelocityrisktype_i > 2.5                                      => 0.0130069667,
    f_srchvelocityrisktype_i = NULL                                     => -0.0143752223,
                                                                           -0.0143752223);

final_score_284_c1596 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 294862 => 0.0012575907,
    r_a46_curr_avm_autoval_d > 294862                                      => final_score_284_c1597,
    r_a46_curr_avm_autoval_d = NULL                                        => 0.0019225149,
                                                                              -0.0001735395);

final_score_284_c1595 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 4.5 => final_score_284_c1596,
    k_inq_lnames_per_addr_i > 4.5                                     => -0.0689498243,
    k_inq_lnames_per_addr_i = NULL                                    => -0.0006261152,
                                                                         -0.0006261152);

final_score_284 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 19.5 => final_score_284_c1595,
    f_rel_homeover300_count_d > 19.5                                       => 0.0612429449,
    f_rel_homeover300_count_d = NULL                                       => 0.0174440522,
                                                                              0.0006868796);

final_score_285_c1603 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 1.5 => -0.0661302523,
    r_c14_addrs_5yr_i > 1.5                               => 0.0875638382,
    r_c14_addrs_5yr_i = NULL                              => -0.0094785057,
                                                             -0.0094785057);

final_score_285_c1602 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 108.5 => final_score_285_c1603,
    f_prevaddrlenofres_d > 108.5                                  => 0.0807462963,
    f_prevaddrlenofres_d = NULL                                   => 0.0254411353,
                                                                     0.0254411353);

final_score_285_c1601 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 98 => final_score_285_c1602,
    r_f00_dob_score_d > 98                               => 0.0032368061,
    r_f00_dob_score_d = NULL                             => -0.0063386462,
                                                            0.0037288628);

final_score_285_c1600 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 7.5 => final_score_285_c1601,
    f_inq_count24_i > 7.5                             => -0.0384278464,
    f_inq_count24_i = NULL                            => 0.0132726811,
                                                         -0.0000607019);

final_score_285 := map(
    NULL < f_addrs_per_ssn_c6_i AND f_addrs_per_ssn_c6_i <= 1.5 => final_score_285_c1600,
    f_addrs_per_ssn_c6_i > 1.5                                  => 0.0701299847,
    f_addrs_per_ssn_c6_i = NULL                                 => 0.0006486344,
                                                                   0.0006486344);

final_score_286_c1605 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 1.5 => 0.1890367606,
    k_inq_ssns_per_addr_i > 1.5                                   => 0.0197341953,
    k_inq_ssns_per_addr_i = NULL                                  => 0.1043854780,
                                                                     0.1043854780);

final_score_286_c1608 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 7.5 => -0.0405517007,
    f_addrs_per_ssn_i > 7.5                               => 0.0014258551,
    f_addrs_per_ssn_i = NULL                              => -0.0141094007,
                                                             -0.0141094007);

final_score_286_c1607 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 254617.5 => 0.0058343744,
    r_l80_inp_avm_autoval_d > 254617.5                                     => final_score_286_c1608,
    r_l80_inp_avm_autoval_d = NULL                                         => -0.0038038753,
                                                                              -0.0011264763);

final_score_286_c1606 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 474.5 => final_score_286_c1607,
    r_c13_curr_addr_lres_d > 474.5                                    => -0.0553196957,
    r_c13_curr_addr_lres_d = NULL                                     => -0.0014466249,
                                                                         -0.0014466249);

final_score_286 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 2 => final_score_286_c1605,
    r_i60_inq_hiriskcred_recency_d > 2                                            => final_score_286_c1606,
    r_i60_inq_hiriskcred_recency_d = NULL                                         => 0.0042661525,
                                                                                     -0.0001676559);

final_score_287_c1611 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 95 => 0.0175883359,
    r_f01_inp_addr_address_score_d > 95                                            => -0.0050182323,
    r_f01_inp_addr_address_score_d = NULL                                          => -0.0038506681,
                                                                                      -0.0038506681);

final_score_287_c1612 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 311.5 => 0.0982899758,
    r_c10_m_hdr_fs_d > 311.5                              => -0.0164393176,
    r_c10_m_hdr_fs_d = NULL                               => 0.0504029664,
                                                             0.0504029664);

final_score_287_c1610 := map(
    NULL < f_hh_prof_license_holders_d AND f_hh_prof_license_holders_d <= 1.5 => final_score_287_c1611,
    f_hh_prof_license_holders_d > 1.5                                         => final_score_287_c1612,
    f_hh_prof_license_holders_d = NULL                                        => -0.0028261181,
                                                                                 -0.0028261181);

final_score_287_c1613 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 0.5 => 0.0087357713,
    k_inq_per_ssn_i > 0.5                             => 0.0596331432,
    k_inq_per_ssn_i = NULL                            => 0.0230365816,
                                                         0.0230365816);

final_score_287 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 80 => -0.0513201969,
    r_f00_dob_score_d > 80                               => final_score_287_c1610,
    r_f00_dob_score_d = NULL                             => final_score_287_c1613,
                                                            -0.0025351182);

final_score_288_c1617 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 473.5 => 0.0135810753,
    r_p88_phn_dst_to_inp_add_i > 473.5                                        => -0.0757002203,
    r_p88_phn_dst_to_inp_add_i = NULL                                         => 0.0078632174,
                                                                                 0.0112548262);

final_score_288_c1616 := map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i <= 15.5 => final_score_288_c1617,
    k_inq_per_addr_i > 15.5                              => 0.0664404449,
    k_inq_per_addr_i = NULL                              => 0.0119513164,
                                                            0.0119513164);

final_score_288_c1615 := map(
    NULL < r_c15_ssns_per_adl_c6_i AND r_c15_ssns_per_adl_c6_i <= 0.5 => final_score_288_c1616,
    r_c15_ssns_per_adl_c6_i > 0.5                                     => -0.0721522234,
    r_c15_ssns_per_adl_c6_i = NULL                                    => 0.0083388044,
                                                                         0.0083388044);

final_score_288_c1618 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 83.25 => -0.0190422035,
    r_c12_source_profile_d > 83.25                                    => 0.0467947029,
    r_c12_source_profile_d = NULL                                     => -0.0166307672,
                                                                         -0.0166307672);

final_score_288 := map(
    NULL < f_dl_addrs_per_adl_i AND f_dl_addrs_per_adl_i <= 0.5 => final_score_288_c1615,
    f_dl_addrs_per_adl_i > 0.5                                  => final_score_288_c1618,
    f_dl_addrs_per_adl_i = NULL                                 => 0.0040145634,
                                                                   -0.0028393303);

final_score_289_c1623 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => 0.0351770826,
    r_c23_inp_addr_occ_index_d > 2                                        => 0.1463650331,
    r_c23_inp_addr_occ_index_d = NULL                                     => 0.0696608207,
                                                                             0.0696608207);

final_score_289_c1622 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 1.5 => 0.0140786886,
    k_inq_per_ssn_i > 1.5                             => final_score_289_c1623,
    k_inq_per_ssn_i = NULL                            => 0.0267752429,
                                                         0.0267752429);

final_score_289_c1621 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_289_c1622,
    f_phone_ver_experian_d > 0.5                                    => -0.0037838108,
    f_phone_ver_experian_d = NULL                                   => 0.0059782229,
                                                                       0.0063181790);

final_score_289_c1620 := map(
    NULL < r_i60_inq_count12_i AND r_i60_inq_count12_i <= 2.5 => final_score_289_c1621,
    r_i60_inq_count12_i > 2.5                                 => -0.0300020174,
    r_i60_inq_count12_i = NULL                                => 0.0157883917,
                                                                 -0.0017710168);

final_score_289 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 170787.5 => -0.0034743846,
    r_a49_curr_avm_chg_1yr_i > 170787.5                                      => 0.0505504462,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => final_score_289_c1620,
                                                                                -0.0022085678);

final_score_290_c1626 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 76.5 => -0.0029837142,
    f_prevaddrageoldest_d > 76.5                                   => 0.0709504854,
    f_prevaddrageoldest_d = NULL                                   => 0.0348430856,
                                                                      0.0348430856);

final_score_290_c1625 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 10.5 => -0.0031500306,
    f_rel_homeover500_count_d > 10.5                                       => final_score_290_c1626,
    f_rel_homeover500_count_d = NULL                                       => 0.0118565634,
                                                                              -0.0024144828);

final_score_290_c1628 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 165.5 => -0.0081727179,
    r_c13_curr_addr_lres_d > 165.5                                    => 0.1236536774,
    r_c13_curr_addr_lres_d = NULL                                     => 0.0301063985,
                                                                         0.0301063985);

final_score_290_c1627 := map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 15.5 => final_score_290_c1628,
    f_rel_homeover150_count_d > 15.5                                       => 0.1411508947,
    f_rel_homeover150_count_d = NULL                                       => 0.0460806766,
                                                                              0.0460806766);

final_score_290 := map(
    NULL < f_mos_liens_rel_ot_fseen_d AND f_mos_liens_rel_ot_fseen_d <= 66.5 => final_score_290_c1625,
    f_mos_liens_rel_ot_fseen_d > 66.5                                        => final_score_290_c1627,
    f_mos_liens_rel_ot_fseen_d = NULL                                        => 0.0246617018,
                                                                                -0.0002888566);

final_score_291_c1631 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 3.5 => -0.0065445129,
    f_rel_homeover500_count_d > 3.5                                       => 0.0220608282,
    f_rel_homeover500_count_d = NULL                                      => -0.0048872766,
                                                                             -0.0048872766);

final_score_291_c1633 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 394.5 => 0.0219029483,
    r_c10_m_hdr_fs_d > 394.5                              => 0.1103271507,
    r_c10_m_hdr_fs_d = NULL                               => 0.0278400019,
                                                             0.0278400019);

final_score_291_c1632 := map(
    NULL < f_bus_fname_verd_d AND f_bus_fname_verd_d <= 0.5 => final_score_291_c1633,
    f_bus_fname_verd_d > 0.5                                => 0.1529627009,
    f_bus_fname_verd_d = NULL                               => 0.0332689676,
                                                               0.0332689676);

final_score_291_c1630 := map(
    NULL < f_assocrisktype_i AND f_assocrisktype_i <= 3.5 => final_score_291_c1631,
    f_assocrisktype_i > 3.5                               => final_score_291_c1632,
    f_assocrisktype_i = NULL                              => 0.0019142261,
                                                             0.0019142261);

final_score_291 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 15.5 => final_score_291_c1630,
    f_rel_incomeover50_count_d > 15.5                                        => -0.0327713032,
    f_rel_incomeover50_count_d = NULL                                        => -0.0028290450,
                                                                                -0.0017663150);

final_score_292_c1638 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 7.5 => 0.0340834688,
    f_rel_homeover100_count_d > 7.5                                       => 0.1841259841,
    f_rel_homeover100_count_d = NULL                                      => 0.0500983694,
                                                                             0.0500983694);

final_score_292_c1637 := map(
    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i <= 0.5 => final_score_292_c1638,
    k_inq_addrs_per_ssn_i > 0.5                                   => -0.0438532204,
    k_inq_addrs_per_ssn_i = NULL                                  => 0.0136377651,
                                                                     0.0136377651);

final_score_292_c1636 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 2.5 => final_score_292_c1637,
    f_rel_incomeover50_count_d > 2.5                                        => -0.0121369304,
    f_rel_incomeover50_count_d = NULL                                       => -0.0083466045,
                                                                               -0.0083466045);

final_score_292_c1635 := map(
    NULL < f_curraddractivephonelist_d AND f_curraddractivephonelist_d <= 0.5 => 0.0085980997,
    f_curraddractivephonelist_d > 0.5                                         => final_score_292_c1636,
    f_curraddractivephonelist_d = NULL                                        => -0.0492763087,
                                                                                 -0.0016467461);

final_score_292 := map(
    NULL < f_inq_retailpayments_count24_i AND f_inq_retailpayments_count24_i <= 1.5 => final_score_292_c1635,
    f_inq_retailpayments_count24_i > 1.5                                            => 0.0969493793,
    f_inq_retailpayments_count24_i = NULL                                           => 0.0114043067,
                                                                                       -0.0007198656);

final_score_293_c1641 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 384.5 => -0.0233916173,
    r_c10_m_hdr_fs_d > 384.5                              => 0.0561441775,
    r_c10_m_hdr_fs_d = NULL                               => -0.0138383658,
                                                             -0.0138383658);

final_score_293_c1640 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 54999 => final_score_293_c1641,
    r_a49_curr_avm_chg_1yr_i > 54999                                      => 0.0834112878,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => -0.0147584156,
                                                                             -0.0129163450);

final_score_293_c1643 := map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d <= 1.5 => -0.0324788554,
    r_c14_addr_stability_v2_d > 1.5                                       => 0.0284271029,
    r_c14_addr_stability_v2_d = NULL                                      => 0.0214045538,
                                                                             0.0214045538);

final_score_293_c1642 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 10.5 => final_score_293_c1643,
    f_rel_educationover12_count_d > 10.5                                           => -0.0039059121,
    f_rel_educationover12_count_d = NULL                                           => 0.0099779710,
                                                                                      0.0099779710);

final_score_293 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 3.5 => final_score_293_c1640,
    r_wealth_index_d > 3.5                              => final_score_293_c1642,
    r_wealth_index_d = NULL                             => -0.0148816880,
                                                           -0.0015196314);

final_score_294_c1647 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => -0.0578822906,
    f_phone_ver_experian_d > 0.5                                    => 0.0444665567,
    f_phone_ver_experian_d = NULL                                   => 0.0051296332,
                                                                       0.0051296332);

final_score_294_c1646 := map(
    NULL < f_hh_tot_derog_i AND f_hh_tot_derog_i <= 1.5 => -0.1031408810,
    f_hh_tot_derog_i > 1.5                              => final_score_294_c1647,
    f_hh_tot_derog_i = NULL                             => -0.0371600768,
                                                           -0.0371600768);

final_score_294_c1648 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 6.5 => 0.0416424655,
    f_rel_homeover100_count_d > 6.5                                       => -0.0377875960,
    f_rel_homeover100_count_d = NULL                                      => -0.0113941688,
                                                                             -0.0113941688);

final_score_294_c1645 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 0.5 => final_score_294_c1646,
    f_historical_count_d > 0.5                                  => final_score_294_c1648,
    f_historical_count_d = NULL                                 => -0.0201196044,
                                                                   -0.0201196044);

final_score_294 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 5.5 => 0.0000569864,
    f_bus_addr_match_count_d > 5.5                                      => final_score_294_c1645,
    f_bus_addr_match_count_d = NULL                                     => -0.0014890469,
                                                                           -0.0014890469);

final_score_295_c1653 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 151 => 0.0663402783,
    f_prevaddrageoldest_d > 151                                   => -0.0451827401,
    f_prevaddrageoldest_d = NULL                                  => 0.0420551390,
                                                                     0.0420551390);

final_score_295_c1652 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 0.5 => 0.1217693641,
    f_rel_homeover200_count_d > 0.5                                       => final_score_295_c1653,
    f_rel_homeover200_count_d = NULL                                      => 0.0600593339,
                                                                             0.0600593339);

final_score_295_c1651 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 1.5 => 0.0054783807,
    k_inq_per_phone_i > 1.5                               => final_score_295_c1652,
    k_inq_per_phone_i = NULL                              => 0.0116929489,
                                                             0.0116929489);

final_score_295_c1650 := map(
    NULL < (real)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d <= 0.5 => final_score_295_c1651,
    (real)k_nap_phn_verd_d > 0.5                              => -0.0067712484,
    (real)k_nap_phn_verd_d = NULL                             => -0.0010798184,
                                                           -0.0010798184);

final_score_295 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 579.5 => final_score_295_c1650,
    r_c21_m_bureau_adl_fs_d > 579.5                                     => -0.0877240750,
    r_c21_m_bureau_adl_fs_d = NULL                                      => 0.0177992084,
                                                                           -0.0016932600);

final_score_296_c1657 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 71950 => -0.0058434440,
    r_a49_curr_avm_chg_1yr_i > 71950                                      => 0.0582315178,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => 0.0030590795,
                                                                             0.0000274857);

final_score_296_c1656 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => final_score_296_c1657,
    r_f03_input_add_not_most_rec_i > 0.5                                            => 0.0682894216,
    r_f03_input_add_not_most_rec_i = NULL                                           => 0.0009960303,
                                                                                       0.0009960303);

final_score_296_c1658 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => -0.0445869997,
    f_phone_ver_experian_d > 0.5                                    => 0.0038847542,
    f_phone_ver_experian_d = NULL                                   => -0.0146646623,
                                                                       -0.0146646623);

final_score_296_c1655 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 4.5 => final_score_296_c1656,
    f_addrchangeecontrajindex_d > 4.5                                         => final_score_296_c1658,
    f_addrchangeecontrajindex_d = NULL                                        => -0.0154113085,
                                                                                 -0.0020791134);

final_score_296 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= -0.5 => 0.0621820221,
    f_prevaddrageoldest_d > -0.5                                   => final_score_296_c1655,
    f_prevaddrageoldest_d = NULL                                   => 0.0005910990,
                                                                      -0.0015394683);

final_score_297_c1661 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 102.5 => -0.0091139067,
    r_d32_mos_since_crim_ls_d > 102.5                                       => 0.0649597099,
    r_d32_mos_since_crim_ls_d = NULL                                        => 0.0154621212,
                                                                               0.0154621212);

final_score_297_c1663 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => 0.0129916738,
    r_i61_inq_collection_recency_d > 549                                            => 0.1335697108,
    r_i61_inq_collection_recency_d = NULL                                           => 0.0465123681,
                                                                                       0.0465123681);

final_score_297_c1662 := map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d <= 5.5 => 0.0043703823,
    r_c14_addr_stability_v2_d > 5.5                                       => final_score_297_c1663,
    r_c14_addr_stability_v2_d = NULL                                      => 0.0154138796,
                                                                             0.0154138796);

final_score_297_c1660 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 84500 => final_score_297_c1661,
    r_a49_curr_avm_chg_1yr_i > 84500                                      => 0.0877652758,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => final_score_297_c1662,
                                                                             0.0176987895);

final_score_297 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 186.5 => final_score_297_c1660,
    r_d32_mos_since_crim_ls_d > 186.5                                       => -0.0023592834,
    r_d32_mos_since_crim_ls_d = NULL                                        => -0.0037911038,
                                                                               0.0016073032);

final_score_298_c1667 := map(
    NULL < r_c12_num_nonderogs_d AND r_c12_num_nonderogs_d <= 5.5 => 0.0090523477,
    r_c12_num_nonderogs_d > 5.5                                   => 0.0742918646,
    r_c12_num_nonderogs_d = NULL                                  => 0.0124012414,
                                                                     0.0124012414);

final_score_298_c1666 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_298_c1667,
    r_phn_cell_n > 0.5                          => -0.0050537439,
    r_phn_cell_n = NULL                         => 0.0006535107,
                                                   0.0006535107);

final_score_298_c1668 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 349.5 => -0.0269619395,
    r_c13_max_lres_d > 349.5                              => -0.1275027372,
    r_c13_max_lres_d = NULL                               => -0.0309750480,
                                                             -0.0309750480);

final_score_298_c1665 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => final_score_298_c1666,
    r_phn_pcs_n > 0.5                         => final_score_298_c1668,
    r_phn_pcs_n = NULL                        => -0.0042019987,
                                                 -0.0042019987);

final_score_298 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 7.5 => final_score_298_c1665,
    f_varrisktype_i > 7.5                             => -0.0552337015,
    f_varrisktype_i = NULL                            => -0.0004350377,
                                                         -0.0047361116);

final_score_299_c1670 := map(
    NULL < f_mos_liens_rel_ot_fseen_d AND f_mos_liens_rel_ot_fseen_d <= 185.5 => 0.0033705409,
    f_mos_liens_rel_ot_fseen_d > 185.5                                        => 0.0915962926,
    f_mos_liens_rel_ot_fseen_d = NULL                                         => 0.0041569399,
                                                                                 0.0041569399);

final_score_299_c1672 := map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d <= 12.5 => -0.0908781152,
    f_rel_incomeover25_count_d > 12.5                                        => 0.0287559851,
    f_rel_incomeover25_count_d = NULL                                        => -0.0614645302,
                                                                                -0.0614645302);

final_score_299_c1673 := map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 2.5 => 0.0062779909,
    f_rel_incomeover100_count_d > 2.5                                         => -0.0729638364,
    f_rel_incomeover100_count_d = NULL                                        => -0.0082038801,
                                                                                 -0.0082038801);

final_score_299_c1671 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '6: Other'])          => final_score_299_c1672,
    (nf_seg_fraudpoint_3_0 in ['3: Derog', '4: Recent Activity', '5: Vuln Vic/Friendly']) => final_score_299_c1673,
    nf_seg_fraudpoint_3_0 = ''                                                          	=> -0.0234212087,
                                                                                             -0.0234212087);

final_score_299 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 393.5 => final_score_299_c1670,
    f_m_bureau_adl_fs_all_d > 393.5                                     => final_score_299_c1671,
    f_m_bureau_adl_fs_all_d = NULL                                      => 0.0037015901,
                                                                           0.0019609858);

final_score_300_c1678 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 2.5 => 0.0226898817,
    f_addrchangeecontrajindex_d > 2.5                                         => 0.0432098334,
    f_addrchangeecontrajindex_d = NULL                                        => 0.0361824527,
                                                                                 0.0361824527);

final_score_300_c1677 := map(
    NULL < f_recent_disconnects_i AND f_recent_disconnects_i <= 0.5 => 0.0060088910,
    f_recent_disconnects_i > 0.5                                    => final_score_300_c1678,
    f_recent_disconnects_i = NULL                                   => 0.0071250793,
                                                                       0.0071250793);

final_score_300_c1676 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 145500 => final_score_300_c1677,
    r_a49_curr_avm_chg_1yr_i > 145500                                      => -0.0423075177,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => -0.0028842223,
                                                                              0.0014198568);

final_score_300_c1675 := map(
    NULL < f_hh_members_ct_d AND f_hh_members_ct_d <= 15.5 => final_score_300_c1676,
    f_hh_members_ct_d > 15.5                               => 0.0919963380,
    f_hh_members_ct_d = NULL                               => 0.0019954382,
                                                              0.0019954382);

final_score_300 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 10.5 => final_score_300_c1675,
    f_rel_homeover500_count_d > 10.5                                       => -0.0433809975,
    f_rel_homeover500_count_d = NULL                                       => 0.0146040086,
                                                                              0.0017991136);

final_score_301_c1681 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 37.5 => -0.0134263604,
    f_prevaddrlenofres_d > 37.5                                  => 0.0105262861,
    f_prevaddrlenofres_d = NULL                                  => 0.0024212183,
                                                                    0.0024212183);

final_score_301_c1682 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 38 => -0.0101849921,
    f_prevaddrageoldest_d > 38                                   => -0.1032581180,
    f_prevaddrageoldest_d = NULL                                 => -0.0357924130,
                                                                    -0.0357924130);

final_score_301_c1680 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 5.5 => final_score_301_c1681,
    r_l79_adls_per_addr_c6_i > 5.5                                      => final_score_301_c1682,
    r_l79_adls_per_addr_c6_i = NULL                                     => 0.0016367743,
                                                                           0.0016367743);

final_score_301_c1683 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 7.5 => 0.1035437515,
    f_assocsuspicousidcount_i > 7.5                                       => 0.0017007259,
    f_assocsuspicousidcount_i = NULL                                      => 0.0550470726,
                                                                             0.0550470726);

final_score_301 := map(
    NULL < f_assoccredbureaucount_i AND f_assoccredbureaucount_i <= 2.5 => final_score_301_c1680,
    f_assoccredbureaucount_i > 2.5                                      => final_score_301_c1683,
    f_assoccredbureaucount_i = NULL                                     => -0.0135325927,
                                                                           0.0022050822);

final_score_302_c1688 := map(
    NULL < (real)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d <= 0.5 => 0.1005684495,
    (real)k_nap_phn_verd_d > 0.5                              => 0.0003319115,
    (real)k_nap_phn_verd_d = NULL                             => 0.0450156694,
                                                           0.0450156694);

final_score_302_c1687 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 7122.5 => -0.0718026479,
    r_a49_curr_avm_chg_1yr_i > 7122.5                                      => 0.0643502523,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => final_score_302_c1688,
                                                                              0.0273899619);

final_score_302_c1686 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 95 => final_score_302_c1687,
    r_f01_inp_addr_address_score_d > 95                                            => 0.0053328132,
    r_f01_inp_addr_address_score_d = NULL                                          => 0.0061827802,
                                                                                      0.0061827802);

final_score_302_c1685 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 6.5 => final_score_302_c1686,
    f_varrisktype_i > 6.5                             => 0.0975042759,
    f_varrisktype_i = NULL                            => 0.0071594807,
                                                         0.0071594807);

final_score_302 := map(
    NULL < f_property_owners_ct_d AND f_property_owners_ct_d <= 0.5 => -0.0194392667,
    f_property_owners_ct_d > 0.5                                    => final_score_302_c1685,
    f_property_owners_ct_d = NULL                                   => -0.0353818437,
                                                                       -0.0008789398);

final_score_303_c1693 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= -0.5 => 0.0811452184,
    f_prevaddrageoldest_d > -0.5                                   => -0.0001586553,
    f_prevaddrageoldest_d = NULL                                   => 0.0003116024,
                                                                      0.0003116024);

final_score_303_c1692 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 29.5 => final_score_303_c1693,
    f_rel_incomeover50_count_d > 29.5                                        => -0.0790816179,
    f_rel_incomeover50_count_d = NULL                                        => -0.0292841730,
                                                                                -0.0009062058);

final_score_303_c1691 := map(
    NULL < r_l70_add_invalid_i AND r_l70_add_invalid_i <= 0.5 => final_score_303_c1692,
    r_l70_add_invalid_i > 0.5                                 => -0.0557926638,
    r_l70_add_invalid_i = NULL                                => -0.0018799930,
                                                                 -0.0018799930);

final_score_303_c1690 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 14.5 => final_score_303_c1691,
    k_inq_per_phone_i > 14.5                               => -0.0711497811,
    k_inq_per_phone_i = NULL                               => -0.0022722341,
                                                              -0.0022722341);

final_score_303 := map(
    NULL < f_mos_liens_unrel_ot_lseen_d AND f_mos_liens_unrel_ot_lseen_d <= 10.5 => 0.1880521329,
    f_mos_liens_unrel_ot_lseen_d > 10.5                                          => final_score_303_c1690,
    f_mos_liens_unrel_ot_lseen_d = NULL                                          => 0.0016136817,
                                                                                    -0.0009031156);

final_score_304_c1696 := map(
    NULL < f_divrisktype_i AND f_divrisktype_i <= 3.5 => -0.0059632675,
    f_divrisktype_i > 3.5                             => -0.0860405404,
    f_divrisktype_i = NULL                            => -0.0105446283,
                                                         -0.0105446283);

final_score_304_c1695 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 388.5 => final_score_304_c1696,
    f_m_bureau_adl_fs_notu_d > 388.5                                      => -0.0846234738,
    f_m_bureau_adl_fs_notu_d = NULL                                       => -0.0129332547,
                                                                             -0.0129332547);

final_score_304_c1698 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 1.5 => 0.0093104948,
    f_inq_other_count24_i > 1.5                                   => 0.0814891592,
    f_inq_other_count24_i = NULL                                  => 0.0213744234,
                                                                     0.0213744234);

final_score_304_c1697 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_304_c1698,
    f_phone_ver_insurance_d > 3.5                                     => -0.0010727089,
    f_phone_ver_insurance_d = NULL                                    => 0.0034620978,
                                                                         0.0034620978);

final_score_304 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 2.5 => final_score_304_c1695,
    f_phone_ver_insurance_d > 2.5                                     => final_score_304_c1697,
    f_phone_ver_insurance_d = NULL                                    => 0.0087162772,
                                                                         -0.0005849344);

final_score_305_c1702 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.0946116259,
    f_phone_ver_experian_d > 0.5                                    => 0.0101211006,
    f_phone_ver_experian_d = NULL                                   => 0.0530213286,
                                                                       0.0530213286);

final_score_305_c1701 := map(
    NULL < f_current_count_d AND f_current_count_d <= 4.5 => 0.0018347560,
    f_current_count_d > 4.5                               => final_score_305_c1702,
    f_current_count_d = NULL                              => 0.0050907775,
                                                             0.0050907775);

final_score_305_c1700 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 832.5 => -0.0029569039,
    r_p88_phn_dst_to_inp_add_i > 832.5                                        => 0.0606777064,
    r_p88_phn_dst_to_inp_add_i = NULL                                         => final_score_305_c1701,
                                                                                 -0.0005038535);

final_score_305_c1703 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 0.5 => -0.0190091453,
    f_rel_homeover500_count_d > 0.5                                       => -0.0929380472,
    f_rel_homeover500_count_d = NULL                                      => -0.0337683325,
                                                                             -0.0337683325);

final_score_305 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 3.5 => final_score_305_c1700,
    r_c23_inp_addr_occ_index_d > 3.5                                        => final_score_305_c1703,
    r_c23_inp_addr_occ_index_d = NULL                                       => -0.0325252187,
                                                                               -0.0018611595);

final_score_306_c1708 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 2.5 => 0.0879575143,
    f_addrchangeecontrajindex_d > 2.5                                         => 0.0021532547,
    f_addrchangeecontrajindex_d = NULL                                        => 0.0515765083,
                                                                                 0.0515765083);

final_score_306_c1707 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 1.5 => -0.0767583309,
    f_phones_per_addr_curr_i > 1.5                                      => final_score_306_c1708,
    f_phones_per_addr_curr_i = NULL                                     => -0.0040437600,
                                                                           -0.0040437600);

final_score_306_c1706 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 5.5 => final_score_306_c1707,
    f_rel_homeover300_count_d > 5.5                                       => 0.0551027867,
    f_rel_homeover300_count_d = NULL                                      => 0.0095427362,
                                                                             0.0095427362);

final_score_306_c1705 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 2.5 => 0.1227174539,
    f_prevaddrageoldest_d > 2.5                                   => final_score_306_c1706,
    f_prevaddrageoldest_d = NULL                                  => 0.0249756522,
                                                                     0.0249756522);

final_score_306 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 85 => final_score_306_c1705,
    r_f01_inp_addr_address_score_d > 85                                            => 0.0005557531,
    r_f01_inp_addr_address_score_d = NULL                                          => -0.0380235118,
                                                                                      0.0011050032);

final_score_307_c1713 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 100055.5 => 0.0173333912,
    r_a49_curr_avm_chg_1yr_i > 100055.5                                      => -0.0386077668,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => 0.0070893305,
                                                                                0.0110623948);

final_score_307_c1712 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_307_c1713,
    r_phn_cell_n > 0.5                          => -0.0065923078,
    r_phn_cell_n = NULL                         => 0.0008961325,
                                                   0.0008961325);

final_score_307_c1711 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 0 => 0.0771065647,
    f_prevaddrageoldest_d > 0                                   => final_score_307_c1712,
    f_prevaddrageoldest_d = NULL                                => 0.0013990740,
                                                                   0.0013990740);

final_score_307_c1710 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 18.5 => final_score_307_c1711,
    f_rel_incomeover75_count_d > 18.5                                        => -0.0974887471,
    f_rel_incomeover75_count_d = NULL                                        => 0.0021767358,
                                                                                0.0007952149);

final_score_307 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 2.5 => final_score_307_c1710,
    k_inq_adls_per_phone_i > 2.5                                    => -0.0577170964,
    k_inq_adls_per_phone_i = NULL                                   => 0.0002086020,
                                                                       0.0002086020);

final_score_308_c1715 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 22.5 => 0.0046378587,
    f_bus_addr_match_count_d > 22.5                                      => -0.0472168438,
    f_bus_addr_match_count_d = NULL                                      => 0.0039933370,
                                                                            0.0039933370);

final_score_308_c1718 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => -0.0649207789,
    f_phone_ver_experian_d > 0.5                                    => -0.0195896447,
    f_phone_ver_experian_d = NULL                                   => -0.0355242252,
                                                                       -0.0355242252);

final_score_308_c1717 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 1.5 => final_score_308_c1718,
    f_varrisktype_i > 1.5                             => 0.0605417438,
    f_varrisktype_i = NULL                            => -0.0152921499,
                                                         -0.0152921499);

final_score_308_c1716 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 5.5 => -0.0545511503,
    f_rel_under500miles_cnt_d > 5.5                                       => final_score_308_c1717,
    f_rel_under500miles_cnt_d = NULL                                      => -0.0273908356,
                                                                             -0.0273908356);

final_score_308 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 353.5 => final_score_308_c1715,
    r_c13_max_lres_d > 353.5                              => final_score_308_c1716,
    r_c13_max_lres_d = NULL                               => 0.0045405999,
                                                             0.0024022547);

final_score_309_c1721 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 428.5 => -0.0020889821,
    r_c13_max_lres_d > 428.5                              => 0.0705676749,
    r_c13_max_lres_d = NULL                               => -0.0012490208,
                                                             -0.0012490208);

final_score_309_c1722 := map(
    NULL < f_hh_tot_derog_i AND f_hh_tot_derog_i <= 1.5 => 0.0538591947,
    f_hh_tot_derog_i > 1.5                              => 0.0086116890,
    f_hh_tot_derog_i = NULL                             => 0.0263733982,
                                                           0.0263733982);

final_score_309_c1720 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 373.5 => final_score_309_c1721,
    r_c21_m_bureau_adl_fs_d > 373.5                                     => final_score_309_c1722,
    r_c21_m_bureau_adl_fs_d = NULL                                      => 0.0006632422,
                                                                           0.0006632422);

final_score_309_c1723 := map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i <= 0.5 => -0.0795727949,
    f_crim_rel_under25miles_cnt_i > 0.5                                           => 0.0080094984,
    f_crim_rel_under25miles_cnt_i = NULL                                          => -0.0383459947,
                                                                                     -0.0383459947);

final_score_309 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 463.5 => final_score_309_c1720,
    f_m_bureau_adl_fs_all_d > 463.5                                     => final_score_309_c1723,
    f_m_bureau_adl_fs_all_d = NULL                                      => -0.0016498265,
                                                                           -0.0002869651);

final_score_310_c1727 := map(
    NULL < f_property_owners_ct_d AND f_property_owners_ct_d <= 1.5 => -0.1472140908,
    f_property_owners_ct_d > 1.5                                    => -0.0425107877,
    f_property_owners_ct_d = NULL                                   => -0.0943950138,
                                                                       -0.0943950138);

final_score_310_c1726 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 46.5 => -0.0013247000,
    f_prevaddrageoldest_d > 46.5                                   => final_score_310_c1727,
    f_prevaddrageoldest_d = NULL                                   => -0.0455874395,
                                                                      -0.0455874395);

final_score_310_c1728 := map(
    NULL < (real)k_nap_fname_verd_d AND (real)k_nap_fname_verd_d <= 0.5 			=> 0.0834884110,
    (real)k_nap_fname_verd_d > 0.5                                						=> -0.0193559262,
    (real)k_nap_fname_verd_d = NULL                               						=> 0.0036282249,
																																								0.0036282249);

final_score_310_c1725 := map(
    NULL < (real)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d <= 0.5 => final_score_310_c1726,
    (real)k_nap_phn_verd_d > 0.5                              => final_score_310_c1728,
    (real)k_nap_phn_verd_d = NULL                             => -0.0195755568,
                                                           -0.0195755568);

final_score_310 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 4.5 => -0.0006282239,
    f_idverrisktype_i > 4.5                               => final_score_310_c1725,
    f_idverrisktype_i = NULL                              => 0.0604130729,
                                                             -0.0010494498);

final_score_311_c1731 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 60.5 => 0.0344096248,
    r_c13_max_lres_d > 60.5                              => -0.0040392997,
    r_c13_max_lres_d = NULL                              => 0.0009754010,
                                                            0.0009754010);

final_score_311_c1730 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 5.5 => final_score_311_c1731,
    r_c14_addrs_5yr_i > 5.5                               => -0.0958147901,
    r_c14_addrs_5yr_i = NULL                              => -0.0005528652,
                                                             -0.0005528652);

final_score_311_c1732 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 14.5 => -0.0934365355,
    f_rel_under25miles_cnt_d > 14.5                                      => 0.0024299718,
    f_rel_under25miles_cnt_d = NULL                                      => -0.0503131931,
                                                                            -0.0503131931);

final_score_311_c1733 := map(
    NULL < k_inq_adls_per_ssn_i AND k_inq_adls_per_ssn_i <= 0.5 => 0.0122406218,
    k_inq_adls_per_ssn_i > 0.5                                  => 0.0832014340,
    k_inq_adls_per_ssn_i = NULL                                 => 0.0265438775,
                                                                   0.0265438775);

final_score_311 := map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 8.5 => final_score_311_c1730,
    f_rel_incomeover100_count_d > 8.5                                         => final_score_311_c1732,
    f_rel_incomeover100_count_d = NULL                                        => final_score_311_c1733,
                                                                                 -0.0005783323);

final_score_312_c1738 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 355.5 => 0.0619783535,
    f_m_bureau_adl_fs_notu_d > 355.5                                      => -0.0492381863,
    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0438307444,
                                                                             0.0438307444);

final_score_312_c1737 := map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 2.5 => final_score_312_c1738,
    f_rel_homeover50_count_d > 2.5                                      => -0.0045507586,
    f_rel_homeover50_count_d = NULL                                     => 0.0218144458,
                                                                           -0.0025174761);

final_score_312_c1736 := map(
    NULL < r_s65_ssn_problem_i AND r_s65_ssn_problem_i <= 0.5 => final_score_312_c1737,
    r_s65_ssn_problem_i > 0.5                                 => -0.0587485327,
    r_s65_ssn_problem_i = NULL                                => -0.0042816717,
                                                                 -0.0042816717);

final_score_312_c1735 := map(
    NULL < f_vardobcount_i AND f_vardobcount_i <= 0.5 => 0.0791476374,
    f_vardobcount_i > 0.5                             => final_score_312_c1736,
    f_vardobcount_i = NULL                            => 0.0101055971,
                                                         -0.0036612410);

final_score_312 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 9.5 => final_score_312_c1735,
    r_l79_adls_per_addr_c6_i > 9.5                                      => 0.0571620935,
    r_l79_adls_per_addr_c6_i = NULL                                     => -0.0032577963,
                                                                           -0.0032577963);

final_score_313_c1743 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 304.5 => -0.0072169445,
    r_c21_m_bureau_adl_fs_d > 304.5                                     => 0.0587439377,
    r_c21_m_bureau_adl_fs_d = NULL                                      => 0.0236695003,
                                                                           0.0236695003);

final_score_313_c1742 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 5.5 => -0.0019500901,
    r_wealth_index_d > 5.5                              => final_score_313_c1743,
    r_wealth_index_d = NULL                             => -0.0012348079,
                                                           -0.0012348079);

final_score_313_c1741 := map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i <= 13.5 => final_score_313_c1742,
    k_inq_per_addr_i > 13.5                              => -0.0441408276,
    k_inq_per_addr_i = NULL                              => -0.0019522843,
                                                            -0.0019522843);

final_score_313_c1740 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 442.5 => final_score_313_c1741,
    r_c13_curr_addr_lres_d > 442.5                                    => 0.0525021053,
    r_c13_curr_addr_lres_d = NULL                                     => -0.0015199198,
                                                                         -0.0015199198);

final_score_313 := map(
    NULL < f_inq_quizprovider_count24_i AND f_inq_quizprovider_count24_i <= 3.5 => final_score_313_c1740,
    f_inq_quizprovider_count24_i > 3.5                                          => 0.0972076699,
    f_inq_quizprovider_count24_i = NULL                                         => -0.0236608725,
                                                                                   -0.0010618169);

final_score_314_c1747 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => -0.0917276675,
    f_phone_ver_experian_d > 0.5                                    => -0.0407773041,
    f_phone_ver_experian_d = NULL                                   => -0.0563743541,
                                                                       -0.0563743541);

final_score_314_c1746 := map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 5.5 => final_score_314_c1747,
    f_rel_homeover150_count_d > 5.5                                       => 0.0104222656,
    f_rel_homeover150_count_d = NULL                                      => -0.0252172950,
                                                                             -0.0252172950);

final_score_314_c1745 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 172 => final_score_314_c1746,
    r_c13_curr_addr_lres_d > 172                                    => -0.1028420225,
    r_c13_curr_addr_lres_d = NULL                                   => -0.0357297020,
                                                                       -0.0357297020);

final_score_314_c1748 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 72.15 => 0.0083927118,
    r_c12_source_profile_d > 72.15                                    => -0.0125034421,
    r_c12_source_profile_d = NULL                                     => 0.0045780223,
                                                                         0.0045780223);

final_score_314 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 0.5 => final_score_314_c1745,
    f_phones_per_addr_curr_i > 0.5                                      => final_score_314_c1748,
    f_phones_per_addr_curr_i = NULL                                     => 0.0116974117,
                                                                           0.0022725757);

final_score_315_c1752 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 47.5 => -0.0121316900,
    f_prevaddrageoldest_d > 47.5                                   => -0.0830570996,
    f_prevaddrageoldest_d = NULL                                   => -0.0506485990,
                                                                      -0.0506485990);

final_score_315_c1751 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 11.5 => final_score_315_c1752,
    f_rel_under25miles_cnt_d > 11.5                                      => 0.0723667118,
    f_rel_under25miles_cnt_d = NULL                                      => -0.0244701995,
                                                                            -0.0244701995);

final_score_315_c1753 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 442.5 => -0.0031425636,
    r_c13_curr_addr_lres_d > 442.5                                    => 0.0494512326,
    r_c13_curr_addr_lres_d = NULL                                     => -0.0026740685,
                                                                         -0.0026740685);

final_score_315_c1750 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 65 => final_score_315_c1751,
    r_f01_inp_addr_address_score_d > 65                                            => final_score_315_c1753,
    r_f01_inp_addr_address_score_d = NULL                                          => -0.0033115297,
                                                                                      -0.0033115297);

final_score_315 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 31.5 => final_score_315_c1750,
    f_rel_under25miles_cnt_d > 31.5                                      => 0.0954640556,
    f_rel_under25miles_cnt_d = NULL                                      => 0.0050182454,
                                                                            -0.0021278566);

final_score_316_c1757 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.1504651956,
    f_phone_ver_experian_d > 0.5                                    => 0.0589968236,
    f_phone_ver_experian_d = NULL                                   => 0.0756964885,
                                                                       0.0847146470);

final_score_316_c1756 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 100.5 => final_score_316_c1757,
    r_c10_m_hdr_fs_d > 100.5                              => -0.0019397986,
    r_c10_m_hdr_fs_d = NULL                               => 0.0080446730,
                                                             0.0080446730);

final_score_316_c1755 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 255004.5 => final_score_316_c1756,
    r_a46_curr_avm_autoval_d > 255004.5                                      => -0.0246457641,
    r_a46_curr_avm_autoval_d = NULL                                          => -0.0010836674,
                                                                                -0.0000750409);

final_score_316_c1758 := map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 1.5 => -0.0089035777,
    r_s66_adlperssn_count_i > 1.5                                     => 0.0644996159,
    r_s66_adlperssn_count_i = NULL                                    => 0.0263627611,
                                                                         0.0263627611);

final_score_316 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 5.5 => final_score_316_c1755,
    f_addrchangeecontrajindex_d > 5.5                                         => final_score_316_c1758,
    f_addrchangeecontrajindex_d = NULL                                        => -0.0096752259,
                                                                                 -0.0010937011);

final_score_317_c1763 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '3: Derog'])          => -0.0128070690,
    (nf_seg_fraudpoint_3_0 in ['4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) => 0.0354217164,
    nf_seg_fraudpoint_3_0 = ''	                                                          => 0.0145660254,
                                                                                             0.0145660254);

final_score_317_c1762 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 5.5 => final_score_317_c1763,
    f_util_adl_count_n > 5.5                                => 0.1706337997,
    f_util_adl_count_n = NULL                               => 0.0270472520,
                                                               0.0270472520);

final_score_317_c1761 := map(
    NULL < (real)k_nap_lname_verd_d AND (real)k_nap_lname_verd_d <= 0.5 		=> final_score_317_c1762,
    (real)k_nap_lname_verd_d > 0.5                                					=> 0.0014669075,
    (real)k_nap_lname_verd_d = NULL                               					=> 0.0041318625,
																																								0.0041318625);

final_score_317_c1760 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 421 => final_score_317_c1761,
    f_prevaddrageoldest_d > 421                                   => 0.0487999058,
    f_prevaddrageoldest_d = NULL                                  => 0.0046725257,
                                                                     0.0046725257);

final_score_317 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 549 => -0.0255191208,
    r_i60_inq_hiriskcred_recency_d > 549                                            => final_score_317_c1760,
    r_i60_inq_hiriskcred_recency_d = NULL                                           => -0.0248804468,
                                                                                       -0.0023573224);

final_score_318_c1767 := map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 1.5 => 0.0056450965,
    f_rel_homeover50_count_d > 1.5                                      => 0.1122848081,
    f_rel_homeover50_count_d = NULL                                     => 0.0646372774,
                                                                           0.0646372774);

final_score_318_c1766 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_318_c1767,
    f_phone_ver_experian_d > 0.5                                    => 0.0124486789,
    f_phone_ver_experian_d = NULL                                   => 0.0063115211,
                                                                       0.0268219454);

final_score_318_c1765 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 1.5 => final_score_318_c1766,
    f_rel_educationover12_count_d > 1.5                                           => -0.0034296316,
    f_rel_educationover12_count_d = NULL                                          => 0.0070933410,
                                                                                     -0.0019676563);

final_score_318_c1768 := map(
    NULL < f_property_owners_ct_d AND f_property_owners_ct_d <= 2.5 => -0.0026772861,
    f_property_owners_ct_d > 2.5                                    => 0.1274673187,
    f_property_owners_ct_d = NULL                                   => 0.0569251706,
                                                                       0.0569251706);

final_score_318 := map(
    NULL < f_hh_prof_license_holders_d AND f_hh_prof_license_holders_d <= 1.5 => final_score_318_c1765,
    f_hh_prof_license_holders_d > 1.5                                         => final_score_318_c1768,
    f_hh_prof_license_holders_d = NULL                                        => 0.0589044488,
                                                                                 -0.0002860782);

final_score_319_c1771 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i <= 0.5 => -0.0111781442,
    r_p85_phn_disconnected_i > 0.5                                      => -0.0682747237,
    r_p85_phn_disconnected_i = NULL                                     => -0.0129743457,
                                                                           -0.0129743457);

final_score_319_c1773 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 6.5 => -0.0008088089,
    f_assocsuspicousidcount_i > 6.5                                       => 0.1136996637,
    f_assocsuspicousidcount_i = NULL                                      => 0.0071720846,
                                                                             0.0071720846);

final_score_319_c1772 := map(
    NULL < f_curraddractivephonelist_d AND f_curraddractivephonelist_d <= 0.5 => 0.0136760034,
    f_curraddractivephonelist_d > 0.5                                         => final_score_319_c1773,
    f_curraddractivephonelist_d = NULL                                        => 0.0092987909,
                                                                                 0.0092987909);

final_score_319_c1770 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 9.5 => final_score_319_c1771,
    f_rel_under500miles_cnt_d > 9.5                                       => final_score_319_c1772,
    f_rel_under500miles_cnt_d = NULL                                      => -0.0013409739,
                                                                             -0.0013409739);

final_score_319 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 170787.5 => final_score_319_c1770,
    r_a49_curr_avm_chg_1yr_i > 170787.5                                      => 0.0593495241,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => 0.0049402384,
                                                                                0.0024782527);

final_score_320_c1777 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 117.35 => -0.0014531927,
    r_a49_curr_avm_chg_1yr_pct_i > 117.35                                          => -0.0820144701,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => -0.0105914855,
                                                                                      -0.0148011715);

final_score_320_c1776 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 75.55 => 0.0069934704,
    r_c12_source_profile_d > 75.55                                    => final_score_320_c1777,
    r_c12_source_profile_d = NULL                                     => 0.0046865706,
                                                                         0.0046865706);

final_score_320_c1775 := map(
    NULL < nf_inq_per_add_nas_479 AND nf_inq_per_add_nas_479 <= 2.5 => final_score_320_c1776,
    nf_inq_per_add_nas_479 > 2.5                                    => 0.0604496683,
    nf_inq_per_add_nas_479 = NULL                                   => 0.0050644901,
                                                                       0.0050644901);

final_score_320_c1778 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => -0.0696639090,
    f_phone_ver_experian_d > 0.5                                    => -0.0310063932,
    f_phone_ver_experian_d = NULL                                   => -0.0434870167,
                                                                       -0.0434870167);

final_score_320 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 358.5 => final_score_320_c1775,
    r_c13_curr_addr_lres_d > 358.5                                    => final_score_320_c1778,
    r_c13_curr_addr_lres_d = NULL                                     => 0.0097818437,
                                                                         0.0038039792);

final_score_321_c1782 := map(
    NULL < nf_number_non_bureau_sources AND nf_number_non_bureau_sources <= 3.5 => 0.0749313772,
    nf_number_non_bureau_sources > 3.5                                          => 0.0024594546,
    nf_number_non_bureau_sources = NULL                                         => 0.0156361678,
                                                                                   0.0156361678);

final_score_321_c1783 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 374.5 => 0.1655312104,
    r_c21_m_bureau_adl_fs_d > 374.5                                     => 0.0204176267,
    r_c21_m_bureau_adl_fs_d = NULL                                      => 0.0941542038,
                                                                           0.0941542038);

final_score_321_c1781 := map(
    NULL < f_assoccredbureaucount_i AND f_assoccredbureaucount_i <= 0.5 => final_score_321_c1782,
    f_assoccredbureaucount_i > 0.5                                      => final_score_321_c1783,
    f_assoccredbureaucount_i = NULL                                     => 0.0355080164,
                                                                           0.0355080164);

final_score_321_c1780 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 385.5 => 0.0084203570,
    r_c10_m_hdr_fs_d > 385.5                              => final_score_321_c1781,
    r_c10_m_hdr_fs_d = NULL                               => 0.0112381229,
                                                             0.0112381229);

final_score_321 := map(
    NULL < f_crim_rel_under500miles_cnt_i AND f_crim_rel_under500miles_cnt_i <= 1.5 => -0.0067016379,
    f_crim_rel_under500miles_cnt_i > 1.5                                            => final_score_321_c1780,
    f_crim_rel_under500miles_cnt_i = NULL                                           => 0.0002195853,
                                                                                       0.0023759806);

final_score_322_c1787 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => -0.0761141445,
    f_phone_ver_experian_d > 0.5                                    => 0.0092859211,
    f_phone_ver_experian_d = NULL                                   => -0.0246335416,
                                                                       -0.0246335416);

final_score_322_c1786 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 5.5 => 0.0042848223,
    r_wealth_index_d > 5.5                              => final_score_322_c1787,
    r_wealth_index_d = NULL                             => 0.0036419974,
                                                           0.0036419974);

final_score_322_c1788 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 2.5 => -0.0680505917,
    f_addrchangeecontrajindex_d > 2.5                                         => 0.0824969023,
    f_addrchangeecontrajindex_d = NULL                                        => -0.0037718864,
                                                                                 -0.0037718864);

final_score_322_c1785 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 8.5 => final_score_322_c1786,
    f_rel_incomeover75_count_d > 8.5                                        => -0.0271046193,
    f_rel_incomeover75_count_d = NULL                                       => final_score_322_c1788,
                                                                               0.0006469187);

final_score_322 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 461.5 => final_score_322_c1785,
    f_m_bureau_adl_fs_notu_d > 461.5                                      => -0.0890456304,
    f_m_bureau_adl_fs_notu_d = NULL                                       => -0.0155860495,
                                                                             0.0000015150);

final_score_323_c1793 := map(
    NULL < f_dl_addrs_per_adl_i AND f_dl_addrs_per_adl_i <= 0.5 => 0.1758736959,
    f_dl_addrs_per_adl_i > 0.5                                  => 0.0515266140,
    f_dl_addrs_per_adl_i = NULL                                 => 0.1128561702,
                                                                   0.1128561702);

final_score_323_c1792 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 1.5 => 0.0214632542,
    r_l79_adls_per_addr_c6_i > 1.5                                      => final_score_323_c1793,
    r_l79_adls_per_addr_c6_i = NULL                                     => 0.0396759093,
                                                                           0.0396759093);

final_score_323_c1791 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 464.5 => final_score_323_c1792,
    r_c10_m_hdr_fs_d > 464.5                              => -0.0477841226,
    r_c10_m_hdr_fs_d = NULL                               => 0.0258629354,
                                                             0.0258629354);

final_score_323_c1790 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 282.5 => -0.0003337029,
    f_prevaddrageoldest_d > 282.5                                   => final_score_323_c1791,
    f_prevaddrageoldest_d = NULL                                    => -0.0548641721,
                                                                       0.0009406737);

final_score_323 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 11.5 => final_score_323_c1790,
    k_inq_per_phone_i > 11.5                               => -0.0608919637,
    k_inq_per_phone_i = NULL                               => 0.0003962106,
                                                              0.0003962106);

final_score_324_c1797 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i <= 0.5 => 0.0008327899,
    r_p85_phn_disconnected_i > 0.5                                      => 0.0494902843,
    r_p85_phn_disconnected_i = NULL                                     => 0.0019223595,
                                                                           0.0019223595);

final_score_324_c1796 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 157.85 => -0.0021278808,
    r_a49_curr_avm_chg_1yr_pct_i > 157.85                                          => -0.0453878626,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => final_score_324_c1797,
                                                                                      -0.0007763741);

final_score_324_c1795 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 406.5 => final_score_324_c1796,
    r_c13_max_lres_d > 406.5                              => 0.0619509898,
    r_c13_max_lres_d = NULL                               => -0.0000765586,
                                                             -0.0000765586);

final_score_324_c1798 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => -0.0745552158,
    f_phone_ver_experian_d > 0.5                                    => -0.0375871132,
    f_phone_ver_experian_d = NULL                                   => -0.0521868349,
                                                                       -0.0521868349);

final_score_324 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 390.5 => final_score_324_c1795,
    f_prevaddrlenofres_d > 390.5                                  => final_score_324_c1798,
    f_prevaddrlenofres_d = NULL                                   => -0.0104783207,
                                                                     -0.0009946236);

final_score_325_c1801 := map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 230.5 => -0.1220815555,
    r_d32_mos_since_fel_ls_d > 230.5                                      => 0.0072986213,
    r_d32_mos_since_fel_ls_d = NULL                                       => 0.0054638981,
                                                                             0.0054638981);

final_score_325_c1803 := map(
    NULL < f_vardobcount_i AND f_vardobcount_i <= 1.5 => -0.0326555675,
    f_vardobcount_i > 1.5                             => 0.0385280526,
    f_vardobcount_i = NULL                            => -0.0075745771,
                                                         -0.0075745771);

final_score_325_c1802 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 82916.5 => -0.0920055931,
    r_a49_curr_avm_chg_1yr_i > 82916.5                                      => final_score_325_c1803,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => -0.0218607051,
                                                                               -0.0218607051);

final_score_325_c1800 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 73480.5 => final_score_325_c1801,
    r_a49_curr_avm_chg_1yr_i > 73480.5                                      => final_score_325_c1802,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => -0.0055940567,
                                                                               -0.0013242749);

final_score_325 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 28.5 => final_score_325_c1800,
    f_phones_per_addr_curr_i > 28.5                                      => -0.0739827446,
    f_phones_per_addr_curr_i = NULL                                      => 0.0022032149,
                                                                            -0.0016914260);

final_score_326_c1806 := map(
    NULL < f_phones_per_addr_c6_i AND f_phones_per_addr_c6_i <= 8.5 => 0.0024476090,
    f_phones_per_addr_c6_i > 8.5                                    => 0.1032032308,
    f_phones_per_addr_c6_i = NULL                                   => 0.0030759571,
                                                                       0.0030759571);

final_score_326_c1805 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 15.5 => final_score_326_c1806,
    f_rel_incomeover50_count_d > 15.5                                        => -0.0287940518,
    f_rel_incomeover50_count_d = NULL                                        => 0.0500623712,
                                                                                0.0005802523);

final_score_326_c1808 := map(
    NULL < r_i60_inq_banking_recency_d AND r_i60_inq_banking_recency_d <= 549 => 0.0755761499,
    r_i60_inq_banking_recency_d > 549                                         => -0.0314588979,
    r_i60_inq_banking_recency_d = NULL                                        => 0.0189829063,
                                                                                 0.0189829063);

final_score_326_c1807 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 4.5 => -0.1104244747,
    f_rel_under500miles_cnt_d > 4.5                                       => final_score_326_c1808,
    f_rel_under500miles_cnt_d = NULL                                      => -0.0255618455,
                                                                             -0.0255618455);

final_score_326 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => final_score_326_c1805,
    f_validationrisktype_i > 1.5                                    => final_score_326_c1807,
    f_validationrisktype_i = NULL                                   => -0.0056397448,
                                                                       -0.0000724441);

final_score_327_c1812 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 203788 => -0.0210300979,
    r_l80_inp_avm_autoval_d > 203788                                     => 0.0085059949,
    r_l80_inp_avm_autoval_d = NULL                                       => 0.0420069981,
                                                                            -0.0094531187);

final_score_327_c1811 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 5.5 => final_score_327_c1812,
    f_addrchangeecontrajindex_d > 5.5                                         => -0.0200574219,
    f_addrchangeecontrajindex_d = NULL                                        => -0.0263168377,
                                                                                 -0.0113660098);

final_score_327_c1810 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= -59961.5 => 0.0629402372,
    r_a49_curr_avm_chg_1yr_i > -59961.5                                      => final_score_327_c1811,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => -0.0034085481,
                                                                                -0.0063531726);

final_score_327_c1813 := map(
    NULL < f_hh_tot_derog_i AND f_hh_tot_derog_i <= 1.5 => -0.0151228707,
    f_hh_tot_derog_i > 1.5                              => 0.0924894190,
    f_hh_tot_derog_i = NULL                             => 0.0447813039,
                                                           0.0447813039);

final_score_327 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 501.5 => final_score_327_c1810,
    r_c10_m_hdr_fs_d > 501.5                              => final_score_327_c1813,
    r_c10_m_hdr_fs_d = NULL                               => 0.0089430365,
                                                             -0.0053877188);

final_score_328_c1817 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 7.5 => 0.0064882939,
    f_rel_under100miles_cnt_d > 7.5                                       => -0.0142589011,
    f_rel_under100miles_cnt_d = NULL                                      => -0.0048248848,
                                                                             -0.0048248848);

final_score_328_c1818 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '4: Recent Activity']) => -0.1114253635,
    (nf_seg_fraudpoint_3_0 in ['3: Derog', '5: Vuln Vic/Friendly', '6: Other'])            => -0.0183938634,
    nf_seg_fraudpoint_3_0 = ''	                                                           => -0.0512125558,
                                                                                              -0.0512125558);

final_score_328_c1816 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 4.5 => final_score_328_c1817,
    r_c14_addrs_5yr_i > 4.5                               => final_score_328_c1818,
    r_c14_addrs_5yr_i = NULL                              => -0.0065865070,
                                                             -0.0065865070);

final_score_328_c1815 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 10.5 => final_score_328_c1816,
    f_rel_homeover500_count_d > 10.5                                       => 0.0416814905,
    f_rel_homeover500_count_d = NULL                                       => -0.0061574816,
                                                                              -0.0061574816);

final_score_328 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 25.5 => final_score_328_c1815,
    f_rel_homeover300_count_d > 25.5                                       => 0.0637732639,
    f_rel_homeover300_count_d = NULL                                       => -0.0018363441,
                                                                              -0.0056207260);

final_score_329_c1822 := map(
    NULL < f_srchphonesrchcountwk_i AND f_srchphonesrchcountwk_i <= 0.5 => 0.0041718309,
    f_srchphonesrchcountwk_i > 0.5                                      => 0.1148784676,
    f_srchphonesrchcountwk_i = NULL                                     => 0.0057642425,
                                                                           0.0057642425);

final_score_329_c1821 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 84.55 => final_score_329_c1822,
    r_c12_source_profile_d > 84.55                                    => 0.0703534755,
    r_c12_source_profile_d = NULL                                     => 0.0069414271,
                                                                         0.0069414271);

final_score_329_c1823 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 8.5 => 0.0648788245,
    f_addrs_per_ssn_i > 8.5                               => 0.0144534985,
    f_addrs_per_ssn_i = NULL                              => 0.0335146183,
                                                             0.0335146183);

final_score_329_c1820 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 108848.5 => final_score_329_c1821,
    r_a49_curr_avm_chg_1yr_i > 108848.5                                      => final_score_329_c1823,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => -0.0006247402,
                                                                                0.0032904610);

final_score_329 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 556.5 => final_score_329_c1820,
    r_c10_m_hdr_fs_d > 556.5                              => -0.0804430786,
    r_c10_m_hdr_fs_d = NULL                               => -0.0209648068,
                                                             0.0025670133);

final_score_330_c1827 := map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d <= 5.5 => 0.0092261889,
    r_c14_addr_stability_v2_d > 5.5                                       => -0.0363507367,
    r_c14_addr_stability_v2_d = NULL                                      => -0.0138632536,
                                                                             -0.0138632536);

final_score_330_c1826 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 229484.5 => 0.0267901243,
    r_a46_curr_avm_autoval_d > 229484.5                                      => final_score_330_c1827,
    r_a46_curr_avm_autoval_d = NULL                                          => 0.0007490532,
                                                                                0.0076299236);

final_score_330_c1825 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_330_c1826,
    f_phone_ver_experian_d > 0.5                                    => -0.0022695006,
    f_phone_ver_experian_d = NULL                                   => 0.0260700056,
                                                                       0.0031934135);

final_score_330_c1828 := map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d <= 3.5 => -0.0274098322,
    r_c14_addr_stability_v2_d > 3.5                                       => -0.0827234682,
    r_c14_addr_stability_v2_d = NULL                                      => -0.0420896719,
                                                                             -0.0420896719);

final_score_330 := map(
    NULL < f_divaddrsuspidcountnew_i AND f_divaddrsuspidcountnew_i <= 2.5 => final_score_330_c1825,
    f_divaddrsuspidcountnew_i > 2.5                                       => final_score_330_c1828,
    f_divaddrsuspidcountnew_i = NULL                                      => 0.0439473770,
                                                                             0.0024422908);

final_score_331_c1831 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 18.5 => -0.0078072593,
    f_historical_count_d > 18.5                                  => 0.1384967306,
    f_historical_count_d = NULL                                  => -0.0065447525,
                                                                    -0.0065447525);

final_score_331_c1830 := map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 2.5 => final_score_331_c1831,
    f_rel_incomeover100_count_d > 2.5                                         => 0.0163368110,
    f_rel_incomeover100_count_d = NULL                                        => -0.0198622067,
                                                                                 -0.0032107202);

final_score_331_c1833 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 1.5 => 0.0430495896,
    k_inq_per_ssn_i > 1.5                             => 0.1385378979,
    k_inq_per_ssn_i = NULL                            => 0.0925954100,
                                                         0.0925954100);

final_score_331_c1832 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 0.5 => final_score_331_c1833,
    k_inq_adls_per_phone_i > 0.5                                    => 0.0014303622,
    k_inq_adls_per_phone_i = NULL                                   => 0.0356374244,
                                                                       0.0356374244);

final_score_331 := map(
    NULL < f_srchcountwk_i AND f_srchcountwk_i <= 0.5 => final_score_331_c1830,
    f_srchcountwk_i > 0.5                             => final_score_331_c1832,
    f_srchcountwk_i = NULL                            => 0.0151460787,
                                                         -0.0018594732);

final_score_332_c1836 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 163.5 => -0.0305186458,
    f_prevaddrageoldest_d > 163.5                                   => 0.0508244374,
    f_prevaddrageoldest_d = NULL                                    => -0.0157479069,
                                                                       -0.0157479069);

final_score_332_c1835 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 5.5 => -0.0029824059,
    f_addrchangeecontrajindex_d > 5.5                                         => -0.0550288479,
    f_addrchangeecontrajindex_d = NULL                                        => final_score_332_c1836,
                                                                                 -0.0049723746);

final_score_332_c1837 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 13.5 => 0.0026251029,
    f_addrs_per_ssn_i > 13.5                               => 0.1121736819,
    f_addrs_per_ssn_i = NULL                               => 0.0327629216,
                                                              0.0327629216);

final_score_332_c1838 := map(
    NULL < f_hh_prof_license_holders_d AND f_hh_prof_license_holders_d <= 1.5 => -0.0004726763,
    f_hh_prof_license_holders_d > 1.5                                         => 0.1416318906,
    f_hh_prof_license_holders_d = NULL                                        => 0.0078329580,
                                                                                 0.0013700594);

final_score_332 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 85562.5 => final_score_332_c1835,
    r_a49_curr_avm_chg_1yr_i > 85562.5                                      => final_score_332_c1837,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => final_score_332_c1838,
                                                                               -0.0006075468);

final_score_333_c1841 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 17.5 => -0.0034272019,
    f_rel_homeover300_count_d > 17.5                                       => 0.0471371926,
    f_rel_homeover300_count_d = NULL                                       => -0.0256086499,
                                                                              -0.0028857003);

final_score_333_c1840 := map(
    NULL < r_i60_inq_retail_count12_i AND r_i60_inq_retail_count12_i <= 0.5 => final_score_333_c1841,
    r_i60_inq_retail_count12_i > 0.5                                        => -0.0471453719,
    r_i60_inq_retail_count12_i = NULL                                       => -0.0064138734,
                                                                               -0.0064138734);

final_score_333_c1843 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 2.5 => -0.0726356304,
    f_phones_per_addr_curr_i > 2.5                                      => 0.0335051700,
    f_phones_per_addr_curr_i = NULL                                     => -0.0037178190,
                                                                           -0.0037178190);

final_score_333_c1842 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 3.5 => final_score_333_c1843,
    r_l79_adls_per_addr_curr_i > 3.5                                        => -0.1202595274,
    r_l79_adls_per_addr_curr_i = NULL                                       => -0.0359278389,
                                                                               -0.0359278389);

final_score_333 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 83.7 => final_score_333_c1840,
    r_c12_source_profile_d > 83.7                                    => final_score_333_c1842,
    r_c12_source_profile_d = NULL                                    => 0.0252106669,
                                                                        -0.0067199163);

final_score_334_c1848 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 17.5 => -0.0072779725,
    r_p88_phn_dst_to_inp_add_i > 17.5                                        => 0.0223676090,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => -0.0021908682,
                                                                                -0.0041479488);

final_score_334_c1847 := map(
    NULL < f_acc_damage_amt_total_i AND f_acc_damage_amt_total_i <= 5250 => final_score_334_c1848,
    f_acc_damage_amt_total_i > 5250                                      => 0.0975065793,
    f_acc_damage_amt_total_i = NULL                                      => -0.0035760926,
                                                                            -0.0035760926);

final_score_334_c1846 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 31.5 => final_score_334_c1847,
    f_rel_under25miles_cnt_d > 31.5                                      => 0.1089711439,
    f_rel_under25miles_cnt_d = NULL                                      => -0.0028102957,
                                                                            -0.0028102957);

final_score_334_c1845 := map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d <= 46.5 => final_score_334_c1846,
    f_rel_incomeover25_count_d > 46.5                                        => -0.0819316754,
    f_rel_incomeover25_count_d = NULL                                        => -0.0231849268,
                                                                                -0.0038297358);

final_score_334 := map(
    NULL < r_l71_add_business_i AND r_l71_add_business_i <= 0.5 => final_score_334_c1845,
    r_l71_add_business_i > 0.5                                  => -0.0716598734,
    r_l71_add_business_i = NULL                                 => -0.0044166824,
                                                                   -0.0044166824);

final_score_335_c1853 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 117 => 0.1523437270,
    r_c13_curr_addr_lres_d > 117                                    => -0.0121534132,
    r_c13_curr_addr_lres_d = NULL                                   => 0.0739748064,
                                                                       0.0739748064);

final_score_335_c1852 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 7.5 => 0.0085256312,
    f_rel_homeover200_count_d > 7.5                                       => final_score_335_c1853,
    f_rel_homeover200_count_d = NULL                                      => 0.0221958038,
                                                                             0.0221958038);

final_score_335_c1851 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 79.15 => 0.0002419797,
    r_c12_source_profile_d > 79.15                                    => final_score_335_c1852,
    r_c12_source_profile_d = NULL                                     => 0.0014548258,
                                                                         0.0014548258);

final_score_335_c1850 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 474.5 => final_score_335_c1851,
    r_c13_curr_addr_lres_d > 474.5                                    => -0.0528605584,
    r_c13_curr_addr_lres_d = NULL                                     => 0.0011473803,
                                                                         0.0011473803);

final_score_335 := map(
    NULL < f_mos_liens_unrel_ot_lseen_d AND f_mos_liens_unrel_ot_lseen_d <= 7.5 => 0.1481775143,
    f_mos_liens_unrel_ot_lseen_d > 7.5                                          => final_score_335_c1850,
    f_mos_liens_unrel_ot_lseen_d = NULL                                         => 0.0349432125,
                                                                                   0.0023218756);

final_score_336_c1856 := map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d <= 3.5 => -0.0102359631,
    r_c14_addr_stability_v2_d > 3.5                                       => -0.1017014069,
    r_c14_addr_stability_v2_d = NULL                                      => -0.0486130724,
                                                                             -0.0486130724);

final_score_336_c1858 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 6.5 => 0.1308703286,
    f_rel_educationover12_count_d > 6.5                                           => 0.0096604825,
    f_rel_educationover12_count_d = NULL                                          => 0.0165191267,
                                                                                     0.0165191267);

final_score_336_c1857 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 7.5 => -0.0374847663,
    f_rel_under100miles_cnt_d > 7.5                                       => final_score_336_c1858,
    f_rel_under100miles_cnt_d = NULL                                      => -0.0034425395,
                                                                             -0.0034425395);

final_score_336_c1855 := map(
    (nf_source_type in ['Bureau and Behavioral', 'Bureau Only', 'Government Only'])                                                           => final_score_336_c1856,
    (nf_source_type in ['Behavioral and Government', 'Behavioral Only', 'Bureau and Government', 'Bureau Behavioral and Government', 'None']) => final_score_336_c1857,
    nf_source_type = ''                                                                                                                     => -0.0071969734,
                                                                                                                                                 -0.0071969734);

final_score_336 := map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 2.5 => 0.0057015021,
    r_s66_adlperssn_count_i > 2.5                                     => final_score_336_c1855,
    r_s66_adlperssn_count_i = NULL                                    => 0.0033157401,
                                                                         0.0033157401);

final_score_337_c1863 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '3: Derog', '5: Vuln Vic/Friendly']) => 0.0128565352,
    (nf_seg_fraudpoint_3_0 in ['2: Synth ID', '4: Recent Activity', '6: Other'])          => 0.1218804020,
    nf_seg_fraudpoint_3_0 = ''                                                          => 0.0609131081,
                                                                                             0.0609131081);

final_score_337_c1862 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 43.45 => -0.0268706351,
    r_c12_source_profile_d > 43.45                                    => final_score_337_c1863,
    r_c12_source_profile_d = NULL                                     => 0.0316518604,
                                                                         0.0316518604);

final_score_337_c1861 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 14.5 => 0.0007308715,
    f_phones_per_addr_curr_i > 14.5                                      => final_score_337_c1862,
    f_phones_per_addr_curr_i = NULL                                      => 0.0015487352,
                                                                            0.0015487352);

final_score_337_c1860 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 5.5 => final_score_337_c1861,
    r_e57_br_source_count_d > 5.5                                     => 0.0620086760,
    r_e57_br_source_count_d = NULL                                    => 0.0020736576,
                                                                         0.0020736576);

final_score_337 := map(
    NULL < r_d31_bk_filing_count_i AND r_d31_bk_filing_count_i <= 1.5 => final_score_337_c1860,
    r_d31_bk_filing_count_i > 1.5                                     => -0.0647622480,
    r_d31_bk_filing_count_i = NULL                                    => 0.0396336710,
                                                                         -0.0021112327);

final_score_338_c1868 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 1.5 => -0.0412762631,
    f_rel_under500miles_cnt_d > 1.5                                       => 0.0449669654,
    f_rel_under500miles_cnt_d = NULL                                      => 0.0373803916,
                                                                             0.0373803916);

final_score_338_c1867 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 7.5 => final_score_338_c1868,
    f_rel_homeover500_count_d > 7.5                                       => -0.0536984883,
    f_rel_homeover500_count_d = NULL                                      => 0.0332206341,
                                                                             0.0332206341);

final_score_338_c1866 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 3.5 => -0.0144834200,
    r_wealth_index_d > 3.5                              => final_score_338_c1867,
    r_wealth_index_d = NULL                             => 0.0112726465,
                                                           0.0112726465);

final_score_338_c1865 := map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 0.5 => final_score_338_c1866,
    f_hh_members_w_derog_i > 0.5                                    => -0.0047644895,
    f_hh_members_w_derog_i = NULL                                   => 0.0162343066,
                                                                       -0.0007767095);

final_score_338 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 36.5 => final_score_338_c1865,
    f_bus_addr_match_count_d > 36.5                                      => -0.0543676325,
    f_bus_addr_match_count_d = NULL                                      => -0.0010866808,
                                                                            -0.0010866808);

final_score_339_c1870 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 5.5 => -0.0336885355,
    r_l79_adls_per_addr_c6_i > 5.5                                      => -0.1195821957,
    r_l79_adls_per_addr_c6_i = NULL                                     => -0.0427085888,
                                                                           -0.0427085888);

final_score_339_c1873 := map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 2.5 => 0.0594552174,
    f_hh_members_w_derog_i > 2.5                                    => -0.0467348283,
    f_hh_members_w_derog_i = NULL                                   => 0.0399902544,
                                                                       0.0399902544);

final_score_339_c1872 := map(
    (nf_source_type in ['Behavioral and Government', 'Bureau and Behavioral', 'Bureau and Government', 'Bureau Behavioral and Government', 'Government Only']) => 0.0015289064,
    (nf_source_type in ['Behavioral Only', 'Bureau Only', 'None'])                                                                                             => final_score_339_c1873,
    nf_source_type = ''                                                                                                                                      => 0.0027422468,
                                                                                                                                                                  0.0027422468);

final_score_339_c1871 := map(
    NULL < f_divrisktype_i AND f_divrisktype_i <= 5.5 => final_score_339_c1872,
    f_divrisktype_i > 5.5                             => 0.0773064892,
    f_divrisktype_i = NULL                            => 0.0032889241,
                                                         0.0032889241);

final_score_339 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 36.5 => final_score_339_c1870,
    r_c10_m_hdr_fs_d > 36.5                              => final_score_339_c1871,
    r_c10_m_hdr_fs_d = NULL                              => -0.0098753942,
                                                            0.0005632946);

final_score_340_c1878 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 6.5 => 0.0310764100,
    f_rel_under25miles_cnt_d > 6.5                                      => -0.0116902918,
    f_rel_under25miles_cnt_d = NULL                                     => 0.0085338694,
                                                                           0.0085338694);

final_score_340_c1877 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 2.5 => 0.0178552230,
    f_addrchangeecontrajindex_d > 2.5                                         => 0.1063155154,
    f_addrchangeecontrajindex_d = NULL                                        => final_score_340_c1878,
                                                                                 0.0131594150);

final_score_340_c1876 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => -0.0021245701,
    r_f03_input_add_not_most_rec_i > 0.5                                            => final_score_340_c1877,
    r_f03_input_add_not_most_rec_i = NULL                                           => 0.0002384199,
                                                                                       0.0002384199);

final_score_340_c1875 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 38.5 => final_score_340_c1876,
    f_bus_addr_match_count_d > 38.5                                      => -0.0669373686,
    f_bus_addr_match_count_d = NULL                                      => -0.0001527899,
                                                                            -0.0001527899);

final_score_340 := map(
    NULL < r_f00_input_dob_match_level_d AND r_f00_input_dob_match_level_d <= 3.5 => 0.0665708757,
    r_f00_input_dob_match_level_d > 3.5                                           => final_score_340_c1875,
    r_f00_input_dob_match_level_d = NULL                                          => -0.0199791990,
                                                                                     0.0000872184);

final_score_341_c1882 := map(
    NULL < r_a44_curr_add_naprop_d AND r_a44_curr_add_naprop_d <= 1.5 => 0.0030919121,
    r_a44_curr_add_naprop_d > 1.5                                     => 0.0478262120,
    r_a44_curr_add_naprop_d = NULL                                    => 0.0303103846,
                                                                         0.0303103846);

final_score_341_c1881 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_341_c1882,
    r_phn_cell_n > 0.5                          => 0.0005136450,
    r_phn_cell_n = NULL                         => 0.0129994002,
                                                   0.0129994002);

final_score_341_c1883 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 1.5 => -0.0415621994,
    k_inq_per_ssn_i > 1.5                             => 0.0342193477,
    k_inq_per_ssn_i = NULL                            => -0.0223977908,
                                                         -0.0223977908);

final_score_341_c1880 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 307.5 => final_score_341_c1881,
    r_c13_max_lres_d > 307.5                              => final_score_341_c1883,
    r_c13_max_lres_d = NULL                               => 0.0094693317,
                                                             0.0094693317);

final_score_341 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => -0.0125149432,
    r_i61_inq_collection_recency_d > 549                                            => final_score_341_c1880,
    r_i61_inq_collection_recency_d = NULL                                           => 0.0054587112,
                                                                                       -0.0042040305);

final_score_342_c1886 := map(
    NULL < nf_number_non_bureau_sources AND nf_number_non_bureau_sources <= 3.5 => -0.0797976240,
    nf_number_non_bureau_sources > 3.5                                          => 0.0214925673,
    nf_number_non_bureau_sources = NULL                                         => -0.0254667667,
                                                                                   -0.0254667667);

final_score_342_c1888 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 110.4 => 0.0291746958,
    r_a49_curr_avm_chg_1yr_pct_i > 110.4                                          => 0.0764556426,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                           => 0.1441288409,
                                                                                     0.0822113173);

final_score_342_c1887 := map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i <= 2.5 => final_score_342_c1888,
    f_rel_criminal_count_i > 2.5                                    => 0.0044112021,
    f_rel_criminal_count_i = NULL                                   => 0.0493715882,
                                                                       0.0493715882);

final_score_342_c1885 := map(
    NULL < r_a41_prop_owner_inp_only_d AND r_a41_prop_owner_inp_only_d <= 0.5 => final_score_342_c1886,
    r_a41_prop_owner_inp_only_d > 0.5                                         => final_score_342_c1887,
    r_a41_prop_owner_inp_only_d = NULL                                        => 0.0246255725,
                                                                                 0.0246255725);

final_score_342 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 381.5 => -0.0057580330,
    r_c21_m_bureau_adl_fs_d > 381.5                                     => final_score_342_c1885,
    r_c21_m_bureau_adl_fs_d = NULL                                      => -0.0054848979,
                                                                           -0.0039468901);

final_score_343_c1892 := map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 7.5 => -0.0082669948,
    f_rel_homeover150_count_d > 7.5                                       => 0.0982101595,
    f_rel_homeover150_count_d = NULL                                      => 0.0369590874,
                                                                             0.0369590874);

final_score_343_c1891 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 95 => final_score_343_c1892,
    r_f01_inp_addr_address_score_d > 95                                            => 0.0044063633,
    r_f01_inp_addr_address_score_d = NULL                                          => 0.0056019825,
                                                                                      0.0056019825);

final_score_343_c1893 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 0.5 => 0.0185610715,
    f_util_adl_count_n > 0.5                                => -0.0655968716,
    f_util_adl_count_n = NULL                               => -0.0360278645,
                                                               -0.0360278645);

final_score_343_c1890 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 105050 => final_score_343_c1891,
    r_a49_curr_avm_chg_1yr_i > 105050                                      => final_score_343_c1893,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => -0.0046183936,
                                                                              -0.0007136244);

final_score_343 := map(
    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i <= 3.5 => final_score_343_c1890,
    k_inq_addrs_per_ssn_i > 3.5                                   => 0.0991302892,
    k_inq_addrs_per_ssn_i = NULL                                  => -0.0001773430,
                                                                     -0.0001773430);

final_score_344_c1897 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 33016.5 => 0.0054407101,
    r_a49_curr_avm_chg_1yr_i > 33016.5                                      => -0.0369780263,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => 0.0041935990,
                                                                               0.0007555416);

final_score_344_c1896 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 946 => -0.0044746521,
    r_p88_phn_dst_to_inp_add_i > 946                                        => 0.0726964947,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => final_score_344_c1897,
                                                                               -0.0026701530);

final_score_344_c1895 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 13.5 => final_score_344_c1896,
    r_c18_invalid_addrs_per_adl_i > 13.5                                           => -0.1305187457,
    r_c18_invalid_addrs_per_adl_i = NULL                                           => -0.0340255208,
                                                                                      -0.0037348946);

final_score_344_c1898 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.0778233910,
    f_phone_ver_experian_d > 0.5                                    => -0.0233024202,
    f_phone_ver_experian_d = NULL                                   => 0.0190939680,
                                                                       0.0190939680);

final_score_344 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 11.5 => final_score_344_c1895,
    k_inq_per_ssn_i > 11.5                             => final_score_344_c1898,
    k_inq_per_ssn_i = NULL                             => -0.0033450210,
                                                          -0.0033450210);

final_score_345_c1902 := map(
    NULL < f_util_add_curr_conv_n AND f_util_add_curr_conv_n <= 0.5 => 0.0353075546,
    f_util_add_curr_conv_n > 0.5                                    => -0.0210207757,
    f_util_add_curr_conv_n = NULL                                   => -0.0086079055,
                                                                       -0.0086079055);

final_score_345_c1903 := map(
    NULL < f_inputaddractivephonelist_d AND f_inputaddractivephonelist_d <= 0.5 => -0.0749468814,
    f_inputaddractivephonelist_d > 0.5                                          => -0.0216510389,
    f_inputaddractivephonelist_d = NULL                                         => -0.0360251639,
                                                                                   -0.0360251639);

final_score_345_c1901 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 157.5 => final_score_345_c1902,
    f_prevaddrageoldest_d > 157.5                                   => final_score_345_c1903,
    f_prevaddrageoldest_d = NULL                                    => -0.0169594346,
                                                                       -0.0169594346);

final_score_345_c1900 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 249942 => 0.0026417409,
    r_a46_curr_avm_autoval_d > 249942                                      => final_score_345_c1901,
    r_a46_curr_avm_autoval_d = NULL                                        => 0.0055117325,
                                                                              0.0009576974);

final_score_345 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 9.5 => final_score_345_c1900,
    f_rel_homeover500_count_d > 9.5                                       => 0.0512614795,
    f_rel_homeover500_count_d = NULL                                      => -0.0094749286,
                                                                             0.0013330471);

final_score_346_c1907 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 15.5 => 0.0035952716,
    f_addrs_per_ssn_i > 15.5                               => 0.0465581332,
    f_addrs_per_ssn_i = NULL                               => 0.0101848677,
                                                              0.0101848677);

final_score_346_c1906 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 76035.5 => final_score_346_c1907,
    r_a49_curr_avm_chg_1yr_i > 76035.5                                      => -0.0294111948,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => 0.0142728057,
                                                                               0.0106014786);

final_score_346_c1905 := map(
    NULL < f_dl_addrs_per_adl_i AND f_dl_addrs_per_adl_i <= 0.5 => final_score_346_c1906,
    f_dl_addrs_per_adl_i > 0.5                                  => -0.0119509685,
    f_dl_addrs_per_adl_i = NULL                                 => 0.0001146471,
                                                                   0.0001146471);

final_score_346_c1908 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 6.5 => -0.0146567778,
    f_rel_homeover500_count_d > 6.5                                       => 0.0845417998,
    f_rel_homeover500_count_d = NULL                                      => 0.0400624376,
                                                                             0.0400624376);

final_score_346 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 18.5 => final_score_346_c1905,
    f_rel_homeover300_count_d > 18.5                                       => final_score_346_c1908,
    f_rel_homeover300_count_d = NULL                                       => -0.0313214661,
                                                                              -0.0001105751);

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
    final_score_346;

base := 400;

odds := (1 - 0.0253) / 0.0253;

point := -40;

fp1702_1_0 := min(if(max(round(point * (final_score - ln(odds)) / ln(2) + base), 300) = NULL, -NULL, max(round(point * (final_score - ln(odds)) / ln(2) + base), 300)), 999);

_ver_src_ds := Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0;

_ver_src_de := Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0;

_ver_src_eq := Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0;

_ver_src_en := Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0;

_ver_src_tn := Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0;

_ver_src_tu := Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0;

_credit_source_cnt := if(max((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu) = NULL, NULL, sum((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu));

_ver_src_cnt := Models.Common.countw((string)(ver_sources));

_bureauonly := _credit_source_cnt > 0 AND _credit_source_cnt = _ver_src_cnt AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6]));

_derog := felony_count > 0 OR (integer)addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2;

_deceased := rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de;

_ssnpriortodob := rc_ssndobflag = '1' OR rc_pwssndobflag = '1';

_inputmiskeys := rc_ssnmiskeyflag or rc_addrmiskeyflag or (Integer)add_input_house_number_match = 0;

_multiplessns := ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1;

_hh_strikes := if((integer)max((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0) = NULL, NULL, (integer)sum((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0));

stolenid := if(addrpop and (nas_summary in [4, 7, 9]) or fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and (integer)ssnlength = 9 or _deceased or _ssnpriortodob, 1, 0);

manipulatedid := if(_inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1), 1, 0);

manipulatedidpt2 := if(1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and (integer)ssnlength = 9, 1, 0);

suspiciousactivity := if(_derog, 1, 0);

vulnerablevictim := if(0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70, 1, 0);

friendlyfraud := if(hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2), 1, 0);

ver_src_ak := Models.Common.findw_cpp(ver_sources, 'AK' , ',', '') > 0;

ver_src_am := Models.Common.findw_cpp(ver_sources, 'AM' , ',', '') > 0;

ver_src_ar := Models.Common.findw_cpp(ver_sources, 'AR' , ',', '') > 0;

ver_src_ba := Models.Common.findw_cpp(ver_sources, 'BA' , ',', '') > 0;

ver_src_cg := Models.Common.findw_cpp(ver_sources, 'CG' , ',', '') > 0;

ver_src_co := Models.Common.findw_cpp(ver_sources, 'CO' , ',', '') > 0;

ver_src_cy := Models.Common.findw_cpp(ver_sources, 'CY' , ',', '') > 0;

ver_src_da := Models.Common.findw_cpp(ver_sources, 'DA' , ',', '') > 0;

ver_src_d := Models.Common.findw_cpp(ver_sources, 'D ' , ',', '') > 0;

ver_src_dl := Models.Common.findw_cpp(ver_sources, 'DL' , ',', '') > 0;

ver_src_ds := Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0;

ver_src_de := Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0;

ver_src_eb := Models.Common.findw_cpp(ver_sources, 'EB' , ',', '') > 0;

ver_src_em := Models.Common.findw_cpp(ver_sources, 'EM' , ',', '') > 0;

ver_src_e1 := Models.Common.findw_cpp(ver_sources, 'E1' , ',', '') > 0;

ver_src_e2 := Models.Common.findw_cpp(ver_sources, 'E2' , ',', '') > 0;

ver_src_e3 := Models.Common.findw_cpp(ver_sources, 'E3' , ',', '') > 0;

ver_src_e4 := Models.Common.findw_cpp(ver_sources, 'E4' , ',', '') > 0;

ver_src_en := Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0;

ver_src_eq := Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0;

ver_src_fe := Models.Common.findw_cpp(ver_sources, 'FE' , ',', '') > 0;

ver_src_ff := Models.Common.findw_cpp(ver_sources, 'FF' , ',', '') > 0;

ver_src_fr := Models.Common.findw_cpp(ver_sources, 'FR' , ',', '') > 0;

ver_src_l2 := Models.Common.findw_cpp(ver_sources, 'L2' , ',', '') > 0;

ver_src_li := Models.Common.findw_cpp(ver_sources, 'LI' , ',', '') > 0;

ver_src_mw := Models.Common.findw_cpp(ver_sources, 'MW' , ',', '') > 0;

ver_src_nt := Models.Common.findw_cpp(ver_sources, 'NT' , ',', '') > 0;

ver_src_p := Models.Common.findw_cpp(ver_sources, 'P ' , ',', '') > 0;

ver_src_pl := Models.Common.findw_cpp(ver_sources, 'PL' , ',', '') > 0;

ver_src_tn := Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0;

ver_src_ts := Models.Common.findw_cpp(ver_sources, 'TS' , ',', '') > 0;

ver_src_tu := Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0;

ver_src_sl := Models.Common.findw_cpp(ver_sources, 'SL' , ',', '') > 0;

ver_src_v := Models.Common.findw_cpp(ver_sources, 'V ' , ',', '') > 0;

ver_src_vo := Models.Common.findw_cpp(ver_sources, 'VO' , ',', '') > 0;

ver_src_w := Models.Common.findw_cpp(ver_sources, 'W ' , ',', '') > 0;

ver_src_wp := Models.Common.findw_cpp(ver_sources, 'WP' , ',', '') > 0;

src_bureau := (integer)ver_src_en +
    (integer)ver_src_eq +
    (integer)ver_src_tn +
    (integer)ver_src_ts;

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

syntheticid2 := map(
    not(truedid) or ver_sources = ' '                                      => 1,
    truedid and src_behavioral = 0 and src_inperson = 0 and src_bureau > 0 => 1,
    truedid and src_inperson = 0 and src_bureau = 0                        => 1,
                                                                              0);

stolenc_fp1702_1_0 := if((Boolean)stolenid, fp1702_1_0, 299);

manip2c_fp1702_1_0 := if((boolean)(integer)manipulatedid or (boolean)(integer)manipulatedidpt2, fp1702_1_0, 299);

synth2c_fp1702_1_0 := if((Boolean)syntheticid2, fp1702_1_0, 299);

suspactc_fp1702_1_0 := if((Boolean)suspiciousactivity, fp1702_1_0, 299);

vulnvicc_fp1702_1_0 := if((Boolean)vulnerablevictim, fp1702_1_0, 299);

friendlyc_fp1702_1_0 := if((Boolean)friendlyfraud, fp1702_1_0, 299);

custstolidindex := map(
    stolenc_fp1702_1_0 = 299                                => 1,
    300 <= stolenc_fp1702_1_0 AND stolenc_fp1702_1_0 < 460  => 9,
    460 <= stolenc_fp1702_1_0 AND stolenc_fp1702_1_0 < 580  => 8,
    580 <= stolenc_fp1702_1_0 AND stolenc_fp1702_1_0 < 630  => 7,
    630 <= stolenc_fp1702_1_0 AND stolenc_fp1702_1_0 < 695  => 6,
    695 <= stolenc_fp1702_1_0 AND stolenc_fp1702_1_0 < 735  => 5,
    735 <= stolenc_fp1702_1_0 AND stolenc_fp1702_1_0 < 785  => 4,
    785 <= stolenc_fp1702_1_0 AND stolenc_fp1702_1_0 < 835  => 3,
    835 <= stolenc_fp1702_1_0 AND stolenc_fp1702_1_0 <= 999 => 2,
                                                               99);

custmanipidindex := map(
    manip2c_fp1702_1_0 = 299                                => 1,
    300 <= manip2c_fp1702_1_0 AND manip2c_fp1702_1_0 < 540  => 9,
    540 <= manip2c_fp1702_1_0 AND manip2c_fp1702_1_0 < 620  => 8,
    620 <= manip2c_fp1702_1_0 AND manip2c_fp1702_1_0 < 695  => 7,
    695 <= manip2c_fp1702_1_0 AND manip2c_fp1702_1_0 < 750  => 6,
    750 <= manip2c_fp1702_1_0 AND manip2c_fp1702_1_0 < 775  => 5,
    775 <= manip2c_fp1702_1_0 AND manip2c_fp1702_1_0 < 805  => 4,
    805 <= manip2c_fp1702_1_0 AND manip2c_fp1702_1_0 < 850  => 3,
    850 <= manip2c_fp1702_1_0 AND manip2c_fp1702_1_0 <= 999 => 2,
                                                               99);

custsynthidindex := map(
    synth2c_fp1702_1_0 = 299                                => 1,
    300 <= synth2c_fp1702_1_0 AND synth2c_fp1702_1_0 < 515  => 9,
    515 <= synth2c_fp1702_1_0 AND synth2c_fp1702_1_0 < 615  => 8,
    615 <= synth2c_fp1702_1_0 AND synth2c_fp1702_1_0 < 670  => 7,
    670 <= synth2c_fp1702_1_0 AND synth2c_fp1702_1_0 < 755  => 6,
    755 <= synth2c_fp1702_1_0 AND synth2c_fp1702_1_0 < 800  => 5,
    800 <= synth2c_fp1702_1_0 AND synth2c_fp1702_1_0 < 835  => 4,
    835 <= synth2c_fp1702_1_0 AND synth2c_fp1702_1_0 < 880  => 3,
    880 <= synth2c_fp1702_1_0 AND synth2c_fp1702_1_0 <= 999 => 2,
                                                               99);

custsuspactindex := map(
    suspactc_fp1702_1_0 = 299                                 => 1,
    300 <= suspactc_fp1702_1_0 AND suspactc_fp1702_1_0 < 585  => 9,
    585 <= suspactc_fp1702_1_0 AND suspactc_fp1702_1_0 < 650  => 8,
    650 <= suspactc_fp1702_1_0 AND suspactc_fp1702_1_0 < 715  => 7,
    715 <= suspactc_fp1702_1_0 AND suspactc_fp1702_1_0 < 755  => 6,
    755 <= suspactc_fp1702_1_0 AND suspactc_fp1702_1_0 < 790  => 5,
    790 <= suspactc_fp1702_1_0 AND suspactc_fp1702_1_0 < 845  => 4,
    845 <= suspactc_fp1702_1_0 AND suspactc_fp1702_1_0 < 890  => 3,
    890 <= suspactc_fp1702_1_0 AND suspactc_fp1702_1_0 <= 999 => 2,
                                                                 99);

custvulnvicindex := map(
    vulnvicc_fp1702_1_0 = 299                                 => 1,
    300 <= vulnvicc_fp1702_1_0 AND vulnvicc_fp1702_1_0 < 480  => 9,
    480 <= vulnvicc_fp1702_1_0 AND vulnvicc_fp1702_1_0 < 595  => 8,
    595 <= vulnvicc_fp1702_1_0 AND vulnvicc_fp1702_1_0 < 675  => 7,
    675 <= vulnvicc_fp1702_1_0 AND vulnvicc_fp1702_1_0 < 730  => 6,
    730 <= vulnvicc_fp1702_1_0 AND vulnvicc_fp1702_1_0 < 790  => 5,
    790 <= vulnvicc_fp1702_1_0 AND vulnvicc_fp1702_1_0 < 840  => 4,
    840 <= vulnvicc_fp1702_1_0 AND vulnvicc_fp1702_1_0 < 860  => 3,
    860 <= vulnvicc_fp1702_1_0 AND vulnvicc_fp1702_1_0 <= 999 => 2,
                                                                 99);

custfriendfrdindex := map(
    friendlyc_fp1702_1_0 = 299                                  => 1,
    300 <= friendlyc_fp1702_1_0 AND friendlyc_fp1702_1_0 < 505  => 9,
    505 <= friendlyc_fp1702_1_0 AND friendlyc_fp1702_1_0 < 595  => 8,
    595 <= friendlyc_fp1702_1_0 AND friendlyc_fp1702_1_0 < 650  => 7,
    650 <= friendlyc_fp1702_1_0 AND friendlyc_fp1702_1_0 < 725  => 6,
    725 <= friendlyc_fp1702_1_0 AND friendlyc_fp1702_1_0 < 785  => 5,
    785 <= friendlyc_fp1702_1_0 AND friendlyc_fp1702_1_0 < 840  => 4,
    840 <= friendlyc_fp1702_1_0 AND friendlyc_fp1702_1_0 < 880  => 3,
    880 <= friendlyc_fp1702_1_0 AND friendlyc_fp1702_1_0 <= 999 => 2,
                                                                   99);
																																	 
//*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//

	#if(FP_DEBUG)
		/* Model Input Variables */
                    self.sysdate                          := sysdate;
                    self.f_phone_ver_experian_d           := f_phone_ver_experian_d;
                    self.k_nap_phn_verd_d           			:= k_nap_phn_verd_d;
                    self.f_rel_homeover500_count_d        := f_rel_homeover500_count_d;
                    self.f_phone_ver_insurance_d          := f_phone_ver_insurance_d;
                    self.r_c12_source_profile_d           := r_c12_source_profile_d;
                    self.r_a49_curr_avm_chg_1yr_i         := r_a49_curr_avm_chg_1yr_i;
                    self.f_addrchangeecontrajindex_d      := f_addrchangeecontrajindex_d;
                    self.r_phn_cell_n                     := r_phn_cell_n;
                    self.f_prevaddrageoldest_d            := f_prevaddrageoldest_d;
                    self.r_phn_pcs_n                      := r_phn_pcs_n;
                    self.r_a46_curr_avm_autoval_d         := r_a46_curr_avm_autoval_d;
                    self.r_wealth_index_d                 := r_wealth_index_d;
                    self.f_hh_lienholders_i               := f_hh_lienholders_i;
                    self.k_inq_per_phone_i                := k_inq_per_phone_i;
                    self.f_idverrisktype_i                := f_idverrisktype_i;
                    self.f_rel_homeover300_count_d        := f_rel_homeover300_count_d;
                    self.r_p88_phn_dst_to_inp_add_i       := r_p88_phn_dst_to_inp_add_i;
                    self.r_f03_address_match_d            := r_f03_address_match_d;
                    self.r_c13_max_lres_d                 := r_c13_max_lres_d;
                    self.r_c14_addr_stability_v2_d        := r_c14_addr_stability_v2_d;
                    self.r_l80_inp_avm_autoval_d          := r_l80_inp_avm_autoval_d;
                    self.r_f00_dob_score_d                := r_f00_dob_score_d;
                    self.f_hh_tot_derog_i                 := f_hh_tot_derog_i;
                    self.f_validationrisktype_i           := f_validationrisktype_i;
                    self.r_i61_inq_collection_recency_d   := r_i61_inq_collection_recency_d;
                    self.r_c23_inp_addr_occ_index_d       := r_c23_inp_addr_occ_index_d;
                    self.f_rel_under25miles_cnt_d         := f_rel_under25miles_cnt_d;
                    self.r_p85_phn_disconnected_i         := r_p85_phn_disconnected_i;
                    self.r_f03_input_add_not_most_rec_i   := r_f03_input_add_not_most_rec_i;
                    self.nf_seg_fraudpoint_3_0            := nf_seg_fraudpoint_3_0;
                    self.f_addrs_per_ssn_i                := f_addrs_per_ssn_i;
                    self.k_inq_adls_per_phone_i           := k_inq_adls_per_phone_i;
                    self._header_first_seen               := _header_first_seen;
                    self.r_c10_m_hdr_fs_d                 := r_c10_m_hdr_fs_d;
                    self.f_rel_educationover12_count_d    := f_rel_educationover12_count_d;
                    self.f_prevaddrlenofres_d             := f_prevaddrlenofres_d;
                    self.k_inf_phn_verd_d                 := k_inf_phn_verd_d;
                    self.f_bus_addr_match_count_d         := f_bus_addr_match_count_d;
                    self.f_phones_per_addr_curr_i         := f_phones_per_addr_curr_i;
                    self.k_inq_per_ssn_i                  := k_inq_per_ssn_i;
                    self.r_l79_adls_per_addr_c6_i         := r_l79_adls_per_addr_c6_i;
                    self.k_inq_lnames_per_addr_i          := k_inq_lnames_per_addr_i;
                    self.f_rel_under500miles_cnt_d        := f_rel_under500miles_cnt_d;
                    self.r_d30_derog_count_i              := r_d30_derog_count_i;
                    self.f_rel_under100miles_cnt_d        := f_rel_under100miles_cnt_d;
                    self.r_d31_mostrec_bk_i               := r_d31_mostrec_bk_i;
                    self.r_c13_curr_addr_lres_d           := r_c13_curr_addr_lres_d;
                    self.f_srchcomponentrisktype_i        := f_srchcomponentrisktype_i;
                    self.f_hh_bankruptcies_i              := f_hh_bankruptcies_i;
                    self.r_f00_input_dob_match_level_d    := r_f00_input_dob_match_level_d;
                    self._src_bureau_adl_fseen_notu       := _src_bureau_adl_fseen_notu;
                    self.f_m_bureau_adl_fs_notu_d         := f_m_bureau_adl_fs_notu_d;
                    self.r_l79_adls_per_addr_curr_i       := r_l79_adls_per_addr_curr_i;
                    self.r_e57_br_source_count_d          := r_e57_br_source_count_d;
                    self.r_f00_ssn_score_d                := r_f00_ssn_score_d;
                    self.f_srchunvrfdaddrcount_i          := f_srchunvrfdaddrcount_i;
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
                    self.f_m_bureau_adl_fs_all_d          := f_m_bureau_adl_fs_all_d;
                    self._liens_unrel_cj_first_seen       := _liens_unrel_cj_first_seen;
                    self.f_mos_liens_unrel_cj_fseen_d     := f_mos_liens_unrel_cj_fseen_d;
                    self.f_recent_disconnects_i           := f_recent_disconnects_i;
                    self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
                    self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
                    self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
                    self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
                    self.r_c21_m_bureau_adl_fs_d          := r_c21_m_bureau_adl_fs_d;
                    self._liens_unrel_cj_last_seen        := _liens_unrel_cj_last_seen;
                    self.f_mos_liens_unrel_cj_lseen_d     := f_mos_liens_unrel_cj_lseen_d;
                    self.r_a49_curr_avm_chg_1yr_pct_i     := r_a49_curr_avm_chg_1yr_pct_i;
                    self.r_f01_inp_addr_address_score_d   := r_f01_inp_addr_address_score_d;
                    self.f_srchunvrfdphonecount_i         := f_srchunvrfdphonecount_i;
                    self.r_d31_bk_chapter_n               := r_d31_bk_chapter_n;
                    self.f_rel_criminal_count_i           := f_rel_criminal_count_i;
                    self.f_srchvelocityrisktype_i         := f_srchvelocityrisktype_i;
                    self.f_rel_homeover200_count_d        := f_rel_homeover200_count_d;
                    self.k_inf_contradictory_i            := k_inf_contradictory_i;
                    self.f_rel_incomeover50_count_d       := f_rel_incomeover50_count_d;
                    self.k_inf_lname_verd_d               := k_inf_lname_verd_d;
                    self.k_inq_ssns_per_addr_i            := k_inq_ssns_per_addr_i;
                    self.nf_number_non_bureau_sources     := nf_number_non_bureau_sources;
                    self.k_inq_adls_per_addr_i            := k_inq_adls_per_addr_i;
                    self.r_c12_source_profile_index_d     := r_c12_source_profile_index_d;
                    self._add_not_ver                     := _add_not_ver;
                    self.nf_inq_per_add_nas_479           := nf_inq_per_add_nas_479;
                    self.f_property_owners_ct_d           := f_property_owners_ct_d;
                    self.f_inq_count24_i                  := f_inq_count24_i;
                    self.r_c12_num_nonderogs_d            := r_c12_num_nonderogs_d;
                    self.f_hh_members_w_derog_i           := f_hh_members_w_derog_i;
                    self.f_rel_incomeover100_count_d      := f_rel_incomeover100_count_d;
                    self.f_dl_addrs_per_adl_i             := f_dl_addrs_per_adl_i;
                    self.f_historical_count_d             := f_historical_count_d;
                    self.r_p85_phn_not_issued_i           := r_p85_phn_not_issued_i;
                    self.f_rel_homeover150_count_d        := f_rel_homeover150_count_d;
                    self.f_hh_collections_ct_i            := f_hh_collections_ct_i;
                    self.k_inq_addrs_per_ssn_i            := k_inq_addrs_per_ssn_i;
                    self.f_assocsuspicousidcount_i        := f_assocsuspicousidcount_i;
                    self.f_bus_fname_verd_d               := f_bus_fname_verd_d;
                    self._criminal_last_date              := _criminal_last_date;
                    self.r_d32_mos_since_crim_ls_d        := r_d32_mos_since_crim_ls_d;
                    self.r_s66_adlperssn_count_i          := r_s66_adlperssn_count_i;
                    self.r_i60_inq_mortgage_recency_d     := r_i60_inq_mortgage_recency_d;
                    self.f_hh_college_attendees_d         := f_hh_college_attendees_d;
                    self.r_i60_inq_retail_recency_d       := r_i60_inq_retail_recency_d;
                    self.f_rel_homeover100_count_d        := f_rel_homeover100_count_d;
                    self.r_c18_invalid_addrs_per_adl_i    := r_c18_invalid_addrs_per_adl_i;
                    self.k_inq_per_addr_i                 := k_inq_per_addr_i;
                    self.f_rel_count_i                    := f_rel_count_i;
                    self.r_i60_inq_banking_recency_d      := r_i60_inq_banking_recency_d;
                    self.r_d34_unrel_liens_ct_i           := r_d34_unrel_liens_ct_i;
                    self.f_crim_rel_under100miles_cnt_i   := f_crim_rel_under100miles_cnt_i;
                    self._acc_last_seen                   := _acc_last_seen;
                    self.f_mos_acc_lseen_d                := f_mos_acc_lseen_d;
                    self.r_i60_inq_hiriskcred_recency_d   := r_i60_inq_hiriskcred_recency_d;
                    self.f_util_adl_count_n               := f_util_adl_count_n;
                    self.add_ec1                          := add_ec1;
                    self.add_ec3                          := add_ec3;
                    self.add_ec4                          := add_ec4;
                    self.r_l70_add_standardized_i         := r_l70_add_standardized_i;
                    self.f_rel_incomeover75_count_d       := f_rel_incomeover75_count_d;
                    self.f_accident_count_i               := f_accident_count_i;
                    self.f_phones_per_addr_c6_i           := f_phones_per_addr_c6_i;
                    self.f_varrisktype_i                  := f_varrisktype_i;
                    self._liens_rel_ot_first_seen         := _liens_rel_ot_first_seen;
                    self.f_mos_liens_rel_ot_fseen_d       := f_mos_liens_rel_ot_fseen_d;
                    self.f_crim_rel_under500miles_cnt_i   := f_crim_rel_under500miles_cnt_i;
                    self.r_l70_add_invalid_i              := r_l70_add_invalid_i;
                    self.f_divrisktype_i                  := f_divrisktype_i;
                    self.f_assoccredbureaucount_i         := f_assoccredbureaucount_i;
                    self.bureau_                          := bureau_;
                    self.behavioral_                      := behavioral_;
                    self.government_                      := government_;
                    self.nf_source_type                   := nf_source_type;
                    self.r_c14_addrs_5yr_i                := r_c14_addrs_5yr_i;
                    self.f_prevaddrstatus_i               := f_prevaddrstatus_i;
                    self.f_assocrisktype_i                := f_assocrisktype_i;
                    self.f_rel_homeover50_count_d         := f_rel_homeover50_count_d;
                    self.k_nap_fname_verd_d               := k_nap_fname_verd_d;
                    self.f_rel_incomeover25_count_d       := f_rel_incomeover25_count_d;
                    self.f_inq_retail_count24_i           := f_inq_retail_count24_i;
                    self.k_inq_lnames_per_ssn_i           := k_inq_lnames_per_ssn_i;
                    self.f_current_count_d                := f_current_count_d;
                    self.f_inq_other_count24_i            := f_inq_other_count24_i;
                    self.r_e55_college_ind_d              := r_e55_college_ind_d;
                    self.f_adl_util_misc_n                := f_adl_util_misc_n;
                    self.f_curraddractivephonelist_d      := f_curraddractivephonelist_d;
                    self.f_divaddrsuspidcountnew_i        := f_divaddrsuspidcountnew_i;
                    self.f_srchphonesrchcountwk_i         := f_srchphonesrchcountwk_i;
                    self.f_accident_recency_d             := f_accident_recency_d;
                    self.f_hh_members_ct_d                := f_hh_members_ct_d;
                    self.f_hh_prof_license_holders_d      := f_hh_prof_license_holders_d;
                    self.f_vardobcount_i                  := f_vardobcount_i;
                    self.k_inq_adls_per_ssn_i             := k_inq_adls_per_ssn_i;
                    self.f_srchphonesrchcountmo_i         := f_srchphonesrchcountmo_i;
                    self.r_l77_add_po_box_i               := r_l77_add_po_box_i;
                    self.k_nap_lname_verd_d               := k_nap_lname_verd_d;
                    self.r_i60_inq_retail_count12_i       := r_i60_inq_retail_count12_i;
                    self.r_a41_prop_owner_inp_only_d      := r_a41_prop_owner_inp_only_d;
                    self.f_addrs_per_ssn_c6_i             := f_addrs_per_ssn_c6_i;
                    self.r_a43_watercraft_cnt_d           := r_a43_watercraft_cnt_d;
                    self._liens_unrel_ot_last_seen        := _liens_unrel_ot_last_seen;
                    self.f_mos_liens_unrel_ot_lseen_d     := f_mos_liens_unrel_ot_lseen_d;
                    self.r_a44_curr_add_naprop_d          := r_a44_curr_add_naprop_d;
                    self.f_inq_quizprovider_count24_i     := f_inq_quizprovider_count24_i;
                    self.f_rel_bankrupt_count_i           := f_rel_bankrupt_count_i;
                    self.r_i60_inq_count12_i              := r_i60_inq_count12_i;
                    self.r_s65_ssn_problem_i              := r_s65_ssn_problem_i;
                    self.f_inputaddractivephonelist_d     := f_inputaddractivephonelist_d;
                    self.r_l71_add_business_i             := r_l71_add_business_i;
                    self.r_i60_inq_recency_d              := r_i60_inq_recency_d;
                    self.r_c14_addrs_15yr_i               := r_c14_addrs_15yr_i;
                    self.f_util_add_input_conv_n          := f_util_add_input_conv_n;
                    self.f_inq_retailpayments_count24_i   := f_inq_retailpayments_count24_i;
                    self.k_inf_addr_verd_d                := k_inf_addr_verd_d;
                    self.r_f04_curr_add_occ_index_d       := r_f04_curr_add_occ_index_d;
                    self.f_bus_lname_verd_d               := f_bus_lname_verd_d;
                    self._liens_unrel_st_last_seen        := _liens_unrel_st_last_seen;
                    self.f_mos_liens_unrel_st_lseen_d     := f_mos_liens_unrel_st_lseen_d;
                    self.r_d32_criminal_count_i           := r_d32_criminal_count_i;
                    self.f_crim_rel_under25miles_cnt_i    := f_crim_rel_under25miles_cnt_i;
                    self.r_i60_inq_auto_recency_d         := r_i60_inq_auto_recency_d;
                    self.f_srchfraudsrchcountwk_i         := f_srchfraudsrchcountwk_i;
                    self.f_inq_mortgage_count24_i         := f_inq_mortgage_count24_i;
                    self.f_util_add_curr_conv_n           := f_util_add_curr_conv_n;
                    self.r_c15_ssns_per_adl_c6_i          := r_c15_ssns_per_adl_c6_i;
                    self.f_bus_phone_match_d              := f_bus_phone_match_d;
                    self.r_l78_no_phone_at_addr_vel_i     := r_l78_no_phone_at_addr_vel_i;
                    self.r_l72_add_vacant_i               := r_l72_add_vacant_i;
                    self.f_srchcountwk_i                  := f_srchcountwk_i;
                    self._felony_last_date                := _felony_last_date;
                    self.r_d32_mos_since_fel_ls_d         := r_d32_mos_since_fel_ls_d;
                    self.r_d31_bk_filing_count_i          := r_d31_bk_filing_count_i;
                    self.r_i60_inq_retpymt_recency_d      := r_i60_inq_retpymt_recency_d;
                    self.f_liens_unrel_ft_total_amt_i     := f_liens_unrel_ft_total_amt_i;
                    self.f_inq_banking_count24_i          := f_inq_banking_count24_i;
                    self.f_acc_damage_amt_total_i         := f_acc_damage_amt_total_i;
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
                    self.final_score                      := final_score;
                    self.base                             := base;
                    self.odds                             := odds;
                    self.point                            := point;
                    self.fp1702_1_0                       := fp1702_1_0;
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
                    self.suspiciousactivity               := suspiciousactivity;
                    self.vulnerablevictim                 := vulnerablevictim;
                    self.friendlyfraud                    := friendlyfraud;
                    self.ver_src_ak                       := ver_src_ak;
                    self.ver_src_am                       := ver_src_am;
                    self.ver_src_ar                       := ver_src_ar;
                    self.ver_src_ba                       := ver_src_ba;
                    self.ver_src_cg                       := ver_src_cg;
                    self.ver_src_co                       := ver_src_co;
                    self.ver_src_cy                       := ver_src_cy;
                    self.ver_src_da                       := ver_src_da;
                    self.ver_src_d                        := ver_src_d;
                    self.ver_src_dl                       := ver_src_dl;
                    self.ver_src_ds                       := ver_src_ds;
                    self.ver_src_de                       := ver_src_de;
                    self.ver_src_eb                       := ver_src_eb;
                    self.ver_src_em                       := ver_src_em;
                    self.ver_src_e1                       := ver_src_e1;
                    self.ver_src_e2                       := ver_src_e2;
                    self.ver_src_e3                       := ver_src_e3;
                    self.ver_src_e4                       := ver_src_e4;
                    self.ver_src_en                       := ver_src_en;
                    self.ver_src_eq                       := ver_src_eq;
                    self.ver_src_fe                       := ver_src_fe;
                    self.ver_src_ff                       := ver_src_ff;
                    self.ver_src_fr                       := ver_src_fr;
                    self.ver_src_l2                       := ver_src_l2;
                    self.ver_src_li                       := ver_src_li;
                    self.ver_src_mw                       := ver_src_mw;
                    self.ver_src_nt                       := ver_src_nt;
                    self.ver_src_p                        := ver_src_p;
                    self.ver_src_pl                       := ver_src_pl;
                    self.ver_src_tn                       := ver_src_tn;
                    self.ver_src_ts                       := ver_src_ts;
                    self.ver_src_tu                       := ver_src_tu;
                    self.ver_src_sl                       := ver_src_sl;
                    self.ver_src_v                        := ver_src_v;
                    self.ver_src_vo                       := ver_src_vo;
                    self.ver_src_w                        := ver_src_w;
                    self.ver_src_wp                       := ver_src_wp;
                    self.src_bureau                       := src_bureau;
                    self.src_behavioral                   := src_behavioral;
                    self.src_inperson                     := src_inperson;
                    self.syntheticid2                     := syntheticid2;
                    self.stolenc_fp1702_1_0               := stolenc_fp1702_1_0;
                    self.manip2c_fp1702_1_0               := manip2c_fp1702_1_0;
                    self.synth2c_fp1702_1_0               := synth2c_fp1702_1_0;
                    self.suspactc_fp1702_1_0              := suspactc_fp1702_1_0;
                    self.vulnvicc_fp1702_1_0              := vulnvicc_fp1702_1_0;
                    self.friendlyc_fp1702_1_0             := friendlyc_fp1702_1_0;
                    self.custstolidindex                  := custstolidindex;
                    self.custmanipidindex                 := custmanipidindex;
                    self.custsynthidindex                 := custsynthidindex;
                    self.custsuspactindex                 := custsuspactindex;
                    self.custvulnvicindex                 := custvulnvicindex;
                    self.custfriendfrdindex               := custfriendfrdindex;

	 SELF.clam := le;
#end

	self.seq := le.seq;
	self.StolenIdentityIndex := (string) custstolidindex;
	self.SyntheticIdentityIndex:= (string) custsynthidindex;
	self.ManipulatedIdentityIndex:= (string) custmanipidindex;
	self.VulnerableVictimIndex := (string) custvulnvicindex;
	self.FriendlyFraudIndex                := (string) custfriendfrdindex;
	self.SuspiciousActivityIndex := (string) custsuspactindex;
	ritmp :=  Models.fraudpoint3_reasons(le, blank_ip, num_reasons, , , nf_seg_fraudpoint_3_0);
	reasons := Models.Common.checkFraudPointRC34(FP1702_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)FP1702_1_0;
	self := [];
END;

model := project( clam, doModel(left) );
	
	return model;
END;

