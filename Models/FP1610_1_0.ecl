import Std, risk_indicators, riskwise, riskwisefcra, ut, easi, Models;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1610_1_0(dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons)
									 := FUNCTION
									
		FP_DEBUG := False;
		
		isFCRA := False;

	#if(FP_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
	Integer seq;
	Integer	sysdate;
	string disposition;
	Integer	k_nap_phn_verd_d;
	Integer	k_nap_fname_verd_d;
	Integer	k_inf_phn_verd_d;
	Integer	k_inf_fname_verd_d;
	Boolean	k_inf_contradictory_i;
	Integer	r_c16_inv_ssn_per_adl_i;
	Integer	r_p88_phn_dst_to_inp_add_i;
	Integer	r_p85_phn_not_issued_i;
	Real	r_p85_phn_disconnected_i;
	Integer	r_phn_cell_n;
	Integer	r_p86_phn_pager_i;
	Integer	r_phn_pcs_n;
	Integer	r_l75_add_drop_delivery_i;
	String	add_ec1;
	String	add_ec3;
	String	add_ec4;
	Real	r_l70_add_standardized_i;
	Real	r_l72_add_curr_vacant_i;
	Real	r_f03_input_add_not_most_rec_i;
	Integer	r_c19_add_prison_hist_i;
	Integer	r_f00_ssn_score_d;
	Real	r_f01_inp_addr_address_score_d;
	Real	r_d30_derog_count_i;
	Real	r_d32_criminal_count_i;
	Real	r_d32_felony_count_i;
	Real	_criminal_last_date;
	Real	r_d32_mos_since_crim_ls_d;
	Real	_felony_last_date;
	Real	r_d32_mos_since_fel_ls_d;
	Real	r_d31_mostrec_bk_i;
	Integer	r_d33_eviction_recency_d;
	Real	r_d34_unrel_liens_ct_i;
	Real	_src_bureau_adl_fseen;
	Real	r_c21_m_bureau_adl_fs_d;
	Real	_src_bureau_adl_fseen_all;
	Real	f_m_bureau_adl_fs_all_d;
	Real	bureau_adl_eq_fseen_pos;
	String	bureau_adl_fseen_eq;
	Real	_bureau_adl_fseen_eq;
	Real	bureau_adl_en_fseen_pos;
	String	bureau_adl_fseen_en;
	Real	_bureau_adl_fseen_en;
	Real	bureau_adl_ts_fseen_pos;
	String	bureau_adl_fseen_ts;
	Real	_bureau_adl_fseen_ts;
	Real	bureau_adl_tu_fseen_pos;
	String	bureau_adl_fseen_tu;
	Real	_bureau_adl_fseen_tu;
	Real	bureau_adl_tn_fseen_pos;
	String	bureau_adl_fseen_tn;
	Real	_bureau_adl_fseen_tn;
	Real	_src_bureau_adl_fseen_notu;
	Real	f_m_bureau_adl_fs_notu_d;
	Real	_header_first_seen;
	Real	r_c10_m_hdr_fs_d;
	Real	r_c12_nonderog_recency_i;
	Real	r_c12_num_nonderogs_d;
	Real	r_c15_ssns_per_adl_i;
	Real	r_s66_adlperssn_count_i;
	Real	_in_dob;
	Real	yr_in_dob;
	Real	yr_in_dob_int;
	Real	k_comb_age_d;
	Real	r_l80_inp_avm_autoval_d;
	Real	r_a46_curr_avm_autoval_d;
	Real	r_a49_curr_avm_chg_1yr_i;
	Real	r_a49_curr_avm_chg_1yr_pct_i;
	Real	r_c13_curr_addr_lres_d;
	Real	r_c14_addr_stability_v2_d;
	Real	r_c13_max_lres_d;
	Real	r_c14_addrs_5yr_i;
	Real	r_c14_addrs_10yr_i;
	Real	r_c14_addrs_15yr_i;
	Real	r_prop_owner_history_d;
	Real	r_c20_email_count_i;
	Real	r_l79_adls_per_addr_curr_i;
	Real	r_l79_adls_per_addr_c6_i;
	Real	r_c18_invalid_addrs_per_adl_i;
	Real	r_a50_pb_average_dollars_d;
	Real	r_a50_pb_total_dollars_d;
	Real	r_a50_pb_total_orders_d;
	Real	r_pb_order_freq_d;
	Real	r_i60_inq_count12_i;
	Real	r_i60_inq_recency_d;
	Real	r_i61_inq_collection_count12_i;
	Real	r_i61_inq_collection_recency_d;
	Real	r_i60_inq_auto_count12_i;
	Real	r_i60_inq_auto_recency_d;
	Real	r_i60_inq_hiriskcred_recency_d;
	Real	r_i60_inq_comm_count12_i;
	Real	r_i60_inq_comm_recency_d;
	Real	f_bus_addr_match_count_d;
	Real	f_adl_util_conv_n;
	Real	f_util_adl_count_n;
	Real	f_util_add_curr_inf_n;
	Real	f_add_input_mobility_index_i;
	Real	f_add_input_nhood_bus_pct_i;
	Real	f_add_input_nhood_mfd_pct_i;
	Real	f_add_input_nhood_sfd_pct_d;
	Real	add_input_nhood_prop_sum;
	Real	f_add_input_nhood_vac_pct_i;
	Real	f_add_curr_mobility_index_i;
	Real	f_add_curr_nhood_bus_pct_i;
	Real	f_add_curr_nhood_mfd_pct_i;
	Real	f_add_curr_nhood_sfd_pct_d;
	Real	add_curr_nhood_prop_sum;
	Real	f_add_curr_nhood_vac_pct_i;
	Real	f_inq_count24_i;
	Real	f_inq_auto_count24_i;
	Real	f_inq_collection_count24_i;
	Real	f_inq_communications_count24_i;
	Real	f_inq_highriskcredit_count24_i;
	Real	f_inq_other_count24_i;
	Real	k_inq_per_ssn_i;
	Real	k_inq_addrs_per_ssn_i;
	Real	k_inq_dobs_per_ssn_i;
	Real	k_inq_per_addr_i;
	Real	k_inq_adls_per_addr_i;
	Real	k_inq_lnames_per_addr_i;
	Real	k_inq_ssns_per_addr_i;
	Real	k_inq_per_phone_i;
	Real	k_inq_adls_per_phone_i;
	Real	f_attr_arrest_recency_d;
	Real	_liens_unrel_cj_first_seen;
	Real	f_mos_liens_unrel_cj_fseen_d;
	Real	_liens_unrel_cj_last_seen;
	Real	f_mos_liens_unrel_cj_lseen_d;
	Real	f_liens_unrel_cj_total_amt_i;
	Real	_liens_rel_cj_first_seen;
	Real	f_mos_liens_rel_cj_fseen_d;
	Real	_liens_rel_cj_last_seen;
	Real	f_mos_liens_rel_cj_lseen_d;
	Real	f_liens_rel_cj_total_amt_i;
	Real	_liens_unrel_o_first_seen;
	Real	f_mos_liens_unrel_o_fseen_d;
	Real	_liens_unrel_o_last_seen;
	Real	f_mos_liens_unrel_o_lseen_d;
	Real	_liens_rel_o_first_seen;
	Real	f_mos_liens_rel_o_fseen_d;
	Real	_liens_rel_o_last_seen;
	Real	f_mos_liens_rel_o_lseen_d;
	Real	_liens_rel_ot_first_seen;
	Real	f_mos_liens_rel_ot_fseen_d;
	Real	_liens_rel_ot_last_seen;
	Real	f_mos_liens_rel_ot_lseen_d;
	Real	f_liens_unrel_sc_total_amt_i;
	Real	k_estimated_income_d;
	Real	r_wealth_index_d;
	Real	f_rel_count_i;
	Real	f_rel_incomeover25_count_d;
	Real	f_rel_incomeover50_count_d;
	Real	f_rel_incomeover75_count_d;
	Real	f_rel_incomeover100_count_d;
	Real	f_rel_homeover50_count_d;
	Real	f_rel_homeover100_count_d;
	Real	f_rel_homeover150_count_d;
	Real	f_rel_homeover200_count_d;
	Real	f_rel_homeover300_count_d;
	Real	f_rel_homeover500_count_d;
	Real	f_rel_ageover20_count_d;
	Real	f_rel_ageover30_count_d;
	Real	f_rel_ageover40_count_d;
	Real	f_rel_ageover50_count_d;
	Real	f_rel_educationover8_count_d;
	Real	f_rel_educationover12_count_d;
	Real	f_crim_rel_under25miles_cnt_i;
	Real	f_crim_rel_under100miles_cnt_i;
	Real	f_rel_under25miles_cnt_d;
	Real	f_rel_under100miles_cnt_d;
	Real	f_rel_under500miles_cnt_d;
	Real	f_rel_bankrupt_count_i;
	Real	f_rel_criminal_count_i;
	Real	f_rel_felony_count_i;
	Real	f_current_count_d;
	Real	f_historical_count_d;
	Real	_acc_last_seen;
	Real	f_mos_acc_lseen_d;
	Real	f_idrisktype_i;
	Real	f_idverrisktype_i;
	Real	f_sourcerisktype_i;
	Real	f_varrisktype_i;
	Real	f_srchvelocityrisktype_i;
	Real	f_srchcountwk_i;
	Real	f_srchunvrfdssncount_i;
	Real	f_srchunvrfdaddrcount_i;
	Real	f_srchunvrfddobcount_i;
	Real	f_srchunvrfdphonecount_i;
	Real	f_srchfraudsrchcountyr_i;
	Real	f_assocrisktype_i;
	Real	f_assocsuspicousidcount_i;
	Real	f_validationrisktype_i;
	Real	f_corrrisktype_i;
	Real	f_corrssnnamecount_d;
	Real	f_corrssnaddrcount_d;
	Real	f_corraddrphonecount_d;
	Real	f_corrphonelastnamecount_d;
	Real	f_divrisktype_i;
	Real	f_divssnidmsrcurelcount_i;
	Real	f_divaddrsuspidcountnew_i;
	Real	f_srchcomponentrisktype_i;
	Real	f_srchssnsrchcountmo_i;
	Real	f_srchaddrsrchcountmo_i;
	Real	f_srchaddrsrchcountwk_i;
	Real	f_srchphonesrchcountmo_i;
	Real	f_srchphonesrchcountwk_i;
	Real	f_addrchangeincomediff_d;
	Real	f_addrchangevaluediff_d;
	Real	f_addrchangecrimediff_i;
	Real	f_addrchangeecontrajindex_d;
	Real	f_curraddractivephonelist_d;
	Real	f_curraddrmedianincome_d;
	Real	f_curraddrmedianvalue_d;
	Real	f_curraddrmurderindex_i;
	Real	f_curraddrcartheftindex_i;
	Real	f_curraddrburglaryindex_i;
	Real	f_curraddrcrimeindex_i;
	Real	f_prevaddrageoldest_d;
	Real	f_prevaddrlenofres_d;
	Real	f_prevaddroccupantowned_i;
	Real	f_prevaddrmedianincome_d;
	Real	f_prevaddrmedianvalue_d;
	Real	f_prevaddrmurderindex_i;
	Real	f_prevaddrcartheftindex_i;
	Real	f_fp_prevaddrburglaryindex_i;
	Real	f_fp_prevaddrcrimeindex_i;
	Real	r_c12_source_profile_d;
	Real	r_f01_inp_addr_not_verified_i;
	Real	r_c23_inp_addr_occ_index_d;
	Real	r_i60_inq_prepaidcards_recency_d;
	Real	f_phone_ver_insurance_d;
	Real	f_phone_ver_experian_d;
	Real	f_addrs_per_ssn_i;
	Real	f_phones_per_addr_curr_i;
	Real	f_addrs_per_ssn_c6_i;
	Real	f_phones_per_addr_c6_i;
	Real	f_inq_communications_cnt_week_i;
	Real	f_inq_prepaidcards_count24_i;
	Real	_liens_unrel_st_first_seen;
	Real	f_mos_liens_unrel_st_fseen_d;
	Real	f_liens_unrel_st_total_amt_i;
	Real	f_hh_members_ct_d;
	Real	f_hh_age_65_plus_d;
	Real	f_hh_age_18_plus_d;
	Real	f_hh_collections_ct_i;
	Real	f_hh_payday_loan_users_i;
	Real	f_hh_members_w_derog_i;
	Real	f_hh_tot_derog_i;
	Real	f_hh_lienholders_i;
	Boolean	_ver_src_ds;
	Boolean	_ver_src_de;
	Boolean	 _ver_src_eq;
	Boolean	_ver_src_en;
	Boolean	_ver_src_tn;
	Boolean	_ver_src_tu;
	Real	_credit_source_cnt;
	Real	_ver_src_cnt;
	Boolean	_bureauonly;
	Boolean	_derog;
	Boolean	_deceased;
	Boolean	_ssnpriortodob;
	Boolean	_inputmiskeys;
	Boolean	_multiplessns;
	Real	_hh_strikes;
	String	nf_seg_fraudpoint_3_0;
	Integer	r_nas_ssn_verd_d;
	Real	r_l70_add_invalid_i;
	Real	r_d31_attr_bankruptcy_recency_d;
	Real	r_d34_unrel_lien60_count_i;
	Real	r_a41_prop_owner_d;
	Real	r_l78_no_phone_at_addr_vel_i;
	Real	r_i60_inq_retail_recency_d;
	Real	f_bus_fname_verd_d;
	Real	f_adl_util_misc_n;
	Real	f_add_curr_has_vac_ct_i;
	Real	_liens_unrel_ft_first_seen;
	Real	f_mos_liens_unrel_ft_fseen_d;
	Real	f_acc_damage_amt_total_i;
	Real	f_vardobcount_i;
	Real	f_srchcountday_i;
	Real	f_srchfraudsrchcountwk_i;
	Real	f_assoccredbureaucount_i;
	Real	f_srchssnsrchcountday_i;
	Real	f_inputaddractivephonelist_d;
	Real	f_prevaddrdwelltype_sfd_n;
	Real	f_prevaddrstatus_i;
	Real	r_c12_source_profile_index_d;
	Real	f_dl_addrs_per_adl_i;
	Real	f_inq_auto_count_week_i;
	Real	f_liens_rel_sc_total_amt_i;
	Real	f_hh_college_attendees_d;
	String r_d31_bk_chapter_n;
	Real	final_score_0;
	Real	final_score_1;
	Real	final_score_2;
	Real	final_score_3;
	Real	final_score_4;
	Real	final_score_5;
	Real	final_score_6;
	Real	final_score_7;
	Real	final_score_8;
	Real	final_score_9;
	Real	final_score_10;
	Real	final_score_11;
	Real	final_score_12;
	Real	final_score_13;
	Real	final_score_14;
	Real	final_score_15;
	Real	final_score_16;
	Real	final_score_17;
	Real	final_score_18;
	Real	final_score_19;
	Real	final_score_20;
	Real	final_score_21;
	Real	final_score_22;
	Real	final_score_23;
	Real	final_score_24;
	Real	final_score_25;
	Real	final_score_26;
	Real	final_score_27;
	Real	final_score_28;
	Real	final_score_29;
	Real	final_score_30;
	Real	final_score_31;
	Real	final_score_32;
	Real	final_score_33;
	Real	final_score_34;
	Real	final_score_35;
	Real	final_score_36;
	Real	final_score_37;
	Real	final_score_38;
	Real	final_score_39;
	Real	final_score_40;
	Real	final_score_41;
	Real	final_score_42;
	Real	final_score_43;
	Real	final_score_44;
	Real	final_score_45;
	Real	final_score_46;
	Real	final_score_47;
	Real	final_score_48;
	Real	final_score_49;
	Real	final_score_50;
	Real	final_score_51;
	Real	final_score_52;
	Real	final_score_53;
	Real	final_score_54;
	Real	final_score_55;
	Real	final_score_56;
	Real	final_score_57;
	Real	final_score_58;
	Real	final_score_59;
	Real	final_score_60;
	Real	final_score_61;
	Real	final_score_62;
	Real	final_score_63;
	Real	final_score_64;
	Real	final_score_65;
	Real	final_score_66;
	Real	final_score_67;
	Real	final_score_68;
	Real	final_score_69;
	Real	final_score_70;
	Real	final_score_71;
	Real	final_score_72;
	Real	final_score_73;
	Real	final_score_74;
	Real	final_score_75;
	Real	final_score_76;
	Real	final_score_77;
	Real	final_score_78;
	Real	final_score_79;
	Real	final_score_80;
	Real	final_score_81;
	Real	final_score_82;
	Real	final_score_83;
	Real	final_score_84;
	Real	final_score_85;
	Real	final_score_86;
	Real	final_score_87;
	Real	final_score_88;
	Real	final_score_89;
	Real	final_score_90;
	Real	final_score_91;
	Real	final_score_92;
	Real	final_score_93;
	Real	final_score_94;
	Real	final_score_95;
	Real	final_score_96;
	Real	final_score_97;
	Real	final_score_98;
	Real	final_score_99;
	Real	final_score_100;
	Real	final_score_101;
	Real	final_score_102;
	Real	final_score_103;
	Real	final_score_104;
	Real	final_score_105;
	Real	final_score_106;
	Real	final_score_107;
	Real	final_score_108;
	Real	final_score_109;
	Real	final_score_110;
	Real	final_score_111;
	Real	final_score_112;
	Real	final_score_113;
	Real	final_score_114;
	Real	final_score_115;
	Real	final_score_116;
	Real	final_score_117;
	Real	final_score_118;
	Real	final_score_119;
	Real	final_score_120;
	Real	final_score_121;
	Real	final_score_122;
	Real	final_score_123;
	Real	final_score_124;
	Real	final_score_125;
	Real	final_score_126;
	Real	final_score_127;
	Real	final_score_128;
	Real	final_score_129;
	Real	final_score_130;
	Real	final_score_131;
	Real	final_score_132;
	Real	final_score_133;
	Real	final_score_134;
	Real	final_score_135;
	Real	final_score_136;
	Real	final_score_137;
	Real	final_score_138;
	Real	final_score_139;
	Real	final_score_140;
	Real	final_score_141;
	Real	final_score_142;
	Real	final_score_143;
	Real	final_score_144;
	Real	final_score_145;
	Real	final_score_146;
	Real	final_score_147;
	Real	final_score_148;
	Real	final_score_149;
	Real	final_score_150;
	Real	final_score_151;
	Real	final_score_152;
	Real	final_score_153;
	Real	final_score_154;
	Real	final_score_155;
	Real	final_score_156;
	Real	final_score_157;
	Real	final_score_158;
	Real	final_score_159;
	Real	final_score_160;
	Real	final_score_161;
	Real	final_score_162;
	Real	final_score_163;
	Real	final_score_164;
	Real	final_score_165;
	Real	final_score_166;
	Real	final_score_167;
	Real	final_score_168;
	Real	final_score_169;
	Real	final_score_170;
	Real	final_score_171;
	Real	final_score_172;
	Real	final_score_173;
	Real	final_score_174;
	Real	final_score_175;
	Real	final_score_176;
	Real	final_score_177;
	Real	final_score_178;
	Real	final_score_179;
	Real	final_score_180;
	Real	final_score_181;
	Real	final_score_182;
	Real	final_score_183;
	Real	final_score_184;
	Real	final_score_185;
	Real	final_score_186;
	Real	final_score_187;
	Real	final_score_188;
	Real	final_score_189;
	Real	final_score_190;
	Real	final_score_191;
	Real	final_score_192;
	Real	final_score_193;
	Real	final_score_194;
	Real	final_score_195;
	Real	final_score_196;
	Real	final_score_197;
	Real	final_score_198;
	Real	final_score_199;
	Real	final_score_200;
	Real	final_score_201;
	Real	final_score_202;
	Real	final_score_203;
	Real	final_score_204;
	Real	final_score_205;
	Real	final_score_206;
	Real	final_score_207;
	Real	final_score_208;
	Real	final_score_209;
	Real	final_score_210;
	Real	final_score_211;
	Real	final_score_212;
	Real	final_score_213;
	Real	final_score_214;
	Real	final_score_215;
	Real	final_score_216;
	Real	final_score_217;
	Real	final_score_218;
	Real	final_score_219;
	Real	final_score_220;
	Real	final_score_221;
	Real	final_score_222;
	Real	final_score_223;
	Real	final_score_224;
	Real	final_score_225;
	Real	final_score_226;
	Real	final_score_227;
	Real	final_score_228;
	Real	final_score_229;
	Real	final_score_230;
	Real	final_score_231;
	Real	final_score_232;
	Real	final_score_233;
	Real	final_score_234;
	Real	final_score_235;
	Real	final_score_236;
	Real	final_score_237;
	Real	final_score_238;
	Real	final_score_239;
	Real	final_score_240;
	Real	final_score_241;
	Real	final_score_242;
	Real	final_score_243;
	Real	final_score_244;
	Real	final_score_245;
	Real	final_score_246;
	Real	final_score_247;
	Real	final_score_248;
	Real	final_score_249;
	Real	final_score_250;
	Real	final_score_251;
	Real	final_score_252;
	Real	final_score_253;
	Real	final_score_254;
	Real	final_score_255;
	Real	final_score_256;
	Real	final_score_257;
	Real	final_score_258;
	Real	final_score_259;
	Real	final_score_260;
	Real	final_score_261;
	Real	final_score_262;
	Real	final_score_263;
	Real	final_score_264;
	Real	final_score_265;
	Real	final_score_266;
	Real	final_score_267;
	Real	final_score_268;
	Real	final_score_269;
	Real	final_score_270;
	Real	final_score_271;
	Real	final_score_272;
	Real	final_score_273;
	Real	final_score_274;
	Real	final_score_275;
	Real	final_score_276;
	Real	final_score_277;
	Real	final_score_278;
	Real	final_score_279;
	Real	final_score;
	Integer	base;
	Integer	pts;
	Real	lgt;
	Integer	fp1610_1_0;
	Integer stolenid;
  Integer manipulatedid;
  Integer manipulatedidpt2;
  Integer syntheticid;
  Integer suspiciousactivity;
  Integer vulnerablevictim;
  Integer friendlyfraud;
  Integer stolenc_fp1610_1_0;
  Integer manip2c_fp1610_1_0;
  Integer synthc_fp1610_1_0;
  Integer suspactc_fp1610_1_0;
  Integer vulnvicc_fp1610_1_0;
  Integer friendlyc_fp1610_1_0;
  Integer custstolidindex;
  Integer custmanipidindex;
  Integer custsynthidindex;
  Integer custsuspactindex;
  Integer custvulnvicindex;
  Integer custfriendfrdindex;
	STRING	StolenIdentityIndex;
  STRING	SyntheticIdentityIndex;
  STRING	ManipulatedIdentityIndex;
  STRING	VulnerableVictimIndex;
  STRING	FriendlyFraudIndex;
  STRING	SuspiciousActivityIndex;
	

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
  truedid                          := le.truedid;
	out_addr_status                  := le.shell_input.addr_status;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_type                         := le.iid.nap_type;
	nap_status                       := le.iid.nap_status;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_pwphonezipflag                := le.iid.pwphonezipflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
	rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
	rc_disthphoneaddr                := le.iid.disthphoneaddr;
	combo_ssnscore                   := le.iid.combo_ssnscore;
	hdr_source_profile               := le.source_profile;
	hdr_source_profile_index         := le.source_profile_index;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	bus_addr_match_count             := le.business_header_address_summary.bus_addr_match_cnt;
	bus_name_match                   := le.business_header_address_summary.bus_name_match;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	hphnpop                          := le.input_validation.homephone;
	util_adl_type_list               := le.utility.utili_adl_type;
	util_adl_count                   := le.utility.utili_adl_count;
	util_add_curr_type_list          := le.utility.utili_addr2_type;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
	add_input_addr_not_verified      := le.address_verification.inputAddr_not_verified;
	add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
	add_input_advo_drop              := le.advo_input_addr.Drop_Indicator;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_occupants_1yr          := le.addr_risk_summary.occupants_1yr;
	add_input_turnover_1yr_in        := le.addr_risk_summary.turnover_1yr_in;
	add_input_turnover_1yr_out       := le.addr_risk_summary.turnover_1yr_out;
	add_input_nhood_vac_prop         := le.addr_risk_summary.N_Vacant_Properties;
	add_input_nhood_bus_ct           := le.addr_risk_summary.N_Business_Count;
	add_input_nhood_sfd_ct           := le.addr_risk_summary.N_SFD_Count;
	add_input_nhood_mfd_ct           := le.addr_risk_summary.N_MFD_Count;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_lres                    := le.lres2;
	add_curr_advo_vacancy            := le.advo_addr_hist1.Address_Vacancy_Indicator;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_avm_auto_val_2          := le.avm.address_history_1.avm_automated_valuation2;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_occupants_1yr           := le.addr_risk_summary2.occupants_1yr;
	add_curr_turnover_1yr_in         := le.addr_risk_summary2.turnover_1yr_in;
	add_curr_turnover_1yr_out        := le.addr_risk_summary2.turnover_1yr_out;
	add_curr_nhood_vac_prop          := le.addr_risk_summary2.N_Vacant_Properties;
	add_curr_nhood_bus_ct            := le.addr_risk_summary2.N_Business_Count;
	add_curr_nhood_sfd_ct            := le.addr_risk_summary2.N_SFD_Count;
	add_curr_nhood_mfd_ct            := le.addr_risk_summary2.N_MFD_Count;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	max_lres                         := le.other_address_info.max_lres;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	addrs_prison_history             := le.other_address_info.isprison;
	telcordia_type                   := le.phone_verification.telcordia_type;
	phone_ver_insurance              := le.insurance_phones_summary.Insurance_Phone_Verification;
	phone_ver_experian               := le.Experian_Phone_Verification;
	header_first_seen                := le.ssn_verification.header_first_seen;
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
	invalid_addrs_per_adl            := le.velocity_counters.invalid_addrs_per_adl;
	inq_count                        := le.acc_logs.inquiries.counttotal;
	inq_count01                      := le.acc_logs.inquiries.count01;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count06                      := le.acc_logs.inquiries.count06;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_count24                      := le.acc_logs.inquiries.count24;
	inq_auto_count                   := le.acc_logs.auto.counttotal;
	inq_auto_count_week              := if(isFCRA, 0, le.acc_logs.auto.countweek);
	inq_auto_count01                 := le.acc_logs.auto.count01;
	inq_auto_count03                 := le.acc_logs.auto.count03;
	inq_auto_count06                 := le.acc_logs.auto.count06;
	inq_auto_count12                 := le.acc_logs.auto.count12;
	inq_auto_count24                 := le.acc_logs.auto.count24;
	inq_collection_count             := le.acc_logs.collection.counttotal;
	inq_collection_count01           := le.acc_logs.collection.count01;
	inq_collection_count03           := le.acc_logs.collection.count03;
	inq_collection_count06           := le.acc_logs.collection.count06;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_collection_count24           := le.acc_logs.collection.count24;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_communications_count_week    := if(isFCRA, 0, le.acc_logs.communications.countweek);
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
	inq_other_count24                := le.acc_logs.other.count24;
	inq_prepaidcards_count           := le.acc_logs.prepaidcards.counttotal;
	inq_prepaidcards_count01         := le.acc_logs.prepaidcards.count01;
	inq_prepaidcards_count03         := le.acc_logs.prepaidcards.count03;
	inq_prepaidcards_count06         := le.acc_logs.prepaidcards.count06;
	inq_prepaidcards_count12         := le.acc_logs.prepaidcards.count12;
	inq_prepaidcards_count24         := le.acc_logs.prepaidcards.count24;
	inq_retail_count                 := le.acc_logs.retail.counttotal;
	inq_retail_count01               := le.acc_logs.retail.count01;
	inq_retail_count03               := le.acc_logs.retail.count03;
	inq_retail_count06               := le.acc_logs.retail.count06;
	inq_retail_count12               := le.acc_logs.retail.count12;
	inq_retail_count24               := le.acc_logs.retail.count24;
	inq_perssn                       := if(isFCRA, 0, le.acc_logs.inquiryPerSSN );
	inq_addrsperssn                  := if(isFCRA, 0, le.acc_logs.inquiryAddrsPerSSN );
	inq_dobsperssn                   := if(isFCRA, 0, le.acc_logs.inquiryDOBsPerSSN );
	inq_peraddr                      := if(isFCRA, 0, le.acc_logs.inquiryPerAddr );
	inq_adlsperaddr                  := if(isFCRA, 0, le.acc_logs.inquiryADLsPerAddr );
	inq_lnamesperaddr                := if(isFCRA, 0, le.acc_logs.inquiryLNamesPerAddr );
	inq_ssnsperaddr                  := if(isFCRA, 0, le.acc_logs.inquirySSNsPerAddr );
	inq_perphone                     := if(isFCRA, 0, le.acc_logs.inquiryPerPhone );
	inq_adlsperphone                 := if(isFCRA, 0, le.acc_logs.inquiryADLsPerPhone );
	pb_number_of_sources             := le.ibehavior.number_of_sources;
	pb_average_days_bt_orders        := le.ibehavior.average_days_between_orders;
	pb_average_dollars               := le.ibehavior.average_amount_per_order;
	pb_total_dollars                 := le.ibehavior.total_dollars;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count                    := le.impulse.count;
	email_count                      := le.email_summary.email_ct;
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
	attr_num_nonderogs90             := le.source_verification.num_nonderogs90;
	attr_num_nonderogs180            := le.source_verification.num_nonderogs180;
	attr_num_nonderogs12             := le.source_verification.num_nonderogs12;
	attr_num_nonderogs24             := le.source_verification.num_nonderogs24;
	attr_num_nonderogs36             := le.source_verification.num_nonderogs36;
	attr_num_nonderogs60             := le.source_verification.num_nonderogs60;
	fp_idrisktype                    := le.fdattributesv2.identityrisklevel;
	fp_idverrisktype                 := le.fdattributesv2.idverrisklevel;
	fp_sourcerisktype                := le.fdattributesv2.sourcerisklevel;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_vardobcount                   := le.fdattributesv2.variationdobcount;
	fp_srchvelocityrisktype          := le.fdattributesv2.searchvelocityrisklevel;
	fp_srchcountwk                   := le.fdattributesv2.searchcountweek;
	fp_srchcountday                  := le.fdattributesv2.searchcountday;
	fp_srchunvrfdssncount            := le.fdattributesv2.searchunverifiedssncountyear;
	fp_srchunvrfdaddrcount           := le.fdattributesv2.searchunverifiedaddrcountyear;
	fp_srchunvrfddobcount            := le.fdattributesv2.searchunverifieddobcountyear;
	fp_srchunvrfdphonecount          := le.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcountyr          := le.fdattributesv2.searchfraudsearchcountyear;
	fp_srchfraudsrchcountwk          := le.fdattributesv2.searchfraudsearchcountweek;
	fp_assocrisktype                 := le.fdattributesv2.assocrisklevel;
	fp_assocsuspicousidcount         := le.fdattributesv2.assocsuspicousidentitiescount;
	fp_assoccredbureaucount          := le.fdattributesv2.assoccreditbureauonlycount;
	fp_validationrisktype            := le.fdattributesv2.validationrisklevel;
	fp_corrrisktype                  := le.fdattributesv2.correlationrisklevel;
	fp_corrssnnamecount              := le.fdattributesv2.correlationssnnamecount;
	fp_corrssnaddrcount              := le.fdattributesv2.correlationssnaddrcount;
	fp_corraddrphonecount            := le.fdattributesv2.correlationaddrphonecount;
	fp_corrphonelastnamecount        := le.fdattributesv2.correlationphonelastnamecount;
	fp_divrisktype                   := le.fdattributesv2.divrisklevel;
	fp_divssnidmsrcurelcount         := le.fdattributesv2.divssnidentitymsourceurelcount;
	fp_divaddrsuspidcountnew         := le.fdattributesv2.divaddrsuspidentitycountnew;
	fp_srchcomponentrisktype         := le.fdattributesv2.searchcomponentrisklevel;
	fp_srchssnsrchcountmo            := le.fdattributesv2.searchssnsearchcountmonth;
	fp_srchssnsrchcountday           := le.fdattributesv2.searchssnsearchcountday;
	fp_srchaddrsrchcountmo           := le.fdattributesv2.searchaddrsearchcountmonth;
	fp_srchaddrsrchcountwk           := le.fdattributesv2.searchaddrsearchcountweek;
	fp_srchphonesrchcountmo          := le.fdattributesv2.searchphonesearchcountmonth;
	fp_srchphonesrchcountwk          := le.fdattributesv2.searchphonesearchcountweek;
	fp_inputaddractivephonelist      := le.fdattributesv2.inputaddractivephonelist;
	fp_addrchangeincomediff          := le.fdattributesv2.addrchangeincomediff;
	fp_addrchangevaluediff           := le.fdattributesv2.addrchangevaluediff;
	fp_addrchangecrimediff           := le.fdattributesv2.addrchangecrimediff;
	fp_addrchangeecontrajindex       := le.fdattributesv2.addrchangeecontrajectoryindex;
	fp_curraddractivephonelist       := le.fdattributesv2.curraddractivephonelist;
	fp_curraddrmedianincome          := le.fdattributesv2.curraddrmedianincome;
	fp_curraddrmedianvalue           := le.fdattributesv2.curraddrmedianvalue;
	fp_curraddrmurderindex           := le.fdattributesv2.curraddrmurderindex;
	fp_curraddrcartheftindex         := le.fdattributesv2.curraddrcartheftindex;
	fp_curraddrburglaryindex         := le.fdattributesv2.curraddrburglaryindex;
	fp_curraddrcrimeindex            := le.fdattributesv2.curraddrcrimeindex;
	fp_prevaddrageoldest             := le.fdattributesv2.prevaddrageoldest;
	fp_prevaddrlenofres              := le.fdattributesv2.prevaddrlenofres;
	fp_prevaddrdwelltype             := le.fdattributesv2.prevaddrdwelltype;
	fp_prevaddrstatus                := le.fdattributesv2.prevaddrstatus;
	fp_prevaddroccupantowned         := le.fdattributesv2.prevaddroccupantowned;
	fp_prevaddrmedianincome          := le.fdattributesv2.prevaddrmedianincome;
	fp_prevaddrmedianvalue           := le.fdattributesv2.prevaddrmedianvalue;
	fp_prevaddrmurderindex           := le.fdattributesv2.prevaddrmurderindex;
	fp_prevaddrcartheftindex         := le.fdattributesv2.prevaddrcartheftindex;
	fp_prevaddrburglaryindex         := le.fdattributesv2.prevaddrburglaryindex;
	fp_prevaddrcrimeindex            := le.fdattributesv2.prevaddrcrimeindex;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_chapter                       := le.bjl.bk_chapter;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_unrel_cj_first_seen        := le.liens.liens_unreleased_civil_judgment.earliest_filing_date;
	liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	liens_unrel_cj_total_amount      := le.liens.liens_unreleased_civil_judgment.total_amount;
	liens_rel_cj_first_seen          := le.liens.liens_released_civil_judgment.earliest_filing_date;
	liens_rel_cj_last_seen           := le.liens.liens_released_civil_judgment.most_recent_filing_date;
	liens_rel_cj_total_amount        := le.liens.liens_released_civil_judgment.total_amount;
	liens_unrel_ft_first_seen        := le.liens.liens_unreleased_federal_tax.earliest_filing_date;
	liens_unrel_o_first_seen         := le.liens.liens_unreleased_other_lj.earliest_filing_date;
	liens_unrel_o_last_seen          := le.liens.liens_unreleased_other_lj.most_recent_filing_date;
	liens_rel_o_first_seen           := le.liens.liens_released_other_lj.earliest_filing_date;
	liens_rel_o_last_seen            := le.liens.liens_released_other_lj.most_recent_filing_date;
	liens_rel_ot_first_seen          := le.liens.liens_released_other_tax.earliest_filing_date;
	liens_rel_ot_last_seen           := le.liens.liens_released_other_tax.most_recent_filing_date;
	liens_unrel_sc_total_amount      := le.liens.liens_unreleased_small_claims.total_amount;
	liens_rel_sc_total_amount        := le.liens.liens_released_small_claims.total_amount;
	liens_unrel_st_first_seen        := le.liens.liens_unreleased_suits.earliest_filing_date;
	liens_unrel_st_total_amount      := le.liens.liens_unreleased_suits.total_amount;
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
	hh_college_attendees             := le.hhid_summary.hh_college_attendees;
	rel_count                        := le.relatives.relative_count;
	rel_bankrupt_count               := le.relatives.relative_bankrupt_count;
	rel_criminal_count               := le.relatives.relative_criminal_count;
	rel_felony_count                 := le.relatives.relative_felony_count;
	crim_rel_within25miles           := le.relatives.criminal_relative_within25miles;
	crim_rel_within100miles          := le.relatives.criminal_relative_within100miles;
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
	rel_educationunder12_count       := le.relatives.relative_educationunder12_count;
	rel_educationover12_count        := le.relatives.relative_educationover12_count;
	rel_ageunder30_count             := le.relatives.relative_ageunder30_count;
	rel_ageunder40_count             := le.relatives.relative_ageunder40_count;
	rel_ageunder50_count             := le.relatives.relative_ageunder50_count;
	rel_ageunder60_count             := le.relatives.relative_ageunder60_count;
	rel_ageunder70_count             := le.relatives.relative_ageunder70_count;
	rel_ageover70_count              := le.relatives.relative_ageover70_count;
	current_count                    := le.vehicles.current_count;
	historical_count                 := le.vehicles.historical_count;
	acc_damage_amt_total             := le.accident_data.acc.dmgamtaccidents;
	acc_last_seen                    := le.accident_data.acc.datelastaccident;
	wealth_index                     := le.wealth_indicator;
	inferred_age                     := le.inferred_age;
	addr_stability_v2                := le.addr_stability;
	estimated_income                 := le.estimated_income;


	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */


NULL := -999999999;

INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

sysdate := __common__( common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01')));


k_nap_phn_verd_d := __common__( (Integer)(nap_summary in [4, 6, 7, 9, 10, 11, 12]));

k_nap_fname_verd_d := __common__( (Integer)(nap_summary in [2, 3, 4, 8, 9, 10, 12]));

k_inf_phn_verd_d := __common__( (Integer)(infutor_nap in [4, 6, 7, 9, 10, 11, 12]));

k_inf_fname_verd_d := __common__( (Integer)(infutor_nap in [2, 3, 4, 8, 9, 10, 12]));

k_inf_contradictory_i := __common__( (infutor_nap in [1]));

r_c16_inv_ssn_per_adl_i := __common__( if(not(truedid), NULL, min(if(invalid_ssns_per_adl = NULL, -NULL, invalid_ssns_per_adl), 999)));

r_p88_phn_dst_to_inp_add_i := __common__( if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr));

r_p85_phn_not_issued_i := __common__( map(
    not(hphnpop)                 => NULL,
    (rc_pwphonezipflag in ['4']) => 1,
                                    0));

r_p85_phn_disconnected_i := __common__( map(
    not(hphnpop)                                                             => NULL,
    rc_hriskphoneflag = '5' or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D' => 1,
                                                                                0));

r_phn_cell_n_1 := __common__( if(not(hphnpop), NULL, NULL));

r_phn_cell_n := __common__( if(rc_hriskphoneflag = '1' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '1' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '04' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '55' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '60', 1, 0));

r_p86_phn_pager_i := __common__( map(
    not(hphnpop)                                                                                                                                                                                                                                            => NULL,
    rc_hriskphoneflag = '2' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '2' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '02' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '56' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '61' => 1,
                                                                                                                                                                                                                                                               0));

r_phn_pcs_n := __common__( map(
    not(hphnpop)                                                                                                                                                                                                                                                                                                                                                            => NULL,
    rc_hriskphoneflag = '3' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '3' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '64' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '65' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '66' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '67' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '68' => 1,
                                                                                                                                                                                                                                                                                                                                                                               0));

r_l75_add_drop_delivery_i := __common__( map(
    not(add_input_pop)                                       => NULL,
    trim(trim(add_input_advo_drop, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                0));

add_ec1 := __common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1]);

add_ec3 := __common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3]);

add_ec4 := __common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4]);

r_l70_add_standardized_i := __common__( map(
    not(addrpop)                                         => NULL,
    trim(trim(add_ec1, LEFT), LEFT, RIGHT) = 'E'         => 2,
    add_ec1 = 'S' and (add_ec3 != '0' or add_ec4 != '0') => 1,
                                                            0));

r_l72_add_curr_vacant_i := __common__( map(
    not(add_curr_pop)                                          => NULL,
    trim(trim(add_curr_advo_vacancy, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                  0));

r_f03_input_add_not_most_rec_i := __common__( if(not(truedid and add_input_pop), NULL, (integer)rc_input_addr_not_most_recent));

r_c19_add_prison_hist_i := __common__( if(not(truedid), NULL, (Integer)addrs_prison_history));

r_f00_ssn_score_d := __common__( if(not(truedid and (integer)ssnlength > 0) or combo_ssnscore = 255, NULL, min(if(combo_ssnscore = NULL, -NULL, combo_ssnscore), 999)));

r_f01_inp_addr_address_score_d := __common__( if(not(truedid and add_input_pop) or add_input_address_score = 255, NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999)));

r_d30_derog_count_i := __common__( if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999)));

r_d32_criminal_count_i := __common__( if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999)));

r_d32_felony_count_i := __common__( if(not(truedid), NULL, min(if(felony_count = NULL, -NULL, felony_count), 999)));

_criminal_last_date := __common__( common.sas_date((string)(criminal_last_date)));

r_d32_mos_since_crim_ls_d := __common__( map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => 241,
                                  max(3, min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240))));

_felony_last_date := __common__( common.sas_date((string)(felony_last_date)));

r_d32_mos_since_fel_ls_d := __common__( map(
    not(truedid)             => NULL,
    _felony_last_date = NULL => 241,
                                max(3, min(if(if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12)))), 240))));

r_d31_mostrec_bk_i := __common__( map(
    not(truedid)                                    => NULL,
    contains_i(Stringlib.stringtouppercase(disposition), 'DISMISS') = 1  => 1,
    contains_i(Stringlib.stringtouppercase(disposition), 'DISCHARG') = 1 => 2,
    (integer)bankrupt = 1 or (integer)filing_count > 0                => 3,
                                                       0));

r_d33_eviction_recency_d := __common__( map(
    not(truedid)             => NULL,
    (Boolean)attr_eviction_count90    => 3,
    (Boolean)attr_eviction_count180   => 6,
    (Boolean)attr_eviction_count12    => 12,
    (Boolean)attr_eviction_count24    => 24,
    (Boolean)attr_eviction_count36    => 36,
    (Boolean)attr_eviction_count60    => 60,
    (Integer)attr_eviction_count >= 1 => 99,
                                999));

r_d34_unrel_liens_ct_i := __common__( if(not(truedid), NULL, min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 999)));

bureau_adl_eq_fseen_pos_2 := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

bureau_adl_fseen_eq_2 := __common__( if(bureau_adl_eq_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_2, ',')));

_bureau_adl_fseen_eq_2 := __common__( common.sas_date((string)(bureau_adl_fseen_eq_2)));

_src_bureau_adl_fseen := __common__( min(if(_bureau_adl_fseen_eq_2 = NULL, -NULL, _bureau_adl_fseen_eq_2), 999999));

r_c21_m_bureau_adl_fs_d := __common__( map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => 1000,
                                      min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999)));

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

_src_bureau_adl_fseen_all := __common__( min(if(_bureau_adl_fseen_tn_1 = NULL, -NULL, _bureau_adl_fseen_tn_1), if(_bureau_adl_fseen_ts_1 = NULL, -NULL, _bureau_adl_fseen_ts_1), if(_bureau_adl_fseen_tu_1 = NULL, -NULL, _bureau_adl_fseen_tu_1), if(_bureau_adl_fseen_en_1 = NULL, -NULL, _bureau_adl_fseen_en_1), if(_bureau_adl_fseen_eq_1 = NULL, -NULL, _bureau_adl_fseen_eq_1), 999999));

f_m_bureau_adl_fs_all_d := __common__( map(
    not(truedid)                       => NULL,
    _src_bureau_adl_fseen_all = 999999 => 1000,
                                          min(if(if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)))), 999)));

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

_src_bureau_adl_fseen_notu := __common__( min(if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999));

f_m_bureau_adl_fs_notu_d := __common__( map(
    not(truedid)                        => NULL,
    _src_bureau_adl_fseen_notu = 999999 => 1000,
                                           min(if(if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)))), 999)));

_header_first_seen := __common__( common.sas_date((string)(header_first_seen)));

r_c10_m_hdr_fs_d := __common__( map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => 1000,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999)));

r_c12_nonderog_recency_i := __common__( map(
    not(truedid)            => NULL,
    (Boolean)attr_num_nonderogs90    => 3,
    (Boolean)attr_num_nonderogs180   => 6,
    (Boolean)attr_num_nonderogs12    => 12,
    (Boolean)attr_num_nonderogs24    => 24,
    (Boolean)attr_num_nonderogs36    => 36,
    (Boolean)attr_num_nonderogs60    => 60,
    (Integer)attr_num_nonderogs >= 1 => 99,
                               999));

r_c12_num_nonderogs_d := __common__( if(not(truedid), NULL, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 999)));

r_c15_ssns_per_adl_i := __common__( map(
    not(truedid)             => NULL,
    ssns_per_adl = 0         => 2,
    (ssns_per_adl in [1, 2]) => 1,
                                min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 999)));

r_s66_adlperssn_count_i := __common__( map(
    not((Integer)ssnlength > 0) => NULL,
    adls_per_ssn = 0   => 1,
                          min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999)));

_in_dob := __common__( common.sas_date((string)(in_dob)));

yr_in_dob := __common__( if(_in_dob = NULL, NULL, (sysdate - _in_dob) / 365.25));

yr_in_dob_int := __common__( if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob)));

k_comb_age_d := __common__( map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                                    NULL));

r_l80_inp_avm_autoval_d := __common__( map(
    not(add_input_pop)         => NULL,
    add_input_avm_auto_val = 0 => NULL,
                                  min(if(add_input_avm_auto_val = NULL, -NULL, add_input_avm_auto_val), 300000)));

r_a46_curr_avm_autoval_d := __common__( map(
    not(add_curr_pop)         => NULL,
    add_curr_avm_auto_val = 0 => NULL,
                                 min(if(add_curr_avm_auto_val = NULL, -NULL, add_curr_avm_auto_val), 300000)));

r_a49_curr_avm_chg_1yr_i := __common__( map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => add_curr_avm_auto_val - add_curr_avm_auto_val_2,
                                                                 NULL));

r_a49_curr_avm_chg_1yr_pct_i := __common__( map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2/0.1)*0.1,
                                                                 NULL));

r_c13_curr_addr_lres_d := __common__( if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999)));

r_c14_addr_stability_v2_d := __common__( map(
    not(truedid)          => NULL,
    addr_stability_v2 = '0' => NULL,
                             (integer)addr_stability_v2));

r_c13_max_lres_d := __common__( if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999)));

r_c14_addrs_5yr_i := __common__( if(not(truedid), NULL, min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999)));

r_c14_addrs_10yr_i := __common__( if(not(truedid), NULL, min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999)));

r_c14_addrs_15yr_i := __common__( if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999)));

r_prop_owner_history_d := __common__( map(
    not(truedid)                                                                     => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 2,
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 1,
                                                                                        0));

r_c20_email_count_i := __common__( if(not(truedid), NULL, min(if(email_count = NULL, -NULL, email_count), 999)));

r_l79_adls_per_addr_curr_i := __common__( if(not(add_curr_pop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999)));

r_l79_adls_per_addr_c6_i := __common__( if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999)));

r_c18_invalid_addrs_per_adl_i := __common__( if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999)));

r_a50_pb_average_dollars_d := __common__( map(
    not(truedid)              => NULL,
    pb_average_dollars = '' => 5000,
                                 min(if(pb_average_dollars = '', -NULL, (Integer)pb_average_dollars), 5000)));

r_a50_pb_total_dollars_d := __common__( map(
    not(truedid)            => NULL,
    pb_total_dollars = '' => 10001,
                               min(if(pb_total_dollars = '', -NULL, (Integer)pb_total_dollars), 10000)));

r_a50_pb_total_orders_d := __common__( map(
    not(truedid)           => NULL,
    pb_total_orders = '' => -1,
                              (Integer)pb_total_orders));

r_pb_order_freq_d := __common__( map(
    not(truedid)                     => NULL,
    pb_number_of_sources = ''     => NULL,
    pb_average_days_bt_orders = '' => -1,
                                        min(if(pb_average_days_bt_orders = '', -NULL, (Integer)	pb_average_days_bt_orders), 999)));

r_i60_inq_count12_i := __common__( if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999)));

r_i60_inq_recency_d := __common__( map(
    not(truedid) => NULL,
    (Boolean)inq_count01  => 1,
    (Boolean)inq_count03  => 3,
    (Boolean)inq_count06  => 6,
    (Boolean)inq_count12  => 12,
    (Boolean)inq_count24  => 24,
    (Boolean)inq_count    => 99,
                    999));

r_i61_inq_collection_count12_i := __common__( if(not(truedid), NULL, min(if(inq_collection_count12 = NULL, -NULL, inq_collection_count12), 999)));

r_i61_inq_collection_recency_d := __common__( map(
    not(truedid)           => NULL,
    (Boolean)inq_collection_count01 => 1,
    (Boolean)inq_collection_count03 => 3,
    (Boolean)inq_collection_count06 => 6,
    (Boolean)inq_collection_count12 => 12,
    (Boolean)inq_collection_count24 => 24,
    (Boolean)inq_collection_count   => 99,
                              999));

r_i60_inq_auto_count12_i := __common__( if(not(truedid), NULL, min(if(inq_auto_count12 = NULL, -NULL, inq_auto_count12), 999)));

r_i60_inq_auto_recency_d := __common__( map(
    not(truedid)     => NULL,
    (Boolean)inq_auto_count01 => 1,
    (Boolean)inq_auto_count03 => 3,
    (Boolean)inq_auto_count06 => 6,
    (Boolean)inq_auto_count12 => 12,
    (Boolean)inq_auto_count24 => 24,
    (Boolean)inq_auto_count   => 99,
                        999));

r_i60_inq_hiriskcred_recency_d := __common__( map(
    not(truedid)               => NULL,
    (Boolean)inq_highRiskCredit_count01 => 1,
    (Boolean)inq_highRiskCredit_count03 => 3,
    (Boolean)inq_highRiskCredit_count06 => 6,
    (Boolean)inq_highRiskCredit_count12 => 12,
    (Boolean)inq_highRiskCredit_count24 => 24,
    (Boolean)inq_highRiskCredit_count   => 99,
                                  999));

r_i60_inq_comm_count12_i := __common__( if(not(truedid), NULL, min(if(inq_communications_count12 = NULL, -NULL, inq_communications_count12), 999)));

r_i60_inq_comm_recency_d := __common__( map(
    not(truedid)               => NULL,
    (Boolean)inq_communications_count01 => 1,
    (Boolean)inq_communications_count03 => 3,
    (Boolean)inq_communications_count06 => 6,
    (Boolean)inq_communications_count12 => 12,
    (Boolean)inq_communications_count24 => 24,
    (Boolean)inq_communications_count   => 99,
                                  999));

f_bus_addr_match_count_d := __common__( if(not(addrpop), NULL, bus_addr_match_count));

f_adl_util_conv_n := __common__( if(contains_i(util_adl_type_list, '2') > 0, 1, 0));

f_util_adl_count_n := __common__( if(not(truedid), NULL, util_adl_count));

f_util_add_curr_inf_n := __common__( if(contains_i(util_add_curr_type_list, '1') > 0, 1, 0));

f_add_input_mobility_index_i := __common__( map(
    not(addrpop)                 => NULL,
    add_input_occupants_1yr <= 0 => NULL,
                                    if(max(add_input_turnover_1yr_in, add_input_turnover_1yr_out) = NULL, NULL, sum(if(add_input_turnover_1yr_in = NULL, 0, add_input_turnover_1yr_in), if(add_input_turnover_1yr_out = NULL, 0, add_input_turnover_1yr_out))) / add_input_occupants_1yr));

add_input_nhood_prop_sum_3 := __common__( if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))));

f_add_input_nhood_bus_pct_i := __common__( map(
    not(addrpop)               => NULL,
    add_input_nhood_BUS_ct = 0 => NULL,
                                  add_input_nhood_BUS_ct / add_input_nhood_prop_sum_3));

add_input_nhood_prop_sum_2 := __common__( if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))));

f_add_input_nhood_mfd_pct_i := __common__( map(
    not(addrpop)               => NULL,
    add_input_nhood_MFD_ct = 0 => NULL,
                                  add_input_nhood_MFD_ct / add_input_nhood_prop_sum_2));

add_input_nhood_prop_sum_1 := __common__( if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))));

f_add_input_nhood_sfd_pct_d := __common__( map(
    not(addrpop)               => NULL,
    add_input_nhood_SFD_ct = 0 => -1,
                                  add_input_nhood_SFD_ct / add_input_nhood_prop_sum_1));

add_input_nhood_prop_sum := __common__( if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))));

f_add_input_nhood_vac_pct_i := __common__( map(
    not(addrpop)                 => NULL,
    add_input_nhood_prop_sum = 0 => -1,
                                    add_input_nhood_VAC_prop / add_input_nhood_prop_sum));

f_add_curr_mobility_index_i := __common__( map(
    not(add_curr_pop)           => NULL,
    add_curr_occupants_1yr <= 0 => NULL,
                                   if(max(add_curr_turnover_1yr_in, add_curr_turnover_1yr_out) = NULL, NULL, sum(if(add_curr_turnover_1yr_in = NULL, 0, add_curr_turnover_1yr_in), if(add_curr_turnover_1yr_out = NULL, 0, add_curr_turnover_1yr_out))) / add_curr_occupants_1yr));

add_curr_nhood_prop_sum_3 := __common__( if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))));

f_add_curr_nhood_bus_pct_i := __common__( map(
    not(add_curr_pop)         => NULL,
    add_curr_nhood_BUS_ct = 0 => NULL,
                                 add_curr_nhood_BUS_ct / add_curr_nhood_prop_sum_3));

add_curr_nhood_prop_sum_2 := __common__( if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))));

f_add_curr_nhood_mfd_pct_i := __common__( map(
    not(add_curr_pop)         => NULL,
    add_curr_nhood_MFD_ct = 0 => NULL,
                                 add_curr_nhood_MFD_ct / add_curr_nhood_prop_sum_2));

add_curr_nhood_prop_sum_1 := __common__( if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))));

f_add_curr_nhood_sfd_pct_d := __common__( map(
    not(add_curr_pop)         => NULL,
    add_curr_nhood_SFD_ct = 0 => -1,
                                 add_curr_nhood_SFD_ct / add_curr_nhood_prop_sum_1));

add_curr_nhood_prop_sum := __common__( if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))));

f_add_curr_nhood_vac_pct_i := __common__( map(
    not(add_curr_pop)           => NULL,
    add_curr_nhood_prop_sum = 0 => -1,
                                   add_curr_nhood_VAC_prop / add_curr_nhood_prop_sum));

f_inq_count24_i := __common__( if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999)));

f_inq_auto_count24_i := __common__( if(not(truedid), NULL, min(if(inq_Auto_count24 = NULL, -NULL, inq_Auto_count24), 999)));

f_inq_collection_count24_i := __common__( if(not(truedid), NULL, min(if(inq_Collection_count24 = NULL, -NULL, inq_Collection_count24), 999)));

f_inq_communications_count24_i := __common__( if(not(truedid), NULL, min(if(inq_Communications_count24 = NULL, -NULL, inq_Communications_count24), 999)));

f_inq_highriskcredit_count24_i := __common__( if(not(truedid), NULL, min(if(inq_HighRiskCredit_count24 = NULL, -NULL, inq_HighRiskCredit_count24), 999)));

f_inq_other_count24_i := __common__( if(not(truedid), NULL, min(if(inq_Other_count24 = NULL, -NULL, inq_Other_count24), 999)));

k_inq_per_ssn_i := __common__( if(not((Integer)ssnlength > 0), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999)));

k_inq_addrs_per_ssn_i := __common__( if(not((Integer)ssnlength > 0), NULL, min(if(inq_addrsperssn = NULL, -NULL, inq_addrsperssn), 999)));

k_inq_dobs_per_ssn_i := __common__( if(not((Integer)ssnlength > 0), NULL, min(if(inq_dobsperssn = NULL, -NULL, inq_dobsperssn), 999)));

k_inq_per_addr_i := __common__( if(not(addrpop), NULL, min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999)));

k_inq_adls_per_addr_i := __common__( if(not(addrpop), NULL, min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999)));

k_inq_lnames_per_addr_i := __common__( if(not(addrpop), NULL, min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999)));

k_inq_ssns_per_addr_i := __common__( if(not(addrpop), NULL, min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999)));

k_inq_per_phone_i := __common__( if(not(hphnpop), NULL, min(if(inq_perphone = NULL, -NULL, inq_perphone), 999)));

k_inq_adls_per_phone_i := __common__( if(not(hphnpop), NULL, min(if(inq_adlsperphone = NULL, -NULL, inq_adlsperphone), 999)));

f_attr_arrest_recency_d := __common__( map(
    not(truedid)        => NULL,
    attr_arrests30 > 0  => 1,
    attr_arrests90 > 0  => 3,
    attr_arrests180 > 0 => 6,
    attr_arrests12 > 0  => 12,
    attr_arrests24 > 0  => 24,
    attr_arrests36 > 0  => 36,
    attr_arrests60 > 0  => 60,
    attr_arrests > 0    => 99,
                           100));

_liens_unrel_cj_first_seen := __common__( common.sas_date((string)(liens_unrel_CJ_first_seen)));

f_mos_liens_unrel_cj_fseen_d := __common__( map(
    not(truedid)                      => NULL,
    _liens_unrel_cj_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)))), 999)));

_liens_unrel_cj_last_seen := __common__( common.sas_date((string)(liens_unrel_CJ_last_seen)));

f_mos_liens_unrel_cj_lseen_d := __common__( map(
    not(truedid)                     => NULL,
    _liens_unrel_cj_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)))), 999))));

f_liens_unrel_cj_total_amt_i := __common__( if(not(truedid), NULL, liens_unrel_CJ_total_amount));

_liens_rel_cj_first_seen := __common__( common.sas_date((string)(liens_rel_CJ_first_seen)));

f_mos_liens_rel_cj_fseen_d := __common__( map(
    not(truedid)                    => NULL,
    _liens_rel_cj_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)))), 999)));

_liens_rel_cj_last_seen := __common__( common.sas_date((string)(liens_rel_CJ_last_seen)));

f_mos_liens_rel_cj_lseen_d := __common__( map(
    not(truedid)                   => NULL,
    _liens_rel_cj_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)))), 999))));

f_liens_rel_cj_total_amt_i := __common__( if(not(truedid), NULL, liens_rel_CJ_total_amount));

_liens_unrel_o_first_seen := __common__( common.sas_date((string)(liens_unrel_O_first_seen)));

f_mos_liens_unrel_o_fseen_d := __common__( map(
    not(truedid)                     => NULL,
    _liens_unrel_o_first_seen = NULL => 1000,
                                        min(if(if ((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12)))), 999)));

_liens_unrel_o_last_seen := __common__( common.sas_date((string)(liens_unrel_O_last_seen)));

f_mos_liens_unrel_o_lseen_d := __common__( map(
    not(truedid)                    => NULL,
    _liens_unrel_o_last_seen = NULL => 1000,
                                       max(3, min(if(if ((sysdate - _liens_unrel_o_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_o_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_o_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_o_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_o_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_o_last_seen) / (365.25 / 12)))), 999))));

_liens_rel_o_first_seen := __common__( common.sas_date((string)(liens_rel_O_first_seen)));

f_mos_liens_rel_o_fseen_d := __common__( map(
    not(truedid)                   => NULL,
    _liens_rel_o_first_seen = NULL => 1000,
                                      min(if(if ((sysdate - _liens_rel_o_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_o_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_o_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_o_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_o_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_o_first_seen) / (365.25 / 12)))), 999)));

_liens_rel_o_last_seen := __common__( common.sas_date((string)(liens_rel_O_last_seen)));

f_mos_liens_rel_o_lseen_d := __common__( map(
    not(truedid)                  => NULL,
    _liens_rel_o_last_seen = NULL => 1000,
                                     max(3, min(if(if ((sysdate - _liens_rel_o_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_o_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_o_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_o_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_o_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_o_last_seen) / (365.25 / 12)))), 999))));

_liens_rel_ot_first_seen := __common__( common.sas_date((string)(liens_rel_OT_first_seen)));

f_mos_liens_rel_ot_fseen_d := __common__( map(
    not(truedid)                    => NULL,
    _liens_rel_ot_first_seen = NULL => -1,
                                       min(if(if ((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)))), 999)));

_liens_rel_ot_last_seen := __common__( common.sas_date((string)(liens_rel_OT_last_seen)));

f_mos_liens_rel_ot_lseen_d := __common__( map(
    not(truedid)                   => NULL,
    _liens_rel_ot_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)))), 999))));

f_liens_unrel_sc_total_amt_i := __common__( if(not(truedid), NULL, liens_unrel_SC_total_amount));

k_estimated_income_d := __common__( if(not(truedid), NULL, estimated_income));

r_wealth_index_d := __common__( if(not(truedid), NULL, (Integer)wealth_index));

f_rel_count_i := __common__( if(not(truedid), NULL, min(if(rel_count = NULL, -NULL, rel_count), 999)));

f_rel_incomeover25_count_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count, rel_incomeunder50_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count)))));

f_rel_incomeover50_count_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count)))));

f_rel_incomeover75_count_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count)))));

f_rel_incomeover100_count_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_incomeover100_count));

f_rel_homeover50_count_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))));

f_rel_homeover100_count_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))));

f_rel_homeover150_count_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))));

f_rel_homeover200_count_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))));

f_rel_homeover300_count_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))));

f_rel_homeover500_count_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_homeover500_count));

f_rel_ageover20_count_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))));

f_rel_ageover30_count_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))));

f_rel_ageover40_count_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))));

f_rel_ageover50_count_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))));

f_rel_educationover8_count_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_educationunder12_count, rel_educationover12_count) = NULL, NULL, sum(if(rel_educationunder12_count = NULL, 0, rel_educationunder12_count), if(rel_educationover12_count = NULL, 0, rel_educationover12_count)))));

f_rel_educationover12_count_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_educationover12_count));

f_crim_rel_under25miles_cnt_i := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     crim_rel_within25miles));

f_crim_rel_under100miles_cnt_i := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(crim_rel_within25miles, crim_rel_within100miles) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles)))));

f_rel_under25miles_cnt_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_within25miles_count));

f_rel_under100miles_cnt_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_within25miles_count, rel_within100miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count)))));

f_rel_under500miles_cnt_d := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count)))));

f_rel_bankrupt_count_i := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 999)));

f_rel_criminal_count_i := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_criminal_count = NULL, -NULL, rel_criminal_count), 999)));

f_rel_felony_count_i := __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_felony_count = NULL, -NULL, rel_felony_count), 999)));

f_current_count_d := __common__( if(not(truedid), NULL, min(if(current_count = NULL, -NULL, current_count), 999)));

f_historical_count_d := __common__( if(not(truedid), NULL, min(if(historical_count = NULL, -NULL, historical_count), 999)));

_acc_last_seen := __common__( common.sas_date((string)(acc_last_seen)));

f_mos_acc_lseen_d := __common__( map(
    not(truedid)          => NULL,
    _acc_last_seen = NULL => 1000,
                             max(3, min(if(if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12)))), 999))));

f_idrisktype_i := __common__( if(not(truedid) or fp_idrisktype = '', NULL, (Integer)fp_idrisktype));

f_idverrisktype_i := __common__( if(not(truedid) or fp_idverrisktype = '', NULL, (Integer)fp_idverrisktype));

f_sourcerisktype_i := __common__( map(
    not(truedid)             => NULL,
    fp_sourcerisktype = '' => NULL,
                                (Integer)fp_sourcerisktype));

f_varrisktype_i := __common__( map(
    not(truedid)          => NULL,
    fp_varrisktype = '' => NULL,
                             (Integer)fp_varrisktype));

f_srchvelocityrisktype_i := __common__( map(
    not(truedid)                   => NULL,
    fp_srchvelocityrisktype = '' => NULL,
                                      (Integer)fp_srchvelocityrisktype));

f_srchcountwk_i := __common__( if(not(truedid), NULL, min(if(fp_srchcountwk = '', -NULL, (Integer)fp_srchcountwk), 999)));

f_srchunvrfdssncount_i := __common__( if(not(truedid), NULL, min(if(fp_srchunvrfdssncount = '', -NULL, (Integer)fp_srchunvrfdssncount), 999)));

f_srchunvrfdaddrcount_i := __common__( if(not(truedid), NULL, min(if(fp_srchunvrfdaddrcount = '', -NULL, (Integer)fp_srchunvrfdaddrcount), 999)));

f_srchunvrfddobcount_i := __common__( if(not(truedid), NULL, min(if(fp_srchunvrfddobcount = '', -NULL, (Integer)fp_srchunvrfddobcount), 999)));

f_srchunvrfdphonecount_i := __common__( if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = '', -NULL, (Integer)fp_srchunvrfdphonecount), 999)));

f_srchfraudsrchcountyr_i := __common__( if(not(truedid), NULL, min(if(fp_srchfraudsrchcountyr = '', -NULL, (Integer)fp_srchfraudsrchcountyr), 999)));

f_assocrisktype_i := __common__( map(
    not(truedid)            => NULL,
    fp_assocrisktype = '' => NULL,
                               (Integer)fp_assocrisktype));

f_assocsuspicousidcount_i := __common__( if(not(truedid), NULL, min(if(fp_assocsuspicousidcount = '', -NULL, (Integer)fp_assocsuspicousidcount), 999)));

f_validationrisktype_i := __common__( map(
    not(truedid)                 => NULL,
    fp_validationrisktype = '' => NULL,
                                    (Integer)fp_validationrisktype));

f_corrrisktype_i := __common__( map(
    not(truedid)           => NULL,
    fp_corrrisktype = '' => NULL,
                              (Integer)fp_corrrisktype));

f_corrssnnamecount_d := __common__( if(not(truedid), NULL, min(if(fp_corrssnnamecount = '', -NULL, (Integer)fp_corrssnnamecount), 999)));

f_corrssnaddrcount_d := __common__( if(not(truedid), NULL, min(if(fp_corrssnaddrcount = '', -NULL, (Integer)fp_corrssnaddrcount), 999)));

f_corraddrphonecount_d := __common__( if(not(truedid), NULL, min(if(fp_corraddrphonecount = '', -NULL, (Integer)fp_corraddrphonecount), 999)));

f_corrphonelastnamecount_d := __common__( if(not(truedid), NULL, min(if(fp_corrphonelastnamecount = '', -NULL, (Integer)fp_corrphonelastnamecount), 999)));

f_divrisktype_i := __common__( map(
    not(truedid)          => NULL,
    fp_divrisktype = '' => NULL,
                             (Integer)fp_divrisktype));

f_divssnidmsrcurelcount_i := __common__( if(not(truedid), NULL, min(if(fp_divssnidmsrcurelcount = '', -NULL, (Integer)fp_divssnidmsrcurelcount), 999)));

f_divaddrsuspidcountnew_i := __common__( if(not(truedid), NULL, min(if(fp_divaddrsuspidcountnew = '', -NULL, (Integer)fp_divaddrsuspidcountnew), 999)));

f_srchcomponentrisktype_i := __common__( map(
    not(truedid)                    => NULL,
    fp_srchcomponentrisktype = '' => NULL,
                                       (Integer)fp_srchcomponentrisktype));

f_srchssnsrchcountmo_i := __common__( if(not(truedid), NULL, min(if(fp_srchssnsrchcountmo = '', -NULL, (Integer)fp_srchssnsrchcountmo), 999)));

f_srchaddrsrchcountmo_i := __common__( if(not(truedid), NULL, min(if(fp_srchaddrsrchcountmo = '', -NULL, (Integer)fp_srchaddrsrchcountmo), 999)));

f_srchaddrsrchcountwk_i := __common__( if(not(truedid), NULL, min(if(fp_srchaddrsrchcountwk = '', -NULL, (Integer)fp_srchaddrsrchcountwk), 999)));

f_srchphonesrchcountmo_i := __common__( if(not(truedid), NULL, min(if(fp_srchphonesrchcountmo = '', -NULL, (Integer)fp_srchphonesrchcountmo), 999)));

f_srchphonesrchcountwk_i := __common__( if(not(truedid), NULL, min(if(fp_srchphonesrchcountwk = '', -NULL, (Integer)fp_srchphonesrchcountwk), 999)));

f_addrchangeincomediff_d_1 := __common__( if(not(truedid), NULL, NULL));

f_addrchangeincomediff_d := __common__( if((Integer)fp_addrchangeincomediff = -1, NULL, (Integer)fp_addrchangeincomediff));

f_addrchangevaluediff_d := __common__( map(
    not(truedid)                => NULL,
    fp_addrchangevaluediff = '-1' => NULL,
                                   (Integer)fp_addrchangevaluediff));

f_addrchangecrimediff_i := __common__( map(
    not(truedid)                => NULL,
    fp_addrchangecrimediff = '-1' => NULL,
                                   (Integer)fp_addrchangecrimediff));

f_addrchangeecontrajindex_d := __common__( if(not(truedid) or fp_addrchangeecontrajindex = '' or fp_addrchangeecontrajindex = '-1', NULL, (Integer)fp_addrchangeecontrajindex));

f_curraddractivephonelist_d := __common__( map(
    not(add_curr_pop)               => NULL,
    fp_curraddractivephonelist = '-1' => NULL,
                                       (Integer)fp_curraddractivephonelist));

f_curraddrmedianincome_d := __common__( if(not(add_curr_pop), NULL, (Integer)fp_curraddrmedianincome));

f_curraddrmedianvalue_d := __common__( if(not(add_curr_pop), NULL, (Integer)fp_curraddrmedianvalue));

f_curraddrmurderindex_i := __common__( if(not(add_curr_pop), NULL, (Integer)fp_curraddrmurderindex));

f_curraddrcartheftindex_i := __common__( if(not(add_curr_pop), NULL, (Integer)fp_curraddrcartheftindex));

f_curraddrburglaryindex_i := __common__( if(not(add_curr_pop), NULL, (Integer)fp_curraddrburglaryindex));

f_curraddrcrimeindex_i := __common__( if(not(add_curr_pop), NULL, (Integer)fp_curraddrcrimeindex));

f_prevaddrageoldest_d := __common__( if(not(truedid), NULL, min(if(fp_prevaddrageoldest = '', -NULL, (Integer)fp_prevaddrageoldest), 999)));

f_prevaddrlenofres_d := __common__( if(not(truedid), NULL, min(if(fp_prevaddrlenofres = '', -NULL, (Integer)fp_prevaddrlenofres), 999)));

f_prevaddroccupantowned_i := __common__( map(
    not(truedid)                    => NULL,
    fp_prevaddroccupantowned = '' => NULL,
                                       (Integer)fp_prevaddroccupantowned));

f_prevaddrmedianincome_d := __common__( if(not(truedid), NULL, (Integer)fp_prevaddrmedianincome));

f_prevaddrmedianvalue_d := __common__( if(not(truedid), NULL, (Integer)fp_prevaddrmedianvalue));

f_prevaddrmurderindex_i := __common__( if(not(truedid), NULL, (Integer)fp_prevaddrmurderindex));

f_prevaddrcartheftindex_i := __common__( if(not(truedid), NULL, (Integer)fp_prevaddrcartheftindex));

f_fp_prevaddrburglaryindex_i := __common__( if(not(truedid), NULL, (Integer)fp_prevaddrburglaryindex));

f_fp_prevaddrcrimeindex_i := __common__( if(not(truedid), NULL, (Integer)fp_prevaddrcrimeindex));

r_c12_source_profile_d := __common__( if(not(truedid), NULL, (Real)hdr_source_profile));

r_f01_inp_addr_not_verified_i := __common__( if(not(add_input_pop and truedid), NULL, (Integer)add_input_addr_not_verified));

r_c23_inp_addr_occ_index_d := __common__( if(not(add_input_pop and truedid), NULL, add_input_occ_index));

r_i60_inq_prepaidcards_recency_d := __common__( map(
    not(truedid)             => NULL,
    (Boolean)inq_PrepaidCards_count01 => 1,
    (Boolean)inq_PrepaidCards_count03 => 3,
    (Boolean)inq_PrepaidCards_count06 => 6,
    (Boolean)inq_PrepaidCards_count12 => 12,
    (Boolean)inq_PrepaidCards_count24 => 24,
    (Boolean)inq_PrepaidCards_count   => 99,
                                999));

f_phone_ver_insurance_d := __common__( if(not(truedid) or phone_ver_insurance = '-1', NULL, (integer)phone_ver_insurance));

f_phone_ver_experian_d := __common__( if(not(truedid) or phone_ver_experian = '-1', NULL, (integer)phone_ver_experian));

f_addrs_per_ssn_i := __common__( if(not((Integer)ssnlength > 0), NULL, min(if((Integer)addrs_per_ssn = NULL, -NULL, (Integer)addrs_per_ssn), 999)));

f_phones_per_addr_curr_i := __common__( if(not(add_curr_pop), NULL, min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999)));

f_addrs_per_ssn_c6_i := __common__( if(not((Integer)ssnlength > 0), NULL, min(if((Integer)addrs_per_ssn_c6 = NULL, -NULL, (Integer)addrs_per_ssn_c6), 999)));

f_phones_per_addr_c6_i := __common__( if(not(addrpop), NULL, min(if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6), 999)));

f_inq_communications_cnt_week_i := __common__( if(not(truedid), NULL, min(if(inq_Communications_count_week = NULL, -NULL, inq_Communications_count_week), 999)));

f_inq_prepaidcards_count24_i := __common__( if(not(truedid), NULL, min(if(inq_PrepaidCards_count24 = NULL, -NULL, inq_PrepaidCards_count24), 999)));

_liens_unrel_st_first_seen := __common__( common.sas_date((string)(liens_unrel_ST_first_seen)));

f_mos_liens_unrel_st_fseen_d := __common__( map(
    not(truedid)                      => NULL,
    _liens_unrel_st_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)))), 999)));

f_liens_unrel_st_total_amt_i := __common__( if(not(truedid), NULL, liens_unrel_ST_total_amount));

f_hh_members_ct_d := __common__( if(not(truedid), NULL, min(if(hh_members_ct = NULL, -NULL, hh_members_ct), 999)));

f_hh_age_65_plus_d := __common__( if(not(truedid), NULL, min(if(hh_age_65_plus = NULL, -NULL, hh_age_65_plus), 999)));

f_hh_age_18_plus_d := __common__( if(not(truedid), NULL, min(if(if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30))) = NULL, -NULL, if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30)))), 999)));

f_hh_collections_ct_i := __common__( if(not(truedid), NULL, min(if(hh_collections_ct = NULL, -NULL, hh_collections_ct), 999)));

f_hh_payday_loan_users_i := __common__( if(not(truedid), NULL, min(if(hh_payday_loan_users = NULL, -NULL, hh_payday_loan_users), 999)));

f_hh_members_w_derog_i := __common__( if(not(truedid), NULL, min(if(hh_members_w_derog = NULL, -NULL, hh_members_w_derog), 999)));

f_hh_tot_derog_i := __common__( if(not(truedid), NULL, min(if(hh_tot_derog = NULL, -NULL, hh_tot_derog), 999)));

f_hh_lienholders_i := __common__( if(not(truedid), NULL, min(if(hh_lienholders = NULL, -NULL, hh_lienholders), 999)));

_ver_src_ds := __common__( Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0);

_ver_src_de := __common__( Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0);

_ver_src_eq := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0);

_ver_src_en := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0);

_ver_src_tn := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0);

_ver_src_tu := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0);

_credit_source_cnt := __common__( if(max((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu) = NULL, NULL, sum((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu)));

_ver_src_cnt := __common__( Models.Common.countw((string)(ver_sources), ','));

_bureauonly := __common__( _credit_source_cnt > 0 AND _credit_source_cnt = _ver_src_cnt AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6])));

_derog := __common__( felony_count > 0 OR (Integer)addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2);

_deceased := __common__( (Integer)rc_decsflag = 1 OR rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de);

_ssnpriortodob := __common__( (Integer)rc_ssndobflag = 1 OR (Integer)rc_pwssndobflag = 1);

_inputmiskeys := __common__( rc_ssnmiskeyflag or rc_addrmiskeyflag or (Integer)add_input_house_number_match = 0);

_multiplessns := __common__( ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1);

_hh_strikes := __common__( if((Real)max((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0) = NULL, NULL, (Real)sum((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0)));

nf_seg_fraudpoint_3_0 := __common__( map(
    addrpop and (nas_summary in [4, 7, 9]) or (fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9') or _deceased or _ssnpriortodob => '1: Stolen/Manip ID  ',
    _inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1)                                                                                                                                 => '1: Stolen/Manip ID  ',
    fnamepop and lnamepop and addrpop and ssnlength = '9' and hphnpop and nap_summary <= 4 and nas_summary <= 4 or _ver_src_cnt = 0 or _bureauonly or add_curr_pop = false                           => '2: Synth ID         ',
    _derog                                                                                                                                                                                     => '3: Derog            ',
    Inq_count03 > 0 or Inq_count12 >= 4 or (Integer)fp_srchfraudsrchcountyr >= 1 or (Integer)fp_srchssnsrchcountmo >= 1 or (Integer)fp_srchaddrsrchcountmo >= 1 or (Integer)fp_srchphonesrchcountmo >= 1                           => '4: Recent Activity  ',
    0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70                                                                                                                              => '5: Vuln Vic/Friendly',
    hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2)                                                                                              => '5: Vuln Vic/Friendly',
                                                                                                                                                                                                  '6: Other            '));

r_nas_ssn_verd_d := __common__( (Integer)(nas_summary in [4, 6, 7, 9, 10, 11, 12]));

r_l70_add_invalid_i := __common__( map(
    not(addrpop)                                        => NULL,
    trim(trim(rc_addrvalflag, LEFT), LEFT, RIGHT) = 'N' => 1,
                                                           0));

r_d31_attr_bankruptcy_recency_d := __common__( map(
    not(truedid)             => NULL,
    (Boolean)attr_bankruptcy_count30  => 1,
    (Boolean)attr_bankruptcy_count90  => 3,
    (Boolean)attr_bankruptcy_count180 => 6,
    (Boolean)attr_bankruptcy_count12  => 12,
    (Boolean)attr_bankruptcy_count24  => 24,
    (Boolean)attr_bankruptcy_count36  => 36,
    (Boolean)attr_bankruptcy_count60  => 60,
    bankrupt                 => 99,
    filing_count > 0         => 99,
                                0));

r_d34_unrel_lien60_count_i := __common__( if(not(truedid), NULL, min(if(attr_num_unrel_liens60 = NULL, -NULL, attr_num_unrel_liens60), 999)));

r_a41_prop_owner_d := __common__( map(
    not(truedid)                                                                                   => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 => 1,
                                                                                                      0));

r_l78_no_phone_at_addr_vel_i := __common__( map(
    not(addrpop)             => NULL,
    phones_per_addr_curr = 0 => 1,
                                0));

r_i60_inq_retail_recency_d := __common__( map(
    not(truedid)       => NULL,
    (Boolean)inq_retail_count01 => 1,
    (Boolean)inq_retail_count03 => 3,
    (Boolean)inq_retail_count06 => 6,
    (Boolean)inq_retail_count12 => 12,
    (Boolean)inq_retail_count24 => 24,
    (Boolean)inq_retail_count   => 99,
                          999));

f_bus_fname_verd_d := __common__( if(not(addrpop), NULL, (Integer)(bus_name_match in [2, 4])));

f_adl_util_misc_n := __common__( if(contains_i(StringLib.StringToUpperCase(util_adl_type_list), 'Z') > 0, 1, 0));

f_add_curr_has_vac_ct_i := __common__( if(add_curr_nhood_prop_sum = 0, 0, 1));

_liens_unrel_ft_first_seen := __common__( common.sas_date((string)(liens_unrel_FT_first_seen)));

f_mos_liens_unrel_ft_fseen_d := __common__( map(
    not(truedid)                      => NULL,
    _liens_unrel_ft_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)))), 999)));

f_acc_damage_amt_total_i := __common__( if(not(truedid), NULL, acc_damage_amt_total));

f_vardobcount_i := __common__( if(not(truedid), NULL, min(if(fp_vardobcount = '', -NULL, (Integer)fp_vardobcount), 999)));

f_srchcountday_i := __common__( if(not(truedid), NULL, min(if(fp_srchcountday = '', -NULL, (Integer)fp_srchcountday), 999)));

f_srchfraudsrchcountwk_i := __common__( if(not(truedid), NULL, min(if(fp_srchfraudsrchcountwk = '', -NULL, (Integer)fp_srchfraudsrchcountwk), 999)));

f_assoccredbureaucount_i := __common__( if(not(truedid), NULL, min(if(fp_assoccredbureaucount = '', -NULL, (Integer)fp_assoccredbureaucount), 999)));

f_srchssnsrchcountday_i := __common__( if(not(truedid), NULL, min(if(fp_srchssnsrchcountday = '', -NULL, (Integer)fp_srchssnsrchcountday), 999)));

f_inputaddractivephonelist_d := __common__( map(
    not(truedid)                     => NULL,
    (Integer)fp_inputaddractivephonelist = -1 => NULL,
                                        (Integer)fp_inputaddractivephonelist));

f_prevaddrdwelltype_sfd_n := __common__( if(not(truedid), NULL, (Integer)(fp_prevaddrdwelltype = 'S')));

f_prevaddrstatus_i := __common__( map(
    not(truedid)            => NULL,
    fp_prevaddrstatus = '0' => 1,
    fp_prevaddrstatus = 'U' => 2,
    fp_prevaddrstatus = 'R' => 3,
                               NULL));

r_c12_source_profile_index_d := __common__( if(not(truedid), NULL, hdr_source_profile_index));

f_dl_addrs_per_adl_i := __common__( if(not(truedid), NULL, min(if(dl_addrs_per_adl = NULL, -NULL, dl_addrs_per_adl), 999)));

f_inq_auto_count_week_i := __common__( if(not(truedid), NULL, min(if(inq_Auto_count_week = NULL, -NULL, inq_Auto_count_week), 999)));

f_liens_rel_sc_total_amt_i := __common__( if(not(truedid), NULL, liens_rel_SC_total_amount));

f_hh_college_attendees_d := __common__( if(not(truedid), NULL, min(if(hh_college_attendees = NULL, -NULL, hh_college_attendees), 999)));

r_d31_bk_chapter_n := __common__( map(
    not(truedid)                                 => '',
    not((bk_chapter in ['7', '11', '12', '13'])) => '',
                                                    trim(bk_chapter, LEFT)));

final_score_0 := __common__( -1.6223089110);

final_score_1_c245 := __common__( map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 8.5 => 0.0897119423,
    f_corrrisktype_i > 8.5                              => 0.2366003946,
    f_corrrisktype_i = NULL                             => 0.1221634563,
                                                           0.1221634563));

final_score_1_c246 := __common__( map(
    NULL < (Integer)k_nap_phn_verd_d AND (Real)k_nap_phn_verd_d <= 0.5 => 0.0358951935,
    (Real)k_nap_phn_verd_d > 0.5                              => -0.0302765573,
    (Integer)k_nap_phn_verd_d = NULL                             => 0.0077123240,
                                                           0.0077123240));

final_score_1_c244 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.1344619476 => final_score_1_c245,
    f_add_input_nhood_sfd_pct_d > 0.1344619476                                         => final_score_1_c246,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => 0.0362248486,
                                                                                          0.0362248486));

final_score_1_c247 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.07355156325 => 0.1925473325,
    f_add_input_nhood_sfd_pct_d > 0.07355156325                                         => 0.0302550556,
    f_add_input_nhood_sfd_pct_d = NULL                                                  => 0.0862920615,
                                                                                           0.0862920615));

final_score_1 := __common__( map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_1_c244,
    f_phone_ver_experian_d > 0.5                                    => -0.0578020228,
    f_phone_ver_experian_d = NULL                                   => final_score_1_c247,
                                                                       0.0011769577));

final_score_2_c250 := __common__( map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 16 => 0.2074233261,
    r_f01_inp_addr_address_score_d > 16                                            => 0.0760262722,
    r_f01_inp_addr_address_score_d = NULL                                          => 0.0924562944,
                                                                                      0.0924562944));

final_score_2_c251 := __common__( map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 7.5 => -0.0176049359,
    f_corrrisktype_i > 7.5                              => 0.0541751063,
    f_corrrisktype_i = NULL                             => 0.0004299222,
                                                           0.0004299222));

final_score_2_c249 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.14837117365 => final_score_2_c250,
    f_add_input_nhood_sfd_pct_d > 0.14837117365                                         => final_score_2_c251,
    f_add_input_nhood_sfd_pct_d = NULL                                                  => 0.0241227280,
                                                                                           0.0241227280));

final_score_2_c252 := __common__( map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.3111941552 => 0.1276678281,
    f_add_curr_nhood_sfd_pct_d > 0.3111941552                                        => 0.0169234607,
    f_add_curr_nhood_sfd_pct_d = NULL                                                => 0.2927329492,
                                                                                        0.0746424353));

final_score_2 := __common__( map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_2_c249,
    f_phone_ver_experian_d > 0.5                                    => -0.0547124339,
    f_phone_ver_experian_d = NULL                                   => final_score_2_c252,
                                                                       -0.0039724367));

final_score_3_c255 := __common__( map(
    NULL < (Integer)k_nap_phn_verd_d AND (Real)k_nap_phn_verd_d <= 0.5 => 0.1120792341,
    (Real)k_nap_phn_verd_d > 0.5                              => 0.0152425644,
    (Integer)k_nap_phn_verd_d = NULL                             => 0.0861116727,
                                                           0.0861116727));

final_score_3_c256 := __common__( map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 8.5 => -0.0085137049,
    f_corrrisktype_i > 8.5                              => 0.0750713513,
    f_corrrisktype_i = NULL                             => 0.0011314578,
                                                           0.0011314578));

final_score_3_c254 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.1308526595 => final_score_3_c255,
    f_add_input_nhood_sfd_pct_d > 0.1308526595                                         => final_score_3_c256,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => 0.0222764278,
                                                                                          0.0222764278));

final_score_3_c257 := __common__( map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.023203354 => 0.1461148511,
    f_add_curr_nhood_sfd_pct_d > 0.023203354                                        => 0.0283267432,
    f_add_curr_nhood_sfd_pct_d = NULL                                               => 0.2262007372,
                                                                                       0.0629371939));

final_score_3 := __common__( map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_3_c254,
    f_phone_ver_experian_d > 0.5                                    => -0.0512366522,
    f_phone_ver_experian_d = NULL                                   => final_score_3_c257,
                                                                       -0.0048559926));

final_score_4_c260 := __common__( map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 5.5 => -0.0211480031,
    f_corrrisktype_i > 5.5                              => 0.0315215242,
    f_corrrisktype_i = NULL                             => 0.0060856930,
                                                           0.0060856930));

final_score_4_c259 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.05990400025 => 0.0799785672,
    f_add_input_nhood_sfd_pct_d > 0.05990400025                                         => final_score_4_c260,
    f_add_input_nhood_sfd_pct_d = NULL                                                  => 0.0210262665,
                                                                                           0.0210262665));

final_score_4_c262 := __common__( map(
    NULL < r_c16_inv_ssn_per_adl_i AND r_c16_inv_ssn_per_adl_i <= 0.5 => 0.0899722701,
    r_c16_inv_ssn_per_adl_i > 0.5                                     => -0.0571796547,
    r_c16_inv_ssn_per_adl_i = NULL                                    => 0.0738750745,
                                                                         0.0738750745));

final_score_4_c261 := __common__( map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => final_score_4_c262,
    f_corrphonelastnamecount_d > 0.5                                        => -0.0265741436,
    f_corrphonelastnamecount_d = NULL                                       => 0.1989880636,
                                                                               0.0493721216));

final_score_4 := __common__( map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_4_c259,
    f_phone_ver_experian_d > 0.5                                    => -0.0486381505,
    f_phone_ver_experian_d = NULL                                   => final_score_4_c261,
                                                                       -0.0056418449));

final_score_5_c264 := __common__( map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 549 => 0.0052662146,
    r_i60_inq_comm_recency_d > 549                                      => -0.0451197067,
    r_i60_inq_comm_recency_d = NULL                                     => -0.0211726110,
                                                                           -0.0211726110));

final_score_5_c267 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 1.5 => 0.0391705436,
    f_inq_communications_count24_i > 1.5                                            => 0.1163940650,
    f_inq_communications_count24_i = NULL                                           => 0.0595734655,
                                                                                       0.0595734655));

final_score_5_c266 := __common__( map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 16 => 0.1600083360,
    r_f01_inp_addr_address_score_d > 16                                            => final_score_5_c267,
    r_f01_inp_addr_address_score_d = NULL                                          => 0.0717175511,
                                                                                      0.0717175511));

final_score_5_c265 := __common__( map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => final_score_5_c266,
    f_corrphonelastnamecount_d > 0.5                                        => -0.0067968524,
    f_corrphonelastnamecount_d = NULL                                       => 0.0451419531,
                                                                               0.0451419531));

final_score_5 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.65899047215 => final_score_5_c264,
    f_add_input_nhood_mfd_pct_i > 0.65899047215                                         => final_score_5_c265,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => -0.0264622935,
                                                                                           -0.0042821000));

final_score_6_c270 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 1.5 => 0.0552758122,
    f_inq_communications_count24_i > 1.5                                            => 0.1359650082,
    f_inq_communications_count24_i = NULL                                           => 0.0773990472,
                                                                                       0.0773990472));

final_score_6_c271 := __common__( map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 2.5 => -0.0085081697,
    f_idverrisktype_i > 2.5                               => 0.0537776802,
    f_idverrisktype_i = NULL                              => 0.0117953390,
                                                             0.0117953390));

final_score_6_c269 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.1104234407 => final_score_6_c270,
    f_add_input_nhood_sfd_pct_d > 0.1104234407                                         => final_score_6_c271,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => 0.0306224214,
                                                                                          0.0306224214));

final_score_6_c272 := __common__( map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 549 => -0.0094039620,
    r_i60_inq_comm_recency_d > 549                                      => -0.0564922059,
    r_i60_inq_comm_recency_d = NULL                                     => -0.0340782569,
                                                                           -0.0340782569));

final_score_6 := __common__( map(
    NULL < (Integer)k_nap_phn_verd_d AND (Real)k_nap_phn_verd_d <= 0.5 => final_score_6_c269,
    (Real)k_nap_phn_verd_d > 0.5                              => final_score_6_c272,
    (Integer)k_nap_phn_verd_d = NULL                             => -0.0048277318,
                                                           -0.0048277318));

final_score_7_c276 := __common__( map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => 0.0384085919,
    f_phone_ver_insurance_d > 3.5                                     => -0.0168795361,
    f_phone_ver_insurance_d = NULL                                    => 0.0190105591,
                                                                         0.0190105591));

final_score_7_c275 := __common__( map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 9 => 0.0957167339,
    r_i60_inq_comm_recency_d > 9                                      => final_score_7_c276,
    r_i60_inq_comm_recency_d = NULL                                   => 0.0285028760,
                                                                         0.0285028760));

final_score_7_c274 := __common__( map(
    NULL < r_d31_attr_bankruptcy_recency_d AND r_d31_attr_bankruptcy_recency_d <= 2 => final_score_7_c275,
    r_d31_attr_bankruptcy_recency_d > 2                                             => -0.0364308007,
    r_d31_attr_bankruptcy_recency_d = NULL                                          => 0.0149685739,
                                                                                       0.0149685739));

final_score_7_c277 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 2.5 => 0.0262105130,
    f_inq_communications_count24_i > 2.5                                            => 0.1360315281,
    f_inq_communications_count24_i = NULL                                           => 0.1286687440,
                                                                                       0.0393912845));

final_score_7 := __common__( map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_7_c274,
    f_phone_ver_experian_d > 0.5                                    => -0.0431081879,
    f_phone_ver_experian_d = NULL                                   => final_score_7_c277,
                                                                       -0.0070688423));

final_score_8_c280 := __common__( map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.083488228 => 0.0821304678,
    f_add_curr_nhood_sfd_pct_d > 0.083488228                                        => 0.0151625253,
    f_add_curr_nhood_sfd_pct_d = NULL                                               => 0.0314441139,
                                                                                       0.0314441139));

final_score_8_c281 := __common__( map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 208.5 => -0.0065559594,
    r_c21_m_bureau_adl_fs_d > 208.5                                     => -0.0458771807,
    r_c21_m_bureau_adl_fs_d = NULL                                      => -0.0298846726,
                                                                           -0.0298846726));

final_score_8_c279 := __common__( map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 61.5 => final_score_8_c280,
    r_i60_inq_comm_recency_d > 61.5                                      => final_score_8_c281,
    r_i60_inq_comm_recency_d = NULL                                      => -0.0148374712,
                                                                            -0.0148374712));

final_score_8_c282 := __common__( map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 0.5 => 0.2305536452,
    f_rel_under100miles_cnt_d > 0.5                                       => 0.0510219371,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0855621914,
                                                                             0.0664468628));

final_score_8 := __common__( map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 8.5 => final_score_8_c279,
    f_corrrisktype_i > 8.5                              => final_score_8_c282,
    f_corrrisktype_i = NULL                             => 0.0747507680,
                                                           -0.0064356306));

final_score_9_c284 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 2.5 => -0.0303169087,
    f_inq_communications_count24_i > 2.5                                            => 0.0411600407,
    f_inq_communications_count24_i = NULL                                           => -0.0257097292,
                                                                                       -0.0257097292));

final_score_9_c287 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -74804.5 => 0.1194576670,
    f_addrchangevaluediff_d > -74804.5                                     => 0.0240442295,
    f_addrchangevaluediff_d = NULL                                         => 0.0232680987,
                                                                              0.0302803422));

final_score_9_c286 := __common__( map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_9_c287,
    f_phone_ver_insurance_d > 3.5                                     => -0.0129403012,
    f_phone_ver_insurance_d = NULL                                    => 0.0144075230,
                                                                         0.0144075230));

final_score_9_c285 := __common__( map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 9 => 0.0912331723,
    r_i60_inq_comm_recency_d > 9                                      => final_score_9_c286,
    r_i60_inq_comm_recency_d = NULL                                   => 0.0230693051,
                                                                         0.0230693051));

final_score_9 := __common__( map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 5.5 => final_score_9_c284,
    f_corrrisktype_i > 5.5                              => final_score_9_c285,
    f_corrrisktype_i = NULL                             => 0.0895637237,
                                                           -0.0033549887));

final_score_10_c290 := __common__( map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 9.5 => 0.0011059922,
    r_pb_order_freq_d > 9.5                               => -0.0220627216,
    r_pb_order_freq_d = NULL                              => 0.0379519513,
                                                             0.0045122487));

final_score_10_c289 := __common__( map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 549 => final_score_10_c290,
    r_i60_inq_comm_recency_d > 549                                      => -0.0440706098,
    r_i60_inq_comm_recency_d = NULL                                     => -0.0203250229,
                                                                           -0.0203250229));

final_score_10_c292 := __common__( map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 549 => 0.0390137372,
    r_i60_inq_comm_recency_d > 549                                      => -0.0069494298,
    r_i60_inq_comm_recency_d = NULL                                     => 0.0166370336,
                                                                           0.0166370336));

final_score_10_c291 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.0517453886 => 0.0567000683,
    f_add_input_nhood_sfd_pct_d > 0.0517453886                                         => final_score_10_c292,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => 0.0270025410,
                                                                                          0.0270025410));

final_score_10 := __common__( map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 6.5 => final_score_10_c289,
    f_corrrisktype_i > 6.5                              => final_score_10_c291,
    f_corrrisktype_i = NULL                             => 0.0978158707,
                                                           -0.0047187516));

final_score_11_c296 := __common__( map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -18355.5 => 0.0841334904,
    f_addrchangeincomediff_d > -18355.5                                      => -0.0088107003,
    f_addrchangeincomediff_d = NULL                                          => 0.0063814605,
                                                                                -0.0034707145));

final_score_11_c295 := __common__( map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 3.5 => final_score_11_c296,
    f_addrchangeecontrajindex_d > 3.5                                         => 0.0701742328,
    f_addrchangeecontrajindex_d = NULL                                        => 0.0229267029,
                                                                                 0.0098145084));

final_score_11_c294 := __common__( map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.0493862968 => 0.0532271263,
    f_add_curr_nhood_sfd_pct_d > 0.0493862968                                        => final_score_11_c295,
    f_add_curr_nhood_sfd_pct_d = NULL                                                => 0.0840668221,
                                                                                        0.0193741867));

final_score_11_c297 := __common__( map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d <= 549 => 0.0245690781,
    r_i60_inq_prepaidcards_recency_d > 549                                              => -0.0362217459,
    r_i60_inq_prepaidcards_recency_d = NULL                                             => -0.0271999565,
                                                                                           -0.0271999565));

final_score_11 := __common__( map(
    NULL < (Integer)k_nap_phn_verd_d AND (Real)k_nap_phn_verd_d <= 0.5 => final_score_11_c294,
    (Real)k_nap_phn_verd_d > 0.5                              => final_score_11_c297,
    (Integer)k_nap_phn_verd_d = NULL                             => -0.0065418145,
                                                           -0.0065418145));

final_score_12_c300 := __common__( map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 4.5 => 0.0551954035,
    f_addrchangeecontrajindex_d > 4.5                                         => 0.1705399612,
    f_addrchangeecontrajindex_d = NULL                                        => 0.0216530228,
                                                                                 0.0402650060));

final_score_12_c299 := __common__( map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 2.5 => 0.0001044708,
    f_idverrisktype_i > 2.5                               => final_score_12_c300,
    f_idverrisktype_i = NULL                              => 0.0135083735,
                                                             0.0135083735));

final_score_12_c302 := __common__( map(
    NULL < f_crim_rel_under100miles_cnt_i AND f_crim_rel_under100miles_cnt_i <= 0.5 => 0.0580744910,
    f_crim_rel_under100miles_cnt_i > 0.5                                            => -0.0019411287,
    f_crim_rel_under100miles_cnt_i = NULL                                           => 0.0821422230,
                                                                                       0.0340402131));

final_score_12_c301 := __common__( map(
    NULL < r_c16_inv_ssn_per_adl_i AND r_c16_inv_ssn_per_adl_i <= 0.5 => final_score_12_c302,
    r_c16_inv_ssn_per_adl_i > 0.5                                     => -0.0733042697,
    r_c16_inv_ssn_per_adl_i = NULL                                    => 0.0630393782,
                                                                         0.0256414112));

final_score_12 := __common__( map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_12_c299,
    f_phone_ver_experian_d > 0.5                                    => -0.0343260800,
    f_phone_ver_experian_d = NULL                                   => final_score_12_c301,
                                                                       -0.0054989850));

final_score_13_c304 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 2.5 => 0.0217254104,
    f_inq_communications_count24_i > 2.5                                            => 0.0786364700,
    f_inq_communications_count24_i = NULL                                           => 0.0294637773,
                                                                                       0.0294637773));

final_score_13_c307 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 411413 => -0.0053268367,
    f_prevaddrmedianvalue_d > 411413                                     => 0.0976371682,
    f_prevaddrmedianvalue_d = NULL                                       => 0.0001432853,
                                                                            0.0001432853));

final_score_13_c306 := __common__( map(
    NULL < (Integer)k_nap_phn_verd_d AND (Real)k_nap_phn_verd_d <= 0.5 => final_score_13_c307,
    (Real)k_nap_phn_verd_d > 0.5                              => -0.0399221751,
    (Integer)k_nap_phn_verd_d = NULL                             => -0.0244351371,
                                                           -0.0244351371));

final_score_13_c305 := __common__( map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d <= 549 => 0.0310156333,
    r_i60_inq_prepaidcards_recency_d > 549                                              => final_score_13_c306,
    r_i60_inq_prepaidcards_recency_d = NULL                                             => -0.0163616596,
                                                                                           -0.0163616596));

final_score_13 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.2448100612 => final_score_13_c304,
    f_add_input_nhood_sfd_pct_d > 0.2448100612                                         => final_score_13_c305,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => -0.0042996252,
                                                                                          -0.0042996252));

final_score_14_c311 := __common__( map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 108515 => -0.0138646653,
    f_curraddrmedianincome_d > 108515                                      => 0.1529614220,
    f_curraddrmedianincome_d = NULL                                        => -0.0106794417,
                                                                              -0.0106794417));

final_score_14_c310 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 0.5 => final_score_14_c311,
    f_inq_communications_count24_i > 0.5                                            => 0.0320043717,
    f_inq_communications_count24_i = NULL                                           => 0.0015678199,
                                                                                       0.0015678199));

final_score_14_c309 := __common__( map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 21.5 => final_score_14_c310,
    f_addrchangecrimediff_i > 21.5                                     => 0.0706574447,
    f_addrchangecrimediff_i = NULL                                     => 0.0166429941,
                                                                          0.0090501161));

final_score_14_c312 := __common__( map(
    NULL < r_c16_inv_ssn_per_adl_i AND r_c16_inv_ssn_per_adl_i <= 0.5 => 0.0348960412,
    r_c16_inv_ssn_per_adl_i > 0.5                                     => -0.0764054614,
    r_c16_inv_ssn_per_adl_i = NULL                                    => 0.0393844594,
                                                                         0.0257789521));

final_score_14 := __common__( map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_14_c309,
    f_phone_ver_experian_d > 0.5                                    => -0.0339856593,
    f_phone_ver_experian_d = NULL                                   => final_score_14_c312,
                                                                       -0.0073460737));

final_score_15_c314 := __common__( map(
    NULL < f_corrssnaddrcount_d AND f_corrssnaddrcount_d <= 2.5 => 0.0175976260,
    f_corrssnaddrcount_d > 2.5                                  => -0.0264378244,
    f_corrssnaddrcount_d = NULL                                 => -0.0178797459,
                                                                   -0.0178797459));

final_score_15_c317 := __common__( map(
    NULL < f_srchunvrfdssncount_i AND f_srchunvrfdssncount_i <= 0.5 => 0.0200650008,
    f_srchunvrfdssncount_i > 0.5                                    => 0.0734339371,
    f_srchunvrfdssncount_i = NULL                                   => 0.0306289109,
                                                                       0.0306289109));

final_score_15_c316 := __common__( map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 16 => 0.0936082077,
    r_f01_inp_addr_address_score_d > 16                                            => final_score_15_c317,
    r_f01_inp_addr_address_score_d = NULL                                          => 0.0385478813,
                                                                                      0.0385478813));

final_score_15_c315 := __common__( map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_15_c316,
    f_phone_ver_insurance_d > 3.5                                     => 0.0028641136,
    f_phone_ver_insurance_d = NULL                                    => 0.0248378747,
                                                                         0.0237509857));

final_score_15 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.64215236775 => final_score_15_c314,
    f_add_input_nhood_mfd_pct_i > 0.64215236775                                         => final_score_15_c315,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => -0.0194389601,
                                                                                           -0.0068216621));

final_score_16_c321 := __common__( map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.0430741028,
    f_phone_ver_experian_d > 0.5                                    => -0.0167899087,
    f_phone_ver_experian_d = NULL                                   => 0.0509334277,
                                                                       0.0265894713));

final_score_16_c320 := __common__( map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_16_c321,
    r_phn_cell_n > 0.5                          => -0.0042093126,
    r_phn_cell_n = NULL                         => 0.0074821381,
                                                   0.0074821381));

final_score_16_c319 := __common__( map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 1.5 => -0.0296741158,
    f_idverrisktype_i > 1.5                               => final_score_16_c320,
    f_idverrisktype_i = NULL                              => -0.0085974420,
                                                             -0.0085974420));

final_score_16_c322 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.32293650245 => 0.0769091629,
    f_add_input_nhood_sfd_pct_d > 0.32293650245                                         => 0.0196896294,
    f_add_input_nhood_sfd_pct_d = NULL                                                  => 0.0467996906,
                                                                                           0.0467996906));

final_score_16 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 2.5 => final_score_16_c319,
    f_inq_communications_count24_i > 2.5                                            => final_score_16_c322,
    f_inq_communications_count24_i = NULL                                           => 0.0351956816,
                                                                                       -0.0040870784));

final_score_17_c324 := __common__( map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 4.5 => 0.0691486176,
    r_i60_inq_comm_recency_d > 4.5                                      => -0.0126209075,
    r_i60_inq_comm_recency_d = NULL                                     => -0.0083244271,
                                                                           -0.0083244271));

final_score_17_c325 := __common__( map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 8.5 => -0.0297276568,
    f_corrrisktype_i > 8.5                              => 0.0428430333,
    f_corrrisktype_i = NULL                             => -0.0252605410,
                                                           -0.0252605410));

final_score_17_c327 := __common__( map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 75 => 0.0666052903,
    f_curraddrburglaryindex_i > 75                                       => 0.0248876705,
    f_curraddrburglaryindex_i = NULL                                     => 0.0424142732,
                                                                            0.0424142732));

final_score_17_c326 := __common__( map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 549 => final_score_17_c327,
    r_i60_inq_comm_recency_d > 549                                      => -0.0026900440,
    r_i60_inq_comm_recency_d = NULL                                     => 0.0071128025,
                                                                           0.0199645697));

final_score_17 := __common__( map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 11.5 => final_score_17_c324,
    r_pb_order_freq_d > 11.5                               => final_score_17_c325,
    r_pb_order_freq_d = NULL                               => final_score_17_c326,
                                                              -0.0027412334));

final_score_18_c332 := __common__( map(
    NULL < (Integer)k_nap_phn_verd_d AND (Real)k_nap_phn_verd_d <= 0.5 => 0.0909516629,
    (Real)k_nap_phn_verd_d > 0.5                              => 0.0147518356,
    (Integer)k_nap_phn_verd_d = NULL                             => 0.0715281775,
                                                           0.0715281775));

final_score_18_c331 := __common__( map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_18_c332,
    r_phn_cell_n > 0.5                          => 0.0143720396,
    r_phn_cell_n = NULL                         => 0.0389043404,
                                                   0.0389043404));

final_score_18_c330 := __common__( map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_18_c331,
    f_phone_ver_insurance_d > 3.5                                     => -0.0010804932,
    f_phone_ver_insurance_d = NULL                                    => 0.0215474268,
                                                                         0.0215474268));

final_score_18_c329 := __common__( map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 2.5 => -0.0050639154,
    f_idverrisktype_i > 2.5                               => final_score_18_c330,
    f_idverrisktype_i = NULL                              => 0.0030710148,
                                                             0.0030710148));

final_score_18 := __common__( map(
    NULL < r_d31_mostrec_bk_i AND r_d31_mostrec_bk_i <= 0.5 => final_score_18_c329,
    r_d31_mostrec_bk_i > 0.5                                => -0.0412938130,
    r_d31_mostrec_bk_i = NULL                               => 0.0330281628,
                                                               -0.0069082917));

final_score_19_c335 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 225141 => -0.0212867560,
    f_addrchangevaluediff_d > 225141                                     => 0.1035614899,
    f_addrchangevaluediff_d = NULL                                       => -0.0131031831,
                                                                            -0.0189843895));

final_score_19_c334 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 361853 => final_score_19_c335,
    f_curraddrmedianvalue_d > 361853                                     => 0.0263761153,
    f_curraddrmedianvalue_d = NULL                                       => -0.0126955701,
                                                                            -0.0126955701));

final_score_19_c337 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 4.5 => 0.0353618684,
    f_inq_communications_count24_i > 4.5                                            => 0.1044592403,
    f_inq_communications_count24_i = NULL                                           => 0.0436987701,
                                                                                       0.0436987701));

final_score_19_c336 := __common__( map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 78.5 => 0.0186740666,
    r_pb_order_freq_d > 78.5                               => -0.0092228233,
    r_pb_order_freq_d = NULL                               => final_score_19_c337,
                                                              0.0236768618));

final_score_19 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 0.5 => final_score_19_c334,
    f_inq_communications_count24_i > 0.5                                            => final_score_19_c336,
    f_inq_communications_count24_i = NULL                                           => 0.0388050263,
                                                                                       -0.0035449601));

final_score_20_c341 := __common__( map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => -0.0100908552,
    f_validationrisktype_i > 1.5                                    => 0.0920118261,
    f_validationrisktype_i = NULL                                   => -0.0083361752,
                                                                       -0.0083361752));

final_score_20_c340 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -248701 => 0.0998603561,
    f_addrchangevaluediff_d > -248701                                     => final_score_20_c341,
    f_addrchangevaluediff_d = NULL                                        => 0.0033947972,
                                                                             -0.0049388532));

final_score_20_c342 := __common__( map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 84 => 0.0444526929,
    f_fp_prevaddrburglaryindex_i > 84                                          => 0.0075812107,
    f_fp_prevaddrburglaryindex_i = NULL                                        => 0.0245352143,
                                                                                  0.0245352143));

final_score_20_c339 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 0.5 => final_score_20_c340,
    f_inq_communications_count24_i > 0.5                                            => final_score_20_c342,
    f_inq_communications_count24_i = NULL                                           => 0.0028313585,
                                                                                       0.0028313585));

final_score_20 := __common__( map(
    NULL < r_d31_mostrec_bk_i AND r_d31_mostrec_bk_i <= 0.5 => final_score_20_c339,
    r_d31_mostrec_bk_i > 0.5                                => -0.0376624685,
    r_d31_mostrec_bk_i = NULL                               => 0.0737606190,
                                                               -0.0063673440));

final_score_21_c345 := __common__( map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i <= 3.5 => 0.0242375683,
    r_i60_inq_comm_count12_i > 3.5                                      => 0.0842502972,
    r_i60_inq_comm_count12_i = NULL                                     => 0.0276508004,
                                                                           0.0276508004));

final_score_21_c344 := __common__( map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 30.5 => 0.0089739631,
    r_pb_order_freq_d > 30.5                               => -0.0149187126,
    r_pb_order_freq_d = NULL                               => final_score_21_c345,
                                                              0.0098439478));

final_score_21_c347 := __common__( map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -14311 => 0.1695156855,
    f_addrchangeincomediff_d > -14311                                      => 0.0304551711,
    f_addrchangeincomediff_d = NULL                                        => 0.1192925590,
                                                                              0.0551021784));

final_score_21_c346 := __common__( map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 292715.5 => -0.0351561586,
    r_a46_curr_avm_autoval_d > 292715.5                                      => final_score_21_c347,
    r_a46_curr_avm_autoval_d = NULL                                          => -0.0197535818,
                                                                                -0.0217013109));

final_score_21 := __common__( map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 549 => final_score_21_c344,
    r_i60_inq_comm_recency_d > 549                                      => final_score_21_c346,
    r_i60_inq_comm_recency_d = NULL                                     => 0.0253736617,
                                                                           -0.0057453459));

final_score_22_c352 := __common__( map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 0.5 => 0.1551368461,
    f_rel_under500miles_cnt_d > 0.5                                       => 0.0160207885,
    f_rel_under500miles_cnt_d = NULL                                      => 0.0183848970,
                                                                             0.0180590542));

final_score_22_c351 := __common__( map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 75 => final_score_22_c352,
    f_curraddrburglaryindex_i > 75                                       => -0.0088506290,
    f_curraddrburglaryindex_i = NULL                                     => 0.0022449732,
                                                                            0.0022449732));

final_score_22_c350 := __common__( map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i <= 0.5 => final_score_22_c351,
    r_p85_phn_not_issued_i > 0.5                                    => 0.1110459346,
    r_p85_phn_not_issued_i = NULL                                   => 0.0034655114,
                                                                       0.0034655114));

final_score_22_c349 := __common__( map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 1.5 => -0.0290029326,
    f_idverrisktype_i > 1.5                               => final_score_22_c350,
    f_idverrisktype_i = NULL                              => -0.0107053756,
                                                             -0.0107053756));

final_score_22 := __common__( map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d <= 549 => 0.0310869466,
    r_i60_inq_prepaidcards_recency_d > 549                                              => final_score_22_c349,
    r_i60_inq_prepaidcards_recency_d = NULL                                             => -0.0010493901,
                                                                                           -0.0045119142));

final_score_23_c355 := __common__( map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 106 => 0.0037726486,
    f_prevaddrageoldest_d > 106                                   => 0.1509397050,
    f_prevaddrageoldest_d = NULL                                  => 0.0401073721,
                                                                     0.0401073721));

final_score_23_c357 := __common__( map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 1.5 => -0.0266181057,
    f_inq_other_count24_i > 1.5                                   => 0.0138584431,
    f_inq_other_count24_i = NULL                                  => -0.0190854304,
                                                                     -0.0190854304));

final_score_23_c356 := __common__( map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 3.5 => final_score_23_c357,
    f_addrchangeecontrajindex_d > 3.5                                         => 0.0175210563,
    f_addrchangeecontrajindex_d = NULL                                        => 0.0003092217,
                                                                                 -0.0119046657));

final_score_23_c354 := __common__( map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 0.5 => final_score_23_c355,
    f_rel_under25miles_cnt_d > 0.5                                      => final_score_23_c356,
    f_rel_under25miles_cnt_d = NULL                                     => 0.0334692394,
                                                                           -0.0089024638));

final_score_23 := __common__( map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d <= 549 => 0.0284638432,
    r_i60_inq_prepaidcards_recency_d > 549                                              => final_score_23_c354,
    r_i60_inq_prepaidcards_recency_d = NULL                                             => 0.0424950549,
                                                                                           -0.0031480267));

final_score_24_c362 := __common__( map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 1.5 => 0.1578184794,
    r_d30_derog_count_i > 1.5                                 => 0.0248800142,
    r_d30_derog_count_i = NULL                                => 0.0751737075,
                                                                 0.0751737075));

final_score_24_c361 := __common__( map(
    NULL < (Integer)k_nap_phn_verd_d AND (Real)k_nap_phn_verd_d <= 0.5 => final_score_24_c362,
    (Real)k_nap_phn_verd_d > 0.5                              => -0.0125059013,
    (Integer)k_nap_phn_verd_d = NULL                             => 0.0257756422,
                                                           0.0257756422));

final_score_24_c360 := __common__( map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 84500 => -0.0231083126,
    k_estimated_income_d > 84500                                  => final_score_24_c361,
    k_estimated_income_d = NULL                                   => -0.0192357684,
                                                                     -0.0192357684));

final_score_24_c359 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 33.5 => 0.0114663107,
    k_comb_age_d > 33.5                          => final_score_24_c360,
    k_comb_age_d = NULL                          => -0.0091524426,
                                                    -0.0091524426));

final_score_24 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 1.5 => final_score_24_c359,
    f_inq_communications_count24_i > 1.5                                            => 0.0273896350,
    f_inq_communications_count24_i = NULL                                           => -0.0060516277,
                                                                                       -0.0035376603));

final_score_25_c365 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 609957 => 0.0024203382,
    f_prevaddrmedianvalue_d > 609957                                     => 0.0801354083,
    f_prevaddrmedianvalue_d = NULL                                       => 0.0041813766,
                                                                            0.0041813766));

final_score_25_c367 := __common__( map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 0.5 => 0.0046746871,
    f_rel_incomeover100_count_d > 0.5                                         => 0.1315272999,
    f_rel_incomeover100_count_d = NULL                                        => 0.0394416995,
                                                                                 0.0394416995));

final_score_25_c366 := __common__( map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 105.45 => 0.0961256664,
    r_a49_curr_avm_chg_1yr_pct_i > 105.45                                          => final_score_25_c367,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                            => 0.0252537538,
                                                                                      0.0356956935));

final_score_25_c364 := __common__( map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i <= 0.5 => final_score_25_c365,
    r_l70_add_standardized_i > 0.5                                      => final_score_25_c366,
    r_l70_add_standardized_i = NULL                                     => 0.0108741809,
                                                                           0.0108741809));

final_score_25 := __common__( map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => final_score_25_c364,
    f_corrphonelastnamecount_d > 0.5                                        => -0.0187897768,
    f_corrphonelastnamecount_d = NULL                                       => 0.0024004121,
                                                                               -0.0028738692));

final_score_26_c370 := __common__( map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => 0.0411603955,
    r_phn_cell_n > 0.5                          => -0.0025675418,
    r_phn_cell_n = NULL                         => 0.0132366670,
                                                   0.0132366670));

final_score_26_c369 := __common__( map(
    NULL < f_corrssnaddrcount_d AND f_corrssnaddrcount_d <= 2.5 => final_score_26_c370,
    f_corrssnaddrcount_d > 2.5                                  => -0.0168870735,
    f_corrssnaddrcount_d = NULL                                 => -0.0105238128,
                                                                   -0.0105238128));

final_score_26_c372 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 7.5 => 0.0414522610,
    f_inq_communications_count24_i > 7.5                                            => 0.1888324763,
    f_inq_communications_count24_i = NULL                                           => 0.0478412637,
                                                                                       0.0478412637));

final_score_26_c371 := __common__( map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d <= 549 => final_score_26_c372,
    r_i60_inq_prepaidcards_recency_d > 549                                              => 0.0084923236,
    r_i60_inq_prepaidcards_recency_d = NULL                                             => 0.0170760562,
                                                                                           0.0170760562));

final_score_26 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 0.5 => final_score_26_c369,
    f_inq_communications_count24_i > 0.5                                            => final_score_26_c371,
    f_inq_communications_count24_i = NULL                                           => 0.0556852371,
                                                                                       -0.0034585083));

final_score_27_c375 := __common__( map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 30.5 => 0.0000098284,
    f_addrchangecrimediff_i > 30.5                                     => 0.0481366120,
    f_addrchangecrimediff_i = NULL                                     => 0.0094268088,
                                                                          0.0045249100));

final_score_27_c374 := __common__( map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 127126.5 => final_score_27_c375,
    f_curraddrmedianincome_d > 127126.5                                      => 0.1561253010,
    f_curraddrmedianincome_d = NULL                                          => 0.0056940316,
                                                                                0.0056940316));

final_score_27_c377 := __common__( map(
    NULL < r_c12_num_nonderogs_d AND r_c12_num_nonderogs_d <= 1.5 => 0.0514876458,
    r_c12_num_nonderogs_d > 1.5                                   => 0.0012729084,
    r_c12_num_nonderogs_d = NULL                                  => 0.0182052834,
                                                                     0.0182052834));

final_score_27_c376 := __common__( map(
    NULL < r_c16_inv_ssn_per_adl_i AND r_c16_inv_ssn_per_adl_i <= 0.5 => final_score_27_c377,
    r_c16_inv_ssn_per_adl_i > 0.5                                     => -0.0789372336,
    r_c16_inv_ssn_per_adl_i = NULL                                    => 0.0279971073,
                                                                         0.0097737834));

final_score_27 := __common__( map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_27_c374,
    f_phone_ver_experian_d > 0.5                                    => -0.0228875239,
    f_phone_ver_experian_d = NULL                                   => final_score_27_c376,
                                                                       -0.0059370319));

final_score_28_c381 := __common__( map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 1.5 => -0.0067722539,
    f_varrisktype_i > 1.5                             => 0.0207320216,
    f_varrisktype_i = NULL                            => 0.0055056865,
                                                         0.0055056865));

final_score_28_c380 := __common__( map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 549 => final_score_28_c381,
    r_i60_inq_comm_recency_d > 549                                      => -0.0190311502,
    r_i60_inq_comm_recency_d = NULL                                     => -0.0068730801,
                                                                           -0.0068730801));

final_score_28_c379 := __common__( map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => final_score_28_c380,
    f_validationrisktype_i > 1.5                                    => 0.0568916440,
    f_validationrisktype_i = NULL                                   => -0.0056363427,
                                                                       -0.0056363427));

final_score_28_c382 := __common__( map(
    NULL < (Integer)k_nap_phn_verd_d AND (Real)k_nap_phn_verd_d <= 0.5 => 0.0806813906,
    (Real)k_nap_phn_verd_d > 0.5                              => 0.0248314906,
    (Integer)k_nap_phn_verd_d = NULL                             => 0.0379507729,
                                                           0.0379507729));

final_score_28 := __common__( map(
    NULL < f_srchphonesrchcountmo_i AND f_srchphonesrchcountmo_i <= 0.5 => final_score_28_c379,
    f_srchphonesrchcountmo_i > 0.5                                      => final_score_28_c382,
    f_srchphonesrchcountmo_i = NULL                                     => 0.0066602879,
                                                                           -0.0019328282));

final_score_29_c385 := __common__( map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 12.5 => 0.0743785096,
    r_d32_mos_since_crim_ls_d > 12.5                                       => 0.0020585244,
    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0082721466,
                                                                              0.0082721466));

final_score_29_c384 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.88942351235 => final_score_29_c385,
    f_add_curr_nhood_mfd_pct_i > 0.88942351235                                        => 0.0348550410,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => 0.0081378653,
                                                                                         0.0130509664));

final_score_29_c387 := __common__( map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 0.5 => 0.1103593227,
    f_rel_under100miles_cnt_d > 0.5                                       => 0.0131865754,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0230478098,
                                                                             0.0230478098));

final_score_29_c386 := __common__( map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 3.5 => -0.0142934571,
    f_idverrisktype_i > 3.5                               => final_score_29_c387,
    f_idverrisktype_i = NULL                              => -0.0111607554,
                                                             -0.0111607554));

final_score_29 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 33.5 => final_score_29_c384,
    k_comb_age_d > 33.5                          => final_score_29_c386,
    k_comb_age_d = NULL                          => 0.0106974553,
                                                    -0.0031148416));

final_score_30_c390 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 5.5 => -0.0121511627,
    f_inq_communications_count24_i > 5.5                                            => 0.0550180279,
    f_inq_communications_count24_i = NULL                                           => -0.0110127019,
                                                                                       -0.0110127019));

final_score_30_c389 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 93542 => final_score_30_c390,
    f_addrchangevaluediff_d > 93542                                     => 0.0427461947,
    f_addrchangevaluediff_d = NULL                                      => -0.0060274014,
                                                                           -0.0084747099));

final_score_30_c392 := __common__( map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => 0.0161708241,
    f_srchunvrfdaddrcount_i > 0.5                                     => 0.0908846619,
    f_srchunvrfdaddrcount_i = NULL                                    => 0.0208965706,
                                                                         0.0208965706));

final_score_30_c391 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.16957210365 => 0.1028593752,
    f_add_input_mobility_index_i > 0.16957210365                                          => final_score_30_c392,
    f_add_input_mobility_index_i = NULL                                                   => 0.0273974412,
                                                                                             0.0273974412));

final_score_30 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 354471 => final_score_30_c389,
    f_prevaddrmedianvalue_d > 354471                                     => final_score_30_c391,
    f_prevaddrmedianvalue_d = NULL                                       => 0.0038503359,
                                                                            -0.0029842569));

final_score_31_c394 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 31.5 => 0.0103657161,
    k_comb_age_d > 31.5                          => -0.0174038594,
    k_comb_age_d = NULL                          => -0.0101489007,
                                                    -0.0101489007));

final_score_31_c396 := __common__( map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => 0.1067574398,
    f_phone_ver_insurance_d > 3.5                                     => -0.0448651477,
    f_phone_ver_insurance_d = NULL                                    => 0.0593409215,
                                                                         0.0593409215));

final_score_31_c397 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 101044.5 => 0.0085510434,
    f_prevaddrmedianincome_d > 101044.5                                      => 0.1023721794,
    f_prevaddrmedianincome_d = NULL                                          => 0.0109826624,
                                                                                0.0109826624));

final_score_31_c395 := __common__( map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 0.5 => final_score_31_c396,
    f_rel_under100miles_cnt_d > 0.5                                       => final_score_31_c397,
    f_rel_under100miles_cnt_d = NULL                                      => -0.0014228785,
                                                                             0.0123816756));

final_score_31 := __common__( map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 2.5 => final_score_31_c394,
    f_idverrisktype_i > 2.5                               => final_score_31_c395,
    f_idverrisktype_i = NULL                              => 0.0288497759,
                                                             -0.0035475363));

final_score_32_c402 := __common__( map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 100242.5 => 0.0347333654,
    f_curraddrmedianincome_d > 100242.5                                      => 0.1851704252,
    f_curraddrmedianincome_d = NULL                                          => 0.0450474566,
                                                                                0.0450474566));

final_score_32_c401 := __common__( map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 113.5 => 0.0087034785,
    f_prevaddrageoldest_d > 113.5                                   => final_score_32_c402,
    f_prevaddrageoldest_d = NULL                                    => 0.0204716586,
                                                                       0.0204716586));

final_score_32_c400 := __common__( map(
    NULL < r_d32_felony_count_i AND r_d32_felony_count_i <= 0.5 => final_score_32_c401,
    r_d32_felony_count_i > 0.5                                  => 0.1133678934,
    r_d32_felony_count_i = NULL                                 => 0.0234567099,
                                                                   0.0234567099));

final_score_32_c399 := __common__( map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_32_c400,
    f_phone_ver_insurance_d > 3.5                                     => -0.0062239243,
    f_phone_ver_insurance_d = NULL                                    => 0.0093425891,
                                                                         0.0093425891));

final_score_32 := __common__( map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 78 => final_score_32_c399,
    f_fp_prevaddrburglaryindex_i > 78                                          => -0.0106877386,
    f_fp_prevaddrburglaryindex_i = NULL                                        => 0.0026947443,
                                                                                  -0.0027415252));

final_score_33_c405 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 410660 => -0.0107695071,
    f_prevaddrmedianvalue_d > 410660                                     => 0.0206745440,
    f_prevaddrmedianvalue_d = NULL                                       => -0.0075949065,
                                                                            -0.0075949065));

final_score_33_c404 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 8.5 => final_score_33_c405,
    f_inq_communications_count24_i > 8.5                                            => 0.0996174557,
    f_inq_communications_count24_i = NULL                                           => -0.0070743238,
                                                                                       -0.0070743238));

final_score_33_c406 := __common__( map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 144.5 => 0.0213932292,
    r_c13_curr_addr_lres_d > 144.5                                    => 0.1076188598,
    r_c13_curr_addr_lres_d = NULL                                     => 0.0358246005,
                                                                         0.0358246005));

final_score_33_c407 := __common__( map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 4.5 => 0.0000511885,
    f_srchcomponentrisktype_i > 4.5                                       => 0.1446604717,
    f_srchcomponentrisktype_i = NULL                                      => 0.0407820220,
                                                                             0.0042221960));

final_score_33 := __common__( map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 27.5 => final_score_33_c404,
    f_addrchangecrimediff_i > 27.5                                     => final_score_33_c406,
    f_addrchangecrimediff_i = NULL                                     => final_score_33_c407,
                                                                          -0.0030360121));

final_score_34_c412 := __common__( map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 73.5 => 0.0328473699,
    f_prevaddrageoldest_d > 73.5                                   => 0.1073774466,
    f_prevaddrageoldest_d = NULL                                   => 0.0684008616,
                                                                      0.0684008616));

final_score_34_c411 := __common__( map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => final_score_34_c412,
    r_phn_pcs_n > 0.5                         => 0.0159376592,
    r_phn_pcs_n = NULL                        => 0.0361367240,
                                                 0.0361367240));

final_score_34_c410 := __common__( map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_34_c411,
    r_phn_cell_n > 0.5                          => 0.0048235962,
    r_phn_cell_n = NULL                         => 0.0163729602,
                                                   0.0163729602));

final_score_34_c409 := __common__( map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 602 => -0.0046045527,
    r_p88_phn_dst_to_inp_add_i > 602                                        => -0.0268564729,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => final_score_34_c410,
                                                                               0.0026430689));

final_score_34 := __common__( map(
		r_d31_bk_chapter_n = ''                            => final_score_34_c409,
    NULL < (Integer)r_d31_bk_chapter_n AND (Integer)r_d31_bk_chapter_n <= 12 => -0.0298488303,
    (Integer)r_d31_bk_chapter_n > 12                                => -0.0375895593,
    
                                                              -0.0054950459));

final_score_35_c414 := __common__( map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d <= 549 => 0.0363392580,
    r_i60_inq_prepaidcards_recency_d > 549                                              => 0.0054906477,
    r_i60_inq_prepaidcards_recency_d = NULL                                             => 0.0119324330,
                                                                                           0.0119324330));

final_score_35_c417 := __common__( map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 7.5 => -0.0148605023,
    f_corrrisktype_i > 7.5                              => 0.1070186993,
    f_corrrisktype_i = NULL                             => 0.0698036759,
                                                           0.0698036759));

final_score_35_c416 := __common__( map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_35_c417,
    r_phn_cell_n > 0.5                          => 0.0010942909,
    r_phn_cell_n = NULL                         => 0.0257318715,
                                                   0.0257318715));

final_score_35_c415 := __common__( map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 25 => final_score_35_c416,
    r_f01_inp_addr_address_score_d > 25                                            => -0.0232238952,
    r_f01_inp_addr_address_score_d = NULL                                          => -0.0188863430,
                                                                                      -0.0188863430));

final_score_35 := __common__( map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 549 => final_score_35_c414,
    r_i60_inq_comm_recency_d > 549                                      => final_score_35_c415,
    r_i60_inq_comm_recency_d = NULL                                     => -0.0018742490,
                                                                           -0.0033888842));

final_score_36_c422 := __common__( map(
    NULL < r_c19_add_prison_hist_i AND r_c19_add_prison_hist_i <= 0.5 => 0.0104510961,
    r_c19_add_prison_hist_i > 0.5                                     => 0.1464195224,
    r_c19_add_prison_hist_i = NULL                                    => 0.0118791877,
                                                                         0.0118791877));

final_score_36_c421 := __common__( map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 358.5 => -0.0092316317,
    r_pb_order_freq_d > 358.5                               => -0.0330123856,
    r_pb_order_freq_d = NULL                                => final_score_36_c422,
                                                               -0.0025129526));

final_score_36_c420 := __common__( map(
    NULL < r_c16_inv_ssn_per_adl_i AND r_c16_inv_ssn_per_adl_i <= 0.5 => final_score_36_c421,
    r_c16_inv_ssn_per_adl_i > 0.5                                     => -0.0594663866,
    r_c16_inv_ssn_per_adl_i = NULL                                    => -0.0037974199,
                                                                         -0.0037974199));

final_score_36_c419 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.9948559453 => final_score_36_c420,
    f_add_curr_nhood_mfd_pct_i > 0.9948559453                                        => 0.0454514204,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => -0.0132090096,
                                                                                        -0.0035885049));

final_score_36 := __common__( map(
    NULL < f_srchfraudsrchcountwk_i AND f_srchfraudsrchcountwk_i <= 0.5 => final_score_36_c419,
    f_srchfraudsrchcountwk_i > 0.5                                      => 0.0618242679,
    f_srchfraudsrchcountwk_i = NULL                                     => -0.0076302437,
                                                                           -0.0018248346));

final_score_37_c426 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.60301837745 => 0.0116356831,
    f_add_curr_nhood_mfd_pct_i > 0.60301837745                                        => 0.0315081639,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => -0.0591140109,
                                                                                         0.0171184385));

final_score_37_c425 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 23067.5 => final_score_37_c426,
    f_prevaddrmedianincome_d > 23067.5                                      => -0.0072636573,
    f_prevaddrmedianincome_d = NULL                                         => -0.0046695758,
                                                                               -0.0046695758));

final_score_37_c427 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 440910.5 => 0.0455653665,
    f_prevaddrmedianvalue_d > 440910.5                                     => 0.1808378027,
    f_prevaddrmedianvalue_d = NULL                                         => 0.0551140090,
                                                                              0.0551140090));

final_score_37_c424 := __common__( map(
    NULL < r_d32_felony_count_i AND r_d32_felony_count_i <= 0.5 => final_score_37_c425,
    r_d32_felony_count_i > 0.5                                  => final_score_37_c427,
    r_d32_felony_count_i = NULL                                 => -0.0027940604,
                                                                   -0.0027940604));

final_score_37 := __common__( map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 6.5 => final_score_37_c424,
    f_varrisktype_i > 6.5                             => 0.0747363980,
    f_varrisktype_i = NULL                            => -0.0246232193,
                                                         -0.0012761265));

final_score_38_c429 := __common__( map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 7.5 => -0.0034086318,
    f_varrisktype_i > 7.5                             => 0.1333096594,
    f_varrisktype_i = NULL                            => -0.0018645509,
                                                         -0.0018645509));

final_score_38_c430 := __common__( map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 114500 => -0.0156311637,
    k_estimated_income_d > 114500                                  => 0.1667420028,
    k_estimated_income_d = NULL                                    => -0.0141167958,
                                                                      -0.0141167958));

final_score_38_c432 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.4028961333 => 0.0042434046,
    f_add_curr_nhood_mfd_pct_i > 0.4028961333                                        => 0.0273749358,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => 0.0166673876,
                                                                                        0.0150754810));

final_score_38_c431 := __common__( map(
    NULL < r_c16_inv_ssn_per_adl_i AND r_c16_inv_ssn_per_adl_i <= 0.5 => final_score_38_c432,
    r_c16_inv_ssn_per_adl_i > 0.5                                     => -0.0456175558,
    r_c16_inv_ssn_per_adl_i = NULL                                    => 0.0112814110,
                                                                         0.0119996827));

final_score_38 := __common__( map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 6.5 => final_score_38_c429,
    r_pb_order_freq_d > 6.5                               => final_score_38_c430,
    r_pb_order_freq_d = NULL                              => final_score_38_c431,
                                                             -0.0004671056));

final_score_39_c437 := __common__( map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 5.5 => -0.0122737793,
    r_wealth_index_d > 5.5                              => 0.1348781468,
    r_wealth_index_d = NULL                             => -0.0112650577,
                                                           -0.0112650577));

final_score_39_c436 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 89343.5 => final_score_39_c437,
    f_addrchangevaluediff_d > 89343.5                                     => 0.0402436070,
    f_addrchangevaluediff_d = NULL                                        => -0.0053014246,
                                                                             -0.0086877500));

final_score_39_c435 := __common__( map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 1.5 => final_score_39_c436,
    f_inq_other_count24_i > 1.5                                   => 0.0178048039,
    f_inq_other_count24_i = NULL                                  => -0.0034379048,
                                                                     -0.0034379048));

final_score_39_c434 := __common__( map(
    NULL < f_idrisktype_i AND f_idrisktype_i <= 4.5 => final_score_39_c435,
    f_idrisktype_i > 4.5                            => 0.1296322084,
    f_idrisktype_i = NULL                           => 0.0077386297,
                                                       -0.0029780122));

final_score_39 := __common__( map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i <= 0.5 => final_score_39_c434,
    r_p85_phn_not_issued_i > 0.5                                    => 0.0870589330,
    r_p85_phn_not_issued_i = NULL                                   => -0.0023746104,
                                                                       -0.0023746104));

final_score_40_c440 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 275621 => -0.0195149482,
    f_addrchangevaluediff_d > 275621                                     => 0.0689277889,
    f_addrchangevaluediff_d = NULL                                       => -0.0065887962,
                                                                            -0.0166481485));

final_score_40_c441 := __common__( map(
    NULL < r_c19_add_prison_hist_i AND r_c19_add_prison_hist_i <= 0.5 => 0.0060629471,
    r_c19_add_prison_hist_i > 0.5                                     => 0.1215789022,
    r_c19_add_prison_hist_i = NULL                                    => 0.0072002350,
                                                                         0.0072002350));

final_score_40_c439 := __common__( map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 210.5 => final_score_40_c440,
    r_pb_order_freq_d > 210.5                               => 0.0021655508,
    r_pb_order_freq_d = NULL                                => final_score_40_c441,
                                                               -0.0061645435));

final_score_40_c442 := __common__( map(
    NULL < f_srchunvrfdssncount_i AND f_srchunvrfdssncount_i <= 1.5 => 0.0313135418,
    f_srchunvrfdssncount_i > 1.5                                    => 0.1506902196,
    f_srchunvrfdssncount_i = NULL                                   => 0.0355397266,
                                                                       0.0355397266));

final_score_40 := __common__( map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 1.5 => final_score_40_c439,
    f_srchunvrfdphonecount_i > 1.5                                      => final_score_40_c442,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0224198412,
                                                                           -0.0023855288));

final_score_41_c445 := __common__( map(
    NULL < f_srchphonesrchcountmo_i AND f_srchphonesrchcountmo_i <= 2.5 => 0.0114950434,
    f_srchphonesrchcountmo_i > 2.5                                      => 0.1480808667,
    f_srchphonesrchcountmo_i = NULL                                     => 0.0122643742,
                                                                           0.0122643742));

final_score_41_c444 := __common__( map(
    NULL < r_i60_inq_auto_count12_i AND r_i60_inq_auto_count12_i <= 1.5 => final_score_41_c445,
    r_i60_inq_auto_count12_i > 1.5                                      => -0.0305119510,
    r_i60_inq_auto_count12_i = NULL                                     => 0.0068934285,
                                                                           0.0068934285));

final_score_41_c447 := __common__( map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 104500 => -0.0158901878,
    k_estimated_income_d > 104500                                  => 0.0759759156,
    k_estimated_income_d = NULL                                    => -0.0143906893,
                                                                      -0.0143906893));

final_score_41_c446 := __common__( map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i <= 0.5 => final_score_41_c447,
    r_p85_phn_not_issued_i > 0.5                                    => 0.1013217182,
    r_p85_phn_not_issued_i = NULL                                   => -0.0135080698,
                                                                       -0.0135080698));

final_score_41 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 41.5 => final_score_41_c444,
    k_comb_age_d > 41.5                          => final_score_41_c446,
    k_comb_age_d = NULL                          => -0.0019088934,
                                                    -0.0026861680));

final_score_42_c452 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 147.5 => 0.0252669693,
    r_c13_max_lres_d > 147.5                              => 0.1796945268,
    r_c13_max_lres_d = NULL                               => 0.0962538304,
                                                             0.0962538304));

final_score_42_c451 := __common__( map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => final_score_42_c452,
    f_hh_lienholders_i > 0.5                                => 0.0109098448,
    f_hh_lienholders_i = NULL                               => 0.0310162176,
                                                               0.0310162176));

final_score_42_c450 := __common__( map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 4.5 => -0.0066776162,
    r_wealth_index_d > 4.5                              => final_score_42_c451,
    r_wealth_index_d = NULL                             => -0.0039512837,
                                                           -0.0039512837));

final_score_42_c449 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 78.5 => final_score_42_c450,
    k_comb_age_d > 78.5                          => 0.1199745561,
    k_comb_age_d = NULL                          => -0.0033749633,
                                                    -0.0033749633));

final_score_42 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 23921.5 => 0.0245409775,
    f_prevaddrmedianincome_d > 23921.5                                      => final_score_42_c449,
    f_prevaddrmedianincome_d = NULL                                         => 0.0231374121,
                                                                               -0.0000122720));

final_score_43_c457 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.3635112086 => 0.0475877074,
    f_add_curr_nhood_mfd_pct_i > 0.3635112086                                        => 0.1011601719,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => -0.0200186143,
                                                                                        0.0554650410));

final_score_43_c456 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.171112287 => final_score_43_c457,
    f_add_input_mobility_index_i > 0.171112287                                          => 0.0134556222,
    f_add_input_mobility_index_i = NULL                                                 => -0.0226291729,
                                                                                           0.0157606748));

final_score_43_c455 := __common__( map(
		r_d31_bk_chapter_n = ''                              => final_score_43_c456,
    NULL < (Integer)r_d31_bk_chapter_n AND (Integer)r_d31_bk_chapter_n <= 10 => -0.0211483752,
    (Integer)r_d31_bk_chapter_n > 10                                => -0.0089574072,
    
                                                              0.0096492560));

final_score_43_c454 := __common__( map(
    NULL < r_c16_inv_ssn_per_adl_i AND r_c16_inv_ssn_per_adl_i <= 0.5 => final_score_43_c455,
    r_c16_inv_ssn_per_adl_i > 0.5                                     => -0.0493779716,
    r_c16_inv_ssn_per_adl_i = NULL                                    => 0.0077868104,
                                                                         0.0077868104));

final_score_43 := __common__( map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => final_score_43_c454,
    f_corrphonelastnamecount_d > 0.5                                        => -0.0139214337,
    f_corrphonelastnamecount_d = NULL                                       => -0.0068850299,
                                                                               -0.0022156128));

final_score_44_c461 := __common__( map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 64.5 => 0.0688708009,
    f_phones_per_addr_curr_i > 64.5                                      => -0.0056430298,
    f_phones_per_addr_curr_i = NULL                                      => 0.0539849505,
                                                                            0.0539849505));

final_score_44_c462 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.93638440515 => 0.0271403888,
    f_add_input_nhood_mfd_pct_i > 0.93638440515                                         => -0.0181517614,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => 0.0727178056,
                                                                                           0.0176962323));

final_score_44_c460 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 24545.5 => final_score_44_c461,
    f_prevaddrmedianincome_d > 24545.5                                      => final_score_44_c462,
    f_prevaddrmedianincome_d = NULL                                         => 0.0270689560,
                                                                               0.0270689560));

final_score_44_c459 := __common__( map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 110.5 => 0.0018117434,
    f_prevaddrcartheftindex_i > 110.5                                       => final_score_44_c460,
    f_prevaddrcartheftindex_i = NULL                                        => 0.0108890116,
                                                                               0.0108890116));

final_score_44 := __common__( map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 75 => final_score_44_c459,
    f_curraddrburglaryindex_i > 75                                       => -0.0069055475,
    f_curraddrburglaryindex_i = NULL                                     => 0.0302184633,
                                                                            -0.0000495191));

final_score_45_c466 := __common__( map(
    NULL < r_c16_inv_ssn_per_adl_i AND r_c16_inv_ssn_per_adl_i <= 0.5 => 0.0058312349,
    r_c16_inv_ssn_per_adl_i > 0.5                                     => -0.0473423137,
    r_c16_inv_ssn_per_adl_i = NULL                                    => 0.0043240939,
                                                                         0.0043240939));

final_score_45_c465 := __common__( map(
    NULL < r_i60_inq_count12_i AND r_i60_inq_count12_i <= 16.5 => final_score_45_c466,
    r_i60_inq_count12_i > 16.5                                 => 0.1593017531,
    r_i60_inq_count12_i = NULL                                 => 0.0049014632,
                                                                  0.0049014632));

final_score_45_c464 := __common__( map(
    NULL < r_d31_mostrec_bk_i AND r_d31_mostrec_bk_i <= 1.5 => final_score_45_c465,
    r_d31_mostrec_bk_i > 1.5                                => -0.0292347095,
    r_d31_mostrec_bk_i = NULL                               => -0.0014928905,
                                                               -0.0014928905));

final_score_45_c467 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.00697497645 => 0.1021813149,
    f_add_input_nhood_sfd_pct_d > 0.00697497645                                         => 0.0315132132,
    f_add_input_nhood_sfd_pct_d = NULL                                                  => 0.0364482302,
                                                                                           0.0364482302));

final_score_45 := __common__( map(
    NULL < f_srchphonesrchcountmo_i AND f_srchphonesrchcountmo_i <= 0.5 => final_score_45_c464,
    f_srchphonesrchcountmo_i > 0.5                                      => final_score_45_c467,
    f_srchphonesrchcountmo_i = NULL                                     => 0.0198588543,
                                                                           0.0017580633));

final_score_46_c469 := __common__( map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => -0.0053974308,
    f_hh_lienholders_i > 0.5                                => 0.0228964407,
    f_hh_lienholders_i = NULL                               => 0.0114903548,
                                                               0.0114903548));

final_score_46_c471 := __common__( map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= -72770 => 0.1209738845,
    r_a49_curr_avm_chg_1yr_i > -72770                                      => -0.0053307216,
    r_a49_curr_avm_chg_1yr_i = NULL                                        => -0.0141606002,
                                                                              -0.0102989086));

final_score_46_c472 := __common__( map(
    NULL < r_c12_num_nonderogs_d AND r_c12_num_nonderogs_d <= 2.5 => 0.1068708096,
    r_c12_num_nonderogs_d > 2.5                                   => 0.0163654381,
    r_c12_num_nonderogs_d = NULL                                  => 0.0391218175,
                                                                     0.0391218175));

final_score_46_c470 := __common__( map(
    NULL < r_d32_felony_count_i AND r_d32_felony_count_i <= 0.5 => final_score_46_c471,
    r_d32_felony_count_i > 0.5                                  => final_score_46_c472,
    r_d32_felony_count_i = NULL                                 => -0.0082392184,
                                                                   -0.0082392184));

final_score_46 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 33.5 => final_score_46_c469,
    k_comb_age_d > 33.5                          => final_score_46_c470,
    k_comb_age_d = NULL                          => -0.0109421060,
                                                    -0.0017785511));

final_score_47_c476 := __common__( map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 139.5 => 0.0898987030,
    r_d32_mos_since_fel_ls_d > 139.5                                      => -0.0084238927,
    r_d32_mos_since_fel_ls_d = NULL                                       => -0.0075075921,
                                                                             -0.0075075921));

final_score_47_c475 := __common__( map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 131134.5 => final_score_47_c476,
    f_curraddrmedianincome_d > 131134.5                                      => 0.1137689950,
    f_curraddrmedianincome_d = NULL                                          => -0.0068863618,
                                                                                -0.0068863618));

final_score_47_c477 := __common__( map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 6.5 => 0.0271192818,
    f_varrisktype_i > 6.5                             => 0.1809596708,
    f_varrisktype_i = NULL                            => 0.0327554763,
                                                         0.0327554763));

final_score_47_c474 := __common__( map(
    NULL < f_srchphonesrchcountmo_i AND f_srchphonesrchcountmo_i <= 0.5 => final_score_47_c475,
    f_srchphonesrchcountmo_i > 0.5                                      => final_score_47_c477,
    f_srchphonesrchcountmo_i = NULL                                     => -0.0037710713,
                                                                           -0.0037710713));

final_score_47 := __common__( map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d <= 549 => 0.0227733723,
    r_i60_inq_prepaidcards_recency_d > 549                                              => final_score_47_c474,
    r_i60_inq_prepaidcards_recency_d = NULL                                             => -0.0011272883,
                                                                                           0.0001833927));

final_score_48_c481 := __common__( map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.2000617665 => 0.0236905442,
    f_add_curr_nhood_bus_pct_i > 0.2000617665                                        => 0.1221424361,
    f_add_curr_nhood_bus_pct_i = NULL                                                => 0.0133920261,
                                                                                        0.0296905944));

final_score_48_c480 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.06538116035 => 0.0032185513,
    f_add_input_nhood_bus_pct_i > 0.06538116035                                         => final_score_48_c481,
    f_add_input_nhood_bus_pct_i = NULL                                                  => -0.0281755061,
                                                                                           0.0109482626));

final_score_48_c479 := __common__( map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 2.5 => -0.0079255347,
    f_idverrisktype_i > 2.5                               => final_score_48_c480,
    f_idverrisktype_i = NULL                              => -0.0025456902,
                                                             -0.0025456902));

final_score_48_c482 := __common__( map(
    NULL < f_historical_count_d AND f_historical_count_d <= 1.5 => 0.0897409094,
    f_historical_count_d > 1.5                                  => 0.0133990070,
    f_historical_count_d = NULL                                 => 0.0435146975,
                                                                   0.0435146975));

final_score_48 := __common__( map(
    NULL < r_d32_felony_count_i AND r_d32_felony_count_i <= 0.5 => final_score_48_c479,
    r_d32_felony_count_i > 0.5                                  => final_score_48_c482,
    r_d32_felony_count_i = NULL                                 => 0.0093625480,
                                                                   -0.0009728156));

final_score_49_c485 := __common__( map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 0.5 => 0.1447135449,
    f_hh_members_w_derog_i > 0.5                                    => 0.0135937409,
    f_hh_members_w_derog_i = NULL                                   => 0.0286099508,
                                                                       0.0286099508));

final_score_49_c484 := __common__( map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 84500 => -0.0119877985,
    k_estimated_income_d > 84500                                  => final_score_49_c485,
    k_estimated_income_d = NULL                                   => -0.0091125024,
                                                                     -0.0091125024));

final_score_49_c487 := __common__( map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 5.5 => 0.0262984438,
    r_c14_addrs_5yr_i > 5.5                               => 0.2185215674,
    r_c14_addrs_5yr_i = NULL                              => 0.0300154655,
                                                             0.0300154655));

final_score_49_c486 := __common__( map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_49_c487,
    r_phn_cell_n > 0.5                          => 0.0015767380,
    r_phn_cell_n = NULL                         => 0.0120309846,
                                                   0.0120309846));

final_score_49 := __common__( map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 5.5 => final_score_49_c484,
    f_sourcerisktype_i > 5.5                                => final_score_49_c486,
    f_sourcerisktype_i = NULL                               => 0.0070296996,
                                                               -0.0023977561));

final_score_50_c491 := __common__( map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 23500 => 0.1502446774,
    k_estimated_income_d > 23500                                  => 0.0233941584,
    k_estimated_income_d = NULL                                   => 0.0286328229,
                                                                     0.0286328229));

final_score_50_c490 := __common__( map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_50_c491,
    f_phone_ver_experian_d > 0.5                                    => -0.0022452576,
    f_phone_ver_experian_d = NULL                                   => -0.0153659228,
                                                                       0.0110577901));

final_score_50_c492 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 0.5 => 0.0306355749,
    f_inq_communications_count24_i > 0.5                                            => 0.1190906541,
    f_inq_communications_count24_i = NULL                                           => 0.0628400940,
                                                                                       0.0628400940));

final_score_50_c489 := __common__( map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 1.5 => final_score_50_c490,
    f_rel_homeover500_count_d > 1.5                                       => final_score_50_c492,
    f_rel_homeover500_count_d = NULL                                      => 0.0128808405,
                                                                             0.0154098090));

final_score_50 := __common__( map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 1.5 => -0.0065545529,
    f_inq_other_count24_i > 1.5                                   => final_score_50_c489,
    f_inq_other_count24_i = NULL                                  => 0.0113180149,
                                                                     -0.0021627965));

final_score_51_c496 := __common__( map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 703 => -0.0118542515,
    r_pb_order_freq_d > 703                               => -0.0623928289,
    r_pb_order_freq_d = NULL                              => 0.0038883463,
                                                             -0.0064383019));

final_score_51_c495 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 84.5 => final_score_51_c496,
    k_comb_age_d > 84.5                          => 0.1290529319,
    k_comb_age_d = NULL                          => -0.0060880337,
                                                    -0.0060880337));

final_score_51_c497 := __common__( map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 6.5 => 0.0222317856,
    f_varrisktype_i > 6.5                             => 0.1338823564,
    f_varrisktype_i = NULL                            => 0.0272621960,
                                                         0.0272621960));

final_score_51_c494 := __common__( map(
    NULL < f_srchphonesrchcountmo_i AND f_srchphonesrchcountmo_i <= 0.5 => final_score_51_c495,
    f_srchphonesrchcountmo_i > 0.5                                      => final_score_51_c497,
    f_srchphonesrchcountmo_i = NULL                                     => -0.0035050550,
                                                                           -0.0035050550));

final_score_51 := __common__( map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 4.5 => 0.0277566100,
    r_i60_inq_comm_recency_d > 4.5                                      => final_score_51_c494,
    r_i60_inq_comm_recency_d = NULL                                     => -0.0233451889,
                                                                           -0.0018145189));

final_score_52_c499 := __common__( map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 29.1 => 0.1671501171,
    r_c12_source_profile_d > 29.1                                    => 0.0348766230,
    r_c12_source_profile_d = NULL                                    => 0.0470842745,
                                                                        0.0470842745));

final_score_52_c502 := __common__( map(
    NULL < f_srchunvrfdssncount_i AND f_srchunvrfdssncount_i <= 1.5 => -0.0078026842,
    f_srchunvrfdssncount_i > 1.5                                    => 0.0724784708,
    f_srchunvrfdssncount_i = NULL                                   => -0.0070679356,
                                                                       -0.0070679356));

final_score_52_c501 := __common__( map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 6.5 => final_score_52_c502,
    f_sourcerisktype_i > 6.5                                => 0.0158214737,
    f_sourcerisktype_i = NULL                               => -0.0040275392,
                                                               -0.0040275392));

final_score_52_c500 := __common__( map(
    NULL < r_c16_inv_ssn_per_adl_i AND r_c16_inv_ssn_per_adl_i <= 0.5 => final_score_52_c501,
    r_c16_inv_ssn_per_adl_i > 0.5                                     => -0.0587630022,
    r_c16_inv_ssn_per_adl_i = NULL                                    => -0.0052647825,
                                                                         -0.0052647825));

final_score_52 := __common__( map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 7.5 => final_score_52_c499,
    r_d32_mos_since_crim_ls_d > 7.5                                       => final_score_52_c500,
    r_d32_mos_since_crim_ls_d = NULL                                      => 0.0186622433,
                                                                             -0.0032808311));

final_score_53_c506 := __common__( map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 3.5 => 0.0563909619,
    f_addrchangeecontrajindex_d > 3.5                                         => 0.0771271934,
    f_addrchangeecontrajindex_d = NULL                                        => 0.0036969038,
                                                                                 0.0469339287));

final_score_53_c505 := __common__( map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_53_c506,
    f_phone_ver_insurance_d > 3.5                                     => 0.0031373057,
    f_phone_ver_insurance_d = NULL                                    => 0.0306514939,
                                                                         0.0306514939));

final_score_53_c504 := __common__( map(
    NULL < f_hh_members_ct_d AND f_hh_members_ct_d <= 3.5 => 0.0042494459,
    f_hh_members_ct_d > 3.5                               => final_score_53_c505,
    f_hh_members_ct_d = NULL                              => 0.0129925450,
                                                             0.0129925450));

final_score_53_c507 := __common__( map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 549 => 0.0058143262,
    r_i60_inq_comm_recency_d > 549                                      => -0.0180521143,
    r_i60_inq_comm_recency_d = NULL                                     => -0.0064105485,
                                                                           -0.0064105485));

final_score_53 := __common__( map(
    NULL < f_corrssnaddrcount_d AND f_corrssnaddrcount_d <= 2.5 => final_score_53_c504,
    f_corrssnaddrcount_d > 2.5                                  => final_score_53_c507,
    f_corrssnaddrcount_d = NULL                                 => 0.0001765505,
                                                                   -0.0021172256));

final_score_54_c512 := __common__( map(
    NULL < f_divaddrsuspidcountnew_i AND f_divaddrsuspidcountnew_i <= 5.5 => -0.0084116584,
    f_divaddrsuspidcountnew_i > 5.5                                       => 0.0447873489,
    f_divaddrsuspidcountnew_i = NULL                                      => -0.0065050451,
                                                                             -0.0065050451));

final_score_54_c511 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.06111790275 => final_score_54_c512,
    f_add_input_nhood_bus_pct_i > 0.06111790275                                         => 0.0169192326,
    f_add_input_nhood_bus_pct_i = NULL                                                  => -0.0095596953,
                                                                                           0.0011431136));

final_score_54_c510 := __common__( map(
    NULL < f_hh_age_65_plus_d AND f_hh_age_65_plus_d <= 1.5 => final_score_54_c511,
    f_hh_age_65_plus_d > 1.5                                => 0.0488511783,
    f_hh_age_65_plus_d = NULL                               => 0.0045589245,
                                                               0.0045589245));

final_score_54_c509 := __common__( map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 100500 => final_score_54_c510,
    k_estimated_income_d > 100500                                  => 0.0777102646,
    k_estimated_income_d = NULL                                    => 0.0057804427,
                                                                      0.0057804427));

final_score_54 := __common__( map(
    NULL < r_i60_inq_auto_recency_d AND r_i60_inq_auto_recency_d <= 549 => -0.0163120021,
    r_i60_inq_auto_recency_d > 549                                      => final_score_54_c509,
    r_i60_inq_auto_recency_d = NULL                                     => -0.0317534624,
                                                                           -0.0038319747));

final_score_55_c515 := __common__( map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 255965.5 => -0.0074760593,
    r_a46_curr_avm_autoval_d > 255965.5                                      => 0.0284891400,
    r_a46_curr_avm_autoval_d = NULL                                          => -0.0035117932,
                                                                                -0.0029716410));

final_score_55_c516 := __common__( map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 235.5 => 0.1944635192,
    r_d32_mos_since_fel_ls_d > 235.5                                      => 0.0242431373,
    r_d32_mos_since_fel_ls_d = NULL                                       => 0.0285810675,
                                                                             0.0285810675));

final_score_55_c514 := __common__( map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 1.5 => final_score_55_c515,
    f_srchunvrfdphonecount_i > 1.5                                      => final_score_55_c516,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0003521507,
                                                                           -0.0003521507));

final_score_55_c517 := __common__( map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 128.5 => 0.0182358651,
    f_prevaddrageoldest_d > 128.5                                   => 0.0754457693,
    f_prevaddrageoldest_d = NULL                                    => 0.0297232507,
                                                                       0.0297232507));

final_score_55 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 3.5 => final_score_55_c514,
    f_inq_communications_count24_i > 3.5                                            => final_score_55_c517,
    f_inq_communications_count24_i = NULL                                           => -0.0098289185,
                                                                                       0.0011437175));

final_score_56_c521 := __common__( map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i <= 39093.5 => -0.0025632473,
    f_liens_unrel_cj_total_amt_i > 39093.5                                          => 0.1463685644,
    f_liens_unrel_cj_total_amt_i = NULL                                             => -0.0017043370,
                                                                                       -0.0017043370));

final_score_56_c522 := __common__( map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 25.5 => 0.0289300798,
    r_l79_adls_per_addr_curr_i > 25.5                                        => 0.1204389919,
    r_l79_adls_per_addr_curr_i = NULL                                        => 0.0319947425,
                                                                                0.0319947425));

final_score_56_c520 := __common__( map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 2.5 => final_score_56_c521,
    f_srchfraudsrchcountyr_i > 2.5                                      => final_score_56_c522,
    f_srchfraudsrchcountyr_i = NULL                                     => 0.0014694317,
                                                                           0.0014694317));

final_score_56_c519 := __common__( map(
    NULL < f_inq_auto_count24_i AND f_inq_auto_count24_i <= 1.5 => final_score_56_c520,
    f_inq_auto_count24_i > 1.5                                  => -0.0250766835,
    f_inq_auto_count24_i = NULL                                 => 0.0056999607,
                                                                   -0.0033480682));

final_score_56 := __common__( map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 3.5 => final_score_56_c519,
    k_inq_adls_per_phone_i > 3.5                                    => 0.1319786630,
    k_inq_adls_per_phone_i = NULL                                   => -0.0030222676,
                                                                       -0.0030222676));

final_score_57_c526 := __common__( map(
    NULL < f_divssnidmsrcurelcount_i AND f_divssnidmsrcurelcount_i <= 0.5 => -0.0519216806,
    f_divssnidmsrcurelcount_i > 0.5                                       => 0.0640231789,
    f_divssnidmsrcurelcount_i = NULL                                      => 0.0550091731,
                                                                             0.0550091731));

final_score_57_c525 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.0151879637 => 0.0167504102,
    f_add_input_nhood_bus_pct_i > 0.0151879637                                         => final_score_57_c526,
    f_add_input_nhood_bus_pct_i = NULL                                                 => -0.0526035282,
                                                                                          0.0355102120));

final_score_57_c524 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.87556306305 => 0.0056083060,
    f_add_curr_nhood_mfd_pct_i > 0.87556306305                                        => final_score_57_c525,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => -0.0138664160,
                                                                                         0.0158590035));

final_score_57_c527 := __common__( map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => -0.0049060801,
    f_srchunvrfdaddrcount_i > 0.5                                     => 0.0273624132,
    f_srchunvrfdaddrcount_i = NULL                                    => -0.0030618714,
                                                                         -0.0030618714));

final_score_57 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 23992.5 => final_score_57_c524,
    f_prevaddrmedianincome_d > 23992.5                                      => final_score_57_c527,
    f_prevaddrmedianincome_d = NULL                                         => -0.0337706525,
                                                                               -0.0008459631));

final_score_58_c530 := __common__( map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 90 => 0.0038139977,
    f_curraddrburglaryindex_i > 90                                       => -0.0157321968,
    f_curraddrburglaryindex_i = NULL                                     => -0.0063560919,
                                                                            -0.0063560919));

final_score_58_c529 := __common__( map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 5.5 => final_score_58_c530,
    r_d32_criminal_count_i > 5.5                                    => 0.0243233333,
    r_d32_criminal_count_i = NULL                                   => -0.0031704612,
                                                                       -0.0031704612));

final_score_58_c532 := __common__( map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.1707156610,
    f_phone_ver_experian_d > 0.5                                    => 0.0133435291,
    f_phone_ver_experian_d = NULL                                   => 0.1036128231,
                                                                       0.1036128231));

final_score_58_c531 := __common__( map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 67500 => 0.0247215584,
    k_estimated_income_d > 67500                                  => final_score_58_c532,
    k_estimated_income_d = NULL                                   => 0.0430307939,
                                                                     0.0430307939));

final_score_58 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 351.5 => final_score_58_c529,
    r_c13_max_lres_d > 351.5                              => final_score_58_c531,
    r_c13_max_lres_d = NULL                               => -0.0106455938,
                                                             -0.0015624374));

final_score_59_c535 := __common__( map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 4.5 => 0.1047418580,
    r_i60_inq_hiriskcred_recency_d > 4.5                                            => 0.0152452816,
    r_i60_inq_hiriskcred_recency_d = NULL                                           => 0.0237258040,
                                                                                       0.0237258040));

final_score_59_c534 := __common__( map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 18.5 => final_score_59_c535,
    f_rel_ageover40_count_d > 18.5                                     => 0.1774540677,
    f_rel_ageover40_count_d = NULL                                     => 0.0268829405,
                                                                          0.0268829405));

final_score_59_c537 := __common__( map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 5.5 => -0.0042657545,
    k_inq_per_phone_i > 5.5                               => 0.0487046998,
    k_inq_per_phone_i = NULL                              => -0.0027918939,
                                                             -0.0027918939));

final_score_59_c536 := __common__( map(
    NULL < f_divaddrsuspidcountnew_i AND f_divaddrsuspidcountnew_i <= 8.5 => final_score_59_c537,
    f_divaddrsuspidcountnew_i > 8.5                                       => 0.0596156613,
    f_divaddrsuspidcountnew_i = NULL                                      => -0.0022837891,
                                                                             -0.0022837891));

final_score_59 := __common__( map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 25.5 => final_score_59_c534,
    r_d32_mos_since_crim_ls_d > 25.5                                       => final_score_59_c536,
    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0051881823,
                                                                              0.0007045382));

final_score_60_c541 := __common__( map(
    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d <= 79.5 => 0.1616842840,
    f_attr_arrest_recency_d > 79.5                                     => -0.0102227201,
    f_attr_arrest_recency_d = NULL                                     => -0.0096759834,
                                                                          -0.0096759834));

final_score_60_c542 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.531623698 => 0.1420445256,
    f_add_input_nhood_mfd_pct_i > 0.531623698                                         => 0.0299928601,
    f_add_input_nhood_mfd_pct_i = NULL                                                => 0.0453113156,
                                                                                         0.0453113156));

final_score_60_c540 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 612784 => final_score_60_c541,
    f_prevaddrmedianvalue_d > 612784                                     => final_score_60_c542,
    f_prevaddrmedianvalue_d = NULL                                       => -0.0085011650,
                                                                            -0.0085011650));

final_score_60_c539 := __common__( map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 9 => 0.0238042373,
    r_i60_inq_hiriskcred_recency_d > 9                                            => final_score_60_c540,
    r_i60_inq_hiriskcred_recency_d = NULL                                         => -0.0051663941,
                                                                                     -0.0051663941));

final_score_60 := __common__( map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d <= 549 => 0.0174180290,
    r_i60_inq_prepaidcards_recency_d > 549                                              => final_score_60_c539,
    r_i60_inq_prepaidcards_recency_d = NULL                                             => -0.0108960171,
                                                                                           -0.0017872749));

final_score_61_c547 := __common__( map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.08339594475 => 0.1896547707,
    f_add_curr_nhood_bus_pct_i > 0.08339594475                                        => 0.0544023803,
    f_add_curr_nhood_bus_pct_i = NULL                                                 => 0.1145680344,
                                                                                         0.1145680344));

final_score_61_c546 := __common__( map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.04878618325 => 0.0298708122,
    f_add_curr_nhood_bus_pct_i > 0.04878618325                                        => final_score_61_c547,
    f_add_curr_nhood_bus_pct_i = NULL                                                 => 0.0628804092,
                                                                                         0.0628804092));

final_score_61_c545 := __common__( map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 36.5 => final_score_61_c546,
    r_d32_mos_since_crim_ls_d > 36.5                                       => 0.0144137452,
    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0218076453,
                                                                              0.0218076453));

final_score_61_c544 := __common__( map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => -0.0062784272,
    f_hh_lienholders_i > 0.5                                => final_score_61_c545,
    f_hh_lienholders_i = NULL                               => 0.0104809375,
                                                               0.0104809375));

final_score_61 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 33.5 => final_score_61_c544,
    k_comb_age_d > 33.5                          => -0.0037792873,
    k_comb_age_d = NULL                          => 0.0445540999,
                                                    0.0009946524));

final_score_62_c550 := __common__( map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 52.5 => 0.1463724554,
    f_fp_prevaddrburglaryindex_i > 52.5                                          => 0.0423686561,
    f_fp_prevaddrburglaryindex_i = NULL                                          => 0.0783292918,
                                                                                    0.0783292918));

final_score_62_c549 := __common__( map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d <= 4.5 => 0.0048128806,
    r_c14_addr_stability_v2_d > 4.5                                       => final_score_62_c550,
    r_c14_addr_stability_v2_d = NULL                                      => 0.0389124738,
                                                                             0.0389124738));

final_score_62_c552 := __common__( map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i <= 0.5 => -0.0034518334,
    r_p85_phn_not_issued_i > 0.5                                    => 0.0510319412,
    r_p85_phn_not_issued_i = NULL                                   => -0.0030685894,
                                                                       -0.0030685894));

final_score_62_c551 := __common__( map(
    NULL < f_inq_communications_cnt_week_i AND f_inq_communications_cnt_week_i <= 1.5 => final_score_62_c552,
    f_inq_communications_cnt_week_i > 1.5                                             => 0.1089458274,
    f_inq_communications_cnt_week_i = NULL                                            => -0.0028330224,
                                                                                         -0.0028330224));

final_score_62 := __common__( map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 95 => final_score_62_c549,
    r_f00_ssn_score_d > 95                               => final_score_62_c551,
    r_f00_ssn_score_d = NULL                             => -0.0260358917,
                                                            -0.0018225791));

final_score_63_c554 := __common__( map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => -0.0064374760,
    f_inq_other_count24_i > 0.5                                   => 0.0094744011,
    f_inq_other_count24_i = NULL                                  => 0.0002189415,
                                                                     0.0002189415));

final_score_63_c557 := __common__( map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 5.5 => -0.0189689348,
    f_rel_homeover150_count_d > 5.5                                       => 0.0708248366,
    f_rel_homeover150_count_d = NULL                                      => 0.0141129810,
                                                                             0.0141129810));

final_score_63_c556 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 25.5 => 0.1092217379,
    k_comb_age_d > 25.5                          => final_score_63_c557,
    k_comb_age_d = NULL                          => 0.0306249179,
                                                    0.0306249179));

final_score_63_c555 := __common__( map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 397.5 => final_score_63_c556,
    r_c10_m_hdr_fs_d > 397.5                              => 0.1752559070,
    r_c10_m_hdr_fs_d = NULL                               => 0.0471879760,
                                                             0.0471879760));

final_score_63 := __common__( map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => final_score_63_c554,
    f_validationrisktype_i > 1.5                                    => final_score_63_c555,
    f_validationrisktype_i = NULL                                   => 0.0135027697,
                                                                       0.0011750540));

final_score_64_c562 := __common__( map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 3.5 => 0.1198332962,
    f_addrs_per_ssn_i > 3.5                               => 0.0135771636,
    f_addrs_per_ssn_i = NULL                              => 0.0270401341,
                                                             0.0270401341));

final_score_64_c561 := __common__( map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 412 => final_score_64_c562,
    f_m_bureau_adl_fs_all_d > 412                                     => 0.1436161819,
    f_m_bureau_adl_fs_all_d = NULL                                    => 0.0406476872,
                                                                         0.0406476872));

final_score_64_c560 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.11429966545 => final_score_64_c561,
    f_add_input_nhood_bus_pct_i > 0.11429966545                                         => 0.1439376842,
    f_add_input_nhood_bus_pct_i = NULL                                                  => 0.0559028253,
                                                                                           0.0559028253));

final_score_64_c559 := __common__( map(
    NULL < (Integer)k_nap_phn_verd_d AND (Real)k_nap_phn_verd_d <= 0.5 => final_score_64_c560,
    (Real)k_nap_phn_verd_d > 0.5                              => -0.0088225908,
    (Integer)k_nap_phn_verd_d = NULL                             => 0.0165168285,
                                                           0.0165168285));

final_score_64 := __common__( map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 218.5 => -0.0060963902,
    r_c13_curr_addr_lres_d > 218.5                                    => final_score_64_c559,
    r_c13_curr_addr_lres_d = NULL                                     => 0.0389099766,
                                                                         -0.0036754221));

final_score_65_c564 := __common__( map(
    NULL < f_hh_collections_ct_i AND f_hh_collections_ct_i <= 2.5 => 0.0171369295,
    f_hh_collections_ct_i > 2.5                                   => 0.1166767565,
    f_hh_collections_ct_i = NULL                                  => 0.0400600017,
                                                                     0.0400600017));

final_score_65_c567 := __common__( map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 6.5 => 0.0092507956,
    f_corrrisktype_i > 6.5                              => 0.0494995405,
    f_corrrisktype_i = NULL                             => 0.0200586440,
                                                           0.0200586440));

final_score_65_c566 := __common__( map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 114.5 => -0.0040166786,
    f_prevaddrageoldest_d > 114.5                                   => final_score_65_c567,
    f_prevaddrageoldest_d = NULL                                    => 0.0031513851,
                                                                       0.0031513851));

final_score_65_c565 := __common__( map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_65_c566,
    f_phone_ver_insurance_d > 3.5                                     => -0.0133350716,
    f_phone_ver_insurance_d = NULL                                    => -0.0051115053,
                                                                         -0.0051115053));

final_score_65 := __common__( map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 7.5 => final_score_65_c564,
    r_d32_mos_since_crim_ls_d > 7.5                                       => final_score_65_c565,
    r_d32_mos_since_crim_ls_d = NULL                                      => 0.0219137223,
                                                                             -0.0033035945));

final_score_66_c572 := __common__( map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 6.5 => 0.0032626127,
    r_l79_adls_per_addr_curr_i > 6.5                                        => 0.0473400883,
    r_l79_adls_per_addr_curr_i = NULL                                       => 0.0151850374,
                                                                               0.0151850374));

final_score_66_c571 := __common__( map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -34287.5 => 0.0449963943,
    f_addrchangeincomediff_d > -34287.5                                      => 0.0004821683,
    f_addrchangeincomediff_d = NULL                                          => final_score_66_c572,
                                                                                0.0038334582));

final_score_66_c570 := __common__( map(
    NULL < f_current_count_d AND f_current_count_d <= 0.5 => final_score_66_c571,
    f_current_count_d > 0.5                               => -0.0108968013,
    f_current_count_d = NULL                              => -0.0057775958,
                                                             -0.0035928938));

final_score_66_c569 := __common__( map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 7.5 => final_score_66_c570,
    k_inq_per_ssn_i > 7.5                             => 0.0388744783,
    k_inq_per_ssn_i = NULL                            => -0.0019495466,
                                                         -0.0019495466));

final_score_66 := __common__( map(
    NULL < r_p86_phn_pager_i AND r_p86_phn_pager_i <= 0.5 => final_score_66_c569,
    r_p86_phn_pager_i > 0.5                               => 0.0966958766,
    r_p86_phn_pager_i = NULL                              => -0.0017475910,
                                                             -0.0017475910));

final_score_67_c577 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.119714958 => 0.0374570787,
    f_add_curr_nhood_mfd_pct_i > 0.119714958                                        => 0.1073706776,
    f_add_curr_nhood_mfd_pct_i = NULL                                               => 0.0845017434,
                                                                                       0.0845017434));

final_score_67_c576 := __common__( map(
    NULL < r_i60_inq_auto_recency_d AND r_i60_inq_auto_recency_d <= 549 => 0.0212056222,
    r_i60_inq_auto_recency_d > 549                                      => final_score_67_c577,
    r_i60_inq_auto_recency_d = NULL                                     => 0.0518211929,
                                                                           0.0518211929));

final_score_67_c575 := __common__( map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 33500 => final_score_67_c576,
    k_estimated_income_d > 33500                                  => 0.0072993590,
    k_estimated_income_d = NULL                                   => 0.0224114884,
                                                                     0.0224114884));

final_score_67_c574 := __common__( map(
    NULL < f_srchphonesrchcountmo_i AND f_srchphonesrchcountmo_i <= 0.5 => -0.0009182404,
    f_srchphonesrchcountmo_i > 0.5                                      => final_score_67_c575,
    f_srchphonesrchcountmo_i = NULL                                     => 0.0010327137,
                                                                           0.0010327137));

final_score_67 := __common__( map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 143787.5 => final_score_67_c574,
    f_curraddrmedianincome_d > 143787.5                                      => 0.1238290481,
    f_curraddrmedianincome_d = NULL                                          => 0.0096541471,
                                                                                0.0013656308));

final_score_68_c582 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 88135 => -0.0196972293,
    f_prevaddrmedianvalue_d > 88135                                     => 0.0188783787,
    f_prevaddrmedianvalue_d = NULL                                      => 0.0093530146,
                                                                           0.0093530146));

final_score_68_c581 := __common__( map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i <= 0.5 => -0.0068546014,
    r_l70_add_standardized_i > 0.5                                      => final_score_68_c582,
    r_l70_add_standardized_i = NULL                                     => -0.0038405233,
                                                                           -0.0038405233));

final_score_68_c580 := __common__( map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 0.5 => -0.0785765283,
    f_addrs_per_ssn_i > 0.5                               => final_score_68_c581,
    f_addrs_per_ssn_i = NULL                              => -0.0042226031,
                                                             -0.0042226031));

final_score_68_c579 := __common__( map(
    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d <= 79.5 => 0.1302435218,
    f_attr_arrest_recency_d > 79.5                                     => final_score_68_c580,
    f_attr_arrest_recency_d = NULL                                     => -0.0037983854,
                                                                          -0.0037983854));

final_score_68 := __common__( map(
    NULL < f_srchunvrfddobcount_i AND f_srchunvrfddobcount_i <= 1.5 => final_score_68_c579,
    f_srchunvrfddobcount_i > 1.5                                    => 0.0857358475,
    f_srchunvrfddobcount_i = NULL                                   => 0.0170590746,
                                                                       -0.0031363373));

final_score_69_c584 := __common__( map(
    NULL < f_mos_liens_unrel_cj_fseen_d AND f_mos_liens_unrel_cj_fseen_d <= 29.5 => 0.1581879694,
    f_mos_liens_unrel_cj_fseen_d > 29.5                                          => 0.0122167933,
    f_mos_liens_unrel_cj_fseen_d = NULL                                          => 0.0146129312,
                                                                                    0.0146129312));

final_score_69_c587 := __common__( map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 6.5 => -0.0007714791,
    r_p88_phn_dst_to_inp_add_i > 6.5                                        => 0.0428702048,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => 0.0433086843,
                                                                               0.0116306011));

final_score_69_c586 := __common__( map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => final_score_69_c587,
    r_phn_pcs_n > 0.5                         => -0.0082877660,
    r_phn_pcs_n = NULL                        => 0.0020917429,
                                                 0.0020917429));

final_score_69_c585 := __common__( map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_69_c586,
    r_phn_cell_n > 0.5                          => -0.0116608357,
    r_phn_cell_n = NULL                         => -0.0059906159,
                                                   -0.0059906159));

final_score_69 := __common__( map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d <= 549 => final_score_69_c584,
    r_i60_inq_prepaidcards_recency_d > 549                                              => final_score_69_c585,
    r_i60_inq_prepaidcards_recency_d = NULL                                             => -0.0013006593,
                                                                                           -0.0028610678));

final_score_70_c592 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 119463 => 0.0012370106,
    f_prevaddrmedianincome_d > 119463                                      => 0.0868640626,
    f_prevaddrmedianincome_d = NULL                                        => 0.0020291521,
                                                                              0.0020291521));

final_score_70_c591 := __common__( map(
    NULL < r_i60_inq_auto_recency_d AND r_i60_inq_auto_recency_d <= 549 => -0.0183798268,
    r_i60_inq_auto_recency_d > 549                                      => final_score_70_c592,
    r_i60_inq_auto_recency_d = NULL                                     => -0.0063439609,
                                                                           -0.0063439609));

final_score_70_c590 := __common__( map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 3.5 => final_score_70_c591,
    f_varrisktype_i > 3.5                             => 0.0153550857,
    f_varrisktype_i = NULL                            => -0.0036373241,
                                                         -0.0036373241));

final_score_70_c589 := __common__( map(
    NULL < f_srchcountday_i AND f_srchcountday_i <= 0.5 => final_score_70_c590,
    f_srchcountday_i > 0.5                              => 0.1049328003,
    f_srchcountday_i = NULL                             => -0.0031392136,
                                                           -0.0031392136));

final_score_70 := __common__( map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i <= 15879 => final_score_70_c589,
    f_liens_unrel_cj_total_amt_i > 15879                                          => 0.0571819100,
    f_liens_unrel_cj_total_amt_i = NULL                                           => -0.0089792808,
                                                                                     -0.0014741066));

final_score_71_c595 := __common__( map(
    NULL < (Real)k_inf_fname_verd_d AND (Real)k_inf_fname_verd_d <= 0.5 => 0.0065673335,
    (Real)k_inf_fname_verd_d > 0.5                                => -0.0192779735,
    (Real)k_inf_fname_verd_d = NULL                               => 0.0004483918,
                                                               0.0004483918));

final_score_71_c594 := __common__( map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 3.5 => final_score_71_c595,
    r_c18_invalid_addrs_per_adl_i > 3.5                                           => -0.0198408105,
    r_c18_invalid_addrs_per_adl_i = NULL                                          => -0.0049846506,
                                                                                     -0.0049846506));

final_score_71_c597 := __common__( map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 147.5 => 0.0502132039,
    f_mos_liens_unrel_cj_lseen_d > 147.5                                          => 0.1809853300,
    f_mos_liens_unrel_cj_lseen_d = NULL                                           => 0.0821339591,
                                                                                     0.0821339591));

final_score_71_c596 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.71228304405 => 0.0159260934,
    f_add_input_nhood_mfd_pct_i > 0.71228304405                                         => final_score_71_c597,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => 0.0498758339,
                                                                                           0.0389880373));

final_score_71 := __common__( map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i <= 3157.5 => final_score_71_c594,
    f_liens_rel_cj_total_amt_i > 3157.5                                        => final_score_71_c596,
    f_liens_rel_cj_total_amt_i = NULL                                          => 0.0107381309,
                                                                                  -0.0035023261));

final_score_72_c599 := __common__( map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 27.5 => 0.0189656716,
    f_rel_educationover12_count_d > 27.5                                           => 0.1405300992,
    f_rel_educationover12_count_d = NULL                                           => 0.0248899549,
                                                                                      0.0248899549));

final_score_72_c602 := __common__( map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 6.5 => 0.0060371077,
    k_inq_ssns_per_addr_i > 6.5                                   => 0.1275911486,
    k_inq_ssns_per_addr_i = NULL                                  => 0.0069326834,
                                                                     0.0069326834));

final_score_72_c601 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.23280119895 => final_score_72_c602,
    f_add_curr_mobility_index_i > 0.23280119895                                         => -0.0104712343,
    f_add_curr_mobility_index_i = NULL                                                  => 0.0077928490,
                                                                                           -0.0045429541));

final_score_72_c600 := __common__( map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 22.5 => final_score_72_c601,
    f_inq_other_count24_i > 22.5                                   => 0.1605604899,
    f_inq_other_count24_i = NULL                                   => -0.0041650243,
                                                                      -0.0041650243));

final_score_72 := __common__( map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 26.5 => final_score_72_c599,
    r_d32_mos_since_crim_ls_d > 26.5                                       => final_score_72_c600,
    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0175944071,
                                                                              -0.0010695722));

final_score_73_c606 := __common__( map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 10.5 => 0.1568573679,
    r_d32_mos_since_crim_ls_d > 10.5                                       => 0.0182398871,
    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0250284209,
                                                                              0.0250284209));

final_score_73_c605 := __common__( map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 24.5 => final_score_73_c606,
    r_c12_source_profile_d > 24.5                                    => -0.0026779166,
    r_c12_source_profile_d = NULL                                    => -0.0012077702,
                                                                        -0.0012077702));

final_score_73_c607 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.80705010895 => -0.0368564435,
    f_add_input_nhood_mfd_pct_i > 0.80705010895                                         => 0.0306497189,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => 0.0033725196,
                                                                                           0.0033725196));

final_score_73_c604 := __common__( map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 0.5 => 0.0520706829,
    f_rel_under500miles_cnt_d > 0.5                                       => final_score_73_c605,
    f_rel_under500miles_cnt_d = NULL                                      => final_score_73_c607,
                                                                             -0.0005932791));

final_score_73 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 80.5 => final_score_73_c604,
    k_comb_age_d > 80.5                          => 0.1006457789,
    k_comb_age_d = NULL                          => 0.0242535140,
                                                    -0.0001553685));

final_score_74_c612 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.45690204125 => 0.0324576337,
    f_add_input_mobility_index_i > 0.45690204125                                          => 0.1162236216,
    f_add_input_mobility_index_i = NULL                                                   => 0.0548102827,
                                                                                             0.0548102827));

final_score_74_c611 := __common__( map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 1.5 => final_score_74_c612,
    r_l79_adls_per_addr_c6_i > 1.5                                      => -0.0567902829,
    r_l79_adls_per_addr_c6_i = NULL                                     => 0.0318405197,
                                                                           0.0318405197));

final_score_74_c610 := __common__( map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => -0.0050036790,
    f_validationrisktype_i > 1.5                                    => final_score_74_c611,
    f_validationrisktype_i = NULL                                   => -0.0042609826,
                                                                       -0.0042609826));

final_score_74_c609 := __common__( map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 19.5 => final_score_74_c610,
    f_rel_homeover300_count_d > 19.5                                       => 0.0680785896,
    f_rel_homeover300_count_d = NULL                                       => 0.0175120697,
                                                                              -0.0033311662));

final_score_74 := __common__( map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i <= 21806.5 => final_score_74_c609,
    f_liens_rel_cj_total_amt_i > 21806.5                                        => 0.1130244369,
    f_liens_rel_cj_total_amt_i = NULL                                           => -0.0296257707,
                                                                                   -0.0029867623));

final_score_75_c617 := __common__( map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 106.5 => -0.0810134211,
    f_m_bureau_adl_fs_all_d > 106.5                                     => 0.0335205708,
    f_m_bureau_adl_fs_all_d = NULL                                      => -0.0335237171,
                                                                           -0.0335237171));

final_score_75_c616 := __common__( map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 2.5 => -0.0064003616,
    f_rel_incomeover100_count_d > 2.5                                         => 0.0571725061,
    f_rel_incomeover100_count_d = NULL                                        => final_score_75_c617,
                                                                                 -0.0037126973));

final_score_75_c615 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 408340.5 => -0.0020883420,
    f_addrchangevaluediff_d > 408340.5                                     => 0.0747007112,
    f_addrchangevaluediff_d = NULL                                         => final_score_75_c616,
                                                                              -0.0020686331));

final_score_75_c614 := __common__( map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 39 => 0.1478810677,
    r_d32_mos_since_fel_ls_d > 39                                      => final_score_75_c615,
    r_d32_mos_since_fel_ls_d = NULL                                    => -0.0017150949,
                                                                          -0.0017150949));

final_score_75 := __common__( map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d <= 549 => 0.0153613614,
    r_i60_inq_prepaidcards_recency_d > 549                                              => final_score_75_c614,
    r_i60_inq_prepaidcards_recency_d = NULL                                             => -0.0173501321,
                                                                                           0.0007711163));

final_score_76_c620 := __common__( map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 402.5 => 0.0180237549,
    f_m_bureau_adl_fs_all_d > 402.5                                     => 0.1568016283,
    f_m_bureau_adl_fs_all_d = NULL                                      => 0.0313251485,
                                                                           0.0313251485));

final_score_76_c622 := __common__( map(
    NULL < k_inq_dobs_per_ssn_i AND k_inq_dobs_per_ssn_i <= 0.5 => -0.0258697807,
    k_inq_dobs_per_ssn_i > 0.5                                  => 0.0478222761,
    k_inq_dobs_per_ssn_i = NULL                                 => -0.0004341353,
                                                                   -0.0004341353));

final_score_76_c621 := __common__( map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.0023379929 => 0.0704719161,
    f_add_curr_nhood_sfd_pct_d > 0.0023379929                                        => final_score_76_c622,
    f_add_curr_nhood_sfd_pct_d = NULL                                                => 0.0120897755,
                                                                                        0.0120897755));

final_score_76_c619 := __common__( map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 3.5 => -0.0022392115,
    f_rel_incomeover100_count_d > 3.5                                         => final_score_76_c620,
    f_rel_incomeover100_count_d = NULL                                        => final_score_76_c621,
                                                                                 -0.0004889048));

final_score_76 := __common__( map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 5.5 => final_score_76_c619,
    r_c14_addrs_5yr_i > 5.5                               => 0.0447638636,
    r_c14_addrs_5yr_i = NULL                              => -0.0186436333,
                                                             0.0007996730));

final_score_77_c626 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 29.5 => 0.0158519876,
    k_comb_age_d > 29.5                          => -0.0060288627,
    k_comb_age_d = NULL                          => -0.0021771453,
                                                    -0.0021771453));

final_score_77_c625 := __common__( map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 1.5 => final_score_77_c626,
    r_pb_order_freq_d > 1.5                               => -0.0153232874,
    r_pb_order_freq_d = NULL                              => 0.0046934537,
                                                             -0.0036988642));

final_score_77_c627 := __common__( map(
    NULL < f_hh_tot_derog_i AND f_hh_tot_derog_i <= 3.5 => 0.1215986192,
    f_hh_tot_derog_i > 3.5                              => -0.0374144570,
    f_hh_tot_derog_i = NULL                             => 0.0570247811,
                                                           0.0570247811));

final_score_77_c624 := __common__( map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 2.5 => final_score_77_c625,
    k_inq_adls_per_phone_i > 2.5                                    => final_score_77_c627,
    k_inq_adls_per_phone_i = NULL                                   => -0.0032031302,
                                                                       -0.0032031302));

final_score_77 := __common__( map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 5.5 => 0.0434372044,
    r_d32_mos_since_crim_ls_d > 5.5                                       => final_score_77_c624,
    r_d32_mos_since_crim_ls_d = NULL                                      => 0.0145088408,
                                                                             -0.0018235236));

final_score_78_c629 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 139032.5 => -0.0039322465,
    f_prevaddrmedianincome_d > 139032.5                                      => 0.0971592867,
    f_prevaddrmedianincome_d = NULL                                          => -0.0036130100,
                                                                                -0.0036130100));

final_score_78_c631 := __common__( map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 7491 => 0.0178766133,
    f_addrchangeincomediff_d > 7491                                      => -0.0497618418,
    f_addrchangeincomediff_d = NULL                                      => 0.0012157161,
                                                                            0.0120633576));

final_score_78_c632 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.4365948217 => 0.0170317834,
    f_add_input_nhood_mfd_pct_i > 0.4365948217                                         => 0.1166828077,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => 0.0515599892,
                                                                                          0.0515599892));

final_score_78_c630 := __common__( map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 5.5 => final_score_78_c631,
    r_c14_addrs_5yr_i > 5.5                               => final_score_78_c632,
    r_c14_addrs_5yr_i = NULL                              => 0.0140705766,
                                                             0.0140705766));

final_score_78 := __common__( map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 1.5 => final_score_78_c629,
    f_inq_other_count24_i > 1.5                                   => final_score_78_c630,
    f_inq_other_count24_i = NULL                                  => 0.0193561080,
                                                                     -0.0000539487));

final_score_79_c634 := __common__( map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d <= 12.5 => -0.0016138210,
    f_hh_age_18_plus_d > 12.5                                => 0.0813619607,
    f_hh_age_18_plus_d = NULL                                => -0.0012641401,
                                                                -0.0012641401));

final_score_79_c637 := __common__( map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 1.5 => 0.0894350320,
    f_rel_homeover300_count_d > 1.5                                       => 0.2074396652,
    f_rel_homeover300_count_d = NULL                                      => 0.1420982567,
                                                                             0.1420982567));

final_score_79_c636 := __common__( map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 3.5 => -0.0315913871,
    f_corrrisktype_i > 3.5                              => final_score_79_c637,
    f_corrrisktype_i = NULL                             => 0.0858189308,
                                                           0.0858189308));

final_score_79_c635 := __common__( map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 4.5 => final_score_79_c636,
    f_rel_under500miles_cnt_d > 4.5                                       => 0.0203154381,
    f_rel_under500miles_cnt_d = NULL                                      => 0.0303540727,
                                                                             0.0303540727));

final_score_79 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 334.5 => final_score_79_c634,
    r_c13_max_lres_d > 334.5                              => final_score_79_c635,
    r_c13_max_lres_d = NULL                               => -0.0553848826,
                                                             0.0001012584));

final_score_80_c640 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 451087 => -0.0100093022,
    f_addrchangevaluediff_d > 451087                                     => 0.0890869000,
    f_addrchangevaluediff_d = NULL                                       => -0.0134102756,
                                                                            -0.0102875902));

final_score_80_c639 := __common__( map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 18 => 0.0165125749,
    r_i61_inq_collection_recency_d > 18                                            => final_score_80_c640,
    r_i61_inq_collection_recency_d = NULL                                          => -0.0059492007,
                                                                                      -0.0059492007));

final_score_80_c642 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 100269.5 => 0.0223812096,
    f_prevaddrmedianincome_d > 100269.5                                      => 0.1200861208,
    f_prevaddrmedianincome_d = NULL                                          => 0.0265824131,
                                                                                0.0265824131));

final_score_80_c641 := __common__( map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_80_c642,
    f_phone_ver_experian_d > 0.5                                    => -0.0135768066,
    f_phone_ver_experian_d = NULL                                   => 0.0231192811,
                                                                       0.0069784291));

final_score_80 := __common__( map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 136.5 => final_score_80_c639,
    f_prevaddrageoldest_d > 136.5                                   => final_score_80_c641,
    f_prevaddrageoldest_d = NULL                                    => 0.0101875876,
                                                                       -0.0028611176));

final_score_81_c645 := __common__( map(
    NULL < (Integer)k_inf_contradictory_i AND (Real)k_inf_contradictory_i <= 0.5 => 0.0214078162,
    (Real)k_inf_contradictory_i > 0.5                                   => 0.1052901569,
    (Integer)k_inf_contradictory_i = NULL                                  => 0.0479541099,
                                                                     0.0479541099));

final_score_81_c644 := __common__( map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 1.5 => final_score_81_c645,
    f_rel_ageover40_count_d > 1.5                                     => 0.0112028560,
    f_rel_ageover40_count_d = NULL                                    => 0.0207970101,
                                                                         0.0207970101));

final_score_81_c647 := __common__( map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 212.5 => 0.0804220348,
    r_c10_m_hdr_fs_d > 212.5                              => 0.0069531151,
    r_c10_m_hdr_fs_d = NULL                               => 0.0229974680,
                                                             0.0229974680));

final_score_81_c646 := __common__( map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 3.5 => -0.0058303576,
    r_s66_adlperssn_count_i > 3.5                                     => final_score_81_c647,
    r_s66_adlperssn_count_i = NULL                                    => -0.0039013036,
                                                                         -0.0039013036));

final_score_81 := __common__( map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 36.5 => final_score_81_c644,
    r_d32_mos_since_crim_ls_d > 36.5                                       => final_score_81_c646,
    r_d32_mos_since_crim_ls_d = NULL                                       => -0.0228323409,
                                                                              -0.0007146861));

final_score_82_c651 := __common__( map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 4.5 => -0.0038714558,
    f_util_adl_count_n > 4.5                                => 0.0122705523,
    f_util_adl_count_n = NULL                               => 0.0021401769,
                                                               0.0021401769));

final_score_82_c652 := __common__( map(
    NULL < r_a50_pb_total_dollars_d AND r_a50_pb_total_dollars_d <= 716.5 => -0.0287679335,
    r_a50_pb_total_dollars_d > 716.5                                      => 0.1210181841,
    r_a50_pb_total_dollars_d = NULL                                       => 0.0609188160,
                                                                             0.0609188160));

final_score_82_c650 := __common__( map(
    NULL < r_c19_add_prison_hist_i AND r_c19_add_prison_hist_i <= 0.5 => final_score_82_c651,
    r_c19_add_prison_hist_i > 0.5                                     => final_score_82_c652,
    r_c19_add_prison_hist_i = NULL                                    => 0.0025525157,
                                                                         0.0025525157));

final_score_82_c649 := __common__( map(
    NULL < f_mos_liens_rel_o_fseen_d AND f_mos_liens_rel_o_fseen_d <= 285.5 => -0.0317026116,
    f_mos_liens_rel_o_fseen_d > 285.5                                       => final_score_82_c650,
    f_mos_liens_rel_o_fseen_d = NULL                                        => 0.0006169527,
                                                                               0.0006169527));

final_score_82 := __common__( map(
    NULL < f_inq_prepaidcards_count24_i AND f_inq_prepaidcards_count24_i <= 0.5 => final_score_82_c649,
    f_inq_prepaidcards_count24_i > 0.5                                          => 0.0436139309,
    f_inq_prepaidcards_count24_i = NULL                                         => 0.0135550218,
                                                                                   0.0013666030));

final_score_83_c655 := __common__( map(
    NULL < f_phones_per_addr_c6_i AND f_phones_per_addr_c6_i <= 7.5 => -0.0030794301,
    f_phones_per_addr_c6_i > 7.5                                    => -0.0461145128,
    f_phones_per_addr_c6_i = NULL                                   => -0.0044323702,
                                                                       -0.0044323702));

final_score_83_c657 := __common__( map(
    NULL < f_mos_liens_rel_o_fseen_d AND f_mos_liens_rel_o_fseen_d <= 300.5 => -0.0413461917,
    f_mos_liens_rel_o_fseen_d > 300.5                                       => 0.0132905226,
    f_mos_liens_rel_o_fseen_d = NULL                                        => 0.0096291123,
                                                                               0.0096291123));

final_score_83_c656 := __common__( map(
    NULL < (Integer)r_nas_ssn_verd_d AND (Real)r_nas_ssn_verd_d <= 0.5 => 0.1066698769,
    (Real)r_nas_ssn_verd_d > 0.5                              => final_score_83_c657,
    (Integer)r_nas_ssn_verd_d = NULL                             => 0.0104180616,
                                                           0.0104180616));

final_score_83_c654 := __common__( map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 0.5 => final_score_83_c655,
    f_srchfraudsrchcountyr_i > 0.5                                      => final_score_83_c656,
    f_srchfraudsrchcountyr_i = NULL                                     => 0.0017845662,
                                                                           0.0017845662));

final_score_83 := __common__( map(
    NULL < f_inq_auto_count24_i AND f_inq_auto_count24_i <= 2.5 => final_score_83_c654,
    f_inq_auto_count24_i > 2.5                                  => -0.0270389047,
    f_inq_auto_count24_i = NULL                                 => 0.0287418751,
                                                                   -0.0017903674));

final_score_84_c661 := __common__( map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.1479777340,
    f_phone_ver_experian_d > 0.5                                    => 0.0234113195,
    f_phone_ver_experian_d = NULL                                   => 0.0856945268,
                                                                       0.0856945268));

final_score_84_c660 := __common__( map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 1.5 => final_score_84_c661,
    f_hh_lienholders_i > 1.5                                => -0.0336756038,
    f_hh_lienholders_i = NULL                               => 0.0373119489,
                                                               0.0373119489));

final_score_84_c659 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 99661 => -0.0174772258,
    f_prevaddrmedianincome_d > 99661                                      => final_score_84_c660,
    f_prevaddrmedianincome_d = NULL                                       => -0.0153501084,
                                                                             -0.0153501084));

final_score_84_c662 := __common__( map(
    NULL < f_rel_felony_count_i AND f_rel_felony_count_i <= 0.5 => -0.0013395845,
    f_rel_felony_count_i > 0.5                                  => 0.0253769901,
    f_rel_felony_count_i = NULL                                 => 0.0108105887,
                                                                   0.0063274040));

final_score_84 := __common__( map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 1.5 => -0.0010719867,
    r_pb_order_freq_d > 1.5                               => final_score_84_c659,
    r_pb_order_freq_d = NULL                              => final_score_84_c662,
                                                             -0.0027588030));

final_score_85_c667 := __common__( map(
    NULL < f_srchphonesrchcountmo_i AND f_srchphonesrchcountmo_i <= 2.5 => 0.0118574303,
    f_srchphonesrchcountmo_i > 2.5                                      => 0.1041828559,
    f_srchphonesrchcountmo_i = NULL                                     => 0.0128064068,
                                                                           0.0128064068));

final_score_85_c666 := __common__( map(
    NULL < f_hh_age_65_plus_d AND f_hh_age_65_plus_d <= 1.5 => final_score_85_c667,
    f_hh_age_65_plus_d > 1.5                                => 0.0591243274,
    f_hh_age_65_plus_d = NULL                               => 0.0160836456,
                                                               0.0160836456));

final_score_85_c665 := __common__( map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 0.5 => -0.0013736531,
    f_srchfraudsrchcountyr_i > 0.5                                      => final_score_85_c666,
    f_srchfraudsrchcountyr_i = NULL                                     => 0.0056546674,
                                                                           0.0056546674));

final_score_85_c664 := __common__( map(
    NULL < f_inq_auto_count24_i AND f_inq_auto_count24_i <= 1.5 => final_score_85_c665,
    f_inq_auto_count24_i > 1.5                                  => -0.0215116344,
    f_inq_auto_count24_i = NULL                                 => 0.0005581941,
                                                                   0.0005581941));

final_score_85 := __common__( map(
    NULL < r_c16_inv_ssn_per_adl_i AND r_c16_inv_ssn_per_adl_i <= 0.5 => final_score_85_c664,
    r_c16_inv_ssn_per_adl_i > 0.5                                     => -0.0572550444,
    r_c16_inv_ssn_per_adl_i = NULL                                    => 0.0275086218,
                                                                         -0.0006826463));

final_score_86_c671 := __common__( map(
    NULL < f_hh_tot_derog_i AND f_hh_tot_derog_i <= 1.5 => -0.0062625030,
    f_hh_tot_derog_i > 1.5                              => 0.0203315863,
    f_hh_tot_derog_i = NULL                             => 0.0066949242,
                                                           0.0066949242));

final_score_86_c670 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 33.5 => final_score_86_c671,
    k_comb_age_d > 33.5                          => -0.0080704492,
    k_comb_age_d = NULL                          => -0.0031825403,
                                                    -0.0031825403));

final_score_86_c669 := __common__( map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 1.5 => final_score_86_c670,
    f_srchunvrfdphonecount_i > 1.5                                      => 0.0220023651,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0077187962,
                                                                           -0.0011129591));

final_score_86_c672 := __common__( map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 17.5 => 0.0273589630,
    f_rel_incomeover50_count_d > 17.5                                        => 0.1233517049,
    f_rel_incomeover50_count_d = NULL                                        => 0.0331719441,
                                                                                0.0331719441));

final_score_86 := __common__( map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 1.5 => final_score_86_c669,
    k_inq_adls_per_phone_i > 1.5                                    => final_score_86_c672,
    k_inq_adls_per_phone_i = NULL                                   => 0.0005983284,
                                                                       0.0005983284));

final_score_87_c675 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 3.5 => 0.0362553890,
    f_inq_communications_count24_i > 3.5                                            => 0.1474735425,
    f_inq_communications_count24_i = NULL                                           => 0.0440656526,
                                                                                       0.0440656526));

final_score_87_c674 := __common__( map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => -0.0015970677,
    r_f03_input_add_not_most_rec_i > 0.5                                            => final_score_87_c675,
    r_f03_input_add_not_most_rec_i = NULL                                           => 0.0000121115,
                                                                                       0.0000121115));

final_score_87_c676 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 287138 => 0.0943919825,
    f_curraddrmedianvalue_d > 287138                                     => -0.0175220027,
    f_curraddrmedianvalue_d = NULL                                       => 0.0378772790,
                                                                            0.0378772790));

final_score_87_c677 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.57041206775 => -0.0197654533,
    f_add_curr_nhood_mfd_pct_i > 0.57041206775                                        => 0.0157784623,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => -0.0087266719,
                                                                                         -0.0086367031));

final_score_87 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 234687.5 => final_score_87_c674,
    f_addrchangevaluediff_d > 234687.5                                     => final_score_87_c676,
    f_addrchangevaluediff_d = NULL                                         => final_score_87_c677,
                                                                              -0.0010728287));

final_score_88_c680 := __common__( map(
    NULL < f_mos_liens_unrel_st_fseen_d AND f_mos_liens_unrel_st_fseen_d <= 78.5 => -0.0426954970,
    f_mos_liens_unrel_st_fseen_d > 78.5                                          => -0.0020236942,
    f_mos_liens_unrel_st_fseen_d = NULL                                          => -0.0034325916,
                                                                                    -0.0034325916));

final_score_88_c682 := __common__( map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 4.5 => 0.0275250471,
    r_p88_phn_dst_to_inp_add_i > 4.5                                        => 0.1395823327,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => 0.0864709237,
                                                                               0.0702103956));

final_score_88_c681 := __common__( map(
    NULL < f_corrssnnamecount_d AND f_corrssnnamecount_d <= 7.5 => final_score_88_c682,
    f_corrssnnamecount_d > 7.5                                  => -0.0209296706,
    f_corrssnnamecount_d = NULL                                 => 0.0362341518,
                                                                   0.0362341518));

final_score_88_c679 := __common__( map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i <= 17041 => final_score_88_c680,
    f_liens_unrel_cj_total_amt_i > 17041                                          => final_score_88_c681,
    f_liens_unrel_cj_total_amt_i = NULL                                           => -0.0024207214,
                                                                                     -0.0024207214));

final_score_88 := __common__( map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 9 => 0.0216243660,
    r_i60_inq_hiriskcred_recency_d > 9                                            => final_score_88_c679,
    r_i60_inq_hiriskcred_recency_d = NULL                                         => -0.0021160760,
                                                                                     0.0001846872));

final_score_89_c687 := __common__( map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => 0.0522224921,
    f_hh_lienholders_i > 0.5                                => 0.0089521750,
    f_hh_lienholders_i = NULL                               => 0.0205451040,
                                                               0.0205451040));

final_score_89_c686 := __common__( map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.0821211961 => final_score_89_c687,
    f_add_curr_nhood_bus_pct_i > 0.0821211961                                        => -0.0041319761,
    f_add_curr_nhood_bus_pct_i = NULL                                                => 0.0311996456,
                                                                                        0.0062482949));

final_score_89_c685 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.06574799435 => -0.0087286187,
    f_add_input_nhood_bus_pct_i > 0.06574799435                                         => final_score_89_c686,
    f_add_input_nhood_bus_pct_i = NULL                                                  => -0.0079540303,
                                                                                           -0.0042965006));

final_score_89_c684 := __common__( map(
    NULL < f_inq_collection_count24_i AND f_inq_collection_count24_i <= 1.5 => final_score_89_c685,
    f_inq_collection_count24_i > 1.5                                        => 0.0182170096,
    f_inq_collection_count24_i = NULL                                       => -0.0014682523,
                                                                               -0.0014682523));

final_score_89 := __common__( map(
    NULL < f_srchcountwk_i AND f_srchcountwk_i <= 2.5 => final_score_89_c684,
    f_srchcountwk_i > 2.5                             => 0.1179561049,
    f_srchcountwk_i = NULL                            => 0.0162237986,
                                                         -0.0010518737));

final_score_90_c691 := __common__( map(
    NULL < r_l78_no_phone_at_addr_vel_i AND r_l78_no_phone_at_addr_vel_i <= 0.5 => -0.0377410263,
    r_l78_no_phone_at_addr_vel_i > 0.5                                          => 0.0275586617,
    r_l78_no_phone_at_addr_vel_i = NULL                                         => -0.0211445252,
                                                                                   -0.0211445252));

final_score_90_c690 := __common__( map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 3.5 => 0.0098260767,
    r_c23_inp_addr_occ_index_d > 3.5                                        => final_score_90_c691,
    r_c23_inp_addr_occ_index_d = NULL                                       => 0.0063827771,
                                                                               0.0063827771));

final_score_90_c692 := __common__( map(
    NULL < f_divaddrsuspidcountnew_i AND f_divaddrsuspidcountnew_i <= 8.5 => -0.0101272336,
    f_divaddrsuspidcountnew_i > 8.5                                       => 0.1097426614,
    f_divaddrsuspidcountnew_i = NULL                                      => -0.0096763438,
                                                                             -0.0096763438));

final_score_90_c689 := __common__( map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 78 => final_score_90_c690,
    f_curraddrburglaryindex_i > 78                                       => final_score_90_c692,
    f_curraddrburglaryindex_i = NULL                                     => -0.0031837916,
                                                                            -0.0031837916));

final_score_90 := __common__( map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 23.5 => final_score_90_c689,
    r_d30_derog_count_i > 23.5                                 => 0.0468907426,
    r_d30_derog_count_i = NULL                                 => -0.0199667779,
                                                                  -0.0016388219));

final_score_91_c696 := __common__( map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 23.5 => -0.0132490109,
    f_prevaddrageoldest_d > 23.5                                   => 0.0013021571,
    f_prevaddrageoldest_d = NULL                                   => -0.0025580164,
                                                                      -0.0025580164));

final_score_91_c695 := __common__( map(
    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d <= 79.5 => 0.1055305589,
    f_attr_arrest_recency_d > 79.5                                     => final_score_91_c696,
    f_attr_arrest_recency_d = NULL                                     => -0.0022007207,
                                                                          -0.0022007207));

final_score_91_c697 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 224 => -0.0146488629,
    r_c13_max_lres_d > 224                              => 0.1407576556,
    r_c13_max_lres_d = NULL                             => 0.0756890726,
                                                           0.0756890726));

final_score_91_c694 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 74.5 => final_score_91_c695,
    k_comb_age_d > 74.5                          => final_score_91_c697,
    k_comb_age_d = NULL                          => -0.0014265434,
                                                    -0.0014265434));

final_score_91 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 8.5 => final_score_91_c694,
    f_inq_communications_count24_i > 8.5                                            => 0.0714105327,
    f_inq_communications_count24_i = NULL                                           => 0.0079334251,
                                                                                       -0.0010319093));

final_score_92_c701 := __common__( map(
    NULL < r_d31_attr_bankruptcy_recency_d AND r_d31_attr_bankruptcy_recency_d <= 9 => 0.0778995099,
    r_d31_attr_bankruptcy_recency_d > 9                                             => -0.0665269406,
    r_d31_attr_bankruptcy_recency_d = NULL                                          => 0.0366930933,
                                                                                       0.0366930933));

final_score_92_c702 := __common__( map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 65 => 0.0128216374,
    f_bus_addr_match_count_d > 65                                      => 0.1035082646,
    f_bus_addr_match_count_d = NULL                                    => 0.0166729947,
                                                                          0.0166729947));

final_score_92_c700 := __common__( map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 15.5 => -0.0035442982,
    r_p88_phn_dst_to_inp_add_i > 15.5                                        => final_score_92_c701,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => final_score_92_c702,
                                                                                0.0046982681));

final_score_92_c699 := __common__( map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 135.5 => 0.0743972206,
    r_c21_m_bureau_adl_fs_d > 135.5                                     => final_score_92_c700,
    r_c21_m_bureau_adl_fs_d = NULL                                      => 0.0072207064,
                                                                           0.0072207064));

final_score_92 := __common__( map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 131.5 => -0.0051597778,
    f_prevaddrageoldest_d > 131.5                                   => final_score_92_c699,
    f_prevaddrageoldest_d = NULL                                    => 0.0267654142,
                                                                       -0.0019495781));

final_score_93_c706 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.17649616295 => 0.1312133546,
    f_add_input_mobility_index_i > 0.17649616295                                          => 0.0151467812,
    f_add_input_mobility_index_i = NULL                                                   => 0.0219118975,
                                                                                             0.0219118975));

final_score_93_c705 := __common__( map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 0.5 => final_score_93_c706,
    f_assocsuspicousidcount_i > 0.5                                       => -0.0169578821,
    f_assocsuspicousidcount_i = NULL                                      => 0.0055075596,
                                                                             0.0055075596));

final_score_93_c704 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 219048.5 => -0.0234081112,
    f_curraddrmedianvalue_d > 219048.5                                     => final_score_93_c705,
    f_curraddrmedianvalue_d = NULL                                         => -0.0114515225,
                                                                              -0.0114515225));

final_score_93_c707 := __common__( map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.07841568625 => 0.0046873995,
    f_add_curr_nhood_vac_pct_i > 0.07841568625                                        => 0.1419419533,
    f_add_curr_nhood_vac_pct_i = NULL                                                 => 0.0137025725,
                                                                                         0.0157615737));

final_score_93 := __common__( map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 3.5 => final_score_93_c704,
    f_rel_under25miles_cnt_d > 3.5                                      => 0.0029761015,
    f_rel_under25miles_cnt_d = NULL                                     => final_score_93_c707,
                                                                           -0.0000474188));

final_score_94_c709 := __common__( map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => -0.0013807911,
    r_f03_input_add_not_most_rec_i > 0.5                                            => 0.0333554029,
    r_f03_input_add_not_most_rec_i = NULL                                           => -0.0001858128,
                                                                                       -0.0001858128));

final_score_94_c710 := __common__( map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 3.5 => 0.0090111973,
    f_addrchangeecontrajindex_d > 3.5                                         => 0.1116301385,
    f_addrchangeecontrajindex_d = NULL                                        => 0.0494500173,
                                                                                 0.0494500173));

final_score_94_c712 := __common__( map(
    NULL < f_divrisktype_i AND f_divrisktype_i <= 3.5 => 0.0236987631,
    f_divrisktype_i > 3.5                             => -0.0275265502,
    f_divrisktype_i = NULL                            => 0.0163598930,
                                                         0.0163598930));

final_score_94_c711 := __common__( map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 3.5 => -0.0177688839,
    r_l79_adls_per_addr_curr_i > 3.5                                        => final_score_94_c712,
    r_l79_adls_per_addr_curr_i = NULL                                       => -0.0142590420,
                                                                               -0.0012562841));

final_score_94 := __common__( map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 35595 => final_score_94_c709,
    f_addrchangeincomediff_d > 35595                                      => final_score_94_c710,
    f_addrchangeincomediff_d = NULL                                       => final_score_94_c711,
                                                                             0.0000974910));

final_score_95_c717 := __common__( map(
    NULL < r_c14_addrs_10yr_i AND r_c14_addrs_10yr_i <= 4.5 => -0.0220823543,
    r_c14_addrs_10yr_i > 4.5                                => 0.0984038721,
    r_c14_addrs_10yr_i = NULL                               => 0.0297936599,
                                                               0.0297936599));

final_score_95_c716 := __common__( map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 8.5 => 0.1610775418,
    f_rel_educationover12_count_d > 8.5                                           => final_score_95_c717,
    f_rel_educationover12_count_d = NULL                                          => 0.0615781786,
                                                                                     0.0615781786));

final_score_95_c715 := __common__( map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 7.5 => 0.0101581649,
    r_d32_criminal_count_i > 7.5                                    => final_score_95_c716,
    r_d32_criminal_count_i = NULL                                   => 0.0151149394,
                                                                       0.0151149394));

final_score_95_c714 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.68897889 => final_score_95_c715,
    f_add_curr_mobility_index_i > 0.68897889                                         => 0.1998277559,
    f_add_curr_mobility_index_i = NULL                                               => 0.0174741564,
                                                                                        0.0174741564));

final_score_95 := __common__( map(
    NULL < r_i61_inq_collection_count12_i AND r_i61_inq_collection_count12_i <= 0.5 => -0.0042634366,
    r_i61_inq_collection_count12_i > 0.5                                            => final_score_95_c714,
    r_i61_inq_collection_count12_i = NULL                                           => -0.0244736332,
                                                                                       -0.0008195651));

final_score_96_c721 := __common__( map(
    NULL < f_dl_addrs_per_adl_i AND f_dl_addrs_per_adl_i <= 0.5 => 0.1042041856,
    f_dl_addrs_per_adl_i > 0.5                                  => -0.0525192997,
    f_dl_addrs_per_adl_i = NULL                                 => 0.0666620579,
                                                                   0.0666620579));

final_score_96_c720 := __common__( map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 55 => final_score_96_c721,
    r_f01_inp_addr_address_score_d > 55                                            => -0.0025063758,
    r_f01_inp_addr_address_score_d = NULL                                          => -0.0015324333,
                                                                                      -0.0015324333));

final_score_96_c719 := __common__( map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 3.5 => final_score_96_c720,
    r_c23_inp_addr_occ_index_d > 3.5                                        => -0.0260246769,
    r_c23_inp_addr_occ_index_d = NULL                                       => -0.0034716240,
                                                                               -0.0034716240));

final_score_96_c722 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 175295 => -0.0013681995,
    f_curraddrmedianvalue_d > 175295                                     => 0.0260660851,
    f_curraddrmedianvalue_d = NULL                                       => 0.0106937868,
                                                                            0.0106937868));

final_score_96 := __common__( map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i <= 0.5 => final_score_96_c719,
    r_l70_add_standardized_i > 0.5                                      => final_score_96_c722,
    r_l70_add_standardized_i = NULL                                     => -0.0008561652,
                                                                           -0.0008561652));

final_score_97_c726 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 59781 => 0.0163155316,
    f_curraddrmedianvalue_d > 59781                                     => -0.0135786301,
    f_curraddrmedianvalue_d = NULL                                      => -0.0095285076,
                                                                           -0.0095285076));

final_score_97_c725 := __common__( map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 97046.5 => -0.0002162820,
    r_a49_curr_avm_chg_1yr_i > 97046.5                                      => -0.0983868817,
    r_a49_curr_avm_chg_1yr_i = NULL                                         => final_score_97_c726,
                                                                               -0.0071749225));

final_score_97_c724 := __common__( map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.05759078695 => final_score_97_c725,
    f_add_curr_nhood_bus_pct_i > 0.05759078695                                        => 0.0099281408,
    f_add_curr_nhood_bus_pct_i = NULL                                                 => 0.0012123871,
                                                                                         -0.0011475241));

final_score_97_c727 := __common__( map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 9.5 => 0.0293233410,
    r_d30_derog_count_i > 9.5                                 => 0.2408258722,
    r_d30_derog_count_i = NULL                                => 0.0678470163,
                                                                 0.0678470163));

final_score_97 := __common__( map(
    NULL < r_l72_add_curr_vacant_i AND r_l72_add_curr_vacant_i <= 0.5 => final_score_97_c724,
    r_l72_add_curr_vacant_i > 0.5                                     => final_score_97_c727,
    r_l72_add_curr_vacant_i = NULL                                    => -0.0396091614,
                                                                         -0.0004858493));

final_score_98_c731 := __common__( map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 17.5 => 0.0015421933,
    f_addrs_per_ssn_i > 17.5                               => 0.0394115839,
    f_addrs_per_ssn_i = NULL                               => 0.0048286827,
                                                              0.0048286827));

final_score_98_c730 := __common__( map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 20.5 => final_score_98_c731,
    r_l79_adls_per_addr_c6_i > 20.5                                      => 0.0835286914,
    r_l79_adls_per_addr_c6_i = NULL                                      => 0.0053515436,
                                                                            0.0053515436));

final_score_98_c732 := __common__( map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i <= 25279.5 => -0.0107446439,
    f_liens_rel_cj_total_amt_i > 25279.5                                        => 0.1202259656,
    f_liens_rel_cj_total_amt_i = NULL                                           => -0.0100624498,
                                                                                   -0.0100624498));

final_score_98_c729 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 40.5 => final_score_98_c730,
    k_comb_age_d > 40.5                          => final_score_98_c732,
    k_comb_age_d = NULL                          => -0.0022895335,
                                                    -0.0022895335));

final_score_98 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 80.5 => final_score_98_c729,
    k_comb_age_d > 80.5                          => 0.0851090113,
    k_comb_age_d = NULL                          => 0.0051191525,
                                                    -0.0019482388));

final_score_99_c737 := __common__( map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 61.5 => -0.0034658056,
    f_prevaddrageoldest_d > 61.5                                   => 0.0688618459,
    f_prevaddrageoldest_d = NULL                                   => 0.0379658518,
                                                                      0.0379658518));

final_score_99_c736 := __common__( map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 61.5 => 0.0077000492,
    r_p88_phn_dst_to_inp_add_i > 61.5                                        => 0.1333470129,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => final_score_99_c737,
                                                                                0.0162150669));

final_score_99_c735 := __common__( map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => final_score_99_c736,
    r_phn_pcs_n > 0.5                         => -0.0055632906,
    r_phn_pcs_n = NULL                        => 0.0056539237,
                                                 0.0056539237));

final_score_99_c734 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 22.5 => 0.0412800588,
    k_comb_age_d > 22.5                          => final_score_99_c735,
    k_comb_age_d = NULL                          => 0.0077053596,
                                                    0.0077053596));

final_score_99 := __common__( map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_99_c734,
    r_phn_cell_n > 0.5                          => -0.0041929097,
    r_phn_cell_n = NULL                         => 0.0006630986,
                                                   0.0006630986));

final_score_100_c741 := __common__( map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -5322.5 => 0.0525656153,
    f_addrchangeincomediff_d > -5322.5                                      => -0.0077012078,
    f_addrchangeincomediff_d = NULL                                         => 0.0067286707,
                                                                               -0.0031062037));

final_score_100_c742 := __common__( map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 395.5 => 0.0131204030,
    f_m_bureau_adl_fs_notu_d > 395.5                                      => 0.1477112750,
    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0173838406,
                                                                             0.0173838406));

final_score_100_c740 := __common__( map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 242912.5 => final_score_100_c741,
    r_l80_inp_avm_autoval_d > 242912.5                                     => final_score_100_c742,
    r_l80_inp_avm_autoval_d = NULL                                         => -0.0083721447,
                                                                              -0.0042752160));

final_score_100_c739 := __common__( map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i <= 0.5 => final_score_100_c740,
    r_l70_add_standardized_i > 0.5                                      => 0.0088944679,
    r_l70_add_standardized_i = NULL                                     => -0.0018372709,
                                                                           -0.0018372709));

final_score_100 := __common__( map(
    NULL < f_hh_collections_ct_i AND f_hh_collections_ct_i <= 8.5 => final_score_100_c739,
    f_hh_collections_ct_i > 8.5                                   => 0.1111916828,
    f_hh_collections_ct_i = NULL                                  => -0.0097842125,
                                                                     -0.0015234130));

final_score_101_c744 := __common__( map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 6.5 => -0.0167523941,
    r_c14_addrs_5yr_i > 6.5                               => 0.0889165924,
    r_c14_addrs_5yr_i = NULL                              => -0.0152397814,
                                                             -0.0152397814));

final_score_101_c747 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 46.5 => 0.0097997202,
    k_comb_age_d > 46.5                          => -0.0112057765,
    k_comb_age_d = NULL                          => 0.0023888336,
                                                    0.0023888336));

final_score_101_c746 := __common__( map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 4.5 => final_score_101_c747,
    r_pb_order_freq_d > 4.5                               => -0.0099481911,
    r_pb_order_freq_d = NULL                              => 0.0091799925,
                                                             0.0014701252));

final_score_101_c745 := __common__( map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 13.5 => 0.0512030798,
    f_curraddrburglaryindex_i > 13.5                                       => final_score_101_c746,
    f_curraddrburglaryindex_i = NULL                                       => 0.0021146426,
                                                                              0.0021146426));

final_score_101 := __common__( map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 72.5 => final_score_101_c744,
    f_prevaddrcartheftindex_i > 72.5                                       => final_score_101_c745,
    f_prevaddrcartheftindex_i = NULL                                       => -0.0071614516,
                                                                              -0.0027168891));

final_score_102_c749 := __common__( map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 3.5 => 0.0107128262,
    f_inq_count24_i > 3.5                             => 0.0906464092,
    f_inq_count24_i = NULL                            => 0.0325128943,
                                                         0.0325128943));

final_score_102_c752 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 22.5 => 0.0228041137,
    k_comb_age_d > 22.5                          => -0.0262273544,
    k_comb_age_d = NULL                          => -0.0102902209,
                                                    -0.0102902209));

final_score_102_c751 := __common__( map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 11.5 => -0.0036489721,
    f_rel_under25miles_cnt_d > 11.5                                      => 0.0142942872,
    f_rel_under25miles_cnt_d = NULL                                      => final_score_102_c752,
                                                                            0.0007482223));

final_score_102_c750 := __common__( map(
    NULL < r_c12_nonderog_recency_i AND r_c12_nonderog_recency_i <= 9 => final_score_102_c751,
    r_c12_nonderog_recency_i > 9                                      => 0.1157017360,
    r_c12_nonderog_recency_i = NULL                                   => 0.0010087590,
                                                                         0.0010087590));

final_score_102 := __common__( map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 95 => final_score_102_c749,
    r_f00_ssn_score_d > 95                               => final_score_102_c750,
    r_f00_ssn_score_d = NULL                             => -0.0119145467,
                                                            0.0017698145));

final_score_103_c756 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.04947570865 => 0.0719909744,
    f_add_curr_nhood_mfd_pct_i > 0.04947570865                                        => 0.1392003269,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => 0.1119887354,
                                                                                         0.1119887354));

final_score_103_c757 := __common__( map(
    NULL < f_hh_tot_derog_i AND f_hh_tot_derog_i <= 4.5 => -0.0096041993,
    f_hh_tot_derog_i > 4.5                              => 0.2011000101,
    f_hh_tot_derog_i = NULL                             => 0.0339897751,
                                                           0.0339897751));

final_score_103_c755 := __common__( map(
    NULL < (Integer)k_nap_phn_verd_d AND (Real)k_nap_phn_verd_d <= 0.5 => final_score_103_c756,
    (Real)k_nap_phn_verd_d > 0.5                              => final_score_103_c757,
    (Integer)k_nap_phn_verd_d = NULL                             => 0.0647887225,
                                                           0.0647887225));

final_score_103_c754 := __common__( map(
    NULL < r_a50_pb_total_dollars_d AND r_a50_pb_total_dollars_d <= 50.5 => -0.0585189594,
    r_a50_pb_total_dollars_d > 50.5                                      => final_score_103_c755,
    r_a50_pb_total_dollars_d = NULL                                      => 0.0400955282,
                                                                            0.0400955282));

final_score_103 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.15400482775 => final_score_103_c754,
    f_add_input_mobility_index_i > 0.15400482775                                          => -0.0020339264,
    f_add_input_mobility_index_i = NULL                                                   => -0.0137983479,
                                                                                             -0.0007954720));

final_score_104_c759 := __common__( map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 7.5 => -0.0167470788,
    f_corrrisktype_i > 7.5                              => -0.0537193242,
    f_corrrisktype_i = NULL                             => -0.0228994004,
                                                           -0.0228994004));

final_score_104_c762 := __common__( map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 12.5 => 0.0310416711,
    r_p88_phn_dst_to_inp_add_i > 12.5                                        => -0.0560069370,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => 0.0290196377,
                                                                                0.0236057524));

final_score_104_c761 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 22884 => final_score_104_c762,
    f_prevaddrmedianincome_d > 22884                                      => 0.0009857741,
    f_prevaddrmedianincome_d = NULL                                       => 0.0032122419,
                                                                             0.0032122419));

final_score_104_c760 := __common__( map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.10480906075 => final_score_104_c761,
    f_add_curr_nhood_bus_pct_i > 0.10480906075                                        => -0.0137942702,
    f_add_curr_nhood_bus_pct_i = NULL                                                 => 0.0229383545,
                                                                                         0.0010857200));

final_score_104 := __common__( map(
    NULL < f_mos_liens_rel_ot_lseen_d AND f_mos_liens_rel_ot_lseen_d <= 263 => final_score_104_c759,
    f_mos_liens_rel_ot_lseen_d > 263                                        => final_score_104_c760,
    f_mos_liens_rel_ot_lseen_d = NULL                                       => 0.0228425568,
                                                                               -0.0013013425));

final_score_105_c766 := __common__( map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.0522771633 => 0.1388306079,
    f_add_curr_nhood_bus_pct_i > 0.0522771633                                        => -0.0172252155,
    f_add_curr_nhood_bus_pct_i = NULL                                                => 0.0774150903,
                                                                                        0.0774150903));

final_score_105_c765 := __common__( map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 2.5 => 0.0065158513,
    f_srchunvrfdphonecount_i > 2.5                                      => final_score_105_c766,
    f_srchunvrfdphonecount_i = NULL                                     => 0.0075433765,
                                                                           0.0075433765));

final_score_105_c767 := __common__( map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 9 => 0.0211212607,
    r_i60_inq_hiriskcred_recency_d > 9                                            => -0.0155854338,
    r_i60_inq_hiriskcred_recency_d = NULL                                         => -0.0104958665,
                                                                                     -0.0104958665));

final_score_105_c764 := __common__( map(
    NULL < f_rel_bankrupt_count_i AND f_rel_bankrupt_count_i <= 1.5 => final_score_105_c765,
    f_rel_bankrupt_count_i > 1.5                                    => final_score_105_c767,
    f_rel_bankrupt_count_i = NULL                                   => -0.0006612874,
                                                                       -0.0006612874));

final_score_105 := __common__( map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 62657 => final_score_105_c764,
    f_addrchangeincomediff_d > 62657                                      => 0.1175535194,
    f_addrchangeincomediff_d = NULL                                       => -0.0022348645,
                                                                             -0.0006698721));

final_score_106_c772 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 26.5 => 0.0902047105,
    k_comb_age_d > 26.5                          => -0.0037928807,
    k_comb_age_d = NULL                          => 0.0199504555,
                                                    0.0199504555));

final_score_106_c771 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.2814703783 => final_score_106_c772,
    f_add_curr_mobility_index_i > 0.2814703783                                         => 0.1277105617,
    f_add_curr_mobility_index_i = NULL                                                 => 0.0441532601,
                                                                                          0.0441532601));

final_score_106_c770 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.9232368045 => -0.0012025012,
    f_add_curr_nhood_mfd_pct_i > 0.9232368045                                        => final_score_106_c771,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => -0.0166028458,
                                                                                        0.0013179510));

final_score_106_c769 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -458374 => -0.0869410957,
    f_addrchangevaluediff_d > -458374                                     => -0.0000328482,
    f_addrchangevaluediff_d = NULL                                        => final_score_106_c770,
                                                                             -0.0000422386));

final_score_106 := __common__( map(
    NULL < r_c16_inv_ssn_per_adl_i AND r_c16_inv_ssn_per_adl_i <= 0.5 => final_score_106_c769,
    r_c16_inv_ssn_per_adl_i > 0.5                                     => -0.0504688376,
    r_c16_inv_ssn_per_adl_i = NULL                                    => 0.0265904421,
                                                                         -0.0011523213));

final_score_107_c775 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 227.5 => -0.0224857058,
    r_c13_max_lres_d > 227.5                              => 0.0397955442,
    r_c13_max_lres_d = NULL                               => -0.0150712713,
                                                             -0.0150712713));

final_score_107_c774 := __common__( map(
    NULL < r_f01_inp_addr_not_verified_i AND r_f01_inp_addr_not_verified_i <= 0.5 => 0.0018664968,
    r_f01_inp_addr_not_verified_i > 0.5                                           => final_score_107_c775,
    r_f01_inp_addr_not_verified_i = NULL                                          => -0.0199369843,
                                                                                     0.0001323246));

final_score_107_c777 := __common__( map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 5.5 => 0.2163730648,
    f_rel_homeover200_count_d > 5.5                                       => 0.0073160862,
    f_rel_homeover200_count_d = NULL                                      => 0.1238134865,
                                                                             0.1238134865));

final_score_107_c776 := __common__( map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 7.5 => -0.0038824487,
    r_p88_phn_dst_to_inp_add_i > 7.5                                        => final_score_107_c777,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => 0.0691600369,
                                                                               0.0356617524));

final_score_107 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.99137466055 => final_score_107_c774,
    f_add_input_nhood_sfd_pct_d > 0.99137466055                                         => final_score_107_c776,
    f_add_input_nhood_sfd_pct_d = NULL                                                  => 0.0013207714,
                                                                                           0.0013207714));

final_score_108_c780 := __common__( map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d <= 549 => 0.0137959194,
    r_i60_inq_prepaidcards_recency_d > 549                                              => -0.0037857837,
    r_i60_inq_prepaidcards_recency_d = NULL                                             => -0.0011809514,
                                                                                           -0.0011809514));

final_score_108_c779 := __common__( map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 13.5 => final_score_108_c780,
    f_assocsuspicousidcount_i > 13.5                                       => 0.1823947090,
    f_assocsuspicousidcount_i = NULL                                       => -0.0007235749,
                                                                              -0.0007235749));

final_score_108_c782 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 30210.5 => 0.1467997426,
    f_prevaddrmedianincome_d > 30210.5                                      => 0.0422565304,
    f_prevaddrmedianincome_d = NULL                                         => 0.0820047309,
                                                                               0.0820047309));

final_score_108_c781 := __common__( map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 5.5 => 0.0117050612,
    f_sourcerisktype_i > 5.5                                => final_score_108_c782,
    f_sourcerisktype_i = NULL                               => 0.0284099332,
                                                               0.0284099332));

final_score_108 := __common__( map(
    NULL < r_d32_felony_count_i AND r_d32_felony_count_i <= 0.5 => final_score_108_c779,
    r_d32_felony_count_i > 0.5                                  => final_score_108_c781,
    r_d32_felony_count_i = NULL                                 => -0.0084860731,
                                                                   0.0002001952));

final_score_109_c785 := __common__( map(
    NULL < r_d31_mostrec_bk_i AND r_d31_mostrec_bk_i <= 1.5 => 0.0067037987,
    r_d31_mostrec_bk_i > 1.5                                => -0.0148875974,
    r_d31_mostrec_bk_i = NULL                               => 0.0027313192,
                                                               0.0027313192));

final_score_109_c786 := __common__( map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 147.5 => 0.0834392171,
    f_curraddrburglaryindex_i > 147.5                                       => -0.0522349560,
    f_curraddrburglaryindex_i = NULL                                        => 0.0541459297,
                                                                               0.0541459297));

final_score_109_c784 := __common__( map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 7.5 => final_score_109_c785,
    f_varrisktype_i > 7.5                             => final_score_109_c786,
    f_varrisktype_i = NULL                            => 0.0033137710,
                                                         0.0033137710));

final_score_109_c787 := __common__( map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 7.5 => -0.0153764216,
    f_corrrisktype_i > 7.5                              => -0.0661239555,
    f_corrrisktype_i = NULL                             => -0.0241811988,
                                                           -0.0241811988));

final_score_109 := __common__( map(
    NULL < f_mos_liens_rel_ot_fseen_d AND f_mos_liens_rel_ot_fseen_d <= 74.5 => final_score_109_c784,
    f_mos_liens_rel_ot_fseen_d > 74.5                                        => final_score_109_c787,
    f_mos_liens_rel_ot_fseen_d = NULL                                        => 0.0287034919,
                                                                                0.0016324267));

final_score_110_c790 := __common__( map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => 0.0046987264,
    r_f03_input_add_not_most_rec_i > 0.5                                            => 0.0792002384,
    r_f03_input_add_not_most_rec_i = NULL                                           => 0.0175811927,
                                                                                       0.0175811927));

final_score_110_c791 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.03192133245 => -0.0411251298,
    f_add_curr_nhood_mfd_pct_i > 0.03192133245                                        => 0.0067687012,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => -0.0186081412,
                                                                                         -0.0036276623));

final_score_110_c789 := __common__( map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 47.5 => -0.0026005773,
    f_addrchangeincomediff_d > 47.5                                      => final_score_110_c790,
    f_addrchangeincomediff_d = NULL                                      => final_score_110_c791,
                                                                            -0.0012631284));

final_score_110_c792 := __common__( map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 6.5 => 0.0140160404,
    f_rel_incomeover75_count_d > 6.5                                        => 0.1515834471,
    f_rel_incomeover75_count_d = NULL                                       => 0.0266061725,
                                                                               0.0266061725));

final_score_110 := __common__( map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 1.5 => final_score_110_c789,
    k_inq_adls_per_phone_i > 1.5                                    => final_score_110_c792,
    k_inq_adls_per_phone_i = NULL                                   => 0.0000934311,
                                                                       0.0000934311));

final_score_111_c794 := __common__( map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 1.5 => -0.0062941520,
    k_inq_adls_per_phone_i > 1.5                                    => 0.0275119155,
    k_inq_adls_per_phone_i = NULL                                   => -0.0047409415,
                                                                       -0.0047409415));

final_score_111_c796 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 535800.5 => 0.0353751754,
    f_prevaddrmedianvalue_d > 535800.5                                     => 0.1497816982,
    f_prevaddrmedianvalue_d = NULL                                         => 0.0410156830,
                                                                              0.0410156830));

final_score_111_c797 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -77315.5 => -0.0760723891,
    f_addrchangevaluediff_d > -77315.5                                     => 0.0135237730,
    f_addrchangevaluediff_d = NULL                                         => -0.0034110439,
                                                                              0.0079376973));

final_score_111_c795 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.2142687479 => final_score_111_c796,
    f_add_input_mobility_index_i > 0.2142687479                                          => final_score_111_c797,
    f_add_input_mobility_index_i = NULL                                                  => 0.0151990481,
                                                                                            0.0151990481));

final_score_111 := __common__( map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 1.5 => final_score_111_c794,
    f_inq_other_count24_i > 1.5                                   => final_score_111_c795,
    f_inq_other_count24_i = NULL                                  => -0.0104926102,
                                                                     -0.0008167973));

final_score_112_c800 := __common__( map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 2.5 => 0.0392240126,
    f_rel_under100miles_cnt_d > 2.5                                       => -0.0178826715,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0176314355,
                                                                             0.0176314355));

final_score_112_c799 := __common__( map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 108.5 => -0.0261231331,
    f_prevaddrageoldest_d > 108.5                                   => final_score_112_c800,
    f_prevaddrageoldest_d = NULL                                    => -0.0151343764,
                                                                       -0.0151343764));

final_score_112_c801 := __common__( map(
    NULL < f_divaddrsuspidcountnew_i AND f_divaddrsuspidcountnew_i <= 8.5 => 0.0006352243,
    f_divaddrsuspidcountnew_i > 8.5                                       => 0.0769589654,
    f_divaddrsuspidcountnew_i = NULL                                      => 0.0010406155,
                                                                             0.0010406155));

final_score_112_c802 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.2699514933 => 0.0404902213,
    f_add_curr_mobility_index_i > 0.2699514933                                         => -0.0237120061,
    f_add_curr_mobility_index_i = NULL                                                 => 0.0426348783,
                                                                                          0.0192590170));

final_score_112 := __common__( map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 3.5 => final_score_112_c799,
    f_rel_under100miles_cnt_d > 3.5                                       => final_score_112_c801,
    f_rel_under100miles_cnt_d = NULL                                      => final_score_112_c802,
                                                                             -0.0015179765));

final_score_113_c807 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.27407841105 => 0.0929481651,
    f_add_curr_mobility_index_i > 0.27407841105                                         => 0.0363228199,
    f_add_curr_mobility_index_i = NULL                                                  => 0.0659342389,
                                                                                           0.0659342389));

final_score_113_c806 := __common__( map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 123.5 => final_score_113_c807,
    f_m_bureau_adl_fs_all_d > 123.5                                     => 0.0084189964,
    f_m_bureau_adl_fs_all_d = NULL                                      => 0.0128022384,
                                                                           0.0128022384));

final_score_113_c805 := __common__( map(
    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i <= 2.5 => final_score_113_c806,
    k_inq_addrs_per_ssn_i > 2.5                                   => 0.1179405865,
    k_inq_addrs_per_ssn_i = NULL                                  => 0.0164937471,
                                                                     0.0164937471));

final_score_113_c804 := __common__( map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 4.5 => -0.0033342943,
    r_d32_criminal_count_i > 4.5                                    => final_score_113_c805,
    r_d32_criminal_count_i = NULL                                   => -0.0009123467,
                                                                       -0.0009123467));

final_score_113 := __common__( map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d <= 0.5 => 0.0504992440,
    f_hh_age_18_plus_d > 0.5                                => final_score_113_c804,
    f_hh_age_18_plus_d = NULL                               => -0.0012612356,
                                                               -0.0005464316));

final_score_114_c812 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.16114098665 => 0.0477003574,
    f_add_curr_nhood_mfd_pct_i > 0.16114098665                                        => 0.2084369510,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => 0.1312833861,
                                                                                         0.1312833861));

final_score_114_c811 := __common__( map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.00486749145 => final_score_114_c812,
    f_add_input_nhood_vac_pct_i > 0.00486749145                                         => 0.0161974789,
    f_add_input_nhood_vac_pct_i = NULL                                                  => 0.0467570136,
                                                                                           0.0467570136));

final_score_114_c810 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 503.5 => -0.0026128686,
    f_addrchangevaluediff_d > 503.5                                     => final_score_114_c811,
    f_addrchangevaluediff_d = NULL                                      => 0.0098263961,
                                                                           0.0027112849));

final_score_114_c809 := __common__( map(
    NULL < r_c12_num_nonderogs_d AND r_c12_num_nonderogs_d <= 1.5 => 0.0631205316,
    r_c12_num_nonderogs_d > 1.5                                   => final_score_114_c810,
    r_c12_num_nonderogs_d = NULL                                  => 0.0062267206,
                                                                     0.0062267206));

final_score_114 := __common__( map(
    NULL < f_rel_felony_count_i AND f_rel_felony_count_i <= 0.5 => -0.0047753220,
    f_rel_felony_count_i > 0.5                                  => final_score_114_c809,
    f_rel_felony_count_i = NULL                                 => -0.0210514101,
                                                                   -0.0010209360));

final_score_115_c815 := __common__( map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 0.5 => 0.1113204193,
    f_rel_incomeover50_count_d > 0.5                                        => 0.0264165134,
    f_rel_incomeover50_count_d = NULL                                       => 0.0343209786,
                                                                               0.0343209786));

final_score_115_c817 := __common__( map(
    NULL < r_i60_inq_count12_i AND r_i60_inq_count12_i <= 2.5 => 0.0133864391,
    r_i60_inq_count12_i > 2.5                                 => -0.0081971162,
    r_i60_inq_count12_i = NULL                                => 0.0040822606,
                                                                 0.0040822606));

final_score_115_c816 := __common__( map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 14193 => -0.0570658849,
    f_curraddrmedianincome_d > 14193                                      => final_score_115_c817,
    f_curraddrmedianincome_d = NULL                                       => 0.0027949937,
                                                                             0.0027949937));

final_score_115_c814 := __common__( map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d <= 32.5 => final_score_115_c815,
    f_mos_acc_lseen_d > 32.5                               => final_score_115_c816,
    f_mos_acc_lseen_d = NULL                               => 0.0069066161,
                                                              0.0069066161));

final_score_115 := __common__( map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 0.5 => -0.0053893782,
    f_srchfraudsrchcountyr_i > 0.5                                      => final_score_115_c814,
    f_srchfraudsrchcountyr_i = NULL                                     => 0.0050328929,
                                                                           0.0004727558));

final_score_116_c821 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 557522.5 => 0.0012818924,
    f_curraddrmedianvalue_d > 557522.5                                     => -0.0375941297,
    f_curraddrmedianvalue_d = NULL                                         => 0.0006836489,
                                                                              0.0006836489));

final_score_116_c822 := __common__( map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 16.5 => 0.0214346399,
    f_rel_under25miles_cnt_d > 16.5                                      => 0.1477323225,
    f_rel_under25miles_cnt_d = NULL                                      => 0.0362931908,
                                                                            0.0362931908));

final_score_116_c820 := __common__( map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 6.5 => final_score_116_c821,
    f_varrisktype_i > 6.5                             => final_score_116_c822,
    f_varrisktype_i = NULL                            => 0.0013506483,
                                                         0.0013506483));

final_score_116_c819 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 610217 => final_score_116_c820,
    f_prevaddrmedianvalue_d > 610217                                     => 0.0310905222,
    f_prevaddrmedianvalue_d = NULL                                       => 0.0019705794,
                                                                            0.0019705794));

final_score_116 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 78.5 => final_score_116_c819,
    k_comb_age_d > 78.5                          => 0.0818592978,
    k_comb_age_d = NULL                          => 0.0301507618,
                                                    0.0024605625));

final_score_117_c827 := __common__( map(
    NULL < f_mos_liens_unrel_cj_fseen_d AND f_mos_liens_unrel_cj_fseen_d <= 84.5 => -0.0487478092,
    f_mos_liens_unrel_cj_fseen_d > 84.5                                          => 0.0762981100,
    f_mos_liens_unrel_cj_fseen_d = NULL                                          => 0.0601764874,
                                                                                    0.0601764874));

final_score_117_c826 := __common__( map(
    NULL < r_a50_pb_average_dollars_d AND r_a50_pb_average_dollars_d <= 259 => 0.0030114374,
    r_a50_pb_average_dollars_d > 259                                        => final_score_117_c827,
    r_a50_pb_average_dollars_d = NULL                                       => 0.0261451198,
                                                                               0.0261451198));

final_score_117_c825 := __common__( map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i <= 85 => 0.0026723340,
    f_liens_rel_cj_total_amt_i > 85                                        => final_score_117_c826,
    f_liens_rel_cj_total_amt_i = NULL                                      => 0.0047385030,
                                                                              0.0047385030));

final_score_117_c824 := __common__( map(
    NULL < r_d31_attr_bankruptcy_recency_d AND r_d31_attr_bankruptcy_recency_d <= 48 => final_score_117_c825,
    r_d31_attr_bankruptcy_recency_d > 48                                             => -0.0197087811,
    r_d31_attr_bankruptcy_recency_d = NULL                                           => 0.0004227425,
                                                                                        0.0004227425));

final_score_117 := __common__( map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 48 => -0.0183453507,
    f_prevaddrcartheftindex_i > 48                                       => final_score_117_c824,
    f_prevaddrcartheftindex_i = NULL                                     => 0.0056678176,
                                                                            -0.0027805436));

final_score_118_c831 := __common__( map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 549 => -0.0424727046,
    r_i60_inq_hiriskcred_recency_d > 549                                            => 0.0206743290,
    r_i60_inq_hiriskcred_recency_d = NULL                                           => 0.0026052902,
                                                                                       0.0026052902));

final_score_118_c830 := __common__( map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 6.5 => final_score_118_c831,
    f_rel_under100miles_cnt_d > 6.5                                       => 0.0477415126,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0074706492,
                                                                             0.0203007814));

final_score_118_c829 := __common__( map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d <= 3.5 => 0.0012569972,
    f_addrchangeecontrajindex_d > 3.5                                         => final_score_118_c830,
    f_addrchangeecontrajindex_d = NULL                                        => 0.0034693138,
                                                                                 0.0039735297));

final_score_118_c832 := __common__( map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 4.5 => -0.0238845219,
    f_idverrisktype_i > 4.5                               => 0.0449344318,
    f_idverrisktype_i = NULL                              => -0.0196602269,
                                                             -0.0196602269));

final_score_118 := __common__( map(
    NULL < f_inq_auto_count24_i AND f_inq_auto_count24_i <= 1.5 => final_score_118_c829,
    f_inq_auto_count24_i > 1.5                                  => final_score_118_c832,
    f_inq_auto_count24_i = NULL                                 => -0.0218753193,
                                                                   -0.0004778658));

final_score_119_c834 := __common__( map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.02377007095 => -0.0591083783,
    f_add_curr_nhood_sfd_pct_d > 0.02377007095                                        => -0.0109695124,
    f_add_curr_nhood_sfd_pct_d = NULL                                                 => -0.0260568595,
                                                                                         -0.0260568595));

final_score_119_c837 := __common__( map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 29.5 => 0.0163584904,
    f_addrchangecrimediff_i > 29.5                                     => 0.1310654548,
    f_addrchangecrimediff_i = NULL                                     => 0.0177106773,
                                                                          0.0183676634));

final_score_119_c836 := __common__( map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 131.5 => -0.0145265761,
    f_prevaddrcartheftindex_i > 131.5                                       => final_score_119_c837,
    f_prevaddrcartheftindex_i = NULL                                        => 0.0123231317,
                                                                               0.0123231317));

final_score_119_c835 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 31123.5 => final_score_119_c836,
    f_prevaddrmedianincome_d > 31123.5                                      => -0.0016777093,
    f_prevaddrmedianincome_d = NULL                                         => 0.0013149298,
                                                                               0.0013149298));

final_score_119 := __common__( map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 1.5 => final_score_119_c834,
    f_addrs_per_ssn_i > 1.5                               => final_score_119_c835,
    f_addrs_per_ssn_i = NULL                              => 0.0004637092,
                                                             0.0004637092));

final_score_120_c840 := __common__( map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 170.5 => 0.0253883696,
    f_curraddrcartheftindex_i > 170.5                                       => 0.1473620382,
    f_curraddrcartheftindex_i = NULL                                        => 0.0489680048,
                                                                               0.0489680048));

final_score_120_c839 := __common__( map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 25 => final_score_120_c840,
    r_f01_inp_addr_address_score_d > 25                                            => 0.0026705291,
    r_f01_inp_addr_address_score_d = NULL                                          => 0.0035382832,
                                                                                      0.0035382832));

final_score_120_c842 := __common__( map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 0.5 => 0.0241827319,
    f_phones_per_addr_curr_i > 0.5                                      => -0.0314570336,
    f_phones_per_addr_curr_i = NULL                                     => -0.0196329436,
                                                                           -0.0196329436));

final_score_120_c841 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.0099771465 => 0.0753323905,
    f_add_input_nhood_mfd_pct_i > 0.0099771465                                         => final_score_120_c842,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0190276504,
                                                                                          -0.0140535772));

final_score_120 := __common__( map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 3.5 => final_score_120_c839,
    r_c23_inp_addr_occ_index_d > 3.5                                        => final_score_120_c841,
    r_c23_inp_addr_occ_index_d = NULL                                       => 0.0126047104,
                                                                               0.0018060493));

final_score_121_c846 := __common__( map(
    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 2.5 => -0.0175055804,
    f_inq_highriskcredit_count24_i > 2.5                                            => 0.1004563056,
    f_inq_highriskcredit_count24_i = NULL                                           => -0.0079074762,
                                                                                       -0.0079074762));

final_score_121_c845 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.99657814935 => -0.0003437012,
    f_add_input_nhood_mfd_pct_i > 0.99657814935                                         => -0.0411192866,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => final_score_121_c846,
                                                                                           -0.0014102823));

final_score_121_c844 := __common__( map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i <= 0.5 => final_score_121_c845,
    r_p85_phn_not_issued_i > 0.5                                    => 0.0384498209,
    r_p85_phn_not_issued_i = NULL                                   => -0.0011438269,
                                                                       -0.0011438269));

final_score_121_c847 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.03863130105 => 0.0025772635,
    f_add_input_nhood_bus_pct_i > 0.03863130105                                         => 0.1267539128,
    f_add_input_nhood_bus_pct_i = NULL                                                  => 0.0606243363,
                                                                                           0.0606243363));

final_score_121 := __common__( map(
    NULL < f_srchunvrfddobcount_i AND f_srchunvrfddobcount_i <= 1.5 => final_score_121_c844,
    f_srchunvrfddobcount_i > 1.5                                    => final_score_121_c847,
    f_srchunvrfddobcount_i = NULL                                   => -0.0231771538,
                                                                       -0.0007756297));

final_score_122_c852 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.87355069435 => 0.0196597376,
    f_add_input_nhood_mfd_pct_i > 0.87355069435                                         => 0.1095864583,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => 0.0406815684,
                                                                                           0.0406815684));

final_score_122_c851 := __common__( map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 55 => final_score_122_c852,
    r_f01_inp_addr_address_score_d > 55                                            => -0.0046951384,
    r_f01_inp_addr_address_score_d = NULL                                          => -0.0038017838,
                                                                                      -0.0038017838));

final_score_122_c850 := __common__( map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 3.5 => final_score_122_c851,
    r_c23_inp_addr_occ_index_d > 3.5                                        => -0.0184526200,
    r_c23_inp_addr_occ_index_d = NULL                                       => -0.0053177600,
                                                                               -0.0053177600));

final_score_122_c849 := __common__( map(
    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d <= 79.5 => 0.0934821011,
    f_attr_arrest_recency_d > 79.5                                     => final_score_122_c850,
    f_attr_arrest_recency_d = NULL                                     => -0.0235204333,
                                                                          -0.0050169571));

final_score_122 := __common__( map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 3.5 => final_score_122_c849,
    r_s66_adlperssn_count_i > 3.5                                     => 0.0277166409,
    r_s66_adlperssn_count_i = NULL                                    => -0.0027383429,
                                                                         -0.0027383429));

final_score_123_c856 := __common__( map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 1.5 => -0.0741559882,
    r_c14_addrs_5yr_i > 1.5                               => 0.0521427835,
    r_c14_addrs_5yr_i = NULL                              => -0.0329867754,
                                                             -0.0329867754));

final_score_123_c855 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.8414343248 => 0.0228705927,
    f_add_input_nhood_mfd_pct_i > 0.8414343248                                         => final_score_123_c856,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => 0.0712855300,
                                                                                          0.0216702974));

final_score_123_c854 := __common__( map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 4.5 => final_score_123_c855,
    r_i60_inq_hiriskcred_recency_d > 4.5                                            => -0.0043080815,
    r_i60_inq_hiriskcred_recency_d = NULL                                           => 0.0097085335,
                                                                                       -0.0023724172));

final_score_123_c857 := __common__( map(
    NULL < f_prevaddrdwelltype_sfd_n AND f_prevaddrdwelltype_sfd_n <= 0.5 => 0.1317368876,
    f_prevaddrdwelltype_sfd_n > 0.5                                       => -0.0079923707,
    f_prevaddrdwelltype_sfd_n = NULL                                      => 0.0550003277,
                                                                             0.0550003277));

final_score_123 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.96933338785 => final_score_123_c854,
    f_add_input_mobility_index_i > 0.96933338785                                          => final_score_123_c857,
    f_add_input_mobility_index_i = NULL                                                   => -0.0611606985,
                                                                                             -0.0024358811));

final_score_124_c862 := __common__( map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => 0.1793853635,
    f_hh_lienholders_i > 0.5                                => 0.0318222011,
    f_hh_lienholders_i = NULL                               => 0.0670430382,
                                                               0.0670430382));

final_score_124_c861 := __common__( map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 71191 => -0.0046642087,
    f_curraddrmedianincome_d > 71191                                      => final_score_124_c862,
    f_curraddrmedianincome_d = NULL                                       => 0.0082144764,
                                                                             0.0082144764));

final_score_124_c860 := __common__( map(
    NULL < f_curraddrcrimeindex_i AND f_curraddrcrimeindex_i <= 194.5 => final_score_124_c861,
    f_curraddrcrimeindex_i > 194.5                                    => 0.1513451214,
    f_curraddrcrimeindex_i = NULL                                     => 0.0145825772,
                                                                         0.0145825772));

final_score_124_c859 := __common__( map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 19.5 => final_score_124_c860,
    f_rel_educationover12_count_d > 19.5                                           => 0.1422936373,
    f_rel_educationover12_count_d = NULL                                           => 0.0265937901,
                                                                                      0.0265937901));

final_score_124 := __common__( map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 260.5 => 0.0009721779,
    r_c13_curr_addr_lres_d > 260.5                                    => final_score_124_c859,
    r_c13_curr_addr_lres_d = NULL                                     => -0.0202909573,
                                                                         0.0025408086));

final_score_125_c867 := __common__( map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 22.5 => 0.0260520518,
    r_p88_phn_dst_to_inp_add_i > 22.5                                        => 0.1319894231,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => 0.0214706910,
                                                                                0.0307093945));

final_score_125_c866 := __common__( map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d <= 4.5 => 0.0032905548,
    f_hh_age_18_plus_d > 4.5                                => final_score_125_c867,
    f_hh_age_18_plus_d = NULL                               => 0.0080764859,
                                                               0.0080764859));

final_score_125_c865 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 33.5 => final_score_125_c866,
    k_comb_age_d > 33.5                          => -0.0057094076,
    k_comb_age_d = NULL                          => -0.0011293692,
                                                    -0.0011293692));

final_score_125_c864 := __common__( map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i <= 21942 => final_score_125_c865,
    f_liens_rel_cj_total_amt_i > 21942                                        => 0.0977572214,
    f_liens_rel_cj_total_amt_i = NULL                                         => -0.0104870101,
                                                                                 -0.0008062541));

final_score_125 := __common__( map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 3.5 => final_score_125_c864,
    k_inq_adls_per_phone_i > 3.5                                    => 0.0794281447,
    k_inq_adls_per_phone_i = NULL                                   => -0.0006066420,
                                                                       -0.0006066420));

final_score_126_c870 := __common__( map(
    NULL < r_l72_add_curr_vacant_i AND r_l72_add_curr_vacant_i <= 0.5 => 0.0000266392,
    r_l72_add_curr_vacant_i > 0.5                                     => 0.1221990741,
    r_l72_add_curr_vacant_i = NULL                                    => 0.0008426381,
                                                                         0.0008426381));

final_score_126_c871 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 357691 => 0.0183605972,
    f_addrchangevaluediff_d > 357691                                     => 0.1052270519,
    f_addrchangevaluediff_d = NULL                                       => 0.0159211550,
                                                                            0.0189888774));

final_score_126_c869 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.06501252005 => final_score_126_c870,
    f_add_input_nhood_bus_pct_i > 0.06501252005                                         => final_score_126_c871,
    f_add_input_nhood_bus_pct_i = NULL                                                  => 0.0163691239,
                                                                                           0.0067437672));

final_score_126_c872 := __common__( map(
    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 2.5 => -0.0107389085,
    f_inq_highriskcredit_count24_i > 2.5                                            => 0.0327048114,
    f_inq_highriskcredit_count24_i = NULL                                           => -0.0072286159,
                                                                                       -0.0072286159));

final_score_126 := __common__( map(
    NULL < f_rel_bankrupt_count_i AND f_rel_bankrupt_count_i <= 1.5 => final_score_126_c869,
    f_rel_bankrupt_count_i > 1.5                                    => final_score_126_c872,
    f_rel_bankrupt_count_i = NULL                                   => 0.0269030193,
                                                                       0.0004696835));

final_score_127_c875 := __common__( map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 11.5 => 0.0047048938,
    f_util_adl_count_n > 11.5                                => 0.0510705660,
    f_util_adl_count_n = NULL                                => 0.0096067932,
                                                                0.0096067932));

final_score_127_c877 := __common__( map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.01299121795 => 0.0096503844,
    f_add_curr_nhood_vac_pct_i > 0.01299121795                                        => 0.1999934073,
    f_add_curr_nhood_vac_pct_i = NULL                                                 => 0.1134738515,
                                                                                         0.1134738515));

final_score_127_c876 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.36041011865 => 0.0192139043,
    f_add_curr_nhood_mfd_pct_i > 0.36041011865                                        => final_score_127_c877,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => 0.0558520463,
                                                                                         0.0558520463));

final_score_127_c874 := __common__( map(
    NULL < f_idrisktype_i AND f_idrisktype_i <= 1.5 => final_score_127_c875,
    f_idrisktype_i > 1.5                            => final_score_127_c876,
    f_idrisktype_i = NULL                           => 0.0113183805,
                                                       0.0113183805));

final_score_127 := __common__( map(
    NULL < f_rel_felony_count_i AND f_rel_felony_count_i <= 0.5 => -0.0045441251,
    f_rel_felony_count_i > 0.5                                  => final_score_127_c874,
    f_rel_felony_count_i = NULL                                 => -0.0280498814,
                                                                   0.0008384333));

final_score_128_c881 := __common__( map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -15562 => 0.0541479753,
    f_addrchangeincomediff_d > -15562                                      => -0.0004620740,
    f_addrchangeincomediff_d = NULL                                        => -0.0002045652,
                                                                              0.0005406959));

final_score_128_c880 := __common__( map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 3.5 => final_score_128_c881,
    r_c23_inp_addr_occ_index_d > 3.5                                        => -0.0181274094,
    r_c23_inp_addr_occ_index_d = NULL                                       => -0.0013965992,
                                                                               -0.0013965992));

final_score_128_c879 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.9979101153 => final_score_128_c880,
    f_add_input_nhood_mfd_pct_i > 0.9979101153                                         => -0.0642158318,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0075778209,
                                                                                          -0.0022589546));

final_score_128_c882 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.22516268895 => 0.1605122840,
    f_add_curr_mobility_index_i > 0.22516268895                                         => 0.0242720138,
    f_add_curr_mobility_index_i = NULL                                                  => 0.0679387670,
                                                                                           0.0679387670));

final_score_128 := __common__( map(
    NULL < f_hh_members_ct_d AND f_hh_members_ct_d <= 16.5 => final_score_128_c879,
    f_hh_members_ct_d > 16.5                               => final_score_128_c882,
    f_hh_members_ct_d = NULL                               => -0.0346667986,
                                                              -0.0018975897));

final_score_129_c884 := __common__( map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d <= 37.5 => 0.0211078477,
    f_mos_acc_lseen_d > 37.5                               => -0.0036018384,
    f_mos_acc_lseen_d = NULL                               => -0.0005070475,
                                                              -0.0005070475));

final_score_129_c885 := __common__( map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 5.5 => 0.1323964469,
    f_rel_ageover30_count_d > 5.5                                     => 0.0208766327,
    f_rel_ageover30_count_d = NULL                                    => 0.0482305494,
                                                                         0.0482305494));

final_score_129_c887 := __common__( map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= -0.5 => -0.0878942451,
    f_add_input_nhood_vac_pct_i > -0.5                                         => -0.0153843504,
    f_add_input_nhood_vac_pct_i = NULL                                         => -0.0202626920,
                                                                                  -0.0202626920));

final_score_129_c886 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 75804.5 => final_score_129_c887,
    f_curraddrmedianvalue_d > 75804.5                                     => 0.0147609623,
    f_curraddrmedianvalue_d = NULL                                        => 0.0116446472,
                                                                             0.0069003551));

final_score_129 := __common__( map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 109.5 => final_score_129_c884,
    f_addrchangecrimediff_i > 109.5                                     => final_score_129_c885,
    f_addrchangecrimediff_i = NULL                                      => final_score_129_c886,
                                                                           0.0012260434));

final_score_130_c892 := __common__( map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 4.5 => 0.1243345726,
    f_phones_per_addr_curr_i > 4.5                                      => 0.0149519787,
    f_phones_per_addr_curr_i = NULL                                     => 0.0429282396,
                                                                           0.0429282396));

final_score_130_c891 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 46295.5 => -0.0296999290,
    f_prevaddrmedianincome_d > 46295.5                                      => final_score_130_c892,
    f_prevaddrmedianincome_d = NULL                                         => 0.0112016489,
                                                                               0.0112016489));

final_score_130_c890 := __common__( map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 24629 => 0.0988231715,
    f_curraddrmedianincome_d > 24629                                      => final_score_130_c891,
    f_curraddrmedianincome_d = NULL                                       => 0.0191073502,
                                                                             0.0191073502));

final_score_130_c889 := __common__( map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 7.5 => final_score_130_c890,
    f_rel_incomeover75_count_d > 7.5                                        => 0.1432908137,
    f_rel_incomeover75_count_d = NULL                                       => 0.0277915084,
                                                                               0.0277915084));

final_score_130 := __common__( map(
    NULL < f_srchaddrsrchcountwk_i AND f_srchaddrsrchcountwk_i <= 0.5 => -0.0011312767,
    f_srchaddrsrchcountwk_i > 0.5                                     => final_score_130_c889,
    f_srchaddrsrchcountwk_i = NULL                                    => -0.0060400469,
                                                                         0.0000484651));

final_score_131_c897 := __common__( map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 5.5 => -0.0079320110,
    f_hh_members_w_derog_i > 5.5                                    => -0.0883388776,
    f_hh_members_w_derog_i = NULL                                   => -0.0117903060,
                                                                       -0.0117903060));

final_score_131_c896 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.9913866542 => final_score_131_c897,
    f_add_input_nhood_mfd_pct_i > 0.9913866542                                         => -0.1000064937,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => 0.0080255623,
                                                                                          -0.0114401226));

final_score_131_c895 := __common__( map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 10.5 => final_score_131_c896,
    k_inq_per_ssn_i > 10.5                             => 0.1103957558,
    k_inq_per_ssn_i = NULL                             => -0.0087598498,
                                                          -0.0087598498));

final_score_131_c894 := __common__( map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 7.5 => 0.0080729557,
    f_rel_homeover150_count_d > 7.5                                       => final_score_131_c895,
    f_rel_homeover150_count_d = NULL                                      => 0.0136782116,
                                                                             0.0044739712));

final_score_131 := __common__( map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 332.5 => final_score_131_c894,
    f_m_bureau_adl_fs_all_d > 332.5                                     => -0.0128125545,
    f_m_bureau_adl_fs_all_d = NULL                                      => -0.0041722738,
                                                                           0.0000212280));

final_score_132_c900 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -298072.5 => 0.0947797661,
    f_addrchangevaluediff_d > -298072.5                                     => 0.0029463163,
    f_addrchangevaluediff_d = NULL                                          => 0.0261219904,
                                                                               0.0078463108));

final_score_132_c902 := __common__( map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 81.5 => -0.0201764446,
    r_c13_curr_addr_lres_d > 81.5                                    => 0.0597864362,
    r_c13_curr_addr_lres_d = NULL                                    => -0.0022900107,
                                                                        -0.0022900107));

final_score_132_c901 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.19970480495 => 0.0655520327,
    f_add_input_mobility_index_i > 0.19970480495                                          => final_score_132_c902,
    f_add_input_mobility_index_i = NULL                                                   => 0.0082631960,
                                                                                             0.0082631960));

final_score_132_c899 := __common__( map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 0.5 => -0.0055914966,
    f_rel_incomeover100_count_d > 0.5                                         => final_score_132_c900,
    f_rel_incomeover100_count_d = NULL                                        => final_score_132_c901,
                                                                                 -0.0024217400));

final_score_132 := __common__( map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d <= 10.5 => 0.0290162920,
    f_mos_acc_lseen_d > 10.5                               => final_score_132_c899,
    f_mos_acc_lseen_d = NULL                               => -0.0240621126,
                                                              -0.0007636296));

final_score_133_c906 := __common__( map(
    NULL < f_mos_liens_unrel_o_fseen_d AND f_mos_liens_unrel_o_fseen_d <= 162 => -0.0788862925,
    f_mos_liens_unrel_o_fseen_d > 162                                         => 0.0185609083,
    f_mos_liens_unrel_o_fseen_d = NULL                                        => 0.0125853724,
                                                                                 0.0125853724));

final_score_133_c907 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 111715.5 => -0.0030875033,
    f_prevaddrmedianvalue_d > 111715.5                                     => 0.0945810184,
    f_prevaddrmedianvalue_d = NULL                                         => 0.0647986889,
                                                                              0.0647986889));

final_score_133_c905 := __common__( map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => final_score_133_c906,
    f_srchunvrfdaddrcount_i > 0.5                                     => final_score_133_c907,
    f_srchunvrfdaddrcount_i = NULL                                    => 0.0216606410,
                                                                         0.0216606410));

final_score_133_c904 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.1504132873 => final_score_133_c905,
    f_add_input_nhood_bus_pct_i > 0.1504132873                                         => -0.0597796563,
    f_add_input_nhood_bus_pct_i = NULL                                                 => 0.0155540866,
                                                                                          0.0155540866));

final_score_133 := __common__( map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 4.5 => final_score_133_c904,
    r_i60_inq_comm_recency_d > 4.5                                      => -0.0044843561,
    r_i60_inq_comm_recency_d = NULL                                     => 0.0182558452,
                                                                           -0.0032974431));

final_score_134_c912 := __common__( map(
    NULL < r_d34_unrel_liens_ct_i AND r_d34_unrel_liens_ct_i <= 7.5 => 0.0212860054,
    r_d34_unrel_liens_ct_i > 7.5                                    => 0.2263302412,
    r_d34_unrel_liens_ct_i = NULL                                   => 0.0620651111,
                                                                       0.0620651111));

final_score_134_c911 := __common__( map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 23193 => 0.1547259745,
    f_curraddrmedianincome_d > 23193                                      => final_score_134_c912,
    f_curraddrmedianincome_d = NULL                                       => 0.0744348866,
                                                                             0.0744348866));

final_score_134_c910 := __common__( map(
    NULL < f_mos_liens_rel_cj_lseen_d AND f_mos_liens_rel_cj_lseen_d <= 102.5 => final_score_134_c911,
    f_mos_liens_rel_cj_lseen_d > 102.5                                        => -0.0008167573,
    f_mos_liens_rel_cj_lseen_d = NULL                                         => 0.0004712522,
                                                                                 0.0004712522));

final_score_134_c909 := __common__( map(
    NULL < f_mos_liens_rel_cj_lseen_d AND f_mos_liens_rel_cj_lseen_d <= 82.5 => -0.0442495452,
    f_mos_liens_rel_cj_lseen_d > 82.5                                        => final_score_134_c910,
    f_mos_liens_rel_cj_lseen_d = NULL                                        => -0.0008660642,
                                                                                -0.0008660642));

final_score_134 := __common__( map(
    NULL < f_idrisktype_i AND f_idrisktype_i <= 4.5 => final_score_134_c909,
    f_idrisktype_i > 4.5                            => 0.0708249148,
    f_idrisktype_i = NULL                           => 0.0225499034,
                                                       -0.0005799168));

final_score_135_c916 := __common__( map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 30.5 => -0.0853737601,
    f_curraddrburglaryindex_i > 30.5                                       => 0.0529651444,
    f_curraddrburglaryindex_i = NULL                                       => -0.0039323082,
                                                                              -0.0039323082));

final_score_135_c915 := __common__( map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => -0.0492741888,
    f_phone_ver_experian_d > 0.5                                    => 0.0351722133,
    f_phone_ver_experian_d = NULL                                   => final_score_135_c916,
                                                                       -0.0205227537));

final_score_135_c914 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.9929539007 => 0.0009060273,
    f_add_input_nhood_mfd_pct_i > 0.9929539007                                         => final_score_135_c915,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0044668064,
                                                                                          -0.0000524070));

final_score_135_c917 := __common__( map(
    NULL < r_a50_pb_total_dollars_d AND r_a50_pb_total_dollars_d <= 170.5 => -0.0208565266,
    r_a50_pb_total_dollars_d > 170.5                                      => 0.1304564974,
    r_a50_pb_total_dollars_d = NULL                                       => 0.0716660868,
                                                                             0.0716660868));

final_score_135 := __common__( map(
    NULL < f_hh_members_ct_d AND f_hh_members_ct_d <= 16.5 => final_score_135_c914,
    f_hh_members_ct_d > 16.5                               => final_score_135_c917,
    f_hh_members_ct_d = NULL                               => 0.0112335948,
                                                              0.0004246141));

final_score_136_c920 := __common__( map(
    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i <= 0.5 => 0.0929771438,
    k_inq_addrs_per_ssn_i > 0.5                                   => -0.0117233170,
    k_inq_addrs_per_ssn_i = NULL                                  => 0.0494419006,
                                                                     0.0494419006));

final_score_136_c922 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 25.5 => 0.1380383329,
    k_comb_age_d > 25.5                          => 0.0181910578,
    k_comb_age_d = NULL                          => 0.0546204057,
                                                    0.0546204057));

final_score_136_c921 := __common__( map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 1.5 => final_score_136_c922,
    f_rel_ageover30_count_d > 1.5                                     => -0.0052925472,
    f_rel_ageover30_count_d = NULL                                    => 0.0074001927,
                                                                         -0.0013913197));

final_score_136_c919 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -94644.5 => final_score_136_c920,
    f_addrchangevaluediff_d > -94644.5                                     => 0.0001450794,
    f_addrchangevaluediff_d = NULL                                         => final_score_136_c921,
                                                                              0.0005208004));

final_score_136 := __common__( map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 3.5 => final_score_136_c919,
    r_c23_inp_addr_occ_index_d > 3.5                                        => -0.0135727184,
    r_c23_inp_addr_occ_index_d = NULL                                       => 0.0306707698,
                                                                               -0.0008174654));

final_score_137_c924 := __common__( map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 164.5 => -0.0251434357,
    f_m_bureau_adl_fs_notu_d > 164.5                                      => 0.0989667765,
    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0522776967,
                                                                             0.0522776967));

final_score_137_c927 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.2558711588 => 0.1462965710,
    f_add_curr_mobility_index_i > 0.2558711588                                         => 0.0277712847,
    f_add_curr_mobility_index_i = NULL                                                 => 0.0818556387,
                                                                                          0.0818556387));

final_score_137_c926 := __common__( map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 2.5 => final_score_137_c927,
    f_phone_ver_insurance_d > 2.5                                     => 0.0125279973,
    f_phone_ver_insurance_d = NULL                                    => 0.0331787841,
                                                                         0.0331787841));

final_score_137_c925 := __common__( map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => -0.0019003505,
    r_f03_input_add_not_most_rec_i > 0.5                                            => final_score_137_c926,
    r_f03_input_add_not_most_rec_i = NULL                                           => -0.0006809256,
                                                                                       -0.0006809256));

final_score_137 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -290317 => final_score_137_c924,
    f_addrchangevaluediff_d > -290317                                     => final_score_137_c925,
    f_addrchangevaluediff_d = NULL                                        => -0.0046826078,
                                                                             -0.0009368487));

final_score_138_c930 := __common__( map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 68 => 0.1493275268,
    f_curraddrburglaryindex_i > 68                                       => -0.0056142921,
    f_curraddrburglaryindex_i = NULL                                     => 0.0788994273,
                                                                            0.0788994273));

final_score_138_c932 := __common__( map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 3613 => -0.0430747485,
    f_addrchangeincomediff_d > 3613                                      => 0.0429983710,
    f_addrchangeincomediff_d = NULL                                      => -0.0092162258,
                                                                            -0.0171391898));

final_score_138_c931 := __common__( map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 8.5 => 0.0209079815,
    f_corrrisktype_i > 8.5                              => final_score_138_c932,
    f_corrrisktype_i = NULL                             => 0.0129635088,
                                                           0.0129635088));

final_score_138_c929 := __common__( map(
    NULL < f_mos_liens_rel_cj_lseen_d AND f_mos_liens_rel_cj_lseen_d <= 150.5 => final_score_138_c930,
    f_mos_liens_rel_cj_lseen_d > 150.5                                        => final_score_138_c931,
    f_mos_liens_rel_cj_lseen_d = NULL                                         => 0.0152971481,
                                                                                 0.0152971481));

final_score_138 := __common__( map(
    NULL < r_c12_num_nonderogs_d AND r_c12_num_nonderogs_d <= 1.5 => final_score_138_c929,
    r_c12_num_nonderogs_d > 1.5                                   => -0.0022783594,
    r_c12_num_nonderogs_d = NULL                                  => -0.0065793481,
                                                                     -0.0001002881));

final_score_139_c937 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.23406421565 => -0.0535377022,
    f_add_input_mobility_index_i > 0.23406421565                                          => 0.0280149820,
    f_add_input_mobility_index_i = NULL                                                   => 0.0104036048,
                                                                                             0.0104036048));

final_score_139_c936 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.00183293305 => 0.0360697465,
    f_add_input_nhood_sfd_pct_d > 0.00183293305                                         => final_score_139_c937,
    f_add_input_nhood_sfd_pct_d = NULL                                                  => 0.0192125770,
                                                                                           0.0192125770));

final_score_139_c935 := __common__( map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 29494.5 => final_score_139_c936,
    f_curraddrmedianincome_d > 29494.5                                      => 0.0890896316,
    f_curraddrmedianincome_d = NULL                                         => 0.0282610634,
                                                                               0.0282610634));

final_score_139_c934 := __common__( map(
    NULL < r_c14_addrs_15yr_i AND r_c14_addrs_15yr_i <= 2.5 => final_score_139_c935,
    r_c14_addrs_15yr_i > 2.5                                => -0.0004017183,
    r_c14_addrs_15yr_i = NULL                               => 0.0129182574,
                                                               0.0129182574));

final_score_139 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 24587.5 => final_score_139_c934,
    f_prevaddrmedianincome_d > 24587.5                                      => -0.0024602667,
    f_prevaddrmedianincome_d = NULL                                         => 0.0054970675,
                                                                               -0.0004811714));

final_score_140_c940 := __common__( map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 7549 => -0.0021605648,
    r_a49_curr_avm_chg_1yr_i > 7549                                      => 0.0315828423,
    r_a49_curr_avm_chg_1yr_i = NULL                                      => 0.0026677151,
                                                                            0.0046348718));

final_score_140_c939 := __common__( map(
    NULL < f_inputaddractivephonelist_d AND f_inputaddractivephonelist_d <= 0.5 => final_score_140_c940,
    f_inputaddractivephonelist_d > 0.5                                          => -0.0078778861,
    f_inputaddractivephonelist_d = NULL                                         => -0.0005922550,
                                                                                   -0.0005922550));

final_score_140_c942 := __common__( map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 1.5 => -0.0100898501,
    f_util_adl_count_n > 1.5                                => 0.1241591890,
    f_util_adl_count_n = NULL                               => 0.0826150738,
                                                               0.0826150738));

final_score_140_c941 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.3211108715 => final_score_140_c942,
    f_add_input_mobility_index_i > 0.3211108715                                          => -0.0774575038,
    f_add_input_mobility_index_i = NULL                                                  => 0.0552392410,
                                                                                            0.0552392410));

final_score_140 := __common__( map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i <= 21446.5 => final_score_140_c939,
    f_liens_unrel_cj_total_amt_i > 21446.5                                          => final_score_140_c941,
    f_liens_unrel_cj_total_amt_i = NULL                                             => 0.0035578254,
                                                                                       0.0003610278));

final_score_141_c947 := __common__( map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 84 => -0.0010789757,
    f_fp_prevaddrburglaryindex_i > 84                                          => -0.0291701492,
    f_fp_prevaddrburglaryindex_i = NULL                                        => -0.0092634455,
                                                                                  -0.0092634455));

final_score_141_c946 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 64.5 => final_score_141_c947,
    k_comb_age_d > 64.5                          => -0.0556924601,
    k_comb_age_d = NULL                          => -0.0113742874,
                                                    -0.0113742874));

final_score_141_c945 := __common__( map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.95715578195 => final_score_141_c946,
    f_add_curr_nhood_sfd_pct_d > 0.95715578195                                        => 0.0889961490,
    f_add_curr_nhood_sfd_pct_d = NULL                                                 => -0.0098780319,
                                                                                         -0.0098780319));

final_score_141_c944 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.10135552735 => final_score_141_c945,
    f_add_input_nhood_sfd_pct_d > 0.10135552735                                         => 0.0019186683,
    f_add_input_nhood_sfd_pct_d = NULL                                                  => -0.0004418130,
                                                                                           -0.0004418130));

final_score_141 := __common__( map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 47.5 => final_score_141_c944,
    r_d32_criminal_count_i > 47.5                                    => 0.1538618119,
    r_d32_criminal_count_i = NULL                                    => -0.0100672117,
                                                                        -0.0001588549));

final_score_142_c950 := __common__( map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 11.5 => 0.0000558774,
    f_assocsuspicousidcount_i > 11.5                                       => 0.1035213601,
    f_assocsuspicousidcount_i = NULL                                       => 0.0005519728,
                                                                              0.0005519728));

final_score_142_c949 := __common__( map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i <= 22792.5 => final_score_142_c950,
    f_liens_rel_cj_total_amt_i > 22792.5                                        => 0.1020357918,
    f_liens_rel_cj_total_amt_i = NULL                                           => 0.0008413161,
                                                                                   0.0008413161));

final_score_142_c952 := __common__( map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 1.5 => -0.0117069435,
    k_inq_per_phone_i > 1.5                               => 0.1153455864,
    k_inq_per_phone_i = NULL                              => 0.0128047986,
                                                             0.0128047986));

final_score_142_c951 := __common__( map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d <= 3.5 => -0.0414907049,
    f_hh_age_18_plus_d > 3.5                                => final_score_142_c952,
    f_hh_age_18_plus_d = NULL                               => -0.0253599950,
                                                               -0.0253599950));

final_score_142 := __common__( map(
    NULL < f_mos_liens_rel_ot_fseen_d AND f_mos_liens_rel_ot_fseen_d <= 43.5 => final_score_142_c949,
    f_mos_liens_rel_ot_fseen_d > 43.5                                        => final_score_142_c951,
    f_mos_liens_rel_ot_fseen_d = NULL                                        => -0.0039563692,
                                                                                -0.0013717411));

final_score_143_c957 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 24.5 => 0.0478675263,
    k_comb_age_d > 24.5                          => -0.0097286682,
    k_comb_age_d = NULL                          => 0.0120769198,
                                                    0.0120769198));

final_score_143_c956 := __common__( map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 17.5 => -0.0641207932,
    f_m_bureau_adl_fs_all_d > 17.5                                     => final_score_143_c957,
    f_m_bureau_adl_fs_all_d = NULL                                     => -0.0003532111,
                                                                          -0.0003532111));

final_score_143_c955 := __common__( map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 10.5 => -0.0027710266,
    f_rel_under25miles_cnt_d > 10.5                                      => 0.0161484369,
    f_rel_under25miles_cnt_d = NULL                                      => final_score_143_c956,
                                                                            0.0024652079));

final_score_143_c954 := __common__( map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 23.5 => final_score_143_c955,
    f_inq_count24_i > 23.5                             => 0.0889331916,
    f_inq_count24_i = NULL                             => 0.0028759025,
                                                          0.0028759025));

final_score_143 := __common__( map(
    NULL < r_c12_num_nonderogs_d AND r_c12_num_nonderogs_d <= 4.5 => final_score_143_c954,
    r_c12_num_nonderogs_d > 4.5                                   => -0.0206292146,
    r_c12_num_nonderogs_d = NULL                                  => 0.0101369449,
                                                                     -0.0011108235));

final_score_144_c962 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 123.5 => -0.0013369424,
    r_c13_max_lres_d > 123.5                              => 0.0194191108,
    r_c13_max_lres_d = NULL                               => 0.0093180020,
                                                             0.0093180020));

final_score_144_c961 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.9955066811 => final_score_144_c962,
    f_add_input_nhood_mfd_pct_i > 0.9955066811                                         => -0.0443651863,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => 0.0130949822,
                                                                                          0.0085320008));

final_score_144_c960 := __common__( map(
    NULL < f_mos_liens_rel_o_fseen_d AND f_mos_liens_rel_o_fseen_d <= 249.5 => -0.0385416262,
    f_mos_liens_rel_o_fseen_d > 249.5                                       => final_score_144_c961,
    f_mos_liens_rel_o_fseen_d = NULL                                        => 0.0060544415,
                                                                               0.0060544415));

final_score_144_c959 := __common__( map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_144_c960,
    f_phone_ver_experian_d > 0.5                                    => -0.0102616463,
    f_phone_ver_experian_d = NULL                                   => -0.0016931382,
                                                                       -0.0016416606));

final_score_144 := __common__( map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 2.5 => -0.0343228071,
    r_c13_curr_addr_lres_d > 2.5                                    => final_score_144_c959,
    r_c13_curr_addr_lres_d = NULL                                   => 0.0089063098,
                                                                       -0.0030639895));

final_score_145_c967 := __common__( map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -72.5 => 0.1271663038,
    f_addrchangecrimediff_i > -72.5                                     => 0.0234084060,
    f_addrchangecrimediff_i = NULL                                      => 0.0318132898,
                                                                           0.0269738848));

final_score_145_c966 := __common__( map(
    NULL < f_mos_liens_rel_ot_lseen_d AND f_mos_liens_rel_ot_lseen_d <= 45.5 => -0.0767266877,
    f_mos_liens_rel_ot_lseen_d > 45.5                                        => final_score_145_c967,
    f_mos_liens_rel_ot_lseen_d = NULL                                        => 0.0232043827,
                                                                                0.0232043827));

final_score_145_c965 := __common__( map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 100502 => final_score_145_c966,
    f_curraddrmedianincome_d > 100502                                      => 0.1124139804,
    f_curraddrmedianincome_d = NULL                                        => 0.0263334004,
                                                                              0.0263334004));

final_score_145_c964 := __common__( map(
    NULL < (Integer)k_nap_phn_verd_d AND (Real)k_nap_phn_verd_d <= 0.5 => final_score_145_c965,
    (Real)k_nap_phn_verd_d > 0.5                              => -0.0047586578,
    (Integer)k_nap_phn_verd_d = NULL                             => 0.0081000553,
                                                           0.0081000553));

final_score_145 := __common__( map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 126.5 => -0.0035479176,
    f_prevaddrageoldest_d > 126.5                                   => final_score_145_c964,
    f_prevaddrageoldest_d = NULL                                    => -0.0012763396,
                                                                       -0.0004536515));

final_score_146_c972 := __common__( map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 0.5 => 0.0720862419,
    f_rel_incomeover50_count_d > 0.5                                        => -0.0258491469,
    f_rel_incomeover50_count_d = NULL                                       => 0.0295210312,
                                                                               0.0036447008));

final_score_146_c971 := __common__( map(
    NULL < f_corrssnnamecount_d AND f_corrssnnamecount_d <= 1.5 => -0.0735619882,
    f_corrssnnamecount_d > 1.5                                  => final_score_146_c972,
    f_corrssnnamecount_d = NULL                                 => -0.0122967613,
                                                                   -0.0122967613));

final_score_146_c970 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 75.5 => final_score_146_c971,
    r_c13_max_lres_d > 75.5                              => -0.0635064252,
    r_c13_max_lres_d = NULL                              => -0.0342944460,
                                                            -0.0342944460));

final_score_146_c969 := __common__( map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 166.5 => final_score_146_c970,
    r_c10_m_hdr_fs_d > 166.5                              => -0.0036745319,
    r_c10_m_hdr_fs_d = NULL                               => -0.0134955858,
                                                             -0.0134955858));

final_score_146 := __common__( map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 28.5 => final_score_146_c969,
    f_fp_prevaddrburglaryindex_i > 28.5                                          => 0.0032087179,
    f_fp_prevaddrburglaryindex_i = NULL                                          => 0.0122826038,
                                                                                    0.0014223461));

final_score_147_c976 := __common__( map(
    NULL < f_hh_members_ct_d AND f_hh_members_ct_d <= 4.5 => -0.0003462641,
    f_hh_members_ct_d > 4.5                               => 0.0297111405,
    f_hh_members_ct_d = NULL                              => 0.0087600163,
                                                             0.0087600163));

final_score_147_c975 := __common__( map(
    NULL < (Integer)k_nap_fname_verd_d AND (Real)k_nap_fname_verd_d <= 0.5 => final_score_147_c976,
    (Real)k_nap_fname_verd_d > 0.5                                => -0.0039240722,
    (Integer)k_nap_fname_verd_d = NULL                               => -0.0011286238,
                                                               -0.0011286238));

final_score_147_c977 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.2983528316 => 0.0238440955,
    f_add_input_nhood_mfd_pct_i > 0.2983528316                                         => 0.1472637135,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => 0.0586870489,
                                                                                          0.0586870489));

final_score_147_c974 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 417.5 => final_score_147_c975,
    r_c13_max_lres_d > 417.5                              => final_score_147_c977,
    r_c13_max_lres_d = NULL                               => -0.0003337151,
                                                             -0.0003337151));

final_score_147 := __common__( map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 20.5 => final_score_147_c974,
    f_inq_other_count24_i > 20.5                                   => 0.0946632364,
    f_inq_other_count24_i = NULL                                   => -0.0266713584,
                                                                      -0.0001696779));

final_score_148_c979 := __common__( map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 170.5 => -0.0221687396,
    r_c10_m_hdr_fs_d > 170.5                              => -0.0039605603,
    r_c10_m_hdr_fs_d = NULL                               => -0.0096736577,
                                                             -0.0096736577));

final_score_148_c981 := __common__( map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 9.5 => 0.0001885507,
    k_inq_per_phone_i > 9.5                               => 0.0841056727,
    k_inq_per_phone_i = NULL                              => 0.0009106440,
                                                             0.0009106440));

final_score_148_c982 := __common__( map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 4.5 => 0.0083727935,
    r_l79_adls_per_addr_curr_i > 4.5                                        => 0.0469304649,
    r_l79_adls_per_addr_curr_i = NULL                                       => 0.0233893976,
                                                                               0.0233893976));

final_score_148_c980 := __common__( map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 2.5 => final_score_148_c981,
    r_s66_adlperssn_count_i > 2.5                                     => final_score_148_c982,
    r_s66_adlperssn_count_i = NULL                                    => 0.0054164223,
                                                                         0.0054164223));

final_score_148 := __common__( map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 1.5 => final_score_148_c979,
    f_util_adl_count_n > 1.5                                => final_score_148_c980,
    f_util_adl_count_n = NULL                               => -0.0134068262,
                                                               0.0006198743));

final_score_149_c987 := __common__( map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i <= 0.5 => 0.0083391764,
    r_p85_phn_disconnected_i > 0.5                                      => 0.0838597152,
    r_p85_phn_disconnected_i = NULL                                     => 0.0097180907,
                                                                           0.0097180907));

final_score_149_c986 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 746608.5 => final_score_149_c987,
    f_curraddrmedianvalue_d > 746608.5                                     => -0.0904929336,
    f_curraddrmedianvalue_d = NULL                                         => 0.0083861224,
                                                                              0.0083861224));

final_score_149_c985 := __common__( map(
    NULL < f_vardobcount_i AND f_vardobcount_i <= 0.5 => 0.0868676735,
    f_vardobcount_i > 0.5                             => final_score_149_c986,
    f_vardobcount_i = NULL                            => 0.0101261568,
                                                         0.0101261568));

final_score_149_c984 := __common__( map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i <= 0.5 => -0.0069783479,
    r_l70_add_standardized_i > 0.5                                      => final_score_149_c985,
    r_l70_add_standardized_i = NULL                                     => -0.0036856636,
                                                                           -0.0036856636));

final_score_149 := __common__( map(
    NULL < f_assocrisktype_i AND f_assocrisktype_i <= 4.5 => final_score_149_c984,
    f_assocrisktype_i > 4.5                               => 0.0162819483,
    f_assocrisktype_i = NULL                              => -0.0087539476,
                                                             -0.0001127483));

final_score_150_c989 := __common__( map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.02748284655 => -0.1136627378,
    f_add_curr_nhood_bus_pct_i > 0.02748284655                                        => 0.0063044014,
    f_add_curr_nhood_bus_pct_i = NULL                                                 => -0.0428746743,
                                                                                         -0.0428746743));

final_score_150_c991 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 341243 => -0.0100078244,
    f_curraddrmedianvalue_d > 341243                                     => 0.0276220840,
    f_curraddrmedianvalue_d = NULL                                       => -0.0050642158,
                                                                            -0.0050642158));

final_score_150_c992 := __common__( map(
    NULL < (Integer)k_inf_contradictory_i AND (Real)k_inf_contradictory_i <= 0.5 => -0.0151711920,
    (Real)k_inf_contradictory_i > 0.5                                   => -0.1157599136,
    (Integer)k_inf_contradictory_i = NULL                                  => -0.0492890040,
                                                                     -0.0492890040));

final_score_150_c990 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 493805 => final_score_150_c991,
    f_prevaddrmedianvalue_d > 493805                                     => final_score_150_c992,
    f_prevaddrmedianvalue_d = NULL                                       => -0.0103883387,
                                                                            -0.0068785642));

final_score_150 := __common__( map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -48531 => final_score_150_c989,
    f_addrchangeincomediff_d > -48531                                      => 0.0044588907,
    f_addrchangeincomediff_d = NULL                                        => final_score_150_c990,
                                                                              0.0021605172));

final_score_151_c996 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.74784718525 => -0.0166183968,
    f_add_input_mobility_index_i > 0.74784718525                                          => 0.1092781204,
    f_add_input_mobility_index_i = NULL                                                   => -0.0151063833,
                                                                                             -0.0151063833));

final_score_151_c995 := __common__( map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 341.5 => 0.0057388307,
    f_m_bureau_adl_fs_all_d > 341.5                                     => final_score_151_c996,
    f_m_bureau_adl_fs_all_d = NULL                                      => 0.0014008279,
                                                                           0.0014008279));

final_score_151_c994 := __common__( map(
    NULL < r_c16_inv_ssn_per_adl_i AND r_c16_inv_ssn_per_adl_i <= 0.5 => final_score_151_c995,
    r_c16_inv_ssn_per_adl_i > 0.5                                     => -0.0413126429,
    r_c16_inv_ssn_per_adl_i = NULL                                    => 0.0003226276,
                                                                         0.0003226276));

final_score_151_c997 := __common__( map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -26806 => 0.0637395248,
    f_addrchangeincomediff_d > -26806                                      => -0.0234531483,
    f_addrchangeincomediff_d = NULL                                        => -0.0536481870,
                                                                              -0.0254713496));

final_score_151 := __common__( map(
    NULL < r_a50_pb_total_orders_d AND r_a50_pb_total_orders_d <= 5.5 => final_score_151_c994,
    r_a50_pb_total_orders_d > 5.5                                     => final_score_151_c997,
    r_a50_pb_total_orders_d = NULL                                    => -0.0094518450,
                                                                         -0.0027435948));

final_score_152_c1001 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.83294401415 => 0.0023036465,
    f_add_input_mobility_index_i > 0.83294401415                                          => 0.0950877636,
    f_add_input_mobility_index_i = NULL                                                   => -0.0505725340,
                                                                                             0.0023310399));

final_score_152_c1000 := __common__( map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 28170 => 0.0728576131,
    r_l80_inp_avm_autoval_d > 28170                                     => 0.0045486740,
    r_l80_inp_avm_autoval_d = NULL                                      => final_score_152_c1001,
                                                                           0.0046930579));

final_score_152_c999 := __common__( map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 188.5 => final_score_152_c1000,
    f_fp_prevaddrburglaryindex_i > 188.5                                          => -0.0490318855,
    f_fp_prevaddrburglaryindex_i = NULL                                           => -0.0036071507,
                                                                                     0.0031126952));

final_score_152_c1002 := __common__( map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.0268226092 => -0.0394330581,
    f_add_curr_nhood_bus_pct_i > 0.0268226092                                        => -0.0013060004,
    f_add_curr_nhood_bus_pct_i = NULL                                                => 0.0026762532,
                                                                                        -0.0126882371));

final_score_152 := __common__( map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.07347192925 => final_score_152_c999,
    f_add_input_nhood_vac_pct_i > 0.07347192925                                         => final_score_152_c1002,
    f_add_input_nhood_vac_pct_i = NULL                                                  => -0.0004648863,
                                                                                           -0.0004648863));

final_score_153_c1004 := __common__( map(
    NULL < f_divssnidmsrcurelcount_i AND f_divssnidmsrcurelcount_i <= 3.5 => 0.0017013301,
    f_divssnidmsrcurelcount_i > 3.5                                       => 0.0924807982,
    f_divssnidmsrcurelcount_i = NULL                                      => 0.0021485014,
                                                                             0.0021485014));

final_score_153_c1006 := __common__( map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 7.5 => 0.0467405765,
    r_c13_curr_addr_lres_d > 7.5                                    => 0.1963260471,
    r_c13_curr_addr_lres_d = NULL                                   => 0.1163751921,
                                                                       0.1163751921));

final_score_153_c1007 := __common__( map(
    NULL < f_liens_unrel_sc_total_amt_i AND f_liens_unrel_sc_total_amt_i <= 317.5 => -0.0278404622,
    f_liens_unrel_sc_total_amt_i > 317.5                                          => 0.1488829388,
    f_liens_unrel_sc_total_amt_i = NULL                                           => 0.0125073463,
                                                                                     0.0125073463));

final_score_153_c1005 := __common__( map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 1.5 => final_score_153_c1006,
    r_c18_invalid_addrs_per_adl_i > 1.5                                           => final_score_153_c1007,
    r_c18_invalid_addrs_per_adl_i = NULL                                          => 0.0484735257,
                                                                                     0.0484735257));

final_score_153 := __common__( map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 6.5 => final_score_153_c1004,
    r_c14_addrs_5yr_i > 6.5                               => final_score_153_c1005,
    r_c14_addrs_5yr_i = NULL                              => -0.0112433850,
                                                             0.0027414450));

final_score_154_c1010 := __common__( map(
    NULL < r_f01_inp_addr_not_verified_i AND r_f01_inp_addr_not_verified_i <= 0.5 => -0.0050597916,
    r_f01_inp_addr_not_verified_i > 0.5                                           => -0.0502017742,
    r_f01_inp_addr_not_verified_i = NULL                                          => -0.0103345342,
                                                                                     -0.0103345342));

final_score_154_c1009 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.9019845452 => 0.0075978181,
    f_add_input_nhood_mfd_pct_i > 0.9019845452                                         => final_score_154_c1010,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => 0.0001463311,
                                                                                          0.0041062906));

final_score_154_c1012 := __common__( map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 14.5 => 0.0570321512,
    f_rel_under100miles_cnt_d > 14.5                                       => -0.0582087859,
    f_rel_under100miles_cnt_d = NULL                                       => 0.0342429322,
                                                                              0.0342429322));

final_score_154_c1011 := __common__( map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 16 => final_score_154_c1012,
    r_f01_inp_addr_address_score_d > 16                                            => -0.0209215419,
    r_f01_inp_addr_address_score_d = NULL                                          => -0.0173478808,
                                                                                      -0.0173478808));

final_score_154 := __common__( map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 323.5 => final_score_154_c1009,
    f_m_bureau_adl_fs_all_d > 323.5                                     => final_score_154_c1011,
    f_m_bureau_adl_fs_all_d = NULL                                      => -0.0098311425,
                                                                           -0.0019824623));

final_score_155_c1016 := __common__( map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 2 => -0.0709475881,
    r_i60_inq_hiriskcred_recency_d > 2                                            => 0.0047965876,
    r_i60_inq_hiriskcred_recency_d = NULL                                         => 0.0022963455,
                                                                                     0.0022963455));

final_score_155_c1015 := __common__( map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 91.5 => final_score_155_c1016,
    f_curraddrburglaryindex_i > 91.5                                       => -0.0204132922,
    f_curraddrburglaryindex_i = NULL                                       => -0.0086761390,
                                                                              -0.0086761390));

final_score_155_c1014 := __common__( map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 6.5 => final_score_155_c1015,
    f_rel_under25miles_cnt_d > 6.5                                      => 0.0057343258,
    f_rel_under25miles_cnt_d = NULL                                     => 0.0059288331,
                                                                           -0.0007885057));

final_score_155_c1017 := __common__( map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 1.5 => 0.0117664090,
    f_rel_incomeover75_count_d > 1.5                                        => 0.1596795738,
    f_rel_incomeover75_count_d = NULL                                       => 0.0525530957,
                                                                               0.0525530957));

final_score_155 := __common__( map(
    NULL < r_l72_add_curr_vacant_i AND r_l72_add_curr_vacant_i <= 0.5 => final_score_155_c1014,
    r_l72_add_curr_vacant_i > 0.5                                     => final_score_155_c1017,
    r_l72_add_curr_vacant_i = NULL                                    => 0.0231695514,
                                                                         -0.0000731440));

final_score_156_c1020 := __common__( map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 7.5 => -0.0860554025,
    f_addrs_per_ssn_i > 7.5                               => -0.0167090869,
    f_addrs_per_ssn_i = NULL                              => -0.0355478986,
                                                             -0.0355478986));

final_score_156_c1021 := __common__( map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 11.5 => -0.0523996058,
    f_m_bureau_adl_fs_all_d > 11.5                                     => -0.0008370702,
    f_m_bureau_adl_fs_all_d = NULL                                     => -0.0013859214,
                                                                          -0.0013859214));

final_score_156_c1019 := __common__( map(
    NULL < f_mos_liens_unrel_st_fseen_d AND f_mos_liens_unrel_st_fseen_d <= 79.5 => final_score_156_c1020,
    f_mos_liens_unrel_st_fseen_d > 79.5                                          => final_score_156_c1021,
    f_mos_liens_unrel_st_fseen_d = NULL                                          => 0.0186934022,
                                                                                    -0.0025758120));

final_score_156_c1022 := __common__( map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 21.5 => 0.0159989870,
    f_rel_homeover100_count_d > 21.5                                       => 0.1125067834,
    f_rel_homeover100_count_d = NULL                                       => 0.0231873648,
                                                                              0.0231873648));

final_score_156 := __common__( map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 1.5 => final_score_156_c1019,
    k_inq_adls_per_phone_i > 1.5                                    => final_score_156_c1022,
    k_inq_adls_per_phone_i = NULL                                   => -0.0012525559,
                                                                       -0.0012525559));

final_score_157_c1026 := __common__( map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => 0.0432201514,
    f_corrphonelastnamecount_d > 0.5                                        => -0.0051595390,
    f_corrphonelastnamecount_d = NULL                                       => 0.0171587708,
                                                                               0.0171587708));

final_score_157_c1025 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 265.5 => -0.0019820780,
    r_c13_max_lres_d > 265.5                              => final_score_157_c1026,
    r_c13_max_lres_d = NULL                               => 0.0002209425,
                                                             0.0002209425));

final_score_157_c1027 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 22.5 => 0.1677071170,
    k_comb_age_d > 22.5                          => 0.0218901200,
    k_comb_age_d = NULL                          => 0.0296352516,
                                                    0.0296352516));

final_score_157_c1024 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.9879350114 => final_score_157_c1025,
    f_add_input_nhood_sfd_pct_d > 0.9879350114                                         => final_score_157_c1027,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => 0.0015311299,
                                                                                          0.0015311299));

final_score_157 := __common__( map(
    NULL < r_i60_inq_auto_count12_i AND r_i60_inq_auto_count12_i <= 1.5 => final_score_157_c1024,
    r_i60_inq_auto_count12_i > 1.5                                      => -0.0237238398,
    r_i60_inq_auto_count12_i = NULL                                     => -0.0065537937,
                                                                           -0.0014193565));

final_score_158_c1031 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.07452275975 => -0.0036302002,
    f_add_input_nhood_bus_pct_i > 0.07452275975                                         => 0.0337710162,
    f_add_input_nhood_bus_pct_i = NULL                                                  => 0.0285467455,
                                                                                           0.0071349583));

final_score_158_c1030 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -415960 => -0.0610217831,
    f_addrchangevaluediff_d > -415960                                     => 0.0008667328,
    f_addrchangevaluediff_d = NULL                                        => final_score_158_c1031,
                                                                             0.0017175615));

final_score_158_c1029 := __common__( map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= -0.5 => -0.0618656121,
    f_add_input_nhood_vac_pct_i > -0.5                                         => final_score_158_c1030,
    f_add_input_nhood_vac_pct_i = NULL                                         => 0.0014216882,
                                                                                  0.0014216882));

final_score_158_c1032 := __common__( map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 1.5 => 0.0564465678,
    f_rel_homeover200_count_d > 1.5                                       => 0.0040457646,
    f_rel_homeover200_count_d = NULL                                      => 0.0486422032,
                                                                             0.0237679012));

final_score_158 := __common__( map(
    NULL < f_divrisktype_i AND f_divrisktype_i <= 4.5 => final_score_158_c1029,
    f_divrisktype_i > 4.5                             => final_score_158_c1032,
    f_divrisktype_i = NULL                            => 0.0277519305,
                                                         0.0025886147));

final_score_159_c1037 := __common__( map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 2.5 => 0.0741451235,
    f_rel_homeover150_count_d > 2.5                                       => -0.0061655696,
    f_rel_homeover150_count_d = NULL                                      => 0.0213512416,
                                                                             0.0213512416));

final_score_159_c1036 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.2182800983 => 0.0984715342,
    f_add_input_mobility_index_i > 0.2182800983                                          => final_score_159_c1037,
    f_add_input_mobility_index_i = NULL                                                  => 0.0379285008,
                                                                                            0.0379285008));

final_score_159_c1035 := __common__( map(
    NULL < f_corrssnaddrcount_d AND f_corrssnaddrcount_d <= 1.5 => -0.0478849178,
    f_corrssnaddrcount_d > 1.5                                  => final_score_159_c1036,
    f_corrssnaddrcount_d = NULL                                 => 0.0256042332,
                                                                   0.0256042332));

final_score_159_c1034 := __common__( map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 13.5 => final_score_159_c1035,
    r_l79_adls_per_addr_curr_i > 13.5                                        => 0.1245948965,
    r_l79_adls_per_addr_curr_i = NULL                                        => 0.0325788535,
                                                                                0.0325788535));

final_score_159 := __common__( map(
    NULL < r_d32_felony_count_i AND r_d32_felony_count_i <= 0.5 => -0.0019647015,
    r_d32_felony_count_i > 0.5                                  => final_score_159_c1034,
    r_d32_felony_count_i = NULL                                 => -0.0356969512,
                                                                   -0.0009150618));

final_score_160_c1039 := __common__( map(
    NULL < r_c15_ssns_per_adl_i AND r_c15_ssns_per_adl_i <= 1.5 => 0.0019122446,
    r_c15_ssns_per_adl_i > 1.5                                  => -0.0803409240,
    r_c15_ssns_per_adl_i = NULL                                 => 0.0015727849,
                                                                   0.0015727849));

final_score_160_c1042 := __common__( map(
    NULL < r_a50_pb_total_dollars_d AND r_a50_pb_total_dollars_d <= 22.5 => -0.1099437584,
    r_a50_pb_total_dollars_d > 22.5                                      => -0.0117625477,
    r_a50_pb_total_dollars_d = NULL                                      => -0.0181072261,
                                                                            -0.0181072261));

final_score_160_c1041 := __common__( map(
    NULL < f_assoccredbureaucount_i AND f_assoccredbureaucount_i <= 0.5 => final_score_160_c1042,
    f_assoccredbureaucount_i > 0.5                                      => -0.0757605541,
    f_assoccredbureaucount_i = NULL                                     => -0.0273805096,
                                                                           -0.0273805096));

final_score_160_c1040 := __common__( map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '3: Derog', '4: Recent Activity', '6: Other']) => final_score_160_c1041,
    (nf_seg_fraudpoint_3_0 in ['5: Vuln Vic/Friendly'])                                                            => 0.0721590230,
    nf_seg_fraudpoint_3_0 = ''                                                                                   => -0.0222603418,
                                                                                                                      -0.0222603418));

final_score_160 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 487470 => final_score_160_c1039,
    f_curraddrmedianvalue_d > 487470                                     => final_score_160_c1040,
    f_curraddrmedianvalue_d = NULL                                       => 0.0125706042,
                                                                            0.0005037060));

final_score_161_c1045 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 408675.5 => -0.0101253348,
    f_addrchangevaluediff_d > 408675.5                                     => 0.0664848411,
    f_addrchangevaluediff_d = NULL                                         => -0.0064812307,
                                                                              -0.0091234611));

final_score_161_c1047 := __common__( map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -12246.5 => 0.0365395601,
    f_addrchangeincomediff_d > -12246.5                                      => -0.0076825700,
    f_addrchangeincomediff_d = NULL                                          => -0.0207527001,
                                                                                -0.0076605471));

final_score_161_c1046 := __common__( map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 3.5 => final_score_161_c1047,
    r_l79_adls_per_addr_curr_i > 3.5                                        => 0.0146969143,
    r_l79_adls_per_addr_curr_i = NULL                                       => 0.0034768538,
                                                                               0.0034768538));

final_score_161_c1044 := __common__( map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 3.5 => final_score_161_c1045,
    f_util_adl_count_n > 3.5                                => final_score_161_c1046,
    f_util_adl_count_n = NULL                               => -0.0033598381,
                                                               -0.0033598381));

final_score_161 := __common__( map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 37.5 => 0.1003987856,
    r_d32_mos_since_fel_ls_d > 37.5                                      => final_score_161_c1044,
    r_d32_mos_since_fel_ls_d = NULL                                      => -0.0058849673,
                                                                            -0.0031588113));

final_score_162_c1051 := __common__( map(
    NULL < r_c14_addrs_10yr_i AND r_c14_addrs_10yr_i <= 11.5 => -0.0006075446,
    r_c14_addrs_10yr_i > 11.5                                => 0.1101807376,
    r_c14_addrs_10yr_i = NULL                                => 0.0018640289,
                                                                0.0018640289));

final_score_162_c1052 := __common__( map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 5.5 => 0.0269947076,
    f_inq_count24_i > 5.5                             => 0.1452557044,
    f_inq_count24_i = NULL                            => 0.0473845346,
                                                         0.0473845346));

final_score_162_c1050 := __common__( map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 28.5 => final_score_162_c1051,
    f_phones_per_addr_curr_i > 28.5                                      => final_score_162_c1052,
    f_phones_per_addr_curr_i = NULL                                      => 0.0055826054,
                                                                            0.0055826054));

final_score_162_c1049 := __common__( map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 21962 => -0.0643523905,
    r_l80_inp_avm_autoval_d > 21962                                     => final_score_162_c1050,
    r_l80_inp_avm_autoval_d = NULL                                      => -0.0018931087,
                                                                           -0.0010419025));

final_score_162 := __common__( map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= -701 => 0.0161017712,
    r_a49_curr_avm_chg_1yr_i > -701                                      => -0.0106832203,
    r_a49_curr_avm_chg_1yr_i = NULL                                      => final_score_162_c1049,
                                                                            -0.0007118764));

final_score_163_c1055 := __common__( map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 115.5 => -0.0506928338,
    r_c21_m_bureau_adl_fs_d > 115.5                                     => -0.0031846921,
    r_c21_m_bureau_adl_fs_d = NULL                                      => -0.0046169089,
                                                                           -0.0046169089));

final_score_163_c1054 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 31.5 => 0.0054403697,
    k_comb_age_d > 31.5                          => final_score_163_c1055,
    k_comb_age_d = NULL                          => -0.0017450876,
                                                    -0.0017450876));

final_score_163_c1057 := __common__( map(
    NULL < r_c14_addrs_15yr_i AND r_c14_addrs_15yr_i <= 3.5 => 0.0913349337,
    r_c14_addrs_15yr_i > 3.5                                => -0.0809620246,
    r_c14_addrs_15yr_i = NULL                               => 0.0160455066,
                                                               0.0160455066));

final_score_163_c1056 := __common__( map(
    NULL < f_rel_ageover50_count_d AND f_rel_ageover50_count_d <= 0.5 => final_score_163_c1057,
    f_rel_ageover50_count_d > 0.5                                     => 0.1634528953,
    f_rel_ageover50_count_d = NULL                                    => 0.0626397961,
                                                                         0.0626397961));

final_score_163 := __common__( map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 5.5 => final_score_163_c1054,
    r_wealth_index_d > 5.5                              => final_score_163_c1056,
    r_wealth_index_d = NULL                             => -0.0222324414,
                                                           -0.0013428068));

final_score_164_c1060 := __common__( map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 115.5 => 0.0019793710,
    f_phones_per_addr_curr_i > 115.5                                      => 0.0946950311,
    f_phones_per_addr_curr_i = NULL                                       => -0.0001498105,
                                                                             0.0021873058));

final_score_164_c1062 := __common__( map(
    NULL < f_adl_util_misc_n AND f_adl_util_misc_n <= 0.5 => -0.0719299180,
    f_adl_util_misc_n > 0.5                               => 0.0540049425,
    f_adl_util_misc_n = NULL                              => -0.0085028714,
                                                             -0.0085028714));

final_score_164_c1061 := __common__( map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.00084800355 => -0.0770498097,
    f_add_curr_nhood_vac_pct_i > 0.00084800355                                        => final_score_164_c1062,
    f_add_curr_nhood_vac_pct_i = NULL                                                 => -0.0405092239,
                                                                                         -0.0405092239));

final_score_164_c1059 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.9966291454 => final_score_164_c1060,
    f_add_input_nhood_mfd_pct_i > 0.9966291454                                         => final_score_164_c1061,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0107843573,
                                                                                          0.0007039113));

final_score_164 := __common__( map(
    NULL < r_p86_phn_pager_i AND r_p86_phn_pager_i <= 0.5 => final_score_164_c1059,
    r_p86_phn_pager_i > 0.5                               => 0.1146501676,
    r_p86_phn_pager_i = NULL                              => 0.0009370612,
                                                             0.0009370612));

final_score_165_c1065 := __common__( map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= -96687.5 => 0.1491329317,
    r_a49_curr_avm_chg_1yr_i > -96687.5                                      => -0.0013535183,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => -0.0049409929,
                                                                                -0.0030136020));

final_score_165_c1066 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 38014.5 => 0.0065019078,
    f_addrchangevaluediff_d > 38014.5                                     => 0.0442819037,
    f_addrchangevaluediff_d = NULL                                        => 0.0090335976,
                                                                             0.0091342414));

final_score_165_c1064 := __common__( map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 777.5 => final_score_165_c1065,
    r_p88_phn_dst_to_inp_add_i > 777.5                                        => -0.0263584221,
    r_p88_phn_dst_to_inp_add_i = NULL                                         => final_score_165_c1066,
                                                                                 0.0007963662));

final_score_165_c1067 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.03489522395 => -0.0546832043,
    f_add_curr_nhood_mfd_pct_i > 0.03489522395                                        => -0.0074443612,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => -0.0792074436,
                                                                                         -0.0125467392));

final_score_165 := __common__( map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 171.5 => final_score_165_c1064,
    f_prevaddrcartheftindex_i > 171.5                                       => final_score_165_c1067,
    f_prevaddrcartheftindex_i = NULL                                        => 0.0012223008,
                                                                               -0.0019805806));

final_score_166_c1071 := __common__( map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '3: Derog', '4: Recent Activity']) => -0.0985914533,
    (nf_seg_fraudpoint_3_0 in ['2: Synth ID', '5: Vuln Vic/Friendly', '6: Other'])      => 0.0151147663,
    nf_seg_fraudpoint_3_0 = ''                                                       => -0.0297271231,
                                                                                           -0.0297271231));

final_score_166_c1070 := __common__( map(
    NULL < f_crim_rel_under100miles_cnt_i AND f_crim_rel_under100miles_cnt_i <= 0.5 => -0.0305219928,
    f_crim_rel_under100miles_cnt_i > 0.5                                            => 0.0506816195,
    f_crim_rel_under100miles_cnt_i = NULL                                           => final_score_166_c1071,
                                                                                       -0.0058020083));

final_score_166_c1069 := __common__( map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 31.5 => final_score_166_c1070,
    f_m_bureau_adl_fs_all_d > 31.5                                     => -0.0718139443,
    f_m_bureau_adl_fs_all_d = NULL                                     => -0.0237605350,
                                                                          -0.0237605350));

final_score_166_c1072 := __common__( map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 114.5 => -0.0001722241,
    f_phones_per_addr_curr_i > 114.5                                      => 0.1022371815,
    f_phones_per_addr_curr_i = NULL                                       => 0.0000574029,
                                                                             0.0000574029));

final_score_166 := __common__( map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 23.5 => final_score_166_c1069,
    r_c21_m_bureau_adl_fs_d > 23.5                                     => final_score_166_c1072,
    r_c21_m_bureau_adl_fs_d = NULL                                     => 0.0179964592,
                                                                          -0.0006642498));

final_score_167_c1075 := __common__( map(
    NULL < r_i60_inq_auto_recency_d AND r_i60_inq_auto_recency_d <= 549 => -0.0222912487,
    r_i60_inq_auto_recency_d > 549                                      => 0.0458686382,
    r_i60_inq_auto_recency_d = NULL                                     => 0.0093875121,
                                                                           0.0093875121));

final_score_167_c1077 := __common__( map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 112.5 => -0.0539399962,
    f_fp_prevaddrcrimeindex_i > 112.5                                       => 0.1094777498,
    f_fp_prevaddrcrimeindex_i = NULL                                        => 0.0347363001,
                                                                               0.0347363001));

final_score_167_c1076 := __common__( map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 70801.5 => final_score_167_c1077,
    f_curraddrmedianincome_d > 70801.5                                      => 0.1812929686,
    f_curraddrmedianincome_d = NULL                                         => 0.0756739170,
                                                                               0.0756739170));

final_score_167_c1074 := __common__( map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 0.5 => final_score_167_c1075,
    f_rel_homeover500_count_d > 0.5                                       => final_score_167_c1076,
    f_rel_homeover500_count_d = NULL                                      => 0.0213968911,
                                                                             0.0213968911));

final_score_167 := __common__( map(
    NULL < f_srchaddrsrchcountwk_i AND f_srchaddrsrchcountwk_i <= 0.5 => 0.0002861778,
    f_srchaddrsrchcountwk_i > 0.5                                     => final_score_167_c1074,
    f_srchaddrsrchcountwk_i = NULL                                    => -0.0121902412,
                                                                         0.0011026192));

final_score_168_c1081 := __common__( map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 27.5 => 0.0063541824,
    f_m_bureau_adl_fs_notu_d > 27.5                                      => 0.1307005939,
    f_m_bureau_adl_fs_notu_d = NULL                                      => 0.0557931171,
                                                                            0.0557931171));

final_score_168_c1082 := __common__( map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 106.5 => -0.0422187847,
    r_c10_m_hdr_fs_d > 106.5                              => 0.0012684992,
    r_c10_m_hdr_fs_d = NULL                               => -0.0038370209,
                                                             -0.0038370209));

final_score_168_c1080 := __common__( map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 38.5 => final_score_168_c1081,
    r_c21_m_bureau_adl_fs_d > 38.5                                     => final_score_168_c1082,
    r_c21_m_bureau_adl_fs_d = NULL                                     => -0.0002146973,
                                                                          -0.0002146973));

final_score_168_c1079 := __common__( map(
    NULL < f_divaddrsuspidcountnew_i AND f_divaddrsuspidcountnew_i <= 3.5 => final_score_168_c1080,
    f_divaddrsuspidcountnew_i > 3.5                                       => -0.0583754671,
    f_divaddrsuspidcountnew_i = NULL                                      => -0.0028688326,
                                                                             -0.0028688326));

final_score_168 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -288918 => 0.0439226272,
    f_addrchangevaluediff_d > -288918                                     => 0.0030582402,
    f_addrchangevaluediff_d = NULL                                        => final_score_168_c1079,
                                                                             0.0023997974));

final_score_169_c1086 := __common__( map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 57 => -0.0241471770,
    f_prevaddrlenofres_d > 57                                  => 0.1067371020,
    f_prevaddrlenofres_d = NULL                                => 0.0538264360,
                                                                  0.0538264360));

final_score_169_c1085 := __common__( map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 122471.5 => -0.0003904716,
    f_curraddrmedianincome_d > 122471.5                                      => final_score_169_c1086,
    f_curraddrmedianincome_d = NULL                                          => 0.0000230118,
                                                                                0.0000230118));

final_score_169_c1087 := __common__( map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 11.5 => 0.0965822389,
    f_rel_under100miles_cnt_d > 11.5                                       => -0.0262981954,
    f_rel_under100miles_cnt_d = NULL                                       => 0.0563535253,
                                                                              0.0563535253));

final_score_169_c1084 := __common__( map(
    NULL < f_srchcountwk_i AND f_srchcountwk_i <= 1.5 => final_score_169_c1085,
    f_srchcountwk_i > 1.5                             => final_score_169_c1087,
    f_srchcountwk_i = NULL                            => 0.0004133291,
                                                         0.0004133291));

final_score_169 := __common__( map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 50.5 => final_score_169_c1084,
    r_l79_adls_per_addr_curr_i > 50.5                                        => -0.0779406180,
    r_l79_adls_per_addr_curr_i = NULL                                        => 0.0035111221,
                                                                                0.0001944451));

final_score_170_c1091 := __common__( map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 211 => 0.0881742829,
    r_d32_mos_since_fel_ls_d > 211                                      => 0.0075274432,
    r_d32_mos_since_fel_ls_d = NULL                                     => 0.0087607651,
                                                                           0.0087607651));

final_score_170_c1090 := __common__( map(
    NULL < f_current_count_d AND f_current_count_d <= 1.5 => final_score_170_c1091,
    f_current_count_d > 1.5                               => -0.0089107526,
    f_current_count_d = NULL                              => 0.0246067597,
                                                             0.0023888791));

final_score_170_c1092 := __common__( map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= -0.5 => 0.1513525375,
    r_pb_order_freq_d > -0.5                               => 0.0131999615,
    r_pb_order_freq_d = NULL                               => 0.0279730511,
                                                              0.0562560272));

final_score_170_c1089 := __common__( map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i <= 0.5 => final_score_170_c1090,
    r_p85_phn_disconnected_i > 0.5                                      => final_score_170_c1092,
    r_p85_phn_disconnected_i = NULL                                     => 0.0034308466,
                                                                           0.0034308466));

final_score_170 := __common__( map(
    NULL < (Integer)k_inf_phn_verd_d AND (Real)k_inf_phn_verd_d <= 0.5 => final_score_170_c1089,
    (Real)k_inf_phn_verd_d > 0.5                              => -0.0122313876,
    (Integer)k_inf_phn_verd_d = NULL                             => -0.0016940739,
                                                           -0.0016940739));

final_score_171_c1095 := __common__( map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 13.5 => 0.0018030297,
    r_d30_derog_count_i > 13.5                                 => 0.0855944921,
    r_d30_derog_count_i = NULL                                 => 0.0123136616,
                                                                  0.0123136616));

final_score_171_c1097 := __common__( map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 129.5 => 0.1371294697,
    f_curraddrcartheftindex_i > 129.5                                       => 0.3215874801,
    f_curraddrcartheftindex_i = NULL                                        => 0.2226509109,
                                                                               0.2226509109));

final_score_171_c1096 := __common__( map(
    NULL < f_corrssnnamecount_d AND f_corrssnnamecount_d <= 6.5 => final_score_171_c1097,
    f_corrssnnamecount_d > 6.5                                  => 0.0177495594,
    f_corrssnnamecount_d = NULL                                 => 0.1157458579,
                                                                   0.1157458579));

final_score_171_c1094 := __common__( map(
    NULL < f_corraddrphonecount_d AND f_corraddrphonecount_d <= 1.5 => final_score_171_c1095,
    f_corraddrphonecount_d > 1.5                                    => final_score_171_c1096,
    f_corraddrphonecount_d = NULL                                   => 0.0266705748,
                                                                       0.0266705748));

final_score_171 := __common__( map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d <= 13.5 => final_score_171_c1094,
    f_mos_acc_lseen_d > 13.5                               => -0.0021184243,
    f_mos_acc_lseen_d = NULL                               => -0.0365982578,
                                                              -0.0002854574));

final_score_172_c1101 := __common__( map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 8.5 => 0.0041369576,
    f_rel_homeover100_count_d > 8.5                                       => -0.0090312117,
    f_rel_homeover100_count_d = NULL                                      => 0.0016010473,
                                                                             -0.0010176546));

final_score_172_c1100 := __common__( map(
    NULL < f_srchphonesrchcountmo_i AND f_srchphonesrchcountmo_i <= 3.5 => final_score_172_c1101,
    f_srchphonesrchcountmo_i > 3.5                                      => -0.0861862502,
    f_srchphonesrchcountmo_i = NULL                                     => -0.0014075395,
                                                                           -0.0014075395));

final_score_172_c1099 := __common__( map(
    NULL < r_c16_inv_ssn_per_adl_i AND r_c16_inv_ssn_per_adl_i <= 0.5 => final_score_172_c1100,
    r_c16_inv_ssn_per_adl_i > 0.5                                     => -0.0436724345,
    r_c16_inv_ssn_per_adl_i = NULL                                    => -0.0243061202,
                                                                         -0.0023951287));

final_score_172_c1102 := __common__( map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 4.5 => 0.0967263940,
    f_rel_educationover12_count_d > 4.5                                           => 0.0127235197,
    f_rel_educationover12_count_d = NULL                                          => 0.0427642827,
                                                                                     0.0427642827));

final_score_172 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.94767828655 => final_score_172_c1099,
    f_add_input_mobility_index_i > 0.94767828655                                          => final_score_172_c1102,
    f_add_input_mobility_index_i = NULL                                                   => -0.0073537825,
                                                                                             -0.0021353508));

final_score_173_c1107 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.44853128835 => -0.0118431189,
    f_add_input_mobility_index_i > 0.44853128835                                          => -0.1064343232,
    f_add_input_mobility_index_i = NULL                                                   => -0.0165022504,
                                                                                             -0.0165022504));

final_score_173_c1106 := __common__( map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 75.05 => final_score_173_c1107,
    r_c12_source_profile_d > 75.05                                    => 0.0452746325,
    r_c12_source_profile_d = NULL                                     => -0.0092050315,
                                                                         -0.0092050315));

final_score_173_c1105 := __common__( map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 179.5 => final_score_173_c1106,
    f_curraddrcartheftindex_i > 179.5                                       => -0.0667490471,
    f_curraddrcartheftindex_i = NULL                                        => -0.0153769448,
                                                                               -0.0153769448));

final_score_173_c1104 := __common__( map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 74500 => 0.0054728142,
    k_estimated_income_d > 74500                                  => final_score_173_c1105,
    k_estimated_income_d = NULL                                   => 0.0027680135,
                                                                     0.0027680135));

final_score_173 := __common__( map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 3.5 => -0.0139299096,
    f_sourcerisktype_i > 3.5                                => final_score_173_c1104,
    f_sourcerisktype_i = NULL                               => 0.0033217214,
                                                               -0.0024380416));

final_score_174_c1110 := __common__( map(
    NULL < f_acc_damage_amt_total_i AND f_acc_damage_amt_total_i <= 6500.5 => 0.0011517120,
    f_acc_damage_amt_total_i > 6500.5                                      => 0.1031457949,
    f_acc_damage_amt_total_i = NULL                                        => 0.0016613691,
                                                                              0.0016613691));

final_score_174_c1112 := __common__( map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i <= 114.5 => 0.0671192180,
    f_prevaddrmurderindex_i > 114.5                                     => -0.0464995597,
    f_prevaddrmurderindex_i = NULL                                      => 0.0208575007,
                                                                           0.0208575007));

final_score_174_c1111 := __common__( map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 146.5 => final_score_174_c1112,
    f_fp_prevaddrburglaryindex_i > 146.5                                          => 0.1593973789,
    f_fp_prevaddrburglaryindex_i = NULL                                           => 0.0519939885,
                                                                                     0.0519939885));

final_score_174_c1109 := __common__( map(
    NULL < f_inq_collection_count24_i AND f_inq_collection_count24_i <= 5.5 => final_score_174_c1110,
    f_inq_collection_count24_i > 5.5                                        => final_score_174_c1111,
    f_inq_collection_count24_i = NULL                                       => 0.0254167309,
                                                                               0.0025127144));

final_score_174 := __common__( map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 3.5 => final_score_174_c1109,
    k_inq_adls_per_phone_i > 3.5                                    => 0.0776749270,
    k_inq_adls_per_phone_i = NULL                                   => 0.0026816250,
                                                                       0.0026816250));

final_score_175_c1114 := __common__( map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 15.5 => 0.0017031317,
    r_l79_adls_per_addr_c6_i > 15.5                                      => -0.0858340855,
    r_l79_adls_per_addr_c6_i = NULL                                      => 0.0013573911,
                                                                            0.0013573911));

final_score_175_c1117 := __common__( map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 2.5 => 0.0515174368,
    f_rel_ageover30_count_d > 2.5                                     => -0.0244745763,
    f_rel_ageover30_count_d = NULL                                    => 0.0038747758,
                                                                         0.0038747758));

final_score_175_c1116 := __common__( map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 13.5 => final_score_175_c1117,
    f_rel_under500miles_cnt_d > 13.5                                       => 0.1199799338,
    f_rel_under500miles_cnt_d = NULL                                       => 0.0197191038,
                                                                              0.0197191038));

final_score_175_c1115 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.1987704082 => 0.1001632955,
    f_add_curr_mobility_index_i > 0.1987704082                                         => final_score_175_c1116,
    f_add_curr_mobility_index_i = NULL                                                 => 0.0316208291,
                                                                                          0.0316208291));

final_score_175 := __common__( map(
    NULL < f_divaddrsuspidcountnew_i AND f_divaddrsuspidcountnew_i <= 5.5 => final_score_175_c1114,
    f_divaddrsuspidcountnew_i > 5.5                                       => final_score_175_c1115,
    f_divaddrsuspidcountnew_i = NULL                                      => 0.0212013991,
                                                                             0.0020911037));

final_score_176_c1121 := __common__( map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.00045289855 => 0.1034631978,
    f_add_input_nhood_vac_pct_i > 0.00045289855                                         => 0.0158065194,
    f_add_input_nhood_vac_pct_i = NULL                                                  => 0.0320392376,
                                                                                           0.0320392376));

final_score_176_c1122 := __common__( map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 257724 => -0.0439783702,
    r_a46_curr_avm_autoval_d > 257724                                      => 0.0924587486,
    r_a46_curr_avm_autoval_d = NULL                                        => 0.0134947695,
                                                                              0.0153693797));

final_score_176_c1120 := __common__( map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d <= 0.5 => final_score_176_c1121,
    f_rel_incomeover25_count_d > 0.5                                        => 0.0001798716,
    f_rel_incomeover25_count_d = NULL                                       => final_score_176_c1122,
                                                                               0.0012777407));

final_score_176_c1119 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.1272582801 => final_score_176_c1120,
    f_add_input_nhood_bus_pct_i > 0.1272582801                                         => -0.0156789579,
    f_add_input_nhood_bus_pct_i = NULL                                                 => -0.0192693253,
                                                                                          -0.0010484871));

final_score_176 := __common__( map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.99791230825 => final_score_176_c1119,
    f_add_curr_nhood_sfd_pct_d > 0.99791230825                                        => 0.0710554709,
    f_add_curr_nhood_sfd_pct_d = NULL                                                 => -0.0059483415,
                                                                                         -0.0001294280));

final_score_177_c1127 := __common__( map(
    NULL < f_divaddrsuspidcountnew_i AND f_divaddrsuspidcountnew_i <= 4.5 => -0.0011231924,
    f_divaddrsuspidcountnew_i > 4.5                                       => 0.0637377509,
    f_divaddrsuspidcountnew_i = NULL                                      => -0.0003266309,
                                                                             -0.0003266309));

final_score_177_c1126 := __common__( map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 111.5 => final_score_177_c1127,
    f_addrchangecrimediff_i > 111.5                                     => 0.0538088260,
    f_addrchangecrimediff_i = NULL                                      => 0.0029054323,
                                                                           0.0006463403));

final_score_177_c1125 := __common__( map(
    NULL < f_srchssnsrchcountday_i AND f_srchssnsrchcountday_i <= 0.5 => final_score_177_c1126,
    f_srchssnsrchcountday_i > 0.5                                     => 0.0925250208,
    f_srchssnsrchcountday_i = NULL                                    => 0.0010203693,
                                                                         0.0010203693));

final_score_177_c1124 := __common__( map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 12.5 => final_score_177_c1125,
    r_l79_adls_per_addr_c6_i > 12.5                                      => -0.0273404823,
    r_l79_adls_per_addr_c6_i = NULL                                      => 0.0003132536,
                                                                            0.0003132536));

final_score_177 := __common__( map(
    NULL < r_i60_inq_count12_i AND r_i60_inq_count12_i <= 8.5 => final_score_177_c1124,
    r_i60_inq_count12_i > 8.5                                 => -0.0387595711,
    r_i60_inq_count12_i = NULL                                => 0.0329210657,
                                                                 -0.0006963516));

final_score_178_c1130 := __common__( map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 145.5 => 0.0075018198,
    f_addrchangecrimediff_i > 145.5                                     => -0.0897434875,
    f_addrchangecrimediff_i = NULL                                      => 0.0046316231,
                                                                           0.0063871386));

final_score_178_c1129 := __common__( map(
    NULL < f_srchssnsrchcountday_i AND f_srchssnsrchcountday_i <= 0.5 => final_score_178_c1130,
    f_srchssnsrchcountday_i > 0.5                                     => 0.1186108809,
    f_srchssnsrchcountday_i = NULL                                    => 0.0070122161,
                                                                         0.0070122161));

final_score_178_c1132 := __common__( map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 2.5 => -0.0044574938,
    r_s66_adlperssn_count_i > 2.5                                     => 0.0258586208,
    r_s66_adlperssn_count_i = NULL                                    => 0.0020767981,
                                                                         0.0020767981));

final_score_178_c1131 := __common__( map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.03023214065 => -0.0156124201,
    f_add_curr_nhood_bus_pct_i > 0.03023214065                                        => final_score_178_c1132,
    f_add_curr_nhood_bus_pct_i = NULL                                                 => -0.0467236131,
                                                                                         -0.0054161799));

final_score_178 := __common__( map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 79.5 => final_score_178_c1129,
    f_fp_prevaddrburglaryindex_i > 79.5                                          => final_score_178_c1131,
    f_fp_prevaddrburglaryindex_i = NULL                                          => -0.0337201277,
                                                                                    -0.0004811564));

final_score_179_c1136 := __common__( map(
    NULL < r_a50_pb_average_dollars_d AND r_a50_pb_average_dollars_d <= 84.5 => 0.0223297253,
    r_a50_pb_average_dollars_d > 84.5                                        => 0.1576942506,
    r_a50_pb_average_dollars_d = NULL                                        => 0.0979584884,
                                                                                0.0979584884));

final_score_179_c1135 := __common__( map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 32500 => final_score_179_c1136,
    k_estimated_income_d > 32500                                  => 0.0220184732,
    k_estimated_income_d = NULL                                   => 0.0389626320,
                                                                     0.0389626320));

final_score_179_c1134 := __common__( map(
    NULL < f_mos_liens_unrel_st_fseen_d AND f_mos_liens_unrel_st_fseen_d <= 212.5 => -0.0772746055,
    f_mos_liens_unrel_st_fseen_d > 212.5                                          => final_score_179_c1135,
    f_mos_liens_unrel_st_fseen_d = NULL                                           => 0.0240439944,
                                                                                     0.0240439944));

final_score_179_c1137 := __common__( map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 19.5 => -0.0125588619,
    f_rel_homeover150_count_d > 19.5                                       => 0.1171333905,
    f_rel_homeover150_count_d = NULL                                       => -0.0075229045,
                                                                              -0.0075229045));

final_score_179 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.00660974985 => final_score_179_c1134,
    f_add_input_nhood_mfd_pct_i > 0.00660974985                                         => -0.0025525252,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => final_score_179_c1137,
                                                                                           -0.0015988500));

final_score_180_c1140 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.92319326215 => -0.0062626408,
    f_add_curr_nhood_mfd_pct_i > 0.92319326215                                        => 0.0377528583,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => -0.0005075543,
                                                                                         -0.0018082642));

final_score_180_c1139 := __common__( map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -3.5 => 0.0211786839,
    f_addrchangecrimediff_i > -3.5                                     => -0.0014309063,
    f_addrchangecrimediff_i = NULL                                     => final_score_180_c1140,
                                                                          -0.0000293603));

final_score_180_c1142 := __common__( map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 6.5 => -0.0105257124,
    r_p88_phn_dst_to_inp_add_i > 6.5                                        => -0.0835836659,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => -0.0264496567,
                                                                               -0.0277893579));

final_score_180_c1141 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.4836700342 => final_score_180_c1142,
    f_add_curr_mobility_index_i > 0.4836700342                                         => 0.1252160078,
    f_add_curr_mobility_index_i = NULL                                                 => -0.0202645038,
                                                                                          -0.0202645038));

final_score_180 := __common__( map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 195.5 => final_score_180_c1139,
    f_prevaddrcartheftindex_i > 195.5                                       => final_score_180_c1141,
    f_prevaddrcartheftindex_i = NULL                                        => 0.0057164618,
                                                                               -0.0008544067));

final_score_181_c1144 := __common__( map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 106500 => -0.0009011309,
    k_estimated_income_d > 106500                                  => -0.0451181670,
    k_estimated_income_d = NULL                                    => -0.0013356876,
                                                                      -0.0013356876));

final_score_181_c1147 := __common__( map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 61.5 => 0.1058811383,
    f_prevaddrageoldest_d > 61.5                                   => -0.0198561823,
    f_prevaddrageoldest_d = NULL                                   => 0.0288792133,
                                                                      0.0288792133));

final_score_181_c1146 := __common__( map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.044200977 => final_score_181_c1147,
    f_add_curr_nhood_bus_pct_i > 0.044200977                                        => -0.0681425418,
    f_add_curr_nhood_bus_pct_i = NULL                                               => -0.0052490423,
                                                                                       -0.0052490423));

final_score_181_c1145 := __common__( map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 96.5 => -0.1106722596,
    f_m_bureau_adl_fs_all_d > 96.5                                     => final_score_181_c1146,
    f_m_bureau_adl_fs_all_d = NULL                                     => -0.0304420905,
                                                                          -0.0304420905));

final_score_181 := __common__( map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 94.5 => final_score_181_c1144,
    f_phones_per_addr_curr_i > 94.5                                      => final_score_181_c1145,
    f_phones_per_addr_curr_i = NULL                                      => 0.0196055561,
                                                                            -0.0016051257));

final_score_182_c1152 := __common__( map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 70 => 0.0881221678,
    f_fp_prevaddrburglaryindex_i > 70                                          => -0.0136080269,
    f_fp_prevaddrburglaryindex_i = NULL                                        => 0.0454611184,
                                                                                  0.0454611184));

final_score_182_c1151 := __common__( map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d <= 4.5 => -0.0100031009,
    r_c14_addr_stability_v2_d > 4.5                                       => final_score_182_c1152,
    r_c14_addr_stability_v2_d = NULL                                      => 0.0053714815,
                                                                             0.0053714815));

final_score_182_c1150 := __common__( map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 18.5 => final_score_182_c1151,
    f_bus_addr_match_count_d > 18.5                                      => -0.0709302816,
    f_bus_addr_match_count_d = NULL                                      => -0.0003694172,
                                                                            -0.0003694172));

final_score_182_c1149 := __common__( map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 8.5 => 0.0005430516,
    f_rel_incomeover100_count_d > 8.5                                         => 0.0933222993,
    f_rel_incomeover100_count_d = NULL                                        => final_score_182_c1150,
                                                                                 0.0008935883));

final_score_182 := __common__( map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d <= 18 => -0.0808324278,
    r_i60_inq_prepaidcards_recency_d > 18                                              => final_score_182_c1149,
    r_i60_inq_prepaidcards_recency_d = NULL                                            => -0.0497869826,
                                                                                          0.0005456096));

final_score_183_c1155 := __common__( map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 5.5 => 0.0183457086,
    r_p88_phn_dst_to_inp_add_i > 5.5                                        => -0.0393722227,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => -0.0046545594,
                                                                               0.0018257595));

final_score_183_c1157 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 185503 => 0.2631481933,
    f_curraddrmedianvalue_d > 185503                                     => 0.0393822864,
    f_curraddrmedianvalue_d = NULL                                       => 0.0469624323,
                                                                            0.0469624323));

final_score_183_c1156 := __common__( map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 132 => final_score_183_c1157,
    f_fp_prevaddrcrimeindex_i > 132                                       => -0.0046046904,
    f_fp_prevaddrcrimeindex_i = NULL                                      => 0.0305677093,
                                                                             0.0305677093));

final_score_183_c1154 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 180510.5 => final_score_183_c1155,
    f_curraddrmedianvalue_d > 180510.5                                     => final_score_183_c1156,
    f_curraddrmedianvalue_d = NULL                                         => 0.0131364668,
                                                                              0.0131364668));

final_score_183 := __common__( map(
    NULL < r_i60_inq_recency_d AND r_i60_inq_recency_d <= 4.5 => final_score_183_c1154,
    r_i60_inq_recency_d > 4.5                                 => -0.0028605585,
    r_i60_inq_recency_d = NULL                                => -0.0130988930,
                                                                 0.0006364638));

final_score_184_c1161 := __common__( map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d <= 2.5 => 0.0657081537,
    f_rel_incomeover25_count_d > 2.5                                        => 0.0224884995,
    f_rel_incomeover25_count_d = NULL                                       => 0.0184094776,
                                                                               0.0307470173));

final_score_184_c1160 := __common__( map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => final_score_184_c1161,
    r_phn_pcs_n > 0.5                         => 0.0053259684,
    r_phn_pcs_n = NULL                        => 0.0166840630,
                                                 0.0166840630));

final_score_184_c1162 := __common__( map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 29.5 => 0.0030294178,
    f_bus_addr_match_count_d > 29.5                                      => -0.0340802199,
    f_bus_addr_match_count_d = NULL                                      => 0.0009687071,
                                                                            0.0009687071));

final_score_184_c1159 := __common__( map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_184_c1160,
    r_phn_cell_n > 0.5                          => final_score_184_c1162,
    r_phn_cell_n = NULL                         => 0.0072431535,
                                                   0.0072431535));

final_score_184 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.27220091855 => -0.0038355240,
    f_add_curr_nhood_mfd_pct_i > 0.27220091855                                        => final_score_184_c1159,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => -0.0110808563,
                                                                                         0.0004351891));

final_score_185_c1165 := __common__( map(
    NULL < f_vardobcount_i AND f_vardobcount_i <= 2.5 => 0.0002644115,
    f_vardobcount_i > 2.5                             => -0.0294855733,
    f_vardobcount_i = NULL                            => -0.0035785045,
                                                         -0.0035785045));

final_score_185_c1164 := __common__( map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 0.5 => final_score_185_c1165,
    k_inq_per_phone_i > 0.5                               => 0.0038803219,
    k_inq_per_phone_i = NULL                              => -0.0010000013,
                                                             -0.0010000013));

final_score_185_c1167 := __common__( map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 55.5 => -0.0306701606,
    f_prevaddrlenofres_d > 55.5                                  => 0.2324567908,
    f_prevaddrlenofres_d = NULL                                  => 0.0975765888,
                                                                    0.0975765888));

final_score_185_c1166 := __common__( map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 13.5 => 0.0107558560,
    r_p88_phn_dst_to_inp_add_i > 13.5                                        => 0.1146519833,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => final_score_185_c1167,
                                                                                0.0455626981));

final_score_185 := __common__( map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.99650950295 => final_score_185_c1164,
    f_add_curr_nhood_sfd_pct_d > 0.99650950295                                        => final_score_185_c1166,
    f_add_curr_nhood_sfd_pct_d = NULL                                                 => -0.0005500966,
                                                                                         -0.0001387041));

final_score_186_c1170 := __common__( map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 13.5 => -0.0062312699,
    r_d30_derog_count_i > 13.5                                 => 0.1115482493,
    r_d30_derog_count_i = NULL                                 => -0.0025176914,
                                                                  -0.0025176914));

final_score_186_c1169 := __common__( map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 95.5 => -0.0051295779,
    f_addrchangecrimediff_i > 95.5                                     => -0.0626816622,
    f_addrchangecrimediff_i = NULL                                     => final_score_186_c1170,
                                                                          -0.0054204925));

final_score_186_c1172 := __common__( map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 11.5 => 0.1131311560,
    f_mos_liens_unrel_cj_lseen_d > 11.5                                          => 0.0100002393,
    f_mos_liens_unrel_cj_lseen_d = NULL                                          => 0.0120209095,
                                                                                    0.0120209095));

final_score_186_c1171 := __common__( map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i <= 15.5 => final_score_186_c1172,
    f_rel_criminal_count_i > 15.5                                    => -0.0326294884,
    f_rel_criminal_count_i = NULL                                    => 0.0073639370,
                                                                        0.0073639370));

final_score_186 := __common__( map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 0.5 => final_score_186_c1169,
    r_d32_criminal_count_i > 0.5                                    => final_score_186_c1171,
    r_d32_criminal_count_i = NULL                                   => -0.0238732041,
                                                                       -0.0008500435));

final_score_187_c1177 := __common__( map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 159.5 => -0.0760384567,
    f_m_bureau_adl_fs_all_d > 159.5                                     => 0.0638395318,
    f_m_bureau_adl_fs_all_d = NULL                                      => -0.0210044940,
                                                                           -0.0210044940));

final_score_187_c1176 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 27.5 => 0.0574388859,
    k_comb_age_d > 27.5                          => final_score_187_c1177,
    k_comb_age_d = NULL                          => 0.0247392538,
                                                    0.0247392538));

final_score_187_c1175 := __common__( map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => final_score_187_c1176,
    r_c23_inp_addr_occ_index_d > 2                                        => -0.0124005242,
    r_c23_inp_addr_occ_index_d = NULL                                     => 0.0097627263,
                                                                             0.0097627263));

final_score_187_c1174 := __common__( map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 6.5 => 0.0035939660,
    f_rel_homeover100_count_d > 6.5                                       => -0.0059285938,
    f_rel_homeover100_count_d = NULL                                      => final_score_187_c1175,
                                                                             -0.0008939814));

final_score_187 := __common__( map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 40.5 => final_score_187_c1174,
    r_d32_criminal_count_i > 40.5                                    => 0.0781354267,
    r_d32_criminal_count_i = NULL                                    => -0.0208267318,
                                                                        -0.0006386082));

final_score_188_c1180 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 74706.5 => 0.0151839508,
    f_addrchangevaluediff_d > 74706.5                                     => 0.0967687159,
    f_addrchangevaluediff_d = NULL                                        => 0.0189624345,
                                                                             0.0207652218));

final_score_188_c1179 := __common__( map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 193.5 => -0.0048305526,
    f_fp_prevaddrcrimeindex_i > 193.5                                       => final_score_188_c1180,
    f_fp_prevaddrcrimeindex_i = NULL                                        => -0.0036960244,
                                                                               -0.0036960244));

final_score_188_c1182 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 24.5 => 0.0807234713,
    k_comb_age_d > 24.5                          => 0.0079874625,
    k_comb_age_d = NULL                          => 0.0174896290,
                                                    0.0174896290));

final_score_188_c1181 := __common__( map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 17.5 => final_score_188_c1182,
    r_d30_derog_count_i > 17.5                                 => 0.1580522279,
    r_d30_derog_count_i = NULL                                 => 0.0237985428,
                                                                  0.0237985428));

final_score_188 := __common__( map(
    NULL < f_prevaddroccupantowned_i AND f_prevaddroccupantowned_i <= 0.5 => final_score_188_c1179,
    f_prevaddroccupantowned_i > 0.5                                       => final_score_188_c1181,
    f_prevaddroccupantowned_i = NULL                                      => 0.0245819276,
                                                                             -0.0024005640));

final_score_189_c1186 := __common__( map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 188.5 => 0.0227915277,
    f_prevaddrcartheftindex_i > 188.5                                       => 0.1367980041,
    f_prevaddrcartheftindex_i = NULL                                        => 0.0316626941,
                                                                               0.0316626941));

final_score_189_c1185 := __common__( map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 409.5 => final_score_189_c1186,
    r_c10_m_hdr_fs_d > 409.5                              => 0.1466340219,
    r_c10_m_hdr_fs_d = NULL                               => 0.0400670309,
                                                             0.0400670309));

final_score_189_c1184 := __common__( map(
    NULL < f_rel_bankrupt_count_i AND f_rel_bankrupt_count_i <= 0.5 => final_score_189_c1185,
    f_rel_bankrupt_count_i > 0.5                                    => 0.0036174787,
    f_rel_bankrupt_count_i = NULL                                   => 0.0110009418,
                                                                       0.0110009418));

final_score_189_c1187 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 1.5 => 0.0092443066,
    f_inq_communications_count24_i > 1.5                                            => -0.0632788170,
    f_inq_communications_count24_i = NULL                                           => -0.0019643337,
                                                                                       -0.0027427072));

final_score_189 := __common__( map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 0.5 => -0.0040422852,
    f_rel_incomeover100_count_d > 0.5                                         => final_score_189_c1184,
    f_rel_incomeover100_count_d = NULL                                        => final_score_189_c1187,
                                                                                 -0.0009497261));

final_score_190_c1191 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.01074662125 => 0.1237042495,
    f_add_input_nhood_sfd_pct_d > 0.01074662125                                         => 0.0538335652,
    f_add_input_nhood_sfd_pct_d = NULL                                                  => 0.0634594552,
                                                                                           0.0634594552));

final_score_190_c1192 := __common__( map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 358.5 => 0.0281672565,
    f_m_bureau_adl_fs_all_d > 358.5                                     => -0.0336078304,
    f_m_bureau_adl_fs_all_d = NULL                                      => 0.0160534196,
                                                                           0.0160534196));

final_score_190_c1190 := __common__( map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 1.5 => final_score_190_c1191,
    r_d30_derog_count_i > 1.5                                 => final_score_190_c1192,
    r_d30_derog_count_i = NULL                                => 0.0235292593,
                                                                 0.0235292593));

final_score_190_c1189 := __common__( map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i <= 3.5 => final_score_190_c1190,
    f_rel_criminal_count_i > 3.5                                    => 0.0017883809,
    f_rel_criminal_count_i = NULL                                   => 0.0082447776,
                                                                       0.0082447776));

final_score_190 := __common__( map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 0.5 => -0.0034892510,
    r_d32_criminal_count_i > 0.5                                    => final_score_190_c1189,
    r_d32_criminal_count_i = NULL                                   => -0.0112161789,
                                                                       0.0007301683));

final_score_191_c1196 := __common__( map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 40 => -0.0282628755,
    f_prevaddrcartheftindex_i > 40                                       => 0.1100716403,
    f_prevaddrcartheftindex_i = NULL                                     => 0.0801417451,
                                                                            0.0801417451));

final_score_191_c1195 := __common__( map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d <= 2.5 => -0.0073727769,
    r_c14_addr_stability_v2_d > 2.5                                       => final_score_191_c1196,
    r_c14_addr_stability_v2_d = NULL                                      => 0.0545078273,
                                                                             0.0545078273));

final_score_191_c1197 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.5597467328 => -0.0653794462,
    f_add_input_nhood_mfd_pct_i > 0.5597467328                                         => 0.0283304301,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0386051958,
                                                                                          -0.0386051958));

final_score_191_c1194 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.2541318933 => final_score_191_c1195,
    f_add_curr_nhood_mfd_pct_i > 0.2541318933                                        => final_score_191_c1197,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => 0.0144091771,
                                                                                        0.0274845039));

final_score_191 := __common__( map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 6.5 => final_score_191_c1194,
    r_d32_mos_since_crim_ls_d > 6.5                                       => -0.0011902302,
    r_d32_mos_since_crim_ls_d = NULL                                      => 0.0127144278,
                                                                             -0.0001921022));

final_score_192_c1200 := __common__( map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 6.5 => 0.1082485516,
    r_c10_m_hdr_fs_d > 6.5                              => 0.0013255675,
    r_c10_m_hdr_fs_d = NULL                             => 0.0015444029,
                                                           0.0015444029));

final_score_192_c1199 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 12.5 => -0.0406021456,
    r_c13_max_lres_d > 12.5                              => final_score_192_c1200,
    r_c13_max_lres_d = NULL                              => -0.0085378898,
                                                            0.0011232598));

final_score_192_c1202 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.03073476705 => -0.0502900477,
    f_add_input_nhood_bus_pct_i > 0.03073476705                                         => 0.0249225786,
    f_add_input_nhood_bus_pct_i = NULL                                                  => -0.0087251753,
                                                                                           -0.0087251753));

final_score_192_c1201 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 25804.5 => -0.1110990743,
    f_prevaddrmedianincome_d > 25804.5                                      => final_score_192_c1202,
    f_prevaddrmedianincome_d = NULL                                         => -0.0404014041,
                                                                               -0.0404014041));

final_score_192 := __common__( map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 77.5 => final_score_192_c1199,
    f_bus_addr_match_count_d > 77.5                                      => final_score_192_c1201,
    f_bus_addr_match_count_d = NULL                                      => 0.0007519389,
                                                                            0.0007519389));

final_score_193_c1206 := __common__( map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 3.5 => -0.0293765807,
    f_addrs_per_ssn_i > 3.5                               => 0.0018337599,
    f_addrs_per_ssn_i = NULL                              => -0.0015086796,
                                                             -0.0015086796));

final_score_193_c1207 := __common__( map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => -0.0008762194,
    r_phn_pcs_n > 0.5                         => -0.0333462603,
    r_phn_pcs_n = NULL                        => -0.0077809542,
                                                 -0.0077809542));

final_score_193_c1205 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 308013 => final_score_193_c1206,
    f_addrchangevaluediff_d > 308013                                     => -0.0662731490,
    f_addrchangevaluediff_d = NULL                                       => final_score_193_c1207,
                                                                            -0.0032108453));

final_score_193_c1204 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.2426660479 => 0.0103493234,
    f_add_curr_mobility_index_i > 0.2426660479                                         => final_score_193_c1205,
    f_add_curr_mobility_index_i = NULL                                                 => 0.0176237997,
                                                                                          0.0027083000));

final_score_193 := __common__( map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.0708038284 => final_score_193_c1204,
    f_add_input_nhood_vac_pct_i > 0.0708038284                                         => -0.0164012721,
    f_add_input_nhood_vac_pct_i = NULL                                                 => -0.0017280149,
                                                                                          -0.0017280149));

final_score_194_c1210 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.0090028636 => -0.1022592677,
    f_add_input_nhood_bus_pct_i > 0.0090028636                                         => -0.0147250227,
    f_add_input_nhood_bus_pct_i = NULL                                                 => -0.0908674744,
                                                                                          -0.0278159543));

final_score_194_c1209 := __common__( map(
    NULL < r_l70_add_invalid_i AND r_l70_add_invalid_i <= 0.5 => -0.0016703408,
    r_l70_add_invalid_i > 0.5                                 => final_score_194_c1210,
    r_l70_add_invalid_i = NULL                                => -0.0024794976,
                                                                 -0.0024794976));

final_score_194_c1212 := __common__( map(
    NULL < f_hh_tot_derog_i AND f_hh_tot_derog_i <= 2.5 => 0.1689138025,
    f_hh_tot_derog_i > 2.5                              => 0.0373438408,
    f_hh_tot_derog_i = NULL                             => 0.0955116133,
                                                           0.0955116133));

final_score_194_c1211 := __common__( map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 315.5 => final_score_194_c1212,
    f_m_bureau_adl_fs_all_d > 315.5                                     => -0.0052709935,
    f_m_bureau_adl_fs_all_d = NULL                                      => 0.0382487685,
                                                                           0.0382487685));

final_score_194 := __common__( map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i <= 21069 => final_score_194_c1209,
    f_liens_unrel_cj_total_amt_i > 21069                                          => final_score_194_c1211,
    f_liens_unrel_cj_total_amt_i = NULL                                           => 0.0373718039,
                                                                                     -0.0016607156));

final_score_195_c1217 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 63473 => 0.1161962191,
    f_curraddrmedianvalue_d > 63473                                     => 0.0056798709,
    f_curraddrmedianvalue_d = NULL                                      => 0.0351910484,
                                                                           0.0351910484));

final_score_195_c1216 := __common__( map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 3.5 => final_score_195_c1217,
    f_rel_homeover200_count_d > 3.5                                       => 0.1386645493,
    f_rel_homeover200_count_d = NULL                                      => 0.0505560230,
                                                                             0.0505560230));

final_score_195_c1215 := __common__( map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d <= 4.5 => final_score_195_c1216,
    f_rel_incomeover25_count_d > 4.5                                        => 0.0174729833,
    f_rel_incomeover25_count_d = NULL                                       => 0.0204900781,
                                                                               0.0204900781));

final_score_195_c1214 := __common__( map(
    NULL < f_curraddractivephonelist_d AND f_curraddractivephonelist_d <= 0.5 => final_score_195_c1215,
    f_curraddractivephonelist_d > 0.5                                         => -0.0027622349,
    f_curraddractivephonelist_d = NULL                                        => 0.0101843286,
                                                                                 0.0101843286));

final_score_195 := __common__( map(
    NULL < f_rel_felony_count_i AND f_rel_felony_count_i <= 0.5 => -0.0018017790,
    f_rel_felony_count_i > 0.5                                  => final_score_195_c1214,
    f_rel_felony_count_i = NULL                                 => 0.0139333364,
                                                                   0.0023163364));

final_score_196_c1220 := __common__( map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 189.5 => 0.0006830722,
    f_curraddrmurderindex_i > 189.5                                     => 0.1069575146,
    f_curraddrmurderindex_i = NULL                                      => -0.0107817621,
                                                                           0.0093463687));

final_score_196_c1219 := __common__( map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 0.5 => 0.0634676260,
    f_rel_under500miles_cnt_d > 0.5                                       => -0.0127022947,
    f_rel_under500miles_cnt_d = NULL                                      => final_score_196_c1220,
                                                                             -0.0102271987));

final_score_196_c1222 := __common__( map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 5.5 => 0.0125119223,
    r_c14_addrs_5yr_i > 5.5                               => 0.0982741962,
    r_c14_addrs_5yr_i = NULL                              => 0.0150969553,
                                                             0.0150969553));

final_score_196_c1221 := __common__( map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 5.5 => -0.0027799510,
    r_l79_adls_per_addr_curr_i > 5.5                                        => final_score_196_c1222,
    r_l79_adls_per_addr_curr_i = NULL                                       => 0.0019681419,
                                                                               0.0019681419));

final_score_196 := __common__( map(
    NULL < f_adl_util_conv_n AND f_adl_util_conv_n <= 0.5 => final_score_196_c1219,
    f_adl_util_conv_n > 0.5                               => final_score_196_c1221,
    f_adl_util_conv_n = NULL                              => -0.0019241233,
                                                             -0.0019241233));

final_score_197_c1225 := __common__( map(
    NULL < (Integer)k_inf_contradictory_i AND (Real)k_inf_contradictory_i <= 0.5 => 0.0068711956,
    (Real)k_inf_contradictory_i > 0.5                                   => 0.1880381025,
    (Integer)k_inf_contradictory_i = NULL                                  => 0.0766540042,
                                                                     0.0766540042));

final_score_197_c1224 := __common__( map(
    NULL < f_liens_unrel_st_total_amt_i AND f_liens_unrel_st_total_amt_i <= 1854.5 => -0.0211405009,
    f_liens_unrel_st_total_amt_i > 1854.5                                          => final_score_197_c1225,
    f_liens_unrel_st_total_amt_i = NULL                                            => -0.0154864289,
                                                                                      -0.0154864289));

final_score_197_c1227 := __common__( map(
    NULL < f_mos_liens_rel_o_lseen_d AND f_mos_liens_rel_o_lseen_d <= 249.5 => -0.0270814712,
    f_mos_liens_rel_o_lseen_d > 249.5                                       => 0.0055330298,
    f_mos_liens_rel_o_lseen_d = NULL                                        => 0.0037564226,
                                                                               0.0037564226));

final_score_197_c1226 := __common__( map(
    NULL < f_liens_rel_sc_total_amt_i AND f_liens_rel_sc_total_amt_i <= 280.5 => final_score_197_c1227,
    f_liens_rel_sc_total_amt_i > 280.5                                        => -0.0474969539,
    f_liens_rel_sc_total_amt_i = NULL                                         => 0.0020722207,
                                                                                 0.0020722207));

final_score_197 := __common__( map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 4.5 => final_score_197_c1224,
    f_prevaddrlenofres_d > 4.5                                  => final_score_197_c1226,
    f_prevaddrlenofres_d = NULL                                 => 0.0080444285,
                                                                   0.0004454289));

final_score_198_c1230 := __common__( map(
    NULL < f_addrs_per_ssn_c6_i AND f_addrs_per_ssn_c6_i <= 0.5 => -0.0003648815,
    f_addrs_per_ssn_c6_i > 0.5                                  => 0.0157753017,
    f_addrs_per_ssn_c6_i = NULL                                 => 0.0014433330,
                                                                   0.0014433330));

final_score_198_c1229 := __common__( map(
    NULL < f_hh_members_ct_d AND f_hh_members_ct_d <= 20.5 => final_score_198_c1230,
    f_hh_members_ct_d > 20.5                               => -0.0776966299,
    f_hh_members_ct_d = NULL                               => 0.0012445211,
                                                              0.0012445211));

final_score_198_c1232 := __common__( map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i <= 0.5 => 0.1711648661,
    f_rel_criminal_count_i > 0.5                                    => 0.0232875825,
    f_rel_criminal_count_i = NULL                                   => 0.1013339266,
                                                                       0.1013339266));

final_score_198_c1231 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.0445526696 => final_score_198_c1232,
    f_add_input_nhood_bus_pct_i > 0.0445526696                                         => 0.0134127787,
    f_add_input_nhood_bus_pct_i = NULL                                                 => 0.0616132049,
                                                                                          0.0616132049));

final_score_198 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 680964.5 => final_score_198_c1229,
    f_curraddrmedianvalue_d > 680964.5                                     => final_score_198_c1231,
    f_curraddrmedianvalue_d = NULL                                         => 0.0034617175,
                                                                              0.0017325362));

final_score_199_c1236 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.3869302942 => 0.0055300145,
    f_add_curr_mobility_index_i > 0.3869302942                                         => 0.0619965394,
    f_add_curr_mobility_index_i = NULL                                                 => 0.0102823417,
                                                                                          0.0102823417));

final_score_199_c1235 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 125 => 0.1091883680,
    r_c13_max_lres_d > 125                              => final_score_199_c1236,
    r_c13_max_lres_d = NULL                             => 0.0116298352,
                                                           0.0116298352));

final_score_199_c1237 := __common__( map(
    (nf_seg_fraudpoint_3_0 in ['3: Derog'])                                                                                    => 0.0136072266,
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) => 0.1413947757,
    nf_seg_fraudpoint_3_0 = ''                                                                                               => 0.0798674372,
                                                                                                                                  0.0798674372));

final_score_199_c1234 := __common__( map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 3.5 => final_score_199_c1235,
    f_rel_homeover500_count_d > 3.5                                       => final_score_199_c1237,
    f_rel_homeover500_count_d = NULL                                      => -0.0086788967,
                                                                             0.0140907607));

final_score_199 := __common__( map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 163.5 => -0.0046119803,
    f_prevaddrageoldest_d > 163.5                                   => final_score_199_c1234,
    f_prevaddrageoldest_d = NULL                                    => -0.0003710003,
                                                                       -0.0011076267));

final_score_200_c1240 := __common__( map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 14.5 => -0.0143747369,
    f_util_adl_count_n > 14.5                                => 0.1819580268,
    f_util_adl_count_n = NULL                                => -0.0017407109,
                                                                -0.0017407109));

final_score_200_c1239 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.91847570885 => -0.0074862707,
    f_add_input_nhood_mfd_pct_i > 0.91847570885                                         => -0.0373701118,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => final_score_200_c1240,
                                                                                           -0.0094027501));

final_score_200_c1242 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 37.5 => -0.0143262649,
    k_comb_age_d > 37.5                          => -0.0613849069,
    k_comb_age_d = NULL                          => -0.0277071567,
                                                    -0.0277071567));

final_score_200_c1241 := __common__( map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '4: Recent Activity', '5: Vuln Vic/Friendly']) => final_score_200_c1242,
    (nf_seg_fraudpoint_3_0 in ['2: Synth ID', '3: Derog', '6: Other'])                              => 0.0383694241,
    nf_seg_fraudpoint_3_0 = ''                                                                    => 0.0106851650,
                                                                                                       0.0106851650));

final_score_200 := __common__( map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 6.5 => 0.0021562295,
    f_rel_homeover150_count_d > 6.5                                       => final_score_200_c1239,
    f_rel_homeover150_count_d = NULL                                      => final_score_200_c1241,
                                                                             -0.0010775622));

final_score_201_c1247 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 48905.5 => -0.0261804563,
    f_prevaddrmedianincome_d > 48905.5                                      => 0.0189511344,
    f_prevaddrmedianincome_d = NULL                                         => -0.0123975793,
                                                                               -0.0123975793));

final_score_201_c1246 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.9781279898 => final_score_201_c1247,
    f_add_input_nhood_mfd_pct_i > 0.9781279898                                         => 0.0584163086,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0096127635,
                                                                                          -0.0096127635));

final_score_201_c1245 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.9895451912 => final_score_201_c1246,
    f_add_curr_nhood_mfd_pct_i > 0.9895451912                                        => -0.0646369455,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => -0.0713813707,
                                                                                        -0.0168759573));

final_score_201_c1244 := __common__( map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i <= 1.5 => 0.0031140090,
    r_i60_inq_comm_count12_i > 1.5                                      => final_score_201_c1245,
    r_i60_inq_comm_count12_i = NULL                                     => 0.0013162694,
                                                                           0.0013162694));

final_score_201 := __common__( map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -51211 => -0.0542509443,
    f_addrchangeincomediff_d > -51211                                      => final_score_201_c1244,
    f_addrchangeincomediff_d = NULL                                        => -0.0054245276,
                                                                              -0.0001821370));

final_score_202_c1251 := __common__( map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 6.5 => -0.0084808118,
    f_rel_under100miles_cnt_d > 6.5                                       => 0.0297472624,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0175360198,
                                                                             0.0175360198));

final_score_202_c1250 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -86704 => -0.0640247809,
    f_addrchangevaluediff_d > -86704                                     => final_score_202_c1251,
    f_addrchangevaluediff_d = NULL                                       => 0.0028038036,
                                                                            0.0129168886));

final_score_202_c1249 := __common__( map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 61.5 => final_score_202_c1250,
    r_i60_inq_hiriskcred_recency_d > 61.5                                            => -0.0039517161,
    r_i60_inq_hiriskcred_recency_d = NULL                                            => -0.0003600721,
                                                                                        -0.0003600721));

final_score_202_c1252 := __common__( map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.0704803260,
    f_phone_ver_experian_d > 0.5                                    => 0.0669980525,
    f_phone_ver_experian_d = NULL                                   => 0.0687391892,
                                                                       0.0687391892));

final_score_202 := __common__( map(
    NULL < f_inq_auto_count_week_i AND f_inq_auto_count_week_i <= 0.5 => final_score_202_c1249,
    f_inq_auto_count_week_i > 0.5                                     => final_score_202_c1252,
    f_inq_auto_count_week_i = NULL                                    => -0.0071492079,
                                                                         -0.0000357880));

final_score_203_c1256 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= -0.49973147155 => 0.0465671929,
    f_add_input_nhood_sfd_pct_d > -0.49973147155                                         => 0.0083858369,
    f_add_input_nhood_sfd_pct_d = NULL                                                   => 0.0117065079,
                                                                                            0.0117065079));

final_score_203_c1255 := __common__( map(
    NULL < r_c12_source_profile_index_d AND r_c12_source_profile_index_d <= 2.5 => final_score_203_c1256,
    r_c12_source_profile_index_d > 2.5                                          => -0.0042847055,
    r_c12_source_profile_index_d = NULL                                         => -0.0023272098,
                                                                                   -0.0023272098));

final_score_203_c1257 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 124.5 => -0.0158776804,
    r_c13_max_lres_d > 124.5                              => 0.0819736992,
    r_c13_max_lres_d = NULL                               => 0.0314171531,
                                                             0.0314171531));

final_score_203_c1254 := __common__( map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i <= 0.5 => final_score_203_c1255,
    r_p85_phn_not_issued_i > 0.5                                    => final_score_203_c1257,
    r_p85_phn_not_issued_i = NULL                                   => -0.0020813393,
                                                                       -0.0020813393));

final_score_203 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 729409 => final_score_203_c1254,
    f_prevaddrmedianvalue_d > 729409                                     => -0.0583433702,
    f_prevaddrmedianvalue_d = NULL                                       => -0.0314993716,
                                                                            -0.0025021761));

final_score_204_c1261 := __common__( map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 18 => 0.1572193183,
    r_i60_inq_comm_recency_d > 18                                      => 0.0417282356,
    r_i60_inq_comm_recency_d = NULL                                    => 0.0833337188,
                                                                          0.0833337188));

final_score_204_c1262 := __common__( map(
    NULL < f_mos_liens_rel_cj_fseen_d AND f_mos_liens_rel_cj_fseen_d <= 111.5 => -0.0203878130,
    f_mos_liens_rel_cj_fseen_d > 111.5                                        => 0.0677971479,
    f_mos_liens_rel_cj_fseen_d = NULL                                         => 0.0125933624,
                                                                                 0.0125933624));

final_score_204_c1260 := __common__( map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i <= 541 => final_score_204_c1261,
    f_liens_rel_cj_total_amt_i > 541                                        => final_score_204_c1262,
    f_liens_rel_cj_total_amt_i = NULL                                       => 0.0298236156,
                                                                               0.0298236156));

final_score_204_c1259 := __common__( map(
    NULL < f_mos_liens_rel_cj_lseen_d AND f_mos_liens_rel_cj_lseen_d <= 108.5 => final_score_204_c1260,
    f_mos_liens_rel_cj_lseen_d > 108.5                                        => 0.0010840864,
    f_mos_liens_rel_cj_lseen_d = NULL                                         => 0.0018705418,
                                                                                 0.0018705418));

final_score_204 := __common__( map(
    NULL < f_mos_liens_rel_cj_lseen_d AND f_mos_liens_rel_cj_lseen_d <= 81.5 => -0.0439403638,
    f_mos_liens_rel_cj_lseen_d > 81.5                                        => final_score_204_c1259,
    f_mos_liens_rel_cj_lseen_d = NULL                                        => -0.0164105147,
                                                                                0.0004672864));

final_score_205_c1266 := __common__( map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.03149283025 => -0.0510554238,
    f_add_curr_nhood_sfd_pct_d > 0.03149283025                                        => 0.0331868912,
    f_add_curr_nhood_sfd_pct_d = NULL                                                 => -0.0064565511,
                                                                                         -0.0064565511));

final_score_205_c1265 := __common__( map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 0.5 => 0.0798973654,
    r_p88_phn_dst_to_inp_add_i > 0.5                                        => -0.0590946662,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => final_score_205_c1266,
                                                                               -0.0149979518));

final_score_205_c1267 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.5783187873 => 0.0700747409,
    f_add_input_nhood_sfd_pct_d > 0.5783187873                                         => -0.0617467957,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => 0.0469112121,
                                                                                          0.0469112121));

final_score_205_c1264 := __common__( map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 1.5 => final_score_205_c1265,
    r_s66_adlperssn_count_i > 1.5                                     => final_score_205_c1267,
    r_s66_adlperssn_count_i = NULL                                    => 0.0095158912,
                                                                         0.0095158912));

final_score_205 := __common__( map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 1.5 => 0.0182154179,
    f_rel_ageover30_count_d > 1.5                                     => -0.0018124435,
    f_rel_ageover30_count_d = NULL                                    => final_score_205_c1264,
                                                                         -0.0001722476));

final_score_206_c1271 := __common__( map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 145.5 => 0.0447451498,
    f_curraddrcartheftindex_i > 145.5                                       => 0.1651055102,
    f_curraddrcartheftindex_i = NULL                                        => 0.0981500779,
                                                                               0.0981500779));

final_score_206_c1270 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.3082581756 => final_score_206_c1271,
    f_add_input_mobility_index_i > 0.3082581756                                          => -0.0226239534,
    f_add_input_mobility_index_i = NULL                                                  => 0.0681067866,
                                                                                            0.0681067866));

final_score_206_c1272 := __common__( map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 7.5 => -0.0097288285,
    f_rel_incomeover50_count_d > 7.5                                        => 0.0789549421,
    f_rel_incomeover50_count_d = NULL                                       => 0.0174809648,
                                                                               0.0174809648));

final_score_206_c1269 := __common__( map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 4.5 => final_score_206_c1270,
    f_rel_under500miles_cnt_d > 4.5                                       => final_score_206_c1272,
    f_rel_under500miles_cnt_d = NULL                                      => -0.0361939130,
                                                                             0.0274403199));

final_score_206 := __common__( map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 95 => final_score_206_c1269,
    r_f00_ssn_score_d > 95                               => 0.0011077816,
    r_f00_ssn_score_d = NULL                             => -0.0033878142,
                                                            0.0017591506));

final_score_207_c1276 := __common__( map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 1.5 => 0.0005154738,
    r_p88_phn_dst_to_inp_add_i > 1.5                                        => -0.0987220563,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => 0.0030054061,
                                                                               -0.0243123013));

final_score_207_c1277 := __common__( map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 136.5 => 0.0292813961,
    f_prevaddrlenofres_d > 136.5                                  => -0.0676030260,
    f_prevaddrlenofres_d = NULL                                   => 0.0205827948,
                                                                     0.0205827948));

final_score_207_c1275 := __common__( map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 0.5 => final_score_207_c1276,
    f_rel_homeover50_count_d > 0.5                                      => 0.0071442954,
    f_rel_homeover50_count_d = NULL                                     => final_score_207_c1277,
                                                                           0.0070352252));

final_score_207_c1274 := __common__( map(
    NULL < r_l75_add_drop_delivery_i AND r_l75_add_drop_delivery_i <= 0.5 => final_score_207_c1275,
    r_l75_add_drop_delivery_i > 0.5                                       => -0.0222075349,
    r_l75_add_drop_delivery_i = NULL                                      => 0.0057331663,
                                                                             0.0057331663));

final_score_207 := __common__( map(
    NULL < r_i60_inq_auto_recency_d AND r_i60_inq_auto_recency_d <= 549 => -0.0075026614,
    r_i60_inq_auto_recency_d > 549                                      => final_score_207_c1274,
    r_i60_inq_auto_recency_d = NULL                                     => 0.0120489410,
                                                                           0.0000777995));

final_score_208_c1280 := __common__( map(
    NULL < r_a41_prop_owner_d AND r_a41_prop_owner_d <= 0.5 => 0.0093929156,
    r_a41_prop_owner_d > 0.5                                => 0.1875916506,
    r_a41_prop_owner_d = NULL                               => 0.0992166682,
                                                               0.0992166682));

final_score_208_c1282 := __common__( map(
    NULL < f_hh_members_ct_d AND f_hh_members_ct_d <= 1.5 => 0.1085808953,
    f_hh_members_ct_d > 1.5                               => 0.0042807294,
    f_hh_members_ct_d = NULL                              => 0.0302602579,
                                                             0.0302602579));

final_score_208_c1281 := __common__( map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i <= 0.5 => -0.0505494704,
    f_crim_rel_under25miles_cnt_i > 0.5                                           => final_score_208_c1282,
    f_crim_rel_under25miles_cnt_i = NULL                                          => 0.0076591202,
                                                                                     0.0076591202));

final_score_208_c1279 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.22708910505 => final_score_208_c1280,
    f_add_curr_mobility_index_i > 0.22708910505                                         => final_score_208_c1281,
    f_add_curr_mobility_index_i = NULL                                                  => 0.0298713064,
                                                                                           0.0298713064));

final_score_208 := __common__( map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 2.5 => -0.0002715216,
    f_srchunvrfdphonecount_i > 2.5                                      => final_score_208_c1279,
    f_srchunvrfdphonecount_i = NULL                                     => 0.0229590766,
                                                                           0.0003945459));

final_score_209_c1286 := __common__( map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 28.5 => 0.0969935094,
    f_curraddrmurderindex_i > 28.5                                     => 0.0209254771,
    f_curraddrmurderindex_i = NULL                                     => 0.0256970453,
                                                                          0.0256970453));

final_score_209_c1287 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 27.5 => 0.0519667732,
    k_comb_age_d > 27.5                          => -0.0496763186,
    k_comb_age_d = NULL                          => 0.0011452273,
                                                    0.0011452273));

final_score_209_c1285 := __common__( map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 0.5 => -0.0492860228,
    f_rel_homeover50_count_d > 0.5                                      => final_score_209_c1286,
    f_rel_homeover50_count_d = NULL                                     => final_score_209_c1287,
                                                                           0.0212270626));

final_score_209_c1284 := __common__( map(
    NULL < f_rel_bankrupt_count_i AND f_rel_bankrupt_count_i <= 1.5 => final_score_209_c1285,
    f_rel_bankrupt_count_i > 1.5                                    => -0.0042621634,
    f_rel_bankrupt_count_i = NULL                                   => 0.0113269803,
                                                                       0.0113269803));

final_score_209 := __common__( map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i <= 0.5 => -0.0032758809,
    r_l70_add_standardized_i > 0.5                                      => final_score_209_c1284,
    r_l70_add_standardized_i = NULL                                     => -0.0005857261,
                                                                           -0.0005857261));

final_score_210_c1292 := __common__( map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 1.5 => 0.1368591873,
    f_srchvelocityrisktype_i > 1.5                                      => 0.0221649594,
    f_srchvelocityrisktype_i = NULL                                     => 0.0374379424,
                                                                           0.0374379424));

final_score_210_c1291 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.01687291225 => final_score_210_c1292,
    f_add_input_nhood_mfd_pct_i > 0.01687291225                                         => -0.0048108692,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => 0.0023648105,
                                                                                           -0.0003877171));

final_score_210_c1290 := __common__( map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 373.5 => final_score_210_c1291,
    f_prevaddrageoldest_d > 373.5                                   => 0.0905183935,
    f_prevaddrageoldest_d = NULL                                    => 0.0012626046,
                                                                       0.0012626046));

final_score_210_c1289 := __common__( map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_210_c1290,
    f_phone_ver_insurance_d > 3.5                                     => -0.0138767461,
    f_phone_ver_insurance_d = NULL                                    => -0.0056125829,
                                                                         -0.0056125829));

final_score_210 := __common__( map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 4.5 => final_score_210_c1289,
    f_util_adl_count_n > 4.5                                => 0.0082662167,
    f_util_adl_count_n = NULL                               => -0.0098904622,
                                                               -0.0004851839));

final_score_211_c1295 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.29760432085 => -0.0057708410,
    f_add_input_mobility_index_i > 0.29760432085                                          => 0.0662827722,
    f_add_input_mobility_index_i = NULL                                                   => 0.0115753992,
                                                                                             0.0115753992));

final_score_211_c1294 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.0183370818 => 0.0653867483,
    f_add_input_nhood_bus_pct_i > 0.0183370818                                         => final_score_211_c1295,
    f_add_input_nhood_bus_pct_i = NULL                                                 => 0.0312348148,
                                                                                          0.0312348148));

final_score_211_c1297 := __common__( map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => 0.0214123918,
    r_c23_inp_addr_occ_index_d > 2                                        => -0.0132819799,
    r_c23_inp_addr_occ_index_d = NULL                                     => 0.0063598073,
                                                                             0.0063598073));

final_score_211_c1296 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 36020.5 => final_score_211_c1297,
    f_prevaddrmedianincome_d > 36020.5                                      => -0.0546007719,
    f_prevaddrmedianincome_d = NULL                                         => 0.0153468500,
                                                                               -0.0197448771));

final_score_211 := __common__( map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d <= 0.5 => final_score_211_c1294,
    f_rel_incomeover25_count_d > 0.5                                        => -0.0028532090,
    f_rel_incomeover25_count_d = NULL                                       => final_score_211_c1296,
                                                                               -0.0027534732));

final_score_212_c1300 := __common__( map(
    NULL < f_mos_liens_unrel_o_fseen_d AND f_mos_liens_unrel_o_fseen_d <= 181.5 => -0.0232857931,
    f_mos_liens_unrel_o_fseen_d > 181.5                                         => 0.0020054891,
    f_mos_liens_unrel_o_fseen_d = NULL                                          => 0.0002430195,
                                                                                   0.0002430195));

final_score_212_c1299 := __common__( map(
    NULL < r_a50_pb_total_dollars_d AND r_a50_pb_total_dollars_d <= 1.5 => -0.0987095874,
    r_a50_pb_total_dollars_d > 1.5                                      => final_score_212_c1300,
    r_a50_pb_total_dollars_d = NULL                                     => -0.0164497262,
                                                                           -0.0001807665));

final_score_212_c1302 := __common__( map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 81.5 => 0.0228781952,
    f_prevaddrageoldest_d > 81.5                                   => 0.1944853624,
    f_prevaddrageoldest_d = NULL                                   => 0.1016486982,
                                                                      0.1016486982));

final_score_212_c1301 := __common__( map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.4237335385 => final_score_212_c1302,
    f_add_curr_nhood_sfd_pct_d > 0.4237335385                                        => 0.0228353495,
    f_add_curr_nhood_sfd_pct_d = NULL                                                => 0.0400361161,
                                                                                        0.0400361161));

final_score_212 := __common__( map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 4.5 => final_score_212_c1299,
    r_s66_adlperssn_count_i > 4.5                                     => final_score_212_c1301,
    r_s66_adlperssn_count_i = NULL                                    => 0.0007298470,
                                                                         0.0007298470));

final_score_213_c1305 := __common__( map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 16.5 => 0.1705249172,
    r_c13_curr_addr_lres_d > 16.5                                    => 0.0121439165,
    r_c13_curr_addr_lres_d = NULL                                    => 0.0622531597,
                                                                        0.0622531597));

final_score_213_c1307 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 431176.5 => -0.0088788536,
    f_prevaddrmedianvalue_d > 431176.5                                     => -0.1163489051,
    f_prevaddrmedianvalue_d = NULL                                         => -0.0202606106,
                                                                              -0.0202606106));

final_score_213_c1306 := __common__( map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i <= 3.5 => final_score_213_c1307,
    f_crim_rel_under25miles_cnt_i > 3.5                                           => 0.0595188373,
    f_crim_rel_under25miles_cnt_i = NULL                                          => -0.0065380074,
                                                                                     -0.0065380074));

final_score_213_c1304 := __common__( map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.3565310748 => -0.0010815706,
    f_add_curr_nhood_bus_pct_i > 0.3565310748                                        => final_score_213_c1305,
    f_add_curr_nhood_bus_pct_i = NULL                                                => final_score_213_c1306,
                                                                                        -0.0007680569));

final_score_213 := __common__( map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 0 => 0.0715286359,
    f_varrisktype_i > 0                             => final_score_213_c1304,
    f_varrisktype_i = NULL                          => -0.0026713994,
                                                       -0.0005903315));

final_score_214_c1310 := __common__( map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 1.5 => 0.0269200006,
    f_rel_homeover500_count_d > 1.5                                       => -0.0475169520,
    f_rel_homeover500_count_d = NULL                                      => 0.0180492757,
                                                                             0.0180492757));

final_score_214_c1309 := __common__( map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 38.5 => -0.0051232220,
    f_addrchangecrimediff_i > 38.5                                     => final_score_214_c1310,
    f_addrchangecrimediff_i = NULL                                     => 0.0045475715,
                                                                          -0.0025133029));

final_score_214_c1312 := __common__( map(
    NULL < f_curraddrcrimeindex_i AND f_curraddrcrimeindex_i <= 155.5 => -0.0216987459,
    f_curraddrcrimeindex_i > 155.5                                    => 0.0918079124,
    f_curraddrcrimeindex_i = NULL                                     => 0.0206544848,
                                                                         0.0206544848));

final_score_214_c1311 := __common__( map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => final_score_214_c1312,
    f_srchunvrfdaddrcount_i > 0.5                                     => 0.1113208623,
    f_srchunvrfdaddrcount_i = NULL                                    => 0.0460020742,
                                                                         0.0460020742));

final_score_214 := __common__( map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 7.5 => final_score_214_c1309,
    f_inq_communications_count24_i > 7.5                                            => final_score_214_c1311,
    f_inq_communications_count24_i = NULL                                           => -0.0035864290,
                                                                                       -0.0021542919));

final_score_215_c1315 := __common__( map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 244.5 => -0.0020792940,
    r_p88_phn_dst_to_inp_add_i > 244.5                                        => -0.0426030791,
    r_p88_phn_dst_to_inp_add_i = NULL                                         => 0.0043386583,
                                                                                 -0.0006828891));

final_score_215_c1316 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.21432705345 => 0.1885657171,
    f_add_input_mobility_index_i > 0.21432705345                                          => 0.0246216124,
    f_add_input_mobility_index_i = NULL                                                   => 0.0596524040,
                                                                                             0.0596524040));

final_score_215_c1314 := __common__( map(
    NULL < f_inq_collection_count24_i AND f_inq_collection_count24_i <= 6.5 => final_score_215_c1315,
    f_inq_collection_count24_i > 6.5                                        => final_score_215_c1316,
    f_inq_collection_count24_i = NULL                                       => 0.0000061523,
                                                                               0.0000061523));

final_score_215_c1317 := __common__( map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 6.5 => 0.0070864319,
    f_hh_members_w_derog_i > 6.5                                    => -0.0970434151,
    f_hh_members_w_derog_i = NULL                                   => -0.0005943799,
                                                                       0.0052853808));

final_score_215 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 497107.5 => final_score_215_c1314,
    f_addrchangevaluediff_d > 497107.5                                     => -0.0842060738,
    f_addrchangevaluediff_d = NULL                                         => final_score_215_c1317,
                                                                              0.0007674689));

final_score_216_c1320 := __common__( map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 1.5 => -0.0153591239,
    f_srchunvrfdphonecount_i > 1.5                                      => 0.0674497604,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0105724832,
                                                                           -0.0105724832));

final_score_216_c1319 := __common__( map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 194.5 => final_score_216_c1320,
    f_prevaddrcartheftindex_i > 194.5                                       => -0.0534933260,
    f_prevaddrcartheftindex_i = NULL                                        => -0.0180140491,
                                                                               -0.0180140491));

final_score_216_c1322 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 311546.5 => 0.0079213582,
    f_addrchangevaluediff_d > 311546.5                                     => -0.0747971308,
    f_addrchangevaluediff_d = NULL                                         => 0.0007582200,
                                                                              0.0062864473));

final_score_216_c1321 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.2530944202 => -0.0073787380,
    f_add_curr_mobility_index_i > 0.2530944202                                         => final_score_216_c1322,
    f_add_curr_mobility_index_i = NULL                                                 => 0.0003207720,
                                                                                          0.0003207720));

final_score_216 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 24909.5 => final_score_216_c1319,
    f_prevaddrmedianvalue_d > 24909.5                                     => final_score_216_c1321,
    f_prevaddrmedianvalue_d = NULL                                        => -0.0007577036,
                                                                             -0.0007577036));

final_score_217_c1327 := __common__( map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 32.5 => 0.0737463666,
    f_prevaddrlenofres_d > 32.5                                  => -0.0356022570,
    f_prevaddrlenofres_d = NULL                                  => 0.0122942475,
                                                                    0.0122942475));

final_score_217_c1326 := __common__( map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 9.5 => 0.0272849884,
    r_p88_phn_dst_to_inp_add_i > 9.5                                        => 0.1197694830,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => final_score_217_c1327,
                                                                               0.0360876848));

final_score_217_c1325 := __common__( map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 16106.5 => final_score_217_c1326,
    f_addrchangeincomediff_d > 16106.5                                      => -0.0232822929,
    f_addrchangeincomediff_d = NULL                                         => 0.0038411364,
                                                                               0.0071756630));

final_score_217_c1324 := __common__( map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => -0.0034525959,
    r_f03_input_add_not_most_rec_i > 0.5                                            => final_score_217_c1325,
    r_f03_input_add_not_most_rec_i = NULL                                           => -0.0015096715,
                                                                                       -0.0015096715));

final_score_217 := __common__( map(
    NULL < f_inq_communications_cnt_week_i AND f_inq_communications_cnt_week_i <= 1.5 => final_score_217_c1324,
    f_inq_communications_cnt_week_i > 1.5                                             => 0.0844109202,
    f_inq_communications_cnt_week_i = NULL                                            => 0.0298452424,
                                                                                         -0.0012483400));

final_score_218_c1332 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.3258929732 => -0.0348704613,
    f_add_curr_mobility_index_i > 0.3258929732                                         => 0.1066766058,
    f_add_curr_mobility_index_i = NULL                                                 => -0.0022559297,
                                                                                          -0.0022559297));

final_score_218_c1331 := __common__( map(
    NULL < f_hh_members_ct_d AND f_hh_members_ct_d <= 3.5 => final_score_218_c1332,
    f_hh_members_ct_d > 3.5                               => 0.0959803905,
    f_hh_members_ct_d = NULL                              => 0.0280909590,
                                                             0.0280909590));

final_score_218_c1330 := __common__( map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 349.5 => -0.0218947658,
    f_m_bureau_adl_fs_notu_d > 349.5                                      => final_score_218_c1331,
    f_m_bureau_adl_fs_notu_d = NULL                                       => -0.0152916873,
                                                                             -0.0152916873));

final_score_218_c1329 := __common__( map(
    NULL < r_f01_inp_addr_not_verified_i AND r_f01_inp_addr_not_verified_i <= 0.5 => 0.0009056817,
    r_f01_inp_addr_not_verified_i > 0.5                                           => final_score_218_c1330,
    r_f01_inp_addr_not_verified_i = NULL                                          => -0.0006883706,
                                                                                     -0.0006883706));

final_score_218 := __common__( map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 2 => 0.0338651625,
    r_i61_inq_collection_recency_d > 2                                            => final_score_218_c1329,
    r_i61_inq_collection_recency_d = NULL                                         => -0.0089581140,
                                                                                     0.0002749724));

final_score_219_c1336 := __common__( map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 17.5 => 0.0294646854,
    r_p88_phn_dst_to_inp_add_i > 17.5                                        => -0.0429597135,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => 0.0722326770,
                                                                                0.0371248932));

final_score_219_c1335 := __common__( map(
    NULL < r_a50_pb_total_dollars_d AND r_a50_pb_total_dollars_d <= 17.5 => final_score_219_c1336,
    r_a50_pb_total_dollars_d > 17.5                                      => 0.0016498420,
    r_a50_pb_total_dollars_d = NULL                                      => 0.0037160350,
                                                                            0.0037160350));

final_score_219_c1334 := __common__( map(
    NULL < f_current_count_d AND f_current_count_d <= 1.5 => final_score_219_c1335,
    f_current_count_d > 1.5                               => -0.0093840640,
    f_current_count_d = NULL                              => -0.0276142273,
                                                             -0.0013155805));

final_score_219_c1337 := __common__( map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 1.5 => -0.0943409086,
    f_rel_homeover200_count_d > 1.5                                       => -0.0127336994,
    f_rel_homeover200_count_d = NULL                                      => -0.0360500449,
                                                                             -0.0360500449));

final_score_219 := __common__( map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 81.5 => final_score_219_c1334,
    f_bus_addr_match_count_d > 81.5                                      => final_score_219_c1337,
    f_bus_addr_match_count_d = NULL                                      => -0.0016124086,
                                                                            -0.0016124086));

final_score_220_c1339 := __common__( map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 14.5 => -0.0023646450,
    k_inq_per_ssn_i > 14.5                             => 0.0640362389,
    k_inq_per_ssn_i = NULL                             => -0.0019436014,
                                                          -0.0019436014));

final_score_220_c1341 := __common__( map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 157.5 => -0.0465732536,
    f_m_bureau_adl_fs_notu_d > 157.5                                      => 0.0317789993,
    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0173791258,
                                                                             0.0173791258));

final_score_220_c1342 := __common__( map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 0.5 => 0.1376005396,
    r_c18_invalid_addrs_per_adl_i > 0.5                                           => 0.0374642674,
    r_c18_invalid_addrs_per_adl_i = NULL                                          => 0.0667817311,
                                                                                     0.0667817311));

final_score_220_c1340 := __common__( map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 7.5 => final_score_220_c1341,
    f_corrrisktype_i > 7.5                              => final_score_220_c1342,
    f_corrrisktype_i = NULL                             => 0.0241181741,
                                                           0.0241181741));

final_score_220 := __common__( map(
    NULL < f_util_add_curr_inf_n AND f_util_add_curr_inf_n <= 0.5 => final_score_220_c1339,
    f_util_add_curr_inf_n > 0.5                                   => final_score_220_c1340,
    f_util_add_curr_inf_n = NULL                                  => 0.0000700684,
                                                                     0.0000700684));

final_score_221_c1346 := __common__( map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 0.5 => 0.0279943594,
    k_inq_per_phone_i > 0.5                               => 0.2053864347,
    k_inq_per_phone_i = NULL                              => 0.0972501696,
                                                             0.0972501696));

final_score_221_c1345 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 31.5 => final_score_221_c1346,
    k_comb_age_d > 31.5                          => 0.0040778303,
    k_comb_age_d = NULL                          => 0.0337143478,
                                                    0.0337143478));

final_score_221_c1347 := __common__( map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 7.5 => 0.0781869527,
    f_corrrisktype_i > 7.5                              => -0.0534722390,
    f_corrrisktype_i = NULL                             => 0.0461223525,
                                                           0.0461223525));

final_score_221_c1344 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.002728518 => final_score_221_c1345,
    f_add_input_nhood_bus_pct_i > 0.002728518                                         => -0.0012538445,
    f_add_input_nhood_bus_pct_i = NULL                                                => final_score_221_c1347,
                                                                                         0.0000202568));

final_score_221 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.9988104533 => final_score_221_c1344,
    f_add_input_nhood_mfd_pct_i > 0.9988104533                                         => -0.0542465752,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0102076925,
                                                                                          -0.0010507223));

final_score_222_c1352 := __common__( map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 91 => 0.1678236464,
    f_prevaddrlenofres_d > 91                                  => 0.0406906371,
    f_prevaddrlenofres_d = NULL                                => 0.1127843558,
                                                                  0.1127843558));

final_score_222_c1351 := __common__( map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 258.5 => final_score_222_c1352,
    r_c10_m_hdr_fs_d > 258.5                              => 0.0483353870,
    r_c10_m_hdr_fs_d = NULL                               => 0.0798865239,
                                                             0.0798865239));

final_score_222_c1350 := __common__( map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.0432214972 => final_score_222_c1351,
    f_add_input_nhood_vac_pct_i > 0.0432214972                                         => -0.0312883339,
    f_add_input_nhood_vac_pct_i = NULL                                                 => 0.0493254699,
                                                                                          0.0493254699));

final_score_222_c1349 := __common__( map(
    NULL < f_mos_liens_rel_cj_lseen_d AND f_mos_liens_rel_cj_lseen_d <= 104.5 => final_score_222_c1350,
    f_mos_liens_rel_cj_lseen_d > 104.5                                        => 0.0010009574,
    f_mos_liens_rel_cj_lseen_d = NULL                                         => 0.0019285375,
                                                                                 0.0019285375));

final_score_222 := __common__( map(
    NULL < f_mos_liens_rel_cj_lseen_d AND f_mos_liens_rel_cj_lseen_d <= 86.5 => -0.0425761583,
    f_mos_liens_rel_cj_lseen_d > 86.5                                        => final_score_222_c1349,
    f_mos_liens_rel_cj_lseen_d = NULL                                        => -0.0147562063,
                                                                                0.0004165512));

final_score_223_c1356 := __common__( map(
    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 5.5 => 0.0225696708,
    f_inq_highriskcredit_count24_i > 5.5                                            => 0.1347903018,
    f_inq_highriskcredit_count24_i = NULL                                           => 0.0265055527,
                                                                                       0.0265055527));

final_score_223_c1357 := __common__( map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => -0.0857869407,
    r_phn_cell_n > 0.5                          => 0.0070396436,
    r_phn_cell_n = NULL                         => -0.0192098960,
                                                   -0.0192098960));

final_score_223_c1355 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.098858422 => final_score_223_c1356,
    f_add_input_nhood_bus_pct_i > 0.098858422                                         => final_score_223_c1357,
    f_add_input_nhood_bus_pct_i = NULL                                                => -0.0304543433,
                                                                                         0.0158459775));

final_score_223_c1354 := __common__( map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 3.5 => -0.0005545524,
    r_c14_addrs_5yr_i > 3.5                               => final_score_223_c1355,
    r_c14_addrs_5yr_i = NULL                              => 0.0014484143,
                                                             0.0014484143));

final_score_223 := __common__( map(
    NULL < f_curraddrcrimeindex_i AND f_curraddrcrimeindex_i <= 199.5 => final_score_223_c1354,
    f_curraddrcrimeindex_i > 199.5                                    => 0.0965692238,
    f_curraddrcrimeindex_i = NULL                                     => 0.0030730113,
                                                                         0.0017462353));

final_score_224_c1360 := __common__( map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i <= 5.5 => 0.0162494273,
    k_inq_per_addr_i > 5.5                              => -0.0500821240,
    k_inq_per_addr_i = NULL                             => 0.0064852938,
                                                           0.0064852938));

final_score_224_c1362 := __common__( map(
    NULL < f_hh_members_ct_d AND f_hh_members_ct_d <= 2.5 => 0.0001325328,
    f_hh_members_ct_d > 2.5                               => 0.0913068539,
    f_hh_members_ct_d = NULL                              => 0.0452975900,
                                                             0.0452975900));

final_score_224_c1361 := __common__( map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 95 => 0.1375224487,
    f_curraddrmurderindex_i > 95                                     => final_score_224_c1362,
    f_curraddrmurderindex_i = NULL                                   => 0.0648196404,
                                                                        0.0648196404));

final_score_224_c1359 := __common__( map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 9.5 => final_score_224_c1360,
    r_l79_adls_per_addr_curr_i > 9.5                                        => final_score_224_c1361,
    r_l79_adls_per_addr_curr_i = NULL                                       => 0.0210555864,
                                                                               0.0210555864));

final_score_224 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 16768 => final_score_224_c1359,
    f_prevaddrmedianincome_d > 16768                                      => 0.0004361628,
    f_prevaddrmedianincome_d = NULL                                       => -0.0168693324,
                                                                             0.0013038100));

final_score_225_c1367 := __common__( map(
    NULL < f_hh_payday_loan_users_i AND f_hh_payday_loan_users_i <= 0.5 => 0.0166265147,
    f_hh_payday_loan_users_i > 0.5                                      => 0.1028220372,
    f_hh_payday_loan_users_i = NULL                                     => 0.0246528184,
                                                                           0.0246528184));

final_score_225_c1366 := __common__( map(
    NULL < f_srchaddrsrchcountmo_i AND f_srchaddrsrchcountmo_i <= 0.5 => final_score_225_c1367,
    f_srchaddrsrchcountmo_i > 0.5                                     => 0.0871276155,
    f_srchaddrsrchcountmo_i = NULL                                    => 0.0351704610,
                                                                         0.0351704610));

final_score_225_c1365 := __common__( map(
    NULL < f_rel_educationover8_count_d AND f_rel_educationover8_count_d <= 7.5 => final_score_225_c1366,
    f_rel_educationover8_count_d > 7.5                                          => 0.0075802050,
    f_rel_educationover8_count_d = NULL                                         => -0.0046027224,
                                                                                   0.0188448696));

final_score_225_c1364 := __common__( map(
    (nf_seg_fraudpoint_3_0 in ['3: Derog', '5: Vuln Vic/Friendly', '6: Other'])            => 0.0016875351,
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '4: Recent Activity']) => final_score_225_c1365,
    nf_seg_fraudpoint_3_0 = ''                                                           => 0.0077263821,
                                                                                              0.0077263821));

final_score_225 := __common__( map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 75 => final_score_225_c1364,
    f_curraddrburglaryindex_i > 75                                       => -0.0032169475,
    f_curraddrburglaryindex_i = NULL                                     => 0.0053406957,
                                                                            0.0009656208));

final_score_226_c1371 := __common__( map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 0.5 => -0.0406890166,
    r_l79_adls_per_addr_c6_i > 0.5                                      => 0.0201370801,
    r_l79_adls_per_addr_c6_i = NULL                                     => 0.0015513283,
                                                                           0.0015513283));

final_score_226_c1370 := __common__( map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 17.5 => -0.0003158522,
    f_rel_incomeover75_count_d > 17.5                                        => 0.0912673377,
    f_rel_incomeover75_count_d = NULL                                        => final_score_226_c1371,
                                                                                0.0000164740));

final_score_226_c1372 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.3358044164 => 0.1323820727,
    f_add_curr_mobility_index_i > 0.3358044164                                         => -0.0265587296,
    f_add_curr_mobility_index_i = NULL                                                 => 0.0529116715,
                                                                                          0.0529116715));

final_score_226_c1369 := __common__( map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 1.8099469835 => final_score_226_c1370,
    f_add_input_nhood_vac_pct_i > 1.8099469835                                         => final_score_226_c1372,
    f_add_input_nhood_vac_pct_i = NULL                                                 => 0.0002360092,
                                                                                          0.0002360092));

final_score_226 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 839850.5 => final_score_226_c1369,
    f_curraddrmedianvalue_d > 839850.5                                     => 0.0791065018,
    f_curraddrmedianvalue_d = NULL                                         => 0.0037173988,
                                                                              0.0004363496));

final_score_227_c1374 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.43880278285 => 0.0112729099,
    f_add_input_nhood_mfd_pct_i > 0.43880278285                                         => -0.0729217254,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => -0.0459438669,
                                                                                           -0.0459438669));

final_score_227_c1377 := __common__( map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 2.5 => -0.0115169606,
    f_rel_incomeover100_count_d > 2.5                                         => 0.0403321908,
    f_rel_incomeover100_count_d = NULL                                        => 0.0175589887,
                                                                                 -0.0072926238));

final_score_227_c1376 := __common__( map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -110.5 => -0.0349408658,
    f_addrchangecrimediff_i > -110.5                                     => 0.0017560670,
    f_addrchangecrimediff_i = NULL                                       => final_score_227_c1377,
                                                                            -0.0000703919));

final_score_227_c1375 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 814640 => final_score_227_c1376,
    f_prevaddrmedianvalue_d > 814640                                     => -0.0754352166,
    f_prevaddrmedianvalue_d = NULL                                       => -0.0003309259,
                                                                            -0.0003309259));

final_score_227 := __common__( map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 11.5 => final_score_227_c1374,
    f_m_bureau_adl_fs_notu_d > 11.5                                      => final_score_227_c1375,
    f_m_bureau_adl_fs_notu_d = NULL                                      => 0.0134537124,
                                                                            -0.0008434046));

final_score_228_c1381 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 28.5 => 0.0332420586,
    k_comb_age_d > 28.5                          => 0.0098775425,
    k_comb_age_d = NULL                          => 0.0114353020,
                                                    0.0114353020));

final_score_228_c1380 := __common__( map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 115.5 => -0.0095017109,
    f_m_bureau_adl_fs_all_d > 115.5                                     => final_score_228_c1381,
    f_m_bureau_adl_fs_all_d = NULL                                      => 0.0068137803,
                                                                           0.0068137803));

final_score_228_c1379 := __common__( map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 2.5 => -0.0208987219,
    f_corrrisktype_i > 2.5                              => final_score_228_c1380,
    f_corrrisktype_i = NULL                             => 0.0103407700,
                                                           0.0013614581));

final_score_228_c1382 := __common__( map(
    NULL < f_mos_liens_unrel_st_fseen_d AND f_mos_liens_unrel_st_fseen_d <= 137.5 => -0.0509710314,
    f_mos_liens_unrel_st_fseen_d > 137.5                                          => -0.0028253438,
    f_mos_liens_unrel_st_fseen_d = NULL                                           => -0.0082096089,
                                                                                     -0.0082096089));

final_score_228 := __common__( map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => final_score_228_c1379,
    r_phn_pcs_n > 0.5                         => final_score_228_c1382,
    r_phn_pcs_n = NULL                        => -0.0005383922,
                                                 -0.0005383922));

final_score_229_c1387 := __common__( map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.0391207857,
    f_phone_ver_experian_d > 0.5                                    => 0.0067973319,
    f_phone_ver_experian_d = NULL                                   => 0.0288216460,
                                                                       0.0288216460));

final_score_229_c1386 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.0706420721 => 0.0056405975,
    f_add_input_nhood_bus_pct_i > 0.0706420721                                         => final_score_229_c1387,
    f_add_input_nhood_bus_pct_i = NULL                                                 => 0.0141869547,
                                                                                          0.0141869547));

final_score_229_c1385 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 96.5 => -0.0198129492,
    r_c13_max_lres_d > 96.5                              => final_score_229_c1386,
    r_c13_max_lres_d = NULL                              => -0.0015230475,
                                                            -0.0015230475));

final_score_229_c1384 := __common__( map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 2.5 => final_score_229_c1385,
    r_l79_adls_per_addr_curr_i > 2.5                                        => -0.0277703203,
    r_l79_adls_per_addr_curr_i = NULL                                       => -0.0148708794,
                                                                               -0.0148708794));

final_score_229 := __common__( map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 85 => final_score_229_c1384,
    r_f01_inp_addr_address_score_d > 85                                            => 0.0024676919,
    r_f01_inp_addr_address_score_d = NULL                                          => 0.0254525654,
                                                                                      -0.0007964310));

final_score_230_c1392 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 36.5 => 0.1829109846,
    k_comb_age_d > 36.5                          => 0.0188344312,
    k_comb_age_d = NULL                          => 0.1085857083,
                                                    0.1085857083));

final_score_230_c1391 := __common__( map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.9909220939 => 0.0151405706,
    f_add_curr_nhood_sfd_pct_d > 0.9909220939                                        => final_score_230_c1392,
    f_add_curr_nhood_sfd_pct_d = NULL                                                => 0.0174369540,
                                                                                        0.0174369540));

final_score_230_c1390 := __common__( map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 33500 => final_score_230_c1391,
    k_estimated_income_d > 33500                                  => 0.0010360577,
    k_estimated_income_d = NULL                                   => 0.0062542258,
                                                                     0.0062542258));

final_score_230_c1389 := __common__( map(
    NULL < f_add_curr_has_vac_ct_i AND f_add_curr_has_vac_ct_i <= 0.5 => -0.0956231782,
    f_add_curr_has_vac_ct_i > 0.5                                     => final_score_230_c1390,
    f_add_curr_has_vac_ct_i = NULL                                    => 0.0059014271,
                                                                         0.0059014271));

final_score_230 := __common__( map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 2.5 => -0.0058789402,
    f_srchvelocityrisktype_i > 2.5                                      => final_score_230_c1389,
    f_srchvelocityrisktype_i = NULL                                     => -0.0159180157,
                                                                           0.0011876172));

final_score_231_c1395 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.17556414615 => 0.0842093955,
    f_add_input_mobility_index_i > 0.17556414615                                          => 0.0070347843,
    f_add_input_mobility_index_i = NULL                                                   => 0.0129993118,
                                                                                             0.0129993118));

final_score_231_c1394 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 22.5 => final_score_231_c1395,
    k_comb_age_d > 22.5                          => 0.0012630870,
    k_comb_age_d = NULL                          => 0.0020726129,
                                                    0.0020726129));

final_score_231_c1397 := __common__( map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 36500 => 0.0890603489,
    k_estimated_income_d > 36500                                  => -0.0445872010,
    k_estimated_income_d = NULL                                   => 0.0265280090,
                                                                     0.0265280090));

final_score_231_c1396 := __common__( map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 1.5 => final_score_231_c1397,
    f_rel_incomeover75_count_d > 1.5                                        => 0.1438068373,
    f_rel_incomeover75_count_d = NULL                                       => 0.0663317325,
                                                                               0.0663317325));

final_score_231 := __common__( map(
    NULL < f_srchunvrfddobcount_i AND f_srchunvrfddobcount_i <= 1.5 => final_score_231_c1394,
    f_srchunvrfddobcount_i > 1.5                                    => final_score_231_c1396,
    f_srchunvrfddobcount_i = NULL                                   => 0.0058539745,
                                                                       0.0025196418));

final_score_232_c1401 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.5259677106 => -0.0460831319,
    f_add_input_nhood_mfd_pct_i > 0.5259677106                                         => 0.0073536427,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0179841592,
                                                                                          -0.0179841592));

final_score_232_c1400 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 418649 => final_score_232_c1401,
    f_prevaddrmedianvalue_d > 418649                                     => 0.0871224587,
    f_prevaddrmedianvalue_d = NULL                                       => 0.0035204132,
                                                                            0.0035204132));

final_score_232_c1399 := __common__( map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 11.5 => final_score_232_c1400,
    f_rel_under25miles_cnt_d > 11.5                                      => 0.1294253903,
    f_rel_under25miles_cnt_d = NULL                                      => -0.0188586025,
                                                                            0.0212455240));

final_score_232_c1402 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.99546793355 => -0.0008823015,
    f_add_curr_nhood_mfd_pct_i > 0.99546793355                                        => -0.0332837495,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => -0.0044156861,
                                                                                         -0.0016841449));

final_score_232 := __common__( map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 95 => final_score_232_c1399,
    r_f00_ssn_score_d > 95                               => final_score_232_c1402,
    r_f00_ssn_score_d = NULL                             => 0.0312740386,
                                                            -0.0010564196));

final_score_233_c1407 := __common__( map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.0612503421 => 0.1584920305,
    f_add_curr_nhood_vac_pct_i > 0.0612503421                                        => 0.0158790795,
    f_add_curr_nhood_vac_pct_i = NULL                                                => 0.1145518239,
                                                                                        0.1145518239));

final_score_233_c1406 := __common__( map(
    NULL < r_d34_unrel_lien60_count_i AND r_d34_unrel_lien60_count_i <= 0.5 => final_score_233_c1407,
    r_d34_unrel_lien60_count_i > 0.5                                        => -0.0266272019,
    r_d34_unrel_lien60_count_i = NULL                                       => 0.0826536340,
                                                                               0.0826536340));

final_score_233_c1405 := __common__( map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 1.5 => 0.0213227651,
    f_idverrisktype_i > 1.5                               => final_score_233_c1406,
    f_idverrisktype_i = NULL                              => 0.0489274311,
                                                             0.0489274311));

final_score_233_c1404 := __common__( map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 16.5 => final_score_233_c1405,
    f_rel_homeover100_count_d > 16.5                                       => -0.0614372115,
    f_rel_homeover100_count_d = NULL                                       => 0.0314369965,
                                                                              0.0314369965));

final_score_233 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 377.5 => -0.0020077685,
    r_c13_max_lres_d > 377.5                              => final_score_233_c1404,
    r_c13_max_lres_d = NULL                               => -0.0319560504,
                                                             -0.0012289629));

final_score_234_c1411 := __common__( map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -2.5 => 0.0663366973,
    f_addrchangecrimediff_i > -2.5                                     => 0.0084755450,
    f_addrchangecrimediff_i = NULL                                     => 0.0520802374,
                                                                          0.0207011460));

final_score_234_c1410 := __common__( map(
    NULL < f_phones_per_addr_c6_i AND f_phones_per_addr_c6_i <= 3.5 => 0.0002958517,
    f_phones_per_addr_c6_i > 3.5                                    => final_score_234_c1411,
    f_phones_per_addr_c6_i = NULL                                   => 0.0017258121,
                                                                       0.0017258121));

final_score_234_c1412 := __common__( map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 14.05 => -0.1178361766,
    r_c12_source_profile_d > 14.05                                    => -0.0099709896,
    r_c12_source_profile_d = NULL                                     => -0.0180531073,
                                                                         -0.0180531073));

final_score_234_c1409 := __common__( map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 9.5 => final_score_234_c1410,
    r_l79_adls_per_addr_c6_i > 9.5                                      => final_score_234_c1412,
    r_l79_adls_per_addr_c6_i = NULL                                     => 0.0008951071,
                                                                           0.0008951071));

final_score_234 := __common__( map(
    NULL < r_i60_inq_retail_recency_d AND r_i60_inq_retail_recency_d <= 2 => 0.1122510331,
    r_i60_inq_retail_recency_d > 2                                        => final_score_234_c1409,
    r_i60_inq_retail_recency_d = NULL                                     => -0.0153414504,
                                                                             0.0012507292));

final_score_235_c1414 := __common__( map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 10.5 => -0.0002890944,
    k_inq_lnames_per_addr_i > 10.5                                     => 0.0925389962,
    k_inq_lnames_per_addr_i = NULL                                     => -0.0000710080,
                                                                          -0.0000710080));

final_score_235_c1417 := __common__( map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 9.5 => 0.0694953416,
    f_addrs_per_ssn_i > 9.5                               => -0.0281536092,
    f_addrs_per_ssn_i = NULL                              => -0.0107321487,
                                                             -0.0107321487));

final_score_235_c1416 := __common__( map(
    NULL < r_d33_eviction_recency_d AND r_d33_eviction_recency_d <= 48 => 0.0964080966,
    r_d33_eviction_recency_d > 48                                      => final_score_235_c1417,
    r_d33_eviction_recency_d = NULL                                    => -0.0015996122,
                                                                          -0.0015996122));

final_score_235_c1415 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.28699997 => final_score_235_c1416,
    f_add_curr_mobility_index_i > 0.28699997                                         => -0.0510689668,
    f_add_curr_mobility_index_i = NULL                                               => -0.0256336279,
                                                                                        -0.0256336279));

final_score_235 := __common__( map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i <= 12.5 => final_score_235_c1414,
    f_rel_criminal_count_i > 12.5                                    => final_score_235_c1415,
    f_rel_criminal_count_i = NULL                                    => -0.0037752678,
                                                                        -0.0020135948));

final_score_236_c1422 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -51729 => -0.0940555358,
    f_addrchangevaluediff_d > -51729                                     => 0.0104368804,
    f_addrchangevaluediff_d = NULL                                       => -0.0084667635,
                                                                            0.0029472556));

final_score_236_c1421 := __common__( map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 279.5 => final_score_236_c1422,
    r_c13_curr_addr_lres_d > 279.5                                    => 0.1472637175,
    r_c13_curr_addr_lres_d = NULL                                     => 0.0103951508,
                                                                         0.0103951508));

final_score_236_c1420 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 29.5 => 0.1115575775,
    r_c13_max_lres_d > 29.5                              => final_score_236_c1421,
    r_c13_max_lres_d = NULL                              => 0.0175004394,
                                                            0.0175004394));

final_score_236_c1419 := __common__( map(
    NULL < k_inq_adls_per_addr_i AND k_inq_adls_per_addr_i <= 3.5 => -0.0032272472,
    k_inq_adls_per_addr_i > 3.5                                   => final_score_236_c1420,
    k_inq_adls_per_addr_i = NULL                                  => -0.0020240172,
                                                                     -0.0020240172));

final_score_236 := __common__( map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 48.5 => final_score_236_c1419,
    r_l79_adls_per_addr_curr_i > 48.5                                        => 0.0509531547,
    r_l79_adls_per_addr_curr_i = NULL                                        => -0.0074542380,
                                                                                -0.0018200850));

final_score_237_c1426 := __common__( map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 1.5 => 0.0445501538,
    f_rel_under25miles_cnt_d > 1.5                                      => 0.0128226350,
    f_rel_under25miles_cnt_d = NULL                                     => 0.0027570071,
                                                                           0.0172062988));

final_score_237_c1425 := __common__( map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_237_c1426,
    f_phone_ver_insurance_d > 3.5                                     => -0.0017762049,
    f_phone_ver_insurance_d = NULL                                    => 0.0082037421,
                                                                         0.0082037421));

final_score_237_c1424 := __common__( map(
    (nf_seg_fraudpoint_3_0 in ['2: Synth ID', '3: Derog', '5: Vuln Vic/Friendly', '6: Other']) => -0.0020521127,
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '4: Recent Activity'])                    => final_score_237_c1425,
    nf_seg_fraudpoint_3_0 = ''                                                               => 0.0010132275,
                                                                                                  0.0010132275));

final_score_237_c1427 := __common__( map(
    NULL < f_corrssnaddrcount_d AND f_corrssnaddrcount_d <= 0.5 => -0.0975396940,
    f_corrssnaddrcount_d > 0.5                                  => -0.0131639163,
    f_corrssnaddrcount_d = NULL                                 => -0.0194103017,
                                                                   -0.0194103017));

final_score_237 := __common__( map(
    NULL < r_l75_add_drop_delivery_i AND r_l75_add_drop_delivery_i <= 0.5 => final_score_237_c1424,
    r_l75_add_drop_delivery_i > 0.5                                       => final_score_237_c1427,
    r_l75_add_drop_delivery_i = NULL                                      => 0.0003120186,
                                                                             0.0003120186));

final_score_238_c1432 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.24762406725 => 0.0116060480,
    f_add_input_mobility_index_i > 0.24762406725                                          => 0.1492314054,
    f_add_input_mobility_index_i = NULL                                                   => 0.1114518956,
                                                                                             0.1114518956));

final_score_238_c1431 := __common__( map(
    NULL < f_hh_college_attendees_d AND f_hh_college_attendees_d <= 0.5 => 0.0179937944,
    f_hh_college_attendees_d > 0.5                                      => final_score_238_c1432,
    f_hh_college_attendees_d = NULL                                     => 0.0344207303,
                                                                           0.0344207303));

final_score_238_c1430 := __common__( map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 6.5 => -0.0080592173,
    f_phones_per_addr_curr_i > 6.5                                      => final_score_238_c1431,
    f_phones_per_addr_curr_i = NULL                                     => 0.0115494863,
                                                                           0.0115494863));

final_score_238_c1429 := __common__( map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 27.5 => final_score_238_c1430,
    f_rel_homeover100_count_d > 27.5                                       => 0.1623681875,
    f_rel_homeover100_count_d = NULL                                       => 0.0145763379,
                                                                              0.0145763379));

final_score_238 := __common__( map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 26.5 => final_score_238_c1429,
    r_d32_mos_since_crim_ls_d > 26.5                                       => -0.0030378838,
    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0133526850,
                                                                              -0.0011537997));

final_score_239_c1436 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 484595 => 0.0139943823,
    f_curraddrmedianvalue_d > 484595                                     => -0.0440225069,
    f_curraddrmedianvalue_d = NULL                                       => 0.0106161836,
                                                                            0.0106161836));

final_score_239_c1435 := __common__( map(
    NULL < (Integer)k_nap_fname_verd_d AND (Real)k_nap_fname_verd_d <= 0.5 => final_score_239_c1436,
    (Real)k_nap_fname_verd_d > 0.5                                => -0.0015119491,
    (Integer)k_nap_fname_verd_d = NULL                               => 0.0010386493,
                                                               0.0010386493));

final_score_239_c1434 := __common__( map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 433.5 => final_score_239_c1435,
    r_c21_m_bureau_adl_fs_d > 433.5                                     => -0.0397304609,
    r_c21_m_bureau_adl_fs_d = NULL                                      => 0.0005699060,
                                                                           0.0005699060));

final_score_239_c1437 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.241223269 => -0.0733179575,
    f_add_input_mobility_index_i > 0.241223269                                          => 0.0592968636,
    f_add_input_mobility_index_i = NULL                                                 => -0.0184115306,
                                                                                           -0.0059978188));

final_score_239 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.97396312455 => final_score_239_c1434,
    f_add_curr_mobility_index_i > 0.97396312455                                         => 0.0988390586,
    f_add_curr_mobility_index_i = NULL                                                  => final_score_239_c1437,
                                                                                           0.0007556611));

final_score_240_c1441 := __common__( map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 1.5 => 0.1250461336,
    f_inq_count24_i > 1.5                             => -0.0313537389,
    f_inq_count24_i = NULL                            => 0.0331699753,
                                                         0.0331699753));

final_score_240_c1440 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.3975163733 => 0.0015994492,
    f_add_input_nhood_bus_pct_i > 0.3975163733                                         => 0.1266942976,
    f_add_input_nhood_bus_pct_i = NULL                                                 => final_score_240_c1441,
                                                                                          0.0033398563));

final_score_240_c1439 := __common__( map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= 99642 => final_score_240_c1440,
    r_a49_curr_avm_chg_1yr_i > 99642                                      => -0.0518137908,
    r_a49_curr_avm_chg_1yr_i = NULL                                       => -0.0018156548,
                                                                             -0.0005379572));

final_score_240_c1442 := __common__( map(
    NULL < f_srchssnsrchcountmo_i AND f_srchssnsrchcountmo_i <= 1.5 => 0.1139809012,
    f_srchssnsrchcountmo_i > 1.5                                    => 0.0025981261,
    f_srchssnsrchcountmo_i = NULL                                   => 0.0453755687,
                                                                       0.0453755687));

final_score_240 := __common__( map(
    NULL < f_srchphonesrchcountwk_i AND f_srchphonesrchcountwk_i <= 1.5 => final_score_240_c1439,
    f_srchphonesrchcountwk_i > 1.5                                      => final_score_240_c1442,
    f_srchphonesrchcountwk_i = NULL                                     => -0.0286949299,
                                                                           -0.0003483560));

final_score_241_c1446 := __common__( map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i <= 4.5 => -0.0186298325,
    r_i60_inq_comm_count12_i > 4.5                                      => -0.0790193689,
    r_i60_inq_comm_count12_i = NULL                                     => -0.0199672499,
                                                                           -0.0199672499));

final_score_241_c1447 := __common__( map(
    NULL < r_c14_addrs_10yr_i AND r_c14_addrs_10yr_i <= 1.5 => -0.0329898881,
    r_c14_addrs_10yr_i > 1.5                                => 0.1125346367,
    r_c14_addrs_10yr_i = NULL                               => 0.0449255091,
                                                               0.0449255091));

final_score_241_c1445 := __common__( map(
    NULL < f_corraddrphonecount_d AND f_corraddrphonecount_d <= 1.5 => final_score_241_c1446,
    f_corraddrphonecount_d > 1.5                                    => final_score_241_c1447,
    f_corraddrphonecount_d = NULL                                   => -0.0130003570,
                                                                       -0.0130003570));

final_score_241_c1444 := __common__( map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 17.5 => final_score_241_c1445,
    r_l79_adls_per_addr_c6_i > 17.5                                      => 0.0552420912,
    r_l79_adls_per_addr_c6_i = NULL                                      => -0.0116574823,
                                                                            -0.0116574823));

final_score_241 := __common__( map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 182 => 0.0010438456,
    f_curraddrcartheftindex_i > 182                                       => final_score_241_c1444,
    f_curraddrcartheftindex_i = NULL                                      => -0.0029557041,
                                                                             -0.0006735283));

final_score_242_c1449 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 566152.5 => 0.0003667282,
    f_prevaddrmedianvalue_d > 566152.5                                     => -0.0549475089,
    f_prevaddrmedianvalue_d = NULL                                         => -0.0001545269,
                                                                              -0.0001545269));

final_score_242_c1451 := __common__( map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 2.5 => 0.1233713201,
    f_phone_ver_insurance_d > 2.5                                     => 0.0370507204,
    f_phone_ver_insurance_d = NULL                                    => 0.0700556556,
                                                                         0.0700556556));

final_score_242_c1452 := __common__( map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 2.5 => 0.0604089888,
    r_p88_phn_dst_to_inp_add_i > 2.5                                        => -0.0005057835,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => -0.0697736247,
                                                                               -0.0017327168));

final_score_242_c1450 := __common__( map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 3.5 => final_score_242_c1451,
    f_rel_ageover30_count_d > 3.5                                     => final_score_242_c1452,
    f_rel_ageover30_count_d = NULL                                    => 0.0259779190,
                                                                         0.0259779190));

final_score_242 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 623556.5 => final_score_242_c1449,
    f_prevaddrmedianvalue_d > 623556.5                                     => final_score_242_c1450,
    f_prevaddrmedianvalue_d = NULL                                         => -0.0024939211,
                                                                              0.0003465375));

final_score_243_c1456 := __common__( map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 17.5 => 0.0633832928,
    f_addrs_per_ssn_i > 17.5                               => -0.0572245145,
    f_addrs_per_ssn_i = NULL                               => 0.0398622681,
                                                              0.0398622681));

final_score_243_c1455 := __common__( map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 55 => final_score_243_c1456,
    r_f01_inp_addr_address_score_d > 55                                            => 0.0021989823,
    r_f01_inp_addr_address_score_d = NULL                                          => 0.0030162382,
                                                                                      0.0030162382));

final_score_243_c1457 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 591250 => -0.0066496702,
    f_curraddrmedianvalue_d > 591250                                     => -0.0980710115,
    f_curraddrmedianvalue_d = NULL                                       => -0.0095245552,
                                                                            -0.0095245552));

final_score_243_c1454 := __common__( map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 3.5 => final_score_243_c1455,
    r_c23_inp_addr_occ_index_d > 3.5                                        => final_score_243_c1457,
    r_c23_inp_addr_occ_index_d = NULL                                       => 0.0017271066,
                                                                               0.0017271066));

final_score_243 := __common__( map(
    NULL < f_liens_unrel_st_total_amt_i AND f_liens_unrel_st_total_amt_i <= 19412.5 => final_score_243_c1454,
    f_liens_unrel_st_total_amt_i > 19412.5                                          => -0.1014897322,
    f_liens_unrel_st_total_amt_i = NULL                                             => 0.0385689201,
                                                                                       0.0013311431));

final_score_244_c1462 := __common__( map(
    NULL < r_prop_owner_history_d AND r_prop_owner_history_d <= 0.5 => 0.2644603654,
    r_prop_owner_history_d > 0.5                                    => 0.0530074202,
    r_prop_owner_history_d = NULL                                   => 0.1605887432,
                                                                       0.1605887432));

final_score_244_c1461 := __common__( map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 39344 => 0.0211264502,
    f_prevaddrmedianincome_d > 39344                                      => final_score_244_c1462,
    f_prevaddrmedianincome_d = NULL                                       => 0.1109496220,
                                                                             0.1109496220));

final_score_244_c1460 := __common__( map(
    NULL < r_a50_pb_average_dollars_d AND r_a50_pb_average_dollars_d <= 204.5 => 0.0312805475,
    r_a50_pb_average_dollars_d > 204.5                                        => final_score_244_c1461,
    r_a50_pb_average_dollars_d = NULL                                         => 0.0568729725,
                                                                                 0.0568729725));

final_score_244_c1459 := __common__( map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 5.5 => -0.0306653124,
    f_rel_ageover30_count_d > 5.5                                     => final_score_244_c1460,
    f_rel_ageover30_count_d = NULL                                    => 0.0322207306,
                                                                         0.0322207306));

final_score_244 := __common__( map(
    NULL < r_d33_eviction_recency_d AND r_d33_eviction_recency_d <= 18 => final_score_244_c1459,
    r_d33_eviction_recency_d > 18                                      => -0.0017359914,
    r_d33_eviction_recency_d = NULL                                    => 0.0199919701,
                                                                          -0.0006269828));

final_score_245_c1465 := __common__( map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 64.5 => 0.0061779640,
    f_addrchangeincomediff_d > 64.5                                      => 0.0863331371,
    f_addrchangeincomediff_d = NULL                                      => 0.0139998647,
                                                                            0.0094216627));

final_score_245_c1464 := __common__( map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 2.5 => -0.0039476331,
    f_bus_addr_match_count_d > 2.5                                      => final_score_245_c1465,
    f_bus_addr_match_count_d = NULL                                     => -0.0015671064,
                                                                           -0.0015671064));

final_score_245_c1467 := __common__( map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.015883685 => 0.1363799361,
    f_add_curr_nhood_bus_pct_i > 0.015883685                                        => -0.0239686243,
    f_add_curr_nhood_bus_pct_i = NULL                                               => 0.0129930778,
                                                                                       0.0129930778));

final_score_245_c1466 := __common__( map(
    NULL < f_hh_members_ct_d AND f_hh_members_ct_d <= 5.5 => final_score_245_c1467,
    f_hh_members_ct_d > 5.5                               => 0.1508319319,
    f_hh_members_ct_d = NULL                              => 0.0456946427,
                                                             0.0456946427));

final_score_245 := __common__( map(
    NULL < f_inq_collection_count24_i AND f_inq_collection_count24_i <= 5.5 => final_score_245_c1464,
    f_inq_collection_count24_i > 5.5                                        => final_score_245_c1466,
    f_inq_collection_count24_i = NULL                                       => 0.0260484812,
                                                                               -0.0007560307));

final_score_246_c1471 := __common__( map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 218.5 => 0.2680894078,
    f_mos_liens_unrel_cj_lseen_d > 218.5                                          => 0.0788964797,
    f_mos_liens_unrel_cj_lseen_d = NULL                                           => 0.1483125900,
                                                                                     0.1483125900));

final_score_246_c1470 := __common__( map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 10.5 => final_score_246_c1471,
    f_rel_homeover100_count_d > 10.5                                       => 0.0048448315,
    f_rel_homeover100_count_d = NULL                                       => 0.0824402340,
                                                                              0.0824402340));

final_score_246_c1469 := __common__( map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 193.5 => 0.0105979709,
    f_fp_prevaddrcrimeindex_i > 193.5                                       => final_score_246_c1470,
    f_fp_prevaddrcrimeindex_i = NULL                                        => 0.0135535434,
                                                                               0.0135535434));

final_score_246_c1472 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.1793777608 => 0.0829543954,
    f_add_input_mobility_index_i > 0.1793777608                                          => 0.0027498751,
    f_add_input_mobility_index_i = NULL                                                  => 0.0079310457,
                                                                                            0.0079310457));

final_score_246 := __common__( map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 11.5 => -0.0034112162,
    f_rel_under25miles_cnt_d > 11.5                                      => final_score_246_c1469,
    f_rel_under25miles_cnt_d = NULL                                      => final_score_246_c1472,
                                                                            0.0011891040));

final_score_247_c1475 := __common__( map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 98500 => -0.0212248942,
    k_estimated_income_d > 98500                                  => -0.0903683924,
    k_estimated_income_d = NULL                                   => -0.0341288130,
                                                                     -0.0341288130));

final_score_247_c1477 := __common__( map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 450 => -0.0120532787,
    r_c10_m_hdr_fs_d > 450                              => 0.0995379741,
    r_c10_m_hdr_fs_d = NULL                             => -0.0088788139,
                                                           -0.0088788139));

final_score_247_c1476 := __common__( map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 14.5 => final_score_247_c1477,
    f_rel_homeover300_count_d > 14.5                                       => 0.0504808610,
    f_rel_homeover300_count_d = NULL                                       => -0.0046326156,
                                                                              -0.0046326156));

final_score_247_c1474 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.0369010972 => final_score_247_c1475,
    f_add_input_nhood_sfd_pct_d > 0.0369010972                                         => final_score_247_c1476,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => -0.0101994060,
                                                                                          -0.0101994060));

final_score_247 := __common__( map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 74500 => 0.0046450267,
    k_estimated_income_d > 74500                                  => final_score_247_c1474,
    k_estimated_income_d = NULL                                   => -0.0015781153,
                                                                     0.0026024090));

final_score_248_c1482 := __common__( map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 172.5 => 0.0976825573,
    f_prevaddrcartheftindex_i > 172.5                                       => -0.0380426438,
    f_prevaddrcartheftindex_i = NULL                                        => 0.0308034727,
                                                                               0.0308034727));

final_score_248_c1481 := __common__( map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 147 => 0.1763544126,
    f_curraddrcartheftindex_i > 147                                       => final_score_248_c1482,
    f_curraddrcartheftindex_i = NULL                                      => 0.0769186220,
                                                                             0.0769186220));

final_score_248_c1480 := __common__( map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 9.5 => 0.0221706736,
    r_l79_adls_per_addr_curr_i > 9.5                                        => final_score_248_c1481,
    r_l79_adls_per_addr_curr_i = NULL                                       => 0.0275971141,
                                                                               0.0275971141));

final_score_248_c1479 := __common__( map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 34500 => final_score_248_c1480,
    k_estimated_income_d > 34500                                  => -0.0002367963,
    k_estimated_income_d = NULL                                   => 0.0098280563,
                                                                     0.0098280563));

final_score_248 := __common__( map(
    NULL < f_hh_payday_loan_users_i AND f_hh_payday_loan_users_i <= 0.5 => -0.0039763739,
    f_hh_payday_loan_users_i > 0.5                                      => final_score_248_c1479,
    f_hh_payday_loan_users_i = NULL                                     => -0.0344507237,
                                                                           -0.0009390453));

final_score_249_c1487 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 68533.5 => 0.0863020806,
    f_curraddrmedianvalue_d > 68533.5                                     => -0.0037220878,
    f_curraddrmedianvalue_d = NULL                                        => 0.0055458158,
                                                                             0.0055458158));

final_score_249_c1486 := __common__( map(
    NULL < f_phones_per_addr_c6_i AND f_phones_per_addr_c6_i <= 0.5 => final_score_249_c1487,
    f_phones_per_addr_c6_i > 0.5                                    => 0.0692609557,
    f_phones_per_addr_c6_i = NULL                                   => 0.0211716251,
                                                                       0.0211716251));

final_score_249_c1485 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.01478775405 => final_score_249_c1486,
    f_add_input_nhood_mfd_pct_i > 0.01478775405                                         => -0.0019020972,
    f_add_input_nhood_mfd_pct_i = NULL                                                  => -0.0072840037,
                                                                                           -0.0000322427));

final_score_249_c1484 := __common__( map(
    NULL < f_idrisktype_i AND f_idrisktype_i <= 4.5 => final_score_249_c1485,
    f_idrisktype_i > 4.5                            => 0.0661701637,
    f_idrisktype_i = NULL                           => 0.0001972932,
                                                       0.0001972932));

final_score_249 := __common__( map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 813702 => final_score_249_c1484,
    f_curraddrmedianvalue_d > 813702                                     => -0.0869879847,
    f_curraddrmedianvalue_d = NULL                                       => 0.0142422386,
                                                                            -0.0000717860));

final_score_250_c1492 := __common__( map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 239207.5 => 0.0590239879,
    r_a46_curr_avm_autoval_d > 239207.5                                      => 0.1493022061,
    r_a46_curr_avm_autoval_d = NULL                                          => 0.0624182073,
                                                                                0.0718547148));

final_score_250_c1491 := __common__( map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => final_score_250_c1492,
    f_corrphonelastnamecount_d > 0.5                                        => -0.0193524500,
    f_corrphonelastnamecount_d = NULL                                       => 0.0360081779,
                                                                               0.0360081779));

final_score_250_c1490 := __common__( map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 1.5 => final_score_250_c1491,
    r_d30_derog_count_i > 1.5                                 => 0.0011797874,
    r_d30_derog_count_i = NULL                                => 0.0089214302,
                                                                 0.0089214302));

final_score_250_c1489 := __common__( map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 75.4 => -0.0044930281,
    r_c12_source_profile_d > 75.4                                    => final_score_250_c1490,
    r_c12_source_profile_d = NULL                                    => -0.0113070155,
                                                                        -0.0024211406));

final_score_250 := __common__( map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 10.5 => final_score_250_c1489,
    k_inq_lnames_per_addr_i > 10.5                                     => 0.0965231369,
    k_inq_lnames_per_addr_i = NULL                                     => -0.0021750797,
                                                                          -0.0021750797));

final_score_251_c1497 := __common__( map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 0.5 => -0.0098581443,
    f_bus_addr_match_count_d > 0.5                                      => -0.0913869905,
    f_bus_addr_match_count_d = NULL                                     => -0.0164833374,
                                                                           -0.0164833374));

final_score_251_c1496 := __common__( map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 3.5 => 0.0751011928,
    f_rel_ageover30_count_d > 3.5                                     => final_score_251_c1497,
    f_rel_ageover30_count_d = NULL                                    => -0.0109701626,
                                                                         -0.0109701626));

final_score_251_c1495 := __common__( map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 58 => -0.1045958806,
    r_c21_m_bureau_adl_fs_d > 58                                     => final_score_251_c1496,
    r_c21_m_bureau_adl_fs_d = NULL                                   => -0.0176856019,
                                                                        -0.0176856019));

final_score_251_c1494 := __common__( map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 8.5 => 0.0047636743,
    f_corrrisktype_i > 8.5                              => final_score_251_c1495,
    f_corrrisktype_i = NULL                             => 0.0031178973,
                                                           0.0031178973));

final_score_251 := __common__( map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 4.5 => -0.0084082381,
    f_rel_under25miles_cnt_d > 4.5                                      => final_score_251_c1494,
    f_rel_under25miles_cnt_d = NULL                                     => 0.0024142021,
                                                                           -0.0005144741));

final_score_252_c1502 := __common__( map(
    NULL < f_prevaddrstatus_i AND f_prevaddrstatus_i <= 2.5 => 0.0072556172,
    f_prevaddrstatus_i > 2.5                                => 0.0696146733,
    f_prevaddrstatus_i = NULL                               => 0.1415127725,
                                                               0.0429556775));

final_score_252_c1501 := __common__( map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.03066000395 => -0.0051915550,
    f_add_input_nhood_vac_pct_i > 0.03066000395                                         => final_score_252_c1502,
    f_add_input_nhood_vac_pct_i = NULL                                                  => 0.0164230917,
                                                                                           0.0164230917));

final_score_252_c1500 := __common__( map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d <= 27.5 => final_score_252_c1501,
    f_rel_incomeover25_count_d > 27.5                                        => 0.1403055106,
    f_rel_incomeover25_count_d = NULL                                        => 0.0232071289,
                                                                                0.0232071289));

final_score_252_c1499 := __common__( map(
    NULL < r_d33_eviction_recency_d AND r_d33_eviction_recency_d <= 48 => final_score_252_c1500,
    r_d33_eviction_recency_d > 48                                      => 0.0003559608,
    r_d33_eviction_recency_d = NULL                                    => 0.0019607467,
                                                                          0.0019607467));

final_score_252 := __common__( map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 12.5 => final_score_252_c1499,
    f_inq_count24_i > 12.5                             => -0.0311786045,
    f_inq_count24_i = NULL                             => -0.0053714148,
                                                          0.0009615309));

final_score_253_c1506 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 197067.5 => 0.0327938951,
    f_prevaddrmedianvalue_d > 197067.5                                     => 0.1633156474,
    f_prevaddrmedianvalue_d = NULL                                         => 0.0723315062,
                                                                              0.0723315062));

final_score_253_c1507 := __common__( map(
    NULL < f_mos_liens_unrel_o_lseen_d AND f_mos_liens_unrel_o_lseen_d <= 127.5 => 0.1425554685,
    f_mos_liens_unrel_o_lseen_d > 127.5                                         => -0.0081377922,
    f_mos_liens_unrel_o_lseen_d = NULL                                          => 0.0035752863,
                                                                                   0.0035752863));

final_score_253_c1505 := __common__( map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 0.5 => final_score_253_c1506,
    r_l79_adls_per_addr_c6_i > 0.5                                      => final_score_253_c1507,
    r_l79_adls_per_addr_c6_i = NULL                                     => 0.0235532336,
                                                                           0.0235532336));

final_score_253_c1504 := __common__( map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 7.5 => -0.0039379813,
    k_inq_per_ssn_i > 7.5                             => final_score_253_c1505,
    k_inq_per_ssn_i = NULL                            => -0.0028926500,
                                                         -0.0028926500));

final_score_253 := __common__( map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 110.5 => final_score_253_c1504,
    f_bus_addr_match_count_d > 110.5                                      => 0.0458066932,
    f_bus_addr_match_count_d = NULL                                       => -0.0026367592,
                                                                             -0.0026367592));

final_score_254_c1510 := __common__( map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.15957489555 => 0.0244064823,
    f_add_input_nhood_vac_pct_i > 0.15957489555                                         => -0.0500947086,
    f_add_input_nhood_vac_pct_i = NULL                                                  => 0.0168079903,
                                                                                           0.0168079903));

final_score_254_c1512 := __common__( map(
    NULL < f_corraddrphonecount_d AND f_corraddrphonecount_d <= 1.5 => -0.0014040505,
    f_corraddrphonecount_d > 1.5                                    => 0.0762503647,
    f_corraddrphonecount_d = NULL                                   => 0.0027072663,
                                                                       0.0027072663));

final_score_254_c1511 := __common__( map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 17.5 => final_score_254_c1512,
    f_rel_under100miles_cnt_d > 17.5                                       => 0.0583832349,
    f_rel_under100miles_cnt_d = NULL                                       => 0.0165651138,
                                                                              0.0067777965));

final_score_254_c1509 := __common__( map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i <= -61093.5 => -0.0855568846,
    r_a49_curr_avm_chg_1yr_i > -61093.5                                      => final_score_254_c1510,
    r_a49_curr_avm_chg_1yr_i = NULL                                          => final_score_254_c1511,
                                                                                0.0082670790));

final_score_254 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 31.5 => final_score_254_c1509,
    k_comb_age_d > 31.5                          => -0.0050998473,
    k_comb_age_d = NULL                          => 0.0113885792,
                                                    -0.0013171414));

final_score_255_c1516 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.77753150005 => 0.0047592961,
    f_add_curr_mobility_index_i > 0.77753150005                                         => 0.0895060095,
    f_add_curr_mobility_index_i = NULL                                                  => 0.0052361137,
                                                                                           0.0052361137));

final_score_255_c1515 := __common__( map(
    NULL < f_phones_per_addr_c6_i AND f_phones_per_addr_c6_i <= 19.5 => final_score_255_c1516,
    f_phones_per_addr_c6_i > 19.5                                    => 0.0962826493,
    f_phones_per_addr_c6_i = NULL                                    => 0.0055779044,
                                                                        0.0055779044));

final_score_255_c1517 := __common__( map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 40.5 => 0.0005651132,
    f_bus_addr_match_count_d > 40.5                                      => -0.0719658104,
    f_bus_addr_match_count_d = NULL                                      => -0.0013717163,
                                                                            -0.0013717163));

final_score_255_c1514 := __common__( map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 118.5 => final_score_255_c1515,
    f_addrchangecrimediff_i > 118.5                                     => 0.0875077747,
    f_addrchangecrimediff_i = NULL                                      => final_score_255_c1517,
                                                                           0.0046767263));

final_score_255 := __common__( map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 53.5 => -0.0158412519,
    f_prevaddrcartheftindex_i > 53.5                                       => final_score_255_c1514,
    f_prevaddrcartheftindex_i = NULL                                       => -0.0132944929,
                                                                              0.0007081290));

final_score_256_c1521 := __common__( map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 3.5 => 0.0821384052,
    f_addrs_per_ssn_i > 3.5                               => -0.0243195870,
    f_addrs_per_ssn_i = NULL                              => -0.0189756720,
                                                             -0.0189756720));

final_score_256_c1520 := __common__( map(
    NULL < f_mos_liens_unrel_st_fseen_d AND f_mos_liens_unrel_st_fseen_d <= 143.5 => final_score_256_c1521,
    f_mos_liens_unrel_st_fseen_d > 143.5                                          => 0.0083435306,
    f_mos_liens_unrel_st_fseen_d = NULL                                           => 0.0054890933,
                                                                                     0.0054890933));

final_score_256_c1519 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 828365.5 => final_score_256_c1520,
    f_prevaddrmedianvalue_d > 828365.5                                     => -0.1021428762,
    f_prevaddrmedianvalue_d = NULL                                         => 0.0051350616,
                                                                              0.0051350616));

final_score_256_c1522 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 22.5 => 0.0751233036,
    k_comb_age_d > 22.5                          => -0.0193389332,
    k_comb_age_d = NULL                          => -0.0146150058,
                                                    -0.0147002962));

final_score_256 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.05676001335 => -0.0101746367,
    f_add_curr_nhood_mfd_pct_i > 0.05676001335                                        => final_score_256_c1519,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => final_score_256_c1522,
                                                                                         -0.0001143188));

final_score_257_c1525 := __common__( map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i <= 136.700001 => 0.0041711377,
    r_a49_curr_avm_chg_1yr_pct_i > 136.700001                                          => 0.1581059677,
    r_a49_curr_avm_chg_1yr_pct_i = NULL                                           => 0.0103317226,
                                                                                     0.0118582640));

final_score_257_c1524 := __common__( map(
    NULL < r_c12_num_nonderogs_d AND r_c12_num_nonderogs_d <= 1.5 => final_score_257_c1525,
    r_c12_num_nonderogs_d > 1.5                                   => -0.0021765350,
    r_c12_num_nonderogs_d = NULL                                  => -0.0003864954,
                                                                     -0.0003864954));

final_score_257_c1527 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.27680086245 => 0.0543691025,
    f_add_input_mobility_index_i > 0.27680086245                                          => 0.2283835504,
    f_add_input_mobility_index_i = NULL                                                   => 0.1407318285,
                                                                                             0.1407318285));

final_score_257_c1526 := __common__( map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 1.5 => final_score_257_c1527,
    f_hh_lienholders_i > 1.5                                => -0.0201090011,
    f_hh_lienholders_i = NULL                               => 0.0633808951,
                                                               0.0633808951));

final_score_257 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 436.5 => final_score_257_c1524,
    r_c13_max_lres_d > 436.5                              => final_score_257_c1526,
    r_c13_max_lres_d = NULL                               => -0.0070370224,
                                                             0.0002659882));

final_score_258_c1530 := __common__( map(
    NULL < f_prevaddrstatus_i AND f_prevaddrstatus_i <= 2.5 => 0.0381640349,
    f_prevaddrstatus_i > 2.5                                => 0.0752270850,
    f_prevaddrstatus_i = NULL                               => -0.0386225431,
                                                               0.0342120813));

final_score_258_c1532 := __common__( map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d <= 3.5 => -0.0033867729,
    r_c14_addr_stability_v2_d > 3.5                                       => 0.0090773430,
    r_c14_addr_stability_v2_d = NULL                                      => 0.0036315627,
                                                                             0.0036315627));

final_score_258_c1531 := __common__( map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 55.5 => final_score_258_c1532,
    f_bus_addr_match_count_d > 55.5                                      => -0.0500380305,
    f_bus_addr_match_count_d = NULL                                      => 0.0030388323,
                                                                            0.0030388323));

final_score_258_c1529 := __common__( map(
    NULL < f_mos_liens_rel_cj_lseen_d AND f_mos_liens_rel_cj_lseen_d <= 160.5 => final_score_258_c1530,
    f_mos_liens_rel_cj_lseen_d > 160.5                                        => final_score_258_c1531,
    f_mos_liens_rel_cj_lseen_d = NULL                                         => 0.0041618077,
                                                                                 0.0041618077));

final_score_258 := __common__( map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i <= 591.5 => final_score_258_c1529,
    f_liens_unrel_cj_total_amt_i > 591.5                                          => -0.0092578363,
    f_liens_unrel_cj_total_amt_i = NULL                                           => -0.0179684102,
                                                                                     0.0005288592));

final_score_259_c1536 := __common__( map(
    NULL < f_rel_count_i AND f_rel_count_i <= 11.5 => 0.0659437376,
    f_rel_count_i > 11.5                           => -0.0195627413,
    f_rel_count_i = NULL                           => 0.0059179879,
                                                      0.0059179879));

final_score_259_c1537 := __common__( map(
    NULL < r_a50_pb_average_dollars_d AND r_a50_pb_average_dollars_d <= 287 => 0.0170816717,
    r_a50_pb_average_dollars_d > 287                                        => 0.1559247176,
    r_a50_pb_average_dollars_d = NULL                                       => 0.0491950293,
                                                                               0.0491950293));

final_score_259_c1535 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.33188066775 => final_score_259_c1536,
    f_add_input_mobility_index_i > 0.33188066775                                          => final_score_259_c1537,
    f_add_input_mobility_index_i = NULL                                                   => 0.0170496154,
                                                                                             0.0170496154));

final_score_259_c1534 := __common__( map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 9.5 => -0.0121990428,
    f_util_adl_count_n > 9.5                                => final_score_259_c1535,
    f_util_adl_count_n = NULL                               => -0.0086368846,
                                                               -0.0086368846));

final_score_259 := __common__( map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 1.5 => 0.0038871474,
    f_hh_lienholders_i > 1.5                                => final_score_259_c1534,
    f_hh_lienholders_i = NULL                               => 0.0013813736,
                                                               -0.0008662955));

final_score_260_c1542 := __common__( map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d <= 3.5 => 0.0027982789,
    f_hh_age_18_plus_d > 3.5                                => 0.0218899210,
    f_hh_age_18_plus_d = NULL                               => 0.0082900739,
                                                               0.0082900739));

final_score_260_c1541 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 36.5 => -0.0152480246,
    r_c13_max_lres_d > 36.5                              => final_score_260_c1542,
    r_c13_max_lres_d = NULL                              => 0.0061719081,
                                                            0.0061719081));

final_score_260_c1540 := __common__( map(
    NULL < r_i61_inq_collection_count12_i AND r_i61_inq_collection_count12_i <= 2.5 => final_score_260_c1541,
    r_i61_inq_collection_count12_i > 2.5                                            => -0.0351469164,
    r_i61_inq_collection_count12_i = NULL                                           => 0.0049903732,
                                                                                       0.0049903732));

final_score_260_c1539 := __common__( map(
    NULL < f_mos_liens_unrel_ft_fseen_d AND f_mos_liens_unrel_ft_fseen_d <= 62.5 => 0.0903088238,
    f_mos_liens_unrel_ft_fseen_d > 62.5                                          => final_score_260_c1540,
    f_mos_liens_unrel_ft_fseen_d = NULL                                          => 0.0057150544,
                                                                                    0.0057150544));

final_score_260 := __common__( map(
    NULL < (Integer)k_inf_phn_verd_d AND (Real)k_inf_phn_verd_d <= 0.5 => final_score_260_c1539,
    (Real)k_inf_phn_verd_d > 0.5                              => -0.0131005512,
    (Integer)k_inf_phn_verd_d = NULL                             => -0.0004605481,
                                                           -0.0004605481));

final_score_261_c1545 := __common__( map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 3.5 => 0.1668223178,
    r_c20_email_count_i > 3.5                                 => -0.0268954431,
    r_c20_email_count_i = NULL                                => 0.0881244774,
                                                                 0.0881244774));

final_score_261_c1544 := __common__( map(
    NULL < r_d34_unrel_liens_ct_i AND r_d34_unrel_liens_ct_i <= 17.5 => -0.0017877605,
    r_d34_unrel_liens_ct_i > 17.5                                    => final_score_261_c1545,
    r_d34_unrel_liens_ct_i = NULL                                    => -0.0011955508,
                                                                        -0.0011955508));

final_score_261_c1547 := __common__( map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 1.5 => 0.1004848307,
    k_inq_ssns_per_addr_i > 1.5                                   => -0.0080522188,
    k_inq_ssns_per_addr_i = NULL                                  => 0.0701672191,
                                                                     0.0701672191));

final_score_261_c1546 := __common__( map(
    NULL < f_hh_tot_derog_i AND f_hh_tot_derog_i <= 3.5 => final_score_261_c1547,
    f_hh_tot_derog_i > 3.5                              => -0.0258526432,
    f_hh_tot_derog_i = NULL                             => 0.0322134222,
                                                           0.0322134222));

final_score_261 := __common__( map(
    NULL < f_divssnidmsrcurelcount_i AND f_divssnidmsrcurelcount_i <= 2.5 => final_score_261_c1544,
    f_divssnidmsrcurelcount_i > 2.5                                       => final_score_261_c1546,
    f_divssnidmsrcurelcount_i = NULL                                      => -0.0202836434,
                                                                             -0.0004557186));

final_score_262_c1551 := __common__( map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 4.5 => 0.1015257544,
    f_addrs_per_ssn_i > 4.5                               => -0.0149898466,
    f_addrs_per_ssn_i = NULL                              => 0.0311472035,
                                                             0.0311472035));

final_score_262_c1550 := __common__( map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 133.5 => 0.1271511259,
    f_curraddrmurderindex_i > 133.5                                     => final_score_262_c1551,
    f_curraddrmurderindex_i = NULL                                      => 0.0660204232,
                                                                           0.0660204232));

final_score_262_c1552 := __common__( map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.0244067909 => 0.0520406357,
    f_add_curr_nhood_bus_pct_i > 0.0244067909                                        => -0.0397134448,
    f_add_curr_nhood_bus_pct_i = NULL                                                => -0.0035930601,
                                                                                        -0.0035930601));

final_score_262_c1549 := __common__( map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 4.5 => final_score_262_c1550,
    f_rel_ageover30_count_d > 4.5                                     => final_score_262_c1552,
    f_rel_ageover30_count_d = NULL                                    => 0.0316657171,
                                                                         0.0316657171));

final_score_262 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 617699 => 0.0000840747,
    f_prevaddrmedianvalue_d > 617699                                     => final_score_262_c1549,
    f_prevaddrmedianvalue_d = NULL                                       => 0.0324452339,
                                                                            0.0007919916));

final_score_263_c1557 := __common__( map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 131 => 0.0228379513,
    f_curraddrmurderindex_i > 131                                     => 0.1710196538,
    f_curraddrmurderindex_i = NULL                                    => 0.0864934714,
                                                                         0.0864934714));

final_score_263_c1556 := __common__( map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 66 => final_score_263_c1557,
    r_pb_order_freq_d > 66                               => -0.0036668655,
    r_pb_order_freq_d = NULL                             => -0.0098705038,
                                                            0.0393396175));

final_score_263_c1555 := __common__( map(
    NULL < f_rel_ageover20_count_d AND f_rel_ageover20_count_d <= 20.5 => final_score_263_c1556,
    f_rel_ageover20_count_d > 20.5                                     => 0.1600391458,
    f_rel_ageover20_count_d = NULL                                     => 0.0585660911,
                                                                          0.0585660911));

final_score_263_c1554 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.3792870535 => final_score_263_c1555,
    f_add_input_mobility_index_i > 0.3792870535                                          => -0.0724263928,
    f_add_input_mobility_index_i = NULL                                                  => 0.0401811811,
                                                                                            0.0401811811));

final_score_263 := __common__( map(
    NULL < f_inq_collection_count24_i AND f_inq_collection_count24_i <= 5.5 => 0.0016117590,
    f_inq_collection_count24_i > 5.5                                        => final_score_263_c1554,
    f_inq_collection_count24_i = NULL                                       => -0.0247242664,
                                                                               0.0021661415));

final_score_264_c1560 := __common__( map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 57 => 0.0358903555,
    f_prevaddrcartheftindex_i > 57                                       => -0.0264127816,
    f_prevaddrcartheftindex_i = NULL                                     => -0.0133055298,
                                                                            -0.0133055298));

final_score_264_c1559 := __common__( map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i <= 15.5 => -0.0006533652,
    f_crim_rel_under25miles_cnt_i > 15.5                                           => -0.0608454313,
    f_crim_rel_under25miles_cnt_i = NULL                                           => final_score_264_c1560,
                                                                                      -0.0016468368));

final_score_264_c1562 := __common__( map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 189 => 0.0086596789,
    f_prevaddrlenofres_d > 189                                  => 0.1206070210,
    f_prevaddrlenofres_d = NULL                                 => 0.0232882862,
                                                                   0.0232882862));

final_score_264_c1561 := __common__( map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.0944344951 => 0.1203149851,
    f_add_curr_nhood_sfd_pct_d > 0.0944344951                                        => final_score_264_c1562,
    f_add_curr_nhood_sfd_pct_d = NULL                                                => 0.0302276159,
                                                                                        0.0302276159));

final_score_264 := __common__( map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 23.5 => final_score_264_c1559,
    r_d30_derog_count_i > 23.5                                 => final_score_264_c1561,
    r_d30_derog_count_i = NULL                                 => 0.0176284227,
                                                                  -0.0005972110));

final_score_265_c1567 := __common__( map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.00604367515 => -0.0193256037,
    f_add_curr_nhood_vac_pct_i > 0.00604367515                                        => 0.0932144921,
    f_add_curr_nhood_vac_pct_i = NULL                                                 => 0.0494488993,
                                                                                         0.0494488993));

final_score_265_c1566 := __common__( map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 68.5 => -0.0090549128,
    r_c13_curr_addr_lres_d > 68.5                                    => final_score_265_c1567,
    r_c13_curr_addr_lres_d = NULL                                    => 0.0039861847,
                                                                        0.0039861847));

final_score_265_c1565 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 184.5 => final_score_265_c1566,
    r_c13_max_lres_d > 184.5                              => -0.0861365303,
    r_c13_max_lres_d = NULL                               => -0.0082019107,
                                                             -0.0038636762));

final_score_265_c1564 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.4203050241 => final_score_265_c1565,
    f_add_input_mobility_index_i > 0.4203050241                                          => 0.0908611773,
    f_add_input_mobility_index_i = NULL                                                  => 0.0021300800,
                                                                                            0.0021300800));

final_score_265 := __common__( map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 25.5 => -0.0011189658,
    f_rel_homeover200_count_d > 25.5                                       => -0.0843634886,
    f_rel_homeover200_count_d = NULL                                       => final_score_265_c1564,
                                                                              -0.0013672503));

final_score_266_c1571 := __common__( map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 2.5 => 0.0160802870,
    f_rel_homeover150_count_d > 2.5                                       => -0.1082244249,
    f_rel_homeover150_count_d = NULL                                      => -0.0619891357,
                                                                             -0.0619891357));

final_score_266_c1570 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -74905.5 => final_score_266_c1571,
    f_addrchangevaluediff_d > -74905.5                                     => -0.0127830302,
    f_addrchangevaluediff_d = NULL                                         => -0.0067852542,
                                                                              -0.0135058974));

final_score_266_c1569 := __common__( map(
    NULL < f_bus_fname_verd_d AND f_bus_fname_verd_d <= 0.5 => final_score_266_c1570,
    f_bus_fname_verd_d > 0.5                                => 0.1069451164,
    f_bus_fname_verd_d = NULL                               => -0.0119365868,
                                                               -0.0119365868));

final_score_266_c1572 := __common__( map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 14.5 => 0.0015740596,
    r_l79_adls_per_addr_c6_i > 14.5                                      => -0.0394948917,
    r_l79_adls_per_addr_c6_i = NULL                                      => 0.0009560228,
                                                                            0.0009560228));

final_score_266 := __common__( map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 115.5 => final_score_266_c1569,
    f_m_bureau_adl_fs_all_d > 115.5                                     => final_score_266_c1572,
    f_m_bureau_adl_fs_all_d = NULL                                      => 0.0024783053,
                                                                           -0.0014610360));

final_score_267_c1575 := __common__( map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 6.5 => 0.0271237577,
    f_srchvelocityrisktype_i > 6.5                                      => -0.0751900157,
    f_srchvelocityrisktype_i = NULL                                     => 0.0187046326,
                                                                           0.0187046326));

final_score_267_c1574 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.0020799136 => 0.0709711653,
    f_add_input_nhood_sfd_pct_d > 0.0020799136                                         => final_score_267_c1575,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => 0.0247626525,
                                                                                          0.0247626525));

final_score_267_c1577 := __common__( map(
    NULL < f_rel_bankrupt_count_i AND f_rel_bankrupt_count_i <= 0.5 => 0.0081290702,
    f_rel_bankrupt_count_i > 0.5                                    => -0.0058982847,
    f_rel_bankrupt_count_i = NULL                                   => -0.0012621948,
                                                                       -0.0012621948));

final_score_267_c1576 := __common__( map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 41.5 => -0.0228448753,
    r_c13_max_lres_d > 41.5                              => final_score_267_c1577,
    r_c13_max_lres_d = NULL                              => -0.0029841457,
                                                            -0.0029841457));

final_score_267 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 20.5 => final_score_267_c1574,
    k_comb_age_d > 20.5                          => final_score_267_c1576,
    k_comb_age_d = NULL                          => 0.0209903127,
                                                    -0.0020082125));

final_score_268_c1582 := __common__( map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 0.5 => -0.0067382202,
    f_rel_homeover200_count_d > 0.5                                       => 0.0351567040,
    f_rel_homeover200_count_d = NULL                                      => 0.0460453874,
                                                                             0.0203299245));

final_score_268_c1581 := __common__( map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 35 => -0.0245553618,
    f_curraddrburglaryindex_i > 35                                       => final_score_268_c1582,
    f_curraddrburglaryindex_i = NULL                                     => 0.0117148454,
                                                                            0.0117148454));

final_score_268_c1580 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.14684582285 => final_score_268_c1581,
    f_add_input_nhood_bus_pct_i > 0.14684582285                                         => -0.0404087380,
    f_add_input_nhood_bus_pct_i = NULL                                                  => 0.0644437720,
                                                                                           0.0083380081));

final_score_268_c1579 := __common__( map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d <= 5.5 => 0.1528571828,
    f_mos_acc_lseen_d > 5.5                               => final_score_268_c1580,
    f_mos_acc_lseen_d = NULL                              => 0.0126669235,
                                                             0.0126669235));

final_score_268 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 23.5 => final_score_268_c1579,
    k_comb_age_d > 23.5                          => -0.0024866705,
    k_comb_age_d = NULL                          => 0.0034312418,
                                                    -0.0011522597));

final_score_269_c1584 := __common__( map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 30.5 => 0.1214353990,
    f_curraddrburglaryindex_i > 30.5                                       => 0.0165951400,
    f_curraddrburglaryindex_i = NULL                                       => 0.0451116905,
                                                                              0.0451116905));

final_score_269_c1587 := __common__( map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 62 => -0.0714734193,
    f_curraddrmurderindex_i > 62                                     => 0.0785419691,
    f_curraddrmurderindex_i = NULL                                   => -0.0315160495,
                                                                        -0.0315160495));

final_score_269_c1586 := __common__( map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.0253317045 => -0.0846958646,
    f_add_input_nhood_bus_pct_i > 0.0253317045                                         => 0.0475572066,
    f_add_input_nhood_bus_pct_i = NULL                                                 => final_score_269_c1587,
                                                                                          -0.0193444199));

final_score_269_c1585 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.017021233 => 0.1452664820,
    f_add_curr_nhood_mfd_pct_i > 0.017021233                                        => -0.0301442555,
    f_add_curr_nhood_mfd_pct_i = NULL                                               => final_score_269_c1586,
                                                                                       -0.0095815734));

final_score_269 := __common__( map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.001667364 => final_score_269_c1584,
    f_add_curr_nhood_bus_pct_i > 0.001667364                                        => 0.0005808243,
    f_add_curr_nhood_bus_pct_i = NULL                                               => final_score_269_c1585,
                                                                                       0.0007471830));

final_score_270_c1592 := __common__( map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 0.5 => 0.1768348369,
    f_rel_homeover300_count_d > 0.5                                       => 0.0119510121,
    f_rel_homeover300_count_d = NULL                                      => 0.0525994550,
                                                                             0.0525994550));

final_score_270_c1591 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.6187991763 => 0.0150150393,
    f_add_curr_nhood_mfd_pct_i > 0.6187991763                                        => final_score_270_c1592,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => 0.0898611135,
                                                                                        0.0262323967));

final_score_270_c1590 := __common__( map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 173 => final_score_270_c1591,
    f_prevaddrlenofres_d > 173                                  => -0.1182494416,
    f_prevaddrlenofres_d = NULL                                 => 0.0226235730,
                                                                   0.0226235730));

final_score_270_c1589 := __common__( map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 4.5 => -0.0138108636,
    f_rel_under100miles_cnt_d > 4.5                                       => final_score_270_c1590,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0136373914,
                                                                             0.0136373914));

final_score_270 := __common__( map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 3.5 => -0.0044655482,
    r_c14_addrs_5yr_i > 3.5                               => final_score_270_c1589,
    r_c14_addrs_5yr_i = NULL                              => -0.0200326328,
                                                             -0.0023384618));

final_score_271_c1597 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.0783067466 => 0.0203117932,
    f_add_input_nhood_sfd_pct_d > 0.0783067466                                         => -0.0536788708,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => 0.0019080239,
                                                                                          0.0019080239));

final_score_271_c1596 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.4066670384 => 0.0996003390,
    f_add_curr_nhood_mfd_pct_i > 0.4066670384                                        => final_score_271_c1597,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => 0.0150052354,
                                                                                        0.0150052354));

final_score_271_c1595 := __common__( map(
    NULL < k_inq_adls_per_addr_i AND k_inq_adls_per_addr_i <= 0.5 => final_score_271_c1596,
    k_inq_adls_per_addr_i > 0.5                                   => -0.0348954108,
    k_inq_adls_per_addr_i = NULL                                  => -0.0046747508,
                                                                     -0.0046747508));

final_score_271_c1594 := __common__( map(
    NULL < f_crim_rel_under100miles_cnt_i AND f_crim_rel_under100miles_cnt_i <= 22.5 => 0.0026968530,
    f_crim_rel_under100miles_cnt_i > 22.5                                            => 0.0831117184,
    f_crim_rel_under100miles_cnt_i = NULL                                            => final_score_271_c1595,
                                                                                        0.0029436814));

final_score_271 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 1.1153944273 => final_score_271_c1594,
    f_add_input_mobility_index_i > 1.1153944273                                          => 0.0858682148,
    f_add_input_mobility_index_i = NULL                                                  => -0.0357075150,
                                                                                            0.0028739786));

final_score_272_c1602 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.3005799559 => -0.0008459974,
    f_add_input_mobility_index_i > 0.3005799559                                          => 0.1444089161,
    f_add_input_mobility_index_i = NULL                                                  => 0.0530630427,
                                                                                            0.0530630427));

final_score_272_c1601 := __common__( map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.0236801242 => 0.1790047733,
    f_add_curr_nhood_bus_pct_i > 0.0236801242                                        => final_score_272_c1602,
    f_add_curr_nhood_bus_pct_i = NULL                                                => 0.0934346079,
                                                                                        0.0934346079));

final_score_272_c1600 := __common__( map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '6: Other'])          => -0.0099064515,
    (nf_seg_fraudpoint_3_0 in ['3: Derog', '4: Recent Activity', '5: Vuln Vic/Friendly']) => final_score_272_c1601,
    nf_seg_fraudpoint_3_0 = ''                                                         => 0.0596096562,
                                                                                             0.0596096562));

final_score_272_c1599 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 35.5 => final_score_272_c1600,
    k_comb_age_d > 35.5                          => 0.0003459052,
    k_comb_age_d = NULL                          => 0.0232151053,
                                                    0.0232151053));

final_score_272 := __common__( map(
    NULL < f_prevaddroccupantowned_i AND f_prevaddroccupantowned_i <= 0.5 => -0.0010049177,
    f_prevaddroccupantowned_i > 0.5                                       => final_score_272_c1599,
    f_prevaddroccupantowned_i = NULL                                      => -0.0026542563,
                                                                             0.0001068281));

final_score_273_c1606 := __common__( map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d <= 19.5 => 0.0243006238,
    f_rel_incomeover25_count_d > 19.5                                        => -0.0503015146,
    f_rel_incomeover25_count_d = NULL                                        => 0.0123207183,
                                                                                0.0123207183));

final_score_273_c1605 := __common__( map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 4.5 => 0.1748406141,
    r_i61_inq_collection_recency_d > 4.5                                            => final_score_273_c1606,
    r_i61_inq_collection_recency_d = NULL                                           => 0.0242797295,
                                                                                       0.0242797295));

final_score_273_c1604 := __common__( map(
    NULL < f_srchaddrsrchcountwk_i AND f_srchaddrsrchcountwk_i <= 0.5 => -0.0033913196,
    f_srchaddrsrchcountwk_i > 0.5                                     => final_score_273_c1605,
    f_srchaddrsrchcountwk_i = NULL                                    => -0.0021964154,
                                                                         -0.0021964154));

final_score_273_c1607 := __common__( map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 41 => 0.0972405589,
    f_curraddrburglaryindex_i > 41                                       => 0.0164398098,
    f_curraddrburglaryindex_i = NULL                                     => 0.0408795426,
                                                                            0.0408795426));

final_score_273 := __common__( map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 625459.5 => final_score_273_c1604,
    f_prevaddrmedianvalue_d > 625459.5                                     => final_score_273_c1607,
    f_prevaddrmedianvalue_d = NULL                                         => -0.0252654368,
                                                                              -0.0017129084));

final_score_274_c1611 := __common__( map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i <= 0.01441168845 => 0.0619286300,
    f_add_input_nhood_vac_pct_i > 0.01441168845                                         => -0.0495970696,
    f_add_input_nhood_vac_pct_i = NULL                                                  => 0.0081573105,
                                                                                           0.0081573105));

final_score_274_c1610 := __common__( map(
    NULL < f_hh_tot_derog_i AND f_hh_tot_derog_i <= 1.5 => -0.0699060687,
    f_hh_tot_derog_i > 1.5                              => final_score_274_c1611,
    f_hh_tot_derog_i = NULL                             => -0.0326485468,
                                                           -0.0326485468));

final_score_274_c1609 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 168491.5 => -0.0019849077,
    f_addrchangevaluediff_d > 168491.5                                     => final_score_274_c1610,
    f_addrchangevaluediff_d = NULL                                         => -0.0025096076,
                                                                              -0.0025096076));

final_score_274_c1612 := __common__( map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 189.5 => 0.0050228036,
    f_curraddrburglaryindex_i > 189.5                                       => -0.0680893389,
    f_curraddrburglaryindex_i = NULL                                        => 0.0190876631,
                                                                               0.0025740871));

final_score_274 := __common__( map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 454567 => final_score_274_c1609,
    f_addrchangevaluediff_d > 454567                                     => 0.0681981742,
    f_addrchangevaluediff_d = NULL                                       => final_score_274_c1612,
                                                                            -0.0014538050));

final_score_275_c1615 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.0403943279 => -0.0116283169,
    f_add_curr_nhood_mfd_pct_i > 0.0403943279                                        => 0.0213997137,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => -0.0070006808,
                                                                                        0.0094031270));

final_score_275_c1617 := __common__( map(
    NULL < r_a50_pb_total_orders_d AND r_a50_pb_total_orders_d <= 2.5 => -0.0188734591,
    r_a50_pb_total_orders_d > 2.5                                     => 0.1039550828,
    r_a50_pb_total_orders_d = NULL                                    => -0.0083875530,
                                                                         -0.0085527025));

final_score_275_c1616 := __common__( map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.1972930945 => 0.0391623639,
    f_add_input_mobility_index_i > 0.1972930945                                          => final_score_275_c1617,
    f_add_input_mobility_index_i = NULL                                                  => -0.0016917126,
                                                                                            -0.0016917126));

final_score_275_c1614 := __common__( map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 11.5 => -0.0047837007,
    f_rel_under25miles_cnt_d > 11.5                                      => final_score_275_c1615,
    f_rel_under25miles_cnt_d = NULL                                      => final_score_275_c1616,
                                                                            -0.0010622459));

final_score_275 := __common__( map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 29.5 => final_score_275_c1614,
    f_bus_addr_match_count_d > 29.5                                      => -0.0193205677,
    f_bus_addr_match_count_d = NULL                                      => -0.0016657542,
                                                                            -0.0016657542));

final_score_276_c1621 := __common__( map(
    NULL < f_mos_liens_rel_cj_lseen_d AND f_mos_liens_rel_cj_lseen_d <= 140.5 => 0.0619653384,
    f_mos_liens_rel_cj_lseen_d > 140.5                                        => -0.0144044895,
    f_mos_liens_rel_cj_lseen_d = NULL                                         => -0.0075806776,
                                                                                 -0.0075806776));

final_score_276_c1620 := __common__( map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d <= 29705.5 => -0.1266751314,
    r_a46_curr_avm_autoval_d > 29705.5                                      => -0.0241818545,
    r_a46_curr_avm_autoval_d = NULL                                         => final_score_276_c1621,
                                                                               -0.0158204956));

final_score_276_c1619 := __common__( map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i <= 1.5 => 0.0045269285,
    r_i60_inq_comm_count12_i > 1.5                                      => final_score_276_c1620,
    r_i60_inq_comm_count12_i = NULL                                     => 0.0026907347,
                                                                           0.0026907347));

final_score_276_c1622 := __common__( map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d <= 27.5 => 0.0378663769,
    f_mos_acc_lseen_d > 27.5                               => -0.0280428291,
    f_mos_acc_lseen_d = NULL                               => -0.0202821566,
                                                              -0.0202821566));

final_score_276 := __common__( map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.1180828959 => final_score_276_c1619,
    f_add_curr_nhood_vac_pct_i > 0.1180828959                                        => final_score_276_c1622,
    f_add_curr_nhood_vac_pct_i = NULL                                                => -0.0054276365,
                                                                                        -0.0005488267));

final_score_277_c1626 := __common__( map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -2464 => -0.0637351506,
    f_addrchangeincomediff_d > -2464                                      => -0.0102686774,
    f_addrchangeincomediff_d = NULL                                       => -0.0255733906,
                                                                             -0.0159844450));

final_score_277_c1625 := __common__( map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 16 => 0.0281053670,
    r_f01_inp_addr_address_score_d > 16                                            => final_score_277_c1626,
    r_f01_inp_addr_address_score_d = NULL                                          => -0.0118052428,
                                                                                      -0.0118052428));

final_score_277_c1624 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.1573597595 => 0.0624868002,
    f_add_curr_nhood_mfd_pct_i > 0.1573597595                                        => final_score_277_c1625,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => -0.0312844184,
                                                                                        -0.0100087484));

final_score_277_c1627 := __common__( map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.0295040964 => 0.0257732930,
    f_add_curr_nhood_sfd_pct_d > 0.0295040964                                        => -0.0011728442,
    f_add_curr_nhood_sfd_pct_d = NULL                                                => -0.0002656584,
                                                                                        -0.0002656584));

final_score_277 := __common__( map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.0212577669 => final_score_277_c1624,
    f_add_input_nhood_sfd_pct_d > 0.0212577669                                         => final_score_277_c1627,
    f_add_input_nhood_sfd_pct_d = NULL                                                 => -0.0014764122,
                                                                                          -0.0014764122));

final_score_278_c1630 := __common__( map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.2889818905 => 0.0939682787,
    f_add_curr_mobility_index_i > 0.2889818905                                         => -0.0607274594,
    f_add_curr_mobility_index_i = NULL                                                 => 0.0443863114,
                                                                                          0.0443863114));

final_score_278_c1629 := __common__( map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d <= 0.5 => final_score_278_c1630,
    f_hh_age_18_plus_d > 0.5                                => -0.0001991609,
    f_hh_age_18_plus_d = NULL                               => 0.0000861076,
                                                               0.0000861076));

final_score_278_c1632 := __common__( map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 1.5 => 0.0704887611,
    r_s66_adlperssn_count_i > 1.5                                     => -0.0584052436,
    r_s66_adlperssn_count_i = NULL                                    => 0.0023236625,
                                                                         0.0023236625));

final_score_278_c1631 := __common__( map(
    NULL < k_comb_age_d AND k_comb_age_d <= 33.5 => -0.0798053197,
    k_comb_age_d > 33.5                          => final_score_278_c1632,
    k_comb_age_d = NULL                          => -0.0314120384,
                                                    -0.0314120384));

final_score_278 := __common__( map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 88.5 => final_score_278_c1629,
    f_phones_per_addr_curr_i > 88.5                                      => final_score_278_c1631,
    f_phones_per_addr_curr_i = NULL                                      => 0.0312099753,
                                                                            -0.0002821514));

final_score_279_c1635 := __common__( map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.9799104462 => -0.0174350617,
    f_add_curr_nhood_mfd_pct_i > 0.9799104462                                        => -0.0879405488,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => -0.0248510352,
                                                                                        -0.0248510352));

final_score_279_c1636 := __common__( map(
    NULL < f_inq_collection_count24_i AND f_inq_collection_count24_i <= 2.5 => 0.0026564049,
    f_inq_collection_count24_i > 2.5                                        => -0.0225559590,
    f_inq_collection_count24_i = NULL                                       => 0.0010827096,
                                                                               0.0010827096));

final_score_279_c1634 := __common__( map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 1.5 => final_score_279_c1635,
    f_addrs_per_ssn_i > 1.5                               => final_score_279_c1636,
    f_addrs_per_ssn_i = NULL                              => 0.0003162906,
                                                             0.0003162906));

final_score_279_c1637 := __common__( map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 4.5 => 0.0015811681,
    r_c14_addrs_5yr_i > 4.5                               => 0.0793359014,
    r_c14_addrs_5yr_i = NULL                              => 0.0061193821,
                                                             0.0061193821));

final_score_279 := __common__( map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.9975766703 => final_score_279_c1634,
    f_add_input_nhood_mfd_pct_i > 0.9975766703                                         => 0.0436967875,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => final_score_279_c1637,
                                                                                          0.0011252137));
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
    final_score_279;

base := 700;

pts := -50;

lgt := ln(0.1497871 / (1 - 0.1497871));

fp1610_1_0 := round(max((real)300, min(999, if(base + pts * (final_score - lgt) / ln(2) = NULL, -NULL, base + pts * (final_score - lgt) / ln(2)))));

stolenid := if(addrpop and (nas_summary in [4, 7, 9]) or fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9' or _deceased or _ssnpriortodob, 1, 0);

manipulatedid := if(_inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1), 1, 0);

manipulatedidpt2 := if(1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and (Integer)ssnlength = 9, 1, 0);

syntheticid := if(fnamepop and lnamepop and addrpop and ssnlength = '9' and hphnpop and nap_summary <= 4 and nas_summary <= 4 or _ver_src_cnt = 0 or _bureauonly or (Integer)add_curr_pop = 0, 1, 0);

suspiciousactivity := if(_derog, 1, 0);

vulnerablevictim := if(0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70, 1, 0);

friendlyfraud := if(hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2), 1, 0);

stolenc_fp1610_1_0 := if((Boolean)(Integer)stolenid, FP1610_1_0, 299);

manip2c_fp1610_1_0 := if((boolean)(integer)manipulatedid or (boolean)(integer)manipulatedidpt2, FP1610_1_0, 299);

synthc_fp1610_1_0 := if((Boolean)(Integer)syntheticid, FP1610_1_0, 299);

suspactc_fp1610_1_0 := if((Boolean)(Integer)suspiciousactivity, FP1610_1_0, 299);

vulnvicc_fp1610_1_0 := if((Boolean)(Integer)vulnerablevictim, FP1610_1_0, 299);

friendlyc_fp1610_1_0 := if((Boolean)(Integer)friendlyfraud, FP1610_1_0, 299);

custstolidindex := map(
    stolenc_fp1610_1_0 = 299                                => 1,
    300 <= stolenc_fp1610_1_0 AND stolenc_fp1610_1_0 <= 520 => 9,
    520 < stolenc_fp1610_1_0 AND stolenc_fp1610_1_0 <= 580  => 8,
    580 < stolenc_fp1610_1_0 AND stolenc_fp1610_1_0 <= 620  => 7,
    620 < stolenc_fp1610_1_0 AND stolenc_fp1610_1_0 <= 660  => 6,
    660 < stolenc_fp1610_1_0 AND stolenc_fp1610_1_0 <= 720  => 5,
    720 < stolenc_fp1610_1_0 AND stolenc_fp1610_1_0 <= 760  => 4,
    760 < stolenc_fp1610_1_0 AND stolenc_fp1610_1_0 <= 800  => 3,
    800 < stolenc_fp1610_1_0 AND stolenc_fp1610_1_0 <= 999  => 2,
                                                               99);

custmanipidindex := map(
    manip2c_fp1610_1_0 = 299                                => 1,
    300 <= manip2c_fp1610_1_0 AND manip2c_fp1610_1_0 <= 520 => 9,
    520 < manip2c_fp1610_1_0 AND manip2c_fp1610_1_0 <= 580  => 8,
    580 < manip2c_fp1610_1_0 AND manip2c_fp1610_1_0 <= 620  => 7,
    620 < manip2c_fp1610_1_0 AND manip2c_fp1610_1_0 <= 660  => 6,
    660 < manip2c_fp1610_1_0 AND manip2c_fp1610_1_0 <= 700  => 5,
    700 < manip2c_fp1610_1_0 AND manip2c_fp1610_1_0 <= 740  => 4,
    740 < manip2c_fp1610_1_0 AND manip2c_fp1610_1_0 <= 780  => 3,
    780 < manip2c_fp1610_1_0 AND manip2c_fp1610_1_0 <= 999  => 2,
                                                               99);

custsynthidindex := map(
    synthc_fp1610_1_0 = 299                               => 1,
    300 <= synthc_fp1610_1_0 AND synthc_fp1610_1_0 <= 520 => 9,
    520 < synthc_fp1610_1_0 AND synthc_fp1610_1_0 <= 560  => 8,
    560 < synthc_fp1610_1_0 AND synthc_fp1610_1_0 <= 620  => 7,
    620 < synthc_fp1610_1_0 AND synthc_fp1610_1_0 <= 660  => 6,
    660 < synthc_fp1610_1_0 AND synthc_fp1610_1_0 <= 700  => 5,
    700 < synthc_fp1610_1_0 AND synthc_fp1610_1_0 <= 740  => 4,
    740 < synthc_fp1610_1_0 AND synthc_fp1610_1_0 <= 780  => 3,
    780 < synthc_fp1610_1_0 AND synthc_fp1610_1_0 <= 999  => 2,
                                                             99);

custsuspactindex := map(
    suspactc_fp1610_1_0 = 299                                 => 1,
    300 <= suspactc_fp1610_1_0 AND suspactc_fp1610_1_0 <= 540 => 9,
    540 < suspactc_fp1610_1_0 AND suspactc_fp1610_1_0 <= 600  => 8,
    600 < suspactc_fp1610_1_0 AND suspactc_fp1610_1_0 <= 640  => 7,
    640 < suspactc_fp1610_1_0 AND suspactc_fp1610_1_0 <= 680  => 6,
    680 < suspactc_fp1610_1_0 AND suspactc_fp1610_1_0 <= 720  => 5,
    720 < suspactc_fp1610_1_0 AND suspactc_fp1610_1_0 <= 760  => 4,
    760 < suspactc_fp1610_1_0 AND suspactc_fp1610_1_0 <= 800  => 3,
    800 < suspactc_fp1610_1_0 AND suspactc_fp1610_1_0 <= 999  => 2,
                                                                 99);

custvulnvicindex := map(
    vulnvicc_fp1610_1_0 = 299                                 => 1,
    300 <= vulnvicc_fp1610_1_0 AND vulnvicc_fp1610_1_0 <= 540 => 9,
    540 < vulnvicc_fp1610_1_0 AND vulnvicc_fp1610_1_0 <= 600  => 8,
    600 < vulnvicc_fp1610_1_0 AND vulnvicc_fp1610_1_0 <= 640  => 7,
    640 < vulnvicc_fp1610_1_0 AND vulnvicc_fp1610_1_0 <= 680  => 6,
    680 < vulnvicc_fp1610_1_0 AND vulnvicc_fp1610_1_0 <= 720  => 5,
    720 < vulnvicc_fp1610_1_0 AND vulnvicc_fp1610_1_0 <= 740  => 4,
    740 < vulnvicc_fp1610_1_0 AND vulnvicc_fp1610_1_0 <= 760  => 3,
    760 < vulnvicc_fp1610_1_0 AND vulnvicc_fp1610_1_0 <= 999  => 2,
                                                                 99);

custfriendfrdindex := map(
    friendlyc_fp1610_1_0 = 299                                  => 1,
    300 <= friendlyc_fp1610_1_0 AND friendlyc_fp1610_1_0 <= 540 => 9,
    540 < friendlyc_fp1610_1_0 AND friendlyc_fp1610_1_0 <= 580  => 8,
    580 < friendlyc_fp1610_1_0 AND friendlyc_fp1610_1_0 <= 620  => 7,
    620 < friendlyc_fp1610_1_0 AND friendlyc_fp1610_1_0 <= 660  => 6,
    660 < friendlyc_fp1610_1_0 AND friendlyc_fp1610_1_0 <= 700  => 5,
    700 < friendlyc_fp1610_1_0 AND friendlyc_fp1610_1_0 <= 740  => 4,
    740 < friendlyc_fp1610_1_0 AND friendlyc_fp1610_1_0 <= 780  => 3,
    780 < friendlyc_fp1610_1_0 AND friendlyc_fp1610_1_0 <= 999  => 2,
                                                                   99);



//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(FP_DEBUG)
		/* Model Input Variables */
		//self.seq	 														:= le.seq;
   self.sysdate                          := sysdate;
	 self.disposition                      := disposition;
   self.k_nap_phn_verd_d                 := k_nap_phn_verd_d;
   self.k_nap_fname_verd_d               := k_nap_fname_verd_d;
   self.k_inf_phn_verd_d                 := k_inf_phn_verd_d;
   self.k_inf_fname_verd_d               := k_inf_fname_verd_d;
   self.k_inf_contradictory_i            := k_inf_contradictory_i;
   self.r_c16_inv_ssn_per_adl_i          := r_c16_inv_ssn_per_adl_i;
   self.r_p88_phn_dst_to_inp_add_i       := r_p88_phn_dst_to_inp_add_i;
   self.r_p85_phn_not_issued_i           := r_p85_phn_not_issued_i;
   self.r_p85_phn_disconnected_i         := r_p85_phn_disconnected_i;
   self.r_phn_cell_n                     := r_phn_cell_n;
   self.r_p86_phn_pager_i                := r_p86_phn_pager_i;
   self.r_phn_pcs_n                      := r_phn_pcs_n;
   self.r_l75_add_drop_delivery_i        := r_l75_add_drop_delivery_i;
   self.add_ec1                          := add_ec1;
   self.add_ec3                          := add_ec3;
   self.add_ec4                          := add_ec4;
   self.r_l70_add_standardized_i         := r_l70_add_standardized_i;
   self.r_l72_add_curr_vacant_i          := r_l72_add_curr_vacant_i;
   self.r_f03_input_add_not_most_rec_i   := r_f03_input_add_not_most_rec_i;
   self.r_c19_add_prison_hist_i          := r_c19_add_prison_hist_i;
   self.r_f00_ssn_score_d                := r_f00_ssn_score_d;
   self.r_f01_inp_addr_address_score_d   := r_f01_inp_addr_address_score_d;
   self.r_d30_derog_count_i              := r_d30_derog_count_i;
   self.r_d32_criminal_count_i           := r_d32_criminal_count_i;
   self.r_d32_felony_count_i             := r_d32_felony_count_i;
   self._criminal_last_date              := _criminal_last_date;
   self.r_d32_mos_since_crim_ls_d        := r_d32_mos_since_crim_ls_d;
   self._felony_last_date                := _felony_last_date;
   self.r_d32_mos_since_fel_ls_d         := r_d32_mos_since_fel_ls_d;
   self.r_d31_mostrec_bk_i               := r_d31_mostrec_bk_i;
   self.r_d33_eviction_recency_d         := r_d33_eviction_recency_d;
   self.r_d34_unrel_liens_ct_i           := r_d34_unrel_liens_ct_i;
   self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
   self.r_c21_m_bureau_adl_fs_d          := r_c21_m_bureau_adl_fs_d;
   self._src_bureau_adl_fseen_all        := _src_bureau_adl_fseen_all;
   self.f_m_bureau_adl_fs_all_d          := f_m_bureau_adl_fs_all_d;
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
   self._src_bureau_adl_fseen_notu       := _src_bureau_adl_fseen_notu;
   self.f_m_bureau_adl_fs_notu_d         := f_m_bureau_adl_fs_notu_d;
   self._header_first_seen               := _header_first_seen;
   self.r_c10_m_hdr_fs_d                 := r_c10_m_hdr_fs_d;
   self.r_c12_nonderog_recency_i         := r_c12_nonderog_recency_i;
   self.r_c12_num_nonderogs_d            := r_c12_num_nonderogs_d;
   self.r_c15_ssns_per_adl_i             := r_c15_ssns_per_adl_i;
   self.r_s66_adlperssn_count_i          := r_s66_adlperssn_count_i;
   self._in_dob                          := _in_dob;
   self.yr_in_dob                        := yr_in_dob;
   self.yr_in_dob_int                    := yr_in_dob_int;
   self.k_comb_age_d                     := k_comb_age_d;
   self.r_l80_inp_avm_autoval_d          := r_l80_inp_avm_autoval_d;
   self.r_a46_curr_avm_autoval_d         := r_a46_curr_avm_autoval_d;
   self.r_a49_curr_avm_chg_1yr_i         := r_a49_curr_avm_chg_1yr_i;
   self.r_a49_curr_avm_chg_1yr_pct_i     := r_a49_curr_avm_chg_1yr_pct_i;
   self.r_c13_curr_addr_lres_d           := r_c13_curr_addr_lres_d;
   self.r_c14_addr_stability_v2_d        := r_c14_addr_stability_v2_d;
   self.r_c13_max_lres_d                 := r_c13_max_lres_d;
   self.r_c14_addrs_5yr_i                := r_c14_addrs_5yr_i;
   self.r_c14_addrs_10yr_i               := r_c14_addrs_10yr_i;
   self.r_c14_addrs_15yr_i               := r_c14_addrs_15yr_i;
   self.r_prop_owner_history_d           := r_prop_owner_history_d;
   self.r_c20_email_count_i              := r_c20_email_count_i;
   self.r_l79_adls_per_addr_curr_i       := r_l79_adls_per_addr_curr_i;
   self.r_l79_adls_per_addr_c6_i         := r_l79_adls_per_addr_c6_i;
   self.r_c18_invalid_addrs_per_adl_i    := r_c18_invalid_addrs_per_adl_i;
   self.r_a50_pb_average_dollars_d       := r_a50_pb_average_dollars_d;
   self.r_a50_pb_total_dollars_d         := r_a50_pb_total_dollars_d;
   self.r_a50_pb_total_orders_d          := r_a50_pb_total_orders_d;
   self.r_pb_order_freq_d                := r_pb_order_freq_d;
   self.r_i60_inq_count12_i              := r_i60_inq_count12_i;
   self.r_i60_inq_recency_d              := r_i60_inq_recency_d;
   self.r_i61_inq_collection_count12_i   := r_i61_inq_collection_count12_i;
   self.r_i61_inq_collection_recency_d   := r_i61_inq_collection_recency_d;
   self.r_i60_inq_auto_count12_i         := r_i60_inq_auto_count12_i;
   self.r_i60_inq_auto_recency_d         := r_i60_inq_auto_recency_d;
   self.r_i60_inq_hiriskcred_recency_d   := r_i60_inq_hiriskcred_recency_d;
   self.r_i60_inq_comm_count12_i         := r_i60_inq_comm_count12_i;
   self.r_i60_inq_comm_recency_d         := r_i60_inq_comm_recency_d;
   self.f_bus_addr_match_count_d         := f_bus_addr_match_count_d;
   self.f_adl_util_conv_n                := f_adl_util_conv_n;
   self.f_util_adl_count_n               := f_util_adl_count_n;
   self.f_util_add_curr_inf_n            := f_util_add_curr_inf_n;
   self.f_add_input_mobility_index_i     := f_add_input_mobility_index_i;
   self.f_add_input_nhood_bus_pct_i      := f_add_input_nhood_bus_pct_i;
   self.f_add_input_nhood_mfd_pct_i      := f_add_input_nhood_mfd_pct_i;
   self.f_add_input_nhood_sfd_pct_d      := f_add_input_nhood_sfd_pct_d;
   self.add_input_nhood_prop_sum         := add_input_nhood_prop_sum;
   self.f_add_input_nhood_vac_pct_i      := f_add_input_nhood_vac_pct_i;
   self.f_add_curr_mobility_index_i      := f_add_curr_mobility_index_i;
   self.f_add_curr_nhood_bus_pct_i       := f_add_curr_nhood_bus_pct_i;
   self.f_add_curr_nhood_mfd_pct_i       := f_add_curr_nhood_mfd_pct_i;
   self.f_add_curr_nhood_sfd_pct_d       := f_add_curr_nhood_sfd_pct_d;
   self.add_curr_nhood_prop_sum          := add_curr_nhood_prop_sum;
   self.f_add_curr_nhood_vac_pct_i       := f_add_curr_nhood_vac_pct_i;
   self.f_inq_count24_i                  := f_inq_count24_i;
   self.f_inq_auto_count24_i             := f_inq_auto_count24_i;
   self.f_inq_collection_count24_i       := f_inq_collection_count24_i;
   self.f_inq_communications_count24_i   := f_inq_communications_count24_i;
   self.f_inq_highriskcredit_count24_i   := f_inq_highriskcredit_count24_i;
   self.f_inq_other_count24_i            := f_inq_other_count24_i;
   self.k_inq_per_ssn_i                  := k_inq_per_ssn_i;
   self.k_inq_addrs_per_ssn_i            := k_inq_addrs_per_ssn_i;
   self.k_inq_dobs_per_ssn_i             := k_inq_dobs_per_ssn_i;
   self.k_inq_per_addr_i                 := k_inq_per_addr_i;
   self.k_inq_adls_per_addr_i            := k_inq_adls_per_addr_i;
   self.k_inq_lnames_per_addr_i          := k_inq_lnames_per_addr_i;
   self.k_inq_ssns_per_addr_i            := k_inq_ssns_per_addr_i;
   self.k_inq_per_phone_i                := k_inq_per_phone_i;
   self.k_inq_adls_per_phone_i           := k_inq_adls_per_phone_i;
   self.f_attr_arrest_recency_d          := f_attr_arrest_recency_d;
   self._liens_unrel_cj_first_seen       := _liens_unrel_cj_first_seen;
   self.f_mos_liens_unrel_cj_fseen_d     := f_mos_liens_unrel_cj_fseen_d;
   self._liens_unrel_cj_last_seen        := _liens_unrel_cj_last_seen;
   self.f_mos_liens_unrel_cj_lseen_d     := f_mos_liens_unrel_cj_lseen_d;
   self.f_liens_unrel_cj_total_amt_i     := f_liens_unrel_cj_total_amt_i;
   self._liens_rel_cj_first_seen         := _liens_rel_cj_first_seen;
   self.f_mos_liens_rel_cj_fseen_d       := f_mos_liens_rel_cj_fseen_d;
   self._liens_rel_cj_last_seen          := _liens_rel_cj_last_seen;
   self.f_mos_liens_rel_cj_lseen_d       := f_mos_liens_rel_cj_lseen_d;
   self.f_liens_rel_cj_total_amt_i       := f_liens_rel_cj_total_amt_i;
   self._liens_unrel_o_first_seen        := _liens_unrel_o_first_seen;
   self.f_mos_liens_unrel_o_fseen_d      := f_mos_liens_unrel_o_fseen_d;
   self._liens_unrel_o_last_seen         := _liens_unrel_o_last_seen;
   self.f_mos_liens_unrel_o_lseen_d      := f_mos_liens_unrel_o_lseen_d;
   self._liens_rel_o_first_seen          := _liens_rel_o_first_seen;
   self.f_mos_liens_rel_o_fseen_d        := f_mos_liens_rel_o_fseen_d;
   self._liens_rel_o_last_seen           := _liens_rel_o_last_seen;
   self.f_mos_liens_rel_o_lseen_d        := f_mos_liens_rel_o_lseen_d;
   self._liens_rel_ot_first_seen         := _liens_rel_ot_first_seen;
   self.f_mos_liens_rel_ot_fseen_d       := f_mos_liens_rel_ot_fseen_d;
   self._liens_rel_ot_last_seen          := _liens_rel_ot_last_seen;
   self.f_mos_liens_rel_ot_lseen_d       := f_mos_liens_rel_ot_lseen_d;
   self.f_liens_unrel_sc_total_amt_i     := f_liens_unrel_sc_total_amt_i;
   self.k_estimated_income_d             := k_estimated_income_d;
   self.r_wealth_index_d                 := r_wealth_index_d;
   self.f_rel_count_i                    := f_rel_count_i;
   self.f_rel_incomeover25_count_d       := f_rel_incomeover25_count_d;
   self.f_rel_incomeover50_count_d       := f_rel_incomeover50_count_d;
   self.f_rel_incomeover75_count_d       := f_rel_incomeover75_count_d;
   self.f_rel_incomeover100_count_d      := f_rel_incomeover100_count_d;
   self.f_rel_homeover50_count_d         := f_rel_homeover50_count_d;
   self.f_rel_homeover100_count_d        := f_rel_homeover100_count_d;
   self.f_rel_homeover150_count_d        := f_rel_homeover150_count_d;
   self.f_rel_homeover200_count_d        := f_rel_homeover200_count_d;
   self.f_rel_homeover300_count_d        := f_rel_homeover300_count_d;
   self.f_rel_homeover500_count_d        := f_rel_homeover500_count_d;
   self.f_rel_ageover20_count_d          := f_rel_ageover20_count_d;
   self.f_rel_ageover30_count_d          := f_rel_ageover30_count_d;
   self.f_rel_ageover40_count_d          := f_rel_ageover40_count_d;
   self.f_rel_ageover50_count_d          := f_rel_ageover50_count_d;
   self.f_rel_educationover8_count_d     := f_rel_educationover8_count_d;
   self.f_rel_educationover12_count_d    := f_rel_educationover12_count_d;
   self.f_crim_rel_under25miles_cnt_i    := f_crim_rel_under25miles_cnt_i;
   self.f_crim_rel_under100miles_cnt_i   := f_crim_rel_under100miles_cnt_i;
   self.f_rel_under25miles_cnt_d         := f_rel_under25miles_cnt_d;
   self.f_rel_under100miles_cnt_d        := f_rel_under100miles_cnt_d;
   self.f_rel_under500miles_cnt_d        := f_rel_under500miles_cnt_d;
   self.f_rel_bankrupt_count_i           := f_rel_bankrupt_count_i;
   self.f_rel_criminal_count_i           := f_rel_criminal_count_i;
   self.f_rel_felony_count_i             := f_rel_felony_count_i;
   self.f_current_count_d                := f_current_count_d;
   self.f_historical_count_d             := f_historical_count_d;
   self._acc_last_seen                   := _acc_last_seen;
   self.f_mos_acc_lseen_d                := f_mos_acc_lseen_d;
   self.f_idrisktype_i                   := f_idrisktype_i;
   self.f_idverrisktype_i                := f_idverrisktype_i;
   self.f_sourcerisktype_i               := f_sourcerisktype_i;
   self.f_varrisktype_i                  := f_varrisktype_i;
   self.f_srchvelocityrisktype_i         := f_srchvelocityrisktype_i;
   self.f_srchcountwk_i                  := f_srchcountwk_i;
   self.f_srchunvrfdssncount_i           := f_srchunvrfdssncount_i;
   self.f_srchunvrfdaddrcount_i          := f_srchunvrfdaddrcount_i;
   self.f_srchunvrfddobcount_i           := f_srchunvrfddobcount_i;
   self.f_srchunvrfdphonecount_i         := f_srchunvrfdphonecount_i;
   self.f_srchfraudsrchcountyr_i         := f_srchfraudsrchcountyr_i;
   self.f_assocrisktype_i                := f_assocrisktype_i;
   self.f_assocsuspicousidcount_i        := f_assocsuspicousidcount_i;
   self.f_validationrisktype_i           := f_validationrisktype_i;
   self.f_corrrisktype_i                 := f_corrrisktype_i;
   self.f_corrssnnamecount_d             := f_corrssnnamecount_d;
   self.f_corrssnaddrcount_d             := f_corrssnaddrcount_d;
   self.f_corraddrphonecount_d           := f_corraddrphonecount_d;
   self.f_corrphonelastnamecount_d       := f_corrphonelastnamecount_d;
   self.f_divrisktype_i                  := f_divrisktype_i;
   self.f_divssnidmsrcurelcount_i        := f_divssnidmsrcurelcount_i;
   self.f_divaddrsuspidcountnew_i        := f_divaddrsuspidcountnew_i;
   self.f_srchcomponentrisktype_i        := f_srchcomponentrisktype_i;
   self.f_srchssnsrchcountmo_i           := f_srchssnsrchcountmo_i;
   self.f_srchaddrsrchcountmo_i          := f_srchaddrsrchcountmo_i;
   self.f_srchaddrsrchcountwk_i          := f_srchaddrsrchcountwk_i;
   self.f_srchphonesrchcountmo_i         := f_srchphonesrchcountmo_i;
   self.f_srchphonesrchcountwk_i         := f_srchphonesrchcountwk_i;
   self.f_addrchangeincomediff_d         := f_addrchangeincomediff_d;
   self.f_addrchangevaluediff_d          := f_addrchangevaluediff_d;
   self.f_addrchangecrimediff_i          := f_addrchangecrimediff_i;
   self.f_addrchangeecontrajindex_d      := f_addrchangeecontrajindex_d;
   self.f_curraddractivephonelist_d      := f_curraddractivephonelist_d;
   self.f_curraddrmedianincome_d         := f_curraddrmedianincome_d;
   self.f_curraddrmedianvalue_d          := f_curraddrmedianvalue_d;
   self.f_curraddrmurderindex_i          := f_curraddrmurderindex_i;
   self.f_curraddrcartheftindex_i        := f_curraddrcartheftindex_i;
   self.f_curraddrburglaryindex_i        := f_curraddrburglaryindex_i;
   self.f_curraddrcrimeindex_i           := f_curraddrcrimeindex_i;
   self.f_prevaddrageoldest_d            := f_prevaddrageoldest_d;
   self.f_prevaddrlenofres_d             := f_prevaddrlenofres_d;
   self.f_prevaddroccupantowned_i        := f_prevaddroccupantowned_i;
   self.f_prevaddrmedianincome_d         := f_prevaddrmedianincome_d;
   self.f_prevaddrmedianvalue_d          := f_prevaddrmedianvalue_d;
   self.f_prevaddrmurderindex_i          := f_prevaddrmurderindex_i;
   self.f_prevaddrcartheftindex_i        := f_prevaddrcartheftindex_i;
   self.f_fp_prevaddrburglaryindex_i     := f_fp_prevaddrburglaryindex_i;
   self.f_fp_prevaddrcrimeindex_i        := f_fp_prevaddrcrimeindex_i;
   self.r_c12_source_profile_d           := r_c12_source_profile_d;
   self.r_f01_inp_addr_not_verified_i    := r_f01_inp_addr_not_verified_i;
   self.r_c23_inp_addr_occ_index_d       := r_c23_inp_addr_occ_index_d;
   self.r_i60_inq_prepaidcards_recency_d := r_i60_inq_prepaidcards_recency_d;
   self.f_phone_ver_insurance_d          := f_phone_ver_insurance_d;
   self.f_phone_ver_experian_d           := f_phone_ver_experian_d;
   self.f_addrs_per_ssn_i                := f_addrs_per_ssn_i;
   self.f_phones_per_addr_curr_i         := f_phones_per_addr_curr_i;
   self.f_addrs_per_ssn_c6_i             := f_addrs_per_ssn_c6_i;
   self.f_phones_per_addr_c6_i           := f_phones_per_addr_c6_i;
   self.f_inq_communications_cnt_week_i  := f_inq_communications_cnt_week_i;
   self.f_inq_prepaidcards_count24_i     := f_inq_prepaidcards_count24_i;
   self._liens_unrel_st_first_seen       := _liens_unrel_st_first_seen;
   self.f_mos_liens_unrel_st_fseen_d     := f_mos_liens_unrel_st_fseen_d;
   self.f_liens_unrel_st_total_amt_i     := f_liens_unrel_st_total_amt_i;
   self.f_hh_members_ct_d                := f_hh_members_ct_d;
   self.f_hh_age_65_plus_d               := f_hh_age_65_plus_d;
   self.f_hh_age_18_plus_d               := f_hh_age_18_plus_d;
   self.f_hh_collections_ct_i            := f_hh_collections_ct_i;
   self.f_hh_payday_loan_users_i         := f_hh_payday_loan_users_i;
   self.f_hh_members_w_derog_i           := f_hh_members_w_derog_i;
   self.f_hh_tot_derog_i                 := f_hh_tot_derog_i;
   self.f_hh_lienholders_i               := f_hh_lienholders_i;
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
   self.nf_seg_fraudpoint_3_0            := nf_seg_fraudpoint_3_0;
   self.r_nas_ssn_verd_d                 := r_nas_ssn_verd_d;
   self.r_l70_add_invalid_i              := r_l70_add_invalid_i;
   self.r_d31_attr_bankruptcy_recency_d  := r_d31_attr_bankruptcy_recency_d;
   self.r_d34_unrel_lien60_count_i       := r_d34_unrel_lien60_count_i;
   self.r_a41_prop_owner_d               := r_a41_prop_owner_d;
   self.r_l78_no_phone_at_addr_vel_i     := r_l78_no_phone_at_addr_vel_i;
   self.r_i60_inq_retail_recency_d       := r_i60_inq_retail_recency_d;
   self.f_bus_fname_verd_d               := f_bus_fname_verd_d;
   self.f_adl_util_misc_n                := f_adl_util_misc_n;
   self.f_add_curr_has_vac_ct_i          := f_add_curr_has_vac_ct_i;
   self._liens_unrel_ft_first_seen       := _liens_unrel_ft_first_seen;
   self.f_mos_liens_unrel_ft_fseen_d     := f_mos_liens_unrel_ft_fseen_d;
   self.f_acc_damage_amt_total_i         := f_acc_damage_amt_total_i;
   self.f_vardobcount_i                  := f_vardobcount_i;
   self.f_srchcountday_i                 := f_srchcountday_i;
   self.f_srchfraudsrchcountwk_i         := f_srchfraudsrchcountwk_i;
   self.f_assoccredbureaucount_i         := f_assoccredbureaucount_i;
   self.f_srchssnsrchcountday_i          := f_srchssnsrchcountday_i;
   self.f_inputaddractivephonelist_d     := f_inputaddractivephonelist_d;
   self.f_prevaddrdwelltype_sfd_n        := f_prevaddrdwelltype_sfd_n;
   self.f_prevaddrstatus_i               := f_prevaddrstatus_i;
   self.r_c12_source_profile_index_d     := r_c12_source_profile_index_d;
   self.f_dl_addrs_per_adl_i             := f_dl_addrs_per_adl_i;
   self.f_inq_auto_count_week_i          := f_inq_auto_count_week_i;
   self.f_liens_rel_sc_total_amt_i       := f_liens_rel_sc_total_amt_i;
   self.f_hh_college_attendees_d         := f_hh_college_attendees_d;
   self.r_d31_bk_chapter_n               := r_d31_bk_chapter_n;
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
   self.final_score                      := final_score;
   self.base                             := base;
   self.pts                              := pts;
   self.lgt                              := lgt;
   self.fp1610_1_0                       := fp1610_1_0;
   self.stolenid                         := stolenid;
   self.manipulatedid                    := manipulatedid;
   self.manipulatedidpt2                 := manipulatedidpt2;
   self.syntheticid                      := syntheticid;
   self.suspiciousactivity               := suspiciousactivity;
   self.vulnerablevictim                 := vulnerablevictim;
   self.friendlyfraud                    := friendlyfraud;
   self.stolenc_fp1610_1_0               := stolenc_fp1610_1_0;
   self.manip2c_fp1610_1_0               := manip2c_fp1610_1_0;
   self.synthc_fp1610_1_0                := synthc_fp1610_1_0;
   self.suspactc_fp1610_1_0              := suspactc_fp1610_1_0;
   self.vulnvicc_fp1610_1_0              := vulnvicc_fp1610_1_0;
   self.friendlyc_fp1610_1_0             := friendlyc_fp1610_1_0;
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
	reasons := Models.Common.checkFraudPointRC34(FP1610_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)FP1610_1_0;
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
