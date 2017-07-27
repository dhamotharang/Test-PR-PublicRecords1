import Std, risk_indicators, riskwise, riskwisefcra, ut, easi, Models;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1606_1_0(dataset(risk_indicators.Layout_Boca_Shell) clam,
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
   Integer	 k_nap_phn_verd_d;
   Integer	 k_nap_fname_verd_d;
   Integer	 k_inf_fname_verd_d;
   Integer	 r_p88_phn_dst_to_inp_add_i;
   String	 add_ec1;
   String	 add_ec3;
   String	 add_ec4;
   Real	 r_l70_add_standardized_i;
   Integer	 r_f00_ssn_score_d;
   Real	 r_f01_inp_addr_address_score_d;
   Real	 r_d30_derog_count_i;
   Real	 r_d32_criminal_count_i;
   Real	 _criminal_last_date;
   Real	 r_d32_mos_since_crim_ls_d;
   Real	 _felony_last_date;
   Real	 r_d32_mos_since_fel_ls_d;
   Real	 r_d31_attr_bankruptcy_recency_d;
   String	 r_d31_bk_chapter_n;
   Integer	 r_d31_bk_filing_count_i;
   Integer	 r_d31_bk_disposed_recent_count_i;
   Integer	 r_d33_eviction_recency_d;
   Real	 r_d33_eviction_count_i;
   Real	 r_d34_unrel_liens_ct_i;
   Integer	 r_d34_unrel_lien60_count_i;
   Integer	 _src_bureau_adl_fseen;
   Integer	 r_c21_m_bureau_adl_fs_d;
   Integer	 _src_bureau_adl_fseen_all;
   Integer	 f_m_bureau_adl_fs_all_d;
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
   Integer	 _src_bureau_adl_fseen_notu;
   Integer	 f_m_bureau_adl_fs_notu_d;
   Integer	 _header_first_seen;
   Integer	 r_c10_m_hdr_fs_d;
   Integer	 r_c12_num_nonderogs_d;
   Integer	 _in_dob;
   Integer	 yr_in_dob;
   Integer	 yr_in_dob_int;
   Integer	 k_comb_age_d;
   Integer	 r_a44_curr_add_naprop_d;
   Integer	 r_l80_inp_avm_autoval_d;
   Integer	 r_a46_curr_avm_autoval_d;
   Integer	 r_a49_curr_avm_chg_1yr_i;
   Real	 r_a49_curr_avm_chg_1yr_pct_i;
   Integer	 r_c13_curr_addr_lres_d;
   Integer	 r_c13_max_lres_d;
   Integer	 r_c14_addrs_5yr_i;
   Integer	 r_c14_addrs_10yr_i;
   Integer	 r_c14_addrs_per_adl_c6_i;
   Integer	 r_c14_addrs_15yr_i;
   Integer	 r_prop_owner_history_d;
   Integer	 r_a43_watercraft_cnt_d;
   Integer	 r_ever_asset_owner_d;
   Integer	 r_c20_email_domain_free_count_i;
   Integer	 r_c20_email_domain_isp_count_i;
   Integer	 r_e57_prof_license_flag_d;
   Integer	 r_l79_adls_per_addr_curr_i;
   Integer	 r_l79_adls_per_addr_c6_i;
   Integer	 r_i60_inq_count12_i;
   Integer	 r_i60_inq_recency_d;
   Integer	 r_i61_inq_collection_count12_i;
   Integer	 r_i61_inq_collection_recency_d;
   Integer	 r_i60_inq_auto_count12_i;
   Integer	 r_i60_inq_auto_recency_d;
   Integer	 r_i60_inq_banking_recency_d;
   Integer	 r_i60_inq_mortgage_recency_d;
   Integer	 r_i60_inq_hiriskcred_count12_i;
   Integer	 r_i60_inq_hiriskcred_recency_d;
   Integer	 r_i60_inq_retail_recency_d;
   Integer	 r_i60_inq_comm_recency_d;
   Integer	 f_util_adl_count_n;
   Integer	 f_util_add_input_conv_n;
   Real	 f_add_input_mobility_index_i;
   Real	 f_add_input_nhood_bus_pct_i;
   Real	 f_add_input_nhood_mfd_pct_i;
   Real	 f_add_input_nhood_sfd_pct_d;
   Real	 add_input_nhood_prop_sum;
   Real	 f_add_input_nhood_vac_pct_i;
   Real	 f_add_curr_mobility_index_i;
   Real	 f_add_curr_nhood_bus_pct_i;
   Real	 f_add_curr_nhood_mfd_pct_i;
   Real	 f_add_curr_nhood_sfd_pct_d;
   Real	 add_curr_nhood_prop_sum;
   Real	 f_add_curr_nhood_vac_pct_i;
   Integer	 f_inq_count24_i;
   Integer	 f_inq_banking_count24_i;
   Integer	 f_inq_collection_count24_i;
   Integer	 f_inq_communications_count24_i;
   Integer	 f_inq_highriskcredit_count24_i;
   Integer	 f_inq_other_count24_i;
   Integer	 f_inq_retail_count24_i;
   Integer	 k_inq_per_ssn_i;
   Integer	 k_inq_dobs_per_ssn_i;
   Integer	 k_inq_per_addr_i;
   Integer	 k_inq_per_phone_i;
   Integer	 k_inq_adls_per_phone_i;
   Integer	 f_attr_arrests_i;
   Integer	 f_attr_arrest_recency_d;
   Integer	 _liens_unrel_cj_first_seen;
   Integer	 f_mos_liens_unrel_cj_fseen_d;
   Integer	 _liens_unrel_cj_last_seen;
   Integer	 f_mos_liens_unrel_cj_lseen_d;
   Integer	 f_liens_unrel_cj_total_amt_i;
   Integer	 _liens_rel_cj_first_seen;
   Integer	 f_mos_liens_rel_cj_fseen_d;
   Integer	 _liens_rel_cj_last_seen;
   Integer	 f_mos_liens_rel_cj_lseen_d;
   Integer	 f_liens_rel_cj_total_amt_i;
   Integer	 _liens_unrel_ft_first_seen;
   Integer	 f_mos_liens_unrel_ft_fseen_d;
   Integer	 _liens_unrel_ft_last_seen;
   Integer	 f_mos_liens_unrel_ft_lseen_d;
   Integer	 f_liens_unrel_ft_total_amt_i;
   Integer	 _liens_rel_ft_first_seen;
   Integer	 f_mos_liens_rel_ft_fseen_d;
   Integer	 _liens_rel_ft_last_seen;
   Integer	 f_mos_liens_rel_ft_lseen_d;
   Integer	 _liens_unrel_ot_first_seen;
   Integer	 f_mos_liens_unrel_ot_fseen_d;
   Integer	 _liens_unrel_ot_last_seen;
   Integer	 f_mos_liens_unrel_ot_lseen_d;
   Integer	 f_liens_unrel_ot_total_amt_i;
   Integer	 _liens_rel_ot_first_seen;
   Integer	 f_mos_liens_rel_ot_fseen_d;
   Integer	 _liens_rel_ot_last_seen;
   Integer	 f_mos_liens_rel_ot_lseen_d;
   Integer	 f_liens_rel_ot_total_amt_i;
   Integer	 _liens_unrel_sc_first_seen;
   Integer	 f_mos_liens_unrel_sc_fseen_d;
   Integer	 f_liens_unrel_sc_total_amt_i;
   Integer	 _foreclosure_last_date;
   Integer	 f_mos_foreclosure_lseen_d;
   Integer	 k_estimated_income_d;
   Integer	 r_wealth_index_d;
   Integer	 f_rel_count_i;
   Integer	 f_rel_incomeover25_count_d;
   Integer	 f_rel_incomeover50_count_d;
   Integer	 f_rel_incomeover75_count_d;
   Integer	 f_rel_homeover50_count_d;
   Integer	 f_rel_homeover100_count_d;
   Integer	 f_rel_homeover150_count_d;
   Integer	 f_rel_homeover200_count_d;
   Integer	 f_rel_homeover300_count_d;
   Integer	 f_rel_homeover500_count_d;
   Integer	 f_rel_ageover20_count_d;
   Integer	 f_rel_ageover30_count_d;
   Integer	 f_rel_ageover40_count_d;
   Integer	 f_rel_educationover8_count_d;
   Integer	 f_rel_educationover12_count_d;
   Integer	 f_crim_rel_under25miles_cnt_i;
   Integer	 f_crim_rel_under100miles_cnt_i;
   Integer	 f_rel_under25miles_cnt_d;
   Integer	 f_rel_under100miles_cnt_d;
   Integer	 f_rel_under500miles_cnt_d;
   Integer	 f_rel_bankrupt_count_i;
   Integer	 f_rel_criminal_count_i;
   Integer	 f_historical_count_d;
   Integer	 f_accident_count_i;
   Integer	 _acc_last_seen;
   Integer	 f_mos_acc_lseen_d;
   Integer	 f_acc_damage_amt_last_6mos_i;
   Integer	 f_accident_recency_d;
   Integer	 f_idverrisktype_i;
   Integer	 f_sourcerisktype_i;
   Integer	 f_varrisktype_i;
   Integer	 f_vardobcount_i;
   Integer	 f_srchvelocityrisktype_i;
   Integer	 f_srchunvrfdssncount_i;
   Integer	 f_srchunvrfddobcount_i;
   Integer	 f_srchunvrfdphonecount_i;
   Integer	 f_srchfraudsrchcountyr_i;
   Integer	 f_srchfraudsrchcountmo_i;
   Integer	 f_srchfraudsrchcountwk_i;
   Integer	 f_assocrisktype_i;
   Integer	 f_assoccredbureaucount_i;
   Integer	 f_assoccredbureaucountnew_i;
   Integer	 f_divrisktype_i;
   Integer	 f_divaddrsuspidcountnew_i;
   Integer	 f_divsrchaddrsuspidcount_i;
   Integer	 f_srchcomponentrisktype_i;
   Integer	 f_srchssnsrchcountmo_i;
   Integer	 f_srchssnsrchcountwk_i;
   Integer	 f_srchaddrsrchcountmo_i;
   Integer	 f_srchaddrsrchcountwk_i;
   Integer	 f_srchphonesrchcountmo_i;
   Integer	 f_srchphonesrchcountwk_i;
   Integer	 f_componentcharrisktype_i;
   Integer	 f_addrchangeincomediff_d;
   Integer	 f_addrchangevaluediff_d;
   Integer	 f_addrchangecrimediff_i;
   Integer	 f_addrchangeecontrajindex_d;
   Integer	 f_curraddrmedianincome_d;
   Integer	 f_curraddrmedianvalue_d;
   Integer	 f_curraddrmurderindex_i;
   Integer	 f_curraddrcartheftindex_i;
   Integer	 f_curraddrburglaryindex_i;
   Integer	 f_curraddrcrimeindex_i;
   Integer	 f_prevaddrageoldest_d;
   Integer	 f_prevaddrlenofres_d;
   Integer	 f_prevaddrstatus_i;
   Integer	 f_prevaddrmedianincome_d;
   Integer	 f_prevaddrmedianvalue_d;
   Integer	 f_prevaddrmurderindex_i;
   Integer	 f_prevaddrcartheftindex_i;
   Integer	 f_fp_prevaddrburglaryindex_i;
   Integer	 f_fp_prevaddrcrimeindex_i;
   Real	 r_c12_source_profile_d;
   Integer	 r_c23_inp_addr_occ_index_d;
   Integer	 r_c23_inp_addr_owned_not_occ_d;
   Integer	 r_e55_college_ind_d;
   Integer	 r_e57_br_source_count_d;
   Integer	 r_i60_inq_prepaidcards_recency_d;
   Integer	 f_phone_ver_experian_d;
   Integer	 f_addrs_per_ssn_i;
   Integer	 f_phones_per_addr_curr_i;
   Integer	 f_phones_per_addr_c6_i;
   Integer	 f_inq_email_ver_count_i;
   Integer	 f_inq_highriskcredit_cnt_day_i;
   Integer	 f_inq_highriskcredit_cnt_week_i;
   Integer	 f_adl_per_email_i;
   Integer	 r_c20_email_verification_d;
   Integer	 _liens_rel_sc_first_seen;
   Integer	 f_mos_liens_rel_sc_fseen_d;
   Integer	 _liens_rel_sc_last_seen;
   Integer	 f_mos_liens_rel_sc_lseen_d;
   Integer	 f_liens_rel_sc_total_amt_i;
   Integer	 f_liens_unrel_st_ct_i;
   Integer	 _liens_unrel_st_last_seen;
   Integer	 f_mos_liens_unrel_st_lseen_d;
   Integer	 f_property_owners_ct_d;
   Integer	 f_hh_age_30_plus_d;
   Integer	 f_hh_collections_ct_i;
   Integer	 f_hh_payday_loan_users_i;
   Integer	 f_hh_members_w_derog_i;
   Integer	 f_hh_tot_derog_i;
   Integer	 f_hh_bankruptcies_i;
   Integer	 f_hh_lienholders_i;
   Integer	 f_hh_prof_license_holders_d;
   Real	 f_hh_college_attendees_d;
   String	 nf_seg_fraudpoint_3_0;
   Real	 mod1__0;
   Real	 mod1_1;
   Real	 mod1_2;
   Real	 mod1_3;
   Real	 mod1_4;
   Real	 mod1_5;
   Real	 mod1_6;
   Real	 mod1_7;
   Real	 mod1_8;
   Real	 mod1_9;
   Real	 mod1_10;
   Real	 mod1_11;
   Real	 mod1_12;
   Real	 mod1_13;
   Real	 mod1_14;
   Real	 mod1_15;
   Real	 mod1_16;
   Real	 mod1_17;
   Real	 mod1_18;
   Real	 mod1_19;
   Real	 mod1_20;
   Real	 mod1_21;
   Real	 mod1_22;
   Real	 mod1_23;
   Real	 mod1_24;
   Real	 mod1_25;
   Real	 mod1_26;
   Real	 mod1_27;
   Real	 mod1_28;
   Real	 mod1_29;
   Real	 mod1_30;
   Real	 mod1_31;
   Real	 mod1_32;
   Real	 mod1_33;
   Real	 mod1_34;
   Real	 mod1_35;
   Real	 mod1_36;
   Real	 mod1_37;
   Real	 mod1_38;
   Real	 mod1_39;
   Real	 mod1_40;
   Real	 mod1_41;
   Real	 mod1_42;
   Real	 mod1_43;
   Real	 mod1_44;
   Real	 mod1_45;
   Real	 mod1_46;
   Real	 mod1_47;
   Real	 mod1_48;
   Real	 mod1_49;
   Real	 mod1_50;
   Real	 mod1_51;
   Real	 mod1_52;
   Real	 mod1_53;
   Real	 mod1_54;
   Real	 mod1_55;
   Real	 mod1_56;
   Real	 mod1_57;
   Real	 mod1_58;
   Real	 mod1_59;
   Real	 mod1_60;
   Real	 mod1_61;
   Real	 mod1_62;
   Real	 mod1_63;
   Real	 mod1_64;
   Real	 mod1_65;
   Real	 mod1_66;
   Real	 mod1_67;
   Real	 mod1_68;
   Real	 mod1_69;
   Real	 mod1_70;
   Real	 mod1_71;
   Real	 mod1_72;
   Real	 mod1_73;
   Real	 mod1_74;
   Real	 mod1_75;
   Real	 mod1_76;
   Real	 mod1_77;
   Real	 mod1_78;
   Real	 mod1_79;
   Real	 mod1_80;
   Real	 mod1_81;
   Real	 mod1_82;
   Real	 mod1_83;
   Real	 mod1_84;
   Real	 mod1_85;
   Real	 mod1_86;
   Real	 mod1_87;
   Real	 mod1_88;
   Real	 mod1_89;
   Real	 mod1_90;
   Real	 mod1_91;
   Real	 mod1_92;
   Real	 mod1_93;
   Real	 mod1_94;
   Real	 mod1_95;
   Real	 mod1_96;
   Real	 mod1_97;
   Real	 mod1_98;
   Real	 mod1_99;
   Real	 mod1_100;
   Real	 mod1_101;
   Real	 mod1_102;
   Real	 mod1_103;
   Real	 mod1_104;
   Real	 mod1_105;
   Real	 mod1_106;
   Real	 mod1_107;
   Real	 mod1_108;
   Real	 mod1_109;
   Real	 mod1_110;
   Real	 mod1_111;
   Real	 mod1_112;
   Real	 mod1_113;
   Real	 mod1_114;
   Real	 mod1_115;
   Real	 mod1_116;
   Real	 mod1_117;
   Real	 mod1_118;
   Real	 mod1_119;
   Real	 mod1_120;
   Real	 mod1_121;
   Real	 mod1_122;
   Real	 mod1_123;
   Real	 mod1_124;
   Real	 mod1_125;
   Real	 mod1_126;
   Real	 mod1_127;
   Real	 mod1_128;
   Real	 mod1_129;
   Real	 mod1_130;
   Real	 mod1_131;
   Real	 mod1_132;
   Real	 mod1_133;
   Real	 mod1_134;
   Real	 mod1_135;
   Real	 mod1_136;
   Real	 mod1_137;
   Real	 mod1_138;
   Real	 mod1_139;
   Real	 mod1_140;
   Real	 mod1_141;
   Real	 mod1_142;
   Real	 mod1_143;
   Real	 mod1_144;
   Real	 mod1_145;
   Real	 mod1_146;
   Real	 mod1_147;
   Real	 mod1_148;
   Real	 mod1_149;
   Real	 mod1_150;
   Real	 mod1_151;
   Real	 mod1_152;
   Real	 mod1_153;
   Real	 mod1_154;
   Real	 mod1_155;
   Real	 mod1_156;
   Real	 mod1_157;
   Real	 mod1_158;
   Real	 mod1_159;
   Real	 mod1_160;
   Real	 mod1_161;
   Real	 mod1_162;
   Real	 mod1_163;
   Real	 mod1_164;
   Real	 mod1_165;
   Real	 mod1_166;
   Real	 mod1_167;
   Real	 mod1_168;
   Real	 mod1_169;
   Real	 mod1_170;
   Real	 mod1_171;
   Real	 mod1_172;
   Real	 mod1_173;
   Real	 mod1_174;
   Real	 mod1_175;
   Real	 mod1_176;
   Real	 mod1_177;
   Real	 mod1_178;
   Real	 mod1_179;
   Real	 mod1_180;
   Real	 mod1_181;
   Real	 mod1_182;
   Real	 mod1_183;
   Real	 mod1_184;
   Real	 mod1_185;
   Real	 mod1_186;
   Real	 mod1_187;
   Real	 mod1_188;
   Real	 mod1_189;
   Real	 mod1_190;
   Real	 mod1_191;
   Real	 mod1_192;
   Real	 mod1_193;
   Real	 mod1_194;
   Real	 mod1_195;
   Real	 mod1_196;
   Real	 mod1_197;
   Real	 mod1_198;
   Real	 mod1_199;
   Real	 mod1_200;
   Real	 mod1_201;
   Real	 mod1_202;
   Real	 mod1_203;
   Real	 mod1_204;
   Real	 mod1_205;
   Real	 mod1_206;
   Real	 mod1_lgt;
   Real	 pbr;
   Real	 sbr;
   Real	 offset;
   Integer	 base;
   Integer	 pts;
   Real	 lgt;
   Integer	 fp1606_1_0;
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
   Integer	 stolenid;
   Integer	 manipulatedid;
   Integer	 manipulatedidpt2;
   Integer	 syntheticid;
   Integer	 suspiciousactivity;
   Integer	 vulnerablevictim;
   Integer	 friendlyfraud;
   Integer	 stolenc_fp1606_1_0;
   Integer	 manip2c_fp1606_1_0;
   Integer	 synthc_fp1606_1_0;
   Integer	 suspactc_fp1606_1_0;
   Integer	 vulnvicc_fp1606_1_0;
   Integer	 friendlyc_fp1606_1_0;
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
	truedid                          := le.truedid;
	out_addr_status                  := le.shell_input.addr_status;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_type                         := le.iid.nap_type;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
	rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
	rc_disthphoneaddr                := le.iid.disthphoneaddr;
	combo_ssnscore                   := le.iid.combo_ssnscore;
	hdr_source_profile               := le.source_profile;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	emailpop                         := le.input_validation.email;
	hphnpop                          := le.input_validation.homephone;
	util_adl_count                   := le.utility.utili_adl_count;
	util_add_input_type_list         := le.utility.utili_addr1_type;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
	add_input_owned_not_occ          := le.address_verification.inputaddr_owned_not_occupied;
	add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
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
	phone_ver_experian               := le.Experian_Phone_Verification;
	header_first_seen                := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_ssn                    := if(isFCRA, 0, le.velocity_counters.addrs_per_ssn );
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	phones_per_addr_curr             := le.velocity_counters.phones_per_addr_current;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
	lnames_per_adl_c6                := if(isFCRA, 0, le.velocity_counters.lnames_per_adl180);
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	phones_per_addr_c6               := if(isFCRA, 0, le.velocity_counters.phones_per_addr_created_6months );
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	inq_email_ver_count              := le.acc_logs.inquiry_email_ver_ct;
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
	inq_highriskcredit_count_week    := if(isFCRA, 0, le.acc_logs.highriskcredit.countweek);
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
	inq_dobsperssn                   := if(isFCRA, 0, le.acc_logs.inquiryDOBsPerSSN );
	inq_peraddr                      := if(isFCRA, 0, le.acc_logs.inquiryPerAddr );
	inq_perphone                     := if(isFCRA, 0, le.acc_logs.inquiryPerPhone );
	inq_adlsperphone                 := if(isFCRA, 0, le.acc_logs.inquiryADLsPerPhone );
	br_source_count                  := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count                    := le.impulse.count;
	email_domain_free_count          := le.email_summary.email_domain_free_ct;
	email_domain_isp_count           := le.email_summary.email_domain_isp_ct;
	email_verification               := le.email_summary.identity_email_verification_level;
	adl_per_email                    := le.email_summary.reverse_email.adls_per_email;
	attr_num_aircraft                := le.aircraft.aircraft_count;
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
	fp_idverrisktype                 := le.fdattributesv2.idverrisklevel;
	fp_sourcerisktype                := le.fdattributesv2.sourcerisklevel;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_vardobcount                   := le.fdattributesv2.variationdobcount;
	fp_srchvelocityrisktype          := le.fdattributesv2.searchvelocityrisklevel;
	fp_srchunvrfdssncount            := le.fdattributesv2.searchunverifiedssncountyear;
	fp_srchunvrfddobcount            := le.fdattributesv2.searchunverifieddobcountyear;
	fp_srchunvrfdphonecount          := le.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcountyr          := le.fdattributesv2.searchfraudsearchcountyear;
	fp_srchfraudsrchcountmo          := le.fdattributesv2.searchfraudsearchcountmonth;
	fp_srchfraudsrchcountwk          := le.fdattributesv2.searchfraudsearchcountweek;
	fp_assocrisktype                 := le.fdattributesv2.assocrisklevel;
	fp_assoccredbureaucount          := le.fdattributesv2.assoccreditbureauonlycount;
	fp_assoccredbureaucountnew       := le.fdattributesv2.assoccreditbureauonlycountnew;
	fp_divrisktype                   := le.fdattributesv2.divrisklevel;
	fp_divaddrsuspidcountnew         := le.fdattributesv2.divaddrsuspidentitycountnew;
	fp_divsrchaddrsuspidcount        := le.fdattributesv2.divsearchaddrsuspidentitycount;
	fp_srchcomponentrisktype         := le.fdattributesv2.searchcomponentrisklevel;
	fp_srchssnsrchcountmo            := le.fdattributesv2.searchssnsearchcountmonth;
	fp_srchssnsrchcountwk            := le.fdattributesv2.searchssnsearchcountweek;
	fp_srchaddrsrchcountmo           := le.fdattributesv2.searchaddrsearchcountmonth;
	fp_srchaddrsrchcountwk           := le.fdattributesv2.searchaddrsearchcountweek;
	fp_srchphonesrchcountmo          := le.fdattributesv2.searchphonesearchcountmonth;
	fp_srchphonesrchcountwk          := le.fdattributesv2.searchphonesearchcountweek;
	fp_componentcharrisktype         := le.fdattributesv2.componentcharrisklevel;
	fp_addrchangeincomediff          := le.fdattributesv2.addrchangeincomediff;
	fp_addrchangevaluediff           := le.fdattributesv2.addrchangevaluediff;
	fp_addrchangecrimediff           := le.fdattributesv2.addrchangecrimediff;
	fp_addrchangeecontrajindex       := le.fdattributesv2.addrchangeecontrajectoryindex;
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
	filing_count                     := le.bjl.filing_count;
	bk_chapter                       := le.bjl.bk_chapter;
	bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
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
	liens_rel_ft_last_seen           := le.liens.liens_released_federal_tax.most_recent_filing_date;
	liens_unrel_ot_first_seen        := le.liens.liens_unreleased_other_tax.earliest_filing_date;
	liens_unrel_ot_last_seen         := le.liens.liens_unreleased_other_tax.most_recent_filing_date;
	liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
	liens_rel_ot_first_seen          := le.liens.liens_released_other_tax.earliest_filing_date;
	liens_rel_ot_last_seen           := le.liens.liens_released_other_tax.most_recent_filing_date;
	liens_rel_ot_total_amount        := le.liens.liens_released_other_tax.total_amount;
	liens_unrel_sc_first_seen        := le.liens.liens_unreleased_small_claims.earliest_filing_date;
	liens_unrel_sc_total_amount      := le.liens.liens_unreleased_small_claims.total_amount;
	liens_rel_sc_first_seen          := le.liens.liens_released_small_claims.earliest_filing_date;
	liens_rel_sc_last_seen           := le.liens.liens_released_small_claims.most_recent_filing_date;
	liens_rel_sc_total_amount        := le.liens.liens_released_small_claims.total_amount;
	liens_unrel_st_ct                := le.liens.liens_unreleased_suits.count;
	liens_unrel_st_last_seen         := le.liens.liens_unreleased_suits.most_recent_filing_date;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_count                     := le.bjl.felony_count;
	felony_last_date                 := le.bjl.last_felony_date;
	foreclosure_last_date            := le.bjl.last_foreclosure_date;
	hh_members_ct                    := le.hhid_summary.hh_members_ct;
	hh_property_owners_ct            := le.hhid_summary.hh_property_owners_ct;
	hh_age_65_plus                   := le.hhid_summary.hh_age_65_plus;
	hh_age_30_to_65                  := le.hhid_summary.hh_age_31_to_65;
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
	historical_count                 := le.vehicles.historical_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	acc_count                        := le.accident_data.acc.num_accidents;
	acc_last_seen                    := le.accident_data.acc.datelastaccident;
	acc_damage_amt_last              := le.accident_data.acc.dmgamtlastaccident;
	acc_count_30                     := le.accident_data.acc.numaccidents30;
	acc_count_90                     := le.accident_data.acc.numaccidents90;
	acc_count_180                    := le.accident_data.acc.numaccidents180;
	acc_count_12                     := le.accident_data.acc.numaccidents12;
	acc_count_24                     := le.accident_data.acc.numaccidents24;
	acc_count_36                     := le.accident_data.acc.numaccidents36;
	acc_count_60                     := le.accident_data.acc.numaccidents60;
	college_file_type                := le.student.file_type2;
	college_attendance               := le.attended_college;
	prof_license_flag                := le.professional_license.professional_license_flag;
	wealth_index                     := le.wealth_indicator;
	inferred_age                     := le.inferred_age;
	estimated_income                 := le.estimated_income;

	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */

NULL := -999999999;

INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

sysdate := __common__(common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01')));

k_nap_phn_verd_d := __common__((Integer)(nap_summary in [4, 6, 7, 9, 10, 11, 12]));

k_nap_fname_verd_d := __common__((Integer)(nap_summary in [2, 3, 4, 8, 9, 10, 12]));

k_inf_fname_verd_d := __common__((Integer)(infutor_nap in [2, 3, 4, 8, 9, 10, 12]));

r_p88_phn_dst_to_inp_add_i := __common__(if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr));

add_ec1 := __common__((StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1]);

add_ec3 := __common__((StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3]);

add_ec4 := __common__((StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4]);

r_l70_add_standardized_i := __common__(map(
    not(addrpop)       => NULL,
    trim(trim(add_ec1, LEFT), LEFT, RIGHT) = 'E'         => 2,
    add_ec1 = 'S' and (add_ec3 != '0' or add_ec4 != '0') => 1,
         0));

r_f00_ssn_score_d := __common__(if(not(truedid and ssnlength > '0') or combo_ssnscore = 255, NULL, min(if(combo_ssnscore = NULL, -NULL, combo_ssnscore), 999)));

r_f01_inp_addr_address_score_d := __common__(if(not(truedid and add_input_pop) or add_input_address_score = 255, NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999)));

r_d30_derog_count_i := __common__(if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999)));

r_d32_criminal_count_i := __common__(if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999)));

_criminal_last_date := __common__(common.sas_date((string)(criminal_last_date)));

r_d32_mos_since_crim_ls_d := __common__(map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => 241,
                 max(3, min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240))));

_felony_last_date := __common__(common.sas_date((string)(felony_last_date)));

r_d32_mos_since_fel_ls_d := __common__(map(
    not(truedid)             => NULL,
    _felony_last_date = NULL => 241,
               max(3, min(if(if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12)))), 240))));

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

r_d31_bk_chapter_n := __common__(map(
    not(truedid)                => '',
    not((bk_chapter in ['7', '11', '12', '13'])) => '',
                  trim(bk_chapter, LEFT)));

r_d31_bk_filing_count_i := __common__(if(not(truedid), NULL, min(if(filing_count = NULL, -NULL, filing_count), 999)));

r_d31_bk_disposed_recent_count_i := __common__(if(not(truedid), NULL, min(if(bk_disposed_recent_count = NULL, -NULL, bk_disposed_recent_count), 999)));

r_d33_eviction_recency_d := __common__(map(
    not(truedid)             => NULL,
    (Boolean)attr_eviction_count90    => 3,
    (Boolean)attr_eviction_count180   => 6,
    (Boolean)attr_eviction_count12    => 12,
    (Boolean)attr_eviction_count24    => 24,
    (Boolean)attr_eviction_count36    => 36,
    (Boolean)attr_eviction_count60    => 60,
    (Integer)attr_eviction_count >= 1 => 99,
                                999));


r_d33_eviction_count_i := __common__(if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999)));

r_d34_unrel_liens_ct_i := __common__(if(not(truedid), NULL, min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 999)));

r_d34_unrel_lien60_count_i := __common__(if(not(truedid), NULL, min(if(attr_num_unrel_liens60 = NULL, -NULL, attr_num_unrel_liens60), 999)));

bureau_adl_eq_fseen_pos_2 := __common__(Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

bureau_adl_fseen_eq_2 := __common__(if(bureau_adl_eq_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_2, ',')));

_bureau_adl_fseen_eq_2 := __common__(common.sas_date((string)(bureau_adl_fseen_eq_2)));

_src_bureau_adl_fseen := __common__(min(if(_bureau_adl_fseen_eq_2 = NULL, -NULL, _bureau_adl_fseen_eq_2), 999999));

r_c21_m_bureau_adl_fs_d := __common__(map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => 1000,
                     min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999)));

bureau_adl_eq_fseen_pos_1 := __common__(Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

bureau_adl_fseen_eq_1 := __common__(if(bureau_adl_eq_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_1, ',')));

_bureau_adl_fseen_eq_1 := __common__(common.sas_date((string)(bureau_adl_fseen_eq_1)));

bureau_adl_en_fseen_pos_1 := __common__(Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E'));

bureau_adl_fseen_en_1 := __common__(if(bureau_adl_en_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos_1, ',')));

_bureau_adl_fseen_en_1 := __common__(common.sas_date((string)(bureau_adl_fseen_en_1)));

bureau_adl_ts_fseen_pos_1 := __common__(Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E'));

bureau_adl_fseen_ts_1 := __common__(if(bureau_adl_ts_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos_1, ',')));

