import ut, Models, STD;

export PhoneScore_wf8_v2(dataset(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout) clam, Unsigned2 Score_Threshold	= Phone_Shell.Constants.Default_PhoneScore) := FUNCTION

  PHONE_DEBUG := False;

  #if(PHONE_DEBUG)
    layout_debug := record
			Integer sysdate                        ;
			String source_list;
			String source_list_last_seen;
			String source_list_first_seen;
			Integer4 phone_pos_cr                  ;
			Integer4 phone_pos_edaca               ;
			Integer4 phone_pos_edadid              ;
			Integer4 phone_pos_edafa               ;
			Integer4 phone_pos_edafla              ;
			Integer4 phone_pos_edahistory          ;
			Integer4 phone_pos_edala               ;
			Integer4 phone_pos_edalfa              ;
			Integer4 phone_pos_exp                 ;
			Integer4 phone_pos_eqp                 ;
			Integer4 phone_pos_inf                 ;
			Integer4 phone_pos_input               ;
			Integer4 phone_pos_md                  ;
			Integer4 phone_pos_ne                  ;
			Integer4 phone_pos_paw                 ;
			Integer4 phone_pos_pde                 ;
			Integer4 phone_pos_pf                  ;
			Integer4 phone_pos_pffla               ;
			Integer4 phone_pos_pfla                ;
			Integer4 phone_pos_ppca                ;
			Integer4 phone_pos_ppdid               ;
			Integer4 phone_pos_ppfa                ;
			Integer4 phone_pos_ppfla               ;
			Integer4 phone_pos_ppla                ;
			Integer4 phone_pos_pplfa               ;
			Integer4 phone_pos_ppth                ;
			Integer4 phone_pos_rel                 ;
			Integer4 phone_pos_rm                  ;
			Integer4 phone_pos_sp                  ;
			Integer4 phone_pos_sx                  ;
			Integer4 phone_pos_utildid             ;
			Boolean source_cr                      ;
			Boolean source_edaca                   ;
			Boolean source_edadid                  ;
			Boolean source_edafa                   ;
			Boolean source_edafla                  ;
			Boolean source_edahistory              ;
			Boolean source_edala                   ;
			Boolean source_edalfa                  ;
			Boolean source_exp                     ;
			Boolean source_inf                     ;
			Boolean source_input                   ;
			Boolean source_md                      ;
			Boolean source_ne                      ;
			Boolean source_paw                     ;
			Boolean source_pde                     ;
			Boolean source_pf                      ;
			Boolean source_pffla                   ;
			Boolean source_pfla                    ;
			Boolean source_ppca                    ;
			Boolean source_ppdid                   ;
			Boolean source_ppfa                    ;
			Boolean source_ppfla                   ;
			Boolean source_ppla                    ;
			Boolean source_pplfa                   ;
			Boolean source_ppth                    ;
			Boolean source_rel                     ;
			Boolean source_rm                      ;
			Boolean source_sp                      ;
			Boolean source_sx                      ;
			Boolean source_utildid                 ;
			String source_cr_fseen                 ;
			String source_edaca_lseen              ;
			String source_edaca_fseen              ;
			String source_edadid_lseen             ;
			String source_edadid_fseen             ;
			String source_edahistory_lseen         ;
			String source_edahistory_fseen         ;
			String source_inf_lseen                ;
			String source_inf_fseen                ;
			String source_md_fseen                 ;
			String source_paw_lseen                ;
			String source_ppca_lseen               ;
			String source_ppca_fseen               ;
			String source_ppdid_lseen              ;
			String source_ppdid_fseen              ;
			String source_ppfla_lseen              ;
			String source_ppfla_fseen              ;
			String source_ppla_lseen               ;
			String source_ppla_fseen               ;
			String source_ppth_lseen               ;
			String source_ppth_fseen               ;
			String source_rel_fseen                ;
			String source_rm_fseen                 ;
			String source_sp_lseen                 ;
			String source_sp_fseen                 ;
			String source_sx_fseen                 ;
			String source_utildid_fseen            ;
			Integer source_eda_any_clean           ;
			Integer number_of_sources              ;
			Integer source_cr_fseen2               ;
			Integer yr_source_cr_fseen             ;
			Integer mth_source_cr_fseen            ;
			Integer source_edaca_lseen2            ;
			Integer yr_source_edaca_lseen          ;
			Integer mth_source_edaca_lseen         ;
			Integer source_edaca_fseen2            ;
			Integer yr_source_edaca_fseen          ;
			Integer mth_source_edaca_fseen         ;
			Integer source_edadid_lseen2           ;
			Integer yr_source_edadid_lseen         ;
			Integer mth_source_edadid_lseen        ;
			Integer source_edadid_fseen2           ;
			Integer yr_source_edadid_fseen         ;
			Integer mth_source_edadid_fseen        ;
			Integer source_edahistory_lseen2       ;
			Integer yr_source_edahistory_lseen     ;
			Integer mth_source_edahistory_lseen    ;
			Integer source_edahistory_fseen2       ;
			Integer yr_source_edahistory_fseen     ;
			Integer mth_source_edahistory_fseen    ;
			Integer source_inf_lseen2              ;
			Integer yr_source_inf_lseen            ;
			Integer mth_source_inf_lseen           ;
			Integer source_inf_fseen2              ;
			Integer yr_source_inf_fseen            ;
			Integer mth_source_inf_fseen           ;
			Integer source_md_fseen2               ;
			Integer yr_source_md_fseen             ;
			Integer mth_source_md_fseen            ;
			Integer source_paw_lseen2              ;
			Integer yr_source_paw_lseen            ;
			Integer mth_source_paw_lseen           ;
			Integer source_ppca_lseen2             ;
			Integer yr_source_ppca_lseen           ;
			Integer mth_source_ppca_lseen          ;
			Integer source_ppca_fseen2             ;
			Integer yr_source_ppca_fseen           ;
			Integer mth_source_ppca_fseen          ;
			Integer source_ppdid_lseen2            ;
			Integer yr_source_ppdid_lseen          ;
			Integer mth_source_ppdid_lseen         ;
			Integer source_ppdid_fseen2            ;
			Integer yr_source_ppdid_fseen          ;
			Integer mth_source_ppdid_fseen         ;
			Integer source_ppfla_lseen2            ;
			Integer yr_source_ppfla_lseen          ;
			Integer mth_source_ppfla_lseen         ;
			Integer source_ppfla_fseen2            ;
			Integer yr_source_ppfla_fseen          ;
			Integer mth_source_ppfla_fseen         ;
			Integer source_ppla_lseen2             ;
			Integer yr_source_ppla_lseen           ;
			Integer mth_source_ppla_lseen          ;
			Integer source_ppla_fseen2             ;
			Integer yr_source_ppla_fseen           ;
			Integer mth_source_ppla_fseen          ;
			Integer source_ppth_lseen2             ;
			Integer yr_source_ppth_lseen           ;
			Integer mth_source_ppth_lseen          ;
			Integer source_ppth_fseen2             ;
			Integer yr_source_ppth_fseen           ;
			Integer mth_source_ppth_fseen          ;
			Integer source_rel_fseen2              ;
			Integer yr_source_rel_fseen            ;
			Integer mth_source_rel_fseen           ;
			Integer source_rm_fseen2               ;
			Integer yr_source_rm_fseen             ;
			Integer mth_source_rm_fseen            ;
			Integer source_sp_lseen2               ;
			Integer yr_source_sp_lseen             ;
			Integer mth_source_sp_lseen            ;
			Integer source_sp_fseen2               ;
			Integer yr_source_sp_fseen             ;
			Integer mth_source_sp_fseen            ;
			Integer source_sx_fseen2               ;
			Integer yr_source_sx_fseen             ;
			Integer mth_source_sx_fseen            ;
			Integer source_utildid_fseen2          ;
			Integer yr_source_utildid_fseen        ;
			Integer mth_source_utildid_fseen       ;
			Integer eda_dt_first_seen2             ;
			Integer yr_eda_dt_first_seen           ;
			Integer mth_eda_dt_first_seen          ;
			Integer eda_dt_last_seen2              ;
			Integer yr_eda_dt_last_seen            ;
			Integer mth_eda_dt_last_seen           ;
			Integer exp_last_update2               ;
			Integer yr_exp_last_update             ;
			Integer mth_exp_last_update            ;
			Integer internal_ver_first_seen2       ;
			Integer yr_internal_ver_first_seen     ;
			Integer mth_internal_ver_first_seen    ;
			Integer phone_fb_rp_date2              ;
			Integer yr_phone_fb_rp_date            ;
			Integer mth_phone_fb_rp_date           ;
			Integer pp_datefirstseen2              ;
			Integer yr_pp_datefirstseen            ;
			Integer mth_pp_datefirstseen           ;
			Integer pp_datelastseen2               ;
			Integer yr_pp_datelastseen             ;
			Integer mth_pp_datelastseen            ;
			Integer pp_datevendorfirstseen2        ;
			Integer yr_pp_datevendorfirstseen      ;
			Integer mth_pp_datevendorfirstseen     ;
			Integer pp_datevendorlastseen2         ;
			Integer yr_pp_datevendorlastseen       ;
			Integer mth_pp_datevendorlastseen      ;
			Integer pp_date_nonglb_lastseen2       ;
			Integer yr_pp_date_nonglb_lastseen     ;
			Integer mth_pp_date_nonglb_lastseen    ;
			Integer pp_orig_lastseen2              ;
			Integer yr_pp_orig_lastseen            ;
			Integer mth_pp_orig_lastseen           ;
			Integer pp_app_npa_effective_dt2       ;
			Integer yr_pp_app_npa_effective_dt     ;
			Integer mth_pp_app_npa_effective_dt    ;
			Integer pp_app_npa_last_change_dt2     ;
			Integer yr_pp_app_npa_last_change_dt   ;
			Integer mth_pp_app_npa_last_change_dt  ;
			Integer pp_eda_hist_ph_dt2             ;
			Integer yr_pp_eda_hist_ph_dt           ;
			Integer mth_pp_eda_hist_ph_dt          ;
			Integer pp_eda_hist_did_dt2            ;
			Integer yr_pp_eda_hist_did_dt          ;
			Integer mth_pp_eda_hist_did_dt         ;
			Integer pp_eda_hist_nm_addr_dt2        ;
			Integer yr_pp_eda_hist_nm_addr_dt      ;
			Integer mth_pp_eda_hist_nm_addr_dt     ;
			Integer pp_first_build_date2           ;
			Integer yr_pp_first_build_date         ;
			Integer mth_pp_first_build_date        ;
			Boolean _phone_match_code_a            ;
			Boolean _phone_match_code_c            ;
			Boolean _phone_match_code_d            ;
			Boolean _phone_match_code_l            ;
			Boolean _phone_match_code_n            ;
			Boolean _phone_match_code_s            ;
			Boolean _phone_match_code_t            ;
			Boolean _phone_match_code_z            ;
			Integer _pp_rule_disconnected_eda      ;
			Integer _pp_rule_high_vend_conf        ;
			Integer _pp_rule_cellphone_latest      ;
			Integer _pp_rule_med_vend_conf_cell    ;
			Integer _pp_rule_gong_disc             ;
			Integer _pp_rule_consort_disc          ;
			Integer _pp_rule_iq_rpc                ;
			Integer _pp_rule_ins_ver_above         ;
			Integer _pp_rule_f1_ver_above          ;
			Integer _pp_rule_30                    ;
			Integer _pp_src_all_uw                 ;
			Integer _pp_src_all_ib                 ;
			Integer _pp_app_nonpub_targ_lap        ;
			Integer _pp_app_ported_match_7         ;
			Integer _eda_hhid_flag                 ;
			Integer inq_firstseen_n                ;
			Integer inq_lastseen_n                 ;
			Integer inq_adl_firstseen_n            ;
			Integer inq_adl_lastseen_n             ;
			Boolean _internal_ver_match_lexid      ;
			Boolean _internal_ver_match_spouse     ;
			Boolean _internal_ver_match_hhid       ;
			Integer _internal_ver_match_level      ;
			Boolean _inq_adl_ph_industry_flag      ;
			Integer _pp_app_nxx_type               ;
			Integer _phone_disconnected            ;
			Integer _phone_zip_match               ;
			Integer _phone_timezone_match          ;
			Integer _phone_fb_rp_result            ;
			Integer _pp_app_fb_ph_disc             ;
			Integer _pp_app_fb_ph7_did_disc        ;
			Integer _pp_app_fb_ph7_nm_addr_disc    ;
			Integer _phone_fb_result_disc          ;
			Integer _phone_fb_rp_result_disc       ;
			Integer _pp_rule_disc_flag             ;
			Integer _pp_app_fb_disc_flag           ;
			Integer _phone_fb_disc_flag            ;
			Integer pk_disconnect_flag             ;
			Boolean _phone_match_code_lns          ;
			Integer _phone_match_code_tcza         ;
			Integer pk_phone_match_level           ;
			Integer _pp_app_coctype_landline       ;
			Integer _pp_app_coctype_cell           ;
			Integer _phone_switch_type_cell        ;
			Integer _pp_app_nxx_type_cell          ;
			Integer _pp_app_ph_type_cell           ;
			Integer _pp_app_company_type_cell      ;
			Integer _exp_type_cell                 ;
			Integer pk_cell_indicator              ;
			Integer pk_cell_flag                   ;
			Integer _pp_origlistingtype_res        ;
			Integer pk_exp_hit                     ;
			String segment                         ;
			String util_add_input_type_list        ;
			Integer add_input_occupants_1yr        ;
			Integer add_input_turnover_1yr_in      ;
			Integer add_input_turnover_1yr_out     ;
			String util_add_curr_type_list         ;
			Integer add_curr_occupants_1yr         ;
			Integer add_curr_turnover_1yr_out      ;
			Integer add_curr_turnover_1yr_in       ;
			String college_income_level_code       ;
			Integer r_pb_order_freq_d              ;
			Integer f_bus_fname_verd_d             ;
			Integer f_bus_name_nover_i             ;
			Boolean f_adl_util_misc_n              ;
			Integer f_util_adl_count_n             ;
			Boolean f_util_add_input_conv_n        ;
			Boolean f_util_add_input_misc_n        ;
			Boolean f_util_add_curr_conv_n         ;
			Integer f_add_input_mobility_index_n   ;
			Integer f_add_curr_mobility_index_n    ;
			Integer f_inq_count_i                  ;
			Integer f_inq_count24_i                ;
			Integer f_inq_per_ssn_i                ;
			Integer f_inq_addrs_per_ssn_i          ;
			Integer f_inq_per_addr_i               ;
			Integer f_inq_adls_per_addr_i          ;
			Integer f_inq_lnames_per_addr_i        ;
			Integer f_inq_ssns_per_addr_i          ;
			Integer _inq_banko_am_first_seen       ;
			Integer f_mos_inq_banko_am_fseen_d     ;
			Integer _inq_banko_cm_first_seen       ;
			Integer f_mos_inq_banko_cm_fseen_d     ;
			Integer _inq_banko_cm_last_seen        ;
			Integer f_mos_inq_banko_cm_lseen_d     ;
			Integer _inq_banko_om_first_seen       ;
			Integer f_mos_inq_banko_om_fseen_d     ;
			Integer _inq_banko_om_last_seen        ;
			Integer f_mos_inq_banko_om_lseen_d     ;
			Integer f_attr_arrest_recency_d        ;
			Integer f_estimated_income_d           ;
			Integer f_wealth_index_d               ;
			Integer f_college_income_d             ;
			Integer f_rel_count_i                  ;
			Integer f_rel_incomeover25_count_d     ;
			Integer f_rel_incomeover50_count_d     ;
			Integer f_rel_incomeover75_count_d     ;
			Integer f_rel_incomeover100_count_d    ;
			Integer f_rel_homeover50_count_d       ;
			Integer f_rel_homeover100_count_d      ;
			Integer f_rel_homeover200_count_d      ;
			Integer f_rel_homeover300_count_d      ;
			Integer f_rel_homeover500_count_d      ;
			Integer f_rel_ageover20_count_d        ;
			Integer f_rel_ageover30_count_d        ;
			Integer f_rel_ageover40_count_d        ;
			Integer f_rel_educationover8_count_d   ;
			Integer f_rel_educationover12_count_d  ;
			Integer f_crim_rel_under25miles_cnt_i  ;
			Integer f_crim_rel_under100miles_cnt_i ;
			Integer f_crim_rel_under500miles_cnt_i ;
			Integer f_rel_under25miles_cnt_d       ;
			Integer f_rel_under100miles_cnt_d      ;
			Integer f_rel_under500miles_cnt_d      ;
			Integer f_rel_bankrupt_count_i         ;
			Integer f_rel_criminal_count_i         ;
			Integer _acc_last_seen                 ;
			Integer f_mos_acc_lseen_d              ;
			Integer f_idrisktype_i                 ;
			Integer f_idverrisktype_i              ;
			Integer f_sourcerisktype_i             ;
			Integer f_varrisktype_i                ;
			Integer f_vardobcount_i                ;
			Integer f_srchvelocityrisktype_i       ;
			Integer f_srchunvrfdaddrcount_i        ;
			Integer f_srchunvrfdphonecount_i       ;
			Integer f_srchfraudsrchcount_i         ;
			Integer f_srchfraudsrchcountyr_i       ;
			Integer f_assocrisktype_i              ;
			Integer f_assocsuspicousidcount_i      ;
			Integer f_assoccredbureaucount_i       ;
			Integer f_validationrisktype_i         ;
			Integer f_corrrisktype_i               ;
			Integer f_corrssnnamecount_d           ;
			Integer f_corrssnaddrcount_d           ;
			Integer f_corraddrnamecount_d          ;
			Integer f_divrisktype_i                ;
			Integer f_divssnidmsrcurelcount_i      ;
			Integer f_divaddrsuspidcountnew_i      ;
			Integer f_srchssnsrchcount_i           ;
			Integer f_srchaddrsrchcount_i          ;
			Integer f_componentcharrisktype_i      ;
			Integer f_inputaddractivephonelist_d   ;
			Integer f_addrchangeincomediff_d       ;
			Integer f_addrchangevaluediff_d        ;
			Integer f_addrchangecrimediff_i        ;
			Integer f_curraddractivephonelist_d    ;
			Integer f_curraddrmedianincome_d       ;
			Integer f_curraddrmedianvalue_d        ;
			Integer f_curraddrmurderindex_i        ;
			Integer f_curraddrcartheftindex_i      ;
			Integer f_curraddrburglaryindex_i      ;
			Integer f_curraddrcrimeindex_i         ;
			Integer f_prevaddrageoldest_d          ;
			Integer f_prevaddrlenofres_d           ;
			Integer f_prevaddrstatus_i             ;
			Integer f_prevaddrmedianincome_d       ;
			Integer f_prevaddrmedianvalue_d        ;
			Integer f_prevaddrmurderindex_i        ;
			Integer f_prevaddrcartheftindex_i      ;
			Integer f_fp_prevaddrburglaryindex_i   ;
			Integer f_fp_prevaddrcrimeindex_i      ;
			Integer r_has_paw_source_d             ;
			Integer _paw_first_seen                ;
			Integer r_mos_since_paw_fseen_d        ;
			Integer r_paw_active_phone_ct_d        ;
			Real final_score_0    ;
			Real final_score_1    ;
			Real final_score_2    ;
			Real final_score_3    ;
			Real final_score_4    ;
			Real final_score_5    ;
			Real final_score_6    ;
			Real final_score_7    ;
			Real final_score_8    ;
			Real final_score_9    ;
			Real final_score_10   ;
			Real final_score_11   ;
			Real final_score_12   ;
			Real final_score_13   ;
			Real final_score_14   ;
			Real final_score_15   ;
			Real final_score_16   ;
			Real final_score_17   ;
			Real final_score_18   ;
			Real final_score_19   ;
			Real final_score_20   ;
			Real final_score_21   ;
			Real final_score_22   ;
			Real final_score_23   ;
			Real final_score_24   ;
			Real final_score_25   ;
			Real final_score_26   ;
			Real final_score_27   ;
			Real final_score_28   ;
			Real final_score_29   ;
			Real final_score_30   ;
			Real final_score_31   ;
			Real final_score_32   ;
			Real final_score_33   ;
			Real final_score_34   ;
			Real final_score_35   ;
			Real final_score_36   ;
			Real final_score_37   ;
			Real final_score_38   ;
			Real final_score_39   ;
			Real final_score_40   ;
			Real final_score_41   ;
			Real final_score_42   ;
			Real final_score_43   ;
			Real final_score_44   ;
			Real final_score_45   ;
			Real final_score_46   ;
			Real final_score_47   ;
			Real final_score_48   ;
			Real final_score_49   ;
			Real final_score_50   ;
			Real final_score_51   ;
			Real final_score_52   ;
			Real final_score_53   ;
			Real final_score_54   ;
			Real final_score_55   ;
			Real final_score_56   ;
			Real final_score_57   ;
			Real final_score_58   ;
			Real final_score_59   ;
			Real final_score_60   ;
			Real final_score_61   ;
			Real final_score_62   ;
			Real final_score_63   ;
			Real final_score_64   ;
			Real final_score_65   ;
			Real final_score_66   ;
			Real final_score_67   ;
			Real final_score_68   ;
			Real final_score_69   ;
			Real final_score_70   ;
			Real final_score_71   ;
			Real final_score_72   ;
			Real final_score_73   ;
			Real final_score_74   ;
			Real final_score_75   ;
			Real final_score_76   ;
			Real final_score_77   ;
			Real final_score_78   ;
			Real final_score_79   ;
			Real final_score_80   ;
			Real final_score_81   ;
			Real final_score_82   ;
			Real final_score_83   ;
			Real final_score_84   ;
			Real final_score_85   ;
			Real final_score_86   ;
			Real final_score_87   ;
			Real final_score_88   ;
			Real final_score_89   ;
			Real final_score_90   ;
			Real final_score_91   ;
			Real final_score_92   ;
			Real final_score_93   ;
			Real final_score_94   ;
			Real final_score_95   ;
			Real final_score_96   ;
			Real final_score_97   ;
			Real final_score_98   ;
			Real final_score_99   ;
			Real final_score_100  ;
			Real final_score_101  ;
			Real final_score_102  ;
			Real final_score_103  ;
			Real final_score_104  ;
			Real final_score_105  ;
			Real final_score_106  ;
			Real final_score_107  ;
			Real final_score_108  ;
			Real final_score_109  ;
			Real final_score_110  ;
			Real final_score_111  ;
			Real final_score_112  ;
			Real final_score_113  ;
			Real final_score_114  ;
			Real final_score_115  ;
			Real final_score_116  ;
			Real final_score_117  ;
			Real final_score_118  ;
			Real final_score_119  ;
			Real final_score_120  ;
			Real final_score_121  ;
			Real final_score_122  ;
			Real final_score_123  ;
			Real final_score_124  ;
			Real final_score_125  ;
			Real final_score_126  ;
			Real final_score_127  ;
			Real final_score_128  ;
			Real final_score_129  ;
			Real final_score_130  ;
			Real final_score_131  ;
			Real final_score_132  ;
			Real final_score_133  ;
			Real final_score_134  ;
			Real final_score_135  ;
			Real final_score_136  ;
			Real final_score_137  ;
			Real final_score_138  ;
			Real final_score_139  ;
			Real final_score_140  ;
			Real final_score_141  ;
			Real final_score_142  ;
			Real final_score_143  ;
			Real final_score_144  ;
			Real final_score_145  ;
			Real final_score_146  ;
			Real final_score_147  ;
			Real final_score_148  ;
			Real final_score_149  ;
			Real final_score_150  ;
			Real final_score_151  ;
			Real final_score_152  ;
			Real final_score_153  ;
			Real final_score_154  ;
			Real final_score_155  ;
			Real final_score_156  ;
			Real final_score_157  ;
			Real final_score_158  ;
			Real final_score_159  ;
			Real final_score_160  ;
			Real final_score_161  ;
			Real final_score_162  ;
			Real final_score_163  ;
			Real final_score_164  ;
			Real final_score_165  ;
			Real final_score_166  ;
			Real final_score_167  ;
			Real final_score_168  ;
			Real final_score_169  ;
			Real final_score_170  ;
			Real final_score_171  ;
			Real final_score_172  ;
			Real final_score_173  ;
			Real final_score_174  ;
			Real final_score_175  ;
			Real final_score_176  ;
			Real final_score_177  ;
			Real final_score_178  ;
			Real final_score_179  ;
			Real final_score_180  ;
			Real final_score_181  ;
			Real final_score_182  ;
			Real final_score_183  ;
			Real final_score_184  ;
			Real final_score_185  ;
			Real final_score_186  ;
			Real final_score_187  ;
			Real final_score_188  ;
			Real final_score_189  ;
			Real final_score_190  ;
			Real final_score_191  ;
			Real final_score_192  ;
			Real final_score_193  ;
			Real final_score_194  ;
			Real final_score_195  ;
			Real final_score_196  ;
			Real final_score_197  ;
			Real final_score_198  ;
			Real final_score_199  ;
			Real final_score_200  ;
			Real final_score_201  ;
			Real final_score_202  ;
			Real final_score_203  ;
			Real final_score_204  ;
			Real final_score_205  ;
			Real final_score_206  ;
			Real final_score_207  ;
			Real final_score_208  ;
			Real final_score_209  ;
			Real final_score_210  ;
			Real final_score_211  ;
			Real final_score_212  ;
			Real final_score_213  ;
			Real final_score_214  ;
			Real final_score_215  ;
			Real final_score_216  ;
			Real final_score_217  ;
			Real final_score_218  ;
			Real final_score_219  ;
			Real final_score_220  ;
			Real final_score_221  ;
			Real final_score_222  ;
			Real final_score_223  ;
			Real final_score_224  ;
			Real final_score_225  ;
			Real final_score_226  ;
			Real final_score_227  ;
			Real final_score_228  ;
			Real final_score_229  ;
			Real final_score_230  ;
			Real final_score_231  ;
			Real final_score_232  ;
			Real final_score_233  ;
			Real final_score_234  ;
			Real final_score_235  ;
			Real final_score_236  ;
			Real final_score_237  ;
			Real final_score_238  ;
			Real final_score_239  ;
			Real final_score_240  ;
			Real final_score_241  ;
			Real final_score_242  ;
			Real final_score_243  ;
			Real final_score_244  ;
			Real final_score_245  ;
			Real final_score_246  ;
			Real final_score_247  ;
			Real final_score_248  ;
			Real final_score_249  ;
			Real final_score_250  ;
			Real final_score_251  ;
			Real final_score_252  ;
			Real final_score_253  ;
			Real final_score_254  ;
			Real final_score_255  ;
			Real final_score_256  ;
			Real final_score_257  ;
			Real final_score_258  ;
			Real final_score_259  ;
			Real final_score_260  ;
			Real final_score_261  ;
			Real final_score_262  ;
			Real final_score_263  ;
			Real final_score_264  ;
			Real final_score_265  ;
			Real final_score_266  ;
			Real final_score_267  ;
			Real final_score_268  ;
			Real final_score_269  ;
			Real final_score_270  ;
			Real final_score_271  ;
			Real final_score_272  ;
			Real final_score_273  ;
			Real final_score_274  ;
			Real final_score_275  ;
			Real final_score_276  ;
			Real final_score_277  ;
			Real final_score_278  ;
			Real final_score_279  ;
			Real final_score_280  ;
			Real final_score_281  ;
			Real final_score_282  ;
			Real final_score_283  ;
			Real final_score_284  ;
			Real final_score_285  ;
			Real final_score_286  ;
			Real final_score_287  ;
			Real final_score_288  ;
			Real final_score_289  ;
			Real final_score_290  ;
			Real final_score_291  ;
			Real final_score_292  ;
			Real final_score_293  ;
			Real final_score_294  ;
			Real final_score_295  ;
			Real final_score_296  ;
			Real final_score_297  ;
			Real final_score_298  ;
			Real final_score_299  ;
			Real final_score_300  ;
			Real final_score      ;
			Integer points        ;
			Real odds             ;
			Integer base          ;
			Integer phat          ;
			Integer wf8           ;
			
			// Save all of the Phone Shell fields for return
			Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
		Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout doModel( clam le ) := TRANSFORM
  #end

//Start: ECL SAS mapping variables 
	source_list                      := trim(le.Phone_Shell.Sources.Source_List, left, right);
	source_list_last_seen            := trim(le.Phone_Shell.Sources.Source_List_Last_Seen, left, right);
	source_list_first_seen           := trim(le.Phone_Shell.Sources.Source_List_First_Seen, left, right);
	eda_dt_first_seen                := le.Phone_Shell.EDA_Characteristics.EDA_Dt_First_Seen;
	eda_dt_last_seen                 := le.Phone_Shell.EDA_Characteristics.EDA_Dt_Last_Seen;
	exp_last_update                  := le.Phone_Shell.Experian_File_One_Verification.Experian_Last_Update;
	internal_ver_first_seen          := le.Phone_Shell.Internal_Corroboration.Internal_Verification_First_Seen;
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
	pp_eda_hist_nm_addr_dt           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Nm_Addr_Dt;
	pp_first_build_date              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_First_Build_Date;
	phone_match_code                 := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Match_Code;
	pp_rules                         := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Rules;
	pp_src_all                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src_All;
	pp_app_nonpublished_match        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NonPublished_Match;
	pp_app_ported_match              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Ported_Match;
	eda_hhid                         := le.Phone_Shell.EDA_Characteristics.EDA_HHID;
	inq_firstseen                    := le.Phone_Shell.Inquiries.Inq_FirstSeen;
	inq_lastseen                     := le.Phone_Shell.Inquiries.Inq_LastSeen;
	inq_adl_firstseen                := le.Phone_Shell.Inquiries.Inq_ADL_FirstSeen;
	inq_adl_lastseen                 := le.Phone_Shell.Inquiries.Inq_ADL_LastSeen;
	inq_adl_ph_industry_list_12      := le.Phone_Shell.Inquiries.Inq_ADL_Phone_Industry_List_12;
	internal_ver_match_type          := le.Phone_Shell.Internal_Corroboration.Internal_Verification_Match_Types;
	pp_app_nxx_type                  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_NXX_Type;
	phone_disconnected               := (integer)le.Phone_Shell.Raw_Phone_Characteristics.Phone_Disconnected;
	phone_zip_match                  := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Zip_Match;
	phone_timezone_match             := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Timezone_Match;
	phone_fb_rp_result               := le.Phone_Shell.Phone_Feedback.Phone_Feedback_RP_Result;
	pp_app_fb_ph                     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone;
	pp_app_fb_ph7_did                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID;
	pp_app_fb_ph7_nm_addr            := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr;
	phone_fb_result                  := le.Phone_Shell.Phone_Feedback.Phone_Feedback_Result;
	pp_app_coctype                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_COCType;
	pp_app_scc                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_SCC;
	phone_switch_type                := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Switch_Type;
	pp_app_ph_type                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Phone_Type;
	pp_app_company_type              := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Company_Type;
	exp_type                         := le.Phone_Shell.Experian_File_One_Verification.Experian_Type;
	pp_origlistingtype               := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigListingType;
	exp_verified                     := (integer)le.Phone_Shell.Experian_File_One_Verification.Experian_Verified;
	exp_source                       := le.Phone_Shell.Experian_File_One_Verification.Experian_Source;
	exp_ph_score_v1                  := le.Phone_Shell.Experian_File_One_Verification.Experian_Phone_Score_V1;
	phone_subject_title              := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Subject_Title;
	eda_address_match_best           := (integer) le.Phone_Shell.EDA_Characteristics.EDA_Address_Match_Best;
	eda_num_phs_ind                  := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phones_Indiv;
	pp_glb_dppa_fl                   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag;
	pp_source                        := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Source;
	eda_avg_days_connected_ind       := le.Phone_Shell.EDA_Characteristics.EDA_Avg_Days_Connected_Indiv;
	eda_pfrd_address_ind             := le.Phone_Shell.EDA_Characteristics.EDA_Pfrd_Address_Ind;
	pp_app_ind_ph_cnt                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Indiv_Phone_Cnt;
	eda_min_days_connected_ind       := le.Phone_Shell.EDA_Characteristics.EDA_Min_Days_Connected_Indiv;
	pp_did_score                     := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DID_Score;
	pp_src_cnt                       := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src_Cnt;
	pp_origphonetype                 := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneType;
	pp_origphoneusage                := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneUsage;
	pp_did_type                      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DID_Type;
	eda_num_phs_connected_addr       := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phones_Connected_Addr; 
	eda_max_days_interrupt           := le.Phone_Shell.EDA_Characteristics.EDA_Max_Days_Interrupt; 
	pp_src                           := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src;
	inq_num                          := (integer)le.Phone_Shell.Inquiries.Inq_Num;
	eda_days_ph_first_seen           := le.Phone_Shell.EDA_Characteristics.EDA_Days_Phone_First_Seen;
	eda_max_days_connected_ind       := le.Phone_Shell.EDA_Characteristics.EDA_Max_Days_Connected_Indiv;
	eda_days_ind_first_seen          := le.Phone_Shell.EDA_Characteristics.EDA_Days_Indiv_First_Seen;
	inq_num_addresses                := (integer)le.Phone_Shell.Inquiries.Inq_Num_Addresses;
	eda_avg_days_interrupt           := le.Phone_Shell.EDA_Characteristics.EDA_Avg_Days_Interrupt;
	subject_ssn_mismatch             := le.Phone_Shell.Subject_Level.Subject_SSN_Mismatch;
	eda_num_phs_connected_hhid       := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phones_Connected_HHID;
	eda_min_days_interrupt           := le.Phone_Shell.EDA_Characteristics.EDA_Min_Days_Interrupt;
	eda_num_phs_connected_ind        := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phones_Connected_Indiv;
	pp_glb_dppa_all                  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_All;
	eda_has_cur_discon_90_days       := (integer)le.Phone_Shell.EDA_Characteristics.EDA_Has_Cur_Discon_90_Days;
	eda_months_addr_last_seen        := le.Phone_Shell.EDA_Characteristics.EDA_Months_Addr_Last_Seen;
	pp_total_source_conf             := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Total_Source_Conf;
	eda_num_interrupts_cur           := le.Phone_Shell.EDA_Characteristics.EDA_Num_Interrupts_Cur;
	pp_type                          := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Type;
	inq_num_adls                     := (integer)le.Phone_Shell.Inquiries.Inq_Num_ADLs;
	eda_days_in_service              := le.Phone_Shell.EDA_Characteristics.EDA_Days_In_Service;
	internal_verification            := le.Phone_Shell.Internal_Corroboration.Internal_Verification;
	truedid                          := le.Boca_Shell.truedid;
	bus_name_match                   := le.Boca_Shell.business_header_address_summary.bus_name_match;
	addrpop                          := le.Boca_Shell.input_validation.address;
	ssnlength                        := le.Boca_Shell.input_validation.ssn_length;
	util_adl_type_list               := le.Boca_Shell.utility.utili_adl_type;
	util_adl_count                   := le.Boca_Shell.utility.utili_adl_count;
	util_add1_type_list              := le.Boca_Shell.utility.utili_addr1_type;
	util_add2_type_list              := le.Boca_Shell.utility.utili_addr2_type;
	add1_isbestmatch                 := le.Boca_Shell.address_verification.input_address_information.isbestmatch;
	add1_occupants_1yr               := le.Boca_Shell.addr_risk_summary.occupants_1yr;
	add1_turnover_1yr_in             := le.Boca_Shell.addr_risk_summary.turnover_1yr_in;
	add2_occupants_1yr               := le.Boca_Shell.addr_risk_summary2.occupants_1yr;
	add2_turnover_1yr_in             := le.Boca_Shell.addr_risk_summary2.turnover_1yr_in;
	inq_count                        := le.Boca_Shell.acc_logs.inquiries.counttotal;
	inq_count24                      := le.Boca_Shell.acc_logs.inquiries.count24;
	inq_perssn                       := le.Boca_Shell.acc_logs.inquiryperssn;
	inq_addrsperssn                  := le.Boca_Shell.acc_logs.inquiryaddrsperssn;
	inq_peraddr                      := le.Boca_Shell.acc_logs.inquiryperaddr;
	inq_adlsperaddr                  := le.Boca_Shell.acc_logs.inquiryadlsperaddr;
	inq_lnamesperaddr                := le.Boca_Shell.acc_logs.inquirylnamesperaddr;
	inq_ssnsperaddr                  := le.Boca_Shell.acc_logs.inquiryssnsperaddr;
	inq_banko_am_first_seen          := le.Boca_Shell.acc_logs.am_first_seen_date;
	inq_banko_cm_first_seen          := le.Boca_Shell.acc_logs.cm_first_seen_date;
	inq_banko_cm_last_seen           := le.Boca_Shell.acc_logs.cm_last_seen_date;
	inq_banko_om_first_seen          := le.Boca_Shell.acc_logs.om_first_seen_date;
	inq_banko_om_last_seen           := le.Boca_Shell.acc_logs.om_last_seen_date;
	pb_number_of_sources             := le.Boca_Shell.ibehavior.number_of_sources;
	pb_average_days_bt_orders        := le.Boca_Shell.ibehavior.average_days_between_orders;
	paw_first_seen                   := le.Boca_Shell.employment.first_seen_date;
	paw_active_phone_count           := le.Boca_Shell.employment.business_active_phone_ct;
	paw_source_count                 := le.Boca_Shell.employment.source_ct;
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
	fp_srchvelocityrisktype          := le.Boca_Shell.fdattributesv2.searchvelocityrisklevel;
	fp_srchunvrfdaddrcount           := le.Boca_Shell.fdattributesv2.searchunverifiedaddrcountyear;
	fp_srchunvrfdphonecount          := le.Boca_Shell.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcount            := le.Boca_Shell.fdattributesv2.searchfraudsearchcount;
	fp_srchfraudsrchcountyr          := le.Boca_Shell.fdattributesv2.searchfraudsearchcountyear;
	fp_assocrisktype                 := le.Boca_Shell.fdattributesv2.assocrisklevel;
	fp_assocsuspicousidcount         := le.Boca_Shell.fdattributesv2.assocsuspicousidentitiescount;
	fp_assoccredbureaucount          := le.Boca_Shell.fdattributesv2.assoccreditbureauonlycount;
	fp_validationrisktype            := le.Boca_Shell.fdattributesv2.validationrisklevel;
	fp_corrrisktype                  := le.Boca_Shell.fdattributesv2.correlationrisklevel;
	fp_corrssnnamecount              := le.Boca_Shell.fdattributesv2.correlationssnnamecount;
	fp_corrssnaddrcount              := le.Boca_Shell.fdattributesv2.correlationssnaddrcount;
	fp_corraddrnamecount             := le.Boca_Shell.fdattributesv2.correlationaddrnamecount;
	fp_divrisktype                   := le.Boca_Shell.fdattributesv2.divrisklevel;
	fp_divssnidmsrcurelcount         := le.Boca_Shell.fdattributesv2.divssnidentitymsourceurelcount;
	fp_divaddrsuspidcountnew         := le.Boca_Shell.fdattributesv2.divaddrsuspidentitycountnew;
	fp_srchssnsrchcount              := le.Boca_Shell.fdattributesv2.searchssnsearchcount;
	fp_srchaddrsrchcount             := le.Boca_Shell.fdattributesv2.searchaddrsearchcount;
	fp_componentcharrisktype         := le.Boca_Shell.fdattributesv2.componentcharrisklevel;
	fp_inputaddractivephonelist      := le.Boca_Shell.fdattributesv2.inputaddractivephonelist;
	fp_addrchangeincomediff          := le.Boca_Shell.fdattributesv2.addrchangeincomediff;
	fp_addrchangevaluediff           := le.Boca_Shell.fdattributesv2.addrchangevaluediff;
	fp_addrchangecrimediff           := le.Boca_Shell.fdattributesv2.addrchangecrimediff;
	fp_curraddractivephonelist       := le.Boca_Shell.fdattributesv2.curraddractivephonelist;
	fp_curraddrmedianincome          := le.Boca_Shell.fdattributesv2.curraddrmedianincome;
	fp_curraddrmedianvalue           := le.Boca_Shell.fdattributesv2.curraddrmedianvalue;
	fp_curraddrmurderindex           := le.Boca_Shell.fdattributesv2.curraddrmurderindex;
	fp_curraddrcartheftindex         := le.Boca_Shell.fdattributesv2.curraddrcartheftindex;
	fp_curraddrburglaryindex         := le.Boca_Shell.fdattributesv2.curraddrburglaryindex;
	fp_curraddrcrimeindex            := le.Boca_Shell.fdattributesv2.curraddrcrimeindex;
	fp_prevaddrageoldest             := le.Boca_Shell.fdattributesv2.prevaddrageoldest;
	fp_prevaddrlenofres              := le.Boca_Shell.fdattributesv2.prevaddrlenofres;
	fp_prevaddrstatus                := le.Boca_Shell.fdattributesv2.prevaddrstatus;
	fp_prevaddrmedianincome          := le.Boca_Shell.fdattributesv2.prevaddrmedianincome;
	fp_prevaddrmedianvalue           := le.Boca_Shell.fdattributesv2.prevaddrmedianvalue;
	fp_prevaddrmurderindex           := le.Boca_Shell.fdattributesv2.prevaddrmurderindex;
	fp_prevaddrcartheftindex         := le.Boca_Shell.fdattributesv2.prevaddrcartheftindex;
	fp_prevaddrburglaryindex         := le.Boca_Shell.fdattributesv2.prevaddrburglaryindex;
	fp_prevaddrcrimeindex            := le.Boca_Shell.fdattributesv2.prevaddrcrimeindex;
	rel_count                        := le.Boca_Shell.relatives.relative_count;
	rel_bankrupt_count               := le.Boca_Shell.relatives.relative_bankrupt_count;
	rel_criminal_count               := le.Boca_Shell.relatives.relative_criminal_count;
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
	acc_last_seen                    := le.Boca_Shell.accident_data.acc.datelastaccident;
	ams_income_level_code            := le.Boca_Shell.student.income_level_code;
	wealth_index                     := le.Boca_Shell.wealth_indicator;
	estimated_income                 := le.Boca_Shell.estimated_income;

//End: ECL SAS mapping variables 

NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := Models.common.sas_date(if(le.Boca_Shell.historydate=999999, (string)STD.Date.Today(), (string6)le.Boca_Shell.historydate+'01'));

phone_pos_cr := Models.Common.findw_cpp(source_list, 'CR' , ',', 'E');

phone_pos_edaca := Models.Common.findw_cpp(source_list, 'EDACA' , ',', 'E');

phone_pos_edadid := Models.Common.findw_cpp(source_list, 'EDADID' , ',', 'E');

phone_pos_edafa := Models.Common.findw_cpp(source_list, 'EDAFA' , ',', 'E');

phone_pos_edafla := Models.Common.findw_cpp(source_list, 'EDAFLA' , ',', 'E');

phone_pos_edahistory := Models.Common.findw_cpp(source_list, 'EDAHistory' , ',', 'E');

phone_pos_edala := Models.Common.findw_cpp(source_list, 'EDALA' , ',', 'E');

phone_pos_edalfa := Models.Common.findw_cpp(source_list, 'EDALFA' , ',', 'E');

phone_pos_exp := Models.Common.findw_cpp(source_list, 'EXP' , ',', 'E');

phone_pos_eqp := Models.Common.findw_cpp(source_list, 'EQP' , ',', 'E');

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

source_exp := phone_pos_exp > 0 or phone_pos_eqp > 0;

source_inf := phone_pos_inf > 0;

source_input := phone_pos_input > 0;

source_md := phone_pos_md > 0;

source_ne := phone_pos_ne > 0;

source_paw := phone_pos_paw > 0;

source_pde := phone_pos_pde > 0;

source_pf := phone_pos_pf > 0;

source_pffla := phone_pos_pffla > 0;

source_pfla := phone_pos_pfla > 0;

source_ppca := phone_pos_ppca > 0;

source_ppdid := phone_pos_ppdid > 0;

source_ppfa := phone_pos_ppfa > 0;

source_ppfla := phone_pos_ppfla > 0;

source_ppla := phone_pos_ppla > 0;

source_pplfa := phone_pos_pplfa > 0;

source_ppth := phone_pos_ppth > 0;

source_rel := phone_pos_rel > 0;

source_rm := phone_pos_rm > 0;

source_sp := phone_pos_sp > 0;

source_sx := phone_pos_sx > 0;

source_utildid := phone_pos_utildid > 0;

source_cr_fseen := Models.Common.getw(source_list_first_seen, phone_pos_cr);

source_edaca_lseen := Models.Common.getw(source_list_last_seen, phone_pos_edaca);

source_edaca_fseen := Models.Common.getw(source_list_first_seen, phone_pos_edaca);

source_edadid_lseen := Models.Common.getw(source_list_last_seen, phone_pos_edadid);

source_edadid_fseen := Models.Common.getw(source_list_first_seen, phone_pos_edadid);

source_edahistory_lseen := Models.Common.getw(source_list_last_seen, phone_pos_edahistory);

source_edahistory_fseen := Models.Common.getw(source_list_first_seen, phone_pos_edahistory);

source_inf_lseen := Models.Common.getw(source_list_last_seen, phone_pos_inf);

source_inf_fseen := Models.Common.getw(source_list_first_seen, phone_pos_inf);

source_md_fseen := Models.Common.getw(source_list_first_seen, phone_pos_md);

source_paw_lseen := Models.Common.getw(source_list_last_seen, phone_pos_paw);

source_ppca_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppca);

source_ppca_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppca);

source_ppdid_lseen := Models.Common.getw(source_list_last_seen, phone_pos_ppdid);

source_ppdid_fseen := Models.Common.getw(source_list_first_seen, phone_pos_ppdid);

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

number_of_sources := if(max((integer)source_cr, (integer)source_edaca, (integer)source_edadid, (integer)source_edafa, (integer)source_edafla, (integer)source_edahistory, (integer)source_edala, (integer)source_edalfa, (integer)source_exp, (integer)source_inf, (integer)source_input, (integer)source_md, (integer)source_ne, (integer)source_paw, (integer)source_pde, (integer)source_pf, (integer)source_pffla, (integer)source_pfla, (integer)source_ppca, (integer)source_ppdid, (integer)source_ppfa, (integer)source_ppfla, (integer)source_ppla, (integer)source_pplfa, (integer)source_ppth, (integer)source_rel, (integer)source_rm, (integer)source_sp, (integer)source_sx, (integer)source_utildid) = NULL, NULL, sum((integer)source_cr, (integer)source_edaca, (integer)source_edadid, (integer)source_edafa, (integer)source_edafla, (integer)source_edahistory, (integer)source_edala, (integer)source_edalfa, (integer)source_exp, (integer)source_inf, (integer)source_input, (integer)source_md, (integer)source_ne, (integer)source_paw, (integer)source_pde, (integer)source_pf, (integer)source_pffla, (integer)source_pfla, (integer)source_ppca, (integer)source_ppdid, (integer)source_ppfa, (integer)source_ppfla, (integer)source_ppla, (integer)source_pplfa, (integer)source_ppth, (integer)source_rel, (integer)source_rm, (integer)source_sp, (integer)source_sx, (integer)source_utildid));

source_cr_fseen2 := Models.common.sas_date((string)(source_cr_fseen));

yr_source_cr_fseen := if(min(sysdate, source_cr_fseen2) = NULL, NULL, (sysdate - source_cr_fseen2) / 365.25);

mth_source_cr_fseen := if(min(sysdate, source_cr_fseen2) = NULL, NULL, ROUNDUP((sysdate - source_cr_fseen2) / 30.5));

source_edaca_lseen2 := Models.common.sas_date((string)(source_edaca_lseen));

yr_source_edaca_lseen := if(min(sysdate, source_edaca_lseen2) = NULL, NULL, (sysdate - source_edaca_lseen2) / 365.25);

mth_source_edaca_lseen := if(min(sysdate, source_edaca_lseen2) = NULL, NULL, ROUNDUP((sysdate - source_edaca_lseen2) / 30.5));

source_edaca_fseen2 := Models.common.sas_date((string)(source_edaca_fseen));

yr_source_edaca_fseen := if(min(sysdate, source_edaca_fseen2) = NULL, NULL, (sysdate - source_edaca_fseen2) / 365.25);

mth_source_edaca_fseen := if(min(sysdate, source_edaca_fseen2) = NULL, NULL, ROUNDUP((sysdate - source_edaca_fseen2) / 30.5));

source_edadid_lseen2 := Models.common.sas_date((string)(source_edadid_lseen));

yr_source_edadid_lseen := if(min(sysdate, source_edadid_lseen2) = NULL, NULL, (sysdate - source_edadid_lseen2) / 365.25);

mth_source_edadid_lseen := if(min(sysdate, source_edadid_lseen2) = NULL, NULL, ROUNDUP((sysdate - source_edadid_lseen2) / 30.5));

source_edadid_fseen2 := Models.common.sas_date((string)(source_edadid_fseen));

yr_source_edadid_fseen := if(min(sysdate, source_edadid_fseen2) = NULL, NULL, (sysdate - source_edadid_fseen2) / 365.25);

mth_source_edadid_fseen := if(min(sysdate, source_edadid_fseen2) = NULL, NULL, ROUNDUP((sysdate - source_edadid_fseen2) / 30.5));

source_edahistory_lseen2 := Models.common.sas_date((string)(source_edahistory_lseen));

yr_source_edahistory_lseen := if(min(sysdate, source_edahistory_lseen2) = NULL, NULL, (sysdate - source_edahistory_lseen2) / 365.25);

mth_source_edahistory_lseen := if(min(sysdate, source_edahistory_lseen2) = NULL, NULL, ROUNDUP((sysdate - source_edahistory_lseen2) / 30.5));

source_edahistory_fseen2 := Models.common.sas_date((string)(source_edahistory_fseen));

yr_source_edahistory_fseen := if(min(sysdate, source_edahistory_fseen2) = NULL, NULL, (sysdate - source_edahistory_fseen2) / 365.25);

mth_source_edahistory_fseen := if(min(sysdate, source_edahistory_fseen2) = NULL, NULL, ROUNDUP((sysdate - source_edahistory_fseen2) / 30.5));

source_inf_lseen2 := Models.common.sas_date((string)(source_inf_lseen));

yr_source_inf_lseen := if(min(sysdate, source_inf_lseen2) = NULL, NULL, (sysdate - source_inf_lseen2) / 365.25);

mth_source_inf_lseen := if(min(sysdate, source_inf_lseen2) = NULL, NULL, ROUNDUP((sysdate - source_inf_lseen2) / 30.5));

source_inf_fseen2 := Models.common.sas_date((string)(source_inf_fseen));

yr_source_inf_fseen := if(min(sysdate, source_inf_fseen2) = NULL, NULL, (sysdate - source_inf_fseen2) / 365.25);

mth_source_inf_fseen := if(min(sysdate, source_inf_fseen2) = NULL, NULL, ROUNDUP((sysdate - source_inf_fseen2) / 30.5));

source_md_fseen2 := Models.common.sas_date((string)(source_md_fseen));

yr_source_md_fseen := if(min(sysdate, source_md_fseen2) = NULL, NULL, (sysdate - source_md_fseen2) / 365.25);

mth_source_md_fseen := if(min(sysdate, source_md_fseen2) = NULL, NULL, ROUNDUP((sysdate - source_md_fseen2) / 30.5));

source_paw_lseen2 := Models.common.sas_date((string)(source_paw_lseen));

yr_source_paw_lseen := if(min(sysdate, source_paw_lseen2) = NULL, NULL, (sysdate - source_paw_lseen2) / 365.25);

mth_source_paw_lseen := if(min(sysdate, source_paw_lseen2) = NULL, NULL, ROUNDUP((sysdate - source_paw_lseen2) / 30.5));

source_ppca_lseen2 := Models.common.sas_date((string)(source_ppca_lseen));

yr_source_ppca_lseen := if(min(sysdate, source_ppca_lseen2) = NULL, NULL, (sysdate - source_ppca_lseen2) / 365.25);

mth_source_ppca_lseen := if(min(sysdate, source_ppca_lseen2) = NULL, NULL, ROUNDUP((sysdate - source_ppca_lseen2) / 30.5));

source_ppca_fseen2 := Models.common.sas_date((string)(source_ppca_fseen));

yr_source_ppca_fseen := if(min(sysdate, source_ppca_fseen2) = NULL, NULL, (sysdate - source_ppca_fseen2) / 365.25);

mth_source_ppca_fseen := if(min(sysdate, source_ppca_fseen2) = NULL, NULL, ROUNDUP((sysdate - source_ppca_fseen2) / 30.5));

source_ppdid_lseen2 := Models.common.sas_date((string)(source_ppdid_lseen));

yr_source_ppdid_lseen := if(min(sysdate, source_ppdid_lseen2) = NULL, NULL, (sysdate - source_ppdid_lseen2) / 365.25);

mth_source_ppdid_lseen := if(min(sysdate, source_ppdid_lseen2) = NULL, NULL, ROUNDUP((sysdate - source_ppdid_lseen2) / 30.5));

source_ppdid_fseen2 := Models.common.sas_date((string)(source_ppdid_fseen));

yr_source_ppdid_fseen := if(min(sysdate, source_ppdid_fseen2) = NULL, NULL, (sysdate - source_ppdid_fseen2) / 365.25);

mth_source_ppdid_fseen := if(min(sysdate, source_ppdid_fseen2) = NULL, NULL, ROUNDUP((sysdate - source_ppdid_fseen2) / 30.5));

source_ppfla_lseen2 := Models.common.sas_date((string)(source_ppfla_lseen));

yr_source_ppfla_lseen := if(min(sysdate, source_ppfla_lseen2) = NULL, NULL, (sysdate - source_ppfla_lseen2) / 365.25);

mth_source_ppfla_lseen := if(min(sysdate, source_ppfla_lseen2) = NULL, NULL, ROUNDUP((sysdate - source_ppfla_lseen2) / 30.5));

source_ppfla_fseen2 := Models.common.sas_date((string)(source_ppfla_fseen));

yr_source_ppfla_fseen := if(min(sysdate, source_ppfla_fseen2) = NULL, NULL, (sysdate - source_ppfla_fseen2) / 365.25);

mth_source_ppfla_fseen := if(min(sysdate, source_ppfla_fseen2) = NULL, NULL, ROUNDUP((sysdate - source_ppfla_fseen2) / 30.5));

source_ppla_lseen2 := Models.common.sas_date((string)(source_ppla_lseen));

yr_source_ppla_lseen := if(min(sysdate, source_ppla_lseen2) = NULL, NULL, (sysdate - source_ppla_lseen2) / 365.25);

mth_source_ppla_lseen := if(min(sysdate, source_ppla_lseen2) = NULL, NULL, ROUNDUP((sysdate - source_ppla_lseen2) / 30.5));

source_ppla_fseen2 := Models.common.sas_date((string)(source_ppla_fseen));

yr_source_ppla_fseen := if(min(sysdate, source_ppla_fseen2) = NULL, NULL, (sysdate - source_ppla_fseen2) / 365.25);

mth_source_ppla_fseen := if(min(sysdate, source_ppla_fseen2) = NULL, NULL, ROUNDUP((sysdate - source_ppla_fseen2) / 30.5));

source_ppth_lseen2 := Models.common.sas_date((string)(source_ppth_lseen));

yr_source_ppth_lseen := if(min(sysdate, source_ppth_lseen2) = NULL, NULL, (sysdate - source_ppth_lseen2) / 365.25);

mth_source_ppth_lseen := if(min(sysdate, source_ppth_lseen2) = NULL, NULL, ROUNDUP((sysdate - source_ppth_lseen2) / 30.5));

source_ppth_fseen2 := Models.common.sas_date((string)(source_ppth_fseen));

yr_source_ppth_fseen := if(min(sysdate, source_ppth_fseen2) = NULL, NULL, (sysdate - source_ppth_fseen2) / 365.25);

mth_source_ppth_fseen := if(min(sysdate, source_ppth_fseen2) = NULL, NULL, ROUNDUP((sysdate - source_ppth_fseen2) / 30.5));

source_rel_fseen2 := Models.common.sas_date((string)(source_rel_fseen));

yr_source_rel_fseen := if(min(sysdate, source_rel_fseen2) = NULL, NULL, (sysdate - source_rel_fseen2) / 365.25);

mth_source_rel_fseen := if(min(sysdate, source_rel_fseen2) = NULL, NULL, ROUNDUP((sysdate - source_rel_fseen2) / 30.5));

source_rm_fseen2 := Models.common.sas_date((string)(source_rm_fseen));

yr_source_rm_fseen := if(min(sysdate, source_rm_fseen2) = NULL, NULL, (sysdate - source_rm_fseen2) / 365.25);

mth_source_rm_fseen := if(min(sysdate, source_rm_fseen2) = NULL, NULL, ROUNDUP((sysdate - source_rm_fseen2) / 30.5));

source_sp_lseen2 := Models.common.sas_date((string)(source_sp_lseen));

yr_source_sp_lseen := if(min(sysdate, source_sp_lseen2) = NULL, NULL, (sysdate - source_sp_lseen2) / 365.25);

mth_source_sp_lseen := if(min(sysdate, source_sp_lseen2) = NULL, NULL, ROUNDUP((sysdate - source_sp_lseen2) / 30.5));

source_sp_fseen2 := Models.common.sas_date((string)(source_sp_fseen));

yr_source_sp_fseen := if(min(sysdate, source_sp_fseen2) = NULL, NULL, (sysdate - source_sp_fseen2) / 365.25);

mth_source_sp_fseen := if(min(sysdate, source_sp_fseen2) = NULL, NULL, ROUNDUP((sysdate - source_sp_fseen2) / 30.5));

source_sx_fseen2 := Models.common.sas_date((string)(source_sx_fseen));

yr_source_sx_fseen := if(min(sysdate, source_sx_fseen2) = NULL, NULL, (sysdate - source_sx_fseen2) / 365.25);

mth_source_sx_fseen := if(min(sysdate, source_sx_fseen2) = NULL, NULL, ROUNDUP((sysdate - source_sx_fseen2) / 30.5));

source_utildid_fseen2 := Models.common.sas_date((string)(source_utildid_fseen));

yr_source_utildid_fseen := if(min(sysdate, source_utildid_fseen2) = NULL, NULL, (sysdate - source_utildid_fseen2) / 365.25);

mth_source_utildid_fseen := if(min(sysdate, source_utildid_fseen2) = NULL, NULL, ROUNDUP((sysdate - source_utildid_fseen2) / 30.5));

eda_dt_first_seen2 := Models.common.sas_date((string)(eda_dt_first_seen));

yr_eda_dt_first_seen := if(min(sysdate, eda_dt_first_seen2) = NULL, NULL, (sysdate - eda_dt_first_seen2) / 365.25);

mth_eda_dt_first_seen := if(min(sysdate, eda_dt_first_seen2) = NULL, NULL, ROUNDUP((sysdate - eda_dt_first_seen2) / 30.5));

eda_dt_last_seen2 := Models.common.sas_date((string)(eda_dt_last_seen));

yr_eda_dt_last_seen := if(min(sysdate, eda_dt_last_seen2) = NULL, NULL, (sysdate - eda_dt_last_seen2) / 365.25);

mth_eda_dt_last_seen := if(min(sysdate, eda_dt_last_seen2) = NULL, NULL, ROUNDUP((sysdate - eda_dt_last_seen2) / 30.5));

exp_last_update2 := Models.common.sas_date((string)(exp_last_update));

yr_exp_last_update := if(min(sysdate, exp_last_update2) = NULL, NULL, (sysdate - exp_last_update2) / 365.25);

mth_exp_last_update := if(min(sysdate, exp_last_update2) = NULL, NULL, ROUNDUP((sysdate - exp_last_update2) / 30.5));

internal_ver_first_seen2 := Models.common.sas_date((string)(internal_ver_first_seen));

yr_internal_ver_first_seen := if(min(sysdate, internal_ver_first_seen2) = NULL, NULL, (sysdate - internal_ver_first_seen2) / 365.25);

mth_internal_ver_first_seen := if(min(sysdate, internal_ver_first_seen2) = NULL, NULL, ROUNDUP((sysdate - internal_ver_first_seen2) / 30.5));

phone_fb_rp_date2 := Models.common.sas_date((string)(phone_fb_rp_date));

yr_phone_fb_rp_date := if(min(sysdate, phone_fb_rp_date2) = NULL, NULL, (sysdate - phone_fb_rp_date2) / 365.25);

mth_phone_fb_rp_date := if(min(sysdate, phone_fb_rp_date2) = NULL, NULL, ROUNDUP((sysdate - phone_fb_rp_date2) / 30.5));

pp_datefirstseen2 := Models.common.sas_date((string)(pp_datefirstseen));

yr_pp_datefirstseen := if(min(sysdate, pp_datefirstseen2) = NULL, NULL, (sysdate - pp_datefirstseen2) / 365.25);

mth_pp_datefirstseen := if(min(sysdate, pp_datefirstseen2) = NULL, NULL, ROUNDUP((sysdate - pp_datefirstseen2) / 30.5));

pp_datelastseen2 := Models.common.sas_date((string)(pp_datelastseen));

yr_pp_datelastseen := if(min(sysdate, pp_datelastseen2) = NULL, NULL, (sysdate - pp_datelastseen2) / 365.25);

mth_pp_datelastseen := if(min(sysdate, pp_datelastseen2) = NULL, NULL, ROUNDUP((sysdate - pp_datelastseen2) / 30.5));

pp_datevendorfirstseen2 := Models.common.sas_date((string)(pp_datevendorfirstseen));

yr_pp_datevendorfirstseen := if(min(sysdate, pp_datevendorfirstseen2) = NULL, NULL, (sysdate - pp_datevendorfirstseen2) / 365.25);

mth_pp_datevendorfirstseen := if(min(sysdate, pp_datevendorfirstseen2) = NULL, NULL, ROUNDUP((sysdate - pp_datevendorfirstseen2) / 30.5));

pp_datevendorlastseen2 := Models.common.sas_date((string)(pp_datevendorlastseen));

yr_pp_datevendorlastseen := if(min(sysdate, pp_datevendorlastseen2) = NULL, NULL, (sysdate - pp_datevendorlastseen2) / 365.25);

mth_pp_datevendorlastseen := if(min(sysdate, pp_datevendorlastseen2) = NULL, NULL, ROUNDUP((sysdate - pp_datevendorlastseen2) / 30.5));

pp_date_nonglb_lastseen2 := Models.common.sas_date((string)(pp_date_nonglb_lastseen));

yr_pp_date_nonglb_lastseen := if(min(sysdate, pp_date_nonglb_lastseen2) = NULL, NULL, (sysdate - pp_date_nonglb_lastseen2) / 365.25);

mth_pp_date_nonglb_lastseen := if(min(sysdate, pp_date_nonglb_lastseen2) = NULL, NULL, ROUNDUP((sysdate - pp_date_nonglb_lastseen2) / 30.5));

pp_orig_lastseen2 := Models.common.sas_date((string)(pp_orig_lastseen));

yr_pp_orig_lastseen := if(min(sysdate, pp_orig_lastseen2) = NULL, NULL, (sysdate - pp_orig_lastseen2) / 365.25);

mth_pp_orig_lastseen := if(min(sysdate, pp_orig_lastseen2) = NULL, NULL, ROUNDUP((sysdate - pp_orig_lastseen2) / 30.5));

pp_app_npa_effective_dt2 := Models.common.sas_date((string)(pp_app_npa_effective_dt));

yr_pp_app_npa_effective_dt := if(min(sysdate, pp_app_npa_effective_dt2) = NULL, NULL, (sysdate - pp_app_npa_effective_dt2) / 365.25);

mth_pp_app_npa_effective_dt := if(min(sysdate, pp_app_npa_effective_dt2) = NULL, NULL, ROUNDUP((sysdate - pp_app_npa_effective_dt2) / 30.5));

pp_app_npa_last_change_dt2 := Models.common.sas_date((string)(pp_app_npa_last_change_dt));

yr_pp_app_npa_last_change_dt := if(min(sysdate, pp_app_npa_last_change_dt2) = NULL, NULL, (sysdate - pp_app_npa_last_change_dt2) / 365.25);

mth_pp_app_npa_last_change_dt := if(min(sysdate, pp_app_npa_last_change_dt2) = NULL, NULL, ROUNDUP((sysdate - pp_app_npa_last_change_dt2) / 30.5));

pp_eda_hist_ph_dt2 := Models.common.sas_date((string)(PP_EDA_Hist_ph_dt));

yr_pp_eda_hist_ph_dt := if(min(sysdate, pp_eda_hist_ph_dt2) = NULL, NULL, (sysdate - pp_eda_hist_ph_dt2) / 365.25);

mth_pp_eda_hist_ph_dt := if(min(sysdate, pp_eda_hist_ph_dt2) = NULL, NULL, ROUNDUP((sysdate - pp_eda_hist_ph_dt2) / 30.5));

pp_eda_hist_did_dt2 := Models.common.sas_date((string)(PP_EDA_Hist_did_dt));

yr_pp_eda_hist_did_dt := if(min(sysdate, pp_eda_hist_did_dt2) = NULL, NULL, (sysdate - pp_eda_hist_did_dt2) / 365.25);

mth_pp_eda_hist_did_dt := if(min(sysdate, pp_eda_hist_did_dt2) = NULL, NULL, ROUNDUP((sysdate - pp_eda_hist_did_dt2) / 30.5));

pp_eda_hist_nm_addr_dt2 := Models.common.sas_date((string)(PP_EDA_Hist_nm_addr_dt));

yr_pp_eda_hist_nm_addr_dt := if(min(sysdate, pp_eda_hist_nm_addr_dt2) = NULL, NULL, (sysdate - pp_eda_hist_nm_addr_dt2) / 365.25);

mth_pp_eda_hist_nm_addr_dt := if(min(sysdate, pp_eda_hist_nm_addr_dt2) = NULL, NULL, ROUNDUP((sysdate - pp_eda_hist_nm_addr_dt2) / 30.5));

pp_first_build_date2 := Models.common.sas_date((string)(pp_first_build_date));

yr_pp_first_build_date := if(min(sysdate, pp_first_build_date2) = NULL, NULL, (sysdate - pp_first_build_date2) / 365.25);

mth_pp_first_build_date := if(min(sysdate, pp_first_build_date2) = NULL, NULL, ROUNDUP((sysdate - pp_first_build_date2) / 30.5));

_phone_match_code_a := (Integer)(indexw(trim((string)phone_match_code, ALL), 'A', ',')) > 0;

_phone_match_code_c := (Integer)(indexw(trim((string)phone_match_code, ALL), 'C', ',')) > 0;

_phone_match_code_d := (Integer)(indexw(trim((string)phone_match_code, ALL), 'D', ',')) > 0;

_phone_match_code_l := (Integer)(indexw(trim((string)phone_match_code, ALL), 'L', ',')) > 0;

_phone_match_code_n := (Integer)(indexw(trim((string)phone_match_code, ALL), 'N', ',')) > 0;

_phone_match_code_s := (Integer)(indexw(trim((string)phone_match_code, ALL), 'S', ',')) > 0;

_phone_match_code_t := (Integer)(indexw(trim((string)phone_match_code, ALL), 'T', ',')) > 0;

_phone_match_code_z := (Integer)(indexw(trim((string)phone_match_code, ALL), 'Z', ',')) > 0;

_pp_rule_disconnected_eda_1 := 0;

_pp_rule_high_vend_conf_1 := 0;

_pp_rule_cellphone_latest_1 := 0;

_pp_rule_med_vend_conf_cell_1 := 0;

_pp_rule_gong_disc_1 := 0;

_pp_rule_consort_disc_1 := 0;

_pp_rule_iq_rpc_1 := 0;

_pp_rule_ins_ver_above_1 := 0;

_pp_rule_f1_ver_above_1 := 0;

_pp_rule_30_1 := 0;

_pp_rule_disconnected_eda := if((Integer)((string)PP_Rules)[3..3] = 1, 1, _pp_rule_disconnected_eda_1);

_pp_rule_high_vend_conf := if((Integer)((string)PP_Rules)[7..7] = 1, 1, _pp_rule_high_vend_conf_1);

_pp_rule_cellphone_latest := if((Integer)((string)PP_Rules)[9..9] = 1, 1, _pp_rule_cellphone_latest_1);

_pp_rule_med_vend_conf_cell := if((Integer)((string)PP_Rules)[15..15] = 1, 1, _pp_rule_med_vend_conf_cell_1);

_pp_rule_gong_disc := if((Integer)((string)PP_Rules)[21..21] = 1, 1, _pp_rule_gong_disc_1);

_pp_rule_consort_disc := if((Integer)((string)PP_Rules)[22..22] = 1, 1, _pp_rule_consort_disc_1);

_pp_rule_iq_rpc := if((Integer)((string)PP_Rules)[25..25] = 1, 1, _pp_rule_iq_rpc_1);

_pp_rule_ins_ver_above := if((Integer)((string)PP_Rules)[26..26] = 1, 1, _pp_rule_ins_ver_above_1);

_pp_rule_f1_ver_above := if((Integer)((string)PP_Rules)[28..28] = 1, 1, _pp_rule_f1_ver_above_1);

_pp_rule_30 := if((Integer)((string)PP_Rules)[30..30] = 1, 1, _pp_rule_30_1);

_pp_src_all_uw := if((Integer)((string)PP_Src_All)[14..14] = 1, 1, 0);

_pp_src_all_ib := if((Integer)((string)PP_Src_All)[44..44] = 1, 1, 0);

_pp_app_nonpub_targ_lap := if((Integer)((string)PP_app_NonPublished_Match)[6..6] = 1, 1, 0);

_pp_app_ported_match_7 := if((Integer)((string)PP_app_Ported_Match)[2..2] = 1, 1, 0);

_eda_hhid_flag := if(eda_hhid > 0, 1, 0);

inq_firstseen_n := if(inq_firstseen = '', NULL, (Integer)inq_firstseen);

inq_lastseen_n := if(inq_lastseen = '', NULL, (Integer)inq_lastseen);

inq_adl_firstseen_n := if(inq_adl_firstseen = '', NULL, (Integer)inq_adl_firstseen);

inq_adl_lastseen_n := if(inq_adl_lastseen = '', NULL, (Integer)inq_adl_lastseen);

_internal_ver_match_lexid := (Integer)indexw(trim((string)internal_ver_match_type, ALL), '1', ',') > 0;

_internal_ver_match_spouse := (Integer)indexw(trim((string)internal_ver_match_type, ALL), '2', ',') > 0;

_internal_ver_match_hhid := (Integer)indexw(trim((string)internal_ver_match_type, ALL), '3', ',') > 0;

_internal_ver_match_level := map(
    (Integer)_internal_ver_match_lexid = 1 and (Integer)_internal_ver_match_spouse = 1 => 3,
    (Integer)_internal_ver_match_lexid = 1 and (Integer)_internal_ver_match_hhid = 0   => 2,
    (Integer)_internal_ver_match_lexid = 1                                             => 1,
                                                                                          0);

_inq_adl_ph_industry_flag := trim(StringLib.StringFilterOut((string)inq_adl_ph_industry_list_12, ','), LEFT, RIGHT) != '';

_pp_app_nxx_type := map(
    (Integer)pp_app_nxx_type < 1  => 0,
    (Integer)pp_app_nxx_type < 2  => 1,
    (Integer)pp_app_nxx_type < 4  => 2,
    (Integer)pp_app_nxx_type < 18 => 3,
    (Integer)pp_app_nxx_type < 50 => 4,
    (Integer)pp_app_nxx_type < 51 => 5,
    (Integer)pp_app_nxx_type < 52 => 6,
    (Integer)pp_app_nxx_type < 53 => 7,
    (Integer)pp_app_nxx_type < 54 => 8,
    (Integer)pp_app_nxx_type < 55 => 9,
    (Integer)pp_app_nxx_type < 60 => 10,
    (Integer)pp_app_nxx_type < 65 => 11,
    (Integer)pp_app_nxx_type < 66 => 12,
    (Integer)pp_app_nxx_type < 77 => 13,
                                     14);

_phone_disconnected := if(phone_disconnected < 1, 0, 1);

_phone_zip_match := if(phone_zip_match < 1, 0, 1);

_phone_timezone_match := if(phone_timezone_match < 1, 0, 1);

_phone_fb_rp_result := map(
    phone_fb_rp_result < 3 => 0,
    phone_fb_rp_result < 9 => 1,
                              2);

_pp_app_fb_ph_disc := if(PP_app_fb_ph = 4, 1, 0);

_pp_app_fb_ph7_did_disc := if(PP_app_fb_ph7_DID = 4, 1, 0);

_pp_app_fb_ph7_nm_addr_disc := if(PP_app_fb_ph7_NM_Addr = 4, 1, 0);

_phone_fb_result_disc := if(Phone_fb_Result = 4, 1, 0);

_phone_fb_rp_result_disc := if(Phone_fb_RP_Result = 4, 1, 0);

_pp_rule_disc_flag := if(if(max(_pp_rule_disconnected_eda, _pp_rule_gong_disc, _pp_rule_consort_disc) = NULL, NULL, sum(if(_pp_rule_disconnected_eda = NULL, 0, _pp_rule_disconnected_eda), if(_pp_rule_gong_disc = NULL, 0, _pp_rule_gong_disc), if(_pp_rule_consort_disc = NULL, 0, _pp_rule_consort_disc))) > 0, 1, 0);

_pp_app_fb_disc_flag := if(if(max(_pp_app_fb_ph_disc, _pp_app_fb_ph7_did_disc, _pp_app_fb_ph7_nm_addr_disc) = NULL, NULL, sum(if(_pp_app_fb_ph_disc = NULL, 0, _pp_app_fb_ph_disc), if(_pp_app_fb_ph7_did_disc = NULL, 0, _pp_app_fb_ph7_did_disc), if(_pp_app_fb_ph7_nm_addr_disc = NULL, 0, _pp_app_fb_ph7_nm_addr_disc))) > 0, 1, 0);

_phone_fb_disc_flag := if(if(max(_phone_fb_result_disc, _phone_fb_rp_result_disc) = NULL, NULL, sum(if(_phone_fb_result_disc = NULL, 0, _phone_fb_result_disc), if(_phone_fb_rp_result_disc = NULL, 0, _phone_fb_rp_result_disc))) > 0, 1, 0);

pk_disconnect_flag := map(
    if(max(_phone_disconnected, _pp_rule_disc_flag, _pp_app_fb_disc_flag, _phone_fb_disc_flag) = NULL, NULL, sum(if(_phone_disconnected = NULL, 0, _phone_disconnected), if(_pp_rule_disc_flag = NULL, 0, _pp_rule_disc_flag), if(_pp_app_fb_disc_flag = NULL, 0, _pp_app_fb_disc_flag), if(_phone_fb_disc_flag = NULL, 0, _phone_fb_disc_flag))) = 4 => 4,
    _phone_disconnected = 1 and if(max(_pp_rule_disc_flag, _pp_app_fb_disc_flag, _phone_fb_disc_flag) = NULL, NULL, sum(if(_pp_rule_disc_flag = NULL, 0, _pp_rule_disc_flag), if(_pp_app_fb_disc_flag = NULL, 0, _pp_app_fb_disc_flag), if(_phone_fb_disc_flag = NULL, 0, _phone_fb_disc_flag))) >= 1                                                 => 3,
    _phone_disconnected = 1                                                                                                                                                                                                                                                                                                                           => 2,
    if(max(_pp_rule_disc_flag, _pp_app_fb_disc_flag, _phone_fb_disc_flag) = NULL, NULL, sum(if(_pp_rule_disc_flag = NULL, 0, _pp_rule_disc_flag), if(_pp_app_fb_disc_flag = NULL, 0, _pp_app_fb_disc_flag), if(_phone_fb_disc_flag = NULL, 0, _phone_fb_disc_flag))) >= 1                                                                             => 1,
                                                                                                                                                                                                                                                                                                                                                         0);

_phone_match_code_lns := if(max((integer)_phone_match_code_l, (integer)_phone_match_code_n, (integer)_phone_match_code_s) = NULL, NULL, sum((integer)_phone_match_code_l, (integer)_phone_match_code_n, (integer)_phone_match_code_s)) > 0;

_phone_match_code_tcza := map(
    (Integer)_phone_match_code_t = 1 and (Integer)_phone_match_code_c = 1 and (Integer)_phone_match_code_z = 1 and (Integer)_phone_match_code_a = 1 => 4,
    (Integer)_phone_match_code_t = 1 and (Integer)_phone_match_code_c = 1                                                                           => 3,
    (Integer)_phone_match_code_t = 1                                                                                                                => 2,
    (Integer)_phone_match_code_c = 1 or (Integer)_phone_match_code_z = 1 or (Integer)_phone_match_code_a = 1                                        => 1,
                                                                                                                                                       0);

pk_phone_match_level := map(
    (Integer)_phone_match_code_lns = 1 and _phone_match_code_tcza = 4 => 4,
    (Integer)_phone_match_code_lns = 1 and _phone_match_code_tcza > 0 => 3,
    (Integer)_phone_match_code_lns = 1                                => 2,
    _phone_match_code_tcza > 0                                        => 1,
                                                                         0);

_pp_app_coctype_landline := if((trim(trim((string)pp_app_coctype, LEFT), LEFT, RIGHT) in ['EOC']), 1, 0);

_pp_app_coctype_cell := map(
    (trim(trim((string)pp_app_coctype, LEFT), LEFT, RIGHT) in ['PMC', 'RCC', 'SP1', 'SP2']) and (trim(trim((string)PP_app_SCC, LEFT), LEFT, RIGHT) in ['C', 'R', 'S']) => 1,
    (trim(trim((string)pp_app_coctype, LEFT), LEFT, RIGHT) in ['EOC']) and (trim(trim((string)PP_app_SCC, LEFT), LEFT, RIGHT) in ['C', 'R'])                           => 1,
                                                                                                                                                                          0);

_phone_switch_type_cell := if(trim(trim((string)Phone_Switch_Type, LEFT), LEFT, RIGHT) = 'C', 1, 0);

_pp_app_nxx_type_cell := if(((Integer)pp_app_nxx_type in [4, 55, 65]), 1, 0);

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

_pp_origlistingtype_res := if(trim(trim((string)pp_origlistingtype, LEFT), LEFT, RIGHT) = trim(trim('R', LEFT), LEFT, RIGHT), 1, 0);

pk_exp_hit := if(exp_verified = 0 and 
									trim(trim((string)exp_type, LEFT), LEFT, RIGHT) = '' and 
									trim(trim((string)exp_source, LEFT), LEFT, RIGHT) = '' and 
									trim(trim((string)exp_last_update, LEFT), LEFT, RIGHT) = '' and 
									trim(exp_ph_score_v1) = '', 0, 1);

segment := map(
    pk_exp_hit = 1          => '3 - ExpHit      ',
    pk_cell_flag = 1        => '2 - Cell Phone  ',
    _phone_disconnected = 1 => '0 - Disconnected',
                               '1 - Other       ');

util_add_input_type_list := util_add1_type_list;

add_input_occupants_1yr := add1_occupants_1yr;

add_input_turnover_1yr_in := add1_turnover_1yr_in;

add_input_turnover_1yr_out := add1_turnover_1yr_in;

util_add_curr_type_list := if(add1_isbestmatch, util_add1_type_list, util_add2_type_list);

add_curr_turnover_1yr_out := if(add1_isbestmatch, add1_turnover_1yr_in, add2_turnover_1yr_in);

add_curr_turnover_1yr_in := if(add1_isbestmatch, add1_turnover_1yr_in, add2_turnover_1yr_in);

add_curr_occupants_1yr := if(add1_isbestmatch, add1_occupants_1yr, add2_occupants_1yr);

college_income_level_code := ams_income_level_code;

r_pb_order_freq_d := map(
    not(truedid)                   => NULL,
    pb_number_of_sources = ''      => NULL,
    pb_average_days_bt_orders = '' => -1,
                                      min(if(pb_average_days_bt_orders = '', -NULL, (Integer)pb_average_days_bt_orders), 999));

f_bus_fname_verd_d := if(not(addrpop), NULL, (Integer)(bus_name_match in [2, 4]));

f_bus_name_nover_i := if(not(addrpop), NULL, (Integer)(bus_name_match = 1));

f_adl_util_misc_n := contains_i(StringLib.StringToUpperCase(util_adl_type_list), 'Z') > 0;

f_util_adl_count_n := if(not(truedid), NULL, util_adl_count);

f_util_add_input_conv_n := contains_i(StringLib.StringToUpperCase(util_add_input_type_list), '2') > 0;

f_util_add_input_misc_n := contains_i(StringLib.StringToUpperCase(util_add_input_type_list), 'Z') > 0;

f_util_add_curr_conv_n := contains_i(StringLib.StringToUpperCase(util_add_curr_type_list), '2') > 0;

f_add_input_mobility_index_n := map(
    not(addrpop)                 => NULL,
    add_input_occupants_1yr <= 0 => NULL,
                                    if(max(add_input_turnover_1yr_in, add_input_turnover_1yr_out) = NULL, NULL, sum(if(add_input_turnover_1yr_in = NULL, 0, add_input_turnover_1yr_in), if(add_input_turnover_1yr_out = NULL, 0, add_input_turnover_1yr_out))) / add_input_occupants_1yr);

f_add_curr_mobility_index_n := map(
    not(addrpop)                => NULL,
    add_curr_occupants_1yr <= 0 => NULL,
                                   if(max(add_curr_turnover_1yr_in, add_curr_turnover_1yr_out) = NULL, NULL, sum(if(add_curr_turnover_1yr_in = NULL, 0, add_curr_turnover_1yr_in), if(add_curr_turnover_1yr_out = NULL, 0, add_curr_turnover_1yr_out))) / add_curr_occupants_1yr);

f_inq_count_i := if(not(truedid), NULL, min(if(inq_count = NULL, -NULL, inq_count), 999));

f_inq_count24_i := if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999));

f_inq_per_ssn_i := if(not((Integer)ssnlength > 0), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999));

f_inq_addrs_per_ssn_i := if(not((Integer)ssnlength > 0), NULL, min(if(inq_addrsperssn = NULL, -NULL, (Integer)inq_addrsperssn), 999));

f_inq_per_addr_i := if(not(addrpop), NULL, min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999));

f_inq_adls_per_addr_i := if(not(addrpop), NULL, min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999));

f_inq_lnames_per_addr_i := if(not(addrpop), NULL, min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999));

f_inq_ssns_per_addr_i := if(not(addrpop), NULL, min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999));

_inq_banko_am_first_seen := Models.common.sas_date((string)(Inq_banko_am_first_seen));

f_mos_inq_banko_am_fseen_d := map(
    not(truedid)                    => NULL,
    _inq_banko_am_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _inq_banko_am_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_am_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_am_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_am_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_am_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_am_first_seen) / (365.25 / 12)))), 999));

_inq_banko_cm_first_seen := Models.common.sas_date((string)(Inq_banko_cm_first_seen));

f_mos_inq_banko_cm_fseen_d := map(
    not(truedid)                    => NULL,
    _inq_banko_cm_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)))), 999));

_inq_banko_cm_last_seen := Models.common.sas_date((string)(Inq_banko_cm_last_seen));

f_mos_inq_banko_cm_lseen_d := map(
    not(truedid)                   => NULL,
    _inq_banko_cm_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)))), 999)));

_inq_banko_om_first_seen := Models.common.sas_date((string)(Inq_banko_om_first_seen));

f_mos_inq_banko_om_fseen_d := map(
    not(truedid)                    => NULL,
    _inq_banko_om_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _inq_banko_om_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_om_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)))), 999));

_inq_banko_om_last_seen := Models.common.sas_date((string)(Inq_banko_om_last_seen));

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

f_estimated_income_d := if(not(truedid), NULL, estimated_income);

f_wealth_index_d := if(not(truedid), NULL, (Integer)wealth_index);

f_college_income_d := map(
    not(truedid)                     => NULL,
    college_income_level_code = ''   => NULL,
    college_income_level_code = 'A'  => 1,
    college_income_level_code = 'B'  => 2,
    college_income_level_code = 'C'  => 3,
    college_income_level_code = 'D'  => 4,
    college_income_level_code = 'E'  => 5,
    college_income_level_code = 'F'  => 6,
    college_income_level_code = 'G'  => 7,
    college_income_level_code = 'H'  => 8,
    college_income_level_code = 'I'  => 9,
    college_income_level_code = 'J'  => 10,
    college_income_level_code = 'K'  => 11,
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

_acc_last_seen := Models.common.sas_date((string)(acc_last_seen));

f_mos_acc_lseen_d := map(
    not(truedid)          => NULL,
    _acc_last_seen = NULL => 1000,
                             max(3, min(if(if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12)))), 999)));

f_idrisktype_i := if(not(truedid) or fp_idrisktype = '', NULL, (Integer)fp_idrisktype);

f_idverrisktype_i := if(not(truedid) or fp_idverrisktype = '', NULL, (Integer)fp_idverrisktype);

f_sourcerisktype_i := map(
    not(truedid)           => NULL,
    fp_sourcerisktype = '' => NULL,
                              (Integer)fp_sourcerisktype);

f_varrisktype_i := map(
    not(truedid)          => NULL,
    fp_varrisktype = ''   => NULL,
                             (Integer)fp_varrisktype);

f_vardobcount_i := if(not(truedid), NULL, min(if(fp_vardobcount = '', -NULL, (Integer)fp_vardobcount), 999));

f_srchvelocityrisktype_i := map(
    not(truedid)                 => NULL,
    fp_srchvelocityrisktype = '' => NULL,
                                    (Integer)fp_srchvelocityrisktype);

f_srchunvrfdaddrcount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdaddrcount = '', -NULL, (Integer)fp_srchunvrfdaddrcount), 999));

f_srchunvrfdphonecount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = '', -NULL, (Integer)fp_srchunvrfdphonecount), 999));

f_srchfraudsrchcount_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcount = '', -NULL, (Integer)fp_srchfraudsrchcount), 999));

f_srchfraudsrchcountyr_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountyr = '', -NULL, (Integer)fp_srchfraudsrchcountyr), 999));

f_assocrisktype_i := map(
    not(truedid)          => NULL,
    fp_assocrisktype = '' => NULL,
                             (Integer)fp_assocrisktype);

f_assocsuspicousidcount_i := if(not(truedid), NULL, min(if(fp_assocsuspicousidcount = '', -NULL, (Integer)fp_assocsuspicousidcount), 999));

f_assoccredbureaucount_i := if(not(truedid), NULL, min(if(fp_assoccredbureaucount = '', -NULL, (Integer)fp_assoccredbureaucount), 999));

f_validationrisktype_i := map(
    not(truedid)               => NULL,
    fp_validationrisktype = '' => NULL,
                                  (Integer)fp_validationrisktype);

f_corrrisktype_i := map(
    not(truedid)         => NULL,
    fp_corrrisktype = '' => NULL,
                            (Integer)fp_corrrisktype);

f_corrssnnamecount_d := if(not(truedid), NULL, min(if(fp_corrssnnamecount = '', -NULL, (Integer)fp_corrssnnamecount), 999));

f_corrssnaddrcount_d := if(not(truedid), NULL, min(if(fp_corrssnaddrcount = '', -NULL, (Integer)fp_corrssnaddrcount), 999));

f_corraddrnamecount_d := if(not(truedid), NULL, min(if(fp_corraddrnamecount = '', -NULL, (Integer)fp_corraddrnamecount), 999));

f_divrisktype_i := map(
    not(truedid)        => NULL,
    fp_divrisktype = '' => NULL,
                           (Integer)fp_divrisktype);

f_divssnidmsrcurelcount_i := if(not(truedid), NULL, min(if(fp_divssnidmsrcurelcount = '', -NULL, (Integer)fp_divssnidmsrcurelcount), 999));

f_divaddrsuspidcountnew_i := if(not(truedid), NULL, min(if(fp_divaddrsuspidcountnew = '', -NULL, (Integer)fp_divaddrsuspidcountnew), 999));

f_srchssnsrchcount_i := if(not(truedid), NULL, min(if(fp_srchssnsrchcount = '', -NULL, (Integer)fp_srchssnsrchcount), 999));

f_srchaddrsrchcount_i := if(not(truedid), NULL, min(if(fp_srchaddrsrchcount = '', -NULL, (Integer)fp_srchaddrsrchcount), 999));

f_componentcharrisktype_i := map(
    not(truedid)                  => NULL,
    fp_componentcharrisktype = '' => NULL,
                                     (Integer)fp_componentcharrisktype);

f_inputaddractivephonelist_d := map(
    not(truedid)                              => NULL,
    (Integer)fp_inputaddractivephonelist = -1 => NULL,
                                                 (Integer)fp_inputaddractivephonelist);

// f_addrchangeincomediff_d_1 := if(not(truedid), NULL, NULL);

f_addrchangeincomediff_d := if((Integer)fp_addrchangeincomediff = -1, NULL, (Integer)fp_addrchangeincomediff);

f_addrchangevaluediff_d := map(
    not(truedid)                         => NULL,
    (Integer)fp_addrchangevaluediff = -1 => NULL,
                                            (Integer)fp_addrchangevaluediff);

f_addrchangecrimediff_i := map(
    not(truedid)                         => NULL,
    (Integer)fp_addrchangecrimediff = -1 => NULL,
                                            (Integer)fp_addrchangecrimediff);

f_curraddractivephonelist_d := map(
    not(truedid)                             => NULL,
    (Integer)fp_curraddractivephonelist = -1 => NULL,
                                                (Integer)fp_curraddractivephonelist);

f_curraddrmedianincome_d := if(not(truedid), NULL, (Integer)fp_curraddrmedianincome);

f_curraddrmedianvalue_d := if(not(truedid), NULL, (Integer)fp_curraddrmedianvalue);

f_curraddrmurderindex_i := if(not(truedid), NULL, (Integer)fp_curraddrmurderindex);

f_curraddrcartheftindex_i := if(not(truedid), NULL, (Integer)fp_curraddrcartheftindex);

f_curraddrburglaryindex_i := if(not(truedid), NULL, (Integer)fp_curraddrburglaryindex);

f_curraddrcrimeindex_i := if(not(truedid), NULL, (Integer)fp_curraddrcrimeindex);

f_prevaddrageoldest_d := if(not(truedid), NULL, min(if(fp_prevaddrageoldest = '', -NULL, (Integer)fp_prevaddrageoldest), 999));

f_prevaddrlenofres_d := if(not(truedid), NULL, min(if(fp_prevaddrlenofres = '', -NULL, (Integer)fp_prevaddrlenofres), 999));

f_prevaddrstatus_i := map(
    not(truedid)            => NULL,
    fp_prevaddrstatus = '0' => 1,
    fp_prevaddrstatus = 'U' => 2,
    fp_prevaddrstatus = 'R' => 3,
                               NULL);

f_prevaddrmedianincome_d := if(not(truedid), NULL, (Integer)fp_prevaddrmedianincome);

f_prevaddrmedianvalue_d := if(not(truedid), NULL, (Integer)fp_prevaddrmedianvalue);

f_prevaddrmurderindex_i := if(not(truedid), NULL, (Integer)fp_prevaddrmurderindex);

f_prevaddrcartheftindex_i := if(not(truedid), NULL, (Integer)fp_prevaddrcartheftindex);

f_fp_prevaddrburglaryindex_i := if(not(truedid), NULL, (Integer)fp_prevaddrburglaryindex);

f_fp_prevaddrcrimeindex_i := if(not(truedid), NULL, (Integer)fp_prevaddrcrimeindex);

r_has_paw_source_d := if(paw_source_count > 0, 1, 0);

_paw_first_seen := Models.common.sas_date((string)(paw_first_seen));

r_mos_since_paw_fseen_d := map(
    not(truedid)                => NULL,
    not(_paw_first_seen = NULL) => min(if(if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen) / (365.25 / 12)), roundup((sysdate - _paw_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen) / (365.25 / 12)), roundup((sysdate - _paw_first_seen) / (365.25 / 12)))), 240),
                                   -1);

r_paw_active_phone_ct_d := if(not(truedid), NULL, paw_active_phone_count);

//--------------------------------------------------------------------------------------------------
//  NOTE:  This is the beginning of the tree code.  You probably want to replace code from here 
//         until the end of the tree code with the tree code that was generated by R.
//--------------------------------------------------------------------------------------------------
final_score_0 := -1.2572657754;

final_score_1_c143 := map(
    NULL < mth_pp_datefirstseen AND mth_pp_datefirstseen <= 22.5 => 0.2406622261,
    mth_pp_datefirstseen > 22.5                                  => 0.1201380490,
    mth_pp_datefirstseen = NULL                                  => 0.0476352238,
                                                                    0.1414684417);

final_score_1_c142 := map(
    NULL < number_of_sources AND number_of_sources <= 2.5 => final_score_1_c143,
    number_of_sources > 2.5                               => 0.2879834174,
    number_of_sources = NULL                              => 0.2053129563,
                                                             0.2053129563);

final_score_1_c145 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 16.5 => 0.0944873600,
    mth_source_ppdid_lseen > 16.5                                    => -0.0468151714,
    mth_source_ppdid_lseen = NULL                                    => -0.0764087256,
                                                                        -0.0562348241);

final_score_1_c144 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 6.5 => 0.2688326887,
    mth_source_rel_fseen > 6.5                                  => 0.2307754772,
    mth_source_rel_fseen = NULL                                 => final_score_1_c145,
                                                                   -0.0411037554);

final_score_1 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 23.5 => final_score_1_c142,
    mth_exp_last_update > 23.5                                 => 0.0795726298,
    mth_exp_last_update = NULL                                 => final_score_1_c144,
                                                                  -0.0004588813);

final_score_2_c148 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 11.5 => 0.2274996030,
    mth_source_ppdid_lseen > 11.5                                    => 0.0803518349,
    mth_source_ppdid_lseen = NULL                                    => 0.0542980104,
                                                                        0.0971160803);

final_score_2_c147 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 65.5 => final_score_2_c148,
    f_mos_inq_banko_cm_lseen_d > 65.5                                        => 0.2051264065,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => 0.1480390629,
                                                                                0.1480390629);

final_score_2_c150 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 16.5 => 0.0839831530,
    mth_source_ppdid_lseen > 16.5                                    => -0.0406881387,
    mth_source_ppdid_lseen = NULL                                    => -0.0664697554,
                                                                        -0.0489305500);

final_score_2_c149 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 4.5 => 0.2241540781,
    mth_source_rel_fseen > 4.5                                  => 0.1977810199,
    mth_source_rel_fseen = NULL                                 => final_score_2_c150,
                                                                   -0.0358434518);

final_score_2 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 34.5 => final_score_2_c147,
    mth_exp_last_update > 34.5                                 => 0.0363112711,
    mth_exp_last_update = NULL                                 => final_score_2_c149,
                                                                  -0.0051082480);

final_score_3_c152 := map(
    NULL < f_mos_inq_banko_cm_fseen_d AND f_mos_inq_banko_cm_fseen_d <= 77 => 0.0761511233,
    f_mos_inq_banko_cm_fseen_d > 77                                        => 0.1811263989,
    f_mos_inq_banko_cm_fseen_d = NULL                                      => 0.1194456190,
                                                                              0.1194456190);

final_score_3_c155 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Granddaughter', 'Grandfather', 'Grandson', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Wife']) => -0.0768613935,
    (phone_subject_title in ['Associate By Property', 'Daughter', 'Father', 'Grandchild', 'Grandmother', 'Grandparent', 'Mother', 'Subject at Household'])                                                                                                                                                                                      => 0.0095604968,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                    => -0.0649029513,
                                                                                                                                                                                                                                                                                                                                                   -0.0649029513);

final_score_3_c154 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 16.5 => 0.0654080354,
    mth_source_ppdid_lseen > 16.5                                    => -0.0393467276,
    mth_source_ppdid_lseen = NULL                                    => final_score_3_c155,
                                                                        -0.0489509709);

final_score_3_c153 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 14.5 => 0.1732012936,
    mth_source_rel_fseen > 14.5                                  => 0.1257762188,
    mth_source_rel_fseen = NULL                                  => final_score_3_c154,
                                                                    -0.0391661987);

final_score_3 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 73.5 => final_score_3_c152,
    mth_exp_last_update > 73.5                                 => -0.0433122169,
    mth_exp_last_update = NULL                                 => final_score_3_c153,
                                                                  -0.0095141779);

final_score_4_c157 := map(
    (phone_subject_title in ['Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Daughter', 'Father', 'Grandfather', 'Husband', 'Mother', 'Neighbor', 'Relative', 'Sister', 'Son', 'Wife'])                                                                                        => -0.0301068716,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Vehicle', 'Child', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Parent', 'Sibling', 'Spouse', 'Subject', 'Subject at Household']) => 0.1301374339,
    phone_subject_title = ''                                                                                                                                                                                                                                                                     => 0.1114876938,
                                                                                                                                                                                                                                                                                                    0.1114876938);

final_score_4_c160 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Grandmother', 'Grandson', 'Husband', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Son', 'Wife']) => -0.0790177930,
    (phone_subject_title in ['Associate By Property', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Mother', 'Parent', 'Spouse', 'Subject', 'Subject at Household'])                                                                    => -0.0147327497,
    phone_subject_title = ''                                                                                                                                                                                                                                                           => -0.0530343174,
                                                                                                                                                                                                                                                                                          -0.0530343174);

final_score_4_c159 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 25.5 => 0.1500296609,
    mth_source_utildid_fseen > 25.5                                      => 0.0010914227,
    mth_source_utildid_fseen = NULL                                      => final_score_4_c160,
                                                                            -0.0455527406);

final_score_4_c158 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 5.5 => 0.1651806197,
    mth_source_rel_fseen > 5.5                                  => 0.1227307769,
    mth_source_rel_fseen = NULL                                 => final_score_4_c159,
                                                                   -0.0364166316);

final_score_4 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 23.5 => final_score_4_c157,
    mth_exp_last_update > 23.5                                 => 0.0369447201,
    mth_exp_last_update = NULL                                 => final_score_4_c158,
                                                                  -0.0110182033);

final_score_5_c162 := map(
    NULL < pk_phone_match_level AND pk_phone_match_level <= 2.5 => 0.0144870028,
    pk_phone_match_level > 2.5                                  => 0.1235970651,
    pk_phone_match_level = NULL                                 => 0.1025963112,
                                                                   0.1025963112);

final_score_5_c163 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 5.5 => 0.0882225675,
    f_srchvelocityrisktype_i > 5.5                                      => -0.0164719489,
    f_srchvelocityrisktype_i = NULL                                     => 0.0443578577,
                                                                           0.0443578577);

final_score_5_c165 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 4.5 => 0.1575545509,
    mth_source_ppdid_lseen > 4.5                                    => -0.0062789588,
    mth_source_ppdid_lseen = NULL                                   => -0.0603096118,
                                                                       -0.0446250269);

final_score_5_c164 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 5.5 => 0.1363852734,
    mth_source_rel_fseen > 5.5                                  => 0.1151129083,
    mth_source_rel_fseen = NULL                                 => final_score_5_c165,
                                                                   -0.0358355913);

final_score_5 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 17.5 => final_score_5_c162,
    mth_exp_last_update > 17.5                                 => final_score_5_c163,
    mth_exp_last_update = NULL                                 => final_score_5_c164,
                                                                  -0.0130923791);

final_score_6_c168 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 15.5 => 0.1510196818,
    mth_source_ppdid_lseen > 15.5                                    => -0.0196498383,
    mth_source_ppdid_lseen = NULL                                    => 0.0102631208,
                                                                        0.0322988698);

final_score_6_c170 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 20.5 => 0.1349361054,
    mth_source_utildid_fseen > 20.5                                      => -0.0131137682,
    mth_source_utildid_fseen = NULL                                      => -0.0060740324,
                                                                            -0.0003939696);

final_score_6_c169 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 5.5 => 0.1190691940,
    mth_source_rel_fseen > 5.5                                  => 0.0972986964,
    mth_source_rel_fseen = NULL                                 => final_score_6_c170,
                                                                   0.0114479458);

final_score_6_c167 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 23.5 => 0.0952852660,
    mth_exp_last_update > 23.5                                 => final_score_6_c168,
    mth_exp_last_update = NULL                                 => final_score_6_c169,
                                                                  0.0317813049);

final_score_6 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Wife']) => -0.0604949113,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Grandchild', 'Grandfather', 'Subject', 'Subject at Household'])                                                                                                                                                                                                                                    => final_score_6_c167,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                           => -0.0125972022,
                                                                                                                                                                                                                                                                                                                                                                          -0.0125972022);

final_score_7_c174 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 17.5 => 0.0770846912,
    mth_source_ppdid_lseen > 17.5                                    => -0.0366601192,
    mth_source_ppdid_lseen = NULL                                    => -0.0054399358,
                                                                        -0.0006600085);

final_score_7_c173 := map(
    NULL < pk_cell_flag AND pk_cell_flag <= 0.5 => -0.0634786066,
    pk_cell_flag > 0.5                          => final_score_7_c174,
    pk_cell_flag = NULL                         => -0.0452207643,
                                                   -0.0452207643);

final_score_7_c172 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 5.5 => 0.0990182209,
    mth_source_rel_fseen > 5.5                                  => 0.0919396924,
    mth_source_rel_fseen = NULL                                 => final_score_7_c173,
                                                                   -0.0376308939);

final_score_7_c175 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 11.5 => 0.1118001368,
    mth_exp_last_update > 11.5                                 => 0.0715600606,
    mth_exp_last_update = NULL                                 => 0.0335382370,
                                                                  0.0619848361);

final_score_7 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => final_score_7_c172,
    number_of_sources > 1.5                               => final_score_7_c175,
    number_of_sources = NULL                              => -0.0113331306,
                                                             -0.0113331306);

final_score_8_c177 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 7.5 => 0.1255560944,
    mth_internal_ver_first_seen > 7.5                                         => 0.1160123034,
    mth_internal_ver_first_seen = NULL                                        => 0.0175669978,
                                                                                 0.0767720606);

final_score_8_c180 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 25.5 => 0.1129555461,
    mth_source_utildid_fseen > 25.5                                      => -0.0173442004,
    mth_source_utildid_fseen = NULL                                      => -0.0094038965,
                                                                            -0.0037678002);

final_score_8_c179 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 5.5 => 0.0930132406,
    mth_source_rel_fseen > 5.5                                  => 0.0620822966,
    mth_source_rel_fseen = NULL                                 => final_score_8_c180,
                                                                   0.0036565787);

final_score_8_c178 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Grandmother', 'Grandson', 'Husband', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Wife']) => -0.0651229718,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Mother', 'Parent', 'Son', 'Subject', 'Subject at Household'])                                                => final_score_8_c179,
    phone_subject_title = ''                                                                                                                                                                                                                                                 => -0.0304343406,
                                                                                                                                                                                                                                                                                -0.0304343406);

final_score_8 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 11.5 => final_score_8_c177,
    mth_exp_last_update > 11.5                                 => 0.0334135447,
    mth_exp_last_update = NULL                                 => final_score_8_c178,
                                                                  -0.0133550100);

final_score_9_c183 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 0.5 => -0.0593938234,
    (Integer)inq_adl_firstseen_n > 0.5                                          => 0.0633574250,
    (Integer)inq_adl_firstseen_n = NULL                                         => -0.0368414315,
                                                                                   -0.0413572699);

final_score_9_c182 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 10.5 => 0.0470698510,
    mth_source_rel_fseen > 10.5                                  => 0.0742657269,
    mth_source_rel_fseen = NULL                                  => final_score_9_c183,
                                                                    -0.0360630974);

final_score_9_c185 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 26.5 => 0.1020473954,
    mth_exp_last_update > 26.5                                 => 0.1357116784,
    mth_exp_last_update = NULL                                 => 0.0468557350,
                                                                  0.0790779899);

final_score_9_c184 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 42.5 => 0.0092464745,
    f_mos_inq_banko_cm_lseen_d > 42.5                                        => final_score_9_c185,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => 0.0494076410,
                                                                                0.0494076410);

final_score_9 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => final_score_9_c182,
    number_of_sources > 1.5                               => final_score_9_c184,
    number_of_sources = NULL                              => -0.0130973344,
                                                             -0.0130973344);

final_score_10_c189 := map(
    NULL < pk_cell_indicator AND pk_cell_indicator <= 1.5 => -0.0498103771,
    pk_cell_indicator > 1.5                               => 0.0151898070,
    pk_cell_indicator = NULL                              => -0.0340601085,
                                                             -0.0340601085);

final_score_10_c188 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 13.5 => 0.0802220340,
    mth_source_rel_fseen > 13.5                                  => 0.0374490073,
    mth_source_rel_fseen = NULL                                  => final_score_10_c189,
                                                                    -0.0292145396);

final_score_10_c187 := map(
    NULL < (Integer)_inq_adl_ph_industry_flag AND (Integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_10_c188,
    (Integer)_inq_adl_ph_industry_flag > 0.5                                                => 0.1333363401,
    (Integer)_inq_adl_ph_industry_flag = NULL                                               => -0.0251378166,
                                                                                               -0.0251378166);

final_score_10_c190 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 6.5 => 0.0280273492,
    f_corraddrnamecount_d > 6.5                                   => 0.1127586419,
    f_corraddrnamecount_d = NULL                                  => 0.0739933357,
                                                                     0.0739933357);

final_score_10 := map(
    NULL < number_of_sources AND number_of_sources <= 2.5 => final_score_10_c187,
    number_of_sources > 2.5                               => final_score_10_c190,
    number_of_sources = NULL                              => -0.0145937775,
                                                             -0.0145937775);

final_score_11_c193 := map(
    (segment in ['0 - Disconnected', '1 - Other']) => -0.0255287168,
    (segment in ['2 - Cell Phone', '3 - ExpHit'])  => 0.0776261437,
    segment = ''                                   => 0.0538211759,
                                                      0.0538211759);

final_score_11_c194 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Father', 'Granddaughter', 'Grandfather', 'Grandson', 'Husband', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Wife']) => -0.0473884293,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Daughter', 'Grandchild', 'Grandmother', 'Grandparent', 'Mother', 'Parent', 'Subject at Household'])                                                                                                                                                            => 0.0523028547,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                       => -0.0283458648,
                                                                                                                                                                                                                                                                                                                                      -0.0283458648);

final_score_11_c192 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 17.5 => final_score_11_c193,
    mth_source_ppdid_lseen > 17.5                                    => -0.0290649513,
    mth_source_ppdid_lseen = NULL                                    => final_score_11_c194,
                                                                        -0.0195664197);

final_score_11_c195 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 3.5 => 0.1443913539,
    f_inq_count_i > 3.5                           => 0.0541415604,
    f_inq_count_i = NULL                          => 0.0754637338,
                                                     0.0754637338);

final_score_11 := map(
    NULL < number_of_sources AND number_of_sources <= 2.5 => final_score_11_c192,
    number_of_sources > 2.5                               => final_score_11_c195,
    number_of_sources = NULL                              => -0.0095056494,
                                                             -0.0095056494);

final_score_12_c198 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 0.5 => -0.0564307304,
    (Integer)inq_adl_firstseen_n > 0.5                                          => 0.0615438284,
    (Integer)inq_adl_firstseen_n = NULL                                         => 0.0077015819,
                                                                                   0.0108206084);

final_score_12_c197 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 114.5 => final_score_12_c198,
    f_prevaddrageoldest_d > 114.5                                   => 0.0886027410,
    f_prevaddrageoldest_d = NULL                                    => 0.0486591424,
                                                                       0.0486591424);

final_score_12_c200 := map(
    NULL < (Integer)_phone_match_code_l AND (Integer)_phone_match_code_l <= 0.5 => 0.0723617867,
    (Integer)_phone_match_code_l > 0.5                                          => -0.0063799360,
    (Integer)_phone_match_code_l = NULL                                         => 0.0043835374,
                                                                                   0.0043835374);

final_score_12_c199 := map(
    NULL < pk_phone_match_level AND pk_phone_match_level <= 1.5 => -0.0511920728,
    pk_phone_match_level > 1.5                                  => final_score_12_c200,
    pk_phone_match_level = NULL                                 => -0.0286920692,
                                                                   -0.0286920692);

final_score_12 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 73.5 => final_score_12_c197,
    mth_exp_last_update > 73.5                                 => -0.0413915324,
    mth_exp_last_update = NULL                                 => final_score_12_c199,
                                                                  -0.0147387681);

final_score_13_c205 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 10.5 => 0.0807168562,
    mth_eda_dt_first_seen > 10.5                                   => -0.0326517993,
    mth_eda_dt_first_seen = NULL                                   => -0.0290669301,
                                                                      -0.0207258870);

final_score_13_c204 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 7.5 => 0.0452504088,
    f_inq_count_i > 7.5                           => final_score_13_c205,
    f_inq_count_i = NULL                          => 0.0098342456,
                                                     0.0098342456);

final_score_13_c203 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Daughter', 'Grandmother', 'Grandson', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Wife']) => -0.0473898181,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Vehicle', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Husband', 'Mother', 'Spouse', 'Subject', 'Subject at Household'])                => final_score_13_c204,
    phone_subject_title = ''                                                                                                                                                                                                                                 => -0.0183723119,
                                                                                                                                                                                                                                                                -0.0183723119);

final_score_13_c202 := map(
    NULL < (Integer)_inq_adl_ph_industry_flag AND (Integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_13_c203,
    (Integer)_inq_adl_ph_industry_flag > 0.5                                                => 0.1411765122,
    (Integer)_inq_adl_ph_industry_flag = NULL                                               => -0.0147407331,
                                                                                               -0.0147407331);

final_score_13 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 12.5 => 0.1657099097,
    mth_source_utildid_fseen > 12.5                                      => 0.0271199481,
    mth_source_utildid_fseen = NULL                                      => final_score_13_c202,
                                                                            -0.0082625139);

final_score_14_c208 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 2.5 => 0.0627076707,
    f_srchfraudsrchcount_i > 2.5                                    => -0.0134793460,
    f_srchfraudsrchcount_i = NULL                                   => 0.0318839158,
                                                                       0.0318839158);

final_score_14_c210 := map(
    NULL < (Integer)_phone_match_code_n AND (Integer)_phone_match_code_n <= 0.5 => 0.0006962854,
    (Integer)_phone_match_code_n > 0.5                                          => 0.0770289282,
    (Integer)_phone_match_code_n = NULL                                         => 0.0150305834,
                                                                                   0.0150305834);

final_score_14_c209 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Grandson', 'Husband', 'Neighbor', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Wife']) => -0.0374858474,
    (phone_subject_title in ['Associate', 'Associate By SSN', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Mother', 'Parent', 'Relative', 'Son', 'Subject at Household'])                                                                    => final_score_14_c210,
    phone_subject_title = ''                                                                                                                                                                                                                                                           => -0.0248901743,
                                                                                                                                                                                                                                                                                          -0.0248901743);

final_score_14_c207 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 71.5 => final_score_14_c208,
    mth_exp_last_update > 71.5                                 => -0.0553397264,
    mth_exp_last_update = NULL                                 => final_score_14_c209,
                                                                  -0.0158610781);

final_score_14 := map(
    NULL < (Integer)_inq_adl_ph_industry_flag AND (Integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_14_c207,
    (Integer)_inq_adl_ph_industry_flag > 0.5                                                => 0.1062698937,
    (Integer)_inq_adl_ph_industry_flag = NULL                                               => -0.0115662297,
                                                                                               -0.0115662297);

final_score_15_c212 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 1.5 => 0.0332325057,
    f_srchfraudsrchcount_i > 1.5                                    => -0.0492335582,
    f_srchfraudsrchcount_i = NULL                                   => -0.0190861283,
                                                                       -0.0190861283);

final_score_15_c215 := map(
    NULL < (Integer)_phone_match_code_n AND (Integer)_phone_match_code_n <= 0.5 => -0.0064631011,
    (Integer)_phone_match_code_n > 0.5                                          => 0.0727057516,
    (Integer)_phone_match_code_n = NULL                                         => 0.0027223652,
                                                                                   0.0027223652);

final_score_15_c214 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Grandmother', 'Grandparent', 'Grandson', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Subject'])                                                                                    => -0.0625845669,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Brother', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Husband', 'Mother', 'Relative', 'Son', 'Spouse', 'Subject at Household', 'Wife']) => final_score_15_c215,
    phone_subject_title = ''                                                                                                                                                                                                                                                                   => -0.0221798742,
                                                                                                                                                                                                                                                                                                  -0.0221798742);

final_score_15_c213 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 14.5 => 0.0951762958,
    mth_source_sx_fseen > 14.5                                 => 0.0450077184,
    mth_source_sx_fseen = NULL                                 => final_score_15_c214,
                                                                  -0.0162161740);

final_score_15 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 16.5 => 0.0512166285,
    mth_source_ppdid_lseen > 16.5                                    => final_score_15_c212,
    mth_source_ppdid_lseen = NULL                                    => final_score_15_c213,
                                                                        -0.0086172374);

final_score_16_c218 := map(
    NULL < f_estimated_income_d AND f_estimated_income_d <= 49500 => -0.0126275609,
    f_estimated_income_d > 49500                                  => 0.0648511823,
    f_estimated_income_d = NULL                                   => 0.0296864737,
                                                                     0.0296864737);

final_score_16_c217 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Daughter', 'Father', 'Grandfather', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject', 'Wife']) => -0.0353813367,
    (phone_subject_title in ['Associate', 'Associate By Vehicle', 'Grandchild', 'Granddaughter', 'Grandmother', 'Spouse', 'Subject at Household'])                                                                                                                                                                                                      => final_score_16_c218,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                            => -0.0252097165,
                                                                                                                                                                                                                                                                                                                                                           -0.0252097165);

final_score_16_c220 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 25.5 => 0.0750199320,
    mth_exp_last_update > 25.5                                 => 0.1337461468,
    mth_exp_last_update = NULL                                 => 0.0446417917,
                                                                  0.0679794758);

final_score_16_c219 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 70.5 => 0.0069986132,
    f_mos_inq_banko_cm_lseen_d > 70.5                                        => final_score_16_c220,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => 0.0329890376,
                                                                                0.0329890376);

final_score_16 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => final_score_16_c217,
    number_of_sources > 1.5                               => final_score_16_c219,
    number_of_sources = NULL                              => -0.0099754216,
                                                             -0.0099754216);

final_score_17_c224 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Wife']) => -0.0448708089,
    (phone_subject_title in ['Associate', 'Associate By SSN', 'Grandchild', 'Granddaughter', 'Parent', 'Son', 'Subject at Household'])                                                                                                                                                                                                                              => 0.0205238658,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                        => -0.0357825831,
                                                                                                                                                                                                                                                                                                                                                                       -0.0357825831);

final_score_17_c223 := map(
    NULL < pk_cell_indicator AND pk_cell_indicator <= 1.5 => final_score_17_c224,
    pk_cell_indicator > 1.5                               => 0.0174802541,
    pk_cell_indicator = NULL                              => -0.0239791633,
                                                             -0.0239791633);

final_score_17_c222 := map(
    NULL < (Integer)_inq_adl_ph_industry_flag AND (Integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_17_c223,
    (Integer)_inq_adl_ph_industry_flag > 0.5                                                => 0.1026995830,
    (Integer)_inq_adl_ph_industry_flag = NULL                                               => -0.0207714408,
                                                                                               -0.0207714408);

final_score_17_c225 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 88.5 => 0.0077240250,
    f_prevaddrageoldest_d > 88.5                                   => 0.0870283083,
    f_prevaddrageoldest_d = NULL                                   => 0.0557362766,
                                                                      0.0557362766);

final_score_17 := map(
    NULL < number_of_sources AND number_of_sources <= 2.5 => final_score_17_c222,
    number_of_sources > 2.5                               => final_score_17_c225,
    number_of_sources = NULL                              => -0.0127284676,
                                                             -0.0127284676);

final_score_18_c228 := map(
    NULL < (Integer)inq_adl_lastseen_n AND (Integer)inq_adl_lastseen_n <= 7.5 => 0.1078091709,
    (Integer)inq_adl_lastseen_n > 7.5                                         => -0.0130956102,
    (Integer)inq_adl_lastseen_n = NULL                                        => 0.0068378437,
                                                                                 0.0068378437);

final_score_18_c227 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 8.5 => 0.1071814253,
    f_inq_count_i > 8.5                           => final_score_18_c228,
    f_inq_count_i = NULL                          => 0.0376798410,
                                                     0.0376798410);

final_score_18_c230 := map(
    NULL < f_estimated_income_d AND f_estimated_income_d <= 81500 => 0.0147400542,
    f_estimated_income_d > 81500                                  => 0.1183511831,
    f_estimated_income_d = NULL                                   => 0.0389774045,
                                                                     0.0389774045);

final_score_18_c229 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 27.5 => final_score_18_c230,
    mth_source_ppdid_lseen > 27.5                                    => -0.0421194588,
    mth_source_ppdid_lseen = NULL                                    => -0.0071577993,
                                                                        -0.0016625214);

final_score_18 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 0.5 => -0.0192069264,
    (Integer)inq_adl_firstseen_n > 0.5                                          => final_score_18_c227,
    (Integer)inq_adl_firstseen_n = NULL                                         => final_score_18_c229,
                                                                                   -0.0045818727);

final_score_19_c232 := map(
    NULL < (Integer)source_rel AND (Integer)source_rel <= 0.5 => -0.0315593194,
    (Integer)source_rel > 0.5                                 => 0.0571120805,
    (Integer)source_rel = NULL                                => -0.0270373306,
                                                                 -0.0270373306);

final_score_19_c233 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 155.5 => -0.0073496489,
    mth_pp_app_npa_effective_dt > 155.5                                         => 0.0664873813,
    mth_pp_app_npa_effective_dt = NULL                                          => 0.0721614593,
                                                                                   0.0369680279);

final_score_19_c235 := map(
    NULL < f_estimated_income_d AND f_estimated_income_d <= 90500 => 0.0321689007,
    f_estimated_income_d > 90500                                  => 0.1438893041,
    f_estimated_income_d = NULL                                   => 0.0482795249,
                                                                     0.0482795249);

final_score_19_c234 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 27.5 => final_score_19_c235,
    mth_source_ppdid_lseen > 27.5                                    => -0.0521996319,
    mth_source_ppdid_lseen = NULL                                    => -0.0054736809,
                                                                        0.0005234835);

final_score_19 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 0.5 => final_score_19_c232,
    (Integer)inq_adl_firstseen_n > 0.5                                          => final_score_19_c233,
    (Integer)inq_adl_firstseen_n = NULL                                         => final_score_19_c234,
                                                                                   -0.0071499145);

final_score_20_c239 := map(
    NULL < pk_cell_indicator AND pk_cell_indicator <= 1.5 => -0.0132729402,
    pk_cell_indicator > 1.5                               => 0.0618046622,
    pk_cell_indicator = NULL                              => 0.0349024639,
                                                             0.0349024639);

final_score_20_c240 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 24.5 => 0.0146289283,
    mth_source_ppth_fseen > 24.5                                   => -0.0852023966,
    mth_source_ppth_fseen = NULL                                   => 0.0057968391,
                                                                      0.0002140706);

final_score_20_c238 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 17.5 => final_score_20_c239,
    mth_source_ppdid_lseen > 17.5                                    => -0.0146610741,
    mth_source_ppdid_lseen = NULL                                    => final_score_20_c240,
                                                                        0.0033278788);

final_score_20_c237 := map(
    NULL < eda_address_match_best AND eda_address_match_best <= 0.5 => final_score_20_c238,
    eda_address_match_best > 0.5                                    => 0.0837560365,
    eda_address_match_best = NULL                                   => 0.0076459171,
                                                                       0.0076459171);

final_score_20 := map(
    (phone_subject_title in ['Associate By Property', 'Brother', 'Child', 'Father', 'Granddaughter', 'Grandfather', 'Grandson', 'Neighbor', 'Sibling', 'Sister', 'Wife'])                                                                                                                                                        => -0.0672220850,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Daughter', 'Grandchild', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Parent', 'Relative', 'Son', 'Spouse', 'Subject', 'Subject at Household']) => final_score_20_c237,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                     => -0.0076502943,
                                                                                                                                                                                                                                                                                                                                    -0.0076502943);

final_score_21_c242 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 5.5 => 0.0586752148,
    f_srchvelocityrisktype_i > 5.5                                      => -0.0382232298,
    f_srchvelocityrisktype_i = NULL                                     => 0.0103018129,
                                                                           0.0103018129);

final_score_21_c245 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 153.5 => 0.0071669623,
    f_prevaddrageoldest_d > 153.5                                   => 0.0678083078,
    f_prevaddrageoldest_d = NULL                                    => 0.0337490001,
                                                                       0.0337490001);

final_score_21_c244 := map(
    NULL < f_mos_inq_banko_cm_fseen_d AND f_mos_inq_banko_cm_fseen_d <= 77 => -0.0148327298,
    f_mos_inq_banko_cm_fseen_d > 77                                        => final_score_21_c245,
    f_mos_inq_banko_cm_fseen_d = NULL                                      => 0.0022161981,
                                                                              0.0022161981);

final_score_21_c243 := map(
    (phone_subject_title in ['Associate By Shared Associates', 'Brother', 'Granddaughter', 'Grandmother', 'Grandson', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister'])                                                                                                                          => -0.0547403849,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Daughter', 'Father', 'Grandchild', 'Grandfather', 'Grandparent', 'Mother', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_21_c244,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                      => -0.0154755703,
                                                                                                                                                                                                                                                                                                                     -0.0154755703);

final_score_21 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 12.5 => 0.1102087935,
    mth_source_utildid_fseen > 12.5                                      => final_score_21_c242,
    mth_source_utildid_fseen = NULL                                      => final_score_21_c243,
                                                                            -0.0114283897);

final_score_22_c249 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Neighbor', 'Relative', 'Sister', 'Son', 'Spouse', 'Subject', 'Wife'])                => -0.0345973925,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Grandfather', 'Husband', 'Mother', 'Parent', 'Sibling', 'Subject at Household']) => 0.0095711959,
    phone_subject_title = ''                                                                                                                                                                                                                                 => -0.0180607278,
                                                                                                                                                                                                                                                                -0.0180607278);

final_score_22_c250 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => 0.0126178669,
    number_of_sources > 1.5                               => 0.0987350487,
    number_of_sources = NULL                              => 0.0337759676,
                                                             0.0337759676);

final_score_22_c248 := map(
    NULL < f_wealth_index_d AND f_wealth_index_d <= 4.5 => final_score_22_c249,
    f_wealth_index_d > 4.5                              => final_score_22_c250,
    f_wealth_index_d = NULL                             => -0.0130084466,
                                                           -0.0130084466);

final_score_22_c247 := map(
    NULL < (Integer)_inq_adl_ph_industry_flag AND (Integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_22_c248,
    (Integer)_inq_adl_ph_industry_flag > 0.5                                                => 0.0823456280,
    (Integer)_inq_adl_ph_industry_flag = NULL                                               => -0.0106389161,
                                                                                               -0.0106389161);

final_score_22 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 12.5 => 0.1152086874,
    mth_source_utildid_fseen > 12.5                                      => 0.0079620343,
    mth_source_utildid_fseen = NULL                                      => final_score_22_c247,
                                                                            -0.0071938031);

final_score_23_c255 := map(
    NULL < eda_address_match_best AND eda_address_match_best <= 0.5 => -0.0011615410,
    eda_address_match_best > 0.5                                    => 0.0666918978,
    eda_address_match_best = NULL                                   => 0.0028707595,
                                                                       0.0028707595);

final_score_23_c254 := map(
    (phone_subject_title in ['Father', 'Grandfather', 'Grandmother', 'Grandson', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Son', 'Wife'])                                                                                                                                                                                                                => -0.0546750626,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandparent', 'Husband', 'Mother', 'Parent', 'Spouse', 'Subject', 'Subject at Household']) => final_score_23_c255,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                 => -0.0118167701,
                                                                                                                                                                                                                                                                                                                                                                -0.0118167701);

final_score_23_c253 := map(
    NULL < mth_pp_eda_hist_nm_addr_dt AND mth_pp_eda_hist_nm_addr_dt <= 49.5 => -0.1052408354,
    mth_pp_eda_hist_nm_addr_dt > 49.5                                        => -0.0666607732,
    mth_pp_eda_hist_nm_addr_dt = NULL                                        => final_score_23_c254,
                                                                                -0.0142311125);

final_score_23_c252 := map(
    NULL < mth_source_ppla_lseen AND mth_source_ppla_lseen <= 18.5 => 0.0683872192,
    mth_source_ppla_lseen > 18.5                                   => 0.0013897639,
    mth_source_ppla_lseen = NULL                                   => final_score_23_c253,
                                                                      -0.0108880137);

final_score_23 := map(
    NULL < (Integer)_inq_adl_ph_industry_flag AND (Integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_23_c252,
    (Integer)_inq_adl_ph_industry_flag > 0.5                                                => 0.0677890975,
    (Integer)_inq_adl_ph_industry_flag = NULL                                               => -0.0082576497,
                                                                                               -0.0082576497);

final_score_24_c260 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandmother', 'Grandson', 'Husband', 'Neighbor', 'Parent', 'Sibling', 'Son', 'Wife']) => -0.0351056872,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By SSN', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Mother', 'Relative', 'Sister', 'Spouse', 'Subject', 'Subject at Household'])                                        => 0.0356997571,
    phone_subject_title = ''                                                                                                                                                                                                                                             => -0.0041701235,
                                                                                                                                                                                                                                                                            -0.0041701235);

final_score_24_c259 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 35 => 0.0395043372,
    mth_source_ppdid_lseen > 35                                    => -0.0659893976,
    mth_source_ppdid_lseen = NULL                                  => final_score_24_c260,
                                                                      -0.0009104529);

final_score_24_c258 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 0.5 => -0.0107709321,
    (Integer)inq_adl_firstseen_n > 0.5                                          => 0.0684264191,
    (Integer)inq_adl_firstseen_n = NULL                                         => final_score_24_c259,
                                                                                   -0.0012926739);

final_score_24_c257 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 12.5 => final_score_24_c258,
    f_inq_count_i > 12.5                           => -0.0301225880,
    f_inq_count_i = NULL                           => -0.0102527397,
                                                      -0.0102527397);

final_score_24 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 31.5 => 0.0571094440,
    mth_source_utildid_fseen > 31.5                                      => -0.0145685188,
    mth_source_utildid_fseen = NULL                                      => final_score_24_c257,
                                                                            -0.0074638419);

final_score_25_c263 := map(
    NULL < eda_num_phs_ind AND eda_num_phs_ind <= 0.5 => -0.0036631094,
    eda_num_phs_ind > 0.5                             => -0.0788991227,
    eda_num_phs_ind = NULL                            => -0.0061949888,
                                                         -0.0061949888);

final_score_25_c262 := map(
    NULL < mth_source_edadid_fseen AND mth_source_edadid_fseen <= 28.5 => 0.0830537796,
    mth_source_edadid_fseen > 28.5                                     => 0.0312796898,
    mth_source_edadid_fseen = NULL                                     => final_score_25_c263,
                                                                          -0.0043969639);

final_score_25_c265 := map(
    NULL < f_crim_rel_under500miles_cnt_i AND f_crim_rel_under500miles_cnt_i <= 3.5 => 0.0442875508,
    f_crim_rel_under500miles_cnt_i > 3.5                                            => -0.0262785092,
    f_crim_rel_under500miles_cnt_i = NULL                                           => 0.0234492512,
                                                                                       0.0234492512);

final_score_25_c264 := map(
    NULL < f_estimated_income_d AND f_estimated_income_d <= 80500 => final_score_25_c265,
    f_estimated_income_d > 80500                                  => 0.1018180202,
    f_estimated_income_d = NULL                                   => 0.0408191218,
                                                                     0.0408191218);

final_score_25 := map(
    NULL < pk_cell_indicator AND pk_cell_indicator <= 3.5 => final_score_25_c262,
    pk_cell_indicator > 3.5                               => final_score_25_c264,
    pk_cell_indicator = NULL                              => -0.0001026675,
                                                             -0.0001026675);

final_score_26_c269 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 100.5 => -0.0591302228,
    f_prevaddrageoldest_d > 100.5                                   => 0.0253666228,
    f_prevaddrageoldest_d = NULL                                    => -0.0240123355,
                                                                       -0.0240123355);

final_score_26_c268 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 16.5 => 0.0300392388,
    mth_source_ppdid_lseen > 16.5                                    => final_score_26_c269,
    mth_source_ppdid_lseen = NULL                                    => -0.0150805521,
                                                                        -0.0118955790);

final_score_26_c270 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Father', 'Grandmother', 'Mother', 'Neighbor', 'Son'])                                                                                                                                                                                                                                                          => -0.0589714529,
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Grandson', 'Husband', 'Parent', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => 0.0892919716,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                                      => 0.0348976335,
                                                                                                                                                                                                                                                                                                                                                                                     0.0348976335);

final_score_26_c267 := map(
    NULL < eda_address_match_best AND eda_address_match_best <= 0.5 => final_score_26_c268,
    eda_address_match_best > 0.5                                    => final_score_26_c270,
    eda_address_match_best = NULL                                   => -0.0089115733,
                                                                       -0.0089115733);

final_score_26 := map(
    NULL < mth_source_ppfla_lseen AND mth_source_ppfla_lseen <= 36.5 => 0.0576025488,
    mth_source_ppfla_lseen > 36.5                                    => 0.0076088205,
    mth_source_ppfla_lseen = NULL                                    => final_score_26_c267,
                                                                        -0.0048014661);

final_score_27_c272 := map(
    NULL < (Integer)_phone_match_code_z AND (Integer)_phone_match_code_z <= 0.5 => -0.0663860188,
    (Integer)_phone_match_code_z > 0.5                                          => 0.0353652457,
    (Integer)_phone_match_code_z = NULL                                         => 0.0088214376,
                                                                                   0.0088214376);

final_score_27_c275 := map(
    NULL < _pp_rule_high_vend_conf AND _pp_rule_high_vend_conf <= 0.5 => -0.0065974877,
    _pp_rule_high_vend_conf > 0.5                                     => 0.0721876220,
    _pp_rule_high_vend_conf = NULL                                    => 0.0206127195,
                                                                         0.0206127195);

final_score_27_c274 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 18.5 => final_score_27_c275,
    mth_source_ppdid_lseen > 18.5                                    => -0.0409155390,
    mth_source_ppdid_lseen = NULL                                    => -0.0103170010,
                                                                        -0.0097795898);

final_score_27_c273 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 16.5 => 0.1041342563,
    mth_source_sx_fseen > 16.5                                 => 0.0183663632,
    mth_source_sx_fseen = NULL                                 => final_score_27_c274,
                                                                  -0.0068608614);

final_score_27 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 11.5 => 0.1043467373,
    mth_source_utildid_fseen > 11.5                                      => final_score_27_c272,
    mth_source_utildid_fseen = NULL                                      => final_score_27_c273,
                                                                            -0.0038306174);

final_score_28_c279 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 0.5 => 0.0021643188,
    f_srchunvrfdphonecount_i > 0.5                                      => -0.0937607101,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0225143799,
                                                                           -0.0225143799);

final_score_28_c278 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 15.5 => 0.0625191964,
    mth_source_utildid_fseen > 15.5                                      => final_score_28_c279,
    mth_source_utildid_fseen = NULL                                      => -0.0078474706,
                                                                            -0.0073518017);

final_score_28_c280 := map(
    NULL < _eda_hhid_flag AND _eda_hhid_flag <= 0.5 => 0.0848680136,
    _eda_hhid_flag > 0.5                            => -0.0049146841,
    _eda_hhid_flag = NULL                           => 0.0388754340,
                                                       0.0388754340);

final_score_28_c277 := map(
    NULL < f_wealth_index_d AND f_wealth_index_d <= 4.5 => final_score_28_c278,
    f_wealth_index_d > 4.5                              => final_score_28_c280,
    f_wealth_index_d = NULL                             => -0.0030707013,
                                                           -0.0030707013);

final_score_28 := map(
    NULL < mth_source_inf_fseen AND mth_source_inf_fseen <= 209.5 => -0.0225564647,
    mth_source_inf_fseen > 209.5                                  => 0.0709896055,
    mth_source_inf_fseen = NULL                                   => final_score_28_c277,
                                                                     -0.0023098500);

final_score_29_c283 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 9.5 => 0.0181249566,
    f_inq_count_i > 9.5                           => -0.0257643200,
    f_inq_count_i = NULL                          => -0.0038062270,
                                                     -0.0038062270);

final_score_29_c285 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Father', 'Grandfather', 'Grandmother', 'Grandson', 'Husband', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject', 'Wife']) => -0.0292467893,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandparent', 'Mother', 'Parent', 'Spouse', 'Subject at Household'])                                                                                                                                    => 0.0361926978,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                           => -0.0191310732,
                                                                                                                                                                                                                                                                                                                          -0.0191310732);

final_score_29_c284 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 15.5 => 0.0828884539,
    mth_source_sx_fseen > 15.5                                 => 0.0147973068,
    mth_source_sx_fseen = NULL                                 => final_score_29_c285,
                                                                  -0.0139539857);

final_score_29_c282 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 9.5 => 0.1131103626,
    mth_pp_app_npa_last_change_dt > 9.5                                           => final_score_29_c283,
    mth_pp_app_npa_last_change_dt = NULL                                          => final_score_29_c284,
                                                                                     -0.0076231108);

final_score_29 := map(
    NULL < f_wealth_index_d AND f_wealth_index_d <= 4.5 => final_score_29_c282,
    f_wealth_index_d > 4.5                              => 0.0553362545,
    f_wealth_index_d = NULL                             => -0.0016982572,
                                                           -0.0016982572);

final_score_30_c287 := map(
    NULL < f_inq_addrs_per_ssn_i AND f_inq_addrs_per_ssn_i <= 0.5 => 0.0675986691,
    f_inq_addrs_per_ssn_i > 0.5                                   => -0.0131352055,
    f_inq_addrs_per_ssn_i = NULL                                  => 0.0423214598,
                                                                     0.0423214598);

final_score_30_c290 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 33.5 => 0.0065697728,
    mth_source_ppdid_lseen > 33.5                                    => -0.0535666718,
    mth_source_ppdid_lseen = NULL                                    => -0.0206190691,
                                                                        -0.0180317930);

final_score_30_c289 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 6.5 => 0.0522681133,
    mth_source_rel_fseen > 6.5                                  => -0.0037730904,
    mth_source_rel_fseen = NULL                                 => final_score_30_c290,
                                                                   -0.0162357853);

final_score_30_c288 := map(
    NULL < eda_address_match_best AND eda_address_match_best <= 0.5 => final_score_30_c289,
    eda_address_match_best > 0.5                                    => 0.0537320356,
    eda_address_match_best = NULL                                   => -0.0115205421,
                                                                       -0.0115205421);

final_score_30 := map(
    NULL < mth_source_ppfla_lseen AND mth_source_ppfla_lseen <= 52 => final_score_30_c287,
    mth_source_ppfla_lseen > 52                                    => -0.0114123825,
    mth_source_ppfla_lseen = NULL                                  => final_score_30_c288,
                                                                      -0.0080057389);

final_score_31_c295 := map(
    NULL < _pp_src_all_uw AND _pp_src_all_uw <= 0.5 => 0.0007191601,
    _pp_src_all_uw > 0.5                            => 0.1031542040,
    _pp_src_all_uw = NULL                           => 0.0041473744,
                                                       0.0041473744);

final_score_31_c294 := map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i <= 0.5 => 0.0543507846,
    f_rel_criminal_count_i > 0.5                                    => final_score_31_c295,
    f_rel_criminal_count_i = NULL                                   => 0.0146766799,
                                                                       0.0146766799);

final_score_31_c293 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Vehicle', 'Brother', 'Child', 'Grandson', 'Husband', 'Neighbor'])                                                                                                                                                                                => -0.0316139271,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Mother', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_31_c294,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                 => -0.0009776965,
                                                                                                                                                                                                                                                                                                                                                -0.0009776965);

final_score_31_c292 := map(
    (exp_source in ['', 'P']) => final_score_31_c293,
    (exp_source in ['S'])     => 0.0383706571,
    exp_source = ''           => 0.0041393271,
                                 0.0041393271);

final_score_31 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 18.5 => final_score_31_c292,
    f_inq_count_i > 18.5                           => -0.0319090620,
    f_inq_count_i = NULL                           => -0.0025926817,
                                                      -0.0025926817);

final_score_32_c299 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 5.5 => 0.0249853048,
    f_srchvelocityrisktype_i > 5.5                                      => -0.0377339282,
    f_srchvelocityrisktype_i = NULL                                     => 0.0010269964,
                                                                           0.0010269964);

final_score_32_c298 := map(
    NULL < (Integer)inq_lastseen_n AND (Integer)inq_lastseen_n <= 3.5 => 0.0738064508,
    (Integer)inq_lastseen_n > 3.5                                     => -0.0234249318,
    (Integer)inq_lastseen_n = NULL                                    => final_score_32_c299,
                                                                         -0.0073927514);

final_score_32_c297 := map(
    (pp_glb_dppa_fl in ['D', 'G'])     => final_score_32_c298,
    (pp_glb_dppa_fl in ['', 'B', 'U']) => 0.0443383941,
    pp_glb_dppa_fl = ''                => 0.0039030716,
                                          0.0039030716);

final_score_32_c300 := map(
    NULL < (Integer)_phone_match_code_n AND (Integer)_phone_match_code_n <= 0.5 => -0.0183417304,
    (Integer)_phone_match_code_n > 0.5                                          => 0.0230219294,
    (Integer)_phone_match_code_n = NULL                                         => -0.0085209068,
                                                                                   -0.0085209068);

final_score_32 := map(
    NULL < mth_pp_datelastseen AND mth_pp_datelastseen <= 49.5 => final_score_32_c297,
    mth_pp_datelastseen > 49.5                                 => -0.0855614771,
    mth_pp_datelastseen = NULL                                 => final_score_32_c300,
                                                                  -0.0065208774);

final_score_33_c305 := map(
    (pp_source in ['CELL', 'GONG', 'IBEHAVIOR', 'INQUIRY', 'OTHER', 'PCNSR', 'THRIVE']) => -0.0391591219,
    (pp_source in ['', 'HEADER', 'INFUTOR', 'INTRADO', 'TARGUS'])                       => 0.0420921286,
    pp_source = ''                                                                      => 0.0249451458,
                                                                                           0.0249451458);

final_score_33_c304 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Father', 'Grandmother', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject'])                => -0.0135380452,
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Parent', 'Spouse', 'Subject at Household', 'Wife']) => final_score_33_c305,
    phone_subject_title = ''                                                                                                                                                                                                                                 => -0.0057835810,
                                                                                                                                                                                                                                                                -0.0057835810);

final_score_33_c303 := map(
    NULL < (Integer)_inq_adl_ph_industry_flag AND (Integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_33_c304,
    (Integer)_inq_adl_ph_industry_flag > 0.5                                                => 0.0707379489,
    (Integer)_inq_adl_ph_industry_flag = NULL                                               => -0.0042290438,
                                                                                               -0.0042290438);

final_score_33_c302 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 13.5 => 0.0874431710,
    mth_source_utildid_fseen > 13.5                                      => 0.0071450727,
    mth_source_utildid_fseen = NULL                                      => final_score_33_c303,
                                                                            -0.0017351586);

final_score_33 := map(
    NULL < mth_source_inf_fseen AND mth_source_inf_fseen <= 114.5 => -0.0636962680,
    mth_source_inf_fseen > 114.5                                  => 0.0421760343,
    mth_source_inf_fseen = NULL                                   => final_score_33_c302,
                                                                     -0.0016277304);

final_score_34_c309 := map(
    NULL < (Integer)_phone_match_code_n AND (Integer)_phone_match_code_n <= 0.5 => -0.0220709623,
    (Integer)_phone_match_code_n > 0.5                                          => 0.0238143976,
    (Integer)_phone_match_code_n = NULL                                         => -0.0108801644,
                                                                                   -0.0108801644);

final_score_34_c308 := map(
    NULL < mth_pp_datevendorlastseen AND mth_pp_datevendorlastseen <= 4.5 => 0.0110362837,
    mth_pp_datevendorlastseen > 4.5                                       => -0.0303190264,
    mth_pp_datevendorlastseen = NULL                                      => final_score_34_c309,
                                                                             -0.0118887916);

final_score_34_c310 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 87424.5 => 0.0169711044,
    f_curraddrmedianincome_d > 87424.5                                      => 0.1179952598,
    f_curraddrmedianincome_d = NULL                                         => 0.0298117167,
                                                                               0.0298117167);

final_score_34_c307 := map(
    NULL < _pp_rule_high_vend_conf AND _pp_rule_high_vend_conf <= 0.5 => final_score_34_c308,
    _pp_rule_high_vend_conf > 0.5                                     => final_score_34_c310,
    _pp_rule_high_vend_conf = NULL                                    => -0.0054491447,
                                                                         -0.0054491447);

final_score_34 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 24.5 => 0.0139981446,
    mth_source_ppth_fseen > 24.5                                   => -0.0930544896,
    mth_source_ppth_fseen = NULL                                   => final_score_34_c307,
                                                                      -0.0081589156);

final_score_35_c312 := map(
    NULL < mth_pp_datelastseen AND mth_pp_datelastseen <= 50.5 => -0.0023787144,
    mth_pp_datelastseen > 50.5                                 => -0.0983431695,
    mth_pp_datelastseen = NULL                                 => -0.0088087628,
                                                                  -0.0101896354);

final_score_35_c315 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 8.5 => -0.0255964940,
    f_corraddrnamecount_d > 8.5                                   => 0.0523831207,
    f_corraddrnamecount_d = NULL                                  => -0.0047443502,
                                                                     -0.0047443502);

final_score_35_c314 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 7.5 => 0.0528814749,
    f_inq_count_i > 7.5                           => final_score_35_c315,
    f_inq_count_i = NULL                          => 0.0182621579,
                                                     0.0182621579);

final_score_35_c313 := map(
    (phone_subject_title in ['Associate', 'Brother', 'Daughter', 'Father', 'Grandmother', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sister', 'Son', 'Subject', 'Subject at Household', 'Wife'])                                                                                => final_score_35_c314,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Grandson', 'Sibling', 'Spouse']) => 0.1311835730,
    phone_subject_title = ''                                                                                                                                                                                                                                                                 => 0.0286871721,
                                                                                                                                                                                                                                                                                                0.0286871721);

final_score_35 := map(
    (exp_source in ['', 'P']) => final_score_35_c312,
    (exp_source in ['S'])     => final_score_35_c313,
    exp_source = ''           => -0.0046103610,
                                 -0.0046103610);

final_score_36_c320 := map(
    NULL < f_estimated_income_d AND f_estimated_income_d <= 78500 => -0.0184658272,
    f_estimated_income_d > 78500                                  => 0.0872658141,
    f_estimated_income_d = NULL                                   => 0.0078418086,
                                                                     0.0078418086);

final_score_36_c319 := map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i <= 1.5 => 0.0710896011,
    f_crim_rel_under25miles_cnt_i > 1.5                                           => final_score_36_c320,
    f_crim_rel_under25miles_cnt_i = NULL                                          => 0.0452266472,
                                                                                     0.0452266472);

final_score_36_c318 := map(
    (eda_pfrd_address_ind in ['1A'])                         => -0.0210706507,
    (eda_pfrd_address_ind in ['1B', '1C', '1D', '1E', 'XX']) => final_score_36_c319,
    eda_pfrd_address_ind = ''                                => 0.0119662791,
                                                                0.0119662791);

final_score_36_c317 := map(
    NULL < f_prevaddrstatus_i AND f_prevaddrstatus_i <= 2.5 => -0.0133236462,
    f_prevaddrstatus_i > 2.5                                => -0.0078539989,
    f_prevaddrstatus_i = NULL                               => final_score_36_c318,
                                                               -0.0053526713);

final_score_36 := map(
    NULL < eda_avg_days_connected_ind AND eda_avg_days_connected_ind <= 665 => final_score_36_c317,
    eda_avg_days_connected_ind > 665                                        => 0.0858020192,
    eda_avg_days_connected_ind = NULL                                       => -0.0041223764,
                                                                               -0.0041223764);

final_score_37_c325 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 6.5 => 0.0304070063,
    mth_pp_datevendorfirstseen > 6.5                                        => -0.0130001755,
    mth_pp_datevendorfirstseen = NULL                                       => -0.0083238013,
                                                                               -0.0065590987);

final_score_37_c324 := map(
    (pp_source in ['OTHER', 'PCNSR', 'TARGUS', 'THRIVE'])                                       => -0.1033752103,
    (pp_source in ['', 'CELL', 'GONG', 'HEADER', 'IBEHAVIOR', 'INFUTOR', 'INQUIRY', 'INTRADO']) => final_score_37_c325,
    pp_source = ''                                                                              => -0.0081010748,
                                                                                                   -0.0081010748);

final_score_37_c323 := map(
    NULL < f_wealth_index_d AND f_wealth_index_d <= 4.5 => final_score_37_c324,
    f_wealth_index_d > 4.5                              => 0.0442139006,
    f_wealth_index_d = NULL                             => -0.0033585613,
                                                           -0.0033585613);

final_score_37_c322 := map(
    (exp_source in ['P'])     => -0.0523497309,
    (exp_source in ['', 'S']) => final_score_37_c323,
    exp_source = ''           => -0.0055429210,
                                 -0.0055429210);

final_score_37 := map(
    NULL < mth_source_sp_lseen AND mth_source_sp_lseen <= 1.5 => 0.0924903386,
    mth_source_sp_lseen > 1.5                                 => 0.0350295248,
    mth_source_sp_lseen = NULL                                => final_score_37_c322,
                                                                 -0.0031711319);

final_score_38_c328 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 7.5 => 0.0368738522,
    mth_internal_ver_first_seen > 7.5                                         => -0.0005680587,
    mth_internal_ver_first_seen = NULL                                        => 0.0158535901,
                                                                                 0.0191541114);

final_score_38_c330 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 3.5 => -0.0069902639,
    f_varrisktype_i > 3.5                             => -0.0828184762,
    f_varrisktype_i = NULL                            => -0.0140420264,
                                                         -0.0140420264);

final_score_38_c329 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 6.5 => 0.0653709445,
    mth_eda_dt_first_seen > 6.5                                   => -0.0154543499,
    mth_eda_dt_first_seen = NULL                                  => final_score_38_c330,
                                                                     -0.0101970390);

final_score_38_c327 := map(
    NULL < f_rel_ageover20_count_d AND f_rel_ageover20_count_d <= 11.5 => final_score_38_c328,
    f_rel_ageover20_count_d > 11.5                                     => final_score_38_c329,
    f_rel_ageover20_count_d = NULL                                     => 0.0037894907,
                                                                          0.0037894907);

final_score_38 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Vehicle', 'Child', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Son'])                                                                                                  => -0.0638727138,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Daughter', 'Father', 'Grandchild', 'Grandfather', 'Husband', 'Mother', 'Relative', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_38_c327,
    phone_subject_title = ''                                                                                                                                                                                                                                                                          => -0.0075378125,
                                                                                                                                                                                                                                                                                                         -0.0075378125);

final_score_39_c335 := map(
    NULL < pp_app_ind_ph_cnt AND pp_app_ind_ph_cnt <= 1.5 => -0.0181700649,
    pp_app_ind_ph_cnt > 1.5                               => 0.0833095816,
    pp_app_ind_ph_cnt = NULL                              => 0.0471411948,
                                                             0.0471411948);

final_score_39_c334 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 9.5 => final_score_39_c335,
    mth_internal_ver_first_seen > 9.5                                         => -0.0154002736,
    mth_internal_ver_first_seen = NULL                                        => -0.0307343068,
                                                                                 0.0140661516);

final_score_39_c333 := map(
    NULL < _pp_rule_high_vend_conf AND _pp_rule_high_vend_conf <= 0.5 => -0.0293088949,
    _pp_rule_high_vend_conf > 0.5                                     => final_score_39_c334,
    _pp_rule_high_vend_conf = NULL                                    => -0.0087100452,
                                                                         -0.0087100452);

final_score_39_c332 := map(
    (pp_origlistingtype in ['B', 'R', 'RB']) => final_score_39_c333,
    (pp_origlistingtype in ['', 'BG'])       => 0.0392497940,
    pp_origlistingtype = ''                  => 0.0110183801,
                                                0.0110183801);

final_score_39 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 11.5 => final_score_39_c332,
    mth_pp_first_build_date > 11.5                                     => -0.0311030989,
    mth_pp_first_build_date = NULL                                     => 0.0026507903,
                                                                          0.0008686337);

final_score_40_c339 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 1.5 => 0.0562448757,
    f_util_adl_count_n > 1.5                                => -0.0410489338,
    f_util_adl_count_n = NULL                               => 0.0145962976,
                                                               0.0145962976);

final_score_40_c340 := map(
    NULL < eda_min_days_connected_ind AND eda_min_days_connected_ind <= 5.5 => -0.0033877057,
    eda_min_days_connected_ind > 5.5                                        => -0.0917072845,
    eda_min_days_connected_ind = NULL                                       => -0.0061622748,
                                                                               -0.0061622748);

final_score_40_c338 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 22.5 => 0.0585964022,
    mth_source_sx_fseen > 22.5                                 => final_score_40_c339,
    mth_source_sx_fseen = NULL                                 => final_score_40_c340,
                                                                  -0.0040440608);

final_score_40_c337 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 9.5 => 0.0160549651,
    mth_source_rel_fseen > 9.5                                  => 0.0484578937,
    mth_source_rel_fseen = NULL                                 => final_score_40_c338,
                                                                   -0.0025942069);

final_score_40 := map(
    NULL < _pp_rule_ins_ver_above AND _pp_rule_ins_ver_above <= 0.5 => final_score_40_c337,
    _pp_rule_ins_ver_above > 0.5                                    => 0.0594119247,
    _pp_rule_ins_ver_above = NULL                                   => -0.0001910470,
                                                                       -0.0001910470);

final_score_41_c344 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 8.5 => 0.0226603054,
    mth_internal_ver_first_seen > 8.5                                         => -0.0305491849,
    mth_internal_ver_first_seen = NULL                                        => -0.0041843252,
                                                                                 0.0004228351);

final_score_41_c343 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 9.5 => final_score_41_c344,
    f_inq_count_i > 9.5                           => -0.0254930222,
    f_inq_count_i = NULL                          => -0.0104998935,
                                                     -0.0104998935);

final_score_41_c342 := map(
    NULL < f_wealth_index_d AND f_wealth_index_d <= 4.5 => final_score_41_c343,
    f_wealth_index_d > 4.5                              => 0.0418991845,
    f_wealth_index_d = NULL                             => -0.0056264973,
                                                           -0.0056264973);

final_score_41_c345 := map(
    NULL < (Integer)inq_lastseen_n AND (Integer)inq_lastseen_n <= 7.5 => 0.0949986848,
    (Integer)inq_lastseen_n > 7.5                                     => -0.0089406332,
    (Integer)inq_lastseen_n = NULL                                    => 0.0536547925,
                                                                         0.0536547925);

final_score_41 := map(
    NULL < (Integer)_inq_adl_ph_industry_flag AND (Integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_41_c342,
    (Integer)_inq_adl_ph_industry_flag > 0.5                                                => final_score_41_c345,
    (Integer)_inq_adl_ph_industry_flag = NULL                                               => -0.0036519224,
                                                                                               -0.0036519224);

final_score_42_c349 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 18.5 => 0.0437767294,
    f_inq_count_i > 18.5                           => -0.0213381324,
    f_inq_count_i = NULL                           => 0.0342077613,
                                                      0.0342077613);

final_score_42_c348 := map(
    NULL < pp_did_score AND pp_did_score <= 99.5 => final_score_42_c349,
    pp_did_score > 99.5                          => -0.0236066735,
    pp_did_score = NULL                          => 0.0253606249,
                                                    0.0253606249);

final_score_42_c347 := map(
    (phone_subject_title in ['Brother', 'Child', 'Daughter', 'Grandfather', 'Grandmother', 'Grandson', 'Neighbor', 'Parent', 'Son', 'Spouse'])                                                                                                                                                                                                              => -0.0586355446,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Father', 'Grandchild', 'Granddaughter', 'Grandparent', 'Husband', 'Mother', 'Relative', 'Sibling', 'Sister', 'Subject', 'Subject at Household', 'Wife']) => final_score_42_c348,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                => 0.0060150504,
                                                                                                                                                                                                                                                                                                                                                               0.0060150504);

final_score_42_c350 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 4.5 => 0.0472211786,
    mth_source_ppdid_lseen > 4.5                                    => -0.0274141997,
    mth_source_ppdid_lseen = NULL                                   => -0.0099440654,
                                                                       -0.0130243727);

final_score_42 := map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i <= 1.5 => final_score_42_c347,
    f_rel_criminal_count_i > 1.5                                    => final_score_42_c350,
    f_rel_criminal_count_i = NULL                                   => -0.0058386172,
                                                                       -0.0058386172);

final_score_43_c353 := map(
    (phone_subject_title in ['Father', 'Grandmother', 'Husband', 'Neighbor', 'Sister'])                                                                                                                                                                                                                                                                                                                            => -0.0743785775,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Grandson', 'Mother', 'Parent', 'Relative', 'Sibling', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => 0.0602926822,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                                                                       => 0.0266985387,
                                                                                                                                                                                                                                                                                                                                                                                                                      0.0266985387);

final_score_43_c352 := map(
    NULL < eda_address_match_best AND eda_address_match_best <= 0.5 => -0.0112497832,
    eda_address_match_best > 0.5                                    => final_score_43_c353,
    eda_address_match_best = NULL                                   => -0.0087084023,
                                                                       -0.0087084023);

final_score_43_c355 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 7.5 => 0.0735266800,
    mth_internal_ver_first_seen > 7.5                                         => 0.0140963876,
    mth_internal_ver_first_seen = NULL                                        => 0.0325236751,
                                                                                 0.0441286651);

final_score_43_c354 := map(
    NULL < pp_app_ind_ph_cnt AND pp_app_ind_ph_cnt <= 1.5 => -0.0184081140,
    pp_app_ind_ph_cnt > 1.5                               => final_score_43_c355,
    pp_app_ind_ph_cnt = NULL                              => 0.0207522972,
                                                             0.0207522972);

final_score_43 := map(
    NULL < _pp_rule_high_vend_conf AND _pp_rule_high_vend_conf <= 0.5 => final_score_43_c352,
    _pp_rule_high_vend_conf > 0.5                                     => final_score_43_c354,
    _pp_rule_high_vend_conf = NULL                                    => -0.0041411913,
                                                                         -0.0041411913);

final_score_44_c358 := map(
    NULL < _pp_rule_f1_ver_above AND _pp_rule_f1_ver_above <= 0.5 => -0.0256505500,
    _pp_rule_f1_ver_above > 0.5                                   => 0.0225952675,
    _pp_rule_f1_ver_above = NULL                                  => -0.0198935274,
                                                                     -0.0198935274);

final_score_44_c359 := map(
    NULL < (Integer)_phone_match_code_n AND (Integer)_phone_match_code_n <= 0.5 => 0.0013026537,
    (Integer)_phone_match_code_n > 0.5                                          => 0.0621998412,
    (Integer)_phone_match_code_n = NULL                                         => 0.0075099644,
                                                                                   0.0075099644);

final_score_44_c357 := map(
    (phone_subject_title in ['Associate By SSN', 'Associate By Vehicle', 'Child', 'Grandfather', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Sister', 'Subject'])                                                                                                                                      => final_score_44_c358,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Brother', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Parent', 'Relative', 'Sibling', 'Son', 'Spouse', 'Subject at Household', 'Wife']) => final_score_44_c359,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                            => -0.0076681877,
                                                                                                                                                                                                                                                                                                                           -0.0076681877);

final_score_44_c360 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Shared Associates', 'Brother', 'Daughter', 'Grandfather', 'Grandmother', 'Husband', 'Neighbor', 'Sibling', 'Son', 'Wife'])                                                                                    => -0.0425654552,
    (phone_subject_title in ['Associate By Address', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandparent', 'Grandson', 'Mother', 'Parent', 'Relative', 'Sister', 'Spouse', 'Subject', 'Subject at Household']) => 0.0546730069,
    phone_subject_title = ''                                                                                                                                                                                                                                                                   => 0.0279935092,
                                                                                                                                                                                                                                                                                                  0.0279935092);

final_score_44 := map(
    NULL < r_paw_active_phone_ct_d AND r_paw_active_phone_ct_d <= 0.5 => final_score_44_c357,
    r_paw_active_phone_ct_d > 0.5                                     => final_score_44_c360,
    r_paw_active_phone_ct_d = NULL                                    => -0.0032745041,
                                                                         -0.0032745041);

final_score_45_c365 := map(
    NULL < pp_src_cnt AND pp_src_cnt <= 1.5 => 0.0440180560,
    pp_src_cnt > 1.5                        => 0.1353341988,
    pp_src_cnt = NULL                       => 0.0634470225,
                                               0.0634470225);

final_score_45_c364 := map(
    NULL < mth_pp_orig_lastseen AND mth_pp_orig_lastseen <= 7.5 => 0.0097067311,
    mth_pp_orig_lastseen > 7.5                                  => final_score_45_c365,
    mth_pp_orig_lastseen = NULL                                 => 0.0471814150,
                                                                   0.0471814150);

final_score_45_c363 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 171.5 => -0.0030576629,
    f_prevaddrageoldest_d > 171.5                                   => final_score_45_c364,
    f_prevaddrageoldest_d = NULL                                    => 0.0126463919,
                                                                       0.0126463919);

final_score_45_c362 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 123.5 => -0.0206567940,
    mth_pp_app_npa_effective_dt > 123.5                                         => final_score_45_c363,
    mth_pp_app_npa_effective_dt = NULL                                          => 0.0002206061,
                                                                                   0.0008257109);

final_score_45 := map(
    NULL < mth_source_ppth_lseen AND mth_source_ppth_lseen <= 20.5 => 0.0242137239,
    mth_source_ppth_lseen > 20.5                                   => -0.0819491229,
    mth_source_ppth_lseen = NULL                                   => final_score_45_c362,
                                                                      -0.0017823982);

final_score_46_c368 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 14.5 => -0.0058940158,
    mth_source_ppdid_lseen > 14.5                                    => 0.1020295800,
    mth_source_ppdid_lseen = NULL                                    => 0.0734701036,
                                                                        0.0584995965);

final_score_46_c370 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 92061 => 0.0244352052,
    f_curraddrmedianincome_d > 92061                                      => 0.1176194833,
    f_curraddrmedianincome_d = NULL                                       => 0.0342997034,
                                                                             0.0342997034);

final_score_46_c369 := map(
    NULL < mth_pp_datefirstseen AND mth_pp_datefirstseen <= 91.5 => final_score_46_c370,
    mth_pp_datefirstseen > 91.5                                  => -0.0525543536,
    mth_pp_datefirstseen = NULL                                  => -0.0031983346,
                                                                    0.0097128076);

final_score_46_c367 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 0.5 => -0.0119572031,
    (Integer)inq_adl_firstseen_n > 0.5                                          => final_score_46_c368,
    (Integer)inq_adl_firstseen_n = NULL                                         => final_score_46_c369,
                                                                                   0.0038503248);

final_score_46 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 5.5 => final_score_46_c367,
    f_srchvelocityrisktype_i > 5.5                                      => -0.0199050604,
    f_srchvelocityrisktype_i = NULL                                     => -0.0049693216,
                                                                           -0.0049693216);

final_score_47_c374 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 120.5 => -0.0351944266,
    f_prevaddrcartheftindex_i > 120.5                                       => 0.0537401502,
    f_prevaddrcartheftindex_i = NULL                                        => 0.0084927339,
                                                                               0.0084927339);

final_score_47_c373 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 199728.5 => final_score_47_c374,
    f_curraddrmedianvalue_d > 199728.5                                     => 0.0915753052,
    f_curraddrmedianvalue_d = NULL                                         => 0.0372978661,
                                                                              0.0372978661);

final_score_47_c375 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Granddaughter', 'Grandmother', 'Grandson', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Sister', 'Son', 'Subject', 'Wife']) => -0.0090002437,
    (phone_subject_title in ['Associate By Business', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Grandfather', 'Grandparent', 'Mother', 'Sibling', 'Spouse', 'Subject at Household'])            => 0.0342787667,
    phone_subject_title = ''                                                                                                                                                                                                                               => -0.0037125617,
                                                                                                                                                                                                                                                              -0.0037125617);

final_score_47_c372 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 31.5 => final_score_47_c373,
    mth_source_utildid_fseen > 31.5                                      => -0.0127725998,
    mth_source_utildid_fseen = NULL                                      => final_score_47_c375,
                                                                            -0.0022917200);

final_score_47 := map(
    NULL < mth_source_ppla_lseen AND mth_source_ppla_lseen <= 18.5 => 0.0304817489,
    mth_source_ppla_lseen > 18.5                                   => -0.0412222827,
    mth_source_ppla_lseen = NULL                                   => final_score_47_c372,
                                                                      -0.0021728441);

final_score_48_c379 := map(
    (pp_source in ['CELL', 'GONG', 'INTRADO', 'OTHER', 'TARGUS', 'THRIVE'])   => -0.0851386579,
    (pp_source in ['', 'HEADER', 'IBEHAVIOR', 'INFUTOR', 'INQUIRY', 'PCNSR']) => -0.0040345908,
    pp_source = ''                                                            => -0.0057360748,
                                                                                 -0.0057360748);

final_score_48_c378 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 62.5 => 0.0235751533,
    mth_source_ppth_fseen > 62.5                                   => -0.1164796855,
    mth_source_ppth_fseen = NULL                                   => final_score_48_c379,
                                                                      -0.0074690758);

final_score_48_c377 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 12.5 => 0.0679980511,
    mth_source_utildid_fseen > 12.5                                      => -0.0011575157,
    mth_source_utildid_fseen = NULL                                      => final_score_48_c378,
                                                                            -0.0057889712);

final_score_48_c380 := map(
    (phone_subject_title in ['Associate', 'Father', 'Grandmother', 'Husband', 'Mother', 'Neighbor', 'Son', 'Subject'])                                                                                                                                                                                                                                                              => 0.0236995518,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Grandson', 'Parent', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject at Household', 'Wife']) => 0.1065114547,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                                        => 0.0464596943,
                                                                                                                                                                                                                                                                                                                                                                                       0.0464596943);

final_score_48 := map(
    NULL < eda_address_match_best AND eda_address_match_best <= 0.5 => final_score_48_c377,
    eda_address_match_best > 0.5                                    => final_score_48_c380,
    eda_address_match_best = NULL                                   => -0.0027288401,
                                                                       -0.0027288401);

final_score_49_c385 := map(
    NULL < f_rel_count_i AND f_rel_count_i <= 9.5 => 0.1143923748,
    f_rel_count_i > 9.5                           => -0.0052715420,
    f_rel_count_i = NULL                          => 0.0376753239,
                                                     0.0376753239);

final_score_49_c384 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 89445.5 => -0.0170937723,
    f_curraddrmedianincome_d > 89445.5                                      => final_score_49_c385,
    f_curraddrmedianincome_d = NULL                                         => -0.0115488265,
                                                                               -0.0115488265);

final_score_49_c383 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 8.5 => 0.0639742269,
    mth_pp_app_npa_last_change_dt > 8.5                                           => final_score_49_c384,
    mth_pp_app_npa_last_change_dt = NULL                                          => -0.0073951572,
                                                                                     -0.0079759067);

final_score_49_c382 := map(
    NULL < _pp_rule_ins_ver_above AND _pp_rule_ins_ver_above <= 0.5 => final_score_49_c383,
    _pp_rule_ins_ver_above > 0.5                                    => 0.0478060091,
    _pp_rule_ins_ver_above = NULL                                   => -0.0057674365,
                                                                       -0.0057674365);

final_score_49 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 12.5 => 0.0227859818,
    mth_source_rel_fseen > 12.5                                  => 0.0532018246,
    mth_source_rel_fseen = NULL                                  => final_score_49_c382,
                                                                    -0.0041037077);

final_score_50_c387 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 83.5 => -0.0517203676,
    f_prevaddrageoldest_d > 83.5                                   => 0.0443663395,
    f_prevaddrageoldest_d = NULL                                   => 0.0115498411,
                                                                      0.0115498411);

final_score_50_c390 := map(
    NULL < f_prevaddrstatus_i AND f_prevaddrstatus_i <= 2.5 => -0.0023065170,
    f_prevaddrstatus_i > 2.5                                => 0.0555681408,
    f_prevaddrstatus_i = NULL                               => 0.0652217118,
                                                               0.0300002756);

final_score_50_c389 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 7.5 => final_score_50_c390,
    mth_internal_ver_first_seen > 7.5                                         => 0.0100412074,
    mth_internal_ver_first_seen = NULL                                        => -0.0094193120,
                                                                                 0.0027522591);

final_score_50_c388 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 38.5 => -0.0204659753,
    f_mos_inq_banko_cm_lseen_d > 38.5                                        => final_score_50_c389,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => -0.0064971573,
                                                                                -0.0064971573);

final_score_50 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 12.5 => 0.0858767351,
    mth_source_sx_fseen > 12.5                                 => final_score_50_c387,
    mth_source_sx_fseen = NULL                                 => final_score_50_c388,
                                                                  -0.0044439649);

final_score_51_c394 := map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i <= 2.5 => 0.0448396464,
    f_crim_rel_under25miles_cnt_i > 2.5                                           => -0.0345917054,
    f_crim_rel_under25miles_cnt_i = NULL                                          => 0.0286515643,
                                                                                     0.0286515643);

final_score_51_c393 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 62.5 => final_score_51_c394,
    mth_source_ppdid_lseen > 62.5                                    => -0.0674162016,
    mth_source_ppdid_lseen = NULL                                    => 0.0130011947,
                                                                        0.0127731985);

final_score_51_c392 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 0.5 => -0.0049824660,
    (Integer)inq_adl_firstseen_n > 0.5                                          => 0.0475902218,
    (Integer)inq_adl_firstseen_n = NULL                                         => final_score_51_c393,
                                                                                   0.0075713456);

final_score_51_c395 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 6.5 => 0.0216727721,
    mth_source_ppdid_lseen > 6.5                                    => -0.0359030048,
    mth_source_ppdid_lseen = NULL                                   => -0.0163616219,
                                                                       -0.0192834366);

final_score_51 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 5.5 => final_score_51_c392,
    f_srchvelocityrisktype_i > 5.5                                      => final_score_51_c395,
    f_srchvelocityrisktype_i = NULL                                     => -0.0026504970,
                                                                           -0.0026504970);

final_score_52_c400 := map(
    NULL < f_wealth_index_d AND f_wealth_index_d <= 4.5 => -0.0053625269,
    f_wealth_index_d > 4.5                              => 0.0316672026,
    f_wealth_index_d = NULL                             => -0.0018599235,
                                                           -0.0018599235);

final_score_52_c399 := map(
    NULL < mth_source_ppth_lseen AND mth_source_ppth_lseen <= 23.5 => 0.0387204645,
    mth_source_ppth_lseen > 23.5                                   => -0.0847036442,
    mth_source_ppth_lseen = NULL                                   => final_score_52_c400,
                                                                      -0.0036174674);

final_score_52_c398 := map(
    NULL < (Integer)_inq_adl_ph_industry_flag AND (Integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_52_c399,
    (Integer)_inq_adl_ph_industry_flag > 0.5                                                => 0.0449983804,
    (Integer)_inq_adl_ph_industry_flag = NULL                                               => -0.0021095627,
                                                                                               -0.0021095627);

final_score_52_c397 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 23.5 => final_score_52_c398,
    f_inq_count24_i > 23.5                             => -0.0891025487,
    f_inq_count24_i = NULL                             => -0.0036384570,
                                                          -0.0036384570);

final_score_52 := map(
    (pp_source in ['CELL', 'GONG', 'INTRADO', 'OTHER', 'TARGUS', 'THRIVE'])   => -0.0913177762,
    (pp_source in ['', 'HEADER', 'IBEHAVIOR', 'INFUTOR', 'INQUIRY', 'PCNSR']) => final_score_52_c397,
    pp_source = ''                                                            => -0.0054406817,
                                                                                 -0.0054406817);

final_score_53_c404 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 66 => -0.0358139646,
    f_fp_prevaddrcrimeindex_i > 66                                       => 0.0362081437,
    f_fp_prevaddrcrimeindex_i = NULL                                     => 0.0125971224,
                                                                            0.0125971224);

final_score_53_c403 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -46.5 => 0.0761723568,
    f_addrchangecrimediff_i > -46.5                                     => final_score_53_c404,
    f_addrchangecrimediff_i = NULL                                      => -0.0053619001,
                                                                           0.0184804501);

final_score_53_c402 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 20.5 => final_score_53_c403,
    mth_source_ppdid_lseen > 20.5                                    => -0.0319878887,
    mth_source_ppdid_lseen = NULL                                    => -0.0009828991,
                                                                        -0.0013424330);

final_score_53_c405 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Daughter', 'Father', 'Grandfather', 'Grandmother', 'Grandson', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Subject', 'Subject at Household', 'Wife']) => -0.0142039920,
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Grandchild', 'Granddaughter', 'Grandparent', 'Husband', 'Relative', 'Son', 'Spouse'])                                                                                          => 0.1135037855,
    phone_subject_title = ''                                                                                                                                                                                                                                                                      => -0.0045687505,
                                                                                                                                                                                                                                                                                                     -0.0045687505);

final_score_53 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 239.5 => final_score_53_c402,
    r_pb_order_freq_d > 239.5                               => 0.0380370842,
    r_pb_order_freq_d = NULL                                => final_score_53_c405,
                                                               0.0003141137);

final_score_54_c409 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -2.5 => 0.0370304084,
    f_addrchangecrimediff_i > -2.5                                     => 0.0830312090,
    f_addrchangecrimediff_i = NULL                                     => 0.0059746303,
                                                                          0.0454167191);

final_score_54_c408 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 141.5 => -0.0019217524,
    mth_pp_app_npa_effective_dt > 141.5                                         => final_score_54_c409,
    mth_pp_app_npa_effective_dt = NULL                                          => 0.0243501172,
                                                                                   0.0243501172);

final_score_54_c407 := map(
    NULL < pk_cell_indicator AND pk_cell_indicator <= 0.5 => -0.0420620043,
    pk_cell_indicator > 0.5                               => final_score_54_c408,
    pk_cell_indicator = NULL                              => 0.0076439624,
                                                             0.0076439624);

final_score_54_c410 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Granddaughter', 'Grandfather', 'Grandson', 'Neighbor', 'Sister', 'Spouse', 'Subject'])                                                                                                                                                              => -0.0162234688,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Parent', 'Relative', 'Sibling', 'Son', 'Subject at Household', 'Wife']) => 0.0188154691,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                        => 0.0046552079,
                                                                                                                                                                                                                                                                                                                                       0.0046552079);

final_score_54 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 20.5 => final_score_54_c407,
    mth_source_ppdid_lseen > 20.5                                    => -0.0280181101,
    mth_source_ppdid_lseen = NULL                                    => final_score_54_c410,
                                                                        0.0015756721);

final_score_55_c415 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 10.5 => 0.0627714240,
    mth_source_ppdid_lseen > 10.5                                    => -0.0150338444,
    mth_source_ppdid_lseen = NULL                                    => 0.0145425069,
                                                                        0.0085602113);

final_score_55_c414 := map(
    (pp_origphonetype in ['O', 'V', 'W']) => final_score_55_c415,
    (pp_origphonetype in ['', 'L'])       => 0.0907801777,
    pp_origphonetype = ''                 => 0.0236251277,
                                             0.0236251277);

final_score_55_c413 := map(
    NULL < _pp_rule_high_vend_conf AND _pp_rule_high_vend_conf <= 0.5 => -0.0038316223,
    _pp_rule_high_vend_conf > 0.5                                     => final_score_55_c414,
    _pp_rule_high_vend_conf = NULL                                    => 0.0003892374,
                                                                         0.0003892374);

final_score_55_c412 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 23.5 => 0.0461044303,
    mth_source_ppth_fseen > 23.5                                   => -0.0672236368,
    mth_source_ppth_fseen = NULL                                   => final_score_55_c413,
                                                                      -0.0013558877);

final_score_55 := map(
    NULL < mth_source_inf_fseen AND mth_source_inf_fseen <= 198.5 => -0.0416426228,
    mth_source_inf_fseen > 198.5                                  => 0.0304471080,
    mth_source_inf_fseen = NULL                                   => final_score_55_c412,
                                                                     -0.0025132631);

final_score_56_c417 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 13.5 => -0.0622366623,
    f_prevaddrlenofres_d > 13.5                                  => 0.0233699335,
    f_prevaddrlenofres_d = NULL                                  => 0.0098031196,
                                                                    0.0098031196);

final_score_56_c420 := map(
    NULL < (Integer)_phone_match_code_n AND (Integer)_phone_match_code_n <= 0.5 => -0.0031278496,
    (Integer)_phone_match_code_n > 0.5                                          => 0.0400512486,
    (Integer)_phone_match_code_n = NULL                                         => 0.0015502890,
                                                                                   0.0015502890);

final_score_56_c419 := map(
    (phone_subject_title in ['Associate By SSN', 'Child', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Neighbor', 'Sibling', 'Sister', 'Subject'])                                                                                                                                                  => -0.0221756737,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Daughter', 'Father', 'Grandchild', 'Grandfather', 'Mother', 'Parent', 'Relative', 'Son', 'Spouse', 'Subject at Household', 'Wife']) => final_score_56_c420,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                  => -0.0102860639,
                                                                                                                                                                                                                                                                                                                                 -0.0102860639);

final_score_56_c418 := map(
    NULL < (Integer)_inq_adl_ph_industry_flag AND (Integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_56_c419,
    (Integer)_inq_adl_ph_industry_flag > 0.5                                                => 0.0452268832,
    (Integer)_inq_adl_ph_industry_flag = NULL                                               => -0.0089039358,
                                                                                               -0.0089039358);

final_score_56 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 12.5 => 0.0690674434,
    mth_source_utildid_fseen > 12.5                                      => final_score_56_c417,
    mth_source_utildid_fseen = NULL                                      => final_score_56_c418,
                                                                            -0.0061389174);

final_score_57_c422 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By SSN', 'Associate By Vehicle', 'Grandparent', 'Grandson', 'Neighbor', 'Spouse', 'Subject'])                                                                                                                                                                                => -0.0281583873,
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Husband', 'Mother', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject at Household', 'Wife']) => 0.0224449995,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                 => -0.0055894787,
                                                                                                                                                                                                                                                                                                                                                -0.0055894787);

final_score_57_c424 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -4761 => -0.0286506946,
    f_addrchangeincomediff_d > -4761                                      => 0.0982500011,
    f_addrchangeincomediff_d = NULL                                       => 0.0474631440,
                                                                             0.0546890608);

final_score_57_c423 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 5.5 => final_score_57_c424,
    f_srchfraudsrchcount_i > 5.5                                    => -0.0094297083,
    f_srchfraudsrchcount_i = NULL                                   => 0.0227978787,
                                                                       0.0227978787);

final_score_57_c425 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 0.5 => 0.0091579741,
    f_srchunvrfdphonecount_i > 0.5                                      => -0.0439177383,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0012691858,
                                                                           -0.0012691858);

final_score_57 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 0.5 => final_score_57_c422,
    (Integer)inq_adl_firstseen_n > 0.5                                          => final_score_57_c423,
    (Integer)inq_adl_firstseen_n = NULL                                         => final_score_57_c425,
                                                                                   -0.0003063323);

final_score_58_c428 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 62460 => -0.0174349943,
    f_prevaddrmedianincome_d > 62460                                      => 0.1051321673,
    f_prevaddrmedianincome_d = NULL                                       => 0.0178809675,
                                                                             0.0178809675);

final_score_58_c430 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Child', 'Father', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject', 'Wife']) => 0.0003393234,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By SSN', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Parent', 'Spouse', 'Subject at Household'])                                                                                                                => 0.0337846744,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                 => 0.0047639119,
                                                                                                                                                                                                                                                                                                                0.0047639119);

final_score_58_c429 := map(
    NULL < mth_source_ppla_fseen AND mth_source_ppla_fseen <= 25.5 => -0.0332831072,
    mth_source_ppla_fseen > 25.5                                   => 0.0503210206,
    mth_source_ppla_fseen = NULL                                   => final_score_58_c430,
                                                                      0.0051148091);

final_score_58_c427 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 16.5 => final_score_58_c428,
    mth_source_ppca_lseen > 16.5                                   => -0.0485121175,
    mth_source_ppca_lseen = NULL                                   => final_score_58_c429,
                                                                      0.0025493412);

final_score_58 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.199203879684916 => -0.0348819231,
    f_add_curr_mobility_index_n > 0.199203879684916                                         => final_score_58_c427,
    f_add_curr_mobility_index_n = NULL                                                      => -0.0010768125,
                                                                                               -0.0010768125);

final_score_59_c433 := map(
    NULL < (Integer)_inq_adl_ph_industry_flag AND (Integer)_inq_adl_ph_industry_flag <= 0.5 => -0.0090492062,
    (Integer)_inq_adl_ph_industry_flag > 0.5                                                => 0.0438176164,
    (Integer)_inq_adl_ph_industry_flag = NULL                                               => -0.0070437345,
                                                                                               -0.0070437345);

final_score_59_c432 := map(
    NULL < r_paw_active_phone_ct_d AND r_paw_active_phone_ct_d <= 0.5 => final_score_59_c433,
    r_paw_active_phone_ct_d > 0.5                                     => 0.0316654232,
    r_paw_active_phone_ct_d = NULL                                    => -0.0013476468,
                                                                         -0.0013476468);

final_score_59_c435 := map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i <= 1.5 => 0.0315261969,
    f_rel_criminal_count_i > 1.5                                    => -0.0139357574,
    f_rel_criminal_count_i = NULL                                   => 0.0010015258,
                                                                       0.0010015258);

final_score_59_c434 := map(
    (exp_source in ['P'])     => -0.0699429201,
    (exp_source in ['', 'S']) => final_score_59_c435,
    exp_source = ''           => -0.0016109017,
                                 -0.0016109017);

final_score_59 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 541.5 => final_score_59_c432,
    r_pb_order_freq_d > 541.5                               => 0.0783163271,
    r_pb_order_freq_d = NULL                                => final_score_59_c434,
                                                               0.0001485665);

final_score_60_c439 := map(
    NULL < f_estimated_income_d AND f_estimated_income_d <= 37500 => 0.0963098653,
    f_estimated_income_d > 37500                                  => -0.0029500837,
    f_estimated_income_d = NULL                                   => 0.0294368483,
                                                                     0.0294368483);

final_score_60_c438 := map(
    NULL < f_prevaddrstatus_i AND f_prevaddrstatus_i <= 2.5 => -0.0224326586,
    f_prevaddrstatus_i > 2.5                                => final_score_60_c439,
    f_prevaddrstatus_i = NULL                               => -0.0164010786,
                                                               -0.0067388865);

final_score_60_c440 := map(
    NULL < _pp_src_all_ib AND _pp_src_all_ib <= 0.5 => 0.0220799262,
    _pp_src_all_ib > 0.5                            => 0.0883159314,
    _pp_src_all_ib = NULL                           => 0.0342622978,
                                                       0.0342622978);

final_score_60_c437 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 6.5 => final_score_60_c438,
    f_corraddrnamecount_d > 6.5                                   => final_score_60_c440,
    f_corraddrnamecount_d = NULL                                  => 0.0089682478,
                                                                     0.0089682478);

final_score_60 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 65.5 => final_score_60_c437,
    mth_source_ppdid_lseen > 65.5                                    => -0.0660708114,
    mth_source_ppdid_lseen = NULL                                    => -0.0006781013,
                                                                        -0.0004543192);

final_score_61_c445 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 17694.5 => -0.0113078915,
    f_addrchangeincomediff_d > 17694.5                                      => 0.0450085982,
    f_addrchangeincomediff_d = NULL                                         => -0.0006112016,
                                                                               0.0023672102);

final_score_61_c444 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 89371.5 => final_score_61_c445,
    f_prevaddrmedianincome_d > 89371.5                                      => 0.0785110791,
    f_prevaddrmedianincome_d = NULL                                         => 0.0079938635,
                                                                               0.0079938635);

final_score_61_c443 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 5.5 => final_score_61_c444,
    f_inq_count24_i > 5.5                             => -0.0441047114,
    f_inq_count24_i = NULL                            => -0.0058303651,
                                                         -0.0058303651);

final_score_61_c442 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 4.5 => 0.0460245406,
    mth_source_ppdid_lseen > 4.5                                    => final_score_61_c443,
    mth_source_ppdid_lseen = NULL                                   => -0.0019156986,
                                                                       -0.0017557937);

final_score_61 := map(
    NULL < mth_source_sp_lseen AND mth_source_sp_lseen <= 1.5 => 0.0780506372,
    mth_source_sp_lseen > 1.5                                 => 0.0014249547,
    mth_source_sp_lseen = NULL                                => final_score_61_c442,
                                                                 -0.0003610449);

final_score_62_c448 := map(
    NULL < mth_source_edahistory_fseen AND mth_source_edahistory_fseen <= 61.5 => -0.0505675725,
    mth_source_edahistory_fseen > 61.5                                         => -0.0808666812,
    mth_source_edahistory_fseen = NULL                                         => -0.0021640272,
                                                                                  -0.0040658399);

final_score_62_c447 := map(
    (pp_origphoneusage in ['H', 'M', 'O', 'S']) => -0.0654727554,
    (pp_origphoneusage in ['', 'P'])            => final_score_62_c448,
    pp_origphoneusage = ''                      => -0.0059174694,
                                                   -0.0059174694);

final_score_62_c450 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Child', 'Father', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse']) => -0.0047351879,
    (phone_subject_title in ['Associate By Business', 'Associate By SSN', 'Brother', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Mother', 'Subject', 'Subject at Household', 'Wife'])              => 0.0972463588,
    phone_subject_title = ''                                                                                                                                                                                                                                => 0.0574997047,
                                                                                                                                                                                                                                                               0.0574997047);

final_score_62_c449 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 5.5 => -0.0187403658,
    f_rel_under100miles_cnt_d > 5.5                                       => final_score_62_c450,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0324362736,
                                                                             0.0324362736);

final_score_62 := map(
    NULL < r_mos_since_paw_fseen_d AND r_mos_since_paw_fseen_d <= 143.5 => final_score_62_c447,
    r_mos_since_paw_fseen_d > 143.5                                     => final_score_62_c449,
    r_mos_since_paw_fseen_d = NULL                                      => -0.0031582415,
                                                                           -0.0031582415);

final_score_63_c454 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 28.5 => -0.0233754132,
    f_mos_inq_banko_cm_lseen_d > 28.5                                        => 0.0143645003,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => 0.0046487578,
                                                                                0.0046487578);

final_score_63_c453 := map(
    (pp_did_type in ['CORE', 'NO_SSN'])                   => final_score_63_c454,
    (pp_did_type in ['', 'AMBIG', 'C_MERGE', 'INACTIVE']) => 0.1042961603,
    pp_did_type = ''                                      => 0.0084303170,
                                                             0.0084303170);

final_score_63_c452 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 16.5 => -0.0350163825,
    f_prevaddrageoldest_d > 16.5                                   => final_score_63_c453,
    f_prevaddrageoldest_d = NULL                                   => 0.0019983326,
                                                                      0.0019983326);

final_score_63_c455 := map(
    (eda_pfrd_address_ind in ['1A', '1E'])             => -0.0088016832,
    (eda_pfrd_address_ind in ['1B', '1C', '1D', 'XX']) => 0.0499215526,
    eda_pfrd_address_ind = ''                          => -0.0000841172,
                                                          -0.0000841172);

final_score_63 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 12.5 => 0.0860565981,
    mth_pp_app_npa_last_change_dt > 12.5                                           => final_score_63_c452,
    mth_pp_app_npa_last_change_dt = NULL                                           => final_score_63_c455,
                                                                                      0.0025103542);

final_score_64_c458 := map(
    NULL < f_componentcharrisktype_i AND f_componentcharrisktype_i <= 4.5 => -0.0224198080,
    f_componentcharrisktype_i > 4.5                                       => 0.0180347038,
    f_componentcharrisktype_i = NULL                                      => -0.0056285924,
                                                                             -0.0056285924);

final_score_64_c457 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 48.5 => 0.0543078630,
    mth_pp_app_npa_effective_dt > 48.5                                         => -0.0140810433,
    mth_pp_app_npa_effective_dt = NULL                                         => final_score_64_c458,
                                                                                  -0.0077013066);

final_score_64_c460 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 3.5 => 0.0710776274,
    f_inq_count_i > 3.5                           => -0.0135467590,
    f_inq_count_i = NULL                          => 0.0083990544,
                                                     0.0083990544);

final_score_64_c459 := map(
    (phone_subject_title in ['Subject', 'Subject at Household'])                                                                                                                                                                                                                                                                                                                                                                          => final_score_64_c460,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Wife']) => 0.1312506094,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                                                                                              => 0.0313601278,
                                                                                                                                                                                                                                                                                                                                                                                                                                             0.0313601278);

final_score_64 := map(
    NULL < (Integer)_internal_ver_match_hhid AND (Integer)_internal_ver_match_hhid <= 0.5 => final_score_64_c457,
    (Integer)_internal_ver_match_hhid > 0.5                                               => final_score_64_c459,
    (Integer)_internal_ver_match_hhid = NULL                                              => -0.0046735134,
                                                                                             -0.0046735134);

final_score_65_c463 := map(
    NULL < _pp_src_all_uw AND _pp_src_all_uw <= 0.5 => 0.0007959675,
    _pp_src_all_uw > 0.5                            => 0.0943731062,
    _pp_src_all_uw = NULL                           => 0.0033602338,
                                                       0.0033602338);

final_score_65_c464 := map(
    NULL < f_mos_inq_banko_om_fseen_d AND f_mos_inq_banko_om_fseen_d <= 34.5 => -0.0354341649,
    f_mos_inq_banko_om_fseen_d > 34.5                                        => 0.0426650450,
    f_mos_inq_banko_om_fseen_d = NULL                                        => 0.0332968500,
                                                                                0.0332968500);

final_score_65_c462 := map(
    (exp_source in ['', 'P']) => final_score_65_c463,
    (exp_source in ['S'])     => final_score_65_c464,
    exp_source = ''           => 0.0076485344,
                                 0.0076485344);

final_score_65_c465 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 9.5 => 0.0287946271,
    mth_source_ppdid_fseen > 9.5                                    => -0.0366372457,
    mth_source_ppdid_fseen = NULL                                   => -0.0100943062,
                                                                       -0.0153758357);

final_score_65 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 4.5 => final_score_65_c462,
    f_util_adl_count_n > 4.5                                => final_score_65_c465,
    f_util_adl_count_n = NULL                               => 0.0013841949,
                                                               0.0013841949);

final_score_66_c469 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 12.5 => -0.0605893868,
    f_prevaddrlenofres_d > 12.5                                  => 0.0373740788,
    f_prevaddrlenofres_d = NULL                                  => 0.0224824641,
                                                                    0.0224824641);

final_score_66_c470 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -179519 => 0.0719732952,
    f_addrchangevaluediff_d > -179519                                     => -0.0168894992,
    f_addrchangevaluediff_d = NULL                                        => -0.0272658638,
                                                                             -0.0164407456);

final_score_66_c468 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 3.5 => final_score_66_c469,
    f_inq_count_i > 3.5                           => final_score_66_c470,
    f_inq_count_i = NULL                          => -0.0089314087,
                                                     -0.0089314087);

final_score_66_c467 := map(
    NULL < f_estimated_income_d AND f_estimated_income_d <= 108500 => final_score_66_c468,
    f_estimated_income_d > 108500                                  => 0.0833214680,
    f_estimated_income_d = NULL                                    => -0.0059042008,
                                                                      -0.0059042008);

final_score_66 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 7.5 => 0.0711899250,
    mth_pp_app_npa_last_change_dt > 7.5                                           => final_score_66_c467,
    mth_pp_app_npa_last_change_dt = NULL                                          => 0.0015719257,
                                                                                     -0.0008863126);

final_score_67_c474 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 0.5 => 0.0590590578,
    f_srchfraudsrchcountyr_i > 0.5                                      => -0.0495541808,
    f_srchfraudsrchcountyr_i = NULL                                     => 0.0311444404,
                                                                           0.0311444404);

final_score_67_c473 := map(
    NULL < mth_source_ppfla_lseen AND mth_source_ppfla_lseen <= 6.5 => -0.0193205335,
    mth_source_ppfla_lseen > 6.5                                    => final_score_67_c474,
    mth_source_ppfla_lseen = NULL                                   => 0.0002917624,
                                                                       0.0018957163);

final_score_67_c472 := map(
    NULL < f_rel_educationover8_count_d AND f_rel_educationover8_count_d <= 25.5 => final_score_67_c473,
    f_rel_educationover8_count_d > 25.5                                          => -0.0303135287,
    f_rel_educationover8_count_d = NULL                                          => -0.0013627905,
                                                                                    -0.0013627905);

final_score_67_c475 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 7.5 => 0.0830088537,
    f_inq_count24_i > 7.5                             => -0.0098537765,
    f_inq_count24_i = NULL                            => 0.0457175612,
                                                         0.0457175612);

final_score_67 := map(
    NULL < (Integer)_inq_adl_ph_industry_flag AND (Integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_67_c472,
    (Integer)_inq_adl_ph_industry_flag > 0.5                                                => final_score_67_c475,
    (Integer)_inq_adl_ph_industry_flag = NULL                                               => 0.0001179437,
                                                                                               0.0001179437);

final_score_68_c479 := map(
    NULL < pp_did_score AND pp_did_score <= 40 => 0.0255844519,
    pp_did_score > 40                          => -0.0576971504,
    pp_did_score = NULL                        => 0.0110773341,
                                                  0.0110773341);

final_score_68_c478 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 95.5 => final_score_68_c479,
    f_prevaddrlenofres_d > 95.5                                  => 0.0561471848,
    f_prevaddrlenofres_d = NULL                                  => 0.0358247794,
                                                                    0.0358247794);

final_score_68_c477 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Grandfather', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Wife'])                                                                                                                        => -0.0442225323,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Brother', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household']) => final_score_68_c478,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                     => 0.0146357851,
                                                                                                                                                                                                                                                                                                                    0.0146357851);

final_score_68_c480 := map(
    NULL < mth_source_edahistory_fseen AND mth_source_edahistory_fseen <= 62.5 => -0.0722859816,
    mth_source_edahistory_fseen > 62.5                                         => -0.0370096104,
    mth_source_edahistory_fseen = NULL                                         => -0.0023657650,
                                                                                  -0.0040843494);

final_score_68 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 3.5 => final_score_68_c477,
    f_inq_count_i > 3.5                           => final_score_68_c480,
    f_inq_count_i = NULL                          => 0.0002503029,
                                                     0.0002503029);

final_score_69_c484 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Child', 'Daughter', 'Father', 'Grandson', 'Husband', 'Neighbor', 'Parent', 'Sibling', 'Son', 'Spouse'])                                                        => -0.0725662092,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Mother', 'Relative', 'Sister', 'Subject', 'Subject at Household', 'Wife']) => 0.0484034345,
    phone_subject_title = ''                                                                                                                                                                                                                                                     => 0.0191846129,
                                                                                                                                                                                                                                                                                    0.0191846129);

final_score_69_c483 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 91891 => -0.0064529766,
    f_curraddrmedianincome_d > 91891                                      => final_score_69_c484,
    f_curraddrmedianincome_d = NULL                                       => -0.0040989106,
                                                                             -0.0040989106);

final_score_69_c485 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 4.5 => 0.0598555471,
    f_inq_count24_i > 4.5                             => -0.0204303768,
    f_inq_count24_i = NULL                            => 0.0395368250,
                                                         0.0395368250);

final_score_69_c482 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 182 => final_score_69_c483,
    f_fp_prevaddrcrimeindex_i > 182                                       => final_score_69_c485,
    f_fp_prevaddrcrimeindex_i = NULL                                      => 0.0007890362,
                                                                             0.0007890362);

final_score_69 := map(
    NULL < _pp_rule_30 AND _pp_rule_30 <= 0.5 => final_score_69_c482,
    _pp_rule_30 > 0.5                         => -0.1033919661,
    _pp_rule_30 = NULL                        => -0.0005396715,
                                                 -0.0005396715);

final_score_70_c487 := map(
    NULL < eda_address_match_best AND eda_address_match_best <= 0.5 => -0.0461380400,
    eda_address_match_best > 0.5                                    => 0.0440439624,
    eda_address_match_best = NULL                                   => -0.0209193593,
                                                                       -0.0209193593);

final_score_70_c490 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 16.5 => 0.0222516021,
    mth_exp_last_update > 16.5                                 => -0.0482457521,
    mth_exp_last_update = NULL                                 => 0.0007680217,
                                                                  -0.0020130310);

final_score_70_c489 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 46.5 => final_score_70_c490,
    mth_pp_datevendorfirstseen > 46.5                                        => 0.0747979551,
    mth_pp_datevendorfirstseen = NULL                                        => 0.0102996939,
                                                                                0.0098787226);

final_score_70_c488 := map(
    NULL < (Integer)inq_adl_lastseen_n AND (Integer)inq_adl_lastseen_n <= 28.5 => final_score_70_c489,
    (Integer)inq_adl_lastseen_n > 28.5                                         => -0.0335317929,
    (Integer)inq_adl_lastseen_n = NULL                                         => -0.0020256230,
                                                                                  0.0025052075);

final_score_70 := map(
    NULL < mth_source_inf_fseen AND mth_source_inf_fseen <= 268.5 => final_score_70_c487,
    mth_source_inf_fseen > 268.5                                  => 0.0663208079,
    mth_source_inf_fseen = NULL                                   => final_score_70_c488,
                                                                     0.0021173933);

final_score_71_c494 := map(
    NULL < f_estimated_income_d AND f_estimated_income_d <= 87500 => 0.0060311987,
    f_estimated_income_d > 87500                                  => 0.0818231435,
    f_estimated_income_d = NULL                                   => 0.0152360970,
                                                                     0.0152360970);

final_score_71_c493 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 15.5 => final_score_71_c494,
    mth_pp_first_build_date > 15.5                                     => -0.0458950545,
    mth_pp_first_build_date = NULL                                     => -0.0031868606,
                                                                          -0.0045488395);

final_score_71_c492 := map(
    NULL < (Integer)inq_adl_lastseen_n AND (Integer)inq_adl_lastseen_n <= 29.5 => -0.0011966174,
    (Integer)inq_adl_lastseen_n > 29.5                                         => -0.0423804857,
    (Integer)inq_adl_lastseen_n = NULL                                         => final_score_71_c493,
                                                                                  -0.0047899161);

final_score_71_c495 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 14.5 => -0.0029962592,
    mth_source_ppdid_lseen > 14.5                                    => 0.0696974201,
    mth_source_ppdid_lseen = NULL                                    => 0.0132197484,
                                                                        0.0220676655);

final_score_71 := map(
    NULL < r_mos_since_paw_fseen_d AND r_mos_since_paw_fseen_d <= 65.5 => final_score_71_c492,
    r_mos_since_paw_fseen_d > 65.5                                     => final_score_71_c495,
    r_mos_since_paw_fseen_d = NULL                                     => -0.0009417152,
                                                                          -0.0009417152);

final_score_72_c499 := map(
    NULL < f_rel_bankrupt_count_i AND f_rel_bankrupt_count_i <= 1.5 => 0.0176353089,
    f_rel_bankrupt_count_i > 1.5                                    => -0.0158004871,
    f_rel_bankrupt_count_i = NULL                                   => -0.0001499441,
                                                                       -0.0001499441);

final_score_72_c498 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 1.5 => 0.0683624350,
    mth_internal_ver_first_seen > 1.5                                         => final_score_72_c499,
    mth_internal_ver_first_seen = NULL                                        => -0.0078534747,
                                                                                 -0.0038355699);

final_score_72_c497 := map(
    NULL < eda_min_days_connected_ind AND eda_min_days_connected_ind <= 54.5 => final_score_72_c498,
    eda_min_days_connected_ind > 54.5                                        => -0.0614593235,
    eda_min_days_connected_ind = NULL                                        => -0.0057857514,
                                                                                -0.0057857514);

final_score_72_c500 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Grandfather', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Son']) => -0.0008646825,
    (phone_subject_title in ['Associate By SSN', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Relative', 'Sister', 'Spouse', 'Subject', 'Subject at Household', 'Wife'])                                                      => 0.1124282150,
    phone_subject_title = ''                                                                                                                                                                                                                                                    => 0.0539143009,
                                                                                                                                                                                                                                                                                   0.0539143009);

final_score_72 := map(
    (eda_pfrd_address_ind in ['1A', '1B', '1E', 'XX']) => final_score_72_c497,
    (eda_pfrd_address_ind in ['1C', '1D'])             => final_score_72_c500,
    eda_pfrd_address_ind = ''                          => -0.0030949615,
                                                          -0.0030949615);

final_score_73_c503 := map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i <= 144 => -0.0004742763,
    f_prevaddrmurderindex_i > 144                                     => 0.0765656778,
    f_prevaddrmurderindex_i = NULL                                    => 0.0221352755,
                                                                         0.0221352755);

final_score_73_c505 := map(
    NULL < mth_source_ppth_lseen AND mth_source_ppth_lseen <= 23.5 => 0.0207655593,
    mth_source_ppth_lseen > 23.5                                   => -0.0834979902,
    mth_source_ppth_lseen = NULL                                   => 0.0118952942,
                                                                      0.0086064394);

final_score_73_c504 := map(
    (phone_subject_title in ['Associate By Vehicle', 'Daughter', 'Grandson', 'Husband', 'Neighbor', 'Sibling'])                                                                                                                                                                                                                                                                            => -0.0491413546,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Mother', 'Parent', 'Relative', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_73_c505,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                                               => -0.0008135238,
                                                                                                                                                                                                                                                                                                                                                                                              -0.0008135238);

final_score_73_c502 := map(
    NULL < mth_source_ppla_lseen AND mth_source_ppla_lseen <= 34.5 => final_score_73_c503,
    mth_source_ppla_lseen > 34.5                                   => -0.0538002688,
    mth_source_ppla_lseen = NULL                                   => final_score_73_c504,
                                                                      -0.0005163315);

final_score_73 := map(
    NULL < pp_app_ind_ph_cnt AND pp_app_ind_ph_cnt <= 11.5 => final_score_73_c502,
    pp_app_ind_ph_cnt > 11.5                               => -0.0640205794,
    pp_app_ind_ph_cnt = NULL                               => -0.0017980542,
                                                              -0.0017980542);

final_score_74_c508 := map(
    NULL < r_paw_active_phone_ct_d AND r_paw_active_phone_ct_d <= 0.5 => -0.0052175644,
    r_paw_active_phone_ct_d > 0.5                                     => 0.0461487812,
    r_paw_active_phone_ct_d = NULL                                    => 0.0012779902,
                                                                         0.0012779902);

final_score_74_c507 := map(
    NULL < mth_source_ppla_fseen AND mth_source_ppla_fseen <= 27.5 => -0.0446674427,
    mth_source_ppla_fseen > 27.5                                   => 0.0422558782,
    mth_source_ppla_fseen = NULL                                   => final_score_74_c508,
                                                                      0.0012810730);

final_score_74_c510 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 9.5 => 0.0524081272,
    mth_pp_first_build_date > 9.5                                     => -0.0159620047,
    mth_pp_first_build_date = NULL                                    => 0.0186845998,
                                                                         0.0221000663);

final_score_74_c509 := map(
    NULL < pp_did_score AND pp_did_score <= 95.5 => final_score_74_c510,
    pp_did_score > 95.5                          => -0.0470968186,
    pp_did_score = NULL                          => 0.0141751875,
                                                    0.0141751875);

final_score_74 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 13.5 => final_score_74_c507,
    f_addrchangecrimediff_i > 13.5                                     => -0.0197587967,
    f_addrchangecrimediff_i = NULL                                     => final_score_74_c509,
                                                                          -0.0008549526);

final_score_75_c515 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 19.5 => 0.0786744997,
    mth_source_ppdid_fseen > 19.5                                    => 0.0182400674,
    mth_source_ppdid_fseen = NULL                                    => 0.0113525704,
                                                                        0.0226584121);

final_score_75_c514 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.515401128013391 => final_score_75_c515,
    f_add_curr_mobility_index_n > 0.515401128013391                                         => -0.0183120158,
    f_add_curr_mobility_index_n = NULL                                                      => 0.0151651855,
                                                                                               0.0151651855);

final_score_75_c513 := map(
    NULL < _pp_rule_high_vend_conf AND _pp_rule_high_vend_conf <= 0.5 => -0.0084390239,
    _pp_rule_high_vend_conf > 0.5                                     => final_score_75_c514,
    _pp_rule_high_vend_conf = NULL                                    => -0.0046654809,
                                                                         -0.0046654809);

final_score_75_c512 := map(
    NULL < mth_pp_eda_hist_ph_dt AND mth_pp_eda_hist_ph_dt <= 19.5 => -0.0836331891,
    mth_pp_eda_hist_ph_dt > 19.5                                   => -0.0086768050,
    mth_pp_eda_hist_ph_dt = NULL                                   => final_score_75_c513,
                                                                      -0.0060574166);

final_score_75 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 182 => final_score_75_c512,
    f_fp_prevaddrcrimeindex_i > 182                                       => 0.0337943033,
    f_fp_prevaddrcrimeindex_i = NULL                                      => -0.0018279523,
                                                                             -0.0018279523);

final_score_76_c519 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 35.5 => 0.0202509864,
    mth_exp_last_update > 35.5                                 => -0.0275950633,
    mth_exp_last_update = NULL                                 => -0.0089684847,
                                                                  -0.0043544513);

final_score_76_c520 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Father', 'Grandmother', 'Grandparent', 'Grandson', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Wife']) => -0.0042749450,
    (phone_subject_title in ['Associate By Vehicle', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Husband', 'Mother', 'Parent', 'Son', 'Subject at Household'])                                                                                                                                                => 0.0526384703,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                 => 0.0017102904,
                                                                                                                                                                                                                                                                                                                                0.0017102904);

final_score_76_c518 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 1.5 => 0.0434299411,
    mth_pp_first_build_date > 1.5                                     => final_score_76_c519,
    mth_pp_first_build_date = NULL                                    => final_score_76_c520,
                                                                         0.0006428176);

final_score_76_c517 := map(
    (pp_origphoneusage in ['H', 'M', 'O']) => -0.0801623696,
    (pp_origphoneusage in ['', 'P', 'S'])  => final_score_76_c518,
    pp_origphoneusage = ''                 => -0.0005833459,
                                              -0.0005833459);

final_score_76 := map(
    NULL < eda_num_phs_connected_addr AND eda_num_phs_connected_addr <= 1.5 => final_score_76_c517,
    eda_num_phs_connected_addr > 1.5                                        => -0.1001804186,
    eda_num_phs_connected_addr = NULL                                       => -0.0018412584,
                                                                               -0.0018412584);

final_score_77_c524 := map(
    NULL < f_inq_per_ssn_i AND f_inq_per_ssn_i <= 0.5 => -0.0139479273,
    f_inq_per_ssn_i > 0.5                             => 0.0892933783,
    f_inq_per_ssn_i = NULL                            => 0.0383261515,
                                                         0.0383261515);

final_score_77_c525 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.402305741071378 => -0.0112159148,
    f_add_input_mobility_index_n > 0.402305741071378                                          => -0.0635048543,
    f_add_input_mobility_index_n = NULL                                                       => -0.0409007815,
                                                                                                 -0.0409007815);

final_score_77_c523 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 10.5 => final_score_77_c524,
    mth_source_ppca_lseen > 10.5                                   => final_score_77_c525,
    mth_source_ppca_lseen = NULL                                   => -0.0006928099,
                                                                      -0.0022416329);

final_score_77_c522 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 17.5 => 0.0502452566,
    mth_source_utildid_fseen > 17.5                                      => -0.0124922937,
    mth_source_utildid_fseen = NULL                                      => final_score_77_c523,
                                                                            -0.0017198623);

final_score_77 := map(
    NULL < mth_source_paw_lseen AND mth_source_paw_lseen <= 37.5 => 0.1135502914,
    mth_source_paw_lseen > 37.5                                  => 0.0232446271,
    mth_source_paw_lseen = NULL                                  => final_score_77_c522,
                                                                    0.0000493949);

final_score_78_c529 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -9.5 => 0.1073934329,
    f_addrchangecrimediff_i > -9.5                                     => 0.0254206318,
    f_addrchangecrimediff_i = NULL                                     => -0.0059061599,
                                                                          0.0393586293);

final_score_78_c530 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.693605636452407 => 0.0044746228,
    f_add_input_mobility_index_n > 0.693605636452407                                          => -0.0574758714,
    f_add_input_mobility_index_n = NULL                                                       => -0.0023128413,
                                                                                                 -0.0023128413);

final_score_78_c528 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 6.5 => final_score_78_c529,
    mth_pp_datevendorfirstseen > 6.5                                        => final_score_78_c530,
    mth_pp_datevendorfirstseen = NULL                                       => 0.0070783762,
                                                                               0.0063727509);

final_score_78_c527 := map(
    NULL < pp_did_score AND pp_did_score <= 37 => final_score_78_c528,
    pp_did_score > 37                          => -0.0240488878,
    pp_did_score = NULL                        => 0.0021828052,
                                                  0.0021828052);

final_score_78 := map(
    NULL < mth_source_edadid_fseen AND mth_source_edadid_fseen <= 31.5 => 0.0614106647,
    mth_source_edadid_fseen > 31.5                                     => 0.0478190304,
    mth_source_edadid_fseen = NULL                                     => final_score_78_c527,
                                                                          0.0036228982);

final_score_79_c535 := map(
    NULL < f_assocrisktype_i AND f_assocrisktype_i <= 2.5 => -0.0397417317,
    f_assocrisktype_i > 2.5                               => -0.0010649347,
    f_assocrisktype_i = NULL                              => -0.0085152261,
                                                             -0.0085152261);

final_score_79_c534 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 6.5 => 0.0211907632,
    f_rel_ageover30_count_d > 6.5                                     => final_score_79_c535,
    f_rel_ageover30_count_d = NULL                                    => 0.0001369631,
                                                                         0.0001369631);

final_score_79_c533 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 2.5 => -0.0418714782,
    f_rel_under500miles_cnt_d > 2.5                                       => final_score_79_c534,
    f_rel_under500miles_cnt_d = NULL                                      => -0.0028746512,
                                                                             -0.0028746512);

final_score_79_c532 := map(
    NULL < mth_source_sp_lseen AND mth_source_sp_lseen <= 1.5 => 0.0717283017,
    mth_source_sp_lseen > 1.5                                 => 0.0071631972,
    mth_source_sp_lseen = NULL                                => final_score_79_c533,
                                                                 -0.0017035172);

final_score_79 := map(
    NULL < mth_source_paw_lseen AND mth_source_paw_lseen <= 37.5 => 0.0924087475,
    mth_source_paw_lseen > 37.5                                  => 0.0238576822,
    mth_source_paw_lseen = NULL                                  => final_score_79_c532,
                                                                    -0.0002068580);

final_score_80_c537 := map(
    NULL < (Integer)inq_firstseen_n AND (Integer)inq_firstseen_n <= 60.5 => -0.0264234224,
    (Integer)inq_firstseen_n > 60.5                                      => -0.0860096144,
    (Integer)inq_firstseen_n = NULL                                      => 0.0005223089,
                                                                            -0.0171437713);

final_score_80_c539 := map(
    NULL < (Integer)f_adl_util_misc_n AND (Integer)f_adl_util_misc_n <= 0.5 => 0.0795394023,
    (Integer)f_adl_util_misc_n > 0.5                                        => -0.0102535207,
    (Integer)f_adl_util_misc_n = NULL                                       => 0.0372151339,
                                                                               0.0372151339);

final_score_80_c538 := map(
    NULL < f_rel_incomeover100_count_d AND f_rel_incomeover100_count_d <= 1.5 => 0.0009795819,
    f_rel_incomeover100_count_d > 1.5                                         => final_score_80_c539,
    f_rel_incomeover100_count_d = NULL                                        => 0.0078373700,
                                                                                 0.0078373700);

final_score_80_c540 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Vehicle', 'Brother', 'Grandfather', 'Grandparent', 'Grandson', 'Neighbor', 'Sister', 'Son', 'Spouse', 'Subject', 'Wife'])                                      => -0.0169005532,
    (phone_subject_title in ['Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Husband', 'Mother', 'Parent', 'Relative', 'Sibling', 'Subject at Household']) => 0.0254366611,
    phone_subject_title = ''                                                                                                                                                                                                                                            => -0.0029326441,
                                                                                                                                                                                                                                                                           -0.0029326441);

final_score_80 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 150.5 => final_score_80_c537,
    mth_pp_app_npa_effective_dt > 150.5                                         => final_score_80_c538,
    mth_pp_app_npa_effective_dt = NULL                                          => final_score_80_c540,
                                                                                   -0.0031275997);

final_score_81_c543 := map(
    (phone_subject_title in ['Associate By Vehicle', 'Brother', 'Mother', 'Parent', 'Sister', 'Subject'])                                                                                                                                                                                                                                                                                        => 0.0248697859,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Neighbor', 'Relative', 'Sibling', 'Son', 'Spouse', 'Subject at Household', 'Wife']) => 0.1331886180,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                                                     => 0.0472420060,
                                                                                                                                                                                                                                                                                                                                                                                                    0.0472420060);

final_score_81_c545 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.205344500940803 => -0.0382894306,
    f_add_curr_mobility_index_n > 0.205344500940803                                         => 0.0282776900,
    f_add_curr_mobility_index_n = NULL                                                      => 0.0206027137,
                                                                                               0.0206027137);

final_score_81_c544 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 168.5 => -0.0159848802,
    mth_pp_app_npa_effective_dt > 168.5                                         => final_score_81_c545,
    mth_pp_app_npa_effective_dt = NULL                                          => 0.0134213733,
                                                                                   0.0069718225);

final_score_81_c542 := map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 4.5 => final_score_81_c543,
    f_rel_homeover50_count_d > 4.5                                      => final_score_81_c544,
    f_rel_homeover50_count_d = NULL                                     => 0.0113755448,
                                                                           0.0113755448);

final_score_81 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By SSN', 'Granddaughter', 'Grandmother', 'Grandson', 'Neighbor', 'Subject at Household'])                                                                                                                                                                                        => -0.0176123204,
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Grandfather', 'Grandparent', 'Husband', 'Mother', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Wife']) => final_score_81_c542,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                     => 0.0014903812,
                                                                                                                                                                                                                                                                                                                                                    0.0014903812);

final_score_82_c550 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -1 => -0.0152076900,
    f_addrchangecrimediff_i > -1                                     => 0.0346551159,
    f_addrchangecrimediff_i = NULL                                   => -0.0071156941,
                                                                        0.0062825603);

final_score_82_c549 := map(
    NULL < mth_pp_datefirstseen AND mth_pp_datefirstseen <= 90.5 => final_score_82_c550,
    mth_pp_datefirstseen > 90.5                                  => -0.0784965247,
    mth_pp_datefirstseen = NULL                                  => -0.0134613055,
                                                                    -0.0073341498);

final_score_82_c548 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 0.5 => -0.0062865148,
    (Integer)inq_adl_firstseen_n > 0.5                                          => 0.0205537379,
    (Integer)inq_adl_firstseen_n = NULL                                         => final_score_82_c549,
                                                                                   -0.0037000997);

final_score_82_c547 := map(
    NULL < mth_pp_date_nonglb_lastseen AND mth_pp_date_nonglb_lastseen <= 82.5 => -0.0691252929,
    mth_pp_date_nonglb_lastseen > 82.5                                         => 0.0379143662,
    mth_pp_date_nonglb_lastseen = NULL                                         => final_score_82_c548,
                                                                                  -0.0044419231);

final_score_82 := map(
    NULL < (Integer)_phone_match_code_d AND (Integer)_phone_match_code_d <= 0.5 => final_score_82_c547,
    (Integer)_phone_match_code_d > 0.5                                          => 0.0631459674,
    (Integer)_phone_match_code_d = NULL                                         => -0.0023664158,
                                                                                   -0.0023664158);

final_score_83_c555 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.275977644119237 => 0.0659486417,
    f_add_curr_mobility_index_n > 0.275977644119237                                         => -0.0139554195,
    f_add_curr_mobility_index_n = NULL                                                      => 0.0104812594,
                                                                                               0.0104812594);

final_score_83_c554 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 59.5 => -0.0235104063,
    r_pb_order_freq_d > 59.5                               => final_score_83_c555,
    r_pb_order_freq_d = NULL                               => 0.0036938320,
                                                              -0.0061669341);

final_score_83_c553 := map(
    (pp_did_type in ['C_MERGE', 'CORE'])                 => final_score_83_c554,
    (pp_did_type in ['', 'AMBIG', 'INACTIVE', 'NO_SSN']) => 0.0853811347,
    pp_did_type = ''                                     => -0.0026714098,
                                                            -0.0026714098);

final_score_83_c552 := map(
    NULL < f_componentcharrisktype_i AND f_componentcharrisktype_i <= 2.5 => 0.0553365680,
    f_componentcharrisktype_i > 2.5                                       => final_score_83_c553,
    f_componentcharrisktype_i = NULL                                      => 0.0014756592,
                                                                             0.0014756592);

final_score_83 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 3.5 => 0.0550475653,
    mth_eda_dt_first_seen > 3.5                                   => -0.0087337364,
    mth_eda_dt_first_seen = NULL                                  => final_score_83_c552,
                                                                     -0.0024605281);

final_score_84_c559 := map(
    NULL < (Integer)f_util_add_input_conv_n AND (Integer)f_util_add_input_conv_n <= 0.5 => 0.0488311779,
    (Integer)f_util_add_input_conv_n > 0.5                                              => 0.0017709499,
    (Integer)f_util_add_input_conv_n = NULL                                             => 0.0225507909,
                                                                                           0.0225507909);

final_score_84_c558 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 2.5 => final_score_84_c559,
    f_srchfraudsrchcount_i > 2.5                                    => -0.0122391002,
    f_srchfraudsrchcount_i = NULL                                   => 0.0059147100,
                                                                       0.0059147100);

final_score_84_c560 := map(
    NULL < (Integer)inq_adl_lastseen_n AND (Integer)inq_adl_lastseen_n <= 13.5 => -0.0065033666,
    (Integer)inq_adl_lastseen_n > 13.5                                         => 0.0662963543,
    (Integer)inq_adl_lastseen_n = NULL                                         => 0.0014030231,
                                                                                  -0.0014789847);

final_score_84_c557 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 9.5 => final_score_84_c558,
    mth_internal_ver_first_seen > 9.5                                         => -0.0277582563,
    mth_internal_ver_first_seen = NULL                                        => final_score_84_c560,
                                                                                 -0.0010986765);

final_score_84 := map(
    NULL < f_srchssnsrchcount_i AND f_srchssnsrchcount_i <= 28.5 => final_score_84_c557,
    f_srchssnsrchcount_i > 28.5                                  => -0.0741090246,
    f_srchssnsrchcount_i = NULL                                  => -0.0027171102,
                                                                    -0.0027171102);

final_score_85_c563 := map(
    NULL < mth_source_ppca_fseen AND mth_source_ppca_fseen <= 15.5 => -0.0798824749,
    mth_source_ppca_fseen > 15.5                                   => 0.0075795728,
    mth_source_ppca_fseen = NULL                                   => -0.0161306328,
                                                                      -0.0166568935);

final_score_85_c562 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 437001 => final_score_85_c563,
    f_prevaddrmedianvalue_d > 437001                                     => 0.0446530695,
    f_prevaddrmedianvalue_d = NULL                                       => -0.0123625669,
                                                                            -0.0123625669);

final_score_85_c565 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 8.5 => 0.0703410892,
    mth_pp_datevendorfirstseen > 8.5                                        => -0.0265556498,
    mth_pp_datevendorfirstseen = NULL                                       => 0.0079766808,
                                                                               0.0031408686);

final_score_85_c564 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 0.5 => 0.0136957616,
    (Integer)inq_adl_firstseen_n > 0.5                                          => 0.0836827738,
    (Integer)inq_adl_firstseen_n = NULL                                         => final_score_85_c565,
                                                                                   0.0118580935);

final_score_85 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By SSN', 'Child', 'Father', 'Granddaughter', 'Grandfather', 'Grandson', 'Neighbor', 'Parent', 'Sibling', 'Son', 'Spouse', 'Subject'])                                                                    => final_score_85_c562,
    (phone_subject_title in ['Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Daughter', 'Grandchild', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Relative', 'Sister', 'Subject at Household', 'Wife']) => final_score_85_c564,
    phone_subject_title = ''                                                                                                                                                                                                                                                           => -0.0028314551,
                                                                                                                                                                                                                                                                                          -0.0028314551);

final_score_86_c570 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 77.5 => 0.0060556953,
    f_fp_prevaddrcrimeindex_i > 77.5                                       => 0.0901097726,
    f_fp_prevaddrcrimeindex_i = NULL                                       => 0.0539873592,
                                                                              0.0539873592);

final_score_86_c569 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 1.5 => -0.0270853286,
    f_rel_homeover100_count_d > 1.5                                       => final_score_86_c570,
    f_rel_homeover100_count_d = NULL                                      => 0.0360678595,
                                                                             0.0360678595);

final_score_86_c568 := map(
    NULL < (Integer)_internal_ver_match_hhid AND (Integer)_internal_ver_match_hhid <= 0.5 => 0.0004191762,
    (Integer)_internal_ver_match_hhid > 0.5                                               => final_score_86_c569,
    (Integer)_internal_ver_match_hhid = NULL                                              => 0.0030991400,
                                                                                             0.0030991400);

final_score_86_c567 := map(
    NULL < f_college_income_d AND f_college_income_d <= 7.5 => 0.0057083900,
    f_college_income_d > 7.5                                => -0.0625244262,
    f_college_income_d = NULL                               => final_score_86_c568,
                                                               0.0015397695);

final_score_86 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 25.5 => final_score_86_c567,
    f_inq_count_i > 25.5                           => -0.0336507211,
    f_inq_count_i = NULL                           => -0.0022293953,
                                                      -0.0022293953);

final_score_87_c573 := map(
    NULL < mth_source_md_fseen AND mth_source_md_fseen <= 9.5 => 0.0592409016,
    mth_source_md_fseen > 9.5                                 => -0.0362509216,
    mth_source_md_fseen = NULL                                => -0.0075750901,
                                                                 -0.0074299296);

final_score_87_c574 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Child', 'Father', 'Mother', 'Neighbor', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Wife'])                                                                => -0.0017234425,
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By SSN', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Parent', 'Relative', 'Son', 'Subject at Household']) => 0.1275889554,
    phone_subject_title = ''                                                                                                                                                                                                                                                         => 0.0261916148,
                                                                                                                                                                                                                                                                                        0.0261916148);

final_score_87_c572 := map(
    NULL < eda_max_days_interrupt AND eda_max_days_interrupt <= 1213 => final_score_87_c573,
    eda_max_days_interrupt > 1213                                    => final_score_87_c574,
    eda_max_days_interrupt = NULL                                    => -0.0047136468,
                                                                        -0.0047136468);

final_score_87_c575 := map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 5.5 => 0.0061065552,
    f_corrrisktype_i > 5.5                              => 0.1061857614,
    f_corrrisktype_i = NULL                             => 0.0534364325,
                                                           0.0534364325);

final_score_87 := map(
    NULL < r_paw_active_phone_ct_d AND r_paw_active_phone_ct_d <= 1.5 => final_score_87_c572,
    r_paw_active_phone_ct_d > 1.5                                     => final_score_87_c575,
    r_paw_active_phone_ct_d = NULL                                    => -0.0027189010,
                                                                         -0.0027189010);

final_score_88_c577 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -115.5 => 0.0693718502,
    f_addrchangecrimediff_i > -115.5                                     => -0.0066807227,
    f_addrchangecrimediff_i = NULL                                       => 0.0070735413,
                                                                            -0.0004345266);

final_score_88_c580 := map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 5.5 => 0.0193157347,
    f_sourcerisktype_i > 5.5                                => 0.0858760438,
    f_sourcerisktype_i = NULL                               => 0.0369225408,
                                                               0.0369225408);

final_score_88_c579 := map(
    NULL < f_inputaddractivephonelist_d AND f_inputaddractivephonelist_d <= 0.5 => final_score_88_c580,
    f_inputaddractivephonelist_d > 0.5                                          => -0.0481969938,
    f_inputaddractivephonelist_d = NULL                                         => 0.0235339474,
                                                                                   0.0235339474);

final_score_88_c578 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Child', 'Daughter', 'Father', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Relative', 'Son', 'Spouse', 'Subject']) => -0.0158021744,
    (phone_subject_title in ['Associate', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Grandchild', 'Granddaughter', 'Parent', 'Sibling', 'Sister', 'Subject at Household', 'Wife'])                                                                                                            => final_score_88_c579,
    phone_subject_title = ''                                                                                                                                                                                                                                                                               => -0.0072294895,
                                                                                                                                                                                                                                                                                                              -0.0072294895);

final_score_88 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 12.5 => 0.0636414010,
    mth_pp_app_npa_last_change_dt > 12.5                                           => final_score_88_c577,
    mth_pp_app_npa_last_change_dt = NULL                                           => final_score_88_c578,
                                                                                      -0.0028316642);

final_score_89_c582 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 7.5 => 0.0577515153,
    f_rel_incomeover50_count_d > 7.5                                        => -0.0328073826,
    f_rel_incomeover50_count_d = NULL                                       => 0.0284842368,
                                                                               0.0284842368);

final_score_89_c585 := map(
    NULL < (Integer)f_adl_util_misc_n AND (Integer)f_adl_util_misc_n <= 0.5 => 0.0966739190,
    (Integer)f_adl_util_misc_n > 0.5                                        => -0.0239570130,
    (Integer)f_adl_util_misc_n = NULL                                       => 0.0421628702,
                                                                               0.0421628702);

final_score_89_c584 := map(
    NULL < _pp_rule_ins_ver_above AND _pp_rule_ins_ver_above <= 0.5 => -0.0054641211,
    _pp_rule_ins_ver_above > 0.5                                    => final_score_89_c585,
    _pp_rule_ins_ver_above = NULL                                   => -0.0038923383,
                                                                       -0.0038923383);

final_score_89_c583 := map(
    NULL < mth_source_edaca_fseen AND mth_source_edaca_fseen <= 36.5 => 0.0867909388,
    mth_source_edaca_fseen > 36.5                                    => -0.0545948782,
    mth_source_edaca_fseen = NULL                                    => final_score_89_c584,
                                                                        -0.0035198212);

final_score_89 := map(
    NULL < mth_source_ppfla_fseen AND mth_source_ppfla_fseen <= 19.5 => -0.0343457039,
    mth_source_ppfla_fseen > 19.5                                    => final_score_89_c582,
    mth_source_ppfla_fseen = NULL                                    => final_score_89_c583,
                                                                        -0.0025184064);

final_score_90_c588 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Daughter', 'Father', 'Husband', 'Mother', 'Neighbor', 'Sister', 'Son', 'Spouse', 'Subject at Household'])                                            => -0.0209426437,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Parent', 'Relative', 'Sibling', 'Subject', 'Wife']) => 0.0922889594,
    phone_subject_title = ''                                                                                                                                                                                                                                               => 0.0384214977,
                                                                                                                                                                                                                                                                              0.0384214977);

final_score_90_c587 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 9.5 => final_score_90_c588,
    f_rel_incomeover50_count_d > 9.5                                        => -0.0129478181,
    f_rel_incomeover50_count_d = NULL                                       => 0.0253930481,
                                                                               0.0253930481);

final_score_90_c590 := map(
    NULL < (Integer)_phone_match_code_n AND (Integer)_phone_match_code_n <= 0.5 => -0.0133803028,
    (Integer)_phone_match_code_n > 0.5                                          => 0.0146625381,
    (Integer)_phone_match_code_n = NULL                                         => -0.0010002950,
                                                                                   -0.0010002950);

final_score_90_c589 := map(
    NULL < f_wealth_index_d AND f_wealth_index_d <= 2.5 => -0.0216972133,
    f_wealth_index_d > 2.5                              => final_score_90_c590,
    f_wealth_index_d = NULL                             => -0.0072729370,
                                                           -0.0072729370);

final_score_90 := map(
    NULL < mth_phone_fb_rp_date AND mth_phone_fb_rp_date <= 38.5 => final_score_90_c587,
    mth_phone_fb_rp_date > 38.5                                  => -0.0536759158,
    mth_phone_fb_rp_date = NULL                                  => final_score_90_c589,
                                                                    -0.0057750130);

final_score_91_c595 := map(
    NULL < _phone_match_code_tcza AND _phone_match_code_tcza <= 2.5 => -0.0478798469,
    _phone_match_code_tcza > 2.5                                    => 0.0357047139,
    _phone_match_code_tcza = NULL                                   => 0.0159309949,
                                                                       0.0159309949);

final_score_91_c594 := map(
    NULL < f_vardobcount_i AND f_vardobcount_i <= 1.5 => -0.0171090886,
    f_vardobcount_i > 1.5                             => final_score_91_c595,
    f_vardobcount_i = NULL                            => -0.0041681427,
                                                         -0.0041681427);

final_score_91_c593 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.199157770307709 => -0.0609554402,
    f_add_curr_mobility_index_n > 0.199157770307709                                         => final_score_91_c594,
    f_add_curr_mobility_index_n = NULL                                                      => -0.0091746963,
                                                                                               -0.0091746963);

final_score_91_c592 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 1.5 => 0.0725229490,
    mth_internal_ver_first_seen > 1.5                                         => final_score_91_c593,
    mth_internal_ver_first_seen = NULL                                        => 0.0044445479,
                                                                                 0.0007329115);

final_score_91 := map(
    NULL < mth_source_ppca_fseen AND mth_source_ppca_fseen <= 22.5 => 0.0365933912,
    mth_source_ppca_fseen > 22.5                                   => -0.0253856609,
    mth_source_ppca_fseen = NULL                                   => final_score_91_c592,
                                                                      0.0009644420);

final_score_92_c600 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 72.5 => 0.0233076991,
    mth_pp_eda_hist_did_dt > 72.5                                    => -0.0764985745,
    mth_pp_eda_hist_did_dt = NULL                                    => -0.0048886921,
                                                                        -0.0048886921);

final_score_92_c599 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 11.5 => 0.0444294113,
    mth_source_ppdid_fseen > 11.5                                    => final_score_92_c600,
    mth_source_ppdid_fseen = NULL                                    => 0.0669963190,
                                                                        0.0238802415);

final_score_92_c598 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 0.5 => -0.0110055238,
    r_pb_order_freq_d > 0.5                               => final_score_92_c599,
    r_pb_order_freq_d = NULL                              => -0.0108498209,
                                                             0.0013204029);

final_score_92_c597 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 1.5 => 0.0651488170,
    mth_internal_ver_first_seen > 1.5                                         => final_score_92_c598,
    mth_internal_ver_first_seen = NULL                                        => -0.0079845074,
                                                                                 -0.0037524998);

final_score_92 := map(
    NULL < mth_pp_eda_hist_ph_dt AND mth_pp_eda_hist_ph_dt <= 19.5 => -0.0833880979,
    mth_pp_eda_hist_ph_dt > 19.5                                   => -0.0044873558,
    mth_pp_eda_hist_ph_dt = NULL                                   => final_score_92_c597,
                                                                      -0.0050018390);

final_score_93_c603 := map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 9.5 => -0.0177010557,
    f_rel_homeover50_count_d > 9.5                                      => 0.1437985790,
    f_rel_homeover50_count_d = NULL                                     => 0.0630487616,
                                                                           0.0630487616);

final_score_93_c602 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 3.5 => final_score_93_c603,
    f_inq_count_i > 3.5                           => -0.0403281274,
    f_inq_count_i = NULL                          => -0.0129387055,
                                                     -0.0129387055);

final_score_93_c605 := map(
    (phone_subject_title in ['Associate By Address', 'Father', 'Husband', 'Mother', 'Neighbor'])                                                                                                                                                                                                                                                                                                          => -0.0092323868,
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => 0.0754102811,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                                                              => 0.0358370857,
                                                                                                                                                                                                                                                                                                                                                                                                             0.0358370857);

final_score_93_c604 := map(
    NULL < eda_address_match_best AND eda_address_match_best <= 0.5 => -0.0015271705,
    eda_address_match_best > 0.5                                    => final_score_93_c605,
    eda_address_match_best = NULL                                   => 0.0005023497,
                                                                       0.0005023497);

final_score_93 := map(
    NULL < mth_source_cr_fseen AND mth_source_cr_fseen <= 154.5 => final_score_93_c602,
    mth_source_cr_fseen > 154.5                                 => 0.1066916882,
    mth_source_cr_fseen = NULL                                  => final_score_93_c604,
                                                                   0.0008577658);

final_score_94_c610 := map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 5.5 => 0.1049198311,
    f_corrrisktype_i > 5.5                              => 0.0204144815,
    f_corrrisktype_i = NULL                             => 0.0569746707,
                                                           0.0569746707);

final_score_94_c609 := map(
    (pp_source in ['', 'CELL', 'GONG', 'INFUTOR', 'OTHER', 'PCNSR', 'TARGUS', 'THRIVE']) => -0.0007854994,
    (pp_source in ['HEADER', 'IBEHAVIOR', 'INQUIRY', 'INTRADO'])                         => final_score_94_c610,
    pp_source = ''                                                                       => 0.0327014199,
                                                                                            0.0327014199);

final_score_94_c608 := map(
    NULL < (Integer)_phone_match_code_n AND (Integer)_phone_match_code_n <= 0.5 => -0.0155639434,
    (Integer)_phone_match_code_n > 0.5                                          => final_score_94_c609,
    (Integer)_phone_match_code_n = NULL                                         => 0.0155297598,
                                                                                   0.0155297598);

final_score_94_c607 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 13.5 => final_score_94_c608,
    f_srchfraudsrchcount_i > 13.5                                    => -0.0545342872,
    f_srchfraudsrchcount_i = NULL                                    => 0.0086756683,
                                                                        0.0086756683);

final_score_94 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 168.5 => -0.0173612995,
    mth_pp_app_npa_effective_dt > 168.5                                         => final_score_94_c607,
    mth_pp_app_npa_effective_dt = NULL                                          => 0.0030697834,
                                                                                   -0.0012382236);

final_score_95_c614 := map(
    (pp_source in ['CELL', 'HEADER', 'INQUIRY', 'OTHER', 'PCNSR'])                     => -0.0261685160,
    (pp_source in ['', 'GONG', 'IBEHAVIOR', 'INFUTOR', 'INTRADO', 'TARGUS', 'THRIVE']) => 0.0565664230,
    pp_source = ''                                                                     => 0.0195681020,
                                                                                          0.0195681020);

final_score_95_c613 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 2.5 => final_score_95_c614,
    f_util_adl_count_n > 2.5                                => -0.0435708500,
    f_util_adl_count_n = NULL                               => -0.0088834011,
                                                               -0.0088834011);

final_score_95_c615 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 2.5 => 0.0828244805,
    mth_eda_dt_first_seen > 2.5                                   => -0.0046712961,
    mth_eda_dt_first_seen = NULL                                  => 0.0106986729,
                                                                     0.0032093191);

final_score_95_c612 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 11.5 => 0.0397343715,
    mth_exp_last_update > 11.5                                 => final_score_95_c613,
    mth_exp_last_update = NULL                                 => final_score_95_c615,
                                                                  0.0035115302);

final_score_95 := map(
    (exp_source in ['P'])     => -0.0363942706,
    (exp_source in ['', 'S']) => final_score_95_c612,
    exp_source = ''           => 0.0011248906,
                                 0.0011248906);

final_score_96_c617 := map(
    NULL < mth_source_ppla_lseen AND mth_source_ppla_lseen <= 17.5 => 0.0417631486,
    mth_source_ppla_lseen > 17.5                                   => -0.0301018420,
    mth_source_ppla_lseen = NULL                                   => -0.0181649539,
                                                                      -0.0152274370);

final_score_96_c619 := map(
    NULL < (Integer)_phone_match_code_n AND (Integer)_phone_match_code_n <= 0.5 => -0.0049099371,
    (Integer)_phone_match_code_n > 0.5                                          => 0.0151498213,
    (Integer)_phone_match_code_n = NULL                                         => 0.0017293606,
                                                                                   0.0017293606);

final_score_96_c620 := map(
    NULL < f_srchaddrsrchcount_i AND f_srchaddrsrchcount_i <= 2.5 => 0.0056111891,
    f_srchaddrsrchcount_i > 2.5                                   => 0.1209044890,
    f_srchaddrsrchcount_i = NULL                                  => 0.0638175153,
                                                                     0.0638175153);

final_score_96_c618 := map(
    (pp_src in ['', 'E1', 'E2', 'EQ', 'FA', 'LP', 'PL', 'UT', 'ZT'])                                 => final_score_96_c619,
    (pp_src in ['CY', 'EM', 'EN', 'FF', 'KW', 'LA', 'MD', 'NW', 'SL', 'TN', 'UW', 'VO', 'VW', 'ZK']) => final_score_96_c620,
    pp_src = ''                                                                                      => 0.0039112371,
                                                                                                        0.0039112371);

final_score_96 := map(
    (pp_origlistingtype in ['R', 'RB'])     => final_score_96_c617,
    (pp_origlistingtype in ['', 'B', 'BG']) => final_score_96_c618,
    pp_origlistingtype = ''                 => -0.0013355465,
                                               -0.0013355465);

final_score_97_c624 := map(
    NULL < inq_num AND inq_num <= 2.5 => -0.0086543771,
    inq_num > 2.5                     => 0.0560930952,
    inq_num = NULL                    => -0.0002345412,
                                         -0.0002345412);

final_score_97_c625 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 87 => 0.0269091789,
    mth_pp_eda_hist_did_dt > 87                                    => -0.0363390406,
    mth_pp_eda_hist_did_dt = NULL                                  => 0.0705562100,
                                                                      0.0260820618);

final_score_97_c623 := map(
    NULL < (Integer)inq_adl_lastseen_n AND (Integer)inq_adl_lastseen_n <= 29.5 => final_score_97_c624,
    (Integer)inq_adl_lastseen_n > 29.5                                         => -0.0373558245,
    (Integer)inq_adl_lastseen_n = NULL                                         => final_score_97_c625,
                                                                                  0.0084999954);

final_score_97_c622 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 11.5 => final_score_97_c623,
    mth_pp_first_build_date > 11.5                                     => -0.0232844066,
    mth_pp_first_build_date = NULL                                     => 0.0006072466,
                                                                          -0.0000295681);

final_score_97 := map(
    NULL < _internal_ver_match_level AND _internal_ver_match_level <= 2.5 => final_score_97_c622,
    _internal_ver_match_level > 2.5                                       => 0.0691851569,
    _internal_ver_match_level = NULL                                      => 0.0012731360,
                                                                             0.0012731360);

final_score_98_c629 := map(
    NULL < (Integer)_phone_match_code_n AND (Integer)_phone_match_code_n <= 0.5 => -0.0183582722,
    (Integer)_phone_match_code_n > 0.5                                          => 0.0142229823,
    (Integer)_phone_match_code_n = NULL                                         => -0.0039495428,
                                                                                   -0.0039495428);

final_score_98_c628 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 583.5 => final_score_98_c629,
    r_pb_order_freq_d > 583.5                               => 0.0724458356,
    r_pb_order_freq_d = NULL                                => -0.0013909068,
                                                               -0.0018121201);

final_score_98_c627 := map(
    (pp_source in ['CELL', 'GONG', 'INTRADO', 'OTHER', 'TARGUS', 'THRIVE'])   => -0.0749315010,
    (pp_source in ['', 'HEADER', 'IBEHAVIOR', 'INFUTOR', 'INQUIRY', 'PCNSR']) => final_score_98_c628,
    pp_source = ''                                                            => -0.0034273396,
                                                                                 -0.0034273396);

final_score_98_c630 := map(
    NULL < eda_days_ph_first_seen AND eda_days_ph_first_seen <= 3705.5 => 0.1304127471,
    eda_days_ph_first_seen > 3705.5                                    => 0.0069933033,
    eda_days_ph_first_seen = NULL                                      => 0.0574663296,
                                                                          0.0574663296);

final_score_98 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Father', 'Grandfather', 'Grandson', 'Husband', 'Neighbor', 'Relative', 'Sister', 'Son', 'Subject', 'Subject at Household', 'Wife']) => final_score_98_c627,
    (phone_subject_title in ['Associate By Property', 'Associate By SSN', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Mother', 'Parent', 'Sibling', 'Spouse'])                                                                                                => final_score_98_c630,
    phone_subject_title = ''                                                                                                                                                                                                                                                                         => -0.0009014135,
                                                                                                                                                                                                                                                                                                        -0.0009014135);

final_score_99_c633 := map(
    NULL < mth_pp_datelastseen AND mth_pp_datelastseen <= 16.5 => 0.0228409988,
    mth_pp_datelastseen > 16.5                                 => -0.0740462477,
    mth_pp_datelastseen = NULL                                 => -0.0227785567,
                                                                  -0.0227785567);

final_score_99_c632 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 6.5 => 0.0637246708,
    f_rel_under25miles_cnt_d > 6.5                                      => final_score_99_c633,
    f_rel_under25miles_cnt_d = NULL                                     => 0.0162533874,
                                                                           0.0162533874);

final_score_99_c635 := map(
    NULL < f_inq_addrs_per_ssn_i AND f_inq_addrs_per_ssn_i <= 1.5 => -0.0023777044,
    f_inq_addrs_per_ssn_i > 1.5                                   => -0.0540402925,
    f_inq_addrs_per_ssn_i = NULL                                  => -0.0052982839,
                                                                     -0.0052982839);

final_score_99_c634 := map(
    NULL < f_estimated_income_d AND f_estimated_income_d <= 25500 => 0.0624910471,
    f_estimated_income_d > 25500                                  => final_score_99_c635,
    f_estimated_income_d = NULL                                   => -0.0033519641,
                                                                     -0.0033519641);

final_score_99 := map(
    NULL < mth_source_ppla_lseen AND mth_source_ppla_lseen <= 6.5 => -0.0463449394,
    mth_source_ppla_lseen > 6.5                                   => final_score_99_c632,
    mth_source_ppla_lseen = NULL                                  => final_score_99_c634,
                                                                     -0.0029262650);

final_score_100_c637 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 6.5 => 0.0006171939,
    f_rel_incomeover75_count_d > 6.5                                        => -0.0302921185,
    f_rel_incomeover75_count_d = NULL                                       => -0.0029220089,
                                                                               -0.0029220089);

final_score_100_c639 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 42.5 => -0.0347050271,
    mth_source_sx_fseen > 42.5                                 => 0.0536337466,
    mth_source_sx_fseen = NULL                                 => 0.0043829258,
                                                                  0.0043829258);

final_score_100_c640 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By SSN', 'Brother', 'Grandmother', 'Grandson', 'Mother', 'Neighbor', 'Relative', 'Sister', 'Son'])                                                                                                                                                                      => 0.0247083132,
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Husband', 'Parent', 'Sibling', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => 0.1044681775,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                            => 0.0608624385,
                                                                                                                                                                                                                                                                                                                                           0.0608624385);

final_score_100_c638 := map(
    (exp_source in ['P'])     => final_score_100_c639,
    (exp_source in ['', 'S']) => final_score_100_c640,
    exp_source = ''           => 0.0342231071,
                                 0.0342231071);

final_score_100 := map(
    NULL < source_eda_any_clean AND source_eda_any_clean <= 0.5 => final_score_100_c637,
    source_eda_any_clean > 0.5                                  => final_score_100_c638,
    source_eda_any_clean = NULL                                 => -0.0004061126,
                                                                   -0.0004061126);

final_score_101_c644 := map(
    NULL < f_srchssnsrchcount_i AND f_srchssnsrchcount_i <= 4.5 => 0.0432700261,
    f_srchssnsrchcount_i > 4.5                                  => -0.0501150706,
    f_srchssnsrchcount_i = NULL                                 => 0.0132884950,
                                                                   0.0132884950);

final_score_101_c643 := map(
    NULL < (Integer)inq_adl_lastseen_n AND (Integer)inq_adl_lastseen_n <= 20.5 => 0.1058656992,
    (Integer)inq_adl_lastseen_n > 20.5                                         => final_score_101_c644,
    (Integer)inq_adl_lastseen_n = NULL                                         => 0.0375563058,
                                                                                  0.0375563058);

final_score_101_c645 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 7.5 => 0.0274814765,
    f_rel_ageover30_count_d > 7.5                                     => -0.0090658021,
    f_rel_ageover30_count_d = NULL                                    => 0.0064725530,
                                                                         0.0064725530);

final_score_101_c642 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 12.5 => -0.0013666134,
    (Integer)inq_adl_firstseen_n > 12.5                                          => final_score_101_c643,
    (Integer)inq_adl_firstseen_n = NULL                                          => final_score_101_c645,
                                                                                    0.0056975909);

final_score_101 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 0.5 => final_score_101_c642,
    f_srchunvrfdphonecount_i > 0.5                                      => -0.0202622786,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0003623910,
                                                                           -0.0003623910);

final_score_102_c648 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.273766696269439 => 0.0617296506,
    f_add_curr_mobility_index_n > 0.273766696269439                                         => 0.0043696280,
    f_add_curr_mobility_index_n = NULL                                                      => 0.0188367864,
                                                                                               0.0188367864);

final_score_102_c649 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 179.5 => -0.0040163958,
    f_fp_prevaddrburglaryindex_i > 179.5                                          => -0.0652157524,
    f_fp_prevaddrburglaryindex_i = NULL                                           => -0.0120724324,
                                                                                     -0.0120724324);

final_score_102_c650 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 63.5 => 0.0191951247,
    r_pb_order_freq_d > 63.5                               => -0.0199764694,
    r_pb_order_freq_d = NULL                               => -0.0098246499,
                                                              -0.0008146782);

final_score_102_c647 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 35.5 => final_score_102_c648,
    mth_pp_eda_hist_did_dt > 35.5                                    => final_score_102_c649,
    mth_pp_eda_hist_did_dt = NULL                                    => final_score_102_c650,
                                                                        -0.0009047019);

final_score_102 := map(
    NULL < _pp_rule_30 AND _pp_rule_30 <= 0.5 => final_score_102_c647,
    _pp_rule_30 > 0.5                         => -0.0740478663,
    _pp_rule_30 = NULL                        => -0.0018466148,
                                                 -0.0018466148);

final_score_103_c653 := map(
    (phone_subject_title in ['Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Son', 'Spouse', 'Subject', 'Subject at Household'])                                                                  => -0.0106738782,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Parent', 'Relative', 'Sibling', 'Sister', 'Wife']) => 0.1156391193,
    phone_subject_title = ''                                                                                                                                                                                                                                                          => 0.0524826206,
                                                                                                                                                                                                                                                                                         0.0524826206);

final_score_103_c654 := map(
    NULL < mth_source_cr_fseen AND mth_source_cr_fseen <= 131.5 => -0.0074353062,
    mth_source_cr_fseen > 131.5                                 => 0.0996665316,
    mth_source_cr_fseen = NULL                                  => -0.0061755271,
                                                                   -0.0043779578);

final_score_103_c652 := map(
    NULL < mth_phone_fb_rp_date AND mth_phone_fb_rp_date <= 34.5 => final_score_103_c653,
    mth_phone_fb_rp_date > 34.5                                  => -0.0533488338,
    mth_phone_fb_rp_date = NULL                                  => final_score_103_c654,
                                                                    -0.0021495114);

final_score_103_c655 := map(
    NULL < _phone_zip_match AND _phone_zip_match <= 0.5 => -0.0001183490,
    _phone_zip_match > 0.5                              => 0.1082757137,
    _phone_zip_match = NULL                             => 0.0557901676,
                                                           0.0557901676);

final_score_103 := map(
    (eda_pfrd_address_ind in ['1A', '1B', '1E', 'XX']) => final_score_103_c652,
    (eda_pfrd_address_ind in ['1C', '1D'])             => final_score_103_c655,
    eda_pfrd_address_ind = ''                          => 0.0005767241,
                                                          0.0005767241);

final_score_104_c658 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 5.5 => -0.0846478576,
    f_rel_ageover40_count_d > 5.5                                     => -0.0034099424,
    f_rel_ageover40_count_d = NULL                                    => -0.0573056467,
                                                                         -0.0573056467);

final_score_104_c657 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 1.5 => 0.0126033558,
    f_rel_ageover40_count_d > 1.5                                     => final_score_104_c658,
    f_rel_ageover40_count_d = NULL                                    => -0.0361593570,
                                                                         -0.0361593570);

final_score_104_c660 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 92 => 0.0032044407,
    f_prevaddrageoldest_d > 92                                   => 0.0894238923,
    f_prevaddrageoldest_d = NULL                                 => 0.0495400644,
                                                                    0.0495400644);

final_score_104_c659 := map(
    NULL < source_eda_any_clean AND source_eda_any_clean <= 0.5 => 0.0034125339,
    source_eda_any_clean > 0.5                                  => final_score_104_c660,
    source_eda_any_clean = NULL                                 => 0.0051892264,
                                                                   0.0051892264);

final_score_104 := map(
    (exp_source in ['P'])     => final_score_104_c657,
    (exp_source in ['', 'S']) => final_score_104_c659,
    exp_source = ''           => 0.0029210958,
                                 0.0029210958);

final_score_105_c664 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 53.5 => -0.0434102944,
    f_mos_inq_banko_cm_lseen_d > 53.5                                        => 0.0460811234,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => -0.0065608871,
                                                                                -0.0065608871);

final_score_105_c663 := map(
    NULL < mth_pp_datevendorlastseen AND mth_pp_datevendorlastseen <= 2.5 => final_score_105_c664,
    mth_pp_datevendorlastseen > 2.5                                       => 0.0912532169,
    mth_pp_datevendorlastseen = NULL                                      => 0.0156695911,
                                                                             0.0156695911);

final_score_105_c665 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 47724.5 => -0.0545121357,
    f_curraddrmedianincome_d > 47724.5                                      => 0.0336405716,
    f_curraddrmedianincome_d = NULL                                         => -0.0046866924,
                                                                               -0.0046866924);

final_score_105_c662 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 10.5 => 0.0587613529,
    mth_source_ppdid_lseen > 10.5                                    => final_score_105_c663,
    mth_source_ppdid_lseen = NULL                                    => final_score_105_c665,
                                                                        0.0128029014);

final_score_105 := map(
    NULL < _pp_rule_high_vend_conf AND _pp_rule_high_vend_conf <= 0.5 => -0.0062131491,
    _pp_rule_high_vend_conf > 0.5                                     => final_score_105_c662,
    _pp_rule_high_vend_conf = NULL                                    => -0.0033240092,
                                                                         -0.0033240092);

final_score_106_c668 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 5.5 => 0.1041828344,
    f_rel_incomeover50_count_d > 5.5                                        => 0.0100325678,
    f_rel_incomeover50_count_d = NULL                                       => 0.0589578155,
                                                                               0.0589578155);

final_score_106_c667 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 7.5 => final_score_106_c668,
    mth_internal_ver_first_seen > 7.5                                         => -0.0116188314,
    mth_internal_ver_first_seen = NULL                                        => 0.0275904169,
                                                                                 0.0275904169);

final_score_106_c670 := map(
    NULL < eda_max_days_connected_ind AND eda_max_days_connected_ind <= 560.5 => -0.0028661677,
    eda_max_days_connected_ind > 560.5                                        => 0.0566270872,
    eda_max_days_connected_ind = NULL                                         => -0.0016008749,
                                                                                 -0.0016008749);

final_score_106_c669 := map(
    NULL < (Integer)_inq_adl_ph_industry_flag AND (Integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_106_c670,
    (Integer)_inq_adl_ph_industry_flag > 0.5                                                => 0.0483999751,
    (Integer)_inq_adl_ph_industry_flag = NULL                                               => -0.0002978993,
                                                                                               -0.0002978993);

final_score_106 := map(
    NULL < mth_source_ppfla_fseen AND mth_source_ppfla_fseen <= 19.5 => -0.0395074195,
    mth_source_ppfla_fseen > 19.5                                    => final_score_106_c667,
    mth_source_ppfla_fseen = NULL                                    => final_score_106_c669,
                                                                        0.0004122319);

final_score_107_c675 := map(
    NULL < f_componentcharrisktype_i AND f_componentcharrisktype_i <= 2.5 => 0.0766294204,
    f_componentcharrisktype_i > 2.5                                       => -0.0000268535,
    f_componentcharrisktype_i = NULL                                      => 0.0063916368,
                                                                             0.0063916368);

final_score_107_c674 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 7.5 => 0.0372048677,
    f_inq_count_i > 7.5                           => final_score_107_c675,
    f_inq_count_i = NULL                          => 0.0189605732,
                                                     0.0189605732);

final_score_107_c673 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Grandmother', 'Grandson', 'Husband', 'Neighbor', 'Sibling', 'Son'])                                                                                            => -0.0193625597,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Mother', 'Parent', 'Relative', 'Sister', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_107_c674,
    phone_subject_title = ''                                                                                                                                                                                                                                                                       => 0.0099055507,
                                                                                                                                                                                                                                                                                                      0.0099055507);

final_score_107_c672 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 24.5 => final_score_107_c673,
    f_rel_under25miles_cnt_d > 24.5                                      => -0.0646785415,
    f_rel_under25miles_cnt_d = NULL                                      => 0.0064781610,
                                                                            0.0064781610);

final_score_107 := map(
    NULL < r_has_paw_source_d AND r_has_paw_source_d <= 0.5 => -0.0137239911,
    r_has_paw_source_d > 0.5                                => final_score_107_c672,
    r_has_paw_source_d = NULL                               => -0.0027598960,
                                                               -0.0027598960);

final_score_108_c679 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 1.5 => 0.0381799578,
    mth_pp_first_build_date > 1.5                                     => -0.0017260334,
    mth_pp_first_build_date = NULL                                    => 0.0103783590,
                                                                         0.0062198257);

final_score_108_c680 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 46.5 => -0.0565678389,
    r_pb_order_freq_d > 46.5                               => 0.0364434012,
    r_pb_order_freq_d = NULL                               => -0.0914541335,
                                                              -0.0423842533);

final_score_108_c678 := map(
    NULL < eda_days_ind_first_seen AND eda_days_ind_first_seen <= 155 => final_score_108_c679,
    eda_days_ind_first_seen > 155                                     => final_score_108_c680,
    eda_days_ind_first_seen = NULL                                    => 0.0038126085,
                                                                         0.0038126085);

final_score_108_c677 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 591115 => final_score_108_c678,
    f_prevaddrmedianvalue_d > 591115                                     => -0.0572991151,
    f_prevaddrmedianvalue_d = NULL                                       => 0.0021643183,
                                                                            0.0021643183);

final_score_108 := map(
    NULL < mth_source_sp_lseen AND mth_source_sp_lseen <= 1.5 => 0.0783046558,
    mth_source_sp_lseen > 1.5                                 => -0.0162861955,
    mth_source_sp_lseen = NULL                                => final_score_108_c677,
                                                                 0.0031089482);

final_score_109_c684 := map(
    NULL < f_inq_per_addr_i AND f_inq_per_addr_i <= 0.5 => -0.0294685945,
    f_inq_per_addr_i > 0.5                              => 0.0552727961,
    f_inq_per_addr_i = NULL                             => 0.0104097070,
                                                           0.0104097070);

final_score_109_c683 := map(
    (pp_app_scc in ['C', 'N'])                         => final_score_109_c684,
    (pp_app_scc in ['', '8', 'A', 'B', 'J', 'R', 'S']) => 0.0800203450,
    pp_app_scc = ''                                    => 0.0295443847,
                                                          0.0295443847);

final_score_109_c682 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 39.5 => final_score_109_c683,
    mth_source_utildid_fseen > 39.5                                      => -0.0097921751,
    mth_source_utildid_fseen = NULL                                      => -0.0003381766,
                                                                            0.0010180366);

final_score_109_c685 := map(
    NULL < eda_avg_days_connected_ind AND eda_avg_days_connected_ind <= 693 => -0.0802936200,
    eda_avg_days_connected_ind > 693                                        => 0.0591061669,
    eda_avg_days_connected_ind = NULL                                       => -0.0443658399,
                                                                               -0.0443658399);

final_score_109 := map(
    NULL < eda_days_ind_first_seen AND eda_days_ind_first_seen <= 721 => final_score_109_c682,
    eda_days_ind_first_seen > 721                                     => final_score_109_c685,
    eda_days_ind_first_seen = NULL                                    => -0.0011623675,
                                                                         -0.0011623675);

final_score_110_c687 := map(
    NULL < mth_source_cr_fseen AND mth_source_cr_fseen <= 107.5 => -0.0428824228,
    mth_source_cr_fseen > 107.5                                 => 0.0553579420,
    mth_source_cr_fseen = NULL                                  => -0.0039256980,
                                                                   -0.0059037323);

final_score_110_c690 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 16.5 => 0.0694265716,
    mth_source_ppca_lseen > 16.5                                   => -0.0496937223,
    mth_source_ppca_lseen = NULL                                   => 0.0054904965,
                                                                      0.0031424581);

final_score_110_c689 := map(
    NULL < f_estimated_income_d AND f_estimated_income_d <= 90500 => final_score_110_c690,
    f_estimated_income_d > 90500                                  => -0.0734901130,
    f_estimated_income_d = NULL                                   => -0.0057167987,
                                                                     -0.0057167987);

final_score_110_c688 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 8.5 => 0.0610178596,
    mth_pp_datevendorfirstseen > 8.5                                        => final_score_110_c689,
    mth_pp_datevendorfirstseen = NULL                                       => 0.0204828670,
                                                                               0.0170164822);

final_score_110 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Daughter', 'Father', 'Grandfather', 'Grandparent', 'Grandson', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Subject', 'Wife']) => final_score_110_c687,
    (phone_subject_title in ['Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Brother', 'Grandchild', 'Granddaughter', 'Grandmother', 'Mother', 'Sister', 'Son', 'Spouse', 'Subject at Household'])                              => final_score_110_c688,
    phone_subject_title = ''                                                                                                                                                                                                                                        => 0.0017987766,
                                                                                                                                                                                                                                                                       0.0017987766);

final_score_111_c695 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.206190051944127 => -0.0252055569,
    f_add_curr_mobility_index_n > 0.206190051944127                                         => 0.0352762634,
    f_add_curr_mobility_index_n = NULL                                                      => 0.0247831890,
                                                                                               0.0247831890);

final_score_111_c694 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 8.5 => -0.0039635899,
    f_rel_ageover40_count_d > 8.5                                     => final_score_111_c695,
    f_rel_ageover40_count_d = NULL                                    => -0.0003644871,
                                                                         -0.0003644871);

final_score_111_c693 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Daughter', 'Father', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject', 'Subject at Household']) => final_score_111_c694,
    (phone_subject_title in ['Associate By Property', 'Child', 'Grandchild', 'Granddaughter', 'Husband', 'Mother', 'Parent', 'Spouse', 'Wife'])                                                                                                                                                                                                            => 0.0589290251,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                               => 0.0011197733,
                                                                                                                                                                                                                                                                                                                                                              0.0011197733);

final_score_111_c692 := map(
    NULL < mth_source_sp_fseen AND mth_source_sp_fseen <= 20 => 0.0091891975,
    mth_source_sp_fseen > 20                                 => 0.0873485290,
    mth_source_sp_fseen = NULL                               => final_score_111_c693,
                                                                0.0026905683);

final_score_111 := map(
    NULL < eda_num_phs_connected_addr AND eda_num_phs_connected_addr <= 1.5 => final_score_111_c692,
    eda_num_phs_connected_addr > 1.5                                        => -0.0987886308,
    eda_num_phs_connected_addr = NULL                                       => 0.0014088845,
                                                                               0.0014088845);

final_score_112_c697 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 112.5 => -0.0792274395,
    f_prevaddrageoldest_d > 112.5                                   => -0.0072210798,
    f_prevaddrageoldest_d = NULL                                    => -0.0357172137,
                                                                       -0.0357172137);

final_score_112_c699 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 11.5 => 0.0325086326,
    mth_exp_last_update > 11.5                                 => -0.0091886916,
    mth_exp_last_update = NULL                                 => -0.0068135103,
                                                                  -0.0052950492);

final_score_112_c700 := map(
    NULL < f_curraddrcrimeindex_i AND f_curraddrcrimeindex_i <= 140 => 0.1028645903,
    f_curraddrcrimeindex_i > 140                                    => -0.0113370367,
    f_curraddrcrimeindex_i = NULL                                   => 0.0600924454,
                                                                       0.0600924454);

final_score_112_c698 := map(
    NULL < source_eda_any_clean AND source_eda_any_clean <= 0.5 => final_score_112_c699,
    source_eda_any_clean > 0.5                                  => final_score_112_c700,
    source_eda_any_clean = NULL                                 => -0.0029996954,
                                                                   -0.0029996954);

final_score_112 := map(
    (exp_source in ['P'])     => final_score_112_c697,
    (exp_source in ['', 'S']) => final_score_112_c698,
    exp_source = ''           => -0.0049037609,
                                 -0.0049037609);

final_score_113_c703 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 66 => 0.0991371902,
    f_curraddrmurderindex_i > 66                                     => 0.0139219432,
    f_curraddrmurderindex_i = NULL                                   => 0.0415452343,
                                                                        0.0415452343);

final_score_113_c702 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Child', 'Father', 'Grandfather', 'Grandmother', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Subject', 'Wife']) => -0.0013490732,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandparent', 'Relative', 'Son', 'Spouse', 'Subject at Household'])                        => final_score_113_c703,
    phone_subject_title = ''                                                                                                                                                                                                                                     => 0.0118584961,
                                                                                                                                                                                                                                                                    0.0118584961);

final_score_113_c705 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.320102726484204 => 0.0556144533,
    f_add_input_mobility_index_n > 0.320102726484204                                          => 0.0118313983,
    f_add_input_mobility_index_n = NULL                                                       => 0.0371125817,
                                                                                                 0.0371125817);

final_score_113_c704 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 90979 => -0.0014718953,
    f_curraddrmedianincome_d > 90979                                      => final_score_113_c705,
    f_curraddrmedianincome_d = NULL                                       => 0.0020831299,
                                                                             0.0020831299);

final_score_113 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 12.5 => final_score_113_c702,
    mth_eda_dt_first_seen > 12.5                                   => -0.0127941035,
    mth_eda_dt_first_seen = NULL                                   => final_score_113_c704,
                                                                      -0.0032742085);

final_score_114_c708 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 14.5 => 0.0777305091,
    f_inq_count_i > 14.5                           => -0.0113954955,
    f_inq_count_i = NULL                           => 0.0502022936,
                                                      0.0502022936);

final_score_114_c707 := map(
    NULL < pp_did_score AND pp_did_score <= 38 => final_score_114_c708,
    pp_did_score > 38                          => -0.0348634463,
    pp_did_score = NULL                        => 0.0296759898,
                                                  0.0296759898);

final_score_114_c710 := map(
    NULL < mth_source_sp_fseen AND mth_source_sp_fseen <= 24 => 0.0817850533,
    mth_source_sp_fseen > 24                                 => 0.0039728766,
    mth_source_sp_fseen = NULL                               => 0.0029174106,
                                                                0.0042445999);

final_score_114_c709 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 26.5 => -0.0306748418,
    f_curraddrmurderindex_i > 26.5                                     => final_score_114_c710,
    f_curraddrmurderindex_i = NULL                                     => 0.0002758441,
                                                                          0.0002758441);

final_score_114 := map(
    NULL < mth_source_ppfla_fseen AND mth_source_ppfla_fseen <= 20.5 => -0.0218522255,
    mth_source_ppfla_fseen > 20.5                                    => final_score_114_c707,
    mth_source_ppfla_fseen = NULL                                    => final_score_114_c709,
                                                                        0.0013681148);

final_score_115_c714 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Shared Associates', 'Associate By SSN', 'Grandfather', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Wife'])                    => -0.0551333865,
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Subject', 'Subject at Household']) => 0.0563035459,
    phone_subject_title = ''                                                                                                                                                                                                                                   => -0.0074155206,
                                                                                                                                                                                                                                                                  -0.0074155206);

final_score_115_c713 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 145 => final_score_115_c714,
    f_curraddrmurderindex_i > 145                                     => -0.0878065526,
    f_curraddrmurderindex_i = NULL                                    => -0.0321182711,
                                                                         -0.0321182711);

final_score_115_c712 := map(
    NULL < exp_verified AND exp_verified <= 0.5 => final_score_115_c713,
    exp_verified > 0.5                          => -0.0942649465,
    exp_verified = NULL                         => -0.0414918270,
                                                   -0.0414918270);

final_score_115_c715 := map(
    NULL < mth_source_md_fseen AND mth_source_md_fseen <= 9.5 => 0.0702931663,
    mth_source_md_fseen > 9.5                                 => -0.0161935337,
    mth_source_md_fseen = NULL                                => 0.0026750941,
                                                                 0.0029776442);

final_score_115 := map(
    NULL < _phone_timezone_match AND _phone_timezone_match <= 0.5 => final_score_115_c712,
    _phone_timezone_match > 0.5                                   => final_score_115_c715,
    _phone_timezone_match = NULL                                  => -0.0006730813,
                                                                     -0.0006730813);

final_score_116_c719 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 4.5 => -0.0210724142,
    f_corraddrnamecount_d > 4.5                                   => 0.0133566754,
    f_corraddrnamecount_d = NULL                                  => -0.0007810616,
                                                                     -0.0007810616);

final_score_116_c718 := map(
    (phone_subject_title in ['Associate', 'Associate By Shared Associates', 'Brother', 'Father', 'Mother', 'Relative', 'Sister', 'Son', 'Subject', 'Subject at Household'])                                                                                                                                                    => final_score_116_c719,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Neighbor', 'Parent', 'Sibling', 'Spouse', 'Wife']) => 0.0954725571,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                   => 0.0039798701,
                                                                                                                                                                                                                                                                                                                                  0.0039798701);

final_score_116_c717 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.172476406787072 => -0.0461803843,
    f_add_input_mobility_index_n > 0.172476406787072                                          => final_score_116_c718,
    f_add_input_mobility_index_n = NULL                                                       => 0.0016157597,
                                                                                                 0.0016157597);

final_score_116_c720 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By SSN', 'Child', 'Daughter', 'Grandson', 'Mother', 'Neighbor', 'Sister', 'Spouse', 'Subject', 'Wife'])                                                                                => -0.0138155307,
    (phone_subject_title in ['Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Husband', 'Parent', 'Relative', 'Sibling', 'Son', 'Subject at Household']) => 0.0239916505,
    phone_subject_title = ''                                                                                                                                                                                                                                                                 => -0.0016982311,
                                                                                                                                                                                                                                                                                                -0.0016982311);

final_score_116 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 1.5 => 0.0829171418,
    mth_internal_ver_first_seen > 1.5                                         => final_score_116_c717,
    mth_internal_ver_first_seen = NULL                                        => final_score_116_c720,
                                                                                 0.0006656362);

final_score_117_c723 := map(
    (pp_src in ['CY', 'E1', 'E2', 'PL', 'SL', 'UW'])                                                                 => -0.0677713622,
    (pp_src in ['', 'EM', 'EN', 'EQ', 'FA', 'FF', 'KW', 'LA', 'LP', 'MD', 'NW', 'TN', 'UT', 'VO', 'VW', 'ZK', 'ZT']) => 0.0032596355,
    pp_src = ''                                                                                                      => -0.0030187319,
                                                                                                                        -0.0030187319);

final_score_117_c722 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 21.5 => -0.0337139390,
    mth_pp_eda_hist_did_dt > 21.5                                    => final_score_117_c723,
    mth_pp_eda_hist_did_dt = NULL                                    => 0.0050614800,
                                                                        0.0001203811);

final_score_117_c725 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 12.5 => 0.0393525416,
    f_rel_under100miles_cnt_d > 12.5                                       => -0.0409103218,
    f_rel_under100miles_cnt_d = NULL                                       => 0.0127072326,
                                                                              0.0127072326);

final_score_117_c724 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 64382 => final_score_117_c725,
    f_prevaddrmedianincome_d > 64382                                      => 0.0836677975,
    f_prevaddrmedianincome_d = NULL                                       => 0.0293126690,
                                                                             0.0293126690);

final_score_117 := map(
    (pp_app_scc in ['', 'A', 'B', 'C', 'N', 'R']) => final_score_117_c722,
    (pp_app_scc in ['8', 'J', 'S'])               => final_score_117_c724,
    pp_app_scc = ''                               => 0.0024374015,
                                                     0.0024374015);

final_score_118_c728 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 169.5 => 0.0053146559,
    mth_pp_app_npa_effective_dt > 169.5                                         => -0.0587610702,
    mth_pp_app_npa_effective_dt = NULL                                          => -0.0365106227,
                                                                                   -0.0159112900);

final_score_118_c727 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 3.5 => 0.0470889437,
    mth_exp_last_update > 3.5                                 => final_score_118_c728,
    mth_exp_last_update = NULL                                => -0.0032168223,
                                                                 -0.0042826014);

final_score_118_c730 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 109.5 => -0.0273095028,
    f_prevaddrageoldest_d > 109.5                                   => 0.0777972172,
    f_prevaddrageoldest_d = NULL                                    => 0.0220588051,
                                                                       0.0220588051);

final_score_118_c729 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 15.5 => 0.0682749796,
    mth_source_ppdid_lseen > 15.5                                    => final_score_118_c730,
    mth_source_ppdid_lseen = NULL                                    => 0.0098656627,
                                                                        0.0179088266);

final_score_118 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 63765.5 => final_score_118_c727,
    f_prevaddrmedianincome_d > 63765.5                                      => final_score_118_c729,
    f_prevaddrmedianincome_d = NULL                                         => 0.0016417075,
                                                                               0.0016417075);

final_score_119_c735 := map(
    NULL < (Integer)_phone_match_code_n AND (Integer)_phone_match_code_n <= 0.5 => -0.0109451296,
    (Integer)_phone_match_code_n > 0.5                                          => 0.0244237998,
    (Integer)_phone_match_code_n = NULL                                         => -0.0051826532,
                                                                                   -0.0051826532);

final_score_119_c734 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 1.5 => 0.0641961798,
    mth_internal_ver_first_seen > 1.5                                         => -0.0023858098,
    mth_internal_ver_first_seen = NULL                                        => final_score_119_c735,
                                                                                 -0.0032687223);

final_score_119_c733 := map(
    NULL < eda_min_days_connected_ind AND eda_min_days_connected_ind <= 13.5 => final_score_119_c734,
    eda_min_days_connected_ind > 13.5                                        => -0.0561811527,
    eda_min_days_connected_ind = NULL                                        => -0.0049577748,
                                                                                -0.0049577748);

final_score_119_c732 := map(
    NULL < _pp_rule_30 AND _pp_rule_30 <= 0.5 => final_score_119_c733,
    _pp_rule_30 > 0.5                         => -0.0834734353,
    _pp_rule_30 = NULL                        => -0.0059729785,
                                                 -0.0059729785);

final_score_119 := map(
    NULL < eda_avg_days_connected_ind AND eda_avg_days_connected_ind <= 628.5 => final_score_119_c732,
    eda_avg_days_connected_ind > 628.5                                        => 0.0802082778,
    eda_avg_days_connected_ind = NULL                                         => -0.0047991378,
                                                                                 -0.0047991378);

final_score_120_c738 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -4307 => 0.0114850184,
    f_addrchangeincomediff_d > -4307                                      => -0.0597841939,
    f_addrchangeincomediff_d = NULL                                       => -0.0011167776,
                                                                             -0.0307091546);

final_score_120_c739 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 26.5 => 0.0363660576,
    mth_source_utildid_fseen > 26.5                                      => -0.0061063673,
    mth_source_utildid_fseen = NULL                                      => -0.0014350929,
                                                                            -0.0005619443);

final_score_120_c737 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.200675393677801 => final_score_120_c738,
    f_add_input_mobility_index_n > 0.200675393677801                                          => final_score_120_c739,
    f_add_input_mobility_index_n = NULL                                                       => -0.0032735569,
                                                                                                 -0.0032735569);

final_score_120_c740 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 96 => -0.0095989349,
    f_fp_prevaddrburglaryindex_i > 96                                          => 0.0761641851,
    f_fp_prevaddrburglaryindex_i = NULL                                        => 0.0411247781,
                                                                                  0.0411247781);

final_score_120 := map(
    NULL < (Integer)_inq_adl_ph_industry_flag AND (Integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_120_c737,
    (Integer)_inq_adl_ph_industry_flag > 0.5                                                => final_score_120_c740,
    (Integer)_inq_adl_ph_industry_flag = NULL                                               => -0.0018606827,
                                                                                               -0.0018606827);

final_score_121_c743 := map(
    NULL < mth_pp_datelastseen AND mth_pp_datelastseen <= 5.5 => -0.0433452659,
    mth_pp_datelastseen > 5.5                                 => 0.0463912036,
    mth_pp_datelastseen = NULL                                => 0.0048353889,
                                                                 0.0048353889);

final_score_121_c742 := map(
    NULL < f_curraddrcrimeindex_i AND f_curraddrcrimeindex_i <= 77.5 => 0.0861540937,
    f_curraddrcrimeindex_i > 77.5                                    => final_score_121_c743,
    f_curraddrcrimeindex_i = NULL                                    => 0.0372319755,
                                                                        0.0372319755);

final_score_121_c745 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.199194065464934 => -0.0299290450,
    f_add_curr_mobility_index_n > 0.199194065464934                                         => 0.0018760252,
    f_add_curr_mobility_index_n = NULL                                                      => -0.0012842896,
                                                                                               -0.0012842896);

final_score_121_c744 := map(
    NULL < _pp_rule_ins_ver_above AND _pp_rule_ins_ver_above <= 0.5 => final_score_121_c745,
    _pp_rule_ins_ver_above > 0.5                                    => 0.0519840411,
    _pp_rule_ins_ver_above = NULL                                   => 0.0001358954,
                                                                       0.0001358954);

final_score_121 := map(
    NULL < mth_source_ppca_fseen AND mth_source_ppca_fseen <= 22.5 => final_score_121_c742,
    mth_source_ppca_fseen > 22.5                                   => -0.0103210001,
    mth_source_ppca_fseen = NULL                                   => final_score_121_c744,
                                                                      0.0016872334);

final_score_122_c748 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 52899 => 0.0205155265,
    f_addrchangevaluediff_d > 52899                                     => -0.0274255642,
    f_addrchangevaluediff_d = NULL                                      => -0.0469781314,
                                                                           -0.0067512273);

final_score_122_c750 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -1135 => 0.0093740420,
    f_addrchangeincomediff_d > -1135                                      => 0.0672161167,
    f_addrchangeincomediff_d = NULL                                       => 0.1243060799,
                                                                             0.0664066587);

final_score_122_c749 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Daughter', 'Father', 'Grandfather', 'Grandmother', 'Grandson', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Subject'])                                      => 0.0165416560,
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Brother', 'Grandchild', 'Granddaughter', 'Grandparent', 'Husband', 'Mother', 'Parent', 'Son', 'Spouse', 'Subject at Household', 'Wife']) => final_score_122_c750,
    phone_subject_title = ''                                                                                                                                                                                                                                            => 0.0295377921,
                                                                                                                                                                                                                                                                           0.0295377921);

final_score_122_c747 := map(
    NULL < f_curraddrcrimeindex_i AND f_curraddrcrimeindex_i <= 116 => final_score_122_c748,
    f_curraddrcrimeindex_i > 116                                    => final_score_122_c749,
    f_curraddrcrimeindex_i = NULL                                   => 0.0131215956,
                                                                       0.0131215956);

final_score_122 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 131.5 => -0.0095862332,
    f_prevaddrcartheftindex_i > 131.5                                       => final_score_122_c747,
    f_prevaddrcartheftindex_i = NULL                                        => -0.0004046777,
                                                                               -0.0004046777);

final_score_123_c753 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 9.5 => -0.0021142322,
    f_rel_educationover12_count_d > 9.5                                           => -0.0513423318,
    f_rel_educationover12_count_d = NULL                                          => -0.0289216132,
                                                                                     -0.0289216132);

final_score_123_c754 := map(
    NULL < pp_src_cnt AND pp_src_cnt <= 1.5 => -0.0055975498,
    pp_src_cnt > 1.5                        => 0.0249819778,
    pp_src_cnt = NULL                       => -0.0029499528,
                                               -0.0029499528);

final_score_123_c752 := map(
    NULL < mth_phone_fb_rp_date AND mth_phone_fb_rp_date <= 12.5 => 0.0604381467,
    mth_phone_fb_rp_date > 12.5                                  => final_score_123_c753,
    mth_phone_fb_rp_date = NULL                                  => final_score_123_c754,
                                                                    -0.0025366542);

final_score_123_c755 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Grandfather', 'Grandmother', 'Neighbor', 'Parent', 'Sibling', 'Son', 'Subject at Household'])                => -0.0459906453,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Vehicle', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Relative', 'Sister', 'Spouse', 'Subject', 'Wife']) => 0.0704256688,
    phone_subject_title = ''                                                                                                                                                                                                                                 => 0.0315227297,
                                                                                                                                                                                                                                                                0.0315227297);

final_score_123 := map(
    (eda_pfrd_address_ind in ['1A', '1B', '1E', 'XX']) => final_score_123_c752,
    (eda_pfrd_address_ind in ['1C', '1D'])             => final_score_123_c755,
    eda_pfrd_address_ind = ''                          => -0.0008581457,
                                                          -0.0008581457);

final_score_124_c759 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 24.5 => -0.0519177472,
    mth_source_ppdid_fseen > 24.5                                    => 0.0202987112,
    mth_source_ppdid_fseen = NULL                                    => -0.0398430394,
                                                                        -0.0257669745);

final_score_124_c758 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 145.5 => 0.0137218729,
    f_curraddrcartheftindex_i > 145.5                                       => final_score_124_c759,
    f_curraddrcartheftindex_i = NULL                                        => 0.0013544142,
                                                                               0.0013544142);

final_score_124_c760 := map(
    NULL < eda_days_ph_first_seen AND eda_days_ph_first_seen <= 181.5 => 0.0999993272,
    eda_days_ph_first_seen > 181.5                                    => -0.0026864246,
    eda_days_ph_first_seen = NULL                                     => -0.0003306111,
                                                                         -0.0003306111);

final_score_124_c757 := map(
    NULL < mth_pp_datelastseen AND mth_pp_datelastseen <= 54.5 => final_score_124_c758,
    mth_pp_datelastseen > 54.5                                 => -0.0641439474,
    mth_pp_datelastseen = NULL                                 => final_score_124_c760,
                                                                  -0.0018701755);

final_score_124 := map(
    NULL < mth_source_ppth_lseen AND mth_source_ppth_lseen <= 23.5 => 0.0634100680,
    mth_source_ppth_lseen > 23.5                                   => -0.0798147967,
    mth_source_ppth_lseen = NULL                                   => final_score_124_c757,
                                                                      -0.0029228723);

final_score_125_c763 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Brother', 'Child', 'Daughter', 'Father', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Relative', 'Subject'])                    => -0.0077158469,
    (phone_subject_title in ['Associate By Business', 'Associate By SSN', 'Associate By Vehicle', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Parent', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject at Household', 'Wife']) => 0.0492604562,
    phone_subject_title = ''                                                                                                                                                                                                                                   => -0.0011048072,
                                                                                                                                                                                                                                                                  -0.0011048072);

final_score_125_c762 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 150.5 => -0.0059553455,
    mth_pp_app_npa_effective_dt > 150.5                                         => 0.0189594066,
    mth_pp_app_npa_effective_dt = NULL                                          => final_score_125_c763,
                                                                                   0.0030039106);

final_score_125_c765 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 3672.5 => -0.0169026666,
    f_addrchangeincomediff_d > 3672.5                                      => -0.1081717462,
    f_addrchangeincomediff_d = NULL                                        => -0.0613670900,
                                                                              -0.0613670900);

final_score_125_c764 := map(
    (pp_origphonetype in ['O', 'W'])     => final_score_125_c765,
    (pp_origphonetype in ['', 'L', 'V']) => -0.0038824978,
    pp_origphonetype = ''                => -0.0181291789,
                                            -0.0181291789);

final_score_125 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 16.5 => final_score_125_c762,
    f_rel_under100miles_cnt_d > 16.5                                       => final_score_125_c764,
    f_rel_under100miles_cnt_d = NULL                                       => -0.0009370469,
                                                                              -0.0009370469);

final_score_126_c770 := map(
    NULL < inq_num_addresses AND inq_num_addresses <= 0.5 => 0.0769602779,
    inq_num_addresses > 0.5                               => -0.0081093911,
    inq_num_addresses = NULL                              => 0.0254532518,
                                                             0.0254532518);

final_score_126_c769 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.3885460208251 => final_score_126_c770,
    f_add_curr_mobility_index_n > 0.3885460208251                                         => -0.0196056853,
    f_add_curr_mobility_index_n = NULL                                                    => 0.0053081115,
                                                                                             0.0053081115);

final_score_126_c768 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 43 => -0.0639218752,
    f_fp_prevaddrcrimeindex_i > 43                                       => final_score_126_c769,
    f_fp_prevaddrcrimeindex_i = NULL                                     => -0.0071799597,
                                                                            -0.0071799597);

final_score_126_c767 := map(
    NULL < number_of_sources AND number_of_sources <= 3.5 => final_score_126_c768,
    number_of_sources > 3.5                               => 0.0701524527,
    number_of_sources = NULL                              => 0.0049282171,
                                                             0.0049282171);

final_score_126 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 10.5 => 0.0829357641,
    mth_source_utildid_fseen > 10.5                                      => final_score_126_c767,
    mth_source_utildid_fseen = NULL                                      => 0.0037508332,
                                                                            0.0049182734);

final_score_127_c772 := map(
    NULL < f_vardobcount_i AND f_vardobcount_i <= 1.5 => 0.0009113807,
    f_vardobcount_i > 1.5                             => 0.0591216016,
    f_vardobcount_i = NULL                            => 0.0225174704,
                                                         0.0225174704);

final_score_127_c774 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 3.5 => 0.0062605667,
    f_srchfraudsrchcount_i > 3.5                                    => -0.0305207728,
    f_srchfraudsrchcount_i = NULL                                   => -0.0071206724,
                                                                       -0.0071206724);

final_score_127_c773 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 10.5 => -0.0788621876,
    f_prevaddrageoldest_d > 10.5                                   => final_score_127_c774,
    f_prevaddrageoldest_d = NULL                                   => -0.0122803765,
                                                                      -0.0122803765);

final_score_127_c775 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Child', 'Grandson', 'Husband', 'Neighbor', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife'])                              => -0.0173015882,
    (phone_subject_title in ['Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Mother', 'Parent', 'Relative', 'Sibling']) => 0.0216965567,
    phone_subject_title = ''                                                                                                                                                                                                                                        => -0.0060572539,
                                                                                                                                                                                                                                                                       -0.0060572539);

final_score_127 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 4.5 => final_score_127_c772,
    mth_internal_ver_first_seen > 4.5                                         => final_score_127_c773,
    mth_internal_ver_first_seen = NULL                                        => final_score_127_c775,
                                                                                 -0.0050725469);

final_score_128_c780 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Shared Associates', 'Child', 'Daughter', 'Father', 'Grandfather', 'Husband', 'Neighbor', 'Sibling', 'Sister', 'Son', 'Subject at Household', 'Wife'])                                => -0.0124194516,
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Mother', 'Parent', 'Relative', 'Spouse', 'Subject']) => 0.0723622668,
    phone_subject_title = ''                                                                                                                                                                                                                                         => 0.0235808258,
                                                                                                                                                                                                                                                                        0.0235808258);

final_score_128_c779 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 394043.5 => -0.0270963355,
    f_prevaddrmedianvalue_d > 394043.5                                     => final_score_128_c780,
    f_prevaddrmedianvalue_d = NULL                                         => -0.0173431875,
                                                                              -0.0173431875);

final_score_128_c778 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -12746.5 => final_score_128_c779,
    f_addrchangevaluediff_d > -12746.5                                     => 0.0083561769,
    f_addrchangevaluediff_d = NULL                                         => -0.0079940877,
                                                                              -0.0027397674);

final_score_128_c777 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 13.5 => final_score_128_c778,
    f_inq_count24_i > 13.5                             => 0.0512443325,
    f_inq_count24_i = NULL                             => -0.0001384505,
                                                          -0.0001384505);

final_score_128 := map(
    NULL < inq_num AND inq_num <= 6.5 => final_score_128_c777,
    inq_num > 6.5                     => -0.0611329647,
    inq_num = NULL                    => -0.0009465749,
                                         -0.0009465749);

final_score_129_c782 := map(
    NULL < r_mos_since_paw_fseen_d AND r_mos_since_paw_fseen_d <= 15.5 => -0.0096039504,
    r_mos_since_paw_fseen_d > 15.5                                     => 0.0170346223,
    r_mos_since_paw_fseen_d = NULL                                     => -0.0048413290,
                                                                          -0.0048413290);

final_score_129_c785 := map(
    NULL < pk_cell_indicator AND pk_cell_indicator <= 2.5 => 0.0391168526,
    pk_cell_indicator > 2.5                               => 0.1116211649,
    pk_cell_indicator = NULL                              => 0.0683974402,
                                                             0.0683974402);

final_score_129_c784 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 54 => -0.0016323800,
    mth_pp_app_npa_last_change_dt > 54                                           => final_score_129_c785,
    mth_pp_app_npa_last_change_dt = NULL                                         => 0.0513999111,
                                                                                    0.0513999111);

final_score_129_c783 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 61.5 => -0.0272918817,
    f_fp_prevaddrburglaryindex_i > 61.5                                          => final_score_129_c784,
    f_fp_prevaddrburglaryindex_i = NULL                                          => 0.0272367497,
                                                                                    0.0272367497);

final_score_129 := map(
    NULL < (Integer)_internal_ver_match_hhid AND (Integer)_internal_ver_match_hhid <= 0.5 => final_score_129_c782,
    (Integer)_internal_ver_match_hhid > 0.5                                               => final_score_129_c783,
    (Integer)_internal_ver_match_hhid = NULL                                              => -0.0024223654,
                                                                                             -0.0024223654);

final_score_130_c788 := map(
    NULL < mth_source_ppla_fseen AND mth_source_ppla_fseen <= 28.5 => -0.0332575711,
    mth_source_ppla_fseen > 28.5                                   => 0.0265517848,
    mth_source_ppla_fseen = NULL                                   => -0.0066811087,
                                                                      -0.0064267203);

final_score_130_c787 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 7.5 => -0.0622604931,
    mth_source_ppca_lseen > 7.5                                   => 0.0095726366,
    mth_source_ppca_lseen = NULL                                  => final_score_130_c788,
                                                                     -0.0067255871);

final_score_130_c790 := map(
    NULL < (Integer)_phone_match_code_lns AND (Integer)_phone_match_code_lns <= 0.5 => 0.0058330261,
    (Integer)_phone_match_code_lns > 0.5                                            => 0.0864454300,
    (Integer)_phone_match_code_lns = NULL                                           => 0.0106137209,
                                                                                       0.0106137209);

final_score_130_c789 := map(
    (exp_source in ['', 'P']) => final_score_130_c790,
    (exp_source in ['S'])     => 0.0784478884,
    exp_source = ''           => 0.0145101322,
                                 0.0145101322);

final_score_130 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By SSN', 'Child', 'Daughter', 'Grandson', 'Husband', 'Neighbor', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife'])                                                                                    => final_score_130_c787,
    (phone_subject_title in ['Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Mother', 'Parent', 'Relative', 'Sibling', 'Sister']) => final_score_130_c789,
    phone_subject_title = ''                                                                                                                                                                                                                                                                   => 0.0000952965,
                                                                                                                                                                                                                                                                                                  0.0000952965);

final_score_131_c793 := map(
    (phone_subject_title in ['Associate', 'Child', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Neighbor', 'Parent', 'Sister', 'Son', 'Subject', 'Subject at Household', 'Wife'])                                                                                                          => -0.0142040333,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Daughter', 'Father', 'Grandchild', 'Grandfather', 'Husband', 'Mother', 'Relative', 'Sibling', 'Spouse']) => 0.0141493164,
    phone_subject_title = ''                                                                                                                                                                                                                                                                              => -0.0044919307,
                                                                                                                                                                                                                                                                                                             -0.0044919307);

final_score_131_c795 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 104.5 => -0.0205589853,
    f_curraddrmurderindex_i > 104.5                                     => 0.0617241597,
    f_curraddrmurderindex_i = NULL                                      => 0.0178134429,
                                                                           0.0178134429);

final_score_131_c794 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 12.5 => 0.0630192411,
    mth_source_ppdid_lseen > 12.5                                    => final_score_131_c795,
    mth_source_ppdid_lseen = NULL                                    => -0.0054399988,
                                                                        0.0152082161);

final_score_131_c792 := map(
    NULL < _pp_rule_high_vend_conf AND _pp_rule_high_vend_conf <= 0.5 => final_score_131_c793,
    _pp_rule_high_vend_conf > 0.5                                     => final_score_131_c794,
    _pp_rule_high_vend_conf = NULL                                    => -0.0013846758,
                                                                         -0.0013846758);

final_score_131 := map(
    NULL < mth_source_edadid_fseen AND mth_source_edadid_fseen <= 28.5 => 0.0697386223,
    mth_source_edadid_fseen > 28.5                                     => 0.0144413260,
    mth_source_edadid_fseen = NULL                                     => final_score_131_c792,
                                                                          -0.0002786663);

final_score_132_c799 := map(
    (pp_src in ['CY', 'E1', 'E2', 'EM', 'EN', 'PL', 'UT', 'UW'])                                         => -0.0299085940,
    (pp_src in ['', 'EQ', 'FA', 'FF', 'KW', 'LA', 'LP', 'MD', 'NW', 'SL', 'TN', 'VO', 'VW', 'ZK', 'ZT']) => 0.0018078727,
    pp_src = ''                                                                                          => -0.0028503854,
                                                                                                            -0.0028503854);

final_score_132_c800 := map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 5.5 => 0.0622760882,
    f_corrrisktype_i > 5.5                              => 0.0014478404,
    f_corrrisktype_i = NULL                             => 0.0257990180,
                                                           0.0257990180);

final_score_132_c798 := map(
    NULL < _pp_app_nxx_type AND _pp_app_nxx_type <= 11 => final_score_132_c799,
    _pp_app_nxx_type > 11                              => final_score_132_c800,
    _pp_app_nxx_type = NULL                            => -0.0005712440,
                                                          -0.0005712440);

final_score_132_c797 := map(
    NULL < f_inq_per_ssn_i AND f_inq_per_ssn_i <= 9.5 => final_score_132_c798,
    f_inq_per_ssn_i > 9.5                             => -0.0869614227,
    f_inq_per_ssn_i = NULL                            => -0.0021261349,
                                                         -0.0021261349);

final_score_132 := map(
    NULL < mth_source_edahistory_lseen AND mth_source_edahistory_lseen <= 27.5 => -0.0305991236,
    mth_source_edahistory_lseen > 27.5                                         => -0.1092856104,
    mth_source_edahistory_lseen = NULL                                         => final_score_132_c797,
                                                                                  -0.0040608381);

final_score_133_c804 := map(
    NULL < eda_avg_days_interrupt AND eda_avg_days_interrupt <= 800 => -0.0033083840,
    eda_avg_days_interrupt > 800                                    => 0.1148197304,
    eda_avg_days_interrupt = NULL                                   => 0.0023114121,
                                                                       0.0023114121);

final_score_133_c803 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 16.5 => 0.0798587002,
    mth_source_ppca_lseen > 16.5                                   => -0.0074068308,
    mth_source_ppca_lseen = NULL                                   => final_score_133_c804,
                                                                      0.0064596049);

final_score_133_c802 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 0.5 => final_score_133_c803,
    f_rel_homeover200_count_d > 0.5                                       => -0.0115863239,
    f_rel_homeover200_count_d = NULL                                      => -0.0060258625,
                                                                             -0.0060258625);

final_score_133_c805 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 0.5 => -0.0071055735,
    f_rel_homeover300_count_d > 0.5                                       => 0.0806877477,
    f_rel_homeover300_count_d = NULL                                      => 0.0384735375,
                                                                             0.0384735375);

final_score_133 := map(
    NULL < f_divaddrsuspidcountnew_i AND f_divaddrsuspidcountnew_i <= 1.5 => final_score_133_c802,
    f_divaddrsuspidcountnew_i > 1.5                                       => final_score_133_c805,
    f_divaddrsuspidcountnew_i = NULL                                      => -0.0044332524,
                                                                             -0.0044332524);

final_score_134_c810 := map(
    (eda_pfrd_address_ind in ['1A', '1B'])             => 0.0182901529,
    (eda_pfrd_address_ind in ['1C', '1D', '1E', 'XX']) => 0.1233611751,
    eda_pfrd_address_ind = ''                          => 0.0729900484,
                                                          0.0729900484);

final_score_134_c809 := map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 6.5 => final_score_134_c810,
    f_corrrisktype_i > 6.5                              => -0.0126288463,
    f_corrrisktype_i = NULL                             => 0.0338350661,
                                                           0.0338350661);

final_score_134_c808 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 42 => final_score_134_c809,
    f_curraddrcartheftindex_i > 42                                       => -0.0066947588,
    f_curraddrcartheftindex_i = NULL                                     => 0.0011807048,
                                                                            0.0011807048);

final_score_134_c807 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 9.5 => -0.0207816620,
    f_rel_under100miles_cnt_d > 9.5                                       => final_score_134_c808,
    f_rel_under100miles_cnt_d = NULL                                      => -0.0109254562,
                                                                             -0.0109254562);

final_score_134 := map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i <= 150.5 => final_score_134_c807,
    f_prevaddrmurderindex_i > 150.5                                     => 0.0114992097,
    f_prevaddrmurderindex_i = NULL                                      => -0.0042030545,
                                                                           -0.0042030545);

final_score_135_c815 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 6.5 => 0.0432551487,
    f_util_adl_count_n > 6.5                                => -0.0291708478,
    f_util_adl_count_n = NULL                               => 0.0278172079,
                                                               0.0278172079);

final_score_135_c814 := map(
    NULL < f_estimated_income_d AND f_estimated_income_d <= 59500 => -0.0115025529,
    f_estimated_income_d > 59500                                  => final_score_135_c815,
    f_estimated_income_d = NULL                                   => 0.0065722084,
                                                                     0.0065722084);

final_score_135_c813 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 15 => 0.0729322554,
    f_fp_prevaddrcrimeindex_i > 15                                       => final_score_135_c814,
    f_fp_prevaddrcrimeindex_i = NULL                                     => 0.0111392189,
                                                                            0.0111392189);

final_score_135_c812 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 10.5 => -0.0583706210,
    f_curraddrmurderindex_i > 10.5                                     => final_score_135_c813,
    f_curraddrmurderindex_i = NULL                                     => 0.0069502379,
                                                                          0.0069502379);

final_score_135 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 7.5 => final_score_135_c812,
    mth_pp_first_build_date > 7.5                                     => -0.0205876727,
    mth_pp_first_build_date = NULL                                    => -0.0005668964,
                                                                         -0.0027773937);

final_score_136_c819 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.301934301107453 => -0.0138939226,
    f_add_curr_mobility_index_n > 0.301934301107453                                         => 0.0082359537,
    f_add_curr_mobility_index_n = NULL                                                      => -0.0001992693,
                                                                                               -0.0001992693);

final_score_136_c820 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandfather', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject at Household', 'Wife']) => -0.0064562505,
    (phone_subject_title in ['Associate By Property', 'Associate By SSN', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Mother', 'Subject'])                                                                                                                                                          => 0.1217368620,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                      => 0.0379182885,
                                                                                                                                                                                                                                                                                                                                     0.0379182885);

final_score_136_c818 := map(
    (eda_pfrd_address_ind in ['1A', '1B', '1E', 'XX']) => final_score_136_c819,
    (eda_pfrd_address_ind in ['1C', '1D'])             => final_score_136_c820,
    eda_pfrd_address_ind = ''                          => 0.0013585874,
                                                          0.0013585874);

final_score_136_c817 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 11.5 => -0.0070921528,
    mth_source_rel_fseen > 11.5                                  => 0.0417300092,
    mth_source_rel_fseen = NULL                                  => final_score_136_c818,
                                                                    0.0018136917);

final_score_136 := map(
    NULL < eda_num_phs_connected_addr AND eda_num_phs_connected_addr <= 1.5 => final_score_136_c817,
    eda_num_phs_connected_addr > 1.5                                        => -0.0984909162,
    eda_num_phs_connected_addr = NULL                                       => 0.0005344229,
                                                                               0.0005344229);

final_score_137_c823 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 25.5 => -0.0756393881,
    mth_eda_dt_first_seen > 25.5                                   => -0.0205212679,
    mth_eda_dt_first_seen = NULL                                   => -0.0420079927,
                                                                      -0.0420079927);

final_score_137_c822 := map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 3.5 => 0.0199719938,
    f_sourcerisktype_i > 3.5                                => final_score_137_c823,
    f_sourcerisktype_i = NULL                               => -0.0200705135,
                                                               -0.0200705135);

final_score_137_c825 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 133 => 0.1014839814,
    f_curraddrburglaryindex_i > 133                                       => -0.0079833809,
    f_curraddrburglaryindex_i = NULL                                      => 0.0597821291,
                                                                             0.0597821291);

final_score_137_c824 := map(
    NULL < source_eda_any_clean AND source_eda_any_clean <= 0.5 => 0.0037812836,
    source_eda_any_clean > 0.5                                  => final_score_137_c825,
    source_eda_any_clean = NULL                                 => 0.0057910418,
                                                                   0.0057910418);

final_score_137 := map(
    (exp_source in ['P'])     => final_score_137_c822,
    (exp_source in ['', 'S']) => final_score_137_c824,
    exp_source = ''           => 0.0042891759,
                                 0.0042891759);

final_score_138_c830 := map(
    NULL < mth_source_inf_fseen AND mth_source_inf_fseen <= 191.5 => -0.0053750662,
    mth_source_inf_fseen > 191.5                                  => 0.0189763416,
    mth_source_inf_fseen = NULL                                   => 0.0792318080,
                                                                     0.0426885166);

final_score_138_c829 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 1.5 => final_score_138_c830,
    f_util_adl_count_n > 1.5                                => -0.0114133979,
    f_util_adl_count_n = NULL                               => 0.0133716570,
                                                               0.0133716570);

final_score_138_c828 := map(
    NULL < f_assoccredbureaucount_i AND f_assoccredbureaucount_i <= 3.5 => final_score_138_c829,
    f_assoccredbureaucount_i > 3.5                                      => 0.0881196626,
    f_assoccredbureaucount_i = NULL                                     => 0.0216846246,
                                                                           0.0216846246);

final_score_138_c827 := map(
    NULL < (Integer)_phone_match_code_n AND (Integer)_phone_match_code_n <= 0.5 => -0.0110403196,
    (Integer)_phone_match_code_n > 0.5                                          => final_score_138_c828,
    (Integer)_phone_match_code_n = NULL                                         => -0.0030121935,
                                                                                   -0.0030121935);

final_score_138 := map(
    NULL < mth_pp_orig_lastseen AND mth_pp_orig_lastseen <= 18.5 => -0.0105865845,
    mth_pp_orig_lastseen > 18.5                                  => 0.0194676183,
    mth_pp_orig_lastseen = NULL                                  => final_score_138_c827,
                                                                    -0.0016226915);

final_score_139_c835 := map(
    NULL < _pp_src_all_ib AND _pp_src_all_ib <= 0.5 => -0.0024573790,
    _pp_src_all_ib > 0.5                            => 0.0738034605,
    _pp_src_all_ib = NULL                           => 0.0096935752,
                                                       0.0096935752);

final_score_139_c834 := map(
    (pp_src in ['', 'CY', 'E1', 'EN', 'FA', 'VO', 'ZT'])                                                         => final_score_139_c835,
    (pp_src in ['E2', 'EM', 'EQ', 'FF', 'KW', 'LA', 'LP', 'MD', 'NW', 'PL', 'SL', 'TN', 'UT', 'UW', 'VW', 'ZK']) => 0.0547761266,
    pp_src = ''                                                                                                  => 0.0248987226,
                                                                                                                    0.0248987226);

final_score_139_c833 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 7.5 => -0.0419902651,
    f_prevaddrlenofres_d > 7.5                                  => final_score_139_c834,
    f_prevaddrlenofres_d = NULL                                 => 0.0178701900,
                                                                   0.0178701900);

final_score_139_c832 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 90.5 => final_score_139_c833,
    mth_pp_app_npa_last_change_dt > 90.5                                           => -0.0140820378,
    mth_pp_app_npa_last_change_dt = NULL                                           => 0.0009477944,
                                                                                      0.0018496167);

final_score_139 := map(
    NULL < mth_source_ppca_fseen AND mth_source_ppca_fseen <= 6.5 => 0.0521211577,
    mth_source_ppca_fseen > 6.5                                   => -0.0209239733,
    mth_source_ppca_fseen = NULL                                  => final_score_139_c832,
                                                                     0.0000219111);

final_score_140_c839 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 11.5 => 0.0396901619,
    mth_source_ppdid_lseen > 11.5                                    => -0.0190705028,
    mth_source_ppdid_lseen = NULL                                    => 0.0029291051,
                                                                        0.0005948926);

final_score_140_c838 := map(
    (pp_origphonetype in ['L', 'O', 'W']) => final_score_140_c839,
    (pp_origphonetype in ['', 'V'])       => 0.0573242758,
    pp_origphonetype = ''                 => 0.0095111021,
                                             0.0095111021);

final_score_140_c840 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 6.5 => 0.0037308568,
    f_rel_under25miles_cnt_d > 6.5                                      => 0.1195133379,
    f_rel_under25miles_cnt_d = NULL                                     => 0.0699566339,
                                                                           0.0699566339);

final_score_140_c837 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.576143147516845 => final_score_140_c838,
    f_add_input_mobility_index_n > 0.576143147516845                                          => final_score_140_c840,
    f_add_input_mobility_index_n = NULL                                                       => 0.0216950250,
                                                                                                 0.0216950250);

final_score_140 := map(
    NULL < _pp_rule_high_vend_conf AND _pp_rule_high_vend_conf <= 0.5 => -0.0025119783,
    _pp_rule_high_vend_conf > 0.5                                     => final_score_140_c837,
    _pp_rule_high_vend_conf = NULL                                    => 0.0013306886,
                                                                         0.0013306886);

final_score_141_c843 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 3.5 => -0.0008847264,
    f_assocsuspicousidcount_i > 3.5                                       => -0.0806847367,
    f_assocsuspicousidcount_i = NULL                                      => -0.0378956901,
                                                                             -0.0378956901);

final_score_141_c842 := map(
    NULL < f_rel_count_i AND f_rel_count_i <= 25.5 => final_score_141_c843,
    f_rel_count_i > 25.5                           => 0.0336022066,
    f_rel_count_i = NULL                           => -0.0260962006,
                                                      -0.0260962006);

final_score_141_c844 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 316.5 => 0.0097163882,
    f_prevaddrageoldest_d > 316.5                                   => -0.0607450948,
    f_prevaddrageoldest_d = NULL                                    => 0.0053398986,
                                                                       0.0053398986);

final_score_141_c845 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 7.5 => 0.0730479766,
    mth_source_ppca_lseen > 7.5                                   => -0.0065641546,
    mth_source_ppca_lseen = NULL                                  => -0.0013915738,
                                                                     0.0005093705);

final_score_141 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 8.5 => final_score_141_c842,
    mth_source_ppdid_lseen > 8.5                                    => final_score_141_c844,
    mth_source_ppdid_lseen = NULL                                   => final_score_141_c845,
                                                                       -0.0005438067);

final_score_142_c848 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Child', 'Grandmother', 'Grandson', 'Husband', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => 0.0110687370,
    (phone_subject_title in ['Associate By Business', 'Associate By SSN', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Mother', 'Parent'])                                                                                                                                        => 0.1061799853,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                             => 0.0169176200,
                                                                                                                                                                                                                                                                                                                            0.0169176200);

final_score_142_c850 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 72.5 => 0.0161771322,
    mth_pp_eda_hist_did_dt > 72.5                                    => -0.0638915064,
    mth_pp_eda_hist_did_dt = NULL                                    => 0.0088202268,
                                                                        0.0023149736);

final_score_142_c849 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 173115 => -0.0036530333,
    f_addrchangevaluediff_d > 173115                                     => -0.0644804718,
    f_addrchangevaluediff_d = NULL                                       => final_score_142_c850,
                                                                            -0.0051055776);

final_score_142_c847 := map(
    NULL < subject_ssn_mismatch AND subject_ssn_mismatch <= -0.5 => final_score_142_c848,
    subject_ssn_mismatch > -0.5                                  => final_score_142_c849,
    subject_ssn_mismatch = NULL                                  => 0.0017642463,
                                                                    0.0017642463);

final_score_142 := map(
    NULL < _pp_rule_30 AND _pp_rule_30 <= 0.5 => final_score_142_c847,
    _pp_rule_30 > 0.5                         => -0.0816158358,
    _pp_rule_30 = NULL                        => 0.0007318035,
                                                 0.0007318035);

final_score_143_c855 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 31.5 => 0.0453388421,
    mth_exp_last_update > 31.5                                 => -0.0242465950,
    mth_exp_last_update = NULL                                 => 0.0174751495,
                                                                  0.0199769280);

final_score_143_c854 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 29248.5 => -0.0327251411,
    f_prevaddrmedianincome_d > 29248.5                                      => final_score_143_c855,
    f_prevaddrmedianincome_d = NULL                                         => 0.0115378649,
                                                                               0.0115378649);

final_score_143_c853 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 132.5 => final_score_143_c854,
    mth_pp_app_npa_last_change_dt > 132.5                                           => -0.0290217817,
    mth_pp_app_npa_last_change_dt = NULL                                            => -0.0017360893,
                                                                                       0.0007337657);

final_score_143_c852 := map(
    NULL < pp_did_score AND pp_did_score <= 97.5 => final_score_143_c853,
    pp_did_score > 97.5                          => -0.0251227751,
    pp_did_score = NULL                          => -0.0025968508,
                                                    -0.0025968508);

final_score_143 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 6.5 => 0.0375445811,
    mth_source_rel_fseen > 6.5                                  => -0.0257624045,
    mth_source_rel_fseen = NULL                                 => final_score_143_c852,
                                                                   -0.0023142623);

final_score_144_c858 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 109.5 => 0.0390064352,
    f_fp_prevaddrcrimeindex_i > 109.5                                       => -0.0268601925,
    f_fp_prevaddrcrimeindex_i = NULL                                        => 0.0091189770,
                                                                               0.0091189770);

final_score_144_c857 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 4.5 => final_score_144_c858,
    f_rel_ageover40_count_d > 4.5                                     => 0.0620369407,
    f_rel_ageover40_count_d = NULL                                    => 0.0252706446,
                                                                         0.0252706446);

final_score_144_c860 := map(
    NULL < f_rel_ageover20_count_d AND f_rel_ageover20_count_d <= 8.5 => 0.1276761904,
    f_rel_ageover20_count_d > 8.5                                     => 0.0063857248,
    f_rel_ageover20_count_d = NULL                                    => 0.0375809345,
                                                                         0.0375809345);

final_score_144_c859 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => -0.0032652919,
    (phone_subject_title in ['Associate By Property', 'Associate By Vehicle', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Relative'])                                                                                                                  => final_score_144_c860,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                  => -0.0002275040,
                                                                                                                                                                                                                                                                                                                 -0.0002275040);

final_score_144 := map(
    NULL < mth_source_ppfla_fseen AND mth_source_ppfla_fseen <= 88.5 => final_score_144_c857,
    mth_source_ppfla_fseen > 88.5                                    => -0.0249398291,
    mth_source_ppfla_fseen = NULL                                    => final_score_144_c859,
                                                                        0.0010389189);

final_score_145_c865 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 183.5 => -0.0409183376,
    f_prevaddrlenofres_d > 183.5                                  => 0.0576179786,
    f_prevaddrlenofres_d = NULL                                   => -0.0182251254,
                                                                     -0.0182251254);

final_score_145_c864 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.576265878218773 => final_score_145_c865,
    f_add_input_mobility_index_n > 0.576265878218773                                          => 0.0333450776,
    f_add_input_mobility_index_n = NULL                                                       => -0.0080952641,
                                                                                                 -0.0080952641);

final_score_145_c863 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 18.5 => -0.0385730273,
    mth_source_ppdid_fseen > 18.5                                    => final_score_145_c864,
    mth_source_ppdid_fseen = NULL                                    => 0.0063830959,
                                                                        -0.0023916002);

final_score_145_c862 := map(
    NULL < (Integer)inq_firstseen_n AND (Integer)inq_firstseen_n <= 64.5 => final_score_145_c863,
    (Integer)inq_firstseen_n > 64.5                                      => 0.0527127652,
    (Integer)inq_firstseen_n = NULL                                      => 0.0111396147,
                                                                            0.0079205753);

final_score_145 := map(
    NULL < eda_avg_days_interrupt AND eda_avg_days_interrupt <= 58.5 => final_score_145_c862,
    eda_avg_days_interrupt > 58.5                                    => -0.0161227774,
    eda_avg_days_interrupt = NULL                                    => 0.0012279729,
                                                                        0.0012279729);

final_score_146_c867 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 6.5 => 0.0362252525,
    mth_eda_dt_first_seen > 6.5                                   => -0.0174284997,
    mth_eda_dt_first_seen = NULL                                  => 0.0100526904,
                                                                     0.0100526904);

final_score_146_c869 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 193.5 => -0.0038991483,
    f_curraddrcartheftindex_i > 193.5                                       => 0.0490126349,
    f_curraddrcartheftindex_i = NULL                                        => -0.0017557065,
                                                                               -0.0017557065);

final_score_146_c870 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 133467.5 => 0.0815880080,
    f_prevaddrmedianvalue_d > 133467.5                                     => 0.0012918483,
    f_prevaddrmedianvalue_d = NULL                                         => 0.0375459672,
                                                                              0.0375459672);

final_score_146_c868 := map(
    NULL < _pp_rule_ins_ver_above AND _pp_rule_ins_ver_above <= 0.5 => final_score_146_c869,
    _pp_rule_ins_ver_above > 0.5                                    => final_score_146_c870,
    _pp_rule_ins_ver_above = NULL                                   => -0.0002404002,
                                                                       -0.0002404002);

final_score_146 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 12.5 => final_score_146_c867,
    mth_source_rel_fseen > 12.5                                  => 0.0438324291,
    mth_source_rel_fseen = NULL                                  => final_score_146_c868,
                                                                    0.0006413721);

final_score_147_c872 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 17.5 => -0.0661357282,
    mth_exp_last_update > 17.5                                 => -0.0113330060,
    mth_exp_last_update = NULL                                 => -0.0055663072,
                                                                  -0.0091016482);

final_score_147_c875 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 126.5 => -0.0159394586,
    mth_pp_app_npa_last_change_dt > 126.5                                           => 0.0799355845,
    mth_pp_app_npa_last_change_dt = NULL                                            => 0.0145825589,
                                                                                       0.0145825589);

final_score_147_c874 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 34.5 => final_score_147_c875,
    f_addrchangecrimediff_i > 34.5                                     => -0.0678026604,
    f_addrchangecrimediff_i = NULL                                     => -0.0521323332,
                                                                          -0.0162653074);

final_score_147_c873 := map(
    NULL < pp_did_score AND pp_did_score <= 38 => 0.0201046976,
    pp_did_score > 38                          => final_score_147_c874,
    pp_did_score = NULL                        => 0.0133808926,
                                                  0.0133808926);

final_score_147 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Shared Associates', 'Grandparent', 'Grandson', 'Mother', 'Neighbor', 'Parent', 'Sister', 'Subject at Household', 'Wife'])                                                                                      => final_score_147_c872,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Husband', 'Relative', 'Sibling', 'Son', 'Spouse', 'Subject']) => final_score_147_c873,
    phone_subject_title = ''                                                                                                                                                                                                                                                                    => 0.0047369737,
                                                                                                                                                                                                                                                                                                   0.0047369737);

final_score_148_c878 := map(
    NULL < f_srchaddrsrchcount_i AND f_srchaddrsrchcount_i <= 2.5 => -0.0346946118,
    f_srchaddrsrchcount_i > 2.5                                   => 0.0665449576,
    f_srchaddrsrchcount_i = NULL                                  => 0.0144788933,
                                                                     0.0144788933);

final_score_148_c877 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 145.5 => -0.0585794683,
    mth_pp_app_npa_effective_dt > 145.5                                         => final_score_148_c878,
    mth_pp_app_npa_effective_dt = NULL                                          => -0.0394432482,
                                                                                   -0.0273381603);

final_score_148_c879 := map(
    NULL < mth_pp_datefirstseen AND mth_pp_datefirstseen <= 35.5 => -0.0115420940,
    mth_pp_datefirstseen > 35.5                                  => 0.0243208252,
    mth_pp_datefirstseen = NULL                                  => 0.0087750112,
                                                                    0.0049110564);

final_score_148_c880 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 12.5 => -0.0030136083,
    f_rel_homeover200_count_d > 12.5                                       => 0.0645906613,
    f_rel_homeover200_count_d = NULL                                       => 0.0043973756,
                                                                              0.0043973756);

final_score_148 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -17688.5 => final_score_148_c877,
    f_addrchangeincomediff_d > -17688.5                                      => final_score_148_c879,
    f_addrchangeincomediff_d = NULL                                          => final_score_148_c880,
                                                                                0.0004414374);

final_score_149_c885 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 165802 => 0.0153171140,
    f_curraddrmedianvalue_d > 165802                                     => -0.0532562423,
    f_curraddrmedianvalue_d = NULL                                       => -0.0138050436,
                                                                            -0.0138050436);

final_score_149_c884 := map(
    NULL < _pp_src_all_ib AND _pp_src_all_ib <= 0.5 => final_score_149_c885,
    _pp_src_all_ib > 0.5                            => 0.0482006707,
    _pp_src_all_ib = NULL                           => 0.0027424937,
                                                       0.0027424937);

final_score_149_c883 := map(
    (pp_src in ['', 'CY', 'E1', 'E2', 'EM', 'EQ', 'FA', 'PL', 'SL', 'TN', 'ZT'])         => final_score_149_c884,
    (pp_src in ['EN', 'FF', 'KW', 'LA', 'LP', 'MD', 'NW', 'UT', 'UW', 'VO', 'VW', 'ZK']) => 0.0505234012,
    pp_src = ''                                                                          => 0.0230756904,
                                                                                            0.0230756904);

final_score_149_c882 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 11.5 => final_score_149_c883,
    mth_pp_datevendorfirstseen > 11.5                                        => -0.0022518710,
    mth_pp_datevendorfirstseen = NULL                                        => 0.0015740575,
                                                                                0.0036868776);

final_score_149 := map(
    NULL < _phone_timezone_match AND _phone_timezone_match <= 0.5 => -0.0368406807,
    _phone_timezone_match > 0.5                                   => final_score_149_c882,
    _phone_timezone_match = NULL                                  => 0.0004500926,
                                                                     0.0004500926);

final_score_150_c889 := map(
    NULL < eda_num_phs_connected_hhid AND eda_num_phs_connected_hhid <= 0.5 => 0.0751479821,
    eda_num_phs_connected_hhid > 0.5                                        => -0.0154992643,
    eda_num_phs_connected_hhid = NULL                                       => -0.0099503176,
                                                                               -0.0099503176);

final_score_150_c888 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 123.5 => -0.0503848102,
    mth_pp_app_npa_effective_dt > 123.5                                         => -0.0000743717,
    mth_pp_app_npa_effective_dt = NULL                                          => final_score_150_c889,
                                                                                   -0.0116295845);

final_score_150_c887 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.346924622371601 => final_score_150_c888,
    f_add_input_mobility_index_n > 0.346924622371601                                          => 0.0132817514,
    f_add_input_mobility_index_n = NULL                                                       => 0.0012979016,
                                                                                                 0.0012979016);

final_score_150_c890 := map(
    NULL < (Integer)inq_lastseen_n AND (Integer)inq_lastseen_n <= 15.5 => 0.0222315282,
    (Integer)inq_lastseen_n > 15.5                                     => -0.0892993365,
    (Integer)inq_lastseen_n = NULL                                     => -0.0539506679,
                                                                          -0.0468625881);

final_score_150 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 24.5 => final_score_150_c887,
    f_rel_ageover30_count_d > 24.5                                     => final_score_150_c890,
    f_rel_ageover30_count_d = NULL                                     => -0.0017102601,
                                                                          -0.0017102601);

final_score_151_c894 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 34.5 => -0.0892766995,
    mth_eda_dt_first_seen > 34.5                                   => 0.0103729101,
    mth_eda_dt_first_seen = NULL                                   => -0.0217211986,
                                                                      -0.0250624242);

final_score_151_c893 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 12.5 => -0.0033095898,
    mth_exp_last_update > 12.5                                 => final_score_151_c894,
    mth_exp_last_update = NULL                                 => -0.0014406034,
                                                                  -0.0042247064);

final_score_151_c895 := map(
    (phone_subject_title in ['Associate', 'Daughter', 'Father', 'Grandmother', 'Husband', 'Neighbor', 'Sibling', 'Sister', 'Subject at Household'])                                                                                                                                                                                                    => -0.0244199365,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Grandson', 'Mother', 'Parent', 'Relative', 'Son', 'Spouse', 'Subject', 'Wife']) => 0.0744448471,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                           => 0.0342810287,
                                                                                                                                                                                                                                                                                                                                                          0.0342810287);

final_score_151_c892 := map(
    NULL < f_bus_fname_verd_d AND f_bus_fname_verd_d <= 0.5 => final_score_151_c893,
    f_bus_fname_verd_d > 0.5                                => final_score_151_c895,
    f_bus_fname_verd_d = NULL                               => -0.0023667189,
                                                               -0.0023667189);

final_score_151 := map(
    NULL < mth_source_rm_fseen AND mth_source_rm_fseen <= 32.5 => 0.0647413086,
    mth_source_rm_fseen > 32.5                                 => -0.0216705003,
    mth_source_rm_fseen = NULL                                 => final_score_151_c892,
                                                                  0.0006670052);

final_score_152_c899 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 16.5 => 0.1164056867,
    mth_eda_dt_first_seen > 16.5                                   => 0.0039106559,
    mth_eda_dt_first_seen = NULL                                   => 0.0482596584,
                                                                      0.0482596584);

final_score_152_c898 := map(
    NULL < mth_source_cr_fseen AND mth_source_cr_fseen <= 11.5 => final_score_152_c899,
    mth_source_cr_fseen > 11.5                                 => -0.0206839647,
    mth_source_cr_fseen = NULL                                 => -0.0048976810,
                                                                  -0.0038808546);

final_score_152_c897 := map(
    NULL < mth_source_edadid_lseen AND mth_source_edadid_lseen <= 5 => 0.0490039494,
    mth_source_edadid_lseen > 5                                     => 0.0066745922,
    mth_source_edadid_lseen = NULL                                  => final_score_152_c898,
                                                                       -0.0029836823);

final_score_152_c900 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= -0.5 => 0.0783205526,
    r_pb_order_freq_d > -0.5                               => -0.0082110104,
    r_pb_order_freq_d = NULL                               => 0.0214574921,
                                                              0.0338800140);

final_score_152 := map(
    (pp_src in ['', 'CY', 'E1', 'E2', 'EM', 'EN', 'EQ', 'FA', 'LP', 'PL', 'SL', 'TN', 'UT', 'ZT']) => final_score_152_c897,
    (pp_src in ['FF', 'KW', 'LA', 'MD', 'NW', 'UW', 'VO', 'VW', 'ZK'])                             => final_score_152_c900,
    pp_src = ''                                                                                    => -0.0011395845,
                                                                                                      -0.0011395845);

final_score_153_c904 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -51.5 => 0.0368369550,
    f_addrchangecrimediff_i > -51.5                                     => -0.0394423090,
    f_addrchangecrimediff_i = NULL                                      => 0.0391094153,
                                                                           -0.0074058466);

final_score_153_c905 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 25664 => -0.0578319146,
    f_addrchangevaluediff_d > 25664                                     => 0.0372306954,
    f_addrchangevaluediff_d = NULL                                      => -0.0749364831,
                                                                           -0.0344634504);

final_score_153_c903 := map(
    NULL < f_college_income_d AND f_college_income_d <= 5.5 => final_score_153_c904,
    f_college_income_d > 5.5                                => final_score_153_c905,
    f_college_income_d = NULL                               => 0.0053259855,
                                                               0.0018893230);

final_score_153_c902 := map(
    NULL < _pp_rule_30 AND _pp_rule_30 <= 0.5 => final_score_153_c903,
    _pp_rule_30 > 0.5                         => -0.0885112301,
    _pp_rule_30 = NULL                        => 0.0007295982,
                                                 0.0007295982);

final_score_153 := map(
    NULL < mth_pp_eda_hist_nm_addr_dt AND mth_pp_eda_hist_nm_addr_dt <= 50.5 => -0.0693022788,
    mth_pp_eda_hist_nm_addr_dt > 50.5                                        => 0.0437205097,
    mth_pp_eda_hist_nm_addr_dt = NULL                                        => final_score_153_c902,
                                                                                -0.0001396942);

final_score_154_c907 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 9.5 => -0.0554279190,
    mth_source_rel_fseen > 9.5                                  => 0.0131435613,
    mth_source_rel_fseen = NULL                                 => -0.0070825321,
                                                                   -0.0076444479);

final_score_154_c910 := map(
    NULL < f_corrssnnamecount_d AND f_corrssnnamecount_d <= 8.5 => -0.0005089219,
    f_corrssnnamecount_d > 8.5                                  => 0.0749920343,
    f_corrssnnamecount_d = NULL                                 => 0.0144768739,
                                                                   0.0144768739);

final_score_154_c909 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 5.5 => 0.0760427355,
    f_rel_educationover12_count_d > 5.5                                           => final_score_154_c910,
    f_rel_educationover12_count_d = NULL                                          => 0.0294447210,
                                                                                     0.0294447210);

final_score_154_c908 := map(
    NULL < f_prevaddrstatus_i AND f_prevaddrstatus_i <= 2.5 => -0.0069246299,
    f_prevaddrstatus_i > 2.5                                => 0.0129426015,
    f_prevaddrstatus_i = NULL                               => final_score_154_c909,
                                                               0.0071725638);

final_score_154 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 3.5 => 0.0390930330,
    mth_eda_dt_first_seen > 3.5                                   => final_score_154_c907,
    mth_eda_dt_first_seen = NULL                                  => final_score_154_c908,
                                                                     -0.0000885582);

final_score_155_c914 := map(
    NULL < eda_min_days_interrupt AND eda_min_days_interrupt <= 3.5 => 0.0694392168,
    eda_min_days_interrupt > 3.5                                    => -0.0045095370,
    eda_min_days_interrupt = NULL                                   => 0.0442498603,
                                                                       0.0442498603);

final_score_155_c915 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 13.5 => 0.0321316719,
    f_rel_ageover30_count_d > 13.5                                     => -0.0574534885,
    f_rel_ageover30_count_d = NULL                                     => -0.0038871039,
                                                                          -0.0038871039);

final_score_155_c913 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 107.5 => final_score_155_c914,
    f_curraddrburglaryindex_i > 107.5                                       => final_score_155_c915,
    f_curraddrburglaryindex_i = NULL                                        => 0.0208123871,
                                                                               0.0208123871);

final_score_155_c912 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Shared Associates', 'Associate By SSN', 'Father', 'Grandfather', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Wife']) => -0.0118570169,
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandmother', 'Son', 'Subject at Household'])                                        => final_score_155_c913,
    phone_subject_title = ''                                                                                                                                                                                                                                             => -0.0060054532,
                                                                                                                                                                                                                                                                            -0.0060054532);

final_score_155 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 8.5 => 0.0514262887,
    mth_pp_app_npa_last_change_dt > 8.5                                           => -0.0077902579,
    mth_pp_app_npa_last_change_dt = NULL                                          => final_score_155_c912,
                                                                                     -0.0058927222);

final_score_156_c918 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 42.5 => 0.0741443384,
    mth_pp_app_npa_last_change_dt > 42.5                                           => 0.0029869467,
    mth_pp_app_npa_last_change_dt = NULL                                           => -0.0017890363,
                                                                                      0.0061157729);

final_score_156_c917 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 5.5 => final_score_156_c918,
    f_rel_under100miles_cnt_d > 5.5                                       => 0.0703272908,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0151620527,
                                                                             0.0151620527);

final_score_156_c920 := map(
    NULL < (Integer)source_paw AND (Integer)source_paw <= 0.5 => -0.0009230910,
    (Integer)source_paw > 0.5                                 => 0.0718151386,
    (Integer)source_paw = NULL                                => 0.0007280606,
                                                                 0.0007280606);

final_score_156_c919 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.180161765666486 => -0.0574926245,
    f_add_input_mobility_index_n > 0.180161765666486                                          => final_score_156_c920,
    f_add_input_mobility_index_n = NULL                                                       => -0.0019920862,
                                                                                                 -0.0019920862);

final_score_156 := map(
    NULL < f_rel_educationover8_count_d AND f_rel_educationover8_count_d <= 6.5 => final_score_156_c917,
    f_rel_educationover8_count_d > 6.5                                          => final_score_156_c919,
    f_rel_educationover8_count_d = NULL                                         => 0.0020172248,
                                                                                   0.0020172248);

final_score_157_c925 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 223812.5 => 0.0170484575,
    f_curraddrmedianvalue_d > 223812.5                                     => -0.0512101852,
    f_curraddrmedianvalue_d = NULL                                         => -0.0045523788,
                                                                              -0.0045523788);

final_score_157_c924 := map(
    NULL < (Integer)f_util_add_input_misc_n AND (Integer)f_util_add_input_misc_n <= 0.5 => 0.0647335239,
    (Integer)f_util_add_input_misc_n > 0.5                                              => final_score_157_c925,
    (Integer)f_util_add_input_misc_n = NULL                                             => 0.0142857238,
                                                                                           0.0142857238);

final_score_157_c923 := map(
    NULL < mth_source_ppfla_lseen AND mth_source_ppfla_lseen <= 35.5 => final_score_157_c924,
    mth_source_ppfla_lseen > 35.5                                    => -0.0426705749,
    mth_source_ppfla_lseen = NULL                                    => -0.0081496414,
                                                                        -0.0074532849);

final_score_157_c922 := map(
    NULL < (Integer)source_pf AND (Integer)source_pf <= 0.5 => final_score_157_c923,
    (Integer)source_pf > 0.5                                => -0.0725817361,
    (Integer)source_pf = NULL                               => -0.0082791593,
                                                               -0.0082791593);

final_score_157 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 0.5 => 0.0509032357,
    f_rel_under100miles_cnt_d > 0.5                                       => final_score_157_c922,
    f_rel_under100miles_cnt_d = NULL                                      => -0.0071311297,
                                                                             -0.0071311297);

final_score_158_c929 := map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 9.5 => -0.0387291751,
    f_rel_homeover50_count_d > 9.5                                      => 0.0448563781,
    f_rel_homeover50_count_d = NULL                                     => 0.0062277234,
                                                                           0.0062277234);

final_score_158_c930 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 11.5 => 0.0158473096,
    mth_source_rel_fseen > 11.5                                  => 0.0417750420,
    mth_source_rel_fseen = NULL                                  => 0.0264178466,
                                                                    0.0264178466);

final_score_158_c928 := map(
    (phone_subject_title in ['Grandmother', 'Parent', 'Sibling', 'Subject', 'Subject at Household', 'Wife'])                                                                                                                                                                                                                                                                                  => final_score_158_c929,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Relative', 'Sister', 'Son', 'Spouse']) => final_score_158_c930,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                                                  => 0.0132746344,
                                                                                                                                                                                                                                                                                                                                                                                                 0.0132746344);

final_score_158_c927 := map(
    NULL < (Integer)_phone_match_code_n AND (Integer)_phone_match_code_n <= 0.5 => -0.0060696033,
    (Integer)_phone_match_code_n > 0.5                                          => final_score_158_c928,
    (Integer)_phone_match_code_n = NULL                                         => -0.0022461519,
                                                                                   -0.0022461519);

final_score_158 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 4.5 => 0.0207921707,
    mth_internal_ver_first_seen > 4.5                                         => -0.0078978959,
    mth_internal_ver_first_seen = NULL                                        => final_score_158_c927,
                                                                                 -0.0017068073);

final_score_159_c935 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= -0.5 => -0.0268777858,
    r_pb_order_freq_d > -0.5                               => 0.0434245553,
    r_pb_order_freq_d = NULL                               => 0.0093315481,
                                                              0.0119752585);

final_score_159_c934 := map(
    NULL < r_mos_since_paw_fseen_d AND r_mos_since_paw_fseen_d <= 108.5 => final_score_159_c935,
    r_mos_since_paw_fseen_d > 108.5                                     => 0.0994162006,
    r_mos_since_paw_fseen_d = NULL                                      => 0.0223393748,
                                                                           0.0223393748);

final_score_159_c933 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 32.5 => final_score_159_c934,
    mth_source_ppdid_fseen > 32.5                                    => -0.0142007385,
    mth_source_ppdid_fseen = NULL                                    => 0.0007912810,
                                                                        0.0023258816);

final_score_159_c932 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 0.5 => final_score_159_c933,
    f_srchunvrfdphonecount_i > 0.5                                      => -0.0199977332,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0029861486,
                                                                           -0.0029861486);

final_score_159 := map(
    NULL < mth_source_edaca_lseen AND mth_source_edaca_lseen <= 4 => 0.0678140938,
    mth_source_edaca_lseen > 4                                    => -0.0446667997,
    mth_source_edaca_lseen = NULL                                 => final_score_159_c932,
                                                                     -0.0027525550);

final_score_160_c938 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 15.5 => 0.1510911665,
    mth_eda_dt_first_seen > 15.5                                   => 0.0224531760,
    mth_eda_dt_first_seen = NULL                                   => 0.0659871525,
                                                                      0.0659871525);

final_score_160_c937 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 69995.5 => final_score_160_c938,
    f_prevaddrmedianincome_d > 69995.5                                      => -0.0667887936,
    f_prevaddrmedianincome_d = NULL                                         => 0.0360221530,
                                                                               0.0360221530);

final_score_160_c939 := map(
    (phone_subject_title in ['Daughter', 'Grandmother', 'Grandparent', 'Subject'])                                                                                                                                                                                                                                                                                                                                      => -0.0838673281,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject at Household', 'Wife']) => -0.0050689643,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                                                                            => -0.0261533338,
                                                                                                                                                                                                                                                                                                                                                                                                                           -0.0261533338);

final_score_160_c940 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 108.5 => -0.0072915311,
    mth_pp_eda_hist_did_dt > 108.5                                    => 0.0371193889,
    mth_pp_eda_hist_did_dt = NULL                                     => 0.0011618281,
                                                                         -0.0001558398);

final_score_160 := map(
    NULL < mth_source_cr_fseen AND mth_source_cr_fseen <= 23.5 => final_score_160_c937,
    mth_source_cr_fseen > 23.5                                 => final_score_160_c939,
    mth_source_cr_fseen = NULL                                 => final_score_160_c940,
                                                                  0.0007270965);

final_score_161_c942 := map(
    NULL < mth_source_ppla_fseen AND mth_source_ppla_fseen <= 21.5 => -0.0607885160,
    mth_source_ppla_fseen > 21.5                                   => -0.0244260407,
    mth_source_ppla_fseen = NULL                                   => -0.0024573780,
                                                                      -0.0041307104);

final_score_161_c945 := map(
    NULL < pp_did_score AND pp_did_score <= 84 => 0.0565464170,
    pp_did_score > 84                          => -0.0384623385,
    pp_did_score = NULL                        => 0.0309671367,
                                                  0.0309671367);

final_score_161_c944 := map(
    NULL < f_curraddrcrimeindex_i AND f_curraddrcrimeindex_i <= 94 => -0.0157544844,
    f_curraddrcrimeindex_i > 94                                    => final_score_161_c945,
    f_curraddrcrimeindex_i = NULL                                  => 0.0067619595,
                                                                      0.0067619595);

final_score_161_c943 := map(
    (pp_origphonetype in ['L', 'O', 'W']) => final_score_161_c944,
    (pp_origphonetype in ['', 'V'])       => 0.0893065924,
    pp_origphonetype = ''                 => 0.0185634161,
                                             0.0185634161);

final_score_161 := map(
    NULL < _pp_rule_high_vend_conf AND _pp_rule_high_vend_conf <= 0.5 => final_score_161_c942,
    _pp_rule_high_vend_conf > 0.5                                     => final_score_161_c943,
    _pp_rule_high_vend_conf = NULL                                    => -0.0005928321,
                                                                         -0.0005928321);

final_score_162_c950 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 84 => -0.0986624265,
    f_curraddrburglaryindex_i > 84                                       => -0.0205085777,
    f_curraddrburglaryindex_i = NULL                                     => -0.0526021734,
                                                                            -0.0526021734);

final_score_162_c949 := map(
    NULL < eda_min_days_interrupt AND eda_min_days_interrupt <= 0.5 => 0.0385251365,
    eda_min_days_interrupt > 0.5                                    => final_score_162_c950,
    eda_min_days_interrupt = NULL                                   => -0.0264246806,
                                                                       -0.0264246806);

final_score_162_c948 := map(
    (exp_source in ['P'])     => final_score_162_c949,
    (exp_source in ['', 'S']) => 0.0037259808,
    exp_source = ''           => 0.0022643946,
                                 0.0022643946);

final_score_162_c947 := map(
    NULL < mth_source_sp_lseen AND mth_source_sp_lseen <= 1.5 => 0.0660400729,
    mth_source_sp_lseen > 1.5                                 => -0.0049879521,
    mth_source_sp_lseen = NULL                                => final_score_162_c948,
                                                                 0.0033343074);

final_score_162 := map(
    (pp_src in ['CY', 'E1', 'E2', 'EM', 'KW', 'LP', 'NW', 'SL', 'VO'])                             => -0.0595241643,
    (pp_src in ['', 'EN', 'EQ', 'FA', 'FF', 'LA', 'MD', 'PL', 'TN', 'UT', 'UW', 'VW', 'ZK', 'ZT']) => final_score_162_c947,
    pp_src = ''                                                                                    => 0.0018710344,
                                                                                                      0.0018710344);

final_score_163_c955 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 170 => 0.0019323055,
    mth_pp_app_npa_effective_dt > 170                                         => -0.0818725239,
    mth_pp_app_npa_effective_dt = NULL                                        => -0.0348180773,
                                                                                 -0.0150807531);

final_score_163_c954 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Daughter', 'Father', 'Grandfather', 'Grandmother', 'Grandparent', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject', 'Subject at Household', 'Wife']) => final_score_163_c955,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Vehicle', 'Child', 'Grandchild', 'Granddaughter', 'Grandson', 'Husband', 'Mother', 'Spouse'])                                                                                                                        => 0.0648711997,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                     => -0.0068311964,
                                                                                                                                                                                                                                                                                                                    -0.0068311964);

final_score_163_c953 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 3.5 => 0.0419058434,
    mth_exp_last_update > 3.5                                 => final_score_163_c954,
    mth_exp_last_update = NULL                                => 0.0042171898,
                                                                 0.0030548133);

final_score_163_c952 := map(
    NULL < f_rel_educationover8_count_d AND f_rel_educationover8_count_d <= 1.5 => -0.1044423735,
    f_rel_educationover8_count_d > 1.5                                          => final_score_163_c953,
    f_rel_educationover8_count_d = NULL                                         => 0.0014856163,
                                                                                   0.0014856163);

final_score_163 := map(
    NULL < mth_source_inf_fseen AND mth_source_inf_fseen <= 209.5 => -0.0291537368,
    mth_source_inf_fseen > 209.5                                  => 0.0186998930,
    mth_source_inf_fseen = NULL                                   => final_score_163_c952,
                                                                     0.0004292413);

final_score_164_c960 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 5.5 => 0.0030289227,
    mth_pp_first_build_date > 5.5                                     => 0.0747268502,
    mth_pp_first_build_date = NULL                                    => 0.0136568458,
                                                                         0.0287160939);

final_score_164_c959 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 2.5 => final_score_164_c960,
    f_util_adl_count_n > 2.5                                => -0.0178031593,
    f_util_adl_count_n = NULL                               => 0.0060797156,
                                                               0.0060797156);

final_score_164_c958 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 3.5 => 0.0680533136,
    mth_exp_last_update > 3.5                                 => final_score_164_c959,
    mth_exp_last_update = NULL                                => 0.0088040171,
                                                                 0.0095937896);

final_score_164_c957 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 4.5 => -0.0091635874,
    f_rel_under25miles_cnt_d > 4.5                                      => final_score_164_c958,
    f_rel_under25miles_cnt_d = NULL                                     => 0.0036471487,
                                                                           0.0036471487);

final_score_164 := map(
    NULL < f_mos_inq_banko_cm_fseen_d AND f_mos_inq_banko_cm_fseen_d <= 21.5 => -0.0611721610,
    f_mos_inq_banko_cm_fseen_d > 21.5                                        => final_score_164_c957,
    f_mos_inq_banko_cm_fseen_d = NULL                                        => 0.0017607663,
                                                                                0.0017607663);

final_score_165_c962 := map(
    NULL < (Integer)inq_firstseen_n AND (Integer)inq_firstseen_n <= 32.5 => 0.0323718436,
    (Integer)inq_firstseen_n > 32.5                                      => -0.0518353198,
    (Integer)inq_firstseen_n = NULL                                      => -0.0462201482,
                                                                            -0.0309084410);

final_score_165_c965 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 22 => -0.0392029040,
    f_curraddrmurderindex_i > 22                                     => 0.0115086788,
    f_curraddrmurderindex_i = NULL                                   => 0.0070994613,
                                                                        0.0070994613);

final_score_165_c964 := map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d <= 13.5 => final_score_165_c965,
    f_rel_incomeover25_count_d > 13.5                                        => -0.0083071103,
    f_rel_incomeover25_count_d = NULL                                        => 0.0015315254,
                                                                                0.0015315254);

final_score_165_c963 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.207747486915355 => 0.0898002181,
    f_add_curr_mobility_index_n > 0.207747486915355                                         => final_score_165_c964,
    f_add_curr_mobility_index_n = NULL                                                      => 0.0029304918,
                                                                                               0.0029304918);

final_score_165 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.200370932350584 => final_score_165_c962,
    f_add_curr_mobility_index_n > 0.200370932350584                                         => final_score_165_c963,
    f_add_curr_mobility_index_n = NULL                                                      => -0.0002356995,
                                                                                               -0.0002356995);

final_score_166_c967 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 111.5 => -0.0349489644,
    f_prevaddrlenofres_d > 111.5                                  => 0.0372366757,
    f_prevaddrlenofres_d = NULL                                   => 0.0079668819,
                                                                     0.0079668819);

final_score_166_c970 := map(
    (pp_source in ['', 'GONG', 'INFUTOR', 'OTHER', 'PCNSR', 'THRIVE'])             => -0.0938525055,
    (pp_source in ['CELL', 'HEADER', 'IBEHAVIOR', 'INQUIRY', 'INTRADO', 'TARGUS']) => -0.0102783326,
    pp_source = ''                                                                 => -0.0467166720,
                                                                                      -0.0467166720);

final_score_166_c969 := map(
    NULL < number_of_sources AND number_of_sources <= 1.5 => -0.0082414816,
    number_of_sources > 1.5                               => final_score_166_c970,
    number_of_sources = NULL                              => -0.0170338011,
                                                             -0.0170338011);

final_score_166_c968 := map(
    NULL < f_inputaddractivephonelist_d AND f_inputaddractivephonelist_d <= 0.5 => 0.0034590232,
    f_inputaddractivephonelist_d > 0.5                                          => final_score_166_c969,
    f_inputaddractivephonelist_d = NULL                                         => 0.0005122369,
                                                                                   0.0005122369);

final_score_166 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 13.5 => 0.0615262125,
    mth_source_sx_fseen > 13.5                                 => final_score_166_c967,
    mth_source_sx_fseen = NULL                                 => final_score_166_c968,
                                                                  0.0016197618);

final_score_167_c974 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Daughter', 'Grandfather', 'Husband', 'Neighbor', 'Parent', 'Sibling', 'Subject', 'Wife'])                                              => 0.0134618420,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Mother', 'Relative', 'Sister', 'Son', 'Spouse', 'Subject at Household']) => 0.1187376640,
    phone_subject_title = ''                                                                                                                                                                                                                                                => 0.0439595732,
                                                                                                                                                                                                                                                                               0.0439595732);

final_score_167_c973 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.309209164748029 => 0.0005486650,
    f_add_input_mobility_index_n > 0.309209164748029                                          => final_score_167_c974,
    f_add_input_mobility_index_n = NULL                                                       => 0.0202012703,
                                                                                                 0.0202012703);

final_score_167_c972 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 89374.5 => -0.0090729660,
    f_curraddrmedianincome_d > 89374.5                                      => final_score_167_c973,
    f_curraddrmedianincome_d = NULL                                         => -0.0060100990,
                                                                               -0.0060100990);

final_score_167_c975 := map(
    NULL < f_mos_inq_banko_cm_fseen_d AND f_mos_inq_banko_cm_fseen_d <= 69.5 => 0.0912712512,
    f_mos_inq_banko_cm_fseen_d > 69.5                                        => 0.0082427518,
    f_mos_inq_banko_cm_fseen_d = NULL                                        => 0.0297095219,
                                                                                0.0297095219);

final_score_167 := map(
    NULL < eda_address_match_best AND eda_address_match_best <= 0.5 => final_score_167_c972,
    eda_address_match_best > 0.5                                    => final_score_167_c975,
    eda_address_match_best = NULL                                   => -0.0039401656,
                                                                       -0.0039401656);

final_score_168_c979 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.201885896812907 => -0.0492320657,
    f_add_input_mobility_index_n > 0.201885896812907                                          => 0.0180804419,
    f_add_input_mobility_index_n = NULL                                                       => 0.0127044014,
                                                                                                 0.0127044014);

final_score_168_c978 := map(
    NULL < mth_eda_dt_last_seen AND mth_eda_dt_last_seen <= 8.5 => -0.0079578784,
    mth_eda_dt_last_seen > 8.5                                  => 0.0155001960,
    mth_eda_dt_last_seen = NULL                                 => final_score_168_c979,
                                                                   0.0058840959);

final_score_168_c977 := map(
    NULL < f_inq_per_ssn_i AND f_inq_per_ssn_i <= 5.5 => final_score_168_c978,
    f_inq_per_ssn_i > 5.5                             => -0.0398316258,
    f_inq_per_ssn_i = NULL                            => 0.0038055576,
                                                         0.0038055576);

final_score_168_c980 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 1.5 => -0.0536073734,
    f_srchfraudsrchcountyr_i > 1.5                                      => 0.0512555259,
    f_srchfraudsrchcountyr_i = NULL                                     => -0.0314765445,
                                                                           -0.0314765445);

final_score_168 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 24.5 => final_score_168_c977,
    f_rel_ageover30_count_d > 24.5                                     => final_score_168_c980,
    f_rel_ageover30_count_d = NULL                                     => 0.0015837186,
                                                                          0.0015837186);

final_score_169_c982 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.275337860128015 => 0.0143492085,
    f_add_curr_mobility_index_n > 0.275337860128015                                         => -0.0263446312,
    f_add_curr_mobility_index_n = NULL                                                      => -0.0132362871,
                                                                                               -0.0132362871);

final_score_169_c985 := map(
    NULL < subject_ssn_mismatch AND subject_ssn_mismatch <= -0.5 => 0.0331907946,
    subject_ssn_mismatch > -0.5                                  => -0.0003694535,
    subject_ssn_mismatch = NULL                                  => 0.0094123429,
                                                                    0.0094123429);

final_score_169_c984 := map(
    NULL < eda_address_match_best AND eda_address_match_best <= 0.5 => final_score_169_c985,
    eda_address_match_best > 0.5                                    => 0.0558859217,
    eda_address_match_best = NULL                                   => 0.0116997221,
                                                                       0.0116997221);

final_score_169_c983 := map(
    NULL < f_college_income_d AND f_college_income_d <= 3.5 => 0.0261600549,
    f_college_income_d > 3.5                                => -0.0258093299,
    f_college_income_d = NULL                               => final_score_169_c984,
                                                               0.0076417231);

final_score_169 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 5.5 => final_score_169_c982,
    f_rel_under100miles_cnt_d > 5.5                                       => final_score_169_c983,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0010421135,
                                                                             0.0010421135);

final_score_170_c988 := map(
    NULL < (Integer)source_rel AND (Integer)source_rel <= 0.5 => 0.0110880341,
    (Integer)source_rel > 0.5                                 => 0.0552130095,
    (Integer)source_rel = NULL                                => 0.0131830366,
                                                                 0.0131830366);

final_score_170_c990 := map(
    (exp_source in ['P'])     => -0.0598187712,
    (exp_source in ['', 'S']) => -0.0088703885,
    exp_source = ''           => -0.0108824063,
                                 -0.0108824063);

final_score_170_c989 := map(
    NULL < mth_source_cr_fseen AND mth_source_cr_fseen <= 117.5 => -0.0030224747,
    mth_source_cr_fseen > 117.5                                 => 0.0997842217,
    mth_source_cr_fseen = NULL                                  => final_score_170_c990,
                                                                   -0.0079479522);

final_score_170_c987 := map(
    NULL < (Integer)f_util_add_curr_conv_n AND (Integer)f_util_add_curr_conv_n <= 0.5 => final_score_170_c988,
    (Integer)f_util_add_curr_conv_n > 0.5                                             => final_score_170_c989,
    (Integer)f_util_add_curr_conv_n = NULL                                            => -0.0005702991,
                                                                                         -0.0005702991);

final_score_170 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 15.5 => final_score_170_c987,
    f_rel_homeover300_count_d > 15.5                                       => 0.0487661189,
    f_rel_homeover300_count_d = NULL                                       => 0.0010781292,
                                                                              0.0010781292);

final_score_171_c995 := map(
    NULL < eda_days_ph_first_seen AND eda_days_ph_first_seen <= 5093.5 => -0.0027865595,
    eda_days_ph_first_seen > 5093.5                                    => 0.0766974644,
    eda_days_ph_first_seen = NULL                                      => 0.0008559898,
                                                                          0.0008559898);

final_score_171_c994 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandmother', 'Grandson', 'Husband', 'Neighbor', 'Relative', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_171_c995,
    (phone_subject_title in ['Associate By SSN', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Mother', 'Parent', 'Sibling'])                                                                                                                                                                                                                => 0.0780691147,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                 => 0.0032272182,
                                                                                                                                                                                                                                                                                                                                                                0.0032272182);

final_score_171_c993 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 44.5 => final_score_171_c994,
    (Integer)inq_adl_firstseen_n > 44.5                                          => 0.0615503254,
    (Integer)inq_adl_firstseen_n = NULL                                          => 0.0053090848,
                                                                                    0.0053090848);

final_score_171_c992 := map(
    NULL < mth_phone_fb_rp_date AND mth_phone_fb_rp_date <= 12.5 => 0.0763982648,
    mth_phone_fb_rp_date > 12.5                                  => -0.0200579831,
    mth_phone_fb_rp_date = NULL                                  => final_score_171_c993,
                                                                    0.0062833723);

final_score_171 := map(
    NULL < (Integer)inq_adl_lastseen_n AND (Integer)inq_adl_lastseen_n <= 50.5 => final_score_171_c992,
    (Integer)inq_adl_lastseen_n > 50.5                                         => -0.0453609319,
    (Integer)inq_adl_lastseen_n = NULL                                         => -0.0035206391,
                                                                                  0.0008867060);

final_score_172_c1000 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 9.5 => 0.0316187135,
    mth_exp_last_update > 9.5                                 => -0.0092850129,
    mth_exp_last_update = NULL                                => -0.0044859715,
                                                                 -0.0036322557);

final_score_172_c999 := map(
    (exp_source in ['P'])     => -0.0320412337,
    (exp_source in ['', 'S']) => final_score_172_c1000,
    exp_source = ''           => -0.0047629613,
                                 -0.0047629613);

final_score_172_c998 := map(
    NULL < f_estimated_income_d AND f_estimated_income_d <= 120500 => final_score_172_c999,
    f_estimated_income_d > 120500                                  => 0.0569301984,
    f_estimated_income_d = NULL                                    => -0.0036836881,
                                                                      -0.0036836881);

final_score_172_c997 := map(
    NULL < mth_source_edadid_fseen AND mth_source_edadid_fseen <= 24.5 => 0.0526962487,
    mth_source_edadid_fseen > 24.5                                     => 0.0296901419,
    mth_source_edadid_fseen = NULL                                     => final_score_172_c998,
                                                                          -0.0025581079);

final_score_172 := map(
    NULL < eda_days_ph_first_seen AND eda_days_ph_first_seen <= 5148.5 => final_score_172_c997,
    eda_days_ph_first_seen > 5148.5                                    => 0.0998532154,
    eda_days_ph_first_seen = NULL                                      => -0.0012646513,
                                                                          -0.0012646513);

final_score_173_c1004 := map(
    (pp_glb_dppa_fl in ['G'])               => -0.0003828101,
    (pp_glb_dppa_fl in ['', 'B', 'D', 'U']) => 0.0866988261,
    pp_glb_dppa_fl = ''                     => 0.0198482771,
                                               0.0198482771);

final_score_173_c1003 := map(
    NULL < mth_pp_datefirstseen AND mth_pp_datefirstseen <= 37.5 => final_score_173_c1004,
    mth_pp_datefirstseen > 37.5                                  => 0.0893578856,
    mth_pp_datefirstseen = NULL                                  => 0.0380803056,
                                                                    0.0380803056);

final_score_173_c1005 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 265 => 0.0117471184,
    f_prevaddrageoldest_d > 265                                   => -0.0762542786,
    f_prevaddrageoldest_d = NULL                                  => -0.0030845777,
                                                                     -0.0030845777);

final_score_173_c1002 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 88.5 => final_score_173_c1003,
    mth_pp_app_npa_last_change_dt > 88.5                                           => final_score_173_c1005,
    mth_pp_app_npa_last_change_dt = NULL                                           => 0.0081230656,
                                                                                      0.0120767756);

final_score_173 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 6.5 => final_score_173_c1002,
    f_rel_under100miles_cnt_d > 6.5                                       => -0.0074803729,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0000029324,
                                                                             0.0000029324);

final_score_174_c1010 := map(
    NULL < (Integer)inq_firstseen_n AND (Integer)inq_firstseen_n <= 50.5 => 0.0297467471,
    (Integer)inq_firstseen_n > 50.5                                      => -0.0416077352,
    (Integer)inq_firstseen_n = NULL                                      => 0.0337072955,
                                                                            0.0185014693);

final_score_174_c1009 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 34072 => 0.1127908596,
    f_curraddrmedianincome_d > 34072                                      => final_score_174_c1010,
    f_curraddrmedianincome_d = NULL                                       => 0.0288987000,
                                                                             0.0288987000);

final_score_174_c1008 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 1.5 => -0.0544324035,
    f_rel_incomeover50_count_d > 1.5                                        => final_score_174_c1009,
    f_rel_incomeover50_count_d = NULL                                       => 0.0210228945,
                                                                               0.0210228945);

final_score_174_c1007 := map(
    NULL < r_mos_since_paw_fseen_d AND r_mos_since_paw_fseen_d <= 29.5 => -0.0039207712,
    r_mos_since_paw_fseen_d > 29.5                                     => final_score_174_c1008,
    r_mos_since_paw_fseen_d = NULL                                     => 0.0004081045,
                                                                          0.0004081045);

final_score_174 := map(
    NULL < mth_source_ppla_lseen AND mth_source_ppla_lseen <= 13.5 => 0.0533782057,
    mth_source_ppla_lseen > 13.5                                   => -0.0177745905,
    mth_source_ppla_lseen = NULL                                   => final_score_174_c1007,
                                                                      0.0009280647);

final_score_175_c1012 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 7 => 0.0179447261,
    f_idverrisktype_i > 7                               => 0.1503036956,
    f_idverrisktype_i = NULL                            => 0.0504400420,
                                                           0.0504400420);

final_score_175_c1013 := map(
    NULL < eda_days_ph_first_seen AND eda_days_ph_first_seen <= 4760.5 => -0.0478586712,
    eda_days_ph_first_seen > 4760.5                                    => 0.0603224413,
    eda_days_ph_first_seen = NULL                                      => -0.0090365651,
                                                                          -0.0090365651);

final_score_175_c1015 := map(
    NULL < f_divaddrsuspidcountnew_i AND f_divaddrsuspidcountnew_i <= 1.5 => -0.0077396960,
    f_divaddrsuspidcountnew_i > 1.5                                       => 0.0516194959,
    f_divaddrsuspidcountnew_i = NULL                                      => -0.0056294887,
                                                                             -0.0056294887);

final_score_175_c1014 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 19757 => 0.0637615016,
    f_curraddrmedianvalue_d > 19757                                     => final_score_175_c1015,
    f_curraddrmedianvalue_d = NULL                                      => -0.0039722158,
                                                                           -0.0039722158);

final_score_175 := map(
    NULL < mth_source_cr_fseen AND mth_source_cr_fseen <= 22.5 => final_score_175_c1012,
    mth_source_cr_fseen > 22.5                                 => final_score_175_c1013,
    mth_source_cr_fseen = NULL                                 => final_score_175_c1014,
                                                                  -0.0008832939);

final_score_176_c1017 := map(
    NULL < f_inq_lnames_per_addr_i AND f_inq_lnames_per_addr_i <= 3.5 => -0.0087559357,
    f_inq_lnames_per_addr_i > 3.5                                     => 0.0435263649,
    f_inq_lnames_per_addr_i = NULL                                    => -0.0048134324,
                                                                         -0.0048134324);

final_score_176_c1020 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 30.5 => 0.0180355695,
    mth_eda_dt_first_seen > 30.5                                   => -0.0667497634,
    mth_eda_dt_first_seen = NULL                                   => -0.0116588328,
                                                                      -0.0116588328);

final_score_176_c1019 := map(
    NULL < f_rel_bankrupt_count_i AND f_rel_bankrupt_count_i <= 1.5 => 0.0532043571,
    f_rel_bankrupt_count_i > 1.5                                    => final_score_176_c1020,
    f_rel_bankrupt_count_i = NULL                                   => 0.0177803207,
                                                                       0.0177803207);

final_score_176_c1018 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Father', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Son', 'Spouse', 'Subject']) => -0.0088026637,
    (phone_subject_title in ['Associate', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Sister', 'Subject at Household', 'Wife'])                                                                                                                                => final_score_176_c1019,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                         => -0.0039781438,
                                                                                                                                                                                                                                                                                                                        -0.0039781438);

final_score_176 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 37.5 => 0.0632670065,
    mth_pp_app_npa_effective_dt > 37.5                                         => final_score_176_c1017,
    mth_pp_app_npa_effective_dt = NULL                                         => final_score_176_c1018,
                                                                                  -0.0034880949);

final_score_177_c1022 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 179 => 0.0029807843,
    f_curraddrmurderindex_i > 179                                     => 0.1387361309,
    f_curraddrmurderindex_i = NULL                                    => 0.0247338666,
                                                                         0.0247338666);

final_score_177_c1025 := map(
    (phone_subject_title in ['Brother', 'Daughter', 'Father', 'Grandfather', 'Neighbor', 'Spouse', 'Subject at Household'])                                                                                                                                                                                                                                                    => -0.0337094339,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject', 'Wife']) => 0.0916031431,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                                   => 0.0485791583,
                                                                                                                                                                                                                                                                                                                                                                                  0.0485791583);

final_score_177_c1024 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.286595532684681 => final_score_177_c1025,
    f_add_curr_mobility_index_n > 0.286595532684681                                         => 0.0062309857,
    f_add_curr_mobility_index_n = NULL                                                      => 0.0239252082,
                                                                                               0.0239252082);

final_score_177_c1023 := map(
    NULL < f_wealth_index_d AND f_wealth_index_d <= 4.5 => -0.0024513812,
    f_wealth_index_d > 4.5                              => final_score_177_c1024,
    f_wealth_index_d = NULL                             => 0.0001699847,
                                                           0.0001699847);

final_score_177 := map(
    NULL < mth_source_rm_fseen AND mth_source_rm_fseen <= 7.5 => -0.0943276087,
    mth_source_rm_fseen > 7.5                                 => final_score_177_c1022,
    mth_source_rm_fseen = NULL                                => final_score_177_c1023,
                                                                 0.0008509949);

final_score_178_c1029 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 59.5 => 0.0360900362,
    mth_pp_eda_hist_did_dt > 59.5                                    => -0.0404177811,
    mth_pp_eda_hist_did_dt = NULL                                    => 0.0018466180,
                                                                        0.0018466180);

final_score_178_c1028 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 143.5 => final_score_178_c1029,
    f_curraddrburglaryindex_i > 143.5                                       => -0.0782609586,
    f_curraddrburglaryindex_i = NULL                                        => -0.0186735494,
                                                                               -0.0186735494);

final_score_178_c1030 := map(
    NULL < _pp_rule_ins_ver_above AND _pp_rule_ins_ver_above <= 0.5 => 0.0044355096,
    _pp_rule_ins_ver_above > 0.5                                    => 0.0444243926,
    _pp_rule_ins_ver_above = NULL                                   => 0.0058768090,
                                                                       0.0058768090);

final_score_178_c1027 := map(
    NULL < mth_source_ppfla_fseen AND mth_source_ppfla_fseen <= 53.5 => final_score_178_c1028,
    mth_source_ppfla_fseen > 53.5                                    => 0.0209533046,
    mth_source_ppfla_fseen = NULL                                    => final_score_178_c1030,
                                                                        0.0049710953);

final_score_178 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By SSN', 'Associate By Vehicle', 'Father', 'Grandson', 'Husband', 'Mother', 'Sibling', 'Son', 'Spouse'])                                                                                                                                                        => -0.0415266054,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Brother', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Neighbor', 'Parent', 'Relative', 'Sister', 'Subject', 'Subject at Household', 'Wife']) => final_score_178_c1027,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                     => 0.0020923372,
                                                                                                                                                                                                                                                                                                                                    0.0020923372);

final_score_179_c1033 := map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 15.5 => 0.0886145156,
    f_rel_homeover50_count_d > 15.5                                      => -0.0234810553,
    f_rel_homeover50_count_d = NULL                                      => 0.0468297866,
                                                                            0.0468297866);

final_score_179_c1034 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By SSN', 'Brother', 'Father', 'Granddaughter', 'Grandfather', 'Grandmother', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Subject', 'Subject at Household']) => 0.0034983488,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Child', 'Daughter', 'Grandchild', 'Grandparent', 'Grandson', 'Mother', 'Sibling', 'Sister', 'Son', 'Spouse', 'Wife'])    => 0.0925298692,
    phone_subject_title = ''                                                                                                                                                                                                                           => 0.0324828118,
                                                                                                                                                                                                                                                          0.0324828118);

final_score_179_c1032 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 138.5 => final_score_179_c1033,
    mth_pp_app_npa_effective_dt > 138.5                                         => -0.0195173171,
    mth_pp_app_npa_effective_dt = NULL                                          => final_score_179_c1034,
                                                                                   0.0196270361);

final_score_179_c1035 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Vehicle', 'Brother', 'Daughter', 'Grandfather', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Sibling', 'Son'])                                                                              => -0.0239450452,
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Parent', 'Relative', 'Sister', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => 0.0022511908,
    phone_subject_title = ''                                                                                                                                                                                                                                                                => -0.0079876205,
                                                                                                                                                                                                                                                                                               -0.0079876205);

final_score_179 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 17.5 => final_score_179_c1032,
    f_prevaddrlenofres_d > 17.5                                  => final_score_179_c1035,
    f_prevaddrlenofres_d = NULL                                  => -0.0026493569,
                                                                    -0.0026493569);

final_score_180_c1039 := map(
    NULL < f_curraddrcrimeindex_i AND f_curraddrcrimeindex_i <= 153.5 => 0.0080579736,
    f_curraddrcrimeindex_i > 153.5                                    => 0.0750777100,
    f_curraddrcrimeindex_i = NULL                                     => 0.0258557459,
                                                                         0.0258557459);

final_score_180_c1040 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 30.5 => -0.0378390428,
    mth_pp_app_npa_last_change_dt > 30.5                                           => -0.0011647931,
    mth_pp_app_npa_last_change_dt = NULL                                           => -0.0007575730,
                                                                                      -0.0029809857);

final_score_180_c1038 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 18.5 => -0.0096382384,
    mth_source_utildid_fseen > 18.5                                      => final_score_180_c1039,
    mth_source_utildid_fseen = NULL                                      => final_score_180_c1040,
                                                                            -0.0012730660);

final_score_180_c1037 := map(
    NULL < mth_source_inf_lseen AND mth_source_inf_lseen <= 3.5 => 0.0093162047,
    mth_source_inf_lseen > 3.5                                  => -0.0468287875,
    mth_source_inf_lseen = NULL                                 => final_score_180_c1038,
                                                                   -0.0027608868);

final_score_180 := map(
    NULL < eda_num_phs_connected_ind AND eda_num_phs_connected_ind <= 0.5 => final_score_180_c1037,
    eda_num_phs_connected_ind > 0.5                                       => 0.0398589499,
    eda_num_phs_connected_ind = NULL                                      => -0.0017159725,
                                                                             -0.0017159725);

final_score_181_c1042 := map(
    NULL < (Integer)f_util_add_curr_conv_n AND (Integer)f_util_add_curr_conv_n <= 0.5 => 0.0149395425,
    (Integer)f_util_add_curr_conv_n > 0.5                                             => -0.0760162855,
    (Integer)f_util_add_curr_conv_n = NULL                                            => -0.0322875221,
                                                                                         -0.0322875221);

final_score_181_c1045 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.524112717031179 => 0.0309464414,
    f_add_curr_mobility_index_n > 0.524112717031179                                         => -0.0160394628,
    f_add_curr_mobility_index_n = NULL                                                      => 0.0219859886,
                                                                                               0.0219859886);

final_score_181_c1044 := map(
    NULL < (Integer)inq_adl_lastseen_n AND (Integer)inq_adl_lastseen_n <= 1.5 => -0.0116561646,
    (Integer)inq_adl_lastseen_n > 1.5                                         => final_score_181_c1045,
    (Integer)inq_adl_lastseen_n = NULL                                        => -0.0062761442,
                                                                                 -0.0062761442);

final_score_181_c1043 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 51.5 => final_score_181_c1044,
    (Integer)inq_adl_firstseen_n > 51.5                                          => -0.0554067592,
    (Integer)inq_adl_firstseen_n = NULL                                          => -0.0021484107,
                                                                                    -0.0054725782);

final_score_181 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 32.5 => 0.0182357813,
    mth_source_sx_fseen > 32.5                                 => final_score_181_c1042,
    mth_source_sx_fseen = NULL                                 => final_score_181_c1043,
                                                                  -0.0054674552);

final_score_182_c1047 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 12.5 => -0.0629227676,
    f_prevaddrageoldest_d > 12.5                                   => -0.0052725657,
    f_prevaddrageoldest_d = NULL                                   => -0.0118854896,
                                                                      -0.0118854896);

final_score_182_c1050 := map(
    (eda_pfrd_address_ind in ['1A', '1B', '1E']) => -0.0194584030,
    (eda_pfrd_address_ind in ['1C', '1D', 'XX']) => 0.0575406723,
    eda_pfrd_address_ind = ''                    => -0.0109724260,
                                                    -0.0109724260);

final_score_182_c1049 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 34.5 => 0.0063680551,
    (Integer)inq_adl_firstseen_n > 34.5                                          => 0.0575945211,
    (Integer)inq_adl_firstseen_n = NULL                                          => final_score_182_c1050,
                                                                                    0.0007427100);

final_score_182_c1048 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 17180.5 => -0.0975517812,
    f_curraddrmedianincome_d > 17180.5                                      => final_score_182_c1049,
    f_curraddrmedianincome_d = NULL                                         => -0.0024511351,
                                                                               -0.0024511351);

final_score_182 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 136.5 => final_score_182_c1047,
    mth_pp_app_npa_last_change_dt > 136.5                                           => 0.0353764034,
    mth_pp_app_npa_last_change_dt = NULL                                            => final_score_182_c1048,
                                                                                       -0.0038591514);

final_score_183_c1055 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -9867 => -0.0216564167,
    f_addrchangeincomediff_d > -9867                                      => 0.0613129593,
    f_addrchangeincomediff_d = NULL                                       => 0.0327560578,
                                                                             0.0327560578);

final_score_183_c1054 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 115.5 => -0.0234373505,
    f_curraddrburglaryindex_i > 115.5                                       => final_score_183_c1055,
    f_curraddrburglaryindex_i = NULL                                        => 0.0056398644,
                                                                               0.0056398644);

final_score_183_c1053 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 71074.5 => final_score_183_c1054,
    f_addrchangevaluediff_d > 71074.5                                     => 0.0653874774,
    f_addrchangevaluediff_d = NULL                                        => -0.0037838792,
                                                                             0.0128258429);

final_score_183_c1052 := map(
    (pp_origlistingtype in ['R', 'RB'])     => -0.0147871277,
    (pp_origlistingtype in ['', 'B', 'BG']) => final_score_183_c1053,
    pp_origlistingtype = ''                 => -0.0038948680,
                                               -0.0038948680);

final_score_183 := map(
    NULL < mth_pp_datefirstseen AND mth_pp_datefirstseen <= 116.5 => final_score_183_c1052,
    mth_pp_datefirstseen > 116.5                                  => 0.0752464627,
    mth_pp_datefirstseen = NULL                                   => 0.0012626476,
                                                                     0.0000927152);

final_score_184_c1059 := map(
    NULL < mth_pp_datefirstseen AND mth_pp_datefirstseen <= 14.5 => 0.0386790139,
    mth_pp_datefirstseen > 14.5                                  => -0.0393338816,
    mth_pp_datefirstseen = NULL                                  => -0.0157728640,
                                                                    -0.0153913971);

final_score_184_c1060 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Father', 'Grandfather', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Subject at Household', 'Wife'])                              => -0.0506037713,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Mother', 'Sister', 'Son', 'Spouse', 'Subject']) => 0.0460214501,
    phone_subject_title = ''                                                                                                                                                                                                                                        => 0.0167371707,
                                                                                                                                                                                                                                                                       0.0167371707);

final_score_184_c1058 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 11.5 => final_score_184_c1059,
    f_rel_ageover30_count_d > 11.5                                     => final_score_184_c1060,
    f_rel_ageover30_count_d = NULL                                     => -0.0030062724,
                                                                          -0.0030062724);

final_score_184_c1057 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -18558.5 => -0.0301751870,
    f_addrchangeincomediff_d > -18558.5                                      => 0.0065325143,
    f_addrchangeincomediff_d = NULL                                          => final_score_184_c1058,
                                                                                -0.0006100116);

final_score_184 := map(
    NULL < mth_source_ppth_lseen AND mth_source_ppth_lseen <= 18.5 => 0.0729089162,
    mth_source_ppth_lseen > 18.5                                   => -0.0574762382,
    mth_source_ppth_lseen = NULL                                   => final_score_184_c1057,
                                                                      -0.0016903233);

final_score_185_c1063 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 49.5 => -0.0010671107,
    (Integer)inq_adl_firstseen_n > 49.5                                          => -0.0457254762,
    (Integer)inq_adl_firstseen_n = NULL                                          => -0.0099221116,
                                                                                    -0.0062276094);

final_score_185_c1062 := map(
    NULL < mth_source_edadid_fseen AND mth_source_edadid_fseen <= 28.5 => 0.0495190998,
    mth_source_edadid_fseen > 28.5                                     => 0.0128448398,
    mth_source_edadid_fseen = NULL                                     => final_score_185_c1063,
                                                                          -0.0051140979);

final_score_185_c1065 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.308339844767412 => 0.0721021056,
    f_add_input_mobility_index_n > 0.308339844767412                                          => -0.0140674129,
    f_add_input_mobility_index_n = NULL                                                       => 0.0127940728,
                                                                                                 0.0127940728);

final_score_185_c1064 := map(
    NULL < subject_ssn_mismatch AND subject_ssn_mismatch <= -0.5 => 0.0998460473,
    subject_ssn_mismatch > -0.5                                  => final_score_185_c1065,
    subject_ssn_mismatch = NULL                                  => 0.0370072048,
                                                                    0.0370072048);

final_score_185 := map(
    (pp_src in ['', 'E1', 'E2', 'EM', 'EN', 'EQ', 'FA', 'KW', 'LP', 'NW', 'TN', 'UT', 'ZT']) => final_score_185_c1062,
    (pp_src in ['CY', 'FF', 'LA', 'MD', 'PL', 'SL', 'UW', 'VO', 'VW', 'ZK'])                 => final_score_185_c1064,
    pp_src = ''                                                                              => -0.0027514246,
                                                                                                -0.0027514246);

final_score_186_c1069 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 202 => -0.0202074194,
    r_pb_order_freq_d > 202                               => 0.0422408511,
    r_pb_order_freq_d = NULL                              => 0.0107430218,
                                                             -0.0014307926);

final_score_186_c1068 := map(
    (pp_src in ['', 'E1', 'EM', 'EN', 'EQ', 'LP', 'UT', 'VO', 'ZT'])                                 => final_score_186_c1069,
    (pp_src in ['CY', 'E2', 'FA', 'FF', 'KW', 'LA', 'MD', 'NW', 'PL', 'SL', 'TN', 'UW', 'VW', 'ZK']) => 0.0677502873,
    pp_src = ''                                                                                      => 0.0026274925,
                                                                                                        0.0026274925);

final_score_186_c1070 := map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 6.5 => 0.1667148116,
    f_corrrisktype_i > 6.5                              => 0.0128424409,
    f_corrrisktype_i = NULL                             => 0.0880903714,
                                                           0.0880903714);

final_score_186_c1067 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandson', 'Husband', 'Neighbor', 'Sibling', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_186_c1068,
    (phone_subject_title in ['Associate By Property', 'Associate By Shared Associates', 'Father', 'Grandchild', 'Grandparent', 'Mother', 'Parent', 'Relative', 'Sister'])                                                                                                                                                        => final_score_186_c1070,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                     => 0.0135281956,
                                                                                                                                                                                                                                                                                                                                    0.0135281956);

final_score_186 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 1.5 => final_score_186_c1067,
    f_rel_ageover40_count_d > 1.5                                     => -0.0060313886,
    f_rel_ageover40_count_d = NULL                                    => 0.0000446914,
                                                                         0.0000446914);

final_score_187_c1073 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 60908 => 0.0104048034,
    f_prevaddrmedianincome_d > 60908                                      => 0.0850075321,
    f_prevaddrmedianincome_d = NULL                                       => 0.0342776766,
                                                                             0.0342776766);

final_score_187_c1072 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 267.5 => final_score_187_c1073,
    f_prevaddrageoldest_d > 267.5                                   => -0.0420720138,
    f_prevaddrageoldest_d = NULL                                    => 0.0230913066,
                                                                       0.0230913066);

final_score_187_c1075 := map(
    NULL < _pp_app_ported_match_7 AND _pp_app_ported_match_7 <= 0.5 => 0.1037780174,
    _pp_app_ported_match_7 > 0.5                                    => -0.0023842474,
    _pp_app_ported_match_7 = NULL                                   => 0.0480428284,
                                                                       0.0480428284);

final_score_187_c1074 := map(
    NULL < f_vardobcount_i AND f_vardobcount_i <= 2.5 => -0.0115461933,
    f_vardobcount_i > 2.5                             => final_score_187_c1075,
    f_vardobcount_i = NULL                            => -0.0059603459,
                                                         -0.0059603459);

final_score_187 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 6.5 => final_score_187_c1072,
    mth_pp_datevendorfirstseen > 6.5                                        => final_score_187_c1074,
    mth_pp_datevendorfirstseen = NULL                                       => -0.0001887750,
                                                                               -0.0002969703);

final_score_188_c1078 := map(
    NULL < mth_pp_orig_lastseen AND mth_pp_orig_lastseen <= 12.5 => -0.0241601862,
    mth_pp_orig_lastseen > 12.5                                  => 0.0414488840,
    mth_pp_orig_lastseen = NULL                                  => 0.0081588695,
                                                                    0.0081588695);

final_score_188_c1080 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 21.5 => -0.0880981670,
    f_rel_under500miles_cnt_d > 21.5                                       => 0.0106333336,
    f_rel_under500miles_cnt_d = NULL                                       => -0.0376212905,
                                                                              -0.0376212905);

final_score_188_c1079 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 15.5 => 0.0069896032,
    f_rel_homeover100_count_d > 15.5                                       => final_score_188_c1080,
    f_rel_homeover100_count_d = NULL                                       => 0.0020940535,
                                                                              0.0020940535);

final_score_188_c1077 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 51.5 => final_score_188_c1078,
    mth_source_utildid_fseen > 51.5                                      => 0.0722703157,
    mth_source_utildid_fseen = NULL                                      => final_score_188_c1079,
                                                                            0.0050249616);

final_score_188 := map(
    NULL < mth_pp_orig_lastseen AND mth_pp_orig_lastseen <= 64.5 => final_score_188_c1077,
    mth_pp_orig_lastseen > 64.5                                  => -0.0627163498,
    mth_pp_orig_lastseen = NULL                                  => 0.0038075336,
                                                                    0.0021980313);

final_score_189_c1085 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 107.5 => -0.0068214769,
    f_prevaddrageoldest_d > 107.5                                   => 0.1069180918,
    f_prevaddrageoldest_d = NULL                                    => 0.0444806363,
                                                                       0.0444806363);

final_score_189_c1084 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 34.5 => final_score_189_c1085,
    mth_pp_datevendorfirstseen > 34.5                                        => -0.0146874200,
    mth_pp_datevendorfirstseen = NULL                                        => 0.0287024879,
                                                                                0.0287024879);

final_score_189_c1083 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 13.5 => final_score_189_c1084,
    f_rel_under100miles_cnt_d > 13.5                                       => -0.0436481597,
    f_rel_under100miles_cnt_d = NULL                                       => 0.0080686652,
                                                                              0.0080686652);

final_score_189_c1082 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 89.5 => 0.0887013042,
    mth_pp_app_npa_effective_dt > 89.5                                         => final_score_189_c1083,
    mth_pp_app_npa_effective_dt = NULL                                         => 0.0207023506,
                                                                                  0.0207023506);

final_score_189 := map(
    (pp_app_scc in ['', 'A', 'B', 'C', 'N', 'R']) => -0.0017406613,
    (pp_app_scc in ['8', 'J', 'S'])               => final_score_189_c1082,
    pp_app_scc = ''                               => 0.0000684522,
                                                     0.0000684522);

final_score_190_c1087 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 13224 => 0.1291160197,
    f_addrchangevaluediff_d > 13224                                     => 0.0107608012,
    f_addrchangevaluediff_d = NULL                                      => 0.0729945311,
                                                                           0.0729945311);

final_score_190_c1090 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By SSN', 'Brother', 'Daughter', 'Grandfather', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Subject at Household']) => 0.0045499627,
    (phone_subject_title in ['Associate By Shared Associates', 'Associate By Vehicle', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Son', 'Wife'])                                                                                                      => 0.1115169134,
    phone_subject_title = ''                                                                                                                                                                                                                                                                            => 0.0114976263,
                                                                                                                                                                                                                                                                                                           0.0114976263);

final_score_190_c1089 := map(
    NULL < _pp_app_nonpub_targ_lap AND _pp_app_nonpub_targ_lap <= 0.5 => final_score_190_c1090,
    _pp_app_nonpub_targ_lap > 0.5                                     => 0.1208914460,
    _pp_app_nonpub_targ_lap = NULL                                    => 0.0161789928,
                                                                         0.0161789928);

final_score_190_c1088 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 6.5 => final_score_190_c1089,
    f_rel_ageover30_count_d > 6.5                                     => -0.0054906538,
    f_rel_ageover30_count_d = NULL                                    => 0.0014138632,
                                                                         0.0014138632);

final_score_190 := map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 1.5 => final_score_190_c1087,
    f_sourcerisktype_i > 1.5                                => final_score_190_c1088,
    f_sourcerisktype_i = NULL                               => 0.0038956099,
                                                               0.0038956099);

final_score_191_c1092 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 314.5 => -0.0005025473,
    r_pb_order_freq_d > 314.5                               => 0.0900465437,
    r_pb_order_freq_d = NULL                                => 0.0142386766,
                                                               0.0101478108);

final_score_191_c1095 := map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i <= 30.5 => -0.0326335553,
    f_prevaddrmurderindex_i > 30.5                                     => 0.0136923342,
    f_prevaddrmurderindex_i = NULL                                     => 0.0063777201,
                                                                          0.0063777201);

final_score_191_c1094 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.30221421415202 => -0.0185385204,
    f_add_curr_mobility_index_n > 0.30221421415202                                         => final_score_191_c1095,
    f_add_curr_mobility_index_n = NULL                                                     => -0.0034350567,
                                                                                              -0.0034350567);

final_score_191_c1093 := map(
    NULL < mth_source_ppca_fseen AND mth_source_ppca_fseen <= 25.5 => -0.0507626714,
    mth_source_ppca_fseen > 25.5                                   => -0.0041102717,
    mth_source_ppca_fseen = NULL                                   => final_score_191_c1094,
                                                                      -0.0067081288);

final_score_191 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 0.5 => final_score_191_c1092,
    f_rel_homeover200_count_d > 0.5                                       => final_score_191_c1093,
    f_rel_homeover200_count_d = NULL                                      => -0.0013567710,
                                                                             -0.0013567710);

final_score_192_c1099 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 55554.5 => -0.0131619899,
    f_addrchangeincomediff_d > 55554.5                                      => 0.0605488724,
    f_addrchangeincomediff_d = NULL                                         => -0.0105092963,
                                                                               -0.0104310485);

final_score_192_c1098 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 8.5 => -0.0629666295,
    mth_source_ppca_lseen > 8.5                                   => 0.0149825699,
    mth_source_ppca_lseen = NULL                                  => final_score_192_c1099,
                                                                     -0.0105381914);

final_score_192_c1100 := map(
    (exp_source in ['', 'P']) => 0.0124921907,
    (exp_source in ['S'])     => 0.0608025919,
    exp_source = ''           => 0.0156516747,
                                 0.0156516747);

final_score_192_c1097 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By Vehicle', 'Daughter', 'Father', 'Granddaughter', 'Grandparent', 'Grandson', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Son', 'Subject', 'Subject at Household']) => final_score_192_c1098,
    (phone_subject_title in ['Associate By Address', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Grandchild', 'Grandfather', 'Grandmother', 'Mother', 'Sibling', 'Sister', 'Spouse', 'Wife'])                                                  => final_score_192_c1100,
    phone_subject_title = ''                                                                                                                                                                                                                                                  => -0.0035989629,
                                                                                                                                                                                                                                                                                 -0.0035989629);

final_score_192 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 7.5 => final_score_192_c1097,
    f_rel_ageover40_count_d > 7.5                                     => 0.0213920378,
    f_rel_ageover40_count_d = NULL                                    => 0.0004176143,
                                                                         0.0004176143);

final_score_193_c1102 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -138907.5 => 0.0689298830,
    f_addrchangevaluediff_d > -138907.5                                     => -0.0090372172,
    f_addrchangevaluediff_d = NULL                                          => 0.0069279743,
                                                                               -0.0005621050);

final_score_193_c1105 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.288491330684013 => -0.0437782967,
    f_add_curr_mobility_index_n > 0.288491330684013                                         => 0.0662853698,
    f_add_curr_mobility_index_n = NULL                                                      => 0.0262305544,
                                                                                               0.0262305544);

final_score_193_c1104 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 97.5 => final_score_193_c1105,
    mth_pp_app_npa_last_change_dt > 97.5                                           => -0.0315185539,
    mth_pp_app_npa_last_change_dt = NULL                                           => 0.0014320355,
                                                                                      0.0017365237);

final_score_193_c1103 := map(
    NULL < mth_source_ppca_fseen AND mth_source_ppca_fseen <= 22.5 => 0.1033772018,
    mth_source_ppca_fseen > 22.5                                   => -0.0366774944,
    mth_source_ppca_fseen = NULL                                   => final_score_193_c1104,
                                                                      0.0029948271);

final_score_193 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 72.5 => final_score_193_c1102,
    mth_pp_eda_hist_did_dt > 72.5                                    => -0.0292645224,
    mth_pp_eda_hist_did_dt = NULL                                    => final_score_193_c1103,
                                                                        -0.0014428177);

final_score_194_c1108 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 58546 => -0.0557476468,
    f_prevaddrmedianincome_d > 58546                                      => 0.0169743486,
    f_prevaddrmedianincome_d = NULL                                       => -0.0320814050,
                                                                             -0.0320814050);

final_score_194_c1110 := map(
    NULL < f_corrssnnamecount_d AND f_corrssnnamecount_d <= 3.5 => 0.0271206895,
    f_corrssnnamecount_d > 3.5                                  => -0.0003824009,
    f_corrssnnamecount_d = NULL                                 => 0.0030343469,
                                                                   0.0030343469);

final_score_194_c1109 := map(
    (pp_origphoneusage in ['H', 'M', 'O']) => -0.0780525455,
    (pp_origphoneusage in ['', 'P', 'S'])  => final_score_194_c1110,
    pp_origphoneusage = ''                 => 0.0017630079,
                                              0.0017630079);

final_score_194_c1107 := map(
    NULL < _phone_timezone_match AND _phone_timezone_match <= 0.5 => final_score_194_c1108,
    _phone_timezone_match > 0.5                                   => final_score_194_c1109,
    _phone_timezone_match = NULL                                  => -0.0009474568,
                                                                     -0.0009474568);

final_score_194 := map(
    NULL < number_of_sources AND number_of_sources <= 4.5 => final_score_194_c1107,
    number_of_sources > 4.5                               => 0.0483253687,
    number_of_sources = NULL                              => 0.0001019397,
                                                             0.0001019397);

final_score_195_c1115 := map(
    NULL < f_idrisktype_i AND f_idrisktype_i <= 1.5 => 0.0087108138,
    f_idrisktype_i > 1.5                            => -0.0753705872,
    f_idrisktype_i = NULL                           => 0.0056547834,
                                                       0.0056547834);

final_score_195_c1114 := map(
    NULL < mth_pp_datelastseen AND mth_pp_datelastseen <= 50.5 => final_score_195_c1115,
    mth_pp_datelastseen > 50.5                                 => -0.0544441041,
    mth_pp_datelastseen = NULL                                 => 0.0031273685,
                                                                  0.0017365258);

final_score_195_c1113 := map(
    NULL < f_srchssnsrchcount_i AND f_srchssnsrchcount_i <= 29.5 => final_score_195_c1114,
    f_srchssnsrchcount_i > 29.5                                  => -0.0739297453,
    f_srchssnsrchcount_i = NULL                                  => 0.0002015759,
                                                                    0.0002015759);

final_score_195_c1112 := map(
    NULL < _internal_ver_match_level AND _internal_ver_match_level <= 2.5 => final_score_195_c1113,
    _internal_ver_match_level > 2.5                                       => 0.0460078561,
    _internal_ver_match_level = NULL                                      => 0.0009657801,
                                                                             0.0009657801);

final_score_195 := map(
    NULL < eda_num_phs_connected_addr AND eda_num_phs_connected_addr <= 1.5 => final_score_195_c1112,
    eda_num_phs_connected_addr > 1.5                                        => -0.0868627430,
    eda_num_phs_connected_addr = NULL                                       => -0.0001652460,
                                                                               -0.0001652460);

final_score_196_c1118 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.530887638291045 => 0.0125026410,
    f_add_curr_mobility_index_n > 0.530887638291045                                         => 0.0961263081,
    f_add_curr_mobility_index_n = NULL                                                      => 0.0265980403,
                                                                                               0.0265980403);

final_score_196_c1117 := map(
    NULL < f_rel_bankrupt_count_i AND f_rel_bankrupt_count_i <= 3.5 => -0.0101061036,
    f_rel_bankrupt_count_i > 3.5                                    => final_score_196_c1118,
    f_rel_bankrupt_count_i = NULL                                   => -0.0010638923,
                                                                       -0.0010638923);

final_score_196_c1119 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 0.5 => 0.0189992406,
    (Integer)inq_adl_firstseen_n > 0.5                                          => 0.0745764282,
    (Integer)inq_adl_firstseen_n = NULL                                         => 0.0135124018,
                                                                                   0.0260162490);

final_score_196_c1120 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 23.5 => 0.0023768627,
    f_rel_educationover12_count_d > 23.5                                           => -0.0537664142,
    f_rel_educationover12_count_d = NULL                                           => -0.0015445371,
                                                                                      -0.0015445371);

final_score_196 := map(
    NULL < mth_pp_orig_lastseen AND mth_pp_orig_lastseen <= 19.5 => final_score_196_c1117,
    mth_pp_orig_lastseen > 19.5                                  => final_score_196_c1119,
    mth_pp_orig_lastseen = NULL                                  => final_score_196_c1120,
                                                                    0.0023399225);

final_score_197_c1125 := map(
    NULL < inq_num AND inq_num <= 0.5 => 0.0000505293,
    inq_num > 0.5                     => 0.0343022285,
    inq_num = NULL                    => 0.0045357587,
                                         0.0045357587);

final_score_197_c1124 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 34.5 => -0.0321692233,
    mth_source_utildid_fseen > 34.5                                      => 0.0436854686,
    mth_source_utildid_fseen = NULL                                      => final_score_197_c1125,
                                                                            0.0040352871);

final_score_197_c1123 := map(
    NULL < (Integer)inq_adl_lastseen_n AND (Integer)inq_adl_lastseen_n <= 38.5 => final_score_197_c1124,
    (Integer)inq_adl_lastseen_n > 38.5                                         => -0.0271304892,
    (Integer)inq_adl_lastseen_n = NULL                                         => -0.0077149079,
                                                                                  -0.0022519137);

final_score_197_c1122 := map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i <= 197.5 => final_score_197_c1123,
    f_prevaddrmurderindex_i > 197.5                                     => -0.0726580876,
    f_prevaddrmurderindex_i = NULL                                      => -0.0032003539,
                                                                           -0.0032003539);

final_score_197 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 1.5 => final_score_197_c1122,
    f_srchunvrfdaddrcount_i > 1.5                                     => 0.0874628127,
    f_srchunvrfdaddrcount_i = NULL                                    => -0.0017072631,
                                                                         -0.0017072631);

final_score_198_c1128 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 95.5 => -0.0244236006,
    r_pb_order_freq_d > 95.5                               => -0.0900776057,
    r_pb_order_freq_d = NULL                               => 0.0124450176,
                                                              -0.0227302834);

final_score_198_c1130 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 0.5 => 0.0758359769,
    f_util_adl_count_n > 0.5                                => 0.0028918926,
    f_util_adl_count_n = NULL                               => 0.0229761591,
                                                               0.0229761591);

final_score_198_c1129 := map(
    NULL < (Integer)_internal_ver_match_hhid AND (Integer)_internal_ver_match_hhid <= 0.5 => -0.0050244543,
    (Integer)_internal_ver_match_hhid > 0.5                                               => final_score_198_c1130,
    (Integer)_internal_ver_match_hhid = NULL                                              => -0.0026259066,
                                                                                             -0.0026259066);

final_score_198_c1127 := map(
    NULL < mth_source_cr_fseen AND mth_source_cr_fseen <= 166.5 => final_score_198_c1128,
    mth_source_cr_fseen > 166.5                                 => 0.0895711100,
    mth_source_cr_fseen = NULL                                  => final_score_198_c1129,
                                                                   -0.0036181067);

final_score_198 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 22.5 => final_score_198_c1127,
    f_rel_incomeover50_count_d > 22.5                                        => -0.0716272586,
    f_rel_incomeover50_count_d = NULL                                        => -0.0051543690,
                                                                                -0.0051543690);

final_score_199_c1132 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.393940853641964 => -0.0533619145,
    f_add_input_mobility_index_n > 0.393940853641964                                          => -0.0384696787,
    f_add_input_mobility_index_n = NULL                                                       => -0.0468735960,
                                                                                                 -0.0468735960);

final_score_199_c1135 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 153.5 => 0.0182647114,
    f_fp_prevaddrburglaryindex_i > 153.5                                          => -0.0172387623,
    f_fp_prevaddrburglaryindex_i = NULL                                           => 0.0094076717,
                                                                                     0.0094076717);

final_score_199_c1134 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 33.5 => -0.0201582563,
    f_prevaddrageoldest_d > 33.5                                   => final_score_199_c1135,
    f_prevaddrageoldest_d = NULL                                   => 0.0010038732,
                                                                      0.0010038732);

final_score_199_c1133 := map(
    (pp_did_type in ['AMBIG', 'C_MERGE', 'CORE']) => final_score_199_c1134,
    (pp_did_type in ['', 'INACTIVE', 'NO_SSN'])   => 0.0748124509,
    pp_did_type = ''                              => 0.0037862538,
                                                     0.0037862538);

final_score_199 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 3.5 => final_score_199_c1132,
    mth_pp_datevendorfirstseen > 3.5                                        => final_score_199_c1133,
    mth_pp_datevendorfirstseen = NULL                                       => -0.0039245161,
                                                                               -0.0019548926);

final_score_200_c1137 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 21.5 => 0.0376232621,
    mth_source_ppdid_lseen > 21.5                                    => -0.0491835833,
    mth_source_ppdid_lseen = NULL                                    => -0.0156403922,
                                                                        -0.0142786674);

final_score_200_c1140 := map(
    NULL < f_srchaddrsrchcount_i AND f_srchaddrsrchcount_i <= 4.5 => 0.1239397930,
    f_srchaddrsrchcount_i > 4.5                                   => -0.0137893651,
    f_srchaddrsrchcount_i = NULL                                  => 0.0708156892,
                                                                     0.0708156892);

final_score_200_c1139 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 12.5 => 0.0042353403,
    f_rel_homeover100_count_d > 12.5                                       => final_score_200_c1140,
    f_rel_homeover100_count_d = NULL                                       => 0.0155957898,
                                                                              0.0155957898);

final_score_200_c1138 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 67.5 => -0.0516672426,
    mth_pp_app_npa_effective_dt > 67.5                                         => 0.0112213361,
    mth_pp_app_npa_effective_dt = NULL                                         => final_score_200_c1139,
                                                                                  0.0093347528);

final_score_200 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By SSN', 'Child', 'Daughter', 'Father', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject at Household', 'Wife']) => final_score_200_c1137,
    (phone_subject_title in ['Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Grandchild', 'Granddaughter', 'Grandfather', 'Mother', 'Son', 'Subject'])                                                                                                => final_score_200_c1138,
    phone_subject_title = ''                                                                                                                                                                                                                                                                         => -0.0027146410,
                                                                                                                                                                                                                                                                                                        -0.0027146410);

final_score_201_c1144 := map(
    (pp_src in ['CY', 'E1', 'E2', 'FA', 'KW', 'NW', 'SL', 'UT', 'UW', 'VO'])                 => -0.0199949322,
    (pp_src in ['', 'EM', 'EN', 'EQ', 'FF', 'LA', 'LP', 'MD', 'PL', 'TN', 'VW', 'ZK', 'ZT']) => 0.0119804144,
    pp_src = ''                                                                              => 0.0068581501,
                                                                                                0.0068581501);

final_score_201_c1143 := map(
    NULL < f_bus_name_nover_i AND f_bus_name_nover_i <= 0.5 => final_score_201_c1144,
    f_bus_name_nover_i > 0.5                                => -0.0143659687,
    f_bus_name_nover_i = NULL                               => -0.0009972004,
                                                               -0.0009972004);

final_score_201_c1142 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 0.5 => 0.0691720908,
    f_rel_under100miles_cnt_d > 0.5                                       => final_score_201_c1143,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0003567833,
                                                                             0.0003567833);

final_score_201_c1145 := map(
    (phone_subject_title in ['Associate By SSN', 'Associate By Vehicle', 'Daughter', 'Grandfather', 'Grandson', 'Husband', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject', 'Wife'])                                                                                                      => -0.0074798807,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Brother', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Mother', 'Parent', 'Spouse', 'Subject at Household']) => 0.1382286445,
    phone_subject_title = ''                                                                                                                                                                                                                                                                            => 0.0485618597,
                                                                                                                                                                                                                                                                                                           0.0485618597);

final_score_201 := map(
    NULL < f_divrisktype_i AND f_divrisktype_i <= 2.5 => final_score_201_c1142,
    f_divrisktype_i > 2.5                             => final_score_201_c1145,
    f_divrisktype_i = NULL                            => 0.0026070698,
                                                         0.0026070698);

final_score_202_c1148 := map(
    (exp_source in ['P'])     => -0.0434672801,
    (exp_source in ['', 'S']) => -0.0033538650,
    exp_source = ''           => -0.0056110945,
                                 -0.0056110945);

final_score_202_c1147 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 1.5 => 0.0553174219,
    mth_internal_ver_first_seen > 1.5                                         => 0.0004375641,
    mth_internal_ver_first_seen = NULL                                        => final_score_202_c1148,
                                                                                 -0.0023061195);

final_score_202_c1150 := map(
    NULL < mth_source_cr_fseen AND mth_source_cr_fseen <= 19.5 => 0.0690946637,
    mth_source_cr_fseen > 19.5                                 => -0.0691714183,
    mth_source_cr_fseen = NULL                                 => -0.0170265367,
                                                                  -0.0036902836);

final_score_202_c1149 := map(
    NULL < mth_eda_dt_last_seen AND mth_eda_dt_last_seen <= 4.5 => final_score_202_c1150,
    mth_eda_dt_last_seen > 4.5                                  => 0.1253869922,
    mth_eda_dt_last_seen = NULL                                 => 0.0415738093,
                                                                   0.0415738093);

final_score_202 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Grandmother', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_202_c1147,
    (phone_subject_title in ['Associate By Business', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Relative'])                                                                                                                                                                              => final_score_202_c1149,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                => 0.0005246683,
                                                                                                                                                                                                                                                                                                                                               0.0005246683);

final_score_203_c1152 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 34764.5 => 0.0668007626,
    f_prevaddrmedianincome_d > 34764.5                                      => -0.0193396422,
    f_prevaddrmedianincome_d = NULL                                         => 0.0022494317,
                                                                               0.0022494317);

final_score_203_c1155 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 47141.5 => -0.0757262863,
    f_prevaddrmedianincome_d > 47141.5                                      => 0.0348121358,
    f_prevaddrmedianincome_d = NULL                                         => -0.0186299939,
                                                                               -0.0186299939);

final_score_203_c1154 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -4.5 => -0.0604281895,
    f_addrchangecrimediff_i > -4.5                                     => -0.0006046577,
    f_addrchangecrimediff_i = NULL                                     => final_score_203_c1155,
                                                                          -0.0257252921);

final_score_203_c1153 := map(
    (pp_source in ['GONG', 'INFUTOR', 'INTRADO', 'OTHER', 'THRIVE'])                 => final_score_203_c1154,
    (pp_source in ['', 'CELL', 'HEADER', 'IBEHAVIOR', 'INQUIRY', 'PCNSR', 'TARGUS']) => 0.0028435633,
    pp_source = ''                                                                   => -0.0007766064,
                                                                                        -0.0007766064);

final_score_203 := map(
    NULL < mth_source_inf_lseen AND mth_source_inf_lseen <= 3.5 => -0.0582369515,
    mth_source_inf_lseen > 3.5                                  => final_score_203_c1152,
    mth_source_inf_lseen = NULL                                 => final_score_203_c1153,
                                                                   -0.0019077943);

final_score_204_c1158 := map(
    NULL < f_crim_rel_under100miles_cnt_i AND f_crim_rel_under100miles_cnt_i <= 8.5 => -0.0006430686,
    f_crim_rel_under100miles_cnt_i > 8.5                                            => -0.0621991836,
    f_crim_rel_under100miles_cnt_i = NULL                                           => -0.0034406428,
                                                                                       -0.0034406428);

final_score_204_c1160 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.1997104970689 => -0.0425919162,
    f_add_curr_mobility_index_n > 0.1997104970689                                         => 0.0112463447,
    f_add_curr_mobility_index_n = NULL                                                    => 0.0019993151,
                                                                                             0.0019993151);

final_score_204_c1159 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Grandfather', 'Grandmother', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject', 'Wife']) => final_score_204_c1160,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Vehicle', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandparent', 'Grandson', 'Husband', 'Spouse', 'Subject at Household'])                                                          => 0.0885747968,
    phone_subject_title = ''                                                                                                                                                                                                                                                      => 0.0173725315,
                                                                                                                                                                                                                                                                                     0.0173725315);

final_score_204_c1157 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 8.5 => final_score_204_c1158,
    f_rel_ageover40_count_d > 8.5                                     => final_score_204_c1159,
    f_rel_ageover40_count_d = NULL                                    => -0.0007517393,
                                                                         -0.0007517393);

final_score_204 := map(
    NULL < mth_source_ppfla_lseen AND mth_source_ppfla_lseen <= 45.5 => -0.0208462533,
    mth_source_ppfla_lseen > 45.5                                    => 0.0331129538,
    mth_source_ppfla_lseen = NULL                                    => final_score_204_c1157,
                                                                        -0.0014955423);

final_score_205_c1164 := map(
    (pp_origphonetype in ['V', 'W'])     => -0.0296572267,
    (pp_origphonetype in ['', 'L', 'O']) => 0.0075976332,
    pp_origphonetype = ''                => -0.0114451328,
                                            -0.0114451328);

final_score_205_c1165 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.404655844485793 => 0.0748870937,
    f_add_input_mobility_index_n > 0.404655844485793                                          => -0.0017211131,
    f_add_input_mobility_index_n = NULL                                                       => 0.0398465686,
                                                                                                 0.0398465686);

final_score_205_c1163 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 15.5 => final_score_205_c1164,
    f_rel_incomeover50_count_d > 15.5                                        => final_score_205_c1165,
    f_rel_incomeover50_count_d = NULL                                        => -0.0069558783,
                                                                                -0.0069558783);

final_score_205_c1162 := map(
    (pp_glb_dppa_fl in ['D', 'G'])     => final_score_205_c1163,
    (pp_glb_dppa_fl in ['', 'B', 'U']) => 0.0327425919,
    pp_glb_dppa_fl = ''                => 0.0019276129,
                                          0.0019276129);

final_score_205 := map(
    NULL < mth_pp_datelastseen AND mth_pp_datelastseen <= 57.5 => final_score_205_c1162,
    mth_pp_datelastseen > 57.5                                 => -0.0650231799,
    mth_pp_datelastseen = NULL                                 => 0.0016088230,
                                                                  -0.0006262756);

final_score_206_c1167 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -10.5 => 0.0944961421,
    f_addrchangecrimediff_i > -10.5                                     => 0.0233808931,
    f_addrchangecrimediff_i = NULL                                      => 0.0591086498,
                                                                           0.0591086498);

final_score_206_c1169 := map(
    NULL < _phone_timezone_match AND _phone_timezone_match <= 0.5 => -0.0340734729,
    _phone_timezone_match > 0.5                                   => 0.0056722321,
    _phone_timezone_match = NULL                                  => 0.0021899120,
                                                                     0.0021899120);

final_score_206_c1170 := map(
    NULL < (Integer)inq_firstseen_n AND (Integer)inq_firstseen_n <= 29.5 => 0.0371696796,
    (Integer)inq_firstseen_n > 29.5                                      => -0.0530404391,
    (Integer)inq_firstseen_n = NULL                                      => -0.0801435907,
                                                                            -0.0420623266);

final_score_206_c1168 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 24.5 => final_score_206_c1169,
    f_rel_ageover30_count_d > 24.5                                     => final_score_206_c1170,
    f_rel_ageover30_count_d = NULL                                     => -0.0007020850,
                                                                          -0.0007020850);

final_score_206 := map(
    NULL < mth_source_ppla_fseen AND mth_source_ppla_fseen <= 26.5 => -0.0061559780,
    mth_source_ppla_fseen > 26.5                                   => final_score_206_c1167,
    mth_source_ppla_fseen = NULL                                   => final_score_206_c1168,
                                                                      0.0010896899);

final_score_207_c1175 := map(
    NULL < r_has_paw_source_d AND r_has_paw_source_d <= 0.5 => -0.0042143342,
    r_has_paw_source_d > 0.5                                => 0.0709213300,
    r_has_paw_source_d = NULL                               => 0.0362619752,
                                                               0.0362619752);

final_score_207_c1174 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 12.5 => -0.0222500555,
    (Integer)inq_adl_firstseen_n > 12.5                                          => 0.0734528295,
    (Integer)inq_adl_firstseen_n = NULL                                          => final_score_207_c1175,
                                                                                    0.0302861827);

final_score_207_c1173 := map(
    NULL < f_crim_rel_under500miles_cnt_i AND f_crim_rel_under500miles_cnt_i <= 1.5 => final_score_207_c1174,
    f_crim_rel_under500miles_cnt_i > 1.5                                            => -0.0097038786,
    f_crim_rel_under500miles_cnt_i = NULL                                           => 0.0078891516,
                                                                                       0.0078891516);

final_score_207_c1172 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 20.5 => -0.0216335227,
    mth_source_utildid_fseen > 20.5                                      => 0.0495550130,
    mth_source_utildid_fseen = NULL                                      => final_score_207_c1173,
                                                                            0.0105902234);

final_score_207 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 32.5 => final_score_207_c1172,
    mth_source_ppdid_lseen > 32.5                                    => -0.0279213969,
    mth_source_ppdid_lseen = NULL                                    => -0.0057723975,
                                                                        -0.0040847678);

final_score_208_c1178 := map(
    NULL < pp_did_score AND pp_did_score <= 97.5 => 0.0142868157,
    pp_did_score > 97.5                          => -0.0249566242,
    pp_did_score = NULL                          => 0.0022748012,
                                                    0.0022748012);

final_score_208_c1177 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 15.5 => final_score_208_c1178,
    f_rel_incomeover50_count_d > 15.5                                        => 0.0773122493,
    f_rel_incomeover50_count_d = NULL                                        => 0.0074613777,
                                                                                0.0074613777);

final_score_208_c1180 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 186.5 => 0.0396943281,
    f_prevaddrlenofres_d > 186.5                                  => -0.0244081084,
    f_prevaddrlenofres_d = NULL                                   => 0.0205246471,
                                                                     0.0205246471);

final_score_208_c1179 := map(
    NULL < (Integer)_phone_match_code_n AND (Integer)_phone_match_code_n <= 0.5 => -0.0105856946,
    (Integer)_phone_match_code_n > 0.5                                          => final_score_208_c1180,
    (Integer)_phone_match_code_n = NULL                                         => -0.0032035796,
                                                                                   -0.0032035796);

final_score_208 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 7.5 => final_score_208_c1177,
    mth_pp_first_build_date > 7.5                                     => -0.0165398865,
    mth_pp_first_build_date = NULL                                    => final_score_208_c1179,
                                                                         -0.0032382882);

final_score_209_c1183 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 8.5 => 0.0047851349,
    f_corraddrnamecount_d > 8.5                                   => -0.1089733410,
    f_corraddrnamecount_d = NULL                                  => -0.0624535519,
                                                                     -0.0624535519);

final_score_209_c1182 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 309.5 => -0.0106470425,
    f_prevaddrageoldest_d > 309.5                                   => final_score_209_c1183,
    f_prevaddrageoldest_d = NULL                                    => -0.0174135121,
                                                                       -0.0174135121);

final_score_209_c1184 := map(
    NULL < mth_source_ppfla_fseen AND mth_source_ppfla_fseen <= 22.5 => -0.0413486835,
    mth_source_ppfla_fseen > 22.5                                    => 0.0349664507,
    mth_source_ppfla_fseen = NULL                                    => 0.0052142296,
                                                                        0.0051447651);

final_score_209_c1185 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By SSN', 'Brother', 'Child', 'Daughter', 'Father', 'Grandson', 'Husband', 'Neighbor', 'Relative', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => -0.0154649135,
    (phone_subject_title in ['Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Mother', 'Parent', 'Sibling'])                                                    => 0.0803382473,
    phone_subject_title = ''                                                                                                                                                                                                                                                   => -0.0067943010,
                                                                                                                                                                                                                                                                                  -0.0067943010);

final_score_209 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -16.5 => final_score_209_c1182,
    f_addrchangecrimediff_i > -16.5                                     => final_score_209_c1184,
    f_addrchangecrimediff_i = NULL                                      => final_score_209_c1185,
                                                                           -0.0040677947);

final_score_210_c1190 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 57.5 => 0.0265571116,
    mth_pp_datevendorfirstseen > 57.5                                        => 0.0863309208,
    mth_pp_datevendorfirstseen = NULL                                        => 0.0311837597,
                                                                                0.0311837597);

final_score_210_c1189 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 1.5 => -0.0068895955,
    f_assocsuspicousidcount_i > 1.5                                       => final_score_210_c1190,
    f_assocsuspicousidcount_i = NULL                                      => 0.0222555882,
                                                                             0.0222555882);

final_score_210_c1188 := map(
    NULL < f_mos_inq_banko_cm_fseen_d AND f_mos_inq_banko_cm_fseen_d <= 39.5 => -0.0254257756,
    f_mos_inq_banko_cm_fseen_d > 39.5                                        => final_score_210_c1189,
    f_mos_inq_banko_cm_fseen_d = NULL                                        => 0.0169501733,
                                                                                0.0169501733);

final_score_210_c1187 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 178.5 => final_score_210_c1188,
    f_fp_prevaddrburglaryindex_i > 178.5                                          => -0.0286302272,
    f_fp_prevaddrburglaryindex_i = NULL                                           => 0.0111227345,
                                                                                     0.0111227345);

final_score_210 := map(
    NULL < mth_pp_datefirstseen AND mth_pp_datefirstseen <= 88.5 => final_score_210_c1187,
    mth_pp_datefirstseen > 88.5                                  => -0.0404081262,
    mth_pp_datefirstseen = NULL                                  => -0.0031474929,
                                                                    0.0009687374);

final_score_211_c1194 := map(
    NULL < (Integer)inq_firstseen_n AND (Integer)inq_firstseen_n <= 22.5 => -0.0420336965,
    (Integer)inq_firstseen_n > 22.5                                      => 0.0369209417,
    (Integer)inq_firstseen_n = NULL                                      => 0.0046657250,
                                                                            0.0099580982);

final_score_211_c1193 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 12.5 => -0.0269256814,
    mth_source_ppdid_fseen > 12.5                                    => final_score_211_c1194,
    mth_source_ppdid_fseen = NULL                                    => -0.0038036120,
                                                                        -0.0023886104);

final_score_211_c1195 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.347400345046763 => 0.0103243373,
    f_add_input_mobility_index_n > 0.347400345046763                                          => 0.0517186012,
    f_add_input_mobility_index_n = NULL                                                       => 0.0258524181,
                                                                                                 0.0258524181);

final_score_211_c1192 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 83767.5 => final_score_211_c1193,
    f_curraddrmedianincome_d > 83767.5                                      => final_score_211_c1195,
    f_curraddrmedianincome_d = NULL                                         => 0.0012360427,
                                                                               0.0012360427);

final_score_211 := map(
    NULL < f_mos_inq_banko_om_fseen_d AND f_mos_inq_banko_om_fseen_d <= 8.5 => 0.0588003822,
    f_mos_inq_banko_om_fseen_d > 8.5                                        => final_score_211_c1192,
    f_mos_inq_banko_om_fseen_d = NULL                                       => 0.0034314137,
                                                                               0.0034314137);

final_score_212_c1199 := map(
    NULL < mth_source_ppfla_lseen AND mth_source_ppfla_lseen <= 22.5 => -0.0459979280,
    mth_source_ppfla_lseen > 22.5                                    => -0.0041981740,
    mth_source_ppfla_lseen = NULL                                    => -0.0068890642,
                                                                        -0.0086769313);

final_score_212_c1200 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 6.5 => 0.0837427121,
    mth_source_ppca_lseen > 6.5                                   => 0.0025375042,
    mth_source_ppca_lseen = NULL                                  => 0.0078060150,
                                                                     0.0094267836);

final_score_212_c1198 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 50393 => final_score_212_c1199,
    f_prevaddrmedianincome_d > 50393                                      => final_score_212_c1200,
    f_prevaddrmedianincome_d = NULL                                       => -0.0004368468,
                                                                             -0.0004368468);

final_score_212_c1197 := map(
    NULL < eda_max_days_connected_ind AND eda_max_days_connected_ind <= 1097 => final_score_212_c1198,
    eda_max_days_connected_ind > 1097                                        => 0.0747354434,
    eda_max_days_connected_ind = NULL                                        => 0.0005371623,
                                                                                0.0005371623);

final_score_212 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 33.5 => final_score_212_c1197,
    f_rel_under500miles_cnt_d > 33.5                                       => 0.0702283742,
    f_rel_under500miles_cnt_d = NULL                                       => 0.0027782877,
                                                                              0.0027782877);

final_score_213_c1204 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.395578930226678 => 0.0197905901,
    f_add_input_mobility_index_n > 0.395578930226678                                          => -0.0594090003,
    f_add_input_mobility_index_n = NULL                                                       => -0.0158849011,
                                                                                                 -0.0158849011);

final_score_213_c1203 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 6.5 => final_score_213_c1204,
    mth_source_ppdid_lseen > 6.5                                    => 0.0163605339,
    mth_source_ppdid_lseen = NULL                                   => -0.0110603480,
                                                                       -0.0053963907);

final_score_213_c1205 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Subject', 'Wife']) => 0.0076016799,
    (phone_subject_title in ['Associate By Property', 'Brother', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Relative', 'Son', 'Spouse', 'Subject at Household'])                                                          => 0.0910898661,
    phone_subject_title = ''                                                                                                                                                                                                                                                      => 0.0200488418,
                                                                                                                                                                                                                                                                                     0.0200488418);

final_score_213_c1202 := map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 5.5 => final_score_213_c1203,
    f_sourcerisktype_i > 5.5                                => final_score_213_c1205,
    f_sourcerisktype_i = NULL                               => 0.0007249318,
                                                               0.0007249318);

final_score_213 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 8.5 => -0.0388687395,
    f_prevaddrageoldest_d > 8.5                                   => final_score_213_c1202,
    f_prevaddrageoldest_d = NULL                                  => -0.0019617116,
                                                                     -0.0019617116);

final_score_214_c1208 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 52056.5 => -0.0191029795,
    f_curraddrmedianincome_d > 52056.5                                      => 0.0754521972,
    f_curraddrmedianincome_d = NULL                                         => 0.0299929777,
                                                                               0.0299929777);

final_score_214_c1207 := map(
    NULL < mth_source_ppfla_fseen AND mth_source_ppfla_fseen <= 21.5 => final_score_214_c1208,
    mth_source_ppfla_fseen > 21.5                                    => -0.0362320233,
    mth_source_ppfla_fseen = NULL                                    => -0.0020513777,
                                                                        -0.0020513777);

final_score_214_c1209 := map(
    NULL < number_of_sources AND number_of_sources <= 2.5 => 0.0049482959,
    number_of_sources > 2.5                               => 0.0890534525,
    number_of_sources = NULL                              => 0.0418365225,
                                                             0.0418365225);

final_score_214_c1210 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 11663 => 0.0089078290,
    f_addrchangeincomediff_d > 11663                                      => -0.0187150099,
    f_addrchangeincomediff_d = NULL                                       => -0.0044888158,
                                                                             -0.0010616796);

final_score_214 := map(
    NULL < mth_source_ppfla_fseen AND mth_source_ppfla_fseen <= 53.5 => final_score_214_c1207,
    mth_source_ppfla_fseen > 53.5                                    => final_score_214_c1209,
    mth_source_ppfla_fseen = NULL                                    => final_score_214_c1210,
                                                                        0.0001000269);

final_score_215_c1214 := map(
    NULL < mth_source_ppca_fseen AND mth_source_ppca_fseen <= 13.5 => 0.0666292541,
    mth_source_ppca_fseen > 13.5                                   => -0.0306950688,
    mth_source_ppca_fseen = NULL                                   => 0.0354851723,
                                                                      0.0258305551);

final_score_215_c1213 := map(
    (pp_glb_dppa_all in ['DG', 'G'])     => -0.0075805237,
    (pp_glb_dppa_all in ['', 'D', 'GD']) => final_score_215_c1214,
    pp_glb_dppa_all = ''                 => 0.0112386500,
                                            0.0112386500);

final_score_215_c1215 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.694017409298994 => -0.0060288055,
    f_add_input_mobility_index_n > 0.694017409298994                                          => -0.0697946485,
    f_add_input_mobility_index_n = NULL                                                       => -0.0133052588,
                                                                                                 -0.0133052588);

final_score_215_c1212 := map(
    NULL < mth_pp_datevendorlastseen AND mth_pp_datevendorlastseen <= 5.5 => final_score_215_c1213,
    mth_pp_datevendorlastseen > 5.5                                       => final_score_215_c1215,
    mth_pp_datevendorlastseen = NULL                                      => 0.0017332839,
                                                                             0.0014545773);

final_score_215 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 14.5 => final_score_215_c1212,
    f_rel_incomeover75_count_d > 14.5                                        => -0.0689413696,
    f_rel_incomeover75_count_d = NULL                                        => 0.0005445489,
                                                                                0.0005445489);

final_score_216_c1217 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 27.5 => -0.0317981443,
    mth_eda_dt_first_seen > 27.5                                   => 0.0701765728,
    mth_eda_dt_first_seen = NULL                                   => 0.0331560484,
                                                                      0.0331560484);

final_score_216_c1220 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 9.5 => -0.0068895130,
    f_rel_homeover100_count_d > 9.5                                       => 0.0140422128,
    f_rel_homeover100_count_d = NULL                                      => -0.0017147336,
                                                                             -0.0017147336);

final_score_216_c1219 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 195.5 => final_score_216_c1220,
    f_curraddrcartheftindex_i > 195.5                                       => 0.0530355034,
    f_curraddrcartheftindex_i = NULL                                        => -0.0000866727,
                                                                               -0.0000866727);

final_score_216_c1218 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 518482 => final_score_216_c1219,
    f_curraddrmedianvalue_d > 518482                                     => -0.0415548624,
    f_curraddrmedianvalue_d = NULL                                       => -0.0019974456,
                                                                            -0.0019974456);

final_score_216 := map(
    NULL < mth_source_inf_fseen AND mth_source_inf_fseen <= 114.5 => -0.0280323076,
    mth_source_inf_fseen > 114.5                                  => final_score_216_c1217,
    mth_source_inf_fseen = NULL                                   => final_score_216_c1218,
                                                                     -0.0012990812);

final_score_217_c1222 := map(
    NULL < mth_pp_datefirstseen AND mth_pp_datefirstseen <= 16.5 => 0.0100991805,
    mth_pp_datefirstseen > 16.5                                  => -0.0615304817,
    mth_pp_datefirstseen = NULL                                  => -0.0277714868,
                                                                    -0.0277714868);

final_score_217_c1225 := map(
    NULL < (Integer)source_rel AND (Integer)source_rel <= 0.5 => -0.0045994845,
    (Integer)source_rel > 0.5                                 => -0.0398930996,
    (Integer)source_rel = NULL                                => -0.0060979647,
                                                                 -0.0060979647);

final_score_217_c1224 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 1.5 => final_score_217_c1225,
    f_rel_incomeover75_count_d > 1.5                                        => 0.0093653021,
    f_rel_incomeover75_count_d = NULL                                       => 0.0009848311,
                                                                               0.0009848311);

final_score_217_c1223 := map(
    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d <= 79.5 => -0.0658585400,
    f_attr_arrest_recency_d > 79.5                                     => final_score_217_c1224,
    f_attr_arrest_recency_d = NULL                                     => -0.0004623390,
                                                                          -0.0004623390);

final_score_217 := map(
    NULL < mth_source_ppla_fseen AND mth_source_ppla_fseen <= 60.5 => final_score_217_c1222,
    mth_source_ppla_fseen > 60.5                                   => 0.0337653103,
    mth_source_ppla_fseen = NULL                                   => final_score_217_c1223,
                                                                      -0.0008882262);

final_score_218_c1230 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 5.5 => -0.0349649116,
    f_rel_under100miles_cnt_d > 5.5                                       => 0.0215135909,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0036822011,
                                                                             0.0036822011);

final_score_218_c1229 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.21364915658876 => 0.0846976716,
    f_add_curr_mobility_index_n > 0.21364915658876                                         => final_score_218_c1230,
    f_add_curr_mobility_index_n = NULL                                                     => 0.0153601067,
                                                                                              0.0153601067);

final_score_218_c1228 := map(
    NULL < r_paw_active_phone_ct_d AND r_paw_active_phone_ct_d <= 0.5 => -0.0107182207,
    r_paw_active_phone_ct_d > 0.5                                     => final_score_218_c1229,
    r_paw_active_phone_ct_d = NULL                                    => -0.0075837726,
                                                                         -0.0075837726);

final_score_218_c1227 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.152922361382288 => 0.0617670320,
    f_add_input_mobility_index_n > 0.152922361382288                                          => final_score_218_c1228,
    f_add_input_mobility_index_n = NULL                                                       => -0.0060432513,
                                                                                                 -0.0060432513);

final_score_218 := map(
    NULL < mth_source_ppth_fseen AND mth_source_ppth_fseen <= 23.5 => 0.0672815156,
    mth_source_ppth_fseen > 23.5                                   => -0.0349003318,
    mth_source_ppth_fseen = NULL                                   => final_score_218_c1227,
                                                                      -0.0061390907);

final_score_219_c1233 := map(
    NULL < pk_phone_match_level AND pk_phone_match_level <= 2.5 => 0.0090656817,
    pk_phone_match_level > 2.5                                  => 0.0696021292,
    pk_phone_match_level = NULL                                 => 0.0228391119,
                                                                   0.0228391119);

final_score_219_c1232 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandfather', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Subject at Household']) => -0.0274080830,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Son', 'Wife'])                                                                                                                                                                => final_score_219_c1233,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                         => -0.0167192769,
                                                                                                                                                                                                                                                                                                                                        -0.0167192769);

final_score_219_c1235 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By SSN', 'Brother', 'Child', 'Daughter', 'Grandson', 'Relative', 'Sibling', 'Subject at Household', 'Wife'])                                                                                                                      => -0.0393383600,
    (phone_subject_title in ['Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Sister', 'Son', 'Spouse', 'Subject']) => 0.0116972716,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                    => 0.0002381277,
                                                                                                                                                                                                                                                                                                                   0.0002381277);

final_score_219_c1234 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 19.5 => final_score_219_c1235,
    f_rel_homeover100_count_d > 19.5                                       => 0.0817534181,
    f_rel_homeover100_count_d = NULL                                       => 0.0049486097,
                                                                              0.0049486097);

final_score_219 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 4735.5 => 0.0099338197,
    f_addrchangeincomediff_d > 4735.5                                      => final_score_219_c1232,
    f_addrchangeincomediff_d = NULL                                        => final_score_219_c1234,
                                                                              0.0002130528);

final_score_220_c1238 := map(
    NULL < eda_has_cur_discon_90_days AND eda_has_cur_discon_90_days <= 0.5 => 0.0111291806,
    eda_has_cur_discon_90_days > 0.5                                        => -0.0639094814,
    eda_has_cur_discon_90_days = NULL                                       => -0.0317500548,
                                                                               -0.0317500548);

final_score_220_c1240 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 128.5 => 0.0068049114,
    f_prevaddrcartheftindex_i > 128.5                                       => 0.1171250037,
    f_prevaddrcartheftindex_i = NULL                                        => 0.0552292423,
                                                                               0.0552292423);

final_score_220_c1239 := map(
    NULL < eda_months_addr_last_seen AND eda_months_addr_last_seen <= 0.5 => -0.0015814414,
    eda_months_addr_last_seen > 0.5                                       => final_score_220_c1240,
    eda_months_addr_last_seen = NULL                                      => 0.0007183098,
                                                                             0.0007183098);

final_score_220_c1237 := map(
    (exp_source in ['P'])     => final_score_220_c1238,
    (exp_source in ['', 'S']) => final_score_220_c1239,
    exp_source = ''           => -0.0007320958,
                                 -0.0007320958);

final_score_220 := map(
    NULL < mth_source_sp_fseen AND mth_source_sp_fseen <= 30.5 => 0.0606156011,
    mth_source_sp_fseen > 30.5                                 => 0.0477176346,
    mth_source_sp_fseen = NULL                                 => final_score_220_c1237,
                                                                  0.0009181425);

final_score_221_c1242 := map(
    NULL < f_estimated_income_d AND f_estimated_income_d <= 41500 => -0.0413643964,
    f_estimated_income_d > 41500                                  => 0.0226301829,
    f_estimated_income_d = NULL                                   => -0.0010847543,
                                                                     -0.0010847543);

final_score_221_c1245 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 5.5 => 0.0067569562,
    f_corraddrnamecount_d > 5.5                                   => 0.0887475950,
    f_corraddrnamecount_d = NULL                                  => 0.0348258235,
                                                                     0.0348258235);

final_score_221_c1244 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Daughter', 'Father', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Wife']) => 0.0012178407,
    (phone_subject_title in ['Associate By Property', 'Associate By SSN', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Subject at Household'])                                                                                                                                                          => final_score_221_c1245,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                      => 0.0028075365,
                                                                                                                                                                                                                                                                                                                                     0.0028075365);

final_score_221_c1243 := map(
    NULL < mth_source_ppla_fseen AND mth_source_ppla_fseen <= 31.5 => -0.0279572788,
    mth_source_ppla_fseen > 31.5                                   => 0.0349721423,
    mth_source_ppla_fseen = NULL                                   => final_score_221_c1244,
                                                                      0.0025783556);

final_score_221 := map(
    NULL < mth_source_ppfla_fseen AND mth_source_ppfla_fseen <= 88.5 => final_score_221_c1242,
    mth_source_ppfla_fseen > 88.5                                    => -0.0611407964,
    mth_source_ppfla_fseen = NULL                                    => final_score_221_c1243,
                                                                        0.0015300094);

final_score_222_c1248 := map(
    (pp_origlistingtype in ['B', 'R'])       => 0.0213537574,
    (pp_origlistingtype in ['', 'BG', 'RB']) => 0.0917264700,
    pp_origlistingtype = ''                  => 0.0505820406,
                                                0.0505820406);

final_score_222_c1249 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Daughter', 'Grandfather', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Subject', 'Wife']) => 0.0021362051,
    (phone_subject_title in ['Associate By Property', 'Associate By Vehicle', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Relative', 'Son', 'Spouse', 'Subject at Household'])                                                                    => 0.0786287552,
    phone_subject_title = ''                                                                                                                                                                                                                                                           => 0.0125338411,
                                                                                                                                                                                                                                                                                          0.0125338411);

final_score_222_c1247 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 20.5 => final_score_222_c1248,
    mth_pp_datevendorfirstseen > 20.5                                        => -0.0094594173,
    mth_pp_datevendorfirstseen = NULL                                        => final_score_222_c1249,
                                                                                0.0149677622);

final_score_222_c1250 := map(
    NULL < pp_total_source_conf AND pp_total_source_conf <= 18.5 => -0.0052423990,
    pp_total_source_conf > 18.5                                  => -0.0517110792,
    pp_total_source_conf = NULL                                  => -0.0072824140,
                                                                    -0.0072824140);

final_score_222 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 3.5 => final_score_222_c1247,
    f_inq_count_i > 3.5                           => final_score_222_c1250,
    f_inq_count_i = NULL                          => -0.0020415675,
                                                     -0.0020415675);

final_score_223_c1253 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 11.5 => 0.0139423206,
    f_rel_under500miles_cnt_d > 11.5                                       => -0.0519310057,
    f_rel_under500miles_cnt_d = NULL                                       => -0.0159383635,
                                                                              -0.0159383635);

final_score_223_c1252 := map(
    NULL < r_mos_since_paw_fseen_d AND r_mos_since_paw_fseen_d <= 50.5 => final_score_223_c1253,
    r_mos_since_paw_fseen_d > 50.5                                     => 0.0572342783,
    r_mos_since_paw_fseen_d = NULL                                     => -0.0032235262,
                                                                          -0.0032235262);

final_score_223_c1255 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 51.5 => -0.0113512019,
    mth_pp_datevendorfirstseen > 51.5                                        => 0.0669279991,
    mth_pp_datevendorfirstseen = NULL                                        => 0.0001178349,
                                                                                0.0001413255);

final_score_223_c1254 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 41.5 => final_score_223_c1255,
    (Integer)inq_adl_firstseen_n > 41.5                                          => 0.0454475011,
    (Integer)inq_adl_firstseen_n = NULL                                          => 0.0009467522,
                                                                                    0.0017645744);

final_score_223 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 16.5 => 0.0458299460,
    mth_source_utildid_fseen > 16.5                                      => final_score_223_c1252,
    mth_source_utildid_fseen = NULL                                      => final_score_223_c1254,
                                                                            0.0022968560);

final_score_224_c1260 := map(
    NULL < f_crim_rel_under100miles_cnt_i AND f_crim_rel_under100miles_cnt_i <= 3.5 => 0.0138957997,
    f_crim_rel_under100miles_cnt_i > 3.5                                            => 0.0897704947,
    f_crim_rel_under100miles_cnt_i = NULL                                           => 0.0329127398,
                                                                                       0.0329127398);

final_score_224_c1259 := map(
    NULL < f_estimated_income_d AND f_estimated_income_d <= 88500 => 0.0013192174,
    f_estimated_income_d > 88500                                  => final_score_224_c1260,
    f_estimated_income_d = NULL                                   => 0.0047908389,
                                                                     0.0047908389);

final_score_224_c1258 := map(
    NULL < mth_source_inf_fseen AND mth_source_inf_fseen <= 96 => 0.0197878392,
    mth_source_inf_fseen > 96                                  => -0.0351577450,
    mth_source_inf_fseen = NULL                                => final_score_224_c1259,
                                                                  0.0034686946);

final_score_224_c1257 := map(
    NULL < mth_source_sp_fseen AND mth_source_sp_fseen <= 14.5 => 0.0832954859,
    mth_source_sp_fseen > 14.5                                 => -0.0102253391,
    mth_source_sp_fseen = NULL                                 => final_score_224_c1258,
                                                                  0.0042289569);

final_score_224 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 8.5 => final_score_224_c1257,
    f_rel_homeover500_count_d > 8.5                                       => -0.0648380638,
    f_rel_homeover500_count_d = NULL                                      => 0.0031217560,
                                                                             0.0031217560);

final_score_225_c1262 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Shared Associates', 'Associate By Vehicle', 'Child', 'Daughter', 'Grandfather', 'Neighbor', 'Relative', 'Sister', 'Son', 'Subject', 'Subject at Household', 'Wife'])                            => -0.0462601908,
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By SSN', 'Brother', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Parent', 'Sibling', 'Spouse']) => 0.0463866259,
    phone_subject_title = ''                                                                                                                                                                                                                                       => -0.0315292252,
                                                                                                                                                                                                                                                                      -0.0315292252);

final_score_225_c1264 := map(
    NULL < eda_min_days_connected_ind AND eda_min_days_connected_ind <= 18.5 => 0.0123871326,
    eda_min_days_connected_ind > 18.5                                        => -0.0522694376,
    eda_min_days_connected_ind = NULL                                        => 0.0096698298,
                                                                                0.0096698298);

final_score_225_c1263 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Brother', 'Child', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Parent'])                                                                                                      => -0.0654795139,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Daughter', 'Father', 'Grandchild', 'Mother', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_225_c1264,
    phone_subject_title = ''                                                                                                                                                                                                                                                                            => 0.0068707334,
                                                                                                                                                                                                                                                                                                           0.0068707334);

final_score_225_c1265 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 10.5 => -0.0040732442,
    f_inq_count24_i > 10.5                             => 0.0590887961,
    f_inq_count24_i = NULL                             => 0.0012889824,
                                                          0.0012889824);

final_score_225 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -93179.5 => final_score_225_c1262,
    f_addrchangevaluediff_d > -93179.5                                     => final_score_225_c1263,
    f_addrchangevaluediff_d = NULL                                         => final_score_225_c1265,
                                                                              0.0018520365);

final_score_226_c1268 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 134.5 => 0.0661208134,
    mth_pp_app_npa_effective_dt > 134.5                                         => 0.0064918546,
    mth_pp_app_npa_effective_dt = NULL                                          => 0.0290159321,
                                                                                   0.0290159321);

final_score_226_c1267 := map(
    NULL < pp_app_company_type AND pp_app_company_type <= 7.5 => 0.0004529163,
    pp_app_company_type > 7.5                                 => final_score_226_c1268,
    pp_app_company_type = NULL                                => 0.0026571879,
                                                                 0.0026571879);

final_score_226_c1270 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 18.5 => -0.0803042544,
    mth_source_ppdid_lseen > 18.5                                    => -0.0496436018,
    mth_source_ppdid_lseen = NULL                                    => -0.0256629624,
                                                                        -0.0368302418);

final_score_226_c1269 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 6.5 => final_score_226_c1270,
    f_util_adl_count_n > 6.5                                => 0.0350375339,
    f_util_adl_count_n = NULL                               => -0.0234311649,
                                                               -0.0234311649);

final_score_226 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 6.5 => final_score_226_c1267,
    f_rel_incomeover75_count_d > 6.5                                        => final_score_226_c1269,
    f_rel_incomeover75_count_d = NULL                                       => -0.0004040185,
                                                                               -0.0004040185);

final_score_227_c1272 := map(
    NULL < mth_source_cr_fseen AND mth_source_cr_fseen <= 14.5 => 0.0244856927,
    mth_source_cr_fseen > 14.5                                 => -0.0534725245,
    mth_source_cr_fseen = NULL                                 => -0.0055594200,
                                                                  -0.0069122190);

final_score_227_c1274 := map(
    NULL < f_corrssnaddrcount_d AND f_corrssnaddrcount_d <= 2.5 => 0.0758412698,
    f_corrssnaddrcount_d > 2.5                                  => -0.0119823458,
    f_corrssnaddrcount_d = NULL                                 => 0.0220578153,
                                                                   0.0220578153);

final_score_227_c1275 := map(
    (phone_subject_title in ['Associate', 'Associate By Shared Associates', 'Daughter', 'Father', 'Grandfather', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Son'])                                                                                                                                                                  => -0.0171462595,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => 0.0553201166,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                          => 0.0273957211,
                                                                                                                                                                                                                                                                                                                                         0.0273957211);

final_score_227_c1273 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= -0.5 => final_score_227_c1274,
    r_pb_order_freq_d > -0.5                               => -0.0229347579,
    r_pb_order_freq_d = NULL                               => final_score_227_c1275,
                                                              0.0119701508);

final_score_227 := map(
    NULL < f_crim_rel_under500miles_cnt_i AND f_crim_rel_under500miles_cnt_i <= 4.5 => final_score_227_c1272,
    f_crim_rel_under500miles_cnt_i > 4.5                                            => final_score_227_c1273,
    f_crim_rel_under500miles_cnt_i = NULL                                           => -0.0024906951,
                                                                                       -0.0024906951);

final_score_228_c1280 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 110.5 => 0.0725775620,
    f_fp_prevaddrburglaryindex_i > 110.5                                          => -0.0027921228,
    f_fp_prevaddrburglaryindex_i = NULL                                           => 0.0319351750,
                                                                                     0.0319351750);

final_score_228_c1279 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 6.5 => 0.0622121979,
    mth_pp_datevendorfirstseen > 6.5                                        => 0.0051711600,
    mth_pp_datevendorfirstseen = NULL                                       => final_score_228_c1280,
                                                                               0.0240822175);

final_score_228_c1278 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 2.5 => -0.0445492087,
    f_rel_educationover12_count_d > 2.5                                           => final_score_228_c1279,
    f_rel_educationover12_count_d = NULL                                          => 0.0167841389,
                                                                                     0.0167841389);

final_score_228_c1277 := map(
    (phone_subject_title in ['Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandmother', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject']) => -0.0041913507,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Subject at Household', 'Wife'])                                                      => final_score_228_c1278,
    phone_subject_title = ''                                                                                                                                                                                                                                                    => 0.0025390236,
                                                                                                                                                                                                                                                                                   0.0025390236);

final_score_228 := map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d <= 15.5 => final_score_228_c1277,
    f_rel_incomeover25_count_d > 15.5                                        => -0.0148667743,
    f_rel_incomeover25_count_d = NULL                                        => -0.0023272529,
                                                                                -0.0023272529);

final_score_229_c1284 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 16701.5 => -0.0199590395,
    f_addrchangeincomediff_d > 16701.5                                      => 0.0550398999,
    f_addrchangeincomediff_d = NULL                                         => -0.0081361020,
                                                                               -0.0081361020);

final_score_229_c1285 := map(
    NULL < f_corrssnnamecount_d AND f_corrssnnamecount_d <= 4.5 => 0.0683519414,
    f_corrssnnamecount_d > 4.5                                  => 0.0125186173,
    f_corrssnnamecount_d = NULL                                 => 0.0241111295,
                                                                   0.0241111295);

final_score_229_c1283 := map(
    NULL < mth_pp_datefirstseen AND mth_pp_datefirstseen <= 19.5 => final_score_229_c1284,
    mth_pp_datefirstseen > 19.5                                  => final_score_229_c1285,
    mth_pp_datefirstseen = NULL                                  => -0.0018038247,
                                                                    0.0038036002);

final_score_229_c1282 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -41.5 => -0.0196092531,
    f_addrchangecrimediff_i > -41.5                                     => final_score_229_c1283,
    f_addrchangecrimediff_i = NULL                                      => -0.0074485907,
                                                                           -0.0032319178);

final_score_229 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 20.5 => final_score_229_c1282,
    f_rel_homeover300_count_d > 20.5                                       => 0.0580346351,
    f_rel_homeover300_count_d = NULL                                       => -0.0023411279,
                                                                              -0.0023411279);

final_score_230_c1289 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 7.5 => 0.0332277071,
    f_rel_ageover30_count_d > 7.5                                     => -0.0346796374,
    f_rel_ageover30_count_d = NULL                                    => -0.0135605391,
                                                                         -0.0135605391);

final_score_230_c1288 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 28978.5 => -0.0910038298,
    f_prevaddrmedianincome_d > 28978.5                                      => final_score_230_c1289,
    f_prevaddrmedianincome_d = NULL                                         => -0.0256842491,
                                                                               -0.0256842491);

final_score_230_c1287 := map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d <= 71.5 => final_score_230_c1288,
    f_mos_acc_lseen_d > 71.5                               => 0.0007819900,
    f_mos_acc_lseen_d = NULL                               => -0.0024086376,
                                                              -0.0024086376);

final_score_230_c1290 := map(
    NULL < eda_days_ph_first_seen AND eda_days_ph_first_seen <= 3398.5 => 0.0833670466,
    eda_days_ph_first_seen > 3398.5                                    => -0.0148750106,
    eda_days_ph_first_seen = NULL                                      => 0.0491363647,
                                                                          0.0491363647);

final_score_230 := map(
    NULL < f_divaddrsuspidcountnew_i AND f_divaddrsuspidcountnew_i <= 1.5 => final_score_230_c1287,
    f_divaddrsuspidcountnew_i > 1.5                                       => final_score_230_c1290,
    f_divaddrsuspidcountnew_i = NULL                                      => -0.0005768625,
                                                                             -0.0005768625);

final_score_231_c1293 := map(
    NULL < f_srchssnsrchcount_i AND f_srchssnsrchcount_i <= 0.5 => 0.0503610128,
    f_srchssnsrchcount_i > 0.5                                  => -0.0371971065,
    f_srchssnsrchcount_i = NULL                                 => 0.0034442049,
                                                                   0.0034442049);

final_score_231_c1295 := map(
    (exp_source in ['P'])     => -0.0391118423,
    (exp_source in ['', 'S']) => 0.0049017156,
    exp_source = ''           => 0.0037240953,
                                 0.0037240953);

final_score_231_c1294 := map(
    NULL < eda_num_interrupts_cur AND eda_num_interrupts_cur <= 8.5 => final_score_231_c1295,
    eda_num_interrupts_cur > 8.5                                    => -0.0453356261,
    eda_num_interrupts_cur = NULL                                   => 0.0004175207,
                                                                       0.0004175207);

final_score_231_c1292 := map(
    NULL < mth_source_inf_fseen AND mth_source_inf_fseen <= 146 => 0.0453815194,
    mth_source_inf_fseen > 146                                  => final_score_231_c1293,
    mth_source_inf_fseen = NULL                                 => final_score_231_c1294,
                                                                   0.0021894380);

final_score_231 := map(
    NULL < _pp_rule_30 AND _pp_rule_30 <= 0.5 => final_score_231_c1292,
    _pp_rule_30 > 0.5                         => -0.0822432097,
    _pp_rule_30 = NULL                        => 0.0009871405,
                                                 0.0009871405);

final_score_232_c1299 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 84 => -0.0609408862,
    f_prevaddrageoldest_d > 84                                   => 0.0360926692,
    f_prevaddrageoldest_d = NULL                                 => 0.0053116320,
                                                                    0.0053116320);

final_score_232_c1300 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 1.5 => 0.0386984932,
    f_rel_educationover12_count_d > 1.5                                           => -0.0058210625,
    f_rel_educationover12_count_d = NULL                                          => -0.0038214091,
                                                                                     -0.0038214091);

final_score_232_c1298 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 16.5 => 0.0468818855,
    mth_source_sx_fseen > 16.5                                 => final_score_232_c1299,
    mth_source_sx_fseen = NULL                                 => final_score_232_c1300,
                                                                  -0.0027090729);

final_score_232_c1297 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 1.5 => final_score_232_c1298,
    f_srchunvrfdaddrcount_i > 1.5                                     => 0.0776831782,
    f_srchunvrfdaddrcount_i = NULL                                    => -0.0012956716,
                                                                         -0.0012956716);

final_score_232 := map(
    NULL < f_mos_inq_banko_cm_fseen_d AND f_mos_inq_banko_cm_fseen_d <= 16.5 => -0.0958689205,
    f_mos_inq_banko_cm_fseen_d > 16.5                                        => final_score_232_c1297,
    f_mos_inq_banko_cm_fseen_d = NULL                                        => -0.0026189476,
                                                                                -0.0026189476);

final_score_233_c1304 := map(
    NULL < mth_source_ppca_lseen AND mth_source_ppca_lseen <= 17.5 => 0.0716904334,
    mth_source_ppca_lseen > 17.5                                   => -0.0016625796,
    mth_source_ppca_lseen = NULL                                   => 0.0103360714,
                                                                      0.0133342414);

final_score_233_c1305 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 12.5 => -0.0170798079,
    f_rel_under100miles_cnt_d > 12.5                                       => 0.0109118362,
    f_rel_under100miles_cnt_d = NULL                                       => -0.0079821174,
                                                                              -0.0079821174);

final_score_233_c1303 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 0.5 => final_score_233_c1304,
    f_rel_homeover200_count_d > 0.5                                       => final_score_233_c1305,
    f_rel_homeover200_count_d = NULL                                      => -0.0011789644,
                                                                             -0.0011789644);

final_score_233_c1302 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 6.5 => 0.0406074296,
    mth_source_rel_fseen > 6.5                                  => 0.0003878533,
    mth_source_rel_fseen = NULL                                 => final_score_233_c1303,
                                                                   -0.0002810358);

final_score_233 := map(
    NULL < eda_num_phs_connected_addr AND eda_num_phs_connected_addr <= 1.5 => final_score_233_c1302,
    eda_num_phs_connected_addr > 1.5                                        => -0.1047575975,
    eda_num_phs_connected_addr = NULL                                       => -0.0016911330,
                                                                               -0.0016911330);

final_score_234_c1307 := map(
    NULL < pp_app_ind_ph_cnt AND pp_app_ind_ph_cnt <= 9.5 => 0.0027055615,
    pp_app_ind_ph_cnt > 9.5                               => 0.0800916561,
    pp_app_ind_ph_cnt = NULL                              => 0.0051858850,
                                                             0.0051858850);

final_score_234_c1309 := map(
    NULL < mth_source_ppfla_lseen AND mth_source_ppfla_lseen <= 10.5 => -0.0054052559,
    mth_source_ppfla_lseen > 10.5                                    => -0.0588351089,
    mth_source_ppfla_lseen = NULL                                    => -0.0151284455,
                                                                        -0.0169279561);

final_score_234_c1310 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 23.5 => 0.0506351761,
    mth_pp_datevendorfirstseen > 23.5                                        => -0.0751464732,
    mth_pp_datevendorfirstseen = NULL                                        => 0.0233509000,
                                                                                0.0182466208);

final_score_234_c1308 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Daughter', 'Grandfather', 'Grandmother', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Sibling', 'Sister', 'Son', 'Subject', 'Subject at Household', 'Wife']) => final_score_234_c1309,
    (phone_subject_title in ['Associate By Address', 'Brother', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandparent', 'Parent', 'Relative', 'Spouse'])                                                                                                                                                                        => final_score_234_c1310,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                             => -0.0089581001,
                                                                                                                                                                                                                                                                                                                                            -0.0089581001);

final_score_234 := map(
    NULL < f_crim_rel_under500miles_cnt_i AND f_crim_rel_under500miles_cnt_i <= 1.5 => final_score_234_c1307,
    f_crim_rel_under500miles_cnt_i > 1.5                                            => final_score_234_c1308,
    f_crim_rel_under500miles_cnt_i = NULL                                           => -0.0026539239,
                                                                                       -0.0026539239);

final_score_235_c1312 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 59.5 => 0.0119608269,
    mth_pp_eda_hist_did_dt > 59.5                                    => -0.0591015164,
    mth_pp_eda_hist_did_dt = NULL                                    => -0.0195002105,
                                                                        -0.0195002105);

final_score_235_c1315 := map(
    NULL < _pp_rule_high_vend_conf AND _pp_rule_high_vend_conf <= 0.5 => 0.0031138007,
    _pp_rule_high_vend_conf > 0.5                                     => 0.0609813010,
    _pp_rule_high_vend_conf = NULL                                    => 0.0096691035,
                                                                         0.0096691035);

final_score_235_c1314 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 0.5 => final_score_235_c1315,
    f_rel_homeover200_count_d > 0.5                                       => -0.0102353479,
    f_rel_homeover200_count_d = NULL                                      => -0.0039548965,
                                                                             -0.0039548965);

final_score_235_c1313 := map(
    NULL < (Integer)_internal_ver_match_spouse AND (Integer)_internal_ver_match_spouse <= 0.5 => final_score_235_c1314,
    (Integer)_internal_ver_match_spouse > 0.5                                                 => 0.0495501480,
    (Integer)_internal_ver_match_spouse = NULL                                                => -0.0028815039,
                                                                                                 -0.0028815039);

final_score_235 := map(
    NULL < mth_source_ppfla_fseen AND mth_source_ppfla_fseen <= 21.5 => 0.0368924425,
    mth_source_ppfla_fseen > 21.5                                    => final_score_235_c1312,
    mth_source_ppfla_fseen = NULL                                    => final_score_235_c1313,
                                                                        -0.0026686914);

final_score_236_c1319 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 13.5 => -0.0267519364,
    mth_pp_datevendorfirstseen > 13.5                                        => 0.0339620128,
    mth_pp_datevendorfirstseen = NULL                                        => -0.0026655032,
                                                                                0.0032479466);

final_score_236_c1320 := map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i <= 168.5 => 0.0223663495,
    f_prevaddrmurderindex_i > 168.5                                     => 0.1105156593,
    f_prevaddrmurderindex_i = NULL                                      => 0.0413100486,
                                                                           0.0413100486);

final_score_236_c1318 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Daughter', 'Father', 'Granddaughter', 'Grandfather', 'Grandson', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Subject', 'Wife']) => final_score_236_c1319,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Brother', 'Child', 'Grandchild', 'Grandmother', 'Grandparent', 'Husband', 'Relative', 'Son', 'Spouse', 'Subject at Household'])                                                                                                    => final_score_236_c1320,
    phone_subject_title = ''                                                                                                                                                                                                                                                                           => 0.0115857723,
                                                                                                                                                                                                                                                                                                          0.0115857723);

final_score_236_c1317 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.409831212449099 => final_score_236_c1318,
    f_add_curr_mobility_index_n > 0.409831212449099                                         => -0.0014748618,
    f_add_curr_mobility_index_n = NULL                                                      => 0.0074029989,
                                                                                               0.0074029989);

final_score_236 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -12981.5 => -0.0141618850,
    f_addrchangevaluediff_d > -12981.5                                     => final_score_236_c1317,
    f_addrchangevaluediff_d = NULL                                         => 0.0049008005,
                                                                              0.0009443255);

final_score_237_c1323 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 6.5 => -0.0657528207,
    f_inq_count_i > 6.5                           => 0.0258697220,
    f_inq_count_i = NULL                          => -0.0208919907,
                                                     -0.0208919907);

final_score_237_c1322 := map(
    NULL < f_vardobcount_i AND f_vardobcount_i <= 1.5 => final_score_237_c1323,
    f_vardobcount_i > 1.5                             => 0.0776930260,
    f_vardobcount_i = NULL                            => 0.0145042254,
                                                         0.0145042254);

final_score_237_c1325 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 89.5 => -0.0310086708,
    mth_pp_app_npa_last_change_dt > 89.5                                           => 0.0260608809,
    mth_pp_app_npa_last_change_dt = NULL                                           => -0.0012436767,
                                                                                      -0.0030401631);

final_score_237_c1324 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 69.5 => final_score_237_c1325,
    mth_exp_last_update > 69.5                                 => -0.0687287788,
    mth_exp_last_update = NULL                                 => -0.0008905289,
                                                                  -0.0023225343);

final_score_237 := map(
    NULL < mth_source_ppla_lseen AND mth_source_ppla_lseen <= 31.5 => final_score_237_c1322,
    mth_source_ppla_lseen > 31.5                                   => -0.0548370298,
    mth_source_ppla_lseen = NULL                                   => final_score_237_c1324,
                                                                      -0.0023844490);

final_score_238_c1328 := map(
    NULL < f_srchaddrsrchcount_i AND f_srchaddrsrchcount_i <= 31.5 => 0.0013180961,
    f_srchaddrsrchcount_i > 31.5                                   => 0.0705349745,
    f_srchaddrsrchcount_i = NULL                                   => 0.0037676588,
                                                                      0.0037676588);

final_score_238_c1330 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 33341 => 0.0228294318,
    f_prevaddrmedianincome_d > 33341                                      => -0.0610255816,
    f_prevaddrmedianincome_d = NULL                                       => -0.0419933201,
                                                                             -0.0419933201);

final_score_238_c1329 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 4.5 => -0.0082591515,
    mth_exp_last_update > 4.5                                 => final_score_238_c1330,
    mth_exp_last_update = NULL                                => -0.0088290832,
                                                                 -0.0141180331);

final_score_238_c1327 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 3.5 => final_score_238_c1328,
    f_util_adl_count_n > 3.5                                => final_score_238_c1329,
    f_util_adl_count_n = NULL                               => -0.0024815317,
                                                               -0.0024815317);

final_score_238 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 17.5 => final_score_238_c1327,
    f_rel_ageover40_count_d > 17.5                                     => 0.0785421018,
    f_rel_ageover40_count_d = NULL                                     => -0.0014548969,
                                                                          -0.0014548969);

final_score_239_c1333 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By SSN', 'Child', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Subject at Household']) => 0.0098181792,
    (phone_subject_title in ['Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Husband', 'Son', 'Wife'])                                                                                      => 0.1035648232,
    phone_subject_title = ''                                                                                                                                                                                                                                                                    => 0.0218294680,
                                                                                                                                                                                                                                                                                                   0.0218294680);

final_score_239_c1332 := map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 5.5 => -0.0038904811,
    f_sourcerisktype_i > 5.5                                => final_score_239_c1333,
    f_sourcerisktype_i = NULL                               => 0.0025153176,
                                                               0.0025153176);

final_score_239_c1335 := map(
    NULL < f_rel_incomeover75_count_d AND f_rel_incomeover75_count_d <= 1.5 => 0.1058185374,
    f_rel_incomeover75_count_d > 1.5                                        => 0.0220088176,
    f_rel_incomeover75_count_d = NULL                                       => 0.0605761223,
                                                                               0.0605761223);

final_score_239_c1334 := map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 9.5 => -0.0139391905,
    f_rel_homeover50_count_d > 9.5                                      => final_score_239_c1335,
    f_rel_homeover50_count_d = NULL                                     => 0.0323258114,
                                                                           0.0323258114);

final_score_239 := map(
    NULL < inq_num AND inq_num <= 2.5 => final_score_239_c1332,
    inq_num > 2.5                     => final_score_239_c1334,
    inq_num = NULL                    => 0.0038663133,
                                         0.0038663133);

final_score_240_c1339 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Shared Associates', 'Associate By Vehicle', 'Child', 'Father', 'Grandfather', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Son', 'Spouse', 'Wife'])                                                            => -0.0089957336,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By SSN', 'Brother', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Sibling', 'Sister', 'Subject', 'Subject at Household']) => 0.0384110164,
    phone_subject_title = ''                                                                                                                                                                                                                                                       => 0.0244058457,
                                                                                                                                                                                                                                                                                      0.0244058457);

final_score_240_c1338 := map(
    NULL < (Integer)f_util_add_curr_conv_n AND (Integer)f_util_add_curr_conv_n <= 0.5 => final_score_240_c1339,
    (Integer)f_util_add_curr_conv_n > 0.5                                             => 0.0019938747,
    (Integer)f_util_add_curr_conv_n = NULL                                            => 0.0096978367,
                                                                                         0.0096978367);

final_score_240_c1337 := map(
    NULL < mth_phone_fb_rp_date AND mth_phone_fb_rp_date <= 24.5 => 0.0786124775,
    mth_phone_fb_rp_date > 24.5                                  => -0.0292539926,
    mth_phone_fb_rp_date = NULL                                  => final_score_240_c1338,
                                                                    0.0104127675);

final_score_240_c1340 := map(
    NULL < mth_source_ppfla_lseen AND mth_source_ppfla_lseen <= 17.5 => -0.0105386166,
    mth_source_ppfla_lseen > 17.5                                    => 0.0529356425,
    mth_source_ppfla_lseen = NULL                                    => -0.0129998800,
                                                                        -0.0102987841);

final_score_240 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 133 => final_score_240_c1337,
    f_fp_prevaddrburglaryindex_i > 133                                          => final_score_240_c1340,
    f_fp_prevaddrburglaryindex_i = NULL                                         => 0.0023625495,
                                                                                   0.0023625495);

final_score_241_c1344 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 29.5 => 0.0584074677,
    mth_source_ppdid_lseen > 29.5                                    => -0.0054839957,
    mth_source_ppdid_lseen = NULL                                    => 0.0284082501,
                                                                        0.0284082501);

final_score_241_c1343 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 28.5 => 0.0060374048,
    mth_source_utildid_fseen > 28.5                                      => final_score_241_c1344,
    mth_source_utildid_fseen = NULL                                      => -0.0103748264,
                                                                            -0.0055911833);

final_score_241_c1345 := map(
    (pp_source in ['', 'GONG', 'IBEHAVIOR', 'INQUIRY', 'INTRADO', 'OTHER', 'PCNSR', 'THRIVE']) => -0.0203180528,
    (pp_source in ['CELL', 'HEADER', 'INFUTOR', 'TARGUS'])                                     => 0.1099429949,
    pp_source = ''                                                                             => 0.0421211271,
                                                                                                  0.0421211271);

final_score_241_c1342 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 148 => final_score_241_c1343,
    mth_pp_app_npa_last_change_dt > 148                                           => final_score_241_c1345,
    mth_pp_app_npa_last_change_dt = NULL                                          => -0.0020090876,
                                                                                     -0.0021546062);

final_score_241 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 1.5 => 0.0418004600,
    f_rel_educationover12_count_d > 1.5                                           => final_score_241_c1342,
    f_rel_educationover12_count_d = NULL                                          => -0.0002164559,
                                                                                     -0.0002164559);

final_score_242_c1350 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 167.5 => 0.0033586801,
    f_fp_prevaddrcrimeindex_i > 167.5                                       => 0.0412649049,
    f_fp_prevaddrcrimeindex_i = NULL                                        => 0.0104282918,
                                                                               0.0104282918);

final_score_242_c1349 := map(
    NULL < (Integer)_phone_match_code_n AND (Integer)_phone_match_code_n <= 0.5 => -0.0073680812,
    (Integer)_phone_match_code_n > 0.5                                          => final_score_242_c1350,
    (Integer)_phone_match_code_n = NULL                                         => -0.0001710537,
                                                                                   -0.0001710537);

final_score_242_c1348 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 14.5 => final_score_242_c1349,
    f_corraddrnamecount_d > 14.5                                   => -0.0465769713,
    f_corraddrnamecount_d = NULL                                   => -0.0015453712,
                                                                      -0.0015453712);

final_score_242_c1347 := map(
    NULL < f_inq_per_ssn_i AND f_inq_per_ssn_i <= 9.5 => final_score_242_c1348,
    f_inq_per_ssn_i > 9.5                             => -0.0754449322,
    f_inq_per_ssn_i = NULL                            => -0.0027496884,
                                                         -0.0027496884);

final_score_242 := map(
    (pp_type in ['U'])               => -0.0440558351,
    (pp_type in ['', 'B', 'M', 'R']) => final_score_242_c1347,
    pp_type = ''                     => -0.0041971426,
                                        -0.0041971426);

final_score_243_c1353 := map(
    (pp_source in ['CELL', 'GONG', 'INFUTOR', 'INQUIRY', 'OTHER'])                     => -0.0746608203,
    (pp_source in ['', 'HEADER', 'IBEHAVIOR', 'INTRADO', 'PCNSR', 'TARGUS', 'THRIVE']) => -0.0086012234,
    pp_source = ''                                                                     => -0.0436811473,
                                                                                          -0.0436811473);

final_score_243_c1352 := map(
    NULL < f_inq_adls_per_addr_i AND f_inq_adls_per_addr_i <= 1.5 => final_score_243_c1353,
    f_inq_adls_per_addr_i > 1.5                                   => 0.0225121417,
    f_inq_adls_per_addr_i = NULL                                  => -0.0268350403,
                                                                     -0.0268350403);

final_score_243_c1354 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 33.5 => 0.0502199804,
    mth_pp_eda_hist_did_dt > 33.5                                    => -0.0047286081,
    mth_pp_eda_hist_did_dt = NULL                                    => 0.0014107567,
                                                                        0.0014107567);

final_score_243_c1355 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 5.5 => 0.0535636296,
    mth_pp_datevendorfirstseen > 5.5                                        => -0.0105023456,
    mth_pp_datevendorfirstseen = NULL                                       => 0.0001520383,
                                                                               0.0000557401);

final_score_243 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 26.5 => final_score_243_c1352,
    mth_pp_eda_hist_did_dt > 26.5                                    => final_score_243_c1354,
    mth_pp_eda_hist_did_dt = NULL                                    => final_score_243_c1355,
                                                                        -0.0021728701);

final_score_244_c1359 := map(
    NULL < f_rel_bankrupt_count_i AND f_rel_bankrupt_count_i <= 2.5 => -0.1048763010,
    f_rel_bankrupt_count_i > 2.5                                    => -0.0276832538,
    f_rel_bankrupt_count_i = NULL                                   => -0.0669083853,
                                                                       -0.0669083853);

final_score_244_c1358 := map(
    NULL < eda_days_ph_first_seen AND eda_days_ph_first_seen <= 2880 => final_score_244_c1359,
    eda_days_ph_first_seen > 2880                                    => -0.0147796810,
    eda_days_ph_first_seen = NULL                                    => -0.0342250179,
                                                                        -0.0342250179);

final_score_244_c1357 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 15.5 => 0.0247357460,
    f_prevaddrlenofres_d > 15.5                                  => final_score_244_c1358,
    f_prevaddrlenofres_d = NULL                                  => -0.0237404864,
                                                                    -0.0237404864);

final_score_244_c1360 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 41.5 => 0.0054482457,
    f_inq_count_i > 41.5                           => -0.0578585978,
    f_inq_count_i = NULL                           => 0.0029872078,
                                                      0.0029872078);

final_score_244 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Daughter', 'Grandfather', 'Grandmother', 'Grandson', 'Husband', 'Relative'])                                                                                                => final_score_244_c1357,
    (phone_subject_title in ['Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Brother', 'Father', 'Grandchild', 'Granddaughter', 'Grandparent', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_244_c1360,
    phone_subject_title = ''                                                                                                                                                                                                                                                                         => -0.0003256231,
                                                                                                                                                                                                                                                                                                        -0.0003256231);

final_score_245_c1362 := map(
    NULL < f_inq_per_ssn_i AND f_inq_per_ssn_i <= 7.5 => -0.0016399676,
    f_inq_per_ssn_i > 7.5                             => -0.0655297545,
    f_inq_per_ssn_i = NULL                            => -0.0033636444,
                                                         -0.0033636444);

final_score_245_c1364 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 2.5 => 0.0942772128,
    f_rel_ageover40_count_d > 2.5                                     => 0.0197292746,
    f_rel_ageover40_count_d = NULL                                    => 0.0503901201,
                                                                         0.0503901201);

final_score_245_c1365 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 6.5 => -0.0108872881,
    f_inq_count_i > 6.5                           => 0.0671519986,
    f_inq_count_i = NULL                          => 0.0262036276,
                                                     0.0262036276);

final_score_245_c1363 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 26 => -0.0132755625,
    r_pb_order_freq_d > 26                               => final_score_245_c1364,
    r_pb_order_freq_d = NULL                             => final_score_245_c1365,
                                                            0.0205385412);

final_score_245 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject']) => final_score_245_c1362,
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Grandchild', 'Granddaughter', 'Grandfather', 'Parent', 'Son', 'Subject at Household', 'Wife'])                                                                                                                                              => final_score_245_c1363,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                => -0.0010728703,
                                                                                                                                                                                                                                                                                                                               -0.0010728703);

final_score_246_c1368 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 38.5 => -0.0485091879,
    f_mos_inq_banko_cm_lseen_d > 38.5                                        => 0.0947528901,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => 0.0348898075,
                                                                                0.0348898075);

final_score_246_c1367 := map(
    NULL < mth_pp_datelastseen AND mth_pp_datelastseen <= 11.5 => 0.0907920075,
    mth_pp_datelastseen > 11.5                                 => -0.0160882241,
    mth_pp_datelastseen = NULL                                 => final_score_246_c1368,
                                                                  0.0343083383);

final_score_246_c1370 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Daughter', 'Father', 'Grandfather', 'Mother', 'Neighbor', 'Sister', 'Spouse', 'Subject', 'Wife'])                                                    => -0.0132112716,
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Child', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Parent', 'Relative', 'Sibling', 'Son', 'Subject at Household']) => 0.1072080484,
    phone_subject_title = ''                                                                                                                                                                                                                                                   => 0.0123268463,
                                                                                                                                                                                                                                                                                  0.0123268463);

final_score_246_c1369 := map(
    NULL < f_college_income_d AND f_college_income_d <= 5.5 => final_score_246_c1370,
    f_college_income_d > 5.5                                => -0.0374180378,
    f_college_income_d = NULL                               => -0.0021499328,
                                                               -0.0030061091);

final_score_246 := map(
    NULL < f_mos_inq_banko_om_fseen_d AND f_mos_inq_banko_om_fseen_d <= 13.5 => final_score_246_c1367,
    f_mos_inq_banko_om_fseen_d > 13.5                                        => final_score_246_c1369,
    f_mos_inq_banko_om_fseen_d = NULL                                        => -0.0005800924,
                                                                                -0.0005800924);

final_score_247_c1373 := map(
    NULL < eda_days_ph_first_seen AND eda_days_ph_first_seen <= 4120 => 0.0310593635,
    eda_days_ph_first_seen > 4120                                    => -0.0688744734,
    eda_days_ph_first_seen = NULL                                    => -0.0286620530,
                                                                        -0.0286620530);

final_score_247_c1375 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 52.5 => 0.0631018543,
    f_mos_inq_banko_cm_lseen_d > 52.5                                        => -0.0571287551,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => -0.0023401230,
                                                                                -0.0023401230);

final_score_247_c1374 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 44.5 => final_score_247_c1375,
    mth_source_sx_fseen > 44.5                                 => 0.0585984535,
    mth_source_sx_fseen = NULL                                 => 0.0042720580,
                                                                  0.0052044054);

final_score_247_c1372 := map(
    NULL < mth_source_md_fseen AND mth_source_md_fseen <= 23.5 => final_score_247_c1373,
    mth_source_md_fseen > 23.5                                 => 0.0534785276,
    mth_source_md_fseen = NULL                                 => final_score_247_c1374,
                                                                  0.0050381968);

final_score_247 := map(
    NULL < mth_source_ppla_lseen AND mth_source_ppla_lseen <= 13.5 => 0.0005850125,
    mth_source_ppla_lseen > 13.5                                   => -0.0370810261,
    mth_source_ppla_lseen = NULL                                   => final_score_247_c1372,
                                                                      0.0034058347);

final_score_248_c1380 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 150341.5 => 0.0676836736,
    f_prevaddrmedianvalue_d > 150341.5                                     => -0.0073548824,
    f_prevaddrmedianvalue_d = NULL                                         => 0.0221815705,
                                                                              0.0221815705);

final_score_248_c1379 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 34816.5 => -0.0525423085,
    f_prevaddrmedianincome_d > 34816.5                                      => final_score_248_c1380,
    f_prevaddrmedianincome_d = NULL                                         => 0.0035378881,
                                                                               0.0035378881);

final_score_248_c1378 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 125.5 => final_score_248_c1379,
    f_curraddrcartheftindex_i > 125.5                                       => -0.0578360255,
    f_curraddrcartheftindex_i = NULL                                        => -0.0202463792,
                                                                               -0.0202463792);

final_score_248_c1377 := map(
    NULL < mth_source_ppca_fseen AND mth_source_ppca_fseen <= 71.5 => final_score_248_c1378,
    mth_source_ppca_fseen > 71.5                                   => 0.0359176419,
    mth_source_ppca_fseen = NULL                                   => 0.0022266154,
                                                                      0.0005567449);

final_score_248 := map(
    NULL < mth_source_cr_fseen AND mth_source_cr_fseen <= 162.5 => -0.0103303356,
    mth_source_cr_fseen > 162.5                                 => 0.1204005366,
    mth_source_cr_fseen = NULL                                  => final_score_248_c1377,
                                                                   0.0009824852);

final_score_249_c1383 := map(
    NULL < _pp_origlistingtype_res AND _pp_origlistingtype_res <= 0.5 => 0.0394702606,
    _pp_origlistingtype_res > 0.5                                     => -0.0294393945,
    _pp_origlistingtype_res = NULL                                    => 0.0042593710,
                                                                         0.0042593710);

final_score_249_c1382 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 4.5 => -0.0596562593,
    f_corraddrnamecount_d > 4.5                                   => final_score_249_c1383,
    f_corraddrnamecount_d = NULL                                  => -0.0231820445,
                                                                     -0.0231820445);

final_score_249_c1385 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 59.5 => -0.0587476338,
    f_mos_inq_banko_cm_lseen_d > 59.5                                        => 0.0196769898,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => -0.0325409017,
                                                                                -0.0325409017);

final_score_249_c1384 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 15.5 => final_score_249_c1385,
    mth_pp_datevendorfirstseen > 15.5                                        => 0.0096217837,
    mth_pp_datevendorfirstseen = NULL                                        => -0.0008535799,
                                                                                -0.0008535799);

final_score_249 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 14.5 => final_score_249_c1382,
    mth_source_ppdid_fseen > 14.5                                    => final_score_249_c1384,
    mth_source_ppdid_fseen = NULL                                    => -0.0001662739,
                                                                        -0.0018968107);

final_score_250_c1387 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Grandfather', 'Grandmother', 'Mother', 'Parent', 'Spouse', 'Subject at Household', 'Wife'])                        => -0.0677478756,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Brother', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandparent', 'Grandson', 'Husband', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject']) => -0.0078396139,
    phone_subject_title = ''                                                                                                                                                                                                                                     => -0.0184578369,
                                                                                                                                                                                                                                                                    -0.0184578369);

final_score_250_c1389 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.447973618836902 => 0.0139304166,
    f_add_input_mobility_index_n > 0.447973618836902                                          => 0.0892304872,
    f_add_input_mobility_index_n = NULL                                                       => 0.0367846486,
                                                                                                 0.0367846486);

final_score_250_c1390 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 12.5 => 0.0613251143,
    mth_source_utildid_fseen > 12.5                                      => 0.0034443722,
    mth_source_utildid_fseen = NULL                                      => 0.0026883702,
                                                                            0.0037446998);

final_score_250_c1388 := map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i <= 14.5 => final_score_250_c1389,
    f_prevaddrmurderindex_i > 14.5                                     => final_score_250_c1390,
    f_prevaddrmurderindex_i = NULL                                     => 0.0066866814,
                                                                          0.0066866814);

final_score_250 := map(
    NULL < f_mos_inq_banko_cm_fseen_d AND f_mos_inq_banko_cm_fseen_d <= 46.5 => final_score_250_c1387,
    f_mos_inq_banko_cm_fseen_d > 46.5                                        => final_score_250_c1388,
    f_mos_inq_banko_cm_fseen_d = NULL                                        => 0.0021721257,
                                                                                0.0021721257);

final_score_251_c1394 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 34.5 => 0.0842911778,
    mth_pp_app_npa_last_change_dt > 34.5                                           => 0.0023261562,
    mth_pp_app_npa_last_change_dt = NULL                                           => 0.0177229006,
                                                                                      0.0177229006);

final_score_251_c1393 := map(
    NULL < inq_num_adls AND inq_num_adls <= 1.5 => final_score_251_c1394,
    inq_num_adls > 1.5                          => -0.0621910012,
    inq_num_adls = NULL                         => 0.0043630612,
                                                   0.0043630612);

final_score_251_c1392 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 47.5 => final_score_251_c1393,
    r_pb_order_freq_d > 47.5                               => -0.0459385832,
    r_pb_order_freq_d = NULL                               => -0.0119635124,
                                                              -0.0123188184);

final_score_251_c1395 := map(
    (segment in ['1 - Other'])                                        => -0.0502051096,
    (segment in ['0 - Disconnected', '2 - Cell Phone', '3 - ExpHit']) => 0.0167906295,
    segment = ''                                                      => 0.0050987603,
                                                                         0.0050987603);

final_score_251 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 149.5 => final_score_251_c1392,
    mth_pp_app_npa_effective_dt > 149.5                                         => final_score_251_c1395,
    mth_pp_app_npa_effective_dt = NULL                                          => -0.0030504046,
                                                                                   -0.0029558061);

final_score_252_c1398 := map(
    (phone_subject_title in ['Associate By Property', 'Associate By SSN', 'Daughter', 'Grandmother', 'Parent', 'Son', 'Subject at Household'])                                                                                                                                                                                                              => -0.0984598671,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Wife']) => -0.0224548072,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                => -0.0304301545,
                                                                                                                                                                                                                                                                                                                                                               -0.0304301545);

final_score_252_c1397 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 268579.5 => 0.0001860017,
    f_prevaddrmedianvalue_d > 268579.5                                     => final_score_252_c1398,
    f_prevaddrmedianvalue_d = NULL                                         => -0.0037928878,
                                                                              -0.0037928878);

final_score_252_c1400 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 55753.5 => 0.1146489587,
    f_prevaddrmedianincome_d > 55753.5                                      => 0.0309154116,
    f_prevaddrmedianincome_d = NULL                                         => 0.0532163061,
                                                                               0.0532163061);

final_score_252_c1399 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Child', 'Daughter', 'Father', 'Husband', 'Neighbor', 'Relative', 'Sibling', 'Subject at Household'])                                                                => -0.0220830504,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Mother', 'Parent', 'Sister', 'Son', 'Spouse', 'Subject', 'Wife']) => final_score_252_c1400,
    phone_subject_title = ''                                                                                                                                                                                                                                                         => 0.0182522711,
                                                                                                                                                                                                                                                                                        0.0182522711);

final_score_252 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 408271 => final_score_252_c1397,
    f_prevaddrmedianvalue_d > 408271                                     => final_score_252_c1399,
    f_prevaddrmedianvalue_d = NULL                                       => -0.0017647114,
                                                                            -0.0017647114);

final_score_253_c1402 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Brother', 'Child', 'Daughter', 'Grandfather', 'Husband', 'Mother', 'Sibling', 'Spouse', 'Subject at Household'])                                                                                                          => -0.0601543964,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Neighbor', 'Parent', 'Relative', 'Sister', 'Son', 'Subject', 'Wife']) => -0.0097165440,
    phone_subject_title = ''                                                                                                                                                                                                                                                                              => -0.0186811465,
                                                                                                                                                                                                                                                                                                             -0.0186811465);

final_score_253_c1404 := map(
    NULL < f_crim_rel_under100miles_cnt_i AND f_crim_rel_under100miles_cnt_i <= 1.5 => -0.0818679071,
    f_crim_rel_under100miles_cnt_i > 1.5                                            => -0.0183770899,
    f_crim_rel_under100miles_cnt_i = NULL                                           => -0.0528497673,
                                                                                       -0.0528497673);

final_score_253_c1405 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.254282776570391 => 0.0445673768,
    f_add_curr_mobility_index_n > 0.254282776570391                                         => 0.0025172941,
    f_add_curr_mobility_index_n = NULL                                                      => 0.0059808080,
                                                                                               0.0059808080);

final_score_253_c1403 := map(
    NULL < f_curraddrcrimeindex_i AND f_curraddrcrimeindex_i <= 13 => final_score_253_c1404,
    f_curraddrcrimeindex_i > 13                                    => final_score_253_c1405,
    f_curraddrcrimeindex_i = NULL                                  => 0.0033050248,
                                                                      0.0033050248);

final_score_253 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.249839153271657 => final_score_253_c1402,
    f_add_input_mobility_index_n > 0.249839153271657                                          => final_score_253_c1403,
    f_add_input_mobility_index_n = NULL                                                       => -0.0010394492,
                                                                                                 -0.0010394492);

final_score_254_c1409 := map(
    NULL < pk_disconnect_flag AND pk_disconnect_flag <= 2.5 => 0.0012873609,
    pk_disconnect_flag > 2.5                                => -0.0680915084,
    pk_disconnect_flag = NULL                               => -0.0001402292,
                                                               -0.0001402292);

final_score_254_c1408 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 1.23737538234961 => final_score_254_c1409,
    f_add_input_mobility_index_n > 1.23737538234961                                          => -0.0781715502,
    f_add_input_mobility_index_n = NULL                                                      => -0.0014083077,
                                                                                                -0.0014083077);

final_score_254_c1410 := map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 5.5 => 0.0116672728,
    f_sourcerisktype_i > 5.5                                => 0.1035690719,
    f_sourcerisktype_i = NULL                               => 0.0316174854,
                                                               0.0316174854);

final_score_254_c1407 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Father', 'Grandfather', 'Grandson', 'Neighbor', 'Sibling', 'Sister', 'Subject', 'Subject at Household', 'Wife']) => final_score_254_c1408,
    (phone_subject_title in ['Associate By Property', 'Brother', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Husband', 'Mother', 'Parent', 'Relative', 'Son', 'Spouse'])                                                                            => final_score_254_c1410,
    phone_subject_title = ''                                                                                                                                                                                                                                                               => 0.0021060502,
                                                                                                                                                                                                                                                                                              0.0021060502);

final_score_254 := map(
    (pp_did_type in ['', 'AMBIG', 'CORE'])             => final_score_254_c1407,
    (pp_did_type in ['C_MERGE', 'INACTIVE', 'NO_SSN']) => 0.0658632168,
    pp_did_type = ''                                   => 0.0033218258,
                                                          0.0033218258);

final_score_255_c1415 := map(
    (eda_pfrd_address_ind in ['1A', '1E', 'XX']) => 0.0021738033,
    (eda_pfrd_address_ind in ['1B', '1C', '1D']) => 0.0679796895,
    eda_pfrd_address_ind = ''                    => 0.0062714435,
                                                    0.0062714435);

final_score_255_c1414 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 1233.5 => final_score_255_c1415,
    f_addrchangevaluediff_d > 1233.5                                     => -0.0121195556,
    f_addrchangevaluediff_d = NULL                                       => -0.0057398907,
                                                                            -0.0033021043);

final_score_255_c1413 := map(
    NULL < f_inq_per_ssn_i AND f_inq_per_ssn_i <= 9.5 => final_score_255_c1414,
    f_inq_per_ssn_i > 9.5                             => -0.0889363538,
    f_inq_per_ssn_i = NULL                            => -0.0047548480,
                                                         -0.0047548480);

final_score_255_c1412 := map(
    NULL < (Integer)source_edala AND (Integer)source_edala <= 0.5 => final_score_255_c1413,
    (Integer)source_edala > 0.5                                   => -0.0541278660,
    (Integer)source_edala = NULL                                  => -0.0055784651,
                                                                     -0.0055784651);

final_score_255 := map(
    NULL < mth_source_edaca_lseen AND mth_source_edaca_lseen <= 3 => 0.0587228774,
    mth_source_edaca_lseen > 3                                    => -0.0252914457,
    mth_source_edaca_lseen = NULL                                 => final_score_255_c1412,
                                                                     -0.0050824971);

final_score_256_c1418 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 13.5 => -0.0553038526,
    f_rel_educationover12_count_d > 13.5                                           => 0.0389190890,
    f_rel_educationover12_count_d = NULL                                           => -0.0222224436,
                                                                                      -0.0222224436);

final_score_256_c1420 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 420923 => -0.0263503544,
    f_curraddrmedianvalue_d > 420923                                     => 0.0550204105,
    f_curraddrmedianvalue_d = NULL                                       => -0.0109069500,
                                                                            -0.0109069500);

final_score_256_c1419 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 71803.5 => 0.0207817618,
    f_curraddrmedianincome_d > 71803.5                                      => final_score_256_c1420,
    f_curraddrmedianincome_d = NULL                                         => 0.0124506620,
                                                                               0.0124506620);

final_score_256_c1417 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 66.5 => final_score_256_c1418,
    mth_pp_app_npa_effective_dt > 66.5                                         => final_score_256_c1419,
    mth_pp_app_npa_effective_dt = NULL                                         => 0.0007443867,
                                                                                  0.0045271541);

final_score_256 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 178.5 => final_score_256_c1417,
    f_curraddrcartheftindex_i > 178.5                                       => -0.0241805536,
    f_curraddrcartheftindex_i = NULL                                        => 0.0008404800,
                                                                               0.0008404800);

final_score_257_c1424 := map(
    NULL < (Integer)inq_firstseen_n AND (Integer)inq_firstseen_n <= 60.5 => -0.0079745974,
    (Integer)inq_firstseen_n > 60.5                                      => 0.0931901719,
    (Integer)inq_firstseen_n = NULL                                      => -0.0322482526,
                                                                            -0.0004325978);

final_score_257_c1423 := map(
    NULL < mth_pp_orig_lastseen AND mth_pp_orig_lastseen <= 25.5 => 0.0385069766,
    mth_pp_orig_lastseen > 25.5                                  => -0.0295547820,
    mth_pp_orig_lastseen = NULL                                  => final_score_257_c1424,
                                                                    0.0116280058);

final_score_257_c1422 := map(
    NULL < f_rel_bankrupt_count_i AND f_rel_bankrupt_count_i <= 3.5 => -0.0070393797,
    f_rel_bankrupt_count_i > 3.5                                    => final_score_257_c1423,
    f_rel_bankrupt_count_i = NULL                                   => -0.0026707211,
                                                                       -0.0026707211);

final_score_257_c1425 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Daughter', 'Father', 'Husband', 'Mother', 'Sister', 'Subject at Household'])                                                                          => -0.0159834527,
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Associate By Vehicle', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Son', 'Spouse', 'Subject', 'Wife']) => 0.0847069505,
    phone_subject_title = ''                                                                                                                                                                                                                                                              => 0.0405745610,
                                                                                                                                                                                                                                                                                             0.0405745610);

final_score_257 := map(
    NULL < (Integer)_phone_match_code_d AND (Integer)_phone_match_code_d <= 0.5 => final_score_257_c1422,
    (Integer)_phone_match_code_d > 0.5                                          => final_score_257_c1425,
    (Integer)_phone_match_code_d = NULL                                         => -0.0014123455,
                                                                                   -0.0014123455);

final_score_258_c1428 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 8.5 => 0.0171266592,
    f_addrchangecrimediff_i > 8.5                                     => -0.0674544080,
    f_addrchangecrimediff_i = NULL                                    => -0.0213192805,
                                                                         -0.0213192805);

final_score_258_c1429 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -258715.5 => 0.0711404182,
    f_addrchangevaluediff_d > -258715.5                                     => 0.0057740745,
    f_addrchangevaluediff_d = NULL                                          => 0.0050601517,
                                                                               0.0074237474);

final_score_258_c1427 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 25.5 => 0.0343273685,
    mth_source_utildid_fseen > 25.5                                      => final_score_258_c1428,
    mth_source_utildid_fseen = NULL                                      => final_score_258_c1429,
                                                                            0.0064728730);

final_score_258_c1430 := map(
    NULL < inq_num AND inq_num <= 1.5 => -0.0259467936,
    inq_num > 1.5                     => 0.0430560080,
    inq_num = NULL                    => -0.0215052339,
                                         -0.0215052339);

final_score_258 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 167.5 => final_score_258_c1427,
    f_prevaddrcartheftindex_i > 167.5                                       => final_score_258_c1430,
    f_prevaddrcartheftindex_i = NULL                                        => 0.0004449005,
                                                                               0.0004449005);

final_score_259_c1433 := map(
    NULL < eda_days_in_service AND eda_days_in_service <= 551.5 => 0.0533036568,
    eda_days_in_service > 551.5                                 => -0.0515151202,
    eda_days_in_service = NULL                                  => -0.0030962943,
                                                                   -0.0030962943);

final_score_259_c1432 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 0.5 => 0.0985794599,
    f_inq_count24_i > 0.5                             => final_score_259_c1433,
    f_inq_count24_i = NULL                            => 0.0241180340,
                                                         0.0241180340);

final_score_259_c1434 := map(
    NULL < (Integer)inq_lastseen_n AND (Integer)inq_lastseen_n <= 19.5 => -0.0369447348,
    (Integer)inq_lastseen_n > 19.5                                     => 0.0404147274,
    (Integer)inq_lastseen_n = NULL                                     => -0.0800824271,
                                                                          -0.0262271617);

final_score_259_c1435 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 44350 => 0.0467090989,
    f_curraddrmedianvalue_d > 44350                                     => 0.0012281616,
    f_curraddrmedianvalue_d = NULL                                      => 0.0033142069,
                                                                           0.0033142069);

final_score_259 := map(
    NULL < mth_source_cr_fseen AND mth_source_cr_fseen <= 22.5 => final_score_259_c1432,
    mth_source_cr_fseen > 22.5                                 => final_score_259_c1434,
    mth_source_cr_fseen = NULL                                 => final_score_259_c1435,
                                                                  0.0029699017);

final_score_260_c1438 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 127.5 => -0.0109236208,
    mth_pp_eda_hist_did_dt > 127.5                                    => 0.0617994706,
    mth_pp_eda_hist_did_dt = NULL                                     => -0.0043597028,
                                                                         -0.0052831860);

final_score_260_c1440 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Shared Associates', 'Associate By SSN', 'Child', 'Father', 'Grandfather', 'Neighbor', 'Parent', 'Relative', 'Sister', 'Son', 'Subject at Household', 'Wife'])                => 0.0014339723,
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Sibling', 'Spouse', 'Subject']) => 0.0824161640,
    phone_subject_title = ''                                                                                                                                                                                                                                 => 0.0343123008,
                                                                                                                                                                                                                                                                0.0343123008);

final_score_260_c1439 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 18.5 => -0.0046754869,
    f_rel_under500miles_cnt_d > 18.5                                       => final_score_260_c1440,
    f_rel_under500miles_cnt_d = NULL                                       => 0.0025987978,
                                                                              0.0025987978);

final_score_260_c1437 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -39130.5 => -0.0518089541,
    f_addrchangeincomediff_d > -39130.5                                      => final_score_260_c1438,
    f_addrchangeincomediff_d = NULL                                          => final_score_260_c1439,
                                                                                -0.0051852723);

final_score_260 := map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 1.5 => 0.0467044638,
    f_sourcerisktype_i > 1.5                                => final_score_260_c1437,
    f_sourcerisktype_i = NULL                               => -0.0034759633,
                                                               -0.0034759633);

final_score_261_c1442 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.428406169753818 => -0.0542874109,
    f_add_input_mobility_index_n > 0.428406169753818                                          => -0.0351947685,
    f_add_input_mobility_index_n = NULL                                                       => -0.0467755516,
                                                                                                 -0.0467755516);

final_score_261_c1443 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 310.5 => 0.0048569016,
    f_prevaddrageoldest_d > 310.5                                   => -0.0456659791,
    f_prevaddrageoldest_d = NULL                                    => 0.0008423399,
                                                                       0.0008423399);

final_score_261_c1445 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 17.5 => -0.0110021171,
    mth_source_sx_fseen > 17.5                                 => 0.0315731225,
    mth_source_sx_fseen = NULL                                 => -0.0048462819,
                                                                  -0.0022038020);

final_score_261_c1444 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 10.5 => -0.0278368413,
    mth_source_rel_fseen > 10.5                                  => 0.0254521177,
    mth_source_rel_fseen = NULL                                  => final_score_261_c1445,
                                                                    -0.0022216280);

final_score_261 := map(
    NULL < mth_pp_orig_lastseen AND mth_pp_orig_lastseen <= 3.5 => final_score_261_c1442,
    mth_pp_orig_lastseen > 3.5                                  => final_score_261_c1443,
    mth_pp_orig_lastseen = NULL                                 => final_score_261_c1444,
                                                                   -0.0026500235);

final_score_262_c1448 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 2.5 => -0.0431197047,
    mth_pp_first_build_date > 2.5                                     => 0.0061951129,
    mth_pp_first_build_date = NULL                                    => -0.0211799666,
                                                                         -0.0043873461);

final_score_262_c1447 := map(
    NULL < mth_internal_ver_first_seen AND mth_internal_ver_first_seen <= 4.5 => 0.0293939812,
    mth_internal_ver_first_seen > 4.5                                         => final_score_262_c1448,
    mth_internal_ver_first_seen = NULL                                        => -0.0051933931,
                                                                                 -0.0015264754);

final_score_262_c1450 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 189708 => 0.0157821105,
    f_curraddrmedianvalue_d > 189708                                     => 0.0847463491,
    f_curraddrmedianvalue_d = NULL                                       => 0.0344945079,
                                                                            0.0344945079);

final_score_262_c1449 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 5.5 => final_score_262_c1450,
    f_rel_homeover300_count_d > 5.5                                       => -0.0366799179,
    f_rel_homeover300_count_d = NULL                                      => 0.0223522283,
                                                                             0.0223522283);

final_score_262 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Daughter', 'Granddaughter', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Relative', 'Sibling', 'Son', 'Spouse', 'Subject']) => final_score_262_c1447,
    (phone_subject_title in ['Associate By Property', 'Associate By Vehicle', 'Child', 'Father', 'Grandchild', 'Grandfather', 'Grandmother', 'Grandparent', 'Parent', 'Sister', 'Subject at Household', 'Wife'])                                                                          => final_score_262_c1449,
    phone_subject_title = ''                                                                                                                                                                                                                                                              => 0.0017318618,
                                                                                                                                                                                                                                                                                             0.0017318618);

final_score_263_c1453 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 93 => -0.0350409540,
    f_curraddrburglaryindex_i > 93                                       => 0.0506215366,
    f_curraddrburglaryindex_i = NULL                                     => 0.0088497214,
                                                                            0.0088497214);

final_score_263_c1452 := map(
    NULL < f_curraddractivephonelist_d AND f_curraddractivephonelist_d <= 0.5 => -0.0144338417,
    f_curraddractivephonelist_d > 0.5                                         => final_score_263_c1453,
    f_curraddractivephonelist_d = NULL                                        => -0.0113832637,
                                                                                 -0.0113832637);

final_score_263_c1455 := map(
    (phone_subject_title in ['Associate', 'Associate By Shared Associates', 'Associate By SSN', 'Grandmother', 'Grandson', 'Husband', 'Mother', 'Relative', 'Sibling', 'Spouse', 'Subject', 'Subject at Household'])                                                                  => 0.0142047339,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Neighbor', 'Parent', 'Sister', 'Son', 'Wife']) => 0.1250674415,
    phone_subject_title = ''                                                                                                                                                                                                                                                          => 0.0190836592,
                                                                                                                                                                                                                                                                                         0.0190836592);

final_score_263_c1454 := map(
    NULL < pk_phone_match_level AND pk_phone_match_level <= 1.5 => 0.0018005687,
    pk_phone_match_level > 1.5                                  => final_score_263_c1455,
    pk_phone_match_level = NULL                                 => 0.0085165681,
                                                                   0.0085165681);

final_score_263 := map(
    (pp_origlistingtype in ['B', 'R', 'RB']) => final_score_263_c1452,
    (pp_origlistingtype in ['', 'BG'])       => final_score_263_c1454,
    pp_origlistingtype = ''                  => 0.0031695355,
                                                0.0031695355);

final_score_264_c1459 := map(
    NULL < _phone_zip_match AND _phone_zip_match <= 0.5 => 0.0294511376,
    _phone_zip_match > 0.5                              => 0.1371643286,
    _phone_zip_match = NULL                             => 0.0656317223,
                                                           0.0656317223);

final_score_264_c1458 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandfather', 'Grandson', 'Mother', 'Neighbor', 'Sibling', 'Sister', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => 0.0114902957,
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Husband', 'Parent', 'Relative', 'Son'])                                                                                                        => final_score_264_c1459,
    phone_subject_title = ''                                                                                                                                                                                                                                                                             => 0.0181935200,
                                                                                                                                                                                                                                                                                                            0.0181935200);

final_score_264_c1457 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.333848767950565 => final_score_264_c1458,
    f_add_input_mobility_index_n > 0.333848767950565                                          => -0.0041865321,
    f_add_input_mobility_index_n = NULL                                                       => 0.0056238164,
                                                                                                 0.0056238164);

final_score_264_c1460 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 56.5 => 0.0486592554,
    f_fp_prevaddrburglaryindex_i > 56.5                                          => -0.0402648325,
    f_fp_prevaddrburglaryindex_i = NULL                                          => -0.0244861604,
                                                                                    -0.0244861604);

final_score_264 := map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i <= 5.5 => final_score_264_c1457,
    f_crim_rel_under25miles_cnt_i > 5.5                                           => final_score_264_c1460,
    f_crim_rel_under25miles_cnt_i = NULL                                          => 0.0026719312,
                                                                                     0.0026719312);

final_score_265_c1464 := map(
    NULL < f_mos_inq_banko_om_lseen_d AND f_mos_inq_banko_om_lseen_d <= 32.5 => -0.0779942485,
    f_mos_inq_banko_om_lseen_d > 32.5                                        => 0.0144791034,
    f_mos_inq_banko_om_lseen_d = NULL                                        => -0.0154561804,
                                                                                -0.0154561804);

final_score_265_c1465 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 94 => 0.1085299644,
    f_fp_prevaddrcrimeindex_i > 94                                       => 0.0128011845,
    f_fp_prevaddrcrimeindex_i = NULL                                     => 0.0604876399,
                                                                            0.0604876399);

final_score_265_c1463 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 0.5 => final_score_265_c1464,
    f_rel_homeover300_count_d > 0.5                                       => final_score_265_c1465,
    f_rel_homeover300_count_d = NULL                                      => 0.0197054163,
                                                                             0.0197054163);

final_score_265_c1462 := map(
    NULL < mth_pp_datefirstseen AND mth_pp_datefirstseen <= 26.5 => -0.0198000813,
    mth_pp_datefirstseen > 26.5                                  => final_score_265_c1463,
    mth_pp_datefirstseen = NULL                                  => 0.0003977084,
                                                                    -0.0021136002);

final_score_265 := map(
    NULL < (Integer)inq_adl_firstseen_n AND (Integer)inq_adl_firstseen_n <= 53.5 => final_score_265_c1462,
    (Integer)inq_adl_firstseen_n > 53.5                                          => -0.0451757881,
    (Integer)inq_adl_firstseen_n = NULL                                          => 0.0051645897,
                                                                                    0.0003132983);

final_score_266_c1469 := map(
    NULL < mth_pp_eda_hist_did_dt AND mth_pp_eda_hist_did_dt <= 44.5 => -0.0834309559,
    mth_pp_eda_hist_did_dt > 44.5                                    => 0.0106452162,
    mth_pp_eda_hist_did_dt = NULL                                    => -0.0069608651,
                                                                        -0.0219275036);

final_score_266_c1468 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 2.5 => 0.0297092363,
    f_srchfraudsrchcount_i > 2.5                                    => final_score_266_c1469,
    f_srchfraudsrchcount_i = NULL                                   => 0.0048801982,
                                                                       0.0048801982);

final_score_266_c1467 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 18.5 => final_score_266_c1468,
    mth_exp_last_update > 18.5                                 => -0.0244011017,
    mth_exp_last_update = NULL                                 => 0.0050601912,
                                                                  0.0027645841);

final_score_266_c1470 := map(
    NULL < (Integer)source_ppla AND (Integer)source_ppla <= 0.5 => -0.0185752750,
    (Integer)source_ppla > 0.5                                  => -0.0745334589,
    (Integer)source_ppla = NULL                                 => -0.0245906534,
                                                                   -0.0245906534);

final_score_266 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 274.5 => final_score_266_c1467,
    f_prevaddrageoldest_d > 274.5                                   => final_score_266_c1470,
    f_prevaddrageoldest_d = NULL                                    => -0.0009855395,
                                                                       -0.0009855395);

final_score_267_c1475 := map(
    NULL < mth_pp_datevendorfirstseen AND mth_pp_datevendorfirstseen <= 19.5 => -0.0656444316,
    mth_pp_datevendorfirstseen > 19.5                                        => 0.0097777894,
    mth_pp_datevendorfirstseen = NULL                                        => -0.0223257936,
                                                                                -0.0286091699);

final_score_267_c1474 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.647889369387757 => 0.0017360617,
    f_add_input_mobility_index_n > 0.647889369387757                                          => final_score_267_c1475,
    f_add_input_mobility_index_n = NULL                                                       => -0.0012677502,
                                                                                                 -0.0012677502);

final_score_267_c1473 := map(
    NULL < mth_source_edahistory_fseen AND mth_source_edahistory_fseen <= 61.5 => -0.0253030129,
    mth_source_edahistory_fseen > 61.5                                         => -0.0687396496,
    mth_source_edahistory_fseen = NULL                                         => final_score_267_c1474,
                                                                                  -0.0028183024);

final_score_267_c1472 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 12.5 => 0.0290360995,
    mth_source_rel_fseen > 12.5                                  => -0.0231517849,
    mth_source_rel_fseen = NULL                                  => final_score_267_c1473,
                                                                    -0.0022318099);

final_score_267 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 1.09035079273914 => final_score_267_c1472,
    f_add_input_mobility_index_n > 1.09035079273914                                          => 0.0627866230,
    f_add_input_mobility_index_n = NULL                                                      => -0.0006061459,
                                                                                                -0.0006061459);

final_score_268_c1477 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 106.5 => -0.0247697865,
    f_fp_prevaddrburglaryindex_i > 106.5                                          => 0.0517669102,
    f_fp_prevaddrburglaryindex_i = NULL                                           => 0.0099583182,
                                                                                     0.0099583182);

final_score_268_c1480 := map(
    NULL < mth_source_ppdid_lseen AND mth_source_ppdid_lseen <= 12.5 => 0.0408399467,
    mth_source_ppdid_lseen > 12.5                                    => -0.0007276510,
    mth_source_ppdid_lseen = NULL                                    => 0.0172012304,
                                                                        0.0172012304);

final_score_268_c1479 := map(
    NULL < f_crim_rel_under500miles_cnt_i AND f_crim_rel_under500miles_cnt_i <= 3.5 => final_score_268_c1480,
    f_crim_rel_under500miles_cnt_i > 3.5                                            => -0.0303548037,
    f_crim_rel_under500miles_cnt_i = NULL                                           => 0.0059675216,
                                                                                       0.0059675216);

final_score_268_c1478 := map(
    NULL < mth_source_ppfla_fseen AND mth_source_ppfla_fseen <= 86.5 => final_score_268_c1479,
    mth_source_ppfla_fseen > 86.5                                    => -0.0558086227,
    mth_source_ppfla_fseen = NULL                                    => 0.0011314671,
                                                                        0.0007067547);

final_score_268 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 4.5 => -0.0508804855,
    mth_source_rel_fseen > 4.5                                  => final_score_268_c1477,
    mth_source_rel_fseen = NULL                                 => final_score_268_c1478,
                                                                   0.0003024743);

final_score_269_c1484 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Grandfather', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Son'])            => -0.0379910762,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Vehicle', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Relative', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => 0.0379504047,
    phone_subject_title = ''                                                                                                                                                                                                                               => 0.0160895457,
                                                                                                                                                                                                                                                              0.0160895457);

final_score_269_c1485 := map(
    NULL < pp_total_source_conf AND pp_total_source_conf <= 20.5 => 0.0053867864,
    pp_total_source_conf > 20.5                                  => -0.0659168984,
    pp_total_source_conf = NULL                                  => 0.0039003755,
                                                                    0.0039003755);

final_score_269_c1483 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.228267188078 => final_score_269_c1484,
    f_add_input_mobility_index_n > 0.228267188078                                          => final_score_269_c1485,
    f_add_input_mobility_index_n = NULL                                                    => 0.0056190501,
                                                                                              0.0056190501);

final_score_269_c1482 := map(
    NULL < eda_min_days_interrupt AND eda_min_days_interrupt <= 22 => final_score_269_c1483,
    eda_min_days_interrupt > 22                                    => -0.0452051320,
    eda_min_days_interrupt = NULL                                  => 0.0034048641,
                                                                      0.0034048641);

final_score_269 := map(
    NULL < f_vardobcount_i AND f_vardobcount_i <= 3.5 => final_score_269_c1482,
    f_vardobcount_i > 3.5                             => -0.0813464924,
    f_vardobcount_i = NULL                            => 0.0022503565,
                                                         0.0022503565);

final_score_270_c1487 := map(
    (phone_subject_title in ['Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Daughter', 'Father', 'Grandfather', 'Mother', 'Neighbor', 'Spouse', 'Wife'])                                                                                                                                  => -0.0402187684,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Vehicle', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject', 'Subject at Household']) => 0.0881829716,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                          => 0.0305332108,
                                                                                                                                                                                                                                                                                                                         0.0305332108);

final_score_270_c1490 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => -0.0053137644,
    f_validationrisktype_i > 1.5                                    => 0.0178304660,
    f_validationrisktype_i = NULL                                   => 0.0000402255,
                                                                       0.0000402255);

final_score_270_c1489 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 3.5 => final_score_270_c1490,
    f_varrisktype_i > 3.5                             => -0.0479631647,
    f_varrisktype_i = NULL                            => -0.0025564871,
                                                         -0.0025564871);

final_score_270_c1488 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 12.5 => 0.0230331891,
    mth_source_rel_fseen > 12.5                                  => -0.0285992947,
    mth_source_rel_fseen = NULL                                  => final_score_270_c1489,
                                                                    -0.0022295946);

final_score_270 := map(
    NULL < _phone_fb_rp_result AND _phone_fb_rp_result <= 0.5 => final_score_270_c1487,
    _phone_fb_rp_result > 0.5                                 => final_score_270_c1488,
    _phone_fb_rp_result = NULL                                => -0.0006393247,
                                                                 -0.0006393247);

final_score_271_c1493 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 51386 => -0.0714226491,
    f_prevaddrmedianincome_d > 51386                                      => 0.0139812037,
    f_prevaddrmedianincome_d = NULL                                       => -0.0252849355,
                                                                             -0.0252849355);

final_score_271_c1495 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By SSN', 'Brother', 'Daughter', 'Grandmother', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject'])      => 0.0173439207,
    (phone_subject_title in ['Associate By Business', 'Associate By Shared Associates', 'Associate By Vehicle', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Grandson', 'Husband', 'Subject at Household', 'Wife']) => 0.0829975569,
    phone_subject_title = ''                                                                                                                                                                                                                            => 0.0280266928,
                                                                                                                                                                                                                                                           0.0280266928);

final_score_271_c1494 := map(
    NULL < f_prevaddrmurderindex_i AND f_prevaddrmurderindex_i <= 150.5 => 0.0031320023,
    f_prevaddrmurderindex_i > 150.5                                     => final_score_271_c1495,
    f_prevaddrmurderindex_i = NULL                                      => 0.0105710063,
                                                                           0.0105710063);

final_score_271_c1492 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.199194065464934 => final_score_271_c1493,
    f_add_curr_mobility_index_n > 0.199194065464934                                         => final_score_271_c1494,
    f_add_curr_mobility_index_n = NULL                                                      => 0.0072299136,
                                                                                               0.0072299136);

final_score_271 := map(
    NULL < eda_avg_days_interrupt AND eda_avg_days_interrupt <= 50.5 => final_score_271_c1492,
    eda_avg_days_interrupt > 50.5                                    => -0.0184778612,
    eda_avg_days_interrupt = NULL                                    => -0.0004894220,
                                                                        -0.0004894220);

final_score_272_c1497 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 170586 => -0.0599208198,
    f_curraddrmedianvalue_d > 170586                                     => 0.0313839678,
    f_curraddrmedianvalue_d = NULL                                       => -0.0142684260,
                                                                            -0.0142684260);

final_score_272_c1500 := map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d <= 101.5 => 0.1047412144,
    f_mos_acc_lseen_d > 101.5                               => 0.0228489845,
    f_mos_acc_lseen_d = NULL                                => 0.0331826340,
                                                               0.0331826340);

final_score_272_c1499 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Property', 'Associate By Vehicle', 'Child', 'Granddaughter', 'Grandson', 'Husband', 'Neighbor', 'Parent', 'Son', 'Spouse', 'Wife'])                                                                                              => -0.0334378201,
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Daughter', 'Father', 'Grandchild', 'Grandfather', 'Grandmother', 'Grandparent', 'Mother', 'Relative', 'Sibling', 'Sister', 'Subject', 'Subject at Household']) => final_score_272_c1500,
    phone_subject_title = ''                                                                                                                                                                                                                                                                        => 0.0083337199,
                                                                                                                                                                                                                                                                                                       0.0083337199);

final_score_272_c1498 := map(
    NULL < mth_eda_dt_last_seen AND mth_eda_dt_last_seen <= 4.5 => -0.0157449053,
    mth_eda_dt_last_seen > 4.5                                  => final_score_272_c1499,
    mth_eda_dt_last_seen = NULL                                 => -0.0012755353,
                                                                   -0.0041526595);

final_score_272 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 10.5 => final_score_272_c1497,
    mth_source_rel_fseen > 10.5                                  => 0.0402627816,
    mth_source_rel_fseen = NULL                                  => final_score_272_c1498,
                                                                    -0.0036992143);

final_score_273_c1503 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 111.5 => -0.0206698698,
    f_prevaddrlenofres_d > 111.5                                  => 0.0620337218,
    f_prevaddrlenofres_d = NULL                                   => 0.0243667395,
                                                                     0.0243667395);

final_score_273_c1505 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 162175.5 => -0.0140601247,
    f_curraddrmedianvalue_d > 162175.5                                     => 0.0188084344,
    f_curraddrmedianvalue_d = NULL                                         => 0.0014702097,
                                                                              0.0014702097);

final_score_273_c1504 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 322.5 => final_score_273_c1505,
    r_pb_order_freq_d > 322.5                               => -0.0415737111,
    r_pb_order_freq_d = NULL                                => 0.0056949087,
                                                               0.0011083039);

final_score_273_c1502 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 18.5 => -0.0329798686,
    mth_source_sx_fseen > 18.5                                 => final_score_273_c1503,
    mth_source_sx_fseen = NULL                                 => final_score_273_c1504,
                                                                  0.0014191470);

final_score_273 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household']) => final_score_273_c1502,
    (phone_subject_title in ['Associate By Property', 'Grandchild', 'Granddaughter', 'Mother', 'Wife'])                                                                                                                                                                                                                                                                                            => 0.0614034873,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                                                       => 0.0029714907,
                                                                                                                                                                                                                                                                                                                                                                                                      0.0029714907);

final_score_274_c1507 := map(
    NULL < mth_exp_last_update AND mth_exp_last_update <= 17.5 => -0.0621514600,
    mth_exp_last_update > 17.5                                 => -0.0121856458,
    mth_exp_last_update = NULL                                 => -0.0019653184,
                                                                  -0.0099596648);

final_score_274_c1510 := map(
    NULL < f_srchaddrsrchcount_i AND f_srchaddrsrchcount_i <= 3.5 => 0.0434971098,
    f_srchaddrsrchcount_i > 3.5                                   => -0.0310075897,
    f_srchaddrsrchcount_i = NULL                                  => 0.0149560788,
                                                                     0.0149560788);

final_score_274_c1509 := map(
    NULL < (Integer)f_util_add_curr_conv_n AND (Integer)f_util_add_curr_conv_n <= 0.5 => final_score_274_c1510,
    (Integer)f_util_add_curr_conv_n > 0.5                                             => -0.0264562241,
    (Integer)f_util_add_curr_conv_n = NULL                                            => -0.0119138163,
                                                                                         -0.0119138163);

final_score_274_c1508 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Father', 'Neighbor', 'Relative', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_274_c1509,
    (phone_subject_title in ['Associate By Property', 'Associate By Vehicle', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Parent', 'Sibling', 'Sister'])                              => 0.0697002254,
    phone_subject_title = ''                                                                                                                                                                                                                                        => -0.0063660340,
                                                                                                                                                                                                                                                                       -0.0063660340);

final_score_274 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 34.5 => 0.0091655415,
    f_addrchangecrimediff_i > 34.5                                     => final_score_274_c1507,
    f_addrchangecrimediff_i = NULL                                     => final_score_274_c1508,
                                                                          0.0020164888);

final_score_275_c1512 := map(
    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i <= 1.5 => 0.0481145265,
    f_crim_rel_under25miles_cnt_i > 1.5                                           => -0.0134686992,
    f_crim_rel_under25miles_cnt_i = NULL                                          => 0.0291411045,
                                                                                     0.0291411045);

final_score_275_c1515 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 68 => -0.1282343987,
    f_fp_prevaddrburglaryindex_i > 68                                          => -0.0332419663,
    f_fp_prevaddrburglaryindex_i = NULL                                        => -0.0686083796,
                                                                                  -0.0686083796);

final_score_275_c1514 := map(
    NULL < r_mos_since_paw_fseen_d AND r_mos_since_paw_fseen_d <= 126 => -0.0143306940,
    r_mos_since_paw_fseen_d > 126                                     => final_score_275_c1515,
    r_mos_since_paw_fseen_d = NULL                                    => -0.0199973332,
                                                                         -0.0199973332);

final_score_275_c1513 := map(
    NULL < (Integer)_phone_match_code_z AND (Integer)_phone_match_code_z <= 0.5 => final_score_275_c1514,
    (Integer)_phone_match_code_z > 0.5                                          => -0.0001731964,
    (Integer)_phone_match_code_z = NULL                                         => -0.0082076370,
                                                                                   -0.0082076370);

final_score_275 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 1.5 => final_score_275_c1512,
    f_prevaddrlenofres_d > 1.5                                  => final_score_275_c1513,
    f_prevaddrlenofres_d = NULL                                 => -0.0063808969,
                                                                   -0.0063808969);

final_score_276_c1520 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 7405.5 => -0.0080751889,
    f_addrchangeincomediff_d > 7405.5                                      => -0.0926845564,
    f_addrchangeincomediff_d = NULL                                        => -0.0285523011,
                                                                              -0.0363803577);

final_score_276_c1519 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 9.5 => final_score_276_c1520,
    f_prevaddrageoldest_d > 9.5                                   => -0.0006924921,
    f_prevaddrageoldest_d = NULL                                  => -0.0033552635,
                                                                     -0.0033552635);

final_score_276_c1518 := map(
    NULL < mth_source_edahistory_fseen AND mth_source_edahistory_fseen <= 66.5 => -0.0768664453,
    mth_source_edahistory_fseen > 66.5                                         => -0.0177798951,
    mth_source_edahistory_fseen = NULL                                         => final_score_276_c1519,
                                                                                  -0.0046574544);

final_score_276_c1517 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 674160 => final_score_276_c1518,
    f_curraddrmedianvalue_d > 674160                                     => 0.0698235576,
    f_curraddrmedianvalue_d = NULL                                       => -0.0036387464,
                                                                            -0.0036387464);

final_score_276 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 193.5 => final_score_276_c1517,
    f_curraddrcartheftindex_i > 193.5                                       => 0.0418616757,
    f_curraddrcartheftindex_i = NULL                                        => -0.0018020528,
                                                                               -0.0018020528);

final_score_277_c1523 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 128.5 => -0.0401819188,
    mth_pp_app_npa_effective_dt > 128.5                                         => -0.0004361908,
    mth_pp_app_npa_effective_dt = NULL                                          => -0.0055770705,
                                                                                   -0.0090213767);

final_score_277_c1525 := map(
    NULL < f_inq_per_addr_i AND f_inq_per_addr_i <= 2.5 => 0.0156717593,
    f_inq_per_addr_i > 2.5                              => -0.0176180554,
    f_inq_per_addr_i = NULL                             => 0.0076822038,
                                                           0.0076822038);

final_score_277_c1524 := map(
    (phone_subject_title in ['Associate By Property', 'Child', 'Daughter', 'Father', 'Grandmother', 'Grandson', 'Husband', 'Parent', 'Spouse', 'Wife'])                                                                                                                                                                                            => -0.0642921307,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Mother', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject', 'Subject at Household']) => final_score_277_c1525,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                       => 0.0041139925,
                                                                                                                                                                                                                                                                                                                                                      0.0041139925);

final_score_277_c1522 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 4.5 => final_score_277_c1523,
    f_rel_homeover100_count_d > 4.5                                       => final_score_277_c1524,
    f_rel_homeover100_count_d = NULL                                      => -0.0025501046,
                                                                             -0.0025501046);

final_score_277 := map(
    NULL < f_mos_inq_banko_am_fseen_d AND f_mos_inq_banko_am_fseen_d <= 53.5 => -0.0713319114,
    f_mos_inq_banko_am_fseen_d > 53.5                                        => final_score_277_c1522,
    f_mos_inq_banko_am_fseen_d = NULL                                        => -0.0037937137,
                                                                                -0.0037937137);

final_score_278_c1530 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 20.5 => 0.0185407452,
    mth_source_ppdid_fseen > 20.5                                    => -0.0310894515,
    mth_source_ppdid_fseen = NULL                                    => -0.0130990983,
                                                                        -0.0098366969);

final_score_278_c1529 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 247991 => final_score_278_c1530,
    f_curraddrmedianvalue_d > 247991                                     => -0.0534043387,
    f_curraddrmedianvalue_d = NULL                                       => -0.0202291734,
                                                                            -0.0202291734);

final_score_278_c1528 := map(
    NULL < mth_pp_datefirstseen AND mth_pp_datefirstseen <= 35.5 => final_score_278_c1529,
    mth_pp_datefirstseen > 35.5                                  => 0.0145269821,
    mth_pp_datefirstseen = NULL                                  => -0.0099636833,
                                                                    -0.0095414329);

final_score_278_c1527 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 26.5 => 0.0198456163,
    f_fp_prevaddrburglaryindex_i > 26.5                                          => final_score_278_c1528,
    f_fp_prevaddrburglaryindex_i = NULL                                          => -0.0057481047,
                                                                                    -0.0057481047);

final_score_278 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 11.5 => -0.0643459895,
    f_mos_inq_banko_cm_lseen_d > 11.5                                        => final_score_278_c1527,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => -0.0074534301,
                                                                                -0.0074534301);

final_score_279_c1532 := map(
    NULL < mth_source_inf_fseen AND mth_source_inf_fseen <= 209 => -0.0335148319,
    mth_source_inf_fseen > 209                                  => 0.0162242150,
    mth_source_inf_fseen = NULL                                 => 0.0005520503,
                                                                   -0.0007939086);

final_score_279_c1534 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 3.5 => -0.0611318444,
    f_srchvelocityrisktype_i > 3.5                                      => 0.0424888827,
    f_srchvelocityrisktype_i = NULL                                     => -0.0104332912,
                                                                           -0.0104332912);

final_score_279_c1535 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 121 => 0.0257350136,
    f_curraddrburglaryindex_i > 121                                       => 0.1016475575,
    f_curraddrburglaryindex_i = NULL                                      => 0.0511829687,
                                                                             0.0511829687);

final_score_279_c1533 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 150 => final_score_279_c1534,
    mth_pp_app_npa_effective_dt > 150                                         => final_score_279_c1535,
    mth_pp_app_npa_effective_dt = NULL                                        => 0.0266417917,
                                                                                 0.0266417917);

final_score_279 := map(
    NULL < (Integer)_internal_ver_match_hhid AND (Integer)_internal_ver_match_hhid <= 0.5 => final_score_279_c1532,
    (Integer)_internal_ver_match_hhid > 0.5                                               => final_score_279_c1533,
    (Integer)_internal_ver_match_hhid = NULL                                              => 0.0012545965,
                                                                                             0.0012545965);

final_score_280_c1538 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Vehicle', 'Brother', 'Child', 'Father', 'Grandfather', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Son', 'Spouse', 'Subject', 'Wife']) => 0.0017217125,
    (phone_subject_title in ['Associate By Shared Associates', 'Associate By SSN', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Grandson', 'Relative', 'Sister', 'Subject at Household'])                                                              => 0.1060370135,
    phone_subject_title = ''                                                                                                                                                                                                                                                        => 0.0205738753,
                                                                                                                                                                                                                                                                                       0.0205738753);

final_score_280_c1537 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 20560.5 => final_score_280_c1538,
    f_prevaddrmedianincome_d > 20560.5                                      => -0.0284281027,
    f_prevaddrmedianincome_d = NULL                                         => -0.0138802492,
                                                                               -0.0138802492);

final_score_280_c1540 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 14.5 => -0.0599708468,
    f_mos_inq_banko_cm_lseen_d > 14.5                                        => 0.0224546274,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => 0.0184546140,
                                                                                0.0184546140);

final_score_280_c1539 := map(
    NULL < (Integer)_phone_match_code_n AND (Integer)_phone_match_code_n <= 0.5 => -0.0006081571,
    (Integer)_phone_match_code_n > 0.5                                          => final_score_280_c1540,
    (Integer)_phone_match_code_n = NULL                                         => 0.0075446901,
                                                                                   0.0075446901);

final_score_280 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 34066 => final_score_280_c1537,
    f_prevaddrmedianincome_d > 34066                                      => final_score_280_c1539,
    f_prevaddrmedianincome_d = NULL                                       => 0.0023529359,
                                                                             0.0023529359);

final_score_281_c1545 := map(
    (pp_glb_dppa_all in ['D', 'G'])       => 0.0130588401,
    (pp_glb_dppa_all in ['', 'DG', 'GD']) => 0.1062949496,
    pp_glb_dppa_all = ''                  => 0.0572551777,
                                             0.0572551777);

final_score_281_c1544 := map(
    NULL < f_rel_ageover20_count_d AND f_rel_ageover20_count_d <= 13.5 => 0.0025744453,
    f_rel_ageover20_count_d > 13.5                                     => final_score_281_c1545,
    f_rel_ageover20_count_d = NULL                                     => 0.0236792894,
                                                                          0.0236792894);

final_score_281_c1543 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 64384 => -0.0088510069,
    f_prevaddrmedianincome_d > 64384                                      => final_score_281_c1544,
    f_prevaddrmedianincome_d = NULL                                       => -0.0008263985,
                                                                             -0.0008263985);

final_score_281_c1542 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 14.5 => -0.0476261828,
    f_prevaddrcartheftindex_i > 14.5                                       => final_score_281_c1543,
    f_prevaddrcartheftindex_i = NULL                                       => -0.0043657657,
                                                                              -0.0043657657);

final_score_281 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 168.5 => final_score_281_c1542,
    mth_pp_app_npa_last_change_dt > 168.5                                           => 0.0447830823,
    mth_pp_app_npa_last_change_dt = NULL                                            => -0.0018620503,
                                                                                       -0.0018682884);

final_score_282_c1547 := map(
    NULL < eda_max_days_interrupt AND eda_max_days_interrupt <= 1794 => 0.0063599672,
    eda_max_days_interrupt > 1794                                    => 0.0965909944,
    eda_max_days_interrupt = NULL                                    => 0.0091886383,
                                                                        0.0091886383);

final_score_282_c1549 := map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 5.5 => -0.0175313601,
    f_sourcerisktype_i > 5.5                                => -0.1157773813,
    f_sourcerisktype_i = NULL                               => -0.0407946886,
                                                               -0.0407946886);

final_score_282_c1550 := map(
    NULL < eda_days_ind_first_seen AND eda_days_ind_first_seen <= 316 => 0.0011691339,
    eda_days_ind_first_seen > 316                                     => -0.0886715432,
    eda_days_ind_first_seen = NULL                                    => -0.0030900866,
                                                                         -0.0030900866);

final_score_282_c1548 := map(
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Vehicle', 'Grandmother', 'Grandson', 'Parent', 'Relative', 'Subject at Household'])                                                                                                                                                                  => final_score_282_c1549,
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Husband', 'Mother', 'Neighbor', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Wife']) => final_score_282_c1550,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                          => -0.0091111119,
                                                                                                                                                                                                                                                                                                                                         -0.0091111119);

final_score_282 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.422209945225094 => final_score_282_c1547,
    f_add_input_mobility_index_n > 0.422209945225094                                          => final_score_282_c1548,
    f_add_input_mobility_index_n = NULL                                                       => 0.0024148493,
                                                                                                 0.0024148493);

final_score_283_c1554 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -105.5 => 0.0377896053,
    f_addrchangecrimediff_i > -105.5                                     => -0.0227008273,
    f_addrchangecrimediff_i = NULL                                       => -0.0244861696,
                                                                            -0.0194210861);

final_score_283_c1553 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Shared Associates', 'Brother', 'Father', 'Granddaughter', 'Grandmother', 'Husband', 'Mother', 'Parent', 'Sibling', 'Sister', 'Subject', 'Subject at Household', 'Wife']) => final_score_283_c1554,
    (phone_subject_title in ['Associate By Address', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Daughter', 'Grandchild', 'Grandfather', 'Grandparent', 'Grandson', 'Neighbor', 'Relative', 'Son', 'Spouse'])          => 0.0160198672,
    phone_subject_title = ''                                                                                                                                                                                                                              => -0.0084265273,
                                                                                                                                                                                                                                                             -0.0084265273);

final_score_283_c1555 := map(
    (pp_source in ['GONG', 'IBEHAVIOR', 'INTRADO', 'OTHER', 'THRIVE'])             => -0.0770264570,
    (pp_source in ['', 'CELL', 'HEADER', 'INFUTOR', 'INQUIRY', 'PCNSR', 'TARGUS']) => 0.0114250755,
    pp_source = ''                                                                 => 0.0077703073,
                                                                                      0.0077703073);

final_score_283_c1552 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 132.5 => final_score_283_c1553,
    f_curraddrcartheftindex_i > 132.5                                       => final_score_283_c1555,
    f_curraddrcartheftindex_i = NULL                                        => -0.0025427125,
                                                                               -0.0025427125);

final_score_283 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 1.5 => final_score_283_c1552,
    f_srchunvrfdaddrcount_i > 1.5                                     => 0.0723035060,
    f_srchunvrfdaddrcount_i = NULL                                    => -0.0011801869,
                                                                         -0.0011801869);

final_score_284_c1559 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 184744 => 0.0766542608,
    f_prevaddrmedianvalue_d > 184744                                     => -0.0094166526,
    f_prevaddrmedianvalue_d = NULL                                       => 0.0408845305,
                                                                            0.0408845305);

final_score_284_c1558 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 117 => 0.0037466304,
    r_pb_order_freq_d > 117                               => final_score_284_c1559,
    r_pb_order_freq_d = NULL                              => -0.0055422885,
                                                             0.0058459924);

final_score_284_c1557 := map(
    NULL < mth_pp_datelastseen AND mth_pp_datelastseen <= 16.5 => final_score_284_c1558,
    mth_pp_datelastseen > 16.5                                 => -0.0212409059,
    mth_pp_datelastseen = NULL                                 => -0.0003671862,
                                                                  -0.0022009887);

final_score_284_c1560 := map(
    NULL < mth_pp_app_npa_last_change_dt AND mth_pp_app_npa_last_change_dt <= 81.5 => 0.0809952849,
    mth_pp_app_npa_last_change_dt > 81.5                                           => -0.0068237325,
    mth_pp_app_npa_last_change_dt = NULL                                           => 0.0355426305,
                                                                                      0.0355426305);

final_score_284 := map(
    NULL < _pp_rule_ins_ver_above AND _pp_rule_ins_ver_above <= 0.5 => final_score_284_c1557,
    _pp_rule_ins_ver_above > 0.5                                    => final_score_284_c1560,
    _pp_rule_ins_ver_above = NULL                                   => -0.0007381664,
                                                                       -0.0007381664);

final_score_285_c1562 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 0.5 => 0.0216090386,
    f_srchfraudsrchcount_i > 0.5                                    => -0.0512701244,
    f_srchfraudsrchcount_i = NULL                                   => -0.0271318029,
                                                                       -0.0271318029);

final_score_285_c1565 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -6059.5 => -0.0570013724,
    f_addrchangeincomediff_d > -6059.5                                      => 0.0411996960,
    f_addrchangeincomediff_d = NULL                                         => 0.0066172600,
                                                                               0.0066172600);

final_score_285_c1564 := map(
    NULL < f_rel_homeover300_count_d AND f_rel_homeover300_count_d <= 1.5 => -0.0427536044,
    f_rel_homeover300_count_d > 1.5                                       => final_score_285_c1565,
    f_rel_homeover300_count_d = NULL                                      => -0.0230255968,
                                                                             -0.0230255968);

final_score_285_c1563 := map(
    (phone_subject_title in ['Associate', 'Associate By Business', 'Associate By Property', 'Associate By SSN', 'Grandfather', 'Grandson', 'Mother', 'Relative'])                                                                                                                                                                        => final_score_285_c1564,
    (phone_subject_title in ['Associate By Address', 'Associate By Shared Associates', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandchild', 'Granddaughter', 'Grandmother', 'Grandparent', 'Husband', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => 0.0034049218,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                             => 0.0000096971,
                                                                                                                                                                                                                                                                                                                                            0.0000096971);

final_score_285 := map(
    NULL < mth_source_ppla_lseen AND mth_source_ppla_lseen <= 20.5 => final_score_285_c1562,
    mth_source_ppla_lseen > 20.5                                   => 0.0285572856,
    mth_source_ppla_lseen = NULL                                   => final_score_285_c1563,
                                                                      -0.0004375845);

final_score_286_c1567 := map(
    NULL < (Integer)internal_verification AND (Integer)internal_verification <= 0.5 => -0.0780524874,
    (Integer)internal_verification > 0.5                                            => 0.0084285730,
    (Integer)internal_verification = NULL                                           => -0.0390651241,
                                                                                       -0.0390651241);

final_score_286_c1570 := map(
    NULL < f_rel_homeover100_count_d AND f_rel_homeover100_count_d <= 5.5 => 0.0347010725,
    f_rel_homeover100_count_d > 5.5                                       => 0.1416365563,
    f_rel_homeover100_count_d = NULL                                      => 0.0788022027,
                                                                             0.0788022027);

final_score_286_c1569 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 85.5 => -0.0253877234,
    f_fp_prevaddrburglaryindex_i > 85.5                                          => final_score_286_c1570,
    f_fp_prevaddrburglaryindex_i = NULL                                          => 0.0422616599,
                                                                                    0.0422616599);

final_score_286_c1568 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 13.5 => -0.0000853802,
    f_inq_count24_i > 13.5                             => final_score_286_c1569,
    f_inq_count24_i = NULL                             => 0.0022951248,
                                                          0.0022951248);

final_score_286 := map(
    NULL < mth_source_inf_fseen AND mth_source_inf_fseen <= 96.5 => 0.0071795443,
    mth_source_inf_fseen > 96.5                                  => final_score_286_c1567,
    mth_source_inf_fseen = NULL                                  => final_score_286_c1568,
                                                                    0.0005428714);

final_score_287_c1572 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 345.5 => -0.0003200182,
    f_prevaddrageoldest_d > 345.5                                   => 0.0461414944,
    f_prevaddrageoldest_d = NULL                                    => 0.0022593857,
                                                                       0.0022593857);

final_score_287_c1575 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 12.5 => 0.0636183901,
    f_rel_educationover12_count_d > 12.5                                           => -0.0264415509,
    f_rel_educationover12_count_d = NULL                                           => 0.0309442042,
                                                                                      0.0309442042);

final_score_287_c1574 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.448937028697326 => final_score_287_c1575,
    f_add_input_mobility_index_n > 0.448937028697326                                          => -0.0367189333,
    f_add_input_mobility_index_n = NULL                                                       => 0.0094214182,
                                                                                                 0.0094214182);

final_score_287_c1573 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Daughter', 'Father', 'Grandfather', 'Grandparent', 'Grandson', 'Mother', 'Neighbor', 'Parent', 'Spouse', 'Subject', 'Wife']) => -0.0271512864,
    (phone_subject_title in ['Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Grandchild', 'Granddaughter', 'Grandmother', 'Husband', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject at Household'])                      => final_score_287_c1574,
    phone_subject_title = ''                                                                                                                                                                                                                                    => -0.0194600988,
                                                                                                                                                                                                                                                                   -0.0194600988);

final_score_287 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 155.5 => final_score_287_c1572,
    f_prevaddrcartheftindex_i > 155.5                                       => final_score_287_c1573,
    f_prevaddrcartheftindex_i = NULL                                        => -0.0039565559,
                                                                               -0.0039565559);

final_score_288_c1580 := map(
    NULL < mth_source_md_fseen AND mth_source_md_fseen <= 18.5 => -0.0361696262,
    mth_source_md_fseen > 18.5                                 => 0.0263273337,
    mth_source_md_fseen = NULL                                 => 0.0076406585,
                                                                  0.0066127270);

final_score_288_c1579 := map(
    (pp_src in ['E1', 'EM', 'EQ', 'KW', 'LP', 'NW', 'PL', 'TN', 'VO'])                             => -0.0426666111,
    (pp_src in ['', 'CY', 'E2', 'EN', 'FA', 'FF', 'LA', 'MD', 'SL', 'UT', 'UW', 'VW', 'ZK', 'ZT']) => final_score_288_c1580,
    pp_src = ''                                                                                    => 0.0048268471,
                                                                                                      0.0048268471);

final_score_288_c1578 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 4.5 => -0.0726276663,
    f_curraddrcartheftindex_i > 4.5                                       => final_score_288_c1579,
    f_curraddrcartheftindex_i = NULL                                      => 0.0031435107,
                                                                             0.0031435107);

final_score_288_c1577 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 12.5 => 0.0301110553,
    mth_source_rel_fseen > 12.5                                  => -0.0167373683,
    mth_source_rel_fseen = NULL                                  => final_score_288_c1578,
                                                                    0.0035891296);

final_score_288 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 20496.5 => -0.0481607556,
    f_curraddrmedianincome_d > 20496.5                                      => final_score_288_c1577,
    f_curraddrmedianincome_d = NULL                                         => 0.0010516166,
                                                                               0.0010516166);

final_score_289_c1585 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.357132761148373 => 0.0005840850,
    f_add_curr_mobility_index_n > 0.357132761148373                                         => -0.0427644348,
    f_add_curr_mobility_index_n = NULL                                                      => -0.0181402888,
                                                                                               -0.0181402888);

final_score_289_c1584 := map(
    NULL < (Integer)inq_adl_lastseen_n AND (Integer)inq_adl_lastseen_n <= 35.5 => 0.0107667474,
    (Integer)inq_adl_lastseen_n > 35.5                                         => -0.0449881471,
    (Integer)inq_adl_lastseen_n = NULL                                         => final_score_289_c1585,
                                                                                  -0.0045975385);

final_score_289_c1583 := map(
    NULL < (Integer)f_util_add_input_conv_n AND (Integer)f_util_add_input_conv_n <= 0.5 => 0.0125557864,
    (Integer)f_util_add_input_conv_n > 0.5                                              => final_score_289_c1584,
    (Integer)f_util_add_input_conv_n = NULL                                             => 0.0028038421,
                                                                                           0.0028038421);

final_score_289_c1582 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Daughter', 'Grandparent', 'Grandson', 'Sister', 'Son', 'Spouse'])                                                                                                                                            => -0.0489425223,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By Shared Associates', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Subject', 'Subject at Household', 'Wife']) => final_score_289_c1583,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                               => -0.0005601288,
                                                                                                                                                                                                                                                                                                                              -0.0005601288);

final_score_289 := map(
    NULL < f_rel_incomeover25_count_d AND f_rel_incomeover25_count_d <= 40.5 => final_score_289_c1582,
    f_rel_incomeover25_count_d > 40.5                                        => 0.0608903613,
    f_rel_incomeover25_count_d = NULL                                        => 0.0004244834,
                                                                                0.0004244834);

final_score_290_c1587 := map(
    NULL < (Integer)inq_lastseen_n AND (Integer)inq_lastseen_n <= 16.5 => 0.0420782023,
    (Integer)inq_lastseen_n > 16.5                                     => -0.0346722766,
    (Integer)inq_lastseen_n = NULL                                     => 0.0602753043,
                                                                          0.0279260272);

final_score_290_c1589 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 82 => -0.0602699762,
    f_fp_prevaddrcrimeindex_i > 82                                       => 0.0242232784,
    f_fp_prevaddrcrimeindex_i = NULL                                     => -0.0092093044,
                                                                            -0.0092093044);

final_score_290_c1588 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 144.5 => final_score_290_c1589,
    f_curraddrcartheftindex_i > 144.5                                       => 0.0746546201,
    f_curraddrcartheftindex_i = NULL                                        => 0.0166591698,
                                                                               0.0166591698);

final_score_290_c1590 := map(
    NULL < f_corrssnnamecount_d AND f_corrssnnamecount_d <= 5.5 => -0.0177235724,
    f_corrssnnamecount_d > 5.5                                  => 0.0054266955,
    f_corrssnnamecount_d = NULL                                 => -0.0023249062,
                                                                   -0.0023249062);

final_score_290 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 31.5 => final_score_290_c1587,
    mth_source_utildid_fseen > 31.5                                      => final_score_290_c1588,
    mth_source_utildid_fseen = NULL                                      => final_score_290_c1590,
                                                                            -0.0000089775);

final_score_291_c1593 := map(
    NULL < f_bus_name_nover_i AND f_bus_name_nover_i <= 0.5 => -0.0915937918,
    f_bus_name_nover_i > 0.5                                => 0.0077522781,
    f_bus_name_nover_i = NULL                               => -0.0537954554,
                                                               -0.0537954554);

final_score_291_c1592 := map(
    NULL < mth_source_utildid_fseen AND mth_source_utildid_fseen <= 31.5 => 0.0003367325,
    mth_source_utildid_fseen > 31.5                                      => final_score_291_c1593,
    mth_source_utildid_fseen = NULL                                      => -0.0031035879,
                                                                            -0.0053421014);

final_score_291_c1595 := map(
    NULL < _phone_match_code_tcza AND _phone_match_code_tcza <= 2.5 => -0.0422442632,
    _phone_match_code_tcza > 2.5                                    => 0.0243663921,
    _phone_match_code_tcza = NULL                                   => 0.0071215874,
                                                                       0.0071215874);

final_score_291_c1594 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Father', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Husband', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Sister', 'Son', 'Subject', 'Subject at Household', 'Wife']) => final_score_291_c1595,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Daughter', 'Grandchild', 'Granddaughter', 'Mother', 'Spouse'])                                                                                                                                                                                                                                      => 0.0716937363,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                                                                            => 0.0126468711,
                                                                                                                                                                                                                                                                                                                                                                           0.0126468711);

final_score_291 := map(
    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 163.5 => final_score_291_c1592,
    f_fp_prevaddrcrimeindex_i > 163.5                                       => final_score_291_c1594,
    f_fp_prevaddrcrimeindex_i = NULL                                        => -0.0014373628,
                                                                               -0.0014373628);

final_score_292_c1600 := map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 3.5 => -0.0386258058,
    f_sourcerisktype_i > 3.5                                => 0.0827275838,
    f_sourcerisktype_i = NULL                               => 0.0287221486,
                                                               0.0287221486);

final_score_292_c1599 := map(
    NULL < (Integer)inq_lastseen_n AND (Integer)inq_lastseen_n <= 43.5 => 0.0247119001,
    (Integer)inq_lastseen_n > 43.5                                     => 0.1160857398,
    (Integer)inq_lastseen_n = NULL                                     => final_score_292_c1600,
                                                                          0.0386505539);

final_score_292_c1598 := map(
    NULL < eda_days_ph_first_seen AND eda_days_ph_first_seen <= 4633.5 => 0.0062380615,
    eda_days_ph_first_seen > 4633.5                                    => final_score_292_c1599,
    eda_days_ph_first_seen = NULL                                      => 0.0120190471,
                                                                          0.0120190471);

final_score_292_c1597 := map(
    (phone_subject_title in ['Brother', 'Child', 'Daughter', 'Father', 'Granddaughter', 'Grandparent', 'Grandson', 'Neighbor', 'Sibling', 'Son', 'Subject at Household', 'Wife'])                                                                                                                                        => -0.0155616388,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Grandchild', 'Grandfather', 'Grandmother', 'Husband', 'Mother', 'Parent', 'Relative', 'Sister', 'Spouse', 'Subject']) => final_score_292_c1598,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                             => 0.0041925772,
                                                                                                                                                                                                                                                                                                                            0.0041925772);

final_score_292 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 18.5 => final_score_292_c1597,
    f_rel_educationover12_count_d > 18.5                                           => -0.0185823342,
    f_rel_educationover12_count_d = NULL                                           => 0.0011408240,
                                                                                      0.0011408240);

final_score_293_c1605 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 81 => 0.0558914584,
    f_curraddrburglaryindex_i > 81                                       => -0.0241561453,
    f_curraddrburglaryindex_i = NULL                                     => 0.0056183568,
                                                                            0.0056183568);

final_score_293_c1604 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 193.5 => final_score_293_c1605,
    r_pb_order_freq_d > 193.5                               => 0.0954808440,
    r_pb_order_freq_d = NULL                                => 0.0306440557,
                                                               0.0243565768);

final_score_293_c1603 := map(
    NULL < r_mos_since_paw_fseen_d AND r_mos_since_paw_fseen_d <= 117.5 => final_score_293_c1604,
    r_mos_since_paw_fseen_d > 117.5                                     => -0.0651391950,
    r_mos_since_paw_fseen_d = NULL                                      => 0.0166444010,
                                                                           0.0166444010);

final_score_293_c1602 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By SSN', 'Brother', 'Father', 'Grandfather', 'Grandmother', 'Grandson', 'Neighbor', 'Parent', 'Relative', 'Subject', 'Subject at Household', 'Wife'])              => -0.0049818690,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By Shared Associates', 'Associate By Vehicle', 'Child', 'Daughter', 'Grandchild', 'Granddaughter', 'Grandparent', 'Husband', 'Mother', 'Sibling', 'Sister', 'Son', 'Spouse']) => final_score_293_c1603,
    phone_subject_title = ''                                                                                                                                                                                                                                => -0.0007566083,
                                                                                                                                                                                                                                                               -0.0007566083);

final_score_293 := map(
    NULL < f_divssnidmsrcurelcount_i AND f_divssnidmsrcurelcount_i <= 2.5 => final_score_293_c1602,
    f_divssnidmsrcurelcount_i > 2.5                                       => -0.0752388482,
    f_divssnidmsrcurelcount_i = NULL                                      => -0.0018265699,
                                                                             -0.0018265699);

final_score_294_c1610 := map(
    NULL < f_inq_ssns_per_addr_i AND f_inq_ssns_per_addr_i <= 3.5 => 0.0359137387,
    f_inq_ssns_per_addr_i > 3.5                                   => -0.0373962848,
    f_inq_ssns_per_addr_i = NULL                                  => 0.0304020736,
                                                                     0.0304020736);

final_score_294_c1609 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 133 => 0.0018025335,
    f_curraddrburglaryindex_i > 133                                       => final_score_294_c1610,
    f_curraddrburglaryindex_i = NULL                                      => 0.0122484895,
                                                                             0.0122484895);

final_score_294_c1608 := map(
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Business', 'Daughter', 'Grandson', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Sibling', 'Sister', 'Son'])                                                                                                                      => -0.0080382254,
    (phone_subject_title in ['Associate By Property', 'Associate By Shared Associates', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Relative', 'Spouse', 'Subject', 'Subject at Household', 'Wife']) => final_score_294_c1609,
    phone_subject_title = ''                                                                                                                                                                                                                                                                                    => 0.0041202121,
                                                                                                                                                                                                                                                                                                                   0.0041202121);

final_score_294_c1607 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 24.5 => final_score_294_c1608,
    f_inq_count_i > 24.5                           => -0.0253702506,
    f_inq_count_i = NULL                           => 0.0007597683,
                                                      0.0007597683);

final_score_294 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 19.5 => final_score_294_c1607,
    f_rel_incomeover50_count_d > 19.5                                        => -0.0454909319,
    f_rel_incomeover50_count_d = NULL                                        => -0.0009585417,
                                                                                -0.0009585417);

final_score_295_c1612 := map(
    NULL < f_add_input_mobility_index_n AND f_add_input_mobility_index_n <= 0.367998690770517 => 0.0731433799,
    f_add_input_mobility_index_n > 0.367998690770517                                          => 0.0121428930,
    f_add_input_mobility_index_n = NULL                                                       => 0.0406097869,
                                                                                                 0.0406097869);

final_score_295_c1615 := map(
    NULL < mth_source_ppdid_fseen AND mth_source_ppdid_fseen <= 12.5 => -0.0456413060,
    mth_source_ppdid_fseen > 12.5                                    => 0.0064090464,
    mth_source_ppdid_fseen = NULL                                    => -0.0023133856,
                                                                        -0.0036574107);

final_score_295_c1614 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 50940.5 => final_score_295_c1615,
    f_curraddrmedianincome_d > 50940.5                                      => 0.0203775949,
    f_curraddrmedianincome_d = NULL                                         => 0.0087555640,
                                                                               0.0087555640);

final_score_295_c1613 := map(
    NULL < eda_days_in_service AND eda_days_in_service <= 302.5 => final_score_295_c1614,
    eda_days_in_service > 302.5                                 => -0.0117439282,
    eda_days_in_service = NULL                                  => 0.0001222415,
                                                                   0.0001222415);

final_score_295 := map(
    NULL < mth_source_rel_fseen AND mth_source_rel_fseen <= 12.5 => final_score_295_c1612,
    mth_source_rel_fseen > 12.5                                  => -0.0086920298,
    mth_source_rel_fseen = NULL                                  => final_score_295_c1613,
                                                                    0.0011284070);

final_score_296_c1617 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 102 => 0.0086945235,
    f_prevaddrageoldest_d > 102                                   => -0.0850561302,
    f_prevaddrageoldest_d = NULL                                  => -0.0342540744,
                                                                     -0.0342540744);

final_score_296_c1620 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Property', 'Associate By Shared Associates', 'Daughter', 'Grandmother', 'Neighbor', 'Relative', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject', 'Subject at Household']) => 0.0295688707,
    (phone_subject_title in ['Associate', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Child', 'Father', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandparent', 'Grandson', 'Husband', 'Mother', 'Parent', 'Wife'])                                  => 0.0835021425,
    phone_subject_title = ''                                                                                                                                                                                                                                          => 0.0433675879,
                                                                                                                                                                                                                                                                         0.0433675879);

final_score_296_c1619 := map(
    NULL < eda_days_ph_first_seen AND eda_days_ph_first_seen <= 4972.5 => final_score_296_c1620,
    eda_days_ph_first_seen > 4972.5                                    => -0.0503381059,
    eda_days_ph_first_seen = NULL                                      => 0.0214364681,
                                                                          0.0214364681);

final_score_296_c1618 := map(
    NULL < f_add_curr_mobility_index_n AND f_add_curr_mobility_index_n <= 0.472398030942335 => -0.0070556075,
    f_add_curr_mobility_index_n > 0.472398030942335                                         => final_score_296_c1619,
    f_add_curr_mobility_index_n = NULL                                                      => -0.0012092326,
                                                                                               -0.0012092326);

final_score_296 := map(
    NULL < mth_pp_app_npa_effective_dt AND mth_pp_app_npa_effective_dt <= 72.5 => final_score_296_c1617,
    mth_pp_app_npa_effective_dt > 72.5                                         => 0.0028791597,
    mth_pp_app_npa_effective_dt = NULL                                         => final_score_296_c1618,
                                                                                  -0.0011037087);

final_score_297_c1623 := map(
    (pp_source in ['', 'IBEHAVIOR', 'INQUIRY', 'INTRADO', 'OTHER', 'PCNSR', 'THRIVE']) => 0.0091159349,
    (pp_source in ['CELL', 'GONG', 'HEADER', 'INFUTOR', 'TARGUS'])                     => 0.0734639162,
    pp_source = ''                                                                     => 0.0419406355,
                                                                                          0.0419406355);

final_score_297_c1625 := map(
    (phone_subject_title in ['Associate By Business', 'Associate By Shared Associates', 'Child', 'Daughter', 'Father', 'Husband', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Subject at Household', 'Wife'])                                                                              => 0.0167774938,
    (phone_subject_title in ['Associate', 'Associate By Address', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Brother', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandmother', 'Grandparent', 'Grandson', 'Sibling', 'Sister', 'Son', 'Spouse', 'Subject']) => 0.1158521717,
    phone_subject_title = ''                                                                                                                                                                                                                                                                => 0.0687583786,
                                                                                                                                                                                                                                                                                               0.0687583786);

final_score_297_c1624 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 144.5 => -0.0146835372,
    f_curraddrcartheftindex_i > 144.5                                       => final_score_297_c1625,
    f_curraddrcartheftindex_i = NULL                                        => 0.0060375621,
                                                                               0.0060375621);

final_score_297_c1622 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 7.5 => final_score_297_c1623,
    mth_pp_first_build_date > 7.5                                     => -0.0277697062,
    mth_pp_first_build_date = NULL                                    => final_score_297_c1624,
                                                                         0.0082514376);

final_score_297 := map(
    NULL < f_rel_homeover500_count_d AND f_rel_homeover500_count_d <= 0.5 => -0.0047842600,
    f_rel_homeover500_count_d > 0.5                                       => final_score_297_c1622,
    f_rel_homeover500_count_d = NULL                                      => -0.0020255878,
                                                                             -0.0020255878);

final_score_298_c1628 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 7.5 => -0.0765982101,
    f_rel_under500miles_cnt_d > 7.5                                       => -0.0029311514,
    f_rel_under500miles_cnt_d = NULL                                      => -0.0301559340,
                                                                             -0.0301559340);

final_score_298_c1629 := map(
    NULL < mth_source_ppla_lseen AND mth_source_ppla_lseen <= 40.5 => 0.0080963974,
    mth_source_ppla_lseen > 40.5                                   => -0.0624432084,
    mth_source_ppla_lseen = NULL                                   => 0.0032887506,
                                                                      0.0026196004);

final_score_298_c1627 := map(
    NULL < mth_source_sx_fseen AND mth_source_sx_fseen <= 51.5 => final_score_298_c1628,
    mth_source_sx_fseen > 51.5                                 => 0.0349475948,
    mth_source_sx_fseen = NULL                                 => final_score_298_c1629,
                                                                  0.0021031929);

final_score_298_c1630 := map(
    NULL < _pp_rule_iq_rpc AND _pp_rule_iq_rpc <= 0.5 => 0.0800386063,
    _pp_rule_iq_rpc > 0.5                             => 0.0056538582,
    _pp_rule_iq_rpc = NULL                            => 0.0417105873,
                                                         0.0417105873);

final_score_298 := map(
    NULL < (Integer)_inq_adl_ph_industry_flag AND (Integer)_inq_adl_ph_industry_flag <= 0.5 => final_score_298_c1627,
    (Integer)_inq_adl_ph_industry_flag > 0.5                                                => final_score_298_c1630,
    (Integer)_inq_adl_ph_industry_flag = NULL                                               => 0.0033881282,
                                                                                               0.0033881282);

final_score_299_c1633 := map(
    NULL < mth_pp_datevendorlastseen AND mth_pp_datevendorlastseen <= 21.5 => -0.0082215142,
    mth_pp_datevendorlastseen > 21.5                                       => 0.0471655713,
    mth_pp_datevendorlastseen = NULL                                       => -0.0051588166,
                                                                              -0.0045280543);

final_score_299_c1635 := map(
    (phone_subject_title in ['Associate By Address', 'Associate By Business', 'Associate By Shared Associates', 'Brother', 'Daughter', 'Father', 'Grandmother', 'Grandparent', 'Mother', 'Neighbor', 'Parent', 'Relative', 'Sibling', 'Son', 'Wife']) => -0.0299955538,
    (phone_subject_title in ['Associate', 'Associate By Property', 'Associate By SSN', 'Associate By Vehicle', 'Child', 'Grandchild', 'Granddaughter', 'Grandfather', 'Grandson', 'Husband', 'Sister', 'Spouse', 'Subject', 'Subject at Household'])  => 0.0823362107,
    phone_subject_title = ''                                                                                                                                                                                                                          => 0.0218251169,
                                                                                                                                                                                                                                                         0.0218251169);

final_score_299_c1634 := map(
    NULL < mth_pp_first_build_date AND mth_pp_first_build_date <= 2.5 => 0.0682353312,
    mth_pp_first_build_date > 2.5                                     => -0.0208226612,
    mth_pp_first_build_date = NULL                                    => final_score_299_c1635,
                                                                         0.0132684653);

final_score_299_c1632 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 8.5 => final_score_299_c1633,
    f_inq_count24_i > 8.5                             => final_score_299_c1634,
    f_inq_count24_i = NULL                            => -0.0026827567,
                                                         -0.0026827567);

final_score_299 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 19690 => 0.0717225479,
    f_curraddrmedianvalue_d > 19690                                     => final_score_299_c1632,
    f_curraddrmedianvalue_d = NULL                                      => -0.0009689007,
                                                                           -0.0009689007);

final_score_300_c1638 := map(
    NULL < f_vardobcount_i AND f_vardobcount_i <= 2.5 => 0.0004844901,
    f_vardobcount_i > 2.5                             => 0.0649046004,
    f_vardobcount_i = NULL                            => 0.0063767585,
                                                         0.0063767585);

final_score_300_c1637 := map(
    NULL < mth_eda_dt_first_seen AND mth_eda_dt_first_seen <= 2.5 => 0.0743792761,
    mth_eda_dt_first_seen > 2.5                                   => 0.0052236168,
    mth_eda_dt_first_seen = NULL                                  => final_score_300_c1638,
                                                                     0.0072192735);

final_score_300_c1640 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 116 => -0.1134151591,
    f_prevaddrcartheftindex_i > 116                                       => -0.0220156974,
    f_prevaddrcartheftindex_i = NULL                                      => -0.0468525076,
                                                                             -0.0468525076);

final_score_300_c1639 := map(
    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 164.5 => -0.0073870815,
    f_curraddrcartheftindex_i > 164.5                                       => final_score_300_c1640,
    f_curraddrcartheftindex_i = NULL                                        => -0.0146523526,
                                                                               -0.0146523526);

final_score_300 := map(
    NULL < pk_phone_match_level AND pk_phone_match_level <= 3.5 => final_score_300_c1637,
    pk_phone_match_level > 3.5                                  => final_score_300_c1639,
    pk_phone_match_level = NULL                                 => 0.0018055315,
                                                                   0.0018055315);
//--------------------------------------------------------------------------------------------------
//  NOTE:  This is the end of the tree code.  
//--------------------------------------------------------------------------------------------------

final_score := final_score_0 +
    final_score_1 + final_score_2 + final_score_3 + final_score_4 + final_score_5 +
    final_score_6 + final_score_7 + final_score_8 + final_score_9 + final_score_10 +
    final_score_11 + final_score_12 + final_score_13 + final_score_14 + final_score_15 +
    final_score_16 + final_score_17 + final_score_18 + final_score_19 + final_score_20 +
    final_score_21 + final_score_22 + final_score_23 + final_score_24 + final_score_25 +
    final_score_26 + final_score_27 + final_score_28 + final_score_29 + final_score_30 +
    final_score_31 + final_score_32 + final_score_33 + final_score_34 + final_score_35 +
    final_score_36 + final_score_37 + final_score_38 + final_score_39 + final_score_40 +
    final_score_41 + final_score_42 + final_score_43 + final_score_44 + final_score_45 +
    final_score_46 + final_score_47 + final_score_48 + final_score_49 + final_score_50 +
    final_score_51 + final_score_52 + final_score_53 + final_score_54 + final_score_55 +
    final_score_56 + final_score_57 + final_score_58 + final_score_59 + final_score_60 +
    final_score_61 + final_score_62 + final_score_63 + final_score_64 + final_score_65 +
    final_score_66 + final_score_67 + final_score_68 + final_score_69 + final_score_70 +
    final_score_71 + final_score_72 + final_score_73 + final_score_74 + final_score_75 +
    final_score_76 + final_score_77 + final_score_78 + final_score_79 + final_score_80 +
    final_score_81 + final_score_82 + final_score_83 + final_score_84 + final_score_85 +
    final_score_86 + final_score_87 + final_score_88 + final_score_89 + final_score_90 +
    final_score_91 + final_score_92 + final_score_93 + final_score_94 + final_score_95 +
    final_score_96 + final_score_97 + final_score_98 + final_score_99 + final_score_100 +
    final_score_101 + final_score_102 + final_score_103 + final_score_104 + final_score_105 +
    final_score_106 + final_score_107 + final_score_108 + final_score_109 + final_score_110 +
    final_score_111 + final_score_112 + final_score_113 + final_score_114 + final_score_115 +
    final_score_116 + final_score_117 + final_score_118 + final_score_119 + final_score_120 +
    final_score_121 + final_score_122 + final_score_123 + final_score_124 + final_score_125 +
    final_score_126 + final_score_127 + final_score_128 + final_score_129 + final_score_130 +
    final_score_131 + final_score_132 + final_score_133 + final_score_134 + final_score_135 +
    final_score_136 + final_score_137 + final_score_138 + final_score_139 + final_score_140 +
    final_score_141 + final_score_142 + final_score_143 + final_score_144 + final_score_145 +
    final_score_146 + final_score_147 + final_score_148 + final_score_149 + final_score_150 +
    final_score_151 + final_score_152 + final_score_153 + final_score_154 + final_score_155 +
    final_score_156 + final_score_157 + final_score_158 + final_score_159 + final_score_160 +
    final_score_161 + final_score_162 + final_score_163 + final_score_164 + final_score_165 +
    final_score_166 + final_score_167 + final_score_168 + final_score_169 + final_score_170 +
    final_score_171 + final_score_172 + final_score_173 + final_score_174 + final_score_175 +
    final_score_176 + final_score_177 + final_score_178 + final_score_179 + final_score_180 +
    final_score_181 + final_score_182 + final_score_183 + final_score_184 + final_score_185 +
    final_score_186 + final_score_187 + final_score_188 + final_score_189 + final_score_190 +
    final_score_191 + final_score_192 + final_score_193 + final_score_194 + final_score_195 +
    final_score_196 + final_score_197 + final_score_198 + final_score_199 + final_score_200 +
    final_score_201 + final_score_202 + final_score_203 + final_score_204 + final_score_205 +
    final_score_206 + final_score_207 + final_score_208 + final_score_209 + final_score_210 +
    final_score_211 + final_score_212 + final_score_213 + final_score_214 + final_score_215 +
    final_score_216 + final_score_217 + final_score_218 + final_score_219 + final_score_220 +
    final_score_221 + final_score_222 + final_score_223 + final_score_224 + final_score_225 +
    final_score_226 + final_score_227 + final_score_228 + final_score_229 + final_score_230 +
    final_score_231 + final_score_232 + final_score_233 + final_score_234 + final_score_235 +
    final_score_236 + final_score_237 + final_score_238 + final_score_239 + final_score_240 +
    final_score_241 + final_score_242 + final_score_243 + final_score_244 + final_score_245 +
    final_score_246 + final_score_247 + final_score_248 + final_score_249 + final_score_250 +
    final_score_251 + final_score_252 + final_score_253 + final_score_254 + final_score_255 +
    final_score_256 + final_score_257 + final_score_258 + final_score_259 + final_score_260 +
    final_score_261 + final_score_262 + final_score_263 + final_score_264 + final_score_265 +
    final_score_266 + final_score_267 + final_score_268 + final_score_269 + final_score_270 +
    final_score_271 + final_score_272 + final_score_273 + final_score_274 + final_score_275 +
    final_score_276 + final_score_277 + final_score_278 + final_score_279 + final_score_280 +
    final_score_281 + final_score_282 + final_score_283 + final_score_284 + final_score_285 +
    final_score_286 + final_score_287 + final_score_288 + final_score_289 + final_score_290 +
    final_score_291 + final_score_292 + final_score_293 + final_score_294 + final_score_295 +
    final_score_296 + final_score_297 + final_score_298 + final_score_299 + final_score_300;

points := 70;

odds := 1 / 20;

base := 250;

phat := exp(final_score) / (1 + exp(final_score));

wf8_1 := round(points * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);

wf8 := max(min(if(wf8_1 = NULL, -NULL, wf8_1), 999), 0);


//Intermediate variables
	#if(PHONE_DEBUG)
			
			self.sysdate                          := sysdate;
			self.source_list											:= source_list;
			self.source_list_last_seen						:= source_list_last_seen;
			self.source_list_first_seen						:= source_list_first_seen;
			self.phone_pos_cr                     := phone_pos_cr;
			self.phone_pos_edaca                  := phone_pos_edaca;
			self.phone_pos_edadid                 := phone_pos_edadid;
			self.phone_pos_edafa                  := phone_pos_edafa;
			self.phone_pos_edafla                 := phone_pos_edafla;
			self.phone_pos_edahistory             := phone_pos_edahistory;
			self.phone_pos_edala                  := phone_pos_edala;
			self.phone_pos_edalfa                 := phone_pos_edalfa;
			self.phone_pos_exp                    := phone_pos_exp;
			self.phone_pos_eqp                    := phone_pos_eqp;
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
			self.source_cr_fseen                  := source_cr_fseen;
			self.source_edaca_lseen               := source_edaca_lseen;
			self.source_edaca_fseen               := source_edaca_fseen;
			self.source_edadid_lseen              := source_edadid_lseen;
			self.source_edadid_fseen              := source_edadid_fseen;
			self.source_edahistory_lseen          := source_edahistory_lseen;
			self.source_edahistory_fseen          := source_edahistory_fseen;
			self.source_inf_lseen                 := source_inf_lseen;
			self.source_inf_fseen                 := source_inf_fseen;
			self.source_md_fseen                  := source_md_fseen;
			self.source_paw_lseen                 := source_paw_lseen;
			self.source_ppca_lseen                := source_ppca_lseen;
			self.source_ppca_fseen                := source_ppca_fseen;
			self.source_ppdid_lseen               := source_ppdid_lseen;
			self.source_ppdid_fseen               := source_ppdid_fseen;
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
			self.source_cr_fseen2                 := source_cr_fseen2;
			self.yr_source_cr_fseen               := yr_source_cr_fseen;
			self.mth_source_cr_fseen              := mth_source_cr_fseen;
			self.source_edaca_lseen2              := source_edaca_lseen2;
			self.yr_source_edaca_lseen            := yr_source_edaca_lseen;
			self.mth_source_edaca_lseen           := mth_source_edaca_lseen;
			self.source_edaca_fseen2              := source_edaca_fseen2;
			self.yr_source_edaca_fseen            := yr_source_edaca_fseen;
			self.mth_source_edaca_fseen           := mth_source_edaca_fseen;
			self.source_edadid_lseen2             := source_edadid_lseen2;
			self.yr_source_edadid_lseen           := yr_source_edadid_lseen;
			self.mth_source_edadid_lseen          := mth_source_edadid_lseen;
			self.source_edadid_fseen2             := source_edadid_fseen2;
			self.yr_source_edadid_fseen           := yr_source_edadid_fseen;
			self.mth_source_edadid_fseen          := mth_source_edadid_fseen;
			self.source_edahistory_lseen2         := source_edahistory_lseen2;
			self.yr_source_edahistory_lseen       := yr_source_edahistory_lseen;
			self.mth_source_edahistory_lseen      := mth_source_edahistory_lseen;
			self.source_edahistory_fseen2         := source_edahistory_fseen2;
			self.yr_source_edahistory_fseen       := yr_source_edahistory_fseen;
			self.mth_source_edahistory_fseen      := mth_source_edahistory_fseen;
			self.source_inf_lseen2                := source_inf_lseen2;
			self.yr_source_inf_lseen              := yr_source_inf_lseen;
			self.mth_source_inf_lseen             := mth_source_inf_lseen;
			self.source_inf_fseen2                := source_inf_fseen2;
			self.yr_source_inf_fseen              := yr_source_inf_fseen;
			self.mth_source_inf_fseen             := mth_source_inf_fseen;
			self.source_md_fseen2                 := source_md_fseen2;
			self.yr_source_md_fseen               := yr_source_md_fseen;
			self.mth_source_md_fseen              := mth_source_md_fseen;
			self.source_paw_lseen2                := source_paw_lseen2;
			self.yr_source_paw_lseen              := yr_source_paw_lseen;
			self.mth_source_paw_lseen             := mth_source_paw_lseen;
			self.source_ppca_lseen2               := source_ppca_lseen2;
			self.yr_source_ppca_lseen             := yr_source_ppca_lseen;
			self.mth_source_ppca_lseen            := mth_source_ppca_lseen;
			self.source_ppca_fseen2               := source_ppca_fseen2;
			self.yr_source_ppca_fseen             := yr_source_ppca_fseen;
			self.mth_source_ppca_fseen            := mth_source_ppca_fseen;
			self.source_ppdid_lseen2              := source_ppdid_lseen2;
			self.yr_source_ppdid_lseen            := yr_source_ppdid_lseen;
			self.mth_source_ppdid_lseen           := mth_source_ppdid_lseen;
			self.source_ppdid_fseen2              := source_ppdid_fseen2;
			self.yr_source_ppdid_fseen            := yr_source_ppdid_fseen;
			self.mth_source_ppdid_fseen           := mth_source_ppdid_fseen;
			self.source_ppfla_lseen2              := source_ppfla_lseen2;
			self.yr_source_ppfla_lseen            := yr_source_ppfla_lseen;
			self.mth_source_ppfla_lseen           := mth_source_ppfla_lseen;
			self.source_ppfla_fseen2              := source_ppfla_fseen2;
			self.yr_source_ppfla_fseen            := yr_source_ppfla_fseen;
			self.mth_source_ppfla_fseen           := mth_source_ppfla_fseen;
			self.source_ppla_lseen2               := source_ppla_lseen2;
			self.yr_source_ppla_lseen             := yr_source_ppla_lseen;
			self.mth_source_ppla_lseen            := mth_source_ppla_lseen;
			self.source_ppla_fseen2               := source_ppla_fseen2;
			self.yr_source_ppla_fseen             := yr_source_ppla_fseen;
			self.mth_source_ppla_fseen            := mth_source_ppla_fseen;
			self.source_ppth_lseen2               := source_ppth_lseen2;
			self.yr_source_ppth_lseen             := yr_source_ppth_lseen;
			self.mth_source_ppth_lseen            := mth_source_ppth_lseen;
			self.source_ppth_fseen2               := source_ppth_fseen2;
			self.yr_source_ppth_fseen             := yr_source_ppth_fseen;
			self.mth_source_ppth_fseen            := mth_source_ppth_fseen;
			self.source_rel_fseen2                := source_rel_fseen2;
			self.yr_source_rel_fseen              := yr_source_rel_fseen;
			self.mth_source_rel_fseen             := mth_source_rel_fseen;
			self.source_rm_fseen2                 := source_rm_fseen2;
			self.yr_source_rm_fseen               := yr_source_rm_fseen;
			self.mth_source_rm_fseen              := mth_source_rm_fseen;
			self.source_sp_lseen2                 := source_sp_lseen2;
			self.yr_source_sp_lseen               := yr_source_sp_lseen;
			self.mth_source_sp_lseen              := mth_source_sp_lseen;
			self.source_sp_fseen2                 := source_sp_fseen2;
			self.yr_source_sp_fseen               := yr_source_sp_fseen;
			self.mth_source_sp_fseen              := mth_source_sp_fseen;
			self.source_sx_fseen2                 := source_sx_fseen2;
			self.yr_source_sx_fseen               := yr_source_sx_fseen;
			self.mth_source_sx_fseen              := mth_source_sx_fseen;
			self.source_utildid_fseen2            := source_utildid_fseen2;
			self.yr_source_utildid_fseen          := yr_source_utildid_fseen;
			self.mth_source_utildid_fseen         := mth_source_utildid_fseen;
			self.eda_dt_first_seen2               := eda_dt_first_seen2;
			self.yr_eda_dt_first_seen             := yr_eda_dt_first_seen;
			self.mth_eda_dt_first_seen            := mth_eda_dt_first_seen;
			self.eda_dt_last_seen2                := eda_dt_last_seen2;
			self.yr_eda_dt_last_seen              := yr_eda_dt_last_seen;
			self.mth_eda_dt_last_seen             := mth_eda_dt_last_seen;
			self.exp_last_update2                 := exp_last_update2;
			self.yr_exp_last_update               := yr_exp_last_update;
			self.mth_exp_last_update              := mth_exp_last_update;
			self.internal_ver_first_seen2         := internal_ver_first_seen2;
			self.yr_internal_ver_first_seen       := yr_internal_ver_first_seen;
			self.mth_internal_ver_first_seen      := mth_internal_ver_first_seen;
			self.phone_fb_rp_date2                := phone_fb_rp_date2;
			self.yr_phone_fb_rp_date              := yr_phone_fb_rp_date;
			self.mth_phone_fb_rp_date             := mth_phone_fb_rp_date;
			self.pp_datefirstseen2                := pp_datefirstseen2;
			self.yr_pp_datefirstseen              := yr_pp_datefirstseen;
			self.mth_pp_datefirstseen             := mth_pp_datefirstseen;
			self.pp_datelastseen2                 := pp_datelastseen2;
			self.yr_pp_datelastseen               := yr_pp_datelastseen;
			self.mth_pp_datelastseen              := mth_pp_datelastseen;
			self.pp_datevendorfirstseen2          := pp_datevendorfirstseen2;
			self.yr_pp_datevendorfirstseen        := yr_pp_datevendorfirstseen;
			self.mth_pp_datevendorfirstseen       := mth_pp_datevendorfirstseen;
			self.pp_datevendorlastseen2           := pp_datevendorlastseen2;
			self.yr_pp_datevendorlastseen         := yr_pp_datevendorlastseen;
			self.mth_pp_datevendorlastseen        := mth_pp_datevendorlastseen;
			self.pp_date_nonglb_lastseen2         := pp_date_nonglb_lastseen2;
			self.yr_pp_date_nonglb_lastseen       := yr_pp_date_nonglb_lastseen;
			self.mth_pp_date_nonglb_lastseen      := mth_pp_date_nonglb_lastseen;
			self.pp_orig_lastseen2                := pp_orig_lastseen2;
			self.yr_pp_orig_lastseen              := yr_pp_orig_lastseen;
			self.mth_pp_orig_lastseen             := mth_pp_orig_lastseen;
			self.pp_app_npa_effective_dt2         := pp_app_npa_effective_dt2;
			self.yr_pp_app_npa_effective_dt       := yr_pp_app_npa_effective_dt;
			self.mth_pp_app_npa_effective_dt      := mth_pp_app_npa_effective_dt;
			self.pp_app_npa_last_change_dt2       := pp_app_npa_last_change_dt2;
			self.yr_pp_app_npa_last_change_dt     := yr_pp_app_npa_last_change_dt;
			self.mth_pp_app_npa_last_change_dt    := mth_pp_app_npa_last_change_dt;
			self.pp_eda_hist_ph_dt2               := pp_eda_hist_ph_dt2;
			self.yr_pp_eda_hist_ph_dt             := yr_pp_eda_hist_ph_dt;
			self.mth_pp_eda_hist_ph_dt            := mth_pp_eda_hist_ph_dt;
			self.pp_eda_hist_did_dt2              := pp_eda_hist_did_dt2;
			self.yr_pp_eda_hist_did_dt            := yr_pp_eda_hist_did_dt;
			self.mth_pp_eda_hist_did_dt           := mth_pp_eda_hist_did_dt;
			self.pp_eda_hist_nm_addr_dt2          := pp_eda_hist_nm_addr_dt2;
			self.yr_pp_eda_hist_nm_addr_dt        := yr_pp_eda_hist_nm_addr_dt;
			self.mth_pp_eda_hist_nm_addr_dt       := mth_pp_eda_hist_nm_addr_dt;
			self.pp_first_build_date2             := pp_first_build_date2;
			self.yr_pp_first_build_date           := yr_pp_first_build_date;
			self.mth_pp_first_build_date          := mth_pp_first_build_date;
			self._phone_match_code_a              := _phone_match_code_a;
			self._phone_match_code_c              := _phone_match_code_c;
			self._phone_match_code_d              := _phone_match_code_d;
			self._phone_match_code_l              := _phone_match_code_l;
			self._phone_match_code_n              := _phone_match_code_n;
			self._phone_match_code_s              := _phone_match_code_s;
			self._phone_match_code_t              := _phone_match_code_t;
			self._phone_match_code_z              := _phone_match_code_z;
			self._pp_rule_disconnected_eda        := _pp_rule_disconnected_eda;
			self._pp_rule_high_vend_conf          := _pp_rule_high_vend_conf;
			self._pp_rule_cellphone_latest        := _pp_rule_cellphone_latest;
			self._pp_rule_med_vend_conf_cell      := _pp_rule_med_vend_conf_cell;
			self._pp_rule_gong_disc               := _pp_rule_gong_disc;
			self._pp_rule_consort_disc            := _pp_rule_consort_disc;
			self._pp_rule_iq_rpc                  := _pp_rule_iq_rpc;
			self._pp_rule_ins_ver_above           := _pp_rule_ins_ver_above;
			self._pp_rule_f1_ver_above            := _pp_rule_f1_ver_above;
			self._pp_rule_30                      := _pp_rule_30;
			self._pp_src_all_uw                   := _pp_src_all_uw;
			self._pp_src_all_ib                   := _pp_src_all_ib;
			self._pp_app_nonpub_targ_lap          := _pp_app_nonpub_targ_lap;
			self._pp_app_ported_match_7           := _pp_app_ported_match_7;
			self._eda_hhid_flag                   := _eda_hhid_flag;
			self.inq_firstseen_n                  := inq_firstseen_n;
			self.inq_lastseen_n                   := inq_lastseen_n;
			self.inq_adl_firstseen_n              := inq_adl_firstseen_n;
			self.inq_adl_lastseen_n               := inq_adl_lastseen_n;
			self._internal_ver_match_lexid        := _internal_ver_match_lexid;
			self._internal_ver_match_spouse       := _internal_ver_match_spouse;
			self._internal_ver_match_hhid         := _internal_ver_match_hhid;
			self._internal_ver_match_level        := _internal_ver_match_level;
			self._inq_adl_ph_industry_flag        := _inq_adl_ph_industry_flag;
			self._pp_app_nxx_type                 := _pp_app_nxx_type;
			self._phone_disconnected              := _phone_disconnected;
			self._phone_zip_match                 := _phone_zip_match;
			self._phone_timezone_match            := _phone_timezone_match;
			self._phone_fb_rp_result              := _phone_fb_rp_result;
			self._pp_app_fb_ph_disc               := _pp_app_fb_ph_disc;
			self._pp_app_fb_ph7_did_disc          := _pp_app_fb_ph7_did_disc;
			self._pp_app_fb_ph7_nm_addr_disc      := _pp_app_fb_ph7_nm_addr_disc;
			self._phone_fb_result_disc            := _phone_fb_result_disc;
			self._phone_fb_rp_result_disc         := _phone_fb_rp_result_disc;
			self._pp_rule_disc_flag               := _pp_rule_disc_flag;
			self._pp_app_fb_disc_flag             := _pp_app_fb_disc_flag;
			self._phone_fb_disc_flag              := _phone_fb_disc_flag;
			self.pk_disconnect_flag               := pk_disconnect_flag;
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
			self._pp_origlistingtype_res          := _pp_origlistingtype_res;
			self.pk_exp_hit                       := pk_exp_hit;
			self.segment                          := segment;
			self.util_add_input_type_list         := util_add_input_type_list;
			self.add_input_occupants_1yr          := add_input_occupants_1yr;
			self.add_input_turnover_1yr_in        := add_input_turnover_1yr_in;
			self.add_input_turnover_1yr_out       := add_input_turnover_1yr_out;
			self.util_add_curr_type_list          := util_add_curr_type_list;
			self.add_curr_occupants_1yr           := add_curr_occupants_1yr;
			self.add_curr_turnover_1yr_out        := add_curr_turnover_1yr_out;
			self.add_curr_turnover_1yr_in         := add_curr_turnover_1yr_in;
			self.college_income_level_code        := college_income_level_code;
			self.r_pb_order_freq_d                := r_pb_order_freq_d;
			self.f_bus_fname_verd_d               := f_bus_fname_verd_d;
			self.f_bus_name_nover_i               := f_bus_name_nover_i;
			self.f_adl_util_misc_n                := f_adl_util_misc_n;
			self.f_util_adl_count_n               := f_util_adl_count_n;
			self.f_util_add_input_conv_n          := f_util_add_input_conv_n;
			self.f_util_add_input_misc_n          := f_util_add_input_misc_n;
			self.f_util_add_curr_conv_n           := f_util_add_curr_conv_n;
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
			self._inq_banko_cm_first_seen         := _inq_banko_cm_first_seen;
			self.f_mos_inq_banko_cm_fseen_d       := f_mos_inq_banko_cm_fseen_d;
			self._inq_banko_cm_last_seen          := _inq_banko_cm_last_seen;
			self.f_mos_inq_banko_cm_lseen_d       := f_mos_inq_banko_cm_lseen_d;
			self._inq_banko_om_first_seen         := _inq_banko_om_first_seen;
			self.f_mos_inq_banko_om_fseen_d       := f_mos_inq_banko_om_fseen_d;
			self._inq_banko_om_last_seen          := _inq_banko_om_last_seen;
			self.f_mos_inq_banko_om_lseen_d       := f_mos_inq_banko_om_lseen_d;
			self.f_attr_arrest_recency_d          := f_attr_arrest_recency_d;
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
			self._acc_last_seen                   := _acc_last_seen;
			self.f_mos_acc_lseen_d                := f_mos_acc_lseen_d;
			self.f_idrisktype_i                   := f_idrisktype_i;
			self.f_idverrisktype_i                := f_idverrisktype_i;
			self.f_sourcerisktype_i               := f_sourcerisktype_i;
			self.f_varrisktype_i                  := f_varrisktype_i;
			self.f_vardobcount_i                  := f_vardobcount_i;
			self.f_srchvelocityrisktype_i         := f_srchvelocityrisktype_i;
			self.f_srchunvrfdaddrcount_i          := f_srchunvrfdaddrcount_i;
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
			self.f_divrisktype_i                  := f_divrisktype_i;
			self.f_divssnidmsrcurelcount_i        := f_divssnidmsrcurelcount_i;
			self.f_divaddrsuspidcountnew_i        := f_divaddrsuspidcountnew_i;
			self.f_srchssnsrchcount_i             := f_srchssnsrchcount_i;
			self.f_srchaddrsrchcount_i            := f_srchaddrsrchcount_i;
			self.f_componentcharrisktype_i        := f_componentcharrisktype_i;
			self.f_inputaddractivephonelist_d     := f_inputaddractivephonelist_d;
			self.f_addrchangeincomediff_d         := f_addrchangeincomediff_d;
			self.f_addrchangevaluediff_d          := f_addrchangevaluediff_d;
			self.f_addrchangecrimediff_i          := f_addrchangecrimediff_i;
			self.f_curraddractivephonelist_d      := f_curraddractivephonelist_d;
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
			self.r_has_paw_source_d               := r_has_paw_source_d;
			self._paw_first_seen                  := _paw_first_seen;
			self.r_mos_since_paw_fseen_d          := r_mos_since_paw_fseen_d;
			self.r_paw_active_phone_ct_d          := r_paw_active_phone_ct_d;
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
			self.final_score                      := final_score;
			self.points                           := points;
			self.odds                             := odds;
			self.base                             := base;
			self.phat                             := phat;
			self.wf8                              := wf8;
			self.clam.phone_shell.Phone_Model_Score := (string) wf8;
			self.clam                             := le;
                              
		#else
			self.phone_shell.Phone_Model_Score		:= (string) wf8;
		#end
			self := le;
	END;

		model := project( clam, doModel(left) )((Integer)phone_shell.Phone_Model_Score >= Score_Threshold); //score threshold defaulted to 306

		return model;

END;