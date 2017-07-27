import risk_indicators, riskwise, riskwisefcra, ut, Models;

export PhoneScore_cp3(dataset(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout) clam, Unsigned2 Score_Threshold	= Phone_Shell.Constants.Default_PhoneScore) := FUNCTION

  PHONE_DEBUG := false;

  #if(PHONE_DEBUG)
    layout_debug := record
			integer  sysdate;
			integer4 phone_pos_cr;
			integer4 phone_pos_edaca;
			integer4 phone_pos_edadid;
			integer4 phone_pos_edafa;
			integer4 phone_pos_edafla;
			integer4 phone_pos_edahistory;
			integer4 phone_pos_edala;
			integer4 phone_pos_edalfa;
			integer4 phone_pos_exp;
			integer4 phone_pos_inf;
			integer4 phone_pos_input;
			integer4 phone_pos_md;
			integer4 phone_pos_ne;
			integer4 phone_pos_paw;
			integer4 phone_pos_pde;
			integer4 phone_pos_pf;
			integer4 phone_pos_pffla;
			integer4 phone_pos_pfla;
			integer4 phone_pos_ppca;
			integer4 phone_pos_ppdid;
			integer4 phone_pos_ppfa;
			integer4 phone_pos_ppfla;
			integer4 phone_pos_ppla;
			integer4 phone_pos_pplfa;
			integer4 phone_pos_ppth;
			integer4 phone_pos_rel;
			integer4 phone_pos_rm;
			integer4 phone_pos_sp;
			integer4 phone_pos_sx;
			integer4 phone_pos_utildid;
			boolean source_cr;
			boolean source_edaca;
			boolean source_edadid;
			boolean source_edafa;
			boolean source_edafla;
			boolean source_edahistory;
			boolean source_edala;
			boolean source_edalfa;
			boolean source_exp;
			boolean source_inf;
			boolean source_input;
			boolean source_md;
			boolean source_ne;
			boolean source_paw;
			boolean source_pde;
			integer source_pf;
			boolean source_pffla;
			boolean source_pfla;
			boolean source_ppca;
			integer source_ppdid;
			integer source_ppfa;
			boolean source_ppfla;
			integer source_ppla;
			boolean source_pplfa;
			boolean source_ppth;
			integer source_rel;
			boolean source_rm;
			integer source_sp;
			boolean source_sx;
			boolean source_utildid;
			string source_cr_lseen;
			string source_cr_fseen;
			string source_edaca_lseen;
			string source_edadid_fseen;
			string source_edahistory_fseen;
			string source_edahistory_lseen;
			string source_edala_fseen;
			string source_exp_lseen;
			string source_exp_fseen;
			string source_inf_lseen;
			string source_inf_fseen;
			string source_input_fseen;
			string source_md_fseen;
			string source_paw_lseen;
			string source_pf_fseen;
			string source_ppca_lseen;
			string source_ppca_fseen;
			string source_ppdid_lseen;
			string source_ppdid_fseen;
			string source_ppfa_lseen;
			string source_ppfa_fseen;
			string source_ppfla_lseen;
			string source_ppfla_fseen;
			string source_ppla_lseen;
			string source_ppla_fseen;
			string source_ppth_lseen;
			string source_ppth_fseen;
			string source_rel_fseen;
			string source_sp_lseen;
			string source_sp_fseen;
			string source_sx_fseen;
			string source_utildid_fseen;
			integer source_eda_any_clean;
			integer source_pp_any_clean;
			integer number_of_sources;
			integer source_cr_lseen2;
			integer yr_source_cr_lseen;
			integer source_cr_fseen2;
			integer yr_source_cr_fseen;
			integer source_edaca_lseen2;
			integer yr_source_edaca_lseen;
			integer source_edadid_fseen2;
			integer yr_source_edadid_fseen;
			integer source_edahistory_lseen2;
			integer yr_source_edahistory_lseen;
			integer source_edahistory_fseen2;
			integer yr_source_edahistory_fseen;
			integer source_edala_fseen2;
			integer yr_source_edala_fseen;
			integer source_exp_lseen2;
			integer yr_source_exp_lseen;
			integer source_exp_fseen2;
			integer yr_source_exp_fseen;
			integer source_inf_lseen2;
			integer yr_source_inf_lseen;
			integer source_inf_fseen2;
			integer yr_source_inf_fseen;
			integer source_md_fseen2;
			integer yr_source_md_fseen;
			integer source_paw_lseen2;
			integer yr_source_paw_lseen;
			integer source_pf_fseen2;
			integer yr_source_pf_fseen;
			integer source_ppca_lseen2;
			integer yr_source_ppca_lseen;
			integer source_ppca_fseen2;
			integer yr_source_ppca_fseen;
			integer source_ppdid_lseen2;
			integer yr_source_ppdid_lseen;
			integer source_ppdid_fseen2;
			integer yr_source_ppdid_fseen;
			integer source_ppfa_lseen2;
			integer yr_source_ppfa_lseen;
			integer source_ppfa_fseen2;
			integer yr_source_ppfa_fseen;
			integer source_ppfla_lseen2;
			integer yr_source_ppfla_lseen;
			integer source_ppfla_fseen2;
			integer yr_source_ppfla_fseen;
			integer source_ppla_lseen2;
			integer yr_source_ppla_lseen;
			integer source_ppla_fseen2;
			integer yr_source_ppla_fseen;
			integer source_ppth_lseen2;
			integer yr_source_ppth_lseen;
			integer source_ppth_fseen2;
			integer yr_source_ppth_fseen;
			integer source_rel_fseen2;
			integer yr_source_rel_fseen;
			integer source_sp_lseen2;
			integer yr_source_sp_lseen;
			integer source_sp_fseen2;
			integer yr_source_sp_fseen;
			integer source_sx_fseen2;
			integer yr_source_sx_fseen;
			integer source_utildid_fseen2;
			integer yr_source_utildid_fseen;
			integer eda_dt_first_seen2;
			integer yr_eda_dt_first_seen;
			integer eda_dt_last_seen2;
			integer yr_eda_dt_last_seen;
			integer eda_deletion_date2;
			integer yr_eda_deletion_date;
			integer exp_last_update2;
			integer yr_exp_last_update;
			integer internal_ver_first_seen2;
			integer yr_internal_ver_first_seen;
			integer pp_datefirstseen2;
			integer yr_pp_datefirstseen;
			integer pp_datelastseen2;
			integer yr_pp_datelastseen;
			integer pp_datevendorfirstseen2;
			integer yr_pp_datevendorfirstseen;
			integer pp_datevendorlastseen2;
			integer yr_pp_datevendorlastseen;
			integer pp_date_nonglb_lastseen2;
			integer yr_pp_date_nonglb_lastseen;
			integer pp_orig_lastseen2;
			integer yr_pp_orig_lastseen;
			integer pp_app_npa_effective_dt2;
			integer yr_pp_app_npa_effective_dt;
			integer pp_app_npa_last_change_dt2;
			integer yr_pp_app_npa_last_change_dt;
			integer pp_eda_hist_did_dt2;
			integer yr_pp_eda_hist_did_dt;
			integer pp_eda_hist_nm_addr_dt2;
			integer yr_pp_eda_hist_nm_addr_dt;
			integer pp_app_fb_ph_dt2;
			integer yr_pp_app_fb_ph_dt;
			integer pp_app_fb_ph7_did_dt2;
			integer yr_pp_app_fb_ph7_did_dt;
			integer pp_app_fb_ph7_nm_addr_dt2;
			integer yr_pp_app_fb_ph7_nm_addr_dt;
			integer pp_first_build_date2;
			integer yr_pp_first_build_date;
			integer mth_source_cr_lseen;
			integer mth_source_cr_fseen;
			integer mth_source_edaca_lseen;
			integer mth_source_edadid_fseen;
			integer mth_source_edahistory_lseen;
			integer mth_source_edahistory_fseen;
			integer mth_source_edala_fseen;
			integer mth_source_exp_lseen;
			integer mth_source_exp_fseen;
			integer mth_source_inf_lseen;
			integer mth_source_inf_fseen;
			integer mth_source_md_fseen;
			integer mth_source_paw_lseen;
			integer mth_source_pf_fseen;
			integer mth_source_ppca_lseen;
			integer mth_source_ppca_fseen;
			integer mth_source_ppdid_lseen;
			integer mth_source_ppdid_fseen;
			integer mth_source_ppfa_lseen;
			integer mth_source_ppfa_fseen;
			integer mth_source_ppfla_lseen;
			integer mth_source_ppfla_fseen;
			integer mth_source_ppla_lseen;
			integer mth_source_ppla_fseen;
			integer mth_source_ppth_lseen;
			integer mth_source_ppth_fseen;
			integer mth_source_rel_fseen;
			integer mth_source_sp_lseen;
			integer mth_source_sp_fseen;
			integer mth_source_sx_fseen;
			integer mth_source_utildid_fseen;
			integer mth_eda_dt_first_seen;
			integer mth_eda_dt_last_seen;
			integer mth_eda_deletion_date;
			integer mth_exp_last_update;
			integer mth_internal_ver_first_seen;
			integer mth_pp_datefirstseen;
			integer mth_pp_datelastseen;
			integer mth_pp_datevendorfirstseen;
			integer mth_pp_datevendorlastseen;
			integer mth_pp_date_nonglb_lastseen;
			integer mth_pp_orig_lastseen;
			integer mth_pp_app_npa_effective_dt;
			integer mth_pp_app_npa_last_change_dt;
			integer mth_pp_eda_hist_did_dt;
			integer mth_pp_eda_hist_nm_addr_dt ;
			integer mth_pp_app_fb_ph_dt;
			integer mth_pp_app_fb_ph7_did_dt;
			integer mth_pp_app_fb_ph7_nm_addr_dt;
			integer mth_pp_first_build_date;
			boolean _phone_match_code_a;
			boolean _phone_match_code_c;
			boolean _phone_match_code_l;
			boolean _phone_match_code_n;
			boolean _phone_match_code_s;
			boolean _phone_match_code_t;
			boolean _phone_match_code_z;
			integer _pp_rule_seen_once;
			integer _pp_rule_high_vend_conf;
			integer _pp_rule_low_vend_conf;
			integer _pp_rule_cellphone_latest;
			integer _pp_rule_source_latest;
			integer _pp_rule_med_vend_conf_cell;
			integer _pp_rule_iq_rpc;
			integer _pp_rule_ins_ver_above;
			integer _pp_rule_f1_ver_above;
			integer _pp_rule_f1_ver_below;
			integer _pp_rule_30;
			integer _pp_did_flag;
			integer _pp_src_all_eq;
			integer _pp_src_all_ut;
			integer _pp_src_all_uw;
			integer _pp_src_all_iq;
			integer _pp_app_nonpub_gong_la;
			integer _pp_app_nonpub_gong_lap;
			integer _pp_app_nonpub_targ_la;
			integer _pp_app_nonpub_targ_lap;
			integer _pp_hhid_flag;
			integer _eda_hhid_flag;
			integer inq_firstseen_n;
			integer inq_lastseen_n;
			integer inq_adl_firstseen_n;
			integer inq_adl_lastseen_n;
			integer _internal_ver_match_lexid;
			integer _internal_ver_match_spouse;
			integer _internal_ver_match_hhid;
			integer _internal_ver_match_level;
			integer _inq_adl_ph_industry_auto;
			integer _inq_adl_ph_industry_day;
			integer _inq_adl_ph_industry_flag;
			integer _pp_gender;
			integer _pp_agegroup;
			integer _pp_app_fb_ph;
			integer _pp_app_fb_ph7_did;
			integer _phone_disconnected;
			integer _phone_zip_match;
			integer _phone_timezone_match;
			integer _phone_fb_result;
			integer _phone_fb_rp_result;
			integer _phone_match_code_lns;
			integer _phone_match_code_tcza;
			integer pk_phone_match_level;
			integer _pp_app_coctype_landline;
			integer _pp_app_coctype_cell;
			integer _phone_switch_type_cell;
			integer _pp_app_nxx_type_cell;
			integer _pp_app_ph_type_cell;
			integer _pp_app_company_type_cell;
			integer _exp_type_cell;
			integer pk_cell_indicator;
			integer pk_cell_flag;
			integer _pp_glb_dppa_fl_glb;
			integer _pp_origlistingtype_res;
			integer pk_exp_hit;
			integer pk_pp_hit;
			string segment;
			integer add_curr_occupants_1yr_out;
			integer r_nas_addr_verd_d;
			integer r_pb_order_freq_d;
			integer f_bus_name_nover_i;
			integer f_adl_util_conv_n;
			integer f_adl_util_misc_n;
			integer f_util_adl_count_n;
			integer f_util_add_input_inf_n;
			integer f_util_add_input_conv_n;
			integer f_util_add_curr_inf_n;
			integer f_util_add_curr_misc_n;
			integer f_add_input_mobility_index_n;
			integer f_add_curr_mobility_index_n;
			integer f_inq_count_i;
			integer f_inq_count24_i;
			integer f_inq_per_ssn_i;
			integer f_inq_lnames_per_ssn_i;
			integer f_inq_addrs_per_ssn_i;
			integer f_inq_dobs_per_ssn_i;
			integer f_inq_per_addr_i;
			integer f_inq_adls_per_addr_i;
			integer f_inq_lnames_per_addr_i;
			integer f_inq_ssns_per_addr_i;
			integer _inq_banko_am_first_seen;
			integer f_mos_inq_banko_am_fseen_d;
			integer _inq_banko_am_last_seen;
			integer f_mos_inq_banko_am_lseen_d;
			integer _inq_banko_cm_first_seen;
			integer f_mos_inq_banko_cm_fseen_d;
			integer _inq_banko_cm_last_seen;
			integer f_mos_inq_banko_cm_lseen_d;
			integer _inq_banko_om_first_seen;
			integer f_mos_inq_banko_om_fseen_d;
			integer _inq_banko_om_last_seen;
			integer f_mos_inq_banko_om_lseen_d;
			integer f_attr_arrest_recency_d;
			integer _foreclosure_last_date;
			integer f_mos_foreclosure_lseen_d;
			integer f_estimated_income_d;
			integer f_wealth_index_d;
			integer f_college_income_d;
			integer f_rel_count_i;
			integer f_rel_incomeover25_count_d;
			integer f_rel_incomeover50_count_d;
			integer f_rel_incomeover75_count_d;
			integer f_rel_incomeover100_count_d;
			integer f_rel_homeover50_count_d;
			integer f_rel_homeover100_count_d;
			integer f_rel_homeover200_count_d;
			integer f_rel_homeover300_count_d;
			integer f_rel_homeover500_count_d;
			integer f_rel_ageover20_count_d;
			integer f_rel_ageover30_count_d;
			integer f_rel_ageover40_count_d;
			integer f_rel_ageover50_count_d;
			integer f_rel_educationover8_count_d;
			integer f_rel_educationover12_count_d;
			integer f_crim_rel_under25miles_cnt_i;
			integer f_crim_rel_under100miles_cnt_i;
			integer f_crim_rel_under500miles_cnt_i;
			integer f_rel_under25miles_cnt_d;
			integer f_rel_under100miles_cnt_d;
			integer f_rel_under500miles_cnt_d;
			integer f_rel_bankrupt_count_i;
			integer f_rel_criminal_count_i;
			integer f_rel_felony_count_i;
			integer f_accident_count_i;
			integer f_acc_damage_amt_total_i;
			integer _acc_last_seen;
			integer f_mos_acc_lseen_d;
			integer f_acc_damage_amt_last_i;
			integer f_idrisktype_i;
			integer f_idverrisktype_i;
			integer f_sourcerisktype_i;
			integer f_varrisktype_i;
			integer f_vardobcount_i;
			integer f_vardobcountnew_i;
			integer f_srchvelocityrisktype_i;
			integer f_srchunvrfdssncount_i;
			integer f_srchunvrfdaddrcount_i;
			integer f_srchunvrfdphonecount_i;
			integer f_srchfraudsrchcount_i;
			integer f_srchfraudsrchcountyr_i;
			integer f_srchfraudsrchcountmo_i;
			integer f_assocrisktype_i;
			integer f_assocsuspicousidcount_i;
			integer f_assoccredbureaucount_i;
			integer f_corrrisktype_i;
			integer f_corrssnnamecount_d;
			integer f_corrssnaddrcount_d;
			integer f_corraddrnamecount_d;
			integer f_divrisktype_i;
			integer f_divssnidmsrcurelcount_i;
			integer f_divaddrsuspidcountnew_i;
			integer f_divsrchaddrsuspidcount_i;
			integer f_srchssnsrchcount_i;
			integer f_srchssnsrchcountmo_i;
			integer f_srchaddrsrchcount_i;
			integer f_srchaddrsrchcountmo_i;
			integer f_componentcharrisktype_i;
			integer f_addrchangeincomediff_d;
			integer f_addrchangevaluediff_d;
			integer f_addrchangecrimediff_i;
			integer f_addrchangeecontrajindex_d;
			integer f_curraddractivephonelist_d;
			integer f_curraddrmedianincome_d;
			integer f_curraddrmedianvalue_d;
			integer f_curraddrmurderindex_i;
			integer f_curraddrcartheftindex_i;
			integer f_curraddrburglaryindex_i;
			integer f_curraddrcrimeindex_i;
			integer f_prevaddrageoldest_d;
			integer f_prevaddrlenofres_d;
			integer f_prevaddrdwelltype_sfd_n;
			integer f_prevaddrstatus_i;
			integer f_prevaddroccupantowned_d;
			integer f_prevaddrmedianincome_d;
			integer f_prevaddrmedianvalue_d;
			integer f_prevaddrmurderindex_i;
			integer f_prevaddrcartheftindex_i;
			integer f_fp_prevaddrburglaryindex_i;
			integer f_fp_prevaddrcrimeindex_i;
			integer r_has_paw_source_d;
			integer _paw_first_seen;
			integer r_mos_since_paw_fseen_d;
			integer r_paw_dead_business_ct_i;
			integer r_paw_active_phone_ct_d;
			real	final_score;
			real	final_score_0	;
			real	final_score_1	;
			real	final_score_2	;
			real	final_score_3	;
			real	final_score_4	;
			real	final_score_5	;
			real	final_score_6	;
			real	final_score_7	;
			real	final_score_8	;
			real	final_score_9	;
			real	final_score_10	;
			real	final_score_11	;
			real	final_score_12	;
			real	final_score_13	;
			real	final_score_14	;
			real	final_score_15	;
			real	final_score_16	;
			real	final_score_17	;
			real	final_score_18	;
			real	final_score_19	;
			real	final_score_20	;
			real	final_score_21	;
			real	final_score_22	;
			real	final_score_23	;
			real	final_score_24	;
			real	final_score_25	;
			real	final_score_26	;
			real	final_score_27	;
			real	final_score_28	;
			real	final_score_29	;
			real	final_score_30	;
			real	final_score_31	;
			real	final_score_32	;
			real	final_score_33	;
			real	final_score_34	;
			real	final_score_35	;
			real	final_score_36	;
			real	final_score_37	;
			real	final_score_38	;
			real	final_score_39	;
			real	final_score_40	;
			real	final_score_41	;
			real	final_score_42	;
			real	final_score_43	;
			real	final_score_44	;
			real	final_score_45	;
			real	final_score_46	;
			real	final_score_47	;
			real	final_score_48	;
			real	final_score_49	;
			real	final_score_50	;
			real	final_score_51	;
			real	final_score_52	;
			real	final_score_53	;
			real	final_score_54	;
			real	final_score_55	;
			real	final_score_56	;
			real	final_score_57	;
			real	final_score_58	;
			real	final_score_59	;
			real	final_score_60	;
			real	final_score_61	;
			real	final_score_62	;
			real	final_score_63	;
			real	final_score_64	;
			real	final_score_65	;
			real	final_score_66	;
			real	final_score_67	;
			real	final_score_68	;
			real	final_score_69	;
			real	final_score_70	;
			real	final_score_71	;
			real	final_score_72	;
			real	final_score_73	;
			real	final_score_74	;
			real	final_score_75	;
			real	final_score_76	;
			real	final_score_77	;
			real	final_score_78	;
			real	final_score_79	;
			real	final_score_80	;
			real	final_score_81	;
			real	final_score_82	;
			real	final_score_83	;
			real	final_score_84	;
			real	final_score_85	;
			real	final_score_86	;
			real	final_score_87	;
			real	final_score_88	;
			real	final_score_89	;
			real	final_score_90	;
			real	final_score_91	;
			real	final_score_92	;
			real	final_score_93	;
			real	final_score_94	;
			real	final_score_95	;
			real	final_score_96	;
			real	final_score_97	;
			real	final_score_98	;
			real	final_score_99	;
			real	final_score_100	;
			real	final_score_101	;
			real	final_score_102	;
			real	final_score_103	;
			real	final_score_104	;
			real	final_score_105	;
			real	final_score_106	;
			real	final_score_107	;
			real	final_score_108	;
			real	final_score_109	;
			real	final_score_110	;
			real	final_score_111	;
			real	final_score_112	;
			real	final_score_113	;
			real	final_score_114	;
			real	final_score_115	;
			real	final_score_116	;
			real	final_score_117	;
			real	final_score_118	;
			real	final_score_119	;
			real	final_score_120	;
			real	final_score_121	;
			real	final_score_122	;
			real	final_score_123	;
			real	final_score_124	;
			real	final_score_125	;
			real	final_score_126	;
			real	final_score_127	;
			real	final_score_128	;
			real	final_score_129	;
			real	final_score_130	;
			real	final_score_131	;
			real	final_score_132	;
			real	final_score_133	;
			real	final_score_134	;
			real	final_score_135	;
			real	final_score_136	;
			real	final_score_137	;
			real	final_score_138	;
			real	final_score_139	;
			real	final_score_140	;
			real	final_score_141	;
			real	final_score_142	;
			real	final_score_143	;
			real	final_score_144	;
			real	final_score_145	;
			real	final_score_146	;
			real	final_score_147	;
			real	final_score_148	;
			real	final_score_149	;
			real	final_score_150	;
			real	final_score_151	;
			real	final_score_152	;
			real	final_score_153	;
			real	final_score_154	;
			real	final_score_155	;
			real	final_score_156	;
			real	final_score_157	;
			real	final_score_158	;
			real	final_score_159	;
			real	final_score_160	;
			real	final_score_161	;
			real	final_score_162	;
			real	final_score_163	;
			real	final_score_164	;
			real	final_score_165	;
			real	final_score_166	;
			real	final_score_167	;
			real	final_score_168	;
			real	final_score_169	;
			real	final_score_170	;
			real	final_score_171	;
			real	final_score_172	;
			real	final_score_173	;
			real	final_score_174	;
			real	final_score_175	;
			real	final_score_176	;
			real	final_score_177	;
			real	final_score_178	;
			real	final_score_179	;
			real	final_score_180	;
			real	final_score_181	;
			real	final_score_182	;
			real	final_score_183	;
			real	final_score_184	;
			real	final_score_185	;
			real	final_score_186	;
			real	final_score_187	;
			real	final_score_188	;
			real	final_score_189	;
			real	final_score_190	;
			real	final_score_191	;
			real	final_score_192	;
			real	final_score_193	;
			real	final_score_194	;
			real	final_score_195	;
			real	final_score_196	;
			real	final_score_197	;
			real	final_score_198	;
			real	final_score_199	;
			real	final_score_200	;
			real	final_score_201	;
			real	final_score_202	;
			real	final_score_203	;
			real	final_score_204	;
			real	final_score_205	;
			real	final_score_206	;
			real	final_score_207	;
			real	final_score_208	;
			real	final_score_209	;
			real	final_score_210	;
			real	final_score_211	;
			real	final_score_212	;
			real	final_score_213	;
			real	final_score_214	;
			real	final_score_215	;
			real	final_score_216	;
			real	final_score_217	;
			real	final_score_218	;
			real	final_score_219	;
			real	final_score_220	;
			real	final_score_221	;
			real	final_score_222	;
			real	final_score_223	;
			real	final_score_224	;
			real	final_score_225	;
			real	final_score_226	;
			real	final_score_227	;
			real	final_score_228	;
			real	final_score_229	;
			real	final_score_230	;
			real	final_score_231	;
			real	final_score_232	;
			real	final_score_233	;
			real	final_score_234	;
			real	final_score_235	;
			real	final_score_236	;
			real	final_score_237	;
			real	final_score_238	;
			real	final_score_239	;
			real	final_score_240	;
			real	final_score_241	;
			real	final_score_242	;
			real	final_score_243	;
			real	final_score_244	;
			real	final_score_245	;
			real	final_score_246	;
			real	final_score_247	;
			real	final_score_248	;
			real	final_score_249	;
			real	final_score_250	;
			real	final_score_251	;
			real	final_score_252	;
			real	final_score_253	;
			real	final_score_254	;
			real	final_score_255	;
			real	final_score_256	;
			real	final_score_257	;
			real	final_score_258	;
			real	final_score_259	;
			real	final_score_260	;
			real	final_score_261	;
			real	final_score_262	;
			real	final_score_263	;
			real	final_score_264	;
			real	final_score_265	;
			real	final_score_266	;
			real	final_score_267	;
			real	final_score_268	;
			real	final_score_269	;
			real	final_score_270	;
			real	final_score_271	;
			real	final_score_272	;
			real	final_score_273	;
			real	final_score_274	;
			real	final_score_275	;
			real	final_score_276	;
			real	final_score_277	;
			real	final_score_278	;
			real	final_score_279	;
			real	final_score_280	;
			real	final_score_281	;
			real	final_score_282	;
			real	final_score_283	;
			real	final_score_284	;
			real	final_score_285	;
			real	final_score_286	;
			real	final_score_287	;
			real	final_score_288	;
			real	final_score_289	;
			real	final_score_290	;
			real	final_score_291	;
			real	final_score_292	;
			real	final_score_293	;
			real	final_score_294	;
			real	final_score_295	;
			real	final_score_296	;
			real	final_score_297	;
			real	final_score_298	;
			real	final_score_299	;
			real	final_score_300	;
			real	final_score_301	;
			real	final_score_302	;
			real	final_score_303	;
			real	final_score_304	;
			real	final_score_305	;
			real	final_score_306	;
			real	final_score_307	;
			real	final_score_308	;
			real	final_score_309	;
			real	final_score_310	;
			real	final_score_311	;
			real	final_score_312	;
			real	final_score_313	;
			real	final_score_314	;
			real	final_score_315	;
			real	final_score_316	;
			real	final_score_317	;
			real	final_score_318	;
			real	final_score_319	;
			real	final_score_320	;
			real	final_score_321	;
			real	final_score_322	;
			real	final_score_323	;
			real	final_score_324	;
			real	final_score_325	;
			real	final_score_326	;
			real	final_score_327	;
			real	final_score_328	;
			real	final_score_329	;
			real	final_score_330	;
			real	final_score_331	;
			real	final_score_332	;
			real	final_score_333	;
			real	final_score_334	;
			real	final_score_335	;
			real	final_score_336	;
			real	final_score_337	;
			real	final_score_338	;
			real	final_score_339	;
			real	final_score_340	;
			real	final_score_341	;
			real	final_score_342	;
			real	final_score_343	;
			real	final_score_344	;
			real	final_score_345	;
			real	final_score_346	;
			real	final_score_347	;
			real	final_score_348	;
			real	final_score_349	;
			real	final_score_350	;
			real	final_score_351	;
			real	final_score_352	;
			real	final_score_353	;
			real	final_score_354	;
			real	final_score_355	;
			real	final_score_356	;
			real	final_score_357	;
			real	final_score_358	;
			real	final_score_359	;
			real	final_score_360	;
			real	final_score_361	;
			real	final_score_362	;
			real	final_score_363	;
			real	final_score_364	;
			real	final_score_365	;
			real	final_score_366	;
			real	final_score_367	;
			real	final_score_368	;
			real	final_score_369	;
			real	final_score_370	;
			real	final_score_371	;
			real	final_score_372	;
			real	final_score_373	;
			real	final_score_374	;
			real	final_score_375	;
			real	final_score_376	;
			real	final_score_377	;
			real	final_score_378	;
			real	final_score_379	;
			real	final_score_380	;
			real	final_score_381	;
			real	final_score_382	;
			real	final_score_383	;
			real	final_score_384	;
			real	final_score_385	;
			real	final_score_386	;
			real	final_score_387	;
			real	final_score_388	;
			real	final_score_389	;
			real	final_score_390	;
			real	final_score_391	;
			real	final_score_392	;
			real	final_score_393	;
			real	final_score_394	;
			real	final_score_395	;
			real	final_score_396	;
			real	final_score_397	;
			real	final_score_398	;
			real	final_score_399	;
			real	final_score_400	;
			real	final_score_401	;
			real	final_score_402	;
			real	final_score_403	;
			real	final_score_404	;
			real	final_score_405	;
			real	final_score_406	;
			real	final_score_407	;
			real	final_score_408	;
			real	final_score_409	;
			real	final_score_410	;
			real	final_score_411	;
			real	final_score_412	;
			real	final_score_413	;
			real	final_score_414	;
			real	final_score_415	;
			real	final_score_416	;
			real	final_score_417	;
			real	final_score_418	;
			real	final_score_419	;
			real	final_score_420	;
			real	final_score_421	;
			real	final_score_422	;
			real	final_score_423	;
			real	final_score_424	;
			real	final_score_425	;
			real	final_score_426	;
			real	final_score_427	;
			real	final_score_428	;
			real	final_score_429	;
			real	final_score_430	;
			real	final_score_431	;
			real	final_score_432	;
			real	final_score_433	;
			real	final_score_434	;
			real	final_score_435	;
			real	final_score_436	;
			real	final_score_437	;
			real	final_score_438	;
			real	final_score_439	;
			real	final_score_440	;
			real	final_score_441	;
			real	final_score_442	;
			real	final_score_443	;
			real	final_score_444	;
			real	final_score_445	;
			real	final_score_446	;
			real	final_score_447	;
			real	final_score_448	;
			real	final_score_449	;
			real	final_score_450	;
			real	final_score_451	;
			real	final_score_452	;
			real	final_score_453	;
			real	final_score_454	;
			real	final_score_455	;
			real	final_score_456	;
			real	final_score_457	;
			real	final_score_458	;
			real	final_score_459	;
			real	final_score_460	;
			real	final_score_461	;
			real	final_score_462	;
			real	final_score_463	;
			real	final_score_464	;
			real	final_score_465	;
			real	final_score_466	;
			real	final_score_467	;
			real	final_score_468	;
			real	final_score_469	;
			real	final_score_470	;
			real	final_score_471	;
			real	final_score_472	;
			real	final_score_473	;
			real	final_score_474	;
			real	final_score_475	;
			real	final_score_476	;
			real	final_score_477	;
			real	final_score_478	;
			real	final_score_479	;
			real	final_score_480	;
			real	final_score_481	;
			real	final_score_482	;
			real	final_score_483	;
			real	final_score_484	;
			real	final_score_485	;
			real	final_score_486	;
			real	final_score_487	;
			real	final_score_488	;
			real	final_score_489	;
			real	final_score_490	;
			real	final_score_491	;
			real	final_score_492	;
			real	final_score_493	;
			real	final_score_494	;
			real	final_score_495	;
			real	final_score_496	;
			real	final_score_497	;
			real	final_score_498	;
			real	final_score_499	;
			real	final_score_500	;
			real	final_score_501	;
			real	final_score_502	;
			real	final_score_503	;
			real	final_score_504	;
			real	final_score_505	;
			real	final_score_506	;
			real	final_score_507	;
			real	final_score_508	;
			real	final_score_509	;
			real	final_score_510	;
			real	final_score_511	;
			real	final_score_512	;
			real	final_score_513	;
			real	final_score_514	;
			real	final_score_515	;
			real	final_score_516	;
			real	final_score_517	;
			real	final_score_518	;
			real	final_score_519	;
			real	final_score_520	;
			real	final_score_521	;
			real	final_score_522	;
			real	final_score_523	;
			real	final_score_524	;
			real	final_score_525	;
			real	final_score_526	;
			real	final_score_527	;
			real	final_score_528	;
			real	final_score_529	;
			real	final_score_530	;
			real	final_score_531	;
			real	final_score_532	;
			real	final_score_533	;
			real	final_score_534	;
			real	final_score_535	;
			real	final_score_536	;
			real	final_score_537	;
			real	final_score_538	;
			real	final_score_539	;
			real	final_score_540	;
			real	final_score_541	;
			real	final_score_542	;
			real	final_score_543	;
			real	final_score_544	;
			real	final_score_545	;
			real	final_score_546	;
			real	final_score_547	;
			real	final_score_548	;
			real	final_score_549	;
			real	final_score_550	;
			real	final_score_551	;
			real	final_score_552	;
			real	final_score_553	;
			real	final_score_554	;
			real	final_score_555	;
			real	final_score_556	;
			real	final_score_557	;
			real	final_score_558	;
			real	final_score_559	;
			real	final_score_560	;
			real	final_score_561	;
			real	final_score_562	;
			real	final_score_563	;
			real	final_score_564	;
			real	final_score_565	;
			real	final_score_566	;
			real	final_score_567	;
			real	final_score_568	;
			real	final_score_569	;
			real	final_score_570	;
			real	final_score_571	;
			real	final_score_572	;
			real	final_score_573	;
			real	final_score_574	;
			real	final_score_575	;
			real	final_score_576	;
			real	final_score_577	;
			real	final_score_578	;
			real	final_score_579	;
			real	final_score_580	;
			real	final_score_581	;
			real	final_score_582	;
			real	final_score_583	;
			real	final_score_584	;
			real	final_score_585	;
			real	final_score_586	;
			real	final_score_587	;
			real	final_score_588	;
			real	final_score_589	;
			real	final_score_590	;
			real	final_score_591	;
			real	final_score_592	;
			real	final_score_593	;
			real	final_score_594	;
			real	final_score_595	;
			real	final_score_596	;
			real	final_score_597	;
			real	final_score_598	;
			real	final_score_599	;
			real	final_score_600	;
			real	final_score_601	;
			real	final_score_602	;
			real	final_score_603	;
			real	final_score_604	;
			real	final_score_605	;
			real	final_score_606	;
			real	final_score_607	;
			real	final_score_608	;
			real	final_score_609	;
			real	final_score_610	;
			real	final_score_611	;
			real	final_score_612	;
			real	final_score_613	;
			real	final_score_614	;
			real	final_score_615	;
			real	final_score_616	;
			real	final_score_617	;
			real	final_score_618	;
			real	final_score_619	;
			real	final_score_620	;
			real	final_score_621	;
			real	final_score_622	;
			real	final_score_623	;
			real	final_score_624	;
			real	final_score_625	;
			real	final_score_626	;
			real	final_score_627	;
			real	final_score_628	;
			real	final_score_629	;
			real	final_score_630	;
			real	final_score_631	;
			real	final_score_632	;
			real	final_score_633	;
			real	final_score_634	;
			real	final_score_635	;
			real	final_score_636	;
			real	final_score_637	;
			real	final_score_638	;
			real	final_score_639	;
			real	final_score_640	;
			real	final_score_641	;
			real	final_score_642	;
			real	final_score_643	;
			real	final_score_644	;
			real	final_score_645	;
			real	final_score_646	;
			real	final_score_647	;
			real	final_score_648	;
			real	final_score_649	;
			real	final_score_650	;
			real	final_score_651	;
			real	final_score_652	;
			real	final_score_653	;
			real	final_score_654	;
			real	final_score_655	;
			real	final_score_656	;
			real	final_score_657	;
			real	final_score_658	;
			real	final_score_659	;
			real	final_score_660	;
			real	final_score_661	;
			real	final_score_662	;
			real	final_score_663	;
			real	final_score_664	;
			real	final_score_665	;
			real	final_score_666	;
			real	final_score_667	;
			real	final_score_668	;
			real	final_score_669	;
			real	final_score_670	;
			real	final_score_671	;
			real	final_score_672	;
			real	final_score_673	;
			real	final_score_674	;
			real	final_score_675	;
			real	final_score_676	;
			real	final_score_677	;
			real	final_score_678	;
			real	final_score_679	;
			real	final_score_680	;
			real	final_score_681	;
			real	final_score_682	;
			real	final_score_683	;
			real	final_score_684	;
			real	final_score_685	;
			real	final_score_686	;
			real	final_score_687	;
			real	final_score_688	;
			real	final_score_689	;
			real	final_score_690	;
			real	final_score_691	;
			real	final_score_692	;
			real	final_score_693	;
			real	final_score_694	;
			real	final_score_695	;
			real	final_score_696	;
			real	final_score_697	;
			real	final_score_698	;
			real	final_score_699	;
			real	final_score_700	;
			real	final_score_701	;
			real	final_score_702	;
			real	final_score_703	;
			real	final_score_704	;
			real	final_score_705	;
			real	final_score_706	;
			real	final_score_707	;
			real	final_score_708	;
			real	final_score_709	;
			real	final_score_710	;
			real	final_score_711	;
			real	final_score_712	;
			real	final_score_713	;
			real	final_score_714	;
			real	final_score_715	;
			real	final_score_716	;
			real	final_score_717	;
			real	final_score_718	;
			real	final_score_719	;
			real	final_score_720	;
			real	final_score_721	;
			real	final_score_722	;
			real	final_score_723	;
			real	final_score_724	;
			real	final_score_725	;
			real	final_score_726	;
			real	final_score_727	;
			real	final_score_728	;
			real	final_score_729	;
			real	final_score_730	;
			real	final_score_731	;
			real	final_score_732	;
			real	final_score_733	;
			real	final_score_734	;
			real	final_score_735	;
			real	final_score_736	;
			real	final_score_737	;
			real	final_score_738	;
			real	final_score_739	;
			real	final_score_740	;
			real	final_score_741	;
			real	final_score_742	;
			real	final_score_743	;
			real	final_score_744	;
			real	final_score_745	;
			real	final_score_746	;
			real	final_score_747	;
			real	final_score_748	;
			real	final_score_749	;
			real	final_score_750	;
			real	final_score_751	;
			real	final_score_752	;
			real	final_score_753	;
			real	final_score_754	;
			real	final_score_755	;
			real	final_score_756	;
			real	final_score_757	;
			real	final_score_758	;
			real	final_score_759	;
			real	final_score_760	;
			real	final_score_761	;
			real	final_score_762	;
			real	final_score_763	;
			real	final_score_764	;
			real	final_score_765	;
			real	final_score_766	;
			real	final_score_767	;
			real	final_score_768	;
			real	final_score_769	;
			real	final_score_770	;
			real	final_score_771	;
			real	final_score_772	;
			real	final_score_773	;
			real	final_score_774	;
			real	final_score_775	;
			real	final_score_776	;
			real	final_score_777	;
			real	final_score_778	;
			real	final_score_779	;
			real	final_score_780	;
			real	final_score_781	;
			real	final_score_782	;
			real	final_score_783	;
			real	final_score_784	;
			real	final_score_785	;
			real	final_score_786	;
			real	final_score_787	;
			real	final_score_788	;
			real	final_score_789	;
			real	final_score_790	;
			real	final_score_791	;
			real	final_score_792	;
			real	final_score_793	;
			real	final_score_794	;
			real	final_score_795	;
			real	final_score_796	;
			real	final_score_797	;
			real	final_score_798	;
			real	final_score_799	;
			real	final_score_800	;
			real	final_score_801	;
			real	final_score_802	;
			real	final_score_803	;
			real	final_score_804	;
			real	final_score_805	;
			real	final_score_806	;
			real	final_score_807	;
			real	final_score_808	;
			real	final_score_809	;
			real	final_score_810	;
			real	final_score_811	;
			real	final_score_812	;
			real	final_score_813	;
			real	final_score_814	;
			real	final_score_815	;
			real	final_score_816	;
			real	final_score_817	;
			real	final_score_818	;
			real	final_score_819	;
			real	final_score_820	;
			real	final_score_821	;
			real	final_score_822	;
			real	final_score_823	;
			real	final_score_824	;
			real	final_score_825	;
			real	final_score_826	;
			real	final_score_827	;
			real	final_score_828	;
			real	final_score_829	;
			real	final_score_830	;
			real	final_score_831	;
			real	final_score_832	;
			real	final_score_833	;
			real	final_score_834	;
			real	final_score_835	;
			real	final_score_836	;
			real	final_score_837	;
			real	final_score_838	;
			real	final_score_839	;
			real	final_score_840	;
			real	final_score_841	;
			real	final_score_842	;
			real	final_score_843	;
			real	final_score_844	;
			real	final_score_845	;
			real	final_score_846	;
			real	final_score_847	;
			real	final_score_848	;
			real	final_score_849	;
			real	final_score_850	;
			real	final_score_851	;
			real	final_score_852	;
			real	final_score_853	;
			real	final_score_854	;
			real	final_score_855	;
			real	final_score_856	;
			real	final_score_857	;
			real	final_score_858	;
			real	final_score_859	;
			real	final_score_860	;
			real	final_score_861	;
			real	final_score_862	;
			real	final_score_863	;
			real	final_score_864	;
			real	final_score_865	;
			real	final_score_866	;
			real	final_score_867	;
			real	final_score_868	;
			real	final_score_869	;
			real	final_score_870	;
			real	final_score_871	;
			real	final_score_872	;
			real	final_score_873	;
			real	final_score_874	;
			real	final_score_875	;
			real	final_score_876	;
			real	final_score_877	;
			real	final_score_878	;
			real	final_score_879	;
			real	final_score_880	;
			real	final_score_881	;
			real	final_score_882	;
			real	final_score_883	;
			real	final_score_884	;
			real	final_score_885	;
			real	final_score_886	;
			real	final_score_887	;
			real	final_score_888	;
			real	final_score_889	;
			real	final_score_890	;
			real	final_score_891	;
			real	final_score_892	;
			real	final_score_893	;
			real	final_score_894	;
			real	final_score_895	;
			real	final_score_896	;
			real	final_score_897	;
			real	final_score_898	;
			real	final_score_899	;
			real	final_score_900	;
			real	final_score_901	;
			real	final_score_902	;
			real	final_score_903	;
			real	final_score_904	;
			real	final_score_905	;
			real	final_score_906	;
			real	final_score_907	;
			real	final_score_908	;
			real	final_score_909	;
			real	final_score_910	;
			real	final_score_911	;
			real	final_score_912	;
			real	final_score_913	;
			real	final_score_914	;
			real	final_score_915	;
			real	final_score_916	;
			real	final_score_917	;
			real	final_score_918	;
			real	final_score_919	;
			real	final_score_920	;
			real	final_score_921	;
			real	final_score_922	;
			real	final_score_923	;
			real	final_score_924	;
			real	final_score_925	;
			real	final_score_926	;
			real	final_score_927	;
			real	final_score_928	;
			real	final_score_929	;
			real	final_score_930	;
			real	final_score_931	;
			real	final_score_932	;
			real	final_score_933	;
			real	final_score_934	;
			real	final_score_935	;
			real	final_score_936	;
			real	final_score_937	;
			real	final_score_938	;
			real	final_score_939	;
			real	final_score_940	;
			real	final_score_941	;
			real	final_score_942	;
			real	final_score_943	;
			real	final_score_944	;
			real	final_score_945	;
			real	final_score_946	;
			real	final_score_947	;
			real	final_score_948	;
			real	final_score_949	;
			integer cp3;
			// Save all of the Phone Shell fields for return
			Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
		Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout doModel( clam le ) := TRANSFORM
  #end

//Start: ECL SAS mapping variables 
	isFCRA													 := false;
	source_list                      := trim(le.Phone_Shell.Sources.Source_List, left, right);
	source_list_last_seen            := trim(le.Phone_Shell.Sources.Source_List_Last_Seen, left, right);
	source_list_first_seen           := trim(le.Phone_Shell.Sources.Source_List_First_Seen, left, right);
	eda_dt_first_seen                := le.Phone_Shell.EDA_Characteristics.EDA_Dt_First_Seen;
	eda_dt_last_seen                 := le.Phone_Shell.EDA_Characteristics.EDA_Dt_Last_Seen;
	eda_deletion_date                := le.Phone_Shell.EDA_Characteristics.EDA_deletion_date;
	exp_last_update                  := le.Phone_Shell.Experian_File_One_Verification.Experian_Last_Update;
	internal_ver_first_seen          := le.Phone_Shell.Internal_Corroboration.Internal_Verification_First_Seen;
	pp_datefirstseen                 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen;
	pp_datelastseen                  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen;
	pp_datevendorfirstseen           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen;
	pp_datevendorlastseen            := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen;
	pp_date_nonglb_lastseen          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen;
	pp_orig_lastseen                 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Orig_LastSeen;
	pp_app_npa_effective_dt          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Effective_DT;
	pp_app_npa_last_change_dt        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Last_Change_DT;
	pp_eda_hist_did_dt               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt;
	pp_eda_hist_nm_addr_dt           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_nm_addr_Dt;
	pp_app_fb_ph_dt                  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone_Dt;
	pp_app_fb_ph7_did_dt             := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID_Dt;
	pp_app_fb_ph7_nm_addr_dt         := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_nm_addr_Dt;
	pp_first_build_date              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_First_Build_Date;
	phone_match_code                 := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Match_Code;
	pp_rules                         := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Rules;
	pp_did                           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DID;
	pp_src_all                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src_All;
	pp_app_nonpublished_match        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NonPublished_Match;
	pp_hhid                          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_HHID;
	eda_hhid                         := le.Phone_Shell.EDA_Characteristics.EDA_HHID;
	inq_firstseen                    := le.Phone_Shell.Inquiries.Inq_FirstSeen;
	inq_lastseen                     := le.Phone_Shell.Inquiries.Inq_LastSeen;
	inq_adl_firstseen                := le.Phone_Shell.Inquiries.Inq_ADL_FirstSeen;
	inq_adl_lastseen                 := le.Phone_Shell.Inquiries.Inq_ADL_LastSeen;
	internal_ver_match_type          := le.Phone_Shell.Internal_Corroboration.Internal_Verification_Match_Types;
	// inq_adl_ph_industry              := ;
	inq_adl_ph_industry_list_12      := le.Phone_Shell.Inquiries.Inq_ADL_Phone_Industry_List_12;
	pp_gender                        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Gender;
	pp_agegroup                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_AgeGroup;
	pp_app_fb_ph                     := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone;
	pp_app_fb_ph7_did                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID;
	phone_disconnected               := (integer)le.Phone_Shell.Raw_Phone_Characteristics.Phone_Disconnected;
	phone_zip_match                  := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Zip_Match;
	phone_timezone_match             := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Timezone_Match;
	phone_fb_result                  := le.Phone_Shell.Phone_Feedback.Phone_Feedback_Result;
	phone_fb_rp_result               := le.Phone_Shell.Phone_Feedback.Phone_Feedback_RP_Result;
	pp_app_coctype                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_COCType;
	pp_app_scc                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_SCC;
	phone_switch_type                := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Switch_Type;
	pp_app_nxx_type                  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NXX_Type;
	pp_app_ph_type                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Phone_Type;
	pp_app_company_type              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Company_Type;
	exp_type                         := le.Phone_Shell.Experian_File_One_Verification.Experian_Type;
	pp_glb_dppa_fl                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag;
	pp_origlistingtype               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigListingType;
	exp_verified                     := (integer)le.Phone_Shell.Experian_File_One_Verification.Experian_Verified;
	exp_source                       := le.Phone_Shell.Experian_File_One_Verification.Experian_Source;
	exp_ph_score_v1                  := le.Phone_Shell.Experian_File_One_Verification.Experian_Phone_Score_V1;
	pp_type                          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_type;
	pp_source                        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Source;
	pp_carrier                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Carrier;
	pp_city                          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_City;
	pp_state                         := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_State;
	pp_rp_type                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_RP_Type;
	pp_rp_source                     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_RP_Source;
	pp_rp_carrier                    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_RP_Carrier;
	pp_rp_city                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_RP_City;
	pp_rp_state                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_RP_State;
	pp_confidence                    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Confidence;
	pp_did_score                     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DID_Score;
	pp_listing_name                  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Listing_Name;
	pp_glb_dppa_all                  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_All;
	pp_src                           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src;
	pp_src_cnt                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src_Cnt;
	pp_src_rule                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src_Rule;
	pp_avg_source_conf               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Avg_Source_Conf;
	pp_max_source_conf               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Max_Source_Conf;
	pp_min_source_conf               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Min_Source_Conf;
	pp_total_source_conf             := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Total_Source_Conf;
	pp_did_type                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DID_Type;
	pp_origname                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigName;
	pp_address1                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Address1;
	pp_address2                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Address2;
	pp_address3                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Address3;
	pp_origcity                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigCity;
	pp_origstate                     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigState;
	pp_origzip                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigZip;
	pp_origphone                     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPhone;
	pp_dob                           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Dob;
	pp_email                         := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Email;
	pp_listingtype                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_ListingType;
	pp_origpublishcode               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPublishCode;
	pp_origphonetype                 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneType;
	pp_origphoneusage                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneUsage;
	pp_company                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Company;
	pp_origphoneregdate              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneRegDate;
	pp_origcarriercode               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigCarrierCode;
	pp_origcarriername               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigCarrierName;
	pp_origrectype                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigRecType;
	pp_bdid                          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_BDID;
	pp_bdid_score                    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_BDID_Score;
	pp_app_dialable_ind              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Dialable_Ind;
	pp_app_place_name                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Place_Name;
	pp_app_portability_indicator     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Portability_Indicator;
	pp_app_prior_area_code           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Prior_Area_Code;
	pp_app_ocn                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_OCN;
	pp_app_time_zone                 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Time_Zone;
	pp_app_ph_use                    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Phone_Use;
	pp_agreg_listing_type            := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Agreg_Listing_Type;
	pp_eda_match                     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Match;
	pp_eda_ph_dt                     := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Phone_Dt;
	pp_eda_did_dt                    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_DID_Dt;
	pp_eda_nm_addr_dt                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_NM_Addr_Dt;
	pp_eda_hist_match                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Match;
	pp_eda_hist_ph_dt                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Phone_Dt;
	pp_app_ported_match              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Ported_Match;
	pp_app_seen_once_ind             := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Seen_Once_Ind;
	pp_app_ind_ph_cnt                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Indiv_Phone_Cnt;
	pp_app_ind_has_actv_eda_ph_fl    := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Indiv_Has_Active_EDA_Phone_Flag;
	pp_app_latest_ph_owner_fl        := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Latest_Phone_Owner_Flag;
	pp_hhid_score                    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_HHID_Score;
	pp_app_best_addr_match_fl        := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Best_Addr_Match_Flag;
	pp_app_best_nm_match_fl          := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Best_NM_Match_Flag;
	pp_rawaid                        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_RawAID;
	pp_cleanaid                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_CleanAID;
	pp_current_rec                   := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Current_Rec;
	pp_last_build_date               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Last_Build_Date;
	util_add1_type_list              := le.Boca_Shell.utility.utili_addr1_type;
	add1_isbestmatch                 := le.Boca_Shell.Address_Verification.Input_Address_Information.isBestMatch;
	util_add2_type_list              := le.Boca_Shell.utility.utili_addr2_type;
	add1_occupants_1yr               := le.Boca_Shell.addr_risk_summary.occupants_1yr;
	add1_turnover_1yr_in             := le.Boca_Shell.addr_risk_summary.turnover_1yr_in;
	add2_occupants_1yr               := le.Boca_Shell.addr_risk_summary2.occupants_1yr;
	add2_turnover_1yr_in             := le.Boca_Shell.addr_risk_summary2.turnover_1yr_in;
	ams_income_level_code            := le.Boca_Shell.student.income_level_code;
	// f_addrchangeecontrajindex_d      := ;	//this field name is also set in the code
	paw_source_count                 := le.Boca_Shell.employment.source_ct;
	paw_first_seen                   := le.Boca_Shell.employment.first_seen_date;
	paw_dead_business_count          := le.Boca_Shell.employment.dead_business_ct;
	paw_active_phone_count           := le.Boca_Shell.employment.business_active_phone_ct;
	truedid                          := le.Boca_Shell.truedid;
	nas_summary                      := le.Boca_Shell.iid.nas_summary;
	bus_name_match                   := le.Boca_Shell.business_header_address_summary.bus_name_match;
	addrpop                          := le.Boca_Shell.input_validation.address;
	ssnlength                        := (integer)le.Boca_Shell.input_validation.ssn_length;
	util_adl_type_list               := le.Boca_Shell.utility.utili_adl_type;
	util_adl_count                   := le.Boca_Shell.utility.utili_adl_count;
	// add_curr_turnover_1yr_out        := le.Boca_Shell.addr_risk_summary2.turnover_1yr_out ;
	add_curr_turnover_1yr_out 		 	 := if(add1_isbestmatch, add1_turnover_1yr_in, add2_turnover_1yr_in); //kh-had to change to 'in' to validate
	inq_count                        := le.Boca_Shell.acc_logs.inquiries.counttotal;
	inq_count24                      := le.Boca_Shell.acc_logs.inquiries.count24;
	inq_perssn                       := if(isFCRA, 0, le.Boca_Shell.acc_logs.inquiryPerSSN );
	inq_lnamesperssn                 := if(isFCRA, 0, le.Boca_Shell.acc_logs.inquiryLNamesPerSSN );
	inq_addrsperssn                  := if(isFCRA, 0, le.Boca_Shell.acc_logs.inquiryAddrsPerSSN );
	inq_dobsperssn                   := if(isFCRA, 0, le.Boca_Shell.acc_logs.inquiryDOBsPerSSN );
	inq_peraddr                      := if(isFCRA, 0, le.Boca_Shell.acc_logs.inquiryPerAddr );
	inq_adlsperaddr                  := if(isFCRA, 0, le.Boca_Shell.acc_logs.inquiryADLsPerAddr );
	inq_lnamesperaddr                := if(isFCRA, 0, le.Boca_Shell.acc_logs.inquiryLNamesPerAddr );
	inq_ssnsperaddr                  := if(isFCRA, 0, le.Boca_Shell.acc_logs.inquirySSNsPerAddr );
	inq_banko_am_first_seen          := le.Boca_Shell.acc_logs.am_first_seen_date;
	inq_banko_am_last_seen           := le.Boca_Shell.acc_logs.am_last_seen_date;
	inq_banko_cm_first_seen          := le.Boca_Shell.acc_logs.cm_first_seen_date;
	inq_banko_cm_last_seen           := le.Boca_Shell.acc_logs.cm_last_seen_date;
	inq_banko_om_first_seen          := le.Boca_Shell.acc_logs.om_first_seen_date;
	inq_banko_om_last_seen           := le.Boca_Shell.acc_logs.om_last_seen_date;
	pb_number_of_sources             := le.Boca_Shell.ibehavior.number_of_sources;
	pb_average_days_bt_orders        := le.Boca_Shell.ibehavior.average_days_between_orders;
	attr_arrests                     := le.Boca_Shell.bjl.arrests_count;
	attr_arrests30                   := le.Boca_Shell.bjl.arrests_count30;
	attr_arrests90                   := le.Boca_Shell.bjl.arrests_count90;
	attr_arrests180                  := le.Boca_Shell.bjl.arrests_count180;
	attr_arrests12                   := le.Boca_Shell.bjl.arrests_count12;
	attr_arrests24                   := le.Boca_Shell.bjl.arrests_count24;
	attr_arrests36                   := le.Boca_Shell.bjl.arrests_count36;
	attr_arrests60                   := le.Boca_Shell.bjl.arrests_count60;
	fp_idrisktype                    := le.Boca_Shell.fdattributesv2.identityrisklevel;
	fp_idverrisktype                 := le.Boca_Shell.fdattributesv2.idverrisklevel;
	fp_sourcerisktype                := le.Boca_Shell.fdattributesv2.sourcerisklevel;
	fp_varrisktype                   := le.Boca_Shell.fdattributesv2.variationrisklevel;
	fp_vardobcount                   := le.Boca_Shell.fdattributesv2.variationdobcount;
	fp_vardobcountnew                := le.Boca_Shell.fdattributesv2.variationdobcountnew;
	fp_srchvelocityrisktype          := le.Boca_Shell.fdattributesv2.searchvelocityrisklevel;
	fp_srchunvrfdssncount            := le.Boca_Shell.fdattributesv2.searchunverifiedssncountyear;
	fp_srchunvrfdaddrcount           := le.Boca_Shell.fdattributesv2.searchunverifiedaddrcountyear;
	fp_srchunvrfdphonecount          := le.Boca_Shell.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcount            := le.Boca_Shell.fdattributesv2.searchfraudsearchcount;
	fp_srchfraudsrchcountyr          := le.Boca_Shell.fdattributesv2.searchfraudsearchcountyear;
	fp_srchfraudsrchcountmo          := le.Boca_Shell.fdattributesv2.searchfraudsearchcountmonth;
	fp_assocrisktype                 := le.Boca_Shell.fdattributesv2.assocrisklevel;
	fp_assocsuspicousidcount         := le.Boca_Shell.fdattributesv2.assocsuspicousidentitiescount;
	fp_assoccredbureaucount          := le.Boca_Shell.fdattributesv2.assoccreditbureauonlycount;
	fp_corrrisktype                  := le.Boca_Shell.fdattributesv2.correlationrisklevel;
	fp_corrssnnamecount              := le.Boca_Shell.fdattributesv2.correlationssnnamecount;
	fp_corrssnaddrcount              := le.Boca_Shell.fdattributesv2.correlationssnaddrcount;
	fp_corraddrnamecount             := le.Boca_Shell.fdattributesv2.correlationaddrnamecount;
	fp_divrisktype                   := le.Boca_Shell.fdattributesv2.divrisklevel;
	fp_divssnidmsrcurelcount         := le.Boca_Shell.fdattributesv2.divssnidentitymsourceurelcount;
	fp_divaddrsuspidcountnew         := le.Boca_Shell.fdattributesv2.divaddrsuspidentitycountnew;
	fp_divsrchaddrsuspidcount        := le.Boca_Shell.fdattributesv2.divsearchaddrsuspidentitycount;
	fp_srchssnsrchcount              := le.Boca_Shell.fdattributesv2.searchssnsearchcount;
	fp_srchssnsrchcountmo            := le.Boca_Shell.fdattributesv2.searchssnsearchcountmonth;
	fp_srchaddrsrchcount             := le.Boca_Shell.fdattributesv2.searchaddrsearchcount;
	fp_srchaddrsrchcountmo           := le.Boca_Shell.fdattributesv2.searchaddrsearchcountmonth;
	fp_componentcharrisktype         := le.Boca_Shell.fdattributesv2.componentcharrisklevel;
	fp_addrchangeincomediff          := le.Boca_Shell.fdattributesv2.addrchangeincomediff;
	fp_addrchangevaluediff           := le.Boca_Shell.fdattributesv2.addrchangevaluediff;
	fp_addrchangecrimediff           := le.Boca_Shell.fdattributesv2.addrchangecrimediff;
	fp_addrchangeecontrajindex       := le.Boca_Shell.fdattributesv2.addrchangeecontrajectoryindex;
	fp_curraddractivephonelist       := le.Boca_Shell.fdattributesv2.curraddractivephonelist;
	fp_curraddrmedianincome          := le.Boca_Shell.fdattributesv2.curraddrmedianincome;
	fp_curraddrmedianvalue           := le.Boca_Shell.fdattributesv2.curraddrmedianvalue;
	fp_curraddrmurderindex           := le.Boca_Shell.fdattributesv2.curraddrmurderindex;
	fp_curraddrcartheftindex         := le.Boca_Shell.fdattributesv2.curraddrcartheftindex;
	fp_curraddrburglaryindex         := le.Boca_Shell.fdattributesv2.curraddrburglaryindex;
	fp_curraddrcrimeindex            := le.Boca_Shell.fdattributesv2.curraddrcrimeindex;
	fp_prevaddrageoldest             := le.Boca_Shell.fdattributesv2.prevaddrageoldest;
	fp_prevaddrlenofres              := le.Boca_Shell.fdattributesv2.prevaddrlenofres;
	fp_prevaddrdwelltype             := le.Boca_Shell.fdattributesv2.prevaddrdwelltype;
	fp_prevaddrstatus                := le.Boca_Shell.fdattributesv2.prevaddrstatus;
	fp_prevaddroccupantowned         := le.Boca_Shell.fdattributesv2.prevaddroccupantowned;
	fp_prevaddrmedianincome          := le.Boca_Shell.fdattributesv2.prevaddrmedianincome;
	fp_prevaddrmedianvalue           := le.Boca_Shell.fdattributesv2.prevaddrmedianvalue;
	fp_prevaddrmurderindex           := le.Boca_Shell.fdattributesv2.prevaddrmurderindex;
	fp_prevaddrcartheftindex         := le.Boca_Shell.fdattributesv2.prevaddrcartheftindex;
	fp_prevaddrburglaryindex         := le.Boca_Shell.fdattributesv2.prevaddrburglaryindex;
	fp_prevaddrcrimeindex            := le.Boca_Shell.fdattributesv2.prevaddrcrimeindex;
	foreclosure_last_date            := le.Boca_Shell.bjl.last_foreclosure_date;
	rel_count                        := le.Boca_Shell.relatives.relative_count;
	rel_bankrupt_count               := le.Boca_Shell.relatives.relative_bankrupt_count;
	rel_criminal_count               := le.Boca_Shell.relatives.relative_criminal_count;
	rel_felony_count                 := le.Boca_Shell.relatives.relative_felony_count;
	crim_rel_within25miles           := le.Boca_Shell.relatives.criminal_relative_within25miles;
	crim_rel_within100miles          := le.Boca_Shell.relatives.criminal_relative_within100miles;
	crim_rel_within500miles          := le.Boca_Shell.relatives.criminal_relative_within500miles;
	rel_within25miles_count          := le.Boca_Shell.relatives.relative_within25miles_count;
	rel_within100miles_count         := le.Boca_Shell.relatives.relative_within100miles_count;
	rel_within500miles_count         := le.Boca_Shell.relatives.relative_within500miles_count;
	rel_incomeunder50_count          := le.Boca_Shell.relatives.relative_incomeunder50_count;
	rel_incomeunder75_count          := le.Boca_Shell.relatives.relative_incomeunder75_count;
	rel_incomeunder100_count         := le.Boca_Shell.relatives.relative_incomeunder100_count;
	rel_incomeover100_count          := le.Boca_Shell.relatives.relative_incomeover100_count;
	rel_homeunder100_count           := le.Boca_Shell.relatives.relative_homeunder100_count;
	rel_homeunder150_count           := le.Boca_Shell.relatives.relative_homeunder150_count;
	rel_homeunder200_count           := le.Boca_Shell.relatives.relative_homeunder200_count;
	rel_homeunder300_count           := le.Boca_Shell.relatives.relative_homeunder300_count;
	rel_homeunder500_count           := le.Boca_Shell.relatives.relative_homeunder500_count;
	rel_homeover500_count            := le.Boca_Shell.relatives.relative_homeover500_count;
	rel_educationunder12_count       := le.Boca_Shell.relatives.relative_educationunder12_count;
	rel_educationover12_count        := le.Boca_Shell.relatives.relative_educationover12_count;
	rel_ageunder30_count             := le.Boca_Shell.relatives.relative_ageunder30_count;
	rel_ageunder40_count             := le.Boca_Shell.relatives.relative_ageunder40_count;
	rel_ageunder50_count             := le.Boca_Shell.relatives.relative_ageunder50_count;
	rel_ageunder60_count             := le.Boca_Shell.relatives.relative_ageunder60_count;
	rel_ageunder70_count             := le.Boca_Shell.relatives.relative_ageunder70_count;
	rel_ageover70_count              := le.Boca_Shell.relatives.relative_ageover70_count;
	acc_count                        := le.Boca_Shell.accident_data.acc.num_accidents;
	acc_damage_amt_total             := le.Boca_Shell.accident_data.acc.dmgamtaccidents;
	acc_last_seen                    := le.Boca_Shell.accident_data.acc.datelastaccident;
	acc_damage_amt_last              := le.Boca_Shell.accident_data.acc.dmgamtlastaccident;
	wealth_index                     := (integer)le.Boca_Shell.wealth_indicator;
	estimated_income                 := le.Boca_Shell.estimated_income;

//Mapped fields needed from Phone shell for Pete's piece
	// in_Processing_Date              14  //not used
	Subject_SSN_Mismatch						 := le.Phone_Shell.Subject_Level.Subject_SSN_Mismatch; // 15
	// Source_List                     19
	// Source_List_Last_Seen           20
	// Source_List_First_Seen          21
	// Phone_Switch_Type               23
	// Phone_Disconnected              26
	// Phone_Zip_Match                 27
	// Phone_Timezone_Match            28
	// Phone_Match_Code                31
	Phone_Business_Count          	 := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Business_Count; // 32
	Phone_Subject_Title           	 := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Subject_Title; // 33
	// PP_Type                       	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_type; // 34
	// PP_Source                     	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_source; // 35
	// PP_Rules                        45
	// PP_DID_Score                  	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DID_Score; // 47
	// PP_DateFirstSeen                49
	// PP_DateLastSeen                 50
	// PP_DateVendorFirstSeen          51
	// PP_DateVendorLastSeen           52
	// PP_Date_NonGLB_LastSeen         53
	// PP_GLB_DPPA_fl                  54
	// PP_Src                        	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src; // 56
	// PP_Src_All                      57
	// PP_Src_Cnt                    	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src_Cnt; // 58
	// PP_Min_Source_Conf            	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Min_Source_Conf; // 62
	// PP_Total_Source_Conf          	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Total_Source_Conf; // 63
	// PP_Orig_LastSeen                64
	// PP_DID_Type                   	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DID_Type; // 65
	// PP_AgeGroup                     75
	// PP_OrigListingType              78
	// PP_OrigPhoneType              	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneType; // 81
	// PP_OrigPhoneUsage             	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneUsage; // 82
	PP_OrigConfScore              	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigConfScore; // 87
	// PP_app_NPA_Effective_DT         91
	// PP_app_NPA_Last_Change_DT       92
	// PP_app_NonPublished_Match       97
	// fp_CorrAddrNameCount            100
	// fp_CorrPhoneLastNameCount       100
	// fp_DivAddrSuspIDCountNew        100
	// fp_DivRiskType                  100
	// fp_DivSSNIDMSrcUrelCount        100
	// fp_SrchSSNSrchCount             100
	// PP_app_NXX_Type                 100
	// fp_SrchAddrSrchCount            101
	// fp_SrchAddrSrchCountMo          101
	// fp_SrchAddrSrchCountWk          101
	// PP_app_COCType                  101
	// fp_AddrChangeCrimeDiff          102
	// fp_AddrChangeEconTrajIndex      102
	// fp_AddrChangeIncomeDiff         102
	// fp_AddrChangeValueDiff          102
	// fp_ComponentCharRiskType        102
	// fp_CurrAddrActivePhoneList      102
	// fp_CurrAddrMedianIncome         102
	// fp_CurrAddrMedianValue          102
	// fp_InputAddrActivePhoneList     102
	// PP_app_SCC                      102
	// fp_CurrAddrBurglaryIndex        103
	// fp_CurrAddrCarTheftIndex        103
	// fp_CurrAddrCrimeIndex           103
	// fp_CurrAddrMurderIndex          103
	// fp_PrevAddrAgeOldest            103
	// fp_PrevAddrDwellType            103
	// fp_PrevAddrLenOfRes             103
	// fp_PrevAddrMedianIncome         103
	// fp_PrevAddrOccupantOwned        103
	// fp_PrevAddrStatus               103
	// PP_app_ph_Type                  103
	// fp_PrevAddrBurglaryIndex        104
	// fp_PrevAddrCarTheftIndex        104
	// fp_PrevAddrCrimeIndex           104
	// fp_PrevAddrMedianValue          104
	// fp_PrevAddrMurderIndex          104
	// PP_app_Company_Type             104
	// PP_app_ph_Use                 	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_append_phone_use; // 105
	// foreclosure_flag                111
	// crim_rel_within100miles         112
	// crim_rel_within25miles          112
	// crim_rel_within500miles         112
	// rel_bankrupt_count              112
	// rel_count                       112
	// rel_criminal_count              112
	// rel_felony_count                112
	// rel_incomeunder100_count        114
	// rel_incomeunder50_count         114
	// rel_incomeunder75_count         114
	// rel_within100miles_count        114
	// rel_within25miles_count         114
	// rel_within500miles_count        114
	// PP_EDA_Hist_ph_Dt               115
	// rel_educationunder12_count      115
	// rel_homeover500_count           115
	// rel_homeunder100_count          115
	// rel_homeunder150_count          115
	// rel_homeunder200_count          115
	// rel_homeunder300_count          115
	// rel_homeunder500_count          115
	// rel_incomeover100_count         115
	// PP_EDA_Hist_DID_Dt              116
	// rel_ageover70_count             116
	// rel_ageunder30_count            116
	// rel_ageunder40_count            116
	// rel_ageunder50_count            116
	// rel_ageunder60_count            116
	// rel_ageunder70_count            116
	// rel_educationover12_count       116
	// acc_count                       117
	// acc_damage_amt_last             117
	// acc_damage_amt_total            117
	// acc_last_seen                   117
	// PP_app_fb_ph                    118
	// ams_income_level_code           119
	// PP_app_fb_ph_Dt                 119
	// PP_app_fb_ph7_DID               120
	// PP_app_fb_ph7_DID_Dt            121
	// PP_app_Ported_Match             124
	// PP_app_ind_ph_Cnt             	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_append_indiv_phone_cnt; // 126
	// PP_app_ind_Has_actv_EDA_ph_fl 	 := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_append_indiv_has_active_eda_phone_flag; // 127
	// PP_app_Latest_ph_Owner_fl     	 := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_append_latest_phone_owner_flag; // 128
	// estimated_income                130
	// wealth_index                    130
	// PP_app_Best_Addr_Match_fl     	 := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_append_best_addr_match_flag; // 131
	// PP_First_Build_Date             136
	// Phone_fb_Result                 139
	// Phone_fb_RP_Date                144
	// Phone_fb_RP_Result              145
	Inq_Num                       	 := (integer)le.Phone_Shell.Inquiries.Inq_Num; // 150
	Inq_Num_Addresses             	 := (integer)le.Phone_Shell.Inquiries.Inq_Num_Addresses; // 152
	// Inq_Num_Addresses_06          	 := (integer)le.Phone_Shell.Inquiries.Inq_Num_Addresses_06; // 153
	Inq_Num_ADLs                  	 := (integer)le.Phone_Shell.Inquiries.Inq_Num_ADLs; // 154
	// Inq_Num_ADLs_06               	 := (integer)le.Phone_Shell.Inquiries.Inq_Num_ADLs_06; // 155
	// Inq_FirstSeen                   156
	// Inq_LastSeen                    157
	// Inq_ADL_FirstSeen               158
	// Inq_ADL_LastSeen                159
	// Inq_ADL_ph_Industry_List_12     160
	Internal_Verification         	 := (integer)le.Phone_Shell.Internal_Corroboration.Internal_Verification; // 161
	// Internal_ver_First_Seen         162
	Internal_ver_Match_Types         := le.Phone_Shell.Internal_Corroboration.Internal_Verification_Match_Types;  //164
	// Exp_Verified                    165
	// Exp_Type                        166
	// Exp_Source                      167
	// Exp_Last_Update                 168
	// Exp_ph_Score_V1                 169
	// EDA_Dt_First_Seen               176
	// EDA_Disc_Cnt12                	 := le.Phone_Shell.EDA_Characteristics.EDA_disc_cnt12; // 181
	EDA_Disc_Cnt18                	 := le.Phone_Shell.EDA_Characteristics.EDA_disc_cnt18; // 182
	EDA_Pfrd_Address_Ind          	 := le.Phone_Shell.EDA_Characteristics.EDA_pfrd_address_ind; // 183
	EDA_Days_In_Service           	 := le.Phone_Shell.EDA_Characteristics.EDA_days_in_service; // 184
	EDA_Num_ph_Owners_Hist        	 := le.Phone_Shell.EDA_Characteristics.EDA_num_phone_owners_hist; // 185
	EDA_Num_phs_ind               	 := le.Phone_Shell.EDA_Characteristics.EDA_num_phones_indiv; // 187
	EDA_Num_phs_Connected_ind     	 := le.Phone_Shell.EDA_Characteristics.EDA_num_phones_connected_indiv; // 188
	EDA_Min_Days_Connected_ind    	 := le.Phone_Shell.EDA_Characteristics.EDA_min_days_connected_indiv; // 191
	EDA_Max_Days_Connected_ind    	 := le.Phone_Shell.EDA_Characteristics.EDA_max_days_connected_indiv; // 192
	EDA_Days_ind_First_Seen       	 := le.Phone_Shell.EDA_Characteristics.EDA_days_indiv_first_seen; // 193
	EDA_Days_ph_First_Seen        	 := le.Phone_Shell.EDA_Characteristics.EDA_days_phone_first_seen; // 195
	EDA_Address_Match_Best        	 := (integer)le.Phone_Shell.EDA_Characteristics.EDA_address_match_best; // 196
	EDA_Months_Addr_Last_Seen     	 := le.Phone_Shell.EDA_Characteristics.EDA_months_addr_last_seen; // 197
	EDA_Num_phs_Connected_Addr    	 := le.Phone_Shell.EDA_Characteristics.EDA_num_phones_connected_addr; // 198
	EDA_Num_phs_Discon_Addr       	 := le.Phone_Shell.EDA_Characteristics.EDA_num_phones_discon_addr; // 199
	EDA_Num_phs_Connected_HHID    	 := le.Phone_Shell.EDA_Characteristics.EDA_num_phones_connected_hhid; // 200
	EDA_Num_phs_Discon_HHID       	 := le.Phone_Shell.EDA_Characteristics.EDA_num_phones_discon_hhid; // 201
	EDA_Num_Interrupts_Cur        	 := le.Phone_Shell.EDA_Characteristics.EDA_num_interrupts_cur; // 209
	EDA_Avg_Days_Interrupt        	 := le.Phone_Shell.EDA_Characteristics.EDA_avg_days_interrupt; // 210
	EDA_Min_Days_Interrupt        	 := le.Phone_Shell.EDA_Characteristics.EDA_min_days_interrupt; // 211
	EDA_Max_Days_Interrupt        	 := le.Phone_Shell.EDA_Characteristics.EDA_max_days_interrupt; // 212
	EDA_Has_Cur_Discon_15_Days    	 := (integer)le.Phone_Shell.EDA_Characteristics.EDA_has_cur_discon_15_days; // 216
	EDA_Has_Cur_Discon_30_Days    	 := (integer)le.Phone_Shell.EDA_Characteristics.EDA_has_cur_discon_30_days; // 216
	EDA_Has_Cur_Discon_90_Days    	 := (integer)le.Phone_Shell.EDA_Characteristics.EDA_has_cur_discon_90_days; // 216
	eda_avg_days_connected_ind    	 := (integer)le.Phone_Shell.EDA_Characteristics.EDA_Avg_Days_Connected_Indiv; // 216
	// truedid                         224
	// nas_summary                     254
	// bus_name_match                  404
	// addrpop                         409
	// ssnlength                       410
	// util_adl_type_list              426
	// util_adl_count                  428
	// util_add1_type_list             431
	// util_add2_type_list             434
	// add1_isbestmatch                439 (221)
	// add1_occupants_1yr              502 (284)
	// add1_turnover_1yr_in            503 (285)
	// add2_occupants_1yr              616 (398)
	// add2_turnover_1yr_in            617 (399)
	// Inq_count                       736
	// Inq_count24                     741
	// Inq_PerSSN                      797
	// Inq_AddrsPerSSN                 800
	// Inq_PerAddr                     802
	// Inq_ADLsPerAddr                 803
	// Inq_LNamesPerAddr               804
	// Inq_SSNsPerAddr                 805
	// Inq_banko_am_first_seen         808
	// Inq_banko_am_last_seen          809
	// Inq_banko_cm_first_seen         810
	// Inq_banko_cm_last_seen          811
	// Inq_banko_om_first_seen         812
	// Inq_banko_om_last_seen          813
	// pb_number_of_sources            818
	// pb_average_days_bt_orders       819
	// PAW_First_seen                  833
	// PAW_Dead_business_count         835
	// PAW_active_phone_count          836
	// PAW_Source_count                837
	// attr_arrests                    907
	// attr_arrests30                  909
	// attr_arrests90                  910
	// attr_arrests180                 911
	// attr_arrests12                  912
	// attr_arrests24                  913
	// attr_arrests36                  914
	// attr_arrests60                  915
	// fp_IDRiskType                   968
	// fp_IDVerRiskType                969
	// fp_SourceRiskType               971
	// fp_VarRiskType                  972
	// fp_VarDOBCount                  975
	// fp_VarDOBCountNew               976
	// fp_SrchVelocityRiskType         977
	// fp_SrchCountWk                  978
	// fp_SrchUnvrfdAddrCount          981
	// fp_SrchUnvrfdDOBCount           982
	// fp_SrchUnvrfdPhoneCount         983
	// fp_SrchFraudSrchCount           984
	// fp_SrchFraudSrchCountYr         985
	// fp_AssocRiskType                991
	// fp_AssocSuspicousIDCount        992
	// fp_AssocCredBureauCount         993
	// fp_ValidationRiskType           996
	// fp_CorrRiskType                 997
	// fp_CorrSSNNameCount             998
	// fp_CorrSSNAddrCount             999

//End SAS mapping variables

NULL := -999999999;


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := models.common.sas_date(if(le.Boca_Shell.historydate=999999, (string)ut.getdate, (string6)le.Boca_Shell.historydate+'01'));
// sysdate := models.common.sas_date(if(le.Boca_Shell.historydate=999999, '20150512', (string6)le.Boca_Shell.historydate+'01'));  //kh-this here just for validation - remove before migrating!!!!!

source_cr_1 := 0;

source_edaca_1 := 0;

source_edadid_1 := 0;

source_edafa_1 := 0;

source_edafla_1 := 0;

source_edahistory_1 := 0;

source_edala_1 := 0;

source_edalfa_1 := 0;

source_exp_1 := 0;

source_inf_1 := 0;

source_input_1 := 0;

source_md_1 := 0;

source_ne_1 := 0;

source_paw_1 := 0;

source_pde_1 := 0;

source_pf_1 := 0;

source_pffla_1 := 0;

source_pfla_1 := 0;

source_ppca_1 := 0;

source_ppdid_1 := 0;

source_ppfa_1 := 0;

source_ppfla_1 := 0;

source_ppla_1 := 0;

source_pplfa_1 := 0;

source_ppth_1 := 0;

source_rel_1 := 0;

source_rm_1 := 0;

source_sp_1 := 0;

source_sx_1 := 0;

source_utildid_1 := 0;

phone_pos_cr := Models.Common.findw_cpp(source_list, 'CR' , ',', 'E');

phone_pos_edaca := Models.Common.findw_cpp(source_list, 'EDACA' , ',', 'E');

phone_pos_edadid := Models.Common.findw_cpp(source_list, 'EDADID' , ',', 'E');

phone_pos_edafa := Models.Common.findw_cpp(source_list, 'EDAFA' , ',', 'E');

phone_pos_edafla := Models.Common.findw_cpp(source_list, 'EDAFLA' , ',', 'E');

phone_pos_edahistory := Models.Common.findw_cpp(source_list, 'EDAHistory' , ',', 'E');

phone_pos_edala := Models.Common.findw_cpp(source_list, 'EDALA' , ',', 'E');

phone_pos_edalfa := Models.Common.findw_cpp(source_list, 'EDALFA' , ',', 'E');

phone_pos_exp := max(Models.Common.findw_cpp(source_list, 'EXP' , ',', 'E'), Models.Common.findw_cpp(source_list, 'EQP' , ',', 'E'));

phone_pos_inf := Models.Common.findw_cpp(source_list, 'INF' , ',', 'E');

phone_pos_input := Models.Common.findw_cpp(source_list, 'INPUT' , ',', 'E');

phone_pos_md := Models.Common.findw_cpp(source_list, 'MD' , ',', 'E');

phone_pos_ne := Models.Common.findw_cpp(source_list, 'NE' , ',', 'E');

phone_pos_paw := Models.Common.findw_cpp(source_list, 'PAW' , ',', 'E');

phone_pos_pde := Models.Common.findw_cpp(source_list, 'PDE' , ',', 'E');

phone_pos_pf := Models.Common.findw_cpp(source_list, 'PF' , ',', 'E');

phone_pos_pffla := Models.Common.findw_cpp(source_list, 'PFFLA' , ',', 'E');

phone_pos_pfla := Models.Common.findw_cpp(source_list, 'PFLA' , ',', 'E');

phone_pos_ppca := Models.Common.findw_cpp(source_list, 'PPCA' , ',', 'E');

phone_pos_ppdid := Models.Common.findw_cpp(source_list, 'PPDID' , ',', 'E');

phone_pos_ppfa := Models.Common.findw_cpp(source_list, 'PPFA' , ',', 'E');

phone_pos_ppfla := Models.Common.findw_cpp(source_list, 'PPFLA' , ',', 'E');

phone_pos_ppla := Models.Common.findw_cpp(source_list, 'PPLA' , ',', 'E');

phone_pos_pplfa := Models.Common.findw_cpp(source_list, 'PPLFA' , ',', 'E');

phone_pos_ppth := Models.Common.findw_cpp(source_list, 'PPTH' , ',', 'E');

phone_pos_rel := Models.Common.findw_cpp(source_list, 'REL' , ',', 'E');

phone_pos_rm := Models.Common.findw_cpp(source_list, 'RM' , ',', 'E');

phone_pos_sp := Models.Common.findw_cpp(source_list, 'SP' , ',', 'E');

phone_pos_sx := Models.Common.findw_cpp(source_list, 'SX' , ',', 'E');

phone_pos_utildid := Models.Common.findw_cpp(source_list, 'UtilDID' , ',', 'E');

source_cr := (integer)(phone_pos_cr > 0);

source_edaca := (integer)(phone_pos_edaca > 0);

source_edadid := (integer)(phone_pos_edadid > 0);

source_edafa := (integer)(phone_pos_edafa > 0);

source_edafla := (integer)(phone_pos_edafla > 0);

source_edahistory := (integer)(phone_pos_edahistory > 0);

source_edala := (integer)(phone_pos_edala > 0);

source_edalfa := (integer)(phone_pos_edalfa > 0);

source_exp := (integer)(phone_pos_exp > 0);

source_inf := (integer)(phone_pos_inf > 0);

source_input := (integer)(phone_pos_input > 0);

source_md := (integer)(phone_pos_md > 0);

source_ne := (integer)(phone_pos_ne > 0);

source_paw := (integer)(phone_pos_paw > 0);

source_pde := (integer)(phone_pos_pde > 0);

source_pf := (integer)(phone_pos_pf > 0);

source_pffla := (integer)(phone_pos_pffla > 0);

source_pfla := (integer)(phone_pos_pfla > 0);

source_ppca := (integer)(phone_pos_ppca > 0);

source_ppdid := (integer)(phone_pos_ppdid > 0);

source_ppfa := (integer)(phone_pos_ppfa > 0);

source_ppfla := (integer)(phone_pos_ppfla > 0);

source_ppla := (integer)(phone_pos_ppla > 0);

source_pplfa := (integer)(phone_pos_pplfa > 0);

source_ppth := (integer)(phone_pos_ppth > 0);

source_rel := (integer)(phone_pos_rel > 0);

source_rm := (integer)(phone_pos_rm > 0);

source_sp := (integer)(phone_pos_sp > 0);

source_sx := (integer)(phone_pos_sx > 0);

source_utildid := (integer)(phone_pos_utildid > 0);

source_cr_lseen := Models.Common.getw(source_list_last_seen, phone_pos_cr);

source_cr_fseen := Models.Common.getw(source_list_first_seen, phone_pos_cr);

source_edaca_lseen := Models.Common.getw(source_list_last_seen, phone_pos_edaca);

source_edadid_fseen := Models.Common.getw(source_list_first_seen, phone_pos_edadid);

source_edahistory_fseen := Models.Common.getw(source_list_first_seen, phone_pos_edahistory);

source_edahistory_lseen := Models.Common.getw(source_list_last_seen, phone_pos_edahistory);

source_edala_fseen := Models.Common.getw(source_list_first_seen, phone_pos_edala);

source_exp_lseen := Models.Common.getw(source_list_last_seen, phone_pos_exp);

source_exp_fseen := Models.Common.getw(source_list_first_seen, phone_pos_exp);

source_inf_lseen := Models.Common.getw(source_list_last_seen, phone_pos_inf);

source_inf_fseen := Models.Common.getw(source_list_first_seen, phone_pos_inf);

source_input_fseen := Models.Common.getw(source_list_first_seen, phone_pos_input);

source_md_fseen := Models.Common.getw(source_list_first_seen, phone_pos_md);

source_paw_lseen := Models.Common.getw(source_list_last_seen, phone_pos_paw);

source_pf_fseen := Models.Common.getw(source_list_first_seen, phone_pos_pf);

source_ppca_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppca);

source_ppca_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppca);

source_ppdid_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppdid);

source_ppdid_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppdid);

source_ppfa_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppfa);

source_ppfa_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppfa);

source_ppfla_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppfla);

source_ppfla_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppfla);

source_ppla_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppla);

source_ppla_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppla);

source_ppth_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppth);

source_ppth_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppth);

source_rel_fseen := Models.Common.getw(source_list_first_seen, phone_pos_rel);

source_sp_lseen := Models.Common.getw(source_list_last_seen, phone_pos_sp);

source_sp_fseen := Models.Common.getw(source_list_first_seen, phone_pos_sp);

source_sx_fseen := Models.Common.getw(source_list_first_seen, phone_pos_sx);

source_utildid_fseen := Models.Common.getw(source_list_first_seen, phone_pos_utildid);

source_eda_any_clean := max((integer)source_edaca, (integer)(integer)source_edadid, (integer)(integer)source_edafa, (integer)(integer)source_edafla, (integer)(integer)source_edala, (integer)(integer)source_edalfa);

source_pp_any_clean := max((integer)source_ppca, (integer)(integer)source_ppdid, (integer)(integer)source_ppfa, (integer)(integer)source_ppfla, (integer)(integer)source_ppla, (integer)(integer)source_pplfa);

number_of_sources := (integer)source_cr +
    (integer)source_edaca +
    (integer)source_edadid +
    (integer)source_edafa +
    (integer)source_edafla +
    (integer)source_edahistory +
    (integer)source_edala +
    (integer)source_edalfa +
    (integer)source_exp +
    (integer)source_inf +
    (integer)source_input +
    (integer)source_md +
    (integer)source_ne +
    (integer)source_paw +
    (integer)source_pde +
    (integer)source_pf +
    (integer)source_pffla +
    (integer)source_pfla +
    (integer)source_ppca +
    (integer)source_ppdid +
    (integer)source_ppfa +
    (integer)source_ppfla +
    (integer)source_ppla +
    (integer)source_pplfa +
    (integer)source_ppth +
    (integer)source_rel +
    (integer)source_rm +
    (integer)source_sp +
    (integer)source_sx +
    (integer)source_utildid;

source_cr_lseen2 := models.common.sas_date((string)(source_cr_lseen));

yr_source_cr_lseen := if(min(sysdate, source_cr_lseen2) = NULL, NULL, (sysdate - source_cr_lseen2) / 365.25);

mth_source_cr_lseen_1 := if(min(sysdate, source_cr_lseen2) = NULL, NULL, roundup((sysdate - source_cr_lseen2) / 30.5));

source_cr_fseen2 := models.common.sas_date((string)(source_cr_fseen));

yr_source_cr_fseen := if(min(sysdate, source_cr_fseen2) = NULL, NULL, (sysdate - source_cr_fseen2) / 365.25);

mth_source_cr_fseen_1 := if(min(sysdate, source_cr_fseen2) = NULL, NULL, roundup((sysdate - source_cr_fseen2) / 30.5));

source_edaca_lseen2 := models.common.sas_date((string)(source_edaca_lseen));

yr_source_edaca_lseen := if(min(sysdate, source_edaca_lseen2) = NULL, NULL, (sysdate - source_edaca_lseen2) / 365.25);

mth_source_edaca_lseen_1 := if(min(sysdate, source_edaca_lseen2) = NULL, NULL, roundup((sysdate - source_edaca_lseen2) / 30.5));

source_edadid_fseen2 := models.common.sas_date((string)(source_edadid_fseen));

yr_source_edadid_fseen := if(min(sysdate, source_edadid_fseen2) = NULL, NULL, (sysdate - source_edadid_fseen2) / 365.25);

mth_source_edadid_fseen_1 := if(min(sysdate, source_edadid_fseen2) = NULL, NULL, roundup((sysdate - source_edadid_fseen2) / 30.5));

source_edahistory_lseen2 := models.common.sas_date((string)(source_edahistory_lseen));

yr_source_edahistory_lseen := if(min(sysdate, source_edahistory_lseen2) = NULL, NULL, (sysdate - source_edahistory_lseen2) / 365.25);

mth_source_edahistory_lseen_1 := if(min(sysdate, source_edahistory_lseen2) = NULL, NULL, roundup((sysdate - source_edahistory_lseen2) / 30.5));

source_edahistory_fseen2 := models.common.sas_date((string)(source_edahistory_fseen));

yr_source_edahistory_fseen := if(min(sysdate, source_edahistory_fseen2) = NULL, NULL, (sysdate - source_edahistory_fseen2) / 365.25);

mth_source_edahistory_fseen_1 := if(min(sysdate, source_edahistory_fseen2) = NULL, NULL, roundup((sysdate - source_edahistory_fseen2) / 30.5));

source_edala_fseen2 := models.common.sas_date((string)(source_edala_fseen));

yr_source_edala_fseen := if(min(sysdate, source_edala_fseen2) = NULL, NULL, (sysdate - source_edala_fseen2) / 365.25);

mth_source_edala_fseen_1 := if(min(sysdate, source_edala_fseen2) = NULL, NULL, roundup((sysdate - source_edala_fseen2) / 30.5));

source_exp_lseen2 := models.common.sas_date((string)(source_exp_lseen));

yr_source_exp_lseen := if(min(sysdate, source_exp_lseen2) = NULL, NULL, (sysdate - source_exp_lseen2) / 365.25);

mth_source_exp_lseen_1 := if(min(sysdate, source_exp_lseen2) = NULL, NULL, roundup((sysdate - source_exp_lseen2) / 30.5));

source_exp_fseen2 := models.common.sas_date((string)(source_exp_fseen));

yr_source_exp_fseen := if(min(sysdate, source_exp_fseen2) = NULL, NULL, (sysdate - source_exp_fseen2) / 365.25);

mth_source_exp_fseen_1 := if(min(sysdate, source_exp_fseen2) = NULL, NULL, roundup((sysdate - source_exp_fseen2) / 30.5));

source_inf_lseen2 := models.common.sas_date((string)(source_inf_lseen));

yr_source_inf_lseen := if(min(sysdate, source_inf_lseen2) = NULL, NULL, (sysdate - source_inf_lseen2) / 365.25);

mth_source_inf_lseen_1 := if(min(sysdate, source_inf_lseen2) = NULL, NULL, roundup((sysdate - source_inf_lseen2) / 30.5));

source_inf_fseen2 := models.common.sas_date((string)(source_inf_fseen));

yr_source_inf_fseen := if(min(sysdate, source_inf_fseen2) = NULL, NULL, (sysdate - source_inf_fseen2) / 365.25);

mth_source_inf_fseen_1 := if(min(sysdate, source_inf_fseen2) = NULL, NULL, roundup((sysdate - source_inf_fseen2) / 30.5));

source_md_fseen2 := models.common.sas_date((string)(source_md_fseen));

yr_source_md_fseen := if(min(sysdate, source_md_fseen2) = NULL, NULL, (sysdate - source_md_fseen2) / 365.25);

mth_source_md_fseen_1 := if(min(sysdate, source_md_fseen2) = NULL, NULL, roundup((sysdate - source_md_fseen2) / 30.5));

source_paw_lseen2 := models.common.sas_date((string)(source_paw_lseen));

yr_source_paw_lseen := if(min(sysdate, source_paw_lseen2) = NULL, NULL, (sysdate - source_paw_lseen2) / 365.25);

mth_source_paw_lseen_1 := if(min(sysdate, source_paw_lseen2) = NULL, NULL, roundup((sysdate - source_paw_lseen2) / 30.5));

source_pf_fseen2 := models.common.sas_date((string)(source_pf_fseen));

yr_source_pf_fseen := if(min(sysdate, source_pf_fseen2) = NULL, NULL, (sysdate - source_pf_fseen2) / 365.25);

mth_source_pf_fseen_1 := if(min(sysdate, source_pf_fseen2) = NULL, NULL, roundup((sysdate - source_pf_fseen2) / 30.5));

source_ppca_lseen2 := models.common.sas_date((string)(source_ppca_lseen));

yr_source_ppca_lseen := if(min(sysdate, source_ppca_lseen2) = NULL, NULL, (sysdate - source_ppca_lseen2) / 365.25);

mth_source_ppca_lseen_1 := if(min(sysdate, source_ppca_lseen2) = NULL, NULL, roundup((sysdate - source_ppca_lseen2) / 30.5));

source_ppca_fseen2 := models.common.sas_date((string)(source_ppca_fseen));

yr_source_ppca_fseen := if(min(sysdate, source_ppca_fseen2) = NULL, NULL, (sysdate - source_ppca_fseen2) / 365.25);

mth_source_ppca_fseen_1 := if(min(sysdate, source_ppca_fseen2) = NULL, NULL, roundup((sysdate - source_ppca_fseen2) / 30.5));

source_ppdid_lseen2 := models.common.sas_date((string)(source_ppdid_lseen));

yr_source_ppdid_lseen := if(min(sysdate, source_ppdid_lseen2) = NULL, NULL, (sysdate - source_ppdid_lseen2) / 365.25);

mth_source_ppdid_lseen_1 := if(min(sysdate, source_ppdid_lseen2) = NULL, NULL, roundup((sysdate - source_ppdid_lseen2) / 30.5));

source_ppdid_fseen2 := models.common.sas_date((string)(source_ppdid_fseen));

yr_source_ppdid_fseen := if(min(sysdate, source_ppdid_fseen2) = NULL, NULL, (sysdate - source_ppdid_fseen2) / 365.25);

mth_source_ppdid_fseen_1 := if(min(sysdate, source_ppdid_fseen2) = NULL, NULL, roundup((sysdate - source_ppdid_fseen2) / 30.5));

source_ppfa_lseen2 := models.common.sas_date((string)(source_ppfa_lseen));

yr_source_ppfa_lseen := if(min(sysdate, source_ppfa_lseen2) = NULL, NULL, (sysdate - source_ppfa_lseen2) / 365.25);

mth_source_ppfa_lseen_1 := if(min(sysdate, source_ppfa_lseen2) = NULL, NULL, roundup((sysdate - source_ppfa_lseen2) / 30.5));

source_ppfa_fseen2 := models.common.sas_date((string)(source_ppfa_fseen));

yr_source_ppfa_fseen := if(min(sysdate, source_ppfa_fseen2) = NULL, NULL, (sysdate - source_ppfa_fseen2) / 365.25);

mth_source_ppfa_fseen_1 := if(min(sysdate, source_ppfa_fseen2) = NULL, NULL, roundup((sysdate - source_ppfa_fseen2) / 30.5));

source_ppfla_lseen2 := models.common.sas_date((string)(source_ppfla_lseen));

yr_source_ppfla_lseen := if(min(sysdate, source_ppfla_lseen2) = NULL, NULL, (sysdate - source_ppfla_lseen2) / 365.25);

mth_source_ppfla_lseen_1 := if(min(sysdate, source_ppfla_lseen2) = NULL, NULL, roundup((sysdate - source_ppfla_lseen2) / 30.5));

source_ppfla_fseen2 := models.common.sas_date((string)(source_ppfla_fseen));

yr_source_ppfla_fseen := if(min(sysdate, source_ppfla_fseen2) = NULL, NULL, (sysdate - source_ppfla_fseen2) / 365.25);

mth_source_ppfla_fseen_1 := if(min(sysdate, source_ppfla_fseen2) = NULL, NULL, roundup((sysdate - source_ppfla_fseen2) / 30.5));

source_ppla_lseen2 := models.common.sas_date((string)(source_ppla_lseen));

yr_source_ppla_lseen := if(min(sysdate, source_ppla_lseen2) = NULL, NULL, (sysdate - source_ppla_lseen2) / 365.25);

mth_source_ppla_lseen_1 := if(min(sysdate, source_ppla_lseen2) = NULL, NULL, roundup((sysdate - source_ppla_lseen2) / 30.5));

source_ppla_fseen2 := models.common.sas_date((string)(source_ppla_fseen));

yr_source_ppla_fseen := if(min(sysdate, source_ppla_fseen2) = NULL, NULL, (sysdate - source_ppla_fseen2) / 365.25);

mth_source_ppla_fseen_1 := if(min(sysdate, source_ppla_fseen2) = NULL, NULL, roundup((sysdate - source_ppla_fseen2) / 30.5));

source_ppth_lseen2 := models.common.sas_date((string)(source_ppth_lseen));

yr_source_ppth_lseen := if(min(sysdate, source_ppth_lseen2) = NULL, NULL, (sysdate - source_ppth_lseen2) / 365.25);

mth_source_ppth_lseen_1 := if(min(sysdate, source_ppth_lseen2) = NULL, NULL, roundup((sysdate - source_ppth_lseen2) / 30.5));

source_ppth_fseen2 := models.common.sas_date((string)(source_ppth_fseen));

yr_source_ppth_fseen := if(min(sysdate, source_ppth_fseen2) = NULL, NULL, (sysdate - source_ppth_fseen2) / 365.25);

mth_source_ppth_fseen_1 := if(min(sysdate, source_ppth_fseen2) = NULL, NULL, roundup((sysdate - source_ppth_fseen2) / 30.5));

source_rel_fseen2 := models.common.sas_date((string)(source_rel_fseen));

yr_source_rel_fseen := if(min(sysdate, source_rel_fseen2) = NULL, NULL, (sysdate - source_rel_fseen2) / 365.25);

mth_source_rel_fseen_1 := if(min(sysdate, source_rel_fseen2) = NULL, NULL, roundup((sysdate - source_rel_fseen2) / 30.5));

source_sp_lseen2 := models.common.sas_date((string)(source_sp_lseen));

yr_source_sp_lseen := if(min(sysdate, source_sp_lseen2) = NULL, NULL, (sysdate - source_sp_lseen2) / 365.25);

mth_source_sp_lseen_1 := if(min(sysdate, source_sp_lseen2) = NULL, NULL, roundup((sysdate - source_sp_lseen2) / 30.5));

source_sp_fseen2 := models.common.sas_date((string)(source_sp_fseen));

yr_source_sp_fseen := if(min(sysdate, source_sp_fseen2) = NULL, NULL, (sysdate - source_sp_fseen2) / 365.25);

mth_source_sp_fseen_1 := if(min(sysdate, source_sp_fseen2) = NULL, NULL, roundup((sysdate - source_sp_fseen2) / 30.5));

source_sx_fseen2 := models.common.sas_date((string)(source_sx_fseen));

yr_source_sx_fseen := if(min(sysdate, source_sx_fseen2) = NULL, NULL, (sysdate - source_sx_fseen2) / 365.25);

mth_source_sx_fseen_1 := if(min(sysdate, source_sx_fseen2) = NULL, NULL, roundup((sysdate - source_sx_fseen2) / 30.5));

source_utildid_fseen2 := models.common.sas_date((string)(source_utildid_fseen));

yr_source_utildid_fseen := if(min(sysdate, source_utildid_fseen2) = NULL, NULL, (sysdate - source_utildid_fseen2) / 365.25);

mth_source_utildid_fseen_1 := if(min(sysdate, source_utildid_fseen2) = NULL, NULL, roundup((sysdate - source_utildid_fseen2) / 30.5));

eda_dt_first_seen2 := models.common.sas_date((string)(eda_dt_first_seen));

yr_eda_dt_first_seen := if(min(sysdate, eda_dt_first_seen2) = NULL, NULL, (sysdate - eda_dt_first_seen2) / 365.25);

mth_eda_dt_first_seen_1 := if(min(sysdate, eda_dt_first_seen2) = NULL, NULL, roundup((sysdate - eda_dt_first_seen2) / 30.5));

eda_dt_last_seen2 := models.common.sas_date((string)(eda_dt_last_seen));

yr_eda_dt_last_seen := if(min(sysdate, eda_dt_last_seen2) = NULL, NULL, (sysdate - eda_dt_last_seen2) / 365.25);

mth_eda_dt_last_seen_1 := if(min(sysdate, eda_dt_last_seen2) = NULL, NULL, roundup((sysdate - eda_dt_last_seen2) / 30.5));

eda_deletion_date2 := models.common.sas_date((string)(eda_deletion_date));

yr_eda_deletion_date := if(min(sysdate, eda_deletion_date2) = NULL, NULL, (sysdate - eda_deletion_date2) / 365.25);

mth_eda_deletion_date_1 := if(min(sysdate, eda_deletion_date2) = NULL, NULL, roundup((sysdate - eda_deletion_date2) / 30.5));

exp_last_update2 := models.common.sas_date((string)(exp_last_update));

yr_exp_last_update := if(min(sysdate, exp_last_update2) = NULL, NULL, (sysdate - exp_last_update2) / 365.25);

mth_exp_last_update_1 := if(min(sysdate, exp_last_update2) = NULL, NULL, roundup((sysdate - exp_last_update2) / 30.5));

internal_ver_first_seen2 := models.common.sas_date((string)(internal_ver_first_seen));

yr_internal_ver_first_seen := if(min(sysdate, internal_ver_first_seen2) = NULL, NULL, (sysdate - internal_ver_first_seen2) / 365.25);

mth_internal_ver_first_seen_1 := if(min(sysdate, internal_ver_first_seen2) = NULL, NULL, roundup((sysdate - internal_ver_first_seen2) / 30.5));

pp_datefirstseen2 := models.common.sas_date((string)(pp_datefirstseen));

yr_pp_datefirstseen := if(min(sysdate, pp_datefirstseen2) = NULL, NULL, (sysdate - pp_datefirstseen2) / 365.25);

mth_pp_datefirstseen_1 := if(min(sysdate, pp_datefirstseen2) = NULL, NULL, roundup((sysdate - pp_datefirstseen2) / 30.5));

pp_datelastseen2 := models.common.sas_date((string)(pp_datelastseen));

yr_pp_datelastseen := if(min(sysdate, pp_datelastseen2) = NULL, NULL, (sysdate - pp_datelastseen2) / 365.25);

mth_pp_datelastseen_1 := if(min(sysdate, pp_datelastseen2) = NULL, NULL, roundup((sysdate - pp_datelastseen2) / 30.5));

pp_datevendorfirstseen2 := models.common.sas_date((string)(pp_datevendorfirstseen));

yr_pp_datevendorfirstseen := if(min(sysdate, pp_datevendorfirstseen2) = NULL, NULL, (sysdate - pp_datevendorfirstseen2) / 365.25);

mth_pp_datevendorfirstseen_1 := if(min(sysdate, pp_datevendorfirstseen2) = NULL, NULL, roundup((sysdate - pp_datevendorfirstseen2) / 30.5));

pp_datevendorlastseen2 := models.common.sas_date((string)(pp_datevendorlastseen));

yr_pp_datevendorlastseen := if(min(sysdate, pp_datevendorlastseen2) = NULL, NULL, (sysdate - pp_datevendorlastseen2) / 365.25);

mth_pp_datevendorlastseen_1 := if(min(sysdate, pp_datevendorlastseen2) = NULL, NULL, roundup((sysdate - pp_datevendorlastseen2) / 30.5));

pp_date_nonglb_lastseen2 := models.common.sas_date((string)(pp_date_nonglb_lastseen));

yr_pp_date_nonglb_lastseen := if(min(sysdate, pp_date_nonglb_lastseen2) = NULL, NULL, (sysdate - pp_date_nonglb_lastseen2) / 365.25);

mth_pp_date_nonglb_lastseen_1 := if(min(sysdate, pp_date_nonglb_lastseen2) = NULL, NULL, roundup((sysdate - pp_date_nonglb_lastseen2) / 30.5));

pp_orig_lastseen2 := models.common.sas_date((string)(pp_orig_lastseen));

yr_pp_orig_lastseen := if(min(sysdate, pp_orig_lastseen2) = NULL, NULL, (sysdate - pp_orig_lastseen2) / 365.25);

mth_pp_orig_lastseen_1 := if(min(sysdate, pp_orig_lastseen2) = NULL, NULL, roundup((sysdate - pp_orig_lastseen2) / 30.5));

pp_app_npa_effective_dt2 := models.common.sas_date((string)(pp_app_npa_effective_dt));

yr_pp_app_npa_effective_dt := if(min(sysdate, pp_app_npa_effective_dt2) = NULL, NULL, (sysdate - pp_app_npa_effective_dt2) / 365.25);

mth_pp_app_npa_effective_dt_1 := if(min(sysdate, pp_app_npa_effective_dt2) = NULL, NULL, roundup((sysdate - pp_app_npa_effective_dt2) / 30.5));

pp_app_npa_last_change_dt2 := models.common.sas_date((string)(pp_app_npa_last_change_dt));

yr_pp_app_npa_last_change_dt := if(min(sysdate, pp_app_npa_last_change_dt2) = NULL, NULL, (sysdate - pp_app_npa_last_change_dt2) / 365.25);

mth_pp_app_npa_last_change_dt_1 := if(min(sysdate, pp_app_npa_last_change_dt2) = NULL, NULL, roundup((sysdate - pp_app_npa_last_change_dt2) / 30.5));

pp_eda_hist_did_dt2 := models.common.sas_date((string)(PP_EDA_Hist_did_dt));

yr_pp_eda_hist_did_dt := if(min(sysdate, pp_eda_hist_did_dt2) = NULL, NULL, (sysdate - pp_eda_hist_did_dt2) / 365.25);

mth_pp_eda_hist_did_dt_1 := if(min(sysdate, pp_eda_hist_did_dt2) = NULL, NULL, roundup((sysdate - pp_eda_hist_did_dt2) / 30.5));

pp_eda_hist_nm_addr_dt2 := models.common.sas_date((string)(PP_EDA_Hist_nm_addr_dt));

yr_pp_eda_hist_nm_addr_dt := if(min(sysdate, pp_eda_hist_nm_addr_dt2) = NULL, NULL, (sysdate - pp_eda_hist_nm_addr_dt2) / 365.25);

mth_pp_eda_hist_nm_addr_dt_1 := if(min(sysdate, pp_eda_hist_nm_addr_dt2) = NULL, NULL, roundup((sysdate - pp_eda_hist_nm_addr_dt2) / 30.5));

pp_app_fb_ph_dt2 := models.common.sas_date((string)(pp_app_fb_ph_dt));

yr_pp_app_fb_ph_dt := if(min(sysdate, pp_app_fb_ph_dt2) = NULL, NULL, (sysdate - pp_app_fb_ph_dt2) / 365.25);

mth_pp_app_fb_ph_dt_1 := if(min(sysdate, pp_app_fb_ph_dt2) = NULL, NULL, roundup((sysdate - pp_app_fb_ph_dt2) / 30.5));

pp_app_fb_ph7_did_dt2 := models.common.sas_date((string)(pp_app_fb_ph7_did_dt));

yr_pp_app_fb_ph7_did_dt := if(min(sysdate, pp_app_fb_ph7_did_dt2) = NULL, NULL, (sysdate - pp_app_fb_ph7_did_dt2) / 365.25);

mth_pp_app_fb_ph7_did_dt_1 := if(min(sysdate, pp_app_fb_ph7_did_dt2) = NULL, NULL, roundup((sysdate - pp_app_fb_ph7_did_dt2) / 30.5));

pp_app_fb_ph7_nm_addr_dt2 := models.common.sas_date((string)(pp_app_fb_ph7_nm_addr_dt));

yr_pp_app_fb_ph7_nm_addr_dt := if(min(sysdate, pp_app_fb_ph7_nm_addr_dt2) = NULL, NULL, (sysdate - pp_app_fb_ph7_nm_addr_dt2) / 365.25);

mth_pp_app_fb_ph7_nm_addr_dt_1 := if(min(sysdate, pp_app_fb_ph7_nm_addr_dt2) = NULL, NULL, roundup((sysdate - pp_app_fb_ph7_nm_addr_dt2) / 30.5));

pp_first_build_date2 := models.common.sas_date((string)(pp_first_build_date));

yr_pp_first_build_date := if(min(sysdate, pp_first_build_date2) = NULL, NULL, (sysdate - pp_first_build_date2) / 365.25);

mth_pp_first_build_date_1 := if(min(sysdate, pp_first_build_date2) = NULL, NULL, roundup((sysdate - pp_first_build_date2) / 30.5));

mth_source_cr_lseen := if(mth_source_cr_lseen_1 = NULL, -999, mth_source_cr_lseen_1);

mth_source_cr_fseen := if(mth_source_cr_fseen_1 = NULL, -999, mth_source_cr_fseen_1);

mth_source_edaca_lseen := if(mth_source_edaca_lseen_1 = NULL, -999, mth_source_edaca_lseen_1);

mth_source_edadid_fseen := if(mth_source_edadid_fseen_1 = NULL, -999, mth_source_edadid_fseen_1);

mth_source_edahistory_lseen := if(mth_source_edahistory_lseen_1 = NULL, -999, mth_source_edahistory_lseen_1);

mth_source_edahistory_fseen := if(mth_source_edahistory_fseen_1 = NULL, -999, mth_source_edahistory_fseen_1);

mth_source_edala_fseen := if(mth_source_edala_fseen_1 = NULL, -999, mth_source_edala_fseen_1);

mth_source_exp_lseen := if(mth_source_exp_lseen_1 = NULL, -999, mth_source_exp_lseen_1);

mth_source_exp_fseen := if(mth_source_exp_fseen_1 = NULL, -999, mth_source_exp_fseen_1);

mth_source_inf_lseen := if(mth_source_inf_lseen_1 = NULL, -999, mth_source_inf_lseen_1);

mth_source_inf_fseen := if(mth_source_inf_fseen_1 = NULL, -999, mth_source_inf_fseen_1);

mth_source_md_fseen := if(mth_source_md_fseen_1 = NULL, -999, mth_source_md_fseen_1);

mth_source_paw_lseen := if(mth_source_paw_lseen_1 = NULL, -999, mth_source_paw_lseen_1);

mth_source_pf_fseen := if(mth_source_pf_fseen_1 = NULL, -999, mth_source_pf_fseen_1);

mth_source_ppca_lseen := if(mth_source_ppca_lseen_1 = NULL, -999, mth_source_ppca_lseen_1);

mth_source_ppca_fseen := if(mth_source_ppca_fseen_1 = NULL, -999, mth_source_ppca_fseen_1);

mth_source_ppdid_lseen := if(mth_source_ppdid_lseen_1 = NULL, -999, mth_source_ppdid_lseen_1);

mth_source_ppdid_fseen := if(mth_source_ppdid_fseen_1 = NULL, -999, mth_source_ppdid_fseen_1);

mth_source_ppfa_lseen := if(mth_source_ppfa_lseen_1 = NULL, -999, mth_source_ppfa_lseen_1);

mth_source_ppfa_fseen := if(mth_source_ppfa_fseen_1 = NULL, -999, mth_source_ppfa_fseen_1);

mth_source_ppfla_lseen := if(mth_source_ppfla_lseen_1 = NULL, -999, mth_source_ppfla_lseen_1);

mth_source_ppfla_fseen := if(mth_source_ppfla_fseen_1 = NULL, -999, mth_source_ppfla_fseen_1);

mth_source_ppla_lseen := if(mth_source_ppla_lseen_1 = NULL, -999, mth_source_ppla_lseen_1);

mth_source_ppla_fseen := if(mth_source_ppla_fseen_1 = NULL, -999, mth_source_ppla_fseen_1);

mth_source_ppth_lseen := if(mth_source_ppth_lseen_1 = NULL, -999, mth_source_ppth_lseen_1);

mth_source_ppth_fseen := if(mth_source_ppth_fseen_1 = NULL, -999, mth_source_ppth_fseen_1);

mth_source_rel_fseen := if(mth_source_rel_fseen_1 = NULL, -999, mth_source_rel_fseen_1);

mth_source_sp_lseen := if(mth_source_sp_lseen_1 = NULL, -999, mth_source_sp_lseen_1);

mth_source_sp_fseen := if(mth_source_sp_fseen_1 = NULL, -999, mth_source_sp_fseen_1);

mth_source_sx_fseen := if(mth_source_sx_fseen_1 = NULL, -999, mth_source_sx_fseen_1);

mth_source_utildid_fseen := if(mth_source_utildid_fseen_1 = NULL, -999, mth_source_utildid_fseen_1);

mth_eda_dt_first_seen := if(mth_eda_dt_first_seen_1 = NULL, -999, mth_eda_dt_first_seen_1);

mth_eda_dt_last_seen := if(mth_eda_dt_last_seen_1 = NULL, -999, mth_eda_dt_last_seen_1);

mth_eda_deletion_date := if(mth_eda_deletion_date_1 = NULL, -999, mth_eda_deletion_date_1);

mth_exp_last_update := if(mth_exp_last_update_1 = NULL, -999, mth_exp_last_update_1);

mth_internal_ver_first_seen := if(mth_internal_ver_first_seen_1 = NULL, -999, mth_internal_ver_first_seen_1);

mth_pp_datefirstseen := if(mth_pp_datefirstseen_1 = NULL, -999, mth_pp_datefirstseen_1);

mth_pp_datelastseen := if(mth_pp_datelastseen_1 = NULL, -999, mth_pp_datelastseen_1);

mth_pp_datevendorfirstseen := if(mth_pp_datevendorfirstseen_1 = NULL, -999, mth_pp_datevendorfirstseen_1);

mth_pp_datevendorlastseen := if(mth_pp_datevendorlastseen_1 = NULL, -999, mth_pp_datevendorlastseen_1);

mth_pp_date_nonglb_lastseen := if(mth_pp_date_nonglb_lastseen_1 = NULL, -999, mth_pp_date_nonglb_lastseen_1);

mth_pp_orig_lastseen := if(mth_pp_orig_lastseen_1 = NULL, -999, mth_pp_orig_lastseen_1);

mth_pp_app_npa_effective_dt := if(mth_pp_app_npa_effective_dt_1 = NULL, -999, mth_pp_app_npa_effective_dt_1);

mth_pp_app_npa_last_change_dt := if(mth_pp_app_npa_last_change_dt_1 = NULL, -999, mth_pp_app_npa_last_change_dt_1);

mth_pp_eda_hist_did_dt := if(mth_pp_eda_hist_did_dt_1 = NULL, -999, mth_pp_eda_hist_did_dt_1);

mth_pp_eda_hist_nm_addr_dt := if(mth_pp_eda_hist_nm_addr_dt_1 = NULL, -999, mth_pp_eda_hist_nm_addr_dt_1);

mth_pp_app_fb_ph_dt := if(mth_pp_app_fb_ph_dt_1 = NULL, -999, mth_pp_app_fb_ph_dt_1);

mth_pp_app_fb_ph7_did_dt := if(mth_pp_app_fb_ph7_did_dt_1 = NULL, -999, mth_pp_app_fb_ph7_did_dt_1);

mth_pp_app_fb_ph7_nm_addr_dt := if(mth_pp_app_fb_ph7_nm_addr_dt_1 = NULL, -999, mth_pp_app_fb_ph7_nm_addr_dt_1);

mth_pp_first_build_date := if(mth_pp_first_build_date_1 = NULL, -999, mth_pp_first_build_date_1);

_phone_match_code_a := (integer)indexw(trim((string)phone_match_code, ALL), 'A', ',');

_phone_match_code_c := (integer)indexw(trim((string)phone_match_code, ALL), 'C', ',');

_phone_match_code_l := (integer)indexw(trim((string)phone_match_code, ALL), 'L', ',');

_phone_match_code_n := (integer)indexw(trim((string)phone_match_code, ALL), 'N', ',');

_phone_match_code_s := (integer)indexw(trim((string)phone_match_code, ALL), 'S', ',');

_phone_match_code_t := (integer)indexw(trim((string)phone_match_code, ALL), 'T', ',');

_phone_match_code_z := (integer)indexw(trim((string)phone_match_code, ALL), 'Z', ',');

_pp_rule_seen_once_1 := 0;

_pp_rule_high_vend_conf_1 := 0;

_pp_rule_low_vend_conf_1 := 0;

_pp_rule_cellphone_latest_1 := 0;

_pp_rule_source_latest_1 := 0;

_pp_rule_med_vend_conf_cell_1 := 0;

_pp_rule_iq_rpc_1 := 0;

_pp_rule_ins_ver_above_1 := 0;

_pp_rule_f1_ver_above_1 := 0;

_pp_rule_f1_ver_below_1 := 0;

_pp_rule_30_1 := 0;

_pp_rule_seen_once := if(((string)PP_Rules)[6..6] = '1', 1, _pp_rule_seen_once_1);

_pp_rule_high_vend_conf := if(((string)PP_Rules)[7..7] = '1', 1, _pp_rule_high_vend_conf_1);

_pp_rule_low_vend_conf := if(((string)PP_Rules)[8..8] = '1', 1, _pp_rule_low_vend_conf_1);

_pp_rule_cellphone_latest := if(((string)PP_Rules)[9..9] = '1', 1, _pp_rule_cellphone_latest_1);

_pp_rule_source_latest := if(((string)PP_Rules)[14..14] = '1', 1, _pp_rule_source_latest_1);

_pp_rule_med_vend_conf_cell := if(((string)PP_Rules)[15..15] = '1', 1, _pp_rule_med_vend_conf_cell_1);

_pp_rule_iq_rpc := if(((string)PP_Rules)[25..25] = '1', 1, _pp_rule_iq_rpc_1);

_pp_rule_ins_ver_above := if(((string)PP_Rules)[26..26] = '1', 1, _pp_rule_ins_ver_above_1);

_pp_rule_f1_ver_above := if(((string)PP_Rules)[28..28] = '1', 1, _pp_rule_f1_ver_above_1);

_pp_rule_f1_ver_below := if(((string)PP_Rules)[29..29] = '1', 1, _pp_rule_f1_ver_below_1);

_pp_rule_30 := if(((string)PP_Rules)[30..30] = '1', 1, _pp_rule_30_1);

_pp_did_flag := if(pp_did > 0, 1, 0);

_pp_src_all_eq_1 := 0;

_pp_src_all_ut_1 := 0;

_pp_src_all_uw_1 := 0;

_pp_src_all_iq_1 := 0;

_pp_src_all_eq := if(((string)PP_Src_All)[10..10] = '1', 1, _pp_src_all_eq_1);

_pp_src_all_ut := if(((string)PP_Src_All)[11..11] = '1', 1, _pp_src_all_ut_1);

_pp_src_all_uw := if(((string)PP_Src_All)[14..14] = '1', 1, _pp_src_all_uw_1);

_pp_src_all_iq := if(((string)PP_Src_All)[42..42] = '1', 1, _pp_src_all_iq_1);

_pp_app_nonpub_gong_la_1 := 0;

_pp_app_nonpub_gong_lap_1 := 0;

_pp_app_nonpub_targ_la_1 := 0;

_pp_app_nonpub_targ_lap_1 := 0;

_pp_app_nonpub_gong_la := if(((string)PP_app_NonPublished_Match)[1..1] = '1', 1, _pp_app_nonpub_gong_la_1);

_pp_app_nonpub_gong_lap := if(((string)PP_app_NonPublished_Match)[2..2] = '1', 1, _pp_app_nonpub_gong_lap_1);

_pp_app_nonpub_targ_la := if(((string)PP_app_NonPublished_Match)[5..5] = '1', 1, _pp_app_nonpub_targ_la_1);

_pp_app_nonpub_targ_lap := if(((string)PP_app_NonPublished_Match)[6..6] = '1', 1, _pp_app_nonpub_targ_lap_1);

_pp_hhid_flag := if(pp_hhid > 0, 1, 0);

_eda_hhid_flag := if(eda_hhid > 0, 1, 0);

inq_firstseen_n_1 := inq_firstseen;

inq_firstseen_n := if(inq_firstseen_n_1 = '', -999, (integer)inq_firstseen_n_1);	//kh-changed NULL to ''

inq_lastseen_n_1 := inq_lastseen;

inq_lastseen_n := if(inq_lastseen_n_1 = '', -999, (integer)inq_lastseen_n_1);	//kh-changed NULL to ''

inq_adl_firstseen_n_1 := inq_adl_firstseen;

inq_adl_firstseen_n := if(inq_adl_firstseen_n_1 = '', -999, (integer)inq_adl_firstseen_n_1);	//kh-changed NULL to ''

inq_adl_lastseen_n_1 := inq_adl_lastseen;

inq_adl_lastseen_n := if(inq_adl_lastseen_n_1 = '', -999, (integer)inq_adl_lastseen_n_1);	//kh-changed NULL to ''

_internal_ver_match_lexid := (integer)indexw(trim((string)internal_ver_match_type, ALL), '1', ',');

_internal_ver_match_spouse := (integer)indexw(trim((string)internal_ver_match_type, ALL), '2', ',');

_internal_ver_match_hhid := (integer)indexw(trim((string)internal_ver_match_type, ALL), '3', ',');

_internal_ver_match_level := map(
    _internal_ver_match_lexid = 1 and _internal_ver_match_spouse = 1 => 3,
    _internal_ver_match_lexid = 1 and _internal_ver_match_hhid = 0   => 2,
    _internal_ver_match_lexid = 1                                    => 1,
                                                                        0);

// _inq_adl_ph_industry_auto := (integer)indexw(trim((string)inq_adl_ph_industry_list_12, ALL), 'AUTO', ',');	//kh-changed to list_12
_inq_adl_ph_industry_auto := (integer)(StringLib.StringFind(trim((string)inq_adl_ph_industry_list_12, ALL), 'AUTO', 1) > 0);

// _inq_adl_ph_industry_day := (integer)indexw(trim((string)inq_adl_ph_industry_list_12, ALL), 'DAY', ',');	//kh-changed to list_12
_inq_adl_ph_industry_day := (integer)(StringLib.StringFind(trim((string)inq_adl_ph_industry_list_12, ALL), 'DAY', 1) > 0);

_inq_adl_ph_industry_flag := (integer)(inq_adl_ph_industry_list_12 != '');

_pp_gender := map(
    trim(trim((string)pp_gender, LEFT), LEFT, RIGHT) = trim(trim(' ', LEFT), LEFT, RIGHT) => 0,
    trim(trim((string)pp_gender, LEFT), LEFT, RIGHT) = trim(trim('F', LEFT), LEFT, RIGHT) => 1,
    trim(trim((string)pp_gender, LEFT), LEFT, RIGHT) = trim(trim('M', LEFT), LEFT, RIGHT) => 2,
    trim(trim((string)pp_gender, LEFT), LEFT, RIGHT) = trim(trim('U', LEFT), LEFT, RIGHT) => 3,
                                                                                             -9999);

_pp_agegroup := map(
    (integer)pp_agegroup < 31 => 0,
    (integer)pp_agegroup < 41 => 1,
																 2);

_pp_app_fb_ph := map(
    pp_app_fb_ph < 2 => 0,
    pp_app_fb_ph < 4 => 1,
                        2);

_pp_app_fb_ph7_did := map(
    pp_app_fb_ph7_did < 2 => 0,
    pp_app_fb_ph7_did < 4 => 1,
                             2);

_phone_disconnected := if(phone_disconnected < 1, 0, 1);

_phone_zip_match := if(phone_zip_match < 1, 0, 1);

_phone_timezone_match := if(phone_timezone_match < 1, 0, 1);

_phone_fb_result := map(
    phone_fb_result < 3 => 0,
    phone_fb_result < 9 => 1,
                           2);

_phone_fb_rp_result := map(
    phone_fb_rp_result < 3 => 0,
    phone_fb_rp_result < 9 => 1,
                              2);

_phone_match_code_lns := (integer)((integer)_phone_match_code_l +
    (integer)_phone_match_code_n +
    (integer)_phone_match_code_s > 0);

_phone_match_code_tcza := map(
    _phone_match_code_t = 1 and _phone_match_code_c = 1 and _phone_match_code_z = 1 and _phone_match_code_a = 1 => 4,
    _phone_match_code_t = 1 and _phone_match_code_c = 1                                                         => 3,
    _phone_match_code_t = 1                                                                                     => 2,
    _phone_match_code_c = 1 or _phone_match_code_z = 1 or _phone_match_code_a = 1                               => 1,
                                                                                                                   0);

pk_phone_match_level := map(
    _phone_match_code_lns = 1 and _phone_match_code_tcza = 4 => 4,
    _phone_match_code_lns = 1 and _phone_match_code_tcza > 0 => 3,
    _phone_match_code_lns = 1                                => 2,
    _phone_match_code_tcza > 0                               => 1,
                                                                0);

_pp_app_coctype_landline := if((trim(trim((string)pp_app_coctype, LEFT), LEFT, RIGHT) in ['EOC']), 1, 0);

_pp_app_coctype_cell := map(
    (trim(trim((string)pp_app_coctype, LEFT), LEFT, RIGHT) in ['PMC', 'RCC', 'SP1', 'SP2']) and (trim(trim((string)PP_app_SCC, LEFT), LEFT, RIGHT) in ['C', 'R', 'S']) => 1,
    (trim(trim((string)pp_app_coctype, LEFT), LEFT, RIGHT) in ['EOC']) and (trim(trim((string)PP_app_SCC, LEFT), LEFT, RIGHT) in ['C', 'R'])                           => 1,
                                                                                                                                                                          0);

_phone_switch_type_cell := if(trim(trim((string)Phone_Switch_Type, LEFT), LEFT, RIGHT) = 'C', 1, 0);

_pp_app_nxx_type_cell := if(((integer)pp_app_nxx_type in [4, 55, 65]), 1, 0);

_pp_app_ph_type_cell := if((trim(trim((string)PP_app_ph_Type, LEFT), LEFT, RIGHT) in ['CELL', 'LNDLN PRTD TO CELL']), 1, 0);

_pp_app_company_type_cell := if((PP_app_Company_Type in [5, 8]), 1, 0);

_exp_type_cell := if(trim(trim((string)Exp_Type, LEFT), LEFT, RIGHT) = 'C', 1, 0);

pk_cell_indicator := map(
    _exp_type_cell > 0 and _phone_switch_type_cell +
    _pp_rule_cellphone_latest +
    _pp_rule_med_vend_conf_cell +
    _pp_app_coctype_cell +
    _pp_app_nxx_type_cell +
    _pp_app_ph_type_cell +
    _pp_app_company_type_cell > 0 => 4,
    _phone_switch_type_cell +
    _pp_rule_cellphone_latest +
    _pp_rule_med_vend_conf_cell +
    _pp_app_coctype_cell +
    _pp_app_nxx_type_cell +
    _pp_app_ph_type_cell +
    _pp_app_company_type_cell = 7                        => 3,
    _phone_switch_type_cell = 1 and _pp_rule_cellphone_latest = 1                                                                                                                                                                          => 2,
    _phone_switch_type_cell = 1 and _pp_rule_med_vend_conf_cell = 1                                                                                                                                                                        => 1,
    _pp_app_coctype_landline = 1                                                                                                                                                                                                           => -1,
                                                                                                                                                                                                                                              0);

pk_cell_flag := if(pk_cell_indicator > 0, 1, 0);

_pp_glb_dppa_fl_glb := if(trim(trim((string)pp_glb_dppa_fl, LEFT), LEFT, RIGHT) = trim(trim('G', LEFT), LEFT, RIGHT), 1, 0);

_pp_origlistingtype_res := if(trim(trim((string)pp_origlistingtype, LEFT), LEFT, RIGHT) = trim(trim('R', LEFT), LEFT, RIGHT), 1, 0);

pk_exp_hit := if(exp_verified = 0 and trim(trim((string)exp_type, LEFT), LEFT, RIGHT) = '' and trim(trim((string)exp_source, LEFT), LEFT, RIGHT) = '' and trim(trim((string)exp_last_update, LEFT), LEFT, RIGHT) = '' and ((integer)exp_ph_score_v1 < 0 or exp_ph_score_v1 = ''), 0, 1);	//kh-check exp_ph_score

pk_pp_hit := if(trim(trim((string)pp_type, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_source, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_carrier, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_city, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_state, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_rp_type, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_rp_source, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_rp_carrier, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_rp_city, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_rp_state, LEFT), LEFT, RIGHT) = '' and pp_confidence = 0 and trim(trim((string)pp_rules, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' and pp_did = 0 and pp_did_score = 0 and trim(trim((string)pp_listing_name, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_datefirstseen, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_datelastseen, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_datevendorfirstseen, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_datevendorlastseen, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_date_nonglb_lastseen, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_glb_dppa_fl, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_glb_dppa_all, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_src, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_src_all, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' and pp_src_cnt = 0 and trim(trim((string)pp_src_rule, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' and pp_avg_source_conf = 0 and pp_max_source_conf = 0 and pp_min_source_conf = 0 and pp_total_source_conf = 0 and trim(trim((string)pp_orig_lastseen, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_did_type, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origname, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_address1, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_address2, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_address3, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origcity, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origstate, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origzip, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origphone, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_dob, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_agegroup, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_gender, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_email, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origlistingtype, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_listingtype, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origpublishcode, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origphonetype, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origphoneusage, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_company, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origphoneregdate, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origcarriercode, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origcarriername, LEFT), LEFT, RIGHT) = '' and pp_origrectype = 0 and pp_bdid = 0 and pp_bdid_score = 0 and trim(trim((string)pp_app_npa_effective_dt, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_npa_last_change_dt, LEFT), LEFT, RIGHT) = '' and pp_app_dialable_ind = 0 and trim(trim((string)pp_app_place_name, LEFT), LEFT, RIGHT) = '' and pp_app_portability_indicator = 0 and trim(trim((string)pp_app_prior_area_code, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_nonpublished_match, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' and trim(trim((string)pp_app_ocn, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_time_zone, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_nxx_type, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_coctype, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_scc, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_ph_type, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_ph_use, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_agreg_listing_type, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_eda_match, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' and pp_eda_ph_dt = 0 and trim(trim((string)pp_eda_did_dt, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_eda_nm_addr_dt, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_eda_hist_match, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' and trim(trim((string)pp_eda_hist_ph_dt, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_eda_hist_did_dt, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_eda_hist_nm_addr_dt, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_fb_ph_dt, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_fb_ph7_did_dt, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_fb_ph7_nm_addr_dt, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_ported_match, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' and pp_app_seen_once_ind = 0 and pp_app_ind_ph_cnt = 0 and pp_app_ind_has_actv_eda_ph_fl = 0 and pp_app_latest_ph_owner_fl = 0 and pp_hhid = 0 and pp_hhid_score = 0 and pp_app_best_addr_match_fl = 0 and pp_app_best_nm_match_fl = 0 and pp_rawaid = 0 and pp_cleanaid = 0 and pp_current_rec = 0 and trim(trim((string)pp_first_build_date, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_last_build_date, LEFT), LEFT, RIGHT) = '', 0, 1);
//pk_pp_hit := if(trim(trim((string)pp_type, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_source, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_carrier, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_city, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_state, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_rp_type, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_rp_source, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_rp_carrier, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_rp_city, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_rp_state, LEFT), LEFT, RIGHT) = '' and pp_confidence = 0 and trim(trim((string)pp_rules, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' and pp_did = 0 and pp_did_score = 0 and trim(trim((string)pp_listing_name, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_datefirstseen, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_datelastseen, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_datevendorfirstseen, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_datevendorlastseen, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_date_nonglb_lastseen, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_glb_dppa_fl, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_glb_dppa_all, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_src, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_src_all, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' and pp_src_cnt = 0 and trim(trim((string)pp_src_rule, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' and pp_avg_source_conf = 0 and pp_max_source_conf = 0 and pp_min_source_conf = 0 and pp_total_source_conf = 0 and trim(trim((string)pp_orig_lastseen, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_did_type, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origname, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_address1, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_address2, LEFT), LEFT, RIGHT) = '' /* zzzzzz */ and trim(trim((string)pp_address3, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origcity, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origstate, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origzip, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origphone, LEFT), LEFT, RIGHT) = '' /* zzzzzz */  and trim(trim((string)pp_dob, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_agegroup, LEFT), LEFT, RIGHT) = '' /* and trim(trim((string)pp_gender, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_email, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origlistingtype, LEFT), LEFT, RIGHT) = ''   zzzzzz and trim(trim((string)pp_listingtype, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origpublishcode, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origphonetype, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origphoneusage, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_company, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origphoneregdate, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origcarriercode, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_origcarriername, LEFT), LEFT, RIGHT) = '' and pp_origrectype = 0 and pp_bdid = 0 and pp_bdid_score = 0 and trim(trim((string)pp_app_npa_effective_dt, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_npa_last_change_dt, LEFT), LEFT, RIGHT) = '' and pp_app_dialable_ind = 0 and trim(trim((string)pp_app_place_name, LEFT), LEFT, RIGHT) = '' and pp_app_portability_indicator = 0 and trim(trim((string)pp_app_prior_area_code, LEFT), LEFT, RIGHT) = '' */ and trim(trim((string)pp_app_nonpublished_match, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' /* and trim(trim((string)pp_app_ocn, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_time_zone, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_nxx_type, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_coctype, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_scc, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_ph_type, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_ph_use, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_agreg_listing_type, LEFT), LEFT, RIGHT) = '' */ and trim(trim((string)pp_eda_match, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' /* and pp_eda_ph_dt = 0 and trim(trim((string)pp_eda_did_dt, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_eda_nm_addr_dt, LEFT), LEFT, RIGHT) = '' */ and trim(trim((string)pp_eda_hist_match, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' /* and trim(trim((string)pp_eda_hist_ph_dt, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_eda_hist_did_dt, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_eda_hist_nm_addr_dt, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_fb_ph_dt, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_fb_ph7_did_dt, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_app_fb_ph7_nm_addr_dt, LEFT), LEFT, RIGHT) = '' */ and trim(trim((string)pp_app_ported_match, LEFT), LEFT, RIGHT) = '0000000000000000000000000000000000000000000000000000000000000000' /* and pp_app_seen_once_ind = 0 and pp_app_ind_ph_cnt = 0 and pp_app_ind_has_actv_eda_ph_fl = 0 and pp_app_latest_ph_owner_fl = 0 and pp_hhid = 0 and pp_hhid_score = 0 and pp_app_best_addr_match_fl = 0 and pp_app_best_nm_match_fl = 0 and pp_rawaid = 0 and pp_cleanaid = 0 and pp_current_rec = 0 and trim(trim((string)pp_first_build_date, LEFT), LEFT, RIGHT) = '' and trim(trim((string)pp_last_build_date, LEFT), LEFT, RIGHT) = '' */ , 0, 1);

segment := map(
    pk_exp_hit = 1          => '3 - ExpHit      ',
    pk_cell_flag = 1        => '2 - Cell Phone  ',
    _phone_disconnected = 1 => '0 - Disconnected',
                               '1 - Other       ');

util_add_input_type_list_1 := util_add1_type_list;

util_add_curr_type_list_1 := if(add1_isbestmatch, util_add1_type_list, util_add2_type_list);

add_input_occupants_1yr_1 := add1_occupants_1yr;

add_input_turnover_1yr_in_1 := add1_turnover_1yr_in;

add_input_turnover_1yr_out_1 := add1_turnover_1yr_in;

add_curr_occupants_1yr_1 := if(add1_isbestmatch, add1_occupants_1yr, add2_occupants_1yr);

add_curr_turnover_1yr_in_1 := if(add1_isbestmatch, add1_turnover_1yr_in, add2_turnover_1yr_in);

add_curr_occupants_1yr_out := if(add1_isbestmatch, add1_turnover_1yr_in, add2_turnover_1yr_in);

college_income_level_code_1 := ams_income_level_code;

r_nas_addr_verd_d := (integer)(nas_summary in [3, 5, 6, 8, 10, 11, 12]);

r_pb_order_freq_d := map(
    not(truedid)                     => NULL,
    pb_number_of_sources = ''	       => NULL,
    pb_average_days_bt_orders = ''   => -1,
                                        min(if(pb_average_days_bt_orders = '', -NULL, (integer)pb_average_days_bt_orders), 999));

f_bus_name_nover_i := if(not(addrpop), NULL, (integer)(bus_name_match = 1));

f_adl_util_conv_n := (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_adl_type_list), '2', 1) > 0);

f_adl_util_misc_n := (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_adl_type_list), 'Z', 1) > 0);

f_util_adl_count_n := if(not(truedid), NULL, util_adl_count);

f_util_add_input_inf_n := (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_add_input_type_list_1), '1', 1) > 0);

f_util_add_input_conv_n := (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_add_input_type_list_1), '2', 1) > 0);

f_util_add_curr_inf_n := (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_add_curr_type_list_1), '1', 1) > 0);

f_util_add_curr_misc_n := (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_add_curr_type_list_1), 'Z', 1) > 0);

f_add_input_mobility_index_n := map(
    not(addrpop)                   => NULL,
    add_input_occupants_1yr_1 <= 0 => NULL,
                                      if(max(add_input_turnover_1yr_in_1, add_input_turnover_1yr_out_1) = NULL, NULL, sum(if(add_input_turnover_1yr_in_1 = NULL, 0, add_input_turnover_1yr_in_1), if(add_input_turnover_1yr_out_1 = NULL, 0, add_input_turnover_1yr_out_1))) / add_input_occupants_1yr_1);

f_add_curr_mobility_index_n := map(
    not(addrpop)                  => NULL,
    add_curr_occupants_1yr_1 <= 0 => NULL,
                                     if(max(add_curr_turnover_1yr_in_1, add_curr_turnover_1yr_out) = NULL, NULL, sum(if(add_curr_turnover_1yr_in_1 = NULL, 0, add_curr_turnover_1yr_in_1), if(add_curr_turnover_1yr_out = NULL, 0, add_curr_turnover_1yr_out))) / add_curr_occupants_1yr_1);

f_inq_count_i := if(not(truedid), NULL, min(if(inq_count = NULL, -NULL, inq_count), 999));

f_inq_count24_i := if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999));

f_inq_per_ssn_i := if(not(ssnlength > 0), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999));

f_inq_lnames_per_ssn_i := if(not(ssnlength > 0), NULL, min(if(inq_lnamesperssn = NULL, -NULL, inq_lnamesperssn), 999));

f_inq_addrs_per_ssn_i := if(not(ssnlength > 0), NULL, min(if(inq_addrsperssn = NULL, -NULL, inq_addrsperssn), 999));

f_inq_dobs_per_ssn_i := if(not(ssnlength > 0), NULL, min(if(inq_dobsperssn = NULL, -NULL, inq_dobsperssn), 999));

f_inq_per_addr_i := if(not(addrpop), NULL, min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999));

f_inq_adls_per_addr_i := if(not(addrpop), NULL, min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999));

f_inq_lnames_per_addr_i := if(not(addrpop), NULL, min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999));

f_inq_ssns_per_addr_i := if(not(addrpop), NULL, min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999));

_inq_banko_am_first_seen := models.common.sas_date((string)(Inq_banko_am_first_seen));

f_mos_inq_banko_am_fseen_d := map(
    not(truedid)                    => NULL,
    _inq_banko_am_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _inq_banko_am_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_am_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_am_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_am_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_am_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_am_first_seen) / (365.25 / 12)))), 999));

_inq_banko_am_last_seen := models.common.sas_date((string)(Inq_banko_am_last_seen));

f_mos_inq_banko_am_lseen_d := map(
    not(truedid)                   => NULL,
    _inq_banko_am_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _inq_banko_am_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_am_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_am_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_am_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_am_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_am_last_seen) / (365.25 / 12)))), 999)));

_inq_banko_cm_first_seen := models.common.sas_date((string)(Inq_banko_cm_first_seen));

f_mos_inq_banko_cm_fseen_d := map(
    not(truedid)                    => NULL,
    _inq_banko_cm_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)))), 999));

_inq_banko_cm_last_seen := models.common.sas_date((string)(Inq_banko_cm_last_seen));

f_mos_inq_banko_cm_lseen_d := map(
    not(truedid)                   => NULL,
    _inq_banko_cm_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)))), 999)));

_inq_banko_om_first_seen := models.common.sas_date((string)(Inq_banko_om_first_seen));

f_mos_inq_banko_om_fseen_d := map(
    not(truedid)                    => NULL,
    _inq_banko_om_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _inq_banko_om_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_om_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)))), 999));

_inq_banko_om_last_seen := models.common.sas_date((string)(Inq_banko_om_last_seen));

f_mos_inq_banko_om_lseen_d := map(
    not(truedid)                   => NULL,
    _inq_banko_om_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _inq_banko_om_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_om_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)))), 999)));

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

_foreclosure_last_date := models.common.sas_date((string)(foreclosure_last_date));

f_mos_foreclosure_lseen_d := map(
    not(truedid)                  => NULL,
    _foreclosure_last_date = NULL => 1000,
                                     max(3, min(if(if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12)))), 999)));

f_estimated_income_d := if(not(truedid), NULL, estimated_income);

f_wealth_index_d := if(not(truedid), NULL, wealth_index);

f_college_income_d := map(
    not(truedid)                       => NULL,
    college_income_level_code_1 = ''   => NULL,
    college_income_level_code_1 = 'A'  => 1,
    college_income_level_code_1 = 'B'  => 2,
    college_income_level_code_1 = 'C'  => 3,
    college_income_level_code_1 = 'D'  => 4,
    college_income_level_code_1 = 'E'  => 5,
    college_income_level_code_1 = 'F'  => 6,
    college_income_level_code_1 = 'G'  => 7,
    college_income_level_code_1 = 'H'  => 8,
    college_income_level_code_1 = 'I'  => 9,
    college_income_level_code_1 = 'J'  => 10,
    college_income_level_code_1 = 'K'  => 11,
                                          NULL);

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
                     if(max(rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_rel_homeover200_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_rel_homeover300_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_rel_homeover500_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_homeover500_count);

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

f_accident_count_i := if(not(truedid), NULL, min(if(acc_count = NULL, -NULL, acc_count), 999));

f_acc_damage_amt_total_i := if(not(truedid), NULL, acc_damage_amt_total);

_acc_last_seen := models.common.sas_date((string)(acc_last_seen));

f_mos_acc_lseen_d := map(
    not(truedid)          => NULL,
    _acc_last_seen = NULL => 1000,
                             max(3, min(if(if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12)))), 999)));

f_acc_damage_amt_last_i := if(not(truedid), NULL, acc_damage_amt_last);

f_idrisktype_i := if(not(truedid) or fp_idrisktype = '', NULL, (integer)fp_idrisktype);

f_idverrisktype_i := if(not(truedid) or fp_idverrisktype = '', NULL, (integer)fp_idverrisktype);

f_sourcerisktype_i := map(
    not(truedid)             => NULL,
    fp_sourcerisktype = ''   => NULL,
                                (integer)fp_sourcerisktype);

f_varrisktype_i := map(
    not(truedid)          => NULL,
    fp_varrisktype = '' 	=> NULL,
                             (integer)fp_varrisktype);

f_vardobcount_i := if(not(truedid), NULL, min(if(fp_vardobcount = '', -NULL, (integer)fp_vardobcount), 999));

f_vardobcountnew_i := if(not(truedid), NULL, min(if(fp_vardobcountnew = '', -NULL, (integer)fp_vardobcountnew), 999));

f_srchvelocityrisktype_i := map(
    not(truedid)                   => NULL,
    fp_srchvelocityrisktype = '' 	 => NULL,
                                      (integer)fp_srchvelocityrisktype);

f_srchunvrfdssncount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdssncount = '', -NULL, (integer)fp_srchunvrfdssncount), 999));

f_srchunvrfdaddrcount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdaddrcount = '', -NULL, (integer)fp_srchunvrfdaddrcount), 999));

f_srchunvrfdphonecount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = '', -NULL, (integer)fp_srchunvrfdphonecount), 999));

f_srchfraudsrchcount_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcount = '', -NULL, (integer)fp_srchfraudsrchcount), 999));

f_srchfraudsrchcountyr_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountyr = '', -NULL, (integer)fp_srchfraudsrchcountyr), 999));

f_srchfraudsrchcountmo_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountmo = '', -NULL, (integer)fp_srchfraudsrchcountmo), 999));

f_assocrisktype_i := map(
    not(truedid)            => NULL,
    fp_assocrisktype = ''   => NULL,
                               (integer)fp_assocrisktype);

f_assocsuspicousidcount_i := if(not(truedid), NULL, min(if(fp_assocsuspicousidcount = '', -NULL, (integer)fp_assocsuspicousidcount), 999));

f_assoccredbureaucount_i := if(not(truedid), NULL, min(if(fp_assoccredbureaucount = '', -NULL, (integer)fp_assoccredbureaucount), 999));

f_corrrisktype_i := map(
    not(truedid)           => NULL,
    fp_corrrisktype = '' => NULL,
                              (integer)fp_corrrisktype);

f_corrssnnamecount_d := if(not(truedid), NULL, min(if(fp_corrssnnamecount = '', -NULL, (integer)fp_corrssnnamecount), 999));

f_corrssnaddrcount_d := if(not(truedid), NULL, min(if(fp_corrssnaddrcount = '', -NULL, (integer)fp_corrssnaddrcount), 999));

f_corraddrnamecount_d := if(not(truedid), NULL, min(if(fp_corraddrnamecount = '', -NULL, (integer)fp_corraddrnamecount), 999));

f_divrisktype_i := map(
    not(truedid)          => NULL,
    fp_divrisktype = ''   => NULL,
                             (integer)fp_divrisktype);

f_divssnidmsrcurelcount_i := if(not(truedid), NULL, min(if(fp_divssnidmsrcurelcount = '', -NULL, (integer)fp_divssnidmsrcurelcount), 999));

f_divaddrsuspidcountnew_i := if(not(truedid), NULL, min(if(fp_divaddrsuspidcountnew = '', -NULL, (integer)fp_divaddrsuspidcountnew), 999));

f_divsrchaddrsuspidcount_i := if(not(truedid), NULL, min(if(fp_divsrchaddrsuspidcount = '', -NULL, (integer)fp_divsrchaddrsuspidcount), 999));

f_srchssnsrchcount_i := if(not(truedid), NULL, min(if(fp_srchssnsrchcount = '', -NULL, (integer)fp_srchssnsrchcount), 999));

f_srchssnsrchcountmo_i := if(not(truedid), NULL, min(if(fp_srchssnsrchcountmo = '', -NULL, (integer)fp_srchssnsrchcountmo), 999));

f_srchaddrsrchcount_i := if(not(truedid), NULL, min(if(fp_srchaddrsrchcount = '', -NULL, (integer)fp_srchaddrsrchcount), 999));

f_srchaddrsrchcountmo_i := if(not(truedid), NULL, min(if(fp_srchaddrsrchcountmo = '', -NULL, (integer)fp_srchaddrsrchcountmo), 999));

f_componentcharrisktype_i := map(
    not(truedid)                    => NULL,
    fp_componentcharrisktype = ''   => NULL,
                                       (integer)fp_componentcharrisktype);

f_addrchangeincomediff_d_1 := if(not(truedid), NULL, NULL);

f_addrchangeincomediff_d := if((integer)fp_addrchangeincomediff = -1, NULL, (integer)fp_addrchangeincomediff);

f_addrchangevaluediff_d := map(
    not(truedid)                => NULL,
    (integer)fp_addrchangevaluediff = -1 => NULL,
                                   (integer)fp_addrchangevaluediff);

f_addrchangecrimediff_i := map(
    not(truedid)                => NULL,
    (integer)fp_addrchangecrimediff = -1 => NULL,
                                   (integer)fp_addrchangecrimediff);

f_addrchangeecontrajindex_d := if(not(truedid) or fp_addrchangeecontrajindex = '' /*or f_addrchangeecontrajindex_d = -1 */, NULL, (integer)fp_addrchangeecontrajindex);

f_curraddractivephonelist_d := map(
    not(truedid)                    => NULL,
    (integer)fp_curraddractivephonelist = -1 => NULL,
                                       (integer)fp_curraddractivephonelist);

f_curraddrmedianincome_d := if(not(truedid), NULL, (integer)fp_curraddrmedianincome);

f_curraddrmedianvalue_d := if(not(truedid), NULL, (integer)fp_curraddrmedianvalue);

f_curraddrmurderindex_i := if(not(truedid), NULL, (integer)fp_curraddrmurderindex);

f_curraddrcartheftindex_i := if(not(truedid), NULL, (integer)fp_curraddrcartheftindex);

f_curraddrburglaryindex_i := if(not(truedid), NULL, (integer)fp_curraddrburglaryindex);

f_curraddrcrimeindex_i := if(not(truedid), NULL, (integer)fp_curraddrcrimeindex);

f_prevaddrageoldest_d := if(not(truedid), NULL, min(if((integer)fp_prevaddrageoldest = NULL, -NULL, (integer)fp_prevaddrageoldest), 999));

f_prevaddrlenofres_d := if(not(truedid), NULL, min(if((integer)fp_prevaddrlenofres = NULL, -NULL, (integer)fp_prevaddrlenofres), 999));

f_prevaddrdwelltype_sfd_n := if(not(truedid), NULL, (integer)(fp_prevaddrdwelltype = 'S'));

f_prevaddrstatus_i := map(
    not(truedid)            => NULL,
    fp_prevaddrstatus = '0' => 1,
    fp_prevaddrstatus = 'U' => 2,
    fp_prevaddrstatus = 'R' => 3,
                               NULL);

f_prevaddroccupantowned_d := map(
    not(truedid)                    => NULL,
    fp_prevaddroccupantowned = '' 	=> NULL,
                                       (integer)fp_prevaddroccupantowned);

f_prevaddrmedianincome_d := if(not(truedid), NULL, (integer)fp_prevaddrmedianincome);

f_prevaddrmedianvalue_d := if(not(truedid), NULL, (integer)fp_prevaddrmedianvalue);

f_prevaddrmurderindex_i := if(not(truedid), NULL, (integer)fp_prevaddrmurderindex);

f_prevaddrcartheftindex_i := if(not(truedid), NULL, (integer)fp_prevaddrcartheftindex);

f_fp_prevaddrburglaryindex_i := if(not(truedid), NULL, (integer)fp_prevaddrburglaryindex);

f_fp_prevaddrcrimeindex_i := if(not(truedid), NULL, (integer)fp_prevaddrcrimeindex);

r_has_paw_source_d := if(paw_source_count > 0, 1, 0);

_paw_first_seen := models.common.sas_date((string)(paw_first_seen));

r_mos_since_paw_fseen_d := map(
    not(truedid)                => NULL,
    not(_paw_first_seen = NULL) => min(if(if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen) / (365.25 / 12)), roundup((sysdate - _paw_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen) / (365.25 / 12)), roundup((sysdate - _paw_first_seen) / (365.25 / 12)))), 240),
                                   -1);

r_paw_dead_business_ct_i := if(not(truedid), NULL, paw_dead_business_count);

r_paw_active_phone_ct_d := if(not(truedid), NULL, paw_active_phone_count);

   final_score_0 :=  -1.4909900206;

// Tree: 1 
final_score_1 := map(
(NULL < source_rel and source_rel <= 0.5) => 0.0174689094,
(source_rel > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 22.5) => 0.6310206805,
   (f_mos_inq_banko_cm_lseen_d > 22.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 47) => -0.4279337421,
      (f_fp_prevaddrburglaryindex_i > 47) => 0.2476842960,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.1135190118, 0.1135190118),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.2067896614, 0.2067896614),
(source_rel = NULL) => 0.0250940515, 0.0250940515);

// Tree: 2 
final_score_2 := map(
(NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 16.5) => -0.0134597808,
(f_rel_homeover100_count_d > 16.5) => 
   map(
   (pp_app_coctype in ['EOC','SP2']) => -0.4820170100,
   (pp_app_coctype in ['PMC','RCC']) => 
      map(
      (NULL < mth_exp_last_update and mth_exp_last_update <= 4.5) => 0.1312936702,
      (mth_exp_last_update > 4.5) => -0.3876978261,
      (mth_exp_last_update = NULL) => -0.0061467656, -0.0061467656),
   (pp_app_coctype = '') => -0.0946332267, -0.1208996442),
(f_rel_homeover100_count_d = NULL) => -0.0231742823, -0.0231742823);

// Tree: 3 
final_score_3 := map(
(NULL < source_eda_any_clean and source_eda_any_clean <= 0.5) => -0.0264227220,
(source_eda_any_clean > 0.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -5774) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -27960.5) => -0.0411003547,
      (f_addrchangeincomediff_d > -27960.5) => 0.7389799532,
      (f_addrchangeincomediff_d = NULL) => 0.4385045754, 0.4385045754),
   (f_addrchangeincomediff_d > -5774) => -0.0169514646,
   (f_addrchangeincomediff_d = NULL) => 0.1345829377, 0.1364693813),
(source_eda_any_clean = NULL) => -0.0160667435, -0.0160667435);

// Tree: 4 
final_score_4 := map(
(NULL < mth_source_exp_fseen and mth_source_exp_fseen <= 3.5) => 0.0180589880,
(mth_source_exp_fseen > 3.5) => 
   map(
   (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 1.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.239793807433075) => 0.2464601787,
      (f_add_input_mobility_index_n > 0.239793807433075) => -0.1541843241,
      (f_add_input_mobility_index_n = NULL) => -0.0891927107, -0.0891927107),
   (f_rel_ageover50_count_d > 1.5) => -0.5772027490,
   (f_rel_ageover50_count_d = NULL) => -0.1475796260, -0.1475796260),
(mth_source_exp_fseen = NULL) => 0.0071987112, 0.0071987112);

// Tree: 5 
final_score_5 := map(
(NULL < source_sx and source_sx <= 0.5) => -0.0149177556,
(source_sx > 0.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 0.5) => 0.4171621904,
   (f_srchssnsrchcount_i > 0.5) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 85438.5) => -0.4412464527,
      (f_curraddrmedianvalue_d > 85438.5) => 0.1320155473,
      (f_curraddrmedianvalue_d = NULL) => 0.0173631473, 0.0173631473),
   (f_srchssnsrchcount_i = NULL) => 0.1641248214, 0.1641248214),
(source_sx = NULL) => -0.0049814272, -0.0049814272);

// Tree: 6 
final_score_6 := map(
(NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.14826121548095) => 0.8341843813,
   (f_add_input_mobility_index_n > 0.14826121548095) => 0.0141517849,
   (f_add_input_mobility_index_n = NULL) => 0.0289963201, 0.0289963201),
(f_crim_rel_under25miles_cnt_i > 0.5) => 
   map(
   (NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 16.5) => -0.0574722791,
   (mth_source_ppla_lseen > 16.5) => -0.3717074620,
   (mth_source_ppla_lseen = NULL) => -0.0671300479, -0.0671300479),
(f_crim_rel_under25miles_cnt_i = NULL) => -0.0305223086, -0.0305223086);

// Tree: 7 
final_score_7 := map(
(NULL < r_paw_dead_business_ct_i and r_paw_dead_business_ct_i <= 0.5) => 0.0201383412,
(r_paw_dead_business_ct_i > 0.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 156.5) => 
      map(
      (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => -0.1032541989,
      (f_prevaddrstatus_i > 2.5) => -0.3459055487,
      (f_prevaddrstatus_i = NULL) => 0.2380420650, -0.0251091241),
   (r_pb_order_freq_d > 156.5) => -0.4857917776,
   (r_pb_order_freq_d = NULL) => -0.2161417312, -0.1559766237),
(r_paw_dead_business_ct_i = NULL) => 0.0081773716, 0.0081773716);

// Tree: 8 
final_score_8 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 0.5) => 
   map(
   (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 76.5) => 
      map(
      (NULL < eda_months_addr_last_seen and eda_months_addr_last_seen <= 0.5) => -0.0057665853,
      (eda_months_addr_last_seen > 0.5) => 0.5126794088,
      (eda_months_addr_last_seen = NULL) => 0.0493183016, 0.0493183016),
   (mth_pp_eda_hist_did_dt > 76.5) => 0.6245434670,
   (mth_pp_eda_hist_did_dt = NULL) => 0.0986233158, 0.0986233158),
(f_rel_incomeover50_count_d > 0.5) => -0.0297045921,
(f_rel_incomeover50_count_d = NULL) => -0.0191488300, -0.0191488300);

// Tree: 9 
final_score_9 := map(
(pp_origphonetype in ['O','W']) => -0.0909462367,
(pp_origphonetype in ['L','V']) => 0.0149315039,
(pp_origphonetype = '') => 
   map(
   (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0446396396,
   (_phone_match_code_n > 0.5) => 
      map(
      (phone_subject_title in ['Associate','Daughter','Sister','Subject','Wife']) => 0.0852021132,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Son','Spouse','Subject at Household']) => 0.9570465335,
      (phone_subject_title = '') => 0.1174467148, 0.1174467148),
   (_phone_match_code_n = NULL) => 0.0121916358, 0.0121916358), -0.0143073404);

// Tree: 10 
final_score_10 := map(
(pp_type in ['M','U']) => -0.0088184284,
(pp_type in ['B','R']) => 0.4351808002,
(pp_type = '') => 
   map(
   (NULL < pk_phone_match_level and pk_phone_match_level <= 3.5) => 
      map(
      (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0138137509,
      (_phone_match_code_n > 0.5) => 0.1211476337,
      (_phone_match_code_n = NULL) => 0.0133461413, 0.0133461413),
   (pk_phone_match_level > 3.5) => -0.1463996327,
   (pk_phone_match_level = NULL) => -0.0068427459, -0.0068427459), -0.0043401562);

// Tree: 11 
final_score_11 := map(
(NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 168.5) => -0.0258436731,
(mth_pp_app_npa_effective_dt > 168.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Mother','Neighbor','Relative','Sister','Subject at Household','Wife']) => -0.0562086781,
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Parent','Sibling','Son','Spouse','Subject']) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 94.5) => 0.2430575372,
      (mth_pp_app_npa_last_change_dt > 94.5) => 0.0452179967,
      (mth_pp_app_npa_last_change_dt = NULL) => 0.1361312059, 0.1361312059),
   (phone_subject_title = '') => 0.0753380640, 0.0753380640),
(mth_pp_app_npa_effective_dt = NULL) => -0.0059413996, -0.0059413996);

// Tree: 12 
final_score_12 := map(
(NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 2.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 61.5) => -0.0026598621,
   (r_pb_order_freq_d > 61.5) => -0.4150869330,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 9.5) => 0.0772305424,
      (f_srchaddrsrchcount_i > 9.5) => -0.5010407665,
      (f_srchaddrsrchcount_i = NULL) => -0.0521842831, -0.0521842831), -0.1038700253),
(f_rel_educationover12_count_d > 2.5) => 0.0255199495,
(f_rel_educationover12_count_d = NULL) => 0.0144107092, 0.0144107092);

// Tree: 13 
final_score_13 := map(
(NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 194.5) => -0.0048417551,
(f_prevaddrmurderindex_i > 194.5) => 
   map(
   (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 6.5) => 0.6293207466,
   (f_rel_ageover20_count_d > 6.5) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 2.5) => 0.3755832774,
      (inq_firstseen_n > 2.5) => -0.1764036963,
      (inq_firstseen_n = NULL) => 0.0833548795, 0.0833548795),
   (f_rel_ageover20_count_d = NULL) => 0.2257807579, 0.2257807579),
(f_prevaddrmurderindex_i = NULL) => 0.0032606871, 0.0032606871);

// Tree: 14 
final_score_14 := map(
(NULL < f_inq_per_addr_i and f_inq_per_addr_i <= 14.5) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 10.5) => -0.0391477121,
   (f_rel_incomeover25_count_d > 10.5) => 0.0418657998,
   (f_rel_incomeover25_count_d = NULL) => 0.0013246453, 0.0013246453),
(f_inq_per_addr_i > 14.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 84) => 0.1244783377,
   (f_prevaddrcartheftindex_i > 84) => -0.4951884704,
   (f_prevaddrcartheftindex_i = NULL) => -0.2794526187, -0.2794526187),
(f_inq_per_addr_i = NULL) => -0.0075513483, -0.0075513483);

// Tree: 15 
final_score_15 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 67.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 262.5) => 0.0357385984,
   (f_prevaddrlenofres_d > 262.5) => 
      map(
      (NULL < _pp_glb_dppa_fl_glb and _pp_glb_dppa_fl_glb <= 0.5) => -0.0023310296,
      (_pp_glb_dppa_fl_glb > 0.5) => -0.2829408751,
      (_pp_glb_dppa_fl_glb = NULL) => -0.0706812869, -0.0706812869),
   (f_prevaddrlenofres_d = NULL) => 0.0224155133, 0.0224155133),
(mth_exp_last_update > 67.5) => -0.2871252005,
(mth_exp_last_update = NULL) => 0.0171967025, 0.0171967025);

// Tree: 16 
final_score_16 := map(
(exp_source in ['P']) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 3.5) => -0.3445265722,
   (r_pb_order_freq_d > 3.5) => 0.0906276101,
   (r_pb_order_freq_d = NULL) => -0.1486321745, -0.1100806910),
(exp_source in ['S']) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 24856) => 0.3159018842,
   (f_prevaddrmedianincome_d > 24856) => -0.0031773448,
   (f_prevaddrmedianincome_d = NULL) => 0.0308678605, 0.0308678605),
(exp_source = '') => 0.0156188859, 0.0116548794);

// Tree: 17 
final_score_17 := map(
(NULL < mth_source_exp_lseen and mth_source_exp_lseen <= 6.5) => 0.0056715745,
(mth_source_exp_lseen > 6.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 37.5) => -0.4268780823,
   (f_mos_inq_banko_om_fseen_d > 37.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 156.5) => -0.1431834475,
      (f_curraddrburglaryindex_i > 156.5) => 0.3051747437,
      (f_curraddrburglaryindex_i = NULL) => -0.0406578543, -0.0406578543),
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.1381981669, -0.1381981669),
(mth_source_exp_lseen = NULL) => -0.0009315093, -0.0009315093);

// Tree: 18 
final_score_18 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.971082029592235) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 726512) => -0.0100066369,
   (f_prevaddrmedianvalue_d > 726512) => 0.3343208337,
   (f_prevaddrmedianvalue_d = NULL) => -0.0069741957, -0.0069741957),
(f_add_curr_mobility_index_n > 0.971082029592235) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -33952) => 0.7653404463,
   (f_addrchangevaluediff_d > -33952) => -0.0003174081,
   (f_addrchangevaluediff_d = NULL) => 0.3131802961, 0.3131802961),
(f_add_curr_mobility_index_n = NULL) => 0.0559344554, -0.0001183486);

// Tree: 19 
final_score_19 := map(
(NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 107.5) => -0.0057297863,
(mth_source_cr_fseen > 107.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 132) => -0.1170356905,
   (f_prevaddrageoldest_d > 132) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 3.5) => 1.0886399710,
      (f_rel_ageover40_count_d > 3.5) => 0.1686185502,
      (f_rel_ageover40_count_d = NULL) => 0.6415267571, 0.6415267571),
   (f_prevaddrageoldest_d = NULL) => 0.3193416315, 0.3193416315),
(mth_source_cr_fseen = NULL) => 0.0013493946, 0.0013493946);

// Tree: 20 
final_score_20 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.422452132915545) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Brother','Child','Daughter','Father','Granddaughter','Husband','Neighbor','Parent','Sister','Subject']) => 0.0257731686,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Grandchild','Grandfather','Grandmother','Grandparent','Grandson','Mother','Relative','Sibling','Son','Spouse','Subject at Household','Wife']) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 36.5) => 0.5646056397,
      (f_mos_inq_banko_cm_fseen_d > 36.5) => 0.0844800511,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.1208226104, 0.1208226104),
   (phone_subject_title = '') => 0.0467872605, 0.0467872605),
(f_add_input_mobility_index_n > 0.422452132915545) => -0.0215624912,
(f_add_input_mobility_index_n = NULL) => 0.2455149762, 0.0238517287);

// Tree: 21 
final_score_21 := map(
(NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 3.5) => 
   map(
   (NULL < mth_pp_datevendorlastseen and mth_pp_datevendorlastseen <= 10.5) => 0.0421494634,
   (mth_pp_datevendorlastseen > 10.5) => 0.4701398939,
   (mth_pp_datevendorlastseen = NULL) => 0.0979920243, 0.0979920243),
(f_corrssnnamecount_d > 3.5) => 
   map(
   (NULL < eda_num_phs_connected_addr and eda_num_phs_connected_addr <= 1.5) => -0.0262617973,
   (eda_num_phs_connected_addr > 1.5) => -0.5108162010,
   (eda_num_phs_connected_addr = NULL) => -0.0324723744, -0.0324723744),
(f_corrssnnamecount_d = NULL) => -0.0164316696, -0.0164316696);

// Tree: 22 
final_score_22 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 35.5) => 0.0171911588,
(inq_adl_lastseen_n > 35.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 4.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 82) => -0.3533656087,
      (f_fp_prevaddrcrimeindex_i > 82) => 0.1071448611,
      (f_fp_prevaddrcrimeindex_i = NULL) => -0.0419977342, -0.0419977342),
   (f_srchfraudsrchcount_i > 4.5) => -0.5006121807,
   (f_srchfraudsrchcount_i = NULL) => -0.2410747447, -0.2410747447),
(inq_adl_lastseen_n = NULL) => 0.0077870263, 0.0077870263);

// Tree: 23 
final_score_23 := map(
(NULL < f_inq_ssns_per_addr_i and f_inq_ssns_per_addr_i <= 4.5) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 15.5) => 0.0078619242,
   (mth_exp_last_update > 15.5) => 
      map(
      (NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 136) => -0.3662781175,
      (f_mos_acc_lseen_d > 136) => -0.0635067568,
      (f_mos_acc_lseen_d = NULL) => -0.1144518695, -0.1144518695),
   (mth_exp_last_update = NULL) => -0.0031520427, -0.0031520427),
(f_inq_ssns_per_addr_i > 4.5) => 0.2158188244,
(f_inq_ssns_per_addr_i = NULL) => 0.0076926683, 0.0076926683);

// Tree: 24 
final_score_24 := map(
(NULL < source_rel and source_rel <= 0.5) => 0.0046034807,
(source_rel > 0.5) => 
   map(
   (NULL < _phone_zip_match and _phone_zip_match <= 0.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 4.5) => 0.3367676179,
      (f_rel_criminal_count_i > 4.5) => -0.0111150976,
      (f_rel_criminal_count_i = NULL) => 0.2249481736, 0.2249481736),
   (_phone_zip_match > 0.5) => -0.3098611086,
   (_phone_zip_match = NULL) => 0.1371436646, 0.1371436646),
(source_rel = NULL) => 0.0098020478, 0.0098020478);

// Tree: 25 
final_score_25 := map(
(NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 2.5) => 0.0024228154,
(f_rel_incomeover100_count_d > 2.5) => 
   map(
   (NULL < mth_pp_datevendorlastseen and mth_pp_datevendorlastseen <= 5.5) => 
      map(
      (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.2037006596,
      (_phone_match_code_n > 0.5) => 0.0808968378,
      (_phone_match_code_n = NULL) => -0.0848415232, -0.0848415232),
   (mth_pp_datevendorlastseen > 5.5) => -0.2996386805,
   (mth_pp_datevendorlastseen = NULL) => -0.1274883600, -0.1274883600),
(f_rel_incomeover100_count_d = NULL) => -0.0122490032, -0.0122490032);

// Tree: 26 
final_score_26 := map(
(NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 20.5) => -0.0083073985,
(f_rel_ageover30_count_d > 20.5) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 150.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By Vehicle','Brother','Father','Grandfather','Grandmother','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => 0.1263541185,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Child','Daughter','Grandchild','Granddaughter','Grandparent','Grandson','Subject at Household']) => 0.4178627234,
      (phone_subject_title = '') => 0.1681279372, 0.1681279372),
   (f_curraddrburglaryindex_i > 150.5) => -0.1750687873,
   (f_curraddrburglaryindex_i = NULL) => 0.0628710585, 0.0628710585),
(f_rel_ageover30_count_d = NULL) => -0.0005713361, -0.0005713361);

// Tree: 27 
final_score_27 := map(
(NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 1.5) => -0.0050700188,
(f_srchaddrsrchcountmo_i > 1.5) => 
   map(
   (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 20.5) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => -0.1499628387,
      (f_sourcerisktype_i > 4.5) => 0.3491879401,
      (f_sourcerisktype_i = NULL) => 0.0817857372, 0.0817857372),
   (mth_pp_datefirstseen > 20.5) => 0.5222684951,
   (mth_pp_datefirstseen = NULL) => 0.2029541334, 0.2029541334),
(f_srchaddrsrchcountmo_i = NULL) => 0.0024577319, 0.0024577319);

// Tree: 28 
final_score_28 := map(
(NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 33.5) => 
   map(
   (NULL < eda_days_in_service and eda_days_in_service <= 104.5) => 
      map(
      (NULL < inq_lastseen_n and inq_lastseen_n <= 3.5) => 0.1198439895,
      (inq_lastseen_n > 3.5) => -0.0097661014,
      (inq_lastseen_n = NULL) => 0.0613454753, 0.0613454753),
   (eda_days_in_service > 104.5) => -0.0257516424,
   (eda_days_in_service = NULL) => 0.0149460308, 0.0149460308),
(mth_source_ppdid_fseen > 33.5) => -0.0822334129,
(mth_source_ppdid_fseen = NULL) => 0.0048423724, 0.0048423724);

// Tree: 29 
final_score_29 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 156877) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 152028.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 97.5) => -0.1198832855,
      (f_fp_prevaddrburglaryindex_i > 97.5) => 0.0071856902,
      (f_fp_prevaddrburglaryindex_i = NULL) => -0.0292062478, -0.0292062478),
   (f_prevaddrmedianvalue_d > 152028.5) => -0.3647248257,
   (f_prevaddrmedianvalue_d = NULL) => -0.0416639672, -0.0416639672),
(f_prevaddrmedianvalue_d > 156877) => 0.0484723592,
(f_prevaddrmedianvalue_d = NULL) => -0.0021264170, -0.0021264170);

// Tree: 30 
final_score_30 := map(
(NULL < eda_disc_cnt18 and eda_disc_cnt18 <= 0.5) => 
   map(
   (NULL < mth_source_inf_lseen and mth_source_inf_lseen <= 3.5) => 0.0248410096,
   (mth_source_inf_lseen > 3.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 29603) => 0.2850473289,
      (f_prevaddrmedianincome_d > 29603) => -0.1853996691,
      (f_prevaddrmedianincome_d = NULL) => -0.1110544181, -0.1110544181),
   (mth_source_inf_lseen = NULL) => 0.0184657501, 0.0184657501),
(eda_disc_cnt18 > 0.5) => -0.1894886432,
(eda_disc_cnt18 = NULL) => 0.0108448948, 0.0108448948);

// Tree: 31 
final_score_31 := map(
(NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 16.5) => 
   map(
   (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 46.5) => 
      map(
      (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 28.5) => -0.0138385360,
      (mth_pp_datefirstseen > 28.5) => 0.0933724290,
      (mth_pp_datefirstseen = NULL) => 0.0010722154, 0.0010722154),
   (mth_pp_datelastseen > 46.5) => -0.1922242705,
   (mth_pp_datelastseen = NULL) => -0.0080528790, -0.0080528790),
(mth_source_rel_fseen > 16.5) => -0.2558051561,
(mth_source_rel_fseen = NULL) => -0.0106345384, -0.0106345384);

// Tree: 32 
final_score_32 := map(
(NULL < pp_app_company_type and pp_app_company_type <= 7.5) => -0.0056875298,
(pp_app_company_type > 7.5) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 41.5) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 134.5) => 0.5910669081,
      (mth_pp_app_npa_effective_dt > 134.5) => 0.0601784284,
      (mth_pp_app_npa_effective_dt = NULL) => 0.3031273937, 0.3031273937),
   (mth_pp_app_npa_last_change_dt > 41.5) => 0.0041476071,
   (mth_pp_app_npa_last_change_dt = NULL) => 0.1017399026, 0.1017399026),
(pp_app_company_type = NULL) => 0.0034062570, 0.0034062570);

// Tree: 33 
final_score_33 := map(
(NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => -0.0274643155,
(f_sourcerisktype_i > 5.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By SSN','Child','Granddaughter','Grandfather','Grandmother','Grandparent','Neighbor','Relative','Sister','Subject']) => 0.0042102908,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Vehicle','Brother','Daughter','Father','Grandchild','Grandson','Husband','Mother','Parent','Sibling','Son','Spouse','Subject at Household','Wife']) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 7.5) => 0.1520268824,
      (f_corrssnnamecount_d > 7.5) => 0.6904045547,
      (f_corrssnnamecount_d = NULL) => 0.2377387506, 0.2377387506),
   (phone_subject_title = '') => 0.0493224680, 0.0493224680),
(f_sourcerisktype_i = NULL) => -0.0087509654, -0.0087509654);

// Tree: 34 
final_score_34 := map(
(NULL < source_eda_any_clean and source_eda_any_clean <= 0.5) => -0.0043380924,
(source_eda_any_clean > 0.5) => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 2613.5) => -0.0710040300,
   (eda_days_ph_first_seen > 2613.5) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 10.5) => 0.1597061522,
      (f_rel_incomeover50_count_d > 10.5) => 0.6885357020,
      (f_rel_incomeover50_count_d = NULL) => 0.2304943597, 0.2304943597),
   (eda_days_ph_first_seen = NULL) => 0.1418183627, 0.1418183627),
(source_eda_any_clean = NULL) => 0.0049710179, 0.0049710179);

// Tree: 35 
final_score_35 := map(
(NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 1938) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Child','Daughter','Father','Granddaughter','Grandfather','Grandmother','Grandson','Husband','Neighbor','Sister','Son','Spouse','Subject','Subject at Household']) => 0.0004938166,
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Grandchild','Grandparent','Mother','Parent','Relative','Sibling','Wife']) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 177.5) => 0.0867440274,
      (f_curraddrcrimeindex_i > 177.5) => 0.4135412100,
      (f_curraddrcrimeindex_i = NULL) => 0.1353473882, 0.1353473882),
   (phone_subject_title = '') => 0.0198266940, 0.0198266940),
(eda_avg_days_interrupt > 1938) => -0.4653669285,
(eda_avg_days_interrupt = NULL) => 0.0168726994, 0.0168726994);

// Tree: 36 
final_score_36 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.202046118169655) => -0.1259872948,
(f_add_input_mobility_index_n > 0.202046118169655) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.209211264171635) => 
      map(
      (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 0.5) => -0.0688371707,
      (f_rel_bankrupt_count_i > 0.5) => 0.4867561195,
      (f_rel_bankrupt_count_i = NULL) => 0.2704564416, 0.2704564416),
   (f_add_input_mobility_index_n > 0.209211264171635) => 0.0006896964,
   (f_add_input_mobility_index_n = NULL) => 0.0052941842, 0.0052941842),
(f_add_input_mobility_index_n = NULL) => -0.1685946169, -0.0083660750);

// Tree: 37 
final_score_37 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.264386099633105) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Father','Granddaughter','Grandfather','Grandmother','Mother','Neighbor','Relative','Sibling','Son','Spouse','Subject','Wife']) => 0.0320652895,
   (phone_subject_title in ['Associate By Vehicle','Grandchild','Grandparent','Grandson','Husband','Parent','Sister','Subject at Household']) => 
      map(
      (NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 18.5) => 0.4474544493,
      (mth_source_ppla_lseen > 18.5) => -0.1353707000,
      (mth_source_ppla_lseen = NULL) => 0.3232458110, 0.3232458110),
   (phone_subject_title = '') => 0.0643892419, 0.0643892419),
(f_add_curr_mobility_index_n > 0.264386099633105) => -0.0211138335,
(f_add_curr_mobility_index_n = NULL) => 0.0821452269, 0.0019177529);

// Tree: 38 
final_score_38 := map(
(NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 2.5) => -0.0231252084,
(mth_source_rel_fseen > 2.5) => 
   map(
   (NULL < f_prevaddroccupantowned_d and f_prevaddroccupantowned_d <= 0.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 88.5) => 0.3315923504,
      (f_prevaddrageoldest_d > 88.5) => 0.0356670919,
      (f_prevaddrageoldest_d = NULL) => 0.1731544908, 0.1731544908),
   (f_prevaddroccupantowned_d > 0.5) => -0.1502894502,
   (f_prevaddroccupantowned_d = NULL) => 0.1080085380, 0.1080085380),
(mth_source_rel_fseen = NULL) => -0.0187801844, -0.0187801844);

// Tree: 39 
final_score_39 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0007404225,
(source_utildid > 0.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 12.5) => 
      map(
      (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 5) => 0.5148013762,
      (inq_adl_firstseen_n > 5) => -0.1357293382,
      (inq_adl_firstseen_n = NULL) => 0.2841167257, 0.2841167257),
   (mth_source_utildid_fseen > 12.5) => 0.0344890123,
   (mth_source_utildid_fseen = NULL) => 0.0776761382, 0.0776761382),
(source_utildid = NULL) => 0.0067422489, 0.0067422489);

// Tree: 40 
final_score_40 := map(
(pp_src in ['CY','E1','FA','LP','NW','PL','UW','VW','ZK','ZT']) => -0.1148151463,
(pp_src in ['E2','EB','EM','EN','EQ','FF','KW','LA','MD','SL','TN','UT','VO']) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 3.5) => -0.1824018832,
   (f_rel_ageover30_count_d > 3.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 73.5) => 0.2133680156,
      (f_prevaddrmurderindex_i > 73.5) => 0.0137039068,
      (f_prevaddrmurderindex_i = NULL) => 0.0786243283, 0.0786243283),
   (f_rel_ageover30_count_d = NULL) => 0.0471379201, 0.0471379201),
(pp_src = '') => 0.0036760525, 0.0048132575);

// Tree: 41 
final_score_41 := map(
(NULL < f_wealth_index_d and f_wealth_index_d <= 4.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 0.0229107487,
   (f_srchvelocityrisktype_i > 5.5) => -0.0749957218,
   (f_srchvelocityrisktype_i = NULL) => -0.0165597294, -0.0165597294),
(f_wealth_index_d > 4.5) => 
   map(
   (pp_app_ph_use in ['B','P']) => -0.0288393757,
   (pp_app_ph_use in ['O']) => 0.3454293019,
   (pp_app_ph_use = '') => 0.1346756649, 0.1452930704),
(f_wealth_index_d = NULL) => -0.0017579687, -0.0017579687);

// Tree: 42 
final_score_42 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0165869983,
(source_utildid > 0.5) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => 
      map(
      (NULL < pp_origconfscore and pp_origconfscore <= 1.5) => 0.2497075036,
      (pp_origconfscore > 1.5) => -0.0714938206,
      (pp_origconfscore = NULL) => 0.1377906659, 0.1377906659),
   (f_sourcerisktype_i > 5.5) => -0.1109171669,
   (f_sourcerisktype_i = NULL) => 0.0664223313, 0.0664223313),
(source_utildid = NULL) => -0.0087632645, -0.0087632645);

// Tree: 43 
final_score_43 := map(
(NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 108) => 
   map(
   (NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 65.5) => -0.1805920508,
   (f_mos_inq_banko_am_lseen_d > 65.5) => -0.0029600575,
   (f_mos_inq_banko_am_lseen_d = NULL) => -0.0083712504, -0.0083712504),
(mth_source_cr_fseen > 108) => 
   map(
   (NULL < _phone_match_code_lns and _phone_match_code_lns <= 0.5) => 0.0545058250,
   (_phone_match_code_lns > 0.5) => 0.5067978701,
   (_phone_match_code_lns = NULL) => 0.1843718577, 0.1843718577),
(mth_source_cr_fseen = NULL) => -0.0038127552, -0.0038127552);

// Tree: 44 
final_score_44 := map(
(NULL < f_idrisktype_i and f_idrisktype_i <= 1.5) => 0.0169369679,
(f_idrisktype_i > 1.5) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => -0.3618215828,
   (f_sourcerisktype_i > 5.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 282184.5) => 0.3797642233,
      (f_prevaddrmedianvalue_d > 282184.5) => -0.3208343879,
      (f_prevaddrmedianvalue_d = NULL) => 0.1446640182, 0.1446640182),
   (f_sourcerisktype_i = NULL) => -0.1637471614, -0.1637471614),
(f_idrisktype_i = NULL) => 0.0088760015, 0.0088760015);

// Tree: 45 
final_score_45 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 110228) => 
   map(
   (NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 21.5) => 0.0186435536,
   (mth_source_cr_fseen > 21.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -12476.5) => 0.3271495786,
      (f_addrchangeincomediff_d > -12476.5) => -0.2341208464,
      (f_addrchangeincomediff_d = NULL) => -0.2696649032, -0.1398454357),
   (mth_source_cr_fseen = NULL) => 0.0098332780, 0.0098332780),
(f_prevaddrmedianincome_d > 110228) => -0.1631252705,
(f_prevaddrmedianincome_d = NULL) => 0.0040821683, 0.0040821683);

// Tree: 46 
final_score_46 := map(
(NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 86.5) => 
   map(
   (NULL < inq_num_addresses and inq_num_addresses <= 8.5) => 
      map(
      (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 8.5) => 0.0021186067,
      (f_rel_incomeover100_count_d > 8.5) => -0.2518049571,
      (f_rel_incomeover100_count_d = NULL) => -0.0003144853, -0.0003144853),
   (inq_num_addresses > 8.5) => -0.4493723144,
   (inq_num_addresses = NULL) => -0.0035615844, -0.0035615844),
(mth_source_ppfla_fseen > 86.5) => -0.2372448720,
(mth_source_ppfla_fseen = NULL) => -0.0064344032, -0.0064344032);

// Tree: 47 
final_score_47 := map(
(NULL < eda_num_ph_owners_hist and eda_num_ph_owners_hist <= 1.5) => 0.0142990568,
(eda_num_ph_owners_hist > 1.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 350.5) => 
      map(
      (phone_subject_title in ['Associate By SSN','Associate By Vehicle','Child','Granddaughter','Grandson','Mother','Parent','Relative','Son','Spouse','Subject','Subject at Household','Wife']) => -0.1710877580,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Brother','Daughter','Father','Grandchild','Grandfather','Grandmother','Grandparent','Husband','Neighbor','Sibling','Sister']) => -0.0255543513,
      (phone_subject_title = '') => -0.0853501628, -0.0853501628),
   (f_prevaddrageoldest_d > 350.5) => 0.2781532727,
   (f_prevaddrageoldest_d = NULL) => -0.0677762054, -0.0677762054),
(eda_num_ph_owners_hist = NULL) => -0.0083602885, -0.0083602885);

// Tree: 48 
final_score_48 := map(
(NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 0.5) => -0.0297683287,
(f_rel_homeover300_count_d > 0.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 195.5) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 7.5) => -0.0111548075,
      (f_corrssnnamecount_d > 7.5) => 0.1000896169,
      (f_corrssnnamecount_d = NULL) => 0.0245893026, 0.0245893026),
   (f_fp_prevaddrburglaryindex_i > 195.5) => 0.5257586065,
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.0313231027, 0.0313231027),
(f_rel_homeover300_count_d = NULL) => -0.0009439025, -0.0009439025);

// Tree: 49 
final_score_49 := map(
(NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 18.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -154.5) => 0.3473718529,
   (f_addrchangecrimediff_i > -154.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 31.5) => 0.0659899651,
      (r_pb_order_freq_d > 31.5) => 0.0054228750,
      (r_pb_order_freq_d = NULL) => -0.0354872296, 0.0103213527),
   (f_addrchangecrimediff_i = NULL) => 0.0148295477, 0.0139389974),
(mth_source_ppth_lseen > 18.5) => -0.2394688105,
(mth_source_ppth_lseen = NULL) => 0.0042073781, 0.0042073781);

// Tree: 50 
final_score_50 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 12440) => 
   map(
   (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 30.5) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 8.5) => 0.5190262961,
      (f_rel_under100miles_cnt_d > 8.5) => 0.0186724096,
      (f_rel_under100miles_cnt_d = NULL) => 0.3361383238, 0.3361383238),
   (mth_pp_eda_hist_did_dt > 30.5) => -0.1913675257,
   (mth_pp_eda_hist_did_dt = NULL) => 0.2008804137, 0.2008804137),
(f_curraddrmedianvalue_d > 12440) => -0.0018798165,
(f_curraddrmedianvalue_d = NULL) => 0.0027499546, 0.0027499546);

// Tree: 51 
final_score_51 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 12.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 24.5) => -0.1081348929,
   (f_mos_inq_banko_cm_lseen_d > 24.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Brother','Child','Granddaughter','Grandfather','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => 0.0220732297,
      (phone_subject_title in ['Associate','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Daughter','Father','Grandchild','Grandmother','Grandparent','Spouse']) => 0.2183602033,
      (phone_subject_title = '') => 0.0488028969, 0.0488028969),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0178897848, 0.0178897848),
(f_addrchangecrimediff_i > 12.5) => -0.0748898916,
(f_addrchangecrimediff_i = NULL) => -0.0141830020, -0.0140627720);

// Tree: 52 
final_score_52 := map(
(NULL < _internal_ver_match_hhid and _internal_ver_match_hhid <= 0.5) => -0.0054977645,
(_internal_ver_match_hhid > 0.5) => 
   map(
   (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 150.5) => -0.0556789689,
   (mth_pp_app_npa_effective_dt > 150.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 152) => 0.2905663043,
      (f_curraddrmurderindex_i > 152) => -0.1690945898,
      (f_curraddrmurderindex_i = NULL) => 0.1990698230, 0.1990698230),
   (mth_pp_app_npa_effective_dt = NULL) => 0.1089519502, 0.1089519502),
(_internal_ver_match_hhid = NULL) => 0.0032524595, 0.0032524595);

// Tree: 53 
final_score_53 := map(
(NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0200429409,
(_pp_rule_high_vend_conf > 0.5) => 
   map(
   (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 1.5) => -0.0461079979,
   (pp_app_ind_ph_cnt > 1.5) => 
      map(
      (NULL < pp_app_best_addr_match_fl and pp_app_best_addr_match_fl <= 0.5) => 0.4147177917,
      (pp_app_best_addr_match_fl > 0.5) => 0.0697396302,
      (pp_app_best_addr_match_fl = NULL) => 0.1333526245, 0.1333526245),
   (pp_app_ind_ph_cnt = NULL) => 0.0603602255, 0.0603602255),
(_pp_rule_high_vend_conf = NULL) => -0.0066188787, -0.0066188787);

// Tree: 54 
final_score_54 := map(
(NULL < pp_did_score and pp_did_score <= 79.5) => 0.0232121255,
(pp_did_score > 79.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 74.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 168) => -0.2780759591,
      (f_curraddrburglaryindex_i > 168) => 0.1798087592,
      (f_curraddrburglaryindex_i = NULL) => -0.2034110640, -0.2034110640),
   (r_pb_order_freq_d > 74.5) => 0.0689936103,
   (r_pb_order_freq_d = NULL) => -0.0545693478, -0.0890067843),
(pp_did_score = NULL) => 0.0079316441, 0.0079316441);

// Tree: 55 
final_score_55 := map(
(NULL < f_college_income_d and f_college_income_d <= 10.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 20.5) => 
      map(
      (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 7.5) => 0.1251402079,
      (eda_avg_days_interrupt > 7.5) => -0.1239701263,
      (eda_avg_days_interrupt = NULL) => 0.0056689252, 0.0056689252),
   (mth_source_ppdid_fseen > 20.5) => -0.2405634603,
   (mth_source_ppdid_fseen = NULL) => -0.0346694861, -0.0346694861),
(f_college_income_d > 10.5) => -0.3461179785,
(f_college_income_d = NULL) => -0.0035969394, -0.0106278464);

// Tree: 56 
final_score_56 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 38.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -28146) => -0.2172445204,
   (f_addrchangeincomediff_d > -28146) => 0.0735399388,
   (f_addrchangeincomediff_d = NULL) => 0.0673003158, 0.0466284267),
(f_mos_inq_banko_om_fseen_d > 38.5) => 
   map(
   (NULL < mth_source_sp_fseen and mth_source_sp_fseen <= 2.5) => -0.0488180443,
   (mth_source_sp_fseen > 2.5) => 0.1913823521,
   (mth_source_sp_fseen = NULL) => -0.0408549435, -0.0408549435),
(f_mos_inq_banko_om_fseen_d = NULL) => -0.0154733967, -0.0154733967);

// Tree: 57 
final_score_57 := map(
(NULL < mth_source_exp_fseen and mth_source_exp_fseen <= 7.5) => 0.0026115331,
(mth_source_exp_fseen > 7.5) => 
   map(
   (NULL < _pp_glb_dppa_fl_glb and _pp_glb_dppa_fl_glb <= 0.5) => 
      map(
      (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 0.1119286926,
      (f_vardobcountnew_i > 0.5) => -0.3679056577,
      (f_vardobcountnew_i = NULL) => -0.0074870960, -0.0074870960),
   (_pp_glb_dppa_fl_glb > 0.5) => -0.2674615420,
   (_pp_glb_dppa_fl_glb = NULL) => -0.1146574128, -0.1146574128),
(mth_source_exp_fseen = NULL) => -0.0025509916, -0.0025509916);

// Tree: 58 
final_score_58 := map(
(pp_origphonetype in ['L','W']) => 
   map(
   (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 102.5) => -0.0697878613,
   (mth_pp_eda_hist_did_dt > 102.5) => 0.1605136817,
   (mth_pp_eda_hist_did_dt = NULL) => -0.0459797246, -0.0459797246),
(pp_origphonetype in ['O','V']) => 0.0810916280,
(pp_origphonetype = '') => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 533427) => 0.0395871667,
   (f_prevaddrmedianvalue_d > 533427) => -0.1834106369,
   (f_prevaddrmedianvalue_d = NULL) => 0.0304127382, 0.0304127382), 0.0087631723);

// Tree: 59 
final_score_59 := map(
(NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 65) => 
   map(
   (NULL < f_util_add_input_inf_n and f_util_add_input_inf_n <= 0.5) => 0.0111722244,
   (f_util_add_input_inf_n > 0.5) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 140.5) => 0.0733200089,
      (mth_pp_app_npa_effective_dt > 140.5) => 0.6953913404,
      (mth_pp_app_npa_effective_dt = NULL) => 0.2939126796, 0.2939126796),
   (f_util_add_input_inf_n = NULL) => 0.0267572143, 0.0267572143),
(f_curraddrmurderindex_i > 65) => -0.0333917951,
(f_curraddrmurderindex_i = NULL) => -0.0153752651, -0.0153752651);

// Tree: 60 
final_score_60 := map(
(NULL < _phone_timezone_match and _phone_timezone_match <= 0.5) => -0.1742845452,
(_phone_timezone_match > 0.5) => 
   map(
   (NULL < mth_source_paw_lseen and mth_source_paw_lseen <= 1.5) => 0.0152040914,
   (mth_source_paw_lseen > 1.5) => 
      map(
      (eda_pfrd_address_ind in ['1A','1C','1E','XX']) => -0.0184865359,
      (eda_pfrd_address_ind in ['1B','1D']) => 0.4558476319,
      (eda_pfrd_address_ind = '') => 0.2369241699, 0.2369241699),
   (mth_source_paw_lseen = NULL) => 0.0185091302, 0.0185091302),
(_phone_timezone_match = NULL) => 0.0028888020, 0.0028888020);

// Tree: 61 
final_score_61 := map(
(NULL < mth_source_exp_lseen and mth_source_exp_lseen <= 3.5) => 0.0129141527,
(mth_source_exp_lseen > 3.5) => 
   map(
   (NULL < f_college_income_d and f_college_income_d <= 5.5) => -0.0631274076,
   (f_college_income_d > 5.5) => 0.2140199083,
   (f_college_income_d = NULL) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 25.5) => -0.1618467677,
      (f_rel_under500miles_cnt_d > 25.5) => 0.1341262450,
      (f_rel_under500miles_cnt_d = NULL) => -0.1194639974, -0.1194639974), -0.0796514591),
(mth_source_exp_lseen = NULL) => 0.0070292297, 0.0070292297);

// Tree: 62 
final_score_62 := map(
(NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 1.5) => 0.0435755211,
   (f_idrisktype_i > 1.5) => -0.2439016586,
   (f_idrisktype_i = NULL) => 0.0340996038, 0.0340996038),
(f_sourcerisktype_i > 4.5) => 
   map(
   (NULL < mth_source_exp_lseen and mth_source_exp_lseen <= 10.5) => -0.0182189770,
   (mth_source_exp_lseen > 10.5) => -0.2290105069,
   (mth_source_exp_lseen = NULL) => -0.0243225580, -0.0243225580),
(f_sourcerisktype_i = NULL) => 0.0076386059, 0.0076386059);

// Tree: 63 
final_score_63 := map(
(NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0119585004,
(_pp_rule_high_vend_conf > 0.5) => 
   map(
   (NULL < _pp_did_flag and _pp_did_flag <= 0.5) => 0.4025992791,
   (_pp_did_flag > 0.5) => 
      map(
      (pp_source in ['CELL','IBEHAVIOR','OTHER','PCNSR','TARGUS','THRIVE']) => -0.1347054586,
      (pp_source in ['GONG','HEADER','INFUTOR','INQUIRY','INTRADO']) => 0.0904465533,
      (pp_source = '') => -0.1943793520, 0.0448476391),
   (_pp_did_flag = NULL) => 0.0621254171, 0.0621254171),
(_pp_rule_high_vend_conf = NULL) => 0.0002543735, 0.0002543735);

// Tree: 64 
final_score_64 := map(
(NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 1.5) => -0.0158362455,
(inq_adl_firstseen_n > 1.5) => 
   map(
   (NULL < inq_firstseen_n and inq_firstseen_n <= 8.5) => 0.4372980597,
   (inq_firstseen_n > 8.5) => 
      map(
      (NULL < pk_phone_match_level and pk_phone_match_level <= 1.5) => 0.4681951496,
      (pk_phone_match_level > 1.5) => 0.0268004832,
      (pk_phone_match_level = NULL) => 0.0527931899, 0.0527931899),
   (inq_firstseen_n = NULL) => 0.0764065903, 0.0764065903),
(inq_adl_firstseen_n = NULL) => -0.0052846414, -0.0052846414);

// Tree: 65 
final_score_65 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 23.5) => -0.0207867585,
(f_rel_under100miles_cnt_d > 23.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 129.5) => -0.0506224663,
   (r_pb_order_freq_d > 129.5) => 0.3733199710,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 1.5) => -0.2542565195,
      (f_util_adl_count_n > 1.5) => 0.3055587069,
      (f_util_adl_count_n = NULL) => 0.1479408276, 0.1479408276), 0.0777650605),
(f_rel_under100miles_cnt_d = NULL) => -0.0133394886, -0.0133394886);

// Tree: 66 
final_score_66 := map(
(NULL < _pp_rule_f1_ver_above and _pp_rule_f1_ver_above <= 0.5) => 0.0128555110,
(_pp_rule_f1_ver_above > 0.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 1.5) => 0.2168872406,
   (f_rel_under25miles_cnt_d > 1.5) => 
      map(
      (NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 35.5) => -0.1193356025,
      (mth_pp_orig_lastseen > 35.5) => 0.1589119900,
      (mth_pp_orig_lastseen = NULL) => -0.0875530111, -0.0875530111),
   (f_rel_under25miles_cnt_d = NULL) => -0.0631133080, -0.0631133080),
(_pp_rule_f1_ver_above = NULL) => 0.0038719602, 0.0038719602);

// Tree: 67 
final_score_67 := map(
(pp_rp_source in ['GONG','HEADER','INFUTOR','INTRADO','TARGUS','THRIVE']) => -0.0406725599,
(pp_rp_source in ['CELL','IBEHAVIOR','INQUIRY','OTHER','PCNSR']) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 5.5) => -0.0854575090,
   (mth_exp_last_update > 5.5) => 0.3674375852,
   (mth_exp_last_update = NULL) => 0.1855663269, 0.1855663269),
(pp_rp_source = '') => 
   map(
   (NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0114711055,
   (_pp_rule_high_vend_conf > 0.5) => 0.0701649600,
   (_pp_rule_high_vend_conf = NULL) => 0.0012892210, 0.0012892210), 0.0027666844);

// Tree: 68 
final_score_68 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 40.5) => 0.0006923395,
(f_srchaddrsrchcount_i > 40.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By SSN','Brother','Father','Neighbor','Sister','Spouse','Subject','Wife']) => 
      map(
      (NULL < f_inq_lnames_per_addr_i and f_inq_lnames_per_addr_i <= 6.5) => 0.2062867685,
      (f_inq_lnames_per_addr_i > 6.5) => -0.2265753994,
      (f_inq_lnames_per_addr_i = NULL) => 0.0719502336, 0.0719502336),
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Parent','Relative','Sibling','Son','Subject at Household']) => 0.5875249920,
   (phone_subject_title = '') => 0.1905780541, 0.1905780541),
(f_srchaddrsrchcount_i = NULL) => 0.0057168298, 0.0057168298);

// Tree: 69 
final_score_69 := map(
(NULL < source_eda_any_clean and source_eda_any_clean <= 0.5) => 0.0062907798,
(source_eda_any_clean > 0.5) => 
   map(
   (NULL < eda_has_cur_discon_15_days and eda_has_cur_discon_15_days <= 0.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -31.5) => 0.4430862066,
      (f_addrchangecrimediff_i > -31.5) => 0.1359988003,
      (f_addrchangecrimediff_i = NULL) => 0.1058452678, 0.1979295499),
   (eda_has_cur_discon_15_days > 0.5) => -0.0240755373,
   (eda_has_cur_discon_15_days = NULL) => 0.1195748133, 0.1195748133),
(source_eda_any_clean = NULL) => 0.0132806740, 0.0132806740);

// Tree: 70 
final_score_70 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 18.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 0.5) => -0.0042522004,
   (mth_source_ppdid_lseen > 0.5) => 
      map(
      (NULL < f_estimated_income_d and f_estimated_income_d <= 95500) => 0.0850416143,
      (f_estimated_income_d > 95500) => 0.4584499086,
      (f_estimated_income_d = NULL) => 0.1187586502, 0.1187586502),
   (mth_source_ppdid_lseen = NULL) => 0.0151498837, 0.0151498837),
(mth_source_ppdid_lseen > 18.5) => -0.1193781988,
(mth_source_ppdid_lseen = NULL) => -0.0010419988, -0.0010419988);

// Tree: 71 
final_score_71 := map(
(NULL < eda_max_days_connected_ind and eda_max_days_connected_ind <= 1040) => 
   map(
   (NULL < eda_avg_days_connected_ind and eda_avg_days_connected_ind <= 33) => -0.0053681915,
   (eda_avg_days_connected_ind > 33) => 
      map(
      (NULL < mth_source_sx_fseen and mth_source_sx_fseen <= 3.5) => -0.3612181080,
      (mth_source_sx_fseen > 3.5) => 0.0694652637,
      (mth_source_sx_fseen = NULL) => -0.2452648925, -0.2452648925),
   (eda_avg_days_connected_ind = NULL) => -0.0127662631, -0.0127662631),
(eda_max_days_connected_ind > 1040) => 0.2494702909,
(eda_max_days_connected_ind = NULL) => -0.0093889044, -0.0093889044);

// Tree: 72 
final_score_72 := map(
(phone_subject_title in ['Associate By SSN','Associate By Vehicle','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Parent','Spouse','Wife']) => -0.1913797831,
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Brother','Child','Daughter','Father','Grandchild','Mother','Neighbor','Relative','Sibling','Sister','Son','Subject','Subject at Household']) => 
   map(
   (NULL < _pp_app_nonpub_targ_la and _pp_app_nonpub_targ_la <= 0.5) => 0.0082580509,
   (_pp_app_nonpub_targ_la > 0.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.23497969319438) => 0.3463819541,
      (f_add_curr_mobility_index_n > 0.23497969319438) => 0.0686145338,
      (f_add_curr_mobility_index_n = NULL) => 0.1335601537, 0.1335601537),
   (_pp_app_nonpub_targ_la = NULL) => 0.0124740768, 0.0124740768),
(phone_subject_title = '') => 0.0065310244, 0.0065310244);

// Tree: 73 
final_score_73 := map(
(NULL < mth_source_exp_lseen and mth_source_exp_lseen <= 11.5) => 0.0126281911,
(mth_source_exp_lseen > 11.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 128) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 34.5) => 0.1970215841,
      (r_pb_order_freq_d > 34.5) => -0.2229802694,
      (r_pb_order_freq_d = NULL) => 0.0011673199, 0.0009205041),
   (f_curraddrmurderindex_i > 128) => -0.2664024863,
   (f_curraddrmurderindex_i = NULL) => -0.0943436889, -0.0943436889),
(mth_source_exp_lseen = NULL) => 0.0091839496, 0.0091839496);

// Tree: 74 
final_score_74 := map(
(NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 37.5) => 0.0165989845,
(mth_source_inf_fseen > 37.5) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 130.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 37.5) => -0.3715229718,
      (f_mos_inq_banko_om_fseen_d > 37.5) => -0.0719920130,
      (f_mos_inq_banko_om_fseen_d = NULL) => -0.1308631086, -0.1308631086),
   (mth_pp_app_npa_last_change_dt > 130.5) => 0.2824229634,
   (mth_pp_app_npa_last_change_dt = NULL) => -0.0891332528, -0.0891332528),
(mth_source_inf_fseen = NULL) => 0.0102236067, 0.0102236067);

// Tree: 75 
final_score_75 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -21193.5) => 
   map(
   (NULL < _pp_rule_source_latest and _pp_rule_source_latest <= 0.5) => -0.1355383971,
   (_pp_rule_source_latest > 0.5) => 0.1257379088,
   (_pp_rule_source_latest = NULL) => -0.0931835755, -0.0931835755),
(f_addrchangeincomediff_d > -21193.5) => 0.0113431775,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (pp_src in ['E2','EM','FA','LP','NW','SL','VO']) => -0.2272162556,
   (pp_src in ['CY','E1','EB','EN','EQ','FF','KW','LA','MD','PL','TN','UT','UW','VW','ZK','ZT']) => 0.1283808698,
   (pp_src = '') => -0.0007619533, 0.0157249048), 0.0003521622);

// Tree: 76 
final_score_76 := map(
(NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 91.5) => 
   map(
   (NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 83.5) => 0.0080452256,
   (mth_source_ppfla_fseen > 83.5) => 0.3066258706,
   (mth_source_ppfla_fseen = NULL) => 0.0099784815, 0.0099784815),
(mth_source_ppdid_fseen > 91.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 53.5) => 0.0708793153,
   (f_prevaddrmurderindex_i > 53.5) => -0.2774354158,
   (f_prevaddrmurderindex_i = NULL) => -0.1890570512, -0.1890570512),
(mth_source_ppdid_fseen = NULL) => 0.0052944701, 0.0052944701);

// Tree: 77 
final_score_77 := map(
(NULL < mth_source_pf_fseen and mth_source_pf_fseen <= 6.5) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 47.5) => 0.0056179302,
   (inq_adl_firstseen_n > 47.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 36852.5) => 0.3739710255,
      (f_curraddrmedianincome_d > 36852.5) => 0.0705615306,
      (f_curraddrmedianincome_d = NULL) => 0.1378546870, 0.1378546870),
   (inq_adl_firstseen_n = NULL) => 0.0096322046, 0.0096322046),
(mth_source_pf_fseen > 6.5) => -0.2471468745,
(mth_source_pf_fseen = NULL) => 0.0073773830, 0.0073773830);

// Tree: 78 
final_score_78 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 298) => -0.0065870592,
(r_pb_order_freq_d > 298) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 28.5) => -0.4641633071,
   (f_curraddrburglaryindex_i > 28.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 0.5) => 0.2559464630,
      (f_corraddrnamecount_d > 0.5) => -0.1147857374,
      (f_corraddrnamecount_d = NULL) => -0.0525460249, -0.0525460249),
   (f_curraddrburglaryindex_i = NULL) => -0.1160672105, -0.1160672105),
(r_pb_order_freq_d = NULL) => 0.0141015757, -0.0047577963);

// Tree: 79 
final_score_79 := map(
(NULL < mth_source_ppfla_lseen and mth_source_ppfla_lseen <= 2.5) => 0.0118512209,
(mth_source_ppfla_lseen > 2.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 1.5) => 
      map(
      (pp_src in ['CY','EM','EQ','LP','TN','UW','VO','ZK']) => -0.2767799668,
      (pp_src in ['E1','E2','EB','EN','FA','FF','KW','LA','MD','NW','PL','SL','UT','VW','ZT']) => 0.0653731782,
      (pp_src = '') => -0.0456805773, -0.0463460316),
   (f_varrisktype_i > 1.5) => -0.3535987133,
   (f_varrisktype_i = NULL) => -0.0893404341, -0.0893404341),
(mth_source_ppfla_lseen = NULL) => 0.0049084379, 0.0049084379);

// Tree: 80 
final_score_80 := map(
(NULL < eda_address_match_best and eda_address_match_best <= 0.5) => -0.0032847081,
(eda_address_match_best > 0.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By SSN','Brother','Grandmother','Mother','Neighbor','Son']) => -0.0805099350,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Parent','Relative','Sibling','Sister','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < number_of_sources and number_of_sources <= 2.5) => 0.5102200064,
      (number_of_sources > 2.5) => 0.1420377145,
      (number_of_sources = NULL) => 0.2291078511, 0.2291078511),
   (phone_subject_title = '') => 0.1153166990, 0.1153166990),
(eda_address_match_best = NULL) => 0.0032139991, 0.0032139991);

// Tree: 81 
final_score_81 := map(
(NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 197.5) => 
   map(
   (NULL < f_estimated_income_d and f_estimated_income_d <= 25500) => 
      map(
      (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 2.5) => 0.0437122031,
      (pp_app_ind_ph_cnt > 2.5) => 0.3860998396,
      (pp_app_ind_ph_cnt = NULL) => 0.1409333838, 0.1409333838),
   (f_estimated_income_d > 25500) => 0.0011944906,
   (f_estimated_income_d = NULL) => 0.0052326106, 0.0052326106),
(f_prevaddrmurderindex_i > 197.5) => -0.2363725596,
(f_prevaddrmurderindex_i = NULL) => 0.0015264891, 0.0015264891);

// Tree: 82 
final_score_82 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 16742.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 4.5) => 0.1379959421,
   (f_rel_under500miles_cnt_d > 4.5) => -0.2276378559,
   (f_rel_under500miles_cnt_d = NULL) => -0.1550914674, -0.1550914674),
(f_curraddrmedianincome_d > 16742.5) => 
   map(
   (NULL < mth_pp_eda_hist_nm_addr_dt and mth_pp_eda_hist_nm_addr_dt <= 60.5) => 0.0101461094,
   (mth_pp_eda_hist_nm_addr_dt > 60.5) => 0.2949627891,
   (mth_pp_eda_hist_nm_addr_dt = NULL) => 0.0134799115, 0.0134799115),
(f_curraddrmedianincome_d = NULL) => 0.0085050916, 0.0085050916);

// Tree: 83 
final_score_83 := map(
(NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 182.5) => 
   map(
   (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 145) => 0.0003015883,
   (mth_source_inf_fseen > 145) => -0.2720324037,
   (mth_source_inf_fseen = NULL) => -0.0022802412, -0.0022802412),
(mth_source_inf_fseen > 182.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 554.5) => 0.2301640916,
   (f_addrchangeincomediff_d > 554.5) => -0.0470125912,
   (f_addrchangeincomediff_d = NULL) => 0.0898433960, 0.0898433960),
(mth_source_inf_fseen = NULL) => -0.0000367432, -0.0000367432);

// Tree: 84 
final_score_84 := map(
(pp_app_ph_use in ['B','P']) => -0.0277794034,
(pp_app_ph_use in ['O']) => 
   map(
   (pp_source in ['INFUTOR','INTRADO','OTHER','TARGUS']) => -0.1302263184,
   (pp_source in ['CELL','GONG','HEADER','IBEHAVIOR','INQUIRY','PCNSR','THRIVE']) => 
      map(
      (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 0.5) => 0.1093160413,
      (f_rel_ageover50_count_d > 0.5) => -0.0491851150,
      (f_rel_ageover50_count_d = NULL) => 0.0728259399, 0.0728259399),
   (pp_source = '') => 0.0682630239, 0.0495763692),
(pp_app_ph_use = '') => 0.0023717059, 0.0085866118);

// Tree: 85 
final_score_85 := map(
(NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 40.5) => -0.0149228478,
(mth_pp_orig_lastseen > 40.5) => 
   map(
   (pp_source in ['GONG','INFUTOR','INQUIRY','PCNSR','THRIVE']) => -0.0582348894,
   (pp_source in ['CELL','HEADER','IBEHAVIOR','INTRADO','OTHER','TARGUS']) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 141) => -0.1029055943,
      (mth_pp_app_npa_effective_dt > 141) => 0.3365695424,
      (mth_pp_app_npa_effective_dt = NULL) => 0.2037503900, 0.2037503900),
   (pp_source = '') => 0.1983168088, 0.0795202888),
(mth_pp_orig_lastseen = NULL) => -0.0087084651, -0.0087084651);

// Tree: 86 
final_score_86 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 0.5) => -0.0184115888,
(mth_source_ppdid_lseen > 0.5) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 2.5) => 
      map(
      (NULL < _phone_match_code_tcza and _phone_match_code_tcza <= 2.5) => -0.0482003313,
      (_phone_match_code_tcza > 2.5) => 0.0907604301,
      (_phone_match_code_tcza = NULL) => 0.0606857611, 0.0606857611),
   (f_srchfraudsrchcountyr_i > 2.5) => -0.1186510457,
   (f_srchfraudsrchcountyr_i = NULL) => 0.0403215084, 0.0403215084),
(mth_source_ppdid_lseen = NULL) => -0.0033930799, -0.0033930799);

// Tree: 87 
final_score_87 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.272922694285295) => 
   map(
   (NULL < mth_source_ppca_lseen and mth_source_ppca_lseen <= 3.5) => 
      map(
      (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 1.5) => 0.0487860973,
      (f_rel_ageover50_count_d > 1.5) => 0.2110407294,
      (f_rel_ageover50_count_d = NULL) => 0.0731364673, 0.0731364673),
   (mth_source_ppca_lseen > 3.5) => -0.2579416233,
   (mth_source_ppca_lseen = NULL) => 0.0509412881, 0.0509412881),
(f_add_input_mobility_index_n > 0.272922694285295) => -0.0120098607,
(f_add_input_mobility_index_n = NULL) => 0.0787504422, 0.0047570254);

// Tree: 88 
final_score_88 := map(
(NULL < _phone_fb_result and _phone_fb_result <= 0.5) => 0.2780964287,
(_phone_fb_result > 0.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 194.5) => -0.0027686951,
   (f_prevaddrmurderindex_i > 194.5) => 
      map(
      (NULL < _phone_match_code_z and _phone_match_code_z <= 0.5) => 0.4181841150,
      (_phone_match_code_z > 0.5) => 0.0311573938,
      (_phone_match_code_z = NULL) => 0.1601663008, 0.1601663008),
   (f_prevaddrmurderindex_i = NULL) => 0.0025863366, 0.0025863366),
(_phone_fb_result = NULL) => 0.0042314618, 0.0042314618);

// Tree: 89 
final_score_89 := map(
(NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 40.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 23.5) => 0.0187793856,
   (mth_source_ppdid_fseen > 23.5) => -0.0577292873,
   (mth_source_ppdid_fseen = NULL) => 0.0083413773, 0.0083413773),
(mth_source_ppla_fseen > 40.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 13752.5) => -0.3114025998,
   (f_addrchangevaluediff_d > 13752.5) => 0.1015930221,
   (f_addrchangevaluediff_d = NULL) => -0.1358794605, -0.1358794605),
(mth_source_ppla_fseen = NULL) => 0.0048460356, 0.0048460356);

// Tree: 90 
final_score_90 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 11.5) => -0.0014851983,
(f_util_adl_count_n > 11.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.32105991133037) => -0.3366263394,
   (f_add_curr_mobility_index_n > 0.32105991133037) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 82) => -0.3410641751,
      (f_curraddrcartheftindex_i > 82) => 0.0566782839,
      (f_curraddrcartheftindex_i = NULL) => -0.0361744852, -0.0361744852),
   (f_add_curr_mobility_index_n = NULL) => -0.1247597985, -0.1247597985),
(f_util_adl_count_n = NULL) => -0.0074901437, -0.0074901437);

// Tree: 91 
final_score_91 := map(
(NULL < f_wealth_index_d and f_wealth_index_d <= 4.5) => -0.0166695360,
(f_wealth_index_d > 4.5) => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 4882.5) => 0.1282664034,
   (eda_days_ph_first_seen > 4882.5) => 
      map(
      (phone_subject_title in ['Associate By Business','Brother','Daughter','Mother','Relative','Sibling','Son','Spouse','Subject','Wife']) => -0.4099828882,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Sister','Subject at Household']) => 0.1933177314,
      (phone_subject_title = '') => -0.1171185098, -0.1171185098),
   (eda_days_ph_first_seen = NULL) => 0.0956539569, 0.0956539569),
(f_wealth_index_d = NULL) => -0.0064762447, -0.0064762447);

// Tree: 92 
final_score_92 := map(
(pp_source in ['GONG','INTRADO','OTHER','THRIVE']) => -0.3750685585,
(pp_source in ['CELL','HEADER','IBEHAVIOR','INFUTOR','INQUIRY','PCNSR','TARGUS']) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 12.5) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 10.5) => 0.3819896573,
      (f_rel_homeover100_count_d > 10.5) => -0.1462092533,
      (f_rel_homeover100_count_d = NULL) => 0.2059233537, 0.2059233537),
   (mth_pp_app_npa_last_change_dt > 12.5) => -0.0007839382,
   (mth_pp_app_npa_last_change_dt = NULL) => 0.0080096221, 0.0080096221),
(pp_source = '') => 0.0091936781, 0.0051956175);

// Tree: 93 
final_score_93 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 11.5) => -0.0097024704,
(inq_adl_lastseen_n > 11.5) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 1.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -5695) => -0.0875676759,
      (f_addrchangeincomediff_d > -5695) => 0.3302816767,
      (f_addrchangeincomediff_d = NULL) => 0.1985682938, 0.1985682938),
   (f_inq_count24_i > 1.5) => -0.0003807344,
   (f_inq_count24_i = NULL) => 0.0593300487, 0.0593300487),
(inq_adl_lastseen_n = NULL) => -0.0035355331, -0.0035355331);

// Tree: 94 
final_score_94 := map(
(NULL < pp_app_ind_has_actv_eda_ph_fl and pp_app_ind_has_actv_eda_ph_fl <= 0.5) => 
   map(
   (pp_src in ['CY','E1','E2','FA','KW','VW','ZK','ZT']) => -0.3980124238,
   (pp_src in ['EB','EM','EN','EQ','FF','LA','LP','MD','NW','PL','SL','TN','UT','UW','VO']) => -0.0313195769,
   (pp_src = '') => -0.0105189866, -0.0166105851),
(pp_app_ind_has_actv_eda_ph_fl > 0.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -120772.5) => 0.3769400103,
   (f_addrchangevaluediff_d > -120772.5) => 0.0282889673,
   (f_addrchangevaluediff_d = NULL) => 0.0650972821, 0.0590725827),
(pp_app_ind_has_actv_eda_ph_fl = NULL) => -0.0079089260, -0.0079089260);

// Tree: 95 
final_score_95 := map(
(NULL < _pp_app_nonpub_targ_la and _pp_app_nonpub_targ_la <= 0.5) => -0.0054754769,
(_pp_app_nonpub_targ_la > 0.5) => 
   map(
   (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 20.5) => -0.0984419717,
   (mth_pp_eda_hist_did_dt > 20.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 167) => 0.1125535239,
      (f_prevaddrageoldest_d > 167) => 0.5969572517,
      (f_prevaddrageoldest_d = NULL) => 0.2629894642, 0.2629894642),
   (mth_pp_eda_hist_did_dt = NULL) => 0.1162829773, 0.1162829773),
(_pp_app_nonpub_targ_la = NULL) => -0.0016121657, -0.0016121657);

// Tree: 96 
final_score_96 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.525267440811755) => 0.0123434389,
   (f_add_curr_mobility_index_n > 0.525267440811755) => -0.0586245549,
   (f_add_curr_mobility_index_n = NULL) => -0.0566895112, 0.0005411450),
(f_assocsuspicousidcount_i > 16.5) => 
   map(
   (NULL < eda_has_cur_discon_90_days and eda_has_cur_discon_90_days <= 0.5) => -0.2235752707,
   (eda_has_cur_discon_90_days > 0.5) => 0.0725324002,
   (eda_has_cur_discon_90_days = NULL) => -0.1430339842, -0.1430339842),
(f_assocsuspicousidcount_i = NULL) => -0.0057641219, -0.0057641219);

// Tree: 97 
final_score_97 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -430642) => -0.2903846856,
(f_addrchangevaluediff_d > -430642) => 0.0140509394,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (pp_src in ['E1','E2','EM','EQ','FA','LP','PL','VO','ZT']) => -0.2330860188,
   (pp_src in ['CY','EB','EN','FF','KW','LA','MD','NW','SL','TN','UT','UW','VW','ZK']) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 15.5) => 0.0150145127,
      (f_rel_educationover12_count_d > 15.5) => 0.3289580667,
      (f_rel_educationover12_count_d = NULL) => 0.0829180342, 0.0829180342),
   (pp_src = '') => -0.0375167334, -0.0235992669), 0.0026327149);

// Tree: 98 
final_score_98 := map(
(NULL < subject_ssn_mismatch and subject_ssn_mismatch <= -0.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Brother','Child','Daughter','Grandfather','Grandson','Husband','Neighbor','Relative','Sibling','Sister','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 150.5) => -0.0130554017,
      (mth_pp_app_npa_effective_dt > 150.5) => 0.1038510439,
      (mth_pp_app_npa_effective_dt = NULL) => 0.0170596258, 0.0170596258),
   (phone_subject_title in ['Associate By Business','Associate By SSN','Associate By Vehicle','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Mother','Parent','Son']) => 0.4199931949,
   (phone_subject_title = '') => 0.0366311117, 0.0366311117),
(subject_ssn_mismatch > -0.5) => -0.0227236489,
(subject_ssn_mismatch = NULL) => -0.0039811376, -0.0039811376);

// Tree: 99 
final_score_99 := map(
(NULL < _pp_rule_low_vend_conf and _pp_rule_low_vend_conf <= 0.5) => -0.0040313046,
(_pp_rule_low_vend_conf > 0.5) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 14.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 142121) => 0.0330866084,
      (f_prevaddrmedianvalue_d > 142121) => 0.3756188985,
      (f_prevaddrmedianvalue_d = NULL) => 0.2043527535, 0.2043527535),
   (f_rel_under100miles_cnt_d > 14.5) => -0.1682411972,
   (f_rel_under100miles_cnt_d = NULL) => 0.1178577292, 0.1178577292),
(_pp_rule_low_vend_conf = NULL) => -0.0008203185, -0.0008203185);

// Tree: 100 
final_score_100 := map(
(NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => 0.0341719529,
(f_util_add_input_conv_n > 0.5) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 7.5) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 73.5) => -0.0447775564,
      (mth_pp_app_npa_last_change_dt > 73.5) => 0.0611217655,
      (mth_pp_app_npa_last_change_dt = NULL) => -0.0156627381, -0.0156627381),
   (f_rel_homeover100_count_d > 7.5) => -0.0670286301,
   (f_rel_homeover100_count_d = NULL) => -0.0327595492, -0.0327595492),
(f_util_add_input_conv_n = NULL) => -0.0033335112, -0.0033335112);

// Tree: 101 
final_score_101 := map(
(NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 19.5) => 0.0061042170,
(mth_source_ppla_fseen > 19.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -30940.5) => -0.3020859732,
   (f_addrchangevaluediff_d > -30940.5) => 
      map(
      (NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 7.5) => 0.0937948859,
      (mth_internal_ver_first_seen > 7.5) => -0.1846774296,
      (mth_internal_ver_first_seen = NULL) => -0.0122898057, -0.0122898057),
   (f_addrchangevaluediff_d = NULL) => -0.1240509014, -0.0933040436),
(mth_source_ppla_fseen = NULL) => 0.0019374734, 0.0019374734);

// Tree: 102 
final_score_102 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 13.5) => -0.3515021176,
(f_mos_inq_banko_cm_fseen_d > 13.5) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 8.5) => -0.0080268997,
   (f_rel_incomeover75_count_d > 8.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 153) => 0.1300834329,
      (f_fp_prevaddrburglaryindex_i > 153) => -0.3491870474,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0815385408, 0.0815385408),
   (f_rel_incomeover75_count_d = NULL) => -0.0022693486, -0.0022693486),
(f_mos_inq_banko_cm_fseen_d = NULL) => -0.0049274435, -0.0049274435);

// Tree: 103 
final_score_103 := map(
(NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 40.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 139.5) => 
      map(
      (NULL < mth_pp_date_nonglb_lastseen and mth_pp_date_nonglb_lastseen <= 99.5) => 0.0072714369,
      (mth_pp_date_nonglb_lastseen > 99.5) => 0.3027150444,
      (mth_pp_date_nonglb_lastseen = NULL) => 0.0097619297, 0.0097619297),
   (mth_source_ppdid_fseen > 139.5) => 0.2983704056,
   (mth_source_ppdid_fseen = NULL) => 0.0116265932, 0.0116265932),
(mth_source_ppth_lseen > 40.5) => -0.3321243472,
(mth_source_ppth_lseen = NULL) => 0.0042613641, 0.0042613641);

// Tree: 104 
final_score_104 := map(
(NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 11.5) => 
   map(
   (NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 5350) => 0.0081737414,
   (f_acc_damage_amt_total_i > 5350) => -0.2333141901,
   (f_acc_damage_amt_total_i = NULL) => 0.0059171153, 0.0059171153),
(pp_app_ind_ph_cnt > 11.5) => 
   map(
   (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 157.5) => -0.0353615757,
   (mth_pp_app_npa_effective_dt > 157.5) => -0.3986726790,
   (mth_pp_app_npa_effective_dt = NULL) => -0.1746622060, -0.1746622060),
(pp_app_ind_ph_cnt = NULL) => 0.0018365850, 0.0018365850);

// Tree: 105 
final_score_105 := map(
(pp_src in ['CY','E1','E2','EQ','LP','NW','SL','TN','UT','VW','ZK','ZT']) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 28.5) => -0.0691803749,
   (f_rel_incomeover25_count_d > 28.5) => 0.2842815255,
   (f_rel_incomeover25_count_d = NULL) => -0.0454359105, -0.0454359105),
(pp_src in ['EB','EM','EN','FA','FF','KW','LA','MD','PL','UW','VO']) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 275.5) => 0.1058189199,
   (f_prevaddrageoldest_d > 275.5) => -0.2284550366,
   (f_prevaddrageoldest_d = NULL) => 0.0767009794, 0.0767009794),
(pp_src = '') => 0.0035232779, 0.0016886071);

// Tree: 106 
final_score_106 := map(
(NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 90.5) => 
   map(
   (NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 37.5) => 0.0003814017,
   (mth_source_ppla_fseen > 37.5) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 161.5) => -0.0584394762,
      (mth_pp_app_npa_effective_dt > 161.5) => 0.3061374054,
      (mth_pp_app_npa_effective_dt = NULL) => 0.1420778087, 0.1420778087),
   (mth_source_ppla_fseen = NULL) => 0.0030546036, 0.0030546036),
(mth_source_ppla_fseen > 90.5) => -0.2804712998,
(mth_source_ppla_fseen = NULL) => 0.0010628515, 0.0010628515);

// Tree: 107 
final_score_107 := map(
(NULL < _pp_rule_30 and _pp_rule_30 <= 0.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 160.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 153.5) => 0.0082002446,
      (f_prevaddrmurderindex_i > 153.5) => 0.1570322880,
      (f_prevaddrmurderindex_i = NULL) => 0.0215245739, 0.0215245739),
   (f_prevaddrcartheftindex_i > 160.5) => -0.0469926268,
   (f_prevaddrcartheftindex_i = NULL) => 0.0037994189, 0.0037994189),
(_pp_rule_30 > 0.5) => -0.2219824964,
(_pp_rule_30 = NULL) => 0.0007329510, 0.0007329510);

// Tree: 108 
final_score_108 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => -0.2577494493,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 8.5) => 0.0166609536,
   (f_rel_incomeover50_count_d > 8.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 1.5) => -0.4774694524,
      (f_curraddrmurderindex_i > 1.5) => -0.0292458690,
      (f_curraddrmurderindex_i = NULL) => -0.0398379978, -0.0398379978),
   (f_rel_incomeover50_count_d = NULL) => -0.0005332017, -0.0005332017),
(f_attr_arrest_recency_d = NULL) => -0.0055630744, -0.0055630744);

// Tree: 109 
final_score_109 := map(
(NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => 
   map(
   (NULL < eda_min_days_connected_ind and eda_min_days_connected_ind <= 84) => 0.0037150312,
   (eda_min_days_connected_ind > 84) => -0.1595210034,
   (eda_min_days_connected_ind = NULL) => -0.0011243720, -0.0011243720),
(_inq_adl_ph_industry_flag > 0.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 27.5) => 0.2802648664,
   (r_pb_order_freq_d > 27.5) => 0.1570837244,
   (r_pb_order_freq_d = NULL) => -0.0612875546, 0.1297736547),
(_inq_adl_ph_industry_flag = NULL) => 0.0031208865, 0.0031208865);

// Tree: 110 
final_score_110 := map(
(NULL < _pp_rule_low_vend_conf and _pp_rule_low_vend_conf <= 0.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 45.5) => 0.0191312280,
   (mth_source_ppdid_lseen > 45.5) => -0.1223672746,
   (mth_source_ppdid_lseen = NULL) => 0.0128284372, 0.0128284372),
(_pp_rule_low_vend_conf > 0.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 46.5) => 0.5388690995,
   (f_prevaddrmurderindex_i > 46.5) => 0.0730707488,
   (f_prevaddrmurderindex_i = NULL) => 0.1895203365, 0.1895203365),
(_pp_rule_low_vend_conf = NULL) => 0.0172141862, 0.0172141862);

// Tree: 111 
final_score_111 := map(
(NULL < mth_source_ppfla_lseen and mth_source_ppfla_lseen <= 21.5) => -0.0050469916,
(mth_source_ppfla_lseen > 21.5) => 
   map(
   (pp_source in ['CELL','IBEHAVIOR','INFUTOR','INQUIRY']) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 165.5) => -0.1853746195,
      (mth_pp_app_npa_effective_dt > 165.5) => 0.1709800309,
      (mth_pp_app_npa_effective_dt = NULL) => 0.0268060121, 0.0268060121),
   (pp_source in ['GONG','HEADER','INTRADO','OTHER','PCNSR','TARGUS','THRIVE']) => 0.3628220223,
   (pp_source = '') => 0.1311478258, 0.1311478258),
(mth_source_ppfla_lseen = NULL) => -0.0020172509, -0.0020172509);

// Tree: 112 
final_score_112 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 10.5) => -0.0062112998,
(f_inq_count24_i > 10.5) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 22.5) => 
      map(
      (NULL < mth_source_exp_fseen and mth_source_exp_fseen <= 1.5) => 0.1188056850,
      (mth_source_exp_fseen > 1.5) => 0.4014432879,
      (mth_source_exp_fseen = NULL) => 0.1424360419, 0.1424360419),
   (inq_adl_firstseen_n > 22.5) => -0.1694905219,
   (inq_adl_firstseen_n = NULL) => 0.0985027231, 0.0985027231),
(f_inq_count24_i = NULL) => 0.0024934135, 0.0024934135);

// Tree: 113 
final_score_113 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 14.5) => 
   map(
   (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 1.5) => 0.0678986111,
   (f_addrchangeecontrajindex_d > 1.5) => 
      map(
      (NULL < exp_verified and exp_verified <= 0.5) => -0.1815890717,
      (exp_verified > 0.5) => -0.3834819162,
      (exp_verified = NULL) => -0.2353116311, -0.2353116311),
   (f_addrchangeecontrajindex_d = NULL) => -0.1100560147, -0.1100560147),
(f_mos_inq_banko_cm_lseen_d > 14.5) => 0.0086167507,
(f_mos_inq_banko_cm_lseen_d = NULL) => 0.0030999957, 0.0030999957);

// Tree: 114 
final_score_114 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 90.5) => -0.0260312260,
(f_prevaddrlenofres_d > 90.5) => 
   map(
   (NULL < f_divrisktype_i and f_divrisktype_i <= 2.5) => 
      map(
      (NULL < _pp_rule_f1_ver_above and _pp_rule_f1_ver_above <= 0.5) => 0.0319871118,
      (_pp_rule_f1_ver_above > 0.5) => -0.0827012526,
      (_pp_rule_f1_ver_above = NULL) => 0.0196797519, 0.0196797519),
   (f_divrisktype_i > 2.5) => 0.2684737836,
   (f_divrisktype_i = NULL) => 0.0291619201, 0.0291619201),
(f_prevaddrlenofres_d = NULL) => 0.0024572269, 0.0024572269);

// Tree: 115 
final_score_115 := map(
(NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 6.5) => 
   map(
   (NULL < _pp_app_nonpub_targ_lap and _pp_app_nonpub_targ_lap <= 0.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By SSN','Brother','Child','Father','Grandmother','Husband','Mother','Neighbor','Relative','Spouse','Subject','Subject at Household','Wife']) => -0.0005066592,
      (phone_subject_title in ['Associate By Shared Associates','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Parent','Sibling','Sister','Son']) => 0.4017348931,
      (phone_subject_title = '') => 0.0203643648, 0.0203643648),
   (_pp_app_nonpub_targ_lap > 0.5) => 0.2357903599,
   (_pp_app_nonpub_targ_lap = NULL) => 0.0304792716, 0.0304792716),
(f_rel_educationover8_count_d > 6.5) => -0.0169358251,
(f_rel_educationover8_count_d = NULL) => -0.0057786761, -0.0057786761);

// Tree: 116 
final_score_116 := map(
(NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 2027) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -21211.5) => -0.0786081538,
   (f_addrchangeincomediff_d > -21211.5) => 0.0011423023,
   (f_addrchangeincomediff_d = NULL) => 0.0081599961, -0.0064762107),
(eda_max_days_interrupt > 2027) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.38578645262187) => 0.4289286279,
   (f_add_input_mobility_index_n > 0.38578645262187) => -0.0727050381,
   (f_add_input_mobility_index_n = NULL) => 0.1716805941, 0.1716805941),
(eda_max_days_interrupt = NULL) => -0.0023878448, -0.0023878448);

// Tree: 117 
final_score_117 := map(
(NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 82.5) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 19.5) => -0.0178812244,
   (f_rel_under100miles_cnt_d > 19.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Grandfather','Grandmother','Grandson','Neighbor','Parent','Relative','Sibling','Sister','Subject at Household','Wife']) => -0.0490494384,
      (phone_subject_title in ['Associate By Property','Brother','Father','Grandchild','Granddaughter','Grandparent','Husband','Mother','Son','Spouse','Subject']) => 0.1263368914,
      (phone_subject_title = '') => 0.0370330357, 0.0370330357),
   (f_rel_under100miles_cnt_d = NULL) => -0.0115162362, -0.0115162362),
(mth_source_utildid_fseen > 82.5) => 0.3142716844,
(mth_source_utildid_fseen = NULL) => -0.0093038841, -0.0093038841);

// Tree: 118 
final_score_118 := map(
(pp_src in ['CY','E1','EN','EQ','LP','NW','PL','SL','TN','UT','UW','VO','VW','ZK','ZT']) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 43.5) => 
      map(
      (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 2.5) => -0.0985883907,
      (pp_app_ind_ph_cnt > 2.5) => 0.1973198340,
      (pp_app_ind_ph_cnt = NULL) => 0.0901596538, 0.0901596538),
   (f_mos_inq_banko_cm_fseen_d > 43.5) => -0.0611509635,
   (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0394842104, -0.0394842104),
(pp_src in ['E2','EB','EM','FA','FF','KW','LA','MD']) => 0.1848274822,
(pp_src = '') => 0.0036719934, -0.0036088394);

// Tree: 119 
final_score_119 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 1.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 5.5) => -0.2147430257,
   (f_mos_inq_banko_om_fseen_d > 5.5) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 10.5) => -0.0056532508,
      (f_rel_count_i > 10.5) => 0.0767109060,
      (f_rel_count_i = NULL) => 0.0398209202, 0.0398209202),
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0321668462, 0.0321668462),
(f_rel_homeover200_count_d > 1.5) => -0.0174119576,
(f_rel_homeover200_count_d = NULL) => 0.0050592624, 0.0050592624);

// Tree: 120 
final_score_120 := map(
(NULL < r_has_paw_source_d and r_has_paw_source_d <= 0.5) => -0.0269159231,
(r_has_paw_source_d > 0.5) => 
   map(
   (pp_did_type in ['AMBIG','CORE','NO_SSN']) => 
      map(
      (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 2.5) => 0.3555310482,
      (mth_pp_datevendorfirstseen > 2.5) => 0.0157624490,
      (mth_pp_datevendorfirstseen = NULL) => 0.0254701233, 0.0254701233),
   (pp_did_type in ['C_MERGE','INACTIVE']) => 0.4193544350,
   (pp_did_type = '') => 0.0208265164, 0.0273188060),
(r_has_paw_source_d = NULL) => 0.0027318875, 0.0027318875);

// Tree: 121 
final_score_121 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.38055843275318) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Brother','Child','Daughter','Father','Granddaughter','Grandfather','Grandson','Husband','Neighbor','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => -0.0308028292,
   (phone_subject_title in ['Associate','Associate By Property','Associate By SSN','Associate By Vehicle','Grandchild','Grandmother','Grandparent','Mother','Parent','Relative','Spouse']) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 27303) => 0.4096969775,
      (f_prevaddrmedianincome_d > 27303) => 0.0445677501,
      (f_prevaddrmedianincome_d = NULL) => 0.0878755113, 0.0878755113),
   (phone_subject_title = '') => -0.0182087085, -0.0182087085),
(f_add_input_mobility_index_n > 0.38055843275318) => 0.0305248643,
(f_add_input_mobility_index_n = NULL) => -0.1284675961, 0.0027989864);

// Tree: 122 
final_score_122 := map(
(NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0180690721,
(_pp_rule_high_vend_conf > 0.5) => 
   map(
   (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 2.5) => -0.0321066707,
   (pp_app_ind_ph_cnt > 2.5) => 
      map(
      (NULL < source_ppdid and source_ppdid <= 0.5) => 0.0562144524,
      (source_ppdid > 0.5) => 0.2264196008,
      (source_ppdid = NULL) => 0.1473957819, 0.1473957819),
   (pp_app_ind_ph_cnt = NULL) => 0.0618385381, 0.0618385381),
(_pp_rule_high_vend_conf = NULL) => -0.0050551995, -0.0050551995);

// Tree: 123 
final_score_123 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 45.5) => 0.2814248812,
(f_mos_inq_banko_am_lseen_d > 45.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.180174123703535) => 
      map(
      (NULL < mth_exp_last_update and mth_exp_last_update <= 8.5) => -0.0829694573,
      (mth_exp_last_update > 8.5) => -0.3095180511,
      (mth_exp_last_update = NULL) => -0.1152636413, -0.1152636413),
   (f_add_input_mobility_index_n > 0.180174123703535) => -0.0031308296,
   (f_add_input_mobility_index_n = NULL) => 0.0254236929, -0.0090384822),
(f_mos_inq_banko_am_lseen_d = NULL) => -0.0067936833, -0.0067936833);

// Tree: 124 
final_score_124 := map(
(NULL < eda_num_phs_connected_addr and eda_num_phs_connected_addr <= 1.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0091512849,
   (f_varrisktype_i > 2.5) => -0.0726781001,
   (f_varrisktype_i = NULL) => -0.0001953759, -0.0001953759),
(eda_num_phs_connected_addr > 1.5) => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 2419) => -0.4441626030,
   (eda_days_ph_first_seen > 2419) => 0.0156616721,
   (eda_days_ph_first_seen = NULL) => -0.2017098034, -0.2017098034),
(eda_num_phs_connected_addr = NULL) => -0.0027906911, -0.0027906911);

// Tree: 125 
final_score_125 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 195.5) => 0.0017990856,
(f_curraddrcrimeindex_i > 195.5) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 184.5) => 
      map(
      (NULL < _phone_zip_match and _phone_zip_match <= 0.5) => 0.1213331990,
      (_phone_zip_match > 0.5) => 0.5978646021,
      (_phone_zip_match = NULL) => 0.3398927147, 0.3398927147),
   (f_curraddrburglaryindex_i > 184.5) => -0.0279189323,
   (f_curraddrburglaryindex_i = NULL) => 0.1750642588, 0.1750642588),
(f_curraddrcrimeindex_i = NULL) => 0.0066886531, 0.0066886531);

// Tree: 126 
final_score_126 := map(
(NULL < _pp_app_nonpub_gong_la and _pp_app_nonpub_gong_la <= 0.5) => 
   map(
   (NULL < eda_max_days_connected_ind and eda_max_days_connected_ind <= 690) => -0.0115508011,
   (eda_max_days_connected_ind > 690) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 4.5) => 0.0066491516,
      (f_rel_homeover100_count_d > 4.5) => 0.3336299441,
      (f_rel_homeover100_count_d = NULL) => 0.1324109948, 0.1324109948),
   (eda_max_days_connected_ind = NULL) => -0.0088927303, -0.0088927303),
(_pp_app_nonpub_gong_la > 0.5) => 0.1790358406,
(_pp_app_nonpub_gong_la = NULL) => -0.0068684441, -0.0068684441);

// Tree: 127 
final_score_127 := map(
(NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 1.5) => 0.0233708164,
(f_crim_rel_under500miles_cnt_i > 1.5) => 
   map(
   (NULL < _pp_app_fb_ph and _pp_app_fb_ph <= 0.5) => 0.3255182414,
   (_pp_app_fb_ph > 0.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.47895967084479) => -0.0497179803,
      (f_add_curr_mobility_index_n > 0.47895967084479) => 0.0368237774,
      (f_add_curr_mobility_index_n = NULL) => 0.0777344899, -0.0286922365),
   (_pp_app_fb_ph = NULL) => -0.0243910015, -0.0243910015),
(f_crim_rel_under500miles_cnt_i = NULL) => -0.0029522989, -0.0029522989);

// Tree: 128 
final_score_128 := map(
(pp_origphonetype in ['L']) => -0.0991901296,
(pp_origphonetype in ['O','V','W']) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 14.5) => -0.1306635552,
   (f_prevaddrlenofres_d > 14.5) => 
      map(
      (NULL < _pp_glb_dppa_fl_glb and _pp_glb_dppa_fl_glb <= 0.5) => 0.0872506427,
      (_pp_glb_dppa_fl_glb > 0.5) => -0.0243604312,
      (_pp_glb_dppa_fl_glb = NULL) => 0.0163017440, 0.0163017440),
   (f_prevaddrlenofres_d = NULL) => -0.0099119340, -0.0099119340),
(pp_origphonetype = '') => 0.0232111351, 0.0106867841);

// Tree: 129 
final_score_129 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 1.18567431277289) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 1.11439598920819) => -0.0012066314,
   (f_add_input_mobility_index_n > 1.11439598920819) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 7.5) => -0.0898152443,
      (f_inq_count_i > 7.5) => 0.4211812730,
      (f_inq_count_i = NULL) => 0.1950024866, 0.1950024866),
   (f_add_input_mobility_index_n = NULL) => 0.0016632299, 0.0016632299),
(f_add_curr_mobility_index_n > 1.18567431277289) => -0.2953153466,
(f_add_curr_mobility_index_n = NULL) => 0.1074255893, -0.0000134951);

// Tree: 130 
final_score_130 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 8.5) => -0.0110527252,
(f_srchssnsrchcount_i > 8.5) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 37314) => 0.1988381954,
   (f_prevaddrmedianincome_d > 37314) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 11.5) => 0.1397020878,
      (f_rel_under500miles_cnt_d > 11.5) => -0.0835058028,
      (f_rel_under500miles_cnt_d = NULL) => 0.0157670772, 0.0157670772),
   (f_prevaddrmedianincome_d = NULL) => 0.0744748931, 0.0744748931),
(f_srchssnsrchcount_i = NULL) => -0.0004957385, -0.0004957385);

// Tree: 131 
final_score_131 := map(
(NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 1.5) => 
   map(
   (NULL < pk_phone_match_level and pk_phone_match_level <= 0.5) => -0.0913733006,
   (pk_phone_match_level > 0.5) => 0.0073939898,
   (pk_phone_match_level = NULL) => -0.0010704307, -0.0010704307),
(f_srchunvrfdaddrcount_i > 1.5) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 6.5) => 0.4945554158,
   (f_inq_count24_i > 6.5) => -0.0230343285,
   (f_inq_count24_i = NULL) => 0.1923601614, 0.1923601614),
(f_srchunvrfdaddrcount_i = NULL) => 0.0025766387, 0.0025766387);

// Tree: 132 
final_score_132 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 107452.5) => -0.0420357710,
(f_prevaddrmedianvalue_d > 107452.5) => 
   map(
   (eda_pfrd_address_ind in ['1A','1B','1D','1E','XX']) => 0.0159809365,
   (eda_pfrd_address_ind in ['1C']) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandmother','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject at Household']) => -0.0380454620,
      (phone_subject_title in ['Associate','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Subject','Wife']) => 0.3293612559,
      (phone_subject_title = '') => 0.1365775028, 0.1365775028),
   (eda_pfrd_address_ind = '') => 0.0217930854, 0.0217930854),
(f_prevaddrmedianvalue_d = NULL) => -0.0012495802, -0.0012495802);

// Tree: 133 
final_score_133 := map(
(phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Granddaughter','Grandmother','Grandson','Mother','Neighbor','Relative','Sibling','Sister','Son','Subject','Subject at Household']) => -0.0012937719,
(phone_subject_title in ['Associate','Associate By Business','Grandchild','Grandfather','Grandparent','Husband','Parent','Spouse','Wife']) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.24294429107657) => -0.1464427666,
   (f_add_curr_mobility_index_n > 0.24294429107657) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 0.2276161865,
      (f_rel_criminal_count_i > 2.5) => 0.0177327039,
      (f_rel_criminal_count_i = NULL) => 0.1067951028, 0.1067951028),
   (f_add_curr_mobility_index_n = NULL) => 0.0674025454, 0.0674025454),
(phone_subject_title = '') => 0.0045535789, 0.0045535789);

// Tree: 134 
final_score_134 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.32893116167716) => -0.0278761630,
(f_add_curr_mobility_index_n > 0.32893116167716) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.356683258869035) => 
      map(
      (NULL < eda_days_in_service and eda_days_in_service <= 372) => 0.1927610862,
      (eda_days_in_service > 372) => -0.0305784286,
      (eda_days_in_service = NULL) => 0.1070016320, 0.1070016320),
   (f_add_curr_mobility_index_n > 0.356683258869035) => 0.0077582509,
   (f_add_curr_mobility_index_n = NULL) => 0.0211630069, 0.0211630069),
(f_add_curr_mobility_index_n = NULL) => -0.0784409855, -0.0023581869);

// Tree: 135 
final_score_135 := map(
(NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 14.5) => 
   map(
   (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 3.5) => -0.0069082172,
   (f_crim_rel_under100miles_cnt_i > 3.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By SSN','Associate By Vehicle','Child','Daughter','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Son','Spouse']) => -0.0336536736,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Brother','Father','Grandchild','Sibling','Sister','Subject','Subject at Household','Wife']) => 0.0835747433,
      (phone_subject_title = '') => 0.0416751216, 0.0416751216),
   (f_crim_rel_under100miles_cnt_i = NULL) => 0.0036721544, 0.0036721544),
(f_crim_rel_under500miles_cnt_i > 14.5) => -0.1746890725,
(f_crim_rel_under500miles_cnt_i = NULL) => -0.0003077203, -0.0003077203);

// Tree: 136 
final_score_136 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -18340.5) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 34.5) => -0.0910350597,
   (mth_exp_last_update > 34.5) => 0.2190597748,
   (mth_exp_last_update = NULL) => -0.0758156813, -0.0758156813),
(f_addrchangeincomediff_d > -18340.5) => 0.0029427556,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 544) => -0.0053555187,
   (eda_avg_days_interrupt > 544) => 0.2879891187,
   (eda_avg_days_interrupt = NULL) => 0.0129956398, 0.0129956398), -0.0050574901);

// Tree: 137 
final_score_137 := map(
(NULL < inq_num and inq_num <= 1.5) => -0.0057288287,
(inq_num > 1.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 47.5) => -0.0439017560,
   (f_prevaddrageoldest_d > 47.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.24852765338897) => -0.0702659763,
      (f_add_input_mobility_index_n > 0.24852765338897) => 0.2346198946,
      (f_add_input_mobility_index_n = NULL) => 0.1738419922, 0.1738419922),
   (f_prevaddrageoldest_d = NULL) => 0.0931961596, 0.0931961596),
(inq_num = NULL) => -0.0000997988, -0.0000997988);

// Tree: 138 
final_score_138 := map(
(NULL < eda_num_interrupts_cur and eda_num_interrupts_cur <= 6.5) => -0.0073843937,
(eda_num_interrupts_cur > 6.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Brother','Child','Daughter','Father','Grandfather','Husband','Neighbor','Relative','Sibling','Sister','Spouse','Subject']) => 0.0234239210,
   (phone_subject_title in ['Associate','Associate By Property','Associate By SSN','Associate By Vehicle','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Mother','Parent','Son','Subject at Household','Wife']) => 
      map(
      (NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 988.5) => 0.1189591668,
      (eda_max_days_interrupt > 988.5) => 0.3922333916,
      (eda_max_days_interrupt = NULL) => 0.2065277029, 0.2065277029),
   (phone_subject_title = '') => 0.0533893681, 0.0533893681),
(eda_num_interrupts_cur = NULL) => 0.0004853851, 0.0004853851);

// Tree: 139 
final_score_139 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 4.5) => -0.0049069358,
(f_rel_homeover500_count_d > 4.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 73.5) => 0.2605695485,
   (f_prevaddrageoldest_d > 73.5) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 68.5) => -0.1100670554,
      (mth_pp_app_npa_last_change_dt > 68.5) => 0.1619875032,
      (mth_pp_app_npa_last_change_dt = NULL) => -0.0096779194, -0.0096779194),
   (f_prevaddrageoldest_d = NULL) => 0.0801826919, 0.0801826919),
(f_rel_homeover500_count_d = NULL) => -0.0008483845, -0.0008483845);

// Tree: 140 
final_score_140 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 8.5) => -0.0106290005,
(f_rel_ageover40_count_d > 8.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 34233) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 10.5) => 0.5426767267,
      (f_rel_ageover40_count_d > 10.5) => 0.1375751166,
      (f_rel_ageover40_count_d = NULL) => 0.2678709561, 0.2678709561),
   (f_curraddrmedianincome_d > 34233) => 0.0284373533,
   (f_curraddrmedianincome_d = NULL) => 0.0680725383, 0.0680725383),
(f_rel_ageover40_count_d = NULL) => -0.0010790546, -0.0010790546);

// Tree: 141 
final_score_141 := map(
(NULL < _pp_rule_ins_ver_above and _pp_rule_ins_ver_above <= 0.5) => 0.0021584542,
(_pp_rule_ins_ver_above > 0.5) => 
   map(
   (NULL < inq_firstseen_n and inq_firstseen_n <= 34.5) => 
      map(
      (NULL < f_util_add_curr_misc_n and f_util_add_curr_misc_n <= 0.5) => 0.4206854196,
      (f_util_add_curr_misc_n > 0.5) => 0.1391586946,
      (f_util_add_curr_misc_n = NULL) => 0.2216261191, 0.2216261191),
   (inq_firstseen_n > 34.5) => -0.0819996596,
   (inq_firstseen_n = NULL) => 0.1183933543, 0.1183933543),
(_pp_rule_ins_ver_above = NULL) => 0.0062411693, 0.0062411693);

// Tree: 142 
final_score_142 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.414417359400035) => 
   map(
   (NULL < eda_has_cur_discon_30_days and eda_has_cur_discon_30_days <= 0.5) => 
      map(
      (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 29.5) => 0.0479249992,
      (f_rel_homeover50_count_d > 29.5) => -0.1431852166,
      (f_rel_homeover50_count_d = NULL) => 0.0384455032, 0.0384455032),
   (eda_has_cur_discon_30_days > 0.5) => -0.0434097660,
   (eda_has_cur_discon_30_days = NULL) => 0.0180247073, 0.0180247073),
(f_add_curr_mobility_index_n > 0.414417359400035) => -0.0323346061,
(f_add_curr_mobility_index_n = NULL) => 0.0066457009, 0.0016904923);

// Tree: 143 
final_score_143 := map(
(NULL < mth_source_edahistory_fseen and mth_source_edahistory_fseen <= 16.5) => 
   map(
   (NULL < f_util_add_curr_inf_n and f_util_add_curr_inf_n <= 0.5) => -0.0100373166,
   (f_util_add_curr_inf_n > 0.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 45.5) => 0.2966285062,
      (f_curraddrburglaryindex_i > 45.5) => 0.0374184853,
      (f_curraddrburglaryindex_i = NULL) => 0.0830824268, 0.0830824268),
   (f_util_add_curr_inf_n = NULL) => -0.0035802709, -0.0035802709),
(mth_source_edahistory_fseen > 16.5) => -0.1778092283,
(mth_source_edahistory_fseen = NULL) => -0.0074765045, -0.0074765045);

// Tree: 144 
final_score_144 := map(
(phone_subject_title in ['Associate By Address','Associate By Shared Associates','Brother','Child','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Relative','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => -0.0062984749,
(phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Daughter','Father','Grandchild','Mother','Parent','Sibling']) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 11.5) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 297956) => 0.0558541328,
      (f_curraddrmedianvalue_d > 297956) => 0.2250406397,
      (f_curraddrmedianvalue_d = NULL) => 0.0886191254, 0.0886191254),
   (f_corraddrnamecount_d > 11.5) => -0.1852448300,
   (f_corraddrnamecount_d = NULL) => 0.0656498904, 0.0656498904),
(phone_subject_title = '') => 0.0015357341, 0.0015357341);

// Tree: 145 
final_score_145 := map(
(NULL < pk_phone_match_level and pk_phone_match_level <= 0.5) => -0.1052814167,
(pk_phone_match_level > 0.5) => 
   map(
   (NULL < _phone_match_code_tcza and _phone_match_code_tcza <= 0.5) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 7.5) => 0.1446204022,
      (f_rel_ageover30_count_d > 7.5) => 0.0166955229,
      (f_rel_ageover30_count_d = NULL) => 0.0565604853, 0.0565604853),
   (_phone_match_code_tcza > 0.5) => -0.0080870460,
   (_phone_match_code_tcza = NULL) => -0.0027383901, -0.0027383901),
(pk_phone_match_level = NULL) => -0.0115387693, -0.0115387693);

// Tree: 146 
final_score_146 := map(
(pp_src in ['E1','EQ','LP','SL','TN','ZT']) => -0.1682552201,
(pp_src in ['CY','E2','EB','EM','EN','FA','FF','KW','LA','MD','NW','PL','UT','UW','VO','VW','ZK']) => 
   map(
   (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 1.5) => 
      map(
      (NULL < mth_exp_last_update and mth_exp_last_update <= 36.5) => -0.0118885814,
      (mth_exp_last_update > 36.5) => -0.2552984813,
      (mth_exp_last_update = NULL) => -0.0209850854, -0.0209850854),
   (f_divaddrsuspidcountnew_i > 1.5) => 0.2454463071,
   (f_divaddrsuspidcountnew_i = NULL) => -0.0080800701, -0.0080800701),
(pp_src = '') => -0.0004654432, -0.0050234857);

// Tree: 147 
final_score_147 := map(
(NULL < pp_src_cnt and pp_src_cnt <= 1.5) => -0.0102331127,
(pp_src_cnt > 1.5) => 
   map(
   (NULL < inq_lastseen_n and inq_lastseen_n <= 1.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 45) => 0.4077455138,
      (f_fp_prevaddrcrimeindex_i > 45) => 0.0834202239,
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.1404774508, 0.1404774508),
   (inq_lastseen_n > 1.5) => -0.0035499059,
   (inq_lastseen_n = NULL) => 0.0618987106, 0.0618987106),
(pp_src_cnt = NULL) => -0.0042115707, -0.0042115707);

// Tree: 148 
final_score_148 := map(
(NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 164.5) => 0.0073670292,
(f_fp_prevaddrburglaryindex_i > 164.5) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 19.5) => -0.0716997317,
   (f_rel_educationover12_count_d > 19.5) => 
      map(
      (NULL < pk_cell_indicator and pk_cell_indicator <= 0.5) => 0.0148504958,
      (pk_cell_indicator > 0.5) => 0.2949288683,
      (pk_cell_indicator = NULL) => 0.1043199759, 0.1043199759),
   (f_rel_educationover12_count_d = NULL) => -0.0491223820, -0.0491223820),
(f_fp_prevaddrburglaryindex_i = NULL) => -0.0038051740, -0.0038051740);

// Tree: 149 
final_score_149 := map(
(pp_app_ph_use in ['B','P']) => -0.0413623873,
(pp_app_ph_use in ['O']) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -33375) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 11.5) => 0.3414986235,
      (f_inq_count_i > 11.5) => -0.0471007760,
      (f_inq_count_i = NULL) => 0.1790513335, 0.1790513335),
   (f_addrchangeincomediff_d > -33375) => -0.0021769421,
   (f_addrchangeincomediff_d = NULL) => 0.0313332838, 0.0161965846),
(pp_app_ph_use = '') => 0.0148254836, 0.0040446087);

// Tree: 150 
final_score_150 := map(
(NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => -0.0172834927,
(_inq_adl_ph_industry_flag > 0.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 8.5) => 
      map(
      (NULL < f_estimated_income_d and f_estimated_income_d <= 39500) => 0.4147571671,
      (f_estimated_income_d > 39500) => 0.1126018135,
      (f_estimated_income_d = NULL) => 0.2195444386, 0.2195444386),
   (inq_adl_lastseen_n > 8.5) => -0.0982652517,
   (inq_adl_lastseen_n = NULL) => 0.1030519187, 0.1030519187),
(_inq_adl_ph_industry_flag = NULL) => -0.0133244421, -0.0133244421);

// Tree: 151 
final_score_151 := map(
(NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0175967340,
(_pp_rule_high_vend_conf > 0.5) => 
   map(
   (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 20.5) => 
      map(
      (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 5.5) => -0.1182834464,
      (pp_app_ind_ph_cnt > 5.5) => 0.1865222644,
      (pp_app_ind_ph_cnt = NULL) => -0.0462574394, -0.0462574394),
   (mth_pp_datefirstseen > 20.5) => 0.0926489773,
   (mth_pp_datefirstseen = NULL) => 0.0349524287, 0.0349524287),
(_pp_rule_high_vend_conf = NULL) => -0.0089462103, -0.0089462103);

// Tree: 152 
final_score_152 := map(
(NULL < mth_source_exp_lseen and mth_source_exp_lseen <= 4.5) => 0.0075357588,
(mth_source_exp_lseen > 4.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 9.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 77.5) => -0.2599489932,
      (f_curraddrcartheftindex_i > 77.5) => -0.0381343159,
      (f_curraddrcartheftindex_i = NULL) => -0.1146425869, -0.1146425869),
   (f_corraddrnamecount_d > 9.5) => 0.0966435416,
   (f_corraddrnamecount_d = NULL) => -0.0729294457, -0.0729294457),
(mth_source_exp_lseen = NULL) => 0.0031455486, 0.0031455486);

// Tree: 153 
final_score_153 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 73.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 16.5) => 
      map(
      (NULL < eda_min_days_interrupt and eda_min_days_interrupt <= 1.5) => 0.0192474125,
      (eda_min_days_interrupt > 1.5) => -0.1406390663,
      (eda_min_days_interrupt = NULL) => -0.0252222922, -0.0252222922),
   (mth_source_ppdid_lseen > 16.5) => -0.1306449137,
   (mth_source_ppdid_lseen = NULL) => -0.0413027409, -0.0413027409),
(f_prevaddrlenofres_d > 73.5) => 0.0207479897,
(f_prevaddrlenofres_d = NULL) => -0.0060672833, -0.0060672833);

// Tree: 154 
final_score_154 := map(
(NULL < mth_source_ppca_fseen and mth_source_ppca_fseen <= 22.5) => 
   map(
   (NULL < _pp_rule_seen_once and _pp_rule_seen_once <= 0.5) => 0.0179644944,
   (_pp_rule_seen_once > 0.5) => 0.2464992126,
   (_pp_rule_seen_once = NULL) => 0.0194194027, 0.0194194027),
(mth_source_ppca_fseen > 22.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 11.5) => -0.1386150079,
   (mth_source_utildid_fseen > 11.5) => 0.1651024286,
   (mth_source_utildid_fseen = NULL) => -0.1093893678, -0.1093893678),
(mth_source_ppca_fseen = NULL) => 0.0114263517, 0.0114263517);

// Tree: 155 
final_score_155 := map(
(NULL < eda_max_days_connected_ind and eda_max_days_connected_ind <= 743.5) => 
   map(
   (NULL < eda_days_ind_first_seen and eda_days_ind_first_seen <= 858.5) => 
      map(
      (NULL < mth_source_pf_fseen and mth_source_pf_fseen <= 7) => 0.0049579622,
      (mth_source_pf_fseen > 7) => -0.2079527068,
      (mth_source_pf_fseen = NULL) => 0.0031330881, 0.0031330881),
   (eda_days_ind_first_seen > 858.5) => -0.1974340722,
   (eda_days_ind_first_seen = NULL) => -0.0020814189, -0.0020814189),
(eda_max_days_connected_ind > 743.5) => 0.1378619244,
(eda_max_days_connected_ind = NULL) => 0.0004746239, 0.0004746239);

// Tree: 156 
final_score_156 := map(
(exp_source in ['S']) => 0.2027154856,
(exp_source in ['P']) => 0.2869986835,
(exp_source = '') => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => 
      map(
      (NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => -0.1310075724,
      (_inq_adl_ph_industry_flag > 0.5) => 0.5579466622,
      (_inq_adl_ph_industry_flag = NULL) => -0.1183558469, -0.1183558469),
   (source_rel > 0.5) => 0.3739271818,
   (source_rel = NULL) => -0.0937416954, -0.0937416954), -0.0157603286);

// Tree: 157 
final_score_157 := map(
(NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 6.5) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 24.5) => 
      map(
      (NULL < r_paw_active_phone_ct_d and r_paw_active_phone_ct_d <= 0.5) => 0.0410111932,
      (r_paw_active_phone_ct_d > 0.5) => -0.0970489007,
      (r_paw_active_phone_ct_d = NULL) => 0.0266645064, 0.0266645064),
   (inq_adl_firstseen_n > 24.5) => 0.1661476732,
   (inq_adl_firstseen_n = NULL) => 0.0362353991, 0.0362353991),
(f_rel_ageover30_count_d > 6.5) => -0.0131979408,
(f_rel_ageover30_count_d = NULL) => 0.0028773285, 0.0028773285);

// Tree: 158 
final_score_158 := map(
(exp_source in ['P']) => -0.0405409306,
(exp_source in ['S']) => 
   map(
   (NULL < f_inq_dobs_per_ssn_i and f_inq_dobs_per_ssn_i <= 0.5) => 
      map(
      (phone_subject_title in ['Grandfather','Grandmother','Grandparent','Neighbor','Parent','Subject at Household']) => -0.1456252769,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandson','Husband','Mother','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => 0.0691571595,
      (phone_subject_title = '') => 0.0538797477, 0.0538797477),
   (f_inq_dobs_per_ssn_i > 0.5) => -0.0522730514,
   (f_inq_dobs_per_ssn_i = NULL) => 0.0218663962, 0.0218663962),
(exp_source = '') => -0.0123514950, -0.0069885179);

// Tree: 159 
final_score_159 := map(
(NULL < f_college_income_d and f_college_income_d <= 8.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 182) => -0.0283820103,
   (f_curraddrmurderindex_i > 182) => -0.2275935987,
   (f_curraddrmurderindex_i = NULL) => -0.0532154840, -0.0532154840),
(f_college_income_d > 8.5) => 
   map(
   (NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 3.5) => 0.1503340149,
   (mth_pp_first_build_date > 3.5) => -0.1864935323,
   (mth_pp_first_build_date = NULL) => 0.0313350611, 0.0313350611),
(f_college_income_d = NULL) => 0.0162931687, 0.0076433603);

// Tree: 160 
final_score_160 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 24) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 213607.5) => 
      map(
      (NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 17.5) => -0.0395268046,
      (mth_pp_orig_lastseen > 17.5) => 0.2153229835,
      (mth_pp_orig_lastseen = NULL) => 0.0167124130, 0.0167124130),
   (f_curraddrmedianvalue_d > 213607.5) => -0.1487528756,
   (f_curraddrmedianvalue_d = NULL) => -0.0558633218, -0.0558633218),
(f_curraddrcrimeindex_i > 24) => 0.0101665866,
(f_curraddrcrimeindex_i = NULL) => 0.0032380472, 0.0032380472);

// Tree: 161 
final_score_161 := map(
(NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 18.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -64151) => -0.0673798150,
   (f_addrchangevaluediff_d > -64151) => 0.0063519757,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Associate By SSN','Child','Daughter','Grandfather','Grandmother','Husband','Neighbor','Relative','Spouse','Subject','Subject at Household','Wife']) => -0.0276750465,
      (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Vehicle','Brother','Father','Grandchild','Granddaughter','Grandparent','Grandson','Mother','Parent','Sibling','Sister','Son']) => 0.1326481571,
      (phone_subject_title = '') => 0.0053214394, 0.0053214394), -0.0041479867),
(mth_source_rel_fseen > 18.5) => -0.1573863932,
(mth_source_rel_fseen = NULL) => -0.0055294827, -0.0055294827);

// Tree: 162 
final_score_162 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 32748) => -0.0121132324,
(f_addrchangeincomediff_d > 32748) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 9.5) => 
      map(
      (phone_subject_title in ['Daughter','Husband','Mother','Neighbor','Parent','Sibling','Sister','Son','Wife']) => -0.2899962481,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Relative','Spouse','Subject','Subject at Household']) => 0.2374273819,
      (phone_subject_title = '') => 0.0957314813, 0.0957314813),
   (f_rel_count_i > 9.5) => -0.0030869019,
   (f_rel_count_i = NULL) => 0.0299759280, 0.0299759280),
(f_addrchangeincomediff_d = NULL) => -0.0208584475, -0.0103284856);

// Tree: 163 
final_score_163 := map(
(NULL < f_estimated_income_d and f_estimated_income_d <= 66500) => 
   map(
   (NULL < f_mos_foreclosure_lseen_d and f_mos_foreclosure_lseen_d <= 66) => -0.1561199790,
   (f_mos_foreclosure_lseen_d > 66) => 
      map(
      (pp_rp_source in ['GONG','HEADER','IBEHAVIOR','INQUIRY','OTHER','PCNSR','THRIVE']) => -0.0406935595,
      (pp_rp_source in ['CELL','INFUTOR','INTRADO','TARGUS']) => 0.1460937179,
      (pp_rp_source = '') => 0.0222346149, 0.0231970902),
   (f_mos_foreclosure_lseen_d = NULL) => 0.0176137202, 0.0176137202),
(f_estimated_income_d > 66500) => -0.0247788367,
(f_estimated_income_d = NULL) => 0.0026455085, 0.0026455085);

// Tree: 164 
final_score_164 := map(
(NULL < mth_source_pf_fseen and mth_source_pf_fseen <= 8.5) => 
   map(
   (NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 18.5) => 
      map(
      (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0320693796,
      (_phone_match_code_n > 0.5) => 0.0368753223,
      (_phone_match_code_n = NULL) => -0.0037558188, -0.0037558188),
   (mth_source_ppth_lseen > 18.5) => -0.1960123892,
   (mth_source_ppth_lseen = NULL) => -0.0104542584, -0.0104542584),
(mth_source_pf_fseen > 8.5) => -0.2531564639,
(mth_source_pf_fseen = NULL) => -0.0125570523, -0.0125570523);

// Tree: 165 
final_score_165 := map(
(NULL < mth_source_ppca_lseen and mth_source_ppca_lseen <= 7.5) => 0.0163699049,
(mth_source_ppca_lseen > 7.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 173.5) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 0.5) => 0.1950446351,
      (f_rel_homeover100_count_d > 0.5) => -0.0612192317,
      (f_rel_homeover100_count_d = NULL) => -0.0239595419, -0.0239595419),
   (f_curraddrcartheftindex_i > 173.5) => -0.3206462183,
   (f_curraddrcartheftindex_i = NULL) => -0.0696347386, -0.0696347386),
(mth_source_ppca_lseen = NULL) => 0.0089788022, 0.0089788022);

// Tree: 166 
final_score_166 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 148112.5) => 
   map(
   (NULL < f_divrisktype_i and f_divrisktype_i <= 3.5) => -0.0063986221,
   (f_divrisktype_i > 3.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 148.5) => -0.2362241331,
      (f_fp_prevaddrburglaryindex_i > 148.5) => 0.0678275959,
      (f_fp_prevaddrburglaryindex_i = NULL) => -0.1394116422, -0.1394116422),
   (f_divrisktype_i = NULL) => -0.0095551294, -0.0095551294),
(f_curraddrmedianincome_d > 148112.5) => 0.1945893888,
(f_curraddrmedianincome_d = NULL) => -0.0079055251, -0.0079055251);

// Tree: 167 
final_score_167 := map(
(NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 11.5) => 0.0061296387,
(mth_pp_first_build_date > 11.5) => 
   map(
   (NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.311715084344505) => 0.1478417201,
      (f_add_input_mobility_index_n > 0.311715084344505) => -0.0373540756,
      (f_add_input_mobility_index_n = NULL) => 0.0104851515, 0.0104851515),
   (f_util_add_input_conv_n > 0.5) => -0.1024490412,
   (f_util_add_input_conv_n = NULL) => -0.0545656859, -0.0545656859),
(mth_pp_first_build_date = NULL) => -0.0025187877, -0.0025187877);

// Tree: 168 
final_score_168 := map(
(NULL < f_college_income_d and f_college_income_d <= 3.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 43) => 0.3009011266,
   (f_prevaddrageoldest_d > 43) => 0.0088228643,
   (f_prevaddrageoldest_d = NULL) => 0.1069429056, 0.1069429056),
(f_college_income_d > 3.5) => 
   map(
   (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 0.5) => 0.0218159005,
   (f_divaddrsuspidcountnew_i > 0.5) => -0.1845226787,
   (f_divaddrsuspidcountnew_i = NULL) => -0.0032065018, -0.0032065018),
(f_college_income_d = NULL) => -0.0050856330, -0.0014919397);

// Tree: 169 
final_score_169 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 8.5) => 0.0154616106,
(f_rel_incomeover50_count_d > 8.5) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 123) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Brother','Father','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Parent','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => -0.0063532403,
      (phone_subject_title in ['Associate By Property','Associate By SSN','Child','Daughter','Grandchild','Granddaughter','Grandparent','Relative','Spouse']) => 0.2753233763,
      (phone_subject_title = '') => 0.0101063635, 0.0101063635),
   (f_fp_prevaddrcrimeindex_i > 123) => -0.1113383413,
   (f_fp_prevaddrcrimeindex_i = NULL) => -0.0255514665, -0.0255514665),
(f_rel_incomeover50_count_d = NULL) => 0.0030868506, 0.0030868506);

// Tree: 170 
final_score_170 := map(
(NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => -0.0136236387,
(_inq_adl_ph_industry_flag > 0.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.251481537732035) => -0.1455698428,
   (f_add_curr_mobility_index_n > 0.251481537732035) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.2245784227,
      (f_varrisktype_i > 2.5) => -0.0080552795,
      (f_varrisktype_i = NULL) => 0.1300709812, 0.1300709812),
   (f_add_curr_mobility_index_n = NULL) => 0.0733788968, 0.0733788968),
(_inq_adl_ph_industry_flag = NULL) => -0.0107408712, -0.0107408712);

// Tree: 171 
final_score_171 := map(
(pp_rp_source in ['GONG','HEADER','IBEHAVIOR','INFUTOR','INTRADO','OTHER','THRIVE']) => 
   map(
   (NULL < _pp_hhid_flag and _pp_hhid_flag <= 0.5) => 0.0895634988,
   (_pp_hhid_flag > 0.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 136.5) => -0.1948671924,
      (f_fp_prevaddrburglaryindex_i > 136.5) => 0.0391193059,
      (f_fp_prevaddrburglaryindex_i = NULL) => -0.1101661976, -0.1101661976),
   (_pp_hhid_flag = NULL) => -0.0556347344, -0.0556347344),
(pp_rp_source in ['CELL','INQUIRY','PCNSR','TARGUS']) => 0.1610284116,
(pp_rp_source = '') => -0.0017559013, -0.0021488788);

// Tree: 172 
final_score_172 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Property','Child','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Neighbor','Sister','Wife']) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.150446937747005) => 0.5506713944,
   (f_add_input_mobility_index_n > 0.150446937747005) => -0.0370512673,
   (f_add_input_mobility_index_n = NULL) => -0.0264672786, -0.0264672786),
(phone_subject_title in ['Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Daughter','Father','Grandchild','Grandmother','Mother','Parent','Relative','Sibling','Son','Spouse','Subject','Subject at Household']) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.131433711591095) => -0.2402109971,
   (f_add_input_mobility_index_n > 0.131433711591095) => 0.0279901896,
   (f_add_input_mobility_index_n = NULL) => -0.0423827507, 0.0249646957),
(phone_subject_title = '') => 0.0077604865, 0.0077604865);

// Tree: 173 
final_score_173 := map(
(NULL < mth_source_exp_lseen and mth_source_exp_lseen <= 2.5) => 0.0048176367,
(mth_source_exp_lseen > 2.5) => 
   map(
   (NULL < _pp_hhid_flag and _pp_hhid_flag <= 0.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 125.5) => 0.0794339225,
      (f_curraddrmurderindex_i > 125.5) => -0.1488143488,
      (f_curraddrmurderindex_i = NULL) => -0.0088339637, -0.0088339637),
   (_pp_hhid_flag > 0.5) => -0.1582577871,
   (_pp_hhid_flag = NULL) => -0.0889597820, -0.0889597820),
(mth_source_exp_lseen = NULL) => -0.0012431449, -0.0012431449);

// Tree: 174 
final_score_174 := map(
(NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 18.5) => -0.0089545180,
(mth_source_ppla_fseen > 18.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 239156) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 66.5) => -0.0282451842,
      (f_prevaddrcartheftindex_i > 66.5) => 0.2250392799,
      (f_prevaddrcartheftindex_i = NULL) => 0.1509301219, 0.1509301219),
   (f_prevaddrmedianvalue_d > 239156) => -0.0832811037,
   (f_prevaddrmedianvalue_d = NULL) => 0.0914068270, 0.0914068270),
(mth_source_ppla_fseen = NULL) => -0.0047008232, -0.0047008232);

// Tree: 175 
final_score_175 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -65715.5) => 0.2330769693,
(f_addrchangeincomediff_d > -65715.5) => -0.0010679039,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 156.5) => 0.0319166167,
   (mth_pp_app_npa_effective_dt > 156.5) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 37.5) => -0.1167814996,
      (inq_firstseen_n > 37.5) => 0.1215794812,
      (inq_firstseen_n = NULL) => -0.0687209352, -0.0687209352),
   (mth_pp_app_npa_effective_dt = NULL) => 0.0085975804, 0.0085975804), 0.0034958013);

// Tree: 176 
final_score_176 := map(
(NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 11.5) => 0.0186489675,
(f_rel_educationover12_count_d > 11.5) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 21777.5) => -0.2190147299,
   (f_prevaddrmedianincome_d > 21777.5) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 11.5) => -0.0358609082,
      (f_rel_homeover300_count_d > 11.5) => 0.0947064894,
      (f_rel_homeover300_count_d = NULL) => -0.0187093449, -0.0187093449),
   (f_prevaddrmedianincome_d = NULL) => -0.0296493009, -0.0296493009),
(f_rel_educationover12_count_d = NULL) => 0.0011912150, 0.0011912150);

// Tree: 177 
final_score_177 := map(
(NULL < inq_num and inq_num <= 0.5) => -0.0125764590,
(inq_num > 0.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 27.5) => 0.1355356069,
   (inq_adl_lastseen_n > 27.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 5.5) => 0.0697350087,
      (f_srchfraudsrchcount_i > 5.5) => -0.2140484861,
      (f_srchfraudsrchcount_i = NULL) => -0.0417752116, -0.0417752116),
   (inq_adl_lastseen_n = NULL) => 0.0616560992, 0.0616560992),
(inq_num = NULL) => -0.0037113133, -0.0037113133);

// Tree: 178 
final_score_178 := map(
(NULL < inq_lastseen_n and inq_lastseen_n <= 3.5) => 
   map(
   (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 3.5) => 
      map(
      (NULL < inq_num_addresses and inq_num_addresses <= 2.5) => 0.0344143106,
      (inq_num_addresses > 2.5) => 0.3150958036,
      (inq_num_addresses = NULL) => 0.0426729761, 0.0426729761),
   (eda_avg_days_interrupt > 3.5) => -0.0535808488,
   (eda_avg_days_interrupt = NULL) => 0.0015578581, 0.0015578581),
(inq_lastseen_n > 3.5) => -0.0340144706,
(inq_lastseen_n = NULL) => -0.0159763304, -0.0159763304);

// Tree: 179 
final_score_179 := map(
(NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 8.5) => -0.0029558137,
(f_rel_incomeover75_count_d > 8.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Father','Grandmother','Neighbor','Parent','Sibling','Sister','Son','Subject at Household']) => -0.0512693400,
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Mother','Relative','Spouse','Subject','Wife']) => 
      map(
      (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 6.5) => 0.1889438902,
      (f_rel_bankrupt_count_i > 6.5) => -0.1872616739,
      (f_rel_bankrupt_count_i = NULL) => 0.1269435319, 0.1269435319),
   (phone_subject_title = '') => 0.0641017416, 0.0641017416),
(f_rel_incomeover75_count_d = NULL) => 0.0014007216, 0.0014007216);

// Tree: 180 
final_score_180 := map(
(NULL < mth_source_ppth_fseen and mth_source_ppth_fseen <= 69.5) => 
   map(
   (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0256815599,
   (_phone_match_code_n > 0.5) => 
      map(
      (phone_subject_title in ['Associate','Daughter','Father','Mother','Parent','Sister','Subject','Subject at Household','Wife']) => 0.0298945678,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Relative','Sibling','Son','Spouse']) => 0.4668937750,
      (phone_subject_title = '') => 0.0392316326, 0.0392316326),
   (_phone_match_code_n = NULL) => 0.0018126323, 0.0018126323),
(mth_source_ppth_fseen > 69.5) => -0.2973700394,
(mth_source_ppth_fseen = NULL) => -0.0031965144, -0.0031965144);

// Tree: 181 
final_score_181 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0121586481,
(source_utildid > 0.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 12.5) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 3.5) => 0.5646663843,
      (inq_firstseen_n > 3.5) => 0.1208477445,
      (inq_firstseen_n = NULL) => 0.3513582008, 0.3513582008),
   (mth_source_utildid_fseen > 12.5) => 0.0332918279,
   (mth_source_utildid_fseen = NULL) => 0.0856267285, 0.0856267285),
(source_utildid = NULL) => -0.0031826810, -0.0031826810);

// Tree: 182 
final_score_182 := map(
(NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 1.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Grandmother','Husband','Mother','Neighbor','Parent','Sister','Spouse']) => -0.1033528681,
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Vehicle','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Relative','Sibling','Son','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 120) => 0.2435440890,
      (f_curraddrmurderindex_i > 120) => -0.0330565033,
      (f_curraddrmurderindex_i = NULL) => 0.1489175706, 0.1489175706),
   (phone_subject_title = '') => 0.0660159776, 0.0660159776),
(f_sourcerisktype_i > 1.5) => -0.0060353893,
(f_sourcerisktype_i = NULL) => -0.0036474590, -0.0036474590);

// Tree: 183 
final_score_183 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6141) => 0.0251222867,
(f_addrchangeincomediff_d > 6141) => 
   map(
   (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 1.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.206689247465265) => -0.1432676092,
      (f_add_curr_mobility_index_n > 0.206689247465265) => -0.0156630092,
      (f_add_curr_mobility_index_n = NULL) => -0.0322110081, -0.0322110081),
   (f_divaddrsuspidcountnew_i > 1.5) => 0.2230438753,
   (f_divaddrsuspidcountnew_i = NULL) => -0.0246449507, -0.0246449507),
(f_addrchangeincomediff_d = NULL) => 0.0085381544, 0.0060754964);

// Tree: 184 
final_score_184 := map(
(NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 38.5) => -0.0058988948,
(mth_source_ppla_fseen > 38.5) => 
   map(
   (NULL < f_inq_per_addr_i and f_inq_per_addr_i <= 2.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 82.5) => -0.0170074994,
      (f_prevaddrlenofres_d > 82.5) => 0.2800734847,
      (f_prevaddrlenofres_d = NULL) => 0.1760005285, 0.1760005285),
   (f_inq_per_addr_i > 2.5) => -0.0984944664,
   (f_inq_per_addr_i = NULL) => 0.0973951436, 0.0973951436),
(mth_source_ppla_fseen = NULL) => -0.0032382358, -0.0032382358);

// Tree: 185 
final_score_185 := map(
(NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 42.5) => 
   map(
   (pp_src in ['CY','E1','EQ','LP','NW','PL','VO','VW','ZK','ZT']) => -0.0983198809,
   (pp_src in ['E2','EB','EM','EN','FA','FF','KW','LA','MD','SL','TN','UT','UW']) => 
      map(
      (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 7.5) => -0.0439118551,
      (f_rel_homeover200_count_d > 7.5) => 0.0936667159,
      (f_rel_homeover200_count_d = NULL) => -0.0137602454, -0.0137602454),
   (pp_src = '') => 0.0119220473, 0.0038920997),
(f_rel_ageover20_count_d > 42.5) => -0.1387966638,
(f_rel_ageover20_count_d = NULL) => 0.0015790433, 0.0015790433);

// Tree: 186 
final_score_186 := map(
(pp_rp_source in ['CELL','GONG','INFUTOR','INQUIRY','OTHER','TARGUS','THRIVE']) => 
   map(
   (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 157.5) => 0.0885759653,
   (mth_pp_app_npa_effective_dt > 157.5) => -0.1119923770,
   (mth_pp_app_npa_effective_dt = NULL) => -0.0057654401, -0.0057654401),
(pp_rp_source in ['HEADER','IBEHAVIOR','INTRADO','PCNSR']) => 
   map(
   (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 9.5) => 0.3075898414,
   (mth_pp_datelastseen > 9.5) => -0.0258521579,
   (mth_pp_datelastseen = NULL) => 0.1440750149, 0.1440750149),
(pp_rp_source = '') => -0.0011830426, 0.0004408410);

// Tree: 187 
final_score_187 := map(
(NULL < inq_firstseen_n and inq_firstseen_n <= 85.5) => 
   map(
   (NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 10.5) => -0.0053705320,
   (mth_source_ppla_lseen > 10.5) => 
      map(
      (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 46.5) => -0.1666085839,
      (mth_pp_eda_hist_did_dt > 46.5) => 0.0404990349,
      (mth_pp_eda_hist_did_dt = NULL) => -0.0915320721, -0.0915320721),
   (mth_source_ppla_lseen = NULL) => -0.0086180812, -0.0086180812),
(inq_firstseen_n > 85.5) => 0.3506295876,
(inq_firstseen_n = NULL) => -0.0064729424, -0.0064729424);

// Tree: 188 
final_score_188 := map(
(NULL < eda_min_days_interrupt and eda_min_days_interrupt <= 147) => 0.0059187353,
(eda_min_days_interrupt > 147) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 72.5) => -0.3479409697,
   (f_curraddrburglaryindex_i > 72.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 48538) => -0.2563034799,
      (f_prevaddrmedianincome_d > 48538) => 0.2169445942,
      (f_prevaddrmedianincome_d = NULL) => -0.0574597513, -0.0574597513),
   (f_curraddrburglaryindex_i = NULL) => -0.1724726195, -0.1724726195),
(eda_min_days_interrupt = NULL) => 0.0018041004, 0.0018041004);

// Tree: 189 
final_score_189 := map(
(NULL < mth_source_exp_lseen and mth_source_exp_lseen <= 5.5) => -0.0052150712,
(mth_source_exp_lseen > 5.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 8.5) => -0.3233608991,
   (f_prevaddrlenofres_d > 8.5) => 
      map(
      (NULL < f_inq_adls_per_addr_i and f_inq_adls_per_addr_i <= 1.5) => -0.1059594719,
      (f_inq_adls_per_addr_i > 1.5) => 0.0947868450,
      (f_inq_adls_per_addr_i = NULL) => -0.0650950817, -0.0650950817),
   (f_prevaddrlenofres_d = NULL) => -0.0942447225, -0.0942447225),
(mth_source_exp_lseen = NULL) => -0.0098328133, -0.0098328133);

// Tree: 190 
final_score_190 := map(
(NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 19.5) => -0.0410153021,
(f_mos_inq_banko_om_lseen_d > 19.5) => 
   map(
   (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0198263109,
   (_phone_match_code_n > 0.5) => 
      map(
      (NULL < f_wealth_index_d and f_wealth_index_d <= 1.5) => -0.1013385067,
      (f_wealth_index_d > 1.5) => 0.0415609720,
      (f_wealth_index_d = NULL) => 0.0308678137, 0.0308678137),
   (_phone_match_code_n = NULL) => 0.0012591232, 0.0012591232),
(f_mos_inq_banko_om_lseen_d = NULL) => -0.0077788233, -0.0077788233);

// Tree: 191 
final_score_191 := map(
(NULL < _internal_ver_match_hhid and _internal_ver_match_hhid <= 0.5) => -0.0057751958,
(_internal_ver_match_hhid > 0.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.219503701120405) => -0.1241985195,
   (f_add_input_mobility_index_n > 0.219503701120405) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 153) => -0.0104796457,
      (mth_pp_app_npa_effective_dt > 153) => 0.1720896353,
      (mth_pp_app_npa_effective_dt = NULL) => 0.0958222462, 0.0958222462),
   (f_add_input_mobility_index_n = NULL) => 0.0606325896, 0.0606325896),
(_internal_ver_match_hhid = NULL) => -0.0007368812, -0.0007368812);

// Tree: 192 
final_score_192 := map(
(NULL < _internal_ver_match_hhid and _internal_ver_match_hhid <= 0.5) => -0.0164610067,
(_internal_ver_match_hhid > 0.5) => 
   map(
   (NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 37.5) => 
      map(
      (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 20.5) => 0.0841566054,
      (mth_source_ppdid_fseen > 20.5) => -0.0746855789,
      (mth_source_ppdid_fseen = NULL) => 0.0355897505, 0.0355897505),
   (mth_source_ppfla_fseen > 37.5) => 0.3116346955,
   (mth_source_ppfla_fseen = NULL) => 0.0600265161, 0.0600265161),
(_internal_ver_match_hhid = NULL) => -0.0109982518, -0.0109982518);

// Tree: 193 
final_score_193 := map(
(NULL < number_of_sources and number_of_sources <= 3.5) => -0.0044663135,
(number_of_sources > 3.5) => 
   map(
   (NULL < inq_num_addresses and inq_num_addresses <= 2.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 17.5) => 0.0841524484,
      (f_inq_count_i > 17.5) => -0.2139429742,
      (f_inq_count_i = NULL) => 0.0356252866, 0.0356252866),
   (inq_num_addresses > 2.5) => 0.2484262110,
   (inq_num_addresses = NULL) => 0.0732981775, 0.0732981775),
(number_of_sources = NULL) => -0.0006604878, -0.0006604878);

// Tree: 194 
final_score_194 := map(
(NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 69.5) => 
   map(
   (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 5.5) => 
      map(
      (NULL < f_inq_per_addr_i and f_inq_per_addr_i <= 21.5) => 0.0017493312,
      (f_inq_per_addr_i > 21.5) => -0.1778520439,
      (f_inq_per_addr_i = NULL) => -0.0002384027, -0.0002384027),
   (f_srchaddrsrchcountmo_i > 5.5) => 0.2098512152,
   (f_srchaddrsrchcountmo_i = NULL) => 0.0011277511, 0.0011277511),
(mth_source_utildid_fseen > 69.5) => -0.1651502357,
(mth_source_utildid_fseen = NULL) => -0.0004686422, -0.0004686422);

// Tree: 195 
final_score_195 := map(
(pp_origphoneusage in ['M','O']) => -0.1111442158,
(pp_origphoneusage in ['H','P','S']) => 
   map(
   (pp_src in ['CY','E2','EM','EQ','FA','LP','TN','UT','VW','ZK']) => -0.0260345963,
   (pp_src in ['E1','EB','EN','FF','KW','LA','MD','NW','PL','SL','UW','VO','ZT']) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 9.5) => -0.0300360651,
      (f_rel_under100miles_cnt_d > 9.5) => 0.3992147798,
      (f_rel_under100miles_cnt_d = NULL) => 0.1553222543, 0.1553222543),
   (pp_src = '') => 0.0191292318, 0.0257733613),
(pp_origphoneusage = '') => -0.0091252218, -0.0064298054);

// Tree: 196 
final_score_196 := map(
(NULL < pp_did_score and pp_did_score <= 37) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 198756.5) => 0.0015250505,
   (f_addrchangevaluediff_d > 198756.5) => 0.1452784732,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 5.5) => 0.0010536026,
      (f_assoccredbureaucount_i > 5.5) => 0.2148266273,
      (f_assoccredbureaucount_i = NULL) => 0.0126214070, 0.0126214070), 0.0096947945),
(pp_did_score > 37) => -0.0535418398,
(pp_did_score = NULL) => 0.0012691663, 0.0012691663);

// Tree: 197 
final_score_197 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 9.5) => -0.0000602152,
(f_addrchangecrimediff_i > 9.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Father','Granddaughter','Grandfather','Grandmother','Grandson','Husband','Parent','Son','Spouse','Subject']) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.553676326028855) => -0.0920246344,
      (f_add_curr_mobility_index_n > 0.553676326028855) => 0.0482847743,
      (f_add_curr_mobility_index_n = NULL) => -0.0692445148, -0.0692445148),
   (phone_subject_title in ['Associate By Address','Associate By Business','Brother','Grandchild','Grandparent','Mother','Neighbor','Relative','Sibling','Sister','Subject at Household','Wife']) => 0.0341984849,
   (phone_subject_title = '') => -0.0278317675, -0.0278317675),
(f_addrchangecrimediff_i = NULL) => 0.0093135877, -0.0052910546);

// Tree: 198 
final_score_198 := map(
(NULL < source_sx and source_sx <= 0.5) => -0.0070173891,
(source_sx > 0.5) => 
   map(
   (NULL < f_estimated_income_d and f_estimated_income_d <= 35500) => -0.0827530089,
   (f_estimated_income_d > 35500) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 153.5) => 0.1522623063,
      (f_curraddrcrimeindex_i > 153.5) => -0.1000423578,
      (f_curraddrcrimeindex_i = NULL) => 0.1123865692, 0.1123865692),
   (f_estimated_income_d = NULL) => 0.0671555412, 0.0671555412),
(source_sx = NULL) => -0.0030833840, -0.0030833840);

// Tree: 199 
final_score_199 := map(
(NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 450) => -0.0023221459,
(f_acc_damage_amt_total_i > 450) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Child','Daughter','Husband','Mother','Neighbor','Sister','Spouse','Wife']) => -0.2206994661,
   (phone_subject_title in ['Associate','Associate By Property','Associate By Vehicle','Brother','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Parent','Relative','Sibling','Son','Subject','Subject at Household']) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.314241977353835) => 0.3669208536,
      (f_add_input_mobility_index_n > 0.314241977353835) => 0.1179568541,
      (f_add_input_mobility_index_n = NULL) => 0.1861661690, 0.1861661690),
   (phone_subject_title = '') => 0.0693563576, 0.0693563576),
(f_acc_damage_amt_total_i = NULL) => 0.0002797670, 0.0002797670);

// Tree: 200 
final_score_200 := map(
(NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 10.5) => -0.0079788989,
(f_rel_homeover100_count_d > 10.5) => 
   map(
   (NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 11.5) => 
      map(
      (NULL < f_college_income_d and f_college_income_d <= 5.5) => -0.0107697073,
      (f_college_income_d > 5.5) => 0.2777658038,
      (f_college_income_d = NULL) => 0.0610115397, 0.0703017751),
   (mth_pp_first_build_date > 11.5) => -0.0780361295,
   (mth_pp_first_build_date = NULL) => 0.0491222384, 0.0491222384),
(f_rel_homeover100_count_d = NULL) => 0.0042896576, 0.0042896576);

// Tree: 201 
final_score_201 := map(
(pp_rp_source in ['GONG','HEADER','INFUTOR','INTRADO','OTHER']) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 14.5) => -0.1123698094,
   (f_inq_count_i > 14.5) => 0.1200028377,
   (f_inq_count_i = NULL) => -0.0399767924, -0.0399767924),
(pp_rp_source in ['CELL','IBEHAVIOR','INQUIRY','PCNSR','TARGUS','THRIVE']) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 95.5) => -0.0904302818,
   (f_prevaddrcartheftindex_i > 95.5) => 0.2522418727,
   (f_prevaddrcartheftindex_i = NULL) => 0.1124316337, 0.1124316337),
(pp_rp_source = '') => 0.0048015811, 0.0050136616);

// Tree: 202 
final_score_202 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 8.5) => 0.0134439044,
(f_inq_count_i > 8.5) => 
   map(
   (NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 5.5) => -0.0159806409,
   (mth_internal_ver_first_seen > 5.5) => 
      map(
      (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 1.5) => -0.0078821970,
      (f_crim_rel_under500miles_cnt_i > 1.5) => -0.1349693862,
      (f_crim_rel_under500miles_cnt_i = NULL) => -0.0854030333, -0.0854030333),
   (mth_internal_ver_first_seen = NULL) => -0.0347955686, -0.0347955686),
(f_inq_count_i = NULL) => -0.0091254591, -0.0091254591);

// Tree: 203 
final_score_203 := map(
(NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 35.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 535) => 0.0005196101,
   (r_pb_order_freq_d > 535) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 155.5) => 0.0193734497,
      (f_prevaddrageoldest_d > 155.5) => 0.3466337584,
      (f_prevaddrageoldest_d = NULL) => 0.1433356878, 0.1433356878),
   (r_pb_order_freq_d = NULL) => -0.0117232360, -0.0020299238),
(f_rel_homeover100_count_d > 35.5) => 0.2558569140,
(f_rel_homeover100_count_d = NULL) => -0.0003946620, -0.0003946620);

// Tree: 204 
final_score_204 := map(
(pp_source in ['CELL','HEADER','INFUTOR','INQUIRY','INTRADO','OTHER','PCNSR','THRIVE']) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 58960.5) => 0.0131755286,
   (f_addrchangeincomediff_d > 58960.5) => 0.1886918971,
   (f_addrchangeincomediff_d = NULL) => -0.0259792472, 0.0076942614),
(pp_source in ['GONG','IBEHAVIOR','TARGUS']) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 36112) => -0.0939470591,
   (f_prevaddrmedianincome_d > 36112) => 0.1487173333,
   (f_prevaddrmedianincome_d = NULL) => 0.0927716521, 0.0927716521),
(pp_source = '') => 0.0006064989, 0.0070238963);

// Tree: 205 
final_score_205 := map(
(NULL < source_rel and source_rel <= 0.5) => -0.0032328343,
(source_rel > 0.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 16.5) => 0.2643026203,
   (f_prevaddrlenofres_d > 16.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 117765.5) => -0.0897972216,
      (f_prevaddrmedianvalue_d > 117765.5) => 0.1159889015,
      (f_prevaddrmedianvalue_d = NULL) => 0.0427053541, 0.0427053541),
   (f_prevaddrlenofres_d = NULL) => 0.0820421469, 0.0820421469),
(source_rel = NULL) => 0.0001418225, 0.0001418225);

// Tree: 206 
final_score_206 := map(
(NULL < _internal_ver_match_level and _internal_ver_match_level <= 2.5) => 0.0002022815,
(_internal_ver_match_level > 2.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.421017257369385) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 135.5) => 0.3390176691,
      (f_prevaddrlenofres_d > 135.5) => 0.0833427448,
      (f_prevaddrlenofres_d = NULL) => 0.2193899522, 0.2193899522),
   (f_add_input_mobility_index_n > 0.421017257369385) => -0.0680132663,
   (f_add_input_mobility_index_n = NULL) => 0.1141201687, 0.1141201687),
(_internal_ver_match_level = NULL) => 0.0025097155, 0.0025097155);

// Tree: 207 
final_score_207 := map(
(exp_source in ['P']) => -0.0587078907,
(exp_source in ['S']) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.16593417255868) => -0.2360662850,
   (f_add_input_mobility_index_n > 0.16593417255868) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => 0.0691230349,
      (f_util_adl_count_n > 4.5) => -0.0401173663,
      (f_util_adl_count_n = NULL) => 0.0341136269, 0.0341136269),
   (f_add_input_mobility_index_n = NULL) => 0.0240826016, 0.0240826016),
(exp_source = '') => -0.0054403526, -0.0026738134);

// Tree: 208 
final_score_208 := map(
(pp_src in ['E1','E2','LP','NW','PL','VO','VW','ZT']) => -0.1344090836,
(pp_src in ['CY','EB','EM','EN','EQ','FA','FF','KW','LA','MD','SL','TN','UT','UW','ZK']) => 0.0200074337,
(pp_src = '') => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 132.5) => 0.0032571329,
   (mth_pp_app_npa_last_change_dt > 132.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.1406722325,
      (f_util_adl_count_n > 4.5) => 0.0547775033,
      (f_util_adl_count_n = NULL) => -0.0905696352, -0.0905696352),
   (mth_pp_app_npa_last_change_dt = NULL) => -0.0021729121, -0.0021729121), -0.0005470705);

// Tree: 209 
final_score_209 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 38.5) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 35.5) => 0.0061372142,
   (f_rel_homeover100_count_d > 35.5) => 0.1988035476,
   (f_rel_homeover100_count_d = NULL) => 0.0074410589, 0.0074410589),
(inq_adl_lastseen_n > 38.5) => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 3641) => -0.1441038064,
   (eda_days_ph_first_seen > 3641) => 0.1040278136,
   (eda_days_ph_first_seen = NULL) => -0.0866849191, -0.0866849191),
(inq_adl_lastseen_n = NULL) => 0.0047741011, 0.0047741011);

// Tree: 210 
final_score_210 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 24.5) => -0.0041451692,
(f_srchaddrsrchcount_i > 24.5) => 
   map(
   (NULL < inq_num_addresses and inq_num_addresses <= 3.5) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 160.5) => 0.0956963704,
      (f_prevaddrcartheftindex_i > 160.5) => -0.0903902022,
      (f_prevaddrcartheftindex_i = NULL) => 0.0348758672, 0.0348758672),
   (inq_num_addresses > 3.5) => 0.2507804985,
   (inq_num_addresses = NULL) => 0.0632843713, 0.0632843713),
(f_srchaddrsrchcount_i = NULL) => 0.0000558515, 0.0000558515);

// Tree: 211 
final_score_211 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Child','Daughter','Father','Granddaughter','Grandfather','Grandson','Neighbor','Parent','Relative','Sibling','Sister','Spouse','Subject','Subject at Household','Wife']) => -0.0043434736,
(phone_subject_title in ['Associate By Property','Associate By Vehicle','Brother','Grandchild','Grandmother','Grandparent','Husband','Mother','Son']) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 5.5) => 0.0353513842,
   (f_rel_homeover200_count_d > 5.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 52267) => 0.7092981260,
      (f_prevaddrmedianincome_d > 52267) => 0.0250686791,
      (f_prevaddrmedianincome_d = NULL) => 0.3123405843, 0.3123405843),
   (f_rel_homeover200_count_d = NULL) => 0.1158072273, 0.1158072273),
(phone_subject_title = '') => 0.0020009786, 0.0020009786);

// Tree: 212 
final_score_212 := map(
(NULL < mth_pp_date_nonglb_lastseen and mth_pp_date_nonglb_lastseen <= 105.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 148.5) => -0.0161938409,
   (f_prevaddrmurderindex_i > 148.5) => 
      map(
      (NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 8.5) => 0.0204655743,
      (f_inq_per_ssn_i > 8.5) => 0.4338243233,
      (f_inq_per_ssn_i = NULL) => 0.0288981577, 0.0288981577),
   (f_prevaddrmurderindex_i = NULL) => -0.0026027915, -0.0026027915),
(mth_pp_date_nonglb_lastseen > 105.5) => 0.2294689926,
(mth_pp_date_nonglb_lastseen = NULL) => -0.0003747285, -0.0003747285);

// Tree: 213 
final_score_213 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 34036.5) => 
   map(
   (NULL < inq_num and inq_num <= 1.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 33524) => 0.0189138489,
      (f_curraddrmedianincome_d > 33524) => 0.2912431190,
      (f_curraddrmedianincome_d = NULL) => 0.0306141725, 0.0306141725),
   (inq_num > 1.5) => 0.1660954343,
   (inq_num = NULL) => 0.0392988688, 0.0392988688),
(f_curraddrmedianincome_d > 34036.5) => -0.0189287040,
(f_curraddrmedianincome_d = NULL) => -0.0072286437, -0.0072286437);

// Tree: 214 
final_score_214 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 0.5) => 
   map(
   (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 3.5) => 0.0078661878,
   (f_rel_ageover40_count_d > 3.5) => 
      map(
      (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 15.5) => 0.2239275118,
      (mth_pp_datevendorfirstseen > 15.5) => -0.0361986894,
      (mth_pp_datevendorfirstseen = NULL) => 0.1560685028, 0.1560685028),
   (f_rel_ageover40_count_d = NULL) => 0.0493147797, 0.0493147797),
(f_rel_criminal_count_i > 0.5) => -0.0136555741,
(f_rel_criminal_count_i = NULL) => -0.0007444395, -0.0007444395);

// Tree: 215 
final_score_215 := map(
(NULL < f_srchssnsrchcountmo_i and f_srchssnsrchcountmo_i <= 0.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 2018.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 158) => 0.0235034813,
      (f_addrchangevaluediff_d > 158) => 0.3119123626,
      (f_addrchangevaluediff_d = NULL) => 0.0290183210, 0.0290183210),
   (f_addrchangevaluediff_d > 2018.5) => -0.0197632983,
   (f_addrchangevaluediff_d = NULL) => 0.0010355264, 0.0050923427),
(f_srchssnsrchcountmo_i > 0.5) => -0.1484007357,
(f_srchssnsrchcountmo_i = NULL) => 0.0009589382, 0.0009589382);

// Tree: 216 
final_score_216 := map(
(eda_pfrd_address_ind in ['1A','1B','1D','1E','XX']) => -0.0039348761,
(eda_pfrd_address_ind in ['1C']) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandmother','Grandparent','Mother','Neighbor','Relative','Sister','Son','Spouse']) => -0.0150930994,
   (phone_subject_title in ['Father','Grandchild','Granddaughter','Grandfather','Grandson','Husband','Parent','Sibling','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 95.5) => 0.1109704080,
      (f_prevaddrcartheftindex_i > 95.5) => 0.3734373494,
      (f_prevaddrcartheftindex_i = NULL) => 0.2630345883, 0.2630345883),
   (phone_subject_title = '') => 0.0776161298, 0.0776161298),
(eda_pfrd_address_ind = '') => -0.0003256641, -0.0003256641);

// Tree: 217 
final_score_217 := map(
(NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 4.5) => -0.0021452571,
(f_rel_ageover50_count_d > 4.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 107491.5) => -0.0612625665,
   (f_curraddrmedianvalue_d > 107491.5) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 12.5) => 0.3896806438,
      (f_rel_incomeover50_count_d > 12.5) => 0.0197937783,
      (f_rel_incomeover50_count_d = NULL) => 0.2342659944, 0.2342659944),
   (f_curraddrmedianvalue_d = NULL) => 0.1352061416, 0.1352061416),
(f_rel_ageover50_count_d = NULL) => 0.0007424455, 0.0007424455);

// Tree: 218 
final_score_218 := map(
(NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 7.5) => 0.0082569487,
(pp_app_ind_ph_cnt > 7.5) => 
   map(
   (pp_src in ['CY','E1','E2','LP','UT','UW','ZK','ZT']) => -0.1384171558,
   (pp_src in ['EB','EM','EN','EQ','FA','FF','KW','LA','MD','NW','PL','SL','TN','VO','VW']) => 0.0029654356,
   (pp_src = '') => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -4360) => 0.0867453056,
      (f_addrchangeincomediff_d > -4360) => -0.1160157045,
      (f_addrchangeincomediff_d = NULL) => 0.0417391221, -0.0185277841), -0.0542827874),
(pp_app_ind_ph_cnt = NULL) => 0.0027505816, 0.0027505816);

// Tree: 219 
final_score_219 := map(
(exp_type in ['C']) => 0.0059667345,
(exp_type in ['N']) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.562038485404395) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 112.5) => 0.0156196166,
      (f_curraddrmurderindex_i > 112.5) => 0.1669304738,
      (f_curraddrmurderindex_i = NULL) => 0.0833675569, 0.0833675569),
   (f_add_curr_mobility_index_n > 0.562038485404395) => -0.2006520073,
   (f_add_curr_mobility_index_n = NULL) => 0.0522861706, 0.0522861706),
(exp_type = '') => -0.0045904384, 0.0024033646);

// Tree: 220 
final_score_220 := map(
(NULL < mth_source_exp_fseen and mth_source_exp_fseen <= 3.5) => 0.0048568623,
(mth_source_exp_fseen > 3.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 117402) => -0.1228151082,
   (f_prevaddrmedianvalue_d > 117402) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 13.5) => -0.2401093252,
      (f_prevaddrlenofres_d > 13.5) => 0.0451062233,
      (f_prevaddrlenofres_d = NULL) => -0.0046933169, -0.0046933169),
   (f_prevaddrmedianvalue_d = NULL) => -0.0530057944, -0.0530057944),
(mth_source_exp_fseen = NULL) => 0.0012459507, 0.0012459507);

// Tree: 221 
final_score_221 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 155255.5) => -0.0245041072,
(f_curraddrmedianvalue_d > 155255.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 73.5) => 0.0121744140,
   (f_addrchangecrimediff_i > 73.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 1.5) => 0.1317591777,
      (r_pb_order_freq_d > 1.5) => 0.3304594832,
      (r_pb_order_freq_d = NULL) => 0.0579962380, 0.1585255341),
   (f_addrchangecrimediff_i = NULL) => 0.0219321901, 0.0238151298),
(f_curraddrmedianvalue_d = NULL) => -0.0016431496, -0.0016431496);

// Tree: 222 
final_score_222 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 13.5) => -0.0102762498,
(f_inq_count24_i > 13.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 31.5) => 
      map(
      (NULL < pk_cell_indicator and pk_cell_indicator <= 1.5) => 0.1225758386,
      (pk_cell_indicator > 1.5) => 0.3648761614,
      (pk_cell_indicator = NULL) => 0.2070621353, 0.2070621353),
   (f_inq_count_i > 31.5) => -0.0020469249,
   (f_inq_count_i = NULL) => 0.0697015563, 0.0697015563),
(f_inq_count24_i = NULL) => -0.0061275181, -0.0061275181);

// Tree: 223 
final_score_223 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 163.5) => -0.0159027760,
(f_prevaddrlenofres_d > 163.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 473) => 0.0052581200,
   (r_pb_order_freq_d > 473) => 0.2452002732,
   (r_pb_order_freq_d = NULL) => 
      map(
      (phone_subject_title in ['Associate','Associate By Shared Associates','Associate By SSN','Child','Daughter','Grandfather','Grandson','Husband','Neighbor','Subject at Household']) => -0.0515512048,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Vehicle','Brother','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Mother','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => 0.0947055018,
      (phone_subject_title = '') => 0.0428191940, 0.0428191940), 0.0228225156),
(f_prevaddrlenofres_d = NULL) => -0.0044135021, -0.0044135021);

// Tree: 224 
final_score_224 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 1.1297979910136) => -0.0053986208,
(f_add_input_mobility_index_n > 1.1297979910136) => 
   map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 4.5) => -0.0534896237,
   (f_rel_incomeover50_count_d > 4.5) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 122.5) => 0.0587360156,
      (f_prevaddrcartheftindex_i > 122.5) => 0.4307094360,
      (f_prevaddrcartheftindex_i = NULL) => 0.2378343291, 0.2378343291),
   (f_rel_incomeover50_count_d = NULL) => 0.1232687297, 0.1232687297),
(f_add_input_mobility_index_n = NULL) => 0.0536504854, -0.0021847618);

// Tree: 225 
final_score_225 := map(
(NULL < source_sx and source_sx <= 0.5) => 0.0033120996,
(source_sx > 0.5) => 
   map(
   (NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 12.5) => 
      map(
      (NULL < eda_address_match_best and eda_address_match_best <= 0.5) => 0.3131671224,
      (eda_address_match_best > 0.5) => 0.0420258866,
      (eda_address_match_best = NULL) => 0.1849912655, 0.1849912655),
   (mth_eda_dt_first_seen > 12.5) => 0.0231279292,
   (mth_eda_dt_first_seen = NULL) => 0.0601444926, 0.0601444926),
(source_sx = NULL) => 0.0065127062, 0.0065127062);

// Tree: 226 
final_score_226 := map(
(phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Child','Granddaughter','Grandfather','Grandmother','Grandson','Husband','Neighbor','Parent','Sibling','Son','Spouse','Subject at Household']) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 4.5) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 55.5) => -0.0426993259,
      (inq_firstseen_n > 55.5) => 0.0913518380,
      (inq_firstseen_n = NULL) => -0.0234857485, -0.0234857485),
   (f_crim_rel_under25miles_cnt_i > 4.5) => -0.1355961398,
   (f_crim_rel_under25miles_cnt_i = NULL) => -0.0355111030, -0.0355111030),
(phone_subject_title in ['Associate By Address','Associate By Shared Associates','Brother','Daughter','Father','Grandchild','Grandparent','Mother','Relative','Sister','Subject','Wife']) => 0.0159894343,
(phone_subject_title = '') => 0.0016264464, 0.0016264464);

// Tree: 227 
final_score_227 := map(
(NULL < pp_app_company_type and pp_app_company_type <= 5.5) => 0.0015375665,
(pp_app_company_type > 5.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 57.5) => 0.0263822658,
   (r_pb_order_freq_d > 57.5) => -0.1027794968,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < inq_lastseen_n and inq_lastseen_n <= 3.5) => 0.0106367088,
      (inq_lastseen_n > 3.5) => -0.1738710533,
      (inq_lastseen_n = NULL) => -0.0842085734, -0.0842085734), -0.0445733737),
(pp_app_company_type = NULL) => -0.0033645215, -0.0033645215);

// Tree: 228 
final_score_228 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.316176916758065) => -0.0150471563,
(f_add_curr_mobility_index_n > 0.316176916758065) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
      map(
      (NULL < eda_days_in_service and eda_days_in_service <= 1707) => 0.0433269847,
      (eda_days_in_service > 1707) => -0.0529787968,
      (eda_days_in_service = NULL) => 0.0292458320, 0.0292458320),
   (f_assocsuspicousidcount_i > 16.5) => -0.0925906818,
   (f_assocsuspicousidcount_i = NULL) => 0.0221426902, 0.0221426902),
(f_add_curr_mobility_index_n = NULL) => 0.0399250952, 0.0065229287);

// Tree: 229 
final_score_229 := map(
(NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 6.5) => 
   map(
   (NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 70.5) => 0.0076188474,
   (mth_source_ppla_fseen > 70.5) => -0.1113506297,
   (mth_source_ppla_fseen = NULL) => 0.0057788168, 0.0057788168),
(f_componentcharrisktype_i > 6.5) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 23.5) => 0.0311944463,
   (f_rel_count_i > 23.5) => 0.3140787168,
   (f_rel_count_i = NULL) => 0.1179884839, 0.1179884839),
(f_componentcharrisktype_i = NULL) => 0.0092475934, 0.0092475934);

// Tree: 230 
final_score_230 := map(
(NULL < mth_pp_eda_hist_nm_addr_dt and mth_pp_eda_hist_nm_addr_dt <= 60.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 17.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 190.5) => -0.0973942167,
      (f_curraddrcrimeindex_i > 190.5) => 0.2002687650,
      (f_curraddrcrimeindex_i = NULL) => -0.0754882830, -0.0754882830),
   (f_mos_inq_banko_cm_lseen_d > 17.5) => 0.0097829305,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0027805664, 0.0027805664),
(mth_pp_eda_hist_nm_addr_dt > 60.5) => 0.2093714634,
(mth_pp_eda_hist_nm_addr_dt = NULL) => 0.0051993803, 0.0051993803);

// Tree: 231 
final_score_231 := map(
(NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 197.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 29.5) => 0.0264179101,
   (r_pb_order_freq_d > 29.5) => -0.0136283884,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 24028) => 0.1220490541,
      (f_prevaddrmedianincome_d > 24028) => -0.0210881195,
      (f_prevaddrmedianincome_d = NULL) => -0.0062523212, -0.0062523212), 0.0032338675),
(f_prevaddrmurderindex_i > 197.5) => -0.1539659427,
(f_prevaddrmurderindex_i = NULL) => 0.0010065634, 0.0010065634);

// Tree: 232 
final_score_232 := map(
(NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 100.5) => -0.0080155648,
(r_mos_since_paw_fseen_d > 100.5) => 
   map(
   (NULL < _pp_rule_source_latest and _pp_rule_source_latest <= 0.5) => 
      map(
      (eda_pfrd_address_ind in ['1A','1C','XX']) => -0.0100370696,
      (eda_pfrd_address_ind in ['1B','1D','1E']) => 0.1934226889,
      (eda_pfrd_address_ind = '') => 0.0057982418, 0.0057982418),
   (_pp_rule_source_latest > 0.5) => 0.1867207641,
   (_pp_rule_source_latest = NULL) => 0.0322169384, 0.0322169384),
(r_mos_since_paw_fseen_d = NULL) => -0.0033374763, -0.0033374763);

// Tree: 233 
final_score_233 := map(
(exp_source in ['P']) => -0.0357032454,
(exp_source in ['S']) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 2.5) => 
      map(
      (pp_source in ['GONG','HEADER','INFUTOR','INQUIRY','PCNSR']) => 0.0273207186,
      (pp_source in ['CELL','IBEHAVIOR','INTRADO','OTHER','TARGUS','THRIVE']) => 0.2479227085,
      (pp_source = '') => 0.0740729240, 0.0698221566),
   (f_util_adl_count_n > 2.5) => -0.0168132344,
   (f_util_adl_count_n = NULL) => 0.0254405177, 0.0254405177),
(exp_source = '') => -0.0057663573, -0.0011938337);

// Tree: 234 
final_score_234 := map(
(NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 12.5) => 0.0103204627,
(mth_source_utildid_fseen > 12.5) => 
   map(
   (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 101.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 62.5) => -0.2991165551,
      (f_prevaddrmurderindex_i > 62.5) => -0.0670420596,
      (f_prevaddrmurderindex_i = NULL) => -0.1290897545, -0.1290897545),
   (mth_pp_app_npa_effective_dt > 101.5) => 0.0147862790,
   (mth_pp_app_npa_effective_dt = NULL) => -0.0490600965, -0.0490600965),
(mth_source_utildid_fseen = NULL) => 0.0058083467, 0.0058083467);

// Tree: 235 
final_score_235 := map(
(pp_rp_source in ['GONG','IBEHAVIOR','INTRADO','OTHER','TARGUS','THRIVE']) => -0.1656999922,
(pp_rp_source in ['CELL','HEADER','INFUTOR','INQUIRY','PCNSR']) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.418243681537505) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 4.5) => 0.0778160883,
      (r_pb_order_freq_d > 4.5) => -0.1539803715,
      (r_pb_order_freq_d = NULL) => -0.1042171564, -0.0626492142),
   (f_add_curr_mobility_index_n > 0.418243681537505) => 0.1099526450,
   (f_add_curr_mobility_index_n = NULL) => -0.0023917604, -0.0023917604),
(pp_rp_source = '') => -0.0029153752, -0.0039047300);

// Tree: 236 
final_score_236 := map(
(NULL < eda_days_ind_first_seen and eda_days_ind_first_seen <= 797) => 
   map(
   (NULL < eda_num_phs_connected_ind and eda_num_phs_connected_ind <= 0.5) => 0.0009142788,
   (eda_num_phs_connected_ind > 0.5) => 0.2029832089,
   (eda_num_phs_connected_ind = NULL) => 0.0022745959, 0.0022745959),
(eda_days_ind_first_seen > 797) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.311909408097035) => -0.0029327584,
   (f_add_input_mobility_index_n > 0.311909408097035) => -0.1946596189,
   (f_add_input_mobility_index_n = NULL) => -0.1056435765, -0.1056435765),
(eda_days_ind_first_seen = NULL) => -0.0024131036, -0.0024131036);

// Tree: 237 
final_score_237 := map(
(NULL < inq_num_adls and inq_num_adls <= 2.5) => -0.0065407181,
(inq_num_adls > 2.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 35884) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 4.5) => 0.0930227427,
      (f_rel_homeover100_count_d > 4.5) => 0.4305805595,
      (f_rel_homeover100_count_d = NULL) => 0.1985095604, 0.1985095604),
   (f_curraddrmedianincome_d > 35884) => 0.0140492225,
   (f_curraddrmedianincome_d = NULL) => 0.0659561857, 0.0659561857),
(inq_num_adls = NULL) => -0.0011932120, -0.0011932120);

// Tree: 238 
final_score_238 := map(
(NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 4.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Property','Associate By Vehicle','Brother','Child','Grandson','Husband','Mother','Parent','Son','Spouse','Subject at Household','Wife']) => -0.0719825560,
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Neighbor','Relative','Sibling','Sister','Subject']) => 
      map(
      (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 58.5) => -0.0153821327,
      (mth_pp_datevendorfirstseen > 58.5) => 0.1007218852,
      (mth_pp_datevendorfirstseen = NULL) => -0.0086462353, -0.0086462353),
   (phone_subject_title = '') => -0.0216446527, -0.0216446527),
(f_componentcharrisktype_i > 4.5) => 0.0182888998,
(f_componentcharrisktype_i = NULL) => -0.0044300600, -0.0044300600);

// Tree: 239 
final_score_239 := map(
(NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 79.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 71.5) => -0.0017350520,
   (mth_source_ppdid_fseen > 71.5) => -0.2054862674,
   (mth_source_ppdid_fseen = NULL) => -0.0039798322, -0.0039798322),
(mth_source_ppdid_fseen > 79.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -59810) => 0.3349462353,
   (f_addrchangevaluediff_d > -59810) => 0.0263490978,
   (f_addrchangevaluediff_d = NULL) => 0.0553322102, 0.0801787168),
(mth_source_ppdid_fseen = NULL) => -0.0003143386, -0.0003143386);

// Tree: 240 
final_score_240 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.77804338484554) => 0.0026168296,
(f_add_input_mobility_index_n > 0.77804338484554) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 74541) => 
      map(
      (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 4.5) => -0.0540051516,
      (f_corrssnaddrcount_d > 4.5) => -0.3011907330,
      (f_corrssnaddrcount_d = NULL) => -0.0850772603, -0.0850772603),
   (f_prevaddrmedianincome_d > 74541) => 0.1092184367,
   (f_prevaddrmedianincome_d = NULL) => -0.0578131867, -0.0578131867),
(f_add_input_mobility_index_n = NULL) => -0.0916928253, -0.0025759130);

// Tree: 241 
final_score_241 := map(
(NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 35.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 11.5) => 
      map(
      (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 4.5) => -0.0040884212,
      (f_addrchangeecontrajindex_d > 4.5) => 0.1013846459,
      (f_addrchangeecontrajindex_d = NULL) => -0.0012354200, -0.0012354200),
   (f_rel_homeover500_count_d > 11.5) => -0.2654910135,
   (f_rel_homeover500_count_d = NULL) => -0.0031734193, -0.0031734193),
(f_rel_homeover100_count_d > 35.5) => 0.1758484367,
(f_rel_homeover100_count_d = NULL) => -0.0019744714, -0.0019744714);

// Tree: 242 
final_score_242 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 25.5) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 20.5) => -0.0102632533,
   (f_rel_under100miles_cnt_d > 20.5) => 
      map(
      (NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 26.5) => 0.0831706483,
      (mth_pp_orig_lastseen > 26.5) => -0.2054728721,
      (mth_pp_orig_lastseen = NULL) => 0.0595113434, 0.0595113434),
   (f_rel_under100miles_cnt_d = NULL) => -0.0050600132, -0.0050600132),
(f_rel_under25miles_cnt_d > 25.5) => -0.0931687822,
(f_rel_under25miles_cnt_d = NULL) => -0.0085164766, -0.0085164766);

// Tree: 243 
final_score_243 := map(
(NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 443.5) => 0.0087678219,
(eda_max_days_interrupt > 443.5) => 
   map(
   (NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 4.5) => -0.0932204866,
   (f_componentcharrisktype_i > 4.5) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => -0.0278409605,
      (f_sourcerisktype_i > 5.5) => 0.2038648294,
      (f_sourcerisktype_i = NULL) => 0.0271850211, 0.0271850211),
   (f_componentcharrisktype_i = NULL) => -0.0416497452, -0.0416497452),
(eda_max_days_interrupt = NULL) => -0.0008658825, -0.0008658825);

// Tree: 244 
final_score_244 := map(
(pp_rp_source in ['CELL','GONG','IBEHAVIOR','INFUTOR','OTHER','PCNSR','THRIVE']) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 78) => -0.1954960214,
   (f_curraddrburglaryindex_i > 78) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0983992757,
      (f_rel_felony_count_i > 0.5) => -0.1271314429,
      (f_rel_felony_count_i = NULL) => 0.0142223174, 0.0142223174),
   (f_curraddrburglaryindex_i = NULL) => -0.0671339347, -0.0671339347),
(pp_rp_source in ['HEADER','INQUIRY','INTRADO','TARGUS']) => 0.0359868530,
(pp_rp_source = '') => 0.0058013734, 0.0042761346);

// Tree: 245 
final_score_245 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 221356.5) => 
   map(
   (pp_source in ['CELL','GONG','INFUTOR','OTHER','PCNSR','THRIVE']) => -0.0289635965,
   (pp_source in ['HEADER','IBEHAVIOR','INQUIRY','INTRADO','TARGUS']) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 43.5) => 0.1482552653,
      (f_curraddrburglaryindex_i > 43.5) => 0.0244905092,
      (f_curraddrburglaryindex_i = NULL) => 0.0410392245, 0.0410392245),
   (pp_source = '') => 0.0097047746, 0.0143532595),
(f_curraddrmedianvalue_d > 221356.5) => -0.0217870694,
(f_curraddrmedianvalue_d = NULL) => 0.0036381175, 0.0036381175);

// Tree: 246 
final_score_246 := map(
(NULL < mth_source_ppca_fseen and mth_source_ppca_fseen <= 45.5) => 
   map(
   (pp_src in ['CY','E1','EM','EQ','FA','LP','NW','PL','SL','TN','UT','UW','ZK','ZT']) => -0.0071422827,
   (pp_src in ['E2','EB','EN','FF','KW','LA','MD','VO','VW']) => 0.0881143927,
   (pp_src = '') => 0.0025270750, 0.0029304721),
(mth_source_ppca_fseen > 45.5) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => -0.2028149300,
   (f_sourcerisktype_i > 5.5) => 0.0741332644,
   (f_sourcerisktype_i = NULL) => -0.1131554426, -0.1131554426),
(mth_source_ppca_fseen = NULL) => -0.0008479947, -0.0008479947);

// Tree: 247 
final_score_247 := map(
(NULL < f_srchunvrfdssncount_i and f_srchunvrfdssncount_i <= 0.5) => 0.0021819116,
(f_srchunvrfdssncount_i > 0.5) => 
   map(
   (exp_type in ['C']) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 132172) => -0.0727274312,
      (f_prevaddrmedianvalue_d > 132172) => 0.1934916087,
      (f_prevaddrmedianvalue_d = NULL) => 0.0567352526, 0.0567352526),
   (exp_type in ['N']) => 0.1995764517,
   (exp_type = '') => 0.0425620567, 0.0573403142),
(f_srchunvrfdssncount_i = NULL) => 0.0080278367, 0.0080278367);

// Tree: 248 
final_score_248 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Property','Brother','Child','Granddaughter','Grandfather','Grandson','Husband','Neighbor','Relative','Sister','Son','Subject','Subject at Household']) => -0.0047942900,
(phone_subject_title in ['Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Daughter','Father','Grandchild','Grandmother','Grandparent','Mother','Parent','Sibling','Spouse','Wife']) => 
   map(
   (NULL < _phone_match_code_z and _phone_match_code_z <= 0.5) => 0.0459173669,
   (_phone_match_code_z > 0.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 153) => 0.0925815794,
      (f_prevaddrmurderindex_i > 153) => 0.5686245300,
      (f_prevaddrmurderindex_i = NULL) => 0.2527455628, 0.2527455628),
   (_phone_match_code_z = NULL) => 0.0878314142, 0.0878314142),
(phone_subject_title = '') => 0.0066578519, 0.0066578519);

// Tree: 249 
final_score_249 := map(
(NULL < _internal_ver_match_hhid and _internal_ver_match_hhid <= 0.5) => -0.0035472415,
(_internal_ver_match_hhid > 0.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 15184) => -0.0095566667,
   (f_addrchangeincomediff_d > 15184) => 0.1313752105,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 18) => 0.2512703614,
      (mth_pp_datefirstseen > 18) => -0.1035729456,
      (mth_pp_datefirstseen = NULL) => 0.0563973978, 0.0563973978), 0.0428043341),
(_internal_ver_match_hhid = NULL) => -0.0001716789, -0.0001716789);

// Tree: 250 
final_score_250 := map(
(pp_rp_source in ['GONG','HEADER','INQUIRY','INTRADO','THRIVE']) => -0.0845956894,
(pp_rp_source in ['CELL','IBEHAVIOR','INFUTOR','OTHER','PCNSR','TARGUS']) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 78) => -0.0834115598,
   (f_curraddrburglaryindex_i > 78) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 3.5) => -0.0268090512,
      (f_rel_incomeover50_count_d > 3.5) => 0.1982227547,
      (f_rel_incomeover50_count_d = NULL) => 0.1099749877, 0.1099749877),
   (f_curraddrburglaryindex_i = NULL) => 0.0475094215, 0.0475094215),
(pp_rp_source = '') => -0.0004873466, -0.0006649203);

// Tree: 251 
final_score_251 := map(
(NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 15.5) => -0.0024148183,
(f_rel_homeover300_count_d > 15.5) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 37) => -0.0915896403,
   (f_curraddrburglaryindex_i > 37) => 
      map(
      (phone_subject_title in ['Associate By Business','Associate By Shared Associates','Daughter','Father','Neighbor','Relative','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => 0.0631148583,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Parent','Spouse']) => 0.3740144920,
      (phone_subject_title = '') => 0.1476157844, 0.1476157844),
   (f_curraddrburglaryindex_i = NULL) => 0.0786477970, 0.0786477970),
(f_rel_homeover300_count_d = NULL) => 0.0001973370, 0.0001973370);

// Tree: 252 
final_score_252 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 18.5) => -0.0154945908,
(f_rel_under500miles_cnt_d > 18.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -36388) => -0.2006365084,
   (f_addrchangeincomediff_d > -36388) => 0.0154824122,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 20.5) => 0.3090210556,
      (f_prevaddrlenofres_d > 20.5) => 0.0394874339,
      (f_prevaddrlenofres_d = NULL) => 0.0777145581, 0.0777145581), 0.0232311023),
(f_rel_under500miles_cnt_d = NULL) => -0.0084163365, -0.0084163365);

// Tree: 253 
final_score_253 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 418.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 23.5) => 
      map(
      (NULL < f_prevaddroccupantowned_d and f_prevaddroccupantowned_d <= 0.5) => -0.1455867150,
      (f_prevaddroccupantowned_d > 0.5) => 0.1355741840,
      (f_prevaddroccupantowned_d = NULL) => -0.0950512593, -0.0950512593),
   (f_mos_inq_banko_cm_fseen_d > 23.5) => 0.0030134058,
   (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0005424406, -0.0005424406),
(f_prevaddrlenofres_d > 418.5) => -0.1841671737,
(f_prevaddrlenofres_d = NULL) => -0.0027353598, -0.0027353598);

// Tree: 254 
final_score_254 := map(
(NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 46.5) => 
   map(
   (pp_source in ['OTHER','TARGUS','THRIVE']) => -0.2414110884,
   (pp_source in ['CELL','GONG','HEADER','IBEHAVIOR','INFUTOR','INQUIRY','INTRADO','PCNSR']) => 
      map(
      (NULL < _pp_glb_dppa_fl_glb and _pp_glb_dppa_fl_glb <= 0.5) => 0.0818262891,
      (_pp_glb_dppa_fl_glb > 0.5) => -0.0109153539,
      (_pp_glb_dppa_fl_glb = NULL) => 0.0082937443, 0.0082937443),
   (pp_source = '') => -0.0042669687, -0.0013292785),
(mth_pp_datelastseen > 46.5) => -0.1164760789,
(mth_pp_datelastseen = NULL) => -0.0065466783, -0.0065466783);

// Tree: 255 
final_score_255 := map(
(phone_subject_title in ['Associate','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Granddaughter','Grandparent','Grandson','Subject at Household']) => 
   map(
   (NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 219) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 22.5) => 0.0698555347,
      (f_mos_inq_banko_cm_lseen_d > 22.5) => -0.0481925099,
      (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0264658760, -0.0264658760),
   (r_mos_since_paw_fseen_d > 219) => -0.2830611393,
   (r_mos_since_paw_fseen_d = NULL) => -0.0341026397, -0.0341026397),
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By SSN','Brother','Father','Grandchild','Grandfather','Grandmother','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => 0.0039866684,
(phone_subject_title = '') => -0.0035054330, -0.0035054330);

// Tree: 256 
final_score_256 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 38) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 6.5) => -0.0550823447,
   (f_sourcerisktype_i > 6.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 56.5) => 0.2958801478,
      (f_fp_prevaddrcrimeindex_i > 56.5) => -0.0542597754,
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.1124735214, 0.1124735214),
   (f_sourcerisktype_i = NULL) => -0.0438977510, -0.0438977510),
(f_curraddrcartheftindex_i > 38) => 0.0097026512,
(f_curraddrcartheftindex_i = NULL) => -0.0001701161, -0.0001701161);

// Tree: 257 
final_score_257 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 14.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Daughter','Father','Grandmother','Mother','Neighbor','Relative','Sibling','Sister','Son','Subject','Wife']) => -0.1699690108,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Parent','Spouse','Subject at Household']) => 0.1432180285,
   (phone_subject_title = '') => -0.1101940651, -0.1101940651),
(f_mos_inq_banko_cm_lseen_d > 14.5) => 
   map(
   (NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 88.5) => 0.0090389289,
   (mth_source_ppfla_fseen > 88.5) => -0.1401291762,
   (mth_source_ppfla_fseen = NULL) => 0.0076146282, 0.0076146282),
(f_mos_inq_banko_cm_lseen_d = NULL) => 0.0024835155, 0.0024835155);

// Tree: 258 
final_score_258 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 180.5) => 0.0039945186,
(f_prevaddrcartheftindex_i > 180.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 249.5) => 
      map(
      (NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 28.5) => -0.0121186719,
      (mth_pp_orig_lastseen > 28.5) => -0.2094441487,
      (mth_pp_orig_lastseen = NULL) => -0.0295114737, -0.0295114737),
   (f_prevaddrlenofres_d > 249.5) => -0.1521847982,
   (f_prevaddrlenofres_d = NULL) => -0.0469573650, -0.0469573650),
(f_prevaddrcartheftindex_i = NULL) => -0.0026339993, -0.0026339993);

// Tree: 259 
final_score_259 := map(
(NULL < _internal_ver_match_level and _internal_ver_match_level <= 2.5) => 0.0019623069,
(_internal_ver_match_level > 2.5) => 
   map(
   (NULL < inq_num_addresses and inq_num_addresses <= 1.5) => 
      map(
      (NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 1.5) => 0.1858073464,
      (mth_pp_first_build_date > 1.5) => -0.0638580289,
      (mth_pp_first_build_date = NULL) => 0.0420000902, 0.0420000902),
   (inq_num_addresses > 1.5) => 0.2683290614,
   (inq_num_addresses = NULL) => 0.1066655106, 0.1066655106),
(_internal_ver_match_level = NULL) => 0.0041076131, 0.0041076131);

// Tree: 260 
final_score_260 := map(
(NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 6.5) => 
   map(
   (NULL < mth_source_exp_fseen and mth_source_exp_fseen <= 3.5) => 0.0075190757,
   (mth_source_exp_fseen > 3.5) => -0.0478663444,
   (mth_source_exp_fseen = NULL) => 0.0039945490, 0.0039945490),
(mth_source_rel_fseen > 6.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 0.0290534507,
   (f_corraddrnamecount_d > 3.5) => -0.2023684230,
   (f_corraddrnamecount_d = NULL) => -0.0962467903, -0.0962467903),
(mth_source_rel_fseen = NULL) => 0.0018702448, 0.0018702448);

// Tree: 261 
final_score_261 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 120979.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 111805) => -0.0076338725,
   (f_addrchangevaluediff_d > 111805) => -0.2216367570,
   (f_addrchangevaluediff_d = NULL) => -0.0103985746, -0.0103985746),
(f_addrchangevaluediff_d > 120979.5) => 
   map(
   (pp_source in ['CELL','HEADER','IBEHAVIOR','INQUIRY','OTHER','PCNSR','TARGUS','THRIVE']) => 0.0002430057,
   (pp_source in ['GONG','INFUTOR','INTRADO']) => 0.2408351250,
   (pp_source = '') => 0.0363698650, 0.0439665985),
(f_addrchangevaluediff_d = NULL) => 0.0246710241, 0.0025975557);

// Tree: 262 
final_score_262 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 251987) => 0.0060262938,
(f_addrchangevaluediff_d > 251987) => -0.1027578893,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => 0.0065057979,
   (f_curraddractivephonelist_d > 0.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Property','Daughter','Father','Husband','Neighbor','Relative','Wife']) => -0.1729012671,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Parent','Sibling','Sister','Son','Spouse','Subject','Subject at Household']) => 0.1241298466,
      (phone_subject_title = '') => 0.0485412836, 0.0485412836),
   (f_curraddractivephonelist_d = NULL) => 0.0121279937, 0.0121279937), 0.0048596868);

// Tree: 263 
final_score_263 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 193.5) => -0.0021600892,
(f_curraddrcartheftindex_i > 193.5) => 
   map(
   (NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 3.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 20191) => -0.0083009967,
      (f_curraddrmedianincome_d > 20191) => 0.2536199711,
      (f_curraddrmedianincome_d = NULL) => 0.1651169957, 0.1651169957),
   (mth_pp_first_build_date > 3.5) => -0.0616299861,
   (mth_pp_first_build_date = NULL) => 0.0906939066, 0.0906939066),
(f_curraddrcartheftindex_i = NULL) => 0.0013848696, 0.0013848696);

// Tree: 264 
final_score_264 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 2.5) => -0.0663865447,
(f_rel_under500miles_cnt_d > 2.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 231292) => 0.0082625299,
   (f_addrchangevaluediff_d > 231292) => 
      map(
      (phone_subject_title in ['Associate','Daughter','Father','Grandfather','Relative','Spouse','Subject at Household','Wife']) => -0.2246935891,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Sibling','Sister','Son','Subject']) => -0.0341393066,
      (phone_subject_title = '') => -0.0791199312, -0.0791199312),
   (f_addrchangevaluediff_d = NULL) => 0.0126701109, 0.0067743850),
(f_rel_under500miles_cnt_d = NULL) => 0.0016555288, 0.0016555288);

// Tree: 265 
final_score_265 := map(
(NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 77.5) => 0.0008397845,
(mth_pp_datefirstseen > 77.5) => 
   map(
   (NULL < f_inq_per_addr_i and f_inq_per_addr_i <= 0.5) => -0.0115205094,
   (f_inq_per_addr_i > 0.5) => 
      map(
      (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 55.5) => 0.2507151001,
      (mth_pp_datevendorfirstseen > 55.5) => 0.0522000542,
      (mth_pp_datevendorfirstseen = NULL) => 0.1375615239, 0.1375615239),
   (f_inq_per_addr_i = NULL) => 0.0591344827, 0.0591344827),
(mth_pp_datefirstseen = NULL) => 0.0051601854, 0.0051601854);

// Tree: 266 
final_score_266 := map(
(NULL < _internal_ver_match_level and _internal_ver_match_level <= 2.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 40.5) => -0.0068552949,
   (f_rel_ageover30_count_d > 40.5) => -0.2068514008,
   (f_rel_ageover30_count_d = NULL) => -0.0084162635, -0.0084162635),
(_internal_ver_match_level > 2.5) => 
   map(
   (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 147.5) => 0.1694080838,
   (mth_pp_app_npa_effective_dt > 147.5) => -0.0607189572,
   (mth_pp_app_npa_effective_dt = NULL) => 0.1001225231, 0.1001225231),
(_internal_ver_match_level = NULL) => -0.0060525808, -0.0060525808);

// Tree: 267 
final_score_267 := map(
(NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 29.5) => 0.0087659889,
(mth_pp_eda_hist_did_dt > 29.5) => 
   map(
   (NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 1.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.395824491737055) => -0.0443129156,
      (f_add_curr_mobility_index_n > 0.395824491737055) => 0.2516517210,
      (f_add_curr_mobility_index_n = NULL) => 0.0890337888, 0.0890337888),
   (mth_pp_first_build_date > 1.5) => -0.0496305069,
   (mth_pp_first_build_date = NULL) => -0.0379428155, -0.0379428155),
(mth_pp_eda_hist_did_dt = NULL) => -0.0031723462, -0.0031723462);

// Tree: 268 
final_score_268 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 1.23818314633184) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 145) => 
      map(
      (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 108.5) => 0.0044916963,
      (mth_source_ppdid_fseen > 108.5) => -0.2123029158,
      (mth_source_ppdid_fseen = NULL) => 0.0025182395, 0.0025182395),
   (mth_source_ppdid_fseen > 145) => 0.1704345702,
   (mth_source_ppdid_fseen = NULL) => 0.0036370158, 0.0036370158),
(f_add_curr_mobility_index_n > 1.23818314633184) => -0.2110957534,
(f_add_curr_mobility_index_n = NULL) => -0.0425856805, 0.0017369595);

// Tree: 269 
final_score_269 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 20.5) => 0.0016766506,
(mth_exp_last_update > 20.5) => 
   map(
   (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 76.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 2.5) => -0.0348617623,
      (f_srchssnsrchcount_i > 2.5) => -0.1586950388,
      (f_srchssnsrchcount_i = NULL) => -0.0876610055, -0.0876610055),
   (mth_pp_datefirstseen > 76.5) => 0.0834878526,
   (mth_pp_datefirstseen = NULL) => -0.0648411578, -0.0648411578),
(mth_exp_last_update = NULL) => -0.0024120801, -0.0024120801);

// Tree: 270 
final_score_270 := map(
(exp_source in ['P']) => -0.0164675728,
(exp_source in ['S']) => 
   map(
   (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => 
      map(
      (NULL < f_college_income_d and f_college_income_d <= 7.5) => 0.0384408469,
      (f_college_income_d > 7.5) => 0.2252366452,
      (f_college_income_d = NULL) => -0.0011189263, 0.0146371901),
   (f_curraddractivephonelist_d > 0.5) => 0.0952222522,
   (f_curraddractivephonelist_d = NULL) => 0.0251566772, 0.0251566772),
(exp_source = '') => -0.0009648470, 0.0032841879);

// Tree: 271 
final_score_271 := map(
(NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 21.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 536936) => 0.0191418644,
   (f_prevaddrmedianvalue_d > 536936) => -0.1000039061,
   (f_prevaddrmedianvalue_d = NULL) => 0.0143364009, 0.0143364009),
(mth_source_ppdid_fseen > 21.5) => 
   map(
   (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 8.5) => -0.0122867736,
   (pp_app_ind_ph_cnt > 8.5) => -0.1639613334,
   (pp_app_ind_ph_cnt = NULL) => -0.0363257605, -0.0363257605),
(mth_source_ppdid_fseen = NULL) => 0.0064769742, 0.0064769742);

// Tree: 272 
final_score_272 := map(
(NULL < _pp_rule_low_vend_conf and _pp_rule_low_vend_conf <= 0.5) => 0.0005044603,
(_pp_rule_low_vend_conf > 0.5) => 
   map(
   (NULL < f_inq_per_addr_i and f_inq_per_addr_i <= 0.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 65) => -0.1704833564,
      (f_mos_inq_banko_cm_lseen_d > 65) => 0.1202260982,
      (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0336789072, -0.0336789072),
   (f_inq_per_addr_i > 0.5) => 0.2321821569,
   (f_inq_per_addr_i = NULL) => 0.0883754904, 0.0883754904),
(_pp_rule_low_vend_conf = NULL) => 0.0027678518, 0.0027678518);

// Tree: 273 
final_score_273 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 50.5) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 13.5) => -0.0115081338,
   (inq_adl_firstseen_n > 13.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 25.5) => 0.0644829116,
      (f_addrchangecrimediff_i > 25.5) => -0.0698567104,
      (f_addrchangecrimediff_i = NULL) => 0.1024737330, 0.0446187118),
   (inq_adl_firstseen_n = NULL) => -0.0062688324, -0.0062688324),
(f_rel_incomeover25_count_d > 50.5) => 0.2539384614,
(f_rel_incomeover25_count_d = NULL) => -0.0046797802, -0.0046797802);

// Tree: 274 
final_score_274 := map(
(NULL < f_estimated_income_d and f_estimated_income_d <= 25500) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 46497.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 152) => -0.0970855515,
      (f_fp_prevaddrcrimeindex_i > 152) => 0.1525282389,
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.0426981711, 0.0426981711),
   (f_curraddrmedianincome_d > 46497.5) => 0.2907961834,
   (f_curraddrmedianincome_d = NULL) => 0.1028431438, 0.1028431438),
(f_estimated_income_d > 25500) => -0.0025256576,
(f_estimated_income_d = NULL) => 0.0007320264, 0.0007320264);

// Tree: 275 
final_score_275 := map(
(NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 3.5) => 
   map(
   (phone_subject_title in ['Associate By SSN','Daughter','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Parent','Spouse','Wife']) => -0.1189936338,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Father','Grandchild','Grandfather','Mother','Neighbor','Relative','Sibling','Sister','Son','Subject','Subject at Household']) => 0.0121616016,
   (phone_subject_title = '') => 0.0083754034, 0.0083754034),
(f_rel_incomeover100_count_d > 3.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Brother','Father','Grandfather','Grandmother','Husband','Neighbor','Parent','Relative','Sister','Son','Subject at Household','Wife']) => -0.1401168038,
   (phone_subject_title in ['Associate By Property','Associate By SSN','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandparent','Grandson','Mother','Sibling','Spouse','Subject']) => 0.0414074950,
   (phone_subject_title = '') => -0.0600584297, -0.0600584297),
(f_rel_incomeover100_count_d = NULL) => 0.0034017574, 0.0034017574);

// Tree: 276 
final_score_276 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 8.5) => -0.0032695166,
(f_rel_ageover40_count_d > 8.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Brother','Child','Father','Grandmother','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => 
      map(
      (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 1.5) => -0.0014319729,
      (inq_adl_lastseen_n > 1.5) => 0.1163095957,
      (inq_adl_lastseen_n = NULL) => 0.0143504075, 0.0143504075),
   (phone_subject_title in ['Associate By Property','Associate By SSN','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Subject at Household']) => 0.2031860716,
   (phone_subject_title = '') => 0.0298408331, 0.0298408331),
(f_rel_ageover40_count_d = NULL) => 0.0007164931, 0.0007164931);

// Tree: 277 
final_score_277 := map(
(NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 21.5) => 0.0071806648,
(mth_source_ppdid_fseen > 21.5) => 
   map(
   (NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 7.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.28878863133478) => -0.2007804852,
      (f_add_curr_mobility_index_n > 0.28878863133478) => -0.0487689262,
      (f_add_curr_mobility_index_n = NULL) => -0.1072349104, -0.1072349104),
   (mth_pp_orig_lastseen > 7.5) => -0.0141018550,
   (mth_pp_orig_lastseen = NULL) => -0.0335541386, -0.0335541386),
(mth_source_ppdid_fseen = NULL) => 0.0008326935, 0.0008326935);

// Tree: 278 
final_score_278 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 106991.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 177.5) => -0.0019197407,
   (f_curraddrmurderindex_i > 177.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.243238070316105) => 0.2586592803,
      (f_add_curr_mobility_index_n > 0.243238070316105) => 0.0353478250,
      (f_add_curr_mobility_index_n = NULL) => 0.0507906554, 0.0507906554),
   (f_curraddrmurderindex_i = NULL) => 0.0051550059, 0.0051550059),
(f_prevaddrmedianincome_d > 106991.5) => -0.0922671773,
(f_prevaddrmedianincome_d = NULL) => 0.0012996379, 0.0012996379);

// Tree: 279 
final_score_279 := map(
(NULL < mth_source_exp_fseen and mth_source_exp_fseen <= 16.5) => 
   map(
   (pp_source in ['GONG','INTRADO','OTHER']) => -0.2473964738,
   (pp_source in ['CELL','HEADER','IBEHAVIOR','INFUTOR','INQUIRY','PCNSR','TARGUS','THRIVE']) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 70.5) => -0.0233018655,
      (r_pb_order_freq_d > 70.5) => 0.0520741875,
      (r_pb_order_freq_d = NULL) => 0.0044506867, 0.0014537839),
   (pp_source = '') => 0.0059016081, 0.0024936402),
(mth_source_exp_fseen > 16.5) => -0.0906664862,
(mth_source_exp_fseen = NULL) => 0.0004321411, 0.0004321411);

// Tree: 280 
final_score_280 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 176.5) => -0.0074700310,
(r_pb_order_freq_d > 176.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By SSN','Brother','Daughter','Father','Grandfather','Grandmother','Grandparent','Mother','Neighbor','Relative','Sibling','Wife']) => -0.0783197012,
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Grandchild','Granddaughter','Grandson','Husband','Parent','Sister','Son','Spouse','Subject','Subject at Household']) => 
      map(
      (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 86.5) => 0.0911519552,
      (mth_pp_datefirstseen > 86.5) => -0.1426312708,
      (mth_pp_datefirstseen = NULL) => 0.0722162422, 0.0722162422),
   (phone_subject_title = '') => 0.0283514640, 0.0283514640),
(r_pb_order_freq_d = NULL) => -0.0172653514, -0.0075408578);

// Tree: 281 
final_score_281 := map(
(NULL < mth_source_sx_fseen and mth_source_sx_fseen <= 64.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 23.5) => 0.0163474157,
   (f_rel_ageover30_count_d > 23.5) => -0.0596992893,
   (f_rel_ageover30_count_d = NULL) => 0.0110815263, 0.0110815263),
(mth_source_sx_fseen > 64.5) => 
   map(
   (NULL < f_adl_util_conv_n and f_adl_util_conv_n <= 0.5) => 0.0030658709,
   (f_adl_util_conv_n > 0.5) => -0.2158661561,
   (f_adl_util_conv_n = NULL) => -0.0992089446, -0.0992089446),
(mth_source_sx_fseen = NULL) => 0.0093124367, 0.0093124367);

// Tree: 282 
final_score_282 := map(
(NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 182) => -0.0037061256,
(f_fp_prevaddrcrimeindex_i > 182) => 
   map(
   (NULL < eda_days_in_service and eda_days_in_service <= 553.5) => 0.0070012812,
   (eda_days_in_service > 553.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Property','Associate By SSN','Brother','Daughter','Grandfather','Grandson','Mother','Neighbor','Parent','Son','Spouse','Wife']) => -0.0361030499,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Child','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Husband','Relative','Sibling','Sister','Subject','Subject at Household']) => 0.2595758052,
      (phone_subject_title = '') => 0.1355147471, 0.1355147471),
   (eda_days_in_service = NULL) => 0.0492482367, 0.0492482367),
(f_fp_prevaddrcrimeindex_i = NULL) => 0.0016891543, 0.0016891543);

// Tree: 283 
final_score_283 := map(
(NULL < r_has_paw_source_d and r_has_paw_source_d <= 0.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By SSN','Child','Daughter','Grandfather','Grandmother','Neighbor','Relative','Sibling','Sister','Spouse','Subject']) => -0.0381808460,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Father','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Mother','Parent','Son','Subject at Household','Wife']) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -3950) => -0.0807410517,
      (f_addrchangeincomediff_d > -3950) => 0.0936214101,
      (f_addrchangeincomediff_d = NULL) => 0.0387724666, 0.0298896282),
   (phone_subject_title = '') => -0.0203140795, -0.0203140795),
(r_has_paw_source_d > 0.5) => 0.0180598259,
(r_has_paw_source_d = NULL) => 0.0004116933, 0.0004116933);

// Tree: 284 
final_score_284 := map(
(NULL < _pp_rule_ins_ver_above and _pp_rule_ins_ver_above <= 0.5) => -0.0018715759,
(_pp_rule_ins_ver_above > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 23.5) => -0.1208931057,
   (f_mos_inq_banko_cm_lseen_d > 23.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.4808768965935) => 0.0658182681,
      (f_add_input_mobility_index_n > 0.4808768965935) => 0.2689296272,
      (f_add_input_mobility_index_n = NULL) => 0.1292905678, 0.1292905678),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0819135931, 0.0819135931),
(_pp_rule_ins_ver_above = NULL) => 0.0010811621, 0.0010811621);

// Tree: 285 
final_score_285 := map(
(pp_rp_source in ['GONG','INQUIRY','OTHER','THRIVE']) => -0.1090181685,
(pp_rp_source in ['CELL','HEADER','IBEHAVIOR','INFUTOR','INTRADO','PCNSR','TARGUS']) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 122.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 32.5) => -0.0206521740,
      (f_prevaddrlenofres_d > 32.5) => 0.2327437201,
      (f_prevaddrlenofres_d = NULL) => 0.0985929527, 0.0985929527),
   (f_prevaddrageoldest_d > 122.5) => -0.0450955215,
   (f_prevaddrageoldest_d = NULL) => 0.0397205917, 0.0397205917),
(pp_rp_source = '') => 0.0061824316, 0.0061668525);

// Tree: 286 
final_score_286 := map(
(NULL < eda_min_days_connected_ind and eda_min_days_connected_ind <= 6.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Property','Child','Daughter','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Neighbor','Sister']) => -0.0476718147,
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Father','Grandchild','Husband','Mother','Parent','Relative','Sibling','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0156612063,
   (phone_subject_title = '') => 0.0017828654, 0.0017828654),
(eda_min_days_connected_ind > 6.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 3.5) => 0.1195472453,
   (f_rel_ageover30_count_d > 3.5) => -0.1274863802,
   (f_rel_ageover30_count_d = NULL) => -0.0840084621, -0.0840084621),
(eda_min_days_connected_ind = NULL) => -0.0020039664, -0.0020039664);

// Tree: 287 
final_score_287 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 13.5) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 13.5) => 0.0043217978,
   (f_inq_count24_i > 13.5) => 0.1345635898,
   (f_inq_count24_i = NULL) => 0.0073613754, 0.0073613754),
(f_srchssnsrchcount_i > 13.5) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 5.5) => -0.0097333523,
   (mth_exp_last_update > 5.5) => -0.1797261515,
   (mth_exp_last_update = NULL) => -0.0419542097, -0.0419542097),
(f_srchssnsrchcount_i = NULL) => 0.0038268704, 0.0038268704);

// Tree: 288 
final_score_288 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 4.5) => -0.0067233594,
(f_rel_homeover500_count_d > 4.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -10954) => -0.0547655751,
   (f_addrchangeincomediff_d > -10954) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Daughter','Father','Grandson','Mother','Neighbor','Parent','Sibling','Sister','Wife']) => -0.1002702875,
      (phone_subject_title in ['Associate','Associate By Property','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Husband','Relative','Son','Spouse','Subject','Subject at Household']) => 0.1699203247,
      (phone_subject_title = '') => 0.0828027909, 0.0828027909),
   (f_addrchangeincomediff_d = NULL) => -0.0234191833, 0.0281670871),
(f_rel_homeover500_count_d = NULL) => -0.0051294212, -0.0051294212);

// Tree: 289 
final_score_289 := map(
(NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 108.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 4.5) => 
      map(
      (NULL < inq_num_addresses and inq_num_addresses <= 3.5) => -0.0135562961,
      (inq_num_addresses > 3.5) => -0.1816191450,
      (inq_num_addresses = NULL) => -0.0227625361, -0.0227625361),
   (f_rel_under25miles_cnt_d > 4.5) => 0.0091445287,
   (f_rel_under25miles_cnt_d = NULL) => -0.0006455279, -0.0006455279),
(mth_source_ppdid_fseen > 108.5) => -0.1687260921,
(mth_source_ppdid_fseen = NULL) => -0.0030267184, -0.0030267184);

// Tree: 290 
final_score_290 := map(
(NULL < f_college_income_d and f_college_income_d <= 5.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By SSN','Associate By Vehicle','Brother','Daughter','Grandfather','Grandmother','Parent','Spouse']) => -0.2893685579,
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Child','Father','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Mother','Neighbor','Relative','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 40.5) => 0.0041400064,
      (mth_pp_datevendorfirstseen > 40.5) => 0.1867500315,
      (mth_pp_datevendorfirstseen = NULL) => 0.0219074683, 0.0219074683),
   (phone_subject_title = '') => 0.0018378383, 0.0018378383),
(f_college_income_d > 5.5) => -0.0555480145,
(f_college_income_d = NULL) => 0.0096810810, 0.0048993628);

// Tree: 291 
final_score_291 := map(
(NULL < f_inq_per_addr_i and f_inq_per_addr_i <= 5.5) => -0.0012952991,
(f_inq_per_addr_i > 5.5) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 2.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => -0.0376690143,
      (f_mos_inq_banko_om_fseen_d > 36.5) => 0.1128304772,
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0794841655, 0.0794841655),
   (f_srchfraudsrchcountyr_i > 2.5) => -0.0547906870,
   (f_srchfraudsrchcountyr_i = NULL) => 0.0521527763, 0.0521527763),
(f_inq_per_addr_i = NULL) => 0.0054068305, 0.0054068305);

// Tree: 292 
final_score_292 := map(
(NULL < pk_phone_match_level and pk_phone_match_level <= 3.5) => 0.0086917898,
(pk_phone_match_level > 3.5) => 
   map(
   (NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 181.5) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 123.5) => -0.0587539321,
      (mth_pp_app_npa_effective_dt > 123.5) => 0.0035808130,
      (mth_pp_app_npa_effective_dt = NULL) => -0.0296965987, -0.0296965987),
   (r_mos_since_paw_fseen_d > 181.5) => 0.1071171288,
   (r_mos_since_paw_fseen_d = NULL) => -0.0217701948, -0.0217701948),
(pk_phone_match_level = NULL) => 0.0013660766, 0.0013660766);

// Tree: 293 
final_score_293 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 162.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 153.5) => -0.0001519428,
   (f_prevaddrlenofres_d > 153.5) => -0.1417127397,
   (f_prevaddrlenofres_d = NULL) => -0.0057047485, -0.0057047485),
(f_prevaddrlenofres_d > 162.5) => 
   map(
   (pp_src in ['E1','EN','EQ','KW','PL','SL','UT','UW','ZT']) => 0.0224412660,
   (pp_src in ['CY','E2','EB','EM','FA','FF','LA','LP','MD','NW','TN','VO','VW','ZK']) => 0.2033916408,
   (pp_src = '') => 0.0297398929, 0.0334918527),
(f_prevaddrlenofres_d = NULL) => 0.0062254502, 0.0062254502);

// Tree: 294 
final_score_294 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 17.5) => 0.0102125456,
(mth_exp_last_update > 17.5) => 
   map(
   (pp_source in ['HEADER','INQUIRY','THRIVE']) => -0.0926551104,
   (pp_source in ['CELL','GONG','IBEHAVIOR','INFUTOR','INTRADO','OTHER','PCNSR','TARGUS']) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -12) => 0.1850934948,
      (f_addrchangecrimediff_i > -12) => 0.0809146061,
      (f_addrchangecrimediff_i = NULL) => 0.1356983321, 0.1356983321),
   (pp_source = '') => -0.0487108149, -0.0248971157),
(mth_exp_last_update = NULL) => 0.0075570203, 0.0075570203);

// Tree: 295 
final_score_295 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.543576968138115) => 0.0064606894,
(f_add_curr_mobility_index_n > 0.543576968138115) => 
   map(
   (NULL < f_accident_count_i and f_accident_count_i <= 1.5) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 8.5) => -0.1034189507,
      (f_rel_under500miles_cnt_d > 8.5) => -0.0202378951,
      (f_rel_under500miles_cnt_d = NULL) => -0.0527709302, -0.0527709302),
   (f_accident_count_i > 1.5) => 0.1293840971,
   (f_accident_count_i = NULL) => -0.0397062250, -0.0397062250),
(f_add_curr_mobility_index_n = NULL) => -0.0708623451, -0.0008111742);

// Tree: 296 
final_score_296 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 15.5) => 0.0066466875,
(mth_source_ppdid_lseen > 15.5) => 
   map(
   (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => -0.0593832473,
   (f_curraddractivephonelist_d > 0.5) => 
      map(
      (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 39.5) => 0.1610529802,
      (mth_source_ppdid_lseen > 39.5) => -0.1140166983,
      (mth_source_ppdid_lseen = NULL) => 0.0418561195, 0.0418561195),
   (f_curraddractivephonelist_d = NULL) => -0.0471167651, -0.0471167651),
(mth_source_ppdid_lseen = NULL) => -0.0011713909, -0.0011713909);

// Tree: 297 
final_score_297 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 53.5) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 47.5) => 0.0058911594,
   (inq_adl_firstseen_n > 47.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 39.5) => 0.0465184993,
      (f_mos_inq_banko_cm_lseen_d > 39.5) => 0.2339269693,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.1449416526, 0.1449416526),
   (inq_adl_firstseen_n = NULL) => 0.0081833817, 0.0081833817),
(inq_adl_lastseen_n > 53.5) => -0.1270434433,
(inq_adl_lastseen_n = NULL) => 0.0064576208, 0.0064576208);

// Tree: 298 
final_score_298 := map(
(NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => 
   map(
   (pp_source in ['GONG','HEADER','INQUIRY','OTHER','THRIVE']) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 91693) => -0.0201171365,
      (f_curraddrmedianincome_d > 91693) => 0.1742006927,
      (f_curraddrmedianincome_d = NULL) => -0.0057687736, -0.0057687736),
   (pp_source in ['CELL','IBEHAVIOR','INFUTOR','INTRADO','PCNSR','TARGUS']) => 0.0805190066,
   (pp_source = '') => 0.0132262005, 0.0182389137),
(f_util_add_input_conv_n > 0.5) => -0.0187770680,
(f_util_add_input_conv_n = NULL) => -0.0026375626, -0.0026375626);

// Tree: 299 
final_score_299 := map(
(NULL < f_inq_addrs_per_ssn_i and f_inq_addrs_per_ssn_i <= 1.5) => 
   map(
   (NULL < eda_num_ph_owners_hist and eda_num_ph_owners_hist <= 5.5) => 0.0048112506,
   (eda_num_ph_owners_hist > 5.5) => -0.1790549917,
   (eda_num_ph_owners_hist = NULL) => 0.0026239941, 0.0026239941),
(f_inq_addrs_per_ssn_i > 1.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 3.5) => 0.0325425443,
   (f_assocsuspicousidcount_i > 3.5) => -0.1337164848,
   (f_assocsuspicousidcount_i = NULL) => -0.0804147579, -0.0804147579),
(f_inq_addrs_per_ssn_i = NULL) => -0.0019552416, -0.0019552416);

// Tree: 300 
final_score_300 := map(
(NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 7.5) => -0.0087782082,
(f_corrssnnamecount_d > 7.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 2500) => -0.1658309654,
   (f_prevaddrmedianvalue_d > 2500) => 
      map(
      (NULL < _pp_rule_ins_ver_above and _pp_rule_ins_ver_above <= 0.5) => 0.0264582461,
      (_pp_rule_ins_ver_above > 0.5) => 0.1416901840,
      (_pp_rule_ins_ver_above = NULL) => 0.0310124931, 0.0310124931),
   (f_prevaddrmedianvalue_d = NULL) => 0.0252692587, 0.0252692587),
(f_corrssnnamecount_d = NULL) => 0.0011968225, 0.0011968225);

// Tree: 301 
final_score_301 := map(
(NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 12.5) => -0.0000642263,
(mth_pp_first_build_date > 12.5) => 
   map(
   (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 8.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 2.5) => 0.2297795774,
      (f_assocrisktype_i > 2.5) => -0.0407746486,
      (f_assocrisktype_i = NULL) => 0.0615080466, 0.0615080466),
   (mth_pp_datelastseen > 8.5) => -0.0697257191,
   (mth_pp_datelastseen = NULL) => -0.0507130534, -0.0507130534),
(mth_pp_first_build_date = NULL) => -0.0067770787, -0.0067770787);

// Tree: 302 
final_score_302 := map(
(NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 0.5) => 0.0006067478,
(mth_source_ppla_lseen > 0.5) => 
   map(
   (pp_source in ['IBEHAVIOR','INFUTOR','INQUIRY','OTHER','THRIVE']) => 
      map(
      (NULL < f_inq_addrs_per_ssn_i and f_inq_addrs_per_ssn_i <= 0.5) => -0.0109574065,
      (f_inq_addrs_per_ssn_i > 0.5) => 0.1387415596,
      (f_inq_addrs_per_ssn_i = NULL) => 0.0251099610, 0.0251099610),
   (pp_source in ['CELL','GONG','HEADER','INTRADO','PCNSR','TARGUS']) => 0.1501133483,
   (pp_source = '') => 0.0510346881, 0.0510346881),
(mth_source_ppla_lseen = NULL) => 0.0034821028, 0.0034821028);

// Tree: 303 
final_score_303 := map(
(NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 4.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 171549.5) => 0.0304802121,
      (f_prevaddrmedianvalue_d > 171549.5) => 0.3007270479,
      (f_prevaddrmedianvalue_d = NULL) => 0.1243159190, 0.1243159190),
   (f_mos_inq_banko_om_lseen_d > 4.5) => 0.0019907736,
   (f_mos_inq_banko_om_lseen_d = NULL) => 0.0091883305, 0.0091883305),
(f_util_add_input_conv_n > 0.5) => -0.0203310940,
(f_util_add_input_conv_n = NULL) => -0.0076433751, -0.0076433751);

// Tree: 304 
final_score_304 := map(
(NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 179.5) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 170.5) => -0.0066830300,
   (f_curraddrburglaryindex_i > 170.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 4088.5) => 0.0792124762,
      (f_addrchangevaluediff_d > 4088.5) => 0.1969416216,
      (f_addrchangevaluediff_d = NULL) => -0.0427845479, 0.0719885585),
   (f_curraddrburglaryindex_i = NULL) => -0.0024133008, -0.0024133008),
(f_curraddrburglaryindex_i > 179.5) => -0.0571101829,
(f_curraddrburglaryindex_i = NULL) => -0.0088380546, -0.0088380546);

// Tree: 305 
final_score_305 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 12.5) => -0.0058562634,
(inq_adl_lastseen_n > 12.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.195746235006365) => -0.1664567813,
   (f_add_curr_mobility_index_n > 0.195746235006365) => 
      map(
      (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 69) => 0.0476879365,
      (mth_pp_datefirstseen > 69) => 0.2258268930,
      (mth_pp_datefirstseen = NULL) => 0.0609590335, 0.0609590335),
   (f_add_curr_mobility_index_n = NULL) => 0.0457574416, 0.0457574416),
(inq_adl_lastseen_n = NULL) => -0.0013058454, -0.0013058454);

// Tree: 306 
final_score_306 := map(
(NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 109.5) => 
   map(
   (NULL < _internal_ver_match_hhid and _internal_ver_match_hhid <= 0.5) => -0.0030718558,
   (_internal_ver_match_hhid > 0.5) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 6.5) => 0.0018276707,
      (f_rel_homeover100_count_d > 6.5) => 0.1184808819,
      (f_rel_homeover100_count_d = NULL) => 0.0451277609, 0.0451277609),
   (_internal_ver_match_hhid = NULL) => 0.0003872788, 0.0003872788),
(mth_pp_eda_hist_did_dt > 109.5) => -0.0834286349,
(mth_pp_eda_hist_did_dt = NULL) => -0.0026156096, -0.0026156096);

// Tree: 307 
final_score_307 := map(
(NULL < f_accident_count_i and f_accident_count_i <= 1.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.32811006830556) => -0.0247821389,
   (f_add_curr_mobility_index_n > 0.32811006830556) => 0.0119651062,
   (f_add_curr_mobility_index_n = NULL) => -0.0040872284, -0.0051070808),
(f_accident_count_i > 1.5) => 
   map(
   (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 23) => 0.0337105282,
   (mth_pp_datevendorfirstseen > 23) => 0.2434048337,
   (mth_pp_datevendorfirstseen = NULL) => 0.0672790553, 0.0672790553),
(f_accident_count_i = NULL) => -0.0010300630, -0.0010300630);

// Tree: 308 
final_score_308 := map(
(NULL < mth_source_exp_fseen and mth_source_exp_fseen <= 16.5) => 
   map(
   (NULL < mth_source_edahistory_fseen and mth_source_edahistory_fseen <= 13.5) => 
      map(
      (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0348246929,
      (_phone_match_code_n > 0.5) => 0.0306155144,
      (_phone_match_code_n = NULL) => -0.0070750876, -0.0070750876),
   (mth_source_edahistory_fseen > 13.5) => -0.1593711183,
   (mth_source_edahistory_fseen = NULL) => -0.0106368202, -0.0106368202),
(mth_source_exp_fseen > 16.5) => -0.1426260811,
(mth_source_exp_fseen = NULL) => -0.0137739025, -0.0137739025);

// Tree: 309 
final_score_309 := map(
(NULL < inq_num and inq_num <= 1.5) => -0.0050779436,
(inq_num > 1.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.65753518133483) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 5.5) => 0.1350070156,
      (f_rel_ageover30_count_d > 5.5) => -0.0060444037,
      (f_rel_ageover30_count_d = NULL) => 0.0280954303, 0.0280954303),
   (f_add_curr_mobility_index_n > 0.65753518133483) => 0.2270390132,
   (f_add_curr_mobility_index_n = NULL) => 0.0471513290, 0.0471513290),
(inq_num = NULL) => -0.0018675036, -0.0018675036);

// Tree: 310 
final_score_310 := map(
(NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 0.5) => 
   map(
   (NULL < eda_months_addr_last_seen and eda_months_addr_last_seen <= 9.5) => -0.0071406352,
   (eda_months_addr_last_seen > 9.5) => -0.1786678384,
   (eda_months_addr_last_seen = NULL) => -0.0094421556, -0.0094421556),
(mth_source_ppla_lseen > 0.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 96063.5) => 0.0428476344,
   (f_addrchangevaluediff_d > 96063.5) => 0.2664149785,
   (f_addrchangevaluediff_d = NULL) => 0.0053179785, 0.0624076860),
(mth_source_ppla_lseen = NULL) => -0.0053032817, -0.0053032817);

// Tree: 311 
final_score_311 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 8.5) => 0.0123905894,
(f_srchaddrsrchcount_i > 8.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 5) => -0.2159432114,
   (f_curraddrmurderindex_i > 5) => 
      map(
      (pp_app_ph_use in ['B','P']) => -0.0778242433,
      (pp_app_ph_use in ['O']) => 0.0175319447,
      (pp_app_ph_use = '') => -0.0278409983, -0.0240736529),
   (f_curraddrmurderindex_i = NULL) => -0.0297436768, -0.0297436768),
(f_srchaddrsrchcount_i = NULL) => 0.0030411240, 0.0030411240);

// Tree: 312 
final_score_312 := map(
(NULL < mth_source_paw_lseen and mth_source_paw_lseen <= 43) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 201164.5) => -0.0027403244,
   (f_addrchangevaluediff_d > 201164.5) => 0.0544626721,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < mth_source_md_fseen and mth_source_md_fseen <= 13.5) => 0.0158072642,
      (mth_source_md_fseen > 13.5) => 0.1897238875,
      (mth_source_md_fseen = NULL) => 0.0202836692, 0.0202836692), 0.0051214504),
(mth_source_paw_lseen > 43) => -0.1120369570,
(mth_source_paw_lseen = NULL) => 0.0039829247, 0.0039829247);

// Tree: 313 
final_score_313 := map(
(NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 15) => 
   map(
   (NULL < pk_cell_indicator and pk_cell_indicator <= 2.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 103196) => -0.0119143846,
      (f_curraddrmedianincome_d > 103196) => 0.1926303445,
      (f_curraddrmedianincome_d = NULL) => 0.0101985591, 0.0101985591),
   (pk_cell_indicator > 2.5) => 0.1328760645,
   (pk_cell_indicator = NULL) => 0.0335257455, 0.0335257455),
(f_fp_prevaddrcrimeindex_i > 15) => -0.0057594155,
(f_fp_prevaddrcrimeindex_i = NULL) => -0.0023963223, -0.0023963223);

// Tree: 314 
final_score_314 := map(
(NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 85.5) => 0.0036544007,
(mth_pp_eda_hist_did_dt > 85.5) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 140.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 130.5) => -0.1117747590,
      (f_fp_prevaddrcrimeindex_i > 130.5) => 0.0052289079,
      (f_fp_prevaddrcrimeindex_i = NULL) => -0.0669204558, -0.0669204558),
   (mth_pp_app_npa_last_change_dt > 140.5) => 0.1701144818,
   (mth_pp_app_npa_last_change_dt = NULL) => -0.0496162523, -0.0496162523),
(mth_pp_eda_hist_did_dt = NULL) => -0.0008736983, -0.0008736983);

// Tree: 315 
final_score_315 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 23491.5) => -0.0088499032,
(f_addrchangeincomediff_d > 23491.5) => 0.0311378132,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 19.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Business','Associate By SSN','Brother','Child','Daughter','Father','Husband','Mother','Neighbor','Relative','Son','Spouse','Subject','Subject at Household','Wife']) => -0.0502201895,
      (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Parent','Sibling','Sister']) => 0.0744740552,
      (phone_subject_title = '') => -0.0237047466, -0.0237047466),
   (f_rel_under500miles_cnt_d > 19.5) => 0.0679742049,
   (f_rel_under500miles_cnt_d = NULL) => -0.0076283428, -0.0076283428), -0.0026095310);

// Tree: 316 
final_score_316 := map(
(NULL < f_vardobcount_i and f_vardobcount_i <= 2.5) => -0.0021034616,
(f_vardobcount_i > 2.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 5.5) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 2.5) => 0.1262808378,
      (f_sourcerisktype_i > 2.5) => -0.0487154652,
      (f_sourcerisktype_i = NULL) => -0.0031847529, -0.0031847529),
   (f_assocsuspicousidcount_i > 5.5) => 0.1434656772,
   (f_assocsuspicousidcount_i = NULL) => 0.0534386076, 0.0534386076),
(f_vardobcount_i = NULL) => 0.0025792422, 0.0025792422);

// Tree: 317 
final_score_317 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 32226) => 
   map(
   (NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 4.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Granddaughter','Grandmother','Grandparent','Grandson','Mother','Neighbor','Parent','Son','Spouse','Subject','Subject at Household']) => -0.0348131285,
      (phone_subject_title in ['Associate','Associate By Property','Daughter','Grandchild','Grandfather','Husband','Relative','Sibling','Sister','Wife']) => 0.0850767388,
      (phone_subject_title = '') => -0.0207749698, -0.0207749698),
   (mth_source_rel_fseen > 4.5) => -0.1467013612,
   (mth_source_rel_fseen = NULL) => -0.0243068859, -0.0243068859),
(f_prevaddrmedianincome_d > 32226) => 0.0100343652,
(f_prevaddrmedianincome_d = NULL) => 0.0025790163, 0.0025790163);

// Tree: 318 
final_score_318 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 240.5) => 0.0074183239,
(f_prevaddrlenofres_d > 240.5) => 
   map(
   (NULL < _pp_glb_dppa_fl_glb and _pp_glb_dppa_fl_glb <= 0.5) => -0.0066239748,
   (_pp_glb_dppa_fl_glb > 0.5) => 
      map(
      (NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 16.5) => -0.1184298400,
      (mth_pp_first_build_date > 16.5) => 0.0681319086,
      (mth_pp_first_build_date = NULL) => -0.0886808044, -0.0886808044),
   (_pp_glb_dppa_fl_glb = NULL) => -0.0296771464, -0.0296771464),
(f_prevaddrlenofres_d = NULL) => 0.0016982988, 0.0016982988);

// Tree: 319 
final_score_319 := map(
(NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 6.5) => 0.0028562528,
(mth_internal_ver_first_seen > 6.5) => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 3640) => 
      map(
      (NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 5.5) => -0.1048106959,
      (mth_pp_orig_lastseen > 5.5) => -0.0279118723,
      (mth_pp_orig_lastseen = NULL) => -0.0407857515, -0.0407857515),
   (eda_days_ph_first_seen > 3640) => 0.0679069896,
   (eda_days_ph_first_seen = NULL) => -0.0277212053, -0.0277212053),
(mth_internal_ver_first_seen = NULL) => -0.0044113083, -0.0044113083);

// Tree: 320 
final_score_320 := map(
(NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 5.5) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By SSN','Brother','Child','Daughter','Granddaughter','Grandmother','Mother','Neighbor','Spouse','Subject at Household','Wife']) => -0.0312606538,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Father','Grandchild','Grandfather','Grandparent','Grandson','Husband','Parent','Relative','Sibling','Sister','Son','Subject']) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 144.5) => 0.0676300388,
      (f_prevaddrcartheftindex_i > 144.5) => -0.0034273984,
      (f_prevaddrcartheftindex_i = NULL) => 0.0403847012, 0.0403847012),
   (phone_subject_title = '') => 0.0169315926, 0.0169315926),
(f_rel_ageover30_count_d > 5.5) => -0.0040585291,
(f_rel_ageover30_count_d = NULL) => 0.0011588112, 0.0011588112);

// Tree: 321 
final_score_321 := map(
(NULL < eda_num_ph_owners_hist and eda_num_ph_owners_hist <= 2.5) => 
   map(
   (eda_pfrd_address_ind in ['1A','1E','XX']) => 0.0023193556,
   (eda_pfrd_address_ind in ['1B','1C','1D']) => 0.0804643344,
   (eda_pfrd_address_ind = '') => 0.0063187788, 0.0063187788),
(eda_num_ph_owners_hist > 2.5) => 
   map(
   (NULL < pk_phone_match_level and pk_phone_match_level <= 2.5) => 0.0018319349,
   (pk_phone_match_level > 2.5) => -0.0945293833,
   (pk_phone_match_level = NULL) => -0.0351158538, -0.0351158538),
(eda_num_ph_owners_hist = NULL) => 0.0012831683, 0.0012831683);

// Tree: 322 
final_score_322 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 17.5) => 0.0107558769,
(mth_exp_last_update > 17.5) => 
   map(
   (NULL < eda_days_in_service and eda_days_in_service <= 1466) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 7.5) => -0.0808081763,
      (f_rel_ageover40_count_d > 7.5) => 0.0553813610,
      (f_rel_ageover40_count_d = NULL) => -0.0595779665, -0.0595779665),
   (eda_days_in_service > 1466) => 0.1213863226,
   (eda_days_in_service = NULL) => -0.0395892748, -0.0395892748),
(mth_exp_last_update = NULL) => 0.0067534933, 0.0067534933);

// Tree: 323 
final_score_323 := map(
(NULL < source_rel and source_rel <= 0.5) => -0.0022750228,
(source_rel > 0.5) => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 4625.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 70.5) => -0.0934514345,
      (f_mos_inq_banko_cm_fseen_d > 70.5) => 0.0724259595,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0184193661, 0.0184193661),
   (eda_days_ph_first_seen > 4625.5) => 0.1704442604,
   (eda_days_ph_first_seen = NULL) => 0.0530118571, 0.0530118571),
(source_rel = NULL) => -0.0001130022, -0.0001130022);

// Tree: 324 
final_score_324 := map(
(NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 3.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Child','Mother','Neighbor','Relative','Son','Subject at Household']) => -0.0444655369,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Parent','Sibling','Sister','Spouse','Subject','Wife']) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 36) => -0.0533953167,
      (f_mos_inq_banko_om_lseen_d > 36) => 0.1522292488,
      (f_mos_inq_banko_om_lseen_d = NULL) => 0.0930342981, 0.0930342981),
   (phone_subject_title = '') => 0.0245983072, 0.0245983072),
(f_rel_educationover8_count_d > 3.5) => -0.0009310359,
(f_rel_educationover8_count_d = NULL) => 0.0010396818, 0.0010396818);

// Tree: 325 
final_score_325 := map(
(NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0049690696,
(_pp_rule_high_vend_conf > 0.5) => 
   map(
   (pp_app_ph_use in ['P']) => 0.0104411021,
   (pp_app_ph_use in ['B','O']) => 
      map(
      (NULL < _phone_match_code_lns and _phone_match_code_lns <= 0.5) => -0.0314964738,
      (_phone_match_code_lns > 0.5) => 0.1842667631,
      (_phone_match_code_lns = NULL) => 0.1066376620, 0.1066376620),
   (pp_app_ph_use = '') => 0.0368480009, 0.0368480009),
(_pp_rule_high_vend_conf = NULL) => 0.0017727763, 0.0017727763);

// Tree: 326 
final_score_326 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 3.5) => -0.0091318186,
(f_rel_felony_count_i > 3.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 87) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 146) => -0.0095492940,
      (f_fp_prevaddrburglaryindex_i > 146) => 0.2311927128,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0852224462, 0.0852224462),
   (r_pb_order_freq_d > 87) => 0.2171952744,
   (r_pb_order_freq_d = NULL) => -0.0054560432, 0.0599532525),
(f_rel_felony_count_i = NULL) => -0.0051112940, -0.0051112940);

// Tree: 327 
final_score_327 := map(
(NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 190.5) => 0.0005336834,
(f_curraddrburglaryindex_i > 190.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 13.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Property','Brother','Daughter','Father','Grandmother','Son','Subject at Household','Wife']) => -0.1731671459,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Spouse','Subject']) => -0.0108070212,
      (phone_subject_title = '') => -0.0419515735, -0.0419515735),
   (f_srchaddrsrchcount_i > 13.5) => -0.2275903530,
   (f_srchaddrsrchcount_i = NULL) => -0.0785167876, -0.0785167876),
(f_curraddrburglaryindex_i = NULL) => -0.0031318888, -0.0031318888);

// Tree: 328 
final_score_328 := map(
(NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 28.5) => -0.0015351361,
(inq_adl_firstseen_n > 28.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 11.5) => 
      map(
      (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 25.5) => 0.1979997731,
      (inq_adl_lastseen_n > 25.5) => 0.0394581768,
      (inq_adl_lastseen_n = NULL) => 0.0694525328, 0.0694525328),
   (f_srchssnsrchcount_i > 11.5) => -0.0724311862,
   (f_srchssnsrchcount_i = NULL) => 0.0399164279, 0.0399164279),
(inq_adl_firstseen_n = NULL) => 0.0009594317, 0.0009594317);

// Tree: 329 
final_score_329 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 29.5) => 0.0008647720,
(inq_adl_lastseen_n > 29.5) => 
   map(
   (NULL < subject_ssn_mismatch and subject_ssn_mismatch <= -0.5) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 135662.5) => -0.0698716521,
      (f_curraddrmedianvalue_d > 135662.5) => 0.1603513244,
      (f_curraddrmedianvalue_d = NULL) => 0.0564453793, 0.0564453793),
   (subject_ssn_mismatch > -0.5) => -0.1186323882,
   (subject_ssn_mismatch = NULL) => -0.0696626166, -0.0696626166),
(inq_adl_lastseen_n = NULL) => -0.0024712619, -0.0024712619);

// Tree: 330 
final_score_330 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 49.5) => 
   map(
   (NULL < _pp_app_nonpub_targ_lap and _pp_app_nonpub_targ_lap <= 0.5) => 
      map(
      (phone_subject_title in ['Associate By Business','Associate By SSN','Brother','Child','Daughter','Father','Grandfather','Grandmother','Grandson','Husband','Neighbor','Parent','Sister','Spouse','Subject','Wife']) => -0.0044603455,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Grandchild','Granddaughter','Grandparent','Mother','Relative','Sibling','Son','Subject at Household']) => 0.0727511608,
      (phone_subject_title = '') => 0.0228418325, 0.0228418325),
   (_pp_app_nonpub_targ_lap > 0.5) => 0.1594734420,
   (_pp_app_nonpub_targ_lap = NULL) => 0.0285933344, 0.0285933344),
(f_curraddrcartheftindex_i > 49.5) => -0.0056747713,
(f_curraddrcartheftindex_i = NULL) => 0.0025240506, 0.0025240506);

// Tree: 331 
final_score_331 := map(
(NULL < pk_phone_match_level and pk_phone_match_level <= 0.5) => -0.0625192095,
(pk_phone_match_level > 0.5) => 
   map(
   (NULL < _phone_match_code_tcza and _phone_match_code_tcza <= 0.5) => 
      map(
      (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 10.5) => 0.0725008057,
      (mth_pp_datelastseen > 10.5) => -0.0314876703,
      (mth_pp_datelastseen = NULL) => 0.0343994281, 0.0343994281),
   (_phone_match_code_tcza > 0.5) => -0.0033004851,
   (_phone_match_code_tcza = NULL) => -0.0002873846, -0.0002873846),
(pk_phone_match_level = NULL) => -0.0055407678, -0.0055407678);

// Tree: 332 
final_score_332 := map(
(NULL < f_vardobcount_i and f_vardobcount_i <= 2.5) => -0.0077809221,
(f_vardobcount_i > 2.5) => 
   map(
   (NULL < f_inq_ssns_per_addr_i and f_inq_ssns_per_addr_i <= 2.5) => 
      map(
      (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 1017.5) => 0.1137443533,
      (eda_days_ph_first_seen > 1017.5) => 0.0141688099,
      (eda_days_ph_first_seen = NULL) => 0.0635776793, 0.0635776793),
   (f_inq_ssns_per_addr_i > 2.5) => -0.1347225277,
   (f_inq_ssns_per_addr_i = NULL) => 0.0422927386, 0.0422927386),
(f_vardobcount_i = NULL) => -0.0034654404, -0.0034654404);

// Tree: 333 
final_score_333 := map(
(pp_source in ['CELL','GONG','HEADER','INFUTOR','INQUIRY','INTRADO','OTHER','PCNSR','THRIVE']) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 0.5) => 0.1194445912,
   (f_prevaddrlenofres_d > 0.5) => 
      map(
      (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 4.5) => 0.0527043752,
      (mth_pp_datelastseen > 4.5) => -0.0224406642,
      (mth_pp_datelastseen = NULL) => -0.0111201128, -0.0111201128),
   (f_prevaddrlenofres_d = NULL) => -0.0063812187, -0.0063812187),
(pp_source in ['IBEHAVIOR','TARGUS']) => 0.0667522026,
(pp_source = '') => 0.0025305873, 0.0017222897);

// Tree: 334 
final_score_334 := map(
(NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 1.5) => 0.0005210364,
(f_srchunvrfdphonecount_i > 1.5) => 
   map(
   (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 6.5) => 
      map(
      (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 3.5) => -0.0568259731,
      (inq_adl_lastseen_n > 3.5) => -0.1535000660,
      (inq_adl_lastseen_n = NULL) => -0.0809944963, -0.0809944963),
   (f_crim_rel_under100miles_cnt_i > 6.5) => 0.1482609542,
   (f_crim_rel_under100miles_cnt_i = NULL) => -0.0537946971, -0.0537946971),
(f_srchunvrfdphonecount_i = NULL) => -0.0024873175, -0.0024873175);

// Tree: 335 
final_score_335 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 98297) => -0.0005393429,
(f_prevaddrmedianincome_d > 98297) => 
   map(
   (NULL < f_estimated_income_d and f_estimated_income_d <= 103500) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.28540957797978) => 0.2128509555,
      (f_add_curr_mobility_index_n > 0.28540957797978) => 0.0308504860,
      (f_add_curr_mobility_index_n = NULL) => 0.0998851468, 0.0998851468),
   (f_estimated_income_d > 103500) => -0.0706500015,
   (f_estimated_income_d = NULL) => 0.0584498999, 0.0584498999),
(f_prevaddrmedianincome_d = NULL) => 0.0029009479, 0.0029009479);

// Tree: 336 
final_score_336 := map(
(NULL < mth_source_edadid_fseen and mth_source_edadid_fseen <= 36) => 
   map(
   (NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 6.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Brother','Father','Grandfather','Grandmother','Grandparent','Neighbor','Sibling','Sister','Subject','Subject at Household']) => 0.0048774769,
      (phone_subject_title in ['Associate By Business','Associate By SSN','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandson','Husband','Mother','Parent','Relative','Son','Spouse','Wife']) => 0.2926670597,
      (phone_subject_title = '') => 0.0101721618, 0.0101721618),
   (mth_eda_dt_first_seen > 6.5) => -0.0298074764,
   (mth_eda_dt_first_seen = NULL) => -0.0095008090, -0.0095008090),
(mth_source_edadid_fseen > 36) => 0.1166982886,
(mth_source_edadid_fseen = NULL) => -0.0082153247, -0.0082153247);

// Tree: 337 
final_score_337 := map(
(NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 6.5) => 0.0033732648,
(mth_source_inf_fseen > 6.5) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 134) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 90) => -0.1350684643,
      (f_fp_prevaddrburglaryindex_i > 90) => -0.0203616400,
      (f_fp_prevaddrburglaryindex_i = NULL) => -0.0688914503, -0.0688914503),
   (mth_pp_app_npa_last_change_dt > 134) => 0.1752768358,
   (mth_pp_app_npa_last_change_dt = NULL) => -0.0474731796, -0.0474731796),
(mth_source_inf_fseen = NULL) => -0.0000200701, -0.0000200701);

// Tree: 338 
final_score_338 := map(
(NULL < pp_did_score and pp_did_score <= 79.5) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 136.5) => -0.0001089853,
   (mth_pp_app_npa_last_change_dt > 136.5) => 
      map(
      (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 70.5) => 0.0435747944,
      (mth_pp_eda_hist_did_dt > 70.5) => 0.2534503016,
      (mth_pp_eda_hist_did_dt = NULL) => 0.0837187672, 0.0837187672),
   (mth_pp_app_npa_last_change_dt = NULL) => 0.0032690634, 0.0032690634),
(pp_did_score > 79.5) => -0.0392371222,
(pp_did_score = NULL) => -0.0024342604, -0.0024342604);

// Tree: 339 
final_score_339 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 19.5) => 0.0076099221,
(mth_exp_last_update > 19.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= -0.5) => -0.0400386190,
   (r_pb_order_freq_d > -0.5) => -0.0990733462,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 161.5) => 0.0743166303,
      (f_prevaddrcartheftindex_i > 161.5) => -0.1093992096,
      (f_prevaddrcartheftindex_i = NULL) => 0.0297254071, 0.0297254071), -0.0360586104),
(mth_exp_last_update = NULL) => 0.0046189268, 0.0046189268);

// Tree: 340 
final_score_340 := map(
(NULL < _pp_rule_ins_ver_above and _pp_rule_ins_ver_above <= 0.5) => -0.0034618859,
(_pp_rule_ins_ver_above > 0.5) => 
   map(
   (NULL < _pp_src_all_ut and _pp_src_all_ut <= 0.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.478499474901205) => 0.0507917649,
      (f_add_input_mobility_index_n > 0.478499474901205) => 0.2633134335,
      (f_add_input_mobility_index_n = NULL) => 0.1278064980, 0.1278064980),
   (_pp_src_all_ut > 0.5) => -0.0779059822,
   (_pp_src_all_ut = NULL) => 0.0746526021, 0.0746526021),
(_pp_rule_ins_ver_above = NULL) => -0.0007364301, -0.0007364301);

// Tree: 341 
final_score_341 := map(
(NULL < eda_num_phs_connected_ind and eda_num_phs_connected_ind <= 0.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 6.5) => 
      map(
      (NULL < mth_source_inf_lseen and mth_source_inf_lseen <= 3.5) => 0.0036121159,
      (mth_source_inf_lseen > 3.5) => -0.0953277379,
      (mth_source_inf_lseen = NULL) => 0.0004134525, 0.0004134525),
   (f_srchvelocityrisktype_i > 6.5) => -0.0615131807,
   (f_srchvelocityrisktype_i = NULL) => -0.0075426845, -0.0075426845),
(eda_num_phs_connected_ind > 0.5) => 0.0784560464,
(eda_num_phs_connected_ind = NULL) => -0.0051764859, -0.0051764859);

// Tree: 342 
final_score_342 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 34.5) => 0.0086411905,
(f_addrchangecrimediff_i > 34.5) => -0.0345501004,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 624) => -0.0130585394,
   (eda_avg_days_interrupt > 624) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Daughter','Mother','Neighbor','Relative','Spouse','Wife']) => -0.0768286993,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Parent','Sibling','Sister','Son','Subject','Subject at Household']) => 0.3081697481,
      (phone_subject_title = '') => 0.1249850029, 0.1249850029),
   (eda_avg_days_interrupt = NULL) => -0.0050634907, -0.0050634907), -0.0021419342);

// Tree: 343 
final_score_343 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 157.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 3.5) => 0.0439602069,
   (f_inq_count_i > 3.5) => -0.0034535577,
   (f_inq_count_i = NULL) => 0.0076467540, 0.0076467540),
(f_curraddrcartheftindex_i > 157.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 49.5) => 0.0033354476,
   (f_mos_inq_banko_cm_lseen_d > 49.5) => -0.0644154303,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0269965354, -0.0269965354),
(f_curraddrcartheftindex_i = NULL) => -0.0010779522, -0.0010779522);

// Tree: 344 
final_score_344 := map(
(exp_source in ['P']) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 156.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 3.5) => -0.1010175258,
      (r_pb_order_freq_d > 3.5) => 0.0087815698,
      (r_pb_order_freq_d = NULL) => -0.1654616169, -0.0693713371),
   (f_prevaddrmurderindex_i > 156.5) => 0.0746612932,
   (f_prevaddrmurderindex_i = NULL) => -0.0326866171, -0.0326866171),
(exp_source in ['S']) => 0.0217523029,
(exp_source = '') => 0.0019313946, 0.0038167301);

// Tree: 345 
final_score_345 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 21.5) => 
   map(
   (NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 65.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 8.5) => -0.1590718653,
      (f_rel_educationover12_count_d > 8.5) => -0.0034028451,
      (f_rel_educationover12_count_d = NULL) => -0.0725198901, -0.0725198901),
   (f_mos_inq_banko_am_fseen_d > 65.5) => 0.0033648385,
   (f_mos_inq_banko_am_fseen_d = NULL) => 0.0011234418, 0.0011234418),
(f_rel_ageover40_count_d > 21.5) => -0.2001754940,
(f_rel_ageover40_count_d = NULL) => -0.0001057204, -0.0001057204);

// Tree: 346 
final_score_346 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -38609) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 10.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Brother','Child','Grandfather','Husband','Neighbor','Parent','Sister','Son','Spouse','Subject at Household','Wife']) => 0.0095253699,
      (phone_subject_title in ['Associate','Associate By Business','Associate By SSN','Associate By Vehicle','Daughter','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Mother','Relative','Sibling','Subject']) => 0.1910075544,
      (phone_subject_title = '') => 0.1145208099, 0.1145208099),
   (f_rel_under25miles_cnt_d > 10.5) => -0.0867373156,
   (f_rel_under25miles_cnt_d = NULL) => 0.0583686810, 0.0583686810),
(f_addrchangeincomediff_d > -38609) => -0.0055715685,
(f_addrchangeincomediff_d = NULL) => 0.0074868787, 0.0003581948);

// Tree: 347 
final_score_347 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 24.5) => 0.0024645384,
(mth_exp_last_update > 24.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 2.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 7.5) => -0.0312536513,
      (f_assocsuspicousidcount_i > 7.5) => 0.1466924416,
      (f_assocsuspicousidcount_i = NULL) => 0.0037000455, 0.0037000455),
   (f_srchssnsrchcount_i > 2.5) => -0.1293984163,
   (f_srchssnsrchcount_i = NULL) => -0.0485577020, -0.0485577020),
(mth_exp_last_update = NULL) => -0.0002893842, -0.0002893842);

// Tree: 348 
final_score_348 := map(
(NULL < source_sp and source_sp <= 0.5) => -0.0040543545,
(source_sp > 0.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 10.5) => 
      map(
      (NULL < eda_days_in_service and eda_days_in_service <= 388) => 0.2203233777,
      (eda_days_in_service > 388) => 0.0616426173,
      (eda_days_in_service = NULL) => 0.0990207519, 0.0990207519),
   (f_srchaddrsrchcount_i > 10.5) => -0.0886712063,
   (f_srchaddrsrchcount_i = NULL) => 0.0605538488, 0.0605538488),
(source_sp = NULL) => -0.0019136074, -0.0019136074);

// Tree: 349 
final_score_349 := map(
(NULL < source_rel and source_rel <= 0.5) => -0.0081497889,
(source_rel > 0.5) => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 4129.5) => 
      map(
      (NULL < eda_has_cur_discon_90_days and eda_has_cur_discon_90_days <= 0.5) => 0.0660325907,
      (eda_has_cur_discon_90_days > 0.5) => -0.0945661084,
      (eda_has_cur_discon_90_days = NULL) => -0.0003016545, -0.0003016545),
   (eda_days_ph_first_seen > 4129.5) => 0.1236288218,
   (eda_days_ph_first_seen = NULL) => 0.0495924333, 0.0495924333),
(source_rel = NULL) => -0.0060675264, -0.0060675264);

// Tree: 350 
final_score_350 := map(
(NULL < _pp_rule_ins_ver_above and _pp_rule_ins_ver_above <= 0.5) => -0.0039185182,
(_pp_rule_ins_ver_above > 0.5) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 86.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 96.5) => 0.2733828913,
      (f_prevaddrlenofres_d > 96.5) => 0.0282014480,
      (f_prevaddrlenofres_d = NULL) => 0.1638993537, 0.1638993537),
   (mth_pp_app_npa_last_change_dt > 86.5) => -0.0001247230,
   (mth_pp_app_npa_last_change_dt = NULL) => 0.0818873154, 0.0818873154),
(_pp_rule_ins_ver_above = NULL) => -0.0007237805, -0.0007237805);

// Tree: 351 
final_score_351 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 11.5) => 0.0039755604,
(mth_source_ppdid_lseen > 11.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 5.5) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 142.5) => -0.0259513140,
      (f_prevaddrcartheftindex_i > 142.5) => 0.1073236009,
      (f_prevaddrcartheftindex_i = NULL) => 0.0263334603, 0.0263334603),
   (f_inq_count_i > 5.5) => -0.0602450862,
   (f_inq_count_i = NULL) => -0.0364664713, -0.0364664713),
(mth_source_ppdid_lseen = NULL) => -0.0027482055, -0.0027482055);

// Tree: 352 
final_score_352 := map(
(NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 83.5) => 
   map(
   (NULL < mth_source_exp_fseen and mth_source_exp_fseen <= 3.5) => -0.0015202873,
   (mth_source_exp_fseen > 3.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0047419949,
      (f_rel_felony_count_i > 0.5) => -0.0980355303,
      (f_rel_felony_count_i = NULL) => -0.0391397912, -0.0391397912),
   (mth_source_exp_fseen = NULL) => -0.0040061970, -0.0040061970),
(mth_pp_orig_lastseen > 83.5) => -0.1631452501,
(mth_pp_orig_lastseen = NULL) => -0.0063725077, -0.0063725077);

// Tree: 353 
final_score_353 := map(
(NULL < f_divssnidmsrcurelcount_i and f_divssnidmsrcurelcount_i <= 2.5) => 
   map(
   (pp_type in ['R','U']) => -0.0491064256,
   (pp_type in ['B','M']) => 0.0076718621,
   (pp_type = '') => 0.0121593347, 0.0077228445),
(f_divssnidmsrcurelcount_i > 2.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.388119687431385) => -0.0064324508,
   (f_add_input_mobility_index_n > 0.388119687431385) => -0.2327171941,
   (f_add_input_mobility_index_n = NULL) => -0.1026034667, -0.1026034667),
(f_divssnidmsrcurelcount_i = NULL) => 0.0061336495, 0.0061336495);

// Tree: 354 
final_score_354 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 1.5) => 
   map(
   (exp_source in ['P']) => -0.0234466991,
   (exp_source in ['S']) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 16.5) => -0.0937516993,
      (f_prevaddrageoldest_d > 16.5) => 0.0784345037,
      (f_prevaddrageoldest_d = NULL) => 0.0552811812, 0.0552811812),
   (exp_source = '') => 0.0140467777, 0.0195217118),
(f_rel_criminal_count_i > 1.5) => -0.0186477578,
(f_rel_criminal_count_i = NULL) => -0.0041531922, -0.0041531922);

// Tree: 355 
final_score_355 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 27175.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -33644.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 47.5) => 0.1266031046,
      (f_mos_inq_banko_cm_lseen_d > 47.5) => -0.1398964002,
      (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0032986640, -0.0032986640),
   (f_addrchangevaluediff_d > -33644.5) => 0.1048799712,
   (f_addrchangevaluediff_d = NULL) => -0.0081498847, 0.0473775573),
(f_curraddrmedianincome_d > 27175.5) => -0.0082127730,
(f_curraddrmedianincome_d = NULL) => -0.0022827038, -0.0022827038);

// Tree: 356 
final_score_356 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 20.5) => 0.0054789491,
(mth_exp_last_update > 20.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 39.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Property','Associate By SSN','Father','Husband','Mother','Neighbor','Parent','Relative','Subject','Subject at Household','Wife']) => -0.0905297095,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Sibling','Sister','Son','Spouse']) => 0.1138538507,
      (phone_subject_title = '') => -0.0651017079, -0.0651017079),
   (mth_source_ppdid_fseen > 39.5) => 0.0710731733,
   (mth_source_ppdid_fseen = NULL) => -0.0365529851, -0.0365529851),
(mth_exp_last_update = NULL) => 0.0028264245, 0.0028264245);

// Tree: 357 
final_score_357 := map(
(exp_type in ['N']) => 
   map(
   (NULL < eda_address_match_best and eda_address_match_best <= 0.5) => -0.0037975010,
   (eda_address_match_best > 0.5) => 0.1691766679,
   (eda_address_match_best = NULL) => 0.0494092699, 0.0494092699),
(exp_type in ['C']) => 
   map(
   (NULL < mth_source_exp_lseen and mth_source_exp_lseen <= 19.5) => 0.0990998601,
   (mth_source_exp_lseen > 19.5) => -0.1550388940,
   (mth_source_exp_lseen = NULL) => 0.0786285961, 0.0786285961),
(exp_type = '') => -0.0313306279, -0.0057531562);

// Tree: 358 
final_score_358 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 33.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.26595206123753) => 
      map(
      (NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 50) => 0.0140424843,
      (f_acc_damage_amt_total_i > 50) => 0.2272212303,
      (f_acc_damage_amt_total_i = NULL) => 0.0193322795, 0.0193322795),
   (f_add_input_mobility_index_n > 0.26595206123753) => -0.0074901158,
   (f_add_input_mobility_index_n = NULL) => -0.0974628364, -0.0018525777),
(f_rel_under25miles_cnt_d > 33.5) => 0.1282491138,
(f_rel_under25miles_cnt_d = NULL) => -0.0002777188, -0.0002777188);

// Tree: 359 
final_score_359 := map(
(NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 90.5) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 4.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 99053.5) => -0.0363596612,
      (f_curraddrmedianincome_d > 99053.5) => 0.0925233928,
      (f_curraddrmedianincome_d = NULL) => -0.0263176259, -0.0263176259),
   (f_rel_under100miles_cnt_d > 4.5) => 0.0029979847,
   (f_rel_under100miles_cnt_d = NULL) => -0.0042640943, -0.0042640943),
(mth_source_ppla_fseen > 90.5) => -0.1254373544,
(mth_source_ppla_fseen = NULL) => -0.0052146397, -0.0052146397);

// Tree: 360 
final_score_360 := map(
(NULL < f_wealth_index_d and f_wealth_index_d <= 5.5) => 
   map(
   (NULL < _phone_timezone_match and _phone_timezone_match <= 0.5) => -0.0708389505,
   (_phone_timezone_match > 0.5) => -0.0007666168,
   (_phone_timezone_match = NULL) => -0.0063198032, -0.0063198032),
(f_wealth_index_d > 5.5) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 100.5) => 0.2146252352,
   (f_fp_prevaddrcrimeindex_i > 100.5) => 0.0003035681,
   (f_fp_prevaddrcrimeindex_i = NULL) => 0.1215483969, 0.1215483969),
(f_wealth_index_d = NULL) => -0.0036998599, -0.0036998599);

// Tree: 361 
final_score_361 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 32.5) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 1.5) => -0.0039389371,
   (inq_adl_firstseen_n > 1.5) => 
      map(
      (pp_source in ['HEADER','INQUIRY','PCNSR','THRIVE']) => 0.0272486481,
      (pp_source in ['CELL','GONG','IBEHAVIOR','INFUTOR','INTRADO','OTHER','TARGUS']) => 0.1710823320,
      (pp_source = '') => 0.0574113478, 0.0599407711),
   (inq_adl_firstseen_n = NULL) => 0.0027336224, 0.0027336224),
(f_inq_count_i > 32.5) => -0.0727363382,
(f_inq_count_i = NULL) => -0.0025074699, -0.0025074699);

// Tree: 362 
final_score_362 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 24) => 
   map(
   (NULL < f_college_income_d and f_college_income_d <= 5.5) => -0.0098566100,
   (f_college_income_d > 5.5) => -0.1664591517,
   (f_college_income_d = NULL) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.42675438071885) => -0.0572792753,
      (f_add_input_mobility_index_n > 0.42675438071885) => 0.0466474980,
      (f_add_input_mobility_index_n = NULL) => -0.0228332909, -0.0228332909), -0.0375449393),
(f_curraddrcrimeindex_i > 24) => 0.0031281496,
(f_curraddrcrimeindex_i = NULL) => -0.0012101228, -0.0012101228);

// Tree: 363 
final_score_363 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 157.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 152.5) => 0.0001105539,
   (f_curraddrcartheftindex_i > 152.5) => 
      map(
      (NULL < number_of_sources and number_of_sources <= 1.5) => 0.0224412308,
      (number_of_sources > 1.5) => 0.1997143942,
      (number_of_sources = NULL) => 0.0775396464, 0.0775396464),
   (f_curraddrcartheftindex_i = NULL) => 0.0027710180, 0.0027710180),
(f_curraddrcartheftindex_i > 157.5) => -0.0306201091,
(f_curraddrcartheftindex_i = NULL) => -0.0053578056, -0.0053578056);

// Tree: 364 
final_score_364 := map(
(NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 6.5) => 0.0057765447,
(mth_source_rel_fseen > 6.5) => 
   map(
   (NULL < eda_days_in_service and eda_days_in_service <= 282) => -0.1720906602,
   (eda_days_in_service > 282) => 
      map(
      (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 3198.5) => -0.0957308712,
      (eda_days_ph_first_seen > 3198.5) => 0.0536555159,
      (eda_days_ph_first_seen = NULL) => -0.0072941300, -0.0072941300),
   (eda_days_in_service = NULL) => -0.0625184992, -0.0625184992),
(mth_source_rel_fseen = NULL) => 0.0042732701, 0.0042732701);

// Tree: 365 
final_score_365 := map(
(NULL < mth_source_exp_lseen and mth_source_exp_lseen <= 42.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 14.5) => -0.1508402588,
   (f_mos_inq_banko_cm_fseen_d > 14.5) => 
      map(
      (NULL < pk_phone_match_level and pk_phone_match_level <= 0.5) => -0.0412622636,
      (pk_phone_match_level > 0.5) => 0.0055139986,
      (pk_phone_match_level = NULL) => 0.0017360657, 0.0017360657),
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0004226138, 0.0004226138),
(mth_source_exp_lseen > 42.5) => -0.1695190648,
(mth_source_exp_lseen = NULL) => -0.0007712160, -0.0007712160);

// Tree: 366 
final_score_366 := map(
(eda_pfrd_address_ind in ['1A','1B','XX']) => -0.0051457804,
(eda_pfrd_address_ind in ['1C','1D','1E']) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 5.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 83352.5) => -0.0661491866,
      (f_prevaddrmedianvalue_d > 83352.5) => 0.1850668409,
      (f_prevaddrmedianvalue_d = NULL) => 0.1124610526, 0.1124610526),
   (f_inq_count_i > 5.5) => 0.0011476756,
   (f_inq_count_i = NULL) => 0.0491706537, 0.0491706537),
(eda_pfrd_address_ind = '') => -0.0025956235, -0.0025956235);

// Tree: 367 
final_score_367 := map(
(pp_source in ['CELL','GONG','IBEHAVIOR','INQUIRY','INTRADO','OTHER','PCNSR','THRIVE']) => -0.0190124305,
(pp_source in ['HEADER','INFUTOR','TARGUS']) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 11.5) => 0.0122752318,
   (f_rel_homeover300_count_d > 11.5) => 
      map(
      (NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 5.5) => 0.3055710461,
      (mth_pp_first_build_date > 5.5) => 0.0307259648,
      (mth_pp_first_build_date = NULL) => 0.1579690580, 0.1579690580),
   (f_rel_homeover300_count_d = NULL) => 0.0212820625, 0.0212820625),
(pp_source = '') => -0.0020399840, -0.0008701422);

// Tree: 368 
final_score_368 := map(
(exp_source in ['P']) => -0.0313523980,
(exp_source in ['S']) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 17.5) => 0.0508183251,
   (mth_exp_last_update > 17.5) => 
      map(
      (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 80.5) => -0.0424947779,
      (mth_pp_datefirstseen > 80.5) => 0.1277744413,
      (mth_pp_datefirstseen = NULL) => -0.0211765179, -0.0211765179),
   (mth_exp_last_update = NULL) => 0.0240972457, 0.0240972457),
(exp_source = '') => -0.0108523083, -0.0051615964);

// Tree: 369 
final_score_369 := map(
(NULL < f_util_add_input_inf_n and f_util_add_input_inf_n <= 0.5) => -0.0043088734,
(f_util_add_input_inf_n > 0.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 73.5) => -0.0118073259,
   (f_prevaddrlenofres_d > 73.5) => 
      map(
      (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 14.5) => 0.0539767868,
      (mth_pp_datefirstseen > 14.5) => 0.2425042116,
      (mth_pp_datefirstseen = NULL) => 0.1129474505, 0.1129474505),
   (f_prevaddrlenofres_d = NULL) => 0.0488453419, 0.0488453419),
(f_util_add_input_inf_n = NULL) => -0.0016079099, -0.0016079099);

// Tree: 370 
final_score_370 := map(
(NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => 
   map(
   (NULL < f_inq_lnames_per_addr_i and f_inq_lnames_per_addr_i <= 10.5) => -0.0148680232,
   (f_inq_lnames_per_addr_i > 10.5) => 0.2088689697,
   (f_inq_lnames_per_addr_i = NULL) => -0.0122793308, -0.0122793308),
(_phone_match_code_n > 0.5) => 
   map(
   (phone_subject_title in ['Associate','Daughter','Grandmother','Mother','Subject','Subject at Household','Wife']) => 0.0108787044,
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse']) => 0.1215174437,
   (phone_subject_title = '') => 0.0135094012, 0.0135094012),
(_phone_match_code_n = NULL) => -0.0011045155, -0.0011045155);

// Tree: 371 
final_score_371 := map(
(NULL < number_of_sources and number_of_sources <= 1.5) => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => -0.0513092435,
   (source_rel > 0.5) => 0.1212649435,
   (source_rel = NULL) => -0.0429646351, -0.0429646351),
(number_of_sources > 1.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 71.5) => 0.0310792343,
   (f_mos_inq_banko_cm_lseen_d > 71.5) => 0.1395330501,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0773669765, 0.0773669765),
(number_of_sources = NULL) => -0.0112086987, -0.0112086987);

// Tree: 372 
final_score_372 := map(
(NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 2.5) => 
   map(
   (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 167.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 22300.5) => 0.1628580927,
      (f_prevaddrmedianincome_d > 22300.5) => -0.0328753332,
      (f_prevaddrmedianincome_d = NULL) => -0.0048646160, -0.0048646160),
   (mth_pp_app_npa_effective_dt > 167.5) => -0.1438193383,
   (mth_pp_app_npa_effective_dt = NULL) => -0.0290915921, -0.0290915921),
(f_rel_educationover12_count_d > 2.5) => 0.0043761193,
(f_rel_educationover12_count_d = NULL) => 0.0016471108, 0.0016471108);

// Tree: 373 
final_score_373 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.34259324358063) => -0.0183868523,
(f_add_input_mobility_index_n > 0.34259324358063) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 148.5) => -0.0048318770,
   (f_prevaddrmurderindex_i > 148.5) => 
      map(
      (NULL < eda_min_days_interrupt and eda_min_days_interrupt <= 15) => 0.0338216729,
      (eda_min_days_interrupt > 15) => 0.2526752058,
      (eda_min_days_interrupt = NULL) => 0.0426941134, 0.0426941134),
   (f_prevaddrmurderindex_i = NULL) => 0.0108586667, 0.0108586667),
(f_add_input_mobility_index_n = NULL) => 0.0016451175, -0.0020984333);

// Tree: 374 
final_score_374 := map(
(NULL < _pp_rule_low_vend_conf and _pp_rule_low_vend_conf <= 0.5) => -0.0045176477,
(_pp_rule_low_vend_conf > 0.5) => 
   map(
   (NULL < pp_app_best_addr_match_fl and pp_app_best_addr_match_fl <= 0.5) => -0.0432089502,
   (pp_app_best_addr_match_fl > 0.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 39.5) => -0.0022484184,
      (f_mos_inq_banko_cm_lseen_d > 39.5) => 0.1835093326,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.1128690611, 0.1128690611),
   (pp_app_best_addr_match_fl = NULL) => 0.0603568330, 0.0603568330),
(_pp_rule_low_vend_conf = NULL) => -0.0028921777, -0.0028921777);

// Tree: 375 
final_score_375 := map(
(pp_source in ['CELL','GONG','INTRADO','OTHER','PCNSR','THRIVE']) => -0.1265404673,
(pp_source in ['HEADER','IBEHAVIOR','INFUTOR','INQUIRY','TARGUS']) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
      map(
      (exp_type in ['N']) => 0.0921070525,
      (exp_type in ['C']) => 0.1159998379,
      (exp_type = '') => 0.0392881624, 0.0590071511),
   (f_srchvelocityrisktype_i > 5.5) => -0.0286650609,
   (f_srchvelocityrisktype_i = NULL) => 0.0209607195, 0.0209607195),
(pp_source = '') => -0.0123963615, -0.0020087746);

// Tree: 376 
final_score_376 := map(
(NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 133) => 0.0130742513,
(f_fp_prevaddrburglaryindex_i > 133) => 
   map(
   (pp_src in ['CY','E1','EM','EQ','FA','TN','UT','ZK','ZT']) => -0.0482050532,
   (pp_src in ['E2','EB','EN','FF','KW','LA','LP','MD','NW','PL','SL','UW','VO','VW']) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 176) => 0.0135400965,
      (f_curraddrburglaryindex_i > 176) => 0.2141279635,
      (f_curraddrburglaryindex_i = NULL) => 0.0669717990, 0.0669717990),
   (pp_src = '') => -0.0191706945, -0.0172189960),
(f_fp_prevaddrburglaryindex_i = NULL) => 0.0013910811, 0.0013910811);

// Tree: 377 
final_score_377 := map(
(NULL < pk_cell_indicator and pk_cell_indicator <= 3.5) => -0.0081266414,
(pk_cell_indicator > 3.5) => 
   map(
   (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 0.5) => 0.0765204088,
   (f_assoccredbureaucount_i > 0.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -24912) => 0.1054735974,
      (f_addrchangeincomediff_d > -24912) => -0.0064671518,
      (f_addrchangeincomediff_d = NULL) => -0.0354613233, -0.0023898281),
   (f_assoccredbureaucount_i = NULL) => 0.0257169954, 0.0257169954),
(pk_cell_indicator = NULL) => -0.0033875020, -0.0033875020);

// Tree: 378 
final_score_378 := map(
(NULL < inq_num and inq_num <= 0.5) => -0.0089485022,
(inq_num > 0.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 5.5) => 0.1339338925,
   (f_srchfraudsrchcount_i > 5.5) => 
      map(
      (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 9.5) => 0.1593860723,
      (inq_adl_lastseen_n > 9.5) => -0.0532668315,
      (inq_adl_lastseen_n = NULL) => -0.0003260458, -0.0003260458),
   (f_srchfraudsrchcount_i = NULL) => 0.0697576420, 0.0697576420),
(inq_num = NULL) => 0.0002665949, 0.0002665949);

// Tree: 379 
final_score_379 := map(
(NULL < pp_did_score and pp_did_score <= 77) => 
   map(
   (phone_switch_type in ['8','G','I','P']) => -0.0122429853,
   (phone_switch_type in ['C','U']) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 49.5) => 0.0728877276,
      (mth_pp_app_npa_effective_dt > 49.5) => 0.0106104231,
      (mth_pp_app_npa_effective_dt = NULL) => 0.0197345256, 0.0197345256),
   (phone_switch_type = '') => 0.0003904774, 0.0003904774),
(pp_did_score > 77) => -0.0358456912,
(pp_did_score = NULL) => -0.0043273096, -0.0043273096);

// Tree: 380 
final_score_380 := map(
(NULL < pp_app_company_type and pp_app_company_type <= 7.5) => -0.0046030041,
(pp_app_company_type > 7.5) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 59843) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 129) => 0.0582100362,
      (f_fp_prevaddrburglaryindex_i > 129) => -0.0649239945,
      (f_fp_prevaddrburglaryindex_i = NULL) => -0.0062887418, -0.0062887418),
   (f_prevaddrmedianincome_d > 59843) => 0.1204836117,
   (f_prevaddrmedianincome_d = NULL) => 0.0370522338, 0.0370522338),
(pp_app_company_type = NULL) => -0.0011792859, -0.0011792859);

// Tree: 381 
final_score_381 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 22.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By SSN','Brother','Child','Daughter','Granddaughter','Grandparent','Grandson','Husband','Neighbor','Parent','Sister','Subject at Household']) => -0.0147627388,
   (phone_subject_title in ['Associate','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Father','Grandchild','Grandfather','Grandmother','Mother','Relative','Sibling','Son','Spouse','Subject','Wife']) => 0.0171917692,
   (phone_subject_title = '') => 0.0047372849, 0.0047372849),
(mth_source_ppdid_lseen > 22.5) => 
   map(
   (NULL < pp_app_company_type and pp_app_company_type <= 2) => 0.1157561316,
   (pp_app_company_type > 2) => -0.0637903355,
   (pp_app_company_type = NULL) => -0.0429128393, -0.0429128393),
(mth_source_ppdid_lseen = NULL) => 0.0006590457, 0.0006590457);

// Tree: 382 
final_score_382 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 2.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 105082) => 
      map(
      (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 16.5) => -0.0724622426,
      (mth_source_inf_fseen > 16.5) => 0.0700522837,
      (mth_source_inf_fseen = NULL) => -0.0614146049, -0.0614146049),
   (f_curraddrmedianincome_d > 105082) => 0.1477153147,
   (f_curraddrmedianincome_d = NULL) => -0.0481812801, -0.0481812801),
(f_rel_under100miles_cnt_d > 2.5) => -0.0043533780,
(f_rel_under100miles_cnt_d = NULL) => -0.0093204715, -0.0093204715);

// Tree: 383 
final_score_383 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 50.5) => 
   map(
   (NULL < _internal_ver_match_hhid and _internal_ver_match_hhid <= 0.5) => -0.0058634904,
   (_internal_ver_match_hhid > 0.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 23.5) => -0.0971174414,
      (f_mos_inq_banko_cm_lseen_d > 23.5) => 0.0523549660,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0308073504, 0.0308073504),
   (_internal_ver_match_hhid = NULL) => -0.0030079919, -0.0030079919),
(f_rel_incomeover25_count_d > 50.5) => 0.1553924611,
(f_rel_incomeover25_count_d = NULL) => -0.0020221741, -0.0020221741);

// Tree: 384 
final_score_384 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 12.5) => -0.0089071988,
(inq_adl_lastseen_n > 12.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 7.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 68.5) => -0.0166424523,
      (f_prevaddrageoldest_d > 68.5) => 0.1339716912,
      (f_prevaddrageoldest_d = NULL) => 0.0869047714, 0.0869047714),
   (f_inq_count_i > 7.5) => 0.0027705810,
   (f_inq_count_i = NULL) => 0.0239419631, 0.0239419631),
(inq_adl_lastseen_n = NULL) => -0.0059726583, -0.0059726583);

// Tree: 385 
final_score_385 := map(
(NULL < pk_cell_indicator and pk_cell_indicator <= 3.5) => 
   map(
   (NULL < eda_address_match_best and eda_address_match_best <= 0.5) => -0.0218411495,
   (eda_address_match_best > 0.5) => 
      map(
      (phone_subject_title in ['Father','Neighbor','Parent','Son']) => -0.1493168012,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Relative','Sibling','Sister','Spouse','Subject','Subject at Household','Wife']) => 0.1404100696,
      (phone_subject_title = '') => 0.0602067084, 0.0602067084),
   (eda_address_match_best = NULL) => -0.0166250101, -0.0166250101),
(pk_cell_indicator > 3.5) => 0.0588251550,
(pk_cell_indicator = NULL) => -0.0059271820, -0.0059271820);

// Tree: 386 
final_score_386 := map(
(NULL < eda_days_in_service and eda_days_in_service <= 1882.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -64142.5) => 0.1381159238,
   (f_addrchangeincomediff_d > -64142.5) => 0.0055255682,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Father','Grandfather','Husband','Neighbor','Relative','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => 0.0000487828,
      (phone_subject_title in ['Associate By Property','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Mother','Parent','Spouse']) => 0.2144884147,
      (phone_subject_title = '') => 0.0066741062, 0.0066741062), 0.0072631025),
(eda_days_in_service > 1882.5) => -0.0620833445,
(eda_days_in_service = NULL) => 0.0010031668, 0.0010031668);

// Tree: 387 
final_score_387 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 8.5) => 
   map(
   (NULL < mth_source_ppfla_lseen and mth_source_ppfla_lseen <= 5.5) => 0.0095682936,
   (mth_source_ppfla_lseen > 5.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 37.5) => -0.1047824961,
      (f_mos_inq_banko_om_fseen_d > 37.5) => 0.1403955439,
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0882952104, 0.0882952104),
   (mth_source_ppfla_lseen = NULL) => 0.0137568239, 0.0137568239),
(f_inq_count_i > 8.5) => -0.0274330541,
(f_inq_count_i = NULL) => -0.0056782784, -0.0056782784);

// Tree: 388 
final_score_388 := map(
(pp_src in ['CY','E1','E2','EM','EN','EQ','NW','SL','UT','VO','ZK','ZT']) => -0.0197035630,
(pp_src in ['EB','FA','FF','KW','LA','LP','MD','PL','TN','UW','VW']) => 
   map(
   (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 54.5) => -0.1260054870,
      (f_prevaddrageoldest_d > 54.5) => 0.0603832918,
      (f_prevaddrageoldest_d = NULL) => -0.0101657320, -0.0101657320),
   (f_prevaddrstatus_i > 2.5) => 0.0125649451,
   (f_prevaddrstatus_i = NULL) => 0.1260528848, 0.0268974728),
(pp_src = '') => 0.0016530337, -0.0006867363);

// Tree: 389 
final_score_389 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 51.5) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 24.5) => 0.0015692326,
   (f_rel_educationover12_count_d > 24.5) => 
      map(
      (pp_app_scc in ['8','J','N','S']) => -0.1866714237,
      (pp_app_scc in ['A','B','C','R']) => 0.0060145090,
      (pp_app_scc = '') => -0.0901671515, -0.0684745249),
   (f_rel_educationover12_count_d = NULL) => -0.0021303491, -0.0021303491),
(f_rel_under500miles_cnt_d > 51.5) => 0.1533988669,
(f_rel_under500miles_cnt_d = NULL) => -0.0011987082, -0.0011987082);

// Tree: 390 
final_score_390 := map(
(NULL < _pp_origlistingtype_res and _pp_origlistingtype_res <= 0.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 192.5) => 0.0014688557,
   (f_curraddrcartheftindex_i > 192.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 41.5) => 0.1938516458,
      (f_mos_inq_banko_cm_lseen_d > 41.5) => -0.0014387787,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0898744915, 0.0898744915),
   (f_curraddrcartheftindex_i = NULL) => 0.0057256924, 0.0057256924),
(_pp_origlistingtype_res > 0.5) => -0.0245403221,
(_pp_origlistingtype_res = NULL) => -0.0029703385, -0.0029703385);

// Tree: 391 
final_score_391 := map(
(NULL < eda_num_ph_owners_hist and eda_num_ph_owners_hist <= 6.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 53.5) => 
      map(
      (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 1.5) => 0.0006009016,
      (inq_adl_firstseen_n > 1.5) => 0.0298193590,
      (inq_adl_firstseen_n = NULL) => 0.0036363592, 0.0036363592),
   (inq_adl_lastseen_n > 53.5) => -0.0975258776,
   (inq_adl_lastseen_n = NULL) => 0.0024204096, 0.0024204096),
(eda_num_ph_owners_hist > 6.5) => -0.1831010722,
(eda_num_ph_owners_hist = NULL) => 0.0012257390, 0.0012257390);

// Tree: 392 
final_score_392 := map(
(pp_rp_source in ['GONG','IBEHAVIOR','INFUTOR','INQUIRY','OTHER','PCNSR','TARGUS']) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 76) => -0.0847573792,
   (f_curraddrcrimeindex_i > 76) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 133) => 0.0839837014,
      (f_curraddrmurderindex_i > 133) => -0.0458517951,
      (f_curraddrmurderindex_i = NULL) => 0.0231970826, 0.0231970826),
   (f_curraddrcrimeindex_i = NULL) => -0.0132212900, -0.0132212900),
(pp_rp_source in ['CELL','HEADER','INTRADO','THRIVE']) => 0.0930951826,
(pp_rp_source = '') => 0.0010720106, 0.0012490625);

// Tree: 393 
final_score_393 := map(
(NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 112) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 10663) => 0.0304932342,
   (f_addrchangevaluediff_d > 10663) => -0.0170547054,
   (f_addrchangevaluediff_d = NULL) => 0.0100756558, 0.0121114778),
(f_fp_prevaddrburglaryindex_i > 112) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 0.0087850571,
   (f_util_adl_count_n > 3.5) => -0.0430700491,
   (f_util_adl_count_n = NULL) => -0.0104994900, -0.0104994900),
(f_fp_prevaddrburglaryindex_i = NULL) => 0.0010336922, 0.0010336922);

// Tree: 394 
final_score_394 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 160.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 129.5) => -0.0010889676,
   (f_prevaddrcartheftindex_i > 129.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 62.5) => 0.0385596789,
      (f_addrchangecrimediff_i > 62.5) => 0.2111524384,
      (f_addrchangecrimediff_i = NULL) => 0.0064967350, 0.0396162439),
   (f_prevaddrcartheftindex_i = NULL) => 0.0077705907, 0.0077705907),
(f_prevaddrcartheftindex_i > 160.5) => -0.0202915463,
(f_prevaddrcartheftindex_i = NULL) => 0.0005554575, 0.0005554575);

// Tree: 395 
final_score_395 := map(
(NULL < _phone_timezone_match and _phone_timezone_match <= 0.5) => -0.0611953501,
(_phone_timezone_match > 0.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Father','Granddaughter','Grandmother','Grandson','Husband','Mother','Neighbor','Sibling','Sister','Son','Subject','Subject at Household']) => -0.0037995961,
   (phone_subject_title in ['Associate By Property','Associate By Vehicle','Daughter','Grandchild','Grandfather','Grandparent','Parent','Relative','Spouse','Wife']) => 
      map(
      (NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 10.5) => 0.2860109712,
      (mth_eda_dt_first_seen > 10.5) => 0.0463874914,
      (mth_eda_dt_first_seen = NULL) => 0.0911714913, 0.0911714913),
   (phone_subject_title = '') => 0.0011741026, 0.0011741026),
(_phone_timezone_match = NULL) => -0.0037476877, -0.0037476877);

// Tree: 396 
final_score_396 := map(
(NULL < eda_address_match_best and eda_address_match_best <= 0.5) => 
   map(
   (NULL < mth_source_exp_fseen and mth_source_exp_fseen <= 20.5) => -0.0021622459,
   (mth_source_exp_fseen > 20.5) => -0.1349066981,
   (mth_source_exp_fseen = NULL) => -0.0043440319, -0.0043440319),
(eda_address_match_best > 0.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By SSN','Brother','Father','Grandmother','Husband','Mother','Neighbor','Subject','Wife']) => 0.0503392831,
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Parent','Relative','Sibling','Sister','Son','Spouse','Subject at Household']) => 0.2692952988,
   (phone_subject_title = '') => 0.0878885330, 0.0878885330),
(eda_address_match_best = NULL) => 0.0005046300, 0.0005046300);

// Tree: 397 
final_score_397 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.18842111046774) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 50.5) => -0.0216315491,
   (f_curraddrcrimeindex_i > 50.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Grandmother','Mother','Neighbor','Sister','Son','Subject']) => 0.0605275864,
      (phone_subject_title in ['Associate By SSN','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Parent','Relative','Sibling','Spouse','Subject at Household','Wife']) => 0.2104402854,
      (phone_subject_title = '') => 0.0816208305, 0.0816208305),
   (f_curraddrcrimeindex_i = NULL) => 0.0429823614, 0.0429823614),
(f_add_curr_mobility_index_n > 0.18842111046774) => 0.0003024883,
(f_add_curr_mobility_index_n = NULL) => 0.0724040156, 0.0041221950);

// Tree: 398 
final_score_398 := map(
(NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 1.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Brother','Daughter','Father','Grandmother','Husband','Neighbor','Parent','Sister','Wife']) => -0.1337189962,
   (phone_subject_title in ['Associate','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Mother','Relative','Sibling','Son','Spouse','Subject','Subject at Household']) => 
      map(
      (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 17.5) => 0.1513603557,
      (mth_source_ppdid_fseen > 17.5) => -0.0587736086,
      (mth_source_ppdid_fseen = NULL) => 0.0983168308, 0.0983168308),
   (phone_subject_title = '') => 0.0394671645, 0.0394671645),
(f_sourcerisktype_i > 1.5) => -0.0026796566,
(f_sourcerisktype_i = NULL) => -0.0013175345, -0.0013175345);

// Tree: 399 
final_score_399 := map(
(pp_type in ['M','U']) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -203672) => 0.1000027320,
   (f_addrchangevaluediff_d > -203672) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 178.5) => 0.0052949757,
      (f_fp_prevaddrburglaryindex_i > 178.5) => -0.0656088129,
      (f_fp_prevaddrburglaryindex_i = NULL) => -0.0049554921, -0.0049554921),
   (f_addrchangevaluediff_d = NULL) => 0.0088633903, 0.0024453953),
(pp_type in ['B','R']) => 0.1328655244,
(pp_type = '') => -0.0004460197, 0.0018059755);

// Tree: 400 
final_score_400 := map(
(pp_origphoneusage in ['M','O']) => -0.1209080947,
(pp_origphoneusage in ['H','P','S']) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 248.5) => -0.0036031451,
   (r_pb_order_freq_d > 248.5) => 0.1266935577,
   (r_pb_order_freq_d = NULL) => -0.0431631784, -0.0018490309),
(pp_origphoneusage = '') => 
   map(
   (NULL < _internal_ver_match_level and _internal_ver_match_level <= 2.5) => -0.0018618522,
   (_internal_ver_match_level > 2.5) => 0.0838979957,
   (_internal_ver_match_level = NULL) => -0.0002963493, -0.0002963493), -0.0018647166);

// Tree: 401 
final_score_401 := map(
(NULL < _pp_rule_iq_rpc and _pp_rule_iq_rpc <= 0.5) => 0.0025212571,
(_pp_rule_iq_rpc > 0.5) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 97.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.388894121839145) => -0.1921369896,
      (f_add_curr_mobility_index_n > 0.388894121839145) => -0.0209576542,
      (f_add_curr_mobility_index_n = NULL) => -0.1176628632, -0.1176628632),
   (f_fp_prevaddrcrimeindex_i > 97.5) => -0.0029713558,
   (f_fp_prevaddrcrimeindex_i = NULL) => -0.0519901918, -0.0519901918),
(_pp_rule_iq_rpc = NULL) => 0.0001917080, 0.0001917080);

// Tree: 402 
final_score_402 := map(
(exp_type in ['C']) => 
   map(
   (NULL < _eda_hhid_flag and _eda_hhid_flag <= 0.5) => 
      map(
      (NULL < pp_min_source_conf and pp_min_source_conf <= 7) => 0.0543027247,
      (pp_min_source_conf > 7) => -0.0196257506,
      (pp_min_source_conf = NULL) => 0.0033511952, 0.0033511952),
   (_eda_hhid_flag > 0.5) => -0.1387739083,
   (_eda_hhid_flag = NULL) => -0.0061602541, -0.0061602541),
(exp_type in ['N']) => 0.0287640769,
(exp_type = '') => 0.0017055765, 0.0031663542);

// Tree: 403 
final_score_403 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0056175958,
(source_utildid > 0.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 12.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 2.5) => 0.0314564261,
      (f_srchvelocityrisktype_i > 2.5) => 0.2007688106,
      (f_srchvelocityrisktype_i = NULL) => 0.1148102154, 0.1148102154),
   (mth_source_utildid_fseen > 12.5) => 0.0091024877,
   (mth_source_utildid_fseen = NULL) => 0.0264316234, 0.0264316234),
(source_utildid = NULL) => -0.0026419453, -0.0026419453);

// Tree: 404 
final_score_404 := map(
(NULL < _pp_src_all_uw and _pp_src_all_uw <= 0.5) => -0.0022675614,
(_pp_src_all_uw > 0.5) => 
   map(
   (NULL < _pp_origlistingtype_res and _pp_origlistingtype_res <= 0.5) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 9.5) => 0.0671818089,
      (f_rel_incomeover50_count_d > 9.5) => 0.2404384865,
      (f_rel_incomeover50_count_d = NULL) => 0.1072875213, 0.1072875213),
   (_pp_origlistingtype_res > 0.5) => -0.0162092068,
   (_pp_origlistingtype_res = NULL) => 0.0602242982, 0.0602242982),
(_pp_src_all_uw = NULL) => 0.0002859638, 0.0002859638);

// Tree: 405 
final_score_405 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 92956.5) => -0.0046684864,
(f_prevaddrmedianincome_d > 92956.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 242287.5) => -0.0484182700,
   (f_prevaddrmedianvalue_d > 242287.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -324967.5) => -0.0697948760,
      (f_addrchangevaluediff_d > -324967.5) => 0.0896477654,
      (f_addrchangevaluediff_d = NULL) => 0.0738825319, 0.0688799390),
   (f_prevaddrmedianvalue_d = NULL) => 0.0451853091, 0.0451853091),
(f_prevaddrmedianincome_d = NULL) => -0.0011717155, -0.0011717155);

// Tree: 406 
final_score_406 := map(
(NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 21.5) => 
   map(
   (NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 6.5) => -0.0099827396,
   (mth_internal_ver_first_seen > 6.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.544168465180625) => -0.1021018415,
      (f_add_input_mobility_index_n > 0.544168465180625) => 0.0226985930,
      (f_add_input_mobility_index_n = NULL) => -0.0704929978, -0.0704929978),
   (mth_internal_ver_first_seen = NULL) => -0.0246567159, -0.0246567159),
(f_mos_inq_banko_om_lseen_d > 21.5) => 0.0074410392,
(f_mos_inq_banko_om_lseen_d = NULL) => 0.0002960940, 0.0002960940);

// Tree: 407 
final_score_407 := map(
(NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 12.5) => -0.0085721712,
(f_rel_ageover30_count_d > 12.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 5.5) => -0.0138159621,
   (f_corrrisktype_i > 5.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 2.5) => 0.0040903659,
      (f_util_adl_count_n > 2.5) => 0.0650080198,
      (f_util_adl_count_n = NULL) => 0.0371956425, 0.0371956425),
   (f_corrrisktype_i = NULL) => 0.0197033653, 0.0197033653),
(f_rel_ageover30_count_d = NULL) => 0.0007976305, 0.0007976305);

// Tree: 408 
final_score_408 := map(
(NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 6.5) => 
   map(
   (NULL < pk_cell_indicator and pk_cell_indicator <= 3.5) => 0.0178940077,
   (pk_cell_indicator > 3.5) => 
      map(
      (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 1.5) => 0.0369870975,
      (f_rel_incomeover75_count_d > 1.5) => 0.1685070121,
      (f_rel_incomeover75_count_d = NULL) => 0.0741180497, 0.0741180497),
   (pk_cell_indicator = NULL) => 0.0256653103, 0.0256653103),
(f_rel_ageover30_count_d > 6.5) => -0.0153269968,
(f_rel_ageover30_count_d = NULL) => -0.0021220031, -0.0021220031);

// Tree: 409 
final_score_409 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 2.5) => -0.0319943104,
(f_rel_under25miles_cnt_d > 2.5) => 
   map(
   (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 16.5) => 0.0030691775,
   (mth_source_inf_fseen > 16.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -28.5) => 0.0041687813,
      (f_addrchangecrimediff_i > -28.5) => -0.0937992960,
      (f_addrchangecrimediff_i = NULL) => 0.0180077628, -0.0449291054),
   (mth_source_inf_fseen = NULL) => 0.0000226282, 0.0000226282),
(f_rel_under25miles_cnt_d = NULL) => -0.0051524343, -0.0051524343);

// Tree: 410 
final_score_410 := map(
(NULL < subject_ssn_mismatch and subject_ssn_mismatch <= -0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 49.5) => -0.0139117142,
   (f_mos_inq_banko_cm_lseen_d > 49.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Granddaughter','Grandmother','Husband','Mother','Neighbor','Parent','Sibling','Sister']) => -0.0489005319,
      (phone_subject_title in ['Associate By Address','Associate By Business','Father','Grandchild','Grandfather','Grandparent','Grandson','Relative','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0778820637,
      (phone_subject_title = '') => 0.0317793017, 0.0317793017),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0130101005, 0.0130101005),
(subject_ssn_mismatch > -0.5) => -0.0106138086,
(subject_ssn_mismatch = NULL) => -0.0029687454, -0.0029687454);

// Tree: 411 
final_score_411 := map(
(NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 26.5) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 11.5) => -0.0745682397,
   (f_rel_incomeover25_count_d > 11.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 15.5) => 0.0969732808,
      (f_rel_educationover12_count_d > 15.5) => -0.0618474811,
      (f_rel_educationover12_count_d = NULL) => 0.0211399440, 0.0211399440),
   (f_rel_incomeover25_count_d = NULL) => -0.0304868771, -0.0304868771),
(f_curraddrmurderindex_i > 26.5) => 0.0084585364,
(f_curraddrmurderindex_i = NULL) => 0.0040390370, 0.0040390370);

// Tree: 412 
final_score_412 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.213200486077585) => -0.0406524438,
(f_add_curr_mobility_index_n > 0.213200486077585) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 54324.5) => -0.0104087636,
   (f_curraddrmedianincome_d > 54324.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Husband','Neighbor','Parent','Sister']) => -0.0390529496,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Relative','Sibling','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0370396948,
      (phone_subject_title = '') => 0.0144910058, 0.0144910058),
   (f_curraddrmedianincome_d = NULL) => 0.0000279840, 0.0000279840),
(f_add_curr_mobility_index_n = NULL) => -0.0795121461, -0.0057172890);

// Tree: 413 
final_score_413 := map(
(pp_rp_source in ['CELL','GONG','INFUTOR','INQUIRY','INTRADO','OTHER','THRIVE']) => 
   map(
   (NULL < r_has_paw_source_d and r_has_paw_source_d <= 0.5) => 0.0286256902,
   (r_has_paw_source_d > 0.5) => 
      map(
      (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => -0.0331123426,
      (f_bus_name_nover_i > 0.5) => -0.1554783642,
      (f_bus_name_nover_i = NULL) => -0.0856621678, -0.0856621678),
   (r_has_paw_source_d = NULL) => -0.0427494855, -0.0427494855),
(pp_rp_source in ['HEADER','IBEHAVIOR','PCNSR','TARGUS']) => 0.0419358518,
(pp_rp_source = '') => 0.0018360788, 0.0009337191);

// Tree: 414 
final_score_414 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 147762) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 41.5) => 
      map(
      (NULL < number_of_sources and number_of_sources <= 1.5) => -0.0526697601,
      (number_of_sources > 1.5) => -0.1347554937,
      (number_of_sources = NULL) => -0.0746508770, -0.0746508770),
   (f_mos_inq_banko_cm_fseen_d > 41.5) => -0.0105015910,
   (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0177660683, -0.0177660683),
(f_curraddrmedianvalue_d > 147762) => 0.0067294622,
(f_curraddrmedianvalue_d = NULL) => -0.0053791728, -0.0053791728);

// Tree: 415 
final_score_415 := map(
(NULL < f_mos_foreclosure_lseen_d and f_mos_foreclosure_lseen_d <= 44.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -6) => -0.1755169707,
   (f_addrchangecrimediff_i > -6) => 0.0030030160,
   (f_addrchangecrimediff_i = NULL) => -0.0591655141, -0.0676760376),
(f_mos_foreclosure_lseen_d > 44.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 39731) => -0.0445005289,
   (f_prevaddrmedianvalue_d > 39731) => 0.0008112950,
   (f_prevaddrmedianvalue_d = NULL) => -0.0021486916, -0.0021486916),
(f_mos_foreclosure_lseen_d = NULL) => -0.0040132285, -0.0040132285);

// Tree: 416 
final_score_416 := map(
(pp_did_type in ['AMBIG','CORE','INACTIVE']) => -0.0060507641,
(pp_did_type in ['C_MERGE','NO_SSN']) => 
   map(
   (NULL < internal_verification and internal_verification <= 0.5) => -0.0311165115,
   (internal_verification > 0.5) => 0.1717630396,
   (internal_verification = NULL) => 0.0647320953, 0.0647320953),
(pp_did_type = '') => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 102) => 0.0791342494,
   (eda_days_ph_first_seen > 102) => 0.0031205381,
   (eda_days_ph_first_seen = NULL) => 0.0082543972, 0.0082543972), 0.0028133847);

// Tree: 417 
final_score_417 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 568) => 
   map(
   (NULL < eda_days_ind_first_seen and eda_days_ind_first_seen <= 776.5) => -0.0144472721,
   (eda_days_ind_first_seen > 776.5) => -0.1070925156,
   (eda_days_ind_first_seen = NULL) => -0.0183178731, -0.0183178731),
(f_mos_inq_banko_cm_fseen_d > 568) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Brother','Child','Daughter','Granddaughter','Grandmother','Husband','Neighbor','Parent','Relative','Sibling','Sister']) => -0.0667769595,
   (phone_subject_title in ['Associate','Associate By Address','Associate By SSN','Associate By Vehicle','Father','Grandchild','Grandfather','Grandparent','Grandson','Mother','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0392688569,
   (phone_subject_title = '') => 0.0056148841, 0.0056148841),
(f_mos_inq_banko_cm_fseen_d = NULL) => -0.0100161016, -0.0100161016);

// Tree: 418 
final_score_418 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 602252) => 
   map(
   (NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0024004226,
   (_pp_rule_high_vend_conf > 0.5) => 0.0276326607,
   (_pp_rule_high_vend_conf = NULL) => 0.0024346806, 0.0024346806),
(f_prevaddrmedianvalue_d > 602252) => 
   map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 7.5) => -0.0070395808,
   (f_rel_incomeover50_count_d > 7.5) => -0.1715556491,
   (f_rel_incomeover50_count_d = NULL) => -0.0880449545, -0.0880449545),
(f_prevaddrmedianvalue_d = NULL) => 0.0003369092, 0.0003369092);

// Tree: 419 
final_score_419 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 167.5) => -0.0076776604,
(r_pb_order_freq_d > 167.5) => 
   map(
   (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 1.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 19.5) => -0.1239023611,
      (f_prevaddrmurderindex_i > 19.5) => 0.0341792308,
      (f_prevaddrmurderindex_i = NULL) => 0.0193715880, 0.0193715880),
   (f_rel_ageover50_count_d > 1.5) => 0.1058654200,
   (f_rel_ageover50_count_d = NULL) => 0.0327850700, 0.0327850700),
(r_pb_order_freq_d = NULL) => -0.0017281352, -0.0009141498);

// Tree: 420 
final_score_420 := map(
(exp_source in ['P']) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 16.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 3) => -0.0804410060,
      (r_pb_order_freq_d > 3) => 0.0005883612,
      (r_pb_order_freq_d = NULL) => -0.1320898148, -0.0529891074),
   (f_rel_count_i > 16.5) => 0.0497315441,
   (f_rel_count_i = NULL) => -0.0204033545, -0.0204033545),
(exp_source in ['S']) => 0.0153240822,
(exp_source = '') => -0.0078329951, -0.0039623311);

// Tree: 421 
final_score_421 := map(
(NULL < f_inq_lnames_per_addr_i and f_inq_lnames_per_addr_i <= 6.5) => -0.0032943969,
(f_inq_lnames_per_addr_i > 6.5) => 
   map(
   (phone_subject_title in ['Associate','Brother','Husband','Neighbor','Relative','Sister','Spouse','Subject','Subject at Household']) => 
      map(
      (NULL < eda_days_in_service and eda_days_in_service <= 38) => 0.0754141885,
      (eda_days_in_service > 38) => -0.1129169563,
      (eda_days_in_service = NULL) => -0.0072920815, -0.0072920815),
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Parent','Sibling','Son','Wife']) => 0.3101887343,
   (phone_subject_title = '') => 0.0692093199, 0.0692093199),
(f_inq_lnames_per_addr_i = NULL) => -0.0011806602, -0.0011806602);

// Tree: 422 
final_score_422 := map(
(exp_source in ['P']) => -0.0273336647,
(exp_source in ['S']) => 
   map(
   (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 4.5) => 0.0320440384,
   (pp_app_ind_ph_cnt > 4.5) => 
      map(
      (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => -0.0432847763,
      (f_curraddractivephonelist_d > 0.5) => 0.0780968501,
      (f_curraddractivephonelist_d = NULL) => -0.0283167145, -0.0283167145),
   (pp_app_ind_ph_cnt = NULL) => 0.0132037321, 0.0132037321),
(exp_source = '') => 0.0007304979, 0.0016031186);

// Tree: 423 
final_score_423 := map(
(NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 86.5) => 
   map(
   (NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0051407637,
   (_pp_rule_high_vend_conf > 0.5) => 
      map(
      (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 2.5) => -0.0316891110,
      (pp_app_ind_ph_cnt > 2.5) => 0.0894953564,
      (pp_app_ind_ph_cnt = NULL) => 0.0303269611, 0.0303269611),
   (_pp_rule_high_vend_conf = NULL) => 0.0000672128, 0.0000672128),
(mth_pp_eda_hist_did_dt > 86.5) => -0.0509144894,
(mth_pp_eda_hist_did_dt = NULL) => -0.0042066309, -0.0042066309);

// Tree: 424 
final_score_424 := map(
(NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 9.5) => 0.0043484666,
(mth_internal_ver_first_seen > 9.5) => 
   map(
   (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 5.5) => -0.1288426213,
   (mth_pp_datevendorfirstseen > 5.5) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 3.5) => 0.0428170191,
      (f_sourcerisktype_i > 3.5) => -0.0560563842,
      (f_sourcerisktype_i = NULL) => -0.0211598889, -0.0211598889),
   (mth_pp_datevendorfirstseen = NULL) => -0.0377676735, -0.0377676735),
(mth_internal_ver_first_seen = NULL) => 0.0013750405, 0.0013750405);

// Tree: 425 
final_score_425 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 32870) => -0.0206363512,
(f_prevaddrmedianincome_d > 32870) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 8.5) => 0.0145264654,
   (f_rel_homeover200_count_d > 8.5) => 
      map(
      (pp_source in ['GONG','HEADER','IBEHAVIOR','INQUIRY','INTRADO','THRIVE']) => -0.0465886493,
      (pp_source in ['CELL','INFUTOR','OTHER','PCNSR','TARGUS']) => 0.0409491154,
      (pp_source = '') => -0.0089311236, -0.0141532739),
   (f_rel_homeover200_count_d = NULL) => 0.0084883983, 0.0084883983),
(f_prevaddrmedianincome_d = NULL) => 0.0020844316, 0.0020844316);

// Tree: 426 
final_score_426 := map(
(NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 9.5) => -0.0021907151,
(f_rel_incomeover75_count_d > 9.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 84) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -4.5) => -0.0180630628,
      (f_addrchangecrimediff_i > -4.5) => 0.1369658304,
      (f_addrchangecrimediff_i = NULL) => 0.1888860221, 0.0945749809),
   (f_curraddrmurderindex_i > 84) => -0.0361438567,
   (f_curraddrmurderindex_i = NULL) => 0.0505539842, 0.0505539842),
(f_rel_incomeover75_count_d = NULL) => 0.0002205774, 0.0002205774);

// Tree: 427 
final_score_427 := map(
(NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 8.5) => -0.0019329045,
(f_rel_incomeover75_count_d > 8.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 337801) => 0.0017753150,
   (f_curraddrmedianvalue_d > 337801) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 15615.5) => 0.1721260148,
      (f_addrchangeincomediff_d > 15615.5) => 0.0006497048,
      (f_addrchangeincomediff_d = NULL) => 0.0928277568, 0.0864365252),
   (f_curraddrmedianvalue_d = NULL) => 0.0362669192, 0.0362669192),
(f_rel_incomeover75_count_d = NULL) => 0.0006134511, 0.0006134511);

// Tree: 428 
final_score_428 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 50.5) => 
   map(
   (NULL < eda_num_phs_connected_addr and eda_num_phs_connected_addr <= 1.5) => 0.0033912011,
   (eda_num_phs_connected_addr > 1.5) => -0.1220909371,
   (eda_num_phs_connected_addr = NULL) => 0.0019618839, 0.0019618839),
(f_srchaddrsrchcount_i > 50.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Brother','Father','Mother','Neighbor','Subject at Household']) => -0.0542636794,
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => 0.1836108538,
   (phone_subject_title = '') => 0.0710452265, 0.0710452265),
(f_srchaddrsrchcount_i = NULL) => 0.0028678949, 0.0028678949);

// Tree: 429 
final_score_429 := map(
(NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 5.5) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 1.5) => -0.0017874526,
   (inq_adl_firstseen_n > 1.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 188.5) => 0.0529163408,
      (f_fp_prevaddrburglaryindex_i > 188.5) => -0.1383959651,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0408401487, 0.0408401487),
   (inq_adl_firstseen_n = NULL) => 0.0029245958, 0.0029245958),
(f_inq_per_ssn_i > 5.5) => -0.0689196269,
(f_inq_per_ssn_i = NULL) => -0.0002045519, -0.0002045519);

// Tree: 430 
final_score_430 := map(
(NULL < eda_num_phs_connected_addr and eda_num_phs_connected_addr <= 1.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 18.5) => 0.0107239315,
   (mth_source_ppdid_lseen > 18.5) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 152.5) => -0.0433230416,
      (mth_pp_app_npa_last_change_dt > 152.5) => 0.1537905383,
      (mth_pp_app_npa_last_change_dt = NULL) => -0.0308259270, -0.0308259270),
   (mth_source_ppdid_lseen = NULL) => 0.0055972985, 0.0055972985),
(eda_num_phs_connected_addr > 1.5) => -0.1453258527,
(eda_num_phs_connected_addr = NULL) => 0.0037595737, 0.0037595737);

// Tree: 431 
final_score_431 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -102262.5) => -0.0424959471,
(f_addrchangevaluediff_d > -102262.5) => 
   map(
   (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 11.5) => 0.0091840992,
   (mth_pp_datelastseen > 11.5) => 
      map(
      (pp_src in ['E1','EM','EN','KW','LP','TN','UT','UW','VO','ZT']) => -0.0668703115,
      (pp_src in ['CY','E2','EB','EQ','FA','FF','LA','MD','NW','PL','SL','VW','ZK']) => 0.0677159069,
      (pp_src = '') => -0.0084173290, -0.0247244412),
   (mth_pp_datelastseen = NULL) => 0.0009271689, 0.0009271689),
(f_addrchangevaluediff_d = NULL) => 0.0016251010, -0.0026910095);

// Tree: 432 
final_score_432 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -76026.5) => -0.0318835800,
(f_addrchangevaluediff_d > -76026.5) => 0.0104258452,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 33.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Father','Grandfather','Husband','Mother','Neighbor','Relative','Sister','Subject','Subject at Household','Wife']) => -0.0055801513,
      (phone_subject_title in ['Associate By Property','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Parent','Sibling','Son','Spouse']) => 0.1902636879,
      (phone_subject_title = '') => -0.0004362109, -0.0004362109),
   (f_rel_under500miles_cnt_d > 33.5) => 0.1597606467,
   (f_rel_under500miles_cnt_d = NULL) => 0.0037363584, 0.0037363584), 0.0036954078);

// Tree: 433 
final_score_433 := map(
(NULL < f_vardobcount_i and f_vardobcount_i <= 2.5) => -0.0029202010,
(f_vardobcount_i > 2.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 19.5) => 
      map(
      (NULL < eda_num_ph_owners_hist and eda_num_ph_owners_hist <= 1.5) => 0.1084376454,
      (eda_num_ph_owners_hist > 1.5) => -0.0304075385,
      (eda_num_ph_owners_hist = NULL) => 0.0740769686, 0.0740769686),
   (f_addrchangecrimediff_i > 19.5) => -0.0164004527,
   (f_addrchangecrimediff_i = NULL) => -0.0178065312, 0.0312922777),
(f_vardobcount_i = NULL) => 0.0000687332, 0.0000687332);

// Tree: 434 
final_score_434 := map(
(NULL < source_ppfla and source_ppfla <= 0.5) => -0.0044042848,
(source_ppfla > 0.5) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 0.5) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => 0.0980073592,
      (f_sourcerisktype_i > 5.5) => -0.0413801067,
      (f_sourcerisktype_i = NULL) => 0.0727513734, 0.0727513734),
   (f_srchfraudsrchcountyr_i > 0.5) => -0.0604717642,
   (f_srchfraudsrchcountyr_i = NULL) => 0.0379778765, 0.0379778765),
(source_ppfla = NULL) => -0.0014765860, -0.0014765860);

// Tree: 435 
final_score_435 := map(
(eda_pfrd_address_ind in ['1A','1B']) => -0.0119831207,
(eda_pfrd_address_ind in ['1C','1D','1E','XX']) => 
   map(
   (pp_did_type in ['AMBIG','CORE','INACTIVE']) => 0.0040209939,
   (pp_did_type in ['C_MERGE','NO_SSN']) => 0.0538007746,
   (pp_did_type = '') => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 0.0357093833,
      (f_srchfraudsrchcount_i > 8.5) => 0.1507220198,
      (f_srchfraudsrchcount_i = NULL) => 0.0491728800, 0.0491728800), 0.0130658155),
(eda_pfrd_address_ind = '') => 0.0015810205, 0.0015810205);

// Tree: 436 
final_score_436 := map(
(NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 2.5) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 12.5) => -0.1433078632,
   (f_mos_inq_banko_om_lseen_d > 12.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 42347) => 0.0422362494,
      (f_prevaddrmedianincome_d > 42347) => -0.0692599369,
      (f_prevaddrmedianincome_d = NULL) => -0.0124635890, -0.0124635890),
   (f_mos_inq_banko_om_lseen_d = NULL) => -0.0310734051, -0.0310734051),
(f_rel_educationover12_count_d > 2.5) => 0.0047238008,
(f_rel_educationover12_count_d = NULL) => 0.0018536275, 0.0018536275);

// Tree: 437 
final_score_437 := map(
(phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Granddaughter','Grandmother','Husband','Mother','Neighbor','Relative','Sister','Subject','Subject at Household','Wife']) => -0.0008330916,
(phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Vehicle','Father','Grandchild','Grandfather','Grandparent','Grandson','Parent','Sibling','Son','Spouse']) => 
   map(
   (NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 891.5) => 0.0195112301,
   (eda_max_days_interrupt > 891.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 6507.5) => 0.0495243894,
      (f_addrchangevaluediff_d > 6507.5) => 0.1803370427,
      (f_addrchangevaluediff_d = NULL) => 0.1022714270, 0.1022714270),
   (eda_max_days_interrupt = NULL) => 0.0362205335, 0.0362205335),
(phone_subject_title = '') => 0.0028197772, 0.0028197772);

// Tree: 438 
final_score_438 := map(
(NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 70.5) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 0.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By SSN','Brother','Child','Daughter','Father','Grandfather','Grandmother','Husband','Mother','Neighbor','Parent','Relative','Son','Spouse','Subject','Wife']) => 0.0110516433,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Grandchild','Granddaughter','Grandparent','Grandson','Sibling','Sister','Subject at Household']) => 0.0703652779,
      (phone_subject_title = '') => 0.0196784708, 0.0196784708),
   (f_rel_criminal_count_i > 0.5) => -0.0056286478,
   (f_rel_criminal_count_i = NULL) => -0.0003409951, -0.0003409951),
(mth_source_utildid_fseen > 70.5) => -0.1143190879,
(mth_source_utildid_fseen = NULL) => -0.0014619599, -0.0014619599);

// Tree: 439 
final_score_439 := map(
(NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 32.5) => 
   map(
   (NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 15) => -0.0032916833,
   (r_mos_since_paw_fseen_d > 15) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -78619) => -0.0407918884,
      (f_addrchangevaluediff_d > -78619) => 0.0212263458,
      (f_addrchangevaluediff_d = NULL) => 0.0689408578, 0.0240391155),
   (r_mos_since_paw_fseen_d = NULL) => 0.0017303133, 0.0017303133),
(f_rel_ageover20_count_d > 32.5) => -0.0479669526,
(f_rel_ageover20_count_d = NULL) => -0.0003671848, -0.0003671848);

// Tree: 440 
final_score_440 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.12867045269957) => -0.1251179750,
(f_add_input_mobility_index_n > 0.12867045269957) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 63.5) => -0.0024926292,
   (f_addrchangecrimediff_i > 63.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 218.5) => 0.0437375951,
      (r_pb_order_freq_d > 218.5) => 0.1862091490,
      (r_pb_order_freq_d = NULL) => -0.0120658499, 0.0323235125),
   (f_addrchangecrimediff_i = NULL) => 0.0023373073, 0.0020463946),
(f_add_input_mobility_index_n = NULL) => -0.0625046242, 0.0004288868);

// Tree: 441 
final_score_441 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 19.5) => 0.0053132284,
(mth_exp_last_update > 19.5) => 
   map(
   (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 78.5) => 
      map(
      (NULL < eda_days_in_service and eda_days_in_service <= 1040) => -0.0736999753,
      (eda_days_in_service > 1040) => 0.0517152979,
      (eda_days_in_service = NULL) => -0.0502000720, -0.0502000720),
   (mth_pp_datefirstseen > 78.5) => 0.1040913593,
   (mth_pp_datefirstseen = NULL) => -0.0307806332, -0.0307806332),
(mth_exp_last_update = NULL) => 0.0028621759, 0.0028621759);

// Tree: 442 
final_score_442 := map(
(NULL < _phone_fb_result and _phone_fb_result <= 0.5) => 0.1272127891,
(_phone_fb_result > 0.5) => 
   map(
   (NULL < source_pf and source_pf <= 0.5) => 
      map(
      (pp_app_ph_type in ['CELL','PAGE','POTS']) => -0.0069526135,
      (pp_app_ph_type in ['LNDLN PRTD TO CELL','Puerto Rico/US Virgin Isl','VOIP']) => 0.0988780113,
      (pp_app_ph_type = '') => 0.0080217822, 0.0019551692),
   (source_pf > 0.5) => -0.1160854097,
   (source_pf = NULL) => 0.0011902974, 0.0011902974),
(_phone_fb_result = NULL) => 0.0019723126, 0.0019723126);

// Tree: 443 
final_score_443 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 11.5) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Grandson','Neighbor','Sister','Wife']) => -0.0621211575,
   (phone_subject_title in ['Associate','Associate By Address','Brother','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Husband','Mother','Parent','Relative','Sibling','Son','Spouse','Subject','Subject at Household']) => 
      map(
      (NULL < mth_source_exp_fseen and mth_source_exp_fseen <= 20.5) => 0.0259624723,
      (mth_source_exp_fseen > 20.5) => -0.1355215762,
      (mth_source_exp_fseen = NULL) => 0.0231416215, 0.0231416215),
   (phone_subject_title = '') => 0.0029113582, 0.0029113582),
(f_inq_count_i > 11.5) => -0.0292603028,
(f_inq_count_i = NULL) => -0.0086175425, -0.0086175425);

// Tree: 444 
final_score_444 := map(
(pp_rp_source in ['GONG','INFUTOR','INQUIRY','OTHER','THRIVE']) => -0.0401954994,
(pp_rp_source in ['CELL','HEADER','IBEHAVIOR','INTRADO','PCNSR','TARGUS']) => 
   map(
   (NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => -0.0362949134,
   (f_util_add_input_conv_n > 0.5) => 0.1532043057,
   (f_util_add_input_conv_n = NULL) => 0.0667660654, 0.0667660654),
(pp_rp_source = '') => 
   map(
   (NULL < mth_source_ppfa_lseen and mth_source_ppfa_lseen <= 6.5) => -0.0008291336,
   (mth_source_ppfa_lseen > 6.5) => 0.1056689170,
   (mth_source_ppfa_lseen = NULL) => 0.0000598754, 0.0000598754), -0.0003741785);

// Tree: 445 
final_score_445 := map(
(NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 19.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 20.5) => 
      map(
      (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 84.5) => 0.0003727187,
      (mth_source_inf_fseen > 84.5) => -0.1425350622,
      (mth_source_inf_fseen = NULL) => -0.0057667431, -0.0057667431),
   (mth_source_ppdid_fseen > 20.5) => -0.0818181238,
   (mth_source_ppdid_fseen = NULL) => -0.0203513829, -0.0203513829),
(f_mos_inq_banko_om_lseen_d > 19.5) => 0.0065647220,
(f_mos_inq_banko_om_lseen_d = NULL) => 0.0006653017, 0.0006653017);

// Tree: 446 
final_score_446 := map(
(NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 27.5) => 
   map(
   (NULL < mth_source_edahistory_fseen and mth_source_edahistory_fseen <= 14.5) => 
      map(
      (phone_subject_title in ['Associate By Business','Associate By Property','Child','Granddaughter','Grandfather','Grandson','Husband','Neighbor','Parent','Sibling','Son']) => -0.0747832533,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Daughter','Father','Grandchild','Grandmother','Grandparent','Mother','Relative','Sister','Spouse','Subject','Subject at Household','Wife']) => 0.0144066898,
      (phone_subject_title = '') => 0.0004200054, 0.0004200054),
   (mth_source_edahistory_fseen > 14.5) => -0.0958069862,
   (mth_source_edahistory_fseen = NULL) => -0.0018330063, -0.0018330063),
(f_rel_ageover20_count_d > 27.5) => -0.0597444466,
(f_rel_ageover20_count_d = NULL) => -0.0065494980, -0.0065494980);

// Tree: 447 
final_score_447 := map(
(NULL < source_eda_any_clean and source_eda_any_clean <= 0.5) => -0.0028289376,
(source_eda_any_clean > 0.5) => 
   map(
   (NULL < r_has_paw_source_d and r_has_paw_source_d <= 0.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.304986529096685) => 0.0667926939,
      (f_add_input_mobility_index_n > 0.304986529096685) => -0.0639570829,
      (f_add_input_mobility_index_n = NULL) => -0.0106111740, -0.0106111740),
   (r_has_paw_source_d > 0.5) => 0.0675892071,
   (r_has_paw_source_d = NULL) => 0.0318363917, 0.0318363917),
(source_eda_any_clean = NULL) => -0.0006007131, -0.0006007131);

// Tree: 448 
final_score_448 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 50.5) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 32.5) => 
      map(
      (NULL < mth_source_edahistory_lseen and mth_source_edahistory_lseen <= 1.5) => 0.0035434666,
      (mth_source_edahistory_lseen > 1.5) => -0.0995405966,
      (mth_source_edahistory_lseen = NULL) => 0.0014251292, 0.0014251292),
   (f_rel_incomeover25_count_d > 32.5) => -0.1007992169,
   (f_rel_incomeover25_count_d = NULL) => -0.0013795122, -0.0013795122),
(f_rel_incomeover25_count_d > 50.5) => 0.2181177182,
(f_rel_incomeover25_count_d = NULL) => 0.0000645485, 0.0000645485);

// Tree: 449 
final_score_449 := map(
(NULL < source_sx and source_sx <= 0.5) => -0.0026907477,
(source_sx > 0.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 4.5) => 
      map(
      (NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 1021) => 0.0361700357,
      (eda_max_days_interrupt > 1021) => 0.1786130999,
      (eda_max_days_interrupt = NULL) => 0.0612149701, 0.0612149701),
   (f_srchfraudsrchcount_i > 4.5) => -0.0490814556,
   (f_srchfraudsrchcount_i = NULL) => 0.0380072623, 0.0380072623),
(source_sx = NULL) => -0.0004940749, -0.0004940749);

// Tree: 450 
final_score_450 := map(
(NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 21.5) => 
   map(
   (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 354) => -0.0013478076,
   (mth_source_inf_fseen > 354) => -0.1198217557,
   (mth_source_inf_fseen = NULL) => -0.0021205626, -0.0021205626),
(f_rel_educationover12_count_d > 21.5) => 
   map(
   (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 6.5) => -0.0553116949,
   (pp_app_ind_ph_cnt > 6.5) => 0.0541032513,
   (pp_app_ind_ph_cnt = NULL) => -0.0391195405, -0.0391195405),
(f_rel_educationover12_count_d = NULL) => -0.0051447891, -0.0051447891);

// Tree: 451 
final_score_451 := map(
(NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 109.5) => -0.0011486690,
(mth_source_cr_fseen > 109.5) => 
   map(
   (NULL < eda_days_in_service and eda_days_in_service <= 465) => -0.1211531753,
   (eda_days_in_service > 465) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 6.5) => 0.2449582930,
      (f_rel_under25miles_cnt_d > 6.5) => 0.0519009568,
      (f_rel_under25miles_cnt_d = NULL) => 0.1254466087, 0.1254466087),
   (eda_days_in_service = NULL) => 0.0628578310, 0.0628578310),
(mth_source_cr_fseen = NULL) => 0.0003276547, 0.0003276547);

// Tree: 452 
final_score_452 := map(
(NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 175.5) => 0.0086533020,
(f_fp_prevaddrburglaryindex_i > 175.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.218047230447025) => 0.0842483305,
   (f_add_input_mobility_index_n > 0.218047230447025) => 
      map(
      (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 11.5) => -0.0245145318,
      (inq_adl_lastseen_n > 11.5) => -0.1035802452,
      (inq_adl_lastseen_n = NULL) => -0.0314198343, -0.0314198343),
   (f_add_input_mobility_index_n = NULL) => -0.0211975681, -0.0211975681),
(f_fp_prevaddrburglaryindex_i = NULL) => 0.0042460959, 0.0042460959);

// Tree: 453 
final_score_453 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 1.02322817602847) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 399.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 376.5) => 0.0025757332,
      (f_prevaddrageoldest_d > 376.5) => 0.1298021734,
      (f_prevaddrageoldest_d = NULL) => 0.0039839708, 0.0039839708),
   (f_prevaddrageoldest_d > 399.5) => -0.0779289264,
   (f_prevaddrageoldest_d = NULL) => 0.0022677945, 0.0022677945),
(f_add_curr_mobility_index_n > 1.02322817602847) => -0.0924681829,
(f_add_curr_mobility_index_n = NULL) => -0.0099960320, 0.0004322429);

// Tree: 454 
final_score_454 := map(
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Granddaughter','Grandfather','Grandmother','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Wife']) => -0.0923247956,
(phone_subject_title in ['Associate','Associate By Property','Grandchild','Grandparent','Mother','Subject','Subject at Household']) => 
   map(
   (NULL < number_of_sources and number_of_sources <= 2.5) => 
      map(
      (NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => 0.0183250178,
      (_inq_adl_ph_industry_flag > 0.5) => 0.2663061664,
      (_inq_adl_ph_industry_flag = NULL) => 0.0297365397, 0.0297365397),
   (number_of_sources > 2.5) => 0.1719910435,
   (number_of_sources = NULL) => 0.0549986204, 0.0549986204),
(phone_subject_title = '') => -0.0093745196, -0.0093745196);

// Tree: 455 
final_score_455 := map(
(exp_source in ['P']) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 129) => -0.0685706968,
   (f_curraddrburglaryindex_i > 129) => 0.0394788526,
   (f_curraddrburglaryindex_i = NULL) => -0.0308672241, -0.0308672241),
(exp_source in ['S']) => 
   map(
   (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 9.5) => 0.0169655007,
   (pp_app_ind_ph_cnt > 9.5) => -0.0864258450,
   (pp_app_ind_ph_cnt = NULL) => 0.0115467977, 0.0115467977),
(exp_source = '') => -0.0080638245, -0.0053924065);

// Tree: 456 
final_score_456 := map(
(NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 5.5) => 0.0011375155,
(mth_source_rel_fseen > 5.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.46053458232229) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => -0.1263671081,
      (f_corrrisktype_i > 6.5) => -0.0269142151,
      (f_corrrisktype_i = NULL) => -0.0830937119, -0.0830937119),
   (f_add_input_mobility_index_n > 0.46053458232229) => 0.0289855526,
   (f_add_input_mobility_index_n = NULL) => -0.0416028303, -0.0416028303),
(mth_source_rel_fseen = NULL) => 0.0000966547, 0.0000966547);

// Tree: 457 
final_score_457 := map(
(NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 17.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 52410.5) => 
      map(
      (pp_rp_source in ['CELL','HEADER','INFUTOR','OTHER','TARGUS','THRIVE']) => -0.0706100604,
      (pp_rp_source in ['GONG','IBEHAVIOR','INQUIRY','INTRADO','PCNSR']) => 0.0325125742,
      (pp_rp_source = '') => -0.0069566040, -0.0082984025),
   (f_curraddrmedianincome_d > 52410.5) => 0.0123491904,
   (f_curraddrmedianincome_d = NULL) => 0.0016509810, 0.0016509810),
(mth_source_rel_fseen > 17.5) => -0.0806771740,
(mth_source_rel_fseen = NULL) => 0.0009280432, 0.0009280432);

// Tree: 458 
final_score_458 := map(
(pp_src in ['E1','EM','EN','EQ','KW','NW','SL','VW','ZT']) => -0.0596773831,
(pp_src in ['CY','E2','EB','FA','FF','LA','LP','MD','PL','TN','UT','UW','VO','ZK']) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 19.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 52.5) => 0.0462190705,
      (f_curraddrburglaryindex_i > 52.5) => -0.0080505489,
      (f_curraddrburglaryindex_i = NULL) => 0.0039349226, 0.0039349226),
   (f_assocsuspicousidcount_i > 19.5) => 0.1617075898,
   (f_assocsuspicousidcount_i = NULL) => 0.0091661118, 0.0091661118),
(pp_src = '') => 0.0003861385, 0.0005017270);

// Tree: 459 
final_score_459 := map(
(NULL < pk_phone_match_level and pk_phone_match_level <= 3.5) => 0.0024212546,
(pk_phone_match_level > 3.5) => 
   map(
   (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 101.5) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 10.5) => -0.0602831887,
      (f_rel_homeover100_count_d > 10.5) => 0.0188275208,
      (f_rel_homeover100_count_d = NULL) => -0.0453020909, -0.0453020909),
   (mth_pp_app_npa_effective_dt > 101.5) => 0.0056854124,
   (mth_pp_app_npa_effective_dt = NULL) => -0.0170509030, -0.0170509030),
(pk_phone_match_level = NULL) => -0.0022159505, -0.0022159505);

// Tree: 460 
final_score_460 := map(
(NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 2.5) => 0.0047955758,
(f_rel_incomeover100_count_d > 2.5) => 
   map(
   (NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 77.5) => 0.0500452339,
   (f_mos_acc_lseen_d > 77.5) => 
      map(
      (pp_src in ['CY','EN','FA','UT','VO','ZK']) => -0.0946102768,
      (pp_src in ['E1','E2','EB','EM','EQ','FF','KW','LA','LP','MD','NW','PL','SL','TN','UW','VW','ZT']) => 0.0480739279,
      (pp_src = '') => -0.0402648718, -0.0419014909),
   (f_mos_acc_lseen_d = NULL) => -0.0286532531, -0.0286532531),
(f_rel_incomeover100_count_d = NULL) => 0.0011406103, 0.0011406103);

// Tree: 461 
final_score_461 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 17.5) => 0.0034380751,
(mth_exp_last_update > 17.5) => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 4703.5) => 
      map(
      (pp_source in ['CELL','HEADER','INQUIRY','OTHER','PCNSR']) => -0.0600384549,
      (pp_source in ['GONG','IBEHAVIOR','INFUTOR','INTRADO','TARGUS','THRIVE']) => 0.0202949535,
      (pp_source = '') => -0.0830212864, -0.0468651592),
   (eda_days_ph_first_seen > 4703.5) => 0.0648531387,
   (eda_days_ph_first_seen = NULL) => -0.0304955597, -0.0304955597),
(mth_exp_last_update = NULL) => 0.0008079304, 0.0008079304);

// Tree: 462 
final_score_462 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 34.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Vehicle','Grandfather','Grandmother','Grandparent','Husband','Mother','Parent','Spouse','Subject']) => 
      map(
      (pp_source in ['CELL','GONG','IBEHAVIOR','INQUIRY','THRIVE']) => -0.0754163709,
      (pp_source in ['HEADER','INFUTOR','INTRADO','OTHER','PCNSR','TARGUS']) => -0.0024914239,
      (pp_source = '') => -0.0768541758, -0.0538085162),
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandson','Neighbor','Relative','Sibling','Sister','Son','Subject at Household','Wife']) => 0.0119203787,
   (phone_subject_title = '') => -0.0240405933, -0.0240405933),
(f_mos_inq_banko_om_fseen_d > 34.5) => 0.0009936484,
(f_mos_inq_banko_om_fseen_d = NULL) => -0.0036731564, -0.0036731564);

// Tree: 463 
final_score_463 := map(
(NULL < mth_source_md_fseen and mth_source_md_fseen <= 7.5) => 0.0032424076,
(mth_source_md_fseen > 7.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.31211534664938) => -0.1128306123,
   (f_add_curr_mobility_index_n > 0.31211534664938) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 206416.5) => -0.0518285363,
      (f_curraddrmedianvalue_d > 206416.5) => 0.1170520892,
      (f_curraddrmedianvalue_d = NULL) => -0.0046791231, -0.0046791231),
   (f_add_curr_mobility_index_n = NULL) => -0.0512530303, -0.0512530303),
(mth_source_md_fseen = NULL) => 0.0009837277, 0.0009837277);

// Tree: 464 
final_score_464 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 216091) => 0.0086725510,
(f_curraddrmedianvalue_d > 216091) => 
   map(
   (pp_rp_source in ['CELL','GONG','INFUTOR','OTHER']) => -0.0915142795,
   (pp_rp_source in ['HEADER','IBEHAVIOR','INQUIRY','INTRADO','PCNSR','TARGUS','THRIVE']) => 0.0286162246,
   (pp_rp_source = '') => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 151.5) => 0.0015659979,
      (f_prevaddrlenofres_d > 151.5) => -0.0431807149,
      (f_prevaddrlenofres_d = NULL) => -0.0139253921, -0.0139253921), -0.0151322148),
(f_curraddrmedianvalue_d = NULL) => 0.0015840827, 0.0015840827);

// Tree: 465 
final_score_465 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 33.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 10.5) => 0.0012159434,
   (f_rel_homeover500_count_d > 10.5) => -0.1153038376,
   (f_rel_homeover500_count_d = NULL) => 0.0003560188, 0.0003560188),
(f_rel_under25miles_cnt_d > 33.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 121.5) => -0.0081335635,
   (f_prevaddrmurderindex_i > 121.5) => 0.1898775457,
   (f_prevaddrmurderindex_i = NULL) => 0.0828445137, 0.0828445137),
(f_rel_under25miles_cnt_d = NULL) => 0.0014317029, 0.0014317029);

// Tree: 466 
final_score_466 := map(
(NULL < _pp_rule_seen_once and _pp_rule_seen_once <= 0.5) => 
   map(
   (NULL < mth_source_ppfla_lseen and mth_source_ppfla_lseen <= 21.5) => -0.0018538920,
   (mth_source_ppfla_lseen > 21.5) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 3.5) => 0.1015165174,
      (f_inq_count24_i > 3.5) => -0.0763170896,
      (f_inq_count24_i = NULL) => 0.0434672053, 0.0434672053),
   (mth_source_ppfla_lseen = NULL) => -0.0008220444, -0.0008220444),
(_pp_rule_seen_once > 0.5) => 0.0951283681,
(_pp_rule_seen_once = NULL) => -0.0001030623, -0.0001030623);

// Tree: 467 
final_score_467 := map(
(NULL < mth_source_cr_lseen and mth_source_cr_lseen <= 4.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 5.5) => -0.0007389592,
   (f_rel_felony_count_i > 5.5) => 
      map(
      (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 11.5) => 0.1669935258,
      (f_crim_rel_under500miles_cnt_i > 11.5) => -0.0210483174,
      (f_crim_rel_under500miles_cnt_i = NULL) => 0.0734808254, 0.0734808254),
   (f_rel_felony_count_i = NULL) => 0.0008919543, 0.0008919543),
(mth_source_cr_lseen > 4.5) => -0.1152957061,
(mth_source_cr_lseen = NULL) => -0.0007540716, -0.0007540716);

// Tree: 468 
final_score_468 := map(
(NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 5.5) => 0.0052964361,
(f_inq_per_ssn_i > 5.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 32033) => 0.1135112283,
   (f_curraddrmedianincome_d > 32033) => 
      map(
      (NULL < pk_cell_indicator and pk_cell_indicator <= 2.5) => -0.0626454634,
      (pk_cell_indicator > 2.5) => -0.1678753550,
      (pk_cell_indicator = NULL) => -0.0825001599, -0.0825001599),
   (f_curraddrmedianincome_d = NULL) => -0.0496605556, -0.0496605556),
(f_inq_per_ssn_i = NULL) => 0.0028384604, 0.0028384604);

// Tree: 469 
final_score_469 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.545089130372775) => 0.0047371156,
(f_add_curr_mobility_index_n > 0.545089130372775) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 245.5) => 
      map(
      (pp_src in ['E2','EM','FA','PL','UT','UW']) => -0.0376999250,
      (pp_src in ['CY','E1','EB','EN','EQ','FF','KW','LA','LP','MD','NW','SL','TN','VO','VW','ZK','ZT']) => 0.1034999650,
      (pp_src = '') => -0.0147730689, -0.0129044324),
   (f_prevaddrageoldest_d > 245.5) => -0.1063879532,
   (f_prevaddrageoldest_d = NULL) => -0.0244171813, -0.0244171813),
(f_add_curr_mobility_index_n = NULL) => 0.0295024700, 0.0008288949);

// Tree: 470 
final_score_470 := map(
(pp_source in ['GONG','INFUTOR','INQUIRY','OTHER','THRIVE']) => 
   map(
   (NULL < f_vardobcount_i and f_vardobcount_i <= 2.5) => -0.0207480908,
   (f_vardobcount_i > 2.5) => 0.0673977546,
   (f_vardobcount_i = NULL) => -0.0140360677, -0.0140360677),
(pp_source in ['CELL','HEADER','IBEHAVIOR','INTRADO','PCNSR','TARGUS']) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 0.0411820664,
   (f_srchvelocityrisktype_i > 5.5) => -0.0346125548,
   (f_srchvelocityrisktype_i = NULL) => 0.0114016906, 0.0114016906),
(pp_source = '') => -0.0019682845, -0.0028850930);

// Tree: 471 
final_score_471 := map(
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Granddaughter','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Wife']) => -0.0989790288,
(phone_subject_title in ['Associate','Grandchild','Grandparent','Subject','Subject at Household']) => 
   map(
   (exp_source in ['S']) => 0.1408811666,
   (exp_source in ['P']) => 0.2397720734,
   (exp_source = '') => 
      map(
      (NULL < source_rel and source_rel <= 0.5) => -0.0061426825,
      (source_rel > 0.5) => 0.2616805910,
      (source_rel = NULL) => 0.0235729929, 0.0235729929), 0.0791052115),
(phone_subject_title = '') => -0.0004812005, -0.0004812005);

// Tree: 472 
final_score_472 := map(
(NULL < mth_source_sx_fseen and mth_source_sx_fseen <= 25.5) => 0.0031620728,
(mth_source_sx_fseen > 25.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 3.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 3) => -0.0332531342,
      (r_pb_order_freq_d > 3) => 0.0352618548,
      (r_pb_order_freq_d = NULL) => -0.0848710910, -0.0152138070),
   (f_srchfraudsrchcount_i > 3.5) => -0.1589230048,
   (f_srchfraudsrchcount_i = NULL) => -0.0463261075, -0.0463261075),
(mth_source_sx_fseen = NULL) => 0.0014759634, 0.0014759634);

// Tree: 473 
final_score_473 := map(
(pp_did_type in ['AMBIG','CORE','INACTIVE','NO_SSN']) => -0.0093784921,
(pp_did_type in ['C_MERGE']) => 0.0806822388,
(pp_did_type = '') => 
   map(
   (NULL < eda_days_in_service and eda_days_in_service <= 55.5) => 
      map(
      (NULL < f_inq_lnames_per_addr_i and f_inq_lnames_per_addr_i <= 2.5) => 0.0507374248,
      (f_inq_lnames_per_addr_i > 2.5) => 0.1783460158,
      (f_inq_lnames_per_addr_i = NULL) => 0.0660684923, 0.0660684923),
   (eda_days_in_service > 55.5) => -0.0043362293,
   (eda_days_in_service = NULL) => 0.0042853788, 0.0042853788), -0.0011090328);

// Tree: 474 
final_score_474 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 21.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Granddaughter','Grandfather','Grandson','Husband','Neighbor','Parent','Sibling','Sister','Subject']) => -0.0341091038,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Daughter','Father','Grandchild','Grandmother','Grandparent','Mother','Relative','Son','Spouse','Subject at Household','Wife']) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 47.5) => -0.0065688566,
      (inq_firstseen_n > 47.5) => 0.1667261292,
      (inq_firstseen_n = NULL) => 0.0325202379, 0.0325202379),
   (phone_subject_title = '') => -0.0199152398, -0.0199152398),
(f_prevaddrlenofres_d > 21.5) => 0.0093369369,
(f_prevaddrlenofres_d = NULL) => 0.0029213249, 0.0029213249);

// Tree: 475 
final_score_475 := map(
(NULL < source_exp and source_exp <= 0.5) => 0.0090090875,
(source_exp > 0.5) => 
   map(
   (NULL < f_wealth_index_d and f_wealth_index_d <= 4.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 24.5) => 0.1022639642,
      (f_fp_prevaddrburglaryindex_i > 24.5) => -0.0181325319,
      (f_fp_prevaddrburglaryindex_i = NULL) => -0.0073828447, -0.0073828447),
   (f_wealth_index_d > 4.5) => -0.0934237582,
   (f_wealth_index_d = NULL) => -0.0166104209, -0.0166104209),
(source_exp = NULL) => 0.0069393696, 0.0069393696);

// Tree: 476 
final_score_476 := map(
(NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 15.5) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 9.5) => -0.0015800910,
   (inq_adl_firstseen_n > 9.5) => -0.0840465198,
   (inq_adl_firstseen_n = NULL) => -0.0025282259, -0.0025282259),
(inq_adl_firstseen_n > 15.5) => 
   map(
   (pp_src in ['CY','E2','EN','EQ','TN','UT','ZK']) => -0.0041259627,
   (pp_src in ['E1','EB','EM','FA','FF','KW','LA','LP','MD','NW','PL','SL','UW','VO','VW','ZT']) => 0.1161789929,
   (pp_src = '') => 0.0276946067, 0.0258063791),
(inq_adl_firstseen_n = NULL) => 0.0001257589, 0.0001257589);

// Tree: 477 
final_score_477 := map(
(NULL < mth_source_ppth_fseen and mth_source_ppth_fseen <= 30.5) => 
   map(
   (NULL < pk_phone_match_level and pk_phone_match_level <= 1.5) => -0.0151728029,
   (pk_phone_match_level > 1.5) => 
      map(
      (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 27.5) => 0.0169743685,
      (inq_adl_lastseen_n > 27.5) => -0.0458501758,
      (inq_adl_lastseen_n = NULL) => 0.0115321207, 0.0115321207),
   (pk_phone_match_level = NULL) => -0.0024534111, -0.0024534111),
(mth_source_ppth_fseen > 30.5) => -0.1000200418,
(mth_source_ppth_fseen = NULL) => -0.0053320894, -0.0053320894);

// Tree: 478 
final_score_478 := map(
(NULL < inq_num and inq_num <= 2.5) => -0.0026294020,
(inq_num > 2.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 24.5) => 
      map(
      (NULL < inq_num_adls and inq_num_adls <= 1.5) => 0.1138980834,
      (inq_num_adls > 1.5) => 0.0111598113,
      (inq_num_adls = NULL) => 0.0704515504, 0.0704515504),
   (inq_adl_lastseen_n > 24.5) => -0.0282592596,
   (inq_adl_lastseen_n = NULL) => 0.0335503130, 0.0335503130),
(inq_num = NULL) => -0.0012696445, -0.0012696445);

// Tree: 479 
final_score_479 := map(
(NULL < f_college_income_d and f_college_income_d <= 3.5) => 
   map(
   (NULL < f_inq_lnames_per_addr_i and f_inq_lnames_per_addr_i <= 2.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Brother','Grandfather','Mother','Sister','Spouse','Subject','Subject at Household']) => -0.0735908525,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Son','Wife']) => 0.0944405614,
      (phone_subject_title = '') => -0.0201976930, -0.0201976930),
   (f_inq_lnames_per_addr_i > 2.5) => 0.1392647437,
   (f_inq_lnames_per_addr_i = NULL) => 0.0104913043, 0.0104913043),
(f_college_income_d > 3.5) => -0.0276130702,
(f_college_income_d = NULL) => 0.0054401527, 0.0016263075);

// Tree: 480 
final_score_480 := map(
(NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 219.5) => 
   map(
   (NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 226.5) => -0.0004754967,
   (r_mos_since_paw_fseen_d > 226.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Property','Daughter','Father','Mother','Relative','Son','Subject at Household']) => -0.1396839478,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Sibling','Sister','Spouse','Subject','Wife']) => -0.0172411864,
      (phone_subject_title = '') => -0.0462954010, -0.0462954010),
   (r_mos_since_paw_fseen_d = NULL) => -0.0017629711, -0.0017629711),
(mth_source_inf_fseen > 219.5) => 0.0601727485,
(mth_source_inf_fseen = NULL) => -0.0007332471, -0.0007332471);

// Tree: 481 
final_score_481 := map(
(NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 24.5) => 
   map(
   (pp_rp_source in ['GONG','HEADER','OTHER']) => -0.0635768359,
   (pp_rp_source in ['CELL','IBEHAVIOR','INFUTOR','INQUIRY','INTRADO','PCNSR','TARGUS','THRIVE']) => 0.0301359722,
   (pp_rp_source = '') => 0.0071563345, 0.0074012012),
(f_rel_educationover12_count_d > 24.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 173.5) => -0.0776240272,
   (f_curraddrcrimeindex_i > 173.5) => 0.1506992733,
   (f_curraddrcrimeindex_i = NULL) => -0.0478002128, -0.0478002128),
(f_rel_educationover12_count_d = NULL) => 0.0043740687, 0.0043740687);

// Tree: 482 
final_score_482 := map(
(NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 88.5) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 21.5) => 0.0045365961,
   (f_rel_educationover12_count_d > 21.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 99) => -0.0799438863,
      (f_curraddrcrimeindex_i > 99) => 0.0113433963,
      (f_curraddrcrimeindex_i = NULL) => -0.0329289768, -0.0329289768),
   (f_rel_educationover12_count_d = NULL) => 0.0014278074, 0.0014278074),
(mth_source_ppfla_fseen > 88.5) => -0.0799209944,
(mth_source_ppfla_fseen = NULL) => 0.0005991754, 0.0005991754);

// Tree: 483 
final_score_483 := map(
(phone_subject_title in ['Associate By Address','Associate By Shared Associates','Brother','Child','Daughter','Father','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => 
   map(
   (NULL < pk_cell_indicator and pk_cell_indicator <= 3.5) => -0.0230220393,
   (pk_cell_indicator > 3.5) => 
      map(
      (NULL < mth_source_exp_fseen and mth_source_exp_fseen <= 16.5) => 0.0394280334,
      (mth_source_exp_fseen > 16.5) => -0.0609278520,
      (mth_source_exp_fseen = NULL) => 0.0250263714, 0.0250263714),
   (pk_cell_indicator = NULL) => -0.0158828625, -0.0158828625),
(phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Grandchild','Grandfather','Subject at Household']) => 0.0410083061,
(phone_subject_title = '') => -0.0083493287, -0.0083493287);

// Tree: 484 
final_score_484 := map(
(NULL < pk_cell_indicator and pk_cell_indicator <= 2.5) => -0.0080882038,
(pk_cell_indicator > 2.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 15.5) => 
      map(
      (NULL < mth_source_exp_fseen and mth_source_exp_fseen <= 20.5) => 0.0713744466,
      (mth_source_exp_fseen > 20.5) => -0.1041850154,
      (mth_source_exp_fseen = NULL) => 0.0613210416, 0.0613210416),
   (mth_source_ppdid_lseen > 15.5) => -0.0280717202,
   (mth_source_ppdid_lseen = NULL) => 0.0394489585, 0.0394489585),
(pk_cell_indicator = NULL) => 0.0005331595, 0.0005331595);

// Tree: 485 
final_score_485 := map(
(NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 24.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.61788003580816) => 
      map(
      (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 0.5) => 0.0614539422,
      (f_rel_ageover50_count_d > 0.5) => -0.0550155995,
      (f_rel_ageover50_count_d = NULL) => 0.0328800813, 0.0328800813),
   (f_add_input_mobility_index_n > 0.61788003580816) => 0.1166438047,
   (f_add_input_mobility_index_n = NULL) => 0.0455486354, 0.0455486354),
(f_mos_acc_lseen_d > 24.5) => -0.0039766992,
(f_mos_acc_lseen_d = NULL) => -0.0013786488, -0.0013786488);

// Tree: 486 
final_score_486 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -21.5) => -0.0170578603,
(f_addrchangecrimediff_i > -21.5) => 0.0086184455,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < _pp_rule_low_vend_conf and _pp_rule_low_vend_conf <= 0.5) => 
      map(
      (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 23.5) => 0.0000859757,
      (f_rel_ageover20_count_d > 23.5) => 0.0613784473,
      (f_rel_ageover20_count_d = NULL) => 0.0085717159, 0.0085717159),
   (_pp_rule_low_vend_conf > 0.5) => 0.1286468069,
   (_pp_rule_low_vend_conf = NULL) => 0.0117094690, 0.0117094690), 0.0027532194);

// Tree: 487 
final_score_487 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 2.5) => 0.0011245966,
(f_rel_homeover500_count_d > 2.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 295714.5) => -0.0758493335,
   (f_prevaddrmedianvalue_d > 295714.5) => 
      map(
      (pp_source in ['IBEHAVIOR','INQUIRY','OTHER','PCNSR','THRIVE']) => -0.0730650412,
      (pp_source in ['CELL','GONG','HEADER','INFUTOR','INTRADO','TARGUS']) => 0.0820522793,
      (pp_source = '') => -0.0016112741, 0.0031428739),
   (f_prevaddrmedianvalue_d = NULL) => -0.0225039467, -0.0225039467),
(f_rel_homeover500_count_d = NULL) => -0.0007995609, -0.0007995609);

// Tree: 488 
final_score_488 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 41144.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 38971.5) => 0.0042111211,
   (f_addrchangeincomediff_d > 38971.5) => 0.1325669254,
   (f_addrchangeincomediff_d = NULL) => 0.0054809052, 0.0054809052),
(f_addrchangeincomediff_d > 41144.5) => -0.0341504233,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 4.5) => 0.0330621459,
   (f_rel_ageover30_count_d > 4.5) => -0.0190816628,
   (f_rel_ageover30_count_d = NULL) => -0.0095327966, -0.0095327966), -0.0004238972);

// Tree: 489 
final_score_489 := map(
(NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 91.5) => 
   map(
   (pp_source in ['GONG','INTRADO','OTHER']) => -0.1448227208,
   (pp_source in ['CELL','HEADER','IBEHAVIOR','INFUTOR','INQUIRY','PCNSR','TARGUS','THRIVE']) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 8.5) => 0.0726945995,
      (mth_pp_app_npa_last_change_dt > 8.5) => 0.0071156697,
      (mth_pp_app_npa_last_change_dt = NULL) => 0.0096951453, 0.0096951453),
   (pp_source = '') => 0.0008037601, 0.0036026932),
(mth_source_ppfla_fseen > 91.5) => -0.0791473603,
(mth_source_ppfla_fseen = NULL) => 0.0028469849, 0.0028469849);

// Tree: 490 
final_score_490 := map(
(exp_source in ['P']) => -0.0236495947,
(exp_source in ['S']) => 
   map(
   (phone_subject_title in ['Associate','Associate By Property','Associate By SSN','Brother','Grandfather','Grandmother','Husband','Neighbor','Parent','Relative','Sibling','Sister','Subject','Subject at Household','Wife']) => 0.0060539607,
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Father','Grandchild','Granddaughter','Grandparent','Grandson','Mother','Son','Spouse']) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 2.5) => 0.1987785844,
      (f_srchssnsrchcount_i > 2.5) => -0.0093855553,
      (f_srchssnsrchcount_i = NULL) => 0.1141590154, 0.1141590154),
   (phone_subject_title = '') => 0.0139033832, 0.0139033832),
(exp_source = '') => 0.0010668725, 0.0022208859);

// Tree: 491 
final_score_491 := map(
(NULL < mth_source_cr_lseen and mth_source_cr_lseen <= 6.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Father','Granddaughter','Grandson','Neighbor','Parent','Relative','Spouse','Subject','Subject at Household']) => -0.0025418766,
   (phone_subject_title in ['Brother','Grandchild','Grandfather','Grandmother','Grandparent','Husband','Mother','Sibling','Sister','Son','Wife']) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 32.5) => -0.0949068286,
      (f_curraddrcrimeindex_i > 32.5) => 0.0716232220,
      (f_curraddrcrimeindex_i = NULL) => 0.0486450400, 0.0486450400),
   (phone_subject_title = '') => 0.0015395125, 0.0015395125),
(mth_source_cr_lseen > 6.5) => -0.1225099642,
(mth_source_cr_lseen = NULL) => 0.0002614006, 0.0002614006);

// Tree: 492 
final_score_492 := map(
(pp_rp_source in ['CELL','GONG','INFUTOR','INQUIRY','OTHER','THRIVE']) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 15.5) => -0.0736696630,
   (f_inq_count_i > 15.5) => 0.0591066448,
   (f_inq_count_i = NULL) => -0.0327421989, -0.0327421989),
(pp_rp_source in ['HEADER','IBEHAVIOR','INTRADO','PCNSR','TARGUS']) => 0.0370157324,
(pp_rp_source = '') => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 139.5) => 0.0046298516,
   (mth_source_ppdid_fseen > 139.5) => 0.1177312146,
   (mth_source_ppdid_fseen = NULL) => 0.0054056572, 0.0054056572), 0.0045222168);

// Tree: 493 
final_score_493 := map(
(NULL < mth_source_ppfla_lseen and mth_source_ppfla_lseen <= 70.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.98628981601979) => -0.0041023143,
   (f_add_input_mobility_index_n > 0.98628981601979) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 30) => 0.0979990661,
      (inq_firstseen_n > 30) => -0.0423477453,
      (inq_firstseen_n = NULL) => 0.0402863587, 0.0402863587),
   (f_add_input_mobility_index_n = NULL) => -0.0567403554, -0.0028828150),
(mth_source_ppfla_lseen > 70.5) => -0.1145140264,
(mth_source_ppfla_lseen = NULL) => -0.0035493870, -0.0035493870);

// Tree: 494 
final_score_494 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 12.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 8.5) => 0.0020350383,
   (inq_adl_lastseen_n > 8.5) => -0.0895737153,
   (inq_adl_lastseen_n = NULL) => 0.0009099979, 0.0009099979),
(inq_adl_lastseen_n > 12.5) => 
   map(
   (phone_subject_title in ['Associate','Mother','Relative','Sister','Son','Subject at Household']) => -0.0522376781,
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Sibling','Spouse','Subject','Wife']) => 0.0426854190,
   (phone_subject_title = '') => 0.0312789143, 0.0312789143),
(inq_adl_lastseen_n = NULL) => 0.0034842978, 0.0034842978);

// Tree: 495 
final_score_495 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 470.5) => -0.0025512166,
(r_pb_order_freq_d > 470.5) => 0.0598230179,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 3.5) => 0.0259755612,
   (f_sourcerisktype_i > 3.5) => 
      map(
      (NULL < mth_source_exp_lseen and mth_source_exp_lseen <= 4.5) => -0.0083469179,
      (mth_source_exp_lseen > 4.5) => -0.0712445826,
      (mth_source_exp_lseen = NULL) => -0.0111488108, -0.0111488108),
   (f_sourcerisktype_i = NULL) => -0.0026171228, -0.0026171228), -0.0013212192);

// Tree: 496 
final_score_496 := map(
(NULL < f_inq_per_addr_i and f_inq_per_addr_i <= 21.5) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 141.5) => -0.0003814216,
   (mth_pp_app_npa_last_change_dt > 141.5) => 0.0489043761,
   (mth_pp_app_npa_last_change_dt = NULL) => 0.0011975017, 0.0011975017),
(f_inq_per_addr_i > 21.5) => 
   map(
   (NULL < _phone_match_code_lns and _phone_match_code_lns <= 0.5) => 0.0161642841,
   (_phone_match_code_lns > 0.5) => -0.1224479935,
   (_phone_match_code_lns = NULL) => -0.0574351553, -0.0574351553),
(f_inq_per_addr_i = NULL) => 0.0004217740, 0.0004217740);

// Tree: 497 
final_score_497 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By SSN','Child','Daughter','Granddaughter','Grandfather','Grandson','Husband','Neighbor','Parent','Spouse','Subject','Wife']) => -0.0078971444,
(phone_subject_title in ['Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Father','Grandchild','Grandmother','Grandparent','Mother','Relative','Sibling','Sister','Son','Subject at Household']) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 21279.5) => 
      map(
      (NULL < subject_ssn_mismatch and subject_ssn_mismatch <= -0.5) => 0.2797072213,
      (subject_ssn_mismatch > -0.5) => 0.0653618007,
      (subject_ssn_mismatch = NULL) => 0.1377566116, 0.1377566116),
   (f_prevaddrmedianincome_d > 21279.5) => 0.0150919731,
   (f_prevaddrmedianincome_d = NULL) => 0.0237716171, 0.0237716171),
(phone_subject_title = '') => 0.0000154111, 0.0000154111);

// Tree: 498 
final_score_498 := map(
(eda_pfrd_address_ind in ['1A','1B','1E','XX']) => -0.0019691881,
(eda_pfrd_address_ind in ['1C','1D']) => 
   map(
   (NULL < inq_firstseen_n and inq_firstseen_n <= 57.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 4.5) => -0.0101747740,
      (f_srchssnsrchcount_i > 4.5) => 0.1055793791,
      (f_srchssnsrchcount_i = NULL) => 0.0088823121, 0.0088823121),
   (inq_firstseen_n > 57.5) => 0.1472461551,
   (inq_firstseen_n = NULL) => 0.0329304360, 0.0329304360),
(eda_pfrd_address_ind = '') => -0.0003469950, -0.0003469950);

// Tree: 499 
final_score_499 := map(
(NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 0.5) => -0.0026899682,
(inq_adl_firstseen_n > 0.5) => 
   map(
   (NULL < inq_num_adls and inq_num_adls <= 1.5) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 0.5) => 0.0061962363,
      (f_rel_homeover300_count_d > 0.5) => 0.0762628609,
      (f_rel_homeover300_count_d = NULL) => 0.0426515649, 0.0426515649),
   (inq_num_adls > 1.5) => -0.0056690278,
   (inq_num_adls = NULL) => 0.0211538318, 0.0211538318),
(inq_adl_firstseen_n = NULL) => 0.0000458852, 0.0000458852);

// Tree: 500 
final_score_500 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0032042594,
(source_utildid > 0.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 6.5) => 0.1235171851,
   (mth_source_utildid_fseen > 6.5) => 
      map(
      (NULL < mth_pp_datevendorlastseen and mth_pp_datevendorlastseen <= 9.5) => -0.0064093117,
      (mth_pp_datevendorlastseen > 9.5) => 0.0564176362,
      (mth_pp_datevendorlastseen = NULL) => 0.0140439667, 0.0140439667),
   (mth_source_utildid_fseen = NULL) => 0.0219929775, 0.0219929775),
(source_utildid = NULL) => -0.0008883911, -0.0008883911);

// Tree: 501 
final_score_501 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 34806) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 155.5) => 
      map(
      (NULL < r_has_paw_source_d and r_has_paw_source_d <= 0.5) => -0.0342015782,
      (r_has_paw_source_d > 0.5) => 0.0247095613,
      (r_has_paw_source_d = NULL) => -0.0072505486, -0.0072505486),
   (f_prevaddrmurderindex_i > 155.5) => 0.0389906547,
   (f_prevaddrmurderindex_i = NULL) => 0.0126851963, 0.0126851963),
(f_curraddrmedianincome_d > 34806) => -0.0107578480,
(f_curraddrmedianincome_d = NULL) => -0.0055373035, -0.0055373035);

// Tree: 502 
final_score_502 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 1.31502298058549) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 76.5) => 
      map(
      (pp_src in ['E1','EM','EQ','PL','SL','UW','VO','ZT']) => -0.0255497221,
      (pp_src in ['CY','E2','EB','EN','FA','FF','KW','LA','LP','MD','NW','TN','UT','VW','ZK']) => 0.0463908620,
      (pp_src = '') => 0.0115549929, 0.0139601708),
   (f_prevaddrmurderindex_i > 76.5) => -0.0064965767,
   (f_prevaddrmurderindex_i = NULL) => 0.0005008872, 0.0005008872),
(f_add_curr_mobility_index_n > 1.31502298058549) => -0.1350547071,
(f_add_curr_mobility_index_n = NULL) => -0.0301389744, -0.0007102184);

// Tree: 503 
final_score_503 := map(
(NULL < inq_lastseen_n and inq_lastseen_n <= 3.5) => 
   map(
   (NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 13.5) => 0.0240304154,
   (mth_eda_dt_first_seen > 13.5) => -0.0177277008,
   (mth_eda_dt_first_seen = NULL) => 0.0086970530, 0.0086970530),
(inq_lastseen_n > 3.5) => 
   map(
   (pp_app_scc in ['8','B','C','S']) => -0.0296866418,
   (pp_app_scc in ['A','J','N','R']) => 0.0216995377,
   (pp_app_scc = '') => 0.0008779482, -0.0093625526),
(inq_lastseen_n = NULL) => -0.0002872889, -0.0002872889);

// Tree: 504 
final_score_504 := map(
(NULL < _inq_adl_ph_industry_day and _inq_adl_ph_industry_day <= 0.5) => 
   map(
   (NULL < eda_num_phs_discon_hhid and eda_num_phs_discon_hhid <= 5.5) => 
      map(
      (NULL < mth_source_edaca_lseen and mth_source_edaca_lseen <= 9.5) => 0.0043841640,
      (mth_source_edaca_lseen > 9.5) => -0.1137511217,
      (mth_source_edaca_lseen = NULL) => 0.0034827980, 0.0034827980),
   (eda_num_phs_discon_hhid > 5.5) => -0.1035154203,
   (eda_num_phs_discon_hhid = NULL) => 0.0023094889, 0.0023094889),
(_inq_adl_ph_industry_day > 0.5) => -0.0845927320,
(_inq_adl_ph_industry_day = NULL) => 0.0016990062, 0.0016990062);

// Tree: 505 
final_score_505 := map(
(NULL < number_of_sources and number_of_sources <= 1.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Father','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Sibling','Sister','Son','Subject']) => -0.0368633256,
   (phone_subject_title in ['Associate','Associate By Property','Associate By Vehicle','Grandchild','Grandfather','Mother','Relative','Spouse','Subject at Household','Wife']) => 0.0341105608,
   (phone_subject_title = '') => -0.0212971923, -0.0212971923),
(number_of_sources > 1.5) => 
   map(
   (NULL < mth_source_ppth_fseen and mth_source_ppth_fseen <= 15.5) => 0.0374584386,
   (mth_source_ppth_fseen > 15.5) => -0.1078729561,
   (mth_source_ppth_fseen = NULL) => 0.0296061666, 0.0296061666),
(number_of_sources = NULL) => -0.0078397770, -0.0078397770);

// Tree: 506 
final_score_506 := map(
(NULL < inq_num and inq_num <= 0.5) => -0.0038995124,
(inq_num > 0.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 27.5) => 
      map(
      (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 9.5) => 0.0548190325,
      (pp_app_ind_ph_cnt > 9.5) => -0.0550084270,
      (pp_app_ind_ph_cnt = NULL) => 0.0429354330, 0.0429354330),
   (inq_adl_lastseen_n > 27.5) => -0.0140367282,
   (inq_adl_lastseen_n = NULL) => 0.0190718401, 0.0190718401),
(inq_num = NULL) => -0.0012476269, -0.0012476269);

// Tree: 507 
final_score_507 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 8.5) => -0.0062082086,
(f_rel_ageover40_count_d > 8.5) => 
   map(
   (NULL < pp_src_cnt and pp_src_cnt <= 1.5) => 
      map(
      (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 0.0368834479,
      (f_vardobcountnew_i > 0.5) => -0.0399319482,
      (f_vardobcountnew_i = NULL) => 0.0183003698, 0.0183003698),
   (pp_src_cnt > 1.5) => 0.1158927331,
   (pp_src_cnt = NULL) => 0.0247621816, 0.0247621816),
(f_rel_ageover40_count_d = NULL) => -0.0024746025, -0.0024746025);

// Tree: 508 
final_score_508 := map(
(pp_rp_source in ['GONG','INFUTOR','INTRADO','THRIVE']) => -0.0333279673,
(pp_rp_source in ['CELL','HEADER','IBEHAVIOR','INQUIRY','OTHER','PCNSR','TARGUS']) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 129) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 90) => -0.0003800066,
      (mth_pp_app_npa_last_change_dt > 90) => 0.1469820522,
      (mth_pp_app_npa_last_change_dt = NULL) => 0.0656030048, 0.0656030048),
   (f_prevaddrlenofres_d > 129) => -0.0529875231,
   (f_prevaddrlenofres_d = NULL) => 0.0268674052, 0.0268674052),
(pp_rp_source = '') => 0.0016000372, 0.0014035765);

// Tree: 509 
final_score_509 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 12.5) => -0.0077576546,
(inq_adl_lastseen_n > 12.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -124646.5) => 0.1494460723,
   (f_addrchangevaluediff_d > -124646.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 7.5) => 0.0602919667,
      (f_inq_count_i > 7.5) => -0.0165296443,
      (f_inq_count_i = NULL) => 0.0068508460, 0.0068508460),
   (f_addrchangevaluediff_d = NULL) => 0.0311056042, 0.0229300417),
(inq_adl_lastseen_n = NULL) => -0.0051204026, -0.0051204026);

// Tree: 510 
final_score_510 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 20.5) => 0.0012542136,
(mth_exp_last_update > 20.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By SSN','Father','Grandfather','Grandparent','Husband','Neighbor','Relative','Sister','Subject','Subject at Household']) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 1.5) => 0.0046360599,
      (f_srchssnsrchcount_i > 1.5) => -0.0830240362,
      (f_srchssnsrchcount_i = NULL) => -0.0445952668, -0.0445952668),
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandmother','Grandson','Mother','Parent','Sibling','Son','Spouse','Wife']) => 0.1027289972,
   (phone_subject_title = '') => -0.0252104952, -0.0252104952),
(mth_exp_last_update = NULL) => -0.0005119594, -0.0005119594);

// Tree: 511 
final_score_511 := map(
(NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 168.5) => -0.0088891846,
(mth_pp_app_npa_effective_dt > 168.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 22691.5) => 0.0149742704,
   (f_addrchangeincomediff_d > 22691.5) => 0.0692268548,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 58807) => -0.0463056141,
      (f_prevaddrmedianincome_d > 58807) => 0.0472701162,
      (f_prevaddrmedianincome_d = NULL) => -0.0146950206, -0.0146950206), 0.0158155539),
(mth_pp_app_npa_effective_dt = NULL) => -0.0039372455, -0.0039372455);

// Tree: 512 
final_score_512 := map(
(NULL < f_rel_count_i and f_rel_count_i <= 66.5) => 
   map(
   (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 115.5) => 0.0019445158,
   (mth_pp_eda_hist_did_dt > 115.5) => 
      map(
      (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 5.5) => -0.0804751464,
      (f_rel_homeover200_count_d > 5.5) => 0.0206867007,
      (f_rel_homeover200_count_d = NULL) => -0.0467545307, -0.0467545307),
   (mth_pp_eda_hist_did_dt = NULL) => 0.0004467017, 0.0004467017),
(f_rel_count_i > 66.5) => 0.1112276297,
(f_rel_count_i = NULL) => 0.0011600784, 0.0011600784);

// Tree: 513 
final_score_513 := map(
(NULL < _pp_app_fb_ph7_did and _pp_app_fb_ph7_did <= 0.5) => 0.0835219837,
(_pp_app_fb_ph7_did > 0.5) => 
   map(
   (NULL < f_inq_per_addr_i and f_inq_per_addr_i <= 14.5) => -0.0015464684,
   (f_inq_per_addr_i > 14.5) => 
      map(
      (NULL < f_estimated_income_d and f_estimated_income_d <= 75500) => -0.0865098875,
      (f_estimated_income_d > 75500) => 0.0377469250,
      (f_estimated_income_d = NULL) => -0.0567509030, -0.0567509030),
   (f_inq_per_addr_i = NULL) => -0.0030973012, -0.0030973012),
(_pp_app_fb_ph7_did = NULL) => -0.0023975318, -0.0023975318);

// Tree: 514 
final_score_514 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 3.5) => -0.0105391474,
(f_rel_ageover40_count_d > 3.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 7.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 46.5) => -0.0304879722,
      (f_curraddrmurderindex_i > 46.5) => 0.0610619573,
      (f_curraddrmurderindex_i = NULL) => 0.0417246784, 0.0417246784),
   (f_rel_ageover30_count_d > 7.5) => 0.0016188872,
   (f_rel_ageover30_count_d = NULL) => 0.0079845523, 0.0079845523),
(f_rel_ageover40_count_d = NULL) => -0.0022333946, -0.0022333946);

// Tree: 515 
final_score_515 := map(
(pp_src in ['CY','E1','E2','EM','LP','NW','SL','ZK','ZT']) => -0.1008397933,
(pp_src in ['EB','EN','EQ','FA','FF','KW','LA','MD','PL','TN','UT','UW','VO','VW']) => 
   map(
   (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 129.5) => -0.0273675649,
   (mth_pp_app_npa_effective_dt > 129.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 178.5) => 0.0201468282,
      (f_curraddrcartheftindex_i > 178.5) => -0.0687996226,
      (f_curraddrcartheftindex_i = NULL) => 0.0081797962, 0.0081797962),
   (mth_pp_app_npa_effective_dt = NULL) => -0.0054665453, -0.0054665453),
(pp_src = '') => -0.0015946048, -0.0031093996);

// Tree: 516 
final_score_516 := map(
(NULL < mth_source_edadid_fseen and mth_source_edadid_fseen <= 4.5) => 0.0039548422,
(mth_source_edadid_fseen > 4.5) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 3.5) => 0.1222965593,
   (f_rel_educationover12_count_d > 3.5) => 
      map(
      (NULL < mth_source_edadid_fseen and mth_source_edadid_fseen <= 26.5) => 0.0836403389,
      (mth_source_edadid_fseen > 26.5) => -0.0311648793,
      (mth_source_edadid_fseen = NULL) => 0.0197698302, 0.0197698302),
   (f_rel_educationover12_count_d = NULL) => 0.0498647407, 0.0498647407),
(mth_source_edadid_fseen = NULL) => 0.0050352648, 0.0050352648);

// Tree: 517 
final_score_517 := map(
(eda_pfrd_address_ind in ['1A','1B','1E','XX']) => -0.0001941416,
(eda_pfrd_address_ind in ['1C','1D']) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 2) => -0.0240965225,
   (r_pb_order_freq_d > 2) => 0.0989641362,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 91) => -0.0564687870,
      (f_prevaddrcartheftindex_i > 91) => 0.1269730282,
      (f_prevaddrcartheftindex_i = NULL) => 0.0619227391, 0.0619227391), 0.0419434282),
(eda_pfrd_address_ind = '') => 0.0016312771, 0.0016312771);

// Tree: 518 
final_score_518 := map(
(NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 15.5) => -0.0051072172,
(f_rel_homeover300_count_d > 15.5) => 
   map(
   (phone_subject_title in ['Associate By Shared Associates','Associate By SSN','Daughter','Grandson','Husband','Parent','Relative','Sibling','Sister','Son','Subject at Household','Wife']) => -0.0989850651,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Mother','Neighbor','Spouse','Subject']) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 111) => 0.0391855664,
      (f_curraddrmurderindex_i > 111) => 0.1670539418,
      (f_curraddrmurderindex_i = NULL) => 0.0693432021, 0.0693432021),
   (phone_subject_title = '') => 0.0275595897, 0.0275595897),
(f_rel_homeover300_count_d = NULL) => -0.0040239576, -0.0040239576);

// Tree: 519 
final_score_519 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0017766982,
(source_utildid > 0.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 4.5) => 0.1790870556,
   (mth_source_utildid_fseen > 4.5) => 
      map(
      (NULL < source_pp_any_clean and source_pp_any_clean <= 0.5) => -0.0331764986,
      (source_pp_any_clean > 0.5) => 0.0357850228,
      (source_pp_any_clean = NULL) => 0.0133677789, 0.0133677789),
   (mth_source_utildid_fseen = NULL) => 0.0248406519, 0.0248406519),
(source_utildid = NULL) => 0.0006541100, 0.0006541100);

// Tree: 520 
final_score_520 := map(
(NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 3.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By SSN','Associate By Vehicle','Brother','Grandfather','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Spouse','Wife']) => -0.0335980746,
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Child','Daughter','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Son','Subject','Subject at Household']) => 
      map(
      (NULL < f_college_income_d and f_college_income_d <= 5.5) => -0.0112497150,
      (f_college_income_d > 5.5) => -0.0385916441,
      (f_college_income_d = NULL) => 0.0561502043, 0.0427992581),
   (phone_subject_title = '') => 0.0163597890, 0.0163597890),
(f_corrssnnamecount_d > 3.5) => -0.0028316429,
(f_corrssnnamecount_d = NULL) => -0.0005394578, -0.0005394578);

// Tree: 521 
final_score_521 := map(
(NULL < mth_source_ppth_fseen and mth_source_ppth_fseen <= 72.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -2197.5) => 
      map(
      (NULL < mth_source_ppth_fseen and mth_source_ppth_fseen <= 11.5) => 0.0098423567,
      (mth_source_ppth_fseen > 11.5) => 0.1334283777,
      (mth_source_ppth_fseen = NULL) => 0.0141319701, 0.0141319701),
   (f_addrchangevaluediff_d > -2197.5) => -0.0054062328,
   (f_addrchangevaluediff_d = NULL) => 0.0014961007, 0.0026922644),
(mth_source_ppth_fseen > 72.5) => -0.1113470894,
(mth_source_ppth_fseen = NULL) => 0.0007962817, 0.0007962817);

// Tree: 522 
final_score_522 := map(
(NULL < eda_days_in_service and eda_days_in_service <= 535.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandparent','Husband','Mother','Neighbor','Parent','Sibling','Sister','Son','Spouse','Subject','Subject at Household']) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 197.5) => 0.0064466186,
      (f_prevaddrmurderindex_i > 197.5) => -0.0865871788,
      (f_prevaddrmurderindex_i = NULL) => 0.0052200907, 0.0052200907),
   (phone_subject_title in ['Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandson','Relative','Wife']) => 0.1005185523,
   (phone_subject_title = '') => 0.0076360614, 0.0076360614),
(eda_days_in_service > 535.5) => -0.0162996656,
(eda_days_in_service = NULL) => -0.0001603550, -0.0001603550);

// Tree: 523 
final_score_523 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 161.5) => 0.0081901660,
(f_prevaddrcartheftindex_i > 161.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 1.09089958638651) => 
      map(
      (NULL < mth_source_md_fseen and mth_source_md_fseen <= 8.5) => -0.0117919056,
      (mth_source_md_fseen > 8.5) => -0.1011264809,
      (mth_source_md_fseen = NULL) => -0.0150342302, -0.0150342302),
   (f_add_input_mobility_index_n > 1.09089958638651) => 0.0969604397,
   (f_add_input_mobility_index_n = NULL) => -0.0121679171, -0.0121679171),
(f_prevaddrcartheftindex_i = NULL) => 0.0030392683, 0.0030392683);

// Tree: 524 
final_score_524 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 177.5) => -0.0033395643,
(f_curraddrcrimeindex_i > 177.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -1176) => 0.0151212233,
   (f_addrchangeincomediff_d > -1176) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Mother','Neighbor','Parent','Sibling','Subject','Subject at Household']) => 0.0318447743,
      (phone_subject_title in ['Associate By Business','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Relative','Sister','Son','Spouse','Wife']) => 0.2418955688,
      (phone_subject_title = '') => 0.0607406508, 0.0607406508),
   (f_addrchangeincomediff_d = NULL) => -0.0230160278, 0.0221787774),
(f_curraddrcrimeindex_i = NULL) => -0.0001721823, -0.0001721823);

// Tree: 525 
final_score_525 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 52.5) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 168.5) => 0.0117754927,
   (f_fp_prevaddrcrimeindex_i > 168.5) => 0.0739834594,
   (f_fp_prevaddrcrimeindex_i = NULL) => 0.0220382283, 0.0220382283),
(f_mos_inq_banko_cm_fseen_d > 52.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -408427.5) => 0.1095308934,
   (f_addrchangevaluediff_d > -408427.5) => -0.0034116697,
   (f_addrchangevaluediff_d = NULL) => -0.0084942284, -0.0038274625),
(f_mos_inq_banko_cm_fseen_d = NULL) => 0.0021392133, 0.0021392133);

// Tree: 526 
final_score_526 := map(
(NULL < mth_source_sx_fseen and mth_source_sx_fseen <= 25.5) => 0.0005750222,
(mth_source_sx_fseen > 25.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 0.5) => 0.0064889483,
   (f_srchfraudsrchcount_i > 0.5) => 
      map(
      (NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 4.5) => -0.0360178103,
      (mth_source_cr_fseen > 4.5) => -0.1372567173,
      (mth_source_cr_fseen = NULL) => -0.0659701496, -0.0659701496),
   (f_srchfraudsrchcount_i = NULL) => -0.0380404610, -0.0380404610),
(mth_source_sx_fseen = NULL) => -0.0006683050, -0.0006683050);

// Tree: 527 
final_score_527 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -2100.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Granddaughter','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household']) => 
      map(
      (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 2.5) => -0.0047837193,
      (pp_app_ind_ph_cnt > 2.5) => 0.0374502929,
      (pp_app_ind_ph_cnt = NULL) => 0.0091688682, 0.0091688682),
   (phone_subject_title in ['Associate By Business','Father','Grandchild','Grandparent','Wife']) => 0.1621585273,
   (phone_subject_title = '') => 0.0133126835, 0.0133126835),
(f_addrchangevaluediff_d > -2100.5) => -0.0059684412,
(f_addrchangevaluediff_d = NULL) => 0.0002982645, 0.0018358031);

// Tree: 528 
final_score_528 := map(
(NULL < f_acc_damage_amt_last_i and f_acc_damage_amt_last_i <= 2100) => 
   map(
   (pp_app_scc in ['A','B','C','N','R']) => -0.0044352650,
   (pp_app_scc in ['8','J','S']) => 
      map(
      (NULL < mth_pp_datevendorlastseen and mth_pp_datevendorlastseen <= 1.5) => 0.1485210166,
      (mth_pp_datevendorlastseen > 1.5) => 0.0090456386,
      (mth_pp_datevendorlastseen = NULL) => 0.0217619176, 0.0217619176),
   (pp_app_scc = '') => 0.0004929925, 0.0003376875),
(f_acc_damage_amt_last_i > 2100) => -0.0737980056,
(f_acc_damage_amt_last_i = NULL) => -0.0005651359, -0.0005651359);

// Tree: 529 
final_score_529 := map(
(NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 49.5) => 
   map(
   (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 5.5) => 0.0015801922,
   (f_rel_bankrupt_count_i > 5.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 79258.5) => -0.0987752826,
      (f_prevaddrmedianvalue_d > 79258.5) => -0.0122618950,
      (f_prevaddrmedianvalue_d = NULL) => -0.0274882512, -0.0274882512),
   (f_rel_bankrupt_count_i = NULL) => -0.0014330631, -0.0014330631),
(f_rel_homeover50_count_d > 49.5) => 0.0908924941,
(f_rel_homeover50_count_d = NULL) => -0.0006952399, -0.0006952399);

// Tree: 530 
final_score_530 := map(
(NULL < eda_avg_days_connected_ind and eda_avg_days_connected_ind <= 631.5) => 
   map(
   (NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0045822929,
   (_pp_rule_high_vend_conf > 0.5) => 
      map(
      (NULL < pp_app_best_nm_match_fl and pp_app_best_nm_match_fl <= 0.5) => 0.0575033869,
      (pp_app_best_nm_match_fl > 0.5) => 0.0065078367,
      (pp_app_best_nm_match_fl = NULL) => 0.0147424549, 0.0147424549),
   (_pp_rule_high_vend_conf = NULL) => -0.0014180201, -0.0014180201),
(eda_avg_days_connected_ind > 631.5) => 0.0688333342,
(eda_avg_days_connected_ind = NULL) => -0.0005379247, -0.0005379247);

// Tree: 531 
final_score_531 := map(
(NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 158.5) => 
   map(
   (NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 141.5) => -0.0048410340,
   (r_mos_since_paw_fseen_d > 141.5) => 0.0218040128,
   (r_mos_since_paw_fseen_d = NULL) => -0.0028018722, -0.0028018722),
(mth_source_cr_fseen > 158.5) => 
   map(
   (NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 82.5) => 0.1751706827,
   (eda_max_days_interrupt > 82.5) => 0.0103146724,
   (eda_max_days_interrupt = NULL) => 0.0949310317, 0.0949310317),
(mth_source_cr_fseen = NULL) => -0.0015088365, -0.0015088365);

// Tree: 532 
final_score_532 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.2004892900509) => -0.0195556642,
(f_add_input_mobility_index_n > 0.2004892900509) => 
   map(
   (NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 8.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Child','Father','Grandfather','Grandmother','Mother','Neighbor','Parent','Sibling','Sister','Son','Subject','Subject at Household']) => 0.0089461330,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Relative','Spouse','Wife']) => 0.1723708546,
      (phone_subject_title = '') => 0.0110228890, 0.0110228890),
   (mth_eda_dt_first_seen > 8.5) => -0.0064677642,
   (mth_eda_dt_first_seen = NULL) => 0.0027864061, 0.0027864061),
(f_add_input_mobility_index_n = NULL) => -0.0631663261, 0.0003333017);

// Tree: 533 
final_score_533 := map(
(NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 37.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 10.5) => 0.1303271470,
   (f_prevaddrageoldest_d > 10.5) => 0.0198328226,
   (f_prevaddrageoldest_d = NULL) => 0.0301151600, 0.0301151600),
(f_mos_acc_lseen_d > 37.5) => 
   map(
   (NULL < _inq_adl_ph_industry_day and _inq_adl_ph_industry_day <= 0.5) => -0.0017989737,
   (_inq_adl_ph_industry_day > 0.5) => -0.0709670132,
   (_inq_adl_ph_industry_day = NULL) => -0.0022563993, -0.0022563993),
(f_mos_acc_lseen_d = NULL) => 0.0003098238, 0.0003098238);

// Tree: 534 
final_score_534 := map(
(NULL < number_of_sources and number_of_sources <= 4.5) => 
   map(
   (NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 25.5) => -0.0045177059,
   (mth_source_ppla_lseen > 25.5) => -0.0565751546,
   (mth_source_ppla_lseen = NULL) => -0.0053340246, -0.0053340246),
(number_of_sources > 4.5) => 
   map(
   (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 99) => 0.0903189985,
   (eda_avg_days_interrupt > 99) => -0.0088647126,
   (eda_avg_days_interrupt = NULL) => 0.0484178585, 0.0484178585),
(number_of_sources = NULL) => -0.0041571598, -0.0041571598);

// Tree: 535 
final_score_535 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 177.5) => 0.0011329774,
(f_curraddrcrimeindex_i > 177.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By SSN','Child','Daughter','Father','Grandson','Mother','Neighbor','Sister','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 2.5) => 0.1540918524,
      (f_corrssnnamecount_d > 2.5) => 0.0036264661,
      (f_corrssnnamecount_d = NULL) => 0.0140731111, 0.0140731111),
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Vehicle','Brother','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Husband','Parent','Relative','Sibling','Son','Spouse']) => 0.1049109157,
   (phone_subject_title = '') => 0.0263841398, 0.0263841398),
(f_curraddrcrimeindex_i = NULL) => 0.0041877205, 0.0041877205);

// Tree: 536 
final_score_536 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 15.5) => -0.1216985437,
(f_mos_inq_banko_cm_fseen_d > 15.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 23.5) => 
      map(
      (NULL < mth_exp_last_update and mth_exp_last_update <= 3.5) => -0.0059334425,
      (mth_exp_last_update > 3.5) => -0.0459176599,
      (mth_exp_last_update = NULL) => -0.0148081638, -0.0148081638),
   (f_prevaddrageoldest_d > 23.5) => 0.0049976787,
   (f_prevaddrageoldest_d = NULL) => 0.0010913441, 0.0010913441),
(f_mos_inq_banko_cm_fseen_d = NULL) => -0.0001739381, -0.0001739381);

// Tree: 537 
final_score_537 := map(
(NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 11.5) => 0.0001734408,
(f_rel_homeover300_count_d > 11.5) => 
   map(
   (pp_source in ['GONG','IBEHAVIOR','INQUIRY','INTRADO','PCNSR']) => 0.0060919541,
   (pp_source in ['CELL','HEADER','INFUTOR','OTHER','TARGUS','THRIVE']) => 
      map(
      (NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 6.5) => 0.1719064295,
      (mth_pp_first_build_date > 6.5) => 0.0130420869,
      (mth_pp_first_build_date = NULL) => 0.0916878011, 0.0916878011),
   (pp_source = '') => 0.0144755905, 0.0279024079),
(f_rel_homeover300_count_d = NULL) => 0.0018478638, 0.0018478638);

// Tree: 538 
final_score_538 := map(
(NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 38.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Vehicle','Brother','Child','Daughter','Grandfather','Grandparent','Mother','Neighbor','Parent','Relative','Sibling','Sister','Subject','Subject at Household']) => 
      map(
      (NULL < inq_lastseen_n and inq_lastseen_n <= 7.5) => 0.0454121301,
      (inq_lastseen_n > 7.5) => -0.0241763298,
      (inq_lastseen_n = NULL) => 0.0134123974, 0.0134123974),
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Father','Grandchild','Granddaughter','Grandmother','Grandson','Husband','Son','Spouse','Wife']) => 0.1954940463,
   (phone_subject_title = '') => 0.0333315680, 0.0333315680),
(f_mos_acc_lseen_d > 38.5) => -0.0004187959,
(f_mos_acc_lseen_d = NULL) => 0.0023990038, 0.0023990038);

// Tree: 539 
final_score_539 := map(
(NULL < mth_source_md_fseen and mth_source_md_fseen <= 10.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 11.5) => -0.0019754775,
   (f_corraddrnamecount_d > 11.5) => 0.0228528146,
   (f_corraddrnamecount_d = NULL) => 0.0005118578, 0.0005118578),
(mth_source_md_fseen > 10.5) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 37787.5) => 0.0144182066,
   (f_prevaddrmedianincome_d > 37787.5) => -0.0811674046,
   (f_prevaddrmedianincome_d = NULL) => -0.0526655133, -0.0526655133),
(mth_source_md_fseen = NULL) => -0.0012003278, -0.0012003278);

// Tree: 540 
final_score_540 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 156722.5) => -0.0075624143,
(f_curraddrmedianvalue_d > 156722.5) => 
   map(
   (NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 15.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 31192) => 0.0717326005,
      (f_curraddrmedianincome_d > 31192) => 0.0099420716,
      (f_curraddrmedianincome_d = NULL) => 0.0126236700, 0.0126236700),
   (mth_source_cr_fseen > 15.5) => -0.0605257677,
   (mth_source_cr_fseen = NULL) => 0.0086052694, 0.0086052694),
(f_curraddrmedianvalue_d = NULL) => 0.0000538142, 0.0000538142);

// Tree: 541 
final_score_541 := map(
(NULL < pp_total_source_conf and pp_total_source_conf <= 14.5) => -0.0019869776,
(pp_total_source_conf > 14.5) => 
   map(
   (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 15.5) => 0.0792520964,
   (mth_pp_datevendorfirstseen > 15.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 175.5) => -0.0133840177,
      (f_prevaddrlenofres_d > 175.5) => 0.0658218319,
      (f_prevaddrlenofres_d = NULL) => 0.0090704562, 0.0090704562),
   (mth_pp_datevendorfirstseen = NULL) => 0.0233888125, 0.0233888125),
(pp_total_source_conf = NULL) => -0.0000647043, -0.0000647043);

// Tree: 542 
final_score_542 := map(
(NULL < inq_num and inq_num <= 0.5) => -0.0086269308,
(inq_num > 0.5) => 
   map(
   (NULL < inq_firstseen_n and inq_firstseen_n <= 9.5) => 0.1164720148,
   (inq_firstseen_n > 9.5) => 
      map(
      (NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 4.5) => 0.0319514692,
      (f_inq_per_ssn_i > 4.5) => -0.0606649067,
      (f_inq_per_ssn_i = NULL) => 0.0189578215, 0.0189578215),
   (inq_firstseen_n = NULL) => 0.0276694642, 0.0276694642),
(inq_num = NULL) => -0.0042030288, -0.0042030288);

// Tree: 543 
final_score_543 := map(
(NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 3.5) => -0.0067823038,
(f_crim_rel_under500miles_cnt_i > 3.5) => 
   map(
   (NULL < f_college_income_d and f_college_income_d <= 3.5) => 0.0622048743,
   (f_college_income_d > 3.5) => -0.0244949799,
   (f_college_income_d = NULL) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.344892249089755) => -0.0123162149,
      (f_add_input_mobility_index_n > 0.344892249089755) => 0.0269551960,
      (f_add_input_mobility_index_n = NULL) => 0.0104794692, 0.0104794692), 0.0086910281),
(f_crim_rel_under500miles_cnt_i = NULL) => -0.0020908245, -0.0020908245);

// Tree: 544 
final_score_544 := map(
(NULL < pp_total_source_conf and pp_total_source_conf <= 23.5) => 
   map(
   (NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 86.5) => 0.0001333415,
   (mth_source_ppfla_fseen > 86.5) => -0.0806644078,
   (mth_source_ppfla_fseen = NULL) => -0.0007253878, -0.0007253878),
(pp_total_source_conf > 23.5) => 
   map(
   (NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 11.5) => -0.0062498798,
   (mth_pp_orig_lastseen > 11.5) => 0.0994711491,
   (mth_pp_orig_lastseen = NULL) => 0.0538908253, 0.0538908253),
(pp_total_source_conf = NULL) => 0.0003425091, 0.0003425091);

// Tree: 545 
final_score_545 := map(
(NULL < source_rel and source_rel <= 0.5) => -0.0017490834,
(source_rel > 0.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 6.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 32.5) => -0.0189344534,
      (f_mos_inq_banko_om_fseen_d > 32.5) => 0.0660598102,
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0486429529, 0.0486429529),
   (f_corraddrnamecount_d > 6.5) => -0.0341081647,
   (f_corraddrnamecount_d = NULL) => 0.0242481148, 0.0242481148),
(source_rel = NULL) => -0.0006959244, -0.0006959244);

// Tree: 546 
final_score_546 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 6.5) => -0.0157860742,
(f_corraddrnamecount_d > 6.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Vehicle','Brother','Child','Daughter','Father','Granddaughter','Grandmother','Husband','Neighbor','Sister','Son']) => -0.0306061865,
   (phone_subject_title in ['Associate','Associate By Property','Associate By Shared Associates','Associate By SSN','Grandchild','Grandfather','Grandparent','Grandson','Mother','Parent','Relative','Sibling','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 20.5) => 0.0334306341,
      (f_inq_count_i > 20.5) => -0.0389825426,
      (f_inq_count_i = NULL) => 0.0234027524, 0.0234027524),
   (phone_subject_title = '') => 0.0066203138, 0.0066203138),
(f_corraddrnamecount_d = NULL) => -0.0069636081, -0.0069636081);

// Tree: 547 
final_score_547 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 60.5) => 
   map(
   (NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 3.5) => 
      map(
      (phone_subject_title in ['Associate By Business','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Father','Granddaughter','Grandmother','Grandson','Husband','Neighbor','Sibling','Sister','Son','Wife']) => -0.0556943526,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By SSN','Brother','Grandchild','Grandfather','Grandparent','Mother','Parent','Relative','Spouse','Subject','Subject at Household']) => 0.0377252289,
      (phone_subject_title = '') => 0.0125167704, 0.0125167704),
   (f_componentcharrisktype_i > 3.5) => -0.0058392477,
   (f_componentcharrisktype_i = NULL) => -0.0008582177, -0.0008582177),
(mth_exp_last_update > 60.5) => -0.0688078524,
(mth_exp_last_update = NULL) => -0.0023141108, -0.0023141108);

// Tree: 548 
final_score_548 := map(
(NULL < source_sx and source_sx <= 0.5) => -0.0066448604,
(source_sx > 0.5) => 
   map(
   (NULL < r_has_paw_source_d and r_has_paw_source_d <= 0.5) => -0.0104380368,
   (r_has_paw_source_d > 0.5) => 
      map(
      (NULL < inq_lastseen_n and inq_lastseen_n <= 29.5) => 0.0910077346,
      (inq_lastseen_n > 29.5) => -0.0159019053,
      (inq_lastseen_n = NULL) => 0.0670727406, 0.0670727406),
   (r_has_paw_source_d = NULL) => 0.0346224586, 0.0346224586),
(source_sx = NULL) => -0.0044174591, -0.0044174591);

// Tree: 549 
final_score_549 := map(
(NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => -0.0022300317,
(f_prevaddrstatus_i > 2.5) => -0.0119044355,
(f_prevaddrstatus_i = NULL) => 
   map(
   (NULL < mth_pp_datevendorlastseen and mth_pp_datevendorlastseen <= 9.5) => 0.0061101966,
   (mth_pp_datevendorlastseen > 9.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Subject at Household']) => -0.0309987375,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => 0.0737321890,
      (phone_subject_title = '') => 0.0470222883, 0.0470222883),
   (mth_pp_datevendorlastseen = NULL) => 0.0114668764, 0.0114668764), -0.0009700890);

// Tree: 550 
final_score_550 := map(
(NULL < pp_app_company_type and pp_app_company_type <= 7.5) => -0.0052823478,
(pp_app_company_type > 7.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 13.5) => 
      map(
      (NULL < pk_phone_match_level and pk_phone_match_level <= 2.5) => 0.0060908898,
      (pk_phone_match_level > 2.5) => 0.0845186153,
      (pk_phone_match_level = NULL) => 0.0519603164, 0.0519603164),
   (f_rel_under500miles_cnt_d > 13.5) => -0.0163527913,
   (f_rel_under500miles_cnt_d = NULL) => 0.0260149398, 0.0260149398),
(pp_app_company_type = NULL) => -0.0027063036, -0.0027063036);

// Tree: 551 
final_score_551 := map(
(pp_origphonetype in ['L']) => -0.0235185446,
(pp_origphonetype in ['O','V','W']) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 57636.5) => -0.0290538328,
   (f_curraddrmedianincome_d > 57636.5) => 
      map(
      (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= -498.5) => 0.0542259608,
      (mth_pp_eda_hist_did_dt > -498.5) => -0.0134214040,
      (mth_pp_eda_hist_did_dt = NULL) => 0.0023894529, 0.0023894529),
   (f_curraddrmedianincome_d = NULL) => -0.0159361308, -0.0159361308),
(pp_origphonetype = '') => 0.0019104724, -0.0035715743);

// Tree: 552 
final_score_552 := map(
(NULL < r_paw_dead_business_ct_i and r_paw_dead_business_ct_i <= 0.5) => 
   map(
   (NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 4.5) => 0.0053294013,
   (f_inq_per_ssn_i > 4.5) => -0.0301762003,
   (f_inq_per_ssn_i = NULL) => 0.0030459107, 0.0030459107),
(r_paw_dead_business_ct_i > 0.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -73) => 0.0533106258,
   (f_addrchangecrimediff_i > -73) => -0.0398555545,
   (f_addrchangecrimediff_i = NULL) => -0.0281447503, -0.0262454205),
(r_paw_dead_business_ct_i = NULL) => 0.0010568027, 0.0010568027);

// Tree: 553 
final_score_553 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 0.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 6) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 49476.5) => -0.0370122418,
      (f_curraddrmedianincome_d > 49476.5) => 0.0767240998,
      (f_curraddrmedianincome_d = NULL) => 0.0191397052, 0.0191397052),
   (mth_source_ppdid_fseen > 6) => 0.1278527356,
   (mth_source_ppdid_fseen = NULL) => 0.0319436843, 0.0319436843),
(f_inq_count_i > 0.5) => -0.0024355744,
(f_inq_count_i = NULL) => -0.0006238088, -0.0006238088);

// Tree: 554 
final_score_554 := map(
(exp_source in ['P']) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 35) => -0.0975426643,
   (f_curraddrburglaryindex_i > 35) => -0.0019474932,
   (f_curraddrburglaryindex_i = NULL) => -0.0213164495, -0.0213164495),
(exp_source in ['S']) => 
   map(
   (NULL < mth_pp_app_fb_ph_dt and mth_pp_app_fb_ph_dt <= 3.5) => 0.0106982420,
   (mth_pp_app_fb_ph_dt > 3.5) => -0.0881445548,
   (mth_pp_app_fb_ph_dt = NULL) => 0.0077708421, 0.0077708421),
(exp_source = '') => -0.0035498522, -0.0022222128);

// Tree: 555 
final_score_555 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -63879) => 0.0702516757,
(f_addrchangeincomediff_d > -63879) => 0.0008883122,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 24.5) => -0.0096304140,
   (f_rel_under500miles_cnt_d > 24.5) => 
      map(
      (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 3.5) => 0.1503863652,
      (f_rel_bankrupt_count_i > 3.5) => 0.0240427312,
      (f_rel_bankrupt_count_i = NULL) => 0.0667676316, 0.0667676316),
   (f_rel_under500miles_cnt_d = NULL) => -0.0023157075, -0.0023157075), 0.0007642002);

// Tree: 556 
final_score_556 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 46.5) => 
   map(
   (NULL < mth_source_ppfla_lseen and mth_source_ppfla_lseen <= 24) => 
      map(
      (NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 50.5) => 0.0029631393,
      (mth_source_ppth_lseen > 50.5) => -0.1074996074,
      (mth_source_ppth_lseen = NULL) => 0.0011777163, 0.0011777163),
   (mth_source_ppfla_lseen > 24) => 0.0610936775,
   (mth_source_ppfla_lseen = NULL) => 0.0018989747, 0.0018989747),
(mth_source_ppdid_lseen > 46.5) => -0.0385299902,
(mth_source_ppdid_lseen = NULL) => 0.0000055681, 0.0000055681);

// Tree: 557 
final_score_557 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 119.5) => -0.0080025794,
(f_curraddrcrimeindex_i > 119.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 294.5) => 0.0084535474,
   (r_pb_order_freq_d > 294.5) => 0.0792119320,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 151.5) => -0.0246635877,
      (f_prevaddrcartheftindex_i > 151.5) => 0.0309134546,
      (f_prevaddrcartheftindex_i = NULL) => 0.0007725672, 0.0007725672), 0.0084386408),
(f_curraddrcrimeindex_i = NULL) => -0.0013652620, -0.0013652620);

// Tree: 558 
final_score_558 := map(
(pp_rp_source in ['CELL','GONG','HEADER','INQUIRY','THRIVE']) => -0.0510490972,
(pp_rp_source in ['IBEHAVIOR','INFUTOR','INTRADO','OTHER','PCNSR','TARGUS']) => 0.0211322937,
(pp_rp_source = '') => 
   map(
   (NULL < mth_source_paw_lseen and mth_source_paw_lseen <= 1.5) => -0.0037411125,
   (mth_source_paw_lseen > 1.5) => 
      map(
      (NULL < mth_source_paw_lseen and mth_source_paw_lseen <= 49) => 0.1606986132,
      (mth_source_paw_lseen > 49) => 0.0115999659,
      (mth_source_paw_lseen = NULL) => 0.0693901392, 0.0693901392),
   (mth_source_paw_lseen = NULL) => -0.0025878201, -0.0025878201), -0.0026754490);

// Tree: 559 
final_score_559 := map(
(NULL < mth_source_sx_fseen and mth_source_sx_fseen <= 25.5) => 0.0019873335,
(mth_source_sx_fseen > 25.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 1.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 109) => -0.0506522446,
      (f_prevaddrlenofres_d > 109) => 0.0645211428,
      (f_prevaddrlenofres_d = NULL) => 0.0138448523, 0.0138448523),
   (f_util_adl_count_n > 1.5) => -0.0985828232,
   (f_util_adl_count_n = NULL) => -0.0358908108, -0.0358908108),
(mth_source_sx_fseen = NULL) => 0.0007943560, 0.0007943560);

// Tree: 560 
final_score_560 := map(
(NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 3.5) => -0.0022943769,
(f_crim_rel_under500miles_cnt_i > 3.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Vehicle','Child','Granddaughter','Grandfather','Grandson','Neighbor','Parent','Relative','Sister']) => -0.0159436176,
   (phone_subject_title in ['Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Daughter','Father','Grandchild','Grandmother','Grandparent','Husband','Mother','Sibling','Son','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 16.5) => 0.0300330892,
      (mth_source_ppdid_lseen > 16.5) => -0.0196114926,
      (mth_source_ppdid_lseen = NULL) => 0.0191984172, 0.0191984172),
   (phone_subject_title = '') => 0.0074124854, 0.0074124854),
(f_crim_rel_under500miles_cnt_i = NULL) => 0.0006788346, 0.0006788346);

// Tree: 561 
final_score_561 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0051387457,
(source_utildid > 0.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 8.5) => 0.1338415358,
   (mth_source_utildid_fseen > 8.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.20507540516592) => -0.0869677392,
      (f_add_curr_mobility_index_n > 0.20507540516592) => 0.0182573152,
      (f_add_curr_mobility_index_n = NULL) => 0.0087054069, 0.0087054069),
   (mth_source_utildid_fseen = NULL) => 0.0212843650, 0.0212843650),
(source_utildid = NULL) => -0.0027689877, -0.0027689877);

// Tree: 562 
final_score_562 := map(
(NULL < inq_num and inq_num <= 2.5) => -0.0009994885,
(inq_num > 2.5) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 160) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 13373) => 0.0063734561,
      (f_addrchangevaluediff_d > 13373) => 0.1017244172,
      (f_addrchangevaluediff_d = NULL) => 0.0691293341, 0.0491031574),
   (f_fp_prevaddrcrimeindex_i > 160) => -0.0632150634,
   (f_fp_prevaddrcrimeindex_i = NULL) => 0.0275298406, 0.0275298406),
(inq_num = NULL) => 0.0000961233, 0.0000961233);

// Tree: 563 
final_score_563 := map(
(NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 6150) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -402804.5) => 0.0613671572,
   (f_addrchangevaluediff_d > -402804.5) => 0.0016421742,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < f_prevaddrdwelltype_sfd_n and f_prevaddrdwelltype_sfd_n <= 0.5) => 0.0090769526,
      (f_prevaddrdwelltype_sfd_n > 0.5) => -0.0227833822,
      (f_prevaddrdwelltype_sfd_n = NULL) => -0.0073753913, -0.0073753913), -0.0000483045),
(f_acc_damage_amt_total_i > 6150) => -0.0794843019,
(f_acc_damage_amt_total_i = NULL) => -0.0006715144, -0.0006715144);

// Tree: 564 
final_score_564 := map(
(NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 0.5) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 90803.5) => 0.0043997262,
   (f_prevaddrmedianincome_d > 90803.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Brother','Child','Daughter','Father','Grandfather','Grandmother','Husband','Mother','Neighbor','Relative','Sister','Son','Spouse','Subject at Household','Wife']) => 0.0049961138,
      (phone_subject_title in ['Associate','Associate By Property','Associate By SSN','Associate By Vehicle','Grandchild','Granddaughter','Grandparent','Grandson','Parent','Sibling','Subject']) => 0.0987362894,
      (phone_subject_title = '') => 0.0457193048, 0.0457193048),
   (f_prevaddrmedianincome_d = NULL) => 0.0076505787, 0.0076505787),
(f_inq_per_ssn_i > 0.5) => -0.0064976626,
(f_inq_per_ssn_i = NULL) => 0.0012084161, 0.0012084161);

// Tree: 565 
final_score_565 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -64103.5) => 0.0682913373,
(f_addrchangeincomediff_d > -64103.5) => 0.0013484615,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < inq_lastseen_n and inq_lastseen_n <= 53.5) => 
      map(
      (pp_src in ['CY','E1','E2','EN','EQ','LP','VO','ZK','ZT']) => -0.0586807931,
      (pp_src in ['EB','EM','FA','FF','KW','LA','MD','NW','PL','SL','TN','UT','UW','VW']) => 0.0294046216,
      (pp_src = '') => -0.0104872668, -0.0054576962),
   (inq_lastseen_n > 53.5) => 0.0943052853,
   (inq_lastseen_n = NULL) => -0.0002769899, -0.0002769899), 0.0017181261);

// Tree: 566 
final_score_566 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0056395038,
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 5.5) => -0.0008865804,
   (mth_source_ppdid_lseen > 5.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 43.5) => 0.0224734963,
      (f_mos_inq_banko_cm_fseen_d > 43.5) => -0.0965666441,
      (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0746159799, -0.0746159799),
   (mth_source_ppdid_lseen = NULL) => -0.0219095234, -0.0219095234),
(f_varrisktype_i = NULL) => 0.0024491071, 0.0024491071);

// Tree: 567 
final_score_567 := map(
(exp_source in ['P']) => 
   map(
   (NULL < eda_num_interrupts_cur and eda_num_interrupts_cur <= 1.5) => 0.0586437527,
   (eda_num_interrupts_cur > 1.5) => -0.0316308975,
   (eda_num_interrupts_cur = NULL) => -0.0169441323, -0.0169441323),
(exp_source in ['S']) => 
   map(
   (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.0050220746,
   (f_prevaddrstatus_i > 2.5) => -0.0147875071,
   (f_prevaddrstatus_i = NULL) => 0.0365303844, 0.0095281031),
(exp_source = '') => -0.0084003022, -0.0053181757);

// Tree: 568 
final_score_568 := map(
(NULL < pp_did_score and pp_did_score <= 37) => 0.0047341449,
(pp_did_score > 37) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 72.5) => -0.0470219660,
   (r_pb_order_freq_d > 72.5) => 
      map(
      (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 15.5) => 0.0497280198,
      (f_rel_ageover20_count_d > 15.5) => -0.0635073887,
      (f_rel_ageover20_count_d = NULL) => 0.0213191364, 0.0213191364),
   (r_pb_order_freq_d = NULL) => -0.0286234447, -0.0247552778),
(pp_did_score = NULL) => 0.0007566464, 0.0007566464);

// Tree: 569 
final_score_569 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 27.5) => 
   map(
   (NULL < inq_num_addresses and inq_num_addresses <= 2.5) => -0.0005243639,
   (inq_num_addresses > 2.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 246.5) => 0.0291686606,
      (f_prevaddrageoldest_d > 246.5) => -0.0401958305,
      (f_prevaddrageoldest_d = NULL) => 0.0193880274, 0.0193880274),
   (inq_num_addresses = NULL) => 0.0021997455, 0.0021997455),
(f_assocsuspicousidcount_i > 27.5) => -0.0625449618,
(f_assocsuspicousidcount_i = NULL) => 0.0015099237, 0.0015099237);

// Tree: 570 
final_score_570 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 157.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 152.5) => 0.0030065020,
   (f_curraddrcartheftindex_i > 152.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Daughter','Father','Husband','Mother','Neighbor','Sister','Son']) => -0.0740440287,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Parent','Relative','Sibling','Spouse','Subject','Subject at Household','Wife']) => 0.0829480721,
      (phone_subject_title = '') => 0.0443652677, 0.0443652677),
   (f_curraddrcartheftindex_i = NULL) => 0.0045275662, 0.0045275662),
(f_curraddrcartheftindex_i > 157.5) => -0.0143684961,
(f_curraddrcartheftindex_i = NULL) => -0.0001698976, -0.0001698976);

// Tree: 571 
final_score_571 := map(
(NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 118.5) => 
   map(
   (exp_source in ['P']) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 149.5) => -0.0313288532,
      (f_curraddrmurderindex_i > 149.5) => 0.0544627631,
      (f_curraddrmurderindex_i = NULL) => -0.0110508348, -0.0110508348),
   (exp_source in ['S']) => 0.0142213317,
   (exp_source = '') => 0.0019637476, 0.0036470063),
(mth_pp_eda_hist_did_dt > 118.5) => -0.0412971796,
(mth_pp_eda_hist_did_dt = NULL) => 0.0023419883, 0.0023419883);

// Tree: 572 
final_score_572 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 65520) => -0.0077822278,
(f_curraddrmedianincome_d > 65520) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => 0.0023116082,
   (f_sourcerisktype_i > 5.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By SSN','Brother','Daughter','Father','Husband','Neighbor','Relative','Sister','Subject','Wife']) => 0.0238676291,
      (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Parent','Sibling','Son','Spouse','Subject at Household']) => 0.1075543929,
      (phone_subject_title = '') => 0.0380785890, 0.0380785890),
   (f_sourcerisktype_i = NULL) => 0.0097954218, 0.0097954218),
(f_curraddrmedianincome_d = NULL) => -0.0025686229, -0.0025686229);

// Tree: 573 
final_score_573 := map(
(pp_src in ['CY','E1','E2','EN','LP','VW','ZK','ZT']) => -0.0573272864,
(pp_src in ['EB','EM','EQ','FA','FF','KW','LA','MD','NW','PL','SL','TN','UT','UW','VO']) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 48) => 0.0320675140,
   (f_curraddrcartheftindex_i > 48) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 21.5) => -0.0146807683,
      (f_rel_educationover12_count_d > 21.5) => 0.0651184990,
      (f_rel_educationover12_count_d = NULL) => -0.0074495596, -0.0074495596),
   (f_curraddrcartheftindex_i = NULL) => 0.0012002063, 0.0012002063),
(pp_src = '') => 0.0007738329, -0.0000170783);

// Tree: 574 
final_score_574 := map(
(NULL < mth_source_paw_lseen and mth_source_paw_lseen <= 63.5) => 
   map(
   (NULL < mth_source_paw_lseen and mth_source_paw_lseen <= 1.5) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 135.5) => -0.0016884488,
      (mth_pp_app_npa_last_change_dt > 135.5) => 0.0226432117,
      (mth_pp_app_npa_last_change_dt = NULL) => 0.0001269585, 0.0001269585),
   (mth_source_paw_lseen > 1.5) => 0.0777542717,
   (mth_source_paw_lseen = NULL) => 0.0006491153, 0.0006491153),
(mth_source_paw_lseen > 63.5) => -0.0690978935,
(mth_source_paw_lseen = NULL) => 0.0001019839, 0.0001019839);

// Tree: 575 
final_score_575 := map(
(exp_source in ['S']) => 0.1083532564,
(exp_source in ['P']) => 0.1440669677,
(exp_source = '') => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => 
      map(
      (NULL < number_of_sources and number_of_sources <= 1.5) => -0.0695122735,
      (number_of_sources > 1.5) => 0.0228618982,
      (number_of_sources = NULL) => -0.0522368270, -0.0522368270),
   (source_rel > 0.5) => 0.2038551614,
   (source_rel = NULL) => -0.0386132127, -0.0386132127), -0.0000296246);

// Tree: 576 
final_score_576 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -154.5) => 0.0745205328,
(f_addrchangecrimediff_i > -154.5) => 
   map(
   (NULL < _pp_app_fb_ph and _pp_app_fb_ph <= 0.5) => 0.0672001787,
   (_pp_app_fb_ph > 0.5) => -0.0044093456,
   (_pp_app_fb_ph = NULL) => -0.0036100568, -0.0036100568),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 46.5) => 0.0014296628,
   (mth_source_utildid_fseen > 46.5) => 0.0896080134,
   (mth_source_utildid_fseen = NULL) => 0.0038409520, 0.0038409520), -0.0012200211);

// Tree: 577 
final_score_577 := map(
(NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 18.5) => 
   map(
   (NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0047323376,
   (_pp_rule_high_vend_conf > 0.5) => 
      map(
      (NULL < pk_phone_match_level and pk_phone_match_level <= 3.5) => 0.0047772093,
      (pk_phone_match_level > 3.5) => 0.0587514484,
      (pk_phone_match_level = NULL) => 0.0233192394, 0.0233192394),
   (_pp_rule_high_vend_conf = NULL) => -0.0002791114, -0.0002791114),
(mth_source_ppth_lseen > 18.5) => -0.0718855099,
(mth_source_ppth_lseen = NULL) => -0.0028613349, -0.0028613349);

// Tree: 578 
final_score_578 := map(
(NULL < eda_num_ph_owners_hist and eda_num_ph_owners_hist <= 2.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -100473.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.24436429836985) => 0.0679316524,
      (f_add_curr_mobility_index_n > 0.24436429836985) => -0.0429024243,
      (f_add_curr_mobility_index_n = NULL) => -0.0247356358, -0.0247356358),
   (f_addrchangevaluediff_d > -100473.5) => 0.0055942215,
   (f_addrchangevaluediff_d = NULL) => 0.0061648964, 0.0030242018),
(eda_num_ph_owners_hist > 2.5) => -0.0251973252,
(eda_num_ph_owners_hist = NULL) => -0.0005377706, -0.0005377706);

// Tree: 579 
final_score_579 := map(
(NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 12.5) => -0.0013454449,
(f_rel_incomeover75_count_d > 12.5) => 
   map(
   (NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 26) => 
      map(
      (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 4.5) => 0.1540100729,
      (f_rel_bankrupt_count_i > 4.5) => 0.0235370432,
      (f_rel_bankrupt_count_i = NULL) => 0.0893311351, 0.0893311351),
   (mth_eda_dt_first_seen > 26) => -0.0638071163,
   (mth_eda_dt_first_seen = NULL) => 0.0434813592, 0.0434813592),
(f_rel_incomeover75_count_d = NULL) => -0.0004664880, -0.0004664880);

// Tree: 580 
final_score_580 := map(
(exp_type in ['N']) => 0.0827475258,
(exp_type in ['C']) => 0.1059816105,
(exp_type = '') => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => 
      map(
      (NULL < number_of_sources and number_of_sources <= 1.5) => -0.0646827415,
      (number_of_sources > 1.5) => 0.0209317933,
      (number_of_sources = NULL) => -0.0492245616, -0.0492245616),
   (source_rel > 0.5) => 0.1572644067,
   (source_rel = NULL) => -0.0388482315, -0.0388482315), -0.0042965772);

// Tree: 581 
final_score_581 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 73.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 56.5) => 0.0008163777,
   (f_prevaddrlenofres_d > 56.5) => -0.0534384765,
   (f_prevaddrlenofres_d = NULL) => -0.0056279712, -0.0056279712),
(f_prevaddrlenofres_d > 73.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Associate By SSN','Child','Daughter','Granddaughter','Grandfather','Grandmother','Grandson','Mother','Neighbor','Sibling','Spouse','Wife']) => -0.0086715916,
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Vehicle','Brother','Father','Grandchild','Grandparent','Husband','Parent','Relative','Sister','Son','Subject','Subject at Household']) => 0.0167608343,
   (phone_subject_title = '') => 0.0092877255, 0.0092877255),
(f_prevaddrlenofres_d = NULL) => 0.0029361989, 0.0029361989);

// Tree: 582 
final_score_582 := map(
(NULL < f_estimated_income_d and f_estimated_income_d <= 25500) => 
   map(
   (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 22.5) => 
      map(
      (phone_subject_title in ['Brother','Child','Father','Grandfather','Grandmother','Husband','Neighbor','Relative','Son','Subject','Subject at Household']) => -0.0356754522,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Grandparent','Grandson','Mother','Parent','Sibling','Sister','Spouse','Wife']) => 0.1004215415,
      (phone_subject_title = '') => 0.0064850296, 0.0064850296),
   (mth_pp_eda_hist_did_dt > 22.5) => 0.1198766212,
   (mth_pp_eda_hist_did_dt = NULL) => 0.0340163214, 0.0340163214),
(f_estimated_income_d > 25500) => -0.0021819311,
(f_estimated_income_d = NULL) => -0.0011518134, -0.0011518134);

// Tree: 583 
final_score_583 := map(
(NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 2.5) => -0.0027700301,
(mth_source_rel_fseen > 2.5) => 
   map(
   (NULL < mth_eda_dt_last_seen and mth_eda_dt_last_seen <= 8.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 66.5) => -0.0029321523,
      (f_mos_inq_banko_cm_fseen_d > 66.5) => 0.0674045088,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0437121598, 0.0437121598),
   (mth_eda_dt_last_seen > 8.5) => -0.0193385319,
   (mth_eda_dt_last_seen = NULL) => 0.0262113975, 0.0262113975),
(mth_source_rel_fseen = NULL) => -0.0018776153, -0.0018776153);

// Tree: 584 
final_score_584 := map(
(NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 11.5) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 7.5) => 0.0004298504,
   (f_rel_criminal_count_i > 7.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 102.5) => -0.0195867786,
      (f_curraddrburglaryindex_i > 102.5) => 0.1016309317,
      (f_curraddrburglaryindex_i = NULL) => 0.0592319120, 0.0592319120),
   (f_rel_criminal_count_i = NULL) => 0.0028826861, 0.0028826861),
(f_rel_educationover12_count_d > 11.5) => -0.0086666955,
(f_rel_educationover12_count_d = NULL) => -0.0014096440, -0.0014096440);

// Tree: 585 
final_score_585 := map(
(NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 6.5) => -0.0018455168,
(f_componentcharrisktype_i > 6.5) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 4.5) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 18.5) => -0.0391232164,
      (f_rel_under500miles_cnt_d > 18.5) => 0.1128277069,
      (f_rel_under500miles_cnt_d = NULL) => 0.0019655536, 0.0019655536),
   (mth_exp_last_update > 4.5) => 0.1069021133,
   (mth_exp_last_update = NULL) => 0.0241234726, 0.0241234726),
(f_componentcharrisktype_i = NULL) => -0.0010823490, -0.0010823490);

// Tree: 586 
final_score_586 := map(
(pp_src in ['CY','E1','E2','EM','EN','EQ','FA','LP','NW','PL','SL','TN','UT','UW','ZK','ZT']) => 
   map(
   (NULL < f_estimated_income_d and f_estimated_income_d <= 25500) => 0.0887529162,
   (f_estimated_income_d > 25500) => -0.0165112436,
   (f_estimated_income_d = NULL) => -0.0132482504, -0.0132482504),
(pp_src in ['EB','FF','KW','LA','MD','VO','VW']) => 
   map(
   (pp_source in ['CELL','HEADER','PCNSR']) => -0.0358015364,
   (pp_source in ['GONG','IBEHAVIOR','INFUTOR','INQUIRY','INTRADO','OTHER','TARGUS','THRIVE']) => 0.0855336924,
   (pp_source = '') => 0.0194493268, 0.0194493268),
(pp_src = '') => 0.0015582691, -0.0009845359);

// Tree: 587 
final_score_587 := map(
(NULL < mth_source_inf_lseen and mth_source_inf_lseen <= 3.5) => -0.0007048879,
(mth_source_inf_lseen > 3.5) => 
   map(
   (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 268.5) => 
      map(
      (eda_pfrd_address_ind in ['1A','1B']) => -0.0651966372,
      (eda_pfrd_address_ind in ['1C','1D','1E','XX']) => 0.0004465006,
      (eda_pfrd_address_ind = '') => -0.0427346786, -0.0427346786),
   (mth_source_inf_fseen > 268.5) => 0.0433684536,
   (mth_source_inf_fseen = NULL) => -0.0305276522, -0.0305276522),
(mth_source_inf_lseen = NULL) => -0.0020841166, -0.0020841166);

// Tree: 588 
final_score_588 := map(
(NULL < f_inq_lnames_per_addr_i and f_inq_lnames_per_addr_i <= 10.5) => 
   map(
   (NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 69.5) => 
      map(
      (NULL < f_inq_per_addr_i and f_inq_per_addr_i <= 14.5) => -0.0008990600,
      (f_inq_per_addr_i > 14.5) => -0.0528156253,
      (f_inq_per_addr_i = NULL) => -0.0019056312, -0.0019056312),
   (mth_source_ppla_fseen > 69.5) => -0.0485411318,
   (mth_source_ppla_fseen = NULL) => -0.0026462281, -0.0026462281),
(f_inq_lnames_per_addr_i > 10.5) => 0.0643340057,
(f_inq_lnames_per_addr_i = NULL) => -0.0018384815, -0.0018384815);

// Tree: 589 
final_score_589 := map(
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Father','Granddaughter','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Wife']) => -0.0690546994,
(phone_subject_title in ['Associate','Associate By Property','Associate By Vehicle','Grandchild','Grandparent','Subject','Subject at Household']) => 
   map(
   (exp_source in ['S']) => 0.0951782065,
   (exp_source in ['P']) => 0.1420363177,
   (exp_source = '') => 
      map(
      (NULL < source_rel and source_rel <= 0.5) => -0.0109751508,
      (source_rel > 0.5) => 0.1827807404,
      (source_rel = NULL) => 0.0096195919, 0.0096195919), 0.0479398257),
(phone_subject_title = '') => -0.0044412847, -0.0044412847);

// Tree: 590 
final_score_590 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 4.5) => -0.0133521119,
(f_corraddrnamecount_d > 4.5) => 
   map(
   (pp_source in ['CELL','GONG','INTRADO','OTHER','TARGUS','THRIVE']) => -0.0807952198,
   (pp_source in ['HEADER','IBEHAVIOR','INFUTOR','INQUIRY','PCNSR']) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 32645) => 0.0111987452,
      (f_addrchangeincomediff_d > 32645) => 0.0611303544,
      (f_addrchangeincomediff_d = NULL) => -0.0062281404, 0.0116596707),
   (pp_source = '') => 0.0059257352, 0.0064151711),
(f_corraddrnamecount_d = NULL) => -0.0018690333, -0.0018690333);

// Tree: 591 
final_score_591 := map(
(NULL < f_estimated_income_d and f_estimated_income_d <= 79500) => -0.0040790589,
(f_estimated_income_d > 79500) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 2.5) => 
      map(
      (NULL < eda_num_phs_connected_hhid and eda_num_phs_connected_hhid <= 0.5) => 0.0608039028,
      (eda_num_phs_connected_hhid > 0.5) => 0.0100999300,
      (eda_num_phs_connected_hhid = NULL) => 0.0358534790, 0.0358534790),
   (f_util_adl_count_n > 2.5) => -0.0052392435,
   (f_util_adl_count_n = NULL) => 0.0182458550, 0.0182458550),
(f_estimated_income_d = NULL) => 0.0002520946, 0.0002520946);

// Tree: 592 
final_score_592 := map(
(pp_src in ['CY','E1','EN','EQ','LP','PL','SL','TN','UT','UW','VO','ZK','ZT']) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 43.5) => 0.0398405263,
   (f_mos_inq_banko_cm_fseen_d > 43.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -35807.5) => 0.0541859362,
      (f_addrchangeincomediff_d > -35807.5) => -0.0228605830,
      (f_addrchangeincomediff_d = NULL) => 0.0016882362, -0.0123696727),
   (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0044976940, -0.0044976940),
(pp_src in ['E2','EB','EM','FA','FF','KW','LA','MD','NW','VW']) => 0.0664903498,
(pp_src = '') => 0.0028115262, 0.0018377779);

// Tree: 593 
final_score_593 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 8.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 88.5) => 0.0026877593,
   (mth_source_ppdid_fseen > 88.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.49554686541776) => -0.0558338339,
      (f_add_input_mobility_index_n > 0.49554686541776) => 0.0426843436,
      (f_add_input_mobility_index_n = NULL) => -0.0347501772, -0.0347501772),
   (mth_source_ppdid_fseen = NULL) => 0.0015295623, 0.0015295623),
(f_rel_homeover500_count_d > 8.5) => -0.0652181307,
(f_rel_homeover500_count_d = NULL) => 0.0004548844, 0.0004548844);

// Tree: 594 
final_score_594 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 19.5) => 0.0007114476,
(mth_exp_last_update > 19.5) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 85.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => -0.0109926845,
      (f_srchvelocityrisktype_i > 5.5) => -0.0846501851,
      (f_srchvelocityrisktype_i = NULL) => -0.0420174770, -0.0420174770),
   (mth_pp_app_npa_last_change_dt > 85.5) => 0.0118889957,
   (mth_pp_app_npa_last_change_dt = NULL) => -0.0213501545, -0.0213501545),
(mth_exp_last_update = NULL) => -0.0007505436, -0.0007505436);

// Tree: 595 
final_score_595 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 8.5) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Child','Granddaughter','Grandmother','Grandson','Neighbor','Sibling','Sister','Son']) => -0.0429743094,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Vehicle','Brother','Daughter','Father','Grandchild','Grandfather','Grandparent','Husband','Mother','Parent','Relative','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < eda_days_in_service and eda_days_in_service <= 1971) => 0.0214342188,
      (eda_days_in_service > 1971) => -0.0412592576,
      (eda_days_in_service = NULL) => 0.0170216602, 0.0170216602),
   (phone_subject_title = '') => 0.0004831818, 0.0004831818),
(f_inq_count_i > 8.5) => -0.0103244196,
(f_inq_count_i = NULL) => -0.0047136810, -0.0047136810);

// Tree: 596 
final_score_596 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0044938555,
(source_utildid > 0.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 12.5) => 0.0985512760,
   (mth_source_utildid_fseen > 12.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 161.5) => -0.0151649553,
      (f_prevaddrageoldest_d > 161.5) => 0.0482062144,
      (f_prevaddrageoldest_d = NULL) => 0.0028750127, 0.0028750127),
   (mth_source_utildid_fseen = NULL) => 0.0189179341, 0.0189179341),
(source_utildid = NULL) => -0.0022379250, -0.0022379250);

// Tree: 597 
final_score_597 := map(
(NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 191.5) => 
   map(
   (NULL < f_inq_ssns_per_addr_i and f_inq_ssns_per_addr_i <= 11.5) => 0.0041384156,
   (f_inq_ssns_per_addr_i > 11.5) => 0.0966431598,
   (f_inq_ssns_per_addr_i = NULL) => 0.0048524317, 0.0048524317),
(f_curraddrburglaryindex_i > 191.5) => 
   map(
   (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 39) => -0.0478959319,
   (mth_pp_datefirstseen > 39) => 0.0585949522,
   (mth_pp_datefirstseen = NULL) => -0.0338470026, -0.0338470026),
(f_curraddrburglaryindex_i = NULL) => 0.0031351754, 0.0031351754);

// Tree: 598 
final_score_598 := map(
(NULL < source_rel and source_rel <= 0.5) => -0.0013601579,
(source_rel > 0.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 113207.5) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 128.5) => 0.0329971293,
      (f_prevaddrcartheftindex_i > 128.5) => -0.0609827438,
      (f_prevaddrcartheftindex_i = NULL) => -0.0164659618, -0.0164659618),
   (f_prevaddrmedianvalue_d > 113207.5) => 0.0407119435,
   (f_prevaddrmedianvalue_d = NULL) => 0.0225551713, 0.0225551713),
(source_rel = NULL) => -0.0003549356, -0.0003549356);

// Tree: 599 
final_score_599 := map(
(NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 28.5) => 0.0008246177,
(mth_source_ppla_fseen > 28.5) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 36.5) => 0.0964090454,
   (f_mos_inq_banko_om_lseen_d > 36.5) => 
      map(
      (NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 10.5) => -0.0247833023,
      (mth_pp_first_build_date > 10.5) => 0.0504557824,
      (mth_pp_first_build_date = NULL) => 0.0054052193, 0.0054052193),
   (f_mos_inq_banko_om_lseen_d = NULL) => 0.0331359989, 0.0331359989),
(mth_source_ppla_fseen = NULL) => 0.0017060780, 0.0017060780);

// Tree: 600 
final_score_600 := map(
(NULL < pp_did_score and pp_did_score <= 38) => 0.0042791962,
(pp_did_score > 38) => 
   map(
   (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 7.5) => -0.0458182892,
   (mth_pp_datefirstseen > 7.5) => 
      map(
      (pp_src in ['CY','E1','E2','EN','FA','LP','PL','SL','TN','VW','ZK','ZT']) => -0.0453385125,
      (pp_src in ['EB','EM','EQ','FF','KW','LA','MD','NW','UT','UW','VO']) => 0.0303969512,
      (pp_src = '') => -0.0141521114, -0.0042960965),
   (mth_pp_datefirstseen = NULL) => -0.0153736376, -0.0153736376),
(pp_did_score = NULL) => 0.0017089802, 0.0017089802);

// Tree: 601 
final_score_601 := map(
(NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 35) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By SSN','Brother','Child','Father','Grandmother','Husband','Mother','Neighbor','Parent','Sibling','Sister','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 15.5) => -0.0328770463,
      (inq_adl_firstseen_n > 15.5) => 0.0265693537,
      (inq_adl_firstseen_n = NULL) => -0.0262406459, -0.0262406459),
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Relative','Son','Spouse']) => 0.0350572289,
   (phone_subject_title = '') => -0.0133671759, -0.0133671759),
(f_curraddrmurderindex_i > 35) => 0.0022580977,
(f_curraddrmurderindex_i = NULL) => -0.0001899838, -0.0001899838);

// Tree: 602 
final_score_602 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 22.5) => -0.0035685064,
(f_rel_under25miles_cnt_d > 22.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 23.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Daughter','Neighbor','Sister','Son','Subject','Subject at Household']) => 0.0396367805,
      (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Parent','Relative','Sibling','Spouse','Wife']) => 0.2091813329,
      (phone_subject_title = '') => 0.0837890077, 0.0837890077),
   (f_rel_ageover30_count_d > 23.5) => 0.0027314383,
   (f_rel_ageover30_count_d = NULL) => 0.0330687742, 0.0330687742),
(f_rel_under25miles_cnt_d = NULL) => -0.0013614932, -0.0013614932);

// Tree: 603 
final_score_603 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 11.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Child','Daughter','Father','Granddaughter','Grandfather','Grandmother','Grandson','Mother','Neighbor','Sister','Wife']) => -0.0222330736,
   (phone_subject_title in ['Associate','Associate By SSN','Associate By Vehicle','Brother','Grandchild','Grandparent','Husband','Parent','Relative','Sibling','Son','Spouse','Subject','Subject at Household']) => 0.0207950877,
   (phone_subject_title = '') => 0.0034794380, 0.0034794380),
(f_inq_count_i > 11.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 11.5) => -0.0048630648,
   (mth_source_ppdid_lseen > 11.5) => -0.0433614229,
   (mth_source_ppdid_lseen = NULL) => -0.0136413202, -0.0136413202),
(f_inq_count_i = NULL) => -0.0024025649, -0.0024025649);

// Tree: 604 
final_score_604 := map(
(NULL < source_rel and source_rel <= 0.5) => -0.0024273702,
(source_rel > 0.5) => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 2912) => -0.0194106083,
   (eda_days_ph_first_seen > 2912) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 0.5) => -0.0200108787,
      (f_inq_count24_i > 0.5) => 0.0748196045,
      (f_inq_count24_i = NULL) => 0.0447291627, 0.0447291627),
   (eda_days_ph_first_seen = NULL) => 0.0198278399, 0.0198278399),
(source_rel = NULL) => -0.0015414352, -0.0015414352);

// Tree: 605 
final_score_605 := map(
(NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 7.5) => 0.0065720318,
(mth_pp_first_build_date > 7.5) => 
   map(
   (NULL < f_inq_lnames_per_ssn_i and f_inq_lnames_per_ssn_i <= 0.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 72.5) => 0.0021949762,
      (r_pb_order_freq_d > 72.5) => 0.0399228928,
      (r_pb_order_freq_d = NULL) => -0.0168519056, 0.0012359685),
   (f_inq_lnames_per_ssn_i > 0.5) => -0.0412536015,
   (f_inq_lnames_per_ssn_i = NULL) => -0.0125671404, -0.0125671404),
(mth_pp_first_build_date = NULL) => 0.0026057123, 0.0026057123);

// Tree: 606 
final_score_606 := map(
(NULL < mth_pp_eda_hist_nm_addr_dt and mth_pp_eda_hist_nm_addr_dt <= 60.5) => 
   map(
   (pp_rp_source in ['GONG','HEADER','PCNSR','THRIVE']) => -0.0407126265,
   (pp_rp_source in ['CELL','IBEHAVIOR','INFUTOR','INQUIRY','INTRADO','OTHER','TARGUS']) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 4.5) => -0.0348384386,
      (f_rel_incomeover50_count_d > 4.5) => 0.0333276809,
      (f_rel_incomeover50_count_d = NULL) => 0.0111617749, 0.0111617749),
   (pp_rp_source = '') => 0.0002161250, 0.0002717105),
(mth_pp_eda_hist_nm_addr_dt > 60.5) => 0.0689321943,
(mth_pp_eda_hist_nm_addr_dt = NULL) => 0.0009469805, 0.0009469805);

// Tree: 607 
final_score_607 := map(
(NULL < _internal_ver_match_hhid and _internal_ver_match_hhid <= 0.5) => -0.0039843940,
(_internal_ver_match_hhid > 0.5) => 
   map(
   (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 0.5) => 0.0630011614,
   (f_rel_bankrupt_count_i > 0.5) => 
      map(
      (NULL < _pp_src_all_ut and _pp_src_all_ut <= 0.5) => -0.0120816227,
      (_pp_src_all_ut > 0.5) => 0.0797376550,
      (_pp_src_all_ut = NULL) => 0.0056307435, 0.0056307435),
   (f_rel_bankrupt_count_i = NULL) => 0.0218659333, 0.0218659333),
(_internal_ver_match_hhid = NULL) => -0.0020806525, -0.0020806525);

// Tree: 608 
final_score_608 := map(
(NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 11.5) => 
   map(
   (pp_app_scc in ['C','N']) => 0.0025253523,
   (pp_app_scc in ['8','A','B','J','R','S']) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => 0.0114430029,
      (f_sourcerisktype_i > 4.5) => 0.0806203406,
      (f_sourcerisktype_i = NULL) => 0.0403949998, 0.0403949998),
   (pp_app_scc = '') => 0.0005684842, 0.0027571241),
(mth_pp_datevendorfirstseen > 11.5) => -0.0111497559,
(mth_pp_datevendorfirstseen = NULL) => -0.0015528526, -0.0015528526);

// Tree: 609 
final_score_609 := map(
(NULL < eda_num_interrupts_cur and eda_num_interrupts_cur <= 13.5) => 
   map(
   (NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => -0.0030670139,
   (_inq_adl_ph_industry_flag > 0.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 10.5) => -0.0083223472,
      (f_rel_educationover12_count_d > 10.5) => 0.0587281856,
      (f_rel_educationover12_count_d = NULL) => 0.0242168819, 0.0242168819),
   (_inq_adl_ph_industry_flag = NULL) => -0.0021754690, -0.0021754690),
(eda_num_interrupts_cur > 13.5) => 0.0506001712,
(eda_num_interrupts_cur = NULL) => -0.0008346057, -0.0008346057);

// Tree: 610 
final_score_610 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 1.00151791727026) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 73110.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 70653.5) => -0.0001075383,
      (f_prevaddrmedianincome_d > 70653.5) => 0.0451210492,
      (f_prevaddrmedianincome_d = NULL) => 0.0012058265, 0.0012058265),
   (f_prevaddrmedianincome_d > 73110.5) => -0.0166897349,
   (f_prevaddrmedianincome_d = NULL) => -0.0018890733, -0.0018890733),
(f_add_curr_mobility_index_n > 1.00151791727026) => 0.0448988564,
(f_add_curr_mobility_index_n = NULL) => -0.0111537261, -0.0010434457);

// Tree: 611 
final_score_611 := map(
(NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 16.5) => 
   map(
   (pp_rp_source in ['GONG','IBEHAVIOR','INFUTOR','INQUIRY','TARGUS','THRIVE']) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 18.5) => -0.0712131018,
      (f_prevaddrlenofres_d > 18.5) => 0.0096788688,
      (f_prevaddrlenofres_d = NULL) => -0.0115774155, -0.0115774155),
   (pp_rp_source in ['CELL','HEADER','INTRADO','OTHER','PCNSR']) => 0.0605938868,
   (pp_rp_source = '') => 0.0039338196, 0.0038533975),
(f_rel_homeover100_count_d > 16.5) => -0.0206827768,
(f_rel_homeover100_count_d = NULL) => 0.0016560852, 0.0016560852);

// Tree: 612 
final_score_612 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 58.5) => -0.0061166530,
(r_pb_order_freq_d > 58.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Granddaughter','Grandmother','Grandson','Husband','Mother','Neighbor','Relative','Sibling','Sister','Son','Spouse','Wife']) => -0.0245083073,
   (phone_subject_title in ['Associate By Address','Associate By Property','Father','Grandchild','Grandfather','Grandparent','Parent','Subject','Subject at Household']) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 62.5) => 0.0101881489,
      (f_mos_inq_banko_cm_lseen_d > 62.5) => 0.0544012519,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0331317816, 0.0331317816),
   (phone_subject_title = '') => 0.0122522763, 0.0122522763),
(r_pb_order_freq_d = NULL) => -0.0025534554, -0.0008201502);

// Tree: 613 
final_score_613 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.197283175275095) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 453098.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 7.5) => -0.0443530732,
      (f_addrchangecrimediff_i > 7.5) => 0.0198688650,
      (f_addrchangecrimediff_i = NULL) => -0.0355644898, -0.0271396540),
   (f_prevaddrmedianvalue_d > 453098.5) => 0.0640676682,
   (f_prevaddrmedianvalue_d = NULL) => -0.0200310252, -0.0200310252),
(f_add_curr_mobility_index_n > 0.197283175275095) => 0.0009257358,
(f_add_curr_mobility_index_n = NULL) => 0.0379937808, -0.0005454283);

// Tree: 614 
final_score_614 := map(
(NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 16.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Father','Granddaughter','Grandmother','Grandson','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household']) => 0.0066450646,
   (phone_subject_title in ['Associate By Property','Associate By Vehicle','Daughter','Grandchild','Grandfather','Grandparent','Husband','Wife']) => 0.1047815854,
   (phone_subject_title = '') => 0.0077065032, 0.0077065032),
(mth_eda_dt_first_seen > 16.5) => 
   map(
   (NULL < f_college_income_d and f_college_income_d <= 3.5) => 0.0722751395,
   (f_college_income_d > 3.5) => -0.0443938789,
   (f_college_income_d = NULL) => -0.0074589560, -0.0090185870),
(mth_eda_dt_first_seen = NULL) => 0.0013011912, 0.0013011912);

// Tree: 615 
final_score_615 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 12.5) => 
   map(
   (NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 24.5) => 
      map(
      (NULL < inq_lastseen_n and inq_lastseen_n <= 32.5) => 0.0516517646,
      (inq_lastseen_n > 32.5) => -0.0583169670,
      (inq_lastseen_n = NULL) => 0.0332822699, 0.0332822699),
   (f_mos_acc_lseen_d > 24.5) => 0.0002313192,
   (f_mos_acc_lseen_d = NULL) => 0.0020125323, 0.0020125323),
(f_util_adl_count_n > 12.5) => -0.0408003286,
(f_util_adl_count_n = NULL) => 0.0004034785, 0.0004034785);

// Tree: 616 
final_score_616 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 25.5) => 0.0017998314,
(mth_exp_last_update > 25.5) => 
   map(
   (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 
      map(
      (NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => 0.0102487597,
      (f_util_add_input_conv_n > 0.5) => -0.0646013941,
      (f_util_add_input_conv_n = NULL) => -0.0317903678, -0.0317903678),
   (f_prevaddrstatus_i > 2.5) => -0.0585913956,
   (f_prevaddrstatus_i = NULL) => 0.0263587400, -0.0229797497),
(mth_exp_last_update = NULL) => 0.0004565524, 0.0004565524);

// Tree: 617 
final_score_617 := map(
(NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 151.5) => -0.0061795282,
(f_curraddrmurderindex_i > 151.5) => 
   map(
   (NULL < inq_num_addresses and inq_num_addresses <= 5.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 70062.5) => 0.0023957053,
      (f_curraddrmedianincome_d > 70062.5) => 0.0840102746,
      (f_curraddrmedianincome_d = NULL) => 0.0052480318, 0.0052480318),
   (inq_num_addresses > 5.5) => 0.1054578203,
   (inq_num_addresses = NULL) => 0.0083258392, 0.0083258392),
(f_curraddrmurderindex_i = NULL) => -0.0024194435, -0.0024194435);

// Tree: 618 
final_score_618 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0049689606,
(source_utildid > 0.5) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 175.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => -0.0134175054,
      (f_mos_inq_banko_om_fseen_d > 36.5) => 0.0381280397,
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0234550453, 0.0234550453),
   (f_curraddrburglaryindex_i > 175.5) => -0.0447472596,
   (f_curraddrburglaryindex_i = NULL) => 0.0142338153, 0.0142338153),
(source_utildid = NULL) => -0.0032062892, -0.0032062892);

// Tree: 619 
final_score_619 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 29071.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -36978) => -0.0126267363,
   (f_addrchangevaluediff_d > -36978) => 0.0437260766,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 10.5) => 0.1023941319,
      (f_mos_inq_banko_om_lseen_d > 10.5) => -0.0111548221,
      (f_mos_inq_banko_om_lseen_d = NULL) => 0.0099471959, 0.0099471959), 0.0229279994),
(f_curraddrmedianincome_d > 29071.5) => -0.0044344358,
(f_curraddrmedianincome_d = NULL) => -0.0008298995, -0.0008298995);

// Tree: 620 
final_score_620 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 10.5) => 
   map(
   (NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 86.5) => 
      map(
      (NULL < _pp_app_nonpub_gong_lap and _pp_app_nonpub_gong_lap <= 0.5) => 0.0000654067,
      (_pp_app_nonpub_gong_lap > 0.5) => -0.0464070345,
      (_pp_app_nonpub_gong_lap = NULL) => -0.0005412395, -0.0005412395),
   (mth_source_ppfla_fseen > 86.5) => -0.0492307383,
   (mth_source_ppfla_fseen = NULL) => -0.0010490229, -0.0010490229),
(f_rel_homeover500_count_d > 10.5) => -0.0624361010,
(f_rel_homeover500_count_d = NULL) => -0.0016469724, -0.0016469724);

// Tree: 621 
final_score_621 := map(
(NULL < mth_source_edadid_fseen and mth_source_edadid_fseen <= 44.5) => 
   map(
   (NULL < eda_num_ph_owners_hist and eda_num_ph_owners_hist <= 2.5) => 
      map(
      (NULL < mth_pp_eda_hist_nm_addr_dt and mth_pp_eda_hist_nm_addr_dt <= 63.5) => 0.0000453286,
      (mth_pp_eda_hist_nm_addr_dt > 63.5) => 0.0902374659,
      (mth_pp_eda_hist_nm_addr_dt = NULL) => 0.0008849478, 0.0008849478),
   (eda_num_ph_owners_hist > 2.5) => -0.0271666528,
   (eda_num_ph_owners_hist = NULL) => -0.0025841908, -0.0025841908),
(mth_source_edadid_fseen > 44.5) => 0.0614451958,
(mth_source_edadid_fseen = NULL) => -0.0019619640, -0.0019619640);

// Tree: 622 
final_score_622 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 396.5) => -0.0020165128,
(r_pb_order_freq_d > 396.5) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 2.5) => 0.1077087696,
   (f_sourcerisktype_i > 2.5) => 0.0171901115,
   (f_sourcerisktype_i = NULL) => 0.0377033325, 0.0377033325),
(r_pb_order_freq_d = NULL) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Child','Father','Granddaughter','Grandfather','Grandmother','Grandson','Mother','Neighbor','Relative','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => -0.0064427424,
   (phone_subject_title in ['Associate By Vehicle','Brother','Daughter','Grandchild','Grandparent','Husband','Parent','Spouse']) => 0.0979412378,
   (phone_subject_title = '') => -0.0027411828, -0.0027411828), -0.0010107952);

// Tree: 623 
final_score_623 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -21.5) => -0.0120484313,
(f_addrchangecrimediff_i > -21.5) => 0.0058743291,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 379) => -0.0043553759,
   (r_pb_order_freq_d > 379) => 0.0721154080,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 177.5) => -0.0005602031,
      (f_fp_prevaddrcrimeindex_i > 177.5) => 0.0753841099,
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.0099239886, 0.0099239886), 0.0032501968), 0.0006306770);

// Tree: 624 
final_score_624 := map(
(NULL < f_estimated_income_d and f_estimated_income_d <= 79500) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 116) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 169.5) => -0.0089442557,
      (f_fp_prevaddrcrimeindex_i > 169.5) => -0.0527336875,
      (f_fp_prevaddrcrimeindex_i = NULL) => -0.0140670194, -0.0140670194),
   (f_curraddrcrimeindex_i > 116) => 0.0038675937,
   (f_curraddrcrimeindex_i = NULL) => -0.0057041767, -0.0057041767),
(f_estimated_income_d > 79500) => 0.0107076898,
(f_estimated_income_d = NULL) => -0.0024337169, -0.0024337169);

// Tree: 625 
final_score_625 := map(
(NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 6.5) => 
   map(
   (NULL < pk_cell_indicator and pk_cell_indicator <= 3.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By SSN','Brother','Child','Father','Granddaughter','Grandmother','Husband','Mother','Neighbor','Parent','Spouse','Subject','Subject at Household']) => 0.0011520358,
      (phone_subject_title in ['Associate By Shared Associates','Associate By Vehicle','Daughter','Grandchild','Grandfather','Grandparent','Grandson','Relative','Sibling','Sister','Son','Wife']) => 0.1109949446,
      (phone_subject_title = '') => 0.0103976073, 0.0103976073),
   (pk_cell_indicator > 3.5) => 0.0364635484,
   (pk_cell_indicator = NULL) => 0.0136713597, 0.0136713597),
(f_rel_ageover30_count_d > 6.5) => -0.0054006871,
(f_rel_ageover30_count_d = NULL) => 0.0007220072, 0.0007220072);

// Tree: 626 
final_score_626 := map(
(NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 242) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 76.5) => -0.0069730204,
   (r_pb_order_freq_d > 76.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Father','Neighbor','Parent','Sibling','Sister']) => -0.0261455988,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Brother','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Relative','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0275011491,
      (phone_subject_title = '') => 0.0123500926, 0.0123500926),
   (r_pb_order_freq_d = NULL) => -0.0030705882, -0.0019337922),
(mth_source_inf_fseen > 242) => 0.0592561719,
(mth_source_inf_fseen = NULL) => -0.0009594525, -0.0009594525);

// Tree: 627 
final_score_627 := map(
(exp_source in ['P']) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 3.5) => -0.0343747792,
   (r_pb_order_freq_d > 3.5) => 0.0211350149,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_estimated_income_d and f_estimated_income_d <= 40500) => -0.1030912908,
      (f_estimated_income_d > 40500) => 0.0128581337,
      (f_estimated_income_d = NULL) => -0.0475941304, -0.0475941304), -0.0145420137),
(exp_source in ['S']) => 0.0077384748,
(exp_source = '') => 0.0026478807, 0.0027449067);

// Tree: 628 
final_score_628 := map(
(NULL < subject_ssn_mismatch and subject_ssn_mismatch <= -0.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 389718.5) => 0.0064236425,
   (f_curraddrmedianvalue_d > 389718.5) => 
      map(
      (phone_subject_title in ['Associate By Business','Associate By Shared Associates','Brother','Daughter','Husband','Neighbor','Sister','Wife']) => -0.0447248118,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By SSN','Associate By Vehicle','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Parent','Relative','Sibling','Son','Spouse','Subject','Subject at Household']) => 0.0783412864,
      (phone_subject_title = '') => 0.0486692232, 0.0486692232),
   (f_curraddrmedianvalue_d = NULL) => 0.0102891513, 0.0102891513),
(subject_ssn_mismatch > -0.5) => -0.0075235920,
(subject_ssn_mismatch = NULL) => -0.0017570266, -0.0017570266);

// Tree: 629 
final_score_629 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 298) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 14.5) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 13.5) => 0.0068034634,
      (f_rel_homeover100_count_d > 13.5) => 0.0556605126,
      (f_rel_homeover100_count_d = NULL) => 0.0098488131, 0.0098488131),
   (f_rel_homeover200_count_d > 14.5) => -0.0300424899,
   (f_rel_homeover200_count_d = NULL) => 0.0072328529, 0.0072328529),
(r_pb_order_freq_d > 298) => -0.0238457840,
(r_pb_order_freq_d = NULL) => 0.0016874152, 0.0033944562);

// Tree: 630 
final_score_630 := map(
(NULL < f_divsrchaddrsuspidcount_i and f_divsrchaddrsuspidcount_i <= 0.5) => 
   map(
   (NULL < inq_lastseen_n and inq_lastseen_n <= 17.5) => -0.0008711423,
   (inq_lastseen_n > 17.5) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 137.5) => 0.0134443222,
      (mth_pp_app_npa_last_change_dt > 137.5) => 0.0835785872,
      (mth_pp_app_npa_last_change_dt = NULL) => 0.0161797175, 0.0161797175),
   (inq_lastseen_n = NULL) => 0.0040889033, 0.0040889033),
(f_divsrchaddrsuspidcount_i > 0.5) => -0.0172650794,
(f_divsrchaddrsuspidcount_i = NULL) => 0.0016884556, 0.0016884556);

// Tree: 631 
final_score_631 := map(
(pp_app_scc in ['8','B','C','N','R']) => 
   map(
   (NULL < _pp_app_nonpub_gong_la and _pp_app_nonpub_gong_la <= 0.5) => -0.0068975320,
   (_pp_app_nonpub_gong_la > 0.5) => 0.0612256612,
   (_pp_app_nonpub_gong_la = NULL) => -0.0052139570, -0.0052139570),
(pp_app_scc in ['A','J','S']) => 0.0209954042,
(pp_app_scc = '') => 
   map(
   (NULL < eda_days_in_service and eda_days_in_service <= 26.5) => 0.0434567155,
   (eda_days_in_service > 26.5) => -0.0020175585,
   (eda_days_in_service = NULL) => 0.0008264746, 0.0008264746), 0.0001659505);

// Tree: 632 
final_score_632 := map(
(NULL < source_sx and source_sx <= 0.5) => 0.0006729866,
(source_sx > 0.5) => 
   map(
   (NULL < f_estimated_income_d and f_estimated_income_d <= 39500) => 
      map(
      (NULL < mth_exp_last_update and mth_exp_last_update <= 3.5) => 0.0233198832,
      (mth_exp_last_update > 3.5) => -0.0604435735,
      (mth_exp_last_update = NULL) => -0.0174538629, -0.0174538629),
   (f_estimated_income_d > 39500) => 0.0419310939,
   (f_estimated_income_d = NULL) => 0.0192109384, 0.0192109384),
(source_sx = NULL) => 0.0017451969, 0.0017451969);

// Tree: 633 
final_score_633 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 28261.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -43) => -0.0683660088,
   (f_addrchangecrimediff_i > -43) => 0.0207747854,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 9.5) => 0.1122665387,
      (f_mos_inq_banko_om_lseen_d > 9.5) => 0.0083125587,
      (f_mos_inq_banko_om_lseen_d = NULL) => 0.0251001579, 0.0251001579), 0.0166905494),
(f_curraddrmedianincome_d > 28261.5) => -0.0014398726,
(f_curraddrmedianincome_d = NULL) => 0.0007555667, 0.0007555667);

// Tree: 634 
final_score_634 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 27.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 12.5) => -0.0007815753,
   (inq_adl_lastseen_n > 12.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.440400212278615) => 0.0086305608,
      (f_add_curr_mobility_index_n > 0.440400212278615) => 0.0727981238,
      (f_add_curr_mobility_index_n = NULL) => 0.0283923103, 0.0283923103),
   (inq_adl_lastseen_n = NULL) => 0.0002205810, 0.0002205810),
(inq_adl_lastseen_n > 27.5) => -0.0279542760,
(inq_adl_lastseen_n = NULL) => -0.0011616067, -0.0011616067);

// Tree: 635 
final_score_635 := map(
(NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 48) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -148.5) => 0.0686941201,
   (f_addrchangecrimediff_i > -148.5) => -0.0161998665,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Daughter','Grandfather','Husband','Neighbor','Parent','Relative','Sibling','Son','Subject','Wife']) => -0.0363992013,
      (phone_subject_title in ['Associate By Address','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Mother','Sister','Spouse','Subject at Household']) => 0.0556016494,
      (phone_subject_title = '') => -0.0121211991, -0.0121211991), -0.0122575332),
(f_curraddrmurderindex_i > 48) => 0.0033045710,
(f_curraddrmurderindex_i = NULL) => -0.0000396685, -0.0000396685);

// Tree: 636 
final_score_636 := map(
(NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0023462399,
(_pp_rule_high_vend_conf > 0.5) => 
   map(
   (NULL < mth_pp_datevendorlastseen and mth_pp_datevendorlastseen <= 14.5) => 0.0068938401,
   (mth_pp_datevendorlastseen > 14.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 45799.5) => 0.1250908381,
      (f_prevaddrmedianincome_d > 45799.5) => 0.0201490006,
      (f_prevaddrmedianincome_d = NULL) => 0.0643744893, 0.0643744893),
   (mth_pp_datevendorlastseen = NULL) => 0.0129672672, 0.0129672672),
(_pp_rule_high_vend_conf = NULL) => 0.0000294066, 0.0000294066);

// Tree: 637 
final_score_637 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 9615.5) => 0.0067270287,
(f_addrchangeincomediff_d > 9615.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 1.5) => -0.0002039431,
   (f_varrisktype_i > 1.5) => -0.0410574570,
   (f_varrisktype_i = NULL) => -0.0084178771, -0.0084178771),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 11.5) => -0.0132969869,
   (f_rel_incomeover75_count_d > 11.5) => 0.0956258692,
   (f_rel_incomeover75_count_d = NULL) => -0.0103000583, -0.0103000583), -0.0015289342);

// Tree: 638 
final_score_638 := map(
(exp_type in ['C']) => 
   map(
   (NULL < inq_lastseen_n and inq_lastseen_n <= 30.5) => 
      map(
      (NULL < f_divssnidmsrcurelcount_i and f_divssnidmsrcurelcount_i <= 0.5) => -0.0413095231,
      (f_divssnidmsrcurelcount_i > 0.5) => -0.0028106090,
      (f_divssnidmsrcurelcount_i = NULL) => -0.0110454850, -0.0110454850),
   (inq_lastseen_n > 30.5) => 0.0331375369,
   (inq_lastseen_n = NULL) => -0.0041755639, -0.0041755639),
(exp_type in ['N']) => 0.0151808643,
(exp_type = '') => 0.0015198114, 0.0019548975);

// Tree: 639 
final_score_639 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 459) => 
   map(
   (NULL < _internal_ver_match_level and _internal_ver_match_level <= 2.5) => 0.0002596457,
   (_internal_ver_match_level > 2.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 105.5) => -0.0015846523,
      (f_fp_prevaddrburglaryindex_i > 105.5) => 0.0760261442,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0325453968, 0.0325453968),
   (_internal_ver_match_level = NULL) => 0.0008915055, 0.0008915055),
(f_prevaddrlenofres_d > 459) => -0.0795390883,
(f_prevaddrlenofres_d = NULL) => 0.0003359025, 0.0003359025);

// Tree: 640 
final_score_640 := map(
(NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => -0.0001925081,
(_inq_adl_ph_industry_flag > 0.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.521880934217485) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => 0.0199099202,
      (f_util_adl_count_n > 4.5) => 0.0968495291,
      (f_util_adl_count_n = NULL) => 0.0470412560, 0.0470412560),
   (f_add_input_mobility_index_n > 0.521880934217485) => -0.0072389889,
   (f_add_input_mobility_index_n = NULL) => 0.0319748762, 0.0319748762),
(_inq_adl_ph_industry_flag = NULL) => 0.0008017770, 0.0008017770);

// Tree: 641 
final_score_641 := map(
(NULL < mth_pp_datevendorlastseen and mth_pp_datevendorlastseen <= 4.5) => 0.0054801010,
(mth_pp_datevendorlastseen > 4.5) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 26.5) => 
      map(
      (NULL < f_estimated_income_d and f_estimated_income_d <= 36500) => -0.0321789372,
      (f_estimated_income_d > 36500) => -0.0005939072,
      (f_estimated_income_d = NULL) => -0.0098534815, -0.0098534815),
   (mth_exp_last_update > 26.5) => -0.0519281894,
   (mth_exp_last_update = NULL) => -0.0131349491, -0.0131349491),
(mth_pp_datevendorlastseen = NULL) => 0.0014000900, 0.0014000900);

// Tree: 642 
final_score_642 := map(
(NULL < _pp_rule_f1_ver_below and _pp_rule_f1_ver_below <= 0.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 4.5) => 0.0126267332,
   (f_inq_count_i > 4.5) => -0.0017883044,
   (f_inq_count_i = NULL) => 0.0024546317, 0.0024546317),
(_pp_rule_f1_ver_below > 0.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 9.5) => -0.1010891127,
   (f_rel_under500miles_cnt_d > 9.5) => 0.0369437632,
   (f_rel_under500miles_cnt_d = NULL) => -0.0383468964, -0.0383468964),
(_pp_rule_f1_ver_below = NULL) => 0.0019291466, 0.0019291466);

// Tree: 643 
final_score_643 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 10.5) => -0.0023045659,
(f_srchfraudsrchcount_i > 10.5) => 
   map(
   (NULL < mth_source_ppfla_lseen and mth_source_ppfla_lseen <= 3.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 38244.5) => 0.0239648073,
      (f_addrchangeincomediff_d > 38244.5) => 0.0971433671,
      (f_addrchangeincomediff_d = NULL) => 0.0211780453, 0.0274521274),
   (mth_source_ppfla_lseen > 3.5) => -0.0413723472,
   (mth_source_ppfla_lseen = NULL) => 0.0223353340, 0.0223353340),
(f_srchfraudsrchcount_i = NULL) => 0.0004511555, 0.0004511555);

// Tree: 644 
final_score_644 := map(
(NULL < pp_app_company_type and pp_app_company_type <= 7.5) => -0.0057081954,
(pp_app_company_type > 7.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 118) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.405839459104025) => 0.0550061005,
      (f_add_input_mobility_index_n > 0.405839459104025) => 0.0164912301,
      (f_add_input_mobility_index_n = NULL) => 0.0379237475, 0.0379237475),
   (f_prevaddrcartheftindex_i > 118) => -0.0094426890,
   (f_prevaddrcartheftindex_i = NULL) => 0.0150088142, 0.0150088142),
(pp_app_company_type = NULL) => -0.0039884483, -0.0039884483);

// Tree: 645 
final_score_645 := map(
(NULL < f_inq_adls_per_addr_i and f_inq_adls_per_addr_i <= 9.5) => 
   map(
   (eda_pfrd_address_ind in ['1A','1B','1E','XX']) => -0.0014019694,
   (eda_pfrd_address_ind in ['1C','1D']) => 0.0374838265,
   (eda_pfrd_address_ind = '') => 0.0003789890, 0.0003789890),
(f_inq_adls_per_addr_i > 9.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 86) => 0.1544042861,
   (f_fp_prevaddrburglaryindex_i > 86) => 0.0034305900,
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.0715691608, 0.0715691608),
(f_inq_adls_per_addr_i = NULL) => 0.0013208564, 0.0013208564);

// Tree: 646 
final_score_646 := map(
(NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 2.5) => 0.0021380982,
(f_rel_incomeover100_count_d > 2.5) => 
   map(
   (NULL < eda_num_interrupts_cur and eda_num_interrupts_cur <= 7.5) => 
      map(
      (pp_src in ['CY','EN','FA','TN','UT','VO','ZK']) => -0.0533309210,
      (pp_src in ['E1','E2','EB','EM','EQ','FF','KW','LA','LP','MD','NW','PL','SL','UW','VW','ZT']) => 0.0379051205,
      (pp_src = '') => -0.0244436751, -0.0235357172),
   (eda_num_interrupts_cur > 7.5) => 0.0555295123,
   (eda_num_interrupts_cur = NULL) => -0.0155403569, -0.0155403569),
(f_rel_incomeover100_count_d = NULL) => 0.0001057817, 0.0001057817);

// Tree: 647 
final_score_647 := map(
(NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 11.5) => -0.0018770568,
(f_rel_homeover100_count_d > 11.5) => 
   map(
   (NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 19.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Father','Grandmother','Grandson','Husband','Neighbor','Parent','Sibling','Sister','Son','Wife']) => -0.0117236425,
      (phone_subject_title in ['Associate By Address','Brother','Daughter','Grandchild','Granddaughter','Grandfather','Grandparent','Mother','Relative','Spouse','Subject','Subject at Household']) => 0.0274069297,
      (phone_subject_title = '') => 0.0146131344, 0.0146131344),
   (mth_pp_orig_lastseen > 19.5) => -0.0278944930,
   (mth_pp_orig_lastseen = NULL) => 0.0080938848, 0.0080938848),
(f_rel_homeover100_count_d = NULL) => 0.0000031913, 0.0000031913);

// Tree: 648 
final_score_648 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 2.5) => -0.0729314979,
(f_mos_inq_banko_om_fseen_d > 2.5) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 14.5) => 
      map(
      (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 5091) => 0.0049113722,
      (eda_days_ph_first_seen > 5091) => -0.0389787399,
      (eda_days_ph_first_seen = NULL) => 0.0028508035, 0.0028508035),
   (f_rel_incomeover25_count_d > 14.5) => -0.0090928129,
   (f_rel_incomeover25_count_d = NULL) => -0.0009631244, -0.0009631244),
(f_mos_inq_banko_om_fseen_d = NULL) => -0.0014856114, -0.0014856114);

// Tree: 649 
final_score_649 := map(
(NULL < number_of_sources and number_of_sources <= 1.5) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 0.5) => -0.0197489295,
   (inq_adl_firstseen_n > 0.5) => 0.0509828605,
   (inq_adl_firstseen_n = NULL) => -0.0158373911, -0.0158373911),
(number_of_sources > 1.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 63.5) => 0.0072143555,
   (f_mos_inq_banko_cm_lseen_d > 63.5) => 0.0565875194,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0295126334, 0.0295126334),
(number_of_sources = NULL) => -0.0040923666, -0.0040923666);

// Tree: 650 
final_score_650 := map(
(NULL < _internal_ver_match_hhid and _internal_ver_match_hhid <= 0.5) => -0.0030863729,
(_internal_ver_match_hhid > 0.5) => 
   map(
   (pp_src in ['CY','E1','E2','EN','EQ','FA','SL','UT','VO','ZK','ZT']) => 0.0091232745,
   (pp_src in ['EB','EM','FF','KW','LA','LP','MD','NW','PL','TN','UW','VW']) => 0.0931872299,
   (pp_src = '') => 
      map(
      (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => 0.0626245987,
      (f_crim_rel_under100miles_cnt_i > 0.5) => -0.0058873855,
      (f_crim_rel_under100miles_cnt_i = NULL) => 0.0196245846, 0.0196245846), 0.0214400435),
(_internal_ver_match_hhid = NULL) => -0.0012715157, -0.0012715157);

// Tree: 651 
final_score_651 := map(
(pp_glb_dppa_fl in ['G']) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 259.5) => -0.0054508633,
   (f_prevaddrageoldest_d > 259.5) => -0.0429502596,
   (f_prevaddrageoldest_d = NULL) => -0.0099071591, -0.0099071591),
(pp_glb_dppa_fl in ['B','D','U']) => 
   map(
   (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 1.5) => -0.0371163817,
   (f_rel_bankrupt_count_i > 1.5) => 0.0455330338,
   (f_rel_bankrupt_count_i = NULL) => 0.0055558709, 0.0055558709),
(pp_glb_dppa_fl = '') => 0.0004358177, -0.0028676317);

// Tree: 652 
final_score_652 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 0.5) => 
   map(
   (exp_type in ['N']) => 0.0458576280,
   (exp_type in ['C']) => 0.0437480375,
   (exp_type = '') => 
      map(
      (NULL < f_adl_util_misc_n and f_adl_util_misc_n <= 0.5) => 0.0288872315,
      (f_adl_util_misc_n > 0.5) => -0.0483398933,
      (f_adl_util_misc_n = NULL) => 0.0061907101, 0.0061907101), 0.0158100369),
(f_rel_incomeover50_count_d > 0.5) => -0.0024099398,
(f_rel_incomeover50_count_d = NULL) => -0.0009153407, -0.0009153407);

// Tree: 653 
final_score_653 := map(
(NULL < _phone_fb_result and _phone_fb_result <= 0.5) => 0.0659827638,
(_phone_fb_result > 0.5) => 
   map(
   (NULL < source_pf and source_pf <= 0.5) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 141.5) => -0.0007416182,
      (mth_pp_app_npa_last_change_dt > 141.5) => 0.0323852591,
      (mth_pp_app_npa_last_change_dt = NULL) => 0.0003514705, 0.0003514705),
   (source_pf > 0.5) => -0.0722516903,
   (source_pf = NULL) => -0.0002128693, -0.0002128693),
(_phone_fb_result = NULL) => 0.0001746476, 0.0001746476);

// Tree: 654 
final_score_654 := map(
(NULL < _pp_agegroup and _pp_agegroup <= 0.5) => 0.0016663707,
(_pp_agegroup > 0.5) => 
   map(
   (pp_src in ['CY','E1','EM','EN','FA','PL','SL','UT','VO','ZK','ZT']) => 
      map(
      (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 14.5) => 0.0188230827,
      (mth_pp_datevendorfirstseen > 14.5) => -0.0631130028,
      (mth_pp_datevendorfirstseen = NULL) => -0.0340842182, -0.0340842182),
   (pp_src in ['E2','EB','EQ','FF','KW','LA','LP','MD','NW','TN','UW','VW']) => 0.0268404085,
   (pp_src = '') => -0.0611493139, -0.0302094209),
(_pp_agegroup = NULL) => 0.0003414783, 0.0003414783);

// Tree: 655 
final_score_655 := map(
(NULL < _pp_origlistingtype_res and _pp_origlistingtype_res <= 0.5) => 
   map(
   (NULL < _phone_match_code_lns and _phone_match_code_lns <= 0.5) => -0.0071122660,
   (_phone_match_code_lns > 0.5) => 0.0141584880,
   (_phone_match_code_lns = NULL) => 0.0015895638, 0.0015895638),
(_pp_origlistingtype_res > 0.5) => 
   map(
   (NULL < _pp_glb_dppa_fl_glb and _pp_glb_dppa_fl_glb <= 0.5) => 0.0131260970,
   (_pp_glb_dppa_fl_glb > 0.5) => -0.0220589992,
   (_pp_glb_dppa_fl_glb = NULL) => -0.0094198347, -0.0094198347),
(_pp_origlistingtype_res = NULL) => -0.0015143622, -0.0015143622);

// Tree: 656 
final_score_656 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 31394) => 0.0165294333,
(f_curraddrmedianincome_d > 31394) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 37266) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 9.5) => -0.0181331539,
      (f_srchssnsrchcount_i > 9.5) => 0.0304961256,
      (f_srchssnsrchcount_i = NULL) => -0.0127149249, -0.0127149249),
   (f_prevaddrmedianincome_d > 37266) => 0.0027523584,
   (f_prevaddrmedianincome_d = NULL) => -0.0011622009, -0.0011622009),
(f_curraddrmedianincome_d = NULL) => 0.0017611971, 0.0017611971);

// Tree: 657 
final_score_657 := map(
(NULL < source_sx and source_sx <= 0.5) => -0.0037255547,
(source_sx > 0.5) => 
   map(
   (NULL < mth_source_sx_fseen and mth_source_sx_fseen <= 9.5) => 0.0757544532,
   (mth_source_sx_fseen > 9.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0226249135,
      (f_srchfraudsrchcount_i > 6.5) => -0.0434158156,
      (f_srchfraudsrchcount_i = NULL) => 0.0125306052, 0.0125306052),
   (mth_source_sx_fseen = NULL) => 0.0199091321, 0.0199091321),
(source_sx = NULL) => -0.0025162867, -0.0025162867);

// Tree: 658 
final_score_658 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Child','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Neighbor','Parent','Sibling','Sister','Spouse','Subject','Subject at Household']) => -0.0052327617,
(phone_subject_title in ['Associate By Shared Associates','Daughter','Father','Grandchild','Husband','Mother','Relative','Son','Wife']) => 
   map(
   (NULL < _phone_match_code_tcza and _phone_match_code_tcza <= 2.5) => -0.0012600445,
   (_phone_match_code_tcza > 2.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => 0.1182640423,
      (f_mos_inq_banko_om_fseen_d > 36.5) => 0.0261188869,
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0457903246, 0.0457903246),
   (_phone_match_code_tcza = NULL) => 0.0146136585, 0.0146136585),
(phone_subject_title = '') => -0.0021678480, -0.0021678480);

// Tree: 659 
final_score_659 := map(
(NULL < eda_num_interrupts_cur and eda_num_interrupts_cur <= 6.5) => -0.0029275786,
(eda_num_interrupts_cur > 6.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Father','Grandson','Mother','Neighbor','Relative','Sister','Son','Spouse','Subject','Wife']) => 0.0043140380,
   (phone_subject_title in ['Associate','Associate By Property','Associate By Vehicle','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Husband','Parent','Sibling','Subject at Household']) => 
      map(
      (NULL < inq_lastseen_n and inq_lastseen_n <= 11.5) => 0.0031239143,
      (inq_lastseen_n > 11.5) => 0.0981280820,
      (inq_lastseen_n = NULL) => 0.0500862018, 0.0500862018),
   (phone_subject_title = '') => 0.0112767872, 0.0112767872),
(eda_num_interrupts_cur = NULL) => -0.0010033951, -0.0010033951);

// Tree: 660 
final_score_660 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 10.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 63335) => -0.0019240862,
   (f_addrchangeincomediff_d > 63335) => 
      map(
      (NULL < pp_avg_source_conf and pp_avg_source_conf <= 6.5) => 0.0014518734,
      (pp_avg_source_conf > 6.5) => 0.0821663536,
      (pp_avg_source_conf = NULL) => 0.0292844528, 0.0292844528),
   (f_addrchangeincomediff_d = NULL) => -0.0026191420, -0.0015582560),
(f_rel_homeover500_count_d > 10.5) => -0.0391529056,
(f_rel_homeover500_count_d = NULL) => -0.0020127987, -0.0020127987);

// Tree: 661 
final_score_661 := map(
(pp_src in ['CY','E1','E2','EQ','LP','TN','ZK','ZT']) => -0.0423356929,
(pp_src in ['EB','EM','EN','FA','FF','KW','LA','MD','NW','PL','SL','UT','UW','VO','VW']) => 
   map(
   (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 2.5) => 0.0826878426,
   (mth_pp_datevendorfirstseen > 2.5) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 14.5) => -0.0051279761,
      (f_inq_count24_i > 14.5) => 0.0568717289,
      (f_inq_count24_i = NULL) => -0.0019368148, -0.0019368148),
   (mth_pp_datevendorfirstseen = NULL) => 0.0014829116, 0.0014829116),
(pp_src = '') => 0.0027193424, 0.0015177528);

// Tree: 662 
final_score_662 := map(
(NULL < mth_source_ppfa_fseen and mth_source_ppfa_fseen <= 3.5) => 
   map(
   (NULL < source_sp and source_sp <= 0.5) => -0.0015951438,
   (source_sp > 0.5) => 
      map(
      (NULL < mth_source_sp_lseen and mth_source_sp_lseen <= 1.5) => 0.0823375245,
      (mth_source_sp_lseen > 1.5) => -0.0061001406,
      (mth_source_sp_lseen = NULL) => 0.0391799440, 0.0391799440),
   (source_sp = NULL) => -0.0003889230, -0.0003889230),
(mth_source_ppfa_fseen > 3.5) => 0.0509275040,
(mth_source_ppfa_fseen = NULL) => 0.0001518191, 0.0001518191);

// Tree: 663 
final_score_663 := map(
(NULL < number_of_sources and number_of_sources <= 1.5) => 
   map(
   (phone_subject_title in ['Brother','Child','Granddaughter','Grandmother','Grandparent','Grandson','Neighbor','Sibling','Sister','Son','Wife']) => -0.0540311231,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Daughter','Father','Grandchild','Grandfather','Husband','Mother','Parent','Relative','Spouse','Subject','Subject at Household']) => -0.0025719555,
   (phone_subject_title = '') => -0.0146752167, -0.0146752167),
(number_of_sources > 1.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 7.5) => 0.0431172586,
   (f_inq_count_i > 7.5) => 0.0025092152,
   (f_inq_count_i = NULL) => 0.0210828851, 0.0210828851),
(number_of_sources = NULL) => -0.0054394864, -0.0054394864);

// Tree: 664 
final_score_664 := map(
(NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 1.5) => -0.0058593256,
(f_rel_incomeover75_count_d > 1.5) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 5.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Father','Granddaughter','Grandfather','Grandmother','Husband','Neighbor','Sibling','Son','Spouse','Wife']) => -0.0161750954,
      (phone_subject_title in ['Associate','Associate By Property','Associate By SSN','Brother','Grandchild','Grandparent','Grandson','Mother','Parent','Relative','Sister','Subject','Subject at Household']) => 0.0141170575,
      (phone_subject_title = '') => 0.0040917716, 0.0040917716),
   (f_rel_criminal_count_i > 5.5) => -0.0144714374,
   (f_rel_criminal_count_i = NULL) => -0.0011358261, -0.0011358261),
(f_rel_incomeover75_count_d = NULL) => -0.0036959373, -0.0036959373);

// Tree: 665 
final_score_665 := map(
(NULL < f_util_add_curr_misc_n and f_util_add_curr_misc_n <= 0.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 34730) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 344.5) => 0.0281855246,
      (r_pb_order_freq_d > 344.5) => 0.0533591501,
      (r_pb_order_freq_d = NULL) => 0.0010215720, 0.0194295598),
   (f_addrchangevaluediff_d > 34730) => 0.0001867419,
   (f_addrchangevaluediff_d = NULL) => -0.0030340611, 0.0097616659),
(f_util_add_curr_misc_n > 0.5) => -0.0030912252,
(f_util_add_curr_misc_n = NULL) => 0.0012472463, 0.0012472463);

// Tree: 666 
final_score_666 := map(
(NULL < _pp_rule_low_vend_conf and _pp_rule_low_vend_conf <= 0.5) => -0.0030148251,
(_pp_rule_low_vend_conf > 0.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 167) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 2.5) => -0.0421772396,
      (f_srchvelocityrisktype_i > 2.5) => 0.0451387222,
      (f_srchvelocityrisktype_i = NULL) => 0.0051423784, 0.0051423784),
   (f_prevaddrlenofres_d > 167) => 0.0888624789,
   (f_prevaddrlenofres_d = NULL) => 0.0314438259, 0.0314438259),
(_pp_rule_low_vend_conf = NULL) => -0.0021030285, -0.0021030285);

// Tree: 667 
final_score_667 := map(
(NULL < eda_min_days_interrupt and eda_min_days_interrupt <= 87) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 50.5) => 0.0019288284,
   (mth_exp_last_update > 50.5) => -0.0261901090,
   (mth_exp_last_update = NULL) => 0.0010991900, 0.0010991900),
(eda_min_days_interrupt > 87) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Vehicle','Brother','Daughter','Father','Husband','Relative','Son','Subject']) => -0.0692506436,
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Neighbor','Parent','Sibling','Sister','Spouse','Subject at Household','Wife']) => 0.0090220127,
   (phone_subject_title = '') => -0.0358885278, -0.0358885278),
(eda_min_days_interrupt = NULL) => -0.0002216452, -0.0002216452);

// Tree: 668 
final_score_668 := map(
(NULL < mth_pp_date_nonglb_lastseen and mth_pp_date_nonglb_lastseen <= 134.5) => 
   map(
   (NULL < mth_source_sx_fseen and mth_source_sx_fseen <= 2.5) => -0.0008470801,
   (mth_source_sx_fseen > 2.5) => 
      map(
      (NULL < r_nas_addr_verd_d and r_nas_addr_verd_d <= 0.5) => 0.0485779164,
      (r_nas_addr_verd_d > 0.5) => 0.0064324964,
      (r_nas_addr_verd_d = NULL) => 0.0156546890, 0.0156546890),
   (mth_source_sx_fseen = NULL) => 0.0000410730, 0.0000410730),
(mth_pp_date_nonglb_lastseen > 134.5) => 0.0638686622,
(mth_pp_date_nonglb_lastseen = NULL) => 0.0004147271, 0.0004147271);

// Tree: 669 
final_score_669 := map(
(NULL < _internal_ver_match_hhid and _internal_ver_match_hhid <= 0.5) => -0.0002835074,
(_internal_ver_match_hhid > 0.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.219625638398915) => -0.0302336210,
   (f_add_input_mobility_index_n > 0.219625638398915) => 
      map(
      (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 24.5) => 0.0058088346,
      (mth_pp_datefirstseen > 24.5) => 0.0492862014,
      (mth_pp_datefirstseen = NULL) => 0.0252039425, 0.0252039425),
   (f_add_input_mobility_index_n = NULL) => 0.0171835637, 0.0171835637),
(_internal_ver_match_hhid = NULL) => 0.0010171667, 0.0010171667);

// Tree: 670 
final_score_670 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 9) => 0.0030141070,
(f_addrchangevaluediff_d > 9) => -0.0079139371,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By SSN','Brother','Child','Grandfather','Mother','Neighbor','Relative','Spouse','Subject at Household','Wife']) => -0.0246001639,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Daughter','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Parent','Sibling','Sister','Son','Subject']) => 
      map(
      (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 1.5) => 0.0225009385,
      (f_crim_rel_under25miles_cnt_i > 1.5) => -0.0039191612,
      (f_crim_rel_under25miles_cnt_i = NULL) => 0.0114592049, 0.0114592049),
   (phone_subject_title = '') => 0.0023471562, 0.0023471562), -0.0010190455);

// Tree: 671 
final_score_671 := map(
(NULL < pp_total_source_conf and pp_total_source_conf <= 15.5) => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => -0.0041534195,
   (source_rel > 0.5) => 0.0217448067,
   (source_rel = NULL) => -0.0031516533, -0.0031516533),
(pp_total_source_conf > 15.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 10.5) => 0.0072131616,
   (f_corraddrnamecount_d > 10.5) => 0.0986261165,
   (f_corraddrnamecount_d = NULL) => 0.0224165794, 0.0224165794),
(pp_total_source_conf = NULL) => -0.0017296991, -0.0017296991);

// Tree: 672 
final_score_672 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.17233999260081) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 8.5) => -0.0169374543,
   (mth_exp_last_update > 8.5) => -0.0795647294,
   (mth_exp_last_update = NULL) => -0.0266102533, -0.0266102533),
(f_add_input_mobility_index_n > 0.17233999260081) => 
   map(
   (NULL < mth_source_ppca_fseen and mth_source_ppca_fseen <= 22.5) => 0.0044768887,
   (mth_source_ppca_fseen > 22.5) => -0.0251037446,
   (mth_source_ppca_fseen = NULL) => 0.0026047431, 0.0026047431),
(f_add_input_mobility_index_n = NULL) => -0.0052499085, 0.0012199200);

// Tree: 673 
final_score_673 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 313223.5) => 
   map(
   (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 4.5) => 0.0004839669,
   (f_rel_ageover50_count_d > 4.5) => 0.0539276982,
   (f_rel_ageover50_count_d = NULL) => 0.0014536605, 0.0014536605),
(f_addrchangevaluediff_d > 313223.5) => -0.0368017271,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 11.5) => -0.0022110319,
   (f_rel_incomeover75_count_d > 11.5) => 0.0550830499,
   (f_rel_incomeover75_count_d = NULL) => -0.0007011256, -0.0007011256), 0.0002960362);

// Tree: 674 
final_score_674 := map(
(NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 0.5) => 
   map(
   (NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 48.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 103.5) => 0.0047085952,
      (f_prevaddrmurderindex_i > 103.5) => 0.0511852374,
      (f_prevaddrmurderindex_i = NULL) => 0.0254192393, 0.0254192393),
   (f_mos_acc_lseen_d > 48.5) => 0.0032323250,
   (f_mos_acc_lseen_d = NULL) => 0.0051770491, 0.0051770491),
(f_srchunvrfdphonecount_i > 0.5) => -0.0071707958,
(f_srchunvrfdphonecount_i = NULL) => 0.0022328856, 0.0022328856);

// Tree: 675 
final_score_675 := map(
(pp_src in ['CY','E1','EM','EQ','LP','PL','SL','TN','UT','VO','ZK','ZT']) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 22.5) => -0.0162394442,
   (f_rel_under500miles_cnt_d > 22.5) => 0.0356325472,
   (f_rel_under500miles_cnt_d = NULL) => -0.0097154206, -0.0097154206),
(pp_src in ['E2','EB','EN','FA','FF','KW','LA','MD','NW','UW','VW']) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.576666059170155) => 0.0171510285,
   (f_add_input_mobility_index_n > 0.576666059170155) => -0.0312831018,
   (f_add_input_mobility_index_n = NULL) => 0.0091148724, 0.0091148724),
(pp_src = '') => 0.0025624790, 0.0010411276);

// Tree: 676 
final_score_676 := map(
(NULL < mth_source_ppca_fseen and mth_source_ppca_fseen <= 104.5) => 
   map(
   (NULL < mth_source_ppth_fseen and mth_source_ppth_fseen <= 28.5) => 
      map(
      (NULL < mth_pp_eda_hist_nm_addr_dt and mth_pp_eda_hist_nm_addr_dt <= 61) => -0.0001367949,
      (mth_pp_eda_hist_nm_addr_dt > 61) => 0.0563851431,
      (mth_pp_eda_hist_nm_addr_dt = NULL) => 0.0003298748, 0.0003298748),
   (mth_source_ppth_fseen > 28.5) => -0.0461980566,
   (mth_source_ppth_fseen = NULL) => -0.0010514917, -0.0010514917),
(mth_source_ppca_fseen > 104.5) => -0.0733384011,
(mth_source_ppca_fseen = NULL) => -0.0015000582, -0.0015000582);

// Tree: 677 
final_score_677 := map(
(NULL < mth_source_ppfla_lseen and mth_source_ppfla_lseen <= 5.5) => -0.0005213907,
(mth_source_ppfla_lseen > 5.5) => 
   map(
   (NULL < pp_min_source_conf and pp_min_source_conf <= 9.5) => 
      map(
      (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 4.5) => 0.0781123136,
      (pp_app_ind_ph_cnt > 4.5) => 0.0155481571,
      (pp_app_ind_ph_cnt = NULL) => 0.0497813748, 0.0497813748),
   (pp_min_source_conf > 9.5) => 0.0010244191,
   (pp_min_source_conf = NULL) => 0.0222057195, 0.0222057195),
(mth_source_ppfla_lseen = NULL) => 0.0007771492, 0.0007771492);

// Tree: 678 
final_score_678 := map(
(NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 3.5) => -0.0020303343,
(f_addrchangeecontrajindex_d > 3.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Father','Granddaughter','Grandfather','Grandmother','Husband','Neighbor','Sibling','Sister','Son','Subject at Household']) => -0.0113948290,
   (phone_subject_title in ['Associate','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Grandparent','Grandson','Mother','Parent','Relative','Spouse','Subject','Wife']) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 166) => 0.0277745983,
      (f_prevaddrmurderindex_i > 166) => -0.0288561051,
      (f_prevaddrmurderindex_i = NULL) => 0.0209948662, 0.0209948662),
   (phone_subject_title = '') => 0.0080116550, 0.0080116550),
(f_addrchangeecontrajindex_d = NULL) => -0.0009154724, -0.0009154724);

// Tree: 679 
final_score_679 := map(
(NULL < subject_ssn_mismatch and subject_ssn_mismatch <= -0.5) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 18.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 35) => -0.0309327262,
      (f_curraddrmurderindex_i > 35) => 0.0100107499,
      (f_curraddrmurderindex_i = NULL) => 0.0024147603, 0.0024147603),
   (inq_adl_firstseen_n > 18.5) => 0.0446772545,
   (inq_adl_firstseen_n = NULL) => 0.0055304080, 0.0055304080),
(subject_ssn_mismatch > -0.5) => -0.0052286648,
(subject_ssn_mismatch = NULL) => -0.0016574236, -0.0016574236);

// Tree: 680 
final_score_680 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 11.5) => 
   map(
   (exp_source in ['P']) => -0.0031450057,
   (exp_source in ['S']) => 
      map(
      (phone_subject_title in ['Associate By SSN','Grandfather','Grandmother','Grandparent','Husband','Neighbor','Sister','Son','Subject','Subject at Household','Wife']) => 0.0099352894,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandson','Mother','Parent','Relative','Sibling','Spouse']) => 0.0888436564,
      (phone_subject_title = '') => 0.0184681200, 0.0184681200),
   (exp_source = '') => 0.0014969877, 0.0042035405),
(f_inq_count_i > 11.5) => -0.0095619912,
(f_inq_count_i = NULL) => -0.0006353501, -0.0006353501);

// Tree: 681 
final_score_681 := map(
(NULL < pp_did_score and pp_did_score <= 75.5) => 
   map(
   (NULL < eda_min_days_interrupt and eda_min_days_interrupt <= 1.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 117801) => 0.0015000938,
      (f_addrchangevaluediff_d > 117801) => 0.0196560965,
      (f_addrchangevaluediff_d = NULL) => 0.0123520748, 0.0058346604),
   (eda_min_days_interrupt > 1.5) => -0.0099501900,
   (eda_min_days_interrupt = NULL) => 0.0014695405, 0.0014695405),
(pp_did_score > 75.5) => -0.0123094947,
(pp_did_score = NULL) => -0.0003034556, -0.0003034556);

// Tree: 682 
final_score_682 := map(
(NULL < f_util_add_input_inf_n and f_util_add_input_inf_n <= 0.5) => -0.0007776022,
(f_util_add_input_inf_n > 0.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 158850.5) => -0.0165312178,
   (f_curraddrmedianvalue_d > 158850.5) => 
      map(
      (phone_subject_title in ['Associate','Brother','Husband','Neighbor','Parent','Sister']) => -0.0107230602,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Relative','Sibling','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0641361595,
      (phone_subject_title = '') => 0.0467733747, 0.0467733747),
   (f_curraddrmedianvalue_d = NULL) => 0.0174465533, 0.0174465533),
(f_util_add_input_inf_n = NULL) => 0.0002679236, 0.0002679236);

// Tree: 683 
final_score_683 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 11.5) => 
   map(
   (NULL < r_paw_dead_business_ct_i and r_paw_dead_business_ct_i <= 2.5) => 0.0044714012,
   (r_paw_dead_business_ct_i > 2.5) => -0.0614757073,
   (r_paw_dead_business_ct_i = NULL) => 0.0039273535, 0.0039273535),
(f_rel_under25miles_cnt_d > 11.5) => 
   map(
   (pp_app_ph_type in ['CELL','LNDLN PRTD TO CELL','PAGE']) => -0.0198050336,
   (pp_app_ph_type in ['POTS','Puerto Rico/US Virgin Isl','VOIP']) => 0.0359369441,
   (pp_app_ph_type = '') => 0.0015632607, -0.0067085354),
(f_rel_under25miles_cnt_d = NULL) => 0.0010168865, 0.0010168865);

// Tree: 684 
final_score_684 := map(
(NULL < mth_source_paw_lseen and mth_source_paw_lseen <= 0.5) => 
   map(
   (pp_rp_source in ['GONG','HEADER','IBEHAVIOR','INFUTOR','INTRADO','OTHER','TARGUS']) => -0.0009073047,
   (pp_rp_source in ['CELL','INQUIRY','PCNSR','THRIVE']) => 0.0404151382,
   (pp_rp_source = '') => 0.0007623889, 0.0010656403),
(mth_source_paw_lseen > 0.5) => 
   map(
   (NULL < eda_days_in_service and eda_days_in_service <= 852.5) => 0.0553548445,
   (eda_days_in_service > 852.5) => -0.0050041641,
   (eda_days_in_service = NULL) => 0.0269771017, 0.0269771017),
(mth_source_paw_lseen = NULL) => 0.0014721660, 0.0014721660);

// Tree: 685 
final_score_685 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0020829482,
(source_utildid > 0.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 31.5) => 
      map(
      (NULL < inq_lastseen_n and inq_lastseen_n <= 3.5) => 0.0645907967,
      (inq_lastseen_n > 3.5) => 0.0044823940,
      (inq_lastseen_n = NULL) => 0.0324505711, 0.0324505711),
   (mth_source_utildid_fseen > 31.5) => -0.0067031945,
   (mth_source_utildid_fseen = NULL) => 0.0124069872, 0.0124069872),
(source_utildid = NULL) => -0.0007308257, -0.0007308257);

// Tree: 686 
final_score_686 := map(
(NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 108.5) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 24.5) => 0.0024984294,
   (f_rel_educationover12_count_d > 24.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 176.5) => -0.0260403306,
      (f_curraddrcrimeindex_i > 176.5) => 0.0539298014,
      (f_curraddrcrimeindex_i = NULL) => -0.0174128475, -0.0174128475),
   (f_rel_educationover12_count_d = NULL) => 0.0013522171, 0.0013522171),
(mth_source_ppdid_fseen > 108.5) => -0.0417781016,
(mth_source_ppdid_fseen = NULL) => 0.0006553451, 0.0006553451);

// Tree: 687 
final_score_687 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 0.5) => 
   map(
   (exp_type in ['C']) => 0.0222010931,
   (exp_type in ['N']) => 0.0522963765,
   (exp_type = '') => 0.0082418200, 0.0139508510),
(f_rel_incomeover50_count_d > 0.5) => 
   map(
   (NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 6.5) => 0.0012756127,
   (mth_internal_ver_first_seen > 6.5) => -0.0104955600,
   (mth_internal_ver_first_seen = NULL) => -0.0014624644, -0.0014624644),
(f_rel_incomeover50_count_d = NULL) => -0.0002110720, -0.0002110720);

// Tree: 688 
final_score_688 := map(
(NULL < source_rel and source_rel <= 0.5) => -0.0018350509,
(source_rel > 0.5) => 
   map(
   (NULL < _phone_zip_match and _phone_zip_match <= 0.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 114) => 0.0152640248,
      (f_curraddrcrimeindex_i > 114) => 0.0537802059,
      (f_curraddrcrimeindex_i = NULL) => 0.0281996479, 0.0281996479),
   (_phone_zip_match > 0.5) => -0.0221520743,
   (_phone_zip_match = NULL) => 0.0191581622, 0.0191581622),
(source_rel = NULL) => -0.0010411383, -0.0010411383);

// Tree: 689 
final_score_689 := map(
(NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 6.5) => 0.0003792818,
(f_rel_incomeover100_count_d > 6.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Father','Husband','Mother','Neighbor','Sibling','Sister','Son','Subject at Household','Wife']) => -0.0131977357,
   (phone_subject_title in ['Associate By Address','Associate By Property','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Parent','Relative','Spouse','Subject']) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 19.5) => 0.0959438437,
      (f_rel_homeover100_count_d > 19.5) => 0.0211470729,
      (f_rel_homeover100_count_d = NULL) => 0.0603847231, 0.0603847231),
   (phone_subject_title = '') => 0.0287511427, 0.0287511427),
(f_rel_incomeover100_count_d = NULL) => 0.0010924943, 0.0010924943);

// Tree: 690 
final_score_690 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 16.5) => 0.0008872167,
(f_rel_under100miles_cnt_d > 16.5) => 
   map(
   (pp_src in ['CY','E2','LP','SL','TN','UW','VO','ZK']) => -0.0434964959,
   (pp_src in ['E1','EB','EM','EN','EQ','FA','FF','KW','LA','MD','NW','PL','UT','VW','ZT']) => 
      map(
      (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 14.5) => 0.0287779386,
      (mth_pp_datelastseen > 14.5) => -0.0285724202,
      (mth_pp_datelastseen = NULL) => 0.0062925557, 0.0062925557),
   (pp_src = '') => -0.0148176462, -0.0135823678),
(f_rel_under100miles_cnt_d = NULL) => -0.0016416465, -0.0016416465);

// Tree: 691 
final_score_691 := map(
(pp_src in ['E1','EN','EQ','FA','LP','SL','TN','UT','VO','VW','ZT']) => 
   map(
   (NULL < f_util_add_curr_inf_n and f_util_add_curr_inf_n <= 0.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -32.5) => -0.0321153997,
      (f_addrchangecrimediff_i > -32.5) => 0.0007382817,
      (f_addrchangecrimediff_i = NULL) => 0.0030552994, -0.0057142141),
   (f_util_add_curr_inf_n > 0.5) => 0.0363521399,
   (f_util_add_curr_inf_n = NULL) => -0.0013699070, -0.0013699070),
(pp_src in ['CY','E2','EB','EM','FF','KW','LA','MD','NW','PL','UW','ZK']) => 0.0183115672,
(pp_src = '') => 0.0005289553, 0.0009998578);

// Tree: 692 
final_score_692 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 2146.5) => 0.0033588902,
(f_addrchangevaluediff_d > 2146.5) => -0.0064784194,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 545) => 0.0025719800,
   (eda_avg_days_interrupt > 545) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Daughter','Husband','Neighbor','Relative','Son','Spouse','Subject at Household','Wife']) => -0.0137866493,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Parent','Sibling','Sister','Subject']) => 0.0855129968,
      (phone_subject_title = '') => 0.0404971572, 0.0404971572),
   (eda_avg_days_interrupt = NULL) => 0.0052809212, 0.0052809212), 0.0004302741);

// Tree: 693 
final_score_693 := map(
(NULL < mth_source_md_fseen and mth_source_md_fseen <= 86.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 36.5) => 0.0029672468,
   (mth_source_utildid_fseen > 36.5) => 
      map(
      (NULL < number_of_sources and number_of_sources <= 3.5) => -0.0335576726,
      (number_of_sources > 3.5) => 0.0266402717,
      (number_of_sources = NULL) => -0.0198943234, -0.0198943234),
   (mth_source_utildid_fseen = NULL) => 0.0021470040, 0.0021470040),
(mth_source_md_fseen > 86.5) => -0.0558792410,
(mth_source_md_fseen = NULL) => 0.0016850224, 0.0016850224);

// Tree: 694 
final_score_694 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 11.5) => -0.0015869564,
(inq_adl_lastseen_n > 11.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.681231368141955) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -3524) => -0.0230279047,
      (f_addrchangeincomediff_d > -3524) => 0.0205901354,
      (f_addrchangeincomediff_d = NULL) => 0.0100510260, 0.0063135200),
   (f_add_curr_mobility_index_n > 0.681231368141955) => 0.0649641483,
   (f_add_curr_mobility_index_n = NULL) => 0.0104110296, 0.0104110296),
(inq_adl_lastseen_n = NULL) => -0.0005460352, -0.0005460352);

// Tree: 695 
final_score_695 := map(
(NULL < pp_src_cnt and pp_src_cnt <= 1.5) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 28.5) => -0.0004988910,
   (f_rel_homeover100_count_d > 28.5) => -0.0445490431,
   (f_rel_homeover100_count_d = NULL) => -0.0013221530, -0.0013221530),
(pp_src_cnt > 1.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 14.5) => 0.0261128783,
   (f_srchfraudsrchcount_i > 14.5) => -0.0359368343,
   (f_srchfraudsrchcount_i = NULL) => 0.0196419797, 0.0196419797),
(pp_src_cnt = NULL) => 0.0003960174, 0.0003960174);

// Tree: 696 
final_score_696 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 127) => 
   map(
   (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 9.5) => 0.0028746461,
   (mth_source_inf_fseen > 9.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -54.5) => 0.0272185239,
      (f_addrchangecrimediff_i > -54.5) => -0.0300658533,
      (f_addrchangecrimediff_i = NULL) => -0.0173814555, -0.0173814555),
   (mth_source_inf_fseen = NULL) => 0.0015156105, 0.0015156105),
(f_addrchangecrimediff_i > 127) => -0.0351153003,
(f_addrchangecrimediff_i = NULL) => -0.0061144016, -0.0010416070);

// Tree: 697 
final_score_697 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 12.5) => 
   map(
   (NULL < pp_app_company_type and pp_app_company_type <= 7.5) => 
      map(
      (NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 59.5) => 0.0054786605,
      (r_mos_since_paw_fseen_d > 59.5) => -0.0143914241,
      (r_mos_since_paw_fseen_d = NULL) => 0.0024248482, 0.0024248482),
   (pp_app_company_type > 7.5) => 0.0214215621,
   (pp_app_company_type = NULL) => 0.0039430135, 0.0039430135),
(f_rel_under500miles_cnt_d > 12.5) => -0.0043116747,
(f_rel_under500miles_cnt_d = NULL) => 0.0008461718, 0.0008461718);

// Tree: 698 
final_score_698 := map(
(NULL < _internal_ver_match_level and _internal_ver_match_level <= 2.5) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 17.5) => 0.0051631986,
   (f_rel_count_i > 17.5) => -0.0051971918,
   (f_rel_count_i = NULL) => 0.0013181308, 0.0013181308),
(_internal_ver_match_level > 2.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 130.5) => 0.0570355971,
   (f_prevaddrlenofres_d > 130.5) => -0.0121591741,
   (f_prevaddrlenofres_d = NULL) => 0.0288749344, 0.0288749344),
(_internal_ver_match_level = NULL) => 0.0018730740, 0.0018730740);

// Tree: 699 
final_score_699 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 4.5) => 
   map(
   (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 3.5) => 
      map(
      (NULL < f_idverrisktype_i and f_idverrisktype_i <= 7.5) => -0.0269572417,
      (f_idverrisktype_i > 7.5) => 0.0411565522,
      (f_idverrisktype_i = NULL) => -0.0100850175, -0.0100850175),
   (pp_app_ind_ph_cnt > 3.5) => -0.0601122422,
   (pp_app_ind_ph_cnt = NULL) => -0.0236375433, -0.0236375433),
(f_curraddrcrimeindex_i > 4.5) => -0.0006877236,
(f_curraddrcrimeindex_i = NULL) => -0.0014911419, -0.0014911419);

// Tree: 700 
final_score_700 := map(
(pp_source in ['GONG','INTRADO','OTHER','PCNSR','THRIVE']) => -0.0536685387,
(pp_source in ['CELL','HEADER','IBEHAVIOR','INFUTOR','INQUIRY','TARGUS']) => 
   map(
   (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 2.5) => 0.0450653371,
   (mth_pp_datelastseen > 2.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 0.0108414607,
      (f_srchvelocityrisktype_i > 5.5) => -0.0120164304,
      (f_srchvelocityrisktype_i = NULL) => 0.0006527296, 0.0006527296),
   (mth_pp_datelastseen = NULL) => 0.0034541009, 0.0034541009),
(pp_source = '') => -0.0015119891, -0.0002809776);

// Tree: 701 
final_score_701 := map(
(pp_app_scc in ['8','A','B','C','N']) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 55048) => -0.0107132846,
   (f_curraddrmedianincome_d > 55048) => 0.0074019365,
   (f_curraddrmedianincome_d = NULL) => -0.0028006355, -0.0028006355),
(pp_app_scc in ['J','R','S']) => 
   map(
   (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 83.5) => 0.0701863103,
   (mth_pp_app_npa_effective_dt > 83.5) => 0.0105704357,
   (mth_pp_app_npa_effective_dt = NULL) => 0.0183138384, 0.0183138384),
(pp_app_scc = '') => -0.0000151111, 0.0004507186);

// Tree: 702 
final_score_702 := map(
(exp_source in ['P']) => -0.0002317842,
(exp_source in ['S']) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 16.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Shared Associates','Associate By SSN','Daughter','Father','Grandfather','Grandmother','Grandparent','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Subject','Subject at Household','Wife']) => 0.0088617554,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandson','Son','Spouse']) => 0.0677918342,
      (phone_subject_title = '') => 0.0117968240, 0.0117968240),
   (f_srchfraudsrchcount_i > 16.5) => -0.0299973395,
   (f_srchfraudsrchcount_i = NULL) => 0.0083946847, 0.0083946847),
(exp_source = '') => -0.0032182242, -0.0007708110);

// Tree: 703 
final_score_703 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -4.5) => -0.0078947847,
(f_addrchangecrimediff_i > -4.5) => 
   map(
   (NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 5.5) => 0.0007257280,
   (mth_pp_first_build_date > 5.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 13.5) => 0.0267773945,
      (f_rel_educationover12_count_d > 13.5) => -0.0102204899,
      (f_rel_educationover12_count_d = NULL) => 0.0171055731, 0.0171055731),
   (mth_pp_first_build_date = NULL) => 0.0048418336, 0.0048418336),
(f_addrchangecrimediff_i = NULL) => -0.0011926964, -0.0010477013);

// Tree: 704 
final_score_704 := map(
(NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 11.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Child','Granddaughter','Grandfather','Grandmother','Grandson','Mother','Neighbor','Sibling','Sister','Spouse']) => -0.0231241313,
      (phone_subject_title in ['Associate','Associate By SSN','Associate By Vehicle','Brother','Daughter','Father','Grandchild','Grandparent','Husband','Parent','Relative','Son','Subject','Subject at Household','Wife']) => 0.0160814845,
      (phone_subject_title = '') => 0.0007602475, 0.0007602475),
   (f_inq_count_i > 11.5) => -0.0146808038,
   (f_inq_count_i = NULL) => -0.0045533840, -0.0045533840),
(_inq_adl_ph_industry_flag > 0.5) => 0.0382830296,
(_inq_adl_ph_industry_flag = NULL) => -0.0032443682, -0.0032443682);

// Tree: 705 
final_score_705 := map(
(NULL < source_edahistory and source_edahistory <= 0.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 34.5) => 
      map(
      (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0017494634,
      (_phone_match_code_n > 0.5) => 0.0105645016,
      (_phone_match_code_n = NULL) => 0.0031619051, 0.0031619051),
   (mth_source_ppdid_lseen > 34.5) => -0.0224713316,
   (mth_source_ppdid_lseen = NULL) => 0.0015386516, 0.0015386516),
(source_edahistory > 0.5) => -0.0377005497,
(source_edahistory = NULL) => 0.0005325182, 0.0005325182);

// Tree: 706 
final_score_706 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 16.5) => 
   map(
   (NULL < mth_pp_app_fb_ph7_did_dt and mth_pp_app_fb_ph7_did_dt <= 8.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -45909.5) => 0.0274717715,
      (f_addrchangeincomediff_d > -45909.5) => 0.0004045104,
      (f_addrchangeincomediff_d = NULL) => -0.0020958831, 0.0005093028),
   (mth_pp_app_fb_ph7_did_dt > 8.5) => -0.0490487870,
   (mth_pp_app_fb_ph7_did_dt = NULL) => 0.0000933406, 0.0000933406),
(f_util_adl_count_n > 16.5) => -0.0464822523,
(f_util_adl_count_n = NULL) => -0.0003484186, -0.0003484186);

// Tree: 707 
final_score_707 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 19.5) => 0.0016138372,
(mth_exp_last_update > 19.5) => 
   map(
   (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Associate By SSN','Grandfather','Grandparent','Neighbor','Parent','Relative','Sister','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 9.5) => -0.0315716296,
      (f_corraddrnamecount_d > 9.5) => 0.0109011180,
      (f_corraddrnamecount_d = NULL) => -0.0206109205, -0.0206109205),
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandmother','Grandson','Husband','Mother','Sibling','Son','Spouse']) => 0.0536716484,
   (phone_subject_title = '') => -0.0120042058, -0.0120042058),
(mth_exp_last_update = NULL) => 0.0007193609, 0.0007193609);

// Tree: 708 
final_score_708 := map(
(NULL < mth_source_ppca_lseen and mth_source_ppca_lseen <= 24.5) => 
   map(
   (NULL < mth_source_inf_lseen and mth_source_inf_lseen <= 3.5) => 0.0043708122,
   (mth_source_inf_lseen > 3.5) => 
      map(
      (NULL < mth_source_sx_fseen and mth_source_sx_fseen <= 5.5) => -0.0383435949,
      (mth_source_sx_fseen > 5.5) => 0.0125301570,
      (mth_source_sx_fseen = NULL) => -0.0211637153, -0.0211637153),
   (mth_source_inf_lseen = NULL) => 0.0031889160, 0.0031889160),
(mth_source_ppca_lseen > 24.5) => -0.0332388402,
(mth_source_ppca_lseen = NULL) => 0.0019605828, 0.0019605828);

// Tree: 709 
final_score_709 := map(
(NULL < source_pp_any_clean and source_pp_any_clean <= 0.5) => -0.0085817814,
(source_pp_any_clean > 0.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 29.5) => 
      map(
      (NULL < f_wealth_index_d and f_wealth_index_d <= 4.5) => 0.0155260293,
      (f_wealth_index_d > 4.5) => 0.0675452896,
      (f_wealth_index_d = NULL) => 0.0206671256, 0.0206671256),
   (mth_source_ppdid_lseen > 29.5) => -0.0253791262,
   (mth_source_ppdid_lseen = NULL) => 0.0122731297, 0.0122731297),
(source_pp_any_clean = NULL) => -0.0006656566, -0.0006656566);

// Tree: 710 
final_score_710 := map(
(NULL < eda_num_phs_ind and eda_num_phs_ind <= 5.5) => 
   map(
   (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 136.5) => 0.0021206491,
   (mth_source_inf_fseen > 136.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 0.5) => 0.0106415105,
      (f_srchssnsrchcount_i > 0.5) => -0.0442370922,
      (f_srchssnsrchcount_i = NULL) => -0.0216533051, -0.0216533051),
   (mth_source_inf_fseen = NULL) => 0.0014388279, 0.0014388279),
(eda_num_phs_ind > 5.5) => 0.0479143672,
(eda_num_phs_ind = NULL) => 0.0018088474, 0.0018088474);

// Tree: 711 
final_score_711 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 28787) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Father','Granddaughter','Grandparent','Grandson','Neighbor','Parent','Relative','Sister','Son','Spouse','Subject','Subject at Household']) => 
      map(
      (pp_source in ['CELL','INFUTOR','OTHER','PCNSR','THRIVE']) => -0.0260074657,
      (pp_source in ['GONG','HEADER','IBEHAVIOR','INQUIRY','INTRADO','TARGUS']) => 0.0245446008,
      (pp_source = '') => 0.0072370027, 0.0091164726),
   (phone_subject_title in ['Associate By Property','Associate By Vehicle','Daughter','Grandchild','Grandfather','Grandmother','Husband','Mother','Sibling','Wife']) => 0.0883461502,
   (phone_subject_title = '') => 0.0130669828, 0.0130669828),
(f_curraddrmedianincome_d > 28787) => 0.0003497669,
(f_curraddrmedianincome_d = NULL) => 0.0019626894, 0.0019626894);

// Tree: 712 
final_score_712 := map(
(eda_pfrd_address_ind in ['1A','1B']) => -0.0077638761,
(eda_pfrd_address_ind in ['1C','1D','1E','XX']) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 185.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 168.5) => 0.0029956472,
      (f_curraddrburglaryindex_i > 168.5) => 0.0261834883,
      (f_curraddrburglaryindex_i = NULL) => 0.0059797364, 0.0059797364),
   (f_curraddrmurderindex_i > 185.5) => -0.0221628637,
   (f_curraddrmurderindex_i = NULL) => 0.0038571476, 0.0038571476),
(eda_pfrd_address_ind = '') => -0.0014859926, -0.0014859926);

// Tree: 713 
final_score_713 := map(
(NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 21.5) => 
   map(
   (NULL < _pp_rule_ins_ver_above and _pp_rule_ins_ver_above <= 0.5) => -0.0023321520,
   (_pp_rule_ins_ver_above > 0.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 24.5) => -0.0199447158,
      (f_mos_inq_banko_cm_lseen_d > 24.5) => 0.0326665526,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0190723658, 0.0190723658),
   (_pp_rule_ins_ver_above = NULL) => -0.0015729820, -0.0015729820),
(f_rel_homeover300_count_d > 21.5) => -0.0392234471,
(f_rel_homeover300_count_d = NULL) => -0.0020245751, -0.0020245751);

// Tree: 714 
final_score_714 := map(
(NULL < mth_source_ppfa_lseen and mth_source_ppfa_lseen <= 2.5) => 
   map(
   (NULL < _pp_gender and _pp_gender <= 0.5) => 0.0006619825,
   (_pp_gender > 0.5) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 151539) => -0.0481832065,
      (f_curraddrmedianvalue_d > 151539) => 0.0008121990,
      (f_curraddrmedianvalue_d = NULL) => -0.0239461176, -0.0239461176),
   (_pp_gender = NULL) => -0.0004341727, -0.0004341727),
(mth_source_ppfa_lseen > 2.5) => 0.0311892754,
(mth_source_ppfa_lseen = NULL) => -0.0000639180, -0.0000639180);

// Tree: 715 
final_score_715 := map(
(NULL < mth_eda_deletion_date and mth_eda_deletion_date <= 50.5) => 
   map(
   (NULL < inq_lastseen_n and inq_lastseen_n <= 28.5) => 0.0024699935,
   (inq_lastseen_n > 28.5) => 
      map(
      (pp_src in ['E1','E2','EM','EQ','FA','LP','PL','SL','TN','UT','ZT']) => -0.0291901060,
      (pp_src in ['CY','EB','EN','FF','KW','LA','MD','NW','UW','VO','VW','ZK']) => 0.0264687406,
      (pp_src = '') => -0.0098925661, -0.0108646679),
   (inq_lastseen_n = NULL) => -0.0000094028, -0.0000094028),
(mth_eda_deletion_date > 50.5) => 0.0429093785,
(mth_eda_deletion_date = NULL) => 0.0005333004, 0.0005333004);

// Tree: 716 
final_score_716 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Granddaughter','Grandfather','Grandson','Neighbor','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => -0.0026957796,
(phone_subject_title in ['Associate By Business','Associate By Property','Associate By SSN','Daughter','Father','Grandchild','Grandmother','Grandparent','Husband','Mother','Parent','Subject at Household']) => 
   map(
   (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 18.5) => 
      map(
      (NULL < eda_days_in_service and eda_days_in_service <= 1967.5) => 0.0263937553,
      (eda_days_in_service > 1967.5) => -0.0305077580,
      (eda_days_in_service = NULL) => 0.0188028384, 0.0188028384),
   (mth_pp_datelastseen > 18.5) => -0.0208287216,
   (mth_pp_datelastseen = NULL) => 0.0132711606, 0.0132711606),
(phone_subject_title = '') => -0.0006599527, -0.0006599527);

// Tree: 717 
final_score_717 := map(
(NULL < mth_source_exp_lseen and mth_source_exp_lseen <= 5.5) => -0.0003471972,
(mth_source_exp_lseen > 5.5) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 11.5) => -0.0301777828,
   (mth_exp_last_update > 11.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 541.5) => -0.0179904197,
      (f_mos_inq_banko_cm_lseen_d > 541.5) => 0.0472328278,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0064682981, 0.0064682981),
   (mth_exp_last_update = NULL) => -0.0159807539, -0.0159807539),
(mth_source_exp_lseen = NULL) => -0.0011031577, -0.0011031577);

// Tree: 718 
final_score_718 := map(
(NULL < _pp_rule_ins_ver_above and _pp_rule_ins_ver_above <= 0.5) => -0.0006835540,
(_pp_rule_ins_ver_above > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 32.5) => -0.0252399272,
   (f_mos_inq_banko_om_fseen_d > 32.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.560063696358795) => 0.0187009474,
      (f_add_input_mobility_index_n > 0.560063696358795) => 0.0779697722,
      (f_add_input_mobility_index_n = NULL) => 0.0332670145, 0.0332670145),
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0229778627, 0.0229778627),
(_pp_rule_ins_ver_above = NULL) => 0.0001198426, 0.0001198426);

// Tree: 719 
final_score_719 := map(
(phone_subject_title in ['Associate By Vehicle','Child','Granddaughter','Grandmother','Grandson','Mother','Neighbor','Sister','Son','Subject at Household','Wife']) => -0.0141384291,
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Daughter','Father','Grandchild','Grandfather','Grandparent','Husband','Parent','Relative','Sibling','Spouse','Subject']) => 
   map(
   (NULL < f_college_income_d and f_college_income_d <= 3.5) => 
      map(
      (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 0.5) => -0.0337098806,
      (f_crim_rel_under500miles_cnt_i > 0.5) => 0.0370588558,
      (f_crim_rel_under500miles_cnt_i = NULL) => 0.0190264373, 0.0190264373),
   (f_college_income_d > 3.5) => -0.0083294131,
   (f_college_income_d = NULL) => 0.0043949157, 0.0032399188),
(phone_subject_title = '') => -0.0008498224, -0.0008498224);

// Tree: 720 
final_score_720 := map(
(NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 81.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 5.5) => 
      map(
      (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 2.5) => 0.0013855128,
      (f_srchfraudsrchcountyr_i > 2.5) => -0.0165390484,
      (f_srchfraudsrchcountyr_i = NULL) => -0.0000264353, -0.0000264353),
   (f_rel_felony_count_i > 5.5) => 0.0365138622,
   (f_rel_felony_count_i = NULL) => 0.0007250473, 0.0007250473),
(mth_pp_orig_lastseen > 81.5) => -0.0500562291,
(mth_pp_orig_lastseen = NULL) => -0.0000419337, -0.0000419337);

// Tree: 721 
final_score_721 := map(
(pp_source in ['CELL','GONG','OTHER','PCNSR','THRIVE']) => -0.0428204778,
(pp_source in ['HEADER','IBEHAVIOR','INFUTOR','INQUIRY','INTRADO','TARGUS']) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 0.0178887869,
   (f_srchvelocityrisktype_i > 5.5) => -0.0065848733,
   (f_srchvelocityrisktype_i = NULL) => 0.0069495828, 0.0069495828),
(pp_source = '') => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => -0.0078010599,
   (source_rel > 0.5) => 0.0247068810,
   (source_rel = NULL) => -0.0056593447, -0.0056593447), -0.0016848270);

// Tree: 722 
final_score_722 := map(
(pp_source in ['CELL','GONG','HEADER','INFUTOR','INQUIRY','INTRADO','OTHER','THRIVE']) => 
   map(
   (NULL < pp_app_latest_ph_owner_fl and pp_app_latest_ph_owner_fl <= 0.5) => 0.0513936752,
   (pp_app_latest_ph_owner_fl > 0.5) => -0.0030070408,
   (pp_app_latest_ph_owner_fl = NULL) => -0.0014164756, -0.0014164756),
(pp_source in ['IBEHAVIOR','PCNSR','TARGUS']) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 118) => 0.0293580018,
   (f_curraddrcartheftindex_i > 118) => -0.0124556930,
   (f_curraddrcartheftindex_i = NULL) => 0.0154201035, 0.0154201035),
(pp_source = '') => 0.0004537858, 0.0004226625);

// Tree: 723 
final_score_723 := map(
(pp_rp_source in ['GONG','IBEHAVIOR','INQUIRY','INTRADO','OTHER','THRIVE']) => -0.0177718943,
(pp_rp_source in ['CELL','HEADER','INFUTOR','PCNSR','TARGUS']) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 17.5) => -0.0223980098,
   (f_prevaddrlenofres_d > 17.5) => 
      map(
      (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 1.5) => 0.0563405348,
      (f_rel_homeover200_count_d > 1.5) => 0.0051310715,
      (f_rel_homeover200_count_d = NULL) => 0.0271136704, 0.0271136704),
   (f_prevaddrlenofres_d = NULL) => 0.0163830021, 0.0163830021),
(pp_rp_source = '') => 0.0000774382, 0.0003475573);

// Tree: 724 
final_score_724 := map(
(NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 1905.5) => -0.0009661291,
(eda_max_days_interrupt > 1905.5) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By Vehicle','Brother','Child','Father','Mother','Neighbor','Son','Subject','Wife']) => -0.0132816136,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Parent','Relative','Sibling','Sister','Spouse','Subject at Household']) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 0.1347973925,
      (f_corraddrnamecount_d > 3.5) => 0.0361351147,
      (f_corraddrnamecount_d = NULL) => 0.0825148180, 0.0825148180),
   (phone_subject_title = '') => 0.0313724999, 0.0313724999),
(eda_max_days_interrupt = NULL) => -0.0000157725, -0.0000157725);

// Tree: 725 
final_score_725 := map(
(NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => 
   map(
   (NULL < number_of_sources and number_of_sources <= 1.5) => -0.0087440238,
   (number_of_sources > 1.5) => 
      map(
      (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 0.5) => 0.0217163581,
      (f_srchunvrfdphonecount_i > 0.5) => -0.0200837671,
      (f_srchunvrfdphonecount_i = NULL) => 0.0130652287, 0.0130652287),
   (number_of_sources = NULL) => -0.0033642675, -0.0033642675),
(_inq_adl_ph_industry_flag > 0.5) => 0.0463149819,
(_inq_adl_ph_industry_flag = NULL) => -0.0017647131, -0.0017647131);

// Tree: 726 
final_score_726 := map(
(NULL < eda_days_in_service and eda_days_in_service <= 67.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Father','Grandmother','Neighbor','Parent','Sibling','Spouse','Subject','Subject at Household']) => 
      map(
      (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 3.5) => 0.0037513646,
      (f_srchaddrsrchcountmo_i > 3.5) => 0.0577600059,
      (f_srchaddrsrchcountmo_i = NULL) => 0.0045114959, 0.0045114959),
   (phone_subject_title in ['Associate By Property','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Mother','Relative','Sister','Son','Wife']) => 0.0883995247,
   (phone_subject_title = '') => 0.0056361619, 0.0056361619),
(eda_days_in_service > 67.5) => -0.0045242418,
(eda_days_in_service = NULL) => 0.0004447321, 0.0004447321);

// Tree: 727 
final_score_727 := map(
(NULL < source_sx and source_sx <= 0.5) => -0.0013617635,
(source_sx > 0.5) => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 1639.5) => 0.0476661431,
   (eda_days_ph_first_seen > 1639.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 157.5) => 0.0152552339,
      (f_curraddrcartheftindex_i > 157.5) => -0.0288688617,
      (f_curraddrcartheftindex_i = NULL) => 0.0051078321, 0.0051078321),
   (eda_days_ph_first_seen = NULL) => 0.0125487308, 0.0125487308),
(source_sx = NULL) => -0.0005979160, -0.0005979160);

// Tree: 728 
final_score_728 := map(
(NULL < mth_source_ppca_fseen and mth_source_ppca_fseen <= 112.5) => 
   map(
   (NULL < r_has_paw_source_d and r_has_paw_source_d <= 0.5) => -0.0034291962,
   (r_has_paw_source_d > 0.5) => 
      map(
      (NULL < f_idrisktype_i and f_idrisktype_i <= 1.5) => 0.0061644407,
      (f_idrisktype_i > 1.5) => -0.0333520893,
      (f_idrisktype_i = NULL) => 0.0047431654, 0.0047431654),
   (r_has_paw_source_d = NULL) => 0.0010686359, 0.0010686359),
(mth_source_ppca_fseen > 112.5) => -0.0540684320,
(mth_source_ppca_fseen = NULL) => 0.0007200348, 0.0007200348);

// Tree: 729 
final_score_729 := map(
(NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 143) => 
   map(
   (pp_glb_dppa_fl in ['G']) => -0.0045166306,
   (pp_glb_dppa_fl in ['B','D','U']) => 0.0148460627,
   (pp_glb_dppa_fl = '') => 
      map(
      (NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0000161617,
      (_pp_rule_high_vend_conf > 0.5) => 0.0223549255,
      (_pp_rule_high_vend_conf = NULL) => 0.0016415608, 0.0016415608), -0.0001311223),
(mth_source_ppdid_fseen > 143) => 0.0426593358,
(mth_source_ppdid_fseen = NULL) => 0.0001544480, 0.0001544480);

// Tree: 730 
final_score_730 := map(
(NULL < _pp_src_all_eq and _pp_src_all_eq <= 0.5) => 
   map(
   (NULL < f_estimated_income_d and f_estimated_income_d <= 84500) => -0.0035584309,
   (f_estimated_income_d > 84500) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -217218) => -0.0463783675,
      (f_addrchangevaluediff_d > -217218) => 0.0119311190,
      (f_addrchangevaluediff_d = NULL) => 0.0102249971, 0.0087746617),
   (f_estimated_income_d = NULL) => -0.0017863847, -0.0017863847),
(_pp_src_all_eq > 0.5) => 0.0518615508,
(_pp_src_all_eq = NULL) => -0.0014283550, -0.0014283550);

// Tree: 731 
final_score_731 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Child','Granddaughter','Grandson','Husband','Neighbor','Parent','Sibling','Sister','Son','Subject']) => -0.0030600555,
(phone_subject_title in ['Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Daughter','Father','Grandchild','Grandfather','Grandmother','Grandparent','Mother','Relative','Spouse','Subject at Household','Wife']) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => 0.0046557742,
   (f_sourcerisktype_i > 5.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 6869.5) => 0.0815690664,
      (f_addrchangevaluediff_d > 6869.5) => 0.0244446395,
      (f_addrchangevaluediff_d = NULL) => 0.0108021386, 0.0442831011),
   (f_sourcerisktype_i = NULL) => 0.0128536284, 0.0128536284),
(phone_subject_title = '') => -0.0002410175, -0.0002410175);

// Tree: 732 
final_score_732 := map(
(NULL < inq_num_adls and inq_num_adls <= 1.5) => 0.0025419385,
(inq_num_adls > 1.5) => 
   map(
   (NULL < pk_cell_indicator and pk_cell_indicator <= 2.5) => -0.0024853313,
   (pk_cell_indicator > 2.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.35062014420875) => -0.0499552170,
      (f_add_input_mobility_index_n > 0.35062014420875) => -0.0143248650,
      (f_add_input_mobility_index_n = NULL) => -0.0282881110, -0.0282881110),
   (pk_cell_indicator = NULL) => -0.0057142987, -0.0057142987),
(inq_num_adls = NULL) => 0.0008193516, 0.0008193516);

// Tree: 733 
final_score_733 := map(
(NULL < f_inq_per_addr_i and f_inq_per_addr_i <= 21.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 177.5) => -0.0002604161,
   (f_curraddrcrimeindex_i > 177.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Father','Mother','Neighbor','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0065213221,
      (phone_subject_title in ['Associate By Business','Brother','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Parent','Relative']) => 0.0833918810,
      (phone_subject_title = '') => 0.0128518387, 0.0128518387),
   (f_curraddrcrimeindex_i = NULL) => 0.0013249916, 0.0013249916),
(f_inq_per_addr_i > 21.5) => -0.0381592837,
(f_inq_per_addr_i = NULL) => 0.0008442090, 0.0008442090);

// Tree: 734 
final_score_734 := map(
(NULL < pk_cell_indicator and pk_cell_indicator <= 3.5) => -0.0044177269,
(pk_cell_indicator > 3.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 76514.5) => 
      map(
      (NULL < mth_source_exp_fseen and mth_source_exp_fseen <= 6.5) => 0.0193146760,
      (mth_source_exp_fseen > 6.5) => -0.0161997594,
      (mth_source_exp_fseen = NULL) => 0.0092565197, 0.0092565197),
   (f_curraddrmedianincome_d > 76514.5) => 0.0451908031,
   (f_curraddrmedianincome_d = NULL) => 0.0161864896, 0.0161864896),
(pk_cell_indicator = NULL) => -0.0015156226, -0.0015156226);

// Tree: 735 
final_score_735 := map(
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Granddaughter','Grandmother','Grandson','Mother','Neighbor','Sister','Subject','Subject at Household']) => -0.0017222501,
(phone_subject_title in ['Associate','Associate By Property','Daughter','Father','Grandchild','Grandfather','Grandparent','Husband','Parent','Relative','Sibling','Son','Spouse','Wife']) => 
   map(
   (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => 
      map(
      (NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 1066.5) => -0.0028092893,
      (eda_max_days_interrupt > 1066.5) => 0.0522525701,
      (eda_max_days_interrupt = NULL) => 0.0056106329, 0.0056106329),
   (_phone_match_code_n > 0.5) => 0.0241765723,
   (_phone_match_code_n = NULL) => 0.0097250893, 0.0097250893),
(phone_subject_title = '') => -0.0000107113, -0.0000107113);

// Tree: 736 
final_score_736 := map(
(NULL < f_college_income_d and f_college_income_d <= 3.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Brother','Daughter','Mother','Sister','Subject at Household']) => -0.0449715032,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Son','Spouse','Subject','Wife']) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 79) => 0.0525359796,
      (mth_pp_app_npa_last_change_dt > 79) => -0.0149648074,
      (mth_pp_app_npa_last_change_dt = NULL) => 0.0362857901, 0.0362857901),
   (phone_subject_title = '') => 0.0202759888, 0.0202759888),
(f_college_income_d > 3.5) => -0.0032549089,
(f_college_income_d = NULL) => -0.0018350152, -0.0013133489);

// Tree: 737 
final_score_737 := map(
(NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 5.5) => 0.0004894759,
(f_crim_rel_under25miles_cnt_i > 5.5) => 
   map(
   (exp_type in ['C']) => -0.0264494729,
   (exp_type in ['N']) => 0.0287223934,
   (exp_type = '') => 
      map(
      (phone_subject_title in ['Associate','Associate By SSN','Associate By Vehicle','Grandfather','Grandmother','Husband','Mother','Parent','Sibling','Spouse','Subject at Household']) => -0.0439521907,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandparent','Grandson','Neighbor','Relative','Sister','Son','Subject','Wife']) => -0.0082005688,
      (phone_subject_title = '') => -0.0145399139, -0.0145399139), -0.0130465142),
(f_crim_rel_under25miles_cnt_i = NULL) => -0.0007743070, -0.0007743070);

// Tree: 738 
final_score_738 := map(
(NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 139) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 90.5) => 0.0028941982,
   (mth_source_ppdid_fseen > 90.5) => 
      map(
      (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 2.5) => -0.0039267758,
      (f_rel_incomeover75_count_d > 2.5) => -0.0608431521,
      (f_rel_incomeover75_count_d = NULL) => -0.0267526142, -0.0267526142),
   (mth_source_ppdid_fseen = NULL) => 0.0022203277, 0.0022203277),
(mth_pp_datefirstseen > 139) => 0.0492663454,
(mth_pp_datefirstseen = NULL) => 0.0024957405, 0.0024957405);

// Tree: 739 
final_score_739 := map(
(NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 5.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 35.5) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 57.5) => 0.0013845147,
      (f_srchaddrsrchcount_i > 57.5) => 0.0369009878,
      (f_srchaddrsrchcount_i = NULL) => 0.0017434827, 0.0017434827),
   (f_rel_ageover30_count_d > 35.5) => -0.0290476464,
   (f_rel_ageover30_count_d = NULL) => 0.0012047563, 0.0012047563),
(f_srchaddrsrchcountmo_i > 5.5) => 0.0530813427,
(f_srchaddrsrchcountmo_i = NULL) => 0.0015085189, 0.0015085189);

// Tree: 740 
final_score_740 := map(
(exp_source in ['P']) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 85406) => 0.0014727271,
   (f_curraddrmedianincome_d > 85406) => -0.0525089447,
   (f_curraddrmedianincome_d = NULL) => -0.0075623408, -0.0075623408),
(exp_source in ['S']) => 
   map(
   (phone_subject_title in ['Associate','Associate By SSN','Father','Grandfather','Grandmother','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Subject at Household','Wife']) => -0.0178885671,
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandparent','Grandson','Spouse','Subject']) => 0.0074847304,
   (phone_subject_title = '') => 0.0046067046, 0.0046067046),
(exp_source = '') => -0.0021604856, -0.0011667364);

// Tree: 741 
final_score_741 := map(
(NULL < eda_num_phs_ind and eda_num_phs_ind <= 3.5) => 
   map(
   (exp_source in ['P']) => 
      map(
      (NULL < eda_days_in_service and eda_days_in_service <= 134) => -0.0632375818,
      (eda_days_in_service > 134) => -0.0034752765,
      (eda_days_in_service = NULL) => -0.0118256260, -0.0118256260),
   (exp_source in ['S']) => 0.0026965429,
   (exp_source = '') => -0.0004999413, -0.0003622985),
(eda_num_phs_ind > 3.5) => 0.0285908345,
(eda_num_phs_ind = NULL) => 0.0000343198, 0.0000343198);

// Tree: 742 
final_score_742 := map(
(NULL < f_util_add_curr_inf_n and f_util_add_curr_inf_n <= 0.5) => -0.0026574489,
(f_util_add_curr_inf_n > 0.5) => 
   map(
   (NULL < inq_lastseen_n and inq_lastseen_n <= 24.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 8.5) => 0.0136636764,
      (f_srchssnsrchcount_i > 8.5) => 0.0606102463,
      (f_srchssnsrchcount_i = NULL) => 0.0224527603, 0.0224527603),
   (inq_lastseen_n > 24.5) => -0.0224231386,
   (inq_lastseen_n = NULL) => 0.0121210507, 0.0121210507),
(f_util_add_curr_inf_n = NULL) => -0.0016729077, -0.0016729077);

// Tree: 743 
final_score_743 := map(
(NULL < _pp_app_nonpub_gong_la and _pp_app_nonpub_gong_la <= 0.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 0.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 470.5) => -0.0043270254,
      (r_pb_order_freq_d > 470.5) => 0.0349553855,
      (r_pb_order_freq_d = NULL) => -0.0044143638, -0.0035710275),
   (f_rel_homeover300_count_d > 0.5) => 0.0035091893,
   (f_rel_homeover300_count_d = NULL) => -0.0002430651, -0.0002430651),
(_pp_app_nonpub_gong_la > 0.5) => 0.0291791463,
(_pp_app_nonpub_gong_la = NULL) => 0.0000531894, 0.0000531894);

// Tree: 744 
final_score_744 := map(
(NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 67.5) => 
   map(
   (NULL < eda_address_match_best and eda_address_match_best <= 0.5) => 0.0001681672,
   (eda_address_match_best > 0.5) => 
      map(
      (phone_subject_title in ['Associate','Brother','Father','Husband','Mother','Neighbor','Parent','Son','Subject','Subject at Household']) => 0.0100769229,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Relative','Sibling','Sister','Spouse','Wife']) => 0.1019401725,
      (phone_subject_title = '') => 0.0208086109, 0.0208086109),
   (eda_address_match_best = NULL) => 0.0013156033, 0.0013156033),
(mth_eda_dt_first_seen > 67.5) => -0.0210036001,
(mth_eda_dt_first_seen = NULL) => -0.0008846975, -0.0008846975);

// Tree: 745 
final_score_745 := map(
(NULL < eda_num_phs_connected_addr and eda_num_phs_connected_addr <= 1.5) => 
   map(
   (NULL < f_college_income_d and f_college_income_d <= 5.5) => 
      map(
      (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 39.5) => -0.0012043763,
      (mth_pp_datevendorfirstseen > 39.5) => 0.0457455057,
      (mth_pp_datevendorfirstseen = NULL) => 0.0041560433, 0.0041560433),
   (f_college_income_d > 5.5) => -0.0127715324,
   (f_college_income_d = NULL) => 0.0014556036, 0.0008780745),
(eda_num_phs_connected_addr > 1.5) => -0.0360874544,
(eda_num_phs_connected_addr = NULL) => 0.0004149775, 0.0004149775);

// Tree: 746 
final_score_746 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 21.5) => 
   map(
   (NULL < inq_num_addresses and inq_num_addresses <= 0.5) => -0.0425874763,
   (inq_num_addresses > 0.5) => 0.0041523764,
   (inq_num_addresses = NULL) => -0.0187286393, -0.0187286393),
(f_mos_inq_banko_cm_fseen_d > 21.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 483.5) => 0.0026767742,
   (f_prevaddrageoldest_d > 483.5) => -0.0451865179,
   (f_prevaddrageoldest_d = NULL) => 0.0023884412, 0.0023884412),
(f_mos_inq_banko_cm_fseen_d = NULL) => 0.0017973904, 0.0017973904);

// Tree: 747 
final_score_747 := map(
(NULL < number_of_sources and number_of_sources <= 1.5) => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => -0.0153931767,
   (source_rel > 0.5) => 0.0352327742,
   (source_rel = NULL) => -0.0129766827, -0.0129766827),
(number_of_sources > 1.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.0385301972,
   (f_srchvelocityrisktype_i > 4.5) => 0.0041881883,
   (f_srchvelocityrisktype_i = NULL) => 0.0240251160, 0.0240251160),
(number_of_sources = NULL) => -0.0032940904, -0.0032940904);

// Tree: 748 
final_score_748 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 20.5) => -0.0019654155,
(f_rel_under100miles_cnt_d > 20.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 17148.5) => -0.0021686277,
   (f_addrchangeincomediff_d > 17148.5) => 0.0330109420,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Brother','Child','Father','Grandfather','Neighbor','Parent','Relative','Sister']) => -0.0315385597,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Mother','Sibling','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0327766228,
      (phone_subject_title = '') => 0.0103021724, 0.0103021724), 0.0074056808),
(f_rel_under100miles_cnt_d = NULL) => -0.0009044951, -0.0009044951);

// Tree: 749 
final_score_749 := map(
(NULL < _internal_ver_match_hhid and _internal_ver_match_hhid <= 0.5) => -0.0013463277,
(_internal_ver_match_hhid > 0.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -2014.5) => 
      map(
      (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 51.5) => 0.0439846021,
      (mth_pp_eda_hist_did_dt > 51.5) => -0.0058413940,
      (mth_pp_eda_hist_did_dt = NULL) => 0.0254323695, 0.0254323695),
   (f_addrchangevaluediff_d > -2014.5) => -0.0014256928,
   (f_addrchangevaluediff_d = NULL) => 0.0090457069, 0.0092225530),
(_internal_ver_match_hhid = NULL) => -0.0005989206, -0.0005989206);

// Tree: 750 
final_score_750 := map(
(NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 0.5) => -0.0040966395,
(inq_adl_firstseen_n > 0.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 8.5) => 0.0499096695,
   (f_inq_count_i > 8.5) => 
      map(
      (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 5.5) => 0.0779493449,
      (inq_adl_lastseen_n > 5.5) => 0.0043956258,
      (inq_adl_lastseen_n = NULL) => 0.0106407529, 0.0106407529),
   (f_inq_count_i = NULL) => 0.0219465830, 0.0219465830),
(inq_adl_firstseen_n = NULL) => -0.0009193725, -0.0009193725);

// Tree: 751 
final_score_751 := map(
(NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 1.5) => 
   map(
   (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 8.5) => 0.0006122975,
   (f_rel_bankrupt_count_i > 8.5) => -0.0192941132,
   (f_rel_bankrupt_count_i = NULL) => -0.0000460857, -0.0000460857),
(f_divaddrsuspidcountnew_i > 1.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 41435.5) => 0.0039738231,
   (f_addrchangevaluediff_d > 41435.5) => 0.0715099523,
   (f_addrchangevaluediff_d = NULL) => 0.0223095487, 0.0213627935),
(f_divaddrsuspidcountnew_i = NULL) => 0.0007485068, 0.0007485068);

// Tree: 752 
final_score_752 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 10.5) => 
   map(
   (NULL < number_of_sources and number_of_sources <= 1.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Relative','Sibling','Sister','Spouse','Subject']) => -0.0079393013,
      (phone_subject_title in ['Associate','Associate By Property','Associate By Vehicle','Daughter','Father','Grandchild','Granddaughter','Grandparent','Parent','Son','Subject at Household','Wife']) => 0.0172389600,
      (phone_subject_title = '') => -0.0030953617, -0.0030953617),
   (number_of_sources > 1.5) => 0.0169177880,
   (number_of_sources = NULL) => 0.0016630366, 0.0016630366),
(f_inq_count_i > 10.5) => -0.0094771274,
(f_inq_count_i = NULL) => -0.0027335382, -0.0027335382);

// Tree: 753 
final_score_753 := map(
(NULL < _pp_rule_low_vend_conf and _pp_rule_low_vend_conf <= 0.5) => -0.0010076089,
(_pp_rule_low_vend_conf > 0.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 55.5) => 0.0564851813,
   (f_prevaddrmurderindex_i > 55.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 158.5) => -0.0214091221,
      (f_prevaddrmurderindex_i > 158.5) => 0.0284559215,
      (f_prevaddrmurderindex_i = NULL) => 0.0023974149, 0.0023974149),
   (f_prevaddrmurderindex_i = NULL) => 0.0178510624, 0.0178510624),
(_pp_rule_low_vend_conf = NULL) => -0.0005284692, -0.0005284692);

// Tree: 754 
final_score_754 := map(
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Father','Granddaughter','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Wife']) => -0.0249247340,
(phone_subject_title in ['Associate','Associate By Vehicle','Grandchild','Grandparent','Subject','Subject at Household']) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 25.5) => 
      map(
      (NULL < mth_source_ppth_fseen and mth_source_ppth_fseen <= 15.5) => 0.0272512228,
      (mth_source_ppth_fseen > 15.5) => -0.0387265288,
      (mth_source_ppth_fseen = NULL) => 0.0221456055, 0.0221456055),
   (mth_source_ppdid_lseen > 25.5) => -0.0226914077,
   (mth_source_ppdid_lseen = NULL) => 0.0156309893, 0.0156309893),
(phone_subject_title = '') => -0.0026691813, -0.0026691813);

// Tree: 755 
final_score_755 := map(
(NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 8.5) => -0.0009862680,
(f_rel_incomeover75_count_d > 8.5) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 24.5) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 11.5) => 0.0089664409,
      (f_rel_homeover300_count_d > 11.5) => 0.0413414837,
      (f_rel_homeover300_count_d = NULL) => 0.0221105318, 0.0221105318),
   (f_rel_incomeover25_count_d > 24.5) => -0.0114356044,
   (f_rel_incomeover25_count_d = NULL) => 0.0110715839, 0.0110715839),
(f_rel_incomeover75_count_d = NULL) => -0.0002111305, -0.0002111305);

// Tree: 756 
final_score_756 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 28175) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.291677808040245) => -0.0141489735,
   (f_add_input_mobility_index_n > 0.291677808040245) => 0.0191142785,
   (f_add_input_mobility_index_n = NULL) => 0.0127029159, 0.0127029159),
(f_curraddrmedianincome_d > 28175) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 134.5) => 0.0033673412,
   (f_fp_prevaddrburglaryindex_i > 134.5) => -0.0075690407,
   (f_fp_prevaddrburglaryindex_i = NULL) => -0.0005390281, -0.0005390281),
(f_curraddrmedianincome_d = NULL) => 0.0010268732, 0.0010268732);

// Tree: 757 
final_score_757 := map(
(NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 1.5) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 104.5) => 
      map(
      (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 3.5) => 0.0179817375,
      (pp_app_ind_ph_cnt > 3.5) => 0.0580714362,
      (pp_app_ind_ph_cnt = NULL) => 0.0287417432, 0.0287417432),
   (mth_pp_app_npa_last_change_dt > 104.5) => -0.0201810476,
   (mth_pp_app_npa_last_change_dt = NULL) => 0.0189233284, 0.0189233284),
(f_sourcerisktype_i > 1.5) => -0.0009543420,
(f_sourcerisktype_i = NULL) => -0.0002815880, -0.0002815880);

// Tree: 758 
final_score_758 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 2145) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Child','Daughter','Father','Granddaughter','Grandfather','Grandmother','Neighbor','Parent','Sister','Son','Wife']) => -0.0040377448,
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Grandchild','Grandparent','Grandson','Husband','Mother','Relative','Sibling','Spouse','Subject','Subject at Household']) => 0.0082965844,
   (phone_subject_title = '') => 0.0029523034, 0.0029523034),
(f_addrchangevaluediff_d > 2145) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 101.5) => -0.0031117381,
   (mth_source_ppdid_fseen > 101.5) => -0.0519427293,
   (mth_source_ppdid_fseen = NULL) => -0.0040290596, -0.0040290596),
(f_addrchangevaluediff_d = NULL) => 0.0001570876, -0.0001732524);

// Tree: 759 
final_score_759 := map(
(NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 194.5) => -0.0013434846,
(f_prevaddrmurderindex_i > 194.5) => 
   map(
   (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 4.5) => 0.0673797583,
   (f_rel_homeover50_count_d > 4.5) => 
      map(
      (NULL < eda_has_cur_discon_30_days and eda_has_cur_discon_30_days <= 0.5) => -0.0081599683,
      (eda_has_cur_discon_30_days > 0.5) => 0.0585266406,
      (eda_has_cur_discon_30_days = NULL) => 0.0079650724, 0.0079650724),
   (f_rel_homeover50_count_d = NULL) => 0.0184027875, 0.0184027875),
(f_prevaddrmurderindex_i = NULL) => -0.0006589903, -0.0006589903);

// Tree: 760 
final_score_760 := map(
(NULL < phone_business_count and phone_business_count <= 7.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 183.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 195.5) => 0.0013460128,
      (f_curraddrburglaryindex_i > 195.5) => 0.0330386067,
      (f_curraddrburglaryindex_i = NULL) => 0.0018372748, 0.0018372748),
   (f_curraddrcartheftindex_i > 183.5) => -0.0100878571,
   (f_curraddrcartheftindex_i = NULL) => 0.0006978683, 0.0006978683),
(phone_business_count > 7.5) => -0.0409899567,
(phone_business_count = NULL) => 0.0004391803, 0.0004391803);

// Tree: 761 
final_score_761 := map(
(NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 90.5) => 
   map(
   (NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 65.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => -0.0307524591,
      (f_assocrisktype_i > 5.5) => 0.0048292398,
      (f_assocrisktype_i = NULL) => -0.0174289155, -0.0174289155),
   (f_mos_inq_banko_am_lseen_d > 65.5) => -0.0000797605,
   (f_mos_inq_banko_am_lseen_d = NULL) => -0.0005441230, -0.0005441230),
(mth_source_ppla_fseen > 90.5) => -0.0360086392,
(mth_source_ppla_fseen = NULL) => -0.0007891068, -0.0007891068);

// Tree: 762 
final_score_762 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 338199) => -0.0022466849,
(f_curraddrmedianvalue_d > 338199) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Daughter','Grandson','Husband','Mother','Neighbor','Sibling','Sister','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 104711.5) => 0.0007705194,
      (f_curraddrmedianincome_d > 104711.5) => 0.0230200797,
      (f_curraddrmedianincome_d = NULL) => 0.0062809245, 0.0062809245),
   (phone_subject_title in ['Associate By Property','Associate By SSN','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Parent','Relative','Son','Spouse']) => 0.0589347306,
   (phone_subject_title = '') => 0.0102401995, 0.0102401995),
(f_curraddrmedianvalue_d = NULL) => -0.0005551587, -0.0005551587);

// Tree: 763 
final_score_763 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 7.5) => 
   map(
   (exp_type in ['C']) => -0.0022808699,
   (exp_type in ['N']) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 111) => -0.0074933807,
      (f_curraddrmurderindex_i > 111) => 0.0223318455,
      (f_curraddrmurderindex_i = NULL) => 0.0070131959, 0.0070131959),
   (exp_type = '') => -0.0006162217, -0.0001298143),
(f_rel_homeover500_count_d > 7.5) => -0.0208395835,
(f_rel_homeover500_count_d = NULL) => -0.0005410893, -0.0005410893);

// Tree: 764 
final_score_764 := map(
(NULL < mth_source_md_fseen and mth_source_md_fseen <= 82.5) => 
   map(
   (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 12.5) => 0.0009932198,
   (mth_source_inf_fseen > 12.5) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 2.5) => 0.0236496704,
      (f_rel_ageover30_count_d > 2.5) => -0.0162791042,
      (f_rel_ageover30_count_d = NULL) => -0.0118846660, -0.0118846660),
   (mth_source_inf_fseen = NULL) => 0.0001897785, 0.0001897785),
(mth_source_md_fseen > 82.5) => -0.0410585963,
(mth_source_md_fseen = NULL) => -0.0001869190, -0.0001869190);

// Tree: 765 
final_score_765 := map(
(pp_glb_dppa_fl in ['U']) => -0.0157198010,
(pp_glb_dppa_fl in ['B','D','G']) => -0.0028755351,
(pp_glb_dppa_fl = '') => 
   map(
   (NULL < pk_cell_indicator and pk_cell_indicator <= 3.5) => 0.0016956299,
   (pk_cell_indicator > 3.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 76.5) => -0.0023547776,
      (f_prevaddrageoldest_d > 76.5) => 0.0287459811,
      (f_prevaddrageoldest_d = NULL) => 0.0161065102, 0.0161065102),
   (pk_cell_indicator = NULL) => 0.0027553686, 0.0027553686), 0.0005132048);

// Tree: 766 
final_score_766 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => -0.0017580604,
(f_rel_felony_count_i > 4.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 196965.5) => 
      map(
      (NULL < f_srchunvrfdssncount_i and f_srchunvrfdssncount_i <= 0.5) => -0.0009528078,
      (f_srchunvrfdssncount_i > 0.5) => 0.0474522606,
      (f_srchunvrfdssncount_i = NULL) => 0.0098694636, 0.0098694636),
   (f_prevaddrmedianvalue_d > 196965.5) => 0.0567558598,
   (f_prevaddrmedianvalue_d = NULL) => 0.0183090149, 0.0183090149),
(f_rel_felony_count_i = NULL) => -0.0010531280, -0.0010531280);

// Tree: 767 
final_score_767 := map(
(NULL < inq_lastseen_n and inq_lastseen_n <= 3.5) => 
   map(
   (phone_subject_title in ['Associate By Property','Associate By Vehicle','Child','Grandfather','Grandmother','Grandson','Husband','Neighbor','Parent','Son','Subject at Household','Wife']) => -0.0106690999,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Daughter','Father','Grandchild','Granddaughter','Grandparent','Mother','Relative','Sibling','Sister','Spouse','Subject']) => 0.0045711282,
   (phone_subject_title = '') => 0.0012773628, 0.0012773628),
(inq_lastseen_n > 3.5) => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 2613.5) => -0.0091200345,
   (eda_days_ph_first_seen > 2613.5) => 0.0017568250,
   (eda_days_ph_first_seen = NULL) => -0.0040881556, -0.0040881556),
(inq_lastseen_n = NULL) => -0.0013529411, -0.0013529411);

// Tree: 768 
final_score_768 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 286.5) => 0.0019845442,
(f_prevaddrlenofres_d > 286.5) => 
   map(
   (pp_app_ph_use in ['B','O']) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 4.5) => -0.0490875816,
      (f_rel_under25miles_cnt_d > 4.5) => -0.0099723397,
      (f_rel_under25miles_cnt_d = NULL) => -0.0205833894, -0.0205833894),
   (pp_app_ph_use in ['P']) => 0.0023767200,
   (pp_app_ph_use = '') => -0.0074397780, -0.0084637965),
(f_prevaddrlenofres_d = NULL) => 0.0008736434, 0.0008736434);

// Tree: 769 
final_score_769 := map(
(NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 8.5) => -0.0001480757,
(f_rel_incomeover75_count_d > 8.5) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 31.5) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 13.5) => -0.0106528606,
      (f_rel_ageover30_count_d > 13.5) => 0.0372111170,
      (f_rel_ageover30_count_d = NULL) => 0.0238092033, 0.0238092033),
   (f_rel_count_i > 31.5) => -0.0152083569,
   (f_rel_count_i = NULL) => 0.0122946225, 0.0122946225),
(f_rel_incomeover75_count_d = NULL) => 0.0006295930, 0.0006295930);

// Tree: 770 
final_score_770 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 0.0018364353,
(f_util_adl_count_n > 3.5) => 
   map(
   (NULL < f_estimated_income_d and f_estimated_income_d <= 64500) => 0.0000469816,
   (f_estimated_income_d > 64500) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 181.5) => -0.0098010346,
      (f_curraddrmurderindex_i > 181.5) => -0.0444265572,
      (f_curraddrmurderindex_i = NULL) => -0.0117694105, -0.0117694105),
   (f_estimated_income_d = NULL) => -0.0044304437, -0.0044304437),
(f_util_adl_count_n = NULL) => -0.0004122727, -0.0004122727);

// Tree: 771 
final_score_771 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 50.5) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 1.5) => 0.0004298831,
   (inq_adl_firstseen_n > 1.5) => 
      map(
      (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 3.5) => 0.0158346403,
      (mth_source_utildid_fseen > 3.5) => -0.0053541032,
      (mth_source_utildid_fseen = NULL) => 0.0094419294, 0.0094419294),
   (inq_adl_firstseen_n = NULL) => 0.0013131432, 0.0013131432),
(inq_adl_lastseen_n > 50.5) => -0.0234534927,
(inq_adl_lastseen_n = NULL) => 0.0008665840, 0.0008665840);

// Tree: 772 
final_score_772 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 119556.5) => -0.0022250250,
(f_addrchangevaluediff_d > 119556.5) => 0.0097981017,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 13.5) => -0.0018473415,
   (f_rel_ageover30_count_d > 13.5) => 
      map(
      (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 14.5) => 0.0511457273,
      (f_rel_incomeover25_count_d > 14.5) => 0.0058623887,
      (f_rel_incomeover25_count_d = NULL) => 0.0113490614, 0.0113490614),
   (f_rel_ageover30_count_d = NULL) => 0.0019484639, 0.0019484639), -0.0002384671);

// Tree: 773 
final_score_773 := map(
(NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 4.5) => -0.0004446066,
(f_rel_ageover50_count_d > 4.5) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 4.5) => -0.0153150210,
   (f_rel_homeover100_count_d > 4.5) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 19.5) => 0.0617906775,
      (f_rel_ageover30_count_d > 19.5) => 0.0135443034,
      (f_rel_ageover30_count_d = NULL) => 0.0356572249, 0.0356572249),
   (f_rel_homeover100_count_d = NULL) => 0.0184787332, 0.0184787332),
(f_rel_ageover50_count_d = NULL) => -0.0000423134, -0.0000423134);

// Tree: 774 
final_score_774 := map(
(NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 24.5) => 
   map(
   (exp_source in ['P']) => 0.0020410600,
   (exp_source in ['S']) => 0.0053869372,
   (exp_source = '') => -0.0011139659, 0.0003188765),
(mth_source_ppla_fseen > 24.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -30.5) => 0.0463717550,
   (f_addrchangecrimediff_i > -30.5) => 0.0171875019,
   (f_addrchangecrimediff_i = NULL) => -0.0105063150, 0.0171718976),
(mth_source_ppla_fseen = NULL) => 0.0008358524, 0.0008358524);

// Tree: 775 
final_score_775 := map(
(NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 158.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 198.5) => -0.0009326984,
   (f_fp_prevaddrburglaryindex_i > 198.5) => -0.0314954515,
   (f_fp_prevaddrburglaryindex_i = NULL) => -0.0011937326, -0.0011937326),
(mth_source_cr_fseen > 158.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 125044) => 0.0575480316,
   (f_prevaddrmedianvalue_d > 125044) => 0.0034993323,
   (f_prevaddrmedianvalue_d = NULL) => 0.0283325185, 0.0283325185),
(mth_source_cr_fseen = NULL) => -0.0008100054, -0.0008100054);

// Tree: 776 
final_score_776 := map(
(NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0003846631,
(_pp_rule_high_vend_conf > 0.5) => 
   map(
   (NULL < mth_source_ppca_lseen and mth_source_ppca_lseen <= 16.5) => 
      map(
      (pp_src in ['CY','E1','EM','EQ','FA','LP','SL','TN','UT','ZK','ZT']) => -0.0026735890,
      (pp_src in ['E2','EB','EN','FF','KW','LA','MD','NW','PL','UW','VO','VW']) => 0.0265210532,
      (pp_src = '') => 0.0125001125, 0.0101575422),
   (mth_source_ppca_lseen > 16.5) => -0.0178399619,
   (mth_source_ppca_lseen = NULL) => 0.0056675647, 0.0056675647),
(_pp_rule_high_vend_conf = NULL) => 0.0006095150, 0.0006095150);

// Tree: 777 
final_score_777 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 86603) => -0.0023776175,
(f_curraddrmedianincome_d > 86603) => 
   map(
   (phone_subject_title in ['Associate By Shared Associates','Child','Husband','Neighbor','Parent','Relative','Sibling','Son','Spouse']) => -0.0238133180,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Sister','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 2.5) => 0.0006724803,
      (r_pb_order_freq_d > 2.5) => 0.0321240931,
      (r_pb_order_freq_d = NULL) => 0.0197442306, 0.0190703477),
   (phone_subject_title = '') => 0.0087709763, 0.0087709763),
(f_curraddrmedianincome_d = NULL) => -0.0011491834, -0.0011491834);

// Tree: 778 
final_score_778 := map(
(NULL < f_inq_per_addr_i and f_inq_per_addr_i <= 14.5) => 
   map(
   (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0013918935,
   (_phone_match_code_n > 0.5) => 0.0035425957,
   (_phone_match_code_n = NULL) => 0.0007516462, 0.0007516462),
(f_inq_per_addr_i > 14.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= -0.5) => 0.0152648324,
   (r_pb_order_freq_d > -0.5) => -0.0235733541,
   (r_pb_order_freq_d = NULL) => -0.0306931083, -0.0156537605),
(f_inq_per_addr_i = NULL) => 0.0002599258, 0.0002599258);

// Tree: 779 
final_score_779 := map(
(NULL < pp_did_score and pp_did_score <= 79.5) => 
   map(
   (NULL < pp_src_cnt and pp_src_cnt <= 2.5) => 0.0003671550,
   (pp_src_cnt > 2.5) => 0.0279262839,
   (pp_src_cnt = NULL) => 0.0007928652, 0.0007928652),
(pp_did_score > 79.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 107482.5) => -0.0193483087,
   (f_prevaddrmedianvalue_d > 107482.5) => -0.0019493915,
   (f_prevaddrmedianvalue_d = NULL) => -0.0078689198, -0.0078689198),
(pp_did_score = NULL) => -0.0003845534, -0.0003845534);

// Tree: 780 
final_score_780 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 12.5) => -0.0004913031,
(inq_adl_lastseen_n > 12.5) => 
   map(
   (pp_glb_dppa_fl in ['U']) => -0.0134138266,
   (pp_glb_dppa_fl in ['B','D','G']) => 0.0031884714,
   (pp_glb_dppa_fl = '') => 
      map(
      (segment in ['0 - Disconnected','3 - ExpHit']) => 0.0108294944,
      (segment in ['1 - Other','2 - Cell Phone']) => 0.0553841480,
      (segment = '') => 0.0233529646, 0.0233529646), 0.0069682921),
(inq_adl_lastseen_n = NULL) => 0.0001366619, 0.0001366619);

// Tree: 781 
final_score_781 := map(
(NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 1.5) => -0.0004802250,
(f_divaddrsuspidcountnew_i > 1.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Daughter','Granddaughter','Grandfather','Husband','Neighbor','Relative','Sibling','Sister','Son','Wife']) => -0.0086751404,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Grandmother','Grandparent','Grandson','Mother','Parent','Spouse','Subject','Subject at Household']) => 
      map(
      (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 4.5) => 0.0417173399,
      (mth_pp_datelastseen > 4.5) => 0.0061310241,
      (mth_pp_datelastseen = NULL) => 0.0246123152, 0.0246123152),
   (phone_subject_title = '') => 0.0108233368, 0.0108233368),
(f_divaddrsuspidcountnew_i = NULL) => -0.0000711841, -0.0000711841);

// Tree: 782 
final_score_782 := map(
(eda_pfrd_address_ind in ['1A','1B','1E','XX']) => -0.0009673182,
(eda_pfrd_address_ind in ['1C','1D']) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Grandfather','Grandmother','Mother','Neighbor','Parent','Sibling','Sister','Son']) => 0.0015160468,
   (phone_subject_title in ['Daughter','Father','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Relative','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 19.5) => 0.0128938453,
      (f_rel_count_i > 19.5) => 0.0675507304,
      (f_rel_count_i = NULL) => 0.0292581822, 0.0292581822),
   (phone_subject_title = '') => 0.0130121674, 0.0130121674),
(eda_pfrd_address_ind = '') => -0.0003077077, -0.0003077077);

// Tree: 783 
final_score_783 := map(
(NULL < inq_lastseen_n and inq_lastseen_n <= 38.5) => 
   map(
   (pp_app_scc in ['A','C','J','N']) => -0.0004299892,
   (pp_app_scc in ['8','B','R','S']) => 
      map(
      (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 12.5) => 0.0229959206,
      (f_rel_ageover20_count_d > 12.5) => -0.0015460444,
      (f_rel_ageover20_count_d = NULL) => 0.0105781058, 0.0105781058),
   (pp_app_scc = '') => -0.0000701603, 0.0006153271),
(inq_lastseen_n > 38.5) => -0.0116450706,
(inq_lastseen_n = NULL) => -0.0008861804, -0.0008861804);

// Tree: 784 
final_score_784 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 10.5) => 
   map(
   (exp_type in ['C']) => 
      map(
      (pp_src in ['E2','EN','FA','UW']) => -0.0312365048,
      (pp_src in ['CY','E1','EB','EM','EQ','FF','KW','LA','LP','MD','NW','PL','SL','TN','UT','VO','VW','ZK','ZT']) => 0.0092661302,
      (pp_src = '') => 0.0033962025, 0.0022822996),
   (exp_type in ['N']) => 0.0101186734,
   (exp_type = '') => 0.0011158958, 0.0022118746),
(f_inq_count_i > 10.5) => -0.0038495061,
(f_inq_count_i = NULL) => -0.0001400064, -0.0001400064);

// Tree: 785 
final_score_785 := map(
(NULL < mth_source_edahistory_fseen and mth_source_edahistory_fseen <= 13.5) => 
   map(
   (NULL < _pp_origlistingtype_res and _pp_origlistingtype_res <= 0.5) => 0.0010944629,
   (_pp_origlistingtype_res > 0.5) => 
      map(
      (NULL < mth_pp_datevendorlastseen and mth_pp_datevendorlastseen <= 4.5) => 0.0001224206,
      (mth_pp_datevendorlastseen > 4.5) => -0.0122561899,
      (mth_pp_datevendorlastseen = NULL) => -0.0039358059, -0.0039358059),
   (_pp_origlistingtype_res = NULL) => -0.0003708631, -0.0003708631),
(mth_source_edahistory_fseen > 13.5) => -0.0167528213,
(mth_source_edahistory_fseen = NULL) => -0.0007659789, -0.0007659789);

// Tree: 786 
final_score_786 := map(
(NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 7.5) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 12.5) => 
      map(
      (pp_source in ['CELL','IBEHAVIOR','INFUTOR','INQUIRY','INTRADO','OTHER']) => -0.0028577089,
      (pp_source in ['GONG','HEADER','PCNSR','TARGUS','THRIVE']) => 0.0134425027,
      (pp_source = '') => -0.0026002094, -0.0009593716),
   (f_rel_count_i > 12.5) => -0.0146576461,
   (f_rel_count_i = NULL) => -0.0031123097, -0.0031123097),
(f_rel_educationover12_count_d > 7.5) => 0.0014463066,
(f_rel_educationover12_count_d = NULL) => -0.0003383842, -0.0003383842);

// Tree: 787 
final_score_787 := map(
(NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 185.5) => 0.0012160980,
(f_curraddrmurderindex_i > 185.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.680979536640125) => 
      map(
      (NULL < pk_cell_indicator and pk_cell_indicator <= 0.5) => -0.0038090238,
      (pk_cell_indicator > 0.5) => -0.0242030506,
      (pk_cell_indicator = NULL) => -0.0106294315, -0.0106294315),
   (f_add_input_mobility_index_n > 0.680979536640125) => 0.0204952736,
   (f_add_input_mobility_index_n = NULL) => -0.0069650403, -0.0069650403),
(f_curraddrmurderindex_i = NULL) => 0.0005550927, 0.0005550927);

// Tree: 788 
final_score_788 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 1.36340510930894) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 49.5) => 0.0054870369,
   (f_curraddrcartheftindex_i > 49.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 239.5) => 0.0005187906,
      (f_prevaddrlenofres_d > 239.5) => -0.0089154482,
      (f_prevaddrlenofres_d = NULL) => -0.0009177531, -0.0009177531),
   (f_curraddrcartheftindex_i = NULL) => 0.0006026106, 0.0006026106),
(f_add_input_mobility_index_n > 1.36340510930894) => -0.0325282469,
(f_add_input_mobility_index_n = NULL) => -0.0043305112, 0.0002256948);

// Tree: 789 
final_score_789 := map(
(NULL < _pp_agegroup and _pp_agegroup <= 1.5) => 0.0008672984,
(_pp_agegroup > 1.5) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 0.5) => 0.0054367136,
   (f_rel_homeover200_count_d > 0.5) => 
      map(
      (pp_src in ['E1','EM','EN','PL','VO','ZT']) => -0.0416550294,
      (pp_src in ['CY','E2','EB','EQ','FA','FF','KW','LA','LP','MD','NW','SL','TN','UT','UW','VW','ZK']) => -0.0088272082,
      (pp_src = '') => -0.0107072317, -0.0212360884),
   (f_rel_homeover200_count_d = NULL) => -0.0142583934, -0.0142583934),
(_pp_agegroup = NULL) => 0.0004458120, 0.0004458120);

// Tree: 790 
final_score_790 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 16.5) => 
   map(
   (NULL < number_of_sources and number_of_sources <= 1.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject']) => -0.0046654259,
      (phone_subject_title in ['Associate','Daughter','Father','Grandchild','Grandfather','Mother','Subject at Household','Wife']) => 0.0106109602,
      (phone_subject_title = '') => -0.0015983522, -0.0015983522),
   (number_of_sources > 1.5) => 0.0100436372,
   (number_of_sources = NULL) => 0.0013724960, 0.0013724960),
(f_inq_count_i > 16.5) => -0.0083416967,
(f_inq_count_i = NULL) => -0.0008253984, -0.0008253984);

// Tree: 791 
final_score_791 := map(
(NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 35.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 186.5) => -0.0000471449,
   (f_curraddrmurderindex_i > 186.5) => 
      map(
      (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 1.5) => -0.0139603902,
      (inq_adl_firstseen_n > 1.5) => 0.0117502600,
      (inq_adl_firstseen_n = NULL) => -0.0108042925, -0.0108042925),
   (f_curraddrmurderindex_i = NULL) => -0.0008968286, -0.0008968286),
(f_rel_homeover100_count_d > 35.5) => 0.0241654622,
(f_rel_homeover100_count_d = NULL) => -0.0007290402, -0.0007290402);

// Tree: 792 
final_score_792 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 1.5) => 0.0009118115,
(f_varrisktype_i > 1.5) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 3.5) => -0.0152745327,
   (f_inq_count24_i > 3.5) => 
      map(
      (NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 5.5) => 0.0066330655,
      (mth_pp_orig_lastseen > 5.5) => -0.0112052054,
      (mth_pp_orig_lastseen = NULL) => -0.0008849797, -0.0008849797),
   (f_inq_count24_i = NULL) => -0.0055599095, -0.0055599095),
(f_varrisktype_i = NULL) => -0.0005530405, -0.0005530405);

// Tree: 793 
final_score_793 := map(
(pp_app_scc in ['8','A','B','C','R']) => -0.0015412548,
(pp_app_scc in ['J','N','S']) => 
   map(
   (NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 20.5) => 0.0025270351,
   (mth_source_ppfla_fseen > 20.5) => 0.0251058034,
   (mth_source_ppfla_fseen = NULL) => 0.0049750915, 0.0049750915),
(pp_app_scc = '') => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 177.5) => -0.0033168638,
   (f_curraddrcrimeindex_i > 177.5) => 0.0156897315,
   (f_curraddrcrimeindex_i = NULL) => -0.0008955616, -0.0008955616), -0.0003462052);

// Tree: 794 
final_score_794 := map(
(pp_app_scc in ['8','B','C','N','R']) => -0.0004130727,
(pp_app_scc in ['A','J','S']) => 
   map(
   (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 90.5) => 
      map(
      (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 14.5) => 0.0484802972,
      (mth_pp_datevendorfirstseen > 14.5) => 0.0066652285,
      (mth_pp_datevendorfirstseen = NULL) => 0.0258464526, 0.0258464526),
   (mth_pp_app_npa_effective_dt > 90.5) => 0.0040903611,
   (mth_pp_app_npa_effective_dt = NULL) => 0.0074540688, 0.0074540688),
(pp_app_scc = '') => -0.0020897819, -0.0006698758);

// Tree: 795 
final_score_795 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 18.5) => -0.0008784918,
(f_rel_homeover200_count_d > 18.5) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 21.5) => -0.0116336848,
   (f_mos_inq_banko_om_lseen_d > 21.5) => 
      map(
      (phone_subject_title in ['Associate By Business','Associate By SSN','Daughter','Husband','Neighbor','Parent','Relative','Sister','Son','Subject at Household','Wife']) => -0.0122506392,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Sibling','Spouse','Subject']) => 0.0264742682,
      (phone_subject_title = '') => 0.0171682827, 0.0171682827),
   (f_mos_inq_banko_om_lseen_d = NULL) => 0.0087808966, 0.0087808966),
(f_rel_homeover200_count_d = NULL) => -0.0004657168, -0.0004657168);

// Tree: 796 
final_score_796 := map(
(NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0110516953,
(_phone_match_code_n > 0.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 17.5) => 
      map(
      (NULL < mth_source_ppth_fseen and mth_source_ppth_fseen <= 22.5) => 0.0190718075,
      (mth_source_ppth_fseen > 22.5) => -0.0261638132,
      (mth_source_ppth_fseen = NULL) => 0.0148435522, 0.0148435522),
   (mth_source_ppdid_lseen > 17.5) => -0.0055512396,
   (mth_source_ppdid_lseen = NULL) => 0.0092295020, 0.0092295020),
(_phone_match_code_n = NULL) => -0.0022182971, -0.0022182971);

// Tree: 797 
final_score_797 := map(
(NULL < f_idrisktype_i and f_idrisktype_i <= 1.5) => 0.0004245671,
(f_idrisktype_i > 1.5) => 
   map(
   (NULL < f_estimated_income_d and f_estimated_income_d <= 41500) => 0.0034159394,
   (f_estimated_income_d > 41500) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 17.5) => -0.0049683279,
      (f_addrchangecrimediff_i > 17.5) => -0.0412303518,
      (f_addrchangecrimediff_i = NULL) => -0.0350890068, -0.0217316367),
   (f_estimated_income_d = NULL) => -0.0106894999, -0.0106894999),
(f_idrisktype_i = NULL) => -0.0000348316, -0.0000348316);

// Tree: 798 
final_score_798 := map(
(NULL < _pp_origlistingtype_res and _pp_origlistingtype_res <= 0.5) => 
   map(
   (NULL < pp_total_source_conf and pp_total_source_conf <= 9.5) => 0.0000781402,
   (pp_total_source_conf > 9.5) => 0.0097225643,
   (pp_total_source_conf = NULL) => 0.0014786975, 0.0014786975),
(_pp_origlistingtype_res > 0.5) => 
   map(
   (NULL < _pp_hhid_flag and _pp_hhid_flag <= 0.5) => 0.0164074552,
   (_pp_hhid_flag > 0.5) => -0.0048346115,
   (_pp_hhid_flag = NULL) => -0.0039789919, -0.0039789919),
(_pp_origlistingtype_res = NULL) => -0.0000759868, -0.0000759868);

// Tree: 799 
final_score_799 := map(
(NULL < source_rel and source_rel <= 0.5) => 0.0010644011,
(source_rel > 0.5) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 9.5) => 
      map(
      (NULL < eda_has_cur_discon_90_days and eda_has_cur_discon_90_days <= 0.5) => 0.0157237307,
      (eda_has_cur_discon_90_days > 0.5) => -0.0104587170,
      (eda_has_cur_discon_90_days = NULL) => 0.0008634225, 0.0008634225),
   (f_rel_educationover12_count_d > 9.5) => 0.0182985319,
   (f_rel_educationover12_count_d = NULL) => 0.0088672593, 0.0088672593),
(source_rel = NULL) => 0.0013777579, 0.0013777579);

// Tree: 800 
final_score_800 := map(
(NULL < eda_min_days_connected_ind and eda_min_days_connected_ind <= 5.5) => 
   map(
   (NULL < f_estimated_income_d and f_estimated_income_d <= 119500) => 0.0012632723,
   (f_estimated_income_d > 119500) => 
      map(
      (phone_subject_title in ['Associate','Associate By Business','Brother','Daughter','Father','Husband','Mother','Neighbor','Son','Subject at Household','Wife']) => -0.0108271962,
      (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Parent','Relative','Sibling','Sister','Spouse','Subject']) => 0.0336994481,
      (phone_subject_title = '') => 0.0188572334, 0.0188572334),
   (f_estimated_income_d = NULL) => 0.0015862158, 0.0015862158),
(eda_min_days_connected_ind > 5.5) => -0.0117738490,
(eda_min_days_connected_ind = NULL) => 0.0010105802, 0.0010105802);

// Tree: 801 
final_score_801 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 85.5) => -0.0018579364,
(f_prevaddrlenofres_d > 85.5) => 
   map(
   (pp_rp_source in ['GONG','HEADER','IBEHAVIOR','OTHER','TARGUS']) => -0.0207454603,
   (pp_rp_source in ['CELL','INFUTOR','INQUIRY','INTRADO','PCNSR','THRIVE']) => 0.0109151005,
   (pp_rp_source = '') => 
      map(
      (NULL < source_edaca and source_edaca <= 0.5) => 0.0028595163,
      (source_edaca > 0.5) => 0.0229206665,
      (source_edaca = NULL) => 0.0034274990, 0.0034274990), 0.0033622042),
(f_prevaddrlenofres_d = NULL) => 0.0009532377, 0.0009532377);

// Tree: 802 
final_score_802 := map(
(NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 37.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 6.5) => 0.0364969295,
   (f_prevaddrlenofres_d > 6.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 6.5) => 0.0109814210,
      (f_assocrisktype_i > 6.5) => -0.0078511112,
      (f_assocrisktype_i = NULL) => 0.0039580674, 0.0039580674),
   (f_prevaddrlenofres_d = NULL) => 0.0076264311, 0.0076264311),
(f_mos_acc_lseen_d > 37.5) => -0.0009213103,
(f_mos_acc_lseen_d = NULL) => -0.0002376111, -0.0002376111);

// Tree: 803 
final_score_803 := map(
(pp_src in ['E1','E2','EQ','LP','PL','SL','TN','UT','UW','ZT']) => 
   map(
   (NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 5.5) => 0.0037532284,
   (mth_internal_ver_first_seen > 5.5) => -0.0067639957,
   (mth_internal_ver_first_seen = NULL) => -0.0012054078, -0.0012054078),
(pp_src in ['CY','EB','EM','EN','FA','FF','KW','LA','MD','NW','VO','VW','ZK']) => 
   map(
   (NULL < f_wealth_index_d and f_wealth_index_d <= 2.5) => 0.0332454621,
   (f_wealth_index_d > 2.5) => 0.0012824173,
   (f_wealth_index_d = NULL) => 0.0110892606, 0.0110892606),
(pp_src = '') => 0.0000227026, 0.0001555525);

// Tree: 804 
final_score_804 := map(
(NULL < mth_source_cr_lseen and mth_source_cr_lseen <= 5.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 1.00151791727026) => 0.0007937238,
   (f_add_curr_mobility_index_n > 1.00151791727026) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Brother','Father','Mother','Neighbor','Relative','Sibling','Sister']) => -0.0079719778,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Parent','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0210082764,
      (phone_subject_title = '') => 0.0098469623, 0.0098469623),
   (f_add_curr_mobility_index_n = NULL) => 0.0176942651, 0.0011024038),
(mth_source_cr_lseen > 5.5) => -0.0300516284,
(mth_source_cr_lseen = NULL) => 0.0007595307, 0.0007595307);

// Tree: 805 
final_score_805 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 49.5) => 
   map(
   (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 6.5) => 0.0015095334,
   (mth_source_inf_fseen > 6.5) => 
      map(
      (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 1552) => 0.0134785328,
      (eda_days_ph_first_seen > 1552) => -0.0114764868,
      (eda_days_ph_first_seen = NULL) => -0.0071509501, -0.0071509501),
   (mth_source_inf_fseen = NULL) => 0.0009680598, 0.0009680598),
(inq_adl_lastseen_n > 49.5) => -0.0168944106,
(inq_adl_lastseen_n = NULL) => 0.0006669012, 0.0006669012);

// Tree: 806 
final_score_806 := map(
(NULL < pk_phone_match_level and pk_phone_match_level <= 1.5) => -0.0170529886,
(pk_phone_match_level > 1.5) => 
   map(
   (exp_source in ['S']) => 0.0277186204,
   (exp_source in ['P']) => 0.0352649661,
   (exp_source = '') => 
      map(
      (NULL < _phone_match_code_l and _phone_match_code_l <= 0.5) => 0.0380990580,
      (_phone_match_code_l > 0.5) => -0.0005861545,
      (_phone_match_code_l = NULL) => 0.0044928003, 0.0044928003), 0.0143541727),
(pk_phone_match_level = NULL) => -0.0016196839, -0.0016196839);

// Tree: 807 
final_score_807 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Granddaughter','Grandmother','Grandson','Husband','Neighbor','Parent','Sister','Son','Subject','Wife']) => -0.0011993669,
(phone_subject_title in ['Associate By Property','Associate By Vehicle','Daughter','Father','Grandchild','Grandfather','Grandparent','Mother','Relative','Sibling','Spouse','Subject at Household']) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 16.5) => 
      map(
      (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 2.5) => 0.0065424376,
      (mth_source_ppdid_lseen > 2.5) => 0.0307534122,
      (mth_source_ppdid_lseen = NULL) => 0.0077120499, 0.0077120499),
   (mth_source_ppdid_lseen > 16.5) => -0.0222379432,
   (mth_source_ppdid_lseen = NULL) => 0.0063099397, 0.0063099397),
(phone_subject_title = '') => -0.0000537602, -0.0000537602);

// Tree: 808 
final_score_808 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0010022786,
(source_utildid > 0.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 15.5) => -0.0128040211,
   (f_prevaddrageoldest_d > 15.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.194984263423625) => -0.0119043558,
      (f_add_curr_mobility_index_n > 0.194984263423625) => 0.0101044149,
      (f_add_curr_mobility_index_n = NULL) => 0.0084140331, 0.0084140331),
   (f_prevaddrageoldest_d = NULL) => 0.0050180578, 0.0050180578),
(source_utildid = NULL) => -0.0004517713, -0.0004517713);

// Tree: 809 
final_score_809 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 27.5) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 18.5) => 0.0000419255,
   (inq_adl_firstseen_n > 18.5) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 5.5) => 0.0369837018,
      (f_rel_ageover30_count_d > 5.5) => 0.0088803932,
      (f_rel_ageover30_count_d = NULL) => 0.0147312527, 0.0147312527),
   (inq_adl_firstseen_n = NULL) => 0.0005755238, 0.0005755238),
(inq_adl_lastseen_n > 27.5) => -0.0096774609,
(inq_adl_lastseen_n = NULL) => 0.0000713377, 0.0000713377);

// Tree: 810 
final_score_810 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Brother','Child','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Relative','Sibling','Sister','Subject','Subject at Household','Wife']) => 
   map(
   (NULL < pp_app_ind_has_actv_eda_ph_fl and pp_app_ind_has_actv_eda_ph_fl <= 0.5) => -0.0014275136,
   (pp_app_ind_has_actv_eda_ph_fl > 0.5) => 0.0045934825,
   (pp_app_ind_has_actv_eda_ph_fl = NULL) => -0.0006948037, -0.0006948037),
(phone_subject_title in ['Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Daughter','Father','Grandchild','Grandfather','Parent','Son','Spouse']) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -56.5) => 0.0303535513,
   (f_addrchangecrimediff_i > -56.5) => 0.0006242490,
   (f_addrchangecrimediff_i = NULL) => 0.0258411772, 0.0118461527),
(phone_subject_title = '') => -0.0001955735, -0.0001955735);

// Tree: 811 
final_score_811 := map(
(pp_src in ['E1','EM','EQ','FA','LP','PL','SL','UT','UW','VW','ZT']) => -0.0036280896,
(pp_src in ['CY','E2','EB','EN','FF','KW','LA','MD','NW','TN','VO','ZK']) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 3.5) => 0.0306788118,
   (f_inq_count_i > 3.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => -0.0238023979,
      (f_mos_inq_banko_om_fseen_d > 36.5) => 0.0111817953,
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0036137862, 0.0036137862),
   (f_inq_count_i = NULL) => 0.0082010787, 0.0082010787),
(pp_src = '') => -0.0004955121, -0.0007507937);

// Tree: 812 
final_score_812 := map(
(NULL < mth_source_paw_lseen and mth_source_paw_lseen <= 0.5) => 
   map(
   (NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 346) => 0.0006189447,
   (eda_max_days_interrupt > 346) => -0.0072458943,
   (eda_max_days_interrupt = NULL) => -0.0009643285, -0.0009643285),
(mth_source_paw_lseen > 0.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 62.5) => 0.0315415527,
   (r_pb_order_freq_d > 62.5) => -0.0090748347,
   (r_pb_order_freq_d = NULL) => 0.0133342066, 0.0133342066),
(mth_source_paw_lseen = NULL) => -0.0007199091, -0.0007199091);

// Tree: 813 
final_score_813 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 9.5) => -0.0011513083,
(f_rel_homeover200_count_d > 9.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Grandmother','Husband','Neighbor','Parent','Relative','Sibling','Sister','Subject','Subject at Household','Wife']) => 
      map(
      (pp_src in ['CY','EN','PL','SL','TN','UW','VO','ZK']) => 0.0038214651,
      (pp_src in ['E1','E2','EB','EM','EQ','FA','FF','KW','LA','LP','MD','NW','UT','VW','ZT']) => 0.0145660991,
      (pp_src = '') => 0.0000640342, 0.0028361473),
   (phone_subject_title in ['Associate By Property','Associate By SSN','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Mother','Son','Spouse']) => 0.0333892102,
   (phone_subject_title = '') => 0.0043691985, 0.0043691985),
(f_rel_homeover200_count_d = NULL) => -0.0002333862, -0.0002333862);

// Tree: 814 
final_score_814 := map(
(NULL < f_mos_foreclosure_lseen_d and f_mos_foreclosure_lseen_d <= 45.5) => 
   map(
   (NULL < f_mos_foreclosure_lseen_d and f_mos_foreclosure_lseen_d <= 35.5) => -0.0046776153,
   (f_mos_foreclosure_lseen_d > 35.5) => -0.0351671989,
   (f_mos_foreclosure_lseen_d = NULL) => -0.0121809112, -0.0121809112),
(f_mos_foreclosure_lseen_d > 45.5) => 
   map(
   (NULL < eda_min_days_interrupt and eda_min_days_interrupt <= 13.5) => 0.0005262665,
   (eda_min_days_interrupt > 13.5) => -0.0105725603,
   (eda_min_days_interrupt = NULL) => -0.0000471639, -0.0000471639),
(f_mos_foreclosure_lseen_d = NULL) => -0.0004108922, -0.0004108922);

// Tree: 815 
final_score_815 := map(
(pp_rp_source in ['GONG','INQUIRY','INTRADO','OTHER','TARGUS']) => -0.0152940382,
(pp_rp_source in ['CELL','HEADER','IBEHAVIOR','INFUTOR','PCNSR','THRIVE']) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 34949) => 0.0227900606,
   (f_prevaddrmedianincome_d > 34949) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.53063896748646) => 0.0023935080,
      (f_add_input_mobility_index_n > 0.53063896748646) => -0.0223799277,
      (f_add_input_mobility_index_n = NULL) => -0.0038309734, -0.0038309734),
   (f_prevaddrmedianincome_d = NULL) => 0.0026987142, 0.0026987142),
(pp_rp_source = '') => 0.0004026527, 0.0003103276);

// Tree: 816 
final_score_816 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 156953) => -0.0018646126,
(f_curraddrmedianvalue_d > 156953) => 
   map(
   (NULL < f_util_add_curr_inf_n and f_util_add_curr_inf_n <= 0.5) => 0.0011847159,
   (f_util_add_curr_inf_n > 0.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Father','Grandmother','Neighbor','Relative','Sister','Son','Spouse','Subject']) => 0.0095356564,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Mother','Parent','Sibling','Subject at Household','Wife']) => 0.0379332405,
      (phone_subject_title = '') => 0.0136512483, 0.0136512483),
   (f_util_add_curr_inf_n = NULL) => 0.0022623790, 0.0022623790),
(f_curraddrmedianvalue_d = NULL) => 0.0000640553, 0.0000640553);

// Tree: 817 
final_score_817 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.318509844739345) => -0.0022289814,
(f_add_curr_mobility_index_n > 0.318509844739345) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 188.5) => 0.0035145375,
   (f_curraddrcartheftindex_i > 188.5) => 
      map(
      (NULL < inq_num_adls and inq_num_adls <= 1.5) => -0.0134845940,
      (inq_num_adls > 1.5) => 0.0122656660,
      (inq_num_adls = NULL) => -0.0071117932, -0.0071117932),
   (f_curraddrcartheftindex_i = NULL) => 0.0024092034, 0.0024092034),
(f_add_curr_mobility_index_n = NULL) => -0.0103458464, 0.0002830289);

// Tree: 818 
final_score_818 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 3.5) => 
   map(
   (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 28.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 103760) => -0.0088183665,
      (f_curraddrmedianincome_d > 103760) => 0.0175398916,
      (f_curraddrmedianincome_d = NULL) => -0.0069831703, -0.0069831703),
   (mth_pp_datevendorfirstseen > 28.5) => 0.0078089299,
   (mth_pp_datevendorfirstseen = NULL) => -0.0048024693, -0.0048024693),
(f_rel_under100miles_cnt_d > 3.5) => 0.0003793439,
(f_rel_under100miles_cnt_d = NULL) => -0.0005534555, -0.0005534555);

// Tree: 819 
final_score_819 := map(
(NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 9.5) => -0.0009172820,
(f_rel_incomeover75_count_d > 9.5) => 
   map(
   (NULL < eda_days_in_service and eda_days_in_service <= 269.5) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 3.5) => 0.0235810959,
      (f_inq_count24_i > 3.5) => -0.0009273452,
      (f_inq_count24_i = NULL) => 0.0146047533, 0.0146047533),
   (eda_days_in_service > 269.5) => -0.0061377873,
   (eda_days_in_service = NULL) => 0.0062465797, 0.0062465797),
(f_rel_incomeover75_count_d = NULL) => -0.0005746626, -0.0005746626);

// Tree: 820 
final_score_820 := map(
(NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 38.5) => -0.0007976209,
(mth_source_ppla_fseen > 38.5) => 
   map(
   (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 163) => -0.0087652667,
   (mth_pp_app_npa_effective_dt > 163) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -3.5) => 0.0380812659,
      (f_addrchangecrimediff_i > -3.5) => 0.0072479618,
      (f_addrchangecrimediff_i = NULL) => 0.0230968564, 0.0230968564),
   (mth_pp_app_npa_effective_dt = NULL) => 0.0112908019, 0.0112908019),
(mth_source_ppla_fseen = NULL) => -0.0004805847, -0.0004805847);

// Tree: 821 
final_score_821 := map(
(NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 196.5) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 191.5) => -0.0001985990,
   (f_curraddrburglaryindex_i > 191.5) => -0.0135362718,
   (f_curraddrburglaryindex_i = NULL) => -0.0005436897, -0.0005436897),
(f_curraddrburglaryindex_i > 196.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 62673) => -0.0002347015,
   (f_curraddrmedianvalue_d > 62673) => 0.0303689371,
   (f_curraddrmedianvalue_d = NULL) => 0.0142617589, 0.0142617589),
(f_curraddrburglaryindex_i = NULL) => -0.0002801426, -0.0002801426);

// Tree: 822 
final_score_822 := map(
(NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 95.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -64142.5) => 0.0193010587,
   (f_addrchangeincomediff_d > -64142.5) => 0.0010157356,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 2.5) => -0.0065133520,
      (f_srchvelocityrisktype_i > 2.5) => 0.0038700057,
      (f_srchvelocityrisktype_i = NULL) => -0.0013681804, -0.0013681804), 0.0006136396),
(mth_source_ppfla_fseen > 95.5) => -0.0221285001,
(mth_source_ppfla_fseen = NULL) => 0.0004725164, 0.0004725164);

// Tree: 823 
final_score_823 := map(
(NULL < _pp_rule_iq_rpc and _pp_rule_iq_rpc <= 0.5) => 0.0007207864,
(_pp_rule_iq_rpc > 0.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 6.5) => 
      map(
      (NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 1.5) => -0.0145696084,
      (f_inq_per_ssn_i > 1.5) => 0.0240245446,
      (f_inq_per_ssn_i = NULL) => 0.0010201480, 0.0010201480),
   (mth_source_ppdid_fseen > 6.5) => -0.0133409223,
   (mth_source_ppdid_fseen = NULL) => -0.0055041017, -0.0055041017),
(_pp_rule_iq_rpc = NULL) => 0.0004496638, 0.0004496638);

// Tree: 824 
final_score_824 := map(
(NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 64.5) => 
   map(
   (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 27.5) => -0.0000599296,
   (mth_pp_datefirstseen > 27.5) => 
      map(
      (NULL < f_util_add_input_inf_n and f_util_add_input_inf_n <= 0.5) => 0.0035742660,
      (f_util_add_input_inf_n > 0.5) => 0.0224931962,
      (f_util_add_input_inf_n = NULL) => 0.0048569054, 0.0048569054),
   (mth_pp_datefirstseen = NULL) => 0.0006798346, 0.0006798346),
(mth_pp_orig_lastseen > 64.5) => -0.0115187706,
(mth_pp_orig_lastseen = NULL) => 0.0002427929, 0.0002427929);

// Tree: 825 
final_score_825 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 38.5) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 31.5) => 0.0009981523,
   (f_rel_incomeover25_count_d > 31.5) => -0.0100430232,
   (f_rel_incomeover25_count_d = NULL) => 0.0005796821, 0.0005796821),
(inq_adl_lastseen_n > 38.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 3.5) => -0.0000981481,
   (f_srchfraudsrchcount_i > 3.5) => -0.0214263519,
   (f_srchfraudsrchcount_i = NULL) => -0.0115044402, -0.0115044402),
(inq_adl_lastseen_n = NULL) => 0.0001934316, 0.0001934316);

// Tree: 826 
final_score_826 := map(
(NULL < source_sx and source_sx <= 0.5) => -0.0009363727,
(source_sx > 0.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 86390) => -0.0084670108,
   (f_curraddrmedianvalue_d > 86390) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -7715.5) => 0.0229743697,
      (f_addrchangeincomediff_d > -7715.5) => 0.0034123889,
      (f_addrchangeincomediff_d = NULL) => 0.0116582916, 0.0098527433),
   (f_curraddrmedianvalue_d = NULL) => 0.0060298194, 0.0060298194),
(source_sx = NULL) => -0.0005416136, -0.0005416136);

// Tree: 827 
final_score_827 := map(
(NULL < f_wealth_index_d and f_wealth_index_d <= 4.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 8.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Child','Daughter','Granddaughter','Grandfather','Grandson','Mother','Neighbor','Sibling','Sister']) => -0.0065729662,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Vehicle','Brother','Father','Grandchild','Grandmother','Grandparent','Husband','Parent','Relative','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0050201542,
      (phone_subject_title = '') => 0.0003989400, 0.0003989400),
   (f_inq_count_i > 8.5) => -0.0037154784,
   (f_inq_count_i = NULL) => -0.0015606110, -0.0015606110),
(f_wealth_index_d > 4.5) => 0.0087203498,
(f_wealth_index_d = NULL) => -0.0005855989, -0.0005855989);

// Tree: 828 
final_score_828 := map(
(NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 64.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 45.5) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 56.5) => 0.0004372386,
      (f_srchaddrsrchcount_i > 56.5) => 0.0181906085,
      (f_srchaddrsrchcount_i = NULL) => 0.0006096014, 0.0006096014),
   (f_srchfraudsrchcount_i > 45.5) => 0.0226317624,
   (f_srchfraudsrchcount_i = NULL) => 0.0007477047, 0.0007477047),
(mth_pp_datelastseen > 64.5) => -0.0125310240,
(mth_pp_datelastseen = NULL) => 0.0003636927, 0.0003636927);

// Tree: 829 
final_score_829 := map(
(NULL < source_sx and source_sx <= 0.5) => -0.0008759617,
(source_sx > 0.5) => 
   map(
   (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 192.5) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 1.5) => 0.0162183820,
      (f_rel_ageover40_count_d > 1.5) => -0.0050150537,
      (f_rel_ageover40_count_d = NULL) => 0.0018748517, 0.0018748517),
   (eda_avg_days_interrupt > 192.5) => 0.0180516863,
   (eda_avg_days_interrupt = NULL) => 0.0067212174, 0.0067212174),
(source_sx = NULL) => -0.0004454460, -0.0004454460);

// Tree: 830 
final_score_830 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 394) => 
   map(
   (pp_app_scc in ['B','C','N','R']) => -0.0021311898,
   (pp_app_scc in ['8','A','J','S']) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 49033) => -0.0029441682,
      (f_prevaddrmedianincome_d > 49033) => 0.0179957230,
      (f_prevaddrmedianincome_d = NULL) => 0.0076812716, 0.0076812716),
   (pp_app_scc = '') => -0.0016746539, -0.0010880631),
(r_pb_order_freq_d > 394) => 0.0140936323,
(r_pb_order_freq_d = NULL) => -0.0013301269, -0.0006850778);

// Tree: 831 
final_score_831 := map(
(NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 1.5) => -0.0013581806,
(inq_adl_firstseen_n > 1.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 27.5) => 0.0093831213,
   (inq_adl_lastseen_n > 27.5) => 
      map(
      (NULL < subject_ssn_mismatch and subject_ssn_mismatch <= -0.5) => 0.0133542886,
      (subject_ssn_mismatch > -0.5) => -0.0086561116,
      (subject_ssn_mismatch = NULL) => -0.0026435145, -0.0026435145),
   (inq_adl_lastseen_n = NULL) => 0.0044472648, 0.0044472648),
(inq_adl_firstseen_n = NULL) => -0.0006791454, -0.0006791454);

// Tree: 832 
final_score_832 := map(
(NULL < eda_max_days_connected_ind and eda_max_days_connected_ind <= 745.5) => 
   map(
   (NULL < mth_source_exp_fseen and mth_source_exp_fseen <= 16.5) => 0.0001880561,
   (mth_source_exp_fseen > 16.5) => -0.0091648380,
   (mth_source_exp_fseen = NULL) => -0.0000294271, -0.0000294271),
(eda_max_days_connected_ind > 745.5) => 
   map(
   (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 1.5) => 0.0246907657,
   (f_rel_ageover40_count_d > 1.5) => 0.0022127117,
   (f_rel_ageover40_count_d = NULL) => 0.0107688742, 0.0107688742),
(eda_max_days_connected_ind = NULL) => 0.0001665378, 0.0001665378);

// Tree: 833 
final_score_833 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 484.5) => 
   map(
   (NULL < r_paw_dead_business_ct_i and r_paw_dead_business_ct_i <= 0.5) => 0.0002061324,
   (r_paw_dead_business_ct_i > 0.5) => 
      map(
      (phone_subject_title in ['Daughter','Grandfather','Husband','Parent','Subject at Household','Wife']) => -0.0257843094,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Mother','Neighbor','Relative','Sibling','Sister','Son','Spouse','Subject']) => -0.0038043298,
      (phone_subject_title = '') => -0.0060214408, -0.0060214408),
   (r_paw_dead_business_ct_i = NULL) => -0.0002156905, -0.0002156905),
(f_prevaddrageoldest_d > 484.5) => -0.0269520857,
(f_prevaddrageoldest_d = NULL) => -0.0003722451, -0.0003722451);

// Tree: 834 
final_score_834 := map(
(NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 11.5) => 
   map(
   (phone_subject_title in ['Associate By SSN','Brother','Child','Daughter','Granddaughter','Grandfather','Grandmother','Grandson','Neighbor','Relative','Son','Subject at Household','Wife']) => -0.0043208544,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Father','Grandchild','Grandparent','Husband','Mother','Parent','Sibling','Sister','Spouse','Subject']) => 
      map(
      (NULL < eda_days_ind_first_seen and eda_days_ind_first_seen <= 945) => 0.0042759868,
      (eda_days_ind_first_seen > 945) => -0.0090291288,
      (eda_days_ind_first_seen = NULL) => 0.0032884093, 0.0032884093),
   (phone_subject_title = '') => 0.0008428257, 0.0008428257),
(f_rel_educationover8_count_d > 11.5) => -0.0015693944,
(f_rel_educationover8_count_d = NULL) => -0.0003425920, -0.0003425920);

// Tree: 835 
final_score_835 := map(
(NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 12.5) => 
   map(
   (NULL < inq_firstseen_n and inq_firstseen_n <= 3.5) => 0.0013582110,
   (inq_firstseen_n > 3.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By SSN','Child','Daughter','Father','Granddaughter','Grandfather','Grandmother','Husband','Relative','Subject','Subject at Household']) => -0.0056954448,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Grandchild','Grandparent','Grandson','Mother','Neighbor','Parent','Sibling','Sister','Son','Spouse','Wife']) => 0.0053620673,
      (phone_subject_title = '') => -0.0018543738, -0.0018543738),
   (inq_firstseen_n = NULL) => -0.0002687511, -0.0002687511),
(f_rel_ageover30_count_d > 12.5) => 0.0023011122,
(f_rel_ageover30_count_d = NULL) => 0.0005881719, 0.0005881719);

// Tree: 836 
final_score_836 := map(
(NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 3.5) => -0.0012007787,
(f_crim_rel_under100miles_cnt_i > 3.5) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 124.5) => -0.0008540375,
   (f_fp_prevaddrcrimeindex_i > 124.5) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 160.5) => 0.0150741719,
      (f_prevaddrcartheftindex_i > 160.5) => 0.0017719860,
      (f_prevaddrcartheftindex_i = NULL) => 0.0076966246, 0.0076966246),
   (f_fp_prevaddrcrimeindex_i = NULL) => 0.0026014532, 0.0026014532),
(f_crim_rel_under100miles_cnt_i = NULL) => -0.0002897621, -0.0002897621);

// Tree: 837 
final_score_837 := map(
(NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 11.5) => 0.0014377256,
(f_rel_educationover12_count_d > 11.5) => 
   map(
   (pp_did_type in ['CORE']) => 
      map(
      (segment in ['0 - Disconnected','1 - Other','3 - ExpHit']) => -0.0073233653,
      (segment in ['2 - Cell Phone']) => 0.0021786085,
      (segment = '') => -0.0032194538, -0.0032194538),
   (pp_did_type in ['AMBIG','C_MERGE','INACTIVE','NO_SSN']) => 0.0177424621,
   (pp_did_type = '') => -0.0011422478, -0.0016836607),
(f_rel_educationover12_count_d = NULL) => 0.0002861391, 0.0002861391);

// Tree: 838 
final_score_838 := map(
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Vehicle','Child','Daughter','Father','Granddaughter','Grandfather','Grandmother','Grandson','Husband','Neighbor','Parent','Wife']) => -0.0053471906,
(phone_subject_title in ['Associate','Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Grandchild','Grandparent','Mother','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household']) => 
   map(
   (NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 7.5) => 0.0013886025,
   (mth_source_rel_fseen > 7.5) => 
      map(
      (NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 53.5) => -0.0034556490,
      (eda_max_days_interrupt > 53.5) => 0.0158076246,
      (eda_max_days_interrupt = NULL) => 0.0089195449, 0.0089195449),
   (mth_source_rel_fseen = NULL) => 0.0015915763, 0.0015915763),
(phone_subject_title = '') => -0.0003736359, -0.0003736359);

// Tree: 839 
final_score_839 := map(
(NULL < eda_num_interrupts_cur and eda_num_interrupts_cur <= 15.5) => 
   map(
   (NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 5.5) => 0.0005896547,
   (f_inq_per_ssn_i > 5.5) => -0.0076367973,
   (f_inq_per_ssn_i = NULL) => 0.0002256088, 0.0002256088),
(eda_num_interrupts_cur > 15.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 106) => 0.0277553798,
   (f_prevaddrmurderindex_i > 106) => 0.0010936171,
   (f_prevaddrmurderindex_i = NULL) => 0.0133876521, 0.0133876521),
(eda_num_interrupts_cur = NULL) => 0.0005029965, 0.0005029965);

// Tree: 840 
final_score_840 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 20.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 198.5) => 
      map(
      (NULL < mth_source_sp_fseen and mth_source_sp_fseen <= 113.5) => -0.0000811228,
      (mth_source_sp_fseen > 113.5) => -0.0188909302,
      (mth_source_sp_fseen = NULL) => -0.0002446668, -0.0002446668),
   (f_fp_prevaddrburglaryindex_i > 198.5) => -0.0197918148,
   (f_fp_prevaddrburglaryindex_i = NULL) => -0.0003948340, -0.0003948340),
(f_rel_ageover40_count_d > 20.5) => -0.0237743059,
(f_rel_ageover40_count_d = NULL) => -0.0005403722, -0.0005403722);

// Tree: 841 
final_score_841 := map(
(NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 62.5) => 
   map(
   (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0023569374,
   (_phone_match_code_n > 0.5) => 
      map(
      (phone_subject_title in ['Associate','Daughter','Mother','Parent','Sister','Subject','Subject at Household']) => 0.0011212852,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Relative','Sibling','Son','Spouse','Wife']) => 0.0300919774,
      (phone_subject_title = '') => 0.0018380696, 0.0018380696),
   (_phone_match_code_n = NULL) => -0.0005395951, -0.0005395951),
(mth_source_ppla_lseen > 62.5) => -0.0205525084,
(mth_source_ppla_lseen = NULL) => -0.0006590962, -0.0006590962);

// Tree: 842 
final_score_842 := map(
(phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Child','Daughter','Granddaughter','Grandson','Husband','Neighbor','Relative','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => -0.0012549406,
(phone_subject_title in ['Associate','Associate By Address','Associate By SSN','Associate By Vehicle','Brother','Father','Grandchild','Grandfather','Grandmother','Grandparent','Mother','Parent','Sibling']) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 1.5) => -0.0141014383,
   (f_rel_educationover12_count_d > 1.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 100.5) => 0.0039986302,
      (f_addrchangecrimediff_i > 100.5) => -0.0124121178,
      (f_addrchangecrimediff_i = NULL) => 0.0087310009, 0.0046346313),
   (f_rel_educationover12_count_d = NULL) => 0.0037737348, 0.0037737348),
(phone_subject_title = '') => -0.0000591509, -0.0000591509);

// Tree: 843 
final_score_843 := map(
(NULL < mth_source_inf_lseen and mth_source_inf_lseen <= 3.5) => 0.0002181745,
(mth_source_inf_lseen > 3.5) => 
   map(
   (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 3.5) => 0.0048572577,
   (eda_avg_days_interrupt > 3.5) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 147715.5) => -0.0157874909,
      (f_curraddrmedianvalue_d > 147715.5) => -0.0012222629,
      (f_curraddrmedianvalue_d = NULL) => -0.0093602951, -0.0093602951),
   (eda_avg_days_interrupt = NULL) => -0.0062833620, -0.0062833620),
(mth_source_inf_lseen = NULL) => -0.0000878339, -0.0000878339);

// Tree: 844 
final_score_844 := map(
(NULL < source_eda_any_clean and source_eda_any_clean <= 0.5) => -0.0008918126,
(source_eda_any_clean > 0.5) => 
   map(
   (NULL < pk_pp_hit and pk_pp_hit <= 0.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -64.5) => 0.0238056646,
      (f_addrchangecrimediff_i > -64.5) => 0.0031227060,
      (f_addrchangecrimediff_i = NULL) => 0.0124446191, 0.0079589964),
   (pk_pp_hit > 0.5) => -0.0079421376,
   (pk_pp_hit = NULL) => 0.0052152713, 0.0052152713),
(source_eda_any_clean = NULL) => -0.0005271465, -0.0005271465);

// Tree: 845 
final_score_845 := map(
(NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 1.5) => 
   map(
   (exp_source in ['P']) => -0.0014173505,
   (exp_source in ['S']) => 0.0019392566,
   (exp_source = '') => -0.0009177169, -0.0003742978),
(f_srchunvrfdaddrcount_i > 1.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 119.5) => -0.0051615404,
   (f_prevaddrcartheftindex_i > 119.5) => 0.0271929616,
   (f_prevaddrcartheftindex_i = NULL) => 0.0138825652, 0.0138825652),
(f_srchunvrfdaddrcount_i = NULL) => -0.0001104982, -0.0001104982);

// Tree: 846 
final_score_846 := map(
(NULL < _phone_fb_rp_result and _phone_fb_rp_result <= 1.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 177.5) => 0.0029800807,
   (f_curraddrcrimeindex_i > 177.5) => 
      map(
      (phone_subject_title in ['Associate','Child','Father','Husband','Mother','Neighbor','Son','Subject','Subject at Household']) => 0.0047329061,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Parent','Relative','Sibling','Sister','Spouse','Wife']) => 0.0443770517,
      (phone_subject_title = '') => 0.0245549789, 0.0245549789),
   (f_curraddrcrimeindex_i = NULL) => 0.0063458995, 0.0063458995),
(_phone_fb_rp_result > 1.5) => -0.0007059772,
(_phone_fb_rp_result = NULL) => -0.0001767355, -0.0001767355);

// Tree: 847 
final_score_847 := map(
(pp_src in ['CY','E1','E2','EN','FA','KW','LP','NW','SL','TN','UW','ZK','ZT']) => -0.0049110709,
(pp_src in ['EB','EM','EQ','FF','LA','MD','PL','UT','VO','VW']) => 
   map(
   (NULL < mth_source_exp_lseen and mth_source_exp_lseen <= 4.5) => 
      map(
      (phone_subject_title in ['Associate','Neighbor','Relative','Wife']) => -0.0198845733,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Parent','Sibling','Sister','Son','Spouse','Subject','Subject at Household']) => 0.0024208490,
      (phone_subject_title = '') => 0.0011582779, 0.0011582779),
   (mth_source_exp_lseen > 4.5) => -0.0131017688,
   (mth_source_exp_lseen = NULL) => 0.0001908878, 0.0001908878),
(pp_src = '') => 0.0004193357, 0.0000603731);

// Tree: 848 
final_score_848 := map(
(NULL < pp_src_cnt and pp_src_cnt <= 1.5) => -0.0004463197,
(pp_src_cnt > 1.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 10.5) => 0.0031800159,
   (f_corraddrnamecount_d > 10.5) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 6.5) => 0.0266995361,
      (f_rel_under25miles_cnt_d > 6.5) => 0.0027812584,
      (f_rel_under25miles_cnt_d = NULL) => 0.0148331037, 0.0148331037),
   (f_corraddrnamecount_d = NULL) => 0.0053002533, 0.0053002533),
(pp_src_cnt = NULL) => 0.0000307112, 0.0000307112);

// Tree: 849 
final_score_849 := map(
(NULL < number_of_sources and number_of_sources <= 4.5) => 
   map(
   (NULL < mth_source_edahistory_lseen and mth_source_edahistory_lseen <= 3) => -0.0005063209,
   (mth_source_edahistory_lseen > 3) => -0.0133746223,
   (mth_source_edahistory_lseen = NULL) => -0.0007266738, -0.0007266738),
(number_of_sources > 4.5) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 39) => -0.0061943304,
   (f_mos_inq_banko_om_lseen_d > 39) => 0.0127586774,
   (f_mos_inq_banko_om_lseen_d = NULL) => 0.0070727751, 0.0070727751),
(number_of_sources = NULL) => -0.0005531701, -0.0005531701);

// Tree: 850 
final_score_850 := map(
(NULL < f_adl_util_misc_n and f_adl_util_misc_n <= 0.5) => 
   map(
   (NULL < f_college_income_d and f_college_income_d <= 3.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 147) => 0.0208637278,
      (f_curraddrburglaryindex_i > 147) => -0.0075581386,
      (f_curraddrburglaryindex_i = NULL) => 0.0066527946, 0.0066527946),
   (f_college_income_d > 3.5) => -0.0049921552,
   (f_college_income_d = NULL) => 0.0021711026, 0.0015574754),
(f_adl_util_misc_n > 0.5) => -0.0017959188,
(f_adl_util_misc_n = NULL) => 0.0002386543, 0.0002386543);

// Tree: 851 
final_score_851 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 53.5) => 
   map(
   (NULL < mth_source_ppth_fseen and mth_source_ppth_fseen <= 23.5) => 
      map(
      (NULL < eda_avg_days_connected_ind and eda_avg_days_connected_ind <= 886.5) => 0.0000915306,
      (eda_avg_days_connected_ind > 886.5) => 0.0159547397,
      (eda_avg_days_connected_ind = NULL) => 0.0002117213, 0.0002117213),
   (mth_source_ppth_fseen > 23.5) => -0.0133987300,
   (mth_source_ppth_fseen = NULL) => -0.0002457179, -0.0002457179),
(mth_exp_last_update > 53.5) => -0.0098448491,
(mth_exp_last_update = NULL) => -0.0004817345, -0.0004817345);

// Tree: 852 
final_score_852 := map(
(pp_rp_source in ['GONG','IBEHAVIOR','INFUTOR','OTHER','THRIVE']) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 89.5) => -0.0093521387,
   (f_curraddrcrimeindex_i > 89.5) => 0.0074324928,
   (f_curraddrcrimeindex_i = NULL) => -0.0000745576, -0.0000745576),
(pp_rp_source in ['CELL','HEADER','INQUIRY','INTRADO','PCNSR','TARGUS']) => 
   map(
   (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 59) => 0.0010789007,
   (mth_pp_eda_hist_did_dt > 59) => 0.0233028595,
   (mth_pp_eda_hist_did_dt = NULL) => 0.0082479196, 0.0082479196),
(pp_rp_source = '') => 0.0001327968, 0.0002743143);

// Tree: 853 
final_score_853 := map(
(NULL < _phone_fb_result and _phone_fb_result <= 0.5) => 0.0140179595,
(_phone_fb_result > 0.5) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 18.5) => 0.0004305689,
   (mth_exp_last_update > 18.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 0.0008259853,
      (f_util_adl_count_n > 3.5) => -0.0135063375,
      (f_util_adl_count_n = NULL) => -0.0040971561, -0.0040971561),
   (mth_exp_last_update = NULL) => 0.0000982833, 0.0000982833),
(_phone_fb_result = NULL) => 0.0001830301, 0.0001830301);

// Tree: 854 
final_score_854 := map(
(NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 35) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 317.5) => -0.0025150278,
   (f_prevaddrageoldest_d > 317.5) => -0.0155629876,
   (f_prevaddrageoldest_d = NULL) => -0.0038424622, -0.0038424622),
(f_curraddrmurderindex_i > 35) => 
   map(
   (NULL < f_inq_lnames_per_addr_i and f_inq_lnames_per_addr_i <= 10.5) => 0.0000122661,
   (f_inq_lnames_per_addr_i > 10.5) => 0.0160284679,
   (f_inq_lnames_per_addr_i = NULL) => 0.0002016766, 0.0002016766),
(f_curraddrmurderindex_i = NULL) => -0.0003987880, -0.0003987880);

// Tree: 855 
final_score_855 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 178.5) => -0.0009104122,
(f_prevaddrlenofres_d > 178.5) => 
   map(
   (NULL < number_of_sources and number_of_sources <= 1.5) => 0.0002226141,
   (number_of_sources > 1.5) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 20.5) => -0.0044016417,
      (f_mos_inq_banko_om_lseen_d > 20.5) => 0.0099518515,
      (f_mos_inq_banko_om_lseen_d = NULL) => 0.0070508438, 0.0070508438),
   (number_of_sources = NULL) => 0.0022090627, 0.0022090627),
(f_prevaddrlenofres_d = NULL) => -0.0000779434, -0.0000779434);

// Tree: 856 
final_score_856 := map(
(NULL < source_rel and source_rel <= 0.5) => -0.0008696594,
(source_rel > 0.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 20.5) => 0.0169190844,
   (f_prevaddrageoldest_d > 20.5) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 14.5) => 0.0048706718,
      (f_rel_under500miles_cnt_d > 14.5) => -0.0080461299,
      (f_rel_under500miles_cnt_d = NULL) => 0.0014232822, 0.0014232822),
   (f_prevaddrageoldest_d = NULL) => 0.0036496905, 0.0036496905),
(source_rel = NULL) => -0.0006855201, -0.0006855201);

// Tree: 857 
final_score_857 := map(
(exp_type in ['N']) => 0.0045079452,
(exp_type in ['C']) => 
   map(
   (NULL < mth_source_exp_fseen and mth_source_exp_fseen <= 20.5) => 0.0088419685,
   (mth_source_exp_fseen > 20.5) => -0.0156484293,
   (mth_source_exp_fseen = NULL) => 0.0067837932, 0.0067837932),
(exp_type = '') => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Father','Granddaughter','Grandmother','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => -0.0055675531,
   (phone_subject_title in ['Associate','Associate By Property','Associate By SSN','Daughter','Grandchild','Grandfather','Grandparent','Mother','Subject at Household']) => 0.0058842166,
   (phone_subject_title = '') => -0.0035711274, -0.0035711274), -0.0012126165);

// Tree: 858 
final_score_858 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 54242) => -0.0009697505,
(f_curraddrmedianincome_d > 54242) => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 1679.5) => 
      map(
      (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 18.5) => 0.0054694688,
      (mth_source_ppdid_lseen > 18.5) => -0.0024468056,
      (mth_source_ppdid_lseen = NULL) => 0.0037884527, 0.0037884527),
   (eda_days_ph_first_seen > 1679.5) => -0.0009506288,
   (eda_days_ph_first_seen = NULL) => 0.0014662299, 0.0014662299),
(f_curraddrmedianincome_d = NULL) => 0.0001444111, 0.0001444111);

// Tree: 859 
final_score_859 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.32889039921531) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Child','Father','Granddaughter','Grandmother','Husband','Neighbor','Parent','Sister','Spouse','Subject','Wife']) => -0.0029809666,
   (phone_subject_title in ['Associate By Vehicle','Daughter','Grandchild','Grandfather','Grandparent','Grandson','Mother','Relative','Sibling','Son','Subject at Household']) => 
      map(
      (NULL < _pp_rule_f1_ver_above and _pp_rule_f1_ver_above <= 0.5) => 0.0061799260,
      (_pp_rule_f1_ver_above > 0.5) => -0.0108425675,
      (_pp_rule_f1_ver_above = NULL) => 0.0042686285, 0.0042686285),
   (phone_subject_title = '') => -0.0019332310, -0.0019332310),
(f_add_curr_mobility_index_n > 0.32889039921531) => 0.0010204237,
(f_add_curr_mobility_index_n = NULL) => -0.0016395525, -0.0003662280);

// Tree: 860 
final_score_860 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -402804.5) => 0.0126344089,
(f_addrchangevaluediff_d > -402804.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 10.5) => 
      map(
      (NULL < exp_verified and exp_verified <= 0.5) => -0.0042608873,
      (exp_verified > 0.5) => -0.0128259387,
      (exp_verified = NULL) => -0.0063470576, -0.0063470576),
   (f_prevaddrageoldest_d > 10.5) => 0.0003274972,
   (f_prevaddrageoldest_d = NULL) => -0.0002860735, -0.0002860735),
(f_addrchangevaluediff_d = NULL) => 0.0005272461, 0.0000268070);

// Tree: 861 
final_score_861 := map(
(NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 34.5) => 
   map(
   (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 39.5) => -0.0004880317,
   (mth_pp_datefirstseen > 39.5) => 
      map(
      (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 4.5) => 0.0019074402,
      (f_rel_bankrupt_count_i > 4.5) => 0.0133458644,
      (f_rel_bankrupt_count_i = NULL) => 0.0035751174, 0.0035751174),
   (mth_pp_datefirstseen = NULL) => 0.0000507018, 0.0000507018),
(mth_source_ppla_lseen > 34.5) => -0.0097717335,
(mth_source_ppla_lseen = NULL) => -0.0000746519, -0.0000746519);

// Tree: 862 
final_score_862 := map(
(NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 46.5) => 
   map(
   (NULL < _inq_adl_ph_industry_auto and _inq_adl_ph_industry_auto <= 0.5) => 
      map(
      (NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 27.5) => 0.0003081113,
      (mth_pp_orig_lastseen > 27.5) => 0.0066914423,
      (mth_pp_orig_lastseen = NULL) => 0.0006480939, 0.0006480939),
   (_inq_adl_ph_industry_auto > 0.5) => 0.0153336841,
   (_inq_adl_ph_industry_auto = NULL) => 0.0007541465, 0.0007541465),
(mth_pp_datelastseen > 46.5) => -0.0077888871,
(mth_pp_datelastseen = NULL) => 0.0003830582, 0.0003830582);

// Tree: 863 
final_score_863 := map(
(NULL < pp_app_company_type and pp_app_company_type <= 7.5) => -0.0004742887,
(pp_app_company_type > 7.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 27.5) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 41.5) => 0.0139687672,
      (mth_pp_app_npa_last_change_dt > 41.5) => 0.0034111817,
      (mth_pp_app_npa_last_change_dt = NULL) => 0.0068007223, 0.0068007223),
   (mth_source_ppdid_lseen > 27.5) => -0.0096031952,
   (mth_source_ppdid_lseen = NULL) => 0.0041471474, 0.0041471474),
(pp_app_company_type = NULL) => -0.0001063486, -0.0001063486);

// Tree: 864 
final_score_864 := map(
(NULL < mth_source_edala_fseen and mth_source_edala_fseen <= 52.5) => 
   map(
   (NULL < mth_source_edadid_fseen and mth_source_edadid_fseen <= 54.5) => 
      map(
      (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 5.5) => 0.0001239339,
      (f_rel_bankrupt_count_i > 5.5) => -0.0044721462,
      (f_rel_bankrupt_count_i = NULL) => -0.0003537012, -0.0003537012),
   (mth_source_edadid_fseen > 54.5) => 0.0134357322,
   (mth_source_edadid_fseen = NULL) => -0.0002724913, -0.0002724913),
(mth_source_edala_fseen > 52.5) => -0.0124238856,
(mth_source_edala_fseen = NULL) => -0.0003450497, -0.0003450497);

// Tree: 865 
final_score_865 := map(
(NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 157.5) => 
   map(
   (pp_src in ['CY','E1','E2','EM','LP','PL','VW','ZK','ZT']) => -0.0122010631,
   (pp_src in ['EB','EN','EQ','FA','FF','KW','LA','MD','NW','SL','TN','UT','UW','VO']) => 0.0006010370,
   (pp_src = '') => -0.0006548043, -0.0004770377),
(mth_source_cr_fseen > 157.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 74.5) => -0.0015947259,
   (f_mos_inq_banko_cm_fseen_d > 74.5) => 0.0219842431,
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0109123794, 0.0109123794),
(mth_source_cr_fseen = NULL) => -0.0003236853, -0.0003236853);

// Tree: 866 
final_score_866 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => -0.0003291025,
(phone_subject_title in ['Associate By Business','Associate By SSN','Brother','Father','Grandchild','Grandfather','Mother','Spouse']) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.207039935372865) => 0.0166774198,
   (f_add_input_mobility_index_n > 0.207039935372865) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 336229.5) => 0.0003354055,
      (f_prevaddrmedianvalue_d > 336229.5) => 0.0220369662,
      (f_prevaddrmedianvalue_d = NULL) => 0.0032194909, 0.0032194909),
   (f_add_input_mobility_index_n = NULL) => 0.0047292779, 0.0047292779),
(phone_subject_title = '') => -0.0000205419, -0.0000205419);

// Tree: 867 
final_score_867 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 0.5) => 0.0032336878,
(f_rel_criminal_count_i > 0.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 10889) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 75.5) => 0.0013529273,
      (inq_firstseen_n > 75.5) => -0.0146319792,
      (inq_firstseen_n = NULL) => 0.0008547085, 0.0008547085),
   (f_addrchangeincomediff_d > 10889) => -0.0025839460,
   (f_addrchangeincomediff_d = NULL) => -0.0001711818, -0.0002260968),
(f_rel_criminal_count_i = NULL) => 0.0005050719, 0.0005050719);

// Tree: 868 
final_score_868 := map(
(NULL < _phone_match_code_lns and _phone_match_code_lns <= 0.5) => -0.0087947612,
(_phone_match_code_lns > 0.5) => 
   map(
   (exp_source in ['S']) => 0.0136365203,
   (exp_source in ['P']) => 0.0189506376,
   (exp_source = '') => 
      map(
      (NULL < _phone_match_code_l and _phone_match_code_l <= 0.5) => 0.0192190628,
      (_phone_match_code_l > 0.5) => -0.0005621431,
      (_phone_match_code_l = NULL) => 0.0020582446, 0.0020582446), 0.0071429852),
(_phone_match_code_lns = NULL) => -0.0009014621, -0.0009014621);

// Tree: 869 
final_score_869 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -40.5) => -0.0028349920,
(f_addrchangecrimediff_i > -40.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 196137.5) => 0.0020946993,
   (f_prevaddrmedianvalue_d > 196137.5) => -0.0016675805,
   (f_prevaddrmedianvalue_d = NULL) => 0.0006987648, 0.0006987648),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Father','Grandfather','Husband','Neighbor','Relative','Son','Spouse','Subject','Subject at Household','Wife']) => -0.0002648616,
   (phone_subject_title in ['Associate By Property','Associate By Vehicle','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Mother','Parent','Sibling','Sister']) => 0.0157500872,
   (phone_subject_title = '') => 0.0004479249, 0.0004479249), -0.0000149035);

// Tree: 870 
final_score_870 := map(
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Relative','Sibling','Sister','Son','Spouse','Wife']) => -0.0115035265,
(phone_subject_title in ['Associate','Associate By Property','Grandchild','Parent','Subject','Subject at Household']) => 
   map(
   (exp_source in ['S']) => 0.0171311135,
   (exp_source in ['P']) => 0.0282100803,
   (exp_source = '') => 
      map(
      (NULL < source_rel and source_rel <= 0.5) => -0.0013565280,
      (source_rel > 0.5) => 0.0297885507,
      (source_rel = NULL) => 0.0021434168, 0.0021434168), 0.0090517031),
(phone_subject_title = '') => -0.0001441209, -0.0001441209);

// Tree: 871 
final_score_871 := map(
(pp_src in ['CY','E1','E2','EQ','FA','NW','TN','UT','ZK','ZT']) => -0.0018760798,
(pp_src in ['EB','EM','EN','FF','KW','LA','LP','MD','PL','SL','UW','VO','VW']) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 98.5) => -0.0028028038,
   (f_fp_prevaddrburglaryindex_i > 98.5) => 0.0074456542,
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.0034032069, 0.0034032069),
(pp_src = '') => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 1.5) => 0.0002650225,
   (inq_adl_firstseen_n > 1.5) => 0.0041415194,
   (inq_adl_firstseen_n = NULL) => 0.0006220832, 0.0006220832), 0.0004519017);

// Tree: 872 
final_score_872 := map(
(NULL < inq_num and inq_num <= 0.5) => -0.0001241749,
(inq_num > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 43.5) => 
      map(
      (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 29.5) => 0.0187861756,
      (inq_adl_lastseen_n > 29.5) => -0.0009805050,
      (inq_adl_lastseen_n = NULL) => 0.0119227448, 0.0119227448),
   (f_mos_inq_banko_cm_fseen_d > 43.5) => 0.0017403259,
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0031949572, 0.0031949572),
(inq_num = NULL) => 0.0002675456, 0.0002675456);

// Tree: 873 
final_score_873 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.2004892900509) => -0.0047416171,
(f_add_input_mobility_index_n > 0.2004892900509) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 69) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Brother','Father','Granddaughter','Grandfather','Grandmother','Husband','Neighbor','Parent','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => 0.0018445208,
      (phone_subject_title in ['Associate','Associate By Property','Associate By SSN','Child','Daughter','Grandchild','Grandparent','Grandson','Mother','Relative','Spouse']) => 0.0088087805,
      (phone_subject_title = '') => 0.0027415221, 0.0027415221),
   (f_curraddrmurderindex_i > 69) => -0.0006277350,
   (f_curraddrmurderindex_i = NULL) => 0.0004021347, 0.0004021347),
(f_add_input_mobility_index_n = NULL) => -0.0022939893, -0.0000547810);

// Tree: 874 
final_score_874 := map(
(pp_glb_dppa_fl in ['B','G']) => -0.0015294858,
(pp_glb_dppa_fl in ['D','U']) => -0.0002790905,
(pp_glb_dppa_fl = '') => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 1.5) => 0.0004952896,
   (inq_adl_lastseen_n > 1.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -8992) => -0.0036150885,
      (f_addrchangeincomediff_d > -8992) => 0.0111318247,
      (f_addrchangeincomediff_d = NULL) => 0.0147732603, 0.0086481039),
   (inq_adl_lastseen_n = NULL) => 0.0008607353, 0.0008607353), 0.0000523257);

// Tree: 875 
final_score_875 := map(
(NULL < f_prevaddrdwelltype_sfd_n and f_prevaddrdwelltype_sfd_n <= 0.5) => 
   map(
   (NULL < f_inq_per_addr_i and f_inq_per_addr_i <= 2.5) => 0.0028493040,
   (f_inq_per_addr_i > 2.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 16.5) => -0.0047597711,
      (f_inq_count_i > 16.5) => 0.0054257999,
      (f_inq_count_i = NULL) => -0.0019112639, -0.0019112639),
   (f_inq_per_addr_i = NULL) => 0.0016656107, 0.0016656107),
(f_prevaddrdwelltype_sfd_n > 0.5) => -0.0011090765,
(f_prevaddrdwelltype_sfd_n = NULL) => -0.0000297427, -0.0000297427);

// Tree: 876 
final_score_876 := map(
(NULL < _phone_match_code_lns and _phone_match_code_lns <= 0.5) => -0.0081668899,
(_phone_match_code_lns > 0.5) => 
   map(
   (exp_source in ['S']) => 0.0126947499,
   (exp_source in ['P']) => 0.0167648788,
   (exp_source = '') => 
      map(
      (NULL < _phone_match_code_l and _phone_match_code_l <= 0.5) => 0.0202791170,
      (_phone_match_code_l > 0.5) => -0.0010142149,
      (_phone_match_code_l = NULL) => 0.0017602430, 0.0017602430), 0.0064351770),
(_phone_match_code_lns = NULL) => -0.0010462239, -0.0010462239);

// Tree: 877 
final_score_877 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -3.5) => 
   map(
   (phone_subject_title in ['Associate By Vehicle','Grandparent','Grandson','Husband','Mother','Parent','Subject at Household']) => -0.0068869882,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Neighbor','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => -0.0014217064,
   (phone_subject_title = '') => -0.0019915905, -0.0019915905),
(f_addrchangecrimediff_i > -3.5) => 0.0009615873,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 10.5) => -0.0011508400,
   (pp_app_ind_ph_cnt > 10.5) => 0.0139743963,
   (pp_app_ind_ph_cnt = NULL) => -0.0006229700, -0.0006229700), -0.0004484652);

// Tree: 878 
final_score_878 := map(
(NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 27.5) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 10.5) => -0.0000286679,
   (f_rel_incomeover75_count_d > 10.5) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 31) => -0.0051473743,
      (f_prevaddrcartheftindex_i > 31) => 0.0116996147,
      (f_prevaddrcartheftindex_i = NULL) => 0.0065407282, 0.0065407282),
   (f_rel_incomeover75_count_d = NULL) => 0.0001447788, 0.0001447788),
(f_rel_homeover50_count_d > 27.5) => -0.0034806756,
(f_rel_homeover50_count_d = NULL) => -0.0001090712, -0.0001090712);

// Tree: 879 
final_score_879 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 57.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 4.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 340) => 0.0003509260,
      (f_prevaddrageoldest_d > 340) => 0.0082034546,
      (f_prevaddrageoldest_d = NULL) => 0.0006479136, 0.0006479136),
   (f_corrssnaddrcount_d > 4.5) => -0.0015195350,
   (f_corrssnaddrcount_d = NULL) => -0.0001506875, -0.0001506875),
(f_srchaddrsrchcount_i > 57.5) => 0.0100886782,
(f_srchaddrsrchcount_i = NULL) => -0.0000511714, -0.0000511714);

// Tree: 880 
final_score_880 := map(
(NULL < mth_source_pf_fseen and mth_source_pf_fseen <= 7) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 0.5) => -0.0001411966,
   (inq_adl_firstseen_n > 0.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 173.5) => 0.0037165633,
      (f_prevaddrmurderindex_i > 173.5) => -0.0055675663,
      (f_prevaddrmurderindex_i = NULL) => 0.0023076150, 0.0023076150),
   (inq_adl_firstseen_n = NULL) => 0.0001466436, 0.0001466436),
(mth_source_pf_fseen > 7) => -0.0098141261,
(mth_source_pf_fseen = NULL) => 0.0000580101, 0.0000580101);

// Tree: 881 
final_score_881 := map(
(NULL < number_of_sources and number_of_sources <= 1.5) => 
   map(
   (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Child','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Neighbor','Sibling','Sister','Son','Spouse']) => -0.0104198331,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By SSN','Associate By Vehicle','Brother','Daughter','Father','Grandchild','Grandfather','Mother','Parent','Relative','Subject','Subject at Household','Wife']) => -0.0006688003,
   (phone_subject_title = '') => -0.0036024523, -0.0036024523),
(number_of_sources > 1.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 0.0094860560,
   (f_srchvelocityrisktype_i > 5.5) => -0.0000091504,
   (f_srchvelocityrisktype_i = NULL) => 0.0055840331, 0.0055840331),
(number_of_sources = NULL) => -0.0012049958, -0.0012049958);

// Tree: 882 
final_score_882 := map(
(pp_origphonetype in ['L']) => -0.0023694218,
(pp_origphonetype in ['O','V','W']) => -0.0011352077,
(pp_origphonetype = '') => 
   map(
   (NULL < _pp_src_all_iq and _pp_src_all_iq <= 0.5) => 0.0004051858,
   (_pp_src_all_iq > 0.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 188) => 0.0028392462,
      (f_prevaddrlenofres_d > 188) => 0.0107515149,
      (f_prevaddrlenofres_d = NULL) => 0.0043446779, 0.0043446779),
   (_pp_src_all_iq = NULL) => 0.0008462320, 0.0008462320), 0.0002304278);

// Tree: 883 
final_score_883 := map(
(pp_rp_source in ['GONG','HEADER','INFUTOR','INQUIRY','OTHER','THRIVE']) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 1.5) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 4.5) => -0.0023562108,
      (f_rel_incomeover50_count_d > 4.5) => 0.0119051564,
      (f_rel_incomeover50_count_d = NULL) => 0.0041963093, 0.0041963093),
   (f_rel_criminal_count_i > 1.5) => -0.0054238463,
   (f_rel_criminal_count_i = NULL) => -0.0022267287, -0.0022267287),
(pp_rp_source in ['CELL','IBEHAVIOR','INTRADO','PCNSR','TARGUS']) => 0.0119779662,
(pp_rp_source = '') => -0.0002595240, -0.0002633800);

// Tree: 884 
final_score_884 := map(
(NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0017249642,
(_phone_match_code_n > 0.5) => 
   map(
   (NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0001254476,
   (_pp_rule_high_vend_conf > 0.5) => 
      map(
      (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 2.5) => -0.0005063723,
      (pp_app_ind_ph_cnt > 2.5) => 0.0061156585,
      (pp_app_ind_ph_cnt = NULL) => 0.0027842299, 0.0027842299),
   (_pp_rule_high_vend_conf = NULL) => 0.0005163115, 0.0005163115),
(_phone_match_code_n = NULL) => -0.0007600689, -0.0007600689);

// Tree: 885 
final_score_885 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 13.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Brother','Child','Granddaughter','Grandmother','Grandson','Mother','Neighbor','Parent','Sibling','Sister','Son','Wife']) => -0.0027443599,
   (phone_subject_title in ['Associate','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Daughter','Father','Grandchild','Grandfather','Grandparent','Husband','Relative','Spouse','Subject','Subject at Household']) => 0.0018994676,
   (phone_subject_title = '') => 0.0004168591, 0.0004168591),
(f_addrchangecrimediff_i > 13.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Granddaughter','Grandfather','Grandmother','Grandson','Neighbor','Parent','Sibling','Sister','Spouse','Subject','Wife']) => -0.0027449786,
   (phone_subject_title in ['Associate By Business','Daughter','Grandchild','Grandparent','Husband','Mother','Relative','Son','Subject at Household']) => 0.0045838944,
   (phone_subject_title = '') => -0.0017885866, -0.0017885866),
(f_addrchangecrimediff_i = NULL) => 0.0013801458, 0.0001171593);

// Tree: 886 
final_score_886 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 8.5) => -0.0004910883,
(f_rel_ageover40_count_d > 8.5) => 
   map(
   (NULL < f_estimated_income_d and f_estimated_income_d <= 35500) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Brother','Daughter','Grandfather','Neighbor','Parent','Sister','Son']) => -0.0008862105,
      (phone_subject_title in ['Associate','Associate By Business','Associate By SSN','Associate By Vehicle','Child','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Mother','Relative','Sibling','Spouse','Subject','Subject at Household','Wife']) => 0.0153551457,
      (phone_subject_title = '') => 0.0086265838, 0.0086265838),
   (f_estimated_income_d > 35500) => 0.0006787089,
   (f_estimated_income_d = NULL) => 0.0022774194, 0.0022774194),
(f_rel_ageover40_count_d = NULL) => -0.0001516495, -0.0001516495);

// Tree: 887 
final_score_887 := map(
(phone_subject_title in ['Associate By SSN','Associate By Vehicle','Child','Father','Granddaughter','Grandfather','Grandmother','Grandson','Neighbor','Sister','Spouse','Wife']) => -0.0074660870,
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Brother','Daughter','Grandchild','Grandparent','Husband','Mother','Parent','Relative','Sibling','Son','Subject','Subject at Household']) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 33.5) => -0.0027021688,
   (f_mos_inq_banko_om_fseen_d > 33.5) => 
      map(
      (NULL < mth_source_ppth_fseen and mth_source_ppth_fseen <= 21.5) => 0.0021427853,
      (mth_source_ppth_fseen > 21.5) => -0.0092647751,
      (mth_source_ppth_fseen = NULL) => 0.0016517117, 0.0016517117),
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0008729033, 0.0008729033),
(phone_subject_title = '') => -0.0006160278, -0.0006160278);

// Tree: 888 
final_score_888 := map(
(NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 35) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By Property','Brother','Father','Grandfather','Grandmother','Mother','Neighbor','Parent','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => -0.0046655365,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Relative','Spouse']) => 0.0025542936,
   (phone_subject_title = '') => -0.0027970047, -0.0027970047),
(f_curraddrmurderindex_i > 35) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 30.5) => 0.0008370895,
   (mth_exp_last_update > 30.5) => -0.0038969468,
   (mth_exp_last_update = NULL) => 0.0006165822, 0.0006165822),
(f_curraddrmurderindex_i = NULL) => 0.0000946123, 0.0000946123);

// Tree: 889 
final_score_889 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 31406) => 0.0029004067,
(f_curraddrmedianincome_d > 31406) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 24.5) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 22.5) => -0.0003443382,
      (f_rel_under100miles_cnt_d > 22.5) => 0.0118383695,
      (f_rel_under100miles_cnt_d = NULL) => -0.0000835749, -0.0000835749),
   (f_rel_incomeover25_count_d > 24.5) => -0.0055412853,
   (f_rel_incomeover25_count_d = NULL) => -0.0005745853, -0.0005745853),
(f_curraddrmedianincome_d = NULL) => -0.0000098635, -0.0000098635);

// Tree: 890 
final_score_890 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 45.5) => 0.0086385347,
(f_mos_inq_banko_am_lseen_d > 45.5) => 
   map(
   (pp_src in ['E1','E2','EN','KW','LP','NW','SL','ZT']) => -0.0074899945,
   (pp_src in ['CY','EB','EM','EQ','FA','FF','LA','MD','PL','TN','UT','UW','VO','VW','ZK']) => -0.0003710589,
   (pp_src = '') => 
      map(
      (NULL < mth_source_ppfla_lseen and mth_source_ppfla_lseen <= 47.5) => 0.0001458628,
      (mth_source_ppfla_lseen > 47.5) => -0.0105117857,
      (mth_source_ppfla_lseen = NULL) => 0.0000328509, 0.0000328509), -0.0001396898),
(f_mos_inq_banko_am_lseen_d = NULL) => -0.0000656900, -0.0000656900);

// Tree: 891 
final_score_891 := map(
(NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 35) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.59170181289957) => -0.0031483966,
   (f_add_curr_mobility_index_n > 0.59170181289957) => 0.0050240579,
   (f_add_curr_mobility_index_n = NULL) => -0.0004286920, -0.0020905466),
(f_curraddrmurderindex_i > 35) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 49.5) => 0.0036126324,
   (f_curraddrcartheftindex_i > 49.5) => 0.0001196311,
   (f_curraddrcartheftindex_i = NULL) => 0.0005933567, 0.0005933567),
(f_curraddrmurderindex_i = NULL) => 0.0001806661, 0.0001806661);

// Tree: 892 
final_score_892 := map(
(NULL < pk_cell_indicator and pk_cell_indicator <= 1.5) => -0.0010108386,
(pk_cell_indicator > 1.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 32.5) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 7.5) => 0.0057807844,
      (f_rel_ageover30_count_d > 7.5) => 0.0009695679,
      (f_rel_ageover30_count_d = NULL) => 0.0028251641, 0.0028251641),
   (mth_source_ppdid_lseen > 32.5) => -0.0056698875,
   (mth_source_ppdid_lseen = NULL) => 0.0019940496, 0.0019940496),
(pk_cell_indicator = NULL) => -0.0001657688, -0.0001657688);

// Tree: 893 
final_score_893 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 72.5) => -0.0011800018,
(f_mos_inq_banko_cm_fseen_d > 72.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Father','Granddaughter','Grandmother','Grandson','Husband','Neighbor','Sibling']) => -0.0019662893,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Brother','Daughter','Grandchild','Grandfather','Grandparent','Mother','Parent','Relative','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < subject_ssn_mismatch and subject_ssn_mismatch <= -0.5) => 0.0043624654,
      (subject_ssn_mismatch > -0.5) => 0.0009727765,
      (subject_ssn_mismatch = NULL) => 0.0018826235, 0.0018826235),
   (phone_subject_title = '') => 0.0005678721, 0.0005678721),
(f_mos_inq_banko_cm_fseen_d = NULL) => -0.0001968867, -0.0001968867);

// Tree: 894 
final_score_894 := map(
(NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 18.5) => 
   map(
   (NULL < number_of_sources and number_of_sources <= 1.5) => -0.0006101310,
   (number_of_sources > 1.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 7.5) => 0.0043816836,
      (f_inq_count_i > 7.5) => -0.0001196683,
      (f_inq_count_i = NULL) => 0.0019403089, 0.0019403089),
   (number_of_sources = NULL) => 0.0000356713, 0.0000356713),
(mth_source_ppth_lseen > 18.5) => -0.0079465948,
(mth_source_ppth_lseen = NULL) => -0.0002362921, -0.0002362921);

// Tree: 895 
final_score_895 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 316635) => -0.0003090469,
(f_curraddrmedianvalue_d > 316635) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Father','Grandson','Husband','Mother','Neighbor','Sibling','Sister','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 93298) => -0.0002931847,
      (f_curraddrmedianincome_d > 93298) => 0.0053857969,
      (f_curraddrmedianincome_d = NULL) => 0.0015998091, 0.0015998091),
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Parent','Relative','Son','Spouse']) => 0.0143722297,
   (phone_subject_title = '') => 0.0022458131, 0.0022458131),
(f_curraddrmedianvalue_d = NULL) => 0.0001049960, 0.0001049960);

// Tree: 896 
final_score_896 := map(
(NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 198.5) => 
   map(
   (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 666.5) => -0.0001220544,
   (eda_avg_days_interrupt > 666.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 30) => -0.0018448800,
      (f_addrchangecrimediff_i > 30) => 0.0082562304,
      (f_addrchangecrimediff_i = NULL) => 0.0168310449, 0.0047883996),
   (eda_avg_days_interrupt = NULL) => 0.0001116111, 0.0001116111),
(f_fp_prevaddrburglaryindex_i > 198.5) => -0.0090467894,
(f_fp_prevaddrburglaryindex_i = NULL) => 0.0000354698, 0.0000354698);

// Tree: 897 
final_score_897 := map(
(NULL < _phone_match_code_lns and _phone_match_code_lns <= 0.5) => -0.0048411854,
(_phone_match_code_lns > 0.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 18.5) => 
      map(
      (NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 18.5) => 0.0070385988,
      (mth_source_ppth_lseen > 18.5) => -0.0091947885,
      (mth_source_ppth_lseen = NULL) => 0.0055554228, 0.0055554228),
   (mth_source_ppdid_lseen > 18.5) => -0.0027978759,
   (mth_source_ppdid_lseen = NULL) => 0.0035007170, 0.0035007170),
(_phone_match_code_lns = NULL) => -0.0007156503, -0.0007156503);

// Tree: 898 
final_score_898 := map(
(exp_source in ['P']) => -0.0011740132,
(exp_source in ['S']) => 
   map(
   (NULL < _pp_rule_iq_rpc and _pp_rule_iq_rpc <= 0.5) => 
      map(
      (NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 2.5) => 0.0083913323,
      (f_componentcharrisktype_i > 2.5) => 0.0012067860,
      (f_componentcharrisktype_i = NULL) => 0.0017605644, 0.0017605644),
   (_pp_rule_iq_rpc > 0.5) => -0.0046737767,
   (_pp_rule_iq_rpc = NULL) => 0.0011324408, 0.0011324408),
(exp_source = '') => -0.0002140970, -0.0000105452);

// Tree: 899 
final_score_899 := map(
(phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Granddaughter','Grandfather','Grandmother','Grandson','Neighbor','Relative','Sibling','Sister']) => -0.0048744224,
(phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Vehicle','Father','Grandchild','Grandparent','Husband','Mother','Parent','Son','Spouse','Subject','Subject at Household','Wife']) => 
   map(
   (NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => 
      map(
      (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 20.5) => 0.0025352342,
      (mth_source_ppdid_lseen > 20.5) => -0.0039464934,
      (mth_source_ppdid_lseen = NULL) => 0.0014217692, 0.0014217692),
   (_inq_adl_ph_industry_flag > 0.5) => 0.0104622936,
   (_inq_adl_ph_industry_flag = NULL) => 0.0018889139, 0.0018889139),
(phone_subject_title = '') => -0.0006601060, -0.0006601060);

// Tree: 900 
final_score_900 := map(
(pp_source in ['CELL','GONG','HEADER','INFUTOR','INTRADO','OTHER','PCNSR','THRIVE']) => -0.0010438568,
(pp_source in ['IBEHAVIOR','INQUIRY','TARGUS']) => 
   map(
   (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => 0.0001977767,
   (f_curraddractivephonelist_d > 0.5) => 
      map(
      (NULL < pk_phone_match_level and pk_phone_match_level <= 3.5) => 0.0006073567,
      (pk_phone_match_level > 3.5) => 0.0085426058,
      (pk_phone_match_level = NULL) => 0.0047733625, 0.0047733625),
   (f_curraddractivephonelist_d = NULL) => 0.0007707993, 0.0007707993),
(pp_source = '') => -0.0004679501, -0.0003695898);

// Tree: 901 
final_score_901 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -148.5) => 0.0074128702,
(f_addrchangecrimediff_i > -148.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 11.5) => 0.0000396006,
   (f_rel_homeover500_count_d > 11.5) => -0.0086849379,
   (f_rel_homeover500_count_d = NULL) => -0.0000385588, -0.0000385588),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 878) => 0.0000211002,
   (eda_avg_days_interrupt > 878) => 0.0096010057,
   (eda_avg_days_interrupt = NULL) => 0.0003724952, 0.0003724952), 0.0001431804);

// Tree: 902 
final_score_902 := map(
(NULL < pk_phone_match_level and pk_phone_match_level <= 0.5) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 11.5) => -0.0042853476,
   (mth_exp_last_update > 11.5) => 0.0050925660,
   (mth_exp_last_update = NULL) => -0.0033707434, -0.0033707434),
(pk_phone_match_level > 0.5) => 
   map(
   (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 42.5) => 0.0001749089,
   (mth_pp_datelastseen > 42.5) => -0.0037316416,
   (mth_pp_datelastseen = NULL) => -0.0000200937, -0.0000200937),
(pk_phone_match_level = NULL) => -0.0003056894, -0.0003056894);

// Tree: 903 
final_score_903 := map(
(NULL < f_wealth_index_d and f_wealth_index_d <= 5.5) => 
   map(
   (NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 5.5) => 0.0001821168,
   (mth_internal_ver_first_seen > 5.5) => -0.0012667041,
   (mth_internal_ver_first_seen = NULL) => -0.0001907492, -0.0001907492),
(f_wealth_index_d > 5.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Brother','Daughter','Husband','Mother','Neighbor','Relative','Wife']) => -0.0033357334,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Parent','Sibling','Sister','Son','Spouse','Subject','Subject at Household']) => 0.0067286353,
   (phone_subject_title = '') => 0.0037588216, 0.0037588216),
(f_wealth_index_d = NULL) => -0.0001061254, -0.0001061254);

// Tree: 904 
final_score_904 := map(
(pp_rp_source in ['GONG','HEADER','INFUTOR','INTRADO','OTHER','THRIVE']) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 33888.5) => 0.0058411649,
   (f_prevaddrmedianincome_d > 33888.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => 0.0024003954,
      (f_assocrisktype_i > 3.5) => -0.0047216081,
      (f_assocrisktype_i = NULL) => -0.0020690251, -0.0020690251),
   (f_prevaddrmedianincome_d = NULL) => -0.0001915092, -0.0001915092),
(pp_rp_source in ['CELL','IBEHAVIOR','INQUIRY','PCNSR','TARGUS']) => 0.0047503900,
(pp_rp_source = '') => 0.0000969855, 0.0001558637);

// Tree: 905 
final_score_905 := map(
(NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 27.5) => -0.0003019862,
(mth_pp_datefirstseen > 27.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -29161.5) => 0.0079186155,
   (f_addrchangeincomediff_d > -29161.5) => 0.0012194232,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 2.5) => -0.0016940939,
      (f_rel_homeover300_count_d > 2.5) => 0.0069845996,
      (f_rel_homeover300_count_d = NULL) => 0.0006559009, 0.0006559009), 0.0015495948),
(mth_pp_datefirstseen = NULL) => 0.0000299153, 0.0000299153);

// Tree: 906 
final_score_906 := map(
(NULL < pk_cell_indicator and pk_cell_indicator <= 2.5) => 
   map(
   (NULL < f_wealth_index_d and f_wealth_index_d <= 4.5) => -0.0017070744,
   (f_wealth_index_d > 4.5) => 0.0039390711,
   (f_wealth_index_d = NULL) => -0.0012166322, -0.0012166322),
(pk_cell_indicator > 2.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 33.5) => -0.0013816212,
   (f_prevaddrageoldest_d > 33.5) => 0.0038294533,
   (f_prevaddrageoldest_d = NULL) => 0.0024293128, 0.0024293128),
(pk_cell_indicator = NULL) => -0.0005541212, -0.0005541212);

// Tree: 907 
final_score_907 := map(
(pp_src in ['CY','E1','FA','PL','TN','UW','VO','ZK','ZT']) => -0.0022764745,
(pp_src in ['E2','EB','EM','EN','EQ','FF','KW','LA','LP','MD','NW','SL','UT','VW']) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 13.5) => 0.0003544575,
   (f_inq_count24_i > 13.5) => 0.0084494313,
   (f_inq_count24_i = NULL) => 0.0007881168, 0.0007881168),
(pp_src = '') => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 0.0000823288,
   (f_srchfraudsrchcountmo_i > 0.5) => -0.0058038172,
   (f_srchfraudsrchcountmo_i = NULL) => -0.0000744637, -0.0000744637), -0.0000827996);

// Tree: 908 
final_score_908 := map(
(NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 59.5) => -0.0001299760,
(mth_pp_datevendorfirstseen > 59.5) => 
   map(
   (pp_src in ['CY','E1','EN','FA','PL','TN','UT','VO','ZK','ZT']) => -0.0015831340,
   (pp_src in ['E2','EB','EM','EQ','FF','KW','LA','LP','MD','NW','SL','UW','VW']) => 0.0110957448,
   (pp_src = '') => 
      map(
      (segment in ['1 - Other','2 - Cell Phone']) => 0.0002753120,
      (segment in ['0 - Disconnected','3 - ExpHit']) => 0.0081073236,
      (segment = '') => 0.0036600004, 0.0036600004), 0.0030733024),
(mth_pp_datevendorfirstseen = NULL) => 0.0000132921, 0.0000132921);

// Tree: 909 
final_score_909 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 11.5) => 
   map(
   (NULL < internal_verification and internal_verification <= 0.5) => -0.0002728481,
   (internal_verification > 0.5) => 
      map(
      (pp_source in ['CELL','GONG','INFUTOR','INQUIRY','OTHER','PCNSR','THRIVE']) => 0.0009390096,
      (pp_source in ['HEADER','IBEHAVIOR','INTRADO','TARGUS']) => 0.0045607907,
      (pp_source = '') => 0.0038212705, 0.0023851668),
   (internal_verification = NULL) => 0.0006067307, 0.0006067307),
(f_inq_count_i > 11.5) => -0.0014822295,
(f_inq_count_i = NULL) => -0.0001333692, -0.0001333692);

// Tree: 910 
final_score_910 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 16.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 0.5) => -0.0003623167,
   (mth_source_ppdid_lseen > 0.5) => 
      map(
      (NULL < f_estimated_income_d and f_estimated_income_d <= 101500) => 0.0023493515,
      (f_estimated_income_d > 101500) => 0.0125543931,
      (f_estimated_income_d = NULL) => 0.0029376925, 0.0029376925),
   (mth_source_ppdid_lseen = NULL) => 0.0000664193, 0.0000664193),
(mth_source_ppdid_lseen > 16.5) => -0.0023496692,
(mth_source_ppdid_lseen = NULL) => -0.0002724724, -0.0002724724);

// Tree: 911 
final_score_911 := map(
(NULL < _phone_match_code_lns and _phone_match_code_lns <= 0.5) => -0.0030012337,
(_phone_match_code_lns > 0.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 18.5) => 
      map(
      (NULL < mth_source_ppth_fseen and mth_source_ppth_fseen <= 23.5) => 0.0039554565,
      (mth_source_ppth_fseen > 23.5) => -0.0061028608,
      (mth_source_ppth_fseen = NULL) => 0.0030747597, 0.0030747597),
   (mth_source_ppdid_lseen > 18.5) => -0.0018397730,
   (mth_source_ppdid_lseen = NULL) => 0.0018403311, 0.0018403311),
(_phone_match_code_lns = NULL) => -0.0005977406, -0.0005977406);

// Tree: 912 
final_score_912 := map(
(NULL < mth_pp_app_fb_ph7_nm_addr_dt and mth_pp_app_fb_ph7_nm_addr_dt <= -499) => 
   map(
   (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 8.5) => 
      map(
      (NULL < pp_max_source_conf and pp_max_source_conf <= 10.5) => 0.0002505299,
      (pp_max_source_conf > 10.5) => -0.0053828202,
      (pp_max_source_conf = NULL) => 0.0002007962, 0.0002007962),
   (f_assoccredbureaucount_i > 8.5) => -0.0059847784,
   (f_assoccredbureaucount_i = NULL) => 0.0001278703, 0.0001278703),
(mth_pp_app_fb_ph7_nm_addr_dt > -499) => -0.0073360277,
(mth_pp_app_fb_ph7_nm_addr_dt = NULL) => 0.0000771846, 0.0000771846);

// Tree: 913 
final_score_913 := map(
(NULL < eda_address_match_best and eda_address_match_best <= 0.5) => -0.0001894191,
(eda_address_match_best > 0.5) => 
   map(
   (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 13.5) => 0.0005822634,
   (f_rel_homeover50_count_d > 13.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 2.5) => 0.0104516988,
      (f_srchssnsrchcount_i > 2.5) => 0.0016810924,
      (f_srchssnsrchcount_i = NULL) => 0.0067224646, 0.0067224646),
   (f_rel_homeover50_count_d = NULL) => 0.0021608172, 0.0021608172),
(eda_address_match_best = NULL) => -0.0000532094, -0.0000532094);

// Tree: 914 
final_score_914 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -45588.5) => 0.0020947738,
(f_addrchangeincomediff_d > -45588.5) => -0.0004561573,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < number_of_sources and number_of_sources <= 3.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 385) => -0.0009722617,
      (r_pb_order_freq_d > 385) => 0.0042085131,
      (r_pb_order_freq_d = NULL) => 0.0010539435, -0.0000054513),
   (number_of_sources > 3.5) => 0.0048351605,
   (number_of_sources = NULL) => 0.0001924919, 0.0001924919), -0.0002147704);

// Tree: 915 
final_score_915 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 7.5) => -0.0004875352,
(f_corraddrnamecount_d > 7.5) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 141.5) => 
      map(
      (NULL < pk_cell_indicator and pk_cell_indicator <= 3.5) => 0.0000972390,
      (pk_cell_indicator > 3.5) => 0.0024166835,
      (pk_cell_indicator = NULL) => 0.0004578788, 0.0004578788),
   (mth_pp_app_npa_last_change_dt > 141.5) => 0.0067315686,
   (mth_pp_app_npa_last_change_dt = NULL) => 0.0006776729, 0.0006776729),
(f_corraddrnamecount_d = NULL) => -0.0001292825, -0.0001292825);

// Tree: 916 
final_score_916 := map(
(NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 10.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 20.5) => 
      map(
      (NULL < internal_verification and internal_verification <= 0.5) => -0.0006146333,
      (internal_verification > 0.5) => 0.0025741880,
      (internal_verification = NULL) => 0.0002689687, 0.0002689687),
   (mth_source_ppdid_lseen > 20.5) => -0.0024075605,
   (mth_source_ppdid_lseen = NULL) => -0.0000242200, -0.0000242200),
(mth_source_ppth_lseen > 10.5) => -0.0050726613,
(mth_source_ppth_lseen = NULL) => -0.0002216418, -0.0002216418);

// Tree: 917 
final_score_917 := map(
(NULL < mth_source_edahistory_fseen and mth_source_edahistory_fseen <= 13.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 5.5) => -0.0000226980,
   (f_rel_felony_count_i > 5.5) => 
      map(
      (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 8.5) => 0.0078595629,
      (f_crim_rel_under100miles_cnt_i > 8.5) => 0.0006752448,
      (f_crim_rel_under100miles_cnt_i = NULL) => 0.0036748828, 0.0036748828),
   (f_rel_felony_count_i = NULL) => 0.0000633851, 0.0000633851),
(mth_source_edahistory_fseen > 13.5) => -0.0039230143,
(mth_source_edahistory_fseen = NULL) => -0.0000336961, -0.0000336961);

// Tree: 918 
final_score_918 := map(
(exp_source in ['S']) => 0.0057636777,
(exp_source in ['P']) => 0.0065552879,
(exp_source = '') => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => 
      map(
      (NULL < number_of_sources and number_of_sources <= 1.5) => -0.0041327823,
      (number_of_sources > 1.5) => 0.0018316740,
      (number_of_sources = NULL) => -0.0029783396, -0.0029783396),
   (source_rel > 0.5) => 0.0100654157,
   (source_rel = NULL) => -0.0023640566, -0.0023640566), -0.0002364113);

// Tree: 919 
final_score_919 := map(
(NULL < _internal_ver_match_hhid and _internal_ver_match_hhid <= 0.5) => -0.0000611813,
(_internal_ver_match_hhid > 0.5) => 
   map(
   (NULL < f_inq_lnames_per_addr_i and f_inq_lnames_per_addr_i <= 1.5) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 128.5) => -0.0007434747,
      (mth_pp_app_npa_effective_dt > 128.5) => 0.0034672008,
      (mth_pp_app_npa_effective_dt = NULL) => 0.0022809844, 0.0022809844),
   (f_inq_lnames_per_addr_i > 1.5) => -0.0032227287,
   (f_inq_lnames_per_addr_i = NULL) => 0.0013227108, 0.0013227108),
(_internal_ver_match_hhid = NULL) => 0.0000439757, 0.0000439757);

// Tree: 920 
final_score_920 := map(
(NULL < mth_source_sp_fseen and mth_source_sp_fseen <= 2.5) => 
   map(
   (exp_source in ['P']) => -0.0019188428,
   (exp_source in ['S']) => -0.0002439365,
   (exp_source = '') => -0.0001395470, -0.0002328651),
(mth_source_sp_fseen > 2.5) => 
   map(
   (NULL < mth_source_sp_lseen and mth_source_sp_lseen <= 1.5) => 0.0045165568,
   (mth_source_sp_lseen > 1.5) => -0.0009419712,
   (mth_source_sp_lseen = NULL) => 0.0019807052, 0.0019807052),
(mth_source_sp_fseen = NULL) => -0.0001670359, -0.0001670359);

// Tree: 921 
final_score_921 := map(
(NULL < mth_source_paw_lseen and mth_source_paw_lseen <= 0.5) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 0.5) => 0.0004078043,
   (f_rel_homeover200_count_d > 0.5) => -0.0004099278,
   (f_rel_homeover200_count_d = NULL) => -0.0001558893, -0.0001558893),
(mth_source_paw_lseen > 0.5) => 
   map(
   (eda_pfrd_address_ind in ['1A','1C','1E','XX']) => -0.0011046936,
   (eda_pfrd_address_ind in ['1B','1D']) => 0.0051598825,
   (eda_pfrd_address_ind = '') => 0.0020275945, 0.0020275945),
(mth_source_paw_lseen = NULL) => -0.0001185648, -0.0001185648);

// Tree: 922 
final_score_922 := map(
(NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 69.5) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 41.5) => -0.0000474464,
   (mth_pp_app_npa_last_change_dt > 41.5) => 
      map(
      (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 10.5) => -0.0028568481,
      (f_rel_homeover200_count_d > 10.5) => 0.0021093274,
      (f_rel_homeover200_count_d = NULL) => -0.0020307348, -0.0020307348),
   (mth_pp_app_npa_last_change_dt = NULL) => -0.0002240082, -0.0002240082),
(mth_pp_app_npa_last_change_dt > 69.5) => 0.0006889935,
(mth_pp_app_npa_last_change_dt = NULL) => 0.0000598016, 0.0000598016);

// Tree: 923 
final_score_923 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 41.5) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 18.5) => -0.0000614392,
   (inq_adl_firstseen_n > 18.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 23.5) => 0.0021456170,
      (f_addrchangecrimediff_i > 23.5) => -0.0016348101,
      (f_addrchangecrimediff_i = NULL) => 0.0009703096, 0.0010969627),
   (inq_adl_firstseen_n = NULL) => 0.0000349062, 0.0000349062),
(f_inq_count_i > 41.5) => -0.0024092424,
(f_inq_count_i = NULL) => -0.0000589674, -0.0000589674);

// Tree: 924 
final_score_924 := map(
(NULL < mth_source_edaca_lseen and mth_source_edaca_lseen <= 10.5) => 
   map(
   (NULL < _pp_rule_low_vend_conf and _pp_rule_low_vend_conf <= 0.5) => -0.0000733165,
   (_pp_rule_low_vend_conf > 0.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 53.5) => 0.0059818927,
      (f_prevaddrmurderindex_i > 53.5) => 0.0006038366,
      (f_prevaddrmurderindex_i = NULL) => 0.0021692801, 0.0021692801),
   (_pp_rule_low_vend_conf = NULL) => -0.0000169606, -0.0000169606),
(mth_source_edaca_lseen > 10.5) => -0.0054576780,
(mth_source_edaca_lseen = NULL) => -0.0000583664, -0.0000583664);

// Tree: 925 
final_score_925 := map(
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Father','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Wife']) => -0.0034676696,
(phone_subject_title in ['Associate','Associate By Property','Associate By Vehicle','Daughter','Grandchild','Subject','Subject at Household']) => 
   map(
   (exp_source in ['S']) => 0.0049648436,
   (exp_source in ['P']) => 0.0081533000,
   (exp_source = '') => 
      map(
      (NULL < source_rel and source_rel <= 0.5) => -0.0003267780,
      (source_rel > 0.5) => 0.0093151029,
      (source_rel = NULL) => 0.0007839289, 0.0007839289), 0.0026986508),
(phone_subject_title = '') => -0.0000505996, -0.0000505996);

// Tree: 926 
final_score_926 := map(
(NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 163.5) => 0.0001245624,
(f_fp_prevaddrburglaryindex_i > 163.5) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 18.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Vehicle','Brother','Daughter','Father','Grandfather','Grandmother','Grandson','Mother','Parent','Spouse']) => -0.0029279457,
      (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By SSN','Child','Grandchild','Granddaughter','Grandparent','Husband','Neighbor','Relative','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => -0.0001506206,
      (phone_subject_title = '') => -0.0004713437, -0.0004713437),
   (mth_exp_last_update > 18.5) => -0.0029785183,
   (mth_exp_last_update = NULL) => -0.0006367625, -0.0006367625),
(f_fp_prevaddrburglaryindex_i = NULL) => -0.0000308410, -0.0000308410);

// Tree: 927 
final_score_927 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 90987) => -0.0001320571,
(f_prevaddrmedianincome_d > 90987) => 
   map(
   (phone_subject_title in ['Associate','Associate By Vehicle','Brother','Child','Daughter','Grandmother','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Subject at Household']) => -0.0012504399,
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Mother','Spouse','Subject','Wife']) => 
      map(
      (NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 0.5) => 0.0032756370,
      (f_inq_per_ssn_i > 0.5) => 0.0002016417,
      (f_inq_per_ssn_i = NULL) => 0.0018158401, 0.0018158401),
   (phone_subject_title = '') => 0.0007246052, 0.0007246052),
(f_prevaddrmedianincome_d = NULL) => -0.0000638371, -0.0000638371);

// Tree: 928 
final_score_928 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 13.5) => -0.0000512268,
(f_srchaddrsrchcount_i > 13.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 51.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Vehicle','Brother','Father','Grandfather','Husband','Mother','Neighbor','Sister','Son','Subject at Household']) => -0.0003246966,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Child','Daughter','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Parent','Relative','Sibling','Spouse','Subject','Wife']) => 0.0040258611,
      (phone_subject_title = '') => 0.0023973101, 0.0023973101),
   (f_prevaddrcartheftindex_i > 51.5) => 0.0004506765,
   (f_prevaddrcartheftindex_i = NULL) => 0.0007449534, 0.0007449534),
(f_srchaddrsrchcount_i = NULL) => 0.0000641117, 0.0000641117);

// Tree: 929 
final_score_929 := map(
(NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 5.5) => 
   map(
   (NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 19.5) => 0.0002394264,
   (mth_pp_first_build_date > 19.5) => 0.0020851986,
   (mth_pp_first_build_date = NULL) => 0.0003165631, 0.0003165631),
(mth_internal_ver_first_seen > 5.5) => 
   map(
   (NULL < f_adl_util_conv_n and f_adl_util_conv_n <= 0.5) => 0.0004566011,
   (f_adl_util_conv_n > 0.5) => -0.0007018154,
   (f_adl_util_conv_n = NULL) => -0.0003030774, -0.0003030774),
(mth_internal_ver_first_seen = NULL) => 0.0001586966, 0.0001586966);

// Tree: 930 
final_score_930 := map(
(NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 288.5) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 26.5) => 0.0000911522,
   (mth_exp_last_update > 26.5) => 
      map(
      (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 4712.5) => -0.0015743755,
      (eda_days_ph_first_seen > 4712.5) => 0.0032256998,
      (eda_days_ph_first_seen = NULL) => -0.0008628599, -0.0008628599),
   (mth_exp_last_update = NULL) => 0.0000400908, 0.0000400908),
(mth_source_inf_fseen > 288.5) => 0.0025301125,
(mth_source_inf_fseen = NULL) => 0.0000680784, 0.0000680784);

// Tree: 931 
final_score_931 := map(
(NULL < mth_source_ppth_fseen and mth_source_ppth_fseen <= 23.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 20.5) => 0.0002058103,
   (mth_source_ppdid_fseen > 20.5) => 
      map(
      (NULL < mth_source_exp_lseen and mth_source_exp_lseen <= 3.5) => -0.0004692649,
      (mth_source_exp_lseen > 3.5) => -0.0039341768,
      (mth_source_exp_lseen = NULL) => -0.0006038246, -0.0006038246),
   (mth_source_ppdid_fseen = NULL) => 0.0000644159, 0.0000644159),
(mth_source_ppth_fseen > 23.5) => -0.0025340586,
(mth_source_ppth_fseen = NULL) => -0.0000219869, -0.0000219869);

// Tree: 932 
final_score_932 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 52227) => -0.0002118997,
(f_prevaddrmedianincome_d > 52227) => 
   map(
   (NULL < pp_app_company_type and pp_app_company_type <= 7.5) => 0.0002092864,
   (pp_app_company_type > 7.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -27.5) => -0.0010809323,
      (f_addrchangecrimediff_i > -27.5) => 0.0015733728,
      (f_addrchangecrimediff_i = NULL) => 0.0030917627, 0.0014461047),
   (pp_app_company_type = NULL) => 0.0003076621, 0.0003076621),
(f_prevaddrmedianincome_d = NULL) => 0.0000152451, 0.0000152451);

// Tree: 933 
final_score_933 := map(
(NULL < mth_source_exp_fseen and mth_source_exp_fseen <= 6.5) => 0.0000534312,
(mth_source_exp_fseen > 6.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => -0.0028974669,
   (f_mos_inq_banko_om_fseen_d > 36.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 6.5) => 0.0001261547,
      (f_rel_criminal_count_i > 6.5) => -0.0027270302,
      (f_rel_criminal_count_i = NULL) => -0.0003870706, -0.0003870706),
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0008793052, -0.0008793052),
(mth_source_exp_fseen = NULL) => 0.0000088748, 0.0000088748);

// Tree: 934 
final_score_934 := map(
(NULL < pk_cell_indicator and pk_cell_indicator <= 2.5) => 
   map(
   (NULL < source_eda_any_clean and source_eda_any_clean <= 0.5) => -0.0003971649,
   (source_eda_any_clean > 0.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 1.5) => 0.0024747936,
      (f_util_adl_count_n > 1.5) => -0.0004350445,
      (f_util_adl_count_n = NULL) => 0.0010711611, 0.0010711611),
   (source_eda_any_clean = NULL) => -0.0002840715, -0.0002840715),
(pk_cell_indicator > 2.5) => 0.0006991148,
(pk_cell_indicator = NULL) => -0.0001064510, -0.0001064510);

// Tree: 935 
final_score_935 := map(
(NULL < f_idrisktype_i and f_idrisktype_i <= 1.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.424263162413235) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 14.5) => 0.0002526511,
      (f_corraddrnamecount_d > 14.5) => -0.0014126408,
      (f_corraddrnamecount_d = NULL) => 0.0002016939, 0.0002016939),
   (f_add_curr_mobility_index_n > 0.424263162413235) => -0.0002438847,
   (f_add_curr_mobility_index_n = NULL) => -0.0003034990, 0.0000618236),
(f_idrisktype_i > 1.5) => -0.0011415593,
(f_idrisktype_i = NULL) => 0.0000105318, 0.0000105318);

// Tree: 936 
final_score_936 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 157.5) => 0.0000403379,
(f_curraddrcartheftindex_i > 157.5) => 
   map(
   (NULL < pk_phone_match_level and pk_phone_match_level <= 3.5) => -0.0001718491,
   (pk_phone_match_level > 3.5) => 
      map(
      (pp_source in ['INQUIRY','OTHER','PCNSR','THRIVE']) => -0.0023181416,
      (pp_source in ['CELL','GONG','HEADER','IBEHAVIOR','INFUTOR','INTRADO','TARGUS']) => -0.0000032394,
      (pp_source = '') => -0.0009793700, -0.0010386810),
   (pk_phone_match_level = NULL) => -0.0003760288, -0.0003760288),
(f_curraddrcartheftindex_i = NULL) => -0.0000617061, -0.0000617061);

// Tree: 937 
final_score_937 := map(
(NULL < source_rel and source_rel <= 0.5) => -0.0001141063,
(source_rel > 0.5) => 
   map(
   (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 1.5) => 0.0019412334,
   (f_crim_rel_under500miles_cnt_i > 1.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 31) => 0.0019390269,
      (f_prevaddrlenofres_d > 31) => -0.0004560733,
      (f_prevaddrlenofres_d = NULL) => 0.0002020398, 0.0002020398),
   (f_crim_rel_under500miles_cnt_i = NULL) => 0.0008474630, 0.0008474630),
(source_rel = NULL) => -0.0000741394, -0.0000741394);

// Tree: 938 
final_score_938 := map(
(NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 8.5) => 0.0000328250,
(mth_internal_ver_first_seen > 8.5) => 
   map(
   (NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 84) => 
      map(
      (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 30.5) => -0.0015314443,
      (mth_pp_eda_hist_did_dt > 30.5) => -0.0001545294,
      (mth_pp_eda_hist_did_dt = NULL) => -0.0007617842, -0.0007617842),
   (r_mos_since_paw_fseen_d > 84) => 0.0010380549,
   (r_mos_since_paw_fseen_d = NULL) => -0.0005287693, -0.0005287693),
(mth_internal_ver_first_seen = NULL) => -0.0000113609, -0.0000113609);

// Tree: 939 
final_score_939 := map(
(NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 35.5) => 
   map(
   (NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 1907) => -0.0000760356,
   (eda_max_days_interrupt > 1907) => 
      map(
      (phone_subject_title in ['Associate By Business','Associate By Vehicle','Brother','Mother','Neighbor','Parent','Sister','Son','Wife']) => -0.0010594757,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Relative','Sibling','Spouse','Subject','Subject at Household']) => 0.0016076216,
      (phone_subject_title = '') => 0.0007149605, 0.0007149605),
   (eda_max_days_interrupt = NULL) => -0.0000531095, -0.0000531095),
(f_rel_homeover100_count_d > 35.5) => 0.0019408999,
(f_rel_homeover100_count_d = NULL) => -0.0000397536, -0.0000397536);

// Tree: 940 
final_score_940 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 14.5) => 0.0000504512,
(f_addrchangecrimediff_i > 14.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Grandfather','Grandmother','Grandson','Husband','Neighbor','Parent','Sibling','Son','Spouse','Subject']) => -0.0003575135,
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By SSN','Brother','Father','Grandchild','Granddaughter','Grandparent','Mother','Relative','Sister','Subject at Household','Wife']) => 0.0006494373,
   (phone_subject_title = '') => -0.0001947303, -0.0001947303),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 0.0000912659,
   (f_rel_felony_count_i > 4.5) => 0.0022113017,
   (f_rel_felony_count_i = NULL) => 0.0001763443, 0.0001763443), 0.0000218561);

// Tree: 941 
final_score_941 := map(
(pp_src in ['CY','E1','FA','LP','NW','SL','ZK','ZT']) => -0.0011389863,
(pp_src in ['E2','EB','EM','EN','EQ','FF','KW','LA','MD','PL','TN','UT','UW','VO','VW']) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 42771) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 128) => 0.0000088876,
      (r_pb_order_freq_d > 128) => 0.0008032472,
      (r_pb_order_freq_d = NULL) => 0.0008778807, 0.0004828966),
   (f_curraddrmedianincome_d > 42771) => -0.0000971140,
   (f_curraddrmedianincome_d = NULL) => 0.0001056651, 0.0001056651),
(pp_src = '') => -0.0000145871, -0.0000002947);

// Tree: 942 
final_score_942 := map(
(NULL < eda_days_in_service and eda_days_in_service <= 1901.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Child','Granddaughter','Grandparent','Grandson','Husband','Neighbor','Parent','Sister','Son','Spouse','Subject','Subject at Household']) => 0.0000304482,
   (phone_subject_title in ['Associate By Business','Associate By Vehicle','Daughter','Father','Grandchild','Grandfather','Grandmother','Mother','Relative','Sibling','Wife']) => 
      map(
      (NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 6.5) => 0.0015973822,
      (mth_eda_dt_first_seen > 6.5) => 0.0003323403,
      (mth_eda_dt_first_seen = NULL) => 0.0004607389, 0.0004607389),
   (phone_subject_title = '') => 0.0000635560, 0.0000635560),
(eda_days_in_service > 1901.5) => -0.0003567878,
(eda_days_in_service = NULL) => 0.0000276292, 0.0000276292);

// Tree: 943 
final_score_943 := map(
(NULL < mth_source_exp_fseen and mth_source_exp_fseen <= 4.5) => -0.0000431727,
(mth_source_exp_fseen > 4.5) => 
   map(
   (NULL < _pp_hhid_flag and _pp_hhid_flag <= 0.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 2.5) => -0.0005233611,
      (f_srchfraudsrchcount_i > 2.5) => 0.0007923631,
      (f_srchfraudsrchcount_i = NULL) => 0.0000614052, 0.0000614052),
   (_pp_hhid_flag > 0.5) => -0.0006420598,
   (_pp_hhid_flag = NULL) => -0.0003261587, -0.0003261587),
(mth_source_exp_fseen = NULL) => -0.0000591095, -0.0000591095);

// Tree: 944 
final_score_944 := map(
(NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 11.5) => 
      map(
      (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 21.5) => 0.0000037654,
      (inq_adl_firstseen_n > 21.5) => 0.0005671592,
      (inq_adl_firstseen_n = NULL) => 0.0000324038, 0.0000324038),
   (f_inq_count_i > 11.5) => -0.0002411786,
   (f_inq_count_i = NULL) => -0.0000623601, -0.0000623601),
(_inq_adl_ph_industry_flag > 0.5) => 0.0004830240,
(_inq_adl_ph_industry_flag = NULL) => -0.0000455024, -0.0000455024);

// Tree: 945 
final_score_945 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Vehicle','Brother','Child','Father','Granddaughter','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Subject at Household','Wife']) => -0.0000790716,
(phone_subject_title in ['Associate By Property','Associate By Shared Associates','Associate By SSN','Daughter','Grandchild','Grandfather','Grandmother','Grandparent','Mother','Sister','Son','Spouse','Subject']) => 
   map(
   (NULL < f_college_income_d and f_college_income_d <= 3.5) => 
      map(
      (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 4.5) => 0.0000054430,
      (f_crim_rel_under500miles_cnt_i > 4.5) => 0.0010599735,
      (f_crim_rel_under500miles_cnt_i = NULL) => 0.0003838334, 0.0003838334),
   (f_college_income_d > 3.5) => -0.0000301586,
   (f_college_income_d = NULL) => 0.0000643520, 0.0000641191),
(phone_subject_title = '') => -0.0000019690, -0.0000019690);

// Tree: 946 
final_score_946 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 11.5) => 
   map(
   (NULL < _pp_rule_low_vend_conf and _pp_rule_low_vend_conf <= 0.5) => -0.0000028913,
   (_pp_rule_low_vend_conf > 0.5) => 
      map(
      (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 73.5) => 0.0000160701,
      (mth_source_ppdid_fseen > 73.5) => 0.0003839206,
      (mth_source_ppdid_fseen = NULL) => 0.0001016168, 0.0001016168),
   (_pp_rule_low_vend_conf = NULL) => -0.0000002274, -0.0000002274),
(f_rel_homeover500_count_d > 11.5) => -0.0001950631,
(f_rel_homeover500_count_d = NULL) => -0.0000019673, -0.0000019673);

// Tree: 947 
final_score_947 := map(
(NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 86.5) => 
   map(
   (NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 36.5) => -0.0000001440,
   (mth_source_ppla_fseen > 36.5) => 
      map(
      (NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 40.5) => 0.0000581427,
      (mth_source_ppla_lseen > 40.5) => -0.0000144630,
      (mth_source_ppla_lseen = NULL) => 0.0000313419, 0.0000313419),
   (mth_source_ppla_fseen = NULL) => 0.0000004104, 0.0000004104),
(mth_source_ppla_fseen > 86.5) => -0.0000416874,
(mth_source_ppla_fseen = NULL) => 0.0000000210, 0.0000000210);

// Tree: 948 
final_score_948 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 1.5) => 0.0000009814,
(f_varrisktype_i > 1.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 11.5) => 
      map(
      (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 2.5) => -0.0000039882,
      (pp_app_ind_ph_cnt > 2.5) => 0.0000067823,
      (pp_app_ind_ph_cnt = NULL) => -0.0000012865, -0.0000012865),
   (mth_source_ppdid_fseen > 11.5) => -0.0000126502,
   (mth_source_ppdid_fseen = NULL) => -0.0000039390, -0.0000039390),
(f_varrisktype_i = NULL) => -0.0000001391, -0.0000001391);

// Tree: 949 
final_score_949 := map(
(NULL < _phone_match_code_lns and _phone_match_code_lns <= 0.5) => -0.0000098716,
(_phone_match_code_lns > 0.5) => 
   map(
   (exp_source in ['S']) => 0.0000167196,
   (exp_source in ['P']) => 0.0000208380,
   (exp_source = '') => 
      map(
      (NULL < _phone_match_code_l and _phone_match_code_l <= 0.5) => 0.0000221444,
      (_phone_match_code_l > 0.5) => -0.0000008001,
      (_phone_match_code_l = NULL) => 0.0000023518, 0.0000023518), 0.0000084070),
(_phone_match_code_lns = NULL) => -0.0000007655, -0.0000007655);

// Final Score Sum 

   final_score := sum(
      final_score_0, final_score_1, final_score_2, final_score_3, final_score_4, 
      final_score_5, final_score_6, final_score_7, final_score_8, final_score_9, 
      final_score_10, final_score_11, final_score_12, final_score_13, final_score_14, 
      final_score_15, final_score_16, final_score_17, final_score_18, final_score_19, 
      final_score_20, final_score_21, final_score_22, final_score_23, final_score_24, 
      final_score_25, final_score_26, final_score_27, final_score_28, final_score_29, 
      final_score_30, final_score_31, final_score_32, final_score_33, final_score_34, 
      final_score_35, final_score_36, final_score_37, final_score_38, final_score_39, 
      final_score_40, final_score_41, final_score_42, final_score_43, final_score_44, 
      final_score_45, final_score_46, final_score_47, final_score_48, final_score_49, 
      final_score_50, final_score_51, final_score_52, final_score_53, final_score_54, 
      final_score_55, final_score_56, final_score_57, final_score_58, final_score_59, 
      final_score_60, final_score_61, final_score_62, final_score_63, final_score_64, 
      final_score_65, final_score_66, final_score_67, final_score_68, final_score_69, 
      final_score_70, final_score_71, final_score_72, final_score_73, final_score_74, 
      final_score_75, final_score_76, final_score_77, final_score_78, final_score_79, 
      final_score_80, final_score_81, final_score_82, final_score_83, final_score_84, 
      final_score_85, final_score_86, final_score_87, final_score_88, final_score_89, 
      final_score_90, final_score_91, final_score_92, final_score_93, final_score_94, 
      final_score_95, final_score_96, final_score_97, final_score_98, final_score_99, 
      final_score_100, final_score_101, final_score_102, final_score_103, final_score_104, 
      final_score_105, final_score_106, final_score_107, final_score_108, final_score_109, 
      final_score_110, final_score_111, final_score_112, final_score_113, final_score_114, 
      final_score_115, final_score_116, final_score_117, final_score_118, final_score_119, 
      final_score_120, final_score_121, final_score_122, final_score_123, final_score_124, 
      final_score_125, final_score_126, final_score_127, final_score_128, final_score_129, 
      final_score_130, final_score_131, final_score_132, final_score_133, final_score_134, 
      final_score_135, final_score_136, final_score_137, final_score_138, final_score_139, 
      final_score_140, final_score_141, final_score_142, final_score_143, final_score_144, 
      final_score_145, final_score_146, final_score_147, final_score_148, final_score_149, 
      final_score_150, final_score_151, final_score_152, final_score_153, final_score_154, 
      final_score_155, final_score_156, final_score_157, final_score_158, final_score_159, 
      final_score_160, final_score_161, final_score_162, final_score_163, final_score_164, 
      final_score_165, final_score_166, final_score_167, final_score_168, final_score_169, 
      final_score_170, final_score_171, final_score_172, final_score_173, final_score_174, 
      final_score_175, final_score_176, final_score_177, final_score_178, final_score_179, 
      final_score_180, final_score_181, final_score_182, final_score_183, final_score_184, 
      final_score_185, final_score_186, final_score_187, final_score_188, final_score_189, 
      final_score_190, final_score_191, final_score_192, final_score_193, final_score_194, 
      final_score_195, final_score_196, final_score_197, final_score_198, final_score_199, 
      final_score_200, final_score_201, final_score_202, final_score_203, final_score_204, 
      final_score_205, final_score_206, final_score_207, final_score_208, final_score_209, 
      final_score_210, final_score_211, final_score_212, final_score_213, final_score_214, 
      final_score_215, final_score_216, final_score_217, final_score_218, final_score_219, 
      final_score_220, final_score_221, final_score_222, final_score_223, final_score_224, 
      final_score_225, final_score_226, final_score_227, final_score_228, final_score_229, 
      final_score_230, final_score_231, final_score_232, final_score_233, final_score_234, 
      final_score_235, final_score_236, final_score_237, final_score_238, final_score_239, 
      final_score_240, final_score_241, final_score_242, final_score_243, final_score_244, 
      final_score_245, final_score_246, final_score_247, final_score_248, final_score_249, 
      final_score_250, final_score_251, final_score_252, final_score_253, final_score_254, 
      final_score_255, final_score_256, final_score_257, final_score_258, final_score_259, 
      final_score_260, final_score_261, final_score_262, final_score_263, final_score_264, 
      final_score_265, final_score_266, final_score_267, final_score_268, final_score_269, 
      final_score_270, final_score_271, final_score_272, final_score_273, final_score_274, 
      final_score_275, final_score_276, final_score_277, final_score_278, final_score_279, 
      final_score_280, final_score_281, final_score_282, final_score_283, final_score_284, 
      final_score_285, final_score_286, final_score_287, final_score_288, final_score_289, 
      final_score_290, final_score_291, final_score_292, final_score_293, final_score_294, 
      final_score_295, final_score_296, final_score_297, final_score_298, final_score_299, 
      final_score_300, final_score_301, final_score_302, final_score_303, final_score_304, 
      final_score_305, final_score_306, final_score_307, final_score_308, final_score_309, 
      final_score_310, final_score_311, final_score_312, final_score_313, final_score_314, 
      final_score_315, final_score_316, final_score_317, final_score_318, final_score_319, 
      final_score_320, final_score_321, final_score_322, final_score_323, final_score_324, 
      final_score_325, final_score_326, final_score_327, final_score_328, final_score_329, 
      final_score_330, final_score_331, final_score_332, final_score_333, final_score_334, 
      final_score_335, final_score_336, final_score_337, final_score_338, final_score_339, 
      final_score_340, final_score_341, final_score_342, final_score_343, final_score_344, 
      final_score_345, final_score_346, final_score_347, final_score_348, final_score_349, 
      final_score_350, final_score_351, final_score_352, final_score_353, final_score_354, 
      final_score_355, final_score_356, final_score_357, final_score_358, final_score_359, 
      final_score_360, final_score_361, final_score_362, final_score_363, final_score_364, 
      final_score_365, final_score_366, final_score_367, final_score_368, final_score_369, 
      final_score_370, final_score_371, final_score_372, final_score_373, final_score_374, 
      final_score_375, final_score_376, final_score_377, final_score_378, final_score_379, 
      final_score_380, final_score_381, final_score_382, final_score_383, final_score_384, 
      final_score_385, final_score_386, final_score_387, final_score_388, final_score_389, 
      final_score_390, final_score_391, final_score_392, final_score_393, final_score_394, 
      final_score_395, final_score_396, final_score_397, final_score_398, final_score_399, 
      final_score_400, final_score_401, final_score_402, final_score_403, final_score_404, 
      final_score_405, final_score_406, final_score_407, final_score_408, final_score_409, 
      final_score_410, final_score_411, final_score_412, final_score_413, final_score_414, 
      final_score_415, final_score_416, final_score_417, final_score_418, final_score_419, 
      final_score_420, final_score_421, final_score_422, final_score_423, final_score_424, 
      final_score_425, final_score_426, final_score_427, final_score_428, final_score_429, 
      final_score_430, final_score_431, final_score_432, final_score_433, final_score_434, 
      final_score_435, final_score_436, final_score_437, final_score_438, final_score_439, 
      final_score_440, final_score_441, final_score_442, final_score_443, final_score_444, 
      final_score_445, final_score_446, final_score_447, final_score_448, final_score_449, 
      final_score_450, final_score_451, final_score_452, final_score_453, final_score_454, 
      final_score_455, final_score_456, final_score_457, final_score_458, final_score_459, 
      final_score_460, final_score_461, final_score_462, final_score_463, final_score_464, 
      final_score_465, final_score_466, final_score_467, final_score_468, final_score_469, 
      final_score_470, final_score_471, final_score_472, final_score_473, final_score_474, 
      final_score_475, final_score_476, final_score_477, final_score_478, final_score_479, 
      final_score_480, final_score_481, final_score_482, final_score_483, final_score_484, 
      final_score_485, final_score_486, final_score_487, final_score_488, final_score_489, 
      final_score_490, final_score_491, final_score_492, final_score_493, final_score_494, 
      final_score_495, final_score_496, final_score_497, final_score_498, final_score_499, 
      final_score_500, final_score_501, final_score_502, final_score_503, final_score_504, 
      final_score_505, final_score_506, final_score_507, final_score_508, final_score_509, 
      final_score_510, final_score_511, final_score_512, final_score_513, final_score_514, 
      final_score_515, final_score_516, final_score_517, final_score_518, final_score_519, 
      final_score_520, final_score_521, final_score_522, final_score_523, final_score_524, 
      final_score_525, final_score_526, final_score_527, final_score_528, final_score_529, 
      final_score_530, final_score_531, final_score_532, final_score_533, final_score_534, 
      final_score_535, final_score_536, final_score_537, final_score_538, final_score_539, 
      final_score_540, final_score_541, final_score_542, final_score_543, final_score_544, 
      final_score_545, final_score_546, final_score_547, final_score_548, final_score_549, 
      final_score_550, final_score_551, final_score_552, final_score_553, final_score_554, 
      final_score_555, final_score_556, final_score_557, final_score_558, final_score_559, 
      final_score_560, final_score_561, final_score_562, final_score_563, final_score_564, 
      final_score_565, final_score_566, final_score_567, final_score_568, final_score_569, 
      final_score_570, final_score_571, final_score_572, final_score_573, final_score_574, 
      final_score_575, final_score_576, final_score_577, final_score_578, final_score_579, 
      final_score_580, final_score_581, final_score_582, final_score_583, final_score_584, 
      final_score_585, final_score_586, final_score_587, final_score_588, final_score_589, 
      final_score_590, final_score_591, final_score_592, final_score_593, final_score_594, 
      final_score_595, final_score_596, final_score_597, final_score_598, final_score_599, 
      final_score_600, final_score_601, final_score_602, final_score_603, final_score_604, 
      final_score_605, final_score_606, final_score_607, final_score_608, final_score_609, 
      final_score_610, final_score_611, final_score_612, final_score_613, final_score_614, 
      final_score_615, final_score_616, final_score_617, final_score_618, final_score_619, 
      final_score_620, final_score_621, final_score_622, final_score_623, final_score_624, 
      final_score_625, final_score_626, final_score_627, final_score_628, final_score_629, 
      final_score_630, final_score_631, final_score_632, final_score_633, final_score_634, 
      final_score_635, final_score_636, final_score_637, final_score_638, final_score_639, 
      final_score_640, final_score_641, final_score_642, final_score_643, final_score_644, 
      final_score_645, final_score_646, final_score_647, final_score_648, final_score_649, 
      final_score_650, final_score_651, final_score_652, final_score_653, final_score_654, 
      final_score_655, final_score_656, final_score_657, final_score_658, final_score_659, 
      final_score_660, final_score_661, final_score_662, final_score_663, final_score_664, 
      final_score_665, final_score_666, final_score_667, final_score_668, final_score_669, 
      final_score_670, final_score_671, final_score_672, final_score_673, final_score_674, 
      final_score_675, final_score_676, final_score_677, final_score_678, final_score_679, 
      final_score_680, final_score_681, final_score_682, final_score_683, final_score_684, 
      final_score_685, final_score_686, final_score_687, final_score_688, final_score_689, 
      final_score_690, final_score_691, final_score_692, final_score_693, final_score_694, 
      final_score_695, final_score_696, final_score_697, final_score_698, final_score_699, 
      final_score_700, final_score_701, final_score_702, final_score_703, final_score_704, 
      final_score_705, final_score_706, final_score_707, final_score_708, final_score_709, 
      final_score_710, final_score_711, final_score_712, final_score_713, final_score_714, 
      final_score_715, final_score_716, final_score_717, final_score_718, final_score_719, 
      final_score_720, final_score_721, final_score_722, final_score_723, final_score_724, 
      final_score_725, final_score_726, final_score_727, final_score_728, final_score_729, 
      final_score_730, final_score_731, final_score_732, final_score_733, final_score_734, 
      final_score_735, final_score_736, final_score_737, final_score_738, final_score_739, 
      final_score_740, final_score_741, final_score_742, final_score_743, final_score_744, 
      final_score_745, final_score_746, final_score_747, final_score_748, final_score_749, 
      final_score_750, final_score_751, final_score_752, final_score_753, final_score_754, 
      final_score_755, final_score_756, final_score_757, final_score_758, final_score_759, 
      final_score_760, final_score_761, final_score_762, final_score_763, final_score_764, 
      final_score_765, final_score_766, final_score_767, final_score_768, final_score_769, 
      final_score_770, final_score_771, final_score_772, final_score_773, final_score_774, 
      final_score_775, final_score_776, final_score_777, final_score_778, final_score_779, 
      final_score_780, final_score_781, final_score_782, final_score_783, final_score_784, 
      final_score_785, final_score_786, final_score_787, final_score_788, final_score_789, 
      final_score_790, final_score_791, final_score_792, final_score_793, final_score_794, 
      final_score_795, final_score_796, final_score_797, final_score_798, final_score_799, 
      final_score_800, final_score_801, final_score_802, final_score_803, final_score_804, 
      final_score_805, final_score_806, final_score_807, final_score_808, final_score_809, 
      final_score_810, final_score_811, final_score_812, final_score_813, final_score_814, 
      final_score_815, final_score_816, final_score_817, final_score_818, final_score_819, 
      final_score_820, final_score_821, final_score_822, final_score_823, final_score_824, 
      final_score_825, final_score_826, final_score_827, final_score_828, final_score_829, 
      final_score_830, final_score_831, final_score_832, final_score_833, final_score_834, 
      final_score_835, final_score_836, final_score_837, final_score_838, final_score_839, 
      final_score_840, final_score_841, final_score_842, final_score_843, final_score_844, 
      final_score_845, final_score_846, final_score_847, final_score_848, final_score_849, 
      final_score_850, final_score_851, final_score_852, final_score_853, final_score_854, 
      final_score_855, final_score_856, final_score_857, final_score_858, final_score_859, 
      final_score_860, final_score_861, final_score_862, final_score_863, final_score_864, 
      final_score_865, final_score_866, final_score_867, final_score_868, final_score_869, 
      final_score_870, final_score_871, final_score_872, final_score_873, final_score_874, 
      final_score_875, final_score_876, final_score_877, final_score_878, final_score_879, 
      final_score_880, final_score_881, final_score_882, final_score_883, final_score_884, 
      final_score_885, final_score_886, final_score_887, final_score_888, final_score_889, 
      final_score_890, final_score_891, final_score_892, final_score_893, final_score_894, 
      final_score_895, final_score_896, final_score_897, final_score_898, final_score_899, 
      final_score_900, final_score_901, final_score_902, final_score_903, final_score_904, 
      final_score_905, final_score_906, final_score_907, final_score_908, final_score_909, 
      final_score_910, final_score_911, final_score_912, final_score_913, final_score_914, 
      final_score_915, final_score_916, final_score_917, final_score_918, final_score_919, 
      final_score_920, final_score_921, final_score_922, final_score_923, final_score_924, 
      final_score_925, final_score_926, final_score_927, final_score_928, final_score_929, 
      final_score_930, final_score_931, final_score_932, final_score_933, final_score_934, 
      final_score_935, final_score_936, final_score_937, final_score_938, final_score_939, 
      final_score_940, final_score_941, final_score_942, final_score_943, final_score_944, 
      final_score_945, final_score_946, final_score_947, final_score_948, final_score_949);  

points := 40;

odds := 1 / 20;

base := 300;

phat := exp(final_score) / (1 + exp(final_score));

cp3_1 := round(points * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);

// cp3 := min(if(max(cp3_1, 999) = NULL, NULL, max(cp3_1, 999)), 0);
cp3 := max(min(cp3_1,999),0);        /* Apply Caps at 0 and 999      PK - 5/11/2016 */

	#if(PHONE_DEBUG)
			self.clam                             := le;
			self.sysdate							:=	 sysdate	;		
			self.phone_pos_cr					:=	phone_pos_cr	;		
			self.phone_pos_edaca			:=	phone_pos_edaca	;		
			self.phone_pos_edadid			:=	phone_pos_edadid	;		
			self.phone_pos_edafa			:=	phone_pos_edafa	;		
			self.phone_pos_edafla			:=	phone_pos_edafla	;		
			self.phone_pos_edahistory	:=	phone_pos_edahistory	;		
			self.phone_pos_edala			:=	phone_pos_edala	;		
			self.phone_pos_edalfa			:=	phone_pos_edalfa	;		
			self.phone_pos_exp				:=	phone_pos_exp	;		
			self.phone_pos_inf				:=	phone_pos_inf	;		
			self.phone_pos_input			:=	phone_pos_input	;		
			self.phone_pos_md					:=	phone_pos_md	;		
			self.phone_pos_ne					:=	phone_pos_ne	;		
			self.phone_pos_paw				:=	phone_pos_paw	;		
			self.phone_pos_pde				:=	phone_pos_pde	;		
			self.phone_pos_pf					:=	phone_pos_pf	;		
			self.phone_pos_pffla			:=	phone_pos_pffla	;		
			self.phone_pos_pfla				:=	phone_pos_pfla	;		 
			self.phone_pos_ppca				:=	phone_pos_ppca	;		
			self.phone_pos_ppdid			:=	phone_pos_ppdid	;		
			self.phone_pos_ppfa				:=	phone_pos_ppfa	;		
			self.phone_pos_ppfla			:=	phone_pos_ppfla	;		
			self.phone_pos_ppla				:=	phone_pos_ppla	;		
			self.phone_pos_pplfa			:=	phone_pos_pplfa	;		
			self.phone_pos_ppth				:=	phone_pos_ppth	;		
			self.phone_pos_rel				:=	phone_pos_rel	;		
			self.phone_pos_rm					:=	phone_pos_rm	;		
			self.phone_pos_sp					:=	phone_pos_sp	;		
			self.phone_pos_sx					:=	phone_pos_sx	;		
			self.phone_pos_utildid		:=	phone_pos_utildid	;		
			self.source_cr						:=	source_cr	;		
			self.source_edaca					:=	source_edaca	;		
			self.source_edadid				:=	source_edadid	;		
			self.source_edafa					:=	source_edafa	;		
			self.source_edafla				:=	source_edafla	;		
			self.source_edahistory		:=	source_edahistory	;		
			self.source_edala					:=	source_edala	;		
			self.source_edalfa				:=	source_edalfa	;		
			self.source_exp						:=	source_exp	;		
			self.source_inf						:=	source_inf	;		
			self.source_input					:=	source_input	;		
			self.source_md						:=	source_md	;		
			self.source_ne						:=	source_ne	;		
			self.source_paw						:=	source_paw	;		
			self.source_pde						:=	source_pde	;		
			self.source_pf						:=	source_pf	;		
			self.source_pffla					:=	source_pffla	;		
			self.source_pfla					:=	source_pfla	;		
			self.source_ppca					:=	source_ppca	;		
			self.source_ppdid					:=	source_ppdid	;		
			self.source_ppfa					:=	source_ppfa	;		
			self.source_ppfla					:=	source_ppfla	;		
			self.source_ppla					:=	source_ppla	;		
			self.source_pplfa					:=	source_pplfa	;		
			self.source_ppth					:=	source_ppth	;		
			self.source_rel						:=	source_rel	;		
			self.source_rm						:=	source_rm	;		
			self.source_sp						:=	source_sp	;		
			self.source_sx						:=	source_sx	;		
			self.source_utildid				:=	source_utildid	;		
			self.source_cr_lseen			:=	source_cr_lseen	;		
			self.source_cr_fseen			:=	source_cr_fseen	;		
			self.source_edaca_lseen		:=	source_edaca_lseen	;		
			self.source_edadid_fseen	:=	source_edadid_fseen	;		
			self.source_edahistory_fseen	:=	source_edahistory_fseen	;		
			self.source_edahistory_lseen	:=	source_edahistory_lseen	;		
			self.source_edala_fseen		:=	source_edala_fseen	;		
			self.source_exp_lseen			:=	source_exp_lseen	;		
			self.source_exp_fseen			:=	source_exp_fseen	;		
			self.source_inf_lseen			:=	source_inf_lseen	;		
			self.source_inf_fseen			:=	source_inf_fseen	;		
			self.source_input_fseen		:=	source_input_fseen	;		
			self.source_md_fseen			:=	source_md_fseen	;		
			self.source_paw_lseen			:=	source_paw_lseen	;		
			self.source_pf_fseen			:=	source_pf_fseen	;		
			self.source_ppca_lseen		:=	source_ppca_lseen	;		
			self.source_ppca_fseen		:=	source_ppca_fseen	;		
			self.source_ppdid_lseen		:=	source_ppdid_lseen	;		
			self.source_ppdid_fseen		:=	source_ppdid_fseen	;		
			self.source_ppfa_lseen		:=	source_ppfa_lseen	;		
			self.source_ppfa_fseen		:=	source_ppfa_fseen	;		
			self.source_ppfla_lseen		:=	source_ppfla_lseen	;		
			self.source_ppfla_fseen		:=	source_ppfla_fseen	;		
			self.source_ppla_lseen		:=	source_ppla_lseen	;		
			self.source_ppla_fseen		:=	source_ppla_fseen	;		
			self.source_ppth_lseen		:=	source_ppth_lseen	;		
			self.source_ppth_fseen		:=	source_ppth_fseen	;		
			self.source_rel_fseen			:=	source_rel_fseen	;		
			self.source_sp_lseen			:=	source_sp_lseen	;		
			self.source_sp_fseen			:=	source_sp_fseen	;		
			self.source_sx_fseen			:=	source_sx_fseen	;		
			self.source_utildid_fseen	:=	source_utildid_fseen	;		
			self.source_eda_any_clean	:=	source_eda_any_clean	;		
			self.source_pp_any_clean	:=	source_pp_any_clean	;		
			self.number_of_sources		:=	number_of_sources	;		
			self.source_cr_lseen2			:=	source_cr_lseen2	;		
			self.yr_source_cr_lseen		:=	yr_source_cr_lseen	;		
			self.source_cr_fseen2			:=	source_cr_fseen2	;		
			self.yr_source_cr_fseen		:=	yr_source_cr_fseen	;		
			self.source_edaca_lseen2	:=	source_edaca_lseen2	;		
			self.yr_source_edaca_lseen	:=	yr_source_edaca_lseen	;		
			self.source_edadid_fseen2	:=	source_edadid_fseen2	;		
			self.yr_source_edadid_fseen	:=	yr_source_edadid_fseen	;		
			self.source_edahistory_lseen2	:=	source_edahistory_lseen2	;		
			self.yr_source_edahistory_lseen	:=	yr_source_edahistory_lseen	;		
			self.source_edahistory_fseen2	:=	source_edahistory_fseen2	;		
			self.yr_source_edahistory_fseen	:=	yr_source_edahistory_fseen	;		
			self.source_edala_fseen2	:=	source_edala_fseen2	;		
			self.yr_source_edala_fseen	:=	yr_source_edala_fseen	;		
			self.source_exp_lseen2	:=	source_exp_lseen2	;		
			self.yr_source_exp_lseen	:=	yr_source_exp_lseen	;		
			self.source_exp_fseen2	:=	source_exp_fseen2	;		
			self.yr_source_exp_fseen	:=	yr_source_exp_fseen	;		
			self.source_inf_lseen2	:=	source_inf_lseen2	;		
			self.yr_source_inf_lseen	:=	yr_source_inf_lseen	;		
			self.source_inf_fseen2	:=	source_inf_fseen2	;		
			self.yr_source_inf_fseen	:=	yr_source_inf_fseen	;		
			self.source_md_fseen2	:=	source_md_fseen2	;		
			self.yr_source_md_fseen	:=	yr_source_md_fseen	;		
			self.source_paw_lseen2	:=	source_paw_lseen2	;		
			self.yr_source_paw_lseen	:=	yr_source_paw_lseen	;		
			self.source_pf_fseen2	:=	source_pf_fseen2	;		
			self.yr_source_pf_fseen	:=	yr_source_pf_fseen	;		
			self.source_ppca_lseen2	:=	source_ppca_lseen2	;		
			self.yr_source_ppca_lseen	:=	yr_source_ppca_lseen	;		
			self.source_ppca_fseen2	:=	source_ppca_fseen2	;		
			self.yr_source_ppca_fseen	:=	yr_source_ppca_fseen	;		
			self.source_ppdid_lseen2	:=	source_ppdid_lseen2	;		
			self.yr_source_ppdid_lseen	:=	yr_source_ppdid_lseen	;		
			self.source_ppdid_fseen2	:=	source_ppdid_fseen2	;		
			self.yr_source_ppdid_fseen	:=	yr_source_ppdid_fseen	;		
			self.source_ppfa_lseen2	:=	source_ppfa_lseen2	;		
			self.yr_source_ppfa_lseen	:=	yr_source_ppfa_lseen	;		
			self.source_ppfa_fseen2	:=	source_ppfa_fseen2	;		
			self.yr_source_ppfa_fseen	:=	yr_source_ppfa_fseen	;		
			self.source_ppfla_lseen2	:=	source_ppfla_lseen2	;		
			self.yr_source_ppfla_lseen	:=	yr_source_ppfla_lseen	;		
			self.source_ppfla_fseen2	:=	source_ppfla_fseen2	;		
			self.yr_source_ppfla_fseen	:=	yr_source_ppfla_fseen	;		
			self.source_ppla_lseen2	:=	source_ppla_lseen2	;		
			self.yr_source_ppla_lseen	:=	yr_source_ppla_lseen	;		
			self.source_ppla_fseen2	:=	source_ppla_fseen2	;		
			self.yr_source_ppla_fseen	:=	yr_source_ppla_fseen	;		
			self.source_ppth_lseen2	:=	source_ppth_lseen2	;		
			self.yr_source_ppth_lseen	:=	yr_source_ppth_lseen	;		
			self.source_ppth_fseen2	:=	source_ppth_fseen2	;		
			self.yr_source_ppth_fseen	:=	yr_source_ppth_fseen	;		
			self.source_rel_fseen2	:=	source_rel_fseen2	;		
			self.yr_source_rel_fseen	:=	yr_source_rel_fseen	;		
			self.source_sp_lseen2	:=	source_sp_lseen2	;		
			self.yr_source_sp_lseen	:=	yr_source_sp_lseen	;		
			self.source_sp_fseen2	:=	source_sp_fseen2	;		
			self.yr_source_sp_fseen	:=	yr_source_sp_fseen	;		
			self.source_sx_fseen2	:=	source_sx_fseen2	;		
			self.yr_source_sx_fseen	:=	yr_source_sx_fseen	;		
			self.source_utildid_fseen2	:=	source_utildid_fseen2	;		
			self.yr_source_utildid_fseen	:=	yr_source_utildid_fseen	;		
			self.eda_dt_first_seen2	:=	eda_dt_first_seen2	;		
			self.yr_eda_dt_first_seen	:=	yr_eda_dt_first_seen	;		
			self.eda_dt_last_seen2	:=	eda_dt_last_seen2	;		
			self.yr_eda_dt_last_seen	:=	yr_eda_dt_last_seen	;		
			self.eda_deletion_date2	:=	eda_deletion_date2	;		
			self.yr_eda_deletion_date	:=	yr_eda_deletion_date	;		
			self.exp_last_update2	:=	exp_last_update2	;		
			self.yr_exp_last_update	:=	yr_exp_last_update	;		
			self.internal_ver_first_seen2	:=	internal_ver_first_seen2	;		
			self.yr_internal_ver_first_seen	:=	yr_internal_ver_first_seen	;		
			self.pp_datefirstseen2	:=	pp_datefirstseen2	;		
			self.yr_pp_datefirstseen	:=	yr_pp_datefirstseen	;		
			self.pp_datelastseen2	:=	pp_datelastseen2	;		
			self.yr_pp_datelastseen	:=	yr_pp_datelastseen	;		
			self.pp_datevendorfirstseen2	:=	pp_datevendorfirstseen2	;		
			self.yr_pp_datevendorfirstseen	:=	yr_pp_datevendorfirstseen	;		
			self.pp_datevendorlastseen2	:=	pp_datevendorlastseen2	;		
			self.yr_pp_datevendorlastseen	:=	yr_pp_datevendorlastseen	;		
			self.pp_date_nonglb_lastseen2	:=	pp_date_nonglb_lastseen2	;		
			self.yr_pp_date_nonglb_lastseen	:=	yr_pp_date_nonglb_lastseen	;		
			self.pp_orig_lastseen2	:=	pp_orig_lastseen2	;		
			self.yr_pp_orig_lastseen	:=	yr_pp_orig_lastseen	;		
			self.pp_app_npa_effective_dt2	:=	pp_app_npa_effective_dt2	;		
			self.yr_pp_app_npa_effective_dt	:=	yr_pp_app_npa_effective_dt	;		
			self.pp_app_npa_last_change_dt2	:=	pp_app_npa_last_change_dt2	;		
			self.yr_pp_app_npa_last_change_dt	:=	yr_pp_app_npa_last_change_dt	;		
			self.pp_eda_hist_did_dt2	:=	pp_eda_hist_did_dt2	;		
			self.yr_pp_eda_hist_did_dt	:=	yr_pp_eda_hist_did_dt	;		
			self.pp_eda_hist_nm_addr_dt2	:=	pp_eda_hist_nm_addr_dt2	;		
			self.yr_pp_eda_hist_nm_addr_dt	:=	yr_pp_eda_hist_nm_addr_dt	;		
			self.pp_app_fb_ph_dt2	:=	pp_app_fb_ph_dt2	;		
			self.yr_pp_app_fb_ph_dt	:=	yr_pp_app_fb_ph_dt	;		
			self.pp_app_fb_ph7_did_dt2	:=	pp_app_fb_ph7_did_dt2	;		
			self.yr_pp_app_fb_ph7_did_dt	:=	yr_pp_app_fb_ph7_did_dt	;		
			self.pp_app_fb_ph7_nm_addr_dt2	:=	pp_app_fb_ph7_nm_addr_dt2	;		
			self.yr_pp_app_fb_ph7_nm_addr_dt	:=	yr_pp_app_fb_ph7_nm_addr_dt	;		
			self.pp_first_build_date2	:=	pp_first_build_date2	;		
			self.yr_pp_first_build_date	:=	yr_pp_first_build_date	;		
			self.mth_source_cr_lseen	:=	mth_source_cr_lseen	;		
			self.mth_source_cr_fseen	:=	mth_source_cr_fseen	;		
			self.mth_source_edaca_lseen	:=	mth_source_edaca_lseen	;		
			self.mth_source_edadid_fseen	:=	mth_source_edadid_fseen	;		
			self.mth_source_edahistory_lseen	:=	mth_source_edahistory_lseen	;		
			self.mth_source_edahistory_fseen	:=	mth_source_edahistory_fseen	;		
			self.mth_source_edala_fseen	:=	mth_source_edala_fseen	;		
			self.mth_source_exp_lseen	:=	mth_source_exp_lseen	;		
			self.mth_source_exp_fseen	:=	mth_source_exp_fseen	;		
			self.mth_source_inf_lseen	:=	mth_source_inf_lseen	;		
			self.mth_source_inf_fseen	:=	mth_source_inf_fseen	;		
			self.mth_source_md_fseen	:=	mth_source_md_fseen	;		
			self.mth_source_paw_lseen	:=	mth_source_paw_lseen	;		
			self.mth_source_pf_fseen	:=	mth_source_pf_fseen	;		
			self.mth_source_ppca_lseen	:=	mth_source_ppca_lseen	;		
			self.mth_source_ppca_fseen	:=	mth_source_ppca_fseen	;		
			self.mth_source_ppdid_lseen	:=	mth_source_ppdid_lseen	;		
			self.mth_source_ppdid_fseen	:=	mth_source_ppdid_fseen	;		
			self.mth_source_ppfa_lseen	:=	mth_source_ppfa_lseen	;		
			self.mth_source_ppfa_fseen	:=	mth_source_ppfa_fseen	;		
			self.mth_source_ppfla_lseen	:=	mth_source_ppfla_lseen	;		
			self.mth_source_ppfla_fseen	:=	mth_source_ppfla_fseen	;		
			self.mth_source_ppla_lseen	:=	mth_source_ppla_lseen	;		
			self.mth_source_ppla_fseen	:=	mth_source_ppla_fseen	;		
			self.mth_source_ppth_lseen	:=	mth_source_ppth_lseen	;		
			self.mth_source_ppth_fseen	:=	mth_source_ppth_fseen	;		
			self.mth_source_rel_fseen	:=	mth_source_rel_fseen	;		
			self.mth_source_sp_lseen	:=	mth_source_sp_lseen	;		
			self.mth_source_sp_fseen	:=	mth_source_sp_fseen	;		
			self.mth_source_sx_fseen	:=	mth_source_sx_fseen	;		
			self.mth_source_utildid_fseen	:=	mth_source_utildid_fseen	;		
			self.mth_eda_dt_first_seen	:=	mth_eda_dt_first_seen	;		
			self.mth_eda_dt_last_seen	:=	mth_eda_dt_last_seen	;		
			self.mth_eda_deletion_date	:=	mth_eda_deletion_date	;		
			self.mth_exp_last_update	:=	mth_exp_last_update	;		
			self.mth_internal_ver_first_seen	:=	mth_internal_ver_first_seen	;		
			self.mth_pp_datefirstseen	:=	mth_pp_datefirstseen	;		
			self.mth_pp_datelastseen	:=	mth_pp_datelastseen	;		
			self.mth_pp_datevendorfirstseen	:=	mth_pp_datevendorfirstseen	;		
			self.mth_pp_datevendorlastseen	:=	mth_pp_datevendorlastseen	;		
			self.mth_pp_date_nonglb_lastseen	:=	mth_pp_date_nonglb_lastseen	;		
			self.mth_pp_orig_lastseen	:=	mth_pp_orig_lastseen	;		
			self.mth_pp_app_npa_effective_dt	:=	mth_pp_app_npa_effective_dt	;		
			self.mth_pp_app_npa_last_change_dt	:=	mth_pp_app_npa_last_change_dt	;		
			self.mth_pp_eda_hist_did_dt	:=	mth_pp_eda_hist_did_dt	;		
			self.mth_pp_eda_hist_nm_addr_dt 	:=	mth_pp_eda_hist_nm_addr_dt 	;		
			self.mth_pp_app_fb_ph_dt	:=	mth_pp_app_fb_ph_dt	;		
			self.mth_pp_app_fb_ph7_did_dt	:=	mth_pp_app_fb_ph7_did_dt	;		
			self.mth_pp_app_fb_ph7_nm_addr_dt	:=	mth_pp_app_fb_ph7_nm_addr_dt	;		
			self.mth_pp_first_build_date	:=	mth_pp_first_build_date	;		
			self._phone_match_code_a	:=	_phone_match_code_a	;		
			self._phone_match_code_c	:=	_phone_match_code_c	;		
			self._phone_match_code_l	:=	_phone_match_code_l	;		
			self._phone_match_code_n	:=	_phone_match_code_n	;		
			self._phone_match_code_s	:=	_phone_match_code_s	;		
			self._phone_match_code_t	:=	_phone_match_code_t	;		
			self._phone_match_code_z	:=	_phone_match_code_z	;		
			self._pp_rule_seen_once	:=	_pp_rule_seen_once	;		
			self._pp_rule_high_vend_conf	:=	_pp_rule_high_vend_conf	;		
			self._pp_rule_low_vend_conf	:=	_pp_rule_low_vend_conf	;		
			self._pp_rule_cellphone_latest	:=	_pp_rule_cellphone_latest	;		
			self._pp_rule_source_latest	:=	_pp_rule_source_latest	;		
			self._pp_rule_med_vend_conf_cell	:=	_pp_rule_med_vend_conf_cell	;		
			self._pp_rule_iq_rpc	:=	_pp_rule_iq_rpc	;		
			self._pp_rule_ins_ver_above	:=	_pp_rule_ins_ver_above	;		
			self._pp_rule_f1_ver_above	:=	_pp_rule_f1_ver_above	;		
			self._pp_rule_f1_ver_below	:=	_pp_rule_f1_ver_below	;		
			self._pp_rule_30	:=	_pp_rule_30	;		
			self._pp_did_flag	:=	_pp_did_flag	;		
			self._pp_src_all_eq	:=	_pp_src_all_eq	;		
			self._pp_src_all_ut	:=	_pp_src_all_ut	;		
			self._pp_src_all_uw	:=	_pp_src_all_uw	;		
			self._pp_src_all_iq	:=	_pp_src_all_iq	;		
			self._pp_app_nonpub_gong_la	:=	_pp_app_nonpub_gong_la	;		
			self._pp_app_nonpub_gong_lap	:=	_pp_app_nonpub_gong_lap	;		
			self._pp_app_nonpub_targ_la	:=	_pp_app_nonpub_targ_la	;		
			self._pp_app_nonpub_targ_lap	:=	_pp_app_nonpub_targ_lap	;		
			self._pp_hhid_flag	:=	_pp_hhid_flag	;		
			self._eda_hhid_flag	:=	_eda_hhid_flag	;		
			self.inq_firstseen_n	:=	inq_firstseen_n	;		
			self.inq_lastseen_n	:=	inq_lastseen_n	;		
			self.inq_adl_firstseen_n	:=	inq_adl_firstseen_n	;		
			self.inq_adl_lastseen_n	:=	inq_adl_lastseen_n	;		
			self._internal_ver_match_lexid	:=	_internal_ver_match_lexid	;		
			self._internal_ver_match_spouse	:=	_internal_ver_match_spouse	;		
			self._internal_ver_match_hhid	:=	_internal_ver_match_hhid	;		
			self._internal_ver_match_level	:=	_internal_ver_match_level	;		
			self._inq_adl_ph_industry_auto	:=	_inq_adl_ph_industry_auto	;		
			self._inq_adl_ph_industry_day	:=	_inq_adl_ph_industry_day	;		
			self._inq_adl_ph_industry_flag	:=	_inq_adl_ph_industry_flag	;		
			self._pp_gender	:=	_pp_gender	;		
			self._pp_agegroup	:=	_pp_agegroup	;		
			self._pp_app_fb_ph	:=	_pp_app_fb_ph	;		
			self._pp_app_fb_ph7_did	:=	_pp_app_fb_ph7_did	;		
			self._phone_disconnected	:=	_phone_disconnected	;		
			self._phone_zip_match	:=	_phone_zip_match	;		
			self._phone_timezone_match	:=	_phone_timezone_match	;		
			self._phone_fb_result	:=	_phone_fb_result	;		
			self._phone_fb_rp_result	:=	_phone_fb_rp_result	;		
			self._phone_match_code_lns	:=	_phone_match_code_lns	;		
			self._phone_match_code_tcza	:=	_phone_match_code_tcza	;		
			self.pk_phone_match_level	:=	pk_phone_match_level	;		
			self._pp_app_coctype_landline	:=	_pp_app_coctype_landline	;		
			self._pp_app_coctype_cell	:=	_pp_app_coctype_cell	;		
			self._phone_switch_type_cell	:=	_phone_switch_type_cell	;		
			self._pp_app_nxx_type_cell	:=	_pp_app_nxx_type_cell	;		
			self._pp_app_ph_type_cell	:=	_pp_app_ph_type_cell	;		
			self._pp_app_company_type_cell	:=	_pp_app_company_type_cell	;		
			self._exp_type_cell	:=	_exp_type_cell	;		
			self.pk_cell_indicator	:=	pk_cell_indicator	;		
			self.pk_cell_flag	:=	pk_cell_flag	;		
			self._pp_glb_dppa_fl_glb	:=	_pp_glb_dppa_fl_glb	;		
			self._pp_origlistingtype_res	:=	_pp_origlistingtype_res	;		
			self.pk_exp_hit	:=	pk_exp_hit	;		
			self.pk_pp_hit	:=	pk_pp_hit	;		
			self.segment	:=	segment	;		
			self.add_curr_occupants_1yr_out	:=	add_curr_occupants_1yr_out	;		
			self.r_nas_addr_verd_d	:=	r_nas_addr_verd_d	;		
			self.r_pb_order_freq_d	:=	r_pb_order_freq_d	;		
			self.f_bus_name_nover_i	:=	f_bus_name_nover_i	;		
			self.f_adl_util_conv_n	:=	f_adl_util_conv_n	;		
			self.f_adl_util_misc_n	:=	f_adl_util_misc_n	;		
			self.f_util_adl_count_n	:=	f_util_adl_count_n	;		
			self.f_util_add_input_inf_n	:=	f_util_add_input_inf_n	;		
			self.f_util_add_input_conv_n	:=	f_util_add_input_conv_n	;		
			self.f_util_add_curr_inf_n	:=	f_util_add_curr_inf_n	;		
			self.f_util_add_curr_misc_n	:=	f_util_add_curr_misc_n	;		
			self.f_add_input_mobility_index_n	:=	f_add_input_mobility_index_n	;		
			self.f_add_curr_mobility_index_n	:=	f_add_curr_mobility_index_n	;		
			self.f_inq_count_i	:=	f_inq_count_i	;		
			self.f_inq_count24_i	:=	f_inq_count24_i	;		
			self.f_inq_per_ssn_i	:=	f_inq_per_ssn_i	;		
			self.f_inq_lnames_per_ssn_i	:=	f_inq_lnames_per_ssn_i	;		
			self.f_inq_addrs_per_ssn_i	:=	f_inq_addrs_per_ssn_i	;		
			self.f_inq_dobs_per_ssn_i	:=	f_inq_dobs_per_ssn_i	;		
			self.f_inq_per_addr_i	:=	f_inq_per_addr_i	;		
			self.f_inq_adls_per_addr_i	:=	f_inq_adls_per_addr_i	;		
			self.f_inq_lnames_per_addr_i	:=	f_inq_lnames_per_addr_i	;		
			self.f_inq_ssns_per_addr_i	:=	f_inq_ssns_per_addr_i	;		
			self._inq_banko_am_first_seen	:=	_inq_banko_am_first_seen	;		
			self.f_mos_inq_banko_am_fseen_d	:=	f_mos_inq_banko_am_fseen_d	;		
			self._inq_banko_am_last_seen	:=	_inq_banko_am_last_seen	;		
			self.f_mos_inq_banko_am_lseen_d	:=	f_mos_inq_banko_am_lseen_d	;		
			self._inq_banko_cm_first_seen	:=	_inq_banko_cm_first_seen	;		
			self.f_mos_inq_banko_cm_fseen_d	:=	f_mos_inq_banko_cm_fseen_d	;		
			self._inq_banko_cm_last_seen	:=	_inq_banko_cm_last_seen	;		
			self.f_mos_inq_banko_cm_lseen_d	:=	f_mos_inq_banko_cm_lseen_d	;		
			self._inq_banko_om_first_seen	:=	_inq_banko_om_first_seen	;		
			self.f_mos_inq_banko_om_fseen_d	:=	f_mos_inq_banko_om_fseen_d	;		
			self._inq_banko_om_last_seen	:=	_inq_banko_om_last_seen	;		
			self.f_mos_inq_banko_om_lseen_d	:=	f_mos_inq_banko_om_lseen_d	;		
			self.f_attr_arrest_recency_d	:=	f_attr_arrest_recency_d	;		
			self._foreclosure_last_date	:=	_foreclosure_last_date	;		
			self.f_mos_foreclosure_lseen_d	:=	f_mos_foreclosure_lseen_d	;		
			self.f_estimated_income_d	:=	f_estimated_income_d	;		
			self.f_wealth_index_d	:=	f_wealth_index_d	;		
			self.f_college_income_d	:=	f_college_income_d	;		
			self.f_rel_count_i	:=	f_rel_count_i	;		
			self.f_rel_incomeover25_count_d	:=	f_rel_incomeover25_count_d	;		
			self.f_rel_incomeover50_count_d	:=	f_rel_incomeover50_count_d	;		
			self.f_rel_incomeover75_count_d	:=	f_rel_incomeover75_count_d	;		
			self.f_rel_incomeover100_count_d	:=	f_rel_incomeover100_count_d	;		
			self.f_rel_homeover50_count_d	:=	f_rel_homeover50_count_d	;		
			self.f_rel_homeover100_count_d	:=	f_rel_homeover100_count_d	;		
			self.f_rel_homeover200_count_d	:=	f_rel_homeover200_count_d	;		
			self.f_rel_homeover300_count_d	:=	f_rel_homeover300_count_d	;		
			self.f_rel_homeover500_count_d	:=	f_rel_homeover500_count_d	;		
			self.f_rel_ageover20_count_d	:=	f_rel_ageover20_count_d	;		
			self.f_rel_ageover30_count_d	:=	f_rel_ageover30_count_d	;		
			self.f_rel_ageover40_count_d	:=	f_rel_ageover40_count_d	;		
			self.f_rel_ageover50_count_d	:=	f_rel_ageover50_count_d	;		
			self.f_rel_educationover8_count_d	:=	f_rel_educationover8_count_d	;		
			self.f_rel_educationover12_count_d	:=	f_rel_educationover12_count_d	;		
			self.f_crim_rel_under25miles_cnt_i	:=	f_crim_rel_under25miles_cnt_i	;		
			self.f_crim_rel_under100miles_cnt_i	:=	f_crim_rel_under100miles_cnt_i	;		
			self.f_crim_rel_under500miles_cnt_i	:=	f_crim_rel_under500miles_cnt_i	;		
			self.f_rel_under25miles_cnt_d	:=	f_rel_under25miles_cnt_d	;		
			self.f_rel_under100miles_cnt_d	:=	f_rel_under100miles_cnt_d	;		
			self.f_rel_under500miles_cnt_d	:=	f_rel_under500miles_cnt_d	;		
			self.f_rel_bankrupt_count_i	:=	f_rel_bankrupt_count_i	;		
			self.f_rel_criminal_count_i	:=	f_rel_criminal_count_i	;		
			self.f_rel_felony_count_i	:=	f_rel_felony_count_i	;		
			self.f_accident_count_i	:=	f_accident_count_i	;		
			self.f_acc_damage_amt_total_i	:=	f_acc_damage_amt_total_i	;		
			self._acc_last_seen	:=	_acc_last_seen	;		
			self.f_mos_acc_lseen_d	:=	f_mos_acc_lseen_d	;		
			self.f_acc_damage_amt_last_i	:=	f_acc_damage_amt_last_i	;		
			self.f_idrisktype_i	:=	f_idrisktype_i	;		
			self.f_idverrisktype_i	:=	f_idverrisktype_i	;		
			self.f_sourcerisktype_i	:=	f_sourcerisktype_i	;		
			self.f_varrisktype_i	:=	f_varrisktype_i	;		
			self.f_vardobcount_i	:=	f_vardobcount_i	;		
			self.f_vardobcountnew_i	:=	f_vardobcountnew_i	;		
			self.f_srchvelocityrisktype_i	:=	f_srchvelocityrisktype_i	;		
			self.f_srchunvrfdssncount_i	:=	f_srchunvrfdssncount_i	;		
			self.f_srchunvrfdaddrcount_i	:=	f_srchunvrfdaddrcount_i	;		
			self.f_srchunvrfdphonecount_i	:=	f_srchunvrfdphonecount_i	;		
			self.f_srchfraudsrchcount_i	:=	f_srchfraudsrchcount_i	;		
			self.f_srchfraudsrchcountyr_i	:=	f_srchfraudsrchcountyr_i	;		
			self.f_srchfraudsrchcountmo_i	:=	f_srchfraudsrchcountmo_i	;		
			self.f_assocrisktype_i	:=	f_assocrisktype_i	;		
			self.f_assocsuspicousidcount_i	:=	f_assocsuspicousidcount_i	;		
			self.f_assoccredbureaucount_i	:=	f_assoccredbureaucount_i	;		
			self.f_corrrisktype_i	:=	f_corrrisktype_i	;		
			self.f_corrssnnamecount_d	:=	f_corrssnnamecount_d	;		
			self.f_corrssnaddrcount_d	:=	f_corrssnaddrcount_d	;		
			self.f_corraddrnamecount_d	:=	f_corraddrnamecount_d	;		
			self.f_divrisktype_i	:=	f_divrisktype_i	;		
			self.f_divssnidmsrcurelcount_i	:=	f_divssnidmsrcurelcount_i	;		
			self.f_divaddrsuspidcountnew_i	:=	f_divaddrsuspidcountnew_i	;		
			self.f_divsrchaddrsuspidcount_i	:=	f_divsrchaddrsuspidcount_i	;		
			self.f_srchssnsrchcount_i	:=	f_srchssnsrchcount_i	;		
			self.f_srchssnsrchcountmo_i	:=	f_srchssnsrchcountmo_i	;		
			self.f_srchaddrsrchcount_i	:=	f_srchaddrsrchcount_i	;		
			self.f_srchaddrsrchcountmo_i	:=	f_srchaddrsrchcountmo_i	;		
			self.f_componentcharrisktype_i	:=	f_componentcharrisktype_i	;		
			self.f_addrchangeincomediff_d	:=	f_addrchangeincomediff_d	;		
			self.f_addrchangevaluediff_d	:=	f_addrchangevaluediff_d	;		
			self.f_addrchangecrimediff_i	:=	f_addrchangecrimediff_i	;		
			self.f_addrchangeecontrajindex_d	:=	f_addrchangeecontrajindex_d	;		
			self.f_curraddractivephonelist_d	:=	f_curraddractivephonelist_d	;		
			self.f_curraddrmedianincome_d	:=	f_curraddrmedianincome_d	;		
			self.f_curraddrmedianvalue_d	:=	f_curraddrmedianvalue_d	;		
			self.f_curraddrmurderindex_i	:=	f_curraddrmurderindex_i	;		
			self.f_curraddrcartheftindex_i	:=	f_curraddrcartheftindex_i	;		
			self.f_curraddrburglaryindex_i	:=	f_curraddrburglaryindex_i	;		
			self.f_curraddrcrimeindex_i	:=	f_curraddrcrimeindex_i	;		
			self.f_prevaddrageoldest_d	:=	f_prevaddrageoldest_d	;		
			self.f_prevaddrlenofres_d	:=	f_prevaddrlenofres_d	;		
			self.f_prevaddrdwelltype_sfd_n	:=	f_prevaddrdwelltype_sfd_n	;		
			self.f_prevaddrstatus_i	:=	f_prevaddrstatus_i	;		
			self.f_prevaddroccupantowned_d	:=	f_prevaddroccupantowned_d	;		
			self.f_prevaddrmedianincome_d	:=	f_prevaddrmedianincome_d	;		
			self.f_prevaddrmedianvalue_d	:=	f_prevaddrmedianvalue_d	;		
			self.f_prevaddrmurderindex_i	:=	f_prevaddrmurderindex_i	;		
			self.f_prevaddrcartheftindex_i	:=	f_prevaddrcartheftindex_i	;		
			self.f_fp_prevaddrburglaryindex_i	:=	f_fp_prevaddrburglaryindex_i	;		
			self.f_fp_prevaddrcrimeindex_i	:=	f_fp_prevaddrcrimeindex_i	;		
			self.r_has_paw_source_d	:=	r_has_paw_source_d	;		
			self._paw_first_seen	:=	_paw_first_seen	;		
			self.r_mos_since_paw_fseen_d	:=	r_mos_since_paw_fseen_d	;		
			self.r_paw_dead_business_ct_i	:=	r_paw_dead_business_ct_i	;		
			self.r_paw_active_phone_ct_d	:=	r_paw_active_phone_ct_d	;		
			self.final_score          						:= final_score;
			self.final_score_0	:=	final_score_0	;
			self.final_score_1	:=	final_score_1	;
			self.final_score_2	:=	final_score_2	;
			self.final_score_3	:=	final_score_3	;
			self.final_score_4	:=	final_score_4	;
			self.final_score_5	:=	final_score_5	;
			self.final_score_6	:=	final_score_6	;
			self.final_score_7	:=	final_score_7	;
			self.final_score_8	:=	final_score_8	;
			self.final_score_9	:=	final_score_9	;
			self.final_score_10	:=	final_score_10	;
			self.final_score_11	:=	final_score_11	;
			self.final_score_12	:=	final_score_12	;
			self.final_score_13	:=	final_score_13	;
			self.final_score_14	:=	final_score_14	;
			self.final_score_15	:=	final_score_15	;
			self.final_score_16	:=	final_score_16	;
			self.final_score_17	:=	final_score_17	;
			self.final_score_18	:=	final_score_18	;
			self.final_score_19	:=	final_score_19	;
			self.final_score_20	:=	final_score_20	;
			self.final_score_21	:=	final_score_21	;
			self.final_score_22	:=	final_score_22	;
			self.final_score_23	:=	final_score_23	;
			self.final_score_24	:=	final_score_24	;
			self.final_score_25	:=	final_score_25	;
			self.final_score_26	:=	final_score_26	;
			self.final_score_27	:=	final_score_27	;
			self.final_score_28	:=	final_score_28	;
			self.final_score_29	:=	final_score_29	;
			self.final_score_30	:=	final_score_30	;
			self.final_score_31	:=	final_score_31	;
			self.final_score_32	:=	final_score_32	;
			self.final_score_33	:=	final_score_33	;
			self.final_score_34	:=	final_score_34	;
			self.final_score_35	:=	final_score_35	;
			self.final_score_36	:=	final_score_36	;
			self.final_score_37	:=	final_score_37	;
			self.final_score_38	:=	final_score_38	;
			self.final_score_39	:=	final_score_39	;
			self.final_score_40	:=	final_score_40	;
			self.final_score_41	:=	final_score_41	;
			self.final_score_42	:=	final_score_42	;
			self.final_score_43	:=	final_score_43	;
			self.final_score_44	:=	final_score_44	;
			self.final_score_45	:=	final_score_45	;
			self.final_score_46	:=	final_score_46	;
			self.final_score_47	:=	final_score_47	;
			self.final_score_48	:=	final_score_48	;
			self.final_score_49	:=	final_score_49	;
			self.final_score_50	:=	final_score_50	;
			self.final_score_51	:=	final_score_51	;
			self.final_score_52	:=	final_score_52	;
			self.final_score_53	:=	final_score_53	;
			self.final_score_54	:=	final_score_54	;
			self.final_score_55	:=	final_score_55	;
			self.final_score_56	:=	final_score_56	;
			self.final_score_57	:=	final_score_57	;
			self.final_score_58	:=	final_score_58	;
			self.final_score_59	:=	final_score_59	;
			self.final_score_60	:=	final_score_60	;
			self.final_score_61	:=	final_score_61	;
			self.final_score_62	:=	final_score_62	;
			self.final_score_63	:=	final_score_63	;
			self.final_score_64	:=	final_score_64	;
			self.final_score_65	:=	final_score_65	;
			self.final_score_66	:=	final_score_66	;
			self.final_score_67	:=	final_score_67	;
			self.final_score_68	:=	final_score_68	;
			self.final_score_69	:=	final_score_69	;
			self.final_score_70	:=	final_score_70	;
			self.final_score_71	:=	final_score_71	;
			self.final_score_72	:=	final_score_72	;
			self.final_score_73	:=	final_score_73	;
			self.final_score_74	:=	final_score_74	;
			self.final_score_75	:=	final_score_75	;
			self.final_score_76	:=	final_score_76	;
			self.final_score_77	:=	final_score_77	;
			self.final_score_78	:=	final_score_78	;
			self.final_score_79	:=	final_score_79	;
			self.final_score_80	:=	final_score_80	;
			self.final_score_81	:=	final_score_81	;
			self.final_score_82	:=	final_score_82	;
			self.final_score_83	:=	final_score_83	;
			self.final_score_84	:=	final_score_84	;
			self.final_score_85	:=	final_score_85	;
			self.final_score_86	:=	final_score_86	;
			self.final_score_87	:=	final_score_87	;
			self.final_score_88	:=	final_score_88	;
			self.final_score_89	:=	final_score_89	;
			self.final_score_90	:=	final_score_90	;
			self.final_score_91	:=	final_score_91	;
			self.final_score_92	:=	final_score_92	;
			self.final_score_93	:=	final_score_93	;
			self.final_score_94	:=	final_score_94	;
			self.final_score_95	:=	final_score_95	;
			self.final_score_96	:=	final_score_96	;
			self.final_score_97	:=	final_score_97	;
			self.final_score_98	:=	final_score_98	;
			self.final_score_99	:=	final_score_99	;
			self.final_score_100	:=	final_score_100	;
			self.final_score_101	:=	final_score_101	;
			self.final_score_102	:=	final_score_102	;
			self.final_score_103	:=	final_score_103	;
			self.final_score_104	:=	final_score_104	;
			self.final_score_105	:=	final_score_105	;
			self.final_score_106	:=	final_score_106	;
			self.final_score_107	:=	final_score_107	;
			self.final_score_108	:=	final_score_108	;
			self.final_score_109	:=	final_score_109	;
			self.final_score_110	:=	final_score_110	;
			self.final_score_111	:=	final_score_111	;
			self.final_score_112	:=	final_score_112	;
			self.final_score_113	:=	final_score_113	;
			self.final_score_114	:=	final_score_114	;
			self.final_score_115	:=	final_score_115	;
			self.final_score_116	:=	final_score_116	;
			self.final_score_117	:=	final_score_117	;
			self.final_score_118	:=	final_score_118	;
			self.final_score_119	:=	final_score_119	;
			self.final_score_120	:=	final_score_120	;
			self.final_score_121	:=	final_score_121	;
			self.final_score_122	:=	final_score_122	;
			self.final_score_123	:=	final_score_123	;
			self.final_score_124	:=	final_score_124	;
			self.final_score_125	:=	final_score_125	;
			self.final_score_126	:=	final_score_126	;
			self.final_score_127	:=	final_score_127	;
			self.final_score_128	:=	final_score_128	;
			self.final_score_129	:=	final_score_129	;
			self.final_score_130	:=	final_score_130	;
			self.final_score_131	:=	final_score_131	;
			self.final_score_132	:=	final_score_132	;
			self.final_score_133	:=	final_score_133	;
			self.final_score_134	:=	final_score_134	;
			self.final_score_135	:=	final_score_135	;
			self.final_score_136	:=	final_score_136	;
			self.final_score_137	:=	final_score_137	;
			self.final_score_138	:=	final_score_138	;
			self.final_score_139	:=	final_score_139	;
			self.final_score_140	:=	final_score_140	;
			self.final_score_141	:=	final_score_141	;
			self.final_score_142	:=	final_score_142	;
			self.final_score_143	:=	final_score_143	;
			self.final_score_144	:=	final_score_144	;
			self.final_score_145	:=	final_score_145	;
			self.final_score_146	:=	final_score_146	;
			self.final_score_147	:=	final_score_147	;
			self.final_score_148	:=	final_score_148	;
			self.final_score_149	:=	final_score_149	;
			self.final_score_150	:=	final_score_150	;
			self.final_score_151	:=	final_score_151	;
			self.final_score_152	:=	final_score_152	;
			self.final_score_153	:=	final_score_153	;
			self.final_score_154	:=	final_score_154	;
			self.final_score_155	:=	final_score_155	;
			self.final_score_156	:=	final_score_156	;
			self.final_score_157	:=	final_score_157	;
			self.final_score_158	:=	final_score_158	;
			self.final_score_159	:=	final_score_159	;
			self.final_score_160	:=	final_score_160	;
			self.final_score_161	:=	final_score_161	;
			self.final_score_162	:=	final_score_162	;
			self.final_score_163	:=	final_score_163	;
			self.final_score_164	:=	final_score_164	;
			self.final_score_165	:=	final_score_165	;
			self.final_score_166	:=	final_score_166	;
			self.final_score_167	:=	final_score_167	;
			self.final_score_168	:=	final_score_168	;
			self.final_score_169	:=	final_score_169	;
			self.final_score_170	:=	final_score_170	;
			self.final_score_171	:=	final_score_171	;
			self.final_score_172	:=	final_score_172	;
			self.final_score_173	:=	final_score_173	;
			self.final_score_174	:=	final_score_174	;
			self.final_score_175	:=	final_score_175	;
			self.final_score_176	:=	final_score_176	;
			self.final_score_177	:=	final_score_177	;
			self.final_score_178	:=	final_score_178	;
			self.final_score_179	:=	final_score_179	;
			self.final_score_180	:=	final_score_180	;
			self.final_score_181	:=	final_score_181	;
			self.final_score_182	:=	final_score_182	;
			self.final_score_183	:=	final_score_183	;
			self.final_score_184	:=	final_score_184	;
			self.final_score_185	:=	final_score_185	;
			self.final_score_186	:=	final_score_186	;
			self.final_score_187	:=	final_score_187	;
			self.final_score_188	:=	final_score_188	;
			self.final_score_189	:=	final_score_189	;
			self.final_score_190	:=	final_score_190	;
			self.final_score_191	:=	final_score_191	;
			self.final_score_192	:=	final_score_192	;
			self.final_score_193	:=	final_score_193	;
			self.final_score_194	:=	final_score_194	;
			self.final_score_195	:=	final_score_195	;
			self.final_score_196	:=	final_score_196	;
			self.final_score_197	:=	final_score_197	;
			self.final_score_198	:=	final_score_198	;
			self.final_score_199	:=	final_score_199	;
			self.final_score_200	:=	final_score_200	;
			self.final_score_201	:=	final_score_201	;
			self.final_score_202	:=	final_score_202	;
			self.final_score_203	:=	final_score_203	;
			self.final_score_204	:=	final_score_204	;
			self.final_score_205	:=	final_score_205	;
			self.final_score_206	:=	final_score_206	;
			self.final_score_207	:=	final_score_207	;
			self.final_score_208	:=	final_score_208	;
			self.final_score_209	:=	final_score_209	;
			self.final_score_210	:=	final_score_210	;
			self.final_score_211	:=	final_score_211	;
			self.final_score_212	:=	final_score_212	;
			self.final_score_213	:=	final_score_213	;
			self.final_score_214	:=	final_score_214	;
			self.final_score_215	:=	final_score_215	;
			self.final_score_216	:=	final_score_216	;
			self.final_score_217	:=	final_score_217	;
			self.final_score_218	:=	final_score_218	;
			self.final_score_219	:=	final_score_219	;
			self.final_score_220	:=	final_score_220	;
			self.final_score_221	:=	final_score_221	;
			self.final_score_222	:=	final_score_222	;
			self.final_score_223	:=	final_score_223	;
			self.final_score_224	:=	final_score_224	;
			self.final_score_225	:=	final_score_225	;
			self.final_score_226	:=	final_score_226	;
			self.final_score_227	:=	final_score_227	;
			self.final_score_228	:=	final_score_228	;
			self.final_score_229	:=	final_score_229	;
			self.final_score_230	:=	final_score_230	;
			self.final_score_231	:=	final_score_231	;
			self.final_score_232	:=	final_score_232	;
			self.final_score_233	:=	final_score_233	;
			self.final_score_234	:=	final_score_234	;
			self.final_score_235	:=	final_score_235	;
			self.final_score_236	:=	final_score_236	;
			self.final_score_237	:=	final_score_237	;
			self.final_score_238	:=	final_score_238	;
			self.final_score_239	:=	final_score_239	;
			self.final_score_240	:=	final_score_240	;
			self.final_score_241	:=	final_score_241	;
			self.final_score_242	:=	final_score_242	;
			self.final_score_243	:=	final_score_243	;
			self.final_score_244	:=	final_score_244	;
			self.final_score_245	:=	final_score_245	;
			self.final_score_246	:=	final_score_246	;
			self.final_score_247	:=	final_score_247	;
			self.final_score_248	:=	final_score_248	;
			self.final_score_249	:=	final_score_249	;
			self.final_score_250	:=	final_score_250	;
			self.final_score_251	:=	final_score_251	;
			self.final_score_252	:=	final_score_252	;
			self.final_score_253	:=	final_score_253	;
			self.final_score_254	:=	final_score_254	;
			self.final_score_255	:=	final_score_255	;
			self.final_score_256	:=	final_score_256	;
			self.final_score_257	:=	final_score_257	;
			self.final_score_258	:=	final_score_258	;
			self.final_score_259	:=	final_score_259	;
			self.final_score_260	:=	final_score_260	;
			self.final_score_261	:=	final_score_261	;
			self.final_score_262	:=	final_score_262	;
			self.final_score_263	:=	final_score_263	;
			self.final_score_264	:=	final_score_264	;
			self.final_score_265	:=	final_score_265	;
			self.final_score_266	:=	final_score_266	;
			self.final_score_267	:=	final_score_267	;
			self.final_score_268	:=	final_score_268	;
			self.final_score_269	:=	final_score_269	;
			self.final_score_270	:=	final_score_270	;
			self.final_score_271	:=	final_score_271	;
			self.final_score_272	:=	final_score_272	;
			self.final_score_273	:=	final_score_273	;
			self.final_score_274	:=	final_score_274	;
			self.final_score_275	:=	final_score_275	;
			self.final_score_276	:=	final_score_276	;
			self.final_score_277	:=	final_score_277	;
			self.final_score_278	:=	final_score_278	;
			self.final_score_279	:=	final_score_279	;
			self.final_score_280	:=	final_score_280	;
			self.final_score_281	:=	final_score_281	;
			self.final_score_282	:=	final_score_282	;
			self.final_score_283	:=	final_score_283	;
			self.final_score_284	:=	final_score_284	;
			self.final_score_285	:=	final_score_285	;
			self.final_score_286	:=	final_score_286	;
			self.final_score_287	:=	final_score_287	;
			self.final_score_288	:=	final_score_288	;
			self.final_score_289	:=	final_score_289	;
			self.final_score_290	:=	final_score_290	;
			self.final_score_291	:=	final_score_291	;
			self.final_score_292	:=	final_score_292	;
			self.final_score_293	:=	final_score_293	;
			self.final_score_294	:=	final_score_294	;
			self.final_score_295	:=	final_score_295	;
			self.final_score_296	:=	final_score_296	;
			self.final_score_297	:=	final_score_297	;
			self.final_score_298	:=	final_score_298	;
			self.final_score_299	:=	final_score_299	;
			self.final_score_300	:=	final_score_300	;
			self.final_score_301	:=	final_score_301	;
			self.final_score_302	:=	final_score_302	;
			self.final_score_303	:=	final_score_303	;
			self.final_score_304	:=	final_score_304	;
			self.final_score_305	:=	final_score_305	;
			self.final_score_306	:=	final_score_306	;
			self.final_score_307	:=	final_score_307	;
			self.final_score_308	:=	final_score_308	;
			self.final_score_309	:=	final_score_309	;
			self.final_score_310	:=	final_score_310	;
			self.final_score_311	:=	final_score_311	;
			self.final_score_312	:=	final_score_312	;
			self.final_score_313	:=	final_score_313	;
			self.final_score_314	:=	final_score_314	;
			self.final_score_315	:=	final_score_315	;
			self.final_score_316	:=	final_score_316	;
			self.final_score_317	:=	final_score_317	;
			self.final_score_318	:=	final_score_318	;
			self.final_score_319	:=	final_score_319	;
			self.final_score_320	:=	final_score_320	;
			self.final_score_321	:=	final_score_321	;
			self.final_score_322	:=	final_score_322	;
			self.final_score_323	:=	final_score_323	;
			self.final_score_324	:=	final_score_324	;
			self.final_score_325	:=	final_score_325	;
			self.final_score_326	:=	final_score_326	;
			self.final_score_327	:=	final_score_327	;
			self.final_score_328	:=	final_score_328	;
			self.final_score_329	:=	final_score_329	;
			self.final_score_330	:=	final_score_330	;
			self.final_score_331	:=	final_score_331	;
			self.final_score_332	:=	final_score_332	;
			self.final_score_333	:=	final_score_333	;
			self.final_score_334	:=	final_score_334	;
			self.final_score_335	:=	final_score_335	;
			self.final_score_336	:=	final_score_336	;
			self.final_score_337	:=	final_score_337	;
			self.final_score_338	:=	final_score_338	;
			self.final_score_339	:=	final_score_339	;
			self.final_score_340	:=	final_score_340	;
			self.final_score_341	:=	final_score_341	;
			self.final_score_342	:=	final_score_342	;
			self.final_score_343	:=	final_score_343	;
			self.final_score_344	:=	final_score_344	;
			self.final_score_345	:=	final_score_345	;
			self.final_score_346	:=	final_score_346	;
			self.final_score_347	:=	final_score_347	;
			self.final_score_348	:=	final_score_348	;
			self.final_score_349	:=	final_score_349	;
			self.final_score_350	:=	final_score_350	;
			self.final_score_351	:=	final_score_351	;
			self.final_score_352	:=	final_score_352	;
			self.final_score_353	:=	final_score_353	;
			self.final_score_354	:=	final_score_354	;
			self.final_score_355	:=	final_score_355	;
			self.final_score_356	:=	final_score_356	;
			self.final_score_357	:=	final_score_357	;
			self.final_score_358	:=	final_score_358	;
			self.final_score_359	:=	final_score_359	;
			self.final_score_360	:=	final_score_360	;
			self.final_score_361	:=	final_score_361	;
			self.final_score_362	:=	final_score_362	;
			self.final_score_363	:=	final_score_363	;
			self.final_score_364	:=	final_score_364	;
			self.final_score_365	:=	final_score_365	;
			self.final_score_366	:=	final_score_366	;
			self.final_score_367	:=	final_score_367	;
			self.final_score_368	:=	final_score_368	;
			self.final_score_369	:=	final_score_369	;
			self.final_score_370	:=	final_score_370	;
			self.final_score_371	:=	final_score_371	;
			self.final_score_372	:=	final_score_372	;
			self.final_score_373	:=	final_score_373	;
			self.final_score_374	:=	final_score_374	;
			self.final_score_375	:=	final_score_375	;
			self.final_score_376	:=	final_score_376	;
			self.final_score_377	:=	final_score_377	;
			self.final_score_378	:=	final_score_378	;
			self.final_score_379	:=	final_score_379	;
			self.final_score_380	:=	final_score_380	;
			self.final_score_381	:=	final_score_381	;
			self.final_score_382	:=	final_score_382	;
			self.final_score_383	:=	final_score_383	;
			self.final_score_384	:=	final_score_384	;
			self.final_score_385	:=	final_score_385	;
			self.final_score_386	:=	final_score_386	;
			self.final_score_387	:=	final_score_387	;
			self.final_score_388	:=	final_score_388	;
			self.final_score_389	:=	final_score_389	;
			self.final_score_390	:=	final_score_390	;
			self.final_score_391	:=	final_score_391	;
			self.final_score_392	:=	final_score_392	;
			self.final_score_393	:=	final_score_393	;
			self.final_score_394	:=	final_score_394	;
			self.final_score_395	:=	final_score_395	;
			self.final_score_396	:=	final_score_396	;
			self.final_score_397	:=	final_score_397	;
			self.final_score_398	:=	final_score_398	;
			self.final_score_399	:=	final_score_399	;
			self.final_score_400	:=	final_score_400	;
			self.final_score_401	:=	final_score_401	;
			self.final_score_402	:=	final_score_402	;
			self.final_score_403	:=	final_score_403	;
			self.final_score_404	:=	final_score_404	;
			self.final_score_405	:=	final_score_405	;
			self.final_score_406	:=	final_score_406	;
			self.final_score_407	:=	final_score_407	;
			self.final_score_408	:=	final_score_408	;
			self.final_score_409	:=	final_score_409	;
			self.final_score_410	:=	final_score_410	;
			self.final_score_411	:=	final_score_411	;
			self.final_score_412	:=	final_score_412	;
			self.final_score_413	:=	final_score_413	;
			self.final_score_414	:=	final_score_414	;
			self.final_score_415	:=	final_score_415	;
			self.final_score_416	:=	final_score_416	;
			self.final_score_417	:=	final_score_417	;
			self.final_score_418	:=	final_score_418	;
			self.final_score_419	:=	final_score_419	;
			self.final_score_420	:=	final_score_420	;
			self.final_score_421	:=	final_score_421	;
			self.final_score_422	:=	final_score_422	;
			self.final_score_423	:=	final_score_423	;
			self.final_score_424	:=	final_score_424	;
			self.final_score_425	:=	final_score_425	;
			self.final_score_426	:=	final_score_426	;
			self.final_score_427	:=	final_score_427	;
			self.final_score_428	:=	final_score_428	;
			self.final_score_429	:=	final_score_429	;
			self.final_score_430	:=	final_score_430	;
			self.final_score_431	:=	final_score_431	;
			self.final_score_432	:=	final_score_432	;
			self.final_score_433	:=	final_score_433	;
			self.final_score_434	:=	final_score_434	;
			self.final_score_435	:=	final_score_435	;
			self.final_score_436	:=	final_score_436	;
			self.final_score_437	:=	final_score_437	;
			self.final_score_438	:=	final_score_438	;
			self.final_score_439	:=	final_score_439	;
			self.final_score_440	:=	final_score_440	;
			self.final_score_441	:=	final_score_441	;
			self.final_score_442	:=	final_score_442	;
			self.final_score_443	:=	final_score_443	;
			self.final_score_444	:=	final_score_444	;
			self.final_score_445	:=	final_score_445	;
			self.final_score_446	:=	final_score_446	;
			self.final_score_447	:=	final_score_447	;
			self.final_score_448	:=	final_score_448	;
			self.final_score_449	:=	final_score_449	;
			self.final_score_450	:=	final_score_450	;
			self.final_score_451	:=	final_score_451	;
			self.final_score_452	:=	final_score_452	;
			self.final_score_453	:=	final_score_453	;
			self.final_score_454	:=	final_score_454	;
			self.final_score_455	:=	final_score_455	;
			self.final_score_456	:=	final_score_456	;
			self.final_score_457	:=	final_score_457	;
			self.final_score_458	:=	final_score_458	;
			self.final_score_459	:=	final_score_459	;
			self.final_score_460	:=	final_score_460	;
			self.final_score_461	:=	final_score_461	;
			self.final_score_462	:=	final_score_462	;
			self.final_score_463	:=	final_score_463	;
			self.final_score_464	:=	final_score_464	;
			self.final_score_465	:=	final_score_465	;
			self.final_score_466	:=	final_score_466	;
			self.final_score_467	:=	final_score_467	;
			self.final_score_468	:=	final_score_468	;
			self.final_score_469	:=	final_score_469	;
			self.final_score_470	:=	final_score_470	;
			self.final_score_471	:=	final_score_471	;
			self.final_score_472	:=	final_score_472	;
			self.final_score_473	:=	final_score_473	;
			self.final_score_474	:=	final_score_474	;
			self.final_score_475	:=	final_score_475	;
			self.final_score_476	:=	final_score_476	;
			self.final_score_477	:=	final_score_477	;
			self.final_score_478	:=	final_score_478	;
			self.final_score_479	:=	final_score_479	;
			self.final_score_480	:=	final_score_480	;
			self.final_score_481	:=	final_score_481	;
			self.final_score_482	:=	final_score_482	;
			self.final_score_483	:=	final_score_483	;
			self.final_score_484	:=	final_score_484	;
			self.final_score_485	:=	final_score_485	;
			self.final_score_486	:=	final_score_486	;
			self.final_score_487	:=	final_score_487	;
			self.final_score_488	:=	final_score_488	;
			self.final_score_489	:=	final_score_489	;
			self.final_score_490	:=	final_score_490	;
			self.final_score_491	:=	final_score_491	;
			self.final_score_492	:=	final_score_492	;
			self.final_score_493	:=	final_score_493	;
			self.final_score_494	:=	final_score_494	;
			self.final_score_495	:=	final_score_495	;
			self.final_score_496	:=	final_score_496	;
			self.final_score_497	:=	final_score_497	;
			self.final_score_498	:=	final_score_498	;
			self.final_score_499	:=	final_score_499	;
			self.final_score_500	:=	final_score_500	;
			self.final_score_501	:=	final_score_501	;
			self.final_score_502	:=	final_score_502	;
			self.final_score_503	:=	final_score_503	;
			self.final_score_504	:=	final_score_504	;
			self.final_score_505	:=	final_score_505	;
			self.final_score_506	:=	final_score_506	;
			self.final_score_507	:=	final_score_507	;
			self.final_score_508	:=	final_score_508	;
			self.final_score_509	:=	final_score_509	;
			self.final_score_510	:=	final_score_510	;
			self.final_score_511	:=	final_score_511	;
			self.final_score_512	:=	final_score_512	;
			self.final_score_513	:=	final_score_513	;
			self.final_score_514	:=	final_score_514	;
			self.final_score_515	:=	final_score_515	;
			self.final_score_516	:=	final_score_516	;
			self.final_score_517	:=	final_score_517	;
			self.final_score_518	:=	final_score_518	;
			self.final_score_519	:=	final_score_519	;
			self.final_score_520	:=	final_score_520	;
			self.final_score_521	:=	final_score_521	;
			self.final_score_522	:=	final_score_522	;
			self.final_score_523	:=	final_score_523	;
			self.final_score_524	:=	final_score_524	;
			self.final_score_525	:=	final_score_525	;
			self.final_score_526	:=	final_score_526	;
			self.final_score_527	:=	final_score_527	;
			self.final_score_528	:=	final_score_528	;
			self.final_score_529	:=	final_score_529	;
			self.final_score_530	:=	final_score_530	;
			self.final_score_531	:=	final_score_531	;
			self.final_score_532	:=	final_score_532	;
			self.final_score_533	:=	final_score_533	;
			self.final_score_534	:=	final_score_534	;
			self.final_score_535	:=	final_score_535	;
			self.final_score_536	:=	final_score_536	;
			self.final_score_537	:=	final_score_537	;
			self.final_score_538	:=	final_score_538	;
			self.final_score_539	:=	final_score_539	;
			self.final_score_540	:=	final_score_540	;
			self.final_score_541	:=	final_score_541	;
			self.final_score_542	:=	final_score_542	;
			self.final_score_543	:=	final_score_543	;
			self.final_score_544	:=	final_score_544	;
			self.final_score_545	:=	final_score_545	;
			self.final_score_546	:=	final_score_546	;
			self.final_score_547	:=	final_score_547	;
			self.final_score_548	:=	final_score_548	;
			self.final_score_549	:=	final_score_549	;
			self.final_score_550	:=	final_score_550	;
			self.final_score_551	:=	final_score_551	;
			self.final_score_552	:=	final_score_552	;
			self.final_score_553	:=	final_score_553	;
			self.final_score_554	:=	final_score_554	;
			self.final_score_555	:=	final_score_555	;
			self.final_score_556	:=	final_score_556	;
			self.final_score_557	:=	final_score_557	;
			self.final_score_558	:=	final_score_558	;
			self.final_score_559	:=	final_score_559	;
			self.final_score_560	:=	final_score_560	;
			self.final_score_561	:=	final_score_561	;
			self.final_score_562	:=	final_score_562	;
			self.final_score_563	:=	final_score_563	;
			self.final_score_564	:=	final_score_564	;
			self.final_score_565	:=	final_score_565	;
			self.final_score_566	:=	final_score_566	;
			self.final_score_567	:=	final_score_567	;
			self.final_score_568	:=	final_score_568	;
			self.final_score_569	:=	final_score_569	;
			self.final_score_570	:=	final_score_570	;
			self.final_score_571	:=	final_score_571	;
			self.final_score_572	:=	final_score_572	;
			self.final_score_573	:=	final_score_573	;
			self.final_score_574	:=	final_score_574	;
			self.final_score_575	:=	final_score_575	;
			self.final_score_576	:=	final_score_576	;
			self.final_score_577	:=	final_score_577	;
			self.final_score_578	:=	final_score_578	;
			self.final_score_579	:=	final_score_579	;
			self.final_score_580	:=	final_score_580	;
			self.final_score_581	:=	final_score_581	;
			self.final_score_582	:=	final_score_582	;
			self.final_score_583	:=	final_score_583	;
			self.final_score_584	:=	final_score_584	;
			self.final_score_585	:=	final_score_585	;
			self.final_score_586	:=	final_score_586	;
			self.final_score_587	:=	final_score_587	;
			self.final_score_588	:=	final_score_588	;
			self.final_score_589	:=	final_score_589	;
			self.final_score_590	:=	final_score_590	;
			self.final_score_591	:=	final_score_591	;
			self.final_score_592	:=	final_score_592	;
			self.final_score_593	:=	final_score_593	;
			self.final_score_594	:=	final_score_594	;
			self.final_score_595	:=	final_score_595	;
			self.final_score_596	:=	final_score_596	;
			self.final_score_597	:=	final_score_597	;
			self.final_score_598	:=	final_score_598	;
			self.final_score_599	:=	final_score_599	;
			self.final_score_600	:=	final_score_600	;
			self.final_score_601	:=	final_score_601	;
			self.final_score_602	:=	final_score_602	;
			self.final_score_603	:=	final_score_603	;
			self.final_score_604	:=	final_score_604	;
			self.final_score_605	:=	final_score_605	;
			self.final_score_606	:=	final_score_606	;
			self.final_score_607	:=	final_score_607	;
			self.final_score_608	:=	final_score_608	;
			self.final_score_609	:=	final_score_609	;
			self.final_score_610	:=	final_score_610	;
			self.final_score_611	:=	final_score_611	;
			self.final_score_612	:=	final_score_612	;
			self.final_score_613	:=	final_score_613	;
			self.final_score_614	:=	final_score_614	;
			self.final_score_615	:=	final_score_615	;
			self.final_score_616	:=	final_score_616	;
			self.final_score_617	:=	final_score_617	;
			self.final_score_618	:=	final_score_618	;
			self.final_score_619	:=	final_score_619	;
			self.final_score_620	:=	final_score_620	;
			self.final_score_621	:=	final_score_621	;
			self.final_score_622	:=	final_score_622	;
			self.final_score_623	:=	final_score_623	;
			self.final_score_624	:=	final_score_624	;
			self.final_score_625	:=	final_score_625	;
			self.final_score_626	:=	final_score_626	;
			self.final_score_627	:=	final_score_627	;
			self.final_score_628	:=	final_score_628	;
			self.final_score_629	:=	final_score_629	;
			self.final_score_630	:=	final_score_630	;
			self.final_score_631	:=	final_score_631	;
			self.final_score_632	:=	final_score_632	;
			self.final_score_633	:=	final_score_633	;
			self.final_score_634	:=	final_score_634	;
			self.final_score_635	:=	final_score_635	;
			self.final_score_636	:=	final_score_636	;
			self.final_score_637	:=	final_score_637	;
			self.final_score_638	:=	final_score_638	;
			self.final_score_639	:=	final_score_639	;
			self.final_score_640	:=	final_score_640	;
			self.final_score_641	:=	final_score_641	;
			self.final_score_642	:=	final_score_642	;
			self.final_score_643	:=	final_score_643	;
			self.final_score_644	:=	final_score_644	;
			self.final_score_645	:=	final_score_645	;
			self.final_score_646	:=	final_score_646	;
			self.final_score_647	:=	final_score_647	;
			self.final_score_648	:=	final_score_648	;
			self.final_score_649	:=	final_score_649	;
			self.final_score_650	:=	final_score_650	;
			self.final_score_651	:=	final_score_651	;
			self.final_score_652	:=	final_score_652	;
			self.final_score_653	:=	final_score_653	;
			self.final_score_654	:=	final_score_654	;
			self.final_score_655	:=	final_score_655	;
			self.final_score_656	:=	final_score_656	;
			self.final_score_657	:=	final_score_657	;
			self.final_score_658	:=	final_score_658	;
			self.final_score_659	:=	final_score_659	;
			self.final_score_660	:=	final_score_660	;
			self.final_score_661	:=	final_score_661	;
			self.final_score_662	:=	final_score_662	;
			self.final_score_663	:=	final_score_663	;
			self.final_score_664	:=	final_score_664	;
			self.final_score_665	:=	final_score_665	;
			self.final_score_666	:=	final_score_666	;
			self.final_score_667	:=	final_score_667	;
			self.final_score_668	:=	final_score_668	;
			self.final_score_669	:=	final_score_669	;
			self.final_score_670	:=	final_score_670	;
			self.final_score_671	:=	final_score_671	;
			self.final_score_672	:=	final_score_672	;
			self.final_score_673	:=	final_score_673	;
			self.final_score_674	:=	final_score_674	;
			self.final_score_675	:=	final_score_675	;
			self.final_score_676	:=	final_score_676	;
			self.final_score_677	:=	final_score_677	;
			self.final_score_678	:=	final_score_678	;
			self.final_score_679	:=	final_score_679	;
			self.final_score_680	:=	final_score_680	;
			self.final_score_681	:=	final_score_681	;
			self.final_score_682	:=	final_score_682	;
			self.final_score_683	:=	final_score_683	;
			self.final_score_684	:=	final_score_684	;
			self.final_score_685	:=	final_score_685	;
			self.final_score_686	:=	final_score_686	;
			self.final_score_687	:=	final_score_687	;
			self.final_score_688	:=	final_score_688	;
			self.final_score_689	:=	final_score_689	;
			self.final_score_690	:=	final_score_690	;
			self.final_score_691	:=	final_score_691	;
			self.final_score_692	:=	final_score_692	;
			self.final_score_693	:=	final_score_693	;
			self.final_score_694	:=	final_score_694	;
			self.final_score_695	:=	final_score_695	;
			self.final_score_696	:=	final_score_696	;
			self.final_score_697	:=	final_score_697	;
			self.final_score_698	:=	final_score_698	;
			self.final_score_699	:=	final_score_699	;
			self.final_score_700	:=	final_score_700	;
			self.final_score_701	:=	final_score_701	;
			self.final_score_702	:=	final_score_702	;
			self.final_score_703	:=	final_score_703	;
			self.final_score_704	:=	final_score_704	;
			self.final_score_705	:=	final_score_705	;
			self.final_score_706	:=	final_score_706	;
			self.final_score_707	:=	final_score_707	;
			self.final_score_708	:=	final_score_708	;
			self.final_score_709	:=	final_score_709	;
			self.final_score_710	:=	final_score_710	;
			self.final_score_711	:=	final_score_711	;
			self.final_score_712	:=	final_score_712	;
			self.final_score_713	:=	final_score_713	;
			self.final_score_714	:=	final_score_714	;
			self.final_score_715	:=	final_score_715	;
			self.final_score_716	:=	final_score_716	;
			self.final_score_717	:=	final_score_717	;
			self.final_score_718	:=	final_score_718	;
			self.final_score_719	:=	final_score_719	;
			self.final_score_720	:=	final_score_720	;
			self.final_score_721	:=	final_score_721	;
			self.final_score_722	:=	final_score_722	;
			self.final_score_723	:=	final_score_723	;
			self.final_score_724	:=	final_score_724	;
			self.final_score_725	:=	final_score_725	;
			self.final_score_726	:=	final_score_726	;
			self.final_score_727	:=	final_score_727	;
			self.final_score_728	:=	final_score_728	;
			self.final_score_729	:=	final_score_729	;
			self.final_score_730	:=	final_score_730	;
			self.final_score_731	:=	final_score_731	;
			self.final_score_732	:=	final_score_732	;
			self.final_score_733	:=	final_score_733	;
			self.final_score_734	:=	final_score_734	;
			self.final_score_735	:=	final_score_735	;
			self.final_score_736	:=	final_score_736	;
			self.final_score_737	:=	final_score_737	;
			self.final_score_738	:=	final_score_738	;
			self.final_score_739	:=	final_score_739	;
			self.final_score_740	:=	final_score_740	;
			self.final_score_741	:=	final_score_741	;
			self.final_score_742	:=	final_score_742	;
			self.final_score_743	:=	final_score_743	;
			self.final_score_744	:=	final_score_744	;
			self.final_score_745	:=	final_score_745	;
			self.final_score_746	:=	final_score_746	;
			self.final_score_747	:=	final_score_747	;
			self.final_score_748	:=	final_score_748	;
			self.final_score_749	:=	final_score_749	;
			self.final_score_750	:=	final_score_750	;
			self.final_score_751	:=	final_score_751	;
			self.final_score_752	:=	final_score_752	;
			self.final_score_753	:=	final_score_753	;
			self.final_score_754	:=	final_score_754	;
			self.final_score_755	:=	final_score_755	;
			self.final_score_756	:=	final_score_756	;
			self.final_score_757	:=	final_score_757	;
			self.final_score_758	:=	final_score_758	;
			self.final_score_759	:=	final_score_759	;
			self.final_score_760	:=	final_score_760	;
			self.final_score_761	:=	final_score_761	;
			self.final_score_762	:=	final_score_762	;
			self.final_score_763	:=	final_score_763	;
			self.final_score_764	:=	final_score_764	;
			self.final_score_765	:=	final_score_765	;
			self.final_score_766	:=	final_score_766	;
			self.final_score_767	:=	final_score_767	;
			self.final_score_768	:=	final_score_768	;
			self.final_score_769	:=	final_score_769	;
			self.final_score_770	:=	final_score_770	;
			self.final_score_771	:=	final_score_771	;
			self.final_score_772	:=	final_score_772	;
			self.final_score_773	:=	final_score_773	;
			self.final_score_774	:=	final_score_774	;
			self.final_score_775	:=	final_score_775	;
			self.final_score_776	:=	final_score_776	;
			self.final_score_777	:=	final_score_777	;
			self.final_score_778	:=	final_score_778	;
			self.final_score_779	:=	final_score_779	;
			self.final_score_780	:=	final_score_780	;
			self.final_score_781	:=	final_score_781	;
			self.final_score_782	:=	final_score_782	;
			self.final_score_783	:=	final_score_783	;
			self.final_score_784	:=	final_score_784	;
			self.final_score_785	:=	final_score_785	;
			self.final_score_786	:=	final_score_786	;
			self.final_score_787	:=	final_score_787	;
			self.final_score_788	:=	final_score_788	;
			self.final_score_789	:=	final_score_789	;
			self.final_score_790	:=	final_score_790	;
			self.final_score_791	:=	final_score_791	;
			self.final_score_792	:=	final_score_792	;
			self.final_score_793	:=	final_score_793	;
			self.final_score_794	:=	final_score_794	;
			self.final_score_795	:=	final_score_795	;
			self.final_score_796	:=	final_score_796	;
			self.final_score_797	:=	final_score_797	;
			self.final_score_798	:=	final_score_798	;
			self.final_score_799	:=	final_score_799	;
			self.final_score_800	:=	final_score_800	;
			self.final_score_801	:=	final_score_801	;
			self.final_score_802	:=	final_score_802	;
			self.final_score_803	:=	final_score_803	;
			self.final_score_804	:=	final_score_804	;
			self.final_score_805	:=	final_score_805	;
			self.final_score_806	:=	final_score_806	;
			self.final_score_807	:=	final_score_807	;
			self.final_score_808	:=	final_score_808	;
			self.final_score_809	:=	final_score_809	;
			self.final_score_810	:=	final_score_810	;
			self.final_score_811	:=	final_score_811	;
			self.final_score_812	:=	final_score_812	;
			self.final_score_813	:=	final_score_813	;
			self.final_score_814	:=	final_score_814	;
			self.final_score_815	:=	final_score_815	;
			self.final_score_816	:=	final_score_816	;
			self.final_score_817	:=	final_score_817	;
			self.final_score_818	:=	final_score_818	;
			self.final_score_819	:=	final_score_819	;
			self.final_score_820	:=	final_score_820	;
			self.final_score_821	:=	final_score_821	;
			self.final_score_822	:=	final_score_822	;
			self.final_score_823	:=	final_score_823	;
			self.final_score_824	:=	final_score_824	;
			self.final_score_825	:=	final_score_825	;
			self.final_score_826	:=	final_score_826	;
			self.final_score_827	:=	final_score_827	;
			self.final_score_828	:=	final_score_828	;
			self.final_score_829	:=	final_score_829	;
			self.final_score_830	:=	final_score_830	;
			self.final_score_831	:=	final_score_831	;
			self.final_score_832	:=	final_score_832	;
			self.final_score_833	:=	final_score_833	;
			self.final_score_834	:=	final_score_834	;
			self.final_score_835	:=	final_score_835	;
			self.final_score_836	:=	final_score_836	;
			self.final_score_837	:=	final_score_837	;
			self.final_score_838	:=	final_score_838	;
			self.final_score_839	:=	final_score_839	;
			self.final_score_840	:=	final_score_840	;
			self.final_score_841	:=	final_score_841	;
			self.final_score_842	:=	final_score_842	;
			self.final_score_843	:=	final_score_843	;
			self.final_score_844	:=	final_score_844	;
			self.final_score_845	:=	final_score_845	;
			self.final_score_846	:=	final_score_846	;
			self.final_score_847	:=	final_score_847	;
			self.final_score_848	:=	final_score_848	;
			self.final_score_849	:=	final_score_849	;
			self.final_score_850	:=	final_score_850	;
			self.final_score_851	:=	final_score_851	;
			self.final_score_852	:=	final_score_852	;
			self.final_score_853	:=	final_score_853	;
			self.final_score_854	:=	final_score_854	;
			self.final_score_855	:=	final_score_855	;
			self.final_score_856	:=	final_score_856	;
			self.final_score_857	:=	final_score_857	;
			self.final_score_858	:=	final_score_858	;
			self.final_score_859	:=	final_score_859	;
			self.final_score_860	:=	final_score_860	;
			self.final_score_861	:=	final_score_861	;
			self.final_score_862	:=	final_score_862	;
			self.final_score_863	:=	final_score_863	;
			self.final_score_864	:=	final_score_864	;
			self.final_score_865	:=	final_score_865	;
			self.final_score_866	:=	final_score_866	;
			self.final_score_867	:=	final_score_867	;
			self.final_score_868	:=	final_score_868	;
			self.final_score_869	:=	final_score_869	;
			self.final_score_870	:=	final_score_870	;
			self.final_score_871	:=	final_score_871	;
			self.final_score_872	:=	final_score_872	;
			self.final_score_873	:=	final_score_873	;
			self.final_score_874	:=	final_score_874	;
			self.final_score_875	:=	final_score_875	;
			self.final_score_876	:=	final_score_876	;
			self.final_score_877	:=	final_score_877	;
			self.final_score_878	:=	final_score_878	;
			self.final_score_879	:=	final_score_879	;
			self.final_score_880	:=	final_score_880	;
			self.final_score_881	:=	final_score_881	;
			self.final_score_882	:=	final_score_882	;
			self.final_score_883	:=	final_score_883	;
			self.final_score_884	:=	final_score_884	;
			self.final_score_885	:=	final_score_885	;
			self.final_score_886	:=	final_score_886	;
			self.final_score_887	:=	final_score_887	;
			self.final_score_888	:=	final_score_888	;
			self.final_score_889	:=	final_score_889	;
			self.final_score_890	:=	final_score_890	;
			self.final_score_891	:=	final_score_891	;
			self.final_score_892	:=	final_score_892	;
			self.final_score_893	:=	final_score_893	;
			self.final_score_894	:=	final_score_894	;
			self.final_score_895	:=	final_score_895	;
			self.final_score_896	:=	final_score_896	;
			self.final_score_897	:=	final_score_897	;
			self.final_score_898	:=	final_score_898	;
			self.final_score_899	:=	final_score_899	;
			self.final_score_900	:=	final_score_900	;
			self.final_score_901	:=	final_score_901	;
			self.final_score_902	:=	final_score_902	;
			self.final_score_903	:=	final_score_903	;
			self.final_score_904	:=	final_score_904	;
			self.final_score_905	:=	final_score_905	;
			self.final_score_906	:=	final_score_906	;
			self.final_score_907	:=	final_score_907	;
			self.final_score_908	:=	final_score_908	;
			self.final_score_909	:=	final_score_909	;
			self.final_score_910	:=	final_score_910	;
			self.final_score_911	:=	final_score_911	;
			self.final_score_912	:=	final_score_912	;
			self.final_score_913	:=	final_score_913	;
			self.final_score_914	:=	final_score_914	;
			self.final_score_915	:=	final_score_915	;
			self.final_score_916	:=	final_score_916	;
			self.final_score_917	:=	final_score_917	;
			self.final_score_918	:=	final_score_918	;
			self.final_score_919	:=	final_score_919	;
			self.final_score_920	:=	final_score_920	;
			self.final_score_921	:=	final_score_921	;
			self.final_score_922	:=	final_score_922	;
			self.final_score_923	:=	final_score_923	;
			self.final_score_924	:=	final_score_924	;
			self.final_score_925	:=	final_score_925	;
			self.final_score_926	:=	final_score_926	;
			self.final_score_927	:=	final_score_927	;
			self.final_score_928	:=	final_score_928	;
			self.final_score_929	:=	final_score_929	;
			self.final_score_930	:=	final_score_930	;
			self.final_score_931	:=	final_score_931	;
			self.final_score_932	:=	final_score_932	;
			self.final_score_933	:=	final_score_933	;
			self.final_score_934	:=	final_score_934	;
			self.final_score_935	:=	final_score_935	;
			self.final_score_936	:=	final_score_936	;
			self.final_score_937	:=	final_score_937	;
			self.final_score_938	:=	final_score_938	;
			self.final_score_939	:=	final_score_939	;
			self.final_score_940	:=	final_score_940	;
			self.final_score_941	:=	final_score_941	;
			self.final_score_942	:=	final_score_942	;
			self.final_score_943	:=	final_score_943	;
			self.final_score_944	:=	final_score_944	;
			self.final_score_945	:=	final_score_945	;
			self.final_score_946	:=	final_score_946	;
			self.final_score_947	:=	final_score_947	;
			self.final_score_948	:=	final_score_948	;
			self.final_score_949	:=	final_score_949	;
			self.cp3							:=	cp3	;

		#else
			self.phone_shell.Phone_Model_Score		:= (string) cp3;
		#end
			self := le;
	END;

		model := project( clam, doModel(left) )((Integer)phone_shell.Phone_Model_Score >= Score_Threshold); 

		return model;

END;
