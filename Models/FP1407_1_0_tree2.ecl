EXPORT FP1407_1_0_tree2 := MACRO

N406_10 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => -0.0034814507,
               ((real)c_dist_best_to_prev_addr_i < 6.5)   => 0.0071304031,
                                                             -0.0034814507));

N406_9 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i < 0.5), 0.012059207, N406_10));

N406_8 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i > NULL), N406_9, 0.0079512522));

N406_7 :=__common__( map(trim(C_POP_45_54_P) = ''              => 0.0057946797,
              ((real)c_pop_45_54_p < 20.3499984741) => -0.0044664359,
                                                       0.0057946797));

N406_6 :=__common__( if(((real)c_hh1_p < 19.25), N406_7, -0.00026567395));

N406_5 :=__common__( if(trim(C_HH1_P) != '', N406_6, -0.0011857368));

N406_4 :=__common__( if(((real)f_divaddrsuspidcountnew_i < 2.5), N406_5, 0.0052162127));

N406_3 :=__common__( if(((real)f_divaddrsuspidcountnew_i > NULL), N406_4, -0.00032794645));

N406_2 :=__common__( if(((real)f_inq_adls_per_phone_i < 1.5), N406_3, N406_8));

N406_1 :=__common__( if(((real)f_inq_adls_per_phone_i > NULL), N406_2, -0.027394602));

N407_9 :=__common__( map(trim(C_HVAL_125K_P) = ''              => -0.0026860004,
              ((real)c_hval_125k_p < 16.3499984741) => 0.0085408526,
                                                       -0.0026860004));

N407_8 :=__common__( map(trim(C_AB_AV_EDU) = ''     => -0.0019107616,
              ((real)c_ab_av_edu < 62.5) => 0.0063732257,
                                            -0.0019107616));

N407_7 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.0093845055,
              ((real)r_d32_criminal_count_i < 1.5)   => 0.00050671257,
                                                        0.0093845055));

N407_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.507367730141), -0.0010450444, N407_7));

N407_5 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N407_6, N407_8));

N407_4 :=__common__( if(((real)c_food < 60.6500015259), N407_5, N407_9));

N407_3 :=__common__( if(trim(C_FOOD) != '', N407_4, 0.0049521702));

N407_2 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i < 4.5), N407_3, -0.0036390303));

N407_1 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i > NULL), N407_2, -0.0070795034));

N408_8 :=__common__( map(trim(C_POP00) = ''      => 0.00072883947,
              ((real)c_pop00 < 990.5) => 0.0077143383,
                                         0.00072883947));

N408_7 :=__common__( map(trim(C_MED_YEARBLT) = ''       => -0.013908678,
              ((real)c_med_yearblt < 1956.5) => -0.0018966145,
                                                -0.013908678));

N408_6 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL) => N408_7,
              ((real)f_fp_prevaddrburglaryindex_i < 175.5) => -0.0011052493,
                                                              N408_7));

N408_5 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => N408_6,
              ((real)r_d32_mos_since_crim_ls_d < 27.5)  => 0.0053419855,
                                                           N408_6));

N408_4 :=__common__( map(trim(C_POPOVER25) = ''      => N408_8,
              ((real)c_popover25 < 625.5) => N408_5,
                                             N408_8));

N408_3 :=__common__( if(((real)f_curraddractivephonelist_d > NULL), N408_4, -0.00016324003));

N408_2 :=__common__( if(((real)c_hval_60k_p < 47.4500007629), N408_3, 0.0090125038));

N408_1 :=__common__( if(trim(C_HVAL_60K_P) != '', N408_2, -0.0014115442));

N409_7 :=__common__( map(trim(C_SFDU_P) = ''              => -0.0058760054,
              ((real)c_sfdu_p < 75.0500030518) => 0.0030792703,
                                                  -0.0058760054));

N409_6 :=__common__( map(trim(C_INCOLLEGE) = ''              => N409_7,
              ((real)c_incollege < 3.15000009537) => -0.0088839672,
                                                     N409_7));

N409_5 :=__common__( if(((real)c_hh7p_p < 3.54999995232), N409_6, -0.012078129));

N409_4 :=__common__( if(trim(C_HH7P_P) != '', N409_5, 0.017340669));

N409_3 :=__common__( if(((real)r_c15_ssns_per_adl_i < 2.5), -0.00032729697, 0.0036939308));

N409_2 :=__common__( if(((real)r_c15_ssns_per_adl_i > NULL), N409_3, -0.0033277884));

N409_1 :=__common__( map(((real)f_adl_util_inf_n <= NULL) => N409_4,
              ((real)f_adl_util_inf_n < 0.5)   => N409_2,
                                                  N409_4));

N410_11 :=__common__( map(trim(C_POP_45_54_P) = ''              => 0.0011967183,
               ((real)c_pop_45_54_p < 8.64999961853) => 0.011234606,
                                                        0.0011967183));

N410_10 :=__common__( if(((real)f_rel_under100miles_cnt_d < 23.5), N410_11, -0.0064813839));

N410_9 :=__common__( if(((real)f_rel_under100miles_cnt_d > NULL), N410_10, -0.0069050118));

N410_8 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N410_9, 0.002017424));

N410_7 :=__common__( if(((real)f_rel_under25miles_cnt_d < 12.5), -0.0027428015, 0.0007551007));

N410_6 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N410_7, -0.0013738741));

N410_5 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => N410_8,
              ((real)f_inq_other_count24_i < 1.5)   => N410_6,
                                                       N410_8));

N410_4 :=__common__( if(((real)r_l72_add_vacant_i < 0.5), N410_5, 0.0060585664));

N410_3 :=__common__( if(((real)r_l72_add_vacant_i > NULL), N410_4, -0.031523779));

N410_2 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 9.5), 0.0079930918, N410_3));

N410_1 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N410_2, -0.0058381787));

N411_9 :=__common__( map(trim(C_UNATTACH) = ''      => 0.00082163508,
              ((real)c_unattach < 108.5) => 0.012657536,
                                            0.00082163508));

N411_8 :=__common__( map(trim(C_HIGH_ED) = ''              => 0.00029395056,
              ((real)c_high_ed < 2.54999995232) => 0.0084372319,
                                                   0.00029395056));

N411_7 :=__common__( if(((real)f_inq_per_phone_i < 1.5), N411_8, 0.0090898152));

N411_6 :=__common__( if(((real)f_inq_per_phone_i > NULL), N411_7, -0.027331131));

N411_5 :=__common__( if(((real)r_i60_inq_count12_i < 1.5), N411_6, -0.0010337777));

N411_4 :=__common__( if(((real)r_i60_inq_count12_i > NULL), N411_5, 0.010837511));

N411_3 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.0057302941,
              (segment in ['KMART', 'SEARS FLS'])                => N411_4,
                                                                    -0.0057302941));

N411_2 :=__common__( if(((real)c_lowrent < 91.3500061035), N411_3, N411_9));

N411_1 :=__common__( if(trim(C_LOWRENT) != '', N411_2, 0.001678485));

N412_9 :=__common__( if(((real)f_rel_ageover30_count_d < 18.5), -0.00463711, 0.0050933442));

N412_8 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N412_9, 0.0036196154));

N412_7 :=__common__( map(trim(C_INC_50K_P) = ''      => -0.0039205108,
              ((real)c_inc_50k_p < 15.25) => 0.0069182239,
                                             -0.0039205108));

N412_6 :=__common__( map(((real)f_corrrisktype_i <= NULL) => N412_7,
              ((real)f_corrrisktype_i < 8.5)   => -0.0048867306,
                                                  N412_7));

N412_5 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N412_6,
              ((real)c_hist_addr_match_i < 22.5)  => 0.0012784948,
                                                     N412_6));

N412_4 :=__common__( if(((real)f_curraddractivephonelist_d < 0.5), N412_5, N412_8));

N412_3 :=__common__( if(((real)f_curraddractivephonelist_d > NULL), N412_4, 0.0015893001));

N412_2 :=__common__( if(((real)c_mining < 1.04999995232), N412_3, -0.010990114));

N412_1 :=__common__( if(trim(C_MINING) != '', N412_2, -0.003913759));

N413_8 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => -0.0015638898,
              ((real)r_d32_mos_since_crim_ls_d < 238.5) => -0.010573752,
                                                           -0.0015638898));

N413_7 :=__common__( map(trim(C_UNEMP) = ''              => 0.0018083353,
              ((real)c_unemp < 3.15000009537) => -0.0078440795,
                                                 0.0018083353));

N413_6 :=__common__( if(((real)c_lar_fam < 56.5), -0.0081851017, N413_7));

N413_5 :=__common__( if(trim(C_LAR_FAM) != '', N413_6, 0.014768798));

N413_4 :=__common__( map(((real)f_rel_count_i <= NULL) => N413_8,
              ((real)f_rel_count_i < 21.5)  => N413_5,
                                               N413_8));

N413_3 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => 0.00054370223,
              ((real)r_c13_max_lres_d < 71.5)  => N413_4,
                                                  0.00054370223));

N413_2 :=__common__( if(((real)f_corrssnaddrcount_d < 0.5), 0.0040288741, N413_3));

N413_1 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N413_2, -0.0047959578));

N414_10 :=__common__( if(((real)c_many_cars < 31.5), -0.0060324266, 0.0023289631));

N414_9 :=__common__( if(trim(C_MANY_CARS) != '', N414_10, 0.0023631307));

N414_8 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => 0.0022163466,
              ((real)f_srchfraudsrchcount_i < 3.5)   => -0.0037198893,
                                                        0.0022163466));

N414_7 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N414_8, N414_9));

N414_6 :=__common__( if(((real)r_l79_adls_per_addr_curr_i < 3.5), 0.0069017743, 0.00076549914));

N414_5 :=__common__( if(((real)r_l79_adls_per_addr_curr_i > NULL), N414_6, 0.044251092));

N414_4 :=__common__( map(((real)r_c20_email_count_i <= NULL) => N414_7,
              ((real)r_c20_email_count_i < 0.5)   => N414_5,
                                                     N414_7));

N414_3 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => -0.0041896475,
              ((real)r_c10_m_hdr_fs_d < 343.5) => N414_4,
                                                  -0.0041896475));

N414_2 :=__common__( if(((real)r_c13_max_lres_d < 67.5), -0.0016045918, N414_3));

N414_1 :=__common__( if(((real)r_c13_max_lres_d > NULL), N414_2, -0.0033170997));

N415_9 :=__common__( map(trim(C_CPIALL) = ''              => 0.0019920955,
              ((real)c_cpiall < 222.949996948) => 0.011509371,
                                                  0.0019920955));

N415_8 :=__common__( if(((real)r_c14_addrs_10yr_i < 3.5), -0.0043548922, N415_9));

N415_7 :=__common__( if(((real)r_c14_addrs_10yr_i > NULL), N415_8, 0.021251217));

N415_6 :=__common__( map(trim(C_INCOLLEGE) = ''              => -0.0069227762,
              ((real)c_incollege < 16.9500007629) => -0.00050700405,
                                                     -0.0069227762));

N415_5 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 6.5), 0.0055500556, N415_6));

N415_4 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N415_5, -0.0079358231));

N415_3 :=__common__( map(trim(C_HOUSINGCPI) = ''              => N415_7,
              ((real)c_housingcpi < 215.950012207) => N415_4,
                                                      N415_7));

N415_2 :=__common__( if(((real)c_hval_60k_p < 44.6500015259), N415_3, 0.0075472604));

N415_1 :=__common__( if(trim(C_HVAL_60K_P) != '', N415_2, 0.00037582485));

N416_8 :=__common__( map(trim(C_INC_150K_P) = ''                => -0.0010453446,
              ((real)c_inc_150k_p < 0.0500000007451) => -0.0072312906,
                                                        -0.0010453446));

N416_7 :=__common__( map(trim(C_INC_15K_P) = ''              => -0.001074302,
              ((real)c_inc_15k_p < 8.85000038147) => 0.011290482,
                                                     -0.001074302));

N416_6 :=__common__( map(((real)f_srchvelocityrisktype_i <= NULL) => -0.0099093777,
              ((real)f_srchvelocityrisktype_i < 7.5)   => -0.0019499903,
                                                          -0.0099093777));

N416_5 :=__common__( map(trim(C_NO_TEENS) = ''      => N416_7,
              ((real)c_no_teens < 100.5) => N416_6,
                                            N416_7));

N416_4 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d < 33.5), N416_5, 0.0022304095));

N416_3 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d > NULL), N416_4, 0.0061471318));

N416_2 :=__common__( if(((real)c_health < 8.64999961853), N416_3, N416_8));

N416_1 :=__common__( if(trim(C_HEALTH) != '', N416_2, -0.0016145023));

N417_8 :=__common__( if(((real)f_m_bureau_adl_fs_all_d < 174.5), -0.00038344793, 0.012601623));

N417_7 :=__common__( if(((real)f_m_bureau_adl_fs_all_d > NULL), N417_8, 0.0217131));

N417_6 :=__common__( map(trim(C_FINANCE) = ''              => -0.0033076895,
              ((real)c_finance < 4.14999961853) => 0.0034500478,
                                                   -0.0033076895));

N417_5 :=__common__( map(trim(C_OLD_HOMES) = ''     => -0.0031737791,
              ((real)c_old_homes < 82.5) => 0.00036546979,
                                            -0.0031737791));

N417_4 :=__common__( map(trim(C_HVAL_60K_P) = ''              => N417_6,
              ((real)c_hval_60k_p < 14.1499996185) => N417_5,
                                                      N417_6));

N417_3 :=__common__( map(trim(C_HVAL_200K_P) = ''      => 0.0040474326,
              ((real)c_hval_200k_p < 16.75) => N417_4,
                                               0.0040474326));

N417_2 :=__common__( if(((real)c_housingcpi < 241.75), N417_3, N417_7));

N417_1 :=__common__( if(trim(C_HOUSINGCPI) != '', N417_2, -0.0034251202));

N418_8 :=__common__( map(trim(C_PRESCHL) = ''     => -0.0054111033,
              ((real)c_preschl < 26.5) => 0.0057907799,
                                          -0.0054111033));

N418_7 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => 0.0049355801,
              ((real)r_d30_derog_count_i < 13.5)  => -0.0030334234,
                                                     0.0049355801));

N418_6 :=__common__( map(trim(C_HVAL_80K_P) = ''              => 0.0087863202,
              ((real)c_hval_80k_p < 30.1500015259) => N418_7,
                                                      0.0087863202));

N418_5 :=__common__( if(((real)f_prevaddrcartheftindex_i < 92.5), N418_6, 0.0015323028));

N418_4 :=__common__( if(((real)f_prevaddrcartheftindex_i > NULL), N418_5, -0.0006249889));

N418_3 :=__common__( map(trim(C_NO_LABFOR) = ''      => N418_8,
              ((real)c_no_labfor < 166.5) => N418_4,
                                             N418_8));

N418_2 :=__common__( if(((real)c_unemp < 16.6500015259), N418_3, -0.0065311949));

N418_1 :=__common__( if(trim(C_UNEMP) != '', N418_2, -0.0019048765));

N419_9 :=__common__( if(((real)c_hh6_p < 1.15000009537), 0.00019903284, 0.012324558));

N419_8 :=__common__( if(trim(C_HH6_P) != '', N419_9, -0.039750151));

N419_7 :=__common__( map(trim(C_OLD_HOMES) = ''     => -0.00025752712,
              ((real)c_old_homes < 91.5) => 0.0035599207,
                                            -0.00025752712));

N419_6 :=__common__( map(((real)r_i60_inq_banking_recency_d <= NULL) => N419_7,
              ((integer)r_i60_inq_banking_recency_d < 18) => -0.003524248,
                                                             N419_7));

N419_5 :=__common__( if(((real)c_hval_175k_p < 9.85000038147), N419_6, -0.0018584457));

N419_4 :=__common__( if(trim(C_HVAL_175K_P) != '', N419_5, -0.0064765674));

N419_3 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.0072207789,
              ((real)f_inq_other_count24_i < 6.5)   => N419_4,
                                                       0.0072207789));

N419_2 :=__common__( if(((real)f_rel_felony_count_i < 6.5), N419_3, N419_8));

N419_1 :=__common__( if(((real)f_rel_felony_count_i > NULL), N419_2, 0.0087507991));

N420_11 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d < 0.0952059775591), -0.010068588, -0.00051457656));

N420_10 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d > NULL), N420_11, -0.030242598));

N420_9 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.128267213702), 0.0076046767, -0.0015993151));

N420_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N420_9, -0.027800828));

N420_7 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N420_8, 0.0066899039));

N420_6 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => -0.0010908683,
              ((real)f_inq_adls_per_phone_i < 0.5)   => N420_7,
                                                        -0.0010908683));

N420_5 :=__common__( if(((real)c_bigapt_p < 2.54999995232), -0.0018314618, 0.0032401959));

N420_4 :=__common__( if(trim(C_BIGAPT_P) != '', N420_5, 0.0016838038));

N420_3 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL)  => N420_6,
              ((integer)f_curraddrcrimeindex_i < 140) => N420_4,
                                                         N420_6));

N420_2 :=__common__( if(((real)f_prevaddrageoldest_d < 33.5), N420_3, N420_10));

N420_1 :=__common__( if(((real)f_prevaddrageoldest_d > NULL), N420_2, -0.0058212881));

N421_8 :=__common__( if(((real)c_med_rent < 167.5), 0.009703689, -0.00086498658));

N421_7 :=__common__( if(trim(C_MED_RENT) != '', N421_8, -0.0013346332));

N421_6 :=__common__( if(((real)c_rental < 65.5), -0.0049684468, 0.0058832563));

N421_5 :=__common__( if(trim(C_RENTAL) != '', N421_6, -0.013313685));

N421_4 :=__common__( if(((real)f_srchssnsrchcount_i < 4.5), N421_5, 0.010402704));

N421_3 :=__common__( if(((real)f_srchssnsrchcount_i > NULL), N421_4, -0.0034003276));

N421_2 :=__common__( if(((real)f_college_income_d > NULL), -0.0024385559, N421_3));

N421_1 :=__common__( map(((real)c_comb_age_d <= NULL) => N421_7,
              ((real)c_comb_age_d < 25.5)  => N421_2,
                                              N421_7));

N422_8 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => 0.005802177,
              ((real)f_add_input_nhood_vac_pct_i < 0.0644158944488) => -0.0042158186,
                                                                       0.005802177));

N422_7 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.010790942,
              ((real)c_easiqlife < 137.5) => N422_8,
                                             0.010790942));

N422_6 :=__common__( map(trim(C_LOW_HVAL) = ''      => -0.0082577906,
              ((real)c_low_hval < 61.25) => 0.00019064471,
                                            -0.0082577906));

N422_5 :=__common__( if(((real)c_sub_bus < 152.5), N422_6, N422_7));

N422_4 :=__common__( if(trim(C_SUB_BUS) != '', N422_5, 0.001144357));

N422_3 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.0017592045,
              ((real)r_c20_email_count_i < 1.5)   => N422_4,
                                                     -0.0017592045));

N422_2 :=__common__( if(((real)r_d31_bk_filing_count_i < 2.5), N422_3, 0.0087184368));

N422_1 :=__common__( if(((real)r_d31_bk_filing_count_i > NULL), N422_2, -0.00013940266));

N423_8 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL)  => 0.0071915651,
              ((integer)r_a50_pb_average_dollars_d < 121) => -0.0061607151,
                                                             0.0071915651));

N423_7 :=__common__( map(trim(C_OCCUNIT_P) = ''              => N423_8,
              ((real)c_occunit_p < 92.3500061035) => -0.0068099513,
                                                     N423_8));

N423_6 :=__common__( map(trim(C_INC_25K_P) = ''              => 0.0032628225,
              ((real)c_inc_25k_p < 12.0500001907) => N423_7,
                                                     0.0032628225));

N423_5 :=__common__( if(((real)c_no_car < 180.5), N423_6, -0.0071812576));

N423_4 :=__common__( if(trim(C_NO_CAR) != '', N423_5, 0.0076340288));

N423_3 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => 0.0013230868,
              ((real)f_mos_liens_unrel_cj_fseen_d < 97.5)  => N423_4,
                                                              0.0013230868));

N423_2 :=__common__( if(((real)r_c20_email_domain_free_count_i < 4.5), N423_3, -0.0041551315));

N423_1 :=__common__( if(((real)r_c20_email_domain_free_count_i > NULL), N423_2, -0.0024645006));

N424_7 :=__common__( map(trim(C_RNT250_P) = ''              => -0.014336393,
              ((real)c_rnt250_p < 23.3999996185) => -0.0042015098,
                                                    -0.014336393));

N424_6 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => 0.0038206102,
              ((real)f_add_curr_nhood_vac_pct_i < 0.207047373056) => N424_7,
                                                                     0.0038206102));

N424_5 :=__common__( map(trim(C_HH00) = ''      => 0.00018223157,
              ((real)c_hh00 < 324.5) => N424_6,
                                        0.00018223157));

N424_4 :=__common__( map(trim(C_RNT750_P) = ''              => 0.0026355651,
              ((real)c_rnt750_p < 24.9500007629) => 0.014924571,
                                                    0.0026355651));

N424_3 :=__common__( map(trim(C_UNATTACH) = ''      => N424_4,
              ((real)c_unattach < 102.5) => 0.00084735211,
                                            N424_4));

N424_2 :=__common__( if(((real)c_femdiv_p < 2.04999995232), N424_3, N424_5));

N424_1 :=__common__( if(trim(C_FEMDIV_P) != '', N424_2, 0.00050923121));

N425_8 :=__common__( map(trim(C_SERV_EMPL) = ''      => -0.0028194775,
              ((real)c_serv_empl < 154.5) => 0.0076814116,
                                             -0.0028194775));

N425_7 :=__common__( map(trim(C_REST_INDX) = ''     => N425_8,
              ((real)c_rest_indx < 54.5) => -0.002337751,
                                            N425_8));

N425_6 :=__common__( map(trim(C_BORN_USA) = ''     => N425_7,
              ((real)c_born_usa < 79.5) => -0.0034996014,
                                           N425_7));

N425_5 :=__common__( if(((real)r_d33_eviction_count_i < 2.5), N425_6, 0.0082196946));

N425_4 :=__common__( if(((real)r_d33_eviction_count_i > NULL), N425_5, 0.0047811334));

N425_3 :=__common__( map(trim(C_FEMDIV_P) = ''     => -0.00075476508,
              ((real)c_femdiv_p < 3.25) => N425_4,
                                           -0.00075476508));

N425_2 :=__common__( if(((real)c_hval_1001k_p < 4.64999961853), N425_3, 0.0075459452));

N425_1 :=__common__( if(trim(C_HVAL_1001K_P) != '', N425_2, 0.00051189903));

N426_9 :=__common__( if(((real)r_d32_criminal_count_i < 1.5), 0.001777087, 0.012733568));

N426_8 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N426_9, 0.034686685));

N426_7 :=__common__( map(((real)r_l77_apartment_i <= NULL) => 0.0045071913,
              ((real)r_l77_apartment_i < 0.5)   => -0.0010552044,
                                                   0.0045071913));

N426_6 :=__common__( map(trim(C_EASIQLIFE) = ''      => -0.0074066234,
              ((real)c_easiqlife < 140.5) => N426_7,
                                             -0.0074066234));

N426_5 :=__common__( if(((real)f_rel_homeover500_count_d < 0.5), N426_6, -0.012439541));

N426_4 :=__common__( if(((real)f_rel_homeover500_count_d > NULL), N426_5, -0.0018628575));

N426_3 :=__common__( map(trim(C_HVAL_80K_P) = ''              => N426_4,
              ((real)c_hval_80k_p < 8.05000019073) => 0.0012432672,
                                                      N426_4));

N426_2 :=__common__( if(((real)c_hh1_p < 50.5499992371), N426_3, N426_8));

N426_1 :=__common__( if(trim(C_HH1_P) != '', N426_2, -0.0010718362));

N427_8 :=__common__( map(trim(C_MANY_CARS) = ''      => -0.00025295238,
              ((real)c_many_cars < 100.5) => 0.012535969,
                                             -0.00025295238));

N427_7 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => -0.00021373098,
              ((real)r_c14_addrs_15yr_i < 4.5)   => -0.0041197609,
                                                    -0.00021373098));

N427_6 :=__common__( map(trim(C_POP_55_64_P) = ''              => 0.0087954291,
              ((real)c_pop_55_64_p < 16.5499992371) => 0.00095852628,
                                                       0.0087954291));

N427_5 :=__common__( map(trim(C_RNT750_P) = ''              => N427_7,
              ((real)c_rnt750_p < 15.6499996185) => N427_6,
                                                    N427_7));

N427_4 :=__common__( if(((real)c_construction < 40.0999984741), N427_5, N427_8));

N427_3 :=__common__( if(trim(C_CONSTRUCTION) != '', N427_4, -0.0006964911));

N427_2 :=__common__( if(((integer)r_i60_inq_mortgage_recency_d < 549), -0.0048896489, N427_3));

N427_1 :=__common__( if(((real)r_i60_inq_mortgage_recency_d > NULL), N427_2, 0.0027807336));

N428_8 :=__common__( map(trim(C_POP_35_44_P) = ''              => 0.0015924418,
              ((real)c_pop_35_44_p < 13.4499998093) => -0.0010420987,
                                                       0.0015924418));

N428_7 :=__common__( map(trim(C_INC_15K_P) = ''              => 0.005150111,
              ((real)c_inc_15k_p < 33.1500015259) => -0.0087905975,
                                                     0.005150111));

N428_6 :=__common__( map(trim(C_RNT500_P) = ''              => 0.0080176163,
              ((real)c_rnt500_p < 49.4500007629) => N428_7,
                                                    0.0080176163));

N428_5 :=__common__( map(trim(C_RNT1000_P) = ''      => 0.011929913,
              ((real)c_rnt1000_p < 11.75) => N428_6,
                                             0.011929913));

N428_4 :=__common__( if(((real)c_white_col < 15.5500001907), N428_5, N428_8));

N428_3 :=__common__( if(trim(C_WHITE_COL) != '', N428_4, 0.00029111736));

N428_2 :=__common__( if(((real)f_mos_liens_rel_ot_fseen_d < 39.5), N428_3, -0.0070770943));

N428_1 :=__common__( if(((real)f_mos_liens_rel_ot_fseen_d > NULL), N428_2, -0.0021087376));

N429_8 :=__common__( map(trim(C_POP_6_11_P) = ''              => 0.011124064,
              ((real)c_pop_6_11_p < 7.35000038147) => -4.9873542e-006,
                                                      0.011124064));

N429_7 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => N429_8,
              ((real)f_srchfraudsrchcount_i < 9.5)   => 0.00067899752,
                                                        N429_8));

N429_6 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => -0.0021108691,
              ((real)f_inq_adls_per_phone_i < 0.5)   => N429_7,
                                                        -0.0021108691));

N429_5 :=__common__( if(((real)f_prevaddrmedianincome_d < 60443.5), N429_6, 0.0097670042));

N429_4 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N429_5, 0.017442709));

N429_3 :=__common__( map(trim(C_RENTOCC_P) = ''              => -0.0043277915,
              ((real)c_rentocc_p < 45.3499984741) => 0.00035545386,
                                                     -0.0043277915));

N429_2 :=__common__( if(((real)c_no_car < 161.5), N429_3, N429_4));

N429_1 :=__common__( if(trim(C_NO_CAR) != '', N429_2, -0.0034589576));

N430_10 :=__common__( map(trim(C_LOWRENT) = ''              => -0.0091454083,
               ((real)c_lowrent < 57.5499992371) => -0.0021414668,
                                                    -0.0091454083));

N430_9 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N430_10, -0.0042473182));

N430_8 :=__common__( map(trim(C_RAPE) = ''      => 0.0033443825,
              ((real)c_rape < 185.5) => N430_9,
                                        0.0033443825));

N430_7 :=__common__( if(((integer)r_i61_inq_collection_recency_d < 549), N430_8, 0.0018112316));

N430_6 :=__common__( if(((real)r_i61_inq_collection_recency_d > NULL), N430_7, -0.0076241822));

N430_5 :=__common__( map(trim(C_HVAL_20K_P) = ''              => 0.0099169374,
              ((real)c_hval_20k_p < 21.9500007629) => -0.00071690204,
                                                      0.0099169374));

N430_4 :=__common__( if(((real)r_i61_inq_collection_count12_i < 0.5), N430_5, 0.0050496632));

N430_3 :=__common__( if(((real)r_i61_inq_collection_count12_i > NULL), N430_4, 0.0051933907));

N430_2 :=__common__( if(((real)c_unemp < 7.64999961853), N430_3, N430_6));

N430_1 :=__common__( if(trim(C_UNEMP) != '', N430_2, -0.0031242982));

N431_9 :=__common__( if(((real)c_pop_55_64_p < 9.44999980927), 0.010441998, -0.00073356555));

N431_8 :=__common__( if(trim(C_POP_55_64_P) != '', N431_9, -0.029999117));

N431_7 :=__common__( map(((real)f_attr_arrests_i <= NULL) => N431_8,
              ((real)f_attr_arrests_i < 0.5)   => -0.00043271522,
                                                  N431_8));

N431_6 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.007285216,
              ((real)f_rel_felony_count_i < 6.5)   => N431_7,
                                                      0.007285216));

N431_5 :=__common__( map(trim(C_INC_15K_P) = ''              => -0.0080317328,
              ((real)c_inc_15k_p < 28.8499984741) => 0.00085572323,
                                                     -0.0080317328));

N431_4 :=__common__( if(((real)c_rnt500_p < 4.75), -0.0086453818, N431_5));

N431_3 :=__common__( if(trim(C_RNT500_P) != '', N431_4, -0.0014920922));

N431_2 :=__common__( if(((real)f_mos_acc_lseen_d < 122.5), N431_3, N431_6));

N431_1 :=__common__( if(((real)f_mos_acc_lseen_d > NULL), N431_2, -0.00066671337));

N432_8 :=__common__( map(trim(C_FAMMAR_P) = ''              => 0.0044851525,
              ((real)c_fammar_p < 58.0499992371) => -0.0051354285,
                                                    0.0044851525));

N432_7 :=__common__( map(trim(C_FAMMAR18_P) = ''              => N432_8,
              ((real)c_fammar18_p < 13.6499996185) => 0.0088310679,
                                                      N432_8));

N432_6 :=__common__( map(trim(C_MANY_CARS) = ''     => -0.0039272714,
              ((real)c_many_cars < 99.5) => N432_7,
                                            -0.0039272714));

N432_5 :=__common__( map(trim(C_OLD_HOMES) = ''      => -0.0065478306,
              ((real)c_old_homes < 148.5) => N432_6,
                                             -0.0065478306));

N432_4 :=__common__( map(trim(C_POP_25_34_P) = ''              => 0.0036146078,
              ((real)c_pop_25_34_p < 18.4500007629) => N432_5,
                                                       0.0036146078));

N432_3 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), 0.0004260188, N432_4));

N432_2 :=__common__( if(((real)c_pop_6_11_p < 15.0500001907), N432_3, -0.0074209853));

N432_1 :=__common__( if(trim(C_POP_6_11_P) != '', N432_2, -0.0042404785));

N433_9 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.00082984029,
              ((real)c_comb_age_d < 29.5)  => 0.0067772237,
                                              -0.00082984029));

N433_8 :=__common__( map(trim(C_EXP_PROD) = ''      => 0.0023430788,
              ((real)c_exp_prod < 128.5) => -0.0036748849,
                                            0.0023430788));

N433_7 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => N433_9,
              ((real)f_m_bureau_adl_fs_all_d < 122.5) => N433_8,
                                                         N433_9));

N433_6 :=__common__( if(((real)c_popover25 < 357.5), -0.0070963071, N433_7));

N433_5 :=__common__( if(trim(C_POPOVER25) != '', N433_6, -0.0015248993));

N433_4 :=__common__( if(((real)r_l79_adls_per_addr_c6_i < 5.5), N433_5, 0.0059547473));

N433_3 :=__common__( if(((real)r_l79_adls_per_addr_c6_i > NULL), N433_4, 0.054407477));

N433_2 :=__common__( if(((real)f_util_adl_count_n < 14.5), N433_3, 0.0072600708));

N433_1 :=__common__( if(((real)f_util_adl_count_n > NULL), N433_2, -0.00090797789));

N434_10 :=__common__( map(trim(C_SPAN_LANG) = ''     => -0.0005750193,
               ((real)c_span_lang < 90.5) => 0.012828888,
                                             -0.0005750193));

N434_9 :=__common__( map(trim(C_UNEMPL) = ''     => 0.004068321,
              ((real)c_unempl < 78.5) => -0.0045252415,
                                         0.004068321));

N434_8 :=__common__( map(((real)f_componentcharrisktype_i <= NULL) => N434_9,
              ((real)f_componentcharrisktype_i < 4.5)   => -0.0013554699,
                                                           N434_9));

N434_7 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.350336611271), -0.0072294454, 0.0014720672));

N434_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N434_7, 0.00032087161));

N434_5 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d < 13.5), N434_6, N434_8));

N434_4 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d > NULL), N434_5, -0.004694111));

N434_3 :=__common__( if(((real)r_pb_order_freq_d > NULL), 0.00016705444, N434_4));

N434_2 :=__common__( if(((real)c_relig_indx < 189.5), N434_3, N434_10));

N434_1 :=__common__( if(trim(C_RELIG_INDX) != '', N434_2, -0.0020991654));

N435_9 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.342906862497), 0.00076570745, 0.012294487));

N435_8 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N435_9, -0.030298317));

N435_7 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL) => 0.0014742818,
              ((real)f_prevaddrcartheftindex_i < 155.5) => -0.0041627435,
                                                           0.0014742818));

N435_6 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => 0.00094156659,
              ((real)f_mos_inq_banko_cm_fseen_d < 53.5)  => N435_7,
                                                            0.00094156659));

N435_5 :=__common__( map(trim(C_CONSTRUCTION) = ''              => N435_8,
              ((real)c_construction < 38.8499984741) => N435_6,
                                                        N435_8));

N435_4 :=__common__( map(((real)f_mos_liens_rel_ot_lseen_d <= NULL) => N435_5,
              ((real)f_mos_liens_rel_ot_lseen_d < 122.5) => -0.0068992963,
                                                            N435_5));

N435_3 :=__common__( if(trim(C_POP_65_74_P) != '', N435_4, 0.0085794594));

N435_2 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.310594022274), N435_3, -0.0076504175));

N435_1 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N435_2, -0.0011651991));

N436_8 :=__common__( map(trim(C_POPOVER25) = ''      => 0.0038768751,
              ((real)c_popover25 < 669.5) => -0.0013351519,
                                             0.0038768751));

N436_7 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => 0.0085750225,
              ((real)r_l79_adls_per_addr_curr_i < 36.5)  => N436_8,
                                                            0.0085750225));

N436_6 :=__common__( map(trim(C_PROFESSIONAL) = ''              => -0.00066741502,
              ((real)c_professional < 1.34999990463) => N436_7,
                                                        -0.00066741502));

N436_5 :=__common__( if(((real)f_rel_criminal_count_i > NULL), N436_6, -0.011649976));

N436_4 :=__common__( map(trim(C_HVAL_125K_P) = ''              => -0.0018023815,
              ((real)c_hval_125k_p < 14.5500001907) => N436_5,
                                                       -0.0018023815));

N436_3 :=__common__( map(trim(C_HH4_P) = ''     => N436_4,
              ((real)c_hh4_p < 1.25) => -0.0057498589,
                                        N436_4));

N436_2 :=__common__( if(((real)c_inc_15k_p < 53.4500007629), N436_3, 0.0079141896));

N436_1 :=__common__( if(trim(C_INC_15K_P) != '', N436_2, -0.0016180285));

N437_9 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS FLS', 'SEARS SHO']) => -0.0031783353,
              (segment in ['KMART'])                                          => 0.0050094403,
                                                                                 -0.0031783353));

N437_8 :=__common__( map(trim(C_NEWHOUSE) = ''              => 0.01096458,
              ((real)c_newhouse < 19.0499992371) => N437_9,
                                                    0.01096458));

N437_7 :=__common__( if(((real)c_easiqlife < 123.5), N437_8, -0.0014079064));

N437_6 :=__common__( if(trim(C_EASIQLIFE) != '', N437_7, 0.011391667));

N437_5 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => 0.0031047579,
              ((real)f_srchaddrsrchcount_i < 20.5)  => -0.0025482306,
                                                       0.0031047579));

N437_4 :=__common__( if(((real)c_pop_35_44_p < 14.6499996185), N437_5, 0.0014783124));

N437_3 :=__common__( if(trim(C_POP_35_44_P) != '', N437_4, -0.0046064252));

N437_2 :=__common__( if(((real)f_util_adl_count_n < 6.5), N437_3, N437_6));

N437_1 :=__common__( if(((real)f_util_adl_count_n > NULL), N437_2, -0.0067834746));

N438_8 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => 0.0047441897,
              ((real)f_mos_inq_banko_cm_fseen_d < 86.5)  => 0.00020658559,
                                                            0.0047441897));

N438_7 :=__common__( map(trim(C_LAR_FAM) = ''      => 0.0092612928,
              ((real)c_lar_fam < 149.5) => -0.00056665565,
                                           0.0092612928));

N438_6 :=__common__( if(((real)c_span_lang < 165.5), N438_7, -0.0056501119));

N438_5 :=__common__( if(trim(C_SPAN_LANG) != '', N438_6, 0.0034158163));

N438_4 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.0051379399,
              ((real)r_c20_email_count_i < 1.5)   => N438_5,
                                                     -0.0051379399));

N438_3 :=__common__( map(((real)f_mos_liens_unrel_lt_fseen_d <= NULL) => N438_4,
              ((real)f_mos_liens_unrel_lt_fseen_d < 196.5) => 0.0042210748,
                                                              N438_4));

N438_2 :=__common__( if(((real)f_srchssnsrchcount_i < 4.5), N438_3, N438_8));

N438_1 :=__common__( if(((real)f_srchssnsrchcount_i > NULL), N438_2, 0.005265258));

N439_8 :=__common__( map(trim(C_RNT500_P) = ''              => 0.0042450766,
              ((real)c_rnt500_p < 13.0500001907) => -0.0038431739,
                                                    0.0042450766));

N439_7 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => 0.010067587,
              ((real)f_add_input_nhood_vac_pct_i < 0.0209822114557) => 0.00041177717,
                                                                       0.010067587));

N439_6 :=__common__( map(((real)c_addr_lres_12mo_ct_i <= NULL) => N439_8,
              ((real)c_addr_lres_12mo_ct_i < 4.5)   => N439_7,
                                                       N439_8));

N439_5 :=__common__( map(trim(C_RNT500_P) = ''              => -0.0053814677,
              ((real)c_rnt500_p < 53.1500015259) => N439_6,
                                                    -0.0053814677));

N439_4 :=__common__( if(((real)r_d32_criminal_count_i < 4.5), -0.0011878183, N439_5));

N439_3 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N439_4, 0.00079974319));

N439_2 :=__common__( if(((real)c_oldhouse < 4.25), 0.0075275198, N439_3));

N439_1 :=__common__( if(trim(C_OLDHOUSE) != '', N439_2, -0.0043826715));

N440_8 :=__common__( map(trim(C_BIGAPT_P) = ''              => 0.0032931205,
              ((real)c_bigapt_p < 6.85000038147) => -0.0060275137,
                                                    0.0032931205));

N440_7 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)            => 0.0050389759,
              ((real)f_add_input_nhood_vac_pct_i < 0.00717024039477) => -0.0061803407,
                                                                        0.0050389759));

N440_6 :=__common__( map(trim(C_UNEMP) = ''              => N440_8,
              ((real)c_unemp < 5.14999961853) => N440_7,
                                                 N440_8));

N440_5 :=__common__( map(trim(C_LAR_FAM) = ''     => N440_6,
              ((real)c_lar_fam < 61.5) => -0.011056258,
                                          N440_6));

N440_4 :=__common__( map(trim(C_FAMILIES) = ''      => N440_5,
              ((real)c_families < 186.5) => 0.0047231461,
                                            N440_5));

N440_3 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 6.5), 0.00089871567, N440_4));

N440_2 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N440_3, 0.00098862045));

N440_1 :=__common__( if(trim(C_HH7P_P) != '', N440_2, -0.0020267775));

N441_8 :=__common__( map(trim(C_SERV_EMPL) = ''     => 0.0080633597,
              ((real)c_serv_empl < 63.5) => -0.0021163191,
                                            0.0080633597));

N441_7 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => -0.0022620754,
              ((real)f_mos_inq_banko_om_fseen_d < 32.5)  => 0.0062523167,
                                                            -0.0022620754));

N441_6 :=__common__( map(trim(C_POP_6_11_P) = ''     => N441_8,
              ((real)c_pop_6_11_p < 8.25) => N441_7,
                                             N441_8));

N441_5 :=__common__( map(((real)f_addrchangevaluediff_d <= NULL) => N441_6,
              ((real)f_addrchangevaluediff_d < 413.5) => -0.00061596131,
                                                         N441_6));

N441_4 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => N441_5,
              ((real)f_mos_inq_banko_cm_lseen_d < 20.5)  => -0.0029904121,
                                                            N441_5));

N441_3 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.23580172658), N441_4, -0.007632584));

N441_2 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N441_3, 0.0014655077));

N441_1 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N441_2, -0.0006641802));

N442_8 :=__common__( map(trim(C_TRANSPORT) = ''              => 0.0056487297,
              ((real)c_transport < 12.9499998093) => -0.00013034277,
                                                     0.0056487297));

N442_7 :=__common__( map(trim(C_RNT1250_P) = ''              => 0.0073423291,
              ((real)c_rnt1250_p < 32.1500015259) => N442_8,
                                                     0.0073423291));

N442_6 :=__common__( map(trim(C_HVAL_175K_P) = ''              => 0.0063343595,
              ((real)c_hval_175k_p < 26.3499984741) => N442_7,
                                                       0.0063343595));

N442_5 :=__common__( map(trim(C_UNATTACH) = ''     => N442_6,
              ((real)c_unattach < 81.5) => -0.0027000956,
                                           N442_6));

N442_4 :=__common__( map(trim(C_SUB_BUS) = ''      => -0.0073115442,
              ((real)c_sub_bus < 189.5) => N442_5,
                                           -0.0073115442));

N442_3 :=__common__( if(((real)r_c15_ssns_per_adl_i < 4.5), N442_4, 0.0080704498));

N442_2 :=__common__( if(((real)r_c15_ssns_per_adl_i > NULL), N442_3, -0.0001637798));

N442_1 :=__common__( if(trim(C_NO_CAR) != '', N442_2, 0.0055532599));

N443_9 :=__common__( if(((real)c_mort_indx < 72.5), -0.0020183764, 0.0082086378));

N443_8 :=__common__( if(trim(C_MORT_INDX) != '', N443_9, 0.0064380447));

N443_7 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.00063024881,
              ((real)c_easiqlife < 138.5) => -0.0042899146,
                                             0.00063024881));

N443_6 :=__common__( map(trim(C_CPIALL) = ''              => N443_7,
              ((real)c_cpiall < 209.300003052) => 0.0045801325,
                                                  N443_7));

N443_5 :=__common__( map(trim(C_CPIALL) = ''              => N443_6,
              ((real)c_cpiall < 203.600006104) => -0.0079590603,
                                                  N443_6));

N443_4 :=__common__( if(((real)c_born_usa < 110.5), N443_5, 0.00062194231));

N443_3 :=__common__( if(trim(C_BORN_USA) != '', N443_4, -0.0012033849));

N443_2 :=__common__( if(((real)f_srchcomponentrisktype_i < 2.5), N443_3, N443_8));

N443_1 :=__common__( if(((real)f_srchcomponentrisktype_i > NULL), N443_2, 0.0099998655));

N444_8 :=__common__( map(trim(C_HVAL_400K_P) = ''              => 0.0088566116,
              ((real)c_hval_400k_p < 2.54999995232) => -0.0021652152,
                                                       0.0088566116));

N444_7 :=__common__( map(trim(C_HVAL_125K_P) = ''              => -0.0010833092,
              ((real)c_hval_125k_p < 14.4499998093) => 0.0068538079,
                                                       -0.0010833092));

N444_6 :=__common__( if(((real)f_prevaddrageoldest_d > NULL), N444_7, 0.030097552));

N444_5 :=__common__( map(trim(C_CARTHEFT) = ''     => N444_6,
              ((real)c_cartheft < 88.5) => -0.0044428141,
                                           N444_6));

N444_4 :=__common__( map(trim(C_FEMDIV_P) = ''              => -0.00055823988,
              ((real)c_femdiv_p < 2.34999990463) => N444_5,
                                                    -0.00055823988));

N444_3 :=__common__( map(trim(C_INC_50K_P) = ''              => N444_4,
              ((real)c_inc_50k_p < 3.45000004768) => -0.0079351076,
                                                     N444_4));

N444_2 :=__common__( if(((real)c_rich_wht < 176.5), N444_3, N444_8));

N444_1 :=__common__( if(trim(C_RICH_WHT) != '', N444_2, 0.0015378079));

N445_8 :=__common__( map(trim(C_UNEMPL) = ''     => 0.0033821647,
              ((real)c_unempl < 92.5) => -0.005593754,
                                         0.0033821647));

N445_7 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => 0.0081531324,
              ((real)f_srchssnsrchcount_i < 5.5)   => N445_8,
                                                      0.0081531324));

N445_6 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL) => -0.0066419949,
              ((real)f_liens_unrel_cj_total_amt_i < 389.5) => N445_7,
                                                              -0.0066419949));

N445_5 :=__common__( map(((real)c_unique_addr_count_i <= NULL) => -0.00077307505,
              ((real)c_unique_addr_count_i < 5.5)   => N445_6,
                                                       -0.00077307505));

N445_4 :=__common__( if(((real)c_pop_6_11_p < 15.5500001907), N445_5, -0.0081218182));

N445_3 :=__common__( if(trim(C_POP_6_11_P) != '', N445_4, -0.0020600899));

N445_2 :=__common__( if(((real)r_e55_college_ind_d < 0.5), N445_3, -0.0068168616));

N445_1 :=__common__( if(((real)r_e55_college_ind_d > NULL), N445_2, 0.01049298));

N446_9 :=__common__( if(((real)c_bargains < 183.5), -0.0054010902, 0.0044668745));

N446_8 :=__common__( if(trim(C_BARGAINS) != '', N446_9, -0.031089236));

N446_7 :=__common__( map(((real)f_assocrisktype_i <= NULL) => 0.00030917617,
              ((real)f_assocrisktype_i < 4.5)   => N446_8,
                                                   0.00030917617));

N446_6 :=__common__( map(trim(C_HVAL_125K_P) = ''     => 0.0020273998,
              ((real)c_hval_125k_p < 7.75) => -0.0038011879,
                                              0.0020273998));

N446_5 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.006102226,
              ((real)f_rel_felony_count_i < 1.5)   => N446_6,
                                                      0.006102226));

N446_4 :=__common__( if(((real)c_sfdu_p < 87.9499969482), N446_5, 0.0072213488));

N446_3 :=__common__( if(trim(C_SFDU_P) != '', N446_4, 0.0019923237));

N446_2 :=__common__( if(((real)f_rel_incomeover25_count_d < 7.5), N446_3, N446_7));

N446_1 :=__common__( if(((real)f_rel_incomeover25_count_d > NULL), N446_2, -0.00023623272));

N447_8 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => -0.0014891759,
              ((real)f_mos_inq_banko_om_lseen_d < 30.5)  => -0.013298866,
                                                            -0.0014891759));

N447_7 :=__common__( map(((real)f_mos_acc_lseen_d <= NULL) => 0.0016459445,
              ((real)f_mos_acc_lseen_d < 234.5) => -0.0021505795,
                                                   0.0016459445));

N447_6 :=__common__( if(((real)c_hh2_p < 46.6500015259), N447_7, N447_8));

N447_5 :=__common__( if(trim(C_HH2_P) != '', N447_6, -0.00039760885));

N447_4 :=__common__( map(((real)f_corrssnnamecount_d <= NULL) => 0.0023817043,
              ((real)f_corrssnnamecount_d < 7.5)   => -0.0066887114,
                                                      0.0023817043));

N447_3 :=__common__( map(((real)r_c20_email_count_i <= NULL) => N447_4,
              ((real)r_c20_email_count_i < 1.5)   => -9.7732374e-005,
                                                     N447_4));

N447_2 :=__common__( if(((real)r_c13_max_lres_d < 50.5), N447_3, N447_5));

N447_1 :=__common__( if(((real)r_c13_max_lres_d > NULL), N447_2, 0.0037040836));

N448_9 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => 0.011338756,
              ((real)r_c14_addrs_5yr_i < 3.5)   => 0.00015240164,
                                                   0.011338756));

N448_8 :=__common__( map(trim(C_LOW_ED) = ''              => -0.013399693,
              ((real)c_low_ed < 62.0499992371) => -0.0019889357,
                                                  -0.013399693));

N448_7 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL)  => N448_8,
              ((integer)r_a50_pb_average_dollars_d < 128) => 0.0017061754,
                                                             N448_8));

N448_6 :=__common__( map(((real)r_d32_mos_since_fel_ls_d <= NULL) => 0.00030515621,
              ((real)r_d32_mos_since_fel_ls_d < 240.5) => N448_7,
                                                          0.00030515621));

N448_5 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N448_6, 0.00096763825));

N448_4 :=__common__( map(trim(C_SERV_EMPL) = ''      => N448_9,
              ((real)c_serv_empl < 192.5) => N448_5,
                                             N448_9));

N448_3 :=__common__( if(((real)c_addr_lres_2mo_ct_i < 6.5), N448_4, 0.0066218329));

N448_2 :=__common__( if(((real)c_addr_lres_2mo_ct_i > NULL), N448_3, 0.0022671787));

N448_1 :=__common__( if(trim(C_HHSIZE) != '', N448_2, -0.0019120439));

N449_8 :=__common__( if(((integer)r_a46_curr_avm_autoval_d < 35686), -0.0051391733, 0.0093275493));

N449_7 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N449_8, 0.0016302673));

N449_6 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.164183586836), N449_7, -0.0042261376));

N449_5 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N449_6, 0.00091998747));

N449_4 :=__common__( map(trim(C_RENTOCC_P) = ''              => 0.006140294,
              ((real)c_rentocc_p < 37.1500015259) => 0.0006488026,
                                                     0.006140294));

N449_3 :=__common__( if(((real)c_assault < 127.5), N449_4, N449_5));

N449_2 :=__common__( if(trim(C_ASSAULT) != '', N449_3, 0.0034751832));

N449_1 :=__common__( map((fp_segment in ['2 NAS 479', '3 New DID', '4 Bureau Only', '6 Recent Activity', '7 Other']) => -0.0019351463,
              (fp_segment in ['1 SSN Prob', '5 Derog'])                                                   => N449_2,
                                                                                                             -0.0019351463));

N450_8 :=__common__( map(trim(C_EASIQLIFE) = ''      => -0.0063500742,
              ((real)c_easiqlife < 142.5) => 0.0044279755,
                                             -0.0063500742));

N450_7 :=__common__( map(trim(C_BORN_USA) = ''      => N450_8,
              ((real)c_born_usa < 105.5) => -0.0009765209,
                                            N450_8));

N450_6 :=__common__( if(((real)f_corraddrnamecount_d < 6.5), -0.0038540074, 0.0018062104));

N450_5 :=__common__( if(((real)f_corraddrnamecount_d > NULL), N450_6, -0.003680006));

N450_4 :=__common__( map(trim(C_VACANT_P) = ''              => 0.0068730267,
              ((real)c_vacant_p < 28.4500007629) => N450_5,
                                                    0.0068730267));

N450_3 :=__common__( map(trim(C_OLD_HOMES) = ''     => N450_4,
              ((real)c_old_homes < 71.5) => 0.0014968259,
                                            N450_4));

N450_2 :=__common__( if(((real)c_relig_indx < 128.5), N450_3, N450_7));

N450_1 :=__common__( if(trim(C_RELIG_INDX) != '', N450_2, 0.0026959502));

N451_9 :=__common__( map(trim(C_AMUS_INDX) = ''      => -0.0067377808,
              ((real)c_amus_indx < 116.5) => -0.00068243494,
                                             -0.0067377808));

N451_8 :=__common__( map(trim(C_FOOD) = ''              => N451_9,
              ((real)c_food < 12.5500001907) => 0.0014474569,
                                                N451_9));

N451_7 :=__common__( if(((real)c_no_labfor < 178.5), N451_8, -0.0064808251));

N451_6 :=__common__( if(trim(C_NO_LABFOR) != '', N451_7, -0.0019510147));

N451_5 :=__common__( map(((real)r_c18_invalid_addrs_per_adl_i <= NULL) => 0.00015229897,
              ((real)r_c18_invalid_addrs_per_adl_i < 1.5)   => 0.010875933,
                                                               0.00015229897));

N451_4 :=__common__( if(trim(C_INC_75K_P) != '', N451_5, 0.020305423));

N451_3 :=__common__( map(((real)f_corrrisktype_i <= NULL) => N451_4,
              ((real)f_corrrisktype_i < 8.5)   => -0.0026021862,
                                                  N451_4));

N451_2 :=__common__( if(((real)f_corrssnaddrcount_d < 0.5), N451_3, N451_6));

N451_1 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N451_2, -0.00040655063));

N452_9 :=__common__( map(trim(C_HH1_P) = ''      => 0.0023885668,
              ((real)c_hh1_p < 27.25) => -0.0083095071,
                                         0.0023885668));

N452_8 :=__common__( map(trim(C_INC_35K_P) = ''              => N452_9,
              ((real)c_inc_35k_p < 10.5500001907) => 0.0078252027,
                                                     N452_9));

N452_7 :=__common__( if(((real)c_new_homes < 153.5), N452_8, 0.011851897));

N452_6 :=__common__( if(trim(C_NEW_HOMES) != '', N452_7, 0.015819232));

N452_5 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.0077663001,
              ((real)f_sourcerisktype_i < 6.5)   => 0.00010598629,
                                                    0.0077663001));

N452_4 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => N452_5,
              ((real)r_c10_m_hdr_fs_d < 178.5) => -0.0013963608,
                                                  N452_5));

N452_3 :=__common__( if(trim(C_MANY_CARS) != '', N452_4, -0.0017580659));

N452_2 :=__common__( if(((real)f_srchfraudsrchcountmo_i < 0.5), N452_3, N452_6));

N452_1 :=__common__( if(((real)f_srchfraudsrchcountmo_i > NULL), N452_2, 0.0022897893));

N453_9 :=__common__( map(trim(C_HH5_P) = ''              => -0.0052715909,
              ((real)c_hh5_p < 2.45000004768) => 0.0038701727,
                                                 -0.0052715909));

N453_8 :=__common__( map(trim(C_EASIQLIFE) = ''     => 0.0015886032,
              ((real)c_easiqlife < 77.5) => -0.0013440358,
                                            0.0015886032));

N453_7 :=__common__( map(((real)f_rel_criminal_count_i <= NULL) => N453_9,
              ((real)f_rel_criminal_count_i < 13.5)  => N453_8,
                                                        N453_9));

N453_6 :=__common__( if(trim(C_RELIG_INDX) != '', N453_7, 0.002076182));

N453_5 :=__common__( map(trim(C_POP_12_17_P) = ''              => 0.0049205681,
              ((real)c_pop_12_17_p < 8.55000019073) => -0.009479832,
                                                       0.0049205681));

N453_4 :=__common__( if(((real)c_hval_40k_p < 5.85000038147), N453_5, -0.011027291));

N453_3 :=__common__( if(trim(C_HVAL_40K_P) != '', N453_4, -0.0044992927));

N453_2 :=__common__( if(((real)r_c14_addrs_10yr_i < 1.5), N453_3, N453_6));

N453_1 :=__common__( if(((real)r_c14_addrs_10yr_i > NULL), N453_2, 0.0048005288));

N454_9 :=__common__( if(((real)f_prevaddrlenofres_d < 41.5), -0.0050655988, 0.00025180981));

N454_8 :=__common__( if(((real)f_prevaddrlenofres_d > NULL), N454_9, 0.0069060892));

N454_7 :=__common__( if(((real)f_addrchangecrimediff_i < -56.5), 0.014020416, 0.0019487491));

N454_6 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N454_7, 0.0039600363));

N454_5 :=__common__( if(((real)f_rel_under25miles_cnt_d < 12.5), -0.0015856577, N454_6));

N454_4 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N454_5, -0.0046492297));

N454_3 :=__common__( if(((real)c_unemp < 7.25), N454_4, N454_8));

N454_2 :=__common__( if(trim(C_UNEMP) != '', N454_3, -0.00041670502));

N454_1 :=__common__( map(((real)f_inq_lnames_per_ssn_i <= NULL) => N454_2,
              ((real)f_inq_lnames_per_ssn_i < 0.5)   => 0.0019932315,
                                                        N454_2));

N455_7 :=__common__( map(trim(C_FOOD) = ''      => 0.0076734577,
              ((real)c_food < 60.25) => -0.00011136346,
                                        0.0076734577));

N455_6 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)    => -0.005849788,
              ((integer)f_curraddrmedianvalue_d < 58801) => 0.0043076527,
                                                            -0.005849788));

N455_5 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.286334216595), N455_6, N455_7));

N455_4 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N455_5, 0.0012748682));

N455_3 :=__common__( if(((real)c_pop_35_44_p < 12.75), N455_4, 0.0018758717));

N455_2 :=__common__( if(trim(C_POP_35_44_P) != '', N455_3, -0.00035258737));

N455_1 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.0044719537,
              (segment in ['KMART', 'SEARS FLS'])                => N455_2,
                                                                    -0.0044719537));

N456_7 :=__common__( if(((real)c_hist_addr_match_i < 3.5), -0.005947003, 0.0019491878));

N456_6 :=__common__( if(((real)c_hist_addr_match_i > NULL), N456_7, 0.027008425));

N456_5 :=__common__( if(((real)c_bargains < 67.5), N456_6, 0.001399225));

N456_4 :=__common__( if(trim(C_BARGAINS) != '', N456_5, -0.00094762934));

N456_3 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => -0.0098326821,
              ((real)r_c10_m_hdr_fs_d < 301.5) => 0.00038850409,
                                                  -0.0098326821));

N456_2 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => -0.010041297,
              ((real)f_srchssnsrchcount_i < 18.5)  => N456_3,
                                                      -0.010041297));

N456_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N456_2, N456_4));

N457_8 :=__common__( map(trim(C_HVAL_20K_P) = ''              => 0.0070694947,
              ((real)c_hval_20k_p < 20.5499992371) => -0.00060888139,
                                                      0.0070694947));

N457_7 :=__common__( map(((real)f_estimated_income_d <= NULL)    => -0.0031853966,
              ((integer)f_estimated_income_d < 26500) => -0.010304863,
                                                         -0.0031853966));

N457_6 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => 0.0040583385,
              ((real)f_add_input_nhood_vac_pct_i < 0.268931567669) => N457_7,
                                                                      0.0040583385));

N457_5 :=__common__( if(((real)c_easiqlife < 78.5), N457_6, N457_8));

N457_4 :=__common__( if(trim(C_EASIQLIFE) != '', N457_5, 0.0031022382));

N457_3 :=__common__( map(((real)f_util_adl_count_n <= NULL) => 0.0017139002,
              ((real)f_util_adl_count_n < 6.5)   => N457_4,
                                                    0.0017139002));

N457_2 :=__common__( if(((real)f_rel_bankrupt_count_i < 9.5), N457_3, 0.007036166));

N457_1 :=__common__( if(((real)f_rel_bankrupt_count_i > NULL), N457_2, 0.0038364653));

N458_8 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)    => -0.0001229,
              ((integer)f_prevaddrmedianvalue_d < 51270) => 0.0057765902,
                                                            -0.0001229));

N458_7 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => N458_8,
              ((real)r_c21_m_bureau_adl_fs_d < 166.5) => 0.010830997,
                                                         N458_8));

N458_6 :=__common__( if(((real)r_l70_inp_addr_dnd_i > NULL), -0.0010697873, 0.0054047108));

N458_5 :=__common__( map(trim(C_APT20) = ''      => 0.00095171143,
              ((real)c_apt20 < 106.5) => -0.0061337446,
                                         0.00095171143));

N458_4 :=__common__( if(((real)c_ab_av_edu < 56.5), N458_5, N458_6));

N458_3 :=__common__( if(trim(C_AB_AV_EDU) != '', N458_4, 0.0036273149));

N458_2 :=__common__( if(((real)r_c10_m_hdr_fs_d < 180.5), N458_3, N458_7));

N458_1 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N458_2, -0.0066555205));

N459_10 :=__common__( if(((real)f_add_input_mobility_index_n < 0.872654914856), -0.00053995324, -0.0106668));

N459_9 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N459_10, -0.039842021));

N459_8 :=__common__( map(trim(C_POP_65_74_P) = ''              => 0.0023083137,
              ((real)c_pop_65_74_p < 7.85000038147) => 0.012802437,
                                                       0.0023083137));

N459_7 :=__common__( map(trim(C_OLDHOUSE) = ''      => -0.0020215753,
              ((real)c_oldhouse < 266.5) => N459_8,
                                            -0.0020215753));

N459_6 :=__common__( if(((real)f_srchphonesrchcount_i < 1.5), 0.002456341, -0.0074596301));

N459_5 :=__common__( if(((real)f_srchphonesrchcount_i > NULL), N459_6, 0.0018690994));

N459_4 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0479234457016), N459_5, N459_7));

N459_3 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N459_4, 0.00063559423));

N459_2 :=__common__( if(((real)c_hh5_p < 0.25), N459_3, N459_9));

N459_1 :=__common__( if(trim(C_HH5_P) != '', N459_2, 0.0034789177));

N460_7 :=__common__( map(trim(C_HH7P_P) = ''     => -0.010836636,
              ((real)c_hh7p_p < 0.25) => 0.00065825351,
                                         -0.010836636));

N460_6 :=__common__( map(trim(C_TRAILER) = ''      => 0.00057143207,
              ((real)c_trailer < 135.5) => -0.0093176091,
                                           0.00057143207));

N460_5 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO']) => N460_6,
              (segment in ['SEARS FLS', 'SEARS SHO'])        => 0.0038239728,
                                                                N460_6));

N460_4 :=__common__( map(((real)f_adl_util_inf_n <= NULL) => N460_5,
              ((real)f_adl_util_inf_n < 0.5)   => 0.001016328,
                                                  N460_5));

N460_3 :=__common__( map(trim(C_RETAIL) = ''              => 0.0091865369,
              ((real)c_retail < 48.8499984741) => N460_4,
                                                  0.0091865369));

N460_2 :=__common__( if(((real)c_low_ed < 82.3500061035), N460_3, N460_7));

N460_1 :=__common__( if(trim(C_LOW_ED) != '', N460_2, -0.0054466837));

N461_9 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.0055523881,
              ((real)c_sub_bus < 179.5) => -0.0021049574,
                                           0.0055523881));

N461_8 :=__common__( if(((real)r_c13_curr_addr_lres_d < 114.5), N461_9, 0.0058492676));

N461_7 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N461_8, -0.036630355));

N461_6 :=__common__( map(((real)r_phn_cell_n <= NULL) => N461_7,
              ((real)r_phn_cell_n < 0.5)   => 0.0024440143,
                                              N461_7));

N461_5 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d < 13.5), -0.0022680439, N461_6));

N461_4 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d > NULL), N461_5, 0.0011204466));

N461_3 :=__common__( map(trim(C_MORT_INDX) = ''     => 0.0018170191,
              ((real)c_mort_indx < 66.5) => 0.01190223,
                                            0.0018170191));

N461_2 :=__common__( if(((real)c_pop_0_5_p < 4.25), N461_3, N461_4));

N461_1 :=__common__( if(trim(C_POP_0_5_P) != '', N461_2, 0.0015134419));

N462_8 :=__common__( if(((real)r_i60_inq_hiriskcred_count12_i < 2.5), 0.003831769, -0.0057751124));

N462_7 :=__common__( if(((real)r_i60_inq_hiriskcred_count12_i > NULL), N462_8, 0.024358824));

N462_6 :=__common__( map(trim(C_MED_RENT) = ''      => N462_7,
              ((real)c_med_rent < 351.5) => -0.0046513404,
                                            N462_7));

N462_5 :=__common__( map(trim(C_INC_100K_P) = ''              => -0.0051875251,
              ((real)c_inc_100k_p < 12.5500001907) => N462_6,
                                                      -0.0051875251));

N462_4 :=__common__( map(trim(C_OLD_HOMES) = ''     => N462_5,
              ((real)c_old_homes < 71.5) => 0.004443572,
                                            N462_5));

N462_3 :=__common__( map(trim(C_RETIRED2) = ''      => 0.0081717348,
              ((real)c_retired2 < 153.5) => N462_4,
                                            0.0081717348));

N462_2 :=__common__( if(((real)c_construction < 1.54999995232), N462_3, -0.00096608239));

N462_1 :=__common__( if(trim(C_CONSTRUCTION) != '', N462_2, 0.004984579));

N463_10 :=__common__( if(((real)c_bargains < 82.5), 0.013206623, 0.0015493146));

N463_9 :=__common__( if(trim(C_BARGAINS) != '', N463_10, -0.013084633));

N463_8 :=__common__( if(((real)f_inq_lnames_per_addr_i < 2.5), -0.00051843372, N463_9));

N463_7 :=__common__( if(((real)f_inq_lnames_per_addr_i > NULL), N463_8, 0.010423062));

N463_6 :=__common__( map((fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '4 Bureau Only', '5 Derog', '7 Other']) => 0.00039228499,
              (fp_segment in ['6 Recent Activity'])                                                           => 0.011172113,
                                                                                                                 0.00039228499));

N463_5 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => -0.010288768,
              ((real)f_add_curr_nhood_vac_pct_i < 0.0784749463201) => -0.0014757601,
                                                                      -0.010288768));

N463_4 :=__common__( map(trim(C_FAMOTF18_P) = ''      => 0.0041812952,
              ((real)c_famotf18_p < 48.25) => N463_5,
                                              0.0041812952));

N463_3 :=__common__( if(((real)c_totsales < 1444.5), N463_4, N463_6));

N463_2 :=__common__( if(trim(C_TOTSALES) != '', N463_3, 0.012802584));

N463_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N463_2, N463_7));

N464_9 :=__common__( if(((real)c_hhsize < 2.625), 0.0023385721, -0.0089663692));

N464_8 :=__common__( if(trim(C_HHSIZE) != '', N464_9, 0.011417557));

N464_7 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => 0.010059556,
              ((real)f_add_curr_nhood_sfd_pct_d < 0.951607644558) => 0.0019688761,
                                                                     0.010059556));

N464_6 :=__common__( map(trim(C_ROBBERY) = ''     => N464_7,
              ((real)c_robbery < 71.5) => -0.0026960524,
                                          N464_7));

N464_5 :=__common__( if(((real)c_occunit_p < 80.5500030518), 0.0088829615, N464_6));

N464_4 :=__common__( if(trim(C_OCCUNIT_P) != '', N464_5, 0.012225619));

N464_3 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL) => N464_8,
              ((real)f_liens_unrel_cj_total_amt_i < 657.5) => N464_4,
                                                              N464_8));

N464_2 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i < 0.5), N464_3, -0.0005932552));

N464_1 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i > NULL), N464_2, 0.0076803245));

N465_7 :=__common__( map(((real)c_inf_phn_verd_d <= NULL) => 0.0070888905,
              ((real)c_inf_phn_verd_d < 0.5)   => -0.0014141465,
                                                  0.0070888905));

N465_6 :=__common__( if(((real)f_current_count_d < 0.5), 0.013839921, 0.0018225854));

N465_5 :=__common__( if(((real)f_current_count_d > NULL), N465_6, 0.078663841));

N465_4 :=__common__( map(((real)c_comb_age_d <= NULL) => N465_7,
              ((real)c_comb_age_d < 29.5)  => N465_5,
                                              N465_7));

N465_3 :=__common__( if(((real)c_fammar_p < 26.25), -0.0062371499, N465_4));

N465_2 :=__common__( if(trim(C_FAMMAR_P) != '', N465_3, 0.00086697377));

N465_1 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), N465_2, -0.00086090315));

N466_9 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.42027336359), 0.0050993004, -0.0038755564));

N466_8 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N466_9, -0.0062040513));

N466_7 :=__common__( map(trim(C_EXP_PROD) = ''     => N466_8,
              ((real)c_exp_prod < 56.5) => -0.0026094835,
                                           N466_8));

N466_6 :=__common__( if(((real)c_sfdu_p < 35.0499992371), 0.0075236822, N466_7));

N466_5 :=__common__( if(trim(C_SFDU_P) != '', N466_6, 0.020902927));

N466_4 :=__common__( map(((real)c_comb_age_d <= NULL) => -8.5926399e-005,
              ((real)c_comb_age_d < 28.5)  => N466_5,
                                              -8.5926399e-005));

N466_3 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => 0.0012762101,
              ((real)r_c21_m_bureau_adl_fs_d < 162.5) => -0.0085358299,
                                                         0.0012762101));

N466_2 :=__common__( if(((real)f_srchfraudsrchcount_i < 0.5), N466_3, N466_4));

N466_1 :=__common__( if(((real)f_srchfraudsrchcount_i > NULL), N466_2, -0.00051908905));

N467_9 :=__common__( map(trim(C_POP_45_54_P) = ''              => 0.0019300113,
              ((real)c_pop_45_54_p < 12.9499998093) => -0.0048258759,
                                                       0.0019300113));

N467_8 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => N467_9,
              ((real)r_c12_num_nonderogs_d < 8.5)   => 0.0030576362,
                                                       N467_9));

N467_7 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => N467_8,
              ((real)r_c10_m_hdr_fs_d < 162.5) => -0.001413588,
                                                  N467_8));

N467_6 :=__common__( if(((real)c_hval_300k_p < 20.0499992371), N467_7, -0.0074011866));

N467_5 :=__common__( if(trim(C_HVAL_300K_P) != '', N467_6, -0.0066409307));

N467_4 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i < 3.5), 0.00037862989, 0.0097438727));

N467_3 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), N467_4, N467_5));

N467_2 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.190672934055), -0.0073339438, N467_3));

N467_1 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N467_2, -0.0044213174));

N468_9 :=__common__( map(trim(C_HVAL_100K_P) = ''              => 0.0023351452,
              ((real)c_hval_100k_p < 12.0500001907) => 0.014092459,
                                                       0.0023351452));

N468_8 :=__common__( map(trim(C_LAR_FAM) = ''     => N468_9,
              ((real)c_lar_fam < 77.5) => -7.0332213e-005,
                                          N468_9));

N468_7 :=__common__( if(((real)c_ab_av_edu < 45.5), -0.0044733244, N468_8));

N468_6 :=__common__( if(trim(C_AB_AV_EDU) != '', N468_7, 0.030023389));

N468_5 :=__common__( if(((real)f_rel_ageover40_count_d < 3.5), -0.00053625939, -0.0067604795));

N468_4 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N468_5, -0.00063001434));

N468_3 :=__common__( map(((real)f_assoccredbureaucount_i <= NULL) => 0.00063977115,
              ((real)f_assoccredbureaucount_i < 0.5)   => N468_4,
                                                          0.00063977115));

N468_2 :=__common__( if(((real)f_srchfraudsrchcountmo_i < 0.5), N468_3, N468_6));

N468_1 :=__common__( if(((real)f_srchfraudsrchcountmo_i > NULL), N468_2, 0.0075014113));

N469_8 :=__common__( if(((real)c_rape < 181.5), 0.0041508234, -0.0024882312));

N469_7 :=__common__( if(trim(C_RAPE) != '', N469_8, 0.0043787867));

N469_6 :=__common__( map(((real)f_adl_util_inf_n <= NULL) => -0.003026175,
              ((real)f_adl_util_inf_n < 0.5)   => N469_7,
                                                  -0.003026175));

N469_5 :=__common__( map(((real)r_s66_adlperssn_count_i <= NULL) => 0.0018131566,
              ((real)r_s66_adlperssn_count_i < 1.5)   => -0.0035397843,
                                                         0.0018131566));

N469_4 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => N469_6,
              ((real)f_rel_felony_count_i < 0.5)   => N469_5,
                                                      N469_6));

N469_3 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL) => 0.0085758274,
              ((real)f_prevaddrmurderindex_i < 197.5) => N469_4,
                                                         0.0085758274));

N469_2 :=__common__( if(((real)f_rel_incomeover75_count_d < 1.5), N469_3, -0.0019172709));

N469_1 :=__common__( if(((real)f_rel_incomeover75_count_d > NULL), N469_2, 0.0020678094));

N470_8 :=__common__( map(trim(C_POP_6_11_P) = ''              => 0.0089144617,
              ((real)c_pop_6_11_p < 8.85000038147) => -0.0012318632,
                                                      0.0089144617));

N470_7 :=__common__( if(((integer)r_i61_inq_collection_recency_d < 9), N470_8, -0.0013040844));

N470_6 :=__common__( if(((real)r_i61_inq_collection_recency_d > NULL), N470_7, -0.0089160171));

N470_5 :=__common__( map(trim(C_FOOD) = ''      => -0.0069654432,
              ((real)c_food < 20.25) => 0.0081251014,
                                        -0.0069654432));

N470_4 :=__common__( map(trim(C_HVAL_125K_P) = ''              => 0.011879837,
              ((real)c_hval_125k_p < 6.55000019073) => N470_5,
                                                       0.011879837));

N470_3 :=__common__( map(trim(C_POPOVER18) = ''      => N470_4,
              ((real)c_popover18 < 881.5) => -0.0011267231,
                                             N470_4));

N470_2 :=__common__( if(((real)c_rnt750_p < 0.0500000007451), N470_3, N470_6));

N470_1 :=__common__( if(trim(C_RNT750_P) != '', N470_2, 0.0011191707));

N471_8 :=__common__( map(((real)f_adl_util_inf_n <= NULL) => -0.011653462,
              ((real)f_adl_util_inf_n < 0.5)   => -0.0029099721,
                                                  -0.011653462));

N471_7 :=__common__( map(trim(C_UNEMP) = ''              => N471_8,
              ((real)c_unemp < 4.94999980927) => 0.0024663182,
                                                 N471_8));

N471_6 :=__common__( map(trim(C_FOR_SALE) = ''      => 0.002978848,
              ((real)c_for_sale < 144.5) => -0.00028366214,
                                            0.002978848));

N471_5 :=__common__( if(((real)f_corraddrphonecount_d < 0.5), N471_6, N471_7));

N471_4 :=__common__( if(((real)f_corraddrphonecount_d > NULL), N471_5, 0.001814401));

N471_3 :=__common__( map(trim(C_INCOLLEGE) = ''              => -0.0098820075,
              ((real)c_incollege < 3.54999995232) => 0.0008961567,
                                                     -0.0098820075));

N471_2 :=__common__( if(((integer)c_med_hval < 43411), N471_3, N471_4));

N471_1 :=__common__( if(trim(C_MED_HVAL) != '', N471_2, 0.0021143332));

N472_9 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => -0.0013675513,
              ((real)f_mos_inq_banko_cm_fseen_d < 70.5)  => 0.0037503811,
                                                            -0.0013675513));

N472_8 :=__common__( if(((real)f_inq_highriskcredit_count24_i < 9.5), N472_9, -0.0072037572));

N472_7 :=__common__( if(((real)f_inq_highriskcredit_count24_i > NULL), N472_8, 0.0083736293));

N472_6 :=__common__( map(trim(C_POPOVER18) = ''        => 0.011996473,
              ((integer)c_popover18 < 1527) => N472_7,
                                               0.011996473));

N472_5 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => -0.0033541455,
              ((real)f_curraddrmedianincome_d < 16436.5) => 0.0059402045,
                                                            -0.0033541455));

N472_4 :=__common__( if(((real)f_current_count_d < 0.5), 0.00043895923, N472_5));

N472_3 :=__common__( if(((real)f_current_count_d > NULL), N472_4, -0.0072724889));

N472_2 :=__common__( if(((real)c_born_usa < 155.5), N472_3, N472_6));

N472_1 :=__common__( if(trim(C_BORN_USA) != '', N472_2, -0.0024262111));

N473_9 :=__common__( map(trim(C_LARCENY) = ''      => -0.0049514286,
              ((real)c_larceny < 180.5) => 0.0030497529,
                                           -0.0049514286));

N473_8 :=__common__( if(((real)c_inc_50k_p < 18.9500007629), -0.0012883749, N473_9));

N473_7 :=__common__( if(trim(C_INC_50K_P) != '', N473_8, 0.00077600844));

N473_6 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => 0.012679777,
              ((real)c_dist_best_to_prev_addr_i < 4.5)   => 0.00048503413,
                                                            0.012679777));

N473_5 :=__common__( if(((real)c_asian_lang < 114.5), N473_6, -0.0023193774));

N473_4 :=__common__( if(trim(C_ASIAN_LANG) != '', N473_5, 0.0056611363));

N473_3 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => N473_7,
              ((real)r_d32_mos_since_crim_ls_d < 13.5)  => N473_4,
                                                           N473_7));

N473_2 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d < 3.5), 0.0066816499, N473_3));

N473_1 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N473_2, 0.0031621923));

N474_9 :=__common__( map(((real)r_nas_addr_verd_d <= NULL) => -0.00282526,
              ((real)r_nas_addr_verd_d < 0.5)   => -0.012999317,
                                                   -0.00282526));

N474_8 :=__common__( map(((real)r_phn_cell_n <= NULL) => -0.0015977869,
              ((real)r_phn_cell_n < 0.5)   => 0.005243407,
                                              -0.0015977869));

N474_7 :=__common__( map(trim(C_LARCENY) = ''      => N474_9,
              ((real)c_larceny < 148.5) => N474_8,
                                           N474_9));

N474_6 :=__common__( if(((real)c_finance < 1.54999995232), 0.0018257059, N474_7));

N474_5 :=__common__( if(trim(C_FINANCE) != '', N474_6, -0.0045077733));

N474_4 :=__common__( if(((real)r_phn_pcs_n < 0.5), -0.00011145362, -0.0078549729));

N474_3 :=__common__( if(((real)r_phn_pcs_n > NULL), N474_4, -0.027219828));

N474_2 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d < 13.5), N474_3, N474_5));

N474_1 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d > NULL), N474_2, 0.009130817));

N475_10 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.004422505,
               ((real)c_comb_age_d < 33.5)  => 0.0072945556,
                                               -0.004422505));

N475_9 :=__common__( if(((real)f_rel_ageover40_count_d < 0.5), N475_10, -0.0034251329));

N475_8 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N475_9, -0.008057588));

N475_7 :=__common__( if(((real)f_rel_under25miles_cnt_d < 7.5), -0.0031304466, 0.0044366114));

N475_6 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N475_7, -0.0093370335));

N475_5 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.165674597025), 0.0086355576, N475_6));

N475_4 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N475_5, 0.0038144124));

N475_3 :=__common__( map(((real)r_l77_apartment_i <= NULL) => N475_4,
              ((real)r_l77_apartment_i < 0.5)   => 5.7975281e-005,
                                                   N475_4));

N475_2 :=__common__( if(((real)c_ab_av_edu < 102.5), N475_3, N475_8));

N475_1 :=__common__( if(trim(C_AB_AV_EDU) != '', N475_2, -0.0024190816));

N476_8 :=__common__( map(trim(C_MORT_INDX) = ''     => 0.00026804685,
              ((real)c_mort_indx < 36.5) => -0.005793108,
                                            0.00026804685));

N476_7 :=__common__( map(trim(C_FAMMAR_P) = ''              => N476_8,
              ((real)c_fammar_p < 11.4499998093) => -0.008508258,
                                                    N476_8));

N476_6 :=__common__( map(trim(C_SPAN_LANG) = ''      => -0.0039719956,
              ((real)c_span_lang < 134.5) => 0.0075979951,
                                             -0.0039719956));

N476_5 :=__common__( if(((real)f_college_income_d > NULL), -0.010198417, N476_6));

N476_4 :=__common__( map(trim(C_RETAIL) = ''              => N476_5,
              ((real)c_retail < 1.95000004768) => 0.0088239798,
                                                  N476_5));

N476_3 :=__common__( if(((real)f_rel_ageover30_count_d < 2.5), N476_4, N476_7));

N476_2 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N476_3, -0.0011567134));

N476_1 :=__common__( if(trim(C_FAMMAR18_P) != '', N476_2, -0.0026187206));

N477_8 :=__common__( map(trim(C_POPOVER25) = ''      => 0.0013395822,
              ((real)c_popover25 < 970.5) => -0.0012991241,
                                             0.0013395822));

N477_7 :=__common__( map(((real)c_a49_prop_sold_purchase_tot_d <= NULL)    => 0.0068405769,
              ((integer)c_a49_prop_sold_purchase_tot_d < 26734) => N477_8,
                                                                   0.0068405769));

N477_6 :=__common__( map(trim(C_HVAL_100K_P) = ''              => 0.007706155,
              ((real)c_hval_100k_p < 48.5499992371) => N477_7,
                                                       0.007706155));

N477_5 :=__common__( map(trim(C_SPAN_LANG) = ''      => -0.0088871742,
              ((real)c_span_lang < 191.5) => N477_6,
                                             -0.0088871742));

N477_4 :=__common__( if(((real)c_hh7p_p < 12.25), N477_5, 0.0072483867));

N477_3 :=__common__( if(trim(C_HH7P_P) != '', N477_4, -0.0021319835));

N477_2 :=__common__( if(((real)r_f00_input_dob_match_level_d < 3.5), 0.0086327824, N477_3));

N477_1 :=__common__( if(((real)r_f00_input_dob_match_level_d > NULL), N477_2, 0.001104756));

N478_11 :=__common__( if(((real)c_pop_45_54_p < 11.5500001907), -0.0016499839, 0.0094145799));

N478_10 :=__common__( if(trim(C_POP_45_54_P) != '', N478_11, 0.013264326));

N478_9 :=__common__( if(((real)c_pop_55_64_p < 17.5499992371), 0.00021457462, -0.0071178918));

N478_8 :=__common__( if(trim(C_POP_55_64_P) != '', N478_9, -0.0026278145));

N478_7 :=__common__( if(((real)f_divaddrsuspidcountnew_i < 1.5), N478_8, N478_10));

N478_6 :=__common__( if(((real)f_divaddrsuspidcountnew_i > NULL), N478_7, -0.0084736854));

N478_5 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => 0.0053246096,
              ((real)c_hist_addr_match_i < 6.5)   => -0.0012764023,
                                                     0.0053246096));

N478_4 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => -0.0099748812,
              ((real)c_hist_addr_match_i < 21.5)  => N478_5,
                                                     -0.0099748812));

N478_3 :=__common__( if(((real)f_corrrisktype_i < 8.5), N478_4, 0.0075080019));

N478_2 :=__common__( if(((real)f_corrrisktype_i > NULL), N478_3, -0.0081509033));

N478_1 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N478_2, N478_6));

N479_7 :=__common__( map(((real)r_c20_email_domain_free_count_i <= NULL) => 0.010869804,
              ((real)r_c20_email_domain_free_count_i < 2.5)   => 0.00029064551,
                                                                 0.010869804));

N479_6 :=__common__( map(((real)f_util_adl_count_n <= NULL) => -0.00012943185,
              ((real)f_util_adl_count_n < 0.5)   => 0.0035201831,
                                                    -0.00012943185));

N479_5 :=__common__( map(((real)f_inq_auto_count24_i <= NULL) => -0.009044644,
              ((real)f_inq_auto_count24_i < 2.5)   => N479_6,
                                                      -0.009044644));

N479_4 :=__common__( map(((real)f_mos_liens_rel_cj_lseen_d <= NULL) => N479_5,
              ((real)f_mos_liens_rel_cj_lseen_d < 126.5) => -0.0048198065,
                                                            N479_5));

N479_3 :=__common__( map(((real)f_srchunvrfdphonecount_i <= NULL) => N479_7,
              ((real)f_srchunvrfdphonecount_i < 2.5)   => N479_4,
                                                          N479_7));

N479_2 :=__common__( if(((real)f_srchfraudsrchcountyr_i < 10.5), N479_3, -0.006150313));

N479_1 :=__common__( if(((real)f_srchfraudsrchcountyr_i > NULL), N479_2, 0.0026024758));

N480_8 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i < 2021.5), -0.0028527318, 0.006439998));

N480_7 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i > NULL), N480_8, 0.00035862564));

N480_6 :=__common__( if(((real)c_fammar_p < 36.9500007629), -0.0058538085, 0.0016949019));

N480_5 :=__common__( if(trim(C_FAMMAR_P) != '', N480_6, -0.014743517));

N480_4 :=__common__( map(((real)f_crim_rel_under25miles_cnt_i <= NULL) => N480_5,
              ((real)f_crim_rel_under25miles_cnt_i < 5.5)   => -0.0065468331,
                                                               N480_5));

N480_3 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 6.5), 0.0012397989, N480_4));

N480_2 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N480_3, 0.0020853034));

N480_1 :=__common__( map(((real)r_phn_pcs_n <= NULL) => N480_7,
              ((real)r_phn_pcs_n < 0.5)   => N480_2,
                                             N480_7));

N481_8 :=__common__( map(trim(C_ROBBERY) = ''      => -0.0066092254,
              ((real)c_robbery < 181.5) => 0.0046853433,
                                           -0.0066092254));

N481_7 :=__common__( map(trim(C_NO_MOVE) = ''     => N481_8,
              ((real)c_no_move < 80.5) => 0.010188438,
                                          N481_8));

N481_6 :=__common__( map(trim(C_INC_125K_P) = ''              => -0.013985719,
              ((real)c_inc_125k_p < 3.15000009537) => -0.0012365931,
                                                      -0.013985719));

N481_5 :=__common__( map(trim(C_NO_CAR) = ''      => N481_6,
              ((real)c_no_car < 188.5) => -0.00013626198,
                                          N481_6));

N481_4 :=__common__( if(((real)r_l72_add_curr_vacant_i < 0.5), N481_5, 0.007127009));

N481_3 :=__common__( if(((real)r_l72_add_curr_vacant_i > NULL), N481_4, 0.0025707449));

N481_2 :=__common__( if(((real)c_rape < 186.5), N481_3, N481_7));

N481_1 :=__common__( if(trim(C_RAPE) != '', N481_2, 0.00011992195));

N482_8 :=__common__( if(((real)f_srchunvrfdphonecount_i < 0.5), 0.0042255968, -0.0034256788));

N482_7 :=__common__( if(((real)f_srchunvrfdphonecount_i > NULL), N482_8, -0.02269213));

N482_6 :=__common__( if(((real)f_srchfraudsrchcountyr_i < 1.5), 0.0018500574, 0.0071292635));

N482_5 :=__common__( if(((real)f_srchfraudsrchcountyr_i > NULL), N482_6, 0.0094139328));

N482_4 :=__common__( map(trim(C_POP_18_24_P) = ''      => -0.0039579117,
              ((real)c_pop_18_24_p < 15.75) => N482_5,
                                               -0.0039579117));

N482_3 :=__common__( if(((integer)c_medi_indx < 89), N482_4, -0.00087148248));

N482_2 :=__common__( if(trim(C_MEDI_INDX) != '', N482_3, 0.0015424561));

N482_1 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => N482_7,
              ((real)f_inq_adls_per_phone_i < 0.5)   => N482_2,
                                                        N482_7));

N483_8 :=__common__( map(trim(C_POP_35_44_P) = ''              => 0.0034021534,
              ((real)c_pop_35_44_p < 17.8499984741) => -0.0073412861,
                                                       0.0034021534));

N483_7 :=__common__( map(trim(C_RICH_BLK) = ''      => 0.0022378999,
              ((real)c_rich_blk < 179.5) => N483_8,
                                            0.0022378999));

N483_6 :=__common__( map(((real)r_c18_invalid_addrs_per_adl_i <= NULL) => -0.0042344056,
              ((real)r_c18_invalid_addrs_per_adl_i < 4.5)   => 0.00027024644,
                                                               -0.0042344056));

N483_5 :=__common__( if(((real)f_inq_collection_count24_i < 3.5), N483_6, 0.0061889251));

N483_4 :=__common__( if(((real)f_inq_collection_count24_i > NULL), N483_5, 6.273599e-005));

N483_3 :=__common__( map(trim(C_RETAIL) = ''              => 0.0077255585,
              ((real)c_retail < 53.8499984741) => N483_4,
                                                  0.0077255585));

N483_2 :=__common__( if(((real)c_rich_fam < 158.5), N483_3, N483_7));

N483_1 :=__common__( if(trim(C_RICH_FAM) != '', N483_2, 0.0029909759));

N484_9 :=__common__( if(((real)c_construction < 27.5499992371), -0.00079131735, 0.006298051));

N484_8 :=__common__( if(trim(C_CONSTRUCTION) != '', N484_9, 0.01367387));

N484_7 :=__common__( if(((real)f_srchvelocityrisktype_i < 2.5), -0.005711848, N484_8));

N484_6 :=__common__( if(((real)f_srchvelocityrisktype_i > NULL), N484_7, -0.001204416));

N484_5 :=__common__( if(((real)f_inq_other_count24_i < 0.5), -0.00042489669, 0.0044400421));

N484_4 :=__common__( if(((real)f_inq_other_count24_i > NULL), N484_5, -0.001269181));

N484_3 :=__common__( if(((real)c_highrent < 20.1500015259), N484_4, 0.010210983));

N484_2 :=__common__( if(trim(C_HIGHRENT) != '', N484_3, 0.0061454364));

N484_1 :=__common__( map(((real)f_inq_lnames_per_ssn_i <= NULL) => N484_6,
              ((real)f_inq_lnames_per_ssn_i < 0.5)   => N484_2,
                                                        N484_6));

N485_8 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => -0.000339296,
              ((real)r_l79_adls_per_addr_curr_i < 1.5)   => 0.0091874152,
                                                            -0.000339296));

N485_7 :=__common__( if(((real)f_curraddrmedianincome_d < 26838.5), N485_8, -0.00013365666));

N485_6 :=__common__( if(((real)f_curraddrmedianincome_d > NULL), N485_7, 0.01308383));

N485_5 :=__common__( map(trim(C_POP_0_5_P) = ''              => -0.0066090864,
              ((real)c_pop_0_5_p < 7.05000019073) => 0.0010296418,
                                                     -0.0066090864));

N485_4 :=__common__( map(trim(C_INC_150K_P) = ''               => 0.000488601,
              ((real)c_inc_150k_p < 0.449999988079) => N485_5,
                                                       0.000488601));

N485_3 :=__common__( map(trim(C_HIGH_ED) = ''              => -0.0098656837,
              ((real)c_high_ed < 37.6500015259) => N485_4,
                                                   -0.0098656837));

N485_2 :=__common__( if(((real)c_bigapt_p < 1.65000009537), N485_3, N485_6));

N485_1 :=__common__( if(trim(C_BIGAPT_P) != '', N485_2, -0.0068420635));

N486_10 :=__common__( map(trim(C_FEMDIV_P) = ''              => -0.0090160696,
               ((real)c_femdiv_p < 11.3500003815) => -0.0006804061,
                                                     -0.0090160696));

N486_9 :=__common__( map(trim(C_RICH_FAM) = ''      => -0.005914378,
              ((real)c_rich_fam < 157.5) => 0.003527045,
                                            -0.005914378));

N486_8 :=__common__( map(trim(C_BORN_USA) = ''      => -0.0051245179,
              ((real)c_born_usa < 176.5) => N486_9,
                                            -0.0051245179));

N486_7 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.0326189398766), 0.0080607938, N486_8));

N486_6 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N486_7, 0.002972645));

N486_5 :=__common__( if(((real)f_rel_incomeover25_count_d < 10.5), 0.0042663706, -0.0018858982));

N486_4 :=__common__( if(((real)f_rel_incomeover25_count_d > NULL), N486_5, 0.01169201));

N486_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N486_4, N486_6));

N486_2 :=__common__( if(((real)c_construction < 2.84999990463), N486_3, N486_10));

N486_1 :=__common__( if(trim(C_CONSTRUCTION) != '', N486_2, 0.00023788839));

N487_11 :=__common__( if(((real)f_rel_incomeover25_count_d < 10.5), 0.0039052702, -0.0047392802));

N487_10 :=__common__( if(((real)f_rel_incomeover25_count_d > NULL), N487_11, 0.0093799299));

N487_9 :=__common__( if(((real)f_rel_under25miles_cnt_d < 6.5), -0.0018639523, 0.0031342156));

N487_8 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N487_9, 0.0054191464));

N487_7 :=__common__( map(trim(C_PRESCHL) = ''     => N487_8,
              ((real)c_preschl < 55.5) => -0.0048986707,
                                          N487_8));

N487_6 :=__common__( map(trim(C_FAMMAR_P) = ''              => N487_7,
              ((real)c_fammar_p < 56.5499992371) => -0.002001238,
                                                    N487_7));

N487_5 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N487_6, N487_10));

N487_4 :=__common__( if(((real)f_rel_felony_count_i < 6.5), N487_5, 0.0058024213));

N487_3 :=__common__( if(((real)f_rel_felony_count_i > NULL), N487_4, -0.0108662));

N487_2 :=__common__( if(((real)c_preschl < 14.5), 0.0057952649, N487_3));

N487_1 :=__common__( if(trim(C_PRESCHL) != '', N487_2, -0.001000239));

N488_10 :=__common__( map(trim(C_INC_50K_P) = ''              => 0.00051630521,
               ((real)c_inc_50k_p < 9.35000038147) => 0.0061183057,
                                                      0.00051630521));

N488_9 :=__common__( map(trim(C_INC_50K_P) = ''              => N488_10,
              ((real)c_inc_50k_p < 5.94999980927) => -0.0057191437,
                                                     N488_10));

N488_8 :=__common__( if(((real)c_inc_150k_p < 0.25), -0.0032561763, N488_9));

N488_7 :=__common__( if(trim(C_INC_150K_P) != '', N488_8, -0.0017734125));

N488_6 :=__common__( if(((real)r_l79_adls_per_addr_curr_i < 39.5), N488_7, 0.0055230881));

N488_5 :=__common__( if(((real)r_l79_adls_per_addr_curr_i > NULL), N488_6, 0.019677134));

N488_4 :=__common__( if(((real)c_business < 36.5), -0.0046232673, 0.0036310386));

N488_3 :=__common__( if(trim(C_BUSINESS) != '', N488_4, -0.012164807));

N488_2 :=__common__( if(((real)f_srchfraudsrchcount_i < 1.5), N488_3, N488_5));

N488_1 :=__common__( if(((real)f_srchfraudsrchcount_i > NULL), N488_2, -0.0034584309));

N489_9 :=__common__( if(((real)c_femdiv_p < 2.34999990463), 0.0097822764, 0.0021720746));

N489_8 :=__common__( if(trim(C_FEMDIV_P) != '', N489_9, 0.015202836));

N489_7 :=__common__( map(((real)c_comb_age_d <= NULL) => 0.00010622201,
              ((real)c_comb_age_d < 28.5)  => N489_8,
                                              0.00010622201));

N489_6 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => N489_7,
              ((real)f_srchssnsrchcount_i < 1.5)   => -0.0020079851,
                                                      N489_7));

N489_5 :=__common__( if(((real)c_inc_75k_p < 21.0499992371), -0.003038434, -0.013708421));

N489_4 :=__common__( if(trim(C_INC_75K_P) != '', N489_5, -0.012558156));

N489_3 :=__common__( map(((real)c_comb_age_d <= NULL) => N489_4,
              ((real)c_comb_age_d < 27.5)  => 0.0035434041,
                                              N489_4));

N489_2 :=__common__( if(((real)r_i60_inq_hiriskcred_recency_d < 4.5), N489_3, N489_6));

N489_1 :=__common__( if(((real)r_i60_inq_hiriskcred_recency_d > NULL), N489_2, 0.0040548036));

N490_9 :=__common__( map(trim(C_LOWINC) = ''              => -0.0062946724,
              ((real)c_lowinc < 23.1500015259) => -0.00037863934,
                                                  -0.0062946724));

N490_8 :=__common__( if(((real)f_addrchangecrimediff_i < 8.5), 0.00069864494, 0.0089617321));

N490_7 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N490_8, 0.0036602202));

N490_6 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => N490_7,
              ((real)f_add_curr_nhood_vac_pct_i < 0.0344111397862) => -0.0016881967,
                                                                      N490_7));

N490_5 :=__common__( map(trim(C_LOWINC) = ''      => -0.0013067104,
              ((real)c_lowinc < 47.25) => N490_6,
                                          -0.0013067104));

N490_4 :=__common__( if(((real)f_inq_other_count24_i < 3.5), N490_5, 0.0047287377));

N490_3 :=__common__( if(((real)f_inq_other_count24_i > NULL), N490_4, -0.001684971));

N490_2 :=__common__( if(((real)c_med_inc < 97.5), N490_3, N490_9));

N490_1 :=__common__( if(trim(C_MED_INC) != '', N490_2, 0.00086203609));

N491_8 :=__common__( if(((real)f_util_adl_count_n < 5.5), 0.002731382, 0.013067881));

N491_7 :=__common__( if(((real)f_util_adl_count_n > NULL), N491_8, 0.012636241));

N491_6 :=__common__( if(((real)c_sfdu_p < 83.5500030518), N491_7, -0.003340013));

N491_5 :=__common__( if(trim(C_SFDU_P) != '', N491_6, 0.0056555127));

N491_4 :=__common__( map(trim(C_FAMMAR18_P) = ''              => -0.00015870372,
              ((real)c_fammar18_p < 2.45000004768) => -0.0054858287,
                                                      -0.00015870372));

N491_3 :=__common__( if(((real)c_white_col < 11.25), 0.0067780655, N491_4));

N491_2 :=__common__( if(trim(C_WHITE_COL) != '', N491_3, 0.0021772838));

N491_1 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => N491_5,
              ((real)f_inq_adls_per_phone_i < 1.5)   => N491_2,
                                                        N491_5));

N492_8 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => 0.0018602103,
              ((real)f_add_input_nhood_vac_pct_i < 0.130191907287) => -0.0023483253,
                                                                      0.0018602103));

N492_7 :=__common__( map(trim(C_FAMMAR_P) = ''              => 0.0015685658,
              ((real)c_fammar_p < 59.1500015259) => N492_8,
                                                    0.0015685658));

N492_6 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d < 3.5), 0.0069502341, N492_7));

N492_5 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N492_6, 0.0011747212));

N492_4 :=__common__( map(trim(C_BEL_EDU) = ''     => 0.0024119493,
              ((real)c_bel_edu < 83.5) => -0.0086358896,
                                          0.0024119493));

N492_3 :=__common__( map(trim(C_POP_65_74_P) = ''              => -0.011075966,
              ((real)c_pop_65_74_p < 1.65000009537) => N492_4,
                                                       -0.011075966));

N492_2 :=__common__( if(((real)c_retired < 3.25), N492_3, N492_5));

N492_1 :=__common__( if(trim(C_RETIRED) != '', N492_2, 0.0042435473));

N493_8 :=__common__( map(trim(C_FEMDIV_P) = ''              => 0.0015820311,
              ((real)c_femdiv_p < 2.15000009537) => 0.0087537195,
                                                    0.0015820311));

N493_7 :=__common__( map(trim(C_HEALTH) = ''              => -0.0037075751,
              ((real)c_health < 27.9500007629) => N493_8,
                                                  -0.0037075751));

N493_6 :=__common__( if(((real)f_addrchangeincomediff_d < -33888.5), 0.010329731, N493_7));

N493_5 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N493_6, 0.00023391162));

N493_4 :=__common__( map(((real)r_s66_adlperssn_count_i <= NULL) => 0.00096233828,
              ((real)r_s66_adlperssn_count_i < 1.5)   => -0.0033698497,
                                                         0.00096233828));

N493_3 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => N493_5,
              ((real)f_rel_felony_count_i < 0.5)   => N493_4,
                                                      N493_5));

N493_2 :=__common__( if(((integer)f_acc_damage_amt_total_i < 425), N493_3, -0.0075201092));

N493_1 :=__common__( if(((real)f_acc_damage_amt_total_i > NULL), N493_2, 0.0059986068));

N494_11 :=__common__( if(((real)c_lowrent < 66.1499938965), -0.0062919348, 0.0049608509));

N494_10 :=__common__( if(trim(C_LOWRENT) != '', N494_11, -0.031409279));

N494_9 :=__common__( map(((real)f_inq_count24_i <= NULL) => N494_10,
              ((real)f_inq_count24_i < 14.5)  => 0.0010728623,
                                                 N494_10));

N494_8 :=__common__( if(((real)f_mos_liens_rel_cj_fseen_d < 65.5), -0.0083013233, N494_9));

N494_7 :=__common__( if(((real)f_mos_liens_rel_cj_fseen_d > NULL), N494_8, 0.002883579));

N494_6 :=__common__( if(((real)f_divrisktype_i < 2.5), 0.00037037626, -0.0079991598));

N494_5 :=__common__( if(((real)f_divrisktype_i > NULL), N494_6, -0.0207941));

N494_4 :=__common__( if(((real)c_no_labfor < 134.5), N494_5, -0.0092917257));

N494_3 :=__common__( if(trim(C_NO_LABFOR) != '', N494_4, -0.0034672924));

N494_2 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0162396281958), N494_3, N494_7));

N494_1 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N494_2, -0.00029320255));

N495_10 :=__common__( if(((real)c_hh7p_p < 7.94999980927), 0.0022062316, -0.0060678857));

N495_9 :=__common__( if(trim(C_HH7P_P) != '', N495_10, 0.0019542355));

N495_8 :=__common__( map(trim(C_POPOVER18) = ''      => -0.01378559,
              ((real)c_popover18 < 512.5) => 0.0006002637,
                                             -0.01378559));

N495_7 :=__common__( if(((real)c_hh00 < 304.5), N495_8, -0.00053314114));

N495_6 :=__common__( if(trim(C_HH00) != '', N495_7, 0.00061158384));

N495_5 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 14.5), N495_6, -0.0096448975));

N495_4 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N495_5, 0.00066490159));

N495_3 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => N495_4,
              ((real)f_srchaddrsrchcount_i < 0.5)   => 0.0034608169,
                                                       N495_4));

N495_2 :=__common__( if(((real)f_inq_other_count24_i < 0.5), N495_3, N495_9));

N495_1 :=__common__( if(((real)f_inq_other_count24_i > NULL), N495_2, -0.0068289648));

N496_9 :=__common__( map(trim(C_OLD_HOMES) = ''     => 0.00035918628,
              ((real)c_old_homes < 73.5) => 0.011019675,
                                            0.00035918628));

N496_8 :=__common__( map(trim(C_RETIRED2) = ''      => -0.00070280706,
              ((real)c_retired2 < 101.5) => 0.0044499523,
                                            -0.00070280706));

N496_7 :=__common__( map(((real)f_inq_per_addr_i <= NULL) => -0.0010344391,
              ((real)f_inq_per_addr_i < 1.5)   => N496_8,
                                                  -0.0010344391));

N496_6 :=__common__( if(((real)c_rnt1000_p < 42.1500015259), N496_7, N496_9));

N496_5 :=__common__( if(trim(C_RNT1000_P) != '', N496_6, -0.016902489));

N496_4 :=__common__( if(((real)f_add_input_nhood_vac_pct_i < 0.0139157343656), -0.0024534519, N496_5));

N496_3 :=__common__( if(((real)f_add_input_nhood_vac_pct_i > NULL), N496_4, 0.018012618));

N496_2 :=__common__( if(((integer)f_liens_unrel_cj_total_amt_i < 5705), N496_3, -0.0040573001));

N496_1 :=__common__( if(((real)f_liens_unrel_cj_total_amt_i > NULL), N496_2, -0.0082415801));

N497_8 :=__common__( map(trim(C_HVAL_300K_P) = ''              => -0.011302961,
              ((real)c_hval_300k_p < 2.45000004768) => 0.00027862643,
                                                       -0.011302961));

N497_7 :=__common__( if(((real)c_bargains < 57.5), N497_8, 0.0012158231));

N497_6 :=__common__( if(trim(C_BARGAINS) != '', N497_7, 0.0029685975));

N497_5 :=__common__( if(((real)c_ab_av_edu < 135.5), -0.0013472948, 0.0073561711));

N497_4 :=__common__( if(trim(C_AB_AV_EDU) != '', N497_5, -0.0015905611));

N497_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d < 22199.5), 0.0043725314, N497_4));

N497_2 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N497_3, N497_6));

N497_1 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.010892925,
              ((real)c_comb_age_d < 62.5)  => N497_2,
                                              -0.010892925));

N498_8 :=__common__( map(trim(C_SPAN_LANG) = ''     => -0.0016767846,
              ((real)c_span_lang < 77.5) => 0.0092279486,
                                            -0.0016767846));

N498_7 :=__common__( map(trim(C_RNT250_P) = ''      => N498_8,
              ((real)c_rnt250_p < 16.75) => 0.014013104,
                                            N498_8));

N498_6 :=__common__( map(trim(C_MORT_INDX) = ''     => N498_7,
              ((real)c_mort_indx < 83.5) => -0.0013140502,
                                            N498_7));

N498_5 :=__common__( if(((real)f_corraddrphonecount_d < 0.5), 0.00082654244, -0.0019878548));

N498_4 :=__common__( if(((real)f_corraddrphonecount_d > NULL), N498_5, -0.0057036062));

N498_3 :=__common__( map(trim(C_RNT1500_P) = ''              => -0.009117208,
              ((real)c_rnt1500_p < 29.8499984741) => N498_4,
                                                     -0.009117208));

N498_2 :=__common__( if(((real)c_assault < 190.5), N498_3, N498_6));

N498_1 :=__common__( if(trim(C_ASSAULT) != '', N498_2, -0.0023840499));

N499_9 :=__common__( if(((real)f_crim_rel_under100miles_cnt_i < 6.5), 6.9812048e-005, -0.0058782172));

N499_8 :=__common__( if(((real)f_crim_rel_under100miles_cnt_i > NULL), N499_9, -0.0084670887));

N499_7 :=__common__( map(((real)f_mos_liens_unrel_lt_lseen_d <= NULL) => N499_8,
              ((real)f_mos_liens_unrel_lt_lseen_d < 136.5) => 0.006051487,
                                                              N499_8));

N499_6 :=__common__( if(((real)f_srchphonesrchcount_i < 4.5), N499_7, -0.005909306));

N499_5 :=__common__( if(((real)f_srchphonesrchcount_i > NULL), N499_6, 0.0091769896));

N499_4 :=__common__( map(trim(C_EXP_PROD) = ''     => 0.0016724481,
              ((real)c_exp_prod < 62.5) => N499_5,
                                           0.0016724481));

N499_3 :=__common__( map(trim(C_RENTOCC_P) = ''              => -0.0081772158,
              ((real)c_rentocc_p < 19.5499992371) => 0.00044067128,
                                                     -0.0081772158));

N499_2 :=__common__( if(((real)c_no_car < 50.5), N499_3, N499_4));

N499_1 :=__common__( if(trim(C_NO_CAR) != '', N499_2, -0.00050382999));

N500_8 :=__common__( map(trim(C_POP00) = ''       => 0.0060166973,
              ((real)c_pop00 < 2236.5) => -0.0034303785,
                                          0.0060166973));

N500_7 :=__common__( map(((real)f_corrssnnamecount_d <= NULL) => -0.005394919,
              ((real)f_corrssnnamecount_d < 8.5)   => 0.0018106637,
                                                      -0.005394919));

N500_6 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL) => N500_8,
              ((real)f_fp_prevaddrburglaryindex_i < 162.5) => N500_7,
                                                              N500_8));

N500_5 :=__common__( map(trim(C_OLD_HOMES) = ''      => -0.0033587806,
              ((real)c_old_homes < 163.5) => N500_6,
                                             -0.0033587806));

N500_4 :=__common__( map(trim(C_EDU_INDX) = ''      => 0.0079594084,
              ((real)c_edu_indx < 136.5) => N500_5,
                                            0.0079594084));

N500_3 :=__common__( if(((real)f_inq_banking_count24_i < 3.5), N500_4, 0.0097422769));

N500_2 :=__common__( if(((real)f_inq_banking_count24_i > NULL), N500_3, 0.0013754165));

N500_1 :=__common__( if(trim(C_EDU_INDX) != '', N500_2, -0.0037653695));

N501_9 :=__common__( map(trim(C_LAR_FAM) = ''      => 0.0020727287,
              ((real)c_lar_fam < 149.5) => -0.0019063825,
                                           0.0020727287));

N501_8 :=__common__( if(((integer)f_prevaddrmedianincome_d < 45564), -0.0064849861, 0.0034032227));

N501_7 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N501_8, 0.0044685411));

N501_6 :=__common__( map(trim(C_VACANT_P) = ''      => 0.0044000297,
              ((real)c_vacant_p < 12.25) => N501_7,
                                            0.0044000297));

N501_5 :=__common__( map(((real)f_addrchangeecontrajindex_d <= NULL) => 0.00036469454,
              ((real)f_addrchangeecontrajindex_d < 1.5)   => 0.005926696,
                                                             0.00036469454));

N501_4 :=__common__( map(trim(C_POP_75_84_P) = ''              => N501_5,
              ((real)c_pop_75_84_p < 1.04999995232) => -0.0047103764,
                                                       N501_5));

N501_3 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N501_4, N501_6));

N501_2 :=__common__( if(((real)c_lar_fam < 93.5), N501_3, N501_9));

N501_1 :=__common__( if(trim(C_LAR_FAM) != '', N501_2, -0.0023064214));

N502_8 :=__common__( map(((real)c_mos_since_impulse_fs_d <= NULL) => 0.0025554081,
              ((real)c_mos_since_impulse_fs_d < 55.5)  => 0.010281344,
                                                          0.0025554081));

N502_7 :=__common__( if(((real)r_c14_addr_stability_v2_d < 4.5), N502_8, 0.00019113115));

N502_6 :=__common__( if(((real)r_c14_addr_stability_v2_d > NULL), N502_7, 0.0039596114));

N502_5 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => 0.007362537,
              ((real)r_c14_addrs_15yr_i < 19.5)  => -0.0015385378,
                                                    0.007362537));

N502_4 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => N502_6,
              ((real)r_c13_max_lres_d < 77.5)  => N502_5,
                                                  N502_6));

N502_3 :=__common__( map(((real)f_srchaddrsrchcountwk_i <= NULL) => -0.005162089,
              ((real)f_srchaddrsrchcountwk_i < 0.5)   => N502_4,
                                                         -0.005162089));

N502_2 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d < 0.00225314171985), -0.0077954365, N502_3));

N502_1 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d > NULL), N502_2, -0.033479597));

N503_8 :=__common__( map(trim(C_LARCENY) = ''      => -0.0063091314,
              ((real)c_larceny < 180.5) => 0.0022051241,
                                           -0.0063091314));

N503_7 :=__common__( map(trim(C_RENTAL) = ''      => 0.011385783,
              ((real)c_rental < 191.5) => N503_8,
                                          0.011385783));

N503_6 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => 0.0063145768,
              ((real)f_inq_per_ssn_i < 7.5)   => -0.0015209214,
                                                 0.0063145768));

N503_5 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => N503_6,
              (segment in ['SEARS FLS'])                                  => N503_7,
                                                                             N503_6));

N503_4 :=__common__( if(((real)r_i60_inq_hiriskcred_count12_i < 5.5), N503_5, -0.0054186034));

N503_3 :=__common__( if(((real)r_i60_inq_hiriskcred_count12_i > NULL), N503_4, 0.0048083052));

N503_2 :=__common__( if(((real)c_rest_indx < 169.5), N503_3, 0.0077778659));

N503_1 :=__common__( if(trim(C_REST_INDX) != '', N503_2, 0.003257201));

N504_8 :=__common__( map(trim(C_UNEMPL) = ''     => 0.003732123,
              ((real)c_unempl < 53.5) => -0.0068351752,
                                         0.003732123));

N504_7 :=__common__( map(((real)f_corraddrphonecount_d <= NULL) => -0.0034107498,
              ((real)f_corraddrphonecount_d < 0.5)   => N504_8,
                                                        -0.0034107498));

N504_6 :=__common__( map(((real)f_inq_per_phone_i <= NULL) => 0.011545662,
              ((real)f_inq_per_phone_i < 1.5)   => N504_7,
                                                   0.011545662));

N504_5 :=__common__( map(((real)r_i60_inq_count12_i <= NULL) => 3.1916255e-005,
              ((real)r_i60_inq_count12_i < 1.5)   => N504_6,
                                                     3.1916255e-005));

N504_4 :=__common__( if(((real)c_rnt2001_p < 3.34999990463), N504_5, -0.0054695927));

N504_3 :=__common__( if(trim(C_RNT2001_P) != '', N504_4, 0.00022581963));

N504_2 :=__common__( if(((real)f_inputaddractivephonelist_d < 0.5), N504_3, -0.0025152102));

N504_1 :=__common__( if(((real)f_inputaddractivephonelist_d > NULL), N504_2, 0.0040797345));

N505_9 :=__common__( map(trim(C_MED_AGE) = ''              => -0.0044411508,
              ((real)c_med_age < 28.8499984741) => 0.0043980005,
                                                   -0.0044411508));

N505_8 :=__common__( map(((real)c_addr_lres_12mo_ct_i <= NULL) => N505_9,
              ((real)c_addr_lres_12mo_ct_i < 2.5)   => 0.0040797171,
                                                       N505_9));

N505_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0464111715555), N505_8, -0.0046354328));

N505_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N505_7, 0.0036441301));

N505_5 :=__common__( map(((real)r_i61_inq_collection_count12_i <= NULL) => 0.0023573784,
              ((real)r_i61_inq_collection_count12_i < 0.5)   => N505_6,
                                                                0.0023573784));

N505_4 :=__common__( if(((real)r_a50_pb_average_dollars_d < 12.5), 0.0059163457, N505_5));

N505_3 :=__common__( if(((real)r_a50_pb_average_dollars_d > NULL), N505_4, 7.4925424e-005));

N505_2 :=__common__( if(((integer)c_medi_indx < 89), 0.0012663782, N505_3));

N505_1 :=__common__( if(trim(C_MEDI_INDX) != '', N505_2, -0.00071119515));

N506_8 :=__common__( map(trim(C_POPOVER25) = ''       => 0.0025949712,
              ((real)c_popover25 < 1022.5) => -0.004066255,
                                              0.0025949712));

N506_7 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => N506_8,
              ((real)r_c21_m_bureau_adl_fs_d < 47.5)  => 0.0077928583,
                                                         N506_8));

N506_6 :=__common__( map(trim(C_RAPE) = ''      => -0.0066161841,
              ((integer)c_rape < 48) => 0.0023780624,
                                        -0.0066161841));

N506_5 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => N506_7,
              ((real)r_d30_derog_count_i < 0.5)   => N506_6,
                                                     N506_7));

N506_4 :=__common__( if(((real)c_hval_200k_p < 16.9500007629), N506_5, 0.0076237712));

N506_3 :=__common__( if(trim(C_HVAL_200K_P) != '', N506_4, 0.0013248524));

N506_2 :=__common__( if(((real)r_c10_m_hdr_fs_d < 137.5), N506_3, 0.00071550442));

N506_1 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N506_2, -0.00064302987));

N507_7 :=__common__( map(trim(C_BARGAINS) = ''     => -0.0063960559,
              ((real)c_bargains < 95.5) => 0.003038871,
                                           -0.0063960559));

N507_6 :=__common__( map(trim(C_POP00) = ''        => 0.004043582,
              ((integer)c_pop00 < 1063) => -0.0013143043,
                                           0.004043582));

N507_5 :=__common__( map(trim(C_RICH_FAM) = ''      => N507_7,
              ((real)c_rich_fam < 100.5) => N507_6,
                                            N507_7));

N507_4 :=__common__( map(trim(C_RAPE) = ''     => N507_5,
              ((real)c_rape < 92.5) => 0.0052411117,
                                       N507_5));

N507_3 :=__common__( map(trim(C_HH4_P) = ''      => -0.00094178763,
              ((real)c_hh4_p < 10.25) => N507_4,
                                         -0.00094178763));

N507_2 :=__common__( if(((real)c_transport < 33.9499969482), N507_3, 0.0081932224));

N507_1 :=__common__( if(trim(C_TRANSPORT) != '', N507_2, -0.0013351224));

N508_9 :=__common__( if(((real)f_rel_under25miles_cnt_d < 12.5), -0.0011330499, 0.003715037));

N508_8 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N508_9, 0.025497135));

N508_7 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => N508_8,
              ((real)r_c14_addrs_10yr_i < 6.5)   => -0.0022090113,
                                                    N508_8));

N508_6 :=__common__( map(trim(C_HVAL_175K_P) = ''              => -0.010035095,
              ((real)c_hval_175k_p < 8.14999961853) => -0.00055542496,
                                                       -0.010035095));

N508_5 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 240.5), N508_6, N508_7));

N508_4 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N508_5, -0.0011890863));

N508_3 :=__common__( map(trim(C_PROFESSIONAL) = ''     => 0.0028587566,
              ((real)c_professional < 8.75) => N508_4,
                                               0.0028587566));

N508_2 :=__common__( if(((real)c_assault < 186.5), N508_3, 0.0028982442));

N508_1 :=__common__( if(trim(C_ASSAULT) != '', N508_2, 0.0023094238));

N509_9 :=__common__( map(trim(C_RETAIL) = ''              => -0.0033827907,
              ((real)c_retail < 9.55000019073) => 0.012347275,
                                                  -0.0033827907));

N509_8 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => 3.0167851e-005,
              ((real)r_c13_max_lres_d < 51.5)  => -0.0027276439,
                                                  3.0167851e-005));

N509_7 :=__common__( map(trim(C_RICH_NFAM) = ''      => N509_9,
              ((real)c_rich_nfam < 182.5) => N509_8,
                                             N509_9));

N509_6 :=__common__( if(((real)f_rel_under100miles_cnt_d > NULL), N509_7, 0.0029153117));

N509_5 :=__common__( if(((real)c_hval_60k_p < 44.9500007629), N509_6, 0.0071508672));

N509_4 :=__common__( if(trim(C_HVAL_60K_P) != '', N509_5, 0.0025646445));

N509_3 :=__common__( map(((real)r_mos_since_paw_fseen_d <= NULL) => 0.0071059115,
              ((real)r_mos_since_paw_fseen_d < 96.5)  => N509_4,
                                                         0.0071059115));

N509_2 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d < 0.00197740131989), -0.0089015899, N509_3));

N509_1 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d > NULL), N509_2, 0.0044581564));

N510_8 :=__common__( if(((real)r_c13_max_lres_d < 89.5), -0.0038557157, 0.012060989));

N510_7 :=__common__( if(((real)r_c13_max_lres_d > NULL), N510_8, 0.00039552226));

N510_6 :=__common__( map(trim(C_POP_6_11_P) = ''              => N510_7,
              ((real)c_pop_6_11_p < 12.1499996185) => -0.0045189408,
                                                      N510_7));

N510_5 :=__common__( map(trim(C_ASIAN_LANG) = ''      => 0.0019675636,
              ((real)c_asian_lang < 158.5) => N510_6,
                                              0.0019675636));

N510_4 :=__common__( map(trim(C_CIV_EMP) = ''              => N510_5,
              ((real)c_civ_emp < 47.5499992371) => 0.0040122992,
                                                   N510_5));

N510_3 :=__common__( map(trim(C_BORN_USA) = ''      => 0.00099542936,
              ((real)c_born_usa < 116.5) => N510_4,
                                            0.00099542936));

N510_2 :=__common__( if(((real)c_pop_65_74_p < 0.649999976158), 0.0058675117, N510_3));

N510_1 :=__common__( if(trim(C_POP_65_74_P) != '', N510_2, 0.0032576954));

N511_7 :=__common__( map(trim(C_WHITE_COL) = ''              => 0.0099821971,
              ((real)c_white_col < 45.5499992371) => 0.00010719922,
                                                     0.0099821971));

N511_6 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => -0.011259822,
              ((real)f_add_input_mobility_index_n < 0.275971621275) => 0.00033790863,
                                                                       -0.011259822));

N511_5 :=__common__( map(trim(C_OCCUNIT_P) = ''              => -0.00071582702,
              ((real)c_occunit_p < 88.0500030518) => N511_6,
                                                     -0.00071582702));

N511_4 :=__common__( map(trim(C_NO_CAR) = ''      => N511_7,
              ((real)c_no_car < 102.5) => N511_5,
                                          N511_7));

N511_3 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => 0.0096345315,
              ((real)f_add_input_nhood_vac_pct_i < 0.0108422078192) => -0.0013895719,
                                                                       0.0096345315));

N511_2 :=__common__( if(((real)c_murders < 30.5), N511_3, N511_4));

N511_1 :=__common__( if(trim(C_MURDERS) != '', N511_2, 0.003353741));

N512_9 :=__common__( if(((real)c_oldhouse < 113.050003052), 0.0027535151, -0.0032703091));

N512_8 :=__common__( if(trim(C_OLDHOUSE) != '', N512_9, 0.0011138032));

N512_7 :=__common__( map(((real)f_estimated_income_d <= NULL)    => 0.001010757,
              ((integer)f_estimated_income_d < 29500) => N512_8,
                                                         0.001010757));

N512_6 :=__common__( map(trim(C_RNT1000_P) = ''              => 0.00089319268,
              ((real)c_rnt1000_p < 8.05000019073) => 0.0098143612,
                                                     0.00089319268));

N512_5 :=__common__( if(((real)c_inc_125k_p < 8.85000038147), N512_6, -0.0049840616));

N512_4 :=__common__( if(trim(C_INC_125K_P) != '', N512_5, 0.029906517));

N512_3 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL) => N512_7,
              ((integer)r_d33_eviction_recency_d < 30) => N512_4,
                                                          N512_7));

N512_2 :=__common__( if(((real)f_mos_liens_rel_ot_fseen_d < 18.5), N512_3, -0.0059523173));

N512_1 :=__common__( if(((real)f_mos_liens_rel_ot_fseen_d > NULL), N512_2, -0.0023187717));

N513_9 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => 0.0016045864,
              ((real)c_hist_addr_match_i < 4.5)   => -0.0017506198,
                                                     0.0016045864));

N513_8 :=__common__( map(((real)f_mos_liens_unrel_cj_lseen_d <= NULL) => -0.003181214,
              ((real)f_mos_liens_unrel_cj_lseen_d < 38.5)  => 0.0066862785,
                                                              -0.003181214));

N513_7 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.010403607,
              ((real)r_d32_criminal_count_i < 6.5)   => 0.0022691061,
                                                        0.010403607));

N513_6 :=__common__( map(trim(C_HVAL_125K_P) = ''      => N513_8,
              ((real)c_hval_125k_p < 14.25) => N513_7,
                                               N513_8));

N513_5 :=__common__( if(((real)f_rel_ageover30_count_d < 7.5), N513_6, N513_9));

N513_4 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N513_5, -0.0044270928));

N513_3 :=__common__( if(trim(C_NEWHOUSE) != '', N513_4, 0.0012280747));

N513_2 :=__common__( if(((real)r_d33_eviction_count_i < 8.5), N513_3, -0.0073367699));

N513_1 :=__common__( if(((real)r_d33_eviction_count_i > NULL), N513_2, 0.001369805));

N514_8 :=__common__( map(trim(C_RETIRED2) = ''     => -0.0013385116,
              ((real)c_retired2 < 84.5) => 0.0069458841,
                                           -0.0013385116));

N514_7 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N514_8,
              ((real)f_sourcerisktype_i < 3.5)   => 0.01200663,
                                                    N514_8));

N514_6 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => -0.006045946,
              ((real)f_mos_inq_banko_cm_fseen_d < 44.5)  => 0.0044798893,
                                                            -0.006045946));

N514_5 :=__common__( map(trim(C_POP_85P_P) = ''               => N514_7,
              ((real)c_pop_85p_p < 0.449999988079) => N514_6,
                                                      N514_7));

N514_4 :=__common__( if(((real)c_easiqlife < 127.5), N514_5, -0.0055102626));

N514_3 :=__common__( if(trim(C_EASIQLIFE) != '', N514_4, 0.0012095336));

N514_2 :=__common__( if(((real)f_rel_bankrupt_count_i < 2.5), 0.00085766472, N514_3));

N514_1 :=__common__( if(((real)f_rel_bankrupt_count_i > NULL), N514_2, -0.0027156999));

N515_9 :=__common__( map(trim(C_INC_25K_P) = ''              => 0.0049256487,
              ((real)c_inc_25k_p < 21.4500007629) => -4.2721913e-005,
                                                     0.0049256487));

N515_8 :=__common__( map(((real)c_nap_lname_verd_d <= NULL) => -0.00029800978,
              ((real)c_nap_lname_verd_d < 0.5)   => -0.007477401,
                                                    -0.00029800978));

N515_7 :=__common__( if(((real)f_mos_acc_lseen_d < 310.5), N515_8, N515_9));

N515_6 :=__common__( if(((real)f_mos_acc_lseen_d > NULL), N515_7, -0.0050837346));

N515_5 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => -0.0041678203,
              ((real)r_d32_mos_since_crim_ls_d < 136.5) => 0.0050543832,
                                                           -0.0041678203));

N515_4 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i < 159.5), N515_5, -0.0080092191));

N515_3 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i > NULL), N515_4, 0.013406309));

N515_2 :=__common__( if(((real)c_ownocc_p < 22.9500007629), N515_3, N515_6));

N515_1 :=__common__( if(trim(C_OWNOCC_P) != '', N515_2, -0.0027442843));

N516_11 :=__common__( if(((real)f_rel_under25miles_cnt_d < 14.5), 0.002045752, 0.012107088));

N516_10 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N516_11, -0.035572425));

N516_9 :=__common__( if(((real)c_fammar18_p < 16.8499984741), -0.0035931502, N516_10));

N516_8 :=__common__( if(trim(C_FAMMAR18_P) != '', N516_9, -0.0035594031));

N516_7 :=__common__( if(((real)f_rel_incomeover50_count_d < 5.5), 0.001281197, -0.001940678));

N516_6 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N516_7, 0.00018315206));

N516_5 :=__common__( map(((real)r_e55_college_ind_d <= NULL) => -0.0064699904,
              ((real)r_e55_college_ind_d < 0.5)   => N516_6,
                                                     -0.0064699904));

N516_4 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i < 119.050003052), 0.00055188752, -0.0055803327));

N516_3 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N516_4, N516_5));

N516_2 :=__common__( if(((real)c_addr_lres_6mo_ct_i < 8.5), N516_3, N516_8));

N516_1 :=__common__( if(((real)c_addr_lres_6mo_ct_i > NULL), N516_2, -0.01021707));

N517_10 :=__common__( map(trim(C_SUB_BUS) = ''      => -0.01094026,
               ((real)c_sub_bus < 129.5) => -0.00049501923,
                                            -0.01094026));

N517_9 :=__common__( map(trim(C_HHSIZE) = ''              => -1.497668e-005,
              ((real)c_hhsize < 1.84500002861) => 0.0072420625,
                                                  -1.497668e-005));

N517_8 :=__common__( map(((real)r_i60_inq_hiriskcred_count12_i <= NULL) => N517_10,
              ((real)r_i60_inq_hiriskcred_count12_i < 5.5)   => N517_9,
                                                                N517_10));

N517_7 :=__common__( if(trim(C_HVAL_60K_P) != '', N517_8, 0.002905779));

N517_6 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d < 0.00506776850671), -0.0082984461, N517_7));

N517_5 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d > NULL), N517_6, -0.0081749589));

N517_4 :=__common__( if(((real)c_incollege < 5.64999961853), 0.00076823418, 0.0097580053));

N517_3 :=__common__( if(trim(C_INCOLLEGE) != '', N517_4, -0.0068340709));

N517_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 7.5), N517_3, N517_5));

N517_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N517_2, 0.002559378));

N518_8 :=__common__( map(trim(C_INC_75K_P) = ''      => -0.0088130335,
              ((real)c_inc_75k_p < 26.25) => -0.00068339793,
                                             -0.0088130335));

N518_7 :=__common__( if(((real)c_hval_125k_p < 24.9500007629), N518_8, 0.0046740139));

N518_6 :=__common__( if(trim(C_HVAL_125K_P) != '', N518_7, 0.0013607912));

N518_5 :=__common__( map(trim(C_FAMOTF18_P) = ''      => -0.010356324,
              ((real)c_famotf18_p < 44.25) => -0.00068851953,
                                              -0.010356324));

N518_4 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.0071983319,
              ((real)r_d32_criminal_count_i < 8.5)   => 0.00092924288,
                                                        0.0071983319));

N518_3 :=__common__( map(((real)f_rel_criminal_count_i <= NULL) => N518_5,
              ((real)f_rel_criminal_count_i < 9.5)   => N518_4,
                                                        N518_5));

N518_2 :=__common__( map(((real)f_estimated_income_d <= NULL)    => N518_3,
              ((integer)f_estimated_income_d < 21500) => -0.0074240298,
                                                         N518_3));

N518_1 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N518_2, N518_6));

N519_9 :=__common__( map(trim(C_HVAL_150K_P) = ''              => -0.01163792,
              ((real)c_hval_150k_p < 3.95000004768) => -0.0028225924,
                                                       -0.01163792));

N519_8 :=__common__( if(((real)c_rentocc_p < 20.4500007629), 0.0019086467, N519_9));

N519_7 :=__common__( if(trim(C_RENTOCC_P) != '', N519_8, -0.0022457764));

N519_6 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => N519_7,
              ((real)f_corrssnaddrcount_d < 0.5)   => 0.0015754743,
                                                      N519_7));

N519_5 :=__common__( map(trim(C_RETAIL) = ''              => 0.0079856982,
              ((real)c_retail < 49.1999969482) => -0.00011275071,
                                                  0.0079856982));

N519_4 :=__common__( if(((real)c_hval_150k_p < 32.8499984741), N519_5, 0.0083577691));

N519_3 :=__common__( if(trim(C_HVAL_150K_P) != '', N519_4, -0.0032544129));

N519_2 :=__common__( if(((real)f_idverrisktype_i < 5.5), N519_3, N519_6));

N519_1 :=__common__( if(((real)f_idverrisktype_i > NULL), N519_2, 0.0086407761));

N520_10 :=__common__( if(((real)c_unemp < 10.3500003815), 0.00265816, -0.0059113288));

N520_9 :=__common__( if(trim(C_UNEMP) != '', N520_10, 0.0010511595));

N520_8 :=__common__( if(((real)f_rel_ageover30_count_d < 3.5), 0.012321552, N520_9));

N520_7 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N520_8, -0.025143156));

N520_6 :=__common__( map(((real)c_addr_lres_6mo_ct_i <= NULL) => -0.0018596621,
              ((real)c_addr_lres_6mo_ct_i < 1.5)   => 0.0011707504,
                                                      -0.0018596621));

N520_5 :=__common__( map(((real)r_c20_email_domain_free_count_i <= NULL) => -0.0032195202,
              ((real)r_c20_email_domain_free_count_i < 1.5)   => 0.0077601226,
                                                                 -0.0032195202));

N520_4 :=__common__( if(((real)c_no_teens < 7.5), N520_5, N520_6));

N520_3 :=__common__( if(trim(C_NO_TEENS) != '', N520_4, -0.0067113145));

N520_2 :=__common__( if(((real)r_i61_inq_collection_count12_i < 0.5), N520_3, N520_7));

N520_1 :=__common__( if(((real)r_i61_inq_collection_count12_i > NULL), N520_2, -0.0026267508));

N521_8 :=__common__( map(trim(C_PRESCHL) = ''      => 0.00045636361,
              ((real)c_preschl < 125.5) => 0.01337084,
                                           0.00045636361));

N521_7 :=__common__( if(((real)r_i60_inq_hiriskcred_recency_d < 61.5), -0.0014051463, 0.0017752178));

N521_6 :=__common__( if(((real)r_i60_inq_hiriskcred_recency_d > NULL), N521_7, 0.0060916858));

N521_5 :=__common__( map(trim(C_ARMFORCE) = ''      => N521_8,
              ((real)c_armforce < 171.5) => N521_6,
                                            N521_8));

N521_4 :=__common__( map(trim(C_FAMOTF18_P) = ''              => N521_5,
              ((real)c_famotf18_p < 12.0500001907) => -0.0019798541,
                                                      N521_5));

N521_3 :=__common__( map(trim(C_INC_75K_P) = ''              => 0.0070417485,
              ((real)c_inc_75k_p < 31.3499984741) => N521_4,
                                                     0.0070417485));

N521_2 :=__common__( if(((real)c_finance < 19.4500007629), N521_3, 0.0079753708));

N521_1 :=__common__( if(trim(C_FINANCE) != '', N521_2, 0.0013560713));

N522_9 :=__common__( if(((real)c_hh00 < 440.5), -0.0022360185, 0.0079902302));

N522_8 :=__common__( if(trim(C_HH00) != '', N522_9, 0.0023059157));

N522_7 :=__common__( if(((real)f_corraddrnamecount_d < 6.5), -0.0022987844, N522_8));

N522_6 :=__common__( if(((real)f_corraddrnamecount_d > NULL), N522_7, -0.0070788298));

N522_5 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => 0.0052006439,
              ((real)f_mos_inq_banko_cm_lseen_d < 17.5)  => -0.003310568,
                                                            0.0052006439));

N522_4 :=__common__( map(((real)r_f03_input_add_not_most_rec_i <= NULL) => N522_5,
              ((real)r_f03_input_add_not_most_rec_i < 0.5)   => -0.00067598597,
                                                                N522_5));

N522_3 :=__common__( map(((real)f_addrchangevaluediff_d <= NULL)      => N522_4,
              ((integer)f_addrchangevaluediff_d < -160752) => -0.0091545248,
                                                              N522_4));

N522_2 :=__common__( map(trim(C_CHILD) = ''              => 0.0093528815,
              ((real)c_child < 39.5499992371) => N522_3,
                                                 0.0093528815));

N522_1 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N522_2, N522_6));

N523_8 :=__common__( if(((real)f_liens_unrel_o_total_amt_i < 1848.5), 0.00035399933, -0.0088574501));

N523_7 :=__common__( if(((real)f_liens_unrel_o_total_amt_i > NULL), N523_8, 0.001056317));

N523_6 :=__common__( map(trim(C_HVAL_60K_P) = ''              => -0.005550782,
              ((real)c_hval_60k_p < 17.8499984741) => 0.0037154154,
                                                      -0.005550782));

N523_5 :=__common__( map(trim(C_ASSAULT) = ''       => N523_6,
              ((integer)c_assault < 105) => -0.0066335375,
                                            N523_6));

N523_4 :=__common__( map(((real)f_inq_per_phone_i <= NULL) => -0.0090443559,
              ((real)f_inq_per_phone_i < 1.5)   => N523_5,
                                                   -0.0090443559));

N523_3 :=__common__( map(trim(C_EASIQLIFE) = ''     => N523_7,
              ((real)c_easiqlife < 64.5) => N523_4,
                                            N523_7));

N523_2 :=__common__( if(((real)c_serv_empl < 192.5), N523_3, 0.0055040245));

N523_1 :=__common__( if(trim(C_SERV_EMPL) != '', N523_2, 0.0029137425));

N524_9 :=__common__( map(((real)f_varmsrcssnunrelcount_i <= NULL) => 0.007570666,
              ((real)f_varmsrcssnunrelcount_i < 2.5)   => 0.00064879343,
                                                          0.007570666));

N524_8 :=__common__( map(((real)f_inq_count24_i <= NULL) => -0.010198519,
              ((real)f_inq_count24_i < 4.5)   => 0.0010815734,
                                                 -0.010198519));

N524_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.00550855789334), N524_8, N524_9));

N524_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N524_7, 0.00050062297));

N524_5 :=__common__( if(trim(C_HH4_P) != '', N524_6, 0.0038214516));

N524_4 :=__common__( map(((real)f_liens_unrel_o_total_amt_i <= NULL)  => -0.0057328489,
              ((integer)f_liens_unrel_o_total_amt_i < 786) => N524_5,
                                                              -0.0057328489));

N524_3 :=__common__( map(((real)r_c20_email_domain_isp_count_i <= NULL) => -0.0063428739,
              ((real)r_c20_email_domain_isp_count_i < 4.5)   => N524_4,
                                                                -0.0063428739));

N524_2 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 11.5), 0.0079838842, N524_3));

N524_1 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N524_2, -0.0044947733));

N525_10 :=__common__( if(((real)c_rnt750_p < 26.1500015259), 0.016684124, 0.0050306308));

N525_9 :=__common__( if(trim(C_RNT750_P) != '', N525_10, -0.030371914));

N525_8 :=__common__( if(((real)r_c14_addr_stability_v2_d < 3.5), N525_9, 0.0014016491));

N525_7 :=__common__( if(((real)r_c14_addr_stability_v2_d > NULL), N525_8, 0.019846382));

N525_6 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)          => 0.0005728417,
              ((real)f_add_input_nhood_sfd_pct_d < 0.648306012154) => N525_7,
                                                                      0.0005728417));

N525_5 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N525_6, 0.0026733631));

N525_4 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.00026258972,
              ((real)f_corrssnaddrcount_d < 2.5)   => N525_5,
                                                      -0.00026258972));

N525_3 :=__common__( if(((real)f_college_income_d > NULL), 0.0081502977, -0.009029874));

N525_2 :=__common__( if(((real)f_corrssnnamecount_d < 1.5), N525_3, N525_4));

N525_1 :=__common__( if(((real)f_corrssnnamecount_d > NULL), N525_2, 0.0067390985));

N526_8 :=__common__( map(trim(C_HH5_P) = ''              => -0.01143355,
              ((real)c_hh5_p < 1.84999990463) => -0.0027986069,
                                                 -0.01143355));

N526_7 :=__common__( if(((integer)f_prevaddrmedianvalue_d < 84858), -0.0047969505, 0.0051210505));

N526_6 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N526_7, -0.032862149));

N526_5 :=__common__( map(trim(C_RETIRED) = ''     => N526_8,
              ((real)c_retired < 7.75) => N526_6,
                                          N526_8));

N526_4 :=__common__( map(trim(C_MORT_INDX) = ''      => 0.0031102748,
              ((real)c_mort_indx < 118.5) => N526_5,
                                             0.0031102748));

N526_3 :=__common__( map(trim(C_SERV_EMPL) = ''     => 0.00040687797,
              ((real)c_serv_empl < 12.5) => 0.0082489989,
                                            0.00040687797));

N526_2 :=__common__( if(((integer)c_totcrime < 189), N526_3, N526_4));

N526_1 :=__common__( if(trim(C_TOTCRIME) != '', N526_2, 0.0038836484));

N527_9 :=__common__( map(trim(C_HVAL_300K_P) = ''              => 0.0050480253,
              ((real)c_hval_300k_p < 4.44999980927) => -0.0026589625,
                                                       0.0050480253));

N527_8 :=__common__( if(((real)f_rel_homeover200_count_d < 1.5), N527_9, -0.0060283415));

N527_7 :=__common__( if(((real)f_rel_homeover200_count_d > NULL), N527_8, 0.0057468212));

N527_6 :=__common__( map(((real)f_corraddrnamecount_d <= NULL) => 0.0012705215,
              ((real)f_corraddrnamecount_d < 6.5)   => N527_7,
                                                       0.0012705215));

N527_5 :=__common__( map(trim(C_EASIQLIFE) = ''      => -0.0008272831,
              ((real)c_easiqlife < 123.5) => 0.0056295324,
                                             -0.0008272831));

N527_4 :=__common__( if(((real)c_med_age < 29.25), N527_5, N527_6));

N527_3 :=__common__( if(trim(C_MED_AGE) != '', N527_4, -0.0022888588));

N527_2 :=__common__( if(((real)f_corrssnaddrcount_d < 2.5), 0.00200026, N527_3));

N527_1 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N527_2, 0.0059693603));

N528_12 :=__common__( if(((real)f_prevaddrmedianincome_d < 43832.5), -0.0065027481, 0.002115378));

N528_11 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N528_12, -0.0069423629));

N528_10 :=__common__( if(((real)c_newhouse < 4.14999961853), 0.004474116, N528_11));

N528_9 :=__common__( if(trim(C_NEWHOUSE) != '', N528_10, -0.0021576903));

N528_8 :=__common__( map(((real)c_inf_phn_verd_d <= NULL) => -0.0050767345,
              ((real)c_inf_phn_verd_d < 0.5)   => 0.0023369129,
                                                  -0.0050767345));

N528_7 :=__common__( if(((real)c_relig_indx < 166.5), N528_8, 0.0077894756));

N528_6 :=__common__( if(trim(C_RELIG_INDX) != '', N528_7, -0.011118603));

N528_5 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N528_6, 0.0022702391));

N528_4 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => -0.0008452554,
              ((real)f_m_bureau_adl_fs_all_d < 43.5)  => -0.0071740637,
                                                         -0.0008452554));

N528_3 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N528_4, -0.00014491678));

N528_2 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.444089174271), N528_3, N528_5));

N528_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N528_2, N528_9));

N529_8 :=__common__( map(trim(C_OLDHOUSE) = ''              => -0.011500879,
              ((real)c_oldhouse < 114.599998474) => -0.00086922898,
                                                    -0.011500879));

N529_7 :=__common__( map(((real)c_dist_input_to_prev_addr_i <= NULL) => 0.0047890568,
              ((real)c_dist_input_to_prev_addr_i < 5.5)   => -0.0039192497,
                                                             0.0047890568));

N529_6 :=__common__( map(((real)c_comb_age_d <= NULL) => N529_7,
              ((real)c_comb_age_d < 28.5)  => 0.0080685146,
                                              N529_7));

N529_5 :=__common__( map(trim(C_ASIAN_LANG) = ''      => N529_6,
              ((real)c_asian_lang < 158.5) => -0.00055174968,
                                              N529_6));

N529_4 :=__common__( map(trim(C_BLUE_EMPL) = ''      => N529_8,
              ((real)c_blue_empl < 182.5) => N529_5,
                                             N529_8));

N529_3 :=__common__( if(((real)c_blue_col < 25.9500007629), N529_4, 0.0062580375));

N529_2 :=__common__( if(trim(C_BLUE_COL) != '', N529_3, 0.0040073737));

N529_1 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N529_2, 0.0081018103));

N530_7 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => -0.0022644336,
              ((real)f_inq_adls_per_phone_i < 0.5)   => 0.00056458945,
                                                        -0.0022644336));

N530_6 :=__common__( if(((real)f_mos_liens_rel_cj_lseen_d < 65.5), -0.0065496504, N530_7));

N530_5 :=__common__( if(((real)f_mos_liens_rel_cj_lseen_d > NULL), N530_6, -0.0054796585));

N530_4 :=__common__( map(trim(C_LOW_HVAL) = ''              => 0.0072032658,
              ((real)c_low_hval < 77.9499969482) => N530_5,
                                                    0.0072032658));

N530_3 :=__common__( if(((real)c_span_lang < 192.5), N530_4, -0.0086898872));

N530_2 :=__common__( if(trim(C_SPAN_LANG) != '', N530_3, -0.0059025909));

N530_1 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => 0.0039474438,
              ((real)f_inq_adls_per_phone_i < 1.5)   => N530_2,
                                                        0.0039474438));

N531_8 :=__common__( map(trim(C_EXP_PROD) = ''      => -0.0021499155,
              ((real)c_exp_prod < 102.5) => 0.0089823407,
                                            -0.0021499155));

N531_7 :=__common__( map(trim(C_HH5_P) = ''              => N531_8,
              ((real)c_hh5_p < 3.54999995232) => 0.014249245,
                                                 N531_8));

N531_6 :=__common__( if(((real)c_larceny < 148.5), N531_7, -0.00089077196));

N531_5 :=__common__( if(trim(C_LARCENY) != '', N531_6, 0.0043070998));

N531_4 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL)    => -0.0092243746,
              ((integer)f_liens_unrel_cj_total_amt_i < 11116) => 0.00082462641,
                                                                 -0.0092243746));

N531_3 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => N531_4,
              ((integer)f_curraddrcartheftindex_i < 94) => -0.0026308198,
                                                           N531_4));

N531_2 :=__common__( if(((real)f_assoccredbureaucount_i < 3.5), N531_3, N531_5));

N531_1 :=__common__( if(((real)f_assoccredbureaucount_i > NULL), N531_2, -0.01151001));

N532_7 :=__common__( map(trim(C_HH1_P) = ''              => -0.010010085,
              ((real)c_hh1_p < 25.3499984741) => -9.793176e-005,
                                                 -0.010010085));

N532_6 :=__common__( map(trim(C_HH1_P) = ''              => 0.0017478255,
              ((real)c_hh1_p < 26.0499992371) => N532_7,
                                                 0.0017478255));

N532_5 :=__common__( map(trim(C_APT20) = ''      => -0.0059957414,
              ((real)c_apt20 < 181.5) => N532_6,
                                         -0.0059957414));

N532_4 :=__common__( map(trim(C_HVAL_80K_P) = ''              => 0.0016115763,
              ((real)c_hval_80k_p < 17.3999996185) => -0.0088912551,
                                                      0.0016115763));

N532_3 :=__common__( map(trim(C_CIV_EMP) = ''              => N532_5,
              ((real)c_civ_emp < 38.1500015259) => N532_4,
                                                   N532_5));

N532_2 :=__common__( if(((real)c_serv_empl < 192.5), N532_3, 0.0053729002));

N532_1 :=__common__( if(trim(C_SERV_EMPL) != '', N532_2, -0.0018055707));

N533_9 :=__common__( if(((real)c_born_usa < 74.5), -0.0080144551, 0.00025368513));

N533_8 :=__common__( if(trim(C_BORN_USA) != '', N533_9, -0.017293304));

N533_7 :=__common__( if(((real)f_prevaddrstatus_i > NULL), 0.0013950975, N533_8));

N533_6 :=__common__( map(((real)f_liens_unrel_o_total_amt_i <= NULL) => -0.0053123372,
              ((real)f_liens_unrel_o_total_amt_i < 721.5) => N533_7,
                                                             -0.0053123372));

N533_5 :=__common__( map(((real)r_l79_adls_per_addr_c6_i <= NULL) => 0.0054809066,
              ((real)r_l79_adls_per_addr_c6_i < 1.5)   => -0.005983899,
                                                          0.0054809066));

N533_4 :=__common__( if(((real)c_mort_indx < 70.5), -0.012823806, N533_5));

N533_3 :=__common__( if(trim(C_MORT_INDX) != '', N533_4, -0.0012070965));

N533_2 :=__common__( map(((real)r_i60_inq_retail_recency_d <= NULL) => N533_6,
              ((real)r_i60_inq_retail_recency_d < 61.5)  => N533_3,
                                                            N533_6));

N533_1 :=__common__( if(((real)f_inq_retail_count24_i > NULL), N533_2, -0.0061226566));

N534_9 :=__common__( map(((real)r_c13_curr_addr_lres_d <= NULL) => -0.002271238,
              ((real)r_c13_curr_addr_lres_d < 5.5)   => 0.0064600824,
                                                        -0.002271238));

N534_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0460168644786), 0.0047255912, N534_9));

N534_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N534_8, -0.0048035625));

N534_6 :=__common__( map(trim(C_RNT250_P) = ''              => 0.00041313426,
              ((real)c_rnt250_p < 8.44999980927) => 0.0080359292,
                                                    0.00041313426));

N534_5 :=__common__( map(trim(C_INC_150K_P) = ''              => -0.0059594197,
              ((real)c_inc_150k_p < 4.55000019073) => N534_6,
                                                      -0.0059594197));

N534_4 :=__common__( map(trim(C_EASIQLIFE) = ''      => -0.0094539665,
              ((real)c_easiqlife < 139.5) => N534_5,
                                             -0.0094539665));

N534_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N534_4, N534_7));

N534_2 :=__common__( if(((real)c_rape < 130.5), -0.00091301388, N534_3));

N534_1 :=__common__( if(trim(C_RAPE) != '', N534_2, 0.0062530508));

N535_10 :=__common__( if(((real)c_sfdu_p < 70.5500030518), 0.0083184224, -0.0015566469));

N535_9 :=__common__( if(trim(C_SFDU_P) != '', N535_10, 0.0004856132));

N535_8 :=__common__( map(trim(C_HHSIZE) = ''              => 0.0039530733,
              ((real)c_hhsize < 2.76499986649) => -0.0088484955,
                                                  0.0039530733));

N535_7 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.00089411301,
              ((real)c_sub_bus < 106.5) => 0.012099155,
                                           0.00089411301));

N535_6 :=__common__( if(((real)c_addr_lres_2mo_ct_i < 1.5), N535_7, N535_8));

N535_5 :=__common__( if(((real)c_addr_lres_2mo_ct_i > NULL), N535_6, 0.0026374105));

N535_4 :=__common__( if(((real)c_sfdu_p < 96.25), -0.00091927895, N535_5));

N535_3 :=__common__( if(trim(C_SFDU_P) != '', N535_4, -0.00048666825));

N535_2 :=__common__( if(((real)f_inq_adls_per_phone_i < 1.5), N535_3, N535_9));

N535_1 :=__common__( if(((real)f_inq_adls_per_phone_i > NULL), N535_2, -0.027133523));

N536_8 :=__common__( map(trim(C_HH00) = ''      => 0.0046579141,
              ((real)c_hh00 < 601.5) => 0.017557509,
                                        0.0046579141));

N536_7 :=__common__( if(((real)c_employees < 208.5), 0.0019340215, N536_8));

N536_6 :=__common__( if(trim(C_EMPLOYEES) != '', N536_7, -0.00032526059));

N536_5 :=__common__( map(((real)c_a49_prop_owned_assessed_tot_d <= NULL)    => -0.00888694,
              ((integer)c_a49_prop_owned_assessed_tot_d < 68522) => N536_6,
                                                                    -0.00888694));

N536_4 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => -0.0042674099,
              ((real)c_dist_best_to_prev_addr_i < 24.5)  => N536_5,
                                                            -0.0042674099));

N536_3 :=__common__( map(((real)r_i60_inq_comm_count12_i <= NULL) => -0.0036714075,
              ((real)r_i60_inq_comm_count12_i < 1.5)   => -0.00046787735,
                                                          -0.0036714075));

N536_2 :=__common__( if(((real)f_corraddrnamecount_d < 6.5), N536_3, N536_4));

N536_1 :=__common__( if(((real)f_corraddrnamecount_d > NULL), N536_2, -0.0031340207));

N537_10 :=__common__( map(trim(C_HVAL_60K_P) = ''              => -0.006703778,
               ((real)c_hval_60k_p < 19.8499984741) => 0.0019470729,
                                                       -0.006703778));

N537_9 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), -0.0014664652, N537_10));

N537_8 :=__common__( map(trim(C_BARGAINS) = ''     => 0.0022509321,
              ((real)c_bargains < 86.5) => 0.01055561,
                                           0.0022509321));

N537_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.036393776536), N537_8, N537_9));

N537_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N537_7, 0.00094939869));

N537_5 :=__common__( map(trim(C_RICH_FAM) = ''      => 0.010654977,
              ((real)c_rich_fam < 192.5) => -0.0014117881,
                                            0.010654977));

N537_4 :=__common__( if(((integer)c_robbery < 145), N537_5, N537_6));

N537_3 :=__common__( if(trim(C_ROBBERY) != '', N537_4, 0.0022972402));

N537_2 :=__common__( if(((real)r_a50_pb_average_dollars_d < 6.5), 0.0088102738, N537_3));

N537_1 :=__common__( if(((real)r_a50_pb_average_dollars_d > NULL), N537_2, -0.0015326408));

N538_7 :=__common__( map(trim(C_HVAL_100K_P) = ''              => -0.010096269,
              ((real)c_hval_100k_p < 29.5499992371) => 0.00028391437,
                                                       -0.010096269));

N538_6 :=__common__( map(trim(C_REST_INDX) = ''     => 0.0034501655,
              ((real)c_rest_indx < 98.5) => -0.0085591516,
                                            0.0034501655));

N538_5 :=__common__( map(((real)f_util_add_curr_misc_n <= NULL) => 0.0035666337,
              ((real)f_util_add_curr_misc_n < 0.5)   => N538_6,
                                                        0.0035666337));

N538_4 :=__common__( map(trim(C_CHILD) = ''              => 0.0068910444,
              ((real)c_child < 30.8499984741) => N538_5,
                                                 0.0068910444));

N538_3 :=__common__( map(((real)f_addrchangeecontrajindex_d <= NULL) => N538_7,
              ((real)f_addrchangeecontrajindex_d < 1.5)   => N538_4,
                                                             N538_7));

N538_2 :=__common__( map(((real)f_rel_criminal_count_i <= NULL) => -0.0027911868,
              ((real)f_rel_criminal_count_i < 9.5)   => N538_3,
                                                        -0.0027911868));

N538_1 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N538_2, -0.00085333095));

N539_8 :=__common__( map(trim(C_ASSAULT) = ''      => -0.005659299,
              ((real)c_assault < 137.5) => -0.00033135847,
                                           -0.005659299));

N539_7 :=__common__( map(((real)c_a49_prop_sold_purchase_tot_d <= NULL)   => 0.011537496,
              ((integer)c_a49_prop_sold_purchase_tot_d < 4850) => 0.0010461223,
                                                                  0.011537496));

N539_6 :=__common__( map(trim(C_HVAL_400K_P) = ''     => N539_8,
              ((real)c_hval_400k_p < 1.25) => N539_7,
                                              N539_8));

N539_5 :=__common__( if(((real)c_housingcpi < 241.75), N539_6, 0.0094362634));

N539_4 :=__common__( if(trim(C_HOUSINGCPI) != '', N539_5, -0.00098799099));

N539_3 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)    => 0.0043071988,
              ((integer)f_prevaddrmedianincome_d < 56748) => -0.0033563159,
                                                             0.0043071988));

N539_2 :=__common__( if(((real)r_c14_addrs_10yr_i < 3.5), N539_3, N539_4));

N539_1 :=__common__( if(((real)r_c14_addrs_10yr_i > NULL), N539_2, -0.0042350227));

N540_8 :=__common__( if(((integer)c_robbery < 107), 0.0011691801, -0.012809162));

N540_7 :=__common__( if(trim(C_ROBBERY) != '', N540_8, -0.015228232));

N540_6 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => 0.0031697581,
              ((real)r_c13_avg_lres_d < 29.5)  => -0.0028637031,
                                                  0.0031697581));

N540_5 :=__common__( map(((real)r_mos_since_paw_fseen_d <= NULL) => 0.011839271,
              ((real)r_mos_since_paw_fseen_d < 12.5)  => N540_6,
                                                         0.011839271));

N540_4 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), -0.0029693994, 0.00028646428));

N540_3 :=__common__( map(((real)f_util_adl_count_n <= NULL) => N540_5,
              ((real)f_util_adl_count_n < 6.5)   => N540_4,
                                                    N540_5));

N540_2 :=__common__( if(((real)f_inq_highriskcredit_count24_i < 13.5), N540_3, N540_7));

N540_1 :=__common__( if(((real)f_inq_highriskcredit_count24_i > NULL), N540_2, 0.0047049459));

N541_8 :=__common__( map(trim(C_RNT500_P) = ''      => -0.0068057545,
              ((real)c_rnt500_p < 55.75) => 0.00019438096,
                                            -0.0068057545));

N541_7 :=__common__( if(((real)f_curraddractivephonelist_d > NULL), 0.0031425456, 0.042284111));

N541_6 :=__common__( map(trim(C_RETAIL) = ''              => -0.0055308238,
              ((real)c_retail < 5.05000019073) => N541_7,
                                                  -0.0055308238));

N541_5 :=__common__( map(((real)f_current_count_d <= NULL) => N541_6,
              ((real)f_current_count_d < 1.5)   => 0.0052654737,
                                                   N541_6));

N541_4 :=__common__( if(((real)c_unemp < 6.25), N541_5, N541_8));

N541_3 :=__common__( if(trim(C_UNEMP) != '', N541_4, 0.0049213392));

N541_2 :=__common__( if(((real)f_assocrisktype_i < 5.5), -0.0014670672, N541_3));

N541_1 :=__common__( if(((real)f_assocrisktype_i > NULL), N541_2, 0.0044149391));

N542_8 :=__common__( map(trim(C_POPOVER18) = ''      => 0.00012784266,
              ((real)c_popover18 < 639.5) => -0.010405085,
                                             0.00012784266));

N542_7 :=__common__( map(trim(C_INC_100K_P) = ''              => N542_8,
              ((real)c_inc_100k_p < 12.0500001907) => 0.0030614645,
                                                      N542_8));

N542_6 :=__common__( map(trim(C_FAMMAR_P) = ''      => 0.00068739002,
              ((real)c_fammar_p < 53.25) => -0.0029412286,
                                            0.00068739002));

N542_5 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => N542_7,
              ((real)c_dist_best_to_prev_addr_i < 4.5)   => N542_6,
                                                            N542_7));

N542_4 :=__common__( map(((real)c_dist_input_to_prev_addr_i <= NULL) => -0.0049034975,
              ((real)c_dist_input_to_prev_addr_i < 819.5) => N542_5,
                                                             -0.0049034975));

N542_3 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N542_4, 0.002927213));

N542_2 :=__common__( if(((real)c_apt20 < 185.5), N542_3, 0.006331972));

N542_1 :=__common__( if(trim(C_APT20) != '', N542_2, -0.00093909818));

N543_9 :=__common__( map(trim(C_POPOVER25) = ''      => -0.0030026756,
              ((real)c_popover25 < 728.5) => -0.012885243,
                                             -0.0030026756));

N543_8 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d < 15.5), 0.0050138202, -0.0018752398));

N543_7 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d > NULL), N543_8, 0.021816564));

N543_6 :=__common__( map(trim(C_HH2_P) = ''              => N543_9,
              ((real)c_hh2_p < 39.5499992371) => N543_7,
                                                 N543_9));

N543_5 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => 0.0066265168,
              ((real)f_inq_adls_per_phone_i < 1.5)   => -0.0012644302,
                                                        0.0066265168));

N543_4 :=__common__( if(((real)c_dist_best_to_prev_addr_i < 4.5), N543_5, 0.002413639));

N543_3 :=__common__( if(((real)c_dist_best_to_prev_addr_i > NULL), N543_4, -0.0077341708));

N543_2 :=__common__( if(((real)c_burglary < 159.5), N543_3, N543_6));

N543_1 :=__common__( if(trim(C_BURGLARY) != '', N543_2, -0.00076063559));

N544_7 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => 0.0021787848,
              ((real)f_curraddrburglaryindex_i < 114.5) => 0.017872252,
                                                           0.0021787848));

N544_6 :=__common__( map(trim(C_HIGHINC) = ''              => -0.00054476811,
              ((real)c_highinc < 1.84999990463) => 0.0088819976,
                                                   -0.00054476811));

N544_5 :=__common__( map(trim(C_OLD_HOMES) = ''      => -0.0078565452,
              ((real)c_old_homes < 154.5) => N544_6,
                                             -0.0078565452));

N544_4 :=__common__( map(trim(C_HH3_P) = ''              => 0.0080434962,
              ((real)c_hh3_p < 21.3499984741) => N544_5,
                                                 0.0080434962));

N544_3 :=__common__( map(trim(C_PRESCHL) = ''      => N544_7,
              ((real)c_preschl < 122.5) => N544_4,
                                           N544_7));

N544_2 :=__common__( if(((real)c_med_age < 39.75), -0.00039503556, N544_3));

N544_1 :=__common__( if(trim(C_MED_AGE) != '', N544_2, -0.00046148146));

N545_10 :=__common__( if(((real)c_hval_100k_p < 15.4499998093), 0.0011797131, 0.011257678));

N545_9 :=__common__( if(trim(C_HVAL_100K_P) != '', N545_10, -0.0082825066));

N545_8 :=__common__( map(((real)f_mos_liens_unrel_lt_lseen_d <= NULL) => -0.00060867226,
              ((real)f_mos_liens_unrel_lt_lseen_d < 127.5) => N545_9,
                                                              -0.00060867226));

N545_7 :=__common__( map(trim(C_INCOLLEGE) = ''              => 0.00076675496,
              ((real)c_incollege < 1.65000009537) => -0.0067225965,
                                                     0.00076675496));

N545_6 :=__common__( if(((real)c_retail < 10.1499996185), N545_7, -0.0046970958));

N545_5 :=__common__( if(trim(C_RETAIL) != '', N545_6, -0.031357881));

N545_4 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => N545_5,
              ((real)f_prevaddrmedianincome_d < 14359.5) => 0.005406781,
                                                            N545_5));

N545_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N545_4, N545_8));

N545_2 :=__common__( if(((real)f_assocsuspicousidcount_i < 16.5), N545_3, 0.0062258027));

N545_1 :=__common__( if(((real)f_assocsuspicousidcount_i > NULL), N545_2, 0.0068237919));

N546_8 :=__common__( map(((real)f_corrrisktype_i <= NULL) => 0.0048134248,
              ((real)f_corrrisktype_i < 7.5)   => -0.0018613997,
                                                  0.0048134248));

N546_7 :=__common__( map(trim(C_POP_35_44_P) = ''              => 0.0089826065,
              ((real)c_pop_35_44_p < 18.9500007629) => N546_8,
                                                       0.0089826065));

N546_6 :=__common__( map(((real)f_util_add_input_misc_n <= NULL) => 0.006183207,
              ((real)f_util_add_input_misc_n < 0.5)   => -0.0052109045,
                                                         0.006183207));

N546_5 :=__common__( map(((real)r_d31_attr_bankruptcy_recency_d <= NULL) => N546_6,
              ((integer)r_d31_attr_bankruptcy_recency_d < 9)  => -0.0017192573,
                                                                 N546_6));

N546_4 :=__common__( if(((real)c_easiqlife < 139.5), N546_5, N546_7));

N546_3 :=__common__( if(trim(C_EASIQLIFE) != '', N546_4, 0.0015463555));

N546_2 :=__common__( if(((integer)f_liens_unrel_sc_total_amt_i < 6936), N546_3, 0.010440021));

N546_1 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i > NULL), N546_2, -0.0057414365));

N547_9 :=__common__( map(trim(C_HIGHRENT) = ''              => 0.0078199056,
              ((real)c_highrent < 21.1500015259) => -0.0015213427,
                                                    0.0078199056));

N547_8 :=__common__( map(trim(C_AB_AV_EDU) = ''      => 0.010871239,
              ((real)c_ab_av_edu < 119.5) => 0.0017140325,
                                             0.010871239));

N547_7 :=__common__( if(((real)c_professional < 0.15000000596), N547_8, N547_9));

N547_6 :=__common__( if(trim(C_PROFESSIONAL) != '', N547_7, 0.0032458857));

N547_5 :=__common__( map(trim(C_POP_0_5_P) = ''              => 0.0027295938,
              ((real)c_pop_0_5_p < 8.35000038147) => -0.0043002354,
                                                     0.0027295938));

N547_4 :=__common__( if(((real)c_inc_35k_p < 14.4499998093), N547_5, -0.0070559265));

N547_3 :=__common__( if(trim(C_INC_35K_P) != '', N547_4, -0.0095137095));

N547_2 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0187365170568), N547_3, N547_6));

N547_1 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N547_2, -0.0024383435));

N548_10 :=__common__( if(((real)c_pop_6_11_p < 8.35000038147), -0.003246284, 0.00054629337));

N548_9 :=__common__( if(trim(C_POP_6_11_P) != '', N548_10, 0.00041823181));

N548_8 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => -0.0051842857,
              ((real)r_c10_m_hdr_fs_d < 345.5) => 0.002611182,
                                                  -0.0051842857));

N548_7 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)    => -0.0045053675,
              ((real)f_curraddrmedianvalue_d < 221445.5) => N548_8,
                                                            -0.0045053675));

N548_6 :=__common__( if(((real)c_housingcpi < 241.75), N548_7, 0.010746839));

N548_5 :=__common__( if(trim(C_HOUSINGCPI) != '', N548_6, -0.0040228924));

N548_4 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.495444238186), N548_5, -0.0033683214));

N548_3 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N548_4, -0.0025928166));

N548_2 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 70.5), N548_3, N548_9));

N548_1 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N548_2, 0.00054881658));

N549_9 :=__common__( if(((real)r_c13_max_lres_d < 91.5), -0.0084813979, 0.00061600924));

N549_8 :=__common__( if(((real)r_c13_max_lres_d > NULL), N549_9, 0.032064501));

N549_7 :=__common__( map(trim(C_POP_35_44_P) = ''     => -0.0028430065,
              ((real)c_pop_35_44_p < 9.75) => 0.0046874953,
                                              -0.0028430065));

N549_6 :=__common__( if(((real)f_corrssnaddrcount_d < 0.5), 0.008457881, 0.001601686));

N549_5 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N549_6, 0.0078928718));

N549_4 :=__common__( map(trim(C_HH5_P) = ''              => N549_7,
              ((real)c_hh5_p < 8.94999980927) => N549_5,
                                                 N549_7));

N549_3 :=__common__( map(trim(C_HEALTH) = ''              => -0.0017784789,
              ((real)c_health < 19.6500015259) => N549_4,
                                                  -0.0017784789));

N549_2 :=__common__( if(((real)c_manufacturing < 11.9499998093), N549_3, N549_8));

N549_1 :=__common__( if(trim(C_MANUFACTURING) != '', N549_2, 0.0015683878));

N550_7 :=__common__( map(trim(C_PRESCHL) = ''     => -0.00063464765,
              ((real)c_preschl < 99.5) => 0.0096652933,
                                          -0.00063464765));

N550_6 :=__common__( map(trim(C_POP_85P_P) = ''     => -0.0035931965,
              ((real)c_pop_85p_p < 0.75) => N550_7,
                                            -0.0035931965));

N550_5 :=__common__( map(((real)r_c13_curr_addr_lres_d <= NULL) => N550_6,
              ((real)r_c13_curr_addr_lres_d < 18.5)  => -0.0055811443,
                                                        N550_6));

N550_4 :=__common__( map(trim(C_POP_45_54_P) = ''              => -0.0004336136,
              ((real)c_pop_45_54_p < 10.9499998093) => 0.0063148838,
                                                       -0.0004336136));

N550_3 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => N550_5,
              ((real)r_a50_pb_average_dollars_d < 111.5) => N550_4,
                                                            N550_5));

N550_2 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => N550_3,
              ((real)r_l79_adls_per_addr_curr_i < 3.5)   => 0.0012586935,
                                                            N550_3));

N550_1 :=__common__( if(trim(C_OLDHOUSE) != '', N550_2, 0.0049167901));

N551_9 :=__common__( map(((real)f_rel_homeover200_count_d <= NULL) => -0.0010552363,
              ((real)f_rel_homeover200_count_d < 1.5)   => 0.010089334,
                                                           -0.0010552363));

N551_8 :=__common__( map(trim(C_NO_CAR) = ''     => 0.0054422016,
              ((real)c_no_car < 53.5) => -0.0075341272,
                                         0.0054422016));

N551_7 :=__common__( if(((real)c_hh6_p < 0.25), -0.0081689743, N551_8));

N551_6 :=__common__( if(trim(C_HH6_P) != '', N551_7, 0.021562599));

N551_5 :=__common__( if(((integer)r_l80_inp_avm_autoval_d < 56226), 0.0049211499, N551_6));

N551_4 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N551_5, 0.0004215955));

N551_3 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => N551_4,
              ((real)r_d32_criminal_count_i < 0.5)   => -0.0017418359,
                                                        N551_4));

N551_2 :=__common__( if(((real)f_rel_felony_count_i < 6.5), N551_3, N551_9));

N551_1 :=__common__( if(((real)f_rel_felony_count_i > NULL), N551_2, 0.0060712822));

N552_9 :=__common__( if(((real)c_burglary < 148.5), 0.0022347338, -0.007461511));

N552_8 :=__common__( if(trim(C_BURGLARY) != '', N552_9, -0.03383745));

N552_7 :=__common__( map(((real)f_prevaddrageoldest_d <= NULL) => 0.0029982213,
              ((real)f_prevaddrageoldest_d < 10.5)  => 0.009749662,
                                                       0.0029982213));

N552_6 :=__common__( map(((real)r_i60_inq_count12_i <= NULL) => N552_8,
              ((real)r_i60_inq_count12_i < 5.5)   => N552_7,
                                                     N552_8));

N552_5 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL) => -0.00031826167,
              ((real)f_prevaddrmurderindex_i < 167.5) => N552_6,
                                                         -0.00031826167));

N552_4 :=__common__( if(((real)c_serv_empl < 96.5), -0.0034634963, 0.00059800929));

N552_3 :=__common__( if(trim(C_SERV_EMPL) != '', N552_4, -0.0029066445));

N552_2 :=__common__( if(((integer)f_fp_prevaddrcrimeindex_i < 114), N552_3, N552_5));

N552_1 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N552_2, 0.00091070649));

N553_7 :=__common__( map(((real)r_c20_email_domain_free_count_i <= NULL) => 0.01301872,
              ((real)r_c20_email_domain_free_count_i < 1.5)   => 0.0036808952,
                                                                 0.01301872));

N553_6 :=__common__( map(trim(C_SERV_EMPL) = ''     => N553_7,
              ((real)c_serv_empl < 89.5) => -0.0010658632,
                                            N553_7));

N553_5 :=__common__( map(trim(C_INC_75K_P) = ''              => 0.00045595785,
              ((real)c_inc_75k_p < 9.85000038147) => N553_6,
                                                     0.00045595785));

N553_4 :=__common__( map(trim(C_NO_MOVE) = ''      => 0.0064185056,
              ((real)c_no_move < 178.5) => -0.0027859136,
                                           0.0064185056));

N553_3 :=__common__( map(((real)f_util_add_curr_misc_n <= NULL) => N553_5,
              ((real)f_util_add_curr_misc_n < 0.5)   => N553_4,
                                                        N553_5));

N553_2 :=__common__( if(((real)c_hh7p_p < 6.85000038147), N553_3, -0.0045288578));

N553_1 :=__common__( if(trim(C_HH7P_P) != '', N553_2, -0.0017551774));

N554_8 :=__common__( map(((real)f_assoccredbureaucount_i <= NULL) => 0.0030345261,
              ((real)f_assoccredbureaucount_i < 2.5)   => -0.0045304491,
                                                          0.0030345261));

N554_7 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => 0.0047933433,
              ((real)f_mos_inq_banko_om_lseen_d < 14.5)  => -0.0012855214,
                                                            0.0047933433));

N554_6 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => N554_7,
              ((real)r_d30_derog_count_i < 7.5)   => -0.00025237493,
                                                     N554_7));

N554_5 :=__common__( map(((real)f_mos_liens_unrel_lt_fseen_d <= NULL) => N554_6,
              ((real)f_mos_liens_unrel_lt_fseen_d < 41.5)  => -0.0058373202,
                                                              N554_6));

N554_4 :=__common__( map((fp_segment in ['3 New DID', '4 Bureau Only', '5 Derog', '6 Recent Activity', '7 Other']) => N554_5,
              (fp_segment in ['1 SSN Prob', '2 NAS 479'])                                               => 0.011058089,
                                                                                                           N554_5));

N554_3 :=__common__( if(((integer)c_hist_addr_match_i < 42), N554_4, N554_8));

N554_2 :=__common__( if(((real)c_hist_addr_match_i > NULL), N554_3, 0.00053828473));

N554_1 :=__common__( if(trim(C_NEWHOUSE) != '', N554_2, 0.0004792316));

N555_10 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => -0.00050291287,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.251536309719) => 0.0074667186,
                                                                      -0.00050291287));

N555_9 :=__common__( map(((real)f_srchphonesrchcount_i <= NULL) => -0.0049490897,
              ((real)f_srchphonesrchcount_i < 0.5)   => 0.0059740374,
                                                        -0.0049490897));

N555_8 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.0078578213,
              ((real)r_c14_addrs_10yr_i < 5.5)   => N555_9,
                                                    0.0078578213));

N555_7 :=__common__( if(((real)c_blue_empl < 60.5), N555_8, N555_10));

N555_6 :=__common__( if(trim(C_BLUE_EMPL) != '', N555_7, 0.0092283174));

N555_5 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.780007004738), N555_6, -0.0072258533));

N555_4 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N555_5, 0.0016072364));

N555_3 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), 0.0014144093, N555_4));

N555_2 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 6.5), N555_3, -0.0022841023));

N555_1 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N555_2, 0.0038998576));

N556_9 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.341629862785), -0.0043483829, 0.0022180485));

N556_8 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N556_9, -0.00010925673));

N556_7 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL)  => 0.008367102,
              ((real)f_liens_unrel_cj_total_amt_i < 6143.5) => N556_8,
                                                               0.008367102));

N556_6 :=__common__( map(((real)f_inq_count24_i <= NULL) => -0.0089345525,
              ((real)f_inq_count24_i < 15.5)  => N556_7,
                                                 -0.0089345525));

N556_5 :=__common__( map(trim(C_TOTSALES) = ''      => 0.0005827865,
              ((real)c_totsales < 581.5) => N556_6,
                                            0.0005827865));

N556_4 :=__common__( if(((real)f_addrchangeecontrajindex_d < 3.5), N556_5, 0.0089491927));

N556_3 :=__common__( if(((real)f_addrchangeecontrajindex_d > NULL), N556_4, 0.0024262001));

N556_2 :=__common__( if(((real)c_mil_emp < 4.64999961853), N556_3, 0.0076776942));

N556_1 :=__common__( if(trim(C_MIL_EMP) != '', N556_2, 0.00058773546));

N557_8 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)   => 0.0059845561,
              ((real)f_prevaddrmedianvalue_d < 78001.5) => -0.0027720035,
                                                           0.0059845561));

N557_7 :=__common__( map(trim(C_POP_85P_P) = ''     => 0.012373267,
              ((real)c_pop_85p_p < 2.25) => N557_8,
                                            0.012373267));

N557_6 :=__common__( map(trim(C_CHILD) = ''      => N557_7,
              ((real)c_child < 22.75) => -0.0017044846,
                                         N557_7));

N557_5 :=__common__( map(trim(C_CHILD) = ''              => -0.0052888052,
              ((real)c_child < 32.0499992371) => N557_6,
                                                 -0.0052888052));

N557_4 :=__common__( if(((real)c_rnt750_p < 6.25), N557_5, -0.00094244585));

N557_3 :=__common__( if(trim(C_RNT750_P) != '', N557_4, -0.0012729704));

N557_2 :=__common__( if(((real)r_f00_input_dob_match_level_d < 3.5), 0.007881384, N557_3));

N557_1 :=__common__( if(((real)r_f00_input_dob_match_level_d > NULL), N557_2, 0.0055641148));

N558_9 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i < 804.5), -0.001632957, -0.010206674));

N558_8 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i > NULL), N558_9, -0.015179608));

N558_7 :=__common__( if(((integer)f_estimated_income_d < 25500), -0.011568976, -0.0028336436));

N558_6 :=__common__( if(((real)f_estimated_income_d > NULL), N558_7, -0.018987302));

N558_5 :=__common__( map(trim(C_EMPLOYEES) = ''      => 0.002137227,
              ((real)c_employees < 208.5) => N558_6,
                                             0.002137227));

N558_4 :=__common__( map(((real)f_util_add_input_misc_n <= NULL) => 0.0012412182,
              ((real)f_util_add_input_misc_n < 0.5)   => N558_5,
                                                         0.0012412182));

N558_3 :=__common__( map(trim(C_HVAL_175K_P) = ''              => N558_8,
              ((real)c_hval_175k_p < 11.6499996185) => N558_4,
                                                       N558_8));

N558_2 :=__common__( if(((real)c_hval_150k_p < 25.0499992371), N558_3, 0.0035309216));

N558_1 :=__common__( if(trim(C_HVAL_150K_P) != '', N558_2, 0.0019956971));

N559_7 :=__common__( map(trim(C_POP_25_34_P) = ''              => -0.0058126177,
              ((real)c_pop_25_34_p < 13.4499998093) => 0.0025759699,
                                                       -0.0058126177));

N559_6 :=__common__( map(trim(C_HVAL_200K_P) = ''              => 0.0050491274,
              ((real)c_hval_200k_p < 3.54999995232) => N559_7,
                                                       0.0050491274));

N559_5 :=__common__( map(((real)r_c15_ssns_per_adl_i <= NULL) => 0.0099930979,
              ((real)r_c15_ssns_per_adl_i < 1.5)   => N559_6,
                                                      0.0099930979));

N559_4 :=__common__( map(((real)f_current_count_d <= NULL) => N559_5,
              ((real)f_current_count_d < 0.5)   => 0.0087973518,
                                                   N559_5));

N559_3 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => N559_4,
              ((real)f_add_curr_nhood_vac_pct_i < 0.0131738418713) => -0.0082294273,
                                                                      N559_4));

N559_2 :=__common__( if(((real)c_cpiall < 208.5), N559_3, -0.00067871487));

N559_1 :=__common__( if(trim(C_CPIALL) != '', N559_2, 0.00049827099));

N560_9 :=__common__( map(trim(C_CIV_EMP) = ''              => 0.010179122,
              ((real)c_civ_emp < 55.4500007629) => -0.00033850361,
                                                   0.010179122));

N560_8 :=__common__( map(trim(C_HVAL_125K_P) = ''      => -0.0053745325,
              ((real)c_hval_125k_p < 14.25) => N560_9,
                                               -0.0053745325));

N560_7 :=__common__( if(((real)c_new_homes < 154.5), N560_8, 0.011121761));

N560_6 :=__common__( if(trim(C_NEW_HOMES) != '', N560_7, 0.02420257));

N560_5 :=__common__( map(trim(C_PRESCHL) = ''      => 0.0012574378,
              ((real)c_preschl < 101.5) => -0.014090001,
                                           0.0012574378));

N560_4 :=__common__( if(((real)c_unemp < 2.04999995232), N560_5, 3.8698147e-005));

N560_3 :=__common__( if(trim(C_UNEMP) != '', N560_4, -0.0013949201));

N560_2 :=__common__( if(((real)f_srchfraudsrchcountmo_i < 0.5), N560_3, N560_6));

N560_1 :=__common__( if(((real)f_srchfraudsrchcountmo_i > NULL), N560_2, 0.0061164316));

N561_9 :=__common__( map(trim(C_LOW_HVAL) = ''              => -0.0058915988,
              ((real)c_low_hval < 40.4500007629) => 0.0034024723,
                                                    -0.0058915988));

N561_8 :=__common__( if(((real)c_hval_150k_p < 16.4500007629), N561_9, -0.0073761388));

N561_7 :=__common__( if(trim(C_HVAL_150K_P) != '', N561_8, 0.00080322848));

N561_6 :=__common__( map(trim(C_RENTOCC_P) = ''              => -0.0089495791,
              ((real)c_rentocc_p < 82.9499969482) => 0.00016327412,
                                                     -0.0089495791));

N561_5 :=__common__( map(trim(C_LOW_ED) = ''              => 0.0054759797,
              ((real)c_low_ed < 77.4499969482) => N561_6,
                                                  0.0054759797));

N561_4 :=__common__( if(((real)c_low_ed < 82.0500030518), N561_5, -0.0051230596));

N561_3 :=__common__( if(trim(C_LOW_ED) != '', N561_4, -0.0056691193));

N561_2 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.00464756274596), 0.0063179644, N561_3));

N561_1 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N561_2, N561_7));

N562_8 :=__common__( map(((real)f_corrrisktype_i <= NULL) => -0.0057932461,
              ((real)f_corrrisktype_i < 3.5)   => 0.0030720853,
                                                  -0.0057932461));

N562_7 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => N562_8,
              ((real)f_curraddrmedianincome_d < 27711.5) => 0.0025512292,
                                                            N562_8));

N562_6 :=__common__( map(trim(C_POP_75_84_P) = ''              => 0.0045590798,
              ((real)c_pop_75_84_p < 7.64999961853) => 5.8976772e-005,
                                                       0.0045590798));

N562_5 :=__common__( map(trim(C_FOR_SALE) = ''      => -0.0069954052,
              ((real)c_for_sale < 195.5) => N562_6,
                                            -0.0069954052));

N562_4 :=__common__( if(((real)r_i60_inq_comm_count12_i < 1.5), N562_5, N562_7));

N562_3 :=__common__( if(((real)r_i60_inq_comm_count12_i > NULL), N562_4, -0.0087873114));

N562_2 :=__common__( if(((real)c_bel_edu < 193.5), N562_3, -0.0064182989));

N562_1 :=__common__( if(trim(C_BEL_EDU) != '', N562_2, -0.00068373517));

N563_10 :=__common__( if(((real)c_pop_85p_p < 1.15000009537), 0.0078630319, -0.0011869478));

N563_9 :=__common__( if(trim(C_POP_85P_P) != '', N563_10, -0.015386982));

N563_8 :=__common__( map(((real)f_college_income_d <= NULL) => N563_9,
              ((real)f_college_income_d < 2.5)   => -0.0069940333,
                                                    N563_9));

N563_7 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => N563_8,
              ((real)f_add_curr_nhood_vac_pct_i < 0.0214755497873) => -0.0046952074,
                                                                      N563_8));

N563_6 :=__common__( if(((real)f_college_income_d > NULL), N563_7, -0.00031841026));

N563_5 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL)  => 0.0062200184,
              ((integer)r_a50_pb_total_dollars_d < 177) => -0.0034893359,
                                                           0.0062200184));

N563_4 :=__common__( if(((real)f_rel_homeover50_count_d < 3.5), N563_5, N563_6));

N563_3 :=__common__( if(((real)f_rel_homeover50_count_d > NULL), N563_4, 0.0016966209));

N563_2 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d < 0.00166678242385), -0.0086506742, N563_3));

N563_1 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d > NULL), N563_2, -0.030139329));

N564_8 :=__common__( map((fp_segment in ['1 SSN Prob', '2 NAS 479', '5 Derog', '6 Recent Activity', '7 Other']) => 0.0031652662,
              (fp_segment in ['3 New DID', '4 Bureau Only'])                                         => 0.029126056,
                                                                                                        0.0031652662));

N564_7 :=__common__( map(trim(C_BLUE_EMPL) = ''     => -0.006469863,
              ((real)c_blue_empl < 76.5) => 0.003208325,
                                            -0.006469863));

N564_6 :=__common__( map(trim(C_EASIQLIFE) = ''     => N564_8,
              ((real)c_easiqlife < 70.5) => N564_7,
                                            N564_8));

N564_5 :=__common__( map(trim(C_POP_18_24_P) = ''      => -0.0066461838,
              ((real)c_pop_18_24_p < 15.25) => -0.0003669235,
                                               -0.0066461838));

N564_4 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => N564_6,
              ((real)r_c10_m_hdr_fs_d < 161.5) => N564_5,
                                                  N564_6));

N564_3 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 5.5), N564_4, -0.0017725385));

N564_2 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N564_3, 0.0029058234));

N564_1 :=__common__( if(trim(C_HVAL_750K_P) != '', N564_2, 0.0023250658));

N565_10 :=__common__( map(trim(C_OWNOCC_P) = ''              => -0.0015131936,
               ((real)c_ownocc_p < 39.4500007629) => -0.012435735,
                                                     -0.0015131936));

N565_9 :=__common__( map(trim(C_HVAL_200K_P) = ''      => 0.009405296,
              ((real)c_hval_200k_p < 20.75) => -0.00062651697,
                                               0.009405296));

N565_8 :=__common__( if(((real)r_pb_order_freq_d > NULL), -0.00026988273, N565_9));

N565_7 :=__common__( map(trim(C_POPOVER25) = ''      => N565_8,
              ((real)c_popover25 < 358.5) => -0.0068051341,
                                             N565_8));

N565_6 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N565_7, -0.0016379126));

N565_5 :=__common__( map(trim(C_FEMDIV_P) = ''      => N565_10,
              ((real)c_femdiv_p < 11.25) => N565_6,
                                            N565_10));

N565_4 :=__common__( if(((real)f_srchssnsrchcount_i < 4.5), -0.00067309173, 0.0084695195));

N565_3 :=__common__( if(((real)f_srchssnsrchcount_i > NULL), N565_4, 0.054847871));

N565_2 :=__common__( if(((real)c_hhsize < 2.00500011444), N565_3, N565_5));

N565_1 :=__common__( if(trim(C_HHSIZE) != '', N565_2, 0.0011568122));

N566_8 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => -0.0039927148,
              ((real)r_d30_derog_count_i < 4.5)   => 0.0075852851,
                                                     -0.0039927148));

N566_7 :=__common__( map(((real)f_inq_per_addr_i <= NULL) => N566_8,
              ((real)f_inq_per_addr_i < 0.5)   => -0.0089054666,
                                                  N566_8));

N566_6 :=__common__( map(trim(C_PRESCHL) = ''      => 0.00871537,
              ((real)c_preschl < 151.5) => N566_7,
                                           0.00871537));

N566_5 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => -0.0050642016,
              ((real)f_mos_inq_banko_om_fseen_d < 9.5)   => 0.001597887,
                                                            -0.0050642016));

N566_4 :=__common__( if(((real)c_mort_indx < 105.5), N566_5, N566_6));

N566_3 :=__common__( if(trim(C_MORT_INDX) != '', N566_4, -0.0038392686));

N566_2 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d < 13.5), N566_3, 0.00082329067));

N566_1 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d > NULL), N566_2, -0.00027666607));

N567_9 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.01025823,
              ((real)r_c14_addrs_10yr_i < 5.5)   => -0.0018823029,
                                                    0.01025823));

N567_8 :=__common__( map(trim(C_FEMDIV_P) = ''     => -0.010473811,
              ((real)c_femdiv_p < 7.25) => 0.00067112357,
                                           -0.010473811));

N567_7 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.388339698315), N567_8, -0.007857054));

N567_6 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N567_7, -0.011209695));

N567_5 :=__common__( if(((real)r_c13_avg_lres_d < 79.5), N567_6, N567_9));

N567_4 :=__common__( if(((real)r_c13_avg_lres_d > NULL), N567_5, 0.024077706));

N567_3 :=__common__( map(trim(C_RNT2001_P) = ''     => -0.0092535623,
              ((real)c_rnt2001_p < 7.25) => 0.00082989743,
                                            -0.0092535623));

N567_2 :=__common__( if(((real)c_wholesale < 2.34999990463), N567_3, N567_4));

N567_1 :=__common__( if(trim(C_WHOLESALE) != '', N567_2, 0.002303224));

N568_8 :=__common__( map(trim(C_SERV_EMPL) = ''      => -0.0061468937,
              ((real)c_serv_empl < 158.5) => 0.0024208766,
                                             -0.0061468937));

N568_7 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => -0.0034610209,
              ((real)f_add_curr_nhood_vac_pct_i < 0.0503664240241) => N568_8,
                                                                      -0.0034610209));

N568_6 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.0012830025,
              ((real)c_comb_age_d < 28.5)  => 0.0030775794,
                                              -0.0012830025));

N568_5 :=__common__( map(trim(C_RETAIL) = ''              => 0.0074900379,
              ((real)c_retail < 9.44999980927) => N568_6,
                                                  0.0074900379));

N568_4 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i < 3771.5), N568_5, 0.0081548848));

N568_3 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i > NULL), N568_4, 0.010862756));

N568_2 :=__common__( if(((real)c_retail < 10.8500003815), N568_3, N568_7));

N568_1 :=__common__( if(trim(C_RETAIL) != '', N568_2, 0.00065862721));

N569_9 :=__common__( map(trim(C_LARCENY) = ''      => -0.010310499,
              ((real)c_larceny < 140.5) => -0.001695449,
                                           -0.010310499));

N569_8 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => N569_9,
              ((real)f_inq_per_ssn_i < 1.5)   => 0.00016550744,
                                                 N569_9));

N569_7 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)            => N569_8,
              ((real)f_add_curr_nhood_vac_pct_i < 0.00601505115628) => -0.012238029,
                                                                       N569_8));

N569_6 :=__common__( if(((real)f_corraddrnamecount_d < 4.5), N569_7, 0.001262054));

N569_5 :=__common__( if(((real)f_corraddrnamecount_d > NULL), N569_6, 0.0005229455));

N569_4 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), 1.4484859e-006, N569_5));

N569_3 :=__common__( map(trim(C_POP_18_24_P) = ''              => N569_4,
              ((real)c_pop_18_24_p < 2.15000009537) => 0.0052887657,
                                                       N569_4));

N569_2 :=__common__( if(((real)c_hval_60k_p < 44.5499992371), N569_3, 0.0080245931));

N569_1 :=__common__( if(trim(C_HVAL_60K_P) != '', N569_2, 0.0071992422));

N570_10 :=__common__( map(trim(C_HVAL_250K_P) = ''              => 0.010008214,
               ((real)c_hval_250k_p < 5.64999961853) => 0.00037166494,
                                                        0.010008214));

N570_9 :=__common__( if(((real)f_srchphonesrchcount_i < 7.5), -0.00051401277, -0.0075711669));

N570_8 :=__common__( if(((real)f_srchphonesrchcount_i > NULL), N570_9, 0.0060447569));

N570_7 :=__common__( map(trim(C_CARTHEFT) = ''      => -0.0070311688,
              ((real)c_cartheft < 141.5) => 0.0012070905,
                                            -0.0070311688));

N570_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.121246799827), 0.0021013525, N570_7));

N570_5 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N570_6, 0.0038520228));

N570_4 :=__common__( if(((real)f_add_input_mobility_index_n < 0.359154284), N570_5, N570_8));

N570_3 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N570_4, -0.030307591));

N570_2 :=__common__( if(((real)c_hval_175k_p < 25.0499992371), N570_3, N570_10));

N570_1 :=__common__( if(trim(C_HVAL_175K_P) != '', N570_2, -0.00025200954));

N571_7 :=__common__( map(trim(C_HVAL_40K_P) = ''              => -0.010134718,
              ((real)c_hval_40k_p < 29.3499984741) => -0.00069019417,
                                                      -0.010134718));

N571_6 :=__common__( map(trim(C_BUSINESS) = ''    => -0.0019297908,
              ((real)c_business < 4.5) => 0.003711449,
                                          -0.0019297908));

N571_5 :=__common__( map(trim(C_TOTSALES) = ''       => 0.006843431,
              ((real)c_totsales < 5778.5) => N571_6,
                                             0.006843431));

N571_4 :=__common__( map(trim(C_HVAL_500K_P) = ''              => -0.004239781,
              ((real)c_hval_500k_p < 1.84999990463) => N571_5,
                                                       -0.004239781));

N571_3 :=__common__( map(trim(C_INCOLLEGE) = ''     => N571_7,
              ((real)c_incollege < 3.75) => N571_4,
                                            N571_7));

N571_2 :=__common__( if(((real)c_mil_emp < 4.44999980927), N571_3, 0.007716658));

N571_1 :=__common__( if(trim(C_MIL_EMP) != '', N571_2, -0.001675669));

N572_9 :=__common__( map(((real)f_fp_prevaddrcrimeindex_i <= NULL) => -0.012031085,
              ((real)f_fp_prevaddrcrimeindex_i < 170.5) => -0.0012208513,
                                                           -0.012031085));

N572_8 :=__common__( map(trim(C_INC_75K_P) = ''              => -0.0018236031,
              ((real)c_inc_75k_p < 9.94999980927) => 0.0038047275,
                                                     -0.0018236031));

N572_7 :=__common__( if(((real)c_hh7p_p < 2.04999995232), N572_8, N572_9));

N572_6 :=__common__( if(trim(C_HH7P_P) != '', N572_7, 0.0040515198));

N572_5 :=__common__( map(trim(C_MED_HHINC) = ''         => 0.0011174067,
              ((integer)c_med_hhinc < 20100) => 0.0098030416,
                                                0.0011174067));

N572_4 :=__common__( if(((real)c_inc_50k_p < 4.85000038147), -0.0090900097, N572_5));

N572_3 :=__common__( if(trim(C_INC_50K_P) != '', N572_4, 0.0032293485));

N572_2 :=__common__( if(((real)f_curraddrmurderindex_i < 167.5), N572_3, N572_6));

N572_1 :=__common__( if(((real)f_curraddrmurderindex_i > NULL), N572_2, 0.0056472502));

N573_10 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => -0.00089744414,
               ((real)f_mos_liens_unrel_cj_fseen_d < 182.5) => -0.010538694,
                                                               -0.00089744414));

N573_9 :=__common__( map(trim(C_POP_0_5_P) = ''              => 0.00048656021,
              ((real)c_pop_0_5_p < 8.05000019073) => -0.0034179975,
                                                     0.00048656021));

N573_8 :=__common__( if(((real)c_no_car < 181.5), N573_9, N573_10));

N573_7 :=__common__( if(trim(C_NO_CAR) != '', N573_8, -0.001099439));

N573_6 :=__common__( if(((real)f_rel_homeover50_count_d < 3.5), 0.0041939371, N573_7));

N573_5 :=__common__( if(((real)f_rel_homeover50_count_d > NULL), N573_6, -0.0078067978));

N573_4 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.00429568625987), -0.0074095452, 0.0016182256));

N573_3 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N573_4, -0.00074397529));

N573_2 :=__common__( if(((real)f_prevaddrlenofres_d < 32.5), N573_3, N573_5));

N573_1 :=__common__( if(((real)f_prevaddrlenofres_d > NULL), N573_2, -0.005670418));

N574_8 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => -0.0002120697,
              ((real)f_inq_per_ssn_i < 1.5)   => 0.010733688,
                                                 -0.0002120697));

N574_7 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => 0.00094533949,
              (segment in ['SEARS FLS'])                                  => N574_8,
                                                                             0.00094533949));

N574_6 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => 0.0026234913,
              ((real)r_c13_max_lres_d < 93.5)  => -0.012671092,
                                                  0.0026234913));

N574_5 :=__common__( if(((real)c_unempl < 76.5), N574_6, N574_7));

N574_4 :=__common__( if(trim(C_UNEMPL) != '', N574_5, 0.0011633927));

N574_3 :=__common__( map(((real)f_adl_util_conv_n <= NULL) => -0.00096163014,
              ((real)f_adl_util_conv_n < 0.5)   => N574_4,
                                                   -0.00096163014));

N574_2 :=__common__( if(((real)r_d33_eviction_count_i < 6.5), N574_3, -0.0056305582));

N574_1 :=__common__( if(((real)r_d33_eviction_count_i > NULL), N574_2, -0.0057386664));

N575_9 :=__common__( map(((real)f_mos_liens_rel_cj_fseen_d <= NULL) => -0.00021151816,
              ((real)f_mos_liens_rel_cj_fseen_d < 101.5) => -0.0092839616,
                                                            -0.00021151816));

N575_8 :=__common__( if(((real)f_rel_under25miles_cnt_d < 22.5), N575_9, 0.0053292038));

N575_7 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N575_8, -0.0017017534));

N575_6 :=__common__( map(((real)f_mos_liens_rel_ot_lseen_d <= NULL) => N575_7,
              ((real)f_mos_liens_rel_ot_lseen_d < 120.5) => -0.012594767,
                                                            N575_7));

N575_5 :=__common__( if(((real)f_srchfraudsrchcount_i < 8.5), N575_6, 0.0021972202));

N575_4 :=__common__( if(((real)f_srchfraudsrchcount_i > NULL), N575_5, -0.00027394413));

N575_3 :=__common__( map(trim(C_WHITE_COL) = ''              => N575_4,
              ((real)c_white_col < 11.3500003815) => 0.0082159403,
                                                     N575_4));

N575_2 :=__common__( if(((real)c_fammar_p < 13.9499998093), -0.0057497934, N575_3));

N575_1 :=__common__( if(trim(C_FAMMAR_P) != '', N575_2, 0.0012099188));

N576_8 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => 0.0075733818,
              ((real)r_c12_num_nonderogs_d < 8.5)   => -0.0046879135,
                                                       0.0075733818));

N576_7 :=__common__( if(((real)c_sub_bus < 128.5), N576_8, -0.0091984215));

N576_6 :=__common__( if(trim(C_SUB_BUS) != '', N576_7, -0.012028648));

N576_5 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => 0.007694928,
              ((real)f_srchssnsrchcount_i < 23.5)  => -0.00029337491,
                                                      0.007694928));

N576_4 :=__common__( map(((real)f_corraddrnamecount_d <= NULL) => 0.003293426,
              ((real)f_corraddrnamecount_d < 6.5)   => N576_5,
                                                       0.003293426));

N576_3 :=__common__( map(((real)r_a50_pb_total_orders_d <= NULL) => N576_6,
              ((real)r_a50_pb_total_orders_d < 2.5)   => N576_4,
                                                         N576_6));

N576_2 :=__common__( if(((real)f_srchssnsrchcount_i < 31.5), N576_3, -0.0061250354));

N576_1 :=__common__( if(((real)f_srchssnsrchcount_i > NULL), N576_2, 0.0051932662));

N577_8 :=__common__( if(((real)f_rel_educationover12_count_d < 18.5), 0.0030434963, 0.010495178));

N577_7 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N577_8, -0.0036185082));

N577_6 :=__common__( map(trim(C_UNEMPL) = ''      => 0.00027553909,
              ((real)c_unempl < 155.5) => N577_7,
                                          0.00027553909));

N577_5 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => -0.002687398,
              ((real)c_hist_addr_match_i < 25.5)  => N577_6,
                                                     -0.002687398));

N577_4 :=__common__( map(((real)f_util_add_curr_misc_n <= NULL) => N577_5,
              ((real)f_util_add_curr_misc_n < 0.5)   => -0.001675249,
                                                        N577_5));

N577_3 :=__common__( map(trim(C_POP_6_11_P) = ''              => -0.00083460765,
              ((real)c_pop_6_11_p < 5.94999980927) => -0.010141947,
                                                      -0.00083460765));

N577_2 :=__common__( if(((real)c_no_car < 87.5), N577_3, N577_4));

N577_1 :=__common__( if(trim(C_NO_CAR) != '', N577_2, -0.00099359028));

N578_8 :=__common__( map(((real)f_corrssnnamecount_d <= NULL) => -0.0010221536,
              ((real)f_corrssnnamecount_d < 4.5)   => 0.0020508237,
                                                      -0.0010221536));

N578_7 :=__common__( map(trim(C_HH1_P) = ''              => -0.0069367745,
              ((real)c_hh1_p < 39.9500007629) => 0.0026785088,
                                                 -0.0069367745));

N578_6 :=__common__( map(trim(C_HVAL_175K_P) = ''              => -0.0047854509,
              ((real)c_hval_175k_p < 6.94999980927) => N578_7,
                                                       -0.0047854509));

N578_5 :=__common__( if(((real)c_bargains < 188.5), N578_6, 0.0064904611));

N578_4 :=__common__( if(trim(C_BARGAINS) != '', N578_5, 0.0034397906));

N578_3 :=__common__( map(((real)c_dist_input_to_prev_addr_i <= NULL) => N578_4,
              ((real)c_dist_input_to_prev_addr_i < 0.5)   => -0.0063135626,
                                                             N578_4));

N578_2 :=__common__( if(((integer)f_addrchangeecontrajindex_d < 0), N578_3, N578_8));

N578_1 :=__common__( if(((real)f_addrchangeecontrajindex_d > NULL), N578_2, -0.0090464683));

N579_7 :=__common__( map(trim(C_LOW_ED) = ''              => 0.0016010514,
              ((real)c_low_ed < 47.9500007629) => -0.0038719871,
                                                  0.0016010514));

N579_6 :=__common__( map(trim(C_RENTOCC_P) = ''              => -0.0032811184,
              ((real)c_rentocc_p < 52.8499984741) => N579_7,
                                                     -0.0032811184));

N579_5 :=__common__( map(trim(C_SERV_EMPL) = ''     => N579_6,
              ((real)c_serv_empl < 20.5) => -0.0089538505,
                                            N579_6));

N579_4 :=__common__( map(trim(C_POP_0_5_P) = ''              => 0.013142928,
              ((real)c_pop_0_5_p < 8.55000019073) => 0.0017836881,
                                                     0.013142928));

N579_3 :=__common__( map(trim(C_HVAL_40K_P) = ''     => N579_4,
              ((real)c_hval_40k_p < 0.25) => 0.00078019719,
                                             N579_4));

N579_2 :=__common__( if(((real)c_low_hval < 4.44999980927), N579_3, N579_5));

N579_1 :=__common__( if(trim(C_LOW_HVAL) != '', N579_2, -0.0032990319));

N580_8 :=__common__( if(((real)f_srchssnsrchcount_i < 6.5), 0.0087829049, -0.00032756914));

N580_7 :=__common__( if(((real)f_srchssnsrchcount_i > NULL), N580_8, 0.026085118));

N580_6 :=__common__( map(trim(C_REST_INDX) = ''     => 0.012086903,
              ((real)c_rest_indx < 64.5) => 0.0016263598,
                                            0.012086903));

N580_5 :=__common__( map(trim(C_MURDERS) = ''      => N580_6,
              ((real)c_murders < 125.5) => -0.00091390446,
                                           N580_6));

N580_4 :=__common__( map(trim(C_FEMDIV_P) = ''     => -0.00015015265,
              ((real)c_femdiv_p < 1.75) => N580_5,
                                           -0.00015015265));

N580_3 :=__common__( map(trim(C_HVAL_150K_P) = ''              => N580_7,
              ((real)c_hval_150k_p < 27.9500007629) => N580_4,
                                                       N580_7));

N580_2 :=__common__( if(((real)c_mort_indx < 34.5), -0.0042913726, N580_3));

N580_1 :=__common__( if(trim(C_MORT_INDX) != '', N580_2, 0.0044268398));

N581_7 :=__common__( map(trim(C_HVAL_80K_P) = ''              => 0.013804362,
              ((real)c_hval_80k_p < 10.0500001907) => 0.0040358945,
                                                      0.013804362));

N581_6 :=__common__( map((segment in ['RETAIL', 'SEARS SHO'])              => -0.008934573,
              (segment in ['KMART', 'SEARS AUTO', 'SEARS FLS']) => N581_7,
                                                                   N581_7));

N581_5 :=__common__( map(trim(C_LAR_FAM) = ''     => 0.0025824326,
              ((real)c_lar_fam < 90.5) => -0.0079539999,
                                          0.0025824326));

N581_4 :=__common__( map(trim(C_FAMMAR18_P) = ''      => N581_6,
              ((real)c_fammar18_p < 27.25) => N581_5,
                                              N581_6));

N581_3 :=__common__( map(trim(C_FAMMAR_P) = ''              => -0.00040538115,
              ((real)c_fammar_p < 11.4499998093) => -0.0070596436,
                                                    -0.00040538115));

N581_2 :=__common__( if(((real)c_inc_100k_p < 16.0499992371), N581_3, N581_4));

N581_1 :=__common__( if(trim(C_INC_100K_P) != '', N581_2, 0.003068754));

N582_11 :=__common__( if(((real)f_rel_homeover150_count_d < 0.5), 0.0047017977, -0.0053447595));

N582_10 :=__common__( if(((real)f_rel_homeover150_count_d > NULL), N582_11, 0.0034071423));

N582_9 :=__common__( if(((real)c_bargains < 103.5), N582_10, 0.0024122156));

N582_8 :=__common__( if(trim(C_BARGAINS) != '', N582_9, 0.00017145522));

N582_7 :=__common__( map(((real)f_rel_count_i <= NULL) => -0.0013977213,
              ((real)f_rel_count_i < 10.5)  => -0.010819425,
                                               -0.0013977213));

N582_6 :=__common__( if(((real)f_rel_educationover8_count_d > NULL), N582_7, 0.0046973757));

N582_5 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.0186429396272), N582_6, N582_8));

N582_4 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N582_5, 0.040469751));

N582_3 :=__common__( map(trim(C_POP_35_44_P) = ''              => 2.1141958e-005,
              ((real)c_pop_35_44_p < 4.55000019073) => -0.0081794652,
                                                       2.1141958e-005));

N582_2 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => N582_3,
              ((real)f_prevaddrmedianincome_d < 14374.5) => 0.0087711937,
                                                            N582_3));

N582_1 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N582_2, N582_4));

N583_8 :=__common__( map(trim(C_HH3_P) = ''              => 0.0034290166,
              ((real)c_hh3_p < 25.5499992371) => -8.4732228e-005,
                                                 0.0034290166));

N583_7 :=__common__( map(trim(C_RENTOCC_P) = ''              => 0.0012069795,
              ((real)c_rentocc_p < 44.4500007629) => 0.011275881,
                                                     0.0012069795));

N583_6 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)    => -0.0031416191,
              ((integer)f_curraddrmedianincome_d < 45732) => N583_7,
                                                             -0.0031416191));

N583_5 :=__common__( map(trim(C_RNT500_P) = ''              => N583_6,
              ((real)c_rnt500_p < 9.94999980927) => -0.006551409,
                                                    N583_6));

N583_4 :=__common__( map(trim(C_NO_LABFOR) = ''      => -0.0098083904,
              ((real)c_no_labfor < 135.5) => N583_5,
                                             -0.0098083904));

N583_3 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d < 53.5), N583_4, N583_8));

N583_2 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d > NULL), N583_3, 0.0090923292));

N583_1 :=__common__( if(trim(C_RELIG_INDX) != '', N583_2, -0.0036647789));

N584_9 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => 0.0028082341,
              ((real)f_srchaddrsrchcount_i < 11.5)  => -0.0030305246,
                                                       0.0028082341));

N584_8 :=__common__( map(((real)f_addrchangevaluediff_d <= NULL)     => 0.0046795068,
              ((real)f_addrchangevaluediff_d < -109471.5) => -0.0060768085,
                                                             0.0046795068));

N584_7 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => N584_9,
              ((real)r_l79_adls_per_addr_curr_i < 3.5)   => N584_8,
                                                            N584_9));

N584_6 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N584_7, -0.00038731881));

N584_5 :=__common__( if(((real)c_wholesale < 2.54999995232), N584_6, -0.0025618652));

N584_4 :=__common__( if(trim(C_WHOLESALE) != '', N584_5, 0.0040383729));

N584_3 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => N584_4,
              ((real)r_d32_mos_since_crim_ls_d < 4.5)   => 0.0078027275,
                                                           N584_4));

N584_2 :=__common__( if(((real)f_vardobcount_i < 2.5), N584_3, -0.0038406052));

N584_1 :=__common__( if(((real)f_vardobcount_i > NULL), N584_2, -0.0046872245));

N585_9 :=__common__( map(trim(C_MED_HHINC) = ''        => 0.0071762563,
              ((real)c_med_hhinc < 74793.5) => -3.0557875e-005,
                                               0.0071762563));

N585_8 :=__common__( map(trim(C_INC_150K_P) = ''              => -0.0089235746,
              ((real)c_inc_150k_p < 10.6499996185) => N585_9,
                                                      -0.0089235746));

N585_7 :=__common__( if(((real)c_hh1_p < 9.64999961853), -0.005436552, N585_8));

N585_6 :=__common__( if(trim(C_HH1_P) != '', N585_7, 0.0037555277));

N585_5 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0459631122649), 0.012877381, 0.0030679325));

N585_4 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N585_5, 0.004641433));

N585_3 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => N585_4,
              ((real)f_srchssnsrchcount_i < 1.5)   => -0.0020476828,
                                                      N585_4));

N585_2 :=__common__( if(((real)f_rel_homeover50_count_d < 3.5), N585_3, N585_6));

N585_1 :=__common__( if(((real)f_rel_homeover50_count_d > NULL), N585_2, 0.00035273952));

N586_8 :=__common__( map(trim(C_FEMDIV_P) = ''              => -0.0040851489,
              ((real)c_femdiv_p < 7.14999961853) => 0.0070338484,
                                                    -0.0040851489));

N586_7 :=__common__( map(trim(C_LOWRENT) = ''      => 0.0066412792,
              ((real)c_lowrent < 89.25) => -0.0016329989,
                                           0.0066412792));

N586_6 :=__common__( map(trim(C_BLUE_EMPL) = ''      => 0.0011045816,
              ((real)c_blue_empl < 104.5) => N586_7,
                                             0.0011045816));

N586_5 :=__common__( map(trim(C_BURGLARY) = ''      => -0.0082601986,
              ((real)c_burglary < 195.5) => N586_6,
                                            -0.0082601986));

N586_4 :=__common__( if(((real)c_robbery < 193.5), N586_5, N586_8));

N586_3 :=__common__( if(trim(C_ROBBERY) != '', N586_4, 0.003170127));

N586_2 :=__common__( if(((real)f_acc_damage_amt_last_i < 5.5), N586_3, -0.0076708363));

N586_1 :=__common__( if(((real)f_acc_damage_amt_last_i > NULL), N586_2, -0.0010692982));

N587_8 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => 0.0039260392,
              ((real)r_c13_max_lres_d < 108.5) => 0.0172358,
                                                  0.0039260392));

N587_7 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.00054595309,
              ((real)c_easiqlife < 118.5) => N587_8,
                                             0.00054595309));

N587_6 :=__common__( map(((real)f_rel_homeover50_count_d <= NULL) => 1.8352311e-005,
              ((real)f_rel_homeover50_count_d < 11.5)  => 0.0045417505,
                                                          1.8352311e-005));

N587_5 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => N587_7,
              ((real)r_d30_derog_count_i < 10.5)  => N587_6,
                                                     N587_7));

N587_4 :=__common__( if(((real)c_rnt500_p < 5.05000019073), -0.0019820401, N587_5));

N587_3 :=__common__( if(trim(C_RNT500_P) != '', N587_4, -0.0022567696));

N587_2 :=__common__( if(((real)f_rel_under25miles_cnt_d < 8.5), -0.0014184603, N587_3));

N587_1 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N587_2, 0.0011644418));

N588_9 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i < 153.5), -0.0096735716, 0.0025916242));

N588_8 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N588_9, 0.026387651));

N588_7 :=__common__( map(trim(C_INC_150K_P) = ''              => -0.0098888587,
              ((real)c_inc_150k_p < 10.6499996185) => 0.00071498739,
                                                      -0.0098888587));

N588_6 :=__common__( map(trim(C_OLDHOUSE) = ''     => N588_7,
              ((real)c_oldhouse < 4.25) => 0.011107721,
                                           N588_7));

N588_5 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => -0.00026645562,
              ((real)r_c21_m_bureau_adl_fs_d < 158.5) => -0.011127419,
                                                         -0.00026645562));

N588_4 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N588_5, -0.001196887));

N588_3 :=__common__( map(trim(C_FAMMAR18_P) = ''              => N588_6,
              ((real)c_fammar18_p < 2.54999995232) => N588_4,
                                                      N588_6));

N588_2 :=__common__( if(((real)c_manufacturing < 18.75), N588_3, N588_8));

N588_1 :=__common__( if(trim(C_MANUFACTURING) != '', N588_2, -0.0019182437));

N589_9 :=__common__( if(((real)c_asian_lang < 168.5), -0.004120576, 0.0076548599));

N589_8 :=__common__( if(trim(C_ASIAN_LANG) != '', N589_9, -0.0086873127));

N589_7 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS FLS', 'SEARS SHO']) => N589_8,
              (segment in ['KMART'])                                          => 0.0015749328,
                                                                                 N589_8));

N589_6 :=__common__( map(trim(C_TRAILER_P) = ''              => -0.0029447301,
              ((real)c_trailer_p < 0.15000000596) => 0.0075502832,
                                                     -0.0029447301));

N589_5 :=__common__( if(((real)c_rich_nfam < 133.5), -0.0049111959, N589_6));

N589_4 :=__common__( if(trim(C_RICH_NFAM) != '', N589_5, 0.0013934969));

N589_3 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => N589_7,
              ((real)r_d32_mos_since_crim_ls_d < 77.5)  => N589_4,
                                                           N589_7));

N589_2 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i < 0.5), 0.0015289608, N589_3));

N589_1 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i > NULL), N589_2, -0.002442157));

N590_11 :=__common__( if(((real)c_unattach < 80.5), -0.0046092083, 0.0023992786));

N590_10 :=__common__( if(trim(C_UNATTACH) != '', N590_11, 0.0028281983));

N590_9 :=__common__( if(((real)c_burglary < 134.5), 0.00048149092, -0.0073418625));

N590_8 :=__common__( if(trim(C_BURGLARY) != '', N590_9, 0.0117542));

N590_7 :=__common__( if(((real)c_many_cars < 44.5), 0.0061105376, -0.00043487596));

N590_6 :=__common__( if(trim(C_MANY_CARS) != '', N590_7, 0.01363699));

N590_5 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.078998349607), -0.0016687113, N590_6));

N590_4 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N590_5, 0.022813197));

N590_3 :=__common__( map(((real)r_i60_inq_count12_i <= NULL) => N590_8,
              ((real)r_i60_inq_count12_i < 4.5)   => N590_4,
                                                     N590_8));

N590_2 :=__common__( if(((real)f_util_adl_count_n < 5.5), N590_3, N590_10));

N590_1 :=__common__( if(((real)f_util_adl_count_n > NULL), N590_2, -0.0051927349));

N591_10 :=__common__( if(((real)c_bigapt_p < 1.54999995232), 0.00021899232, 0.011782659));

N591_9 :=__common__( if(trim(C_BIGAPT_P) != '', N591_10, -0.032635484));

N591_8 :=__common__( map(trim(C_INC_200K_P) = ''     => 0.013812447,
              ((real)c_inc_200k_p < 0.25) => 0.0014980116,
                                             0.013812447));

N591_7 :=__common__( map(trim(C_RNT500_P) = ''      => N591_8,
              ((real)c_rnt500_p < 28.25) => -0.0011296466,
                                            N591_8));

N591_6 :=__common__( if(((real)c_assault < 190.5), -0.00078102962, N591_7));

N591_5 :=__common__( if(trim(C_ASSAULT) != '', N591_6, -0.0048528581));

N591_4 :=__common__( map(((real)f_attr_arrests_i <= NULL) => N591_9,
              ((real)f_attr_arrests_i < 0.5)   => N591_5,
                                                  N591_9));

N591_3 :=__common__( if(((real)f_attr_arrest_recency_d > NULL), N591_4, 0.003010226));

N591_2 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => 0.0072477184,
              ((real)f_add_curr_nhood_sfd_pct_d < 0.983617782593) => -0.0013529807,
                                                                     0.0072477184));

N591_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N591_2, N591_3));

N592_8 :=__common__( if(((real)c_addr_lres_12mo_ct_i < 5.5), 0.001786778, -0.005504631));

N592_7 :=__common__( if(((real)c_addr_lres_12mo_ct_i > NULL), N592_8, -0.018237509));

N592_6 :=__common__( map(trim(C_FOOD) = ''              => 0.0077997931,
              ((real)c_food < 38.5499992371) => N592_7,
                                                0.0077997931));

N592_5 :=__common__( map(trim(C_CONSTRUCTION) = ''      => 0.0011489244,
              ((real)c_construction < 17.25) => -0.0096753738,
                                                0.0011489244));

N592_4 :=__common__( map(trim(C_UNATTACH) = ''      => N592_5,
              ((real)c_unattach < 120.5) => -0.013259708,
                                            N592_5));

N592_3 :=__common__( map(trim(C_FAMMAR_P) = ''              => N592_6,
              ((real)c_fammar_p < 52.6500015259) => N592_4,
                                                    N592_6));

N592_2 :=__common__( if(((real)c_construction < 10.1499996185), 0.00066671154, N592_3));

N592_1 :=__common__( if(trim(C_CONSTRUCTION) != '', N592_2, 0.0020672844));

N593_10 :=__common__( if(((real)r_i60_inq_count12_i < 1.5), 0.010751194, 0.0026311325));

N593_9 :=__common__( if(((real)r_i60_inq_count12_i > NULL), N593_10, -0.017538094));

N593_8 :=__common__( map(trim(C_PRESCHL) = ''     => 0.00084236928,
              ((real)c_preschl < 98.5) => N593_9,
                                          0.00084236928));

N593_7 :=__common__( map(((real)f_inq_per_addr_i <= NULL) => N593_8,
              ((real)f_inq_per_addr_i < 2.5)   => -0.00031554283,
                                                  N593_8));

N593_6 :=__common__( if(((real)c_blue_col < 5.94999980927), -0.0049745765, N593_7));

N593_5 :=__common__( if(trim(C_BLUE_COL) != '', N593_6, -0.0029391246));

N593_4 :=__common__( if(((real)f_prevaddrlenofres_d < 20.5), 0.002194933, -0.0081523721));

N593_3 :=__common__( if(((real)f_prevaddrlenofres_d > NULL), N593_4, -0.016420022));

N593_2 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d < 0.220896989107), N593_3, N593_5));

N593_1 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d > NULL), N593_2, -0.010867675));

N594_9 :=__common__( if(((real)r_l70_inp_addr_dnd_i > NULL), -0.0078653567, 0.0058329362));

N594_8 :=__common__( map(trim(C_OCCUNIT_P) = ''      => 0.0078630325,
              ((real)c_occunit_p < 89.25) => -0.0030882001,
                                             0.0078630325));

N594_7 :=__common__( if(((real)r_d30_derog_count_i < 2.5), N594_8, N594_9));

N594_6 :=__common__( if(((real)r_d30_derog_count_i > NULL), N594_7, 0.076424398));

N594_5 :=__common__( map(((real)f_varmsrcssnunrelcount_i <= NULL) => -0.002441682,
              ((real)f_varmsrcssnunrelcount_i < 0.5)   => 0.0046656743,
                                                          -0.002441682));

N594_4 :=__common__( if(((real)f_rel_felony_count_i < 0.5), N594_5, 0.0013936282));

N594_3 :=__common__( if(((real)f_rel_felony_count_i > NULL), N594_4, -0.0025340763));

N594_2 :=__common__( map(((real)f_adl_util_inf_n <= NULL) => N594_6,
              ((real)f_adl_util_inf_n < 0.5)   => N594_3,
                                                  N594_6));

N594_1 :=__common__( if(trim(C_LAR_FAM) != '', N594_2, -0.0027652331));

N595_8 :=__common__( map(trim(C_OCCUNIT_P) = ''              => 0.0089518602,
              ((real)c_occunit_p < 85.8500061035) => -0.0014144127,
                                                     0.0089518602));

N595_7 :=__common__( map((fp_segment in ['1 SSN Prob', '3 New DID', '4 Bureau Only', '5 Derog', '6 Recent Activity', '7 Other']) => 7.4943671e-005,
              (fp_segment in ['2 NAS 479'])                                                                           => 0.012649589,
                                                                                                                         7.4943671e-005));

N595_6 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => -0.0042856436,
              ((real)c_hist_addr_match_i < 21.5)  => N595_7,
                                                     -0.0042856436));

N595_5 :=__common__( if(((real)f_corrssnaddrcount_d < 0.5), 0.0046661852, N595_6));

N595_4 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N595_5, 0.0014041576));

N595_3 :=__common__( map(trim(C_POP_35_44_P) = ''      => -0.007227438,
              ((real)c_pop_35_44_p < 23.75) => N595_4,
                                               -0.007227438));

N595_2 :=__common__( if(((real)c_rural_p < 99.8500061035), N595_3, N595_8));

N595_1 :=__common__( if(trim(C_RURAL_P) != '', N595_2, 0.0035300044));

N596_9 :=__common__( map(trim(C_OLDHOUSE) = ''              => 0.0077140766,
              ((real)c_oldhouse < 208.149993896) => -0.0015822331,
                                                    0.0077140766));

N596_8 :=__common__( map(((real)r_s66_adlperssn_count_i <= NULL) => 0.0070952997,
              ((real)r_s66_adlperssn_count_i < 1.5)   => N596_9,
                                                         0.0070952997));

N596_7 :=__common__( if(((real)c_trailer_p < 18.75), N596_8, -0.0062590303));

N596_6 :=__common__( if(trim(C_TRAILER_P) != '', N596_7, 0.025037793));

N596_5 :=__common__( if(((real)f_add_input_mobility_index_n < 0.412722766399), 0.00018073049, -0.008934158));

N596_4 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N596_5, 0.034021378));

N596_3 :=__common__( map(((real)c_dist_input_to_prev_addr_i <= NULL) => N596_6,
              ((real)c_dist_input_to_prev_addr_i < 2.5)   => N596_4,
                                                             N596_6));

N596_2 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i < 0.5), N596_3, -0.00087465926));

N596_1 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i > NULL), N596_2, -0.0018630526));

N597_7 :=__common__( map(trim(C_NO_LABFOR) = ''      => -0.0036640178,
              ((real)c_no_labfor < 129.5) => 0.0072540424,
                                             -0.0036640178));

N597_6 :=__common__( map(trim(C_TOTSALES) = ''         => N597_7,
              ((integer)c_totsales < 15998) => -0.0026552919,
                                               N597_7));

N597_5 :=__common__( map(trim(C_NO_TEENS) = ''     => 0.01074595,
              ((real)c_no_teens < 76.5) => -0.0024740419,
                                           0.01074595));

N597_4 :=__common__( map(trim(C_FINANCE) = ''      => N597_5,
              ((real)c_finance < 10.75) => -0.0001249164,
                                           N597_5));

N597_3 :=__common__( map(trim(C_MED_HHINC) = ''         => N597_4,
              ((integer)c_med_hhinc < 20807) => 0.0080510219,
                                                N597_4));

N597_2 :=__common__( if(((real)c_lowrent < 51.0499992371), N597_3, N597_6));

N597_1 :=__common__( if(trim(C_LOWRENT) != '', N597_2, -0.001448771));

N598_10 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => 0.0043439599,
               ((real)r_c13_avg_lres_d < 56.5)  => -0.0044494656,
                                                   0.0043439599));

N598_9 :=__common__( if(((real)f_prevaddrlenofres_d < 15.5), 0.0087940471, N598_10));

N598_8 :=__common__( if(((real)f_prevaddrlenofres_d > NULL), N598_9, -0.03329739));

N598_7 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.0234516020864), 0.010445746, -0.0010731037));

N598_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N598_7, -0.0071410553));

N598_5 :=__common__( map(trim(C_URBAN_P) = ''      => -0.0040054933,
              ((real)c_urban_p < 91.75) => N598_6,
                                           -0.0040054933));

N598_4 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N598_5, -0.0033499951));

N598_3 :=__common__( map(trim(C_HVAL_80K_P) = ''              => N598_4,
              ((real)c_hval_80k_p < 8.05000019073) => -0.00026490709,
                                                      N598_4));

N598_2 :=__common__( if(((real)c_hval_80k_p < 33.75), N598_3, N598_8));

N598_1 :=__common__( if(trim(C_HVAL_80K_P) != '', N598_2, 0.0013475766));

N599_8 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => 0.00088265392,
              ((real)f_mos_liens_unrel_cj_fseen_d < 45.5)  => -0.0029754905,
                                                              0.00088265392));

N599_7 :=__common__( map(((real)c_comb_age_d <= NULL) => N599_8,
              ((real)c_comb_age_d < 24.5)  => 0.0072241382,
                                              N599_8));

N599_6 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.0070588961,
              ((real)c_sub_bus < 105.5) => -0.0021605709,
                                           0.0070588961));

N599_5 :=__common__( if(((real)c_span_lang < 125.5), N599_6, -0.0056255845));

N599_4 :=__common__( if(trim(C_SPAN_LANG) != '', N599_5, 0.0044097164));

N599_3 :=__common__( map(((real)f_idverrisktype_i <= NULL) => -0.0087322805,
              ((integer)f_idverrisktype_i < 4)  => N599_4,
                                                   -0.0087322805));

N599_2 :=__common__( if(((real)f_m_bureau_adl_fs_all_d < 77.5), N599_3, N599_7));

N599_1 :=__common__( if(((real)f_m_bureau_adl_fs_all_d > NULL), N599_2, -0.0031341135));

N600_11 :=__common__( if(((integer)f_curraddrburglaryindex_i < 96), 0.002794735, -0.0081241955));

N600_10 :=__common__( if(((real)f_curraddrburglaryindex_i > NULL), N600_11, 0.010142577));

N600_9 :=__common__( map(trim(C_POP_12_17_P) = ''              => 0.010413026,
              ((real)c_pop_12_17_p < 11.4499998093) => 0.001498271,
                                                       0.010413026));

N600_8 :=__common__( if(((real)c_inc_50k_p < 15.75), N600_9, N600_10));

N600_7 :=__common__( if(trim(C_INC_50K_P) != '', N600_8, -0.0039082645));

N600_6 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0858011096716), 0.011206167, -0.00081906532));

N600_5 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N600_6, 0.012202472));

N600_4 :=__common__( if(((real)c_inc_75k_p < 10.0500001907), N600_5, 0.0009043776));

N600_3 :=__common__( if(trim(C_INC_75K_P) != '', N600_4, 0.013488318));

N600_2 :=__common__( map(((real)r_l77_apartment_i <= NULL) => N600_3,
              ((real)r_l77_apartment_i < 0.5)   => -0.0010377621,
                                                   N600_3));

N600_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N600_2, N600_7));

N601_9 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => -0.01458699,
              ((real)r_c13_avg_lres_d < 86.5)  => 0.0017166496,
                                                  -0.01458699));

N601_8 :=__common__( map(trim(C_FOOD) = ''              => -0.0038146579,
              ((real)c_food < 9.35000038147) => 0.0074260447,
                                                -0.0038146579));

N601_7 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => N601_8,
              ((real)f_mos_liens_unrel_cj_fseen_d < 145.5) => 0.0093740997,
                                                              N601_8));

N601_6 :=__common__( if(((integer)r_f01_inp_addr_address_score_d < 11), N601_7, -0.00013318568));

N601_5 :=__common__( if(((real)r_f01_inp_addr_address_score_d > NULL), N601_6, 0.013538833));

N601_4 :=__common__( map(((real)c_comb_age_d <= NULL) => N601_9,
              ((real)c_comb_age_d < 56.5)  => N601_5,
                                              N601_9));

N601_3 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 5.5), 0.005861385, N601_4));

N601_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N601_3, -0.0003868285));

N601_1 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N601_2, -0.00048188295));

N602_9 :=__common__( map(((real)f_crim_rel_under100miles_cnt_i <= NULL) => -0.0015916628,
              ((real)f_crim_rel_under100miles_cnt_i < 11.5)  => 0.010807833,
                                                                -0.0015916628));

N602_8 :=__common__( map(trim(C_HH00) = ''       => 0.0093111295,
              ((integer)c_hh00 < 878) => -0.0018117925,
                                         0.0093111295));

N602_7 :=__common__( if(((real)c_pop_55_64_p < 10.9499998093), N602_8, N602_9));

N602_6 :=__common__( if(trim(C_POP_55_64_P) != '', N602_7, 0.0072267041));

N602_5 :=__common__( if(((real)r_l72_add_vacant_i < 0.5), -0.00067946982, 0.0066869389));

N602_4 :=__common__( if(((real)r_l72_add_vacant_i > NULL), N602_5, 0.014519295));

N602_3 :=__common__( map(((real)f_rel_count_i <= NULL) => N602_6,
              ((real)f_rel_count_i < 28.5)  => N602_4,
                                               N602_6));

N602_2 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 11.5), 0.0070279311, N602_3));

N602_1 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N602_2, 0.0020296293));

N603_9 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => -0.0059324172,
              ((real)f_curraddrmedianincome_d < 29041.5) => 0.0070992793,
                                                            -0.0059324172));

N603_8 :=__common__( map(((real)f_prevaddrageoldest_d <= NULL) => N603_9,
              ((real)f_prevaddrageoldest_d < 30.5)  => 0.0078953546,
                                                       N603_9));

N603_7 :=__common__( map(trim(C_LARCENY) = ''      => N603_8,
              ((real)c_larceny < 113.5) => 0.013277237,
                                           N603_8));

N603_6 :=__common__( if(((real)f_prevaddrstatus_i < 2.5), 0.0022529854, -0.0064255754));

N603_5 :=__common__( if(((real)f_prevaddrstatus_i > NULL), N603_6, -0.00099989591));

N603_4 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i < 150.5), N603_5, N603_7));

N603_3 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N603_4, 0.012116426));

N603_2 :=__common__( if(((real)c_pop_12_17_p < 6.25), N603_3, -0.00079250434));

N603_1 :=__common__( if(trim(C_POP_12_17_P) != '', N603_2, -0.0032686445));

N604_10 :=__common__( if(((real)c_unemp < 10.25), -0.00084822042, -0.0070844097));

N604_9 :=__common__( if(trim(C_UNEMP) != '', N604_10, -0.001240049));

N604_8 :=__common__( map(trim(C_INC_35K_P) = ''              => -0.0055882433,
              ((real)c_inc_35k_p < 9.64999961853) => 0.0030894653,
                                                     -0.0055882433));

N604_7 :=__common__( if(((real)f_rel_under25miles_cnt_d < 4.5), -0.0021805855, 0.0042085222));

N604_6 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N604_7, -0.0019730987));

N604_5 :=__common__( if(((real)c_hh5_p < 9.14999961853), N604_6, N604_8));

N604_4 :=__common__( if(trim(C_HH5_P) != '', N604_5, -0.0033629879));

N604_3 :=__common__( map(((real)c_addr_lres_2mo_ct_i <= NULL) => N604_9,
              ((real)c_addr_lres_2mo_ct_i < 1.5)   => N604_4,
                                                      N604_9));

N604_2 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 33.5), 0.0022171231, N604_3));

N604_1 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N604_2, -0.0036508311));

N605_9 :=__common__( map(((real)r_i60_inq_comm_count12_i <= NULL) => -0.0048475431,
              ((real)r_i60_inq_comm_count12_i < 2.5)   => 0.0012169756,
                                                          -0.0048475431));

N605_8 :=__common__( if(((real)c_pop00 < 684.5), 0.0069125349, N605_9));

N605_7 :=__common__( if(trim(C_POP00) != '', N605_8, 0.00083690494));

N605_6 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL)  => -0.0016691831,
              ((integer)r_a50_pb_total_dollars_d < 640) => 0.011278136,
                                                           -0.0016691831));

N605_5 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => -0.00424161,
              ((real)f_curraddrburglaryindex_i < 149.5) => -0.00070254338,
                                                           -0.00424161));

N605_4 :=__common__( if(((real)c_trailer_p < 32.6500015259), N605_5, N605_6));

N605_3 :=__common__( if(trim(C_TRAILER_P) != '', N605_4, 0.0037155108));

N605_2 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d < 37.5), N605_3, N605_7));

N605_1 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d > NULL), N605_2, -0.0041757358));

N606_9 :=__common__( map(trim(C_UNEMP) = ''              => -0.0082103932,
              ((real)c_unemp < 5.14999961853) => 0.0030291762,
                                                 -0.0082103932));

N606_8 :=__common__( map(((real)r_d33_eviction_count_i <= NULL) => N606_9,
              ((real)r_d33_eviction_count_i < 5.5)   => 0.0014381484,
                                                        N606_9));

N606_7 :=__common__( if(((real)f_mos_liens_unrel_ot_lseen_d < 73.5), -0.0073939627, N606_8));

N606_6 :=__common__( if(((real)f_mos_liens_unrel_ot_lseen_d > NULL), N606_7, 7.0498852e-006));

N606_5 :=__common__( map(trim(C_LOW_ED) = ''              => -0.002837355,
              ((real)c_low_ed < 57.4500007629) => 0.0036367996,
                                                  -0.002837355));

N606_4 :=__common__( if(((real)c_hist_addr_match_i < 1.5), -0.0060423519, N606_5));

N606_3 :=__common__( if(((real)c_hist_addr_match_i > NULL), N606_4, 0.0074281663));

N606_2 :=__common__( if(((real)c_easiqlife < 77.5), N606_3, N606_6));

N606_1 :=__common__( if(trim(C_EASIQLIFE) != '', N606_2, 0.0024914414));

N607_10 :=__common__( map(((real)r_l79_adls_per_addr_c6_i <= NULL) => 0.0031011702,
               ((real)r_l79_adls_per_addr_c6_i < 1.5)   => -0.00069316608,
                                                           0.0031011702));

N607_9 :=__common__( map(trim(C_RENTOCC_P) = ''              => 0.0043499028,
              ((real)c_rentocc_p < 49.8499984741) => -0.0074929258,
                                                     0.0043499028));

N607_8 :=__common__( if(((real)c_rental < 170.5), -0.007170865, N607_9));

N607_7 :=__common__( if(trim(C_RENTAL) != '', N607_8, -0.031452845));

N607_6 :=__common__( if(((real)f_rel_ageover30_count_d < 7.5), -0.0048375951, 0.0054929331));

N607_5 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N607_6, 0.015064714));

N607_4 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.123229235411), N607_5, N607_7));

N607_3 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N607_4, -0.0016826176));

N607_2 :=__common__( if(((real)r_c13_max_lres_d < 54.5), N607_3, N607_10));

N607_1 :=__common__( if(((real)r_c13_max_lres_d > NULL), N607_2, -0.0073125432));

N608_8 :=__common__( map(((real)f_componentcharrisktype_i <= NULL) => 0.0036492382,
              ((real)f_componentcharrisktype_i < 5.5)   => 0.00035764045,
                                                           0.0036492382));

N608_7 :=__common__( if(((real)c_popover25 < 895.5), -0.0066819717, 9.1046238e-005));

N608_6 :=__common__( if(trim(C_POPOVER25) != '', N608_7, 0.0041380623));

N608_5 :=__common__( map(((real)c_addr_lres_12mo_ct_i <= NULL) => N608_6,
              ((real)c_addr_lres_12mo_ct_i < 2.5)   => 0.0039811963,
                                                       N608_6));

N608_4 :=__common__( map(((real)c_dist_input_to_prev_addr_i <= NULL) => 0.0052518108,
              ((real)c_dist_input_to_prev_addr_i < 61.5)  => N608_5,
                                                             0.0052518108));

N608_3 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => -0.0051918338,
              ((real)f_curraddrburglaryindex_i < 163.5) => N608_4,
                                                           -0.0051918338));

N608_2 :=__common__( if(((real)f_srchaddrsrchcount_i < 2.5), N608_3, N608_8));

N608_1 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N608_2, -0.0059179058));

N609_9 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => -0.0025503189,
              ((real)f_add_curr_nhood_vac_pct_i < 0.0624458417296) => 0.0050646247,
                                                                      -0.0025503189));

N609_8 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => N609_9,
              ((real)r_c13_max_lres_d < 54.5)  => -0.0068957748,
                                                  N609_9));

N609_7 :=__common__( if(((real)c_blue_col < 13.9499998093), -0.010574285, 0.00078177871));

N609_6 :=__common__( if(trim(C_BLUE_COL) != '', N609_7, 0.084143542));

N609_5 :=__common__( if(((integer)r_l80_inp_avm_autoval_d < 60698), 0.0036418586, N609_6));

N609_4 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N609_5, N609_8));

N609_3 :=__common__( map(((real)f_rel_under25miles_cnt_d <= NULL) => N609_4,
              ((real)f_rel_under25miles_cnt_d < 12.5)  => -0.0061743869,
                                                          N609_4));

N609_2 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 6.5), 0.0010443376, N609_3));

N609_1 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N609_2, 0.0018017212));

N610_7 :=__common__( map(trim(C_VACANT_P) = ''      => 0.0078247036,
              ((real)c_vacant_p < 23.25) => -0.0019744236,
                                            0.0078247036));

N610_6 :=__common__( map(trim(C_HH2_P) = ''              => N610_7,
              ((real)c_hh2_p < 24.6500015259) => -0.0055877367,
                                                 N610_7));

N610_5 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => 0.0068063465,
              ((real)f_add_curr_nhood_vac_pct_i < 0.363135933876) => N610_6,
                                                                     0.0068063465));

N610_4 :=__common__( map(trim(C_HH1_P) = ''              => 0.0091368557,
              ((real)c_hh1_p < 50.5499992371) => N610_5,
                                                 0.0091368557));

N610_3 :=__common__( map(trim(C_WHITE_COL) = ''      => 0.0013743752,
              ((real)c_white_col < 23.25) => N610_4,
                                             0.0013743752));

N610_2 :=__common__( if(((real)c_pop_25_34_p < 5.05000019073), -0.0042026242, N610_3));

N610_1 :=__common__( if(trim(C_POP_25_34_P) != '', N610_2, 0.00016525798));

N611_9 :=__common__( map(trim(C_SUB_BUS) = ''     => 0.00029789836,
              ((real)c_sub_bus < 78.5) => 0.010889272,
                                          0.00029789836));

N611_8 :=__common__( if(((real)f_srchaddrsrchcount_i < 22.5), -0.0028806305, 0.0036586422));

N611_7 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N611_8, 0.0075934696));

N611_6 :=__common__( if(((real)f_rel_educationover12_count_d < 27.5), -0.001614487, 0.0084837391));

N611_5 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N611_6, -0.0043262651));

N611_4 :=__common__( map(trim(C_HHSIZE) = ''              => 0.0023281637,
              ((real)c_hhsize < 2.54500007629) => N611_5,
                                                  0.0023281637));

N611_3 :=__common__( map(trim(C_CHILD) = ''              => N611_7,
              ((real)c_child < 28.0499992371) => N611_4,
                                                 N611_7));

N611_2 :=__common__( if(((real)c_hval_80k_p < 41.5499992371), N611_3, N611_9));

N611_1 :=__common__( if(trim(C_HVAL_80K_P) != '', N611_2, -0.0014558885));

N612_8 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => 0.010030233,
              ((real)f_mos_inq_banko_cm_lseen_d < 43.5)  => -0.00031839087,
                                                            0.010030233));

N612_7 :=__common__( if(((real)c_health < 41.8499984741), -0.0021599846, -0.010106408));

N612_6 :=__common__( if(trim(C_HEALTH) != '', N612_7, 0.0019373519));

N612_5 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => N612_8,
              ((real)f_rel_felony_count_i < 4.5)   => N612_6,
                                                      N612_8));

N612_4 :=__common__( map(((real)f_corrrisktype_i <= NULL) => 0.0042166896,
              ((real)f_corrrisktype_i < 8.5)   => 0.00022820936,
                                                  0.0042166896));

N612_3 :=__common__( map(((real)f_srchunvrfdphonecount_i <= NULL) => 0.0082878118,
              ((real)f_srchunvrfdphonecount_i < 3.5)   => N612_4,
                                                          0.0082878118));

N612_2 :=__common__( if(((real)f_rel_bankrupt_count_i < 2.5), N612_3, N612_5));

N612_1 :=__common__( if(((real)f_rel_bankrupt_count_i > NULL), N612_2, 0.0082300305));

N613_8 :=__common__( map(trim(C_CHILD) = ''      => 0.0042667959,
              ((real)c_child < 27.75) => -0.0054730652,
                                         0.0042667959));

N613_7 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => N613_8,
              ((real)f_mos_inq_banko_om_fseen_d < 34.5)  => 0.0049134715,
                                                            N613_8));

N613_6 :=__common__( if(((real)c_pop_85p_p < 2.95000004768), N613_7, 0.010173114));

N613_5 :=__common__( if(trim(C_POP_85P_P) != '', N613_6, 0.022097283));

N613_4 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => N613_5,
              ((real)f_inq_other_count24_i < 2.5)   => -0.00040605426,
                                                       N613_5));

N613_3 :=__common__( map(((real)f_rel_criminal_count_i <= NULL) => -0.0084170519,
              ((real)f_rel_criminal_count_i < 21.5)  => N613_4,
                                                        -0.0084170519));

N613_2 :=__common__( if(((real)r_d32_criminal_count_i < 22.5), N613_3, 0.0069826239));

N613_1 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N613_2, 0.003991643));

N614_9 :=__common__( if(((real)f_curraddrmurderindex_i < 147.5), 0.013847136, 0.0008645666));

N614_8 :=__common__( if(((real)f_curraddrmurderindex_i > NULL), N614_9, 0.058847841));

N614_7 :=__common__( map(trim(C_REST_INDX) = ''      => N614_8,
              ((real)c_rest_indx < 123.5) => 0.00072788727,
                                             N614_8));

N614_6 :=__common__( map(trim(C_OLDHOUSE) = ''              => 0.00054541183,
              ((real)c_oldhouse < 148.049987793) => 0.014781966,
                                                    0.00054541183));

N614_5 :=__common__( map(trim(C_MED_HVAL) = ''          => N614_6,
              ((integer)c_med_hval < 297707) => -0.00017070439,
                                                N614_6));

N614_4 :=__common__( if(((real)c_hist_addr_match_i < 2.5), -0.0022874244, N614_5));

N614_3 :=__common__( if(((real)c_hist_addr_match_i > NULL), N614_4, -0.0024954389));

N614_2 :=__common__( if(((real)c_born_usa < 156.5), N614_3, N614_7));

N614_1 :=__common__( if(trim(C_BORN_USA) != '', N614_2, 0.0013840499));

N615_8 :=__common__( map(trim(C_LAR_FAM) = ''      => 0.011537673,
              ((real)c_lar_fam < 151.5) => 0.002678118,
                                           0.011537673));

N615_7 :=__common__( map(trim(C_VERY_RICH) = ''      => -0.0027126755,
              ((real)c_very_rich < 128.5) => N615_8,
                                             -0.0027126755));

N615_6 :=__common__( map(trim(C_HH6_P) = ''              => -0.0045188852,
              ((real)c_hh6_p < 7.14999961853) => N615_7,
                                                 -0.0045188852));

N615_5 :=__common__( map(trim(C_OWNOCC_P) = ''              => 0.0086125425,
              ((real)c_ownocc_p < 87.0500030518) => -0.0013387942,
                                                    0.0086125425));

N615_4 :=__common__( if(((real)f_prevaddrlenofres_d < 49.5), N615_5, N615_6));

N615_3 :=__common__( if(((real)f_prevaddrlenofres_d > NULL), N615_4, -0.0098304675));

N615_2 :=__common__( if(((real)c_pop_25_34_p < 24.8499984741), N615_3, -0.0050650045));

N615_1 :=__common__( if(trim(C_POP_25_34_P) != '', N615_2, -0.0016132982));

N616_8 :=__common__( map(trim(C_BORN_USA) = ''     => 0.0055187324,
              ((real)c_born_usa < 50.5) => -0.0023288286,
                                           0.0055187324));

N616_7 :=__common__( map(((real)f_prevaddrageoldest_d <= NULL) => -0.0023500448,
              ((real)f_prevaddrageoldest_d < 44.5)  => 0.0022471578,
                                                       -0.0023500448));

N616_6 :=__common__( map(trim(C_POP_6_11_P) = ''              => N616_8,
              ((real)c_pop_6_11_p < 9.85000038147) => N616_7,
                                                      N616_8));

N616_5 :=__common__( map(((real)r_d34_unrel_liens_ct_i <= NULL) => 0.0089737911,
              ((real)r_d34_unrel_liens_ct_i < 8.5)   => N616_6,
                                                        0.0089737911));

N616_4 :=__common__( if(((real)c_trailer_p < 0.0500000007451), N616_5, -0.00066769057));

N616_3 :=__common__( if(trim(C_TRAILER_P) != '', N616_4, -2.721572e-005));

N616_2 :=__common__( if(((real)f_vardobcount_i < 2.5), N616_3, -0.0030190453));

N616_1 :=__common__( if(((real)f_vardobcount_i > NULL), N616_2, -0.0010337474));

N617_8 :=__common__( map(((real)f_rel_criminal_count_i <= NULL) => -0.011308708,
              ((real)f_rel_criminal_count_i < 5.5)   => -0.00022818283,
                                                        -0.011308708));

N617_7 :=__common__( map(trim(C_RAPE) = ''     => 6.4014027e-005,
              ((real)c_rape < 72.5) => 0.013358002,
                                       6.4014027e-005));

N617_6 :=__common__( map(trim(C_VERY_RICH) = ''      => 0.0078001092,
              ((real)c_very_rich < 174.5) => -0.0031791461,
                                             0.0078001092));

N617_5 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => N617_7,
              ((real)f_rel_felony_count_i < 1.5)   => N617_6,
                                                      N617_7));

N617_4 :=__common__( if(((real)r_c10_m_hdr_fs_d < 161.5), N617_5, 0.0014493213));

N617_3 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N617_4, 0.0074074025));

N617_2 :=__common__( if(((real)c_unemp < 13.75), N617_3, N617_8));

N617_1 :=__common__( if(trim(C_UNEMP) != '', N617_2, -0.0044629594));

N618_8 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)             => 0.0032709675,
              ((real)f_add_input_nhood_vac_pct_i < 0.000490797800012) => -0.0050230049,
                                                                         0.0032709675));

N618_7 :=__common__( if(((real)f_srchfraudsrchcount_i < 11.5), -0.0026646615, 0.0014056917));

N618_6 :=__common__( if(((real)f_srchfraudsrchcount_i > NULL), N618_7, 0.011480701));

N618_5 :=__common__( map(trim(C_FAMILIES) = ''      => 0.0017910146,
              ((real)c_families < 382.5) => N618_6,
                                            0.0017910146));

N618_4 :=__common__( map(trim(C_EASIQLIFE) = ''      => -0.0087678108,
              ((real)c_easiqlife < 149.5) => N618_5,
                                             -0.0087678108));

N618_3 :=__common__( map(trim(C_LOW_ED) = ''              => -0.0092416438,
              ((real)c_low_ed < 84.3500061035) => N618_4,
                                                  -0.0092416438));

N618_2 :=__common__( if(((real)c_rnt1250_p < 2.25), N618_3, N618_8));

N618_1 :=__common__( if(trim(C_RNT1250_P) != '', N618_2, 0.0020112222));

N619_7 :=__common__( map(trim(C_FAMMAR18_P) = ''              => 0.0024709599,
              ((real)c_fammar18_p < 21.0499992371) => 0.011134789,
                                                      0.0024709599));

N619_6 :=__common__( map(trim(C_RNT750_P) = ''              => -0.0031380845,
              ((real)c_rnt750_p < 58.0499992371) => N619_7,
                                                    -0.0031380845));

N619_5 :=__common__( map(trim(C_INC_50K_P) = ''              => N619_6,
              ((real)c_inc_50k_p < 20.5499992371) => 0.00019443468,
                                                     N619_6));

N619_4 :=__common__( map(trim(C_HVAL_100K_P) = ''      => -0.010059025,
              ((real)c_hval_100k_p < 16.75) => -0.00034565217,
                                               -0.010059025));

N619_3 :=__common__( map(trim(C_FAMMAR18_P) = ''              => N619_5,
              ((real)c_fammar18_p < 3.95000004768) => N619_4,
                                                      N619_5));

N619_2 :=__common__( if(((real)c_low_ed < 81.8500061035), N619_3, -0.0053146315));

N619_1 :=__common__( if(trim(C_LOW_ED) != '', N619_2, 0.0013820943));

N620_9 :=__common__( map(trim(C_SERV_EMPL) = ''      => 0.0007561819,
              ((real)c_serv_empl < 101.5) => 0.012788932,
                                             0.0007561819));

N620_8 :=__common__( map((fp_segment in ['1 SSN Prob', '2 NAS 479', '4 Bureau Only', '6 Recent Activity']) => -0.0034573517,
              (fp_segment in ['3 New DID', '5 Derog', '7 Other'])                               => 0.0022253367,
                                                                                                   -0.0034573517));

N620_7 :=__common__( map(((real)f_corrssnnamecount_d <= NULL) => -0.0014617085,
              ((real)f_corrssnnamecount_d < 4.5)   => 0.0019948974,
                                                      -0.0014617085));

N620_6 :=__common__( if(((real)f_addrchangeincomediff_d < 37626.5), N620_7, 0.0088841647));

N620_5 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N620_6, N620_8));

N620_4 :=__common__( if(((real)f_srchcomponentrisktype_i < 2.5), N620_5, N620_9));

N620_3 :=__common__( if(((real)f_srchcomponentrisktype_i > NULL), N620_4, -0.0069845148));

N620_2 :=__common__( if(((real)c_inc_35k_p < 3.95000004768), -0.0048777004, N620_3));

N620_1 :=__common__( if(trim(C_INC_35K_P) != '', N620_2, -0.0018526939));

N621_9 :=__common__( map(((real)f_current_count_d <= NULL) => -0.0017940807,
              ((real)f_current_count_d < 1.5)   => 0.0031124278,
                                                   -0.0017940807));

N621_8 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)    => N621_9,
              ((integer)f_curraddrmedianincome_d < 24026) => -0.0035301705,
                                                             N621_9));

N621_7 :=__common__( if(((real)c_lar_fam < 156.5), N621_8, 0.0062743226));

N621_6 :=__common__( if(trim(C_LAR_FAM) != '', N621_7, 0.0015539183));

N621_5 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.010888999,
              ((real)c_sub_bus < 150.5) => 0.00097015419,
                                           0.010888999));

N621_4 :=__common__( if(((real)c_hval_200k_p < 12.6499996185), -0.0021253185, N621_5));

N621_3 :=__common__( if(trim(C_HVAL_200K_P) != '', N621_4, 0.00021629272));

N621_2 :=__common__( if(((real)r_c10_m_hdr_fs_d < 182.5), N621_3, N621_6));

N621_1 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N621_2, 0.0031779966));

N622_9 :=__common__( map(trim(C_UNEMPL) = ''      => -0.0010924628,
              ((real)c_unempl < 164.5) => 0.013212961,
                                          -0.0010924628));

N622_8 :=__common__( map(trim(C_UNEMPL) = ''      => N622_9,
              ((real)c_unempl < 125.5) => -0.0049235632,
                                          N622_9));

N622_7 :=__common__( if(((real)f_prevaddrmedianvalue_d < 153375.5), N622_8, 0.011567959));

N622_6 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N622_7, 0.014657213));

N622_5 :=__common__( map(trim(C_LAR_FAM) = ''      => -0.0015536518,
              ((real)c_lar_fam < 100.5) => 0.00074604976,
                                           -0.0015536518));

N622_4 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 11.5), 0.0070510052, N622_5));

N622_3 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N622_4, -0.011495973));

N622_2 :=__common__( if(((real)c_rnt750_p < 67.5500030518), N622_3, N622_6));

N622_1 :=__common__( if(trim(C_RNT750_P) != '', N622_2, -0.0030147652));

N623_8 :=__common__( map(trim(C_HVAL_1000K_P) = ''               => -0.0065089709,
              ((real)c_hval_1000k_p < 0.649999976158) => 0.0016741291,
                                                         -0.0065089709));

N623_7 :=__common__( map(trim(C_HVAL_750K_P) = ''              => 0.0099957719,
              ((real)c_hval_750k_p < 8.44999980927) => N623_8,
                                                       0.0099957719));

N623_6 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => N623_7,
              ((real)f_curraddrburglaryindex_i < 99.5)  => -0.001183816,
                                                           N623_7));

N623_5 :=__common__( map(trim(C_BEL_EDU) = ''      => -0.0052327428,
              ((real)c_bel_edu < 193.5) => N623_6,
                                           -0.0052327428));

N623_4 :=__common__( if(((real)f_curraddrburglaryindex_i > NULL), N623_5, 0.015015056));

N623_3 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.002613556,
              ((real)c_comb_age_d < 47.5)  => N623_4,
                                              -0.002613556));

N623_2 :=__common__( if(((real)c_work_home < 181.5), N623_3, -0.0058572382));

N623_1 :=__common__( if(trim(C_WORK_HOME) != '', N623_2, -0.0026199737));

N624_8 :=__common__( map(((real)f_rel_bankrupt_count_i <= NULL) => -0.0014900755,
              ((real)f_rel_bankrupt_count_i < 2.5)   => 0.0011845535,
                                                        -0.0014900755));

N624_7 :=__common__( map(trim(C_RICH_FAM) = ''      => -0.0079721431,
              ((real)c_rich_fam < 122.5) => 0.0019228649,
                                            -0.0079721431));

N624_6 :=__common__( map(trim(C_INC_100K_P) = ''     => -0.0029668943,
              ((real)c_inc_100k_p < 6.75) => -0.012701019,
                                             -0.0029668943));

N624_5 :=__common__( map(trim(C_LARCENY) = ''      => 0.00068227056,
              ((real)c_larceny < 180.5) => N624_6,
                                           0.00068227056));

N624_4 :=__common__( if(((real)c_white_col < 21.3499984741), N624_5, N624_7));

N624_3 :=__common__( if(trim(C_WHITE_COL) != '', N624_4, 0.00049656671));

N624_2 :=__common__( if(((integer)f_estimated_income_d < 26500), N624_3, N624_8));

N624_1 :=__common__( if(((real)f_estimated_income_d > NULL), N624_2, -0.00085790797));

N625_10 :=__common__( map(trim(C_INC_25K_P) = ''              => 0.00027679097,
               ((real)c_inc_25k_p < 8.64999961853) => -0.0055920688,
                                                      0.00027679097));

N625_9 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 70.5), 0.0018185898, N625_10));

N625_8 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N625_9, -0.0010111819));

N625_7 :=__common__( map(trim(C_NEW_HOMES) = ''      => -0.0085037024,
              ((real)c_new_homes < 194.5) => N625_8,
                                             -0.0085037024));

N625_6 :=__common__( if(((real)c_inc_75k_p < 28.9500007629), N625_7, 0.0075285697));

N625_5 :=__common__( if(trim(C_INC_75K_P) != '', N625_6, -0.00055652177));

N625_4 :=__common__( if(((real)c_totsales < 5294.5), -0.0042020394, 0.00091096902));

N625_3 :=__common__( if(trim(C_TOTSALES) != '', N625_4, -0.0026460131));

N625_2 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0186772998422), N625_3, N625_5));

N625_1 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N625_2, -0.0014999318));

N626_8 :=__common__( map(trim(C_POPOVER25) = ''       => 0.0010040947,
              ((integer)c_popover25 < 660) => -0.0065560277,
                                              0.0010040947));

N626_7 :=__common__( map(trim(C_HVAL_300K_P) = ''              => 0.011939339,
              ((real)c_hval_300k_p < 4.05000019073) => 0.0031466568,
                                                       0.011939339));

N626_6 :=__common__( map(trim(C_CHILD) = ''      => N626_7,
              ((real)c_child < 27.75) => 0.00067234891,
                                         N626_7));

N626_5 :=__common__( map(trim(C_HH4_P) = ''              => N626_8,
              ((real)c_hh4_p < 17.0499992371) => N626_6,
                                                 N626_8));

N626_4 :=__common__( if(((real)r_d30_derog_count_i > NULL), N626_5, -0.0016630009));

N626_3 :=__common__( map(trim(C_HVAL_150K_P) = ''              => 0.005451405,
              ((real)c_hval_150k_p < 28.1500015259) => -0.001232445,
                                                       0.005451405));

N626_2 :=__common__( if(((real)c_young < 25.5499992371), N626_3, N626_4));

N626_1 :=__common__( if(trim(C_YOUNG) != '', N626_2, 0.00019791084));

N627_7 :=__common__( map(trim(C_HVAL_100K_P) = ''     => 0.0003010791,
              ((real)c_hval_100k_p < 6.25) => -0.012577357,
                                              0.0003010791));

N627_6 :=__common__( map(trim(C_INCOLLEGE) = ''              => 0.0013683608,
              ((real)c_incollege < 3.65000009537) => 0.012373444,
                                                     0.0013683608));

N627_5 :=__common__( map(trim(C_TOTSALES) = ''         => N627_6,
              ((integer)c_totsales < 34568) => -0.00028549131,
                                               N627_6));

N627_4 :=__common__( map(trim(C_HH00) = ''       => N627_7,
              ((real)c_hh00 < 1192.5) => N627_5,
                                         N627_7));

N627_3 :=__common__( map(trim(C_HEALTH) = ''              => 0.01276628,
              ((real)c_health < 9.35000038147) => 0.00030610929,
                                                  0.01276628));

N627_2 :=__common__( if(((real)c_murders < 26.5), N627_3, N627_4));

N627_1 :=__common__( if(trim(C_MURDERS) != '', N627_2, 0.00045595514));

N628_8 :=__common__( map(trim(C_PRESCHL) = ''      => 0.0087004097,
              ((real)c_preschl < 140.5) => -0.0010546347,
                                           0.0087004097));

N628_7 :=__common__( map(trim(C_HVAL_40K_P) = ''              => N628_8,
              ((real)c_hval_40k_p < 1.95000004768) => -0.0041457908,
                                                      N628_8));

N628_6 :=__common__( if(((real)f_inq_highriskcredit_count24_i < 1.5), -0.0040356875, -0.013676229));

N628_5 :=__common__( if(((real)f_inq_highriskcredit_count24_i > NULL), N628_6, -0.031555213));

N628_4 :=__common__( map(trim(C_WHITE_COL) = ''              => N628_7,
              ((real)c_white_col < 23.5499992371) => N628_5,
                                                     N628_7));

N628_3 :=__common__( map(trim(C_INC_50K_P) = ''              => N628_4,
              ((real)c_inc_50k_p < 9.35000038147) => 0.003003118,
                                                     N628_4));

N628_2 :=__common__( if(((real)c_hh3_p < 21.5499992371), 0.00048768393, N628_3));

N628_1 :=__common__( if(trim(C_HH3_P) != '', N628_2, -0.0005877219));

N629_8 :=__common__( map(trim(C_REST_INDX) = ''      => -0.0040271672,
              ((real)c_rest_indx < 111.5) => 0.0061414333,
                                             -0.0040271672));

N629_7 :=__common__( map(trim(C_FAMMAR_P) = ''              => -0.0030984385,
              ((real)c_fammar_p < 64.4499969482) => 0.013390382,
                                                    -0.0030984385));

N629_6 :=__common__( map(trim(C_EMPLOYEES) = ''      => N629_7,
              ((real)c_employees < 723.5) => -0.0024672254,
                                             N629_7));

N629_5 :=__common__( map(trim(C_SERV_EMPL) = ''      => N629_8,
              ((real)c_serv_empl < 171.5) => N629_6,
                                             N629_8));

N629_4 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N629_5, -0.00035402615));

N629_3 :=__common__( map(trim(C_POP_18_24_P) = ''              => N629_4,
              ((real)c_pop_18_24_p < 2.15000009537) => 0.0053525371,
                                                       N629_4));

N629_2 :=__common__( if(((real)c_mort_indx < 167.5), N629_3, -0.0078301995));

N629_1 :=__common__( if(trim(C_MORT_INDX) != '', N629_2, -0.00061617521));

N630_8 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => -0.0083647949,
              ((real)f_add_input_mobility_index_n < 0.386954367161) => -0.0018250172,
                                                                       -0.0083647949));

N630_7 :=__common__( map(trim(C_FOR_SALE) = ''      => 0.0062054637,
              ((real)c_for_sale < 124.5) => -0.0022040364,
                                            0.0062054637));

N630_6 :=__common__( if(((real)f_corrssnaddrcount_d < 2.5), N630_7, N630_8));

N630_5 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N630_6, -0.0025181219));

N630_4 :=__common__( map(trim(C_HVAL_250K_P) = ''              => 0.0040898278,
              ((real)c_hval_250k_p < 12.1499996185) => 0.00018372732,
                                                       0.0040898278));

N630_3 :=__common__( map(trim(C_EXP_PROD) = ''      => N630_5,
              ((real)c_exp_prod < 105.5) => N630_4,
                                            N630_5));

N630_2 :=__common__( if(((real)c_rnt500_p < 80.5500030518), N630_3, 0.0080010967));

N630_1 :=__common__( if(trim(C_RNT500_P) != '', N630_2, 0.0012582039));

N631_8 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => -0.00054906001,
              ((real)f_inq_adls_per_phone_i < 0.5)   => 0.0058101803,
                                                        -0.00054906001));

N631_7 :=__common__( map(trim(C_SPAN_LANG) = ''      => 0.0013938425,
              ((real)c_span_lang < 143.5) => 0.014085265,
                                             0.0013938425));

N631_6 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.0034177354,
              ((real)r_c20_email_count_i < 2.5)   => N631_7,
                                                     -0.0034177354));

N631_5 :=__common__( if(((real)c_asian_lang < 131.5), -0.0022968429, N631_6));

N631_4 :=__common__( if(trim(C_ASIAN_LANG) != '', N631_5, 0.013348613));

N631_3 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL)  => N631_8,
              ((integer)f_curraddrcrimeindex_i < 140) => N631_4,
                                                         N631_8));

N631_2 :=__common__( if(((real)f_prevaddrageoldest_d < 28.5), N631_3, -0.0013947379));

N631_1 :=__common__( if(((real)f_prevaddrageoldest_d > NULL), N631_2, 2.0090115e-005));

N632_10 :=__common__( if(((real)f_historical_count_d < 4.5), 0.0020191415, 0.010794957));

N632_9 :=__common__( if(((real)f_historical_count_d > NULL), N632_10, 0.011399168));

N632_8 :=__common__( map(trim(C_RENTAL) = ''      => N632_9,
              ((real)c_rental < 130.5) => -0.00097082602,
                                          N632_9));

N632_7 :=__common__( if(((real)c_many_cars < 31.5), -0.0042103061, N632_8));

N632_6 :=__common__( if(trim(C_MANY_CARS) != '', N632_7, 0.00063098286));

N632_5 :=__common__( if(((real)f_rel_educationover8_count_d < 15.5), -0.00067633748, -0.011845078));

N632_4 :=__common__( if(((real)f_rel_educationover8_count_d > NULL), N632_5, -0.0029592211));

N632_3 :=__common__( map(((real)f_addrchangevaluediff_d <= NULL)     => 0.00081372019,
              ((real)f_addrchangevaluediff_d < -113152.5) => -0.0057153448,
                                                             0.00081372019));

N632_2 :=__common__( map(trim(C_RENTAL) = ''      => N632_4,
              ((real)c_rental < 188.5) => N632_3,
                                          N632_4));

N632_1 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N632_2, N632_6));

N633_9 :=__common__( map(((real)f_inq_per_addr_i <= NULL) => -0.0019680954,
              ((real)f_inq_per_addr_i < 1.5)   => 0.0041140526,
                                                  -0.0019680954));

N633_8 :=__common__( if(((real)f_college_income_d < 3.5), -0.013206169, -0.0011762369));

N633_7 :=__common__( if(((real)f_college_income_d > NULL), N633_8, -0.0030443145));

N633_6 :=__common__( map(trim(C_HVAL_80K_P) = ''              => N633_9,
              ((real)c_hval_80k_p < 23.6500015259) => N633_7,
                                                      N633_9));

N633_5 :=__common__( if(((real)f_inq_highriskcredit_count24_i < 10.5), N633_6, 0.0057925953));

N633_4 :=__common__( if(((real)f_inq_highriskcredit_count24_i > NULL), N633_5, -0.0012866582));

N633_3 :=__common__( map(trim(C_LOW_ED) = ''              => 0.0073845986,
              ((real)c_low_ed < 77.4499969482) => 0.00053671011,
                                                  0.0073845986));

N633_2 :=__common__( if(((real)c_hval_80k_p < 7.94999980927), N633_3, N633_4));

N633_1 :=__common__( if(trim(C_HVAL_80K_P) != '', N633_2, 0.0010140088));

N634_9 :=__common__( if(((real)r_a50_pb_average_dollars_d < 31.5), -0.0059459343, 0.00019986217));

N634_8 :=__common__( if(((real)r_a50_pb_average_dollars_d > NULL), N634_9, -0.0019158359));

N634_7 :=__common__( if(((real)f_rel_ageover40_count_d < 2.5), 0.00099574364, -0.0083697504));

N634_6 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N634_7, 0.0024979081));

N634_5 :=__common__( map(((real)r_c13_curr_addr_lres_d <= NULL) => N634_6,
              ((real)r_c13_curr_addr_lres_d < 94.5)  => 0.0013677186,
                                                        N634_6));

N634_4 :=__common__( map(((real)f_addrchangeincomediff_d <= NULL)    => N634_5,
              ((real)f_addrchangeincomediff_d < -24068.5) => -0.0042625941,
                                                             N634_5));

N634_3 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)    => 0.00078256309,
              ((real)f_curraddrmedianvalue_d < 105224.5) => 0.011967607,
                                                            0.00078256309));

N634_2 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => N634_4,
              ((real)f_corrssnaddrcount_d < 0.5)   => N634_3,
                                                      N634_4));

N634_1 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N634_2, N634_8));

N635_9 :=__common__( map(trim(C_ROBBERY) = ''     => 0.0019449521,
              ((real)c_robbery < 71.5) => -0.0097954741,
                                          0.0019449521));

N635_8 :=__common__( if(((real)c_inc_150k_p < 0.649999976158), -0.010148538, N635_9));

N635_7 :=__common__( if(trim(C_INC_150K_P) != '', N635_8, -0.0065002371));

N635_6 :=__common__( map(((real)r_d32_mos_since_fel_ls_d <= NULL) => 0.00066824721,
              ((real)r_d32_mos_since_fel_ls_d < 240.5) => N635_7,
                                                          0.00066824721));

N635_5 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => -0.0034694444,
              ((real)r_c13_max_lres_d < 76.5)  => -0.014969106,
                                                  -0.0034694444));

N635_4 :=__common__( if(((real)c_high_hval < 1.15000009537), N635_5, 0.0026031158));

N635_3 :=__common__( if(trim(C_HIGH_HVAL) != '', N635_4, 0.0073220573));

N635_2 :=__common__( map(((real)r_i60_inq_retail_recency_d <= NULL) => N635_6,
              ((real)r_i60_inq_retail_recency_d < 61.5)  => N635_3,
                                                            N635_6));

N635_1 :=__common__( if(((real)f_inq_retail_count24_i > NULL), N635_2, 0.003720979));

N636_9 :=__common__( map(trim(C_INC_35K_P) = ''     => 0.0050970272,
              ((real)c_inc_35k_p < 6.25) => -0.0036370213,
                                            0.0050970272));

N636_8 :=__common__( if(((real)c_inc_150k_p < 5.94999980927), -0.0038684037, N636_9));

N636_7 :=__common__( if(trim(C_INC_150K_P) != '', N636_8, 0.0010916793));

N636_6 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO'])            => -0.0078386713,
              (segment in ['KMART', 'SEARS FLS', 'SEARS SHO']) => 0.00081660312,
                                                                  0.00081660312));

N636_5 :=__common__( map(trim(C_ASIAN_LANG) = ''      => -0.0081836477,
              ((real)c_asian_lang < 182.5) => N636_6,
                                              -0.0081836477));

N636_4 :=__common__( if(((real)c_high_hval < 8.64999961853), N636_5, 0.0062121166));

N636_3 :=__common__( if(trim(C_HIGH_HVAL) != '', N636_4, -0.0050978666));

N636_2 :=__common__( if(((real)f_rel_incomeover50_count_d < 5.5), N636_3, N636_7));

N636_1 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N636_2, -0.0014529987));

N637_9 :=__common__( if(((real)f_prevaddrstatus_i > NULL), 0.0040563433, 0.022286378));

N637_8 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.0182294845581), 0.0035052612, -0.002365706));

N637_7 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N637_8, -0.0017045476));

N637_6 :=__common__( map(trim(C_LOW_ED) = ''              => 0.0053278004,
              ((real)c_low_ed < 75.0500030518) => 9.7777456e-005,
                                                  0.0053278004));

N637_5 :=__common__( map(((real)f_srchphonesrchcount_i <= NULL) => N637_7,
              ((real)f_srchphonesrchcount_i < 0.5)   => N637_6,
                                                        N637_7));

N637_4 :=__common__( if(trim(C_POP_18_24_P) != '', N637_5, 0.0017334666));

N637_3 :=__common__( map(((real)r_i61_inq_collection_count12_i <= NULL) => 0.0080615624,
              ((real)r_i61_inq_collection_count12_i < 2.5)   => N637_4,
                                                                0.0080615624));

N637_2 :=__common__( if(((real)r_c14_addrs_5yr_i < 9.5), N637_3, N637_9));

N637_1 :=__common__( if(((real)r_c14_addrs_5yr_i > NULL), N637_2, -0.0053145127));

N638_8 :=__common__( if(((real)c_sfdu_p < 72.8000030518), 0.0089120636, -0.0018435979));

N638_7 :=__common__( if(trim(C_SFDU_P) != '', N638_8, 0.0028755623));

N638_6 :=__common__( map(((real)c_unique_addr_count_i <= NULL) => -0.0040315394,
              ((real)c_unique_addr_count_i < 7.5)   => 0.0050806056,
                                                       -0.0040315394));

N638_5 :=__common__( map(((real)f_assoccredbureaucount_i <= NULL) => 0.0022890951,
              ((real)f_assoccredbureaucount_i < 1.5)   => -0.00087794187,
                                                          0.0022890951));

N638_4 :=__common__( map(((real)f_rel_criminal_count_i <= NULL) => N638_6,
              ((real)f_rel_criminal_count_i < 9.5)   => N638_5,
                                                        N638_6));

N638_3 :=__common__( if(trim(C_MANY_CARS) != '', N638_4, -0.003671963));

N638_2 :=__common__( if(((real)f_rel_criminal_count_i > NULL), N638_3, 0.007635727));

N638_1 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => N638_7,
              ((real)f_inq_adls_per_phone_i < 1.5)   => N638_2,
                                                        N638_7));

N639_7 :=__common__( map(trim(C_RETAIL) = ''     => -0.0010798381,
              ((real)c_retail < 3.75) => 0.0031950488,
                                         -0.0010798381));

N639_6 :=__common__( map(trim(C_HH00) = ''      => 0.010282667,
              ((real)c_hh00 < 368.5) => -0.00096274644,
                                        0.010282667));

N639_5 :=__common__( map(trim(C_FEMDIV_P) = ''              => N639_7,
              ((real)c_femdiv_p < 2.54999995232) => N639_6,
                                                    N639_7));

N639_4 :=__common__( map(((real)f_addrchangeincomediff_d <= NULL)     => N639_5,
              ((integer)f_addrchangeincomediff_d < -34442) => 0.0086255651,
                                                              N639_5));

N639_3 :=__common__( map(trim(C_UNATTACH) = ''     => N639_4,
              ((real)c_unattach < 80.5) => -0.0038758771,
                                           N639_4));

N639_2 :=__common__( map(trim(C_RNT1000_P) = ''              => -0.0023982403,
              ((real)c_rnt1000_p < 21.6500015259) => N639_3,
                                                     -0.0023982403));

N639_1 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N639_2, -0.00067306786));

N640_9 :=__common__( map(((real)r_c13_curr_addr_lres_d <= NULL) => 0.000729712,
              ((real)r_c13_curr_addr_lres_d < 14.5)  => -0.0052423627,
                                                        0.000729712));

N640_8 :=__common__( map(((real)c_dist_input_to_prev_addr_i <= NULL) => 0.00096006335,
              ((real)c_dist_input_to_prev_addr_i < 1.5)   => N640_9,
                                                             0.00096006335));

N640_7 :=__common__( map(((real)f_crim_rel_under500miles_cnt_i <= NULL) => 0.0027532947,
              ((real)f_crim_rel_under500miles_cnt_i < 4.5)   => -0.005970495,
                                                                0.0027532947));

N640_6 :=__common__( map(trim(C_HH7P_P) = ''              => -0.011433468,
              ((real)c_hh7p_p < 1.54999995232) => N640_7,
                                                  -0.011433468));

N640_5 :=__common__( map(trim(C_PRESCHL) = ''     => N640_6,
              ((real)c_preschl < 64.5) => 0.0042407929,
                                          N640_6));

N640_4 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N640_5, -0.0253705));

N640_3 :=__common__( if(trim(C_PRESCHL) != '', N640_4, 0.0033394852));

N640_2 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 37.5), N640_3, N640_8));

N640_1 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N640_2, -0.0046344204));

N641_8 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => -0.0061727382,
              ((real)f_inq_per_ssn_i < 1.5)   => 0.0056984294,
                                                 -0.0061727382));

N641_7 :=__common__( map(trim(C_INC_75K_P) = ''              => 0.0089465702,
              ((real)c_inc_75k_p < 19.9500007629) => -0.0028588343,
                                                     0.0089465702));

N641_6 :=__common__( map(trim(C_RNT500_P) = ''              => 0.015103902,
              ((real)c_rnt500_p < 4.94999980927) => N641_7,
                                                    0.015103902));

N641_5 :=__common__( if(((real)f_curraddrmurderindex_i < 96.5), N641_6, N641_8));

N641_4 :=__common__( if(((real)f_curraddrmurderindex_i > NULL), N641_5, 0.018346613));

N641_3 :=__common__( map(trim(C_CIV_EMP) = ''              => -0.0006088279,
              ((real)c_civ_emp < 36.1500015259) => 0.0048291051,
                                                   -0.0006088279));

N641_2 :=__common__( if(((real)c_rnt1500_p < 6.44999980927), N641_3, N641_4));

N641_1 :=__common__( if(trim(C_RNT1500_P) != '', N641_2, 0.00036337942));

N642_9 :=__common__( if(((real)c_retail < 13.6499996185), -0.0016037962, -0.010425979));

N642_8 :=__common__( if(trim(C_RETAIL) != '', N642_9, -0.0050605246));

N642_7 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N642_8,
              ((real)c_hist_addr_match_i < 20.5)  => -0.00034948671,
                                                     N642_8));

N642_6 :=__common__( if(((real)c_serv_empl < 192.5), 0.0006543467, 0.0089825131));

N642_5 :=__common__( if(trim(C_SERV_EMPL) != '', N642_6, 0.0015446642));

N642_4 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => 0.0079014952,
              ((real)r_c14_addrs_15yr_i < 18.5)  => N642_5,
                                                    0.0079014952));

N642_3 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL) => N642_7,
              ((real)f_fp_prevaddrburglaryindex_i < 134.5) => N642_4,
                                                              N642_7));

N642_2 :=__common__( if(((real)r_i60_inq_banking_recency_d < 4.5), -0.0063818444, N642_3));

N642_1 :=__common__( if(((real)r_i60_inq_banking_recency_d > NULL), N642_2, -0.0030682582));

N643_9 :=__common__( if(((real)c_manufacturing < 14.1499996185), -0.0010265677, -0.008925099));

N643_8 :=__common__( if(trim(C_MANUFACTURING) != '', N643_9, -0.0041782226));

N643_7 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => 0.012435345,
              ((real)r_c10_m_hdr_fs_d < 135.5) => 0.00056507824,
                                                  0.012435345));

N643_6 :=__common__( if(((real)c_old_homes < 140.5), 0.0013483142, -0.0022029109));

N643_5 :=__common__( if(trim(C_OLD_HOMES) != '', N643_6, -0.00059105254));

N643_4 :=__common__( map(((real)r_c14_addrs_per_adl_c6_i <= NULL) => N643_7,
              ((real)r_c14_addrs_per_adl_c6_i < 1.5)   => N643_5,
                                                          N643_7));

N643_3 :=__common__( map(((real)f_rel_bankrupt_count_i <= NULL) => N643_8,
              ((real)f_rel_bankrupt_count_i < 2.5)   => N643_4,
                                                        N643_8));

N643_2 :=__common__( if(((real)f_mos_liens_unrel_ft_lseen_d < 142.5), 0.010600484, N643_3));

N643_1 :=__common__( if(((real)f_mos_liens_unrel_ft_lseen_d > NULL), N643_2, -0.0011379292));

N644_10 :=__common__( map(trim(C_RETIRED2) = ''     => 0.00048541119,
               ((real)c_retired2 < 24.5) => -0.0070569052,
                                            0.00048541119));

N644_9 :=__common__( if(((real)c_relig_indx < 169.5), N644_10, 0.0044728789));

N644_8 :=__common__( if(trim(C_RELIG_INDX) != '', N644_9, 0.0037961424));

N644_7 :=__common__( map(trim(C_POPOVER18) = ''      => -0.004044433,
              ((real)c_popover18 < 862.5) => 0.00077510234,
                                             -0.004044433));

N644_6 :=__common__( if(((real)c_pop_25_34_p < 6.85000038147), 0.004693417, N644_7));

N644_5 :=__common__( if(trim(C_POP_25_34_P) != '', N644_6, -0.0070781879));

N644_4 :=__common__( map((fp_segment in ['2 NAS 479', '3 New DID', '7 Other'])                           => N644_5,
              (fp_segment in ['1 SSN Prob', '4 Bureau Only', '5 Derog', '6 Recent Activity']) => N644_8,
                                                                                                 N644_8));

N644_3 :=__common__( if(((real)f_rel_ageover50_count_d > NULL), N644_4, 0.00050607378));

N644_2 :=__common__( if(((real)f_srchaddrsrchcountwk_i < 0.5), N644_3, -0.0056270702));

N644_1 :=__common__( if(((real)f_srchaddrsrchcountwk_i > NULL), N644_2, -0.0058764199));

N645_8 :=__common__( map(trim(C_CARTHEFT) = ''      => 0.0080882313,
              ((real)c_cartheft < 191.5) => 0.0024314044,
                                            0.0080882313));

N645_7 :=__common__( map(trim(C_POP_35_44_P) = ''     => N645_8,
              ((real)c_pop_35_44_p < 5.25) => -0.0054110892,
                                              N645_8));

N645_6 :=__common__( map(trim(C_NO_LABFOR) = ''     => N645_7,
              ((real)c_no_labfor < 21.5) => -0.0064439564,
                                            N645_7));

N645_5 :=__common__( if(((real)r_c14_addrs_15yr_i < 5.5), -0.0012448627, N645_6));

N645_4 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N645_5, 0.00041729004));

N645_3 :=__common__( map(((real)f_adl_util_inf_n <= NULL) => -0.0026125048,
              ((real)f_adl_util_inf_n < 0.5)   => N645_4,
                                                  -0.0026125048));

N645_2 :=__common__( if(((real)c_rnt500_p < 60.75), N645_3, -0.0033912615));

N645_1 :=__common__( if(trim(C_RNT500_P) != '', N645_2, -0.007426359));

N646_9 :=__common__( map(((real)c_addr_lres_6mo_ct_i <= NULL) => -0.0059485931,
              ((real)c_addr_lres_6mo_ct_i < 0.5)   => 0.0018434683,
                                                      -0.0059485931));

N646_8 :=__common__( if(((real)f_rel_under100miles_cnt_d < 23.5), N646_9, 0.0045587408));

N646_7 :=__common__( if(((real)f_rel_under100miles_cnt_d > NULL), N646_8, 0.0053221842));

N646_6 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL)   => 0.0059917781,
              ((integer)f_liens_unrel_cj_total_amt_i < 5366) => N646_7,
                                                                0.0059917781));

N646_5 :=__common__( if(trim(C_FAMILIES) != '', N646_6, 0.002026843));

N646_4 :=__common__( if(((real)f_liens_unrel_cj_total_amt_i > NULL), N646_5, 0.025706965));

N646_3 :=__common__( if(((real)f_addrchangeecontrajindex_d < 3.5), 1.7475094e-005, 0.009251633));

N646_2 :=__common__( if(((real)f_addrchangeecontrajindex_d > NULL), N646_3, -0.00013286961));

N646_1 :=__common__( map(((real)r_phn_pcs_n <= NULL) => N646_4,
              ((real)r_phn_pcs_n < 0.5)   => N646_2,
                                             N646_4));

N647_10 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => 0.011029058,
               ((real)f_add_input_mobility_index_n < 0.345039725304) => 0.0011116923,
                                                                        0.011029058));

N647_9 :=__common__( map(trim(C_AB_AV_EDU) = ''     => -0.0007871299,
              ((real)c_ab_av_edu < 97.5) => N647_10,
                                            -0.0007871299));

N647_8 :=__common__( if(((real)c_hval_250k_p < 13.25), -0.00086629507, N647_9));

N647_7 :=__common__( if(trim(C_HVAL_250K_P) != '', N647_8, -0.0061670276));

N647_6 :=__common__( if(((real)c_addr_lres_2mo_ct_i < 0.5), 0.0036317455, -0.0013471544));

N647_5 :=__common__( if(((real)c_addr_lres_2mo_ct_i > NULL), N647_6, 0.0088847712));

N647_4 :=__common__( map(trim(C_MURDERS) = ''     => N647_5,
              ((real)c_murders < 24.5) => 0.009534114,
                                          N647_5));

N647_3 :=__common__( if(((real)c_span_lang < 163.5), N647_4, -0.0043968718));

N647_2 :=__common__( if(trim(C_SPAN_LANG) != '', N647_3, -0.013952262));

N647_1 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N647_2, N647_7));

N648_11 :=__common__( if(((real)f_crim_rel_under100miles_cnt_i < 8.5), -0.0010455734, 0.0073483425));

N648_10 :=__common__( if(((real)f_crim_rel_under100miles_cnt_i > NULL), N648_11, 0.0004983798));

N648_9 :=__common__( if(((real)c_inc_35k_p < 10.5500001907), -0.00057145684, 0.010173971));

N648_8 :=__common__( if(trim(C_INC_35K_P) != '', N648_9, 0.0099241929));

N648_7 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)    => N648_10,
              ((integer)f_curraddrmedianincome_d < 23889) => N648_8,
                                                             N648_10));

N648_6 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => N648_7,
              ((real)f_add_curr_nhood_sfd_pct_d < 0.126647382975) => 0.010807902,
                                                                     N648_7));

N648_5 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N648_6, 0.0012850138));

N648_4 :=__common__( if(((real)f_corrssnnamecount_d < 4.5), N648_5, -0.00094479702));

N648_3 :=__common__( if(((real)f_corrssnnamecount_d > NULL), N648_4, -0.0024430761));

N648_2 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => -0.0086954049,
              ((real)f_srchssnsrchcount_i < 23.5)  => 0.0008512236,
                                                      -0.0086954049));

N648_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N648_2, N648_3));

N649_8 :=__common__( map(trim(C_BLUE_EMPL) = ''     => 0.0099042705,
              ((real)c_blue_empl < 89.5) => -0.0041339293,
                                            0.0099042705));

N649_7 :=__common__( map(trim(C_SERV_EMPL) = ''      => N649_8,
              ((real)c_serv_empl < 138.5) => -0.0040336078,
                                             N649_8));

N649_6 :=__common__( map(trim(C_NO_LABFOR) = ''     => N649_7,
              ((real)c_no_labfor < 63.5) => -0.00829816,
                                            N649_7));

N649_5 :=__common__( map(trim(C_HVAL_400K_P) = ''              => 0.0064797485,
              ((real)c_hval_400k_p < 22.3499984741) => N649_6,
                                                       0.0064797485));

N649_4 :=__common__( if(((integer)c_robbery < 70), N649_5, 0.00044652942));

N649_3 :=__common__( if(trim(C_ROBBERY) != '', N649_4, 0.0012246167));

N649_2 :=__common__( if(((real)r_d34_unrel_lien60_count_i < 5.5), N649_3, -0.0073395613));

N649_1 :=__common__( if(((real)r_d34_unrel_lien60_count_i > NULL), N649_2, -0.0014759846));

N650_8 :=__common__( map(trim(C_FAMMAR18_P) = ''              => -0.0015044148,
              ((real)c_fammar18_p < 17.1500015259) => 0.0058695818,
                                                      -0.0015044148));

N650_7 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => N650_8,
              ((real)f_mos_liens_unrel_cj_fseen_d < 108.5) => -0.0048825974,
                                                              N650_8));

N650_6 :=__common__( map(trim(C_HIGH_ED) = ''              => 0.0028538533,
              ((real)c_high_ed < 6.35000038147) => 0.013232873,
                                                   0.0028538533));

N650_5 :=__common__( if(((real)f_curraddrmurderindex_i < 164.5), N650_6, N650_7));

N650_4 :=__common__( if(((real)f_curraddrmurderindex_i > NULL), N650_5, -0.0056724835));

N650_3 :=__common__( map(trim(C_TOTCRIME) = ''      => N650_4,
              ((real)c_totcrime < 178.5) => -0.00025863302,
                                            N650_4));

N650_2 :=__common__( if(((real)c_manufacturing < 40.8499984741), N650_3, -0.0073679535));

N650_1 :=__common__( if(trim(C_MANUFACTURING) != '', N650_2, 0.001805827));

N651_8 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), 0.0065473301, 0.057016595));

N651_7 :=__common__( map(trim(C_SERV_EMPL) = ''     => N651_8,
              ((real)c_serv_empl < 62.5) => -0.0022903995,
                                            N651_8));

N651_6 :=__common__( if(((real)f_componentcharrisktype_i < 4.5), -0.0006122425, N651_7));

N651_5 :=__common__( if(((real)f_componentcharrisktype_i > NULL), N651_6, -0.0022729117));

N651_4 :=__common__( map(trim(C_NEWHOUSE) = ''              => -0.0078782134,
              ((real)c_newhouse < 173.300003052) => N651_5,
                                                    -0.0078782134));

N651_3 :=__common__( map(trim(C_NEWHOUSE) = ''      => N651_4,
              ((real)c_newhouse < 32.25) => -0.00098810483,
                                            N651_4));

N651_2 :=__common__( if(((real)c_hval_60k_p < 47.0499992371), N651_3, 0.0080351744));

N651_1 :=__common__( if(trim(C_HVAL_60K_P) != '', N651_2, -0.0028583213));

N652_8 :=__common__( map(((real)f_fp_prevaddrcrimeindex_i <= NULL) => 1.5824994e-005,
              ((real)f_fp_prevaddrcrimeindex_i < 143.5) => 0.0099445862,
                                                           1.5824994e-005));

N652_7 :=__common__( map(((real)c_comb_age_d <= NULL) => 0.00085845252,
              ((real)c_comb_age_d < 29.5)  => N652_8,
                                              0.00085845252));

N652_6 :=__common__( map(trim(C_HVAL_200K_P) = ''              => 0.006656267,
              ((real)c_hval_200k_p < 16.1500015259) => -0.0025081465,
                                                       0.006656267));

N652_5 :=__common__( if(((real)c_inc_50k_p < 8.35000038147), 0.0049303345, N652_6));

N652_4 :=__common__( if(trim(C_INC_50K_P) != '', N652_5, -0.0025405639));

N652_3 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => N652_4,
              ((real)f_srchssnsrchcount_i < 0.5)   => -0.0079789583,
                                                      N652_4));

N652_2 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 129.5), N652_3, N652_7));

N652_1 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N652_2, 0.001626805));

N653_9 :=__common__( if(((real)c_inc_201k_p < 0.449999988079), 0.0039278463, -0.010070547));

N653_8 :=__common__( if(trim(C_INC_201K_P) != '', N653_9, -0.0080992185));

N653_7 :=__common__( if(((real)c_inc_25k_p < 15.3500003815), 0.01372079, 0.0016401918));

N653_6 :=__common__( if(trim(C_INC_25K_P) != '', N653_7, 0.014074209));

N653_5 :=__common__( if(((real)f_rel_under25miles_cnt_d < 5.5), 0.00051318749, N653_6));

N653_4 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N653_5, 0.0028984413));

N653_3 :=__common__( if(((real)r_c13_avg_lres_d < 73.5), N653_4, N653_8));

N653_2 :=__common__( if(((real)r_c13_avg_lres_d > NULL), N653_3, 0.039367063));

N653_1 :=__common__( if(((real)r_l70_inp_addr_dnd_i > NULL), -0.00052756428, N653_2));

N654_9 :=__common__( map(((real)f_srchfraudsrchcountyr_i <= NULL) => -0.0046317958,
              ((real)f_srchfraudsrchcountyr_i < 0.5)   => 0.003461461,
                                                          -0.0046317958));

N654_8 :=__common__( if(((real)c_asian_lang < 130.5), N654_9, -0.010382746));

N654_7 :=__common__( if(trim(C_ASIAN_LANG) != '', N654_8, -0.01842976));

N654_6 :=__common__( map(trim(C_BUSINESS) = ''     => 0.0083683699,
              ((real)c_business < 61.5) => 0.001188921,
                                           0.0083683699));

N654_5 :=__common__( map(trim(C_POP_12_17_P) = ''              => N654_6,
              ((real)c_pop_12_17_p < 9.94999980927) => -0.00046343996,
                                                       N654_6));

N654_4 :=__common__( if(((real)c_trailer_p < 45.9500007629), N654_5, -0.0065634915));

N654_3 :=__common__( if(trim(C_TRAILER_P) != '', N654_4, -0.00095680927));

N654_2 :=__common__( if(((real)f_prevaddrageoldest_d < 146.5), N654_3, N654_7));

N654_1 :=__common__( if(((real)f_prevaddrageoldest_d > NULL), N654_2, -0.0085010777));

N655_8 :=__common__( map(trim(C_BORN_USA) = ''      => -0.0030898787,
              ((real)c_born_usa < 176.5) => 0.0068092254,
                                            -0.0030898787));

N655_7 :=__common__( map(trim(C_BURGLARY) = ''       => -0.0073271519,
              ((integer)c_burglary < 129) => 0.0025691064,
                                             -0.0073271519));

N655_6 :=__common__( map(trim(C_RNT500_P) = ''              => N655_8,
              ((real)c_rnt500_p < 14.1499996185) => N655_7,
                                                    N655_8));

N655_5 :=__common__( if(((real)c_unemp < 6.05000019073), N655_6, -0.00078285448));

N655_4 :=__common__( if(trim(C_UNEMP) != '', N655_5, -0.001330678));

N655_3 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)    => 0.0012665895,
              ((real)f_prevaddrmedianvalue_d < 131434.5) => -0.0030786407,
                                                            0.0012665895));

N655_2 :=__common__( if(((real)f_rel_under25miles_cnt_d < 8.5), N655_3, N655_4));

N655_1 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N655_2, -0.0021276273));

N656_10 :=__common__( map(((real)f_srchphonesrchcount_i <= NULL) => 0.0096071749,
               ((real)f_srchphonesrchcount_i < 0.5)   => -0.0004594012,
                                                         0.0096071749));

N656_9 :=__common__( map(trim(C_HVAL_80K_P) = ''              => 0.0044280987,
              ((real)c_hval_80k_p < 11.9499998093) => -0.003476544,
                                                      0.0044280987));

N656_8 :=__common__( map(trim(C_RNT500_P) = ''              => N656_9,
              ((real)c_rnt500_p < 5.55000019073) => 0.0095595106,
                                                    N656_9));

N656_7 :=__common__( map(((real)c_unique_addr_count_i <= NULL) => -0.0013651891,
              ((real)c_unique_addr_count_i < 4.5)   => N656_8,
                                                       -0.0013651891));

N656_6 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N656_7, -0.0056066469));

N656_5 :=__common__( if(((real)f_rel_felony_count_i < 5.5), N656_6, N656_10));

N656_4 :=__common__( if(((real)f_rel_felony_count_i > NULL), N656_5, -0.0075506424));

N656_3 :=__common__( if(trim(C_RETAIL) != '', N656_4, 0.0067694518));

N656_2 :=__common__( map(((real)f_srchunvrfdaddrcount_i <= NULL) => 0.0054819481,
              ((real)f_srchunvrfdaddrcount_i < 0.5)   => -0.0011744593,
                                                         0.0054819481));

N656_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N656_2, N656_3));

N657_8 :=__common__( map(((real)f_inq_per_addr_i <= NULL) => -0.0050350522,
              ((real)f_inq_per_addr_i < 1.5)   => 0.0060472665,
                                                  -0.0050350522));

N657_7 :=__common__( map((fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '4 Bureau Only', '6 Recent Activity', '7 Other']) => 0.0082197997,
              (fp_segment in ['5 Derog'])                                                                               => 0.020039656,
                                                                                                                           0.0082197997));

N657_6 :=__common__( if(((real)r_c20_email_count_i < 2.5), N657_7, 0.0028416562));

N657_5 :=__common__( if(((real)r_c20_email_count_i > NULL), N657_6, 0.0073244187));

N657_4 :=__common__( map(trim(C_CHILD) = ''              => N657_8,
              ((real)c_child < 27.6500015259) => N657_5,
                                                 N657_8));

N657_3 :=__common__( map(trim(C_WHOLESALE) = ''               => -0.0035438249,
              ((real)c_wholesale < 0.449999988079) => N657_4,
                                                      -0.0035438249));

N657_2 :=__common__( if(((real)c_retail < 27.1500015259), -0.00025080668, N657_3));

N657_1 :=__common__( if(trim(C_RETAIL) != '', N657_2, -0.00014732532));

N658_9 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => -0.0031138168,
              ((real)f_add_curr_nhood_sfd_pct_d < 0.963121116161) => 0.0024151805,
                                                                     -0.0031138168));

N658_8 :=__common__( if(((real)f_rel_incomeover75_count_d < 0.5), 0.00092332683, -0.0058267548));

N658_7 :=__common__( if(((real)f_rel_incomeover75_count_d > NULL), N658_8, -0.005112243));

N658_6 :=__common__( map(trim(C_INC_50K_P) = ''              => N658_9,
              ((real)c_inc_50k_p < 10.6499996185) => N658_7,
                                                     N658_9));

N658_5 :=__common__( map(((real)c_mos_since_impulse_fs_d <= NULL) => N658_6,
              ((real)c_mos_since_impulse_fs_d < 34.5)  => 0.008634709,
                                                          N658_6));

N658_4 :=__common__( if(((real)c_hhsize < 2.49499988556), -0.0014886203, N658_5));

N658_3 :=__common__( if(trim(C_HHSIZE) != '', N658_4, -0.003535476));

N658_2 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d < 6.5), 0.0084901074, N658_3));

N658_1 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d > NULL), N658_2, 0.0089460702));

N659_10 :=__common__( if(((real)c_families < 241.5), 0.0037085258, 0.00012643218));

N659_9 :=__common__( if(trim(C_FAMILIES) != '', N659_10, 0.0065323648));

N659_8 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.3235232234), 0.00067813855, -0.012235301));

N659_7 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N659_8, 0.0039492268));

N659_6 :=__common__( map(trim(C_POP_65_74_P) = ''              => N659_7,
              ((real)c_pop_65_74_p < 7.94999980927) => 0.0011250131,
                                                       N659_7));

N659_5 :=__common__( if(((real)c_sfdu_p < 92.0500030518), N659_6, 0.0070315028));

N659_4 :=__common__( if(trim(C_SFDU_P) != '', N659_5, 0.00095924212));

N659_3 :=__common__( map(((real)f_inq_dobs_per_ssn_i <= NULL) => -0.0029996277,
              ((real)f_inq_dobs_per_ssn_i < 0.5)   => N659_4,
                                                      -0.0029996277));

N659_2 :=__common__( if(((integer)f_estimated_income_d < 30500), N659_3, N659_9));

N659_1 :=__common__( if(((real)f_estimated_income_d > NULL), N659_2, -0.0023132874));

N660_8 :=__common__( map(trim(C_TRAILER_P) = ''               => -0.0011433255,
              ((real)c_trailer_p < 0.550000011921) => -0.010643142,
                                                      -0.0011433255));

N660_7 :=__common__( map(((real)r_i60_inq_count12_i <= NULL) => 0.00024893907,
              ((real)r_i60_inq_count12_i < 1.5)   => 0.012205397,
                                                     0.00024893907));

N660_6 :=__common__( map(trim(C_POP00) = ''      => 0.00078002265,
              ((real)c_pop00 < 855.5) => -0.0030302331,
                                         0.00078002265));

N660_5 :=__common__( if(((real)f_rel_homeover200_count_d > NULL), N660_6, -0.0038000287));

N660_4 :=__common__( map(trim(C_BLUE_COL) = ''              => N660_5,
              ((real)c_blue_col < 6.05000019073) => -0.0063788104,
                                                    N660_5));

N660_3 :=__common__( map(trim(C_NO_MOVE) = ''      => N660_7,
              ((real)c_no_move < 187.5) => N660_4,
                                           N660_7));

N660_2 :=__common__( if(((real)c_rnt250_p < 46.8499984741), N660_3, N660_8));

N660_1 :=__common__( if(trim(C_RNT250_P) != '', N660_2, 7.6543615e-005));

N661_8 :=__common__( map(((real)r_d32_mos_since_fel_ls_d <= NULL) => -4.7447812e-005,
              ((real)r_d32_mos_since_fel_ls_d < 106.5) => -0.0056090802,
                                                          -4.7447812e-005));

N661_7 :=__common__( map(trim(C_HH3_P) = ''              => -0.011276418,
              ((real)c_hh3_p < 22.9500007629) => -0.0021316004,
                                                 -0.011276418));

N661_6 :=__common__( map(trim(C_OWNOCC_P) = ''      => N661_8,
              ((real)c_ownocc_p < 20.25) => N661_7,
                                            N661_8));

N661_5 :=__common__( map(trim(C_SERV_EMPL) = ''      => -0.0017673031,
              ((real)c_serv_empl < 123.5) => 0.0085194269,
                                             -0.0017673031));

N661_4 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => N661_6,
              ((real)r_d32_mos_since_crim_ls_d < 8.5)   => N661_5,
                                                           N661_6));

N661_3 :=__common__( if(trim(C_OWNOCC_P) != '', N661_4, -0.0016206236));

N661_2 :=__common__( if(((real)r_f00_input_dob_match_level_d < 3.5), 0.0067618297, N661_3));

N661_1 :=__common__( if(((real)r_f00_input_dob_match_level_d > NULL), N661_2, 0.0014398714));

N662_8 :=__common__( map(trim(C_PRESCHL) = ''      => 0.012178465,
              ((real)c_preschl < 162.5) => 0.0037440563,
                                           0.012178465));

N662_7 :=__common__( if(((real)f_prevaddrmedianvalue_d < 70439.5), -0.002561502, N662_8));

N662_6 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N662_7, -0.032209814));

N662_5 :=__common__( map(trim(C_EASIQLIFE) = ''     => N662_6,
              ((real)c_easiqlife < 62.5) => -0.0063924112,
                                            N662_6));

N662_4 :=__common__( map(trim(C_INC_150K_P) = ''              => -0.0077653518,
              ((real)c_inc_150k_p < 9.44999980927) => -1.6181971e-005,
                                                      -0.0077653518));

N662_3 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => N662_5,
              ((real)f_inq_per_ssn_i < 6.5)   => N662_4,
                                                 N662_5));

N662_2 :=__common__( if(((real)c_hh7p_p < 13.1499996185), N662_3, -0.0082528441));

N662_1 :=__common__( if(trim(C_HH7P_P) != '', N662_2, 0.0023099265));

N663_9 :=__common__( if(((real)c_hist_addr_match_i < 2.5), 0.0033586661, 0.016671115));

N663_8 :=__common__( if(((real)c_hist_addr_match_i > NULL), N663_9, 0.016477942));

N663_7 :=__common__( map(trim(C_FINANCE) = ''              => -0.0012660402,
              ((real)c_finance < 3.15000009537) => N663_8,
                                                   -0.0012660402));

N663_6 :=__common__( map(trim(C_VERY_RICH) = ''      => 0.0087847988,
              ((real)c_very_rich < 123.5) => -0.0011461319,
                                             0.0087847988));

N663_5 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N663_6,
              ((real)c_hist_addr_match_i < 2.5)   => -0.0045722448,
                                                     N663_6));

N663_4 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N663_5, -0.0018819864));

N663_3 :=__common__( map(trim(C_BORN_USA) = ''     => 0.00078267742,
              ((real)c_born_usa < 94.5) => N663_4,
                                           0.00078267742));

N663_2 :=__common__( if(((real)c_inc_201k_p < 6.14999961853), N663_3, N663_7));

N663_1 :=__common__( if(trim(C_INC_201K_P) != '', N663_2, -8.0166416e-005));

N664_7 :=__common__( map(trim(C_CONSTRUCTION) = ''              => -0.012284579,
              ((real)c_construction < 6.64999961853) => 0.00012023863,
                                                        -0.012284579));

N664_6 :=__common__( map(trim(C_LOWINC) = ''              => 0.0071914347,
              ((real)c_lowinc < 82.4499969482) => 8.178971e-005,
                                                  0.0071914347));

N664_5 :=__common__( map(trim(C_MIL_EMP) = ''              => 0.006037567,
              ((real)c_mil_emp < 3.15000009537) => N664_6,
                                                   0.006037567));

N664_4 :=__common__( map(trim(C_POP_75_84_P) = ''                => N664_5,
              ((real)c_pop_75_84_p < 0.0500000007451) => -0.0051921721,
                                                         N664_5));

N664_3 :=__common__( map(trim(C_EASIQLIFE) = ''      => N664_7,
              ((real)c_easiqlife < 153.5) => N664_4,
                                             N664_7));

N664_2 :=__common__( if(((real)c_bel_edu < 193.5), N664_3, -0.0060341776));

N664_1 :=__common__( if(trim(C_BEL_EDU) != '', N664_2, -0.00095365282));

N665_10 :=__common__( if(((real)f_rel_educationover8_count_d < 10.5), 0.0039810335, -0.0062093992));

N665_9 :=__common__( if(((real)f_rel_educationover8_count_d > NULL), N665_10, -0.0058058798));

N665_8 :=__common__( map(trim(C_SPAN_LANG) = ''      => 0.0052586189,
              ((real)c_span_lang < 135.5) => -0.0089993802,
                                             0.0052586189));

N665_7 :=__common__( map(trim(C_RAPE) = ''      => 0.0035286735,
              ((integer)c_rape < 48) => N665_8,
                                        0.0035286735));

N665_6 :=__common__( if(((real)c_unemp < 10.25), N665_7, N665_9));

N665_5 :=__common__( if(trim(C_UNEMP) != '', N665_6, 0.0056980984));

N665_4 :=__common__( if(((real)c_health < 53.5), -0.0013046431, 0.0072883578));

N665_3 :=__common__( if(trim(C_HEALTH) != '', N665_4, 0.0018573019));

N665_2 :=__common__( if(((real)f_prevaddrageoldest_d < 64.5), N665_3, N665_5));

N665_1 :=__common__( if(((real)f_prevaddrageoldest_d > NULL), N665_2, -0.0082591629));

N666_7 :=__common__( map(trim(C_POP_35_44_P) = ''     => -0.0062440181,
              ((real)c_pop_35_44_p < 8.25) => 0.0036087245,
                                              -0.0062440181));

N666_6 :=__common__( if(((real)c_manufacturing < 0.0500000007451), N666_7, 0.0047660167));

N666_5 :=__common__( if(trim(C_MANUFACTURING) != '', N666_6, -0.017568634));

N666_4 :=__common__( map(((real)f_srchunvrfdphonecount_i <= NULL) => -0.00069917905,
              ((real)f_srchunvrfdphonecount_i < 0.5)   => 0.0015929402,
                                                          -0.00069917905));

N666_3 :=__common__( if(((real)f_prevaddrageoldest_d < 140.5), N666_4, N666_5));

N666_2 :=__common__( if(((real)f_prevaddrageoldest_d > NULL), N666_3, 0.0097045657));

N666_1 :=__common__( map(((real)r_s65_ssn_problem_i <= NULL) => -0.0066810863,
              ((real)r_s65_ssn_problem_i < 0.5)   => N666_2,
                                                     -0.0066810863));

N667_10 :=__common__( if(((real)f_rel_under25miles_cnt_d < 9.5), -0.0030130929, 0.0076727134));

N667_9 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N667_10, 0.0065559551));

N667_8 :=__common__( if(((real)c_pop_18_24_p < 7.94999980927), N667_9, -0.005076986));

N667_7 :=__common__( if(trim(C_POP_18_24_P) != '', N667_8, -0.0055388851));

N667_6 :=__common__( map(trim(C_HH5_P) = ''              => -0.0051970138,
              ((real)c_hh5_p < 1.04999995232) => 0.0023038275,
                                                 -0.0051970138));

N667_5 :=__common__( if(((real)c_inc_35k_p < 11.0500001907), N667_6, 0.00018991489));

N667_4 :=__common__( if(trim(C_INC_35K_P) != '', N667_5, 0.0021477537));

N667_3 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => 0.0013780691,
              ((real)f_curraddrmedianincome_d < 39420.5) => N667_4,
                                                            0.0013780691));

N667_2 :=__common__( if(((real)f_idverrisktype_i < 3.5), N667_3, N667_7));

N667_1 :=__common__( if(((real)f_idverrisktype_i > NULL), N667_2, -0.00010216826));

N668_9 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.0096839608,
              ((real)c_sub_bus < 156.5) => 0.0007503912,
                                           0.0096839608));

N668_8 :=__common__( map(trim(C_HH4_P) = ''               => 0.00084790202,
              ((real)c_hh4_p < 0.949999988079) => -0.0064843389,
                                                  0.00084790202));

N668_7 :=__common__( map(trim(C_APT20) = ''      => N668_9,
              ((real)c_apt20 < 166.5) => N668_8,
                                         N668_9));

N668_6 :=__common__( if(((real)r_c20_email_domain_free_count_i < 5.5), N668_7, -0.0053987352));

N668_5 :=__common__( if(((real)r_c20_email_domain_free_count_i > NULL), N668_6, 0.0093882265));

N668_4 :=__common__( if(((real)c_incollege < 9.64999961853), N668_5, -0.0024552688));

N668_3 :=__common__( if(trim(C_INCOLLEGE) != '', N668_4, 0.0031417153));

N668_2 :=__common__( if(((real)f_bus_fname_verd_d < 0.5), N668_3, -0.011512926));

N668_1 :=__common__( if(((real)f_bus_fname_verd_d > NULL), N668_2, 0.0069308938));

N669_10 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.374190598726), -0.0015138839, 0.0039795552));

N669_9 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N669_10, 0.020146329));

N669_8 :=__common__( if(((real)f_add_input_mobility_index_n < 0.440678656101), N669_9, -0.0058163856));

N669_7 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N669_8, -0.029699028));

N669_6 :=__common__( map(trim(C_LOW_ED) = ''              => -0.0048386828,
              ((real)c_low_ed < 61.5499992371) => 0.00088258018,
                                                  -0.0048386828));

N669_5 :=__common__( map(trim(C_HHSIZE) = ''              => 0.0031093445,
              ((real)c_hhsize < 2.49499988556) => N669_6,
                                                  0.0031093445));

N669_4 :=__common__( if(((real)f_current_count_d < 1.5), N669_5, N669_7));

N669_3 :=__common__( if(((real)f_current_count_d > NULL), N669_4, -0.00023993172));

N669_2 :=__common__( if(((real)c_incollege < 11.75), N669_3, -0.003109828));

N669_1 :=__common__( if(trim(C_INCOLLEGE) != '', N669_2, -0.00069533105));

N670_7 :=__common__( if(((real)f_rel_under100miles_cnt_d < 13.5), -0.0030457888, 0.0050071013));

N670_6 :=__common__( if(((real)f_rel_under100miles_cnt_d > NULL), N670_7, 0.0030736682));

N670_5 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL) => -0.0097324841,
              ((real)f_curraddrcrimeindex_i < 160.5) => -0.0032132228,
                                                        -0.0097324841));

N670_4 :=__common__( if(((real)f_corrphonelastnamecount_d < 0.5), N670_5, N670_6));

N670_3 :=__common__( if(((real)f_corrphonelastnamecount_d > NULL), N670_4, -0.018187394));

N670_2 :=__common__( map(((real)f_inq_lnames_per_ssn_i <= NULL) => N670_3,
              ((real)f_inq_lnames_per_ssn_i < 0.5)   => 0.0048255255,
                                                        N670_3));

N670_1 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => N670_2,
              ((real)f_inq_adls_per_phone_i < 0.5)   => 0.0007598402,
                                                        N670_2));

N671_8 :=__common__( map(((real)c_addr_lres_6mo_ct_i <= NULL) => 0.010687526,
              ((real)c_addr_lres_6mo_ct_i < 3.5)   => 0.0011337372,
                                                      0.010687526));

N671_7 :=__common__( map(trim(C_FOR_SALE) = ''      => 0.0052392517,
              ((real)c_for_sale < 141.5) => -7.3627269e-005,
                                            0.0052392517));

N671_6 :=__common__( map(trim(C_NEWHOUSE) = ''              => N671_7,
              ((real)c_newhouse < 34.4500007629) => -0.00073747604,
                                                    N671_7));

N671_5 :=__common__( map(trim(C_HVAL_80K_P) = ''              => N671_8,
              ((real)c_hval_80k_p < 40.6500015259) => N671_6,
                                                      N671_8));

N671_4 :=__common__( if(((real)c_pop_45_54_p < 25.5499992371), N671_5, 0.0079581661));

N671_3 :=__common__( if(trim(C_POP_45_54_P) != '', N671_4, 0.0020364745));

N671_2 :=__common__( if(((real)f_prevaddrageoldest_d < 242.5), N671_3, -0.0089980045));

N671_1 :=__common__( if(((real)f_prevaddrageoldest_d > NULL), N671_2, -0.0015851555));

N672_8 :=__common__( map(((real)f_liens_unrel_sc_total_amt_i <= NULL)   => -0.0097884304,
              ((integer)f_liens_unrel_sc_total_amt_i < 2105) => -0.00045966375,
                                                                -0.0097884304));

N672_7 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), -0.00050288999, 0.010928159));

N672_6 :=__common__( map(((real)f_add_curr_has_mfd_ct_i <= NULL) => N672_8,
              ((real)f_add_curr_has_mfd_ct_i < 0.5)   => N672_7,
                                                         N672_8));

N672_5 :=__common__( if(((real)c_hval_40k_p < 8.25), N672_6, -0.0051138493));

N672_4 :=__common__( if(trim(C_HVAL_40K_P) != '', N672_5, -0.00057163913));

N672_3 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => N672_4,
              ((real)f_mos_inq_banko_cm_fseen_d < 70.5)  => 0.0008863163,
                                                            N672_4));

N672_2 :=__common__( if(((real)f_rel_bankrupt_count_i < 8.5), N672_3, 0.0059785433));

N672_1 :=__common__( if(((real)f_rel_bankrupt_count_i > NULL), N672_2, -0.0055331104));

N673_8 :=__common__( map(trim(C_LAR_FAM) = ''      => -0.0082201731,
              ((real)c_lar_fam < 112.5) => 0.0018339604,
                                           -0.0082201731));

N673_7 :=__common__( map(((real)f_rel_bankrupt_count_i <= NULL) => 0.004015625,
              ((real)f_rel_bankrupt_count_i < 0.5)   => N673_8,
                                                        0.004015625));

N673_6 :=__common__( map(trim(C_POP_55_64_P) = ''              => N673_7,
              ((real)c_pop_55_64_p < 4.55000019073) => 0.01054798,
                                                       N673_7));

N673_5 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0307039227337), -0.0010310005, N673_6));

N673_4 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N673_5, 0.0020896822));

N673_3 :=__common__( map(trim(C_BLUE_EMPL) = ''      => -0.0057793926,
              ((real)c_blue_empl < 183.5) => N673_4,
                                             -0.0057793926));

N673_2 :=__common__( if(((real)c_pop_45_54_p < 13.3500003815), -0.0010269915, N673_3));

N673_1 :=__common__( if(trim(C_POP_45_54_P) != '', N673_2, 0.003722421));

N674_7 :=__common__( map(trim(C_YOUNG) = ''              => -0.0094017823,
              ((real)c_young < 21.1500015259) => 0.00064906108,
                                                 -0.0094017823));

N674_6 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL) => N674_7,
              ((real)f_prevaddrcartheftindex_i < 140.5) => 0.0066611152,
                                                           N674_7));

N674_5 :=__common__( map(trim(C_HVAL_40K_P) = ''              => N674_6,
              ((real)c_hval_40k_p < 2.95000004768) => -0.007156957,
                                                      N674_6));

N674_4 :=__common__( map(trim(C_MED_AGE) = ''      => N674_5,
              ((real)c_med_age < 31.25) => 0.00015610044,
                                           N674_5));

N674_3 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => 0.0071872582,
              ((real)f_add_curr_nhood_vac_pct_i < 0.357802093029) => N674_4,
                                                                     0.0071872582));

N674_2 :=__common__( if(((real)c_famotf18_p < 27.6500015259), 0.0011724296, N674_3));

N674_1 :=__common__( if(trim(C_FAMOTF18_P) != '', N674_2, 0.00083328448));

N675_8 :=__common__( map(trim(C_HH3_P) = ''      => -0.0037235703,
              ((real)c_hh3_p < 23.75) => -0.00017794566,
                                         -0.0037235703));

N675_7 :=__common__( map(trim(C_UNATTACH) = ''      => 0.0090671333,
              ((real)c_unattach < 113.5) => -0.00041446102,
                                            0.0090671333));

N675_6 :=__common__( map(trim(C_BEL_EDU) = ''      => -0.0081132177,
              ((real)c_bel_edu < 171.5) => 0.0020528003,
                                           -0.0081132177));

N675_5 :=__common__( map(((real)f_rel_count_i <= NULL) => N675_7,
              ((real)f_rel_count_i < 16.5)  => N675_6,
                                               N675_7));

N675_4 :=__common__( if(((real)c_hh5_p < 0.15000000596), N675_5, N675_8));

N675_3 :=__common__( if(trim(C_HH5_P) != '', N675_4, -0.00095859786));

N675_2 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 63.5), 0.0073025816, N675_3));

N675_1 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N675_2, 0.0059034894));

N676_8 :=__common__( map(trim(C_HEALTH) = ''              => 0.0041786884,
              ((real)c_health < 24.1500015259) => -0.0038714587,
                                                  0.0041786884));

N676_7 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => 0.0013790548,
              ((real)f_srchssnsrchcount_i < 4.5)   => N676_8,
                                                      0.0013790548));

N676_6 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => N676_7,
              ((real)f_mos_inq_banko_cm_fseen_d < 27.5)  => -0.0078372815,
                                                            N676_7));

N676_5 :=__common__( if(((real)c_hval_200k_p < 21.5499992371), N676_6, 0.0084966827));

N676_4 :=__common__( if(trim(C_HVAL_200K_P) != '', N676_5, 0.0026030918));

N676_3 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => 0.0014781148,
              ((real)f_m_bureau_adl_fs_all_d < 180.5) => N676_4,
                                                         0.0014781148));

N676_2 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 19.5), N676_3, -0.0074944132));

N676_1 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N676_2, -0.0022548538));

N677_8 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.0017627187,
              ((real)c_sub_bus < 117.5) => 0.015079269,
                                           0.0017627187));

N677_7 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL)  => N677_8,
              ((integer)f_prevaddrmurderindex_i < 111) => -0.0040488982,
                                                          N677_8));

N677_6 :=__common__( map(trim(C_HEALTH) = ''              => -0.0040289216,
              ((real)c_health < 10.5500001907) => N677_7,
                                                  -0.0040289216));

N677_5 :=__common__( map(trim(C_INC_200K_P) = ''              => 0.0095216851,
              ((real)c_inc_200k_p < 2.65000009537) => N677_6,
                                                      0.0095216851));

N677_4 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => N677_5,
              ((real)f_mos_liens_unrel_cj_fseen_d < 58.5)  => -0.007781717,
                                                              N677_5));

N677_3 :=__common__( if(((integer)c_assault < 99), -0.0038673434, N677_4));

N677_2 :=__common__( if(trim(C_ASSAULT) != '', N677_3, 0.020612635));

N677_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N677_2, 0.00070951125));

N678_7 :=__common__( map(trim(C_INCOLLEGE) = ''              => 0.00091969117,
              ((real)c_incollege < 1.34999990463) => 0.01054561,
                                                     0.00091969117));

N678_6 :=__common__( if(((real)c_serv_empl < 66.5), N678_7, -0.0013110868));

N678_5 :=__common__( if(trim(C_SERV_EMPL) != '', N678_6, 0.0036647165));

N678_4 :=__common__( map(((real)r_phn_pcs_n <= NULL) => -0.0053020637,
              ((real)r_phn_pcs_n < 0.5)   => 0.0036555341,
                                             -0.0053020637));

N678_3 :=__common__( if(((real)f_rel_felony_count_i < 1.5), N678_4, 0.010458702));

N678_2 :=__common__( if(((real)f_rel_felony_count_i > NULL), N678_3, -0.0091884207));

N678_1 :=__common__( map(((real)c_comb_age_d <= NULL) => N678_5,
              ((real)c_comb_age_d < 24.5)  => N678_2,
                                              N678_5));

N679_8 :=__common__( if(((real)f_rel_bankrupt_count_i < 1.5), -0.0056092892, 0.0041022414));

N679_7 :=__common__( if(((real)f_rel_bankrupt_count_i > NULL), N679_8, -0.031847499));

N679_6 :=__common__( map(trim(C_OLD_HOMES) = ''      => 0.013352434,
              ((real)c_old_homes < 136.5) => 0.0036122713,
                                             0.013352434));

N679_5 :=__common__( map(trim(C_SPAN_LANG) = ''     => N679_7,
              ((real)c_span_lang < 81.5) => N679_6,
                                            N679_7));

N679_4 :=__common__( map(trim(C_CONSTRUCTION) = ''              => 0.0049552422,
              ((real)c_construction < 38.5499992371) => -0.00038835016,
                                                        0.0049552422));

N679_3 :=__common__( map(trim(C_INC_25K_P) = ''              => N679_5,
              ((real)c_inc_25k_p < 22.8499984741) => N679_4,
                                                     N679_5));

N679_2 :=__common__( if(((real)c_edu_indx < 143.5), N679_3, 0.0088789797));

N679_1 :=__common__( if(trim(C_EDU_INDX) != '', N679_2, -0.0036845578));

N680_8 :=__common__( map(trim(C_RETAIL) = ''              => -2.7877623e-005,
              ((real)c_retail < 19.6500015259) => -0.0093083851,
                                                  -2.7877623e-005));

N680_7 :=__common__( map(trim(C_POP_35_44_P) = ''      => 0.010317441,
              ((real)c_pop_35_44_p < 19.25) => 0.00012841558,
                                               0.010317441));

N680_6 :=__common__( if(((real)f_rel_under25miles_cnt_d < 9.5), -0.0032681233, N680_7));

N680_5 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N680_6, -0.0036689803));

N680_4 :=__common__( map(trim(C_CHILD) = ''              => N680_5,
              ((real)c_child < 17.1500015259) => 0.0079557704,
                                                 N680_5));

N680_3 :=__common__( map(trim(C_AMUS_INDX) = ''      => N680_8,
              ((real)c_amus_indx < 115.5) => N680_4,
                                             N680_8));

N680_2 :=__common__( if(((real)c_work_home < 82.5), 0.0011055058, N680_3));

N680_1 :=__common__( if(trim(C_WORK_HOME) != '', N680_2, 0.0033190108));

N681_8 :=__common__( map(trim(C_EMPLOYEES) = ''     => -0.0062457965,
              ((real)c_employees < 22.5) => 0.0062916498,
                                            -0.0062457965));

N681_7 :=__common__( map(trim(C_POP_65_74_P) = ''              => N681_8,
              ((real)c_pop_65_74_p < 10.3500003815) => 0.0014266628,
                                                       N681_8));

N681_6 :=__common__( map(trim(C_HOUSINGCPI) = ''              => N681_7,
              ((real)c_housingcpi < 186.399993896) => -0.0077316834,
                                                      N681_7));

N681_5 :=__common__( map(((real)r_i60_inq_hiriskcred_count12_i <= NULL) => 0.0082987875,
              ((real)r_i60_inq_hiriskcred_count12_i < 7.5)   => N681_6,
                                                                0.0082987875));

N681_4 :=__common__( if(((real)c_rich_fam < 142.5), N681_5, -0.0018760748));

N681_3 :=__common__( if(trim(C_RICH_FAM) != '', N681_4, 0.00072536884));

N681_2 :=__common__( if(((real)f_mos_liens_unrel_lt_fseen_d < 35.5), -0.0052675258, N681_3));

N681_1 :=__common__( if(((real)f_mos_liens_unrel_lt_fseen_d > NULL), N681_2, 0.0014433895));

N682_9 :=__common__( if(((integer)f_addrchangevaluediff_d < 5489), -0.0067067964, 0.0015588813));

N682_8 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N682_9, -0.0024433273));

N682_7 :=__common__( map(((real)f_prevaddrageoldest_d <= NULL) => -0.010818334,
              ((real)f_prevaddrageoldest_d < 95.5)  => -0.00064207054,
                                                       -0.010818334));

N682_6 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)    => 0.00083659419,
              ((integer)f_curraddrmedianincome_d < 24594) => N682_7,
                                                             0.00083659419));

N682_5 :=__common__( map(trim(C_HVAL_100K_P) = ''     => 0.010354342,
              ((real)c_hval_100k_p < 5.75) => -0.0012168902,
                                              0.010354342));

N682_4 :=__common__( if(((real)c_unique_addr_count_i < 2.5), N682_5, N682_6));

N682_3 :=__common__( if(((real)c_unique_addr_count_i > NULL), N682_4, 0.0015167822));

N682_2 :=__common__( if(((real)c_bigapt_p < 9.64999961853), N682_3, N682_8));

N682_1 :=__common__( if(trim(C_BIGAPT_P) != '', N682_2, -0.0020270123));

N683_9 :=__common__( map((segment in ['KMART', 'RETAIL'])                      => 0.0034484209,
              (segment in ['SEARS AUTO', 'SEARS FLS', 'SEARS SHO']) => 0.015998891,
                                                                       0.015998891));

N683_8 :=__common__( map(((real)f_corrphonelastnamecount_d <= NULL) => -0.0056857388,
              ((real)f_corrphonelastnamecount_d < 0.5)   => 0.0029103107,
                                                            -0.0056857388));

N683_7 :=__common__( if(((real)c_lar_fam < 122.5), N683_8, N683_9));

N683_6 :=__common__( if(trim(C_LAR_FAM) != '', N683_7, 0.015523349));

N683_5 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.510045170784), -0.00070259953, N683_6));

N683_4 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N683_5, -0.00038935017));

N683_3 :=__common__( map(((real)f_recent_disconnects_i <= NULL) => 0.0052218362,
              ((real)f_recent_disconnects_i < 0.5)   => N683_4,
                                                        0.0052218362));

N683_2 :=__common__( if(((real)f_curraddrmedianvalue_d < 351456.5), N683_3, -0.0052990802));

N683_1 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N683_2, 0.0037907307));

N684_7 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => 0.0010897582,
              ((real)f_corrssnaddrcount_d < 2.5)   => 0.0096659834,
                                                      0.0010897582));

N684_6 :=__common__( map(trim(C_CHILD) = ''              => N684_7,
              ((real)c_child < 22.6500015259) => -0.0031343333,
                                                 N684_7));

N684_5 :=__common__( map(((real)f_addrchangeincomediff_d <= NULL)    => 0.009349878,
              ((integer)f_addrchangeincomediff_d < 12028) => N684_6,
                                                             0.009349878));

N684_4 :=__common__( map(trim(C_SERV_EMPL) = ''      => 0.010613444,
              ((real)c_serv_empl < 168.5) => 0.00079984348,
                                             0.010613444));

N684_3 :=__common__( map(((real)f_addrchangevaluediff_d <= NULL)    => -0.0019369891,
              ((real)f_addrchangevaluediff_d < -53191.5) => N684_4,
                                                            -0.0019369891));

N684_2 :=__common__( map(trim(C_HH1_P) = ''              => N684_5,
              ((real)c_hh1_p < 35.9500007629) => N684_3,
                                                 N684_5));

N684_1 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N684_2, -3.2768535e-007));

N685_8 :=__common__( map(trim(C_PRESCHL) = ''      => -0.0038971966,
              ((real)c_preschl < 113.5) => 0.0036895389,
                                           -0.0038971966));

N685_7 :=__common__( map(trim(C_RNT500_P) = ''              => N685_8,
              ((real)c_rnt500_p < 19.1500015259) => -0.0071007818,
                                                    N685_8));

N685_6 :=__common__( map(trim(C_HH00) = ''      => 0.00018680282,
              ((real)c_hh00 < 313.5) => N685_7,
                                        0.00018680282));

N685_5 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => 0.0050003712,
              ((real)f_add_curr_nhood_vac_pct_i < 0.052513550967) => -0.0063013638,
                                                                     0.0050003712));

N685_4 :=__common__( map((fp_segment in ['2 NAS 479', '3 New DID', '4 Bureau Only', '6 Recent Activity', '7 Other']) => N685_5,
              (fp_segment in ['1 SSN Prob', '5 Derog'])                                                   => 0.010139165,
                                                                                                             N685_5));

N685_3 :=__common__( if(((real)f_prevaddrmedianincome_d < 13206.5), N685_4, N685_6));

N685_2 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N685_3, -0.012570604));

N685_1 :=__common__( if(trim(C_AB_AV_EDU) != '', N685_2, -0.00084512878));

N686_8 :=__common__( map(((real)f_historical_count_d <= NULL) => 0.00081125594,
              ((real)f_historical_count_d < 0.5)   => -0.0027300681,
                                                      0.00081125594));

N686_7 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => -0.0043682835,
              ((real)c_dist_best_to_prev_addr_i < 287.5) => N686_8,
                                                            -0.0043682835));

N686_6 :=__common__( map(trim(C_BORN_USA) = ''     => 0.0048665209,
              ((real)c_born_usa < 64.5) => -0.0025290867,
                                           0.0048665209));

N686_5 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N686_6, -0.023527943));

N686_4 :=__common__( if(trim(C_BORN_USA) != '', N686_5, -0.0068289007));

N686_3 :=__common__( map(((real)r_i61_inq_collection_recency_d <= NULL) => N686_4,
              ((real)r_i61_inq_collection_recency_d < 61.5)  => 0.0087642586,
                                                                N686_4));

N686_2 :=__common__( if(((real)f_rel_ageover30_count_d < 3.5), N686_3, N686_7));

N686_1 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N686_2, 0.0013650374));

N687_9 :=__common__( map(trim(C_FAMILIES) = ''      => -0.0011325465,
              ((real)c_families < 138.5) => 0.0053922497,
                                            -0.0011325465));

N687_8 :=__common__( map(trim(C_OLDHOUSE) = ''              => -0.0073849197,
              ((real)c_oldhouse < 476.100006104) => N687_9,
                                                    -0.0073849197));

N687_7 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)     => 0.010499385,
              ((integer)f_prevaddrmedianvalue_d < 199870) => 0.0010918047,
                                                             0.010499385));

N687_6 :=__common__( if(((real)c_pop_55_64_p < 4.94999980927), N687_7, N687_8));

N687_5 :=__common__( if(trim(C_POP_55_64_P) != '', N687_6, 0.0035585076));

N687_4 :=__common__( if(((real)c_burglary < 177.5), 0.0012642651, 0.010871702));

N687_3 :=__common__( if(trim(C_BURGLARY) != '', N687_4, 0.008611656));

N687_2 :=__common__( if(((real)c_mos_since_impulse_fs_d < 57.5), N687_3, N687_5));

N687_1 :=__common__( if(((real)c_mos_since_impulse_fs_d > NULL), N687_2, 0.011019297));

N688_8 :=__common__( if(((real)f_assocrisktype_i < 6.5), 0.0037124334, 0.015585712));

N688_7 :=__common__( if(((real)f_assocrisktype_i > NULL), N688_8, -0.036748394));

N688_6 :=__common__( map(trim(C_AB_AV_EDU) = ''     => N688_7,
              ((real)c_ab_av_edu < 47.5) => -0.0017829685,
                                            N688_7));

N688_5 :=__common__( map(trim(C_POP_45_54_P) = ''              => -0.0016251909,
              ((real)c_pop_45_54_p < 13.8500003815) => 0.01106315,
                                                       -0.0016251909));

N688_4 :=__common__( map(trim(C_RICH_WHT) = ''      => N688_5,
              ((real)c_rich_wht < 172.5) => 0.00011048359,
                                            N688_5));

N688_3 :=__common__( map(trim(C_RNT250_P) = ''              => N688_6,
              ((real)c_rnt250_p < 40.3499984741) => N688_4,
                                                    N688_6));

N688_2 :=__common__( if(((real)c_fammar18_p < 50.9500007629), N688_3, -0.005081103));

N688_1 :=__common__( if(trim(C_FAMMAR18_P) != '', N688_2, -0.0010624689));

N689_9 :=__common__( map(trim(C_UNATTACH) = ''     => 9.0096427e-005,
              ((real)c_unattach < 81.5) => -0.005241379,
                                           9.0096427e-005));

N689_8 :=__common__( map(trim(C_OLDHOUSE) = ''              => 0.010407106,
              ((real)c_oldhouse < 168.899993896) => -0.00078117557,
                                                    0.010407106));

N689_7 :=__common__( map(trim(C_BARGAINS) = ''      => N689_8,
              ((real)c_bargains < 142.5) => -0.002877227,
                                            N689_8));

N689_6 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N689_7, -0.0054834847));

N689_5 :=__common__( map(trim(C_HH3_P) = ''              => 0.00751578,
              ((real)c_hh3_p < 25.1500015259) => N689_6,
                                                 0.00751578));

N689_4 :=__common__( if(((real)f_varmsrcssncount_i < 1.5), N689_5, 0.006437031));

N689_3 :=__common__( if(((real)f_varmsrcssncount_i > NULL), N689_4, -0.0045125236));

N689_2 :=__common__( if(((real)c_serv_empl < 69.5), N689_3, N689_9));

N689_1 :=__common__( if(trim(C_SERV_EMPL) != '', N689_2, -0.0030856092));

N690_9 :=__common__( if(((real)r_c13_max_lres_d < 51.5), -0.0079770611, -0.00048805686));

N690_8 :=__common__( if(((real)r_c13_max_lres_d > NULL), N690_9, 0.0082352776));

N690_7 :=__common__( map(((real)f_corrrisktype_i <= NULL) => -0.0083013593,
              ((real)f_corrrisktype_i < 4.5)   => 0.0039267607,
                                                  -0.0083013593));

N690_6 :=__common__( if(((real)r_i60_inq_banking_count12_i < 0.5), 0.0018112734, N690_7));

N690_5 :=__common__( if(((real)r_i60_inq_banking_count12_i > NULL), N690_6, -0.0077767105));

N690_4 :=__common__( map(trim(C_CHILD) = ''              => N690_5,
              ((real)c_child < 19.4500007629) => 0.0093182549,
                                                 N690_5));

N690_3 :=__common__( map(trim(C_BURGLARY) = ''      => N690_8,
              ((real)c_burglary < 163.5) => N690_4,
                                            N690_8));

N690_2 :=__common__( if(((real)c_blue_col < 13.3500003815), -0.001740899, N690_3));

N690_1 :=__common__( if(trim(C_BLUE_COL) != '', N690_2, 0.00097015957));

N691_8 :=__common__( map(trim(C_BLUE_EMPL) = ''     => -0.0039160252,
              ((real)c_blue_empl < 76.5) => 0.0076849778,
                                            -0.0039160252));

N691_7 :=__common__( map(trim(C_VERY_RICH) = ''      => -0.0089584716,
              ((real)c_very_rich < 110.5) => N691_8,
                                             -0.0089584716));

N691_6 :=__common__( map(trim(C_URBAN_P) = ''              => -0.0025572739,
              ((real)c_urban_p < 99.5500030518) => -0.012255766,
                                                   -0.0025572739));

N691_5 :=__common__( map(trim(C_MED_AGE) = ''      => 0.0029359554,
              ((real)c_med_age < 39.25) => N691_6,
                                           0.0029359554));

N691_4 :=__common__( if(((real)f_crim_rel_under100miles_cnt_i < 0.5), N691_5, 0.00086381863));

N691_3 :=__common__( if(((real)f_crim_rel_under100miles_cnt_i > NULL), N691_4, 0.00095944733));

N691_2 :=__common__( if(((real)c_hval_1001k_p < 0.850000023842), N691_3, N691_7));

N691_1 :=__common__( if(trim(C_HVAL_1001K_P) != '', N691_2, -0.0024347622));

N692_10 :=__common__( map(((real)f_mos_acc_lseen_d <= NULL) => 0.00039060998,
               ((real)f_mos_acc_lseen_d < 65.5)  => -0.010027282,
                                                    0.00039060998));

N692_9 :=__common__( map(((real)f_mos_acc_lseen_d <= NULL) => N692_10,
              ((real)f_mos_acc_lseen_d < 36.5)  => 0.005652898,
                                                   N692_10));

N692_8 :=__common__( if(((real)r_c13_curr_addr_lres_d < 112.5), N692_9, 0.0074899081));

N692_7 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N692_8, -0.032041416));

N692_6 :=__common__( if(((real)f_prevaddrageoldest_d < 94.5), N692_7, -0.0019298744));

N692_5 :=__common__( if(((real)f_prevaddrageoldest_d > NULL), N692_6, -0.00061421998));

N692_4 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)         => -0.0045583709,
              ((real)f_add_input_nhood_sfd_pct_d < 0.98238492012) => N692_5,
                                                                     -0.0045583709));

N692_3 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N692_4, 0.00066797925));

N692_2 :=__common__( if(((real)c_inc_100k_p < 23.0499992371), N692_3, 0.0085166209));

N692_1 :=__common__( if(trim(C_INC_100K_P) != '', N692_2, 0.0039065334));

N693_9 :=__common__( map(trim(C_HVAL_40K_P) = ''     => 0.0054391628,
              ((real)c_hval_40k_p < 1.75) => -0.00453378,
                                             0.0054391628));

N693_8 :=__common__( map(trim(C_INC_200K_P) = ''     => N693_9,
              ((real)c_inc_200k_p < 0.25) => -0.0089593207,
                                             N693_9));

N693_7 :=__common__( if(((real)f_curraddrcartheftindex_i < 190.5), 4.5472347e-005, N693_8));

N693_6 :=__common__( if(((real)f_curraddrcartheftindex_i > NULL), N693_7, -0.0039795165));

N693_5 :=__common__( if(((real)f_prevaddrageoldest_d < 19.5), 0.0079226502, -0.0027365978));

N693_4 :=__common__( if(((real)f_prevaddrageoldest_d > NULL), N693_5, 0.046197211));

N693_3 :=__common__( map(trim(C_POP_25_34_P) = ''              => 0.0084877537,
              ((real)c_pop_25_34_p < 15.8500003815) => N693_4,
                                                       0.0084877537));

N693_2 :=__common__( if(((real)c_employees < 11.5), N693_3, N693_6));

N693_1 :=__common__( if(trim(C_EMPLOYEES) != '', N693_2, -0.0031652111));

N694_9 :=__common__( if(((real)c_housingcpi < 241.75), 0.00016636938, 0.0085198876));

N694_8 :=__common__( if(trim(C_HOUSINGCPI) != '', N694_9, 0.0031083588));

N694_7 :=__common__( map(trim(C_UNEMPL) = ''      => -0.012291927,
              ((real)c_unempl < 132.5) => 3.1216297e-005,
                                          -0.012291927));

N694_6 :=__common__( map(trim(C_RETIRED2) = ''     => N694_7,
              ((real)c_retired2 < 85.5) => 0.0036856626,
                                           N694_7));

N694_5 :=__common__( map(trim(C_CARTHEFT) = ''      => 0.0092295612,
              ((real)c_cartheft < 154.5) => N694_6,
                                            0.0092295612));

N694_4 :=__common__( if(((real)c_rentocc_p < 30.6500015259), N694_5, -0.003948122));

N694_3 :=__common__( if(trim(C_RENTOCC_P) != '', N694_4, -0.0095256988));

N694_2 :=__common__( if(((real)r_c14_addrs_15yr_i < 5.5), N694_3, N694_8));

N694_1 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N694_2, -0.0027436415));

N695_9 :=__common__( if(((real)c_rnt750_p < 9.05000019073), 0.0023573008, -0.0058168203));

N695_8 :=__common__( if(trim(C_RNT750_P) != '', N695_9, 0.0169743));

N695_7 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)    => N695_8,
              ((real)f_curraddrmedianvalue_d < 222828.5) => 0.001065098,
                                                            N695_8));

N695_6 :=__common__( if(((real)f_rel_ageover30_count_d < 12.5), 0.0080174899, -0.0034168294));

N695_5 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N695_6, -0.020162507));

N695_4 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => N695_5,
              ((real)f_inq_other_count24_i < 0.5)   => -0.0044112817,
                                                       N695_5));

N695_3 :=__common__( map(((real)f_current_count_d <= NULL) => -0.0077508604,
              ((real)f_current_count_d < 2.5)   => N695_4,
                                                   -0.0077508604));

N695_2 :=__common__( if(((real)f_mos_acc_lseen_d < 128.5), N695_3, N695_7));

N695_1 :=__common__( if(((real)f_mos_acc_lseen_d > NULL), N695_2, 0.012241966));

N696_8 :=__common__( map(trim(C_WHITE_COL) = ''              => 0.0034441547,
              ((real)c_white_col < 33.0499992371) => -0.0057865769,
                                                     0.0034441547));

N696_7 :=__common__( map(trim(C_HH5_P) = ''              => N696_8,
              ((real)c_hh5_p < 9.05000019073) => 0.0008851679,
                                                 N696_8));

N696_6 :=__common__( map(trim(C_HH5_P) = ''     => 0.014488726,
              ((real)c_hh5_p < 7.75) => 0.0038810033,
                                        0.014488726));

N696_5 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => N696_6,
              ((real)r_c21_m_bureau_adl_fs_d < 159.5) => -0.00022012424,
                                                         N696_6));

N696_4 :=__common__( map(trim(C_HIGH_ED) = ''              => N696_7,
              ((real)c_high_ed < 3.95000004768) => N696_5,
                                                   N696_7));

N696_3 :=__common__( map(((real)c_addr_lres_2mo_ct_i <= NULL) => -0.0019170993,
              ((real)c_addr_lres_2mo_ct_i < 2.5)   => N696_4,
                                                      -0.0019170993));

N696_2 :=__common__( if(trim(C_HIGH_ED) != '', N696_3, -0.0020539343));

N696_1 :=__common__( if(((real)f_curraddractivephonelist_d > NULL), N696_2, 0.0014112882));

N697_10 :=__common__( if(((real)c_hh3_p < 18.6500015259), 0.0063678107, -0.0048304084));

N697_9 :=__common__( if(trim(C_HH3_P) != '', N697_10, 0.004207762));

N697_8 :=__common__( if(((real)f_rel_ageover30_count_d < 7.5), N697_9, -0.0041475848));

N697_7 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N697_8, -0.021593592));

N697_6 :=__common__( map(trim(C_MANY_CARS) = ''     => -0.00068370275,
              ((real)c_many_cars < 38.5) => 0.0024714972,
                                            -0.00068370275));

N697_5 :=__common__( if(((real)c_pop_65_74_p < 0.550000011921), 0.0081096957, N697_6));

N697_4 :=__common__( if(trim(C_POP_65_74_P) != '', N697_5, -0.0073471301));

N697_3 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL)  => N697_7,
              ((integer)f_liens_unrel_cj_total_amt_i < 773) => N697_4,
                                                               N697_7));

N697_2 :=__common__( if(((real)f_componentcharrisktype_i < 7.5), N697_3, 0.0057970372));

N697_1 :=__common__( if(((real)f_componentcharrisktype_i > NULL), N697_2, 0.005496282));

N698_8 :=__common__( map(trim(C_NEWHOUSE) = ''              => -0.007606091,
              ((real)c_newhouse < 4.14999961853) => 0.0029557193,
                                                    -0.007606091));

N698_7 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)    => 0.010276097,
              ((integer)f_curraddrmedianincome_d < 40936) => -0.0019617173,
                                                             0.010276097));

N698_6 :=__common__( map(trim(C_PROFESSIONAL) = ''               => -0.005530751,
              ((real)c_professional < 0.550000011921) => N698_7,
                                                         -0.005530751));

N698_5 :=__common__( map(trim(C_HH2_P) = ''              => -0.0095669093,
              ((real)c_hh2_p < 36.0499992371) => N698_6,
                                                 -0.0095669093));

N698_4 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N698_5, N698_8));

N698_3 :=__common__( map(trim(C_CPIALL) = ''      => -0.00064039431,
              ((real)c_cpiall < 208.5) => 0.0024068765,
                                          -0.00064039431));

N698_2 :=__common__( if(((real)c_rnt750_p < 55.8499984741), N698_3, N698_4));

N698_1 :=__common__( if(trim(C_RNT750_P) != '', N698_2, 0.0027701114));

N699_10 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.107818387449), 0.0018241831, 0.013853977));

N699_9 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N699_10, -0.0040299684));

N699_8 :=__common__( map(trim(C_HEALTH) = ''              => -0.00065207998,
              ((real)c_health < 10.5500001907) => 0.0020409694,
                                                  -0.00065207998));

N699_7 :=__common__( if(((real)f_rel_ageover30_count_d < 33.5), N699_8, -0.007761545));

N699_6 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N699_7, 0.0039208768));

N699_5 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => -0.0075291446,
              ((real)f_add_input_nhood_vac_pct_i < 0.455489575863) => N699_6,
                                                                      -0.0075291446));

N699_4 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.175685569644), N699_5, -0.0041244389));

N699_3 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N699_4, -0.0015622153));

N699_2 :=__common__( if(((real)f_add_input_mobility_index_n < 0.590294599533), N699_3, N699_9));

N699_1 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N699_2, 0.0010874696));

N700_9 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => 0.0035287353,
              ((real)f_srchaddrsrchcount_i < 4.5)   => -0.0042837845,
                                                       0.0035287353));

N700_8 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => 0.0063375494,
              ((real)f_curraddrcartheftindex_i < 80.5)  => -0.00074331988,
                                                           0.0063375494));

N700_7 :=__common__( map(((real)r_c18_invalid_addrs_per_adl_i <= NULL) => N700_9,
              ((real)r_c18_invalid_addrs_per_adl_i < 1.5)   => N700_8,
                                                               N700_9));

N700_6 :=__common__( if(((real)f_current_count_d < 0.5), N700_7, -0.00041676608));

N700_5 :=__common__( if(((real)f_current_count_d > NULL), N700_6, 0.01168426));

N700_4 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.122121334076), -0.00046189747, -0.0069922178));

N700_3 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N700_4, -0.0068523606));

N700_2 :=__common__( if(((real)c_exp_prod < 37.5), N700_3, N700_5));

N700_1 :=__common__( if(trim(C_EXP_PROD) != '', N700_2, 0.0037513159));

N701_8 :=__common__( map(trim(C_MURDERS) = ''      => 0.0016666732,
              ((real)c_murders < 185.5) => 0.01377376,
                                           0.0016666732));

N701_7 :=__common__( if(((real)c_rape < 186.5), 0.00029002351, N701_8));

N701_6 :=__common__( if(trim(C_RAPE) != '', N701_7, 0.0012460778));

N701_5 :=__common__( if(((real)f_rel_incomeover25_count_d < 7.5), 0.0062735775, -0.0028535195));

N701_4 :=__common__( if(((real)f_rel_incomeover25_count_d > NULL), N701_5, 0.0076388556));

N701_3 :=__common__( if(((real)c_serv_empl < 127.5), N701_4, -0.0044968598));

N701_2 :=__common__( if(trim(C_SERV_EMPL) != '', N701_3, -0.0059466604));

N701_1 :=__common__( map(((real)f_util_add_curr_misc_n <= NULL) => N701_6,
              ((real)f_util_add_curr_misc_n < 0.5)   => N701_2,
                                                        N701_6));

N702_9 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.260217964649), -0.0021256326, 0.0052055841));

N702_8 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N702_9, -0.0005115738));

N702_7 :=__common__( map(trim(C_INC_150K_P) = ''              => -0.0031116732,
              ((real)c_inc_150k_p < 2.95000004768) => -0.012802029,
                                                      -0.0031116732));

N702_6 :=__common__( map(trim(C_RETIRED2) = ''     => 0.00035243058,
              ((real)c_retired2 < 47.5) => -0.0071530716,
                                           0.00035243058));

N702_5 :=__common__( map(trim(C_HVAL_125K_P) = ''              => N702_7,
              ((real)c_hval_125k_p < 12.6499996185) => N702_6,
                                                       N702_7));

N702_4 :=__common__( if(((real)c_highinc < 5.64999961853), 4.4343606e-005, N702_5));

N702_3 :=__common__( if(trim(C_HIGHINC) != '', N702_4, 0.0052555101));

N702_2 :=__common__( if(((real)f_curraddrmedianincome_d < 59609.5), N702_3, N702_8));

N702_1 :=__common__( if(((real)f_curraddrmedianincome_d > NULL), N702_2, 0.0061027654));

N703_8 :=__common__( map(trim(C_RNT1500_P) = ''              => -0.002347536,
              ((real)c_rnt1500_p < 29.8499984741) => 0.009957384,
                                                     -0.002347536));

N703_7 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => -0.0030409455,
              ((real)f_curraddrmurderindex_i < 30.5)  => 0.0066126391,
                                                         -0.0030409455));

N703_6 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => -0.00019748831,
              ((real)f_mos_inq_banko_om_lseen_d < 9.5)   => -0.0063009824,
                                                            -0.00019748831));

N703_5 :=__common__( map(trim(C_EMPLOYEES) = ''      => 0.0021402807,
              ((real)c_employees < 164.5) => N703_6,
                                             0.0021402807));

N703_4 :=__common__( if(((real)f_inq_communications_count24_i < 1.5), N703_5, N703_7));

N703_3 :=__common__( if(((real)f_inq_communications_count24_i > NULL), N703_4, 0.004307705));

N703_2 :=__common__( if(((real)c_highrent < 26.8499984741), N703_3, N703_8));

N703_1 :=__common__( if(trim(C_HIGHRENT) != '', N703_2, 0.00073788245));

N704_9 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => 0.013224974,
              ((real)f_add_curr_nhood_sfd_pct_d < 0.374407440424) => -0.00026538567,
                                                                     0.013224974));

N704_8 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => 0.0028885521,
              ((real)f_add_input_nhood_vac_pct_i < 0.0925953015685) => -0.0069328936,
                                                                       0.0028885521));

N704_7 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.284260511398), N704_8, N704_9));

N704_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N704_7, 0.0044031589));

N704_5 :=__common__( map(trim(C_HVAL_100K_P) = ''              => 0.0044433268,
              ((real)c_hval_100k_p < 25.9500007629) => -0.0057432763,
                                                       0.0044433268));

N704_4 :=__common__( map(((real)r_s66_adlperssn_count_i <= NULL) => N704_6,
              ((real)r_s66_adlperssn_count_i < 1.5)   => N704_5,
                                                         N704_6));

N704_3 :=__common__( if(((real)f_assocrisktype_i < 2.5), N704_4, 0.00069128613));

N704_2 :=__common__( if(((real)f_assocrisktype_i > NULL), N704_3, 0.0028023583));

N704_1 :=__common__( if(trim(C_WORK_HOME) != '', N704_2, 0.00043363689));

N705_9 :=__common__( map(trim(C_HVAL_80K_P) = ''               => 0.0012344181,
              ((real)c_hval_80k_p < 0.949999988079) => 0.0064656849,
                                                       0.0012344181));

N705_8 :=__common__( map(((real)f_srchfraudsrchcountyr_i <= NULL) => -0.00850216,
              ((real)f_srchfraudsrchcountyr_i < 7.5)   => 7.9838521e-005,
                                                          -0.00850216));

N705_7 :=__common__( if(((real)c_rnt500_p < 15.9499998093), N705_8, N705_9));

N705_6 :=__common__( if(trim(C_RNT500_P) != '', N705_7, 0.0014748301));

N705_5 :=__common__( if(((real)c_span_lang < 54.5), 0.01343425, -0.0020961529));

N705_4 :=__common__( if(trim(C_SPAN_LANG) != '', N705_5, -0.0044089802));

N705_3 :=__common__( map(((real)f_divsrchaddrsuspidcount_i <= NULL) => N705_4,
              ((real)f_divsrchaddrsuspidcount_i < 0.5)   => -0.0024438952,
                                                            N705_4));

N705_2 :=__common__( if(((real)c_dist_input_to_prev_addr_i < 1.5), N705_3, N705_6));

N705_1 :=__common__( if(((real)c_dist_input_to_prev_addr_i > NULL), N705_2, 0.00097838143));

N706_12 :=__common__( if(((integer)c_med_hval < 95923), -0.011888497, -0.0010623011));

N706_11 :=__common__( if(trim(C_MED_HVAL) != '', N706_12, 0.013122503));

N706_10 :=__common__( if(((real)c_blue_empl < 100.5), 0.00072831053, 0.013026976));

N706_9 :=__common__( if(trim(C_BLUE_EMPL) != '', N706_10, -0.029082585));

N706_8 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => N706_9,
              ((real)f_inq_other_count24_i < 1.5)   => 0.00033817098,
                                                       N706_9));

N706_7 :=__common__( map(((real)f_inq_communications_count24_i <= NULL) => -0.0027419664,
              ((real)f_inq_communications_count24_i < 1.5)   => N706_8,
                                                                -0.0027419664));

N706_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N706_7, 0.0010744078));

N706_5 :=__common__( if(((real)f_inq_per_addr_i < 9.5), N706_6, N706_11));

N706_4 :=__common__( if(((real)f_inq_per_addr_i > NULL), N706_5, 0.0012627947));

N706_3 :=__common__( if(((real)c_med_hval < 45278.5), 0.0078199481, -0.00026342553));

N706_2 :=__common__( if(trim(C_MED_HVAL) != '', N706_3, -0.0013110579));

N706_1 :=__common__( if(((real)r_pb_order_freq_d > NULL), N706_2, N706_4));

N707_8 :=__common__( map(trim(C_HHSIZE) = ''              => 0.013519791,
              ((real)c_hhsize < 2.57499980927) => 0.0026823326,
                                                  0.013519791));

N707_7 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL) => N707_8,
              ((integer)f_curraddrcrimeindex_i < 88) => -0.00084015965,
                                                        N707_8));

N707_6 :=__common__( map(trim(C_RNT750_P) = ''              => -0.0013186564,
              ((real)c_rnt750_p < 42.0499992371) => N707_7,
                                                    -0.0013186564));

N707_5 :=__common__( if(((real)c_cartheft < 187.5), N707_6, -0.004114422));

N707_4 :=__common__( if(trim(C_CARTHEFT) != '', N707_5, -0.0028456891));

N707_3 :=__common__( map(((real)c_addr_lres_6mo_ct_i <= NULL) => -0.00053840245,
              ((real)c_addr_lres_6mo_ct_i < 0.5)   => N707_4,
                                                      -0.00053840245));

N707_2 :=__common__( if(((real)f_srchphonesrchcountwk_i < 0.5), N707_3, 0.0073742078));

N707_1 :=__common__( if(((real)f_srchphonesrchcountwk_i > NULL), N707_2, -0.0041022385));

N708_8 :=__common__( map(trim(C_LAR_FAM) = ''     => -0.001936058,
              ((real)c_lar_fam < 94.5) => 0.0015022404,
                                          -0.001936058));

N708_7 :=__common__( map(trim(C_OLDHOUSE) = ''              => -0.0061913453,
              ((real)c_oldhouse < 331.450012207) => N708_8,
                                                    -0.0061913453));

N708_6 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => 0.00077660974,
              ((real)r_c21_m_bureau_adl_fs_d < 46.5)  => 0.0091046548,
                                                         0.00077660974));

N708_5 :=__common__( if(((real)c_pop_75_84_p < 1.95000004768), N708_6, N708_7));

N708_4 :=__common__( if(trim(C_POP_75_84_P) != '', N708_5, 0.0031967539));

N708_3 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), 0.014234441, 0.001668561));

N708_2 :=__common__( if(((integer)f_prevaddrmedianincome_d < 13258), N708_3, N708_4));

N708_1 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N708_2, 0.0081322685));

N709_10 :=__common__( if(((integer)f_addrchangevaluediff_d < 12153), -0.0070888875, 0.0016548413));

N709_9 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N709_10, -0.005355751));

N709_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0696426704526), -8.5871949e-005, N709_9));

N709_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N709_8, -0.0030345018));

N709_6 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => 0.0031854758,
              ((real)f_m_bureau_adl_fs_all_d < 231.5) => -0.0070731581,
                                                         0.0031854758));

N709_5 :=__common__( map(trim(C_RAPE) = ''      => N709_6,
              ((real)c_rape < 172.5) => 0.0008889243,
                                        N709_6));

N709_4 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 19.5), 0.0086034009, N709_5));

N709_3 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N709_4, 0.0073862092));

N709_2 :=__common__( if(((integer)c_trailer < 85), N709_3, N709_7));

N709_1 :=__common__( if(trim(C_TRAILER) != '', N709_2, -0.0012317484));

N710_7 :=__common__( map(trim(C_OLD_HOMES) = ''      => 0.0015041323,
              ((real)c_old_homes < 115.5) => -0.0076531505,
                                             0.0015041323));

N710_6 :=__common__( map(trim(C_TOTSALES) = ''       => N710_7,
              ((integer)c_totsales < 401) => -0.011290593,
                                             N710_7));

N710_5 :=__common__( map(trim(C_NEW_HOMES) = ''      => 0.0018434733,
              ((real)c_new_homes < 130.5) => N710_6,
                                             0.0018434733));

N710_4 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL) => 0.011482407,
              ((real)f_fp_prevaddrburglaryindex_i < 150.5) => 0.0013542942,
                                                              0.011482407));

N710_3 :=__common__( map(trim(C_RNT500_P) = ''              => N710_4,
              ((real)c_rnt500_p < 53.9500007629) => 0.00044998319,
                                                    N710_4));

N710_2 :=__common__( if(((real)c_rnt500_p < 59.3499984741), N710_3, N710_5));

N710_1 :=__common__( if(trim(C_RNT500_P) != '', N710_2, -0.00021795319));

N711_9 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.0012979503,
              ((real)c_easiqlife < 130.5) => -0.0019016735,
                                             0.0012979503));

N711_8 :=__common__( map(trim(C_NO_LABFOR) = ''     => 0.012342295,
              ((real)c_no_labfor < 99.5) => 0.0038072117,
                                            0.012342295));

N711_7 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.389993816614), 0.0043628638, -0.0076610985));

N711_6 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N711_7, -0.03031068));

N711_5 :=__common__( map(trim(C_APT20) = ''     => N711_8,
              ((real)c_apt20 < 90.5) => N711_6,
                                        N711_8));

N711_4 :=__common__( if(((real)f_rel_felony_count_i < 0.5), -0.001321283, N711_5));

N711_3 :=__common__( if(((real)f_rel_felony_count_i > NULL), N711_4, -0.012730758));

N711_2 :=__common__( if(((real)c_pop_55_64_p < 6.75), N711_3, N711_9));

N711_1 :=__common__( if(trim(C_POP_55_64_P) != '', N711_2, -0.0023697296));

N712_10 :=__common__( if(((real)f_rel_incomeover50_count_d < 7.5), 0.002681186, -0.0064539852));

N712_9 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N712_10, 0.0027718794));

N712_8 :=__common__( map(trim(C_LOWRENT) = ''              => 0.012383217,
              ((real)c_lowrent < 49.0499992371) => 0.0015619027,
                                                   0.012383217));

N712_7 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => N712_8,
              ((real)f_inq_per_ssn_i < 6.5)   => -0.00038966415,
                                                 N712_8));

N712_6 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N712_7, N712_9));

N712_5 :=__common__( if(((real)r_c20_email_domain_free_count_i < 4.5), -0.0013042577, -0.0091404506));

N712_4 :=__common__( if(((real)r_c20_email_domain_free_count_i > NULL), N712_5, 0.0024370804));

N712_3 :=__common__( map(trim(C_HIGHINC) = ''              => N712_6,
              ((real)c_highinc < 2.54999995232) => N712_4,
                                                   N712_6));

N712_2 :=__common__( if(((real)c_inc_50k_p < 28.3499984741), N712_3, 0.0071554634));

N712_1 :=__common__( if(trim(C_INC_50K_P) != '', N712_2, -0.0050025801));

N713_8 :=__common__( map(trim(C_HH3_P) = ''              => 0.0067709397,
              ((real)c_hh3_p < 33.3499984741) => 0.00017825552,
                                                 0.0067709397));

N713_7 :=__common__( map(trim(C_FAMOTF18_P) = ''              => -0.0012278079,
              ((real)c_famotf18_p < 35.5500030518) => -0.011942818,
                                                      -0.0012278079));

N713_6 :=__common__( if(((integer)r_i61_inq_collection_recency_d < 549), N713_7, 0.0056757973));

N713_5 :=__common__( if(((real)r_i61_inq_collection_recency_d > NULL), N713_6, 0.0016972952));

N713_4 :=__common__( map(trim(C_HEALTH) = ''              => -0.010549665,
              ((real)c_health < 21.0499992371) => N713_5,
                                                  -0.010549665));

N713_3 :=__common__( map(trim(C_APT20) = ''      => 0.0016691605,
              ((real)c_apt20 < 130.5) => N713_4,
                                         0.0016691605));

N713_2 :=__common__( if(((real)c_many_cars < 29.5), N713_3, N713_8));

N713_1 :=__common__( if(trim(C_MANY_CARS) != '', N713_2, 0.0032082438));

N714_8 :=__common__( if(((real)f_prevaddrmurderindex_i < 184.5), -0.00079137936, -0.0089434406));

N714_7 :=__common__( if(((real)f_prevaddrmurderindex_i > NULL), N714_8, -0.0029030227));

N714_6 :=__common__( map(trim(C_RELIG_INDX) = ''      => 0.0059474599,
              ((real)c_relig_indx < 168.5) => N714_7,
                                              0.0059474599));

N714_5 :=__common__( map(trim(C_UNEMP) = ''     => N714_6,
              ((real)c_unemp < 3.25) => -0.012772256,
                                        N714_6));

N714_4 :=__common__( map(trim(C_WHITE_COL) = ''              => -0.0081036915,
              ((real)c_white_col < 50.1500015259) => 0.00070354489,
                                                     -0.0081036915));

N714_3 :=__common__( map(trim(C_RENTOCC_P) = ''              => N714_5,
              ((real)c_rentocc_p < 55.5499992371) => N714_4,
                                                     N714_5));

N714_2 :=__common__( if(((real)c_rest_indx < 170.5), N714_3, 0.0066601379));

N714_1 :=__common__( if(trim(C_REST_INDX) != '', N714_2, 1.5679925e-005));

N715_9 :=__common__( if(((real)f_rel_under25miles_cnt_d < 3.5), -0.0036528895, 0.00124989));

N715_8 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N715_9, 0.0022253919));

N715_7 :=__common__( map(((real)f_liens_unrel_o_total_amt_i <= NULL) => -0.012729393,
              ((real)f_liens_unrel_o_total_amt_i < 498.5) => -0.0010958779,
                                                             -0.012729393));

N715_6 :=__common__( map(((real)f_fp_prevaddrcrimeindex_i <= NULL) => N715_8,
              ((real)f_fp_prevaddrcrimeindex_i < 124.5) => N715_7,
                                                           N715_8));

N715_5 :=__common__( map(trim(C_INC_100K_P) = ''              => 0.012193628,
              ((real)c_inc_100k_p < 16.6500015259) => -0.0016410521,
                                                      0.012193628));

N715_4 :=__common__( if(((integer)c_totcrime < 24), N715_5, N715_6));

N715_3 :=__common__( if(trim(C_TOTCRIME) != '', N715_4, -0.0044778145));

N715_2 :=__common__( if(((integer)r_d33_eviction_recency_d < 9), 0.0052726881, N715_3));

N715_1 :=__common__( if(((real)r_d33_eviction_recency_d > NULL), N715_2, 0.0045125671));

N716_9 :=__common__( map(((real)r_l79_adls_per_addr_c6_i <= NULL) => 0.01065819,
              ((real)r_l79_adls_per_addr_c6_i < 1.5)   => 0.00047642396,
                                                          0.01065819));

N716_8 :=__common__( if(trim(C_MED_HHINC) != '', N716_9, 0.018938847));

N716_7 :=__common__( map(((real)r_l78_no_phone_at_addr_vel_i <= NULL) => -0.010014231,
              ((real)r_l78_no_phone_at_addr_vel_i < 0.5)   => -0.0011331144,
                                                              -0.010014231));

N716_6 :=__common__( map(trim(C_FAMILIES) = ''      => N716_7,
              ((real)c_families < 361.5) => 0.0039115077,
                                            N716_7));

N716_5 :=__common__( map(trim(C_POPOVER25) = ''      => N716_6,
              ((real)c_popover25 < 641.5) => -0.0079662772,
                                             N716_6));

N716_4 :=__common__( if(((real)c_med_inc < 87.5), 0.00046271518, N716_5));

N716_3 :=__common__( if(trim(C_MED_INC) != '', N716_4, 0.0053415886));

N716_2 :=__common__( if(((integer)f_curraddrmedianincome_d < 72297), N716_3, N716_8));

N716_1 :=__common__( if(((real)f_curraddrmedianincome_d > NULL), N716_2, -0.00060342427));

N717_8 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.0052439837,
              ((real)f_inq_other_count24_i < 0.5)   => -0.0074860517,
                                                       0.0052439837));

N717_7 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => -0.0084767157,
              ((real)f_sourcerisktype_i < 4.5)   => N717_8,
                                                    -0.0084767157));

N717_6 :=__common__( map(trim(C_POP_45_54_P) = ''      => 0.0080953301,
              ((real)c_pop_45_54_p < 24.25) => 0.00047862233,
                                               0.0080953301));

N717_5 :=__common__( if(((real)c_pop_25_34_p < 3.45000004768), -0.0067144758, N717_6));

N717_4 :=__common__( if(trim(C_POP_25_34_P) != '', N717_5, -0.001965523));

N717_3 :=__common__( map(((real)r_d31_mostrec_bk_i <= NULL) => N717_7,
              ((real)r_d31_mostrec_bk_i < 1.5)   => N717_4,
                                                    N717_7));

N717_2 :=__common__( if(((real)f_rel_felony_count_i < 6.5), N717_3, 0.0058768977));

N717_1 :=__common__( if(((real)f_rel_felony_count_i > NULL), N717_2, 0.00025870514));

N718_9 :=__common__( map(trim(C_NO_CAR) = ''      => 0.0072046917,
              ((real)c_no_car < 136.5) => -0.0031853226,
                                          0.0072046917));

N718_8 :=__common__( if(((integer)f_estimated_income_d < 34500), 0.0028295818, 0.01532748));

N718_7 :=__common__( if(((real)f_estimated_income_d > NULL), N718_8, -0.030942316));

N718_6 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => N718_9,
              ((real)f_add_curr_nhood_sfd_pct_d < 0.788295090199) => N718_7,
                                                                     N718_9));

N718_5 :=__common__( if(((real)f_mos_liens_unrel_sc_fseen_d < 36.5), -0.0060225377, 0.00041962216));

N718_4 :=__common__( if(((real)f_mos_liens_unrel_sc_fseen_d > NULL), N718_5, -0.0028331552));

N718_3 :=__common__( map(trim(C_TRANSPORT) = ''              => N718_6,
              ((real)c_transport < 6.35000038147) => N718_4,
                                                     N718_6));

N718_2 :=__common__( if(((real)c_rnt1000_p < 68.0500030518), N718_3, -0.009226644));

N718_1 :=__common__( if(trim(C_RNT1000_P) != '', N718_2, -0.001848903));

N719_10 :=__common__( map(((real)r_l80_inp_avm_autoval_d <= NULL)   => -0.0044264356,
               ((real)r_l80_inp_avm_autoval_d < 69994.5) => 0.0020091829,
                                                            -0.0044264356));

N719_9 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL) => N719_10,
              ((integer)f_prevaddrcartheftindex_i < 17) => 0.0093814527,
                                                           N719_10));

N719_8 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N719_9, -0.00078735805));

N719_7 :=__common__( map(trim(C_FEMDIV_P) = ''              => -0.00050609712,
              ((real)c_femdiv_p < 5.35000038147) => 0.0035941952,
                                                    -0.00050609712));

N719_6 :=__common__( if(((real)c_high_ed < 11.75), N719_7, N719_8));

N719_5 :=__common__( if(trim(C_HIGH_ED) != '', N719_6, -0.0018983558));

N719_4 :=__common__( if(((real)c_hh00 < 687.5), -0.0054111742, 0.0021649093));

N719_3 :=__common__( if(trim(C_HH00) != '', N719_4, -0.001061802));

N719_2 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 240.5), N719_3, N719_5));

N719_1 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N719_2, -0.0051911175));

N720_9 :=__common__( map(((real)c_comb_age_d <= NULL) => 0.0003746365,
              ((real)c_comb_age_d < 41.5)  => 0.011216642,
                                              0.0003746365));

N720_8 :=__common__( map(trim(C_CONSTRUCTION) = ''              => 0.0025973996,
              ((real)c_construction < 8.05000019073) => -0.0063922703,
                                                        0.0025973996));

N720_7 :=__common__( map(((real)r_d34_unrel_lien60_count_i <= NULL) => N720_8,
              ((real)r_d34_unrel_lien60_count_i < 2.5)   => 5.5106818e-005,
                                                            N720_8));

N720_6 :=__common__( map(((real)r_d31_attr_bankruptcy_recency_d <= NULL) => N720_9,
              ((real)r_d31_attr_bankruptcy_recency_d < 79.5)  => N720_7,
                                                                 N720_9));

N720_5 :=__common__( if(trim(C_RELIG_INDX) != '', N720_6, 0.0066982213));

N720_4 :=__common__( if(((real)c_inc_200k_p < 1.65000009537), 0.011578415, -0.0012292544));

N720_3 :=__common__( if(trim(C_INC_200K_P) != '', N720_4, 0.015452046));

N720_2 :=__common__( if(((real)c_mos_since_impulse_fs_d < 35.5), N720_3, N720_5));

N720_1 :=__common__( if(((real)c_mos_since_impulse_fs_d > NULL), N720_2, -5.4285104e-006));

N721_7 :=__common__( map(trim(C_MORT_INDX) = ''     => 0.00034139085,
              ((real)c_mort_indx < 38.5) => -0.0051917098,
                                            0.00034139085));

N721_6 :=__common__( map(trim(C_ARMFORCE) = ''      => 0.0064971275,
              ((real)c_armforce < 195.5) => N721_7,
                                            0.0064971275));

N721_5 :=__common__( map(trim(C_LARCENY) = ''      => -0.0094481366,
              ((real)c_larceny < 180.5) => -0.0012057386,
                                           -0.0094481366));

N721_4 :=__common__( map(trim(C_HVAL_80K_P) = ''               => N721_5,
              ((real)c_hval_80k_p < 0.700000047684) => 0.0060534486,
                                                       N721_5));

N721_3 :=__common__( map(trim(C_LOWRENT) = ''              => N721_4,
              ((real)c_lowrent < 17.5499992371) => -0.01051228,
                                                   N721_4));

N721_2 :=__common__( if(((real)c_inc_150k_p < 0.0500000007451), N721_3, N721_6));

N721_1 :=__common__( if(trim(C_INC_150K_P) != '', N721_2, 0.002187298));

N722_9 :=__common__( map(trim(C_LAR_FAM) = ''      => -0.0035583477,
              ((real)c_lar_fam < 121.5) => 0.00038769657,
                                           -0.0035583477));

N722_8 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => 0.001479251,
              ((real)r_d30_derog_count_i < 2.5)   => -0.011156282,
                                                     0.001479251));

N722_7 :=__common__( map(trim(C_INCOLLEGE) = ''              => N722_8,
              ((real)c_incollege < 10.5500001907) => 0.0028559406,
                                                     N722_8));

N722_6 :=__common__( if(((real)c_pop_65_74_p < 3.75), N722_7, N722_9));

N722_5 :=__common__( if(trim(C_POP_65_74_P) != '', N722_6, -0.00089189417));

N722_4 :=__common__( if(((real)f_rel_ageover50_count_d < 2.5), N722_5, 0.0065074311));

N722_3 :=__common__( if(((real)f_rel_ageover50_count_d > NULL), N722_4, 0.0030599723));

N722_2 :=__common__( if(((real)f_corrssnnamecount_d < 1.5), -0.0053095626, N722_3));

N722_1 :=__common__( if(((real)f_corrssnnamecount_d > NULL), N722_2, -0.0064155767));

N723_8 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)         => 0.0077166377,
              ((real)f_add_input_nhood_vac_pct_i < 0.12175835669) => -0.0022622859,
                                                                     0.0077166377));

N723_7 :=__common__( map(trim(C_CARTHEFT) = ''      => -0.0042273456,
              ((real)c_cartheft < 167.5) => N723_8,
                                            -0.0042273456));

N723_6 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 38.5), 0.0064214522, N723_7));

N723_5 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N723_6, 0.026478599));

N723_4 :=__common__( map(trim(C_INC_125K_P) = ''              => -0.0091776688,
              ((real)c_inc_125k_p < 5.94999980927) => N723_5,
                                                      -0.0091776688));

N723_3 :=__common__( map(trim(C_INC_25K_P) = ''              => N723_4,
              ((real)c_inc_25k_p < 18.6500015259) => 0.0012169975,
                                                     N723_4));

N723_2 :=__common__( if(((real)c_high_ed < 34.6500015259), N723_3, -0.003563517));

N723_1 :=__common__( if(trim(C_HIGH_ED) != '', N723_2, -0.004356688));

N724_8 :=__common__( map(trim(C_REST_INDX) = ''     => 0.0014422235,
              ((real)c_rest_indx < 68.5) => 0.0092882708,
                                            0.0014422235));

N724_7 :=__common__( map(trim(C_LOW_HVAL) = ''              => -0.006478041,
              ((real)c_low_hval < 50.5499992371) => N724_8,
                                                    -0.006478041));

N724_6 :=__common__( map(trim(C_HH4_P) = ''              => 0.0090448351,
              ((real)c_hh4_p < 16.0499992371) => 0.00035187133,
                                                 0.0090448351));

N724_5 :=__common__( map(trim(C_INC_100K_P) = ''      => -0.0049771629,
              ((real)c_inc_100k_p < 12.75) => -0.00071201367,
                                              -0.0049771629));

N724_4 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N724_5, -0.00015225641));

N724_3 :=__common__( map(trim(C_POP_85P_P) = ''              => N724_6,
              ((real)c_pop_85p_p < 2.54999995232) => N724_4,
                                                     N724_6));

N724_2 :=__common__( if(((real)c_employees < 180.5), N724_3, N724_7));

N724_1 :=__common__( if(trim(C_EMPLOYEES) != '', N724_2, 0.0017612409));

N725_8 :=__common__( map(trim(C_HVAL_60K_P) = ''     => -0.007353725,
              ((real)c_hval_60k_p < 4.75) => 0.0035198916,
                                             -0.007353725));

N725_7 :=__common__( map(trim(C_HVAL_125K_P) = ''              => N725_8,
              ((real)c_hval_125k_p < 3.45000004768) => 0.0078310055,
                                                       N725_8));

N725_6 :=__common__( if(((real)c_blue_col < 9.85000038147), 0.010534594, N725_7));

N725_5 :=__common__( if(trim(C_BLUE_COL) != '', N725_6, 0.0021027927));

N725_4 :=__common__( map(((real)r_i60_inq_comm_recency_d <= NULL) => -0.00041827344,
              ((real)r_i60_inq_comm_recency_d < 4.5)   => N725_5,
                                                          -0.00041827344));

N725_3 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => 0.011405373,
              ((real)r_c13_avg_lres_d < 45.5)  => -0.00045170799,
                                                  0.011405373));

N725_2 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 6.5), N725_3, N725_4));

N725_1 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N725_2, 0.0042773148));

N726_8 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => 0.007454618,
              ((real)f_srchfraudsrchcount_i < 7.5)   => -0.0031127511,
                                                        0.007454618));

N726_7 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => N726_8,
              ((real)f_mos_inq_banko_cm_fseen_d < 70.5)  => 0.0065161107,
                                                            N726_8));

N726_6 :=__common__( map(((real)f_corraddrnamecount_d <= NULL) => -0.0067892388,
              ((real)f_corraddrnamecount_d < 9.5)   => N726_7,
                                                       -0.0067892388));

N726_5 :=__common__( map(((real)r_d34_unrel_lien60_count_i <= NULL) => -0.0010749192,
              ((real)r_d34_unrel_lien60_count_i < 0.5)   => N726_6,
                                                            -0.0010749192));

N726_4 :=__common__( if(((real)c_span_lang < 42.5), 0.0018567841, -0.0017652737));

N726_3 :=__common__( if(trim(C_SPAN_LANG) != '', N726_4, 0.0053359273));

N726_2 :=__common__( if(((real)f_m_bureau_adl_fs_all_d < 220.5), N726_3, N726_5));

N726_1 :=__common__( if(((real)f_m_bureau_adl_fs_all_d > NULL), N726_2, 0.0073307479));

N727_8 :=__common__( map(trim(C_RENTAL) = ''      => 0.00024083393,
              ((real)c_rental < 171.5) => -0.0075323368,
                                          0.00024083393));

N727_7 :=__common__( map(trim(C_POP_85P_P) = ''               => -0.0038216691,
              ((real)c_pop_85p_p < 0.649999976158) => 0.0097074378,
                                                      -0.0038216691));

N727_6 :=__common__( map(trim(C_BURGLARY) = ''      => N727_8,
              ((real)c_burglary < 125.5) => N727_7,
                                            N727_8));

N727_5 :=__common__( map(trim(C_MANY_CARS) = ''     => 0.00013554417,
              ((real)c_many_cars < 28.5) => N727_6,
                                            0.00013554417));

N727_4 :=__common__( if(((real)c_rental < 197.5), N727_5, 0.0065225412));

N727_3 :=__common__( if(trim(C_RENTAL) != '', N727_4, -0.0039726744));

N727_2 :=__common__( if(((real)f_assoccredbureaucount_i < 6.5), N727_3, 0.0056459835));

N727_1 :=__common__( if(((real)f_assoccredbureaucount_i > NULL), N727_2, -0.0083458686));

N728_9 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0433876104653), -0.0019437178, 0.011410926));

N728_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N728_9, 0.0055398462));

N728_7 :=__common__( map(trim(C_POP_18_24_P) = ''              => 0.0011662273,
              ((real)c_pop_18_24_p < 9.55000019073) => 0.0085459273,
                                                       0.0011662273));

N728_6 :=__common__( map(((real)c_comb_age_d <= NULL) => 0.00028042455,
              ((real)c_comb_age_d < 30.5)  => N728_7,
                                              0.00028042455));

N728_5 :=__common__( map(trim(C_UNEMP) = ''              => N728_6,
              ((real)c_unemp < 3.65000009537) => -0.0033930829,
                                                 N728_6));

N728_4 :=__common__( map(((real)f_inq_adls_per_ssn_i <= NULL) => -0.0014521899,
              ((real)f_inq_adls_per_ssn_i < 0.5)   => N728_5,
                                                      -0.0014521899));

N728_3 :=__common__( if(((real)f_inq_banking_count24_i < 2.5), N728_4, N728_8));

N728_2 :=__common__( if(((real)f_inq_banking_count24_i > NULL), N728_3, -0.011704038));

N728_1 :=__common__( if(trim(C_INC_25K_P) != '', N728_2, 0.001139191));

N729_10 :=__common__( if(((real)c_rentocc_p < 64.25), 0.0026608734, -0.0051113366));

N729_9 :=__common__( if(trim(C_RENTOCC_P) != '', N729_10, -0.012409886));

N729_8 :=__common__( map(((real)f_mos_liens_unrel_sc_fseen_d <= NULL) => -0.00052889427,
              ((real)f_mos_liens_unrel_sc_fseen_d < 56.5)  => 0.0097969766,
                                                              -0.00052889427));

N729_7 :=__common__( if(((real)c_retail < 9.94999980927), N729_8, -0.0034641904));

N729_6 :=__common__( if(trim(C_RETAIL) != '', N729_7, 0.0041029617));

N729_5 :=__common__( if(((real)c_vacant_p < 16.8499984741), 0.0014491479, 0.011395185));

N729_4 :=__common__( if(trim(C_VACANT_P) != '', N729_5, -0.021843655));

N729_3 :=__common__( map(((real)f_mos_liens_unrel_lt_lseen_d <= NULL) => N729_6,
              ((real)f_mos_liens_unrel_lt_lseen_d < 135.5) => N729_4,
                                                              N729_6));

N729_2 :=__common__( if(((real)f_prevaddroccupantowned_d < 0.5), N729_3, N729_9));

N729_1 :=__common__( if(((real)f_prevaddroccupantowned_d > NULL), N729_2, 0.0079155987));

N730_9 :=__common__( if(((real)f_add_input_mobility_index_n < 0.234877333045), 0.0030065818, -0.0085369717));

N730_8 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N730_9, -0.029685618));

N730_7 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => 0.0024333251,
              ((real)r_c14_addrs_15yr_i < 6.5)   => -0.0040358055,
                                                    0.0024333251));

N730_6 :=__common__( map(trim(C_HVAL_250K_P) = ''              => 0.0067511994,
              ((real)c_hval_250k_p < 17.8499984741) => N730_7,
                                                       0.0067511994));

N730_5 :=__common__( map(trim(C_RURAL_P) = ''              => N730_8,
              ((real)c_rural_p < 10.0500001907) => N730_6,
                                                   N730_8));

N730_4 :=__common__( if(((real)c_femdiv_p < 5.64999961853), N730_5, -0.0042614521));

N730_3 :=__common__( if(trim(C_FEMDIV_P) != '', N730_4, -0.0076639884));

N730_2 :=__common__( if(((integer)f_fp_prevaddrcrimeindex_i < 116), N730_3, 0.0012294205));

N730_1 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N730_2, 0.0035717211));

N731_10 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.379782736301), -0.0060534298, 0.005856774));

N731_9 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N731_10, -0.029559935));

N731_8 :=__common__( map(((real)f_assocrisktype_i <= NULL) => 0.010265627,
              ((real)f_assocrisktype_i < 8.5)   => 0.0012323328,
                                                   0.010265627));

N731_7 :=__common__( map(trim(C_INC_50K_P) = ''      => 0.013986999,
              ((real)c_inc_50k_p < 19.25) => N731_8,
                                             0.013986999));

N731_6 :=__common__( if(((real)c_unemp < 6.25), N731_7, N731_9));

N731_5 :=__common__( if(trim(C_UNEMP) != '', N731_6, -0.0071652333));

N731_4 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.699536442757), -0.00082205086, 0.0049245312));

N731_3 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N731_4, -0.0020789473));

N731_2 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)     => N731_5,
              ((integer)f_prevaddrmedianvalue_d < 186940) => N731_3,
                                                             N731_5));

N731_1 :=__common__( if(((real)f_rel_under500miles_cnt_d > NULL), N731_2, 0.00090412853));

N732_11 :=__common__( map(trim(C_FAMILIES) = ''      => -0.0080971007,
               ((real)c_families < 237.5) => 0.0029080227,
                                             -0.0080971007));

N732_10 :=__common__( if(((real)c_med_yearblt < 1982.5), N732_11, 0.0029275441));

N732_9 :=__common__( if(trim(C_MED_YEARBLT) != '', N732_10, 0.0028380336));

N732_8 :=__common__( if(((real)c_preschl < 117.5), 0.0015911179, -0.0040674856));

N732_7 :=__common__( if(trim(C_PRESCHL) != '', N732_8, -0.0091375417));

N732_6 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 1.5), N732_7, 0.0010782911));

N732_5 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N732_6, -0.0011998746));

N732_4 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.187482357025), 0.0074569288, N732_5));

N732_3 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N732_4, -0.0034147072));

N732_2 :=__common__( if(((real)f_rel_criminal_count_i < 12.5), N732_3, N732_9));

N732_1 :=__common__( if(((real)f_rel_criminal_count_i > NULL), N732_2, -0.0030923339));

N733_8 :=__common__( map(((real)f_rel_criminal_count_i <= NULL) => -0.0058197975,
              ((real)f_rel_criminal_count_i < 4.5)   => 0.0050510821,
                                                        -0.0058197975));

N733_7 :=__common__( map(trim(C_FEMDIV_P) = ''              => 0.0011972475,
              ((real)c_femdiv_p < 3.54999995232) => 0.01143972,
                                                    0.0011972475));

N733_6 :=__common__( map(trim(C_BLUE_COL) = ''              => 0.013554654,
              ((real)c_blue_col < 17.0499992371) => N733_7,
                                                    0.013554654));

N733_5 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 70.5), N733_6, N733_8));

N733_4 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N733_5, -0.017013692));

N733_3 :=__common__( map(trim(C_RELIG_INDX) = ''      => -0.0057794876,
              ((real)c_relig_indx < 176.5) => N733_4,
                                              -0.0057794876));

N733_2 :=__common__( if(((real)c_health < 21.8499984741), -0.0003253216, N733_3));

N733_1 :=__common__( if(trim(C_HEALTH) != '', N733_2, 0.0003574504));

N734_9 :=__common__( map(trim(C_INC_35K_P) = ''              => 0.0034951456,
              ((real)c_inc_35k_p < 16.8499984741) => -0.0034412136,
                                                     0.0034951456));

N734_8 :=__common__( map(((real)f_rel_bankrupt_count_i <= NULL) => N734_9,
              ((real)f_rel_bankrupt_count_i < 2.5)   => 0.00032591568,
                                                        N734_9));

N734_7 :=__common__( map(trim(C_HVAL_200K_P) = ''              => 0.0051427027,
              ((real)c_hval_200k_p < 21.6500015259) => N734_8,
                                                       0.0051427027));

N734_6 :=__common__( if(((real)c_addr_lres_12mo_ct_i > NULL), N734_7, -0.0093442677));

N734_5 :=__common__( map(trim(C_CONSTRUCTION) = ''              => -0.012184594,
              ((real)c_construction < 4.14999961853) => -0.00049243279,
                                                        -0.012184594));

N734_4 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.00412229541689), N734_5, N734_6));

N734_3 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N734_4, 0.00014464235));

N734_2 :=__common__( if(((real)c_totsales < 237709.5), N734_3, 0.0088723308));

N734_1 :=__common__( if(trim(C_TOTSALES) != '', N734_2, -0.003413737));

N735_8 :=__common__( map(trim(C_INC_150K_P) = ''              => 0.0025758475,
              ((real)c_inc_150k_p < 5.14999961853) => -0.0033595316,
                                                      0.0025758475));

N735_7 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)    => -0.0037014857,
              ((integer)f_prevaddrmedianvalue_d < 49536) => 0.0036931034,
                                                            -0.0037014857));

N735_6 :=__common__( map(trim(C_HVAL_40K_P) = ''              => N735_7,
              ((real)c_hval_40k_p < 8.44999980927) => 0.0015641864,
                                                      N735_7));

N735_5 :=__common__( map(trim(C_CONSTRUCTION) = ''              => N735_8,
              ((real)c_construction < 10.5500001907) => N735_6,
                                                        N735_8));

N735_4 :=__common__( if(((real)c_pop_25_34_p < 3.45000004768), -0.0077308726, N735_5));

N735_3 :=__common__( if(trim(C_POP_25_34_P) != '', N735_4, -0.00095033321));

N735_2 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 14.5), 0.0067363813, N735_3));

N735_1 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N735_2, 0.0019079715));

N736_8 :=__common__( map(trim(C_NO_LABFOR) = ''      => -0.0072173132,
              ((real)c_no_labfor < 159.5) => 0.002009424,
                                             -0.0072173132));

N736_7 :=__common__( map(trim(C_INC_50K_P) = ''     => N736_8,
              ((real)c_inc_50k_p < 7.75) => -0.0069609182,
                                            N736_8));

N736_6 :=__common__( map(trim(C_UNEMPL) = ''     => N736_7,
              ((real)c_unempl < 82.5) => 0.0065996868,
                                         N736_7));

N736_5 :=__common__( map(trim(C_URBAN_P) = ''              => N736_6,
              ((real)c_urban_p < 20.2000007629) => -0.0072109409,
                                                   N736_6));

N736_4 :=__common__( if(((real)c_femdiv_p < 1.75), 0.0073025579, N736_5));

N736_3 :=__common__( if(trim(C_FEMDIV_P) != '', N736_4, 0.0040230985));

N736_2 :=__common__( if(((real)f_rel_felony_count_i < 1.5), -0.0013078422, N736_3));

N736_1 :=__common__( if(((real)f_rel_felony_count_i > NULL), N736_2, -0.0062336493));

N737_7 :=__common__( map(trim(C_POP_12_17_P) = ''              => -0.0008113591,
              ((real)c_pop_12_17_p < 4.44999980927) => -0.0089741533,
                                                       -0.0008113591));

N737_6 :=__common__( map(trim(C_POP_25_34_P) = ''              => 0.0068277892,
              ((real)c_pop_25_34_p < 21.6500015259) => N737_7,
                                                       0.0068277892));

N737_5 :=__common__( map(trim(C_HHSIZE) = ''              => -0.007848874,
              ((real)c_hhsize < 2.93499994278) => N737_6,
                                                  -0.007848874));

N737_4 :=__common__( map(trim(C_INC_150K_P) = ''              => -0.00026865167,
              ((real)c_inc_150k_p < 1.95000004768) => -0.010941215,
                                                      -0.00026865167));

N737_3 :=__common__( map(trim(C_POP_65_74_P) = ''              => N737_4,
              ((real)c_pop_65_74_p < 10.4499998093) => 0.0011372455,
                                                       N737_4));

N737_2 :=__common__( if(((real)c_lowrent < 51.3499984741), N737_3, N737_5));

N737_1 :=__common__( if(trim(C_LOWRENT) != '', N737_2, 0.0010233419));

N738_8 :=__common__( map(trim(C_RNT1000_P) = ''              => -0.0069889552,
              ((real)c_rnt1000_p < 3.65000009537) => 0.0025309856,
                                                     -0.0069889552));

N738_7 :=__common__( map(trim(C_FAMILIES) = ''      => -0.0029712592,
              ((real)c_families < 192.5) => 0.0038697483,
                                            -0.0029712592));

N738_6 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => 0.0013469489,
              ((real)f_srchssnsrchcount_i < 0.5)   => -0.0040265249,
                                                      0.0013469489));

N738_5 :=__common__( map(((real)f_rel_count_i <= NULL) => N738_7,
              ((real)f_rel_count_i < 21.5)  => N738_6,
                                               N738_7));

N738_4 :=__common__( if(((real)c_medi_indx < 116.5), N738_5, N738_8));

N738_3 :=__common__( if(trim(C_MEDI_INDX) != '', N738_4, -0.0001509328));

N738_2 :=__common__( if(((real)c_impulse_count_i < 2.5), N738_3, 0.0077205865));

N738_1 :=__common__( if(((real)c_impulse_count_i > NULL), N738_2, -0.011804477));

N739_9 :=__common__( map(trim(C_HVAL_200K_P) = ''              => -0.013254995,
              ((real)c_hval_200k_p < 13.0500001907) => -0.002666049,
                                                       -0.013254995));

N739_8 :=__common__( map(trim(C_LOW_HVAL) = ''              => -0.0038787907,
              ((real)c_low_hval < 17.2000007629) => 0.0044624118,
                                                    -0.0038787907));

N739_7 :=__common__( if(((real)c_unique_addr_count_i < 8.5), N739_8, N739_9));

N739_6 :=__common__( if(((real)c_unique_addr_count_i > NULL), N739_7, 0.010812156));

N739_5 :=__common__( map(((real)f_liens_unrel_sc_total_amt_i <= NULL)  => -0.010875317,
              ((real)f_liens_unrel_sc_total_amt_i < 1770.5) => 0.0010987356,
                                                               -0.010875317));

N739_4 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i < 2720.5), N739_5, 0.0057259635));

N739_3 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i > NULL), N739_4, -0.011453317));

N739_2 :=__common__( if(((real)c_wholesale < 2.25), N739_3, N739_6));

N739_1 :=__common__( if(trim(C_WHOLESALE) != '', N739_2, 0.0014095093));

N740_8 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL)  => 0.0078857919,
              ((integer)f_curraddrburglaryindex_i < 121) => -0.00048718223,
                                                            0.0078857919));

N740_7 :=__common__( map(trim(C_OCCUNIT_P) = ''              => -0.0072792549,
              ((real)c_occunit_p < 92.3500061035) => 0.0003536641,
                                                     -0.0072792549));

N740_6 :=__common__( if(((real)c_inc_75k_p < 19.25), N740_7, N740_8));

N740_5 :=__common__( if(trim(C_INC_75K_P) != '', N740_6, -0.00064487367));

N740_4 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.0079558905,
              ((real)r_c14_addrs_10yr_i < 10.5)  => N740_5,
                                                    0.0079558905));

N740_3 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => N740_4,
              ((real)f_mos_liens_unrel_cj_fseen_d < 28.5)  => 0.010185422,
                                                              N740_4));

N740_2 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d < 65.5), -0.0005384784, N740_3));

N740_1 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d > NULL), N740_2, -0.0031084494));

N741_8 :=__common__( map(((real)f_bus_name_nover_i <= NULL) => -0.0019582928,
              ((real)f_bus_name_nover_i < 0.5)   => 0.0042857252,
                                                    -0.0019582928));

N741_7 :=__common__( map(trim(C_TOTSALES) = ''        => N741_8,
              ((real)c_totsales < 15596.5) => -0.0017107913,
                                              N741_8));

N741_6 :=__common__( map(((real)f_historical_count_d <= NULL) => 0.012627235,
              ((real)f_historical_count_d < 6.5)   => 0.001520947,
                                                      0.012627235));

N741_5 :=__common__( map(trim(C_FAMILIES) = ''      => N741_7,
              ((real)c_families < 252.5) => N741_6,
                                            N741_7));

N741_4 :=__common__( map(trim(C_EXP_PROD) = ''      => -0.0094430658,
              ((real)c_exp_prod < 105.5) => -0.0011810321,
                                            -0.0094430658));

N741_3 :=__common__( if(((real)c_hh00 < 324.5), N741_4, N741_5));

N741_2 :=__common__( if(trim(C_HH00) != '', N741_3, -0.00031256083));

N741_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N741_2, -0.0002312705));

N742_9 :=__common__( map(trim(C_POPOVER18) = ''      => 0.0014411949,
              ((real)c_popover18 < 577.5) => -0.0074010549,
                                             0.0014411949));

N742_8 :=__common__( if(((integer)r_f01_inp_addr_address_score_d < 11), -0.01035848, -0.0017085895));

N742_7 :=__common__( if(((real)r_f01_inp_addr_address_score_d > NULL), N742_8, 0.019397652));

N742_6 :=__common__( map(trim(C_EXP_PROD) = ''     => N742_9,
              ((real)c_exp_prod < 69.5) => N742_7,
                                           N742_9));

N742_5 :=__common__( map(trim(C_APT20) = ''     => 0.0039449655,
              ((real)c_apt20 < 89.5) => -0.0068633271,
                                        0.0039449655));

N742_4 :=__common__( if(((real)r_i60_inq_hiriskcred_count12_i < 1.5), 0.0028866157, N742_5));

N742_3 :=__common__( if(((real)r_i60_inq_hiriskcred_count12_i > NULL), N742_4, 0.017714236));

N742_2 :=__common__( if(((real)c_food < 12.4499998093), N742_3, N742_6));

N742_1 :=__common__( if(trim(C_FOOD) != '', N742_2, -0.0014823102));

N743_9 :=__common__( map(((real)f_prevaddrlenofres_d <= NULL) => 0.0047294732,
              ((real)f_prevaddrlenofres_d < 23.5)  => -0.0053898851,
                                                      0.0047294732));

N743_8 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => 0.0066866841,
              ((real)f_mos_inq_banko_cm_lseen_d < 33.5)  => N743_9,
                                                            0.0066866841));

N743_7 :=__common__( map(trim(C_VACANT_P) = ''      => -0.0091296069,
              ((real)c_vacant_p < 13.25) => 0.002225025,
                                            -0.0091296069));

N743_6 :=__common__( if(((real)c_retired2 < 50.5), N743_7, N743_8));

N743_5 :=__common__( if(trim(C_RETIRED2) != '', N743_6, 0.0050388039));

N743_4 :=__common__( if(((real)r_c13_curr_addr_lres_d < 87.5), N743_5, -0.0027733313));

N743_3 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N743_4, -0.028306842));

N743_2 :=__common__( if(((real)f_srchaddrsrchcount_i < 10.5), -0.00049570991, N743_3));

N743_1 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N743_2, -0.0062401023));

N744_11 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => 0.002326756,
               ((real)c_hist_addr_match_i < 3.5)   => -0.0018859538,
                                                      0.002326756));

N744_10 :=__common__( if(((real)c_rental < 187.5), N744_11, 0.0057129504));

N744_9 :=__common__( if(trim(C_RENTAL) != '', N744_10, 0.0015538207));

N744_8 :=__common__( if(((real)c_ab_av_edu < 62.5), 0.0031680593, -0.0022456878));

N744_7 :=__common__( if(trim(C_AB_AV_EDU) != '', N744_8, -0.00010939768));

N744_6 :=__common__( if(((real)r_pb_order_freq_d > NULL), N744_7, N744_9));

N744_5 :=__common__( if(((real)c_vacant_p < 6.75), 0.0032749348, -0.0050975106));

N744_4 :=__common__( if(trim(C_VACANT_P) != '', N744_5, 0.0074416641));

N744_3 :=__common__( map(((real)f_mos_acc_lseen_d <= NULL) => N744_6,
              ((real)f_mos_acc_lseen_d < 116.5) => N744_4,
                                                   N744_6));

N744_2 :=__common__( if(((real)f_srchfraudsrchcountyr_i < 9.5), N744_3, -0.0069843887));

N744_1 :=__common__( if(((real)f_srchfraudsrchcountyr_i > NULL), N744_2, -0.0022664542));

N745_8 :=__common__( map(((real)r_i60_inq_comm_recency_d <= NULL) => -0.010949069,
              ((real)r_i60_inq_comm_recency_d < 4.5)   => 0.0012940697,
                                                          -0.010949069));

N745_7 :=__common__( map((fp_segment in ['2 NAS 479', '4 Bureau Only'])                                         => -0.005622411,
              (fp_segment in ['1 SSN Prob', '3 New DID', '5 Derog', '6 Recent Activity', '7 Other']) => 0.0018607273,
                                                                                                        0.0018607273));

N745_6 :=__common__( map(((real)f_corrrisktype_i <= NULL) => 0.0055071234,
              ((real)f_corrrisktype_i < 8.5)   => N745_7,
                                                  0.0055071234));

N745_5 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N745_6,
              ((real)c_hist_addr_match_i < 3.5)   => -0.0011722543,
                                                     N745_6));

N745_4 :=__common__( if(((real)c_pop_18_24_p < 2.15000009537), 0.0062266836, N745_5));

N745_3 :=__common__( if(trim(C_POP_18_24_P) != '', N745_4, -0.0025884356));

N745_2 :=__common__( if(((real)r_i60_inq_comm_count12_i < 3.5), N745_3, N745_8));

N745_1 :=__common__( if(((real)r_i60_inq_comm_count12_i > NULL), N745_2, 0.00040998765));

N746_8 :=__common__( map(((real)c_impulse_count_i <= NULL) => 0.0074894896,
              ((real)c_impulse_count_i < 1.5)   => -0.0021501641,
                                                   0.0074894896));

N746_7 :=__common__( map(trim(C_INFO) = ''              => -0.0057652223,
              ((real)c_info < 3.34999990463) => 0.0020144244,
                                                -0.0057652223));

N746_6 :=__common__( map(trim(C_MANY_CARS) = ''     => -0.00042196204,
              ((real)c_many_cars < 28.5) => -0.0095787765,
                                            -0.00042196204));

N746_5 :=__common__( map(((real)c_mos_since_impulse_fs_d <= NULL) => N746_7,
              ((real)c_mos_since_impulse_fs_d < 65.5)  => N746_6,
                                                          N746_7));

N746_4 :=__common__( if(((real)f_corraddrphonecount_d < 0.5), N746_5, N746_8));

N746_3 :=__common__( if(((real)f_corraddrphonecount_d > NULL), N746_4, 0.0031103183));

N746_2 :=__common__( if(((real)c_young < 47.6500015259), N746_3, -0.008630726));

N746_1 :=__common__( if(trim(C_YOUNG) != '', N746_2, -0.002109149));

N747_9 :=__common__( map(((real)r_c13_curr_addr_lres_d <= NULL) => -0.0029246729,
              ((real)r_c13_curr_addr_lres_d < 51.5)  => 0.0095073042,
                                                        -0.0029246729));

N747_8 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => N747_9,
              ((real)r_c13_avg_lres_d < 50.5)  => -0.0051699505,
                                                  N747_9));

N747_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0221197083592), -0.0089864865, N747_8));

N747_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N747_7, -0.00046166781));

N747_5 :=__common__( if(((real)f_rel_educationover12_count_d < 31.5), 0.0011077851, 0.0083857617));

N747_4 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N747_5, -0.004076744));

N747_3 :=__common__( map(((real)r_d31_bk_disposed_recent_count_i <= NULL) => -0.0050911836,
              ((real)r_d31_bk_disposed_recent_count_i < 0.5)   => N747_4,
                                                                  -0.0050911836));

N747_2 :=__common__( if(((real)c_dist_best_to_prev_addr_i < 169.5), N747_3, N747_6));

N747_1 :=__common__( if(((real)c_dist_best_to_prev_addr_i > NULL), N747_2, -0.0024059102));

N748_9 :=__common__( map(trim(C_OLD_HOMES) = ''      => -0.0042572828,
              ((real)c_old_homes < 123.5) => 0.00043902242,
                                             -0.0042572828));

N748_8 :=__common__( map(trim(C_INC_125K_P) = ''              => N748_9,
              ((real)c_inc_125k_p < 3.34999990463) => 0.0019408927,
                                                      N748_9));

N748_7 :=__common__( map(((real)f_corraddrphonecount_d <= NULL) => -0.00080086746,
              ((real)f_corraddrphonecount_d < 0.5)   => 0.0087842598,
                                                        -0.00080086746));

N748_6 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => -0.0090525666,
              ((real)r_c13_max_lres_d < 181.5) => N748_7,
                                                  -0.0090525666));

N748_5 :=__common__( map(trim(C_LAR_FAM) = ''      => 0.0074805901,
              ((real)c_lar_fam < 127.5) => N748_6,
                                           0.0074805901));

N748_4 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), N748_5, N748_8));

N748_3 :=__common__( if(trim(C_INC_125K_P) != '', N748_4, 0.0013962888));

N748_2 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 19.5), N748_3, -0.0074176685));

N748_1 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N748_2, 0.004964078));

N749_10 :=__common__( map(((real)f_srchfraudsrchcountyr_i <= NULL) => 0.0046655918,
               ((real)f_srchfraudsrchcountyr_i < 5.5)   => -0.0076849419,
                                                           0.0046655918));

N749_9 :=__common__( if(((integer)f_addrchangevaluediff_d < -35000), 0.0033014582, -0.0051318818));

N749_8 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N749_9, N749_10));

N749_7 :=__common__( map(trim(C_MANUFACTURING) = ''              => -0.01067677,
              ((real)c_manufacturing < 12.3500003815) => -0.00099126382,
                                                         -0.01067677));

N749_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0831381380558), 0.0013100703, N749_7));

N749_5 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N749_6, 0.0011534805));

N749_4 :=__common__( if(((real)f_srchssnsrchcount_i < 13.5), N749_5, N749_8));

N749_3 :=__common__( if(((real)f_srchssnsrchcount_i > NULL), N749_4, -0.006241955));

N749_2 :=__common__( if(((real)c_food < 38.75), N749_3, 0.0022758115));

N749_1 :=__common__( if(trim(C_FOOD) != '', N749_2, 0.004932366));

N750_8 :=__common__( map(trim(C_NEWHOUSE) = ''              => 0.010510234,
              ((real)c_newhouse < 6.55000019073) => -0.001028114,
                                                    0.010510234));

N750_7 :=__common__( map(trim(C_RENTAL) = ''      => 0.00032885312,
              ((real)c_rental < 113.5) => 0.011406189,
                                          0.00032885312));

N750_6 :=__common__( map(((real)r_i60_inq_count12_i <= NULL) => -0.00052540684,
              ((real)r_i60_inq_count12_i < 7.5)   => N750_7,
                                                     -0.00052540684));

N750_5 :=__common__( map(((real)r_i60_inq_retail_recency_d <= NULL) => -0.00031719037,
              ((real)r_i60_inq_retail_recency_d < 61.5)  => -0.0076126374,
                                                            -0.00031719037));

N750_4 :=__common__( if(((real)f_srchfraudsrchcountyr_i < 3.5), N750_5, N750_6));

N750_3 :=__common__( if(((real)f_srchfraudsrchcountyr_i > NULL), N750_4, -0.0010142349));

N750_2 :=__common__( if(((real)c_serv_empl < 192.5), N750_3, N750_8));

N750_1 :=__common__( if(trim(C_SERV_EMPL) != '', N750_2, -0.002014843));

N751_7 :=__common__( map(trim(C_POPOVER25) = ''        => -0.0064128651,
              ((integer)c_popover25 < 1423) => 0.0059624188,
                                               -0.0064128651));

N751_6 :=__common__( map(trim(C_HVAL_40K_P) = ''               => 0.010991318,
              ((real)c_hval_40k_p < 0.550000011921) => N751_7,
                                                       0.010991318));

N751_5 :=__common__( map(trim(C_BEL_EDU) = ''      => -0.0033125404,
              ((real)c_bel_edu < 135.5) => N751_6,
                                           -0.0033125404));

N751_4 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => -0.0064581926,
              ((real)f_add_curr_nhood_vac_pct_i < 0.142602518201) => N751_5,
                                                                     -0.0064581926));

N751_3 :=__common__( map(trim(C_INC_100K_P) = ''      => N751_4,
              ((real)c_inc_100k_p < 16.75) => -0.00086466148,
                                              N751_4));

N751_2 :=__common__( if(((real)c_low_hval < 78.75), N751_3, 0.0081247995));

N751_1 :=__common__( if(trim(C_LOW_HVAL) != '', N751_2, 0.001525918));

N752_8 :=__common__( map(((real)r_d33_eviction_count_i <= NULL) => 0.012880908,
              ((real)r_d33_eviction_count_i < 1.5)   => 0.0027125637,
                                                        0.012880908));

N752_7 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => N752_8,
              ((real)r_c14_addrs_15yr_i < 16.5)  => 0.00033073341,
                                                    N752_8));

N752_6 :=__common__( map(((real)f_mos_liens_unrel_sc_fseen_d <= NULL) => -0.001989924,
              ((real)f_mos_liens_unrel_sc_fseen_d < 172.5) => 0.0024887031,
                                                              -0.001989924));

N752_5 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N752_7,
              ((real)c_hist_addr_match_i < 2.5)   => N752_6,
                                                     N752_7));

N752_4 :=__common__( if(((real)f_inq_highriskcredit_count24_i < 19.5), N752_5, -0.0080659633));

N752_3 :=__common__( if(((real)f_inq_highriskcredit_count24_i > NULL), N752_4, 0.0063709248));

N752_2 :=__common__( if(((real)c_lowrent < 97.1499938965), N752_3, -0.0076671084));

N752_1 :=__common__( if(trim(C_LOWRENT) != '', N752_2, 0.0036273639));

N753_8 :=__common__( map(((real)f_srchaddrsrchcountwk_i <= NULL) => -0.0087639473,
              ((real)f_srchaddrsrchcountwk_i < 0.5)   => -0.00036889963,
                                                         -0.0087639473));

N753_7 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => 0.0036557922,
              ((real)f_mos_liens_unrel_cj_fseen_d < 129.5) => 0.012522874,
                                                              0.0036557922));

N753_6 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => -0.0015748075,
              ((real)c_dist_best_to_prev_addr_i < 15.5)  => N753_7,
                                                            -0.0015748075));

N753_5 :=__common__( if(((real)c_lar_fam < 104.5), N753_6, -0.0014572309));

N753_4 :=__common__( if(trim(C_LAR_FAM) != '', N753_5, 0.0090597654));

N753_3 :=__common__( map((fp_segment in ['2 NAS 479', '3 New DID', '5 Derog', '6 Recent Activity', '7 Other']) => N753_4,
              (fp_segment in ['1 SSN Prob', '4 Bureau Only'])                                       => 0.029428727,
                                                                                                       N753_4));

N753_2 :=__common__( if(((real)r_a50_pb_average_dollars_d < 33.5), N753_3, N753_8));

N753_1 :=__common__( if(((real)r_a50_pb_average_dollars_d > NULL), N753_2, -0.0047363558));

N754_8 :=__common__( map(trim(C_MANUFACTURING) = ''              => 0.003829008,
              ((real)c_manufacturing < 1.15000009537) => -0.0051109018,
                                                         0.003829008));

N754_7 :=__common__( map(trim(C_NO_CAR) = ''     => 0.011382738,
              ((real)c_no_car < 62.5) => -0.0016570032,
                                         0.011382738));

N754_6 :=__common__( map(trim(C_FAMILIES) = ''      => N754_7,
              ((real)c_families < 513.5) => -0.0037016616,
                                            N754_7));

N754_5 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => N754_6,
              ((real)f_prevaddrmedianincome_d < 27003.5) => 0.0088193356,
                                                            N754_6));

N754_4 :=__common__( if(((real)c_unemp < 5.94999980927), N754_5, N754_8));

N754_3 :=__common__( if(trim(C_UNEMP) != '', N754_4, -0.0025125027));

N754_2 :=__common__( if(((real)f_rel_count_i < 21.5), 0.00087121994, N754_3));

N754_1 :=__common__( if(((real)f_rel_count_i > NULL), N754_2, -0.0023784424));

N755_8 :=__common__( map(((real)r_i60_inq_comm_recency_d <= NULL) => -0.001095957,
              ((real)r_i60_inq_comm_recency_d < 4.5)   => 0.0037580781,
                                                          -0.001095957));

N755_7 :=__common__( map(trim(C_RNT750_P) = ''              => N755_8,
              ((real)c_rnt750_p < 10.3500003815) => 0.0019830664,
                                                    N755_8));

N755_6 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => -0.0067325498,
              ((real)f_add_input_nhood_vac_pct_i < 0.411429107189) => N755_7,
                                                                      -0.0067325498));

N755_5 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => 0.0078569179,
              ((real)f_add_input_nhood_vac_pct_i < 0.758492469788) => N755_6,
                                                                      0.0078569179));

N755_4 :=__common__( if(((real)f_srchaddrsrchcountwk_i < 0.5), N755_5, -0.0059244209));

N755_3 :=__common__( if(((real)f_srchaddrsrchcountwk_i > NULL), N755_4, -0.0082268297));

N755_2 :=__common__( if(((real)c_rnt750_p < 86.5), N755_3, 0.0081281671));

N755_1 :=__common__( if(trim(C_RNT750_P) != '', N755_2, -0.00080215355));

N756_9 :=__common__( if(((real)f_inq_count24_i < 3.5), 0.0019616935, -0.0079750607));

N756_8 :=__common__( if(((real)f_inq_count24_i > NULL), N756_9, -0.03079774));

N756_7 :=__common__( map(trim(C_HH7P_P) = ''              => N756_8,
              ((real)c_hh7p_p < 7.14999961853) => 0.0012379489,
                                                  N756_8));

N756_6 :=__common__( map(trim(C_POP_6_11_P) = ''     => N756_7,
              ((real)c_pop_6_11_p < 2.75) => -0.0079204395,
                                             N756_7));

N756_5 :=__common__( if(((integer)f_fp_prevaddrburglaryindex_i < 39), 0.0073697169, -0.0016908039));

N756_4 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i > NULL), N756_5, -0.013009363));

N756_3 :=__common__( map(trim(C_FOR_SALE) = ''      => N756_4,
              ((real)c_for_sale < 113.5) => -0.0054403685,
                                            N756_4));

N756_2 :=__common__( if(((integer)c_cartheft < 82), N756_3, N756_6));

N756_1 :=__common__( if(trim(C_CARTHEFT) != '', N756_2, -0.0002550161));

N757_10 :=__common__( if(((real)f_prevaddrmurderindex_i < 164.5), 0.01254059, 0.00041583482));

N757_9 :=__common__( if(((real)f_prevaddrmurderindex_i > NULL), N757_10, 0.066896945));

N757_8 :=__common__( map(trim(C_OLDHOUSE) = ''              => -0.0042043576,
              ((real)c_oldhouse < 31.5499992371) => 0.0036813943,
                                                    -0.0042043576));

N757_7 :=__common__( if(((real)f_prevaddrlenofres_d < 1.5), -0.0063156738, 0.0021413268));

N757_6 :=__common__( if(((real)f_prevaddrlenofres_d > NULL), N757_7, -0.0097116536));

N757_5 :=__common__( map(trim(C_PROFESSIONAL) = ''              => N757_8,
              ((real)c_professional < 1.34999990463) => N757_6,
                                                        N757_8));

N757_4 :=__common__( map(trim(C_FAMILIES) = ''      => N757_5,
              ((real)c_families < 150.5) => -0.0078942281,
                                            N757_5));

N757_3 :=__common__( if(((real)c_assault < 182.5), N757_4, N757_9));

N757_2 :=__common__( if(trim(C_ASSAULT) != '', N757_3, 0.0015086784));

N757_1 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N757_2, 0.00045862214));

N758_9 :=__common__( if(((real)f_srchunvrfdssncount_i < 1.5), -0.00081169137, 0.00673272));

N758_8 :=__common__( if(((real)f_srchunvrfdssncount_i > NULL), N758_9, -0.00053735892));

N758_7 :=__common__( map(trim(C_HH00) = ''      => 0.0029285499,
              ((real)c_hh00 < 380.5) => -0.0064188944,
                                        0.0029285499));

N758_6 :=__common__( map(trim(C_MED_HVAL) = ''        => 0.0058510384,
              ((real)c_med_hval < 75699.5) => N758_7,
                                              0.0058510384));

N758_5 :=__common__( map(trim(C_NO_LABFOR) = ''      => 0.00089912678,
              ((real)c_no_labfor < 115.5) => -0.012117892,
                                             0.00089912678));

N758_4 :=__common__( if(((real)f_mos_liens_unrel_sc_fseen_d < 164.5), N758_5, N758_6));

N758_3 :=__common__( if(((real)f_mos_liens_unrel_sc_fseen_d > NULL), N758_4, -0.0032540876));

N758_2 :=__common__( if(((real)c_rnt750_p < 10.5500001907), N758_3, N758_8));

N758_1 :=__common__( if(trim(C_RNT750_P) != '', N758_2, -0.0036993124));

N759_10 :=__common__( map(trim(C_HIGHINC) = ''              => 0.0054033883,
               ((real)c_highinc < 11.4499998093) => -0.0059754695,
                                                    0.0054033883));

N759_9 :=__common__( if(((integer)f_fp_prevaddrcrimeindex_i < 134), N759_10, 0.009056502));

N759_8 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N759_9, -0.0093028258));

N759_7 :=__common__( if(((real)f_add_input_mobility_index_n < 0.329832673073), -0.0045997845, -0.00010504514));

N759_6 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N759_7, -0.036623772));

N759_5 :=__common__( map(((real)f_assoccredbureaucount_i <= NULL) => -0.00011266664,
              ((real)f_assoccredbureaucount_i < 0.5)   => N759_6,
                                                          -0.00011266664));

N759_4 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 65.5), 0.0050719443, N759_5));

N759_3 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N759_4, -0.001406311));

N759_2 :=__common__( if(((real)c_rich_wht < 171.5), N759_3, N759_8));

N759_1 :=__common__( if(trim(C_RICH_WHT) != '', N759_2, 0.00016208051));

N760_7 :=__common__( map(trim(C_LOW_HVAL) = ''              => 0.013205422,
              ((real)c_low_hval < 39.1500015259) => 0.0042622493,
                                                    0.013205422));

N760_6 :=__common__( map(trim(C_REST_INDX) = ''      => -0.0040119425,
              ((real)c_rest_indx < 138.5) => N760_7,
                                             -0.0040119425));

N760_5 :=__common__( map(trim(C_HH1_P) = ''      => -0.0032685993,
              ((real)c_hh1_p < 38.75) => N760_6,
                                         -0.0032685993));

N760_4 :=__common__( map(trim(C_OLD_HOMES) = ''      => -0.0015277226,
              ((real)c_old_homes < 117.5) => 0.0063395893,
                                             -0.0015277226));

N760_3 :=__common__( map(trim(C_MED_AGE) = ''      => N760_4,
              ((real)c_med_age < 41.75) => -0.0011236448,
                                           N760_4));

N760_2 :=__common__( if(((real)c_serv_empl < 172.5), N760_3, N760_5));

N760_1 :=__common__( if(trim(C_SERV_EMPL) != '', N760_2, 0.0015701606));

N761_8 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => 0.010065677,
              ((real)r_c14_addrs_5yr_i < 4.5)   => 0.0025708826,
                                                   0.010065677));

N761_7 :=__common__( if(((real)c_popover25 < 658.5), -0.0047970404, 0.0012345328));

N761_6 :=__common__( if(trim(C_POPOVER25) != '', N761_7, -0.0073501113));

N761_5 :=__common__( map(((real)f_prevaddroccupantowned_d <= NULL) => 0.012451746,
              ((real)f_prevaddroccupantowned_d < 0.5)   => 0.0013816977,
                                                           0.012451746));

N761_4 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => N761_6,
              ((real)f_mos_inq_banko_om_fseen_d < 27.5)  => N761_5,
                                                            N761_6));

N761_3 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N761_8,
              ((real)c_hist_addr_match_i < 6.5)   => N761_4,
                                                     N761_8));

N761_2 :=__common__( if(((real)r_f03_input_add_not_most_rec_i < 0.5), -0.00054290974, N761_3));

N761_1 :=__common__( if(((real)r_f03_input_add_not_most_rec_i > NULL), N761_2, 0.00086616009));

N762_8 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => 0.001432144,
              ((real)r_c13_avg_lres_d < 39.5)  => 0.010066464,
                                                  0.001432144));

N762_7 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL) => 0.0026678915,
              ((real)f_curraddrcrimeindex_i < 178.5) => -0.00018809722,
                                                        0.0026678915));

N762_6 :=__common__( map(trim(C_FOR_SALE) = ''      => -0.0055179321,
              ((real)c_for_sale < 195.5) => N762_7,
                                            -0.0055179321));

N762_5 :=__common__( map(trim(C_HVAL_175K_P) = ''              => -0.0079987449,
              ((real)c_hval_175k_p < 22.6500015259) => N762_6,
                                                       -0.0079987449));

N762_4 :=__common__( if(((real)c_hval_175k_p < 26.25), N762_5, N762_8));

N762_3 :=__common__( if(trim(C_HVAL_175K_P) != '', N762_4, 0.0017839336));

N762_2 :=__common__( if(((real)r_c20_email_domain_free_count_i < 5.5), N762_3, -0.0058282318));

N762_1 :=__common__( if(((real)r_c20_email_domain_free_count_i > NULL), N762_2, 0.0025380076));

N763_10 :=__common__( map(((real)f_prevaddrageoldest_d <= NULL) => 0.0015397076,
               ((real)f_prevaddrageoldest_d < 22.5)  => 0.011251892,
                                                        0.0015397076));

N763_9 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.482361018658), N763_10, -0.0051701756));

N763_8 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N763_9, -5.7207992e-005));

N763_7 :=__common__( if(((real)c_pop_65_74_p < 3.75), N763_8, -0.0029034668));

N763_6 :=__common__( if(trim(C_POP_65_74_P) != '', N763_7, -0.0055208971));

N763_5 :=__common__( map(trim(C_LOW_HVAL) = ''              => 0.002227112,
              ((real)c_low_hval < 21.5499992371) => -0.0017165829,
                                                    0.002227112));

N763_4 :=__common__( if(((real)c_rape < 86.5), 0.0035455851, N763_5));

N763_3 :=__common__( if(trim(C_RAPE) != '', N763_4, 0.00072517094));

N763_2 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 5.5), N763_3, N763_6));

N763_1 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N763_2, -0.00060793146));

N764_7 :=__common__( map(trim(C_MED_RENT) = ''       => 0.0078160202,
              ((integer)c_med_rent < 715) => -0.0025952225,
                                             0.0078160202));

N764_6 :=__common__( map(trim(C_HH1_P) = ''              => 0.00076151517,
              ((real)c_hh1_p < 34.3499984741) => 0.014166904,
                                                 0.00076151517));

N764_5 :=__common__( map(trim(C_BIGAPT_P) = ''              => 0.0074588538,
              ((real)c_bigapt_p < 2.65000009537) => -0.0025744128,
                                                    0.0074588538));

N764_4 :=__common__( map(trim(C_OLD_HOMES) = ''      => N764_6,
              ((real)c_old_homes < 128.5) => N764_5,
                                             N764_6));

N764_3 :=__common__( map(trim(C_HIGHINC) = ''              => 0.00032220538,
              ((real)c_highinc < 1.04999995232) => N764_4,
                                                   0.00032220538));

N764_2 :=__common__( if(((real)c_inc_25k_p < 17.9500007629), N764_3, N764_7));

N764_1 :=__common__( if(trim(C_INC_25K_P) != '', N764_2, 0.0020233451));

N765_8 :=__common__( map(trim(C_TOTSALES) = ''       => 0.0053167977,
              ((real)c_totsales < 2387.5) => -0.0014369206,
                                             0.0053167977));

N765_7 :=__common__( if(((integer)f_prevaddrmedianincome_d < 22739), N765_8, -0.00087507155));

N765_6 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N765_7, 0.0065485372));

N765_5 :=__common__( map(trim(C_FAMMAR18_P) = ''              => N765_6,
              ((real)c_fammar18_p < 2.84999990463) => -0.0066660016,
                                                      N765_6));

N765_4 :=__common__( map(trim(C_NO_MOVE) = ''      => 0.0066466796,
              ((real)c_no_move < 185.5) => N765_5,
                                           0.0066466796));

N765_3 :=__common__( map(trim(C_POPOVER25) = ''      => N765_4,
              ((real)c_popover25 < 346.5) => -0.0074681644,
                                             N765_4));

N765_2 :=__common__( if(((real)c_white_col < 12.5500001907), 0.0048657018, N765_3));

N765_1 :=__common__( if(trim(C_WHITE_COL) != '', N765_2, -0.00079370497));

N766_9 :=__common__( map(trim(C_CIV_EMP) = ''              => -0.011604649,
              ((real)c_civ_emp < 67.0500030518) => -0.00097179286,
                                                   -0.011604649));

N766_8 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => 0.001235353,
              ((real)r_c13_max_lres_d < 49.5)  => N766_9,
                                                  0.001235353));

N766_7 :=__common__( map(trim(C_FINANCE) = ''              => 0.0062453561,
              ((real)c_finance < 13.1499996185) => N766_8,
                                                   0.0062453561));

N766_6 :=__common__( if(((real)c_inc_75k_p < 22.5499992371), N766_7, -0.0020897742));

N766_5 :=__common__( if(trim(C_INC_75K_P) != '', N766_6, 0.0022600673));

N766_4 :=__common__( if(((real)c_for_sale < 125.5), -0.0029985196, -0.013807637));

N766_3 :=__common__( if(trim(C_FOR_SALE) != '', N766_4, -0.0034083893));

N766_2 :=__common__( if(((real)f_corrssnnamecount_d < 1.5), N766_3, N766_5));

N766_1 :=__common__( if(((real)f_corrssnnamecount_d > NULL), N766_2, 0.00094947383));

N767_9 :=__common__( map(trim(C_HHSIZE) = ''              => 0.0097701818,
              ((real)c_hhsize < 2.48500013351) => -0.0015534129,
                                                  0.0097701818));

N767_8 :=__common__( map(((real)f_addrchangevaluediff_d <= NULL)  => -0.0061319533,
              ((integer)f_addrchangevaluediff_d < 437) => 0.0040539473,
                                                          -0.0061319533));

N767_7 :=__common__( if(((real)f_addrchangecrimediff_i < -25.5), 0.010530311, N767_8));

N767_6 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N767_7, N767_9));

N767_5 :=__common__( map(trim(C_HVAL_175K_P) = ''              => -0.0048763891,
              ((real)c_hval_175k_p < 15.6499996185) => N767_6,
                                                       -0.0048763891));

N767_4 :=__common__( map(trim(C_BIGAPT_P) = ''              => 0.00053874055,
              ((real)c_bigapt_p < 1.34999990463) => -0.0017449454,
                                                    0.00053874055));

N767_3 :=__common__( map(((real)f_rel_ageover40_count_d <= NULL) => N767_5,
              ((real)f_rel_ageover40_count_d < 7.5)   => N767_4,
                                                         N767_5));

N767_2 :=__common__( if(trim(C_MED_AGE) != '', N767_3, -0.0029396892));

N767_1 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N767_2, 0.00078462706));

N768_9 :=__common__( map(trim(C_VERY_RICH) = ''      => 0.011057502,
              ((real)c_very_rich < 110.5) => 2.283508e-005,
                                             0.011057502));

N768_8 :=__common__( if(((real)f_rel_under25miles_cnt_d < 19.5), -0.0029871517, 0.0042268511));

N768_7 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N768_8, -0.0090729643));

N768_6 :=__common__( map(trim(C_BLUE_COL) = ''              => 0.0014666418,
              ((real)c_blue_col < 14.9499998093) => N768_7,
                                                    0.0014666418));

N768_5 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), -0.00077618646, N768_6));

N768_4 :=__common__( map(trim(C_HVAL_250K_P) = ''              => 0.0030238004,
              ((real)c_hval_250k_p < 20.3499984741) => N768_5,
                                                       0.0030238004));

N768_3 :=__common__( map(trim(C_MED_HHINC) = ''         => -0.0099155459,
              ((integer)c_med_hhinc < 89846) => N768_4,
                                                -0.0099155459));

N768_2 :=__common__( if(((real)c_hval_500k_p < 19.6500015259), N768_3, N768_9));

N768_1 :=__common__( if(trim(C_HVAL_500K_P) != '', N768_2, 0.0017366574));

N769_9 :=__common__( map(trim(C_HH6_P) = ''               => 0.010250736,
              ((real)c_hh6_p < 0.949999988079) => 0.00010990753,
                                                  0.010250736));

N769_8 :=__common__( map(trim(C_HVAL_400K_P) = ''      => 0.011848262,
              ((real)c_hval_400k_p < 14.25) => 0.00090133454,
                                               0.011848262));

N769_7 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 6.5), 0.00051651865, -0.0019420383));

N769_6 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N769_7, -0.0026543454));

N769_5 :=__common__( map(trim(C_HIGH_ED) = ''              => N769_8,
              ((real)c_high_ed < 41.5499992371) => N769_6,
                                                   N769_8));

N769_4 :=__common__( if(((real)f_rel_felony_count_i < 6.5), N769_5, N769_9));

N769_3 :=__common__( if(((real)f_rel_felony_count_i > NULL), N769_4, 0.0027947854));

N769_2 :=__common__( if(((real)c_mining < 0.649999976158), N769_3, -0.0092377918));

N769_1 :=__common__( if(trim(C_MINING) != '', N769_2, 0.003107708));

N770_8 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => 0.010837512,
              ((real)f_add_input_mobility_index_n < 0.294168055058) => -0.0010018366,
                                                                       0.010837512));

N770_7 :=__common__( map(trim(C_HVAL_250K_P) = ''              => N770_8,
              ((real)c_hval_250k_p < 12.8500003815) => -7.7041112e-005,
                                                       N770_8));

N770_6 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => N770_7,
              ((real)f_add_input_nhood_vac_pct_i < 0.0173667669296) => -0.0026702778,
                                                                       N770_7));

N770_5 :=__common__( map(trim(C_ASSAULT) = ''      => -0.0032449541,
              ((real)c_assault < 123.5) => N770_6,
                                           -0.0032449541));

N770_4 :=__common__( if(((real)f_rel_homeover150_count_d < 2.5), 0.0019631204, N770_5));

N770_3 :=__common__( if(((real)f_rel_homeover150_count_d > NULL), N770_4, 0.0013831407));

N770_2 :=__common__( if(((real)c_hval_20k_p < 11.1499996185), N770_3, -0.0027116345));

N770_1 :=__common__( if(trim(C_HVAL_20K_P) != '', N770_2, -0.0015903645));

N771_8 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => 0.010754147,
              ((real)r_c13_avg_lres_d < 41.5)  => 0.0012290519,
                                                  0.010754147));

N771_7 :=__common__( map(trim(C_RELIG_INDX) = ''      => 0.010001404,
              ((real)c_relig_indx < 129.5) => -0.000822249,
                                              0.010001404));

N771_6 :=__common__( map(trim(C_HVAL_400K_P) = ''              => -0.0082889606,
              ((real)c_hval_400k_p < 17.4500007629) => 0.00012852532,
                                                       -0.0082889606));

N771_5 :=__common__( map(trim(C_PROFESSIONAL) = ''              => N771_7,
              ((real)c_professional < 11.5500001907) => N771_6,
                                                        N771_7));

N771_4 :=__common__( if(((real)c_addr_lres_6mo_ct_i < 7.5), N771_5, N771_8));

N771_3 :=__common__( if(((real)c_addr_lres_6mo_ct_i > NULL), N771_4, 0.0035511255));

N771_2 :=__common__( if(((real)c_hh1_p < 27.25), -0.0011560243, N771_3));

N771_1 :=__common__( if(trim(C_HH1_P) != '', N771_2, -0.0025935906));

N772_9 :=__common__( if(((real)c_hh2_p < 41.8499984741), 0.00068952687, -0.008009607));

N772_8 :=__common__( if(trim(C_HH2_P) != '', N772_9, 0.0086450517));

N772_7 :=__common__( map(((real)f_mos_liens_unrel_cj_lseen_d <= NULL) => 0.0063183039,
              ((real)f_mos_liens_unrel_cj_lseen_d < 239.5) => 0.00074099115,
                                                              0.0063183039));

N772_6 :=__common__( map(((real)c_addr_lres_12mo_ct_i <= NULL) => N772_8,
              ((real)c_addr_lres_12mo_ct_i < 5.5)   => N772_7,
                                                       N772_8));

N772_5 :=__common__( if(((real)c_hh6_p < 4.64999961853), 0.0010558404, -0.0045759685));

N772_4 :=__common__( if(trim(C_HH6_P) != '', N772_5, -0.0032954831));

N772_3 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => N772_6,
              ((real)f_rel_felony_count_i < 0.5)   => N772_4,
                                                      N772_6));

N772_2 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i < 4.5), N772_3, -0.0023325659));

N772_1 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i > NULL), N772_2, 0.0049989445));

N773_7 :=__common__( map(trim(C_RETAIL) = ''              => -0.0075404474,
              ((real)c_retail < 8.05000019073) => 0.00098282866,
                                                  -0.0075404474));

N773_6 :=__common__( map(((real)f_adl_util_conv_n <= NULL) => N773_7,
              ((real)f_adl_util_conv_n < 0.5)   => 0.0035672861,
                                                   N773_7));

N773_5 :=__common__( map(trim(C_INC_15K_P) = ''              => 0.003955916,
              ((real)c_inc_15k_p < 9.55000019073) => -0.0030847023,
                                                     0.003955916));

N773_4 :=__common__( map(trim(C_SFDU_P) = ''              => 0.012309117,
              ((real)c_sfdu_p < 96.5500030518) => N773_5,
                                                  0.012309117));

N773_3 :=__common__( map(trim(C_SUB_BUS) = ''      => N773_6,
              ((real)c_sub_bus < 121.5) => N773_4,
                                           N773_6));

N773_2 :=__common__( if(((real)c_hh4_p < 10.25), N773_3, -0.00085861824));

N773_1 :=__common__( if(trim(C_HH4_P) != '', N773_2, 0.0012818849));

N774_9 :=__common__( map(trim(C_INC_75K_P) = ''              => -0.001230093,
              ((real)c_inc_75k_p < 15.0500001907) => 0.0098036074,
                                                     -0.001230093));

N774_8 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.0536056384444), -0.0038769442, N774_9));

N774_7 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N774_8, 0.0049961209));

N774_6 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => -0.013559855,
              ((real)f_curraddrburglaryindex_i < 156.5) => -0.0033663564,
                                                           -0.013559855));

N774_5 :=__common__( map(((real)r_c20_email_domain_free_count_i <= NULL) => N774_6,
              ((real)r_c20_email_domain_free_count_i < 1.5)   => -0.0016364544,
                                                                 N774_6));

N774_4 :=__common__( if(((integer)f_fp_prevaddrcrimeindex_i < 189), -0.00025742085, N774_5));

N774_3 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N774_4, 0.0050330338));

N774_2 :=__common__( if(((real)c_hval_80k_p < 32.25), N774_3, N774_7));

N774_1 :=__common__( if(trim(C_HVAL_80K_P) != '', N774_2, 0.0025030548));

N775_8 :=__common__( map(trim(C_BEL_EDU) = ''     => -0.0074907688,
              ((real)c_bel_edu < 77.5) => 0.0063308665,
                                          -0.0074907688));

N775_7 :=__common__( map(trim(C_YOUNG) = ''              => 0.01000412,
              ((real)c_young < 28.0499992371) => N775_8,
                                                 0.01000412));

N775_6 :=__common__( map(trim(C_FAMMAR_P) = ''              => N775_7,
              ((real)c_fammar_p < 65.4499969482) => -0.0052460496,
                                                    N775_7));

N775_5 :=__common__( map(trim(C_RETAIL) = ''              => 0.008191039,
              ((real)c_retail < 32.1500015259) => 0.0018204188,
                                                  0.008191039));

N775_4 :=__common__( if(((real)c_civ_emp < 61.6500015259), N775_5, N775_6));

N775_3 :=__common__( if(trim(C_CIV_EMP) != '', N775_4, 0.00027699501));

N775_2 :=__common__( if(((real)f_rel_bankrupt_count_i < 1.5), N775_3, -0.00072192829));

N775_1 :=__common__( if(((real)f_rel_bankrupt_count_i > NULL), N775_2, -0.0014125364));

N776_8 :=__common__( if(((real)r_d32_criminal_count_i < 19.5), -0.00098097414, 0.0083584306));

N776_7 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N776_8, 0.0018970995));

N776_6 :=__common__( if(((real)c_rental < 135.5), 0.0011971155, 0.010047704));

N776_5 :=__common__( if(trim(C_RENTAL) != '', N776_6, -0.017570702));

N776_4 :=__common__( if(((real)r_i60_inq_comm_count12_i < 1.5), 0.0011567008, -0.008136015));

N776_3 :=__common__( if(((real)r_i60_inq_comm_count12_i > NULL), N776_4, 0.013356794));

N776_2 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => N776_3,
              (segment in ['SEARS FLS'])                                  => N776_5,
                                                                             N776_3));

N776_1 :=__common__( map(((real)f_adl_util_conv_n <= NULL) => N776_7,
              ((real)f_adl_util_conv_n < 0.5)   => N776_2,
                                                   N776_7));

N777_8 :=__common__( map(trim(C_HHSIZE) = ''      => 0.0071622563,
              ((real)c_hhsize < 2.875) => 0.0015055233,
                                          0.0071622563));

N777_7 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.0019547424,
              ((real)f_rel_felony_count_i < 0.5)   => -0.0019124334,
                                                      0.0019547424));

N777_6 :=__common__( if(((real)r_c14_addrs_10yr_i < 8.5), N777_7, N777_8));

N777_5 :=__common__( if(((real)r_c14_addrs_10yr_i > NULL), N777_6, -0.0068077929));

N777_4 :=__common__( map(trim(C_RETIRED) = ''              => N777_5,
              ((real)c_retired < 3.04999995232) => -0.003801507,
                                                   N777_5));

N777_3 :=__common__( map(trim(C_TOTCRIME) = ''      => -0.0066966943,
              ((real)c_totcrime < 197.5) => N777_4,
                                            -0.0066966943));

N777_2 :=__common__( if(((real)c_blue_empl < 16.5), -0.0062289685, N777_3));

N777_1 :=__common__( if(trim(C_BLUE_EMPL) != '', N777_2, 0.0010652591));

N778_9 :=__common__( map(trim(C_RNT500_P) = ''              => -0.011425955,
              ((real)c_rnt500_p < 23.0499992371) => -0.00052884079,
                                                    -0.011425955));

N778_8 :=__common__( if(((real)c_pop_85p_p < 0.449999988079), N778_9, 0.0019042815));

N778_7 :=__common__( if(trim(C_POP_85P_P) != '', N778_8, 0.0045027141));

N778_6 :=__common__( map(trim(C_NEW_HOMES) = ''      => 0.0016261556,
              ((real)c_new_homes < 133.5) => 0.011364293,
                                             0.0016261556));

N778_5 :=__common__( if(((real)c_lar_fam < 72.5), -0.0019434738, N778_6));

N778_4 :=__common__( if(trim(C_LAR_FAM) != '', N778_5, 0.015206689));

N778_3 :=__common__( map(((real)r_a44_curr_add_naprop_d <= NULL) => N778_7,
              ((real)r_a44_curr_add_naprop_d < 0.5)   => N778_4,
                                                         N778_7));

N778_2 :=__common__( if(((real)f_assocsuspicousidcount_i < 7.5), -0.00083752474, N778_3));

N778_1 :=__common__( if(((real)f_assocsuspicousidcount_i > NULL), N778_2, 0.0074929693));

N779_8 :=__common__( map(trim(C_HEALTH) = ''      => 0.0060927094,
              ((real)c_health < 11.75) => 0.0011363651,
                                          0.0060927094));

N779_7 :=__common__( map(((real)f_inq_per_addr_i <= NULL) => -0.0043010562,
              ((real)f_inq_per_addr_i < 9.5)   => N779_8,
                                                  -0.0043010562));

N779_6 :=__common__( map(trim(C_VERY_RICH) = ''      => -0.0024832758,
              ((real)c_very_rich < 120.5) => N779_7,
                                             -0.0024832758));

N779_5 :=__common__( map(trim(C_POP_25_34_P) = ''              => 0.0070373726,
              ((real)c_pop_25_34_p < 27.1500015259) => -0.0010852013,
                                                       0.0070373726));

N779_4 :=__common__( map(trim(C_POP_75_84_P) = ''               => N779_5,
              ((real)c_pop_75_84_p < 0.850000023842) => -0.0049898723,
                                                        N779_5));

N779_3 :=__common__( if(((real)c_pop_45_54_p < 14.5500001907), N779_4, N779_6));

N779_2 :=__common__( if(trim(C_POP_45_54_P) != '', N779_3, 0.00038046996));

N779_1 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N779_2, -0.0040202366));

N780_9 :=__common__( if(((real)r_c14_addrs_15yr_i < 8.5), 0.0004783364, 0.010015277));

N780_8 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N780_9, -0.0075507785));

N780_7 :=__common__( map(((real)f_corraddrnamecount_d <= NULL) => 0.0047635399,
              ((real)f_corraddrnamecount_d < 6.5)   => -0.0069696335,
                                                       0.0047635399));

N780_6 :=__common__( map(trim(C_POP_45_54_P) = ''      => 0.007544917,
              ((real)c_pop_45_54_p < 14.75) => N780_7,
                                               0.007544917));

N780_5 :=__common__( map(trim(C_POP_35_44_P) = ''              => N780_6,
              ((real)c_pop_35_44_p < 14.0500001907) => -0.0049937668,
                                                       N780_6));

N780_4 :=__common__( if(((real)r_c14_addr_stability_v2_d < 5.5), 0.00045090515, N780_5));

N780_3 :=__common__( if(((real)r_c14_addr_stability_v2_d > NULL), N780_4, -0.0046289404));

N780_2 :=__common__( if(((real)c_hh6_p < 11.0500001907), N780_3, N780_8));

N780_1 :=__common__( if(trim(C_HH6_P) != '', N780_2, -0.0026322005));

N781_9 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i < 144.5), 0.013097519, -0.0047903442));

N781_8 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i > NULL), N781_9, 0.025152948));

N781_7 :=__common__( map(trim(C_CONSTRUCTION) = ''              => -0.0043582704,
              ((real)c_construction < 10.0500001907) => 0.0052801794,
                                                        -0.0043582704));

N781_6 :=__common__( map(((real)f_srchphonesrchcount_i <= NULL) => -0.004340904,
              ((real)f_srchphonesrchcount_i < 4.5)   => N781_7,
                                                        -0.004340904));

N781_5 :=__common__( map(trim(C_INC_25K_P) = ''              => 0.0092835922,
              ((real)c_inc_25k_p < 22.4500007629) => N781_6,
                                                     0.0092835922));

N781_4 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), N781_5, -0.00096523789));

N781_3 :=__common__( if(((real)f_current_count_d > NULL), N781_4, -0.0080767338));

N781_2 :=__common__( if(((real)c_hh2_p < 49.3499984741), N781_3, N781_8));

N781_1 :=__common__( if(trim(C_HH2_P) != '', N781_2, -0.0031534448));

N782_9 :=__common__( if(((real)c_trailer < 130.5), -0.0017411182, 0.008902661));

N782_8 :=__common__( if(trim(C_TRAILER) != '', N782_9, -0.00021370525));

N782_7 :=__common__( map(((real)f_corraddrnamecount_d <= NULL) => -0.0047764565,
              ((real)f_corraddrnamecount_d < 0.5)   => N782_8,
                                                       -0.0047764565));

N782_6 :=__common__( map(trim(C_OWNOCC_P) = ''      => -0.0006282499,
              ((real)c_ownocc_p < 31.75) => -0.0060268988,
                                            -0.0006282499));

N782_5 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => 0.0070841454,
              ((real)r_d30_derog_count_i < 16.5)  => N782_6,
                                                     0.0070841454));

N782_4 :=__common__( if(((real)c_pop_75_84_p < 2.95000004768), 0.0015647079, N782_5));

N782_3 :=__common__( if(trim(C_POP_75_84_P) != '', N782_4, 0.00055851567));

N782_2 :=__common__( if(((integer)c_hist_addr_match_i < 28), N782_3, N782_7));

N782_1 :=__common__( if(((real)c_hist_addr_match_i > NULL), N782_2, 0.0055200341));

N783_11 :=__common__( if(((real)f_corrssnaddrcount_d < 3.5), 0.0096259691, 0.0009421889));

N783_10 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N783_11, 0.002719973));

N783_9 :=__common__( map(trim(C_NO_MOVE) = ''     => N783_10,
              ((real)c_no_move < 48.5) => -0.0038367552,
                                          N783_10));

N783_8 :=__common__( if(((real)c_hh6_p < 2.34999990463), N783_9, -0.0047785129));

N783_7 :=__common__( if(trim(C_HH6_P) != '', N783_8, 0.0058932167));

N783_6 :=__common__( if(((real)c_hval_20k_p < 28.25), -3.7145819e-005, 0.0072829104));

N783_5 :=__common__( if(trim(C_HVAL_20K_P) != '', N783_6, -0.0021000995));

N783_4 :=__common__( if(((real)c_families < 329.5), -0.0096463877, -0.00089994282));

N783_3 :=__common__( if(trim(C_FAMILIES) != '', N783_4, 0.009944655));

N783_2 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => N783_5,
              ((real)r_c13_avg_lres_d < 11.5)  => N783_3,
                                                  N783_5));

N783_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N783_2, N783_7));

N784_9 :=__common__( if(((real)r_c13_avg_lres_d < 44.5), -0.001498289, 0.0088497093));

N784_8 :=__common__( if(((real)r_c13_avg_lres_d > NULL), N784_9, 0.015558866));

N784_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0328295379877), 0.004677695, -0.0075481449));

N784_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N784_7, 0.011860812));

N784_5 :=__common__( map(trim(C_FINANCE) = ''               => N784_6,
              ((real)c_finance < 0.550000011921) => -0.011787677,
                                                    N784_6));

N784_4 :=__common__( map(trim(C_NO_LABFOR) = ''     => 0.0001168785,
              ((real)c_no_labfor < 25.5) => N784_5,
                                            0.0001168785));

N784_3 :=__common__( map(trim(C_POP_6_11_P) = ''              => N784_8,
              ((real)c_pop_6_11_p < 13.8500003815) => N784_4,
                                                      N784_8));

N784_2 :=__common__( if(((integer)c_med_hhinc < 15130), 0.0062255434, N784_3));

N784_1 :=__common__( if(trim(C_MED_HHINC) != '', N784_2, -0.0034098088));

N785_9 :=__common__( map(trim(C_SERV_EMPL) = ''      => 0.00023867558,
              ((real)c_serv_empl < 119.5) => 0.011469943,
                                             0.00023867558));

N785_8 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.012436702,
              ((real)r_c20_email_count_i < 5.5)   => 0.00034026245,
                                                     -0.012436702));

N785_7 :=__common__( if(((real)r_c14_addrs_10yr_i < 9.5), N785_8, N785_9));

N785_6 :=__common__( if(((real)r_c14_addrs_10yr_i > NULL), N785_7, 0.010717343));

N785_5 :=__common__( map(trim(C_RNT750_P) = ''              => -0.0025066828,
              ((real)c_rnt750_p < 3.54999995232) => -0.012109986,
                                                    -0.0025066828));

N785_4 :=__common__( if(((real)c_fammar_p < 54.9500007629), N785_5, N785_6));

N785_3 :=__common__( if(trim(C_FAMMAR_P) != '', N785_4, -0.0030664719));

N785_2 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.164589643478), 0.0013621879, N785_3));

N785_1 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N785_2, -0.0003173084));

N786_8 :=__common__( map(trim(C_SUB_BUS) = ''      => -0.0018389555,
              ((real)c_sub_bus < 138.5) => 0.0024886677,
                                           -0.0018389555));

N786_7 :=__common__( map(trim(C_FOR_SALE) = ''      => -0.007276764,
              ((real)c_for_sale < 191.5) => N786_8,
                                            -0.007276764));

N786_6 :=__common__( map(trim(C_BARGAINS) = ''      => 0.0042430595,
              ((real)c_bargains < 175.5) => N786_7,
                                            0.0042430595));

N786_5 :=__common__( if(((real)c_hval_200k_p < 10.3500003815), N786_6, -0.0026873853));

N786_4 :=__common__( if(trim(C_HVAL_200K_P) != '', N786_5, -0.0082279415));

N786_3 :=__common__( map(((real)c_comb_age_d <= NULL) => N786_4,
              ((real)c_comb_age_d < 24.5)  => 0.0088116442,
                                              N786_4));

N786_2 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 122.5), -0.0018019615, N786_3));

N786_1 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N786_2, 0.0043421787));

N787_8 :=__common__( map(trim(C_POP_25_34_P) = ''              => 0.00082202729,
              ((real)c_pop_25_34_p < 3.84999990463) => -0.006877762,
                                                       0.00082202729));

N787_7 :=__common__( map(trim(C_UNEMP) = ''              => 0.0019773976,
              ((real)c_unemp < 3.34999990463) => -0.0071020321,
                                                 0.0019773976));

N787_6 :=__common__( if(((real)c_unique_addr_count_i < 10.5), -0.0088096887, 0.0011731037));

N787_5 :=__common__( if(((real)c_unique_addr_count_i > NULL), N787_6, -0.031824162));

N787_4 :=__common__( map(((real)r_s66_adlperssn_count_i <= NULL) => N787_7,
              ((real)r_s66_adlperssn_count_i < 1.5)   => N787_5,
                                                         N787_7));

N787_3 :=__common__( map((fp_segment in ['2 NAS 479', '3 New DID', '4 Bureau Only'])               => N787_4,
              (fp_segment in ['1 SSN Prob', '5 Derog', '6 Recent Activity', '7 Other']) => N787_8,
                                                                                           N787_8));

N787_2 :=__common__( if(((real)c_inc_25k_p < 28.1500015259), N787_3, -0.0055090056));

N787_1 :=__common__( if(trim(C_INC_25K_P) != '', N787_2, 0.0030470202));

N788_8 :=__common__( map(trim(C_INC_50K_P) = ''              => 0.00064319695,
              ((real)c_inc_50k_p < 8.35000038147) => 0.01125465,
                                                     0.00064319695));

N788_7 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.00089551678,
              ((real)c_comb_age_d < 25.5)  => N788_8,
                                              -0.00089551678));

N788_6 :=__common__( map(((real)f_prevaddrlenofres_d <= NULL) => 0.001510115,
              ((real)f_prevaddrlenofres_d < 34.5)  => 0.010692092,
                                                      0.001510115));

N788_5 :=__common__( map((segment in ['KMART', 'SEARS SHO'])                => -0.0072224355,
              (segment in ['RETAIL', 'SEARS AUTO', 'SEARS FLS']) => 0.0075711406,
                                                                    0.0075711406));

N788_4 :=__common__( if(((real)f_historical_count_d < 1.5), N788_5, N788_6));

N788_3 :=__common__( if(((real)f_historical_count_d > NULL), N788_4, 0.042988804));

N788_2 :=__common__( if(((real)c_child < 19.4500007629), N788_3, N788_7));

N788_1 :=__common__( if(trim(C_CHILD) != '', N788_2, 0.0020173334));

N789_8 :=__common__( map(trim(C_INC_125K_P) = ''              => 0.00051200075,
              ((real)c_inc_125k_p < 2.04999995232) => 0.0089829619,
                                                      0.00051200075));

N789_7 :=__common__( map(trim(C_POP_25_34_P) = ''              => -0.0013037194,
              ((real)c_pop_25_34_p < 14.5500001907) => 0.010730427,
                                                       -0.0013037194));

N789_6 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => 0.0048666186,
              ((real)f_srchaddrsrchcount_i < 36.5)  => -0.00068388517,
                                                       0.0048666186));

N789_5 :=__common__( if(((real)f_srchphonesrchcountmo_i < 0.5), N789_6, N789_7));

N789_4 :=__common__( if(((real)f_srchphonesrchcountmo_i > NULL), N789_5, -0.0088069918));

N789_3 :=__common__( map(trim(C_INFO) = ''               => -0.0046963401,
              ((real)c_info < 0.649999976158) => N789_4,
                                                 -0.0046963401));

N789_2 :=__common__( if(((real)c_hh1_p < 49.3499984741), N789_3, N789_8));

N789_1 :=__common__( if(trim(C_HH1_P) != '', N789_2, 0.0036762561));

N790_8 :=__common__( map(trim(C_HH4_P) = ''              => -0.0043391322,
              ((real)c_hh4_p < 12.3500003815) => 0.0011159199,
                                                 -0.0043391322));

N790_7 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d < 15.5), 0.0058457311, N790_8));

N790_6 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d > NULL), N790_7, -0.0084536287));

N790_5 :=__common__( map(trim(C_MED_HHINC) = ''        => N790_6,
              ((real)c_med_hhinc < 15408.5) => 0.0077129081,
                                               N790_6));

N790_4 :=__common__( map(trim(C_RNT500_P) = ''              => -0.0072060561,
              ((real)c_rnt500_p < 56.5499992371) => N790_5,
                                                    -0.0072060561));

N790_3 :=__common__( map(trim(C_POP00) = ''      => 0.00092083389,
              ((real)c_pop00 < 690.5) => 0.0078902066,
                                         0.00092083389));

N790_2 :=__common__( if(((real)c_unemp < 8.14999961853), N790_3, N790_4));

N790_1 :=__common__( if(trim(C_UNEMP) != '', N790_2, 0.00063494687));

N791_8 :=__common__( map(trim(C_FAMOTF18_P) = ''              => 0.016550582,
              ((real)c_famotf18_p < 22.9500007629) => 0.0065699138,
                                                      0.016550582));

N791_7 :=__common__( map(trim(C_RETIRED2) = ''      => 0.0026706232,
              ((real)c_retired2 < 105.5) => N791_8,
                                            0.0026706232));

N791_6 :=__common__( map(trim(C_RELIG_INDX) = ''     => N791_7,
              ((real)c_relig_indx < 86.5) => -0.00051127458,
                                             N791_7));

N791_5 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => -6.9712913e-005,
              ((real)r_c21_m_bureau_adl_fs_d < 194.5) => N791_6,
                                                         -6.9712913e-005));

N791_4 :=__common__( map(trim(C_ASSAULT) = ''      => 0.0060933161,
              ((real)c_assault < 196.5) => -0.00053835768,
                                           0.0060933161));

N791_3 :=__common__( if(((real)f_corraddrnamecount_d < 6.5), N791_4, N791_5));

N791_2 :=__common__( if(((real)f_corraddrnamecount_d > NULL), N791_3, 0.0043212185));

N791_1 :=__common__( if(trim(C_NEW_HOMES) != '', N791_2, 0.0020851481));

N792_8 :=__common__( map(trim(C_RETIRED2) = ''      => -0.00010859683,
              ((real)c_retired2 < 138.5) => -0.010646506,
                                            -0.00010859683));

N792_7 :=__common__( map(((real)f_historical_count_d <= NULL) => 0.001943396,
              ((real)f_historical_count_d < 1.5)   => 0.011497206,
                                                      0.001943396));

N792_6 :=__common__( map(trim(C_HVAL_150K_P) = ''              => -0.0036826576,
              ((real)c_hval_150k_p < 16.0499992371) => N792_7,
                                                       -0.0036826576));

N792_5 :=__common__( map(((real)f_divaddrsuspidcountnew_i <= NULL) => N792_6,
              ((real)f_divaddrsuspidcountnew_i < 1.5)   => 6.1243902e-005,
                                                           N792_6));

N792_4 :=__common__( map(((real)f_curraddractivephonelist_d <= NULL) => -0.0028649788,
              ((real)f_curraddractivephonelist_d < 0.5)   => N792_5,
                                                             -0.0028649788));

N792_3 :=__common__( if(((real)c_pop_65_74_p < 13.75), N792_4, N792_8));

N792_2 :=__common__( if(trim(C_POP_65_74_P) != '', N792_3, -0.00048562308));

N792_1 :=__common__( if(((real)f_curraddractivephonelist_d > NULL), N792_2, 0.0010552714));

N793_8 :=__common__( map(trim(C_MED_AGE) = ''              => 0.0020323091,
              ((real)c_med_age < 37.1500015259) => 0.012488689,
                                                   0.0020323091));

N793_7 :=__common__( map(trim(C_HH4_P) = ''              => 0.0015413549,
              ((real)c_hh4_p < 10.1499996185) => N793_8,
                                                 0.0015413549));

N793_6 :=__common__( map(trim(C_BORN_USA) = ''     => N793_7,
              ((real)c_born_usa < 49.5) => -0.0066735175,
                                           N793_7));

N793_5 :=__common__( map(trim(C_CPIALL) = ''      => -0.00073162385,
              ((real)c_cpiall < 208.5) => N793_6,
                                          -0.00073162385));

N793_4 :=__common__( map(trim(C_HIGHINC) = ''              => 0.001279996,
              ((real)c_highinc < 2.65000009537) => -0.0041335164,
                                                   0.001279996));

N793_3 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N793_4, N793_5));

N793_2 :=__common__( if(((real)c_popover25 < 342.5), -0.0085035081, N793_3));

N793_1 :=__common__( if(trim(C_POPOVER25) != '', N793_2, -6.1643573e-005));

N794_8 :=__common__( map(trim(C_INC_25K_P) = ''              => -0.0014973826,
              ((real)c_inc_25k_p < 15.4499998093) => 0.0077015818,
                                                     -0.0014973826));

N794_7 :=__common__( map(trim(C_NO_TEENS) = ''     => N794_8,
              ((real)c_no_teens < 20.5) => 0.011358457,
                                           N794_8));

N794_6 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL)   => -0.0054108985,
              ((integer)f_liens_unrel_cj_total_amt_i < 2968) => N794_7,
                                                                -0.0054108985));

N794_5 :=__common__( map(((real)f_add_curr_mobility_index_n <= NULL)         => -0.0012147215,
              ((real)f_add_curr_mobility_index_n < 0.33561745286) => N794_6,
                                                                     -0.0012147215));

N794_4 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => 0.0090994059,
              ((real)f_add_curr_nhood_vac_pct_i < 0.370101094246) => N794_5,
                                                                     0.0090994059));

N794_3 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N794_4, 0.0058364078));

N794_2 :=__common__( if(((real)c_no_car < 164.5), -0.0009230736, N794_3));

N794_1 :=__common__( if(trim(C_NO_CAR) != '', N794_2, 0.00021837921));

N795_10 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => 0.005157455,
               ((real)r_c10_m_hdr_fs_d < 237.5) => -0.0041213436,
                                                   0.005157455));

N795_9 :=__common__( if(((real)f_rel_ageover30_count_d < 16.5), -0.0033042344, -0.01293718));

N795_8 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N795_9, -0.0002023571));

N795_7 :=__common__( map(trim(C_INC_35K_P) = ''              => N795_10,
              ((real)c_inc_35k_p < 12.5500001907) => N795_8,
                                                     N795_10));

N795_6 :=__common__( if(((real)c_incollege < 7.14999961853), N795_7, 0.0017047457));

N795_5 :=__common__( if(trim(C_INCOLLEGE) != '', N795_6, 0.0047075111));

N795_4 :=__common__( if(((real)c_food < 45.3499984741), 0.0014212558, -0.0026356302));

N795_3 :=__common__( if(trim(C_FOOD) != '', N795_4, 0.002394719));

N795_2 :=__common__( if(((real)f_vardobcount_i < 1.5), N795_3, N795_5));

N795_1 :=__common__( if(((real)f_vardobcount_i > NULL), N795_2, -0.0029896346));

N796_9 :=__common__( map(trim(C_UNEMPL) = ''      => 0.01433938,
              ((real)c_unempl < 165.5) => 0.0029418247,
                                          0.01433938));

N796_8 :=__common__( map(trim(C_POP_45_54_P) = ''              => -0.0024579154,
              ((real)c_pop_45_54_p < 12.0500001907) => 0.0050366315,
                                                       -0.0024579154));

N796_7 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => N796_8,
              (segment in ['SEARS FLS'])                                  => N796_9,
                                                                             N796_8));

N796_6 :=__common__( if(trim(C_POP_45_54_P) != '', N796_7, -0.0061149265));

N796_5 :=__common__( map(((real)f_adl_util_conv_n <= NULL) => -0.00053788567,
              ((real)f_adl_util_conv_n < 0.5)   => N796_6,
                                                   -0.00053788567));

N796_4 :=__common__( if(((integer)f_addrchangeecontrajindex_d < 0), -0.0062346051, -0.00042727737));

N796_3 :=__common__( if(((real)f_addrchangeecontrajindex_d > NULL), N796_4, -0.0012260684));

N796_2 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.0168725531548), N796_3, N796_5));

N796_1 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N796_2, 0.0081461249));

N797_10 :=__common__( map(((real)f_prevaddrlenofres_d <= NULL) => -0.00071410689,
               ((real)f_prevaddrlenofres_d < 23.5)  => 0.0091597982,
                                                       -0.00071410689));

N797_9 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => N797_10,
              ((real)r_c21_m_bureau_adl_fs_d < 148.5) => 0.013112527,
                                                         N797_10));

N797_8 :=__common__( if(((real)c_pop_18_24_p < 5.94999980927), -0.0041997289, N797_9));

N797_7 :=__common__( if(trim(C_POP_18_24_P) != '', N797_8, 0.012633128));

N797_6 :=__common__( if(((real)c_hval_125k_p < 38.75), -0.00050928686, 0.0073035842));

N797_5 :=__common__( if(trim(C_HVAL_125K_P) != '', N797_6, -0.0020500723));

N797_4 :=__common__( if(((real)f_srchfraudsrchcount_i < 20.5), N797_5, N797_7));

N797_3 :=__common__( if(((real)f_srchfraudsrchcount_i > NULL), N797_4, -0.0062198321));

N797_2 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i < 162.350006104), -0.0013792405, 0.0076864138));

N797_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N797_2, N797_3));

N798_8 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => 0.010224155,
              ((real)c_hist_addr_match_i < 2.5)   => 0.00043173959,
                                                     0.010224155));

N798_7 :=__common__( map(trim(C_RAPE) = ''       => -0.0023734513,
              ((integer)c_rape < 107) => N798_8,
                                         -0.0023734513));

N798_6 :=__common__( map(trim(C_FAMOTF18_P) = ''      => -0.0078796516,
              ((real)c_famotf18_p < 17.25) => 0.00039191617,
                                              -0.0078796516));

N798_5 :=__common__( if(((real)c_inc_50k_p < 14.3500003815), N798_6, N798_7));

N798_4 :=__common__( if(trim(C_INC_50K_P) != '', N798_5, 0.014451769));

N798_3 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => 0.0010001575,
              ((real)f_mos_inq_banko_om_lseen_d < 14.5)  => N798_4,
                                                            0.0010001575));

N798_2 :=__common__( if(((real)r_e55_college_ind_d < 0.5), N798_3, -0.0049524886));

N798_1 :=__common__( if(((real)r_e55_college_ind_d > NULL), N798_2, -0.006011232));

N799_8 :=__common__( if(((real)r_i60_inq_hiriskcred_count12_i < 5.5), -0.00056034065, -0.0095624183));

N799_7 :=__common__( if(((real)r_i60_inq_hiriskcred_count12_i > NULL), N799_8, -0.003487698));

N799_6 :=__common__( map(trim(C_LOW_HVAL) = ''              => N799_7,
              ((real)c_low_hval < 9.94999980927) => 0.0014541218,
                                                    N799_7));

N799_5 :=__common__( map(trim(C_OWNOCC_P) = ''              => N799_6,
              ((real)c_ownocc_p < 22.0499992371) => -0.0032900653,
                                                    N799_6));

N799_4 :=__common__( map(trim(C_RENTOCC_P) = ''              => 0.0024361471,
              ((real)c_rentocc_p < 54.1500015259) => 0.012627947,
                                                     0.0024361471));

N799_3 :=__common__( map(trim(C_RETAIL) = ''              => -0.0025784825,
              ((real)c_retail < 7.85000038147) => N799_4,
                                                  -0.0025784825));

N799_2 :=__common__( if(((real)c_inc_75k_p < 6.25), N799_3, N799_5));

N799_1 :=__common__( if(trim(C_INC_75K_P) != '', N799_2, 0.00070700071));

ENDMACRO;