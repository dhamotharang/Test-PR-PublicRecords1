
import risk_indicators, riskwise, riskwisefcra, ut, Models;

export CollectionsScore_v8(dataset(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout) clam, Unsigned2 Score_Threshold	= Phone_Shell.Constants.Default_PhoneScore) := FUNCTION

  PHONE_DEBUG := false;

  #if(PHONE_DEBUG)
    layout_debug := record
			integer sysdate;
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
			string  source_cr_lseen;
			string  source_cr_fseen;
			string  source_edaca_fseen;
			string  source_edadid_fseen;
			string  source_edafla_fseen;
			string  source_edahistory_fseen;
			string  source_edala_fseen;
			string  source_inf_lseen;
			string  source_inf_fseen;
			string  source_md_fseen;
			string  source_paw_lseen;
			string  source_paw_fseen;
			string  source_pf_fseen;
			string  source_ppca_lseen;
			string  source_ppca_fseen;
			string  source_ppdid_lseen;
			string  source_ppdid_fseen;
			string  source_ppfa_lseen;
			string  source_ppfla_lseen;
			string  source_ppfla_fseen;
			string  source_ppla_lseen;
			string  source_ppla_fseen;
			string  source_ppth_lseen;
			string  source_ppth_fseen;
			string  source_rel_fseen;
			string  source_rm_fseen;
			string  source_sp_lseen;
			string  source_sp_fseen;
			string  source_sx_fseen;
			string  source_utildid_fseen;
			integer source_eda_any_clean;
			integer number_of_sources;
			integer source_cr_lseen2;
			integer source_cr_fseen2;
			integer source_edaca_fseen2;
			integer source_edadid_fseen2;
			integer source_edafla_fseen2;
			integer source_edahistory_fseen2;
			integer source_edala_fseen2;
			integer source_inf_lseen2;
			integer source_inf_fseen2;
			integer source_md_fseen2;
			integer source_paw_lseen2;
			integer source_paw_fseen2;
			integer source_pf_fseen2;
			integer source_ppca_lseen2;
			integer source_ppca_fseen2;
			integer source_ppdid_lseen2;
			integer source_ppdid_fseen2;
			integer source_ppfa_lseen2;
			integer source_ppfla_lseen2;
			integer source_ppfla_fseen2;
			integer source_ppla_lseen2;
			integer source_ppla_fseen2;
			integer source_ppth_lseen2;
			integer source_ppth_fseen2;
			integer source_rel_fseen2;
			integer source_rm_fseen2;
			integer source_sp_lseen2;
			integer source_sp_fseen2;
			integer source_sx_fseen2;
			integer source_utildid_fseen2;
			integer eda_dt_first_seen2;
			integer exp_last_update2;
			integer internal_ver_first_seen2;
			integer phone_fb_rp_date2;
			integer pp_datefirstseen2;
			integer pp_datelastseen2;
			integer pp_datevendorfirstseen2;
			integer pp_datevendorlastseen2;
			integer pp_date_nonglb_lastseen2;
			integer pp_orig_lastseen2; 
			integer pp_app_npa_effective_dt2;
			integer pp_app_npa_last_change_dt2;
			integer pp_eda_hist_ph_dt2;
			integer pp_eda_hist_did_dt2;
			integer pp_app_fb_ph_dt2;
			integer pp_app_fb_ph7_did_dt2;
			integer pp_first_build_date2; 
			integer mth_source_cr_lseen;
			integer mth_source_cr_fseen;
			integer mth_source_edaca_fseen;
			integer mth_source_edadid_fseen;
			integer mth_source_edafla_fseen;
			integer mth_source_edahistory_fseen;
			integer mth_source_edala_fseen;
			integer mth_source_inf_lseen;
			integer mth_source_inf_fseen;
			integer mth_source_md_fseen;
			integer mth_source_paw_lseen;
			integer mth_source_paw_fseen;
			integer mth_source_pf_fseen;
			integer mth_source_ppca_lseen;
			integer mth_source_ppca_fseen;
			integer mth_source_ppdid_lseen;
			integer mth_source_ppdid_fseen;
			integer mth_source_ppfa_lseen;
			integer mth_source_ppfla_lseen;
			integer mth_source_ppfla_fseen;
			integer mth_source_ppla_lseen;
			integer mth_source_ppla_fseen;
			integer mth_source_ppth_lseen;
			integer mth_source_ppth_fseen;
			integer mth_source_rel_fseen;
			integer mth_source_rm_fseen;
			integer mth_source_sp_lseen;
			integer mth_source_sp_fseen;
			integer mth_source_sx_fseen;
			integer mth_source_utildid_fseen;
			integer mth_eda_dt_first_seen;
			integer mth_exp_last_update;
			integer mth_internal_ver_first_seen;
			integer mth_phone_fb_rp_date;
			integer mth_pp_datefirstseen;
			integer mth_pp_datelastseen;
			integer mth_pp_datevendorfirstseen;
			integer mth_pp_datevendorlastseen;
			integer mth_pp_date_nonglb_lastseen;
			integer mth_pp_orig_lastseen;
			integer mth_pp_app_npa_effective_dt;
			integer mth_pp_app_npa_last_change_dt;
			integer mth_pp_eda_hist_ph_dt;
			integer mth_pp_eda_hist_did_dt;
			integer mth_pp_app_fb_ph_dt;
			integer mth_pp_app_fb_ph7_did_dt;
			integer mth_pp_first_build_date;
			boolean _phone_match_code_a;
			boolean _phone_match_code_c;
			boolean _phone_match_code_d;
			boolean _phone_match_code_l;
			boolean _phone_match_code_n;
			boolean _phone_match_code_s;
			boolean _phone_match_code_t;
			boolean _phone_match_code_z;
			integer _pp_rule_seen_once;
			integer _pp_rule_high_vend_conf;
			integer _pp_rule_low_vend_conf;
			integer _pp_rule_cellphone_latest;
			integer _pp_rule_targ_non_pub;
			integer _pp_rule_med_vend_conf_cell;
			integer _pp_rule_iq_rpc;
			integer _pp_rule_ins_ver_above;
			integer _pp_rule_30;
			integer _pp_src_all_eq;
			integer _pp_src_all_uw;
			integer _pp_src_all_iq;
			integer _pp_src_all_tn;
			integer _pp_src_all_ib;
			integer _pp_src_all_48;
			integer _pp_app_nonpub_gong_la;
			integer _pp_app_nonpub_targ_la;
			integer _pp_app_nonpub_targ_lap;
			integer _pp_app_ported_match_7;
			integer inq_firstseen_n;
			integer inq_lastseen_n;
			integer inq_adl_firstseen_n;
			integer inq_adl_lastseen_n;
			integer _internal_ver_match_level;
			integer _inq_adl_ph_industry_auto;
			integer _inq_adl_ph_industry_cards;
			integer _inq_adl_ph_industry_flag;
			integer _pp_agegroup;
			integer _pp_app_nxx_type;
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
			string  segment;
			integer r_nas_addr_verd_d;
			integer r_pb_order_freq_d;
			integer f_bus_fname_verd_d;
			integer f_bus_name_nover_i;
			integer f_adl_util_inf_n;
			integer f_adl_util_conv_n;
			integer f_adl_util_misc_n;
			integer f_util_adl_count_n;
			integer f_util_add_input_inf_n;
			integer f_util_add_input_conv_n;
			integer f_util_add_input_misc_n;
			integer f_util_add_curr_conv_n;
			integer f_util_add_curr_misc_n;
			real    f_add_input_mobility_index_n;
			real    f_add_curr_mobility_index_n;
			integer f_inq_count_i;
			integer f_inq_count24_i;
			integer f_inq_per_ssn_i;
			integer f_inq_addrs_per_ssn_i;
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
			integer f_foreclosure_flag_i;
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
			integer f_rel_ageover60_count_d;
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
			integer f_srchcountwk_i;
			integer f_srchunvrfdaddrcount_i;
			integer f_srchunvrfddobcount_i;
			integer f_srchunvrfdphonecount_i;
			integer f_srchfraudsrchcount_i;
			integer f_srchfraudsrchcountyr_i;
			integer f_assocrisktype_i;
			integer f_assocsuspicousidcount_i;
			integer f_assoccredbureaucount_i;
			integer f_validationrisktype_i;
			integer f_corrrisktype_i;
			integer f_corrssnnamecount_d;
			integer f_corrssnaddrcount_d;
			integer f_corraddrnamecount_d;
			integer f_corrphonelastnamecount_d;
			integer f_divrisktype_i;
			integer f_divssnidmsrcurelcount_i;
			integer f_divaddrsuspidcountnew_i;
			integer f_srchssnsrchcount_i;
			integer f_srchaddrsrchcount_i;
			integer f_srchaddrsrchcountmo_i;
			integer f_srchaddrsrchcountwk_i;
			integer f_componentcharrisktype_i;
			integer f_inputaddractivephonelist_d;
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
			integer f_prevaddrdwelltype_apt_n;
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
			integer final_score;
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
			real	final_score_950	;
			real	final_score_951	;
			real	final_score_952	;
			real	final_score_953	;
			real	final_score_954	;
			real	final_score_955	;
			real	final_score_956	;
			real	final_score_957	;
			real	final_score_958	;
			real	final_score_959	;
			real	final_score_960	;
			real	final_score_961	;
			real	final_score_962	;
			real	final_score_963	;
			real	final_score_964	;
			real	final_score_965	;
			real	final_score_966	;
			real	final_score_967	;
			real	final_score_968	;
			real	final_score_969	;
			real	final_score_970	;
			real	final_score_971	;
			real	final_score_972	;
			real	final_score_973	;
			real	final_score_974	;
			real	final_score_975	;
			real	final_score_976	;
			real	final_score_977	;
			real	final_score_978	;
			real	final_score_979	;
			real	final_score_980	;
			real	final_score_981	;
			real	final_score_982	;
			real	final_score_983	;
			real	final_score_984	;
			real	final_score_985	;
			real	final_score_986	;
			real	final_score_987	;
			real	final_score_988	;
			real	final_score_989	;
			real	final_score_990	;
			real	final_score_991	;
			real	final_score_992	;
			real	final_score_993	;
			real	final_score_994	;
			real	final_score_995	;
			real	final_score_996	;
			real	final_score_997	;
			real	final_score_998	;
			real	final_score_999	;
			real	final_score_1000	;
			real	final_score_1001	;
			real	final_score_1002	;
			real	final_score_1003	;
			real	final_score_1004	;
			real	final_score_1005	;
			real	final_score_1006	;
			real	final_score_1007	;
			real	final_score_1008	;
			real	final_score_1009	;
			string50 acctno;
			string10 gathered_ph;
			integer wf8;
			// Save all of the Phone Shell fields for return
			Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
		Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout doModel( clam le ) := TRANSFORM
  #end

//Start: ECL SAS mapping variables 
	source_list               			 := trim(le.Phone_Shell.Sources.Source_List, left, right);	//kh-added trim
	source_list_last_seen            := trim(le.Phone_Shell.Sources.Source_List_Last_Seen, left, right);	//kh-added trim
	source_list_first_seen           := trim(le.Phone_Shell.Sources.Source_List_First_Seen, left, right);	//kh-added trim
	eda_dt_first_seen                := le.Phone_Shell.EDA_Characteristics.EDA_Dt_First_Seen;
	exp_last_update                  := le.Phone_Shell.Experian_File_One_Verification.Experian_Last_Update;
	internal_ver_first_seen          := le.Phone_Shell.Internal_Corroboration.Internal_Verification_First_Seen; //Kevin mapped
	phone_fb_rp_date                 := le.Phone_Shell.Phone_Feedback.Phone_Feedback_RP_Date;
	pp_datefirstseen                 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen;
	pp_datelastseen                  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen;
	pp_datevendorfirstseen           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen;
	pp_datevendorlastseen            := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen;
	pp_date_nonglb_lastseen          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen;
	pp_orig_lastseen                 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Orig_LastSeen;
	pp_app_npa_effective_dt          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Effective_DT;
	pp_app_npa_last_change_dt        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Last_Change_DT;
	pp_eda_hist_ph_dt                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Phone_Dt;
	pp_eda_hist_did_dt               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt;
	pp_app_fb_ph_dt                  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone_Dt;
	pp_app_fb_ph7_did_dt             := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID_Dt;
	pp_first_build_date              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_First_Build_Date;
	phone_match_code                 := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Match_Code;
	pp_rules                         := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Rules;
	pp_src_all                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src_All;
	pp_app_nonpublished_match        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NonPublished_Match;
	pp_app_ported_match              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Ported_Match;
	inq_firstseen                    := le.Phone_Shell.Inquiries.Inq_FirstSeen;
	inq_lastseen                     := le.Phone_Shell.Inquiries.Inq_LastSeen;
	inq_adl_firstseen                := le.Phone_Shell.Inquiries.Inq_ADL_FirstSeen;
	inq_adl_lastseen                 := le.Phone_Shell.Inquiries.Inq_ADL_LastSeen;
	// internal_ver_match_type          := ;
	// _internal_ver_match_lexid        := 1;
	// _internal_ver_match_spouse       := 1;
	// _internal_ver_match_hhid         := 1;
	// inq_adl_ph_industry              := le.Phone_Shell.Inquiries.Inq_ADL_Phone_Industry; //not the correct mapping
	inq_adl_ph_industry_list_12      := le.Phone_Shell.Inquiries.Inq_ADL_Phone_Industry_List_12;
	pp_agegroup                      := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_AgeGroup;
	pp_app_nxx_type                  := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NXX_Type;
	pp_app_fb_ph                     := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone;
	pp_app_fb_ph7_did                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID;
	phone_disconnected               := (integer)le.Phone_Shell.Raw_Phone_Characteristics.Phone_Disconnected;
	phone_zip_match                  := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Zip_Match;  //Kevin mapped
	phone_timezone_match             := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Timezone_Match;  //Kevin mapped
	phone_fb_result                  := le.Phone_Shell.Phone_Feedback.Phone_Feedback_Result;
	phone_fb_rp_result               := le.Phone_Shell.Phone_Feedback.Phone_Feedback_RP_Result;
	pp_app_coctype                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_COCType;
	pp_app_scc                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_SCC;
	phone_switch_type                := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Switch_Type;
	pp_app_ph_type                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Phone_Type;
	pp_app_company_type              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Company_Type;
	exp_type                         := le.Phone_Shell.Experian_File_One_Verification.Experian_Type;
	pp_glb_dppa_fl                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag;
	pp_origlistingtype               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigListingType;
	exp_verified                     := (integer)le.Phone_Shell.Experian_File_One_Verification.Experian_Verified;
	exp_source                       := le.Phone_Shell.Experian_File_One_Verification.Experian_Source;
	exp_ph_score_v1                  := le.Phone_Shell.Experian_File_One_Verification.Experian_Phone_Score_V1;
	util_add1_type_list              := le.Boca_Shell.utility.utili_addr1_type;
	// add1_isbestmatch                 := le.Boca_Shell.Address_Verification.Address_History_1.isBestMatch;
	add1_isbestmatch                 := le.Boca_Shell.Address_Verification.Input_Address_Information.isBestMatch;
	util_add2_type_list              := le.Boca_Shell.utility.utili_addr2_type;
	add1_occupants_1yr               := le.Boca_Shell.addr_risk_summary.occupants_1yr;
	add1_turnover_1yr_in             := le.Boca_Shell.addr_risk_summary.turnover_1yr_in;
	add2_occupants_1yr               := le.Boca_Shell.addr_risk_summary2.occupants_1yr;
	add2_turnover_1yr_in             := le.Boca_Shell.addr_risk_summary2.turnover_1yr_in;
	add1_turnover_1yr_out            := le.Boca_Shell.addr_risk_summary.turnover_1yr_out;
	add2_turnover_1yr_out            := le.Boca_Shell.addr_risk_summary2.turnover_1yr_out;
	ams_income_level_code            := le.Boca_Shell.student.income_level_code;
	// f_addrchangeecontrajindex_d      := '';  //this field name is also set in the code so will need to get resolved
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
	f_util_adl_count	               := le.Boca_Shell.utility.utili_adl_count;
	inq_count                        := le.Boca_Shell.acc_logs.inquiries.counttotal;
	inq_count24                      := le.Boca_Shell.acc_logs.inquiries.count24;
	inq_perssn                       := le.Boca_Shell.acc_logs.inquiryPerSSN;
	inq_addrsperssn                  := le.Boca_Shell.acc_logs.inquiryAddrsPerSSN;
	inq_peraddr                      := le.Boca_Shell.acc_logs.inquiryPerAddr;
	inq_adlsperaddr                  := le.Boca_Shell.acc_logs.inquiryADLsPerAddr;
	inq_lnamesperaddr                := le.Boca_Shell.acc_logs.inquiryLNamesPerAddr;
	inq_ssnsperaddr                  := le.Boca_Shell.acc_logs.inquirySSNsPerAddr;
	inq_banko_am_first_seen          := le.Boca_Shell.acc_logs.am_first_seen_date;
	inq_banko_am_last_seen           := le.Boca_Shell.acc_logs.am_last_seen_date;
	inq_banko_cm_first_seen          := le.Boca_Shell.acc_logs.cm_first_seen_date;
	inq_banko_cm_last_seen           := le.Boca_Shell.acc_logs.cm_last_seen_date;
	inq_banko_om_first_seen          := le.Boca_Shell.acc_logs.om_first_seen_date;
	inq_banko_om_last_seen           := le.Boca_Shell.acc_logs.om_last_seen_date;
	pb_number_of_sources             := (integer)le.Boca_Shell.ibehavior.number_of_sources;
	pb_average_days_bt_orders        := le.Boca_Shell.ibehavior.average_days_between_orders;
	attr_arrests                     := le.Boca_Shell.bjl.arrests_count;
	attr_arrests30                   := le.Boca_Shell.bjl.arrests_count30;
	attr_arrests90                   := le.Boca_Shell.bjl.arrests_count90;
	attr_arrests180                  := le.Boca_Shell.bjl.arrests_count180;
	attr_arrests12                   := le.Boca_Shell.bjl.arrests_count12;
	attr_arrests24                   := le.Boca_Shell.bjl.arrests_count24;
	attr_arrests36                   := le.Boca_Shell.bjl.arrests_count36;
	attr_arrests60                   := le.Boca_Shell.bjl.arrests_count60;
	fp_idrisktype                    := (integer)le.Boca_Shell.fdattributesv2.identityrisklevel;
	fp_idverrisktype                 := (integer)le.Boca_Shell.fdattributesv2.idverrisklevel;
	fp_sourcerisktype                := (integer)le.Boca_Shell.fdattributesv2.sourcerisklevel;
	fp_varrisktype                   := (integer)le.Boca_Shell.fdattributesv2.variationrisklevel;
	fp_vardobcount                   := (integer)le.Boca_Shell.fdattributesv2.variationdobcount;
	fp_vardobcountnew                := (integer)le.Boca_Shell.fdattributesv2.variationdobcountnew;
	fp_srchvelocityrisktype          := (integer)le.Boca_Shell.fdattributesv2.searchvelocityrisklevel;
	fp_srchcountwk                   := (integer)le.Boca_Shell.fdattributesv2.searchcountweek;
	fp_srchunvrfdaddrcount           := (integer)le.Boca_Shell.fdattributesv2.searchunverifiedaddrcountyear;
	fp_srchunvrfddobcount            := (integer)le.Boca_Shell.fdattributesv2.searchunverifieddobcountyear;
	fp_srchunvrfdphonecount          := (integer)le.Boca_Shell.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcount            := (integer)le.Boca_Shell.fdattributesv2.searchfraudsearchcount;
	fp_srchfraudsrchcountyr          := (integer)le.Boca_Shell.fdattributesv2.searchfraudsearchcountyear;
	fp_assocrisktype                 := (integer)le.Boca_Shell.fdattributesv2.assocrisklevel;
	fp_assocsuspicousidcount         := (integer)le.Boca_Shell.fdattributesv2.assocsuspicousidentitiescount;
	fp_assoccredbureaucount          := (integer)le.Boca_Shell.fdattributesv2.assoccreditbureauonlycount;
	fp_validationrisktype            := (integer)le.Boca_Shell.fdattributesv2.validationrisklevel;
	fp_corrrisktype                  := (integer)le.Boca_Shell.fdattributesv2.correlationrisklevel;
	fp_corrssnnamecount              := (integer)le.Boca_Shell.fdattributesv2.correlationssnnamecount;
	fp_corrssnaddrcount              := (integer)le.Boca_Shell.fdattributesv2.correlationssnaddrcount;
	fp_corraddrnamecount             := (integer)le.Boca_Shell.fdattributesv2.correlationaddrnamecount;
	fp_corrphonelastnamecount        := (integer)le.Boca_Shell.fdattributesv2.correlationphonelastnamecount;
	fp_divrisktype                   := (integer)le.Boca_Shell.fdattributesv2.divrisklevel;
	fp_divssnidmsrcurelcount         := (integer)le.Boca_Shell.fdattributesv2.divssnidentitymsourceurelcount;
	fp_divaddrsuspidcountnew         := (integer)le.Boca_Shell.fdattributesv2.divaddrsuspidentitycountnew;
	fp_srchssnsrchcount              := (integer)le.Boca_Shell.fdattributesv2.searchssnsearchcount;
	fp_srchaddrsrchcount             := (integer)le.Boca_Shell.fdattributesv2.searchaddrsearchcount;
	fp_srchaddrsrchcountmo           := (integer)le.Boca_Shell.fdattributesv2.searchaddrsearchcountmonth;
	fp_srchaddrsrchcountwk           := (integer)le.Boca_Shell.fdattributesv2.searchaddrsearchcountweek;
	fp_componentcharrisktype         := (integer)le.Boca_Shell.fdattributesv2.componentcharrisklevel;
	fp_inputaddractivephonelist      := (integer)le.Boca_Shell.fdattributesv2.inputaddractivephonelist;
	fp_addrchangeincomediff          := (integer)le.Boca_Shell.fdattributesv2.addrchangeincomediff;
	fp_addrchangevaluediff           := (integer)le.Boca_Shell.fdattributesv2.addrchangevaluediff;
	fp_addrchangecrimediff           := (integer)le.Boca_Shell.fdattributesv2.addrchangecrimediff;
	fp_addrchangeecontrajindex       := (integer)le.Boca_Shell.fdattributesv2.addrchangeecontrajectoryindex;
	fp_curraddractivephonelist       := (integer)le.Boca_Shell.fdattributesv2.curraddractivephonelist;
	fp_curraddrmedianincome          := (integer)le.Boca_Shell.fdattributesv2.curraddrmedianincome;
	fp_curraddrmedianvalue           := (integer)le.Boca_Shell.fdattributesv2.curraddrmedianvalue;
	fp_curraddrmurderindex           := (integer)le.Boca_Shell.fdattributesv2.curraddrmurderindex;
	fp_curraddrcartheftindex         := (integer)le.Boca_Shell.fdattributesv2.curraddrcartheftindex;
	fp_curraddrburglaryindex         := (integer)le.Boca_Shell.fdattributesv2.curraddrburglaryindex;
	fp_curraddrcrimeindex            := (integer)le.Boca_Shell.fdattributesv2.curraddrcrimeindex;
	fp_prevaddrageoldest             := (integer)le.Boca_Shell.fdattributesv2.prevaddrageoldest;
	fp_prevaddrlenofres              := (integer)le.Boca_Shell.fdattributesv2.prevaddrlenofres;
	fp_prevaddrdwelltype             := le.Boca_Shell.fdattributesv2.prevaddrdwelltype;
	fp_prevaddrstatus                := le.Boca_Shell.fdattributesv2.prevaddrstatus;
	fp_prevaddroccupantowned         := (integer)le.Boca_Shell.fdattributesv2.prevaddroccupantowned;
	fp_prevaddrmedianincome          := (integer)le.Boca_Shell.fdattributesv2.prevaddrmedianincome;
	fp_prevaddrmedianvalue           := (integer)le.Boca_Shell.fdattributesv2.prevaddrmedianvalue;
	fp_prevaddrmurderindex           := (integer)le.Boca_Shell.fdattributesv2.prevaddrmurderindex;
	fp_prevaddrcartheftindex         := (integer)le.Boca_Shell.fdattributesv2.prevaddrcartheftindex;
	fp_prevaddrburglaryindex         := (integer)le.Boca_Shell.fdattributesv2.prevaddrburglaryindex;
	fp_prevaddrcrimeindex            := (integer)le.Boca_Shell.fdattributesv2.prevaddrcrimeindex;
	foreclosure_flag                 := (integer)le.Boca_Shell.bjl.foreclosure_flag;
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
	PP_Type                       	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_type; // 34
	PP_Source                     	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_source; // 35
	// PP_Rules                        45
	PP_DID_Score                  	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DID_Score; // 47
	// PP_DateFirstSeen                49
	// PP_DateLastSeen                 50
	// PP_DateVendorFirstSeen          51
	// PP_DateVendorLastSeen           52
	// PP_Date_NonGLB_LastSeen         53
	// PP_GLB_DPPA_fl                  54
	PP_Src                        	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src; // 56
	// PP_Src_All                      57
	PP_Src_Cnt                    	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src_Cnt; // 58
	PP_Min_Source_Conf            	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Min_Source_Conf; // 62
	PP_Total_Source_Conf          	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Total_Source_Conf; // 63
	// PP_Orig_LastSeen                64
	PP_DID_Type                   	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DID_Type; // 65
	// PP_AgeGroup                     75
	// PP_OrigListingType              78
	PP_OrigPhoneType              	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneType; // 81
	PP_OrigPhoneUsage             	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneUsage; // 82
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
	PP_app_ph_Use                 	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_append_phone_use; // 105
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
	PP_app_ind_ph_Cnt             	 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_append_indiv_phone_cnt; // 126
	PP_app_ind_Has_actv_EDA_ph_fl 	 := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_append_indiv_has_active_eda_phone_flag; // 127
	PP_app_Latest_ph_Owner_fl     	 := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_append_latest_phone_owner_flag; // 128
	// estimated_income                130
	// wealth_index                    130
	PP_app_Best_Addr_Match_fl     	 := (integer)le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_append_best_addr_match_flag; // 131
	// PP_First_Build_Date             136
	// Phone_fb_Result                 139
	// Phone_fb_RP_Date                144
	// Phone_fb_RP_Result              145
	Inq_Num                       	 := (integer)le.Phone_Shell.Inquiries.Inq_Num; // 150
	Inq_Num_Addresses             	 := (integer)le.Phone_Shell.Inquiries.Inq_Num_Addresses; // 152
	Inq_Num_Addresses_06          	 := (integer)le.Phone_Shell.Inquiries.Inq_Num_Addresses_06; // 153
	Inq_Num_ADLs                  	 := (integer)le.Phone_Shell.Inquiries.Inq_Num_ADLs; // 154
	Inq_Num_ADLs_06               	 := (integer)le.Phone_Shell.Inquiries.Inq_Num_ADLs_06; // 155
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
	EDA_Disc_Cnt12                	 := le.Phone_Shell.EDA_Characteristics.EDA_disc_cnt12; // 181
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
	EDA_Has_Cur_Discon_90_Days    	 := (integer)le.Phone_Shell.EDA_Characteristics.EDA_has_cur_discon_90_days; // 216
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

f_util_adl_count_n  := if(not(truedid), NULL, f_util_adl_count);  //kh-added check for truedid to set to NULL

BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := models.common.sas_date(if(le.Boca_Shell.historydate=999999, (string)ut.getdate, (string6)le.Boca_Shell.historydate+'01'));

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

phone_pos_exp := Models.Common.findw_cpp(source_list, 'EXP' , ',', 'E');

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

source_cr := phone_pos_cr > 0;

source_edaca := phone_pos_edaca > 0;

source_edadid := phone_pos_edadid > 0;

source_edafa := phone_pos_edafa > 0;

source_edafla := phone_pos_edafla > 0;

source_edahistory := phone_pos_edahistory > 0;

source_edala := phone_pos_edala > 0;

source_edalfa := phone_pos_edalfa > 0;

source_exp := phone_pos_exp > 0;

source_inf := phone_pos_inf > 0;

source_input := phone_pos_input > 0;

source_md := phone_pos_md > 0;

source_ne := phone_pos_ne > 0;

source_paw := phone_pos_paw > 0;

source_pde := phone_pos_pde > 0;

source_pf := (integer)(phone_pos_pf > 0);

source_pffla := phone_pos_pffla > 0;

source_pfla := phone_pos_pfla > 0;

source_ppca := phone_pos_ppca > 0;

source_ppdid := (integer)(phone_pos_ppdid > 0);

source_ppfa := (integer)(phone_pos_ppfa > 0);

source_ppfla := phone_pos_ppfla > 0;

source_ppla := (integer)(phone_pos_ppla > 0);

source_pplfa := phone_pos_pplfa > 0;

source_ppth := phone_pos_ppth > 0;

source_rel := (integer)(phone_pos_rel > 0);

source_rm := phone_pos_rm > 0;

source_sp := (integer)(phone_pos_sp > 0);

source_sx := (integer)(phone_pos_sx > 0);

source_utildid := (integer)(phone_pos_utildid > 0);

source_cr_lseen := Models.Common.getw(source_list_last_seen, phone_pos_cr);

source_cr_fseen := Models.Common.getw(source_list_first_seen, phone_pos_cr);

source_edaca_fseen := Models.Common.getw(source_list_first_seen, phone_pos_edaca);

source_edadid_fseen := Models.Common.getw(source_list_first_seen, phone_pos_edadid);

source_edafla_fseen := Models.Common.getw(source_list_first_seen, phone_pos_edafla);

source_edahistory_fseen := Models.Common.getw(source_list_first_seen, phone_pos_edahistory);

source_edala_fseen := Models.Common.getw(source_list_first_seen, phone_pos_edala);

source_inf_lseen := Models.Common.getw(source_list_last_seen, phone_pos_inf);

source_inf_fseen := Models.Common.getw(source_list_first_seen, phone_pos_inf);

source_md_fseen := Models.Common.getw(source_list_first_seen, phone_pos_md);

source_paw_lseen := Models.Common.getw(source_list_last_seen, phone_pos_paw);

source_paw_fseen := Models.Common.getw(source_list_first_seen, phone_pos_paw);

source_pf_fseen := Models.Common.getw(source_list_first_seen, phone_pos_pf);

source_ppca_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppca);

source_ppca_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppca);

source_ppdid_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppdid);

source_ppdid_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppdid);

source_ppfa_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppfa);

source_ppfla_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppfla);

source_ppfla_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppfla);

source_ppla_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppla);

source_ppla_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppla);

source_ppth_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppth);

source_ppth_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppth);

source_rel_fseen := Models.Common.getw(source_list_first_seen, phone_pos_rel);

source_rm_fseen := Models.Common.getw(source_list_first_seen, phone_pos_rm);

source_sp_lseen := Models.Common.getw(source_list_last_seen, phone_pos_sp);

source_sp_fseen := Models.Common.getw(source_list_first_seen, phone_pos_sp);

source_sx_fseen := Models.Common.getw(source_list_first_seen, phone_pos_sx);

source_utildid_fseen := Models.Common.getw(source_list_first_seen, phone_pos_utildid);

source_eda_any_clean := max((integer)source_edaca, (integer)(integer)source_edadid, (integer)(integer)source_edafa, (integer)(integer)source_edafla, (integer)(integer)source_edala, (integer)(integer)source_edalfa);

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

// yr_source_cr_lseen := if(min(sysdate, source_cr_lseen2) = NULL, NULL, (sysdate - source_cr_lseen2) / 365.25);

mth_source_cr_lseen_1 := if(min(sysdate, source_cr_lseen2) = NULL, NULL, roundup((sysdate - source_cr_lseen2) / 30.5));	//kh-added round

source_cr_fseen2 := models.common.sas_date((string)(source_cr_fseen));

// yr_source_cr_fseen := if(min(sysdate, source_cr_fseen2) = NULL, NULL, (sysdate - source_cr_fseen2) / 365.25);

mth_source_cr_fseen_1 := if(min(sysdate, source_cr_fseen2) = NULL, NULL, roundup((sysdate - source_cr_fseen2) / 30.5));	//kh-added round

source_edaca_fseen2 := models.common.sas_date((string)(source_edaca_fseen));

// yr_source_edaca_fseen := if(min(sysdate, source_edaca_fseen2) = NULL, NULL, (sysdate - source_edaca_fseen2) / 365.25);

mth_source_edaca_fseen_1 := if(min(sysdate, source_edaca_fseen2) = NULL, NULL, roundup((sysdate - source_edaca_fseen2) / 30.5));	//kh-added round

source_edadid_fseen2 := models.common.sas_date((string)(source_edadid_fseen));

// yr_source_edadid_fseen := if(min(sysdate, source_edadid_fseen2) = NULL, NULL, (sysdate - source_edadid_fseen2) / 365.25);

mth_source_edadid_fseen_1 := if(min(sysdate, source_edadid_fseen2) = NULL, NULL, roundup((sysdate - source_edadid_fseen2) / 30.5));	//kh-added round

source_edafla_fseen2 := models.common.sas_date((string)(source_edafla_fseen));

// yr_source_edafla_fseen := if(min(sysdate, source_edafla_fseen2) = NULL, NULL, (sysdate - source_edafla_fseen2) / 365.25);

mth_source_edafla_fseen_1 := if(min(sysdate, source_edafla_fseen2) = NULL, NULL, roundup((sysdate - source_edafla_fseen2) / 30.5));	//kh-added round

source_edahistory_fseen2 := models.common.sas_date((string)(source_edahistory_fseen));

// yr_source_edahistory_fseen := if(min(sysdate, source_edahistory_fseen2) = NULL, NULL, (sysdate - source_edahistory_fseen2) / 365.25);

mth_source_edahistory_fseen_1 := if(min(sysdate, source_edahistory_fseen2) = NULL, NULL, roundup((sysdate - source_edahistory_fseen2) / 30.5));	//kh-added round

source_edala_fseen2 := models.common.sas_date((string)(source_edala_fseen));

// yr_source_edala_fseen := if(min(sysdate, source_edala_fseen2) = NULL, NULL, (sysdate - source_edala_fseen2) / 365.25);

mth_source_edala_fseen_1 := if(min(sysdate, source_edala_fseen2) = NULL, NULL, roundup((sysdate - source_edala_fseen2) / 30.5));	//kh-added round

source_inf_lseen2 := models.common.sas_date((string)(source_inf_lseen));

// yr_source_inf_lseen := if(min(sysdate, source_inf_lseen2) = NULL, NULL, (sysdate - source_inf_lseen2) / 365.25);

mth_source_inf_lseen_1 := if(min(sysdate, source_inf_lseen2) = NULL, NULL, roundup((sysdate - source_inf_lseen2) / 30.5));	//kh-added round

source_inf_fseen2 := models.common.sas_date((string)(source_inf_fseen));

// yr_source_inf_fseen := if(min(sysdate, source_inf_fseen2) = NULL, NULL, (sysdate - source_inf_fseen2) / 365.25);

mth_source_inf_fseen_1 := if(min(sysdate, source_inf_fseen2) = NULL, NULL, roundup((sysdate - source_inf_fseen2) / 30.5));	//kh-added round

source_md_fseen2 := models.common.sas_date((string)(source_md_fseen));

// yr_source_md_fseen := if(min(sysdate, source_md_fseen2) = NULL, NULL, (sysdate - source_md_fseen2) / 365.25);

mth_source_md_fseen_1 := if(min(sysdate, source_md_fseen2) = NULL, NULL, roundup((sysdate - source_md_fseen2) / 30.5));	//kh-added round

source_paw_lseen2 := models.common.sas_date((string)(source_paw_lseen));

// yr_source_paw_lseen := if(min(sysdate, source_paw_lseen2) = NULL, NULL, (sysdate - source_paw_lseen2) / 365.25);

mth_source_paw_lseen_1 := if(min(sysdate, source_paw_lseen2) = NULL, NULL, roundup((sysdate - source_paw_lseen2) / 30.5));	//kh-added round

source_paw_fseen2 := models.common.sas_date((string)(source_paw_fseen));

// yr_source_paw_fseen := if(min(sysdate, source_paw_fseen2) = NULL, NULL, (sysdate - source_paw_fseen2) / 365.25);

mth_source_paw_fseen_1 := if(min(sysdate, source_paw_fseen2) = NULL, NULL, roundup((sysdate - source_paw_fseen2) / 30.5));	//kh-added round

source_pf_fseen2 := models.common.sas_date((string)(source_pf_fseen));

// yr_source_pf_fseen := if(min(sysdate, source_pf_fseen2) = NULL, NULL, (sysdate - source_pf_fseen2) / 365.25);

mth_source_pf_fseen_1 := if(min(sysdate, source_pf_fseen2) = NULL, NULL, roundup((sysdate - source_pf_fseen2) / 30.5));	//kh-added round

source_ppca_lseen2 := models.common.sas_date((string)(source_ppca_lseen));

// yr_source_ppca_lseen := if(min(sysdate, source_ppca_lseen2) = NULL, NULL, (sysdate - source_ppca_lseen2) / 365.25);

mth_source_ppca_lseen_1 := if(min(sysdate, source_ppca_lseen2) = NULL, NULL, roundup((sysdate - source_ppca_lseen2) / 30.5));	//kh-added round

source_ppca_fseen2 := models.common.sas_date((string)(source_ppca_fseen));

// yr_source_ppca_fseen := if(min(sysdate, source_ppca_fseen2) = NULL, NULL, (sysdate - source_ppca_fseen2) / 365.25);

mth_source_ppca_fseen_1 := if(min(sysdate, source_ppca_fseen2) = NULL, NULL, roundup((sysdate - source_ppca_fseen2) / 30.5));	//kh-added round

source_ppdid_lseen2 := models.common.sas_date((string)(source_ppdid_lseen));

// yr_source_ppdid_lseen := if(min(sysdate, source_ppdid_lseen2) = NULL, NULL, (sysdate - source_ppdid_lseen2) / 365.25);

mth_source_ppdid_lseen_1 := if(min(sysdate, source_ppdid_lseen2) = NULL, NULL, roundup((sysdate - source_ppdid_lseen2) / 30.5));	//kh-added round

source_ppdid_fseen2 := models.common.sas_date((string)(source_ppdid_fseen));

// yr_source_ppdid_fseen := if(min(sysdate, source_ppdid_fseen2) = NULL, NULL, (sysdate - source_ppdid_fseen2) / 365.25);

mth_source_ppdid_fseen_1 := if(min(sysdate, source_ppdid_fseen2) = NULL, NULL, roundup((sysdate - source_ppdid_fseen2) / 30.5));	//kh-added round

source_ppfa_lseen2 := models.common.sas_date((string)(source_ppfa_lseen));

// yr_source_ppfa_lseen := if(min(sysdate, source_ppfa_lseen2) = NULL, NULL, (sysdate - source_ppfa_lseen2) / 365.25);

mth_source_ppfa_lseen_1 := if(min(sysdate, source_ppfa_lseen2) = NULL, NULL, roundup((sysdate - source_ppfa_lseen2) / 30.5));	//kh-added round

source_ppfla_lseen2 := models.common.sas_date((string)(source_ppfla_lseen));

// yr_source_ppfla_lseen := if(min(sysdate, source_ppfla_lseen2) = NULL, NULL, (sysdate - source_ppfla_lseen2) / 365.25);

mth_source_ppfla_lseen_1 := if(min(sysdate, source_ppfla_lseen2) = NULL, NULL, roundup((sysdate - source_ppfla_lseen2) / 30.5));	//kh-added round

source_ppfla_fseen2 := models.common.sas_date((string)(source_ppfla_fseen));

// yr_source_ppfla_fseen := if(min(sysdate, source_ppfla_fseen2) = NULL, NULL, (sysdate - source_ppfla_fseen2) / 365.25);

mth_source_ppfla_fseen_1 := if(min(sysdate, source_ppfla_fseen2) = NULL, NULL, roundup((sysdate - source_ppfla_fseen2) / 30.5));	//kh-added round

source_ppla_lseen2 := models.common.sas_date((string)(source_ppla_lseen));

// yr_source_ppla_lseen := if(min(sysdate, source_ppla_lseen2) = NULL, NULL, (sysdate - source_ppla_lseen2) / 365.25);

mth_source_ppla_lseen_1 := if(min(sysdate, source_ppla_lseen2) = NULL, NULL, roundup((sysdate - source_ppla_lseen2) / 30.5));	//kh-added round

source_ppla_fseen2 := models.common.sas_date((string)(source_ppla_fseen));

// yr_source_ppla_fseen := if(min(sysdate, source_ppla_fseen2) = NULL, NULL, (sysdate - source_ppla_fseen2) / 365.25);

mth_source_ppla_fseen_1 := if(min(sysdate, source_ppla_fseen2) = NULL, NULL, roundup((sysdate - source_ppla_fseen2) / 30.5));	//kh-added round

source_ppth_lseen2 := models.common.sas_date((string)(source_ppth_lseen));

// yr_source_ppth_lseen := if(min(sysdate, source_ppth_lseen2) = NULL, NULL, (sysdate - source_ppth_lseen2) / 365.25);

mth_source_ppth_lseen_1 := if(min(sysdate, source_ppth_lseen2) = NULL, NULL, roundup((sysdate - source_ppth_lseen2) / 30.5));	//kh-added round

source_ppth_fseen2 := models.common.sas_date((string)(source_ppth_fseen));

// yr_source_ppth_fseen := if(min(sysdate, source_ppth_fseen2) = NULL, NULL, (sysdate - source_ppth_fseen2) / 365.25);

mth_source_ppth_fseen_1 := if(min(sysdate, source_ppth_fseen2) = NULL, NULL, roundup((sysdate - source_ppth_fseen2) / 30.5));	//kh-added round

source_rel_fseen2 := models.common.sas_date((string)(source_rel_fseen));

// yr_source_rel_fseen := if(min(sysdate, source_rel_fseen2) = NULL, NULL, (sysdate - source_rel_fseen2) / 365.25);

mth_source_rel_fseen_1 := if(min(sysdate, source_rel_fseen2) = NULL, NULL, roundup((sysdate - source_rel_fseen2) / 30.5));	//kh-added round

source_rm_fseen2 := models.common.sas_date((string)(source_rm_fseen));

// yr_source_rm_fseen := if(min(sysdate, source_rm_fseen2) = NULL, NULL, (sysdate - source_rm_fseen2) / 365.25);

mth_source_rm_fseen_1 := if(min(sysdate, source_rm_fseen2) = NULL, NULL, roundup((sysdate - source_rm_fseen2) / 30.5));	//kh-added round

source_sp_lseen2 := models.common.sas_date((string)(source_sp_lseen));

// yr_source_sp_lseen := if(min(sysdate, source_sp_lseen2) = NULL, NULL, (sysdate - source_sp_lseen2) / 365.25);

mth_source_sp_lseen_1 := if(min(sysdate, source_sp_lseen2) = NULL, NULL, roundup((sysdate - source_sp_lseen2) / 30.5));	//kh-added round

source_sp_fseen2 := models.common.sas_date((string)(source_sp_fseen));

// yr_source_sp_fseen := if(min(sysdate, source_sp_fseen2) = NULL, NULL, (sysdate - source_sp_fseen2) / 365.25);

mth_source_sp_fseen_1 := if(min(sysdate, source_sp_fseen2) = NULL, NULL, roundup((sysdate - source_sp_fseen2) / 30.5));	//kh-added round

source_sx_fseen2 := models.common.sas_date((string)(source_sx_fseen));

// yr_source_sx_fseen := if(min(sysdate, source_sx_fseen2) = NULL, NULL, (sysdate - source_sx_fseen2) / 365.25);

mth_source_sx_fseen_1 := if(min(sysdate, source_sx_fseen2) = NULL, NULL, roundup((sysdate - source_sx_fseen2) / 30.5));	//kh-added round

source_utildid_fseen2 := models.common.sas_date((string)(source_utildid_fseen));

// yr_source_utildid_fseen := if(min(sysdate, source_utildid_fseen2) = NULL, NULL, (sysdate - source_utildid_fseen2) / 365.25);

mth_source_utildid_fseen_1 := if(min(sysdate, source_utildid_fseen2) = NULL, NULL, roundup((sysdate - source_utildid_fseen2) / 30.5));	//kh-added round

eda_dt_first_seen2 := models.common.sas_date((string)(eda_dt_first_seen));

// yr_eda_dt_first_seen := if(min(sysdate, eda_dt_first_seen2) = NULL, NULL, (sysdate - eda_dt_first_seen2) / 365.25);

mth_eda_dt_first_seen_1 := if(min(sysdate, eda_dt_first_seen2) = NULL, NULL, roundup((sysdate - eda_dt_first_seen2) / 30.5));	//kh-added round

exp_last_update2 := models.common.sas_date((string)(exp_last_update));

// yr_exp_last_update := if(min(sysdate, exp_last_update2) = NULL, NULL, (sysdate - exp_last_update2) / 365.25);

mth_exp_last_update_1 := if(min(sysdate, exp_last_update2) = NULL, NULL, roundup((sysdate - exp_last_update2) / 30.5));	//kh-added round

internal_ver_first_seen2 := models.common.sas_date((string)(internal_ver_first_seen));

// yr_internal_ver_first_seen := if(min(sysdate, internal_ver_first_seen2) = NULL, NULL, (sysdate - internal_ver_first_seen2) / 365.25);

mth_internal_ver_first_seen_1 := if(min(sysdate, internal_ver_first_seen2) = NULL, NULL, roundup((sysdate - internal_ver_first_seen2) / 30.5));	//kh-added round

phone_fb_rp_date2 := models.common.sas_date((string)(phone_fb_rp_date));

// yr_phone_fb_rp_date := if(min(sysdate, phone_fb_rp_date2) = NULL, NULL, (sysdate - phone_fb_rp_date2) / 365.25);

mth_phone_fb_rp_date_1 := if(min(sysdate, phone_fb_rp_date2) = NULL, NULL, roundup((sysdate - phone_fb_rp_date2) / 30.5));	//kh-added round

pp_datefirstseen2 := models.common.sas_date((string)(pp_datefirstseen));

// yr_pp_datefirstseen := if(min(sysdate, pp_datefirstseen2) = NULL, NULL, (sysdate - pp_datefirstseen2) / 365.25);

mth_pp_datefirstseen_1 := if(min(sysdate, pp_datefirstseen2) = NULL, NULL, roundup((sysdate - pp_datefirstseen2) / 30.5));	//kh-added round

pp_datelastseen2 := models.common.sas_date((string)(pp_datelastseen));

// yr_pp_datelastseen := if(min(sysdate, pp_datelastseen2) = NULL, NULL, (sysdate - pp_datelastseen2) / 365.25);

mth_pp_datelastseen_1 := if(min(sysdate, pp_datelastseen2) = NULL, NULL, roundup((sysdate - pp_datelastseen2) / 30.5));	//kh-added round

pp_datevendorfirstseen2 := models.common.sas_date((string)(pp_datevendorfirstseen));

// yr_pp_datevendorfirstseen := if(min(sysdate, pp_datevendorfirstseen2) = NULL, NULL, (sysdate - pp_datevendorfirstseen2) / 365.25);

mth_pp_datevendorfirstseen_1 := if(min(sysdate, pp_datevendorfirstseen2) = NULL, NULL, roundup((sysdate - pp_datevendorfirstseen2) / 30.5));	//kh-added round

pp_datevendorlastseen2 := models.common.sas_date((string)(pp_datevendorlastseen));

// yr_pp_datevendorlastseen := if(min(sysdate, pp_datevendorlastseen2) = NULL, NULL, (sysdate - pp_datevendorlastseen2) / 365.25);

mth_pp_datevendorlastseen_1 := if(min(sysdate, pp_datevendorlastseen2) = NULL, NULL, roundup((sysdate - pp_datevendorlastseen2) / 30.5));	//kh-added round

pp_date_nonglb_lastseen2 := models.common.sas_date((string)(pp_date_nonglb_lastseen));

// yr_pp_date_nonglb_lastseen := if(min(sysdate, pp_date_nonglb_lastseen2) = NULL, NULL, (sysdate - pp_date_nonglb_lastseen2) / 365.25);

mth_pp_date_nonglb_lastseen_1 := if(min(sysdate, pp_date_nonglb_lastseen2) = NULL, NULL, roundup((sysdate - pp_date_nonglb_lastseen2) / 30.5));	//kh-added round

pp_orig_lastseen2 := models.common.sas_date((string)(pp_orig_lastseen));

// yr_pp_orig_lastseen := if(min(sysdate, pp_orig_lastseen2) = NULL, NULL, (sysdate - pp_orig_lastseen2) / 365.25);

mth_pp_orig_lastseen_1 := if(min(sysdate, pp_orig_lastseen2) = NULL, NULL, roundup((sysdate - pp_orig_lastseen2) / 30.5));	//kh-added round

pp_app_npa_effective_dt2 := models.common.sas_date((string)(pp_app_npa_effective_dt));

// yr_pp_app_npa_effective_dt := if(min(sysdate, pp_app_npa_effective_dt2) = NULL, NULL, (sysdate - pp_app_npa_effective_dt2) / 365.25);

mth_pp_app_npa_effective_dt_1 := if(min(sysdate, pp_app_npa_effective_dt2) = NULL, NULL, roundup((sysdate - pp_app_npa_effective_dt2) / 30.5));	//kh-added round

pp_app_npa_last_change_dt2 := models.common.sas_date((string)(pp_app_npa_last_change_dt));

// yr_pp_app_npa_last_change_dt := if(min(sysdate, pp_app_npa_last_change_dt2) = NULL, NULL, (sysdate - pp_app_npa_last_change_dt2) / 365.25);

mth_pp_app_npa_last_change_dt_1 := if(min(sysdate, pp_app_npa_last_change_dt2) = NULL, NULL, roundup((sysdate - pp_app_npa_last_change_dt2) / 30.5));	//kh-added round

pp_eda_hist_ph_dt2 := models.common.sas_date((string)(PP_EDA_Hist_ph_dt));

// yr_pp_eda_hist_ph_dt := if(min(sysdate, pp_eda_hist_ph_dt2) = NULL, NULL, (sysdate - pp_eda_hist_ph_dt2) / 365.25);

mth_pp_eda_hist_ph_dt_1 := if(min(sysdate, pp_eda_hist_ph_dt2) = NULL, NULL, roundup((sysdate - pp_eda_hist_ph_dt2) / 30.5));	//kh-added round

pp_eda_hist_did_dt2 := models.common.sas_date((string)(PP_EDA_Hist_did_dt));

// yr_pp_eda_hist_did_dt := if(min(sysdate, pp_eda_hist_did_dt2) = NULL, NULL, (sysdate - pp_eda_hist_did_dt2) / 365.25);

mth_pp_eda_hist_did_dt_1 := if(min(sysdate, pp_eda_hist_did_dt2) = NULL, NULL, roundup((sysdate - pp_eda_hist_did_dt2) / 30.5));	//kh-added round

pp_app_fb_ph_dt2 := models.common.sas_date((string)(pp_app_fb_ph_dt));

// yr_pp_app_fb_ph_dt := if(min(sysdate, pp_app_fb_ph_dt2) = NULL, NULL, (sysdate - pp_app_fb_ph_dt2) / 365.25);

mth_pp_app_fb_ph_dt_1 := if(min(sysdate, pp_app_fb_ph_dt2) = NULL, NULL, roundup((sysdate - pp_app_fb_ph_dt2) / 30.5));	//kh-added round

pp_app_fb_ph7_did_dt2 := models.common.sas_date((string)(pp_app_fb_ph7_did_dt));

// yr_pp_app_fb_ph7_did_dt := if(min(sysdate, pp_app_fb_ph7_did_dt2) = NULL, NULL, (sysdate - pp_app_fb_ph7_did_dt2) / 365.25);

mth_pp_app_fb_ph7_did_dt_1 := if(min(sysdate, pp_app_fb_ph7_did_dt2) = NULL, NULL, roundup((sysdate - pp_app_fb_ph7_did_dt2) / 30.5));	//kh-added round

pp_first_build_date2 := models.common.sas_date((string)(pp_first_build_date));

// yr_pp_first_build_date := if(min(sysdate, pp_first_build_date2) = NULL, NULL, (sysdate - pp_first_build_date2) / 365.25);

mth_pp_first_build_date_1 := if(min(sysdate, pp_first_build_date2) = NULL, NULL, roundup((sysdate - pp_first_build_date2) / 30.5));	//kh-added round

mth_source_cr_lseen := if(mth_source_cr_lseen_1 = NULL, -999, mth_source_cr_lseen_1);

mth_source_cr_fseen := if(mth_source_cr_fseen_1 = NULL, -999, mth_source_cr_fseen_1);

mth_source_edaca_fseen := if(mth_source_edaca_fseen_1 = NULL, -999, mth_source_edaca_fseen_1);

mth_source_edadid_fseen := if(mth_source_edadid_fseen_1 = NULL, -999, mth_source_edadid_fseen_1);

mth_source_edafla_fseen := if(mth_source_edafla_fseen_1 = NULL, -999, mth_source_edafla_fseen_1);

mth_source_edahistory_fseen := if(mth_source_edahistory_fseen_1 = NULL, -999, mth_source_edahistory_fseen_1);

mth_source_edala_fseen := if(mth_source_edala_fseen_1 = NULL, -999, mth_source_edala_fseen_1);

mth_source_inf_lseen := if(mth_source_inf_lseen_1 = NULL, -999, mth_source_inf_lseen_1);

mth_source_inf_fseen := if(mth_source_inf_fseen_1 = NULL, -999, mth_source_inf_fseen_1);

mth_source_md_fseen := if(mth_source_md_fseen_1 = NULL, -999, mth_source_md_fseen_1);

mth_source_paw_lseen := if(mth_source_paw_lseen_1 = NULL, -999, mth_source_paw_lseen_1);

mth_source_paw_fseen := if(mth_source_paw_fseen_1 = NULL, -999, mth_source_paw_fseen_1);

mth_source_pf_fseen := if(mth_source_pf_fseen_1 = NULL, -999, mth_source_pf_fseen_1);

mth_source_ppca_lseen := if(mth_source_ppca_lseen_1 = NULL, -999, mth_source_ppca_lseen_1);

mth_source_ppca_fseen := if(mth_source_ppca_fseen_1 = NULL, -999, mth_source_ppca_fseen_1);

mth_source_ppdid_lseen := if(mth_source_ppdid_lseen_1 = NULL, -999, mth_source_ppdid_lseen_1);

mth_source_ppdid_fseen := if(mth_source_ppdid_fseen_1 = NULL, -999, mth_source_ppdid_fseen_1);

mth_source_ppfa_lseen := if(mth_source_ppfa_lseen_1 = NULL, -999, mth_source_ppfa_lseen_1);

mth_source_ppfla_lseen := if(mth_source_ppfla_lseen_1 = NULL, -999, mth_source_ppfla_lseen_1);

mth_source_ppfla_fseen := if(mth_source_ppfla_fseen_1 = NULL, -999, mth_source_ppfla_fseen_1);

mth_source_ppla_lseen := if(mth_source_ppla_lseen_1 = NULL, -999, mth_source_ppla_lseen_1);

mth_source_ppla_fseen := if(mth_source_ppla_fseen_1 = NULL, -999, mth_source_ppla_fseen_1);

mth_source_ppth_lseen := if(mth_source_ppth_lseen_1 = NULL, -999, mth_source_ppth_lseen_1);

mth_source_ppth_fseen := if(mth_source_ppth_fseen_1 = NULL, -999, mth_source_ppth_fseen_1);

mth_source_rel_fseen := if(mth_source_rel_fseen_1 = NULL, -999, mth_source_rel_fseen_1);

mth_source_rm_fseen := if(mth_source_rm_fseen_1 = NULL, -999, mth_source_rm_fseen_1);

mth_source_sp_lseen := if(mth_source_sp_lseen_1 = NULL, -999, mth_source_sp_lseen_1);

mth_source_sp_fseen := if(mth_source_sp_fseen_1 = NULL, -999, mth_source_sp_fseen_1);

mth_source_sx_fseen := if(mth_source_sx_fseen_1 = NULL, -999, mth_source_sx_fseen_1);

mth_source_utildid_fseen := if(mth_source_utildid_fseen_1 = NULL, -999, mth_source_utildid_fseen_1);

mth_eda_dt_first_seen := if(mth_eda_dt_first_seen_1 = NULL, -999, mth_eda_dt_first_seen_1);

mth_exp_last_update := if(mth_exp_last_update_1 = NULL, -999, mth_exp_last_update_1);

mth_internal_ver_first_seen := if(mth_internal_ver_first_seen_1 = NULL, -999, mth_internal_ver_first_seen_1);

mth_phone_fb_rp_date := if(mth_phone_fb_rp_date_1 = NULL, -999, mth_phone_fb_rp_date_1);

mth_pp_datefirstseen := if(mth_pp_datefirstseen_1 = NULL, -999, mth_pp_datefirstseen_1);

mth_pp_datelastseen := if(mth_pp_datelastseen_1 = NULL, -999, mth_pp_datelastseen_1);

mth_pp_datevendorfirstseen := if(mth_pp_datevendorfirstseen_1 = NULL, -999, mth_pp_datevendorfirstseen_1);

mth_pp_datevendorlastseen := if(mth_pp_datevendorlastseen_1 = NULL, -999, mth_pp_datevendorlastseen_1);

mth_pp_date_nonglb_lastseen := if(mth_pp_date_nonglb_lastseen_1 = NULL, -999, mth_pp_date_nonglb_lastseen_1);

mth_pp_orig_lastseen := if(mth_pp_orig_lastseen_1 = NULL, -999, mth_pp_orig_lastseen_1);

mth_pp_app_npa_effective_dt := if(mth_pp_app_npa_effective_dt_1 = NULL, -999, mth_pp_app_npa_effective_dt_1);

mth_pp_app_npa_last_change_dt := if(mth_pp_app_npa_last_change_dt_1 = NULL, -999, mth_pp_app_npa_last_change_dt_1);

mth_pp_eda_hist_ph_dt := if(mth_pp_eda_hist_ph_dt_1 = NULL, -999, mth_pp_eda_hist_ph_dt_1);

mth_pp_eda_hist_did_dt := if(mth_pp_eda_hist_did_dt_1 = NULL, -999, mth_pp_eda_hist_did_dt_1);

mth_pp_app_fb_ph_dt := if(mth_pp_app_fb_ph_dt_1 = NULL, -999, mth_pp_app_fb_ph_dt_1);

mth_pp_app_fb_ph7_did_dt := if(mth_pp_app_fb_ph7_did_dt_1 = NULL, -999, mth_pp_app_fb_ph7_did_dt_1);

mth_pp_first_build_date := if(mth_pp_first_build_date_1 = NULL, -999, mth_pp_first_build_date_1);

_phone_match_code_a := (integer)indexw(trim((string)phone_match_code, ALL), 'A', ',');

_phone_match_code_c := (integer)indexw(trim((string)phone_match_code, ALL), 'C', ',');

_phone_match_code_d := (integer)indexw(trim((string)phone_match_code, ALL), 'D', ',');

_phone_match_code_l := (integer)indexw(trim((string)phone_match_code, ALL), 'L', ',');

_phone_match_code_n := (integer)indexw(trim((string)phone_match_code, ALL), 'N', ',');

_phone_match_code_s := (integer)indexw(trim((string)phone_match_code, ALL), 'S', ',');

_phone_match_code_t := (integer)indexw(trim((string)phone_match_code, ALL), 'T', ',');

_phone_match_code_z := (integer)indexw(trim((string)phone_match_code, ALL), 'Z', ',');

_pp_rule_seen_once_1 := 0;

_pp_rule_high_vend_conf_1 := 0;

_pp_rule_low_vend_conf_1 := 0;

_pp_rule_cellphone_latest_1 := 0;

_pp_rule_targ_non_pub_1 := 0;

_pp_rule_med_vend_conf_cell_1 := 0;

_pp_rule_iq_rpc_1 := 0;

_pp_rule_ins_ver_above_1 := 0;

_pp_rule_30_1 := 0;

_pp_rule_seen_once := if(((string)PP_Rules)[6..6] = '1', 1, _pp_rule_seen_once_1);

_pp_rule_high_vend_conf := if(((string)PP_Rules)[7..7] = '1', 1, _pp_rule_high_vend_conf_1);

_pp_rule_low_vend_conf := if(((string)PP_Rules)[8..8] = '1', 1, _pp_rule_low_vend_conf_1);

_pp_rule_cellphone_latest := if(((string)PP_Rules)[9..9] = '1', 1, _pp_rule_cellphone_latest_1);

_pp_rule_targ_non_pub := if(((string)PP_Rules)[11..11] = '1', 1, _pp_rule_targ_non_pub_1);

_pp_rule_med_vend_conf_cell := if(((string)PP_Rules)[15..15] = '1', 1, _pp_rule_med_vend_conf_cell_1);

_pp_rule_iq_rpc := if(((string)PP_Rules)[25..25] = '1', 1, _pp_rule_iq_rpc_1);

_pp_rule_ins_ver_above := if(((string)PP_Rules)[26..26] = '1', 1, _pp_rule_ins_ver_above_1);

_pp_rule_30 := if(((string)PP_Rules)[30..30] = '1', 1, _pp_rule_30_1);

_pp_src_all_eq_1 := 0;

_pp_src_all_uw_1 := 0;

_pp_src_all_iq_1 := 0;

_pp_src_all_tn_1 := 0;

_pp_src_all_ib_1 := 0;

_pp_src_all_48_1 := 0;

_pp_src_all_eq := if(((string)PP_Src_All)[10..10] = '1', 1, _pp_src_all_eq_1);

_pp_src_all_uw := if(((string)PP_Src_All)[14..14] = '1', 1, _pp_src_all_uw_1);

_pp_src_all_iq := if(((string)PP_Src_All)[42..42] = '1', 1, _pp_src_all_iq_1);

_pp_src_all_tn := if(((string)PP_Src_All)[43..43] = '1', 1, _pp_src_all_tn_1);

_pp_src_all_ib := if(((string)PP_Src_All)[44..44] = '1', 1, _pp_src_all_ib_1);

_pp_src_all_48 := if(((string)PP_Src_All)[48..48] = '1', 1, _pp_src_all_48_1);

_pp_app_nonpub_gong_la_1 := 0;

_pp_app_nonpub_targ_la_1 := 0;

_pp_app_nonpub_targ_lap_1 := 0;

_pp_app_nonpub_gong_la := if(((string)PP_app_NonPublished_Match)[1..1] = '1', 1, _pp_app_nonpub_gong_la_1);

_pp_app_nonpub_targ_la := if(((string)PP_app_NonPublished_Match)[5..5] = '1', 1, _pp_app_nonpub_targ_la_1);

_pp_app_nonpub_targ_lap := if(((string)PP_app_NonPublished_Match)[6..6] = '1', 1, _pp_app_nonpub_targ_lap_1);

_pp_app_ported_match_7_1 := 0;

_pp_app_ported_match_7 := if(((string)PP_app_Ported_Match)[2..2] = '1', 1, _pp_app_ported_match_7_1);

inq_firstseen_n_1 := inq_firstseen;

inq_firstseen_n := if(inq_firstseen_n_1 = '', -999, (integer)inq_firstseen_n_1);	//kh-changed NULL to ''

inq_lastseen_n_1 := inq_lastseen;

inq_lastseen_n := if(inq_lastseen_n_1 = '', -999, (integer)inq_lastseen_n_1);	//kh-changed NULL to ''

inq_adl_firstseen_n_1 := inq_adl_firstseen;

inq_adl_firstseen_n := if(inq_adl_firstseen_n_1 = '', -999, (integer)inq_adl_firstseen_n_1);	//kh-changed NULL to ''

inq_adl_lastseen_n_1 := inq_adl_lastseen;

inq_adl_lastseen_n := if(inq_adl_lastseen_n_1 = '', -999, (integer)inq_adl_lastseen_n_1);	//kh-changed NULL to ''

_internal_ver_match_lexid := (integer)indexw(trim((string)internal_ver_match_types, ALL), '1', ',');

_internal_ver_match_spouse := (integer)indexw(trim((string)internal_ver_match_types, ALL), '2', ',');

_internal_ver_match_hhid := (integer)indexw(trim((string)internal_ver_match_types, ALL), '3', ',');

_internal_ver_match_level := map(
    _internal_ver_match_LexID = 1 and _internal_ver_match_Spouse = 1 => 3,
    _internal_ver_match_LexID = 1 and _internal_ver_match_HHID = 0   => 2,
    _internal_ver_match_LexID = 1                                    => 1,
                                                                        0);

// _inq_adl_ph_industry_auto := (integer)indexw(trim((string)inq_adl_ph_industry_list_12, ALL), 'AUTO', ',');
_inq_adl_ph_industry_auto := (integer)(StringLib.StringFind(trim((string)inq_adl_ph_industry_list_12, ALL), 'AUTO', 1) > 0);

// _inq_adl_ph_industry_cards := (integer)indexw(trim((string)inq_adl_ph_industry_list_12, ALL), 'CARDS', ','); //kh-changed indexw to stringfind to match 'CARDS' to 'SM-CARDS'
_inq_adl_ph_industry_cards := (integer)(StringLib.StringFind(trim((string)inq_adl_ph_industry_list_12, ALL), 'CARDS', 1) > 0);
														
_inq_adl_ph_industry_flag := (integer)(inq_adl_ph_industry_list_12 != '');

_pp_agegroup := map(
    pp_agegroup < 31 => 0,
    pp_agegroup < 41 => 1,
                        2);

_pp_app_nxx_type := map(
    pp_app_nxx_type < 1  => 0,
    pp_app_nxx_type < 2  => 1,
    pp_app_nxx_type < 4  => 2,
    pp_app_nxx_type < 18 => 3,
    pp_app_nxx_type < 50 => 4,
    pp_app_nxx_type < 51 => 5,
    pp_app_nxx_type < 52 => 6,
    pp_app_nxx_type < 53 => 7,
    pp_app_nxx_type < 54 => 8,
    pp_app_nxx_type < 55 => 9,
    pp_app_nxx_type < 60 => 10,
    pp_app_nxx_type < 65 => 11,
    pp_app_nxx_type < 66 => 12,
    pp_app_nxx_type < 77 => 13,
                            14);

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

_phone_match_code_lns := (integer)(if(max((integer)_phone_match_code_l, (integer)_phone_match_code_n, (integer)_phone_match_code_s) = NULL, NULL, sum((integer)_phone_match_code_l, (integer)_phone_match_code_n, (integer)_phone_match_code_s)) > 0);

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

_pp_app_nxx_type_cell := if((pp_app_nxx_type in [4, 55, 65]), 1, 0);

_pp_app_ph_type_cell := if((trim(trim((string)PP_app_ph_Type, LEFT), LEFT, RIGHT) in ['CELL', 'LNDLN PRTD TO CELL']), 1, 0);

_pp_app_company_type_cell := if((PP_app_Company_Type in [5, 8]), 1, 0);

_exp_type_cell := if(trim(trim((string)Exp_Type, LEFT), LEFT, RIGHT) = 'C', 1, 0);

pk_cell_indicator := map(
    _exp_type_cell > 0 and if(max(_phone_switch_type_cell, _pp_rule_cellphone_latest, _pp_rule_med_vend_conf_cell, _pp_app_coctype_cell, _pp_app_nxx_type_cell, _pp_app_ph_type_cell, _pp_app_company_type_cell) = NULL, NULL, sum(if(_phone_switch_type_cell = NULL, 0, _phone_switch_type_cell), if(_pp_rule_cellphone_latest = NULL, 0, _pp_rule_cellphone_latest), if(_pp_rule_med_vend_conf_cell = NULL, 0, _pp_rule_med_vend_conf_cell), if(_pp_app_coctype_cell = NULL, 0, _pp_app_coctype_cell), if(_pp_app_nxx_type_cell = NULL, 0, _pp_app_nxx_type_cell), if(_pp_app_ph_type_cell = NULL, 0, _pp_app_ph_type_cell), if(_pp_app_company_type_cell = NULL, 0, _pp_app_company_type_cell))) > 0 => 4,
    if(max(_phone_switch_type_cell, _pp_rule_cellphone_latest, _pp_rule_med_vend_conf_cell, _pp_app_coctype_cell, _pp_app_nxx_type_cell, _pp_app_ph_type_cell, _pp_app_company_type_cell) = NULL, NULL, sum(if(_phone_switch_type_cell = NULL, 0, _phone_switch_type_cell), if(_pp_rule_cellphone_latest = NULL, 0, _pp_rule_cellphone_latest), if(_pp_rule_med_vend_conf_cell = NULL, 0, _pp_rule_med_vend_conf_cell), if(_pp_app_coctype_cell = NULL, 0, _pp_app_coctype_cell), if(_pp_app_nxx_type_cell = NULL, 0, _pp_app_nxx_type_cell), if(_pp_app_ph_type_cell = NULL, 0, _pp_app_ph_type_cell), if(_pp_app_company_type_cell = NULL, 0, _pp_app_company_type_cell))) = 7                        => 3,
    _phone_switch_type_cell = 1 and _pp_rule_cellphone_latest = 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       => 2,
    _phone_switch_type_cell = 1 and _pp_rule_med_vend_conf_cell = 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     => 1,
    _pp_app_coctype_landline = 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        => -1,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           0);

pk_cell_flag := if(pk_cell_indicator > 0, 1, 0);

_pp_glb_dppa_fl_glb := if(trim(trim((string)pp_glb_dppa_fl, LEFT), LEFT, RIGHT) = trim(trim('G', LEFT), LEFT, RIGHT), 1, 0);

_pp_origlistingtype_res := if(trim(trim((string)pp_origlistingtype, LEFT), LEFT, RIGHT) = trim(trim('R', LEFT), LEFT, RIGHT), 1, 0);

pk_exp_hit := if(exp_verified = 0 and trim(trim((string)exp_type, LEFT), LEFT, RIGHT) = '' and trim(trim((string)exp_source, LEFT), LEFT, RIGHT) = '' and trim(trim((string)exp_last_update, LEFT), LEFT, RIGHT) = '' and ((integer)exp_ph_score_v1 < 0 or exp_ph_score_v1 = ''), 0, 1);	//kh-check exp_ph_score_v1 for <0 and ''

segment := map(
    pk_exp_hit = 1          => '3 - ExpHit      ',
    pk_cell_flag = 1        => '2 - Cell Phone  ',
    _phone_disconnected = 1 => '0 - Disconnected',
                               '1 - Other       ');

util_add_input_type_list_1 := util_add1_type_list;

util_add_curr_type_list_1 := if(add1_isbestmatch, util_add1_type_list, util_add2_type_list);

add_input_occupants_1yr_1 := add1_occupants_1yr;

add_input_turnover_1yr_in_1 := add1_turnover_1yr_in;

add_input_turnover_1yr_out_1 := add1_turnover_1yr_in;	//kh-asked Pete about this (in vs out) he said it's a bug but can't change now

add_curr_occupants_1yr_1 := if(add1_isbestmatch, add1_occupants_1yr, add2_occupants_1yr);

add_curr_turnover_1yr_in_1 := if(add1_isbestmatch, add1_turnover_1yr_in, add2_turnover_1yr_in);

// add_curr_turnover_1yr_out_1 := if(add1_isbestmatch, add1_turnover_1yr_out, add2_turnover_1yr_out);
add_curr_turnover_1yr_out_1 := if(add1_isbestmatch, add1_turnover_1yr_in, add2_turnover_1yr_in); //kh-had to change to 'in' to validate

college_income_level_code_1 := ams_income_level_code;

r_nas_addr_verd_d := (integer)(nas_summary in [3, 5, 6, 8, 10, 11, 12]);

r_pb_order_freq_d := map(
    not(truedid)                     			=> NULL,
    pb_number_of_sources = 0  						=> NULL,
    pb_average_days_bt_orders = '' 				=> -1,	//kh-casting changes for pb_average_days_bt_orders
                                        min(if(pb_average_days_bt_orders = '0', 0, (integer)pb_average_days_bt_orders), 999));

f_bus_fname_verd_d := if(not(addrpop), NULL, (integer)(bus_name_match in [2, 4]));

f_bus_name_nover_i := if(not(addrpop), NULL, (integer)(bus_name_match = 1));

f_adl_util_inf_n := (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_adl_type_list), '1', 1) > 0);

f_adl_util_conv_n := (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_adl_type_list), '2', 1) > 0);

f_adl_util_misc_n := (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_adl_type_list), 'Z', 1) > 0);

f_util_add_input_inf_n := (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_add_input_type_list_1), '1', 1) > 0);

f_util_add_input_conv_n := (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_add_input_type_list_1), '2', 1) > 0);

f_util_add_input_misc_n := (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_add_input_type_list_1), 'Z', 1) > 0);

f_util_add_curr_conv_n := (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_add_curr_type_list_1), '2', 1) > 0);

f_util_add_curr_misc_n := (integer)(Stringlib.StringFind(StringLib.StringToUpperCase(util_add_curr_type_list_1), 'Z', 1) > 0);

f_add_input_mobility_index_n := map(
    not(addrpop)                   => NULL,
    add_input_occupants_1yr_1 <= 0 => NULL,
                                      if(max(add_input_turnover_1yr_in_1, add_input_turnover_1yr_out_1) = NULL, NULL, sum(if(add_input_turnover_1yr_in_1 = NULL, 0, add_input_turnover_1yr_in_1), if(add_input_turnover_1yr_out_1 = NULL, 0, add_input_turnover_1yr_out_1))) / add_input_occupants_1yr_1);

f_add_curr_mobility_index_n := map(
    not(addrpop)                  => NULL,
    add_curr_occupants_1yr_1 <= 0 => NULL, 
                                     if(max(add_curr_turnover_1yr_in_1, add_curr_turnover_1yr_out_1) = NULL, NULL, sum(if(add_curr_turnover_1yr_in_1 = NULL, 0, add_curr_turnover_1yr_in_1), if(add_curr_turnover_1yr_out_1 = NULL, 0, add_curr_turnover_1yr_out_1))) / add_curr_occupants_1yr_1);

f_inq_count_i := if(not(truedid), NULL, min(if(inq_count = NULL, -NULL, inq_count), 999));

f_inq_count24_i := if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999));

f_inq_per_ssn_i := if(not(ssnlength > 0), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999));

f_inq_addrs_per_ssn_i := if(not(ssnlength > 0), NULL, min(if(inq_addrsperssn = NULL, -NULL, inq_addrsperssn), 999));

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

f_foreclosure_flag_i := if(not(truedid), NULL, foreclosure_flag);

f_estimated_income_d := if(not(truedid), NULL, estimated_income);

f_wealth_index_d := if(not(truedid), NULL, wealth_index);

f_college_income_d := map(
    not(truedid)                       => NULL,
    college_income_level_code_1 = '' => NULL,	
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

f_rel_ageover60_count_d := map(
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

f_accident_count_i := if(not(truedid), NULL, min(if(acc_count = NULL, -NULL, acc_count), 999));

f_acc_damage_amt_total_i := if(not(truedid), NULL, acc_damage_amt_total);

_acc_last_seen := models.common.sas_date((string)(acc_last_seen));

f_mos_acc_lseen_d := map(
    not(truedid)          => NULL,
    _acc_last_seen = NULL => 1000,
                             max(3, min(if(if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12)))), 999)));

f_acc_damage_amt_last_i := if(not(truedid), NULL, acc_damage_amt_last);

f_idrisktype_i := if(not(truedid) or fp_idrisktype = NULL, NULL, fp_idrisktype);

f_idverrisktype_i := if(not(truedid) or fp_idverrisktype = NULL, NULL, fp_idverrisktype);

f_sourcerisktype_i := map(
    not(truedid)             => NULL,
    fp_sourcerisktype = NULL => NULL,
                                fp_sourcerisktype);

f_varrisktype_i := map(
    not(truedid)          => NULL,
    fp_varrisktype = NULL => NULL,
                             fp_varrisktype);

f_vardobcount_i := if(not(truedid), NULL, min(if(fp_vardobcount = NULL, -NULL, fp_vardobcount), 999));

f_vardobcountnew_i := if(not(truedid), NULL, min(if(fp_vardobcountnew = NULL, -NULL, fp_vardobcountnew), 999));

f_srchvelocityrisktype_i := map(
    not(truedid)                   => NULL,
    fp_srchvelocityrisktype = NULL => NULL,
                                      fp_srchvelocityrisktype);

f_srchcountwk_i := if(not(truedid), NULL, min(if(fp_srchcountwk = NULL, -NULL, fp_srchcountwk), 999));

f_srchunvrfdaddrcount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdaddrcount = NULL, -NULL, fp_srchunvrfdaddrcount), 999));

f_srchunvrfddobcount_i := if(not(truedid), NULL, min(if(fp_srchunvrfddobcount = NULL, -NULL, fp_srchunvrfddobcount), 999));

f_srchunvrfdphonecount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = NULL, -NULL, fp_srchunvrfdphonecount), 999));

f_srchfraudsrchcount_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcount = NULL, -NULL, fp_srchfraudsrchcount), 999));

f_srchfraudsrchcountyr_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountyr = NULL, -NULL, fp_srchfraudsrchcountyr), 999));

f_assocrisktype_i := map(
    not(truedid)            => NULL,
    fp_assocrisktype = NULL => NULL,
                               fp_assocrisktype);

f_assocsuspicousidcount_i := if(not(truedid), NULL, min(if(fp_assocsuspicousidcount = NULL, -NULL, fp_assocsuspicousidcount), 999));

f_assoccredbureaucount_i := if(not(truedid), NULL, min(if(fp_assoccredbureaucount = NULL, -NULL, fp_assoccredbureaucount), 999));

f_validationrisktype_i := map(
    not(truedid)                 => NULL,
    fp_validationrisktype = NULL => NULL,
                                    fp_validationrisktype);

f_corrrisktype_i := map(
    not(truedid)           => NULL,
    fp_corrrisktype = NULL => NULL,
                              fp_corrrisktype);

f_corrssnnamecount_d := if(not(truedid), NULL, min(if(fp_corrssnnamecount = NULL, -NULL, fp_corrssnnamecount), 999));

f_corrssnaddrcount_d := if(not(truedid), NULL, min(if(fp_corrssnaddrcount = NULL, -NULL, fp_corrssnaddrcount), 999));

f_corraddrnamecount_d := if(not(truedid), NULL, min(if(fp_corraddrnamecount = NULL, -NULL, fp_corraddrnamecount), 999));

f_corrphonelastnamecount_d := if(not(truedid), NULL, min(if(fp_corrphonelastnamecount = NULL, -NULL, fp_corrphonelastnamecount), 999));

f_divrisktype_i := map(
    not(truedid)          => NULL,
    fp_divrisktype = NULL => NULL,
                             fp_divrisktype);

f_divssnidmsrcurelcount_i := if(not(truedid), NULL, min(if(fp_divssnidmsrcurelcount = NULL, -NULL, fp_divssnidmsrcurelcount), 999));

f_divaddrsuspidcountnew_i := if(not(truedid), NULL, min(if(fp_divaddrsuspidcountnew = NULL, -NULL, fp_divaddrsuspidcountnew), 999));

f_srchssnsrchcount_i := if(not(truedid), NULL, min(if(fp_srchssnsrchcount = NULL, -NULL, fp_srchssnsrchcount), 999));

f_srchaddrsrchcount_i := if(not(truedid), NULL, min(if(fp_srchaddrsrchcount = NULL, -NULL, fp_srchaddrsrchcount), 999));

f_srchaddrsrchcountmo_i := if(not(truedid), NULL, min(if(fp_srchaddrsrchcountmo = NULL, -NULL, fp_srchaddrsrchcountmo), 999));

f_srchaddrsrchcountwk_i := if(not(truedid), NULL, min(if(fp_srchaddrsrchcountwk = NULL, -NULL, fp_srchaddrsrchcountwk), 999));

f_componentcharrisktype_i := map(
    not(truedid)                    => NULL,
    fp_componentcharrisktype = NULL => NULL,
                                       fp_componentcharrisktype);

f_inputaddractivephonelist_d := map(
    not(truedid)                     => NULL,
    fp_inputaddractivephonelist = -1 => NULL, 
                                        fp_inputaddractivephonelist);

f_addrchangeincomediff_d_1 := if(not(truedid), NULL, NULL);

f_addrchangeincomediff_d := if(fp_addrchangeincomediff = -1, NULL, fp_addrchangeincomediff);

f_addrchangevaluediff_d := map(
    not(truedid)                => NULL,
    fp_addrchangevaluediff = -1 => NULL, 
                                   fp_addrchangevaluediff);

f_addrchangecrimediff_i := map(
    not(truedid)                => NULL,
    fp_addrchangecrimediff = -1 => NULL, 
                                   fp_addrchangecrimediff);

f_addrchangeecontrajindex_d := if(not(truedid) or fp_addrchangeecontrajindex = NULL /*or f_addrchangeecontrajindex_d = -1*/, NULL, fp_addrchangeecontrajindex);

f_curraddractivephonelist_d := map(
    not(truedid)                    => NULL,
    fp_curraddractivephonelist = -1 => NULL, 
                                       fp_curraddractivephonelist);

f_curraddrmedianincome_d := if(not(truedid), NULL, fp_curraddrmedianincome);

f_curraddrmedianvalue_d := if(not(truedid), NULL, fp_curraddrmedianvalue);

f_curraddrmurderindex_i := if(not(truedid), NULL, fp_curraddrmurderindex);

f_curraddrcartheftindex_i := if(not(truedid), NULL, fp_curraddrcartheftindex);

f_curraddrburglaryindex_i := if(not(truedid), NULL, fp_curraddrburglaryindex);

f_curraddrcrimeindex_i := if(not(truedid), NULL, fp_curraddrcrimeindex);

f_prevaddrageoldest_d := if(not(truedid), NULL, min(if(fp_prevaddrageoldest = NULL, -NULL, fp_prevaddrageoldest), 999));

f_prevaddrlenofres_d := if(not(truedid), NULL, min(if(fp_prevaddrlenofres = NULL, -NULL, fp_prevaddrlenofres), 999));

f_prevaddrdwelltype_apt_n := if(not(truedid), NULL, (integer)(fp_prevaddrdwelltype = 'H'));

f_prevaddrstatus_i := map(
    not(truedid)            => NULL,
    fp_prevaddrstatus = '0' => 1,
    fp_prevaddrstatus = 'U' => 2,
    fp_prevaddrstatus = 'R' => 3,
                               NULL);	

f_prevaddroccupantowned_d := map(
    not(truedid)                    => NULL,
    fp_prevaddroccupantowned = NULL => NULL,
                                       fp_prevaddroccupantowned);

f_prevaddrmedianincome_d := if(not(truedid), NULL, fp_prevaddrmedianincome);

f_prevaddrmedianvalue_d := if(not(truedid), NULL, fp_prevaddrmedianvalue);

f_prevaddrmurderindex_i := if(not(truedid), NULL, fp_prevaddrmurderindex);

f_prevaddrcartheftindex_i := if(not(truedid), NULL, fp_prevaddrcartheftindex);

f_fp_prevaddrburglaryindex_i := if(not(truedid), NULL, fp_prevaddrburglaryindex);

f_fp_prevaddrcrimeindex_i := if(not(truedid), NULL, fp_prevaddrcrimeindex);

r_has_paw_source_d := if(paw_source_count > 0, 1, 0);

_paw_first_seen := models.common.sas_date((string)(paw_first_seen));

r_mos_since_paw_fseen_d := map(
    not(truedid)                => NULL,
    not(_paw_first_seen = NULL) => min(if(if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen) / (365.25 / 12)), roundup((sysdate - _paw_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen) / (365.25 / 12)), roundup((sysdate - _paw_first_seen) / (365.25 / 12)))), 240),
                                   -1);

r_paw_dead_business_ct_i := if(not(truedid), NULL, paw_dead_business_count);

r_paw_active_phone_ct_d := if(not(truedid), NULL, paw_active_phone_count);

//Begin original ECL code from Pete
   final_score_0 :=  -1.2915126913;

// Tree: 1 
final_score_1 := map(
(NULL < f_inq_per_addr_i and f_inq_per_addr_i <= 14.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 223558) => 0.0475057328,
   (f_curraddrmedianvalue_d > 223558) => -0.0786162451,
   (f_curraddrmedianvalue_d = NULL) => 0.0101374459, 0.0101374459),
(f_inq_per_addr_i > 14.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 79) => 0.2240524408,
   (f_prevaddrcartheftindex_i > 79) => -0.5942613142,
   (f_prevaddrcartheftindex_i = NULL) => -0.3770785167, -0.3770785167),
(f_inq_per_addr_i = NULL) => 0.0000207336, 0.0000207336);

// Tree: 2 
final_score_2 := map(
(NULL < eda_address_match_best and eda_address_match_best <= 0.5) => -0.0139362637,
(eda_address_match_best > 0.5) => 
   map(
   (NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 22) => 
      map(
      (phone_subject_title in ['Associate','Father','Husband','Mother','Neighbor','Son']) => -0.2655735596,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Parent','Relative','Sibling','Sister','Spouse','Subject','Subject at Household','Wife']) => 0.4806277188,
      (phone_subject_title = '') => 0.2234418413, 0.2234418413),
   (mth_source_cr_fseen > 22) => -0.3792656327,
   (mth_source_cr_fseen = NULL) => 0.1479434528, 0.1479434528),
(eda_address_match_best = NULL) => -0.0044952847, -0.0044952847);

// Tree: 3 
final_score_3 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 407096) => -0.0290080217,
(f_prevaddrmedianvalue_d > 407096) => 
   map(
   (phone_subject_title in ['Associate By Address','Father','Husband','Neighbor','Relative']) => -0.3385381373,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Parent','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 18.5) => 0.3149798756,
      (f_rel_incomeover50_count_d > 18.5) => -0.4432247935,
      (f_rel_incomeover50_count_d = NULL) => 0.2319096430, 0.2319096430),
   (phone_subject_title = '') => 0.0618876026, 0.0618876026),
(f_prevaddrmedianvalue_d = NULL) => -0.0209259092, -0.0209259092);

// Tree: 4 
final_score_4 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 17.5) => 0.0112839054,
(mth_source_ppdid_lseen > 17.5) => 
   map(
   (NULL < _pp_src_all_ib and _pp_src_all_ib <= 0.5) => 
      map(
      (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 19.5) => -0.4606764177,
      (mth_pp_datefirstseen > 19.5) => -0.1061660827,
      (mth_pp_datefirstseen = NULL) => -0.1704149659, -0.1704149659),
   (_pp_src_all_ib > 0.5) => 0.3277740337,
   (_pp_src_all_ib = NULL) => -0.1303743949, -0.1303743949),
(mth_source_ppdid_lseen = NULL) => -0.0094491445, -0.0094491445);

// Tree: 5 
final_score_5 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 11.5) => -0.0130218425,
(f_corraddrnamecount_d > 11.5) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Child','Daughter','Grandson','Husband','Mother','Sibling','Sister','Spouse']) => -0.4502643803,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Vehicle','Brother','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Neighbor','Parent','Relative','Son','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_wealth_index_d and f_wealth_index_d <= 3.5) => 0.3881375207,
      (f_wealth_index_d > 3.5) => 0.0632165257,
      (f_wealth_index_d = NULL) => 0.1941292119, 0.1941292119),
   (phone_subject_title = '') => 0.1065917262, 0.1065917262),
(f_corraddrnamecount_d = NULL) => -0.0000474138, -0.0000474138);

// Tree: 6 
final_score_6 := map(
(NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 12.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 94.5) => -0.0323363787,
   (f_addrchangecrimediff_i > 94.5) => 0.2343102497,
   (f_addrchangecrimediff_i = NULL) => -0.0844052520, -0.0340408500),
(f_rel_ageover30_count_d > 12.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Grandfather','Grandmother','Grandparent','Neighbor','Parent','Relative','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => 0.0129890261,
   (phone_subject_title in ['Associate By SSN','Brother','Daughter','Father','Grandchild','Granddaughter','Grandson','Husband','Mother','Spouse']) => 0.3562002667,
   (phone_subject_title = '') => 0.0453233428, 0.0453233428),
(f_rel_ageover30_count_d = NULL) => -0.0079999361, -0.0079999361);

// Tree: 7 
final_score_7 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.42191458243518) => 0.0366685922,
(f_add_input_mobility_index_n > 0.42191458243518) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 0.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 23929.5) => -0.0130814394,
      (f_addrchangevaluediff_d > 23929.5) => -0.2394235652,
      (f_addrchangevaluediff_d = NULL) => -0.3213103788, -0.1389327408),
   (f_rel_homeover300_count_d > 0.5) => 0.0010034615,
   (f_rel_homeover300_count_d = NULL) => -0.0700900007, -0.0700900007),
(f_add_input_mobility_index_n = NULL) => 0.1723729035, -0.0000067907);

// Tree: 8 
final_score_8 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 3.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Grandfather','Grandmother','Grandson','Husband','Neighbor','Relative','Sibling','Sister']) => -0.0275550135,
   (phone_subject_title in ['Associate By Property','Brother','Daughter','Father','Grandchild','Granddaughter','Grandparent','Mother','Parent','Son','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 276) => 0.1828053836,
      (r_pb_order_freq_d > 276) => 0.6149715274,
      (r_pb_order_freq_d = NULL) => 0.0757544716, 0.1657797189),
   (phone_subject_title = '') => 0.0655621346, 0.0655621346),
(f_inq_count_i > 3.5) => -0.0206089089,
(f_inq_count_i = NULL) => -0.0002693413, -0.0002693413);

// Tree: 9 
final_score_9 := map(
(NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 11.5) => 0.0208072206,
   (inq_adl_lastseen_n > 11.5) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 1.5) => 0.4538531566,
      (f_inq_count24_i > 1.5) => 0.0717619996,
      (f_inq_count24_i = NULL) => 0.1852094928, 0.1852094928),
   (inq_adl_lastseen_n = NULL) => 0.0364840851, 0.0364840851),
(f_sourcerisktype_i > 4.5) => -0.0373139250,
(f_sourcerisktype_i = NULL) => 0.0030350799, 0.0030350799);

// Tree: 10 
final_score_10 := map(
(NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 4.5) => 0.0166360449,
(mth_internal_ver_first_seen > 4.5) => 
   map(
   (NULL < f_wealth_index_d and f_wealth_index_d <= 2.5) => -0.1953909735,
   (f_wealth_index_d > 2.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 94) => -0.1011274090,
      (f_curraddrcrimeindex_i > 94) => 0.1036793587,
      (f_curraddrcrimeindex_i = NULL) => -0.0105181992, -0.0105181992),
   (f_wealth_index_d = NULL) => -0.0645689715, -0.0645689715),
(mth_internal_ver_first_seen = NULL) => -0.0066817403, -0.0066817403);

// Tree: 11 
final_score_11 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 157.5) => 0.0369655435,
(f_curraddrcartheftindex_i > 157.5) => 
   map(
   (NULL < mth_source_sx_fseen and mth_source_sx_fseen <= 10.5) => 
      map(
      (pp_source in ['GONG','IBEHAVIOR','INFUTOR','INQUIRY','OTHER','THRIVE']) => -0.1479129447,
      (pp_source in ['CELL','HEADER','INTRADO','PCNSR','TARGUS']) => 0.0737370653,
      (pp_source = '') => 0.0362620812, -0.0212120431),
   (mth_source_sx_fseen > 10.5) => -0.3049709963,
   (mth_source_sx_fseen = NULL) => -0.0342534900, -0.0342534900),
(f_curraddrcartheftindex_i = NULL) => 0.0195047106, 0.0195047106);

// Tree: 12 
final_score_12 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0181879316,
(source_utildid > 0.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 8.5) => 0.4339676437,
   (mth_source_utildid_fseen > 8.5) => 
      map(
      (NULL < f_inq_addrs_per_ssn_i and f_inq_addrs_per_ssn_i <= 1.5) => 0.0599775812,
      (f_inq_addrs_per_ssn_i > 1.5) => -0.4736328734,
      (f_inq_addrs_per_ssn_i = NULL) => 0.0213101570, 0.0213101570),
   (mth_source_utildid_fseen = NULL) => 0.0660946904, 0.0660946904),
(source_utildid = NULL) => -0.0101103251, -0.0101103251);

// Tree: 13 
final_score_13 := map(
(NULL < source_sx and source_sx <= 0.5) => -0.0031752894,
(source_sx > 0.5) => 
   map(
   (NULL < eda_address_match_best and eda_address_match_best <= 0.5) => 
      map(
      (phone_subject_title in ['Associate','Brother','Father','Grandmother','Grandson','Husband','Mother','Relative']) => -0.0722697441,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandparent','Neighbor','Parent','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 0.3649192976,
      (phone_subject_title = '') => 0.2460717911, 0.2460717911),
   (eda_address_match_best > 0.5) => -0.0197443033,
   (eda_address_match_best = NULL) => 0.1022114104, 0.1022114104),
(source_sx = NULL) => 0.0026838770, 0.0026838770);

// Tree: 14 
final_score_14 := map(
(NULL < inq_num and inq_num <= 0.5) => 
   map(
   (NULL < source_utildid and source_utildid <= 0.5) => -0.0286933201,
   (source_utildid > 0.5) => 
      map(
      (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 12.5) => 0.6047763403,
      (mth_source_utildid_fseen > 12.5) => -0.0143382856,
      (mth_source_utildid_fseen = NULL) => 0.1070300001, 0.1070300001),
   (source_utildid = NULL) => -0.0200645024, -0.0200645024),
(inq_num > 0.5) => 0.0844168164,
(inq_num = NULL) => -0.0079681635, -0.0079681635);

// Tree: 15 
final_score_15 := map(
(NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 0.5) => 
   map(
   (NULL < mth_pp_datevendorlastseen and mth_pp_datevendorlastseen <= 34.5) => -0.0315897716,
   (mth_pp_datevendorlastseen > 34.5) => 0.3749273511,
   (mth_pp_datevendorlastseen = NULL) => -0.0233004942, -0.0233004942),
(f_rel_ageover50_count_d > 0.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 33880.5) => 0.1081770150,
   (f_addrchangeincomediff_d > 33880.5) => -0.1860911608,
   (f_addrchangeincomediff_d = NULL) => 0.0026913932, 0.0542818352),
(f_rel_ageover50_count_d = NULL) => -0.0029429681, -0.0029429681);

// Tree: 16 
final_score_16 := map(
(NULL < f_estimated_income_d and f_estimated_income_d <= 25500) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 46166.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 137) => -0.3154208692,
      (f_prevaddrmurderindex_i > 137) => 0.2740451490,
      (f_prevaddrmurderindex_i = NULL) => 0.0650810050, 0.0650810050),
   (f_curraddrmedianincome_d > 46166.5) => 0.6660488285,
   (f_curraddrmedianincome_d = NULL) => 0.1908064911, 0.1908064911),
(f_estimated_income_d > 25500) => -0.0170790134,
(f_estimated_income_d = NULL) => -0.0109261173, -0.0109261173);

// Tree: 17 
final_score_17 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 0.5) => 
   map(
   (NULL < eda_min_days_interrupt and eda_min_days_interrupt <= 0.5) => 
      map(
      (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 13.5) => 0.5941923037,
      (mth_pp_datefirstseen > 13.5) => 0.0824335554,
      (mth_pp_datefirstseen = NULL) => 0.3436069855, 0.3436069855),
   (eda_min_days_interrupt > 0.5) => -0.1120544054,
   (eda_min_days_interrupt = NULL) => 0.1460350543, 0.1460350543),
(f_rel_under25miles_cnt_d > 0.5) => -0.0160018011,
(f_rel_under25miles_cnt_d = NULL) => -0.0108462660, -0.0108462660);

// Tree: 18 
final_score_18 := map(
(NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 54.5) => 0.0420605621,
(eda_avg_days_interrupt > 54.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 4) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Relative','Sibling','Sister','Spouse','Subject','Wife']) => -0.0534454001,
      (phone_subject_title in ['Associate By Property','Associate By SSN','Father','Grandchild','Granddaughter','Parent','Son','Subject at Household']) => 0.2050113623,
      (phone_subject_title = '') => -0.0330917879, -0.0330917879),
   (mth_source_utildid_fseen > 4) => -0.3625472678,
   (mth_source_utildid_fseen = NULL) => -0.0475063314, -0.0475063314),
(eda_avg_days_interrupt = NULL) => 0.0156984390, 0.0156984390);

// Tree: 19 
final_score_19 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 45.5) => 0.4157371524,
(f_mos_inq_banko_am_lseen_d > 45.5) => 
   map(
   (NULL < inq_num and inq_num <= 5.5) => 0.0022432952,
   (inq_num > 5.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 10.5) => -0.4148359122,
      (f_rel_educationover12_count_d > 10.5) => 0.0198652249,
      (f_rel_educationover12_count_d = NULL) => -0.1762405512, -0.1762405512),
   (inq_num = NULL) => -0.0007143863, -0.0007143863),
(f_mos_inq_banko_am_lseen_d = NULL) => 0.0018639417, 0.0018639417);

// Tree: 20 
final_score_20 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 9.5) => 0.0218196693,
(f_srchaddrsrchcount_i > 9.5) => 
   map(
   (NULL < eda_num_ph_owners_hist and eda_num_ph_owners_hist <= 2.5) => -0.1219412284,
   (eda_num_ph_owners_hist > 2.5) => 
      map(
      (NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 12.5) => 0.5912682363,
      (mth_eda_dt_first_seen > 12.5) => -0.0946382370,
      (mth_eda_dt_first_seen = NULL) => 0.1180227220, 0.1180227220),
   (eda_num_ph_owners_hist = NULL) => -0.0881039472, -0.0881039472),
(f_srchaddrsrchcount_i = NULL) => -0.0002875695, -0.0002875695);

// Tree: 21 
final_score_21 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 53736.5) => 0.0067896892,
(f_addrchangeincomediff_d > 53736.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Daughter','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Subject at Household']) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 13.5) => 0.2493654140,
      (f_rel_count_i > 13.5) => -0.4145969966,
      (f_rel_count_i = NULL) => -0.0641723910, -0.0641723910),
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Spouse','Subject','Wife']) => 0.3445556309,
   (phone_subject_title = '') => 0.1137445126, 0.1137445126),
(f_addrchangeincomediff_d = NULL) => -0.0464261767, -0.0031371748);

// Tree: 22 
final_score_22 := map(
(pp_app_ph_use in ['B','P']) => 
   map(
   (NULL < _pp_glb_dppa_fl_glb and _pp_glb_dppa_fl_glb <= 0.5) => 0.0524501555,
   (_pp_glb_dppa_fl_glb > 0.5) => -0.1141518777,
   (_pp_glb_dppa_fl_glb = NULL) => -0.0308508611, -0.0308508611),
(pp_app_ph_use in ['O']) => 
   map(
   (pp_source in ['CELL','GONG','IBEHAVIOR','INFUTOR','INTRADO','OTHER']) => -0.1352117386,
   (pp_source in ['HEADER','INQUIRY','PCNSR','TARGUS','THRIVE']) => 0.0708649747,
   (pp_source = '') => 0.0354486749, 0.0354486749),
(pp_app_ph_use = '') => -0.0047149350, 0.0003960849);

// Tree: 23 
final_score_23 := map(
(NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 
   map(
   (phone_subject_title in ['Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandmother','Grandparent','Grandson','Neighbor','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => -0.0819905359,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Father','Grandchild','Granddaughter','Grandfather','Husband','Mother','Parent']) => 0.0637183036,
   (phone_subject_title = '') => -0.0348833403, -0.0348833403),
(f_prevaddrstatus_i > 2.5) => 0.0052650864,
(f_prevaddrstatus_i = NULL) => 
   map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 20.5) => 0.0535719158,
   (f_rel_incomeover50_count_d > 20.5) => -0.3687960995,
   (f_rel_incomeover50_count_d = NULL) => 0.0384663249, 0.0384663249), -0.0053498979);

// Tree: 24 
final_score_24 := map(
(NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 92) => -0.0437107816,
(f_prevaddrmurderindex_i > 92) => 
   map(
   (NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 172.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 35782) => -0.1105292540,
      (f_curraddrmedianincome_d > 35782) => 0.2315851675,
      (f_curraddrmedianincome_d = NULL) => 0.1524776286, 0.1524776286),
   (f_mos_acc_lseen_d > 172.5) => 0.0058400246,
   (f_mos_acc_lseen_d = NULL) => 0.0267747822, 0.0267747822),
(f_prevaddrmurderindex_i = NULL) => -0.0029906386, -0.0029906386);

// Tree: 25 
final_score_25 := map(
(NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 0.5) => -0.0093205128,
(inq_adl_firstseen_n > 0.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 1586) => -0.0300180305,
   (f_addrchangeincomediff_d > 1586) => 
      map(
      (NULL < f_inq_per_addr_i and f_inq_per_addr_i <= 1.5) => 0.3066555840,
      (f_inq_per_addr_i > 1.5) => -0.0348952220,
      (f_inq_per_addr_i = NULL) => 0.1615206806, 0.1615206806),
   (f_addrchangeincomediff_d = NULL) => 0.0940943080, 0.0723942072),
(inq_adl_firstseen_n = NULL) => 0.0002412022, 0.0002412022);

// Tree: 26 
final_score_26 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 5.5) => 
   map(
   (pp_src in ['E1','EN','EQ','FA','KW','SL','TN','UT','UW']) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.243440292291585) => 0.2437863369,
      (f_add_input_mobility_index_n > 0.243440292291585) => -0.1764813767,
      (f_add_input_mobility_index_n = NULL) => -0.1196884424, -0.1196884424),
   (pp_src in ['CY','E2','EM','FF','LA','LP','MD','NW','PL','VO','VW','ZK','ZT']) => 0.2494488351,
   (pp_src = '') => -0.0248559553, -0.0345176514),
(f_rel_under100miles_cnt_d > 5.5) => 0.0340530044,
(f_rel_under100miles_cnt_d = NULL) => 0.0123376855, 0.0123376855);

// Tree: 27 
final_score_27 := map(
(phone_subject_title in ['Associate','Associate By Business','Associate By SSN','Associate By Vehicle','Brother','Father','Granddaughter','Grandparent','Grandson','Husband','Mother','Neighbor','Sibling','Sister','Spouse','Subject','Wife']) => -0.0394208513,
(phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Child','Daughter','Grandchild','Grandfather','Grandmother','Parent','Relative','Son','Subject at Household']) => 
   map(
   (NULL < f_inq_lnames_per_addr_i and f_inq_lnames_per_addr_i <= 7.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -30242) => -0.1179693313,
      (f_addrchangevaluediff_d > -30242) => 0.0745475848,
      (f_addrchangevaluediff_d = NULL) => 0.0454001877, 0.0245250946),
   (f_inq_lnames_per_addr_i > 7.5) => 0.5667082932,
   (f_inq_lnames_per_addr_i = NULL) => 0.0361492367, 0.0361492367),
(phone_subject_title = '') => -0.0149794112, -0.0149794112);

// Tree: 28 
final_score_28 := map(
(phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Father','Grandparent','Grandson','Husband']) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 67.5) => -0.0804391046,
   (f_addrchangecrimediff_i > 67.5) => 0.1895709617,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.27387747195834) => -0.5090710559,
      (f_add_curr_mobility_index_n > 0.27387747195834) => -0.0173443663,
      (f_add_curr_mobility_index_n = NULL) => -0.1727605739, -0.1727605739), -0.0810114070),
(phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0068766015,
(phone_subject_title = '') => -0.0018512567, -0.0018512567);

// Tree: 29 
final_score_29 := map(
(NULL < mth_source_edadid_fseen and mth_source_edadid_fseen <= 1.5) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 4.5) => -0.0234522817,
   (f_rel_homeover200_count_d > 4.5) => 0.0564673975,
   (f_rel_homeover200_count_d = NULL) => 0.0031197649, 0.0031197649),
(mth_source_edadid_fseen > 1.5) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 2.5) => 0.3471385144,
   (f_rel_incomeover75_count_d > 2.5) => -0.1169708572,
   (f_rel_incomeover75_count_d = NULL) => 0.1948154386, 0.1948154386),
(mth_source_edadid_fseen = NULL) => 0.0077483752, 0.0077483752);

// Tree: 30 
final_score_30 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.293523797003995) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 26071) => -0.2928625238,
   (f_curraddrmedianincome_d > 26071) => 
      map(
      (NULL < f_inq_adls_per_addr_i and f_inq_adls_per_addr_i <= 3.5) => -0.0226153083,
      (f_inq_adls_per_addr_i > 3.5) => 0.3910202789,
      (f_inq_adls_per_addr_i = NULL) => -0.0097813320, -0.0097813320),
   (f_curraddrmedianincome_d = NULL) => -0.0256885458, -0.0256885458),
(f_add_input_mobility_index_n > 0.293523797003995) => 0.0190657177,
(f_add_input_mobility_index_n = NULL) => 0.2762843076, 0.0073233323);

// Tree: 31 
final_score_31 := map(
(NULL < _pp_origlistingtype_res and _pp_origlistingtype_res <= 0.5) => 
   map(
   (pp_src in ['E1','E2','EM','FA','LP','PL','TN','UT','UW']) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.55264122606152) => 0.1470303634,
      (f_add_curr_mobility_index_n > 0.55264122606152) => -0.2557590166,
      (f_add_curr_mobility_index_n = NULL) => 0.0835364710, 0.0835364710),
   (pp_src in ['CY','EN','EQ','FF','KW','LA','MD','NW','SL','VO','VW','ZK','ZT']) => 0.3927458356,
   (pp_src = '') => 0.0242231936, 0.0367805862),
(_pp_origlistingtype_res > 0.5) => -0.0564920746,
(_pp_origlistingtype_res = NULL) => 0.0116838190, 0.0116838190);

// Tree: 32 
final_score_32 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 220257.5) => 
   map(
   (NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 11.5) => 0.0116772613,
   (mth_source_rel_fseen > 11.5) => 0.2091352189,
   (mth_source_rel_fseen = NULL) => 0.0145738698, 0.0145738698),
(f_curraddrmedianvalue_d > 220257.5) => 
   map(
   (NULL < f_inq_adls_per_addr_i and f_inq_adls_per_addr_i <= 5.5) => -0.0630693947,
   (f_inq_adls_per_addr_i > 5.5) => 0.3098464943,
   (f_inq_adls_per_addr_i = NULL) => -0.0485722509, -0.0485722509),
(f_curraddrmedianvalue_d = NULL) => -0.0043324353, -0.0043324353);

// Tree: 33 
final_score_33 := map(
(NULL < inq_num_addresses and inq_num_addresses <= 8.5) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 6.5) => -0.0013857562,
   (f_sourcerisktype_i > 6.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 3.5) => 0.3864544058,
      (r_pb_order_freq_d > 3.5) => -0.1494109252,
      (r_pb_order_freq_d = NULL) => 0.0765722499, 0.1031323756),
   (f_sourcerisktype_i = NULL) => 0.0092902665, 0.0092902665),
(inq_num_addresses > 8.5) => -0.3850719553,
(inq_num_addresses = NULL) => 0.0065068778, 0.0065068778);

// Tree: 34 
final_score_34 := map(
(NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 37.5) => -0.0106984907,
(inq_adl_firstseen_n > 37.5) => 
   map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 3.5) => 0.3033024268,
   (f_rel_incomeover50_count_d > 3.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.24921157274098) => -0.2924994690,
      (f_add_curr_mobility_index_n > 0.24921157274098) => 0.0838186643,
      (f_add_curr_mobility_index_n = NULL) => 0.0088548928, 0.0088548928),
   (f_rel_incomeover50_count_d = NULL) => 0.1070040708, 0.1070040708),
(inq_adl_firstseen_n = NULL) => -0.0051748068, -0.0051748068);

// Tree: 35 
final_score_35 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 30180.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Vehicle','Child','Father','Grandfather','Grandmother','Grandson','Mother','Parent','Son','Spouse','Subject']) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 245164.5) => -0.0847001068,
      (f_curraddrmedianvalue_d > 245164.5) => -0.3752264622,
      (f_curraddrmedianvalue_d = NULL) => -0.1288755904, -0.1288755904),
   (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Daughter','Grandchild','Granddaughter','Grandparent','Husband','Neighbor','Relative','Sibling','Sister','Subject at Household','Wife']) => 0.0499976495,
   (phone_subject_title = '') => -0.0613040005, -0.0613040005),
(f_prevaddrmedianincome_d > 30180.5) => 0.0124282599,
(f_prevaddrmedianincome_d = NULL) => -0.0007933268, -0.0007933268);

// Tree: 36 
final_score_36 := map(
(NULL < eda_num_interrupts_cur and eda_num_interrupts_cur <= 8.5) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 30.5) => 0.0193619128,
   (f_rel_under100miles_cnt_d > 30.5) => -0.1370964013,
   (f_rel_under100miles_cnt_d = NULL) => 0.0144589567, 0.0144589567),
(eda_num_interrupts_cur > 8.5) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 3.5) => -0.1066434334,
   (mth_exp_last_update > 3.5) => -0.3760271590,
   (mth_exp_last_update = NULL) => -0.1351908417, -0.1351908417),
(eda_num_interrupts_cur = NULL) => 0.0048417891, 0.0048417891);

// Tree: 37 
final_score_37 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 595992.5) => 
   map(
   (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 55.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.45933123752825) => -0.0040912468,
      (f_add_curr_mobility_index_n > 0.45933123752825) => 0.0614747955,
      (f_add_curr_mobility_index_n = NULL) => 0.2077134894, 0.0131945662),
   (mth_pp_datevendorfirstseen > 55.5) => -0.1051882608,
   (mth_pp_datevendorfirstseen = NULL) => 0.0046579945, 0.0046579945),
(f_prevaddrmedianvalue_d > 595992.5) => -0.1820294298,
(f_prevaddrmedianvalue_d = NULL) => -0.0002432729, -0.0002432729);

// Tree: 38 
final_score_38 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 3.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 55.5) => 0.0270204756,
   (mth_source_utildid_fseen > 55.5) => 0.3248422497,
   (mth_source_utildid_fseen = NULL) => 0.0323963199, 0.0323963199),
(f_srchaddrsrchcount_i > 3.5) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 1.5) => -0.0313590815,
   (f_idrisktype_i > 1.5) => -0.2842214367,
   (f_idrisktype_i = NULL) => -0.0435253130, -0.0435253130),
(f_srchaddrsrchcount_i = NULL) => 0.0007435044, 0.0007435044);

// Tree: 39 
final_score_39 := map(
(NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 4.5) => 0.0422510890,
(f_rel_educationover12_count_d > 4.5) => 
   map(
   (NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 2.5) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 18.5) => 0.3982712221,
      (f_mos_inq_banko_om_lseen_d > 18.5) => 0.0317114732,
      (f_mos_inq_banko_om_lseen_d = NULL) => 0.0898340550, 0.0898340550),
   (f_componentcharrisktype_i > 2.5) => -0.0390828313,
   (f_componentcharrisktype_i = NULL) => -0.0297160591, -0.0297160591),
(f_rel_educationover12_count_d = NULL) => -0.0159556614, -0.0159556614);

// Tree: 40 
final_score_40 := map(
(NULL < eda_days_ind_first_seen and eda_days_ind_first_seen <= 728.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 67) => 
      map(
      (NULL < mth_source_pf_fseen and mth_source_pf_fseen <= 7.5) => -0.0024531705,
      (mth_source_pf_fseen > 7.5) => -0.2794764042,
      (mth_source_pf_fseen = NULL) => -0.0045647946, -0.0045647946),
   (mth_source_utildid_fseen > 67) => -0.2700122814,
   (mth_source_utildid_fseen = NULL) => -0.0072582906, -0.0072582906),
(eda_days_ind_first_seen > 728.5) => -0.1763741039,
(eda_days_ind_first_seen = NULL) => -0.0154041612, -0.0154041612);

// Tree: 41 
final_score_41 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 3.5) => -0.0143690633,
(f_rel_homeover500_count_d > 3.5) => 
   map(
   (NULL < pk_phone_match_level and pk_phone_match_level <= 2.5) => 
      map(
      (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 4.5) => -0.2024506330,
      (f_crim_rel_under100miles_cnt_i > 4.5) => 0.5357698586,
      (f_crim_rel_under100miles_cnt_i = NULL) => -0.0524058176, -0.0524058176),
   (pk_phone_match_level > 2.5) => 0.1795856676,
   (pk_phone_match_level = NULL) => 0.0599422601, 0.0599422601),
(f_rel_homeover500_count_d = NULL) => -0.0099619389, -0.0099619389);

// Tree: 42 
final_score_42 := map(
(NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 95.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 14.5) => -0.0213545898,
   (mth_source_ppdid_fseen > 14.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 2.5) => 0.1480392339,
      (f_util_adl_count_n > 2.5) => -0.0154325180,
      (f_util_adl_count_n = NULL) => 0.0544687995, 0.0544687995),
   (mth_source_ppdid_fseen = NULL) => -0.0071563167, -0.0071563167),
(mth_source_ppdid_fseen > 95.5) => -0.2386503294,
(mth_source_ppdid_fseen = NULL) => -0.0124019091, -0.0124019091);

// Tree: 43 
final_score_43 := map(
(NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 107) => 
   map(
   (pp_src in ['E1','LP','PL','SL','VO']) => -0.2313388227,
   (pp_src in ['CY','E2','EM','EN','EQ','FA','FF','KW','LA','MD','NW','TN','UT','UW','VW','ZK','ZT']) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 23548) => -0.3926844759,
      (f_prevaddrmedianincome_d > 23548) => 0.0059357280,
      (f_prevaddrmedianincome_d = NULL) => -0.0229337018, -0.0229337018),
   (pp_src = '') => 0.0573066814, 0.0383026848),
(f_fp_prevaddrcrimeindex_i > 107) => -0.0326426246,
(f_fp_prevaddrcrimeindex_i = NULL) => 0.0034670004, 0.0034670004);

// Tree: 44 
final_score_44 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 11.5) => 0.0047358778,
(mth_exp_last_update > 11.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 32.5) => -0.2671529981,
   (f_prevaddrageoldest_d > 32.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 12.5) => 0.0111898747,
      (f_srchfraudsrchcount_i > 12.5) => -0.3465472734,
      (f_srchfraudsrchcount_i = NULL) => -0.0267852995, -0.0267852995),
   (f_prevaddrageoldest_d = NULL) => -0.0844173208, -0.0844173208),
(mth_exp_last_update = NULL) => -0.0047027037, -0.0047027037);

// Tree: 45 
final_score_45 := map(
(NULL < mth_source_rm_fseen and mth_source_rm_fseen <= 7.5) => -0.0044887580,
(mth_source_rm_fseen > 7.5) => 
   map(
   (NULL < _phone_match_code_z and _phone_match_code_z <= 0.5) => 0.0739542700,
   (_phone_match_code_z > 0.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 96.5) => 0.0852770034,
      (f_curraddrburglaryindex_i > 96.5) => 0.6331982594,
      (f_curraddrburglaryindex_i = NULL) => 0.4000402782, 0.4000402782),
   (_phone_match_code_z = NULL) => 0.1464749753, 0.1464749753),
(mth_source_rm_fseen = NULL) => 0.0073625306, 0.0073625306);

// Tree: 46 
final_score_46 := map(
(NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => 
   map(
   (NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 18.5) => 
      map(
      (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 18.5) => 0.0311467397,
      (mth_source_ppdid_lseen > 18.5) => -0.1269048976,
      (mth_source_ppdid_lseen = NULL) => 0.0103299773, 0.0103299773),
   (mth_source_ppth_lseen > 18.5) => -0.3065330413,
   (mth_source_ppth_lseen = NULL) => -0.0023105114, -0.0023105114),
(_inq_adl_ph_industry_flag > 0.5) => 0.2261422460,
(_inq_adl_ph_industry_flag = NULL) => 0.0049028929, 0.0049028929);

// Tree: 47 
final_score_47 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 12) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 3.5) => -0.0505291595,
   (f_rel_under25miles_cnt_d > 3.5) => 
      map(
      (NULL < _phone_match_code_a and _phone_match_code_a <= 0.5) => -0.0672812918,
      (_phone_match_code_a > 0.5) => -0.3425566158,
      (_phone_match_code_a = NULL) => -0.1829644801, -0.1829644801),
   (f_rel_under25miles_cnt_d = NULL) => -0.1443854954, -0.1443854954),
(f_curraddrcartheftindex_i > 12) => 0.0035491193,
(f_curraddrcartheftindex_i = NULL) => -0.0048953901, -0.0048953901);

// Tree: 48 
final_score_48 := map(
(NULL < mth_source_pf_fseen and mth_source_pf_fseen <= 10.5) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By SSN','Grandfather','Grandmother','Grandson','Mother','Son','Spouse','Wife']) => 
      map(
      (NULL < eda_min_days_interrupt and eda_min_days_interrupt <= 1.5) => -0.0014142236,
      (eda_min_days_interrupt > 1.5) => -0.2692604906,
      (eda_min_days_interrupt = NULL) => -0.1283276063, -0.1283276063),
   (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandparent','Husband','Neighbor','Parent','Relative','Sibling','Sister','Subject','Subject at Household']) => 0.0092284696,
   (phone_subject_title = '') => 0.0029977664, 0.0029977664),
(mth_source_pf_fseen > 10.5) => -0.3517413502,
(mth_source_pf_fseen = NULL) => 0.0002744102, 0.0002744102);

// Tree: 49 
final_score_49 := map(
(NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 125.5) => -0.0259717933,
(mth_pp_app_npa_effective_dt > 125.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 360.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 59281.5) => 0.0662372876,
      (f_addrchangeincomediff_d > 59281.5) => 0.3899516190,
      (f_addrchangeincomediff_d = NULL) => 0.0021931493, 0.0576860702),
   (f_prevaddrlenofres_d > 360.5) => -0.2452573032,
   (f_prevaddrlenofres_d = NULL) => 0.0479938704, 0.0479938704),
(mth_pp_app_npa_effective_dt = NULL) => -0.0036428819, -0.0036428819);

// Tree: 50 
final_score_50 := map(
(NULL < f_idrisktype_i and f_idrisktype_i <= 1.5) => 0.0004572221,
(f_idrisktype_i > 1.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 4.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Child','Grandfather','Mother','Neighbor','Parent','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => -0.1906481890,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Daughter','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Relative','Spouse']) => 0.2838478057,
      (phone_subject_title = '') => -0.0605832971, -0.0605832971),
   (f_srchaddrsrchcount_i > 4.5) => -0.3865208674,
   (f_srchaddrsrchcount_i = NULL) => -0.1833256099, -0.1833256099),
(f_idrisktype_i = NULL) => -0.0067347748, -0.0067347748);

// Tree: 51 
final_score_51 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.264719738575345) => 
   map(
   (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 4.5) => 0.0354786409,
   (f_assoccredbureaucount_i > 4.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 114) => 0.0424044107,
      (f_fp_prevaddrcrimeindex_i > 114) => 0.7350317845,
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.3728321487, 0.3728321487),
   (f_assoccredbureaucount_i = NULL) => 0.0530642613, 0.0530642613),
(f_add_curr_mobility_index_n > 0.264719738575345) => -0.0185601025,
(f_add_curr_mobility_index_n = NULL) => 0.0030299132, 0.0001770231);

// Tree: 52 
final_score_52 := map(
(NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 354) => 
   map(
   (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 291.5) => 
      map(
      (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 35.5) => 0.0047286593,
      (inq_adl_lastseen_n > 35.5) => -0.1233864206,
      (inq_adl_lastseen_n = NULL) => 0.0004694075, 0.0004694075),
   (mth_source_inf_fseen > 291.5) => 0.3166230745,
   (mth_source_inf_fseen = NULL) => 0.0025185151, 0.0025185151),
(mth_source_inf_fseen > 354) => -0.3683937045,
(mth_source_inf_fseen = NULL) => 0.0000843463, 0.0000843463);

// Tree: 53 
final_score_53 := map(
(NULL < mth_source_edafla_fseen and mth_source_edafla_fseen <= 16.5) => 
   map(
   (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 18.5) => -0.0012684032,
   (mth_source_inf_fseen > 18.5) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 115.5) => -0.1626028778,
      (mth_pp_app_npa_last_change_dt > 115.5) => 0.2188576101,
      (mth_pp_app_npa_last_change_dt = NULL) => -0.1212982390, -0.1212982390),
   (mth_source_inf_fseen = NULL) => -0.0083307458, -0.0083307458),
(mth_source_edafla_fseen > 16.5) => 0.3333903366,
(mth_source_edafla_fseen = NULL) => -0.0053265114, -0.0053265114);

// Tree: 54 
final_score_54 := map(
(NULL < source_sx and source_sx <= 0.5) => -0.0025825444,
(source_sx > 0.5) => 
   map(
   (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 458) => 
      map(
      (NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 60.5) => -0.0009633352,
      (r_mos_since_paw_fseen_d > 60.5) => 0.3697372048,
      (r_mos_since_paw_fseen_d = NULL) => 0.0564178295, 0.0564178295),
   (eda_avg_days_interrupt > 458) => 0.4082084573,
   (eda_avg_days_interrupt = NULL) => 0.1042195284, 0.1042195284),
(source_sx = NULL) => 0.0036462540, 0.0036462540);

// Tree: 55 
final_score_55 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 12.5) => 0.0073896451,
(f_rel_ageover40_count_d > 12.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 1685.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 156.5) => 0.1872188685,
      (f_curraddrburglaryindex_i > 156.5) => -0.2691951706,
      (f_curraddrburglaryindex_i = NULL) => 0.0242138546, 0.0242138546),
   (f_addrchangeincomediff_d > 1685.5) => -0.3024039875,
   (f_addrchangeincomediff_d = NULL) => -0.1803912318, -0.1375742175),
(f_rel_ageover40_count_d = NULL) => 0.0006538413, 0.0006538413);

// Tree: 56 
final_score_56 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0077404322,
(source_utildid > 0.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 95.5) => -0.0478604695,
   (f_prevaddrcartheftindex_i > 95.5) => 
      map(
      (NULL < pp_min_source_conf and pp_min_source_conf <= 9.5) => 0.0911285750,
      (pp_min_source_conf > 9.5) => 0.3496062894,
      (pp_min_source_conf = NULL) => 0.1556066044, 0.1556066044),
   (f_prevaddrcartheftindex_i = NULL) => 0.0774555046, 0.0774555046),
(source_utildid = NULL) => 0.0000871291, 0.0000871291);

// Tree: 57 
final_score_57 := map(
(NULL < source_sx and source_sx <= 0.5) => -0.0165431789,
(source_sx > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 23.5) => -0.1830917949,
   (f_mos_inq_banko_cm_lseen_d > 23.5) => 
      map(
      (NULL < f_inq_adls_per_addr_i and f_inq_adls_per_addr_i <= 0.5) => 0.2581318566,
      (f_inq_adls_per_addr_i > 0.5) => -0.0344274709,
      (f_inq_adls_per_addr_i = NULL) => 0.1332769921, 0.1332769921),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0869126009, 0.0869126009),
(source_sx = NULL) => -0.0105992113, -0.0105992113);

// Tree: 58 
final_score_58 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 14.5) => -0.0006633503,
(f_rel_incomeover50_count_d > 14.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 15948) => 0.1359773172,
   (f_addrchangeincomediff_d > 15948) => -0.0804802762,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 15.5) => -0.0841961337,
      (f_rel_homeover100_count_d > 15.5) => 0.3259332588,
      (f_rel_homeover100_count_d = NULL) => 0.1817325135, 0.1817325135), 0.0882931254),
(f_rel_incomeover50_count_d = NULL) => 0.0086499022, 0.0086499022);

// Tree: 59 
final_score_59 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 51.5) => 
   map(
   (NULL < _phone_fb_result and _phone_fb_result <= 0.5) => 0.3272872455,
   (_phone_fb_result > 0.5) => 
      map(
      (NULL < source_pf and source_pf <= 0.5) => -0.0091905617,
      (source_pf > 0.5) => -0.3304827366,
      (source_pf = NULL) => -0.0113853470, -0.0113853470),
   (_phone_fb_result = NULL) => -0.0092566694, -0.0092566694),
(inq_adl_lastseen_n > 51.5) => -0.2228214365,
(inq_adl_lastseen_n = NULL) => -0.0124564387, -0.0124564387);

// Tree: 60 
final_score_60 := map(
(NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0204303063,
(_pp_rule_high_vend_conf > 0.5) => 
   map(
   (pp_origphonetype in ['O','W']) => 0.0218793845,
   (pp_origphonetype in ['L','V']) => 0.0688891765,
   (pp_origphonetype = '') => 
      map(
      (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 7.5) => -0.0076774755,
      (mth_source_ppdid_lseen > 7.5) => 0.5745052453,
      (mth_source_ppdid_lseen = NULL) => 0.2122582190, 0.2122582190), 0.0514106133),
(_pp_rule_high_vend_conf = NULL) => -0.0087058967, -0.0087058967);

// Tree: 61 
final_score_61 := map(
(NULL < mth_source_ppfa_lseen and mth_source_ppfa_lseen <= 9.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 13.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 37.5) => 0.2562227557,
      (r_pb_order_freq_d > 37.5) => 0.1392224387,
      (r_pb_order_freq_d = NULL) => -0.0639085684, 0.1010169750),
   (f_mos_inq_banko_om_fseen_d > 13.5) => 0.0008376361,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0073371066, 0.0073371066),
(mth_source_ppfa_lseen > 9.5) => -0.1969223522,
(mth_source_ppfa_lseen = NULL) => 0.0057942850, 0.0057942850);

// Tree: 62 
final_score_62 := map(
(NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 1.5) => 
   map(
   (pp_src in ['CY','E1','E2','EN','EQ','TN','UW','ZT']) => -0.2663077352,
   (pp_src in ['EM','FA','FF','KW','LA','LP','MD','NW','PL','SL','UT','VO','VW','ZK']) => 0.0526950012,
   (pp_src = '') => -0.0412788724, -0.0462798213),
(f_rel_homeover100_count_d > 1.5) => 
   map(
   (pp_origphoneusage in ['H','M','O','P']) => -0.0387006395,
   (pp_origphoneusage in ['S']) => 0.2504150276,
   (pp_origphoneusage = '') => 0.0171281971, 0.0137118301),
(f_rel_homeover100_count_d = NULL) => -0.0024543883, -0.0024543883);

// Tree: 63 
final_score_63 := map(
(NULL < eda_days_ind_first_seen and eda_days_ind_first_seen <= 1212.5) => 0.0094957416,
(eda_days_ind_first_seen > 1212.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 525) => 
      map(
      (NULL < eda_days_in_service and eda_days_in_service <= 549) => -0.0903430184,
      (eda_days_in_service > 549) => -0.5628053018,
      (eda_days_in_service = NULL) => -0.3288676663, -0.3288676663),
   (f_mos_inq_banko_om_fseen_d > 525) => -0.0280041044,
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.1224826010, -0.1224826010),
(eda_days_ind_first_seen = NULL) => 0.0041355513, 0.0041355513);

// Tree: 64 
final_score_64 := map(
(NULL < _internal_ver_match_hhid and _internal_ver_match_hhid <= 0.5) => -0.0106348576,
(_internal_ver_match_hhid > 0.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -6692) => 
      map(
      (NULL < pp_did_score and pp_did_score <= 40) => 0.3739520681,
      (pp_did_score > 40) => -0.0446880735,
      (pp_did_score = NULL) => 0.2135639619, 0.2135639619),
   (f_addrchangevaluediff_d > -6692) => -0.0025804173,
   (f_addrchangevaluediff_d = NULL) => 0.1502254774, 0.0806139308),
(_internal_ver_match_hhid = NULL) => -0.0036861200, -0.0036861200);

// Tree: 65 
final_score_65 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.328308116376625) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -132.5) => -0.2920210540,
   (f_addrchangecrimediff_i > -132.5) => -0.0063047285,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 56.5) => -0.0388501680,
      (mth_pp_eda_hist_did_dt > 56.5) => -0.2907306231,
      (mth_pp_eda_hist_did_dt = NULL) => -0.0723483360, -0.0723483360), -0.0290797701),
(f_add_input_mobility_index_n > 0.328308116376625) => 0.0242358434,
(f_add_input_mobility_index_n = NULL) => -0.1371700828, 0.0006867458);

// Tree: 66 
final_score_66 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Child','Father','Granddaughter','Grandfather','Grandmother','Grandson','Mother','Neighbor','Relative','Sibling','Sister','Son','Subject','Wife']) => -0.0074372002,
(phone_subject_title in ['Associate By Property','Associate By SSN','Brother','Daughter','Grandchild','Grandparent','Husband','Parent','Spouse','Subject at Household']) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => 
      map(
      (NULL < f_inq_addrs_per_ssn_i and f_inq_addrs_per_ssn_i <= 0.5) => -0.0542338886,
      (f_inq_addrs_per_ssn_i > 0.5) => 0.2111476353,
      (f_inq_addrs_per_ssn_i = NULL) => 0.0087379984, 0.0087379984),
   (f_sourcerisktype_i > 5.5) => 0.2640241865,
   (f_sourcerisktype_i = NULL) => 0.0650358671, 0.0650358671),
(phone_subject_title = '') => 0.0013930992, 0.0013930992);

// Tree: 67 
final_score_67 := map(
(NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 7.5) => 
   map(
   (NULL < f_divssnidmsrcurelcount_i and f_divssnidmsrcurelcount_i <= 1.5) => -0.0008944773,
   (f_divssnidmsrcurelcount_i > 1.5) => 
      map(
      (NULL < inq_num_addresses_06 and inq_num_addresses_06 <= 0.5) => 0.0618231021,
      (inq_num_addresses_06 > 0.5) => 0.5152576242,
      (inq_num_addresses_06 = NULL) => 0.1065164689, 0.1065164689),
   (f_divssnidmsrcurelcount_i = NULL) => 0.0066798065, 0.0066798065),
(f_rel_incomeover100_count_d > 7.5) => -0.1864316120,
(f_rel_incomeover100_count_d = NULL) => 0.0033697362, 0.0033697362);

// Tree: 68 
final_score_68 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 32.5) => -0.0010635729,
(inq_adl_lastseen_n > 32.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 2.5) => 
      map(
      (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 0.5) => 0.3304936617,
      (f_rel_bankrupt_count_i > 0.5) => -0.0686141384,
      (f_rel_bankrupt_count_i = NULL) => 0.0844683054, 0.0844683054),
   (f_srchssnsrchcount_i > 2.5) => -0.2768963002,
   (f_srchssnsrchcount_i = NULL) => -0.1343037802, -0.1343037802),
(inq_adl_lastseen_n = NULL) => -0.0071679410, -0.0071679410);

// Tree: 69 
final_score_69 := map(
(NULL < mth_source_edala_fseen and mth_source_edala_fseen <= 21.5) => 
   map(
   (NULL < source_ppfa and source_ppfa <= 0.5) => 
      map(
      (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 95.5) => -0.0092197108,
      (mth_source_ppdid_fseen > 95.5) => -0.1707461414,
      (mth_source_ppdid_fseen = NULL) => -0.0129775643, -0.0129775643),
   (source_ppfa > 0.5) => 0.1648800475,
   (source_ppfa = NULL) => -0.0112185819, -0.0112185819),
(mth_source_edala_fseen > 21.5) => -0.2341525123,
(mth_source_edala_fseen = NULL) => -0.0136477778, -0.0136477778);

// Tree: 70 
final_score_70 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 338278) => 0.0066488386,
(f_prevaddrmedianvalue_d > 338278) => 
   map(
   (pp_src in ['CY','LP','PL','TN','UT','VO','ZT']) => 
      map(
      (NULL < f_estimated_income_d and f_estimated_income_d <= 78500) => 0.0867327313,
      (f_estimated_income_d > 78500) => -0.2942547706,
      (f_estimated_income_d = NULL) => -0.1459509108, -0.1459509108),
   (pp_src in ['E1','E2','EM','EN','EQ','FA','FF','KW','LA','MD','NW','SL','UW','VW','ZK']) => 0.2005085831,
   (pp_src = '') => -0.0822235183, -0.0727788837),
(f_prevaddrmedianvalue_d = NULL) => -0.0046614488, -0.0046614488);

// Tree: 71 
final_score_71 := map(
(NULL < mth_source_md_fseen and mth_source_md_fseen <= 9.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 51.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.200497480836145) => -0.1357430568,
      (f_add_curr_mobility_index_n > 0.200497480836145) => 0.0271405100,
      (f_add_curr_mobility_index_n = NULL) => 0.0139128341, 0.0139128341),
   (f_mos_inq_banko_cm_lseen_d > 51.5) => -0.0345355826,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0094672820, -0.0094672820),
(mth_source_md_fseen > 9.5) => -0.1487589441,
(mth_source_md_fseen = NULL) => -0.0141068878, -0.0141068878);

// Tree: 72 
final_score_72 := map(
(NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 4182.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Child','Granddaughter','Grandmother','Grandson','Husband','Neighbor','Relative','Sister','Spouse']) => -0.0657811847,
   (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By Vehicle','Brother','Daughter','Father','Grandchild','Grandfather','Grandparent','Mother','Parent','Sibling','Son','Subject','Subject at Household','Wife']) => 0.0365830616,
   (phone_subject_title = '') => 0.0156913305, 0.0156913305),
(eda_days_ph_first_seen > 4182.5) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Father','Grandfather','Grandmother','Grandparent','Husband','Mother','Parent','Sibling','Son','Subject']) => -0.1110215421,
   (phone_subject_title in ['Associate','Associate By Address','Associate By SSN','Grandchild','Granddaughter','Grandson','Neighbor','Relative','Sister','Spouse','Subject at Household','Wife']) => 0.0377668895,
   (phone_subject_title = '') => -0.0347094293, -0.0347094293),
(eda_days_ph_first_seen = NULL) => 0.0018929056, 0.0018929056);

// Tree: 73 
final_score_73 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 6.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Daughter','Grandmother','Husband','Mother','Neighbor','Parent','Relative','Sister','Spouse','Subject','Subject at Household','Wife']) => 0.0211044668,
   (phone_subject_title in ['Associate By Shared Associates','Child','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Sibling','Son']) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 5.5) => 0.4272181053,
      (f_rel_ageover40_count_d > 5.5) => -0.2490553244,
      (f_rel_ageover40_count_d = NULL) => 0.2725546752, 0.2725546752),
   (phone_subject_title = '') => 0.0392747185, 0.0392747185),
(f_rel_under100miles_cnt_d > 6.5) => -0.0187321549,
(f_rel_under100miles_cnt_d = NULL) => 0.0035077769, 0.0035077769);

// Tree: 74 
final_score_74 := map(
(NULL < _pp_rule_ins_ver_above and _pp_rule_ins_ver_above <= 0.5) => -0.0263524259,
(_pp_rule_ins_ver_above > 0.5) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 85) => 0.2094500013,
   (mth_pp_app_npa_last_change_dt > 85) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 98.5) => -0.2241442237,
      (f_fp_prevaddrcrimeindex_i > 98.5) => 0.1525825155,
      (f_fp_prevaddrcrimeindex_i = NULL) => -0.0268111699, -0.0268111699),
   (mth_pp_app_npa_last_change_dt = NULL) => 0.0867277675, 0.0867277675),
(_pp_rule_ins_ver_above = NULL) => -0.0223898584, -0.0223898584);

// Tree: 75 
final_score_75 := map(
(NULL < _pp_app_fb_ph and _pp_app_fb_ph <= 0.5) => 0.2639942279,
(_pp_app_fb_ph > 0.5) => 
   map(
   (NULL < mth_source_edadid_fseen and mth_source_edadid_fseen <= 2.5) => -0.0052823738,
   (mth_source_edadid_fseen > 2.5) => 
      map(
      (NULL < eda_months_addr_last_seen and eda_months_addr_last_seen <= 5) => 0.2371615423,
      (eda_months_addr_last_seen > 5) => -0.0646706987,
      (eda_months_addr_last_seen = NULL) => 0.1190532741, 0.1190532741),
   (mth_source_edadid_fseen = NULL) => -0.0020663949, -0.0020663949),
(_pp_app_fb_ph = NULL) => 0.0003385612, 0.0003385612);

// Tree: 76 
final_score_76 := map(
(NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 89.5) => 
   map(
   (NULL < mth_source_edala_fseen and mth_source_edala_fseen <= 4) => -0.0043919372,
   (mth_source_edala_fseen > 4) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 101) => -0.3398056183,
      (f_prevaddrageoldest_d > 101) => 0.0054737578,
      (f_prevaddrageoldest_d = NULL) => -0.1285152538, -0.1285152538),
   (mth_source_edala_fseen = NULL) => -0.0064730839, -0.0064730839),
(mth_source_ppfla_fseen > 89.5) => -0.2187371511,
(mth_source_ppfla_fseen = NULL) => -0.0086808825, -0.0086808825);

// Tree: 77 
final_score_77 := map(
(NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0266678623,
(_phone_match_code_n > 0.5) => 
   map(
   (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 17) => 0.0562876205,
      (r_pb_order_freq_d > 17) => 0.1539192555,
      (r_pb_order_freq_d = NULL) => -0.0017305041, 0.0687827206),
   (f_util_add_curr_conv_n > 0.5) => 0.0004098663,
   (f_util_add_curr_conv_n = NULL) => 0.0225571192, 0.0225571192),
(_phone_match_code_n = NULL) => -0.0059502159, -0.0059502159);

// Tree: 78 
final_score_78 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 2.5) => 
   map(
   (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0283509333,
   (_phone_match_code_n > 0.5) => 
      map(
      (phone_subject_title in ['Associate','Grandmother','Subject','Subject at Household']) => 0.0569171723,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Wife']) => 0.4995039324,
      (phone_subject_title = '') => 0.0709077568, 0.0709077568),
   (_phone_match_code_n = NULL) => 0.0088343423, 0.0088343423),
(f_util_adl_count_n > 2.5) => -0.0311375498,
(f_util_adl_count_n = NULL) => -0.0094017507, -0.0094017507);

// Tree: 79 
final_score_79 := map(
(NULL < f_estimated_income_d and f_estimated_income_d <= 84500) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 73.5) => -0.0101167329,
   (mth_exp_last_update > 73.5) => -0.3238756620,
   (mth_exp_last_update = NULL) => -0.0143264195, -0.0143264195),
(f_estimated_income_d > 84500) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Father','Grandmother','Husband','Neighbor','Parent','Sibling','Son','Subject at Household']) => -0.0462478377,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Brother','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Mother','Relative','Sister','Spouse','Subject','Wife']) => 0.1479725129,
   (phone_subject_title = '') => 0.0759564354, 0.0759564354),
(f_estimated_income_d = NULL) => -0.0006990297, -0.0006990297);

// Tree: 80 
final_score_80 := map(
(NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => -0.0060193120,
(_inq_adl_ph_industry_flag > 0.5) => 
   map(
   (NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 12.5) => 
      map(
      (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 7.5) => 0.1518078527,
      (inq_adl_lastseen_n > 7.5) => -0.1286829127,
      (inq_adl_lastseen_n = NULL) => 0.0323395637, 0.0323395637),
   (mth_pp_orig_lastseen > 12.5) => 0.3380683058,
   (mth_pp_orig_lastseen = NULL) => 0.1030597354, 0.1030597354),
(_inq_adl_ph_industry_flag = NULL) => -0.0022239663, -0.0022239663);

// Tree: 81 
final_score_81 := map(
(NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 85.5) => -0.0048788586,
(mth_pp_eda_hist_did_dt > 85.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 10.5) => 
      map(
      (pp_source in ['CELL','GONG','HEADER','IBEHAVIOR','INQUIRY','OTHER','PCNSR','THRIVE']) => -0.1027852069,
      (pp_source in ['INFUTOR','INTRADO','TARGUS']) => 0.1479318182,
      (pp_source = '') => -0.0476192276, -0.0476192276),
   (f_corraddrnamecount_d > 10.5) => -0.2915426272,
   (f_corraddrnamecount_d = NULL) => -0.0721896139, -0.0721896139),
(mth_pp_eda_hist_did_dt = NULL) => -0.0105881042, -0.0105881042);

// Tree: 82 
final_score_82 := map(
(NULL < mth_phone_fb_rp_date and mth_phone_fb_rp_date <= 7.5) => -0.0121476543,
(mth_phone_fb_rp_date > 7.5) => 
   map(
   (NULL < mth_phone_fb_rp_date and mth_phone_fb_rp_date <= 10.5) => 0.4425393777,
   (mth_phone_fb_rp_date > 10.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 1.5) => -0.0273733086,
      (f_varrisktype_i > 1.5) => 0.2838772414,
      (f_varrisktype_i = NULL) => 0.0580140104, 0.0580140104),
   (mth_phone_fb_rp_date = NULL) => 0.0970016719, 0.0970016719),
(mth_phone_fb_rp_date = NULL) => -0.0053494731, -0.0053494731);

// Tree: 83 
final_score_83 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 11.5) => -0.0097278961,
(inq_adl_lastseen_n > 11.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 108.5) => 0.1422163006,
      (f_prevaddrageoldest_d > 108.5) => -0.3591257664,
      (f_prevaddrageoldest_d = NULL) => -0.0988135393, -0.0988135393),
   (f_mos_inq_banko_om_fseen_d > 21.5) => 0.0978248924,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0678389732, 0.0678389732),
(inq_adl_lastseen_n = NULL) => -0.0031775488, -0.0031775488);

// Tree: 84 
final_score_84 := map(
(NULL < _pp_rule_targ_non_pub and _pp_rule_targ_non_pub <= 0.5) => 
   map(
   (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 1.5) => -0.0003068380,
   (f_divaddrsuspidcountnew_i > 1.5) => 
      map(
      (NULL < mth_exp_last_update and mth_exp_last_update <= 2.5) => 0.2619991516,
      (mth_exp_last_update > 2.5) => -0.1046067193,
      (mth_exp_last_update = NULL) => 0.1823531477, 0.1823531477),
   (f_divaddrsuspidcountnew_i = NULL) => 0.0068201347, 0.0068201347),
(_pp_rule_targ_non_pub > 0.5) => 0.2813864126,
(_pp_rule_targ_non_pub = NULL) => 0.0086220184, 0.0086220184);

// Tree: 85 
final_score_85 := map(
(NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 57.5) => 
   map(
   (NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 46.5) => 0.0000555079,
   (mth_source_ppla_fseen > 46.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 1607.5) => -0.0487287518,
      (f_addrchangevaluediff_d > 1607.5) => 0.3725503379,
      (f_addrchangevaluediff_d = NULL) => 0.1600467263, 0.1600467263),
   (mth_source_ppla_fseen = NULL) => 0.0026295747, 0.0026295747),
(mth_source_ppla_lseen > 57.5) => -0.2723372804,
(mth_source_ppla_lseen = NULL) => 0.0006548251, 0.0006548251);

// Tree: 86 
final_score_86 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 66.5) => -0.0160595414,
(r_pb_order_freq_d > 66.5) => 
   map(
   (NULL < pp_total_source_conf and pp_total_source_conf <= 14.5) => 
      map(
      (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 0.5) => 0.0802710802,
      (f_srchfraudsrchcountyr_i > 0.5) => -0.0882557781,
      (f_srchfraudsrchcountyr_i = NULL) => 0.0363122945, 0.0363122945),
   (pp_total_source_conf > 14.5) => 0.2351629215,
   (pp_total_source_conf = NULL) => 0.0544427929, 0.0544427929),
(r_pb_order_freq_d = NULL) => -0.0050240976, 0.0030636692);

// Tree: 87 
final_score_87 := map(
(NULL < f_divrisktype_i and f_divrisktype_i <= 2.5) => -0.0073357442,
(f_divrisktype_i > 2.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 106) => -0.0600419969,
   (f_prevaddrmurderindex_i > 106) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 25712) => -0.0060125181,
      (f_addrchangevaluediff_d > 25712) => 0.3898083635,
      (f_addrchangevaluediff_d = NULL) => 0.1745807591, 0.1745807591),
   (f_prevaddrmurderindex_i = NULL) => 0.0584366585, 0.0584366585),
(f_divrisktype_i = NULL) => -0.0040613781, -0.0040613781);

// Tree: 88 
final_score_88 := map(
(NULL < _pp_app_nonpub_gong_la and _pp_app_nonpub_gong_la <= 0.5) => 
   map(
   (NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => -0.0129145618,
   (_inq_adl_ph_industry_flag > 0.5) => 
      map(
      (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 9.5) => 0.2771003878,
      (inq_adl_firstseen_n > 9.5) => -0.0343328856,
      (inq_adl_firstseen_n = NULL) => 0.1118500795, 0.1118500795),
   (_inq_adl_ph_industry_flag = NULL) => -0.0090936447, -0.0090936447),
(_pp_app_nonpub_gong_la > 0.5) => 0.2537237607,
(_pp_app_nonpub_gong_la = NULL) => -0.0066203754, -0.0066203754);

// Tree: 89 
final_score_89 := map(
(pp_app_ph_use in ['B','P']) => -0.0138835134,
(pp_app_ph_use in ['O']) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 7.5) => -0.1378011419,
   (f_prevaddrlenofres_d > 7.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 1.00785292764485) => 0.0490133250,
      (f_add_input_mobility_index_n > 1.00785292764485) => 0.2739338015,
      (f_add_input_mobility_index_n = NULL) => 0.0563437045, 0.0563437045),
   (f_prevaddrlenofres_d = NULL) => 0.0349272466, 0.0349272466),
(pp_app_ph_use = '') => -0.0068651593, 0.0025131665);

// Tree: 90 
final_score_90 := map(
(NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 22.5) => 
   map(
   (NULL < f_acc_damage_amt_last_i and f_acc_damage_amt_last_i <= 125) => -0.0077378346,
   (f_acc_damage_amt_last_i > 125) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 23) => 0.0343339474,
      (r_pb_order_freq_d > 23) => 0.3973440488,
      (r_pb_order_freq_d = NULL) => 0.0287093815, 0.1316237231),
   (f_acc_damage_amt_last_i = NULL) => -0.0036650727, -0.0036650727),
(mth_source_rel_fseen > 22.5) => 0.1439348743,
(mth_source_rel_fseen = NULL) => -0.0024040033, -0.0024040033);

// Tree: 91 
final_score_91 := map(
(NULL < mth_source_ppfla_lseen and mth_source_ppfla_lseen <= 17.5) => -0.0068705894,
(mth_source_ppfla_lseen > 17.5) => 
   map(
   (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 11.5) => 0.2489892852,
   (mth_pp_eda_hist_did_dt > 11.5) => 
      map(
      (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 39.5) => 0.1210978765,
      (mth_source_ppdid_lseen > 39.5) => -0.1285665672,
      (mth_source_ppdid_lseen = NULL) => 0.0168565366, 0.0168565366),
   (mth_pp_eda_hist_did_dt = NULL) => 0.0898594151, 0.0898594151),
(mth_source_ppfla_lseen = NULL) => -0.0034809669, -0.0034809669);

// Tree: 92 
final_score_92 := map(
(pp_source in ['CELL','GONG','INQUIRY','INTRADO','OTHER','THRIVE']) => -0.0527402520,
(pp_source in ['HEADER','IBEHAVIOR','INFUTOR','PCNSR','TARGUS']) => 0.0337714613,
(pp_source = '') => 
   map(
   (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandfather','Grandparent','Grandson','Husband','Neighbor','Parent','Sister','Son','Subject']) => -0.0568161274,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Father','Grandchild','Granddaughter','Grandmother','Mother','Relative','Sibling','Spouse','Subject at Household','Wife']) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 253.5) => 0.0385421688,
      (f_prevaddrageoldest_d > 253.5) => 0.2516213160,
      (f_prevaddrageoldest_d = NULL) => 0.0681867529, 0.0681867529),
   (phone_subject_title = '') => -0.0143345714, -0.0143345714), -0.0084888835);

// Tree: 93 
final_score_93 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 24.5) => -0.0065139708,
(f_rel_under500miles_cnt_d > 24.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By SSN','Associate By Vehicle','Brother','Daughter','Grandfather','Grandmother','Grandson','Mother','Parent','Sister','Son','Subject at Household','Wife']) => -0.0339267191,
   (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Child','Father','Grandchild','Granddaughter','Grandparent','Husband','Neighbor','Relative','Sibling','Spouse','Subject']) => 
      map(
      (NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 3.5) => 0.1058781512,
      (f_inq_per_ssn_i > 3.5) => 0.4840379619,
      (f_inq_per_ssn_i = NULL) => 0.1595416277, 0.1595416277),
   (phone_subject_title = '') => 0.0799821900, 0.0799821900),
(f_rel_under500miles_cnt_d = NULL) => 0.0017186409, 0.0017186409);

// Tree: 94 
final_score_94 := map(
(NULL < eda_months_addr_last_seen and eda_months_addr_last_seen <= 0.5) => -0.0011252863,
(eda_months_addr_last_seen > 0.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Mother','Neighbor','Relative','Sibling','Spouse','Subject']) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 18961) => -0.1210520580,
      (f_addrchangevaluediff_d > 18961) => 0.1786562864,
      (f_addrchangevaluediff_d = NULL) => 0.0575538405, 0.0246988862),
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Parent','Sister','Son','Subject at Household','Wife']) => 0.2427542755,
   (phone_subject_title = '') => 0.0656595671, 0.0656595671),
(eda_months_addr_last_seen = NULL) => 0.0033650772, 0.0033650772);

// Tree: 95 
final_score_95 := map(
(NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 8.5) => 
   map(
   (NULL < f_college_income_d and f_college_income_d <= 10.5) => 
      map(
      (phone_subject_title in ['Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Daughter','Father','Grandfather','Neighbor','Relative','Sister','Spouse','Subject','Subject at Household','Wife']) => -0.0460633623,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Child','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Mother','Parent','Sibling','Son']) => 0.1560204024,
      (phone_subject_title = '') => 0.0006807275, 0.0006807275),
   (f_college_income_d > 10.5) => -0.3026605191,
   (f_college_income_d = NULL) => 0.0052335588, 0.0026151531),
(f_rel_incomeover100_count_d > 8.5) => -0.2331963802,
(f_rel_incomeover100_count_d = NULL) => 0.0004469059, 0.0004469059);

// Tree: 96 
final_score_96 := map(
(NULL < mth_source_ppfla_lseen and mth_source_ppfla_lseen <= 3.5) => -0.0021198177,
(mth_source_ppfla_lseen > 3.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 72.5) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 2.5) => -0.2878181434,
      (f_rel_ageover40_count_d > 2.5) => -0.0425282313,
      (f_rel_ageover40_count_d = NULL) => -0.1584458269, -0.1584458269),
   (r_pb_order_freq_d > 72.5) => 0.0247994494,
   (r_pb_order_freq_d = NULL) => -0.0339068428, -0.0701492236),
(mth_source_ppfla_lseen = NULL) => -0.0067865204, -0.0067865204);

// Tree: 97 
final_score_97 := map(
(pp_src in ['CY','E1','EM','LP','PL','SL','VW','ZT']) => -0.3337332406,
(pp_src in ['E2','EN','EQ','FA','FF','KW','LA','MD','NW','TN','UT','UW','VO','ZK']) => 
   map(
   (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => -0.0689365142,
   (f_bus_name_nover_i > 0.5) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 88.5) => -0.1555007936,
      (mth_pp_app_npa_effective_dt > 88.5) => 0.0964274134,
      (mth_pp_app_npa_effective_dt = NULL) => 0.0461191693, 0.0461191693),
   (f_bus_name_nover_i = NULL) => -0.0207064756, -0.0207064756),
(pp_src = '') => 0.0117428631, 0.0031928962);

// Tree: 98 
final_score_98 := map(
(NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => 0.0268985591,
(f_sourcerisktype_i > 4.5) => 
   map(
   (NULL < f_divssnidmsrcurelcount_i and f_divssnidmsrcurelcount_i <= 0.5) => 0.0814330180,
   (f_divssnidmsrcurelcount_i > 0.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Grandmother','Grandparent','Grandson','Mother','Parent','Relative','Sister','Spouse','Subject','Subject at Household']) => -0.0682101436,
      (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Husband','Neighbor','Sibling','Son','Wife']) => 0.0223150292,
      (phone_subject_title = '') => -0.0285610634, -0.0285610634),
   (f_divssnidmsrcurelcount_i = NULL) => -0.0099503511, -0.0099503511),
(f_sourcerisktype_i = NULL) => 0.0100710726, 0.0100710726);

// Tree: 99 
final_score_99 := map(
(exp_source in ['P']) => -0.0635592467,
(exp_source in ['S']) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 
      map(
      (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 1.5) => 0.0098283406,
      (f_crim_rel_under25miles_cnt_i > 1.5) => -0.2879367763,
      (f_crim_rel_under25miles_cnt_i = NULL) => -0.0159164412, -0.0159164412),
   (f_rel_criminal_count_i > 2.5) => 0.1044031364,
   (f_rel_criminal_count_i = NULL) => 0.0407167393, 0.0407167393),
(exp_source = '') => 0.0002275111, 0.0024968586);

// Tree: 100 
final_score_100 := map(
(NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 108.5) => -0.0036462073,
(mth_pp_eda_hist_did_dt > 108.5) => 
   map(
   (NULL < mth_pp_datevendorlastseen and mth_pp_datevendorlastseen <= 13.5) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 82.5) => -0.0004532502,
      (mth_pp_app_npa_last_change_dt > 82.5) => 0.3018540935,
      (mth_pp_app_npa_last_change_dt = NULL) => 0.1824881037, 0.1824881037),
   (mth_pp_datevendorlastseen > 13.5) => -0.1070532765,
   (mth_pp_datevendorlastseen = NULL) => 0.1037690410, 0.1037690410),
(mth_pp_eda_hist_did_dt = NULL) => 0.0006099690, 0.0006099690);

// Tree: 101 
final_score_101 := map(
(NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 246.5) => 
   map(
   (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 209) => -0.0016568957,
   (mth_source_inf_fseen > 209) => 0.2596156722,
   (mth_source_inf_fseen = NULL) => 0.0000831704, 0.0000831704),
(mth_source_inf_fseen > 246.5) => 
   map(
   (NULL < eda_days_in_service and eda_days_in_service <= 792) => -0.3566132055,
   (eda_days_in_service > 792) => -0.0009213744,
   (eda_days_in_service = NULL) => -0.1516382520, -0.1516382520),
(mth_source_inf_fseen = NULL) => -0.0021336607, -0.0021336607);

// Tree: 102 
final_score_102 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 22461.5) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 1.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Vehicle','Father','Grandfather','Mother','Neighbor','Parent','Son','Spouse']) => -0.0636197587,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Relative','Sibling','Sister','Subject','Subject at Household','Wife']) => 0.2076438626,
      (phone_subject_title = '') => 0.1078687376, 0.1078687376),
   (f_rel_homeover200_count_d > 1.5) => -0.0454954117,
   (f_rel_homeover200_count_d = NULL) => 0.0489994961, 0.0489994961),
(f_prevaddrmedianincome_d > 22461.5) => 0.0000509787,
(f_prevaddrmedianincome_d = NULL) => 0.0043967052, 0.0043967052);

// Tree: 103 
final_score_103 := map(
(NULL < _pp_rule_ins_ver_above and _pp_rule_ins_ver_above <= 0.5) => -0.0015025704,
(_pp_rule_ins_ver_above > 0.5) => 
   map(
   (NULL < f_adl_util_misc_n and f_adl_util_misc_n <= 0.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 74) => 0.0624519016,
      (f_mos_inq_banko_cm_fseen_d > 74) => 0.3237065730,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.1806385387, 0.1806385387),
   (f_adl_util_misc_n > 0.5) => -0.0569354655,
   (f_adl_util_misc_n = NULL) => 0.0797509479, 0.0797509479),
(_pp_rule_ins_ver_above = NULL) => 0.0014352735, 0.0014352735);

// Tree: 104 
final_score_104 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 535) => -0.0027676314,
(r_pb_order_freq_d > 535) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 125.5) => 0.0115894479,
   (f_prevaddrlenofres_d > 125.5) => 0.4474275298,
   (f_prevaddrlenofres_d = NULL) => 0.1706544413, 0.1706544413),
(r_pb_order_freq_d = NULL) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Father','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => 0.0009264838,
   (phone_subject_title in ['Associate By Property','Brother','Grandchild','Granddaughter','Grandparent','Spouse']) => 0.4671193337,
   (phone_subject_title = '') => 0.0118063041, 0.0118063041), 0.0058190569);

// Tree: 105 
final_score_105 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 27.5) => -0.0027407681,
(f_srchaddrsrchcount_i > 27.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 1.5) => 0.2805686869,
   (f_util_adl_count_n > 1.5) => 
      map(
      (NULL < f_wealth_index_d and f_wealth_index_d <= 3.5) => 0.1245990583,
      (f_wealth_index_d > 3.5) => -0.1855584624,
      (f_wealth_index_d = NULL) => 0.0223014901, 0.0223014901),
   (f_util_adl_count_n = NULL) => 0.1147890673, 0.1147890673),
(f_srchaddrsrchcount_i = NULL) => 0.0037215535, 0.0037215535);

// Tree: 106 
final_score_106 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 192.5) => -0.0042467421,
(f_curraddrcartheftindex_i > 192.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 19) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 4.5) => 0.3050999772,
      (f_rel_under100miles_cnt_d > 4.5) => -0.0262378603,
      (f_rel_under100miles_cnt_d = NULL) => 0.0467525039, 0.0467525039),
   (f_srchaddrsrchcount_i > 19) => 0.4212987065,
   (f_srchaddrsrchcount_i = NULL) => 0.0936881183, 0.0936881183),
(f_curraddrcartheftindex_i = NULL) => 0.0005917930, 0.0005917930);

// Tree: 107 
final_score_107 := map(
(NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 11.5) => 
   map(
   (NULL < mth_source_edahistory_fseen and mth_source_edahistory_fseen <= 13.5) => 
      map(
      (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0244925307,
      (_phone_match_code_n > 0.5) => 0.0512598099,
      (_phone_match_code_n = NULL) => 0.0052921644, 0.0052921644),
   (mth_source_edahistory_fseen > 13.5) => -0.1958422098,
   (mth_source_edahistory_fseen = NULL) => -0.0000248516, -0.0000248516),
(mth_source_ppth_lseen > 11.5) => -0.2342346238,
(mth_source_ppth_lseen = NULL) => -0.0104361082, -0.0104361082);

// Tree: 108 
final_score_108 := map(
(NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 3.5) => -0.0021634970,
(mth_source_rel_fseen > 3.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 69) => 0.0635774436,
   (f_curraddrcrimeindex_i > 69) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 1.5) => -0.3447697980,
      (f_inq_count24_i > 1.5) => -0.0229197572,
      (f_inq_count24_i = NULL) => -0.1653140177, -0.1653140177),
   (f_curraddrcrimeindex_i = NULL) => -0.0868890549, -0.0868890549),
(mth_source_rel_fseen = NULL) => -0.0047967455, -0.0047967455);

// Tree: 109 
final_score_109 := map(
(exp_source in ['P']) => -0.0523573374,
(exp_source in ['S']) => 
   map(
   (phone_subject_title in ['Associate','Daughter','Father','Grandfather','Grandmother','Grandparent','Mother','Neighbor','Relative','Sibling','Sister','Son','Subject','Subject at Household']) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 71.5) => -0.0411207376,
      (f_mos_inq_banko_cm_lseen_d > 71.5) => 0.0899235454,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0164946160, 0.0164946160),
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandson','Husband','Parent','Spouse','Wife']) => 0.2942772127,
   (phone_subject_title = '') => 0.0459915974, 0.0459915974),
(exp_source = '') => -0.0058262302, -0.0007566337);

// Tree: 110 
final_score_110 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0033590123,
(source_utildid > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => -0.0677287164,
   (f_mos_inq_banko_om_fseen_d > 36.5) => 
      map(
      (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 35.5) => 0.1579630704,
      (inq_adl_firstseen_n > 35.5) => -0.0591850079,
      (inq_adl_firstseen_n = NULL) => 0.1146122743, 0.1146122743),
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0665893129, 0.0665893129),
(source_utildid = NULL) => 0.0031196092, 0.0031196092);

// Tree: 111 
final_score_111 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 51289) => -0.0235688314,
(f_curraddrmedianincome_d > 51289) => 
   map(
   (NULL < eda_days_in_service and eda_days_in_service <= 477.5) => 
      map(
      (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 20.5) => 0.0792534459,
      (mth_source_ppdid_fseen > 20.5) => -0.0218190644,
      (mth_source_ppdid_fseen = NULL) => 0.0520431177, 0.0520431177),
   (eda_days_in_service > 477.5) => -0.0379849936,
   (eda_days_in_service = NULL) => 0.0195805238, 0.0195805238),
(f_curraddrmedianincome_d = NULL) => -0.0019327027, -0.0019327027);

// Tree: 112 
final_score_112 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 343.5) => -0.0070504851,
(f_prevaddrageoldest_d > 343.5) => 
   map(
   (NULL < f_vardobcount_i and f_vardobcount_i <= 1.5) => -0.0129763885,
   (f_vardobcount_i > 1.5) => 
      map(
      (NULL < eda_days_in_service and eda_days_in_service <= 179) => 0.3648734221,
      (eda_days_in_service > 179) => 0.0682034068,
      (eda_days_in_service = NULL) => 0.2115939142, 0.2115939142),
   (f_vardobcount_i = NULL) => 0.0816902496, 0.0816902496),
(f_prevaddrageoldest_d = NULL) => -0.0023579410, -0.0023579410);

// Tree: 113 
final_score_113 := map(
(NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 5.5) => 
   map(
   (NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 154.5) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 23.5) => -0.0025341669,
      (f_rel_ageover30_count_d > 23.5) => -0.1188241195,
      (f_rel_ageover30_count_d = NULL) => -0.0107300363, -0.0107300363),
   (mth_source_cr_fseen > 154.5) => 0.2812354813,
   (mth_source_cr_fseen = NULL) => -0.0065450638, -0.0065450638),
(f_srchaddrsrchcountmo_i > 5.5) => 0.3633546788,
(f_srchaddrsrchcountmo_i = NULL) => -0.0041175395, -0.0041175395);

// Tree: 114 
final_score_114 := map(
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Granddaughter','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Wife']) => -0.1850154910,
(phone_subject_title in ['Associate','Grandchild','Grandparent','Subject','Subject at Household']) => 
   map(
   (exp_source in ['S']) => 0.2980051127,
   (exp_source in ['P']) => 0.3896267129,
   (exp_source = '') => 
      map(
      (NULL < source_rel and source_rel <= 0.5) => 0.0028934965,
      (source_rel > 0.5) => 0.4123935093,
      (source_rel = NULL) => 0.0492629247, 0.0492629247), 0.1373545829),
(phone_subject_title = '') => -0.0181622333, -0.0181622333);

// Tree: 115 
final_score_115 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 536.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 4.5) => -0.1709677383,
   (f_curraddrcartheftindex_i > 4.5) => -0.0063223311,
   (f_curraddrcartheftindex_i = NULL) => -0.0124965339, -0.0124965339),
(r_pb_order_freq_d > 536.5) => 
   map(
   (NULL < _phone_match_code_a and _phone_match_code_a <= 0.5) => -0.0597162213,
   (_phone_match_code_a > 0.5) => 0.2689894879,
   (_phone_match_code_a = NULL) => 0.0987246601, 0.0987246601),
(r_pb_order_freq_d = NULL) => -0.0080916031, -0.0088712226);

// Tree: 116 
final_score_116 := map(
(pp_src in ['E1','EM','LP','PL','UW']) => -0.0765483944,
(pp_src in ['CY','E2','EN','EQ','FA','FF','KW','LA','MD','NW','SL','TN','UT','VO','VW','ZK','ZT']) => 
   map(
   (pp_origphonetype in ['O','W']) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -12101) => 0.1721037891,
      (f_addrchangeincomediff_d > -12101) => -0.0825296073,
      (f_addrchangeincomediff_d = NULL) => -0.0435792278, -0.0250928398),
   (pp_origphonetype in ['L','V']) => 0.1993313239,
   (pp_origphonetype = '') => 0.0471776752, 0.0331010131),
(pp_src = '') => -0.0055946234, -0.0021084896);

// Tree: 117 
final_score_117 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 86618) => -0.0100777208,
(f_addrchangeincomediff_d > 86618) => 0.1888598451,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 34.5) => 
      map(
      (NULL < _phone_fb_rp_result and _phone_fb_rp_result <= 0.5) => 0.2504729434,
      (_phone_fb_rp_result > 0.5) => -0.0038305666,
      (_phone_fb_rp_result = NULL) => 0.0105664411, 0.0105664411),
   (mth_source_utildid_fseen > 34.5) => 0.2240125649,
   (mth_source_utildid_fseen = NULL) => 0.0193107789, 0.0193107789), -0.0012763985);

// Tree: 118 
final_score_118 := map(
(NULL < eda_months_addr_last_seen and eda_months_addr_last_seen <= 0.5) => -0.0052280847,
(eda_months_addr_last_seen > 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 1.5) => 
      map(
      (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 1644.5) => 0.3780904804,
      (eda_days_ph_first_seen > 1644.5) => 0.0993057996,
      (eda_days_ph_first_seen = NULL) => 0.1304201613, 0.1304201613),
   (f_varrisktype_i > 1.5) => -0.1288275942,
   (f_varrisktype_i = NULL) => 0.0866510598, 0.0866510598),
(eda_months_addr_last_seen = NULL) => 0.0009040177, 0.0009040177);

// Tree: 119 
final_score_119 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 193.5) => -0.0023134123,
(f_curraddrcartheftindex_i > 193.5) => 
   map(
   (NULL < inq_num_addresses and inq_num_addresses <= 1.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Father','Grandparent','Grandson','Mother','Relative','Sibling','Sister','Subject at Household']) => -0.1707957525,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Vehicle','Grandchild','Granddaughter','Grandfather','Grandmother','Husband','Neighbor','Parent','Son','Spouse','Subject','Wife']) => 0.1327170367,
      (phone_subject_title = '') => 0.0382908356, 0.0382908356),
   (inq_num_addresses > 1.5) => 0.3157453242,
   (inq_num_addresses = NULL) => 0.1236614475, 0.1236614475),
(f_curraddrcartheftindex_i = NULL) => 0.0027561555, 0.0027561555);

// Tree: 120 
final_score_120 := map(
(pp_source in ['GONG','OTHER','PCNSR']) => -0.2863058283,
(pp_source in ['CELL','HEADER','IBEHAVIOR','INFUTOR','INQUIRY','INTRADO','TARGUS','THRIVE']) => 
   map(
   (NULL < pp_app_latest_ph_owner_fl and pp_app_latest_ph_owner_fl <= 0.5) => 0.1920138461,
   (pp_app_latest_ph_owner_fl > 0.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -120.5) => 0.1377242594,
      (f_addrchangecrimediff_i > -120.5) => -0.0137884237,
      (f_addrchangecrimediff_i = NULL) => -0.0121153147, -0.0078569588),
   (pp_app_latest_ph_owner_fl = NULL) => -0.0018347003, -0.0018347003),
(pp_source = '') => 0.0103057152, 0.0009404523);

// Tree: 121 
final_score_121 := map(
(NULL < source_rel and source_rel <= 0.5) => -0.0122726982,
(source_rel > 0.5) => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 2499.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 157897) => -0.2211054596,
      (f_prevaddrmedianvalue_d > 157897) => 0.1211928545,
      (f_prevaddrmedianvalue_d = NULL) => -0.0296504704, -0.0296504704),
   (eda_days_ph_first_seen > 2499.5) => 0.1322340381,
   (eda_days_ph_first_seen = NULL) => 0.0753817405, 0.0753817405),
(source_rel = NULL) => -0.0086258568, -0.0086258568);

// Tree: 122 
final_score_122 := map(
(NULL < _phone_fb_rp_result and _phone_fb_rp_result <= 0.5) => 
   map(
   (phone_subject_title in ['Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Grandfather','Husband','Neighbor','Parent','Sister','Subject at Household','Wife']) => -0.0337839642,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By SSN','Brother','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Mother','Relative','Sibling','Son','Spouse','Subject']) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 4.5) => 0.0076396986,
      (f_rel_incomeover50_count_d > 4.5) => 0.3160880923,
      (f_rel_incomeover50_count_d = NULL) => 0.2068766993, 0.2068766993),
   (phone_subject_title = '') => 0.0901029291, 0.0901029291),
(_phone_fb_rp_result > 0.5) => -0.0083105920,
(_phone_fb_rp_result = NULL) => -0.0033631069, -0.0033631069);

// Tree: 123 
final_score_123 := map(
(NULL < _pp_src_all_uw and _pp_src_all_uw <= 0.5) => 0.0000506309,
(_pp_src_all_uw > 0.5) => 
   map(
   (NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 48.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 71.5) => 0.2579748672,
      (f_mos_inq_banko_cm_fseen_d > 71.5) => 0.0525320197,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.1284386140, 0.1284386140),
   (r_mos_since_paw_fseen_d > 48.5) => -0.1695356293,
   (r_mos_since_paw_fseen_d = NULL) => 0.0769613361, 0.0769613361),
(_pp_src_all_uw = NULL) => 0.0029171641, 0.0029171641);

// Tree: 124 
final_score_124 := map(
(NULL < inq_num_adls and inq_num_adls <= 2.5) => -0.0121485577,
(inq_num_adls > 2.5) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 4.5) => 0.2868254563,
   (f_rel_educationover12_count_d > 4.5) => 
      map(
      (NULL < _pp_origlistingtype_res and _pp_origlistingtype_res <= 0.5) => 0.0712781441,
      (_pp_origlistingtype_res > 0.5) => -0.1820720805,
      (_pp_origlistingtype_res = NULL) => 0.0284282118, 0.0284282118),
   (f_rel_educationover12_count_d = NULL) => 0.0760980483, 0.0760980483),
(inq_num_adls = NULL) => -0.0057890326, -0.0057890326);

// Tree: 125 
final_score_125 := map(
(NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 149) => 
   map(
   (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 2.5) => 0.0165708223,
   (f_rel_ageover40_count_d > 2.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 51.5) => -0.0403574381,
      (f_addrchangecrimediff_i > 51.5) => 0.0792404624,
      (f_addrchangecrimediff_i = NULL) => -0.0175267808, -0.0208482774),
   (f_rel_ageover40_count_d = NULL) => -0.0044557722, -0.0044557722),
(mth_source_ppdid_fseen > 149) => 0.2399784870,
(mth_source_ppdid_fseen = NULL) => -0.0028213678, -0.0028213678);

// Tree: 126 
final_score_126 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 0.5) => 
   map(
   (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 573.5) => 0.0166142357,
   (eda_avg_days_interrupt > 573.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 0.1082286544,
      (f_util_adl_count_n > 3.5) => 0.5596828643,
      (f_util_adl_count_n = NULL) => 0.2453194616, 0.2453194616),
   (eda_avg_days_interrupt = NULL) => 0.0340177011, 0.0340177011),
(f_rel_homeover200_count_d > 0.5) => -0.0161732029,
(f_rel_homeover200_count_d = NULL) => -0.0005352723, -0.0005352723);

// Tree: 127 
final_score_127 := map(
(NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 63.5) => -0.0163088486,
(r_mos_since_paw_fseen_d > 63.5) => 
   map(
   (NULL < _phone_match_code_a and _phone_match_code_a <= 0.5) => 0.0110084589,
   (_phone_match_code_a > 0.5) => 
      map(
      (NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 17.5) => 0.1761561664,
      (mth_source_ppla_fseen > 17.5) => -0.1054385800,
      (mth_source_ppla_fseen = NULL) => 0.1410959509, 0.1410959509),
   (_phone_match_code_a = NULL) => 0.0671246320, 0.0671246320),
(r_mos_since_paw_fseen_d = NULL) => -0.0041890378, -0.0041890378);

// Tree: 128 
final_score_128 := map(
(NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => -0.0169016733,
(f_prevaddrstatus_i > 2.5) => 0.0061332598,
(f_prevaddrstatus_i = NULL) => 
   map(
   (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 64.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 98.5) => 0.0792705870,
      (r_pb_order_freq_d > 98.5) => 0.0108139116,
      (r_pb_order_freq_d = NULL) => -0.0245721192, 0.0303526888),
   (mth_pp_datevendorfirstseen > 64.5) => 0.3139794509,
   (mth_pp_datevendorfirstseen = NULL) => 0.0373036570, 0.0373036570), 0.0028473487);

// Tree: 129 
final_score_129 := map(
(NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0162690264,
(_pp_rule_high_vend_conf > 0.5) => 
   map(
   (NULL < mth_source_ppca_lseen and mth_source_ppca_lseen <= 12.5) => 
      map(
      (NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 1.5) => 0.1031030647,
      (mth_source_ppth_lseen > 1.5) => -0.1711748982,
      (mth_source_ppth_lseen = NULL) => 0.0696218680, 0.0696218680),
   (mth_source_ppca_lseen > 12.5) => -0.1207953567,
   (mth_source_ppca_lseen = NULL) => 0.0317768171, 0.0317768171),
(_pp_rule_high_vend_conf = NULL) => -0.0086659323, -0.0086659323);

// Tree: 130 
final_score_130 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0018701351,
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 3.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Grandfather','Grandmother','Neighbor','Parent','Relative','Sibling','Sister','Spouse','Subject','Wife']) => -0.1432265686,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Mother','Son','Subject at Household']) => 0.1479497757,
      (phone_subject_title = '') => -0.0815443524, -0.0815443524),
   (inq_adl_lastseen_n > 3.5) => -0.2742068519,
   (inq_adl_lastseen_n = NULL) => -0.1262531143, -0.1262531143),
(f_varrisktype_i = NULL) => -0.0083087834, -0.0083087834);

// Tree: 131 
final_score_131 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 4.5) => 
   map(
   (NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 138.5) => -0.0182984426,
   (r_mos_since_paw_fseen_d > 138.5) => -0.2070934034,
   (r_mos_since_paw_fseen_d = NULL) => -0.0325127350, -0.0325127350),
(f_rel_under25miles_cnt_d > 4.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 104.5) => 0.0194790138,
   (mth_source_ppdid_fseen > 104.5) => -0.1974803418,
   (mth_source_ppdid_fseen = NULL) => 0.0157431319, 0.0157431319),
(f_rel_under25miles_cnt_d = NULL) => 0.0002154023, 0.0002154023);

// Tree: 132 
final_score_132 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 25.5) => 
   map(
   (NULL < inq_num_adls and inq_num_adls <= 4.5) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 752448.5) => -0.0074923932,
      (f_curraddrmedianvalue_d > 752448.5) => 0.2103558112,
      (f_curraddrmedianvalue_d = NULL) => -0.0058784967, -0.0058784967),
   (inq_num_adls > 4.5) => 0.2065776604,
   (inq_num_adls = NULL) => -0.0034639173, -0.0034639173),
(f_rel_homeover200_count_d > 25.5) => -0.1371500886,
(f_rel_homeover200_count_d = NULL) => -0.0056884234, -0.0056884234);

// Tree: 133 
final_score_133 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.31825514109247) => -0.0224039094,
(f_add_curr_mobility_index_n > 0.31825514109247) => 
   map(
   (NULL < inq_firstseen_n and inq_firstseen_n <= 49.5) => 0.0276964569,
   (inq_firstseen_n > 49.5) => 
      map(
      (NULL < number_of_sources and number_of_sources <= 2.5) => -0.0233980164,
      (number_of_sources > 2.5) => -0.2345359953,
      (number_of_sources = NULL) => -0.0450851524, -0.0450851524),
   (inq_firstseen_n = NULL) => 0.0139637719, 0.0139637719),
(f_add_curr_mobility_index_n = NULL) => 0.1542080586, -0.0006801913);

// Tree: 134 
final_score_134 := map(
(NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 4.5) => 0.0006570570,
(f_assoccredbureaucount_i > 4.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By Vehicle','Daughter','Father','Grandfather','Grandmother','Grandson','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => 0.0403942785,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Brother','Child','Grandchild','Granddaughter','Grandparent','Husband','Mother','Subject at Household']) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 13.5) => 0.4300655813,
      (f_rel_under25miles_cnt_d > 13.5) => 0.0354832720,
      (f_rel_under25miles_cnt_d = NULL) => 0.2058710874, 0.2058710874),
   (phone_subject_title = '') => 0.0754551754, 0.0754551754),
(f_assoccredbureaucount_i = NULL) => 0.0064271446, 0.0064271446);

// Tree: 135 
final_score_135 := map(
(NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 7.5) => -0.0005673915,
(mth_source_utildid_fseen > 7.5) => 
   map(
   (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 42.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.43554239877769) => -0.0364840286,
      (f_add_curr_mobility_index_n > 0.43554239877769) => -0.2193691958,
      (f_add_curr_mobility_index_n = NULL) => -0.0957709784, -0.0957709784),
   (mth_pp_datefirstseen > 42.5) => 0.0972812329,
   (mth_pp_datefirstseen = NULL) => -0.0561562183, -0.0561562183),
(mth_source_utildid_fseen = NULL) => -0.0053305748, -0.0053305748);

// Tree: 136 
final_score_136 := map(
(phone_subject_title in ['Associate By SSN','Brother','Granddaughter','Grandson','Husband','Relative','Sibling','Son','Subject at Household']) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.2700436717205) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.25929435537929) => -0.0419187693,
      (f_add_input_mobility_index_n > 0.25929435537929) => 0.2124225311,
      (f_add_input_mobility_index_n = NULL) => 0.0171030158, 0.0171030158),
   (f_add_curr_mobility_index_n > 0.2700436717205) => -0.0889041476,
   (f_add_curr_mobility_index_n = NULL) => -0.0528839573, -0.0528839573),
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Father','Grandchild','Grandfather','Grandmother','Grandparent','Mother','Neighbor','Parent','Sister','Spouse','Subject','Wife']) => 0.0065062577,
(phone_subject_title = '') => -0.0027229052, -0.0027229052);

// Tree: 137 
final_score_137 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.19919406546493) => -0.0649152446,
(f_add_curr_mobility_index_n > 0.19919406546493) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.209344303584915) => 
      map(
      (phone_subject_title in ['Associate','Child','Father','Grandson','Husband','Neighbor','Sibling','Son','Spouse','Subject','Wife']) => 0.0549291723,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Mother','Parent','Relative','Sister','Subject at Household']) => 0.5365018290,
      (phone_subject_title = '') => 0.2173874180, 0.2173874180),
   (f_add_curr_mobility_index_n > 0.209344303584915) => 0.0018783232,
   (f_add_curr_mobility_index_n = NULL) => 0.0067984868, 0.0067984868),
(f_add_curr_mobility_index_n = NULL) => -0.1896477309, -0.0013691578);

// Tree: 138 
final_score_138 := map(
(NULL < r_paw_active_phone_ct_d and r_paw_active_phone_ct_d <= 1.5) => -0.0000351645,
(r_paw_active_phone_ct_d > 1.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 80.5) => -0.0215281483,
   (f_curraddrcartheftindex_i > 80.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 110.5) => -0.0611010982,
      (f_prevaddrageoldest_d > 110.5) => 0.4047516653,
      (f_prevaddrageoldest_d = NULL) => 0.2125466790, 0.2125466790),
   (f_curraddrcartheftindex_i = NULL) => 0.0997497513, 0.0997497513),
(r_paw_active_phone_ct_d = NULL) => 0.0033750184, 0.0033750184);

// Tree: 139 
final_score_139 := map(
(NULL < source_rel and source_rel <= 0.5) => 
   map(
   (NULL < subject_ssn_mismatch and subject_ssn_mismatch <= -0.5) => 
      map(
      (pp_src in ['CY','E1','E2','EN','FA','KW','PL','UT','ZT']) => -0.0660586767,
      (pp_src in ['EM','EQ','FF','LA','LP','MD','NW','SL','TN','UW','VO','VW','ZK']) => 0.1894415849,
      (pp_src = '') => 0.0513192615, 0.0466824470),
   (subject_ssn_mismatch > -0.5) => -0.0346742168,
   (subject_ssn_mismatch = NULL) => -0.0083214585, -0.0083214585),
(source_rel > 0.5) => 0.0950007279,
(source_rel = NULL) => -0.0041762890, -0.0041762890);

// Tree: 140 
final_score_140 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 49.5) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandfather','Grandmother','Grandson','Husband','Neighbor','Parent','Relative','Sister','Son','Spouse','Subject']) => 0.0108020976,
   (phone_subject_title in ['Associate','Associate By Address','Father','Grandchild','Granddaughter','Grandparent','Mother','Sibling','Subject at Household','Wife']) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 110521.5) => 0.1290327103,
      (f_curraddrmedianincome_d > 110521.5) => -0.1474805078,
      (f_curraddrmedianincome_d = NULL) => 0.1021867668, 0.1021867668),
   (phone_subject_title = '') => 0.0404949081, 0.0404949081),
(f_curraddrcartheftindex_i > 49.5) => -0.0048854165,
(f_curraddrcartheftindex_i = NULL) => 0.0058035467, 0.0058035467);

// Tree: 141 
final_score_141 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 274.5) => -0.0000190538,
(f_prevaddrlenofres_d > 274.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 77291) => 0.0907495715,
   (f_prevaddrmedianvalue_d > 77291) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 78070) => -0.1446025239,
      (f_prevaddrmedianincome_d > 78070) => 0.0991453416,
      (f_prevaddrmedianincome_d = NULL) => -0.0996764467, -0.0996764467),
   (f_prevaddrmedianvalue_d = NULL) => -0.0653875174, -0.0653875174),
(f_prevaddrlenofres_d = NULL) => -0.0075709083, -0.0075709083);

// Tree: 142 
final_score_142 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 8.5) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 18.5) => 0.0110057109,
   (mth_exp_last_update > 18.5) => 
      map(
      (NULL < f_inq_lnames_per_addr_i and f_inq_lnames_per_addr_i <= 1.5) => -0.0141125452,
      (f_inq_lnames_per_addr_i > 1.5) => -0.1999487762,
      (f_inq_lnames_per_addr_i = NULL) => -0.0488455149, -0.0488455149),
   (mth_exp_last_update = NULL) => 0.0062744484, 0.0062744484),
(f_rel_homeover500_count_d > 8.5) => -0.1378356223,
(f_rel_homeover500_count_d = NULL) => 0.0039116948, 0.0039116948);

// Tree: 143 
final_score_143 := map(
(NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Child','Grandmother','Grandson','Mother','Neighbor','Relative','Sibling','Sister','Son','Subject','Subject at Household']) => 0.0096832831,
   (phone_subject_title in ['Associate','Associate By Shared Associates','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Husband','Parent','Spouse','Wife']) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 3.5) => 0.3870069233,
      (f_rel_incomeover50_count_d > 3.5) => 0.0324973297,
      (f_rel_incomeover50_count_d = NULL) => 0.1423453728, 0.1423453728),
   (phone_subject_title = '') => 0.0279868361, 0.0279868361),
(f_crim_rel_under100miles_cnt_i > 0.5) => -0.0126748414,
(f_crim_rel_under100miles_cnt_i = NULL) => 0.0003169003, 0.0003169003);

// Tree: 144 
final_score_144 := map(
(NULL < _internal_ver_match_hhid and _internal_ver_match_hhid <= 0.5) => -0.0095161364,
(_internal_ver_match_hhid > 0.5) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 68) => -0.1087642022,
   (f_fp_prevaddrcrimeindex_i > 68) => 
      map(
      (NULL < f_estimated_income_d and f_estimated_income_d <= 38500) => -0.0122836260,
      (f_estimated_income_d > 38500) => 0.1902902816,
      (f_estimated_income_d = NULL) => 0.1349029854, 0.1349029854),
   (f_fp_prevaddrcrimeindex_i = NULL) => 0.0495393160, 0.0495393160),
(_internal_ver_match_hhid = NULL) => -0.0050701588, -0.0050701588);

// Tree: 145 
final_score_145 := map(
(NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 12.5) => -0.0114633972,
(f_rel_homeover100_count_d > 12.5) => 
   map(
   (pp_source in ['HEADER','IBEHAVIOR','INQUIRY','OTHER','PCNSR','THRIVE']) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 13.5) => -0.1925094850,
      (f_rel_educationover12_count_d > 13.5) => 0.0457896778,
      (f_rel_educationover12_count_d = NULL) => -0.0226870931, -0.0226870931),
   (pp_source in ['CELL','GONG','INFUTOR','INTRADO','TARGUS']) => 0.1597522002,
   (pp_source = '') => 0.0585232086, 0.0442957849),
(f_rel_homeover100_count_d = NULL) => -0.0023930891, -0.0023930891);

// Tree: 146 
final_score_146 := map(
(NULL < inq_num and inq_num <= 0.5) => -0.0173281811,
(inq_num > 0.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 2.5) => 0.1690610521,
   (f_srchssnsrchcount_i > 2.5) => 
      map(
      (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 5.5) => 0.2485434999,
      (inq_adl_lastseen_n > 5.5) => -0.0237547433,
      (inq_adl_lastseen_n = NULL) => 0.0070880998, 0.0070880998),
   (f_srchssnsrchcount_i = NULL) => 0.0631358833, 0.0631358833),
(inq_num = NULL) => -0.0079128095, -0.0079128095);

// Tree: 147 
final_score_147 := map(
(NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => -0.0071953005,
(f_srchunvrfddobcount_i > 0.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 4.5) => 
      map(
      (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 67.5) => 0.3013180037,
      (eda_avg_days_interrupt > 67.5) => -0.0979633521,
      (eda_avg_days_interrupt = NULL) => 0.1863498312, 0.1863498312),
   (inq_adl_lastseen_n > 4.5) => -0.1516719367,
   (inq_adl_lastseen_n = NULL) => 0.1303786943, 0.1303786943),
(f_srchunvrfddobcount_i = NULL) => -0.0019478961, -0.0019478961);

// Tree: 148 
final_score_148 := map(
(NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 17.5) => 
   map(
   (NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 56.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 20607) => -0.3063518728,
      (f_addrchangevaluediff_d > 20607) => 0.0093787926,
      (f_addrchangevaluediff_d = NULL) => -0.0321538570, -0.1353943161),
   (f_mos_inq_banko_am_lseen_d > 56.5) => 0.0088387212,
   (f_mos_inq_banko_am_lseen_d = NULL) => 0.0048878725, 0.0048878725),
(f_rel_incomeover75_count_d > 17.5) => -0.1943314424,
(f_rel_incomeover75_count_d = NULL) => 0.0034530382, 0.0034530382);

// Tree: 149 
final_score_149 := map(
(NULL < internal_verification and internal_verification <= 0.5) => 
   map(
   (NULL < pk_phone_match_level and pk_phone_match_level <= 3.5) => -0.0109222641,
   (pk_phone_match_level > 3.5) => -0.1080782753,
   (pk_phone_match_level = NULL) => -0.0202682815, -0.0202682815),
(internal_verification > 0.5) => 
   map(
   (NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 1.5) => 0.2271517568,
   (mth_internal_ver_first_seen > 1.5) => 0.0214398277,
   (mth_internal_ver_first_seen = NULL) => 0.0288468039, 0.0288468039),
(internal_verification = NULL) => -0.0016889618, -0.0016889618);

// Tree: 150 
final_score_150 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 49.5) => -0.0019446696,
(mth_exp_last_update > 49.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.25282820691216) => -0.1134448971,
   (f_add_curr_mobility_index_n > 0.25282820691216) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 2.5) => 0.2507760824,
      (f_util_adl_count_n > 2.5) => 0.0230120464,
      (f_util_adl_count_n = NULL) => 0.1467968486, 0.1467968486),
   (f_add_curr_mobility_index_n = NULL) => 0.0852458963, 0.0852458963),
(mth_exp_last_update = NULL) => 0.0006788207, 0.0006788207);

// Tree: 151 
final_score_151 := map(
(eda_pfrd_address_ind in ['1A','1B','1E','XX']) => 0.0002850278,
(eda_pfrd_address_ind in ['1C','1D']) => 
   map(
   (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => 0.0099673241,
   (_phone_match_code_n > 0.5) => 
      map(
      (NULL < inq_lastseen_n and inq_lastseen_n <= 3.5) => 0.3637755566,
      (inq_lastseen_n > 3.5) => 0.0099235950,
      (inq_lastseen_n = NULL) => 0.1757917020, 0.1757917020),
   (_phone_match_code_n = NULL) => 0.0679605491, 0.0679605491),
(eda_pfrd_address_ind = '') => 0.0033520462, 0.0033520462);

// Tree: 152 
final_score_152 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 13.5) => -0.2899740915,
(f_mos_inq_banko_cm_fseen_d > 13.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 197.5) => 
      map(
      (NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 12.5) => 0.0169678112,
      (mth_source_ppla_lseen > 12.5) => -0.0634910164,
      (mth_source_ppla_lseen = NULL) => 0.0138113652, 0.0138113652),
   (f_prevaddrmurderindex_i > 197.5) => -0.1758404607,
   (f_prevaddrmurderindex_i = NULL) => 0.0112542619, 0.0112542619),
(f_mos_inq_banko_cm_fseen_d = NULL) => 0.0088295135, 0.0088295135);

// Tree: 153 
final_score_153 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 6.5) => 
   map(
   (NULL < _pp_src_all_iq and _pp_src_all_iq <= 0.5) => 0.0150596792,
   (_pp_src_all_iq > 0.5) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 104.5) => -0.0314545582,
      (mth_pp_app_npa_effective_dt > 104.5) => 0.1231728261,
      (mth_pp_app_npa_effective_dt = NULL) => 0.0778004112, 0.0778004112),
   (_pp_src_all_iq = NULL) => 0.0243061081, 0.0243061081),
(f_rel_incomeover50_count_d > 6.5) => -0.0181952484,
(f_rel_incomeover50_count_d = NULL) => 0.0063324776, 0.0063324776);

// Tree: 154 
final_score_154 := map(
(NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 5155.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 1) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Father','Grandfather','Grandmother','Sibling','Subject','Subject at Household','Wife']) => -0.1309988346,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sister','Son','Spouse']) => 0.2250490225,
      (phone_subject_title = '') => -0.0361271486, -0.0361271486),
   (f_fp_prevaddrburglaryindex_i > 1) => 0.0053829692,
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.0037322926, 0.0037322926),
(eda_days_ph_first_seen > 5155.5) => 0.2452706155,
(eda_days_ph_first_seen = NULL) => 0.0053174253, 0.0053174253);

// Tree: 155 
final_score_155 := map(
(pp_origphonetype in ['O','V','W']) => -0.0317840165,
(pp_origphonetype in ['L']) => 0.0377384804,
(pp_origphonetype = '') => 
   map(
   (segment in ['0 - Disconnected','1 - Other','3 - ExpHit']) => 0.0034757211,
   (segment in ['2 - Cell Phone']) => 
      map(
      (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => -0.0261355091,
      (f_crim_rel_under25miles_cnt_i > 0.5) => 0.1533256493,
      (f_crim_rel_under25miles_cnt_i = NULL) => 0.0904400864, 0.0904400864),
   (segment = '') => 0.0126354243, 0.0126354243), 0.0020914700);

// Tree: 156 
final_score_156 := map(
(eda_pfrd_address_ind in ['1A','1B','1E','XX']) => -0.0113393044,
(eda_pfrd_address_ind in ['1C','1D']) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.51972417082075) => 
      map(
      (NULL < _phone_match_code_c and _phone_match_code_c <= 0.5) => 0.0695037197,
      (_phone_match_code_c > 0.5) => 0.2954182337,
      (_phone_match_code_c = NULL) => 0.1679219238, 0.1679219238),
   (f_add_curr_mobility_index_n > 0.51972417082075) => -0.1482096572,
   (f_add_curr_mobility_index_n = NULL) => 0.1208573907, 0.1208573907),
(eda_pfrd_address_ind = '') => -0.0053809591, -0.0053809591);

// Tree: 157 
final_score_157 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 2.5) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By SSN','Brother','Daughter','Father','Granddaughter','Grandmother','Parent','Spouse','Subject at Household']) => -0.1432540034,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By Vehicle','Child','Grandchild','Grandfather','Grandparent','Grandson','Husband','Mother','Neighbor','Relative','Sibling','Sister','Son','Subject','Wife']) => 
      map(
      (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 12.5) => 0.0119109247,
      (mth_source_utildid_fseen > 12.5) => -0.1363172224,
      (mth_source_utildid_fseen = NULL) => -0.0011532510, -0.0011532510),
   (phone_subject_title = '') => -0.0173059154, -0.0173059154),
(f_rel_incomeover50_count_d > 2.5) => 0.0149030452,
(f_rel_incomeover50_count_d = NULL) => 0.0069167906, 0.0069167906);

// Tree: 158 
final_score_158 := map(
(NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 55.5) => 
   map(
   (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 51.5) => 0.0005050435,
   (mth_pp_datevendorfirstseen > 51.5) => 0.1806413455,
   (mth_pp_datevendorfirstseen = NULL) => 0.0027730333, 0.0027730333),
(mth_pp_datevendorfirstseen > 55.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -7792.5) => -0.1810347785,
   (f_addrchangeincomediff_d > -7792.5) => -0.0013133588,
   (f_addrchangeincomediff_d = NULL) => -0.1603538994, -0.0745643176),
(mth_pp_datevendorfirstseen = NULL) => -0.0030684456, -0.0030684456);

// Tree: 159 
final_score_159 := map(
(NULL < _pp_rule_iq_rpc and _pp_rule_iq_rpc <= 0.5) => 0.0039355567,
(_pp_rule_iq_rpc > 0.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 5.5) => 0.0072601399,
   (inq_adl_lastseen_n > 5.5) => 
      map(
      (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 41.5) => -0.0382415794,
      (mth_pp_eda_hist_did_dt > 41.5) => -0.3486512268,
      (mth_pp_eda_hist_did_dt = NULL) => -0.1898369886, -0.1898369886),
   (inq_adl_lastseen_n = NULL) => -0.0631706900, -0.0631706900),
(_pp_rule_iq_rpc = NULL) => 0.0009358842, 0.0009358842);

// Tree: 160 
final_score_160 := map(
(phone_subject_title in ['Associate','Associate By Business','Associate By SSN','Associate By Vehicle','Daughter','Granddaughter','Grandfather','Grandparent','Grandson','Subject at Household']) => 
   map(
   (NULL < inq_num_addresses_06 and inq_num_addresses_06 <= 0.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 182) => -0.0046872544,
      (f_curraddrcartheftindex_i > 182) => -0.2003476265,
      (f_curraddrcartheftindex_i = NULL) => -0.0215031861, -0.0215031861),
   (inq_num_addresses_06 > 0.5) => -0.1808179710,
   (inq_num_addresses_06 = NULL) => -0.0360217019, -0.0360217019),
(phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Brother','Child','Father','Grandchild','Grandmother','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => 0.0120329293,
(phone_subject_title = '') => 0.0047200093, 0.0047200093);

// Tree: 161 
final_score_161 := map(
(NULL < f_srchcountwk_i and f_srchcountwk_i <= 0.5) => 
   map(
   (NULL < eda_days_ind_first_seen and eda_days_ind_first_seen <= 273.5) => 0.0087956940,
   (eda_days_ind_first_seen > 273.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 251) => -0.1214755440,
      (f_prevaddrlenofres_d > 251) => 0.1102621556,
      (f_prevaddrlenofres_d = NULL) => -0.0804278349, -0.0804278349),
   (eda_days_ind_first_seen = NULL) => 0.0037971142, 0.0037971142),
(f_srchcountwk_i > 0.5) => -0.1929816369,
(f_srchcountwk_i = NULL) => 0.0009950394, 0.0009950394);

// Tree: 162 
final_score_162 := map(
(NULL < inq_firstseen_n and inq_firstseen_n <= 49.5) => 0.0087789486,
(inq_firstseen_n > 49.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Daughter','Grandfather','Grandson','Husband','Neighbor','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 136.5) => -0.0910057693,
      (mth_pp_app_npa_last_change_dt > 136.5) => 0.1488261279,
      (mth_pp_app_npa_last_change_dt = NULL) => -0.0776416425, -0.0776416425),
   (phone_subject_title in ['Associate By Property','Child','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Mother','Parent','Relative','Sibling']) => 0.1202824341,
   (phone_subject_title = '') => -0.0533260030, -0.0533260030),
(inq_firstseen_n = NULL) => -0.0028638073, -0.0028638073);

// Tree: 163 
final_score_163 := map(
(phone_subject_title in ['Associate','Associate By Vehicle','Brother','Child','Daughter','Grandson','Husband','Neighbor','Sister','Son','Subject','Subject at Household','Wife']) => -0.0125523945,
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Mother','Parent','Relative','Sibling','Spouse']) => 
   map(
   (NULL < _pp_app_nonpub_targ_lap and _pp_app_nonpub_targ_lap <= 0.5) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 24.5) => 0.0458279590,
      (f_rel_ageover30_count_d > 24.5) => -0.2096401801,
      (f_rel_ageover30_count_d = NULL) => 0.0247139255, 0.0247139255),
   (_pp_app_nonpub_targ_lap > 0.5) => 0.3258444142,
   (_pp_app_nonpub_targ_lap = NULL) => 0.0324660642, 0.0324660642),
(phone_subject_title = '') => 0.0000066183, 0.0000066183);

// Tree: 164 
final_score_164 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 4.5) => 
   map(
   (phone_subject_title in ['Associate','Brother','Daughter','Grandfather','Grandmother','Parent','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.29224592083119) => -0.3943685701,
      (f_add_curr_mobility_index_n > 0.29224592083119) => -0.1094787560,
      (f_add_curr_mobility_index_n = NULL) => -0.2155326284, -0.2155326284),
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Father','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Mother','Neighbor','Relative','Spouse']) => 0.0865458240,
   (phone_subject_title = '') => -0.1000008694, -0.1000008694),
(f_curraddrcartheftindex_i > 4.5) => -0.0030261291,
(f_curraddrcartheftindex_i = NULL) => -0.0064483432, -0.0064483432);

// Tree: 165 
final_score_165 := map(
(NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 1.5) => 
   map(
   (NULL < f_inq_addrs_per_ssn_i and f_inq_addrs_per_ssn_i <= 2.5) => 0.0005591625,
   (f_inq_addrs_per_ssn_i > 2.5) => 0.2059568841,
   (f_inq_addrs_per_ssn_i = NULL) => 0.0022153870, 0.0022153870),
(f_srchunvrfdaddrcount_i > 1.5) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 6.5) => 0.3558475076,
   (f_inq_count24_i > 6.5) => -0.0391694355,
   (f_inq_count24_i = NULL) => 0.1440268280, 0.1440268280),
(f_srchunvrfdaddrcount_i = NULL) => 0.0046389138, 0.0046389138);

// Tree: 166 
final_score_166 := map(
(NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 1826.5) => 
   map(
   (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => -0.0002696270,
   (f_corrphonelastnamecount_d > 0.5) => 
      map(
      (NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 0.5) => -0.0108874887,
      (f_inq_per_ssn_i > 0.5) => 0.3783309688,
      (f_inq_per_ssn_i = NULL) => 0.1613330677, 0.1613330677),
   (f_corrphonelastnamecount_d = NULL) => 0.0020104460, 0.0020104460),
(eda_avg_days_interrupt > 1826.5) => -0.2986619232,
(eda_avg_days_interrupt = NULL) => -0.0004839879, -0.0004839879);

// Tree: 167 
final_score_167 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 16.5) => 0.0095092929,
(mth_exp_last_update > 16.5) => 
   map(
   (pp_source in ['HEADER','INQUIRY','THRIVE']) => -0.1318004152,
   (pp_source in ['CELL','GONG','IBEHAVIOR','INFUTOR','INTRADO','OTHER','PCNSR','TARGUS']) => 0.0227093195,
   (pp_source = '') => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 92.5) => -0.1932485680,
      (f_prevaddrmurderindex_i > 92.5) => 0.1196502486,
      (f_prevaddrmurderindex_i = NULL) => -0.0263691992, -0.0263691992), -0.0581996478),
(mth_exp_last_update = NULL) => 0.0038584972, 0.0038584972);

// Tree: 168 
final_score_168 := map(
(NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 182) => -0.0117746410,
(f_fp_prevaddrcrimeindex_i > 182) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By SSN','Grandfather','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse']) => -0.0549594303,
   (phone_subject_title in ['Associate','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 4.5) => 0.2019418243,
      (mth_pp_datevendorfirstseen > 4.5) => 0.0104590233,
      (mth_pp_datevendorfirstseen = NULL) => 0.1083123665, 0.1083123665),
   (phone_subject_title = '') => 0.0430757324, 0.0430757324),
(f_fp_prevaddrcrimeindex_i = NULL) => -0.0056212930, -0.0056212930);

// Tree: 169 
final_score_169 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 15.5) => 0.0113696865,
(f_rel_incomeover25_count_d > 15.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 92449.5) => -0.0917974963,
      (f_curraddrmedianincome_d > 92449.5) => 0.1139126535,
      (f_curraddrmedianincome_d = NULL) => -0.0750603005, -0.0750603005),
   (f_util_adl_count_n > 4.5) => 0.0189851708,
   (f_util_adl_count_n = NULL) => -0.0403294729, -0.0403294729),
(f_rel_incomeover25_count_d = NULL) => -0.0032694197, -0.0032694197);

// Tree: 170 
final_score_170 := map(
(pp_app_scc in ['B','C','N']) => -0.0100244594,
(pp_app_scc in ['8','A','J','R','S']) => 
   map(
   (NULL < f_inputaddractivephonelist_d and f_inputaddractivephonelist_d <= 0.5) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 97.5) => 0.2108469267,
      (mth_pp_app_npa_effective_dt > 97.5) => -0.0124147819,
      (mth_pp_app_npa_effective_dt = NULL) => 0.0310307398, 0.0310307398),
   (f_inputaddractivephonelist_d > 0.5) => 0.2291405387,
   (f_inputaddractivephonelist_d = NULL) => 0.0584092679, 0.0584092679),
(pp_app_scc = '') => 0.0058838275, 0.0040998327);

// Tree: 171 
final_score_171 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 160.5) => -0.0179207236,
(f_curraddrcrimeindex_i > 160.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Child','Daughter','Grandfather','Grandmother','Grandparent','Grandson','Neighbor','Parent','Relative','Sibling','Sister','Son','Subject']) => 0.0062886011,
   (phone_subject_title in ['Associate','Associate By Property','Associate By Vehicle','Brother','Father','Grandchild','Granddaughter','Husband','Mother','Spouse','Subject at Household','Wife']) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 8.5) => 0.0761583411,
      (f_rel_ageover40_count_d > 8.5) => 0.2913870231,
      (f_rel_ageover40_count_d = NULL) => 0.1092704460, 0.1092704460),
   (phone_subject_title = '') => 0.0266798510, 0.0266798510),
(f_curraddrcrimeindex_i = NULL) => -0.0084936334, -0.0084936334);

// Tree: 172 
final_score_172 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0027579522,
(source_utildid > 0.5) => 
   map(
   (NULL < inq_lastseen_n and inq_lastseen_n <= 5.5) => 
      map(
      (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 22.5) => 0.2949748375,
      (mth_source_utildid_fseen > 22.5) => 0.0397855055,
      (mth_source_utildid_fseen = NULL) => 0.1189139805, 0.1189139805),
   (inq_lastseen_n > 5.5) => -0.0366460134,
   (inq_lastseen_n = NULL) => 0.0408336747, 0.0408336747),
(source_utildid = NULL) => 0.0014360416, 0.0014360416);

// Tree: 173 
final_score_173 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -64103.5) => 0.1585484733,
(f_addrchangeincomediff_d > -64103.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 194884.5) => 0.0064616325,
   (f_prevaddrmedianvalue_d > 194884.5) => -0.0435580765,
   (f_prevaddrmedianvalue_d = NULL) => -0.0103959311, -0.0103959311),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < f_srchaddrsrchcountwk_i and f_srchaddrsrchcountwk_i <= 0.5) => 0.0089298792,
   (f_srchaddrsrchcountwk_i > 0.5) => 0.2320274370,
   (f_srchaddrsrchcountwk_i = NULL) => 0.0158331926, 0.0158331926), -0.0023367571);

// Tree: 174 
final_score_174 := map(
(NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 1688.5) => 
   map(
   (NULL < f_inq_lnames_per_addr_i and f_inq_lnames_per_addr_i <= 2.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Daughter','Father','Grandmother','Husband','Neighbor','Parent','Relative','Sibling','Son','Subject','Subject at Household']) => 0.0106380142,
      (phone_subject_title in ['Associate By Business','Child','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Mother','Sister','Spouse','Wife']) => 0.3967984529,
      (phone_subject_title = '') => 0.0166318813, 0.0166318813),
   (f_inq_lnames_per_addr_i > 2.5) => 0.1169252959,
   (f_inq_lnames_per_addr_i = NULL) => 0.0283891910, 0.0283891910),
(eda_days_ph_first_seen > 1688.5) => -0.0209452423,
(eda_days_ph_first_seen = NULL) => 0.0031294236, 0.0031294236);

// Tree: 175 
final_score_175 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 11.5) => -0.0119979711,
(inq_adl_lastseen_n > 11.5) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 15.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 38429) => 0.1322473072,
      (f_curraddrmedianincome_d > 38429) => -0.1979531359,
      (f_curraddrmedianincome_d = NULL) => -0.1019646350, -0.1019646350),
   (f_mos_inq_banko_om_lseen_d > 15.5) => 0.0841629140,
   (f_mos_inq_banko_om_lseen_d = NULL) => 0.0391995174, 0.0391995174),
(inq_adl_lastseen_n = NULL) => -0.0074842747, -0.0074842747);

// Tree: 176 
final_score_176 := map(
(NULL < source_sp and source_sp <= 0.5) => -0.0050837168,
(source_sp > 0.5) => 
   map(
   (NULL < eda_days_in_service and eda_days_in_service <= 332.5) => 0.3281951650,
   (eda_days_in_service > 332.5) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 36.5) => -0.2347277508,
      (f_mos_inq_banko_om_lseen_d > 36.5) => 0.1565454067,
      (f_mos_inq_banko_om_lseen_d = NULL) => 0.0503426925, 0.0503426925),
   (eda_days_in_service = NULL) => 0.1096595125, 0.1096595125),
(source_sp = NULL) => -0.0012902000, -0.0012902000);

// Tree: 177 
final_score_177 := map(
(NULL < f_college_income_d and f_college_income_d <= 5.5) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 45492) => -0.0586743020,
   (f_prevaddrmedianincome_d > 45492) => 0.1067247753,
   (f_prevaddrmedianincome_d = NULL) => 0.0201898957, 0.0201898957),
(f_college_income_d > 5.5) => 
   map(
   (exp_type in ['N']) => -0.2546320543,
   (exp_type in ['C']) => 0.0032127010,
   (exp_type = '') => -0.0885665661, -0.0920285767),
(f_college_income_d = NULL) => 0.0088216032, 0.0035365836);

// Tree: 178 
final_score_178 := map(
(NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 131) => 0.0109939875,
(mth_source_inf_fseen > 131) => 
   map(
   (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 1.5) => 0.0832351389,
   (f_rel_ageover40_count_d > 1.5) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 10.5) => -0.2693489903,
      (f_rel_ageover30_count_d > 10.5) => -0.0112009768,
      (f_rel_ageover30_count_d = NULL) => -0.1742418274, -0.1742418274),
   (f_rel_ageover40_count_d = NULL) => -0.0776879651, -0.0776879651),
(mth_source_inf_fseen = NULL) => 0.0076557863, 0.0076557863);

// Tree: 179 
final_score_179 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.424280973105505) => 0.0158696733,
(f_add_curr_mobility_index_n > 0.424280973105505) => 
   map(
   (exp_source in ['S']) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 5.5) => 0.0592739451,
      (f_rel_educationover12_count_d > 5.5) => -0.1213101215,
      (f_rel_educationover12_count_d = NULL) => -0.0884766549, -0.0884766549),
   (exp_source in ['P']) => 0.0703979847,
   (exp_source = '') => -0.0217377907, -0.0266096084),
(f_add_curr_mobility_index_n = NULL) => -0.0090839369, 0.0029722559);

// Tree: 180 
final_score_180 := map(
(pp_source in ['INTRADO','OTHER','THRIVE']) => -0.2664703765,
(pp_source in ['CELL','GONG','HEADER','IBEHAVIOR','INFUTOR','INQUIRY','PCNSR','TARGUS']) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 67688.5) => -0.0092646409,
   (f_prevaddrmedianincome_d > 67688.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 74147) => 0.1871574077,
      (f_prevaddrmedianincome_d > 74147) => 0.0151521924,
      (f_prevaddrmedianincome_d = NULL) => 0.0567310612, 0.0567310612),
   (f_prevaddrmedianincome_d = NULL) => 0.0053597239, 0.0053597239),
(pp_source = '') => -0.0029645708, -0.0014619841);

// Tree: 181 
final_score_181 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 1.5) => 
   map(
   (NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 22.5) => 
      map(
      (NULL < mth_source_ppca_fseen and mth_source_ppca_fseen <= 32.5) => 0.0698653796,
      (mth_source_ppca_fseen > 32.5) => -0.1282780401,
      (mth_source_ppca_fseen = NULL) => 0.0549391071, 0.0549391071),
   (mth_eda_dt_first_seen > 22.5) => -0.0179668313,
   (mth_eda_dt_first_seen = NULL) => 0.0250397585, 0.0250397585),
(f_rel_criminal_count_i > 1.5) => -0.0199913510,
(f_rel_criminal_count_i = NULL) => -0.0035515107, -0.0035515107);

// Tree: 182 
final_score_182 := map(
(NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 4.5) => 0.0081853010,
(mth_source_ppla_fseen > 4.5) => 
   map(
   (NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 46.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 242433.5) => -0.0457718975,
      (f_prevaddrmedianvalue_d > 242433.5) => -0.1918157459,
      (f_prevaddrmedianvalue_d = NULL) => -0.0848728820, -0.0848728820),
   (mth_source_ppfla_fseen > 46.5) => 0.1356565098,
   (mth_source_ppfla_fseen = NULL) => -0.0606191404, -0.0606191404),
(mth_source_ppla_fseen = NULL) => 0.0040021682, 0.0040021682);

// Tree: 183 
final_score_183 := map(
(NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 4.5) => 
   map(
   (pp_source in ['CELL','GONG','IBEHAVIOR','INQUIRY','INTRADO','OTHER','THRIVE']) => 0.0057082663,
   (pp_source in ['HEADER','INFUTOR','PCNSR','TARGUS']) => 
      map(
      (NULL < mth_source_ppca_fseen and mth_source_ppca_fseen <= 9.5) => 0.1360264940,
      (mth_source_ppca_fseen > 9.5) => -0.0263025595,
      (mth_source_ppca_fseen = NULL) => 0.0656136318, 0.0656136318),
   (pp_source = '') => 0.0023906198, 0.0112263393),
(mth_internal_ver_first_seen > 4.5) => -0.0249307230,
(mth_internal_ver_first_seen = NULL) => 0.0009603483, 0.0009603483);

// Tree: 184 
final_score_184 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.921908798785005) => -0.0085720163,
(f_add_input_mobility_index_n > 0.921908798785005) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 262883) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.1197304296,
      (f_srchvelocityrisktype_i > 4.5) => 0.1440766969,
      (f_srchvelocityrisktype_i = NULL) => 0.0221578655, 0.0221578655),
   (f_curraddrmedianvalue_d > 262883) => 0.2348585855,
   (f_curraddrmedianvalue_d = NULL) => 0.0745346194, 0.0745346194),
(f_add_input_mobility_index_n = NULL) => -0.0062489376, -0.0051219570);

// Tree: 185 
final_score_185 := map(
(NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 6.5) => 
   map(
   (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => 
      map(
      (NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 1.5) => 0.0723027627,
      (f_inq_per_ssn_i > 1.5) => -0.0693848728,
      (f_inq_per_ssn_i = NULL) => 0.0445372881, 0.0445372881),
   (f_curraddractivephonelist_d > 0.5) => -0.0589480454,
   (f_curraddractivephonelist_d = NULL) => 0.0222961418, 0.0222961418),
(f_rel_ageover30_count_d > 6.5) => -0.0189093771,
(f_rel_ageover30_count_d = NULL) => -0.0056316449, -0.0056316449);

// Tree: 186 
final_score_186 := map(
(NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 182) => -0.0116700239,
(f_fp_prevaddrcrimeindex_i > 182) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 48) => -0.1364111951,
   (f_curraddrcartheftindex_i > 48) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By SSN','Father','Grandfather','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling']) => -0.0104979309,
      (phone_subject_title in ['Associate','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandmother','Grandparent','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 0.1312650551,
      (phone_subject_title = '') => 0.0779922054, 0.0779922054),
   (f_curraddrcartheftindex_i = NULL) => 0.0557039423, 0.0557039423),
(f_fp_prevaddrcrimeindex_i = NULL) => -0.0042860041, -0.0042860041);

// Tree: 187 
final_score_187 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 61.5) => 
   map(
   (NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0022317881,
   (_pp_rule_high_vend_conf > 0.5) => 
      map(
      (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 5.5) => 0.0128173599,
      (pp_app_ind_ph_cnt > 5.5) => 0.1242011971,
      (pp_app_ind_ph_cnt = NULL) => 0.0440472999, 0.0440472999),
   (_pp_rule_high_vend_conf = NULL) => 0.0050286944, 0.0050286944),
(inq_adl_lastseen_n > 61.5) => -0.2057114455,
(inq_adl_lastseen_n = NULL) => 0.0036978689, 0.0036978689);

// Tree: 188 
final_score_188 := map(
(NULL < f_rel_count_i and f_rel_count_i <= 66.5) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 5.5) => 0.0016697545,
   (f_crim_rel_under25miles_cnt_i > 5.5) => 
      map(
      (NULL < f_validationrisktype_i and f_validationrisktype_i <= 1.5) => -0.1227230311,
      (f_validationrisktype_i > 1.5) => 0.0959450156,
      (f_validationrisktype_i = NULL) => -0.0721080606, -0.0721080606),
   (f_crim_rel_under25miles_cnt_i = NULL) => -0.0054310139, -0.0054310139),
(f_rel_count_i > 66.5) => 0.2810291604,
(f_rel_count_i = NULL) => -0.0033027808, -0.0033027808);

// Tree: 189 
final_score_189 := map(
(NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 101.5) => 0.0063991747,
(mth_pp_eda_hist_did_dt > 101.5) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 136.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 121) => 0.0141536803,
      (r_pb_order_freq_d > 121) => -0.1450458913,
      (r_pb_order_freq_d = NULL) => 0.1603693871, 0.0509350661),
   (mth_pp_app_npa_last_change_dt > 136.5) => 0.3861239079,
   (mth_pp_app_npa_last_change_dt = NULL) => 0.0953576837, 0.0953576837),
(mth_pp_eda_hist_did_dt = NULL) => 0.0109704700, 0.0109704700);

// Tree: 190 
final_score_190 := map(
(NULL < r_paw_active_phone_ct_d and r_paw_active_phone_ct_d <= 0.5) => -0.0121581186,
(r_paw_active_phone_ct_d > 0.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Brother','Daughter','Grandmother','Husband','Neighbor','Relative','Sibling','Son','Wife']) => -0.0685734552,
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By SSN','Child','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Mother','Parent','Sister','Spouse','Subject','Subject at Household']) => 
      map(
      (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => 0.2014304908,
      (f_util_add_curr_conv_n > 0.5) => 0.0443879888,
      (f_util_add_curr_conv_n = NULL) => 0.1063961871, 0.1063961871),
   (phone_subject_title = '') => 0.0518042809, 0.0518042809),
(r_paw_active_phone_ct_d = NULL) => -0.0041113382, -0.0041113382);

// Tree: 191 
final_score_191 := map(
(NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 7.5) => 
   map(
   (NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0077182505,
   (_pp_rule_high_vend_conf > 0.5) => 
      map(
      (NULL < internal_verification and internal_verification <= 0.5) => -0.0857048939,
      (internal_verification > 0.5) => 0.0979721180,
      (internal_verification = NULL) => 0.0449133380, 0.0449133380),
   (_pp_rule_high_vend_conf = NULL) => 0.0003143454, 0.0003143454),
(mth_source_ppth_lseen > 7.5) => -0.1634498287,
(mth_source_ppth_lseen = NULL) => -0.0070668036, -0.0070668036);

// Tree: 192 
final_score_192 := map(
(NULL < mth_source_edahistory_fseen and mth_source_edahistory_fseen <= 4.5) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By SSN','Brother','Child','Daughter','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Sibling','Son','Spouse','Subject at Household']) => -0.0375934304,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Father','Grandchild','Grandfather','Mother','Neighbor','Parent','Relative','Sister','Subject','Wife']) => 0.0096839892,
   (phone_subject_title = '') => 0.0036220083, 0.0036220083),
(mth_source_edahistory_fseen > 4.5) => 
   map(
   (exp_source in ['S']) => -0.2083596318,
   (exp_source in ['P']) => 0.0687140796,
   (exp_source = '') => -0.2072750556, -0.1332873420),
(mth_source_edahistory_fseen = NULL) => -0.0004127150, -0.0004127150);

// Tree: 193 
final_score_193 := map(
(NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 131) => 0.0148389275,
(f_fp_prevaddrburglaryindex_i > 131) => 
   map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 0.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Child','Father','Grandfather','Grandson','Husband','Mother','Neighbor','Sister','Son','Subject at Household','Wife']) => -0.0511859902,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Grandmother','Grandparent','Parent','Relative','Sibling','Spouse','Subject']) => 0.1223930218,
      (phone_subject_title = '') => 0.0290661245, 0.0290661245),
   (f_rel_incomeover50_count_d > 0.5) => -0.0403838643,
   (f_rel_incomeover50_count_d = NULL) => -0.0319808959, -0.0319808959),
(f_fp_prevaddrburglaryindex_i = NULL) => -0.0036895712, -0.0036895712);

// Tree: 194 
final_score_194 := map(
(NULL < inq_firstseen_n and inq_firstseen_n <= 67.5) => -0.0101405582,
(inq_firstseen_n > 67.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Grandfather','Grandmother','Grandson','Neighbor','Parent','Relative','Sibling','Sister','Son','Subject','Wife']) => 
      map(
      (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 144.5) => 0.1254031083,
      (eda_avg_days_interrupt > 144.5) => -0.1890210408,
      (eda_avg_days_interrupt = NULL) => 0.0433189278, 0.0433189278),
   (phone_subject_title in ['Associate By Property','Child','Daughter','Father','Grandchild','Granddaughter','Grandparent','Husband','Mother','Spouse','Subject at Household']) => 0.2877654936,
   (phone_subject_title = '') => 0.0719650097, 0.0719650097),
(inq_firstseen_n = NULL) => -0.0049352523, -0.0049352523);

// Tree: 195 
final_score_195 := map(
(NULL < eda_days_in_service and eda_days_in_service <= 67.5) => 
   map(
   (NULL < inq_lastseen_n and inq_lastseen_n <= 24.5) => 0.0335069555,
   (inq_lastseen_n > 24.5) => 
      map(
      (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 79.5) => -0.0695220056,
      (mth_pp_datefirstseen > 79.5) => 0.1579916201,
      (mth_pp_datefirstseen = NULL) => -0.0417680844, -0.0417680844),
   (inq_lastseen_n = NULL) => 0.0202910310, 0.0202910310),
(eda_days_in_service > 67.5) => -0.0194289696,
(eda_days_in_service = NULL) => -0.0008280481, -0.0008280481);

// Tree: 196 
final_score_196 := map(
(NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0333254749,
(_phone_match_code_n > 0.5) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 0.5) => 0.0403067312,
   (f_srchfraudsrchcountyr_i > 0.5) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 7.5) => 0.0703308942,
      (mth_pp_app_npa_last_change_dt > 7.5) => -0.0622577342,
      (mth_pp_app_npa_last_change_dt = NULL) => -0.0275461966, -0.0275461966),
   (f_srchfraudsrchcountyr_i = NULL) => 0.0182456896, 0.0182456896),
(_phone_match_code_n = NULL) => -0.0112691596, -0.0112691596);

// Tree: 197 
final_score_197 := map(
(NULL < eda_num_phs_discon_addr and eda_num_phs_discon_addr <= 2.5) => 
   map(
   (NULL < mth_phone_fb_rp_date and mth_phone_fb_rp_date <= 37.5) => 0.0107300396,
   (mth_phone_fb_rp_date > 37.5) => -0.1826881006,
   (mth_phone_fb_rp_date = NULL) => 0.0078286238, 0.0078286238),
(eda_num_phs_discon_addr > 2.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 193.5) => -0.0714061845,
   (f_prevaddrmurderindex_i > 193.5) => 0.1988030399,
   (f_prevaddrmurderindex_i = NULL) => -0.0595266433, -0.0595266433),
(eda_num_phs_discon_addr = NULL) => -0.0033722335, -0.0033722335);

// Tree: 198 
final_score_198 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0090143822,
(source_utildid > 0.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 6.5) => 0.2906103033,
   (mth_source_utildid_fseen > 6.5) => 
      map(
      (NULL < _pp_src_all_iq and _pp_src_all_iq <= 0.5) => -0.0037102357,
      (_pp_src_all_iq > 0.5) => 0.1673492189,
      (_pp_src_all_iq = NULL) => 0.0345180441, 0.0345180441),
   (mth_source_utildid_fseen = NULL) => 0.0517485259, 0.0517485259),
(source_utildid = NULL) => -0.0033112761, -0.0033112761);

// Tree: 199 
final_score_199 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 16.5) => 
   map(
   (NULL < _pp_rule_30 and _pp_rule_30 <= 0.5) => -0.0003894635,
   (_pp_rule_30 > 0.5) => -0.1664591084,
   (_pp_rule_30 = NULL) => -0.0024889533, -0.0024889533),
(f_rel_ageover40_count_d > 16.5) => 
   map(
   (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => 0.2736702993,
   (f_bus_name_nover_i > 0.5) => -0.0430501275,
   (f_bus_name_nover_i = NULL) => 0.1351051126, 0.1351051126),
(f_rel_ageover40_count_d = NULL) => -0.0000288657, -0.0000288657);

// Tree: 200 
final_score_200 := map(
(NULL < _internal_ver_match_spouse and _internal_ver_match_spouse <= 0.5) => 
   map(
   (exp_source in ['P']) => -0.0458978288,
   (exp_source in ['S']) => 0.0244531989,
   (exp_source = '') => 0.0019134925, 0.0026123451),
(_internal_ver_match_spouse > 0.5) => 
   map(
   (NULL < inq_firstseen_n and inq_firstseen_n <= 31.5) => 0.0016956814,
   (inq_firstseen_n > 31.5) => 0.3132328578,
   (inq_firstseen_n = NULL) => 0.1188149207, 0.1188149207),
(_internal_ver_match_spouse = NULL) => 0.0045260328, 0.0045260328);

// Tree: 201 
final_score_201 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 188.5) => -0.0241148315,
(r_pb_order_freq_d > 188.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 77.5) => 0.0155000472,
   (f_addrchangecrimediff_i > 77.5) => 0.2833324987,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (phone_subject_title in ['Associate By Shared Associates','Brother','Daughter','Husband','Parent','Relative','Son','Subject','Subject at Household']) => -0.0857485300,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Neighbor','Sibling','Sister','Spouse','Wife']) => 0.2811572591,
      (phone_subject_title = '') => 0.0557380161, 0.0557380161), 0.0431366855),
(r_pb_order_freq_d = NULL) => 0.0107174471, -0.0035518816);

// Tree: 202 
final_score_202 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 312034) => 0.0060067586,
(f_addrchangevaluediff_d > 312034) => -0.1581929865,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < f_college_income_d and f_college_income_d <= 4.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 10.5) => 0.3137935333,
      (f_inq_count_i > 10.5) => -0.0943814595,
      (f_inq_count_i = NULL) => 0.1437206196, 0.1437206196),
   (f_college_income_d > 4.5) => -0.0773901189,
   (f_college_income_d = NULL) => 0.0186049057, 0.0181214356), 0.0064309473);

// Tree: 203 
final_score_203 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 11.5) => 0.0038961398,
(mth_exp_last_update > 11.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.400934659901095) => 
      map(
      (NULL < eda_days_in_service and eda_days_in_service <= 851) => -0.0267448929,
      (eda_days_in_service > 851) => 0.1812284630,
      (eda_days_in_service = NULL) => 0.0035533838, 0.0035533838),
   (f_add_curr_mobility_index_n > 0.400934659901095) => -0.1082383458,
   (f_add_curr_mobility_index_n = NULL) => -0.0341546728, -0.0341546728),
(mth_exp_last_update = NULL) => -0.0000992898, -0.0000992898);

// Tree: 204 
final_score_204 := map(
(NULL < f_util_add_input_inf_n and f_util_add_input_inf_n <= 0.5) => -0.0001917842,
(f_util_add_input_inf_n > 0.5) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 52.5) => 0.2976500075,
   (f_curraddrburglaryindex_i > 52.5) => 
      map(
      (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => 0.2198085058,
      (f_util_add_curr_conv_n > 0.5) => -0.0218287941,
      (f_util_add_curr_conv_n = NULL) => 0.0218570454, 0.0218570454),
   (f_curraddrburglaryindex_i = NULL) => 0.0752565939, 0.0752565939),
(f_util_add_input_inf_n = NULL) => 0.0039094835, 0.0039094835);

// Tree: 205 
final_score_205 := map(
(NULL < mth_source_edala_fseen and mth_source_edala_fseen <= 22.5) => 
   map(
   (NULL < f_college_income_d and f_college_income_d <= 9.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 166.5) => -0.0515870852,
      (f_fp_prevaddrburglaryindex_i > 166.5) => 0.1241278817,
      (f_fp_prevaddrburglaryindex_i = NULL) => -0.0127550483, -0.0127550483),
   (f_college_income_d > 9.5) => -0.1346175041,
   (f_college_income_d = NULL) => 0.0031600617, -0.0008614170),
(mth_source_edala_fseen > 22.5) => -0.1630412308,
(mth_source_edala_fseen = NULL) => -0.0024277896, -0.0024277896);

// Tree: 206 
final_score_206 := map(
(NULL < _internal_ver_match_hhid and _internal_ver_match_hhid <= 0.5) => -0.0058406016,
(_internal_ver_match_hhid > 0.5) => 
   map(
   (phone_subject_title in ['Associate','Relative','Subject','Subject at Household']) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 23.5) => -0.1146800750,
      (f_mos_inq_banko_om_lseen_d > 23.5) => 0.0724561628,
      (f_mos_inq_banko_om_lseen_d = NULL) => 0.0331994775, 0.0331994775),
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Sibling','Sister','Son','Spouse','Wife']) => 0.2545545189,
   (phone_subject_title = '') => 0.0715825907, 0.0715825907),
(_internal_ver_match_hhid = NULL) => -0.0001460280, -0.0001460280);

// Tree: 207 
final_score_207 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 19757) => 0.1346591794,
(f_curraddrmedianvalue_d > 19757) => 
   map(
   (NULL < f_vardobcount_i and f_vardobcount_i <= 2.5) => -0.0088419138,
   (f_vardobcount_i > 2.5) => 
      map(
      (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 9.5) => -0.0288930175,
      (mth_pp_datefirstseen > 9.5) => 0.1990309998,
      (mth_pp_datefirstseen = NULL) => 0.0500727837, 0.0500727837),
   (f_vardobcount_i = NULL) => -0.0040937436, -0.0040937436),
(f_curraddrmedianvalue_d = NULL) => -0.0007091069, -0.0007091069);

// Tree: 208 
final_score_208 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 13.5) => -0.0054818774,
(f_inq_count24_i > 13.5) => 
   map(
   (NULL < pp_app_best_addr_match_fl and pp_app_best_addr_match_fl <= 0.5) => 0.0013439661,
   (pp_app_best_addr_match_fl > 0.5) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 8.5) => 0.3049984824,
      (f_rel_incomeover50_count_d > 8.5) => 0.0103913998,
      (f_rel_incomeover50_count_d = NULL) => 0.1988667383, 0.1988667383),
   (pp_app_best_addr_match_fl = NULL) => 0.0734554544, 0.0734554544),
(f_inq_count24_i = NULL) => -0.0011708727, -0.0011708727);

// Tree: 209 
final_score_209 := map(
(NULL < _phone_match_code_d and _phone_match_code_d <= 0.5) => -0.0150103408,
(_phone_match_code_d > 0.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Father','Mother','Sibling','Sister','Son']) => -0.0763299120,
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By SSN','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Relative','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 39) => -0.0087721523,
      (f_mos_inq_banko_cm_lseen_d > 39) => 0.2591249761,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.1713925832, 0.1713925832),
   (phone_subject_title = '') => 0.0865952675, 0.0865952675),
(_phone_match_code_d = NULL) => -0.0117392340, -0.0117392340);

// Tree: 210 
final_score_210 := map(
(NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 14.5) => 
   map(
   (pp_source in ['HEADER','INFUTOR','OTHER','THRIVE']) => -0.0164569384,
   (pp_source in ['CELL','GONG','IBEHAVIOR','INQUIRY','INTRADO','PCNSR','TARGUS']) => 0.1430799163,
   (pp_source = '') => 
      map(
      (phone_subject_title in ['Associate By Business','Associate By Vehicle','Brother','Child','Father','Grandfather','Grandson','Sibling','Son','Spouse','Subject','Wife']) => -0.1246292782,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Daughter','Grandchild','Granddaughter','Grandmother','Grandparent','Husband','Mother','Neighbor','Parent','Relative','Sister','Subject at Household']) => 0.1543728903,
      (phone_subject_title = '') => 0.0618466609, 0.0618466609), 0.0586566177),
(f_prevaddrmurderindex_i > 14.5) => -0.0104176661,
(f_prevaddrmurderindex_i = NULL) => -0.0043784780, -0.0043784780);

// Tree: 211 
final_score_211 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 2.5) => -0.2404677006,
(f_mos_inq_banko_om_fseen_d > 2.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 20.5) => 0.0025868869,
   (inq_adl_lastseen_n > 20.5) => 
      map(
      (NULL < f_idverrisktype_i and f_idverrisktype_i <= 7) => -0.0898065228,
      (f_idverrisktype_i > 7) => 0.0674824785,
      (f_idverrisktype_i = NULL) => -0.0500027755, -0.0500027755),
   (inq_adl_lastseen_n = NULL) => -0.0006249958, -0.0006249958),
(f_mos_inq_banko_om_fseen_d = NULL) => -0.0021694937, -0.0021694937);

// Tree: 212 
final_score_212 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 58.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 1.5) => 0.0365121888,
   (f_srchaddrsrchcount_i > 1.5) => 
      map(
      (phone_subject_title in ['Associate','Daughter','Mother','Relative','Subject','Subject at Household']) => -0.2314076697,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Sibling','Sister','Son','Spouse','Wife']) => -0.0450838386,
      (phone_subject_title = '') => -0.1653353892, -0.1653353892),
   (f_srchaddrsrchcount_i = NULL) => -0.0905436527, -0.0905436527),
(f_mos_inq_banko_am_lseen_d > 58.5) => -0.0009912684,
(f_mos_inq_banko_am_lseen_d = NULL) => -0.0034751384, -0.0034751384);

// Tree: 213 
final_score_213 := map(
(NULL < eda_address_match_best and eda_address_match_best <= 0.5) => 
   map(
   (NULL < eda_min_days_connected_ind and eda_min_days_connected_ind <= 63.5) => -0.0110551688,
   (eda_min_days_connected_ind > 63.5) => -0.1615772236,
   (eda_min_days_connected_ind = NULL) => -0.0151185111, -0.0151185111),
(eda_address_match_best > 0.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Father','Husband','Mother','Neighbor','Parent']) => -0.0914388000,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 0.1422071726,
   (phone_subject_title = '') => 0.0559229753, 0.0559229753),
(eda_address_match_best = NULL) => -0.0108785413, -0.0108785413);

// Tree: 214 
final_score_214 := map(
(NULL < inq_num and inq_num <= 0.5) => 
   map(
   (NULL < source_utildid and source_utildid <= 0.5) => -0.0120818965,
   (source_utildid > 0.5) => 
      map(
      (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 31.5) => 0.1668281600,
      (mth_source_utildid_fseen > 31.5) => -0.0469469275,
      (mth_source_utildid_fseen = NULL) => 0.0531873728, 0.0531873728),
   (source_utildid = NULL) => -0.0078795407, -0.0078795407),
(inq_num > 0.5) => 0.0408437461,
(inq_num = NULL) => -0.0021661984, -0.0021661984);

// Tree: 215 
final_score_215 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 19.5) => 0.0161795234,
(mth_exp_last_update > 19.5) => 
   map(
   (NULL < f_vardobcount_i and f_vardobcount_i <= 2.5) => 
      map(
      (NULL < _pp_app_nxx_type and _pp_app_nxx_type <= 3.5) => -0.0328357385,
      (_pp_app_nxx_type > 3.5) => -0.1840197246,
      (_pp_app_nxx_type = NULL) => -0.0547000892, -0.0547000892),
   (f_vardobcount_i > 2.5) => 0.1592509988,
   (f_vardobcount_i = NULL) => -0.0364107220, -0.0364107220),
(mth_exp_last_update = NULL) => 0.0121421346, 0.0121421346);

// Tree: 216 
final_score_216 := map(
(NULL < eda_address_match_best and eda_address_match_best <= 0.5) => 
   map(
   (NULL < mth_source_pf_fseen and mth_source_pf_fseen <= 7) => 
      map(
      (NULL < eda_days_ind_first_seen and eda_days_ind_first_seen <= 410.5) => 0.0023051731,
      (eda_days_ind_first_seen > 410.5) => -0.1076321887,
      (eda_days_ind_first_seen = NULL) => -0.0017655003, -0.0017655003),
   (mth_source_pf_fseen > 7) => -0.1809523169,
   (mth_source_pf_fseen = NULL) => -0.0034381619, -0.0034381619),
(eda_address_match_best > 0.5) => 0.0908058631,
(eda_address_match_best = NULL) => 0.0020465696, 0.0020465696);

// Tree: 217 
final_score_217 := map(
(phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Father','Grandfather','Grandmother','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Sister','Spouse','Subject','Subject at Household','Wife']) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 23.5) => -0.1389252142,
   (f_mos_inq_banko_cm_fseen_d > 23.5) => 0.0002498405,
   (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0047835808, -0.0047835808),
(phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandparent','Mother','Son']) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 17.5) => 0.2442503372,
   (f_mos_inq_banko_cm_lseen_d > 17.5) => 0.0401951713,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0579611684, 0.0579611684),
(phone_subject_title = '') => 0.0014629247, 0.0014629247);

// Tree: 218 
final_score_218 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 1.5) => 
   map(
   (exp_source in ['P']) => 0.0313659517,
   (exp_source in ['S']) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 2.5) => 0.1367539536,
      (f_util_adl_count_n > 2.5) => -0.0182529180,
      (f_util_adl_count_n = NULL) => 0.0772503561, 0.0772503561),
   (exp_source = '') => 0.0111428197, 0.0206609091),
(f_srchssnsrchcount_i > 1.5) => -0.0269785243,
(f_srchssnsrchcount_i = NULL) => -0.0019731308, -0.0019731308);

// Tree: 219 
final_score_219 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 160.5) => 0.0135039081,
(f_prevaddrageoldest_d > 160.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.387423062151005) => 
      map(
      (pp_src in ['E1','EN','EQ','LP','VO']) => -0.1238635709,
      (pp_src in ['CY','E2','EM','FA','FF','KW','LA','MD','NW','PL','SL','TN','UT','UW','VW','ZK','ZT']) => 0.0809358963,
      (pp_src = '') => -0.0078543770, -0.0017504116),
   (f_add_curr_mobility_index_n > 0.387423062151005) => -0.0780838679,
   (f_add_curr_mobility_index_n = NULL) => -0.0244102001, -0.0244102001),
(f_prevaddrageoldest_d = NULL) => 0.0003072070, 0.0003072070);

// Tree: 220 
final_score_220 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 18.5) => -0.0045134772,
(f_rel_under500miles_cnt_d > 18.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Father','Grandfather','Grandson','Husband','Mother','Parent','Sister','Son']) => -0.0579362387,
   (phone_subject_title in ['Associate','Associate By Property','Brother','Daughter','Grandchild','Granddaughter','Grandmother','Grandparent','Neighbor','Relative','Sibling','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 0.5) => 0.0002399352,
      (f_inq_per_ssn_i > 0.5) => 0.1139768385,
      (f_inq_per_ssn_i = NULL) => 0.0623396094, 0.0623396094),
   (phone_subject_title = '') => 0.0223270500, 0.0223270500),
(f_rel_under500miles_cnt_d = NULL) => 0.0005372493, 0.0005372493);

// Tree: 221 
final_score_221 := map(
(NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 138.5) => -0.0003197565,
(mth_pp_app_npa_last_change_dt > 138.5) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 52.5) => 0.2513244441,
   (f_curraddrburglaryindex_i > 52.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 6.5) => -0.0952248030,
      (f_corraddrnamecount_d > 6.5) => 0.1748160876,
      (f_corraddrnamecount_d = NULL) => 0.0154169508, 0.0154169508),
   (f_curraddrburglaryindex_i = NULL) => 0.0725313965, 0.0725313965),
(mth_pp_app_npa_last_change_dt = NULL) => 0.0031081086, 0.0031081086);

// Tree: 222 
final_score_222 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 20.5) => 0.0004555633,
(mth_exp_last_update > 20.5) => 
   map(
   (NULL < subject_ssn_mismatch and subject_ssn_mismatch <= -0.5) => 0.0438745930,
   (subject_ssn_mismatch > -0.5) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 5.5) => -0.1323337381,
      (f_rel_ageover40_count_d > 5.5) => 0.0135100869,
      (f_rel_ageover40_count_d = NULL) => -0.0893331018, -0.0893331018),
   (subject_ssn_mismatch = NULL) => -0.0500864673, -0.0500864673),
(mth_exp_last_update = NULL) => -0.0031554758, -0.0031554758);

// Tree: 223 
final_score_223 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 25.5) => 0.0149240341,
(f_inq_count_i > 25.5) => 
   map(
   (NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 904.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Associate By SSN','Daughter','Grandfather','Grandmother','Grandparent','Mother','Parent','Wife']) => -0.1878539659,
      (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandson','Husband','Neighbor','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household']) => -0.0389598730,
      (phone_subject_title = '') => -0.0615030568, -0.0615030568),
   (eda_max_days_interrupt > 904.5) => 0.1683395190,
   (eda_max_days_interrupt = NULL) => -0.0422209615, -0.0422209615),
(f_inq_count_i = NULL) => 0.0085973931, 0.0085973931);

// Tree: 224 
final_score_224 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 0.5) => 
   map(
   (NULL < r_paw_dead_business_ct_i and r_paw_dead_business_ct_i <= 0.5) => 0.0305537793,
   (r_paw_dead_business_ct_i > 0.5) => -0.1603838500,
   (r_paw_dead_business_ct_i = NULL) => 0.0252584833, 0.0252584833),
(f_rel_homeover200_count_d > 0.5) => 
   map(
   (NULL < f_wealth_index_d and f_wealth_index_d <= 1.5) => -0.1214725794,
   (f_wealth_index_d > 1.5) => -0.0107982152,
   (f_wealth_index_d = NULL) => -0.0177029266, -0.0177029266),
(f_rel_homeover200_count_d = NULL) => -0.0044249157, -0.0044249157);

// Tree: 225 
final_score_225 := map(
(NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 147.5) => -0.0066767231,
(f_prevaddrmurderindex_i > 147.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 160.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By SSN','Brother','Grandmother','Grandparent','Grandson','Neighbor','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household']) => 0.0641354646,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Husband','Mother','Parent','Wife']) => 0.3746270736,
      (phone_subject_title = '') => 0.1121362565, 0.1121362565),
   (f_prevaddrcartheftindex_i > 160.5) => -0.0007222856,
   (f_prevaddrcartheftindex_i = NULL) => 0.0318339351, 0.0318339351),
(f_prevaddrmurderindex_i = NULL) => 0.0051936209, 0.0051936209);

// Tree: 226 
final_score_226 := map(
(NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 13.5) => 
   map(
   (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 1.5) => -0.0106696289,
   (pp_app_ind_ph_cnt > 1.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -121053) => 0.1495263491,
      (f_addrchangevaluediff_d > -121053) => 0.0055536202,
      (f_addrchangevaluediff_d = NULL) => 0.0322602980, 0.0218605794),
   (pp_app_ind_ph_cnt = NULL) => 0.0012029183, 0.0012029183),
(f_crim_rel_under25miles_cnt_i > 13.5) => -0.2145192350,
(f_crim_rel_under25miles_cnt_i = NULL) => -0.0007004336, -0.0007004336);

// Tree: 227 
final_score_227 := map(
(NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 149) => 
   map(
   (NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 88.5) => 
      map(
      (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 8.5) => 0.0030976453,
      (f_rel_homeover500_count_d > 8.5) => -0.1307343769,
      (f_rel_homeover500_count_d = NULL) => 0.0006367542, 0.0006367542),
   (mth_source_ppla_fseen > 88.5) => -0.1688836985,
   (mth_source_ppla_fseen = NULL) => -0.0004832388, -0.0004832388),
(mth_pp_datefirstseen > 149) => 0.2002704077,
(mth_pp_datefirstseen = NULL) => 0.0008590961, 0.0008590961);

// Tree: 228 
final_score_228 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 2135.5) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 10.5) => 0.0318462765,
   (f_rel_incomeover75_count_d > 10.5) => -0.1511938425,
   (f_rel_incomeover75_count_d = NULL) => 0.0249138213, 0.0249138213),
(f_addrchangevaluediff_d > 2135.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Brother','Child','Father','Grandmother','Grandparent','Grandson','Mother','Neighbor','Parent','Spouse','Subject','Wife']) => -0.0493102318,
   (phone_subject_title in ['Associate','Associate By SSN','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Grandfather','Husband','Relative','Sibling','Sister','Son','Subject at Household']) => 0.0373903226,
   (phone_subject_title = '') => -0.0293998749, -0.0293998749),
(f_addrchangevaluediff_d = NULL) => 0.0120379542, 0.0023168562);

// Tree: 229 
final_score_229 := map(
(NULL < f_bus_fname_verd_d and f_bus_fname_verd_d <= 0.5) => -0.0021401847,
(f_bus_fname_verd_d > 0.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Father','Grandmother','Husband','Neighbor','Sibling','Subject at Household','Wife']) => -0.0605622717,
   (phone_subject_title in ['Associate By Property','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Mother','Parent','Relative','Sister','Son','Spouse','Subject']) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 40.5) => 0.0026993181,
      (f_mos_inq_banko_cm_lseen_d > 40.5) => 0.2199883538,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.1495989479, 0.1495989479),
   (phone_subject_title = '') => 0.0597719750, 0.0597719750),
(f_bus_fname_verd_d = NULL) => 0.0007116384, 0.0007116384);

// Tree: 230 
final_score_230 := map(
(NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 9.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Child','Father','Grandfather','Grandmother','Grandparent','Grandson','Mother','Neighbor','Sibling','Sister','Subject','Subject at Household']) => 0.0177403786,
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Husband','Parent','Relative','Son','Spouse','Wife']) => 0.3000671747,
   (phone_subject_title = '') => 0.0226802399, 0.0226802399),
(mth_eda_dt_first_seen > 9.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 24.5) => -0.0187790031,
   (mth_source_ppdid_lseen > 24.5) => 0.2316963743,
   (mth_source_ppdid_lseen = NULL) => -0.0144157612, -0.0144157612),
(mth_eda_dt_first_seen = NULL) => 0.0044859283, 0.0044859283);

// Tree: 231 
final_score_231 := map(
(NULL < inq_num and inq_num <= 2.5) => 
   map(
   (pp_src in ['E1','E2','EM','EN','EQ','LP','NW','PL','UW','VO']) => -0.0588458873,
   (pp_src in ['CY','FA','FF','KW','LA','MD','SL','TN','UT','VW','ZK','ZT']) => -0.0090776909,
   (pp_src = '') => 0.0062179085, -0.0005533439),
(inq_num > 2.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 229481) => 0.1142372567,
   (f_prevaddrmedianvalue_d > 229481) => -0.1029024518,
   (f_prevaddrmedianvalue_d = NULL) => 0.0682208947, 0.0682208947),
(inq_num = NULL) => 0.0020184515, 0.0020184515);

// Tree: 232 
final_score_232 := map(
(NULL < number_of_sources and number_of_sources <= 3.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 89355) => -0.0132703546,
   (f_curraddrmedianincome_d > 89355) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 31.5) => 0.0902027259,
      (inq_firstseen_n > 31.5) => -0.0435928615,
      (inq_firstseen_n = NULL) => 0.0474161947, 0.0474161947),
   (f_curraddrmedianincome_d = NULL) => -0.0072553069, -0.0072553069),
(number_of_sources > 3.5) => 0.0788707333,
(number_of_sources = NULL) => -0.0032241476, -0.0032241476);

// Tree: 233 
final_score_233 := map(
(NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 5.5) => 0.0128833423,
(f_crim_rel_under25miles_cnt_i > 5.5) => 
   map(
   (exp_type in ['C']) => -0.1638498171,
   (exp_type in ['N']) => 0.1205485071,
   (exp_type = '') => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 47) => 0.1505171410,
      (f_curraddrcrimeindex_i > 47) => -0.1043157510,
      (f_curraddrcrimeindex_i = NULL) => -0.0561249621, -0.0561249621), -0.0497422624),
(f_crim_rel_under25miles_cnt_i = NULL) => 0.0066946420, 0.0066946420);

// Tree: 234 
final_score_234 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 220676) => 
   map(
   (pp_src in ['CY','E1','EN','EQ','FA','LP','UW','ZT']) => -0.0620466000,
   (pp_src in ['E2','EM','FF','KW','LA','MD','NW','PL','SL','TN','UT','VO','VW','ZK']) => 0.0224665390,
   (pp_src = '') => 0.0162581475, 0.0120923556),
(f_curraddrmedianvalue_d > 220676) => 
   map(
   (pp_src in ['E1','EM','EN','EQ','FA','LP','PL','SL','UT','VO','VW']) => -0.0293012834,
   (pp_src in ['CY','E2','FF','KW','LA','MD','NW','TN','UW','ZK','ZT']) => 0.1329714892,
   (pp_src = '') => -0.0466093069, -0.0364340556),
(f_curraddrmedianvalue_d = NULL) => -0.0019860720, -0.0019860720);

// Tree: 235 
final_score_235 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 178.5) => 0.0044630902,
(f_curraddrcartheftindex_i > 178.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 8.5) => 
      map(
      (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 1.5) => -0.0356785130,
      (f_rel_ageover50_count_d > 1.5) => 0.1251102356,
      (f_rel_ageover50_count_d = NULL) => -0.0203470471, -0.0203470471),
   (f_corraddrnamecount_d > 8.5) => -0.1649797674,
   (f_corraddrnamecount_d = NULL) => -0.0481930019, -0.0481930019),
(f_curraddrcartheftindex_i = NULL) => -0.0023447067, -0.0023447067);

// Tree: 236 
final_score_236 := map(
(NULL < _pp_rule_low_vend_conf and _pp_rule_low_vend_conf <= 0.5) => 0.0008351769,
(_pp_rule_low_vend_conf > 0.5) => 
   map(
   (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 135.5) => -0.0829866111,
   (mth_pp_app_npa_effective_dt > 135.5) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 7.5) => 0.2925341020,
      (f_rel_under25miles_cnt_d > 7.5) => 0.0246565935,
      (f_rel_under25miles_cnt_d = NULL) => 0.1807578754, 0.1807578754),
   (mth_pp_app_npa_effective_dt = NULL) => 0.1093270770, 0.1093270770),
(_pp_rule_low_vend_conf = NULL) => 0.0034144792, 0.0034144792);

// Tree: 237 
final_score_237 := map(
(phone_subject_title in ['Associate','Associate By Business','Associate By SSN','Associate By Vehicle','Child','Father','Grandfather','Grandmother','Grandson','Mother']) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 1.5) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 315773.5) => -0.1356322823,
      (f_curraddrmedianvalue_d > 315773.5) => 0.0438791063,
      (f_curraddrmedianvalue_d = NULL) => -0.0993480654, -0.0993480654),
   (f_inq_count24_i > 1.5) => -0.0033087909,
   (f_inq_count24_i = NULL) => -0.0433873338, -0.0433873338),
(phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Brother','Daughter','Grandchild','Granddaughter','Grandparent','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0094536619,
(phone_subject_title = '') => 0.0035584492, 0.0035584492);

// Tree: 238 
final_score_238 := map(
(NULL < eda_days_ind_first_seen and eda_days_ind_first_seen <= 358) => 0.0034808696,
(eda_days_ind_first_seen > 358) => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 4117.5) => -0.1563789471,
   (eda_days_ph_first_seen > 4117.5) => 
      map(
      (NULL < number_of_sources and number_of_sources <= 2.5) => -0.2197353000,
      (number_of_sources > 2.5) => 0.1294233233,
      (number_of_sources = NULL) => -0.0087053628, -0.0087053628),
   (eda_days_ph_first_seen = NULL) => -0.0923870606, -0.0923870606),
(eda_days_ind_first_seen = NULL) => -0.0015048326, -0.0015048326);

// Tree: 239 
final_score_239 := map(
(exp_source in ['P']) => -0.0436765705,
(exp_source in ['S']) => 
   map(
   (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => 0.0077321115,
   (f_curraddractivephonelist_d > 0.5) => 
      map(
      (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 15.5) => -0.0516566938,
      (mth_pp_datevendorfirstseen > 15.5) => 0.1956625953,
      (mth_pp_datevendorfirstseen = NULL) => 0.0743963632, 0.0743963632),
   (f_curraddractivephonelist_d = NULL) => 0.0169415224, 0.0169415224),
(exp_source = '') => -0.0074123791, -0.0061946525);

// Tree: 240 
final_score_240 := map(
(NULL < pp_did_score and pp_did_score <= 99.5) => 
   map(
   (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 27.5) => 0.0163040105,
   (f_rel_educationover8_count_d > 27.5) => -0.0672541552,
   (f_rel_educationover8_count_d = NULL) => 0.0097425897, 0.0097425897),
(pp_did_score > 99.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 449138) => -0.0763196463,
   (f_prevaddrmedianvalue_d > 449138) => 0.1518354787,
   (f_prevaddrmedianvalue_d = NULL) => -0.0588245579, -0.0588245579),
(pp_did_score = NULL) => 0.0016598848, 0.0016598848);

// Tree: 241 
final_score_241 := map(
(NULL < _inq_adl_ph_industry_cards and _inq_adl_ph_industry_cards <= 0.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 389.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 374.5) => -0.0010801028,
      (f_prevaddrageoldest_d > 374.5) => 0.1624816429,
      (f_prevaddrageoldest_d = NULL) => 0.0009237165, 0.0009237165),
   (f_prevaddrlenofres_d > 389.5) => -0.1057783818,
   (f_prevaddrlenofres_d = NULL) => -0.0014202138, -0.0014202138),
(_inq_adl_ph_industry_cards > 0.5) => 0.1199187576,
(_inq_adl_ph_industry_cards = NULL) => -0.0004736616, -0.0004736616);

// Tree: 242 
final_score_242 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 20.5) => -0.0053012094,
(f_rel_under500miles_cnt_d > 20.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 88) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 57.5) => 0.0580546074,
      (inq_firstseen_n > 57.5) => 0.3570250946,
      (inq_firstseen_n = NULL) => 0.1081284821, 0.1081284821),
   (f_curraddrcrimeindex_i > 88) => -0.0026738629,
   (f_curraddrcrimeindex_i = NULL) => 0.0369961125, 0.0369961125),
(f_rel_under500miles_cnt_d = NULL) => 0.0006594173, 0.0006594173);

// Tree: 243 
final_score_243 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 23.5) => 
   map(
   (pp_src in ['CY','E1','EN','EQ','FA','KW','LP','PL','UT','UW','VO','ZT']) => -0.0047379478,
   (pp_src in ['E2','EM','FF','LA','MD','NW','SL','TN','VW','ZK']) => 0.2398970629,
   (pp_src = '') => 
      map(
      (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 14.5) => 0.0129237586,
      (mth_source_utildid_fseen > 14.5) => -0.1083174597,
      (mth_source_utildid_fseen = NULL) => 0.0095172111, 0.0095172111), 0.0083818199),
(mth_exp_last_update > 23.5) => -0.0558002408,
(mth_exp_last_update = NULL) => 0.0041618256, 0.0041618256);

// Tree: 244 
final_score_244 := map(
(NULL < mth_source_md_fseen and mth_source_md_fseen <= 7.5) => 0.0069957534,
(mth_source_md_fseen > 7.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 169421) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 114.5) => -0.2590145185,
      (f_prevaddrageoldest_d > 114.5) => -0.0470846369,
      (f_prevaddrageoldest_d = NULL) => -0.1554469745, -0.1554469745),
   (f_curraddrmedianvalue_d > 169421) => 0.0599196608,
   (f_curraddrmedianvalue_d = NULL) => -0.0752963233, -0.0752963233),
(mth_source_md_fseen = NULL) => 0.0034089764, 0.0034089764);

// Tree: 245 
final_score_245 := map(
(NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 157.5) => -0.0017861134,
(r_mos_since_paw_fseen_d > 157.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 32707.5) => 0.1299654360,
   (f_curraddrmedianincome_d > 32707.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By SSN','Child','Daughter','Father']) => -0.2259369813,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => -0.0833993571,
      (phone_subject_title = '') => -0.1029846795, -0.1029846795),
   (f_curraddrmedianincome_d = NULL) => -0.0712420264, -0.0712420264),
(r_mos_since_paw_fseen_d = NULL) => -0.0056997283, -0.0056997283);

// Tree: 246 
final_score_246 := map(
(NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 65.5) => 
   map(
   (NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 35.5) => 0.0034806293,
   (mth_pp_orig_lastseen > 35.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 5.5) => 0.2166931227,
      (f_inq_count_i > 5.5) => 0.0179106418,
      (f_inq_count_i = NULL) => 0.0829444164, 0.0829444164),
   (mth_pp_orig_lastseen = NULL) => 0.0067818560, 0.0067818560),
(mth_pp_orig_lastseen > 65.5) => -0.1442471284,
(mth_pp_orig_lastseen = NULL) => 0.0016016890, 0.0016016890);

// Tree: 247 
final_score_247 := map(
(NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 26.5) => -0.0108452758,
(mth_source_ppla_fseen > 26.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 73622.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -13.5) => 0.2709062551,
      (f_addrchangecrimediff_i > -13.5) => 0.0668964888,
      (f_addrchangecrimediff_i = NULL) => 0.1551560331, 0.1551560331),
   (f_curraddrmedianincome_d > 73622.5) => -0.0669428962,
   (f_curraddrmedianincome_d = NULL) => 0.0928599920, 0.0928599920),
(mth_source_ppla_fseen = NULL) => -0.0076863486, -0.0076863486);

// Tree: 248 
final_score_248 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 138273.5) => 
   map(
   (NULL < mth_pp_date_nonglb_lastseen and mth_pp_date_nonglb_lastseen <= 108) => 
      map(
      (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 8.5) => -0.0044522138,
      (f_rel_incomeover100_count_d > 8.5) => -0.1633046465,
      (f_rel_incomeover100_count_d = NULL) => -0.0059587809, -0.0059587809),
   (mth_pp_date_nonglb_lastseen > 108) => 0.1620022060,
   (mth_pp_date_nonglb_lastseen = NULL) => -0.0044284324, -0.0044284324),
(f_prevaddrmedianincome_d > 138273.5) => -0.2139333449,
(f_prevaddrmedianincome_d = NULL) => -0.0060886992, -0.0060886992);

// Tree: 249 
final_score_249 := map(
(NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 71.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 8.5) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 28.5) => 0.0222985820,
      (f_rel_homeover100_count_d > 28.5) => -0.2115870469,
      (f_rel_homeover100_count_d = NULL) => 0.0189177708, 0.0189177708),
   (f_inq_count_i > 8.5) => -0.0223676662,
   (f_inq_count_i = NULL) => -0.0004602650, -0.0004602650),
(mth_source_utildid_fseen > 71.5) => -0.1600988361,
(mth_source_utildid_fseen = NULL) => -0.0019823267, -0.0019823267);

// Tree: 250 
final_score_250 := map(
(NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 15.5) => 0.0103139850,
(mth_pp_datelastseen > 15.5) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 22.5) => -0.1439045447,
   (f_mos_inq_banko_om_lseen_d > 22.5) => 
      map(
      (NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 2.5) => 0.1519767274,
      (f_componentcharrisktype_i > 2.5) => -0.0296334149,
      (f_componentcharrisktype_i = NULL) => -0.0156383681, -0.0156383681),
   (f_mos_inq_banko_om_lseen_d = NULL) => -0.0485380869, -0.0485380869),
(mth_pp_datelastseen = NULL) => -0.0006242220, -0.0006242220);

// Tree: 251 
final_score_251 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 33.5) => 0.0035701176,
(mth_exp_last_update > 33.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Property','Daughter','Father','Grandfather','Neighbor','Parent','Subject','Subject at Household']) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 9.5) => -0.1269660498,
      (f_corraddrnamecount_d > 9.5) => 0.0529283410,
      (f_corraddrnamecount_d = NULL) => -0.0914868783, -0.0914868783),
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Mother','Relative','Sibling','Sister','Son','Spouse','Wife']) => 0.1760515236,
   (phone_subject_title = '') => -0.0554720934, -0.0554720934),
(mth_exp_last_update = NULL) => 0.0005288150, 0.0005288150);

// Tree: 252 
final_score_252 := map(
(NULL < mth_pp_datevendorlastseen and mth_pp_datevendorlastseen <= 6.5) => 0.0053537721,
(mth_pp_datevendorlastseen > 6.5) => 
   map(
   (NULL < pp_app_ind_has_actv_eda_ph_fl and pp_app_ind_has_actv_eda_ph_fl <= 0.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 35.5) => -0.0007899718,
      (r_pb_order_freq_d > 35.5) => -0.1368912690,
      (r_pb_order_freq_d = NULL) => -0.0727895605, -0.0594478936),
   (pp_app_ind_has_actv_eda_ph_fl > 0.5) => 0.0262060652,
   (pp_app_ind_has_actv_eda_ph_fl = NULL) => -0.0377183932, -0.0377183932),
(mth_pp_datevendorlastseen = NULL) => -0.0022355904, -0.0022355904);

// Tree: 253 
final_score_253 := map(
(NULL < inq_num_addresses_06 and inq_num_addresses_06 <= 1.5) => 
   map(
   (exp_source in ['P']) => -0.0557027116,
   (exp_source in ['S']) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 17.5) => 0.0272045872,
      (f_rel_homeover100_count_d > 17.5) => -0.1354044961,
      (f_rel_homeover100_count_d = NULL) => 0.0144849434, 0.0144849434),
   (exp_source = '') => 0.0000128335, -0.0010869660),
(inq_num_addresses_06 > 1.5) => 0.1747107089,
(inq_num_addresses_06 = NULL) => 0.0010027538, 0.0010027538);

// Tree: 254 
final_score_254 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 14.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 1.22341097274996) => 0.0199440766,
   (f_add_curr_mobility_index_n > 1.22341097274996) => -0.1237564509,
   (f_add_curr_mobility_index_n = NULL) => -0.1558661116, 0.0170166824),
(f_rel_under100miles_cnt_d > 14.5) => 
   map(
   (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 72.5) => -0.0402852692,
   (mth_source_inf_fseen > 72.5) => 0.1814856521,
   (mth_source_inf_fseen = NULL) => -0.0339623390, -0.0339623390),
(f_rel_under100miles_cnt_d = NULL) => 0.0050223636, 0.0050223636);

// Tree: 255 
final_score_255 := map(
(pp_src in ['CY','E1','LP','PL','SL','TN','ZT']) => -0.1725950369,
(pp_src in ['E2','EM','EN','EQ','FA','FF','KW','LA','MD','NW','UT','UW','VO','VW','ZK']) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 20.5) => 
      map(
      (NULL < subject_ssn_mismatch and subject_ssn_mismatch <= -0.5) => 0.0406791246,
      (subject_ssn_mismatch > -0.5) => -0.0508591799,
      (subject_ssn_mismatch = NULL) => -0.0246503180, -0.0246503180),
   (f_rel_homeover100_count_d > 20.5) => 0.1220201496,
   (f_rel_homeover100_count_d = NULL) => -0.0145846976, -0.0145846976),
(pp_src = '') => 0.0094457262, 0.0032867981);

// Tree: 256 
final_score_256 := map(
(NULL < number_of_sources and number_of_sources <= 1.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Father','Grandparent','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => 
      map(
      (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 0.5) => -0.1053619654,
      (inq_adl_firstseen_n > 0.5) => 0.1436756066,
      (inq_adl_firstseen_n = NULL) => -0.0903788014, -0.0903788014),
   (phone_subject_title in ['Associate','Associate By Property','Associate By SSN','Grandchild','Granddaughter','Grandfather','Grandmother','Mother','Subject at Household']) => 0.0717344665,
   (phone_subject_title = '') => -0.0608640580, -0.0608640580),
(number_of_sources > 1.5) => 0.1072215533,
(number_of_sources = NULL) => -0.0166989184, -0.0166989184);

// Tree: 257 
final_score_257 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 6.5) => -0.0228220373,
(f_corraddrnamecount_d > 6.5) => 
   map(
   (pp_source in ['CELL','GONG','INFUTOR','OTHER','THRIVE']) => -0.0135033791,
   (pp_source in ['HEADER','IBEHAVIOR','INQUIRY','INTRADO','PCNSR','TARGUS']) => 
      map(
      (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 34.5) => 0.0782929337,
      (inq_adl_lastseen_n > 34.5) => -0.1266281378,
      (inq_adl_lastseen_n = NULL) => 0.0627060961, 0.0627060961),
   (pp_source = '') => 0.0055642641, 0.0188018215),
(f_corraddrnamecount_d = NULL) => -0.0064714639, -0.0064714639);

// Tree: 258 
final_score_258 := map(
(NULL < mth_source_cr_lseen and mth_source_cr_lseen <= 6.5) => 
   map(
   (pp_origphonetype in ['O','V','W']) => 
      map(
      (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 12.5) => -0.0371340134,
      (f_rel_homeover200_count_d > 12.5) => 0.0807490024,
      (f_rel_homeover200_count_d = NULL) => -0.0239229858, -0.0239229858),
   (pp_origphonetype in ['L']) => 0.0586768602,
   (pp_origphonetype = '') => 0.0076514471, 0.0008984899),
(mth_source_cr_lseen > 6.5) => -0.2291663939,
(mth_source_cr_lseen = NULL) => -0.0016653832, -0.0016653832);

// Tree: 259 
final_score_259 := map(
(pp_src in ['CY','E1','EN','EQ','FA','KW','LP','PL','SL','UT','UW','VO','ZT']) => 
   map(
   (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 8.5) => 
      map(
      (NULL < inq_lastseen_n and inq_lastseen_n <= 5.5) => 0.0922286528,
      (inq_lastseen_n > 5.5) => -0.0507385580,
      (inq_lastseen_n = NULL) => 0.0293481071, 0.0293481071),
   (mth_pp_datevendorfirstseen > 8.5) => -0.0458094087,
   (mth_pp_datevendorfirstseen = NULL) => -0.0238484210, -0.0238484210),
(pp_src in ['E2','EM','FF','LA','MD','NW','TN','VW','ZK']) => 0.1608656536,
(pp_src = '') => 0.0033586007, -0.0009351623);

// Tree: 260 
final_score_260 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 3.5) => 0.0081411553,
(mth_exp_last_update > 3.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Property','Associate By Shared Associates','Daughter','Father','Grandfather','Grandmother','Grandparent','Husband','Neighbor','Relative','Sister','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 6.5) => -0.0768304232,
      (mth_internal_ver_first_seen > 6.5) => 0.0006731541,
      (mth_internal_ver_first_seen = NULL) => -0.0368567313, -0.0368567313),
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By SSN','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandson','Mother','Parent','Sibling','Son','Spouse']) => 0.1056076937,
   (phone_subject_title = '') => -0.0249928666, -0.0249928666),
(mth_exp_last_update = NULL) => 0.0021798213, 0.0021798213);

// Tree: 261 
final_score_261 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 200193) => 0.0022344965,
(f_addrchangevaluediff_d > 200193) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 3.5) => 0.0733786647,
   (f_sourcerisktype_i > 3.5) => -0.1670483918,
   (f_sourcerisktype_i = NULL) => -0.0993785249, -0.0993785249),
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 25.5) => -0.0134142063,
   (inq_adl_firstseen_n > 25.5) => 0.1109606384,
   (inq_adl_firstseen_n = NULL) => -0.0048910571, -0.0048910571), -0.0033034521);

// Tree: 262 
final_score_262 := map(
(NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 4.5) => 
   map(
   (NULL < _pp_app_fb_ph and _pp_app_fb_ph <= 1.5) => 0.1572911549,
   (_pp_app_fb_ph > 1.5) => 
      map(
      (NULL < inq_num and inq_num <= 1.5) => -0.0210800406,
      (inq_num > 1.5) => 0.0650754011,
      (inq_num = NULL) => -0.0162661434, -0.0162661434),
   (_pp_app_fb_ph = NULL) => -0.0138845032, -0.0138845032),
(f_componentcharrisktype_i > 4.5) => 0.0234810649,
(f_componentcharrisktype_i = NULL) => 0.0022396925, 0.0022396925);

// Tree: 263 
final_score_263 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 275.5) => 
   map(
   (NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 166.5) => 0.0006579253,
   (mth_source_cr_fseen > 166.5) => 0.2059971901,
   (mth_source_cr_fseen = NULL) => 0.0029163098, 0.0029163098),
(f_prevaddrlenofres_d > 275.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Brother','Child','Daughter','Father','Grandfather','Mother','Neighbor','Parent','Sister','Son','Subject','Subject at Household','Wife']) => -0.0764093955,
   (phone_subject_title in ['Associate By Property','Associate By SSN','Associate By Vehicle','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Relative','Sibling','Spouse']) => 0.1958351223,
   (phone_subject_title = '') => -0.0617309017, -0.0617309017),
(f_prevaddrlenofres_d = NULL) => -0.0049534374, -0.0049534374);

// Tree: 264 
final_score_264 := map(
(NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 69.5) => 
   map(
   (NULL < pp_origconfscore and pp_origconfscore <= 1.5) => 0.0262570080,
   (pp_origconfscore > 1.5) => -0.0122856249,
   (pp_origconfscore = NULL) => -0.0028574622, -0.0028574622),
(mth_pp_eda_hist_did_dt > 69.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.636055274057505) => -0.0591927086,
   (f_add_curr_mobility_index_n > 0.636055274057505) => 0.1407860841,
   (f_add_curr_mobility_index_n = NULL) => -0.0448491154, -0.0448491154),
(mth_pp_eda_hist_did_dt = NULL) => -0.0079062357, -0.0079062357);

// Tree: 265 
final_score_265 := map(
(NULL < f_util_add_input_inf_n and f_util_add_input_inf_n <= 0.5) => -0.0056034384,
(f_util_add_input_inf_n > 0.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Vehicle','Child','Husband','Neighbor','Sister','Son','Subject','Subject at Household','Wife']) => 
      map(
      (pp_app_coctype in ['EOC','SP2']) => -0.1141540032,
      (pp_app_coctype in ['PMC','RCC']) => 0.1089472736,
      (pp_app_coctype = '') => -0.0292662142, 0.0130621296),
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Parent','Relative','Sibling','Spouse']) => 0.2801114129,
   (phone_subject_title = '') => 0.0635373788, 0.0635373788),
(f_util_add_input_inf_n = NULL) => -0.0017080605, -0.0017080605);

// Tree: 266 
final_score_266 := map(
(NULL < mth_source_edadid_fseen and mth_source_edadid_fseen <= 34) => 
   map(
   (NULL < eda_days_ind_first_seen and eda_days_ind_first_seen <= 423.5) => -0.0018127035,
   (eda_days_ind_first_seen > 423.5) => 
      map(
      (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 158.5) => -0.1804338791,
      (mth_source_inf_fseen > 158.5) => 0.0791912260,
      (mth_source_inf_fseen = NULL) => -0.1133574842, -0.1133574842),
   (eda_days_ind_first_seen = NULL) => -0.0063982630, -0.0063982630),
(mth_source_edadid_fseen > 34) => 0.1589651965,
(mth_source_edadid_fseen = NULL) => -0.0049035215, -0.0049035215);

// Tree: 267 
final_score_267 := map(
(NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 27.5) => 
   map(
   (NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 153) => 0.0006470549,
   (mth_source_cr_fseen > 153) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 110431) => 0.2990713193,
      (f_prevaddrmedianvalue_d > 110431) => 0.0250717030,
      (f_prevaddrmedianvalue_d = NULL) => 0.1583688137, 0.1583688137),
   (mth_source_cr_fseen = NULL) => 0.0029832059, 0.0029832059),
(f_rel_homeover50_count_d > 27.5) => -0.0599801843,
(f_rel_homeover50_count_d = NULL) => -0.0013582877, -0.0013582877);

// Tree: 268 
final_score_268 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 68436) => 
   map(
   (NULL < inq_lastseen_n and inq_lastseen_n <= 7.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Vehicle','Daughter','Grandfather','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Spouse','Subject at Household','Wife']) => 0.0247629459,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Child','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Mother','Sister','Son','Subject']) => 0.1277096076,
      (phone_subject_title = '') => 0.0798509769, 0.0798509769),
   (inq_lastseen_n > 7.5) => -0.0094251134,
   (inq_lastseen_n = NULL) => 0.0415897954, 0.0415897954),
(f_prevaddrmedianvalue_d > 68436) => -0.0086317661,
(f_prevaddrmedianvalue_d = NULL) => -0.0008824082, -0.0008824082);

// Tree: 269 
final_score_269 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 22.5) => -0.0060765379,
(f_rel_under100miles_cnt_d > 22.5) => 
   map(
   (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 0.1144854904,
      (f_corraddrnamecount_d > 3.5) => -0.0282203632,
      (f_corraddrnamecount_d = NULL) => 0.0378549802, 0.0378549802),
   (f_curraddractivephonelist_d > 0.5) => 0.2069305300,
   (f_curraddractivephonelist_d = NULL) => 0.0553455543, 0.0553455543),
(f_rel_under100miles_cnt_d = NULL) => -0.0003034408, -0.0003034408);

// Tree: 270 
final_score_270 := map(
(NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 6.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 173.5) => 0.0155586012,
   (f_curraddrcartheftindex_i > 173.5) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 3.5) => 0.1364978386,
      (f_mos_inq_banko_om_lseen_d > 3.5) => -0.0524140884,
      (f_mos_inq_banko_om_lseen_d = NULL) => -0.0380222415, -0.0380222415),
   (f_curraddrcartheftindex_i = NULL) => 0.0062877103, 0.0062877103),
(f_rel_incomeover75_count_d > 6.5) => -0.0504402488,
(f_rel_incomeover75_count_d = NULL) => 0.0003408220, 0.0003408220);

// Tree: 271 
final_score_271 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.17627539469211) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -19847) => 0.2653293443,
   (f_addrchangevaluediff_d > -19847) => 0.0453123784,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 6.5) => 0.1776054633,
      (f_corrssnnamecount_d > 6.5) => -0.1472348135,
      (f_corrssnnamecount_d = NULL) => 0.0238864037, 0.0238864037), 0.0848503361),
(f_add_curr_mobility_index_n > 0.17627539469211) => -0.0047505677,
(f_add_curr_mobility_index_n = NULL) => -0.0726900369, -0.0005293367);

// Tree: 272 
final_score_272 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 11.5) => -0.0065046756,
(inq_adl_lastseen_n > 11.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 5.5) => 0.0815379498,
   (f_srchfraudsrchcount_i > 5.5) => 
      map(
      (NULL < inq_num and inq_num <= 1.5) => -0.1804467967,
      (inq_num > 1.5) => 0.0387985730,
      (inq_num = NULL) => -0.0222914681, -0.0222914681),
   (f_srchfraudsrchcount_i = NULL) => 0.0336964349, 0.0336964349),
(inq_adl_lastseen_n = NULL) => -0.0030152033, -0.0030152033);

// Tree: 273 
final_score_273 := map(
(NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 6.5) => -0.0040518648,
(f_rel_incomeover100_count_d > 6.5) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By Shared Associates','Associate By SSN','Father','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Subject at Household','Wife']) => -0.1268037939,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Spouse','Subject']) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 86784) => 0.0552766184,
      (f_curraddrmedianincome_d > 86784) => 0.3011859540,
      (f_curraddrmedianincome_d = NULL) => 0.1707470891, 0.1707470891),
   (phone_subject_title = '') => 0.0581602685, 0.0581602685),
(f_rel_incomeover100_count_d = NULL) => -0.0026216120, -0.0026216120);

// Tree: 274 
final_score_274 := map(
(NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 48.5) => 
   map(
   (NULL < mth_source_paw_lseen and mth_source_paw_lseen <= 2.5) => -0.0079641764,
   (mth_source_paw_lseen > 2.5) => 
      map(
      (NULL < mth_source_paw_lseen and mth_source_paw_lseen <= 78) => 0.2483971320,
      (mth_source_paw_lseen > 78) => -0.0613607103,
      (mth_source_paw_lseen = NULL) => 0.0924500803, 0.0924500803),
   (mth_source_paw_lseen = NULL) => -0.0061402922, -0.0061402922),
(f_rel_homeover50_count_d > 48.5) => 0.1557230045,
(f_rel_homeover50_count_d = NULL) => -0.0047731696, -0.0047731696);

// Tree: 275 
final_score_275 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.154391537068825) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 3.5) => 
      map(
      (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 1.5) => 0.2422280355,
      (f_crim_rel_under25miles_cnt_i > 1.5) => 0.0561275528,
      (f_crim_rel_under25miles_cnt_i = NULL) => 0.1675161629, 0.1675161629),
   (f_srchvelocityrisktype_i > 3.5) => -0.0675875802,
   (f_srchvelocityrisktype_i = NULL) => 0.0883947109, 0.0883947109),
(f_add_curr_mobility_index_n > 0.154391537068825) => -0.0004566382,
(f_add_curr_mobility_index_n = NULL) => -0.0015662845, 0.0018218642);

// Tree: 276 
final_score_276 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Child','Father','Granddaughter','Grandfather','Grandson','Husband','Neighbor','Parent','Sister','Son','Spouse','Subject','Subject at Household']) => -0.0034524534,
(phone_subject_title in ['Associate By Business','Associate By Property','Associate By Vehicle','Daughter','Grandchild','Grandmother','Grandparent','Mother','Relative','Sibling','Wife']) => 
   map(
   (NULL < _phone_zip_match and _phone_zip_match <= 0.5) => 0.0185026018,
   (_phone_zip_match > 0.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 23) => 0.3756448654,
      (f_prevaddrlenofres_d > 23) => 0.0925601827,
      (f_prevaddrlenofres_d = NULL) => 0.1544491417, 0.1544491417),
   (_phone_zip_match = NULL) => 0.0745606908, 0.0745606908),
(phone_subject_title = '') => 0.0023338113, 0.0023338113);

// Tree: 277 
final_score_277 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 608) => -0.0145373089,
(r_pb_order_freq_d > 608) => 0.0721596838,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < mth_phone_fb_rp_date and mth_phone_fb_rp_date <= 23.5) => 
      map(
      (NULL < mth_source_sx_fseen and mth_source_sx_fseen <= 18.5) => 0.0100731505,
      (mth_source_sx_fseen > 18.5) => -0.1262130767,
      (mth_source_sx_fseen = NULL) => 0.0060007607, 0.0060007607),
   (mth_phone_fb_rp_date > 23.5) => 0.1605800536,
   (mth_phone_fb_rp_date = NULL) => 0.0138717012, 0.0138717012), -0.0023980549);

// Tree: 278 
final_score_278 := map(
(NULL < f_college_income_d and f_college_income_d <= 10.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By SSN','Associate By Vehicle','Brother','Daughter','Father','Mother','Neighbor','Relative','Sibling','Son','Subject','Wife']) => -0.0643229494,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Parent','Sister','Spouse','Subject at Household']) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 87.5) => -0.0794350944,
      (f_fp_prevaddrburglaryindex_i > 87.5) => 0.1544240699,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0776216137, 0.0776216137),
   (phone_subject_title = '') => -0.0306390820, -0.0306390820),
(f_college_income_d > 10.5) => -0.1165101269,
(f_college_income_d = NULL) => 0.0066053432, 0.0001801439);

// Tree: 279 
final_score_279 := map(
(NULL < f_inq_per_addr_i and f_inq_per_addr_i <= 15.5) => 
   map(
   (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0172153901,
   (_phone_match_code_n > 0.5) => 0.0167726965,
   (_phone_match_code_n = NULL) => -0.0029658070, -0.0029658070),
(f_inq_per_addr_i > 15.5) => 
   map(
   (NULL < f_estimated_income_d and f_estimated_income_d <= 75000) => -0.1791248193,
   (f_estimated_income_d > 75000) => 0.1017380674,
   (f_estimated_income_d = NULL) => -0.1075842727, -0.1075842727),
(f_inq_per_addr_i = NULL) => -0.0057121065, -0.0057121065);

// Tree: 280 
final_score_280 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.47766473613175) => -0.0124709449,
(f_add_curr_mobility_index_n > 0.47766473613175) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 2.5) => -0.0754172800,
   (f_rel_under500miles_cnt_d > 2.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 138.5) => 0.0500435260,
      (r_pb_order_freq_d > 138.5) => -0.0924546259,
      (r_pb_order_freq_d = NULL) => 0.0499115053, 0.0343107422),
   (f_rel_under500miles_cnt_d = NULL) => 0.0250557695, 0.0250557695),
(f_add_curr_mobility_index_n = NULL) => 0.0560184115, -0.0041446183);

// Tree: 281 
final_score_281 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 30.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 18.5) => -0.0024908857,
   (f_rel_under25miles_cnt_d > 18.5) => 
      map(
      (NULL < mth_exp_last_update and mth_exp_last_update <= 13.5) => 0.0385192775,
      (mth_exp_last_update > 13.5) => 0.2428960365,
      (mth_exp_last_update = NULL) => 0.0569699571, 0.0569699571),
   (f_rel_under25miles_cnt_d = NULL) => 0.0019634575, 0.0019634575),
(f_rel_incomeover25_count_d > 30.5) => -0.0735202780,
(f_rel_incomeover25_count_d = NULL) => -0.0014484485, -0.0014484485);

// Tree: 282 
final_score_282 := map(
(NULL < inq_firstseen_n and inq_firstseen_n <= 20.5) => 0.0166258264,
(inq_firstseen_n > 20.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Father','Grandfather','Grandson','Husband','Mother','Neighbor','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 12.5) => -0.0276637771,
      (f_crim_rel_under25miles_cnt_i > 12.5) => 0.2143785462,
      (f_crim_rel_under25miles_cnt_i = NULL) => -0.0237899521, -0.0237899521),
   (phone_subject_title in ['Associate By Property','Associate By SSN','Daughter','Grandchild','Granddaughter','Grandmother','Grandparent','Parent']) => 0.2350639897,
   (phone_subject_title = '') => -0.0191326845, -0.0191326845),
(inq_firstseen_n = NULL) => 0.0013677991, 0.0013677991);

// Tree: 283 
final_score_283 := map(
(NULL < mth_source_edafla_fseen and mth_source_edafla_fseen <= 12.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Brother','Daughter','Grandfather','Grandparent','Grandson','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => -0.0014665486,
   (phone_subject_title in ['Associate By Property','Associate By SSN','Associate By Vehicle','Child','Father','Grandchild','Granddaughter','Grandmother','Husband']) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 27) => 0.0131558863,
      (inq_firstseen_n > 27) => 0.2304152073,
      (inq_firstseen_n = NULL) => 0.1047614956, 0.1047614956),
   (phone_subject_title = '') => 0.0020929807, 0.0020929807),
(mth_source_edafla_fseen > 12.5) => 0.1389141545,
(mth_source_edafla_fseen = NULL) => 0.0034144334, 0.0034144334);

// Tree: 284 
final_score_284 := map(
(NULL < pk_cell_indicator and pk_cell_indicator <= 2.5) => 0.0077500009,
(pk_cell_indicator > 2.5) => 
   map(
   (NULL < f_college_income_d and f_college_income_d <= 3.5) => -0.1220780830,
   (f_college_income_d > 3.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 132.5) => -0.0325578695,
      (f_prevaddrlenofres_d > 132.5) => 0.1684013775,
      (f_prevaddrlenofres_d = NULL) => 0.0276224398, 0.0276224398),
   (f_college_income_d = NULL) => -0.0351113115, -0.0288643970),
(pk_cell_indicator = NULL) => 0.0025180773, 0.0025180773);

// Tree: 285 
final_score_285 := map(
(NULL < inq_num and inq_num <= 2.5) => -0.0014459183,
(inq_num > 2.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 23.5) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 42.5) => 0.0435279590,
      (inq_firstseen_n > 42.5) => 0.2700584103,
      (inq_firstseen_n = NULL) => 0.1170919715, 0.1170919715),
   (inq_adl_lastseen_n > 23.5) => -0.0411696484,
   (inq_adl_lastseen_n = NULL) => 0.0578714944, 0.0578714944),
(inq_num = NULL) => 0.0008310007, 0.0008310007);

// Tree: 286 
final_score_286 := map(
(phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Brother','Granddaughter','Grandmother','Grandson','Neighbor','Relative','Sibling','Sister','Spouse','Subject','Subject at Household','Wife']) => -0.0104154398,
(phone_subject_title in ['Associate','Associate By Business','Associate By SSN','Associate By Vehicle','Child','Daughter','Father','Grandchild','Grandfather','Grandparent','Husband','Mother','Parent','Son']) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 70.5) => -0.0186747461,
   (f_prevaddrmurderindex_i > 70.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 19.5) => 0.2279556464,
      (f_prevaddrlenofres_d > 19.5) => 0.0541933901,
      (f_prevaddrlenofres_d = NULL) => 0.0869832374, 0.0869832374),
   (f_prevaddrmurderindex_i = NULL) => 0.0546595713, 0.0546595713),
(phone_subject_title = '') => -0.0019869527, -0.0019869527);

// Tree: 287 
final_score_287 := map(
(NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 20.5) => 0.0105061159,
(mth_source_inf_fseen > 20.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -36) => 0.0398389057,
   (f_addrchangecrimediff_i > -36) => -0.0907827655,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 25.5) => 0.1087927872,
      (inq_firstseen_n > 25.5) => -0.1096535669,
      (inq_firstseen_n = NULL) => 0.0094989899, 0.0094989899), -0.0388335583),
(mth_source_inf_fseen = NULL) => 0.0072681234, 0.0072681234);

// Tree: 288 
final_score_288 := map(
(NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => 
   map(
   (pp_source in ['GONG','INFUTOR','INTRADO','OTHER','PCNSR','THRIVE']) => -0.1024841557,
   (pp_source in ['CELL','HEADER','IBEHAVIOR','INQUIRY','TARGUS']) => 0.0065865480,
   (pp_source = '') => -0.0042227706, -0.0099955695),
(_pp_rule_high_vend_conf > 0.5) => 
   map(
   (NULL < mth_source_ppca_lseen and mth_source_ppca_lseen <= 16.5) => 0.0712334133,
   (mth_source_ppca_lseen > 16.5) => -0.1179771513,
   (mth_source_ppca_lseen = NULL) => 0.0406539281, 0.0406539281),
(_pp_rule_high_vend_conf = NULL) => -0.0019240114, -0.0019240114);

// Tree: 289 
final_score_289 := map(
(NULL < eda_disc_cnt12 and eda_disc_cnt12 <= 0.5) => 
   map(
   (NULL < mth_pp_app_fb_ph_dt and mth_pp_app_fb_ph_dt <= 11.5) => 0.0010083131,
   (mth_pp_app_fb_ph_dt > 11.5) => -0.1680208637,
   (mth_pp_app_fb_ph_dt = NULL) => -0.0003718690, -0.0003718690),
(eda_disc_cnt12 > 0.5) => 
   map(
   (NULL < _phone_match_code_lns and _phone_match_code_lns <= 0.5) => -0.0453882165,
   (_phone_match_code_lns > 0.5) => -0.1804893112,
   (_phone_match_code_lns = NULL) => -0.0834208776, -0.0834208776),
(eda_disc_cnt12 = NULL) => -0.0028193262, -0.0028193262);

// Tree: 290 
final_score_290 := map(
(NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 3.5) => 
   map(
   (NULL < number_of_sources and number_of_sources <= 3.5) => -0.0527032067,
   (number_of_sources > 3.5) => 0.0933986452,
   (number_of_sources = NULL) => -0.0416120633, -0.0416120633),
(f_rel_educationover12_count_d > 3.5) => 
   map(
   (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => 0.0043285338,
   (f_curraddractivephonelist_d > 0.5) => 0.0017783257,
   (f_curraddractivephonelist_d = NULL) => 0.0039481464, 0.0039481464),
(f_rel_educationover12_count_d = NULL) => -0.0020877046, -0.0020877046);

// Tree: 291 
final_score_291 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 12.5) => -0.0091819278,
(inq_adl_lastseen_n > 12.5) => 
   map(
   (pp_source in ['CELL','HEADER','INQUIRY','PCNSR','THRIVE']) => 
      map(
      (NULL < mth_pp_datevendorlastseen and mth_pp_datevendorlastseen <= 11.5) => -0.0650531435,
      (mth_pp_datevendorlastseen > 11.5) => 0.0689204415,
      (mth_pp_datevendorlastseen = NULL) => 0.0011265792, 0.0011265792),
   (pp_source in ['GONG','IBEHAVIOR','INFUTOR','INTRADO','OTHER','TARGUS']) => 0.1032314688,
   (pp_source = '') => 0.0809430824, 0.0371301237),
(inq_adl_lastseen_n = NULL) => -0.0051906960, -0.0051906960);

// Tree: 292 
final_score_292 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 104840.5) => -0.0043168451,
(f_curraddrmedianincome_d > 104840.5) => 
   map(
   (NULL < f_idverrisktype_i and f_idverrisktype_i <= 6.5) => 0.0112319504,
   (f_idverrisktype_i > 6.5) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => 0.2523948048,
      (f_sourcerisktype_i > 4.5) => 0.0528636070,
      (f_sourcerisktype_i = NULL) => 0.1526292059, 0.1526292059),
   (f_idverrisktype_i = NULL) => 0.0492091509, 0.0492091509),
(f_curraddrmedianincome_d = NULL) => -0.0015527162, -0.0015527162);

// Tree: 293 
final_score_293 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 1.5) => 
   map(
   (NULL < f_estimated_income_d and f_estimated_income_d <= 31500) => -0.0537856706,
   (f_estimated_income_d > 31500) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 307932) => 0.0615971192,
      (f_prevaddrmedianvalue_d > 307932) => -0.0198936297,
      (f_prevaddrmedianvalue_d = NULL) => 0.0418759690, 0.0418759690),
   (f_estimated_income_d = NULL) => 0.0270252709, 0.0270252709),
(f_rel_ageover40_count_d > 1.5) => -0.0034502813,
(f_rel_ageover40_count_d = NULL) => 0.0059466315, 0.0059466315);

// Tree: 294 
final_score_294 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 27.5) => 
   map(
   (NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 4.5) => 0.0230551845,
   (mth_eda_dt_first_seen > 4.5) => -0.0055812348,
   (mth_eda_dt_first_seen = NULL) => 0.0064441458, 0.0064441458),
(mth_source_ppdid_lseen > 27.5) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 151.5) => -0.0688066066,
   (mth_pp_app_npa_last_change_dt > 151.5) => 0.1680864464,
   (mth_pp_app_npa_last_change_dt = NULL) => -0.0490983659, -0.0490983659),
(mth_source_ppdid_lseen = NULL) => 0.0023107816, 0.0023107816);

// Tree: 295 
final_score_295 := map(
(NULL < mth_pp_app_fb_ph_dt and mth_pp_app_fb_ph_dt <= 11.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 12.5) => -0.0017390949,
   (inq_adl_lastseen_n > 12.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 1026) => -0.0289512391,
      (f_addrchangeincomediff_d > 1026) => 0.1181478551,
      (f_addrchangeincomediff_d = NULL) => 0.0289057394, 0.0401996286),
   (inq_adl_lastseen_n = NULL) => 0.0017405143, 0.0017405143),
(mth_pp_app_fb_ph_dt > 11.5) => -0.1627340555,
(mth_pp_app_fb_ph_dt = NULL) => 0.0002538076, 0.0002538076);

// Tree: 296 
final_score_296 := map(
(NULL < eda_address_match_best and eda_address_match_best <= 0.5) => -0.0038937862,
(eda_address_match_best > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 70.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.400957943245585) => 0.2616263738,
      (f_add_curr_mobility_index_n > 0.400957943245585) => 0.0070662916,
      (f_add_curr_mobility_index_n = NULL) => 0.1690590712, 0.1690590712),
   (f_mos_inq_banko_cm_fseen_d > 70.5) => 0.0219998218,
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0640587672, 0.0640587672),
(eda_address_match_best = NULL) => 0.0003132813, 0.0003132813);

// Tree: 297 
final_score_297 := map(
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By SSN','Associate By Vehicle','Father','Grandparent','Grandson','Mother','Neighbor','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => -0.0058367105,
(phone_subject_title in ['Associate','Associate By Property','Associate By Shared Associates','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Husband','Parent','Relative']) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 17279.5) => -0.0049103315,
   (f_addrchangevaluediff_d > 17279.5) => 
      map(
      (NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 1147) => 0.0488209972,
      (eda_max_days_interrupt > 1147) => 0.2917406796,
      (eda_max_days_interrupt = NULL) => 0.0800216903, 0.0800216903),
   (f_addrchangevaluediff_d = NULL) => 0.0442638237, 0.0297100482),
(phone_subject_title = '') => 0.0016282849, 0.0016282849);

// Tree: 298 
final_score_298 := map(
(NULL < f_vardobcount_i and f_vardobcount_i <= 3.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 120.5) => 0.0023233096,
   (mth_source_ppdid_fseen > 120.5) => 0.1359083052,
   (mth_source_ppdid_fseen = NULL) => 0.0035311608, 0.0035311608),
(f_vardobcount_i > 3.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 137) => -0.0133416154,
   (f_fp_prevaddrburglaryindex_i > 137) => -0.2536645085,
   (f_fp_prevaddrburglaryindex_i = NULL) => -0.1292115817, -0.1292115817),
(f_vardobcount_i = NULL) => 0.0016900231, 0.0016900231);

// Tree: 299 
final_score_299 := map(
(NULL < _pp_rule_30 and _pp_rule_30 <= 0.5) => 
   map(
   (NULL < _pp_rule_ins_ver_above and _pp_rule_ins_ver_above <= 0.5) => 0.0056751828,
   (_pp_rule_ins_ver_above > 0.5) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 132) => 0.0997928199,
      (mth_pp_app_npa_last_change_dt > 132) => -0.1067995089,
      (mth_pp_app_npa_last_change_dt = NULL) => 0.0617177832, 0.0617177832),
   (_pp_rule_ins_ver_above = NULL) => 0.0077339192, 0.0077339192),
(_pp_rule_30 > 0.5) => -0.1173055616,
(_pp_rule_30 = NULL) => 0.0061856344, 0.0061856344);

// Tree: 300 
final_score_300 := map(
(segment in ['0 - Disconnected','1 - Other']) => -0.0350053724,
(segment in ['2 - Cell Phone','3 - ExpHit']) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 15.5) => 
      map(
      (NULL < subject_ssn_mismatch and subject_ssn_mismatch <= -0.5) => 0.1222279398,
      (subject_ssn_mismatch > -0.5) => 0.0284909347,
      (subject_ssn_mismatch = NULL) => 0.0583938740, 0.0583938740),
   (f_inq_count_i > 15.5) => -0.0417389895,
   (f_inq_count_i = NULL) => 0.0307710151, 0.0307710151),
(segment = '') => -0.0059533201, -0.0059533201);

// Tree: 301 
final_score_301 := map(
(NULL < eda_months_addr_last_seen and eda_months_addr_last_seen <= 0.5) => -0.0018076848,
(eda_months_addr_last_seen > 0.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 22.5) => 0.0608237327,
   (f_addrchangecrimediff_i > 22.5) => -0.0589364296,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 3.5) => 0.0332320481,
      (f_rel_incomeover50_count_d > 3.5) => 0.1412966430,
      (f_rel_incomeover50_count_d = NULL) => 0.0886265043, 0.0886265043), 0.0410857097),
(eda_months_addr_last_seen = NULL) => 0.0011294186, 0.0011294186);

// Tree: 302 
final_score_302 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 13.5) => 
   map(
   (NULL < mth_source_rm_fseen and mth_source_rm_fseen <= 8.5) => 0.0047037662,
   (mth_source_rm_fseen > 8.5) => 
      map(
      (NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 808.5) => 0.0478819143,
      (eda_max_days_interrupt > 808.5) => 0.3989907482,
      (eda_max_days_interrupt = NULL) => 0.1245746289, 0.1245746289),
   (mth_source_rm_fseen = NULL) => 0.0114593275, 0.0114593275),
(f_rel_incomeover25_count_d > 13.5) => -0.0184072770,
(f_rel_incomeover25_count_d = NULL) => 0.0008865198, 0.0008865198);

// Tree: 303 
final_score_303 := map(
(NULL < source_eda_any_clean and source_eda_any_clean <= 0.5) => -0.0092482892,
(source_eda_any_clean > 0.5) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 15.5) => 
      map(
      (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 12.5) => 0.0518999138,
      (f_rel_homeover50_count_d > 12.5) => 0.2266915346,
      (f_rel_homeover50_count_d = NULL) => 0.0756370475, 0.0756370475),
   (f_rel_incomeover25_count_d > 15.5) => -0.0708011932,
   (f_rel_incomeover25_count_d = NULL) => 0.0454879979, 0.0454879979),
(source_eda_any_clean = NULL) => -0.0057713557, -0.0057713557);

// Tree: 304 
final_score_304 := map(
(NULL < eda_num_phs_discon_hhid and eda_num_phs_discon_hhid <= 2.5) => 
   map(
   (eda_pfrd_address_ind in ['1A','1B','1E','XX']) => 0.0035040968,
   (eda_pfrd_address_ind in ['1C','1D']) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -43) => -0.0860692650,
      (f_addrchangecrimediff_i > -43) => 0.1476775161,
      (f_addrchangecrimediff_i = NULL) => 0.0625798208, 0.0860850360),
   (eda_pfrd_address_ind = '') => 0.0071152045, 0.0071152045),
(eda_num_phs_discon_hhid > 2.5) => -0.0570676842,
(eda_num_phs_discon_hhid = NULL) => -0.0003632624, -0.0003632624);

// Tree: 305 
final_score_305 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 132.5) => -0.0127467449,
(f_prevaddrcartheftindex_i > 132.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Daughter','Grandfather','Grandparent','Grandson','Mother','Neighbor','Relative','Sibling','Sister','Son','Subject','Subject at Household']) => 0.0133226449,
   (phone_subject_title in ['Associate By SSN','Child','Father','Grandchild','Granddaughter','Grandmother','Husband','Parent','Spouse','Wife']) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 179.5) => 0.3276225206,
      (f_prevaddrcartheftindex_i > 179.5) => -0.0468213900,
      (f_prevaddrcartheftindex_i = NULL) => 0.1846057492, 0.1846057492),
   (phone_subject_title = '') => 0.0209048051, 0.0209048051),
(f_prevaddrcartheftindex_i = NULL) => 0.0008097247, 0.0008097247);

// Tree: 306 
final_score_306 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 4.5) => -0.0293910337,
(f_rel_under25miles_cnt_d > 4.5) => 
   map(
   (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 23.5) => 0.0129305714,
   (mth_pp_datevendorfirstseen > 23.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 120779.5) => -0.0909977483,
      (f_prevaddrmedianvalue_d > 120779.5) => 0.0096846588,
      (f_prevaddrmedianvalue_d = NULL) => -0.0351233521, -0.0351233521),
   (mth_pp_datevendorfirstseen = NULL) => 0.0048269841, 0.0048269841),
(f_rel_under25miles_cnt_d = NULL) => -0.0060024171, -0.0060024171);

// Tree: 307 
final_score_307 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.311645966706285) => -0.0145396577,
(f_add_curr_mobility_index_n > 0.311645966706285) => 
   map(
   (NULL < mth_source_md_fseen and mth_source_md_fseen <= 36.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 15931) => -0.0795089185,
      (f_prevaddrmedianincome_d > 15931) => 0.0250646878,
      (f_prevaddrmedianincome_d = NULL) => 0.0198170265, 0.0198170265),
   (mth_source_md_fseen > 36.5) => -0.1724767657,
   (mth_source_md_fseen = NULL) => 0.0177454204, 0.0177454204),
(f_add_curr_mobility_index_n = NULL) => -0.0124503252, 0.0044041364);

// Tree: 308 
final_score_308 := map(
(NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 151.5) => -0.0055499426,
(mth_pp_app_npa_effective_dt > 151.5) => 
   map(
   (NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 7.5) => 0.0166594118,
   (mth_source_ppla_lseen > 7.5) => 
      map(
      (phone_subject_title in ['Subject at Household']) => 0.0406401750,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => 0.2186796831,
      (phone_subject_title = '') => 0.0933334823, 0.0933334823),
   (mth_source_ppla_lseen = NULL) => 0.0253564198, 0.0253564198),
(mth_pp_app_npa_effective_dt = NULL) => 0.0019738202, 0.0019738202);

// Tree: 309 
final_score_309 := map(
(NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => 
   map(
   (pp_source in ['GONG','INFUTOR','INTRADO','OTHER','PCNSR','THRIVE']) => -0.0967654379,
   (pp_source in ['CELL','HEADER','IBEHAVIOR','INQUIRY','TARGUS']) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 13.5) => 0.2186505230,
      (mth_pp_app_npa_last_change_dt > 13.5) => 0.0017041123,
      (mth_pp_app_npa_last_change_dt = NULL) => 0.0128203747, 0.0128203747),
   (pp_source = '') => -0.0146001843, -0.0138020945),
(_pp_rule_high_vend_conf > 0.5) => 0.0484960163,
(_pp_rule_high_vend_conf = NULL) => -0.0036890654, -0.0036890654);

// Tree: 310 
final_score_310 := map(
(NULL < _pp_src_all_tn and _pp_src_all_tn <= 0.5) => 
   map(
   (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 116.5) => -0.0009728676,
   (mth_pp_eda_hist_did_dt > 116.5) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 32) => -0.1373337058,
      (inq_firstseen_n > 32) => 0.0974180178,
      (inq_firstseen_n = NULL) => -0.0740944660, -0.0740944660),
   (mth_pp_eda_hist_did_dt = NULL) => -0.0032049623, -0.0032049623),
(_pp_src_all_tn > 0.5) => 0.1781124450,
(_pp_src_all_tn = NULL) => -0.0020823929, -0.0020823929);

// Tree: 311 
final_score_311 := map(
(NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 7.5) => 0.0216028896,
(f_rel_ageover30_count_d > 7.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Child','Father','Grandfather','Grandmother','Grandparent','Neighbor','Relative','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => -0.0225445392,
   (phone_subject_title in ['Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Daughter','Grandchild','Granddaughter','Grandson','Husband','Mother','Parent','Spouse']) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -447.5) => -0.0806013707,
      (f_addrchangeincomediff_d > -447.5) => 0.0970178888,
      (f_addrchangeincomediff_d = NULL) => 0.2434078959, 0.0816187540),
   (phone_subject_title = '') => -0.0153188540, -0.0153188540),
(f_rel_ageover30_count_d = NULL) => -0.0011616170, -0.0011616170);

// Tree: 312 
final_score_312 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 0.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 123.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 78) => 0.0733320873,
      (f_prevaddrmurderindex_i > 78) => -0.0391805378,
      (f_prevaddrmurderindex_i = NULL) => -0.0098294182, -0.0098294182),
   (f_prevaddrageoldest_d > 123.5) => 0.0521053109,
   (f_prevaddrageoldest_d = NULL) => 0.0179036597, 0.0179036597),
(f_rel_homeover200_count_d > 0.5) => -0.0110239574,
(f_rel_homeover200_count_d = NULL) => -0.0020505071, -0.0020505071);

// Tree: 313 
final_score_313 := map(
(pp_app_scc in ['B','C','N','R']) => -0.0038664642,
(pp_app_scc in ['8','A','J','S']) => 
   map(
   (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => -0.0076000305,
   (f_prevaddrstatus_i > 2.5) => 0.0851035141,
   (f_prevaddrstatus_i = NULL) => 
      map(
      (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 30) => 0.1988588625,
      (mth_pp_datevendorfirstseen > 30) => -0.0667904696,
      (mth_pp_datevendorfirstseen = NULL) => 0.1162483994, 0.1162483994), 0.0459409732),
(pp_app_scc = '') => -0.0068100605, -0.0015039649);

// Tree: 314 
final_score_314 := map(
(NULL < f_college_income_d and f_college_income_d <= 10.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Daughter','Father','Grandfather','Mother','Neighbor','Relative','Sister','Son','Spouse','Subject','Wife']) => -0.0398683047,
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Vehicle','Child','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Parent','Sibling','Subject at Household']) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 4.5) => -0.0218087724,
      (inq_firstseen_n > 4.5) => 0.2245842302,
      (inq_firstseen_n = NULL) => 0.1061260559, 0.1061260559),
   (phone_subject_title = '') => -0.0260400593, -0.0260400593),
(f_college_income_d > 10.5) => -0.1484625211,
(f_college_income_d = NULL) => 0.0090076796, 0.0030532344);

// Tree: 315 
final_score_315 := map(
(NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 12.5) => 0.0046638675,
(mth_source_inf_fseen > 12.5) => 
   map(
   (NULL < mth_source_md_fseen and mth_source_md_fseen <= 5.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 0.5) => 0.0508400845,
      (f_srchssnsrchcount_i > 0.5) => -0.0731371625,
      (f_srchssnsrchcount_i = NULL) => -0.0295775892, -0.0295775892),
   (mth_source_md_fseen > 5.5) => -0.1376245173,
   (mth_source_md_fseen = NULL) => -0.0419144392, -0.0419144392),
(mth_source_inf_fseen = NULL) => 0.0015321165, 0.0015321165);

// Tree: 316 
final_score_316 := map(
(NULL < pk_cell_indicator and pk_cell_indicator <= 1.5) => 
   map(
   (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 209.5) => -0.0235653836,
   (mth_source_inf_fseen > 209.5) => 0.1052435607,
   (mth_source_inf_fseen = NULL) => -0.0198531887, -0.0198531887),
(pk_cell_indicator > 1.5) => 
   map(
   (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 2.5) => 0.2676947637,
   (mth_pp_datevendorfirstseen > 2.5) => 0.0301813492,
   (mth_pp_datevendorfirstseen = NULL) => 0.0386251983, 0.0386251983),
(pk_cell_indicator = NULL) => -0.0055956424, -0.0055956424);

// Tree: 317 
final_score_317 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 316765) => 
   map(
   (NULL < mth_source_edahistory_fseen and mth_source_edahistory_fseen <= 1.5) => -0.0091609444,
   (mth_source_edahistory_fseen > 1.5) => -0.1259342254,
   (mth_source_edahistory_fseen = NULL) => -0.0125017520, -0.0125017520),
(f_curraddrmedianvalue_d > 316765) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Brother','Daughter','Grandmother','Grandson','Husband','Neighbor','Parent','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0194529062,
   (phone_subject_title in ['Associate','Associate By Property','Associate By SSN','Child','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Mother','Relative']) => 0.1603365699,
   (phone_subject_title = '') => 0.0397967248, 0.0397967248),
(f_curraddrmedianvalue_d = NULL) => -0.0041156045, -0.0041156045);

// Tree: 318 
final_score_318 := map(
(NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 15.5) => 
   map(
   (NULL < _pp_src_all_uw and _pp_src_all_uw <= 0.5) => -0.0176013825,
   (_pp_src_all_uw > 0.5) => 0.0831883779,
   (_pp_src_all_uw = NULL) => -0.0137207399, -0.0137207399),
(r_mos_since_paw_fseen_d > 15.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 26.5) => 0.0061904959,
   (r_pb_order_freq_d > 26.5) => 0.0945715765,
   (r_pb_order_freq_d = NULL) => 0.0085711477, 0.0378192267),
(r_mos_since_paw_fseen_d = NULL) => -0.0042819570, -0.0042819570);

// Tree: 319 
final_score_319 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 95220) => 
   map(
   (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 7.5) => -0.0060385504,
   (f_rel_incomeover100_count_d > 7.5) => -0.1542827110,
   (f_rel_incomeover100_count_d = NULL) => -0.0077356787, -0.0077356787),
(f_addrchangevaluediff_d > 95220) => 
   map(
   (NULL < pp_app_ind_has_actv_eda_ph_fl and pp_app_ind_has_actv_eda_ph_fl <= 0.5) => 0.0190348584,
   (pp_app_ind_has_actv_eda_ph_fl > 0.5) => 0.1466576550,
   (pp_app_ind_has_actv_eda_ph_fl = NULL) => 0.0355785543, 0.0355785543),
(f_addrchangevaluediff_d = NULL) => 0.0030437530, -0.0004843213);

// Tree: 320 
final_score_320 := map(
(NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 177.5) => 
   map(
   (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 2.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 192.5) => 0.0070340048,
      (f_curraddrcartheftindex_i > 192.5) => 0.0905206172,
      (f_curraddrcartheftindex_i = NULL) => 0.0103338709, 0.0103338709),
   (f_srchunvrfdphonecount_i > 2.5) => -0.1381950996,
   (f_srchunvrfdphonecount_i = NULL) => 0.0078117212, 0.0078117212),
(f_fp_prevaddrburglaryindex_i > 177.5) => -0.0389446821,
(f_fp_prevaddrburglaryindex_i = NULL) => 0.0012868987, 0.0012868987);

// Tree: 321 
final_score_321 := map(
(NULL < pp_app_company_type and pp_app_company_type <= 7.5) => -0.0093909066,
(pp_app_company_type > 7.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 12.5) => 
      map(
      (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 4.5) => 0.0155126672,
      (pp_app_ind_ph_cnt > 4.5) => 0.1833385796,
      (pp_app_ind_ph_cnt = NULL) => 0.0859636518, 0.0859636518),
   (f_rel_under500miles_cnt_d > 12.5) => -0.0316722796,
   (f_rel_under500miles_cnt_d = NULL) => 0.0354969392, 0.0354969392),
(pp_app_company_type = NULL) => -0.0057336254, -0.0057336254);

// Tree: 322 
final_score_322 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 1.5) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 4.5) => 
      map(
      (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 0.0641863449,
      (f_vardobcountnew_i > 0.5) => -0.1537551912,
      (f_vardobcountnew_i = NULL) => 0.0150848921, 0.0150848921),
   (f_rel_homeover200_count_d > 4.5) => 0.1457912082,
   (f_rel_homeover200_count_d = NULL) => 0.0556857641, 0.0556857641),
(f_prevaddrlenofres_d > 1.5) => -0.0036154727,
(f_prevaddrlenofres_d = NULL) => -0.0008395139, -0.0008395139);

// Tree: 323 
final_score_323 := map(
(NULL < inq_num and inq_num <= 0.5) => 
   map(
   (NULL < mth_source_md_fseen and mth_source_md_fseen <= 21.5) => -0.0076136607,
   (mth_source_md_fseen > 21.5) => 0.1454180193,
   (mth_source_md_fseen = NULL) => -0.0046008024, -0.0046008024),
(inq_num > 0.5) => 
   map(
   (pp_glb_dppa_fl in ['U']) => 0.0029398131,
   (pp_glb_dppa_fl in ['B','D','G']) => 0.0172638765,
   (pp_glb_dppa_fl = '') => 0.1072439999, 0.0381816141),
(inq_num = NULL) => 0.0005112619, 0.0005112619);

// Tree: 324 
final_score_324 := map(
(pp_type in ['M','U']) => 
   map(
   (NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 1.5) => 0.0770009047,
   (mth_pp_first_build_date > 1.5) => -0.0072389258,
   (mth_pp_first_build_date = NULL) => -0.0005092178, -0.0005092178),
(pp_type in ['B','R']) => 0.1403945936,
(pp_type = '') => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 42.5) => -0.0105654541,
   (inq_adl_firstseen_n > 42.5) => 0.1513965858,
   (inq_adl_firstseen_n = NULL) => -0.0077648529, -0.0077648529), -0.0033234679);

// Tree: 325 
final_score_325 := map(
(NULL < inq_num and inq_num <= 2.5) => 0.0011565428,
(inq_num > 2.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 76.5) => 0.1000028920,
      (f_curraddrcrimeindex_i > 76.5) => -0.0510088784,
      (f_curraddrcrimeindex_i = NULL) => 0.0095573397, 0.0095573397),
   (f_rel_felony_count_i > 0.5) => 0.1198405150,
   (f_rel_felony_count_i = NULL) => 0.0579097229, 0.0579097229),
(inq_num = NULL) => 0.0034966627, 0.0034966627);

// Tree: 326 
final_score_326 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 0.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.37790218779385) => 0.0090824885,
   (f_add_input_mobility_index_n > 0.37790218779385) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 74) => 0.0384015819,
      (f_mos_inq_banko_cm_fseen_d > 74) => 0.2526829357,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.1332163402, 0.1332163402),
   (f_add_input_mobility_index_n = NULL) => 0.0861546052, 0.0861546052),
(f_rel_under100miles_cnt_d > 0.5) => -0.0005941049,
(f_rel_under100miles_cnt_d = NULL) => 0.0013999944, 0.0013999944);

// Tree: 327 
final_score_327 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 50.5) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 47.5) => 0.0057902583,
   (inq_adl_firstseen_n > 47.5) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 0.5) => 0.2092107843,
      (f_rel_homeover300_count_d > 0.5) => -0.0045629610,
      (f_rel_homeover300_count_d = NULL) => 0.0968889859, 0.0968889859),
   (inq_adl_firstseen_n = NULL) => 0.0071557638, 0.0071557638),
(inq_adl_lastseen_n > 50.5) => -0.0953286802,
(inq_adl_lastseen_n = NULL) => 0.0054172338, 0.0054172338);

// Tree: 328 
final_score_328 := map(
(NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 6.5) => 0.0043322400,
(f_rel_incomeover75_count_d > 6.5) => 
   map(
   (NULL < mth_pp_datevendorlastseen and mth_pp_datevendorlastseen <= 6.5) => 
      map(
      (phone_subject_title in ['Associate By Business','Associate By SSN','Daughter','Father','Grandfather','Grandmother','Mother','Parent','Son','Spouse','Wife']) => -0.1859233709,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Neighbor','Relative','Sibling','Sister','Subject','Subject at Household']) => 0.0060030830,
      (phone_subject_title = '') => -0.0100332123, -0.0100332123),
   (mth_pp_datevendorlastseen > 6.5) => -0.1161705437,
   (mth_pp_datevendorlastseen = NULL) => -0.0283247172, -0.0283247172),
(f_rel_incomeover75_count_d = NULL) => 0.0006365272, 0.0006365272);

// Tree: 329 
final_score_329 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 3.5) => 
   map(
   (NULL < mth_source_rm_fseen and mth_source_rm_fseen <= 8.5) => -0.0195762879,
   (mth_source_rm_fseen > 8.5) => 0.0836121724,
   (mth_source_rm_fseen = NULL) => -0.0119753522, -0.0119753522),
(f_rel_homeover200_count_d > 3.5) => 
   map(
   (phone_subject_title in ['Associate By Vehicle','Child','Daughter','Husband','Parent','Wife']) => -0.1456890594,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Neighbor','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household']) => 0.0172497085,
   (phone_subject_title = '') => 0.0132361816, 0.0132361816),
(f_rel_homeover200_count_d = NULL) => -0.0021899965, -0.0021899965);

// Tree: 330 
final_score_330 := map(
(NULL < f_college_income_d and f_college_income_d <= 10.5) => 
   map(
   (NULL < _phone_timezone_match and _phone_timezone_match <= 0.5) => -0.1800109589,
   (_phone_timezone_match > 0.5) => 
      map(
      (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 19) => 0.0237312837,
      (mth_source_inf_fseen > 19) => -0.1344688649,
      (mth_source_inf_fseen = NULL) => 0.0132360543, 0.0132360543),
   (_phone_timezone_match = NULL) => -0.0022028902, -0.0022028902),
(f_college_income_d > 10.5) => -0.1389158067,
(f_college_income_d = NULL) => -0.0021818392, -0.0033529753);

// Tree: 331 
final_score_331 := map(
(NULL < number_of_sources and number_of_sources <= 1.5) => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => 
      map(
      (NULL < pk_cell_indicator and pk_cell_indicator <= 3.5) => -0.0883218318,
      (pk_cell_indicator > 3.5) => 0.1131906118,
      (pk_cell_indicator = NULL) => -0.0766171954, -0.0766171954),
   (source_rel > 0.5) => 0.1896052650,
   (source_rel = NULL) => -0.0625514331, -0.0625514331),
(number_of_sources > 1.5) => 0.1276049437,
(number_of_sources = NULL) => -0.0127754821, -0.0127754821);

// Tree: 332 
final_score_332 := map(
(NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 26.5) => -0.0048404147,
(mth_source_ppla_fseen > 26.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 3.5) => 0.1684960841,
   (f_corrssnaddrcount_d > 3.5) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 71) => 0.1272997610,
      (mth_pp_app_npa_last_change_dt > 71) => -0.0187814444,
      (mth_pp_app_npa_last_change_dt = NULL) => 0.0235609340, 0.0235609340),
   (f_corrssnaddrcount_d = NULL) => 0.0526598831, 0.0526598831),
(mth_source_ppla_fseen = NULL) => -0.0029963610, -0.0029963610);

// Tree: 333 
final_score_333 := map(
(NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 1.5) => -0.0052446311,
(f_divaddrsuspidcountnew_i > 1.5) => 
   map(
   (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 2.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 66.5) => 0.2123840639,
      (f_mos_inq_banko_cm_fseen_d > 66.5) => -0.0211819487,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0457131714, 0.0457131714),
   (f_addrchangeecontrajindex_d > 2.5) => 0.1913945855,
   (f_addrchangeecontrajindex_d = NULL) => 0.0798318669, 0.0798318669),
(f_divaddrsuspidcountnew_i = NULL) => -0.0024105038, -0.0024105038);

// Tree: 334 
final_score_334 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.94235248784614) => 0.0012389735,
(f_add_input_mobility_index_n > 0.94235248784614) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 61) => -0.0848403818,
   (f_curraddrcrimeindex_i > 61) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 31.5) => 0.0037818343,
      (r_pb_order_freq_d > 31.5) => 0.2428453521,
      (r_pb_order_freq_d = NULL) => 0.1151563168, 0.1086313484),
   (f_curraddrcrimeindex_i = NULL) => 0.0571947555, 0.0571947555),
(f_add_input_mobility_index_n = NULL) => -0.0928256491, 0.0027403318);

// Tree: 335 
final_score_335 := map(
(NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 6.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By SSN','Brother','Daughter','Grandmother','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Spouse','Subject','Subject at Household','Wife']) => 0.0115050527,
   (phone_subject_title in ['Associate By Shared Associates','Associate By Vehicle','Child','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Sister','Son']) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 129) => 0.2463527507,
      (f_curraddrburglaryindex_i > 129) => -0.0044102909,
      (f_curraddrburglaryindex_i = NULL) => 0.1386953193, 0.1386953193),
   (phone_subject_title = '') => 0.0209503641, 0.0209503641),
(f_rel_ageover30_count_d > 6.5) => -0.0120792753,
(f_rel_ageover30_count_d = NULL) => -0.0015170183, -0.0015170183);

// Tree: 336 
final_score_336 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 17.5) => 
   map(
   (NULL < internal_verification and internal_verification <= 0.5) => -0.0029700201,
   (internal_verification > 0.5) => 
      map(
      (NULL < inq_num_addresses and inq_num_addresses <= 1.5) => 0.0596905114,
      (inq_num_addresses > 1.5) => -0.0302289738,
      (inq_num_addresses = NULL) => 0.0358130506, 0.0358130506),
   (internal_verification = NULL) => 0.0076965888, 0.0076965888),
(mth_source_ppdid_lseen > 17.5) => -0.0338220982,
(mth_source_ppdid_lseen = NULL) => 0.0016559180, 0.0016559180);

// Tree: 337 
final_score_337 := map(
(pp_src in ['CY','E1','E2','EM','EN','KW','NW','PL','SL','TN','UT','ZT']) => -0.0083303923,
(pp_src in ['EQ','FA','FF','LA','LP','MD','UW','VO','VW','ZK']) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 178.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 0.5) => -0.0369878869,
      (f_corraddrnamecount_d > 0.5) => 0.0956730238,
      (f_corraddrnamecount_d = NULL) => 0.0604391401, 0.0604391401),
   (f_fp_prevaddrburglaryindex_i > 178.5) => -0.1395452426,
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.0405131599, 0.0405131599),
(pp_src = '') => 0.0008161287, 0.0023504567);

// Tree: 338 
final_score_338 := map(
(NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 189.5) => 
   map(
   (NULL < _pp_app_nonpub_gong_la and _pp_app_nonpub_gong_la <= 0.5) => 0.0018776662,
   (_pp_app_nonpub_gong_la > 0.5) => 0.1257157236,
   (_pp_app_nonpub_gong_la = NULL) => 0.0029334734, 0.0029334734),
(f_fp_prevaddrburglaryindex_i > 189.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.320052929462315) => -0.1317552320,
   (f_add_input_mobility_index_n > 0.320052929462315) => -0.0274345757,
   (f_add_input_mobility_index_n = NULL) => -0.0642945409, -0.0642945409),
(f_fp_prevaddrburglaryindex_i = NULL) => -0.0008213049, -0.0008213049);

// Tree: 339 
final_score_339 := map(
(NULL < source_sx and source_sx <= 0.5) => -0.0081081539,
(source_sx > 0.5) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 27105) => 0.2256297857,
   (f_prevaddrmedianincome_d > 27105) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Father','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Relative','Subject']) => -0.0122070213,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandparent','Parent','Sibling','Sister','Son','Spouse','Subject at Household','Wife']) => 0.1297375684,
      (phone_subject_title = '') => 0.0076075788, 0.0076075788),
   (f_prevaddrmedianincome_d = NULL) => 0.0355838797, 0.0355838797),
(source_sx = NULL) => -0.0056627850, -0.0056627850);

// Tree: 340 
final_score_340 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 27.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 17.5) => -0.0046023723,
   (f_rel_homeover300_count_d > 17.5) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 122) => 0.0072945788,
      (mth_pp_app_npa_effective_dt > 122) => 0.1666942863,
      (mth_pp_app_npa_effective_dt = NULL) => 0.0521257466, 0.0521257466),
   (f_rel_homeover300_count_d = NULL) => -0.0032325070, -0.0032325070),
(f_inq_count24_i > 27.5) => -0.1553510852,
(f_inq_count24_i = NULL) => -0.0050595875, -0.0050595875);

// Tree: 341 
final_score_341 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 4.5) => -0.0030476835,
(mth_exp_last_update > 4.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 2.5) => 
      map(
      (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Brother','Father','Grandfather','Grandparent','Husband','Mother','Neighbor','Parent','Subject','Subject at Household','Wife']) => 0.0285790180,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By SSN','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandmother','Grandson','Relative','Sibling','Sister','Son','Spouse']) => 0.1797494764,
      (phone_subject_title = '') => 0.0500231421, 0.0500231421),
   (f_srchssnsrchcount_i > 2.5) => -0.0141823748,
   (f_srchssnsrchcount_i = NULL) => 0.0231964707, 0.0231964707),
(mth_exp_last_update = NULL) => 0.0009266355, 0.0009266355);

// Tree: 342 
final_score_342 := map(
(NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 179.5) => 0.0089905699,
(f_fp_prevaddrburglaryindex_i > 179.5) => 
   map(
   (NULL < _phone_zip_match and _phone_zip_match <= 0.5) => -0.0696470091,
   (_phone_zip_match > 0.5) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 184.5) => -0.0433881077,
      (f_prevaddrcartheftindex_i > 184.5) => 0.1309309103,
      (f_prevaddrcartheftindex_i = NULL) => 0.0225345666, 0.0225345666),
   (_phone_zip_match = NULL) => -0.0329606042, -0.0329606042),
(f_fp_prevaddrburglaryindex_i = NULL) => 0.0038479668, 0.0038479668);

// Tree: 343 
final_score_343 := map(
(NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 11.5) => 
   map(
   (pp_src in ['CY','E1','E2','EN','EQ','FA','LP','PL','SL','TN','UT','VW','ZT']) => -0.0148724568,
   (pp_src in ['EM','FF','KW','LA','MD','NW','UW','VO','ZK']) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 5.5) => 0.0013339166,
      (f_srchaddrsrchcount_i > 5.5) => 0.1845513139,
      (f_srchaddrsrchcount_i = NULL) => 0.0636401695, 0.0636401695),
   (pp_src = '') => 0.0066114853, 0.0061986735),
(mth_pp_first_build_date > 11.5) => -0.0440648011,
(mth_pp_first_build_date = NULL) => -0.0004608012, -0.0004608012);

// Tree: 344 
final_score_344 := map(
(pp_origphoneusage in ['H','O','S']) => -0.0804554569,
(pp_origphoneusage in ['M','P']) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 66.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 68.5) => 0.0585602310,
      (f_mos_inq_banko_cm_fseen_d > 68.5) => -0.0819483333,
      (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0335109080, -0.0335109080),
   (r_pb_order_freq_d > 66.5) => 0.0797651264,
   (r_pb_order_freq_d = NULL) => -0.0021786496, 0.0087735748),
(pp_origphoneusage = '') => -0.0073183826, -0.0076824408);

// Tree: 345 
final_score_345 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -4.5) => -0.0214633919,
(f_addrchangecrimediff_i > -4.5) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 133606.5) => 0.0147607551,
   (f_prevaddrmedianincome_d > 133606.5) => -0.1608190007,
   (f_prevaddrmedianincome_d = NULL) => 0.0120749220, 0.0120749220),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By SSN','Brother','Child','Daughter','Father','Grandfather','Husband','Spouse','Wife']) => -0.0842311220,
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Subject','Subject at Household']) => 0.0143713717,
   (phone_subject_title = '') => 0.0009633899, 0.0009633899), -0.0020222448);

// Tree: 346 
final_score_346 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 18.5) => 
   map(
   (NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 40.5) => 0.0082904457,
   (mth_source_ppla_lseen > 40.5) => -0.1213784247,
   (mth_source_ppla_lseen = NULL) => 0.0069808454, 0.0069808454),
(mth_source_ppdid_lseen > 18.5) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 152.5) => -0.0450179579,
   (mth_pp_app_npa_last_change_dt > 152.5) => 0.1391373591,
   (mth_pp_app_npa_last_change_dt = NULL) => -0.0339263852, -0.0339263852),
(mth_source_ppdid_lseen = NULL) => 0.0016825587, 0.0016825587);

// Tree: 347 
final_score_347 := map(
(NULL < _inq_adl_ph_industry_auto and _inq_adl_ph_industry_auto <= 0.5) => 
   map(
   (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0145182458,
   (_phone_match_code_n > 0.5) => 
      map(
      (phone_subject_title in ['Associate','Grandfather','Grandmother','Sibling','Subject','Subject at Household','Wife']) => 0.0090887520,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sister','Son','Spouse']) => 0.2559956553,
      (phone_subject_title = '') => 0.0162551103, 0.0162551103),
   (_phone_match_code_n = NULL) => -0.0016658893, -0.0016658893),
(_inq_adl_ph_industry_auto > 0.5) => 0.1281950337,
(_inq_adl_ph_industry_auto = NULL) => -0.0004759799, -0.0004759799);

// Tree: 348 
final_score_348 := map(
(NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 53.5) => -0.0024436021,
(mth_source_ppfla_fseen > 53.5) => 
   map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 5.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 1.5) => 0.0414031822,
      (f_rel_criminal_count_i > 1.5) => 0.2546547052,
      (f_rel_criminal_count_i = NULL) => 0.1422129931, 0.1422129931),
   (f_rel_incomeover50_count_d > 5.5) => -0.0303904875,
   (f_rel_incomeover50_count_d = NULL) => 0.0604534496, 0.0604534496),
(mth_source_ppfla_fseen = NULL) => -0.0008080918, -0.0008080918);

// Tree: 349 
final_score_349 := map(
(NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 25.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 15.5) => 
      map(
      (NULL < f_adl_util_conv_n and f_adl_util_conv_n <= 0.5) => -0.0016018243,
      (f_adl_util_conv_n > 0.5) => 0.0426104995,
      (f_adl_util_conv_n = NULL) => 0.0259231923, 0.0259231923),
   (mth_source_ppdid_lseen > 15.5) => -0.0146052158,
   (mth_source_ppdid_lseen = NULL) => 0.0170157663, 0.0170157663),
(mth_eda_dt_first_seen > 25.5) => -0.0248022663,
(mth_eda_dt_first_seen = NULL) => 0.0027864506, 0.0027864506);

// Tree: 350 
final_score_350 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 231292) => 0.0007133614,
(f_addrchangevaluediff_d > 231292) => -0.0688231906,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 16.5) => -0.0013774198,
   (f_rel_homeover200_count_d > 16.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.39821862457055) => -0.0503693432,
      (f_add_input_mobility_index_n > 0.39821862457055) => 0.2479236707,
      (f_add_input_mobility_index_n = NULL) => 0.0921777608, 0.0921777608),
   (f_rel_homeover200_count_d = NULL) => 0.0038660859, 0.0038660859), -0.0005629926);

// Tree: 351 
final_score_351 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.75235979876698) => 
   map(
   (NULL < f_inq_addrs_per_ssn_i and f_inq_addrs_per_ssn_i <= 0.5) => 0.0126882803,
   (f_inq_addrs_per_ssn_i > 0.5) => -0.0202084946,
   (f_inq_addrs_per_ssn_i = NULL) => 0.0043176107, 0.0043176107),
(f_add_curr_mobility_index_n > 0.75235979876698) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 18151) => -0.0191670774,
   (f_addrchangeincomediff_d > 18151) => -0.1804519385,
   (f_addrchangeincomediff_d = NULL) => -0.0602925641, -0.0618076925),
(f_add_curr_mobility_index_n = NULL) => -0.0373434840, 0.0009179039);

// Tree: 352 
final_score_352 := map(
(NULL < eda_num_interrupts_cur and eda_num_interrupts_cur <= 17.5) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 26.5) => 0.0005217478,
   (f_rel_homeover200_count_d > 26.5) => -0.0962511949,
   (f_rel_homeover200_count_d = NULL) => -0.0011467512, -0.0011467512),
(eda_num_interrupts_cur > 17.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Daughter','Father','Husband','Mother','Neighbor','Spouse','Wife']) => -0.0285417533,
   (phone_subject_title in ['Associate','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Parent','Relative','Sibling','Sister','Son','Subject','Subject at Household']) => 0.1889528494,
   (phone_subject_title = '') => 0.0795300990, 0.0795300990),
(eda_num_interrupts_cur = NULL) => 0.0004615912, 0.0004615912);

// Tree: 353 
final_score_353 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -30242) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 52.5) => 
      map(
      (NULL < _pp_src_all_iq and _pp_src_all_iq <= 0.5) => -0.0141960643,
      (_pp_src_all_iq > 0.5) => 0.1437070806,
      (_pp_src_all_iq = NULL) => 0.0093715693, 0.0093715693),
   (r_pb_order_freq_d > 52.5) => -0.0406677767,
   (r_pb_order_freq_d = NULL) => -0.0662196340, -0.0313708510),
(f_addrchangevaluediff_d > -30242) => 0.0025115645,
(f_addrchangevaluediff_d = NULL) => 0.0165231955, -0.0013897007);

// Tree: 354 
final_score_354 := map(
(NULL < f_wealth_index_d and f_wealth_index_d <= 4.5) => -0.0027262355,
(f_wealth_index_d > 4.5) => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 4861.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.213208033684365) => -0.0251424448,
      (f_add_input_mobility_index_n > 0.213208033684365) => 0.1030039392,
      (f_add_input_mobility_index_n = NULL) => 0.0812578861, 0.0812578861),
   (eda_days_ph_first_seen > 4861.5) => -0.0927018895,
   (eda_days_ph_first_seen = NULL) => 0.0595984121, 0.0595984121),
(f_wealth_index_d = NULL) => 0.0031627684, 0.0031627684);

// Tree: 355 
final_score_355 := map(
(NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 27.5) => 0.0007274120,
(f_rel_ageover20_count_d > 27.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 1662) => 
      map(
      (pp_source in ['CELL','HEADER','INFUTOR','OTHER','THRIVE']) => -0.1425449731,
      (pp_source in ['GONG','IBEHAVIOR','INQUIRY','INTRADO','PCNSR','TARGUS']) => 0.1258594851,
      (pp_source = '') => -0.0010567198, 0.0024661850),
   (f_addrchangeincomediff_d > 1662) => -0.1178807225,
   (f_addrchangeincomediff_d = NULL) => 0.0015437371, -0.0370946138),
(f_rel_ageover20_count_d = NULL) => -0.0025520631, -0.0025520631);

// Tree: 356 
final_score_356 := map(
(NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0064973375,
(_pp_rule_high_vend_conf > 0.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 89981.5) => 
      map(
      (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 0.5) => -0.0356602257,
      (mth_source_ppdid_lseen > 0.5) => 0.0529014903,
      (mth_source_ppdid_lseen = NULL) => 0.0129033417, 0.0129033417),
   (f_curraddrmedianincome_d > 89981.5) => 0.1491936829,
   (f_curraddrmedianincome_d = NULL) => 0.0273862170, 0.0273862170),
(_pp_rule_high_vend_conf = NULL) => -0.0012067033, -0.0012067033);

// Tree: 357 
final_score_357 := map(
(NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 197.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 177.5) => -0.0035078638,
   (f_curraddrcrimeindex_i > 177.5) => 
      map(
      (phone_subject_title in ['Associate By SSN','Child','Daughter','Father','Neighbor','Parent','Sibling','Sister','Son','Subject','Subject at Household']) => 0.0021780151,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Relative','Spouse','Wife']) => 0.1100535400,
      (phone_subject_title = '') => 0.0447021035, 0.0447021035),
   (f_curraddrcrimeindex_i = NULL) => 0.0015008854, 0.0015008854),
(f_curraddrmurderindex_i > 197.5) => -0.1072733446,
(f_curraddrmurderindex_i = NULL) => -0.0000482213, -0.0000482213);

// Tree: 358 
final_score_358 := map(
(NULL < pp_src_cnt and pp_src_cnt <= 1.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 26.5) => 
      map(
      (NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 4.5) => -0.0196791832,
      (f_componentcharrisktype_i > 4.5) => 0.0171972434,
      (f_componentcharrisktype_i = NULL) => -0.0037862215, -0.0037862215),
   (mth_source_ppdid_lseen > 26.5) => -0.0682519023,
   (mth_source_ppdid_lseen = NULL) => -0.0088442310, -0.0088442310),
(pp_src_cnt > 1.5) => 0.0396864322,
(pp_src_cnt = NULL) => -0.0048120276, -0.0048120276);

// Tree: 359 
final_score_359 := map(
(NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 2.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 38) => 
      map(
      (phone_subject_title in ['Daughter','Father','Grandfather','Husband','Mother','Neighbor','Parent','Sibling','Sister','Son','Spouse','Wife']) => -0.1237115110,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Relative','Subject','Subject at Household']) => 0.1663226091,
      (phone_subject_title = '') => 0.0964776578, 0.0964776578),
   (r_pb_order_freq_d > 38) => -0.0178975473,
   (r_pb_order_freq_d = NULL) => 0.0082755806, 0.0306224500),
(f_componentcharrisktype_i > 2.5) => -0.0035032506,
(f_componentcharrisktype_i = NULL) => -0.0006886727, -0.0006886727);

// Tree: 360 
final_score_360 := map(
(NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 50) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 7.5) => 
      map(
      (NULL < number_of_sources and number_of_sources <= 2.5) => -0.0320974480,
      (number_of_sources > 2.5) => -0.1214928850,
      (number_of_sources = NULL) => -0.0425539159, -0.0425539159),
   (f_corrssnnamecount_d > 7.5) => 0.0233151286,
   (f_corrssnnamecount_d = NULL) => -0.0207670214, -0.0207670214),
(f_prevaddrmurderindex_i > 50) => 0.0084262286,
(f_prevaddrmurderindex_i = NULL) => 0.0018689533, 0.0018689533);

// Tree: 361 
final_score_361 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 5.5) => -0.0180814872,
(f_rel_under25miles_cnt_d > 5.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 11.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Father','Grandfather','Grandmother','Neighbor','Relative','Son','Spouse','Wife']) => -0.0684011445,
      (phone_subject_title in ['Associate By Address','Associate By Property','Child','Daughter','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Mother','Parent','Sibling','Sister','Subject','Subject at Household']) => 0.1335677199,
      (phone_subject_title = '') => 0.0632880137, 0.0632880137),
   (f_fp_prevaddrburglaryindex_i > 11.5) => 0.0009784122,
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.0047255967, 0.0047255967),
(f_rel_under25miles_cnt_d = NULL) => -0.0041383165, -0.0041383165);

// Tree: 362 
final_score_362 := map(
(NULL < mth_source_ppfla_lseen and mth_source_ppfla_lseen <= 4.5) => 0.0050589225,
(mth_source_ppfla_lseen > 4.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 2.5) => 0.0790042078,
   (f_rel_under25miles_cnt_d > 2.5) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 166.5) => -0.0957312124,
      (mth_pp_app_npa_effective_dt > 166.5) => -0.0041616350,
      (mth_pp_app_npa_effective_dt = NULL) => -0.0509593615, -0.0509593615),
   (f_rel_under25miles_cnt_d = NULL) => -0.0322524841, -0.0322524841),
(mth_source_ppfla_lseen = NULL) => 0.0026010636, 0.0026010636);

// Tree: 363 
final_score_363 := map(
(NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0406325010,
(_phone_match_code_n > 0.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 0.0712811477,
   (f_srchvelocityrisktype_i > 5.5) => 
      map(
      (phone_subject_title in ['Daughter','Mother','Relative','Sister','Subject','Wife']) => -0.0387008955,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Sibling','Son','Spouse','Subject at Household']) => 0.1572679850,
      (phone_subject_title = '') => -0.0217015131, -0.0217015131),
   (f_srchvelocityrisktype_i = NULL) => 0.0317216514, 0.0317216514),
(_phone_match_code_n = NULL) => -0.0102878361, -0.0102878361);

// Tree: 364 
final_score_364 := map(
(NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 6.5) => -0.0053388533,
(f_crim_rel_under500miles_cnt_i > 6.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 1311) => 
      map(
      (pp_source in ['CELL','HEADER','INFUTOR','OTHER','PCNSR','THRIVE']) => -0.0039139616,
      (pp_source in ['GONG','IBEHAVIOR','INQUIRY','INTRADO','TARGUS']) => 0.2056197053,
      (pp_source = '') => 0.0127114010, 0.0541846581),
   (f_addrchangeincomediff_d > 1311) => -0.0259332815,
   (f_addrchangeincomediff_d = NULL) => 0.0611759607, 0.0251360729),
(f_crim_rel_under500miles_cnt_i = NULL) => -0.0012200061, -0.0012200061);

// Tree: 365 
final_score_365 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 18.5) => 
   map(
   (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 12.5) => -0.0036036736,
   (pp_app_ind_ph_cnt > 12.5) => -0.1415997070,
   (pp_app_ind_ph_cnt = NULL) => -0.0055038943, -0.0055038943),
(f_rel_under100miles_cnt_d > 18.5) => 
   map(
   (NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => 0.0219446106,
   (_inq_adl_ph_industry_flag > 0.5) => 0.1498113658,
   (_inq_adl_ph_industry_flag = NULL) => 0.0274992047, 0.0274992047),
(f_rel_under100miles_cnt_d = NULL) => -0.0007850662, -0.0007850662);

// Tree: 366 
final_score_366 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Father','Grandfather','Grandparent','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household']) => -0.0078579679,
(phone_subject_title in ['Associate By Property','Associate By SSN','Grandchild','Granddaughter','Grandmother','Mother','Wife']) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 5.5) => 
      map(
      (NULL < _phone_zip_match and _phone_zip_match <= 0.5) => -0.1006454891,
      (_phone_zip_match > 0.5) => 0.1460909204,
      (_phone_zip_match = NULL) => 0.0256254969, 0.0256254969),
   (f_rel_homeover200_count_d > 5.5) => 0.2281145333,
   (f_rel_homeover200_count_d = NULL) => 0.0858701689, 0.0858701689),
(phone_subject_title = '') => -0.0050493734, -0.0050493734);

// Tree: 367 
final_score_367 := map(
(exp_source in ['P']) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.44573823009004) => -0.0723752154,
   (f_add_curr_mobility_index_n > 0.44573823009004) => 0.0633580988,
   (f_add_curr_mobility_index_n = NULL) => -0.0399301907, -0.0399301907),
(exp_source in ['S']) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 1.5) => -0.0043162746,
   (f_rel_homeover300_count_d > 1.5) => 0.0571176666,
   (f_rel_homeover300_count_d = NULL) => 0.0197744150, 0.0197744150),
(exp_source = '') => -0.0035338749, -0.0023010979);

// Tree: 368 
final_score_368 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 3.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Father','Grandmother','Grandson','Husband','Neighbor','Parent','Sibling','Sister','Wife']) => -0.0142045486,
   (phone_subject_title in ['Brother','Daughter','Grandchild','Granddaughter','Grandfather','Grandparent','Mother','Relative','Son','Spouse','Subject','Subject at Household']) => 
      map(
      (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 9.5) => 0.0441505886,
      (f_rel_homeover200_count_d > 9.5) => 0.1911290515,
      (f_rel_homeover200_count_d = NULL) => 0.0603947546, 0.0603947546),
   (phone_subject_title = '') => 0.0218352375, 0.0218352375),
(f_inq_count_i > 3.5) => -0.0095891939,
(f_inq_count_i = NULL) => -0.0019860068, -0.0019860068);

// Tree: 369 
final_score_369 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 274.5) => 0.0072220456,
(f_prevaddrageoldest_d > 274.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 330.5) => -0.0742865428,
   (f_prevaddrlenofres_d > 330.5) => 
      map(
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Husband','Mother','Neighbor','Sibling','Sister','Son','Subject']) => -0.0419852894,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Vehicle','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Parent','Relative','Spouse','Subject at Household','Wife']) => 0.0834664581,
      (phone_subject_title = '') => -0.0059836842, -0.0059836842),
   (f_prevaddrlenofres_d = NULL) => -0.0455307854, -0.0455307854),
(f_prevaddrageoldest_d = NULL) => 0.0001935604, 0.0001935604);

// Tree: 370 
final_score_370 := map(
(NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 73.5) => -0.0038124162,
   (mth_exp_last_update > 73.5) => -0.1361532741,
   (mth_exp_last_update = NULL) => -0.0061297344, -0.0061297344),
(_inq_adl_ph_industry_flag > 0.5) => 
   map(
   (NULL < inq_lastseen_n and inq_lastseen_n <= 7.5) => 0.1589539473,
   (inq_lastseen_n > 7.5) => -0.0248219945,
   (inq_lastseen_n = NULL) => 0.0889440647, 0.0889440647),
(_inq_adl_ph_industry_flag = NULL) => -0.0031630928, -0.0031630928);

// Tree: 371 
final_score_371 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 279865) => 0.0046276469,
(f_prevaddrmedianvalue_d > 279865) => 
   map(
   (phone_subject_title in ['Associate By Business','Daughter','Subject at Household']) => -0.1184024323,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => 
      map(
      (NULL < pp_app_ind_has_actv_eda_ph_fl and pp_app_ind_has_actv_eda_ph_fl <= 0.5) => -0.0308291775,
      (pp_app_ind_has_actv_eda_ph_fl > 0.5) => 0.0676664343,
      (pp_app_ind_has_actv_eda_ph_fl = NULL) => -0.0162217774, -0.0162217774),
   (phone_subject_title = '') => -0.0247533661, -0.0247533661),
(f_prevaddrmedianvalue_d = NULL) => -0.0009931636, -0.0009931636);

// Tree: 372 
final_score_372 := map(
(exp_type in ['N']) => 0.1617635915,
(exp_type in ['C']) => 0.2768958105,
(exp_type = '') => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Granddaughter','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Wife']) => -0.1313528027,
      (phone_subject_title in ['Associate','Daughter','Father','Grandchild','Grandfather','Grandmother','Grandparent','Mother','Subject','Subject at Household']) => -0.0100966859,
      (phone_subject_title = '') => -0.0751417487, -0.0751417487),
   (source_rel > 0.5) => 0.3892588259,
   (source_rel = NULL) => -0.0533797051, -0.0533797051), 0.0007442295);

// Tree: 373 
final_score_373 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 4.5) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 15.5) => -0.0108952980,
   (mth_exp_last_update > 15.5) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 4.5) => -0.1204316006,
      (f_rel_ageover40_count_d > 4.5) => -0.0068795297,
      (f_rel_ageover40_count_d = NULL) => -0.0786845157, -0.0786845157),
   (mth_exp_last_update = NULL) => -0.0163287850, -0.0163287850),
(f_corraddrnamecount_d > 4.5) => 0.0154632520,
(f_corraddrnamecount_d = NULL) => 0.0020551691, 0.0020551691);

// Tree: 374 
final_score_374 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0073187224,
(source_utildid > 0.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 25.5) => 
      map(
      (NULL < inq_lastseen_n and inq_lastseen_n <= 5.5) => 0.1625370094,
      (inq_lastseen_n > 5.5) => 0.0059071591,
      (inq_lastseen_n = NULL) => 0.0865254644, 0.0865254644),
   (mth_source_utildid_fseen > 25.5) => 0.0020701789,
   (mth_source_utildid_fseen = NULL) => 0.0322962810, 0.0322962810),
(source_utildid = NULL) => -0.0035907132, -0.0035907132);

// Tree: 375 
final_score_375 := map(
(NULL < _pp_rule_iq_rpc and _pp_rule_iq_rpc <= 0.5) => 0.0059666252,
(_pp_rule_iq_rpc > 0.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 103.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 62) => -0.1183700645,
      (f_prevaddrmurderindex_i > 62) => 0.0759840717,
      (f_prevaddrmurderindex_i = NULL) => 0.0146699692, 0.0146699692),
   (f_curraddrcartheftindex_i > 103.5) => -0.1069488693,
   (f_curraddrcartheftindex_i = NULL) => -0.0536017025, -0.0536017025),
(_pp_rule_iq_rpc = NULL) => 0.0031416290, 0.0031416290);

// Tree: 376 
final_score_376 := map(
(NULL < _pp_rule_targ_non_pub and _pp_rule_targ_non_pub <= 0.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 147) => 
      map(
      (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 65.5) => -0.0005932397,
      (mth_source_ppdid_lseen > 65.5) => -0.1089541672,
      (mth_source_ppdid_lseen = NULL) => -0.0035307347, -0.0035307347),
   (mth_source_ppdid_fseen > 147) => 0.1423381228,
   (mth_source_ppdid_fseen = NULL) => -0.0025127068, -0.0025127068),
(_pp_rule_targ_non_pub > 0.5) => 0.1732177042,
(_pp_rule_targ_non_pub = NULL) => -0.0013812084, -0.0013812084);

// Tree: 377 
final_score_377 := map(
(NULL < _pp_rule_ins_ver_above and _pp_rule_ins_ver_above <= 0.5) => 0.0017363412,
(_pp_rule_ins_ver_above > 0.5) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 9.5) => -0.0475393437,
   (f_rel_count_i > 9.5) => 
      map(
      (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.1547001674,
      (f_prevaddrstatus_i > 2.5) => -0.0461650754,
      (f_prevaddrstatus_i = NULL) => 0.1257038279, 0.0965231737),
   (f_rel_count_i = NULL) => 0.0588049873, 0.0588049873),
(_pp_rule_ins_ver_above = NULL) => 0.0036796149, 0.0036796149);

// Tree: 378 
final_score_378 := map(
(exp_source in ['P']) => -0.0327319624,
(exp_source in ['S']) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 22.5) => -0.0732410668,
   (f_mos_inq_banko_cm_lseen_d > 22.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 2.5) => 0.0723553025,
      (f_util_adl_count_n > 2.5) => -0.0020555146,
      (f_util_adl_count_n = NULL) => 0.0349922439, 0.0349922439),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0160703364, 0.0160703364),
(exp_source = '') => 0.0002430890, 0.0005456177);

// Tree: 379 
final_score_379 := map(
(NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 26.5) => 
   map(
   (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 2.5) => -0.0663944979,
   (f_crim_rel_under100miles_cnt_i > 2.5) => 
      map(
      (NULL < f_estimated_income_d and f_estimated_income_d <= 84500) => -0.0290875343,
      (f_estimated_income_d > 84500) => 0.1284862252,
      (f_estimated_income_d = NULL) => 0.0129659128, 0.0129659128),
   (f_crim_rel_under100miles_cnt_i = NULL) => -0.0406582229, -0.0406582229),
(f_curraddrmurderindex_i > 26.5) => 0.0038353414,
(f_curraddrmurderindex_i = NULL) => -0.0014708260, -0.0014708260);

// Tree: 380 
final_score_380 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 3.5) => -0.0295376171,
(f_rel_under100miles_cnt_d > 3.5) => 
   map(
   (eda_pfrd_address_ind in ['1A','1D','XX']) => 0.0049590130,
   (eda_pfrd_address_ind in ['1B','1C','1E']) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 0.5) => 0.1835236598,
      (f_util_adl_count_n > 0.5) => 0.0242727580,
      (f_util_adl_count_n = NULL) => 0.0616621002, 0.0616621002),
   (eda_pfrd_address_ind = '') => 0.0089002974, 0.0089002974),
(f_rel_under100miles_cnt_d = NULL) => 0.0020704989, 0.0020704989);

// Tree: 381 
final_score_381 := map(
(NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 57.5) => 
   map(
   (NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 12.5) => 
      map(
      (NULL < mth_exp_last_update and mth_exp_last_update <= 35.5) => 0.0252211450,
      (mth_exp_last_update > 35.5) => -0.0623836501,
      (mth_exp_last_update = NULL) => 0.0207474405, 0.0207474405),
   (mth_eda_dt_first_seen > 12.5) => -0.0212959279,
   (mth_eda_dt_first_seen = NULL) => 0.0012182446, 0.0012182446),
(mth_pp_datelastseen > 57.5) => -0.1005021917,
(mth_pp_datelastseen = NULL) => -0.0023966347, -0.0023966347);

// Tree: 382 
final_score_382 := map(
(NULL < _pp_rule_low_vend_conf and _pp_rule_low_vend_conf <= 0.5) => -0.0019267324,
(_pp_rule_low_vend_conf > 0.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 9.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 72) => 0.1985824780,
      (f_curraddrmurderindex_i > 72) => 0.0561065145,
      (f_curraddrmurderindex_i = NULL) => 0.1114568888, 0.1114568888),
   (f_rel_under25miles_cnt_d > 9.5) => -0.0638184212,
   (f_rel_under25miles_cnt_d = NULL) => 0.0598529904, 0.0598529904),
(_pp_rule_low_vend_conf = NULL) => -0.0004120735, -0.0004120735);

// Tree: 383 
final_score_383 := map(
(NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 73.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By SSN','Daughter','Grandparent','Parent','Son','Subject at Household']) => -0.1138870868,
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Relative','Sibling','Sister','Spouse','Subject','Wife']) => 
      map(
      (NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 2.5) => 0.1673247453,
      (f_componentcharrisktype_i > 2.5) => -0.0396407495,
      (f_componentcharrisktype_i = NULL) => -0.0225790779, -0.0225790779),
   (phone_subject_title = '') => -0.0364556750, -0.0364556750),
(f_mos_acc_lseen_d > 73.5) => 0.0000115859,
(f_mos_acc_lseen_d = NULL) => -0.0044457747, -0.0044457747);

// Tree: 384 
final_score_384 := map(
(NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 13.5) => 
      map(
      (phone_subject_title in ['Associate By Business','Associate By Shared Associates','Associate By Vehicle','Grandmother','Grandson','Mother','Neighbor','Sibling','Sister','Spouse']) => -0.0836148623,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By SSN','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Husband','Parent','Relative','Son','Subject','Subject at Household','Wife']) => 0.0236344427,
      (phone_subject_title = '') => -0.0060700640, -0.0060700640),
   (f_inq_count_i > 13.5) => -0.0523931123,
   (f_inq_count_i = NULL) => -0.0191988667, -0.0191988667),
(_inq_adl_ph_industry_flag > 0.5) => 0.0957224396,
(_inq_adl_ph_industry_flag = NULL) => -0.0158548218, -0.0158548218);

// Tree: 385 
final_score_385 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 16.5) => 0.0036653452,
(mth_source_ppdid_lseen > 16.5) => 
   map(
   (NULL < _phone_match_code_z and _phone_match_code_z <= 0.5) => -0.1065575294,
   (_phone_match_code_z > 0.5) => 
      map(
      (NULL < r_paw_active_phone_ct_d and r_paw_active_phone_ct_d <= 0.5) => -0.0188729708,
      (r_paw_active_phone_ct_d > 0.5) => 0.1050490186,
      (r_paw_active_phone_ct_d = NULL) => -0.0043408818, -0.0043408818),
   (_phone_match_code_z = NULL) => -0.0412734812, -0.0412734812),
(mth_source_ppdid_lseen = NULL) => -0.0030955109, -0.0030955109);

// Tree: 386 
final_score_386 := map(
(NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 122.5) => -0.0003968074,
(mth_pp_eda_hist_did_dt > 122.5) => 
   map(
   (NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 16.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.359362919419775) => 0.2360544564,
      (f_add_curr_mobility_index_n > 0.359362919419775) => 0.0491254351,
      (f_add_curr_mobility_index_n = NULL) => 0.1348726926, 0.1348726926),
   (mth_pp_orig_lastseen > 16.5) => -0.0220994107,
   (mth_pp_orig_lastseen = NULL) => 0.0621861029, 0.0621861029),
(mth_pp_eda_hist_did_dt = NULL) => 0.0011762895, 0.0011762895);

// Tree: 387 
final_score_387 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 125.5) => 0.0010580467,
(r_pb_order_freq_d > 125.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 154.5) => 
      map(
      (pp_source in ['CELL','HEADER','INQUIRY','OTHER','THRIVE']) => -0.0150057231,
      (pp_source in ['GONG','IBEHAVIOR','INFUTOR','INTRADO','PCNSR','TARGUS']) => 0.1122782084,
      (pp_source = '') => 0.0596987061, 0.0534372379),
   (f_prevaddrcartheftindex_i > 154.5) => -0.0538200181,
   (f_prevaddrcartheftindex_i = NULL) => 0.0262371064, 0.0262371064),
(r_pb_order_freq_d = NULL) => -0.0229387380, -0.0047694456);

// Tree: 388 
final_score_388 := map(
(NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 13.5) => 0.0017866398,
(mth_pp_datelastseen > 13.5) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 4.5) => -0.0498530530,
   (inq_adl_firstseen_n > 4.5) => 
      map(
      (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 29.5) => 0.0867967470,
      (inq_adl_lastseen_n > 29.5) => -0.0591501809,
      (inq_adl_lastseen_n = NULL) => 0.0210506869, 0.0210506869),
   (inq_adl_firstseen_n = NULL) => -0.0361368165, -0.0361368165),
(mth_pp_datelastseen = NULL) => -0.0058111998, -0.0058111998);

// Tree: 389 
final_score_389 := map(
(NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 50) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By Vehicle','Brother','Daughter','Father','Grandmother','Parent','Sibling','Son','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 194.5) => -0.0167588702,
      (r_pb_order_freq_d > 194.5) => -0.1129508227,
      (r_pb_order_freq_d = NULL) => -0.0537599699, -0.0394745172),
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Child','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Mother','Neighbor','Relative','Sister']) => 0.0249248258,
   (phone_subject_title = '') => -0.0139722382, -0.0139722382),
(f_curraddrmurderindex_i > 50) => 0.0088067381,
(f_curraddrmurderindex_i = NULL) => 0.0035858509, 0.0035858509);

// Tree: 390 
final_score_390 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 11.5) => -0.0075259238,
(inq_adl_lastseen_n > 11.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 20.5) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 32) => 0.0197698978,
      (inq_firstseen_n > 32) => 0.2102285398,
      (inq_firstseen_n = NULL) => 0.0949238484, 0.0949238484),
   (inq_adl_lastseen_n > 20.5) => 0.0066261713,
   (inq_adl_lastseen_n = NULL) => 0.0288205603, 0.0288205603),
(inq_adl_lastseen_n = NULL) => -0.0042135152, -0.0042135152);

// Tree: 391 
final_score_391 := map(
(pp_app_scc in ['A','B','C','R']) => -0.0034791174,
(pp_app_scc in ['8','J','N','S']) => 
   map(
   (pp_src in ['E1','EM','EN','KW','LP','SL','TN','VW']) => -0.0278338576,
   (pp_src in ['CY','E2','EQ','FA','FF','LA','MD','NW','PL','UT','UW','VO','ZK','ZT']) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0188883015,
      (f_rel_felony_count_i > 0.5) => 0.1394130834,
      (f_rel_felony_count_i = NULL) => 0.0665063515, 0.0665063515),
   (pp_src = '') => -0.0040570944, 0.0248717237),
(pp_app_scc = '') => -0.0057534953, -0.0012041261);

// Tree: 392 
final_score_392 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 98582) => -0.0065776732,
(f_prevaddrmedianincome_d > 98582) => 
   map(
   (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 57.5) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 49.5) => -0.0246858214,
      (inq_firstseen_n > 49.5) => 0.1915791572,
      (inq_firstseen_n = NULL) => 0.0143127813, 0.0143127813),
   (mth_pp_eda_hist_did_dt > 57.5) => 0.1686600472,
   (mth_pp_eda_hist_did_dt = NULL) => 0.0405623163, 0.0405623163),
(f_prevaddrmedianincome_d = NULL) => -0.0040032168, -0.0040032168);

// Tree: 393 
final_score_393 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 14.5) => 0.0020069380,
(f_corraddrnamecount_d > 14.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 50.5) => -0.1869373410,
   (f_mos_inq_banko_cm_fseen_d > 50.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Brother','Daughter','Father','Grandfather','Husband','Mother','Parent','Sister','Subject at Household']) => -0.1252583491,
      (phone_subject_title in ['Associate By Address','Associate By Property','Associate By SSN','Associate By Vehicle','Child','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Neighbor','Relative','Sibling','Son','Spouse','Subject','Wife']) => 0.0379403684,
      (phone_subject_title = '') => -0.0172711380, -0.0172711380),
   (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0526739284, -0.0526739284),
(f_corraddrnamecount_d = NULL) => 0.0002871584, 0.0002871584);

// Tree: 394 
final_score_394 := map(
(NULL < mth_source_sp_fseen and mth_source_sp_fseen <= 2.5) => 
   map(
   (pp_src in ['CY','E1','FA','KW','LP','PL','SL','TN','UT','UW','VO','ZT']) => -0.0174396148,
   (pp_src in ['E2','EM','EN','EQ','FF','LA','MD','NW','VW','ZK']) => 0.0512862106,
   (pp_src = '') => -0.0012179976, -0.0028429642),
(mth_source_sp_fseen > 2.5) => 
   map(
   (NULL < mth_source_sp_fseen and mth_source_sp_fseen <= 10.5) => 0.1670711603,
   (mth_source_sp_fseen > 10.5) => 0.0224062016,
   (mth_source_sp_fseen = NULL) => 0.0595277759, 0.0595277759),
(mth_source_sp_fseen = NULL) => -0.0007963760, -0.0007963760);

// Tree: 395 
final_score_395 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 27.5) => 
   map(
   (NULL < inq_num and inq_num <= 0.5) => -0.0071875272,
   (inq_num > 0.5) => 
      map(
      (pp_source in ['CELL','HEADER','INQUIRY','OTHER','PCNSR']) => 0.0008801503,
      (pp_source in ['GONG','IBEHAVIOR','INFUTOR','INTRADO','TARGUS','THRIVE']) => 0.1068851500,
      (pp_source = '') => 0.0815091555, 0.0377066542),
   (inq_num = NULL) => -0.0027968382, -0.0027968382),
(f_inq_count_i > 27.5) => -0.0648104310,
(f_inq_count_i = NULL) => -0.0085873335, -0.0085873335);

// Tree: 396 
final_score_396 := map(
(exp_source in ['P']) => -0.0455354792,
(exp_source in ['S']) => 
   map(
   (pp_source in ['GONG','HEADER','INQUIRY','OTHER','PCNSR']) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 66) => -0.0793129217,
      (f_curraddrcartheftindex_i > 66) => 0.0093516367,
      (f_curraddrcartheftindex_i = NULL) => -0.0197787299, -0.0197787299),
   (pp_source in ['CELL','IBEHAVIOR','INFUTOR','INTRADO','TARGUS','THRIVE']) => 0.0592713108,
   (pp_source = '') => -0.0069389682, 0.0048321247),
(exp_source = '') => 0.0037678737, 0.0011115512);

// Tree: 397 
final_score_397 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 195593.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 30.5) => 0.0120108118,
   (mth_source_utildid_fseen > 30.5) => -0.0517118695,
   (mth_source_utildid_fseen = NULL) => 0.0089229775, 0.0089229775),
(f_addrchangevaluediff_d > 195593.5) => -0.0697409602,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < pp_src_cnt and pp_src_cnt <= 2.5) => -0.0004583427,
   (pp_src_cnt > 2.5) => -0.1486868429,
   (pp_src_cnt = NULL) => -0.0045819373, -0.0045819373), 0.0023813929);

// Tree: 398 
final_score_398 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 193.5) => 0.0025708162,
(f_curraddrcartheftindex_i > 193.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 35.5) => 
      map(
      (NULL < eda_days_in_service and eda_days_in_service <= 299.5) => 0.0410773886,
      (eda_days_in_service > 299.5) => 0.3056769801,
      (eda_days_in_service = NULL) => 0.1820323112, 0.1820323112),
   (f_mos_inq_banko_cm_lseen_d > 35.5) => 0.0233414377,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0757486089, 0.0757486089),
(f_curraddrcartheftindex_i = NULL) => 0.0055066266, 0.0055066266);

// Tree: 399 
final_score_399 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 49761.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Grandfather','Grandmother','Grandson','Husband','Neighbor','Relative','Son','Spouse','Subject']) => 
      map(
      (pp_source in ['CELL','GONG','HEADER','IBEHAVIOR','INFUTOR','OTHER','PCNSR','THRIVE']) => -0.0344050084,
      (pp_source in ['INQUIRY','INTRADO','TARGUS']) => 0.1393241014,
      (pp_source = '') => 0.0235685341, 0.0253856883),
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Vehicle','Father','Grandchild','Granddaughter','Grandparent','Mother','Parent','Sibling','Sister','Subject at Household','Wife']) => 0.2233676718,
   (phone_subject_title = '') => 0.0503984014, 0.0503984014),
(f_curraddrmedianvalue_d > 49761.5) => -0.0034911248,
(f_curraddrmedianvalue_d = NULL) => -0.0003749276, -0.0003749276);

// Tree: 400 
final_score_400 := map(
(NULL < _pp_origlistingtype_res and _pp_origlistingtype_res <= 0.5) => 0.0104722229,
(_pp_origlistingtype_res > 0.5) => 
   map(
   (NULL < _pp_glb_dppa_fl_glb and _pp_glb_dppa_fl_glb <= 0.5) => 0.0220603883,
   (_pp_glb_dppa_fl_glb > 0.5) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 122.5) => -0.1013605328,
      (mth_pp_app_npa_effective_dt > 122.5) => -0.0129319833,
      (mth_pp_app_npa_effective_dt = NULL) => -0.0388417218, -0.0388417218),
   (_pp_glb_dppa_fl_glb = NULL) => -0.0195664898, -0.0195664898),
(_pp_origlistingtype_res = NULL) => 0.0021516929, 0.0021516929);

// Tree: 401 
final_score_401 := map(
(NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0079021207,
(_pp_rule_high_vend_conf > 0.5) => 
   map(
   (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 1.5) => -0.0180513402,
   (pp_app_ind_ph_cnt > 1.5) => 
      map(
      (NULL < mth_source_ppca_fseen and mth_source_ppca_fseen <= 15.5) => 0.1073461504,
      (mth_source_ppca_fseen > 15.5) => -0.0134900995,
      (mth_source_ppca_fseen = NULL) => 0.0743234988, 0.0743234988),
   (pp_app_ind_ph_cnt = NULL) => 0.0393138566, 0.0393138566),
(_pp_rule_high_vend_conf = NULL) => -0.0002198777, -0.0002198777);

// Tree: 402 
final_score_402 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 21576) => -0.0105824777,
(f_addrchangeincomediff_d > 21576) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By Vehicle','Child','Daughter','Father','Grandmother','Husband','Neighbor','Parent','Sister','Son','Subject at Household','Wife']) => -0.0344066890,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Mother','Relative','Sibling','Spouse','Subject']) => 0.0447681411,
   (phone_subject_title = '') => 0.0203974201, 0.0203974201),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 12.5) => -0.0076517014,
   (f_rel_homeover200_count_d > 12.5) => 0.0696602400,
   (f_rel_homeover200_count_d = NULL) => 0.0010561885, 0.0010561885), -0.0026591846);

// Tree: 403 
final_score_403 := map(
(NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 1.5) => -0.0070881167,
(f_divaddrsuspidcountnew_i > 1.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 86.5) => -0.0074415773,
   (f_prevaddrlenofres_d > 86.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By SSN','Brother','Father','Husband','Neighbor','Relative','Sister','Son','Subject at Household','Wife']) => 0.0263540075,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Parent','Sibling','Spouse','Subject']) => 0.2499440754,
      (phone_subject_title = '') => 0.1346554466, 0.1346554466),
   (f_prevaddrlenofres_d = NULL) => 0.0630561710, 0.0630561710),
(f_divaddrsuspidcountnew_i = NULL) => -0.0048472517, -0.0048472517);

// Tree: 404 
final_score_404 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 0.5) => 0.0135417894,
(f_rel_homeover200_count_d > 0.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 51090.5) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 2.5) => 0.0443744837,
      (f_sourcerisktype_i > 2.5) => -0.0469214921,
      (f_sourcerisktype_i = NULL) => -0.0364077053, -0.0364077053),
   (f_curraddrmedianincome_d > 51090.5) => 0.0062216460,
   (f_curraddrmedianincome_d = NULL) => -0.0122735470, -0.0122735470),
(f_rel_homeover200_count_d = NULL) => -0.0043056922, -0.0043056922);

// Tree: 405 
final_score_405 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Daughter','Grandson','Husband','Neighbor','Parent','Spouse','Subject','Subject at Household','Wife']) => -0.0082717305,
(phone_subject_title in ['Associate By Property','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Mother','Relative','Sibling','Sister','Son']) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 22.5) => 0.2023930793,
   (f_fp_prevaddrburglaryindex_i > 22.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 66949.5) => 0.0000261976,
      (f_addrchangevaluediff_d > 66949.5) => 0.1457634082,
      (f_addrchangevaluediff_d = NULL) => -0.0009260898, 0.0223190898),
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.0432672944, 0.0432672944),
(phone_subject_title = '') => -0.0025664447, -0.0025664447);

// Tree: 406 
final_score_406 := map(
(NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 15.5) => 0.0075389390,
(f_rel_homeover50_count_d > 15.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.20711506913522) => 0.0386980602,
   (f_add_input_mobility_index_n > 0.20711506913522) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 2.5) => -0.1783790723,
      (f_assocrisktype_i > 2.5) => -0.0184997096,
      (f_assocrisktype_i = NULL) => -0.0240846897, -0.0240846897),
   (f_add_input_mobility_index_n = NULL) => -0.0200359546, -0.0200359546),
(f_rel_homeover50_count_d = NULL) => -0.0004017804, -0.0004017804);

// Tree: 407 
final_score_407 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Relative','Subject','Subject at Household','Wife']) => -0.0016233117,
(phone_subject_title in ['Associate By Property','Associate By SSN','Father','Grandchild','Granddaughter','Grandparent','Parent','Sibling','Sister','Son','Spouse']) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 923) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 2.5) => 0.2466083733,
      (f_util_adl_count_n > 2.5) => -0.0035076524,
      (f_util_adl_count_n = NULL) => 0.1529820535, 0.1529820535),
   (f_addrchangeincomediff_d > 923) => -0.0212104544,
   (f_addrchangeincomediff_d = NULL) => 0.0512767587, 0.0638356215),
(phone_subject_title = '') => 0.0023240014, 0.0023240014);

// Tree: 408 
final_score_408 := map(
(NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 8.5) => 0.0040059889,
(mth_internal_ver_first_seen > 8.5) => 
   map(
   (NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 28.5) => -0.1779952111,
   (f_mos_acc_lseen_d > 28.5) => 
      map(
      (pp_app_scc in ['B','C','J','N']) => -0.0446684086,
      (pp_app_scc in ['8','A','R','S']) => 0.0620004340,
      (pp_app_scc = '') => -0.0271313277, -0.0271313277),
   (f_mos_acc_lseen_d = NULL) => -0.0380952727, -0.0380952727),
(mth_internal_ver_first_seen = NULL) => 0.0004193534, 0.0004193534);

// Tree: 409 
final_score_409 := map(
(exp_source in ['P']) => -0.0284732749,
(exp_source in ['S']) => 
   map(
   (NULL < _pp_rule_iq_rpc and _pp_rule_iq_rpc <= 0.5) => 
      map(
      (NULL < mth_exp_last_update and mth_exp_last_update <= 8.5) => 0.1023689341,
      (mth_exp_last_update > 8.5) => 0.0065032296,
      (mth_exp_last_update = NULL) => 0.0272207689, 0.0272207689),
   (_pp_rule_iq_rpc > 0.5) => -0.0922943015,
   (_pp_rule_iq_rpc = NULL) => 0.0133188423, 0.0133188423),
(exp_source = '') => -0.0000408967, 0.0002981339);

// Tree: 410 
final_score_410 := map(
(NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 111.5) => -0.0025427068,
(mth_pp_eda_hist_did_dt > 111.5) => 
   map(
   (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 119) => -0.0539809880,
      (mth_pp_app_npa_last_change_dt > 119) => 0.1094003600,
      (mth_pp_app_npa_last_change_dt = NULL) => -0.0048819301, -0.0048819301),
   (f_prevaddrstatus_i > 2.5) => 0.1605146598,
   (f_prevaddrstatus_i = NULL) => 0.1478871534, 0.0554237818),
(mth_pp_eda_hist_did_dt = NULL) => -0.0003176435, -0.0003176435);

// Tree: 411 
final_score_411 := map(
(NULL < _inq_adl_ph_industry_cards and _inq_adl_ph_industry_cards <= 0.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 11.5) => 0.0119964893,
   (f_addrchangecrimediff_i > 11.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Daughter','Father','Grandfather','Grandmother','Grandson','Husband','Neighbor','Parent','Spouse','Subject']) => -0.0324859995,
      (phone_subject_title in ['Associate By Business','Associate By SSN','Child','Grandchild','Granddaughter','Grandparent','Mother','Relative','Sibling','Sister','Son','Subject at Household','Wife']) => 0.0466074861,
      (phone_subject_title = '') => -0.0188620626, -0.0188620626),
   (f_addrchangecrimediff_i = NULL) => -0.0031236201, 0.0001068054),
(_inq_adl_ph_industry_cards > 0.5) => 0.0951586594,
(_inq_adl_ph_industry_cards = NULL) => 0.0008836037, 0.0008836037);

// Tree: 412 
final_score_412 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Father','Grandson','Neighbor','Parent','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 41.5) => -0.0017700841,
   (f_inq_count_i > 41.5) => -0.0919501330,
   (f_inq_count_i = NULL) => -0.0049643404, -0.0049643404),
(phone_subject_title in ['Associate By Business','Associate By Property','Associate By SSN','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Husband','Mother','Relative','Spouse']) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 247.5) => 0.0438245136,
   (f_prevaddrlenofres_d > 247.5) => 0.2343691628,
   (f_prevaddrlenofres_d = NULL) => 0.0713378731, 0.0713378731),
(phone_subject_title = '') => 0.0011863210, 0.0011863210);

// Tree: 413 
final_score_413 := map(
(NULL < eda_address_match_best and eda_address_match_best <= 0.5) => 
   map(
   (NULL < eda_days_ind_first_seen and eda_days_ind_first_seen <= 529) => 0.0020546234,
   (eda_days_ind_first_seen > 529) => -0.0826764000,
   (eda_days_ind_first_seen = NULL) => -0.0011215363, -0.0011215363),
(eda_address_match_best > 0.5) => 
   map(
   (phone_subject_title in ['Associate','Brother','Father','Mother','Neighbor','Sister']) => -0.0923468846,
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Parent','Relative','Sibling','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0960455009,
   (phone_subject_title = '') => 0.0482503926, 0.0482503926),
(eda_address_match_best = NULL) => 0.0017701084, 0.0017701084);

// Tree: 414 
final_score_414 := map(
(NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 11.5) => 
   map(
   (NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 27.5) => -0.0023167904,
   (mth_source_rel_fseen > 27.5) => 0.0748723006,
   (mth_source_rel_fseen = NULL) => -0.0017893690, -0.0017893690),
(f_crim_rel_under25miles_cnt_i > 11.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Vehicle','Daughter','Father','Neighbor','Sister','Wife']) => -0.1066052788,
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Parent','Relative','Sibling','Son','Spouse','Subject','Subject at Household']) => 0.1458965988,
   (phone_subject_title = '') => 0.0582223358, 0.0582223358),
(f_crim_rel_under25miles_cnt_i = NULL) => -0.0007154675, -0.0007154675);

// Tree: 415 
final_score_415 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 7.5) => 0.0115641647,
(f_rel_incomeover50_count_d > 7.5) => 
   map(
   (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 4.5) => -0.0246195968,
   (f_crim_rel_under500miles_cnt_i > 4.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 99986) => 0.0121164694,
      (f_prevaddrmedianincome_d > 99986) => 0.1709134136,
      (f_prevaddrmedianincome_d = NULL) => 0.0226044536, 0.0226044536),
   (f_crim_rel_under500miles_cnt_i = NULL) => -0.0070657053, -0.0070657053),
(f_rel_incomeover50_count_d = NULL) => 0.0048704656, 0.0048704656);

// Tree: 416 
final_score_416 := map(
(NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 11.5) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 9.5) => 0.0043492402,
   (f_rel_under100miles_cnt_d > 9.5) => 0.0682007903,
   (f_rel_under100miles_cnt_d = NULL) => 0.0114040578, 0.0114040578),
(f_rel_educationover8_count_d > 11.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 589096.5) => -0.0091133206,
   (f_prevaddrmedianvalue_d > 589096.5) => -0.1532049754,
   (f_prevaddrmedianvalue_d = NULL) => -0.0123989170, -0.0123989170),
(f_rel_educationover8_count_d = NULL) => -0.0002711431, -0.0002711431);

// Tree: 417 
final_score_417 := map(
(segment in ['0 - Disconnected','1 - Other']) => -0.0337379715,
(segment in ['2 - Cell Phone','3 - ExpHit']) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 42.5) => -0.0120297350,
   (f_mos_inq_banko_cm_lseen_d > 42.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 96.5) => -0.0015451726,
      (f_prevaddrageoldest_d > 96.5) => 0.0910275463,
      (f_prevaddrageoldest_d = NULL) => 0.0536468582, 0.0536468582),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0247307861, 0.0247307861),
(segment = '') => -0.0078556277, -0.0078556277);

// Tree: 418 
final_score_418 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 10.5) => -0.0031252768,
(f_rel_ageover40_count_d > 10.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 2963) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -26371) => -0.0805082784,
      (f_addrchangeincomediff_d > -26371) => 0.1186971277,
      (f_addrchangeincomediff_d = NULL) => 0.0776158572, 0.0776158572),
   (f_addrchangeincomediff_d > 2963) => -0.0260028292,
   (f_addrchangeincomediff_d = NULL) => 0.0182169038, 0.0283216052),
(f_rel_ageover40_count_d = NULL) => -0.0007107938, -0.0007107938);

// Tree: 419 
final_score_419 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 11.5) => -0.0053394350,
(inq_adl_lastseen_n > 11.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 23.5) => 0.0787604339,
   (inq_adl_lastseen_n > 23.5) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => 0.0445251808,
      (f_sourcerisktype_i > 4.5) => -0.0470952064,
      (f_sourcerisktype_i = NULL) => 0.0066900411, 0.0066900411),
   (inq_adl_lastseen_n = NULL) => 0.0299895106, 0.0299895106),
(inq_adl_lastseen_n = NULL) => -0.0021460063, -0.0021460063);

// Tree: 420 
final_score_420 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 33.5) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 47886.5) => -0.0136238426,
   (f_prevaddrmedianincome_d > 47886.5) => 0.0111781524,
   (f_prevaddrmedianincome_d = NULL) => -0.0010072571, -0.0010072571),
(f_rel_under25miles_cnt_d > 33.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Brother','Daughter','Father','Husband','Mother','Subject at Household','Wife']) => -0.0406676163,
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject']) => 0.2281961329,
   (phone_subject_title = '') => 0.0950445619, 0.0950445619),
(f_rel_under25miles_cnt_d = NULL) => 0.0002466831, 0.0002466831);

// Tree: 421 
final_score_421 := map(
(NULL < eda_num_phs_connected_addr and eda_num_phs_connected_addr <= 1.5) => 
   map(
   (NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 94.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 41.5) => 0.0049030013,
      (f_inq_count_i > 41.5) => -0.0681466115,
      (f_inq_count_i = NULL) => 0.0021584428, 0.0021584428),
   (mth_source_ppfla_fseen > 94.5) => -0.1068005336,
   (mth_source_ppfla_fseen = NULL) => 0.0013513393, 0.0013513393),
(eda_num_phs_connected_addr > 1.5) => -0.1300222456,
(eda_num_phs_connected_addr = NULL) => -0.0004543155, -0.0004543155);

// Tree: 422 
final_score_422 := map(
(exp_source in ['P']) => 
   map(
   (NULL < inq_firstseen_n and inq_firstseen_n <= 42.5) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 2.5) => 0.0455621474,
      (f_rel_under25miles_cnt_d > 2.5) => -0.0760853335,
      (f_rel_under25miles_cnt_d = NULL) => -0.0479832256, -0.0479832256),
   (inq_firstseen_n > 42.5) => 0.0456846243,
   (inq_firstseen_n = NULL) => -0.0211303657, -0.0211303657),
(exp_source in ['S']) => 0.0154927952,
(exp_source = '') => -0.0042623967, -0.0023574627);

// Tree: 423 
final_score_423 := map(
(NULL < mth_source_edaca_fseen and mth_source_edaca_fseen <= 1.5) => 
   map(
   (NULL < mth_source_edala_fseen and mth_source_edala_fseen <= 21.5) => -0.0029087738,
   (mth_source_edala_fseen > 21.5) => -0.0885779850,
   (mth_source_edala_fseen = NULL) => -0.0038048038, -0.0038048038),
(mth_source_edaca_fseen > 1.5) => 
   map(
   (NULL < f_idverrisktype_i and f_idverrisktype_i <= 6.5) => -0.0047805941,
   (f_idverrisktype_i > 6.5) => 0.1458788329,
   (f_idverrisktype_i = NULL) => 0.0628884706, 0.0628884706),
(mth_source_edaca_fseen = NULL) => -0.0018558671, -0.0018558671);

// Tree: 424 
final_score_424 := map(
(pp_app_scc in ['B','C','N','R']) => -0.0015489534,
(pp_app_scc in ['8','A','J','S']) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 47627.5) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 105.5) => 0.1173280268,
      (mth_pp_app_npa_effective_dt > 105.5) => -0.0413353242,
      (mth_pp_app_npa_effective_dt = NULL) => -0.0020728678, -0.0020728678),
   (f_prevaddrmedianincome_d > 47627.5) => 0.0774089633,
   (f_prevaddrmedianincome_d = NULL) => 0.0401321109, 0.0401321109),
(pp_app_scc = '') => -0.0029068014, 0.0009643171);

// Tree: 425 
final_score_425 := map(
(NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 15.5) => -0.0100965297,
(r_mos_since_paw_fseen_d > 15.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -117.5) => 0.0923076084,
   (f_addrchangecrimediff_i > -117.5) => -0.0001954856,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 4796) => 0.0938065242,
      (eda_days_ph_first_seen > 4796) => -0.1062776486,
      (eda_days_ph_first_seen = NULL) => 0.0558784805, 0.0558784805), 0.0178639850),
(r_mos_since_paw_fseen_d = NULL) => -0.0049060887, -0.0049060887);

// Tree: 426 
final_score_426 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 97.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Father','Grandparent','Grandson','Husband','Mother','Neighbor','Relative','Sibling','Son','Spouse','Subject at Household','Wife']) => -0.0199563530,
   (phone_subject_title in ['Associate','Associate By Business','Associate By SSN','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Parent','Sister','Subject']) => 0.0229906031,
   (phone_subject_title = '') => 0.0014993441, 0.0014993441),
(r_pb_order_freq_d > 97.5) => 
   map(
   (NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0468506177,
   (_pp_rule_high_vend_conf > 0.5) => 0.0503699343,
   (_pp_rule_high_vend_conf = NULL) => -0.0336194184, -0.0336194184),
(r_pb_order_freq_d = NULL) => -0.0028875632, -0.0060643466);

// Tree: 427 
final_score_427 := map(
(NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 143) => 
   map(
   (NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0082321546,
   (_pp_rule_high_vend_conf > 0.5) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 114.5) => 0.0366448979,
      (mth_pp_app_npa_last_change_dt > 114.5) => -0.0398409483,
      (mth_pp_app_npa_last_change_dt = NULL) => 0.0179224395, 0.0179224395),
   (_pp_rule_high_vend_conf = NULL) => -0.0041667075, -0.0041667075),
(mth_source_ppdid_fseen > 143) => 0.1100301542,
(mth_source_ppdid_fseen = NULL) => -0.0033182910, -0.0033182910);

// Tree: 428 
final_score_428 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 18.5) => -0.0024410777,
(f_rel_under100miles_cnt_d > 18.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 1.5) => 
      map(
      (pp_source in ['CELL','HEADER','INFUTOR','OTHER','PCNSR']) => -0.0615592613,
      (pp_source in ['GONG','IBEHAVIOR','INQUIRY','INTRADO','TARGUS','THRIVE']) => 0.1036621245,
      (pp_source = '') => -0.0673786221, -0.0363493223),
   (f_util_adl_count_n > 1.5) => 0.0623983425,
   (f_util_adl_count_n = NULL) => 0.0343978936, 0.0343978936),
(f_rel_under100miles_cnt_d = NULL) => 0.0027065863, 0.0027065863);

// Tree: 429 
final_score_429 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -24127) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 247) => -0.0027657609,
   (r_pb_order_freq_d > 247) => -0.1686366310,
   (r_pb_order_freq_d = NULL) => -0.0979028170, -0.0489311718),
(f_addrchangeincomediff_d > -24127) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 416632) => -0.0071071980,
   (f_prevaddrmedianvalue_d > 416632) => 0.0553347844,
   (f_prevaddrmedianvalue_d = NULL) => -0.0026587628, -0.0026587628),
(f_addrchangeincomediff_d = NULL) => 0.0061318861, -0.0046786149);

// Tree: 430 
final_score_430 := map(
(eda_pfrd_address_ind in ['1A','1B','XX']) => -0.0049897960,
(eda_pfrd_address_ind in ['1C','1D','1E']) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Father','Grandfather','Neighbor','Parent','Relative','Sibling','Sister','Wife']) => 
      map(
      (NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 18) => 0.0578832644,
      (r_mos_since_paw_fseen_d > 18) => -0.1590440260,
      (r_mos_since_paw_fseen_d = NULL) => 0.0130926093, 0.0130926093),
   (phone_subject_title in ['Associate By SSN','Daughter','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Mother','Son','Spouse','Subject','Subject at Household']) => 0.1379826351,
   (phone_subject_title = '') => 0.0557217381, 0.0557217381),
(eda_pfrd_address_ind = '') => -0.0021707240, -0.0021707240);

// Tree: 431 
final_score_431 := map(
(NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 11.5) => 0.0016920151,
(mth_pp_first_build_date > 11.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 46747.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 3.5) => 0.0428568454,
      (f_rel_criminal_count_i > 3.5) => -0.0857666264,
      (f_rel_criminal_count_i = NULL) => -0.0037719789, -0.0037719789),
   (f_addrchangevaluediff_d > 46747.5) => -0.0803672098,
   (f_addrchangevaluediff_d = NULL) => -0.0711500308, -0.0378508363),
(mth_pp_first_build_date = NULL) => -0.0036303077, -0.0036303077);

// Tree: 432 
final_score_432 := map(
(phone_subject_title in ['Associate','Associate By Business','Associate By SSN','Associate By Vehicle','Daughter','Grandfather','Grandmother','Grandson','Husband','Relative','Sibling','Son','Subject at Household','Wife']) => 
   map(
   (NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 3.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -30814.5) => -0.0693623411,
      (f_addrchangevaluediff_d > -30814.5) => -0.0079554545,
      (f_addrchangevaluediff_d = NULL) => -0.0476918963, -0.0312680590),
   (f_inq_per_ssn_i > 3.5) => 0.0493416560,
   (f_inq_per_ssn_i = NULL) => -0.0232534149, -0.0232534149),
(phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Brother','Child','Father','Grandchild','Granddaughter','Grandparent','Mother','Neighbor','Parent','Sister','Spouse','Subject']) => 0.0021831535,
(phone_subject_title = '') => -0.0032972365, -0.0032972365);

// Tree: 433 
final_score_433 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.264541321085485) => 
   map(
   (NULL < _phone_match_code_a and _phone_match_code_a <= 0.5) => -0.0092964037,
   (_phone_match_code_a > 0.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.24917334735385) => 0.0176891541,
      (f_add_input_mobility_index_n > 0.24917334735385) => 0.1036769108,
      (f_add_input_mobility_index_n = NULL) => 0.0480264076, 0.0480264076),
   (_phone_match_code_a = NULL) => 0.0160289790, 0.0160289790),
(f_add_curr_mobility_index_n > 0.264541321085485) => -0.0090051740,
(f_add_curr_mobility_index_n = NULL) => -0.0064376978, -0.0027231101);

// Tree: 434 
final_score_434 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 31.5) => 
   map(
   (NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 123.5) => 0.0036261765,
   (r_mos_since_paw_fseen_d > 123.5) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 4.5) => -0.1005950972,
      (f_rel_under100miles_cnt_d > 4.5) => -0.0084662697,
      (f_rel_under100miles_cnt_d = NULL) => -0.0350562971, -0.0350562971),
   (r_mos_since_paw_fseen_d = NULL) => 0.0000501192, 0.0000501192),
(f_rel_homeover200_count_d > 31.5) => 0.1055928784,
(f_rel_homeover200_count_d = NULL) => 0.0008244319, 0.0008244319);

// Tree: 435 
final_score_435 := map(
(pp_source in ['CELL','GONG','INQUIRY','INTRADO','OTHER','THRIVE']) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 9.5) => 0.1099299223,
   (mth_pp_app_npa_last_change_dt > 9.5) => -0.0290339052,
   (mth_pp_app_npa_last_change_dt = NULL) => -0.0240640847, -0.0240640847),
(pp_source in ['HEADER','IBEHAVIOR','INFUTOR','PCNSR','TARGUS']) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 4.5) => 0.0443882913,
   (f_inq_count_i > 4.5) => -0.0096276814,
   (f_inq_count_i = NULL) => 0.0044470797, 0.0044470797),
(pp_source = '') => 0.0014288742, -0.0023562380);

// Tree: 436 
final_score_436 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 10.5) => 0.0053391875,
(f_corraddrnamecount_d > 10.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 81.5) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 3.5) => -0.0670787679,
      (f_rel_ageover40_count_d > 3.5) => -0.0134750416,
      (f_rel_ageover40_count_d = NULL) => -0.0425395512, -0.0425395512),
   (mth_source_ppdid_fseen > 81.5) => 0.0810939245,
   (mth_source_ppdid_fseen = NULL) => -0.0351720053, -0.0351720053),
(f_corraddrnamecount_d = NULL) => -0.0008057123, -0.0008057123);

// Tree: 437 
final_score_437 := map(
(NULL < _internal_ver_match_level and _internal_ver_match_level <= 1.5) => -0.0089956619,
(_internal_ver_match_level > 1.5) => 
   map(
   (phone_subject_title in ['Associate','Brother','Husband','Mother','Sister','Son']) => -0.0965695956,
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Neighbor','Parent','Relative','Sibling','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => -0.0784369986,
      (f_attr_arrest_recency_d > 99.5) => 0.0272962984,
      (f_attr_arrest_recency_d = NULL) => 0.0224511323, 0.0224511323),
   (phone_subject_title = '') => 0.0153118053, 0.0153118053),
(_internal_ver_match_level = NULL) => -0.0015192196, -0.0015192196);

// Tree: 438 
final_score_438 := map(
(NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 9.5) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 1.5) => 
      map(
      (NULL < pk_phone_match_level and pk_phone_match_level <= 3.5) => 0.0050137718,
      (pk_phone_match_level > 3.5) => 0.1533639229,
      (pk_phone_match_level = NULL) => 0.0496906513, 0.0496906513),
   (f_sourcerisktype_i > 1.5) => -0.0038143226,
   (f_sourcerisktype_i = NULL) => -0.0020685695, -0.0020685695),
(f_inq_per_ssn_i > 9.5) => -0.1098741100,
(f_inq_per_ssn_i = NULL) => -0.0039107147, -0.0039107147);

// Tree: 439 
final_score_439 := map(
(NULL < f_estimated_income_d and f_estimated_income_d <= 120500) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.767406532024255) => 0.0025782558,
   (f_add_input_mobility_index_n > 0.767406532024255) => -0.0382222432,
   (f_add_input_mobility_index_n = NULL) => -0.0360256835, -0.0011440914),
(f_estimated_income_d > 120500) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Brother','Daughter','Neighbor','Parent','Subject at Household']) => -0.0012544315,
   (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => 0.1482065306,
   (phone_subject_title = '') => 0.0754171010, 0.0754171010),
(f_estimated_income_d = NULL) => 0.0003158421, 0.0003158421);

// Tree: 440 
final_score_440 := map(
(NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 6.5) => 
   map(
   (exp_source in ['P']) => -0.0441562399,
   (exp_source in ['S']) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 51.5) => -0.0326963492,
      (f_mos_inq_banko_cm_lseen_d > 51.5) => 0.1043933636,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0545912414, 0.0545912414),
   (exp_source = '') => 0.0171231726, 0.0172677789),
(f_rel_ageover20_count_d > 6.5) => -0.0083090491,
(f_rel_ageover20_count_d = NULL) => -0.0022181184, -0.0022181184);

// Tree: 441 
final_score_441 := map(
(pp_origphonetype in ['O','V']) => -0.1355363272,
(pp_origphonetype in ['L','W']) => 
   map(
   (NULL < _pp_glb_dppa_fl_glb and _pp_glb_dppa_fl_glb <= 0.5) => 
      map(
      (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 12.5) => 0.0637340029,
      (mth_source_ppdid_lseen > 12.5) => -0.0473387940,
      (mth_source_ppdid_lseen = NULL) => 0.0207919243, 0.0207919243),
   (_pp_glb_dppa_fl_glb > 0.5) => -0.0333343549,
   (_pp_glb_dppa_fl_glb = NULL) => -0.0155033754, -0.0155033754),
(pp_origphonetype = '') => 0.0081645019, 0.0007273466);

// Tree: 442 
final_score_442 := map(
(NULL < eda_num_interrupts_cur and eda_num_interrupts_cur <= 6.5) => -0.0058606027,
(eda_num_interrupts_cur > 6.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Brother','Child','Daughter','Father','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => 
      map(
      (NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 6.5) => 0.0007117108,
      (mth_internal_ver_first_seen > 6.5) => 0.1458051434,
      (mth_internal_ver_first_seen = NULL) => 0.0087333652, 0.0087333652),
   (phone_subject_title in ['Associate By SSN','Associate By Vehicle','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Subject at Household']) => 0.2068757435,
   (phone_subject_title = '') => 0.0243156076, 0.0243156076),
(eda_num_interrupts_cur = NULL) => -0.0016794264, -0.0016794264);

// Tree: 443 
final_score_443 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 32.5) => 
   map(
   (NULL < mth_pp_eda_hist_ph_dt and mth_pp_eda_hist_ph_dt <= 2.5) => 
      map(
      (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 79.5) => 0.0023454816,
      (mth_source_ppdid_fseen > 79.5) => 0.0707575290,
      (mth_source_ppdid_fseen = NULL) => 0.0036511626, 0.0036511626),
   (mth_pp_eda_hist_ph_dt > 2.5) => -0.0752491842,
   (mth_pp_eda_hist_ph_dt = NULL) => 0.0013070675, 0.0013070675),
(mth_source_ppdid_lseen > 32.5) => -0.0542238250,
(mth_source_ppdid_lseen = NULL) => -0.0026122748, -0.0026122748);

// Tree: 444 
final_score_444 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 19710) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 4.5) => -0.0080390315,
   (f_rel_under25miles_cnt_d > 4.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Father','Grandfather','Mother','Relative','Sister','Wife']) => -0.0095478029,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Sibling','Son','Spouse','Subject','Subject at Household']) => 0.1852098585,
      (phone_subject_title = '') => 0.0922174616, 0.0922174616),
   (f_rel_under25miles_cnt_d = NULL) => 0.0570397447, 0.0570397447),
(f_curraddrmedianvalue_d > 19710) => -0.0012625321,
(f_curraddrmedianvalue_d = NULL) => -0.0000208293, -0.0000208293);

// Tree: 445 
final_score_445 := map(
(segment in ['0 - Disconnected','1 - Other']) => -0.0323812899,
(segment in ['2 - Cell Phone','3 - ExpHit']) => 
   map(
   (NULL < subject_ssn_mismatch and subject_ssn_mismatch <= -0.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 51.5) => 0.0066208276,
      (f_mos_inq_banko_cm_lseen_d > 51.5) => 0.1296677901,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0803621229, 0.0803621229),
   (subject_ssn_mismatch > -0.5) => 0.0066285934,
   (subject_ssn_mismatch = NULL) => 0.0303413634, 0.0303413634),
(segment = '') => -0.0050197362, -0.0050197362);

// Tree: 446 
final_score_446 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 9.5) => -0.0129827628,
(f_rel_under500miles_cnt_d > 9.5) => 
   map(
   (NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 12.5) => 
      map(
      (NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 1926.5) => 0.0040142240,
      (eda_max_days_interrupt > 1926.5) => 0.1073554976,
      (eda_max_days_interrupt = NULL) => 0.0067454927, 0.0067454927),
   (mth_source_rel_fseen > 12.5) => -0.0933381931,
   (mth_source_rel_fseen = NULL) => 0.0054870264, 0.0054870264),
(f_rel_under500miles_cnt_d = NULL) => -0.0033083299, -0.0033083299);

// Tree: 447 
final_score_447 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 193.5) => -0.0011409776,
(f_curraddrcartheftindex_i > 193.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 141207) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 163) => -0.0364024110,
      (f_prevaddrlenofres_d > 163) => 0.1441720478,
      (f_prevaddrlenofres_d = NULL) => 0.0129854752, 0.0129854752),
   (f_prevaddrmedianvalue_d > 141207) => 0.1388706619,
   (f_prevaddrmedianvalue_d = NULL) => 0.0512006211, 0.0512006211),
(f_curraddrcartheftindex_i = NULL) => 0.0010366818, 0.0010366818);

// Tree: 448 
final_score_448 := map(
(NULL < number_of_sources and number_of_sources <= 2.5) => 
   map(
   (NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => 
      map(
      (NULL < source_rel and source_rel <= 0.5) => -0.0465155154,
      (source_rel > 0.5) => 0.1471623084,
      (source_rel = NULL) => -0.0378946763, -0.0378946763),
   (_inq_adl_ph_industry_flag > 0.5) => 0.2544356820,
   (_inq_adl_ph_industry_flag = NULL) => -0.0302350097, -0.0302350097),
(number_of_sources > 2.5) => 0.1694493426,
(number_of_sources = NULL) => -0.0079571988, -0.0079571988);

// Tree: 449 
final_score_449 := map(
(NULL < f_wealth_index_d and f_wealth_index_d <= 4.5) => -0.0092367975,
(f_wealth_index_d > 4.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 3.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 3.5) => 0.0312518000,
      (f_srchvelocityrisktype_i > 3.5) => 0.1560225786,
      (f_srchvelocityrisktype_i = NULL) => 0.0528358193, 0.0528358193),
   (f_srchssnsrchcount_i > 3.5) => -0.0833256082,
   (f_srchssnsrchcount_i = NULL) => 0.0335108251, 0.0335108251),
(f_wealth_index_d = NULL) => -0.0051716447, -0.0051716447);

// Tree: 450 
final_score_450 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 1.27225709656084) => 
   map(
   (NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 154.5) => -0.0013454894,
   (mth_source_cr_fseen > 154.5) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 110604.5) => 0.2365499787,
      (f_curraddrmedianvalue_d > 110604.5) => 0.0229506946,
      (f_curraddrmedianvalue_d = NULL) => 0.1077123153, 0.1077123153),
   (mth_source_cr_fseen = NULL) => 0.0003829739, 0.0003829739),
(f_add_curr_mobility_index_n > 1.27225709656084) => -0.1478150280,
(f_add_curr_mobility_index_n = NULL) => -0.0000905051, -0.0006853373);

// Tree: 451 
final_score_451 := map(
(NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0245389972,
(_phone_match_code_n > 0.5) => 
   map(
   (phone_subject_title in ['Daughter','Grandfather','Grandmother','Son','Subject','Wife']) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 7.5) => 0.0486159700,
      (f_inq_count_i > 7.5) => -0.0119630059,
      (f_inq_count_i = NULL) => 0.0132397744, 0.0132397744),
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Spouse','Subject at Household']) => 0.0986556349,
   (phone_subject_title = '') => 0.0229227471, 0.0229227471),
(_phone_match_code_n = NULL) => -0.0045281949, -0.0045281949);

// Tree: 452 
final_score_452 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.8773742920271) => 0.0023368205,
(f_add_input_mobility_index_n > 0.8773742920271) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 16111.5) => 
      map(
      (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => 0.0520799086,
      (_phone_match_code_n > 0.5) => 0.1363558471,
      (_phone_match_code_n = NULL) => 0.0860418539, 0.0860418539),
   (f_addrchangevaluediff_d > 16111.5) => -0.0457336629,
   (f_addrchangevaluediff_d = NULL) => 0.0784924704, 0.0443497972),
(f_add_input_mobility_index_n = NULL) => 0.0043248797, 0.0045085021);

// Tree: 453 
final_score_453 := map(
(NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 22.5) => 0.0021222266,
(mth_source_inf_fseen > 22.5) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 3.5) => 0.0501536192,
   (f_rel_incomeover25_count_d > 3.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 6.5) => -0.1184687580,
      (f_rel_educationover12_count_d > 6.5) => -0.0221574333,
      (f_rel_educationover12_count_d = NULL) => -0.0544054948, -0.0544054948),
   (f_rel_incomeover25_count_d = NULL) => -0.0366538542, -0.0366538542),
(mth_source_inf_fseen = NULL) => -0.0004513221, -0.0004513221);

// Tree: 454 
final_score_454 := map(
(NULL < _pp_rule_iq_rpc and _pp_rule_iq_rpc <= 0.5) => 0.0052346182,
(_pp_rule_iq_rpc > 0.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 43) => 0.0822877106,
   (f_curraddrcrimeindex_i > 43) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.41443738470998) => -0.0229783925,
      (f_add_input_mobility_index_n > 0.41443738470998) => -0.1246158498,
      (f_add_input_mobility_index_n = NULL) => -0.0612216391, -0.0612216391),
   (f_curraddrcrimeindex_i = NULL) => -0.0381792928, -0.0381792928),
(_pp_rule_iq_rpc = NULL) => 0.0033262553, 0.0033262553);

// Tree: 455 
final_score_455 := map(
(NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 34.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Child','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Neighbor','Relative','Sibling','Sister','Son','Spouse']) => -0.0134053590,
   (phone_subject_title in ['Associate By Vehicle','Brother','Daughter','Father','Grandchild','Husband','Mother','Parent','Subject','Subject at Household','Wife']) => 0.0198420193,
   (phone_subject_title = '') => 0.0018580381, 0.0018580381),
(mth_pp_eda_hist_did_dt > 34.5) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 16.5) => -0.0152990246,
   (f_inq_count24_i > 16.5) => -0.1597959575,
   (f_inq_count24_i = NULL) => -0.0214414551, -0.0214414551),
(mth_pp_eda_hist_did_dt = NULL) => -0.0037071826, -0.0037071826);

// Tree: 456 
final_score_456 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 25.5) => 
   map(
   (NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 6.5) => 
      map(
      (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 1261) => 0.0957853935,
      (eda_days_ph_first_seen > 1261) => 0.0174530069,
      (eda_days_ph_first_seen = NULL) => 0.0502219019, 0.0502219019),
   (mth_internal_ver_first_seen > 6.5) => -0.0307380494,
   (mth_internal_ver_first_seen = NULL) => 0.0306127240, 0.0306127240),
(f_mos_inq_banko_om_fseen_d > 25.5) => -0.0047848734,
(f_mos_inq_banko_om_fseen_d = NULL) => 0.0001373037, 0.0001373037);

// Tree: 457 
final_score_457 := map(
(NULL < eda_num_phs_connected_addr and eda_num_phs_connected_addr <= 1.5) => 
   map(
   (NULL < mth_source_sp_fseen and mth_source_sp_fseen <= 2.5) => 0.0016726776,
   (mth_source_sp_fseen > 2.5) => 
      map(
      (NULL < mth_source_sp_lseen and mth_source_sp_lseen <= 3.5) => 0.1142886407,
      (mth_source_sp_lseen > 3.5) => -0.1043727241,
      (mth_source_sp_lseen = NULL) => 0.0715617073, 0.0715617073),
   (mth_source_sp_fseen = NULL) => 0.0039568044, 0.0039568044),
(eda_num_phs_connected_addr > 1.5) => -0.1681325398,
(eda_num_phs_connected_addr = NULL) => 0.0020390183, 0.0020390183);

// Tree: 458 
final_score_458 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -3.5) => 
   map(
   (NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 23.5) => 0.0733574507,
   (f_mos_acc_lseen_d > 23.5) => -0.0212727642,
   (f_mos_acc_lseen_d = NULL) => -0.0161475266, -0.0161475266),
(f_addrchangecrimediff_i > -3.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 7.5) => 0.0456677165,
   (f_addrchangecrimediff_i > 7.5) => -0.0007412329,
   (f_addrchangecrimediff_i = NULL) => 0.0128318633, 0.0128318633),
(f_addrchangecrimediff_i = NULL) => 0.0046841067, 0.0008007363);

// Tree: 459 
final_score_459 := map(
(NULL < eda_num_phs_ind and eda_num_phs_ind <= 3.5) => 
   map(
   (NULL < mth_source_sp_fseen and mth_source_sp_fseen <= 1.5) => -0.0053030667,
   (mth_source_sp_fseen > 1.5) => 0.0519912689,
   (mth_source_sp_fseen = NULL) => -0.0036918893, -0.0036918893),
(eda_num_phs_ind > 3.5) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 8.5) => 0.0062384330,
   (f_rel_incomeover25_count_d > 8.5) => 0.1245379170,
   (f_rel_incomeover25_count_d = NULL) => 0.0494789340, 0.0494789340),
(eda_num_phs_ind = NULL) => -0.0027306535, -0.0027306535);

// Tree: 460 
final_score_460 := map(
(NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => 
   map(
   (NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 1.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 22.5) => 0.0766182630,
      (f_fp_prevaddrburglaryindex_i > 22.5) => 0.0001306572,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0083556306, 0.0083556306),
   (mth_source_rel_fseen > 1.5) => 0.0696915968,
   (mth_source_rel_fseen = NULL) => 0.0109432696, 0.0109432696),
(f_util_add_input_conv_n > 0.5) => -0.0114886450,
(f_util_add_input_conv_n = NULL) => -0.0019420266, -0.0019420266);

// Tree: 461 
final_score_461 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 0.5) => 0.1096588028,
(f_rel_under500miles_cnt_d > 0.5) => 
   map(
   (NULL < r_paw_dead_business_ct_i and r_paw_dead_business_ct_i <= 0.5) => -0.0001016634,
   (r_paw_dead_business_ct_i > 0.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 205) => -0.0083013413,
      (r_pb_order_freq_d > 205) => -0.1270779565,
      (r_pb_order_freq_d = NULL) => -0.0530895375, -0.0345427810),
   (r_paw_dead_business_ct_i = NULL) => -0.0024635370, -0.0024635370),
(f_rel_under500miles_cnt_d = NULL) => -0.0016694300, -0.0016694300);

// Tree: 462 
final_score_462 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 777278) => 
   map(
   (pp_source in ['CELL','INFUTOR','INTRADO','OTHER','PCNSR','TARGUS','THRIVE']) => -0.0203936300,
   (pp_source in ['GONG','HEADER','IBEHAVIOR','INQUIRY']) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 14.5) => 0.0259007665,
      (inq_firstseen_n > 14.5) => -0.0120978477,
      (inq_firstseen_n = NULL) => 0.0090812009, 0.0090812009),
   (pp_source = '') => -0.0040478776, -0.0022772585),
(f_curraddrmedianvalue_d > 777278) => 0.1104388182,
(f_curraddrmedianvalue_d = NULL) => -0.0015654556, -0.0015654556);

// Tree: 463 
final_score_463 := map(
(NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 3.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Father','Grandfather','Grandmother','Grandson','Mother','Neighbor','Parent','Sibling','Son','Spouse']) => -0.0360940108,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Child','Daughter','Grandchild','Granddaughter','Grandparent','Husband','Relative','Sister','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < mth_source_sx_fseen and mth_source_sx_fseen <= 56) => 0.0193172969,
      (mth_source_sx_fseen > 56) => 0.1518280544,
      (mth_source_sx_fseen = NULL) => 0.0237565183, 0.0237565183),
   (phone_subject_title = '') => 0.0057616306, 0.0057616306),
(f_sourcerisktype_i > 3.5) => -0.0106721260,
(f_sourcerisktype_i = NULL) => -0.0054601321, -0.0054601321);

// Tree: 464 
final_score_464 := map(
(NULL < _pp_src_all_iq and _pp_src_all_iq <= 0.5) => -0.0095181747,
(_pp_src_all_iq > 0.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -170216) => 0.1659182414,
   (f_addrchangevaluediff_d > -170216) => 
      map(
      (NULL < f_adl_util_conv_n and f_adl_util_conv_n <= 0.5) => 0.0566427289,
      (f_adl_util_conv_n > 0.5) => -0.0092293922,
      (f_adl_util_conv_n = NULL) => 0.0130329450, 0.0130329450),
   (f_addrchangevaluediff_d = NULL) => 0.0176706942, 0.0204437903),
(_pp_src_all_iq = NULL) => -0.0049622939, -0.0049622939);

// Tree: 465 
final_score_465 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 193.5) => -0.0035358811,
(f_curraddrcartheftindex_i > 193.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By SSN','Daughter','Grandparent','Grandson','Parent','Spouse','Subject at Household','Wife']) => -0.0663919176,
   (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Husband','Mother','Neighbor','Relative','Sibling','Sister','Son','Subject']) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 25606) => 0.0432310678,
      (f_curraddrmedianincome_d > 25606) => 0.1989570958,
      (f_curraddrmedianincome_d = NULL) => 0.1114854545, 0.1114854545),
   (phone_subject_title = '') => 0.0642367776, 0.0642367776),
(f_curraddrcartheftindex_i = NULL) => -0.0008504860, -0.0008504860);

// Tree: 466 
final_score_466 := map(
(NULL < _pp_rule_30 and _pp_rule_30 <= 0.5) => 
   map(
   (NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 6.5) => 
      map(
      (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 67.5) => 0.0089663110,
      (mth_source_utildid_fseen > 67.5) => -0.0963588359,
      (mth_source_utildid_fseen = NULL) => 0.0081064007, 0.0081064007),
   (mth_source_ppth_lseen > 6.5) => -0.0611588089,
   (mth_source_ppth_lseen = NULL) => 0.0048304022, 0.0048304022),
(_pp_rule_30 > 0.5) => -0.0817061084,
(_pp_rule_30 = NULL) => 0.0037052990, 0.0037052990);

// Tree: 467 
final_score_467 := map(
(NULL < _phone_fb_rp_result and _phone_fb_rp_result <= 1.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Father','Grandfather','Grandmother','Mother','Neighbor','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => -0.0665839540,
      (f_crim_rel_under25miles_cnt_i > 0.5) => 0.0705813534,
      (f_crim_rel_under25miles_cnt_i = NULL) => 0.0220417417, 0.0220417417),
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Vehicle','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Parent','Relative','Sibling']) => 0.1634722990,
   (phone_subject_title = '') => 0.0421776176, 0.0421776176),
(_phone_fb_rp_result > 1.5) => -0.0028150049,
(_phone_fb_rp_result = NULL) => 0.0004719747, 0.0004719747);

// Tree: 468 
final_score_468 := map(
(NULL < _pp_app_fb_ph7_did and _pp_app_fb_ph7_did <= 0.5) => 0.1152321404,
(_pp_app_fb_ph7_did > 0.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 17) => 
      map(
      (pp_source in ['HEADER','INFUTOR','INQUIRY','PCNSR','THRIVE']) => 0.0255593126,
      (pp_source in ['CELL','GONG','IBEHAVIOR','INTRADO','OTHER','TARGUS']) => 0.1539115496,
      (pp_source = '') => 0.0163405130, 0.0298900212),
   (f_prevaddrmurderindex_i > 17) => -0.0041537504,
   (f_prevaddrmurderindex_i = NULL) => -0.0007846364, -0.0007846364),
(_pp_app_fb_ph7_did = NULL) => 0.0001060323, 0.0001060323);

// Tree: 469 
final_score_469 := map(
(NULL < _pp_rule_seen_once and _pp_rule_seen_once <= 0.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 750800) => 
      map(
      (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 120.5) => -0.0039490930,
      (mth_source_ppdid_fseen > 120.5) => 0.0936852755,
      (mth_source_ppdid_fseen = NULL) => -0.0031138764, -0.0031138764),
   (f_curraddrmedianvalue_d > 750800) => 0.0970084990,
   (f_curraddrmedianvalue_d = NULL) => -0.0022398813, -0.0022398813),
(_pp_rule_seen_once > 0.5) => 0.1102582922,
(_pp_rule_seen_once = NULL) => -0.0014598049, -0.0014598049);

// Tree: 470 
final_score_470 := map(
(NULL < _phone_timezone_match and _phone_timezone_match <= 0.5) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 1.5) => 
      map(
      (NULL < pk_phone_match_level and pk_phone_match_level <= 3.5) => -0.0570021335,
      (pk_phone_match_level > 3.5) => -0.1199742293,
      (pk_phone_match_level = NULL) => -0.0668496217, -0.0668496217),
   (f_crim_rel_under25miles_cnt_i > 1.5) => 0.0294075379,
   (f_crim_rel_under25miles_cnt_i = NULL) => -0.0412585944, -0.0412585944),
(_phone_timezone_match > 0.5) => 0.0004683676,
(_phone_timezone_match = NULL) => -0.0029623781, -0.0029623781);

// Tree: 471 
final_score_471 := map(
(NULL < f_wealth_index_d and f_wealth_index_d <= 4.5) => 0.0005390092,
(f_wealth_index_d > 4.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 10.5) => 
      map(
      (NULL < f_foreclosure_flag_i and f_foreclosure_flag_i <= 0.5) => 0.0069971768,
      (f_foreclosure_flag_i > 0.5) => 0.1269052272,
      (f_foreclosure_flag_i = NULL) => 0.0171946356, 0.0171946356),
   (f_rel_homeover300_count_d > 10.5) => 0.1168681632,
   (f_rel_homeover300_count_d = NULL) => 0.0290421350, 0.0290421350),
(f_wealth_index_d = NULL) => 0.0032781331, 0.0032781331);

// Tree: 472 
final_score_472 := map(
(NULL < f_divrisktype_i and f_divrisktype_i <= 2.5) => -0.0019737732,
(f_divrisktype_i > 2.5) => 
   map(
   (phone_subject_title in ['Associate By Vehicle','Brother','Daughter','Granddaughter','Grandfather','Grandson','Neighbor','Relative','Sibling','Son','Subject','Subject at Household','Wife']) => 0.0044699552,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Child','Father','Grandchild','Grandmother','Grandparent','Husband','Mother','Parent','Sister','Spouse']) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 0.2679551775,
      (f_assocrisktype_i > 7.5) => 0.0522830466,
      (f_assocrisktype_i = NULL) => 0.1642666531, 0.1642666531),
   (phone_subject_title = '') => 0.0497529431, 0.0497529431),
(f_divrisktype_i = NULL) => 0.0003768589, 0.0003768589);

// Tree: 473 
final_score_473 := map(
(NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 18.5) => 
   map(
   (NULL < _pp_rule_ins_ver_above and _pp_rule_ins_ver_above <= 0.5) => 0.0026977897,
   (_pp_rule_ins_ver_above > 0.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 5.5) => 0.1307116786,
      (f_corrrisktype_i > 5.5) => 0.0202117600,
      (f_corrrisktype_i = NULL) => 0.0614600173, 0.0614600173),
   (_pp_rule_ins_ver_above = NULL) => 0.0049029780, 0.0049029780),
(mth_source_ppth_lseen > 18.5) => -0.0957093056,
(mth_source_ppth_lseen = NULL) => 0.0012278141, 0.0012278141);

// Tree: 474 
final_score_474 := map(
(NULL < inq_firstseen_n and inq_firstseen_n <= 69.5) => -0.0037460852,
(inq_firstseen_n > 69.5) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 1.5) => -0.0077556209,
   (f_rel_incomeover75_count_d > 1.5) => 
      map(
      (phone_subject_title in ['Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Grandfather','Neighbor','Sibling','Son','Wife']) => -0.0975421383,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Vehicle','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Mother','Parent','Relative','Sister','Spouse','Subject','Subject at Household']) => 0.1488278734,
      (phone_subject_title = '') => 0.0713665597, 0.0713665597),
   (f_rel_incomeover75_count_d = NULL) => 0.0318920363, 0.0318920363),
(inq_firstseen_n = NULL) => -0.0017294159, -0.0017294159);

// Tree: 475 
final_score_475 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 2.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 344.5) => 0.0096263413,
   (f_prevaddrageoldest_d > 344.5) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 3.5) => -0.0148613100,
      (f_rel_under25miles_cnt_d > 3.5) => 0.1452138082,
      (f_rel_under25miles_cnt_d = NULL) => 0.0816919359, 0.0816919359),
   (f_prevaddrageoldest_d = NULL) => 0.0135034826, 0.0135034826),
(f_rel_ageover40_count_d > 2.5) => -0.0091140103,
(f_rel_ageover40_count_d = NULL) => 0.0007598871, 0.0007598871);

// Tree: 476 
final_score_476 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 64.5) => 
   map(
   (NULL < _pp_app_nonpub_targ_la and _pp_app_nonpub_targ_la <= 0.5) => 0.0011188816,
   (_pp_app_nonpub_targ_la > 0.5) => 
      map(
      (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => -0.0027168194,
      (f_prevaddrstatus_i > 2.5) => 0.0819691871,
      (f_prevaddrstatus_i = NULL) => 0.1526634245, 0.0573698074),
   (_pp_app_nonpub_targ_la = NULL) => 0.0028953781, 0.0028953781),
(mth_source_ppdid_lseen > 64.5) => -0.0778321392,
(mth_source_ppdid_lseen = NULL) => 0.0003464037, 0.0003464037);

// Tree: 477 
final_score_477 := map(
(pp_src in ['E1','E2','EM','EN','EQ','FA','KW','LP','PL','UT','VO','VW']) => -0.0190423755,
(pp_src in ['CY','FF','LA','MD','NW','SL','TN','UW','ZK','ZT']) => 
   map(
   (pp_app_scc in ['B','C']) => 
      map(
      (NULL < mth_pp_datevendorlastseen and mth_pp_datevendorlastseen <= 2.5) => 0.0490907042,
      (mth_pp_datevendorlastseen > 2.5) => -0.0771972569,
      (mth_pp_datevendorlastseen = NULL) => -0.0316880817, -0.0316880817),
   (pp_app_scc in ['8','A','J','N','R','S']) => 0.1010730497,
   (pp_app_scc = '') => 0.0089700148, 0.0089700148),
(pp_src = '') => 0.0022390560, -0.0008566844);

// Tree: 478 
final_score_478 := map(
(NULL < source_eda_any_clean and source_eda_any_clean <= 0.5) => -0.0034016481,
(source_eda_any_clean > 0.5) => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 3059) => 
      map(
      (NULL < mth_source_sx_fseen and mth_source_sx_fseen <= 9.5) => 0.0489406909,
      (mth_source_sx_fseen > 9.5) => -0.0911404630,
      (mth_source_sx_fseen = NULL) => -0.0107529826, -0.0107529826),
   (eda_days_ph_first_seen > 3059) => 0.0647366786,
   (eda_days_ph_first_seen = NULL) => 0.0399026966, 0.0399026966),
(source_eda_any_clean = NULL) => -0.0005329229, -0.0005329229);

// Tree: 479 
final_score_479 := map(
(NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 1.5) => 
   map(
   (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 51.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Father','Mother','Neighbor','Relative','Sibling','Wife']) => 0.0016225902,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Parent','Sister','Son','Spouse','Subject','Subject at Household']) => 0.0945514989,
      (phone_subject_title = '') => 0.0419218580, 0.0419218580),
   (mth_pp_eda_hist_did_dt > 51.5) => -0.0530809172,
   (mth_pp_eda_hist_did_dt = NULL) => 0.0245800816, 0.0245800816),
(f_rel_educationover12_count_d > 1.5) => -0.0027387779,
(f_rel_educationover12_count_d = NULL) => -0.0014559792, -0.0014559792);

// Tree: 480 
final_score_480 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 111.5) => -0.0179820810,
(f_prevaddrageoldest_d > 111.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 42.5) => -0.0115299447,
   (f_mos_inq_banko_cm_lseen_d > 42.5) => 
      map(
      (phone_subject_title in ['Associate By Business','Associate By Shared Associates','Associate By Vehicle','Daughter','Grandfather','Grandson','Mother','Neighbor','Parent','Sibling','Sister','Wife']) => -0.0417440631,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By SSN','Brother','Child','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Husband','Relative','Son','Spouse','Subject','Subject at Household']) => 0.0546582016,
      (phone_subject_title = '') => 0.0272872037, 0.0272872037),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0119703259, 0.0119703259),
(f_prevaddrageoldest_d = NULL) => -0.0033100005, -0.0033100005);

// Tree: 481 
final_score_481 := map(
(NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 21.5) => 
   map(
   (NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 6.5) => -0.0022004217,
   (mth_source_cr_fseen > 6.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 7.5) => 0.1352203578,
      (f_rel_educationover12_count_d > 7.5) => 0.0107526843,
      (f_rel_educationover12_count_d = NULL) => 0.0540858744, 0.0540858744),
   (mth_source_cr_fseen = NULL) => 0.0007974676, 0.0007974676),
(mth_source_cr_fseen > 21.5) => -0.0531034277,
(mth_source_cr_fseen = NULL) => -0.0023527581, -0.0023527581);

// Tree: 482 
final_score_482 := map(
(NULL < mth_pp_app_fb_ph7_did_dt and mth_pp_app_fb_ph7_did_dt <= 6.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 118.5) => -0.0001155133,
   (f_addrchangecrimediff_i > 118.5) => -0.0784240514,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 16.5) => 0.0206662449,
      (mth_pp_orig_lastseen > 16.5) => -0.0445595241,
      (mth_pp_orig_lastseen = NULL) => 0.0087179809, 0.0087179809), 0.0003197373),
(mth_pp_app_fb_ph7_did_dt > 6.5) => -0.0993772932,
(mth_pp_app_fb_ph7_did_dt = NULL) => -0.0008036443, -0.0008036443);

// Tree: 483 
final_score_483 := map(
(NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 11.5) => 0.0073178275,
(mth_pp_first_build_date > 11.5) => 
   map(
   (NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 0.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 63588.5) => -0.0340850441,
      (f_prevaddrmedianincome_d > 63588.5) => 0.0869362320,
      (f_prevaddrmedianincome_d = NULL) => -0.0012514457, -0.0012514457),
   (f_inq_per_ssn_i > 0.5) => -0.0708028305,
   (f_inq_per_ssn_i = NULL) => -0.0335315852, -0.0335315852),
(mth_pp_first_build_date = NULL) => 0.0018904601, 0.0018904601);

// Tree: 484 
final_score_484 := map(
(NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 26.5) => 0.0002654505,
(mth_source_ppla_fseen > 26.5) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 12.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 89.5) => 0.0114447299,
      (f_fp_prevaddrburglaryindex_i > 89.5) => 0.1098263299,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0693750121, 0.0693750121),
   (f_rel_under100miles_cnt_d > 12.5) => -0.0454673258,
   (f_rel_under100miles_cnt_d = NULL) => 0.0429074421, 0.0429074421),
(mth_source_ppla_fseen = NULL) => 0.0016171530, 0.0016171530);

// Tree: 485 
final_score_485 := map(
(NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0076132975,
(_phone_match_code_n > 0.5) => 
   map(
   (phone_subject_title in ['Associate','Daughter','Grandfather','Mother','Parent','Sibling','Subject','Subject at Household']) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 349.5) => 0.0202947272,
      (r_pb_order_freq_d > 349.5) => -0.0415591524,
      (r_pb_order_freq_d = NULL) => -0.0036529733, 0.0088020463),
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Neighbor','Relative','Sister','Son','Spouse','Wife']) => 0.1105729034,
   (phone_subject_title = '') => 0.0116423023, 0.0116423023),
(_phone_match_code_n = NULL) => 0.0005028568, 0.0005028568);

// Tree: 486 
final_score_486 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 1.11439598920819) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 89060) => -0.0156374659,
   (f_prevaddrmedianvalue_d > 89060) => 0.0091030211,
   (f_prevaddrmedianvalue_d = NULL) => 0.0022946415, 0.0022946415),
(f_add_input_mobility_index_n > 1.11439598920819) => 
   map(
   (NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 0.5) => 0.0061620007,
   (f_inq_per_ssn_i > 0.5) => 0.1788495295,
   (f_inq_per_ssn_i = NULL) => 0.0866186902, 0.0866186902),
(f_add_input_mobility_index_n = NULL) => 0.0093736484, 0.0042015601);

// Tree: 487 
final_score_487 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.199163805510475) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -22834.5) => 0.1250283139,
   (f_addrchangeincomediff_d > -22834.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.189283904241465) => -0.0197193037,
      (f_add_curr_mobility_index_n > 0.189283904241465) => -0.1442169339,
      (f_add_curr_mobility_index_n = NULL) => -0.0399531442, -0.0399531442),
   (f_addrchangeincomediff_d = NULL) => -0.0223981221, -0.0237895911),
(f_add_curr_mobility_index_n > 0.199163805510475) => 0.0005240774,
(f_add_curr_mobility_index_n = NULL) => -0.0856248226, -0.0025224758);

// Tree: 488 
final_score_488 := map(
(NULL < inq_firstseen_n and inq_firstseen_n <= 57.5) => -0.0079666747,
(inq_firstseen_n > 57.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -56.5) => -0.0579096114,
   (f_addrchangecrimediff_i > -56.5) => 0.0241014662,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 18.5) => 0.0340233487,
      (f_rel_incomeover25_count_d > 18.5) => 0.2140050634,
      (f_rel_incomeover25_count_d = NULL) => 0.0745011640, 0.0745011640), 0.0238097906),
(inq_firstseen_n = NULL) => -0.0038195233, -0.0038195233);

// Tree: 489 
final_score_489 := map(
(NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 86.5) => 0.0052067878,
(mth_pp_eda_hist_did_dt > 86.5) => 
   map(
   (NULL < f_estimated_income_d and f_estimated_income_d <= 89500) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 11.5) => -0.0246935450,
      (f_assocsuspicousidcount_i > 11.5) => -0.1554382200,
      (f_assocsuspicousidcount_i = NULL) => -0.0400059844, -0.0400059844),
   (f_estimated_income_d > 89500) => 0.0705020871,
   (f_estimated_income_d = NULL) => -0.0282611652, -0.0282611652),
(mth_pp_eda_hist_did_dt = NULL) => 0.0026332862, 0.0026332862);

// Tree: 490 
final_score_490 := map(
(NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 22.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 120329.5) => 
      map(
      (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 1799.5) => 0.0405350555,
      (eda_days_ph_first_seen > 1799.5) => 0.0063138735,
      (eda_days_ph_first_seen = NULL) => 0.0202602589, 0.0202602589),
   (f_prevaddrmedianvalue_d > 120329.5) => -0.0059271407,
   (f_prevaddrmedianvalue_d = NULL) => 0.0053437839, 0.0053437839),
(mth_pp_datevendorfirstseen > 22.5) => -0.0195887645,
(mth_pp_datevendorfirstseen = NULL) => 0.0009691652, 0.0009691652);

// Tree: 491 
final_score_491 := map(
(NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 21.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Brother','Child','Father','Grandson','Husband','Neighbor','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => -0.0041814244,
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Mother','Parent']) => 
      map(
      (NULL < pk_cell_indicator and pk_cell_indicator <= 3.5) => 0.0316461411,
      (pk_cell_indicator > 3.5) => 0.1153539362,
      (pk_cell_indicator = NULL) => 0.0341997652, 0.0341997652),
   (phone_subject_title = '') => 0.0044834199, 0.0044834199),
(f_rel_ageover30_count_d > 21.5) => -0.0311819052,
(f_rel_ageover30_count_d = NULL) => 0.0009753551, 0.0009753551);

// Tree: 492 
final_score_492 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 10.5) => 
   map(
   (NULL < pk_phone_match_level and pk_phone_match_level <= 3.5) => -0.0142091310,
   (pk_phone_match_level > 3.5) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 0.5) => -0.1526639108,
      (f_rel_homeover300_count_d > 0.5) => 0.0158855177,
      (f_rel_homeover300_count_d = NULL) => -0.0834149208, -0.0834149208),
   (pk_phone_match_level = NULL) => -0.0274396497, -0.0274396497),
(f_prevaddrageoldest_d > 10.5) => 0.0015910476,
(f_prevaddrageoldest_d = NULL) => -0.0008536427, -0.0008536427);

// Tree: 493 
final_score_493 := map(
(NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 3.5) => -0.0026371847,
(f_crim_rel_under100miles_cnt_i > 3.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -23857.5) => -0.0732019589,
   (f_addrchangeincomediff_d > -23857.5) => 0.0242947279,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 7.5) => -0.0006537747,
      (f_inq_count24_i > 7.5) => 0.1671791249,
      (f_inq_count24_i = NULL) => 0.0282612567, 0.0282612567), 0.0168882763),
(f_crim_rel_under100miles_cnt_i = NULL) => 0.0023212004, 0.0023212004);

// Tree: 494 
final_score_494 := map(
(NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 4.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 192.5) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 5.5) => -0.0020299146,
      (f_srchaddrsrchcount_i > 5.5) => 0.0666853094,
      (f_srchaddrsrchcount_i = NULL) => 0.0161721560, 0.0161721560),
   (f_curraddrcartheftindex_i > 192.5) => 0.1383362424,
   (f_curraddrcartheftindex_i = NULL) => 0.0248413522, 0.0248413522),
(f_rel_educationover12_count_d > 4.5) => -0.0039620388,
(f_rel_educationover12_count_d = NULL) => 0.0015345457, 0.0015345457);

// Tree: 495 
final_score_495 := map(
(NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 23.5) => -0.0009016156,
(mth_source_inf_fseen > 23.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 134) => 0.0070832887,
   (r_pb_order_freq_d > 134) => -0.0830358669,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 43.5) => -0.0470932660,
      (inq_firstseen_n > 43.5) => -0.1692727440,
      (inq_firstseen_n = NULL) => -0.0895904758, -0.0895904758), -0.0417477153),
(mth_source_inf_fseen = NULL) => -0.0034254150, -0.0034254150);

// Tree: 496 
final_score_496 := map(
(NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 6.5) => 
   map(
   (NULL < pp_did_score and pp_did_score <= 77) => 0.0063386434,
   (pp_did_score > 77) => -0.0236620810,
   (pp_did_score = NULL) => 0.0020577094, 0.0020577094),
(mth_source_rel_fseen > 6.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 91) => 0.0214664472,
   (f_curraddrcrimeindex_i > 91) => -0.1149451677,
   (f_curraddrcrimeindex_i = NULL) => -0.0544029341, -0.0544029341),
(mth_source_rel_fseen = NULL) => 0.0008132821, 0.0008132821);

// Tree: 497 
final_score_497 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 1.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 101) => 0.0151974398,
   (f_addrchangecrimediff_i > 101) => -0.0715898501,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 214.5) => 0.0002418511,
      (f_prevaddrageoldest_d > 214.5) => 0.0835262094,
      (f_prevaddrageoldest_d = NULL) => 0.0174215842, 0.0174215842), 0.0123083720),
(f_rel_homeover200_count_d > 1.5) => -0.0112601862,
(f_rel_homeover200_count_d = NULL) => -0.0006964845, -0.0006964845);

// Tree: 498 
final_score_498 := map(
(phone_subject_title in ['Associate By SSN','Granddaughter','Grandfather','Grandmother','Grandson','Husband','Neighbor','Sibling','Son','Spouse','Subject','Subject at Household']) => -0.0081933800,
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Grandparent','Mother','Parent','Relative','Sister','Wife']) => 
   map(
   (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => 0.0073654532,
   (_phone_match_code_n > 0.5) => 
      map(
      (NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 1.5) => 0.1587475799,
      (mth_source_rel_fseen > 1.5) => 0.0236753060,
      (mth_source_rel_fseen = NULL) => 0.0650871493, 0.0650871493),
   (_phone_match_code_n = NULL) => 0.0138283573, 0.0138283573),
(phone_subject_title = '') => 0.0003060944, 0.0003060944);

// Tree: 499 
final_score_499 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0038579712,
(source_utildid > 0.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 12.5) => 
      map(
      (NULL < inq_lastseen_n and inq_lastseen_n <= 5.5) => 0.2154950036,
      (inq_lastseen_n > 5.5) => 0.0332248812,
      (inq_lastseen_n = NULL) => 0.1390591459, 0.1390591459),
   (mth_source_utildid_fseen > 12.5) => 0.0084128532,
   (mth_source_utildid_fseen = NULL) => 0.0304239133, 0.0304239133),
(source_utildid = NULL) => -0.0007337182, -0.0007337182);

// Tree: 500 
final_score_500 := map(
(NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 4.5) => -0.0115083616,
(f_rel_homeover100_count_d > 4.5) => 
   map(
   (pp_src in ['CY','E1','E2','FA','LP','PL','SL','UT','UW','VO','ZT']) => -0.0005146660,
   (pp_src in ['EM','EN','EQ','FF','KW','LA','MD','NW','TN','VW','ZK']) => 0.0953011491,
   (pp_src = '') => 
      map(
      (NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 239.5) => 0.0072269746,
      (r_mos_since_paw_fseen_d > 239.5) => 0.1049888746,
      (r_mos_since_paw_fseen_d = NULL) => 0.0098205331, 0.0098205331), 0.0101194007),
(f_rel_homeover100_count_d = NULL) => -0.0006689475, -0.0006689475);

// Tree: 501 
final_score_501 := map(
(NULL < _pp_app_nonpub_gong_la and _pp_app_nonpub_gong_la <= 0.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 273.5) => 0.0041807885,
   (f_prevaddrlenofres_d > 273.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Brother','Child','Daughter','Father','Grandfather','Mother','Neighbor','Parent','Sister','Son','Subject','Subject at Household','Wife']) => -0.0365449044,
      (phone_subject_title in ['Associate By Property','Associate By SSN','Associate By Vehicle','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Relative','Sibling','Spouse']) => 0.1460951920,
      (phone_subject_title = '') => -0.0270109792, -0.0270109792),
   (f_prevaddrlenofres_d = NULL) => 0.0003662489, 0.0003662489),
(_pp_app_nonpub_gong_la > 0.5) => 0.0751548525,
(_pp_app_nonpub_gong_la = NULL) => 0.0011626604, 0.0011626604);

// Tree: 502 
final_score_502 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Property','Child','Daughter','Father','Granddaughter','Grandparent','Grandson','Husband','Neighbor','Son','Spouse','Subject','Subject at Household','Wife']) => -0.0074821145,
(phone_subject_title in ['Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Grandchild','Grandfather','Grandmother','Mother','Parent','Relative','Sibling','Sister']) => 
   map(
   (NULL < _phone_zip_match and _phone_zip_match <= 0.5) => -0.0055330572,
   (_phone_zip_match > 0.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -5979) => -0.0433616958,
      (f_addrchangeincomediff_d > -5979) => 0.1042980540,
      (f_addrchangeincomediff_d = NULL) => 0.1042029078, 0.0725946258),
   (_phone_zip_match = NULL) => 0.0254253186, 0.0254253186),
(phone_subject_title = '') => -0.0018264041, -0.0018264041);

// Tree: 503 
final_score_503 := map(
(NULL < pk_cell_indicator and pk_cell_indicator <= 1.5) => -0.0055079946,
(pk_cell_indicator > 1.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -33093) => 0.0843953080,
   (f_addrchangeincomediff_d > -33093) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 4.5) => -0.0763371443,
      (f_prevaddrlenofres_d > 4.5) => 0.0195757427,
      (f_prevaddrlenofres_d = NULL) => 0.0123106733, 0.0123106733),
   (f_addrchangeincomediff_d = NULL) => 0.0037248328, 0.0154410169),
(pk_cell_indicator = NULL) => -0.0003796890, -0.0003796890);

// Tree: 504 
final_score_504 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 24.5) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 3.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Father','Grandmother','Neighbor','Parent','Sibling','Spouse','Subject','Wife']) => -0.0353334956,
      (phone_subject_title in ['Associate','Associate By Property','Brother','Daughter','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Mother','Relative','Sister','Son','Subject at Household']) => 0.0435464451,
      (phone_subject_title = '') => -0.0149985420, -0.0149985420),
   (mth_exp_last_update > 3.5) => -0.0703675791,
   (mth_exp_last_update = NULL) => -0.0232859524, -0.0232859524),
(f_mos_inq_banko_cm_lseen_d > 24.5) => 0.0058957217,
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0002361878, -0.0002361878);

// Tree: 505 
final_score_505 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 1.5) => -0.0199119376,
(f_assocsuspicousidcount_i > 1.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -21.5) => -0.0168110441,
   (f_addrchangecrimediff_i > -21.5) => 0.0166134911,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 233) => -0.0071562201,
      (f_prevaddrlenofres_d > 233) => 0.0652703506,
      (f_prevaddrlenofres_d = NULL) => 0.0013617846, 0.0013617846), 0.0043961630),
(f_assocsuspicousidcount_i = NULL) => -0.0014972571, -0.0014972571);

// Tree: 506 
final_score_506 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 33468) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.331524421880015) => -0.0402863207,
   (f_add_curr_mobility_index_n > 0.331524421880015) => 
      map(
      (NULL < mth_source_sx_fseen and mth_source_sx_fseen <= 11.5) => 0.0129134672,
      (mth_source_sx_fseen > 11.5) => -0.0956734561,
      (mth_source_sx_fseen = NULL) => 0.0076741738, 0.0076741738),
   (f_add_curr_mobility_index_n = NULL) => -0.0129136195, -0.0129136195),
(f_prevaddrmedianincome_d > 33468) => 0.0048211104,
(f_prevaddrmedianincome_d = NULL) => 0.0006970611, 0.0006970611);

// Tree: 507 
final_score_507 := map(
(NULL < mth_source_paw_fseen and mth_source_paw_fseen <= 120) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 35.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 51) => 0.0178175199,
      (f_curraddrburglaryindex_i > 51) => -0.0053494835,
      (f_curraddrburglaryindex_i = NULL) => -0.0001552711, -0.0001552711),
   (f_rel_homeover100_count_d > 35.5) => 0.1026465558,
   (f_rel_homeover100_count_d = NULL) => 0.0005384678, 0.0005384678),
(mth_source_paw_fseen > 120) => -0.1049721473,
(mth_source_paw_fseen = NULL) => -0.0001931561, -0.0001931561);

// Tree: 508 
final_score_508 := map(
(phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => -0.0036596592,
(phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Mother','Spouse']) => 
   map(
   (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 159.5) => -0.0054832481,
      (f_curraddrcrimeindex_i > 159.5) => 0.1004928677,
      (f_curraddrcrimeindex_i = NULL) => 0.0203375395, 0.0203375395),
   (_phone_match_code_n > 0.5) => 0.0524984489,
   (_phone_match_code_n = NULL) => 0.0296580578, 0.0296580578),
(phone_subject_title = '') => 0.0002265827, 0.0002265827);

// Tree: 509 
final_score_509 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 12.5) => 
   map(
   (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 88.5) => 0.0041367146,
   (mth_pp_datefirstseen > 88.5) => -0.0420274583,
   (mth_pp_datefirstseen = NULL) => 0.0021261743, 0.0021261743),
(f_rel_ageover40_count_d > 12.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Brother','Father','Mother','Parent','Relative','Sibling','Sister','Son','Subject','Wife']) => -0.0696048268,
   (phone_subject_title in ['Associate By Property','Associate By SSN','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Spouse','Subject at Household']) => 0.0971164364,
   (phone_subject_title = '') => -0.0467478794, -0.0467478794),
(f_rel_ageover40_count_d = NULL) => -0.0001348813, -0.0001348813);

// Tree: 510 
final_score_510 := map(
(NULL < eda_num_phs_connected_ind and eda_num_phs_connected_ind <= 0.5) => -0.0015456753,
(eda_num_phs_connected_ind > 0.5) => 
   map(
   (NULL < eda_days_ind_first_seen and eda_days_ind_first_seen <= 810) => 0.1385214751,
   (eda_days_ind_first_seen > 810) => 
      map(
      (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 3524.5) => -0.0709265807,
      (eda_days_ph_first_seen > 3524.5) => 0.0813729741,
      (eda_days_ph_first_seen = NULL) => 0.0273311966, 0.0273311966),
   (eda_days_ind_first_seen = NULL) => 0.0560597853, 0.0560597853),
(eda_num_phs_connected_ind = NULL) => -0.0000548951, -0.0000548951);

// Tree: 511 
final_score_511 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 10.5) => 0.0015253336,
(f_util_adl_count_n > 10.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 44.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Husband','Mother','Parent','Relative','Sibling','Sister','Son','Spouse','Wife']) => -0.1061476427,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Neighbor','Subject','Subject at Household']) => 0.0385541675,
      (phone_subject_title = '') => -0.0137145472, -0.0137145472),
   (f_mos_inq_banko_om_fseen_d > 44.5) => -0.0923142554,
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0442404804, -0.0442404804),
(f_util_adl_count_n = NULL) => -0.0009114296, -0.0009114296);

// Tree: 512 
final_score_512 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0020094384,
(source_utildid > 0.5) => 
   map(
   (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 3.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 26822) => 0.1187876236,
      (f_curraddrmedianincome_d > 26822) => 0.0069769761,
      (f_curraddrmedianincome_d = NULL) => 0.0168021648, 0.0168021648),
   (f_rel_bankrupt_count_i > 3.5) => 0.0834998734,
   (f_rel_bankrupt_count_i = NULL) => 0.0334325961, 0.0334325961),
(source_utildid = NULL) => 0.0013170923, 0.0013170923);

// Tree: 513 
final_score_513 := map(
(NULL < eda_address_match_best and eda_address_match_best <= 0.5) => -0.0046693936,
(eda_address_match_best > 0.5) => 
   map(
   (NULL < eda_num_phs_discon_addr and eda_num_phs_discon_addr <= 2.5) => 
      map(
      (phone_subject_title in ['Associate','Father','Husband','Mother','Neighbor','Son','Subject at Household']) => -0.0076183501,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Parent','Relative','Sibling','Sister','Spouse','Subject','Wife']) => 0.1074583392,
      (phone_subject_title = '') => 0.0595916821, 0.0595916821),
   (eda_num_phs_discon_addr > 2.5) => -0.0458873075,
   (eda_num_phs_discon_addr = NULL) => 0.0320561143, 0.0320561143),
(eda_address_match_best = NULL) => -0.0025093371, -0.0025093371);

// Tree: 514 
final_score_514 := map(
(NULL < r_has_paw_source_d and r_has_paw_source_d <= 0.5) => -0.0108748833,
(r_has_paw_source_d > 0.5) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 12.5) => 0.0037380893,
   (inq_adl_firstseen_n > 12.5) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 152.5) => 0.0050545934,
      (mth_pp_app_npa_effective_dt > 152.5) => 0.0840367752,
      (mth_pp_app_npa_effective_dt = NULL) => 0.0377989148, 0.0377989148),
   (inq_adl_firstseen_n = NULL) => 0.0070952295, 0.0070952295),
(r_has_paw_source_d = NULL) => -0.0009641747, -0.0009641747);

// Tree: 515 
final_score_515 := map(
(NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 6.5) => 
   map(
   (NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 5.5) => -0.0001475794,
   (mth_pp_first_build_date > 5.5) => 
      map(
      (NULL < _pp_app_nonpub_targ_lap and _pp_app_nonpub_targ_lap <= 0.5) => 0.0270209806,
      (_pp_app_nonpub_targ_lap > 0.5) => 0.1349298166,
      (_pp_app_nonpub_targ_lap = NULL) => 0.0381339801, 0.0381339801),
   (mth_pp_first_build_date = NULL) => 0.0100022603, 0.0100022603),
(f_rel_ageover30_count_d > 6.5) => -0.0072466091,
(f_rel_ageover30_count_d = NULL) => -0.0018272515, -0.0018272515);

// Tree: 516 
final_score_516 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 8648.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Sibling','Sister','Subject','Wife']) => 0.0063263149,
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Relative','Son','Spouse','Subject at Household']) => 0.0520859389,
   (phone_subject_title = '') => 0.0141255584, 0.0141255584),
(f_addrchangeincomediff_d > 8648.5) => 
   map(
   (NULL < f_estimated_income_d and f_estimated_income_d <= 28500) => 0.1147858537,
   (f_estimated_income_d > 28500) => -0.0171070072,
   (f_estimated_income_d = NULL) => -0.0130308481, -0.0130308481),
(f_addrchangeincomediff_d = NULL) => -0.0042963967, 0.0018193671);

// Tree: 517 
final_score_517 := map(
(NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 135.5) => 0.0028759129,
(f_fp_prevaddrburglaryindex_i > 135.5) => 
   map(
   (NULL < inq_lastseen_n and inq_lastseen_n <= 5.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Daughter','Grandfather','Grandmother','Grandparent','Husband','Neighbor','Parent','Relative','Sibling','Sister','Subject','Subject at Household','Wife']) => -0.0047469663,
      (phone_subject_title in ['Associate By Property','Child','Father','Grandchild','Granddaughter','Grandson','Mother','Son','Spouse']) => 0.1267395298,
      (phone_subject_title = '') => 0.0016565968, 0.0016565968),
   (inq_lastseen_n > 5.5) => -0.0347812585,
   (inq_lastseen_n = NULL) => -0.0156492104, -0.0156492104),
(f_fp_prevaddrburglaryindex_i = NULL) => -0.0038519458, -0.0038519458);

// Tree: 518 
final_score_518 := map(
(NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 400.5) => 0.0079786198,
(eda_max_days_interrupt > 400.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Grandmother','Grandson','Husband','Mother','Relative','Sibling','Son','Spouse','Subject']) => 
      map(
      (NULL < eda_days_in_service and eda_days_in_service <= 86) => 0.0443650810,
      (eda_days_in_service > 86) => -0.0549681138,
      (eda_days_in_service = NULL) => -0.0422028328, -0.0422028328),
   (phone_subject_title in ['Associate By Address','Associate By Property','Brother','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Neighbor','Parent','Sister','Subject at Household','Wife']) => 0.0188434046,
   (phone_subject_title = '') => -0.0154372600, -0.0154372600),
(eda_max_days_interrupt = NULL) => 0.0031974428, 0.0031974428);

// Tree: 519 
final_score_519 := map(
(pp_src in ['CY','E1','E2','EM','EN','EQ','FA','LP','PL','SL','UT','VO','ZT']) => -0.0066232801,
(pp_src in ['FF','KW','LA','MD','NW','TN','UW','VW','ZK']) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 5.5) => 
      map(
      (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 7.5) => -0.0989845699,
      (mth_pp_datevendorfirstseen > 7.5) => 0.0411243229,
      (mth_pp_datevendorfirstseen = NULL) => -0.0053439531, -0.0053439531),
   (f_srchaddrsrchcount_i > 5.5) => 0.1083482885,
   (f_srchaddrsrchcount_i = NULL) => 0.0372012568, 0.0372012568),
(pp_src = '') => 0.0017845914, 0.0018423914);

// Tree: 520 
final_score_520 := map(
(NULL < _phone_match_code_z and _phone_match_code_z <= 0.5) => -0.0170818295,
(_phone_match_code_z > 0.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Brother','Daughter','Father','Grandfather','Grandmother','Grandson','Husband','Neighbor','Parent','Spouse','Subject','Subject at Household','Wife']) => 0.0013134945,
   (phone_subject_title in ['Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Grandchild','Granddaughter','Grandparent','Mother','Relative','Sibling','Sister','Son']) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 5.5) => 0.1701283561,
      (f_corraddrnamecount_d > 5.5) => 0.0090851699,
      (f_corraddrnamecount_d = NULL) => 0.0857724014, 0.0857724014),
   (phone_subject_title = '') => 0.0053361764, 0.0053361764),
(_phone_match_code_z = NULL) => -0.0036188121, -0.0036188121);

// Tree: 521 
final_score_521 := map(
(NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 72) => 
   map(
   (NULL < f_college_income_d and f_college_income_d <= 3.5) => 0.0997272657,
   (f_college_income_d > 3.5) => -0.0428312615,
   (f_college_income_d = NULL) => 
      map(
      (NULL < mth_source_sx_fseen and mth_source_sx_fseen <= 5.5) => 0.0162689365,
      (mth_source_sx_fseen > 5.5) => 0.0804481117,
      (mth_source_sx_fseen = NULL) => 0.0195655069, 0.0195655069), 0.0141837693),
(f_fp_prevaddrburglaryindex_i > 72) => -0.0072670336,
(f_fp_prevaddrburglaryindex_i = NULL) => -0.0006259182, -0.0006259182);

// Tree: 522 
final_score_522 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 8.5) => 
   map(
   (NULL < inq_num_adls_06 and inq_num_adls_06 <= 1.5) => -0.0010030363,
   (inq_num_adls_06 > 1.5) => 
      map(
      (phone_subject_title in ['Brother','Father','Neighbor','Parent','Sibling','Sister','Son','Subject']) => -0.0352167920,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Relative','Spouse','Subject at Household','Wife']) => 0.1799604267,
      (phone_subject_title = '') => 0.0702622368, 0.0702622368),
   (inq_num_adls_06 = NULL) => -0.0000849942, -0.0000849942),
(f_rel_homeover500_count_d > 8.5) => -0.0686049027,
(f_rel_homeover500_count_d = NULL) => -0.0011834244, -0.0011834244);

// Tree: 523 
final_score_523 := map(
(NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => 0.0002934022,
(_pp_rule_high_vend_conf > 0.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 97.5) => -0.0019545390,
   (f_curraddrcrimeindex_i > 97.5) => 
      map(
      (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 1.5) => 0.0281138953,
      (f_rel_incomeover100_count_d > 1.5) => 0.1396591065,
      (f_rel_incomeover100_count_d = NULL) => 0.0413845474, 0.0413845474),
   (f_curraddrcrimeindex_i = NULL) => 0.0195596051, 0.0195596051),
(_pp_rule_high_vend_conf = NULL) => 0.0032873453, 0.0032873453);

// Tree: 524 
final_score_524 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 20149.5) => 0.0118621794,
   (f_addrchangeincomediff_d > 20149.5) => -0.0210840727,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 4.5) => 0.0110711999,
      (f_inq_per_ssn_i > 4.5) => 0.1293781975,
      (f_inq_per_ssn_i = NULL) => 0.0174142233, 0.0174142233), 0.0072583120),
(f_util_adl_count_n > 3.5) => -0.0136787191,
(f_util_adl_count_n = NULL) => -0.0001234499, -0.0001234499);

// Tree: 525 
final_score_525 := map(
(NULL < f_estimated_income_d and f_estimated_income_d <= 119500) => 0.0015491687,
(f_estimated_income_d > 119500) => 
   map(
   (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 2.5) => 0.1420072502,
   (f_addrchangeecontrajindex_d > 2.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 93202.5) => -0.0219784534,
      (f_addrchangevaluediff_d > 93202.5) => 0.0756765374,
      (f_addrchangevaluediff_d = NULL) => 0.0303367202, 0.0303367202),
   (f_addrchangeecontrajindex_d = NULL) => 0.0648530659, 0.0648530659),
(f_estimated_income_d = NULL) => 0.0028425247, 0.0028425247);

// Tree: 526 
final_score_526 := map(
(NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 8.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 262.5) => 0.0063171562,
   (f_prevaddrlenofres_d > 262.5) => -0.0242156394,
   (f_prevaddrlenofres_d = NULL) => 0.0022366122, 0.0022366122),
(mth_source_rel_fseen > 8.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.3289493692245) => -0.1191531562,
   (f_add_curr_mobility_index_n > 0.3289493692245) => 0.0086325274,
   (f_add_curr_mobility_index_n = NULL) => -0.0402519287, -0.0402519287),
(mth_source_rel_fseen = NULL) => 0.0014369269, 0.0014369269);

// Tree: 527 
final_score_527 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 4.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 22.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.30874042134391) => -0.0103576056,
      (f_add_curr_mobility_index_n > 0.30874042134391) => 0.0095777508,
      (f_add_curr_mobility_index_n = NULL) => 0.0017269775, 0.0017269775),
   (f_addrchangecrimediff_i > 22.5) => -0.0293098577,
   (f_addrchangecrimediff_i = NULL) => -0.0034238298, -0.0060402940),
(f_rel_ageover40_count_d > 4.5) => 0.0084956044,
(f_rel_ageover40_count_d = NULL) => -0.0009031815, -0.0009031815);

// Tree: 528 
final_score_528 := map(
(NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 1.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By SSN','Brother','Daughter','Father','Grandfather','Grandmother','Husband','Mother','Neighbor','Sibling','Sister','Son']) => -0.0377117868,
   (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Grandchild','Granddaughter','Grandparent','Grandson','Parent','Relative','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 131) => 0.1272226944,
      (f_prevaddrmurderindex_i > 131) => -0.0097853859,
      (f_prevaddrmurderindex_i = NULL) => 0.0823273913, 0.0823273913),
   (phone_subject_title = '') => 0.0404019431, 0.0404019431),
(f_sourcerisktype_i > 1.5) => -0.0024059964,
(f_sourcerisktype_i = NULL) => -0.0009642233, -0.0009642233);

// Tree: 529 
final_score_529 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 0.5) => 
   map(
   (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => 
      map(
      (NULL < source_eda_any_clean and source_eda_any_clean <= 0.5) => -0.0147399909,
      (source_eda_any_clean > 0.5) => 0.0938703899,
      (source_eda_any_clean = NULL) => -0.0088381438, -0.0088381438),
   (_phone_match_code_n > 0.5) => 0.0377328019,
   (_phone_match_code_n = NULL) => 0.0073504764, 0.0073504764),
(f_util_adl_count_n > 0.5) => -0.0100703779,
(f_util_adl_count_n = NULL) => -0.0056892789, -0.0056892789);

// Tree: 530 
final_score_530 := map(
(NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 12.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 0.5) => 
      map(
      (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 18.5) => -0.0154938382,
      (mth_source_utildid_fseen > 18.5) => 0.0394438953,
      (mth_source_utildid_fseen = NULL) => -0.0119009064, -0.0119009064),
   (f_srchaddrsrchcount_i > 0.5) => 0.0086388629,
   (f_srchaddrsrchcount_i = NULL) => 0.0016248456, 0.0016248456),
(f_inq_per_ssn_i > 12.5) => -0.1101428303,
(f_inq_per_ssn_i = NULL) => 0.0007944766, 0.0007944766);

// Tree: 531 
final_score_531 := map(
(NULL < f_util_add_curr_misc_n and f_util_add_curr_misc_n <= 0.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 35060) => 0.0225809123,
   (f_addrchangeincomediff_d > 35060) => -0.0406173639,
   (f_addrchangeincomediff_d = NULL) => 0.0119597338, 0.0140846918),
(f_util_add_curr_misc_n > 0.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Daughter','Grandfather','Grandparent','Grandson','Husband','Mother','Neighbor','Relative','Sibling','Son','Subject','Subject at Household']) => -0.0152261007,
   (phone_subject_title in ['Associate','Associate By SSN','Child','Father','Grandchild','Granddaughter','Grandmother','Parent','Sister','Spouse','Wife']) => 0.0223309117,
   (phone_subject_title = '') => -0.0106491071, -0.0106491071),
(f_util_add_curr_misc_n = NULL) => -0.0020492424, -0.0020492424);

// Tree: 532 
final_score_532 := map(
(NULL < pp_total_source_conf and pp_total_source_conf <= 25.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 26.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By Vehicle','Brother','Father','Grandmother','Grandparent','Husband','Mother','Neighbor','Parent','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0157479434,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By SSN','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandson','Relative']) => 0.1824387526,
      (phone_subject_title = '') => 0.0236093441, 0.0236093441),
   (f_mos_inq_banko_om_fseen_d > 26.5) => -0.0017420033,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0018982391, 0.0018982391),
(pp_total_source_conf > 25.5) => -0.0559955599,
(pp_total_source_conf = NULL) => 0.0011742082, 0.0011742082);

// Tree: 533 
final_score_533 := map(
(eda_pfrd_address_ind in ['1A','1B','1D','1E','XX']) => -0.0000278586,
(eda_pfrd_address_ind in ['1C']) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Grandfather','Grandmother','Neighbor','Parent','Sibling','Sister','Son','Wife']) => -0.0064003198,
   (phone_subject_title in ['Associate By Property','Daughter','Father','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Mother','Relative','Spouse','Subject','Subject at Household']) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 1.5) => 0.1540340982,
      (f_util_adl_count_n > 1.5) => 0.0513714674,
      (f_util_adl_count_n = NULL) => 0.0914645658, 0.0914645658),
   (phone_subject_title = '') => 0.0371238004, 0.0371238004),
(eda_pfrd_address_ind = '') => 0.0017202383, 0.0017202383);

// Tree: 534 
final_score_534 := map(
(NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => -0.0076185541,
(f_sourcerisktype_i > 5.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Child','Granddaughter','Husband','Mother','Neighbor','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 2.5) => -0.0786848491,
      (f_rel_under500miles_cnt_d > 2.5) => 0.0178931491,
      (f_rel_under500miles_cnt_d = NULL) => 0.0099174118, 0.0099174118),
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Vehicle','Brother','Daughter','Father','Grandchild','Grandfather','Grandmother','Grandparent','Grandson','Parent']) => 0.1594312162,
   (phone_subject_title = '') => 0.0163004723, 0.0163004723),
(f_sourcerisktype_i = NULL) => -0.0017217263, -0.0017217263);

// Tree: 535 
final_score_535 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 6.5) => 0.0087386227,
(f_rel_incomeover50_count_d > 6.5) => 
   map(
   (NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 4.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 9.5) => 0.0591941293,
      (f_fp_prevaddrburglaryindex_i > 9.5) => -0.0113814721,
      (f_fp_prevaddrburglaryindex_i = NULL) => -0.0064129145, -0.0064129145),
   (mth_source_ppla_fseen > 4.5) => -0.0571902495,
   (mth_source_ppla_fseen = NULL) => -0.0095296437, -0.0095296437),
(f_rel_incomeover50_count_d = NULL) => 0.0010095661, 0.0010095661);

// Tree: 536 
final_score_536 := map(
(NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 6.5) => 0.0016646623,
(mth_source_rel_fseen > 6.5) => 
   map(
   (NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 29.5) => -0.0945685830,
   (eda_max_days_interrupt > 29.5) => 
      map(
      (NULL < eda_min_days_interrupt and eda_min_days_interrupt <= 1.5) => 0.0551761596,
      (eda_min_days_interrupt > 1.5) => -0.0552356646,
      (eda_min_days_interrupt = NULL) => 0.0019418872, 0.0019418872),
   (eda_max_days_interrupt = NULL) => -0.0338428939, -0.0338428939),
(mth_source_rel_fseen = NULL) => 0.0008820539, 0.0008820539);

// Tree: 537 
final_score_537 := map(
(NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 4.5) => 
   map(
   (NULL < number_of_sources and number_of_sources <= 1.5) => 0.0011976452,
   (number_of_sources > 1.5) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 3.5) => 0.0881804159,
      (f_inq_count24_i > 3.5) => -0.0271125808,
      (f_inq_count24_i = NULL) => 0.0554087764, 0.0554087764),
   (number_of_sources = NULL) => 0.0156144488, 0.0156144488),
(f_rel_homeover50_count_d > 4.5) => -0.0034606511,
(f_rel_homeover50_count_d = NULL) => -0.0008595011, -0.0008595011);

// Tree: 538 
final_score_538 := map(
(NULL < number_of_sources and number_of_sources <= 3.5) => 
   map(
   (NULL < mth_source_pf_fseen and mth_source_pf_fseen <= 2.5) => 0.0017386751,
   (mth_source_pf_fseen > 2.5) => -0.1135050723,
   (mth_source_pf_fseen = NULL) => 0.0009473914, 0.0009473914),
(number_of_sources > 3.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 5.5) => 0.0517289617,
   (f_srchssnsrchcount_i > 5.5) => -0.0510545407,
   (f_srchssnsrchcount_i = NULL) => 0.0364697863, 0.0364697863),
(number_of_sources = NULL) => 0.0025176607, 0.0025176607);

// Tree: 539 
final_score_539 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 8.5) => 0.0071719899,
(f_addrchangecrimediff_i > 8.5) => -0.0144513586,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (pp_src in ['E1','E2','EN','EQ','LP','SL','VO']) => -0.0502691500,
   (pp_src in ['CY','EM','FA','FF','KW','LA','MD','NW','PL','TN','UT','UW','VW','ZK','ZT']) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 61) => 0.0055244814,
      (r_pb_order_freq_d > 61) => 0.1080945569,
      (r_pb_order_freq_d = NULL) => 0.0235465092, 0.0306552086),
   (pp_src = '') => -0.0091653305, -0.0041999021), -0.0016602339);

// Tree: 540 
final_score_540 := map(
(NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 11.5) => 
   map(
   (pp_source in ['GONG','OTHER','THRIVE']) => -0.0974673217,
   (pp_source in ['CELL','HEADER','IBEHAVIOR','INFUTOR','INQUIRY','INTRADO','PCNSR','TARGUS']) => 
      map(
      (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 6.5) => 0.0517329695,
      (mth_pp_datevendorfirstseen > 6.5) => 0.0002346437,
      (mth_pp_datevendorfirstseen = NULL) => 0.0101604787, 0.0101604787),
   (pp_source = '') => -0.0009255224, 0.0028183451),
(mth_source_ppth_lseen > 11.5) => -0.0702622065,
(mth_source_ppth_lseen = NULL) => -0.0002583498, -0.0002583498);

// Tree: 541 
final_score_541 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 184.5) => -0.0057957121,
(r_pb_order_freq_d > 184.5) => 0.0275584975,
(r_pb_order_freq_d = NULL) => 
   map(
   (exp_source in ['P']) => -0.0537090105,
   (exp_source in ['S']) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -17.5) => -0.0635641914,
      (f_addrchangecrimediff_i > -17.5) => 0.0357471107,
      (f_addrchangecrimediff_i = NULL) => -0.0162512632, -0.0023999903),
   (exp_source = '') => 0.0116247225, 0.0072713360), 0.0028637580);

// Tree: 542 
final_score_542 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 9.5) => -0.0021902577,
(mth_source_ppdid_lseen > 9.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 109.5) => -0.0453411951,
   (f_prevaddrageoldest_d > 109.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 60.5) => -0.0262173246,
      (f_mos_inq_banko_cm_lseen_d > 60.5) => 0.0344126627,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0010833941, 0.0010833941),
   (f_prevaddrageoldest_d = NULL) => -0.0240355166, -0.0240355166),
(mth_source_ppdid_lseen = NULL) => -0.0063396667, -0.0063396667);

// Tree: 543 
final_score_543 := map(
(pp_src in ['E1','E2','EN','EQ','KW','LP','PL','VW']) => -0.0674749564,
(pp_src in ['CY','EM','FA','FF','LA','MD','NW','SL','TN','UT','UW','VO','ZK','ZT']) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -3856) => -0.0435355805,
   (f_addrchangeincomediff_d > -3856) => 
      map(
      (NULL < _pp_origlistingtype_res and _pp_origlistingtype_res <= 0.5) => 0.0423790533,
      (_pp_origlistingtype_res > 0.5) => -0.0190105814,
      (_pp_origlistingtype_res = NULL) => 0.0114947617, 0.0114947617),
   (f_addrchangeincomediff_d = NULL) => 0.0130138180, -0.0031654218),
(pp_src = '') => 0.0044185362, 0.0012381451);

// Tree: 544 
final_score_544 := map(
(NULL < mth_source_paw_lseen and mth_source_paw_lseen <= 1.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 10.5) => 0.0057335290,
   (f_corraddrnamecount_d > 10.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Daughter','Father','Grandfather','Grandmother','Mother','Relative','Sibling','Sister','Spouse','Subject at Household']) => -0.0585479416,
      (phone_subject_title in ['Associate By Address','Associate By Property','Child','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Neighbor','Parent','Son','Subject','Wife']) => 0.0060418641,
      (phone_subject_title = '') => -0.0191020245, -0.0191020245),
   (f_corraddrnamecount_d = NULL) => 0.0022245319, 0.0022245319),
(mth_source_paw_lseen > 1.5) => 0.0563306109,
(mth_source_paw_lseen = NULL) => 0.0032227743, 0.0032227743);

// Tree: 545 
final_score_545 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 2.5) => 
   map(
   (pp_src in ['CY','E1','E2','EQ','FA','TN','UT','ZT']) => -0.0915513613,
   (pp_src in ['EM','EN','FF','KW','LA','LP','MD','NW','PL','SL','UW','VO','VW','ZK']) => 0.0462475068,
   (pp_src = '') => -0.0135921772, -0.0212223016),
(f_rel_under100miles_cnt_d > 2.5) => 
   map(
   (pp_did_type in ['AMBIG','C_MERGE','CORE']) => 0.0036000250,
   (pp_did_type in ['INACTIVE','NO_SSN']) => 0.0981020745,
   (pp_did_type = '') => 0.0006298013, 0.0028682081),
(f_rel_under100miles_cnt_d = NULL) => 0.0001735202, 0.0001735202);

// Tree: 546 
final_score_546 := map(
(NULL < f_accident_count_i and f_accident_count_i <= 1.5) => -0.0004405881,
(f_accident_count_i > 1.5) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Father','Grandfather','Grandmother','Grandparent','Husband','Neighbor','Parent','Relative','Sister','Spouse','Subject at Household']) => -0.0491674447,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Grandson','Mother','Sibling','Son','Subject','Wife']) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.261400072326435) => 0.0231776470,
      (f_add_input_mobility_index_n > 0.261400072326435) => 0.0788381657,
      (f_add_input_mobility_index_n = NULL) => 0.0698549807, 0.0698549807),
   (phone_subject_title = '') => 0.0318799456, 0.0318799456),
(f_accident_count_i = NULL) => 0.0014285994, 0.0014285994);

// Tree: 547 
final_score_547 := map(
(NULL < _internal_ver_match_hhid and _internal_ver_match_hhid <= 0.5) => -0.0021560372,
(_internal_ver_match_hhid > 0.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 61.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 59.5) => -0.0384517358,
      (f_fp_prevaddrburglaryindex_i > 59.5) => 0.0339770638,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0128213901, 0.0128213901),
   (mth_source_ppdid_fseen > 61.5) => 0.0986258991,
   (mth_source_ppdid_fseen = NULL) => 0.0255661013, 0.0255661013),
(_internal_ver_match_hhid = NULL) => -0.0001685287, -0.0001685287);

// Tree: 548 
final_score_548 := map(
(NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 7.5) => 0.0056599281,
(mth_pp_first_build_date > 7.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -1) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 9.5) => 0.0004035471,
      (f_rel_ageover30_count_d > 9.5) => -0.0795120864,
      (f_rel_ageover30_count_d = NULL) => -0.0390353370, -0.0390353370),
   (f_addrchangecrimediff_i > -1) => 0.0076623017,
   (f_addrchangecrimediff_i = NULL) => -0.0429648316, -0.0226313619),
(mth_pp_first_build_date = NULL) => -0.0001132327, -0.0001132327);

// Tree: 549 
final_score_549 := map(
(NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 1.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By SSN','Brother','Father','Grandfather','Grandmother','Husband','Mother','Neighbor','Sibling','Sister','Son','Spouse']) => -0.0587420806,
   (phone_subject_title in ['Associate','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandparent','Grandson','Parent','Relative','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 6.5) => 0.1346869961,
      (f_corraddrnamecount_d > 6.5) => 0.0226788642,
      (f_corraddrnamecount_d = NULL) => 0.0743749251, 0.0743749251),
   (phone_subject_title = '') => 0.0316064092, 0.0316064092),
(f_sourcerisktype_i > 1.5) => -0.0044333043,
(f_sourcerisktype_i = NULL) => -0.0033219869, -0.0033219869);

// Tree: 550 
final_score_550 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 10.5) => 0.0049448211,
(f_corraddrnamecount_d > 10.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 20) => 
      map(
      (NULL < pk_phone_match_level and pk_phone_match_level <= 3.5) => -0.0014543966,
      (pk_phone_match_level > 3.5) => 0.1006415660,
      (pk_phone_match_level = NULL) => 0.0353001499, 0.0353001499),
   (f_fp_prevaddrburglaryindex_i > 20) => -0.0267666287,
   (f_fp_prevaddrburglaryindex_i = NULL) => -0.0189034389, -0.0189034389),
(f_corraddrnamecount_d = NULL) => 0.0014480608, 0.0014480608);

// Tree: 551 
final_score_551 := map(
(NULL < f_divssnidmsrcurelcount_i and f_divssnidmsrcurelcount_i <= 2.5) => 
   map(
   (NULL < pp_did_score and pp_did_score <= 99.5) => 0.0064089836,
   (pp_did_score > 99.5) => 
      map(
      (NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 120.5) => 0.0356879443,
      (f_mos_acc_lseen_d > 120.5) => -0.0333240233,
      (f_mos_acc_lseen_d = NULL) => -0.0205866737, -0.0205866737),
   (pp_did_score = NULL) => 0.0031586590, 0.0031586590),
(f_divssnidmsrcurelcount_i > 2.5) => -0.0746905234,
(f_divssnidmsrcurelcount_i = NULL) => 0.0020886665, 0.0020886665);

// Tree: 552 
final_score_552 := map(
(exp_type in ['N']) => 
   map(
   (NULL < eda_address_match_best and eda_address_match_best <= 0.5) => 0.0497156739,
   (eda_address_match_best > 0.5) => 0.2901402463,
   (eda_address_match_best = NULL) => 0.1239136878, 0.1239136878),
(exp_type in ['C']) => 0.1769543749,
(exp_type = '') => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => -0.0537490499,
   (source_rel > 0.5) => 0.2435462559,
   (source_rel = NULL) => -0.0383129173, -0.0383129173), -0.0005154844);

// Tree: 553 
final_score_553 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 23.5) => 0.0051911961,
(mth_exp_last_update > 23.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 2.5) => 
      map(
      (phone_subject_title in ['Brother','Grandfather','Neighbor','Relative','Subject','Subject at Household','Wife']) => -0.0136546334,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Mother','Parent','Sibling','Sister','Son','Spouse']) => 0.1181713010,
      (phone_subject_title = '') => 0.0110351737, 0.0110351737),
   (f_util_adl_count_n > 2.5) => -0.0774363413,
   (f_util_adl_count_n = NULL) => -0.0268570239, -0.0268570239),
(mth_exp_last_update = NULL) => 0.0031157603, 0.0031157603);

// Tree: 554 
final_score_554 := map(
(NULL < source_rel and source_rel <= 0.5) => 0.0002526231,
(source_rel > 0.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0580916685,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 2.5) => -0.0667632502,
      (f_rel_homeover200_count_d > 2.5) => 0.0344683907,
      (f_rel_homeover200_count_d = NULL) => -0.0106179704, -0.0106179704),
   (f_rel_felony_count_i = NULL) => 0.0328557209, 0.0328557209),
(source_rel = NULL) => 0.0015606225, 0.0015606225);

// Tree: 555 
final_score_555 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 33549.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 69.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By SSN','Daughter','Grandfather','Husband','Mother','Relative','Sibling','Sister','Spouse','Subject','Wife']) => -0.0738927492,
      (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Neighbor','Parent','Son','Subject at Household']) => 0.0097556996,
      (phone_subject_title = '') => -0.0471252456, -0.0471252456),
   (f_curraddrcartheftindex_i > 69.5) => -0.0078479967,
   (f_curraddrcartheftindex_i = NULL) => -0.0173328433, -0.0173328433),
(f_prevaddrmedianincome_d > 33549.5) => 0.0008166931,
(f_prevaddrmedianincome_d = NULL) => -0.0036038292, -0.0036038292);

// Tree: 556 
final_score_556 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 27.5) => -0.0018070232,
(f_srchaddrsrchcount_i > 27.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 2.5) => 0.1005533886,
   (f_srchvelocityrisktype_i > 2.5) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 175247.5) => -0.0292592332,
      (f_curraddrmedianvalue_d > 175247.5) => 0.0604383343,
      (f_curraddrmedianvalue_d = NULL) => 0.0028398963, 0.0028398963),
   (f_srchvelocityrisktype_i = NULL) => 0.0346022956, 0.0346022956),
(f_srchaddrsrchcount_i = NULL) => 0.0001904168, 0.0001904168);

// Tree: 557 
final_score_557 := map(
(NULL < _phone_timezone_match and _phone_timezone_match <= 0.5) => -0.0366155566,
(_phone_timezone_match > 0.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 3.5) => 0.0146692541,
   (f_srchaddrsrchcount_i > 3.5) => 
      map(
      (NULL < mth_exp_last_update and mth_exp_last_update <= 18.5) => -0.0009603813,
      (mth_exp_last_update > 18.5) => -0.0431486194,
      (mth_exp_last_update = NULL) => -0.0048250555, -0.0048250555),
   (f_srchaddrsrchcount_i = NULL) => 0.0064023791, 0.0064023791),
(_phone_timezone_match = NULL) => 0.0027429782, 0.0027429782);

// Tree: 558 
final_score_558 := map(
(NULL < f_wealth_index_d and f_wealth_index_d <= 3.5) => 
   map(
   (NULL < source_sp and source_sp <= 0.5) => -0.0128748181,
   (source_sp > 0.5) => 0.0795617953,
   (source_sp = NULL) => -0.0102685584, -0.0102685584),
(f_wealth_index_d > 3.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 66300) => -0.0840257754,
   (f_curraddrmedianvalue_d > 66300) => 0.0156560134,
   (f_curraddrmedianvalue_d = NULL) => 0.0118745525, 0.0118745525),
(f_wealth_index_d = NULL) => -0.0014497045, -0.0014497045);

// Tree: 559 
final_score_559 := map(
(NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Vehicle','Brother','Daughter','Grandmother','Grandson','Husband','Sister','Son','Spouse']) => -0.0546871915,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Child','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Mother','Neighbor','Parent','Relative','Sibling','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < mth_phone_fb_rp_date and mth_phone_fb_rp_date <= 34.5) => 0.0145087869,
      (mth_phone_fb_rp_date > 34.5) => -0.1036096894,
      (mth_phone_fb_rp_date = NULL) => 0.0123208746, 0.0123208746),
   (phone_subject_title = '') => 0.0072767696, 0.0072767696),
(f_sourcerisktype_i > 4.5) => -0.0090356591,
(f_sourcerisktype_i = NULL) => -0.0000735187, -0.0000735187);

// Tree: 560 
final_score_560 := map(
(NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 6.5) => 
   map(
   (NULL < _pp_src_all_ib and _pp_src_all_ib <= 0.5) => 0.0015947163,
   (_pp_src_all_ib > 0.5) => 
      map(
      (NULL < source_ppdid and source_ppdid <= 0.5) => -0.0023099522,
      (source_ppdid > 0.5) => 0.1055852762,
      (source_ppdid = NULL) => 0.0438567561, 0.0438567561),
   (_pp_src_all_ib = NULL) => 0.0049874235, 0.0049874235),
(f_rel_ageover30_count_d > 6.5) => -0.0115123224,
(f_rel_ageover30_count_d = NULL) => -0.0062029779, -0.0062029779);

// Tree: 561 
final_score_561 := map(
(NULL < mth_source_ppca_lseen and mth_source_ppca_lseen <= 6.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Father','Grandfather','Grandson','Neighbor','Relative','Sibling','Sister','Subject','Wife']) => 0.0013034715,
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By SSN','Brother','Child','Daughter','Grandchild','Granddaughter','Grandmother','Grandparent','Husband','Mother','Parent','Son','Spouse','Subject at Household']) => 0.0226637283,
   (phone_subject_title = '') => 0.0062561092, 0.0062561092),
(mth_source_ppca_lseen > 6.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 23.5) => -0.0358077865,
   (mth_source_utildid_fseen > 23.5) => 0.0556716587,
   (mth_source_utildid_fseen = NULL) => -0.0297655510, -0.0297655510),
(mth_source_ppca_lseen = NULL) => 0.0028796361, 0.0028796361);

// Tree: 562 
final_score_562 := map(
(NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 1.5) => 
   map(
   (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 898.5) => 
      map(
      (NULL < source_rel and source_rel <= 0.5) => -0.0134295012,
      (source_rel > 0.5) => -0.0797943257,
      (source_rel = NULL) => -0.0151344015, -0.0151344015),
   (eda_avg_days_interrupt > 898.5) => 0.1294861859,
   (eda_avg_days_interrupt = NULL) => -0.0104091085, -0.0104091085),
(f_rel_homeover100_count_d > 1.5) => 0.0030246655,
(f_rel_homeover100_count_d = NULL) => -0.0005993681, -0.0005993681);

// Tree: 563 
final_score_563 := map(
(NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 6.5) => -0.0029028696,
(f_sourcerisktype_i > 6.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 6) => 
      map(
      (NULL < f_estimated_income_d and f_estimated_income_d <= 51000) => 0.0170262884,
      (f_estimated_income_d > 51000) => 0.1749328844,
      (f_estimated_income_d = NULL) => 0.0908527489, 0.0908527489),
   (r_pb_order_freq_d > 6) => -0.0193227181,
   (r_pb_order_freq_d = NULL) => 0.0139406662, 0.0241043817),
(f_sourcerisktype_i = NULL) => -0.0002640186, -0.0002640186);

// Tree: 564 
final_score_564 := map(
(NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 25.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 27.5) => -0.0020047138,
   (mth_source_ppdid_fseen > 27.5) => -0.0566888235,
   (mth_source_ppdid_fseen = NULL) => -0.0038615312, -0.0038615312),
(mth_pp_datefirstseen > 25.5) => 
   map(
   (pp_src in ['CY','E1','EM','EN','KW','NW','PL','VO','ZT']) => -0.0599613170,
   (pp_src in ['E2','EQ','FA','FF','LA','LP','MD','SL','TN','UT','UW','VW','ZK']) => 0.0316165355,
   (pp_src = '') => 0.0135605723, 0.0141620010),
(mth_pp_datefirstseen = NULL) => -0.0004291151, -0.0004291151);

// Tree: 565 
final_score_565 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 35.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By SSN','Associate By Vehicle','Brother','Daughter','Grandmother','Grandparent','Grandson','Mother','Neighbor','Parent','Sibling','Sister','Subject at Household','Wife']) => -0.0122396236,
   (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Child','Father','Grandchild','Granddaughter','Grandfather','Husband','Relative','Son','Spouse','Subject']) => 0.0097720622,
   (phone_subject_title = '') => -0.0009903387, -0.0009903387),
(inq_adl_lastseen_n > 35.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 136.5) => -0.0065737586,
   (f_prevaddrlenofres_d > 136.5) => -0.0935696669,
   (f_prevaddrlenofres_d = NULL) => -0.0370223265, -0.0370223265),
(inq_adl_lastseen_n = NULL) => -0.0023288227, -0.0023288227);

// Tree: 566 
final_score_566 := map(
(pp_src in ['E1','EM','EQ','LP','NW','UT','UW']) => 
   map(
   (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 6.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 43524.5) => -0.0405206164,
      (f_prevaddrmedianincome_d > 43524.5) => 0.0634993841,
      (f_prevaddrmedianincome_d = NULL) => 0.0235166964, 0.0235166964),
   (mth_pp_datevendorfirstseen > 6.5) => -0.0288805256,
   (mth_pp_datevendorfirstseen = NULL) => -0.0157195279, -0.0157195279),
(pp_src in ['CY','E2','EN','FA','FF','KW','LA','MD','PL','SL','TN','VO','VW','ZK','ZT']) => 0.0240986103,
(pp_src = '') => 0.0048335259, 0.0023355214);

// Tree: 567 
final_score_567 := map(
(NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 5.5) => -0.0084678465,
(f_crim_rel_under500miles_cnt_i > 5.5) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 51) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Brother','Grandson','Husband','Neighbor','Relative','Sibling','Sister','Son','Subject','Wife']) => 0.0371053515,
      (phone_subject_title in ['Associate','Associate By Property','Associate By SSN','Associate By Vehicle','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Mother','Parent','Spouse','Subject at Household']) => 0.1397079093,
      (phone_subject_title = '') => 0.0602621788, 0.0602621788),
   (f_curraddrburglaryindex_i > 51) => 0.0012310182,
   (f_curraddrburglaryindex_i = NULL) => 0.0132288829, 0.0132288829),
(f_crim_rel_under500miles_cnt_i = NULL) => -0.0046496317, -0.0046496317);

// Tree: 568 
final_score_568 := map(
(NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 88.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.45650182303758) => -0.0014013951,
   (f_add_curr_mobility_index_n > 0.45650182303758) => 0.0123495528,
   (f_add_curr_mobility_index_n = NULL) => 0.0549605786, 0.0024641070),
(mth_pp_datefirstseen > 88.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 108) => 0.0035751427,
   (r_pb_order_freq_d > 108) => -0.0814426087,
   (r_pb_order_freq_d = NULL) => -0.0546694704, -0.0338028777),
(mth_pp_datefirstseen = NULL) => 0.0008743952, 0.0008743952);

// Tree: 569 
final_score_569 := map(
(NULL < f_estimated_income_d and f_estimated_income_d <= 84500) => -0.0013165112,
(f_estimated_income_d > 84500) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Grandmother','Husband','Neighbor','Parent','Sibling','Son','Spouse','Subject at Household','Wife']) => -0.0244955106,
   (phone_subject_title in ['Associate','Associate By Property','Brother','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Mother','Relative','Sister','Subject']) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 77) => 0.0143696078,
      (f_mos_inq_banko_cm_fseen_d > 77) => 0.0709319573,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0364572799, 0.0364572799),
   (phone_subject_title = '') => 0.0145266306, 0.0145266306),
(f_estimated_income_d = NULL) => 0.0010064956, 0.0010064956);

// Tree: 570 
final_score_570 := map(
(NULL < eda_num_ph_owners_hist and eda_num_ph_owners_hist <= 5.5) => 
   map(
   (NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 4.5) => -0.0014074502,
   (mth_source_rel_fseen > 4.5) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 0.5) => -0.0337828580,
      (f_rel_homeover300_count_d > 0.5) => 0.0568448902,
      (f_rel_homeover300_count_d = NULL) => 0.0249501462, 0.0249501462),
   (mth_source_rel_fseen = NULL) => -0.0006331027, -0.0006331027),
(eda_num_ph_owners_hist > 5.5) => -0.0809537053,
(eda_num_ph_owners_hist = NULL) => -0.0017370634, -0.0017370634);

// Tree: 571 
final_score_571 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -48719) => -0.0524850701,
(f_addrchangeincomediff_d > -48719) => -0.0021288935,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 10.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 97589) => 0.0042588860,
      (f_curraddrmedianincome_d > 97589) => 0.0805292695,
      (f_curraddrmedianincome_d = NULL) => 0.0091196868, 0.0091196868),
   (mth_pp_first_build_date > 10.5) => -0.0485143903,
   (mth_pp_first_build_date = NULL) => 0.0008821612, 0.0008821612), -0.0026745609);

// Tree: 572 
final_score_572 := map(
(NULL < f_vardobcount_i and f_vardobcount_i <= 2.5) => -0.0022105322,
(f_vardobcount_i > 2.5) => 
   map(
   (NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 322.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By SSN','Daughter','Father','Grandfather','Grandmother','Mother','Neighbor','Relative','Sibling','Sister','Spouse','Wife']) => -0.0097306865,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Parent','Son','Subject','Subject at Household']) => 0.0536775425,
      (phone_subject_title = '') => 0.0320034570, 0.0320034570),
   (eda_max_days_interrupt > 322.5) => -0.0445761768,
   (eda_max_days_interrupt = NULL) => 0.0156796151, 0.0156796151),
(f_vardobcount_i = NULL) => -0.0006618990, -0.0006618990);

// Tree: 573 
final_score_573 := map(
(NULL < f_rel_count_i and f_rel_count_i <= 66.5) => 
   map(
   (NULL < _pp_app_nonpub_targ_la and _pp_app_nonpub_targ_la <= 0.5) => -0.0029313031,
   (_pp_app_nonpub_targ_la > 0.5) => 
      map(
      (NULL < source_ppla and source_ppla <= 0.5) => 0.0167016176,
      (source_ppla > 0.5) => 0.1048753098,
      (source_ppla = NULL) => 0.0333381633, 0.0333381633),
   (_pp_app_nonpub_targ_la = NULL) => -0.0017334705, -0.0017334705),
(f_rel_count_i > 66.5) => 0.1153589201,
(f_rel_count_i = NULL) => -0.0009939397, -0.0009939397);

// Tree: 574 
final_score_574 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 12.5) => 0.0058131783,
(mth_source_ppdid_lseen > 12.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 5.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 223295.5) => -0.0186541878,
      (f_prevaddrmedianvalue_d > 223295.5) => 0.0385061426,
      (f_prevaddrmedianvalue_d = NULL) => -0.0074306999, -0.0074306999),
   (f_rel_homeover300_count_d > 5.5) => -0.0513619031,
   (f_rel_homeover300_count_d = NULL) => -0.0152699581, -0.0152699581),
(mth_source_ppdid_lseen = NULL) => 0.0021531291, 0.0021531291);

// Tree: 575 
final_score_575 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 27.5) => -0.0009149501,
(f_srchaddrsrchcount_i > 27.5) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 1.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 17110) => 0.0301747973,
      (f_addrchangevaluediff_d > 17110) => 0.1393914616,
      (f_addrchangevaluediff_d = NULL) => 0.0628590957, 0.0664278759),
   (f_crim_rel_under25miles_cnt_i > 1.5) => -0.0027534752,
   (f_crim_rel_under25miles_cnt_i = NULL) => 0.0340244327, 0.0340244327),
(f_srchaddrsrchcount_i = NULL) => 0.0009369454, 0.0009369454);

// Tree: 576 
final_score_576 := map(
(phone_subject_title in ['Associate','Associate By Address','Child','Father','Grandmother','Grandparent','Grandson','Neighbor','Parent','Relative','Sibling','Son','Subject','Subject at Household']) => -0.0057320187,
(phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Daughter','Grandchild','Granddaughter','Grandfather','Husband','Mother','Sister','Spouse','Wife']) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 176.5) => 0.0127824442,
   (f_curraddrcrimeindex_i > 176.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 185.5) => 0.2604496219,
      (f_curraddrcrimeindex_i > 185.5) => 0.0386337870,
      (f_curraddrcrimeindex_i = NULL) => 0.1206928242, 0.1206928242),
   (f_curraddrcrimeindex_i = NULL) => 0.0277411748, 0.0277411748),
(phone_subject_title = '') => -0.0005593410, -0.0005593410);

// Tree: 577 
final_score_577 := map(
(eda_pfrd_address_ind in ['1A','1B','1D','1E','XX']) => -0.0034244151,
(eda_pfrd_address_ind in ['1C']) => 
   map(
   (NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 8) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Child','Father','Grandfather','Grandmother','Grandparent','Neighbor','Parent','Sibling','Son','Subject at Household']) => -0.0144407256,
      (phone_subject_title in ['Associate','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Grandson','Husband','Mother','Relative','Sister','Spouse','Subject','Wife']) => 0.0928901407,
      (phone_subject_title = '') => 0.0508325912, 0.0508325912),
   (r_mos_since_paw_fseen_d > 8) => -0.0770223770,
   (r_mos_since_paw_fseen_d = NULL) => 0.0294677924, 0.0294677924),
(eda_pfrd_address_ind = '') => -0.0018645196, -0.0018645196);

// Tree: 578 
final_score_578 := map(
(NULL < eda_days_ind_first_seen and eda_days_ind_first_seen <= 747.5) => 0.0040937955,
(eda_days_ind_first_seen > 747.5) => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 4110.5) => -0.0784163468,
   (eda_days_ph_first_seen > 4110.5) => 
      map(
      (NULL < mth_source_edadid_fseen and mth_source_edadid_fseen <= 11.5) => -0.0245222612,
      (mth_source_edadid_fseen > 11.5) => 0.0702744831,
      (mth_source_edadid_fseen = NULL) => 0.0153198487, 0.0153198487),
   (eda_days_ph_first_seen = NULL) => -0.0306247397, -0.0306247397),
(eda_days_ind_first_seen = NULL) => 0.0023484110, 0.0023484110);

// Tree: 579 
final_score_579 := map(
(NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 16) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 9.5) => 
      map(
      (NULL < f_inq_adls_per_addr_i and f_inq_adls_per_addr_i <= 0.5) => -0.0356293427,
      (f_inq_adls_per_addr_i > 0.5) => 0.0446585441,
      (f_inq_adls_per_addr_i = NULL) => -0.0140809039, -0.0140809039),
   (f_srchaddrsrchcount_i > 9.5) => -0.1032406152,
   (f_srchaddrsrchcount_i = NULL) => -0.0295996714, -0.0295996714),
(f_curraddrburglaryindex_i > 16) => 0.0015789307,
(f_curraddrburglaryindex_i = NULL) => -0.0007722046, -0.0007722046);

// Tree: 580 
final_score_580 := map(
(NULL < inq_num and inq_num <= 6.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -23052.5) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 14.5) => -0.0096015519,
      (f_rel_under500miles_cnt_d > 14.5) => -0.0869817566,
      (f_rel_under500miles_cnt_d = NULL) => -0.0300704812, -0.0300704812),
   (f_addrchangeincomediff_d > -23052.5) => 0.0047412985,
   (f_addrchangeincomediff_d = NULL) => 0.0079927847, 0.0020252306),
(inq_num > 6.5) => -0.0599090422,
(inq_num = NULL) => 0.0013043513, 0.0013043513);

// Tree: 581 
final_score_581 := map(
(NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0041485690,
(_pp_rule_high_vend_conf > 0.5) => 
   map(
   (NULL < subject_ssn_mismatch and subject_ssn_mismatch <= -0.5) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 1.5) => 0.0831220963,
      (f_inq_count24_i > 1.5) => 0.0201926191,
      (f_inq_count24_i = NULL) => 0.0458305543, 0.0458305543),
   (subject_ssn_mismatch > -0.5) => 0.0040109241,
   (subject_ssn_mismatch = NULL) => 0.0155780559, 0.0155780559),
(_pp_rule_high_vend_conf = NULL) => -0.0010488802, -0.0010488802);

// Tree: 582 
final_score_582 := map(
(NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => 
   map(
   (NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 25.5) => 
      map(
      (phone_subject_title in ['Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Father','Grandfather','Neighbor','Parent','Relative','Sister','Subject','Subject at Household','Wife']) => 0.0327364853,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Vehicle','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Mother','Sibling','Son','Spouse']) => 0.1586657142,
      (phone_subject_title = '') => 0.0648484387, 0.0648484387),
   (f_mos_acc_lseen_d > 25.5) => 0.0079497577,
   (f_mos_acc_lseen_d = NULL) => 0.0111936962, 0.0111936962),
(f_util_add_input_conv_n > 0.5) => -0.0067674584,
(f_util_add_input_conv_n = NULL) => 0.0010343903, 0.0010343903);

// Tree: 583 
final_score_583 := map(
(NULL < eda_num_phs_connected_addr and eda_num_phs_connected_addr <= 1.5) => 
   map(
   (NULL < eda_num_phs_connected_ind and eda_num_phs_connected_ind <= 0.5) => -0.0002665798,
   (eda_num_phs_connected_ind > 0.5) => 
      map(
      (NULL < f_estimated_income_d and f_estimated_income_d <= 68500) => 0.0771233441,
      (f_estimated_income_d > 68500) => -0.0220579716,
      (f_estimated_income_d = NULL) => 0.0437203103, 0.0437203103),
   (eda_num_phs_connected_ind = NULL) => 0.0007988657, 0.0007988657),
(eda_num_phs_connected_addr > 1.5) => -0.0958874671,
(eda_num_phs_connected_addr = NULL) => -0.0004941165, -0.0004941165);

// Tree: 584 
final_score_584 := map(
(NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 209.5) => 0.0009446554,
(r_mos_since_paw_fseen_d > 209.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 7.5) => 
      map(
      (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 2342.5) => -0.0544544853,
      (eda_days_ph_first_seen > 2342.5) => 0.0741479659,
      (eda_days_ph_first_seen = NULL) => 0.0258404462, 0.0258404462),
   (mth_source_ppdid_fseen > 7.5) => 0.1169483676,
   (mth_source_ppdid_fseen = NULL) => 0.0445763494, 0.0445763494),
(r_mos_since_paw_fseen_d = NULL) => 0.0022846752, 0.0022846752);

// Tree: 585 
final_score_585 := map(
(pp_src in ['E1','EQ','KW','PL','SL']) => -0.0703973798,
(pp_src in ['CY','E2','EM','EN','FA','FF','LA','LP','MD','NW','TN','UT','UW','VO','VW','ZK','ZT']) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 13.5) => 0.0948980582,
   (mth_pp_app_npa_last_change_dt > 13.5) => 
      map(
      (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 10.5) => 0.0267669053,
      (mth_pp_datevendorfirstseen > 10.5) => -0.0246122085,
      (mth_pp_datevendorfirstseen = NULL) => -0.0071619931, -0.0071619931),
   (mth_pp_app_npa_last_change_dt = NULL) => -0.0018163254, -0.0018163254),
(pp_src = '') => -0.0012563470, -0.0023415064);

// Tree: 586 
final_score_586 := map(
(NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 10.5) => 0.0026741547,
(mth_pp_first_build_date > 10.5) => 
   map(
   (NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 81.5) => 
      map(
      (NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => 0.0010755840,
      (f_util_add_input_conv_n > 0.5) => -0.0437171287,
      (f_util_add_input_conv_n = NULL) => -0.0241534325, -0.0241534325),
   (mth_source_ppfla_fseen > 81.5) => 0.0806704585,
   (mth_source_ppfla_fseen = NULL) => -0.0195919055, -0.0195919055),
(mth_pp_first_build_date = NULL) => -0.0004937134, -0.0004937134);

// Tree: 587 
final_score_587 := map(
(NULL < f_accident_count_i and f_accident_count_i <= 1.5) => -0.0027197359,
(f_accident_count_i > 1.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Vehicle','Child','Daughter','Father','Grandmother','Husband','Neighbor','Parent','Relative','Sibling','Sister','Spouse','Subject at Household']) => -0.0462928182,
   (phone_subject_title in ['Associate','Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Mother','Son','Subject','Wife']) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.56732346048295) => 0.0499697750,
      (f_add_input_mobility_index_n > 0.56732346048295) => 0.1162613207,
      (f_add_input_mobility_index_n = NULL) => 0.0662477702, 0.0662477702),
   (phone_subject_title = '') => 0.0237655614, 0.0237655614),
(f_accident_count_i = NULL) => -0.0012339353, -0.0012339353);

// Tree: 588 
final_score_588 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 7.5) => -0.0025500233,
(f_rel_ageover40_count_d > 7.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.359467784357015) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 7.5) => 0.1083014055,
      (f_prevaddrlenofres_d > 7.5) => 0.0181134126,
      (f_prevaddrlenofres_d = NULL) => 0.0258543439, 0.0258543439),
   (f_add_input_mobility_index_n > 0.359467784357015) => 0.0051612305,
   (f_add_input_mobility_index_n = NULL) => 0.0166330925, 0.0166330925),
(f_rel_ageover40_count_d = NULL) => 0.0006507403, 0.0006507403);

// Tree: 589 
final_score_589 := map(
(NULL < _pp_rule_ins_ver_above and _pp_rule_ins_ver_above <= 0.5) => -0.0018451454,
(_pp_rule_ins_ver_above > 0.5) => 
   map(
   (NULL < source_ppdid and source_ppdid <= 0.5) => -0.0222264816,
   (source_ppdid > 0.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.32530636475427) => 0.1245314092,
      (f_add_input_mobility_index_n > 0.32530636475427) => 0.0425565674,
      (f_add_input_mobility_index_n = NULL) => 0.0676778899, 0.0676778899),
   (source_ppdid = NULL) => 0.0362580230, 0.0362580230),
(_pp_rule_ins_ver_above = NULL) => -0.0004816219, -0.0004816219);

// Tree: 590 
final_score_590 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 71219) => -0.0042253743,
(f_addrchangeincomediff_d > 71219) => 0.0671678825,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 36.5) => 
      map(
      (pp_src in ['CY','E1','E2','EM','EN','LP','NW','UT','VO','ZT']) => -0.0347629442,
      (pp_src in ['EQ','FA','FF','KW','LA','MD','PL','SL','TN','UW','VW','ZK']) => 0.0239402045,
      (pp_src = '') => 0.0042257980, -0.0001800039),
   (mth_source_utildid_fseen > 36.5) => 0.0736956512,
   (mth_source_utildid_fseen = NULL) => 0.0025493922, 0.0025493922), -0.0015411956);

// Tree: 591 
final_score_591 := map(
(NULL < source_ppfa and source_ppfa <= 0.5) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 26.5) => -0.0031598675,
   (f_rel_educationover12_count_d > 26.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Daughter','Mother','Parent','Sibling','Sister','Son','Spouse','Subject at Household','Wife']) => -0.0412483522,
      (phone_subject_title in ['Associate','Associate By Property','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Relative','Subject']) => 0.0713962221,
      (phone_subject_title = '') => 0.0211628309, 0.0211628309),
   (f_rel_educationover12_count_d = NULL) => -0.0020272978, -0.0020272978),
(source_ppfa > 0.5) => 0.0564611130,
(source_ppfa = NULL) => -0.0013030728, -0.0013030728);

// Tree: 592 
final_score_592 := map(
(NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 89.5) => -0.0009578971,
(mth_source_cr_fseen > 89.5) => 
   map(
   (NULL < _phone_match_code_lns and _phone_match_code_lns <= 0.5) => 
      map(
      (NULL < inq_lastseen_n and inq_lastseen_n <= 19.5) => -0.0321084670,
      (inq_lastseen_n > 19.5) => 0.1320519881,
      (inq_lastseen_n = NULL) => 0.0297050377, 0.0297050377),
   (_phone_match_code_lns > 0.5) => 0.1167452697,
   (_phone_match_code_lns = NULL) => 0.0511614670, 0.0511614670),
(mth_source_cr_fseen = NULL) => 0.0004296293, 0.0004296293);

// Tree: 593 
final_score_593 := map(
(NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 7.5) => 
   map(
   (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Associate By SSN','Daughter','Granddaughter','Grandson','Parent','Relative','Spouse','Subject at Household','Wife']) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 20057.5) => 0.0431549048,
      (f_prevaddrmedianincome_d > 20057.5) => -0.0256619321,
      (f_prevaddrmedianincome_d = NULL) => -0.0209799136, -0.0209799136),
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Vehicle','Brother','Child','Father','Grandchild','Grandfather','Grandmother','Grandparent','Husband','Mother','Neighbor','Sibling','Sister','Son','Subject']) => 0.0000766668,
   (phone_subject_title = '') => -0.0040891938, -0.0040891938),
(f_inq_per_ssn_i > 7.5) => -0.0550670488,
(f_inq_per_ssn_i = NULL) => -0.0053579591, -0.0053579591);

// Tree: 594 
final_score_594 := map(
(NULL < f_estimated_income_d and f_estimated_income_d <= 25500) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 45133) => 
      map(
      (NULL < eda_has_cur_discon_90_days and eda_has_cur_discon_90_days <= 0.5) => 0.0563484584,
      (eda_has_cur_discon_90_days > 0.5) => -0.0617523555,
      (eda_has_cur_discon_90_days = NULL) => 0.0081297829, 0.0081297829),
   (f_curraddrmedianincome_d > 45133) => 0.1644166274,
   (f_curraddrmedianincome_d = NULL) => 0.0529715779, 0.0529715779),
(f_estimated_income_d > 25500) => 0.0000023385,
(f_estimated_income_d = NULL) => 0.0015567850, 0.0015567850);

// Tree: 595 
final_score_595 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 143681.5) => 
   map(
   (NULL < f_vardobcount_i and f_vardobcount_i <= 3.5) => -0.0057927414,
   (f_vardobcount_i > 3.5) => -0.1003106213,
   (f_vardobcount_i = NULL) => -0.0073647644, -0.0073647644),
(f_curraddrmedianvalue_d > 143681.5) => 
   map(
   (pp_src in ['CY','E1','FA','LP','PL','SL','VO','VW','ZT']) => -0.0650798511,
   (pp_src in ['E2','EM','EN','EQ','FF','KW','LA','MD','NW','TN','UT','UW','ZK']) => 0.0146101677,
   (pp_src = '') => 0.0073567308, 0.0069078945),
(f_curraddrmedianvalue_d = NULL) => 0.0001073508, 0.0001073508);

// Tree: 596 
final_score_596 := map(
(NULL < eda_num_phs_discon_addr and eda_num_phs_discon_addr <= 6.5) => 
   map(
   (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0070221470,
   (_phone_match_code_n > 0.5) => 
      map(
      (phone_subject_title in ['Associate','Daughter','Mother','Parent','Sibling','Subject','Subject at Household']) => 0.0054773439,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Relative','Sister','Son','Spouse','Wife']) => 0.0887798165,
      (phone_subject_title = '') => 0.0077093244, 0.0077093244),
   (_phone_match_code_n = NULL) => -0.0008336762, -0.0008336762),
(eda_num_phs_discon_addr > 6.5) => -0.0927638815,
(eda_num_phs_discon_addr = NULL) => -0.0017443271, -0.0017443271);

// Tree: 597 
final_score_597 := map(
(NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 148.5) => -0.0052850432,
(f_prevaddrmurderindex_i > 148.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 130348) => 
      map(
      (NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 16.5) => 0.0242647033,
      (mth_source_ppfla_fseen > 16.5) => 0.0894308190,
      (mth_source_ppfla_fseen = NULL) => 0.0274024996, 0.0274024996),
   (f_curraddrmedianvalue_d > 130348) => -0.0097334246,
   (f_curraddrmedianvalue_d = NULL) => 0.0122656574, 0.0122656574),
(f_prevaddrmurderindex_i = NULL) => -0.0000274401, -0.0000274401);

// Tree: 598 
final_score_598 := map(
(NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 7.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Father','Grandson','Husband','Mother','Neighbor','Parent','Relative','Spouse','Subject','Subject at Household']) => 0.0072627852,
   (phone_subject_title in ['Associate By Business','Associate By Shared Associates','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Sibling','Sister','Son','Wife']) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 109) => 0.2254121983,
      (f_fp_prevaddrburglaryindex_i > 109) => 0.0156078790,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.1236136528, 0.1236136528),
   (phone_subject_title = '') => 0.0150317684, 0.0150317684),
(f_rel_homeover50_count_d > 7.5) => -0.0059301181,
(f_rel_homeover50_count_d = NULL) => 0.0006580521, 0.0006580521);

// Tree: 599 
final_score_599 := map(
(exp_type in ['N']) => 0.0523258642,
(exp_type in ['C']) => 0.0800490836,
(exp_type = '') => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => 
      map(
      (NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => -0.0382262505,
      (_inq_adl_ph_industry_flag > 0.5) => 0.1773926377,
      (_inq_adl_ph_industry_flag = NULL) => -0.0345208523, -0.0345208523),
   (source_rel > 0.5) => 0.0934464020,
   (source_rel = NULL) => -0.0278317000, -0.0278317000), -0.0089890725);

// Tree: 600 
final_score_600 := map(
(NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 69.5) => 
   map(
   (NULL < inq_num and inq_num <= 2.5) => -0.0015683135,
   (inq_num > 2.5) => 
      map(
      (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 23.5) => 0.0559442026,
      (inq_adl_lastseen_n > 23.5) => -0.0293562235,
      (inq_adl_lastseen_n = NULL) => 0.0266403147, 0.0266403147),
   (inq_num = NULL) => -0.0005312575, -0.0005312575),
(mth_source_utildid_fseen > 69.5) => -0.0736792792,
(mth_source_utildid_fseen = NULL) => -0.0012467966, -0.0012467966);

// Tree: 601 
final_score_601 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 6.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Daughter','Grandmother','Grandson','Husband','Mother','Neighbor','Parent','Subject']) => 0.0044390994,
   (phone_subject_title in ['Associate','Associate By Shared Associates','Child','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Relative','Sibling','Sister','Son','Spouse','Subject at Household','Wife']) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 50.5) => -0.0164637890,
      (f_curraddrcrimeindex_i > 50.5) => 0.0732690911,
      (f_curraddrcrimeindex_i = NULL) => 0.0512226508, 0.0512226508),
   (phone_subject_title = '') => 0.0143331595, 0.0143331595),
(f_rel_incomeover25_count_d > 6.5) => -0.0076837695,
(f_rel_incomeover25_count_d = NULL) => -0.0016808937, -0.0016808937);

// Tree: 602 
final_score_602 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -415078) => 0.0916181695,
(f_addrchangevaluediff_d > -415078) => 0.0012289800,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 18.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 0.5) => 0.0319207550,
      (f_rel_criminal_count_i > 0.5) => -0.0190570428,
      (f_rel_criminal_count_i = NULL) => -0.0076277454, -0.0076277454),
   (f_rel_under500miles_cnt_d > 18.5) => 0.0373573598,
   (f_rel_under500miles_cnt_d = NULL) => 0.0015277359, 0.0015277359), 0.0019205044);

// Tree: 603 
final_score_603 := map(
(NULL < mth_source_ppca_fseen and mth_source_ppca_fseen <= 6.5) => 0.0013504743,
(mth_source_ppca_fseen > 6.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 217.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 57) => 0.0342945705,
      (f_curraddrcartheftindex_i > 57) => -0.0303576265,
      (f_curraddrcartheftindex_i = NULL) => -0.0133011423, -0.0133011423),
   (f_prevaddrlenofres_d > 217.5) => -0.0815473662,
   (f_prevaddrlenofres_d = NULL) => -0.0219161980, -0.0219161980),
(mth_source_ppca_fseen = NULL) => -0.0012740847, -0.0012740847);

// Tree: 604 
final_score_604 := map(
(NULL < _pp_rule_low_vend_conf and _pp_rule_low_vend_conf <= 0.5) => 
   map(
   (NULL < source_ppfa and source_ppfa <= 0.5) => -0.0008157549,
   (source_ppfa > 0.5) => 0.0460825769,
   (source_ppfa = NULL) => -0.0002586408, -0.0002586408),
(_pp_rule_low_vend_conf > 0.5) => 
   map(
   (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 71) => 0.0034830939,
   (mth_pp_datefirstseen > 71) => 0.0971380145,
   (mth_pp_datefirstseen = NULL) => 0.0471504189, 0.0471504189),
(_pp_rule_low_vend_conf = NULL) => 0.0006982285, 0.0006982285);

// Tree: 605 
final_score_605 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 63765.5) => -0.0052396323,
(f_prevaddrmedianincome_d > 63765.5) => 
   map(
   (pp_app_coctype in ['EOC']) => -0.0309985698,
   (pp_app_coctype in ['PMC','RCC','SP2']) => 
      map(
      (NULL < inq_lastseen_n and inq_lastseen_n <= 1.5) => 0.0600832576,
      (inq_lastseen_n > 1.5) => 0.0019387849,
      (inq_lastseen_n = NULL) => 0.0346536419, 0.0346536419),
   (pp_app_coctype = '') => 0.0009402071, 0.0129606125),
(f_prevaddrmedianincome_d = NULL) => -0.0004551945, -0.0004551945);

// Tree: 606 
final_score_606 := map(
(NULL < number_of_sources and number_of_sources <= 1.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Subject','Wife']) => -0.0398073520,
   (phone_subject_title in ['Associate','Associate By Property','Father','Grandchild','Granddaughter','Spouse','Subject at Household']) => 0.0345427669,
   (phone_subject_title = '') => -0.0265751280, -0.0265751280),
(number_of_sources > 1.5) => 
   map(
   (exp_type in ['N']) => 0.0594225870,
   (exp_type in ['C']) => 0.0700541936,
   (exp_type = '') => 0.0206388940, 0.0415028460),
(number_of_sources = NULL) => -0.0087042384, -0.0087042384);

// Tree: 607 
final_score_607 := map(
(NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 4.5) => 
   map(
   (NULL < mth_source_md_fseen and mth_source_md_fseen <= 81.5) => 0.0001574299,
   (mth_source_md_fseen > 81.5) => -0.0678961232,
   (mth_source_md_fseen = NULL) => -0.0004468766, -0.0004468766),
(f_rel_ageover50_count_d > 4.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 3.5) => -0.0076231368,
   (f_srchaddrsrchcount_i > 3.5) => 0.1033707592,
   (f_srchaddrsrchcount_i = NULL) => 0.0346602522, 0.0346602522),
(f_rel_ageover50_count_d = NULL) => 0.0002857029, 0.0002857029);

// Tree: 608 
final_score_608 := map(
(NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 15.5) => 
   map(
   (NULL < pk_cell_indicator and pk_cell_indicator <= 1.5) => -0.0005839062,
   (pk_cell_indicator > 1.5) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 127.5) => -0.0042285703,
      (mth_pp_app_npa_effective_dt > 127.5) => 0.0274546119,
      (mth_pp_app_npa_effective_dt = NULL) => 0.0176379107, 0.0176379107),
   (pk_cell_indicator = NULL) => 0.0040140624, 0.0040140624),
(f_rel_homeover50_count_d > 15.5) => -0.0116702519,
(f_rel_homeover50_count_d = NULL) => -0.0006082523, -0.0006082523);

// Tree: 609 
final_score_609 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Father','Grandfather','Grandmother','Grandparent','Grandson','Neighbor','Sibling','Sister','Son','Subject','Subject at Household']) => -0.0020438316,
(phone_subject_title in ['Associate By Business','Associate By SSN','Grandchild','Granddaughter','Husband','Mother','Parent','Relative','Spouse','Wife']) => 
   map(
   (NULL < f_validationrisktype_i and f_validationrisktype_i <= 1.5) => 
      map(
      (NULL < pk_phone_match_level and pk_phone_match_level <= 0.5) => -0.0728632200,
      (pk_phone_match_level > 0.5) => 0.0300391932,
      (pk_phone_match_level = NULL) => 0.0102882501, 0.0102882501),
   (f_validationrisktype_i > 1.5) => 0.0891326904,
   (f_validationrisktype_i = NULL) => 0.0265138590, 0.0265138590),
(phone_subject_title = '') => 0.0002758619, 0.0002758619);

// Tree: 610 
final_score_610 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 23.5) => 0.0029739563,
(mth_exp_last_update > 23.5) => 
   map(
   (NULL < f_inq_lnames_per_addr_i and f_inq_lnames_per_addr_i <= 1.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 2.5) => 0.0169759331,
      (f_util_adl_count_n > 2.5) => -0.0491184215,
      (f_util_adl_count_n = NULL) => -0.0095571371, -0.0095571371),
   (f_inq_lnames_per_addr_i > 1.5) => -0.0813306930,
   (f_inq_lnames_per_addr_i = NULL) => -0.0246745275, -0.0246745275),
(mth_exp_last_update = NULL) => 0.0011697524, 0.0011697524);

// Tree: 611 
final_score_611 := map(
(NULL < f_vardobcount_i and f_vardobcount_i <= 2.5) => -0.0013758851,
(f_vardobcount_i > 2.5) => 
   map(
   (pp_source in ['CELL','HEADER','IBEHAVIOR','OTHER']) => 0.0054970633,
   (pp_source in ['GONG','INFUTOR','INQUIRY','INTRADO','PCNSR','TARGUS','THRIVE']) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 138.5) => 0.0360723021,
      (f_fp_prevaddrburglaryindex_i > 138.5) => 0.1280290447,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0652820910, 0.0652820910),
   (pp_source = '') => 0.0102234000, 0.0224002712),
(f_vardobcount_i = NULL) => 0.0007205389, 0.0007205389);

// Tree: 612 
final_score_612 := map(
(NULL < _pp_src_all_tn and _pp_src_all_tn <= 0.5) => 
   map(
   (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 88.5) => 
      map(
      (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 75.5) => 0.0023983573,
      (mth_pp_datefirstseen > 75.5) => 0.0406990500,
      (mth_pp_datefirstseen = NULL) => 0.0036815379, 0.0036815379),
   (mth_pp_datefirstseen > 88.5) => -0.0309600539,
   (mth_pp_datefirstseen = NULL) => 0.0021575496, 0.0021575496),
(_pp_src_all_tn > 0.5) => 0.0691486996,
(_pp_src_all_tn = NULL) => 0.0025888943, 0.0025888943);

// Tree: 613 
final_score_613 := map(
(NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 18.5) => 
   map(
   (NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0004147275,
   (_pp_rule_high_vend_conf > 0.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 102775) => 0.0166191883,
      (f_curraddrmedianincome_d > 102775) => 0.1318900457,
      (f_curraddrmedianincome_d = NULL) => 0.0241093622, 0.0241093622),
   (_pp_rule_high_vend_conf = NULL) => 0.0033225469, 0.0033225469),
(mth_source_ppth_lseen > 18.5) => -0.0679784302,
(mth_source_ppth_lseen = NULL) => 0.0006739222, 0.0006739222);

// Tree: 614 
final_score_614 := map(
(NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 66.5) => 0.0111917551,
(f_fp_prevaddrburglaryindex_i > 66.5) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 79.5) => 
      map(
      (exp_type in ['C']) => -0.0437972951,
      (exp_type in ['N']) => -0.0356214967,
      (exp_type = '') => -0.0124241741, -0.0177981778),
   (f_curraddrburglaryindex_i > 79.5) => 0.0022314600,
   (f_curraddrburglaryindex_i = NULL) => -0.0030309724, -0.0030309724),
(f_fp_prevaddrburglaryindex_i = NULL) => 0.0009549140, 0.0009549140);

// Tree: 615 
final_score_615 := map(
(NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 122.5) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 1.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 44299.5) => 0.0970403150,
      (f_curraddrmedianincome_d > 44299.5) => 0.0129116756,
      (f_curraddrmedianincome_d = NULL) => 0.0362987877, 0.0362987877),
   (f_sourcerisktype_i > 1.5) => 0.0040207657,
   (f_sourcerisktype_i = NULL) => 0.0050648530, 0.0050648530),
(mth_source_ppdid_fseen > 122.5) => 0.0642462961,
(mth_source_ppdid_fseen = NULL) => 0.0055704894, 0.0055704894);

// Tree: 616 
final_score_616 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 411041) => 
   map(
   (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 4.5) => -0.0028150692,
   (f_rel_ageover50_count_d > 4.5) => 0.0657516973,
   (f_rel_ageover50_count_d = NULL) => -0.0014846693, -0.0014846693),
(f_addrchangevaluediff_d > 411041) => -0.0600250298,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 894) => 0.0043734007,
   (eda_avg_days_interrupt > 894) => 0.0937529920,
   (eda_avg_days_interrupt = NULL) => 0.0069167224, 0.0069167224), 0.0001132055);

// Tree: 617 
final_score_617 := map(
(NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 5.5) => 
   map(
   (NULL < eda_min_days_interrupt and eda_min_days_interrupt <= 70.5) => -0.0003976715,
   (eda_min_days_interrupt > 70.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandmother','Husband','Neighbor','Relative','Sibling','Sister','Son','Subject']) => -0.0696569002,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Mother','Parent','Spouse','Subject at Household','Wife']) => 0.0494395502,
      (phone_subject_title = '') => -0.0466199956, -0.0466199956),
   (eda_min_days_interrupt = NULL) => -0.0019758543, -0.0019758543),
(f_srchaddrsrchcountmo_i > 5.5) => 0.0860315646,
(f_srchaddrsrchcountmo_i = NULL) => -0.0014200867, -0.0014200867);

// Tree: 618 
final_score_618 := map(
(NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 33.5) => 
   map(
   (NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 6.5) => -0.0055018479,
   (mth_internal_ver_first_seen > 6.5) => -0.0374566189,
   (mth_internal_ver_first_seen = NULL) => -0.0129725266, -0.0129725266),
(f_mos_inq_banko_om_lseen_d > 33.5) => 
   map(
   (NULL < inq_num_addresses_06 and inq_num_addresses_06 <= 1.5) => 0.0046484108,
   (inq_num_addresses_06 > 1.5) => -0.0858744836,
   (inq_num_addresses_06 = NULL) => 0.0037132569, 0.0037132569),
(f_mos_inq_banko_om_lseen_d = NULL) => -0.0009711606, -0.0009711606);

// Tree: 619 
final_score_619 := map(
(NULL < mth_source_ppca_lseen and mth_source_ppca_lseen <= 6.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 64543.5) => 0.0026288914,
   (f_addrchangevaluediff_d > 64543.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Brother','Child','Daughter','Grandmother','Husband','Neighbor','Parent','Sibling','Sister','Spouse','Subject','Wife']) => 0.0085776153,
      (phone_subject_title in ['Associate By Property','Associate By SSN','Associate By Vehicle','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Mother','Relative','Son','Subject at Household']) => 0.0681516188,
      (phone_subject_title = '') => 0.0199224842, 0.0199224842),
   (f_addrchangevaluediff_d = NULL) => 0.0010890422, 0.0048791818),
(mth_source_ppca_lseen > 6.5) => -0.0202964280,
(mth_source_ppca_lseen = NULL) => 0.0024507767, 0.0024507767);

// Tree: 620 
final_score_620 := map(
(pp_src in ['E1','EM','EQ','FA','LP','NW','UT','UW','VO','VW']) => 
   map(
   (phone_subject_title in ['Father','Neighbor','Relative','Subject at Household','Wife']) => -0.0371015884,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Parent','Sibling','Sister','Son','Spouse','Subject']) => 0.0079229908,
   (phone_subject_title = '') => 0.0025519605, 0.0025519605),
(pp_src in ['CY','E2','EN','FF','KW','LA','MD','PL','SL','TN','ZK','ZT']) => 0.0490821655,
(pp_src = '') => 
   map(
   (NULL < f_vardobcount_i and f_vardobcount_i <= 3.5) => -0.0038316653,
   (f_vardobcount_i > 3.5) => -0.0833050160,
   (f_vardobcount_i = NULL) => -0.0048494539, -0.0048494539), -0.0026568845);

// Tree: 621 
final_score_621 := map(
(eda_pfrd_address_ind in ['1A','1B','XX']) => -0.0005855603,
(eda_pfrd_address_ind in ['1C','1D','1E']) => 
   map(
   (NULL < eda_num_phs_discon_addr and eda_num_phs_discon_addr <= 2.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Brother','Grandparent','Husband','Neighbor','Sibling','Sister','Son']) => -0.0163092226,
      (phone_subject_title in ['Associate','Associate By SSN','Associate By Vehicle','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandson','Mother','Parent','Relative','Spouse','Subject','Subject at Household','Wife']) => 0.0784529742,
      (phone_subject_title = '') => 0.0470053425, 0.0470053425),
   (eda_num_phs_discon_addr > 2.5) => -0.0119855091,
   (eda_num_phs_discon_addr = NULL) => 0.0219379832, 0.0219379832),
(eda_pfrd_address_ind = '') => 0.0005104962, 0.0005104962);

// Tree: 622 
final_score_622 := map(
(NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 36.5) => 
   map(
   (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0061985309,
   (_phone_match_code_n > 0.5) => 0.0062552520,
   (_phone_match_code_n = NULL) => -0.0012007674, -0.0012007674),
(mth_source_ppfla_fseen > 36.5) => 
   map(
   (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => -0.0653641419,
   (f_prevaddrstatus_i > 2.5) => -0.0016811463,
   (f_prevaddrstatus_i = NULL) => 0.0028344054, -0.0267909455),
(mth_source_ppfla_fseen = NULL) => -0.0020214529, -0.0020214529);

// Tree: 623 
final_score_623 := map(
(eda_pfrd_address_ind in ['1A','1B','XX']) => -0.0004490096,
(eda_pfrd_address_ind in ['1C','1D','1E']) => 
   map(
   (NULL < eda_days_in_service and eda_days_in_service <= 523.5) => 0.0686898034,
   (eda_days_in_service > 523.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Grandfather','Grandmother','Neighbor','Parent','Sibling','Sister','Spouse','Wife']) => -0.0823512967,
      (phone_subject_title in ['Associate By Address','Associate By SSN','Daughter','Father','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Mother','Relative','Son','Subject','Subject at Household']) => 0.0403905172,
      (phone_subject_title = '') => -0.0080215927, -0.0080215927),
   (eda_days_in_service = NULL) => 0.0200671761, 0.0200671761),
(eda_pfrd_address_ind = '') => 0.0005569846, 0.0005569846);

// Tree: 624 
final_score_624 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 19678) => 0.0439309403,
(f_curraddrmedianvalue_d > 19678) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 11.5) => -0.0425935511,
   (f_mos_inq_banko_cm_lseen_d > 11.5) => 
      map(
      (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 1.5) => -0.0066353493,
      (f_rel_incomeover75_count_d > 1.5) => 0.0065194400,
      (f_rel_incomeover75_count_d = NULL) => -0.0005064329, -0.0005064329),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0017961737, -0.0017961737),
(f_curraddrmedianvalue_d = NULL) => -0.0007881952, -0.0007881952);

// Tree: 625 
final_score_625 := map(
(NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 3.5) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 102.5) => -0.0116805136,
   (f_curraddrburglaryindex_i > 102.5) => 
      map(
      (NULL < inq_lastseen_n and inq_lastseen_n <= 1.5) => 0.0170617502,
      (inq_lastseen_n > 1.5) => -0.0072260579,
      (inq_lastseen_n = NULL) => 0.0045316953, 0.0045316953),
   (f_curraddrburglaryindex_i = NULL) => -0.0033312508, -0.0033312508),
(f_crim_rel_under25miles_cnt_i > 3.5) => 0.0121901082,
(f_crim_rel_under25miles_cnt_i = NULL) => -0.0004113530, -0.0004113530);

// Tree: 626 
final_score_626 := map(
(phone_subject_title in ['Associate By Address','Child','Daughter','Father','Granddaughter','Grandson','Husband','Neighbor','Sister','Son','Spouse','Subject','Wife']) => -0.0017968442,
(phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Grandchild','Grandfather','Grandmother','Grandparent','Mother','Parent','Relative','Sibling','Subject at Household']) => 
   map(
   (NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 1277.5) => 0.0072933198,
   (eda_max_days_interrupt > 1277.5) => 
      map(
      (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 414) => 0.2189551777,
      (eda_avg_days_interrupt > 414) => 0.0395634099,
      (eda_avg_days_interrupt = NULL) => 0.0778436616, 0.0778436616),
   (eda_max_days_interrupt = NULL) => 0.0143014377, 0.0143014377),
(phone_subject_title = '') => 0.0029991521, 0.0029991521);

// Tree: 627 
final_score_627 := map(
(NULL < _phone_match_code_d and _phone_match_code_d <= 0.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 95.5) => 0.0016973236,
   (mth_source_ppdid_fseen > 95.5) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 8.5) => -0.0916101891,
      (f_rel_homeover100_count_d > 8.5) => 0.0213090881,
      (f_rel_homeover100_count_d = NULL) => -0.0512329930, -0.0512329930),
   (mth_source_ppdid_fseen = NULL) => 0.0005795069, 0.0005795069),
(_phone_match_code_d > 0.5) => 0.0480994562,
(_phone_match_code_d = NULL) => 0.0021270238, 0.0021270238);

// Tree: 628 
final_score_628 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 8.5) => 
   map(
   (NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 2.5) => -0.0018081242,
   (f_inq_per_ssn_i > 2.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Grandfather','Grandmother','Grandparent','Mother','Neighbor','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0138507673,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Vehicle','Child','Daughter','Father','Grandchild','Granddaughter','Grandson','Husband','Parent']) => 0.1184883364,
      (phone_subject_title = '') => 0.0184889575, 0.0184889575),
   (f_inq_per_ssn_i = NULL) => 0.0010863269, 0.0010863269),
(f_rel_homeover500_count_d > 8.5) => -0.0465848102,
(f_rel_homeover500_count_d = NULL) => 0.0002805508, 0.0002805508);

// Tree: 629 
final_score_629 := map(
(NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 6.5) => -0.0014791339,
(mth_source_rel_fseen > 6.5) => 
   map(
   (NULL < eda_days_in_service and eda_days_in_service <= 317.5) => -0.0756067934,
   (eda_days_in_service > 317.5) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 167542) => 0.0316937857,
      (f_curraddrmedianvalue_d > 167542) => -0.0360140361,
      (f_curraddrmedianvalue_d = NULL) => -0.0024825434, -0.0024825434),
   (eda_days_in_service = NULL) => -0.0324717021, -0.0324717021),
(mth_source_rel_fseen = NULL) => -0.0021622291, -0.0021622291);

// Tree: 630 
final_score_630 := map(
(NULL < _phone_timezone_match and _phone_timezone_match <= 0.5) => -0.0292475855,
(_phone_timezone_match > 0.5) => 
   map(
   (NULL < eda_days_in_service and eda_days_in_service <= 223.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Grandmother','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Subject','Subject at Household']) => 0.0087056292,
      (phone_subject_title in ['Associate By Property','Associate By Vehicle','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Son','Spouse','Wife']) => 0.1699881828,
      (phone_subject_title = '') => 0.0108872290, 0.0108872290),
   (eda_days_in_service > 223.5) => -0.0067103394,
   (eda_days_in_service = NULL) => 0.0031095734, 0.0031095734),
(_phone_timezone_match = NULL) => 0.0004772488, 0.0004772488);

// Tree: 631 
final_score_631 := map(
(NULL < f_wealth_index_d and f_wealth_index_d <= 4.5) => -0.0018979230,
(f_wealth_index_d > 4.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.2361891437208) => -0.0225666009,
   (f_add_input_mobility_index_n > 0.2361891437208) => 
      map(
      (NULL < _phone_timezone_match and _phone_timezone_match <= 0.5) => -0.0426508924,
      (_phone_timezone_match > 0.5) => 0.0405486185,
      (_phone_timezone_match = NULL) => 0.0318061129, 0.0318061129),
   (f_add_input_mobility_index_n = NULL) => 0.0192191590, 0.0192191590),
(f_wealth_index_d = NULL) => 0.0000634159, 0.0000634159);

// Tree: 632 
final_score_632 := map(
(NULL < r_paw_active_phone_ct_d and r_paw_active_phone_ct_d <= 1.5) => 0.0011593275,
(r_paw_active_phone_ct_d > 1.5) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 4.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 137643) => 0.0343535815,
      (f_prevaddrmedianvalue_d > 137643) => -0.0701595637,
      (f_prevaddrmedianvalue_d = NULL) => -0.0040390025, -0.0040390025),
   (f_rel_homeover200_count_d > 4.5) => 0.0746193072,
   (f_rel_homeover200_count_d = NULL) => 0.0339053230, 0.0339053230),
(r_paw_active_phone_ct_d = NULL) => 0.0023231789, 0.0023231789);

// Tree: 633 
final_score_633 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 25.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Brother','Child','Grandmother','Grandson','Neighbor','Relative','Sibling','Son','Subject','Wife']) => -0.0028721805,
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Husband','Mother','Parent','Sister','Spouse','Subject at Household']) => 
      map(
      (NULL < eda_min_days_interrupt and eda_min_days_interrupt <= 221) => 0.0122612146,
      (eda_min_days_interrupt > 221) => 0.1352322862,
      (eda_min_days_interrupt = NULL) => 0.0147877028, 0.0147877028),
   (phone_subject_title = '') => 0.0032397145, 0.0032397145),
(f_rel_under25miles_cnt_d > 25.5) => -0.0351157712,
(f_rel_under25miles_cnt_d = NULL) => 0.0017251182, 0.0017251182);

// Tree: 634 
final_score_634 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 22.5) => 
   map(
   (NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 17.5) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 19.5) => 0.0011574587,
      (f_inq_count24_i > 19.5) => 0.0720193386,
      (f_inq_count24_i = NULL) => 0.0019314137, 0.0019314137),
   (mth_source_rel_fseen > 17.5) => -0.0407263943,
   (mth_source_rel_fseen = NULL) => 0.0015821559, 0.0015821559),
(f_inq_count24_i > 22.5) => -0.0603938977,
(f_inq_count24_i = NULL) => 0.0005308038, 0.0005308038);

// Tree: 635 
final_score_635 := map(
(NULL < f_inq_lnames_per_addr_i and f_inq_lnames_per_addr_i <= 6.5) => -0.0003940045,
(f_inq_lnames_per_addr_i > 6.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Brother','Grandson','Husband','Neighbor','Relative','Sibling','Spouse','Subject','Wife']) => 
      map(
      (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 9.5) => -0.0487676713,
      (mth_pp_datefirstseen > 9.5) => 0.0774833885,
      (mth_pp_datefirstseen = NULL) => 0.0047427117, 0.0047427117),
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Mother','Parent','Sister','Son','Subject at Household']) => 0.1192808734,
   (phone_subject_title = '') => 0.0332347917, 0.0332347917),
(f_inq_lnames_per_addr_i = NULL) => 0.0004429678, 0.0004429678);

// Tree: 636 
final_score_636 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -7.5) => -0.0103659419,
(f_addrchangecrimediff_i > -7.5) => 0.0054436988,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 5.5) => 
      map(
      (NULL < f_wealth_index_d and f_wealth_index_d <= 2.5) => -0.0320377004,
      (f_wealth_index_d > 2.5) => 0.0687711344,
      (f_wealth_index_d = NULL) => 0.0381625113, 0.0381625113),
   (f_rel_ageover20_count_d > 5.5) => 0.0012767503,
   (f_rel_ageover20_count_d = NULL) => 0.0068288544, 0.0068288544), 0.0007082093);

// Tree: 637 
final_score_637 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 7.5) => 0.0051071996,
(f_srchaddrsrchcount_i > 7.5) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 12.5) => -0.0062705980,
   (mth_exp_last_update > 12.5) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 3.5) => 0.0171966616,
      (f_sourcerisktype_i > 3.5) => -0.0648326306,
      (f_sourcerisktype_i = NULL) => -0.0371097679, -0.0371097679),
   (mth_exp_last_update = NULL) => -0.0095698851, -0.0095698851),
(f_srchaddrsrchcount_i = NULL) => 0.0014374740, 0.0014374740);

// Tree: 638 
final_score_638 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 43.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By SSN','Brother','Father','Granddaughter','Grandmother','Grandson','Husband','Neighbor','Parent','Relative','Son','Subject','Wife']) => -0.0003352197,
   (phone_subject_title in ['Associate','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Grandchild','Grandfather','Grandparent','Mother','Sibling','Sister','Spouse','Subject at Household']) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.311964559707425) => -0.0037976950,
      (f_add_curr_mobility_index_n > 0.311964559707425) => 0.0561314351,
      (f_add_curr_mobility_index_n = NULL) => 0.0340617255, 0.0340617255),
   (phone_subject_title = '') => 0.0082864021, 0.0082864021),
(f_prevaddrlenofres_d > 43.5) => -0.0075339016,
(f_prevaddrlenofres_d = NULL) => -0.0022656915, -0.0022656915);

// Tree: 639 
final_score_639 := map(
(NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 209.5) => 
   map(
   (NULL < eda_days_ind_first_seen and eda_days_ind_first_seen <= 643) => 0.0019717451,
   (eda_days_ind_first_seen > 643) => 
      map(
      (NULL < eda_max_days_connected_ind and eda_max_days_connected_ind <= 756.5) => -0.0772786846,
      (eda_max_days_connected_ind > 756.5) => 0.0280936972,
      (eda_max_days_connected_ind = NULL) => -0.0485092514, -0.0485092514),
   (eda_days_ind_first_seen = NULL) => 0.0000267232, 0.0000267232),
(mth_source_inf_fseen > 209.5) => 0.0473401331,
(mth_source_inf_fseen = NULL) => 0.0011164080, 0.0011164080);

// Tree: 640 
final_score_640 := map(
(NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 3.5) => 0.0000387120,
(mth_source_ppla_lseen > 3.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 91969) => 
      map(
      (NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 25.5) => -0.0586902596,
      (mth_source_ppla_fseen > 25.5) => -0.0065879985,
      (mth_source_ppla_fseen = NULL) => -0.0288235594, -0.0288235594),
   (f_curraddrmedianincome_d > 91969) => 0.0457645681,
   (f_curraddrmedianincome_d = NULL) => -0.0203135046, -0.0203135046),
(mth_source_ppla_lseen = NULL) => -0.0010877666, -0.0010877666);

// Tree: 641 
final_score_641 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 2.5) => 
   map(
   (NULL < pk_cell_indicator and pk_cell_indicator <= 2.5) => 0.0044556812,
   (pk_cell_indicator > 2.5) => 0.0266677600,
   (pk_cell_indicator = NULL) => 0.0071375039, 0.0071375039),
(f_inq_count24_i > 2.5) => 
   map(
   (NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 2.5) => 0.0056557254,
   (mth_pp_first_build_date > 2.5) => -0.0263944508,
   (mth_pp_first_build_date = NULL) => -0.0066007205, -0.0066007205),
(f_inq_count24_i = NULL) => 0.0014302549, 0.0014302549);

// Tree: 642 
final_score_642 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 376.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 38.5) => 0.0114596266,
   (f_mos_inq_banko_om_fseen_d > 38.5) => -0.0028351979,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0013075406, 0.0013075406),
(f_prevaddrageoldest_d > 376.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 390.5) => 0.0978085544,
   (f_prevaddrlenofres_d > 390.5) => 0.0060419787,
   (f_prevaddrlenofres_d = NULL) => 0.0400959814, 0.0400959814),
(f_prevaddrageoldest_d = NULL) => 0.0025372422, 0.0025372422);

// Tree: 643 
final_score_643 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 175.5) => -0.0034727372,
(f_curraddrcrimeindex_i > 175.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Daughter','Father','Grandparent','Grandson','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household']) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 12.5) => 0.0009375772,
      (f_rel_educationover12_count_d > 12.5) => 0.0327979086,
      (f_rel_educationover12_count_d = NULL) => 0.0105630550, 0.0105630550),
   (phone_subject_title in ['Associate By Property','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Husband','Mother','Wife']) => 0.0963139814,
   (phone_subject_title = '') => 0.0159577142, 0.0159577142),
(f_curraddrcrimeindex_i = NULL) => -0.0009100832, -0.0009100832);

// Tree: 644 
final_score_644 := map(
(NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0048416893,
(_phone_match_code_n > 0.5) => 
   map(
   (phone_subject_title in ['Daughter','Grandfather','Grandmother','Sibling','Sister','Subject','Subject at Household']) => 0.0031575475,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Son','Spouse','Wife']) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.280324381262635) => 0.0845776600,
      (f_add_input_mobility_index_n > 0.280324381262635) => 0.0118039810,
      (f_add_input_mobility_index_n = NULL) => 0.0270259826, 0.0270259826),
   (phone_subject_title = '') => 0.0056158282, 0.0056158282),
(_phone_match_code_n = NULL) => -0.0004287101, -0.0004287101);

// Tree: 645 
final_score_645 := map(
(exp_type in ['N']) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 14.5) => 0.0296685588,
   (f_inq_count_i > 14.5) => -0.0525042578,
   (f_inq_count_i = NULL) => 0.0093421060, 0.0093421060),
(exp_type in ['C']) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 0.0553240429,
   (f_srchvelocityrisktype_i > 5.5) => -0.0105706458,
   (f_srchvelocityrisktype_i = NULL) => 0.0266293545, 0.0266293545),
(exp_type = '') => -0.0087942254, -0.0035143620);

// Tree: 646 
final_score_646 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 127.5) => -0.0035238519,
(f_curraddrcrimeindex_i > 127.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 68025.5) => 0.0052623523,
   (f_curraddrmedianincome_d > 68025.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Brother','Daughter','Neighbor','Relative','Sibling','Subject at Household']) => 0.0019828034,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Parent','Sister','Son','Spouse','Subject','Wife']) => 0.1208519854,
      (phone_subject_title = '') => 0.0660440392, 0.0660440392),
   (f_curraddrmedianincome_d = NULL) => 0.0086651488, 0.0086651488),
(f_curraddrcrimeindex_i = NULL) => 0.0009789083, 0.0009789083);

// Tree: 647 
final_score_647 := map(
(NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 13.5) => 0.0033044787,
(mth_source_inf_fseen > 13.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.50116782156031) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 6.5) => 0.0058976490,
      (r_pb_order_freq_d > 6.5) => 0.0224878537,
      (r_pb_order_freq_d = NULL) => -0.0333508295, -0.0030464816),
   (f_add_input_mobility_index_n > 0.50116782156031) => -0.0816935081,
   (f_add_input_mobility_index_n = NULL) => -0.0170957663, -0.0170957663),
(mth_source_inf_fseen = NULL) => 0.0019151604, 0.0019151604);

// Tree: 648 
final_score_648 := map(
(NULL < _pp_src_all_48 and _pp_src_all_48 <= 0.5) => 
   map(
   (NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 23.5) => 
      map(
      (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 138.5) => 0.0013271826,
      (mth_pp_datefirstseen > 138.5) => 0.0723192865,
      (mth_pp_datefirstseen = NULL) => 0.0018625007, 0.0018625007),
   (mth_source_rel_fseen > 23.5) => 0.0513907105,
   (mth_source_rel_fseen = NULL) => 0.0022147727, 0.0022147727),
(_pp_src_all_48 > 0.5) => -0.0799217300,
(_pp_src_all_48 = NULL) => 0.0015842052, 0.0015842052);

// Tree: 649 
final_score_649 := map(
(NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 4.5) => 0.0015999960,
(f_crim_rel_under25miles_cnt_i > 4.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By SSN','Associate By Vehicle','Child','Grandfather','Grandmother','Grandparent','Husband','Parent','Sister','Son','Subject at Household','Wife']) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 41048) => -0.0673838732,
      (f_addrchangevaluediff_d > 41048) => 0.0216904017,
      (f_addrchangevaluediff_d = NULL) => -0.0391958115, -0.0391958115),
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Brother','Daughter','Father','Grandchild','Granddaughter','Grandson','Mother','Neighbor','Relative','Sibling','Spouse','Subject']) => -0.0053702183,
   (phone_subject_title = '') => -0.0119253191, -0.0119253191),
(f_crim_rel_under25miles_cnt_i = NULL) => -0.0001844660, -0.0001844660);

// Tree: 650 
final_score_650 := map(
(NULL < pk_phone_match_level and pk_phone_match_level <= 1.5) => -0.0186616076,
(pk_phone_match_level > 1.5) => 
   map(
   (NULL < _phone_match_code_l and _phone_match_code_l <= 0.5) => 0.0625345728,
   (_phone_match_code_l > 0.5) => 
      map(
      (NULL < f_wealth_index_d and f_wealth_index_d <= 4.5) => 0.0004422185,
      (f_wealth_index_d > 4.5) => 0.0593436597,
      (f_wealth_index_d = NULL) => 0.0062735452, 0.0062735452),
   (_phone_match_code_l = NULL) => 0.0118417960, 0.0118417960),
(pk_phone_match_level = NULL) => -0.0039689082, -0.0039689082);

// Tree: 651 
final_score_651 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 3.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Parent','Sibling','Sister','Subject at Household','Wife']) => -0.0030838364,
   (phone_subject_title in ['Associate By Property','Father','Grandchild','Granddaughter','Grandparent','Relative','Son','Spouse','Subject']) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 55.5) => 0.0235485591,
      (inq_firstseen_n > 55.5) => 0.0999746231,
      (inq_firstseen_n = NULL) => 0.0314433605, 0.0314433605),
   (phone_subject_title = '') => 0.0095224791, 0.0095224791),
(f_inq_count_i > 3.5) => -0.0026254107,
(f_inq_count_i = NULL) => 0.0002461001, 0.0002461001);

// Tree: 652 
final_score_652 := map(
(NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 5.5) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 18.5) => 0.0005453037,
   (f_rel_under100miles_cnt_d > 18.5) => 
      map(
      (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 201.5) => 0.0269840564,
      (eda_avg_days_interrupt > 201.5) => -0.0321132696,
      (eda_avg_days_interrupt = NULL) => 0.0174324092, 0.0174324092),
   (f_rel_under100miles_cnt_d = NULL) => 0.0027811387, 0.0027811387),
(f_srchaddrsrchcountmo_i > 5.5) => 0.0906482872,
(f_srchaddrsrchcountmo_i = NULL) => 0.0033469004, 0.0033469004);

// Tree: 653 
final_score_653 := map(
(eda_pfrd_address_ind in ['1A','1E','XX']) => -0.0038938829,
(eda_pfrd_address_ind in ['1B','1C','1D']) => 
   map(
   (NULL < eda_num_ph_owners_hist and eda_num_ph_owners_hist <= 2.5) => 
      map(
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Grandfather','Husband','Neighbor','Parent','Son']) => -0.0395843225,
      (phone_subject_title in ['Associate','Associate By Address','Associate By SSN','Brother','Daughter','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Mother','Relative','Sibling','Sister','Spouse','Subject','Subject at Household','Wife']) => 0.0579564860,
      (phone_subject_title = '') => 0.0366623658, 0.0366623658),
   (eda_num_ph_owners_hist > 2.5) => -0.0278081359,
   (eda_num_ph_owners_hist = NULL) => 0.0198731727, 0.0198731727),
(eda_pfrd_address_ind = '') => -0.0021987586, -0.0021987586);

// Tree: 654 
final_score_654 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 783073.5) => 
   map(
   (pp_origphonetype in ['O','V','W']) => -0.0109964243,
   (pp_origphonetype in ['L']) => 0.0071019251,
   (pp_origphonetype = '') => 
      map(
      (NULL < _pp_agegroup and _pp_agegroup <= 1.5) => -0.0012189096,
      (_pp_agegroup > 1.5) => 0.0672391169,
      (_pp_agegroup = NULL) => -0.0004054995, -0.0004054995), -0.0028797327),
(f_curraddrmedianvalue_d > 783073.5) => 0.0659851728,
(f_curraddrmedianvalue_d = NULL) => -0.0024533246, -0.0024533246);

// Tree: 655 
final_score_655 := map(
(NULL < source_rel and source_rel <= 0.5) => 
   map(
   (pp_source in ['CELL','GONG','INTRADO','OTHER','PCNSR','TARGUS','THRIVE']) => -0.0498475209,
   (pp_source in ['HEADER','IBEHAVIOR','INFUTOR','INQUIRY']) => 0.0067576862,
   (pp_source = '') => -0.0085313197, -0.0030143703),
(source_rel > 0.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 0.5) => -0.0073084101,
   (f_rel_homeover300_count_d > 0.5) => 0.0609742844,
   (f_rel_homeover300_count_d = NULL) => 0.0340370746, 0.0340370746),
(source_rel = NULL) => -0.0015049690, -0.0015049690);

// Tree: 656 
final_score_656 := map(
(NULL < source_rel and source_rel <= 0.5) => 0.0007537688,
(source_rel > 0.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 17.5) => 0.0736076351,
   (f_prevaddrlenofres_d > 17.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => -0.0013391798,
      (f_srchfraudsrchcount_i > 6.5) => 0.0543750995,
      (f_srchfraudsrchcount_i = NULL) => 0.0103516854, 0.0103516854),
   (f_prevaddrlenofres_d = NULL) => 0.0200157888, 0.0200157888),
(source_rel = NULL) => 0.0016124027, 0.0016124027);

// Tree: 657 
final_score_657 := map(
(NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 18.5) => 
   map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 15.5) => 0.0023143406,
   (f_rel_incomeover50_count_d > 15.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Brother','Daughter','Father','Husband','Neighbor','Relative','Sibling','Sister','Son','Wife']) => 0.0019627706,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Parent','Spouse','Subject','Subject at Household']) => 0.1053723225,
      (phone_subject_title = '') => 0.0488318481, 0.0488318481),
   (f_rel_incomeover50_count_d = NULL) => 0.0032454946, 0.0032454946),
(f_rel_educationover12_count_d > 18.5) => -0.0171940200,
(f_rel_educationover12_count_d = NULL) => 0.0004526280, 0.0004526280);

// Tree: 658 
final_score_658 := map(
(NULL < source_eda_any_clean and source_eda_any_clean <= 0.5) => -0.0034820305,
(source_eda_any_clean > 0.5) => 
   map(
   (NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 1532.5) => 
      map(
      (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 0.5) => -0.0053195035,
      (f_rel_ageover50_count_d > 0.5) => 0.0431660527,
      (f_rel_ageover50_count_d = NULL) => 0.0078036532, 0.0078036532),
   (eda_max_days_interrupt > 1532.5) => 0.0883223177,
   (eda_max_days_interrupt = NULL) => 0.0156006189, 0.0156006189),
(source_eda_any_clean = NULL) => -0.0022131619, -0.0022131619);

// Tree: 659 
final_score_659 := map(
(NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 17.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Subject','Subject at Household']) => 0.0019254267,
   (phone_subject_title in ['Daughter','Grandchild','Grandfather','Mother','Spouse','Wife']) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 31.5) => 0.1094582154,
      (f_prevaddrlenofres_d > 31.5) => 0.0056074736,
      (f_prevaddrlenofres_d = NULL) => 0.0385532262, 0.0385532262),
   (phone_subject_title = '') => 0.0032546799, 0.0032546799),
(f_rel_incomeover75_count_d > 17.5) => -0.0767887909,
(f_rel_incomeover75_count_d = NULL) => 0.0027272925, 0.0027272925);

// Tree: 660 
final_score_660 := map(
(NULL < f_inq_per_addr_i and f_inq_per_addr_i <= 14.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 35.5) => 0.0009503144,
   (f_rel_ageover30_count_d > 35.5) => -0.0454932041,
   (f_rel_ageover30_count_d = NULL) => 0.0002394442, 0.0002394442),
(f_inq_per_addr_i > 14.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 29.5) => 0.0111358994,
   (r_pb_order_freq_d > 29.5) => -0.0625258758,
   (r_pb_order_freq_d = NULL) => -0.0701790705, -0.0382371839),
(f_inq_per_addr_i = NULL) => -0.0007515338, -0.0007515338);

// Tree: 661 
final_score_661 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 4.5) => -0.0060718963,
(f_rel_under25miles_cnt_d > 4.5) => 
   map(
   (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => 
      map(
      (NULL < subject_ssn_mismatch and subject_ssn_mismatch <= -0.5) => 0.0464088143,
      (subject_ssn_mismatch > -0.5) => 0.0078625125,
      (subject_ssn_mismatch = NULL) => 0.0204964944, 0.0204964944),
   (f_util_add_curr_conv_n > 0.5) => -0.0017399055,
   (f_util_add_curr_conv_n = NULL) => 0.0050382510, 0.0050382510),
(f_rel_under25miles_cnt_d = NULL) => 0.0015138715, 0.0015138715);

// Tree: 662 
final_score_662 := map(
(NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 1784.5) => -0.0028305922,
(eda_max_days_interrupt > 1784.5) => 
   map(
   (phone_subject_title in ['Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Mother','Neighbor','Parent','Sibling','Son','Wife']) => -0.0277158337,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Relative','Sister','Spouse','Subject','Subject at Household']) => 
      map(
      (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 12.5) => 0.0255341702,
      (f_rel_homeover50_count_d > 12.5) => 0.1109241594,
      (f_rel_homeover50_count_d = NULL) => 0.0652377958, 0.0652377958),
   (phone_subject_title = '') => 0.0224344063, 0.0224344063),
(eda_max_days_interrupt = NULL) => -0.0019202263, -0.0019202263);

// Tree: 663 
final_score_663 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.19920387968491) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 2.5) => -0.0130758303,
   (mth_exp_last_update > 2.5) => 
      map(
      (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 2.5) => -0.0760290947,
      (f_addrchangeecontrajindex_d > 2.5) => -0.0121615984,
      (f_addrchangeecontrajindex_d = NULL) => -0.0470395928, -0.0470395928),
   (mth_exp_last_update = NULL) => -0.0196903200, -0.0196903200),
(f_add_curr_mobility_index_n > 0.19920387968491) => 0.0006728286,
(f_add_curr_mobility_index_n = NULL) => 0.0308130102, -0.0008653247);

// Tree: 664 
final_score_664 := map(
(NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 5.5) => 0.0001616414,
(f_crim_rel_under25miles_cnt_i > 5.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Father','Grandmother','Grandparent','Husband','Parent','Sibling','Son','Subject','Subject at Household']) => 
      map(
      (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 12.5) => 0.0331766909,
      (f_rel_educationover8_count_d > 12.5) => -0.0408992413,
      (f_rel_educationover8_count_d = NULL) => -0.0332958019, -0.0332958019),
   (phone_subject_title in ['Associate By Property','Associate By SSN','Daughter','Grandchild','Granddaughter','Grandfather','Grandson','Mother','Neighbor','Relative','Sister','Spouse','Wife']) => 0.0414023236,
   (phone_subject_title = '') => -0.0197056850, -0.0197056850),
(f_crim_rel_under25miles_cnt_i = NULL) => -0.0017774767, -0.0017774767);

// Tree: 665 
final_score_665 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 16.5) => 0.0029167471,
(mth_exp_last_update > 16.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.397845621170065) => 
      map(
      (pp_source in ['GONG','HEADER','INQUIRY','OTHER','THRIVE']) => -0.0221295755,
      (pp_source in ['CELL','IBEHAVIOR','INFUTOR','INTRADO','PCNSR','TARGUS']) => 0.0324730542,
      (pp_source = '') => -0.0005841073, -0.0002377687),
   (f_add_curr_mobility_index_n > 0.397845621170065) => -0.0369790709,
   (f_add_curr_mobility_index_n = NULL) => -0.0127975614, -0.0127975614),
(mth_exp_last_update = NULL) => 0.0015332809, 0.0015332809);

// Tree: 666 
final_score_666 := map(
(NULL < eda_num_phs_connected_addr and eda_num_phs_connected_addr <= 1.5) => 
   map(
   (NULL < mth_source_ppca_lseen and mth_source_ppca_lseen <= 43.5) => 
      map(
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Vehicle','Brother','Daughter','Father','Granddaughter','Grandfather','Grandmother','Grandson','Neighbor','Parent','Son']) => -0.0250555295,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Child','Grandchild','Grandparent','Husband','Mother','Relative','Sibling','Sister','Spouse','Subject','Subject at Household','Wife']) => 0.0050424021,
      (phone_subject_title = '') => -0.0010202968, -0.0010202968),
   (mth_source_ppca_lseen > 43.5) => -0.0615095020,
   (mth_source_ppca_lseen = NULL) => -0.0021663281, -0.0021663281),
(eda_num_phs_connected_addr > 1.5) => -0.0913058833,
(eda_num_phs_connected_addr = NULL) => -0.0033363124, -0.0033363124);

// Tree: 667 
final_score_667 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 13.5) => -0.0817157857,
(f_mos_inq_banko_cm_fseen_d > 13.5) => 
   map(
   (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 
      map(
      (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 1137.5) => -0.0051456923,
      (eda_avg_days_interrupt > 1137.5) => 0.0909203137,
      (eda_avg_days_interrupt = NULL) => -0.0034808132, -0.0034808132),
   (f_prevaddrstatus_i > 2.5) => -0.0005139341,
   (f_prevaddrstatus_i = NULL) => 0.0118566808, 0.0013561745),
(f_mos_inq_banko_cm_fseen_d = NULL) => 0.0007389980, 0.0007389980);

// Tree: 668 
final_score_668 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.26112489169507) => -0.0101249505,
(f_add_input_mobility_index_n > 0.26112489169507) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.26485819189373) => 0.0709784636,
   (f_add_input_mobility_index_n > 0.26485819189373) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.16067534204149) => 0.0940850833,
      (f_add_curr_mobility_index_n > 0.16067534204149) => 0.0022425915,
      (f_add_curr_mobility_index_n = NULL) => 0.0030454370, 0.0030454370),
   (f_add_input_mobility_index_n = NULL) => 0.0039698456, 0.0039698456),
(f_add_input_mobility_index_n = NULL) => 0.0085997754, 0.0008364015);

// Tree: 669 
final_score_669 := map(
(NULL < inq_firstseen_n and inq_firstseen_n <= 64.5) => -0.0019328908,
(inq_firstseen_n > 64.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 147.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Father','Grandfather','Grandmother','Husband','Neighbor','Relative','Sibling','Sister','Spouse','Subject','Wife']) => 0.0301744452,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandparent','Grandson','Mother','Parent','Son','Subject at Household']) => 0.0866751068,
      (phone_subject_title = '') => 0.0394463486, 0.0394463486),
   (f_prevaddrageoldest_d > 147.5) => -0.0123594736,
   (f_prevaddrageoldest_d = NULL) => 0.0182530577, 0.0182530577),
(inq_firstseen_n = NULL) => -0.0002832219, -0.0002832219);

// Tree: 670 
final_score_670 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.68303780193163) => 0.0054190941,
(f_add_input_mobility_index_n > 0.68303780193163) => 
   map(
   (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 5.5) => 0.0008274362,
   (mth_pp_datelastseen > 5.5) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 5.5) => -0.0803001447,
      (f_rel_under100miles_cnt_d > 5.5) => -0.0171232304,
      (f_rel_under100miles_cnt_d = NULL) => -0.0406907941, -0.0406907941),
   (mth_pp_datelastseen = NULL) => -0.0154942268, -0.0154942268),
(f_add_input_mobility_index_n = NULL) => -0.0151285552, 0.0031101903);

// Tree: 671 
final_score_671 := map(
(NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 149) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 6.5) => 0.0003501959,
   (mth_exp_last_update > 6.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 117996.5) => -0.0155570788,
      (f_addrchangevaluediff_d > 117996.5) => 0.0455472611,
      (f_addrchangevaluediff_d = NULL) => -0.0214432508, -0.0121588411),
   (mth_exp_last_update = NULL) => -0.0012243464, -0.0012243464),
(mth_source_ppdid_fseen > 149) => 0.0669975950,
(mth_source_ppdid_fseen = NULL) => -0.0007850769, -0.0007850769);

// Tree: 672 
final_score_672 := map(
(NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 79.5) => 
   map(
   (NULL < f_college_income_d and f_college_income_d <= 5.5) => 0.0118954078,
   (f_college_income_d > 5.5) => -0.0176470226,
   (f_college_income_d = NULL) => 0.0021938438, 0.0018144145),
(mth_source_ppfla_fseen > 79.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 87.5) => 0.0907986570,
   (mth_source_ppdid_fseen > 87.5) => -0.0118511935,
   (mth_source_ppdid_fseen = NULL) => 0.0355920147, 0.0355920147),
(mth_source_ppfla_fseen = NULL) => 0.0023121280, 0.0023121280);

// Tree: 673 
final_score_673 := map(
(eda_pfrd_address_ind in ['1A','1B','1E','XX']) => 0.0004369417,
(eda_pfrd_address_ind in ['1C','1D']) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Grandfather','Neighbor','Parent','Relative','Sibling']) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 31.5) => 0.0698234431,
      (f_prevaddrlenofres_d > 31.5) => -0.0378296881,
      (f_prevaddrlenofres_d = NULL) => -0.0087342473, -0.0087342473),
   (phone_subject_title in ['Associate By Property','Brother','Daughter','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Mother','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0602973802,
   (phone_subject_title = '') => 0.0268658329, 0.0268658329),
(eda_pfrd_address_ind = '') => 0.0016870452, 0.0016870452);

// Tree: 674 
final_score_674 := map(
(NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 51.5) => 0.0458519740,
(f_mos_inq_banko_am_fseen_d > 51.5) => 
   map(
   (NULL < r_paw_dead_business_ct_i and r_paw_dead_business_ct_i <= 1.5) => -0.0017982697,
   (r_paw_dead_business_ct_i > 1.5) => 
      map(
      (phone_subject_title in ['Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Daughter','Father','Grandmother','Neighbor','Parent','Relative','Subject at Household']) => -0.0313299646,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Vehicle','Child','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Mother','Sibling','Sister','Son','Spouse','Subject','Wife']) => 0.0576068627,
      (phone_subject_title = '') => 0.0255896049, 0.0255896049),
   (r_paw_dead_business_ct_i = NULL) => -0.0012832664, -0.0012832664),
(f_mos_inq_banko_am_fseen_d = NULL) => -0.0007112226, -0.0007112226);

// Tree: 675 
final_score_675 := map(
(NULL < mth_source_sx_fseen and mth_source_sx_fseen <= 17.5) => -0.0008631524,
(mth_source_sx_fseen > 17.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 111.5) => 
      map(
      (NULL < f_util_add_input_misc_n and f_util_add_input_misc_n <= 0.5) => -0.0536345185,
      (f_util_add_input_misc_n > 0.5) => 0.0274802002,
      (f_util_add_input_misc_n = NULL) => -0.0100422547, -0.0100422547),
   (f_prevaddrlenofres_d > 111.5) => 0.0474277620,
   (f_prevaddrlenofres_d = NULL) => 0.0232211934, 0.0232211934),
(mth_source_sx_fseen = NULL) => 0.0001776396, 0.0001776396);

// Tree: 676 
final_score_676 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 518789) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 457107) => 
      map(
      (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 43.5) => -0.0015975009,
      (inq_adl_firstseen_n > 43.5) => 0.0267824663,
      (inq_adl_firstseen_n = NULL) => -0.0005891518, -0.0005891518),
   (f_curraddrmedianvalue_d > 457107) => 0.0423671631,
   (f_curraddrmedianvalue_d = NULL) => 0.0003596379, 0.0003596379),
(f_curraddrmedianvalue_d > 518789) => -0.0287547994,
(f_curraddrmedianvalue_d = NULL) => -0.0008409946, -0.0008409946);

// Tree: 677 
final_score_677 := map(
(NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 31.5) => -0.0047559076,
(mth_pp_datefirstseen > 31.5) => 
   map(
   (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 4.5) => 0.0883829894,
   (mth_pp_datevendorfirstseen > 4.5) => 
      map(
      (NULL < f_college_income_d and f_college_income_d <= 5.5) => 0.0654235839,
      (f_college_income_d > 5.5) => -0.0257607641,
      (f_college_income_d = NULL) => 0.0060718206, 0.0092762092),
   (mth_pp_datevendorfirstseen = NULL) => 0.0126638112, 0.0126638112),
(mth_pp_datefirstseen = NULL) => -0.0020359639, -0.0020359639);

// Tree: 678 
final_score_678 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 0.0077166240,
(f_corraddrnamecount_d > 1.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.68303780193163) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.651161974891535) => -0.0057985018,
      (f_add_curr_mobility_index_n > 0.651161974891535) => 0.0660651246,
      (f_add_curr_mobility_index_n = NULL) => -0.0051545403, -0.0051545403),
   (f_add_curr_mobility_index_n > 0.68303780193163) => -0.0406183733,
   (f_add_curr_mobility_index_n = NULL) => -0.0067144816, -0.0067144816),
(f_corraddrnamecount_d = NULL) => -0.0032188478, -0.0032188478);

// Tree: 679 
final_score_679 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 227.5) => 0.0015270987,
(r_pb_order_freq_d > 227.5) => 0.0221818975,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < mth_phone_fb_rp_date and mth_phone_fb_rp_date <= 8.5) => 
      map(
      (NULL < mth_source_sx_fseen and mth_source_sx_fseen <= 32.5) => -0.0003982415,
      (mth_source_sx_fseen > 32.5) => -0.0685108814,
      (mth_source_sx_fseen = NULL) => -0.0019877737, -0.0019877737),
   (mth_phone_fb_rp_date > 8.5) => 0.0549619150,
   (mth_phone_fb_rp_date = NULL) => 0.0018594284, 0.0018594284), 0.0033443430);

// Tree: 680 
final_score_680 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 3.5) => -0.0054084036,
(f_rel_homeover200_count_d > 3.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 1.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Grandson','Husband','Mother','Neighbor','Sister','Son','Subject','Subject at Household','Wife']) => 0.0172424720,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Parent','Relative','Sibling','Spouse']) => 0.1005500731,
      (phone_subject_title = '') => 0.0349137814, 0.0349137814),
   (f_srchvelocityrisktype_i > 1.5) => 0.0025224872,
   (f_srchvelocityrisktype_i = NULL) => 0.0052115758, 0.0052115758),
(f_rel_homeover200_count_d = NULL) => -0.0012147448, -0.0012147448);

// Tree: 681 
final_score_681 := map(
(NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 36.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 223843.5) => 0.0007518030,
   (f_curraddrmedianvalue_d > 223843.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.17528683855265) => 0.0271227908,
      (f_add_input_mobility_index_n > 0.17528683855265) => -0.0135424680,
      (f_add_input_mobility_index_n = NULL) => -0.0117774828, -0.0117774828),
   (f_curraddrmedianvalue_d = NULL) => -0.0028778988, -0.0028778988),
(f_rel_homeover100_count_d > 36.5) => 0.0567453985,
(f_rel_homeover100_count_d = NULL) => -0.0024780406, -0.0024780406);

// Tree: 682 
final_score_682 := map(
(NULL < eda_num_phs_connected_addr and eda_num_phs_connected_addr <= 1.5) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 0.5) => -0.0066665380,
   (f_rel_incomeover75_count_d > 0.5) => 
      map(
      (NULL < eda_days_ind_first_seen and eda_days_ind_first_seen <= 716.5) => 0.0074143848,
      (eda_days_ind_first_seen > 716.5) => -0.0322259759,
      (eda_days_ind_first_seen = NULL) => 0.0055327470, 0.0055327470),
   (f_rel_incomeover75_count_d = NULL) => 0.0010587041, 0.0010587041),
(eda_num_phs_connected_addr > 1.5) => -0.0655969899,
(eda_num_phs_connected_addr = NULL) => 0.0002333488, 0.0002333488);

// Tree: 683 
final_score_683 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 43.5) => 
   map(
   (NULL < pk_phone_match_level and pk_phone_match_level <= 0.5) => -0.0380307216,
   (pk_phone_match_level > 0.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 14.5) => -0.0732715694,
      (f_mos_inq_banko_cm_fseen_d > 14.5) => 0.0053490012,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0045521002, 0.0045521002),
   (pk_phone_match_level = NULL) => 0.0018900083, 0.0018900083),
(f_srchfraudsrchcount_i > 43.5) => -0.0755489839,
(f_srchfraudsrchcount_i = NULL) => 0.0011515808, 0.0011515808);

// Tree: 684 
final_score_684 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 1.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Relative','Sibling','Sister','Son','Subject','Subject at Household']) => -0.0173608628,
   (phone_subject_title in ['Father','Grandchild','Granddaughter','Grandparent','Parent','Spouse','Wife']) => 0.0583301418,
   (phone_subject_title = '') => -0.0147708233, -0.0147708233),
(f_assocsuspicousidcount_i > 1.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 50.5) => 0.0012282040,
   (inq_adl_lastseen_n > 50.5) => -0.0489100761,
   (inq_adl_lastseen_n = NULL) => 0.0003265838, 0.0003265838),
(f_assocsuspicousidcount_i = NULL) => -0.0033341869, -0.0033341869);

// Tree: 685 
final_score_685 := map(
(NULL < _pp_app_fb_ph7_did and _pp_app_fb_ph7_did <= 0.5) => 0.0442183730,
(_pp_app_fb_ph7_did > 0.5) => 
   map(
   (pp_glb_dppa_fl in ['G']) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 13.5) => 0.0531639533,
      (mth_pp_app_npa_last_change_dt > 13.5) => -0.0095396948,
      (mth_pp_app_npa_last_change_dt = NULL) => -0.0072269520, -0.0072269520),
   (pp_glb_dppa_fl in ['B','D','U']) => 0.0003855908,
   (pp_glb_dppa_fl = '') => 0.0040826375, 0.0002453855),
(_pp_app_fb_ph7_did = NULL) => 0.0005720793, 0.0005720793);

// Tree: 686 
final_score_686 := map(
(phone_subject_title in ['Associate By Property','Associate By SSN','Associate By Vehicle','Daughter','Grandparent','Grandson','Mother','Parent','Sibling','Sister','Son','Spouse','Subject at Household','Wife']) => -0.0114308401,
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Husband','Neighbor','Relative','Subject']) => 
   map(
   (NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 5.5) => 0.0020649956,
   (mth_source_ppla_lseen > 5.5) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 6.5) => 0.0813965378,
      (f_rel_under25miles_cnt_d > 6.5) => -0.0078064469,
      (f_rel_under25miles_cnt_d = NULL) => 0.0350926984, 0.0350926984),
   (mth_source_ppla_lseen = NULL) => 0.0026959755, 0.0026959755),
(phone_subject_title = '') => 0.0005636590, 0.0005636590);

// Tree: 687 
final_score_687 := map(
(NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 8.5) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 66.5) => 
      map(
      (NULL < _phone_fb_result and _phone_fb_result <= 0.5) => 0.0512749480,
      (_phone_fb_result > 0.5) => 0.0012302279,
      (_phone_fb_result = NULL) => 0.0015778923, 0.0015778923),
   (f_rel_count_i > 66.5) => 0.0650628103,
   (f_rel_count_i = NULL) => 0.0020079746, 0.0020079746),
(f_rel_incomeover100_count_d > 8.5) => -0.0491059341,
(f_rel_incomeover100_count_d = NULL) => 0.0015126479, 0.0015126479);

// Tree: 688 
final_score_688 := map(
(NULL < _pp_rule_ins_ver_above and _pp_rule_ins_ver_above <= 0.5) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 18.5) => -0.0004399717,
   (mth_exp_last_update > 18.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 2.5) => 0.0003857246,
      (f_util_adl_count_n > 2.5) => -0.0590843008,
      (f_util_adl_count_n = NULL) => -0.0250288162, -0.0250288162),
   (mth_exp_last_update = NULL) => -0.0022879257, -0.0022879257),
(_pp_rule_ins_ver_above > 0.5) => 0.0355617890,
(_pp_rule_ins_ver_above = NULL) => -0.0009194120, -0.0009194120);

// Tree: 689 
final_score_689 := map(
(NULL < f_adl_util_inf_n and f_adl_util_inf_n <= 0.5) => 0.0015604380,
(f_adl_util_inf_n > 0.5) => 
   map(
   (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 3.5) => -0.0322018165,
   (f_rel_bankrupt_count_i > 3.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 26.5) => 0.0687736434,
      (f_mos_inq_banko_om_fseen_d > 26.5) => -0.0040867868,
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0159074708, 0.0159074708),
   (f_rel_bankrupt_count_i = NULL) => -0.0178358488, -0.0178358488),
(f_adl_util_inf_n = NULL) => -0.0001688000, -0.0001688000);

// Tree: 690 
final_score_690 := map(
(NULL < f_rel_ageover60_count_d and f_rel_ageover60_count_d <= 0.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 92.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.173942361253625) => 0.0432430454,
      (f_add_curr_mobility_index_n > 0.173942361253625) => 0.0059256129,
      (f_add_curr_mobility_index_n = NULL) => 0.0082478732, 0.0082478732),
   (r_pb_order_freq_d > 92.5) => -0.0015213158,
   (r_pb_order_freq_d = NULL) => -0.0037348490, 0.0019464273),
(f_rel_ageover60_count_d > 0.5) => -0.0364335636,
(f_rel_ageover60_count_d = NULL) => 0.0013216257, 0.0013216257);

// Tree: 691 
final_score_691 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 57.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 11.5) => 
      map(
      (NULL < f_adl_util_misc_n and f_adl_util_misc_n <= 0.5) => 0.0458639368,
      (f_adl_util_misc_n > 0.5) => -0.0070677061,
      (f_adl_util_misc_n = NULL) => 0.0236041750, 0.0236041750),
   (f_mos_inq_banko_om_fseen_d > 11.5) => -0.0009594338,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0002968518, 0.0002968518),
(f_srchaddrsrchcount_i > 57.5) => 0.0702492369,
(f_srchaddrsrchcount_i = NULL) => 0.0009725529, 0.0009725529);

// Tree: 692 
final_score_692 := map(
(NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 1785) => -0.0012356893,
(eda_max_days_interrupt > 1785) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Father','Husband','Neighbor','Sibling','Sister','Son','Subject','Wife']) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 116) => -0.0351369119,
      (f_prevaddrlenofres_d > 116) => 0.0524950336,
      (f_prevaddrlenofres_d = NULL) => 0.0083139278, 0.0083139278),
   (phone_subject_title in ['Associate By Business','Associate By SSN','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Parent','Relative','Spouse','Subject at Household']) => 0.1069644359,
   (phone_subject_title = '') => 0.0272468536, 0.0272468536),
(eda_max_days_interrupt = NULL) => -0.0001882258, -0.0001882258);

// Tree: 693 
final_score_693 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 477594.5) => -0.0005945899,
(f_curraddrmedianvalue_d > 477594.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.409703471633075) => 0.0040808022,
   (f_add_input_mobility_index_n > 0.409703471633075) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Child','Grandson','Husband','Neighbor','Parent','Sister','Son']) => -0.0131216362,
      (phone_subject_title in ['Associate By Property','Associate By SSN','Brother','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Mother','Relative','Sibling','Spouse','Subject','Subject at Household','Wife']) => 0.1023738812,
      (phone_subject_title = '') => 0.0450085579, 0.0450085579),
   (f_add_input_mobility_index_n = NULL) => 0.0189725880, 0.0189725880),
(f_curraddrmedianvalue_d = NULL) => 0.0004207225, 0.0004207225);

// Tree: 694 
final_score_694 := map(
(NULL < _internal_ver_match_hhid and _internal_ver_match_hhid <= 0.5) => 0.0001272374,
(_internal_ver_match_hhid > 0.5) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 68) => -0.0126003362,
   (f_fp_prevaddrcrimeindex_i > 68) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 141.5) => -0.0037425413,
      (mth_pp_app_npa_effective_dt > 141.5) => 0.0517437950,
      (mth_pp_app_npa_effective_dt = NULL) => 0.0324323740, 0.0324323740),
   (f_fp_prevaddrcrimeindex_i = NULL) => 0.0173236797, 0.0173236797),
(_internal_ver_match_hhid = NULL) => 0.0014346440, 0.0014346440);

// Tree: 695 
final_score_695 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 73.5) => 
   map(
   (exp_source in ['P']) => -0.0082969304,
   (exp_source in ['S']) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 1.5) => 0.0382142819,
      (f_srchssnsrchcount_i > 1.5) => -0.0008165747,
      (f_srchssnsrchcount_i = NULL) => 0.0152370525, 0.0152370525),
   (exp_source = '') => -0.0014277501, 0.0003108126),
(mth_exp_last_update > 73.5) => -0.0459556502,
(mth_exp_last_update = NULL) => -0.0004339423, -0.0004339423);

// Tree: 696 
final_score_696 := map(
(NULL < eda_max_days_connected_ind and eda_max_days_connected_ind <= 745.5) => 
   map(
   (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 14.5) => 0.0004112410,
   (mth_source_inf_fseen > 14.5) => -0.0259006756,
   (mth_source_inf_fseen = NULL) => -0.0009390238, -0.0009390238),
(eda_max_days_connected_ind > 745.5) => 
   map(
   (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 1.5) => 0.0839052227,
   (f_rel_ageover40_count_d > 1.5) => 0.0138685906,
   (f_rel_ageover40_count_d = NULL) => 0.0399511984, 0.0399511984),
(eda_max_days_connected_ind = NULL) => -0.0002048631, -0.0002048631);

// Tree: 697 
final_score_697 := map(
(NULL < f_util_add_input_inf_n and f_util_add_input_inf_n <= 0.5) => -0.0008873006,
(f_util_add_input_inf_n > 0.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By Vehicle','Brother','Husband','Neighbor','Relative','Sibling','Son','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < eda_days_in_service and eda_days_in_service <= 198.5) => 0.0334377671,
      (eda_days_in_service > 198.5) => -0.0398506378,
      (eda_days_in_service = NULL) => 0.0036583097, 0.0036583097),
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Parent','Sister']) => 0.0875642586,
   (phone_subject_title = '') => 0.0142915521, 0.0142915521),
(f_util_add_input_inf_n = NULL) => -0.0000715970, -0.0000715970);

// Tree: 698 
final_score_698 := map(
(NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 120.5) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 94833.5) => -0.0030472885,
   (f_prevaddrmedianincome_d > 94833.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Child','Grandfather','Grandmother','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Subject at Household']) => -0.0271486141,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Daughter','Father','Grandchild','Granddaughter','Grandparent','Grandson','Mother','Spouse','Subject','Wife']) => 0.0374794648,
      (phone_subject_title = '') => 0.0138145363, 0.0138145363),
   (f_prevaddrmedianincome_d = NULL) => -0.0019151705, -0.0019151705),
(mth_pp_datevendorfirstseen > 120.5) => 0.0719362078,
(mth_pp_datevendorfirstseen = NULL) => -0.0013482084, -0.0013482084);

// Tree: 699 
final_score_699 := map(
(pp_source in ['CELL','GONG','INFUTOR','INQUIRY','OTHER','PCNSR','THRIVE']) => -0.0083036533,
(pp_source in ['HEADER','IBEHAVIOR','INTRADO','TARGUS']) => 
   map(
   (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 10.5) => 0.0304137426,
   (mth_pp_datevendorfirstseen > 10.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 24191) => -0.0058567444,
      (f_addrchangeincomediff_d > 24191) => 0.0508934754,
      (f_addrchangeincomediff_d = NULL) => -0.0197132229, -0.0023985657),
   (mth_pp_datevendorfirstseen = NULL) => 0.0100437756, 0.0100437756),
(pp_source = '') => 0.0035920971, 0.0010721471);

// Tree: 700 
final_score_700 := map(
(NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 16.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Grandmother','Husband','Neighbor','Parent','Relative','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0199233805,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Mother','Sibling']) => 0.1221868998,
      (phone_subject_title = '') => 0.0277898051, 0.0277898051),
   (f_prevaddrlenofres_d > 16.5) => 0.0021569078,
   (f_prevaddrlenofres_d = NULL) => 0.0072131782, 0.0072131782),
(f_util_add_input_conv_n > 0.5) => -0.0050503415,
(f_util_add_input_conv_n = NULL) => 0.0001551247, 0.0001551247);

// Tree: 701 
final_score_701 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0026819923,
(source_utildid > 0.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 12.5) => 0.0758212655,
   (mth_source_utildid_fseen > 12.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 1.5) => 0.0186213515,
      (f_varrisktype_i > 1.5) => -0.0432718458,
      (f_varrisktype_i = NULL) => 0.0031991192, 0.0031991192),
   (mth_source_utildid_fseen = NULL) => 0.0150353253, 0.0150353253),
(source_utildid = NULL) => -0.0010936642, -0.0010936642);

// Tree: 702 
final_score_702 := map(
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Daughter','Grandfather','Grandmother','Grandson','Husband','Neighbor','Sibling','Subject','Wife']) => -0.0044822762,
(phone_subject_title in ['Associate','Associate By Property','Brother','Child','Father','Grandchild','Granddaughter','Grandparent','Mother','Parent','Relative','Sister','Son','Spouse','Subject at Household']) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 74100) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.25354555101283) => 0.0333917922,
      (f_add_curr_mobility_index_n > 0.25354555101283) => 0.0054372134,
      (f_add_curr_mobility_index_n = NULL) => 0.0121388660, 0.0121388660),
   (f_prevaddrmedianincome_d > 74100) => -0.0160247054,
   (f_prevaddrmedianincome_d = NULL) => 0.0069917742, 0.0069917742),
(phone_subject_title = '') => -0.0013182457, -0.0013182457);

// Tree: 703 
final_score_703 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.400651066338235) => 0.0044516579,
(f_add_curr_mobility_index_n > 0.400651066338235) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 23.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Daughter','Grandson','Husband','Neighbor','Relative','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => -0.0125589109,
      (phone_subject_title in ['Associate','Associate By Property','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Mother','Parent','Sibling']) => 0.0177560928,
      (phone_subject_title = '') => -0.0080356827, -0.0080356827),
   (mth_exp_last_update > 23.5) => -0.0397275113,
   (mth_exp_last_update = NULL) => -0.0101827327, -0.0101827327),
(f_add_curr_mobility_index_n = NULL) => -0.0003377391, -0.0006166090);

// Tree: 704 
final_score_704 := map(
(pp_app_scc in ['A','B','C','N','R']) => -0.0016534187,
(pp_app_scc in ['8','J','S']) => 
   map(
   (NULL < f_estimated_income_d and f_estimated_income_d <= 85500) => 0.0060491512,
   (f_estimated_income_d > 85500) => 0.0729314867,
   (f_estimated_income_d = NULL) => 0.0152894738, 0.0152894738),
(pp_app_scc = '') => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 13.5) => 0.0009271545,
   (f_rel_incomeover75_count_d > 13.5) => -0.0435421905,
   (f_rel_incomeover75_count_d = NULL) => 0.0001471682, 0.0001471682), 0.0006035727);

// Tree: 705 
final_score_705 := map(
(NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 50) => -0.0113930468,
(f_curraddrmurderindex_i > 50) => 
   map(
   (exp_source in ['P']) => -0.0016296510,
   (exp_source in ['S']) => 
      map(
      (phone_subject_title in ['Associate','Associate By Property','Associate By Shared Associates','Associate By SSN','Father','Grandmother','Grandparent','Husband','Mother','Neighbor','Parent','Relative','Sister','Subject','Subject at Household','Wife']) => 0.0111868452,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandson','Sibling','Son','Spouse']) => 0.0763555237,
      (phone_subject_title = '') => 0.0156712604, 0.0156712604),
   (exp_source = '') => 0.0006482563, 0.0026786132),
(f_curraddrmurderindex_i = NULL) => -0.0004598462, -0.0004598462);

// Tree: 706 
final_score_706 := map(
(eda_pfrd_address_ind in ['1A','1B','1E','XX']) => 0.0001126343,
(eda_pfrd_address_ind in ['1C','1D']) => 
   map(
   (NULL < _phone_zip_match and _phone_zip_match <= 0.5) => -0.0042009382,
   (_phone_zip_match > 0.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 0.5) => 0.1257457386,
      (f_srchssnsrchcount_i > 0.5) => 0.0337978229,
      (f_srchssnsrchcount_i = NULL) => 0.0668628369, 0.0668628369),
   (_phone_zip_match = NULL) => 0.0319543158, 0.0319543158),
(eda_pfrd_address_ind = '') => 0.0016857932, 0.0016857932);

// Tree: 707 
final_score_707 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 29.5) => 
   map(
   (NULL < mth_source_ppth_fseen and mth_source_ppth_fseen <= 66.5) => 0.0026015137,
   (mth_source_ppth_fseen > 66.5) => -0.0614909965,
   (mth_source_ppth_fseen = NULL) => 0.0013164078, 0.0013164078),
(mth_source_ppdid_lseen > 29.5) => 
   map(
   (NULL < f_vardobcount_i and f_vardobcount_i <= 2.5) => -0.0297192298,
   (f_vardobcount_i > 2.5) => 0.0450723394,
   (f_vardobcount_i = NULL) => -0.0226800233, -0.0226800233),
(mth_source_ppdid_lseen = NULL) => -0.0004515313, -0.0004515313);

// Tree: 708 
final_score_708 := map(
(NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 53.5) => -0.0025745076,
(mth_source_ppfla_fseen > 53.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 71.5) => -0.0060560826,
   (f_curraddrcrimeindex_i > 71.5) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 7.5) => 0.0849315832,
      (f_rel_ageover30_count_d > 7.5) => 0.0221481452,
      (f_rel_ageover30_count_d = NULL) => 0.0529475676, 0.0529475676),
   (f_curraddrcrimeindex_i = NULL) => 0.0248919104, 0.0248919104),
(mth_source_ppfla_fseen = NULL) => -0.0018807051, -0.0018807051);

// Tree: 709 
final_score_709 := map(
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Father','Grandfather','Grandson','Neighbor','Relative','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => -0.0003705637,
(phone_subject_title in ['Associate','Associate By SSN','Brother','Child','Daughter','Grandchild','Granddaughter','Grandmother','Grandparent','Husband','Mother','Parent','Spouse']) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 172.5) => 0.0031722179,
   (f_prevaddrageoldest_d > 172.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 164.5) => 0.0185649092,
      (f_prevaddrmurderindex_i > 164.5) => 0.0906390381,
      (f_prevaddrmurderindex_i = NULL) => 0.0350607486, 0.0350607486),
   (f_prevaddrageoldest_d = NULL) => 0.0121477805, 0.0121477805),
(phone_subject_title = '') => 0.0011934543, 0.0011934543);

// Tree: 710 
final_score_710 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -16.5) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 20068) => 
      map(
      (phone_subject_title in ['Associate By Address','Brother','Daughter','Father','Mother','Neighbor','Sibling','Sister','Son','Spouse']) => -0.0372747095,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Parent','Relative','Subject','Subject at Household','Wife']) => 0.0660991547,
      (phone_subject_title = '') => 0.0197822934, 0.0197822934),
   (f_prevaddrmedianincome_d > 20068) => -0.0135274280,
   (f_prevaddrmedianincome_d = NULL) => -0.0112271154, -0.0112271154),
(f_addrchangecrimediff_i > -16.5) => 0.0025750695,
(f_addrchangecrimediff_i = NULL) => 0.0053480578, -0.0005448967);

// Tree: 711 
final_score_711 := map(
(NULL < inq_num and inq_num <= 2.5) => -0.0009493413,
(inq_num > 2.5) => 
   map(
   (NULL < f_estimated_income_d and f_estimated_income_d <= 72500) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 172.5) => 0.0213428232,
      (f_fp_prevaddrburglaryindex_i > 172.5) => 0.0805343985,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0337148328, 0.0337148328),
   (f_estimated_income_d > 72500) => -0.0239194246,
   (f_estimated_income_d = NULL) => 0.0201644588, 0.0201644588),
(inq_num = NULL) => -0.0001153514, -0.0001153514);

// Tree: 712 
final_score_712 := map(
(NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 1.5) => 
   map(
   (NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 138.5) => -0.0017304696,
   (mth_pp_datefirstseen > 138.5) => 0.0628287288,
   (mth_pp_datefirstseen = NULL) => -0.0012397465, -0.0012397465),
(f_divaddrsuspidcountnew_i > 1.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => 0.0863496677,
   (f_mos_inq_banko_om_fseen_d > 36.5) => 0.0150267747,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0309775815, 0.0309775815),
(f_divaddrsuspidcountnew_i = NULL) => 0.0000090490, 0.0000090490);

// Tree: 713 
final_score_713 := map(
(NULL < _internal_ver_match_spouse and _internal_ver_match_spouse <= 0.5) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 1.5) => 0.0028038784,
   (f_idrisktype_i > 1.5) => -0.0300629536,
   (f_idrisktype_i = NULL) => 0.0013808211, 0.0013808211),
(_internal_ver_match_spouse > 0.5) => 
   map(
   (NULL < inq_lastseen_n and inq_lastseen_n <= 6.5) => -0.0003464256,
   (inq_lastseen_n > 6.5) => 0.0727727355,
   (inq_lastseen_n = NULL) => 0.0379005202, 0.0379005202),
(_internal_ver_match_spouse = NULL) => 0.0019686816, 0.0019686816);

// Tree: 714 
final_score_714 := map(
(NULL < _pp_rule_ins_ver_above and _pp_rule_ins_ver_above <= 0.5) => -0.0013610192,
(_pp_rule_ins_ver_above > 0.5) => 
   map(
   (NULL < mth_source_ppca_lseen and mth_source_ppca_lseen <= 5.5) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 16.5) => 0.0525158187,
      (f_rel_ageover30_count_d > 16.5) => -0.0166493883,
      (f_rel_ageover30_count_d = NULL) => 0.0364820662, 0.0364820662),
   (mth_source_ppca_lseen > 5.5) => -0.0355508280,
   (mth_source_ppca_lseen = NULL) => 0.0167502833, 0.0167502833),
(_pp_rule_ins_ver_above = NULL) => -0.0006815089, -0.0006815089);

// Tree: 715 
final_score_715 := map(
(NULL < mth_source_sp_lseen and mth_source_sp_lseen <= 3.5) => 
   map(
   (NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 5.5) => 0.0014553544,
   (f_inq_per_ssn_i > 5.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -7741.5) => 0.0248066218,
      (f_addrchangevaluediff_d > -7741.5) => -0.0532303137,
      (f_addrchangevaluediff_d = NULL) => -0.0155416611, -0.0249285795),
   (f_inq_per_ssn_i = NULL) => 0.0003341029, 0.0003341029),
(mth_source_sp_lseen > 3.5) => -0.0706210864,
(mth_source_sp_lseen = NULL) => -0.0001227655, -0.0001227655);

// Tree: 716 
final_score_716 := map(
(NULL < pp_app_company_type and pp_app_company_type <= 7.5) => -0.0011918867,
(pp_app_company_type > 7.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 60542.5) => 0.0012247175,
   (f_curraddrmedianincome_d > 60542.5) => 
      map(
      (NULL < inq_num_addresses and inq_num_addresses <= 1.5) => 0.0558557951,
      (inq_num_addresses > 1.5) => -0.0198933822,
      (inq_num_addresses = NULL) => 0.0378202767, 0.0378202767),
   (f_curraddrmedianincome_d = NULL) => 0.0143107457, 0.0143107457),
(pp_app_company_type = NULL) => 0.0000481703, 0.0000481703);

// Tree: 717 
final_score_717 := map(
(NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 89.5) => 
   map(
   (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 19.5) => -0.0025518956,
   (f_rel_ageover20_count_d > 19.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 18.5) => 0.0185412137,
      (f_addrchangecrimediff_i > 18.5) => -0.0152346494,
      (f_addrchangecrimediff_i = NULL) => 0.0018382829, 0.0062786030),
   (f_rel_ageover20_count_d = NULL) => -0.0007977635, -0.0007977635),
(mth_source_ppfla_fseen > 89.5) => -0.0437180564,
(mth_source_ppfla_fseen = NULL) => -0.0012176128, -0.0012176128);

// Tree: 718 
final_score_718 := map(
(NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 20.5) => 
   map(
   (NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 53.5) => 0.0007773645,
   (mth_source_ppfla_fseen > 53.5) => 
      map(
      (NULL < mth_source_ppfla_lseen and mth_source_ppfla_lseen <= 18.5) => -0.0148438846,
      (mth_source_ppfla_lseen > 18.5) => 0.0490032099,
      (mth_source_ppfla_lseen = NULL) => 0.0267597060, 0.0267597060),
   (mth_source_ppfla_fseen = NULL) => 0.0013109181, 0.0013109181),
(mth_pp_first_build_date > 20.5) => -0.0203095298,
(mth_pp_first_build_date = NULL) => -0.0001026030, -0.0001026030);

// Tree: 719 
final_score_719 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 18.5) => -0.0039545175,
(f_rel_under500miles_cnt_d > 18.5) => 
   map(
   (NULL < source_utildid and source_utildid <= 0.5) => 0.0064659368,
   (source_utildid > 0.5) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 17.5) => 0.0830955442,
      (inq_firstseen_n > 17.5) => 0.0072371221,
      (inq_firstseen_n = NULL) => 0.0403297223, 0.0403297223),
   (source_utildid = NULL) => 0.0099361596, 0.0099361596),
(f_rel_under500miles_cnt_d = NULL) => -0.0014452561, -0.0014452561);

// Tree: 720 
final_score_720 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 31.5) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 1.5) => 0.0024838443,
   (f_idrisktype_i > 1.5) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 158.5) => -0.0110041340,
      (mth_pp_app_npa_effective_dt > 158.5) => -0.0641808891,
      (mth_pp_app_npa_effective_dt = NULL) => -0.0209855314, -0.0209855314),
   (f_idrisktype_i = NULL) => 0.0015752954, 0.0015752954),
(f_rel_homeover200_count_d > 31.5) => 0.0444447496,
(f_rel_homeover200_count_d = NULL) => 0.0019321414, 0.0019321414);

// Tree: 721 
final_score_721 := map(
(pp_did_type in ['C_MERGE','CORE']) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.143000800052325) => -0.0543119196,
   (f_add_curr_mobility_index_n > 0.143000800052325) => 
      map(
      (pp_app_ph_type in ['LNDLN PRTD TO CELL','VOIP']) => -0.0449546875,
      (pp_app_ph_type in ['CELL','PAGE','POTS','Puerto Rico/US Virgin Isl']) => 0.0017165219,
      (pp_app_ph_type = '') => 0.0009377733, 0.0009377733),
   (f_add_curr_mobility_index_n = NULL) => 0.0000774299, 0.0000774299),
(pp_did_type in ['AMBIG','INACTIVE','NO_SSN']) => 0.0482289245,
(pp_did_type = '') => 0.0031712809, 0.0022597719);

// Tree: 722 
final_score_722 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 4.5) => 
   map(
   (pp_source in ['INQUIRY','INTRADO','OTHER','THRIVE']) => -0.0177315684,
   (pp_source in ['CELL','GONG','HEADER','IBEHAVIOR','INFUTOR','PCNSR','TARGUS']) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 13.5) => 0.0017454839,
      (f_rel_under500miles_cnt_d > 13.5) => 0.0601932377,
      (f_rel_under500miles_cnt_d = NULL) => 0.0063597802, 0.0063597802),
   (pp_source = '') => -0.0144192831, -0.0088015806),
(f_rel_under25miles_cnt_d > 4.5) => 0.0042550029,
(f_rel_under25miles_cnt_d = NULL) => 0.0000704084, 0.0000704084);

// Tree: 723 
final_score_723 := map(
(NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 11.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 283836) => -0.0025389133,
   (f_addrchangevaluediff_d > 283836) => -0.0578193177,
   (f_addrchangevaluediff_d = NULL) => -0.0003640277, -0.0027820308),
(f_rel_homeover100_count_d > 11.5) => 
   map(
   (NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 11.5) => 0.0163450028,
   (mth_pp_first_build_date > 11.5) => -0.0246419361,
   (mth_pp_first_build_date = NULL) => 0.0107828754, 0.0107828754),
(f_rel_homeover100_count_d = NULL) => -0.0002231235, -0.0002231235);

// Tree: 724 
final_score_724 := map(
(NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 1.5) => 0.0007316242,
(f_divaddrsuspidcountnew_i > 1.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By SSN','Brother','Granddaughter','Grandfather','Husband','Neighbor','Relative','Sibling','Subject at Household','Wife']) => -0.0162180085,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Father','Grandchild','Grandmother','Grandparent','Grandson','Mother','Parent','Sister','Son','Spouse','Subject']) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 86.5) => 0.0125123434,
      (f_prevaddrlenofres_d > 86.5) => 0.1040269288,
      (f_prevaddrlenofres_d = NULL) => 0.0503804477, 0.0503804477),
   (phone_subject_title = '') => 0.0233319280, 0.0233319280),
(f_divaddrsuspidcountnew_i = NULL) => 0.0015516724, 0.0015516724);

// Tree: 725 
final_score_725 := map(
(NULL < mth_source_pf_fseen and mth_source_pf_fseen <= 8.5) => 
   map(
   (NULL < _pp_app_fb_ph7_did and _pp_app_fb_ph7_did <= 0.5) => 0.0550680372,
   (_pp_app_fb_ph7_did > 0.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 3.5) => 0.0098507213,
      (f_inq_count_i > 3.5) => -0.0038251455,
      (f_inq_count_i = NULL) => -0.0005517307, -0.0005517307),
   (_pp_app_fb_ph7_did = NULL) => -0.0001564281, -0.0001564281),
(mth_source_pf_fseen > 8.5) => -0.0552711620,
(mth_source_pf_fseen = NULL) => -0.0005386006, -0.0005386006);

// Tree: 726 
final_score_726 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 1.34153904703355) => 
   map(
   (NULL < source_utildid and source_utildid <= 0.5) => 0.0000315829,
   (source_utildid > 0.5) => 
      map(
      (NULL < mth_source_ppca_lseen and mth_source_ppca_lseen <= 15.5) => 0.0074170934,
      (mth_source_ppca_lseen > 15.5) => 0.0576212787,
      (mth_source_ppca_lseen = NULL) => 0.0115591172, 0.0115591172),
   (source_utildid = NULL) => 0.0010572577, 0.0010572577),
(f_add_input_mobility_index_n > 1.34153904703355) => -0.0439699193,
(f_add_input_mobility_index_n = NULL) => 0.0091375854, 0.0005813308);

// Tree: 727 
final_score_727 := map(
(pp_glb_dppa_fl in ['G']) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 14.5) => -0.0032811241,
   (f_corraddrnamecount_d > 14.5) => -0.0484383479,
   (f_corraddrnamecount_d = NULL) => -0.0044936311, -0.0044936311),
(pp_glb_dppa_fl in ['B','D','U']) => 
   map(
   (NULL < eda_num_phs_connected_hhid and eda_num_phs_connected_hhid <= 0.5) => 0.0665193917,
   (eda_num_phs_connected_hhid > 0.5) => -0.0024907657,
   (eda_num_phs_connected_hhid = NULL) => 0.0161606282, 0.0161606282),
(pp_glb_dppa_fl = '') => 0.0043420575, 0.0017605562);

// Tree: 728 
final_score_728 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 16.5) => 
   map(
   (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 2074.5) => -0.0002495909,
   (eda_avg_days_interrupt > 2074.5) => -0.0715102508,
   (eda_avg_days_interrupt = NULL) => -0.0007188860, -0.0007188860),
(f_rel_ageover40_count_d > 16.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Father','Grandmother','Parent','Sibling','Sister','Son','Subject','Subject at Household']) => -0.0036970793,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Mother','Neighbor','Relative','Spouse','Wife']) => 0.0933905957,
   (phone_subject_title = '') => 0.0309285950, 0.0309285950),
(f_rel_ageover40_count_d = NULL) => -0.0001559317, -0.0001559317);

// Tree: 729 
final_score_729 := map(
(NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 1) => -0.0248042846,
(f_fp_prevaddrburglaryindex_i > 1) => 
   map(
   (pp_src in ['CY','E1','E2','LP','PL','SL','VO','ZT']) => -0.0326479632,
   (pp_src in ['EM','EN','EQ','FA','FF','KW','LA','MD','NW','TN','UT','UW','VW','ZK']) => 
      map(
      (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => -0.0066303784,
      (f_bus_name_nover_i > 0.5) => 0.0174414046,
      (f_bus_name_nover_i = NULL) => 0.0032007402, 0.0032007402),
   (pp_src = '') => 0.0013009429, 0.0009258078),
(f_fp_prevaddrburglaryindex_i = NULL) => -0.0001638024, -0.0001638024);

// Tree: 730 
final_score_730 := map(
(phone_subject_title in ['Associate By Business','Associate By SSN','Brother','Father','Granddaughter','Grandson','Husband','Neighbor','Parent','Sister','Son','Subject','Wife']) => 
   map(
   (NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0081712858,
   (_pp_rule_high_vend_conf > 0.5) => 
      map(
      (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 5.5) => 0.0017723714,
      (pp_app_ind_ph_cnt > 5.5) => 0.0400574003,
      (pp_app_ind_ph_cnt = NULL) => 0.0122767596, 0.0122767596),
   (_pp_rule_high_vend_conf = NULL) => -0.0051391303, -0.0051391303),
(phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Grandchild','Grandfather','Grandmother','Grandparent','Mother','Relative','Sibling','Spouse','Subject at Household']) => 0.0082266775,
(phone_subject_title = '') => 0.0002131508, 0.0002131508);

// Tree: 731 
final_score_731 := map(
(pp_src in ['CY','E1','EN','EQ','LP','NW','SL','ZT']) => -0.0317631759,
(pp_src in ['E2','EM','FA','FF','KW','LA','MD','PL','TN','UT','UW','VO','VW','ZK']) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -23867.5) => -0.0350934619,
   (f_addrchangeincomediff_d > -23867.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 180.5) => 0.0082216275,
      (f_fp_prevaddrburglaryindex_i > 180.5) => -0.0367895711,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0021253027, 0.0021253027),
   (f_addrchangeincomediff_d = NULL) => 0.0124836974, 0.0009125323),
(pp_src = '') => -0.0021630093, -0.0023423321);

// Tree: 732 
final_score_732 := map(
(NULL < pp_did_score and pp_did_score <= 37) => 
   map(
   (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 55.5) => 0.0059749977,
   (mth_pp_datelastseen > 55.5) => -0.0372422089,
   (mth_pp_datelastseen = NULL) => 0.0046882558, 0.0046882558),
(pp_did_score > 37) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 92061) => -0.0210788220,
   (f_curraddrmedianincome_d > 92061) => 0.0280114076,
   (f_curraddrmedianincome_d = NULL) => -0.0161697991, -0.0161697991),
(pp_did_score = NULL) => 0.0018730899, 0.0018730899);

// Tree: 733 
final_score_733 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 1.11439598920819) => 
   map(
   (NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 10.5) => -0.0020451786,
   (mth_source_rel_fseen > 10.5) => 0.0189871091,
   (mth_source_rel_fseen = NULL) => -0.0016721895, -0.0016721895),
(f_add_input_mobility_index_n > 1.11439598920819) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 138) => 0.0073456397,
   (f_fp_prevaddrcrimeindex_i > 138) => 0.0932003956,
   (f_fp_prevaddrcrimeindex_i = NULL) => 0.0333622324, 0.0333622324),
(f_add_input_mobility_index_n = NULL) => 0.0227936180, -0.0007352550);

// Tree: 734 
final_score_734 := map(
(NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 0.5) => -0.0023324404,
(inq_adl_firstseen_n > 0.5) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 0.5) => -0.0056277229,
   (f_rel_incomeover75_count_d > 0.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.261687325196625) => -0.0118495399,
      (f_add_input_mobility_index_n > 0.261687325196625) => 0.0231519560,
      (f_add_input_mobility_index_n = NULL) => 0.0159951006, 0.0159951006),
   (f_rel_incomeover75_count_d = NULL) => 0.0083296324, 0.0083296324),
(inq_adl_firstseen_n = NULL) => -0.0010425884, -0.0010425884);

// Tree: 735 
final_score_735 := map(
(NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => 
   map(
   (NULL < mth_source_ppth_fseen and mth_source_ppth_fseen <= 23.5) => 
      map(
      (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 44.5) => 0.0007175889,
      (mth_pp_datelastseen > 44.5) => -0.0351734919,
      (mth_pp_datelastseen = NULL) => -0.0008136494, -0.0008136494),
   (mth_source_ppth_fseen > 23.5) => -0.0457222550,
   (mth_source_ppth_fseen = NULL) => -0.0024304743, -0.0024304743),
(_inq_adl_ph_industry_flag > 0.5) => 0.0252765059,
(_inq_adl_ph_industry_flag = NULL) => -0.0015007329, -0.0015007329);

// Tree: 736 
final_score_736 := map(
(NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 59) => 
   map(
   (NULL < eda_disc_cnt18 and eda_disc_cnt18 <= 0.5) => -0.0046182420,
   (eda_disc_cnt18 > 0.5) => -0.0519171739,
   (eda_disc_cnt18 = NULL) => -0.0066737352, -0.0066737352),
(f_fp_prevaddrcrimeindex_i > 59) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 1.02633960958143) => 0.0023709100,
   (f_add_input_mobility_index_n > 1.02633960958143) => 0.0335053194,
   (f_add_input_mobility_index_n = NULL) => 0.0029719458, 0.0032194350),
(f_fp_prevaddrcrimeindex_i = NULL) => 0.0006539491, 0.0006539491);

// Tree: 737 
final_score_737 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 87007.5) => 
   map(
   (NULL < eda_address_match_best and eda_address_match_best <= 0.5) => -0.0037599253,
   (eda_address_match_best > 0.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Brother','Father','Grandmother','Husband','Mother','Neighbor','Subject']) => 0.0134183048,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Parent','Relative','Sibling','Sister','Son','Spouse','Subject at Household','Wife']) => 0.0768638784,
      (phone_subject_title = '') => 0.0248843723, 0.0248843723),
   (eda_address_match_best = NULL) => -0.0021063735, -0.0021063735),
(f_curraddrmedianincome_d > 87007.5) => 0.0219066080,
(f_curraddrmedianincome_d = NULL) => 0.0005283635, 0.0005283635);

// Tree: 738 
final_score_738 := map(
(NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0038947218,
(_pp_rule_high_vend_conf > 0.5) => 
   map(
   (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 1.5) => -0.0121506772,
   (pp_app_ind_ph_cnt > 1.5) => 
      map(
      (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0018705132,
      (_phone_match_code_n > 0.5) => 0.0399982843,
      (_phone_match_code_n = NULL) => 0.0220693190, 0.0220693190),
   (pp_app_ind_ph_cnt = NULL) => 0.0090531242, 0.0090531242),
(_pp_rule_high_vend_conf = NULL) => -0.0018040840, -0.0018040840);

// Tree: 739 
final_score_739 := map(
(NULL < _pp_src_all_iq and _pp_src_all_iq <= 0.5) => 
   map(
   (pp_glb_dppa_fl in ['D','G']) => -0.0116728972,
   (pp_glb_dppa_fl in ['B','U']) => 0.0078650009,
   (pp_glb_dppa_fl = '') => 0.0001720764, -0.0023138953),
(_pp_src_all_iq > 0.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.700412333933925) => 0.0139797817,
   (f_add_input_mobility_index_n > 0.700412333933925) => -0.0262667062,
   (f_add_input_mobility_index_n = NULL) => 0.0093541367, 0.0093541367),
(_pp_src_all_iq = NULL) => -0.0005844953, -0.0005844953);

// Tree: 740 
final_score_740 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.200510396436405) => 
   map(
   (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 2.5) => -0.0227758607,
   (f_rel_ageover50_count_d > 2.5) => 0.0492661907,
   (f_rel_ageover50_count_d = NULL) => -0.0170499751, -0.0170499751),
(f_add_input_mobility_index_n > 0.200510396436405) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 33.5) => 0.0026378185,
   (f_rel_incomeover25_count_d > 33.5) => -0.0256239495,
   (f_rel_incomeover25_count_d = NULL) => 0.0017367974, 0.0017367974),
(f_add_input_mobility_index_n = NULL) => -0.0113436758, -0.0000078985);

// Tree: 741 
final_score_741 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 1.5) => 
   map(
   (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 157.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Property','Associate By SSN','Child','Daughter','Husband','Parent','Spouse','Wife']) => -0.0504461452,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Brother','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Neighbor','Relative','Sibling','Sister','Son','Subject','Subject at Household']) => -0.0160153837,
      (phone_subject_title = '') => -0.0190493360, -0.0190493360),
   (mth_pp_app_npa_effective_dt > 157.5) => 0.0214802018,
   (mth_pp_app_npa_effective_dt = NULL) => -0.0120260055, -0.0120260055),
(f_inq_count_i > 1.5) => 0.0022887166,
(f_inq_count_i = NULL) => 0.0006828303, 0.0006828303);

// Tree: 742 
final_score_742 := map(
(NULL < inq_num_adls and inq_num_adls <= 4.5) => 
   map(
   (NULL < _pp_rule_low_vend_conf and _pp_rule_low_vend_conf <= 0.5) => -0.0014942538,
   (_pp_rule_low_vend_conf > 0.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 53.5) => 0.0729774576,
      (f_prevaddrmurderindex_i > 53.5) => 0.0012678443,
      (f_prevaddrmurderindex_i = NULL) => 0.0230435384, 0.0230435384),
   (_pp_rule_low_vend_conf = NULL) => -0.0009083408, -0.0009083408),
(inq_num_adls > 4.5) => 0.0417111478,
(inq_num_adls = NULL) => -0.0005019885, -0.0005019885);

// Tree: 743 
final_score_743 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.40978699532796) => 
   map(
   (exp_source in ['P']) => -0.0131532073,
   (exp_source in ['S']) => 
      map(
      (phone_subject_title in ['Associate','Associate By Property','Daughter','Father','Grandfather','Grandmother','Husband','Mother','Neighbor','Parent','Relative','Sister','Son','Subject','Subject at Household','Wife']) => 0.0021395499,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandparent','Grandson','Sibling','Spouse']) => 0.0694595490,
      (phone_subject_title = '') => 0.0087378015, 0.0087378015),
   (exp_source = '') => 0.0039996471, 0.0036106396),
(f_add_curr_mobility_index_n > 0.40978699532796) => -0.0057831293,
(f_add_curr_mobility_index_n = NULL) => 0.0024785471, 0.0005131687);

// Tree: 744 
final_score_744 := map(
(NULL < subject_ssn_mismatch and subject_ssn_mismatch <= -0.5) => 
   map(
   (pp_src in ['CY','E1','E2','EN','FA','KW','PL','TN','UT','ZT']) => 0.0002509554,
   (pp_src in ['EM','EQ','FF','LA','LP','MD','NW','SL','UW','VO','VW','ZK']) => 0.0485501039,
   (pp_src = '') => 
      map(
      (exp_source in ['P']) => 0.0172663591,
      (exp_source in ['S']) => 0.0282044774,
      (exp_source = '') => 0.0051995080, 0.0085300542), 0.0098467916),
(subject_ssn_mismatch > -0.5) => -0.0024947531,
(subject_ssn_mismatch = NULL) => 0.0015319891, 0.0015319891);

// Tree: 745 
final_score_745 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 109.5) => -0.0081439229,
(f_prevaddrlenofres_d > 109.5) => 
   map(
   (phone_subject_title in ['Associate By Shared Associates','Child','Daughter','Grandfather','Mother','Neighbor','Relative','Sibling','Sister','Wife']) => -0.0222636160,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Parent','Son','Spouse','Subject','Subject at Household']) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 38.5) => -0.0049348587,
      (f_mos_inq_banko_cm_lseen_d > 38.5) => 0.0278124126,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0155321859, 0.0155321859),
   (phone_subject_title = '') => 0.0041184496, 0.0041184496),
(f_prevaddrlenofres_d = NULL) => -0.0025578322, -0.0025578322);

// Tree: 746 
final_score_746 := map(
(NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 1461) => -0.0027466210,
(eda_max_days_interrupt > 1461) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Father','Husband','Mother','Neighbor','Sibling','Sister','Son','Subject','Wife']) => 
      map(
      (NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => 0.0348537474,
      (f_util_add_input_conv_n > 0.5) => -0.0144447952,
      (f_util_add_input_conv_n = NULL) => 0.0079334197, 0.0079334197),
   (phone_subject_title in ['Associate By SSN','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Parent','Relative','Spouse','Subject at Household']) => 0.0771882375,
   (phone_subject_title = '') => 0.0155514496, 0.0155514496),
(eda_max_days_interrupt = NULL) => -0.0016137538, -0.0016137538);

// Tree: 747 
final_score_747 := map(
(NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 149.5) => -0.0021980680,
(f_prevaddrmurderindex_i > 149.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 353395) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 8.5) => 0.0100401212,
      (f_rel_incomeover50_count_d > 8.5) => -0.0161417799,
      (f_rel_incomeover50_count_d = NULL) => 0.0051725324, 0.0051725324),
   (f_prevaddrmedianvalue_d > 353395) => 0.0429447099,
   (f_prevaddrmedianvalue_d = NULL) => 0.0075188222, 0.0075188222),
(f_prevaddrmurderindex_i = NULL) => 0.0007461160, 0.0007461160);

// Tree: 748 
final_score_748 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 391.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 36.5) => 0.0047256884,
   (f_mos_inq_banko_cm_lseen_d > 36.5) => -0.0040043270,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0009697176, -0.0009697176),
(f_prevaddrlenofres_d > 391.5) => 
   map(
   (NULL < mth_pp_datevendorlastseen and mth_pp_datevendorlastseen <= 1.5) => -0.0014749418,
   (mth_pp_datevendorlastseen > 1.5) => -0.0596782316,
   (mth_pp_datevendorlastseen = NULL) => -0.0213672054, -0.0213672054),
(f_prevaddrlenofres_d = NULL) => -0.0013688264, -0.0013688264);

// Tree: 749 
final_score_749 := map(
(NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 2.5) => -0.0041285468,
(pp_app_ind_ph_cnt > 2.5) => 
   map(
   (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 54.5) => 
      map(
      (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 1.5) => 0.0040742467,
      (f_rel_incomeover75_count_d > 1.5) => 0.0666836445,
      (f_rel_incomeover75_count_d = NULL) => 0.0319006457, 0.0319006457),
   (mth_pp_app_npa_effective_dt > 54.5) => 0.0015568328,
   (mth_pp_app_npa_effective_dt = NULL) => 0.0036199708, 0.0036199708),
(pp_app_ind_ph_cnt = NULL) => -0.0017155302, -0.0017155302);

// Tree: 750 
final_score_750 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 537.5) => 
   map(
   (NULL < number_of_sources and number_of_sources <= 4.5) => -0.0032769998,
   (number_of_sources > 4.5) => 0.0291161934,
   (number_of_sources = NULL) => -0.0024532133, -0.0024532133),
(r_pb_order_freq_d > 537.5) => 0.0385381925,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 49.5) => 0.0025820819,
   (inq_adl_firstseen_n > 49.5) => -0.0509347183,
   (inq_adl_firstseen_n = NULL) => 0.0012957831, 0.0012957831), -0.0001935568);

// Tree: 751 
final_score_751 := map(
(NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 147.5) => -0.0034392647,
(f_prevaddrmurderindex_i > 147.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By SSN','Associate By Vehicle','Daughter','Grandson','Husband','Mother','Neighbor','Relative','Sister','Subject']) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 5.5) => 0.0177554230,
      (f_inq_count_i > 5.5) => -0.0091863918,
      (f_inq_count_i = NULL) => 0.0008778233, 0.0008778233),
   (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Parent','Sibling','Son','Spouse','Subject at Household','Wife']) => 0.0258668372,
   (phone_subject_title = '') => 0.0075637459, 0.0075637459),
(f_prevaddrmurderindex_i = NULL) => -0.0000627371, -0.0000627371);

// Tree: 752 
final_score_752 := map(
(pp_src in ['E1','EM','FA','KW','LP','PL','SL','TN','VW']) => -0.0385013198,
(pp_src in ['CY','E2','EN','EQ','FF','LA','MD','NW','UT','UW','VO','ZK','ZT']) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 34.5) => -0.0014187594,
   (mth_source_utildid_fseen > 34.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.46053847447743) => 0.0104710128,
      (f_add_curr_mobility_index_n > 0.46053847447743) => 0.0627443283,
      (f_add_curr_mobility_index_n = NULL) => 0.0253020465, 0.0253020465),
   (mth_source_utildid_fseen = NULL) => 0.0024111051, 0.0024111051),
(pp_src = '') => 0.0000846644, 0.0000764592);

// Tree: 753 
final_score_753 := map(
(NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 0.5) => -0.0050325225,
(inq_adl_firstseen_n > 0.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0433426198,
   (f_srchfraudsrchcount_i > 6.5) => 
      map(
      (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 7.5) => 0.0656531074,
      (inq_adl_lastseen_n > 7.5) => -0.0099117605,
      (inq_adl_lastseen_n = NULL) => 0.0020608550, 0.0020608550),
   (f_srchfraudsrchcount_i = NULL) => 0.0257613372, 0.0257613372),
(inq_adl_firstseen_n = NULL) => -0.0015855624, -0.0015855624);

// Tree: 754 
final_score_754 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 88018.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 68.5) => 0.0003304091,
   (mth_source_utildid_fseen > 68.5) => -0.0445550791,
   (mth_source_utildid_fseen = NULL) => -0.0002030475, -0.0002030475),
(f_addrchangeincomediff_d > 88018.5) => 0.0555858240,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By SSN','Child','Father','Grandfather','Grandson','Neighbor','Relative','Son','Spouse','Subject at Household','Wife']) => -0.0119943034,
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Daughter','Grandchild','Granddaughter','Grandmother','Grandparent','Husband','Mother','Parent','Sibling','Sister','Subject']) => 0.0097214397,
   (phone_subject_title = '') => 0.0027228507, 0.0027228507), 0.0008923276);

// Tree: 755 
final_score_755 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 1.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By SSN','Associate By Vehicle','Brother','Child','Grandmother','Mother','Subject at Household']) => -0.0285672398,
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => -0.0033716177,
   (phone_subject_title = '') => -0.0071176838, -0.0071176838),
(f_rel_incomeover50_count_d > 1.5) => 
   map(
   (NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 14.5) => -0.0253842647,
   (f_mos_acc_lseen_d > 14.5) => 0.0019239063,
   (f_mos_acc_lseen_d = NULL) => 0.0009693592, 0.0009693592),
(f_rel_incomeover50_count_d = NULL) => -0.0003620687, -0.0003620687);

// Tree: 756 
final_score_756 := map(
(NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 20.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 14.5) => 0.0034273684,
   (f_addrchangecrimediff_i > 14.5) => -0.0075346140,
   (f_addrchangecrimediff_i = NULL) => 0.0007393789, 0.0000661975),
(mth_source_cr_fseen > 20.5) => 
   map(
   (NULL < eda_address_match_best and eda_address_match_best <= 0.5) => -0.0160201013,
   (eda_address_match_best > 0.5) => -0.0597233835,
   (eda_address_match_best = NULL) => -0.0218350910, -0.0218350910),
(mth_source_cr_fseen = NULL) => -0.0012382255, -0.0012382255);

// Tree: 757 
final_score_757 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 6.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Brother','Child','Father','Grandfather','Grandmother','Grandparent','Grandson','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0009262782,
   (phone_subject_title in ['Associate','Associate By SSN','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Husband']) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 37139) => 0.0546725851,
      (f_curraddrmedianincome_d > 37139) => 0.0080439086,
      (f_curraddrmedianincome_d = NULL) => 0.0193999700, 0.0193999700),
   (phone_subject_title = '') => 0.0022595327, 0.0022595327),
(f_addrchangecrimediff_i > 6.5) => -0.0067914209,
(f_addrchangecrimediff_i = NULL) => 0.0000401833, -0.0009022768);

// Tree: 758 
final_score_758 := map(
(NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 153.5) => 
   map(
   (NULL < pp_total_source_conf and pp_total_source_conf <= 28.5) => 0.0020569695,
   (pp_total_source_conf > 28.5) => -0.0499366687,
   (pp_total_source_conf = NULL) => 0.0017208037, 0.0017208037),
(mth_pp_app_npa_last_change_dt > 153.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 20.5) => 0.0107054398,
   (mth_source_ppdid_lseen > 20.5) => 0.0663998534,
   (mth_source_ppdid_lseen = NULL) => 0.0255177839, 0.0255177839),
(mth_pp_app_npa_last_change_dt = NULL) => 0.0022747701, 0.0022747701);

// Tree: 759 
final_score_759 := map(
(NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 138.5) => 
   map(
   (NULL < eda_address_match_best and eda_address_match_best <= 0.5) => 
      map(
      (NULL < eda_min_days_connected_ind and eda_min_days_connected_ind <= 19.5) => -0.0002033105,
      (eda_min_days_connected_ind > 19.5) => -0.0304280740,
      (eda_min_days_connected_ind = NULL) => -0.0011750645, -0.0011750645),
   (eda_address_match_best > 0.5) => 0.0221975787,
   (eda_address_match_best = NULL) => 0.0002589473, 0.0002589473),
(mth_pp_datefirstseen > 138.5) => 0.0616684401,
(mth_pp_datefirstseen = NULL) => 0.0006923724, 0.0006923724);

// Tree: 760 
final_score_760 := map(
(NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 90.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Child','Daughter','Grandparent','Grandson','Parent','Son']) => 
      map(
      (NULL < r_mos_since_paw_fseen_d and r_mos_since_paw_fseen_d <= 151) => -0.0055987096,
      (r_mos_since_paw_fseen_d > 151) => -0.0600575181,
      (r_mos_since_paw_fseen_d = NULL) => -0.0096386806, -0.0096386806),
   (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Husband','Mother','Neighbor','Relative','Sibling','Sister','Spouse','Subject','Subject at Household','Wife']) => 0.0011779879,
   (phone_subject_title = '') => 0.0002688428, 0.0002688428),
(mth_source_ppla_fseen > 90.5) => -0.0358053497,
(mth_source_ppla_fseen = NULL) => 0.0000142330, 0.0000142330);

// Tree: 761 
final_score_761 := map(
(NULL < mth_pp_date_nonglb_lastseen and mth_pp_date_nonglb_lastseen <= 100.5) => 
   map(
   (pp_src in ['E1','E2','EN','FA','TN','VW']) => -0.0295377016,
   (pp_src in ['CY','EM','EQ','FF','KW','LA','LP','MD','NW','PL','SL','UT','UW','VO','ZK','ZT']) => 
      map(
      (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 6.5) => 0.0050804915,
      (f_crim_rel_under100miles_cnt_i > 6.5) => -0.0268419398,
      (f_crim_rel_under100miles_cnt_i = NULL) => 0.0014395961, 0.0014395961),
   (pp_src = '') => 0.0016631646, 0.0010661646),
(mth_pp_date_nonglb_lastseen > 100.5) => 0.0337567736,
(mth_pp_date_nonglb_lastseen = NULL) => 0.0014385688, 0.0014385688);

// Tree: 762 
final_score_762 := map(
(NULL < mth_pp_datefirstseen and mth_pp_datefirstseen <= 138.5) => 
   map(
   (NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 82.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0003936700,
      (f_varrisktype_i > 3.5) => -0.0172929360,
      (f_varrisktype_i = NULL) => -0.0006400208, -0.0006400208),
   (mth_source_ppla_fseen > 82.5) => -0.0335516201,
   (mth_source_ppla_fseen = NULL) => -0.0010340734, -0.0010340734),
(mth_pp_datefirstseen > 138.5) => 0.0400948001,
(mth_pp_datefirstseen = NULL) => -0.0007386951, -0.0007386951);

// Tree: 763 
final_score_763 := map(
(NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 20.5) => 
   map(
   (NULL < mth_source_cr_fseen and mth_source_cr_fseen <= 8.5) => -0.0008117270,
   (mth_source_cr_fseen > 8.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 64303.5) => 0.0600366710,
      (f_prevaddrmedianincome_d > 64303.5) => -0.0179780580,
      (f_prevaddrmedianincome_d = NULL) => 0.0321183566, 0.0321183566),
   (mth_source_cr_fseen = NULL) => 0.0004814297, 0.0004814297),
(mth_source_cr_fseen > 20.5) => -0.0197989190,
(mth_source_cr_fseen = NULL) => -0.0006787388, -0.0006787388);

// Tree: 764 
final_score_764 := map(
(NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 10.5) => 
   map(
   (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 6.5) => -0.0025824285,
   (f_rel_ageover40_count_d > 6.5) => 0.0073905900,
   (f_rel_ageover40_count_d = NULL) => -0.0004605633, -0.0004605633),
(mth_source_rel_fseen > 10.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 0.5) => -0.0053690769,
   (f_rel_homeover300_count_d > 0.5) => 0.0372639654,
   (f_rel_homeover300_count_d = NULL) => 0.0204016427, 0.0204016427),
(mth_source_rel_fseen = NULL) => -0.0001144098, -0.0001144098);

// Tree: 765 
final_score_765 := map(
(pp_src in ['E1','E2','EM','KW','LP','NW','PL','SL','TN','UT']) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 54166.5) => 0.0444849651,
   (f_curraddrmedianvalue_d > 54166.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 246) => -0.0209887999,
      (r_pb_order_freq_d > 246) => 0.0209651559,
      (r_pb_order_freq_d = NULL) => -0.0022744944, -0.0103812458),
   (f_curraddrmedianvalue_d = NULL) => -0.0073685289, -0.0073685289),
(pp_src in ['CY','EN','EQ','FA','FF','LA','MD','UW','VO','VW','ZK','ZT']) => 0.0083466357,
(pp_src = '') => 0.0000643643, -0.0001334437);

// Tree: 766 
final_score_766 := map(
(pp_did_type in ['AMBIG','CORE','NO_SSN']) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 49142.5) => -0.0168873396,
   (f_prevaddrmedianvalue_d > 49142.5) => 0.0045820457,
   (f_prevaddrmedianvalue_d = NULL) => 0.0027405932, 0.0027405932),
(pp_did_type in ['C_MERGE','INACTIVE']) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 4.5) => 0.0721496308,
   (f_assocsuspicousidcount_i > 4.5) => -0.0087625448,
   (f_assocsuspicousidcount_i = NULL) => 0.0281447633, 0.0281447633),
(pp_did_type = '') => -0.0001974626, 0.0014835562);

// Tree: 767 
final_score_767 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 13.5) => -0.0011760122,
(f_inq_count24_i > 13.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 27.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.547760621481345) => -0.0125049357,
      (f_add_input_mobility_index_n > 0.547760621481345) => 0.0421167878,
      (f_add_input_mobility_index_n = NULL) => 0.0015471260, 0.0015471260),
   (f_addrchangecrimediff_i > 27.5) => 0.0479495793,
   (f_addrchangecrimediff_i = NULL) => 0.0231915339, 0.0163538263),
(f_inq_count24_i = NULL) => -0.0002274561, -0.0002274561);

// Tree: 768 
final_score_768 := map(
(NULL < eda_address_match_best and eda_address_match_best <= 0.5) => -0.0010926696,
(eda_address_match_best > 0.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 88394) => 
      map(
      (phone_subject_title in ['Associate','Grandmother','Mother','Neighbor','Sister']) => -0.0214293139,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Parent','Relative','Sibling','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0297304490,
      (phone_subject_title = '') => 0.0150941914, 0.0150941914),
   (f_curraddrmedianincome_d > 88394) => -0.0466553866,
   (f_curraddrmedianincome_d = NULL) => 0.0079306672, 0.0079306672),
(eda_address_match_best = NULL) => -0.0006111121, -0.0006111121);

// Tree: 769 
final_score_769 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 51044.5) => -0.0066357010,
(f_curraddrmedianincome_d > 51044.5) => 
   map(
   (NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Daughter','Grandfather','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => -0.0006177089,
      (phone_subject_title in ['Associate','Child','Father','Grandchild','Granddaughter','Grandmother','Grandparent']) => 0.0180566657,
      (phone_subject_title = '') => 0.0010502383, 0.0010502383),
   (_inq_adl_ph_industry_flag > 0.5) => 0.0290255106,
   (_inq_adl_ph_industry_flag = NULL) => 0.0019767991, 0.0019767991),
(f_curraddrmedianincome_d = NULL) => -0.0022883883, -0.0022883883);

// Tree: 770 
final_score_770 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 16.5) => 
   map(
   (exp_source in ['P']) => -0.0064464144,
   (exp_source in ['S']) => 0.0150310094,
   (exp_source = '') => -0.0012278208, -0.0005665794),
(mth_exp_last_update > 16.5) => 
   map(
   (NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 35.5) => -0.0168189578,
   (mth_pp_orig_lastseen > 35.5) => 0.0245898768,
   (mth_pp_orig_lastseen = NULL) => -0.0124386156, -0.0124386156),
(mth_exp_last_update = NULL) => -0.0016088371, -0.0016088371);

// Tree: 771 
final_score_771 := map(
(NULL < mth_source_edaca_fseen and mth_source_edaca_fseen <= 12.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -116.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 44087) => 0.0385214146,
      (f_addrchangeincomediff_d > 44087) => -0.0168075526,
      (f_addrchangeincomediff_d = NULL) => 0.0195578573, 0.0195578573),
   (f_addrchangecrimediff_i > -116.5) => 0.0008086125,
   (f_addrchangecrimediff_i = NULL) => 0.0047171349, 0.0023937707),
(mth_source_edaca_fseen > 12.5) => -0.0240816202,
(mth_source_edaca_fseen = NULL) => 0.0017577843, 0.0017577843);

// Tree: 772 
final_score_772 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Child','Grandmother','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => -0.0011294623,
(phone_subject_title in ['Associate By Business','Associate By Property','Associate By Vehicle','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Spouse']) => 
   map(
   (NULL < f_estimated_income_d and f_estimated_income_d <= 41500) => 0.0654114766,
   (f_estimated_income_d > 41500) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.301258650458005) => -0.0398555967,
      (f_add_curr_mobility_index_n > 0.301258650458005) => 0.0414336048,
      (f_add_curr_mobility_index_n = NULL) => 0.0050806700, 0.0050806700),
   (f_estimated_income_d = NULL) => 0.0284789296, 0.0284789296),
(phone_subject_title = '') => -0.0001652465, -0.0001652465);

// Tree: 773 
final_score_773 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 8.5) => 
   map(
   (NULL < number_of_sources and number_of_sources <= 1.5) => -0.0032469483,
   (number_of_sources > 1.5) => -0.0351239499,
   (number_of_sources = NULL) => -0.0112929737, -0.0112929737),
(f_prevaddrageoldest_d > 8.5) => 
   map(
   (phone_switch_type in ['8','G','I','U']) => -0.0407450839,
   (phone_switch_type in ['C','P']) => 0.0034020727,
   (phone_switch_type = '') => 0.0028062000, 0.0028062000),
(f_prevaddrageoldest_d = NULL) => 0.0019001238, 0.0019001238);

// Tree: 774 
final_score_774 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 2.5) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By SSN','Brother','Child','Granddaughter','Grandson','Husband','Neighbor','Sibling','Son']) => -0.0204692512,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By Vehicle','Daughter','Father','Grandchild','Grandfather','Grandmother','Grandparent','Mother','Parent','Relative','Sister','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < _phone_timezone_match and _phone_timezone_match <= 0.5) => -0.0187413958,
      (_phone_timezone_match > 0.5) => 0.0090718430,
      (_phone_timezone_match = NULL) => 0.0069379589, 0.0069379589),
   (phone_subject_title = '') => 0.0009158304, 0.0009158304),
(f_util_adl_count_n > 2.5) => -0.0049008276,
(f_util_adl_count_n = NULL) => -0.0017245693, -0.0017245693);

// Tree: 775 
final_score_775 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 33.5) => 
   map(
   (pp_source in ['CELL','GONG','INQUIRY','INTRADO','OTHER','PCNSR','TARGUS','THRIVE']) => -0.0043807132,
   (pp_source in ['HEADER','IBEHAVIOR','INFUTOR']) => 
      map(
      (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 11.5) => 0.0254202549,
      (mth_pp_datevendorfirstseen > 11.5) => 0.0013430936,
      (mth_pp_datevendorfirstseen = NULL) => 0.0101429393, 0.0101429393),
   (pp_source = '') => -0.0013703501, 0.0007087480),
(mth_source_ppdid_lseen > 33.5) => -0.0207638478,
(mth_source_ppdid_lseen = NULL) => -0.0006525657, -0.0006525657);

// Tree: 776 
final_score_776 := map(
(NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 11.5) => 0.0008681622,
(mth_pp_first_build_date > 11.5) => 
   map(
   (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 34.5) => 
      map(
      (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 0.5) => 0.0120469536,
      (f_srchfraudsrchcountyr_i > 0.5) => -0.0295515529,
      (f_srchfraudsrchcountyr_i = NULL) => 0.0002291961, 0.0002291961),
   (mth_pp_eda_hist_did_dt > 34.5) => -0.0226078086,
   (mth_pp_eda_hist_did_dt = NULL) => -0.0117935140, -0.0117935140),
(mth_pp_first_build_date = NULL) => -0.0008799518, -0.0008799518);

// Tree: 777 
final_score_777 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 11.5) => -0.0236574428,
(f_mos_inq_banko_cm_lseen_d > 11.5) => 
   map(
   (NULL < _pp_rule_ins_ver_above and _pp_rule_ins_ver_above <= 0.5) => 0.0007876818,
   (_pp_rule_ins_ver_above > 0.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.53586684107377) => 0.0104718526,
      (f_add_input_mobility_index_n > 0.53586684107377) => 0.0454799635,
      (f_add_input_mobility_index_n = NULL) => 0.0192238803, 0.0192238803),
   (_pp_rule_ins_ver_above = NULL) => 0.0015221166, 0.0015221166),
(f_mos_inq_banko_cm_lseen_d = NULL) => 0.0007613672, 0.0007613672);

// Tree: 778 
final_score_778 := map(
(NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 90.5) => 
   map(
   (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 7.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By SSN','Brother','Child','Daughter','Husband','Mother','Neighbor','Parent','Sister','Spouse','Subject','Subject at Household']) => 0.0051627094,
      (phone_subject_title in ['Associate By Business','Associate By Shared Associates','Associate By Vehicle','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Relative','Sibling','Son','Wife']) => 0.0666490363,
      (phone_subject_title = '') => 0.0101251363, 0.0101251363),
   (f_rel_ageover20_count_d > 7.5) => -0.0009497942,
   (f_rel_ageover20_count_d = NULL) => 0.0022626011, 0.0022626011),
(mth_source_ppla_fseen > 90.5) => -0.0383294674,
(mth_source_ppla_fseen = NULL) => 0.0019358943, 0.0019358943);

// Tree: 779 
final_score_779 := map(
(NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 35.5) => 
   map(
   (phone_subject_title in ['Associate By Property','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Mother','Sibling','Son']) => -0.0211306762,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Grandmother','Neighbor','Parent','Relative','Sister','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 354) => 0.0012979625,
      (mth_source_inf_fseen > 354) => -0.0362531578,
      (mth_source_inf_fseen = NULL) => 0.0010338968, 0.0010338968),
   (phone_subject_title = '') => 0.0001525245, 0.0001525245),
(f_rel_homeover100_count_d > 35.5) => 0.0359176469,
(f_rel_homeover100_count_d = NULL) => 0.0003968218, 0.0003968218);

// Tree: 780 
final_score_780 := map(
(pp_src in ['CY','E1','EN','EQ','FA','LP','PL','SL','TN','UT','VO','ZT']) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 15.5) => -0.0082827909,
   (f_rel_homeover300_count_d > 15.5) => 0.0447818745,
   (f_rel_homeover300_count_d = NULL) => -0.0059773900, -0.0059773900),
(pp_src in ['E2','EM','FF','KW','LA','MD','NW','UW','VW','ZK']) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.60342358231004) => 0.0254609522,
   (f_add_input_mobility_index_n > 0.60342358231004) => -0.0332466093,
   (f_add_input_mobility_index_n = NULL) => 0.0155775244, 0.0155775244),
(pp_src = '') => -0.0014335877, -0.0015404078);

// Tree: 781 
final_score_781 := map(
(NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 93.5) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 2.5) => 
      map(
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By SSN','Brother','Child','Daughter','Grandfather','Grandmother','Husband','Mother','Neighbor','Sibling','Son']) => -0.0302739437,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By Vehicle','Father','Grandchild','Granddaughter','Grandparent','Grandson','Parent','Relative','Sister','Spouse','Subject','Subject at Household','Wife']) => 0.0163627184,
      (phone_subject_title = '') => 0.0075267153, 0.0075267153),
   (f_sourcerisktype_i > 2.5) => -0.0019047419,
   (f_sourcerisktype_i = NULL) => -0.0005174856, -0.0005174856),
(mth_source_ppfla_fseen > 93.5) => -0.0356213890,
(mth_source_ppfla_fseen = NULL) => -0.0008347942, -0.0008347942);

// Tree: 782 
final_score_782 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -83.5) => 
   map(
   (NULL < number_of_sources and number_of_sources <= 1.5) => 0.0010231175,
   (number_of_sources > 1.5) => 0.0267967021,
   (number_of_sources = NULL) => 0.0082669356, 0.0082669356),
(f_addrchangecrimediff_i > -83.5) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 21001.5) => 0.0304249995,
   (f_prevaddrmedianincome_d > 21001.5) => -0.0036921887,
   (f_prevaddrmedianincome_d = NULL) => -0.0022795731, -0.0022795731),
(f_addrchangecrimediff_i = NULL) => -0.0047204426, -0.0020496928);

// Tree: 783 
final_score_783 := map(
(NULL < source_rel and source_rel <= 0.5) => 
   map(
   (NULL < inq_num and inq_num <= 0.5) => -0.0038574950,
   (inq_num > 0.5) => 
      map(
      (phone_subject_title in ['Associate','Father','Mother','Subject','Subject at Household']) => 0.0065311861,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Wife']) => 0.0721226106,
      (phone_subject_title = '') => 0.0100652069, 0.0100652069),
   (inq_num = NULL) => -0.0021841020, -0.0021841020),
(source_rel > 0.5) => 0.0145212375,
(source_rel = NULL) => -0.0014497786, -0.0014497786);

// Tree: 784 
final_score_784 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 75025) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Child','Daughter','Grandfather','Grandmother','Grandparent','Grandson','Parent','Subject at Household']) => -0.0289422338,
   (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Brother','Father','Grandchild','Granddaughter','Husband','Mother','Neighbor','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Father','Mother','Neighbor','Relative','Sister','Son','Subject']) => -0.0083897392,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Parent','Sibling','Spouse','Subject at Household','Wife']) => 0.0536776679,
      (phone_subject_title = '') => -0.0052951272, -0.0052951272),
   (phone_subject_title = '') => -0.0086541996, -0.0086541996),
(f_curraddrmedianvalue_d > 75025) => 0.0010721421,
(f_curraddrmedianvalue_d = NULL) => -0.0004202340, -0.0004202340);

// Tree: 785 
final_score_785 := map(
(NULL < _pp_app_nonpub_gong_la and _pp_app_nonpub_gong_la <= 0.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 147) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 1.5) => 0.0196600318,
      (f_sourcerisktype_i > 1.5) => -0.0023649247,
      (f_sourcerisktype_i = NULL) => -0.0016160596, -0.0016160596),
   (mth_source_ppdid_fseen > 147) => 0.0363215200,
   (mth_source_ppdid_fseen = NULL) => -0.0013457205, -0.0013457205),
(_pp_app_nonpub_gong_la > 0.5) => 0.0342801707,
(_pp_app_nonpub_gong_la = NULL) => -0.0010060482, -0.0010060482);

// Tree: 786 
final_score_786 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 595992.5) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => -0.0029704178,
   (f_sourcerisktype_i > 5.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Child','Granddaughter','Grandfather','Grandmother','Husband','Mother','Neighbor','Parent','Relative','Sister','Subject','Subject at Household']) => 0.0023602237,
      (phone_subject_title in ['Associate By Property','Associate By Vehicle','Brother','Daughter','Father','Grandchild','Grandparent','Grandson','Sibling','Son','Spouse','Wife']) => 0.0654913661,
      (phone_subject_title = '') => 0.0059876852, 0.0059876852),
   (f_sourcerisktype_i = NULL) => -0.0008138795, -0.0008138795),
(f_prevaddrmedianvalue_d > 595992.5) => -0.0254918323,
(f_prevaddrmedianvalue_d = NULL) => -0.0014098177, -0.0014098177);

// Tree: 787 
final_score_787 := map(
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Father','Granddaughter','Grandmother','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Wife']) => -0.0252593750,
(phone_subject_title in ['Associate','Associate By Property','Associate By Vehicle','Grandchild','Grandfather','Grandparent','Spouse','Subject','Subject at Household']) => 
   map(
   (NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => 
      map(
      (NULL < eda_address_match_best and eda_address_match_best <= 0.5) => 0.0089137582,
      (eda_address_match_best > 0.5) => 0.0660833407,
      (eda_address_match_best = NULL) => 0.0124459750, 0.0124459750),
   (_inq_adl_ph_industry_flag > 0.5) => 0.0772685384,
   (_inq_adl_ph_industry_flag = NULL) => 0.0161740879, 0.0161740879),
(phone_subject_title = '') => -0.0038500337, -0.0038500337);

// Tree: 788 
final_score_788 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -52014.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 19.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 341995.5) => -0.0034744130,
      (f_prevaddrmedianvalue_d > 341995.5) => 0.0505538990,
      (f_prevaddrmedianvalue_d = NULL) => 0.0155740304, 0.0155740304),
   (f_prevaddrmurderindex_i > 19.5) => -0.0129595296,
   (f_prevaddrmurderindex_i = NULL) => -0.0094070672, -0.0094070672),
(f_addrchangevaluediff_d > -52014.5) => 0.0009009861,
(f_addrchangevaluediff_d = NULL) => -0.0033851992, -0.0017714579);

// Tree: 789 
final_score_789 := map(
(NULL < mth_phone_fb_rp_date and mth_phone_fb_rp_date <= 34.5) => 
   map(
   (NULL < mth_pp_app_fb_ph7_did_dt and mth_pp_app_fb_ph7_did_dt <= 7.5) => 
      map(
      (NULL < _pp_app_fb_ph and _pp_app_fb_ph <= 1.5) => 0.0315622736,
      (_pp_app_fb_ph > 1.5) => 0.0020447695,
      (_pp_app_fb_ph = NULL) => 0.0022889331, 0.0022889331),
   (mth_pp_app_fb_ph7_did_dt > 7.5) => -0.0346408534,
   (mth_pp_app_fb_ph7_did_dt = NULL) => 0.0020276154, 0.0020276154),
(mth_phone_fb_rp_date > 34.5) => -0.0244384220,
(mth_phone_fb_rp_date = NULL) => 0.0014967217, 0.0014967217);

// Tree: 790 
final_score_790 := map(
(NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 137.5) => -0.0014164507,
(mth_pp_app_npa_last_change_dt > 137.5) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 33) => 0.0610163719,
   (f_curraddrburglaryindex_i > 33) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 8.5) => -0.0016113407,
      (f_inq_count24_i > 8.5) => 0.0506044670,
      (f_inq_count24_i = NULL) => 0.0059197854, 0.0059197854),
   (f_curraddrburglaryindex_i = NULL) => 0.0125593317, 0.0125593317),
(mth_pp_app_npa_last_change_dt = NULL) => -0.0005979087, -0.0005979087);

// Tree: 791 
final_score_791 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 536) => -0.0022048591,
(r_pb_order_freq_d > 536) => 0.0271401737,
(r_pb_order_freq_d = NULL) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By SSN','Associate By Vehicle','Daughter','Father','Grandfather','Grandson','Neighbor','Parent','Sister','Subject','Subject at Household']) => -0.0032045047,
   (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Brother','Child','Grandchild','Granddaughter','Grandmother','Grandparent','Husband','Mother','Relative','Sibling','Son','Spouse','Wife']) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 129.5) => 0.0031242591,
      (f_fp_prevaddrcrimeindex_i > 129.5) => 0.0669469304,
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.0315919254, 0.0315919254),
   (phone_subject_title = '') => 0.0028698485, 0.0028698485), 0.0003742399);

// Tree: 792 
final_score_792 := map(
(exp_type in ['C']) => 
   map(
   (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 6.5) => 0.0022941029,
   (pp_app_ind_ph_cnt > 6.5) => 
      map(
      (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 1.5) => -0.0412033345,
      (f_rel_homeover200_count_d > 1.5) => 0.0004707030,
      (f_rel_homeover200_count_d = NULL) => -0.0198320332, -0.0198320332),
   (pp_app_ind_ph_cnt = NULL) => -0.0032516510, -0.0032516510),
(exp_type in ['N']) => 0.0074573865,
(exp_type = '') => 0.0003915986, 0.0007466807);

// Tree: 793 
final_score_793 := map(
(exp_type in ['N']) => 0.0286163637,
(exp_type in ['C']) => 0.0440789699,
(exp_type = '') => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => 
      map(
      (NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => -0.0183528420,
      (_inq_adl_ph_industry_flag > 0.5) => 0.0958595960,
      (_inq_adl_ph_industry_flag = NULL) => -0.0165443400, -0.0165443400),
   (source_rel > 0.5) => 0.0420709371,
   (source_rel = NULL) => -0.0135686258, -0.0135686258), -0.0040144547);

// Tree: 794 
final_score_794 := map(
(NULL < _internal_ver_match_spouse and _internal_ver_match_spouse <= 0.5) => 
   map(
   (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 12.5) => 0.0011825243,
   (f_rel_ageover40_count_d > 12.5) => 
      map(
      (NULL < f_estimated_income_d and f_estimated_income_d <= 35500) => 0.0324847389,
      (f_estimated_income_d > 35500) => -0.0232342982,
      (f_estimated_income_d = NULL) => -0.0129043643, -0.0129043643),
   (f_rel_ageover40_count_d = NULL) => 0.0005490058, 0.0005490058),
(_internal_ver_match_spouse > 0.5) => 0.0214019861,
(_internal_ver_match_spouse = NULL) => 0.0008975883, 0.0008975883);

// Tree: 795 
final_score_795 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 19.5) => 0.0007099685,
(mth_exp_last_update > 19.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 71) => -0.0245068302,
   (f_mos_inq_banko_cm_lseen_d > 71) => 
      map(
      (NULL < f_util_add_input_misc_n and f_util_add_input_misc_n <= 0.5) => 0.0221819073,
      (f_util_add_input_misc_n > 0.5) => -0.0124999207,
      (f_util_add_input_misc_n = NULL) => 0.0044408184, 0.0044408184),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0123084694, -0.0123084694),
(mth_exp_last_update = NULL) => -0.0002846298, -0.0002846298);

// Tree: 796 
final_score_796 := map(
(NULL < mth_pp_datevendorlastseen and mth_pp_datevendorlastseen <= 6.5) => 0.0013972759,
(mth_pp_datevendorlastseen > 6.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 5.5) => 0.0121590082,
      (f_rel_incomeover50_count_d > 5.5) => -0.0085035836,
      (f_rel_incomeover50_count_d = NULL) => 0.0024542930, 0.0024542930),
   (f_corrrisktype_i > 6.5) => -0.0199217616,
   (f_corrrisktype_i = NULL) => -0.0086223315, -0.0086223315),
(mth_pp_datevendorlastseen = NULL) => -0.0003470986, -0.0003470986);

// Tree: 797 
final_score_797 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 407003.5) => -0.0024099180,
(f_prevaddrmedianvalue_d > 407003.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Child','Father','Husband','Neighbor','Parent','Sibling','Son','Wife']) => -0.0145518554,
   (phone_subject_title in ['Associate','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Mother','Relative','Sister','Spouse','Subject','Subject at Household']) => 
      map(
      (NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 29.5) => 0.0258855448,
      (mth_eda_dt_first_seen > 29.5) => -0.0086378848,
      (mth_eda_dt_first_seen = NULL) => 0.0172176451, 0.0172176451),
   (phone_subject_title = '') => 0.0059531131, 0.0059531131),
(f_prevaddrmedianvalue_d = NULL) => -0.0016621646, -0.0016621646);

// Tree: 798 
final_score_798 := map(
(NULL < f_idrisktype_i and f_idrisktype_i <= 1.5) => 
   map(
   (pp_app_ph_type in ['LNDLN PRTD TO CELL','VOIP']) => -0.0292870167,
   (pp_app_ph_type in ['CELL','PAGE','POTS','Puerto Rico/US Virgin Isl']) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 385) => 0.0047992189,
      (f_prevaddrlenofres_d > 385) => -0.0308511396,
      (f_prevaddrlenofres_d = NULL) => 0.0041881290, 0.0041881290),
   (pp_app_ph_type = '') => -0.0012942051, 0.0008873047),
(f_idrisktype_i > 1.5) => -0.0206408580,
(f_idrisktype_i = NULL) => -0.0000110349, -0.0000110349);

// Tree: 799 
final_score_799 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 341.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.203952454195515) => -0.0138958830,
   (f_add_input_mobility_index_n > 0.203952454195515) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.208384583973055) => 0.0483863353,
      (f_add_input_mobility_index_n > 0.208384583973055) => -0.0004190546,
      (f_add_input_mobility_index_n = NULL) => -0.0000525737, -0.0000525737),
   (f_add_input_mobility_index_n = NULL) => -0.0124122631, -0.0014090125),
(f_prevaddrlenofres_d > 341.5) => 0.0171375344,
(f_prevaddrlenofres_d = NULL) => -0.0005156733, -0.0005156733);

// Tree: 800 
final_score_800 := map(
(NULL < _pp_rule_ins_ver_above and _pp_rule_ins_ver_above <= 0.5) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 1.5) => 0.0212748587,
   (f_sourcerisktype_i > 1.5) => -0.0020125689,
   (f_sourcerisktype_i = NULL) => -0.0013122401, -0.0013122401),
(_pp_rule_ins_ver_above > 0.5) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 86.5) => 0.0336293853,
   (mth_pp_app_npa_last_change_dt > 86.5) => -0.0007393168,
   (mth_pp_app_npa_last_change_dt = NULL) => 0.0164450342, 0.0164450342),
(_pp_rule_ins_ver_above = NULL) => -0.0006658015, -0.0006658015);

// Tree: 801 
final_score_801 := map(
(NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 171) => 0.0088584343,
(f_mos_acc_lseen_d > 171) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 197.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 175.5) => -0.0024316894,
      (f_curraddrcrimeindex_i > 175.5) => 0.0122847816,
      (f_curraddrcrimeindex_i = NULL) => -0.0005874201, -0.0005874201),
   (f_curraddrmurderindex_i > 197.5) => -0.0356020669,
   (f_curraddrmurderindex_i = NULL) => -0.0011121203, -0.0011121203),
(f_mos_acc_lseen_d = NULL) => 0.0005362624, 0.0005362624);

// Tree: 802 
final_score_802 := map(
(NULL < mth_source_ppca_fseen and mth_source_ppca_fseen <= 6.5) => 0.0007238614,
(mth_source_ppca_fseen > 6.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 47.5) => -0.0055943971,
   (f_addrchangecrimediff_i > 47.5) => -0.0390211567,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 77071) => -0.0181291956,
      (f_curraddrmedianincome_d > 77071) => 0.0346325247,
      (f_curraddrmedianincome_d = NULL) => -0.0086054194, -0.0086054194), -0.0108178351),
(mth_source_ppca_fseen = NULL) => -0.0006109509, -0.0006109509);

// Tree: 803 
final_score_803 := map(
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Daughter','Father','Granddaughter','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Relative','Sibling','Sister','Son','Spouse']) => -0.0163543013,
(phone_subject_title in ['Associate','Associate By Property','Child','Grandchild','Grandparent','Parent','Subject','Subject at Household','Wife']) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 17.5) => 
      map(
      (NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 11.5) => 0.0207697723,
      (mth_source_ppth_lseen > 11.5) => -0.0345019672,
      (mth_source_ppth_lseen = NULL) => 0.0155564609, 0.0155564609),
   (mth_source_ppdid_lseen > 17.5) => -0.0110821282,
   (mth_source_ppdid_lseen = NULL) => 0.0082817903, 0.0082817903),
(phone_subject_title = '') => -0.0032736227, -0.0032736227);

// Tree: 804 
final_score_804 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 50971.5) => -0.0025566687,
(f_addrchangeincomediff_d > 50971.5) => 
   map(
   (pp_source in ['CELL','GONG','INFUTOR','INQUIRY','OTHER']) => 0.0110893795,
   (pp_source in ['HEADER','IBEHAVIOR','INTRADO','PCNSR','TARGUS','THRIVE']) => 0.0474900209,
   (pp_source = '') => -0.0117139408, 0.0044519670),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 17.5) => 0.0026017250,
   (f_rel_homeover200_count_d > 17.5) => 0.0308180051,
   (f_rel_homeover200_count_d = NULL) => 0.0039533197, 0.0039533197), -0.0006604480);

// Tree: 805 
final_score_805 := map(
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Brother','Daughter','Father','Grandfather','Grandmother','Grandparent','Grandson','Neighbor','Relative','Sibling','Sister','Subject','Subject at Household']) => -0.0012991364,
(phone_subject_title in ['Associate','Associate By Shared Associates','Child','Grandchild','Granddaughter','Husband','Mother','Parent','Son','Spouse','Wife']) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -7162) => -0.0068430274,
   (f_addrchangeincomediff_d > -7162) => 0.0156755566,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 0.5) => -0.0086460206,
      (f_rel_homeover500_count_d > 0.5) => 0.0318057911,
      (f_rel_homeover500_count_d = NULL) => 0.0016769937, 0.0016769937), 0.0065620681),
(phone_subject_title = '') => 0.0000889367, 0.0000889367);

// Tree: 806 
final_score_806 := map(
(NULL < _pp_rule_seen_once and _pp_rule_seen_once <= 0.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 57.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 33900.5) => -0.0075598436,
      (f_curraddrmedianincome_d > 33900.5) => 0.0015569915,
      (f_curraddrmedianincome_d = NULL) => -0.0002443464, -0.0002443464),
   (f_srchaddrsrchcount_i > 57.5) => 0.0279730246,
   (f_srchaddrsrchcount_i = NULL) => 0.0000299501, 0.0000299501),
(_pp_rule_seen_once > 0.5) => 0.0373991474,
(_pp_rule_seen_once = NULL) => 0.0002705640, 0.0002705640);

// Tree: 807 
final_score_807 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 13.5) => -0.0212061344,
(f_mos_inq_banko_cm_lseen_d > 13.5) => 
   map(
   (NULL < eda_days_in_service and eda_days_in_service <= 533.5) => 
      map(
      (NULL < mth_phone_fb_rp_date and mth_phone_fb_rp_date <= 29.5) => 0.0043203219,
      (mth_phone_fb_rp_date > 29.5) => -0.0285388118,
      (mth_phone_fb_rp_date = NULL) => 0.0036164769, 0.0036164769),
   (eda_days_in_service > 533.5) => -0.0054058170,
   (eda_days_in_service = NULL) => 0.0004465445, 0.0004465445),
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0003632523, -0.0003632523);

// Tree: 808 
final_score_808 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.201780675172665) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 54.5) => 0.0048415740,
   (f_fp_prevaddrburglaryindex_i > 54.5) => -0.0219914728,
   (f_fp_prevaddrburglaryindex_i = NULL) => -0.0119457675, -0.0119457675),
(f_add_curr_mobility_index_n > 0.201780675172665) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.20565985271069) => 0.0588227620,
   (f_add_curr_mobility_index_n > 0.20565985271069) => 0.0008951594,
   (f_add_curr_mobility_index_n = NULL) => 0.0013054800, 0.0013054800),
(f_add_curr_mobility_index_n = NULL) => 0.0100351330, 0.0000640897);

// Tree: 809 
final_score_809 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 11.5) => 0.0015247213,
(mth_exp_last_update > 11.5) => 
   map(
   (NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 2.5) => 0.0238021941,
   (f_componentcharrisktype_i > 2.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.52528762764107) => -0.0078707521,
      (f_add_curr_mobility_index_n > 0.52528762764107) => -0.0352479462,
      (f_add_curr_mobility_index_n = NULL) => -0.0119736013, -0.0119736013),
   (f_componentcharrisktype_i = NULL) => -0.0081713429, -0.0081713429),
(mth_exp_last_update = NULL) => 0.0005306226, 0.0005306226);

// Tree: 810 
final_score_810 := map(
(NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 1.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 4.5) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 3.5) => 0.0028272291,
      (f_rel_count_i > 3.5) => 0.0427981673,
      (f_rel_count_i = NULL) => 0.0203785705, 0.0203785705),
   (f_rel_ageover30_count_d > 4.5) => -0.0239217163,
   (f_rel_ageover30_count_d = NULL) => 0.0131337515, 0.0131337515),
(f_rel_educationover12_count_d > 1.5) => -0.0014747004,
(f_rel_educationover12_count_d = NULL) => -0.0007973070, -0.0007973070);

// Tree: 811 
final_score_811 := map(
(pp_source in ['CELL','GONG','INFUTOR','INQUIRY','INTRADO','OTHER','PCNSR','TARGUS','THRIVE']) => -0.0003834514,
(pp_source in ['HEADER','IBEHAVIOR']) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 1.5) => 
      map(
      (NULL < internal_verification and internal_verification <= 0.5) => -0.0068127278,
      (internal_verification > 0.5) => 0.0288717555,
      (internal_verification = NULL) => 0.0194713370, 0.0194713370),
   (f_srchssnsrchcount_i > 1.5) => -0.0006945466,
   (f_srchssnsrchcount_i = NULL) => 0.0088585855, 0.0088585855),
(pp_source = '') => -0.0035676393, -0.0007449179);

// Tree: 812 
final_score_812 := map(
(NULL < f_wealth_index_d and f_wealth_index_d <= 4.5) => 
   map(
   (NULL < mth_exp_last_update and mth_exp_last_update <= 61.5) => 
      map(
      (exp_source in ['P']) => -0.0011694434,
      (exp_source in ['S']) => 0.0137320902,
      (exp_source = '') => -0.0044867909, -0.0022159969),
   (mth_exp_last_update > 61.5) => -0.0345811864,
   (mth_exp_last_update = NULL) => -0.0029307837, -0.0029307837),
(f_wealth_index_d > 4.5) => 0.0200591236,
(f_wealth_index_d = NULL) => -0.0006958515, -0.0006958515);

// Tree: 813 
final_score_813 := map(
(NULL < inq_num and inq_num <= 0.5) => -0.0017817506,
(inq_num > 0.5) => 
   map(
   (pp_glb_dppa_fl in ['U']) => -0.0166776254,
   (pp_glb_dppa_fl in ['B','D','G']) => 0.0038627224,
   (pp_glb_dppa_fl = '') => 
      map(
      (phone_subject_title in ['Associate','Father','Mother','Subject']) => 0.0132243240,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject at Household','Wife']) => 0.0602615441,
      (phone_subject_title = '') => 0.0247126773, 0.0247126773), 0.0073702124),
(inq_num = NULL) => -0.0007380461, -0.0007380461);

// Tree: 814 
final_score_814 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.33182982985171) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Brother','Child','Granddaughter','Grandfather','Grandmother','Grandson','Sibling','Spouse','Subject at Household','Wife']) => -0.0116267051,
   (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By Vehicle','Daughter','Father','Grandchild','Grandparent','Husband','Mother','Neighbor','Parent','Relative','Sister','Son','Subject']) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 14.5) => 0.0212572666,
      (f_prevaddrmurderindex_i > 14.5) => -0.0028186483,
      (f_prevaddrmurderindex_i = NULL) => -0.0007457302, -0.0007457302),
   (phone_subject_title = '') => -0.0028112614, -0.0028112614),
(f_add_curr_mobility_index_n > 0.33182982985171) => 0.0030590065,
(f_add_curr_mobility_index_n = NULL) => 0.0116120061, 0.0003987504);

// Tree: 815 
final_score_815 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -115.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Brother','Mother','Neighbor','Parent','Relative','Sibling','Sister','Subject','Wife']) => 
      map(
      (segment in ['0 - Disconnected','1 - Other','3 - ExpHit']) => -0.0098654659,
      (segment in ['2 - Cell Phone']) => 0.0381123012,
      (segment = '') => 0.0018801286, 0.0018801286),
   (phone_subject_title in ['Associate','Associate By Property','Associate By SSN','Associate By Vehicle','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Son','Spouse','Subject at Household']) => 0.0423067664,
   (phone_subject_title = '') => 0.0093918349, 0.0093918349),
(f_addrchangecrimediff_i > -115.5) => -0.0019279313,
(f_addrchangecrimediff_i = NULL) => -0.0010665191, -0.0012975817);

// Tree: 816 
final_score_816 := map(
(exp_source in ['P']) => -0.0068689586,
(exp_source in ['S']) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 40.5) => -0.0076477834,
   (f_mos_inq_banko_cm_lseen_d > 40.5) => 
      map(
      (NULL < mth_exp_last_update and mth_exp_last_update <= 11.5) => 0.0344489058,
      (mth_exp_last_update > 11.5) => 0.0083666125,
      (mth_exp_last_update = NULL) => 0.0161489216, 0.0161489216),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0062764770, 0.0062764770),
(exp_source = '') => -0.0009682400, -0.0002664313);

// Tree: 817 
final_score_817 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 15.5) => 0.0006531361,
(mth_exp_last_update > 15.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.44242889482104) => 
      map(
      (pp_source in ['GONG','HEADER','INFUTOR','INQUIRY','PCNSR']) => -0.0060366304,
      (pp_source in ['CELL','IBEHAVIOR','INTRADO','OTHER','TARGUS','THRIVE']) => 0.0321124460,
      (pp_source = '') => -0.0103633072, -0.0031338457),
   (f_add_curr_mobility_index_n > 0.44242889482104) => -0.0257755151,
   (f_add_curr_mobility_index_n = NULL) => -0.0090623051, -0.0090623051),
(mth_exp_last_update = NULL) => -0.0002154310, -0.0002154310);

// Tree: 818 
final_score_818 := map(
(NULL < number_of_sources and number_of_sources <= 1.5) => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => -0.0195576362,
   (source_rel > 0.5) => 0.0592072550,
   (source_rel = NULL) => -0.0153905316, -0.0153905316),
(number_of_sources > 1.5) => 
   map(
   (exp_source in ['S']) => 0.0527619746,
   (exp_source in ['P']) => 0.0564717156,
   (exp_source = '') => 0.0148129926, 0.0333080632),
(number_of_sources = NULL) => -0.0025947889, -0.0025947889);

// Tree: 819 
final_score_819 := map(
(NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 1.09014101574821) => -0.0009613923,
(f_add_input_mobility_index_n > 1.09014101574821) => 
   map(
   (NULL < f_adl_util_misc_n and f_adl_util_misc_n <= 0.5) => 
      map(
      (NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 2.5) => 0.0300991151,
      (mth_pp_orig_lastseen > 2.5) => -0.0294269932,
      (mth_pp_orig_lastseen = NULL) => -0.0002475283, -0.0002475283),
   (f_adl_util_misc_n > 0.5) => 0.0414175415,
   (f_adl_util_misc_n = NULL) => 0.0195111645, 0.0195111645),
(f_add_input_mobility_index_n = NULL) => -0.0037727085, -0.0004953647);

// Tree: 820 
final_score_820 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -115.5) => 0.0186833346,
(f_addrchangecrimediff_i > -115.5) => 
   map(
   (NULL < mth_source_md_fseen and mth_source_md_fseen <= 8.5) => 0.0004234485,
   (mth_source_md_fseen > 8.5) => -0.0212990403,
   (mth_source_md_fseen = NULL) => -0.0003869241, -0.0003869241),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 72.5) => -0.0096073992,
   (f_curraddrcartheftindex_i > 72.5) => 0.0062792001,
   (f_curraddrcartheftindex_i = NULL) => 0.0005669866, 0.0005669866), 0.0005044662);

// Tree: 821 
final_score_821 := map(
(NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 24) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 334.5) => 
      map(
      (NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 160.5) => 0.0014617192,
      (mth_pp_app_npa_effective_dt > 160.5) => 0.0215698781,
      (mth_pp_app_npa_effective_dt = NULL) => 0.0064413340, 0.0064413340),
   (f_prevaddrageoldest_d > 334.5) => 0.0483272409,
   (f_prevaddrageoldest_d = NULL) => 0.0098448476, 0.0098448476),
(f_fp_prevaddrcrimeindex_i > 24) => -0.0002898898,
(f_fp_prevaddrcrimeindex_i = NULL) => 0.0008685452, 0.0008685452);

// Tree: 822 
final_score_822 := map(
(eda_pfrd_address_ind in ['1A','1B','XX']) => -0.0011497523,
(eda_pfrd_address_ind in ['1C','1D','1E']) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Vehicle','Brother','Child','Grandfather','Neighbor','Sibling','Son','Subject at Household']) => -0.0123016188,
   (phone_subject_title in ['Associate By Shared Associates','Associate By SSN','Daughter','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Mother','Parent','Relative','Sister','Spouse','Subject','Wife']) => 
      map(
      (NULL < eda_days_in_service and eda_days_in_service <= 586) => 0.0701803867,
      (eda_days_in_service > 586) => 0.0159826672,
      (eda_days_in_service = NULL) => 0.0357291231, 0.0357291231),
   (phone_subject_title = '') => 0.0192300133, 0.0192300133),
(eda_pfrd_address_ind = '') => -0.0001580178, -0.0001580178);

// Tree: 823 
final_score_823 := map(
(NULL < _pp_app_nonpub_gong_la and _pp_app_nonpub_gong_la <= 0.5) => 
   map(
   (NULL < mth_source_ppca_lseen and mth_source_ppca_lseen <= 5.5) => 0.0014147725,
   (mth_source_ppca_lseen > 5.5) => 
      map(
      (NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 37.5) => 0.0315270050,
      (f_mos_acc_lseen_d > 37.5) => -0.0124153518,
      (f_mos_acc_lseen_d = NULL) => -0.0089418656, -0.0089418656),
   (mth_source_ppca_lseen = NULL) => 0.0003832503, 0.0003832503),
(_pp_app_nonpub_gong_la > 0.5) => 0.0258789842,
(_pp_app_nonpub_gong_la = NULL) => 0.0006168665, 0.0006168665);

// Tree: 824 
final_score_824 := map(
(NULL < inq_num and inq_num <= 6.5) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 42.5) => 0.0001201351,
   (inq_adl_firstseen_n > 42.5) => 0.0138246768,
   (inq_adl_firstseen_n = NULL) => 0.0005555004, 0.0005555004),
(inq_num > 6.5) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 10.5) => -0.0419825585,
   (f_rel_educationover12_count_d > 10.5) => 0.0014374486,
   (f_rel_educationover12_count_d = NULL) => -0.0198848763, -0.0198848763),
(inq_num = NULL) => 0.0002720281, 0.0002720281);

// Tree: 825 
final_score_825 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 752448.5) => 
   map(
   (NULL < mth_source_edahistory_fseen and mth_source_edahistory_fseen <= 9.5) => 
      map(
      (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 8.5) => 0.0004061668,
      (f_rel_homeover500_count_d > 8.5) => -0.0187865501,
      (f_rel_homeover500_count_d = NULL) => 0.0000672390, 0.0000672390),
   (mth_source_edahistory_fseen > 9.5) => -0.0202005088,
   (mth_source_edahistory_fseen = NULL) => -0.0004923079, -0.0004923079),
(f_curraddrmedianvalue_d > 752448.5) => 0.0327593353,
(f_curraddrmedianvalue_d = NULL) => -0.0001999767, -0.0001999767);

// Tree: 826 
final_score_826 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 2.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 49216) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 0.5) => 0.0296746852,
      (f_rel_homeover100_count_d > 0.5) => 0.0045360562,
      (f_rel_homeover100_count_d = NULL) => 0.0136368763, 0.0136368763),
   (f_curraddrmedianvalue_d > 49216) => -0.0002236132,
   (f_curraddrmedianvalue_d = NULL) => 0.0005342183, 0.0005342183),
(f_rel_felony_count_i > 2.5) => -0.0107136542,
(f_rel_felony_count_i = NULL) => -0.0006008754, -0.0006008754);

// Tree: 827 
final_score_827 := map(
(NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => 
   map(
   (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 0.5) => 0.0023484416,
   (f_srchunvrfdphonecount_i > 0.5) => -0.0109047887,
   (f_srchunvrfdphonecount_i = NULL) => -0.0004955337, -0.0004955337),
(_inq_adl_ph_industry_flag > 0.5) => 
   map(
   (NULL < r_nas_addr_verd_d and r_nas_addr_verd_d <= 0.5) => -0.0045542824,
   (r_nas_addr_verd_d > 0.5) => 0.0307380303,
   (r_nas_addr_verd_d = NULL) => 0.0182978281, 0.0182978281),
(_inq_adl_ph_industry_flag = NULL) => 0.0001118297, 0.0001118297);

// Tree: 828 
final_score_828 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 14.5) => 
   map(
   (NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 7.5) => 0.0014356681,
   (f_inq_per_ssn_i > 7.5) => -0.0189517069,
   (f_inq_per_ssn_i = NULL) => 0.0008135304, 0.0008135304),
(f_corraddrnamecount_d > 14.5) => 
   map(
   (NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 55) => -0.0278559154,
   (mth_eda_dt_first_seen > 55) => 0.0327110864,
   (mth_eda_dt_first_seen = NULL) => -0.0134588412, -0.0134588412),
(f_corraddrnamecount_d = NULL) => 0.0003823196, 0.0003823196);

// Tree: 829 
final_score_829 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 33.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Father','Grandfather','Grandmother','Husband','Mother','Neighbor','Parent','Relative','Son','Subject','Wife']) => -0.0207910823,
   (phone_subject_title in ['Associate','Associate By Property','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Grandparent','Grandson','Sibling','Sister','Spouse','Subject at Household']) => 0.0191200389,
   (phone_subject_title = '') => -0.0148941500, -0.0148941500),
(f_mos_inq_banko_cm_fseen_d > 33.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 16.5) => 0.0118132752,
   (f_mos_inq_banko_cm_lseen_d > 16.5) => -0.0004210148,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0002382990, 0.0002382990),
(f_mos_inq_banko_cm_fseen_d = NULL) => -0.0006368532, -0.0006368532);

// Tree: 830 
final_score_830 := map(
(NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 2.5) => -0.0000902455,
(inq_adl_firstseen_n > 2.5) => 
   map(
   (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 4.5) => 0.0306059899,
   (f_rel_educationover8_count_d > 4.5) => 
      map(
      (NULL < pk_phone_match_level and pk_phone_match_level <= 3.5) => 0.0143371184,
      (pk_phone_match_level > 3.5) => -0.0025867489,
      (pk_phone_match_level = NULL) => 0.0045607096, 0.0045607096),
   (f_rel_educationover8_count_d = NULL) => 0.0070221317, 0.0070221317),
(inq_adl_firstseen_n = NULL) => 0.0007129353, 0.0007129353);

// Tree: 831 
final_score_831 := map(
(phone_subject_title in ['Associate By Business','Brother','Father','Grandfather','Grandmother','Grandparent','Grandson','Mother','Parent','Son','Wife']) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 12.5) => 0.0313093246,
   (f_prevaddrageoldest_d > 12.5) => 
      map(
      (NULL < number_of_sources and number_of_sources <= 1.5) => -0.0117014571,
      (number_of_sources > 1.5) => -0.0301939493,
      (number_of_sources = NULL) => -0.0140856131, -0.0140856131),
   (f_prevaddrageoldest_d = NULL) => -0.0103027016, -0.0103027016),
(phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Husband','Neighbor','Relative','Sibling','Sister','Spouse','Subject','Subject at Household']) => 0.0008068660,
(phone_subject_title = '') => -0.0001010482, -0.0001010482);

// Tree: 832 
final_score_832 := map(
(NULL < mth_source_ppth_fseen and mth_source_ppth_fseen <= 16.5) => 
   map(
   (NULL < source_utildid and source_utildid <= 0.5) => -0.0002283519,
   (source_utildid > 0.5) => 
      map(
      (NULL < _pp_app_ported_match_7 and _pp_app_ported_match_7 <= 0.5) => -0.0010150809,
      (_pp_app_ported_match_7 > 0.5) => 0.0227397345,
      (_pp_app_ported_match_7 = NULL) => 0.0091262658, 0.0091262658),
   (source_utildid = NULL) => 0.0006060409, 0.0006060409),
(mth_source_ppth_fseen > 16.5) => -0.0251316974,
(mth_source_ppth_fseen = NULL) => -0.0004424628, -0.0004424628);

// Tree: 833 
final_score_833 := map(
(NULL < mth_source_sx_fseen and mth_source_sx_fseen <= 68.5) => 
   map(
   (phone_subject_title in ['Associate By Property','Associate By SSN','Daughter','Granddaughter','Grandfather','Grandson','Husband','Sibling','Spouse']) => -0.0183550609,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Father','Grandchild','Grandmother','Grandparent','Mother','Neighbor','Parent','Relative','Sister','Son','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < phone_business_count and phone_business_count <= 5.5) => 0.0019908713,
      (phone_business_count > 5.5) => -0.0319849168,
      (phone_business_count = NULL) => 0.0017291500, 0.0017291500),
   (phone_subject_title = '') => 0.0012092111, 0.0012092111),
(mth_source_sx_fseen > 68.5) => 0.0208952087,
(mth_source_sx_fseen = NULL) => 0.0014042185, 0.0014042185);

// Tree: 834 
final_score_834 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 7.5) => -0.0295317971,
(f_mos_inq_banko_cm_lseen_d > 7.5) => 
   map(
   (NULL < mth_pp_app_fb_ph7_did_dt and mth_pp_app_fb_ph7_did_dt <= 10.5) => 
      map(
      (NULL < mth_pp_app_fb_ph_dt and mth_pp_app_fb_ph_dt <= -499) => 0.0010668456,
      (mth_pp_app_fb_ph_dt > -499) => 0.0305482829,
      (mth_pp_app_fb_ph_dt = NULL) => 0.0012910106, 0.0012910106),
   (mth_pp_app_fb_ph7_did_dt > 10.5) => -0.0307308356,
   (mth_pp_app_fb_ph7_did_dt = NULL) => 0.0010733669, 0.0010733669),
(f_mos_inq_banko_cm_lseen_d = NULL) => 0.0005806521, 0.0005806521);

// Tree: 835 
final_score_835 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 67.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 196.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 21.5) => 0.0014683842,
      (f_rel_educationover12_count_d > 21.5) => -0.0094421727,
      (f_rel_educationover12_count_d = NULL) => 0.0005879326, 0.0005879326),
   (f_curraddrmurderindex_i > 196.5) => -0.0185651991,
   (f_curraddrmurderindex_i = NULL) => 0.0002013911, 0.0002013911),
(mth_exp_last_update > 67.5) => -0.0173047579,
(mth_exp_last_update = NULL) => -0.0001194249, -0.0001194249);

// Tree: 836 
final_score_836 := map(
(NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 7.5) => 
   map(
   (NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 6.5) => 
      map(
      (NULL < inq_num_addresses and inq_num_addresses <= 0.5) => 0.0119609467,
      (inq_num_addresses > 0.5) => 0.0002001845,
      (inq_num_addresses = NULL) => 0.0050393005, 0.0050393005),
   (mth_eda_dt_first_seen > 6.5) => -0.0013914803,
   (mth_eda_dt_first_seen = NULL) => 0.0009201995, 0.0009201995),
(mth_pp_first_build_date > 7.5) => -0.0057380669,
(mth_pp_first_build_date = NULL) => -0.0003758375, -0.0003758375);

// Tree: 837 
final_score_837 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 183.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 177.5) => 0.0006608613,
   (f_curraddrcrimeindex_i > 177.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 72) => 0.0502805422,
      (f_prevaddrageoldest_d > 72) => 0.0086137210,
      (f_prevaddrageoldest_d = NULL) => 0.0241333467, 0.0241333467),
   (f_curraddrcrimeindex_i = NULL) => 0.0014481649, 0.0014481649),
(f_curraddrcrimeindex_i > 183.5) => -0.0112600183,
(f_curraddrcrimeindex_i = NULL) => 0.0003292153, 0.0003292153);

// Tree: 838 
final_score_838 := map(
(NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 6150) => 
   map(
   (NULL < _pp_rule_low_vend_conf and _pp_rule_low_vend_conf <= 0.5) => 0.0004068446,
   (_pp_rule_low_vend_conf > 0.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 52.5) => 0.0558531461,
      (f_prevaddrmurderindex_i > 52.5) => 0.0021961902,
      (f_prevaddrmurderindex_i = NULL) => 0.0168812518, 0.0168812518),
   (_pp_rule_low_vend_conf = NULL) => 0.0007980140, 0.0007980140),
(f_acc_damage_amt_total_i > 6150) => -0.0268307746,
(f_acc_damage_amt_total_i = NULL) => 0.0005482429, 0.0005482429);

// Tree: 839 
final_score_839 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -19010.5) => -0.0067248698,
(f_addrchangeincomediff_d > -19010.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 39.5) => 0.0005326704,
   (inq_adl_lastseen_n > 39.5) => 0.0221339786,
   (inq_adl_lastseen_n = NULL) => 0.0011295094, 0.0011295094),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 15.5) => 0.0057593207,
   (mth_source_ppla_fseen > 15.5) => -0.0248398324,
   (mth_source_ppla_fseen = NULL) => 0.0045854006, 0.0045854006), 0.0009774315);

// Tree: 840 
final_score_840 := map(
(NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 95.5) => 
   map(
   (NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 26.5) => -0.0001189665,
   (mth_source_ppfla_fseen > 26.5) => 
      map(
      (pp_source in ['CELL','IBEHAVIOR','INFUTOR','INQUIRY','THRIVE']) => 0.0036152020,
      (pp_source in ['GONG','HEADER','INTRADO','OTHER','PCNSR','TARGUS']) => 0.0292350655,
      (pp_source = '') => 0.0110223054, 0.0110223054),
   (mth_source_ppfla_fseen = NULL) => 0.0002963942, 0.0002963942),
(mth_source_ppdid_fseen > 95.5) => -0.0188172695,
(mth_source_ppdid_fseen = NULL) => -0.0001532834, -0.0001532834);

// Tree: 841 
final_score_841 := map(
(NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 184.5) => 
   map(
   (NULL < f_inq_ssns_per_addr_i and f_inq_ssns_per_addr_i <= 0.5) => -0.0019253107,
   (f_inq_ssns_per_addr_i > 0.5) => 0.0044741362,
   (f_inq_ssns_per_addr_i = NULL) => 0.0005538792, 0.0005538792),
(f_curraddrburglaryindex_i > 184.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By SSN','Brother','Child','Daughter','Grandfather','Grandmother','Grandparent','Grandson','Neighbor','Parent','Relative','Sibling','Sister','Son','Subject','Subject at Household']) => -0.0148049219,
   (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Associate By Vehicle','Father','Grandchild','Granddaughter','Husband','Mother','Spouse','Wife']) => 0.0216239355,
   (phone_subject_title = '') => -0.0094725819, -0.0094725819),
(f_curraddrburglaryindex_i = NULL) => -0.0003028710, -0.0003028710);

// Tree: 842 
final_score_842 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -82578.5) => -0.0371530460,
(f_addrchangeincomediff_d > -82578.5) => -0.0001119321,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By SSN','Brother','Child','Daughter','Father','Grandson','Husband','Neighbor','Relative','Sibling','Son','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 27.5) => -0.0037362792,
      (mth_source_utildid_fseen > 27.5) => 0.0207777621,
      (mth_source_utildid_fseen = NULL) => -0.0022659863, -0.0022659863),
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Mother','Parent','Sister']) => 0.0293241111,
   (phone_subject_title = '') => 0.0012160144, 0.0012160144), -0.0000115758);

// Tree: 843 
final_score_843 := map(
(NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0019913579,
(_pp_rule_high_vend_conf > 0.5) => 
   map(
   (NULL < inq_firstseen_n and inq_firstseen_n <= 51.5) => 
      map(
      (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 3.5) => 0.0018060053,
      (pp_app_ind_ph_cnt > 3.5) => 0.0197129986,
      (pp_app_ind_ph_cnt = NULL) => 0.0096230375, 0.0096230375),
   (inq_firstseen_n > 51.5) => -0.0170016935,
   (inq_firstseen_n = NULL) => 0.0066963495, 0.0066963495),
(_pp_rule_high_vend_conf = NULL) => -0.0005821334, -0.0005821334);

// Tree: 844 
final_score_844 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 212.5) => 0.0010324804,
(f_prevaddrlenofres_d > 212.5) => 
   map(
   (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 0.5) => -0.0073887097,
   (f_divaddrsuspidcountnew_i > 0.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Brother','Daughter','Husband','Mother','Neighbor','Sister','Son','Spouse','Wife']) => -0.0183928888,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Parent','Relative','Sibling','Subject','Subject at Household']) => 0.0272666175,
      (phone_subject_title = '') => 0.0080126088, 0.0080126088),
   (f_divaddrsuspidcountnew_i = NULL) => -0.0058830449, -0.0058830449),
(f_prevaddrlenofres_d = NULL) => -0.0004217069, -0.0004217069);

// Tree: 845 
final_score_845 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 1.5) => 
   map(
   (NULL < pk_phone_match_level and pk_phone_match_level <= 2.5) => -0.0008847220,
   (pk_phone_match_level > 2.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By SSN','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Parent','Sister','Spouse','Subject','Subject at Household']) => 0.0059937498,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandparent','Relative','Sibling','Son','Wife']) => 0.0477396989,
      (phone_subject_title = '') => 0.0081775404, 0.0081775404),
   (pk_phone_match_level = NULL) => 0.0026498828, 0.0026498828),
(f_srchssnsrchcount_i > 1.5) => -0.0042070859,
(f_srchssnsrchcount_i = NULL) => -0.0006283188, -0.0006283188);

// Tree: 846 
final_score_846 := map(
(NULL < number_of_sources and number_of_sources <= 1.5) => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => -0.0140655349,
   (source_rel > 0.5) => 0.0305015957,
   (source_rel = NULL) => -0.0116879212, -0.0116879212),
(number_of_sources > 1.5) => 
   map(
   (NULL < eda_address_match_best and eda_address_match_best <= 0.5) => 0.0180434951,
   (eda_address_match_best > 0.5) => 0.0505539408,
   (eda_address_match_best = NULL) => 0.0222025165, 0.0222025165),
(number_of_sources = NULL) => -0.0027327214, -0.0027327214);

// Tree: 847 
final_score_847 := map(
(pp_src in ['CY','E1','EM','EN','EQ','FA','KW','LP','NW','PL','SL','TN','UT','ZT']) => 
   map(
   (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 9.5) => 
      map(
      (NULL < inq_lastseen_n and inq_lastseen_n <= 5.5) => 0.0236478755,
      (inq_lastseen_n > 5.5) => -0.0039691967,
      (inq_lastseen_n = NULL) => 0.0114186148, 0.0114186148),
   (mth_pp_datevendorfirstseen > 9.5) => -0.0060580207,
   (mth_pp_datevendorfirstseen = NULL) => -0.0010542149, -0.0010542149),
(pp_src in ['E2','FF','LA','MD','UW','VO','VW','ZK']) => 0.0102433350,
(pp_src = '') => 0.0007990913, 0.0010251196);

// Tree: 848 
final_score_848 := map(
(NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 11.5) => 
   map(
   (NULL < mth_pp_eda_hist_did_dt and mth_pp_eda_hist_did_dt <= 127.5) => 
      map(
      (pp_src in ['E1','E2','EQ','FA','LP','SL','TN','UT','UW']) => 0.0009743534,
      (pp_src in ['CY','EM','EN','FF','KW','LA','MD','NW','PL','VO','VW','ZK','ZT']) => 0.0305444091,
      (pp_src = '') => -0.0010760502, -0.0005475324),
   (mth_pp_eda_hist_did_dt > 127.5) => 0.0328613977,
   (mth_pp_eda_hist_did_dt = NULL) => -0.0002253173, -0.0002253173),
(mth_pp_datevendorfirstseen > 11.5) => -0.0060551673,
(mth_pp_datevendorfirstseen = NULL) => -0.0020133979, -0.0020133979);

// Tree: 849 
final_score_849 := map(
(NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 14.5) => 
   map(
   (pp_source in ['INFUTOR','OTHER','THRIVE']) => -0.0048861094,
   (pp_source in ['CELL','GONG','HEADER','IBEHAVIOR','INQUIRY','INTRADO','PCNSR','TARGUS']) => 
      map(
      (NULL < f_estimated_income_d and f_estimated_income_d <= 38500) => -0.0093733882,
      (f_estimated_income_d > 38500) => 0.0279991255,
      (f_estimated_income_d = NULL) => 0.0185218851, 0.0185218851),
   (pp_source = '') => 0.0104405819, 0.0107777117),
(f_prevaddrmurderindex_i > 14.5) => -0.0004691475,
(f_prevaddrmurderindex_i = NULL) => 0.0004932772, 0.0004932772);

// Tree: 850 
final_score_850 := map(
(NULL < source_ppfa and source_ppfa <= 0.5) => 
   map(
   (pp_source in ['GONG','OTHER','PCNSR','THRIVE']) => -0.0281102339,
   (pp_source in ['CELL','HEADER','IBEHAVIOR','INFUTOR','INQUIRY','INTRADO','TARGUS']) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 8.5) => 0.0216530947,
      (mth_pp_app_npa_last_change_dt > 8.5) => -0.0003839795,
      (mth_pp_app_npa_last_change_dt = NULL) => 0.0003824704, 0.0003824704),
   (pp_source = '') => -0.0000204597, -0.0003399660),
(source_ppfa > 0.5) => 0.0165529340,
(source_ppfa = NULL) => -0.0001349754, -0.0001349754);

// Tree: 851 
final_score_851 := map(
(NULL < _phone_match_code_tcza and _phone_match_code_tcza <= 2.5) => -0.0049376812,
(_phone_match_code_tcza > 2.5) => 
   map(
   (eda_pfrd_address_ind in ['1A','1B','XX']) => 0.0005347023,
   (eda_pfrd_address_ind in ['1C','1D','1E']) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 0.5) => -0.0034775800,
      (f_addrchangecrimediff_i > 0.5) => 0.0347853833,
      (f_addrchangecrimediff_i = NULL) => 0.0274628763, 0.0179950727),
   (eda_pfrd_address_ind = '') => 0.0011572608, 0.0011572608),
(_phone_match_code_tcza = NULL) => -0.0008102372, -0.0008102372);

// Tree: 852 
final_score_852 := map(
(NULL < mth_source_edala_fseen and mth_source_edala_fseen <= 21) => 
   map(
   (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 46.5) => 
      map(
      (NULL < mth_pp_orig_lastseen and mth_pp_orig_lastseen <= 38.5) => 0.0010078927,
      (mth_pp_orig_lastseen > 38.5) => 0.0156922601,
      (mth_pp_orig_lastseen = NULL) => 0.0013491654, 0.0013491654),
   (mth_pp_datelastseen > 46.5) => -0.0142815867,
   (mth_pp_datelastseen = NULL) => 0.0006193781, 0.0006193781),
(mth_source_edala_fseen > 21) => -0.0173353726,
(mth_source_edala_fseen = NULL) => 0.0004259577, 0.0004259577);

// Tree: 853 
final_score_853 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 818) => 
   map(
   (NULL < _internal_ver_match_hhid and _internal_ver_match_hhid <= 0.5) => -0.0003672254,
   (_internal_ver_match_hhid > 0.5) => 
      map(
      (pp_source in ['CELL','GONG','IBEHAVIOR','INQUIRY','OTHER','PCNSR']) => 0.0010517352,
      (pp_source in ['HEADER','INFUTOR','INTRADO','TARGUS','THRIVE']) => 0.0294918614,
      (pp_source = '') => 0.0133040089, 0.0133040089),
   (_internal_ver_match_hhid = NULL) => 0.0007546183, 0.0007546183),
(r_pb_order_freq_d > 818) => -0.0271970824,
(r_pb_order_freq_d = NULL) => -0.0001948435, 0.0001900467);

// Tree: 854 
final_score_854 := map(
(NULL < f_vardobcount_i and f_vardobcount_i <= 3.5) => 
   map(
   (eda_pfrd_address_ind in ['1A','1B','XX']) => -0.0006687511,
   (eda_pfrd_address_ind in ['1C','1D','1E']) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Vehicle','Child','Grandfather','Grandparent','Mother','Neighbor','Sibling','Son','Spouse','Subject at Household']) => -0.0063310435,
      (phone_subject_title in ['Associate By Shared Associates','Associate By SSN','Brother','Daughter','Father','Grandchild','Granddaughter','Grandmother','Grandson','Husband','Parent','Relative','Sister','Subject','Wife']) => 0.0223108085,
      (phone_subject_title = '') => 0.0126889363, 0.0126889363),
   (eda_pfrd_address_ind = '') => -0.0000241982, -0.0000241982),
(f_vardobcount_i > 3.5) => -0.0198321833,
(f_vardobcount_i = NULL) => -0.0003111994, -0.0003111994);

// Tree: 855 
final_score_855 := map(
(NULL < inq_num and inq_num <= 0.5) => -0.0027256110,
(inq_num > 0.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 0.0311804379,
   (f_srchvelocityrisktype_i > 5.5) => 
      map(
      (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 5.5) => 0.0504533121,
      (inq_adl_lastseen_n > 5.5) => -0.0005139254,
      (inq_adl_lastseen_n = NULL) => 0.0046279021, 0.0046279021),
   (f_srchvelocityrisktype_i = NULL) => 0.0151524649, 0.0151524649),
(inq_num = NULL) => -0.0006535606, -0.0006535606);

// Tree: 856 
final_score_856 := map(
(NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 0.5) => 0.0008955269,
(f_srchaddrsrchcountmo_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 58) => -0.0181889809,
   (f_mos_inq_banko_cm_lseen_d > 58) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 312523.5) => -0.0044894978,
      (f_curraddrmedianvalue_d > 312523.5) => 0.0309357655,
      (f_curraddrmedianvalue_d = NULL) => 0.0029527844, 0.0029527844),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0105419594, -0.0105419594),
(f_srchaddrsrchcountmo_i = NULL) => -0.0000363535, -0.0000363535);

// Tree: 857 
final_score_857 := map(
(NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 68.5) => 
   map(
   (NULL < source_utildid and source_utildid <= 0.5) => 0.0002249058,
   (source_utildid > 0.5) => 
      map(
      (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 10.5) => 0.0386267122,
      (mth_source_utildid_fseen > 10.5) => 0.0038606158,
      (mth_source_utildid_fseen = NULL) => 0.0083998094, 0.0083998094),
   (source_utildid = NULL) => 0.0009140722, 0.0009140722),
(mth_source_utildid_fseen > 68.5) => -0.0266911277,
(mth_source_utildid_fseen = NULL) => 0.0006371998, 0.0006371998);

// Tree: 858 
final_score_858 := map(
(NULL < pp_did_score and pp_did_score <= 97.5) => 0.0001523374,
(pp_did_score > 97.5) => 
   map(
   (pp_src in ['CY','E1','EM','EN','LP','PL','SL','TN','UT','UW','VW','ZT']) => -0.0178559486,
   (pp_src in ['E2','EQ','FA','FF','KW','LA','MD','NW','VO','ZK']) => 0.0131750053,
   (pp_src = '') => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 416123.5) => -0.0102364637,
      (f_prevaddrmedianvalue_d > 416123.5) => 0.0242026629,
      (f_prevaddrmedianvalue_d = NULL) => -0.0070742734, -0.0070742734), -0.0080099844),
(pp_did_score = NULL) => -0.0008482444, -0.0008482444);

// Tree: 859 
final_score_859 := map(
(NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0027678848,
(_phone_match_code_n > 0.5) => 
   map(
   (phone_subject_title in ['Associate','Daughter','Mother','Sibling','Sister','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_college_income_d and f_college_income_d <= 9.5) => -0.0061158086,
      (f_college_income_d > 9.5) => -0.0256257257,
      (f_college_income_d = NULL) => 0.0035753956, 0.0016926936),
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Relative','Son','Spouse']) => 0.0371755096,
   (phone_subject_title = '') => 0.0027151328, 0.0027151328),
(_phone_match_code_n = NULL) => -0.0004588527, -0.0004588527);

// Tree: 860 
final_score_860 := map(
(pp_source in ['CELL','GONG','IBEHAVIOR','INFUTOR','INQUIRY','INTRADO','OTHER','PCNSR','THRIVE']) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 2.5) => -0.0189853370,
   (f_rel_under500miles_cnt_d > 2.5) => -0.0010799965,
   (f_rel_under500miles_cnt_d = NULL) => -0.0022175741, -0.0022175741),
(pp_source in ['HEADER','TARGUS']) => 
   map(
   (pp_src in ['E1','E2','EN','EQ','FA','PL','SL','VO']) => -0.0120024423,
   (pp_src in ['CY','EM','FF','KW','LA','LP','MD','NW','TN','UT','UW','VW','ZK','ZT']) => 0.0092384169,
   (pp_src = '') => 0.0055163037, 0.0055163037),
(pp_source = '') => -0.0014097026, -0.0009476281);

// Tree: 861 
final_score_861 := map(
(phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Grandmother','Grandson','Husband','Neighbor','Sibling','Subject','Wife']) => -0.0013067949,
(phone_subject_title in ['Associate By Address','Associate By SSN','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Mother','Parent','Relative','Sister','Son','Spouse','Subject at Household']) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 70216) => 
      map(
      (NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 1826) => -0.0023302802,
      (eda_max_days_interrupt > 1826) => 0.0514898072,
      (eda_max_days_interrupt = NULL) => -0.0004043129, -0.0004043129),
   (f_addrchangevaluediff_d > 70216) => 0.0139850044,
   (f_addrchangevaluediff_d = NULL) => 0.0118083562, 0.0049943931),
(phone_subject_title = '') => 0.0007062147, 0.0007062147);

// Tree: 862 
final_score_862 := map(
(NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 7.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Brother','Grandson','Mother','Neighbor','Parent','Spouse','Subject at Household','Wife']) => -0.0048388141,
   (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Husband','Relative','Sibling','Sister','Son','Subject']) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 2.5) => 0.0300824244,
      (f_corrssnnamecount_d > 2.5) => 0.0045664419,
      (f_corrssnnamecount_d = NULL) => 0.0060097702, 0.0060097702),
   (phone_subject_title = '') => 0.0020348489, 0.0020348489),
(f_rel_ageover30_count_d > 7.5) => -0.0012860633,
(f_rel_ageover30_count_d = NULL) => 0.0000035913, 0.0000035913);

// Tree: 863 
final_score_863 := map(
(NULL < f_accident_count_i and f_accident_count_i <= 1.5) => -0.0005337495,
(f_accident_count_i > 1.5) => 
   map(
   (NULL < pk_phone_match_level and pk_phone_match_level <= 3.5) => 
      map(
      (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.471155181118255) => -0.0069872555,
      (f_add_input_mobility_index_n > 0.471155181118255) => 0.0120334615,
      (f_add_input_mobility_index_n = NULL) => 0.0011007327, 0.0011007327),
   (pk_phone_match_level > 3.5) => 0.0275212212,
   (pk_phone_match_level = NULL) => 0.0076623045, 0.0076623045),
(f_accident_count_i = NULL) => -0.0000719285, -0.0000719285);

// Tree: 864 
final_score_864 := map(
(NULL < f_idrisktype_i and f_idrisktype_i <= 1.5) => 
   map(
   (exp_source in ['P']) => 
      map(
      (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 276) => -0.0128873482,
      (eda_avg_days_interrupt > 276) => 0.0122951517,
      (eda_avg_days_interrupt = NULL) => -0.0074987200, -0.0074987200),
   (exp_source in ['S']) => 0.0017373231,
   (exp_source = '') => 0.0009557218, 0.0005550561),
(f_idrisktype_i > 1.5) => -0.0119646880,
(f_idrisktype_i = NULL) => 0.0000170560, 0.0000170560);

// Tree: 865 
final_score_865 := map(
(NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 2.5) => 
   map(
   (pp_src in ['CY','E1','E2','EN','EQ','LP','SL','ZT']) => -0.0208659374,
   (pp_src in ['EM','FA','FF','KW','LA','MD','NW','PL','TN','UT','UW','VO','VW','ZK']) => 0.0000291991,
   (pp_src = '') => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 65) => 0.0093161400,
      (f_fp_prevaddrburglaryindex_i > 65) => -0.0011681721,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0011626635, 0.0011626635), 0.0003511775),
(f_rel_homeover300_count_d > 2.5) => -0.0054081466,
(f_rel_homeover300_count_d = NULL) => -0.0012397248, -0.0012397248);

// Tree: 866 
final_score_866 := map(
(phone_subject_title in ['Associate By Business','Associate By Vehicle','Brother','Child','Daughter','Father','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Parent','Sister','Son','Spouse','Subject']) => -0.0015760386,
(phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Grandchild','Granddaughter','Grandparent','Relative','Sibling','Subject at Household','Wife']) => 
   map(
   (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 17.5) => 
      map(
      (NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 1298) => 0.0049149086,
      (eda_max_days_interrupt > 1298) => 0.0248944655,
      (eda_max_days_interrupt = NULL) => 0.0064275564, 0.0064275564),
   (f_rel_homeover50_count_d > 17.5) => -0.0037036793,
   (f_rel_homeover50_count_d = NULL) => 0.0035250063, 0.0035250063),
(phone_subject_title = '') => 0.0003914893, 0.0003914893);

// Tree: 867 
final_score_867 := map(
(NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 5.5) => 0.0005412054,
(f_rel_bankrupt_count_i > 5.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 42189.5) => -0.0187322585,
   (f_curraddrmedianincome_d > 42189.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 139.5) => -0.0088358017,
      (f_curraddrcartheftindex_i > 139.5) => 0.0161813986,
      (f_curraddrcartheftindex_i = NULL) => -0.0039868418, -0.0039868418),
   (f_curraddrmedianincome_d = NULL) => -0.0090623170, -0.0090623170),
(f_rel_bankrupt_count_i = NULL) => -0.0005160740, -0.0005160740);

// Tree: 868 
final_score_868 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 142.5) => 
   map(
   (pp_did_type in ['AMBIG','C_MERGE','CORE']) => -0.0019493103,
   (pp_did_type in ['INACTIVE','NO_SSN']) => 0.0292382612,
   (pp_did_type = '') => -0.0016387414, -0.0015127242),
(f_addrchangecrimediff_i > 142.5) => 0.0220145416,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Father','Husband','Mother','Neighbor','Relative','Sibling','Son','Spouse','Subject','Subject at Household','Wife']) => -0.0004985325,
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Vehicle','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Parent','Sister']) => 0.0194845492,
   (phone_subject_title = '') => 0.0031519358, 0.0031519358), -0.0000988839);

// Tree: 869 
final_score_869 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 2.5) => 
   map(
   (NULL < f_estimated_income_d and f_estimated_income_d <= 119500) => -0.0045093432,
   (f_estimated_income_d > 119500) => 0.0240673263,
   (f_estimated_income_d = NULL) => -0.0039599990, -0.0039599990),
(f_assocrisktype_i > 2.5) => 
   map(
   (NULL < f_accident_count_i and f_accident_count_i <= 1.5) => 0.0005858300,
   (f_accident_count_i > 1.5) => 0.0118384475,
   (f_accident_count_i = NULL) => 0.0013390478, 0.0013390478),
(f_assocrisktype_i = NULL) => -0.0004017114, -0.0004017114);

// Tree: 870 
final_score_870 := map(
(NULL < r_paw_active_phone_ct_d and r_paw_active_phone_ct_d <= 0.5) => -0.0021452418,
(r_paw_active_phone_ct_d > 0.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Daughter','Grandfather','Neighbor','Sibling','Son','Subject at Household','Wife']) => -0.0044007983,
   (phone_subject_title in ['Associate By Property','Child','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Mother','Parent','Relative','Sister','Spouse','Subject']) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 0.0186996573,
      (f_util_adl_count_n > 3.5) => -0.0024478879,
      (f_util_adl_count_n = NULL) => 0.0108502981, 0.0108502981),
   (phone_subject_title = '') => 0.0043887744, 0.0043887744),
(r_paw_active_phone_ct_d = NULL) => -0.0013660148, -0.0013660148);

// Tree: 871 
final_score_871 := map(
(pp_did_type in ['AMBIG','C_MERGE','CORE']) => 
   map(
   (NULL < phone_business_count and phone_business_count <= 0.5) => -0.0017368089,
   (phone_business_count > 0.5) => 
      map(
      (NULL < internal_verification and internal_verification <= 0.5) => -0.0191482945,
      (internal_verification > 0.5) => 0.0188034140,
      (internal_verification = NULL) => 0.0095629980, 0.0095629980),
   (phone_business_count = NULL) => -0.0010156780, -0.0010156780),
(pp_did_type in ['INACTIVE','NO_SSN']) => 0.0266432815,
(pp_did_type = '') => 0.0013855135, 0.0005391372);

// Tree: 872 
final_score_872 := map(
(NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 18.5) => 
   map(
   (pp_src in ['E1','E2','EQ','KW','NW','SL','UT','UW','VO']) => 
      map(
      (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 2.5) => 0.0301572014,
      (mth_pp_datevendorfirstseen > 2.5) => -0.0032923461,
      (mth_pp_datevendorfirstseen = NULL) => -0.0018964608, -0.0018964608),
   (pp_src in ['CY','EM','EN','FA','FF','LA','LP','MD','PL','TN','VW','ZK','ZT']) => 0.0125542984,
   (pp_src = '') => 0.0004736373, 0.0003120394),
(mth_source_ppth_lseen > 18.5) => -0.0207609113,
(mth_source_ppth_lseen = NULL) => -0.0004994623, -0.0004994623);

// Tree: 873 
final_score_873 := map(
(exp_source in ['P']) => -0.0048619445,
(exp_source in ['S']) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 1.5) => -0.0001380511,
   (f_rel_homeover300_count_d > 1.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 6.5) => 0.0142513160,
      (f_rel_criminal_count_i > 6.5) => -0.0088409265,
      (f_rel_criminal_count_i = NULL) => 0.0097818497, 0.0097818497),
   (f_rel_homeover300_count_d = NULL) => 0.0035926569, 0.0035926569),
(exp_source = '') => -0.0003241642, -0.0000174817);

// Tree: 874 
final_score_874 := map(
(NULL < inq_firstseen_n and inq_firstseen_n <= 9.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 22486) => -0.0170312407,
   (f_curraddrmedianincome_d > 22486) => 
      map(
      (NULL < f_adl_util_inf_n and f_adl_util_inf_n <= 0.5) => 0.0034703231,
      (f_adl_util_inf_n > 0.5) => -0.0100294271,
      (f_adl_util_inf_n = NULL) => 0.0023058302, 0.0023058302),
   (f_curraddrmedianincome_d = NULL) => 0.0012349556, 0.0012349556),
(inq_firstseen_n > 9.5) => -0.0033613507,
(inq_firstseen_n = NULL) => -0.0010284805, -0.0010284805);

// Tree: 875 
final_score_875 := map(
(phone_subject_title in ['Associate By Business','Associate By SSN','Associate By Vehicle','Brother','Daughter','Father','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Mother','Relative','Spouse']) => -0.0070453847,
(phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Child','Grandchild','Grandmother','Neighbor','Parent','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => 
   map(
   (NULL < _internal_ver_match_spouse and _internal_ver_match_spouse <= 0.5) => 0.0009608059,
   (_internal_ver_match_spouse > 0.5) => 
      map(
      (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => 0.0344438937,
      (f_util_add_curr_conv_n > 0.5) => 0.0005855204,
      (f_util_add_curr_conv_n = NULL) => 0.0140292863, 0.0140292863),
   (_internal_ver_match_spouse = NULL) => 0.0012109555, 0.0012109555),
(phone_subject_title = '') => 0.0002182727, 0.0002182727);

// Tree: 876 
final_score_876 := map(
(exp_source in ['P']) => -0.0064141728,
(exp_source in ['S']) => 
   map(
   (phone_subject_title in ['Associate','Associate By Property','Daughter','Father','Grandmother','Husband','Mother','Neighbor','Parent','Relative','Sister','Son','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 6.5) => 0.0124000930,
      (f_rel_ageover20_count_d > 6.5) => -0.0011339967,
      (f_rel_ageover20_count_d = NULL) => 0.0018349439, 0.0018349439),
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Sibling','Spouse']) => 0.0328500354,
   (phone_subject_title = '') => 0.0051871902, 0.0051871902),
(exp_source = '') => -0.0010639508, -0.0004719372);

// Tree: 877 
final_score_877 := map(
(NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 39.5) => -0.0016972936,
   (inq_adl_firstseen_n > 39.5) => 0.0237388107,
   (inq_adl_firstseen_n = NULL) => -0.0014045507, -0.0014045507),
(_phone_match_code_n > 0.5) => 
   map(
   (phone_subject_title in ['Associate','Daughter','Grandfather','Grandmother','Sibling','Sister','Subject','Subject at Household','Wife']) => 0.0020350278,
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Son','Spouse']) => 0.0261060916,
   (phone_subject_title = '') => 0.0027321213, 0.0027321213),
(_phone_match_code_n = NULL) => 0.0003287948, 0.0003287948);

// Tree: 878 
final_score_878 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 574) => 
   map(
   (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => 
      map(
      (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Daughter','Father','Grandfather','Grandmother','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject at Household','Wife']) => -0.0076891233,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By SSN','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Subject']) => 0.0087221329,
      (phone_subject_title = '') => 0.0016972421, 0.0016972421),
   (f_util_add_curr_conv_n > 0.5) => -0.0036117137,
   (f_util_add_curr_conv_n = NULL) => -0.0017925687, -0.0017925687),
(r_pb_order_freq_d > 574) => 0.0188465783,
(r_pb_order_freq_d = NULL) => -0.0010277981, -0.0011969716);

// Tree: 879 
final_score_879 := map(
(NULL < eda_max_days_connected_ind and eda_max_days_connected_ind <= 848.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 50) => 
      map(
      (NULL < inq_num_addresses and inq_num_addresses <= 2.5) => -0.0016988685,
      (inq_num_addresses > 2.5) => -0.0194353346,
      (inq_num_addresses = NULL) => -0.0038505378, -0.0038505378),
   (f_curraddrmurderindex_i > 50) => 0.0017806485,
   (f_curraddrmurderindex_i = NULL) => 0.0005048994, 0.0005048994),
(eda_max_days_connected_ind > 848.5) => 0.0168457051,
(eda_max_days_connected_ind = NULL) => 0.0007962660, 0.0007962660);

// Tree: 880 
final_score_880 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 12.5) => -0.0004149712,
(inq_adl_lastseen_n > 12.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 23.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 4.5) => 0.0011156008,
      (f_srchssnsrchcount_i > 4.5) => 0.0328415171,
      (f_srchssnsrchcount_i = NULL) => 0.0194988420, 0.0194988420),
   (inq_adl_lastseen_n > 23.5) => 0.0005498270,
   (inq_adl_lastseen_n = NULL) => 0.0062854553, 0.0062854553),
(inq_adl_lastseen_n = NULL) => 0.0001716065, 0.0001716065);

// Tree: 881 
final_score_881 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 5.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 66.5) => -0.0004991867,
   (f_inq_count_i > 66.5) => 0.0319405351,
   (f_inq_count_i = NULL) => -0.0002636371, -0.0002636371),
(f_srchfraudsrchcountyr_i > 5.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 7.5) => 0.0249730508,
   (f_util_adl_count_n > 7.5) => -0.0219417170,
   (f_util_adl_count_n = NULL) => 0.0131405651, 0.0131405651),
(f_srchfraudsrchcountyr_i = NULL) => 0.0001114681, 0.0001114681);

// Tree: 882 
final_score_882 := map(
(NULL < f_college_income_d and f_college_income_d <= 3.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Vehicle','Brother','Daughter','Father','Husband','Mother','Neighbor','Sibling','Sister','Son','Spouse','Subject','Wife']) => -0.0016170594,
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Parent','Relative','Subject at Household']) => 0.0467141290,
   (phone_subject_title = '') => 0.0097915902, 0.0097915902),
(f_college_income_d > 3.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 185) => -0.0075168051,
   (f_fp_prevaddrburglaryindex_i > 185) => 0.0181957274,
   (f_fp_prevaddrburglaryindex_i = NULL) => -0.0052714082, -0.0052714082),
(f_college_income_d = NULL) => 0.0006675583, 0.0002402688);

// Tree: 883 
final_score_883 := map(
(NULL < f_rel_count_i and f_rel_count_i <= 67.5) => 
   map(
   (NULL < inq_lastseen_n and inq_lastseen_n <= 58.5) => -0.0005461961,
   (inq_lastseen_n > 58.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By SSN','Brother','Daughter','Grandfather','Husband','Neighbor','Sibling','Son','Subject','Wife']) => 0.0001745597,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Mother','Parent','Relative','Sister','Spouse','Subject at Household']) => 0.0302122059,
      (phone_subject_title = '') => 0.0120971946, 0.0120971946),
   (inq_lastseen_n = NULL) => -0.0000341585, -0.0000341585),
(f_rel_count_i > 67.5) => 0.0272865723,
(f_rel_count_i = NULL) => 0.0001383722, 0.0001383722);

// Tree: 884 
final_score_884 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 8.5) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 7.5) => -0.0069326940,
   (inq_adl_lastseen_n > 7.5) => -0.0236900071,
   (inq_adl_lastseen_n = NULL) => -0.0085804446, -0.0085804446),
(f_prevaddrageoldest_d > 8.5) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 10.5) => 0.0015243107,
   (f_rel_incomeover75_count_d > 10.5) => -0.0103329501,
   (f_rel_incomeover75_count_d = NULL) => 0.0010934532, 0.0010934532),
(f_prevaddrageoldest_d = NULL) => 0.0004477280, 0.0004477280);

// Tree: 885 
final_score_885 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 23.5) => 
   map(
   (NULL < eda_months_addr_last_seen and eda_months_addr_last_seen <= 0.5) => -0.0001681747,
   (eda_months_addr_last_seen > 0.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.563984856095695) => 0.0106354491,
      (f_add_curr_mobility_index_n > 0.563984856095695) => -0.0255441690,
      (f_add_curr_mobility_index_n = NULL) => 0.0070814591, 0.0070814591),
   (eda_months_addr_last_seen = NULL) => 0.0003037276, 0.0003037276),
(f_rel_incomeover50_count_d > 23.5) => -0.0147580322,
(f_rel_incomeover50_count_d = NULL) => -0.0000051451, -0.0000051451);

// Tree: 886 
final_score_886 := map(
(NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 147) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 10.5) => 0.0018680779,
   (mth_source_ppdid_lseen > 10.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 29.5) => -0.0152031209,
      (f_prevaddrageoldest_d > 29.5) => -0.0000691835,
      (f_prevaddrageoldest_d = NULL) => -0.0039103909, -0.0039103909),
   (mth_source_ppdid_lseen = NULL) => 0.0008285878, 0.0008285878),
(mth_source_ppdid_fseen > 147) => 0.0251840521,
(mth_source_ppdid_fseen = NULL) => 0.0010095348, 0.0010095348);

// Tree: 887 
final_score_887 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 10.5) => 
   map(
   (phone_subject_title in ['Associate By Business','Grandmother','Grandparent','Grandson','Mother','Neighbor','Parent','Relative','Son','Subject at Household','Wife']) => -0.0067051979,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Husband','Sibling','Sister','Spouse','Subject']) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 12.5) => -0.0102188622,
      (f_prevaddrageoldest_d > 12.5) => 0.0062539847,
      (f_prevaddrageoldest_d = NULL) => 0.0043233862, 0.0043233862),
   (phone_subject_title = '') => 0.0011144002, 0.0011144002),
(f_addrchangecrimediff_i > 10.5) => -0.0054035323,
(f_addrchangecrimediff_i = NULL) => 0.0000791917, -0.0009127256);

// Tree: 888 
final_score_888 := map(
(NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 46.5) => 
   map(
   (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0032962114,
   (_phone_match_code_n > 0.5) => 
      map(
      (phone_subject_title in ['Grandfather','Sibling','Subject','Subject at Household']) => 0.0032406802,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sister','Son','Spouse','Wife']) => 0.0216779982,
      (phone_subject_title = '') => 0.0053491560, 0.0053491560),
   (_phone_match_code_n = NULL) => 0.0001872249, 0.0001872249),
(mth_pp_datelastseen > 46.5) => -0.0189454515,
(mth_pp_datelastseen = NULL) => -0.0006419525, -0.0006419525);

// Tree: 889 
final_score_889 := map(
(NULL < f_college_income_d and f_college_income_d <= 10.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 141012) => -0.0048248270,
   (f_addrchangevaluediff_d > 141012) => 0.0181499391,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By SSN','Brother','Daughter','Father','Grandfather','Husband','Mother','Neighbor','Relative','Sibling','Son','Subject','Wife']) => -0.0010382099,
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Parent','Sister','Spouse','Subject at Household']) => 0.0309930661,
      (phone_subject_title = '') => 0.0070763800, 0.0070763800), -0.0004859788),
(f_college_income_d > 10.5) => -0.0241239409,
(f_college_income_d = NULL) => 0.0007004575, 0.0003377242);

// Tree: 890 
final_score_890 := map(
(NULL < _pp_app_nonpub_targ_la and _pp_app_nonpub_targ_la <= 0.5) => 0.0000078311,
(_pp_app_nonpub_targ_la > 0.5) => 
   map(
   (NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 9.5) => 
      map(
      (NULL < mth_pp_datevendorlastseen and mth_pp_datevendorlastseen <= 5.5) => 0.0289900209,
      (mth_pp_datevendorlastseen > 5.5) => 0.0042748639,
      (mth_pp_datevendorlastseen = NULL) => 0.0178682002, 0.0178682002),
   (mth_pp_first_build_date > 9.5) => -0.0093752125,
   (mth_pp_first_build_date = NULL) => 0.0094856117, 0.0094856117),
(_pp_app_nonpub_targ_la = NULL) => 0.0003129602, 0.0003129602);

// Tree: 891 
final_score_891 := map(
(NULL < eda_max_days_interrupt and eda_max_days_interrupt <= 1746.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 796947.5) => -0.0005414042,
   (f_curraddrmedianvalue_d > 796947.5) => 0.0216306640,
   (f_curraddrmedianvalue_d = NULL) => -0.0003950444, -0.0003950444),
(eda_max_days_interrupt > 1746.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Father','Mother','Neighbor','Parent','Son','Subject','Wife']) => -0.0008134745,
   (phone_subject_title in ['Associate','Associate By Business','Associate By SSN','Brother','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Relative','Sibling','Sister','Spouse','Subject at Household']) => 0.0282940169,
   (phone_subject_title = '') => 0.0081940014, 0.0081940014),
(eda_max_days_interrupt = NULL) => -0.0000238734, -0.0000238734);

// Tree: 892 
final_score_892 := map(
(NULL < _pp_src_all_eq and _pp_src_all_eq <= 0.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -19010.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.437829160202305) => -0.0094479358,
      (f_add_curr_mobility_index_n > 0.437829160202305) => 0.0053683724,
      (f_add_curr_mobility_index_n = NULL) => -0.0048944938, -0.0048944938),
   (f_addrchangeincomediff_d > -19010.5) => 0.0008426820,
   (f_addrchangeincomediff_d = NULL) => -0.0002603940, -0.0001799453),
(_pp_src_all_eq > 0.5) => 0.0215149017,
(_pp_src_all_eq = NULL) => -0.0000429422, -0.0000429422);

// Tree: 893 
final_score_893 := map(
(NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 196.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Grandparent','Grandson','Husband','Mother','Neighbor','Sibling','Sister','Subject','Subject at Household','Wife']) => -0.0015469742,
   (phone_subject_title in ['Associate By Business','Brother','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Parent','Relative','Son','Spouse']) => 0.0055950324,
   (phone_subject_title = '') => -0.0008124709, -0.0008124709),
(f_curraddrburglaryindex_i > 196.5) => 
   map(
   (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 13.5) => 0.0230926306,
   (f_rel_ageover20_count_d > 13.5) => -0.0035381847,
   (f_rel_ageover20_count_d = NULL) => 0.0142711730, 0.0142711730),
(f_curraddrburglaryindex_i = NULL) => -0.0005117692, -0.0005117692);

// Tree: 894 
final_score_894 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -24427.5) => -0.0045044036,
(f_addrchangevaluediff_d > -24427.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.651969346076075) => 
      map(
      (NULL < _internal_ver_match_level and _internal_ver_match_level <= 2.5) => 0.0021000264,
      (_internal_ver_match_level > 2.5) => 0.0230801620,
      (_internal_ver_match_level = NULL) => 0.0024190096, 0.0024190096),
   (f_add_input_mobility_index_n > 0.651969346076075) => -0.0083123436,
   (f_add_input_mobility_index_n = NULL) => 0.0012895282, 0.0012895282),
(f_addrchangevaluediff_d = NULL) => 0.0014893140, 0.0000193367);

// Tree: 895 
final_score_895 := map(
(NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 26.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 202) => -0.0039665303,
   (r_pb_order_freq_d > 202) => -0.0250917706,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.31423817591347) => 0.0060043676,
      (f_add_curr_mobility_index_n > 0.31423817591347) => -0.0126724177,
      (f_add_curr_mobility_index_n = NULL) => -0.0040473745, -0.0040473745), -0.0062152814),
(f_curraddrmurderindex_i > 26.5) => 0.0011269886,
(f_curraddrmurderindex_i = NULL) => 0.0002368236, 0.0002368236);

// Tree: 896 
final_score_896 := map(
(pp_src in ['E1','E2','EM','EQ','LP','NW','PL','SL','TN','UT','UW','VO','VW']) => 
   map(
   (NULL < inq_firstseen_n and inq_firstseen_n <= 1.5) => 0.0022433742,
   (inq_firstseen_n > 1.5) => 
      map(
      (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 43.5) => -0.0103273237,
      (mth_source_ppdid_fseen > 43.5) => 0.0075416687,
      (mth_source_ppdid_fseen = NULL) => -0.0074887598, -0.0074887598),
   (inq_firstseen_n = NULL) => -0.0029148583, -0.0029148583),
(pp_src in ['CY','EN','FA','FF','KW','LA','MD','ZK','ZT']) => 0.0113516056,
(pp_src = '') => 0.0005682076, 0.0001048382);

// Tree: 897 
final_score_897 := map(
(NULL < pp_did_score and pp_did_score <= 38) => 0.0001357828,
(pp_did_score > 38) => 
   map(
   (NULL < mth_source_ppfla_lseen and mth_source_ppfla_lseen <= 8.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 66.5) => -0.0108000827,
      (r_pb_order_freq_d > 66.5) => 0.0057912375,
      (r_pb_order_freq_d = NULL) => -0.0037922048, -0.0042848897),
   (mth_source_ppfla_lseen > 8.5) => -0.0187610477,
   (mth_source_ppfla_lseen = NULL) => -0.0058257692, -0.0058257692),
(pp_did_score = NULL) => -0.0006548093, -0.0006548093);

// Tree: 898 
final_score_898 := map(
(NULL < _phone_match_code_tcza and _phone_match_code_tcza <= 2.5) => -0.0033300004,
(_phone_match_code_tcza > 2.5) => 
   map(
   (pp_src in ['E1','E2','EM','EN','EQ','LP','SL','TN','UT','UW']) => -0.0027293715,
   (pp_src in ['CY','FA','FF','KW','LA','MD','NW','PL','VO','VW','ZK','ZT']) => 
      map(
      (NULL < inq_firstseen_n and inq_firstseen_n <= 2.5) => -0.0038310250,
      (inq_firstseen_n > 2.5) => 0.0255395290,
      (inq_firstseen_n = NULL) => 0.0092919885, 0.0092919885),
   (pp_src = '') => 0.0023173131, 0.0014030691),
(_phone_match_code_tcza = NULL) => -0.0001429731, -0.0001429731);

// Tree: 899 
final_score_899 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -42.5) => -0.0030336312,
(f_addrchangecrimediff_i > -42.5) => 0.0016537724,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By SSN','Child','Father','Mother','Subject at Household','Wife']) => -0.0097057044,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject']) => 
      map(
      (NULL < _phone_fb_rp_result and _phone_fb_rp_result <= 0.5) => 0.0280163639,
      (_phone_fb_rp_result > 0.5) => 0.0011412528,
      (_phone_fb_rp_result = NULL) => 0.0023417045, 0.0023417045),
   (phone_subject_title = '') => 0.0010130782, 0.0010130782), 0.0006739533);

// Tree: 900 
final_score_900 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.38808675230435) => 
   map(
   (NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 54.5) => 0.0014060651,
   (inq_adl_firstseen_n > 54.5) => 0.0161649580,
   (inq_adl_firstseen_n = NULL) => 0.0016723109, 0.0016723109),
(f_add_curr_mobility_index_n > 0.38808675230435) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 50.5) => -0.0018566212,
   (inq_adl_lastseen_n > 50.5) => -0.0220577061,
   (inq_adl_lastseen_n = NULL) => -0.0021981046, -0.0021981046),
(f_add_curr_mobility_index_n = NULL) => -0.0050767893, 0.0001679176);

// Tree: 901 
final_score_901 := map(
(NULL < mth_source_ppth_fseen and mth_source_ppth_fseen <= 23.5) => 
   map(
   (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0033630309,
   (_phone_match_code_n > 0.5) => 
      map(
      (phone_subject_title in ['Associate','Mother','Subject','Subject at Household','Wife']) => 0.0028940050,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse']) => 0.0461725953,
      (phone_subject_title = '') => 0.0041340792, 0.0041340792),
   (_phone_match_code_n = NULL) => -0.0003381853, -0.0003381853),
(mth_source_ppth_fseen > 23.5) => -0.0186883728,
(mth_source_ppth_fseen = NULL) => -0.0009993919, -0.0009993919);

// Tree: 902 
final_score_902 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 57) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 103.5) => 
      map(
      (NULL < f_estimated_income_d and f_estimated_income_d <= 72500) => -0.0348160671,
      (f_estimated_income_d > 72500) => -0.0061966104,
      (f_estimated_income_d = NULL) => -0.0187612499, -0.0187612499),
   (f_curraddrmurderindex_i > 103.5) => 0.0037220724,
   (f_curraddrmurderindex_i = NULL) => -0.0093224967, -0.0093224967),
(f_mos_inq_banko_am_lseen_d > 57) => 0.0012568164,
(f_mos_inq_banko_am_lseen_d = NULL) => 0.0009791029, 0.0009791029);

// Tree: 903 
final_score_903 := map(
(NULL < inq_num and inq_num <= 5.5) => 
   map(
   (NULL < eda_num_phs_connected_ind and eda_num_phs_connected_ind <= 0.5) => 0.0003829304,
   (eda_num_phs_connected_ind > 0.5) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 2.5) => 0.0279850595,
      (f_rel_incomeover50_count_d > 2.5) => 0.0031437884,
      (f_rel_incomeover50_count_d = NULL) => 0.0103994072, 0.0103994072),
   (eda_num_phs_connected_ind = NULL) => 0.0006374371, 0.0006374371),
(inq_num > 5.5) => -0.0146540408,
(inq_num = NULL) => 0.0003988628, 0.0003988628);

// Tree: 904 
final_score_904 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 0.5) => -0.0001792657,
(mth_source_ppdid_lseen > 0.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 4.5) => 
      map(
      (NULL < f_inq_lnames_per_addr_i and f_inq_lnames_per_addr_i <= 0.5) => 0.0023043918,
      (f_inq_lnames_per_addr_i > 0.5) => 0.0284790947,
      (f_inq_lnames_per_addr_i = NULL) => 0.0149554982, 0.0149554982),
   (mth_source_ppdid_lseen > 4.5) => 0.0019532627,
   (mth_source_ppdid_lseen = NULL) => 0.0030238950, 0.0030238950),
(mth_source_ppdid_lseen = NULL) => 0.0006877612, 0.0006877612);

// Tree: 905 
final_score_905 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 70475.5) => -0.0017223249,
(f_addrchangevaluediff_d > 70475.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Daughter','Father','Grandfather','Grandmother','Husband','Neighbor','Parent','Sibling','Sister','Son','Spouse','Subject','Wife']) => 0.0014063301,
   (phone_subject_title in ['Associate By Business','Associate By Vehicle','Child','Grandchild','Granddaughter','Grandparent','Grandson','Mother','Relative','Subject at Household']) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 1.5) => 0.0327558206,
      (f_inq_count24_i > 1.5) => 0.0033526614,
      (f_inq_count24_i = NULL) => 0.0166129097, 0.0166129097),
   (phone_subject_title = '') => 0.0033847371, 0.0033847371),
(f_addrchangevaluediff_d = NULL) => 0.0003128122, -0.0005023752);

// Tree: 906 
final_score_906 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.33182982985171) => 
   map(
   (NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 3.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Granddaughter','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => -0.0010475959,
      (phone_subject_title in ['Grandchild','Grandparent','Subject at Household']) => 0.0126747830,
      (phone_subject_title = '') => -0.0005336346, -0.0005336346),
   (mth_source_ppla_lseen > 3.5) => -0.0099591019,
   (mth_source_ppla_lseen = NULL) => -0.0011674459, -0.0011674459),
(f_add_curr_mobility_index_n > 0.33182982985171) => 0.0019383385,
(f_add_curr_mobility_index_n = NULL) => 0.0086472345, 0.0005390781);

// Tree: 907 
final_score_907 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 284.5) => 0.0006919669,
(f_prevaddrageoldest_d > 284.5) => 
   map(
   (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 6.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 340.5) => -0.0079815607,
      (f_prevaddrlenofres_d > 340.5) => 0.0050182125,
      (f_prevaddrlenofres_d = NULL) => -0.0029898613, -0.0029898613),
   (pp_app_ind_ph_cnt > 6.5) => -0.0180034244,
   (pp_app_ind_ph_cnt = NULL) => -0.0040366523, -0.0040366523),
(f_prevaddrageoldest_d = NULL) => 0.0000788568, 0.0000788568);

// Tree: 908 
final_score_908 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 25.5) => 
   map(
   (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => -0.0011579409,
   (f_prevaddrstatus_i > 2.5) => 
      map(
      (NULL < mth_eda_dt_first_seen and mth_eda_dt_first_seen <= 19.5) => 0.0029588734,
      (mth_eda_dt_first_seen > 19.5) => -0.0065954591,
      (mth_eda_dt_first_seen = NULL) => -0.0006363865, -0.0006363865),
   (f_prevaddrstatus_i = NULL) => 0.0024875719, -0.0000765085),
(f_rel_homeover200_count_d > 25.5) => -0.0135447136,
(f_rel_homeover200_count_d = NULL) => -0.0002821937, -0.0002821937);

// Tree: 909 
final_score_909 := map(
(NULL < subject_ssn_mismatch and subject_ssn_mismatch <= -0.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 33.5) => -0.0043982497,
   (f_prevaddrageoldest_d > 33.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Property','Associate By Shared Associates','Child','Daughter','Grandfather','Husband','Neighbor','Sibling','Spouse','Subject at Household','Wife']) => -0.0030021920,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By SSN','Associate By Vehicle','Brother','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Mother','Parent','Relative','Sister','Son','Subject']) => 0.0078936019,
      (phone_subject_title = '') => 0.0034928102, 0.0034928102),
   (f_prevaddrageoldest_d = NULL) => 0.0011329790, 0.0011329790),
(subject_ssn_mismatch > -0.5) => -0.0018029113,
(subject_ssn_mismatch = NULL) => -0.0008446390, -0.0008446390);

// Tree: 910 
final_score_910 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 8.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By SSN','Associate By Vehicle','Brother','Daughter','Grandson','Husband','Mother','Neighbor','Relative','Sibling','Son','Spouse','Subject','Wife']) => 0.0005358138,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Parent','Sister','Subject at Household']) => 
      map(
      (pp_src in ['E1','E2','EN','EQ','PL','UT']) => -0.0104256135,
      (pp_src in ['CY','EM','FA','FF','KW','LA','LP','MD','NW','SL','TN','UW','VO','VW','ZK','ZT']) => 0.0113745833,
      (pp_src = '') => 0.0069523643, 0.0056936974),
   (phone_subject_title = '') => 0.0017533794, 0.0017533794),
(f_rel_incomeover50_count_d > 8.5) => -0.0015583579,
(f_rel_incomeover50_count_d = NULL) => 0.0007502339, 0.0007502339);

// Tree: 911 
final_score_911 := map(
(NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 91.5) => 
   map(
   (NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 79.5) => 
      map(
      (NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 57) => -0.0005945473,
      (mth_source_ppla_lseen > 57) => -0.0183684466,
      (mth_source_ppla_lseen = NULL) => -0.0007332486, -0.0007332486),
   (mth_source_ppfla_fseen > 79.5) => 0.0167311605,
   (mth_source_ppfla_fseen = NULL) => -0.0006001823, -0.0006001823),
(mth_source_ppfla_fseen > 91.5) => -0.0174980282,
(mth_source_ppfla_fseen = NULL) => -0.0007466470, -0.0007466470);

// Tree: 912 
final_score_912 := map(
(NULL < inq_firstseen_n and inq_firstseen_n <= 61.5) => 0.0001500584,
(inq_firstseen_n > 61.5) => 
   map(
   (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 116.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 37.5) => 0.0235353307,
      (f_mos_inq_banko_om_fseen_d > 37.5) => 0.0067733515,
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0105815809, 0.0105815809),
   (eda_avg_days_interrupt > 116.5) => -0.0055900831,
   (eda_avg_days_interrupt = NULL) => 0.0056622963, 0.0056622963),
(inq_firstseen_n = NULL) => 0.0007199839, 0.0007199839);

// Tree: 913 
final_score_913 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 229627) => 0.0005792305,
(f_addrchangevaluediff_d > 229627) => -0.0103113997,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 62.5) => 0.0005840909,
   (r_pb_order_freq_d > 62.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Father','Grandfather','Mother','Neighbor','Relative','Sister','Son','Subject','Subject at Household']) => 0.0037082252,
      (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Vehicle','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Parent','Sibling','Spouse','Wife']) => 0.0354781406,
      (phone_subject_title = '') => 0.0082723539, 0.0082723539),
   (r_pb_order_freq_d = NULL) => -0.0019109069, 0.0009859222), 0.0003752208);

// Tree: 914 
final_score_914 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 1) => 
   map(
   (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 0.5) => -0.0055571098,
   (f_crim_rel_under500miles_cnt_i > 0.5) => 
      map(
      (NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 4.5) => 0.0191550847,
      (f_componentcharrisktype_i > 4.5) => 0.0006724793,
      (f_componentcharrisktype_i = NULL) => 0.0122560477, 0.0122560477),
   (f_crim_rel_under500miles_cnt_i = NULL) => 0.0064474093, 0.0064474093),
(f_prevaddrcartheftindex_i > 1) => -0.0001883780,
(f_prevaddrcartheftindex_i = NULL) => 0.0000795188, 0.0000795188);

// Tree: 915 
final_score_915 := map(
(NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 5.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 33.5) => -0.0000632041,
   (f_rel_under500miles_cnt_d > 33.5) => 0.0145291036,
   (f_rel_under500miles_cnt_d = NULL) => 0.0002220923, 0.0002220923),
(f_crim_rel_under25miles_cnt_i > 5.5) => 
   map(
   (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 12.5) => 0.0128460469,
   (f_rel_ageover20_count_d > 12.5) => -0.0078463400,
   (f_rel_ageover20_count_d = NULL) => -0.0055412982, -0.0055412982),
(f_crim_rel_under25miles_cnt_i = NULL) => -0.0003374810, -0.0003374810);

// Tree: 916 
final_score_916 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Granddaughter','Grandparent','Grandson','Mother','Neighbor','Parent','Sibling','Sister','Spouse','Subject','Subject at Household','Wife']) => -0.0004180535,
(phone_subject_title in ['Brother','Father','Grandchild','Grandfather','Grandmother','Husband','Relative','Son']) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => 0.0018550127,
   (f_sourcerisktype_i > 5.5) => 
      map(
      (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 2.5) => 0.0101234275,
      (f_rel_bankrupt_count_i > 2.5) => 0.0535751808,
      (f_rel_bankrupt_count_i = NULL) => 0.0263490822, 0.0263490822),
   (f_sourcerisktype_i = NULL) => 0.0070150967, 0.0070150967),
(phone_subject_title = '') => 0.0002722465, 0.0002722465);

// Tree: 917 
final_score_917 := map(
(exp_type in ['N']) => 0.0205917988,
(exp_type in ['C']) => 0.0283694072,
(exp_type = '') => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Brother','Daughter','Granddaughter','Grandson','Husband','Neighbor','Relative','Sibling','Sister','Son','Wife']) => -0.0150493098,
      (phone_subject_title in ['Associate By Property','Associate By SSN','Child','Father','Grandchild','Grandfather','Grandmother','Grandparent','Mother','Parent','Spouse','Subject','Subject at Household']) => -0.0022940324,
      (phone_subject_title = '') => -0.0094080325, -0.0094080325),
   (source_rel > 0.5) => 0.0397057578,
   (source_rel = NULL) => -0.0069938486, -0.0069938486), -0.0006939001);

// Tree: 918 
final_score_918 := map(
(NULL < mth_source_paw_lseen and mth_source_paw_lseen <= 2.5) => 
   map(
   (exp_source in ['P']) => -0.0005303458,
   (exp_source in ['S']) => 0.0031827187,
   (exp_source = '') => -0.0001175537, 0.0003313234),
(mth_source_paw_lseen > 2.5) => 
   map(
   (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 11.5) => 0.0022305181,
   (f_rel_homeover50_count_d > 11.5) => 0.0242063857,
   (f_rel_homeover50_count_d = NULL) => 0.0113114551, 0.0113114551),
(mth_source_paw_lseen = NULL) => 0.0004971946, 0.0004971946);

// Tree: 919 
final_score_919 := map(
(NULL < f_util_add_input_misc_n and f_util_add_input_misc_n <= 0.5) => 
   map(
   (NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 31) => 
      map(
      (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Father','Grandmother','Husband','Neighbor','Parent','Sister','Son','Subject']) => -0.0003982119,
      (phone_subject_title in ['Associate By Address','Associate By Shared Associates','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Mother','Relative','Sibling','Spouse','Subject at Household','Wife']) => 0.0051629179,
      (phone_subject_title = '') => 0.0016056988, 0.0016056988),
   (mth_source_ppla_fseen > 31) => 0.0170503905,
   (mth_source_ppla_fseen = NULL) => 0.0019292608, 0.0019292608),
(f_util_add_input_misc_n > 0.5) => -0.0016650219,
(f_util_add_input_misc_n = NULL) => -0.0000717168, -0.0000717168);

// Tree: 920 
final_score_920 := map(
(NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 1.5) => 
   map(
   (NULL < mth_source_edadid_fseen and mth_source_edadid_fseen <= 26.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 79.5) => -0.0052772593,
      (f_curraddrmurderindex_i > 79.5) => -0.0003934513,
      (f_curraddrmurderindex_i = NULL) => -0.0017267538, -0.0017267538),
   (mth_source_edadid_fseen > 26.5) => 0.0141206522,
   (mth_source_edadid_fseen = NULL) => -0.0015030343, -0.0015030343),
(f_rel_incomeover75_count_d > 1.5) => 0.0011258078,
(f_rel_incomeover75_count_d = NULL) => -0.0002863288, -0.0002863288);

// Tree: 921 
final_score_921 := map(
(NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0036892955,
(_phone_match_code_n > 0.5) => 
   map(
   (phone_subject_title in ['Grandmother','Parent','Sibling','Sister','Subject','Subject at Household']) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 7.5) => 0.0064086444,
      (f_inq_count_i > 7.5) => -0.0024183144,
      (f_inq_count_i = NULL) => 0.0013010228, 0.0013010228),
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Mother','Neighbor','Relative','Son','Spouse','Wife']) => 0.0149332814,
   (phone_subject_title = '') => 0.0026562532, 0.0026562532),
(_phone_match_code_n = NULL) => -0.0010099590, -0.0010099590);

// Tree: 922 
final_score_922 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 24.5) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By SSN','Associate By Vehicle','Granddaughter','Grandfather','Grandmother','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Son','Spouse','Subject','Subject at Household']) => -0.0049727325,
   (phone_subject_title in ['Associate','Associate By Business','Associate By Property','Associate By Shared Associates','Brother','Child','Daughter','Father','Grandchild','Grandparent','Mother','Sister','Wife']) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -6327.5) => -0.0008939332,
      (f_addrchangeincomediff_d > -6327.5) => 0.0135524333,
      (f_addrchangeincomediff_d = NULL) => -0.0043907066, 0.0060315402),
   (phone_subject_title = '') => -0.0025691857, -0.0025691857),
(f_prevaddrageoldest_d > 24.5) => 0.0017201861,
(f_prevaddrageoldest_d = NULL) => 0.0008665613, 0.0008665613);

// Tree: 923 
final_score_923 := map(
(NULL < mth_phone_fb_rp_date and mth_phone_fb_rp_date <= 36.5) => 
   map(
   (NULL < eda_months_addr_last_seen and eda_months_addr_last_seen <= 0.5) => -0.0005206214,
   (eda_months_addr_last_seen > 0.5) => 
      map(
      (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.27651665544603) => 0.0144095660,
      (f_add_curr_mobility_index_n > 0.27651665544603) => 0.0002188687,
      (f_add_curr_mobility_index_n = NULL) => 0.0047501239, 0.0047501239),
   (eda_months_addr_last_seen = NULL) => -0.0001707432, -0.0001707432),
(mth_phone_fb_rp_date > 36.5) => -0.0124386448,
(mth_phone_fb_rp_date = NULL) => -0.0003788540, -0.0003788540);

// Tree: 924 
final_score_924 := map(
(NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 135.5) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 12.5) => 0.0008296487,
   (f_rel_homeover100_count_d > 12.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Shared Associates','Associate By Vehicle','Daughter','Grandfather','Grandmother','Grandson','Husband','Neighbor','Parent','Relative','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0036474341,
      (phone_subject_title in ['Associate By Property','Associate By SSN','Brother','Child','Father','Grandchild','Granddaughter','Grandparent','Mother','Sibling']) => 0.0289208428,
      (phone_subject_title = '') => 0.0053757445, 0.0053757445),
   (f_rel_homeover100_count_d = NULL) => 0.0017310066, 0.0017310066),
(f_fp_prevaddrburglaryindex_i > 135.5) => -0.0016029647,
(f_fp_prevaddrburglaryindex_i = NULL) => 0.0005047658, 0.0005047658);

// Tree: 925 
final_score_925 := map(
(NULL < _pp_rule_high_vend_conf and _pp_rule_high_vend_conf <= 0.5) => -0.0001859006,
(_pp_rule_high_vend_conf > 0.5) => 
   map(
   (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 1.5) => -0.0016110139,
   (pp_app_ind_ph_cnt > 1.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 148.5) => 0.0085637477,
      (f_prevaddrageoldest_d > 148.5) => 0.0001350644,
      (f_prevaddrageoldest_d = NULL) => 0.0054612298, 0.0054612298),
   (pp_app_ind_ph_cnt = NULL) => 0.0027699246, 0.0027699246),
(_pp_rule_high_vend_conf = NULL) => 0.0002844109, 0.0002844109);

// Tree: 926 
final_score_926 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 13.5) => -0.0004118212,
(f_inq_count24_i > 13.5) => 
   map(
   (pp_app_ph_use in ['P']) => -0.0055406678,
   (pp_app_ph_use in ['B','O']) => 
      map(
      (NULL < f_prevaddroccupantowned_d and f_prevaddroccupantowned_d <= 0.5) => 0.0204761708,
      (f_prevaddroccupantowned_d > 0.5) => -0.0051310831,
      (f_prevaddroccupantowned_d = NULL) => 0.0108296025, 0.0108296025),
   (pp_app_ph_use = '') => 0.0090779937, 0.0062190946),
(f_inq_count24_i = NULL) => -0.0000611833, -0.0000611833);

// Tree: 927 
final_score_927 := map(
(NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 16.5) => -0.0003935933,
(f_rel_educationover8_count_d > 16.5) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 31.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 92185) => 0.0029407157,
      (f_curraddrmedianincome_d > 92185) => 0.0167791199,
      (f_curraddrmedianincome_d = NULL) => 0.0038367939, 0.0038367939),
   (f_rel_count_i > 31.5) => -0.0020998661,
   (f_rel_count_i = NULL) => 0.0017768195, 0.0017768195),
(f_rel_educationover8_count_d = NULL) => 0.0002245998, 0.0002245998);

// Tree: 928 
final_score_928 := map(
(NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 11.5) => -0.0000769326,
(inq_adl_lastseen_n > 11.5) => 
   map(
   (NULL < mth_pp_datevendorlastseen and mth_pp_datevendorlastseen <= 14.5) => 0.0007287857,
   (mth_pp_datevendorlastseen > 14.5) => 
      map(
      (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 21.5) => 0.0305740024,
      (inq_adl_lastseen_n > 21.5) => 0.0035741225,
      (inq_adl_lastseen_n = NULL) => 0.0115969440, 0.0115969440),
   (mth_pp_datevendorlastseen = NULL) => 0.0034075571, 0.0034075571),
(inq_adl_lastseen_n = NULL) => 0.0002294056, 0.0002294056);

// Tree: 929 
final_score_929 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 23.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -37770) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By Vehicle','Child','Daughter','Grandfather','Husband','Neighbor','Parent','Relative','Sister','Spouse']) => -0.0054440126,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By SSN','Brother','Father','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Mother','Sibling','Son','Subject','Subject at Household','Wife']) => 0.0103093082,
      (phone_subject_title = '') => 0.0036057674, 0.0036057674),
   (f_addrchangeincomediff_d > -37770) => -0.0004302605,
   (f_addrchangeincomediff_d = NULL) => 0.0012687976, 0.0001575238),
(f_rel_incomeover50_count_d > 23.5) => -0.0086895589,
(f_rel_incomeover50_count_d = NULL) => -0.0000161639, -0.0000161639);

// Tree: 930 
final_score_930 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 11.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 2.5) => -0.0155590578,
   (f_srchvelocityrisktype_i > 2.5) => -0.0012054447,
   (f_srchvelocityrisktype_i = NULL) => -0.0065087877, -0.0065087877),
(f_mos_inq_banko_cm_lseen_d > 11.5) => 
   map(
   (NULL < mth_source_sx_fseen and mth_source_sx_fseen <= 53.5) => 0.0006200337,
   (mth_source_sx_fseen > 53.5) => 0.0067803782,
   (mth_source_sx_fseen = NULL) => 0.0007412570, 0.0007412570),
(f_mos_inq_banko_cm_lseen_d = NULL) => 0.0005176952, 0.0005176952);

// Tree: 931 
final_score_931 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 31.5) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By SSN','Child','Father','Husband','Mother','Parent','Son','Spouse','Subject','Wife']) => -0.0104603955,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Neighbor','Relative','Sibling','Sister','Subject at Household']) => 0.0003346124,
   (phone_subject_title = '') => -0.0042953566, -0.0042953566),
(f_mos_inq_banko_cm_fseen_d > 31.5) => 
   map(
   (NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 4.5) => -0.0011130731,
   (f_componentcharrisktype_i > 4.5) => 0.0017526435,
   (f_componentcharrisktype_i = NULL) => 0.0001365279, 0.0001365279),
(f_mos_inq_banko_cm_fseen_d = NULL) => -0.0001027665, -0.0001027665);

// Tree: 932 
final_score_932 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 772513.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 94.5) => -0.0016463586,
   (f_prevaddrlenofres_d > 94.5) => 
      map(
      (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 11.5) => 0.0024675763,
      (f_rel_educationover8_count_d > 11.5) => -0.0012886510,
      (f_rel_educationover8_count_d = NULL) => 0.0007923895, 0.0007923895),
   (f_prevaddrlenofres_d = NULL) => -0.0004072093, -0.0004072093),
(f_curraddrmedianvalue_d > 772513.5) => 0.0114802237,
(f_curraddrmedianvalue_d = NULL) => -0.0003203537, -0.0003203537);

// Tree: 933 
final_score_933 := map(
(NULL < pk_phone_match_level and pk_phone_match_level <= 1.5) => -0.0064543640,
(pk_phone_match_level > 1.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 18.5) => 
      map(
      (NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 10.5) => 0.0110977002,
      (mth_source_ppth_lseen > 10.5) => -0.0106578334,
      (mth_source_ppth_lseen = NULL) => 0.0087582300, 0.0087582300),
   (mth_source_ppdid_lseen > 18.5) => -0.0027621004,
   (mth_source_ppdid_lseen = NULL) => 0.0056425381, 0.0056425381),
(pk_phone_match_level = NULL) => -0.0006500679, -0.0006500679);

// Tree: 934 
final_score_934 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 13.5) => -0.0169785535,
(f_mos_inq_banko_cm_fseen_d > 13.5) => 
   map(
   (pp_origphoneusage in ['H','M','O']) => -0.0108461346,
   (pp_origphoneusage in ['P','S']) => 
      map(
      (NULL < _pp_glb_dppa_fl_glb and _pp_glb_dppa_fl_glb <= 0.5) => 0.0062245896,
      (_pp_glb_dppa_fl_glb > 0.5) => -0.0020307799,
      (_pp_glb_dppa_fl_glb = NULL) => 0.0012677231, 0.0012677231),
   (pp_origphoneusage = '') => 0.0008968729, 0.0007820959),
(f_mos_inq_banko_cm_fseen_d = NULL) => 0.0006611256, 0.0006611256);

// Tree: 935 
final_score_935 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 91363.5) => -0.0006913046,
(f_curraddrmedianincome_d > 91363.5) => 
   map(
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Child','Grandson','Husband','Neighbor','Parent','Sibling','Spouse','Wife']) => -0.0097258893,
   (phone_subject_title in ['Associate','Associate By Address','Associate By SSN','Brother','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Mother','Relative','Sister','Son','Subject','Subject at Household']) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 9.5) => 0.0154737772,
      (f_rel_count_i > 9.5) => 0.0035618300,
      (f_rel_count_i = NULL) => 0.0076169610, 0.0076169610),
   (phone_subject_title = '') => 0.0035279963, 0.0035279963),
(f_curraddrmedianincome_d = NULL) => -0.0003056892, -0.0003056892);

// Tree: 936 
final_score_936 := map(
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Brother','Child','Father','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Relative','Sibling','Sister','Subject']) => -0.0003954716,
(phone_subject_title in ['Associate','Associate By Property','Associate By SSN','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Mother','Parent','Son','Spouse','Subject at Household','Wife']) => 
   map(
   (NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 46.5) => 
      map(
      (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 10.5) => 0.0036173354,
      (f_rel_incomeover75_count_d > 10.5) => -0.0082762081,
      (f_rel_incomeover75_count_d = NULL) => 0.0030718359, 0.0030718359),
   (mth_source_ppla_lseen > 46.5) => -0.0130983350,
   (mth_source_ppla_lseen = NULL) => 0.0025292127, 0.0025292127),
(phone_subject_title = '') => 0.0001441247, 0.0001441247);

// Tree: 937 
final_score_937 := map(
(NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.407333666284595) => 0.0012155837,
(f_add_curr_mobility_index_n > 0.407333666284595) => 
   map(
   (pp_src in ['E1','E2','EM','EQ','FA','UT','UW']) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 44) => -0.0127552925,
      (f_prevaddrcartheftindex_i > 44) => -0.0009934234,
      (f_prevaddrcartheftindex_i = NULL) => -0.0029137285, -0.0029137285),
   (pp_src in ['CY','EN','FF','KW','LA','LP','MD','NW','PL','SL','TN','VO','VW','ZK','ZT']) => 0.0082011290,
   (pp_src = '') => -0.0011206753, -0.0011077773),
(f_add_curr_mobility_index_n = NULL) => -0.0011552343, 0.0004156899);

// Tree: 938 
final_score_938 := map(
(NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 18.5) => 
   map(
   (NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 25.5) => 0.0001198032,
   (mth_source_ppla_fseen > 25.5) => 
      map(
      (NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 40.5) => 0.0097667382,
      (mth_source_ppla_lseen > 40.5) => -0.0041371206,
      (mth_source_ppla_lseen = NULL) => 0.0050043929, 0.0050043929),
   (mth_source_ppla_fseen = NULL) => 0.0002974755, 0.0002974755),
(f_rel_educationover12_count_d > 18.5) => -0.0037611282,
(f_rel_educationover12_count_d = NULL) => -0.0002400411, -0.0002400411);

// Tree: 939 
final_score_939 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => 0.0009019022,
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < mth_source_ppdid_fseen and mth_source_ppdid_fseen <= 17.5) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 8.5) => -0.0028696062,
      (f_rel_under100miles_cnt_d > 8.5) => 0.0024629026,
      (f_rel_under100miles_cnt_d = NULL) => 0.0002217504, 0.0002217504),
   (mth_source_ppdid_fseen > 17.5) => -0.0053115501,
   (mth_source_ppdid_fseen = NULL) => -0.0011935700, -0.0011935700),
(f_util_adl_count_n = NULL) => 0.0003297021, 0.0003297021);

// Tree: 940 
final_score_940 := map(
(NULL < mth_source_ppth_lseen and mth_source_ppth_lseen <= 18.5) => 
   map(
   (NULL < source_utildid and source_utildid <= 0.5) => -0.0002898720,
   (source_utildid > 0.5) => 
      map(
      (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 10.5) => 0.0189534321,
      (mth_source_utildid_fseen > 10.5) => 0.0013390216,
      (mth_source_utildid_fseen = NULL) => 0.0037398005, 0.0037398005),
   (source_utildid = NULL) => 0.0000586263, 0.0000586263),
(mth_source_ppth_lseen > 18.5) => -0.0111429763,
(mth_source_ppth_lseen = NULL) => -0.0003172571, -0.0003172571);

// Tree: 941 
final_score_941 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 21.5) => 0.0001596403,
(f_rel_under25miles_cnt_d > 21.5) => 
   map(
   (NULL < eda_num_interrupts_cur and eda_num_interrupts_cur <= 7.5) => 
      map(
      (phone_subject_title in ['Associate','Daughter','Father','Parent','Spouse']) => -0.0136571387,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Relative','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => -0.0042381349,
      (phone_subject_title = '') => -0.0051895494, -0.0051895494),
   (eda_num_interrupts_cur > 7.5) => 0.0099221122,
   (eda_num_interrupts_cur = NULL) => -0.0036536999, -0.0036536999),
(f_rel_under25miles_cnt_d = NULL) => -0.0001015344, -0.0001015344);

// Tree: 942 
final_score_942 := map(
(NULL < mth_source_inf_lseen and mth_source_inf_lseen <= 3.5) => 
   map(
   (NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 5.5) => -0.0000190917,
   (f_inq_per_ssn_i > 5.5) => -0.0053992231,
   (f_inq_per_ssn_i = NULL) => -0.0002720188, -0.0002720188),
(mth_source_inf_lseen > 3.5) => 
   map(
   (NULL < mth_internal_ver_first_seen and mth_internal_ver_first_seen <= 4.5) => -0.0066103734,
   (mth_internal_ver_first_seen > 4.5) => 0.0021194418,
   (mth_internal_ver_first_seen = NULL) => -0.0044334170, -0.0044334170),
(mth_source_inf_lseen = NULL) => -0.0004765849, -0.0004765849);

// Tree: 943 
final_score_943 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 313223.5) => 0.0004726123,
(f_addrchangevaluediff_d > 313223.5) => -0.0089317695,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 18.5) => -0.0005880653,
   (f_rel_under500miles_cnt_d > 18.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By SSN','Child','Father','Grandfather','Neighbor','Parent','Relative','Sister','Son','Subject','Subject at Household','Wife']) => 0.0017091023,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Daughter','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Mother','Sibling','Spouse']) => 0.0241665308,
      (phone_subject_title = '') => 0.0054134204, 0.0054134204),
   (f_rel_under500miles_cnt_d = NULL) => 0.0005567609, 0.0005567609), 0.0003599837);

// Tree: 944 
final_score_944 := map(
(NULL < number_of_sources and number_of_sources <= 2.5) => 
   map(
   (NULL < _inq_adl_ph_industry_flag and _inq_adl_ph_industry_flag <= 0.5) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => -0.0032880101,
      (phone_subject_title in ['Associate','Associate By Business','Grandchild','Grandmother','Mother','Subject at Household']) => 0.0029466480,
      (phone_subject_title = '') => -0.0022362104, -0.0022362104),
   (_inq_adl_ph_industry_flag > 0.5) => 0.0098198082,
   (_inq_adl_ph_industry_flag = NULL) => -0.0019618297, -0.0019618297),
(number_of_sources > 2.5) => 0.0050252350,
(number_of_sources = NULL) => -0.0012091370, -0.0012091370);

// Tree: 945 
final_score_945 := map(
(pp_source in ['CELL','GONG','OTHER','PCNSR','TARGUS','THRIVE']) => -0.0089174356,
(pp_source in ['HEADER','IBEHAVIOR','INFUTOR','INQUIRY','INTRADO']) => 
   map(
   (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 16.5) => 
      map(
      (NULL < mth_source_ppth_fseen and mth_source_ppth_fseen <= 23.5) => 0.0041704473,
      (mth_source_ppth_fseen > 23.5) => -0.0102893130,
      (mth_source_ppth_fseen = NULL) => 0.0031673398, 0.0031673398),
   (mth_pp_datelastseen > 16.5) => -0.0018360980,
   (mth_pp_datelastseen = NULL) => 0.0012904973, 0.0012904973),
(pp_source = '') => -0.0007980082, -0.0001603536);

// Tree: 946 
final_score_946 := map(
(NULL < mth_pp_app_npa_effective_dt and mth_pp_app_npa_effective_dt <= 168.5) => -0.0006236546,
(mth_pp_app_npa_effective_dt > 168.5) => 
   map(
   (NULL < pp_app_ind_ph_cnt and pp_app_ind_ph_cnt <= 4.5) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 4.5) => -0.0022827003,
      (f_rel_ageover30_count_d > 4.5) => 0.0051783347,
      (f_rel_ageover30_count_d = NULL) => 0.0036304361, 0.0036304361),
   (pp_app_ind_ph_cnt > 4.5) => -0.0007246817,
   (pp_app_ind_ph_cnt = NULL) => 0.0018290900, 0.0018290900),
(mth_pp_app_npa_effective_dt = NULL) => -0.0001507815, -0.0001507815);

// Tree: 947 
final_score_947 := map(
(NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 14) => 0.0004062755,
(mth_source_inf_fseen > 14) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.25811783983906) => 0.0030432415,
   (f_add_input_mobility_index_n > 0.25811783983906) => 
      map(
      (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 3.5) => -0.0069675814,
      (f_crim_rel_under100miles_cnt_i > 3.5) => 0.0029303659,
      (f_crim_rel_under100miles_cnt_i = NULL) => -0.0049044857, -0.0049044857),
   (f_add_input_mobility_index_n = NULL) => -0.0028662310, -0.0028662310),
(mth_source_inf_fseen = NULL) => 0.0001813819, 0.0001813819);

// Tree: 948 
final_score_948 := map(
(NULL < eda_num_phs_discon_hhid and eda_num_phs_discon_hhid <= 3.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 188.5) => 0.0004462362,
   (f_fp_prevaddrburglaryindex_i > 188.5) => -0.0039374335,
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.0001681182, 0.0001681182),
(eda_num_phs_discon_hhid > 3.5) => 
   map(
   (phone_subject_title in ['Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Mother','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Wife']) => -0.0102847680,
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Subject at Household']) => 0.0009745808,
   (phone_subject_title = '') => -0.0057858921, -0.0057858921),
(eda_num_phs_discon_hhid = NULL) => -0.0001732274, -0.0001732274);

// Tree: 949 
final_score_949 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 0.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandfather','Grandmother','Neighbor','Relative','Sibling','Sister','Son','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < eda_days_in_service and eda_days_in_service <= 200) => 0.0033797945,
      (eda_days_in_service > 200) => -0.0015857294,
      (eda_days_in_service = NULL) => 0.0010163341, 0.0010163341),
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Grandchild','Granddaughter','Grandparent','Grandson','Husband','Mother','Parent','Spouse']) => 0.0154818705,
   (phone_subject_title = '') => 0.0018817936, 0.0018817936),
(f_rel_criminal_count_i > 0.5) => -0.0007179455,
(f_rel_criminal_count_i = NULL) => -0.0001905929, -0.0001905929);

// Tree: 950 
final_score_950 := map(
(NULL < f_rel_count_i and f_rel_count_i <= 67.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 24.5) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 8.5) => -0.0002485799,
      (f_rel_ageover40_count_d > 8.5) => 0.0030233339,
      (f_rel_ageover40_count_d = NULL) => 0.0000608670, 0.0000608670),
   (f_rel_ageover30_count_d > 24.5) => -0.0039021946,
   (f_rel_ageover30_count_d = NULL) => -0.0001528834, -0.0001528834),
(f_rel_count_i > 67.5) => 0.0119256256,
(f_rel_count_i = NULL) => -0.0000661383, -0.0000661383);

// Tree: 951 
final_score_951 := map(
(NULL < f_college_income_d and f_college_income_d <= 5.5) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 1.5) => 0.0094957154,
   (f_sourcerisktype_i > 1.5) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 6.5) => -0.0087141711,
      (f_rel_count_i > 6.5) => 0.0023288297,
      (f_rel_count_i = NULL) => 0.0010484817, 0.0010484817),
   (f_sourcerisktype_i = NULL) => 0.0020655000, 0.0020655000),
(f_college_income_d > 5.5) => -0.0023935603,
(f_college_income_d = NULL) => 0.0000659804, 0.0000988575);

// Tree: 952 
final_score_952 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 360300.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 5.5) => 0.0002236902,
   (f_rel_homeover300_count_d > 5.5) => -0.0033763224,
   (f_rel_homeover300_count_d = NULL) => -0.0001171604, -0.0001171604),
(f_curraddrmedianvalue_d > 360300.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 186.5) => 0.0030895785,
   (f_curraddrcartheftindex_i > 186.5) => -0.0088505168,
   (f_curraddrcartheftindex_i = NULL) => 0.0024475051, 0.0024475051),
(f_curraddrmedianvalue_d = NULL) => 0.0001899262, 0.0001899262);

// Tree: 953 
final_score_953 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 220362.5) => 
   map(
   (NULL < _pp_app_nonpub_gong_la and _pp_app_nonpub_gong_la <= 0.5) => 
      map(
      (NULL < eda_address_match_best and eda_address_match_best <= 0.5) => 0.0002615368,
      (eda_address_match_best > 0.5) => 0.0049611304,
      (eda_address_match_best = NULL) => 0.0005145466, 0.0005145466),
   (_pp_app_nonpub_gong_la > 0.5) => 0.0089040179,
   (_pp_app_nonpub_gong_la = NULL) => 0.0006006838, 0.0006006838),
(f_curraddrmedianvalue_d > 220362.5) => -0.0012055094,
(f_curraddrmedianvalue_d = NULL) => 0.0000578865, 0.0000578865);

// Tree: 954 
final_score_954 := map(
(NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 24.5) => 
   map(
   (NULL < source_sx and source_sx <= 0.5) => -0.0003149081,
   (source_sx > 0.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Daughter','Father','Grandmother','Grandson','Husband','Mother','Neighbor','Parent','Relative']) => -0.0033549575,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Grandchild','Granddaughter','Grandfather','Grandparent','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 0.0075835422,
      (phone_subject_title = '') => 0.0038414239, 0.0038414239),
   (source_sx = NULL) => -0.0001897075, -0.0001897075),
(mth_source_inf_fseen > 24.5) => -0.0032861018,
(mth_source_inf_fseen = NULL) => -0.0003840948, -0.0003840948);

// Tree: 955 
final_score_955 := map(
(pp_src in ['CY','E1','EN','FA','PL','TN','UT','VO','ZT']) => 
   map(
   (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 2.5) => 0.0056568613,
   (mth_pp_datelastseen > 2.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 69996) => -0.0011622327,
      (f_curraddrmedianincome_d > 69996) => -0.0068988999,
      (f_curraddrmedianincome_d = NULL) => -0.0023875936, -0.0023875936),
   (mth_pp_datelastseen = NULL) => -0.0015582684, -0.0015582684),
(pp_src in ['E2','EM','EQ','FF','KW','LA','LP','MD','NW','SL','UW','VW','ZK']) => 0.0020561470,
(pp_src = '') => 0.0002974780, 0.0001199447);

// Tree: 956 
final_score_956 := map(
(NULL < eda_address_match_best and eda_address_match_best <= 0.5) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 96999) => -0.0005931474,
   (f_prevaddrmedianincome_d > 96999) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By Vehicle','Daughter','Father','Husband','Mother','Neighbor','Relative','Sibling','Sister','Spouse','Subject at Household']) => -0.0006052737,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By SSN','Brother','Child','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Parent','Son','Subject','Wife']) => 0.0062239780,
      (phone_subject_title = '') => 0.0024081132, 0.0024081132),
   (f_prevaddrmedianincome_d = NULL) => -0.0004282560, -0.0004282560),
(eda_address_match_best > 0.5) => 0.0026950093,
(eda_address_match_best = NULL) => -0.0002406899, -0.0002406899);

// Tree: 957 
final_score_957 := map(
(pp_src in ['E1','E2','EN','EQ','FA','KW','LP','PL','SL','UT','UW']) => 
   map(
   (NULL < inq_lastseen_n and inq_lastseen_n <= 2.5) => 0.0012486042,
   (inq_lastseen_n > 2.5) => -0.0020336360,
   (inq_lastseen_n = NULL) => -0.0004735734, -0.0004735734),
(pp_src in ['CY','EM','FF','LA','MD','NW','TN','VO','VW','ZK','ZT']) => 
   map(
   (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 12.5) => 0.0100250835,
   (mth_pp_datelastseen > 12.5) => -0.0027020446,
   (mth_pp_datelastseen = NULL) => 0.0034535598, 0.0034535598),
(pp_src = '') => 0.0000249480, 0.0000036681);

// Tree: 958 
final_score_958 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 6.5) => -0.0038608608,
(f_prevaddrageoldest_d > 6.5) => 
   map(
   (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 1540) => 
      map(
      (NULL < _inq_adl_ph_industry_cards and _inq_adl_ph_industry_cards <= 0.5) => 0.0001421350,
      (_inq_adl_ph_industry_cards > 0.5) => 0.0054238465,
      (_inq_adl_ph_industry_cards = NULL) => 0.0001879302, 0.0001879302),
   (eda_avg_days_interrupt > 1540) => -0.0094512090,
   (eda_avg_days_interrupt = NULL) => 0.0001013398, 0.0001013398),
(f_prevaddrageoldest_d = NULL) => -0.0000919861, -0.0000919861);

// Tree: 959 
final_score_959 := map(
(NULL < inq_adl_firstseen_n and inq_adl_firstseen_n <= 2.5) => -0.0002012326,
(inq_adl_firstseen_n > 2.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 406870) => 
      map(
      (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Father','Mother','Relative','Spouse','Subject','Subject at Household']) => 0.0003469683,
      (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Neighbor','Parent','Sibling','Sister','Son','Wife']) => 0.0072416861,
      (phone_subject_title = '') => 0.0008988657, 0.0008988657),
   (f_prevaddrmedianvalue_d > 406870) => 0.0071035759,
   (f_prevaddrmedianvalue_d = NULL) => 0.0013771731, 0.0013771731),
(inq_adl_firstseen_n = NULL) => -0.0000186879, -0.0000186879);

// Tree: 960 
final_score_960 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 7.5) => -0.0002565681,
(f_rel_ageover40_count_d > 7.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.39346261390647) => 
      map(
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Brother','Child','Father','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Relative','Sibling','Sister','Wife']) => -0.0003751520,
      (phone_subject_title in ['Associate','Associate By Property','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Grandparent','Parent','Son','Spouse','Subject','Subject at Household']) => 0.0040807822,
      (phone_subject_title = '') => 0.0017920523, 0.0017920523),
   (f_add_curr_mobility_index_n > 0.39346261390647) => -0.0015449632,
   (f_add_curr_mobility_index_n = NULL) => 0.0007174202, 0.0007174202),
(f_rel_ageover40_count_d = NULL) => -0.0000981498, -0.0000981498);

// Tree: 961 
final_score_961 := map(
(NULL < eda_max_days_connected_ind and eda_max_days_connected_ind <= 559.5) => 
   map(
   (NULL < eda_max_days_connected_ind and eda_max_days_connected_ind <= 34.5) => 0.0000491678,
   (eda_max_days_connected_ind > 34.5) => -0.0056713768,
   (eda_max_days_connected_ind = NULL) => -0.0000896523, -0.0000896523),
(eda_max_days_connected_ind > 559.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 11.5) => 0.0014818959,
   (f_rel_under500miles_cnt_d > 11.5) => 0.0095517694,
   (f_rel_under500miles_cnt_d = NULL) => 0.0040406363, 0.0040406363),
(eda_max_days_connected_ind = NULL) => -0.0000057782, -0.0000057782);

// Tree: 962 
final_score_962 := map(
(NULL < inq_num and inq_num <= 8.5) => 
   map(
   (NULL < mth_pp_datelastseen and mth_pp_datelastseen <= 18.5) => 0.0006390449,
   (mth_pp_datelastseen > 18.5) => 
      map(
      (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 2.5) => -0.0005528639,
      (f_crim_rel_under100miles_cnt_i > 2.5) => -0.0049104705,
      (f_crim_rel_under100miles_cnt_i = NULL) => -0.0020067057, -0.0020067057),
   (mth_pp_datelastseen = NULL) => 0.0002713685, 0.0002713685),
(inq_num > 8.5) => -0.0074039027,
(inq_num = NULL) => 0.0002076930, 0.0002076930);

// Tree: 963 
final_score_963 := map(
(NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 182) => 0.0000126498,
(f_fp_prevaddrcrimeindex_i > 182) => 
   map(
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By SSN','Child','Grandfather','Grandmother','Grandson','Husband','Mother','Neighbor','Parent','Sibling','Son','Spouse']) => -0.0024167872,
   (phone_subject_title in ['Associate','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Daughter','Father','Grandchild','Granddaughter','Grandparent','Relative','Sister','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 4.5) => 0.0129052874,
      (f_rel_homeover50_count_d > 4.5) => 0.0027848116,
      (f_rel_homeover50_count_d = NULL) => 0.0039324944, 0.0039324944),
   (phone_subject_title = '') => 0.0018404500, 0.0018404500),
(f_fp_prevaddrcrimeindex_i = NULL) => 0.0002090999, 0.0002090999);

// Tree: 964 
final_score_964 := map(
(NULL < _phone_match_code_lns and _phone_match_code_lns <= 0.5) => -0.0049212178,
(_phone_match_code_lns > 0.5) => 
   map(
   (exp_source in ['S']) => 0.0086500647,
   (exp_source in ['P']) => 0.0120376982,
   (exp_source = '') => 
      map(
      (NULL < source_rel and source_rel <= 0.5) => 0.0000756374,
      (source_rel > 0.5) => 0.0144000385,
      (source_rel = NULL) => 0.0015197414, 0.0015197414), 0.0042034196),
(_phone_match_code_lns = NULL) => -0.0005577520, -0.0005577520);

// Tree: 965 
final_score_965 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 15336) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Brother','Child','Father','Grandfather','Grandson','Husband','Mother','Neighbor','Parent','Sibling','Son','Subject','Subject at Household','Wife']) => -0.0042411488,
   (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Grandmother','Grandparent','Relative','Sister','Spouse']) => 0.0082445508,
   (phone_subject_title = '') => -0.0026955889, -0.0026955889),
(f_prevaddrmedianincome_d > 15336) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 19747) => 0.0051108892,
   (f_prevaddrmedianincome_d > 19747) => 0.0001032646,
   (f_prevaddrmedianincome_d = NULL) => 0.0001980070, 0.0001980070),
(f_prevaddrmedianincome_d = NULL) => 0.0000503892, 0.0000503892);

// Tree: 966 
final_score_966 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 157964) => 0.0001956038,
(f_addrchangevaluediff_d > 157964) => -0.0025842207,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (phone_subject_title in ['Associate','Associate By Business','Associate By Shared Associates','Associate By SSN','Child','Father','Grandfather','Neighbor','Relative','Sibling','Son','Spouse','Subject','Subject at Household','Wife']) => -0.0013679388,
   (phone_subject_title in ['Associate By Address','Associate By Property','Associate By Vehicle','Brother','Daughter','Grandchild','Granddaughter','Grandmother','Grandparent','Grandson','Husband','Mother','Parent','Sister']) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 11.5) => 0.0099040953,
      (f_mos_inq_banko_om_lseen_d > 11.5) => 0.0010536394,
      (f_mos_inq_banko_om_lseen_d = NULL) => 0.0026961913, 0.0026961913),
   (phone_subject_title = '') => -0.0004138785, -0.0004138785), -0.0001041191);

// Tree: 967 
final_score_967 := map(
(NULL < inq_num and inq_num <= 0.5) => -0.0001666515,
(inq_num > 0.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Property','Father','Spouse','Subject','Subject at Household']) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => 0.0027999088,
      (f_sourcerisktype_i > 4.5) => -0.0007776265,
      (f_sourcerisktype_i = NULL) => 0.0012648966, 0.0012648966),
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Wife']) => 0.0106294602,
   (phone_subject_title = '') => 0.0017891477, 0.0017891477),
(inq_num = NULL) => 0.0000539693, 0.0000539693);

// Tree: 968 
final_score_968 := map(
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Vehicle','Grandparent','Grandson','Neighbor','Relative','Sister','Spouse','Subject at Household','Wife']) => -0.0013947281,
(phone_subject_title in ['Associate','Associate By Property','Associate By Shared Associates','Associate By SSN','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Husband','Mother','Parent','Sibling','Son','Subject']) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 1.5) => 0.0013432650,
   (f_srchssnsrchcount_i > 1.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 34) => -0.0036833277,
      (f_curraddrcartheftindex_i > 34) => 0.0000933815,
      (f_curraddrcartheftindex_i = NULL) => -0.0005024658, -0.0005024658),
   (f_srchssnsrchcount_i = NULL) => 0.0003815078, 0.0003815078),
(phone_subject_title = '') => -0.0003352768, -0.0003352768);

// Tree: 969 
final_score_969 := map(
(NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 2.5) => 0.0004370757,
(f_crim_rel_under500miles_cnt_i > 2.5) => 
   map(
   (NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 3.5) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 2.5) => -0.0037072414,
      (f_rel_incomeover50_count_d > 2.5) => 0.0000145773,
      (f_rel_incomeover50_count_d = NULL) => -0.0005719123, -0.0005719123),
   (mth_source_ppla_lseen > 3.5) => -0.0056091105,
   (mth_source_ppla_lseen = NULL) => -0.0007763072, -0.0007763072),
(f_crim_rel_under500miles_cnt_i = NULL) => -0.0000644057, -0.0000644057);

// Tree: 970 
final_score_970 := map(
(NULL < inq_num and inq_num <= 5.5) => 
   map(
   (NULL < inq_num and inq_num <= 0.5) => -0.0001335853,
   (inq_num > 0.5) => 0.0014422152,
   (inq_num = NULL) => 0.0000233195, 0.0000233195),
(inq_num > 5.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.41443738470998) => -0.0005195705,
   (f_add_curr_mobility_index_n > 0.41443738470998) => -0.0073081447,
   (f_add_curr_mobility_index_n = NULL) => -0.0032638877, -0.0032638877),
(inq_num = NULL) => -0.0000344793, -0.0000344793);

// Tree: 971 
final_score_971 := map(
(NULL < f_rel_count_i and f_rel_count_i <= 59.5) => 
   map(
   (phone_subject_title in ['Associate','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Granddaughter','Grandfather','Grandmother','Grandson','Mother','Neighbor','Parent','Relative','Sibling','Sister','Spouse','Subject','Wife']) => -0.0005812095,
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By SSN','Daughter','Father','Grandchild','Grandparent','Husband','Son','Subject at Household']) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 213157.5) => 0.0018562263,
      (f_prevaddrmedianvalue_d > 213157.5) => -0.0011173654,
      (f_prevaddrmedianvalue_d = NULL) => 0.0009964836, 0.0009964836),
   (phone_subject_title = '') => -0.0001927085, -0.0001927085),
(f_rel_count_i > 59.5) => 0.0058818833,
(f_rel_count_i = NULL) => -0.0001302700, -0.0001302700);

// Tree: 972 
final_score_972 := map(
(NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => -0.0002250698,
(f_prevaddrstatus_i > 2.5) => 
   map(
   (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 3.5) => 0.0007570406,
   (f_rel_incomeover100_count_d > 3.5) => -0.0047941191,
   (f_rel_incomeover100_count_d = NULL) => 0.0004203537, 0.0004203537),
(f_prevaddrstatus_i = NULL) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -103989.5) => -0.0029073969,
   (f_addrchangevaluediff_d > -103989.5) => 0.0017762460,
   (f_addrchangevaluediff_d = NULL) => 0.0011273643, 0.0012384378), 0.0003126634);

// Tree: 973 
final_score_973 := map(
(NULL < mth_source_rel_fseen and mth_source_rel_fseen <= 10.5) => 
   map(
   (NULL < f_add_curr_mobility_index_n and f_add_curr_mobility_index_n <= 0.264155850216085) => 0.0011985650,
   (f_add_curr_mobility_index_n > 0.264155850216085) => -0.0002226790,
   (f_add_curr_mobility_index_n = NULL) => 0.0000570784, 0.0001460728),
(mth_source_rel_fseen > 10.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 8.5) => 0.0005154051,
   (f_inq_count_i > 8.5) => 0.0059626449,
   (f_inq_count_i = NULL) => 0.0029077739, 0.0029077739),
(mth_source_rel_fseen = NULL) => 0.0001966835, 0.0001966835);

// Tree: 974 
final_score_974 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 778981) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 68.5) => 
      map(
      (NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 61.5) => 0.0000004636,
      (mth_source_ppla_lseen > 61.5) => -0.0062037739,
      (mth_source_ppla_lseen = NULL) => -0.0000449542, -0.0000449542),
   (mth_source_utildid_fseen > 68.5) => -0.0046334678,
   (mth_source_utildid_fseen = NULL) => -0.0000981892, -0.0000981892),
(f_curraddrmedianvalue_d > 778981) => 0.0057708514,
(f_curraddrmedianvalue_d = NULL) => -0.0000553071, -0.0000553071);

// Tree: 975 
final_score_975 := map(
(phone_subject_title in ['Associate','Associate By SSN','Brother','Child','Daughter','Father','Grandfather','Grandparent','Grandson','Husband','Mother','Neighbor','Relative','Sibling','Sister','Son','Subject']) => -0.0003883593,
(phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Grandchild','Granddaughter','Grandmother','Parent','Spouse','Subject at Household','Wife']) => 
   map(
   (NULL < f_college_income_d and f_college_income_d <= 3.5) => 0.0063117353,
   (f_college_income_d > 3.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 137) => 0.0054808973,
      (f_curraddrburglaryindex_i > 137) => -0.0027151640,
      (f_curraddrburglaryindex_i = NULL) => 0.0031260588, 0.0031260588),
   (f_college_income_d = NULL) => 0.0002810898, 0.0008309431),
(phone_subject_title = '') => -0.0000432224, -0.0000432224);

// Tree: 976 
final_score_976 := map(
(NULL < mth_exp_last_update and mth_exp_last_update <= 11.5) => 0.0000097109,
(mth_exp_last_update > 11.5) => 
   map(
   (NULL < f_vardobcount_i and f_vardobcount_i <= 2.5) => 
      map(
      (pp_src in ['E2','EN','LP','NW','TN','UT','VO']) => -0.0029991772,
      (pp_src in ['CY','E1','EM','EQ','FA','FF','KW','LA','MD','PL','SL','UW','VW','ZK','ZT']) => 0.0019301491,
      (pp_src = '') => -0.0016544603, -0.0015638195),
   (f_vardobcount_i > 2.5) => 0.0030711744,
   (f_vardobcount_i = NULL) => -0.0011816075, -0.0011816075),
(mth_exp_last_update = NULL) => -0.0001172982, -0.0001172982);

// Tree: 977 
final_score_977 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 10.5) => 
   map(
   (NULL < mth_source_ppfla_fseen and mth_source_ppfla_fseen <= 71.5) => 0.0000249989,
   (mth_source_ppfla_fseen > 71.5) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 8.5) => 0.0000132597,
      (f_rel_under100miles_cnt_d > 8.5) => -0.0056258707,
      (f_rel_under100miles_cnt_d = NULL) => -0.0025014876, -0.0025014876),
   (mth_source_ppfla_fseen = NULL) => -0.0000220174, -0.0000220174),
(f_rel_homeover500_count_d > 10.5) => -0.0031818596,
(f_rel_homeover500_count_d = NULL) => -0.0000600925, -0.0000600925);

// Tree: 978 
final_score_978 := map(
(NULL < f_college_income_d and f_college_income_d <= 5.5) => -0.0001880605,
(f_college_income_d > 5.5) => -0.0023697900,
(f_college_income_d = NULL) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 90713.5) => -0.0001495554,
   (f_curraddrmedianincome_d > 90713.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 26.5) => 0.0010470544,
      (f_addrchangecrimediff_i > 26.5) => 0.0067573285,
      (f_addrchangecrimediff_i = NULL) => 0.0016338090, 0.0018383871),
   (f_curraddrmedianincome_d = NULL) => 0.0000384776, 0.0000384776), -0.0001257498);

// Tree: 979 
final_score_979 := map(
(NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 32.5) => 
   map(
   (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 0.5) => -0.0003855538,
   (mth_source_ppdid_lseen > 0.5) => 
      map(
      (NULL < mth_source_ppdid_lseen and mth_source_ppdid_lseen <= 10.5) => 0.0027729362,
      (mth_source_ppdid_lseen > 10.5) => -0.0000973100,
      (mth_source_ppdid_lseen = NULL) => 0.0011726635, 0.0011726635),
   (mth_source_ppdid_lseen = NULL) => -0.0000485691, -0.0000485691),
(mth_source_ppdid_lseen > 32.5) => -0.0023514141,
(mth_source_ppdid_lseen = NULL) => -0.0002088216, -0.0002088216);

// Tree: 980 
final_score_980 := map(
(NULL < eda_max_days_connected_ind and eda_max_days_connected_ind <= 1230) => 
   map(
   (NULL < inq_adl_lastseen_n and inq_adl_lastseen_n <= 38.5) => 0.0002054357,
   (inq_adl_lastseen_n > 38.5) => 
      map(
      (NULL < inq_lastseen_n and inq_lastseen_n <= 44.5) => -0.0041134935,
      (inq_lastseen_n > 44.5) => 0.0006841982,
      (inq_lastseen_n = NULL) => -0.0015206984, -0.0015206984),
   (inq_adl_lastseen_n = NULL) => 0.0001546034, 0.0001546034),
(eda_max_days_connected_ind > 1230) => 0.0029467003,
(eda_max_days_connected_ind = NULL) => 0.0001877933, 0.0001877933);

// Tree: 981 
final_score_981 := map(
(exp_type in ['N']) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 60.5) => -0.0010419687,
   (f_mos_inq_banko_cm_lseen_d > 60.5) => 0.0033227818,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0013038211, 0.0013038211),
(exp_type in ['C']) => 0.0022987405,
(exp_type = '') => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => -0.0011312567,
   (source_rel > 0.5) => 0.0025762184,
   (source_rel = NULL) => -0.0009417318, -0.0009417318), -0.0004013401);

// Tree: 982 
final_score_982 := map(
(NULL < eda_days_in_service and eda_days_in_service <= 506.5) => 0.0002543526,
(eda_days_in_service > 506.5) => 
   map(
   (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 5.5) => 0.0007775503,
   (f_rel_homeover50_count_d > 5.5) => 
      map(
      (NULL < inq_lastseen_n and inq_lastseen_n <= 17.5) => -0.0017841000,
      (inq_lastseen_n > 17.5) => 0.0002932244,
      (inq_lastseen_n = NULL) => -0.0010395055, -0.0010395055),
   (f_rel_homeover50_count_d = NULL) => -0.0006466285, -0.0006466285),
(eda_days_in_service = NULL) => -0.0000603661, -0.0000603661);

// Tree: 983 
final_score_983 := map(
(NULL < f_inq_per_ssn_i and f_inq_per_ssn_i <= 9.5) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 13.5) => 0.0000850426,
   (f_inq_count24_i > 13.5) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 10.5) => -0.0019598670,
      (f_mos_inq_banko_om_lseen_d > 10.5) => 0.0034659862,
      (f_mos_inq_banko_om_lseen_d = NULL) => 0.0025564501, 0.0025564501),
   (f_inq_count24_i = NULL) => 0.0001928474, 0.0001928474),
(f_inq_per_ssn_i > 9.5) => -0.0028314530,
(f_inq_per_ssn_i = NULL) => 0.0001389222, 0.0001389222);

// Tree: 984 
final_score_984 := map(
(NULL < mth_source_edala_fseen and mth_source_edala_fseen <= 25) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 161.5) => 0.0002625704,
   (f_fp_prevaddrburglaryindex_i > 161.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 181502.5) => -0.0002018814,
      (f_prevaddrmedianvalue_d > 181502.5) => -0.0027767961,
      (f_prevaddrmedianvalue_d = NULL) => -0.0004664377, -0.0004664377),
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.0001060999, 0.0001060999),
(mth_source_edala_fseen > 25) => -0.0020175827,
(mth_source_edala_fseen = NULL) => 0.0000811185, 0.0000811185);

// Tree: 985 
final_score_985 := map(
(NULL < eda_address_match_best and eda_address_match_best <= 0.5) => 0.0000628153,
(eda_address_match_best > 0.5) => 
   map(
   (phone_subject_title in ['Associate','Brother','Father','Grandmother','Husband','Mother','Neighbor']) => -0.0018195434,
   (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Child','Daughter','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 60) => 0.0049534600,
      (f_mos_inq_banko_cm_fseen_d > 60) => 0.0012006208,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0019732641, 0.0019732641),
   (phone_subject_title = '') => 0.0008670286, 0.0008670286),
(eda_address_match_best = NULL) => 0.0001106140, 0.0001106140);

// Tree: 986 
final_score_986 := map(
(NULL < _pp_origlistingtype_res and _pp_origlistingtype_res <= 0.5) => 0.0001752188,
(_pp_origlistingtype_res > 0.5) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 1.5) => -0.0009373643,
   (f_rel_incomeover75_count_d > 1.5) => 
      map(
      (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 9.5) => 0.0014661329,
      (mth_pp_datevendorfirstseen > 9.5) => -0.0003991868,
      (mth_pp_datevendorfirstseen = NULL) => 0.0001171821, 0.0001171821),
   (f_rel_incomeover75_count_d = NULL) => -0.0004026171, -0.0004026171),
(_pp_origlistingtype_res = NULL) => 0.0000183102, 0.0000183102);

// Tree: 987 
final_score_987 := map(
(pp_app_scc in ['B','C','N','R']) => -0.0000533858,
(pp_app_scc in ['8','A','J','S']) => 
   map(
   (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 8.5) => 0.0031452438,
   (mth_pp_app_npa_last_change_dt > 8.5) => 0.0003688203,
   (mth_pp_app_npa_last_change_dt = NULL) => 0.0008159094, 0.0008159094),
(pp_app_scc = '') => 
   map(
   (NULL < eda_days_ph_first_seen and eda_days_ph_first_seen <= 79) => 0.0048930814,
   (eda_days_ph_first_seen > 79) => -0.0001889161,
   (eda_days_ph_first_seen = NULL) => -0.0001197105, -0.0001197105), -0.0000227263);

// Tree: 988 
final_score_988 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 3.5) => 
   map(
   (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 60) => 
      map(
      (pp_src in ['E1','EM','EN','EQ','TN','UT','VO']) => -0.0015056367,
      (pp_src in ['CY','E2','FA','FF','KW','LA','LP','MD','NW','PL','SL','UW','VW','ZK','ZT']) => 0.0016799134,
      (pp_src = '') => -0.0007793227, -0.0007893529),
   (mth_pp_datevendorfirstseen > 60) => 0.0022553351,
   (mth_pp_datevendorfirstseen = NULL) => -0.0006546322, -0.0006546322),
(f_rel_under100miles_cnt_d > 3.5) => 0.0000750625,
(f_rel_under100miles_cnt_d = NULL) => -0.0000579633, -0.0000579633);

// Tree: 989 
final_score_989 := map(
(NULL < source_utildid and source_utildid <= 0.5) => -0.0001759759,
(source_utildid > 0.5) => 
   map(
   (NULL < mth_source_utildid_fseen and mth_source_utildid_fseen <= 12.5) => 0.0045692696,
   (mth_source_utildid_fseen > 12.5) => 
      map(
      (NULL < number_of_sources and number_of_sources <= 2.5) => -0.0006914393,
      (number_of_sources > 2.5) => 0.0011805324,
      (number_of_sources = NULL) => 0.0002301909, 0.0002301909),
   (mth_source_utildid_fseen = NULL) => 0.0008807699, 0.0008807699),
(source_utildid = NULL) => -0.0000756139, -0.0000756139);

// Tree: 990 
final_score_990 := map(
(NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 57.5) => 
   map(
   (NULL < mth_source_ppla_fseen and mth_source_ppla_fseen <= 30.5) => -0.0000833182,
   (mth_source_ppla_fseen > 30.5) => 
      map(
      (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 1.5) => 0.0025561108,
      (f_crim_rel_under500miles_cnt_i > 1.5) => -0.0004242725,
      (f_crim_rel_under500miles_cnt_i = NULL) => 0.0011847688, 0.0011847688),
   (mth_source_ppla_fseen = NULL) => -0.0000575260, -0.0000575260),
(mth_source_ppla_lseen > 57.5) => -0.0026754394,
(mth_source_ppla_lseen = NULL) => -0.0000776239, -0.0000776239);

// Tree: 991 
final_score_991 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -149.5) => 0.0021780182,
(f_addrchangecrimediff_i > -149.5) => 0.0000332337,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By SSN','Brother','Child','Daughter','Father','Grandfather','Grandson','Husband','Mother','Neighbor','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => -0.0000731275,
   (phone_subject_title in ['Associate By Property','Associate By Shared Associates','Associate By Vehicle','Grandchild','Granddaughter','Grandmother','Grandparent','Parent']) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 92.5) => -0.0005977951,
      (f_curraddrcartheftindex_i > 92.5) => 0.0051366296,
      (f_curraddrcartheftindex_i = NULL) => 0.0024634391, 0.0024634391),
   (phone_subject_title = '') => 0.0000994369, 0.0000994369), 0.0000683812);

// Tree: 992 
final_score_992 := map(
(NULL < mth_source_inf_fseen and mth_source_inf_fseen <= 23.5) => 0.0001223549,
(mth_source_inf_fseen > 23.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.304953312712705) => 
      map(
      (NULL < eda_avg_days_interrupt and eda_avg_days_interrupt <= 51.5) => 0.0013011731,
      (eda_avg_days_interrupt > 51.5) => -0.0008691514,
      (eda_avg_days_interrupt = NULL) => 0.0002262482, 0.0002262482),
   (f_add_input_mobility_index_n > 0.304953312712705) => -0.0016142608,
   (f_add_input_mobility_index_n = NULL) => -0.0008724587, -0.0008724587),
(mth_source_inf_fseen = NULL) => 0.0000560833, 0.0000560833);

// Tree: 993 
final_score_993 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By SSN','Associate By Vehicle','Child','Granddaughter','Grandfather','Grandparent','Grandson','Mother','Neighbor','Parent','Relative','Sibling','Sister','Spouse','Subject']) => -0.0001344176,
(phone_subject_title in ['Associate By Shared Associates','Brother','Daughter','Father','Grandchild','Grandmother','Husband','Son','Subject at Household','Wife']) => 
   map(
   (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 1.5) => 
      map(
      (NULL < f_prevaddrdwelltype_apt_n and f_prevaddrdwelltype_apt_n <= 0.5) => 0.0001502583,
      (f_prevaddrdwelltype_apt_n > 0.5) => 0.0013613697,
      (f_prevaddrdwelltype_apt_n = NULL) => 0.0003750083, 0.0003750083),
   (f_srchunvrfdphonecount_i > 1.5) => 0.0031551046,
   (f_srchunvrfdphonecount_i = NULL) => 0.0005103444, 0.0005103444),
(phone_subject_title = '') => 0.0000017041, 0.0000017041);

// Tree: 994 
final_score_994 := map(
(NULL < _pp_app_nonpub_targ_la and _pp_app_nonpub_targ_la <= 0.5) => 0.0000128178,
(_pp_app_nonpub_targ_la > 0.5) => 
   map(
   (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 96.5) => -0.0017470076,
      (f_prevaddrlenofres_d > 96.5) => 0.0016362962,
      (f_prevaddrlenofres_d = NULL) => -0.0000553557, -0.0000553557),
   (f_prevaddrstatus_i > 2.5) => 0.0005373861,
   (f_prevaddrstatus_i = NULL) => 0.0026448936, 0.0008427328),
(_pp_app_nonpub_targ_la = NULL) => 0.0000399472, 0.0000399472);

// Tree: 995 
final_score_995 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 89384) => -0.0001215796,
(f_curraddrmedianincome_d > 89384) => 
   map(
   (pp_source in ['CELL','INFUTOR','INQUIRY','PCNSR','TARGUS','THRIVE']) => 0.0005210378,
   (pp_source in ['GONG','HEADER','IBEHAVIOR','INTRADO','OTHER']) => 
      map(
      (NULL < mth_pp_app_npa_last_change_dt and mth_pp_app_npa_last_change_dt <= 101.5) => 0.0001391232,
      (mth_pp_app_npa_last_change_dt > 101.5) => 0.0035362074,
      (mth_pp_app_npa_last_change_dt = NULL) => 0.0017205245, 0.0017205245),
   (pp_source = '') => -0.0000004915, 0.0003942378),
(f_curraddrmedianincome_d = NULL) => -0.0000700298, -0.0000700298);

// Tree: 996 
final_score_996 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 3.5) => 
   map(
   (NULL < mth_source_ppla_lseen and mth_source_ppla_lseen <= 14.5) => 0.0000834529,
   (mth_source_ppla_lseen > 14.5) => -0.0007423332,
   (mth_source_ppla_lseen = NULL) => 0.0000538326, 0.0000538326),
(f_srchfraudsrchcountyr_i > 3.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 43.5) => 0.0029563565,
   (f_mos_inq_banko_cm_fseen_d > 43.5) => 0.0005378264,
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0009704514, 0.0009704514),
(f_srchfraudsrchcountyr_i = NULL) => 0.0001065028, 0.0001065028);

// Tree: 997 
final_score_997 := map(
(NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 10.5) => 
   map(
   (NULL < eda_days_in_service and eda_days_in_service <= 103.5) => 
      map(
      (phone_subject_title in ['Associate','Associate By Address','Associate By Shared Associates','Associate By SSN','Brother','Child','Father','Neighbor','Parent','Relative','Sibling','Subject','Subject at Household']) => 0.0002611942,
      (phone_subject_title in ['Associate By Business','Associate By Property','Associate By Vehicle','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Sister','Son','Spouse','Wife']) => 0.0055491158,
      (phone_subject_title = '') => 0.0003564034, 0.0003564034),
   (eda_days_in_service > 103.5) => -0.0001982425,
   (eda_days_in_service = NULL) => 0.0000252091, 0.0000252091),
(mth_pp_first_build_date > 10.5) => -0.0005037544,
(mth_pp_first_build_date = NULL) => -0.0000522753, -0.0000522753);

// Tree: 998 
final_score_998 := map(
(phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By Vehicle','Brother','Child','Father','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse','Subject','Subject at Household','Wife']) => 
   map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 8.5) => 0.0000919660,
   (f_rel_incomeover50_count_d > 8.5) => -0.0002151978,
   (f_rel_incomeover50_count_d = NULL) => -0.0000009056, -0.0000009056),
(phone_subject_title in ['Associate By SSN','Daughter','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent']) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 114) => 0.0029192008,
   (f_curraddrcrimeindex_i > 114) => -0.0001753326,
   (f_curraddrcrimeindex_i = NULL) => 0.0013872536, 0.0013872536),
(phone_subject_title = '') => 0.0000164550, 0.0000164550);

// Tree: 999 
final_score_999 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 9.5) => -0.0002029752,
(f_rel_under500miles_cnt_d > 9.5) => 
   map(
   (NULL < f_add_input_mobility_index_n and f_add_input_mobility_index_n <= 0.752078020491615) => 
      map(
      (NULL < _phone_match_code_z and _phone_match_code_z <= 0.5) => -0.0001179825,
      (_phone_match_code_z > 0.5) => 0.0004337432,
      (_phone_match_code_z = NULL) => 0.0001842219, 0.0001842219),
   (f_add_input_mobility_index_n > 0.752078020491615) => -0.0006548665,
   (f_add_input_mobility_index_n = NULL) => 0.0001079775, 0.0001079775),
(f_rel_under500miles_cnt_d = NULL) => -0.0000396188, -0.0000396188);

// Tree: 1000 
final_score_1000 := map(
(NULL < mth_pp_first_build_date and mth_pp_first_build_date <= 7.5) => 
   map(
   (NULL < f_util_add_curr_misc_n and f_util_add_curr_misc_n <= 0.5) => 
      map(
      (NULL < mth_pp_datevendorfirstseen and mth_pp_datevendorfirstseen <= 57.5) => 0.0002761098,
      (mth_pp_datevendorfirstseen > 57.5) => 0.0019188484,
      (mth_pp_datevendorfirstseen = NULL) => 0.0003249784, 0.0003249784),
   (f_util_add_curr_misc_n > 0.5) => -0.0000229525,
   (f_util_add_curr_misc_n = NULL) => 0.0000956480, 0.0000956480),
(mth_pp_first_build_date > 7.5) => -0.0002397747,
(mth_pp_first_build_date = NULL) => 0.0000264535, 0.0000264535);

// Tree: 1001 
final_score_1001 := map(
(NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 1.5) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 8.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 147.5) => -0.0003331340,
      (f_prevaddrmurderindex_i > 147.5) => 0.0003273911,
      (f_prevaddrmurderindex_i = NULL) => -0.0000568160, -0.0000568160),
   (f_corrssnnamecount_d > 8.5) => -0.0010065816,
   (f_corrssnnamecount_d = NULL) => -0.0001576607, -0.0001576607),
(f_rel_homeover100_count_d > 1.5) => 0.0001063285,
(f_rel_homeover100_count_d = NULL) => 0.0000346832, 0.0000346832);

// Tree: 1002 
final_score_1002 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 774866) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 2.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 192.5) => -0.0002450264,
      (f_curraddrcartheftindex_i > 192.5) => 0.0015244012,
      (f_curraddrcartheftindex_i = NULL) => -0.0001772322, -0.0001772322),
   (f_rel_under25miles_cnt_d > 2.5) => 0.0000165440,
   (f_rel_under25miles_cnt_d = NULL) => -0.0000150935, -0.0000150935),
(f_curraddrmedianvalue_d > 774866) => 0.0009759932,
(f_curraddrmedianvalue_d = NULL) => -0.0000089567, -0.0000089567);

// Tree: 1003 
final_score_1003 := map(
(NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0002633627,
(_phone_match_code_n > 0.5) => 
   map(
   (phone_subject_title in ['Daughter','Subject','Subject at Household','Wife']) => 
      map(
      (NULL < number_of_sources and number_of_sources <= 2.5) => 0.0000097828,
      (number_of_sources > 2.5) => 0.0005026180,
      (number_of_sources = NULL) => 0.0001279204, 0.0001279204),
   (phone_subject_title in ['Associate','Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Father','Grandchild','Granddaughter','Grandfather','Grandmother','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Sister','Son','Spouse']) => 0.0008875709,
   (phone_subject_title = '') => 0.0002027806, 0.0002027806),
(_phone_match_code_n = NULL) => -0.0000689054, -0.0000689054);

// Tree: 1004 
final_score_1004 := map(
(NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 0.5) => 
   map(
   (NULL < _phone_match_code_n and _phone_match_code_n <= 0.5) => -0.0000189534,
   (_phone_match_code_n > 0.5) => 
      map(
      (phone_subject_title in ['Associate','Grandmother','Sister','Subject','Subject at Household','Wife']) => 0.0000793503,
      (phone_subject_title in ['Associate By Address','Associate By Business','Associate By Property','Associate By Shared Associates','Associate By SSN','Associate By Vehicle','Brother','Child','Daughter','Father','Grandchild','Granddaughter','Grandfather','Grandparent','Grandson','Husband','Mother','Neighbor','Parent','Relative','Sibling','Son','Spouse']) => 0.0009055329,
      (phone_subject_title = '') => 0.0001064650, 0.0001064650),
   (_phone_match_code_n = NULL) => 0.0000322134, 0.0000322134),
(f_srchunvrfdphonecount_i > 0.5) => -0.0001172676,
(f_srchunvrfdphonecount_i = NULL) => -0.0000025143, -0.0000025143);

// Tree: 1005 
final_score_1005 := map(
(NULL < inq_num and inq_num <= 2.5) => -0.0000096753,
(inq_num > 2.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 177249.5) => 
      map(
      (NULL < f_inq_adls_per_addr_i and f_inq_adls_per_addr_i <= 1.5) => 0.0001401221,
      (f_inq_adls_per_addr_i > 1.5) => 0.0006491231,
      (f_inq_adls_per_addr_i = NULL) => 0.0003217117, 0.0003217117),
   (f_prevaddrmedianvalue_d > 177249.5) => -0.0000781519,
   (f_prevaddrmedianvalue_d = NULL) => 0.0001604764, 0.0001604764),
(inq_num = NULL) => -0.0000031440, -0.0000031440);

// Tree: 1006 
final_score_1006 := map(
(exp_type in ['N']) => 
   map(
   (NULL < eda_address_match_best and eda_address_match_best <= 0.5) => 0.0002323293,
   (eda_address_match_best > 0.5) => 0.0011843292,
   (eda_address_match_best = NULL) => 0.0005213293, 0.0005213293),
(exp_type in ['C']) => 0.0007126409,
(exp_type = '') => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => -0.0002321362,
   (source_rel > 0.5) => 0.0010343213,
   (source_rel = NULL) => -0.0001683634, -0.0001683634), -0.0000135012);

// Tree: 1007 
final_score_1007 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 251987) => 0.0000074184,
(f_addrchangevaluediff_d > 251987) => -0.0001572223,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (pp_src in ['CY','E2','EM','EQ','LP','NW','SL','UT','VO','ZT']) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 18.5) => -0.0000798918,
      (f_rel_under500miles_cnt_d > 18.5) => 0.0002095483,
      (f_rel_under500miles_cnt_d = NULL) => -0.0000275357, -0.0000275357),
   (pp_src in ['E1','EN','FA','FF','KW','LA','MD','PL','TN','UW','VW','ZK']) => 0.0001887562,
   (pp_src = '') => -0.0000162666, -0.0000063986), -0.0000002438);

// Tree: 1008 
final_score_1008 := map(
(NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 5.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -3292) => -0.0000227201,
   (f_addrchangeincomediff_d > -3292) => 0.0000317114,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 0.5) => 0.0000096974,
      (f_rel_incomeover75_count_d > 0.5) => 0.0001435064,
      (f_rel_incomeover75_count_d = NULL) => 0.0000620219, 0.0000620219), 0.0000250272),
(f_rel_educationover12_count_d > 5.5) => -0.0000078310,
(f_rel_educationover12_count_d = NULL) => 0.0000006052, 0.0000006052);

// Tree: 1009 
final_score_1009 := map(
(exp_type in ['N']) => 
   map(
   (NULL < eda_address_match_best and eda_address_match_best <= 0.5) => 0.0000625605,
   (eda_address_match_best > 0.5) => 0.0003084140,
   (eda_address_match_best = NULL) => 0.0001387872, 0.0001387872),
(exp_type in ['C']) => 0.0001660023,
(exp_type = '') => 
   map(
   (NULL < source_rel and source_rel <= 0.5) => -0.0000568359,
   (source_rel > 0.5) => 0.0002353022,
   (source_rel = NULL) => -0.0000424773, -0.0000424773), -0.0000037687);

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
      final_score_945, final_score_946, final_score_947, final_score_948, final_score_949, 
      final_score_950, final_score_951, final_score_952, final_score_953, final_score_954, 
      final_score_955, final_score_956, final_score_957, final_score_958, final_score_959, 
      final_score_960, final_score_961, final_score_962, final_score_963, final_score_964, 
      final_score_965, final_score_966, final_score_967, final_score_968, final_score_969, 
      final_score_970, final_score_971, final_score_972, final_score_973, final_score_974, 
      final_score_975, final_score_976, final_score_977, final_score_978, final_score_979, 
      final_score_980, final_score_981, final_score_982, final_score_983, final_score_984, 
      final_score_985, final_score_986, final_score_987, final_score_988, final_score_989, 
      final_score_990, final_score_991, final_score_992, final_score_993, final_score_994, 
      final_score_995, final_score_996, final_score_997, final_score_998, final_score_999, 
      final_score_1000, final_score_1001, final_score_1002, final_score_1003, final_score_1004, 
      final_score_1005, final_score_1006, final_score_1007, final_score_1008, final_score_1009);   
			
	points := 40;

	odds := 1 / 20;

	base := 300;

	phat := exp(final_score) / (1 + exp(final_score));

	wf8_1 := round(points * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);

	// wf8 := min(if(max(wf8_1, 999) = NULL, NULL, max(wf8_1, 999)), 0);
	wf8 := max(min(wf8_1,999),0);        /* Apply Caps at 0 and 999      PK - 5/11/2016 */
			
	#if(PHONE_DEBUG)
			self.clam                             := le;
			self.sysdate                          := sysdate;
			self.phone_pos_cr                     := phone_pos_cr;
			self.phone_pos_edaca                  := phone_pos_edaca;
			self.phone_pos_edadid                 := phone_pos_edadid;
			self.phone_pos_edafa                  := phone_pos_edafa;
			self.phone_pos_edafla                 := phone_pos_edafla;
			self.phone_pos_edahistory             := phone_pos_edahistory;
			self.phone_pos_edala                  := phone_pos_edala;
			self.phone_pos_edalfa                 := phone_pos_edalfa;
			self.phone_pos_exp                    := phone_pos_exp;
			self.phone_pos_inf                    := phone_pos_inf;
			self.phone_pos_input                  := phone_pos_input;
			self.phone_pos_md                     := phone_pos_md;
			self.phone_pos_ne                     := phone_pos_ne;
			self.phone_pos_paw                    := phone_pos_paw;
			self.phone_pos_pde                    := phone_pos_pde;
			self.phone_pos_pf                     := phone_pos_pf;
			self.phone_pos_pffla                  := phone_pos_pffla;
			self.phone_pos_pfla                   := phone_pos_pfla;
			self.phone_pos_ppca                   := phone_pos_ppca;
			self.phone_pos_ppdid                  := phone_pos_ppdid;
			self.phone_pos_ppfa                   := phone_pos_ppfa;
			self.phone_pos_ppfla                  := phone_pos_ppfla;
			self.phone_pos_ppla                   := phone_pos_ppla;
			self.phone_pos_pplfa                  := phone_pos_pplfa;
			self.phone_pos_ppth                   := phone_pos_ppth;
			self.phone_pos_rel                    := phone_pos_rel;
			self.phone_pos_rm                     := phone_pos_rm;
			self.phone_pos_sp                     := phone_pos_sp;
			self.phone_pos_sx                     := phone_pos_sx;
			self.phone_pos_utildid                := phone_pos_utildid;
			self.source_cr                        := source_cr;
			self.source_edaca                     := source_edaca;
			self.source_edadid                    := source_edadid;
			self.source_edafa                     := source_edafa;
			self.source_edafla                    := source_edafla;
			self.source_edahistory                := source_edahistory;
			self.source_edala                     := source_edala;
			self.source_edalfa                    := source_edalfa;
			self.source_exp                       := source_exp;
			self.source_inf                       := source_inf;
			self.source_input                     := source_input;
			self.source_md                        := source_md;
			self.source_ne                        := source_ne;
			self.source_paw                       := source_paw;
			self.source_pde                       := source_pde;
			self.source_pf                        := source_pf;
			self.source_pffla                     := source_pffla;
			self.source_pfla                      := source_pfla;
			self.source_ppca                      := source_ppca;
			self.source_ppdid                     := source_ppdid;
			self.source_ppfa                      := source_ppfa;
			self.source_ppfla                     := source_ppfla;
			self.source_ppla                      := source_ppla;
			self.source_pplfa                     := source_pplfa;
			self.source_ppth                      := source_ppth;
			self.source_rel                       := source_rel;
			self.source_rm                        := source_rm;
			self.source_sp                        := source_sp;
			self.source_sx                        := source_sx;
			self.source_utildid                   := source_utildid;
			self.source_cr_lseen                  := source_cr_lseen;
			self.source_cr_fseen                  := source_cr_fseen;
			self.source_edaca_fseen               := source_edaca_fseen;
			self.source_edadid_fseen              := source_edadid_fseen;
			self.source_edafla_fseen              := source_edafla_fseen;
			self.source_edahistory_fseen          := source_edahistory_fseen;
			self.source_edala_fseen               := source_edala_fseen;
			self.source_inf_lseen                 := source_inf_lseen;
			self.source_inf_fseen                 := source_inf_fseen;
			self.source_md_fseen                  := source_md_fseen;
			self.source_paw_lseen                 := source_paw_lseen;
			self.source_paw_fseen                 := source_paw_fseen;
			self.source_pf_fseen                  := source_pf_fseen;
			self.source_ppca_lseen                := source_ppca_lseen;
			self.source_ppca_fseen                := source_ppca_fseen;
			self.source_ppdid_lseen               := source_ppdid_lseen;
			self.source_ppdid_fseen               := source_ppdid_fseen;
			self.source_ppfa_lseen                := source_ppfa_lseen;
			self.source_ppfla_lseen               := source_ppfla_lseen;
			self.source_ppfla_fseen               := source_ppfla_fseen;
			self.source_ppla_lseen                := source_ppla_lseen;
			self.source_ppla_fseen                := source_ppla_fseen;
			self.source_ppth_lseen                := source_ppth_lseen;
			self.source_ppth_fseen                := source_ppth_fseen;
			self.source_rel_fseen                 := source_rel_fseen;
			self.source_rm_fseen                  := source_rm_fseen;
			self.source_sp_lseen                  := source_sp_lseen;
			self.source_sp_fseen                  := source_sp_fseen;
			self.source_sx_fseen                  := source_sx_fseen;
			self.source_utildid_fseen             := source_utildid_fseen;
			self.source_eda_any_clean             := source_eda_any_clean;
			self.number_of_sources                := number_of_sources;
			self.source_cr_lseen2                 := source_cr_lseen2;
			// self.yr_source_cr_lseen               := yr_source_cr_lseen;
			self.source_cr_fseen2                 := source_cr_fseen2;
			// self.yr_source_cr_fseen               := yr_source_cr_fseen;
			self.source_edaca_fseen2              := source_edaca_fseen2;
			// self.yr_source_edaca_fseen            := yr_source_edaca_fseen;
			self.source_edadid_fseen2             := source_edadid_fseen2;
			// self.yr_source_edadid_fseen           := yr_source_edadid_fseen;
			self.source_edafla_fseen2             := source_edafla_fseen2;
			// self.yr_source_edafla_fseen           := yr_source_edafla_fseen;
			self.source_edahistory_fseen2         := source_edahistory_fseen2;
			// self.yr_source_edahistory_fseen       := yr_source_edahistory_fseen;
			self.source_edala_fseen2              := source_edala_fseen2;
			// self.yr_source_edala_fseen            := yr_source_edala_fseen;
			self.source_inf_lseen2                := source_inf_lseen2;
			// self.yr_source_inf_lseen              := yr_source_inf_lseen;
			self.source_inf_fseen2                := source_inf_fseen2;
			// self.yr_source_inf_fseen              := yr_source_inf_fseen;
			self.source_md_fseen2                 := source_md_fseen2;
			// self.yr_source_md_fseen               := yr_source_md_fseen;
			self.source_paw_lseen2                := source_paw_lseen2;
			// self.yr_source_paw_lseen              := yr_source_paw_lseen;
			self.source_paw_fseen2                := source_paw_fseen2;
			// self.yr_source_paw_fseen              := yr_source_paw_fseen;
			self.source_pf_fseen2                 := source_pf_fseen2;
			// self.yr_source_pf_fseen               := yr_source_pf_fseen;
			self.source_ppca_lseen2               := source_ppca_lseen2;
			// self.yr_source_ppca_lseen             := yr_source_ppca_lseen;
			self.source_ppca_fseen2               := source_ppca_fseen2;
			// self.yr_source_ppca_fseen             := yr_source_ppca_fseen;
			self.source_ppdid_lseen2              := source_ppdid_lseen2;
			// self.yr_source_ppdid_lseen            := yr_source_ppdid_lseen;
			self.source_ppdid_fseen2              := source_ppdid_fseen2;
			// self.yr_source_ppdid_fseen            := yr_source_ppdid_fseen;
			self.source_ppfa_lseen2               := source_ppfa_lseen2;
			// self.yr_source_ppfa_lseen             := yr_source_ppfa_lseen;
			self.source_ppfla_lseen2              := source_ppfla_lseen2;
			// self.yr_source_ppfla_lseen            := yr_source_ppfla_lseen;
			self.source_ppfla_fseen2              := source_ppfla_fseen2;
			// self.yr_source_ppfla_fseen            := yr_source_ppfla_fseen;
			self.source_ppla_lseen2               := source_ppla_lseen2;
			// self.yr_source_ppla_lseen             := yr_source_ppla_lseen;
			self.source_ppla_fseen2               := source_ppla_fseen2;
			// self.yr_source_ppla_fseen             := yr_source_ppla_fseen;
			self.source_ppth_lseen2               := source_ppth_lseen2;
			// self.yr_source_ppth_lseen             := yr_source_ppth_lseen;
			self.source_ppth_fseen2               := source_ppth_fseen2;
			// self.yr_source_ppth_fseen             := yr_source_ppth_fseen;
			self.source_rel_fseen2                := source_rel_fseen2;
			// self.yr_source_rel_fseen              := yr_source_rel_fseen;
			self.source_rm_fseen2                 := source_rm_fseen2;
			// self.yr_source_rm_fseen               := yr_source_rm_fseen;
			self.source_sp_lseen2                 := source_sp_lseen2;
			// self.yr_source_sp_lseen               := yr_source_sp_lseen;
			self.source_sp_fseen2                 := source_sp_fseen2;
			// self.yr_source_sp_fseen               := yr_source_sp_fseen;
			self.source_sx_fseen2                 := source_sx_fseen2;
			// self.yr_source_sx_fseen               := yr_source_sx_fseen;
			self.source_utildid_fseen2            := source_utildid_fseen2;
			// self.yr_source_utildid_fseen          := yr_source_utildid_fseen;
			self.eda_dt_first_seen2               := eda_dt_first_seen2;
			// self.yr_eda_dt_first_seen             := yr_eda_dt_first_seen;
			self.exp_last_update2                 := exp_last_update2;
			// self.yr_exp_last_update               := yr_exp_last_update;
			self.internal_ver_first_seen2         := internal_ver_first_seen2;
			// self.yr_internal_ver_first_seen       := yr_internal_ver_first_seen;
			self.phone_fb_rp_date2                := phone_fb_rp_date2;
			// self.yr_phone_fb_rp_date              := yr_phone_fb_rp_date;
			self.pp_datefirstseen2                := pp_datefirstseen2;
			// self.yr_pp_datefirstseen              := yr_pp_datefirstseen;
			self.pp_datelastseen2                 := pp_datelastseen2;
			// self.yr_pp_datelastseen               := yr_pp_datelastseen;
			self.pp_datevendorfirstseen2          := pp_datevendorfirstseen2;
			// self.yr_pp_datevendorfirstseen        := yr_pp_datevendorfirstseen;
			self.pp_datevendorlastseen2           := pp_datevendorlastseen2;
			// self.yr_pp_datevendorlastseen         := yr_pp_datevendorlastseen;
			self.pp_date_nonglb_lastseen2         := pp_date_nonglb_lastseen2;
			// self.yr_pp_date_nonglb_lastseen       := yr_pp_date_nonglb_lastseen;
			self.pp_orig_lastseen2                := pp_orig_lastseen2;
			// self.yr_pp_orig_lastseen              := yr_pp_orig_lastseen;
			self.pp_app_npa_effective_dt2         := pp_app_npa_effective_dt2;
			// self.yr_pp_app_npa_effective_dt       := yr_pp_app_npa_effective_dt;
			self.pp_app_npa_last_change_dt2       := pp_app_npa_last_change_dt2;
			// self.yr_pp_app_npa_last_change_dt     := yr_pp_app_npa_last_change_dt;
			self.pp_eda_hist_ph_dt2               := pp_eda_hist_ph_dt2;
			// self.yr_pp_eda_hist_ph_dt             := yr_pp_eda_hist_ph_dt;
			self.pp_eda_hist_did_dt2              := pp_eda_hist_did_dt2;
			// self.yr_pp_eda_hist_did_dt            := yr_pp_eda_hist_did_dt;
			self.pp_app_fb_ph_dt2                 := pp_app_fb_ph_dt2;
			// self.yr_pp_app_fb_ph_dt               := yr_pp_app_fb_ph_dt;
			self.pp_app_fb_ph7_did_dt2            := pp_app_fb_ph7_did_dt2;
			// self.yr_pp_app_fb_ph7_did_dt          := yr_pp_app_fb_ph7_did_dt;
			self.pp_first_build_date2             := pp_first_build_date2;
			// self.yr_pp_first_build_date           := yr_pp_first_build_date;
			self.mth_source_cr_lseen              := mth_source_cr_lseen;
			self.mth_source_cr_fseen              := mth_source_cr_fseen;
			self.mth_source_edaca_fseen           := mth_source_edaca_fseen;
			self.mth_source_edadid_fseen          := mth_source_edadid_fseen;
			self.mth_source_edafla_fseen          := mth_source_edafla_fseen;
			self.mth_source_edahistory_fseen      := mth_source_edahistory_fseen;
			self.mth_source_edala_fseen           := mth_source_edala_fseen;
			self.mth_source_inf_lseen             := mth_source_inf_lseen;
			self.mth_source_inf_fseen             := mth_source_inf_fseen;
			self.mth_source_md_fseen              := mth_source_md_fseen;
			self.mth_source_paw_lseen             := mth_source_paw_lseen;
			self.mth_source_paw_fseen             := mth_source_paw_fseen;
			self.mth_source_pf_fseen              := mth_source_pf_fseen;
			self.mth_source_ppca_lseen            := mth_source_ppca_lseen;
			self.mth_source_ppca_fseen            := mth_source_ppca_fseen;
			self.mth_source_ppdid_lseen           := mth_source_ppdid_lseen;
			self.mth_source_ppdid_fseen           := mth_source_ppdid_fseen;
			self.mth_source_ppfa_lseen            := mth_source_ppfa_lseen;
			self.mth_source_ppfla_lseen           := mth_source_ppfla_lseen;
			self.mth_source_ppfla_fseen           := mth_source_ppfla_fseen;
			self.mth_source_ppla_lseen            := mth_source_ppla_lseen;
			self.mth_source_ppla_fseen            := mth_source_ppla_fseen;
			self.mth_source_ppth_lseen            := mth_source_ppth_lseen;
			self.mth_source_ppth_fseen            := mth_source_ppth_fseen;
			self.mth_source_rel_fseen             := mth_source_rel_fseen;
			self.mth_source_rm_fseen              := mth_source_rm_fseen;
			self.mth_source_sp_lseen              := mth_source_sp_lseen;
			self.mth_source_sp_fseen              := mth_source_sp_fseen;
			self.mth_source_sx_fseen              := mth_source_sx_fseen;
			self.mth_source_utildid_fseen         := mth_source_utildid_fseen;
			self.mth_eda_dt_first_seen            := mth_eda_dt_first_seen;
			self.mth_exp_last_update              := mth_exp_last_update;
			self.mth_internal_ver_first_seen      := mth_internal_ver_first_seen;
			self.mth_phone_fb_rp_date             := mth_phone_fb_rp_date;
			self.mth_pp_datefirstseen             := mth_pp_datefirstseen;
			self.mth_pp_datelastseen              := mth_pp_datelastseen;
			self.mth_pp_datevendorfirstseen       := mth_pp_datevendorfirstseen;
			self.mth_pp_datevendorlastseen        := mth_pp_datevendorlastseen;
			self.mth_pp_date_nonglb_lastseen      := mth_pp_date_nonglb_lastseen;
			self.mth_pp_orig_lastseen             := mth_pp_orig_lastseen;
			self.mth_pp_app_npa_effective_dt      := mth_pp_app_npa_effective_dt;
			self.mth_pp_app_npa_last_change_dt    := mth_pp_app_npa_last_change_dt;
			self.mth_pp_eda_hist_ph_dt            := mth_pp_eda_hist_ph_dt;
			self.mth_pp_eda_hist_did_dt           := mth_pp_eda_hist_did_dt;
			self.mth_pp_app_fb_ph_dt              := mth_pp_app_fb_ph_dt;
			self.mth_pp_app_fb_ph7_did_dt         := mth_pp_app_fb_ph7_did_dt;
			self.mth_pp_first_build_date          := mth_pp_first_build_date;
			self._phone_match_code_a              := _phone_match_code_a;
			self._phone_match_code_c              := _phone_match_code_c;
			self._phone_match_code_d              := _phone_match_code_d;
			self._phone_match_code_l              := _phone_match_code_l;
			self._phone_match_code_n              := _phone_match_code_n;
			self._phone_match_code_s              := _phone_match_code_s;
			self._phone_match_code_t              := _phone_match_code_t;
			self._phone_match_code_z              := _phone_match_code_z;
			self._pp_rule_seen_once               := _pp_rule_seen_once;
			self._pp_rule_high_vend_conf          := _pp_rule_high_vend_conf;
			self._pp_rule_low_vend_conf           := _pp_rule_low_vend_conf;
			self._pp_rule_cellphone_latest        := _pp_rule_cellphone_latest;
			self._pp_rule_targ_non_pub            := _pp_rule_targ_non_pub;
			self._pp_rule_med_vend_conf_cell      := _pp_rule_med_vend_conf_cell;
			self._pp_rule_iq_rpc                  := _pp_rule_iq_rpc;
			self._pp_rule_ins_ver_above           := _pp_rule_ins_ver_above;
			self._pp_rule_30                      := _pp_rule_30;
			self._pp_src_all_eq                   := _pp_src_all_eq;
			self._pp_src_all_uw                   := _pp_src_all_uw;
			self._pp_src_all_iq                   := _pp_src_all_iq;
			self._pp_src_all_tn                   := _pp_src_all_tn;
			self._pp_src_all_ib                   := _pp_src_all_ib;
			self._pp_src_all_48                   := _pp_src_all_48;
			self._pp_app_nonpub_gong_la           := _pp_app_nonpub_gong_la;
			self._pp_app_nonpub_targ_la           := _pp_app_nonpub_targ_la;
			self._pp_app_nonpub_targ_lap          := _pp_app_nonpub_targ_lap;
			self._pp_app_ported_match_7           := _pp_app_ported_match_7;
			self.inq_firstseen_n                  := inq_firstseen_n;
			self.inq_lastseen_n                   := inq_lastseen_n;
			self.inq_adl_firstseen_n              := inq_adl_firstseen_n;
			self.inq_adl_lastseen_n               := inq_adl_lastseen_n;
			// self._interval_ver_match_lexid        := _interval_ver_match_lexid;
			// self._interval_ver_match_spouse       := _interval_ver_match_spouse;
			// self._interval_ver_match_hhid         := _interval_ver_match_hhid;
			self._internal_ver_match_level        := _internal_ver_match_level;
			self._inq_adl_ph_industry_auto        := _inq_adl_ph_industry_auto;
			self._inq_adl_ph_industry_cards       := _inq_adl_ph_industry_cards;
			self._inq_adl_ph_industry_flag        := _inq_adl_ph_industry_flag;
			self._pp_agegroup                     := _pp_agegroup;
			self._pp_app_nxx_type                 := _pp_app_nxx_type;
			self._pp_app_fb_ph                    := _pp_app_fb_ph;
			self._pp_app_fb_ph7_did               := _pp_app_fb_ph7_did;
			self._phone_disconnected              := _phone_disconnected;
			self._phone_zip_match                 := _phone_zip_match;
			self._phone_timezone_match            := _phone_timezone_match;
			self._phone_fb_result                 := _phone_fb_result;
			self._phone_fb_rp_result              := _phone_fb_rp_result;
			self._phone_match_code_lns            := _phone_match_code_lns;
			self._phone_match_code_tcza           := _phone_match_code_tcza;
			self.pk_phone_match_level             := pk_phone_match_level;
			self._pp_app_coctype_landline         := _pp_app_coctype_landline;
			self._pp_app_coctype_cell             := _pp_app_coctype_cell;
			self._phone_switch_type_cell          := _phone_switch_type_cell;
			self._pp_app_nxx_type_cell            := _pp_app_nxx_type_cell;
			self._pp_app_ph_type_cell             := _pp_app_ph_type_cell;
			self._pp_app_company_type_cell        := _pp_app_company_type_cell;
			self._exp_type_cell                   := _exp_type_cell;
			self.pk_cell_indicator                := pk_cell_indicator;
			self.pk_cell_flag                     := pk_cell_flag;
			self._pp_glb_dppa_fl_glb              := _pp_glb_dppa_fl_glb;
			self._pp_origlistingtype_res          := _pp_origlistingtype_res;
			self.pk_exp_hit                       := pk_exp_hit;
			self.segment                          := segment;
			self.r_nas_addr_verd_d                := r_nas_addr_verd_d;
			self.r_pb_order_freq_d                := r_pb_order_freq_d;
			self.f_bus_fname_verd_d               := f_bus_fname_verd_d;
			self.f_bus_name_nover_i               := f_bus_name_nover_i;
			self.f_adl_util_inf_n                 := f_adl_util_inf_n;
			self.f_adl_util_conv_n                := f_adl_util_conv_n;
			self.f_adl_util_misc_n                := f_adl_util_misc_n;
			self.f_util_adl_count_n               := f_util_adl_count_n;
			self.f_util_add_input_inf_n           := f_util_add_input_inf_n;
			self.f_util_add_input_conv_n          := f_util_add_input_conv_n;
			self.f_util_add_input_misc_n          := f_util_add_input_misc_n;
			self.f_util_add_curr_conv_n           := f_util_add_curr_conv_n;
			self.f_util_add_curr_misc_n           := f_util_add_curr_misc_n;
			self.f_add_input_mobility_index_n     := f_add_input_mobility_index_n;
			self.f_add_curr_mobility_index_n      := f_add_curr_mobility_index_n;
			self.f_inq_count_i                    := f_inq_count_i;
			self.f_inq_count24_i                  := f_inq_count24_i;
			self.f_inq_per_ssn_i                  := f_inq_per_ssn_i;
			self.f_inq_addrs_per_ssn_i            := f_inq_addrs_per_ssn_i;
			self.f_inq_per_addr_i                 := f_inq_per_addr_i;
			self.f_inq_adls_per_addr_i            := f_inq_adls_per_addr_i;
			self.f_inq_lnames_per_addr_i          := f_inq_lnames_per_addr_i;
			self.f_inq_ssns_per_addr_i            := f_inq_ssns_per_addr_i;
			self._inq_banko_am_first_seen         := _inq_banko_am_first_seen;
			self.f_mos_inq_banko_am_fseen_d       := f_mos_inq_banko_am_fseen_d;
			self._inq_banko_am_last_seen          := _inq_banko_am_last_seen;
			self.f_mos_inq_banko_am_lseen_d       := f_mos_inq_banko_am_lseen_d;
			self._inq_banko_cm_first_seen         := _inq_banko_cm_first_seen;
			self.f_mos_inq_banko_cm_fseen_d       := f_mos_inq_banko_cm_fseen_d;
			self._inq_banko_cm_last_seen          := _inq_banko_cm_last_seen;
			self.f_mos_inq_banko_cm_lseen_d       := f_mos_inq_banko_cm_lseen_d;
			self._inq_banko_om_first_seen         := _inq_banko_om_first_seen;
			self.f_mos_inq_banko_om_fseen_d       := f_mos_inq_banko_om_fseen_d;
			self._inq_banko_om_last_seen          := _inq_banko_om_last_seen;
			self.f_mos_inq_banko_om_lseen_d       := f_mos_inq_banko_om_lseen_d;
			self.f_attr_arrest_recency_d          := f_attr_arrest_recency_d;
			self.f_foreclosure_flag_i             := f_foreclosure_flag_i;
			self.f_estimated_income_d             := f_estimated_income_d;
			self.f_wealth_index_d                 := f_wealth_index_d;
			self.f_college_income_d               := f_college_income_d;
			self.f_rel_count_i                    := f_rel_count_i;
			self.f_rel_incomeover25_count_d       := f_rel_incomeover25_count_d;
			self.f_rel_incomeover50_count_d       := f_rel_incomeover50_count_d;
			self.f_rel_incomeover75_count_d       := f_rel_incomeover75_count_d;
			self.f_rel_incomeover100_count_d      := f_rel_incomeover100_count_d;
			self.f_rel_homeover50_count_d         := f_rel_homeover50_count_d;
			self.f_rel_homeover100_count_d        := f_rel_homeover100_count_d;
			self.f_rel_homeover200_count_d        := f_rel_homeover200_count_d;
			self.f_rel_homeover300_count_d        := f_rel_homeover300_count_d;
			self.f_rel_homeover500_count_d        := f_rel_homeover500_count_d;
			self.f_rel_ageover20_count_d          := f_rel_ageover20_count_d;
			self.f_rel_ageover30_count_d          := f_rel_ageover30_count_d;
			self.f_rel_ageover40_count_d          := f_rel_ageover40_count_d;
			self.f_rel_ageover50_count_d          := f_rel_ageover50_count_d;
			self.f_rel_ageover60_count_d          := f_rel_ageover60_count_d;
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
			self.f_accident_count_i               := f_accident_count_i;
			self.f_acc_damage_amt_total_i         := f_acc_damage_amt_total_i;
			self._acc_last_seen                   := _acc_last_seen;
			self.f_mos_acc_lseen_d                := f_mos_acc_lseen_d;
			self.f_acc_damage_amt_last_i          := f_acc_damage_amt_last_i;
			self.f_idrisktype_i                   := f_idrisktype_i;
			self.f_idverrisktype_i                := f_idverrisktype_i;
			self.f_sourcerisktype_i               := f_sourcerisktype_i;
			self.f_varrisktype_i                  := f_varrisktype_i;
			self.f_vardobcount_i                  := f_vardobcount_i;
			self.f_vardobcountnew_i               := f_vardobcountnew_i;
			self.f_srchvelocityrisktype_i         := f_srchvelocityrisktype_i;
			self.f_srchcountwk_i                  := f_srchcountwk_i;
			self.f_srchunvrfdaddrcount_i          := f_srchunvrfdaddrcount_i;
			self.f_srchunvrfddobcount_i           := f_srchunvrfddobcount_i;
			self.f_srchunvrfdphonecount_i         := f_srchunvrfdphonecount_i;
			self.f_srchfraudsrchcount_i           := f_srchfraudsrchcount_i;
			self.f_srchfraudsrchcountyr_i         := f_srchfraudsrchcountyr_i;
			self.f_assocrisktype_i                := f_assocrisktype_i;
			self.f_assocsuspicousidcount_i        := f_assocsuspicousidcount_i;
			self.f_assoccredbureaucount_i         := f_assoccredbureaucount_i;
			self.f_validationrisktype_i           := f_validationrisktype_i;
			self.f_corrrisktype_i                 := f_corrrisktype_i;
			self.f_corrssnnamecount_d             := f_corrssnnamecount_d;
			self.f_corrssnaddrcount_d             := f_corrssnaddrcount_d;
			self.f_corraddrnamecount_d            := f_corraddrnamecount_d;
			self.f_corrphonelastnamecount_d       := f_corrphonelastnamecount_d;
			self.f_divrisktype_i                  := f_divrisktype_i;
			self.f_divssnidmsrcurelcount_i        := f_divssnidmsrcurelcount_i;
			self.f_divaddrsuspidcountnew_i        := f_divaddrsuspidcountnew_i;
			self.f_srchssnsrchcount_i             := f_srchssnsrchcount_i;
			self.f_srchaddrsrchcount_i            := f_srchaddrsrchcount_i;
			self.f_srchaddrsrchcountmo_i          := f_srchaddrsrchcountmo_i;
			self.f_srchaddrsrchcountwk_i          := f_srchaddrsrchcountwk_i;
			self.f_componentcharrisktype_i        := f_componentcharrisktype_i;
			self.f_inputaddractivephonelist_d     := f_inputaddractivephonelist_d;
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
			self.f_prevaddrdwelltype_apt_n        := f_prevaddrdwelltype_apt_n;
			self.f_prevaddrstatus_i               := f_prevaddrstatus_i;
			self.f_prevaddroccupantowned_d        := f_prevaddroccupantowned_d;
			self.f_prevaddrmedianincome_d         := f_prevaddrmedianincome_d;
			self.f_prevaddrmedianvalue_d          := f_prevaddrmedianvalue_d;
			self.f_prevaddrmurderindex_i          := f_prevaddrmurderindex_i;
			self.f_prevaddrcartheftindex_i        := f_prevaddrcartheftindex_i;
			self.f_fp_prevaddrburglaryindex_i     := f_fp_prevaddrburglaryindex_i;
			self.f_fp_prevaddrcrimeindex_i        := f_fp_prevaddrcrimeindex_i;
			self.r_has_paw_source_d               := r_has_paw_source_d;
			self._paw_first_seen                  := _paw_first_seen;
			self.r_mos_since_paw_fseen_d          := r_mos_since_paw_fseen_d;
			self.r_paw_dead_business_ct_i         := r_paw_dead_business_ct_i;
			self.r_paw_active_phone_ct_d          := r_paw_active_phone_ct_d;
			self.final_score          						:= final_score;
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
			self.final_score_950	:=	final_score_950	;
			self.final_score_951	:=	final_score_951	;
			self.final_score_952	:=	final_score_952	;
			self.final_score_953	:=	final_score_953	;
			self.final_score_954	:=	final_score_954	;
			self.final_score_955	:=	final_score_955	;
			self.final_score_956	:=	final_score_956	;
			self.final_score_957	:=	final_score_957	;
			self.final_score_958	:=	final_score_958	;
			self.final_score_959	:=	final_score_959	;
			self.final_score_960	:=	final_score_960	;
			self.final_score_961	:=	final_score_961	;
			self.final_score_962	:=	final_score_962	;
			self.final_score_963	:=	final_score_963	;
			self.final_score_964	:=	final_score_964	;
			self.final_score_965	:=	final_score_965	;
			self.final_score_966	:=	final_score_966	;
			self.final_score_967	:=	final_score_967	;
			self.final_score_968	:=	final_score_968	;
			self.final_score_969	:=	final_score_969	;
			self.final_score_970	:=	final_score_970	;
			self.final_score_971	:=	final_score_971	;
			self.final_score_972	:=	final_score_972	;
			self.final_score_973	:=	final_score_973	;
			self.final_score_974	:=	final_score_974	;
			self.final_score_975	:=	final_score_975	;
			self.final_score_976	:=	final_score_976	;
			self.final_score_977	:=	final_score_977	;
			self.final_score_978	:=	final_score_978	;
			self.final_score_979	:=	final_score_979	;
			self.final_score_980	:=	final_score_980	;
			self.final_score_981	:=	final_score_981	;
			self.final_score_982	:=	final_score_982	;
			self.final_score_983	:=	final_score_983	;
			self.final_score_984	:=	final_score_984	;
			self.final_score_985	:=	final_score_985	;
			self.final_score_986	:=	final_score_986	;
			self.final_score_987	:=	final_score_987	;
			self.final_score_988	:=	final_score_988	;
			self.final_score_989	:=	final_score_989	;
			self.final_score_990	:=	final_score_990	;
			self.final_score_991	:=	final_score_991	;
			self.final_score_992	:=	final_score_992	;
			self.final_score_993	:=	final_score_993	;
			self.final_score_994	:=	final_score_994	;
			self.final_score_995	:=	final_score_995	;
			self.final_score_996	:=	final_score_996	;
			self.final_score_997	:=	final_score_997	;
			self.final_score_998	:=	final_score_998	;
			self.final_score_999	:=	final_score_999	;
			self.final_score_1000	:=	final_score_1000	;
			self.final_score_1001	:=	final_score_1001	;
			self.final_score_1002	:=	final_score_1002	;
			self.final_score_1003	:=	final_score_1003	;
			self.final_score_1004	:=	final_score_1004	;
			self.final_score_1005	:=	final_score_1005	;
			self.final_score_1006	:=	final_score_1006	;
			self.final_score_1007	:=	final_score_1007	;
			self.final_score_1008	:=	final_score_1008	;
			self.final_score_1009	:=	final_score_1009	;
			self.gathered_ph		  :=  le.Phone_Shell.Gathered_Phone;
			self.acctno					  :=  le.Phone_Shell.Input_Echo.acctno;
			self.wf8							:=	wf8	;

		#else
			self.phone_shell.Phone_Model_Score		:= (string) wf8;
		#end
			self := le;
	END;

		model := project( clam, doModel(left) )((Integer)phone_shell.Phone_Model_Score >= Score_Threshold); 

		return model;

END;