_bureau_adl_fseen_ts_1 := __common__(common.sas_date((string)(bureau_adl_fseen_ts_1)));

bureau_adl_tu_fseen_pos_1 := __common__(Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E'));

bureau_adl_fseen_tu_1 := __common__(if(bureau_adl_tu_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos_1, ',')));

_bureau_adl_fseen_tu_1 := __common__(common.sas_date((string)(bureau_adl_fseen_tu_1)));

bureau_adl_tn_fseen_pos_1 := __common__(Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E'));

bureau_adl_fseen_tn_1 := __common__(if(bureau_adl_tn_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos_1, ',')));

_bureau_adl_fseen_tn_1 := __common__(common.sas_date((string)(bureau_adl_fseen_tn_1)));

_src_bureau_adl_fseen_all := __common__(min(if(_bureau_adl_fseen_tn_1 = NULL, -NULL, _bureau_adl_fseen_tn_1), if(_bureau_adl_fseen_ts_1 = NULL, -NULL, _bureau_adl_fseen_ts_1), if(_bureau_adl_fseen_tu_1 = NULL, -NULL, _bureau_adl_fseen_tu_1), if(_bureau_adl_fseen_en_1 = NULL, -NULL, _bureau_adl_fseen_en_1), if(_bureau_adl_fseen_eq_1 = NULL, -NULL, _bureau_adl_fseen_eq_1), 999999));

f_m_bureau_adl_fs_all_d := __common__(map(
    not(truedid)      => NULL,
    _src_bureau_adl_fseen_all = 999999 => 1000,
        min(if(if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)))), 999)));

bureau_adl_eq_fseen_pos := __common__(Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

bureau_adl_fseen_eq := __common__(if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ',')));

_bureau_adl_fseen_eq := __common__(common.sas_date((string)(bureau_adl_fseen_eq)));

bureau_adl_en_fseen_pos := __common__(Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E'));

bureau_adl_fseen_en := __common__(if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ',')));

_bureau_adl_fseen_en := __common__(common.sas_date((string)(bureau_adl_fseen_en)));

bureau_adl_ts_fseen_pos := __common__(Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E'));

bureau_adl_fseen_ts := __common__(if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos, ',')));

_bureau_adl_fseen_ts := __common__(common.sas_date((string)(bureau_adl_fseen_ts)));

bureau_adl_tu_fseen_pos := __common__(Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E'));

bureau_adl_fseen_tu := __common__(if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos, ',')));

_bureau_adl_fseen_tu := __common__(common.sas_date((string)(bureau_adl_fseen_tu)));

bureau_adl_tn_fseen_pos := __common__(Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E'));

bureau_adl_fseen_tn := __common__(if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos, ',')));

_bureau_adl_fseen_tn := __common__(common.sas_date((string)(bureau_adl_fseen_tn)));

_src_bureau_adl_fseen_notu := __common__(min(if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999));

f_m_bureau_adl_fs_notu_d := __common__(map(
    not(truedid)       => NULL,
    _src_bureau_adl_fseen_notu = 999999 => 1000,
         min(if(if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)))), 999)));

_header_first_seen := __common__(common.sas_date((string)(header_first_seen)));

r_c10_m_hdr_fs_d := __common__(map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => 1000,
                min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999)));

r_c12_num_nonderogs_d := __common__(if(not(truedid), NULL, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 999)));

_in_dob := __common__(common.sas_date((string)(in_dob)));

yr_in_dob := __common__(if(_in_dob = NULL, NULL, (sysdate - _in_dob) / 365.25));

yr_in_dob_int := __common__(if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob)));

k_comb_age_d := __common__(map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                   NULL));

r_a44_curr_add_naprop_d := __common__(if(not(truedid and add_curr_pop), NULL, add_curr_naprop));

r_l80_inp_avm_autoval_d := __common__(map(
    not(add_input_pop)         => NULL,
    add_input_avm_auto_val = 0 => NULL,
                 min(if(add_input_avm_auto_val = NULL, -NULL, add_input_avm_auto_val), 300000)));

r_a46_curr_avm_autoval_d := __common__(map(
    not(add_curr_pop)         => NULL,
    add_curr_avm_auto_val = 0 => NULL,
                min(if(add_curr_avm_auto_val = NULL, -NULL, add_curr_avm_auto_val), 300000)));

r_a49_curr_avm_chg_1yr_i := __common__(map(
    not(add_curr_pop)       => NULL,
    add_curr_lres < 12      => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => add_curr_avm_auto_val - add_curr_avm_auto_val_2,
              NULL));

r_a49_curr_avm_chg_1yr_pct_i := __common__(map(
    not(add_curr_pop)       => NULL,
    add_curr_lres < 12      => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2/0.1)*0.1,
              NULL));

r_c13_curr_addr_lres_d := __common__(if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999)));

r_c13_max_lres_d := __common__(if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999)));

r_c14_addrs_5yr_i := __common__(if(not(truedid), NULL, min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999)));

r_c14_addrs_10yr_i := __common__(if(not(truedid), NULL, min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999)));

r_c14_addrs_per_adl_c6_i := __common__(if(not(truedid), NULL, min(if(addrs_per_adl_c6 = NULL, -NULL, addrs_per_adl_c6), 999)));

r_c14_addrs_15yr_i := __common__(if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999)));

r_prop_owner_history_d := __common__(map(
    not(truedid)                  => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 2,
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 1,
                    0));

r_a43_watercraft_cnt_d := __common__(if(not(truedid), NULL, watercraft_count));

r_ever_asset_owner_d := __common__(map(
    not(truedid)                                        => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 or watercraft_count > 0 or attr_num_aircraft > 0 => 1,
                                          0));

r_c20_email_domain_free_count_i := __common__(if(not(truedid), NULL, min(if(email_domain_free_count = NULL, -NULL, email_domain_free_count), 999)));

r_c20_email_domain_isp_count_i := __common__(if(not(truedid), NULL, min(if(email_domain_ISP_count = NULL, -NULL, email_domain_ISP_count), 999)));

r_e57_prof_license_flag_d := __common__(if(not(truedid), NULL, (Integer)prof_license_flag));

r_l79_adls_per_addr_curr_i := __common__(if(not(add_curr_pop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999)));

r_l79_adls_per_addr_c6_i := __common__(if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999)));

r_i60_inq_count12_i := __common__(if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999)));

r_i60_inq_recency_d := __common__( map(
    not(truedid) => NULL,
    (Boolean)inq_count01  => 1,
    (Boolean)inq_count03  => 3,
    (Boolean)inq_count06  => 6,
    (Boolean)inq_count12  => 12,
    (Boolean)inq_count24  => 24,
    (Boolean)inq_count    => 99,
                    999));

r_i61_inq_collection_count12_i := __common__(if(not(truedid), NULL, min(if(inq_collection_count12 = NULL, -NULL, inq_collection_count12), 999)));

r_i61_inq_collection_recency_d := __common__( map(
    not(truedid)           => NULL,
    (Boolean)inq_collection_count01 => 1,
    (Boolean)inq_collection_count03 => 3,
    (Boolean)inq_collection_count06 => 6,
    (Boolean)inq_collection_count12 => 12,
    (Boolean)inq_collection_count24 => 24,
    (Boolean)inq_collection_count   => 99,
                              999));

r_i60_inq_auto_count12_i := __common__(if(not(truedid), NULL, min(if(inq_auto_count12 = NULL, -NULL, inq_auto_count12), 999)));

r_i60_inq_auto_recency_d := __common__( map(
    not(truedid)     => NULL,
    (Boolean)inq_auto_count01 => 1,
    (Boolean)inq_auto_count03 => 3,
    (Boolean)inq_auto_count06 => 6,
    (Boolean)inq_auto_count12 => 12,
    (Boolean)inq_auto_count24 => 24,
    (Boolean)inq_auto_count   => 99,
                        999));

r_i60_inq_banking_recency_d := __common__(map(
    not(truedid)        => NULL,
    (Boolean)inq_banking_count01 => 1,
    (Boolean)inq_banking_count03 => 3,
    (Boolean)inq_banking_count06 => 6,
    (Boolean)inq_banking_count12 => 12,
    (Boolean)inq_banking_count24 => 24,
    (Boolean)inq_banking_count   => 99,
                           999));

r_i60_inq_mortgage_recency_d := __common__(map(
    not(truedid)         => NULL,
    (Boolean)inq_mortgage_count01 => 1,
    (Boolean)inq_mortgage_count03 => 3,
    (Boolean)inq_mortgage_count06 => 6,
    (Boolean)inq_mortgage_count12 => 12,
    (Boolean)inq_mortgage_count24 => 24,
    (Boolean)inq_mortgage_count   => 99,
           999));

r_i60_inq_hiriskcred_count12_i := __common__(if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999)));

r_i60_inq_hiriskcred_recency_d := __common__(map(
    not(truedid)               => NULL,
    (Boolean)inq_highRiskCredit_count01 => 1,
    (Boolean)inq_highRiskCredit_count03 => 3,
    (Boolean)inq_highRiskCredit_count06 => 6,
    (Boolean)inq_highRiskCredit_count12 => 12,
    (Boolean)inq_highRiskCredit_count24 => 24,
    (Boolean)inq_highRiskCredit_count   => 99,
                 999));

r_i60_inq_retail_recency_d := __common__(map(
    not(truedid)       => NULL,
    (Boolean)inq_retail_count01 => 1,
    (Boolean)inq_retail_count03 => 3,
    (Boolean)inq_retail_count06 => 6,
    (Boolean)inq_retail_count12 => 12,
    (Boolean)inq_retail_count24 => 24,
    (Boolean)inq_retail_count   => 99,
         999));

r_i60_inq_comm_recency_d := __common__(map(
    not(truedid)               => NULL,
    (Boolean)inq_communications_count01 => 1,
    (Boolean)inq_communications_count03 => 3,
    (Boolean)inq_communications_count06 => 6,
    (Boolean)inq_communications_count12 => 12,
    (Boolean)inq_communications_count24 => 24,
    (Boolean)inq_communications_count   => 99,
                 999));

f_util_adl_count_n := __common__(if(not(truedid), NULL, util_adl_count));

f_util_add_input_conv_n := __common__(if(contains_i(util_add_input_type_list, '2') > 0, 1, 0));

f_add_input_mobility_index_i := __common__(map(
    not(addrpop)                 => NULL,
    add_input_occupants_1yr <= 0 => NULL,
                   if(max(add_input_turnover_1yr_in, add_input_turnover_1yr_out) = NULL, NULL, sum(if(add_input_turnover_1yr_in = NULL, 0, add_input_turnover_1yr_in), if(add_input_turnover_1yr_out = NULL, 0, add_input_turnover_1yr_out))) / add_input_occupants_1yr));

add_input_nhood_prop_sum_3 := __common__(if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))));

f_add_input_nhood_bus_pct_i := __common__(map(
    not(addrpop)               => NULL,
    add_input_nhood_BUS_ct = 0 => NULL,
                 add_input_nhood_BUS_ct / add_input_nhood_prop_sum_3));

add_input_nhood_prop_sum_2 := __common__(if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))));

f_add_input_nhood_mfd_pct_i := __common__(map(
    not(addrpop)               => NULL,
    add_input_nhood_MFD_ct = 0 => NULL,
                 add_input_nhood_MFD_ct / add_input_nhood_prop_sum_2));

add_input_nhood_prop_sum_1 := __common__(if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))));

f_add_input_nhood_sfd_pct_d := __common__(map(
    not(addrpop)               => NULL,
    add_input_nhood_SFD_ct = 0 => -1,
                 add_input_nhood_SFD_ct / add_input_nhood_prop_sum_1));

add_input_nhood_prop_sum := __common__(if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct))));

f_add_input_nhood_vac_pct_i := __common__(map(
    not(addrpop)                 => NULL,
    add_input_nhood_prop_sum = 0 => -1,
                   add_input_nhood_VAC_prop / add_input_nhood_prop_sum));

f_add_curr_mobility_index_i := __common__(map(
    not(add_curr_pop)           => NULL,
    add_curr_occupants_1yr <= 0 => NULL,
                  if(max(add_curr_turnover_1yr_in, add_curr_turnover_1yr_out) = NULL, NULL, sum(if(add_curr_turnover_1yr_in = NULL, 0, add_curr_turnover_1yr_in), if(add_curr_turnover_1yr_out = NULL, 0, add_curr_turnover_1yr_out))) / add_curr_occupants_1yr));

add_curr_nhood_prop_sum_3 := __common__(if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))));

f_add_curr_nhood_bus_pct_i := __common__(map(
    not(add_curr_pop)         => NULL,
    add_curr_nhood_BUS_ct = 0 => NULL,
                add_curr_nhood_BUS_ct / add_curr_nhood_prop_sum_3));

add_curr_nhood_prop_sum_2 := __common__(if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))));

f_add_curr_nhood_mfd_pct_i := __common__(map(
    not(add_curr_pop)         => NULL,
    add_curr_nhood_MFD_ct = 0 => NULL,
                add_curr_nhood_MFD_ct / add_curr_nhood_prop_sum_2));

add_curr_nhood_prop_sum_1 := __common__(if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))));

f_add_curr_nhood_sfd_pct_d := __common__(map(
    not(add_curr_pop)         => NULL,
    add_curr_nhood_SFD_ct = 0 => -1,
                add_curr_nhood_SFD_ct / add_curr_nhood_prop_sum_1));

add_curr_nhood_prop_sum := __common__(if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct))));

f_add_curr_nhood_vac_pct_i := __common__(map(
    not(add_curr_pop)           => NULL,
    add_curr_nhood_prop_sum = 0 => -1,
                  add_curr_nhood_VAC_prop / add_curr_nhood_prop_sum));

f_inq_count24_i := __common__(if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999)));

f_inq_banking_count24_i := __common__(if(not(truedid), NULL, min(if(inq_Banking_count24 = NULL, -NULL, inq_Banking_count24), 999)));

f_inq_collection_count24_i := __common__(if(not(truedid), NULL, min(if(inq_Collection_count24 = NULL, -NULL, inq_Collection_count24), 999)));

f_inq_communications_count24_i := __common__(if(not(truedid), NULL, min(if(inq_Communications_count24 = NULL, -NULL, inq_Communications_count24), 999)));

f_inq_highriskcredit_count24_i := __common__(if(not(truedid), NULL, min(if(inq_HighRiskCredit_count24 = NULL, -NULL, inq_HighRiskCredit_count24), 999)));

f_inq_other_count24_i := __common__(if(not(truedid), NULL, min(if(inq_Other_count24 = NULL, -NULL, inq_Other_count24), 999)));

f_inq_retail_count24_i := __common__(if(not(truedid), NULL, min(if(inq_Retail_count24 = NULL, -NULL, inq_Retail_count24), 999)));

k_inq_per_ssn_i := __common__(if(not(ssnlength > '0'), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999)));

k_inq_dobs_per_ssn_i := __common__(if(not(ssnlength > '0'), NULL, min(if(inq_dobsperssn = NULL, -NULL, inq_dobsperssn), 999)));

k_inq_per_addr_i := __common__(if(not(addrpop), NULL, min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999)));

k_inq_per_phone_i := __common__(if(not(hphnpop), NULL, min(if(inq_perphone = NULL, -NULL, inq_perphone), 999)));

k_inq_adls_per_phone_i := __common__(if(not(hphnpop), NULL, min(if(inq_adlsperphone = NULL, -NULL, inq_adlsperphone), 999)));

f_attr_arrests_i := __common__(if(not(truedid), NULL, min(if(attr_arrests = NULL, -NULL, attr_arrests), 999)));

f_attr_arrest_recency_d := __common__(map(
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

_liens_unrel_cj_first_seen := __common__(common.sas_date((string)(liens_unrel_CJ_first_seen)));

f_mos_liens_unrel_cj_fseen_d := __common__(map(
    not(truedid)     => NULL,
    _liens_unrel_cj_first_seen = NULL => 1000,
       min(if(if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)))), 999)));

_liens_unrel_cj_last_seen := __common__(common.sas_date((string)(liens_unrel_CJ_last_seen)));

f_mos_liens_unrel_cj_lseen_d := __common__(map(
    not(truedid)    => NULL,
    _liens_unrel_cj_last_seen = NULL => 1000,
      max(3, min(if(if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)))), 999))));

f_liens_unrel_cj_total_amt_i := __common__(if(not(truedid), NULL, liens_unrel_CJ_total_amount));

_liens_rel_cj_first_seen := __common__(common.sas_date((string)(liens_rel_CJ_first_seen)));

f_mos_liens_rel_cj_fseen_d := __common__(map(
    not(truedid)   => NULL,
    _liens_rel_cj_first_seen = NULL => 1000,
                      min(if(if ((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)))), 999)));

_liens_rel_cj_last_seen := __common__(common.sas_date((string)(liens_rel_CJ_last_seen)));

f_mos_liens_rel_cj_lseen_d := __common__(map(
    not(truedid)                   => NULL,
    _liens_rel_cj_last_seen = NULL => 1000,
                     max(3, min(if(if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)))), 999))));

f_liens_rel_cj_total_amt_i := __common__(if(not(truedid), NULL, liens_rel_CJ_total_amount));

_liens_unrel_ft_first_seen := __common__(common.sas_date((string)(liens_unrel_FT_first_seen)));

f_mos_liens_unrel_ft_fseen_d := __common__(map(
    not(truedid)     => NULL,
    _liens_unrel_ft_first_seen = NULL => 1000,
       min(if(if ((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)))), 999)));

_liens_unrel_ft_last_seen := __common__(common.sas_date((string)(liens_unrel_FT_last_seen)));

f_mos_liens_unrel_ft_lseen_d := __common__(map(
    not(truedid)    => NULL,
    _liens_unrel_ft_last_seen = NULL => 1000,
      max(3, min(if(if ((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12)))), 999))));

f_liens_unrel_ft_total_amt_i := __common__(if(not(truedid), NULL, liens_unrel_FT_total_amount));

_liens_rel_ft_first_seen := __common__(common.sas_date((string)(liens_rel_FT_first_seen)));

f_mos_liens_rel_ft_fseen_d := __common__(map(
    not(truedid)   => NULL,
    _liens_rel_ft_first_seen = NULL => 1000,
                      min(if(if ((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12)))), 999)));

_liens_rel_ft_last_seen := __common__(common.sas_date((string)(liens_rel_FT_last_seen)));

f_mos_liens_rel_ft_lseen_d := __common__(map(
    not(truedid)                   => NULL,
    _liens_rel_ft_last_seen = NULL => 1000,
                     max(3, min(if(if ((sysdate - _liens_rel_ft_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ft_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ft_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ft_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ft_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ft_last_seen) / (365.25 / 12)))), 999))));

_liens_unrel_ot_first_seen := __common__(common.sas_date((string)(liens_unrel_OT_first_seen)));

f_mos_liens_unrel_ot_fseen_d := __common__(map(
    not(truedid)     => NULL,
    _liens_unrel_ot_first_seen = NULL => 1000,
       min(if(if ((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)))), 999)));

_liens_unrel_ot_last_seen := __common__(common.sas_date((string)(liens_unrel_OT_last_seen)));

f_mos_liens_unrel_ot_lseen_d := __common__(map(
    not(truedid)    => NULL,
    _liens_unrel_ot_last_seen = NULL => 1000,
      max(3, min(if(if ((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)))), 999))));

f_liens_unrel_ot_total_amt_i := __common__(if(not(truedid), NULL, liens_unrel_OT_total_amount));

_liens_rel_ot_first_seen := __common__(common.sas_date((string)(liens_rel_OT_first_seen)));

f_mos_liens_rel_ot_fseen_d := __common__(map(
    not(truedid)   => NULL,
    _liens_rel_ot_first_seen = NULL => -1,
                      min(if(if ((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)))), 999)));

_liens_rel_ot_last_seen := __common__(common.sas_date((string)(liens_rel_OT_last_seen)));

f_mos_liens_rel_ot_lseen_d := __common__(map(
    not(truedid)                   => NULL,
    _liens_rel_ot_last_seen = NULL => 1000,
                     max(3, min(if(if ((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)))), 999))));

f_liens_rel_ot_total_amt_i := __common__(if(not(truedid), NULL, liens_rel_OT_total_amount));

_liens_unrel_sc_first_seen := __common__(common.sas_date((string)(liens_unrel_SC_first_seen)));

f_mos_liens_unrel_sc_fseen_d := __common__(map(
    not(truedid)     => NULL,
    _liens_unrel_sc_first_seen = NULL => 1000,
       min(if(if ((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)))), 999)));

f_liens_unrel_sc_total_amt_i := __common__(if(not(truedid), NULL, liens_unrel_SC_total_amount));

_foreclosure_last_date := __common__(common.sas_date((string)(foreclosure_last_date)));

f_mos_foreclosure_lseen_d := __common__(map(
    not(truedid)                  => NULL,
    _foreclosure_last_date = NULL => 1000,
                    max(3, min(if(if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12)))), 999))));

k_estimated_income_d := __common__(if(not(truedid), NULL, estimated_income));

r_wealth_index_d := __common__(if(not(truedid), NULL, (Integer)wealth_index));

f_rel_count_i := __common__(if(not(truedid), NULL, min(if(rel_count = NULL, -NULL, rel_count), 999)));

f_rel_incomeover25_count_d := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count, rel_incomeunder50_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count)))));

f_rel_incomeover50_count_d := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count)))));

f_rel_incomeover75_count_d := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    if(max(rel_incomeover100_count, rel_incomeunder100_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count)))));

f_rel_homeover50_count_d := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    if(max(rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))));

f_rel_homeover100_count_d := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    if(max(rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))));

f_rel_homeover150_count_d := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    if(max(rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))));

f_rel_homeover200_count_d := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    if(max(rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))));

f_rel_homeover300_count_d := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    if(max(rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))));

f_rel_homeover500_count_d := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    rel_homeover500_count));

f_rel_ageover20_count_d := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    if(max(rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))));

f_rel_ageover30_count_d := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    if(max(rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))));

f_rel_ageover40_count_d := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    if(max(rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))));

f_rel_educationover8_count_d := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    if(max(rel_educationunder12_count, rel_educationover12_count) = NULL, NULL, sum(if(rel_educationunder12_count = NULL, 0, rel_educationunder12_count), if(rel_educationover12_count = NULL, 0, rel_educationover12_count)))));

f_rel_educationover12_count_d := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    rel_educationover12_count));

f_crim_rel_under25miles_cnt_i := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    crim_rel_within25miles));

f_crim_rel_under100miles_cnt_i := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    if(max(crim_rel_within25miles, crim_rel_within100miles) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles)))));

f_rel_under25miles_cnt_d := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    rel_within25miles_count));

f_rel_under100miles_cnt_d := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    if(max(rel_within25miles_count, rel_within100miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count)))));

f_rel_under500miles_cnt_d := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
    if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count)))));

f_rel_bankrupt_count_i := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
    min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 999)));

f_rel_criminal_count_i := __common__(map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
    min(if(rel_criminal_count = NULL, -NULL, rel_criminal_count), 999)));

f_historical_count_d := __common__(if(not(truedid), NULL, min(if(historical_count = NULL, -NULL, historical_count), 999)));

f_accident_count_i := __common__(if(not(truedid), NULL, min(if(acc_count = NULL, -NULL, acc_count), 999)));

_acc_last_seen := __common__(common.sas_date((string)(acc_last_seen)));

f_mos_acc_lseen_d := __common__(map(
    not(truedid)          => NULL,
    _acc_last_seen = NULL => 1000,
            max(3, min(if(if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12)))), 999))));

f_acc_damage_amt_last_6mos_i := __common__(map(
    not(truedid)      => NULL,
    acc_count_180 = 0 => -1,
        acc_damage_amt_last));

f_accident_recency_d := __common__( map(
    not(truedid)  => NULL,
    (BOOLEAN)acc_count_30  => 1,
    (BOOLEAN)acc_count_90  => 3,
    (BOOLEAN)acc_count_180 => 6,
    (BOOLEAN)acc_count_12  => 12,
    (BOOLEAN)acc_count_24  => 24,
    (BOOLEAN)acc_count_36  => 36,
    (BOOLEAN)acc_count_60  => 60,
    (BOOLEAN)acc_count     => 61,
                     62));

f_idverrisktype_i := __common__(if(not(truedid) or fp_idverrisktype = '', NULL, (Integer)fp_idverrisktype));

f_sourcerisktype_i := __common__(map(
    not(truedid)             => NULL,
    fp_sourcerisktype = '' => NULL,
               (Integer)fp_sourcerisktype));

f_varrisktype_i := __common__(map(
    not(truedid)          => NULL,
    fp_varrisktype = '' => NULL,
            (Integer)fp_varrisktype));

f_vardobcount_i := __common__(if(not(truedid), NULL, min(if(fp_vardobcount = '', -NULL, (Integer)fp_vardobcount), 999)));

f_srchvelocityrisktype_i := __common__(map(
    not(truedid)                   => NULL,
    fp_srchvelocityrisktype = '' => NULL,
                     (Integer)fp_srchvelocityrisktype));

f_srchunvrfdssncount_i := __common__(if(not(truedid), NULL, min(if(fp_srchunvrfdssncount = '', -NULL, (Integer)fp_srchunvrfdssncount), 999)));

f_srchunvrfddobcount_i := __common__(if(not(truedid), NULL, min(if(fp_srchunvrfddobcount = '', -NULL, (Integer)fp_srchunvrfddobcount), 999)));

f_srchunvrfdphonecount_i := __common__(if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = '', -NULL, (Integer)fp_srchunvrfdphonecount), 999)));

f_srchfraudsrchcountyr_i := __common__(if(not(truedid), NULL, min(if(fp_srchfraudsrchcountyr = '', -NULL, (Integer)fp_srchfraudsrchcountyr), 999)));

f_srchfraudsrchcountmo_i := __common__(if(not(truedid), NULL, min(if(fp_srchfraudsrchcountmo = '', -NULL, (Integer)fp_srchfraudsrchcountmo), 999)));

f_srchfraudsrchcountwk_i := __common__(if(not(truedid), NULL, min(if(fp_srchfraudsrchcountwk = '', -NULL, (Integer)fp_srchfraudsrchcountwk), 999)));

f_assocrisktype_i := __common__(map(
    not(truedid)            => NULL,
    fp_assocrisktype = '' => NULL,
              (Integer)fp_assocrisktype));

f_assoccredbureaucount_i := __common__(if(not(truedid), NULL, min(if(fp_assoccredbureaucount = '', -NULL, (Integer)fp_assoccredbureaucount), 999)));

f_assoccredbureaucountnew_i := __common__(if(not(truedid), NULL, (Integer)fp_assoccredbureaucountnew));

f_divrisktype_i := __common__(map(
    not(truedid)          => NULL,
    fp_divrisktype = '' => NULL,
            (Integer)fp_divrisktype));

f_divaddrsuspidcountnew_i := __common__(if(not(truedid), NULL, min(if(fp_divaddrsuspidcountnew = '', -NULL, (Integer)fp_divaddrsuspidcountnew), 999)));

f_divsrchaddrsuspidcount_i := __common__(if(not(truedid), NULL, min(if(fp_divsrchaddrsuspidcount = '', -NULL, (Integer)fp_divsrchaddrsuspidcount), 999)));

f_srchcomponentrisktype_i := __common__(map(
    not(truedid)   => NULL,
    fp_srchcomponentrisktype = '' => NULL,
                      (Integer)fp_srchcomponentrisktype));

f_srchssnsrchcountmo_i := __common__(if(not(truedid), NULL, min(if(fp_srchssnsrchcountmo = '', -NULL, (Integer)fp_srchssnsrchcountmo), 999)));

f_srchssnsrchcountwk_i := __common__(if(not(truedid), NULL, min(if(fp_srchssnsrchcountwk = '', -NULL, (Integer)fp_srchssnsrchcountwk), 999)));

f_srchaddrsrchcountmo_i := __common__(if(not(truedid), NULL, min(if(fp_srchaddrsrchcountmo = '', -NULL, (Integer)fp_srchaddrsrchcountmo), 999)));

f_srchaddrsrchcountwk_i := __common__(if(not(truedid), NULL, min(if(fp_srchaddrsrchcountwk = '', -NULL, (Integer)fp_srchaddrsrchcountwk), 999)));

f_srchphonesrchcountmo_i := __common__(if(not(truedid), NULL, min(if(fp_srchphonesrchcountmo = '', -NULL, (Integer)fp_srchphonesrchcountmo), 999)));

f_srchphonesrchcountwk_i := __common__(if(not(truedid), NULL, min(if(fp_srchphonesrchcountwk = '', -NULL, (Integer)fp_srchphonesrchcountwk), 999)));

f_componentcharrisktype_i := __common__(map(
    not(truedid)   => NULL,
    fp_componentcharrisktype = '' => NULL,
                      (Integer)fp_componentcharrisktype));

f_addrchangeincomediff_d_1 := __common__(if(not(truedid), NULL, NULL));

f_addrchangeincomediff_d := __common__(if((Integer)fp_addrchangeincomediff = -1, NULL, (Integer)fp_addrchangeincomediff));

f_addrchangevaluediff_d := __common__(map(
    not(truedid)                => NULL,
    fp_addrchangevaluediff = '-1' => NULL,
                  (Integer)fp_addrchangevaluediff));

f_addrchangecrimediff_i := __common__(map(
    not(truedid)                => NULL,
    fp_addrchangecrimediff = '-1' => NULL,
                  (Integer)fp_addrchangecrimediff));

f_addrchangeecontrajindex_d := __common__(if(not(truedid) or fp_addrchangeecontrajindex = '' or fp_addrchangeecontrajindex = '-1', NULL, (Integer)fp_addrchangeecontrajindex));

f_curraddrmedianincome_d := __common__(if(not(add_curr_pop), NULL, (Integer)fp_curraddrmedianincome));

f_curraddrmedianvalue_d := __common__(if(not(add_curr_pop), NULL, (Integer)fp_curraddrmedianvalue));

f_curraddrmurderindex_i := __common__(if(not(add_curr_pop), NULL, (Integer)fp_curraddrmurderindex));

f_curraddrcartheftindex_i := __common__(if(not(add_curr_pop), NULL, (Integer)fp_curraddrcartheftindex));

f_curraddrburglaryindex_i := __common__(if(not(add_curr_pop), NULL, (Integer)fp_curraddrburglaryindex));

f_curraddrcrimeindex_i := __common__(if(not(add_curr_pop), NULL, (Integer)fp_curraddrcrimeindex));

f_prevaddrageoldest_d := __common__(if(not(truedid), NULL, min(if(fp_prevaddrageoldest = '', -NULL, (Integer)fp_prevaddrageoldest), 999)));

f_prevaddrlenofres_d := __common__(if(not(truedid), NULL, min(if(fp_prevaddrlenofres = '', -NULL, (Integer)fp_prevaddrlenofres), 999)));

f_prevaddrstatus_i := __common__(map(
    not(truedid)            => NULL,
    fp_prevaddrstatus = '0' => 1,
    fp_prevaddrstatus = 'U' => 2,
    fp_prevaddrstatus = 'R' => 3,
              NULL));

f_prevaddrmedianincome_d := __common__(if(not(truedid), NULL, (Integer)fp_prevaddrmedianincome));

f_prevaddrmedianvalue_d := __common__(if(not(truedid), NULL, (Integer)fp_prevaddrmedianvalue));

f_prevaddrmurderindex_i := __common__(if(not(truedid), NULL, (Integer)fp_prevaddrmurderindex));

f_prevaddrcartheftindex_i := __common__(if(not(truedid), NULL, (Integer)fp_prevaddrcartheftindex));

f_fp_prevaddrburglaryindex_i := __common__(if(not(truedid), NULL, (Integer)fp_prevaddrburglaryindex));

f_fp_prevaddrcrimeindex_i := __common__(if(not(truedid), NULL, (Integer)fp_prevaddrcrimeindex));

