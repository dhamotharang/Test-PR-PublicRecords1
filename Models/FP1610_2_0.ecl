import Std, risk_indicators, riskwise, riskwisefcra, ut, easi, Models;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1610_2_0(dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons)
									 := FUNCTION
									
		FP_DEBUG := false;
		
		isFCRA := False;

	#if(FP_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	
	Integer seq;
	Integer	sysdate;
	Integer	k_nap_phn_verd_d;
	Boolean k_nap_contradictory_i;
	Integer	k_inf_phn_verd_d;
	Integer k_inf_lname_verd_d;
	Boolean	k_inf_contradictory_i;
	
	Integer r_s65_ssn_invalid_i;
	Integer	r_c16_inv_ssn_per_adl_i;
	Integer r_s65_ssn_problem_i;
	Integer	r_p88_phn_dst_to_inp_add_i;
	Integer	r_p85_phn_not_issued_i;
	Real	r_p85_phn_disconnected_i;
	Integer r_p85_phn_invalid_i;
	Integer	r_phn_cell_n;
	Integer	r_p86_phn_pager_i;
	Integer	r_phn_pcs_n;
	Real r_l72_add_vacant_i;
	Real r_l71_add_business_i;
	Real	r_l70_add_standardized_i;
	Real	r_l72_add_curr_vacant_i;
	Real r_l71_add_curr_business_i;
	Real	r_f03_input_add_not_most_rec_i;
	Integer	r_c19_add_prison_hist_i;
	Integer r_l77_apartment_i;
	Integer	r_f00_ssn_score_d;
	Real	r_f01_inp_addr_address_score_d;
	Real	r_d30_derog_count_i;
	Real	r_d32_criminal_count_i;
	Real	r_d32_felony_count_i;
	Real	r_d32_mos_since_crim_ls_d;
	Real	r_d32_mos_since_fel_ls_d;
	integer	r_d31_mostrec_bk_i;
	Real r_d31_attr_bankruptcy_recency_d;
	Integer	r_d33_eviction_recency_d;
	Integer r_d33_eviction_count_i;
	Real	r_d34_unrel_liens_ct_i;
	Real	r_c21_m_bureau_adl_fs_d;
	Real	f_m_bureau_adl_fs_all_d;
	Real f_m_bureau_adl_fs_notu_d;
	Real r_c10_m_hdr_fs_d;
	Real	r_c15_ssns_per_adl_i;
	Real	r_s66_adlperssn_count_i;
	Real	k_comb_age_d;
	Real r_f03_address_match_d;
	Real r_a44_curr_add_naprop_d;
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
	Real	r_l79_adls_per_addr_curr_i;
	Real	r_l79_adls_per_addr_c6_i;
	Real	r_c18_invalid_addrs_per_adl_i;
	Real r_l78_no_phone_at_addr_vel_i;
	Real r_i60_inq_count12_i;
	Real	r_i60_inq_recency_d;
	Real	r_i61_inq_collection_recency_d;
	Real	r_i60_inq_auto_count12_i;
	Real	r_i60_inq_auto_recency_d;
	Real r_i60_inq_banking_recency_d;
	Real	r_i60_inq_hiriskcred_recency_d;
	Real	r_i60_inq_comm_count12_i;
	Real	r_i60_inq_comm_recency_d;
	
	Real	f_bus_addr_match_count_d;
	
	Real	f_util_adl_count_n;
	Real f_util_add_input_conv_n;
	Real	f_util_add_curr_inf_n;
	Real f_util_add_curr_conv_n;
	
	Real	f_add_input_mobility_index_i;
	Real	f_add_input_nhood_bus_pct_i;
	Real	f_add_input_nhood_mfd_pct_i;
	Real	f_add_input_nhood_sfd_pct_d;
	Real	f_add_input_nhood_vac_pct_i;
	
	Real	f_add_curr_mobility_index_i;
	Real	f_add_curr_nhood_bus_pct_i;
	Real	f_add_curr_nhood_mfd_pct_i;
	Real	f_add_curr_nhood_sfd_pct_d;
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
	
	Real f_attr_arrests_i;
	Real	f_attr_arrest_recency_d;
	
	Real	f_mos_liens_unrel_cj_fseen_d;
	Real	f_mos_liens_unrel_cj_lseen_d;
	Real	f_liens_unrel_cj_total_amt_i;
	Real	f_mos_liens_rel_cj_fseen_d;
	Real	f_mos_liens_rel_cj_lseen_d;
	Real	f_liens_rel_cj_total_amt_i;
	Real f_mos_liens_unrel_lt_lseen_d;
	Real	f_mos_liens_unrel_o_fseen_d;
	Real f_liens_unrel_ot_total_amt_i;
	Real	f_mos_liens_rel_ot_fseen_d;
	Real f_mos_liens_unrel_sc_fseen_d;
	
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
	Real	f_rel_ageover20_count_d;
	Real	f_rel_ageover30_count_d;
	Real	f_rel_ageover40_count_d;
	Real	f_rel_ageover50_count_d;
	Real f_rel_ageover70_count_d;
	Real	f_rel_educationover8_count_d;
	Real	f_rel_educationover12_count_d;
	
	Real	f_crim_rel_under25miles_cnt_i;
	Real	f_crim_rel_under100miles_cnt_i;
	Real f_crim_rel_under500miles_cnt_i;
	Real	f_rel_under25miles_cnt_d;
	Real	f_rel_under100miles_cnt_d;
	Real	f_rel_under500miles_cnt_d;
	Real	f_rel_bankrupt_count_i;
	Real	f_rel_criminal_count_i;
	Real	f_rel_felony_count_i;
	Real	f_current_count_d;
	Real	f_historical_count_d;
	
	Real f_accident_count_i;
	Real f_acc_damage_amt_total_i;
	Real	f_mos_acc_lseen_d;
	Real f_accident_recency_d;
	
	Real	f_idverrisktype_i;
	Real	f_sourcerisktype_i;
	Real	f_varrisktype_i;
	Real f_vardobcountnew_i;
	
	Real	f_srchvelocityrisktype_i;
	Real	f_srchcountwk_i;
	Real	f_srchunvrfdssncount_i;
	Real	f_srchunvrfdaddrcount_i;
	Real	f_srchunvrfddobcount_i;
	Real	f_srchunvrfdphonecount_i;
	Real	f_srchfraudsrchcountyr_i;
  Real f_srchfraudsrchcountmo_i;
	Real f_srchlocatesrchcountwk_i;
	
	Real	f_assocsuspicousidcount_i;
	Real	f_validationrisktype_i;
	
	Real	f_divrisktype_i;
	Real	f_divssnidmsrcurelcount_i;
	Real	f_divaddrsuspidcountnew_i;
	Real f_divsrchaddrsuspidcount_i;
	
	Real	f_srchcomponentrisktype_i;
	Real	f_srchssnsrchcountmo_i;
	Real f_srchssnsrchcountday_i;
	Real	f_srchaddrsrchcountmo_i;
	Real	f_srchaddrsrchcountwk_i;
	Real	f_srchphonesrchcountmo_i;
	
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
	Real	f_prevaddrmedianincome_d;
	Real	f_prevaddrmedianvalue_d;
	Real	f_prevaddrmurderindex_i;
	Real	f_prevaddrcartheftindex_i;
	Real	f_fp_prevaddrburglaryindex_i;
	Real	f_fp_prevaddrcrimeindex_i;
	
	Real r_d31_all_bk_i;
	String r_d31_bk_chapter_n;
	Real r_d31_bk_dism_recent_count_i;
	Real	r_c12_source_profile_d;
	Real	r_f01_inp_addr_not_verified_i;
	Real	r_c23_inp_addr_occ_index_d;
	Real r_f04_curr_add_occ_index_d;
	Real r_e57_br_source_count_d;
	Real r_i60_inq_prepaidcards_count12_i;
	Real	r_i60_inq_prepaidcards_recency_d;
	Real r_i60_inq_retpymt_count12_i;
	Real r_i60_inq_util_recency_d;
	
	Real	f_phone_ver_insurance_d;
	Real	f_phone_ver_experian_d;
	Real	f_addrs_per_ssn_i;
	Real	f_phones_per_addr_curr_i;
	Real	f_addrs_per_ssn_c6_i;
	Real	f_phones_per_addr_c6_i;
	Real f_adls_per_phone_c6_i;
	
	Real f_inq_highriskcredit_cnt_day_i;
  Real	f_inq_prepaidcards_count24_i;
	Real f_inq_retailpayments_count24_i;
	
	Real f_mos_liens_rel_sc_lseen_d;
	Real	f_liens_rel_sc_total_amt_i;
	Real	f_mos_liens_unrel_st_fseen_d;
	Real	f_mos_liens_unrel_st_lseen_d;
	Real	f_mos_liens_rel_st_fseen_d;
	Real	f_mos_liens_rel_st_lseen_d;
	
	Real	f_hh_members_ct_d;
	Real	f_hh_age_65_plus_d;
	Real f_hh_age_30_plus_d;
	Real	f_hh_age_18_plus_d;
	Real	f_hh_collections_ct_i;
	Real f_hh_workers_paw_d;
	Real	f_hh_payday_loan_users_i;
	Real	f_hh_tot_derog_i;
	Real f_hh_bankruptcies_i;
	Real	f_hh_lienholders_i;
	Real f_hh_criminals_i;
	
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
	
  Real	final_score_tree_0;
	Real	final_score_tree_1;
	Real	final_score_tree_2;
	Real	final_score_tree_3;
	Real	final_score_tree_4;
	Real	final_score_tree_5;
	Real	final_score_tree_6;
	Real	final_score_tree_7;
	Real	final_score_tree_8;
	Real	final_score_tree_9;
	Real	final_score_tree_10;
	Real	final_score_tree_11;
	Real	final_score_tree_12;
	Real	final_score_tree_13;
	Real	final_score_tree_14;
	Real	final_score_tree_15;
	Real	final_score_tree_16;
	Real	final_score_tree_17;
	Real	final_score_tree_18;
	Real	final_score_tree_19;
	Real	final_score_tree_20;
	Real	final_score_tree_21;
	Real	final_score_tree_22;
	Real	final_score_tree_23;
	Real	final_score_tree_24;
	Real	final_score_tree_25;
	Real	final_score_tree_26;
	Real	final_score_tree_27;
	Real	final_score_tree_28;
	Real	final_score_tree_29;
	Real	final_score_tree_30;
	Real	final_score_tree_31;
	Real	final_score_tree_32;
	Real	final_score_tree_33;
	Real	final_score_tree_34;
	Real	final_score_tree_35;
	Real	final_score_tree_36;
	Real	final_score_tree_37;
	Real	final_score_tree_38;
	Real	final_score_tree_39;
	Real	final_score_tree_40;
	Real	final_score_tree_41;
	Real	final_score_tree_42;
	Real	final_score_tree_43;
	Real	final_score_tree_44;
	Real	final_score_tree_45;
	Real	final_score_tree_46;
	Real	final_score_tree_47;
	Real	final_score_tree_48;
	Real	final_score_tree_49;
	Real	final_score_tree_50;
	Real	final_score_tree_51;
	Real	final_score_tree_52;
	Real	final_score_tree_53;
	Real	final_score_tree_54;
	Real	final_score_tree_55;
	Real	final_score_tree_56;
	Real	final_score_tree_57;
	Real	final_score_tree_58;
	Real	final_score_tree_59;
	Real	final_score_tree_60;
	Real	final_score_tree_61;
	Real	final_score_tree_62;
	Real	final_score_tree_63;
	Real	final_score_tree_64;
	Real	final_score_tree_65;
	Real	final_score_tree_66;
	Real	final_score_tree_67;
	Real	final_score_tree_68;
	Real	final_score_tree_69;
	Real	final_score_tree_70;
	Real	final_score_tree_71;
	Real	final_score_tree_72;
	Real	final_score_tree_73;
	Real	final_score_tree_74;
	Real	final_score_tree_75;
	Real	final_score_tree_76;
	Real	final_score_tree_77;
	Real	final_score_tree_78;
	Real	final_score_tree_79;
	Real	final_score_tree_80;
	Real	final_score_tree_81;
	Real	final_score_tree_82;
	Real	final_score_tree_83;
	Real	final_score_tree_84;
	Real	final_score_tree_85;
	Real	final_score_tree_86;
	Real	final_score_tree_87;
	Real	final_score_tree_88;
	Real	final_score_tree_89;
	Real	final_score_tree_90;
	Real	final_score_tree_91;
	Real	final_score_tree_92;
	Real	final_score_tree_93;
	Real	final_score_tree_94;
	Real	final_score_tree_95;
	Real	final_score_tree_96;
	Real	final_score_tree_97;
	Real	final_score_tree_98;
	Real	final_score_tree_99;
	Real	final_score_tree_100;
	Real	final_score_tree_101;
	Real	final_score_tree_102;
	Real	final_score_tree_103;
	Real	final_score_tree_104;
	Real	final_score_tree_105;
	Real	final_score_tree_106;
	Real	final_score_tree_107;
	Real	final_score_tree_108;
	Real	final_score_tree_109;
	Real	final_score_tree_110;
	Real	final_score_tree_111;
	Real	final_score_tree_112;
	Real	final_score_tree_113;
	Real	final_score_tree_114;
	Real	final_score_tree_115;
	Real	final_score_tree_116;
	Real	final_score_tree_117;
	Real	final_score_tree_118;
	Real	final_score_tree_119;
	Real	final_score_tree_120;
	Real	final_score_tree_121;
	Real	final_score_tree_122;
	Real	final_score_tree_123;
	Real	final_score_tree_124;
	Real	final_score_tree_125;
	Real	final_score_tree_126;
	Real	final_score_tree_127;
	Real	final_score_tree_128;
	Real	final_score_tree_129;
	Real	final_score_tree_130;
	Real	final_score_tree_131;
	Real	final_score_tree_132;
	Real	final_score_tree_133;
	Real	final_score_tree_134;
	Real	final_score_tree_135;
	Real	final_score_tree_136;
	Real	final_score_tree_137;
	Real	final_score_tree_138;
	Real	final_score_tree_139;
	Real	final_score_tree_140;
	Real	final_score_tree_141;
	Real	final_score_tree_142;
	Real	final_score_tree_143;
	Real	final_score_tree_144;
	Real	final_score_tree_145;
	Real	final_score_tree_146;
	Real	final_score_tree_147;
	Real	final_score_tree_148;
	Real	final_score_tree_149;
	Real	final_score_tree_150;
	Real	final_score_tree_151;
	Real	final_score_tree_152;
	Real	final_score_tree_153;
	Real	final_score_tree_154;
	Real	final_score_tree_155;
	Real	final_score_tree_156;
	Real	final_score_tree_157;
	Real	final_score_tree_158;
	Real	final_score_tree_159;
	Real	final_score_tree_160;
	Real	final_score_tree_161;
	Real	final_score_tree_162;
	Real	final_score_tree_163;
	Real	final_score_tree_164;
	Real	final_score_tree_165;
	Real	final_score_tree_166;
	Real	final_score_tree_167;
	Real	final_score_tree_168;
	Real	final_score_tree_169;
	Real	final_score_tree_170;
	Real	final_score_tree_171;
	Real	final_score_tree_172;
	Real	final_score_tree_173;
	Real	final_score_tree_174;
	Real	final_score_tree_175;
	Real	final_score_tree_176;
	Real	final_score_tree_177;
	Real	final_score_tree_178;
	Real	final_score_tree_179;
	Real	final_score_tree_180;
	Real	final_score_tree_181;
	Real	final_score_tree_182;
	Real	final_score_tree_183;
	Real	final_score_tree_184;
	Real	final_score_tree_185;
	Real	final_score_tree_186;
	Real	final_score_tree_187;
	Real	final_score_tree_188;
	Real	final_score_tree_189;
	Real	final_score_tree_190;
	Real	final_score_tree_191;
	Real	final_score_tree_192;
	Real	final_score_tree_193;
	Real	final_score_tree_194;
	Real	final_score_tree_195;
	Real	final_score_tree_196;
	Real	final_score_tree_197;
	Real	final_score_tree_198;
	Real	final_score_tree_199;
	Real	final_score_tree_200;
	Real	final_score_tree_201;
	Real	final_score_tree_202;
	Real	final_score_tree_203;
	Real	final_score_tree_204;
	Real	final_score_tree_205;
	Real	final_score_tree_206;
	Real	final_score_tree_207;
	Real	final_score_tree_208;
	Real	final_score_tree_209;
	Real	final_score_tree_210;
	Real	final_score_tree_211;
	Real	final_score_tree_212;
	Real	final_score_tree_213;
	Real	final_score_tree_214;
	Real	final_score_tree_215;
	Real	final_score_tree_216;
	Real	final_score_tree_217;
	Real	final_score_tree_218;
	Real	final_score_tree_219;
	Real	final_score_tree_220;
	Real	final_score_tree_221;
	Real	final_score_tree_222;
	Real	final_score_tree_223;
	Real	final_score_tree_224;
	Real	final_score_tree_225;
	Real	final_score_tree_226;
	Real	final_score_tree_227;
	Real	final_score_tree_228;
	Real	final_score_tree_229;
	Real	final_score_tree_230;
	Real	final_score_tree_231;
	Real	final_score_tree_232;
	Real	final_score_tree_233;
	Real	final_score_tree_234;
	Real	final_score_tree_235;
	Real	final_score_tree_236;
	Real	final_score_tree_237;
	Real	final_score_tree_238;
	Real	final_score_tree_239;
	Real	final_score_tree_240;
	Real	final_score_tree_241;
	
	Real final_score_gbm_logit;
	
	Integer	base;
	Integer	pts;
	Real	lgt;
	
	Integer	fp1610_2_0;
	
	Integer stolenid;
  Integer manipulatedid;
  Integer manipulatedidpt2;
  Integer syntheticid;
  Integer suspiciousactivity;
  Integer vulnerablevictim;
  Integer friendlyfraud;
	
  Integer stolenc_fp1610_2_0;
  Integer manip2c_fp1610_2_0;
  Integer synthc_fp1610_2_0;
  Integer suspactc_fp1610_2_0;
  Integer vulnvicc_fp1610_2_0;
  Integer friendlyc_fp1610_2_0;
	
  Integer custstolidindex;
  Integer custmanipidindex;
  Integer custsynthidindex;
  Integer custsuspactindex;
  Integer custvulnvicindex;
  Integer custfriendfrdindex;
	

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
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
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
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_pwphonezipflag                := le.iid.pwphonezipflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnvalflag                    := le.iid.socsvalflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
	rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
	rc_disthphoneaddr                := le.iid.disthphoneaddr;
	rc_phonetype                     := le.iid.phonetype;
	combo_ssnscore                   := le.iid.combo_ssnscore;
	hdr_source_profile               := le.source_profile;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	bus_addr_match_count             := le.business_header_address_summary.bus_addr_match_cnt;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	util_adl_count                   := le.utility.utili_adl_count;
	util_add_input_type_list         := le.utility.utili_addr1_type;
	util_add_curr_type_list          := le.utility.utili_addr2_type;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_addr_not_verified      := le.address_verification.inputAddr_not_verified;
	add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
	add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind;
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
	add_curr_isbestmatch             := le.address_verification.address_history_1.isbestmatch;
	add_curr_lres                    := le.lres2;
	add_curr_occ_index               := le.address_verification.currAddr_occupancy_index;
	add_curr_advo_vacancy            := le.advo_addr_hist1.Address_Vacancy_Indicator;
	add_curr_advo_res_or_bus         := le.advo_addr_hist1.Residential_or_Business_Ind;
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
	adls_per_phone_c6                := if(isFCRA, 0, le.velocity_counters.adls_per_phone_created_6months );
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
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_communications_count01       := le.acc_logs.communications.count01;
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_communications_count06       := le.acc_logs.communications.count06;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_communications_count24       := le.acc_logs.communications.count24;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count_day     := if(isFCRA, 0, le.acc_logs.highriskcredit.countday);
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
	inq_retailpayments_count12       := le.acc_logs.retailpayments.count12;
	inq_retailpayments_count24       := le.acc_logs.retailpayments.count24;
	inq_utilities_count              := le.acc_logs.utilities.counttotal;
	inq_utilities_count01            := le.acc_logs.utilities.count01;
	inq_utilities_count03            := le.acc_logs.utilities.count03;
	inq_utilities_count06            := le.acc_logs.utilities.count06;
	inq_utilities_count12            := le.acc_logs.utilities.count12;
	inq_utilities_count24            := le.acc_logs.utilities.count24;
	inq_perssn                       := if(isFCRA, 0, le.acc_logs.inquiryPerSSN );
	inq_addrsperssn                  := if(isFCRA, 0, le.acc_logs.inquiryAddrsPerSSN );
	inq_dobsperssn                   := if(isFCRA, 0, le.acc_logs.inquiryDOBsPerSSN );
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
	fp_idverrisktype                 := le.fdattributesv2.idverrisklevel;
	fp_sourcerisktype                := le.fdattributesv2.sourcerisklevel;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_vardobcountnew                := le.fdattributesv2.variationdobcountnew;
	fp_srchvelocityrisktype          := le.fdattributesv2.searchvelocityrisklevel;
	fp_srchcountwk                   := le.fdattributesv2.searchcountweek;
	fp_srchunvrfdssncount            := le.fdattributesv2.searchunverifiedssncountyear;
	fp_srchunvrfdaddrcount           := le.fdattributesv2.searchunverifiedaddrcountyear;
	fp_srchunvrfddobcount            := le.fdattributesv2.searchunverifieddobcountyear;
	fp_srchunvrfdphonecount          := le.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcountyr          := le.fdattributesv2.searchfraudsearchcountyear;
	fp_srchfraudsrchcountmo          := le.fdattributesv2.searchfraudsearchcountmonth;
	fp_srchlocatesrchcountwk         := le.fdattributesv2.searchlocatesearchcountweek;
	fp_assocsuspicousidcount         := le.fdattributesv2.assocsuspicousidentitiescount;
	fp_validationrisktype            := le.fdattributesv2.validationrisklevel;
	fp_divrisktype                   := le.fdattributesv2.divrisklevel;
	fp_divssnidmsrcurelcount         := le.fdattributesv2.divssnidentitymsourceurelcount;
	fp_divaddrsuspidcountnew         := le.fdattributesv2.divaddrsuspidentitycountnew;
	fp_divsrchaddrsuspidcount        := le.fdattributesv2.divsearchaddrsuspidentitycount;
	fp_srchcomponentrisktype         := le.fdattributesv2.searchcomponentrisklevel;
	fp_srchssnsrchcountmo            := le.fdattributesv2.searchssnsearchcountmonth;
	fp_srchssnsrchcountday           := le.fdattributesv2.searchssnsearchcountday;
	fp_srchaddrsrchcountmo           := le.fdattributesv2.searchaddrsearchcountmonth;
	fp_srchaddrsrchcountwk           := le.fdattributesv2.searchaddrsearchcountweek;
	fp_srchphonesrchcountmo          := le.fdattributesv2.searchphonesearchcountmonth;
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
	fp_prevaddrmedianincome          := le.fdattributesv2.prevaddrmedianincome;
	fp_prevaddrmedianvalue           := le.fdattributesv2.prevaddrmedianvalue;
	fp_prevaddrmurderindex           := le.fdattributesv2.prevaddrmurderindex;
	fp_prevaddrcartheftindex         := le.fdattributesv2.prevaddrcartheftindex;
	fp_prevaddrburglaryindex         := le.fdattributesv2.prevaddrburglaryindex;
	fp_prevaddrcrimeindex            := le.fdattributesv2.prevaddrcrimeindex;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_dismissed_recent_count        := le.bjl.bk_dismissed_recent_count;
	bk_dismissed_historical_count    := le.bjl.bk_dismissed_historical_count;
	bk_chapter                       := le.bjl.bk_chapter;
	bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
	bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_unrel_cj_first_seen        := le.liens.liens_unreleased_civil_judgment.earliest_filing_date;
	liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	liens_unrel_cj_total_amount      := le.liens.liens_unreleased_civil_judgment.total_amount;
	liens_rel_cj_first_seen          := le.liens.liens_released_civil_judgment.earliest_filing_date;
	liens_rel_cj_last_seen           := le.liens.liens_released_civil_judgment.most_recent_filing_date;
	liens_rel_cj_total_amount        := le.liens.liens_released_civil_judgment.total_amount;
	liens_unrel_lt_last_seen         := le.liens.liens_unreleased_landlord_tenant.most_recent_filing_date;
	liens_unrel_o_first_seen         := le.liens.liens_unreleased_other_lj.earliest_filing_date;
	liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
	liens_rel_ot_first_seen          := le.liens.liens_released_other_tax.earliest_filing_date;
	liens_unrel_sc_first_seen        := le.liens.liens_unreleased_small_claims.earliest_filing_date;
	liens_rel_sc_last_seen           := le.liens.liens_released_small_claims.most_recent_filing_date;
	liens_rel_sc_total_amount        := le.liens.liens_released_small_claims.total_amount;
	liens_unrel_st_first_seen        := le.liens.liens_unreleased_suits.earliest_filing_date;
	liens_unrel_st_last_seen         := le.liens.liens_unreleased_suits.most_recent_filing_date;
	liens_rel_st_first_seen          := le.liens.liens_released_suits.earliest_filing_date;
	liens_rel_st_last_seen           := le.liens.liens_released_suits.most_recent_filing_date;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_count                     := le.bjl.felony_count;
	felony_last_date                 := le.bjl.last_felony_date;
	hh_members_ct                    := le.hhid_summary.hh_members_ct;
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
	hh_criminals                     := le.hhid_summary.hh_criminals;
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
	wealth_index                     := le.wealth_indicator;
	inferred_age                     := le.inferred_age;
	addr_stability_v2                := le.addr_stability;
	estimated_income                 := le.estimated_income;



	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */


NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

sysdate := common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01'));

k_nap_phn_verd_d := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

k_nap_contradictory_i := (nap_summary in [1]);

k_inf_phn_verd_d := (infutor_nap in [4, 6, 7, 9, 10, 11, 12]);

k_inf_lname_verd_d := (infutor_nap in [2, 5, 7, 8, 9, 11, 12]);

k_inf_contradictory_i := (infutor_nap in [1]);

r_s65_ssn_invalid_i := map(
    not((integer)ssnlength > 0)                                                                          => NULL,
    rc_ssnvalflag = '1' or (rc_pwssnvalflag in ['1', '2', '3']) or (inputssncharflag in ['1', '2', '3']) => 1,
    rc_ssnvalflag = '0' or (rc_pwssnvalflag in ['0', '4', '5']) or (inputssncharflag in ['0', '4', '5']) => 0,
                                                                                                          NULL);

r_c16_inv_ssn_per_adl_i := if(not(truedid), NULL, min(if(invalid_ssns_per_adl = NULL, -NULL, invalid_ssns_per_adl), 999));

r_s65_ssn_problem_i := map(
    not((integer)ssnlength > 0)
	      => NULL,
    (dobpop and (rc_ssndobflag = '1' or rc_pwssndobflag = '1')) 
		  or (truedid and invalid_ssns_per_adl >= 2) 
			or (truedid and invalid_ssns_per_adl_c6 >= 1)
	      => 2,
    rc_decsflag = '1' or contains_i(ver_sources, 'DE') > 0 
		  or contains_i(ver_sources, 'DS') > 0 or rc_ssnvalflag = '1' 
			or (rc_pwssnvalflag in ['1', '2', '3']) or (inputssncharflag in ['1', '2', '3']) 
			or (truedid and invalid_ssns_per_adl >= 1)                          
			  => 1,
    rc_decsflag = '0' 
		  or (dobpop and (rc_ssndobflag = '0' or rc_pwssndobflag = '0')) 
			or rc_ssnvalflag = '0' 
			or (rc_pwssnvalflag in ['0', '4', '5']) or (inputssncharflag in ['0', '4', '5']) 
			or (truedid and invalid_ssns_per_adl = 0) 
			or (truedid and invalid_ssns_per_adl_c6 = 0) 
			  => 0,
    NULL);

r_p88_phn_dst_to_inp_add_i := if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr);

r_p85_phn_not_issued_i := map(
    not(hphnpop)                 => NULL,
    (rc_pwphonezipflag in ['4']) => 1,
                                    0);

r_p85_phn_disconnected_i := map(
    not(hphnpop)                                                               => NULL,
    rc_hriskphoneflag = '5' or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D' => 1,
                                                                                0);

r_p85_phn_invalid_i := map(
    not(hphnpop)                                                          => NULL,
    rc_phonevalflag = '0' or rc_hphonevalflag = '0' or rc_phonetype = '5' => 1,
                                                                             0);

r_phn_cell_n_1 := if(not(hphnpop), NULL, NULL);

r_phn_cell_n := if(rc_hriskphoneflag = '1' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '1' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '04' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '55' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '60', 1, 0);

r_p86_phn_pager_i := map(
    not(hphnpop)                                                                                                                                                                                                                                            => NULL,
    rc_hriskphoneflag = '2' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '2' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '02' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '56' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '61' => 1,
                                                                                                                                                                                                                                                               0);

r_phn_pcs_n := map(
    not(hphnpop)                                                                                                                                                                                                                                                                                                                                                            => NULL,
    rc_hriskphoneflag = '3' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '3' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '64' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '65' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '66' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '67' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '68' => 1,
                                                                                                                                                                                                                                                                                                                                                                               0);

r_l72_add_vacant_i := map(
    not(add_input_pop)                                          => NULL,
    trim(trim(add_input_advo_vacancy, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                   0);

r_l71_add_business_i := map(
    not(add_input_pop)                                                       => NULL,
    (trim(trim(add_input_advo_res_or_bus, LEFT), LEFT, RIGHT) in ['B', 'D']) => 1,
                                                                                0);

add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];

add_ec3 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3];

add_ec4 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4];

r_l70_add_standardized_i := map(
    not(addrpop)                                         => NULL,
    trim(trim(add_ec1, LEFT), LEFT, RIGHT) = 'E'         => 2,
    add_ec1 = 'S' and (add_ec3 != '0' or add_ec4 != '0') => 1,
                                                            0);

r_l72_add_curr_vacant_i := map(
    not(add_curr_pop)                                          => NULL,
    trim(trim(add_curr_advo_vacancy, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                  0);

r_l71_add_curr_business_i := map(
    not(add_curr_pop)                                                       => NULL,
    (trim(trim(add_curr_advo_res_or_bus, LEFT), LEFT, RIGHT) in ['B', 'D']) => 1,
                                                                               0);

r_f03_input_add_not_most_rec_i := if(not(truedid and add_input_pop), NULL, (integer)rc_input_addr_not_most_recent);

r_c19_add_prison_hist_i := if(not(truedid), NULL, (integer)addrs_prison_history);

r_l77_apartment_i := map(
    not(addrpop) 
		    => NULL,
    StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' 
		  or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' 
			or not(out_unit_desig = '') or not(out_sec_range = '') 
			  => 1,
    0);

r_f00_ssn_score_d := if(not(truedid and (integer)ssnlength > 0) or combo_ssnscore = 255, NULL, min(if(combo_ssnscore = NULL, -NULL, combo_ssnscore), 999));

r_f01_inp_addr_address_score_d := if(not(truedid and add_input_pop) or add_input_address_score = 255, NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));

r_d30_derog_count_i := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));

r_d32_criminal_count_i := if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999));

r_d32_felony_count_i := if(not(truedid), NULL, min(if(felony_count = NULL, -NULL, felony_count), 999));

_criminal_last_date := common.sas_date((string)(criminal_last_date));

r_d32_mos_since_crim_ls_d := map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => 241,
                                  max(3, min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240)));

_felony_last_date := common.sas_date((string)(felony_last_date));

r_d32_mos_since_fel_ls_d := map(
    not(truedid)             => NULL,
    _felony_last_date = NULL => 241,
                                max(3, min(if(if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12)))), 240)));

r_d31_mostrec_bk_i := map(
    not(truedid)                                    => NULL,
    contains_i(Stringlib.stringtouppercase(disposition), 'DISMISS') = 1  => 1,
    contains_i(Stringlib.stringtouppercase(disposition), 'DISCHARG') = 1 => 2,
    (integer)bankrupt = 1 or (integer)filing_count > 0                => 3,
                                                       0);

r_d31_attr_bankruptcy_recency_d := map(
    not(truedid)             => NULL,
    (boolean)attr_bankruptcy_count30  => 1,
    (boolean)attr_bankruptcy_count90  => 3,
    (boolean)attr_bankruptcy_count180 => 6,
    (boolean)attr_bankruptcy_count12  => 12,
    (boolean)attr_bankruptcy_count24  => 24,
    (boolean)attr_bankruptcy_count36  => 36,
    (boolean)attr_bankruptcy_count60  => 60,
    bankrupt                 => 99,
    filing_count > 0         => 99,
                                0);

r_d33_eviction_recency_d := map(
    not(truedid)             => NULL,
    (boolean)attr_eviction_count90    => 3,
    (boolean)attr_eviction_count180   => 6,
    (boolean)attr_eviction_count12    => 12,
    (boolean)attr_eviction_count24    => 24,
    (boolean)attr_eviction_count36    => 36,
    (boolean)attr_eviction_count60    => 60,
    attr_eviction_count >= 1 => 99,
                                999);

r_d33_eviction_count_i := if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999));

r_d34_unrel_liens_ct_i := if(not(truedid), NULL, min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 999));

bureau_adl_eq_fseen_pos_2 := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq_2 := if(bureau_adl_eq_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_2, ','));

_bureau_adl_fseen_eq_2 := common.sas_date((string)(bureau_adl_fseen_eq_2));

_src_bureau_adl_fseen := min(if(_bureau_adl_fseen_eq_2 = NULL, -NULL, _bureau_adl_fseen_eq_2), 999999);

r_c21_m_bureau_adl_fs_d := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => 1000,
                                      min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999));

bureau_adl_eq_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq_1 := if(bureau_adl_eq_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_1, ','));

_bureau_adl_fseen_eq_1 := common.sas_date((string)(bureau_adl_fseen_eq_1));

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

_src_bureau_adl_fseen_all := min(if(_bureau_adl_fseen_tn_1 = NULL, -NULL, _bureau_adl_fseen_tn_1), if(_bureau_adl_fseen_ts_1 = NULL, -NULL, _bureau_adl_fseen_ts_1), if(_bureau_adl_fseen_tu_1 = NULL, -NULL, _bureau_adl_fseen_tu_1), if(_bureau_adl_fseen_en_1 = NULL, -NULL, _bureau_adl_fseen_en_1), if(_bureau_adl_fseen_eq_1 = NULL, -NULL, _bureau_adl_fseen_eq_1), 999999);

f_m_bureau_adl_fs_all_d := map(
    not(truedid)                       => NULL,
    _src_bureau_adl_fseen_all = 999999 => 1000,
                                          min(if(if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)))), 999));

bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

_bureau_adl_fseen_eq := common.sas_date((string)(bureau_adl_fseen_eq));

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

_src_bureau_adl_fseen_notu := min(if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

f_m_bureau_adl_fs_notu_d := map(
    not(truedid)                        => NULL,
    _src_bureau_adl_fseen_notu = 999999 => 1000,
                                           min(if(if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)))), 999));

_header_first_seen := common.sas_date((string)(header_first_seen));

r_c10_m_hdr_fs_d := map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => 1000,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));

r_c15_ssns_per_adl_i := map(
    not(truedid)             => NULL,
    ssns_per_adl = 0         => 2,
    (ssns_per_adl in [1, 2]) => 1,
                                min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 999));

r_s66_adlperssn_count_i := map(
    not((integer)ssnlength > 0) => NULL,
    adls_per_ssn = 0   => 1,
                          min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999));

_in_dob := common.sas_date((string)(in_dob));

yr_in_dob := if(_in_dob = NULL, NULL, (sysdate - _in_dob) / 365.25);

yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

k_comb_age_d := map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                                    NULL);

r_f03_address_match_d := map(
    not(truedid)                                => NULL,
    add_input_isbestmatch                       => 4,
    not(add_input_pop) and add_curr_isbestmatch => 3,
    add_input_pop and add_curr_isbestmatch      => 2,
    add_curr_pop                                => 1,
    add_input_pop                               => 0,
                                                   NULL);

r_a44_curr_add_naprop_d := if(not(truedid and add_curr_pop), NULL, add_curr_naprop);

r_l80_inp_avm_autoval_d := map(
    not(add_input_pop)         => NULL,
    add_input_avm_auto_val = 0 => NULL,
                                  min(if(add_input_avm_auto_val = NULL, -NULL, add_input_avm_auto_val), 300000));

r_a46_curr_avm_autoval_d := map(
    not(add_curr_pop)         => NULL,
    add_curr_avm_auto_val = 0 => NULL,
                                 min(if(add_curr_avm_auto_val = NULL, -NULL, add_curr_avm_auto_val), 300000));

r_a49_curr_avm_chg_1yr_i := map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => add_curr_avm_auto_val - add_curr_avm_auto_val_2,
                                                                 NULL);

r_a49_curr_avm_chg_1yr_pct_i := map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2/0.1)*0.1,
                                                                 NULL);

r_c13_curr_addr_lres_d := if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999));

r_c14_addr_stability_v2_d := map(
    not(truedid)          => NULL,
    addr_stability_v2 = '0' => NULL,
                             (integer)addr_stability_v2);

r_c13_max_lres_d := if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999));

r_c14_addrs_5yr_i := if(not(truedid), NULL, min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));

r_c14_addrs_10yr_i := if(not(truedid), NULL, min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));

r_c14_addrs_15yr_i := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));

r_prop_owner_history_d := map(
    not(truedid)                                                                     => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 2,
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 1,
                                                                                        0);

r_l79_adls_per_addr_curr_i := if(not(add_curr_pop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

r_l79_adls_per_addr_c6_i := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));

r_c18_invalid_addrs_per_adl_i := if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999));

r_l78_no_phone_at_addr_vel_i := map(
    not(addrpop)             => NULL,
    phones_per_addr_curr = 0 => 1,
                                0);

r_i60_inq_count12_i := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));

r_i60_inq_recency_d := map(
    not(truedid) => NULL,
    (boolean)inq_count01  => 1,
    (boolean)inq_count03  => 3,
    (boolean)inq_count06  => 6,
    (boolean)inq_count12  => 12,
    (boolean)inq_count24  => 24,
    (boolean)inq_count    => 99,
                    999);

r_i61_inq_collection_recency_d := map(
    not(truedid)           => NULL,
    (boolean)inq_collection_count01 => 1,
    (boolean)inq_collection_count03 => 3,
    (boolean)inq_collection_count06 => 6,
    (boolean)inq_collection_count12 => 12,
    (boolean)inq_collection_count24 => 24,
    (boolean)inq_collection_count   => 99,
                              999);

r_i60_inq_auto_count12_i := if(not(truedid), NULL, min(if(inq_auto_count12 = NULL, -NULL, inq_auto_count12), 999));

r_i60_inq_auto_recency_d := map(
    not(truedid)     => NULL,
    (boolean)inq_auto_count01 => 1,
    (boolean)inq_auto_count03 => 3,
    (boolean)inq_auto_count06 => 6,
    (boolean)inq_auto_count12 => 12,
    (boolean)inq_auto_count24 => 24,
    (boolean)inq_auto_count   => 99,
                        999);

r_i60_inq_banking_recency_d := map(
    not(truedid)        => NULL,
    (boolean)inq_banking_count01 => 1,
    (boolean)inq_banking_count03 => 3,
    (boolean)inq_banking_count06 => 6,
    (boolean)inq_banking_count12 => 12,
    (boolean)inq_banking_count24 => 24,
    (boolean)inq_banking_count   => 99,
                           999);

r_i60_inq_hiriskcred_recency_d := map(
    not(truedid)               => NULL,
    (boolean)inq_highRiskCredit_count01 => 1,
    (boolean)inq_highRiskCredit_count03 => 3,
    (boolean)inq_highRiskCredit_count06 => 6,
    (boolean)inq_highRiskCredit_count12 => 12,
    (boolean)inq_highRiskCredit_count24 => 24,
    (boolean)inq_highRiskCredit_count   => 99,
                                  999);

r_i60_inq_comm_count12_i := if(not(truedid), NULL, min(if(inq_communications_count12 = NULL, -NULL, inq_communications_count12), 999));

r_i60_inq_comm_recency_d := map(
    not(truedid)               => NULL,
    (boolean)inq_communications_count01 => 1,
    (boolean)inq_communications_count03 => 3,
    (boolean)inq_communications_count06 => 6,
    (boolean)inq_communications_count12 => 12,
    (boolean)inq_communications_count24 => 24,
    (boolean)inq_communications_count   => 99,
                                  999);

f_bus_addr_match_count_d := if(not(addrpop), NULL, bus_addr_match_count);

f_util_adl_count_n := if(not(truedid), NULL, util_adl_count);

f_util_add_input_conv_n := if(contains_i(util_add_input_type_list, '2') > 0, 1, 0);

f_util_add_curr_inf_n := if(contains_i(util_add_curr_type_list, '1') > 0, 1, 0);

f_util_add_curr_conv_n := if(contains_i(util_add_curr_type_list, '2') > 0, 1, 0);

f_add_input_mobility_index_i := map(
    not(addrpop)                 => NULL,
    add_input_occupants_1yr <= 0 => NULL,
                                    if(max(add_input_turnover_1yr_in, add_input_turnover_1yr_out) = NULL, NULL, sum(if(add_input_turnover_1yr_in = NULL, 0, add_input_turnover_1yr_in), if(add_input_turnover_1yr_out = NULL, 0, add_input_turnover_1yr_out))) / add_input_occupants_1yr);

add_input_nhood_prop_sum_3 := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));

f_add_input_nhood_bus_pct_i := map(
    not(addrpop)               => NULL,
    add_input_nhood_BUS_ct = 0 => NULL,
                                  add_input_nhood_BUS_ct / add_input_nhood_prop_sum_3);

add_input_nhood_prop_sum_2 := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));

f_add_input_nhood_mfd_pct_i := map(
    not(addrpop)               => NULL,
    add_input_nhood_MFD_ct = 0 => NULL,
                                  add_input_nhood_MFD_ct / add_input_nhood_prop_sum_2);

add_input_nhood_prop_sum_1 := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));

f_add_input_nhood_sfd_pct_d := map(
    not(addrpop)               => NULL,
    add_input_nhood_SFD_ct = 0 => -1,
                                  add_input_nhood_SFD_ct / add_input_nhood_prop_sum_1);

add_input_nhood_prop_sum := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));

f_add_input_nhood_vac_pct_i := map(
    not(addrpop)                 => NULL,
    add_input_nhood_prop_sum = 0 => -1,
                                    add_input_nhood_VAC_prop / add_input_nhood_prop_sum);

f_add_curr_mobility_index_i := map(
    not(add_curr_pop)           => NULL,
    add_curr_occupants_1yr <= 0 => NULL,
                                   if(max(add_curr_turnover_1yr_in, add_curr_turnover_1yr_out) = NULL, NULL, sum(if(add_curr_turnover_1yr_in = NULL, 0, add_curr_turnover_1yr_in), if(add_curr_turnover_1yr_out = NULL, 0, add_curr_turnover_1yr_out))) / add_curr_occupants_1yr);

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

f_inq_auto_count24_i := if(not(truedid), NULL, min(if(inq_Auto_count24 = NULL, -NULL, inq_Auto_count24), 999));

f_inq_collection_count24_i := if(not(truedid), NULL, min(if(inq_Collection_count24 = NULL, -NULL, inq_Collection_count24), 999));

f_inq_communications_count24_i := if(not(truedid), NULL, min(if(inq_Communications_count24 = NULL, -NULL, inq_Communications_count24), 999));

f_inq_highriskcredit_count24_i := if(not(truedid), NULL, min(if(inq_HighRiskCredit_count24 = NULL, -NULL, inq_HighRiskCredit_count24), 999));

f_inq_other_count24_i := if(not(truedid), NULL, min(if(inq_Other_count24 = NULL, -NULL, inq_Other_count24), 999));

k_inq_per_ssn_i := if(not((integer)ssnlength > 0), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999));

k_inq_addrs_per_ssn_i := if(not((integer)ssnlength > 0), NULL, min(if(inq_addrsperssn = NULL, -NULL, inq_addrsperssn), 999));

k_inq_dobs_per_ssn_i := if(not((integer)ssnlength > 0), NULL, min(if(inq_dobsperssn = NULL, -NULL, inq_dobsperssn), 999));

k_inq_per_addr_i := if(not(addrpop), NULL, min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999));

k_inq_adls_per_addr_i := if(not(addrpop), NULL, min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999));

k_inq_lnames_per_addr_i := if(not(addrpop), NULL, min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999));

k_inq_ssns_per_addr_i := if(not(addrpop), NULL, min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999));

k_inq_per_phone_i := if(not(hphnpop), NULL, min(if(inq_perphone = NULL, -NULL, inq_perphone), 999));

k_inq_adls_per_phone_i := if(not(hphnpop), NULL, min(if(inq_adlsperphone = NULL, -NULL, inq_adlsperphone), 999));

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

_liens_unrel_cj_first_seen := common.sas_date((string)(liens_unrel_CJ_first_seen));

f_mos_liens_unrel_cj_fseen_d := map(
    not(truedid)                      => NULL,
    _liens_unrel_cj_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)))), 999));

_liens_unrel_cj_last_seen := common.sas_date((string)(liens_unrel_CJ_last_seen));

f_mos_liens_unrel_cj_lseen_d := map(
    not(truedid)                     => NULL,
    _liens_unrel_cj_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)))), 999)));

f_liens_unrel_cj_total_amt_i := if(not(truedid), NULL, liens_unrel_CJ_total_amount);

_liens_rel_cj_first_seen := common.sas_date((string)(liens_rel_CJ_first_seen));

f_mos_liens_rel_cj_fseen_d := map(
    not(truedid)                    => NULL,
    _liens_rel_cj_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)))), 999));

_liens_rel_cj_last_seen := common.sas_date((string)(liens_rel_CJ_last_seen));

f_mos_liens_rel_cj_lseen_d := map(
    not(truedid)                   => NULL,
    _liens_rel_cj_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)))), 999)));

f_liens_rel_cj_total_amt_i := if(not(truedid), NULL, liens_rel_CJ_total_amount);

_liens_unrel_lt_last_seen := common.sas_date((string)(liens_unrel_LT_last_seen));

f_mos_liens_unrel_lt_lseen_d := map(
    not(truedid)                     => NULL,
    _liens_unrel_lt_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12)))), 999)));

_liens_unrel_o_first_seen := common.sas_date((string)(liens_unrel_O_first_seen));

f_mos_liens_unrel_o_fseen_d := map(
    not(truedid)                     => NULL,
    _liens_unrel_o_first_seen = NULL => 1000,
                                        min(if(if ((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12)))), 999));

f_liens_unrel_ot_total_amt_i := if(not(truedid), NULL, liens_unrel_OT_total_amount);

_liens_rel_ot_first_seen := common.sas_date((string)(liens_rel_OT_first_seen));

f_mos_liens_rel_ot_fseen_d := map(
    not(truedid)                    => NULL,
    _liens_rel_ot_first_seen = NULL => -1,
                                       min(if(if ((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)))), 999));

_liens_unrel_sc_first_seen := common.sas_date((string)(liens_unrel_SC_first_seen));

f_mos_liens_unrel_sc_fseen_d := map(
    not(truedid)                      => NULL,
    _liens_unrel_sc_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)))), 999));

k_estimated_income_d := if(not(truedid), NULL, estimated_income);

r_wealth_index_d := if(not(truedid), NULL, (integer)wealth_index);

f_rel_count_i := if(not(truedid), NULL, min(if(rel_count = NULL, -NULL, rel_count), 999));

f_rel_incomeover25_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count, rel_incomeunder50_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count))));

f_rel_incomeover50_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count))));

f_rel_incomeover75_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count))));

f_rel_incomeover100_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_incomeover100_count);

f_rel_homeover50_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_rel_homeover100_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_rel_homeover150_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_rel_homeover200_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_rel_homeover300_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_rel_ageover20_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))));

f_rel_ageover30_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))));

f_rel_ageover40_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))));

f_rel_ageover50_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))));

f_rel_ageover70_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_ageover70_count);

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

f_crim_rel_under100miles_cnt_i := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(crim_rel_within25miles, crim_rel_within100miles) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles))));

f_crim_rel_under500miles_cnt_i := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(crim_rel_within25miles, crim_rel_within100miles, crim_rel_within500miles) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles), if(crim_rel_within500miles = NULL, 0, crim_rel_within500miles))));

f_rel_under25miles_cnt_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_within25miles_count);

f_rel_under100miles_cnt_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_within25miles_count, rel_within100miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count))));

f_rel_under500miles_cnt_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count))));

f_rel_bankrupt_count_i := map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 999));

f_rel_criminal_count_i := map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_criminal_count = NULL, -NULL, rel_criminal_count), 999));

f_rel_felony_count_i := map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_felony_count = NULL, -NULL, rel_felony_count), 999));

f_current_count_d := if(not(truedid), NULL, min(if(current_count = NULL, -NULL, current_count), 999));

f_historical_count_d := if(not(truedid), NULL, min(if(historical_count = NULL, -NULL, historical_count), 999));

f_accident_count_i := if(not(truedid), NULL, min(if(acc_count = NULL, -NULL, acc_count), 999));

f_acc_damage_amt_total_i := if(not(truedid), NULL, acc_damage_amt_total);

_acc_last_seen := common.sas_date((string)(acc_last_seen));

f_mos_acc_lseen_d := map(
    not(truedid)          => NULL,
    _acc_last_seen = NULL => 1000,
                             max(3, min(if(if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12)))), 999)));

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

f_idverrisktype_i := if(not(truedid) or fp_idverrisktype = '', NULL, (integer)fp_idverrisktype);

f_sourcerisktype_i := map(
    not(truedid)             => NULL,
    fp_sourcerisktype = ''   => NULL,
                                (integer)fp_sourcerisktype);

f_varrisktype_i := map(
    not(truedid)          => NULL,
    fp_varrisktype = ''   => NULL,
                             (integer)fp_varrisktype);

f_vardobcountnew_i := if(not(truedid), NULL, min(if(fp_vardobcountnew = '', -NULL, (integer)fp_vardobcountnew), 999));

f_srchvelocityrisktype_i := map(
    not(truedid)                   => NULL,
    fp_srchvelocityrisktype = '' => NULL,
                                      (integer)fp_srchvelocityrisktype);

f_srchcountwk_i := if(not(truedid), NULL, min(if(fp_srchcountwk = '', -NULL, (integer)fp_srchcountwk), 999));

f_srchunvrfdssncount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdssncount = '', -NULL, (integer)fp_srchunvrfdssncount), 999));

f_srchunvrfdaddrcount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdaddrcount = '', -NULL, (integer)fp_srchunvrfdaddrcount), 999));

f_srchunvrfddobcount_i := if(not(truedid), NULL, min(if(fp_srchunvrfddobcount = '', -NULL, (integer)fp_srchunvrfddobcount), 999));

f_srchunvrfdphonecount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = '', -NULL, (integer)fp_srchunvrfdphonecount), 999));

f_srchfraudsrchcountyr_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountyr = '', -NULL, (integer)fp_srchfraudsrchcountyr), 999));

f_srchfraudsrchcountmo_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountmo = '', -NULL, (integer)fp_srchfraudsrchcountmo), 999));

f_srchlocatesrchcountwk_i := if(not(truedid), NULL, min(if(fp_srchlocatesrchcountwk = '', -NULL, (integer)fp_srchlocatesrchcountwk), 999));

f_assocsuspicousidcount_i := if(not(truedid), NULL, min(if(fp_assocsuspicousidcount = '', -NULL, (integer)fp_assocsuspicousidcount), 999));

f_validationrisktype_i := map(
    not(truedid)                 => NULL,
    fp_validationrisktype = '' => NULL,
                                    (integer)fp_validationrisktype);

f_divrisktype_i := map(
    not(truedid)          => NULL,
    fp_divrisktype = '' => NULL,
                             (integer)fp_divrisktype);

f_divssnidmsrcurelcount_i := if(not(truedid), NULL, min(if(fp_divssnidmsrcurelcount = '', -NULL, (integer)fp_divssnidmsrcurelcount), 999));

f_divaddrsuspidcountnew_i := if(not(truedid), NULL, min(if(fp_divaddrsuspidcountnew = '', -NULL, (integer)fp_divaddrsuspidcountnew), 999));

f_divsrchaddrsuspidcount_i := if(not(truedid), NULL, min(if(fp_divsrchaddrsuspidcount = '', -NULL, (integer)fp_divsrchaddrsuspidcount), 999));

f_srchcomponentrisktype_i := map(
    not(truedid)                    => NULL,
    fp_srchcomponentrisktype = '' => NULL,
                                       (integer)fp_srchcomponentrisktype);

f_srchssnsrchcountmo_i := if(not(truedid), NULL, min(if(fp_srchssnsrchcountmo = '', -NULL, (integer)fp_srchssnsrchcountmo), 999));

f_srchssnsrchcountday_i := if(not(truedid), NULL, min(if(fp_srchssnsrchcountday = '', -NULL, (integer)fp_srchssnsrchcountday), 999));

f_srchaddrsrchcountmo_i := if(not(truedid), NULL, min(if(fp_srchaddrsrchcountmo = '', -NULL, (integer)fp_srchaddrsrchcountmo), 999));

f_srchaddrsrchcountwk_i := if(not(truedid), NULL, min(if(fp_srchaddrsrchcountwk = '', -NULL, (integer)fp_srchaddrsrchcountwk), 999));

f_srchphonesrchcountmo_i := if(not(truedid), NULL, min(if(fp_srchphonesrchcountmo = '', -NULL, (integer)fp_srchphonesrchcountmo), 999));

f_addrchangeincomediff_d_1 := if(not(truedid), NULL, NULL);

f_addrchangeincomediff_d := if(fp_addrchangeincomediff = '-1', NULL, (integer)fp_addrchangeincomediff);

f_addrchangevaluediff_d := map(
    not(truedid)                => NULL,
    fp_addrchangevaluediff = '-1' => NULL,
                                   (integer)fp_addrchangevaluediff);

f_addrchangecrimediff_i := map(
    not(truedid)                => NULL,
    fp_addrchangecrimediff = '-1' => NULL,
                                   (integer)fp_addrchangecrimediff);

f_addrchangeecontrajindex_d := if(not(truedid) or fp_addrchangeecontrajindex = '' or fp_addrchangeecontrajindex = '-1', NULL, (integer)fp_addrchangeecontrajindex);

f_curraddractivephonelist_d := map(
    not(add_curr_pop)               => NULL,
    fp_curraddractivephonelist = '-1' => NULL,
                                       (integer)fp_curraddractivephonelist);

f_curraddrmedianincome_d := if(not(add_curr_pop), NULL, (integer)fp_curraddrmedianincome);

f_curraddrmedianvalue_d := if(not(add_curr_pop), NULL, (integer)fp_curraddrmedianvalue);

f_curraddrmurderindex_i := if(not(add_curr_pop), NULL, (integer)fp_curraddrmurderindex);

f_curraddrcartheftindex_i := if(not(add_curr_pop), NULL, (integer)fp_curraddrcartheftindex);

f_curraddrburglaryindex_i := if(not(add_curr_pop), NULL, (integer)fp_curraddrburglaryindex);

f_curraddrcrimeindex_i := if(not(add_curr_pop), NULL, (integer)fp_curraddrcrimeindex);

f_prevaddrageoldest_d := if(not(truedid), NULL, min(if(fp_prevaddrageoldest = '', -NULL, (integer)fp_prevaddrageoldest), 999));

f_prevaddrlenofres_d := if(not(truedid), NULL, min(if(fp_prevaddrlenofres = '', -NULL, (integer)fp_prevaddrlenofres), 999));

f_prevaddrmedianincome_d := if(not(truedid), NULL, (integer)fp_prevaddrmedianincome);

f_prevaddrmedianvalue_d := if(not(truedid), NULL, (integer)fp_prevaddrmedianvalue);

f_prevaddrmurderindex_i := if(not(truedid), NULL, (integer)fp_prevaddrmurderindex);

f_prevaddrcartheftindex_i := if(not(truedid), NULL, (integer)fp_prevaddrcartheftindex);

f_fp_prevaddrburglaryindex_i := if(not(truedid), NULL, (integer)fp_prevaddrburglaryindex);

f_fp_prevaddrcrimeindex_i := if(not(truedid), NULL, (integer)fp_prevaddrcrimeindex);

r_d31_all_bk_i := map(
    not(truedid)                                                                                                                                                                                                                                                                                                   => NULL,
    contains_i(StringLib.StringToUpperCase(disposition), 'DISMISS') = 1 or if(max(bk_dismissed_recent_count, bk_dismissed_historical_count) = NULL, NULL, sum(if(bk_dismissed_recent_count = NULL, 0, bk_dismissed_recent_count), if(bk_dismissed_historical_count = NULL, 0, bk_dismissed_historical_count))) > 0 => 1,
    contains_i(StringLib.StringToUpperCase(disposition), 'DISCHARG') = 1 or if(max(bk_disposed_recent_count, bk_disposed_historical_count) = NULL, NULL, sum(if(bk_disposed_recent_count = NULL, 0, bk_disposed_recent_count), if(bk_disposed_historical_count = NULL, 0, bk_disposed_historical_count))) > 0      => 2,
    bankrupt or filing_count > 0                                                                                                                                                                                                                                                                               => 3,
                                                                                                                                                                                                                                                                                                                      0);

r_d31_bk_chapter_n := map(
    not(truedid)                                 => '',
    not((bk_chapter in ['7', '11', '12', '13'])) => '',
                                                    trim(bk_chapter, LEFT));

r_d31_bk_dism_recent_count_i := if(not(truedid), NULL, min(if(bk_dismissed_recent_count = NULL, -NULL, bk_dismissed_recent_count), 999));

r_c12_source_profile_d := if(not(truedid), NULL, hdr_source_profile);

r_f01_inp_addr_not_verified_i := if(not(add_input_pop and truedid), NULL, (integer)add_input_addr_not_verified);

r_c23_inp_addr_occ_index_d := if(not(add_input_pop and truedid), NULL, add_input_occ_index);

r_f04_curr_add_occ_index_d := if(not(truedid and add_curr_pop), NULL, add_curr_occ_index);

r_e57_br_source_count_d := if(not(truedid), NULL, br_source_count);

r_i60_inq_prepaidcards_count12_i := if(not(truedid), NULL, min(if(inq_PrepaidCards_count12 = NULL, -NULL, inq_PrepaidCards_count12), 999));

r_i60_inq_prepaidcards_recency_d := map(
    not(truedid)             => NULL,
    (boolean)inq_PrepaidCards_count01 => 1,
    (boolean)inq_PrepaidCards_count03 => 3,
    (boolean)inq_PrepaidCards_count06 => 6,
    (boolean)inq_PrepaidCards_count12 => 12,
    (boolean)inq_PrepaidCards_count24 => 24,
    (boolean)inq_PrepaidCards_count   => 99,
                                999);

r_i60_inq_retpymt_count12_i := if(not(truedid), NULL, min(if(inq_retailpayments_count12 = NULL, -NULL, inq_retailpayments_count12), 999));

r_i60_inq_util_recency_d := map(
    not(truedid)          => NULL,
    (boolean)inq_utilities_count01 => 1,
    (boolean)inq_utilities_count03 => 3,
    (boolean)inq_utilities_count06 => 6,
    (boolean)inq_utilities_count12 => 12,
    (boolean)inq_utilities_count24 => 24,
    (boolean)inq_utilities_count   => 99,
                             999);

f_phone_ver_insurance_d := if(not(truedid) or phone_ver_insurance = '-1', NULL, (integer)phone_ver_insurance);

f_phone_ver_experian_d := if(not(truedid) or phone_ver_experian = '-1', NULL, (integer)phone_ver_experian);

f_addrs_per_ssn_i := if(not((integer)ssnlength > 0), NULL, min(if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn), 999));

f_phones_per_addr_curr_i := if(not(add_curr_pop), NULL, min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999));

f_addrs_per_ssn_c6_i := if(not((integer)ssnlength > 0), NULL, min(if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6), 999));

f_phones_per_addr_c6_i := if(not(addrpop), NULL, min(if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6), 999));

f_adls_per_phone_c6_i := if(not(hphnpop), NULL, min(if(adls_per_phone_c6 = NULL, -NULL, adls_per_phone_c6), 999));

f_inq_highriskcredit_cnt_day_i := if(not(truedid), NULL, min(if(inq_HighRiskCredit_count_day = NULL, -NULL, inq_HighRiskCredit_count_day), 999));

f_inq_prepaidcards_count24_i := if(not(truedid), NULL, min(if(inq_PrepaidCards_count24 = NULL, -NULL, inq_PrepaidCards_count24), 999));

f_inq_retailpayments_count24_i := if(not(truedid), NULL, min(if(inq_RetailPayments_count24 = NULL, -NULL, inq_RetailPayments_count24), 999));

_liens_rel_sc_last_seen := common.sas_date((string)(liens_rel_SC_last_seen));

f_mos_liens_rel_sc_lseen_d := map(
    not(truedid)                   => NULL,
    _liens_rel_sc_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12)))), 999)));

f_liens_rel_sc_total_amt_i := if(not(truedid), NULL, liens_rel_SC_total_amount);

_liens_unrel_st_first_seen := common.sas_date((string)(liens_unrel_ST_first_seen));

f_mos_liens_unrel_st_fseen_d := map(
    not(truedid)                      => NULL,
    _liens_unrel_st_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)))), 999));

_liens_unrel_st_last_seen := common.sas_date((string)(liens_unrel_ST_last_seen));

f_mos_liens_unrel_st_lseen_d := map(
    not(truedid)                     => NULL,
    _liens_unrel_st_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)))), 999)));

_liens_rel_st_first_seen := common.sas_date((string)(liens_rel_ST_first_seen));

f_mos_liens_rel_st_fseen_d := map(
    not(truedid)                    => NULL,
    _liens_rel_st_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _liens_rel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_st_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_st_first_seen) / (365.25 / 12)))), 999));

_liens_rel_st_last_seen := common.sas_date((string)(liens_rel_ST_last_seen));

f_mos_liens_rel_st_lseen_d := map(
    not(truedid)                   => NULL,
    _liens_rel_st_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _liens_rel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_st_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_st_last_seen) / (365.25 / 12)))), 999)));

f_hh_members_ct_d := if(not(truedid), NULL, min(if(hh_members_ct = NULL, -NULL, hh_members_ct), 999));

f_hh_age_65_plus_d := if(not(truedid), NULL, min(if(hh_age_65_plus = NULL, -NULL, hh_age_65_plus), 999));

f_hh_age_30_plus_d := if(not(truedid), NULL, min(if(if(max(hh_age_65_plus, hh_age_30_to_65) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65))) = NULL, -NULL, if(max(hh_age_65_plus, hh_age_30_to_65) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65)))), 999));

f_hh_age_18_plus_d := if(not(truedid), NULL, min(if(if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30))) = NULL, -NULL, if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30)))), 999));

f_hh_collections_ct_i := if(not(truedid), NULL, min(if(hh_collections_ct = NULL, -NULL, hh_collections_ct), 999));

f_hh_workers_paw_d := if(not(truedid), NULL, min(if(hh_workers_paw = NULL, -NULL, hh_workers_paw), 999));

f_hh_payday_loan_users_i := if(not(truedid), NULL, min(if(hh_payday_loan_users = NULL, -NULL, hh_payday_loan_users), 999));

f_hh_tot_derog_i := if(not(truedid), NULL, min(if(hh_tot_derog = NULL, -NULL, hh_tot_derog), 999));

f_hh_bankruptcies_i := if(not(truedid), NULL, min(if(hh_bankruptcies = NULL, -NULL, hh_bankruptcies), 999));

f_hh_lienholders_i := if(not(truedid), NULL, min(if(hh_lienholders = NULL, -NULL, hh_lienholders), 999));

f_hh_criminals_i := if(not(truedid), NULL, min(if(hh_criminals = NULL, -NULL, hh_criminals), 999));

_ver_src_ds_1 := Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0;

_ver_src_de_1 := Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0;

_ver_src_eq_1 := Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0;

_ver_src_en_1 := Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0;

_ver_src_tn_1 := Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0;

_ver_src_tu_1 := Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0;

_credit_source_cnt_1 := if(max((integer)_ver_src_eq_1, (integer)_ver_src_en_1, (integer)_ver_src_tn_1, (integer)_ver_src_tu_1) = NULL, NULL, sum((integer)_ver_src_eq_1, (integer)_ver_src_en_1, (integer)_ver_src_tn_1, (integer)_ver_src_tu_1));

_ver_src_cnt_1 := Models.Common.countw((string)(ver_sources));

_bureauonly_1 := _credit_source_cnt_1 > 0 AND _credit_source_cnt_1 = _ver_src_cnt_1 AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6]));

_derog_1 := felony_count > 0 OR addrs_prison_history OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2;

_deceased_1 := rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds_1 OR _ver_src_de_1;

_ssnpriortodob_1 := rc_ssndobflag = '1' OR rc_pwssndobflag = '1';

_inputmiskeys_1 := rc_ssnmiskeyflag or rc_addrmiskeyflag or (integer)add_input_house_number_match = 0;

_multiplessns_1 := ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1;

_hh_strikes_1 := if((real)max((integer)hh_members_w_derog > 0, 
                        (integer)hh_criminals > 0, 
												(integer)hh_payday_loan_users > 0
											 ) = NULL, 
									  NULL, 
										(real)sum((integer)hh_members_w_derog > 0, 
										    (integer)hh_criminals > 0, 
												(integer)hh_payday_loan_users > 0
											 )
									 );

nf_seg_fraudpoint_3_0 := map(
    addrpop and (nas_summary in [4, 7, 9]) or fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and (integer)ssnlength = 9 or _deceased_1 or _ssnpriortodob_1 => '1: Stolen/Manip ID  ',
    _inputmiskeys_1 and (_multiplessns_1 or lnames_per_adl_c6 > 1)                                                                                                                                 => '1: Stolen/Manip ID  ',
    fnamepop and lnamepop and addrpop and (integer)ssnlength = 9 and hphnpop and nap_summary <= 4 and nas_summary <= 4 or _ver_src_cnt_1 = 0 or _bureauonly_1 or (integer)add_curr_pop = 0                           => '2: Synth ID         ',
    _derog_1                                                                                                                                                                                         => '3: Derog            ',
    Inq_count03 > 0 or Inq_count12 >= 4 or fp_srchfraudsrchcountyr >= '1' or fp_srchssnsrchcountmo >= '1' or fp_srchaddrsrchcountmo >= '1' or fp_srchphonesrchcountmo >= '1'                               => '4: Recent Activity  ',
    0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70                                                                                                                                  => '5: Vuln Vic/Friendly',
    hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes_1 >= 2 or rel_felony_count >= 2)                                                                                                => '5: Vuln Vic/Friendly',
                                                                                                                                                                                                      '6: Other            ');

final_score_tree_0 := -1.7233382031;

final_score_tree_1_c241 := map(
    NULL < (integer)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d < 0.5 => 0.0398199193,
    (real)k_nap_phn_verd_d >= 0.5                            => -0.0193601613,
                                                          0.0144796529);

final_score_tree_1_c240 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d < 0.15722584035 => 0.1249877862,
    f_add_input_nhood_sfd_pct_d >= 0.15722584035                                       => final_score_tree_1_c241,
                                                                                          0.0368172400);

final_score_tree_1_c243 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i < 1.5 => 0.1211513753,
    f_inq_communications_count24_i >= 1.5                                          => 0.3101449824,
                                                                                      0.4619638635);

final_score_tree_1_c242 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d < 0.0734645517 => final_score_tree_1_c243,
    f_add_input_nhood_sfd_pct_d >= 0.0734645517                                       => 0.0093534576,
                                                                                         0.0596816841);

final_score_tree_1 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => final_score_tree_1_c240,
    f_phone_ver_experian_d >= 0.5                                  => -0.0500182619,
                                                                      final_score_tree_1_c242);

final_score_tree_2_c246 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d < 549 => 0.0334712924,
    r_i60_inq_comm_recency_d >= 549                                    => -0.0186537980,
                                                                          0.0073608161);

final_score_tree_2_c245 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d < 0.21680618055 => 0.0888359405,
    f_add_input_nhood_sfd_pct_d >= 0.21680618055                                       => final_score_tree_2_c246,
                                                                                          0.0259682170);

final_score_tree_2_c248 := map(
    NULL < r_c16_inv_ssn_per_adl_i AND r_c16_inv_ssn_per_adl_i < 0.5 => 0.1782992169,
    r_c16_inv_ssn_per_adl_i >= 0.5                                   => -0.0043474083,
                                                                        0.3135021688);

final_score_tree_2_c247 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d < 0.0706842829 => final_score_tree_2_c248,
    f_add_input_nhood_sfd_pct_d >= 0.0706842829                                       => 0.0145380794,
                                                                                         0.0531787190);

final_score_tree_2 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => final_score_tree_2_c245,
    f_phone_ver_experian_d >= 0.5                                  => -0.0501817868,
                                                                      final_score_tree_2_c247);

final_score_tree_3_c251 := map(
    (nf_seg_fraudpoint_3_0 in ['2: Synth ID', '3: Derog', '5: Vuln Vic/Friendly', '6: Other']) => 0.0449015017,
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '4: Recent Activity'])                    => 0.1633837110,
                                                                                                  0.0890092752);

final_score_tree_3_c250 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.745385238 => 0.0074461870,
    f_add_input_nhood_mfd_pct_i >= 0.745385238                                       => final_score_tree_3_c251,
                                                                                        0.0278415356);

final_score_tree_3_c253 := map(
    NULL < r_c16_inv_ssn_per_adl_i AND r_c16_inv_ssn_per_adl_i < 0.5 => 0.1455958451,
    r_c16_inv_ssn_per_adl_i >= 0.5                                   => -0.0302767287,
                                                                        0.2624871564);

final_score_tree_3_c252 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d < 0.0730647709 => final_score_tree_3_c253,
    f_add_input_nhood_sfd_pct_d >= 0.0730647709                                       => 0.0188712766,
                                                                                         0.0489318048);

final_score_tree_3 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => final_score_tree_3_c250,
    f_phone_ver_experian_d >= 0.5                                  => -0.0458301649,
                                                                      final_score_tree_3_c252);

final_score_tree_4_c257 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d < 0.5 => 0.3625989991,
    f_rel_under500miles_cnt_d >= 0.5                                     => 0.0850554072,
                                                                            0.1474469699);

final_score_tree_4_c256 := map(
    NULL < (integer)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d < 0.5 => final_score_tree_4_c257,
    (real)k_nap_phn_verd_d >= 0.5                            => 0.0056282245,
                                                          0.0641512951);

final_score_tree_4_c255 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d < 2.5 => final_score_tree_4_c256,
    r_f03_address_match_d >= 2.5                                 => -0.0013492146,
                                                                    0.0235462215);

final_score_tree_4_c258 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d < 0.0296770213 => 0.1037112744,
    f_add_input_nhood_sfd_pct_d >= 0.0296770213                                       => 0.0133758075,
                                                                                         0.0343587063);

final_score_tree_4 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => final_score_tree_4_c255,
    f_phone_ver_experian_d >= 0.5                                  => -0.0407131265,
                                                                      final_score_tree_4_c258);

final_score_tree_5_c260 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d < 549 => -0.0097643344,
    r_i60_inq_comm_recency_d >= 549                                    => -0.0610595303,
                                                                          -0.0386657139);

final_score_tree_5_c262 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d < 549 => 0.0354387812,
    r_i60_inq_comm_recency_d >= 549                                    => -0.0143458251,
                                                                          0.0094329425);

final_score_tree_5_c263 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i < 2.5 => 0.0732620253,
    f_inq_communications_count24_i >= 2.5                                          => 0.1973831934,
                                                                                      0.0924539806);

final_score_tree_5_c261 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.880443238 => final_score_tree_5_c262,
    f_add_input_nhood_mfd_pct_i >= 0.880443238                                       => final_score_tree_5_c263,
                                                                                        0.0115404152);

final_score_tree_5 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i < 1.5 => final_score_tree_5_c260,
    f_idverrisktype_i >= 1.5                             => final_score_tree_5_c261,
                                                            0.1357108921);

final_score_tree_6_c267 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d < 3.5 => 0.0725101095,
    f_addrchangeecontrajindex_d >= 3.5                                       => 0.2187760422,
                                                                                0.0631070954);

final_score_tree_6_c266 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i < 5.5 => 0.0266513006,
    f_idverrisktype_i >= 5.5                             => final_score_tree_6_c267,
                                                            0.0372972817);

final_score_tree_6_c265 := map(
    NULL < (integer)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d < 0.5 => final_score_tree_6_c266,
    (real)k_nap_phn_verd_d >= 0.5                            => -0.0148770617,
                                                          0.0167337221);

final_score_tree_6_c268 := map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d < 0.0607659367 => 0.0769081881,
    f_add_curr_nhood_sfd_pct_d >= 0.0607659367                                      => 0.0086409348,
                                                                                       0.1132121717);

final_score_tree_6 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => final_score_tree_6_c265,
    f_phone_ver_experian_d >= 0.5                                  => -0.0381411239,
                                                                      final_score_tree_6_c268);

final_score_tree_7_c271 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i < 0.8232268214 => 0.0060701616,
    f_add_curr_nhood_mfd_pct_i >= 0.8232268214                                      => 0.1747064506,
                                                                                       0.0359478976);

final_score_tree_7_c270 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d < 549 => final_score_tree_7_c271,
    r_i60_inq_comm_recency_d >= 549                                    => -0.0317049365,
                                                                          -0.0129136913);

final_score_tree_7_c272 := map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i < 1.5 => 0.0409186102,
    r_i60_inq_comm_count12_i >= 1.5                                    => 0.1245639088,
                                                                          0.0533918449);

final_score_tree_7_c273 := map(
    NULL < r_d31_mostrec_bk_i AND r_d31_mostrec_bk_i < 0.5 => -0.0049078624,
    r_d31_mostrec_bk_i >= 0.5                              => -0.0552929711,
                                                              -0.0194356993);

final_score_tree_7 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.7446190903 => final_score_tree_7_c270,
    f_add_input_nhood_mfd_pct_i >= 0.7446190903                                       => final_score_tree_7_c272,
                                                                                         final_score_tree_7_c273);

final_score_tree_8_c276 := map(
    NULL < (integer)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d < 0.5 => 0.0464764706,
    (real)k_nap_phn_verd_d >= 0.5                            => -0.0041601315,
                                                          0.0277321549);

final_score_tree_8_c275 := map(
    NULL < r_d31_attr_bankruptcy_recency_d AND r_d31_attr_bankruptcy_recency_d < 4.5 => final_score_tree_8_c276,
    r_d31_attr_bankruptcy_recency_d >= 4.5                                           => -0.0298544806,
                                                                                        0.0151338048);

final_score_tree_8_c278 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d < 0.14967699015 => 0.0963803153,
    f_add_input_nhood_sfd_pct_d >= 0.14967699015                                       => 0.0174187962,
                                                                                          0.0427939536);

final_score_tree_8_c277 := map(
    NULL < r_s65_ssn_problem_i AND r_s65_ssn_problem_i < 0.5 => final_score_tree_8_c278,
    r_s65_ssn_problem_i >= 0.5                               => -0.0547795623,
                                                                0.0239940202);

final_score_tree_8 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => final_score_tree_8_c275,
    f_phone_ver_experian_d >= 0.5                                  => -0.0352782860,
                                                                      final_score_tree_8_c277);

final_score_tree_9_c282 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d < 100.5 => 0.0482467272,
    r_c13_curr_addr_lres_d >= 100.5                                  => 0.2228386603,
                                                                        0.1064440383);

final_score_tree_9_c281 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d < 0.5 => final_score_tree_9_c282,
    f_rel_under25miles_cnt_d >= 0.5                                    => 0.0131892002,
                                                                          0.0549644958);

final_score_tree_9_c283 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i < 13.5 => -0.0345867898,
    f_phones_per_addr_curr_i >= 13.5                                    => 0.0111799290,
                                                                           -0.0258038058);

final_score_tree_9_c280 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d < 2.5 => final_score_tree_9_c281,
    r_f03_address_match_d >= 2.5                                 => final_score_tree_9_c283,
                                                                    -0.0107694777);

final_score_tree_9 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i < 2.5 => final_score_tree_9_c280,
    f_inq_communications_count24_i >= 2.5                                          => 0.0835878079,
                                                                                      0.0849810169);

final_score_tree_10_c285 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.66634114585 => 0.0168338268,
    f_add_input_nhood_mfd_pct_i >= 0.66634114585                                       => 0.0702788801,
                                                                                          0.0157728792);

final_score_tree_10_c288 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i < 4.5 => 0.0258475459,
    f_idverrisktype_i >= 4.5                             => 0.1241149289,
                                                            0.0413598279);

final_score_tree_10_c287 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n < 0.5 => final_score_tree_10_c288,
    r_phn_cell_n >= 0.5                        => -0.0134972898,
                                                  0.0053809064);

final_score_tree_10_c286 := map(
    NULL < (integer)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d < 0.5 => final_score_tree_10_c287,
    (real)k_nap_phn_verd_d >= 0.5                            => -0.0341914663,
                                                          -0.0172210733);

final_score_tree_10 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d < 61.5 => final_score_tree_10_c285,
    r_i60_inq_comm_recency_d >= 61.5                                    => final_score_tree_10_c286,
                                                                           0.0656666773);

final_score_tree_11_c291 := map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d < 0.04673400685 => 0.0801792370,
    f_add_curr_nhood_sfd_pct_d >= 0.04673400685                                      => 0.0264147814,
                                                                                        0.0363068189);

final_score_tree_11_c290 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i < 1.5 => -0.0084874570,
    r_p88_phn_dst_to_inp_add_i >= 1.5                                      => 0.0274780355,
                                                                              final_score_tree_11_c291);

final_score_tree_11_c293 := map(
    NULL < f_util_add_input_conv_n AND f_util_add_input_conv_n < 0.5 => 0.1208813255,
    f_util_add_input_conv_n >= 0.5                                   => 0.0028722554,
                                                                        0.0329447170);

final_score_tree_11_c292 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d < 3.5 => -0.0334650552,
    f_addrchangeecontrajindex_d >= 3.5                                       => final_score_tree_11_c293,
                                                                                -0.0048656766);

final_score_tree_11 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d < 549 => final_score_tree_11_c290,
    r_i60_inq_comm_recency_d >= 549                                    => final_score_tree_11_c292,
                                                                          0.0838532161);

final_score_tree_12_c297 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d < 239032 => 0.0893157088,
    r_a46_curr_avm_autoval_d >= 239032                                    => 0.2615005538,
                                                                             0.0744037048);

final_score_tree_12_c298 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => 0.0163912722,
    f_phone_ver_experian_d >= 0.5                                  => -0.0343746639,
                                                                      0.0292945052);

final_score_tree_12_c296 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d < -22549 => final_score_tree_12_c297,
    f_addrchangeincomediff_d >= -22549                                    => final_score_tree_12_c298,
                                                                             0.0092810968);

final_score_tree_12_c295 := map(
    NULL < (integer)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d < 0.5 => final_score_tree_12_c296,
    (real)k_nap_phn_verd_d >= 0.5                            => -0.0286811572,
                                                          -0.0115785095);

final_score_tree_12 := map(
    NULL < f_srchunvrfdssncount_i AND f_srchunvrfdssncount_i < 0.5 => final_score_tree_12_c295,
    f_srchunvrfdssncount_i >= 0.5                                  => 0.0476697841,
                                                                      0.0547220684);

final_score_tree_13_c302 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d < 342515.5 => 0.0242048507,
    f_prevaddrmedianvalue_d >= 342515.5                                   => 0.0881299016,
                                                                             0.0332163117);

final_score_tree_13_c301 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d < 0.5 => 0.1692329713,
    f_rel_under500miles_cnt_d >= 0.5                                     => final_score_tree_13_c302,
                                                                            0.0778551725);

final_score_tree_13_c300 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d < 2.5 => final_score_tree_13_c301,
    r_f03_address_match_d >= 2.5                                 => -0.0011559437,
                                                                    0.0132991954);

final_score_tree_13_c303 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i < 2.5 => 0.0095284890,
    f_inq_communications_count24_i >= 2.5                                          => 0.0911510259,
                                                                                      0.0753266546);

final_score_tree_13 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => final_score_tree_13_c300,
    f_phone_ver_experian_d >= 0.5                                  => -0.0289017216,
                                                                      final_score_tree_13_c303);

final_score_tree_14_c305 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i < 2.5 => 0.0272796299,
    f_inq_communications_count24_i >= 2.5                                          => 0.0852001371,
                                                                                      0.0350047485);

final_score_tree_14_c308 := map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i < 0.5 => -0.0287461671,
    r_l70_add_standardized_i >= 0.5                                    => 0.0103012896,
                                                                          -0.0212275805);

final_score_tree_14_c307 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d < 342610.5 => final_score_tree_14_c308,
    f_curraddrmedianvalue_d >= 342610.5                                   => 0.0279610789,
                                                                             -0.0159103903);

final_score_tree_14_c306 := map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d < 549 => 0.0317809886,
    r_i60_inq_prepaidcards_recency_d >= 549                                            => final_score_tree_14_c307,
                                                                                          -0.0090903973);

final_score_tree_14 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d < 0.05271172855 => final_score_tree_14_c305,
    f_add_input_nhood_sfd_pct_d >= 0.05271172855                                       => final_score_tree_14_c306,
                                                                                          -0.0032934786);

final_score_tree_15_c312 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d < 7377 => 0.0380898699,
    f_addrchangeincomediff_d >= 7377                                    => 0.1458035523,
                                                                           0.0226354598);

final_score_tree_15_c311 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d < 0.1519704472 => final_score_tree_15_c312,
    f_add_input_nhood_sfd_pct_d >= 0.1519704472                                       => 0.0071128730,
                                                                                         0.0150278164);

final_score_tree_15_c310 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 125553.5 => final_score_tree_15_c311,
    f_curraddrmedianincome_d >= 125553.5                                    => 0.2405164156,
                                                                               0.0768989741);

final_score_tree_15_c313 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i < 1.5 => -0.0288413134,
    f_srchunvrfdphonecount_i >= 1.5                                    => 0.0415189596,
                                                                          -0.0194947671);

final_score_tree_15 := map(
    NULL < (integer)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d < 0.5 => final_score_tree_15_c310,
    (real)k_nap_phn_verd_d >= 0.5                            => final_score_tree_15_c313,
                                                          -0.0033480083);

final_score_tree_16_c316 := map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d < 549 => 0.0440995660,
    r_i60_inq_prepaidcards_recency_d >= 549                                            => 0.0002918852,
                                                                                          0.0092952359);

final_score_tree_16_c315 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i < 8.5 => final_score_tree_16_c316,
    r_l79_adls_per_addr_curr_i >= 8.5                                      => 0.0552549645,
                                                                              0.0156448025);

final_score_tree_16_c318 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d < 268125.5 => -0.0025031276,
    r_a46_curr_avm_autoval_d >= 268125.5                                    => 0.0795927975,
                                                                               -0.0132369171);

final_score_tree_16_c317 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d < 3.5 => final_score_tree_16_c318,
    f_phone_ver_insurance_d >= 3.5                                   => -0.0426632105,
                                                                        -0.0229568843);

final_score_tree_16 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d < 549 => final_score_tree_16_c315,
    r_i60_inq_comm_recency_d >= 549                                    => final_score_tree_16_c317,
                                                                          0.0461153759);

final_score_tree_17_c323 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i < 5.5 => 0.0665839656,
    f_idverrisktype_i >= 5.5                             => 0.1768232189,
                                                            0.0894174857);

final_score_tree_17_c322 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n < 0.5 => final_score_tree_17_c323,
    r_phn_pcs_n >= 0.5                       => 0.0020792529,
                                                0.0321289591);

final_score_tree_17_c321 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n < 0.5 => final_score_tree_17_c322,
    r_phn_cell_n >= 0.5                        => -0.0083708269,
                                                  0.0051291018);

final_score_tree_17_c320 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i < 1.5 => -0.0304238919,
    r_p88_phn_dst_to_inp_add_i >= 1.5                                      => 0.0017950016,
                                                                              final_score_tree_17_c321);

final_score_tree_17 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i < 2.5 => final_score_tree_17_c320,
    f_inq_communications_count24_i >= 2.5                                          => 0.0437315594,
                                                                                      0.0392584233);

final_score_tree_18_c326 := map(
    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i < 3.5 => -0.0034691165,
    f_inq_highriskcredit_count24_i >= 3.5                                          => 0.0598260313,
                                                                                      0.0028368752);

final_score_tree_18_c325 := map(
    NULL < f_historical_count_d AND f_historical_count_d < 0.5 => 0.0323329354,
    f_historical_count_d >= 0.5                                => final_score_tree_18_c326,
                                                                  0.0142141860);

final_score_tree_18_c328 := map(
    NULL < r_d31_attr_bankruptcy_recency_d AND r_d31_attr_bankruptcy_recency_d < 9 => -0.0137832352,
    r_d31_attr_bankruptcy_recency_d >= 9                                           => -0.0587405363,
                                                                                      -0.0248325786);

final_score_tree_18_c327 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i < 1.5 => final_score_tree_18_c328,
    f_srchcomponentrisktype_i >= 1.5                                     => 0.0278597829,
                                                                            -0.0184009592);

final_score_tree_18 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d < 549 => final_score_tree_18_c325,
    r_i60_inq_comm_recency_d >= 549                                    => final_score_tree_18_c327,
                                                                          0.0307398501);

final_score_tree_19_c332 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i < 57.5 => 0.0002317836,
    f_addrchangecrimediff_i >= 57.5                                   => 0.0732413513,
                                                                         0.0041017902);

final_score_tree_19_c331 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 127015.5 => final_score_tree_19_c332,
    f_curraddrmedianincome_d >= 127015.5                                    => 0.1856499075,
                                                                               0.0047254061);

final_score_tree_19_c330 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d < 95 => 0.1033055838,
    r_f00_ssn_score_d >= 95                             => final_score_tree_19_c331,
                                                           0.0075750511);

final_score_tree_19_c333 := map(
    NULL < r_s65_ssn_problem_i AND r_s65_ssn_problem_i < 0.5 => 0.0279134454,
    r_s65_ssn_problem_i >= 0.5                               => -0.0496464581,
                                                                0.0140718949);

final_score_tree_19 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => final_score_tree_19_c330,
    f_phone_ver_experian_d >= 0.5                                  => -0.0242646100,
                                                                      final_score_tree_19_c333);

final_score_tree_20_c338 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 131470 => 0.0091939848,
    f_curraddrmedianincome_d >= 131470                                    => 0.1776025879,
                                                                             0.0099173543);

final_score_tree_20_c337 := map(
    NULL < (integer)k_inf_phn_verd_d AND (real)k_inf_phn_verd_d < 0.5 => final_score_tree_20_c338,
    (real)k_inf_phn_verd_d >= 0.5                            => -0.0211408598,
                                                          -0.0001542473);

final_score_tree_20_c336 := map(
    NULL < r_d31_mostrec_bk_i AND r_d31_mostrec_bk_i < 1.5 => final_score_tree_20_c337,
    r_d31_mostrec_bk_i >= 1.5                              => -0.0377242276,
                                                              -0.0075224015);

final_score_tree_20_c335 := map(
    NULL < r_p85_phn_invalid_i AND r_p85_phn_invalid_i < 0.5 => final_score_tree_20_c336,
    r_p85_phn_invalid_i >= 0.5                               => 0.1307492114,
                                                                -0.0067056939);

final_score_tree_20 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i < 2.5 => final_score_tree_20_c335,
    f_srchcomponentrisktype_i >= 2.5                                     => 0.0495729742,
                                                                            0.0141900633);

final_score_tree_21_c341 := map(
    NULL < r_s65_ssn_problem_i AND r_s65_ssn_problem_i < 0.5 => 0.0078046919,
    r_s65_ssn_problem_i >= 0.5                               => -0.0425502861,
                                                                0.0050228692);

final_score_tree_21_c343 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d < 10.5 => 0.1655564839,
    f_rel_under500miles_cnt_d >= 10.5                                     => -0.0325718082,
                                                                             0.0622668529);

final_score_tree_21_c342 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d < -44420 => final_score_tree_21_c343,
    f_addrchangevaluediff_d >= -44420                                   => -0.0310604914,
                                                                           -0.0266921452);

final_score_tree_21_c340 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d < 313.5 => final_score_tree_21_c341,
    f_m_bureau_adl_fs_all_d >= 313.5                                   => final_score_tree_21_c342,
                                                                          -0.0044855900);

final_score_tree_21 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i < 2.5 => final_score_tree_21_c340,
    f_inq_communications_count24_i >= 2.5                                          => 0.0394234607,
                                                                                      0.0250230777);

final_score_tree_22_c347 := map(
    NULL < f_crim_rel_under500miles_cnt_i AND f_crim_rel_under500miles_cnt_i < 3.5 => 0.0571443655,
    f_crim_rel_under500miles_cnt_i >= 3.5                                          => 0.0127285064,
                                                                                      0.0815034926);

final_score_tree_22_c346 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => final_score_tree_22_c347,
    f_phone_ver_experian_d >= 0.5                                  => -0.0143895734,
                                                                      0.0256934485);

final_score_tree_22_c345 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d < 3.5 => final_score_tree_22_c346,
    f_phone_ver_insurance_d >= 3.5                                   => -0.0023669805,
                                                                        0.0151046686);

final_score_tree_22_c348 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i < 1.5 => -0.0219817253,
    f_varrisktype_i >= 1.5                           => 0.0091711636,
                                                        -0.0105057920);

final_score_tree_22 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d < 2.5 => final_score_tree_22_c345,
    r_f03_address_match_d >= 2.5                                 => final_score_tree_22_c348,
                                                                    0.0236650007);

final_score_tree_23_c350 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d < 0.5 => 0.0256090139,
    r_e57_br_source_count_d >= 0.5                                   => -0.0052449549,
                                                                        0.0143771457);

final_score_tree_23_c353 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d < 0.5 => 0.1726329388,
    f_rel_under100miles_cnt_d >= 0.5                                     => 0.0291253199,
                                                                            0.0665850293);

final_score_tree_23_c352 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d < 16 => final_score_tree_23_c353,
    r_f01_inp_addr_address_score_d >= 16                                          => -0.0000575765,
                                                                                     0.0175450199);

final_score_tree_23_c351 := map(
    NULL < r_l78_no_phone_at_addr_vel_i AND r_l78_no_phone_at_addr_vel_i < 0.5 => -0.0200786196,
    r_l78_no_phone_at_addr_vel_i >= 0.5                                        => final_score_tree_23_c352,
                                                                                  -0.0168762485);

final_score_tree_23 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d < 549 => final_score_tree_23_c350,
    r_i60_inq_comm_recency_d >= 549                                    => final_score_tree_23_c351,
                                                                          0.0285115838);

final_score_tree_24_c358 := map(
    NULL < r_f01_inp_addr_not_verified_i AND r_f01_inp_addr_not_verified_i < 0.5 => 0.1339419803,
    r_f01_inp_addr_not_verified_i >= 0.5                                         => 0.0190359036,
                                                                                    0.0409725182);

final_score_tree_24_c357 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d < 65 => final_score_tree_24_c358,
    r_f01_inp_addr_address_score_d >= 65                                          => -0.0081540418,
                                                                                     0.0010708158);

final_score_tree_24_c356 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.23887234975 => 0.0539536576,
    f_add_input_mobility_index_i >= 0.23887234975                                        => final_score_tree_24_c357,
                                                                                            0.0170390142);

final_score_tree_24_c355 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.6701266259 => -0.0111566064,
    f_add_input_nhood_mfd_pct_i >= 0.6701266259                                       => final_score_tree_24_c356,
                                                                                         -0.0135818393);

final_score_tree_24 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i < 1.5 => final_score_tree_24_c355,
    f_srchunvrfdphonecount_i >= 1.5                                    => 0.0411482127,
                                                                          0.0198980422);

final_score_tree_25_c363 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d < 1.5 => -0.0072531741,
    f_bus_addr_match_count_d >= 1.5                                    => 0.0298901277,
                                                                          0.0002247915);

final_score_tree_25_c362 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d < 16 => 0.0359723669,
    r_f01_inp_addr_address_score_d >= 16                                          => final_score_tree_25_c363,
                                                                                     0.0036336086);

final_score_tree_25_c361 := map(
    NULL < r_d32_felony_count_i AND r_d32_felony_count_i < 0.5 => final_score_tree_25_c362,
    r_d32_felony_count_i >= 0.5                                => 0.0760554261,
                                                                  0.0062347278);

final_score_tree_25_c360 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d < 554538.5 => final_score_tree_25_c361,
    f_prevaddrmedianvalue_d >= 554538.5                                   => 0.0872234020,
                                                                             0.0557336416);

final_score_tree_25 := map(
    NULL < (integer)k_inf_phn_verd_d AND (real)k_inf_phn_verd_d < 0.5 => final_score_tree_25_c360,
    (real)k_inf_phn_verd_d >= 0.5                            => -0.0236212905,
                                                          -0.0023082018);

final_score_tree_26_c368 := map(
    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i < 4.5 => -0.0155418601,
    f_inq_highriskcredit_count24_i >= 4.5                                          => 0.0504515094,
                                                                                      -0.0126750980);

final_score_tree_26_c367 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 24.5 => 0.0185666436,
    k_comb_age_d >= 24.5                        => final_score_tree_26_c368,
                                                   -0.0088103722);

final_score_tree_26_c366 := map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i < 0.5 => final_score_tree_26_c367,
    r_p85_phn_not_issued_i >= 0.5                                  => 0.1070584415,
                                                                      -0.0082136229);

final_score_tree_26_c365 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 122471.5 => final_score_tree_26_c366,
    f_curraddrmedianincome_d >= 122471.5                                    => 0.1180231445,
                                                                               -0.0072590014);

final_score_tree_26 := map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d < 549 => 0.0273665223,
    r_i60_inq_prepaidcards_recency_d >= 549                                            => final_score_tree_26_c365,
                                                                                          0.0280158913);

final_score_tree_27_c372 := map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i < 35 => 0.0398606448,
    f_liens_rel_cj_total_amt_i >= 35                                      => 0.1798575561,
                                                                             0.0605199112);

final_score_tree_27_c371 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d < 23645 => final_score_tree_27_c372,
    f_prevaddrmedianincome_d >= 23645                                    => 0.0036951303,
                                                                            0.0195762918);

final_score_tree_27_c370 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i < 0.8799548955 => -0.0122661826,
    f_add_curr_nhood_mfd_pct_i >= 0.8799548955                                      => final_score_tree_27_c371,
                                                                                       -0.0027032733);

final_score_tree_27_c373 := map(
    NULL < f_util_add_input_conv_n AND f_util_add_input_conv_n < 0.5 => 0.0906578690,
    f_util_add_input_conv_n >= 0.5                                   => -0.0872584595,
                                                                        0.0008360333);

final_score_tree_27 := map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d < 549 => 0.0275498092,
    r_i60_inq_prepaidcards_recency_d >= 549                                            => final_score_tree_27_c370,
                                                                                          final_score_tree_27_c373);

final_score_tree_28_c376 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i < 21.5 => 0.0219640809,
    r_l79_adls_per_addr_curr_i >= 21.5                                      => 0.1084964133,
                                                                               0.0248154675);

final_score_tree_28_c378 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d < -22792.5 => 0.0462821351,
    f_addrchangeincomediff_d >= -22792.5                                    => -0.0156209112,
                                                                               -0.0073638396);

final_score_tree_28_c377 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i < 1.5 => final_score_tree_28_c378,
    f_srchunvrfdphonecount_i >= 1.5                                    => 0.0278967337,
                                                                          -0.0085163498);

final_score_tree_28_c375 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 25.5 => final_score_tree_28_c376,
    k_comb_age_d >= 25.5                        => final_score_tree_28_c377,
                                                   -0.0036880915);

final_score_tree_28 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 80.5 => final_score_tree_28_c375,
    k_comb_age_d >= 80.5                        => 0.1914307896,
                                                   0.0201258775);

final_score_tree_29_c382 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d < 95 => 0.1074120196,
    r_f00_ssn_score_d >= 95                             => 0.0013801958,
                                                           0.0032898486);

final_score_tree_29_c381 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 23.5 => 0.0630584775,
    k_comb_age_d >= 23.5                        => final_score_tree_29_c382,
                                                   0.0080770754);

final_score_tree_29_c380 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i < 0.5 => -0.0171449260,
    f_inq_other_count24_i >= 0.5                                 => final_score_tree_29_c381,
                                                                    -0.0067916764);

final_score_tree_29_c383 := map(
    NULL < r_i60_inq_recency_d AND r_i60_inq_recency_d < 4.5 => 0.0599120423,
    r_i60_inq_recency_d >= 4.5                               => 0.0126282272,
                                                                0.0237791811);

final_score_tree_29 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d < 333436.5 => final_score_tree_29_c380,
    f_curraddrmedianvalue_d >= 333436.5                                   => final_score_tree_29_c383,
                                                                             0.0037499523);

final_score_tree_30_c386 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.19839064675 => 0.0005114358,
    f_add_input_nhood_bus_pct_i >= 0.19839064675                                       => 0.0682598991,
                                                                                          -0.0092565869);

final_score_tree_30_c385 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i < 1.5 => -0.0260347589,
    r_p88_phn_dst_to_inp_add_i >= 1.5                                      => -0.0007100603,
                                                                              final_score_tree_30_c386);

final_score_tree_30_c388 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i < 51 => 0.0969823674,
    f_fp_prevaddrburglaryindex_i >= 51                                        => 0.0307309731,
                                                                                 0.0464335424);

final_score_tree_30_c387 := map(
    NULL < r_i60_inq_recency_d AND r_i60_inq_recency_d < 4.5 => final_score_tree_30_c388,
    r_i60_inq_recency_d >= 4.5                               => -0.0002321769,
                                                                0.0230937198);

final_score_tree_30 := map(
    NULL < f_srchunvrfdssncount_i AND f_srchunvrfdssncount_i < 0.5 => final_score_tree_30_c385,
    f_srchunvrfdssncount_i >= 0.5                                  => final_score_tree_30_c387,
                                                                      -0.0246401834);

final_score_tree_31_c392 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 75.5 => -0.0168854543,
    k_comb_age_d >= 75.5                        => 0.1254725476,
                                                   -0.0155901214);

final_score_tree_31_c391 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d < 349420.5 => final_score_tree_31_c392,
    f_curraddrmedianvalue_d >= 349420.5                                   => 0.0203163016,
                                                                             -0.0105387306);

final_score_tree_31_c390 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d < 68.5 => 0.0270034252,
    r_d32_mos_since_crim_ls_d >= 68.5                                     => final_score_tree_31_c391,
                                                                             -0.0044774727);

final_score_tree_31_c393 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d < 2.5 => 0.0537552877,
    r_f03_address_match_d >= 2.5                                 => 0.0154743584,
                                                                    0.0282962750);

final_score_tree_31 := map(
    NULL < f_srchunvrfdssncount_i AND f_srchunvrfdssncount_i < 0.5 => final_score_tree_31_c390,
    f_srchunvrfdssncount_i >= 0.5                                  => final_score_tree_31_c393,
                                                                      0.0076277728);

final_score_tree_32_c397 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 50.5 => 0.0392579213,
    k_comb_age_d >= 50.5                        => -0.0251167165,
                                                   0.0235650850);

final_score_tree_32_c396 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i < 2.5 => -0.0075354290,
    f_inq_communications_count24_i >= 2.5                                          => final_score_tree_32_c397,
                                                                                      -0.0056007657);

final_score_tree_32_c395 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i < 1.5 => final_score_tree_32_c396,
    f_srchcomponentrisktype_i >= 1.5                                     => 0.0266015917,
                                                                            0.0227856539);

final_score_tree_32_c398 := map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i < 1.5 => 0.1693363332,
    r_s66_adlperssn_count_i >= 1.5                                   => 0.0275897668,
                                                                        0.0970913090);

final_score_tree_32 := map(
    NULL < r_p85_phn_invalid_i AND r_p85_phn_invalid_i < 0.5 => final_score_tree_32_c395,
    r_p85_phn_invalid_i >= 0.5                               => final_score_tree_32_c398,
                                                                -0.0005129972);

final_score_tree_33_c402 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d < 0.5 => 0.1530790508,
    f_rel_under25miles_cnt_d >= 0.5                                    => 0.0482303054,
                                                                          0.0672905754);

final_score_tree_33_c401 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n < 0.5 => final_score_tree_33_c402,
    r_phn_pcs_n >= 0.5                       => 0.0137673771,
                                                0.0316974384);

final_score_tree_33_c400 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n < 0.5 => final_score_tree_33_c401,
    r_phn_cell_n >= 0.5                        => -0.0046354318,
                                                  0.0083833234);

final_score_tree_33_c403 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d < 4.5 => 0.0308790831,
    r_i60_inq_hiriskcred_recency_d >= 4.5                                          => -0.0225165382,
                                                                                      -0.0164803450);

final_score_tree_33 := map(
    NULL < (integer)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d < 0.5 => final_score_tree_33_c400,
    (real)k_nap_phn_verd_d >= 0.5                            => final_score_tree_33_c403,
                                                          -0.0055266999);

final_score_tree_34_c406 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d < 175.5 => 0.0156574127,
    r_c13_max_lres_d >= 175.5                            => 0.1373994630,
                                                            0.0497981181);

final_score_tree_34_c407 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d < 549 => 0.0122566377,
    r_i60_inq_comm_recency_d >= 549                                    => -0.0083847345,
                                                                          0.0015097871);

final_score_tree_34_c408 := map(
    NULL < r_s65_ssn_problem_i AND r_s65_ssn_problem_i < 0.5 => 0.0668458522,
    r_s65_ssn_problem_i >= 0.5                               => -0.0546786199,
                                                                0.0157892619);

final_score_tree_34_c405 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d < 0.5 => final_score_tree_34_c406,
    f_rel_under100miles_cnt_d >= 0.5                                     => final_score_tree_34_c407,
                                                                            final_score_tree_34_c408);

final_score_tree_34 := map(
    NULL < r_d31_all_bk_i AND r_d31_all_bk_i < 1.5 => final_score_tree_34_c405,
    r_d31_all_bk_i >= 1.5                          => -0.0302800215,
                                                      0.0023535564);

final_score_tree_35_c413 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d < 109930 => 0.0332860220,
    f_prevaddrmedianincome_d >= 109930                                    => 0.1652148852,
                                                                             0.0462433211);

final_score_tree_35_c412 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d < 240712.5 => 0.0068536396,
    r_a46_curr_avm_autoval_d >= 240712.5                                    => final_score_tree_35_c413,
                                                                               0.0016900720);

final_score_tree_35_c411 := map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d < 51.5 => final_score_tree_35_c412,
    f_rel_incomeover25_count_d >= 51.5                                      => 0.1383618584,
                                                                               0.0585111573);

final_score_tree_35_c410 := map(
    NULL < r_s65_ssn_problem_i AND r_s65_ssn_problem_i < 0.5 => final_score_tree_35_c411,
    r_s65_ssn_problem_i >= 0.5                               => -0.0419785412,
                                                                0.0057426336);

final_score_tree_35 := map(
    NULL < r_d31_mostrec_bk_i AND r_d31_mostrec_bk_i < 1.5 => final_score_tree_35_c410,
    r_d31_mostrec_bk_i >= 1.5                              => -0.0276630230,
                                                              0.0223323133);

final_score_tree_36_c416 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i < 1.5 => -0.0186069953,
    f_varrisktype_i >= 1.5                           => 0.0076852846,
                                                        -0.0086096214);

final_score_tree_36_c415 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i < 13.5 => final_score_tree_36_c416,
    f_addrchangecrimediff_i >= 13.5                                   => 0.0300718444,
                                                                         -0.0026000898);

final_score_tree_36_c418 := map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i < 3.5 => 0.0244261689,
    r_i60_inq_comm_count12_i >= 3.5                                    => 0.0959839521,
                                                                          0.0269200194);

final_score_tree_36_c417 := map(
    NULL < r_s65_ssn_problem_i AND r_s65_ssn_problem_i < 0.5 => final_score_tree_36_c418,
    r_s65_ssn_problem_i >= 0.5                               => -0.0415355362,
                                                                0.0204931821);

final_score_tree_36 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i < 7.5 => final_score_tree_36_c415,
    r_l79_adls_per_addr_curr_i >= 7.5                                      => final_score_tree_36_c417,
                                                                              0.0120235779);

final_score_tree_37_c423 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d < 234.5 => 0.0366095422,
    r_c13_max_lres_d >= 234.5                            => 0.1550173777,
                                                            0.0524072839);

final_score_tree_37_c422 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i < 6.5 => -0.0056426992,
    r_p88_phn_dst_to_inp_add_i >= 6.5                                      => 0.0430481488,
                                                                              final_score_tree_37_c423);

final_score_tree_37_c421 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n < 0.5 => final_score_tree_37_c422,
    r_phn_cell_n >= 0.5                        => -0.0199876332,
                                                  -0.0073532164);

final_score_tree_37_c420 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d < 549 => 0.0188687744,
    r_i60_inq_comm_recency_d >= 549                                    => final_score_tree_37_c421,
                                                                          0.0048361526);

final_score_tree_37 := map(
    NULL < f_current_count_d AND f_current_count_d < 1.5 => final_score_tree_37_c420,
    f_current_count_d >= 1.5                             => -0.0135212075,
                                                            -0.0125596766);

final_score_tree_38_c426 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d < 363.5 => 0.0247988384,
    f_prevaddrageoldest_d >= 363.5                                 => 0.1817016394,
                                                                      0.0269736504);

final_score_tree_38_c427 := map(
    NULL < r_c19_add_prison_hist_i AND r_c19_add_prison_hist_i < 0.5 => -0.0018461406,
    r_c19_add_prison_hist_i >= 0.5                                   => 0.1368617370,
                                                                        -0.0006354523);

final_score_tree_38_c425 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i < 66.5 => final_score_tree_38_c426,
    f_fp_prevaddrburglaryindex_i >= 66.5                                        => final_score_tree_38_c427,
                                                                                   0.0083317998);

final_score_tree_38_c428 := map(
    NULL < f_util_add_input_conv_n AND f_util_add_input_conv_n < 0.5 => 0.0880837360,
    f_util_add_input_conv_n >= 0.5                                   => -0.0610547620,
                                                                        0.0012900199);

final_score_tree_38 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d < 3.5 => final_score_tree_38_c425,
    f_phone_ver_insurance_d >= 3.5                                   => -0.0134953698,
                                                                        final_score_tree_38_c428);

final_score_tree_39_c432 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i < 15.5 => 0.0142765821,
    r_l79_adls_per_addr_curr_i >= 15.5                                      => 0.1084864292,
                                                                               0.0186019139);

final_score_tree_39_c431 := map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d < 549 => final_score_tree_39_c432,
    r_i60_inq_prepaidcards_recency_d >= 549                                            => -0.0124693046,
                                                                                          -0.0081823911);

final_score_tree_39_c430 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d < 4.5 => 0.0315931490,
    r_i60_inq_hiriskcred_recency_d >= 4.5                                          => final_score_tree_39_c431,
                                                                                      -0.0044785959);

final_score_tree_39_c433 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d < 8.5 => -0.0010620954,
    f_bus_addr_match_count_d >= 8.5                                    => 0.0591789892,
                                                                          0.0033853173);

final_score_tree_39 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d < 5.5 => final_score_tree_39_c430,
    f_addrchangeincomediff_d >= 5.5                                    => 0.0336501098,
                                                                          final_score_tree_39_c433);

final_score_tree_40_c436 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i < 9.5 => -0.0191379650,
    r_l79_adls_per_addr_curr_i >= 9.5                                      => 0.0220213134,
                                                                              -0.0152883119);

final_score_tree_40_c435 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d < 61.5 => 0.0147896955,
    r_i60_inq_hiriskcred_recency_d >= 61.5                                          => final_score_tree_40_c436,
                                                                                       -0.0321237264);

final_score_tree_40_c438 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.03416911675 => -0.0003647521,
    f_add_input_nhood_bus_pct_i >= 0.03416911675                                       => 0.0316521506,
                                                                                          -0.0353961912);

final_score_tree_40_c437 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d < 95 => 0.0785877064,
    r_f00_ssn_score_d >= 95                             => final_score_tree_40_c438,
                                                           0.0176731222);

final_score_tree_40 := map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i < 0.5 => final_score_tree_40_c435,
    r_l70_add_standardized_i >= 0.5                                    => final_score_tree_40_c437,
                                                                          -0.0022320387);

final_score_tree_41_c441 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d < 25463 => -0.0014182625,
    f_addrchangeincomediff_d >= 25463                                    => 0.0577502909,
                                                                            0.0098277543);

final_score_tree_41_c442 := map(
    NULL < r_d33_eviction_recency_d AND r_d33_eviction_recency_d < 48 => 0.0585768593,
    r_d33_eviction_recency_d >= 48                                    => -0.0296785897,
                                                                         -0.0243107312);

final_score_tree_41_c440 := map(
    NULL < (integer)k_inf_lname_verd_d AND (real)k_inf_lname_verd_d < 0.5 => final_score_tree_41_c441,
    (real)k_inf_lname_verd_d >= 0.5                              => final_score_tree_41_c442,
                                                              -0.0056020242);

final_score_tree_41_c443 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d < 173.5 => 0.0228044052,
    r_c13_curr_addr_lres_d >= 173.5                                  => 0.1254508717,
                                                                        0.0352145313);

final_score_tree_41 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i < 0.5 => final_score_tree_41_c440,
    f_srchunvrfdaddrcount_i >= 0.5                                   => final_score_tree_41_c443,
                                                                        0.0131978567);

final_score_tree_42_c446 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i < 0.5 => 0.0167801054,
    r_f03_input_add_not_most_rec_i >= 0.5                                          => 0.1022854304,
                                                                                      0.0206297427);

final_score_tree_42_c447 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i < 0.9431607484 => -0.0112003273,
    f_add_curr_nhood_mfd_pct_i >= 0.9431607484                                      => 0.0236900609,
                                                                                       -0.0096770303);

final_score_tree_42_c445 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d < 66.5 => final_score_tree_42_c446,
    r_d32_mos_since_crim_ls_d >= 66.5                                     => final_score_tree_42_c447,
                                                                             -0.0041446787);

final_score_tree_42_c448 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d < 21500 => 0.1064085465,
    k_estimated_income_d >= 21500                                => -0.0010674298,
                                                                    0.0059199638);

final_score_tree_42 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d < 323494.5 => final_score_tree_42_c445,
    f_addrchangevaluediff_d >= 323494.5                                   => 0.0961871078,
                                                                             final_score_tree_42_c448);

final_score_tree_43_c452 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i < 0.5 => 0.0378034721,
    f_srchunvrfdaddrcount_i >= 0.5                                   => 0.1971747429,
                                                                        0.0472078885);

final_score_tree_43_c451 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i < 2.5 => -0.0003538935,
    r_d30_derog_count_i >= 2.5                               => final_score_tree_43_c452,
                                                                0.0082271200);

final_score_tree_43_c450 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 30.5 => final_score_tree_43_c451,
    k_comb_age_d >= 30.5                        => -0.0141132900,
                                                   -0.0504457943);

final_score_tree_43_c453 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d < 231.5 => 0.0098925771,
    r_c13_max_lres_d >= 231.5                            => 0.0533144613,
                                                            0.0160161761);

final_score_tree_43 := map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i < 0.5 => final_score_tree_43_c450,
    r_l70_add_standardized_i >= 0.5                                    => final_score_tree_43_c453,
                                                                          -0.0029739446);

final_score_tree_44_c455 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d < 64500 => 0.0171231838,
    k_estimated_income_d >= 64500                                => 0.0819995622,
                                                                    0.0231535724);

final_score_tree_44_c457 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d < 9 => 0.0234081454,
    r_i60_inq_hiriskcred_recency_d >= 9                                          => -0.0101948702,
                                                                                    -0.0057437389);

final_score_tree_44_c458 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d < 82.5 => 0.0079467395,
    f_prevaddrlenofres_d >= 82.5                                => 0.1594758061,
                                                                   0.0839971767);

final_score_tree_44_c456 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 116631 => final_score_tree_44_c457,
    f_curraddrmedianincome_d >= 116631                                    => final_score_tree_44_c458,
                                                                             -0.0046590216);

final_score_tree_44 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d < 23836 => final_score_tree_44_c455,
    f_prevaddrmedianincome_d >= 23836                                    => final_score_tree_44_c456,
                                                                            0.0218229543);

final_score_tree_45_c461 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d < 12.5 => 0.0427526579,
    r_d32_mos_since_crim_ls_d >= 12.5                                     => -0.0112820611,
                                                                             -0.0088738126);

final_score_tree_45_c460 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i < 0.5 => final_score_tree_45_c461,
    r_f03_input_add_not_most_rec_i >= 0.5                                          => 0.0437729056,
                                                                                      -0.0070996257);

final_score_tree_45_c462 := map(
    NULL < f_hh_age_65_plus_d AND f_hh_age_65_plus_d < 0.5 => 0.0364577523,
    f_hh_age_65_plus_d >= 0.5                              => 0.1563421954,
                                                              0.0547347088);

final_score_tree_45_c463 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i < 3.5 => -0.0049642540,
    f_inq_other_count24_i >= 3.5                                 => 0.0686589245,
                                                                    0.0069865694);

final_score_tree_45 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d < 147047.5 => final_score_tree_45_c460,
    f_addrchangevaluediff_d >= 147047.5                                   => final_score_tree_45_c462,
                                                                             final_score_tree_45_c463);

final_score_tree_46_c465 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i < 2.5 => 0.0292954664,
    f_inq_other_count24_i >= 2.5                                 => 0.1623971700,
                                                                    0.0423679551);

final_score_tree_46_c467 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d < 119500 => 0.0026055892,
    k_estimated_income_d >= 119500                                => 0.1376933354,
                                                                     0.0032150187);

final_score_tree_46_c466 := map(
    NULL < r_d31_attr_bankruptcy_recency_d AND r_d31_attr_bankruptcy_recency_d < 9 => final_score_tree_46_c467,
    r_d31_attr_bankruptcy_recency_d >= 9                                           => -0.0227977771,
                                                                                      -0.0029081829);

final_score_tree_46_c468 := map(
    NULL < f_util_add_input_conv_n AND f_util_add_input_conv_n < 0.5 => 0.0702256434,
    f_util_add_input_conv_n >= 0.5                                   => -0.0925619527,
                                                                        -0.0164929826);

final_score_tree_46 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d < 95 => final_score_tree_46_c465,
    r_f00_ssn_score_d >= 95                             => final_score_tree_46_c466,
                                                           final_score_tree_46_c468);

final_score_tree_47_c472 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.0936090226 => 0.0240328762,
    f_add_input_nhood_bus_pct_i >= 0.0936090226                                       => 0.1079872367,
                                                                                         0.0455819925);

final_score_tree_47_c471 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 83913.5 => final_score_tree_47_c472,
    f_curraddrmedianincome_d >= 83913.5                                    => 0.1543009959,
                                                                              0.0567362798);

final_score_tree_47_c470 := map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d < 4.5 => 0.0017691707,
    r_c14_addr_stability_v2_d >= 4.5                                     => final_score_tree_47_c471,
                                                                            0.0287447437);

final_score_tree_47_c473 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i < 44.5 => -0.0028508432,
    r_l79_adls_per_addr_curr_i >= 44.5                                      => 0.1125438095,
                                                                               -0.0025136693);

final_score_tree_47 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d < -12571 => final_score_tree_47_c470,
    f_addrchangevaluediff_d >= -12571                                   => final_score_tree_47_c473,
                                                                           0.0003715644);

final_score_tree_48_c478 := map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d < 8.5 => 0.0179956207,
    f_hh_age_18_plus_d >= 8.5                              => 0.1991888440,
                                                              0.0232397359);

final_score_tree_48_c477 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i < 2.5 => -0.0117447425,
    f_inq_other_count24_i >= 2.5                                 => final_score_tree_48_c478,
                                                                    -0.0075871849);

final_score_tree_48_c476 := map(
    NULL < f_rel_bankrupt_count_i AND f_rel_bankrupt_count_i < 0.5 => 0.0116005353,
    f_rel_bankrupt_count_i >= 0.5                                  => final_score_tree_48_c477,
                                                                      0.0177435432);

final_score_tree_48_c475 := map(
    NULL < r_s65_ssn_problem_i AND r_s65_ssn_problem_i < 0.5 => final_score_tree_48_c476,
    r_s65_ssn_problem_i >= 0.5                               => -0.0427470636,
                                                                -0.0036145094);

final_score_tree_48 := map(
    NULL < r_p85_phn_invalid_i AND r_p85_phn_invalid_i < 0.5 => final_score_tree_48_c475,
    r_p85_phn_invalid_i >= 0.5                               => 0.0789820561,
                                                                -0.0031209309);

final_score_tree_49_c481 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d < 3.5 => 0.0026683558,
    f_phone_ver_insurance_d >= 3.5                                   => -0.0179089878,
                                                                        -0.0076128522);

final_score_tree_49_c482 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d < 297.5 => 0.0832712412,
    r_c21_m_bureau_adl_fs_d >= 297.5                                   => -0.0202304662,
                                                                          0.0429971074);

final_score_tree_49_c480 := map(
    NULL < r_d32_felony_count_i AND r_d32_felony_count_i < 0.5 => final_score_tree_49_c481,
    r_d32_felony_count_i >= 0.5                                => final_score_tree_49_c482,
                                                                  -0.0058769653);

final_score_tree_49_c483 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d < 28.5 => 0.0168362462,
    f_rel_homeover100_count_d >= 28.5                                     => 0.1742101939,
                                                                             0.0091785072);

final_score_tree_49 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i < 1.5 => final_score_tree_49_c480,
    f_srchcomponentrisktype_i >= 1.5                                     => final_score_tree_49_c483,
                                                                            0.0088949948);

final_score_tree_50_c486 := map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i < 12148.5 => -0.0123726135,
    f_liens_unrel_cj_total_amt_i >= 12148.5                                        => 0.0455188698,
                                                                                      -0.0102368488);

final_score_tree_50_c488 := map(
    NULL < r_l77_apartment_i AND r_l77_apartment_i < 0.5 => 0.0220866156,
    r_l77_apartment_i >= 0.5                             => -0.0183538052,
                                                            0.0105807039);

final_score_tree_50_c487 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i < 48.5 => final_score_tree_50_c488,
    f_phones_per_addr_curr_i >= 48.5                                    => 0.0612185272,
                                                                           0.0144544664);

final_score_tree_50_c485 := map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i < 0.5 => final_score_tree_50_c486,
    r_l70_add_standardized_i >= 0.5                                    => final_score_tree_50_c487,
                                                                          -0.0049372072);

final_score_tree_50 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d < 9 => 0.0237886982,
    r_i60_inq_comm_recency_d >= 9                                    => final_score_tree_50_c485,
                                                                        0.0102590016);

final_score_tree_51_c491 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d < 559138 => 0.0204702234,
    f_prevaddrmedianvalue_d >= 559138                                   => 0.1335349940,
                                                                           0.0218578365);

final_score_tree_51_c490 := map(
    NULL < (integer)k_inf_phn_verd_d AND (real)k_inf_phn_verd_d < 0.5 => final_score_tree_51_c491,
    (real)k_inf_phn_verd_d >= 0.5                            => -0.0119334343,
                                                          0.0082788538);

final_score_tree_51_c493 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i < 3.5 => -0.0063897529,
    f_srchunvrfdphonecount_i >= 3.5                                    => 0.0844764292,
                                                                          -0.0058197153);

final_score_tree_51_c492 := map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i < 17034 => final_score_tree_51_c493,
    f_liens_unrel_cj_total_amt_i >= 17034                                        => 0.0721675256,
                                                                                    0.0031058255);

final_score_tree_51 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i < 50585 => final_score_tree_51_c490,
    r_a49_curr_avm_chg_1yr_i >= 50585                                    => 0.0506128405,
                                                                            final_score_tree_51_c492);

final_score_tree_52_c497 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 55 => 0.0750766106,
    r_f01_inp_addr_address_score_d > 55                                          => 0.0049144308,
                                                                                     0.0060960238);

final_score_tree_52_c496 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 3.5 => final_score_tree_52_c497,
    r_c23_inp_addr_occ_index_d > 3.5                                      => -0.0230716172,
                                                                              -0.0214440956);

final_score_tree_52_c498 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 95 => 0.1124137690,
    r_f00_ssn_score_d > 95                             => 0.0224328830,
                                                           0.0262276040);

final_score_tree_52_c495 := map(
    NULL < r_l78_no_phone_at_addr_vel_i AND r_l78_no_phone_at_addr_vel_i <= 0.5 => final_score_tree_52_c496,
    r_l78_no_phone_at_addr_vel_i > 0.5                                        => final_score_tree_52_c498,
                                                                                  0.0050065295);

final_score_tree_52 := map(
    r_d31_bk_chapter_n = '' => final_score_tree_52_c495,
    NULL < (integer)r_d31_bk_chapter_n AND (integer)r_d31_bk_chapter_n <= 9 => -0.0088183691,
    (integer)r_d31_bk_chapter_n > 9                              => -0.0298855612,
                                                            final_score_tree_52_c495);

final_score_tree_53_c502 := map(
    NULL < r_i60_inq_recency_d AND r_i60_inq_recency_d < 4.5 => 0.2688106514,
    r_i60_inq_recency_d >= 4.5                               => 0.0667142097,
                                                                0.1113881600);

final_score_tree_53_c501 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d < 2.5 => 0.0110114382,
    f_bus_addr_match_count_d >= 2.5                                    => final_score_tree_53_c502,
                                                                          0.0236249151);

final_score_tree_53_c503 := map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i < 1.5 => 0.0248415634,
    r_l70_add_standardized_i >= 1.5                                    => 0.1195142366,
                                                                          0.0378323626);

final_score_tree_53_c500 := map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i < 6.5 => -0.0023642207,
    f_crim_rel_under25miles_cnt_i >= 6.5                                         => final_score_tree_53_c501,
                                                                                    final_score_tree_53_c503);

final_score_tree_53 := map(
    NULL < r_s65_ssn_problem_i AND r_s65_ssn_problem_i < 0.5 => final_score_tree_53_c500,
    r_s65_ssn_problem_i >= 0.5                               => -0.0467137411,
                                                                -0.0008976570);

final_score_tree_54_c505 := map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d < 549 => 0.0654202239,
    r_i60_inq_prepaidcards_recency_d >= 549                                            => 0.0113192035,
                                                                                          0.0207121833);

final_score_tree_54_c508 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i < 0.5 => -0.0074039019,
    f_srchunvrfdaddrcount_i >= 0.5                                   => 0.0327564096,
                                                                        -0.0050654236);

final_score_tree_54_c507 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d < 417241 => final_score_tree_54_c508,
    f_addrchangevaluediff_d >= 417241                                   => 0.1064645751,
                                                                           -0.0015479179);

final_score_tree_54_c506 := map(
    NULL < f_srchphonesrchcountmo_i AND f_srchphonesrchcountmo_i < 2.5 => final_score_tree_54_c507,
    f_srchphonesrchcountmo_i >= 2.5                                    => 0.0803017220,
                                                                          -0.0032012107);

final_score_tree_54 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d < 52.5 => final_score_tree_54_c505,
    r_d32_mos_since_crim_ls_d >= 52.5                                     => final_score_tree_54_c506,
                                                                             -0.0128380880);

final_score_tree_55_c513 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i < 2.5 => -0.0053300154,
    r_c14_addrs_5yr_i >= 2.5                             => 0.0994199600,
                                                            0.0425358674);

final_score_tree_55_c512 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i < 0.5 => -0.0138972919,
    r_f03_input_add_not_most_rec_i >= 0.5                                          => final_score_tree_55_c513,
                                                                                      -0.0119516171);

final_score_tree_55_c511 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i < 1.5 => final_score_tree_55_c512,
    r_d32_criminal_count_i >= 1.5                                  => 0.0139973098,
                                                                      -0.0059513737);

final_score_tree_55_c510 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d < 3.5 => final_score_tree_55_c511,
    f_addrchangeecontrajindex_d >= 3.5                                       => 0.0212509799,
                                                                                -0.0012174374);

final_score_tree_55 := map(
    NULL < f_srchaddrsrchcountwk_i AND f_srchaddrsrchcountwk_i < 0.5 => final_score_tree_55_c510,
    f_srchaddrsrchcountwk_i >= 0.5                                   => 0.0404263455,
                                                                        0.0456080651);

final_score_tree_56_c517 := map(
    NULL < f_divssnidmsrcurelcount_i AND f_divssnidmsrcurelcount_i < 2.5 => 0.0001838796,
    f_divssnidmsrcurelcount_i >= 2.5                                     => 0.0796025511,
                                                                            0.0020228657);

final_score_tree_56_c516 := map(
    NULL < f_srchaddrsrchcountwk_i AND f_srchaddrsrchcountwk_i < 0.5 => final_score_tree_56_c517,
    f_srchaddrsrchcountwk_i >= 0.5                                   => 0.0556252378,
                                                                        0.0041907054);

final_score_tree_56_c518 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d < 203108 => -0.0156460905,
    f_addrchangevaluediff_d >= 203108                                   => 0.1346005250,
                                                                           -0.0127238662);

final_score_tree_56_c515 := map(
    NULL < f_current_count_d AND f_current_count_d < 1.5 => final_score_tree_56_c516,
    f_current_count_d >= 1.5                             => final_score_tree_56_c518,
                                                            -0.0036954112);

final_score_tree_56 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 83.5 => final_score_tree_56_c515,
    k_comb_age_d >= 83.5                        => 0.1357074991,
                                                   -0.0345253572);

final_score_tree_57_c520 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d < 135181.5 => 0.0750919420,
    r_l80_inp_avm_autoval_d >= 135181.5                                   => 0.1976831719,
                                                                             0.0155587884);

final_score_tree_57_c523 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i < 0.5 => 0.0804480645,
    f_phones_per_addr_curr_i >= 0.5                                    => 0.0184871552,
                                                                          0.0344770673);

final_score_tree_57_c522 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.03013116295 => -0.0071000961,
    f_add_input_nhood_bus_pct_i >= 0.03013116295                                       => final_score_tree_57_c523,
                                                                                          -0.0169658865);

final_score_tree_57_c521 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i < 3.5 => -0.0035842211,
    f_idverrisktype_i >= 3.5                             => final_score_tree_57_c522,
                                                            -0.0015149005);

final_score_tree_57 := map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d < 196.5 => final_score_tree_57_c520,
    r_d32_mos_since_fel_ls_d >= 196.5                                    => final_score_tree_57_c521,
                                                                            -0.0041964443);

final_score_tree_58_c525 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i < 1.5 => -0.0143652123,
    f_varrisktype_i >= 1.5                           => 0.0152795111,
                                                        -0.0029938771);

final_score_tree_58_c526 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 24448.5 => 0.1133968669,
    f_curraddrmedianincome_d >= 24448.5                                    => 0.0268745250,
                                                                              0.0309269704);

final_score_tree_58_c528 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i < 0.5 => 0.0133466913,
    f_phones_per_addr_curr_i >= 0.5                                    => -0.0090265142,
                                                                          -0.0059100735);

final_score_tree_58_c527 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d < 4.5 => 0.0763233659,
    r_d32_mos_since_crim_ls_d >= 4.5                                     => final_score_tree_58_c528,
                                                                            0.0435114394);

final_score_tree_58 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d < 260582 => final_score_tree_58_c525,
    r_l80_inp_avm_autoval_d >= 260582                                   => final_score_tree_58_c526,
                                                                           final_score_tree_58_c527);

final_score_tree_59_c530 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d < 323.5 => 0.0148831100,
    r_c10_m_hdr_fs_d >= 323.5                            => -0.0133227119,
                                                            0.0085274535);

final_score_tree_59_c533 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d < 215.5 => 0.0217838196,
    f_prevaddrageoldest_d >= 215.5                                 => 0.1149065719,
                                                                      0.0333652086);

final_score_tree_59_c532 := map(
    NULL < (integer)k_nap_phn_verd_d AND (real)k_nap_phn_verd_d < 0.5 => final_score_tree_59_c533,
    (real)k_nap_phn_verd_d >= 0.5                            => -0.0116018476,
                                                          0.0052988417);

final_score_tree_59_c531 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n < 0.5 => final_score_tree_59_c532,
    r_phn_cell_n >= 0.5                        => -0.0215582035,
                                                  -0.0120265934);

final_score_tree_59 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d < 549 => final_score_tree_59_c530,
    r_i60_inq_comm_recency_d >= 549                                    => final_score_tree_59_c531,
                                                                          -0.0070334372);

final_score_tree_60_c535 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.03681236675 => -0.0061916088,
    f_add_input_nhood_bus_pct_i >= 0.03681236675                                       => 0.1890219540,
                                                                                          0.1004143794);

final_score_tree_60_c537 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i < 0.5 => -0.0093763785,
    f_inq_other_count24_i >= 0.5                                 => 0.0080128214,
                                                                    -0.0022220429);

final_score_tree_60_c538 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d < 229.5 => 0.0225774064,
    r_c13_max_lres_d >= 229.5                            => 0.1740553490,
                                                            0.0508190567);

final_score_tree_60_c536 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d < 98500 => final_score_tree_60_c537,
    k_estimated_income_d >= 98500                                => final_score_tree_60_c538,
                                                                    -0.0010821358);

final_score_tree_60 := map(
    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d < 79.5 => final_score_tree_60_c535,
    f_attr_arrest_recency_d >= 79.5                                   => final_score_tree_60_c536,
                                                                         0.0050028213);

final_score_tree_61_c543 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 61.5 => -0.0098026296,
    k_comb_age_d >= 61.5                        => 0.1655878712,
                                                   0.0307727848);

final_score_tree_61_c542 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i < 26.5 => -0.0024566218,
    r_p88_phn_dst_to_inp_add_i >= 26.5                                      => 0.2075390528,
                                                                               final_score_tree_61_c543);

final_score_tree_61_c541 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i < 14.5 => final_score_tree_61_c542,
    f_addrchangecrimediff_i >= 14.5                                   => 0.1459217170,
                                                                         0.0148971118);

final_score_tree_61_c540 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d < 217.5 => -0.0068549969,
    r_c13_curr_addr_lres_d >= 217.5                                  => final_score_tree_61_c541,
                                                                        -0.0043878805);

final_score_tree_61 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i < 1.5 => final_score_tree_61_c540,
    f_inq_other_count24_i >= 1.5                                 => 0.0164088396,
                                                                    -0.0278387683);

final_score_tree_62_c546 := map(
    NULL < f_util_add_curr_inf_n AND f_util_add_curr_inf_n < 0.5 => 0.0044140486,
    f_util_add_curr_inf_n >= 0.5                                 => 0.0436685589,
                                                                    0.0068218578);

final_score_tree_62_c545 := map(
    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d < 79.5 => 0.1129423144,
    f_attr_arrest_recency_d >= 79.5                                   => final_score_tree_62_c546,
                                                                         0.0074508585);

final_score_tree_62_c548 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d < 106937.5 => 0.0496263825,
    r_l80_inp_avm_autoval_d >= 106937.5                                   => -0.0199236800,
                                                                             -0.0359077561);

final_score_tree_62_c547 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d < -18198.5 => 0.0358555257,
    f_addrchangevaluediff_d >= -18198.5                                   => -0.0187705591,
                                                                             final_score_tree_62_c548);

final_score_tree_62 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d < 278.5 => final_score_tree_62_c545,
    f_m_bureau_adl_fs_notu_d >= 278.5                                    => final_score_tree_62_c547,
                                                                            0.0077982825);

final_score_tree_63_c551 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i < 0.66265449505 => -0.0321521592,
    f_add_curr_nhood_mfd_pct_i >= 0.66265449505                                      => 0.1259536950,
                                                                                        -0.0030654351);

final_score_tree_63_c550 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d < 3.5 => 0.0500372025,
    f_phone_ver_insurance_d >= 3.5                                   => final_score_tree_63_c551,
                                                                        0.0248771625);

final_score_tree_63_c553 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i < 88.5 => 0.0326608582,
    f_curraddrburglaryindex_i >= 88.5                                     => -0.0002551576,
                                                                             0.0064307392);

final_score_tree_63_c552 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i < 141 => -0.0123375288,
    f_curraddrmurderindex_i >= 141                                   => final_score_tree_63_c553,
                                                                        -0.0112171447);

final_score_tree_63 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d < 268120.5 => 0.0011683840,
    r_a46_curr_avm_autoval_d >= 268120.5                                    => final_score_tree_63_c550,
                                                                               final_score_tree_63_c552);

final_score_tree_64_c558 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i < 0.00121216575 => -0.0166637906,
    f_add_input_nhood_vac_pct_i >= 0.00121216575                                       => 0.0077916828,
                                                                                          0.0030243431);

final_score_tree_64_c557 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i < 0.5 => final_score_tree_64_c558,
    r_p85_phn_disconnected_i >= 0.5                                    => 0.0817388381,
                                                                          0.0042287690);

final_score_tree_64_c556 := map(
    NULL < r_i60_inq_auto_recency_d AND r_i60_inq_auto_recency_d < 549 => -0.0134053158,
    r_i60_inq_auto_recency_d >= 549                                    => final_score_tree_64_c557,
                                                                          -0.0035179075);

final_score_tree_64_c555 := map(
    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i < 6.5 => final_score_tree_64_c556,
    f_inq_highriskcredit_count24_i >= 6.5                                          => 0.0394111964,
                                                                                      -0.0023456929);

final_score_tree_64 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 78.5 => final_score_tree_64_c555,
    k_comb_age_d >= 78.5                        => 0.0993037373,
                                                   -0.0228889153);

final_score_tree_65_c561 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i < 197.5 => 0.0005217881,
    f_curraddrmurderindex_i >= 197.5                                   => 0.0674456980,
                                                                          0.0017859680);

final_score_tree_65_c562 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i < 43 => 0.1105147737,
    f_fp_prevaddrcrimeindex_i >= 43                                     => 0.0255835837,
                                                                           0.0373044486);

final_score_tree_65_c560 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i < 2.5 => final_score_tree_65_c561,
    r_d30_derog_count_i >= 2.5                               => final_score_tree_65_c562,
                                                                0.0085198487);

final_score_tree_65_c563 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.04696514745 => -0.0957034659,
    f_add_input_nhood_bus_pct_i >= 0.04696514745                                       => -0.0087398770,
                                                                                          -0.0522216714);

final_score_tree_65 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 31.5 => final_score_tree_65_c560,
    k_comb_age_d >= 31.5                        => -0.0078609475,
                                                   final_score_tree_65_c563);

final_score_tree_66_c567 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 27.5 => 0.0248195921,
    k_comb_age_d >= 27.5                        => -0.0002703123,
                                                   0.0074450641);

final_score_tree_66_c568 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d < 5.5 => -0.0091095100,
    r_wealth_index_d >= 5.5                            => 0.1208792558,
                                                          -0.0082393572);

final_score_tree_66_c566 := map(
    NULL < f_historical_count_d AND f_historical_count_d < 0.5 => final_score_tree_66_c567,
    f_historical_count_d >= 0.5                                => final_score_tree_66_c568,
                                                                  -0.0022702881);

final_score_tree_66_c565 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i < 49.5 => final_score_tree_66_c566,
    r_l79_adls_per_addr_curr_i >= 49.5                                      => 0.1036212086,
                                                                               -0.0020317254);

final_score_tree_66 := map(
    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d < 99.5 => 0.0643318706,
    f_attr_arrest_recency_d >= 99.5                                   => final_score_tree_66_c565,
                                                                         -0.0228905924);

final_score_tree_67_c572 := map(
    NULL < f_srchphonesrchcountmo_i AND f_srchphonesrchcountmo_i < 0.5 => -0.0047260237,
    f_srchphonesrchcountmo_i >= 0.5                                    => 0.0536136137,
                                                                          -0.0020720006);

final_score_tree_67_c571 := map(
    NULL < f_inq_auto_count24_i AND f_inq_auto_count24_i < 1.5 => final_score_tree_67_c572,
    f_inq_auto_count24_i >= 1.5                                => -0.0311078364,
                                                                  -0.0067979996);

final_score_tree_67_c570 := map(
    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i < 0.5 => final_score_tree_67_c571,
    f_inq_highriskcredit_count24_i >= 0.5                                          => 0.0106253071,
                                                                                      -0.0024488736);

final_score_tree_67_c573 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i < 0.0879017013 => 0.2074966157,
    f_add_curr_nhood_mfd_pct_i >= 0.0879017013                                      => 0.0059347265,
                                                                                       0.0874826664);

final_score_tree_67 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i < 25.5 => final_score_tree_67_c570,
    r_d32_criminal_count_i >= 25.5                                  => final_score_tree_67_c573,
                                                                       0.0178461294);

final_score_tree_68_c578 := map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d < 4.5 => 0.1306793208,
    f_rel_incomeover25_count_d >= 4.5                                      => 0.0252784785,
                                                                              0.0506569893);

final_score_tree_68_c577 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 68.5 => -0.0049555390,
    k_comb_age_d >= 68.5                        => final_score_tree_68_c578,
                                                   -0.0034435505);

final_score_tree_68_c576 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i < 3.5 => final_score_tree_68_c577,
    f_inq_count24_i >= 3.5                           => 0.0171645511,
                                                        0.0004275793);

final_score_tree_68_c575 := map(
    NULL < f_inq_auto_count24_i AND f_inq_auto_count24_i < 2.5 => final_score_tree_68_c576,
    f_inq_auto_count24_i >= 2.5                                => -0.0242057743,
                                                                  -0.0027601611);

final_score_tree_68 := map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d < 13.5 => final_score_tree_68_c575,
    f_hh_age_18_plus_d >= 13.5                              => 0.1020617845,
                                                               -0.0314842359);

final_score_tree_69_c582 := map(
    NULL < r_c14_addrs_15yr_i AND r_c14_addrs_15yr_i < 15.5 => 0.0018661066,
    r_c14_addrs_15yr_i >= 15.5                              => 0.1327635860,
                                                               0.0023687739);

final_score_tree_69_c583 := map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i < 63.5 => 0.1337792262,
    f_prevaddrmurderindex_i >= 63.5                                   => 0.0079780985,
                                                                         0.0281502910);

final_score_tree_69_c581 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d < 0.5 => 0.0591307776,
    f_rel_under500miles_cnt_d >= 0.5                                     => final_score_tree_69_c582,
                                                                            final_score_tree_69_c583);

final_score_tree_69_c580 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d < 19.5 => -0.0134709851,
    f_prevaddrageoldest_d >= 19.5                                 => final_score_tree_69_c581,
                                                                     -0.0008981315);

final_score_tree_69 := map(
    NULL < r_i60_inq_prepaidcards_count12_i AND r_i60_inq_prepaidcards_count12_i < 0.5 => final_score_tree_69_c580,
    r_i60_inq_prepaidcards_count12_i >= 0.5                                            => 0.1341511402,
                                                                                          0.0074764497);

final_score_tree_70_c587 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i < 0.3627752384 => 0.0310107042,
    f_add_curr_mobility_index_i >= 0.3627752384                                       => 0.1009980138,
                                                                                         0.0417039524);

final_score_tree_70_c586 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d < 176.5 => final_score_tree_70_c587,
    r_c21_m_bureau_adl_fs_d >= 176.5                                   => 0.0051967275,
                                                                          0.0174625558);

final_score_tree_70_c585 := map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d < 4.5 => -0.0050659348,
    f_hh_age_18_plus_d >= 4.5                              => final_score_tree_70_c586,
                                                              -0.0009317707);

final_score_tree_70_c588 := map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i < 67.5 => 0.0291756750,
    f_liens_rel_cj_total_amt_i >= 67.5                                      => 0.1346421491,
                                                                               0.0413784075);

final_score_tree_70 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i < 0.98904931445 => final_score_tree_70_c585,
    f_add_curr_nhood_mfd_pct_i >= 0.98904931445                                      => final_score_tree_70_c588,
                                                                                        0.0057667218);

final_score_tree_71_c590 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d < 305.5 => 0.0495164784,
    f_m_bureau_adl_fs_notu_d >= 305.5                                    => -0.0212904643,
                                                                            0.0297065965);

final_score_tree_71_c592 := map(
    NULL < r_i60_inq_prepaidcards_count12_i AND r_i60_inq_prepaidcards_count12_i < 0.5 => -0.0002307476,
    r_i60_inq_prepaidcards_count12_i >= 0.5                                            => 0.1163764889,
                                                                                          0.0001097038);

final_score_tree_71_c591 := map(
    NULL < f_mos_liens_unrel_st_lseen_d AND f_mos_liens_unrel_st_lseen_d < 72.5 => -0.0417742010,
    f_mos_liens_unrel_st_lseen_d >= 72.5                                        => final_score_tree_71_c592,
                                                                                   -0.0016769586);

final_score_tree_71_c593 := map(
    NULL < f_util_add_input_conv_n AND f_util_add_input_conv_n < 0.5 => 0.0961894300,
    f_util_add_input_conv_n >= 0.5                                   => -0.0527433650,
                                                                        0.0197104272);

final_score_tree_71 := map(
    NULL < r_d33_eviction_recency_d AND r_d33_eviction_recency_d < 48 => final_score_tree_71_c590,
    r_d33_eviction_recency_d >= 48                                    => final_score_tree_71_c591,
                                                                         final_score_tree_71_c593);

final_score_tree_72_c597 := map(
    NULL < k_inq_dobs_per_ssn_i AND k_inq_dobs_per_ssn_i < 0.5 => 0.0328562552,
    k_inq_dobs_per_ssn_i >= 0.5                                => -0.0546769480,
                                                                  0.0043190857);

final_score_tree_72_c598 := map(
    NULL < f_hh_tot_derog_i AND f_hh_tot_derog_i < 1.5 => 0.1675713896,
    f_hh_tot_derog_i >= 1.5                            => 0.0406543506,
                                                          0.0967741297);

final_score_tree_72_c596 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 78378.5 => final_score_tree_72_c597,
    f_curraddrmedianincome_d >= 78378.5                                    => final_score_tree_72_c598,
                                                                              0.0171649189);

final_score_tree_72_c595 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d < 147.5 => -0.0220673449,
    f_prevaddrageoldest_d >= 147.5                                 => final_score_tree_72_c596,
                                                                      -0.0165263310);

final_score_tree_72 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d < 4.5 => final_score_tree_72_c595,
    f_rel_under25miles_cnt_d >= 4.5                                    => 0.0011313887,
                                                                          0.0016033764);

final_score_tree_73_c603 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i < 12.5 => -0.0079134541,
    r_d30_derog_count_i >= 12.5                               => 0.0347421466,
                                                                 -0.0045372481);

final_score_tree_73_c602 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d < 45 => 0.0563376438,
    r_f01_inp_addr_address_score_d >= 45                                          => final_score_tree_73_c603,
                                                                                     -0.0035818203);

final_score_tree_73_c601 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d < -42474 => 0.1235698843,
    f_addrchangeincomediff_d >= -42474                                    => final_score_tree_73_c602,
                                                                             0.0147579190);

final_score_tree_73_c600 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d < 3.5 => final_score_tree_73_c601,
    r_c23_inp_addr_occ_index_d >= 3.5                                      => -0.0175795057,
                                                                              -0.0016764204);

final_score_tree_73 := map(
    NULL < f_srchssnsrchcountmo_i AND f_srchssnsrchcountmo_i < 4.5 => final_score_tree_73_c600,
    f_srchssnsrchcountmo_i >= 4.5                                  => 0.0972044295,
                                                                      0.0135969131);

final_score_tree_74_c606 := map(
    NULL < f_rel_felony_count_i AND f_rel_felony_count_i < 0.5 => 0.0186501445,
    f_rel_felony_count_i >= 0.5                                => 0.1158571017,
                                                                  0.0367286916);

final_score_tree_74_c605 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d < 95 => final_score_tree_74_c606,
    r_f00_ssn_score_d >= 95                             => -0.0019621538,
                                                           -0.0008373451);

final_score_tree_74_c608 := map(
    NULL < f_rel_felony_count_i AND f_rel_felony_count_i < 0.5 => 0.1815436599,
    f_rel_felony_count_i >= 0.5                                => 0.0461443789,
                                                                  0.1102808804);

final_score_tree_74_c607 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d < 549 => 0.0199437383,
    r_i61_inq_collection_recency_d >= 549                                          => final_score_tree_74_c608,
                                                                                      0.0369800232);

final_score_tree_74 := map(
    NULL < r_d32_felony_count_i AND r_d32_felony_count_i < 0.5 => final_score_tree_74_c605,
    r_d32_felony_count_i >= 0.5                                => final_score_tree_74_c607,
                                                                  0.0033848451);

final_score_tree_75_c610 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d < 95 => 0.0326606929,
    r_f00_ssn_score_d >= 95                             => -0.0017191842,
                                                           -0.0006730176);

final_score_tree_75_c613 := map(
    NULL < f_hh_members_ct_d AND f_hh_members_ct_d < 3.5 => 0.2051638213,
    f_hh_members_ct_d >= 3.5                             => 0.0548173582,
                                                            0.1292312642);

final_score_tree_75_c612 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d < 6.5 => 0.0114907021,
    f_rel_under25miles_cnt_d >= 6.5                                    => final_score_tree_75_c613,
                                                                          0.0836660312);

final_score_tree_75_c611 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.01402881645 => -0.0627269830,
    f_add_input_nhood_bus_pct_i >= 0.01402881645                                       => final_score_tree_75_c612,
                                                                                          0.0507451141);

final_score_tree_75 := map(
    NULL < f_attr_arrests_i AND f_attr_arrests_i < 0.5 => final_score_tree_75_c610,
    f_attr_arrests_i >= 0.5                            => final_score_tree_75_c611,
                                                          0.0067589961);

final_score_tree_76_c617 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d < 491.5 => -0.0059199898,
    f_addrchangeincomediff_d >= 491.5                                    => 0.0227053050,
                                                                            -0.0076385804);

final_score_tree_76_c616 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 25.5 => 0.0158713806,
    k_comb_age_d >= 25.5                        => final_score_tree_76_c617,
                                                   0.0302840763);

final_score_tree_76_c615 := map(
    NULL < r_s65_ssn_invalid_i AND r_s65_ssn_invalid_i < 0.5 => final_score_tree_76_c616,
    r_s65_ssn_invalid_i >= 0.5                               => -0.0619847460,
                                                                -0.0018909735);

final_score_tree_76_c618 := map(
    NULL < f_inq_collection_count24_i AND f_inq_collection_count24_i < 0.5 => 0.1727330946,
    f_inq_collection_count24_i >= 0.5                                      => 0.0051737784,
                                                                              0.0856022502);

final_score_tree_76 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i < 18.5 => final_score_tree_76_c615,
    k_inq_per_ssn_i >= 18.5                           => final_score_tree_76_c618,
                                                         -0.0014526834);

final_score_tree_77_c622 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d < 2.5 => -0.0010950334,
    f_bus_addr_match_count_d >= 2.5                                    => 0.0183946696,
                                                                          0.0018532205);

final_score_tree_77_c621 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d < 7.5 => 0.0508012750,
    r_d32_mos_since_crim_ls_d >= 7.5                                     => final_score_tree_77_c622,
                                                                            0.0274350544);

final_score_tree_77_c623 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i < 7.5 => 0.0237880376,
    r_p88_phn_dst_to_inp_add_i >= 7.5                                      => 0.1384574511,
                                                                              0.0569316887);

final_score_tree_77_c620 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i < 0.5 => final_score_tree_77_c621,
    r_p85_phn_disconnected_i >= 0.5                                    => final_score_tree_77_c623,
                                                                          0.0042477635);

final_score_tree_77 := map(
    NULL < (integer)k_inf_lname_verd_d AND (real)k_inf_lname_verd_d < 0.5 => final_score_tree_77_c620,
    (real)k_inf_lname_verd_d >= 0.5                              => -0.0172940544,
                                                              -0.0018427877);

final_score_tree_78_c628 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => 0.1125809671,
    f_phone_ver_experian_d >= 0.5                                  => 0.0189687210,
                                                                      0.0835141510);

final_score_tree_78_c627 := map(
    NULL < f_rel_ageover20_count_d AND f_rel_ageover20_count_d < 5.5 => -0.0727560713,
    f_rel_ageover20_count_d >= 5.5                                   => final_score_tree_78_c628,
                                                                        0.0497983154);

final_score_tree_78_c626 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i < 1.5 => -0.0112115674,
    f_validationrisktype_i >= 1.5                                  => final_score_tree_78_c627,
                                                                      -0.0098835562);

final_score_tree_78_c625 := map(
    NULL < f_current_count_d AND f_current_count_d < 0.5 => 0.0049059559,
    f_current_count_d >= 0.5                             => final_score_tree_78_c626,
                                                            -0.0041247403);

final_score_tree_78 := map(
    NULL < k_inq_adls_per_addr_i AND k_inq_adls_per_addr_i < 9.5 => final_score_tree_78_c625,
    k_inq_adls_per_addr_i >= 9.5                                 => 0.0841860566,
                                                                    -0.0031714090);

final_score_tree_79_c632 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d < 2.5 => -0.0472338789,
    f_rel_ageover40_count_d >= 2.5                                   => 0.0611003367,
                                                                        -0.0005579669);

final_score_tree_79_c631 := map(
    NULL < f_curraddrcrimeindex_i AND f_curraddrcrimeindex_i < 136 => final_score_tree_79_c632,
    f_curraddrcrimeindex_i >= 136                                  => 0.0540385046,
                                                                      0.0275202185);

final_score_tree_79_c630 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i < 3.5 => -0.0040220659,
    f_inq_communications_count24_i >= 3.5                                          => final_score_tree_79_c631,
                                                                                      -0.0027633766);

final_score_tree_79_c633 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i < 26.5 => 0.0153941068,
    f_addrchangecrimediff_i >= 26.5                                   => 0.0882042245,
                                                                         0.0136508519);

final_score_tree_79 := map(
    NULL < f_hh_age_65_plus_d AND f_hh_age_65_plus_d < 0.5 => final_score_tree_79_c630,
    f_hh_age_65_plus_d >= 0.5                              => final_score_tree_79_c633,
                                                              0.0056684323);

final_score_tree_80_c635 := map(
    NULL < r_f04_curr_add_occ_index_d AND r_f04_curr_add_occ_index_d < 0.5 => 0.1178558622,
    r_f04_curr_add_occ_index_d >= 0.5                                      => -0.0034323070,
                                                                              -0.0031729003);

final_score_tree_80_c638 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i < 1.5 => 0.2535848466,
    k_inq_lnames_per_addr_i >= 1.5                                   => 0.0273102851,
                                                                        0.1643963333);

final_score_tree_80_c637 := map(
    NULL < f_divrisktype_i AND f_divrisktype_i < 1.5 => 0.0447357825,
    f_divrisktype_i >= 1.5                           => final_score_tree_80_c638,
                                                        0.0842381812);

final_score_tree_80_c636 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d < 123131 => final_score_tree_80_c637,
    r_l80_inp_avm_autoval_d >= 123131                                   => 0.0048615792,
                                                                           0.0137626114);

final_score_tree_80 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i < 14.5 => final_score_tree_80_c635,
    r_d30_derog_count_i >= 14.5                               => final_score_tree_80_c636,
                                                                 -0.0055102256);

final_score_tree_81_c642 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d < 21500 => 0.1098189917,
    k_estimated_income_d >= 21500                                => -0.0105344076,
                                                                    -0.0079666476);

final_score_tree_81_c641 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d < 21119 => 0.1048073185,
    r_l80_inp_avm_autoval_d >= 21119                                   => -0.0064103614,
                                                                          final_score_tree_81_c642);

final_score_tree_81_c643 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i < 3.5 => 0.1328658559,
    k_inq_per_ssn_i >= 3.5                           => 0.0160310657,
                                                        0.0577577765);

final_score_tree_81_c640 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i < 3.5 => final_score_tree_81_c641,
    f_inq_other_count24_i >= 3.5                                 => final_score_tree_81_c643,
                                                                    0.0057587450);

final_score_tree_81 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d < -18480.5 => 0.0271911651,
    f_addrchangevaluediff_d >= -18480.5                                   => -0.0052011277,
                                                                             final_score_tree_81_c640);

final_score_tree_82_c646 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.03467223855 => 0.2168524186,
    f_add_input_nhood_bus_pct_i >= 0.03467223855                                       => 0.0666452838,
                                                                                          0.1417488512);

final_score_tree_82_c645 := map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i < 14527 => 0.0166092146,
    f_liens_unrel_cj_total_amt_i >= 14527                                        => final_score_tree_82_c646,
                                                                                    0.0218551985);

final_score_tree_82_c648 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d < 34829 => -0.0041009545,
    f_addrchangeincomediff_d >= 34829                                    => 0.0521107697,
                                                                            0.0015802843);

final_score_tree_82_c647 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i < 112.5 => final_score_tree_82_c648,
    f_phones_per_addr_curr_i >= 112.5                                    => 0.0850271976,
                                                                            -0.0020790572);

final_score_tree_82 := map(
    NULL < r_d33_eviction_recency_d AND r_d33_eviction_recency_d < 79.5 => final_score_tree_82_c645,
    r_d33_eviction_recency_d >= 79.5                                    => final_score_tree_82_c647,
                                                                           -0.0136699798);

final_score_tree_83_c650 := map(
    NULL < f_rel_educationover8_count_d AND f_rel_educationover8_count_d < 45.5 => -0.0099662178,
    f_rel_educationover8_count_d >= 45.5                                        => 0.0876645237,
                                                                                   -0.0086737988);

final_score_tree_83_c653 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d < 0.99961089495 => 0.0088740690,
    f_add_input_nhood_sfd_pct_d >= 0.99961089495                                       => 0.1455504582,
                                                                                          0.0101104609);

final_score_tree_83_c652 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i < 1.5 => -0.0177238083,
    f_srchvelocityrisktype_i >= 1.5                                    => final_score_tree_83_c653,
                                                                          0.0049725139);

final_score_tree_83_c651 := map(
    NULL < f_srchaddrsrchcountmo_i AND f_srchaddrsrchcountmo_i < 4.5 => final_score_tree_83_c652,
    f_srchaddrsrchcountmo_i >= 4.5                                   => 0.1349141412,
                                                                        0.0056421703);

final_score_tree_83 := map(
    NULL < r_i60_inq_auto_recency_d AND r_i60_inq_auto_recency_d < 549 => final_score_tree_83_c650,
    r_i60_inq_auto_recency_d >= 549                                    => final_score_tree_83_c651,
                                                                          -0.0064007095);

final_score_tree_84_c658 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d < 241.5 => -0.0328799148,
    r_c13_curr_addr_lres_d >= 241.5                                  => 0.1261881603,
                                                                        -0.0276069400);

final_score_tree_84_c657 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d < 0.1410158693 => final_score_tree_84_c658,
    f_add_input_nhood_sfd_pct_d >= 0.1410158693                                       => -0.0026411601,
                                                                                         -0.0053195884);

final_score_tree_84_c656 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i < 78 => 0.0089621713,
    f_curraddrburglaryindex_i >= 78                                     => final_score_tree_84_c657,
                                                                           -0.0001318797);

final_score_tree_84_c655 := map(
    NULL < f_hh_criminals_i AND f_hh_criminals_i < 3.5 => final_score_tree_84_c656,
    f_hh_criminals_i >= 3.5                            => 0.0403939076,
                                                          0.0013330064);

final_score_tree_84 := map(
    NULL < f_inq_prepaidcards_count24_i AND f_inq_prepaidcards_count24_i < 1.5 => final_score_tree_84_c655,
    f_inq_prepaidcards_count24_i >= 1.5                                        => 0.0897152669,
                                                                                  0.0020336397);

final_score_tree_85_c662 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d < 109672 => 0.0075831688,
    f_prevaddrmedianvalue_d >= 109672                                   => 0.0476043391,
                                                                           0.0173869573);

final_score_tree_85_c663 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 15406 => -0.0758047199,
    f_curraddrmedianincome_d >= 15406                                    => -0.0015378972,
                                                                            -0.0021013058);

final_score_tree_85_c661 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d < 23624 => final_score_tree_85_c662,
    f_prevaddrmedianincome_d >= 23624                                    => final_score_tree_85_c663,
                                                                            -0.0000033922);

final_score_tree_85_c660 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.4721822927 => final_score_tree_85_c661,
    f_add_input_mobility_index_i >= 0.4721822927                                        => -0.0216309146,
                                                                                           -0.0419410007);

final_score_tree_85 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d < 689758 => final_score_tree_85_c660,
    f_curraddrmedianvalue_d >= 689758                                   => 0.0685358599,
                                                                           -0.0278874030);

final_score_tree_86_c666 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.00240250725 => 0.0946046474,
    f_add_input_nhood_bus_pct_i >= 0.00240250725                                       => 0.0213819984,
                                                                                          0.0929583722);

final_score_tree_86_c668 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d < 3.5 => 0.1454800899,
    f_rel_ageover30_count_d >= 3.5                                   => 0.0330020027,
                                                                        0.0417598385);

final_score_tree_86_c667 := map(
    NULL < r_d32_felony_count_i AND r_d32_felony_count_i < 0.5 => -0.0026610051,
    r_d32_felony_count_i >= 0.5                                => final_score_tree_86_c668,
                                                                  -0.0001969252);

final_score_tree_86_c665 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 31.5 => final_score_tree_86_c666,
    k_comb_age_d >= 31.5                        => final_score_tree_86_c667,
                                                   0.0062234486);

final_score_tree_86 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '5: Vuln Vic/Friendly', '6: Other']) => -0.0090587502,
    (nf_seg_fraudpoint_3_0 in ['3: Derog', '4: Recent Activity'])                                        => final_score_tree_86_c665,
                                                                                                            0.0006827099);

final_score_tree_87_c671 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d < 5.5 => -0.0469784439,
    r_c13_curr_addr_lres_d >= 5.5                                  => 0.0316334618,
                                                                      0.0213286722);

final_score_tree_87_c673 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i < 93.5 => 0.0030189154,
    f_addrchangecrimediff_i >= 93.5                                   => 0.0857659685,
                                                                         -0.0002976650);

final_score_tree_87_c672 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i < 76.5 => final_score_tree_87_c673,
    f_curraddrburglaryindex_i >= 76.5                                     => -0.0113683838,
                                                                             -0.0061041030);

final_score_tree_87_c670 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d < 27.5 => final_score_tree_87_c671,
    r_d32_mos_since_crim_ls_d >= 27.5                                     => final_score_tree_87_c672,
                                                                             -0.0038064115);

final_score_tree_87 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 83.5 => final_score_tree_87_c670,
    k_comb_age_d >= 83.5                        => 0.1039126704,
                                                   0.0131513162);

final_score_tree_88_c678 := map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i < 0.5 => -0.0081476430,
    f_crim_rel_under25miles_cnt_i >= 0.5                                         => 0.0123018878,
                                                                                    0.0037590737);

final_score_tree_88_c677 := map(
    NULL < r_p85_phn_invalid_i AND r_p85_phn_invalid_i < 0.5 => final_score_tree_88_c678,
    r_p85_phn_invalid_i >= 0.5                               => 0.0840661803,
                                                                0.0042281160);

final_score_tree_88_c676 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d < 5.5 => final_score_tree_88_c677,
    f_rel_ageover40_count_d >= 5.5                                   => -0.0124016399,
                                                                        0.0260377361);

final_score_tree_88_c675 := map(
    NULL < r_s65_ssn_problem_i AND r_s65_ssn_problem_i < 0.5 => final_score_tree_88_c676,
    r_s65_ssn_problem_i >= 0.5                               => -0.0422454783,
                                                                -0.0014353972);

final_score_tree_88 := map(
    NULL < k_inq_adls_per_addr_i AND k_inq_adls_per_addr_i < 3.5 => final_score_tree_88_c675,
    k_inq_adls_per_addr_i >= 3.5                                 => 0.0280802263,
                                                                    0.0002056753);

final_score_tree_89_c680 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i < 0.1950855727 => 0.2071466526,
    f_add_curr_mobility_index_i >= 0.1950855727                                       => 0.0303992677,
                                                                                         0.0472620924);

final_score_tree_89_c682 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 74225 => 0.0029345597,
    f_curraddrmedianincome_d >= 74225                                    => 0.0334492426,
                                                                            0.0065297757);

final_score_tree_89_c681 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d < 3.5 => final_score_tree_89_c682,
    f_phone_ver_insurance_d >= 3.5                                   => -0.0102906740,
                                                                        -0.0019910963);

final_score_tree_89_c683 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d < 0.0183139513 => 0.1094916144,
    f_add_input_nhood_sfd_pct_d >= 0.0183139513                                       => -0.0569703206,
                                                                                         0.0180125330);

final_score_tree_89 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d < 6.5 => final_score_tree_89_c680,
    r_d32_mos_since_crim_ls_d >= 6.5                                     => final_score_tree_89_c681,
                                                                            final_score_tree_89_c683);

final_score_tree_90_c686 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i < 0.204533575 => 0.1793586983,
    f_add_curr_mobility_index_i >= 0.204533575                                       => 0.0041553702,
                                                                                        0.0171237883);

final_score_tree_90_c688 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i < 0.0241881638 => 0.0503524673,
    f_add_curr_nhood_vac_pct_i >= 0.0241881638                                      => 0.1986834104,
                                                                                       0.1462790652);

final_score_tree_90_c687 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d < 119.5 => final_score_tree_90_c688,
    r_c13_max_lres_d >= 119.5                            => -0.0021125730,
                                                            0.0821779154);

final_score_tree_90_c685 := map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i < 0.5 => final_score_tree_90_c686,
    r_l70_add_standardized_i >= 0.5                                    => final_score_tree_90_c687,
                                                                          0.0287152509);

final_score_tree_90 := map(
    NULL < f_util_add_curr_inf_n AND f_util_add_curr_inf_n < 0.5 => -0.0037130601,
    f_util_add_curr_inf_n >= 0.5                                 => final_score_tree_90_c685,
                                                                    -0.0015674607);

final_score_tree_91_c692 := map(
    NULL < f_rel_ageover20_count_d AND f_rel_ageover20_count_d < 10.5 => 0.1071767319,
    f_rel_ageover20_count_d >= 10.5                                   => 0.0046614347,
                                                                         0.0609087659);

final_score_tree_91_c691 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 131447.5 => 0.0011235033,
    f_curraddrmedianincome_d >= 131447.5                                    => final_score_tree_91_c692,
                                                                               0.0014017656);

final_score_tree_91_c690 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i < 0 => 0.1058423541,
    f_varrisktype_i >= 0                           => final_score_tree_91_c691,
                                                      0.0016925808);

final_score_tree_91_c693 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n < 0.5 => 0.0484563260,
    r_phn_cell_n >= 0.5                        => -0.0870941133,
                                                  -0.0193188936);

final_score_tree_91 := map(
    NULL < r_d34_unrel_liens_ct_i AND r_d34_unrel_liens_ct_i < 19.5 => final_score_tree_91_c690,
    r_d34_unrel_liens_ct_i >= 19.5                                  => 0.1451753996,
                                                                       final_score_tree_91_c693);

final_score_tree_92_c697 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i < 0.3251671305 => 0.0406446678,
    f_add_curr_mobility_index_i >= 0.3251671305                                       => 0.1864758086,
                                                                                         0.0974111521);

final_score_tree_92_c696 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d < 4.5 => final_score_tree_92_c697,
    r_i61_inq_collection_recency_d >= 4.5                                          => 0.0109109474,
                                                                                      0.0175665216);

final_score_tree_92_c695 := map(
    NULL < f_rel_felony_count_i AND f_rel_felony_count_i < 1.5 => -0.0009472581,
    f_rel_felony_count_i >= 1.5                                => final_score_tree_92_c696,
                                                                  0.0053579232);

final_score_tree_92_c698 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i < 1.5 => 0.1009088285,
    r_c14_addrs_5yr_i >= 1.5                             => -0.0324055036,
                                                            0.0514399883);

final_score_tree_92 := map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i < 0.5 => final_score_tree_92_c695,
    r_p85_phn_not_issued_i >= 0.5                                  => final_score_tree_92_c698,
                                                                      0.0023008897);

final_score_tree_93_c701 := map(
    NULL < r_i60_inq_auto_count12_i AND r_i60_inq_auto_count12_i < 4.5 => 0.0508922813,
    r_i60_inq_auto_count12_i >= 4.5                                    => -0.0462202954,
                                                                          0.0335424325);

final_score_tree_93_c700 := map(
    NULL < f_srchfraudsrchcountmo_i AND f_srchfraudsrchcountmo_i < 1.5 => -0.0016966898,
    f_srchfraudsrchcountmo_i >= 1.5                                    => final_score_tree_93_c701,
                                                                          -0.0002149197);

final_score_tree_93_c703 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i < 85.5 => 0.0875867865,
    f_fp_prevaddrcrimeindex_i >= 85.5                                     => -0.0396484264,
                                                                             0.0110677074);

final_score_tree_93_c702 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i < 137.5 => final_score_tree_93_c703,
    f_fp_prevaddrburglaryindex_i >= 137.5                                        => 0.1419574956,
                                                                                    0.0528277827);

final_score_tree_93 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d < 244731 => final_score_tree_93_c700,
    f_addrchangevaluediff_d >= 244731                                   => final_score_tree_93_c702,
                                                                           -0.0022881268);

final_score_tree_94_c707 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d < 52.5 => 0.0512697510,
    f_prevaddrlenofres_d >= 52.5                                => -0.0357378428,
                                                                   0.0129416470);

final_score_tree_94_c706 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d < 198.5 => final_score_tree_94_c707,
    r_c13_max_lres_d >= 198.5                            => 0.1266448711,
                                                            0.0340749687);

final_score_tree_94_c705 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d < 144087.5 => -0.0024403373,
    f_addrchangevaluediff_d >= 144087.5                                   => final_score_tree_94_c706,
                                                                             -0.0065284199);

final_score_tree_94_c708 := map(
    NULL < r_i60_inq_count12_i AND r_i60_inq_count12_i < 6.5 => 0.1461865860,
    r_i60_inq_count12_i >= 6.5                               => 0.0007081984,
                                                                0.0666444460);

final_score_tree_94 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i < 3.5 => final_score_tree_94_c705,
    f_srchunvrfdphonecount_i >= 3.5                                    => final_score_tree_94_c708,
                                                                          -0.0145035114);

final_score_tree_95_c713 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.0776154996 => -0.0081031455,
    f_add_input_nhood_bus_pct_i >= 0.0776154996                                       => 0.1162443378,
                                                                                         0.0333460156);

final_score_tree_95_c712 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.23206242875 => 0.1292237870,
    f_add_input_mobility_index_i >= 0.23206242875                                        => final_score_tree_95_c713,
                                                                                            0.0608587674);

final_score_tree_95_c711 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d < 82.5 => 0.0120185973,
    f_m_bureau_adl_fs_notu_d >= 82.5                                    => final_score_tree_95_c712,
                                                                           0.0179324384);

final_score_tree_95_c710 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 22.5 => final_score_tree_95_c711,
    k_comb_age_d >= 22.5                        => -0.0038598377,
                                                   -0.0021542701);

final_score_tree_95 := map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i < 21837 => final_score_tree_95_c710,
    f_liens_unrel_cj_total_amt_i >= 21837                                        => 0.0592955277,
                                                                                    0.0327616165);

final_score_tree_96_c716 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d < 112.5 => 0.0241938877,
    f_prevaddrageoldest_d >= 112.5                                 => 0.1161538966,
                                                                      0.0428524403);

final_score_tree_96_c717 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i < 64.5 => 0.0652086388,
    f_fp_prevaddrcrimeindex_i >= 64.5                                     => -0.0252011692,
                                                                             0.0054380601);

final_score_tree_96_c715 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d < 0.5 => final_score_tree_96_c716,
    f_rel_under25miles_cnt_d >= 0.5                                    => 0.0030578954,
                                                                          final_score_tree_96_c717);

final_score_tree_96_c718 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d < 34 => 0.0838119705,
    r_d32_mos_since_crim_ls_d >= 34                                     => -0.0326889683,
                                                                           -0.0256220068);

final_score_tree_96 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.02003490945 => -0.0065498198,
    f_add_input_nhood_bus_pct_i >= 0.02003490945                                       => final_score_tree_96_c715,
                                                                                          final_score_tree_96_c718);

final_score_tree_97_c723 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 14499 => -0.0692236352,
    f_curraddrmedianincome_d >= 14499                                    => 0.0489212367,
                                                                            0.0415371822);

final_score_tree_97_c722 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i < 0.0926590979 => final_score_tree_97_c723,
    f_add_input_nhood_vac_pct_i >= 0.0926590979                                       => -0.0286891578,
                                                                                         0.0333961005);

final_score_tree_97_c721 := map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i < 162.5 => 0.0061395574,
    f_prevaddrmurderindex_i >= 162.5                                   => final_score_tree_97_c722,
                                                                          0.0091852385);

final_score_tree_97_c720 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i < 78 => final_score_tree_97_c721,
    f_curraddrburglaryindex_i >= 78                                     => -0.0030372799,
                                                                           0.0012990507);

final_score_tree_97 := map(
    NULL < f_mos_liens_rel_ot_fseen_d AND f_mos_liens_rel_ot_fseen_d < 55.5 => final_score_tree_97_c720,
    f_mos_liens_rel_ot_fseen_d >= 55.5                                      => -0.0336495747,
                                                                               -0.0064046741);

final_score_tree_98_c728 := map(
    NULL < r_d34_unrel_liens_ct_i AND r_d34_unrel_liens_ct_i < 0.5 => 0.1208295018,
    r_d34_unrel_liens_ct_i >= 0.5                                  => 0.0088985186,
                                                                      0.0754326009);

final_score_tree_98_c727 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => final_score_tree_98_c728,
    f_phone_ver_experian_d >= 0.5                                  => 0.0377519342,
                                                                      0.0581222250);

final_score_tree_98_c726 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d < 88.5 => 0.0127536515,
    f_prevaddrageoldest_d >= 88.5                                 => final_score_tree_98_c727,
                                                                     0.0294799852);

final_score_tree_98_c725 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d < 0.5 => 0.0023601948,
    f_rel_incomeover75_count_d >= 0.5                                      => final_score_tree_98_c726,
                                                                              -0.0028983214);

final_score_tree_98 := map(
    NULL < f_rel_bankrupt_count_i AND f_rel_bankrupt_count_i < 0.5 => final_score_tree_98_c725,
    f_rel_bankrupt_count_i >= 0.5                                  => -0.0046612463,
                                                                      0.0121248851);

final_score_tree_99_c733 := map(
    NULL < f_rel_ageover50_count_d AND f_rel_ageover50_count_d < 0.5 => -0.0643053686,
    f_rel_ageover50_count_d >= 0.5                                   => -0.0046498823,
                                                                        0.0455733794);

final_score_tree_99_c732 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d < 25500 => 0.0274405071,
    k_estimated_income_d >= 25500                                => final_score_tree_99_c733,
                                                                    -0.0349246470);

final_score_tree_99_c731 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d < 0.00117928625 => final_score_tree_99_c732,
    f_add_input_nhood_sfd_pct_d >= 0.00117928625                                       => -0.0054355208,
                                                                                          -0.0069986222);

final_score_tree_99_c730 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i < 4.5 => final_score_tree_99_c731,
    r_l79_adls_per_addr_curr_i >= 4.5                                      => 0.0087370698,
                                                                              0.0033222878);

final_score_tree_99 := map(
    NULL < r_p86_phn_pager_i AND r_p86_phn_pager_i < 0.5 => final_score_tree_99_c730,
    r_p86_phn_pager_i >= 0.5                             => 0.1660123380,
                                                            -0.0008317352);

final_score_tree_100_c736 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.1106189268 => -0.0785312323,
    f_add_input_mobility_index_i >= 0.1106189268                                        => -0.0018749991,
                                                                                           -0.0630235677);

final_score_tree_100_c735 := map(
    NULL < r_i60_inq_retpymt_count12_i AND r_i60_inq_retpymt_count12_i < 1.5 => final_score_tree_100_c736,
    r_i60_inq_retpymt_count12_i >= 1.5                                       => 0.1194192916,
                                                                                0.0085373432);

final_score_tree_100_c738 := map(
    NULL < r_i60_inq_auto_count12_i AND r_i60_inq_auto_count12_i < 1.5 => 0.0329304159,
    r_i60_inq_auto_count12_i >= 1.5                                    => -0.0111034873,
                                                                          0.0152936265);

final_score_tree_100_c737 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i < 0.68365784685 => final_score_tree_100_c738,
    f_add_curr_mobility_index_i >= 0.68365784685                                       => 0.2116865873,
                                                                                          0.0194228773);

final_score_tree_100 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i < 2.5 => final_score_tree_100_c735,
    k_inq_per_phone_i >= 2.5                             => final_score_tree_100_c737,
                                                            0.0001222221);

final_score_tree_101_c743 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d < 0.5 => 0.0029556827,
    f_rel_incomeover75_count_d >= 0.5                                      => 0.0708950132,
                                                                              0.0418587018);

final_score_tree_101_c742 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.00513918725 => 0.1062980385,
    f_add_curr_nhood_bus_pct_i >= 0.00513918725                                      => final_score_tree_101_c743,
                                                                                        0.0463833775);

final_score_tree_101_c741 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i < 6.5 => 0.0045256266,
    r_l79_adls_per_addr_curr_i >= 6.5                                      => final_score_tree_101_c742,
                                                                              0.0110223085);

final_score_tree_101_c740 := map(
    NULL < f_rel_felony_count_i AND f_rel_felony_count_i < 0.5 => -0.0046147227,
    f_rel_felony_count_i >= 0.5                                => final_score_tree_101_c741,
                                                                  0.0008163753);

final_score_tree_101 := map(
    NULL < r_c19_add_prison_hist_i AND r_c19_add_prison_hist_i < 0.5 => final_score_tree_101_c740,
    r_c19_add_prison_hist_i >= 0.5                                   => 0.0868690356,
                                                                        -0.0011699352);

final_score_tree_102_c747 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d < -16548.5 => 0.1164313865,
    f_addrchangeincomediff_d >= -16548.5                                    => -0.0003534651,
                                                                               0.0190691755);

final_score_tree_102_c748 := map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d < 0.0895261309 => 0.1441291579,
    f_add_curr_nhood_sfd_pct_d >= 0.0895261309                                      => 0.0007429293,
                                                                                       0.0488527823);

final_score_tree_102_c746 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d < 9837.5 => final_score_tree_102_c747,
    f_addrchangeincomediff_d >= 9837.5                                    => 0.1465790697,
                                                                             final_score_tree_102_c748);

final_score_tree_102_c745 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i < 3.5 => 0.0001698631,
    f_idverrisktype_i >= 3.5                             => final_score_tree_102_c746,
                                                            0.0014017521);

final_score_tree_102 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d < 3.5 => final_score_tree_102_c745,
    r_c23_inp_addr_occ_index_d >= 3.5                                      => -0.0181365067,
                                                                              0.0192106223);

final_score_tree_103_c752 := map(
    NULL < f_rel_bankrupt_count_i AND f_rel_bankrupt_count_i < 0.5 => 0.1524466811,
    f_rel_bankrupt_count_i >= 0.5                                  => 0.0368515275,
                                                                      0.0692023896);

final_score_tree_103_c751 := map(
    NULL < r_i60_inq_recency_d AND r_i60_inq_recency_d < 4.5 => final_score_tree_103_c752,
    r_i60_inq_recency_d >= 4.5                               => 0.0075062450,
                                                                0.0231980596);

final_score_tree_103_c750 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 91712 => -0.0021907637,
    f_curraddrmedianincome_d >= 91712                                    => final_score_tree_103_c751,
                                                                            -0.0010055335);

final_score_tree_103_c753 := map(
    NULL < r_f03_address_match_d AND r_f03_address_match_d < 3 => 0.1548440099,
    r_f03_address_match_d >= 3                                 => 0.0101610696,
                                                                  0.0751384380);

final_score_tree_103 := map(
    NULL < r_c19_add_prison_hist_i AND r_c19_add_prison_hist_i < 0.5 => final_score_tree_103_c750,
    r_c19_add_prison_hist_i >= 0.5                                   => final_score_tree_103_c753,
                                                                        0.0050259698);

final_score_tree_104_c758 := map(
    NULL < f_divrisktype_i AND f_divrisktype_i < 1.5 => 0.0225820922,
    f_divrisktype_i >= 1.5                           => 0.0956817154,
                                                        0.0452129345);

final_score_tree_104_c757 := map(
    NULL < f_historical_count_d AND f_historical_count_d < 2.5 => final_score_tree_104_c758,
    f_historical_count_d >= 2.5                                => -0.0030364108,
                                                                  0.0178462110);

final_score_tree_104_c756 := map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d < 28.5 => final_score_tree_104_c757,
    f_mos_acc_lseen_d >= 28.5                             => -0.0046164242,
                                                             -0.0022285895);

final_score_tree_104_c755 := map(
    NULL < r_i60_inq_util_recency_d AND r_i60_inq_util_recency_d < 549 => 0.0411742185,
    r_i60_inq_util_recency_d >= 549                                    => final_score_tree_104_c756,
                                                                          -0.0005423969);

final_score_tree_104 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 83.5 => final_score_tree_104_c755,
    k_comb_age_d >= 83.5                        => 0.1089686114,
                                                   -0.0098891569);

final_score_tree_105_c761 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i < 0.19930385145 => 0.2096875814,
    f_add_curr_nhood_mfd_pct_i >= 0.19930385145                                      => -0.0028853608,
                                                                                        0.1302781489);

final_score_tree_105_c763 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i < -19.5 => -0.0729386813,
    f_addrchangecrimediff_i >= -19.5                                   => 0.0069171671,
                                                                          0.0257170992);

final_score_tree_105_c762 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.6118821382 => final_score_tree_105_c763,
    f_add_input_mobility_index_i >= 0.6118821382                                        => 0.1157502459,
                                                                                           0.0103424619);

final_score_tree_105_c760 := map(
    NULL < f_mos_liens_unrel_sc_fseen_d AND f_mos_liens_unrel_sc_fseen_d < 120 => final_score_tree_105_c761,
    f_mos_liens_unrel_sc_fseen_d >= 120                                        => final_score_tree_105_c762,
                                                                                  0.0209996527);

final_score_tree_105 := map(
    NULL < f_srchphonesrchcountmo_i AND f_srchphonesrchcountmo_i < 0.5 => -0.0029149688,
    f_srchphonesrchcountmo_i >= 0.5                                    => final_score_tree_105_c760,
                                                                          0.0068167462);

final_score_tree_106_c766 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i < 44 => 0.0063981484,
    f_addrchangecrimediff_i >= 44                                   => 0.1260120554,
                                                                       -0.0011091617);

final_score_tree_106_c768 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d < 33500 => 0.2092820939,
    k_estimated_income_d >= 33500                                => 0.0672883908,
                                                                    0.1170468680);

final_score_tree_106_c767 := map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i < 1.5 => 0.0225945650,
    f_crim_rel_under25miles_cnt_i >= 1.5                                         => final_score_tree_106_c768,
                                                                                    0.0669757676);

final_score_tree_106_c765 := map(
    NULL < f_srchunvrfdssncount_i AND f_srchunvrfdssncount_i < 0.5 => final_score_tree_106_c766,
    f_srchunvrfdssncount_i >= 0.5                                  => final_score_tree_106_c767,
                                                                      0.0187992773);

final_score_tree_106 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n < 10.5 => -0.0020196794,
    f_util_adl_count_n >= 10.5                              => final_score_tree_106_c765,
                                                               0.0047878342);

final_score_tree_107_c772 := map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d < 103.5 => 0.2545844650,
    f_mos_liens_unrel_cj_lseen_d >= 103.5                                        => -0.0147815188,
                                                                                    0.0141825654);

final_score_tree_107_c771 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => 0.0303893743,
    f_phone_ver_experian_d >= 0.5                                  => final_score_tree_107_c772,
                                                                      0.0219027007);

final_score_tree_107_c770 := map(
    NULL < r_i60_inq_util_recency_d AND r_i60_inq_util_recency_d < 549 => final_score_tree_107_c771,
    r_i60_inq_util_recency_d >= 549                                    => -0.0026235357,
                                                                          -0.0017010120);

final_score_tree_107_c773 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d < 61.8 => 0.1816827316,
    r_c12_source_profile_d >= 61.8                                  => 0.0079240030,
                                                                       0.0862578561);

final_score_tree_107 := map(
    NULL < f_srchlocatesrchcountwk_i AND f_srchlocatesrchcountwk_i < 0.5 => final_score_tree_107_c770,
    f_srchlocatesrchcountwk_i >= 0.5                                     => final_score_tree_107_c773,
                                                                            0.0110340813);

final_score_tree_108_c778 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.94741353885 => 0.0847169423,
    f_add_input_nhood_mfd_pct_i >= 0.94741353885                                       => -0.0554261996,
                                                                                          0.1143027199);

final_score_tree_108_c777 := map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i < 7.5 => final_score_tree_108_c778,
    f_rel_criminal_count_i >= 7.5                                  => -0.0258540502,
                                                                      0.0558732619);

final_score_tree_108_c776 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => final_score_tree_108_c777,
    f_phone_ver_experian_d >= 0.5                                  => -0.0117539917,
                                                                      0.0190876801);

final_score_tree_108_c775 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d < 128.5 => 0.0000347106,
    r_c13_max_lres_d >= 128.5                            => final_score_tree_108_c776,
                                                            0.0109285077);

final_score_tree_108 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i < 7.5 => -0.0083717246,
    r_p88_phn_dst_to_inp_add_i >= 7.5                                      => final_score_tree_108_c775,
                                                                              0.0038013466);

final_score_tree_109_c782 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i < 1.5 => -0.0336693558,
    f_addrs_per_ssn_i >= 1.5                             => 0.0263307243,
                                                            0.0114758658);

final_score_tree_109_c781 := map(
    NULL < f_divaddrsuspidcountnew_i AND f_divaddrsuspidcountnew_i < 3.5 => final_score_tree_109_c782,
    f_divaddrsuspidcountnew_i >= 3.5                                     => 0.1053189774,
                                                                            0.0166933427);

final_score_tree_109_c780 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i < 188.5 => final_score_tree_109_c781,
    f_curraddrmurderindex_i >= 188.5                                   => 0.0940915163,
                                                                          0.0220178979);

final_score_tree_109_c783 := map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d < 18 => 0.1047677002,
    r_i60_inq_prepaidcards_recency_d >= 18                                            => -0.0017784636,
                                                                                         -0.0014872793);

final_score_tree_109 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 21.5 => final_score_tree_109_c780,
    k_comb_age_d >= 21.5                        => final_score_tree_109_c783,
                                                   0.0108704381);

final_score_tree_110_c786 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i < 35.5 => -0.0027959937,
    f_addrs_per_ssn_i >= 35.5                             => 0.1091490157,
                                                             -0.0023221242);

final_score_tree_110_c788 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d < 1241 => -0.0547264102,
    f_addrchangeincomediff_d >= 1241                                    => 0.0572589472,
                                                                           -0.0501537194);

final_score_tree_110_c787 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => final_score_tree_110_c788,
    f_phone_ver_experian_d >= 0.5                                  => -0.0166338027,
                                                                      0.0152873632);

final_score_tree_110_c785 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i < 187.5 => final_score_tree_110_c786,
    f_curraddrcartheftindex_i >= 187.5                                     => final_score_tree_110_c787,
                                                                              -0.0041706918);

final_score_tree_110 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d < 20968 => 0.0154987360,
    f_prevaddrmedianincome_d >= 20968                                    => final_score_tree_110_c785,
                                                                            0.0267363284);

final_score_tree_111_c793 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d < 5.5 => 0.1523012974,
    f_rel_incomeover50_count_d >= 5.5                                      => 0.0116929051,
                                                                              0.0695904784);

final_score_tree_111_c792 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i < 4.5 => 0.0072920727,
    f_hh_lienholders_i >= 4.5                              => final_score_tree_111_c793,
                                                              0.0086853278);

final_score_tree_111_c791 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i < 0.13121947315 => 0.1276051060,
    f_add_curr_mobility_index_i >= 0.13121947315                                       => final_score_tree_111_c792,
                                                                                          0.0096106402);

final_score_tree_111_c790 := map(
    NULL < (integer)k_inf_contradictory_i AND (real)k_inf_contradictory_i < 0.5 => -0.0038419937,
    (real)k_inf_contradictory_i >= 0.5                                 => final_score_tree_111_c791,
                                                                    -0.0000247091);

final_score_tree_111 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i < 31.5 => final_score_tree_111_c790,
    r_l79_adls_per_addr_curr_i >= 31.5                                      => 0.0475454847,
                                                                               -0.0137450639);

final_score_tree_112_c798 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i < 0.02060969375 => 0.1981941582,
    f_add_curr_nhood_vac_pct_i >= 0.02060969375                                      => -0.0181740338,
                                                                                        0.0900100622);

final_score_tree_112_c797 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d < 7851 => 0.0114666481,
    f_addrchangeincomediff_d >= 7851                                    => final_score_tree_112_c798,
                                                                           0.0300458243);

final_score_tree_112_c796 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d < 7.5 => 0.0839395392,
    f_rel_ageover30_count_d >= 7.5                                   => final_score_tree_112_c797,
                                                                        0.0321587029);

final_score_tree_112_c795 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d < 4.5 => -0.0039556662,
    f_rel_under25miles_cnt_d >= 4.5                                    => final_score_tree_112_c796,
                                                                          0.0204368177);

final_score_tree_112 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i < 3.5 => -0.0020388332,
    r_c14_addrs_5yr_i >= 3.5                             => final_score_tree_112_c795,
                                                            -0.0165195734);

final_score_tree_113_c803 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d < 79925.5 => -0.0011976421,
    f_curraddrmedianvalue_d >= 79925.5                                   => 0.0490817636,
                                                                            0.0154948175);

final_score_tree_113_c802 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i < 4.5 => final_score_tree_113_c803,
    r_d32_criminal_count_i >= 4.5                                  => 0.1450736128,
                                                                      0.0217507727);

final_score_tree_113_c801 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 24378 => final_score_tree_113_c802,
    f_curraddrmedianincome_d >= 24378                                    => 0.0027143879,
                                                                            0.0056250820);

final_score_tree_113_c800 := map(
    NULL < r_i60_inq_auto_recency_d AND r_i60_inq_auto_recency_d < 549 => -0.0068688061,
    r_i60_inq_auto_recency_d >= 549                                    => final_score_tree_113_c801,
                                                                          0.0000292236);

final_score_tree_113 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d < 135977.5 => final_score_tree_113_c800,
    f_prevaddrmedianincome_d >= 135977.5                                    => 0.1036946921,
                                                                               -0.0080458697);

final_score_tree_114_c807 := map(
    NULL < f_hh_tot_derog_i AND f_hh_tot_derog_i < 2.5 => 0.0566496892,
    f_hh_tot_derog_i >= 2.5                            => -0.0020607929,
                                                          0.0285622007);

final_score_tree_114_c806 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d < 74.5 => -0.0050763462,
    f_prevaddrageoldest_d >= 74.5                                 => final_score_tree_114_c807,
                                                                     0.0091182635);

final_score_tree_114_c805 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d < 64500 => -0.0047083274,
    k_estimated_income_d >= 64500                                => final_score_tree_114_c806,
                                                                    -0.0015519846);

final_score_tree_114_c808 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n < 0.5 => 0.0478448452,
    r_phn_cell_n >= 0.5                        => -0.0745826085,
                                                  -0.0180776299);

final_score_tree_114 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i < 44.5 => final_score_tree_114_c805,
    r_l79_adls_per_addr_curr_i >= 44.5                                      => 0.0697196914,
                                                                               final_score_tree_114_c808);

final_score_tree_115_c812 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d < 58 => 0.0443642756,
    r_c13_curr_addr_lres_d >= 58                                  => -0.0747477559,
                                                                     0.0090907555);

final_score_tree_115_c813 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.03438561835 => 0.0684296133,
    f_add_curr_nhood_bus_pct_i >= 0.03438561835                                      => 0.1613038945,
                                                                                        0.1155207981);

final_score_tree_115_c811 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d < 132.5 => final_score_tree_115_c812,
    f_prevaddrlenofres_d >= 132.5                                => final_score_tree_115_c813,
                                                                    0.0343482943);

final_score_tree_115_c810 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i < 15.5 => -0.0154676893,
    r_d30_derog_count_i >= 15.5                               => final_score_tree_115_c811,
                                                                 -0.0125636185);

final_score_tree_115 := map(
    NULL < f_current_count_d AND f_current_count_d < 1.5 => 0.0062744512,
    f_current_count_d >= 1.5                             => final_score_tree_115_c810,
                                                            -0.0199369785);

final_score_tree_116_c817 := map(
    NULL < f_inq_retailpayments_count24_i AND f_inq_retailpayments_count24_i < 0.5 => 0.0235019983,
    f_inq_retailpayments_count24_i >= 0.5                                          => -0.0573995655,
                                                                                      0.0182999022);

final_score_tree_116_c816 := map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d < 0.99226302715 => final_score_tree_116_c817,
    f_add_curr_nhood_sfd_pct_d >= 0.99226302715                                      => 0.1572141728,
                                                                                        0.0220462417);

final_score_tree_116_c818 := map(
    NULL < f_rel_ageover70_count_d AND f_rel_ageover70_count_d < 0.5 => -0.0031872822,
    f_rel_ageover70_count_d >= 0.5                                   => 0.0664698313,
                                                                        0.0136712100);

final_score_tree_116_c815 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 22.5 => final_score_tree_116_c816,
    k_comb_age_d >= 22.5                        => final_score_tree_116_c818,
                                                   -0.0003894095);

final_score_tree_116 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i < 3.5 => final_score_tree_116_c815,
    f_validationrisktype_i >= 3.5                                  => -0.0607488609,
                                                                      0.0259530272);

final_score_tree_117_c823 := map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d < 4.5 => 0.0359704331,
    f_rel_incomeover25_count_d >= 4.5                                      => -0.0247521075,
                                                                              -0.0513913213);

final_score_tree_117_c822 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.0039255116 => 0.0650887985,
    f_add_input_nhood_bus_pct_i >= 0.0039255116                                       => final_score_tree_117_c823,
                                                                                         -0.0649754084);

final_score_tree_117_c821 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.22834809545 => final_score_tree_117_c822,
    f_add_input_mobility_index_i >= 0.22834809545                                        => 0.0186223622,
                                                                                            -0.0450491193);

final_score_tree_117_c820 := map(
    NULL < f_acc_damage_amt_total_i AND f_acc_damage_amt_total_i < 3050 => final_score_tree_117_c821,
    f_acc_damage_amt_total_i >= 3050                                    => 0.1475752038,
                                                                           0.0120867659);

final_score_tree_117 := map(
    NULL < r_l70_add_standardized_i AND r_l70_add_standardized_i < 0.5 => -0.0032811486,
    r_l70_add_standardized_i >= 0.5                                    => final_score_tree_117_c820,
                                                                          0.0000404609);

final_score_tree_118_c827 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i < 43 => -0.1096723860,
    f_phones_per_addr_curr_i >= 43                                    => -0.0232054719,
                                                                         -0.0726151371);

final_score_tree_118_c826 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.9355263452 => -0.0154584082,
    f_add_input_nhood_mfd_pct_i >= 0.9355263452                                       => final_score_tree_118_c827,
                                                                                         0.0120529196);

final_score_tree_118_c828 := map(
    NULL < r_i60_inq_auto_recency_d AND r_i60_inq_auto_recency_d < 549 => -0.0075951446,
    r_i60_inq_auto_recency_d >= 549                                    => 0.0059363151,
                                                                          -0.0002927130);

final_score_tree_118_c825 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i < 1.5 => final_score_tree_118_c826,
    f_addrs_per_ssn_i >= 1.5                             => final_score_tree_118_c828,
                                                            -0.0010913672);

final_score_tree_118 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d < 114 => final_score_tree_118_c825,
    f_bus_addr_match_count_d >= 114                                    => 0.0723269297,
                                                                          -0.0008234172);

final_score_tree_119_c832 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i < 0.5 => 0.0286822555,
    f_srchunvrfdaddrcount_i >= 0.5                                   => 0.0966578047,
                                                                        0.0323572587);

final_score_tree_119_c833 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d < 50.5 => 0.1316184752,
    f_prevaddrlenofres_d >= 50.5                                => -0.0282836399,
                                                                   0.0374825526);

final_score_tree_119_c831 := map(
    NULL < f_rel_educationover8_count_d AND f_rel_educationover8_count_d < 12.5 => final_score_tree_119_c832,
    f_rel_educationover8_count_d >= 12.5                                        => 0.0013809793,
                                                                                   final_score_tree_119_c833);

final_score_tree_119_c830 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d < 29.5 => -0.0094814585,
    f_prevaddrageoldest_d >= 29.5                                 => final_score_tree_119_c831,
                                                                     0.0093135139);

final_score_tree_119 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d < 53500 => -0.0040033690,
    k_estimated_income_d >= 53500                                => final_score_tree_119_c830,
                                                                    -0.0174954698);

final_score_tree_120_c836 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d < -16441.5 => 0.0560977794,
    f_addrchangevaluediff_d >= -16441.5                                   => 0.0046643470,
                                                                             0.0121702686);

final_score_tree_120_c838 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i < 3.5 => 0.0983162149,
    f_phones_per_addr_curr_i >= 3.5                                    => -0.0124740800,
                                                                          0.0352941993);

final_score_tree_120_c837 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d < 1.5 => final_score_tree_120_c838,
    f_rel_under500miles_cnt_d >= 1.5                                     => -0.0187650242,
                                                                            -0.0078924474);

final_score_tree_120_c835 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d < 3.5 => final_score_tree_120_c836,
    r_c23_inp_addr_occ_index_d >= 3.5                                      => final_score_tree_120_c837,
                                                                              0.0046621470);

final_score_tree_120 := map(
    (nf_seg_fraudpoint_3_0 in ['2: Synth ID', '5: Vuln Vic/Friendly', '6: Other'])      => -0.0138433058,
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '3: Derog', '4: Recent Activity']) => final_score_tree_120_c835,
                                                                                           0.0003741444);

final_score_tree_121_c841 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i < 2.5 => 0.0077341298,
    k_inq_adls_per_phone_i >= 2.5                                  => 0.1023959699,
                                                                      0.0084975980);

final_score_tree_121_c840 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i < 2.5 => -0.0087070473,
    f_srchvelocityrisktype_i >= 2.5                                    => final_score_tree_121_c841,
                                                                          0.0020519139);

final_score_tree_121_c843 := map(
    NULL < f_hh_age_65_plus_d AND f_hh_age_65_plus_d < 2.5 => -0.0310053434,
    f_hh_age_65_plus_d >= 2.5                              => 0.1138765586,
                                                              -0.0276411554);

final_score_tree_121_c842 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i < 37984.5 => -0.0057774749,
    r_a49_curr_avm_chg_1yr_i >= 37984.5                                    => 0.0459800164,
                                                                              final_score_tree_121_c843);

final_score_tree_121 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d < 312.5 => final_score_tree_121_c840,
    r_c21_m_bureau_adl_fs_d >= 312.5                                   => final_score_tree_121_c842,
                                                                          0.0197085503);

final_score_tree_122_c846 := map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i < 13271.5 => 0.0038901083,
    f_liens_unrel_cj_total_amt_i >= 13271.5                                        => 0.1779772151,
                                                                                      0.0111740877);

final_score_tree_122_c847 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.04937351425 => 0.0359287309,
    f_add_curr_nhood_bus_pct_i >= 0.04937351425                                      => 0.1632851847,
                                                                                        0.0877203555);

final_score_tree_122_c845 := map(
    NULL < r_c14_addrs_10yr_i AND r_c14_addrs_10yr_i < 6.5 => final_score_tree_122_c846,
    r_c14_addrs_10yr_i >= 6.5                              => final_score_tree_122_c847,
                                                              0.0268196963);

final_score_tree_122_c848 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.4727458487 => 0.0003858640,
    f_add_input_mobility_index_i >= 0.4727458487                                        => -0.0253394726,
                                                                                           -0.0024041172);

final_score_tree_122 := map(
    NULL < f_mos_liens_unrel_sc_fseen_d AND f_mos_liens_unrel_sc_fseen_d < 96.5 => final_score_tree_122_c845,
    f_mos_liens_unrel_sc_fseen_d >= 96.5                                        => final_score_tree_122_c848,
                                                                                   0.0258422067);

final_score_tree_123_c851 := map(
    NULL < f_accident_count_i AND f_accident_count_i < 5.5 => -0.0015192774,
    f_accident_count_i >= 5.5                              => 0.1278676077,
                                                              -0.0010728234);

final_score_tree_123_c853 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.22731188655 => -0.0267516562,
    f_add_input_mobility_index_i >= 0.22731188655                                        => 0.0435022748,
                                                                                            0.0128411664);

final_score_tree_123_c852 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => final_score_tree_123_c853,
    f_phone_ver_experian_d >= 0.5                                  => -0.0530744571,
                                                                      -0.0362908456);

final_score_tree_123_c850 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.2448126429 => final_score_tree_123_c851,
    f_add_curr_nhood_bus_pct_i >= 0.2448126429                                      => 0.0364751404,
                                                                                       final_score_tree_123_c852);

final_score_tree_123 := map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i < 22965.5 => final_score_tree_123_c850,
    f_liens_rel_cj_total_amt_i >= 22965.5                                      => 0.1369959431,
                                                                                  0.0081535409);

final_score_tree_124_c855 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d < 98500 => -0.0057558724,
    k_estimated_income_d >= 98500                                => 0.0458141851,
                                                                    -0.0047090820);

final_score_tree_124_c858 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => 0.1145101360,
    f_phone_ver_experian_d >= 0.5                                  => 0.0452913791,
                                                                      0.0793955111);

final_score_tree_124_c857 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d < 29.5 => 0.0074789549,
    f_rel_ageover30_count_d >= 29.5                                   => final_score_tree_124_c858,
                                                                         0.0109891973);

final_score_tree_124_c856 := map(
    NULL < f_accident_count_i AND f_accident_count_i < 4.5 => final_score_tree_124_c857,
    f_accident_count_i >= 4.5                              => 0.2085292798,
                                                              0.0126646857);

final_score_tree_124 := map(
    NULL < f_hh_collections_ct_i AND f_hh_collections_ct_i < 2.5 => final_score_tree_124_c855,
    f_hh_collections_ct_i >= 2.5                                 => final_score_tree_124_c856,
                                                                    0.0046269102);

final_score_tree_125_c862 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i < 0.05696351325 => 0.0075133586,
    f_add_curr_nhood_mfd_pct_i >= 0.05696351325                                      => 0.1640930594,
                                                                                        0.1072649054);

final_score_tree_125_c861 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d < 5.5 => final_score_tree_125_c862,
    f_rel_homeover200_count_d >= 5.5                                     => -0.0083910432,
                                                                            0.0790411726);

final_score_tree_125_c860 := map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i < 0.5 => -0.0100040024,
    k_inq_per_addr_i >= 0.5                            => final_score_tree_125_c861,
                                                          0.0453563202);

final_score_tree_125_c863 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i < 112.5 => 0.0005275675,
    f_phones_per_addr_curr_i >= 112.5                                    => 0.0867815566,
                                                                            0.0007517332);

final_score_tree_125 := map(
    NULL < f_mos_liens_unrel_sc_fseen_d AND f_mos_liens_unrel_sc_fseen_d < 48.5 => final_score_tree_125_c860,
    f_mos_liens_unrel_sc_fseen_d >= 48.5                                        => final_score_tree_125_c863,
                                                                                   0.0037427127);

final_score_tree_126_c866 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i < 0.00849794935 => 0.0927157926,
    f_add_input_nhood_vac_pct_i >= 0.00849794935                                       => 0.0233358414,
                                                                                          0.0466803741);

final_score_tree_126_c868 := map(
    NULL < r_i60_inq_util_recency_d AND r_i60_inq_util_recency_d < 61.5 => 0.1065524828,
    r_i60_inq_util_recency_d >= 61.5                                    => 0.0120789027,
                                                                           0.0135582684);

final_score_tree_126_c867 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d < 6.5 => -0.0095750904,
    f_rel_under25miles_cnt_d >= 6.5                                    => final_score_tree_126_c868,
                                                                          0.0052496380);

final_score_tree_126_c865 := map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d < 3.5 => final_score_tree_126_c866,
    f_rel_homeover50_count_d >= 3.5                                    => final_score_tree_126_c867,
                                                                          -0.0193571403);

final_score_tree_126 := map(
    NULL < f_hh_criminals_i AND f_hh_criminals_i < 0.5 => -0.0072714541,
    f_hh_criminals_i >= 0.5                            => final_score_tree_126_c865,
                                                          0.0187067337);

final_score_tree_127_c872 := map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i < 1.5 => 0.1350080921,
    r_s66_adlperssn_count_i >= 1.5                                   => -0.0296886383,
                                                                        0.0345327283);

final_score_tree_127_c871 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i < 129 => final_score_tree_127_c872,
    f_fp_prevaddrburglaryindex_i >= 129                                        => 0.2285714802,
                                                                                  0.0989405493);

final_score_tree_127_c870 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i < 153.5 => final_score_tree_127_c871,
    f_prevaddrcartheftindex_i >= 153.5                                     => -0.0428209978,
                                                                              0.0555441573);

final_score_tree_127_c873 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d < 18608 => -0.0034466937,
    f_addrchangeincomediff_d >= 18608                                    => 0.0242682985,
                                                                            0.0010001808);

final_score_tree_127 := map(
    NULL < f_mos_liens_unrel_sc_fseen_d AND f_mos_liens_unrel_sc_fseen_d < 30.5 => final_score_tree_127_c870,
    f_mos_liens_unrel_sc_fseen_d >= 30.5                                        => final_score_tree_127_c873,
                                                                                   0.0131356540);

final_score_tree_128_c876 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d < 108.5 => 0.0489951398,
    r_c13_curr_addr_lres_d >= 108.5                                  => -0.0548059838,
                                                                        0.0274943317);

final_score_tree_128_c878 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i < 116.5 => 0.0330783092,
    f_prevaddrcartheftindex_i >= 116.5                                     => -0.0241745616,
                                                                              0.0079811604);

final_score_tree_128_c877 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i < 160.5 => final_score_tree_128_c878,
    f_curraddrcartheftindex_i >= 160.5                                     => 0.0498353640,
                                                                              0.0232305150);

final_score_tree_128_c875 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d < 116711.5 => final_score_tree_128_c876,
    r_a46_curr_avm_autoval_d >= 116711.5                                    => -0.0236094425,
                                                                               final_score_tree_128_c877);

final_score_tree_128 := map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d < 549 => final_score_tree_128_c875,
    r_i60_inq_prepaidcards_recency_d >= 549                                            => -0.0035282872,
                                                                                          -0.0030854083);

final_score_tree_129_c881 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d < 6.5 => 0.0856506936,
    r_d32_mos_since_crim_ls_d >= 6.5                                     => 0.0080504631,
                                                                            0.0105772915);

final_score_tree_129_c880 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d < 118.5 => final_score_tree_129_c881,
    r_c13_curr_addr_lres_d >= 118.5                                  => 0.1133435729,
                                                                        0.0132921961);

final_score_tree_129_c883 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.0550411082 => -0.0100510440,
    f_add_input_nhood_bus_pct_i >= 0.0550411082                                       => 0.0063923583,
                                                                                         -0.0029194747);

final_score_tree_129_c882 := map(
    NULL < f_srchssnsrchcountmo_i AND f_srchssnsrchcountmo_i < 4.5 => final_score_tree_129_c883,
    f_srchssnsrchcountmo_i >= 4.5                                  => 0.0975172166,
                                                                      -0.0033214287);

final_score_tree_129 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 25.5 => final_score_tree_129_c880,
    k_comb_age_d >= 25.5                        => final_score_tree_129_c882,
                                                   -0.0350668419);

final_score_tree_130_c887 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d < 30500 => 0.0705716702,
    k_estimated_income_d >= 30500                                => -0.0178390153,
                                                                    0.0039277492);

final_score_tree_130_c888 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i < 0.2534077034 => 0.0852794674,
    f_add_curr_nhood_mfd_pct_i >= 0.2534077034                                      => 0.1393507218,
                                                                                       -0.0424965106);

final_score_tree_130_c886 := map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d < 0.5 => final_score_tree_130_c887,
    f_rel_incomeover100_count_d >= 0.5                                       => final_score_tree_130_c888,
                                                                                0.0217900775);

final_score_tree_130_c885 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 24.5 => 0.1727885117,
    k_comb_age_d >= 24.5                        => final_score_tree_130_c886,
                                                   0.0304368595);

final_score_tree_130 := map(
    NULL < r_i60_inq_util_recency_d AND r_i60_inq_util_recency_d < 549 => final_score_tree_130_c885,
    r_i60_inq_util_recency_d >= 549                                    => -0.0015876449,
                                                                          -0.0057301990);

final_score_tree_131_c891 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i < 0.07363786225 => 0.1974882665,
    f_add_curr_nhood_vac_pct_i >= 0.07363786225                                      => 0.0261435769,
                                                                                        0.1245756326);

final_score_tree_131_c893 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i < 4.5 => -0.0127720645,
    r_l79_adls_per_addr_curr_i >= 4.5                                      => 0.1053981201,
                                                                              0.0272334668);

final_score_tree_131_c892 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d < 14.5 => final_score_tree_131_c893,
    f_rel_educationover12_count_d >= 14.5                                         => -0.0603080830,
                                                                                     0.0045875832);

final_score_tree_131_c890 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.2828478698 => final_score_tree_131_c891,
    f_add_curr_nhood_bus_pct_i >= 0.2828478698                                      => final_score_tree_131_c892,
                                                                                       0.0295041001);

final_score_tree_131 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.25518264605 => -0.0023704913,
    f_add_curr_nhood_bus_pct_i >= 0.25518264605                                      => final_score_tree_131_c890,
                                                                                        -0.0063028261);

final_score_tree_132_c897 := map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d < 89.5 => -0.0528011683,
    f_mos_liens_unrel_cj_lseen_d >= 89.5                                        => 0.0180165723,
                                                                                   0.0118502405);

final_score_tree_132_c896 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 23297 => final_score_tree_132_c897,
    f_curraddrmedianincome_d >= 23297                                    => -0.0007420873,
                                                                            0.0006358592);

final_score_tree_132_c898 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i < 0.2344727173 => -0.0055504610,
    f_add_curr_nhood_mfd_pct_i >= 0.2344727173                                      => 0.1395458551,
                                                                                       0.0554320486);

final_score_tree_132_c895 := map(
    NULL < f_srchssnsrchcountmo_i AND f_srchssnsrchcountmo_i < 3.5 => final_score_tree_132_c896,
    f_srchssnsrchcountmo_i >= 3.5                                  => final_score_tree_132_c898,
                                                                      0.0010172129);

final_score_tree_132 := map(
    NULL < f_mos_liens_rel_sc_lseen_d AND f_mos_liens_rel_sc_lseen_d < 181.5 => -0.0475863830,
    f_mos_liens_rel_sc_lseen_d >= 181.5                                      => final_score_tree_132_c895,
                                                                                -0.0235526034);

final_score_tree_133_c901 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d < 110 => -0.0106521375,
    r_d32_mos_since_crim_ls_d >= 110                                     => 0.1805116834,
                                                                            0.1222836230);

final_score_tree_133_c903 := map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i < 33082 => 0.0872535235,
    f_liens_unrel_cj_total_amt_i >= 33082                                        => -0.0515285200,
                                                                                    0.0536955703);

final_score_tree_133_c902 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d < 1.5 => -0.0186925467,
    f_rel_homeover300_count_d >= 1.5                                     => final_score_tree_133_c903,
                                                                            0.0099341965);

final_score_tree_133_c900 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d < 84.5 => final_score_tree_133_c901,
    r_c13_max_lres_d >= 84.5                            => final_score_tree_133_c902,
                                                           0.0346170251);

final_score_tree_133 := map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i < 13262 => -0.0034356418,
    f_liens_unrel_cj_total_amt_i >= 13262                                        => final_score_tree_133_c900,
                                                                                    -0.0020424076);

final_score_tree_134_c907 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i < 1.5 => 0.0400282360,
    f_varrisktype_i >= 1.5                           => -0.0216900510,
                                                        0.0138750078);

final_score_tree_134_c906 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d < 23.5 => -0.0017588151,
    f_rel_homeover100_count_d >= 23.5                                     => -0.0281803513,
                                                                             final_score_tree_134_c907);

final_score_tree_134_c905 := map(
    NULL < r_i60_inq_prepaidcards_count12_i AND r_i60_inq_prepaidcards_count12_i < 0.5 => final_score_tree_134_c906,
    r_i60_inq_prepaidcards_count12_i >= 0.5                                            => 0.0961242555,
                                                                                          -0.0020790361);

final_score_tree_134_c908 := map(
    NULL < r_i60_inq_banking_recency_d AND r_i60_inq_banking_recency_d < 549 => 0.1385430564,
    r_i60_inq_banking_recency_d >= 549                                       => 0.0212077547,
                                                                                0.0619889266);

final_score_tree_134 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d < 689758 => final_score_tree_134_c905,
    f_curraddrmedianvalue_d >= 689758                                   => final_score_tree_134_c908,
                                                                           -0.0100291940);

final_score_tree_135_c910 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d < 94238 => 0.0134948418,
    f_curraddrmedianvalue_d >= 94238                                   => -0.0498103843,
                                                                          -0.0315462848);

final_score_tree_135_c913 := map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i < 22359 => 0.0018662864,
    f_liens_rel_cj_total_amt_i >= 22359                                      => 0.1147026610,
                                                                                0.0021176143);

final_score_tree_135_c912 := map(
    NULL < f_liens_rel_sc_total_amt_i AND f_liens_rel_sc_total_amt_i < 573.5 => final_score_tree_135_c913,
    f_liens_rel_sc_total_amt_i >= 573.5                                      => -0.0547605173,
                                                                                0.0005287453);

final_score_tree_135_c911 := map(
    NULL < f_phones_per_addr_c6_i AND f_phones_per_addr_c6_i < 22.5 => final_score_tree_135_c912,
    f_phones_per_addr_c6_i >= 22.5                                  => 0.1162947980,
                                                                       0.0007739604);

final_score_tree_135 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d < 2.5 => final_score_tree_135_c910,
    r_c13_curr_addr_lres_d >= 2.5                                  => final_score_tree_135_c911,
                                                                      -0.0223320425);

final_score_tree_136_c917 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i < 9.5 => -0.0248950710,
    f_assocsuspicousidcount_i >= 9.5                                     => 0.1038835709,
                                                                            -0.0217670094);

final_score_tree_136_c916 := map(
    NULL < f_inq_auto_count24_i AND f_inq_auto_count24_i < 2.5 => 0.0022588628,
    f_inq_auto_count24_i >= 2.5                                => final_score_tree_136_c917,
                                                                  -0.0008529662);

final_score_tree_136_c918 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d < 2.5 => 0.0261103130,
    f_bus_addr_match_count_d >= 2.5                                    => 0.1383279346,
                                                                          0.0463662014);

final_score_tree_136_c915 := map(
    NULL < f_srchphonesrchcountmo_i AND f_srchphonesrchcountmo_i < 2.5 => final_score_tree_136_c916,
    f_srchphonesrchcountmo_i >= 2.5                                    => final_score_tree_136_c918,
                                                                          -0.0003245358);

final_score_tree_136 := map(
    NULL < r_d34_unrel_liens_ct_i AND r_d34_unrel_liens_ct_i < 18.5 => final_score_tree_136_c915,
    r_d34_unrel_liens_ct_i >= 18.5                                  => 0.0988822679,
                                                                       0.0026078407);

final_score_tree_137_c922 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d < -15174.5 => 0.0658088446,
    f_addrchangeincomediff_d >= -15174.5                                    => 0.0035813281,
                                                                               0.0076983995);

final_score_tree_137_c921 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d < 3.5 => final_score_tree_137_c922,
    r_c23_inp_addr_occ_index_d >= 3.5                                      => -0.0151679808,
                                                                              0.0028020417);

final_score_tree_137_c920 := map(
    NULL < r_i60_inq_auto_recency_d AND r_i60_inq_auto_recency_d < 549 => -0.0134417091,
    r_i60_inq_auto_recency_d >= 549                                    => final_score_tree_137_c921,
                                                                          -0.0044146356);

final_score_tree_137_c923 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d < 0.4009187534 => 0.0486226164,
    f_add_input_nhood_sfd_pct_d >= 0.4009187534                                       => -0.1000169955,
                                                                                         -0.0165701958);

final_score_tree_137 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 83.5 => final_score_tree_137_c920,
    k_comb_age_d >= 83.5                        => 0.0886486148,
                                                   final_score_tree_137_c923);

final_score_tree_138_c927 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => 0.0566248321,
    f_phone_ver_experian_d >= 0.5                                  => 0.0113985662,
                                                                      0.0862579892);

final_score_tree_138_c926 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d < 0.5 => -0.0146874242,
    f_rel_homeover200_count_d >= 0.5                                     => final_score_tree_138_c927,
                                                                            0.0166951645);

final_score_tree_138_c925 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d < 213.5 => -0.0003942466,
    r_c13_curr_addr_lres_d >= 213.5                                  => final_score_tree_138_c926,
                                                                        0.0012346020);

final_score_tree_138_c928 := map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i < 5.5 => 0.0116782375,
    f_sourcerisktype_i >= 5.5                              => 0.1557740582,
                                                              0.0617603215);

final_score_tree_138 := map(
    NULL < r_c19_add_prison_hist_i AND r_c19_add_prison_hist_i < 0.5 => final_score_tree_138_c925,
    r_c19_add_prison_hist_i >= 0.5                                   => final_score_tree_138_c928,
                                                                        0.0123754227);

final_score_tree_139_c931 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d < -28038.5 => 0.0740015144,
    f_addrchangevaluediff_d >= -28038.5                                   => -0.0318957533,
                                                                             -0.0650372345);

final_score_tree_139_c930 := map(
    NULL < f_mos_liens_unrel_st_fseen_d AND f_mos_liens_unrel_st_fseen_d < 95.5 => final_score_tree_139_c931,
    f_mos_liens_unrel_st_fseen_d >= 95.5                                        => 0.0005603627,
                                                                                   0.0156477291);

final_score_tree_139_c933 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i < 157.5 => -0.0656445721,
    f_prevaddrcartheftindex_i >= 157.5                                     => 0.1114087063,
                                                                              -0.0011465922);

final_score_tree_139_c932 := map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d < 3.5 => final_score_tree_139_c933,
    r_c14_addr_stability_v2_d >= 3.5                                     => 0.1454485013,
                                                                            0.0573656125);

final_score_tree_139 := map(
    NULL < r_l72_add_vacant_i AND r_l72_add_vacant_i < 0.5 => final_score_tree_139_c930,
    r_l72_add_vacant_i >= 0.5                              => final_score_tree_139_c932,
                                                              -0.0001625403);

final_score_tree_140_c938 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d < 147.5 => 0.0370042247,
    f_prevaddrageoldest_d >= 147.5                                 => 0.1207558256,
                                                                      0.0564697338);

final_score_tree_140_c937 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i < 0.5 => final_score_tree_140_c938,
    k_inq_adls_per_phone_i >= 0.5                                  => -0.0796284425,
                                                                      0.0420003488);

final_score_tree_140_c936 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i < 6.5 => 0.0010720558,
    r_p88_phn_dst_to_inp_add_i >= 6.5                                      => 0.0532990902,
                                                                              final_score_tree_140_c937);

final_score_tree_140_c935 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n < 0.5 => final_score_tree_140_c936,
    r_phn_cell_n >= 0.5                        => -0.0028115856,
                                                  0.0007553065);

final_score_tree_140 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n < 0.5 => final_score_tree_140_c935,
    r_phn_pcs_n >= 0.5                       => -0.0124322265,
                                                -0.0018766980);

final_score_tree_141_c940 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d < 55 => -0.0191852631,
    r_f01_inp_addr_address_score_d >= 55                                          => 0.0097085894,
                                                                                     0.0073472500);

final_score_tree_141_c942 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i < 188.5 => -0.0359898225,
    f_curraddrmurderindex_i >= 188.5                                   => 0.0894288231,
                                                                          -0.0253201785);

final_score_tree_141_c943 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.04881548115 => -0.0151860630,
    f_add_input_nhood_bus_pct_i >= 0.04881548115                                       => 0.1154051545,
                                                                                          0.0426329493);

final_score_tree_141_c941 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d < 52 => final_score_tree_141_c942,
    r_c12_source_profile_d >= 52                                  => final_score_tree_141_c943,
                                                                     0.0034018866);

final_score_tree_141 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d < 6.5 => -0.0094114002,
    f_rel_under25miles_cnt_d >= 6.5                                    => final_score_tree_141_c940,
                                                                          final_score_tree_141_c941);

final_score_tree_142_c946 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i < 0.21386969005 => 0.1901476798,
    f_add_curr_mobility_index_i >= 0.21386969005                                       => 0.0253160719,
                                                                                          0.0516000310);

final_score_tree_142_c945 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d < 6.5 => final_score_tree_142_c946,
    r_d32_mos_since_crim_ls_d >= 6.5                                     => 0.0052202731,
                                                                            0.0064832827);

final_score_tree_142_c948 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i < 0.00721840155 => 0.1346417318,
    f_add_curr_nhood_vac_pct_i >= 0.00721840155                                      => 0.0200379864,
                                                                                        0.0570264968);

final_score_tree_142_c947 := map(
    NULL < (integer)k_nap_contradictory_i AND (real)k_nap_contradictory_i < 0.5 => -0.0121232281,
    (real)k_nap_contradictory_i >= 0.5                                 => final_score_tree_142_c948,
                                                                    -0.0109625445);

final_score_tree_142 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d < 240.5 => final_score_tree_142_c945,
    r_c21_m_bureau_adl_fs_d >= 240.5                                   => final_score_tree_142_c947,
                                                                          0.0066030232);

final_score_tree_143_c953 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i < 0.07364826185 => -0.0216763834,
    f_add_curr_nhood_mfd_pct_i >= 0.07364826185                                      => 0.1166616497,
                                                                                        0.0736352536);

final_score_tree_143_c952 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i < 5.5 => 0.0197364080,
    r_c14_addrs_5yr_i >= 5.5                             => final_score_tree_143_c953,
                                                            0.0233613721);

final_score_tree_143_c951 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i < 51.5 => -0.0121302860,
    f_curraddrcartheftindex_i >= 51.5                                     => final_score_tree_143_c952,
                                                                             0.0154385399);

final_score_tree_143_c950 := map(
    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i < 0.5 => -0.0019384593,
    f_inq_highriskcredit_count24_i >= 0.5                                          => final_score_tree_143_c951,
                                                                                      0.0024676209);

final_score_tree_143 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i < 179.5 => final_score_tree_143_c950,
    f_prevaddrcartheftindex_i >= 179.5                                     => -0.0160894545,
                                                                              0.0012926306);

final_score_tree_144_c956 := map(
    NULL < f_mos_liens_unrel_st_fseen_d AND f_mos_liens_unrel_st_fseen_d < 104.5 => -0.0341658613,
    f_mos_liens_unrel_st_fseen_d >= 104.5                                        => 0.0051403925,
                                                                                    0.0033989303);

final_score_tree_144_c957 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i < 3.5 => 0.0228925508,
    r_c18_invalid_addrs_per_adl_i >= 3.5                                         => 0.1498581443,
                                                                                    0.0681974542);

final_score_tree_144_c955 := map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i < 16267 => final_score_tree_144_c956,
    f_liens_unrel_cj_total_amt_i >= 16267                                        => final_score_tree_144_c957,
                                                                                    0.0042915911);

final_score_tree_144_c958 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i < 5.5 => -0.0159566027,
    k_inq_ssns_per_addr_i >= 5.5                                 => 0.0940669978,
                                                                    -0.0144286801);

final_score_tree_144 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d < 289.5 => final_score_tree_144_c955,
    f_m_bureau_adl_fs_notu_d >= 289.5                                    => final_score_tree_144_c958,
                                                                            -0.0093851439);

final_score_tree_145_c962 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i < 9.5 => -0.0044927598,
    f_inq_communications_count24_i >= 9.5                                          => 0.0711816306,
                                                                                      -0.0042132677);

final_score_tree_145_c963 := map(
    NULL < (integer)k_nap_contradictory_i AND (real)k_nap_contradictory_i < 0.5 => -0.0025609556,
    (real)k_nap_contradictory_i >= 0.5                                 => 0.1255839029,
                                                                    -0.0000230348);

final_score_tree_145_c961 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i < 0.00697037635 => 0.0278342080,
    f_add_curr_nhood_mfd_pct_i >= 0.00697037635                                      => final_score_tree_145_c962,
                                                                                        final_score_tree_145_c963);

final_score_tree_145_c960 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i < 0 => 0.0802485633,
    f_varrisktype_i >= 0                           => final_score_tree_145_c961,
                                                      -0.0014537789);

final_score_tree_145 := map(
    NULL < f_historical_count_d AND f_historical_count_d < 30.5 => final_score_tree_145_c960,
    f_historical_count_d >= 30.5                                => 0.1648232457,
                                                                   -0.0019445826);

final_score_tree_146_c967 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 72.5 => -0.0133057737,
    k_comb_age_d >= 72.5                        => 0.0729937774,
                                                   -0.0120175750);

final_score_tree_146_c966 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i < 10.5 => final_score_tree_146_c967,
    r_d32_criminal_count_i >= 10.5                                  => 0.0551479604,
                                                                       -0.0101793448);

final_score_tree_146_c965 := map(
    NULL < f_srchphonesrchcountmo_i AND f_srchphonesrchcountmo_i < 1.5 => final_score_tree_146_c966,
    f_srchphonesrchcountmo_i >= 1.5                                    => 0.1214564170,
                                                                          -0.0092883604);

final_score_tree_146_c968 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d < 364.5 => 0.0091089834,
    r_c21_m_bureau_adl_fs_d >= 364.5                                   => -0.0249523011,
                                                                          0.0055545548);

final_score_tree_146 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i < 2.5 => final_score_tree_146_c965,
    f_srchvelocityrisktype_i >= 2.5                                    => final_score_tree_146_c968,
                                                                          -0.0157054029);

final_score_tree_147_c971 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.02238960855 => 0.0115892383,
    f_add_curr_nhood_bus_pct_i >= 0.02238960855                                      => -0.0780831857,
                                                                                        -0.0422142161);

final_score_tree_147_c970 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i < 15.5 => -0.0012628393,
    r_l79_adls_per_addr_c6_i >= 15.5                                    => final_score_tree_147_c971,
                                                                           -0.0017396826);

final_score_tree_147_c973 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i < 54.5 => -0.0410064856,
    f_curraddrburglaryindex_i >= 54.5                                     => 0.0303543565,
                                                                             0.0211388836);

final_score_tree_147_c972 := map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d < 8.5 => 0.1335506112,
    f_rel_homeover50_count_d >= 8.5                                    => final_score_tree_147_c973,
                                                                          0.0257210450);

final_score_tree_147 := map(
    NULL < f_rel_felony_count_i AND f_rel_felony_count_i < 2.5 => final_score_tree_147_c970,
    f_rel_felony_count_i >= 2.5                                => final_score_tree_147_c972,
                                                                  0.0041287116);

final_score_tree_148_c976 := map(
    NULL < r_a44_curr_add_naprop_d AND r_a44_curr_add_naprop_d < 0.5 => -0.0597841753,
    r_a44_curr_add_naprop_d >= 0.5                                   => 0.0866352425,
                                                                        0.0147939394);

final_score_tree_148_c975 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.38756075685 => -0.0016082838,
    f_add_input_mobility_index_i >= 0.38756075685                                        => -0.0218655041,
                                                                                            final_score_tree_148_c976);

final_score_tree_148_c978 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i < 1.5 => 0.0137307345,
    k_inq_adls_per_phone_i >= 1.5                                  => 0.0867846573,
                                                                      0.0178805432);

final_score_tree_148_c977 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i < 59.5 => final_score_tree_148_c978,
    f_phones_per_addr_curr_i >= 59.5                                    => -0.0439674010,
                                                                           0.0146746396);

final_score_tree_148 := map(
    NULL < r_d33_eviction_count_i AND r_d33_eviction_count_i < 1.5 => final_score_tree_148_c975,
    r_d33_eviction_count_i >= 1.5                                  => final_score_tree_148_c977,
                                                                      0.0027084970);

final_score_tree_149_c983 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => 0.1039573071,
    f_phone_ver_experian_d >= 0.5                                  => 0.0322958846,
                                                                      0.0563854588);

final_score_tree_149_c982 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d < 69.5 => -0.0454344365,
    r_c13_max_lres_d >= 69.5                            => final_score_tree_149_c983,
                                                           0.0343820069);

final_score_tree_149_c981 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n < 11.5 => final_score_tree_149_c982,
    f_util_adl_count_n >= 11.5                              => 0.1606438798,
                                                               0.0528760606);

final_score_tree_149_c980 := map(
    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i < 1.5 => final_score_tree_149_c981,
    k_inq_addrs_per_ssn_i >= 1.5                                 => -0.0037539222,
                                                                    0.0222171130);

final_score_tree_149 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i < 4.5 => -0.0022089028,
    k_inq_per_phone_i >= 4.5                             => final_score_tree_149_c980,
                                                            -0.0010248963);

final_score_tree_150_c987 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i < 45.5 => 0.0631015077,
    f_phones_per_addr_curr_i >= 45.5                                    => -0.0482723954,
                                                                           0.0200957431);

final_score_tree_150_c986 := map(
    NULL < f_hh_age_65_plus_d AND f_hh_age_65_plus_d < 0.5 => -0.0377105612,
    f_hh_age_65_plus_d >= 0.5                              => final_score_tree_150_c987,
                                                              -0.0278815431);

final_score_tree_150_c988 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d < 15.5 => -0.0231413050,
    f_rel_ageover30_count_d >= 15.5                                   => 0.0198256882,
                                                                         0.0783395460);

final_score_tree_150_c985 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.9112880107 => -0.0078146680,
    f_add_input_nhood_mfd_pct_i >= 0.9112880107                                       => final_score_tree_150_c986,
                                                                                         final_score_tree_150_c988);

final_score_tree_150 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i < 0.00853839315 => final_score_tree_150_c985,
    f_add_input_nhood_vac_pct_i >= 0.00853839315                                       => 0.0042788057,
                                                                                          -0.0009340733);

final_score_tree_151_c992 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d < 13.5 => 0.1419190324,
    f_rel_under500miles_cnt_d >= 13.5                                     => 0.0449194574,
                                                                             0.0712570903);

final_score_tree_151_c993 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.07444856385 => -0.0484545775,
    f_add_input_nhood_bus_pct_i >= 0.07444856385                                       => 0.0686102246,
                                                                                          -0.0105681506);

final_score_tree_151_c991 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d < 0.5 => final_score_tree_151_c992,
    f_phone_ver_experian_d >= 0.5                                  => final_score_tree_151_c993,
                                                                      0.0318181663);

final_score_tree_151_c990 := map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d < 10.5 => 0.0040133683,
    f_rel_homeover150_count_d >= 10.5                                     => final_score_tree_151_c991,
                                                                             0.0219609090);

final_score_tree_151 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i < 1.5 => -0.0047455056,
    f_srchcomponentrisktype_i >= 1.5                                     => final_score_tree_151_c990,
                                                                            0.0082121981);

final_score_tree_152_c997 := map(
    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d < 8.5 => 0.0678345189,
    f_rel_homeover150_count_d >= 8.5                                     => -0.0277665996,
                                                                            -0.0139422065);

final_score_tree_152_c996 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d < 95 => final_score_tree_152_c997,
    r_f00_ssn_score_d >= 95                             => 0.0023840877,
                                                           0.0034023917);

final_score_tree_152_c995 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d < 4.5 => -0.0168983824,
    f_prevaddrlenofres_d >= 4.5                                => final_score_tree_152_c996,
                                                                  0.0012073577);

final_score_tree_152_c998 := map(
    NULL < f_hh_bankruptcies_i AND f_hh_bankruptcies_i < 1.5 => 0.1855443654,
    f_hh_bankruptcies_i >= 1.5                               => 0.0076116688,
                                                                0.0931749327);

final_score_tree_152 := map(
    NULL < r_d31_bk_dism_recent_count_i AND r_d31_bk_dism_recent_count_i < 0.5 => final_score_tree_152_c995,
    r_d31_bk_dism_recent_count_i >= 0.5                                        => final_score_tree_152_c998,
                                                                                  0.0147776256);

final_score_tree_153_c1003 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i < 2.5 => 0.0228627846,
    r_l79_adls_per_addr_c6_i >= 2.5                                    => 0.0747640958,
                                                                          0.0396710867);

final_score_tree_153_c1002 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.2677212345 => 0.0089978104,
    f_add_input_mobility_index_i >= 0.2677212345                                        => final_score_tree_153_c1003,
                                                                                           0.0209480979);

final_score_tree_153_c1001 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.3096291614 => final_score_tree_153_c1002,
    f_add_input_nhood_bus_pct_i >= 0.3096291614                                       => -0.0807882460,
                                                                                         -0.0266551644);

final_score_tree_153_c1000 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i < 75 => final_score_tree_153_c1001,
    f_curraddrburglaryindex_i >= 75                                     => -0.0023118716,
                                                                           0.0022358973);

final_score_tree_153 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i < 86 => -0.0107020593,
    f_prevaddrcartheftindex_i >= 86                                     => final_score_tree_153_c1000,
                                                                           0.0120223677);

final_score_tree_154_c1007 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d < 3.5 => 0.0014423583,
    f_rel_homeover300_count_d >= 3.5                                     => 0.1261716282,
                                                                            0.0335364394);

final_score_tree_154_c1008 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i < 10.5 => 0.0419725466,
    r_d30_derog_count_i >= 10.5                               => -0.0475211350,
                                                                 0.0154375876);

final_score_tree_154_c1006 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d < 39057.5 => 0.1490141889,
    r_l80_inp_avm_autoval_d >= 39057.5                                   => final_score_tree_154_c1007,
                                                                            final_score_tree_154_c1008);

final_score_tree_154_c1005 := map(
    NULL < r_d33_eviction_recency_d AND r_d33_eviction_recency_d < 30 => final_score_tree_154_c1006,
    r_d33_eviction_recency_d >= 30                                    => 0.0006023051,
                                                                         0.0020131041);

final_score_tree_154 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i < 182 => final_score_tree_154_c1005,
    f_curraddrcartheftindex_i >= 182                                     => -0.0216558388,
                                                                            -0.0078055039);

final_score_tree_155_c1010 := map(
    NULL < f_mos_liens_unrel_sc_fseen_d AND f_mos_liens_unrel_sc_fseen_d < 156.5 => 0.0187224721,
    f_mos_liens_unrel_sc_fseen_d >= 156.5                                        => -0.0076165771,
                                                                                    -0.0446765424);

final_score_tree_155_c1013 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d < 1.5 => -0.0920644473,
    f_rel_ageover30_count_d >= 1.5                                   => 0.0372511856,
                                                                        0.0271062651);

final_score_tree_155_c1012 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i < 15.5 => -0.0014632974,
    r_p88_phn_dst_to_inp_add_i >= 15.5                                      => final_score_tree_155_c1013,
                                                                               0.0102069350);

final_score_tree_155_c1011 := map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d < 206.5 => 0.0761291878,
    r_d32_mos_since_fel_ls_d >= 206.5                                    => final_score_tree_155_c1012,
                                                                            0.0074262463);

final_score_tree_155 := map(
    NULL < (integer)k_inf_contradictory_i AND (real)k_inf_contradictory_i < 0.5 => final_score_tree_155_c1010,
    (real)k_inf_contradictory_i >= 0.5                                 => final_score_tree_155_c1011,
                                                                    -0.0014206351);

final_score_tree_156_c1018 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d < 94 => -0.0672104141,
    r_c21_m_bureau_adl_fs_d >= 94                                   => 0.0649980643,
                                                                       -0.0152440758);

final_score_tree_156_c1017 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d < 1.5 => 0.0323545138,
    f_rel_homeover100_count_d >= 1.5                                     => -0.0211512428,
                                                                            final_score_tree_156_c1018);

final_score_tree_156_c1016 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d < 3.5 => 0.0061993442,
    r_c23_inp_addr_occ_index_d >= 3.5                                      => final_score_tree_156_c1017,
                                                                              0.0041189540);

final_score_tree_156_c1015 := map(
    NULL < f_inq_highriskcredit_cnt_day_i AND f_inq_highriskcredit_cnt_day_i < 0.5 => final_score_tree_156_c1016,
    f_inq_highriskcredit_cnt_day_i >= 0.5                                          => -0.0761289263,
                                                                                      0.0037816096);

final_score_tree_156 := map(
    NULL < f_liens_rel_sc_total_amt_i AND f_liens_rel_sc_total_amt_i < 350.5 => final_score_tree_156_c1015,
    f_liens_rel_sc_total_amt_i >= 350.5                                      => -0.0462807424,
                                                                                0.0058063394);

final_score_tree_157_c1021 := map(
    NULL < r_c14_addrs_10yr_i AND r_c14_addrs_10yr_i < 3.5 => 0.0361549956,
    r_c14_addrs_10yr_i >= 3.5                              => 0.1867985524,
                                                              0.1028461536);

final_score_tree_157_c1020 := map(
    NULL < r_prop_owner_history_d AND r_prop_owner_history_d < 0.5 => final_score_tree_157_c1021,
    r_prop_owner_history_d >= 0.5                                  => -0.0022199050,
                                                                      0.0432140663);

final_score_tree_157_c1022 := map(
    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d < 99.5 => 0.0409067194,
    f_attr_arrest_recency_d >= 99.5                                   => -0.0016307978,
                                                                         -0.0009952028);

final_score_tree_157_c1023 := map(
    NULL < f_rel_count_i AND f_rel_count_i < 3.5 => 0.0685422348,
    f_rel_count_i >= 3.5                         => -0.0081830262,
                                                    -0.0180410462);

final_score_tree_157 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.0021715552 => final_score_tree_157_c1020,
    f_add_curr_nhood_bus_pct_i >= 0.0021715552                                      => final_score_tree_157_c1022,
                                                                                       final_score_tree_157_c1023);

final_score_tree_158_c1027 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.05640121315 => -0.0242019285,
    f_add_input_nhood_bus_pct_i >= 0.05640121315                                       => 0.0986060266,
                                                                                          -0.0285773652);

final_score_tree_158_c1026 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d < 56.2 => 0.1132148432,
    r_c12_source_profile_d >= 56.2                                  => final_score_tree_158_c1027,
                                                                       0.0474415649);

final_score_tree_158_c1028 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d < 397.5 => 0.0035612080,
    f_m_bureau_adl_fs_notu_d >= 397.5                                    => 0.1260550133,
                                                                            0.0072090972);

final_score_tree_158_c1025 := map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d < 2.5 => final_score_tree_158_c1026,
    f_rel_incomeover25_count_d >= 2.5                                      => final_score_tree_158_c1028,
                                                                              0.0129842760);

final_score_tree_158 := map(
    NULL < f_hh_age_65_plus_d AND f_hh_age_65_plus_d < 0.5 => -0.0044352770,
    f_hh_age_65_plus_d >= 0.5                              => final_score_tree_158_c1025,
                                                              0.0048408212);

final_score_tree_159_c1030 := map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i < 160.5 => -0.0027448551,
    f_prevaddrmurderindex_i >= 160.5                                   => 0.0117097157,
                                                                          0.0008678737);

final_score_tree_159_c1033 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '3: Derog', '4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) => 0.0456511976,
    (nf_seg_fraudpoint_3_0 in ['2: Synth ID'])                                                                              => 0.1653015342,
                                                                                                                               0.0758238912);

final_score_tree_159_c1032 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.1320750881 => -0.0522575918,
    f_add_input_mobility_index_i >= 0.1320750881                                        => final_score_tree_159_c1033,
                                                                                           0.0496757684);

final_score_tree_159_c1031 := map(
    NULL < r_l78_no_phone_at_addr_vel_i AND r_l78_no_phone_at_addr_vel_i < 0.5 => -0.0204937867,
    r_l78_no_phone_at_addr_vel_i >= 0.5                                        => final_score_tree_159_c1032,
                                                                                  -0.0004282799);

final_score_tree_159 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.53602590845 => final_score_tree_159_c1030,
    f_add_curr_nhood_bus_pct_i >= 0.53602590845                                      => 0.1388622608,
                                                                                        final_score_tree_159_c1031);

final_score_tree_160_c1035 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i < 1433.5 => 0.0071484487,
    r_p88_phn_dst_to_inp_add_i >= 1433.5                                      => 0.1341383869,
                                                                                 0.0035958103);

final_score_tree_160_c1038 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d < 34.5 => -0.0534511217,
    r_c13_max_lres_d >= 34.5                            => 0.0778112024,
                                                           0.0106884230);

final_score_tree_160_c1037 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.02014633215 => final_score_tree_160_c1038,
    f_add_input_nhood_bus_pct_i >= 0.02014633215                                       => -0.0308358551,
                                                                                          -0.0190966607);

final_score_tree_160_c1036 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.40792497165 => final_score_tree_160_c1037,
    f_add_input_mobility_index_i >= 0.40792497165                                        => 0.0517720519,
                                                                                            -0.0102380716);

final_score_tree_160 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d < 8.5 => final_score_tree_160_c1035,
    f_rel_homeover100_count_d >= 8.5                                     => -0.0087572922,
                                                                            final_score_tree_160_c1036);

final_score_tree_161_c1042 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i < 9927.5 => 0.0011737775,
    r_a49_curr_avm_chg_1yr_i >= 9927.5                                    => 0.0757725831,
                                                                             -0.0266356878);

final_score_tree_161_c1041 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d < 185850.5 => final_score_tree_161_c1042,
    r_a46_curr_avm_autoval_d >= 185850.5                                    => -0.0597608492,
                                                                               -0.0237402139);

final_score_tree_161_c1040 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.4025441705 => 0.0023238393,
    f_add_input_mobility_index_i >= 0.4025441705                                        => final_score_tree_161_c1041,
                                                                                           -0.0287678544);

final_score_tree_161_c1043 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d < 81854 => 0.0120118655,
    f_prevaddrmedianincome_d >= 81854                                    => 0.1045866173,
                                                                            0.0188325103);

final_score_tree_161 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i < 0.5 => final_score_tree_161_c1040,
    f_srchunvrfdaddrcount_i >= 0.5                                   => final_score_tree_161_c1043,
                                                                        0.0141699277);

final_score_tree_162_c1046 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d < 17500 => 0.1025848106,
    r_l80_inp_avm_autoval_d >= 17500                                   => 0.0243314178,
                                                                          -0.0017460670);

final_score_tree_162_c1045 := map(
    NULL < r_d33_eviction_count_i AND r_d33_eviction_count_i < 1.5 => -0.0060438983,
    r_d33_eviction_count_i >= 1.5                                  => final_score_tree_162_c1046,
                                                                      -0.0485041085);

final_score_tree_162_c1048 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d < -30079 => 0.0564828813,
    f_addrchangevaluediff_d >= -30079                                   => 0.0093323271,
                                                                           -0.0054773687);

final_score_tree_162_c1047 := map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d < 0.5 => 0.1329228695,
    f_hh_age_18_plus_d >= 0.5                              => final_score_tree_162_c1048,
                                                              0.0146864570);

final_score_tree_162 := map(
    NULL < r_l78_no_phone_at_addr_vel_i AND r_l78_no_phone_at_addr_vel_i < 0.5 => final_score_tree_162_c1045,
    r_l78_no_phone_at_addr_vel_i >= 0.5                                        => final_score_tree_162_c1047,
                                                                                  -0.0020099603);

final_score_tree_163_c1052 := map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d < 14.5 => -0.0125972323,
    f_rel_incomeover25_count_d >= 14.5                                      => 0.0817581268,
                                                                               0.0049673807);

final_score_tree_163_c1051 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d < 230 => final_score_tree_163_c1052,
    r_c13_max_lres_d >= 230                            => 0.1120387470,
                                                          0.0176067414);

final_score_tree_163_c1050 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d < 15017.5 => 0.1126100492,
    f_prevaddrmedianincome_d >= 15017.5                                    => final_score_tree_163_c1051,
                                                                              0.0250882519);

final_score_tree_163_c1053 := map(
    NULL < r_s65_ssn_invalid_i AND r_s65_ssn_invalid_i < 0.5 => 0.0112768837,
    r_s65_ssn_invalid_i >= 0.5                               => -0.0829901894,
                                                                -0.0039130712);

final_score_tree_163 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d < 0.5 => final_score_tree_163_c1050,
    f_rel_under25miles_cnt_d >= 0.5                                    => -0.0036112943,
                                                                          final_score_tree_163_c1053);

final_score_tree_164_c1058 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.01041465875 => -0.0259230428,
    f_add_curr_nhood_bus_pct_i >= 0.01041465875                                      => -0.0028699185,
                                                                                        -0.0919052535);

final_score_tree_164_c1057 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d < 9.5 => final_score_tree_164_c1058,
    f_rel_homeover300_count_d >= 9.5                                     => -0.1017092180,
                                                                            -0.0466710750);

final_score_tree_164_c1056 := map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i < 194.5 => final_score_tree_164_c1057,
    f_prevaddrmurderindex_i >= 194.5                                   => -0.1026975558,
                                                                          -0.0187327078);

final_score_tree_164_c1055 := map(
    NULL < f_mos_liens_rel_cj_fseen_d AND f_mos_liens_rel_cj_fseen_d < 148.5 => 0.0612325060,
    f_mos_liens_rel_cj_fseen_d >= 148.5                                      => final_score_tree_164_c1056,
                                                                                -0.0139950124);

final_score_tree_164 := map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i < 1.5 => 0.0014411393,
    r_i60_inq_comm_count12_i >= 1.5                                    => final_score_tree_164_c1055,
                                                                          0.0260076267);

final_score_tree_165_c1061 := map(
    NULL < f_hh_criminals_i AND f_hh_criminals_i < 1.5 => 0.0445235542,
    f_hh_criminals_i >= 1.5                            => -0.0129010742,
                                                          0.0309784322);

final_score_tree_165_c1060 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i < 3.5 => 0.0042364067,
    f_varrisktype_i >= 3.5                           => final_score_tree_165_c1061,
                                                        0.0076722087);

final_score_tree_165_c1063 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i < 0.0032888809 => -0.0275938938,
    f_add_input_nhood_vac_pct_i >= 0.0032888809                                       => 0.0699533182,
                                                                                         0.0345195019);

final_score_tree_165_c1062 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d < 23404 => final_score_tree_165_c1063,
    f_prevaddrmedianincome_d >= 23404                                    => -0.0286223513,
                                                                            0.0020625260);

final_score_tree_165 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d < 6.5 => -0.0061686098,
    f_rel_under25miles_cnt_d >= 6.5                                    => final_score_tree_165_c1060,
                                                                          final_score_tree_165_c1062);

final_score_tree_166_c1068 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.2822321483 => 0.1389064731,
    f_add_input_mobility_index_i >= 0.2822321483                                        => 0.0332374961,
                                                                                           0.0939257599);

final_score_tree_166_c1067 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d < 59.5 => final_score_tree_166_c1068,
    f_prevaddrlenofres_d >= 59.5                                => 0.0014887649,
                                                                   0.0535065416);

final_score_tree_166_c1066 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 32712 => final_score_tree_166_c1067,
    f_curraddrmedianincome_d >= 32712                                    => -0.0234853713,
                                                                            0.0118529761);

final_score_tree_166_c1065 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.06110375705 => 0.1891928537,
    f_add_input_nhood_mfd_pct_i >= 0.06110375705                                       => final_score_tree_166_c1066,
                                                                                          0.0273843348);

final_score_tree_166 := map(
    NULL < f_divrisktype_i AND f_divrisktype_i < 5.5 => -0.0006999545,
    f_divrisktype_i >= 5.5                           => final_score_tree_166_c1065,
                                                        0.0071380586);

final_score_tree_167_c1073 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.04995697075 => 0.0079956745,
    f_add_curr_nhood_bus_pct_i >= 0.04995697075                                      => 0.1231912031,
                                                                                        0.0518024248);

final_score_tree_167_c1072 := map(
    NULL < r_p85_phn_invalid_i AND r_p85_phn_invalid_i < 0.5 => 0.0016470188,
    r_p85_phn_invalid_i >= 0.5                               => final_score_tree_167_c1073,
                                                                0.0019715463);

final_score_tree_167_c1071 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d < 78.5 => final_score_tree_167_c1072,
    f_bus_addr_match_count_d >= 78.5                                    => -0.0990919553,
                                                                           0.0017500372);

final_score_tree_167_c1070 := map(
    NULL < f_mos_liens_unrel_st_fseen_d AND f_mos_liens_unrel_st_fseen_d < 96.5 => -0.0349692454,
    f_mos_liens_unrel_st_fseen_d >= 96.5                                        => final_score_tree_167_c1071,
                                                                                   0.0011524277);

final_score_tree_167 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d < 104 => final_score_tree_167_c1070,
    f_bus_addr_match_count_d >= 104                                    => 0.0797986950,
                                                                          0.0006108496);

final_score_tree_168_c1078 := map(
    NULL < (integer)k_inf_contradictory_i AND (real)k_inf_contradictory_i < 0.5 => 0.0008571222,
    (real)k_inf_contradictory_i >= 0.5                                 => 0.0468857962,
                                                                    0.0148140471);

final_score_tree_168_c1077 := map(
    NULL < f_util_add_curr_conv_n AND f_util_add_curr_conv_n < 0.5 => -0.0274665908,
    f_util_add_curr_conv_n >= 0.5                                  => final_score_tree_168_c1078,
                                                                      0.0048325406);

final_score_tree_168_c1076 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i < 16.5 => final_score_tree_168_c1077,
    r_d30_derog_count_i >= 16.5                               => 0.1102930647,
                                                                 0.0079707551);

final_score_tree_168_c1075 := map(
    NULL < r_d33_eviction_recency_d AND r_d33_eviction_recency_d < 79.5 => 0.0628524801,
    r_d33_eviction_recency_d >= 79.5                                    => final_score_tree_168_c1076,
                                                                           0.0141323113);

final_score_tree_168 := map(
    NULL < f_addrs_per_ssn_c6_i AND f_addrs_per_ssn_c6_i < 0.5 => -0.0019614238,
    f_addrs_per_ssn_c6_i >= 0.5                                => final_score_tree_168_c1075,
                                                                  -0.0000839396);

final_score_tree_169_c1083 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.0543088674 => 0.0766686402,
    f_add_input_nhood_bus_pct_i >= 0.0543088674                                       => 0.0076563139,
                                                                                         0.0470673431);

final_score_tree_169_c1082 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i < 0.1522950307 => -0.0188373681,
    f_add_curr_nhood_mfd_pct_i >= 0.1522950307                                      => final_score_tree_169_c1083,
                                                                                       0.0221180092);

final_score_tree_169_c1081 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.48680934335 => final_score_tree_169_c1082,
    f_add_input_mobility_index_i >= 0.48680934335                                        => 0.1304800231,
                                                                                            0.0306416802);

final_score_tree_169_c1080 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d < 28.5 => final_score_tree_169_c1081,
    f_m_bureau_adl_fs_notu_d >= 28.5                                    => -0.0014032625,
                                                                           0.0409854996);

final_score_tree_169 := map(
    NULL < r_s65_ssn_problem_i AND r_s65_ssn_problem_i < 0.5 => final_score_tree_169_c1080,
    r_s65_ssn_problem_i >= 0.5                               => -0.0323635645,
                                                                -0.0014982992);

final_score_tree_170_c1087 := map(
    NULL < f_historical_count_d AND f_historical_count_d < 2.5 => 0.1263195654,
    f_historical_count_d >= 2.5                                => -0.0174570399,
                                                                  0.0634928135);

final_score_tree_170_c1088 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.26904018915 => 0.0000431453,
    f_add_input_mobility_index_i >= 0.26904018915                                        => -0.0303098534,
                                                                                            -0.0603340056);

final_score_tree_170_c1086 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d < 11.5 => final_score_tree_170_c1087,
    r_d32_mos_since_crim_ls_d >= 11.5                                     => final_score_tree_170_c1088,
                                                                             -0.0159486988);

final_score_tree_170_c1085 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d < 65141 => final_score_tree_170_c1086,
    f_curraddrmedianvalue_d >= 65141                                   => 0.0019638193,
                                                                          -0.0006148197);

final_score_tree_170 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d < 1.5 => 0.0290281713,
    f_phone_ver_insurance_d >= 1.5                                   => final_score_tree_170_c1085,
                                                                        -0.0027884833);

final_score_tree_171_c1092 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i < 30.5 => 0.0052588676,
    f_addrs_per_ssn_i >= 30.5                             => 0.1583940372,
                                                             0.0071549798);

final_score_tree_171_c1091 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i < 118.5 => -0.0018672388,
    f_addrchangecrimediff_i >= 118.5                                   => 0.0548257212,
                                                                          final_score_tree_171_c1092);

final_score_tree_171_c1090 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d < 685043 => final_score_tree_171_c1091,
    f_curraddrmedianvalue_d >= 685043                                   => 0.0444448362,
                                                                           0.0005810732);

final_score_tree_171_c1093 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.2686861371 => 0.0177724312,
    f_add_input_mobility_index_i >= 0.2686861371                                        => 0.1399949659,
                                                                                           0.0877546890);

final_score_tree_171 := map(
    NULL < f_vardobcountnew_i AND f_vardobcountnew_i < 1.5 => final_score_tree_171_c1090,
    f_vardobcountnew_i >= 1.5                              => final_score_tree_171_c1093,
                                                              -0.0085236467);

final_score_tree_172_c1095 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i < 0.5 => 0.0114891192,
    r_p85_phn_disconnected_i >= 0.5                                    => 0.1106189365,
                                                                          0.0132755244);

final_score_tree_172_c1098 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i < 102 => -0.0153881600,
    r_p88_phn_dst_to_inp_add_i >= 102                                      => 0.1360102436,
                                                                              -0.0248534917);

final_score_tree_172_c1097 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i < 0.9972817098 => -0.0015129812,
    f_add_curr_nhood_mfd_pct_i >= 0.9972817098                                      => -0.0844069616,
                                                                                       final_score_tree_172_c1098);

final_score_tree_172_c1096 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d < 60254.5 => final_score_tree_172_c1097,
    f_addrchangevaluediff_d >= 60254.5                                   => -0.0319617544,
                                                                            0.0037912195);

final_score_tree_172 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i < 0.5 => final_score_tree_172_c1095,
    r_l79_adls_per_addr_curr_i >= 0.5                                      => final_score_tree_172_c1096,
                                                                              -0.0279032959);

final_score_tree_173_c1102 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d < 21513.5 => 0.0761832353,
    f_prevaddrmedianincome_d >= 21513.5                                    => -0.0057725744,
                                                                              -0.0030544190);

final_score_tree_173_c1101 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d < 1.5 => -0.0257402396,
    f_rel_incomeover75_count_d >= 1.5                                      => final_score_tree_173_c1102,
                                                                              -0.0106751416);

final_score_tree_173_c1103 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d < 99914.5 => 0.1358699135,
    r_a46_curr_avm_autoval_d >= 99914.5                                    => 0.0128975408,
                                                                              0.0012229716);

final_score_tree_173_c1100 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d < 2.5 => 0.0029966833,
    f_rel_homeover300_count_d >= 2.5                                     => final_score_tree_173_c1101,
                                                                            final_score_tree_173_c1103);

final_score_tree_173 := map(
    NULL < f_liens_unrel_ot_total_amt_i AND f_liens_unrel_ot_total_amt_i < 18409 => final_score_tree_173_c1100,
    f_liens_unrel_ot_total_amt_i >= 18409                                        => 0.1035810285,
                                                                                    0.0048877996);

final_score_tree_174_c1108 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i < 0.021481215 => -0.0185098407,
    f_add_input_nhood_vac_pct_i >= 0.021481215                                       => 0.0633313309,
                                                                                        -0.0005447055);

final_score_tree_174_c1107 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i < 110.45 => -0.0140018515,
    r_a49_curr_avm_chg_1yr_pct_i >= 110.45                                        => -0.1157628942,
                                                                                     final_score_tree_174_c1108);

final_score_tree_174_c1106 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i < 184.5 => final_score_tree_174_c1107,
    f_curraddrmurderindex_i >= 184.5                                   => -0.1055197380,
                                                                          -0.0252409361);

final_score_tree_174_c1105 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d < 529541.5 => 0.0018181057,
    f_curraddrmedianvalue_d >= 529541.5                                   => final_score_tree_174_c1106,
                                                                             0.0009846806);

final_score_tree_174 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i < 10.5 => final_score_tree_174_c1105,
    f_inq_communications_count24_i >= 10.5                                          => 0.0811875126,
                                                                                       0.0269428121);

final_score_tree_175_c1110 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d < 1.5 => -0.0456977067,
    f_rel_homeover200_count_d >= 1.5                                     => 0.1806886541,
                                                                            0.0908527967);

final_score_tree_175_c1113 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 17962 => 0.1637371804,
    f_curraddrmedianincome_d >= 17962                                    => 0.0181726664,
                                                                            0.0268606385);

final_score_tree_175_c1112 := map(
    NULL < r_l71_add_business_i AND r_l71_add_business_i < 0.5 => -0.0005150974,
    r_l71_add_business_i >= 0.5                                => final_score_tree_175_c1113,
                                                                  0.0005020429);

final_score_tree_175_c1111 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d < 1.5 => -0.0325325323,
    r_c13_curr_addr_lres_d >= 1.5                                  => final_score_tree_175_c1112,
                                                                      -0.0005643213);

final_score_tree_175 := map(
    NULL < f_accident_recency_d AND f_accident_recency_d < 2 => final_score_tree_175_c1110,
    f_accident_recency_d >= 2                                => final_score_tree_175_c1111,
                                                                0.0303127057);

final_score_tree_176_c1117 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d < 128.5 => -0.0577279815,
    r_c13_max_lres_d >= 128.5                            => 0.0869670762,
                                                            0.0087245635);

final_score_tree_176_c1116 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 1.0240876673 => 0.1266769190,
    f_add_input_mobility_index_i >= 1.0240876673                                        => final_score_tree_176_c1117,
                                                                                           0.0542500341);

final_score_tree_176_c1115 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.91436195295 => 0.0007750065,
    f_add_input_mobility_index_i >= 0.91436195295                                        => final_score_tree_176_c1116,
                                                                                            -0.0114633195);

final_score_tree_176_c1118 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i < 1.5 => 0.0948746062,
    r_d30_derog_count_i >= 1.5                               => -0.0038899659,
                                                                0.0489968695);

final_score_tree_176 := map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i < 0.5 => final_score_tree_176_c1115,
    r_p85_phn_not_issued_i >= 0.5                                  => final_score_tree_176_c1118,
                                                                      0.0014584458);

final_score_tree_177_c1122 := map(
    NULL < f_mos_liens_rel_ot_fseen_d AND f_mos_liens_rel_ot_fseen_d < 84.5 => 0.0050457972,
    f_mos_liens_rel_ot_fseen_d >= 84.5                                      => -0.0463984142,
                                                                               0.0026531995);

final_score_tree_177_c1121 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i < 0.0347773955 => final_score_tree_177_c1122,
    f_add_curr_nhood_vac_pct_i >= 0.0347773955                                      => 0.1276054085,
                                                                                       0.0035204729);

final_score_tree_177_c1123 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d < 0.0115103581 => -0.0522054766,
    f_add_input_nhood_sfd_pct_d >= 0.0115103581                                       => -0.0064827152,
                                                                                         -0.0079061269);

final_score_tree_177_c1120 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i < 0.0354802947 => final_score_tree_177_c1121,
    f_add_curr_nhood_vac_pct_i >= 0.0354802947                                      => final_score_tree_177_c1123,
                                                                                       -0.0007576624);

final_score_tree_177 := map(
    NULL < r_d31_bk_dism_recent_count_i AND r_d31_bk_dism_recent_count_i < 0.5 => final_score_tree_177_c1120,
    r_d31_bk_dism_recent_count_i >= 0.5                                        => 0.0697364993,
                                                                                  -0.0127149063);

final_score_tree_178_c1128 := map(
    NULL < f_hh_age_30_plus_d AND f_hh_age_30_plus_d < 6.5 => 0.0030776222,
    f_hh_age_30_plus_d >= 6.5                              => -0.0311516704,
                                                              0.0023278510);

final_score_tree_178_c1127 := map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d < 13.5 => final_score_tree_178_c1128,
    f_hh_age_18_plus_d >= 13.5                              => 0.0740082370,
                                                               0.0025381431);

final_score_tree_178_c1126 := map(
    NULL < f_hh_bankruptcies_i AND f_hh_bankruptcies_i < 3.5 => final_score_tree_178_c1127,
    f_hh_bankruptcies_i >= 3.5                               => -0.0763029779,
                                                                0.0019736025);

final_score_tree_178_c1125 := map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d < 45.5 => 0.0948773609,
    r_d32_mos_since_fel_ls_d >= 45.5                                    => final_score_tree_178_c1126,
                                                                           0.0021798553);

final_score_tree_178 := map(
    NULL < f_curraddrcrimeindex_i AND f_curraddrcrimeindex_i < 199.5 => final_score_tree_178_c1125,
    f_curraddrcrimeindex_i >= 199.5                                  => 0.1089016764,
                                                                        -0.0075679073);

final_score_tree_179_c1133 := map(
    NULL < f_rel_educationover8_count_d AND f_rel_educationover8_count_d < 12.5 => 0.0010708822,
    f_rel_educationover8_count_d >= 12.5                                        => 0.0890716104,
                                                                                   0.0403948791);

final_score_tree_179_c1132 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i < 49 => final_score_tree_179_c1133,
    f_fp_prevaddrcrimeindex_i >= 49                                     => -0.0054394020,
                                                                           -0.0030613417);

final_score_tree_179_c1131 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i < 57 => -0.0410918171,
    f_curraddrcartheftindex_i >= 57                                     => final_score_tree_179_c1132,
                                                                           -0.0080457997);

final_score_tree_179_c1130 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i < 0.03553838075 => 0.0050657112,
    f_add_curr_nhood_vac_pct_i >= 0.03553838075                                      => final_score_tree_179_c1131,
                                                                                        0.0001158861);

final_score_tree_179 := map(
    NULL < r_c15_ssns_per_adl_i AND r_c15_ssns_per_adl_i < 1.5 => final_score_tree_179_c1130,
    r_c15_ssns_per_adl_i >= 1.5                                => -0.0694134849,
                                                                  -0.0073483379);

final_score_tree_180_c1137 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i < 0.3125536735 => -0.0072022871,
    f_add_curr_mobility_index_i >= 0.3125536735                                       => 0.0593839152,
                                                                                         0.0166605022);

final_score_tree_180_c1136 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i < 6.5 => -0.0092331198,
    r_l79_adls_per_addr_curr_i >= 6.5                                      => final_score_tree_180_c1137,
                                                                              -0.0045598590);

final_score_tree_180_c1138 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.03349782955 => 0.1532285877,
    f_add_curr_nhood_bus_pct_i >= 0.03349782955                                      => 0.0087063398,
                                                                                        0.0662476052);

final_score_tree_180_c1135 := map(
    NULL < r_c14_addrs_15yr_i AND r_c14_addrs_15yr_i < 11.5 => final_score_tree_180_c1136,
    r_c14_addrs_15yr_i >= 11.5                              => final_score_tree_180_c1138,
                                                               0.0039360614);

final_score_tree_180 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d < -62994.5 => -0.0787509815,
    f_addrchangeincomediff_d >= -62994.5                                    => 0.0014092330,
                                                                               final_score_tree_180_c1135);

final_score_tree_181_c1142 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d < 1.5 => -0.1321634315,
    f_rel_ageover40_count_d >= 1.5                                   => -0.0222050613,
                                                                        -0.0868427519);

final_score_tree_181_c1143 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.0318799271 => -0.0427063511,
    f_add_input_nhood_bus_pct_i >= 0.0318799271                                       => 0.0783612388,
                                                                                         0.0275909592);

final_score_tree_181_c1141 := map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d < 2.5 => final_score_tree_181_c1142,
    f_hh_age_18_plus_d >= 2.5                              => final_score_tree_181_c1143,
                                                              -0.0299880284);

final_score_tree_181_c1140 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i < 191.5 => 0.0173880812,
    f_curraddrcartheftindex_i >= 191.5                                     => final_score_tree_181_c1141,
                                                                              0.0135146399);

final_score_tree_181 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d < 2.5 => -0.0034593817,
    f_bus_addr_match_count_d >= 2.5                                    => final_score_tree_181_c1140,
                                                                          -0.0008279352);

final_score_tree_182_c1146 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d < 0.5 => 0.0281021734,
    f_rel_under25miles_cnt_d >= 0.5                                    => -0.0036550606,
                                                                          0.0069367127);

final_score_tree_182_c1148 := map(
    NULL < r_d33_eviction_recency_d AND r_d33_eviction_recency_d < 48 => 0.1282506785,
    r_d33_eviction_recency_d >= 48                                    => 0.0219381109,
                                                                         0.0340514732);

final_score_tree_182_c1147 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d < 251694.5 => 0.0018288980,
    r_l80_inp_avm_autoval_d >= 251694.5                                   => 0.1704542069,
                                                                             final_score_tree_182_c1148);

final_score_tree_182_c1145 := map(
    NULL < f_util_add_curr_inf_n AND f_util_add_curr_inf_n < 0.5 => final_score_tree_182_c1146,
    f_util_add_curr_inf_n >= 0.5                                 => final_score_tree_182_c1147,
                                                                    -0.0006348233);

final_score_tree_182 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d < 750678 => final_score_tree_182_c1145,
    f_prevaddrmedianvalue_d >= 750678                                   => -0.0628714644,
                                                                           -0.0210450356);

final_score_tree_183_c1151 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d < 2.5 => 0.1006006739,
    f_phone_ver_insurance_d >= 2.5                                   => -0.0482476938,
                                                                        0.0563674326);

final_score_tree_183_c1152 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i < 0.95845227985 => -0.0041126736,
    f_add_curr_nhood_mfd_pct_i >= 0.95845227985                                      => 0.0363958959,
                                                                                        0.0111538809);

final_score_tree_183_c1150 := map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d < 0.5 => final_score_tree_183_c1151,
    f_hh_age_18_plus_d >= 0.5                              => final_score_tree_183_c1152,
                                                              -0.0112797906);

final_score_tree_183_c1153 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i < 0.020378128 => -0.0050627945,
    f_add_curr_nhood_vac_pct_i >= 0.020378128                                      => -0.0671680467,
                                                                                      -0.0172219553);

final_score_tree_183 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.96395569775 => final_score_tree_183_c1150,
    f_add_input_nhood_mfd_pct_i >= 0.96395569775                                       => final_score_tree_183_c1153,
                                                                                          0.0134222753);

final_score_tree_184_c1155 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i < 0.0156924308 => 0.0054305206,
    f_add_curr_nhood_vac_pct_i >= 0.0156924308                                      => -0.0051013617,
                                                                                       -0.0005235636);

final_score_tree_184_c1158 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i < 0.2980889807 => 0.2094001169,
    f_add_curr_mobility_index_i >= 0.2980889807                                       => 0.0536321289,
                                                                                         0.1240985997);

final_score_tree_184_c1157 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d < 288 => final_score_tree_184_c1158,
    f_m_bureau_adl_fs_notu_d >= 288                                    => -0.0014640537,
                                                                          0.0801516710);

final_score_tree_184_c1156 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d < 39500 => final_score_tree_184_c1157,
    k_estimated_income_d >= 39500                                => -0.0041659025,
                                                                    0.0352631786);

final_score_tree_184 := map(
    NULL < f_divsrchaddrsuspidcount_i AND f_divsrchaddrsuspidcount_i < 1.5 => final_score_tree_184_c1155,
    f_divsrchaddrsuspidcount_i >= 1.5                                      => final_score_tree_184_c1156,
                                                                              -0.0074925516);

final_score_tree_185_c1160 := map(
    NULL < f_mos_liens_unrel_cj_fseen_d AND f_mos_liens_unrel_cj_fseen_d < 99.5 => -0.0302234168,
    f_mos_liens_unrel_cj_fseen_d >= 99.5                                        => 0.0003808172,
                                                                                   -0.0024439337);

final_score_tree_185_c1163 := map(
    NULL < f_rel_ageover20_count_d AND f_rel_ageover20_count_d < 3.5 => -0.1249128815,
    f_rel_ageover20_count_d >= 3.5                                   => -0.0180003656,
                                                                        -0.0243949233);

final_score_tree_185_c1162 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i < 173.5 => 0.0171973693,
    f_curraddrmurderindex_i >= 173.5                                   => final_score_tree_185_c1163,
                                                                          0.0108382172);

final_score_tree_185_c1161 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.91037769865 => final_score_tree_185_c1162,
    f_add_input_mobility_index_i >= 0.91037769865                                        => 0.1173685852,
                                                                                            0.0782134068);

final_score_tree_185 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n < 6.5 => final_score_tree_185_c1160,
    f_util_adl_count_n >= 6.5                              => final_score_tree_185_c1161,
                                                              0.0065785646);

final_score_tree_186_c1166 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 20.5 => 0.0223759990,
    k_comb_age_d >= 20.5                        => -0.0670291800,
                                                   -0.0584993572);

final_score_tree_186_c1168 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d < 159.5 => -0.0030328524,
    r_c21_m_bureau_adl_fs_d >= 159.5                                   => -0.0801224257,
                                                                          -0.0362503108);

final_score_tree_186_c1167 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d < 165179 => 0.0103993658,
    f_curraddrmedianvalue_d >= 165179                                   => final_score_tree_186_c1168,
                                                                           -0.0062081891);

final_score_tree_186_c1165 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i < 19.5 => -0.0074324063,
    r_p88_phn_dst_to_inp_add_i >= 19.5                                      => final_score_tree_186_c1166,
                                                                               final_score_tree_186_c1167);

final_score_tree_186 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d < 15.5 => final_score_tree_186_c1165,
    f_prevaddrageoldest_d >= 15.5                                 => 0.0032752626,
                                                                     -0.0275883325);

final_score_tree_187_c1171 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.94322211475 => 0.0004775229,
    f_add_input_nhood_mfd_pct_i >= 0.94322211475                                       => -0.0162237161,
                                                                                          0.0020672326);

final_score_tree_187_c1172 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d < 42500 => 0.0101720048,
    k_estimated_income_d >= 42500                                => 0.1302427324,
                                                                    0.0419326489);

final_score_tree_187_c1170 := map(
    NULL < r_l72_add_curr_vacant_i AND r_l72_add_curr_vacant_i < 0.5 => final_score_tree_187_c1171,
    r_l72_add_curr_vacant_i >= 0.5                                   => final_score_tree_187_c1172,
                                                                        0.0002695714);

final_score_tree_187_c1173 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d < 0.09733542405 => 0.0604369057,
    f_add_input_nhood_sfd_pct_d >= 0.09733542405                                       => -0.0613792708,
                                                                                          -0.0010625232);

final_score_tree_187 := map(
    NULL < f_inq_auto_count24_i AND f_inq_auto_count24_i < 9.5 => final_score_tree_187_c1170,
    f_inq_auto_count24_i >= 9.5                                => -0.0637406843,
                                                                  final_score_tree_187_c1173);

final_score_tree_188_c1177 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d < 25.5 => -0.0250390280,
    f_rel_under100miles_cnt_d >= 25.5                                     => 0.0790196833,
                                                                             -0.0406386931);

final_score_tree_188_c1178 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i < 4.5 => 0.0759317596,
    f_srchvelocityrisktype_i >= 4.5                                    => -0.0332667665,
                                                                          0.0184986248);

final_score_tree_188_c1176 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.15454367175 => final_score_tree_188_c1177,
    f_add_input_nhood_bus_pct_i >= 0.15454367175                                       => final_score_tree_188_c1178,
                                                                                          -0.0441976357);

final_score_tree_188_c1175 := map(
    NULL < r_i60_inq_banking_recency_d AND r_i60_inq_banking_recency_d < 9 => 0.0653907887,
    r_i60_inq_banking_recency_d >= 9                                       => final_score_tree_188_c1176,
                                                                              -0.0156770992);

final_score_tree_188 := map(
    NULL < r_f01_inp_addr_not_verified_i AND r_f01_inp_addr_not_verified_i < 0.5 => 0.0009512751,
    r_f01_inp_addr_not_verified_i >= 0.5                                         => final_score_tree_188_c1175,
                                                                                    0.0033464217);

final_score_tree_189_c1181 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i < 0.1228423271 => -0.0684128670,
    f_add_curr_mobility_index_i >= 0.1228423271                                       => -0.0001309790,
                                                                                         0.0369666479);

final_score_tree_189_c1182 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d < 63.5 => 0.0140141396,
    r_c13_curr_addr_lres_d >= 63.5                                  => 0.1206070761,
                                                                       0.0409595659);

final_score_tree_189_c1180 := map(
    NULL < r_l72_add_curr_vacant_i AND r_l72_add_curr_vacant_i < 0.5 => final_score_tree_189_c1181,
    r_l72_add_curr_vacant_i >= 0.5                                   => final_score_tree_189_c1182,
                                                                        0.0001383603);

final_score_tree_189_c1183 := map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i < 1.5 => 0.0269477920,
    r_i60_inq_comm_count12_i >= 1.5                                    => 0.1181593441,
                                                                          0.0340522094);

final_score_tree_189 := map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i < 2816 => final_score_tree_189_c1180,
    f_liens_rel_cj_total_amt_i >= 2816                                      => final_score_tree_189_c1183,
                                                                               -0.0063640921);

final_score_tree_190_c1188 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 20182 => 0.1305559632,
    f_curraddrmedianincome_d >= 20182                                    => 0.0264678943,
                                                                            0.0339096596);

final_score_tree_190_c1187 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n < 14.5 => final_score_tree_190_c1188,
    f_util_adl_count_n >= 14.5                              => 0.1783739431,
                                                               0.0429622518);

final_score_tree_190_c1186 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i < 82 => -0.0223890615,
    f_prevaddrcartheftindex_i >= 82                                     => final_score_tree_190_c1187,
                                                                           0.0285876249);

final_score_tree_190_c1185 := map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d < 549 => final_score_tree_190_c1186,
    r_i60_inq_prepaidcards_recency_d >= 549                                            => 0.0021994931,
                                                                                          0.0061926838);

final_score_tree_190 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.05067896845 => -0.0047365939,
    f_add_curr_nhood_bus_pct_i >= 0.05067896845                                      => final_score_tree_190_c1185,
                                                                                        -0.0125240142);

final_score_tree_191_c1193 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i < 4.5 => -0.1154216780,
    f_phones_per_addr_curr_i >= 4.5                                    => 0.0192819944,
                                                                          0.0092566873);

final_score_tree_191_c1192 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i < 0.03753701105 => final_score_tree_191_c1193,
    f_add_input_nhood_bus_pct_i >= 0.03753701105                                       => 0.0723880254,
                                                                                          -0.0069555152);

final_score_tree_191_c1191 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 22.5 => 0.0940665937,
    k_comb_age_d >= 22.5                        => final_score_tree_191_c1192,
                                                   0.0261006300);

final_score_tree_191_c1190 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d < 24.5 => -0.0751417509,
    r_c10_m_hdr_fs_d >= 24.5                            => final_score_tree_191_c1191,
                                                           0.0172320433);

final_score_tree_191 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i < 0.95745903645 => -0.0022532664,
    f_add_curr_nhood_mfd_pct_i >= 0.95745903645                                      => final_score_tree_191_c1190,
                                                                                        0.0053547179);

final_score_tree_192_c1196 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.39598909455 => 0.0072700845,
    f_add_input_mobility_index_i >= 0.39598909455                                        => -0.0228876810,
                                                                                            0.0235572373);

final_score_tree_192_c1198 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d < 218 => 0.0096358610,
    r_c13_curr_addr_lres_d >= 218                                  => 0.1648740515,
                                                                      0.0285131803);

final_score_tree_192_c1197 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d < 78500 => -0.0172608661,
    k_estimated_income_d >= 78500                                => final_score_tree_192_c1198,
                                                                    -0.0139524121);

final_score_tree_192_c1195 := map(
    NULL < f_historical_count_d AND f_historical_count_d < 1.5 => final_score_tree_192_c1196,
    f_historical_count_d >= 1.5                                => final_score_tree_192_c1197,
                                                                  -0.0054066764);

final_score_tree_192 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d < 13.5 => final_score_tree_192_c1195,
    f_rel_under25miles_cnt_d >= 13.5                                    => 0.0125879777,
                                                                           0.0043109994);

final_score_tree_193_c1203 := map(
    NULL < r_d34_unrel_liens_ct_i AND r_d34_unrel_liens_ct_i < 1.5 => 0.0432117720,
    r_d34_unrel_liens_ct_i >= 1.5                                  => 0.1702404090,
                                                                      0.0746702746);

final_score_tree_193_c1202 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i < 125.5 => -0.0062063006,
    f_curraddrcartheftindex_i >= 125.5                                     => final_score_tree_193_c1203,
                                                                              0.0344230340);

final_score_tree_193_c1201 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i < 0.5 => 0.0036302679,
    f_srchunvrfdaddrcount_i >= 0.5                                   => final_score_tree_193_c1202,
                                                                        0.0054468237);

final_score_tree_193_c1200 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d < 8.5 => final_score_tree_193_c1201,
    f_rel_ageover30_count_d >= 8.5                                   => -0.0055272686,
                                                                        -0.0115292173);

final_score_tree_193 := map(
    NULL < f_mos_liens_rel_st_lseen_d AND f_mos_liens_rel_st_lseen_d < 141.5 => -0.1060490195,
    f_mos_liens_rel_st_lseen_d >= 141.5                                      => final_score_tree_193_c1200,
                                                                                -0.0088233663);

final_score_tree_194_c1206 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d < 36.5 => -0.0000537070,
    f_rel_homeover100_count_d >= 36.5                                     => -0.1049087040,
                                                                             0.0106196962);

final_score_tree_194_c1208 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i < 0.2467889314 => 0.0898120471,
    f_add_curr_mobility_index_i >= 0.2467889314                                       => -0.0151802228,
                                                                                         0.0180281948);

final_score_tree_194_c1207 := map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d < 79 => 0.1494267847,
    f_mos_acc_lseen_d >= 79                             => final_score_tree_194_c1208,
                                                           0.0421973655);

final_score_tree_194_c1205 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i < 9.5 => final_score_tree_194_c1206,
    f_assocsuspicousidcount_i >= 9.5                                     => final_score_tree_194_c1207,
                                                                            -0.0138231484);

final_score_tree_194 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i < 18.5 => final_score_tree_194_c1205,
    r_l79_adls_per_addr_c6_i >= 18.5                                    => -0.0436304758,
                                                                           0.0002544667);

final_score_tree_195_c1210 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d < 8.5 => 0.1156115803,
    r_d32_mos_since_crim_ls_d >= 8.5                                     => 0.0192979589,
                                                                            0.0240625904);

final_score_tree_195_c1211 := map(
    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d < 99.5 => 0.0444817359,
    f_attr_arrest_recency_d >= 99.5                                   => -0.0049025364,
                                                                         -0.0069802876);

final_score_tree_195_c1213 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i < 2.5 => -0.0170897329,
    f_inq_communications_count24_i >= 2.5                                          => 0.0691471144,
                                                                                      -0.0141227941);

final_score_tree_195_c1212 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d < 19.5 => final_score_tree_195_c1213,
    f_rel_educationover12_count_d >= 19.5                                         => 0.0468818639,
                                                                                     0.0185930126);

final_score_tree_195 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.00827301815 => final_score_tree_195_c1210,
    f_add_input_nhood_mfd_pct_i >= 0.00827301815                                       => final_score_tree_195_c1211,
                                                                                          final_score_tree_195_c1212);

final_score_tree_196_c1217 := map(
    NULL < f_curraddractivephonelist_d AND f_curraddractivephonelist_d < 0.5 => 0.0057618633,
    f_curraddractivephonelist_d >= 0.5                                       => -0.0029130449,
                                                                                -0.0304938502);

final_score_tree_196_c1216 := map(
    NULL < f_mos_liens_rel_cj_lseen_d AND f_mos_liens_rel_cj_lseen_d < 83.5 => -0.0415293829,
    f_mos_liens_rel_cj_lseen_d >= 83.5                                      => final_score_tree_196_c1217,
                                                                               0.0005120433);

final_score_tree_196_c1215 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i < 10.5 => final_score_tree_196_c1216,
    f_inq_other_count24_i >= 10.5                                 => -0.0570031324,
                                                                     0.0000249031);

final_score_tree_196_c1218 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '4: Recent Activity', '6: Other']) => -0.1237037397,
    (nf_seg_fraudpoint_3_0 in ['3: Derog', '5: Vuln Vic/Friendly'])                                    => -0.0086444730,
                                                                                                          -0.0573983996);

final_score_tree_196 := map(
    NULL < r_l71_add_curr_business_i AND r_l71_add_curr_business_i < 0.5 => final_score_tree_196_c1215,
    r_l71_add_curr_business_i >= 0.5                                     => final_score_tree_196_c1218,
                                                                            0.0121573690);

final_score_tree_197_c1220 := map(
    NULL < f_liens_unrel_ot_total_amt_i AND f_liens_unrel_ot_total_amt_i < 11132 => -0.0076616027,
    f_liens_unrel_ot_total_amt_i >= 11132                                        => 0.1646901893,
                                                                                    -0.0068085296);

final_score_tree_197_c1222 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d < 2.5 => 0.0333622778,
    f_addrchangeecontrajindex_d >= 2.5                                       => -0.0468198606,
                                                                                -0.0077987482);

final_score_tree_197_c1223 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d < 32.5 => 0.0042303243,
    r_c13_max_lres_d >= 32.5                            => 0.1437807496,
                                                           0.0745075169);

final_score_tree_197_c1221 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 55296.5 => final_score_tree_197_c1222,
    f_curraddrmedianincome_d >= 55296.5                                    => final_score_tree_197_c1223,
                                                                              0.0117710402);

final_score_tree_197 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d < 0.5 => final_score_tree_197_c1220,
    f_rel_incomeover75_count_d >= 0.5                                      => 0.0095273675,
                                                                              final_score_tree_197_c1221);

final_score_tree_198_c1228 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d < 124 => 0.1179684510,
    f_m_bureau_adl_fs_all_d >= 124                                   => 0.0128185764,
                                                                        0.0247223358);

final_score_tree_198_c1227 := map(
    NULL < k_inq_dobs_per_ssn_i AND k_inq_dobs_per_ssn_i < 0.5 => 0.1804231924,
    k_inq_dobs_per_ssn_i >= 0.5                                => final_score_tree_198_c1228,
                                                                  0.0371153128);

final_score_tree_198_c1226 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i < 5.5 => 0.0037207781,
    k_inq_per_phone_i >= 5.5                             => final_score_tree_198_c1227,
                                                            0.0053153897);

final_score_tree_198_c1225 := map(
    (nf_seg_fraudpoint_3_0 in ['2: Synth ID', '4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) => -0.0069306039,
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '3: Derog'])                                        => final_score_tree_198_c1226,
                                                                                                            0.0003816575);

final_score_tree_198 := map(
    NULL < f_hh_collections_ct_i AND f_hh_collections_ct_i < 5.5 => final_score_tree_198_c1225,
    f_hh_collections_ct_i >= 5.5                                 => -0.0301759848,
                                                                    0.0431866938);

final_score_tree_199_c1232 := map(
    NULL < f_hh_collections_ct_i AND f_hh_collections_ct_i < 2.5 => 0.0087472409,
    f_hh_collections_ct_i >= 2.5                                 => 0.0389013865,
                                                                    0.0153703111);

final_score_tree_199_c1231 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i < 4.5 => final_score_tree_199_c1232,
    r_c18_invalid_addrs_per_adl_i >= 4.5                                         => -0.0175016038,
                                                                                    0.0094289291);

final_score_tree_199_c1233 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d < 149.5 => 0.0423548933,
    f_m_bureau_adl_fs_all_d >= 149.5                                   => -0.0198818225,
                                                                          0.0126707678);

final_score_tree_199_c1230 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.048884363 => -0.0037875450,
    f_add_curr_nhood_bus_pct_i >= 0.048884363                                      => final_score_tree_199_c1231,
                                                                                      final_score_tree_199_c1233);

final_score_tree_199 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d < 140 => final_score_tree_199_c1230,
    f_bus_addr_match_count_d >= 140                                    => -0.0893986224,
                                                                          0.0014832907);

final_score_tree_200_c1238 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d < -34386.5 => 0.0663859102,
    f_addrchangevaluediff_d >= -34386.5                                   => 0.0121573979,
                                                                             0.0090854916);

final_score_tree_200_c1237 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d < 0.5 => -0.1281597630,
    r_c13_curr_addr_lres_d >= 0.5                                  => final_score_tree_200_c1238,
                                                                      0.0115223799);

final_score_tree_200_c1236 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i < 38.5 => final_score_tree_200_c1237,
    f_curraddrmurderindex_i >= 38.5                                   => -0.0019441587,
                                                                         0.0001416895);

final_score_tree_200_c1235 := map(
    NULL < f_hh_bankruptcies_i AND f_hh_bankruptcies_i < 3.5 => final_score_tree_200_c1236,
    f_hh_bankruptcies_i >= 3.5                               => -0.0826222287,
                                                                0.0026718667);

final_score_tree_200 := map(
    NULL < f_phones_per_addr_c6_i AND f_phones_per_addr_c6_i < 21.5 => final_score_tree_200_c1235,
    f_phones_per_addr_c6_i >= 21.5                                  => 0.0839102512,
                                                                       -0.0002427277);

final_score_tree_201_c1243 := map(
    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i < 0.00908403245 => 0.1966940386,
    f_add_curr_nhood_vac_pct_i >= 0.00908403245                                      => 0.0304846868,
                                                                                        0.0935296134);

final_score_tree_201_c1242 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i < 2.5 => 0.0259070505,
    f_srchcomponentrisktype_i >= 2.5                                     => final_score_tree_201_c1243,
                                                                            0.0311589367);

final_score_tree_201_c1241 := map(
    NULL < r_s65_ssn_problem_i AND r_s65_ssn_problem_i < 0.5 => final_score_tree_201_c1242,
    r_s65_ssn_problem_i >= 0.5                               => -0.0221657548,
                                                                0.0190416951);

final_score_tree_201_c1240 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d < 32.5 => final_score_tree_201_c1241,
    r_c12_source_profile_d >= 32.5                                  => 0.0008394665,
                                                                       0.0030837423);

final_score_tree_201 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.1045811597 => final_score_tree_201_c1240,
    f_add_curr_nhood_bus_pct_i >= 0.1045811597                                      => -0.0097432652,
                                                                                       -0.0187163335);

final_score_tree_202_c1246 := map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i < 4.5 => 0.0010935486,
    r_s66_adlperssn_count_i >= 4.5                                   => 0.1132418204,
                                                                        0.0039721275);

final_score_tree_202_c1248 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.9376202167 => 0.0110182418,
    f_add_input_nhood_mfd_pct_i >= 0.9376202167                                       => -0.0162913953,
                                                                                         -0.0042626008);

final_score_tree_202_c1247 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i < 11.5 => final_score_tree_202_c1248,
    f_inq_count24_i >= 11.5                           => 0.0825294282,
                                                         0.0067168010);

final_score_tree_202_c1245 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i < 81250 => final_score_tree_202_c1246,
    r_a49_curr_avm_chg_1yr_i >= 81250                                    => -0.0674821495,
                                                                            final_score_tree_202_c1247);

final_score_tree_202 := map(
    NULL < r_i60_inq_auto_recency_d AND r_i60_inq_auto_recency_d < 549 => -0.0098620204,
    r_i60_inq_auto_recency_d >= 549                                    => final_score_tree_202_c1245,
                                                                          0.0233490282);

final_score_tree_203_c1252 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.1561397233 => 0.0241169339,
    f_add_input_mobility_index_i >= 0.1561397233                                        => 0.2153913584,
                                                                                           0.0408333542);

final_score_tree_203_c1251 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.15801265395 => final_score_tree_203_c1252,
    f_add_input_mobility_index_i >= 0.15801265395                                        => -0.0036523047,
                                                                                            0.1013367410);

final_score_tree_203_c1250 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d < 0.00648340795 => -0.0245324912,
    f_add_input_nhood_sfd_pct_d >= 0.00648340795                                       => final_score_tree_203_c1251,
                                                                                          -0.0031805970);

final_score_tree_203_c1253 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i < 49566.5 => 0.0032865584,
    r_a49_curr_avm_chg_1yr_i >= 49566.5                                    => 0.1151422201,
                                                                              0.0125276596);

final_score_tree_203 := map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i < 159.5 => final_score_tree_203_c1250,
    f_prevaddrmurderindex_i >= 159.5                                   => final_score_tree_203_c1253,
                                                                          0.0144517251);

final_score_tree_204_c1256 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.0413734703 => -0.0104943963,
    f_add_curr_nhood_bus_pct_i >= 0.0413734703                                      => 0.0401662442,
                                                                                       0.0158391050);

final_score_tree_204_c1255 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i < 0.5 => 0.1091942534,
    f_phones_per_addr_curr_i >= 0.5                                    => final_score_tree_204_c1256,
                                                                          0.0383970405);

final_score_tree_204_c1258 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.3868434355 => 0.0230969359,
    f_add_input_nhood_mfd_pct_i >= 0.3868434355                                       => 0.1469705136,
                                                                                         0.0469351501);

final_score_tree_204_c1257 := map(
    NULL < f_mos_liens_unrel_sc_fseen_d AND f_mos_liens_unrel_sc_fseen_d < 29.5 => final_score_tree_204_c1258,
    f_mos_liens_unrel_sc_fseen_d >= 29.5                                        => -0.0022022523,
                                                                                   -0.0015542865);

final_score_tree_204 := map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d < 0.5 => final_score_tree_204_c1255,
    f_hh_age_18_plus_d >= 0.5                              => final_score_tree_204_c1257,
                                                              -0.0195113581);

final_score_tree_205_c1260 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i < 1.5 => -0.0068675461,
    f_validationrisktype_i >= 1.5                                  => 0.0489098249,
                                                                      -0.0056459411);

final_score_tree_205_c1263 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d < 1.5 => -0.0764384679,
    r_wealth_index_d >= 1.5                            => 0.0034974017,
                                                          -0.0124897722);

final_score_tree_205_c1262 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d < 52 => final_score_tree_205_c1263,
    r_c12_source_profile_d >= 52                                  => 0.0577529374,
                                                                     -0.0000090558);

final_score_tree_205_c1261 := map(
    NULL < f_srchunvrfdssncount_i AND f_srchunvrfdssncount_i < 0.5 => final_score_tree_205_c1262,
    f_srchunvrfdssncount_i >= 0.5                                  => -0.0781671594,
                                                                      -0.0112705866);

final_score_tree_205 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d < 8.5 => 0.0076763180,
    f_rel_homeover100_count_d >= 8.5                                     => final_score_tree_205_c1260,
                                                                            final_score_tree_205_c1261);

final_score_tree_206_c1268 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d < -15186.5 => 0.0893908069,
    f_addrchangeincomediff_d >= -15186.5                                    => -0.0202308755,
                                                                               -0.0103543370);

final_score_tree_206_c1267 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i < 166.5 => final_score_tree_206_c1268,
    f_curraddrcartheftindex_i >= 166.5                                     => 0.0440940251,
                                                                              -0.0060758442);

final_score_tree_206_c1266 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i < 0.37645648005 => final_score_tree_206_c1267,
    f_add_curr_mobility_index_i >= 0.37645648005                                       => -0.0484699024,
                                                                                          -0.0136138251);

final_score_tree_206_c1265 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i < 188.5 => final_score_tree_206_c1266,
    f_curraddrcartheftindex_i >= 188.5                                     => -0.0787716440,
                                                                              -0.0184996604);

final_score_tree_206 := map(
    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i < 1.5 => 0.0005673385,
    k_inq_addrs_per_ssn_i >= 1.5                                 => final_score_tree_206_c1265,
                                                                    -0.0019244454);

final_score_tree_207_c1272 := map(
    NULL < r_i60_inq_util_recency_d AND r_i60_inq_util_recency_d < 61.5 => 0.0715731637,
    r_i60_inq_util_recency_d >= 61.5                                    => 0.0027491858,
                                                                           0.0033638671);

final_score_tree_207_c1271 := map(
    NULL < r_f04_curr_add_occ_index_d AND r_f04_curr_add_occ_index_d < 0.5 => 0.0685733715,
    r_f04_curr_add_occ_index_d >= 0.5                                      => final_score_tree_207_c1272,
                                                                              0.0036561574);

final_score_tree_207_c1273 := map(
    NULL < r_c14_addrs_10yr_i AND r_c14_addrs_10yr_i < 2.5 => 0.1550985417,
    r_c14_addrs_10yr_i >= 2.5                              => 0.0099868101,
                                                              0.0649533751);

final_score_tree_207_c1270 := map(
    NULL < r_l72_add_vacant_i AND r_l72_add_vacant_i < 0.5 => final_score_tree_207_c1271,
    r_l72_add_vacant_i >= 0.5                              => final_score_tree_207_c1273,
                                                              0.0042448676);

final_score_tree_207 := map(
    NULL < r_i60_inq_auto_recency_d AND r_i60_inq_auto_recency_d < 549 => -0.0072184798,
    r_i60_inq_auto_recency_d >= 549                                    => final_score_tree_207_c1270,
                                                                          -0.0403060068);

final_score_tree_208_c1275 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i < 0.5 => -0.0057047701,
    f_srchfraudsrchcountyr_i >= 0.5                                    => 0.0109660061,
                                                                          0.0015714250);

final_score_tree_208_c1277 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i < 196.5 => -0.0189157871,
    f_fp_prevaddrcrimeindex_i >= 196.5                                     => -0.1025678267,
                                                                              -0.0223179035);

final_score_tree_208_c1278 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d < 1.5 => -0.0244991303,
    f_rel_homeover300_count_d >= 1.5                                     => 0.0926499447,
                                                                            0.0239980674);

final_score_tree_208_c1276 := map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i < 2.5 => final_score_tree_208_c1277,
    f_liens_rel_cj_total_amt_i >= 2.5                                      => final_score_tree_208_c1278,
                                                                              -0.0174581978);

final_score_tree_208 := map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i < 1.5 => final_score_tree_208_c1275,
    r_i60_inq_comm_count12_i >= 1.5                                    => final_score_tree_208_c1276,
                                                                          -0.0028452693);

final_score_tree_209_c1282 := map(
    NULL < f_mos_liens_rel_st_fseen_d AND f_mos_liens_rel_st_fseen_d < 173.5 => -0.1078203827,
    f_mos_liens_rel_st_fseen_d >= 173.5                                      => 0.0011138472,
                                                                                0.0005190847);

final_score_tree_209_c1281 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d < 37.5 => final_score_tree_209_c1282,
    f_rel_ageover30_count_d >= 37.5                                   => 0.0833743796,
                                                                         0.0191697672);

final_score_tree_209_c1283 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i < 7.5 => -0.0126345876,
    f_varrisktype_i >= 7.5                           => 0.0956186725,
                                                        -0.0115393324);

final_score_tree_209_c1280 := map(
    NULL < f_curraddractivephonelist_d AND f_curraddractivephonelist_d < 0.5 => final_score_tree_209_c1281,
    f_curraddractivephonelist_d >= 0.5                                       => final_score_tree_209_c1283,
                                                                                -0.0304750499);

final_score_tree_209 := map(
    NULL < f_hh_workers_paw_d AND f_hh_workers_paw_d < 5.5 => final_score_tree_209_c1280,
    f_hh_workers_paw_d >= 5.5                              => 0.0926587253,
                                                              0.0105507887);

final_score_tree_210_c1286 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i < 193.5 => 0.0296939977,
    f_curraddrburglaryindex_i >= 193.5                                     => 0.1679599595,
                                                                              0.0424219690);

final_score_tree_210_c1288 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d < 38252 => 0.0822995951,
    f_prevaddrmedianvalue_d >= 38252                                   => -0.0143403125,
                                                                          0.0006793868);

final_score_tree_210_c1287 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d < 701.5 => final_score_tree_210_c1288,
    f_addrchangevaluediff_d >= 701.5                                   => -0.0957873745,
                                                                          -0.0208751351);

final_score_tree_210_c1285 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i < 2.5 => final_score_tree_210_c1286,
    f_inq_count24_i >= 2.5                           => final_score_tree_210_c1287,
                                                        0.0203698055);

final_score_tree_210 := map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i < 189.5 => -0.0048505359,
    f_prevaddrmurderindex_i >= 189.5                                   => final_score_tree_210_c1285,
                                                                          0.0080892577);

final_score_tree_211_c1291 := map(
    NULL < r_i60_inq_count12_i AND r_i60_inq_count12_i < 1.5 => -0.1094469647,
    r_i60_inq_count12_i >= 1.5                               => -0.0015497501,
                                                                -0.0198481081);

final_score_tree_211_c1293 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d < 331 => 0.1219921885,
    f_m_bureau_adl_fs_all_d >= 331                                   => 0.0026470685,
                                                                        0.0861298618);

final_score_tree_211_c1292 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i < 0.0474068383 => 0.0117347592,
    f_add_input_nhood_vac_pct_i >= 0.0474068383                                       => final_score_tree_211_c1293,
                                                                                         0.0373751766);

final_score_tree_211_c1290 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d < 27.5 => final_score_tree_211_c1291,
    f_prevaddrageoldest_d >= 27.5                                 => final_score_tree_211_c1292,
                                                                     0.0163769326);

final_score_tree_211 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i < 3.5 => -0.0038802978,
    f_inq_communications_count24_i >= 3.5                                          => final_score_tree_211_c1290,
                                                                                      0.0254699568);

final_score_tree_212_c1297 := map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d < 2.5 => 0.0007313570,
    f_rel_incomeover100_count_d >= 2.5                                       => 0.0263520280,
                                                                                -0.0125186540);

final_score_tree_212_c1296 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d < 18.5 => 0.0363363194,
    r_c13_max_lres_d >= 18.5                            => final_score_tree_212_c1297,
                                                           0.0028748911);

final_score_tree_212_c1298 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d < 5.5 => -0.0902224738,
    f_rel_educationover12_count_d >= 5.5                                         => -0.0002606608,
                                                                                    -0.0443820595);

final_score_tree_212_c1295 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i < 103.5 => final_score_tree_212_c1296,
    f_phones_per_addr_curr_i >= 103.5                                    => final_score_tree_212_c1298,
                                                                            0.0025586821);

final_score_tree_212 := map(
    NULL < r_c15_ssns_per_adl_i AND r_c15_ssns_per_adl_i < 1.5 => final_score_tree_212_c1295,
    r_c15_ssns_per_adl_i >= 1.5                                => -0.0644351364,
                                                                  -0.0134660268);

final_score_tree_213_c1301 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i < 1.5 => 0.0031738140,
    f_varrisktype_i >= 1.5                           => -0.0666061254,
                                                        -0.0312696661);

final_score_tree_213_c1300 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i < 11.5 => 0.0000261903,
    r_l79_adls_per_addr_c6_i >= 11.5                                    => final_score_tree_213_c1301,
                                                                           -0.0006715408);

final_score_tree_213_c1303 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 50538.5 => 0.2755696839,
    f_curraddrmedianincome_d >= 50538.5                                    => 0.0604396314,
                                                                              0.1289447319);

final_score_tree_213_c1302 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 41854.5 => -0.0202036746,
    f_curraddrmedianincome_d >= 41854.5                                    => final_score_tree_213_c1303,
                                                                              0.0681988577);

final_score_tree_213 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d < 407.5 => final_score_tree_213_c1300,
    r_c13_max_lres_d >= 407.5                            => final_score_tree_213_c1302,
                                                            -0.0233075508);

final_score_tree_214_c1307 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d < 2.5 => 0.0876168564,
    f_rel_under100miles_cnt_d >= 2.5                                     => 0.0156874305,
                                                                            0.0221039716);

final_score_tree_214_c1308 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d < 4.5 => 0.0950058720,
    f_rel_ageover30_count_d >= 4.5                                   => -0.0074495700,
                                                                        0.0150963351);

final_score_tree_214_c1306 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i < 92 => final_score_tree_214_c1307,
    r_p88_phn_dst_to_inp_add_i >= 92                                      => 0.1394535016,
                                                                             final_score_tree_214_c1308);

final_score_tree_214_c1305 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d < 116.5 => 0.0004762187,
    f_prevaddrageoldest_d >= 116.5                                 => final_score_tree_214_c1306,
                                                                      0.0062238635);

final_score_tree_214 := map(
    NULL < (integer)k_inf_contradictory_i AND (real)k_inf_contradictory_i < 0.5 => -0.0052242456,
    (real)k_inf_contradictory_i >= 0.5                                 => final_score_tree_214_c1305,
                                                                    -0.0019719054);

final_score_tree_215_c1311 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.00671591975 => 0.0311305794,
    f_add_input_nhood_mfd_pct_i >= 0.00671591975                                       => -0.0083462100,
                                                                                          -0.0021824039);

final_score_tree_215_c1313 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d < 105672.5 => -0.0325858402,
    r_l80_inp_avm_autoval_d >= 105672.5                                   => 0.0383895177,
                                                                             0.0129265532);

final_score_tree_215_c1312 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i < 51875 => -0.0127731450,
    r_a49_curr_avm_chg_1yr_i >= 51875                                    => 0.1216282457,
                                                                            final_score_tree_215_c1313);

final_score_tree_215_c1310 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i < 159.5 => final_score_tree_215_c1311,
    f_curraddrmurderindex_i >= 159.5                                   => final_score_tree_215_c1312,
                                                                          -0.0020943314);

final_score_tree_215 := map(
    NULL < f_liens_unrel_ot_total_amt_i AND f_liens_unrel_ot_total_amt_i < 13816.5 => final_score_tree_215_c1310,
    f_liens_unrel_ot_total_amt_i >= 13816.5                                        => 0.0785793613,
                                                                                      0.0013870981);

final_score_tree_216_c1317 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.238742345 => 0.0337414310,
    f_add_input_mobility_index_i >= 0.238742345                                        => -0.0594667727,
                                                                                          -0.0351515891);

final_score_tree_216_c1318 := map(
    NULL < r_d33_eviction_recency_d AND r_d33_eviction_recency_d < 4.5 => 0.1191885902,
    r_d33_eviction_recency_d >= 4.5                                    => 0.0044828827,
                                                                          0.0052792289);

final_score_tree_216_c1316 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d < 0.0955025724 => final_score_tree_216_c1317,
    f_add_input_nhood_sfd_pct_d >= 0.0955025724                                       => final_score_tree_216_c1318,
                                                                                         0.0032833041);

final_score_tree_216_c1315 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.0014507523 => 0.1346175925,
    f_add_curr_nhood_bus_pct_i >= 0.0014507523                                      => final_score_tree_216_c1316,
                                                                                       0.0350489030);

final_score_tree_216 := map(
    NULL < r_a49_curr_avm_chg_1yr_i AND r_a49_curr_avm_chg_1yr_i < -119750 => 0.0886869210,
    r_a49_curr_avm_chg_1yr_i >= -119750                                    => final_score_tree_216_c1315,
                                                                              -0.0036868876);

final_score_tree_217_c1321 := map(
    NULL < f_crim_rel_under100miles_cnt_i AND f_crim_rel_under100miles_cnt_i < 12.5 => 0.0019846807,
    f_crim_rel_under100miles_cnt_i >= 12.5                                          => 0.0615855642,
                                                                                       0.0030638672);

final_score_tree_217_c1323 := map(
    NULL < f_addrchangeecontrajindex_d AND f_addrchangeecontrajindex_d < 3.5 => -0.0012604309,
    f_addrchangeecontrajindex_d >= 3.5                                       => -0.1271193301,
                                                                                0.0025911940);

final_score_tree_217_c1322 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i < 0.0053788069 => final_score_tree_217_c1323,
    f_add_input_nhood_vac_pct_i >= 0.0053788069                                       => 0.0297298317,
                                                                                         0.0083952328);

final_score_tree_217_c1320 := map(
    NULL < f_crim_rel_under100miles_cnt_i AND f_crim_rel_under100miles_cnt_i < 16.5 => final_score_tree_217_c1321,
    f_crim_rel_under100miles_cnt_i >= 16.5                                          => -0.0520125909,
                                                                                       final_score_tree_217_c1322);

final_score_tree_217 := map(
    NULL < f_mos_liens_unrel_o_fseen_d AND f_mos_liens_unrel_o_fseen_d < 179.5 => -0.0353615376,
    f_mos_liens_unrel_o_fseen_d >= 179.5                                       => final_score_tree_217_c1320,
                                                                                  0.0075837642);

final_score_tree_218_c1328 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i < 30.5 => -0.0085800665,
    r_p88_phn_dst_to_inp_add_i >= 30.5                                      => -0.0992111795,
                                                                               -0.0103551724);

final_score_tree_218_c1327 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i < 0.1756368223 => 0.0553559560,
    f_add_curr_mobility_index_i >= 0.1756368223                                       => final_score_tree_218_c1328,
                                                                                         -0.0099615929);

final_score_tree_218_c1326 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.84256554415 => 0.0084151311,
    f_add_input_nhood_mfd_pct_i >= 0.84256554415                                       => final_score_tree_218_c1327,
                                                                                          0.0142289013);

final_score_tree_218_c1325 := map(
    NULL < f_curraddractivephonelist_d AND f_curraddractivephonelist_d < 0.5 => final_score_tree_218_c1326,
    f_curraddractivephonelist_d >= 0.5                                       => -0.0074242698,
                                                                                -0.0165379915);

final_score_tree_218 := map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i < 7.5 => final_score_tree_218_c1325,
    r_i60_inq_comm_count12_i >= 7.5                                    => 0.0827708816,
                                                                          -0.0246345306);

final_score_tree_219_c1330 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i < 173.5 => 0.0044969483,
    f_prevaddrcartheftindex_i >= 173.5                                     => -0.0111859552,
                                                                              0.0016375120);

final_score_tree_219_c1333 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d < 181.5 => 0.1081778150,
    f_m_bureau_adl_fs_all_d >= 181.5                                   => 0.0096512978,
                                                                          0.0501270562);

final_score_tree_219_c1332 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d < 115.5 => 0.0011088966,
    f_m_bureau_adl_fs_notu_d >= 115.5                                    => final_score_tree_219_c1333,
                                                                            0.0397664335);

final_score_tree_219_c1331 := map(
    NULL < r_s65_ssn_invalid_i AND r_s65_ssn_invalid_i < 0.5 => final_score_tree_219_c1332,
    r_s65_ssn_invalid_i >= 0.5                               => -0.0595436127,
                                                                0.0042113920);

final_score_tree_219 := map(
    NULL < f_rel_ageover50_count_d AND f_rel_ageover50_count_d < 3.5 => final_score_tree_219_c1330,
    f_rel_ageover50_count_d >= 3.5                                   => -0.0380818429,
                                                                        final_score_tree_219_c1331);

final_score_tree_220_c1338 := map(
    NULL < f_srchcountwk_i AND f_srchcountwk_i < 0.5 => 0.0158954206,
    f_srchcountwk_i >= 0.5                           => 0.1184923783,
                                                        0.0245003268);

final_score_tree_220_c1337 := map(
    NULL < f_liens_unrel_ot_total_amt_i AND f_liens_unrel_ot_total_amt_i < 408 => final_score_tree_220_c1338,
    f_liens_unrel_ot_total_amt_i >= 408                                        => 0.1457217476,
                                                                                  0.0362268745);

final_score_tree_220_c1336 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.0279149783 => final_score_tree_220_c1337,
    f_add_curr_nhood_bus_pct_i >= 0.0279149783                                      => -0.0008866964,
                                                                                       0.0056371521);

final_score_tree_220_c1335 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i < 1.5 => -0.0054702460,
    f_srchunvrfdphonecount_i >= 1.5                                    => final_score_tree_220_c1336,
                                                                          -0.0161953532);

final_score_tree_220 := map(
    NULL < f_adls_per_phone_c6_i AND f_adls_per_phone_c6_i < 0.5 => final_score_tree_220_c1335,
    f_adls_per_phone_c6_i >= 0.5                                 => 0.0229121723,
                                                                    -0.0013003503);

final_score_tree_221_c1342 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i < 0.0081306187 => 0.1474294558,
    f_add_curr_nhood_mfd_pct_i >= 0.0081306187                                      => 0.0180468430,
                                                                                       0.0725191791);

final_score_tree_221_c1343 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i < 5.5 => 0.0494425789,
    r_p88_phn_dst_to_inp_add_i >= 5.5                                      => 0.2056981694,
                                                                              0.0302996947);

final_score_tree_221_c1341 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i < 120.95 => final_score_tree_221_c1342,
    r_a49_curr_avm_chg_1yr_pct_i >= 120.95                                        => final_score_tree_221_c1343,
                                                                                     0.0141109112);

final_score_tree_221_c1340 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d < 12.5 => -0.0120764934,
    f_prevaddrlenofres_d >= 12.5                                => final_score_tree_221_c1341,
                                                                   0.0135967635);

final_score_tree_221 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i < 0.3440059881 => -0.0011132992,
    f_add_curr_mobility_index_i >= 0.3440059881                                       => final_score_tree_221_c1340,
                                                                                         -0.0189182603);

final_score_tree_222_c1347 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.1433028917 => -0.0967104724,
    f_add_input_mobility_index_i >= 0.1433028917                                        => 0.0373799165,
                                                                                           0.0282613025);

final_score_tree_222_c1348 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d < 4.5 => -0.0132382319,
    f_rel_homeover200_count_d >= 4.5                                     => 0.0412721021,
                                                                            -0.0313437381);

final_score_tree_222_c1346 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i < 0.5 => final_score_tree_222_c1347,
    k_inq_per_ssn_i >= 0.5                           => final_score_tree_222_c1348,
                                                        0.0128345132);

final_score_tree_222_c1345 := map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d < 0.0232140394 => final_score_tree_222_c1346,
    f_add_curr_nhood_sfd_pct_d >= 0.0232140394                                      => -0.0007611728,
                                                                                       -0.0263280002);

final_score_tree_222 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i < 3.5 => final_score_tree_222_c1345,
    k_inq_adls_per_phone_i >= 3.5                                  => -0.1035527937,
                                                                      0.0002359012);

final_score_tree_223_c1352 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d < 372.5 => 0.0214597867,
    r_c21_m_bureau_adl_fs_d >= 372.5                                   => -0.0463361677,
                                                                          0.0169976577);

final_score_tree_223_c1351 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d < 462711.5 => final_score_tree_223_c1352,
    f_prevaddrmedianvalue_d >= 462711.5                                   => -0.0534426051,
                                                                             0.0146900909);

final_score_tree_223_c1350 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d < 61.5 => final_score_tree_223_c1351,
    r_i60_inq_hiriskcred_recency_d >= 61.5                                          => 0.0001843132,
                                                                                       0.0037415295);

final_score_tree_223_c1353 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i < 33 => 0.0567095760,
    f_curraddrburglaryindex_i >= 33                                     => -0.0441521414,
                                                                           -0.0313830193);

final_score_tree_223 := map(
    NULL < r_i60_inq_count12_i AND r_i60_inq_count12_i < 8.5 => final_score_tree_223_c1350,
    r_i60_inq_count12_i >= 8.5                               => final_score_tree_223_c1353,
                                                                0.0174169467);

final_score_tree_224_c1357 := map(
    NULL < f_hh_payday_loan_users_i AND f_hh_payday_loan_users_i < 1.5 => 0.0006759727,
    f_hh_payday_loan_users_i >= 1.5                                    => 0.0347431265,
                                                                          0.0018186129);

final_score_tree_224_c1356 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i < 28.5 => final_score_tree_224_c1357,
    f_inq_count24_i >= 28.5                           => -0.1042047646,
                                                         0.0014873046);

final_score_tree_224_c1355 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d < 43.5 => final_score_tree_224_c1356,
    f_rel_under25miles_cnt_d >= 43.5                                    => 0.0988383463,
                                                                           -0.0062548501);

final_score_tree_224_c1358 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d < 87721 => -0.0676056253,
    f_curraddrmedianvalue_d >= 87721                                   => 0.0759570283,
                                                                          -0.0295036888);

final_score_tree_224 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.5042692299 => final_score_tree_224_c1355,
    f_add_input_mobility_index_i >= 0.5042692299                                        => -0.0227800850,
                                                                                           final_score_tree_224_c1358);

final_score_tree_225_c1363 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d < 106.5 => -0.0008316634,
    r_c10_m_hdr_fs_d >= 106.5                            => 0.1064553222,
                                                            0.0130594890);

final_score_tree_225_c1362 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d < 183232 => final_score_tree_225_c1363,
    r_a46_curr_avm_autoval_d >= 183232                                    => -0.0399438180,
                                                                             0.0144117745);

final_score_tree_225_c1361 := map(
    NULL < f_inq_collection_count24_i AND f_inq_collection_count24_i < 1.5 => final_score_tree_225_c1362,
    f_inq_collection_count24_i >= 1.5                                      => 0.0733531539,
                                                                              0.0127882583);

final_score_tree_225_c1360 := map(
    NULL < r_i60_inq_util_recency_d AND r_i60_inq_util_recency_d < 549 => 0.1562503456,
    r_i60_inq_util_recency_d >= 549                                    => final_score_tree_225_c1361,
                                                                          0.0153018705);

final_score_tree_225 := map(
    NULL < k_comb_age_d AND k_comb_age_d < 24.5 => final_score_tree_225_c1360,
    k_comb_age_d >= 24.5                        => -0.0028896431,
                                                   0.0001571187);

final_score_tree_226_c1365 := map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d < 74.5 => 0.1136940757,
    r_d32_mos_since_fel_ls_d >= 74.5                                    => 0.0015237084,
                                                                           0.0021546436);

final_score_tree_226_c1367 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.86729421075 => 0.0241054137,
    f_add_input_nhood_mfd_pct_i >= 0.86729421075                                       => -0.0401406446,
                                                                                          -0.0031819114);

final_score_tree_226_c1368 := map(
    NULL < r_a44_curr_add_naprop_d AND r_a44_curr_add_naprop_d < 0.5 => 0.1274363115,
    r_a44_curr_add_naprop_d >= 0.5                                   => 0.0089904523,
                                                                        0.0652020465);

final_score_tree_226_c1366 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i < 1.5 => final_score_tree_226_c1367,
    f_inq_communications_count24_i >= 1.5                                          => final_score_tree_226_c1368,
                                                                                      0.0175502027);

final_score_tree_226 := map(
    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d < 264980 => final_score_tree_226_c1365,
    r_l80_inp_avm_autoval_d >= 264980                                   => final_score_tree_226_c1366,
                                                                           -0.0029835060);

final_score_tree_227_c1371 := map(
    NULL < f_srchssnsrchcountmo_i AND f_srchssnsrchcountmo_i < 4.5 => -0.0029383659,
    f_srchssnsrchcountmo_i >= 4.5                                  => 0.0820991452,
                                                                      -0.0026021961);

final_score_tree_227_c1373 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d < 95 => -0.0122938940,
    r_f01_inp_addr_address_score_d >= 95                                          => 0.0170664136,
                                                                                     0.0092169512);

final_score_tree_227_c1372 := map(
    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d < 99.5 => 0.0975567606,
    f_attr_arrest_recency_d >= 99.5                                   => final_score_tree_227_c1373,
                                                                         0.0106895370);

final_score_tree_227_c1370 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i < 2.5 => final_score_tree_227_c1371,
    r_l79_adls_per_addr_c6_i >= 2.5                                    => final_score_tree_227_c1372,
                                                                          0.0004929917);

final_score_tree_227 := map(
    NULL < r_d34_unrel_liens_ct_i AND r_d34_unrel_liens_ct_i < 18.5 => final_score_tree_227_c1370,
    r_d34_unrel_liens_ct_i >= 18.5                                  => 0.0833487903,
                                                                       0.0280408748);

final_score_tree_228_c1378 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d < 39126.5 => 0.1476078548,
    r_a46_curr_avm_autoval_d >= 39126.5                                    => 0.0247038929,
                                                                              0.0008954762);

final_score_tree_228_c1377 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i < 12.5 => final_score_tree_228_c1378,
    r_l79_adls_per_addr_curr_i >= 12.5                                      => 0.0944599856,
                                                                               0.0213405217);

final_score_tree_228_c1376 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i < 72.5 => -0.0045369194,
    f_prevaddrcartheftindex_i >= 72.5                                     => final_score_tree_228_c1377,
                                                                             0.0043717079);

final_score_tree_228_c1375 := map(
    NULL < f_curraddrcrimeindex_i AND f_curraddrcrimeindex_i < 73 => final_score_tree_228_c1376,
    f_curraddrcrimeindex_i >= 73                                  => -0.0071379184,
                                                                     -0.0036521379);

final_score_tree_228 := map(
    NULL < f_hh_workers_paw_d AND f_hh_workers_paw_d < 5.5 => final_score_tree_228_c1375,
    f_hh_workers_paw_d >= 5.5                              => 0.1020652725,
                                                              -0.0067646066);

final_score_tree_229_c1383 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d < 113 => 0.0959678571,
    r_c13_max_lres_d >= 113                            => -0.0280010688,
                                                          0.0185728923);

final_score_tree_229_c1382 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d < 35.5 => -0.0668679697,
    f_prevaddrlenofres_d >= 35.5                                => final_score_tree_229_c1383,
                                                                   -0.0135410868);

final_score_tree_229_c1381 := map(
    NULL < f_crim_rel_under100miles_cnt_i AND f_crim_rel_under100miles_cnt_i < 2.5 => final_score_tree_229_c1382,
    f_crim_rel_under100miles_cnt_i >= 2.5                                          => -0.1055704337,
                                                                                      -0.0270748143);

final_score_tree_229_c1380 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d < -158985.5 => final_score_tree_229_c1381,
    f_addrchangevaluediff_d >= -158985.5                                   => -0.0030136146,
                                                                              -0.0015625713);

final_score_tree_229 := map(
    NULL < f_historical_count_d AND f_historical_count_d < 30.5 => final_score_tree_229_c1380,
    f_historical_count_d >= 30.5                                => 0.1356944781,
                                                                   0.0249686928);

final_score_tree_230_c1386 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i < 0.5 => 0.0112608435,
    f_phones_per_addr_curr_i >= 0.5                                    => -0.0036387418,
                                                                          -0.0024488822);

final_score_tree_230_c1385 := map(
    NULL < f_mos_liens_rel_sc_lseen_d AND f_mos_liens_rel_sc_lseen_d < 19.5 => 0.1380897495,
    f_mos_liens_rel_sc_lseen_d >= 19.5                                      => final_score_tree_230_c1386,
                                                                               0.0052625787);

final_score_tree_230_c1388 := map(
    NULL < r_i60_inq_banking_recency_d AND r_i60_inq_banking_recency_d < 549 => 0.0953242522,
    r_i60_inq_banking_recency_d >= 549                                       => -0.0591835659,
                                                                                0.0161227656);

final_score_tree_230_c1387 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i < 2.5 => final_score_tree_230_c1388,
    r_l79_adls_per_addr_c6_i >= 2.5                                    => 0.1422614752,
                                                                          0.0559941968);

final_score_tree_230 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i < 2.5 => final_score_tree_230_c1385,
    k_inq_adls_per_phone_i >= 2.5                                  => final_score_tree_230_c1387,
                                                                      -0.0016974164);

final_score_tree_231_c1391 := map(
    NULL < f_srchfraudsrchcountmo_i AND f_srchfraudsrchcountmo_i < 4.5 => 0.0010799643,
    f_srchfraudsrchcountmo_i >= 4.5                                    => 0.0701308208,
                                                                          0.0013602601);

final_score_tree_231_c1393 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i < 87 => 0.0650207105,
    f_curraddrburglaryindex_i >= 87                                     => -0.0989718008,
                                                                           -0.0103272001);

final_score_tree_231_c1392 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i < 0.041112604 => final_score_tree_231_c1393,
    f_add_input_nhood_vac_pct_i >= 0.041112604                                       => 0.1645393154,
                                                                                        0.0523417245);

final_score_tree_231_c1390 := map(
    NULL < f_srchunvrfddobcount_i AND f_srchunvrfddobcount_i < 1.5 => final_score_tree_231_c1391,
    f_srchunvrfddobcount_i >= 1.5                                  => final_score_tree_231_c1392,
                                                                      0.0017157822);

final_score_tree_231 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i < 47.5 => final_score_tree_231_c1390,
    r_l79_adls_per_addr_curr_i >= 47.5                                      => 0.0874301838,
                                                                               0.0104855150);

final_score_tree_232_c1395 := map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d < 3.5 => -0.0243660521,
    r_c14_addr_stability_v2_d >= 3.5                                     => 0.0014916554,
                                                                            -0.0118381280);

final_score_tree_232_c1398 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.71460464025 => 0.0502221973,
    f_add_input_nhood_mfd_pct_i >= 0.71460464025                                       => -0.0380080294,
                                                                                          0.0046941444);

final_score_tree_232_c1397 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d < 402768 => final_score_tree_232_c1398,
    f_curraddrmedianvalue_d >= 402768                                   => 0.0816470813,
                                                                           0.0219993503);

final_score_tree_232_c1396 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d < 2.5 => final_score_tree_232_c1397,
    f_phone_ver_insurance_d >= 2.5                                   => -0.0434748316,
                                                                        -0.0175243057);

final_score_tree_232 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d < 3.5 => final_score_tree_232_c1395,
    f_rel_under25miles_cnt_d >= 3.5                                    => 0.0032032245,
                                                                          final_score_tree_232_c1396);

final_score_tree_233_c1402 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i < 0.5 => 0.1087985189,
    r_l79_adls_per_addr_c6_i >= 0.5                                    => 0.0053001562,
                                                                          0.0432384628);

final_score_tree_233_c1401 := map(
    NULL < f_add_input_nhood_vac_pct_i AND f_add_input_nhood_vac_pct_i < 0.0017361948 => -0.0151223535,
    f_add_input_nhood_vac_pct_i >= 0.0017361948                                       => final_score_tree_233_c1402,
                                                                                         0.0077081042);

final_score_tree_233_c1400 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i < 0.37719395335 => 0.0069212964,
    f_add_curr_nhood_bus_pct_i >= 0.37719395335                                      => -0.0667085887,
                                                                                        final_score_tree_233_c1401);

final_score_tree_233_c1403 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d < 53495.5 => -0.0452361968,
    f_curraddrmedianvalue_d >= 53495.5                                   => -0.0011397880,
                                                                            -0.0044164311);

final_score_tree_233 := map(
    NULL < f_current_count_d AND f_current_count_d < 1.5 => final_score_tree_233_c1400,
    f_current_count_d >= 1.5                             => final_score_tree_233_c1403,
                                                            -0.0096198759);

final_score_tree_234_c1408 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d < 20.5 => 0.2229108586,
    f_rel_under25miles_cnt_d >= 20.5                                    => 0.0298498442,
                                                                           0.1255260991);

final_score_tree_234_c1407 := map(
    NULL < f_crim_rel_under500miles_cnt_i AND f_crim_rel_under500miles_cnt_i < 10.5 => final_score_tree_234_c1408,
    f_crim_rel_under500miles_cnt_i >= 10.5                                          => -0.0408852930,
                                                                                       0.0690824690);

final_score_tree_234_c1406 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d < 19.5 => -0.0014814293,
    f_rel_homeover300_count_d >= 19.5                                     => final_score_tree_234_c1407,
                                                                             0.0011638037);

final_score_tree_234_c1405 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 140753.5 => final_score_tree_234_c1406,
    f_curraddrmedianincome_d >= 140753.5                                    => -0.0784234298,
                                                                               -0.0011306469);

final_score_tree_234 := map(
    NULL < f_mos_liens_unrel_lt_lseen_d AND f_mos_liens_unrel_lt_lseen_d < 129.5 => 0.1082342943,
    f_mos_liens_unrel_lt_lseen_d >= 129.5                                        => final_score_tree_234_c1405,
                                                                                    0.0139921326);

final_score_tree_235_c1411 := map(
    NULL < f_srchssnsrchcountmo_i AND f_srchssnsrchcountmo_i < 0.5 => 0.0545019811,
    f_srchssnsrchcountmo_i >= 0.5                                  => 0.0055854824,
                                                                      0.0212682593);

final_score_tree_235_c1410 := map(
    NULL < f_srchphonesrchcountmo_i AND f_srchphonesrchcountmo_i < 0.5 => -0.0006278751,
    f_srchphonesrchcountmo_i >= 0.5                                    => final_score_tree_235_c1411,
                                                                          0.0011822490);

final_score_tree_235_c1413 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i < 0.97916440585 => -0.0669738746,
    f_add_input_nhood_mfd_pct_i >= 0.97916440585                                       => 0.0231902207,
                                                                                          -0.0521172907);

final_score_tree_235_c1412 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d < 37027.5 => final_score_tree_235_c1413,
    f_prevaddrmedianincome_d >= 37027.5                                    => 0.0010727379,
                                                                              -0.0245501349);

final_score_tree_235 := map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i < 2.5 => final_score_tree_235_c1410,
    r_i60_inq_comm_count12_i >= 2.5                                    => final_score_tree_235_c1412,
                                                                          -0.0080955460);

final_score_tree_236_c1418 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.2597705577 => 0.0106262882,
    f_add_input_mobility_index_i >= 0.2597705577                                        => 0.0576775110,
                                                                                           -0.0620148332);

final_score_tree_236_c1417 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d < 82.5 => -0.0077689674,
    r_c13_max_lres_d >= 82.5                            => final_score_tree_236_c1418,
                                                           0.0159789917);

final_score_tree_236_c1416 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i < 93.55 => 0.0718785896,
    r_a49_curr_avm_chg_1yr_pct_i >= 93.55                                        => -0.0441567121,
                                                                                    final_score_tree_236_c1417);

final_score_tree_236_c1415 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 23840 => final_score_tree_236_c1416,
    f_curraddrmedianincome_d >= 23840                                    => -0.0012671221,
                                                                            0.0003899577);

final_score_tree_236 := map(
    NULL < f_srchssnsrchcountday_i AND f_srchssnsrchcountday_i < 0.5 => final_score_tree_236_c1415,
    f_srchssnsrchcountday_i >= 0.5                                   => -0.0705867869,
                                                                        -0.0071830055);

final_score_tree_237_c1421 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d < -27891 => 0.0646727749,
    f_addrchangeincomediff_d >= -27891                                    => -0.0014979813,
                                                                             0.0035948755);

final_score_tree_237_c1420 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d < 3.5 => final_score_tree_237_c1421,
    r_c23_inp_addr_occ_index_d >= 3.5                                      => -0.0146751889,
                                                                              -0.0016436856);

final_score_tree_237_c1423 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i < 63 => 0.0485229813,
    f_fp_prevaddrcrimeindex_i >= 63                                     => 0.2091451069,
                                                                           0.1228406812);

final_score_tree_237_c1422 := map(
    NULL < f_hh_age_30_plus_d AND f_hh_age_30_plus_d < 2.5 => final_score_tree_237_c1423,
    f_hh_age_30_plus_d >= 2.5                              => -0.0228919517,
                                                              0.0581378110);

final_score_tree_237 := map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d < 6.5 => final_score_tree_237_c1420,
    f_rel_incomeover100_count_d >= 6.5                                       => final_score_tree_237_c1422,
                                                                                -0.0079461338);

final_score_tree_238_c1426 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n < 0.5 => 0.0023662462,
    r_phn_pcs_n >= 0.5                       => -0.0108133345,
                                                -0.0003370690);

final_score_tree_238_c1428 := map(
    NULL < r_a46_curr_avm_autoval_d AND r_a46_curr_avm_autoval_d < 45421 => 0.0681937122,
    r_a46_curr_avm_autoval_d >= 45421                                    => -0.0092200129,
                                                                            -0.0044175391);

final_score_tree_238_c1427 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i < 0.9639576136 => final_score_tree_238_c1428,
    f_add_input_mobility_index_i >= 0.9639576136                                        => 0.1144951635,
                                                                                           -0.0178005072);

final_score_tree_238_c1425 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i < 0.9978188089 => final_score_tree_238_c1426,
    f_add_curr_nhood_mfd_pct_i >= 0.9978188089                                      => 0.0614020918,
                                                                                       final_score_tree_238_c1427);

final_score_tree_238 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i < 16.5 => final_score_tree_238_c1425,
    f_srchfraudsrchcountyr_i >= 16.5                                    => -0.0727588992,
                                                                           0.0297717356);

final_score_tree_239_c1432 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i < 92.6 => 0.0580804635,
    r_a49_curr_avm_chg_1yr_pct_i >= 92.6                                        => -0.0417282174,
                                                                                   0.0367162254);

final_score_tree_239_c1431 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 15759.5 => -0.0088910331,
    f_curraddrmedianincome_d >= 15759.5                                    => final_score_tree_239_c1432,
                                                                              0.0124562977);

final_score_tree_239_c1430 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 24343 => final_score_tree_239_c1431,
    f_curraddrmedianincome_d >= 24343                                    => -0.0013481192,
                                                                            0.0002973619);

final_score_tree_239_c1433 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d < 358635 => -0.0161700936,
    f_curraddrmedianvalue_d >= 358635                                   => -0.0847744183,
                                                                           -0.0291983187);

final_score_tree_239 := map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i < 3.5 => final_score_tree_239_c1430,
    r_i60_inq_comm_count12_i >= 3.5                                    => final_score_tree_239_c1433,
                                                                          -0.0046086052);

final_score_tree_240_c1438 := map(
    NULL < r_c14_addr_stability_v2_d AND r_c14_addr_stability_v2_d < 4.5 => 0.0007874834,
    r_c14_addr_stability_v2_d >= 4.5                                     => 0.0151542760,
                                                                            0.0077544405);

final_score_tree_240_c1437 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d < 121.5 => 0.0576087105,
    r_d32_mos_since_crim_ls_d >= 121.5                                     => final_score_tree_240_c1438,
                                                                              0.0140997170);

final_score_tree_240_c1436 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d < 58500 => -0.0042496280,
    k_estimated_income_d >= 58500                                => final_score_tree_240_c1437,
                                                                    0.0034388940);

final_score_tree_240_c1435 := map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i < 4.5 => final_score_tree_240_c1436,
    f_rel_criminal_count_i >= 4.5                                  => -0.0154999713,
                                                                      -0.0030567743);

final_score_tree_240 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d < 90658.5 => 0.0125733220,
    f_prevaddrmedianvalue_d >= 90658.5                                   => final_score_tree_240_c1435,
                                                                            0.0233750267);

final_score_tree_241_c1442 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d < 0.5 => 0.0233000905,
    f_rel_homeover300_count_d >= 0.5                                     => -0.0500819089,
                                                                            -0.0005475267);

final_score_tree_241_c1443 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i < 7.5 => 0.0124627771,
    f_varrisktype_i >= 7.5                           => 0.1074485462,
                                                        0.0141744096);

final_score_tree_241_c1441 := map(
    NULL < r_a49_curr_avm_chg_1yr_pct_i AND r_a49_curr_avm_chg_1yr_pct_i < 49.15 => 0.1374364624,
    r_a49_curr_avm_chg_1yr_pct_i >= 49.15                                        => final_score_tree_241_c1442,
                                                                                    final_score_tree_241_c1443);

final_score_tree_241_c1440 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d < 34402.5 => final_score_tree_241_c1441,
    f_curraddrmedianincome_d >= 34402.5                                    => -0.0001251471,
                                                                              0.0031394795);

final_score_tree_241 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i < 195.5 => final_score_tree_241_c1440,
    f_prevaddrcartheftindex_i >= 195.5                                     => -0.0257088368,
                                                                              -0.0152659934);

final_score_gbm_logit := final_score_tree_0 +
    final_score_tree_1 +
    final_score_tree_2 +
    final_score_tree_3 +
    final_score_tree_4 +
    final_score_tree_5 +
    final_score_tree_6 +
    final_score_tree_7 +
    final_score_tree_8 +
    final_score_tree_9 +
    final_score_tree_10 +
    final_score_tree_11 +
    final_score_tree_12 +
    final_score_tree_13 +
    final_score_tree_14 +
    final_score_tree_15 +
    final_score_tree_16 +
    final_score_tree_17 +
    final_score_tree_18 +
    final_score_tree_19 +
    final_score_tree_20 +
    final_score_tree_21 +
    final_score_tree_22 +
    final_score_tree_23 +
    final_score_tree_24 +
    final_score_tree_25 +
    final_score_tree_26 +
    final_score_tree_27 +
    final_score_tree_28 +
    final_score_tree_29 +
    final_score_tree_30 +
    final_score_tree_31 +
    final_score_tree_32 +
    final_score_tree_33 +
    final_score_tree_34 +
    final_score_tree_35 +
    final_score_tree_36 +
    final_score_tree_37 +
    final_score_tree_38 +
    final_score_tree_39 +
    final_score_tree_40 +
    final_score_tree_41 +
    final_score_tree_42 +
    final_score_tree_43 +
    final_score_tree_44 +
    final_score_tree_45 +
    final_score_tree_46 +
    final_score_tree_47 +
    final_score_tree_48 +
    final_score_tree_49 +
    final_score_tree_50 +
    final_score_tree_51 +
    final_score_tree_52 +
    final_score_tree_53 +
    final_score_tree_54 +
    final_score_tree_55 +
    final_score_tree_56 +
    final_score_tree_57 +
    final_score_tree_58 +
    final_score_tree_59 +
    final_score_tree_60 +
    final_score_tree_61 +
    final_score_tree_62 +
    final_score_tree_63 +
    final_score_tree_64 +
    final_score_tree_65 +
    final_score_tree_66 +
    final_score_tree_67 +
    final_score_tree_68 +
    final_score_tree_69 +
    final_score_tree_70 +
    final_score_tree_71 +
    final_score_tree_72 +
    final_score_tree_73 +
    final_score_tree_74 +
    final_score_tree_75 +
    final_score_tree_76 +
    final_score_tree_77 +
    final_score_tree_78 +
    final_score_tree_79 +
    final_score_tree_80 +
    final_score_tree_81 +
    final_score_tree_82 +
    final_score_tree_83 +
    final_score_tree_84 +
    final_score_tree_85 +
    final_score_tree_86 +
    final_score_tree_87 +
    final_score_tree_88 +
    final_score_tree_89 +
    final_score_tree_90 +
    final_score_tree_91 +
    final_score_tree_92 +
    final_score_tree_93 +
    final_score_tree_94 +
    final_score_tree_95 +
    final_score_tree_96 +
    final_score_tree_97 +
    final_score_tree_98 +
    final_score_tree_99 +
    final_score_tree_100 +
    final_score_tree_101 +
    final_score_tree_102 +
    final_score_tree_103 +
    final_score_tree_104 +
    final_score_tree_105 +
    final_score_tree_106 +
    final_score_tree_107 +
    final_score_tree_108 +
    final_score_tree_109 +
    final_score_tree_110 +
    final_score_tree_111 +
    final_score_tree_112 +
    final_score_tree_113 +
    final_score_tree_114 +
    final_score_tree_115 +
    final_score_tree_116 +
    final_score_tree_117 +
    final_score_tree_118 +
    final_score_tree_119 +
    final_score_tree_120 +
    final_score_tree_121 +
    final_score_tree_122 +
    final_score_tree_123 +
    final_score_tree_124 +
    final_score_tree_125 +
    final_score_tree_126 +
    final_score_tree_127 +
    final_score_tree_128 +
    final_score_tree_129 +
    final_score_tree_130 +
    final_score_tree_131 +
    final_score_tree_132 +
    final_score_tree_133 +
    final_score_tree_134 +
    final_score_tree_135 +
    final_score_tree_136 +
    final_score_tree_137 +
    final_score_tree_138 +
    final_score_tree_139 +
    final_score_tree_140 +
    final_score_tree_141 +
    final_score_tree_142 +
    final_score_tree_143 +
    final_score_tree_144 +
    final_score_tree_145 +
    final_score_tree_146 +
    final_score_tree_147 +
    final_score_tree_148 +
    final_score_tree_149 +
    final_score_tree_150 +
    final_score_tree_151 +
    final_score_tree_152 +
    final_score_tree_153 +
    final_score_tree_154 +
    final_score_tree_155 +
    final_score_tree_156 +
    final_score_tree_157 +
    final_score_tree_158 +
    final_score_tree_159 +
    final_score_tree_160 +
    final_score_tree_161 +
    final_score_tree_162 +
    final_score_tree_163 +
    final_score_tree_164 +
    final_score_tree_165 +
    final_score_tree_166 +
    final_score_tree_167 +
    final_score_tree_168 +
    final_score_tree_169 +
    final_score_tree_170 +
    final_score_tree_171 +
    final_score_tree_172 +
    final_score_tree_173 +
    final_score_tree_174 +
    final_score_tree_175 +
    final_score_tree_176 +
    final_score_tree_177 +
    final_score_tree_178 +
    final_score_tree_179 +
    final_score_tree_180 +
    final_score_tree_181 +
    final_score_tree_182 +
    final_score_tree_183 +
    final_score_tree_184 +
    final_score_tree_185 +
    final_score_tree_186 +
    final_score_tree_187 +
    final_score_tree_188 +
    final_score_tree_189 +
    final_score_tree_190 +
    final_score_tree_191 +
    final_score_tree_192 +
    final_score_tree_193 +
    final_score_tree_194 +
    final_score_tree_195 +
    final_score_tree_196 +
    final_score_tree_197 +
    final_score_tree_198 +
    final_score_tree_199 +
    final_score_tree_200 +
    final_score_tree_201 +
    final_score_tree_202 +
    final_score_tree_203 +
    final_score_tree_204 +
    final_score_tree_205 +
    final_score_tree_206 +
    final_score_tree_207 +
    final_score_tree_208 +
    final_score_tree_209 +
    final_score_tree_210 +
    final_score_tree_211 +
    final_score_tree_212 +
    final_score_tree_213 +
    final_score_tree_214 +
    final_score_tree_215 +
    final_score_tree_216 +
    final_score_tree_217 +
    final_score_tree_218 +
    final_score_tree_219 +
    final_score_tree_220 +
    final_score_tree_221 +
    final_score_tree_222 +
    final_score_tree_223 +
    final_score_tree_224 +
    final_score_tree_225 +
    final_score_tree_226 +
    final_score_tree_227 +
    final_score_tree_228 +
    final_score_tree_229 +
    final_score_tree_230 +
    final_score_tree_231 +
    final_score_tree_232 +
    final_score_tree_233 +
    final_score_tree_234 +
    final_score_tree_235 +
    final_score_tree_236 +
    final_score_tree_237 +
    final_score_tree_238 +
    final_score_tree_239 +
    final_score_tree_240 +
    final_score_tree_241;

base := 700;

pts := -50;

lgt := ln(0.1497871 / (1 - 0.1497871));

fp1610_2_0 := round(max((real)300, min(999, if(base + pts * (final_score_gbm_logit - lgt) / ln(2) = NULL, -NULL, base + pts * (final_score_gbm_logit - lgt) / ln(2)))));

_ver_src_ds := Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0;

_ver_src_de := Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0;

_ver_src_eq := Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0;

_ver_src_en := Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0;

_ver_src_tn := Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0;

_ver_src_tu := Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0;

_credit_source_cnt := if(max((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu) = NULL, NULL, sum((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu));

_ver_src_cnt := Models.Common.countw((string)(ver_sources));

_bureauonly := _credit_source_cnt > 0 AND _credit_source_cnt = _ver_src_cnt AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6]));

_derog := felony_count > 0 OR addrs_prison_history OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2;

_deceased := rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de;

_ssnpriortodob := rc_ssndobflag = '1' OR rc_pwssndobflag = '1';

_inputmiskeys := rc_ssnmiskeyflag or rc_addrmiskeyflag or (integer)add_input_house_number_match = 0;

_multiplessns := ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1;

_hh_strikes := if((real)max((integer)hh_members_w_derog > 0, 
                            (integer)hh_criminals > 0, 
														(integer)hh_payday_loan_users > 0) = NULL, 
									NULL, 
									(real)sum((integer)hh_members_w_derog > 0, 
									          (integer)hh_criminals > 0, 
														(integer)hh_payday_loan_users > 0)
								 );

stolenid := if((addrpop and (nas_summary in [4, 7, 9])) 
                 or (fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and (integer)ssnlength = 9) 
								 or _deceased or _ssnpriortodob, 
							 1, 0);

manipulatedid := if(_inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1), 1, 0);

manipulatedidpt2 := if(1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and (integer)ssnlength = 9, 1, 0);

syntheticid := if((fnamepop and lnamepop and addrpop and (integer)ssnlength = 9 and hphnpop and nap_summary <= 4 and nas_summary <= 4) 
                    or _ver_src_cnt = 0 
										or _bureauonly 
										or (integer)add_curr_pop = 0, 
								 1, 0);

suspiciousactivity := if(_derog, 1, 0);

vulnerablevictim := if(0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70, 1, 0);

friendlyfraud := if(hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2), 1, 0);

stolenc_fp1610_2_0 := if((boolean)(integer)stolenid, fp1610_2_0, 299);

manip2c_fp1610_2_0 := if((boolean)(integer)manipulatedid or (boolean)(integer)manipulatedidpt2, fp1610_2_0, 299);

synthc_fp1610_2_0 := if((boolean)(integer)syntheticid, fp1610_2_0, 299);

suspactc_fp1610_2_0 := if((boolean)(integer)suspiciousactivity, fp1610_2_0, 299);

vulnvicc_fp1610_2_0 := if((boolean)(integer)vulnerablevictim, fp1610_2_0, 299);

friendlyc_fp1610_2_0 := if((boolean)(integer)friendlyfraud, fp1610_2_0, 299);

custstolidindex := map(
    stolenc_fp1610_2_0 = 299                                => 1,
    300 <= stolenc_fp1610_2_0 AND stolenc_fp1610_2_0 <= 480 => 9,
    480 < stolenc_fp1610_2_0 AND stolenc_fp1610_2_0 <= 530  => 8,
    530 < stolenc_fp1610_2_0 AND stolenc_fp1610_2_0 <= 570  => 7,
    570 < stolenc_fp1610_2_0 AND stolenc_fp1610_2_0 <= 610  => 6,
    610 < stolenc_fp1610_2_0 AND stolenc_fp1610_2_0 <= 640  => 5,
    640 < stolenc_fp1610_2_0 AND stolenc_fp1610_2_0 <= 680  => 4,
    680 < stolenc_fp1610_2_0 AND stolenc_fp1610_2_0 <= 720  => 3,
    720 < stolenc_fp1610_2_0 AND stolenc_fp1610_2_0 <= 999  => 2,
                                                               99);

custmanipidindex := map(
    manip2c_fp1610_2_0 = 299                                => 1,
    300 <= manip2c_fp1610_2_0 AND manip2c_fp1610_2_0 <= 510 => 9,
    510 < manip2c_fp1610_2_0 AND manip2c_fp1610_2_0 <= 570  => 8,
    570 < manip2c_fp1610_2_0 AND manip2c_fp1610_2_0 <= 610  => 7,
    610 < manip2c_fp1610_2_0 AND manip2c_fp1610_2_0 <= 650  => 6,
    650 < manip2c_fp1610_2_0 AND manip2c_fp1610_2_0 <= 680  => 5,
    680 < manip2c_fp1610_2_0 AND manip2c_fp1610_2_0 <= 720  => 4,
    720 < manip2c_fp1610_2_0 AND manip2c_fp1610_2_0 <= 750  => 3,
    750 < manip2c_fp1610_2_0 AND manip2c_fp1610_2_0 <= 999  => 2,
                                                               99);

custsynthidindex := map(
    synthc_fp1610_2_0 = 299                               => 1,
    300 <= synthc_fp1610_2_0 AND synthc_fp1610_2_0 <= 470 => 9,
    470 < synthc_fp1610_2_0 AND synthc_fp1610_2_0 <= 540  => 8,
    540 < synthc_fp1610_2_0 AND synthc_fp1610_2_0 <= 580  => 7,
    580 < synthc_fp1610_2_0 AND synthc_fp1610_2_0 <= 620  => 6,
    620 < synthc_fp1610_2_0 AND synthc_fp1610_2_0 <= 660  => 5,
    660 < synthc_fp1610_2_0 AND synthc_fp1610_2_0 <= 710  => 4,
    710 < synthc_fp1610_2_0 AND synthc_fp1610_2_0 <= 740  => 3,
    740 < synthc_fp1610_2_0 AND synthc_fp1610_2_0 <= 999  => 2,
                                                             99);

custsuspactindex := map(
    suspactc_fp1610_2_0 = 299                                 => 1,
    300 <= suspactc_fp1610_2_0 AND suspactc_fp1610_2_0 <= 550 => 9,
    550 < suspactc_fp1610_2_0 AND suspactc_fp1610_2_0 <= 610  => 8,
    610 < suspactc_fp1610_2_0 AND suspactc_fp1610_2_0 <= 640  => 7,
    640 < suspactc_fp1610_2_0 AND suspactc_fp1610_2_0 <= 680  => 6,
    680 < suspactc_fp1610_2_0 AND suspactc_fp1610_2_0 <= 700  => 5,
    700 < suspactc_fp1610_2_0 AND suspactc_fp1610_2_0 <= 730  => 4,
    730 < suspactc_fp1610_2_0 AND suspactc_fp1610_2_0 <= 760  => 3,
    760 < suspactc_fp1610_2_0 AND suspactc_fp1610_2_0 <= 999  => 2,
                                                                 99);

custvulnvicindex := map(
    vulnvicc_fp1610_2_0 = 299                                 => 1,
    300 <= vulnvicc_fp1610_2_0 AND vulnvicc_fp1610_2_0 <= 550 => 9,
    550 < vulnvicc_fp1610_2_0 AND vulnvicc_fp1610_2_0 <= 590  => 8,
    590 < vulnvicc_fp1610_2_0 AND vulnvicc_fp1610_2_0 <= 640  => 7,
    640 < vulnvicc_fp1610_2_0 AND vulnvicc_fp1610_2_0 <= 680  => 6,
    680 < vulnvicc_fp1610_2_0 AND vulnvicc_fp1610_2_0 <= 710  => 5,
    710 < vulnvicc_fp1610_2_0 AND vulnvicc_fp1610_2_0 <= 730  => 4,
    730 < vulnvicc_fp1610_2_0 AND vulnvicc_fp1610_2_0 <= 760  => 3,
    760 < vulnvicc_fp1610_2_0 AND vulnvicc_fp1610_2_0 <= 999  => 2,
                                                                 99);

custfriendfrdindex := map(
    friendlyc_fp1610_2_0 = 299                                  => 1,
    300 <= friendlyc_fp1610_2_0 AND friendlyc_fp1610_2_0 <= 550 => 9,
    550 < friendlyc_fp1610_2_0 AND friendlyc_fp1610_2_0 <= 590  => 8,
    590 < friendlyc_fp1610_2_0 AND friendlyc_fp1610_2_0 <= 630  => 7,
    630 < friendlyc_fp1610_2_0 AND friendlyc_fp1610_2_0 <= 660  => 6,
    660 < friendlyc_fp1610_2_0 AND friendlyc_fp1610_2_0 <= 690  => 5,
    690 < friendlyc_fp1610_2_0 AND friendlyc_fp1610_2_0 <= 720  => 4,
    720 < friendlyc_fp1610_2_0 AND friendlyc_fp1610_2_0 <= 750  => 3,
    750 < friendlyc_fp1610_2_0 AND friendlyc_fp1610_2_0 <= 999  => 2,
                                                                   99);



//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(FP_DEBUG)
		/* Model Input Variables */
		
	 //self.seq	 														 := le.seq;
   self.sysdate                          := sysdate;
   self.k_nap_phn_verd_d                 := (integer)k_nap_phn_verd_d;
	 self.k_nap_contradictory_i            := k_nap_contradictory_i;
   self.k_inf_phn_verd_d                 := (integer)k_inf_phn_verd_d;
   self.k_inf_lname_verd_d               := (integer)k_inf_lname_verd_d;
   self.k_inf_contradictory_i            := k_inf_contradictory_i;
	 
	 self.r_s65_ssn_invalid_i              := r_s65_ssn_invalid_i;
   self.r_c16_inv_ssn_per_adl_i          := r_c16_inv_ssn_per_adl_i;
	 self.r_s65_ssn_problem_i              := r_s65_ssn_problem_i;
   self.r_p88_phn_dst_to_inp_add_i       := r_p88_phn_dst_to_inp_add_i;
   self.r_p85_phn_not_issued_i           := r_p85_phn_not_issued_i;
   self.r_p85_phn_disconnected_i         := r_p85_phn_disconnected_i;
	 self.r_p85_phn_invalid_i              := r_p85_phn_invalid_i;
   self.r_phn_cell_n                     := r_phn_cell_n;
   self.r_p86_phn_pager_i                := r_p86_phn_pager_i;
   self.r_phn_pcs_n                      := r_phn_pcs_n;
	 
   self.r_l72_add_vacant_i               := r_l72_add_vacant_i;
	 self.r_l71_add_business_i             := r_l71_add_business_i;
   self.r_l70_add_standardized_i         := r_l70_add_standardized_i;
   self.r_l72_add_curr_vacant_i          := r_l72_add_curr_vacant_i;
	 self.r_l71_add_curr_business_i        := r_l71_add_curr_business_i;
   self.r_f03_input_add_not_most_rec_i   := r_f03_input_add_not_most_rec_i;
   self.r_c19_add_prison_hist_i          := r_c19_add_prison_hist_i;
	 self.r_l77_apartment_i                := r_l77_apartment_i;
	 
   self.r_f00_ssn_score_d                := r_f00_ssn_score_d;
   self.r_f01_inp_addr_address_score_d   := r_f01_inp_addr_address_score_d;
   self.r_d30_derog_count_i              := r_d30_derog_count_i;
   self.r_d32_criminal_count_i           := r_d32_criminal_count_i;
   self.r_d32_felony_count_i             := r_d32_felony_count_i;
   self.r_d32_mos_since_crim_ls_d        := r_d32_mos_since_crim_ls_d;
   self.r_d32_mos_since_fel_ls_d         := r_d32_mos_since_fel_ls_d;
	 
   self.r_d31_mostrec_bk_i               := r_d31_mostrec_bk_i;
	 self.r_d31_attr_bankruptcy_recency_d  := r_d31_attr_bankruptcy_recency_d;
   self.r_d33_eviction_recency_d         := r_d33_eviction_recency_d;
	 self.r_d33_eviction_count_i           := r_d33_eviction_count_i;
   self.r_d34_unrel_liens_ct_i           := r_d34_unrel_liens_ct_i;
	 
   self.r_c21_m_bureau_adl_fs_d          := r_c21_m_bureau_adl_fs_d;
   self.f_m_bureau_adl_fs_all_d          := f_m_bureau_adl_fs_all_d;
   self.f_m_bureau_adl_fs_notu_d         := f_m_bureau_adl_fs_notu_d;
   self.r_c10_m_hdr_fs_d                 := r_c10_m_hdr_fs_d;
   self.r_c15_ssns_per_adl_i             := r_c15_ssns_per_adl_i;
   self.r_s66_adlperssn_count_i          := r_s66_adlperssn_count_i;
   self.k_comb_age_d                     := k_comb_age_d;
	 self.r_f03_address_match_d            := r_f03_address_match_d;
	 self.r_a44_curr_add_naprop_d          := r_a44_curr_add_naprop_d;
	 
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
	 
   self.r_l79_adls_per_addr_curr_i       := r_l79_adls_per_addr_curr_i;
   self.r_l79_adls_per_addr_c6_i         := r_l79_adls_per_addr_c6_i;
   self.r_c18_invalid_addrs_per_adl_i    := r_c18_invalid_addrs_per_adl_i;
   self.r_l78_no_phone_at_addr_vel_i     := r_l78_no_phone_at_addr_vel_i;
	 
   self.r_i60_inq_count12_i              := r_i60_inq_count12_i;
   self.r_i60_inq_recency_d              := r_i60_inq_recency_d;
   self.r_i61_inq_collection_recency_d   := r_i61_inq_collection_recency_d;
   self.r_i60_inq_auto_count12_i         := r_i60_inq_auto_count12_i;
   self.r_i60_inq_auto_recency_d         := r_i60_inq_auto_recency_d;
	 self.r_i60_inq_banking_recency_d      := r_i60_inq_banking_recency_d;
   self.r_i60_inq_hiriskcred_recency_d   := r_i60_inq_hiriskcred_recency_d;
   self.r_i60_inq_comm_count12_i         := r_i60_inq_comm_count12_i;
   self.r_i60_inq_comm_recency_d         := r_i60_inq_comm_recency_d;
	 
   self.f_bus_addr_match_count_d         := f_bus_addr_match_count_d;
   
   self.f_util_adl_count_n               := f_util_adl_count_n;
	 self.f_util_add_input_conv_n          := f_util_add_input_conv_n;
   self.f_util_add_curr_inf_n            := f_util_add_curr_inf_n;
	 self.f_util_add_curr_conv_n           := f_util_add_curr_conv_n;
	 
   self.f_add_input_mobility_index_i     := f_add_input_mobility_index_i;
   self.f_add_input_nhood_bus_pct_i      := f_add_input_nhood_bus_pct_i;
   self.f_add_input_nhood_mfd_pct_i      := f_add_input_nhood_mfd_pct_i;
   self.f_add_input_nhood_sfd_pct_d      := f_add_input_nhood_sfd_pct_d;
   self.f_add_input_nhood_vac_pct_i      := f_add_input_nhood_vac_pct_i;
	 
   self.f_add_curr_mobility_index_i      := f_add_curr_mobility_index_i;
   self.f_add_curr_nhood_bus_pct_i       := f_add_curr_nhood_bus_pct_i;
   self.f_add_curr_nhood_mfd_pct_i       := f_add_curr_nhood_mfd_pct_i;
   self.f_add_curr_nhood_sfd_pct_d       := f_add_curr_nhood_sfd_pct_d;
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
	 
	 self.f_attr_arrests_i                 := f_attr_arrests_i;
   self.f_attr_arrest_recency_d          := f_attr_arrest_recency_d;
	 
   self.f_mos_liens_unrel_cj_fseen_d     := f_mos_liens_unrel_cj_fseen_d;
   self.f_mos_liens_unrel_cj_lseen_d     := f_mos_liens_unrel_cj_lseen_d;
   self.f_liens_unrel_cj_total_amt_i     := f_liens_unrel_cj_total_amt_i;
   self.f_mos_liens_rel_cj_fseen_d       := f_mos_liens_rel_cj_fseen_d;
   self.f_mos_liens_rel_cj_lseen_d       := f_mos_liens_rel_cj_lseen_d;
   self.f_liens_rel_cj_total_amt_i       := f_liens_rel_cj_total_amt_i;
	 
   self.f_mos_liens_unrel_lt_lseen_d     := f_mos_liens_unrel_lt_lseen_d;
	 self.f_mos_liens_unrel_o_fseen_d      := f_mos_liens_unrel_o_fseen_d;
   self.f_liens_unrel_ot_total_amt_i     := f_liens_unrel_ot_total_amt_i;
   self.f_mos_liens_rel_ot_fseen_d       := f_mos_liens_rel_ot_fseen_d;
   self.f_mos_liens_unrel_sc_fseen_d     := f_mos_liens_unrel_sc_fseen_d;
	 
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
   self.f_rel_ageover20_count_d          := f_rel_ageover20_count_d;
   self.f_rel_ageover30_count_d          := f_rel_ageover30_count_d;
   self.f_rel_ageover40_count_d          := f_rel_ageover40_count_d;
   self.f_rel_ageover50_count_d          := f_rel_ageover50_count_d;
	 self.f_rel_ageover70_count_d          := f_rel_ageover70_count_d;
   self.f_rel_educationover8_count_d     := f_rel_educationover8_count_d;
   self.f_rel_educationover12_count_d    := f_rel_educationover12_count_d;
	 
   self.f_crim_rel_under25miles_cnt_i    := f_crim_rel_under25miles_cnt_i;
   self.f_crim_rel_under100miles_cnt_i   := f_crim_rel_under100miles_cnt_i;
	 self.f_crim_rel_under500miles_cnt_i   := f_crim_rel_under500miles_cnt_i;
   self.f_rel_under25miles_cnt_d         := f_rel_under25miles_cnt_d;
   self.f_rel_under100miles_cnt_d        := f_rel_under100miles_cnt_d;
   self.f_rel_under500miles_cnt_d        := f_rel_under500miles_cnt_d;
   self.f_rel_bankrupt_count_i           := f_rel_bankrupt_count_i;
   self.f_rel_criminal_count_i           := f_rel_criminal_count_i;
   self.f_rel_felony_count_i             := f_rel_felony_count_i;
   self.f_current_count_d                := f_current_count_d;
   self.f_historical_count_d             := f_historical_count_d;
	 
   self.f_accident_count_i               := f_accident_count_i;
	 self.f_acc_damage_amt_total_i         := f_acc_damage_amt_total_i;
   self.f_mos_acc_lseen_d                := f_mos_acc_lseen_d;
	 self.f_accident_recency_d             := f_accident_recency_d;
	 
   self.f_idverrisktype_i                := f_idverrisktype_i;
   self.f_sourcerisktype_i               := f_sourcerisktype_i;
   self.f_varrisktype_i                  := f_varrisktype_i;
	 self.f_vardobcountnew_i               := f_vardobcountnew_i;
	 
   self.f_srchvelocityrisktype_i         := f_srchvelocityrisktype_i;
   self.f_srchcountwk_i                  := f_srchcountwk_i;
   self.f_srchunvrfdssncount_i           := f_srchunvrfdssncount_i;
   self.f_srchunvrfdaddrcount_i          := f_srchunvrfdaddrcount_i;
   self.f_srchunvrfddobcount_i           := f_srchunvrfddobcount_i;
   self.f_srchunvrfdphonecount_i         := f_srchunvrfdphonecount_i;
   self.f_srchfraudsrchcountyr_i         := f_srchfraudsrchcountyr_i;
   self.f_srchfraudsrchcountmo_i         := f_srchfraudsrchcountmo_i;
	 self.f_srchlocatesrchcountwk_i        := f_srchlocatesrchcountwk_i;
	 
   self.f_assocsuspicousidcount_i        := f_assocsuspicousidcount_i;
   self.f_validationrisktype_i           := f_validationrisktype_i;
   
   self.f_divrisktype_i                  := f_divrisktype_i;
   self.f_divssnidmsrcurelcount_i        := f_divssnidmsrcurelcount_i;
   self.f_divaddrsuspidcountnew_i        := f_divaddrsuspidcountnew_i;
	 self.f_divsrchaddrsuspidcount_i       := f_divsrchaddrsuspidcount_i;
	 
   self.f_srchcomponentrisktype_i        := f_srchcomponentrisktype_i;
   self.f_srchssnsrchcountmo_i           := f_srchssnsrchcountmo_i;
	 self.f_srchssnsrchcountday_i          := f_srchssnsrchcountday_i;
   self.f_srchaddrsrchcountmo_i          := f_srchaddrsrchcountmo_i;
   self.f_srchaddrsrchcountwk_i          := f_srchaddrsrchcountwk_i;
   self.f_srchphonesrchcountmo_i         := f_srchphonesrchcountmo_i;
   
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
   self.f_prevaddrmedianincome_d         := f_prevaddrmedianincome_d;
   self.f_prevaddrmedianvalue_d          := f_prevaddrmedianvalue_d;
   self.f_prevaddrmurderindex_i          := f_prevaddrmurderindex_i;
   self.f_prevaddrcartheftindex_i        := f_prevaddrcartheftindex_i;
   self.f_fp_prevaddrburglaryindex_i     := f_fp_prevaddrburglaryindex_i;
   self.f_fp_prevaddrcrimeindex_i        := f_fp_prevaddrcrimeindex_i;
	 
	 self.r_d31_all_bk_i                   := r_d31_all_bk_i;
	 self.r_d31_bk_chapter_n               := r_d31_bk_chapter_n;
	 self.r_d31_bk_dism_recent_count_i     := r_d31_bk_dism_recent_count_i;
   self.r_c12_source_profile_d           := r_c12_source_profile_d;
   self.r_f01_inp_addr_not_verified_i    := r_f01_inp_addr_not_verified_i;
   self.r_c23_inp_addr_occ_index_d       := r_c23_inp_addr_occ_index_d;
	 self.r_f04_curr_add_occ_index_d       := r_f04_curr_add_occ_index_d;
	 self.r_e57_br_source_count_d          := r_e57_br_source_count_d;
	 self.r_i60_inq_prepaidcards_count12_i := r_i60_inq_prepaidcards_count12_i;
   self.r_i60_inq_prepaidcards_recency_d := r_i60_inq_prepaidcards_recency_d;
	 self.r_i60_inq_retpymt_count12_i      := r_i60_inq_retpymt_count12_i;
	 self.r_i60_inq_util_recency_d         := r_i60_inq_util_recency_d;
	 
   self.f_phone_ver_insurance_d          := f_phone_ver_insurance_d;
   self.f_phone_ver_experian_d           := f_phone_ver_experian_d;
   self.f_addrs_per_ssn_i                := f_addrs_per_ssn_i;
   self.f_phones_per_addr_curr_i         := f_phones_per_addr_curr_i;
   self.f_addrs_per_ssn_c6_i             := f_addrs_per_ssn_c6_i;
   self.f_phones_per_addr_c6_i           := f_phones_per_addr_c6_i;
   self.f_adls_per_phone_c6_i            := f_adls_per_phone_c6_i;
	 
	 self.f_inq_highriskcredit_cnt_day_i   := f_inq_highriskcredit_cnt_day_i;
   self.f_inq_prepaidcards_count24_i     := f_inq_prepaidcards_count24_i;
	 self.f_inq_retailpayments_count24_i   := f_inq_retailpayments_count24_i;
	 
   self.f_mos_liens_rel_sc_lseen_d       := f_mos_liens_rel_sc_lseen_d;
	 self.f_liens_rel_sc_total_amt_i       := f_liens_rel_sc_total_amt_i;
	 self.f_mos_liens_unrel_st_fseen_d     := f_mos_liens_unrel_st_fseen_d;
	 self.f_mos_liens_unrel_st_lseen_d     := f_mos_liens_unrel_st_lseen_d;
   self.f_mos_liens_rel_st_fseen_d       := f_mos_liens_rel_st_fseen_d;
	 self.f_mos_liens_rel_st_lseen_d       := f_mos_liens_rel_st_lseen_d;
	 
   self.f_hh_members_ct_d                := f_hh_members_ct_d;
   self.f_hh_age_65_plus_d               := f_hh_age_65_plus_d;
	 self.f_hh_age_30_plus_d               := f_hh_age_30_plus_d;
   self.f_hh_age_18_plus_d               := f_hh_age_18_plus_d;
   self.f_hh_collections_ct_i            := f_hh_collections_ct_i;
	 self.f_hh_workers_paw_d               := f_hh_workers_paw_d;
   self.f_hh_payday_loan_users_i         := f_hh_payday_loan_users_i;
   self.f_hh_tot_derog_i                 := f_hh_tot_derog_i;
	 self.f_hh_bankruptcies_i              := f_hh_bankruptcies_i;
   self.f_hh_lienholders_i               := f_hh_lienholders_i;
	 self.f_hh_criminals_i                 := f_hh_criminals_i;
	 
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
	 
   self.final_score_tree_0               := final_score_tree_0;
   self.final_score_tree_1               := final_score_tree_1;
   self.final_score_tree_2               := final_score_tree_2;
   self.final_score_tree_3               := final_score_tree_3;
   self.final_score_tree_4               := final_score_tree_4;
   self.final_score_tree_5               := final_score_tree_5;
   self.final_score_tree_6               := final_score_tree_6;
   self.final_score_tree_7               := final_score_tree_7;
   self.final_score_tree_8               := final_score_tree_8;
   self.final_score_tree_9               := final_score_tree_9;
   self.final_score_tree_10              := final_score_tree_10;
   self.final_score_tree_11              := final_score_tree_11;
   self.final_score_tree_12              := final_score_tree_12;
   self.final_score_tree_13              := final_score_tree_13;
   self.final_score_tree_14              := final_score_tree_14;
   self.final_score_tree_15              := final_score_tree_15;
   self.final_score_tree_16              := final_score_tree_16;
   self.final_score_tree_17              := final_score_tree_17;
   self.final_score_tree_18              := final_score_tree_18;
   self.final_score_tree_19              := final_score_tree_19;
   self.final_score_tree_20              := final_score_tree_20;
   self.final_score_tree_21              := final_score_tree_21;
   self.final_score_tree_22              := final_score_tree_22;
   self.final_score_tree_23              := final_score_tree_23;
   self.final_score_tree_24              := final_score_tree_24;
   self.final_score_tree_25              := final_score_tree_25;
   self.final_score_tree_26              := final_score_tree_26;
   self.final_score_tree_27              := final_score_tree_27;
   self.final_score_tree_28              := final_score_tree_28;
   self.final_score_tree_29              := final_score_tree_29;
   self.final_score_tree_30              := final_score_tree_30;
   self.final_score_tree_31              := final_score_tree_31;
   self.final_score_tree_32              := final_score_tree_32;
   self.final_score_tree_33              := final_score_tree_33;
   self.final_score_tree_34              := final_score_tree_34;
   self.final_score_tree_35              := final_score_tree_35;
   self.final_score_tree_36              := final_score_tree_36;
   self.final_score_tree_37              := final_score_tree_37;
   self.final_score_tree_38              := final_score_tree_38;
   self.final_score_tree_39              := final_score_tree_39;
   self.final_score_tree_40              := final_score_tree_40;
   self.final_score_tree_41              := final_score_tree_41;
   self.final_score_tree_42              := final_score_tree_42;
   self.final_score_tree_43              := final_score_tree_43;
   self.final_score_tree_44              := final_score_tree_44;
   self.final_score_tree_45              := final_score_tree_45;
   self.final_score_tree_46              := final_score_tree_46;
   self.final_score_tree_47              := final_score_tree_47;
   self.final_score_tree_48              := final_score_tree_48;
   self.final_score_tree_49              := final_score_tree_49;
   self.final_score_tree_50              := final_score_tree_50;
   self.final_score_tree_51              := final_score_tree_51;
   self.final_score_tree_52              := final_score_tree_52;
   self.final_score_tree_53              := final_score_tree_53;
   self.final_score_tree_54              := final_score_tree_54;
   self.final_score_tree_55              := final_score_tree_55;
   self.final_score_tree_56              := final_score_tree_56;
   self.final_score_tree_57              := final_score_tree_57;
   self.final_score_tree_58              := final_score_tree_58;
   self.final_score_tree_59              := final_score_tree_59;
   self.final_score_tree_60              := final_score_tree_60;
   self.final_score_tree_61              := final_score_tree_61;
   self.final_score_tree_62              := final_score_tree_62;
   self.final_score_tree_63              := final_score_tree_63;
   self.final_score_tree_64              := final_score_tree_64;
   self.final_score_tree_65              := final_score_tree_65;
   self.final_score_tree_66              := final_score_tree_66;
   self.final_score_tree_67              := final_score_tree_67;
   self.final_score_tree_68              := final_score_tree_68;
   self.final_score_tree_69              := final_score_tree_69;
   self.final_score_tree_70              := final_score_tree_70;
   self.final_score_tree_71              := final_score_tree_71;
   self.final_score_tree_72              := final_score_tree_72;
   self.final_score_tree_73              := final_score_tree_73;
   self.final_score_tree_74              := final_score_tree_74;
   self.final_score_tree_75              := final_score_tree_75;
   self.final_score_tree_76              := final_score_tree_76;
   self.final_score_tree_77              := final_score_tree_77;
   self.final_score_tree_78              := final_score_tree_78;
   self.final_score_tree_79              := final_score_tree_79;
   self.final_score_tree_80              := final_score_tree_80;
   self.final_score_tree_81              := final_score_tree_81;
   self.final_score_tree_82              := final_score_tree_82;
   self.final_score_tree_83              := final_score_tree_83;
   self.final_score_tree_84              := final_score_tree_84;
   self.final_score_tree_85              := final_score_tree_85;
   self.final_score_tree_86              := final_score_tree_86;
   self.final_score_tree_87              := final_score_tree_87;
   self.final_score_tree_88              := final_score_tree_88;
   self.final_score_tree_89              := final_score_tree_89;
   self.final_score_tree_90              := final_score_tree_90;
   self.final_score_tree_91              := final_score_tree_91;
   self.final_score_tree_92              := final_score_tree_92;
   self.final_score_tree_93              := final_score_tree_93;
   self.final_score_tree_94              := final_score_tree_94;
   self.final_score_tree_95              := final_score_tree_95;
   self.final_score_tree_96              := final_score_tree_96;
   self.final_score_tree_97              := final_score_tree_97;
   self.final_score_tree_98              := final_score_tree_98;
   self.final_score_tree_99              := final_score_tree_99;
   self.final_score_tree_100             := final_score_tree_100;
   self.final_score_tree_101             := final_score_tree_101;
   self.final_score_tree_102             := final_score_tree_102;
   self.final_score_tree_103             := final_score_tree_103;
   self.final_score_tree_104             := final_score_tree_104;
   self.final_score_tree_105             := final_score_tree_105;
   self.final_score_tree_106             := final_score_tree_106;
   self.final_score_tree_107             := final_score_tree_107;
   self.final_score_tree_108             := final_score_tree_108;
   self.final_score_tree_109             := final_score_tree_109;
   self.final_score_tree_110             := final_score_tree_110;
   self.final_score_tree_111             := final_score_tree_111;
   self.final_score_tree_112             := final_score_tree_112;
   self.final_score_tree_113             := final_score_tree_113;
   self.final_score_tree_114             := final_score_tree_114;
   self.final_score_tree_115             := final_score_tree_115;
   self.final_score_tree_116             := final_score_tree_116;
   self.final_score_tree_117             := final_score_tree_117;
   self.final_score_tree_118             := final_score_tree_118;
   self.final_score_tree_119             := final_score_tree_119;
   self.final_score_tree_120             := final_score_tree_120;
   self.final_score_tree_121             := final_score_tree_121;
   self.final_score_tree_122             := final_score_tree_122;
   self.final_score_tree_123             := final_score_tree_123;
   self.final_score_tree_124             := final_score_tree_124;
   self.final_score_tree_125             := final_score_tree_125;
   self.final_score_tree_126             := final_score_tree_126;
   self.final_score_tree_127             := final_score_tree_127;
   self.final_score_tree_128             := final_score_tree_128;
   self.final_score_tree_129             := final_score_tree_129;
   self.final_score_tree_130             := final_score_tree_130;
   self.final_score_tree_131             := final_score_tree_131;
   self.final_score_tree_132             := final_score_tree_132;
   self.final_score_tree_133             := final_score_tree_133;
   self.final_score_tree_134             := final_score_tree_134;
   self.final_score_tree_135             := final_score_tree_135;
   self.final_score_tree_136             := final_score_tree_136;
   self.final_score_tree_137             := final_score_tree_137;
   self.final_score_tree_138             := final_score_tree_138;
   self.final_score_tree_139             := final_score_tree_139;
   self.final_score_tree_140             := final_score_tree_140;
   self.final_score_tree_141             := final_score_tree_141;
   self.final_score_tree_142             := final_score_tree_142;
   self.final_score_tree_143             := final_score_tree_143;
   self.final_score_tree_144             := final_score_tree_144;
   self.final_score_tree_145             := final_score_tree_145;
   self.final_score_tree_146             := final_score_tree_146;
   self.final_score_tree_147             := final_score_tree_147;
   self.final_score_tree_148             := final_score_tree_148;
   self.final_score_tree_149             := final_score_tree_149;
   self.final_score_tree_150             := final_score_tree_150;
   self.final_score_tree_151             := final_score_tree_151;
   self.final_score_tree_152             := final_score_tree_152;
   self.final_score_tree_153             := final_score_tree_153;
   self.final_score_tree_154             := final_score_tree_154;
   self.final_score_tree_155             := final_score_tree_155;
   self.final_score_tree_156             := final_score_tree_156;
   self.final_score_tree_157             := final_score_tree_157;
   self.final_score_tree_158             := final_score_tree_158;
   self.final_score_tree_159             := final_score_tree_159;
   self.final_score_tree_160             := final_score_tree_160;
   self.final_score_tree_161             := final_score_tree_161;
   self.final_score_tree_162             := final_score_tree_162;
   self.final_score_tree_163             := final_score_tree_163;
   self.final_score_tree_164             := final_score_tree_164;
   self.final_score_tree_165             := final_score_tree_165;
   self.final_score_tree_166             := final_score_tree_166;
   self.final_score_tree_167             := final_score_tree_167;
   self.final_score_tree_168             := final_score_tree_168;
   self.final_score_tree_169             := final_score_tree_169;
   self.final_score_tree_170             := final_score_tree_170;
   self.final_score_tree_171             := final_score_tree_171;
   self.final_score_tree_172             := final_score_tree_172;
   self.final_score_tree_173             := final_score_tree_173;
   self.final_score_tree_174             := final_score_tree_174;
   self.final_score_tree_175             := final_score_tree_175;
   self.final_score_tree_176             := final_score_tree_176;
   self.final_score_tree_177             := final_score_tree_177;
   self.final_score_tree_178             := final_score_tree_178;
   self.final_score_tree_179             := final_score_tree_179;
   self.final_score_tree_180             := final_score_tree_180;
   self.final_score_tree_181             := final_score_tree_181;
   self.final_score_tree_182             := final_score_tree_182;
   self.final_score_tree_183             := final_score_tree_183;
   self.final_score_tree_184             := final_score_tree_184;
   self.final_score_tree_185             := final_score_tree_185;
   self.final_score_tree_186             := final_score_tree_186;
   self.final_score_tree_187             := final_score_tree_187;
   self.final_score_tree_188             := final_score_tree_188;
   self.final_score_tree_189             := final_score_tree_189;
   self.final_score_tree_190             := final_score_tree_190;
   self.final_score_tree_191             := final_score_tree_191;
   self.final_score_tree_192             := final_score_tree_192;
   self.final_score_tree_193             := final_score_tree_193;
   self.final_score_tree_194             := final_score_tree_194;
   self.final_score_tree_195             := final_score_tree_195;
   self.final_score_tree_196             := final_score_tree_196;
   self.final_score_tree_197             := final_score_tree_197;
   self.final_score_tree_198             := final_score_tree_198;
   self.final_score_tree_199             := final_score_tree_199;
   self.final_score_tree_200             := final_score_tree_200;
   self.final_score_tree_201             := final_score_tree_201;
   self.final_score_tree_202             := final_score_tree_202;
   self.final_score_tree_203             := final_score_tree_203;
   self.final_score_tree_204             := final_score_tree_204;
   self.final_score_tree_205             := final_score_tree_205;
   self.final_score_tree_206             := final_score_tree_206;
   self.final_score_tree_207             := final_score_tree_207;
   self.final_score_tree_208             := final_score_tree_208;
   self.final_score_tree_209             := final_score_tree_209;
   self.final_score_tree_210             := final_score_tree_210;
   self.final_score_tree_211             := final_score_tree_211;
   self.final_score_tree_212             := final_score_tree_212;
   self.final_score_tree_213             := final_score_tree_213;
   self.final_score_tree_214             := final_score_tree_214;
   self.final_score_tree_215             := final_score_tree_215;
   self.final_score_tree_216             := final_score_tree_216;
   self.final_score_tree_217             := final_score_tree_217;
   self.final_score_tree_218             := final_score_tree_218;
   self.final_score_tree_219             := final_score_tree_219;
   self.final_score_tree_220             := final_score_tree_220;
   self.final_score_tree_221             := final_score_tree_221;
   self.final_score_tree_222             := final_score_tree_222;
   self.final_score_tree_223             := final_score_tree_223;
   self.final_score_tree_224             := final_score_tree_224;
   self.final_score_tree_225             := final_score_tree_225;
   self.final_score_tree_226             := final_score_tree_226;
   self.final_score_tree_227             := final_score_tree_227;
   self.final_score_tree_228             := final_score_tree_228;
   self.final_score_tree_229             := final_score_tree_229;
   self.final_score_tree_230             := final_score_tree_230;
   self.final_score_tree_231             := final_score_tree_231;
   self.final_score_tree_232             := final_score_tree_232;
   self.final_score_tree_233             := final_score_tree_233;
   self.final_score_tree_234             := final_score_tree_234;
   self.final_score_tree_235             := final_score_tree_235;
   self.final_score_tree_236             := final_score_tree_236;
   self.final_score_tree_237             := final_score_tree_237;
   self.final_score_tree_238             := final_score_tree_238;
   self.final_score_tree_239             := final_score_tree_239;
   self.final_score_tree_240             := final_score_tree_240;
   self.final_score_tree_241             := final_score_tree_241;
	 
   self.final_score_gbm_logit            := final_score_gbm_logit;
	 
   self.base                             := base;
   self.pts                              := pts;
   self.lgt                              := lgt;
	 
   self.fp1610_2_0                       := fp1610_2_0;
	 
   self.stolenid                         := stolenid;
   self.manipulatedid                    := manipulatedid;
   self.manipulatedidpt2                 := manipulatedidpt2;
   self.syntheticid                      := syntheticid;
   self.suspiciousactivity               := suspiciousactivity;
   self.vulnerablevictim                 := vulnerablevictim;
   self.friendlyfraud                    := friendlyfraud;
	 
   self.stolenc_fp1610_2_0               := stolenc_fp1610_2_0;
   self.manip2c_fp1610_2_0               := manip2c_fp1610_2_0;
   self.synthc_fp1610_2_0                := synthc_fp1610_2_0;
   self.suspactc_fp1610_2_0              := suspactc_fp1610_2_0;
   self.vulnvicc_fp1610_2_0              := vulnvicc_fp1610_2_0;
   self.friendlyc_fp1610_2_0             := friendlyc_fp1610_2_0;
	 
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
	reasons := Models.Common.checkFraudPointRC34(FP1610_2_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)FP1610_2_0;
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