r_c12_source_profile_d := __common__(if(not(truedid), NULL, (Real)hdr_source_profile));

r_c23_inp_addr_occ_index_d := __common__(if(not(add_input_pop and truedid), NULL, (Integer)add_input_occ_index));

r_c23_inp_addr_owned_not_occ_d := __common__(if(not(add_input_pop and truedid), NULL, (Integer)add_input_owned_not_occ));

r_e55_college_ind_d := __common__(map(
    not(truedid)          => NULL,
    (college_file_type in ['H', 'C', 'A']) => 1,
    college_attendance    => 1,
            0));

r_e57_br_source_count_d := __common__(if(not(truedid), NULL, br_source_count));

r_i60_inq_prepaidcards_recency_d := __common__(map(
    not(truedid)             => NULL,
    (Boolean)inq_PrepaidCards_count01 => 1,
    (Boolean)inq_PrepaidCards_count03 => 3,
    (Boolean)inq_PrepaidCards_count06 => 6,
    (Boolean)inq_PrepaidCards_count12 => 12,
    (Boolean)inq_PrepaidCards_count24 => 24,
    (Boolean)inq_PrepaidCards_count   => 99,
               999));

f_phone_ver_experian_d := __common__(if(not(truedid) or phone_ver_experian = '-1', NULL, (integer)phone_ver_experian));

f_addrs_per_ssn_i := __common__(if(not(ssnlength > '0'), NULL, min(if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn), 999)));

f_phones_per_addr_curr_i := __common__(if(not(add_curr_pop), NULL, min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999)));

f_phones_per_addr_c6_i := __common__(if(not(addrpop), NULL, min(if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6), 999)));

f_inq_email_ver_count_i := __common__(if(not(truedid), NULL, min(if(inq_email_ver_count = NULL, -NULL, inq_email_ver_count), 999)));

f_inq_highriskcredit_cnt_day_i := __common__(if(not(truedid), NULL, min(if(inq_HighRiskCredit_count_day = NULL, -NULL, inq_HighRiskCredit_count_day), 999)));

f_inq_highriskcredit_cnt_week_i := __common__(if(not(truedid), NULL, min(if(inq_HighRiskCredit_count_week = NULL, -NULL, inq_HighRiskCredit_count_week), 999)));

f_adl_per_email_i := __common__(if(not(emailpop), NULL, min(if(adl_per_email = NULL, -NULL, adl_per_email), 999)));

r_c20_email_verification_d := __common__(if(not(emailpop), NULL, (Integer)email_verification));

_liens_rel_sc_first_seen := __common__(common.sas_date((string)(liens_rel_SC_first_seen)));

f_mos_liens_rel_sc_fseen_d := __common__(map(
    not(truedid)   => NULL,
    _liens_rel_sc_first_seen = NULL => 1000,
                      min(if(if ((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12)))), 999)));

_liens_rel_sc_last_seen := __common__(common.sas_date((string)(liens_rel_SC_last_seen)));

f_mos_liens_rel_sc_lseen_d := __common__(map(
    not(truedid)                   => NULL,
    _liens_rel_sc_last_seen = NULL => 1000,
                     max(3, min(if(if ((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12)))), 999))));

f_liens_rel_sc_total_amt_i := __common__(if(not(truedid), NULL, liens_rel_SC_total_amount));

f_liens_unrel_st_ct_i := __common__(if(not(truedid), NULL, min(if(liens_unrel_ST_ct = NULL, -NULL, liens_unrel_ST_ct), 999)));

_liens_unrel_st_last_seen := __common__(common.sas_date((string)(liens_unrel_ST_last_seen)));

f_mos_liens_unrel_st_lseen_d := __common__(map(
    not(truedid)    => NULL,
    _liens_unrel_st_last_seen = NULL => 1000,
      max(3, min(if(if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)))), 999))));

f_property_owners_ct_d := __common__(if(not(truedid), NULL, min(if(hh_property_owners_ct = NULL, -NULL, hh_property_owners_ct), 999)));

f_hh_age_30_plus_d := __common__(if(not(truedid), NULL, min(if(if(max(hh_age_65_plus, hh_age_30_to_65) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65))) = NULL, -NULL, if(max(hh_age_65_plus, hh_age_30_to_65) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65)))), 999)));

f_hh_collections_ct_i := __common__(if(not(truedid), NULL, min(if(hh_collections_ct = NULL, -NULL, hh_collections_ct), 999)));

f_hh_payday_loan_users_i := __common__(if(not(truedid), NULL, min(if(hh_payday_loan_users = NULL, -NULL, hh_payday_loan_users), 999)));

f_hh_members_w_derog_i := __common__(if(not(truedid), NULL, min(if(hh_members_w_derog = NULL, -NULL, hh_members_w_derog), 999)));

f_hh_tot_derog_i := __common__(if(not(truedid), NULL, min(if(hh_tot_derog = NULL, -NULL, hh_tot_derog), 999)));

f_hh_bankruptcies_i := __common__(if(not(truedid), NULL, min(if(hh_bankruptcies = NULL, -NULL, hh_bankruptcies), 999)));

f_hh_lienholders_i := __common__(if(not(truedid), NULL, min(if(hh_lienholders = NULL, -NULL, hh_lienholders), 999)));

f_hh_prof_license_holders_d := __common__(if(not(truedid), NULL, min(if(hh_prof_license_holders = NULL, -NULL, hh_prof_license_holders), 999)));

f_hh_college_attendees_d := __common__(if(not(truedid), NULL, min(if(hh_college_attendees = NULL, -NULL, hh_college_attendees), 999)));

_ver_src_ds_1 := __common__(Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0);

_ver_src_de_1 := __common__(Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0);

_ver_src_eq_1 := __common__(Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0);

_ver_src_en_1 := __common__(Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0);

_ver_src_tn_1 := __common__(Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0);

_ver_src_tu_1 := __common__(Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0);

_credit_source_cnt_1 := __common__(if(max((integer)_ver_src_eq_1, (integer)_ver_src_en_1, (integer)_ver_src_tn_1, (integer)_ver_src_tu_1) = NULL, NULL, sum((integer)_ver_src_eq_1, (integer)_ver_src_en_1, (integer)_ver_src_tn_1, (integer)_ver_src_tu_1)));

_ver_src_cnt_1 := __common__(Models.Common.countw((string)(ver_sources)));

_bureauonly_1 := __common__(_credit_source_cnt_1 > 0 AND _credit_source_cnt_1 = _ver_src_cnt_1 AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6])));

_derog_1 := __common__(felony_count > 0 OR (Integer)addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2);

_deceased_1 := __common__(rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds_1 OR _ver_src_de_1);

_ssnpriortodob_1 := __common__(rc_ssndobflag = '1' OR rc_pwssndobflag = '1');

_inputmiskeys_1 := __common__(rc_ssnmiskeyflag or rc_addrmiskeyflag or (Integer)add_input_house_number_match = 0);

_multiplessns_1 := __common__(ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1);

_hh_strikes_1 := __common__(if((Integer)max((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0) = NULL, NULL, (Integer)sum((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0)));

nf_seg_fraudpoint_3_0 := __common__(map(
    addrpop and (nas_summary in [4, 7, 9]) or fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9' or _deceased_1 or _ssnpriortodob_1 => '1: Stolen/Manip ID  ',
    _inputmiskeys_1 and (_multiplessns_1 or lnames_per_adl_c6 > 1)                                                                                                                                 => '1: Stolen/Manip ID  ',
    fnamepop and lnamepop and addrpop and ssnlength = '9' and hphnpop and nap_summary <= 4 and nas_summary <= 4 or _ver_src_cnt_1 = 0 or _bureauonly_1 or (Integer)add_curr_pop = 0                           => '2: Synth ID         ',
    _derog_1                                                                                                                                                                                         => '3: Derog            ',
    Inq_count03 > 0 or Inq_count12 >= 4 or (Integer)fp_srchfraudsrchcountyr >= 1 or (Integer)fp_srchssnsrchcountmo >= 1 or (Integer)fp_srchaddrsrchcountmo >= 1 or (Integer)fp_srchphonesrchcountmo >= 1                              => '4: Recent Activity  ',
    0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70                                                                                                                                  => '5: Vuln Vic/Friendly',
    hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes_1 >= 2 or rel_felony_count >= 2)                                                                                                => '5: Vuln Vic/Friendly',
                                                                                                                                                                                                      '6: Other            '));

mod1__0 := __common__(-1.1135557553);

mod1_1 := __common__(map(
    f_acc_damage_amt_last_6mos_i = NULL => -0.0000069677,
    f_acc_damage_amt_last_6mos_i < -0.5 => -0.0000133394,
         0.0002868257));

mod1_2 := __common__(map(
    f_accident_count_i = NULL => -0.0000165719,
    f_accident_count_i < 1.5  => -0.0000364642,
                0.0004043318));

mod1_3 := __common__(map(
    f_accident_recency_d = NULL => -0.0000277754,
    f_accident_recency_d < 9    => 0.0007560025,
                  -0.0000457742));

mod1_4 := __common__(map(
    f_add_curr_mobility_index_i = NULL          => 0.0000082699,
    f_add_curr_mobility_index_i < 0.1462272669  => -0.0149525490,
    f_add_curr_mobility_index_i < 0.14624548295 => -0.0141597624,
    f_add_curr_mobility_index_i < 0.1491158532  => -0.0131658527,
    f_add_curr_mobility_index_i < 0.1493570905  => -0.0121693660,
    f_add_curr_mobility_index_i < 0.15014222775 => -0.0062383186,
    f_add_curr_mobility_index_i < 0.15047137995 => -0.0035624372,
    f_add_curr_mobility_index_i < 0.15295092035 => -0.0018837024,
    f_add_curr_mobility_index_i < 0.1546315888  => -0.0011939044,
    f_add_curr_mobility_index_i < 0.1737189864  => 0.0003205890,
    f_add_curr_mobility_index_i < 0.209344708   => 0.0000771916,
    f_add_curr_mobility_index_i < 0.2988651357  => 0.0002519605,
    f_add_curr_mobility_index_i < 0.38490456905 => 0.0003429552,
    f_add_curr_mobility_index_i < 0.4023533315  => 0.0000855856,
    f_add_curr_mobility_index_i < 0.4340099696  => -0.0000395791,
    f_add_curr_mobility_index_i < 0.44276028085 => -0.0002480996,
    f_add_curr_mobility_index_i < 0.8494296511  => -0.0004087913,
    f_add_curr_mobility_index_i < 0.87705568085 => -0.0012892644,
                 -0.0032997182));

mod1_5 := __common__(map(
    f_add_curr_nhood_bus_pct_i = NULL          => 0.0137087019,
    f_add_curr_nhood_bus_pct_i < 0.00191387735 => 0.0508378004,
    f_add_curr_nhood_bus_pct_i < 0.00192771485 => 0.0503709670,
    f_add_curr_nhood_bus_pct_i < 0.0019314345  => 0.0501112687,
    f_add_curr_nhood_bus_pct_i < 0.00193236895 => 0.0455054416,
    f_add_curr_nhood_bus_pct_i < 0.00193704645 => 0.0452931003,
    f_add_curr_nhood_bus_pct_i < 0.0019474215  => 0.0282672598,
    f_add_curr_nhood_bus_pct_i < 0.001998004   => 0.0272312685,
    f_add_curr_nhood_bus_pct_i < 0.002000008   => -0.0024945561,
    f_add_curr_nhood_bus_pct_i < 0.00996265555 => -0.0047314520,
    f_add_curr_nhood_bus_pct_i < 0.01051841315 => -0.0046214221,
    f_add_curr_nhood_bus_pct_i < 0.01252021495 => -0.0044836875,
    f_add_curr_nhood_bus_pct_i < 0.0128068449  => -0.0043689755,
    f_add_curr_nhood_bus_pct_i < 0.01302586065 => -0.0042368910,
    f_add_curr_nhood_bus_pct_i < 0.01357906225 => -0.0041121361,
    f_add_curr_nhood_bus_pct_i < 0.01425081665 => -0.0040290533,
    f_add_curr_nhood_bus_pct_i < 0.04098254755 => -0.0038964262,
    f_add_curr_nhood_bus_pct_i < 0.040985436   => -0.0037993646,
    f_add_curr_nhood_bus_pct_i < 0.04105626895 => -0.0035821035,
    f_add_curr_nhood_bus_pct_i < 0.04106528185 => -0.0034689537,
    f_add_curr_nhood_bus_pct_i < 0.04114698495 => -0.0033595607,
    f_add_curr_nhood_bus_pct_i < 0.06637763245 => -0.0032468555,
    f_add_curr_nhood_bus_pct_i < 0.06642942245 => -0.0030417727,
    f_add_curr_nhood_bus_pct_i < 0.24781176425 => -0.0029335204,
    f_add_curr_nhood_bus_pct_i < 0.2904865201  => -0.0032603401,
    f_add_curr_nhood_bus_pct_i < 0.2913346679  => -0.0036181845,
    f_add_curr_nhood_bus_pct_i < 0.29282715    => -0.0040258330,
    f_add_curr_nhood_bus_pct_i < 0.30849462735 => -0.0047532144,
    f_add_curr_nhood_bus_pct_i < 0.3770141507  => -0.0050764090,
    f_add_curr_nhood_bus_pct_i < 0.49764725815 => -0.0056339322,
                -0.0066079538));

mod1_6 := __common__(map(
    f_add_curr_nhood_mfd_pct_i = NULL          => 0.0008873966,
    f_add_curr_nhood_mfd_pct_i < 0.0021621647  => -0.0010391276,
    f_add_curr_nhood_mfd_pct_i < 0.00223339545 => -0.0013450303,
    f_add_curr_nhood_mfd_pct_i < 0.101715944   => -0.0016307380,
    f_add_curr_nhood_mfd_pct_i < 0.10173220995 => -0.0015035353,
    f_add_curr_nhood_mfd_pct_i < 0.1019262878  => -0.0013444029,
    f_add_curr_nhood_mfd_pct_i < 0.1029175336  => -0.0012150141,
    f_add_curr_nhood_mfd_pct_i < 0.1032977962  => -0.0010846893,
    f_add_curr_nhood_mfd_pct_i < 0.12040927485 => -0.0009387698,
    f_add_curr_nhood_mfd_pct_i < 0.12709523365 => -0.0007947875,
    f_add_curr_nhood_mfd_pct_i < 0.135693553   => -0.0006515358,
    f_add_curr_nhood_mfd_pct_i < 0.14643493765 => -0.0005420372,
    f_add_curr_nhood_mfd_pct_i < 0.2139924655  => -0.0004234125,
    f_add_curr_nhood_mfd_pct_i < 0.2147137187  => -0.0002946659,
    f_add_curr_nhood_mfd_pct_i < 0.2174845053  => -0.0001826040,
    f_add_curr_nhood_mfd_pct_i < 0.2244400199  => -0.0000582469,
    f_add_curr_nhood_mfd_pct_i < 0.22537787515 => 0.0001829569,
    f_add_curr_nhood_mfd_pct_i < 0.24363031485 => 0.0002825469,
    f_add_curr_nhood_mfd_pct_i < 0.35440633225 => 0.0003948725,
    f_add_curr_nhood_mfd_pct_i < 0.89936031575 => 0.0005068795,
                -0.0000265274));

mod1_7 := __common__(map(
    f_add_curr_nhood_sfd_pct_d = NULL          => -0.0003791862,
    f_add_curr_nhood_sfd_pct_d < 0.0643261899  => -0.0171128945,
    f_add_curr_nhood_sfd_pct_d < 0.07298952635 => -0.0168305426,
    f_add_curr_nhood_sfd_pct_d < 0.10036943925 => -0.0165401204,
    f_add_curr_nhood_sfd_pct_d < 0.1005033681  => -0.0159863863,
    f_add_curr_nhood_sfd_pct_d < 0.1012429362  => -0.0151992447,
    f_add_curr_nhood_sfd_pct_d < 0.1485223699  => -0.0149564298,
    f_add_curr_nhood_sfd_pct_d < 0.14927467455 => -0.0146708754,
    f_add_curr_nhood_sfd_pct_d < 0.1492912952  => -0.0144219005,
    f_add_curr_nhood_sfd_pct_d < 0.15414387645 => -0.0140114037,
    f_add_curr_nhood_sfd_pct_d < 0.1578932168  => -0.0137849761,
    f_add_curr_nhood_sfd_pct_d < 0.15790516445 => -0.0135178334,
    f_add_curr_nhood_sfd_pct_d < 0.15938625805 => -0.0126024797,
    f_add_curr_nhood_sfd_pct_d < 0.1598969072  => -0.0123460815,
    f_add_curr_nhood_sfd_pct_d < 0.1969449812  => -0.0121473820,
    f_add_curr_nhood_sfd_pct_d < 0.20464969955 => -0.0115512745,
    f_add_curr_nhood_sfd_pct_d < 0.20502592945 => -0.0107124668,
    f_add_curr_nhood_sfd_pct_d < 0.2052145803  => -0.0105275755,
    f_add_curr_nhood_sfd_pct_d < 0.20926021365 => -0.0101082002,
    f_add_curr_nhood_sfd_pct_d < 0.20935257175 => -0.0099133136,
    f_add_curr_nhood_sfd_pct_d < 0.2112310888  => -0.0089437679,
    f_add_curr_nhood_sfd_pct_d < 0.21150848825 => -0.0087399594,
    f_add_curr_nhood_sfd_pct_d < 0.2146490847  => -0.0085653863,
    f_add_curr_nhood_sfd_pct_d < 0.21617727235 => -0.0083298344,
    f_add_curr_nhood_sfd_pct_d < 0.21628528015 => -0.0071802850,
    f_add_curr_nhood_sfd_pct_d < 0.22215829175 => -0.0070016966,
    f_add_curr_nhood_sfd_pct_d < 0.248350427   => -0.0067856110,
    f_add_curr_nhood_sfd_pct_d < 0.24841142895 => -0.0064104173,
    f_add_curr_nhood_sfd_pct_d < 0.2495567376  => -0.0058660931,
    f_add_curr_nhood_sfd_pct_d < 0.24960567825 => -0.0056910638,
    f_add_curr_nhood_sfd_pct_d < 0.2521271155  => -0.0051973500,
    f_add_curr_nhood_sfd_pct_d < 0.2547854456  => -0.0046035518,
    f_add_curr_nhood_sfd_pct_d < 0.2548575489  => -0.0039006548,
    f_add_curr_nhood_sfd_pct_d < 0.2553888975  => -0.0029651195,
    f_add_curr_nhood_sfd_pct_d < 0.2558373713  => -0.0024021785,
    f_add_curr_nhood_sfd_pct_d < 0.26765705055 => -0.0018773303,
    f_add_curr_nhood_sfd_pct_d < 0.2817857547  => -0.0016793000,
    f_add_curr_nhood_sfd_pct_d < 0.2978450277  => -0.0015011024,
    f_add_curr_nhood_sfd_pct_d < 0.2978559233  => -0.0013467115,
    f_add_curr_nhood_sfd_pct_d < 0.2981421694  => 0.0001355256,
    f_add_curr_nhood_sfd_pct_d < 0.2990785977  => 0.0004850545,
    f_add_curr_nhood_sfd_pct_d < 0.2994761716  => 0.0006512531,
    f_add_curr_nhood_sfd_pct_d < 0.66812013665 => 0.0008135838,
    f_add_curr_nhood_sfd_pct_d < 0.68075953325 => 0.0007062244,
    f_add_curr_nhood_sfd_pct_d < 0.6807606044  => 0.0006117918,
    f_add_curr_nhood_sfd_pct_d < 0.68136384165 => 0.0005043346,
    f_add_curr_nhood_sfd_pct_d < 0.99540486545 => 0.0004093104,
    f_add_curr_nhood_sfd_pct_d < 0.99541281995 => 0.0005970663,
    f_add_curr_nhood_sfd_pct_d < 0.99542159415 => 0.0009732578,
    f_add_curr_nhood_sfd_pct_d < 0.9954622671  => 0.0031684392,
    f_add_curr_nhood_sfd_pct_d < 0.9954633659  => 0.0051009022,
    f_add_curr_nhood_sfd_pct_d < 0.9956043744  => 0.0052858908,
    f_add_curr_nhood_sfd_pct_d < 0.9956059904  => 0.0054496076,
    f_add_curr_nhood_sfd_pct_d < 0.99562977545 => 0.0075218073,
    f_add_curr_nhood_sfd_pct_d < 0.9956473965  => 0.0076972361,
    f_add_curr_nhood_sfd_pct_d < 0.9973924336  => 0.0080666074,
    f_add_curr_nhood_sfd_pct_d < 0.9979939315  => 0.0082867407,
    f_add_curr_nhood_sfd_pct_d < 0.998001996   => 0.0085011773,
    f_add_curr_nhood_sfd_pct_d < 0.9980429854  => 0.0107071780,
    f_add_curr_nhood_sfd_pct_d < 0.9980449191  => 0.0109178387,
                0.0111139862));

mod1_8 := __common__(map(
    f_add_curr_nhood_vac_pct_i = NULL          => -0.0004360214,
    f_add_curr_nhood_vac_pct_i < 0.000916618   => -0.0002396757,
    f_add_curr_nhood_vac_pct_i < 0.00092004105 => -0.0005082643,
    f_add_curr_nhood_vac_pct_i < 0.00104058725 => -0.0006285525,
    f_add_curr_nhood_vac_pct_i < 0.0010465796  => -0.0015303768,
    f_add_curr_nhood_vac_pct_i < 0.00105708715 => -0.0037939518,
    f_add_curr_nhood_vac_pct_i < 0.0010599075  => -0.0042087167,
    f_add_curr_nhood_vac_pct_i < 0.00107009125 => -0.0043353359,
    f_add_curr_nhood_vac_pct_i < 0.00107066505 => -0.0073872347,
    f_add_curr_nhood_vac_pct_i < 0.0012562893  => -0.0075032719,
    f_add_curr_nhood_vac_pct_i < 0.00126422455 => -0.0077425483,
    f_add_curr_nhood_vac_pct_i < 0.0035279592  => -0.0078879657,
    f_add_curr_nhood_vac_pct_i < 0.0060876183  => -0.0077875570,
    f_add_curr_nhood_vac_pct_i < 0.0061112245  => -0.0076809622,
    f_add_curr_nhood_vac_pct_i < 0.0065746248  => -0.0075576020,
    f_add_curr_nhood_vac_pct_i < 0.02030853425 => -0.0074352945,
    f_add_curr_nhood_vac_pct_i < 0.02187606235 => -0.0072537915,
    f_add_curr_nhood_vac_pct_i < 0.02188043    => -0.0071386325,
    f_add_curr_nhood_vac_pct_i < 0.02233632785 => -0.0059817556,
    f_add_curr_nhood_vac_pct_i < 0.02234489935 => -0.0058011369,
    f_add_curr_nhood_vac_pct_i < 0.0223594559  => -0.0041760399,
    f_add_curr_nhood_vac_pct_i < 0.02239448935 => -0.0008435844,
    f_add_curr_nhood_vac_pct_i < 0.02257763055 => -0.0003137703,
    f_add_curr_nhood_vac_pct_i < 0.0225820954  => 0.0005980222,
    f_add_curr_nhood_vac_pct_i < 0.0226583056  => 0.0041836682,
    f_add_curr_nhood_vac_pct_i < 0.02265997205 => 0.0046215324,
    f_add_curr_nhood_vac_pct_i < 0.02267266765 => 0.0063064833,
    f_add_curr_nhood_vac_pct_i < 0.02294456    => 0.0068107918,
    f_add_curr_nhood_vac_pct_i < 0.022950577   => 0.0069447965,
    f_add_curr_nhood_vac_pct_i < 0.0229530218  => 0.0073423156,
    f_add_curr_nhood_vac_pct_i < 0.0229636908  => 0.0141562715,
    f_add_curr_nhood_vac_pct_i < 0.02302505355 => 0.0162450225,
    f_add_curr_nhood_vac_pct_i < 0.02302651035 => 0.0178947566,
    f_add_curr_nhood_vac_pct_i < 0.0234109884  => 0.0180053240,
    f_add_curr_nhood_vac_pct_i < 0.02341454635 => 0.0181495263,
    f_add_curr_nhood_vac_pct_i < 0.02342761075 => 0.0186864500,
    f_add_curr_nhood_vac_pct_i < 0.02348205565 => 0.0193984983,
    f_add_curr_nhood_vac_pct_i < 0.38915312035 => 0.0195604977,
                0.0189415900));

mod1_9 := __common__(map(
    f_add_input_mobility_index_i = NULL          => -0.0000051838,
    f_add_input_mobility_index_i < 0.29259545235 => -0.0001544730,
    f_add_input_mobility_index_i < 0.29913014185 => -0.0000247669,
    f_add_input_mobility_index_i < 0.29923911465 => 0.0001045425,
                  0.0002114642));

mod1_10 := __common__(map(
    f_add_input_nhood_bus_pct_i = NULL          => -0.0009293130,
    f_add_input_nhood_bus_pct_i < 0.00190842475 => 0.0019825752,
    f_add_input_nhood_bus_pct_i < 0.0019314345  => 0.0017205975,
    f_add_input_nhood_bus_pct_i < 0.0019474215  => 0.0006889480,
    f_add_input_nhood_bus_pct_i < 0.001998004   => -0.0002686863,
    f_add_input_nhood_bus_pct_i < 0.0100898115  => -0.0015735525,
    f_add_input_nhood_bus_pct_i < 0.01275598135 => -0.0014347099,
    f_add_input_nhood_bus_pct_i < 0.0127695333  => -0.0013006171,
    f_add_input_nhood_bus_pct_i < 0.0128068449  => -0.0005744556,
    f_add_input_nhood_bus_pct_i < 0.01355541785 => -0.0002932973,
    f_add_input_nhood_bus_pct_i < 0.0135600603  => -0.0001663257,
    f_add_input_nhood_bus_pct_i < 0.01404397785 => -0.0000512872,
    f_add_input_nhood_bus_pct_i < 0.01425081665 => 0.0001178893,
    f_add_input_nhood_bus_pct_i < 0.04114698495 => 0.0002484945,
    f_add_input_nhood_bus_pct_i < 0.06518198555 => 0.0003620168,
    f_add_input_nhood_bus_pct_i < 0.06637763245 => 0.0004731119,
    f_add_input_nhood_bus_pct_i < 0.0664171632  => 0.0013182068,
    f_add_input_nhood_bus_pct_i < 0.06721668425 => 0.0017694586,
    f_add_input_nhood_bus_pct_i < 0.14860547445 => 0.0018815973,
    f_add_input_nhood_bus_pct_i < 0.22442292765 => 0.0017042857,
    f_add_input_nhood_bus_pct_i < 0.24781176425 => 0.0014371753,
    f_add_input_nhood_bus_pct_i < 0.26587806525 => 0.0010983591,
    f_add_input_nhood_bus_pct_i < 0.2904865201  => 0.0007030397,
    f_add_input_nhood_bus_pct_i < 0.29109976045 => 0.0003360342,
    f_add_input_nhood_bus_pct_i < 0.29254324345 => -0.0001689815,
    f_add_input_nhood_bus_pct_i < 0.29282715    => -0.0005472661,
    f_add_input_nhood_bus_pct_i < 0.293552484   => -0.0015751522,
    f_add_input_nhood_bus_pct_i < 0.30093779095 => -0.0045655412,
    f_add_input_nhood_bus_pct_i < 0.3015349396  => -0.0049532198,
    f_add_input_nhood_bus_pct_i < 0.30154037245 => -0.0078704093,
    f_add_input_nhood_bus_pct_i < 0.30183040975 => -0.0082302075,
    f_add_input_nhood_bus_pct_i < 0.30849462735 => -0.0089522627,
    f_add_input_nhood_bus_pct_i < 0.36791218375 => -0.0096990337,
    f_add_input_nhood_bus_pct_i < 0.36796889885 => -0.0102194025,
    f_add_input_nhood_bus_pct_i < 0.37246293125 => -0.0113513839,
    f_add_input_nhood_bus_pct_i < 0.37692204445 => -0.0117992097,
    f_add_input_nhood_bus_pct_i < 0.53655343345 => -0.0132547983,
                 -0.0142627034));

mod1_11 := __common__(map(
    f_add_input_nhood_mfd_pct_i = NULL          => -0.0009823256,
    f_add_input_nhood_mfd_pct_i < 0.00137551845 => 0.0037416646,
    f_add_input_nhood_mfd_pct_i < 0.0021621647  => 0.0010132369,
    f_add_input_nhood_mfd_pct_i < 0.0021692382  => 0.0007224819,
    f_add_input_nhood_mfd_pct_i < 0.00223339545 => 0.0000997656,
    f_add_input_nhood_mfd_pct_i < 0.05821159005 => -0.0005100191,
    f_add_input_nhood_mfd_pct_i < 0.101715944   => -0.0003756627,
    f_add_input_nhood_mfd_pct_i < 0.10173220995 => -0.0002763903,
    f_add_input_nhood_mfd_pct_i < 0.13578446945 => -0.0001250928,
    f_add_input_nhood_mfd_pct_i < 0.1358279057  => -0.0000133790,
    f_add_input_nhood_mfd_pct_i < 0.13668292955 => 0.0001297819,
    f_add_input_nhood_mfd_pct_i < 0.1440269934  => 0.0002402177,
    f_add_input_nhood_mfd_pct_i < 0.2036725857  => 0.0003449356,
                 0.0004681806));

mod1_12 := __common__(map(
    f_add_input_nhood_sfd_pct_d = NULL          => -0.0001064489,
    f_add_input_nhood_sfd_pct_d < 0.0090974921  => -0.0227830830,
    f_add_input_nhood_sfd_pct_d < 0.06293732135 => -0.0223195272,
    f_add_input_nhood_sfd_pct_d < 0.062958496   => -0.0219373098,
    f_add_input_nhood_sfd_pct_d < 0.0638727561  => -0.0215890423,
    f_add_input_nhood_sfd_pct_d < 0.06550233245 => -0.0206902063,
    f_add_input_nhood_sfd_pct_d < 0.07604689075 => -0.0200318030,
    f_add_input_nhood_sfd_pct_d < 0.0851199597  => -0.0187144630,
    f_add_input_nhood_sfd_pct_d < 0.10025396565 => -0.0183788742,
    f_add_input_nhood_sfd_pct_d < 0.10036943925 => -0.0180908603,
    f_add_input_nhood_sfd_pct_d < 0.1052030075  => -0.0163582272,
    f_add_input_nhood_sfd_pct_d < 0.12084304825 => -0.0152228891,
    f_add_input_nhood_sfd_pct_d < 0.1409901081  => -0.0149545123,
    f_add_input_nhood_sfd_pct_d < 0.1412975866  => -0.0141031328,
    f_add_input_nhood_sfd_pct_d < 0.1482398586  => -0.0138246707,
    f_add_input_nhood_sfd_pct_d < 0.1961784208  => -0.0135655193,
    f_add_input_nhood_sfd_pct_d < 0.1961883869  => -0.0125518264,
    f_add_input_nhood_sfd_pct_d < 0.19641202465 => -0.0123300123,
    f_add_input_nhood_sfd_pct_d < 0.19642199075 => -0.0106472660,
    f_add_input_nhood_sfd_pct_d < 0.19648018165 => -0.0098976231,
    f_add_input_nhood_sfd_pct_d < 0.19649014775 => -0.0032331885,
    f_add_input_nhood_sfd_pct_d < 0.19666943635 => -0.0009955032,
    f_add_input_nhood_sfd_pct_d < 0.1969449812  => -0.0003002308,
    f_add_input_nhood_sfd_pct_d < 0.1973362273  => 0.0001450471,
    f_add_input_nhood_sfd_pct_d < 0.2120389109  => 0.0003550486,
    f_add_input_nhood_sfd_pct_d < 0.21221261115 => 0.0005720160,
    f_add_input_nhood_sfd_pct_d < 0.2130659727  => 0.0009640598,
    f_add_input_nhood_sfd_pct_d < 0.21617727235 => 0.0011988366,
    f_add_input_nhood_sfd_pct_d < 0.21628528015 => 0.0016637484,
    f_add_input_nhood_sfd_pct_d < 0.2493213898  => 0.0018530850,
    f_add_input_nhood_sfd_pct_d < 0.91843512525 => 0.0020603285,
    f_add_input_nhood_sfd_pct_d < 0.9227906558  => 0.0019359857,
    f_add_input_nhood_sfd_pct_d < 0.92392376955 => 0.0017771562,
                 0.0016407873));

mod1_13 := __common__(map(
    f_add_input_nhood_vac_pct_i = NULL          => -0.0004221474,
    f_add_input_nhood_vac_pct_i < 0.0007920793  => -0.0032912661,
    f_add_input_nhood_vac_pct_i < 0.00104058385 => -0.0034088514,
    f_add_input_nhood_vac_pct_i < 0.0010465796  => -0.0035379044,
    f_add_input_nhood_vac_pct_i < 0.00656922335 => -0.0038148800,
    f_add_input_nhood_vac_pct_i < 0.0065843666  => -0.0036887695,
    f_add_input_nhood_vac_pct_i < 0.02179242875 => -0.0035506408,
    f_add_input_nhood_vac_pct_i < 0.02294456    => -0.0032617226,
    f_add_input_nhood_vac_pct_i < 0.02294748175 => -0.0029882516,
    f_add_input_nhood_vac_pct_i < 0.022950577   => -0.0023149368,
    f_add_input_nhood_vac_pct_i < 0.0229530218  => -0.0009190632,
    f_add_input_nhood_vac_pct_i < 0.0229575289  => 0.0045551809,
    f_add_input_nhood_vac_pct_i < 0.0229636908  => 0.0047362176,
    f_add_input_nhood_vac_pct_i < 0.02301943405 => 0.0091495413,
    f_add_input_nhood_vac_pct_i < 0.02302505355 => 0.0094129528,
    f_add_input_nhood_vac_pct_i < 0.02302651035 => 0.0105214687,
    f_add_input_nhood_vac_pct_i < 0.02341454635 => 0.0108213299,
    f_add_input_nhood_vac_pct_i < 0.04460816745 => 0.0109595316,
    f_add_input_nhood_vac_pct_i < 0.04466779725 => 0.0111534123,
    f_add_input_nhood_vac_pct_i < 0.04467242195 => 0.0116052486,
                 0.0117608635));

mod1_14 := __common__(map(
    f_addrchangecrimediff_i = NULL  => 0.0026270731,
    f_addrchangecrimediff_i < -66.5 => 0.0037442419,
    f_addrchangecrimediff_i < -64.5 => 0.0012042424,
    f_addrchangecrimediff_i < -55.5 => 0.0008398118,
    f_addrchangecrimediff_i < -43.5 => 0.0004460029,
    f_addrchangecrimediff_i < -40.5 => -0.0003179624,
    f_addrchangecrimediff_i < 9.5   => -0.0007223819,
    f_addrchangecrimediff_i < 16.5  => -0.0004290010,
    f_addrchangecrimediff_i < 35.5  => 0.0002633421,
    f_addrchangecrimediff_i < 39.5  => 0.0047051094,
                      0.0095968719));

mod1_15 := __common__(map(
    f_addrchangeecontrajindex_d = NULL => 0.0025584770,
    f_addrchangeecontrajindex_d < 2.5  => 0.0029169531,
    f_addrchangeecontrajindex_d < 3.5  => -0.0017363107,
        -0.0019140117));

mod1_16 := __common__(map(
    f_addrchangeincomediff_d = NULL     => 0.0128492369,
    f_addrchangeincomediff_d < -36116.5 => 0.0953115838,
    f_addrchangeincomediff_d < -36082.5 => 0.0939173965,
    f_addrchangeincomediff_d < -36029   => 0.0933380489,
    f_addrchangeincomediff_d < -33790   => 0.0929040294,
    f_addrchangeincomediff_d < -33613   => 0.0924536587,
    f_addrchangeincomediff_d < -33442   => 0.0897872237,
    f_addrchangeincomediff_d < -33374   => 0.0894003930,
    f_addrchangeincomediff_d < -32956.5 => 0.0889277511,
    f_addrchangeincomediff_d < -32727   => 0.0704054965,
    f_addrchangeincomediff_d < -32694.5 => 0.0661708465,
    f_addrchangeincomediff_d < -32513   => 0.0651676348,
    f_addrchangeincomediff_d < -32455   => 0.0636810192,
    f_addrchangeincomediff_d < -32148   => 0.0632486103,
    f_addrchangeincomediff_d < -32014.5 => 0.0627057096,
    f_addrchangeincomediff_d < -31672   => 0.0622665433,
    f_addrchangeincomediff_d < -31378.5 => 0.0617544979,
    f_addrchangeincomediff_d < -31245   => 0.0143277851,
    f_addrchangeincomediff_d < -31173.5 => 0.0035175360,
    f_addrchangeincomediff_d < -31166   => 0.0024156667,
    f_addrchangeincomediff_d < -31102.5 => -0.0009889048,
    f_addrchangeincomediff_d < -30709.5 => -0.0024682246,
    f_addrchangeincomediff_d < 21178    => -0.0030305689,
         -0.0026951667));

mod1_17 := __common__(map(
    f_addrchangevaluediff_d = NULL      => 0.0096379964,
    f_addrchangevaluediff_d < -169117   => 0.0457875903,
    f_addrchangevaluediff_d < -154207.5 => 0.0453594623,
    f_addrchangevaluediff_d < -151131   => 0.0448905910,
    f_addrchangevaluediff_d < -150792.5 => 0.0444307800,
    f_addrchangevaluediff_d < -148645.5 => 0.0439138162,
    f_addrchangevaluediff_d < -144055   => 0.0422486731,
    f_addrchangevaluediff_d < -143721   => 0.0313602097,
    f_addrchangevaluediff_d < -143317.5 => 0.0286699209,
    f_addrchangevaluediff_d < -140013   => 0.0277926689,
    f_addrchangevaluediff_d < -140000   => 0.0148878977,
    f_addrchangevaluediff_d < -130355.5 => 0.0145253675,
    f_addrchangevaluediff_d < -130292.5 => 0.0132391062,
    f_addrchangevaluediff_d < -124394   => 0.0128387356,
    f_addrchangevaluediff_d < -124231   => 0.0051696871,
    f_addrchangevaluediff_d < -123775.5 => 0.0024399819,
    f_addrchangevaluediff_d < -22844    => 0.0020157529,
    f_addrchangevaluediff_d < -22776    => 0.0016593462,
    f_addrchangevaluediff_d < -22721.5  => 0.0013361057,
    f_addrchangevaluediff_d < -19879.5  => 0.0010386363,
    f_addrchangevaluediff_d < -15044.5  => -0.0002691553,
    f_addrchangevaluediff_d < -12902.5  => -0.0006104495,
    f_addrchangevaluediff_d < -11585    => -0.0017164899,
    f_addrchangevaluediff_d < -11432    => -0.0020476401,
    f_addrchangevaluediff_d < 39908     => -0.0023305701,
    f_addrchangevaluediff_d < 165908.5  => -0.0020299677,
    f_addrchangevaluediff_d < 185409    => -0.0025024290,
    f_addrchangevaluediff_d < 187398.5  => -0.0040070040,
    f_addrchangevaluediff_d < 211299.5  => -0.0046708343,
    f_addrchangevaluediff_d < 221428    => -0.0063568103,
    f_addrchangevaluediff_d < 221522.5  => -0.0089176533,
         -0.0104368142));

mod1_18 := __common__(map(
    f_addrs_per_ssn_i = NULL => 0.0000195201,
    f_addrs_per_ssn_i < 33.5 => 0.0000113692,
               0.0012868949));

mod1_19 := __common__(map(
    f_adl_per_email_i = NULL => -0.0001378541,
    f_adl_per_email_i < 0.5  => 0.0000824426,
    f_adl_per_email_i < 1.5  => -0.0000386930,
               -0.0002139962));

mod1_20 := __common__(map(
    f_assoccredbureaucount_i = NULL => -0.0001493539,
    f_assoccredbureaucount_i < 2.5  => -0.0017475525,
                      0.0423560113));

mod1_21 := __common__(map(
    f_assoccredbureaucountnew_i = NULL => 0.0000272799,
    f_assoccredbureaucountnew_i < 0.5  => 0.0000619922,
        -0.0022294476));

mod1_22 := __common__(map(
    f_assocrisktype_i = NULL => -0.0000160313,
    f_assocrisktype_i < 6.5  => -0.0000326788,
               0.0001299208));

mod1_23 := __common__(map(
    f_attr_arrest_recency_d = NULL => -0.0006091929,
    f_attr_arrest_recency_d < 99.5 => 0.0932232950,
                     -0.0031925410));

mod1_24 := __common__(map(
    f_attr_arrests_i = NULL => -0.0010774086,
    f_attr_arrests_i < 0.5  => -0.0037797683,
              0.0971676569));

mod1_25 := __common__(map(
    f_componentcharrisktype_i = NULL => 0.0000032911,
    f_componentcharrisktype_i < 5.5  => 0.0000219987,
      -0.0001325370));

mod1_26 := __common__(map(
    f_crim_rel_under100miles_cnt_i = NULL => -0.0055472328,
    f_crim_rel_under100miles_cnt_i < 7.5  => -0.0005304053,
    f_crim_rel_under100miles_cnt_i < 8.5  => 0.0009650373,
    f_crim_rel_under100miles_cnt_i < 9.5  => 0.0056202716,
    f_crim_rel_under100miles_cnt_i < 10.5 => 0.0058560644,
    f_crim_rel_under100miles_cnt_i < 11.5 => 0.0068720347,
    f_crim_rel_under100miles_cnt_i < 15.5 => 0.0071366441,
    f_crim_rel_under100miles_cnt_i < 16.5 => 0.0075046739,
           0.0079168251));

mod1_27 := __common__(map(
    f_crim_rel_under25miles_cnt_i = NULL => -0.0019809601,
    f_crim_rel_under25miles_cnt_i < 0.5  => -0.0009261219,
          0.0004085034));

mod1_28 := __common__(map(
    f_curraddrburglaryindex_i = NULL  => -0.0000488264,
    f_curraddrburglaryindex_i < 1     => 0.0358566284,
    f_curraddrburglaryindex_i < 98.5  => -0.0002650585,
    f_curraddrburglaryindex_i < 131   => -0.0001599630,
    f_curraddrburglaryindex_i < 133   => -0.0003024126,
    f_curraddrburglaryindex_i < 141.5 => -0.0004641099,
    f_curraddrburglaryindex_i < 143.5 => -0.0006782357,
    f_curraddrburglaryindex_i < 145.5 => -0.0015958668,
    f_curraddrburglaryindex_i < 147.5 => -0.0023035804,
       -0.0025058234));

mod1_29 := __common__(map(
    f_curraddrcartheftindex_i = NULL  => -0.0000493687,
    f_curraddrcartheftindex_i < 12    => 0.0006368277,
    f_curraddrcartheftindex_i < 21.5  => 0.0000403184,
    f_curraddrcartheftindex_i < 127   => -0.0001259805,
    f_curraddrcartheftindex_i < 161.5 => -0.0000107635,
    f_curraddrcartheftindex_i < 167.5 => -0.0003468535,
    f_curraddrcartheftindex_i < 193.5 => -0.0005336715,
    f_curraddrcartheftindex_i < 194.5 => -0.0002015068,
    f_curraddrcartheftindex_i < 195.5 => 0.0010292914,
    f_curraddrcartheftindex_i < 196.5 => 0.0031140794,
       0.0066134038));

mod1_30 := __common__(map(
    f_curraddrcrimeindex_i = NULL  => 0.0000439978,
    f_curraddrcrimeindex_i < 4.5   => 0.0041745037,
    f_curraddrcrimeindex_i < 10    => 0.0036702570,
    f_curraddrcrimeindex_i < 43    => 0.0000926702,
    f_curraddrcrimeindex_i < 64.5  => -0.0000212844,
    f_curraddrcrimeindex_i < 194.5 => -0.0005890724,
    f_curraddrcrimeindex_i < 195.5 => 0.0072786820,
                     0.0104053060));

mod1_31 := __common__(map(
    f_curraddrmedianincome_d = NULL     => -0.0002091571,
    f_curraddrmedianincome_d < 15531    => 0.0016721001,
    f_curraddrmedianincome_d < 25079.5  => 0.0012401803,
    f_curraddrmedianincome_d < 25091    => 0.0016444551,
    f_curraddrmedianincome_d < 25264.5  => 0.0020251508,
    f_curraddrmedianincome_d < 25722.5  => 0.0023609648,
    f_curraddrmedianincome_d < 33302.5  => 0.0026696039,
    f_curraddrmedianincome_d < 35385.5  => 0.0029119367,
    f_curraddrmedianincome_d < 45955    => 0.0030874331,
    f_curraddrmedianincome_d < 46627.5  => 0.0029673686,
    f_curraddrmedianincome_d < 47438.5  => 0.0028505075,
    f_curraddrmedianincome_d < 48255.5  => 0.0027465597,
    f_curraddrmedianincome_d < 54242.5  => 0.0026295457,
    f_curraddrmedianincome_d < 62705    => 0.0025003842,
    f_curraddrmedianincome_d < 63010.5  => 0.0023885678,
    f_curraddrmedianincome_d < 64755    => 0.0021291814,
    f_curraddrmedianincome_d < 64804.5  => 0.0020194037,
    f_curraddrmedianincome_d < 64809    => 0.0018740589,
    f_curraddrmedianincome_d < 64828.5  => 0.0017580700,
    f_curraddrmedianincome_d < 64829.5  => 0.0006763937,
    f_curraddrmedianincome_d < 65902    => 0.0002481394,
    f_curraddrmedianincome_d < 66041    => -0.0000220306,
    f_curraddrmedianincome_d < 67106    => -0.0001326154,
    f_curraddrmedianincome_d < 75266    => -0.0002820136,
    f_curraddrmedianincome_d < 78889    => -0.0003894264,
    f_curraddrmedianincome_d < 79035    => -0.0005474161,
    f_curraddrmedianincome_d < 86913    => -0.0006802609,
    f_curraddrmedianincome_d < 87297.5  => -0.0008177613,
    f_curraddrmedianincome_d < 87300    => -0.0009551581,
    f_curraddrmedianincome_d < 87528.5  => -0.0014782307,
    f_curraddrmedianincome_d < 87568.5  => -0.0016234338,
    f_curraddrmedianincome_d < 87703.5  => -0.0019043987,
    f_curraddrmedianincome_d < 87722.5  => -0.0027810916,
    f_curraddrmedianincome_d < 87957.5  => -0.0029920953,
    f_curraddrmedianincome_d < 89715    => -0.0040938639,
    f_curraddrmedianincome_d < 93712.5  => -0.0042851451,
    f_curraddrmedianincome_d < 99167    => -0.0044618478,
    f_curraddrmedianincome_d < 99316.5  => -0.0047109042,
    f_curraddrmedianincome_d < 100091   => -0.0051588711,
    f_curraddrmedianincome_d < 100106.5 => -0.0056028152,
    f_curraddrmedianincome_d < 101445.5 => -0.0060721721,
    f_curraddrmedianincome_d < 101649   => -0.0062772162,
    f_curraddrmedianincome_d < 101673   => -0.0067623471,
    f_curraddrmedianincome_d < 102811   => -0.0069818702,
    f_curraddrmedianincome_d < 103328.5 => -0.0072791534,
    f_curraddrmedianincome_d < 109807.5 => -0.0077965344,
    f_curraddrmedianincome_d < 111084   => -0.0081550132,
         -0.0084922315));

mod1_32 := __common__(map(
    f_curraddrmedianvalue_d = NULL     => -0.0000927558,
    f_curraddrmedianvalue_d < 13607.5  => -0.0003054961,
    f_curraddrmedianvalue_d < 55034    => 0.0008767355,
    f_curraddrmedianvalue_d < 72984.5  => 0.0013131520,
    f_curraddrmedianvalue_d < 85048.5  => 0.0016724768,
    f_curraddrmedianvalue_d < 243076.5 => 0.0019860523,
    f_curraddrmedianvalue_d < 246658.5 => 0.0018032399,
    f_curraddrmedianvalue_d < 307230   => 0.0016720337,
    f_curraddrmedianvalue_d < 395248.5 => 0.0015436479,
    f_curraddrmedianvalue_d < 448845.5 => 0.0014061150,
    f_curraddrmedianvalue_d < 449878   => 0.0012741530,
    f_curraddrmedianvalue_d < 450219.5 => 0.0011448895,
    f_curraddrmedianvalue_d < 450229.5 => 0.0009856926,
    f_curraddrmedianvalue_d < 479115   => 0.0008436394,
    f_curraddrmedianvalue_d < 479150.5 => 0.0006981523,
    f_curraddrmedianvalue_d < 479351   => 0.0003603915,
    f_curraddrmedianvalue_d < 486406.5 => 0.0002234322,
    f_curraddrmedianvalue_d < 488218   => -0.0001948614,
    f_curraddrmedianvalue_d < 498563   => -0.0008234427,
    f_curraddrmedianvalue_d < 499870.5 => -0.0010917134,
    f_curraddrmedianvalue_d < 500718   => -0.0012330544,
    f_curraddrmedianvalue_d < 528581.5 => -0.0013948956,
    f_curraddrmedianvalue_d < 535937.5 => -0.0015221247,
    f_curraddrmedianvalue_d < 536164.5 => -0.0016686125,
    f_curraddrmedianvalue_d < 539461.5 => -0.0018475431,
    f_curraddrmedianvalue_d < 540335.5 => -0.0020026970,
    f_curraddrmedianvalue_d < 554164   => -0.0021440255,
    f_curraddrmedianvalue_d < 561019.5 => -0.0023147957,
    f_curraddrmedianvalue_d < 563511   => -0.0024919660,
    f_curraddrmedianvalue_d < 594174   => -0.0026439581,
    f_curraddrmedianvalue_d < 595101.5 => -0.0030532894,
    f_curraddrmedianvalue_d < 596478   => -0.0032442043,
    f_curraddrmedianvalue_d < 609214.5 => -0.0036014961,
    f_curraddrmedianvalue_d < 609957   => -0.0038440478,
    f_curraddrmedianvalue_d < 610163   => -0.0041221907,
    f_curraddrmedianvalue_d < 611474.5 => -0.0043126985,
    f_curraddrmedianvalue_d < 613419   => -0.0045623803,
    f_curraddrmedianvalue_d < 613490.5 => -0.0049682669,
    f_curraddrmedianvalue_d < 620946.5 => -0.0051947063,
    f_curraddrmedianvalue_d < 622000   => -0.0054118283,
    f_curraddrmedianvalue_d < 851201   => -0.0058078533,
        -0.0054956377));

mod1_33 := __common__(map(
    f_curraddrmurderindex_i = NULL  => 0.0000240898,
    f_curraddrmurderindex_i < 37    => 0.0021569067,
    f_curraddrmurderindex_i < 38.5  => 0.0017393943,
    f_curraddrmurderindex_i < 40.5  => -0.0002112647,
    f_curraddrmurderindex_i < 131   => -0.0010746819,
    f_curraddrmurderindex_i < 172.5 => -0.0009441827,
    f_curraddrmurderindex_i < 190.5 => -0.0011910687,
    f_curraddrmurderindex_i < 195.5 => -0.0006220890,
    f_curraddrmurderindex_i < 196.5 => 0.0309416270,
                      0.0314203849));

mod1_34 := __common__(map(
    f_divaddrsuspidcountnew_i = NULL => -0.0009114310,
    f_divaddrsuspidcountnew_i < 0.5  => -0.0061889443,
    f_divaddrsuspidcountnew_i < 1.5  => -0.0060750612,
    f_divaddrsuspidcountnew_i < 2.5  => 0.0626217920,
      0.0629006364));

mod1_35 := __common__(map(
    f_divrisktype_i = NULL => -0.0000796870,
    f_divrisktype_i < 3.5  => -0.0003397009,
    f_divrisktype_i < 5.5  => 0.0037388194,
    f_divrisktype_i < 6.5  => 0.0040644180,
             0.0044747652));

mod1_36 := __common__(map(
    f_divsrchaddrsuspidcount_i = NULL => -0.0000195785,
    f_divsrchaddrsuspidcount_i < 0.5  => 0.0000352866,
       -0.0002383297));

mod1_37 := __common__(map(
    f_fp_prevaddrburglaryindex_i = NULL  => -0.0000787522,
    f_fp_prevaddrburglaryindex_i < 1     => 0.0135483020,
    f_fp_prevaddrburglaryindex_i < 9.5   => 0.0040312142,
    f_fp_prevaddrburglaryindex_i < 13.5  => -0.0000139653,
    f_fp_prevaddrburglaryindex_i < 73.5  => -0.0001926578,
    f_fp_prevaddrburglaryindex_i < 123.5 => -0.0000894893,
    f_fp_prevaddrburglaryindex_i < 140.5 => -0.0003541274,
    f_fp_prevaddrburglaryindex_i < 141.5 => -0.0005246154,
    f_fp_prevaddrburglaryindex_i < 143.5 => -0.0015840550,
    f_fp_prevaddrburglaryindex_i < 147.5 => -0.0021179359,
    f_fp_prevaddrburglaryindex_i < 170.5 => -0.0023088776,
          -0.0025920183));

mod1_38 := __common__(map(
    f_fp_prevaddrcrimeindex_i = NULL  => -0.0001512117,
    f_fp_prevaddrcrimeindex_i < 4.5   => 0.0219564905,
    f_fp_prevaddrcrimeindex_i < 7     => 0.0216969311,
    f_fp_prevaddrcrimeindex_i < 10    => 0.0157452805,
    f_fp_prevaddrcrimeindex_i < 43    => 0.0011756577,
    f_fp_prevaddrcrimeindex_i < 56    => 0.0010603836,
    f_fp_prevaddrcrimeindex_i < 57.5  => 0.0009452504,
    f_fp_prevaddrcrimeindex_i < 63    => 0.0008226487,
    f_fp_prevaddrcrimeindex_i < 64.5  => 0.0002486301,
    f_fp_prevaddrcrimeindex_i < 66    => -0.0018075386,
    f_fp_prevaddrcrimeindex_i < 70    => -0.0031668156,
    f_fp_prevaddrcrimeindex_i < 73    => -0.0032651149,
    f_fp_prevaddrcrimeindex_i < 76    => -0.0033716356,
    f_fp_prevaddrcrimeindex_i < 77.5  => -0.0036243044,
    f_fp_prevaddrcrimeindex_i < 80.5  => -0.0039725322,
    f_fp_prevaddrcrimeindex_i < 85    => -0.0040720873,
    f_fp_prevaddrcrimeindex_i < 136   => -0.0041776670,
    f_fp_prevaddrcrimeindex_i < 194.5 => -0.0040431564,
    f_fp_prevaddrcrimeindex_i < 195.5 => 0.0074887212,
       0.0255254508));

mod1_39 := __common__(map(
    f_hh_age_30_plus_d = NULL => -0.0000097440,
    f_hh_age_30_plus_d < 5.5  => -0.0000820878,
                0.0011003531));

mod1_40 := __common__(map(
    f_hh_bankruptcies_i = NULL => -0.0000044272,
    f_hh_bankruptcies_i < 0.5  => -0.0010534307,
                 0.0011862523));

mod1_41 := __common__(map(
    f_hh_collections_ct_i = NULL => -0.0002333190,
    f_hh_collections_ct_i < 0.5  => -0.0153483081,
    f_hh_collections_ct_i < 2.5  => 0.0012818689,
    f_hh_collections_ct_i < 5.5  => 0.0014066427,
                   0.0016839158));

mod1_42 := __common__(map(
    f_hh_college_attendees_d = NULL => -0.0000099233,
    f_hh_college_attendees_d < 0.5  => 0.0000102267,
                      -0.0001821259));

mod1_43 := __common__(map(
    f_hh_lienholders_i = NULL => 0.0000041232,
    f_hh_lienholders_i < 0.5  => -0.0000682002,
                0.0000509404));

mod1_44 := __common__(map(
    f_hh_members_w_derog_i = NULL => -0.0002315545,
    f_hh_members_w_derog_i < 0.5  => -0.0092731784,
    f_hh_members_w_derog_i < 6.5  => 0.0006670762,
                    0.0793581350));

mod1_45 := __common__(map(
    f_hh_payday_loan_users_i = NULL => -0.0000036419,
    f_hh_payday_loan_users_i < 1.5  => -0.0000089743,
                      0.0002411424));

mod1_46 := __common__(map(
    f_hh_prof_license_holders_d = NULL => -0.0008059635,
    f_hh_prof_license_holders_d < 0.5  => 0.0076572283,
        -0.0295627687));

mod1_47 := __common__(map(
    f_hh_tot_derog_i = NULL => 0.0000381525,
    f_hh_tot_derog_i < 1.5  => -0.0000474953,
    f_hh_tot_derog_i < 10.5 => 0.0000694814,
              0.0016847987));

mod1_48 := __common__(map(
    f_historical_count_d = NULL => -0.0000324398,
    f_historical_count_d < 7.5  => -0.0000325302,
    f_historical_count_d < 15.5 => 0.0001930558,
                  -0.0007990611));

mod1_49 := __common__(map(
    f_idverrisktype_i = NULL => -0.0004207961,
    f_idverrisktype_i < 1.5  => -0.0100218504,
    f_idverrisktype_i < 3.5  => 0.0179888965,
               0.0184412728));

mod1_50 := __common__(map(
    f_inq_banking_count24_i = NULL => -0.0000126896,
    f_inq_banking_count24_i < 3.5  => -0.0000187677,
                     0.0002405157));

mod1_51 := __common__(map(
    f_inq_collection_count24_i = NULL => -0.0008848041,
    f_inq_collection_count24_i < 0.5  => -0.0086579257,
    f_inq_collection_count24_i < 2.5  => 0.0154946889,
       0.0182180374));

mod1_52 := __common__(map(
    f_inq_communications_count24_i = NULL => -0.0000160201,
    f_inq_communications_count24_i < 0.5  => -0.0000298211,
           0.0002302909));

mod1_53 := __common__(map(
    f_inq_count24_i = NULL => -0.0003171911,
    f_inq_count24_i < 0.5  => -0.0075423279,
    f_inq_count24_i < 6.5  => 0.0007133254,
    f_inq_count24_i < 14.5 => 0.0014189072,
    f_inq_count24_i < 15.5 => 0.0032276289,
    f_inq_count24_i < 16.5 => 0.0216268514,
             0.0391888585));

mod1_54 := __common__(map(
    f_inq_email_ver_count_i = NULL => 0.0000076721,
    f_inq_email_ver_count_i < 1.5  => -0.0001636648,
                     0.0000312567));

mod1_55 := __common__(map(
    f_inq_highriskcredit_cnt_day_i = NULL => 0.0000034845,
    f_inq_highriskcredit_cnt_day_i < 0.5  => -0.0000017225,
           0.0002809257));

mod1_56 := __common__(map(
    f_inq_highriskcredit_cnt_week_i = NULL => -0.0002100991,
    f_inq_highriskcredit_cnt_week_i < 0.5  => -0.0009703839,
    f_inq_highriskcredit_cnt_week_i < 1.5  => -0.0007648790,
    f_inq_highriskcredit_cnt_week_i < 2.5  => 0.0375068586,
            0.0378558642));

mod1_57 := __common__(map(
    f_inq_highriskcredit_count24_i = NULL => -0.0065483763,
    f_inq_highriskcredit_count24_i < 1.5  => -0.0344638340,
    f_inq_highriskcredit_count24_i < 2.5  => 0.0222908166,
    f_inq_highriskcredit_count24_i < 3.5  => 0.0261617637,
    f_inq_highriskcredit_count24_i < 4.5  => 0.0655596180,
    f_inq_highriskcredit_count24_i < 17.5 => 0.0657257851,
           0.0819834584));

mod1_58 := __common__(map(
    f_inq_other_count24_i = NULL => -0.0001581121,
    f_inq_other_count24_i < 0.5  => -0.0009457868,
    f_inq_other_count24_i < 14.5 => 0.0001183280,
    f_inq_other_count24_i < 16.5 => 0.0308613913,
                   0.0312768963));

mod1_59 := __common__(map(
    f_inq_retail_count24_i = NULL => -0.0000005946,
    f_inq_retail_count24_i < 0.5  => 0.0000401757,
    f_inq_retail_count24_i < 1.5  => -0.0001870287,
                    -0.0010726506));

mod1_60 := __common__(map(
    f_liens_rel_cj_total_amt_i = NULL   => -0.0000020169,
    f_liens_rel_cj_total_amt_i < 462.5  => 0.0003975915,
    f_liens_rel_cj_total_amt_i < 463.5  => 0.0000579669,
    f_liens_rel_cj_total_amt_i < 483.5  => -0.0002842505,
    f_liens_rel_cj_total_amt_i < 484    => -0.0005530008,
    f_liens_rel_cj_total_amt_i < 519    => -0.0008566919,
    f_liens_rel_cj_total_amt_i < 522.5  => -0.0011697872,
    f_liens_rel_cj_total_amt_i < 523.5  => -0.0017259525,
    f_liens_rel_cj_total_amt_i < 524    => -0.0020699808,
    f_liens_rel_cj_total_amt_i < 937    => -0.0023653509,
    f_liens_rel_cj_total_amt_i < 942    => -0.0027797836,
    f_liens_rel_cj_total_amt_i < 946    => -0.0031308554,
    f_liens_rel_cj_total_amt_i < 980.5  => -0.0038581791,
    f_liens_rel_cj_total_amt_i < 983.5  => -0.0052619552,
    f_liens_rel_cj_total_amt_i < 988.5  => -0.0055801277,
    f_liens_rel_cj_total_amt_i < 1048.5 => -0.0062488082,
    f_liens_rel_cj_total_amt_i < 1652.5 => -0.0065915330,
    f_liens_rel_cj_total_amt_i < 1683   => -0.0070041941,
    f_liens_rel_cj_total_amt_i < 1685.5 => -0.0094937373,
         -0.0099060178));

mod1_61 := __common__(map(
    f_liens_rel_ot_total_amt_i = NULL   => -0.0005439996,
    f_liens_rel_ot_total_amt_i < 1771   => 0.0015988977,
    f_liens_rel_ot_total_amt_i < 1801   => 0.0012994607,
    f_liens_rel_ot_total_amt_i < 1802   => 0.0009439914,
    f_liens_rel_ot_total_amt_i < 1822   => 0.0005957877,
    f_liens_rel_ot_total_amt_i < 1824   => -0.0005554751,
    f_liens_rel_ot_total_amt_i < 1847.5 => -0.0012142741,
    f_liens_rel_ot_total_amt_i < 1849.5 => -0.0015117067,
    f_liens_rel_ot_total_amt_i < 1850.5 => -0.0018297874,
    f_liens_rel_ot_total_amt_i < 2041   => -0.0024877733,
    f_liens_rel_ot_total_amt_i < 2084.5 => -0.0042845414,
    f_liens_rel_ot_total_amt_i < 2149   => -0.0050749368,
    f_liens_rel_ot_total_amt_i < 2154.5 => -0.0071745823,
    f_liens_rel_ot_total_amt_i < 2419   => -0.0075343600,
    f_liens_rel_ot_total_amt_i < 2683.5 => -0.0079146145,
    f_liens_rel_ot_total_amt_i < 2986.5 => -0.0082653196,
    f_liens_rel_ot_total_amt_i < 3246   => -0.0090715717,
    f_liens_rel_ot_total_amt_i < 3415   => -0.0095615354,
    f_liens_rel_ot_total_amt_i < 3704.5 => -0.0099241532,
    f_liens_rel_ot_total_amt_i < 3976   => -0.0117582419,
    f_liens_rel_ot_total_amt_i < 4311.5 => -0.0136220913,
    f_liens_rel_ot_total_amt_i < 4374   => -0.0141366925,
    f_liens_rel_ot_total_amt_i < 4434.5 => -0.0159716709,
    f_liens_rel_ot_total_amt_i < 4444.5 => -0.0209393310,
    f_liens_rel_ot_total_amt_i < 4538.5 => -0.0228983449,
    f_liens_rel_ot_total_amt_i < 4564   => -0.0303796329,
    f_liens_rel_ot_total_amt_i < 4567   => -0.0331008549,
    f_liens_rel_ot_total_amt_i < 5878.5 => -0.0340719961,
    f_liens_rel_ot_total_amt_i < 5880.5 => -0.0346973570,
    f_liens_rel_ot_total_amt_i < 5888.5 => -0.0381396555,
    f_liens_rel_ot_total_amt_i < 5917   => -0.0394949734,
    f_liens_rel_ot_total_amt_i < 5922.5 => -0.0538097969,
    f_liens_rel_ot_total_amt_i < 5927   => -0.0590110259,
    f_liens_rel_ot_total_amt_i < 9659.5 => -0.0602374387,
    f_liens_rel_ot_total_amt_i < 9685.5 => -0.0645106459,
    f_liens_rel_ot_total_amt_i < 9725.5 => -0.0727428992,
    f_liens_rel_ot_total_amt_i < 10608  => -0.0736164039,
         -0.0798495493));

mod1_62 := __common__(map(
    f_liens_rel_sc_total_amt_i = NULL   => -0.0000027391,
    f_liens_rel_sc_total_amt_i < 2014.5 => 0.0000032605,
         -0.0007033288));

mod1_63 := __common__(map(
    f_liens_unrel_cj_total_amt_i = NULL    => -0.0001825860,
    f_liens_unrel_cj_total_amt_i < 716.5   => -0.0007021870,
    f_liens_unrel_cj_total_amt_i < 717.5   => -0.0002682007,
    f_liens_unrel_cj_total_amt_i < 4070.5  => 0.0001423923,
    f_liens_unrel_cj_total_amt_i < 4071    => 0.0002903559,
    f_liens_unrel_cj_total_amt_i < 4519.5  => 0.0004663237,
    f_liens_unrel_cj_total_amt_i < 4803    => 0.0010875532,
    f_liens_unrel_cj_total_amt_i < 4803.5  => 0.0014049422,
    f_liens_unrel_cj_total_amt_i < 4872.5  => 0.0022552327,
    f_liens_unrel_cj_total_amt_i < 4884.5  => 0.0024281807,
    f_liens_unrel_cj_total_amt_i < 6606.5  => 0.0028074401,
    f_liens_unrel_cj_total_amt_i < 6608    => 0.0030168512,
    f_liens_unrel_cj_total_amt_i < 7040    => 0.0031857531,
    f_liens_unrel_cj_total_amt_i < 7040.5  => 0.0033652225,
    f_liens_unrel_cj_total_amt_i < 8516    => 0.0035881859,
    f_liens_unrel_cj_total_amt_i < 12133   => 0.0038003702,
    f_liens_unrel_cj_total_amt_i < 12137.5 => 0.0040194778,
            0.0057823920));

mod1_64 := __common__(map(
    f_liens_unrel_ft_total_amt_i = NULL    => -0.0000287995,
    f_liens_unrel_ft_total_amt_i < 13535.5 => 0.0000395605,
    f_liens_unrel_ft_total_amt_i < 19377   => -0.0002662407,
    f_liens_unrel_ft_total_amt_i < 20707.5 => -0.0006305379,
    f_liens_unrel_ft_total_amt_i < 104642  => -0.0010094853,
            -0.0030173581));

mod1_65 := __common__(map(
    f_liens_unrel_ot_total_amt_i = NULL   => -0.0000479723,
    f_liens_unrel_ot_total_amt_i < 1822   => 0.0001129232,
    f_liens_unrel_ot_total_amt_i < 2085.5 => -0.0001558705,
    f_liens_unrel_ot_total_amt_i < 2419   => -0.0004014244,
    f_liens_unrel_ot_total_amt_i < 2571.5 => -0.0008938687,
    f_liens_unrel_ot_total_amt_i < 3152.5 => -0.0011650870,
    f_liens_unrel_ot_total_amt_i < 3222.5 => -0.0014661393,
    f_liens_unrel_ot_total_amt_i < 6237.5 => -0.0017686834,
           -0.0021723965));

mod1_66 := __common__(map(
    f_liens_unrel_sc_total_amt_i = NULL   => -0.0001113848,
    f_liens_unrel_sc_total_amt_i < 502    => -0.0010274157,
    f_liens_unrel_sc_total_amt_i < 696.5  => -0.0008480268,
    f_liens_unrel_sc_total_amt_i < 717    => -0.0006699186,
    f_liens_unrel_sc_total_amt_i < 725.5  => -0.0001454600,
    f_liens_unrel_sc_total_amt_i < 775    => 0.0000252443,
    f_liens_unrel_sc_total_amt_i < 786.5  => 0.0002087441,
    f_liens_unrel_sc_total_amt_i < 858.5  => 0.0003818871,
    f_liens_unrel_sc_total_amt_i < 860.5  => 0.0005598796,
    f_liens_unrel_sc_total_amt_i < 2114.5 => 0.0007599239,
    f_liens_unrel_sc_total_amt_i < 2129.5 => 0.0009560063,
    f_liens_unrel_sc_total_amt_i < 2305   => 0.0011916695,
    f_liens_unrel_sc_total_amt_i < 2336   => 0.0014296685,
    f_liens_unrel_sc_total_amt_i < 2337.5 => 0.0018628532,
    f_liens_unrel_sc_total_amt_i < 2496.5 => 0.0032508928,
    f_liens_unrel_sc_total_amt_i < 2497   => 0.0034826962,
    f_liens_unrel_sc_total_amt_i < 2498.5 => 0.0055517403,
    f_liens_unrel_sc_total_amt_i < 2499.5 => 0.0145305273,
           0.0181242432));

mod1_67 := __common__(map(
    f_liens_unrel_st_ct_i = NULL => -0.0000148603,
    f_liens_unrel_st_ct_i < 1.5  => -0.0000201811,
                   0.0003245699));

mod1_68 := __common__(map(
    f_m_bureau_adl_fs_all_d = NULL  => -0.0000585011,
    f_m_bureau_adl_fs_all_d < 63.5  => -0.0024773461,
    f_m_bureau_adl_fs_all_d < 64.5  => -0.0019415403,
    f_m_bureau_adl_fs_all_d < 69.5  => -0.0005650964,
    f_m_bureau_adl_fs_all_d < 70.5  => -0.0001137780,
    f_m_bureau_adl_fs_all_d < 218.5 => 0.0003384617,
    f_m_bureau_adl_fs_all_d < 397.5 => -0.0000391736,
                      -0.0008165919));

mod1_69 := __common__(map(
    f_m_bureau_adl_fs_notu_d = NULL  => -0.0000361987,
    f_m_bureau_adl_fs_notu_d < 64.5  => -0.0047530931,
    f_m_bureau_adl_fs_notu_d < 65.5  => -0.0018116671,
    f_m_bureau_adl_fs_notu_d < 70.5  => -0.0014096755,
    f_m_bureau_adl_fs_notu_d < 218.5 => 0.0003180278,
    f_m_bureau_adl_fs_notu_d < 293.5 => 0.0000945278,
    f_m_bureau_adl_fs_notu_d < 391.5 => -0.0000960180,
      0.0001339234));

mod1_70 := __common__(map(
    f_mos_acc_lseen_d = NULL => 0.0000067099,
    f_mos_acc_lseen_d < 6.5  => 0.0030686715,
    f_mos_acc_lseen_d < 8.5  => 0.0025465287,
    f_mos_acc_lseen_d < 27.5 => 0.0018642968,
    f_mos_acc_lseen_d < 28.5 => 0.0008241507,
    f_mos_acc_lseen_d < 31.5 => 0.0005104787,
    f_mos_acc_lseen_d < 33.5 => 0.0003638912,
    f_mos_acc_lseen_d < 60.5 => -0.0001015389,
               -0.0002189067));

mod1_71 := __common__(map(
    f_mos_foreclosure_lseen_d = NULL => -0.0000176505,
    f_mos_foreclosure_lseen_d < 57.5 => 0.0072679760,
    f_mos_foreclosure_lseen_d < 59.5 => 0.0063582956,
    f_mos_foreclosure_lseen_d < 69.5 => 0.0059210750,
    f_mos_foreclosure_lseen_d < 70.5 => 0.0056915656,
    f_mos_foreclosure_lseen_d < 71.5 => 0.0050038777,
    f_mos_foreclosure_lseen_d < 74.5 => 0.0020355590,
    f_mos_foreclosure_lseen_d < 75.5 => 0.0009651984,
    f_mos_foreclosure_lseen_d < 77.5 => 0.0007523872,
    f_mos_foreclosure_lseen_d < 78.5 => 0.0005551417,
    f_mos_foreclosure_lseen_d < 79.5 => 0.0001417709,
    f_mos_foreclosure_lseen_d < 80.5 => -0.0002331997,
      -0.0004080902));

mod1_72 := __common__(map(
    f_mos_liens_rel_cj_fseen_d = NULL  => -0.0000673682,
    f_mos_liens_rel_cj_fseen_d < 71.5  => -0.0151438562,
    f_mos_liens_rel_cj_fseen_d < 84.5  => -0.0142743795,
    f_mos_liens_rel_cj_fseen_d < 86.5  => -0.0136678958,
    f_mos_liens_rel_cj_fseen_d < 117.5 => -0.0131670782,
    f_mos_liens_rel_cj_fseen_d < 189.5 => -0.0127407234,
    f_mos_liens_rel_cj_fseen_d < 200.5 => -0.0121369958,
    f_mos_liens_rel_cj_fseen_d < 242   => -0.0117898078,
    f_mos_liens_rel_cj_fseen_d < 242.5 => -0.0112175361,
    f_mos_liens_rel_cj_fseen_d < 247.5 => -0.0061621659,
    f_mos_liens_rel_cj_fseen_d < 272.5 => -0.0036918109,
    f_mos_liens_rel_cj_fseen_d < 275.5 => -0.0007131736,
    f_mos_liens_rel_cj_fseen_d < 288.5 => -0.0004748530,
    f_mos_liens_rel_cj_fseen_d < 289.5 => -0.0001915366,
        0.0006395420));

mod1_73 := __common__(map(
    f_mos_liens_rel_cj_lseen_d = NULL  => -0.0000002320,
    f_mos_liens_rel_cj_lseen_d < 45.5  => -0.0103526474,
    f_mos_liens_rel_cj_lseen_d < 50.5  => -0.0085297879,
    f_mos_liens_rel_cj_lseen_d < 69.5  => -0.0076726064,
    f_mos_liens_rel_cj_lseen_d < 71.5  => -0.0065393475,
    f_mos_liens_rel_cj_lseen_d < 74.5  => -0.0060377272,
    f_mos_liens_rel_cj_lseen_d < 78.5  => -0.0030484148,
    f_mos_liens_rel_cj_lseen_d < 84.5  => -0.0026147572,
    f_mos_liens_rel_cj_lseen_d < 87.5  => -0.0012692821,
    f_mos_liens_rel_cj_lseen_d < 96.5  => -0.0007626023,
    f_mos_liens_rel_cj_lseen_d < 100.5 => -0.0002848480,
        0.0001766404));

mod1_74 := __common__(map(
    f_mos_liens_rel_ft_fseen_d = NULL  => -0.0000661563,
    f_mos_liens_rel_ft_fseen_d < 114.5 => -0.0025764562,
    f_mos_liens_rel_ft_fseen_d < 211   => -0.0019992514,
    f_mos_liens_rel_ft_fseen_d < 211.5 => -0.0015988562,
    f_mos_liens_rel_ft_fseen_d < 245.5 => -0.0011601557,
        0.0000154543));

mod1_75 := __common__(map(
    f_mos_liens_rel_ft_lseen_d = NULL  => -0.0000459546,
    f_mos_liens_rel_ft_lseen_d < 114.5 => -0.0029891777,
    f_mos_liens_rel_ft_lseen_d < 179   => -0.0023374089,
    f_mos_liens_rel_ft_lseen_d < 193.5 => -0.0007311645,
    f_mos_liens_rel_ft_lseen_d < 269   => -0.0003281555,
        0.0000545809));

mod1_76 := __common__(map(
    f_mos_liens_rel_ot_fseen_d = NULL  => -0.0002306744,
    f_mos_liens_rel_ot_fseen_d < 46.5  => 0.0009545123,
    f_mos_liens_rel_ot_fseen_d < 53.5  => 0.0002568981,
    f_mos_liens_rel_ot_fseen_d < 54.5  => -0.0006878309,
    f_mos_liens_rel_ot_fseen_d < 60.5  => -0.0009270734,
    f_mos_liens_rel_ot_fseen_d < 61.5  => -0.0011747000,
    f_mos_liens_rel_ot_fseen_d < 76.5  => -0.0017372835,
    f_mos_liens_rel_ot_fseen_d < 77.5  => -0.0019890945,
    f_mos_liens_rel_ot_fseen_d < 88.5  => -0.0049314168,
    f_mos_liens_rel_ot_fseen_d < 89.5  => -0.0070018578,
    f_mos_liens_rel_ot_fseen_d < 96.5  => -0.0107533684,
    f_mos_liens_rel_ot_fseen_d < 107.5 => -0.0121088608,
    f_mos_liens_rel_ot_fseen_d < 205.5 => -0.0129868697,
    f_mos_liens_rel_ot_fseen_d < 229.5 => -0.0133499823,
    f_mos_liens_rel_ot_fseen_d < 253.5 => -0.0137674050,
        -0.0145278593));

mod1_77 := __common__(map(
    f_mos_liens_rel_ot_lseen_d = NULL => 0.0000094494,
    f_mos_liens_rel_ot_lseen_d < 36.5 => -0.0018484389,
       0.0000270733));

mod1_78 := __common__(map(
    f_mos_liens_rel_sc_fseen_d = NULL  => -0.0000120241,
    f_mos_liens_rel_sc_fseen_d < 61.5  => -0.0016270127,
    f_mos_liens_rel_sc_fseen_d < 146.5 => -0.0006221849,
        0.0000040013));

mod1_79 := __common__(map(
    f_mos_liens_rel_sc_lseen_d = NULL => 0.0000118446,
    f_mos_liens_rel_sc_lseen_d < 69.5 => -0.0019357702,
       0.0000290406));

mod1_80 := __common__(map(
    f_mos_liens_unrel_cj_fseen_d = NULL  => -0.0002277286,
    f_mos_liens_unrel_cj_fseen_d < 16.5  => 0.0110308295,
    f_mos_liens_unrel_cj_fseen_d < 17.5  => 0.0105912925,
    f_mos_liens_unrel_cj_fseen_d < 21.5  => 0.0101649007,
    f_mos_liens_unrel_cj_fseen_d < 57.5  => 0.0096874041,
    f_mos_liens_unrel_cj_fseen_d < 98.5  => 0.0087694334,
    f_mos_liens_unrel_cj_fseen_d < 142.5 => 0.0084506462,
    f_mos_liens_unrel_cj_fseen_d < 146.5 => 0.0080903687,
    f_mos_liens_unrel_cj_fseen_d < 148.5 => 0.0072156780,
    f_mos_liens_unrel_cj_fseen_d < 151.5 => 0.0068693794,
    f_mos_liens_unrel_cj_fseen_d < 152.5 => 0.0067103813,
    f_mos_liens_unrel_cj_fseen_d < 155.5 => 0.0065502497,
    f_mos_liens_unrel_cj_fseen_d < 157.5 => 0.0064006280,
    f_mos_liens_unrel_cj_fseen_d < 158.5 => 0.0040530934,
    f_mos_liens_unrel_cj_fseen_d < 159.5 => 0.0022214352,
    f_mos_liens_unrel_cj_fseen_d < 183.5 => -0.0014854941,
          -0.0016223615));

mod1_81 := __common__(map(
    f_mos_liens_unrel_cj_lseen_d = NULL  => -0.0006247312,
    f_mos_liens_unrel_cj_lseen_d < 11.5  => 0.1070752217,
    f_mos_liens_unrel_cj_lseen_d < 12.5  => 0.1066054558,
    f_mos_liens_unrel_cj_lseen_d < 13.5  => 0.0269811686,
    f_mos_liens_unrel_cj_lseen_d < 14.5  => 0.0234655501,
    f_mos_liens_unrel_cj_lseen_d < 56.5  => 0.0211627416,
    f_mos_liens_unrel_cj_lseen_d < 139.5 => 0.0209406740,
    f_mos_liens_unrel_cj_lseen_d < 141.5 => 0.0206649604,
    f_mos_liens_unrel_cj_lseen_d < 142.5 => 0.0202004093,
    f_mos_liens_unrel_cj_lseen_d < 143.5 => 0.0183641205,
    f_mos_liens_unrel_cj_lseen_d < 149.5 => 0.0144456366,
    f_mos_liens_unrel_cj_lseen_d < 151.5 => 0.0118862060,
    f_mos_liens_unrel_cj_lseen_d < 152   => 0.0011192390,
    f_mos_liens_unrel_cj_lseen_d < 158.5 => 0.0009650291,
    f_mos_liens_unrel_cj_lseen_d < 159.5 => 0.0006294786,
    f_mos_liens_unrel_cj_lseen_d < 165.5 => -0.0005868259,
    f_mos_liens_unrel_cj_lseen_d < 181.5 => -0.0010561328,
    f_mos_liens_unrel_cj_lseen_d < 183.5 => -0.0011907096,
    f_mos_liens_unrel_cj_lseen_d < 184.5 => -0.0013690212,
    f_mos_liens_unrel_cj_lseen_d < 186.5 => -0.0017716934,
    f_mos_liens_unrel_cj_lseen_d < 212.5 => -0.0024954636,
    f_mos_liens_unrel_cj_lseen_d < 228.5 => -0.0045165163,
    f_mos_liens_unrel_cj_lseen_d < 230.5 => -0.0048523191,
    f_mos_liens_unrel_cj_lseen_d < 237.5 => -0.0051568161,
          -0.0052915767));

mod1_82 := __common__(map(
    f_mos_liens_unrel_ft_fseen_d = NULL  => -0.0000209918,
    f_mos_liens_unrel_ft_fseen_d < 19.5  => 0.0150071661,
    f_mos_liens_unrel_ft_fseen_d < 22.5  => 0.0145532617,
    f_mos_liens_unrel_ft_fseen_d < 30.5  => 0.0123577032,
    f_mos_liens_unrel_ft_fseen_d < 31    => 0.0115867817,
    f_mos_liens_unrel_ft_fseen_d < 31.5  => 0.0111783855,
    f_mos_liens_unrel_ft_fseen_d < 33.5  => 0.0096517184,
    f_mos_liens_unrel_ft_fseen_d < 37.5  => 0.0025455046,
    f_mos_liens_unrel_ft_fseen_d < 42.5  => -0.0000199401,
    f_mos_liens_unrel_ft_fseen_d < 61.5  => -0.0003243411,
    f_mos_liens_unrel_ft_fseen_d < 245   => -0.0008593865,
    f_mos_liens_unrel_ft_fseen_d < 245.5 => -0.0005984249,
    f_mos_liens_unrel_ft_fseen_d < 248.5 => -0.0003606570,
          -0.0001290418));

mod1_83 := __common__(map(
    f_mos_liens_unrel_ft_lseen_d = NULL => -0.0002976120,
    f_mos_liens_unrel_ft_lseen_d < 7.5  => 0.1923232201,
    f_mos_liens_unrel_ft_lseen_d < 8.5  => 0.0573421912,
    f_mos_liens_unrel_ft_lseen_d < 10.5 => 0.0231255567,
    f_mos_liens_unrel_ft_lseen_d < 12.5 => 0.0108401282,
         -0.0013979527));

mod1_84 := __common__(map(
    f_mos_liens_unrel_ot_fseen_d = NULL  => 0.0000173121,
    f_mos_liens_unrel_ot_fseen_d < 102.5 => 0.0001856542,
          0.0000049540));

mod1_85 := __common__(map(
    f_mos_liens_unrel_ot_lseen_d = NULL => -0.0000021169,
    f_mos_liens_unrel_ot_lseen_d < 36.5 => -0.0003408701,
         0.0000114101));

mod1_86 := __common__(map(
    f_mos_liens_unrel_sc_fseen_d = NULL  => -0.0000469627,
    f_mos_liens_unrel_sc_fseen_d < 50.5  => 0.0058301042,
    f_mos_liens_unrel_sc_fseen_d < 59.5  => 0.0055133443,
    f_mos_liens_unrel_sc_fseen_d < 63.5  => 0.0051274997,
    f_mos_liens_unrel_sc_fseen_d < 72.5  => 0.0044714672,
    f_mos_liens_unrel_sc_fseen_d < 73.5  => 0.0041978109,
    f_mos_liens_unrel_sc_fseen_d < 79.5  => 0.0039331665,
    f_mos_liens_unrel_sc_fseen_d < 80.5  => 0.0036851922,
    f_mos_liens_unrel_sc_fseen_d < 115.5 => 0.0015655117,
    f_mos_liens_unrel_sc_fseen_d < 138.5 => 0.0011128159,
    f_mos_liens_unrel_sc_fseen_d < 221.5 => 0.0006757888,
          -0.0002631151));

mod1_87 := __common__(map(
    f_mos_liens_unrel_st_lseen_d = NULL => -0.0012514119,
    f_mos_liens_unrel_st_lseen_d < 22   => 0.1736296650,
    f_mos_liens_unrel_st_lseen_d < 22.5 => 0.1731750215,
    f_mos_liens_unrel_st_lseen_d < 23.5 => 0.1644517818,
    f_mos_liens_unrel_st_lseen_d < 24.5 => 0.1620096685,
    f_mos_liens_unrel_st_lseen_d < 33.5 => 0.1615148868,
    f_mos_liens_unrel_st_lseen_d < 36.5 => 0.1610284321,
    f_mos_liens_unrel_st_lseen_d < 37   => 0.1118429820,
    f_mos_liens_unrel_st_lseen_d < 37.5 => 0.1109993075,
    f_mos_liens_unrel_st_lseen_d < 39.5 => 0.0789342771,
    f_mos_liens_unrel_st_lseen_d < 41.5 => 0.0746765078,
    f_mos_liens_unrel_st_lseen_d < 42.5 => 0.0479686927,
    f_mos_liens_unrel_st_lseen_d < 43.5 => 0.0402531197,
    f_mos_liens_unrel_st_lseen_d < 49.5 => 0.0360515902,
    f_mos_liens_unrel_st_lseen_d < 50.5 => 0.0352735579,
    f_mos_liens_unrel_st_lseen_d < 51   => 0.0097180917,
    f_mos_liens_unrel_st_lseen_d < 51.5 => -0.0016390650,
         -0.0031204425));

mod1_88 := __common__(map(
    f_phone_ver_experian_d = NULL => 0.0893894197,
    f_phone_ver_experian_d < 0.5  => 0.0839632478,
                    -0.0401138015));

mod1_89 := __common__(map(
    f_phones_per_addr_c6_i = NULL => -0.0000568713,
    f_phones_per_addr_c6_i < 1.5  => -0.0005066167,
                    0.0024097735));

mod1_90 := __common__(map(
    f_phones_per_addr_curr_i = NULL => -0.0002305876,
    f_phones_per_addr_curr_i < 6.5  => -0.0013676990,
    f_phones_per_addr_curr_i < 15.5 => -0.0009048082,
    f_phones_per_addr_curr_i < 17.5 => 0.0004504823,
    f_phones_per_addr_curr_i < 18.5 => 0.0342981504,
    f_phones_per_addr_curr_i < 20.5 => 0.0414957142,
    f_phones_per_addr_curr_i < 26.5 => 0.0491611683,
                      0.0494836263));

mod1_91 := __common__(map(
    f_prevaddrageoldest_d = NULL  => 0.0002598772,
    f_prevaddrageoldest_d < 13.5  => -0.0085955631,
    f_prevaddrageoldest_d < 14.5  => -0.0029935372,
    f_prevaddrageoldest_d < 20.5  => 0.0019853574,
    f_prevaddrageoldest_d < 91.5  => 0.0023530491,
    f_prevaddrageoldest_d < 146.5 => 0.0022349680,
    f_prevaddrageoldest_d < 150.5 => 0.0020749093,
    f_prevaddrageoldest_d < 155.5 => 0.0017272524,
    f_prevaddrageoldest_d < 158.5 => 0.0015258069,
                    0.0011900334));

mod1_92 := __common__(map(
    f_prevaddrcartheftindex_i = NULL  => -0.0000257518,
    f_prevaddrcartheftindex_i < 34    => 0.0001045565,
    f_prevaddrcartheftindex_i < 60.5  => -0.0000480252,
    f_prevaddrcartheftindex_i < 133.5 => -0.0001602742,
    f_prevaddrcartheftindex_i < 136.5 => -0.0000554308,
    f_prevaddrcartheftindex_i < 195.5 => 0.0000536221,
    f_prevaddrcartheftindex_i < 196.5 => 0.0008669169,
       0.0036450631));

mod1_93 := __common__(map(
    f_prevaddrlenofres_d = NULL  => -0.0000815162,
    f_prevaddrlenofres_d < 87.5  => 0.0003262173,
    f_prevaddrlenofres_d < 90.5  => 0.0001880853,
    f_prevaddrlenofres_d < 149.5 => 0.0000662558,
    f_prevaddrlenofres_d < 150.5 => -0.0002604636,
    f_prevaddrlenofres_d < 154.5 => -0.0009429155,
    f_prevaddrlenofres_d < 157.5 => -0.0012472642,
                   -0.0014144708));

mod1_94 := __common__(map(
    f_prevaddrmedianincome_d = NULL     => -0.0010400499,
    f_prevaddrmedianincome_d < 27073    => 0.0039191014,
    f_prevaddrmedianincome_d < 28239    => 0.0046139147,
    f_prevaddrmedianincome_d < 39919.5  => 0.0050389482,
    f_prevaddrmedianincome_d < 42415.5  => 0.0051913359,
    f_prevaddrmedianincome_d < 62437    => 0.0053441093,
    f_prevaddrmedianincome_d < 64598.5  => 0.0052449231,
    f_prevaddrmedianincome_d < 64755    => 0.0051238302,
    f_prevaddrmedianincome_d < 64767.5  => 0.0048264806,
    f_prevaddrmedianincome_d < 64828.5  => 0.0047025125,
    f_prevaddrmedianincome_d < 70844    => 0.0045815557,
    f_prevaddrmedianincome_d < 74905.5  => 0.0044589165,
    f_prevaddrmedianincome_d < 75267.5  => 0.0043380395,
    f_prevaddrmedianincome_d < 75684    => 0.0042175493,
    f_prevaddrmedianincome_d < 75836.5  => 0.0040644970,
    f_prevaddrmedianincome_d < 76119    => 0.0038167763,
    f_prevaddrmedianincome_d < 78905.5  => 0.0036801335,
    f_prevaddrmedianincome_d < 87568.5  => 0.0035359501,
    f_prevaddrmedianincome_d < 89617    => 0.0033695618,
    f_prevaddrmedianincome_d < 89692.5  => 0.0031842579,
    f_prevaddrmedianincome_d < 89715    => 0.0030095968,
    f_prevaddrmedianincome_d < 89719    => 0.0027057525,
    f_prevaddrmedianincome_d < 99323.5  => 0.0025642888,
    f_prevaddrmedianincome_d < 99326.5  => 0.0023415430,
    f_prevaddrmedianincome_d < 99776.5  => -0.0003314286,
    f_prevaddrmedianincome_d < 99889.5  => -0.0005387105,
    f_prevaddrmedianincome_d < 99890.5  => -0.0028221992,
    f_prevaddrmedianincome_d < 100091   => -0.0037854209,
    f_prevaddrmedianincome_d < 100097   => -0.0126228930,
    f_prevaddrmedianincome_d < 100122   => -0.0149962125,
    f_prevaddrmedianincome_d < 100907.5 => -0.0152052816,
    f_prevaddrmedianincome_d < 101007   => -0.0154812014,
    f_prevaddrmedianincome_d < 101008   => -0.0159701180,
    f_prevaddrmedianincome_d < 101010   => -0.0164539983,
    f_prevaddrmedianincome_d < 101291   => -0.0166928185,
    f_prevaddrmedianincome_d < 101445.5 => -0.0189203397,
    f_prevaddrmedianincome_d < 101460.5 => -0.0214802058,
    f_prevaddrmedianincome_d < 101511.5 => -0.0217117846,
    f_prevaddrmedianincome_d < 102854   => -0.0219435496,
    f_prevaddrmedianincome_d < 103031   => -0.0222148176,
    f_prevaddrmedianincome_d < 103038   => -0.0229749381,
    f_prevaddrmedianincome_d < 103198   => -0.0238124579,
    f_prevaddrmedianincome_d < 103328.5 => -0.0252485151,
    f_prevaddrmedianincome_d < 103337   => -0.0282976621,
    f_prevaddrmedianincome_d < 103337.5 => -0.0291049061,
    f_prevaddrmedianincome_d < 103344.5 => -0.0293933862,
    f_prevaddrmedianincome_d < 103504   => -0.0296156026,
    f_prevaddrmedianincome_d < 104936   => -0.0298948228,
    f_prevaddrmedianincome_d < 106220   => -0.0301299836,
    f_prevaddrmedianincome_d < 106491.5 => -0.0307252193,
    f_prevaddrmedianincome_d < 107784   => -0.0310504327,
    f_prevaddrmedianincome_d < 107785   => -0.0323433394,
    f_prevaddrmedianincome_d < 107917   => -0.0329347217,
    f_prevaddrmedianincome_d < 107919.5 => -0.0369263421,
    f_prevaddrmedianincome_d < 107925   => -0.0381084947,
    f_prevaddrmedianincome_d < 109609   => -0.0383302244,
    f_prevaddrmedianincome_d < 110879.5 => -0.0386194714,
    f_prevaddrmedianincome_d < 111056   => -0.0389200124,
    f_prevaddrmedianincome_d < 111095.5 => -0.0418451376,
    f_prevaddrmedianincome_d < 111108   => -0.0466492997,
    f_prevaddrmedianincome_d < 111117   => -0.0469481927,
    f_prevaddrmedianincome_d < 111666   => -0.0472414150,
    f_prevaddrmedianincome_d < 113882.5 => -0.0502464187,
    f_prevaddrmedianincome_d < 114276   => -0.0505794469,
    f_prevaddrmedianincome_d < 121162.5 => -0.0512288569,
         -0.0516315995));

mod1_95 := __common__(map(
    f_prevaddrmedianvalue_d = NULL     => -0.0000919007,
    f_prevaddrmedianvalue_d < 492340.5 => 0.0001180902,
    f_prevaddrmedianvalue_d < 492995.5 => -0.0000369146,
    f_prevaddrmedianvalue_d < 495367   => -0.0002158372,
    f_prevaddrmedianvalue_d < 498086   => -0.0003731911,
    f_prevaddrmedianvalue_d < 498563   => -0.0005298524,
    f_prevaddrmedianvalue_d < 538072   => -0.0006745790,
    f_prevaddrmedianvalue_d < 549343   => -0.0007956650,
    f_prevaddrmedianvalue_d < 854715   => -0.0009371003,
    f_prevaddrmedianvalue_d < 854941.5 => -0.0005934891,
    f_prevaddrmedianvalue_d < 855030.5 => 0.0007100642,
    f_prevaddrmedianvalue_d < 855738.5 => 0.0023647914,
    f_prevaddrmedianvalue_d < 891333.5 => 0.0027037160,
    f_prevaddrmedianvalue_d < 897524   => 0.0031059469,
    f_prevaddrmedianvalue_d < 897780   => 0.0034614918,
    f_prevaddrmedianvalue_d < 898670.5 => 0.0038741782,
        0.0046869711));

mod1_96 := __common__(map(
    f_prevaddrmurderindex_i = NULL  => -0.0005507507,
    f_prevaddrmurderindex_i < 5     => 0.0270335423,
    f_prevaddrmurderindex_i < 8     => 0.0221877295,
    f_prevaddrmurderindex_i < 37    => -0.0009997129,
    f_prevaddrmurderindex_i < 38.5  => -0.0014688303,
    f_prevaddrmurderindex_i < 60.5  => -0.0039594847,
    f_prevaddrmurderindex_i < 62    => -0.0044085168,
    f_prevaddrmurderindex_i < 129   => -0.0047219726,
    f_prevaddrmurderindex_i < 131   => -0.0042340663,
    f_prevaddrmurderindex_i < 134.5 => -0.0033843012,
    f_prevaddrmurderindex_i < 137.5 => -0.0029901744,
    f_prevaddrmurderindex_i < 139   => -0.0028529926,
    f_prevaddrmurderindex_i < 141   => -0.0010682291,
    f_prevaddrmurderindex_i < 190.5 => -0.0005446356,
    f_prevaddrmurderindex_i < 195.5 => 0.0007078317,
                      0.0995569440));

mod1_97 := __common__(map(
    f_prevaddrstatus_i = NULL => -0.0045490602,
    f_prevaddrstatus_i < 2.5  => 0.0033632528,
                0.0012829705));

mod1_98 := __common__(map(
    f_property_owners_ct_d = NULL => -0.0000346294,
    f_property_owners_ct_d < 0.5  => 0.0004406310,
    f_property_owners_ct_d < 1.5  => 0.0001820366,
                    -0.0005693872));

mod1_99 := __common__(map(
    f_rel_ageover20_count_d = NULL => 0.0000067517,
    f_rel_ageover20_count_d < 7.5  => -0.0001234738,
                     0.0000374451));

mod1_100 := __common__(map(
    f_rel_ageover30_count_d = NULL => -0.0001434933,
    f_rel_ageover30_count_d < 3.5  => -0.0001228480,
    f_rel_ageover30_count_d < 26.5 => 0.0000664384,
    f_rel_ageover30_count_d < 27.5 => -0.0002798184,
    f_rel_ageover30_count_d < 29.5 => -0.0005823673,
                     -0.0010352281));

mod1_101 := __common__(map(
    f_rel_ageover40_count_d = NULL => -0.0004868297,
    f_rel_ageover40_count_d < 10.5 => 0.0000067105,
                     -0.0003424859));

mod1_102 := __common__(map(
    f_rel_bankrupt_count_i = NULL => -0.0003059942,
    f_rel_bankrupt_count_i < 0.5  => -0.0137370163,
    f_rel_bankrupt_count_i < 1.5  => 0.0024698404,
    f_rel_bankrupt_count_i < 2.5  => 0.0036969844,
    f_rel_bankrupt_count_i < 4.5  => 0.0051740623,
    f_rel_bankrupt_count_i < 5.5  => 0.0047563760,
    f_rel_bankrupt_count_i < 11.5 => 0.0040940552,
    f_rel_bankrupt_count_i < 12.5 => 0.0025893941,
                    -0.0225510094));

mod1_103 := __common__(map(
    f_rel_count_i = NULL => -0.0000910806,
    f_rel_count_i < 1.5  => 0.0009617637,
    f_rel_count_i < 7.5  => -0.0008422462,
    f_rel_count_i < 29.5 => 0.0002615254,
    f_rel_count_i < 30.5 => 0.0000098061,
    f_rel_count_i < 33.5 => -0.0011419543,
           -0.0017063805));

mod1_104 := __common__(map(
    f_rel_criminal_count_i = NULL => -0.0000041293,
    f_rel_criminal_count_i < 3.5  => 0.0000357303,
                    -0.0000672411));

mod1_105 := __common__(map(
    f_rel_educationover12_count_d = NULL => -0.0017715429,
    f_rel_educationover12_count_d < 16.5 => 0.0001332870,
    f_rel_educationover12_count_d < 28.5 => -0.0000188656,
    f_rel_educationover12_count_d < 29.5 => -0.0043482195,
          -0.0048849853));

mod1_106 := __common__(map(
    f_rel_educationover8_count_d = NULL => -0.0011583180,
    f_rel_educationover8_count_d < 7.5  => -0.0008813776,
         0.0001983777));

mod1_107 := __common__(map(
    f_rel_homeover100_count_d = NULL => -0.0015466153,
    f_rel_homeover100_count_d < 6.5  => -0.0004807786,
    f_rel_homeover100_count_d < 7.5  => -0.0000997184,
      0.0001697735));

mod1_108 := __common__(map(
    f_rel_homeover150_count_d = NULL => -0.0003641824,
    f_rel_homeover150_count_d < 0.5  => 0.0003313425,
      -0.0000113657));

mod1_109 := __common__(map(
    f_rel_homeover200_count_d = NULL => -0.0049272940,
    f_rel_homeover200_count_d < 0.5  => 0.0038006383,
      -0.0001459944));

mod1_110 := __common__(map(
    f_rel_homeover300_count_d = NULL => -0.0522127675,
    f_rel_homeover300_count_d < 0.5  => 0.0566883896,
    f_rel_homeover300_count_d < 30.5 => -0.0066567664,
      -0.0071541145));

mod1_111 := __common__(map(
    f_rel_homeover50_count_d = NULL => -0.0012211976,
    f_rel_homeover50_count_d < 7.5  => -0.0008051375,
                      0.0002232321));

mod1_112 := __common__(map(
    f_rel_homeover500_count_d = NULL => -0.0026625467,
    f_rel_homeover500_count_d < 0.5  => 0.0016090877,
      -0.0008066468));

mod1_113 := __common__(map(
    f_rel_incomeover25_count_d = NULL => -0.0000325358,
    f_rel_incomeover25_count_d < 7.5  => -0.0002278299,
       0.0000710231));

mod1_114 := __common__(map(
    f_rel_incomeover50_count_d = NULL => -0.0104594155,
    f_rel_incomeover50_count_d < 0.5  => 0.0235088928,
    f_rel_incomeover50_count_d < 28.5 => -0.0009275653,
       -0.0019488073));

mod1_115 := __common__(map(
    f_rel_incomeover75_count_d = NULL => -0.0021330650,
    f_rel_incomeover75_count_d < 0.5  => 0.0034582720,
    f_rel_incomeover75_count_d < 18.5 => -0.0008325837,
       -0.0013716313));

mod1_116 := __common__(map(
    f_rel_under100miles_cnt_d = NULL => -0.0027689065,
    f_rel_under100miles_cnt_d < 4.5  => -0.0010702425,
    f_rel_under100miles_cnt_d < 6.5  => -0.0009241436,
    f_rel_under100miles_cnt_d < 7.5  => 0.0001595209,
      0.0005598425));

mod1_117 := __common__(map(
    f_rel_under25miles_cnt_d = NULL => -0.0118955404,
    f_rel_under25miles_cnt_d < 1.5  => -0.0079152755,
    f_rel_under25miles_cnt_d < 2.5  => -0.0077403740,
    f_rel_under25miles_cnt_d < 3.5  => 0.0000971587,
    f_rel_under25miles_cnt_d < 4.5  => 0.0002547503,
    f_rel_under25miles_cnt_d < 6.5  => 0.0004867439,
    f_rel_under25miles_cnt_d < 7.5  => 0.0023511185,
    f_rel_under25miles_cnt_d < 12.5 => 0.0024678921,
    f_rel_under25miles_cnt_d < 13.5 => 0.0018272594,
    f_rel_under25miles_cnt_d < 22.5 => 0.0016790052,
    f_rel_under25miles_cnt_d < 23.5 => 0.0010635657,
                      0.0007895182));

mod1_118 := __common__(map(
    f_rel_under500miles_cnt_d = NULL => -0.0244413438,
    f_rel_under500miles_cnt_d < 3.5  => -0.0170262408,
    f_rel_under500miles_cnt_d < 4.5  => -0.0168390886,
    f_rel_under500miles_cnt_d < 5.5  => -0.0166638916,
    f_rel_under500miles_cnt_d < 6.5  => -0.0151869598,
    f_rel_under500miles_cnt_d < 7.5  => 0.0023067748,
      0.0062722757));

mod1_119 := __common__(map(
    f_sourcerisktype_i = NULL => -0.0020325306,
    f_sourcerisktype_i < 4.5  => -0.0375430090,
    f_sourcerisktype_i < 5.5  => -0.0201992127,
    f_sourcerisktype_i < 6.5  => 0.0366961580,
                0.0450081344));

mod1_120 := __common__(map(
    f_srchaddrsrchcountmo_i = NULL => -0.0024118160,
    f_srchaddrsrchcountmo_i < 1.5  => -0.0086098100,
    f_srchaddrsrchcountmo_i < 2.5  => -0.0056295228,
    f_srchaddrsrchcountmo_i < 5.5  => 0.0809126602,
                     0.0827285977));

mod1_121 := __common__(map(
    f_srchaddrsrchcountwk_i = NULL => -0.0000583527,
    f_srchaddrsrchcountwk_i < 0.5  => -0.0001403953,
    f_srchaddrsrchcountwk_i < 1.5  => 0.0007072919,
                     0.0013814149));

mod1_122 := __common__(map(
    f_srchcomponentrisktype_i = NULL => -0.0022557396,
    f_srchcomponentrisktype_i < 2.5  => -0.0076938875,
    f_srchcomponentrisktype_i < 4.5  => 0.0174130956,
    f_srchcomponentrisktype_i < 5.5  => 0.0422799191,
    f_srchcomponentrisktype_i < 6.5  => 0.0428553462,
    f_srchcomponentrisktype_i < 7.5  => 0.0438385672,
    f_srchcomponentrisktype_i < 8.5  => 0.0455970337,
      0.0470165966));

mod1_123 := __common__(map(
    f_srchfraudsrchcountmo_i = NULL => -0.0007939063,
    f_srchfraudsrchcountmo_i < 0.5  => -0.0028854015,
    f_srchfraudsrchcountmo_i < 1.5  => -0.0002914898,
    f_srchfraudsrchcountmo_i < 2.5  => 0.0109542337,
    f_srchfraudsrchcountmo_i < 3.5  => 0.0123480947,
    f_srchfraudsrchcountmo_i < 5.5  => 0.0126667510,
                      0.0130273750));

mod1_124 := __common__(map(
    f_srchfraudsrchcountwk_i = NULL => -0.0000203324,
    f_srchfraudsrchcountwk_i < 3.5  => -0.0000374923,
                      0.0022519842));

mod1_125 := __common__(map(
    f_srchfraudsrchcountyr_i = NULL => -0.0024726805,
    f_srchfraudsrchcountyr_i < 0.5  => -0.0143422579,
    f_srchfraudsrchcountyr_i < 2.5  => -0.0050836220,
    f_srchfraudsrchcountyr_i < 3.5  => -0.0048501509,
    f_srchfraudsrchcountyr_i < 4.5  => 0.0082129889,
    f_srchfraudsrchcountyr_i < 5.5  => 0.0121913152,
    f_srchfraudsrchcountyr_i < 6.5  => 0.0131907199,
    f_srchfraudsrchcountyr_i < 7.5  => 0.0301118849,
    f_srchfraudsrchcountyr_i < 9.5  => 0.0305423718,
    f_srchfraudsrchcountyr_i < 10.5 => 0.0307263920,
    f_srchfraudsrchcountyr_i < 11.5 => 0.0318018375,
                      0.0320907170));

mod1_126 := __common__(map(
    f_srchphonesrchcountmo_i = NULL => -0.0041065128,
    f_srchphonesrchcountmo_i < 0.5  => -0.0164881814,
    f_srchphonesrchcountmo_i < 1.5  => 0.0272566157,
    f_srchphonesrchcountmo_i < 2.5  => 0.0689374508,
    f_srchphonesrchcountmo_i < 3.5  => 0.0751792704,
    f_srchphonesrchcountmo_i < 4.5  => 0.0763705357,
    f_srchphonesrchcountmo_i < 6.5  => 0.0874895762,
                      0.1235834551));

mod1_127 := __common__(map(
    f_srchphonesrchcountwk_i = NULL => -0.0001101535,
    f_srchphonesrchcountwk_i < 0.5  => -0.0004926887,
    f_srchphonesrchcountwk_i < 3.5  => 0.0056134039,
                      0.0064647583));

mod1_128 := __common__(map(
    f_srchssnsrchcountmo_i = NULL => -0.0009816577,
    f_srchssnsrchcountmo_i < 1.5  => -0.0030865705,
    f_srchssnsrchcountmo_i < 2.5  => 0.0038539411,
    f_srchssnsrchcountmo_i < 5.5  => 0.0179064444,
    f_srchssnsrchcountmo_i < 6.5  => 0.0182493641,
                    0.0579965483));

mod1_129 := __common__(map(
    f_srchssnsrchcountwk_i = NULL => -0.0000051092,
    f_srchssnsrchcountwk_i < 3.5  => -0.0000076400,
                    0.0003671072));

mod1_130 := __common__(map(
    f_srchunvrfddobcount_i = NULL => -0.0001944525,
    f_srchunvrfddobcount_i < 0.5  => -0.0013060451,
                    0.0087394025));

mod1_131 := __common__(map(
    f_srchunvrfdphonecount_i = NULL => -0.0030825570,
    f_srchunvrfdphonecount_i < 0.5  => -0.0180564031,
    f_srchunvrfdphonecount_i < 1.5  => 0.0010957639,
    f_srchunvrfdphonecount_i < 2.5  => 0.0046781760,
    f_srchunvrfdphonecount_i < 3.5  => 0.1154252797,
                      0.1282775076));

mod1_132 := __common__(map(
    f_srchunvrfdssncount_i = NULL => 0.0000100125,
    f_srchunvrfdssncount_i < 0.5  => -0.0000050375,
                    0.0001285441));

mod1_133 := __common__(map(
    f_srchvelocityrisktype_i = NULL => -0.0067244779,
    f_srchvelocityrisktype_i < 4.5  => -0.0300571843,
    f_srchvelocityrisktype_i < 5.5  => -0.0254755891,
    f_srchvelocityrisktype_i < 6.5  => -0.0253537728,
    f_srchvelocityrisktype_i < 7.5  => -0.0228466754,
    f_srchvelocityrisktype_i < 8.5  => 0.0236384662,
                      0.0756801758));

mod1_134 := __common__(map(
    f_util_add_input_conv_n = NULL => -0.0000132315,
    f_util_add_input_conv_n < 0.5  => -0.0002380379,
                     0.0000513955));

mod1_135 := __common__(map(
    f_util_adl_count_n = NULL => -0.0002715261,
    f_util_adl_count_n < 1.5  => -0.0027581453,
    f_util_adl_count_n < 4.5  => -0.0028670292,
    f_util_adl_count_n < 5.5  => -0.0027635406,
    f_util_adl_count_n < 7.5  => -0.0016588615,
    f_util_adl_count_n < 9.5  => 0.0021506933,
    f_util_adl_count_n < 10.5 => 0.0153572852,
    f_util_adl_count_n < 19.5 => 0.0167206684,
                0.0170631015));

mod1_136 := __common__(map(
    f_vardobcount_i = NULL => -0.0000107872,
    f_vardobcount_i < 2.5  => 0.0000557312,
    f_vardobcount_i < 3.5  => -0.0004311324,
             -0.0026326765));

mod1_137 := __common__(map(
    f_varrisktype_i = NULL => -0.0015509981,
    f_varrisktype_i < 1.5  => -0.0062799754,
    f_varrisktype_i < 3.5  => -0.0061637041,
    f_varrisktype_i < 4.5  => 0.0226468774,
    f_varrisktype_i < 5.5  => 0.0240987222,
    f_varrisktype_i < 6.5  => 0.0253424230,
             0.0727122537));

mod1_138 := __common__(map(
    k_comb_age_d = NULL => -0.0033159134,
    k_comb_age_d < 36.5 => 0.0197997123,
    k_comb_age_d < 42.5 => 0.0196212873,
    k_comb_age_d < 45.5 => 0.0194466928,
    k_comb_age_d < 47.5 => 0.0192203140,
    k_comb_age_d < 48.5 => -0.0092478664,
    k_comb_age_d < 49.5 => -0.0127216746,
    k_comb_age_d < 50.5 => -0.0164359202,
    k_comb_age_d < 51.5 => -0.0479425368,
          -0.0487631617));

mod1_139 := __common__(map(
    k_estimated_income_d = NULL   => -0.0050426677,
    k_estimated_income_d < 35500  => 0.0796980506,
    k_estimated_income_d < 40500  => 0.0681070349,
    k_estimated_income_d < 41500  => 0.0677095745,
    k_estimated_income_d < 43500  => 0.0675089581,
    k_estimated_income_d < 46500  => 0.0672522062,
    k_estimated_income_d < 47500  => 0.0670684265,
    k_estimated_income_d < 49500  => 0.0668550938,
    k_estimated_income_d < 58500  => 0.0628553167,
    k_estimated_income_d < 60500  => 0.0625535117,
    k_estimated_income_d < 61500  => 0.0624136382,
    k_estimated_income_d < 62500  => 0.0622525114,
    k_estimated_income_d < 63500  => 0.0621199111,
    k_estimated_income_d < 73500  => 0.0504436681,
    k_estimated_income_d < 74500  => 0.0495035714,
    k_estimated_income_d < 75500  => 0.0441738450,
    k_estimated_income_d < 76500  => 0.0322021511,
    k_estimated_income_d < 78500  => 0.0279579400,
    k_estimated_income_d < 79500  => 0.0257645610,
    k_estimated_income_d < 80500  => 0.0230258206,
    k_estimated_income_d < 81500  => 0.0208529966,
    k_estimated_income_d < 83500  => -0.0094152942,
    k_estimated_income_d < 85500  => -0.0178881550,
    k_estimated_income_d < 86500  => -0.0190792498,
    k_estimated_income_d < 87500  => -0.0196577289,
    k_estimated_income_d < 89500  => -0.0207147801,
    k_estimated_income_d < 93500  => -0.0231012965,
    k_estimated_income_d < 94500  => -0.0249481759,
    k_estimated_income_d < 95500  => -0.0262861917,
    k_estimated_income_d < 96500  => -0.0340990721,
    k_estimated_income_d < 99500  => -0.0564054070,
    k_estimated_income_d < 101500 => -0.0580384998,
    k_estimated_income_d < 103500 => -0.0586263220,
    k_estimated_income_d < 104500 => -0.0592545477,
    k_estimated_income_d < 107500 => -0.0596501655,
    k_estimated_income_d < 111500 => -0.0607435424,
    k_estimated_income_d < 112500 => -0.0632269064,
    k_estimated_income_d < 114500 => -0.0648980957,
    k_estimated_income_d < 115500 => -0.0661360092,
    k_estimated_income_d < 119500 => -0.0688761583,
    k_estimated_income_d < 123500 => -0.0698479859,
    k_estimated_income_d < 124500 => -0.0729910794,
    k_estimated_income_d < 126500 => -0.0733546003,
                    -0.0762712097));

mod1_140 := __common__(map(
    k_inf_fname_verd_d = NULL => -0.0000587798,
    k_inf_fname_verd_d < 0.5  => 0.0008569972,
                -0.0013512386));

mod1_141 := __common__(map(
    k_inq_adls_per_phone_i = NULL => 0.0000226616,
    k_inq_adls_per_phone_i < 1.5  => -0.0001912614,
                    0.0037288137));

mod1_142 := __common__(map(
    k_inq_dobs_per_ssn_i = NULL => -0.0000627516,
    k_inq_dobs_per_ssn_i < 0.5  => -0.0004859464,
    k_inq_dobs_per_ssn_i < 1.5  => -0.0002146071,
                  0.0035309430));

mod1_143 := __common__(map(
    k_inq_per_addr_i = NULL => -0.0001485402,
    k_inq_per_addr_i < 19.5 => -0.0003146164,
    k_inq_per_addr_i < 20.5 => 0.0006191272,
    k_inq_per_addr_i < 23.5 => 0.0009270121,
    k_inq_per_addr_i < 25.5 => 0.0046103762,
    k_inq_per_addr_i < 26.5 => 0.0211612998,
              0.0225049279));

mod1_144 := __common__(map(
    k_inq_per_phone_i = NULL => -0.0007941071,
    k_inq_per_phone_i < 1.5  => -0.0022076925,
    k_inq_per_phone_i < 2.5  => -0.0020045961,
    k_inq_per_phone_i < 6.5  => -0.0017419805,
    k_inq_per_phone_i < 7.5  => -0.0014059360,
    k_inq_per_phone_i < 8.5  => 0.0021368120,
    k_inq_per_phone_i < 13.5 => 0.0023767871,
    k_inq_per_phone_i < 14.5 => 0.0513622616,
    k_inq_per_phone_i < 15.5 => 0.0626022006,
    k_inq_per_phone_i < 16.5 => 0.0636319573,
    k_inq_per_phone_i < 17.5 => 0.0643581406,
    k_inq_per_phone_i < 18.5 => 0.0647239688,
               0.0654874187));

mod1_145 := __common__(map(
    k_inq_per_ssn_i = NULL => -0.0000407007,
    k_inq_per_ssn_i < 7.5  => -0.0001472812,
    k_inq_per_ssn_i < 15.5 => 0.0004216636,
    k_inq_per_ssn_i < 16.5 => 0.0012882344,
             0.0015642369));

mod1_146 := __common__(map(
    k_nap_fname_verd_d = NULL => -0.0000125854,
    k_nap_fname_verd_d < 0.5  => 0.0004412371,
                -0.0000641357));

mod1_147 := __common__(map(
    k_nap_phn_verd_d = NULL => -0.0001846740,
    k_nap_phn_verd_d < 0.5  => 0.0043776498,
              -0.0014848273));

mod1_148 := __common__(map(
    nf_seg_fraudpoint_3_0 = ''                   => -0.0041261049,
    nf_seg_fraudpoint_3_0 = '1: Stolen/Manip ID'   => 0.0202641099,
    nf_seg_fraudpoint_3_0 = '2: Synth ID'          => 0.0029655298,
    nf_seg_fraudpoint_3_0 = '3: Derog'             => 0.0194853871,
    nf_seg_fraudpoint_3_0 = '4: Recent Activity'   => -0.0389609282,
    nf_seg_fraudpoint_3_0 = '5: Vuln Vic/Friendly' => -0.0499302224,
                    -0.0494082012));

mod1_149 := __common__(map(
    r_a43_watercraft_cnt_d = NULL => -0.0002578518,
    r_a43_watercraft_cnt_d < 0.5  => -0.0011077939,
                    0.0734642215));

mod1_150 := __common__(map(
    r_a44_curr_add_naprop_d = NULL => -0.0002593972,
    r_a44_curr_add_naprop_d < 2.5  => 0.0018248050,
    r_a44_curr_add_naprop_d < 3.5  => -0.0025858855,
                     -0.0034561907));

mod1_151 := __common__(map(
    r_a46_curr_avm_autoval_d = NULL     => 0.0058370552,
    r_a46_curr_avm_autoval_d < 59948    => 0.0245850928,
    r_a46_curr_avm_autoval_d < 192650   => 0.0251244179,
    r_a46_curr_avm_autoval_d < 194094   => 0.0249565147,
    r_a46_curr_avm_autoval_d < 195275   => 0.0247137516,
    r_a46_curr_avm_autoval_d < 195760   => 0.0237405318,
    r_a46_curr_avm_autoval_d < 195878   => 0.0234889507,
    r_a46_curr_avm_autoval_d < 195900   => 0.0231093090,
    r_a46_curr_avm_autoval_d < 196674.5 => 0.0228603870,
    r_a46_curr_avm_autoval_d < 196694   => 0.0210244567,
    r_a46_curr_avm_autoval_d < 196754   => 0.0204598449,
    r_a46_curr_avm_autoval_d < 197196   => 0.0199264775,
    r_a46_curr_avm_autoval_d < 197250   => 0.0154557714,
    r_a46_curr_avm_autoval_d < 198582   => 0.0149152097,
    r_a46_curr_avm_autoval_d < 198619   => 0.0139631189,
    r_a46_curr_avm_autoval_d < 198685   => 0.0133665018,
    r_a46_curr_avm_autoval_d < 198778   => 0.0132161357,
    r_a46_curr_avm_autoval_d < 198814.5 => 0.0014753702,
    r_a46_curr_avm_autoval_d < 198820.5 => -0.0012950310,
    r_a46_curr_avm_autoval_d < 198887.5 => -0.0021200659,
    r_a46_curr_avm_autoval_d < 204551.5 => -0.0023441388,
    r_a46_curr_avm_autoval_d < 204576   => -0.0025158120,
    r_a46_curr_avm_autoval_d < 213242.5 => -0.0026659514,
    r_a46_curr_avm_autoval_d < 213342.5 => -0.0033931475,
    r_a46_curr_avm_autoval_d < 213369   => -0.0035748201,
    r_a46_curr_avm_autoval_d < 216945.5 => -0.0038089069,
    r_a46_curr_avm_autoval_d < 217014   => -0.0039971454,
    r_a46_curr_avm_autoval_d < 217061   => -0.0041919335,
    r_a46_curr_avm_autoval_d < 217803.5 => -0.0044827175,
    r_a46_curr_avm_autoval_d < 217852   => -0.0063285297,
    r_a46_curr_avm_autoval_d < 217856   => -0.0069966437,
    r_a46_curr_avm_autoval_d < 225220   => -0.0072715423,
    r_a46_curr_avm_autoval_d < 232004   => -0.0075646656,
    r_a46_curr_avm_autoval_d < 244431.5 => -0.0077916989,
    r_a46_curr_avm_autoval_d < 258212   => -0.0080540615,
    r_a46_curr_avm_autoval_d < 259835.5 => -0.0082823836,
    r_a46_curr_avm_autoval_d < 272750   => -0.0093230212,
    r_a46_curr_avm_autoval_d < 284500   => -0.0095516230,
    r_a46_curr_avm_autoval_d < 290035   => -0.0097664123,
    r_a46_curr_avm_autoval_d < 290057   => -0.0101655288,
    r_a46_curr_avm_autoval_d < 290189   => -0.0103584798,
    r_a46_curr_avm_autoval_d < 292303.5 => -0.0107596196,
    r_a46_curr_avm_autoval_d < 292319.5 => -0.0111400775,
    r_a46_curr_avm_autoval_d < 295034   => -0.0115016817,
    r_a46_curr_avm_autoval_d < 295278   => -0.0119318968,
    r_a46_curr_avm_autoval_d < 295330.5 => -0.0123633342,
    r_a46_curr_avm_autoval_d < 295528   => -0.0125009148,
    r_a46_curr_avm_autoval_d < 295571   => -0.0161781634,
    r_a46_curr_avm_autoval_d < 296987.5 => -0.0170617542,
         -0.0181811174));

mod1_152 := __common__(map(
    r_a49_curr_avm_chg_1yr_i = NULL  => 0.0000256384,
    r_a49_curr_avm_chg_1yr_i < -6920 => -0.0002689259,
      0.0000244618));

mod1_153 := __common__(map(
    r_a49_curr_avm_chg_1yr_pct_i = NULL   => 0.0039434917,
    r_a49_curr_avm_chg_1yr_pct_i < 118.95 => -0.0157380716,
    r_a49_curr_avm_chg_1yr_pct_i < 119.55 => -0.0153979187,
    r_a49_curr_avm_chg_1yr_pct_i < 119.65 => -0.0133221768,
    r_a49_curr_avm_chg_1yr_pct_i < 119.95 => -0.0100438103,
    r_a49_curr_avm_chg_1yr_pct_i < 120.95 => -0.0098781805,
    r_a49_curr_avm_chg_1yr_pct_i < 121.35 => -0.0096654677,
    r_a49_curr_avm_chg_1yr_pct_i < 121.55 => -0.0093242283,
    r_a49_curr_avm_chg_1yr_pct_i < 121.65 => 0.0069704257,
    r_a49_curr_avm_chg_1yr_pct_i < 122.15 => 0.0094254045,
    r_a49_curr_avm_chg_1yr_pct_i < 161.35 => 0.0097557607,
    r_a49_curr_avm_chg_1yr_pct_i < 174    => 0.0100529495,
    r_a49_curr_avm_chg_1yr_pct_i < 178.45 => 0.0120958696,
    r_a49_curr_avm_chg_1yr_pct_i < 179.05 => 0.0131998075,
    r_a49_curr_avm_chg_1yr_pct_i < 185.75 => 0.0135861416,
    r_a49_curr_avm_chg_1yr_pct_i < 198.65 => 0.0139950366,
    r_a49_curr_avm_chg_1yr_pct_i < 199.15 => 0.0149279751,
    r_a49_curr_avm_chg_1yr_pct_i < 199.45 => 0.0172626231,
    r_a49_curr_avm_chg_1yr_pct_i < 199.85 => 0.0222840121,
    r_a49_curr_avm_chg_1yr_pct_i < 203.7  => 0.0434045746,
    r_a49_curr_avm_chg_1yr_pct_i < 206.75 => 0.0448270367,
    r_a49_curr_avm_chg_1yr_pct_i < 206.85 => 0.0453182825,
    r_a49_curr_avm_chg_1yr_pct_i < 207.2  => 0.0458151634,
    r_a49_curr_avm_chg_1yr_pct_i < 207.6  => 0.0462408895,
    r_a49_curr_avm_chg_1yr_pct_i < 207.7  => 0.0467712223,
    r_a49_curr_avm_chg_1yr_pct_i < 207.8  => 0.0482240333,
    r_a49_curr_avm_chg_1yr_pct_i < 207.9  => 0.0487208920,
    r_a49_curr_avm_chg_1yr_pct_i < 208.2  => 0.0492386990,
    r_a49_curr_avm_chg_1yr_pct_i < 208.3  => 0.0507448370,
    r_a49_curr_avm_chg_1yr_pct_i < 208.4  => 0.0536175402,
    r_a49_curr_avm_chg_1yr_pct_i < 209.15 => 0.0666514078,
    r_a49_curr_avm_chg_1yr_pct_i < 209.35 => 0.0671604251,
           0.0681160167));

mod1_154 := __common__(map(
    r_c10_m_hdr_fs_d = NULL  => -0.0041745910,
    r_c10_m_hdr_fs_d < 64.5  => -0.0360699530,
    r_c10_m_hdr_fs_d < 65.5  => -0.0017906001,
    r_c10_m_hdr_fs_d < 66.5  => 0.0174815437,
    r_c10_m_hdr_fs_d < 67.5  => 0.0228450878,
    r_c10_m_hdr_fs_d < 68.5  => 0.0233779064,
    r_c10_m_hdr_fs_d < 69.5  => 0.0238961658,
    r_c10_m_hdr_fs_d < 70.5  => 0.0249435864,
    r_c10_m_hdr_fs_d < 164.5 => 0.0293453431,
    r_c10_m_hdr_fs_d < 294.5 => 0.0292248520,
    r_c10_m_hdr_fs_d < 298.5 => 0.0291055019,
    r_c10_m_hdr_fs_d < 299.5 => 0.0287473145,
    r_c10_m_hdr_fs_d < 301.5 => 0.0272995796,
    r_c10_m_hdr_fs_d < 303.5 => 0.0045469191,
    r_c10_m_hdr_fs_d < 304.5 => 0.0024819869,
    r_c10_m_hdr_fs_d < 305.5 => -0.0182719598,
    r_c10_m_hdr_fs_d < 307.5 => -0.0184719072,
    r_c10_m_hdr_fs_d < 308.5 => -0.0189969825,
    r_c10_m_hdr_fs_d < 310.5 => -0.0194954377,
    r_c10_m_hdr_fs_d < 311.5 => -0.0198058406,
    r_c10_m_hdr_fs_d < 312.5 => -0.0208632986,
    r_c10_m_hdr_fs_d < 313.5 => -0.0212370185,
    r_c10_m_hdr_fs_d < 319.5 => -0.0221222590,
    r_c10_m_hdr_fs_d < 331.5 => -0.0234595597,
    r_c10_m_hdr_fs_d < 335.5 => -0.0247818198,
    r_c10_m_hdr_fs_d < 336.5 => -0.0259744361,
    r_c10_m_hdr_fs_d < 340.5 => -0.0261391004,
    r_c10_m_hdr_fs_d < 341.5 => -0.0262850874,
    r_c10_m_hdr_fs_d < 344.5 => -0.0264392543,
    r_c10_m_hdr_fs_d < 345.5 => -0.0278913287,
    r_c10_m_hdr_fs_d < 346.5 => -0.0287032574,
    r_c10_m_hdr_fs_d < 348.5 => -0.0315654137,
    r_c10_m_hdr_fs_d < 349.5 => -0.0350488855,
    r_c10_m_hdr_fs_d < 350.5 => -0.0475003294,
    r_c10_m_hdr_fs_d < 352.5 => -0.0487842614,
    r_c10_m_hdr_fs_d < 353.5 => -0.0492650200,
    r_c10_m_hdr_fs_d < 356.5 => -0.0498030860,
    r_c10_m_hdr_fs_d < 357.5 => -0.0505088577,
    r_c10_m_hdr_fs_d < 363.5 => -0.0528645332,
    r_c10_m_hdr_fs_d < 388.5 => -0.0532281851,
    r_c10_m_hdr_fs_d < 389.5 => -0.0534933268,
    r_c10_m_hdr_fs_d < 397.5 => -0.0551014875,
    r_c10_m_hdr_fs_d < 406.5 => -0.0595717355,
    r_c10_m_hdr_fs_d < 407.5 => -0.0598241294,
    r_c10_m_hdr_fs_d < 431.5 => -0.0601015475,
    r_c10_m_hdr_fs_d < 435.5 => -0.0617158034,
    r_c10_m_hdr_fs_d < 436.5 => -0.0638991340,
    r_c10_m_hdr_fs_d < 437.5 => -0.0642452916,
    r_c10_m_hdr_fs_d < 460.5 => -0.0653379888,
    r_c10_m_hdr_fs_d < 473.5 => -0.0657981869,
    r_c10_m_hdr_fs_d < 476.5 => -0.0663632169,
    r_c10_m_hdr_fs_d < 485.5 => -0.0669925702,
    r_c10_m_hdr_fs_d < 490.5 => -0.0675784035,
    r_c10_m_hdr_fs_d < 494.5 => -0.0689233761,
    r_c10_m_hdr_fs_d < 495.5 => -0.0697164635,
    r_c10_m_hdr_fs_d < 501.5 => -0.0720585026,
    r_c10_m_hdr_fs_d < 503.5 => -0.0746513405,
    r_c10_m_hdr_fs_d < 506.5 => -0.0791044954,
               -0.0799731925));

mod1_155 := __common__(map(
    r_c12_num_nonderogs_d = NULL => -0.0001626293,
    r_c12_num_nonderogs_d < 2.5  => 0.0047518919,
                   -0.0063985933));

mod1_156 := __common__(map(
    r_c12_source_profile_d = NULL  => -0.0000068596,
    r_c12_source_profile_d < 27.1  => 0.0005585850,
    r_c12_source_profile_d < 28.05 => 0.0003398651,
    r_c12_source_profile_d < 28.5  => 0.0001393545,
    r_c12_source_profile_d < 78.5  => -0.0000587385,
    r_c12_source_profile_d < 78.65 => 0.0001766371,
                     0.0003912208));

mod1_157 := __common__(map(
    r_c13_curr_addr_lres_d = NULL  => -0.0000143335,
    r_c13_curr_addr_lres_d < 6.5   => 0.0007692259,
    r_c13_curr_addr_lres_d < 13.5  => -0.0003573674,
    r_c13_curr_addr_lres_d < 151.5 => -0.0000862257,
    r_c13_curr_addr_lres_d < 293.5 => -0.0002662468,
                     0.0006837303));

mod1_158 := __common__(map(
    r_c13_max_lres_d = NULL  => -0.0003120890,
    r_c13_max_lres_d < 48.5  => 0.0046910964,
    r_c13_max_lres_d < 65.5  => 0.0016244512,
    r_c13_max_lres_d < 74.5  => 0.0014987221,
    r_c13_max_lres_d < 97.5  => 0.0012683150,
    r_c13_max_lres_d < 108.5 => 0.0011568533,
    r_c13_max_lres_d < 122.5 => 0.0004567249,
    r_c13_max_lres_d < 124.5 => 0.0003317678,
    r_c13_max_lres_d < 132.5 => -0.0001145834,
    r_c13_max_lres_d < 155.5 => -0.0003648135,
    r_c13_max_lres_d < 156.5 => -0.0004760418,
    r_c13_max_lres_d < 172.5 => -0.0005871903,
    r_c13_max_lres_d < 173.5 => -0.0007033787,
    r_c13_max_lres_d < 174.5 => -0.0011671934,
    r_c13_max_lres_d < 176.5 => -0.0017333395,
    r_c13_max_lres_d < 178.5 => -0.0018590501,
    r_c13_max_lres_d < 356.5 => -0.0021406471,
    r_c13_max_lres_d < 372.5 => -0.0025388511,
    r_c13_max_lres_d < 373.5 => -0.0030914920,
    r_c13_max_lres_d < 390.5 => -0.0036297082,
    r_c13_max_lres_d < 400.5 => -0.0041735919,
    r_c13_max_lres_d < 416.5 => -0.0048568132,
    r_c13_max_lres_d < 436   => -0.0065242691,
    r_c13_max_lres_d < 436.5 => -0.0109913260,
    r_c13_max_lres_d < 437   => -0.0127603021,
    r_c13_max_lres_d < 443   => -0.0135978629,
    r_c13_max_lres_d < 449   => -0.0163390907,
    r_c13_max_lres_d < 454   => -0.0173474607,
    r_c13_max_lres_d < 455   => -0.0223896903,
    r_c13_max_lres_d < 465   => -0.0244222040,
               -0.0254428605));

mod1_159 := __common__(map(
    r_c14_addrs_10yr_i = NULL => -0.0025820556,
    r_c14_addrs_10yr_i < 0.5  => -0.0237156736,
    r_c14_addrs_10yr_i < 2.5  => -0.0217707037,
    r_c14_addrs_10yr_i < 3.5  => -0.0175291575,
    r_c14_addrs_10yr_i < 4.5  => 0.0317009933,
    r_c14_addrs_10yr_i < 7.5  => 0.0320276090,
    r_c14_addrs_10yr_i < 10.5 => 0.0401849992,
                0.0405319345));

mod1_160 := __common__(map(
    r_c14_addrs_15yr_i = NULL => -0.0033925078,
    r_c14_addrs_15yr_i < 1.5  => -0.0555494536,
    r_c14_addrs_15yr_i < 2.5  => -0.0548442898,
    r_c14_addrs_15yr_i < 4.5  => 0.0209236082,
    r_c14_addrs_15yr_i < 6.5  => 0.0217058589,
    r_c14_addrs_15yr_i < 7.5  => 0.0219358845,
                0.0227213187));

mod1_161 := __common__(map(
    r_c14_addrs_5yr_i = NULL => -0.0028479809,
    r_c14_addrs_5yr_i < 1.5  => -0.0231757546,
    r_c14_addrs_5yr_i < 2.5  => 0.0148533604,
    r_c14_addrs_5yr_i < 5.5  => 0.0463198327,
               0.0473891409));

mod1_162 := __common__(map(
    r_c14_addrs_per_adl_c6_i = NULL => -0.0001052056,
    r_c14_addrs_per_adl_c6_i < 0.5  => -0.0007360985,
                      0.0050515287));

mod1_163 := __common__(map(
    r_c20_email_domain_free_count_i = NULL => -0.0013583132,
    r_c20_email_domain_free_count_i < 0.5  => -0.0071571206,
    r_c20_email_domain_free_count_i < 1.5  => -0.0070198612,
    r_c20_email_domain_free_count_i < 2.5  => -0.0013777864,
    r_c20_email_domain_free_count_i < 3.5  => 0.0016721931,
    r_c20_email_domain_free_count_i < 4.5  => 0.0478500610,
    r_c20_email_domain_free_count_i < 5.5  => 0.0936409890,
    r_c20_email_domain_free_count_i < 6.5  => 0.1048451753,
            0.1995322793));

mod1_164 := __common__(map(
    r_c20_email_domain_isp_count_i = NULL => 0.0000237004,
    r_c20_email_domain_isp_count_i < 5.5  => 0.0005712183,
           -0.0549253169));

mod1_165 := __common__(map(
    r_c20_email_verification_d = NULL => -0.0002155203,
    r_c20_email_verification_d < 3.5  => 0.0000952943,
       -0.0001000698));

mod1_166 := __common__(map(
    r_c21_m_bureau_adl_fs_d = NULL  => -0.0002416176,
    r_c21_m_bureau_adl_fs_d < 55.5  => -0.0065501280,
    r_c21_m_bureau_adl_fs_d < 64.5  => -0.0060693896,
    r_c21_m_bureau_adl_fs_d < 65.5  => -0.0023797465,
    r_c21_m_bureau_adl_fs_d < 66.5  => -0.0017950117,
    r_c21_m_bureau_adl_fs_d < 68.5  => -0.0005133171,
    r_c21_m_bureau_adl_fs_d < 70.5  => -0.0000887969,
    r_c21_m_bureau_adl_fs_d < 155.5 => 0.0006166256,
    r_c21_m_bureau_adl_fs_d < 161.5 => 0.0004972578,
    r_c21_m_bureau_adl_fs_d < 214.5 => 0.0002245032,
    r_c21_m_bureau_adl_fs_d < 218.5 => 0.0001098820,
    r_c21_m_bureau_adl_fs_d < 356.5 => -0.0000103023,
    r_c21_m_bureau_adl_fs_d < 357.5 => -0.0004630834,
    r_c21_m_bureau_adl_fs_d < 363.5 => -0.0008355412,
                      -0.0010122181));

mod1_167 := __common__(map(
    r_c23_inp_addr_occ_index_d = NULL => -0.0000374412,
    r_c23_inp_addr_occ_index_d < 2    => -0.0003859204,
       0.0014239442));

mod1_168 := __common__(map(
    r_c23_inp_addr_owned_not_occ_d = NULL => -0.0000488469,
    r_c23_inp_addr_owned_not_occ_d < 0.5  => 0.0001077377,
           -0.0057693250));

mod1_169 := __common__(map(
    r_d30_derog_count_i = NULL => 0.0000010664,
    r_d30_derog_count_i < 0.5  => -0.0002858200,
    r_d30_derog_count_i < 3.5  => 0.0000800726,
    r_d30_derog_count_i < 19.5 => 0.0001896900,
                 -0.0006323175));

mod1_170 := __common__(map(
    r_d31_attr_bankruptcy_recency_d = NULL => 0.0001176519,
    r_d31_attr_bankruptcy_recency_d < 79.5 => -0.0035827620,
            0.0120916640));

mod1_171 := __common__(map(
    r_d31_bk_chapter_n = '' => -0.0002827384,
    (Integer)r_d31_bk_chapter_n < 10  => 0.0013325537,
                -0.0063618738));

mod1_172 := __common__(map(
    r_d31_bk_disposed_recent_count_i = NULL => -0.0000060280,
    r_d31_bk_disposed_recent_count_i < 0.5  => 0.0000039878,
             -0.0002575078));

mod1_173 := __common__(map(
    r_d31_bk_filing_count_i = NULL => -0.0000193549,
    r_d31_bk_filing_count_i < 2.5  => -0.0000313090,
                     0.0005662530));

mod1_174 := __common__(map(
    r_d32_criminal_count_i = NULL => -0.0000121985,
    r_d32_criminal_count_i < 8.5  => -0.0000238796,
                    0.0005898586));

mod1_175 := __common__(map(
    r_d32_mos_since_crim_ls_d = NULL  => -0.0004074203,
    r_d32_mos_since_crim_ls_d < 14.5  => 0.0292671632,
    r_d32_mos_since_crim_ls_d < 15.5  => 0.0189977235,
    r_d32_mos_since_crim_ls_d < 19.5  => 0.0187722281,
    r_d32_mos_since_crim_ls_d < 23.5  => 0.0112126992,
    r_d32_mos_since_crim_ls_d < 26.5  => 0.0096913298,
    r_d32_mos_since_crim_ls_d < 31.5  => 0.0092960114,
    r_d32_mos_since_crim_ls_d < 32.5  => 0.0091337039,
    r_d32_mos_since_crim_ls_d < 34.5  => 0.0089133138,
    r_d32_mos_since_crim_ls_d < 35.5  => 0.0085530619,
    r_d32_mos_since_crim_ls_d < 37.5  => 0.0075745599,
    r_d32_mos_since_crim_ls_d < 38.5  => 0.0058237112,
    r_d32_mos_since_crim_ls_d < 43.5  => 0.0030217203,
    r_d32_mos_since_crim_ls_d < 70.5  => -0.0011072711,
    r_d32_mos_since_crim_ls_d < 98.5  => -0.0012588580,
    r_d32_mos_since_crim_ls_d < 101.5 => -0.0015340784,
    r_d32_mos_since_crim_ls_d < 114.5 => -0.0016825255,
    r_d32_mos_since_crim_ls_d < 165.5 => -0.0019488507,
    r_d32_mos_since_crim_ls_d < 208.5 => -0.0020709769,
    r_d32_mos_since_crim_ls_d < 237.5 => -0.0022079081,
       -0.0023284003));

mod1_176 := __common__(map(
    r_d32_mos_since_fel_ls_d = NULL  => -0.0000029789,
    r_d32_mos_since_fel_ls_d < 225   => 0.0035092853,
    r_d32_mos_since_fel_ls_d < 235.5 => 0.0030533132,
    r_d32_mos_since_fel_ls_d < 236   => 0.0021694924,
    r_d32_mos_since_fel_ls_d < 239.5 => 0.0004501702,
      -0.0000203359));

mod1_177 := __common__(map(
    r_d33_eviction_count_i = NULL => -0.0005827846,
    r_d33_eviction_count_i < 0.5  => -0.0029705922,
    r_d33_eviction_count_i < 1.5  => -0.0023553101,
                    0.0515778989));

mod1_178 := __common__(map(
    r_d33_eviction_recency_d = NULL => -0.0000803977,
    r_d33_eviction_recency_d < 30   => 0.0081983030,
    r_d33_eviction_recency_d < 48   => 0.0008036254,
    r_d33_eviction_recency_d < 549  => 0.0004941911,
                      -0.0002348649));

mod1_179 := __common__(map(
    r_d34_unrel_lien60_count_i = NULL => -0.0000021810,
    r_d34_unrel_lien60_count_i < 2.5  => 0.0000091937,
       -0.0003945278));

mod1_180 := __common__(map(
    r_d34_unrel_liens_ct_i = NULL => -0.0000157973,
    r_d34_unrel_liens_ct_i < 2.5  => 0.0000148112,
    r_d34_unrel_liens_ct_i < 11.5 => -0.0001659712,
                    -0.0009945732));

mod1_181 := __common__(map(
    r_e55_college_ind_d = NULL => 0.0000091947,
    r_e55_college_ind_d < 0.5  => 0.0001307915,
                 -0.0010357470));

mod1_182 := __common__(map(
    r_e57_br_source_count_d = NULL => -0.0000833507,
    r_e57_br_source_count_d < 0.5  => 0.0009310067,
                     -0.0009590277));

mod1_183 := __common__(map(
    r_e57_prof_license_flag_d = NULL => -0.0000085772,
    r_e57_prof_license_flag_d < 0.5  => 0.0000684986,
      -0.0005265478));

mod1_184 := __common__(map(
    r_ever_asset_owner_d = NULL => 0.0000007723,
    r_ever_asset_owner_d < 0.5  => 0.0000927163,
                  -0.0000376226));

mod1_185 := __common__(map(
    r_f00_ssn_score_d = NULL => -0.0002531591,
    r_f00_ssn_score_d < 95   => 0.0910451427,
               -0.0007213183));

mod1_186 := __common__(map(
    r_f01_inp_addr_address_score_d = NULL => -0.0012163837,
    r_f01_inp_addr_address_score_d < 16   => 0.1225765411,
    r_f01_inp_addr_address_score_d < 25   => 0.1070325091,
    r_f01_inp_addr_address_score_d < 35   => 0.0710952528,
    r_f01_inp_addr_address_score_d < 45   => 0.0546616656,
    r_f01_inp_addr_address_score_d < 55   => 0.0435803820,
    r_f01_inp_addr_address_score_d < 65   => 0.0354855085,
    r_f01_inp_addr_address_score_d < 85   => 0.0351374718,
    r_f01_inp_addr_address_score_d < 95   => 0.0042100764,
           -0.0053943310));

mod1_187 := __common__(map(
    r_i60_inq_auto_count12_i = NULL => -0.0000008677,
    r_i60_inq_auto_count12_i < 0.5  => 0.0000223824,
                      -0.0001063501));

mod1_188 := __common__(map(
    r_i60_inq_auto_recency_d = NULL => -0.0000101634,
    r_i60_inq_auto_recency_d < 9    => -0.0001844933,
                      0.0000100094));

mod1_189 := __common__(map(
    r_i60_inq_banking_recency_d = NULL => -0.0000142649,
    r_i60_inq_banking_recency_d < 18   => 0.0000899990,
        -0.0000396210));

mod1_190 := __common__(map(
    r_i60_inq_comm_recency_d = NULL => -0.0016819264,
    r_i60_inq_comm_recency_d < 2    => 0.3141835051,
    r_i60_inq_comm_recency_d < 4.5  => 0.0718429329,
    r_i60_inq_comm_recency_d < 9    => 0.0150995410,
    r_i60_inq_comm_recency_d < 549  => 0.0132692493,
                      -0.0072084315));

mod1_191 := __common__(map(
    r_i60_inq_count12_i = NULL => -0.0000562433,
    r_i60_inq_count12_i < 0.5  => -0.0004949194,
    r_i60_inq_count12_i < 15.5 => 0.0002094054,
                 0.0006371730));

mod1_192 := __common__(map(
    r_i60_inq_hiriskcred_count12_i = NULL => -0.0026601163,
    r_i60_inq_hiriskcred_count12_i < 0.5  => -0.0116370689,
    r_i60_inq_hiriskcred_count12_i < 1.5  => -0.0105599009,
    r_i60_inq_hiriskcred_count12_i < 2.5  => 0.0089651671,
           0.0297845248));

mod1_193 := __common__(map(
    r_i60_inq_hiriskcred_recency_d = NULL => -0.0026860354,
    r_i60_inq_hiriskcred_recency_d < 2    => 0.0311606898,
    r_i60_inq_hiriskcred_recency_d < 4.5  => 0.0200271340,
    r_i60_inq_hiriskcred_recency_d < 9    => -0.0112398346,
    r_i60_inq_hiriskcred_recency_d < 18   => -0.0126258064,
           -0.0133719142));

mod1_194 := __common__(map(
    r_i60_inq_mortgage_recency_d = NULL => -0.0000640239,
    r_i60_inq_mortgage_recency_d < 549  => -0.0021256982,
         0.0003765208));

mod1_195 := __common__(map(
    r_i60_inq_prepaidcards_recency_d = NULL => 0.0000124245,
    r_i60_inq_prepaidcards_recency_d < 549  => 0.0003306398,
             -0.0000107707));

mod1_196 := __common__(map(
    r_i60_inq_recency_d = NULL => -0.0004685927,
    r_i60_inq_recency_d < 2    => 0.0027278543,
    r_i60_inq_recency_d < 9    => 0.0025915470,
    r_i60_inq_recency_d < 18   => 0.0019404597,
    r_i60_inq_recency_d < 61.5 => 0.0016498417,
    r_i60_inq_recency_d < 549  => -0.0094485698,
                 -0.0120868311));

mod1_197 := __common__(map(
    r_i60_inq_retail_recency_d = NULL => -0.0001689513,
    r_i60_inq_retail_recency_d < 2    => 0.0094723953,
    r_i60_inq_retail_recency_d < 549  => -0.0183277276,
       0.0047709249));

mod1_198 := __common__(map(
    r_i61_inq_collection_count12_i = NULL => -0.0001980794,
    r_i61_inq_collection_count12_i < 0.5  => -0.0015000194,
           0.0050948713));

mod1_199 := __common__(map(
    r_i61_inq_collection_recency_d = NULL => -0.0018103418,
    r_i61_inq_collection_recency_d < 4.5  => 0.0566874767,
    r_i61_inq_collection_recency_d < 9    => 0.0342869942,
    r_i61_inq_collection_recency_d < 18   => 0.0180503531,
    r_i61_inq_collection_recency_d < 61.5 => 0.0126959373,
    r_i61_inq_collection_recency_d < 549  => -0.0132731147,
           -0.0197228343));

mod1_200 := __common__(map(
    r_l70_add_standardized_i = NULL => 0.0000119444,
    r_l70_add_standardized_i < 0.5  => -0.0000122678,
                      0.0001089687));

mod1_201 := __common__(map(
    r_l79_adls_per_addr_c6_i = NULL => -0.0011050813,
    r_l79_adls_per_addr_c6_i < 1.5  => -0.0096641480,
    r_l79_adls_per_addr_c6_i < 2.5  => 0.0196876967,
    r_l79_adls_per_addr_c6_i < 3.5  => 0.0205611185,
    r_l79_adls_per_addr_c6_i < 4.5  => 0.0215401665,
    r_l79_adls_per_addr_c6_i < 8.5  => 0.0220292537,
                      0.0225177869));

mod1_202 := __common__(map(
    r_l79_adls_per_addr_curr_i = NULL => 0.0000067878,
    r_l79_adls_per_addr_curr_i < 4.5  => -0.0000667456,
    r_l79_adls_per_addr_curr_i < 9.5  => 0.0002662872,
       -0.0005311441));

mod1_203 := __common__(map(
    r_l80_inp_avm_autoval_d = NULL     => 0.0004762136,
    r_l80_inp_avm_autoval_d < 51687.5  => -0.0003438670,
    r_l80_inp_avm_autoval_d < 73751.5  => 0.0002277918,
    r_l80_inp_avm_autoval_d < 108693   => 0.0005580591,
    r_l80_inp_avm_autoval_d < 161028.5 => 0.0004296726,
    r_l80_inp_avm_autoval_d < 199014   => 0.0001928775,
    r_l80_inp_avm_autoval_d < 218090.5 => -0.0000187738,
    r_l80_inp_avm_autoval_d < 218111   => -0.0002070027,
    r_l80_inp_avm_autoval_d < 258709.5 => -0.0003982280,
        -0.0006246787));

mod1_204 := __common__(map(
    r_p88_phn_dst_to_inp_add_i = NULL  => 0.0022686575,
    r_p88_phn_dst_to_inp_add_i < 0.5   => -0.0021014782,
    r_p88_phn_dst_to_inp_add_i < 1.5   => -0.0012144473,
    r_p88_phn_dst_to_inp_add_i < 36.5  => 0.0015752994,
    r_p88_phn_dst_to_inp_add_i < 341.5 => 0.0012607554,
    r_p88_phn_dst_to_inp_add_i < 383.5 => 0.0014923711,
        0.0020704740));

mod1_205 := __common__(map(
    r_prop_owner_history_d = NULL => -0.0000845061,
    r_prop_owner_history_d < 1.5  => 0.0004256537,
                    -0.0005439257));

mod1_206 := __common__(map(
    r_wealth_index_d = NULL => -0.0023157302,
    r_wealth_index_d < 3.5  => 0.0299311111,
    r_wealth_index_d < 4.5  => 0.0047744911,
              -0.0368234519));

mod1_lgt := mod1__0 +
    mod1_1 +
    mod1_2 +
    mod1_3 +
    mod1_4 +
    mod1_5 +
    mod1_6 +
    mod1_7 +
    mod1_8 +
    mod1_9 +
    mod1_10 +
    mod1_11 +
    mod1_12 +
    mod1_13 +
    mod1_14 +
    mod1_15 +
    mod1_16 +
    mod1_17 +
    mod1_18 +
    mod1_19 +
    mod1_20 +
    mod1_21 +
    mod1_22 +
    mod1_23 +
    mod1_24 +
    mod1_25 +
    mod1_26 +
    mod1_27 +
    mod1_28 +
    mod1_29 +
    mod1_30 +
    mod1_31 +
    mod1_32 +
    mod1_33 +
    mod1_34 +
    mod1_35 +
    mod1_36 +
    mod1_37 +
    mod1_38 +
    mod1_39 +
    mod1_40 +
    mod1_41 +
    mod1_42 +
    mod1_43 +
    mod1_44 +
    mod1_45 +
    mod1_46 +
    mod1_47 +
    mod1_48 +
    mod1_49 +
    mod1_50 +
    mod1_51 +
    mod1_52 +
    mod1_53 +
    mod1_54 +
    mod1_55 +
    mod1_56 +
    mod1_57 +
    mod1_58 +
    mod1_59 +
    mod1_60 +
    mod1_61 +
    mod1_62 +
    mod1_63 +
    mod1_64 +
    mod1_65 +
    mod1_66 +
    mod1_67 +
    mod1_68 +
    mod1_69 +
    mod1_70 +
    mod1_71 +
    mod1_72 +
    mod1_73 +
    mod1_74 +
    mod1_75 +
    mod1_76 +
    mod1_77 +
    mod1_78 +
    mod1_79 +
    mod1_80 +
    mod1_81 +
    mod1_82 +
    mod1_83 +
    mod1_84 +
    mod1_85 +
    mod1_86 +
    mod1_87 +
    mod1_88 +
    mod1_89 +
    mod1_90 +
    mod1_91 +
    mod1_92 +
    mod1_93 +
    mod1_94 +
    mod1_95 +
    mod1_96 +
    mod1_97 +
    mod1_98 +
    mod1_99 +
    mod1_100 +
    mod1_101 +
    mod1_102 +
    mod1_103 +
    mod1_104 +
    mod1_105 +
    mod1_106 +
    mod1_107 +
    mod1_108 +
    mod1_109 +
    mod1_110 +
    mod1_111 +
    mod1_112 +
    mod1_113 +
    mod1_114 +
    mod1_115 +
    mod1_116 +
    mod1_117 +
    mod1_118 +
    mod1_119 +
    mod1_120 +
    mod1_121 +
    mod1_122 +
    mod1_123 +
    mod1_124 +
    mod1_125 +
    mod1_126 +
    mod1_127 +
    mod1_128 +
    mod1_129 +
    mod1_130 +
    mod1_131 +
    mod1_132 +
    mod1_133 +
    mod1_134 +
    mod1_135 +
    mod1_136 +
    mod1_137 +
    mod1_138 +
    mod1_139 +
    mod1_140 +
    mod1_141 +
    mod1_142 +
    mod1_143 +
    mod1_144 +
    mod1_145 +
    mod1_146 +
    mod1_147 +
    mod1_148 +
    mod1_149 +
    mod1_150 +
    mod1_151 +
    mod1_152 +
    mod1_153 +
    mod1_154 +
    mod1_155 +
    mod1_156 +
    mod1_157 +
    mod1_158 +
    mod1_159 +
    mod1_160 +
    mod1_161 +
    mod1_162 +
    mod1_163 +
    mod1_164 +
    mod1_165 +
    mod1_166 +
    mod1_167 +
    mod1_168 +
    mod1_169 +
    mod1_170 +
    mod1_171 +
    mod1_172 +
    mod1_173 +
    mod1_174 +
    mod1_175 +
    mod1_176 +
    mod1_177 +
    mod1_178 +
    mod1_179 +
    mod1_180 +
    mod1_181 +
    mod1_182 +
    mod1_183 +
    mod1_184 +
    mod1_185 +
    mod1_186 +
    mod1_187 +
    mod1_188 +
    mod1_189 +
    mod1_190 +
    mod1_191 +
    mod1_192 +
    mod1_193 +
    mod1_194 +
    mod1_195 +
    mod1_196 +
    mod1_197 +
    mod1_198 +
    mod1_199 +
    mod1_200 +
    mod1_201 +
    mod1_202 +
    mod1_203 +
    mod1_204 +
    mod1_205 +
    mod1_206;

pbr := 0.02477127;

sbr := 0.10011810;

offset := ln(((1 - pbr) * sbr) / (pbr * (1 - sbr)));

base := 900;

pts := -125;

lgt := ln(0.0248 / 0.9752);

fp1606_1_0 := round(max((real)300, min(999, if(base + pts * (mod1_lgt - offset - lgt) / ln(2) = NULL, -NULL, base + pts * (mod1_lgt - offset - lgt) / ln(2)))));

_ver_src_ds := Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0;

_ver_src_de := Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0;

_ver_src_eq := Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0;

_ver_src_en := Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0;

_ver_src_tn := Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0;

_ver_src_tu := Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0;

_credit_source_cnt := if(max((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu) = NULL, NULL, sum((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu));

_ver_src_cnt := Models.Common.countw((string)(ver_sources));

_bureauonly := _credit_source_cnt > 0 AND _credit_source_cnt = _ver_src_cnt AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6]));

_derog := felony_count > 0 OR (Integer)addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2;

_deceased := rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de;

_ssnpriortodob := rc_ssndobflag = '1' OR rc_pwssndobflag = '1';

_inputmiskeys := rc_ssnmiskeyflag or rc_addrmiskeyflag or (Integer)add_input_house_number_match = 0;

_multiplessns := ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1;

_hh_strikes := if((Integer)max((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0) = NULL, NULL, (Integer)sum((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0));

stolenid := if(addrpop and (nas_summary in [4, 7, 9]) or fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9' or _deceased or _ssnpriortodob, 1, 0);

manipulatedid := if(_inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1), 1, 0);

manipulatedidpt2 := if(1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9', 1, 0);

syntheticid := if(fnamepop and lnamepop and addrpop and ssnlength = '9' and hphnpop and nap_summary <= 4 and nas_summary <= 4 or _ver_src_cnt = 0 or _bureauonly or (Integer)add_curr_pop = 0, 1, 0);

suspiciousactivity := if(_derog, 1, 0);

vulnerablevictim := if(0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70, 1, 0);

friendlyfraud := if(hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2), 1, 0);

stolenc_fp1606_1_0 := if((Boolean)(Integer)stolenid, fp1606_1_0, 299);

manip2c_fp1606_1_0 := if((boolean)(integer)manipulatedid or (boolean)(integer)manipulatedidpt2, fp1606_1_0, 299);

synthc_fp1606_1_0 := if((Boolean)(Integer)syntheticid, fp1606_1_0, 299);

suspactc_fp1606_1_0 := if((Boolean)(Integer)suspiciousactivity, fp1606_1_0, 299);

vulnvicc_fp1606_1_0 := if((Boolean)(Integer)vulnerablevictim, fp1606_1_0, 299);

friendlyc_fp1606_1_0 := if((Boolean)(Integer)friendlyfraud, fp1606_1_0, 299);

custstolidindex := map(
    stolenc_fp1606_1_0 = 299               => 1,
    300 <= stolenc_fp1606_1_0 AND stolenc_fp1606_1_0 <= 590 => 9,
    590 < stolenc_fp1606_1_0 AND stolenc_fp1606_1_0 <= 620  => 8,
    620 < stolenc_fp1606_1_0 AND stolenc_fp1606_1_0 <= 650  => 7,
    650 < stolenc_fp1606_1_0 AND stolenc_fp1606_1_0 <= 680  => 6,
    680 < stolenc_fp1606_1_0 AND stolenc_fp1606_1_0 <= 710  => 5,
    710 < stolenc_fp1606_1_0 AND stolenc_fp1606_1_0 <= 740  => 4,
    740 < stolenc_fp1606_1_0 AND stolenc_fp1606_1_0 <= 770  => 3,
    770 < stolenc_fp1606_1_0 AND stolenc_fp1606_1_0 <= 999  => 2,
            99);

custmanipidindex := map(
    manip2c_fp1606_1_0 = 299               => 1,
    300 <= manip2c_fp1606_1_0 AND manip2c_fp1606_1_0 <= 570 => 9,
    570 < manip2c_fp1606_1_0 AND manip2c_fp1606_1_0 <= 615  => 8,
    615 < manip2c_fp1606_1_0 AND manip2c_fp1606_1_0 <= 635  => 7,
    635 < manip2c_fp1606_1_0 AND manip2c_fp1606_1_0 <= 655  => 6,
    655 < manip2c_fp1606_1_0 AND manip2c_fp1606_1_0 <= 680  => 5,
    680 < manip2c_fp1606_1_0 AND manip2c_fp1606_1_0 <= 710  => 4,
    710 < manip2c_fp1606_1_0 AND manip2c_fp1606_1_0 <= 730  => 3,
    730 < manip2c_fp1606_1_0 AND manip2c_fp1606_1_0 <= 999  => 2,
            99);

custsynthidindex := map(
    synthc_fp1606_1_0 = 299              => 1,
    300 <= synthc_fp1606_1_0 AND synthc_fp1606_1_0 <= 620 => 9,
    620 < synthc_fp1606_1_0 AND synthc_fp1606_1_0 <= 645  => 8,
    645 < synthc_fp1606_1_0 AND synthc_fp1606_1_0 <= 660  => 7,
    660 < synthc_fp1606_1_0 AND synthc_fp1606_1_0 <= 680  => 6,
    680 < synthc_fp1606_1_0 AND synthc_fp1606_1_0 <= 710  => 5,
    710 < synthc_fp1606_1_0 AND synthc_fp1606_1_0 <= 730  => 4,
    730 < synthc_fp1606_1_0 AND synthc_fp1606_1_0 <= 750  => 3,
    750 < synthc_fp1606_1_0 AND synthc_fp1606_1_0 <= 999  => 2,
          99);

custsuspactindex := map(
    suspactc_fp1606_1_0 = 299                => 1,
    300 <= suspactc_fp1606_1_0 AND suspactc_fp1606_1_0 <= 550 => 9,
    550 < suspactc_fp1606_1_0 AND suspactc_fp1606_1_0 <= 590  => 8,
    590 < suspactc_fp1606_1_0 AND suspactc_fp1606_1_0 <= 620  => 7,
    620 < suspactc_fp1606_1_0 AND suspactc_fp1606_1_0 <= 650  => 6,
    650 < suspactc_fp1606_1_0 AND suspactc_fp1606_1_0 <= 675  => 5,
    675 < suspactc_fp1606_1_0 AND suspactc_fp1606_1_0 <= 710  => 4,
    710 < suspactc_fp1606_1_0 AND suspactc_fp1606_1_0 <= 750  => 3,
    750 < suspactc_fp1606_1_0 AND suspactc_fp1606_1_0 <= 999  => 2,
              99);

custvulnvicindex := map(
    vulnvicc_fp1606_1_0 = 299                => 1,
    300 <= vulnvicc_fp1606_1_0 AND vulnvicc_fp1606_1_0 <= 630 => 9,
    630 < vulnvicc_fp1606_1_0 AND vulnvicc_fp1606_1_0 <= 670  => 8,
    670 < vulnvicc_fp1606_1_0 AND vulnvicc_fp1606_1_0 <= 690  => 7,
    690 < vulnvicc_fp1606_1_0 AND vulnvicc_fp1606_1_0 <= 720  => 6,
    720 < vulnvicc_fp1606_1_0 AND vulnvicc_fp1606_1_0 <= 740  => 5,
    740 < vulnvicc_fp1606_1_0 AND vulnvicc_fp1606_1_0 <= 780  => 4,
    780 < vulnvicc_fp1606_1_0 AND vulnvicc_fp1606_1_0 <= 810  => 3,
    810 < vulnvicc_fp1606_1_0 AND vulnvicc_fp1606_1_0 <= 999  => 2,
              99);

custfriendfrdindex := map(
    friendlyc_fp1606_1_0 = 299                 => 1,
    300 <= friendlyc_fp1606_1_0 AND friendlyc_fp1606_1_0 <= 590 => 9,
    590 < friendlyc_fp1606_1_0 AND friendlyc_fp1606_1_0 <= 615  => 8,
    615 < friendlyc_fp1606_1_0 AND friendlyc_fp1606_1_0 <= 635  => 7,
    635 < friendlyc_fp1606_1_0 AND friendlyc_fp1606_1_0 <= 670  => 6,
    670 < friendlyc_fp1606_1_0 AND friendlyc_fp1606_1_0 <= 690  => 5,
    690 < friendlyc_fp1606_1_0 AND friendlyc_fp1606_1_0 <= 730  => 4,
    730 < friendlyc_fp1606_1_0 AND friendlyc_fp1606_1_0 <= 770  => 3,
    770 < friendlyc_fp1606_1_0 AND friendlyc_fp1606_1_0 <= 999  => 2,
                99);
																																	 
//*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//

	#if(FP_DEBUG)
		/* Model Input Variables */
   self.sysdate         := sysdate;
   self.k_nap_phn_verd_d                 := k_nap_phn_verd_d;
   self.k_nap_fname_verd_d               := k_nap_fname_verd_d;
   self.k_inf_fname_verd_d               := k_inf_fname_verd_d;
   self.r_p88_phn_dst_to_inp_add_i       := r_p88_phn_dst_to_inp_add_i;
   self.add_ec1         := add_ec1;
   self.add_ec3         := add_ec3;
   self.add_ec4         := add_ec4;
   self.r_l70_add_standardized_i         := r_l70_add_standardized_i;
   self.r_f00_ssn_score_d                := r_f00_ssn_score_d;
   self.r_f01_inp_addr_address_score_d   := r_f01_inp_addr_address_score_d;
   self.r_d30_derog_count_i              := r_d30_derog_count_i;
   self.r_d32_criminal_count_i           := r_d32_criminal_count_i;
   self._criminal_last_date              := _criminal_last_date;
   self.r_d32_mos_since_crim_ls_d        := r_d32_mos_since_crim_ls_d;
   self._felony_last_date                := _felony_last_date;
   self.r_d32_mos_since_fel_ls_d         := r_d32_mos_since_fel_ls_d;
   self.r_d31_attr_bankruptcy_recency_d  := r_d31_attr_bankruptcy_recency_d;
   self.r_d31_bk_chapter_n               := r_d31_bk_chapter_n;
   self.r_d31_bk_filing_count_i          := r_d31_bk_filing_count_i;
   self.r_d31_bk_disposed_recent_count_i := r_d31_bk_disposed_recent_count_i;
   self.r_d33_eviction_recency_d         := r_d33_eviction_recency_d;
   self.r_d33_eviction_count_i           := r_d33_eviction_count_i;
   self.r_d34_unrel_liens_ct_i           := r_d34_unrel_liens_ct_i;
   self.r_d34_unrel_lien60_count_i       := r_d34_unrel_lien60_count_i;
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
   self.r_c12_num_nonderogs_d            := r_c12_num_nonderogs_d;
   self._in_dob         := _in_dob;
   self.yr_in_dob       := yr_in_dob;
   self.yr_in_dob_int   := yr_in_dob_int;
   self.k_comb_age_d    := k_comb_age_d;
   self.r_a44_curr_add_naprop_d          := r_a44_curr_add_naprop_d;
   self.r_l80_inp_avm_autoval_d          := r_l80_inp_avm_autoval_d;
   self.r_a46_curr_avm_autoval_d         := r_a46_curr_avm_autoval_d;
   self.r_a49_curr_avm_chg_1yr_i         := r_a49_curr_avm_chg_1yr_i;
   self.r_a49_curr_avm_chg_1yr_pct_i     := r_a49_curr_avm_chg_1yr_pct_i;
   self.r_c13_curr_addr_lres_d           := r_c13_curr_addr_lres_d;
   self.r_c13_max_lres_d                 := r_c13_max_lres_d;
   self.r_c14_addrs_5yr_i                := r_c14_addrs_5yr_i;
   self.r_c14_addrs_10yr_i               := r_c14_addrs_10yr_i;
   self.r_c14_addrs_per_adl_c6_i         := r_c14_addrs_per_adl_c6_i;
   self.r_c14_addrs_15yr_i               := r_c14_addrs_15yr_i;
   self.r_prop_owner_history_d           := r_prop_owner_history_d;
   self.r_a43_watercraft_cnt_d           := r_a43_watercraft_cnt_d;
   self.r_ever_asset_owner_d             := r_ever_asset_owner_d;
   self.r_c20_email_domain_free_count_i  := r_c20_email_domain_free_count_i;
   self.r_c20_email_domain_isp_count_i   := r_c20_email_domain_isp_count_i;
   self.r_e57_prof_license_flag_d        := r_e57_prof_license_flag_d;
   self.r_l79_adls_per_addr_curr_i       := r_l79_adls_per_addr_curr_i;
   self.r_l79_adls_per_addr_c6_i         := r_l79_adls_per_addr_c6_i;
   self.r_i60_inq_count12_i              := r_i60_inq_count12_i;
   self.r_i60_inq_recency_d              := r_i60_inq_recency_d;
   self.r_i61_inq_collection_count12_i   := r_i61_inq_collection_count12_i;
   self.r_i61_inq_collection_recency_d   := r_i61_inq_collection_recency_d;
   self.r_i60_inq_auto_count12_i         := r_i60_inq_auto_count12_i;
   self.r_i60_inq_auto_recency_d         := r_i60_inq_auto_recency_d;
   self.r_i60_inq_banking_recency_d      := r_i60_inq_banking_recency_d;
   self.r_i60_inq_mortgage_recency_d     := r_i60_inq_mortgage_recency_d;
   self.r_i60_inq_hiriskcred_count12_i   := r_i60_inq_hiriskcred_count12_i;
   self.r_i60_inq_hiriskcred_recency_d   := r_i60_inq_hiriskcred_recency_d;
   self.r_i60_inq_retail_recency_d       := r_i60_inq_retail_recency_d;
   self.r_i60_inq_comm_recency_d         := r_i60_inq_comm_recency_d;
   self.f_util_adl_count_n               := f_util_adl_count_n;
   self.f_util_add_input_conv_n          := f_util_add_input_conv_n;
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
   self.f_inq_banking_count24_i          := f_inq_banking_count24_i;
   self.f_inq_collection_count24_i       := f_inq_collection_count24_i;
   self.f_inq_communications_count24_i   := f_inq_communications_count24_i;
   self.f_inq_highriskcredit_count24_i   := f_inq_highriskcredit_count24_i;
   self.f_inq_other_count24_i            := f_inq_other_count24_i;
   self.f_inq_retail_count24_i           := f_inq_retail_count24_i;
   self.k_inq_per_ssn_i                  := k_inq_per_ssn_i;
   self.k_inq_dobs_per_ssn_i             := k_inq_dobs_per_ssn_i;
   self.k_inq_per_addr_i                 := k_inq_per_addr_i;
   self.k_inq_per_phone_i                := k_inq_per_phone_i;
   self.k_inq_adls_per_phone_i           := k_inq_adls_per_phone_i;
   self.f_attr_arrests_i                 := f_attr_arrests_i;
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
   self._liens_unrel_ft_first_seen       := _liens_unrel_ft_first_seen;
   self.f_mos_liens_unrel_ft_fseen_d     := f_mos_liens_unrel_ft_fseen_d;
   self._liens_unrel_ft_last_seen        := _liens_unrel_ft_last_seen;
   self.f_mos_liens_unrel_ft_lseen_d     := f_mos_liens_unrel_ft_lseen_d;
   self.f_liens_unrel_ft_total_amt_i     := f_liens_unrel_ft_total_amt_i;
   self._liens_rel_ft_first_seen         := _liens_rel_ft_first_seen;
   self.f_mos_liens_rel_ft_fseen_d       := f_mos_liens_rel_ft_fseen_d;
   self._liens_rel_ft_last_seen          := _liens_rel_ft_last_seen;
   self.f_mos_liens_rel_ft_lseen_d       := f_mos_liens_rel_ft_lseen_d;
   self._liens_unrel_ot_first_seen       := _liens_unrel_ot_first_seen;
   self.f_mos_liens_unrel_ot_fseen_d     := f_mos_liens_unrel_ot_fseen_d;
   self._liens_unrel_ot_last_seen        := _liens_unrel_ot_last_seen;
   self.f_mos_liens_unrel_ot_lseen_d     := f_mos_liens_unrel_ot_lseen_d;
   self.f_liens_unrel_ot_total_amt_i     := f_liens_unrel_ot_total_amt_i;
   self._liens_rel_ot_first_seen         := _liens_rel_ot_first_seen;
   self.f_mos_liens_rel_ot_fseen_d       := f_mos_liens_rel_ot_fseen_d;
   self._liens_rel_ot_last_seen          := _liens_rel_ot_last_seen;
   self.f_mos_liens_rel_ot_lseen_d       := f_mos_liens_rel_ot_lseen_d;
   self.f_liens_rel_ot_total_amt_i       := f_liens_rel_ot_total_amt_i;
   self._liens_unrel_sc_first_seen       := _liens_unrel_sc_first_seen;
   self.f_mos_liens_unrel_sc_fseen_d     := f_mos_liens_unrel_sc_fseen_d;
   self.f_liens_unrel_sc_total_amt_i     := f_liens_unrel_sc_total_amt_i;
   self._foreclosure_last_date           := _foreclosure_last_date;
   self.f_mos_foreclosure_lseen_d        := f_mos_foreclosure_lseen_d;
   self.k_estimated_income_d             := k_estimated_income_d;
   self.r_wealth_index_d                 := r_wealth_index_d;
   self.f_rel_count_i   := f_rel_count_i;
   self.f_rel_incomeover25_count_d       := f_rel_incomeover25_count_d;
   self.f_rel_incomeover50_count_d       := f_rel_incomeover50_count_d;
   self.f_rel_incomeover75_count_d       := f_rel_incomeover75_count_d;
   self.f_rel_homeover50_count_d         := f_rel_homeover50_count_d;
   self.f_rel_homeover100_count_d        := f_rel_homeover100_count_d;
   self.f_rel_homeover150_count_d        := f_rel_homeover150_count_d;
   self.f_rel_homeover200_count_d        := f_rel_homeover200_count_d;
   self.f_rel_homeover300_count_d        := f_rel_homeover300_count_d;
   self.f_rel_homeover500_count_d        := f_rel_homeover500_count_d;
   self.f_rel_ageover20_count_d          := f_rel_ageover20_count_d;
   self.f_rel_ageover30_count_d          := f_rel_ageover30_count_d;
   self.f_rel_ageover40_count_d          := f_rel_ageover40_count_d;
   self.f_rel_educationover8_count_d     := f_rel_educationover8_count_d;
   self.f_rel_educationover12_count_d    := f_rel_educationover12_count_d;
   self.f_crim_rel_under25miles_cnt_i    := f_crim_rel_under25miles_cnt_i;
   self.f_crim_rel_under100miles_cnt_i   := f_crim_rel_under100miles_cnt_i;
   self.f_rel_under25miles_cnt_d         := f_rel_under25miles_cnt_d;
   self.f_rel_under100miles_cnt_d        := f_rel_under100miles_cnt_d;
   self.f_rel_under500miles_cnt_d        := f_rel_under500miles_cnt_d;
   self.f_rel_bankrupt_count_i           := f_rel_bankrupt_count_i;
   self.f_rel_criminal_count_i           := f_rel_criminal_count_i;
   self.f_historical_count_d             := f_historical_count_d;
   self.f_accident_count_i               := f_accident_count_i;
   self._acc_last_seen                   := _acc_last_seen;
   self.f_mos_acc_lseen_d                := f_mos_acc_lseen_d;
   self.f_acc_damage_amt_last_6mos_i     := f_acc_damage_amt_last_6mos_i;
   self.f_accident_recency_d             := f_accident_recency_d;
   self.f_idverrisktype_i                := f_idverrisktype_i;
   self.f_sourcerisktype_i               := f_sourcerisktype_i;
   self.f_varrisktype_i                  := f_varrisktype_i;
   self.f_vardobcount_i                  := f_vardobcount_i;
   self.f_srchvelocityrisktype_i         := f_srchvelocityrisktype_i;
   self.f_srchunvrfdssncount_i           := f_srchunvrfdssncount_i;
   self.f_srchunvrfddobcount_i           := f_srchunvrfddobcount_i;
   self.f_srchunvrfdphonecount_i         := f_srchunvrfdphonecount_i;
   self.f_srchfraudsrchcountyr_i         := f_srchfraudsrchcountyr_i;
   self.f_srchfraudsrchcountmo_i         := f_srchfraudsrchcountmo_i;
   self.f_srchfraudsrchcountwk_i         := f_srchfraudsrchcountwk_i;
   self.f_assocrisktype_i                := f_assocrisktype_i;
   self.f_assoccredbureaucount_i         := f_assoccredbureaucount_i;
   self.f_assoccredbureaucountnew_i      := f_assoccredbureaucountnew_i;
   self.f_divrisktype_i                  := f_divrisktype_i;
   self.f_divaddrsuspidcountnew_i        := f_divaddrsuspidcountnew_i;
   self.f_divsrchaddrsuspidcount_i       := f_divsrchaddrsuspidcount_i;
   self.f_srchcomponentrisktype_i        := f_srchcomponentrisktype_i;
   self.f_srchssnsrchcountmo_i           := f_srchssnsrchcountmo_i;
   self.f_srchssnsrchcountwk_i           := f_srchssnsrchcountwk_i;
   self.f_srchaddrsrchcountmo_i          := f_srchaddrsrchcountmo_i;
   self.f_srchaddrsrchcountwk_i          := f_srchaddrsrchcountwk_i;
   self.f_srchphonesrchcountmo_i         := f_srchphonesrchcountmo_i;
   self.f_srchphonesrchcountwk_i         := f_srchphonesrchcountwk_i;
   self.f_componentcharrisktype_i        := f_componentcharrisktype_i;
   self.f_addrchangeincomediff_d         := f_addrchangeincomediff_d;
   self.f_addrchangevaluediff_d          := f_addrchangevaluediff_d;
   self.f_addrchangecrimediff_i          := f_addrchangecrimediff_i;
   self.f_addrchangeecontrajindex_d      := f_addrchangeecontrajindex_d;
   self.f_curraddrmedianincome_d         := f_curraddrmedianincome_d;
   self.f_curraddrmedianvalue_d          := f_curraddrmedianvalue_d;
   self.f_curraddrmurderindex_i          := f_curraddrmurderindex_i;
   self.f_curraddrcartheftindex_i        := f_curraddrcartheftindex_i;
   self.f_curraddrburglaryindex_i        := f_curraddrburglaryindex_i;
   self.f_curraddrcrimeindex_i           := f_curraddrcrimeindex_i;
   self.f_prevaddrageoldest_d            := f_prevaddrageoldest_d;
   self.f_prevaddrlenofres_d             := f_prevaddrlenofres_d;
   self.f_prevaddrstatus_i               := f_prevaddrstatus_i;
   self.f_prevaddrmedianincome_d         := f_prevaddrmedianincome_d;
   self.f_prevaddrmedianvalue_d          := f_prevaddrmedianvalue_d;
   self.f_prevaddrmurderindex_i          := f_prevaddrmurderindex_i;
   self.f_prevaddrcartheftindex_i        := f_prevaddrcartheftindex_i;
   self.f_fp_prevaddrburglaryindex_i     := f_fp_prevaddrburglaryindex_i;
   self.f_fp_prevaddrcrimeindex_i        := f_fp_prevaddrcrimeindex_i;
   self.r_c12_source_profile_d           := r_c12_source_profile_d;
   self.r_c23_inp_addr_occ_index_d       := r_c23_inp_addr_occ_index_d;
   self.r_c23_inp_addr_owned_not_occ_d   := r_c23_inp_addr_owned_not_occ_d;
   self.r_e55_college_ind_d              := r_e55_college_ind_d;
   self.r_e57_br_source_count_d          := r_e57_br_source_count_d;
   self.r_i60_inq_prepaidcards_recency_d := r_i60_inq_prepaidcards_recency_d;
   self.f_phone_ver_experian_d           := f_phone_ver_experian_d;
   self.f_addrs_per_ssn_i                := f_addrs_per_ssn_i;
   self.f_phones_per_addr_curr_i         := f_phones_per_addr_curr_i;
   self.f_phones_per_addr_c6_i           := f_phones_per_addr_c6_i;
   self.f_inq_email_ver_count_i          := f_inq_email_ver_count_i;
   self.f_inq_highriskcredit_cnt_day_i   := f_inq_highriskcredit_cnt_day_i;
   self.f_inq_highriskcredit_cnt_week_i  := f_inq_highriskcredit_cnt_week_i;
   self.f_adl_per_email_i                := f_adl_per_email_i;
   self.r_c20_email_verification_d       := r_c20_email_verification_d;
   self._liens_rel_sc_first_seen         := _liens_rel_sc_first_seen;
   self.f_mos_liens_rel_sc_fseen_d       := f_mos_liens_rel_sc_fseen_d;
   self._liens_rel_sc_last_seen          := _liens_rel_sc_last_seen;
   self.f_mos_liens_rel_sc_lseen_d       := f_mos_liens_rel_sc_lseen_d;
   self.f_liens_rel_sc_total_amt_i       := f_liens_rel_sc_total_amt_i;
   self.f_liens_unrel_st_ct_i            := f_liens_unrel_st_ct_i;
   self._liens_unrel_st_last_seen        := _liens_unrel_st_last_seen;
   self.f_mos_liens_unrel_st_lseen_d     := f_mos_liens_unrel_st_lseen_d;
   self.f_property_owners_ct_d           := f_property_owners_ct_d;
   self.f_hh_age_30_plus_d               := f_hh_age_30_plus_d;
   self.f_hh_collections_ct_i            := f_hh_collections_ct_i;
   self.f_hh_payday_loan_users_i         := f_hh_payday_loan_users_i;
   self.f_hh_members_w_derog_i           := f_hh_members_w_derog_i;
   self.f_hh_tot_derog_i                 := f_hh_tot_derog_i;
   self.f_hh_bankruptcies_i              := f_hh_bankruptcies_i;
   self.f_hh_lienholders_i               := f_hh_lienholders_i;
   self.f_hh_prof_license_holders_d      := f_hh_prof_license_holders_d;
   self.f_hh_college_attendees_d         := f_hh_college_attendees_d;
   self.nf_seg_fraudpoint_3_0            := nf_seg_fraudpoint_3_0;
   self.mod1__0         := mod1__0;
   self.mod1_1          := mod1_1;
   self.mod1_2          := mod1_2;
   self.mod1_3          := mod1_3;
   self.mod1_4          := mod1_4;
   self.mod1_5          := mod1_5;
   self.mod1_6          := mod1_6;
   self.mod1_7          := mod1_7;
   self.mod1_8          := mod1_8;
   self.mod1_9          := mod1_9;
   self.mod1_10         := mod1_10;
   self.mod1_11         := mod1_11;
   self.mod1_12         := mod1_12;
   self.mod1_13         := mod1_13;
   self.mod1_14         := mod1_14;
   self.mod1_15         := mod1_15;
   self.mod1_16         := mod1_16;
   self.mod1_17         := mod1_17;
   self.mod1_18         := mod1_18;
   self.mod1_19         := mod1_19;
   self.mod1_20         := mod1_20;
   self.mod1_21         := mod1_21;
   self.mod1_22         := mod1_22;
   self.mod1_23         := mod1_23;
   self.mod1_24         := mod1_24;
   self.mod1_25         := mod1_25;
   self.mod1_26         := mod1_26;
   self.mod1_27         := mod1_27;
   self.mod1_28         := mod1_28;
   self.mod1_29         := mod1_29;
   self.mod1_30         := mod1_30;
   self.mod1_31         := mod1_31;
   self.mod1_32         := mod1_32;
   self.mod1_33         := mod1_33;
   self.mod1_34         := mod1_34;
   self.mod1_35         := mod1_35;
   self.mod1_36         := mod1_36;
   self.mod1_37         := mod1_37;
   self.mod1_38         := mod1_38;
   self.mod1_39         := mod1_39;
   self.mod1_40         := mod1_40;
   self.mod1_41         := mod1_41;
   self.mod1_42         := mod1_42;
   self.mod1_43         := mod1_43;
   self.mod1_44         := mod1_44;
   self.mod1_45         := mod1_45;
   self.mod1_46         := mod1_46;
   self.mod1_47         := mod1_47;
   self.mod1_48         := mod1_48;
   self.mod1_49         := mod1_49;
   self.mod1_50         := mod1_50;
   self.mod1_51         := mod1_51;
   self.mod1_52         := mod1_52;
   self.mod1_53         := mod1_53;
   self.mod1_54         := mod1_54;
   self.mod1_55         := mod1_55;
   self.mod1_56         := mod1_56;
   self.mod1_57         := mod1_57;
   self.mod1_58         := mod1_58;
   self.mod1_59         := mod1_59;
   self.mod1_60         := mod1_60;
   self.mod1_61         := mod1_61;
   self.mod1_62         := mod1_62;
   self.mod1_63         := mod1_63;
   self.mod1_64         := mod1_64;
   self.mod1_65         := mod1_65;
   self.mod1_66         := mod1_66;
   self.mod1_67         := mod1_67;
   self.mod1_68         := mod1_68;
   self.mod1_69         := mod1_69;
   self.mod1_70         := mod1_70;
   self.mod1_71         := mod1_71;
   self.mod1_72         := mod1_72;
   self.mod1_73         := mod1_73;
   self.mod1_74         := mod1_74;
   self.mod1_75         := mod1_75;
   self.mod1_76         := mod1_76;
   self.mod1_77         := mod1_77;
   self.mod1_78         := mod1_78;
   self.mod1_79         := mod1_79;
   self.mod1_80         := mod1_80;
   self.mod1_81         := mod1_81;
   self.mod1_82         := mod1_82;
   self.mod1_83         := mod1_83;
   self.mod1_84         := mod1_84;
   self.mod1_85         := mod1_85;
   self.mod1_86         := mod1_86;
   self.mod1_87         := mod1_87;
   self.mod1_88         := mod1_88;
   self.mod1_89         := mod1_89;
   self.mod1_90         := mod1_90;
   self.mod1_91         := mod1_91;
   self.mod1_92         := mod1_92;
   self.mod1_93         := mod1_93;
   self.mod1_94         := mod1_94;
   self.mod1_95         := mod1_95;
   self.mod1_96         := mod1_96;
   self.mod1_97         := mod1_97;
   self.mod1_98         := mod1_98;
   self.mod1_99         := mod1_99;
   self.mod1_100        := mod1_100;
   self.mod1_101        := mod1_101;
   self.mod1_102        := mod1_102;
   self.mod1_103        := mod1_103;
   self.mod1_104        := mod1_104;
   self.mod1_105        := mod1_105;
   self.mod1_106        := mod1_106;
   self.mod1_107        := mod1_107;
   self.mod1_108        := mod1_108;
   self.mod1_109        := mod1_109;
   self.mod1_110        := mod1_110;
   self.mod1_111        := mod1_111;
   self.mod1_112        := mod1_112;
   self.mod1_113        := mod1_113;
   self.mod1_114        := mod1_114;
   self.mod1_115        := mod1_115;
   self.mod1_116        := mod1_116;
   self.mod1_117        := mod1_117;
   self.mod1_118        := mod1_118;
   self.mod1_119        := mod1_119;
   self.mod1_120        := mod1_120;
   self.mod1_121        := mod1_121;
   self.mod1_122        := mod1_122;
   self.mod1_123        := mod1_123;
   self.mod1_124        := mod1_124;
   self.mod1_125        := mod1_125;
   self.mod1_126        := mod1_126;
   self.mod1_127        := mod1_127;
   self.mod1_128        := mod1_128;
   self.mod1_129        := mod1_129;
   self.mod1_130        := mod1_130;
   self.mod1_131        := mod1_131;
   self.mod1_132        := mod1_132;
   self.mod1_133        := mod1_133;
   self.mod1_134        := mod1_134;
   self.mod1_135        := mod1_135;
   self.mod1_136        := mod1_136;
   self.mod1_137        := mod1_137;
   self.mod1_138        := mod1_138;
   self.mod1_139        := mod1_139;
   self.mod1_140        := mod1_140;
   self.mod1_141        := mod1_141;
   self.mod1_142        := mod1_142;
   self.mod1_143        := mod1_143;
   self.mod1_144        := mod1_144;
   self.mod1_145        := mod1_145;
   self.mod1_146        := mod1_146;
   self.mod1_147        := mod1_147;
   self.mod1_148        := mod1_148;
   self.mod1_149        := mod1_149;
   self.mod1_150        := mod1_150;
   self.mod1_151        := mod1_151;
   self.mod1_152        := mod1_152;
   self.mod1_153        := mod1_153;
   self.mod1_154        := mod1_154;
   self.mod1_155        := mod1_155;
   self.mod1_156        := mod1_156;
   self.mod1_157        := mod1_157;
   self.mod1_158        := mod1_158;
   self.mod1_159        := mod1_159;
   self.mod1_160        := mod1_160;
   self.mod1_161        := mod1_161;
   self.mod1_162        := mod1_162;
   self.mod1_163        := mod1_163;
   self.mod1_164        := mod1_164;
   self.mod1_165        := mod1_165;
   self.mod1_166        := mod1_166;
   self.mod1_167        := mod1_167;
   self.mod1_168        := mod1_168;
   self.mod1_169        := mod1_169;
   self.mod1_170        := mod1_170;
   self.mod1_171        := mod1_171;
   self.mod1_172        := mod1_172;
   self.mod1_173        := mod1_173;
   self.mod1_174        := mod1_174;
   self.mod1_175        := mod1_175;
   self.mod1_176        := mod1_176;
   self.mod1_177        := mod1_177;
   self.mod1_178        := mod1_178;
   self.mod1_179        := mod1_179;
   self.mod1_180        := mod1_180;
   self.mod1_181        := mod1_181;
   self.mod1_182        := mod1_182;
   self.mod1_183        := mod1_183;
   self.mod1_184        := mod1_184;
   self.mod1_185        := mod1_185;
   self.mod1_186        := mod1_186;
   self.mod1_187        := mod1_187;
   self.mod1_188        := mod1_188;
   self.mod1_189        := mod1_189;
   self.mod1_190        := mod1_190;
   self.mod1_191        := mod1_191;
   self.mod1_192        := mod1_192;
   self.mod1_193        := mod1_193;
   self.mod1_194        := mod1_194;
   self.mod1_195        := mod1_195;
   self.mod1_196        := mod1_196;
   self.mod1_197        := mod1_197;
   self.mod1_198        := mod1_198;
   self.mod1_199        := mod1_199;
   self.mod1_200        := mod1_200;
   self.mod1_201        := mod1_201;
   self.mod1_202        := mod1_202;
   self.mod1_203        := mod1_203;
   self.mod1_204        := mod1_204;
   self.mod1_205        := mod1_205;
   self.mod1_206        := mod1_206;
   self.mod1_lgt        := mod1_lgt;
   self.pbr             := pbr;
   self.sbr             := sbr;
   self.offset          := offset;
   self.base            := base;
   self.pts             := pts;
   self.lgt             := lgt;
   self.fp1606_1_0      := fp1606_1_0;
   self._ver_src_ds     := _ver_src_ds;
   self._ver_src_de     := _ver_src_de;
   self._ver_src_eq     := _ver_src_eq;
   self._ver_src_en     := _ver_src_en;
   self._ver_src_tn     := _ver_src_tn;
   self._ver_src_tu     := _ver_src_tu;
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
   self.stolenc_fp1606_1_0               := stolenc_fp1606_1_0;
   self.manip2c_fp1606_1_0               := manip2c_fp1606_1_0;
   self.synthc_fp1606_1_0                := synthc_fp1606_1_0;
   self.suspactc_fp1606_1_0              := suspactc_fp1606_1_0;
   self.vulnvicc_fp1606_1_0              := vulnvicc_fp1606_1_0;
   self.friendlyc_fp1606_1_0             := friendlyc_fp1606_1_0;
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
	reasons := Models.Common.checkFraudPointRC34(FP1606_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)FP1606_1_0;
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

