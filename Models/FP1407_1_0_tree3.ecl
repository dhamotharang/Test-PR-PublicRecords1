EXPORT FP1407_1_0_tree3 := MACRO

N800_9 :=__common__( if(((real)c_ab_av_edu < 126.5), 0.0015865522, 0.01053069));

N800_8 :=__common__( if(trim(C_AB_AV_EDU) != '', N800_9, 0.0094876898));

N800_7 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => -0.0043195126,
              ((integer)c_hist_addr_match_i < 70) => N800_8,
                                                     -0.0043195126));

N800_6 :=__common__( map(((real)c_dist_input_to_prev_addr_i <= NULL) => N800_7,
              ((real)c_dist_input_to_prev_addr_i < 1.5)   => -0.0034487221,
                                                             N800_7));

N800_5 :=__common__( if(((real)f_liens_unrel_o_total_amt_i < 302.5), N800_6, -0.0098314922));

N800_4 :=__common__( if(((real)f_liens_unrel_o_total_amt_i > NULL), N800_5, -0.0021656762));

N800_3 :=__common__( map(trim(C_FOOD) = ''              => 0.00012259648,
              ((real)c_food < 2.34999990463) => 0.0034737456,
                                                0.00012259648));

N800_2 :=__common__( map(((real)f_prevaddrlenofres_d <= NULL) => N800_3,
              ((real)f_prevaddrlenofres_d < 0.5)   => -0.0067532919,
                                                      N800_3));

N800_1 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N800_2, N800_4));

N801_8 :=__common__( map(trim(C_ASIAN_LANG) = ''      => -0.0075176659,
              ((real)c_asian_lang < 162.5) => 0.0027418176,
                                              -0.0075176659));

N801_7 :=__common__( if(((real)r_c13_curr_addr_lres_d < 14.5), -0.0092537458, -0.0025820143));

N801_6 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N801_7, -0.015141837));

N801_5 :=__common__( map(trim(C_HVAL_250K_P) = ''     => N801_8,
              ((real)c_hval_250k_p < 2.25) => N801_6,
                                              N801_8));

N801_4 :=__common__( map(trim(C_LOW_HVAL) = ''              => -0.0038900107,
              ((real)c_low_hval < 14.6499996185) => 0.00022368773,
                                                    -0.0038900107));

N801_3 :=__common__( map(trim(C_HVAL_60K_P) = ''              => 0.0024683263,
              ((real)c_hval_60k_p < 12.4499998093) => N801_4,
                                                      0.0024683263));

N801_2 :=__common__( if(((real)c_hh3_p < 21.9500007629), N801_3, N801_5));

N801_1 :=__common__( if(trim(C_HH3_P) != '', N801_2, -0.0014481683));

N802_7 :=__common__( map(trim(C_OLDHOUSE) = ''              => 0.00043589633,
              ((real)c_oldhouse < 230.050003052) => 0.011067451,
                                                    0.00043589633));

N802_6 :=__common__( map(trim(C_MANY_CARS) = ''     => -0.0082874921,
              ((real)c_many_cars < 44.5) => 0.0067646097,
                                            -0.0082874921));

N802_5 :=__common__( map((fp_segment in ['2 NAS 479', '4 Bureau Only', '6 Recent Activity', '7 Other']) => N802_6,
              (fp_segment in ['1 SSN Prob', '3 New DID', '5 Derog'])                         => N802_7,
                                                                                                N802_6));

N802_4 :=__common__( map(trim(C_INC_25K_P) = ''              => N802_5,
              ((real)c_inc_25k_p < 22.4500007629) => -0.00056312936,
                                                     N802_5));

N802_3 :=__common__( map(trim(C_HOUSINGCPI) = ''       => 0.0056650027,
              ((real)c_housingcpi < 241.75) => N802_4,
                                               0.0056650027));

N802_2 :=__common__( if(((real)c_inc_125k_p < 15.75), N802_3, -0.006932707));

N802_1 :=__common__( if(trim(C_INC_125K_P) != '', N802_2, -0.00045624978));

N803_9 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => 0.0018808143,
              ((real)r_c10_m_hdr_fs_d < 165.5) => -0.0050473253,
                                                  0.0018808143));

N803_8 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => N803_9,
              ((real)r_c13_max_lres_d < 71.5)  => -0.0054779049,
                                                  N803_9));

N803_7 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => 0.0040909748,
              ((real)f_srchaddrsrchcount_i < 20.5)  => N803_8,
                                                       0.0040909748));

N803_6 :=__common__( if(((integer)f_prevaddrmedianvalue_d < 287922), N803_7, 0.0071699324));

N803_5 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N803_6, 0.0041291238));

N803_4 :=__common__( map(trim(C_HVAL_1001K_P) = ''                => -0.0076373007,
              ((real)c_hval_1001k_p < 0.0500000007451) => -0.00037466344,
                                                          -0.0076373007));

N803_3 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => 0.0023280033,
              ((real)f_inq_per_ssn_i < 3.5)   => N803_4,
                                                 0.0023280033));

N803_2 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N803_3, N803_5));

N803_1 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N803_2, 0.0014060855));

N804_9 :=__common__( if(((integer)c_robbery < 134), -0.013829403, 0.0023670273));

N804_8 :=__common__( if(trim(C_ROBBERY) != '', N804_9, -0.019806862));

N804_7 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => 0.0078117455,
              ((real)f_mos_inq_banko_cm_fseen_d < 61.5)  => -0.0036769076,
                                                            0.0078117455));

N804_6 :=__common__( if(((real)c_med_yearblt < 1988.5), -0.0014281831, N804_7));

N804_5 :=__common__( if(trim(C_MED_YEARBLT) != '', N804_6, -0.0011028364));

N804_4 :=__common__( map(((real)f_corraddrnamecount_d <= NULL) => 0.0016524111,
              ((real)f_corraddrnamecount_d < 4.5)   => N804_5,
                                                       0.0016524111));

N804_3 :=__common__( map(((real)c_comb_age_d <= NULL) => N804_8,
              ((real)c_comb_age_d < 57.5)  => N804_4,
                                              N804_8));

N804_2 :=__common__( if(((real)f_rel_criminal_count_i < 21.5), N804_3, -0.0074752011));

N804_1 :=__common__( if(((real)f_rel_criminal_count_i > NULL), N804_2, 0.011106688));

N805_8 :=__common__( map((fp_segment in ['6 Recent Activity', '7 Other'])                                     => -0.010879797,
              (fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '4 Bureau Only', '5 Derog']) => 0.0042334106,
                                                                                                      0.0042334106));

N805_7 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => N805_8,
              ((real)r_c13_avg_lres_d < 46.5)  => -0.009592639,
                                                  N805_8));

N805_6 :=__common__( map(trim(C_RELIG_INDX) = ''      => 0.0092876342,
              ((real)c_relig_indx < 115.5) => -0.0014572463,
                                              0.0092876342));

N805_5 :=__common__( if(((real)c_pop_6_11_p < 8.35000038147), N805_6, N805_7));

N805_4 :=__common__( if(trim(C_POP_6_11_P) != '', N805_5, -0.0080482103));

N805_3 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => N805_4,
              ((real)r_c21_m_bureau_adl_fs_d < 156.5) => 0.0081118077,
                                                         N805_4));

N805_2 :=__common__( if(((real)f_rel_felony_count_i < 3.5), -0.00023820189, N805_3));

N805_1 :=__common__( if(((real)f_rel_felony_count_i > NULL), N805_2, 0.0071605733));

N806_9 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => 0.010895114,
              ((real)f_add_input_nhood_vac_pct_i < 0.0696477070451) => -0.00035389884,
                                                                       0.010895114));

N806_8 :=__common__( map(trim(C_EASIQLIFE) = ''     => 0.00088346894,
              ((real)c_easiqlife < 83.5) => -0.0018434272,
                                            0.00088346894));

N806_7 :=__common__( map(trim(C_HH7P_P) = ''              => 0.0059340782,
              ((real)c_hh7p_p < 9.94999980927) => N806_8,
                                                  0.0059340782));

N806_6 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N806_7, -0.005156121));

N806_5 :=__common__( map(((real)f_liens_unrel_ot_total_amt_i <= NULL)   => -0.0080505794,
              ((integer)f_liens_unrel_ot_total_amt_i < 2054) => N806_6,
                                                                -0.0080505794));

N806_4 :=__common__( if(((real)f_rel_felony_count_i < 6.5), N806_5, N806_9));

N806_3 :=__common__( if(((real)f_rel_felony_count_i > NULL), N806_4, -0.0034108124));

N806_2 :=__common__( if(((real)c_unemp < 16.6500015259), N806_3, -0.0069542803));

N806_1 :=__common__( if(trim(C_UNEMP) != '', N806_2, 2.6054948e-005));

N807_9 :=__common__( if(((real)c_rnt1500_p < 4.05000019073), -0.0019662247, 0.0035292264));

N807_8 :=__common__( if(trim(C_RNT1500_P) != '', N807_9, -0.0075734233));

N807_7 :=__common__( map(((real)c_addr_lres_12mo_ct_i <= NULL) => N807_8,
              ((real)c_addr_lres_12mo_ct_i < 0.5)   => 0.00418396,
                                                       N807_8));

N807_6 :=__common__( map(trim(C_LOWRENT) = ''      => 0.010074238,
              ((real)c_lowrent < 16.75) => -0.0015156784,
                                           0.010074238));

N807_5 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => N807_6,
              ((real)f_mos_inq_banko_om_lseen_d < 30.5)  => 5.847275e-005,
                                                            N807_6));

N807_4 :=__common__( if(((real)c_fammar_p < 86.75), N807_5, 0.010638147));

N807_3 :=__common__( if(trim(C_FAMMAR_P) != '', N807_4, 0.0036630524));

N807_2 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 34.5), N807_3, N807_7));

N807_1 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N807_2, 0.00057352785));

N808_8 :=__common__( map(trim(C_HH2_P) = ''              => -0.0029306968,
              ((real)c_hh2_p < 38.5499992371) => 0.0017660483,
                                                 -0.0029306968));

N808_7 :=__common__( map(trim(C_RENTOCC_P) = ''      => -0.0027579704,
              ((real)c_rentocc_p < 55.75) => N808_8,
                                             -0.0027579704));

N808_6 :=__common__( map(trim(C_POP_18_24_P) = ''              => 0.0084975532,
              ((real)c_pop_18_24_p < 24.3499984741) => N808_7,
                                                       0.0084975532));

N808_5 :=__common__( map(trim(C_OCCUNIT_P) = ''      => -0.0035147016,
              ((real)c_occunit_p < 93.75) => N808_6,
                                             -0.0035147016));

N808_4 :=__common__( if(((real)r_c13_avg_lres_d < 77.5), 0.0044527996, -0.0011931764));

N808_3 :=__common__( if(((real)r_c13_avg_lres_d > NULL), N808_4, 0.0029294459));

N808_2 :=__common__( if(((real)c_rnt750_p < 5.75), N808_3, N808_5));

N808_1 :=__common__( if(trim(C_RNT750_P) != '', N808_2, 0.0043906839));

N809_10 :=__common__( if(((real)c_finance < 0.0500000007451), 0.0014762687, -0.0011601367));

N809_9 :=__common__( if(trim(C_FINANCE) != '', N809_10, -0.0024341218));

N809_8 :=__common__( if(((real)c_hh4_p < 10.3500003815), 0.0062005368, -0.0017481857));

N809_7 :=__common__( if(trim(C_HH4_P) != '', N809_8, -0.0085916031));

N809_6 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)    => -0.0016173229,
              ((integer)f_curraddrmedianincome_d < 44949) => -0.0085656679,
                                                             -0.0016173229));

N809_5 :=__common__( if(((real)c_assault < 180.5), N809_6, 0.00413865));

N809_4 :=__common__( if(trim(C_ASSAULT) != '', N809_5, -0.029407614));

N809_3 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => N809_7,
              ((real)c_dist_best_to_prev_addr_i < 4.5)   => N809_4,
                                                            N809_7));

N809_2 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.0077449165,
              ((real)f_inq_other_count24_i < 3.5)   => N809_3,
                                                       0.0077449165));

N809_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N809_2, N809_9));

N810_8 :=__common__( map(trim(C_FOOD) = ''              => -0.00077741931,
              ((real)c_food < 8.94999980927) => -0.01216058,
                                                -0.00077741931));

N810_7 :=__common__( map(trim(C_RETAIL) = ''              => -0.0047338,
              ((real)c_retail < 17.1500015259) => 0.0021082082,
                                                  -0.0047338));

N810_6 :=__common__( map(trim(C_MED_HVAL) = ''         => N810_8,
              ((real)c_med_hval < 130216.5) => N810_7,
                                               N810_8));

N810_5 :=__common__( if(((integer)c_assault < 37), 0.0075007346, N810_6));

N810_4 :=__common__( if(trim(C_ASSAULT) != '', N810_5, 0.0014257429));

N810_3 :=__common__( map(trim(C_LOW_ED) = ''              => 0.0045926298,
              ((real)c_low_ed < 77.9499969482) => -0.0021777356,
                                                  0.0045926298));

N810_2 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => N810_3,
              ((real)f_add_curr_nhood_vac_pct_i < 0.0637345984578) => 0.0014583686,
                                                                      N810_3));

N810_1 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N810_2, N810_4));

N811_9 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => 0.004371885,
              ((real)r_d32_mos_since_crim_ls_d < 51.5)  => 0.012068816,
                                                           0.004371885));

N811_8 :=__common__( map(trim(C_INC_25K_P) = ''              => 0.0029839543,
              ((real)c_inc_25k_p < 10.0500001907) => -0.0063762583,
                                                     0.0029839543));

N811_7 :=__common__( map(trim(C_MORT_INDX) = ''     => N811_9,
              ((real)c_mort_indx < 72.5) => N811_8,
                                            N811_9));

N811_6 :=__common__( if(((real)f_mos_liens_unrel_sc_fseen_d < 145.5), -0.0036290564, N811_7));

N811_5 :=__common__( if(((real)f_mos_liens_unrel_sc_fseen_d > NULL), N811_6, -0.0012229156));

N811_4 :=__common__( if(((real)c_inc_15k_p < 4.75), -0.0069017366, N811_5));

N811_3 :=__common__( if(trim(C_INC_15K_P) != '', N811_4, -0.0093796979));

N811_2 :=__common__( if(((real)r_l77_apartment_i < 0.5), -0.0005551005, N811_3));

N811_1 :=__common__( if(((real)r_l77_apartment_i > NULL), N811_2, -0.034115706));

N812_9 :=__common__( map(((real)r_d33_eviction_count_i <= NULL) => 0.013300768,
              ((real)r_d33_eviction_count_i < 1.5)   => 0.0037047643,
                                                        0.013300768));

N812_8 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.0012452212,
              ((real)c_easiqlife < 118.5) => N812_9,
                                             0.0012452212));

N812_7 :=__common__( map(trim(C_RETAIL) = ''              => -0.0088373115,
              ((real)c_retail < 11.3500003815) => 0.0016458021,
                                                  -0.0088373115));

N812_6 :=__common__( if(((real)c_span_lang < 51.5), N812_7, N812_8));

N812_5 :=__common__( if(trim(C_SPAN_LANG) != '', N812_6, 0.0058702873));

N812_4 :=__common__( if(((real)c_hval_80k_p < 15.3500003815), -0.0013988267, 0.001577467));

N812_3 :=__common__( if(trim(C_HVAL_80K_P) != '', N812_4, -0.0038532891));

N812_2 :=__common__( if(((real)f_varmsrcssncount_i < 1.5), N812_3, N812_5));

N812_1 :=__common__( if(((real)f_varmsrcssncount_i > NULL), N812_2, 0.0034069461));

N813_8 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL)  => 0.0036240362,
              ((integer)f_curraddrcartheftindex_i < 182) => -0.0014978985,
                                                            0.0036240362));

N813_7 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL) => -0.0061778717,
              ((real)r_a50_pb_total_dollars_d < 49.5)  => 0.0032147493,
                                                          -0.0061778717));

N813_6 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => N813_8,
              ((real)f_mos_inq_banko_om_lseen_d < 17.5)  => N813_7,
                                                            N813_8));

N813_5 :=__common__( if(((real)c_hval_80k_p < 7.94999980927), 0.00071192057, N813_6));

N813_4 :=__common__( if(trim(C_HVAL_80K_P) != '', N813_5, 0.0042869352));

N813_3 :=__common__( map(((real)r_i60_inq_count12_i <= NULL) => 0.0073653163,
              ((real)r_i60_inq_count12_i < 17.5)  => N813_4,
                                                     0.0073653163));

N813_2 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 10.5), 0.0070416326, N813_3));

N813_1 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N813_2, -0.0076245973));

N814_11 :=__common__( if(((real)c_preschl < 137.5), -0.0034214998, 0.0011166527));

N814_10 :=__common__( if(trim(C_PRESCHL) != '', N814_11, 0.0060959518));

N814_9 :=__common__( if(((real)f_rel_under500miles_cnt_d > NULL), N814_10, 0.0037175076));

N814_8 :=__common__( map(trim(C_BORN_USA) = ''      => 0.0055648395,
              ((real)c_born_usa < 183.5) => -0.0016795523,
                                            0.0055648395));

N814_7 :=__common__( map(trim(C_HVAL_300K_P) = ''              => 0.0084362795,
              ((real)c_hval_300k_p < 3.04999995232) => N814_8,
                                                       0.0084362795));

N814_6 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)    => N814_7,
              ((integer)f_prevaddrmedianincome_d < 14175) => 0.011101551,
                                                             N814_7));

N814_5 :=__common__( if(((real)c_rnt250_p < 21.75), N814_6, -0.0063339795));

N814_4 :=__common__( if(trim(C_RNT250_P) != '', N814_5, 0.0036123698));

N814_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N814_4, 0.0011848081));

N814_2 :=__common__( if(((integer)f_curraddrmedianvalue_d < 136033), N814_3, N814_9));

N814_1 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N814_2, 0.00016966258));

N815_8 :=__common__( map(trim(C_RETAIL) = ''      => 0.011209008,
              ((real)c_retail < 13.75) => 0.0009314389,
                                          0.011209008));

N815_7 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 127.5), N815_8, -0.00011434725));

N815_6 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N815_7, -0.004184792));

N815_5 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)   => -0.0057892417,
              ((real)f_curraddrmedianvalue_d < 55302.5) => 0.0030869374,
                                                           -0.0057892417));

N815_4 :=__common__( map(trim(C_HH3_P) = ''      => -0.0087508095,
              ((real)c_hh3_p < 17.75) => N815_5,
                                         -0.0087508095));

N815_3 :=__common__( map(trim(C_MED_HVAL) = ''         => N815_6,
              ((integer)c_med_hval < 57550) => N815_4,
                                               N815_6));

N815_2 :=__common__( if(((real)c_hval_20k_p < 28.25), N815_3, 0.0062412954));

N815_1 :=__common__( if(trim(C_HVAL_20K_P) != '', N815_2, -0.0019773679));

N816_8 :=__common__( map(((real)f_rel_criminal_count_i <= NULL) => -0.0051471953,
              ((real)f_rel_criminal_count_i < 19.5)  => 0.00046154457,
                                                        -0.0051471953));

N816_7 :=__common__( if(((real)f_mos_liens_rel_cj_fseen_d < 53.5), -0.0067358663, N816_8));

N816_6 :=__common__( if(((real)f_mos_liens_rel_cj_fseen_d > NULL), N816_7, 0.0086017297));

N816_5 :=__common__( map(trim(C_CONSTRUCTION) = ''              => -0.0049232384,
              ((real)c_construction < 2.84999990463) => 0.0064493257,
                                                        -0.0049232384));

N816_4 :=__common__( map(trim(C_HVAL_125K_P) = ''              => 0.0098648942,
              ((real)c_hval_125k_p < 10.0500001907) => N816_5,
                                                       0.0098648942));

N816_3 :=__common__( map(trim(C_HHSIZE) = ''              => N816_6,
              ((real)c_hhsize < 2.05499982834) => N816_4,
                                                  N816_6));

N816_2 :=__common__( if(((real)c_white_col < 52.6500015259), N816_3, -0.0073339633));

N816_1 :=__common__( if(trim(C_WHITE_COL) != '', N816_2, 0.00050302585));

N817_8 :=__common__( map(trim(C_BURGLARY) = ''      => -0.010334926,
              ((real)c_burglary < 106.5) => -0.0013443233,
                                            -0.010334926));

N817_7 :=__common__( map(((real)f_addrchangeecontrajindex_d <= NULL) => -0.0011666391,
              ((integer)f_addrchangeecontrajindex_d < 0)  => N817_8,
                                                             -0.0011666391));

N817_6 :=__common__( map(trim(C_INC_35K_P) = ''      => 0.0057551819,
              ((real)c_inc_35k_p < 19.75) => N817_7,
                                             0.0057551819));

N817_5 :=__common__( map(trim(C_BEL_EDU) = ''      => 0.00060423451,
              ((real)c_bel_edu < 107.5) => N817_6,
                                           0.00060423451));

N817_4 :=__common__( if(((real)c_pop_25_34_p < 3.04999995232), -0.0094718794, N817_5));

N817_3 :=__common__( if(trim(C_POP_25_34_P) != '', N817_4, -0.0012168513));

N817_2 :=__common__( if(((real)f_rel_ageover40_count_d < 16.5), N817_3, -0.010758211));

N817_1 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N817_2, 0.0021899172));

N818_8 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => 0.0039956402,
              ((real)f_mos_inq_banko_cm_lseen_d < 56.5)  => 0.00019902635,
                                                            0.0039956402));

N818_7 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => -0.0058528633,
              ((real)r_d32_criminal_count_i < 15.5)  => N818_8,
                                                        -0.0058528633));

N818_6 :=__common__( map(trim(C_RNT1250_P) = ''              => 0.0053772947,
              ((real)c_rnt1250_p < 8.64999961853) => -0.0013243233,
                                                     0.0053772947));

N818_5 :=__common__( map(trim(C_HVAL_200K_P) = ''              => N818_6,
              ((real)c_hval_200k_p < 3.65000009537) => -0.0033137381,
                                                       N818_6));

N818_4 :=__common__( map(((real)c_mos_since_impulse_ls_d <= NULL) => N818_5,
              ((real)c_mos_since_impulse_ls_d < 37.5)  => 0.0064899145,
                                                          N818_5));

N818_3 :=__common__( if(trim(C_HVAL_200K_P) != '', N818_4, 0.0056341465));

N818_2 :=__common__( if(((real)f_m_bureau_adl_fs_all_d < 167.5), N818_3, N818_7));

N818_1 :=__common__( if(((real)f_m_bureau_adl_fs_all_d > NULL), N818_2, -7.0273876e-005));

N819_9 :=__common__( map(trim(C_POP_75_84_P) = ''              => 0.014601503,
              ((real)c_pop_75_84_p < 3.95000004768) => 0.0018352531,
                                                       0.014601503));

N819_8 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.150788158178), N819_9, -0.0011871427));

N819_7 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N819_8, 0.0023113285));

N819_6 :=__common__( map(trim(C_AMUS_INDX) = ''      => -0.0068659157,
              ((real)c_amus_indx < 116.5) => 0.0029640707,
                                             -0.0068659157));

N819_5 :=__common__( map(trim(C_PRESCHL) = ''     => -0.0011021371,
              ((real)c_preschl < 76.5) => N819_6,
                                          -0.0011021371));

N819_4 :=__common__( if(((integer)f_liens_unrel_sc_total_amt_i < 5615), N819_5, 0.0070417634));

N819_3 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i > NULL), N819_4, -2.7992966e-005));

N819_2 :=__common__( if(((real)c_retail < 32.1500015259), N819_3, N819_7));

N819_1 :=__common__( if(trim(C_RETAIL) != '', N819_2, -0.0024701458));

N820_9 :=__common__( map(trim(C_LOW_ED) = ''              => -0.00010361675,
              ((real)c_low_ed < 47.9500007629) => -0.0077919984,
                                                  -0.00010361675));

N820_8 :=__common__( if(((real)f_addrchangeincomediff_d < 26153.5), N820_9, 0.0064450642));

N820_7 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N820_8, -0.0041037572));

N820_6 :=__common__( map(trim(C_NO_TEENS) = ''     => 0.00013833562,
              ((real)c_no_teens < 46.5) => -0.0041616432,
                                           0.00013833562));

N820_5 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.339573860168), 0.0014950979, N820_6));

N820_4 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N820_5, -0.00058602481));

N820_3 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)         => 0.0081408848,
              ((real)f_add_curr_nhood_vac_pct_i < 0.63786303997) => N820_4,
                                                                    0.0081408848));

N820_2 :=__common__( if(((real)c_rich_fam < 134.5), N820_3, N820_7));

N820_1 :=__common__( if(trim(C_RICH_FAM) != '', N820_2, -0.0015275192));

N821_8 :=__common__( map(trim(C_HH3_P) = ''              => -0.0054551536,
              ((real)c_hh3_p < 15.6499996185) => 0.0041669615,
                                                 -0.0054551536));

N821_7 :=__common__( map(trim(C_MORT_INDX) = ''     => N821_8,
              ((real)c_mort_indx < 62.5) => -0.012487614,
                                            N821_8));

N821_6 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => -0.0016096821,
              ((real)f_inq_adls_per_phone_i < 0.5)   => 0.0014115873,
                                                        -0.0016096821));

N821_5 :=__common__( if(((real)f_rel_criminal_count_i < 13.5), N821_6, -0.0037404668));

N821_4 :=__common__( if(((real)f_rel_criminal_count_i > NULL), N821_5, 0.0026577842));

N821_3 :=__common__( map(trim(C_INC_35K_P) = ''              => 0.006053533,
              ((real)c_inc_35k_p < 23.4500007629) => N821_4,
                                                     0.006053533));

N821_2 :=__common__( if(((real)c_low_hval < 57.1500015259), N821_3, N821_7));

N821_1 :=__common__( if(trim(C_LOW_HVAL) != '', N821_2, 0.00067859069));

N822_8 :=__common__( map(trim(C_RELIG_INDX) = ''     => 0.0059072281,
              ((real)c_relig_indx < 83.5) => -0.00028848084,
                                             0.0059072281));

N822_7 :=__common__( map(trim(C_RNT250_P) = ''              => -0.004126317,
              ((real)c_rnt250_p < 22.5499992371) => N822_8,
                                                    -0.004126317));

N822_6 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d < 7.5), -0.0049755194, N822_7));

N822_5 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d > NULL), N822_6, 0.003736577));

N822_4 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => 0.008705383,
              ((real)f_inq_adls_per_phone_i < 1.5)   => N822_5,
                                                        0.008705383));

N822_3 :=__common__( map(((real)r_l77_apartment_i <= NULL) => 0.0062161757,
              ((real)r_l77_apartment_i < 0.5)   => N822_4,
                                                   0.0062161757));

N822_2 :=__common__( if(((real)c_business < 6.5), N822_3, -0.00062318151));

N822_1 :=__common__( if(trim(C_BUSINESS) != '', N822_2, 0.0018484326));

N823_9 :=__common__( map(((real)f_componentcharrisktype_i <= NULL) => -9.1038005e-008,
              ((real)f_componentcharrisktype_i < 3.5)   => -0.0062839174,
                                                           -9.1038005e-008));

N823_8 :=__common__( map(trim(C_POP_35_44_P) = ''              => -0.0024454759,
              ((real)c_pop_35_44_p < 8.85000038147) => 0.0062299707,
                                                       -0.0024454759));

N823_7 :=__common__( map(trim(C_RAPE) = ''     => N823_8,
              ((real)c_rape < 57.5) => 0.0085174666,
                                       N823_8));

N823_6 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.007842774,
              ((real)r_d32_criminal_count_i < 1.5)   => N823_7,
                                                        0.007842774));

N823_5 :=__common__( map(((real)c_unique_addr_count_i <= NULL) => N823_9,
              ((real)c_unique_addr_count_i < 5.5)   => N823_6,
                                                       N823_9));

N823_4 :=__common__( if(((real)f_rel_incomeover25_count_d > NULL), N823_5, -0.001828152));

N823_3 :=__common__( if(((real)c_med_hval < 46235.5), -0.0060459813, N823_4));

N823_2 :=__common__( if(trim(C_MED_HVAL) != '', N823_3, 0.0012300974));

N823_1 :=__common__( if(((real)r_pb_order_freq_d > NULL), 0.00045398611, N823_2));

N824_9 :=__common__( map(trim(C_HIGH_ED) = ''              => 0.005057583,
              ((real)c_high_ed < 22.9500007629) => -0.0067003118,
                                                   0.005057583));

N824_8 :=__common__( if(((real)c_famotf18_p < 11.6499996185), N824_9, 0.0041883247));

N824_7 :=__common__( if(trim(C_FAMOTF18_P) != '', N824_8, 0.004379653));

N824_6 :=__common__( map(((real)f_mos_acc_lseen_d <= NULL) => N824_7,
              ((real)f_mos_acc_lseen_d < 116.5) => -0.0040767851,
                                                   N824_7));

N824_5 :=__common__( if(((real)c_rich_fam < 123.5), -0.0019425471, -0.011170166));

N824_4 :=__common__( if(trim(C_RICH_FAM) != '', N824_5, -0.0094221492));

N824_3 :=__common__( map(((real)r_c20_email_count_i <= NULL) => N824_4,
              ((real)r_c20_email_count_i < 5.5)   => -0.00022451057,
                                                     N824_4));

N824_2 :=__common__( if(((real)c_hist_addr_match_i < 6.5), N824_3, N824_6));

N824_1 :=__common__( if(((real)c_hist_addr_match_i > NULL), N824_2, 5.4157845e-005));

N825_8 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.0071113618,
              ((real)r_c14_addrs_10yr_i < 5.5)   => 0.00016449995,
                                                    0.0071113618));

N825_7 :=__common__( map(trim(C_FAMILIES) = ''      => -0.0098718611,
              ((real)c_families < 596.5) => 0.0015489982,
                                            -0.0098718611));

N825_6 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => N825_7,
              ((real)f_mos_inq_banko_om_fseen_d < 33.5)  => 0.0050743152,
                                                            N825_7));

N825_5 :=__common__( map(trim(C_POP_18_24_P) = ''              => N825_6,
              ((real)c_pop_18_24_p < 11.9499998093) => -0.0010216446,
                                                       N825_6));

N825_4 :=__common__( if(((real)c_bel_edu < 183.5), N825_5, N825_8));

N825_3 :=__common__( if(trim(C_BEL_EDU) != '', N825_4, -0.0050043903));

N825_2 :=__common__( if(((real)f_util_adl_count_n < 14.5), N825_3, 0.007432507));

N825_1 :=__common__( if(((real)f_util_adl_count_n > NULL), N825_2, 0.001888293));

N826_8 :=__common__( map(((real)r_i60_inq_banking_count12_i <= NULL) => -0.0079409073,
              ((real)r_i60_inq_banking_count12_i < 1.5)   => 0.0016491665,
                                                             -0.0079409073));

N826_7 :=__common__( map(trim(C_HVAL_60K_P) = ''              => 0.011207539,
              ((real)c_hval_60k_p < 30.0499992371) => N826_8,
                                                      0.011207539));

N826_6 :=__common__( map(trim(C_MED_RENT) = ''      => N826_7,
              ((real)c_med_rent < 440.5) => -0.0012624749,
                                            N826_7));

N826_5 :=__common__( if(((real)f_curraddrcartheftindex_i < 53.5), -0.0028023149, N826_6));

N826_4 :=__common__( if(((real)f_curraddrcartheftindex_i > NULL), N826_5, -0.0087585855));

N826_3 :=__common__( map(((real)r_l78_no_phone_at_addr_vel_i <= NULL) => 0.0043242063,
              ((real)r_l78_no_phone_at_addr_vel_i < 0.5)   => -0.0057847306,
                                                              0.0043242063));

N826_2 :=__common__( if(((real)c_blue_empl < 33.5), N826_3, N826_4));

N826_1 :=__common__( if(trim(C_BLUE_EMPL) != '', N826_2, 0.0035561876));

N827_9 :=__common__( if(((real)r_l80_inp_avm_autoval_d < 12589.5), 0.008103638, -0.00022114316));

N827_8 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N827_9, 0.00082908262));

N827_7 :=__common__( if(((integer)r_i61_inq_collection_recency_d < 549), -0.0012466942, 0.0066454136));

N827_6 :=__common__( if(((real)r_i61_inq_collection_recency_d > NULL), N827_7, 0.0023024765));

N827_5 :=__common__( map(trim(C_OLD_HOMES) = ''      => -0.011402106,
              ((real)c_old_homes < 101.5) => 0.0011725231,
                                             -0.011402106));

N827_4 :=__common__( map(trim(C_LARCENY) = ''      => N827_6,
              ((real)c_larceny < 145.5) => N827_5,
                                           N827_6));

N827_3 :=__common__( map(trim(C_BUSINESS) = ''    => -0.0093993569,
              ((real)c_business < 7.5) => N827_4,
                                          -0.0093993569));

N827_2 :=__common__( if(((real)c_pop00 < 864.5), N827_3, N827_8));

N827_1 :=__common__( if(trim(C_POP00) != '', N827_2, 0.0048408561));

N828_8 :=__common__( map(trim(C_MED_AGE) = ''              => -0.01342608,
              ((real)c_med_age < 31.3499984741) => -0.00069357056,
                                                   -0.01342608));

N828_7 :=__common__( map(trim(C_NO_CAR) = ''      => -0.00040044107,
              ((real)c_no_car < 123.5) => 0.0083882951,
                                          -0.00040044107));

N828_6 :=__common__( map(trim(C_FEMDIV_P) = ''              => -0.0092650105,
              ((real)c_femdiv_p < 8.55000019073) => -0.0011787144,
                                                    -0.0092650105));

N828_5 :=__common__( map(trim(C_RNT750_P) = ''      => N828_7,
              ((real)c_rnt750_p < 29.75) => N828_6,
                                            N828_7));

N828_4 :=__common__( if(((real)f_srchvelocityrisktype_i < 7.5), N828_5, N828_8));

N828_3 :=__common__( if(((real)f_srchvelocityrisktype_i > NULL), N828_4, 0.0047884711));

N828_2 :=__common__( if(((real)c_fammar_p < 48.9500007629), N828_3, 0.00062495101));

N828_1 :=__common__( if(trim(C_FAMMAR_P) != '', N828_2, 0.00099634927));

N829_8 :=__common__( map(trim(C_MANY_CARS) = ''     => -0.010972955,
              ((real)c_many_cars < 73.5) => -0.0019333595,
                                            -0.010972955));

N829_7 :=__common__( if(((real)c_employees < 32.5), N829_8, -3.0361431e-005));

N829_6 :=__common__( if(trim(C_EMPLOYEES) != '', N829_7, -0.0024685746));

N829_5 :=__common__( map(trim(C_TRANSPORT) = ''              => 0.0061940777,
              ((real)c_transport < 5.64999961853) => -0.0037473096,
                                                     0.0061940777));

N829_4 :=__common__( map(trim(C_SERV_EMPL) = ''     => 0.0068647639,
              ((real)c_serv_empl < 68.5) => -0.0021133681,
                                            0.0068647639));

N829_3 :=__common__( map(trim(C_NEWHOUSE) = ''              => N829_4,
              ((real)c_newhouse < 34.5499992371) => 0.00061001658,
                                                    N829_4));

N829_2 :=__common__( if(((integer)f_addrchangeincomediff_d < 13883), N829_3, N829_5));

N829_1 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N829_2, N829_6));

N830_10 :=__common__( if(((real)r_f03_input_add_not_most_rec_i < 0.5), -0.00016121377, 0.0048560414));

N830_9 :=__common__( if(((real)r_f03_input_add_not_most_rec_i > NULL), N830_10, -0.039673384));

N830_8 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 32.5), N830_9, -0.0008667197));

N830_7 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N830_8, -0.0054286756));

N830_6 :=__common__( map(trim(C_HH00) = ''      => 0.010745525,
              ((real)c_hh00 < 379.5) => -7.7759215e-005,
                                        0.010745525));

N830_5 :=__common__( map(trim(C_BUSINESS) = ''    => -0.0025344638,
              ((real)c_business < 4.5) => N830_6,
                                          -0.0025344638));

N830_4 :=__common__( if(((real)c_pop_65_74_p < 3.04999995232), 0.0052909574, N830_5));

N830_3 :=__common__( if(trim(C_POP_65_74_P) != '', N830_4, 0.010664798));

N830_2 :=__common__( map(((real)r_a46_curr_avm_autoval_d <= NULL)   => N830_3,
              ((real)r_a46_curr_avm_autoval_d < 14999.5) => -0.0064472049,
                                                            N830_3));

N830_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N830_2, N830_7));

N831_8 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => 0.0019571306,
              ((real)f_mos_inq_banko_cm_fseen_d < 28.5)  => -0.0049384642,
                                                            0.0019571306));

N831_7 :=__common__( map(trim(C_HH5_P) = ''              => 0.0082835082,
              ((real)c_hh5_p < 6.14999961853) => -0.0018905426,
                                                 0.0082835082));

N831_6 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), 0.015323204, N831_7));

N831_5 :=__common__( map(((real)r_l77_apartment_i <= NULL) => N831_6,
              ((real)r_l77_apartment_i < 0.5)   => -0.0019895793,
                                                   N831_6));

N831_4 :=__common__( if(((real)c_med_rent < 457.5), N831_5, N831_8));

N831_3 :=__common__( if(trim(C_MED_RENT) != '', N831_4, -0.00090454864));

N831_2 :=__common__( if(((real)f_srchssnsrchcount_i < 31.5), N831_3, -0.0052071659));

N831_1 :=__common__( if(((real)f_srchssnsrchcount_i > NULL), N831_2, -0.001866388));

N832_9 :=__common__( if(((real)r_c13_max_lres_d < 104.5), 0.010130323, -0.0021600446));

N832_8 :=__common__( if(((real)r_c13_max_lres_d > NULL), N832_9, 0.071689837));

N832_7 :=__common__( if(((real)f_srchphonesrchcount_i < 4.5), 0.0047392237, -0.0034796383));

N832_6 :=__common__( if(((real)f_srchphonesrchcount_i > NULL), N832_7, 0.013715391));

N832_5 :=__common__( map(trim(C_CHILD) = ''              => N832_6,
              ((real)c_child < 21.8499984741) => -0.0041248917,
                                                 N832_6));

N832_4 :=__common__( map(trim(C_FAMMAR18_P) = ''              => -0.00022183976,
              ((real)c_fammar18_p < 10.5500001907) => -0.0040727085,
                                                      -0.00022183976));

N832_3 :=__common__( map(trim(C_MURDERS) = ''      => N832_5,
              ((real)c_murders < 183.5) => N832_4,
                                           N832_5));

N832_2 :=__common__( if(((real)c_inc_75k_p < 28.75), N832_3, N832_8));

N832_1 :=__common__( if(trim(C_INC_75K_P) != '', N832_2, -0.0015223995));

N833_9 :=__common__( map(trim(C_SERV_EMPL) = ''     => -0.0010221025,
              ((real)c_serv_empl < 36.5) => 0.0033912665,
                                            -0.0010221025));

N833_8 :=__common__( map(((real)f_assoccredbureaucount_i <= NULL) => 0.010021117,
              ((real)f_assoccredbureaucount_i < 2.5)   => 0.00058642355,
                                                          0.010021117));

N833_7 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL) => N833_9,
              ((integer)f_fp_prevaddrburglaryindex_i < 41) => N833_8,
                                                              N833_9));

N833_6 :=__common__( if(trim(C_INC_25K_P) != '', N833_7, -6.3825372e-005));

N833_5 :=__common__( if(((real)f_rel_under25miles_cnt_d < 12.5), 0.011849006, 0.0020803736));

N833_4 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N833_5, -0.03500325));

N833_3 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), -0.0021496927, N833_4));

N833_2 :=__common__( if(((real)c_mos_since_impulse_fs_d < 44.5), N833_3, N833_6));

N833_1 :=__common__( if(((real)c_mos_since_impulse_fs_d > NULL), N833_2, -0.0029317148));

N834_9 :=__common__( map(trim(C_SPAN_LANG) = ''     => -0.0071446432,
              ((real)c_span_lang < 78.5) => 0.0049859877,
                                            -0.0071446432));

N834_8 :=__common__( map(trim(C_LOW_HVAL) = ''    => N834_9,
              ((real)c_low_hval < 8.5) => -0.011022194,
                                          N834_9));

N834_7 :=__common__( if(((real)c_manufacturing < 14.25), -2.0809069e-007, N834_8));

N834_6 :=__common__( if(trim(C_MANUFACTURING) != '', N834_7, 0.0016765281));

N834_5 :=__common__( map(((real)f_divsrchaddrsuspidcount_i <= NULL) => 0.0068116344,
              ((real)f_divsrchaddrsuspidcount_i < 0.5)   => -0.0012511273,
                                                            0.0068116344));

N834_4 :=__common__( if(((real)c_pop_45_54_p < 16.6500015259), N834_5, 0.0070046693));

N834_3 :=__common__( if(trim(C_POP_45_54_P) != '', N834_4, 0.018532007));

N834_2 :=__common__( if(((integer)r_i61_inq_collection_recency_d < 18), N834_3, N834_6));

N834_1 :=__common__( if(((real)r_i61_inq_collection_recency_d > NULL), N834_2, 0.0049240495));

N835_8 :=__common__( map(trim(C_POP_55_64_P) = ''     => -4.5534918e-005,
              ((real)c_pop_55_64_p < 6.75) => 0.005080217,
                                              -4.5534918e-005));

N835_7 :=__common__( map(trim(C_CONSTRUCTION) = ''               => -0.0047732116,
              ((real)c_construction < 0.649999976158) => 0.0028644237,
                                                         -0.0047732116));

N835_6 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d < 83.5), -0.0074152387, N835_7));

N835_5 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N835_6, 0.0035902443));

N835_4 :=__common__( map(trim(C_TOTCRIME) = ''      => N835_5,
              ((real)c_totcrime < 157.5) => -0.0002166515,
                                            N835_5));

N835_3 :=__common__( map(trim(C_LOW_HVAL) = ''      => N835_8,
              ((real)c_low_hval < 26.25) => N835_4,
                                            N835_8));

N835_2 :=__common__( if(((real)c_hval_125k_p < 38.4500007629), N835_3, 0.0056674041));

N835_1 :=__common__( if(trim(C_HVAL_125K_P) != '', N835_2, 0.00082473674));

N836_9 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.112773895264), 0.0067609674, 0.00031111101));

N836_8 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N836_9, 0.0027867005));

N836_7 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => N836_8,
              ((real)f_mos_liens_unrel_cj_fseen_d < 81.5)  => -0.0036026522,
                                                              N836_8));

N836_6 :=__common__( map(trim(C_RNT1500_P) = ''     => 0.011215272,
              ((real)c_rnt1500_p < 3.25) => N836_7,
                                            0.011215272));

N836_5 :=__common__( map(trim(C_HIGH_ED) = ''      => -0.001397411,
              ((real)c_high_ed < 14.25) => N836_6,
                                           -0.001397411));

N836_4 :=__common__( if(((real)c_rich_old < 163.5), N836_5, 0.0092357773));

N836_3 :=__common__( if(trim(C_RICH_OLD) != '', N836_4, 0.0036117209));

N836_2 :=__common__( if(((integer)r_f01_inp_addr_address_score_d < 55), N836_3, -0.0010431761));

N836_1 :=__common__( if(((real)r_f01_inp_addr_address_score_d > NULL), N836_2, -0.0070771456));

N837_9 :=__common__( if(((real)r_c10_m_hdr_fs_d < 152.5), -0.011684986, -0.00066564212));

N837_8 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N837_9, -0.03166087));

N837_7 :=__common__( map(trim(C_VACANT_P) = ''              => 0.0031455778,
              ((real)c_vacant_p < 11.5500001907) => -0.0025647727,
                                                    0.0031455778));

N837_6 :=__common__( map(trim(C_CIV_EMP) = ''              => 0.0065683856,
              ((real)c_civ_emp < 59.1500015259) => N837_7,
                                                   0.0065683856));

N837_5 :=__common__( map(trim(C_INC_75K_P) = ''              => -0.00011430739,
              ((real)c_inc_75k_p < 14.9499998093) => N837_6,
                                                     -0.00011430739));

N837_4 :=__common__( map(trim(C_INC_125K_P) = ''              => N837_5,
              ((real)c_inc_125k_p < 1.04999995232) => -0.002489803,
                                                      N837_5));

N837_3 :=__common__( if(((real)c_unique_addr_count_i > NULL), N837_4, 0.011151274));

N837_2 :=__common__( if(((real)c_agriculture < 0.0500000007451), N837_3, N837_8));

N837_1 :=__common__( if(trim(C_AGRICULTURE) != '', N837_2, -0.0012071318));

N838_9 :=__common__( map(((real)f_srchaddrsrchcountmo_i <= NULL) => 0.00083110339,
              ((real)f_srchaddrsrchcountmo_i < 0.5)   => 0.011542988,
                                                         0.00083110339));

N838_8 :=__common__( map(((real)f_corrrisktype_i <= NULL) => 0.0064085185,
              ((real)f_corrrisktype_i < 2.5)   => -0.0044103089,
                                                  0.0064085185));

N838_7 :=__common__( if(((real)r_c13_curr_addr_lres_d < 130.5), -0.00075158317, N838_8));

N838_6 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N838_7, -0.030388365));

N838_5 :=__common__( map(((real)f_srchfraudsrchcountmo_i <= NULL) => 0.0041741342,
              ((real)f_srchfraudsrchcountmo_i < 0.5)   => N838_6,
                                                          0.0041741342));

N838_4 :=__common__( if(trim(C_BLUE_COL) != '', N838_5, -0.00050685512));

N838_3 :=__common__( map(((real)f_srchfraudsrchcountyr_i <= NULL) => -0.0060598712,
              ((real)f_srchfraudsrchcountyr_i < 10.5)  => N838_4,
                                                          -0.0060598712));

N838_2 :=__common__( if(((real)f_srchphonesrchcountmo_i < 0.5), N838_3, N838_9));

N838_1 :=__common__( if(((real)f_srchphonesrchcountmo_i > NULL), N838_2, 0.0083377092));

N839_7 :=__common__( map(trim(C_RNT750_P) = ''      => 0.004729708,
              ((real)c_rnt750_p < 67.75) => -0.0022353646,
                                            0.004729708));

N839_6 :=__common__( map(trim(C_RENTOCC_P) = ''              => 0.013071952,
              ((real)c_rentocc_p < 38.3499984741) => 0.0007606298,
                                                     0.013071952));

N839_5 :=__common__( map(trim(C_HVAL_175K_P) = ''              => -0.0064739779,
              ((real)c_hval_175k_p < 6.55000019073) => 0.00083745837,
                                                       -0.0064739779));

N839_4 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => N839_5,
              ((real)f_add_curr_nhood_vac_pct_i < 0.0883636549115) => 0.0014416511,
                                                                      N839_5));

N839_3 :=__common__( map(trim(C_INC_35K_P) = ''              => N839_6,
              ((real)c_inc_35k_p < 20.3499984741) => N839_4,
                                                     N839_6));

N839_2 :=__common__( if(((real)c_inc_25k_p < 14.4499998093), N839_3, N839_7));

N839_1 :=__common__( if(trim(C_INC_25K_P) != '', N839_2, -0.0013777381));

N840_9 :=__common__( map(trim(C_LOW_HVAL) = ''              => -0.0068864193,
              ((real)c_low_hval < 2.34999990463) => -0.0001832002,
                                                    -0.0068864193));

N840_8 :=__common__( map(trim(C_BARGAINS) = ''      => -0.0048312378,
              ((real)c_bargains < 121.5) => 0.0044810191,
                                            -0.0048312378));

N840_7 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => 0.0078301684,
              ((real)r_c14_addrs_5yr_i < 6.5)   => N840_8,
                                                   0.0078301684));

N840_6 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.332237541676), N840_7, N840_9));

N840_5 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N840_6, 0.00034641415));

N840_4 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => 0.00059609314,
              ((real)f_mos_liens_unrel_cj_fseen_d < 94.5)  => N840_5,
                                                              0.00059609314));

N840_3 :=__common__( if(trim(C_NO_TEENS) != '', N840_4, -0.0051789267));

N840_2 :=__common__( if(((real)f_assocsuspicousidcount_i < 17.5), N840_3, 0.0075120785));

N840_1 :=__common__( if(((real)f_assocsuspicousidcount_i > NULL), N840_2, 0.0016811588));

N841_9 :=__common__( map(trim(C_AB_AV_EDU) = ''     => -4.5445798e-005,
              ((real)c_ab_av_edu < 85.5) => 0.01059866,
                                            -4.5445798e-005));

N841_8 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.0041019373,
              ((real)c_comb_age_d < 37.5)  => N841_9,
                                              -0.0041019373));

N841_7 :=__common__( map(trim(C_EMPLOYEES) = ''       => 0.014087835,
              ((integer)c_employees < 724) => N841_8,
                                              0.014087835));

N841_6 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0415599122643), -2.1212625e-005, -0.0083138416));

N841_5 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N841_6, 0.0016041882));

N841_4 :=__common__( if(((integer)f_curraddrmedianvalue_d < 222827), 2.6993304e-005, N841_5));

N841_3 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N841_4, -0.010876431));

N841_2 :=__common__( if(((real)c_inc_100k_p < 18.0499992371), N841_3, N841_7));

N841_1 :=__common__( if(trim(C_INC_100K_P) != '', N841_2, -0.0040523386));

N842_8 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => 0.00568544,
              ((real)f_srchfraudsrchcount_i < 6.5)   => 0.00094941829,
                                                        0.00568544));

N842_7 :=__common__( map(trim(C_RETIRED) = ''              => -0.00096510488,
              ((real)c_retired < 6.64999961853) => -0.0084066243,
                                                   -0.00096510488));

N842_6 :=__common__( map(trim(C_POP_35_44_P) = ''     => N842_7,
              ((real)c_pop_35_44_p < 8.75) => 0.0049333275,
                                              N842_7));

N842_5 :=__common__( map(trim(C_SUB_BUS) = ''      => N842_8,
              ((real)c_sub_bus < 105.5) => N842_6,
                                           N842_8));

N842_4 :=__common__( if(((real)f_rel_homeover50_count_d < 13.5), N842_5, -0.0012745294));

N842_3 :=__common__( if(((real)f_rel_homeover50_count_d > NULL), N842_4, 0.00092118485));

N842_2 :=__common__( if(((real)c_mort_indx < 39.5), -0.0049012846, N842_3));

N842_1 :=__common__( if(trim(C_MORT_INDX) != '', N842_2, -0.00066057654));

N843_8 :=__common__( map(((real)f_util_adl_count_n <= NULL) => 0.0098631491,
              ((real)f_util_adl_count_n < 4.5)   => -0.00086346539,
                                                    0.0098631491));

N843_7 :=__common__( map(trim(C_HH4_P) = ''              => N843_8,
              ((real)c_hh4_p < 22.0499992371) => -0.00012427247,
                                                 N843_8));

N843_6 :=__common__( if(((real)r_a50_pb_total_orders_d < 8.5), N843_7, -0.0075227769));

N843_5 :=__common__( if(((real)r_a50_pb_total_orders_d > NULL), N843_6, -0.0073678482));

N843_4 :=__common__( map(trim(C_INC_125K_P) = ''              => 0.007599469,
              ((real)c_inc_125k_p < 14.1499996185) => N843_5,
                                                      0.007599469));

N843_3 :=__common__( map(trim(C_HH3_P) = ''     => N843_4,
              ((real)c_hh3_p < 2.75) => -0.0063592236,
                                        N843_4));

N843_2 :=__common__( if(((real)c_inc_125k_p < 15.75), N843_3, -0.0073294323));

N843_1 :=__common__( if(trim(C_INC_125K_P) != '', N843_2, -0.002688272));

N844_9 :=__common__( map(((real)r_phn_cell_n <= NULL) => -0.004364788,
              ((real)r_phn_cell_n < 0.5)   => 0.0057261489,
                                              -0.004364788));

N844_8 :=__common__( map(trim(C_EXP_PROD) = ''      => 0.0076912949,
              ((real)c_exp_prod < 110.5) => N844_9,
                                            0.0076912949));

N844_7 :=__common__( if(((real)c_pop_75_84_p < 1.84999990463), N844_8, -0.0026562898));

N844_6 :=__common__( if(trim(C_POP_75_84_P) != '', N844_7, -0.022865062));

N844_5 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => 0.001457568,
              ((real)f_m_bureau_adl_fs_all_d < 150.5) => N844_6,
                                                         0.001457568));

N844_4 :=__common__( if(((real)f_add_input_mobility_index_n < 0.65040409565), N844_5, 0.0073778144));

N844_3 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N844_4, -0.0069690307));

N844_2 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.713522255421), N844_3, -0.0067942164));

N844_1 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N844_2, 0.00036591466));

N845_8 :=__common__( if(((real)f_srchvelocityrisktype_i < 7.5), -0.0029900513, -0.010248162));

N845_7 :=__common__( if(((real)f_srchvelocityrisktype_i > NULL), N845_8, 0.0095309381));

N845_6 :=__common__( map(trim(C_FOR_SALE) = ''      => 0.0047717897,
              ((real)c_for_sale < 183.5) => N845_7,
                                            0.0047717897));

N845_5 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.0091956228,
              ((real)c_sub_bus < 127.5) => -0.0012276862,
                                           0.0091956228));

N845_4 :=__common__( map((segment in ['KMART', 'SEARS AUTO'])              => -0.001898023,
              (segment in ['RETAIL', 'SEARS FLS', 'SEARS SHO']) => N845_5,
                                                                   N845_5));

N845_3 :=__common__( map(trim(C_RAPE) = ''      => N845_6,
              ((integer)c_rape < 97) => N845_4,
                                        N845_6));

N845_2 :=__common__( if(((real)c_rnt1000_p < 6.05000019073), 0.0012505014, N845_3));

N845_1 :=__common__( if(trim(C_RNT1000_P) != '', N845_2, -0.0025267296));

N846_10 :=__common__( if(((real)c_health < 7.25), -0.001377576, -0.012608166));

N846_9 :=__common__( if(trim(C_HEALTH) != '', N846_10, -0.044924725));

N846_8 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => N846_9,
              ((real)f_curraddrcartheftindex_i < 190.5) => -0.00075895989,
                                                           N846_9));

N846_7 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)    => N846_8,
              ((integer)f_curraddrmedianincome_d < 16085) => 0.0059595327,
                                                             N846_8));

N846_6 :=__common__( if(((real)c_inc_35k_p < 12.25), 0.0013150463, 0.012860073));

N846_5 :=__common__( if(trim(C_INC_35K_P) != '', N846_6, -0.0026037858));

N846_4 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.164266616106), 0.00054575904, N846_5));

N846_3 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N846_4, 0.00054972469));

N846_2 :=__common__( if(((real)f_prevaddrageoldest_d < 33.5), N846_3, N846_7));

N846_1 :=__common__( if(((real)f_prevaddrageoldest_d > NULL), N846_2, -0.017220936));

N847_9 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => 0.00018691952,
              ((real)r_a50_pb_average_dollars_d < 41.5)  => 0.0062200247,
                                                            0.00018691952));

N847_8 :=__common__( if(((real)r_f00_dob_score_d > NULL), N847_9, 0.012045512));

N847_7 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL)  => -0.0053051265,
              ((integer)f_curraddrcrimeindex_i < 192) => N847_8,
                                                         -0.0053051265));

N847_6 :=__common__( if(((real)c_transport < 5.85000038147), N847_7, 0.0076221447));

N847_5 :=__common__( if(trim(C_TRANSPORT) != '', N847_6, 0.0080269521));

N847_4 :=__common__( if(((real)c_mil_emp < 3.15000009537), -0.0010743995, 0.0060752409));

N847_3 :=__common__( if(trim(C_MIL_EMP) != '', N847_4, -0.0004065536));

N847_2 :=__common__( if(((real)f_prevaddrageoldest_d < 65.5), N847_3, N847_5));

N847_1 :=__common__( if(((real)f_prevaddrageoldest_d > NULL), N847_2, -0.0048837858));

N848_9 :=__common__( if(((real)r_l79_adls_per_addr_c6_i < 4.5), 0.00073621181, 0.0085582424));

N848_8 :=__common__( if(((real)r_l79_adls_per_addr_c6_i > NULL), N848_9, 0.047070723));

N848_7 :=__common__( map(trim(C_HH2_P) = ''              => 0.0076326193,
              ((real)c_hh2_p < 26.1500015259) => -0.0020921459,
                                                 0.0076326193));

N848_6 :=__common__( map(trim(C_RNT1000_P) = ''              => 0.0082861708,
              ((real)c_rnt1000_p < 44.1500015259) => -0.0006415008,
                                                     0.0082861708));

N848_5 :=__common__( map(((real)c_unique_addr_count_i <= NULL) => -0.0032664295,
              ((real)c_unique_addr_count_i < 8.5)   => N848_6,
                                                       -0.0032664295));

N848_4 :=__common__( if(((real)c_inc_25k_p < 21.9500007629), N848_5, N848_7));

N848_3 :=__common__( if(trim(C_INC_25K_P) != '', N848_4, 0.0029938229));

N848_2 :=__common__( if(((real)r_c13_max_lres_d < 101.5), N848_3, N848_8));

N848_1 :=__common__( if(((real)r_c13_max_lres_d > NULL), N848_2, -0.0048289684));

N849_8 :=__common__( map(trim(C_FAMILIES) = ''      => 0.0028298655,
              ((real)c_families < 248.5) => 0.013161357,
                                            0.0028298655));

N849_7 :=__common__( map(trim(C_BLUE_EMPL) = ''     => -0.0096383226,
              ((real)c_blue_empl < 88.5) => 0.0032698953,
                                            -0.0096383226));

N849_6 :=__common__( map(trim(C_HVAL_150K_P) = ''               => N849_8,
              ((real)c_hval_150k_p < 0.350000023842) => N849_7,
                                                        N849_8));

N849_5 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 240.5), -0.0040032829, -0.00013046456));

N849_4 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N849_5, -0.00078686908));

N849_3 :=__common__( map(trim(C_PROFESSIONAL) = ''              => N849_6,
              ((real)c_professional < 9.85000038147) => N849_4,
                                                        N849_6));

N849_2 :=__common__( if(((real)c_hval_20k_p < 30.1000003815), N849_3, 0.0074867087));

N849_1 :=__common__( if(trim(C_HVAL_20K_P) != '', N849_2, 0.0029430533));

N850_10 :=__common__( if(((real)r_c13_curr_addr_lres_d < 90.5), 0.0018536644, -0.0063649503));

N850_9 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N850_10, -0.033562567));

N850_8 :=__common__( if(((real)f_rel_homeover150_count_d < 3.5), N850_9, -0.0073651529));

N850_7 :=__common__( if(((real)f_rel_homeover150_count_d > NULL), N850_8, 0.0057500245));

N850_6 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => N850_7,
              ((real)f_mos_inq_banko_om_fseen_d < 32.5)  => 0.0074195543,
                                                            N850_7));

N850_5 :=__common__( if(((real)c_inc_100k_p < 5.14999961853), -0.01164988, -0.0029460749));

N850_4 :=__common__( if(trim(C_INC_100K_P) != '', N850_5, -0.0056960758));

N850_3 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => N850_6,
              ((real)f_mos_inq_banko_om_lseen_d < 19.5)  => N850_4,
                                                            N850_6));

N850_2 :=__common__( if(((real)f_prevaddrmedianvalue_d < 75452.5), N850_3, 0.00067392086));

N850_1 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N850_2, -0.0041806126));

N851_9 :=__common__( map(trim(C_RELIG_INDX) = ''     => 0.0081944077,
              ((real)c_relig_indx < 61.5) => -0.00040364948,
                                             0.0081944077));

N851_8 :=__common__( map(trim(C_INC_35K_P) = ''              => N851_9,
              ((real)c_inc_35k_p < 9.85000038147) => 0.00043983901,
                                                     N851_9));

N851_7 :=__common__( map(trim(C_OWNOCC_P) = ''              => N851_8,
              ((real)c_ownocc_p < 65.3500061035) => -3.9469174e-005,
                                                    N851_8));

N851_6 :=__common__( if(((real)c_inc_25k_p < 1.54999995232), -0.0082335377, N851_7));

N851_5 :=__common__( if(trim(C_INC_25K_P) != '', N851_6, 0.0015824846));

N851_4 :=__common__( if(((real)c_fammar18_p < 32.75), 6.7672286e-005, -0.010249907));

N851_3 :=__common__( if(trim(C_FAMMAR18_P) != '', N851_4, -0.015333654));

N851_2 :=__common__( if(((integer)r_i60_inq_mortgage_recency_d < 549), N851_3, N851_5));

N851_1 :=__common__( if(((real)r_i60_inq_mortgage_recency_d > NULL), N851_2, 0.001909627));

N852_9 :=__common__( map(((real)c_inf_nothing_found_i <= NULL) => 0.0026291245,
              ((real)c_inf_nothing_found_i < 0.5)   => 0.010960881,
                                                       0.0026291245));

N852_8 :=__common__( map(trim(C_RETIRED2) = ''     => 0.0050076641,
              ((real)c_retired2 < 63.5) => -0.0069151817,
                                           0.0050076641));

N852_7 :=__common__( map(trim(C_RAPE) = ''      => N852_9,
              ((real)c_rape < 130.5) => N852_8,
                                        N852_9));

N852_6 :=__common__( if(((real)c_rich_fam < 126.5), N852_7, -0.0061728146));

N852_5 :=__common__( if(trim(C_RICH_FAM) != '', N852_6, 0.016032173));

N852_4 :=__common__( if(((real)c_rnt2000_p < 5.25), -0.00079569544, 0.0040778597));

N852_3 :=__common__( if(trim(C_RNT2000_P) != '', N852_4, -0.0020444985));

N852_2 :=__common__( if(((real)f_add_input_nhood_vac_pct_i < 0.177452981472), N852_3, N852_5));

N852_1 :=__common__( if(((real)f_add_input_nhood_vac_pct_i > NULL), N852_2, -0.0058836999));

N853_7 :=__common__( map(trim(C_HEALTH) = ''              => -0.0097626195,
              ((real)c_health < 9.35000038147) => -0.00015063849,
                                                  -0.0097626195));

N853_6 :=__common__( map(((real)f_inq_per_addr_i <= NULL) => N853_7,
              ((real)f_inq_per_addr_i < 1.5)   => 0.0029196401,
                                                  N853_7));

N853_5 :=__common__( map(trim(C_POP_45_54_P) = ''              => -0.0056386416,
              ((real)c_pop_45_54_p < 13.9499998093) => 0.0051334582,
                                                       -0.0056386416));

N853_4 :=__common__( map(trim(C_RNT1000_P) = ''              => N853_5,
              ((real)c_rnt1000_p < 5.94999980927) => 0.0082072291,
                                                     N853_5));

N853_3 :=__common__( map(trim(C_HVAL_150K_P) = ''              => N853_6,
              ((real)c_hval_150k_p < 6.44999980927) => N853_4,
                                                       N853_6));

N853_2 :=__common__( if(((real)c_newhouse < 32.6500015259), -0.00043236048, N853_3));

N853_1 :=__common__( if(trim(C_NEWHOUSE) != '', N853_2, 0.0046428629));

N854_10 :=__common__( if(((real)r_c13_avg_lres_d < 56.5), 0.011162732, 0.00070528197));

N854_9 :=__common__( if(((real)r_c13_avg_lres_d > NULL), N854_10, -0.030237271));

N854_8 :=__common__( map(trim(C_INC_201K_P) = ''     => 0.010459975,
              ((real)c_inc_201k_p < 1.25) => 0.0001452679,
                                             0.010459975));

N854_7 :=__common__( map(trim(C_HIGH_HVAL) = ''     => -0.0059498396,
              ((real)c_high_hval < 1.25) => N854_8,
                                            -0.0059498396));

N854_6 :=__common__( map(((real)f_inq_count24_i <= NULL) => -0.0070117412,
              ((real)f_inq_count24_i < 9.5)   => N854_7,
                                                 -0.0070117412));

N854_5 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), -0.00057442345, N854_6));

N854_4 :=__common__( if(((real)f_mos_liens_unrel_lt_fseen_d < 24.5), 0.006369318, N854_5));

N854_3 :=__common__( if(((real)f_mos_liens_unrel_lt_fseen_d > NULL), N854_4, 0.0036659895));

N854_2 :=__common__( if(((real)c_rnt500_p < 73.6499938965), N854_3, N854_9));

N854_1 :=__common__( if(trim(C_RNT500_P) != '', N854_2, 0.00071302036));

N855_8 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => 5.4651408e-005,
              ((real)r_d32_mos_since_crim_ls_d < 22.5)  => -0.0060366085,
                                                           5.4651408e-005));

N855_7 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => -0.0076471571,
              ((real)f_curraddrmedianincome_d < 39204.5) => 0.0025118718,
                                                            -0.0076471571));

N855_6 :=__common__( if(((real)c_finance < 3.65000009537), N855_7, 0.0046417723));

N855_5 :=__common__( if(trim(C_FINANCE) != '', N855_6, -0.00067334489));

N855_4 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => 0.0041462888,
              ((real)f_curraddrburglaryindex_i < 91.5)  => N855_5,
                                                           0.0041462888));

N855_3 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)    => N855_8,
              ((integer)f_prevaddrmedianincome_d < 39647) => N855_4,
                                                             N855_8));

N855_2 :=__common__( if(((real)f_curraddrmurderindex_i < 163.5), N855_3, -0.0018839155));

N855_1 :=__common__( if(((real)f_curraddrmurderindex_i > NULL), N855_2, -0.0027694116));

N856_8 :=__common__( map(trim(C_HIGHINC) = ''              => -0.0038902164,
              ((real)c_highinc < 6.44999980927) => 0.0018309098,
                                                   -0.0038902164));

N856_7 :=__common__( map(trim(C_ASIAN_LANG) = ''      => 0.0055435078,
              ((real)c_asian_lang < 164.5) => N856_8,
                                              0.0055435078));

N856_6 :=__common__( map(trim(C_POP_85P_P) = ''              => 0.0067241162,
              ((real)c_pop_85p_p < 3.04999995232) => N856_7,
                                                     0.0067241162));

N856_5 :=__common__( map(trim(C_HVAL_60K_P) = ''              => 0.0074481301,
              ((real)c_hval_60k_p < 22.3499984741) => N856_6,
                                                      0.0074481301));

N856_4 :=__common__( if(((real)c_fammar18_p < 4.64999961853), -0.0059484139, N856_5));

N856_3 :=__common__( if(trim(C_FAMMAR18_P) != '', N856_4, 0.0036074019));

N856_2 :=__common__( if(((real)r_c14_addrs_15yr_i < 11.5), -0.0011244246, N856_3));

N856_1 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N856_2, -0.0023267954));

N857_8 :=__common__( map(((real)r_c20_email_domain_free_count_i <= NULL) => -0.0082234251,
              ((real)r_c20_email_domain_free_count_i < 0.5)   => 0.0021729223,
                                                                 -0.0082234251));

N857_7 :=__common__( map(((real)f_rel_criminal_count_i <= NULL) => 0.00014305298,
              ((real)f_rel_criminal_count_i < 3.5)   => 0.0042625572,
                                                        0.00014305298));

N857_6 :=__common__( map(((real)r_f00_input_dob_match_level_d <= NULL) => -0.001107751,
              ((real)r_f00_input_dob_match_level_d < 5.5)   => 0.0073958327,
                                                               -0.001107751));

N857_5 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => N857_7,
              ((real)r_d30_derog_count_i < 3.5)   => N857_6,
                                                     N857_7));

N857_4 :=__common__( if(((real)c_pop_55_64_p < 20.6500015259), N857_5, 0.0074968617));

N857_3 :=__common__( if(trim(C_POP_55_64_P) != '', N857_4, -0.00085968317));

N857_2 :=__common__( if(((real)r_c18_inv_add_per_adl_c6_i < 0.5), N857_3, N857_8));

N857_1 :=__common__( if(((real)r_c18_inv_add_per_adl_c6_i > NULL), N857_2, -0.00041892827));

N858_9 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0558067336679), -0.002938182, -0.012163161));

N858_8 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N858_9, -0.0059458748));

N858_7 :=__common__( map(trim(C_UNATTACH) = ''      => -0.00017376399,
              ((real)c_unattach < 127.5) => N858_8,
                                            -0.00017376399));

N858_6 :=__common__( map(trim(C_WHITE_COL) = ''              => -0.00035005703,
              ((real)c_white_col < 18.5499992371) => N858_7,
                                                     -0.00035005703));

N858_5 :=__common__( if(((real)f_prevaddrlenofres_d < 45.5), 0.010726591, 0.00097674277));

N858_4 :=__common__( if(((real)f_prevaddrlenofres_d > NULL), N858_5, -0.031294093));

N858_3 :=__common__( map(trim(C_HVAL_175K_P) = ''    => -0.0016662624,
              ((real)c_hval_175k_p < 0.5) => N858_4,
                                             -0.0016662624));

N858_2 :=__common__( if(((real)c_hh2_p < 16.6500015259), N858_3, N858_6));

N858_1 :=__common__( if(trim(C_HH2_P) != '', N858_2, 0.0011732665));

N859_8 :=__common__( map(trim(C_NO_MOVE) = ''      => 0.0064764537,
              ((real)c_no_move < 172.5) => -0.0014568151,
                                           0.0064764537));

N859_7 :=__common__( if(((real)c_unique_addr_count_i < 5.5), 0.003308674, N859_8));

N859_6 :=__common__( if(((real)c_unique_addr_count_i > NULL), N859_7, -0.00084616616));

N859_5 :=__common__( map(trim(C_HH2_P) = ''      => N859_6,
              ((real)c_hh2_p < 21.75) => -0.0043361939,
                                         N859_6));

N859_4 :=__common__( map(trim(C_NO_TEENS) = ''     => -0.00072957039,
              ((real)c_no_teens < 31.5) => 0.0039930308,
                                           -0.00072957039));

N859_3 :=__common__( map(trim(C_NEWHOUSE) = ''              => 0.0059894508,
              ((real)c_newhouse < 41.3499984741) => N859_4,
                                                    0.0059894508));

N859_2 :=__common__( if(((real)c_hval_150k_p < 2.54999995232), N859_3, N859_5));

N859_1 :=__common__( if(trim(C_HVAL_150K_P) != '', N859_2, -0.0012636877));

N860_8 :=__common__( map(((real)f_componentcharrisktype_i <= NULL) => 0.012351821,
              ((real)f_componentcharrisktype_i < 5.5)   => 0.0025473476,
                                                           0.012351821));

N860_7 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => 0.00063226163,
              ((real)r_d32_mos_since_crim_ls_d < 42.5)  => N860_8,
                                                           0.00063226163));

N860_6 :=__common__( map(trim(C_HVAL_250K_P) = ''              => -0.0049802858,
              ((real)c_hval_250k_p < 6.94999980927) => 0.00016106809,
                                                       -0.0049802858));

N860_5 :=__common__( if(((real)c_dist_best_to_prev_addr_i < 3.5), N860_6, N860_7));

N860_4 :=__common__( if(((real)c_dist_best_to_prev_addr_i > NULL), N860_5, 0.0059690873));

N860_3 :=__common__( map(((real)f_bus_name_nover_i <= NULL) => -0.0019654708,
              ((real)f_bus_name_nover_i < 0.5)   => N860_4,
                                                    -0.0019654708));

N860_2 :=__common__( if(((real)c_pop_18_24_p < 19.3499984741), N860_3, 0.0043455476));

N860_1 :=__common__( if(trim(C_POP_18_24_P) != '', N860_2, -0.0001252463));

N861_9 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => -0.0040186096,
              ((real)f_rel_felony_count_i < 0.5)   => 0.0039247397,
                                                      -0.0040186096));

N861_8 :=__common__( if(((integer)r_i61_inq_collection_recency_d < 549), N861_9, -0.0083585842));

N861_7 :=__common__( if(((real)r_i61_inq_collection_recency_d > NULL), N861_8, 0.014257433));

N861_6 :=__common__( map(trim(C_RETAIL) = ''              => 0.00074604503,
              ((real)c_retail < 3.15000009537) => 0.009152466,
                                                  0.00074604503));

N861_5 :=__common__( if(((real)f_divssnidmsrcurelcount_i < 1.5), N861_6, 0.0093543441));

N861_4 :=__common__( if(((real)f_divssnidmsrcurelcount_i > NULL), N861_5, 0.011428362));

N861_3 :=__common__( map(trim(C_TOTSALES) = ''       => N861_4,
              ((real)c_totsales < 2914.5) => -0.00059934425,
                                             N861_4));

N861_2 :=__common__( if(((real)c_amus_indx < 115.5), N861_3, N861_7));

N861_1 :=__common__( if(trim(C_AMUS_INDX) != '', N861_2, 0.0011485304));

N862_8 :=__common__( map(trim(C_RENTOCC_P) = ''              => 0.00014940759,
              ((real)c_rentocc_p < 3.84999990463) => 0.0077546571,
                                                     0.00014940759));

N862_7 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => 0.0068628215,
              ((real)r_d30_derog_count_i < 26.5)  => N862_8,
                                                     0.0068628215));

N862_6 :=__common__( map(trim(C_POP_35_44_P) = ''              => -0.011077644,
              ((real)c_pop_35_44_p < 14.4499998093) => -0.00053400517,
                                                       -0.011077644));

N862_5 :=__common__( if(((real)f_mos_liens_unrel_ot_fseen_d < 95.5), N862_6, N862_7));

N862_4 :=__common__( if(((real)f_mos_liens_unrel_ot_fseen_d > NULL), N862_5, -0.0009778932));

N862_3 :=__common__( map(trim(C_INC_15K_P) = ''              => 0.0007559832,
              ((real)c_inc_15k_p < 37.5499992371) => -0.0089536192,
                                                     0.0007559832));

N862_2 :=__common__( if(((real)c_fammar_p < 21.6500015259), N862_3, N862_4));

N862_1 :=__common__( if(trim(C_FAMMAR_P) != '', N862_2, -0.0010543398));

N863_8 :=__common__( map(trim(C_RENTAL) = ''      => 0.013518497,
              ((real)c_rental < 123.5) => 0.0040899048,
                                          0.013518497));

N863_7 :=__common__( map(trim(C_PROFESSIONAL) = ''     => -0.0025056554,
              ((real)c_professional < 4.75) => N863_8,
                                               -0.0025056554));

N863_6 :=__common__( if(((real)c_hh4_p < 11.0500001907), -0.0011264008, N863_7));

N863_5 :=__common__( if(trim(C_HH4_P) != '', N863_6, -0.018391138));

N863_4 :=__common__( map(((real)c_mos_since_impulse_ls_d <= NULL) => -0.00055537124,
              ((real)c_mos_since_impulse_ls_d < 63.5)  => N863_5,
                                                          -0.00055537124));

N863_3 :=__common__( map(((real)f_inq_communications_count24_i <= NULL) => 0.0051633468,
              ((real)f_inq_communications_count24_i < 5.5)   => N863_4,
                                                                0.0051633468));

N863_2 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d < 3.5), 0.0071581634, N863_3));

N863_1 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N863_2, 0.0045512817));

N864_9 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0589769855142), -0.0029942882, 0.0083539243));

N864_8 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N864_9, -0.0052746824));

N864_7 :=__common__( map(trim(C_RELIG_INDX) = ''      => N864_8,
              ((real)c_relig_indx < 136.5) => -0.005749502,
                                              N864_8));

N864_6 :=__common__( map(((real)f_current_count_d <= NULL) => N864_7,
              ((real)f_current_count_d < 3.5)   => 0.00015937721,
                                                   N864_7));

N864_5 :=__common__( map(trim(C_HH1_P) = ''              => N864_6,
              ((real)c_hh1_p < 9.14999961853) => -0.0063769971,
                                                 N864_6));

N864_4 :=__common__( if(((real)c_ownocc_p < 88.4499969482), N864_5, 0.0072169918));

N864_3 :=__common__( if(trim(C_OWNOCC_P) != '', N864_4, 0.00011626741));

N864_2 :=__common__( if(((real)f_inq_banking_count24_i < 3.5), N864_3, 0.0079457639));

N864_1 :=__common__( if(((real)f_inq_banking_count24_i > NULL), N864_2, 0.0048499344));

N865_9 :=__common__( if(((real)r_pb_order_freq_d > NULL), -0.0061458366, 0.0058698532));

N865_8 :=__common__( if(((real)r_i60_inq_comm_recency_d < 61.5), -0.0084167203, N865_9));

N865_7 :=__common__( if(((real)r_i60_inq_comm_recency_d > NULL), N865_8, 0.01986213));

N865_6 :=__common__( map(trim(C_FAMILIES) = ''      => -0.0010180326,
              ((real)c_families < 150.5) => 0.0073741535,
                                            -0.0010180326));

N865_5 :=__common__( map(((real)f_attr_arrest_recency_d <= NULL) => N865_6,
              ((real)f_attr_arrest_recency_d < 99.5)  => -0.0082641114,
                                                         N865_6));

N865_4 :=__common__( if(((real)f_rel_count_i < 21.5), 0.0013977334, N865_5));

N865_3 :=__common__( if(((real)f_rel_count_i > NULL), N865_4, 0.0027040936));

N865_2 :=__common__( if(((real)c_manufacturing < 17.6500015259), N865_3, N865_7));

N865_1 :=__common__( if(trim(C_MANUFACTURING) != '', N865_2, 0.0018659316));

N866_8 :=__common__( map(trim(C_POP_75_84_P) = ''              => 0.0015358147,
              ((real)c_pop_75_84_p < 2.54999995232) => 0.013349062,
                                                       0.0015358147));

N866_7 :=__common__( map(trim(C_HOUSINGCPI) = ''              => 0.00044865246,
              ((real)c_housingcpi < 188.050003052) => N866_8,
                                                      0.00044865246));

N866_6 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => 0.0034173619,
              ((real)r_c14_addrs_5yr_i < 4.5)   => -0.0040666289,
                                                   0.0034173619));

N866_5 :=__common__( map(trim(C_HVAL_20K_P) = ''     => 0.0069314732,
              ((real)c_hval_20k_p < 1.75) => N866_6,
                                             0.0069314732));

N866_4 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N866_5, -0.01775259));

N866_3 :=__common__( map(trim(C_RELIG_INDX) = ''     => -0.0038926156,
              ((real)c_relig_indx < 84.5) => N866_4,
                                             -0.0038926156));

N866_2 :=__common__( if(((real)c_born_usa < 91.5), N866_3, N866_7));

N866_1 :=__common__( if(trim(C_BORN_USA) != '', N866_2, 0.0015346525));

N867_9 :=__common__( if(((real)c_rest_indx < 121.5), 0.0036091024, -0.0023494579));

N867_8 :=__common__( if(trim(C_REST_INDX) != '', N867_9, 0.0040832085));

N867_7 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.00090242878,
              ((real)c_comb_age_d < 28.5)  => N867_8,
                                              -0.00090242878));

N867_6 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => -0.0023892419,
              ((real)r_a50_pb_average_dollars_d < 40.5)  => 0.0080372322,
                                                            -0.0023892419));

N867_5 :=__common__( map(trim(C_EMPLOYEES) = ''      => 0.015436643,
              ((real)c_employees < 134.5) => 0.0023196762,
                                             0.015436643));

N867_4 :=__common__( if(((real)c_pop_65_74_p < 3.75), N867_5, N867_6));

N867_3 :=__common__( if(trim(C_POP_65_74_P) != '', N867_4, -0.011550202));

N867_2 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => N867_3,
              ((real)r_c10_m_hdr_fs_d < 119.5) => -0.0038607786,
                                                  N867_3));

N867_1 :=__common__( if(((real)f_college_income_d > NULL), N867_2, N867_7));

N868_10 :=__common__( map(((real)r_l79_adls_per_addr_c6_i <= NULL) => 0.0013993825,
               ((real)r_l79_adls_per_addr_c6_i < 1.5)   => -0.0009805743,
                                                           0.0013993825));

N868_9 :=__common__( if(((real)r_c10_m_hdr_fs_d < 212.5), 0.0032683338, 0.014601311));

N868_8 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N868_9, 0.059960435));

N868_7 :=__common__( map(trim(C_OCCUNIT_P) = ''              => 0.0030444897,
              ((real)c_occunit_p < 90.1499938965) => -0.0057833092,
                                                     0.0030444897));

N868_6 :=__common__( if(((real)f_prevaddrstatus_i > NULL), N868_7, 0.0017048346));

N868_5 :=__common__( if(((real)f_rel_count_i < 23.5), N868_6, 0.0073042358));

N868_4 :=__common__( if(((real)f_rel_count_i > NULL), N868_5, 0.017038768));

N868_3 :=__common__( map(trim(C_MURDERS) = ''      => N868_8,
              ((real)c_murders < 181.5) => N868_4,
                                           N868_8));

N868_2 :=__common__( if(((real)c_hh5_p < 0.15000000596), N868_3, N868_10));

N868_1 :=__common__( if(trim(C_HH5_P) != '', N868_2, 0.0012031192));

N869_11 :=__common__( if(((real)c_professional < 20.0499992371), 8.1078214e-006, -0.0066193011));

N869_10 :=__common__( if(trim(C_PROFESSIONAL) != '', N869_11, 0.0018662151));

N869_9 :=__common__( map(trim(C_RNT1000_P) = ''              => -0.0048819004,
              ((real)c_rnt1000_p < 8.14999961853) => 0.0041650406,
                                                     -0.0048819004));

N869_8 :=__common__( map(trim(C_HH4_P) = ''              => 0.0087666868,
              ((real)c_hh4_p < 15.0500001907) => N869_9,
                                                 0.0087666868));

N869_7 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N869_8, 0.001341816));

N869_6 :=__common__( if(((real)c_oldhouse < 76.75), -0.0079017847, N869_7));

N869_5 :=__common__( if(trim(C_OLDHOUSE) != '', N869_6, 0.018968777));

N869_4 :=__common__( if(((real)f_rel_homeover150_count_d < 6.5), N869_5, 0.0079259352));

N869_3 :=__common__( if(((real)f_rel_homeover150_count_d > NULL), N869_4, 0.0027325987));

N869_2 :=__common__( if(((integer)r_d33_eviction_recency_d < 48), N869_3, N869_10));

N869_1 :=__common__( if(((real)r_d33_eviction_recency_d > NULL), N869_2, -0.0019461598));

N870_8 :=__common__( map(trim(C_POP_85P_P) = ''               => 0.0041923409,
              ((real)c_pop_85p_p < 0.649999976158) => -0.0057151725,
                                                      0.0041923409));

N870_7 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => N870_8,
              ((real)r_d32_mos_since_crim_ls_d < 70.5)  => -0.0089199424,
                                                           N870_8));

N870_6 :=__common__( map(trim(C_HVAL_100K_P) = ''      => -0.0015040503,
              ((real)c_hval_100k_p < 18.25) => 0.0022367452,
                                               -0.0015040503));

N870_5 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N870_6, -0.0014166123));

N870_4 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.0091069991,
              ((real)r_d32_criminal_count_i < 16.5)  => N870_5,
                                                        0.0091069991));

N870_3 :=__common__( map(((real)c_addr_lres_2mo_ct_i <= NULL) => N870_7,
              ((real)c_addr_lres_2mo_ct_i < 3.5)   => N870_4,
                                                      N870_7));

N870_2 :=__common__( if(((real)f_addrchangevaluediff_d < -158839.5), -0.0070570054, N870_3));

N870_1 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N870_2, -0.0011455105));

N871_8 :=__common__( map(((real)f_fp_prevaddrcrimeindex_i <= NULL) => 0.011579895,
              ((real)f_fp_prevaddrcrimeindex_i < 83.5)  => -0.00041658985,
                                                           0.011579895));

N871_7 :=__common__( map(trim(C_PRESCHL) = ''      => 0.010005724,
              ((real)c_preschl < 138.5) => 0.0010787012,
                                           0.010005724));

N871_6 :=__common__( map(trim(C_BURGLARY) = ''       => -0.0024073274,
              ((integer)c_burglary < 131) => N871_7,
                                             -0.0024073274));

N871_5 :=__common__( map(trim(C_HVAL_250K_P) = ''              => N871_6,
              ((real)c_hval_250k_p < 15.3500003815) => -0.00087604491,
                                                       N871_6));

N871_4 :=__common__( if(((real)c_hval_750k_p < 16.25), N871_5, N871_8));

N871_3 :=__common__( if(trim(C_HVAL_750K_P) != '', N871_4, 0.0043601313));

N871_2 :=__common__( if(((real)f_inputaddractivephonelist_d < 0.5), N871_3, -0.0035659885));

N871_1 :=__common__( if(((real)f_inputaddractivephonelist_d > NULL), N871_2, 0.00082646488));

N872_8 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => -0.0019082351,
              ((real)f_m_bureau_adl_fs_all_d < 143.5) => 0.0028708252,
                                                         -0.0019082351));

N872_7 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => 0.0094848749,
              ((real)f_add_curr_nhood_sfd_pct_d < 0.967365145683) => 0.00057506208,
                                                                     0.0094848749));

N872_6 :=__common__( map(trim(C_RETIRED2) = ''     => 0.0035432082,
              ((real)c_retired2 < 77.5) => 0.014916196,
                                           0.0035432082));

N872_5 :=__common__( map(trim(C_HH1_P) = ''              => N872_7,
              ((real)c_hh1_p < 17.4500007629) => N872_6,
                                                 N872_7));

N872_4 :=__common__( if(((real)c_pop_65_74_p < 4.94999980927), -0.00083724984, N872_5));

N872_3 :=__common__( if(trim(C_POP_65_74_P) != '', N872_4, 0.0050064628));

N872_2 :=__common__( if(((real)f_rel_criminal_count_i < 5.5), N872_3, N872_8));

N872_1 :=__common__( if(((real)f_rel_criminal_count_i > NULL), N872_2, 0.00021613325));

N873_8 :=__common__( map(trim(C_HH3_P) = ''              => -0.0078157442,
              ((real)c_hh3_p < 11.9499998093) => 0.0010846429,
                                                 -0.0078157442));

N873_7 :=__common__( map(trim(C_CIV_EMP) = ''      => 0.0057248885,
              ((real)c_civ_emp < 59.75) => -0.0033271514,
                                           0.0057248885));

N873_6 :=__common__( map(((real)f_prevaddrdwelltype_apt_n <= NULL) => 0.0068325197,
              ((real)f_prevaddrdwelltype_apt_n < 0.5)   => N873_7,
                                                           0.0068325197));

N873_5 :=__common__( if(((integer)f_liens_unrel_sc_total_amt_i < 407), N873_6, 0.0092043394));

N873_4 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i > NULL), N873_5, -0.015421626));

N873_3 :=__common__( map(trim(C_CHILD) = ''              => N873_4,
              ((real)c_child < 33.3499984741) => -0.00026749243,
                                                 N873_4));

N873_2 :=__common__( if(((real)c_inc_25k_p < 26.3499984741), N873_3, N873_8));

N873_1 :=__common__( if(trim(C_INC_25K_P) != '', N873_2, 0.0010527188));

N874_7 :=__common__( map(trim(C_MED_RENT) = ''      => 0.010740502,
              ((real)c_med_rent < 444.5) => 0.00074548429,
                                            0.010740502));

N874_6 :=__common__( map(trim(C_FOOD) = ''              => -0.0055102108,
              ((real)c_food < 32.6999969482) => N874_7,
                                                -0.0055102108));

N874_5 :=__common__( map(trim(C_MED_HVAL) = ''          => -0.0014213691,
              ((integer)c_med_hval < 124451) => -0.0095929448,
                                                -0.0014213691));

N874_4 :=__common__( map(trim(C_VACANT_P) = ''              => 2.9693444e-005,
              ((real)c_vacant_p < 5.85000038147) => N874_5,
                                                    2.9693444e-005));

N874_3 :=__common__( map(trim(C_FAMOTF18_P) = ''      => N874_6,
              ((real)c_famotf18_p < 52.25) => N874_4,
                                              N874_6));

N874_2 :=__common__( if(((real)c_rest_indx < 170.5), N874_3, 0.0066822153));

N874_1 :=__common__( if(trim(C_REST_INDX) != '', N874_2, -0.00055740442));

N875_8 :=__common__( map(trim(C_EXP_PROD) = ''     => -0.00012038723,
              ((real)c_exp_prod < 69.5) => -0.0036159895,
                                           -0.00012038723));

N875_7 :=__common__( map(trim(C_RAPE) = ''       => 0.013246443,
              ((integer)c_rape < 115) => 0.0026857295,
                                         0.013246443));

N875_6 :=__common__( map(((real)f_srchphonesrchcount_i <= NULL) => -0.0033932691,
              ((real)f_srchphonesrchcount_i < 2.5)   => N875_7,
                                                        -0.0033932691));

N875_5 :=__common__( if(((real)f_rel_criminal_count_i < 1.5), -0.0053247248, N875_6));

N875_4 :=__common__( if(((real)f_rel_criminal_count_i > NULL), N875_5, 0.020933613));

N875_3 :=__common__( map(trim(C_POP_65_74_P) = ''              => N875_8,
              ((real)c_pop_65_74_p < 2.15000009537) => N875_4,
                                                       N875_8));

N875_2 :=__common__( if(((real)c_pop_18_24_p < 9.75), 0.0013067766, N875_3));

N875_1 :=__common__( if(trim(C_POP_18_24_P) != '', N875_2, 0.0029081093));

N876_8 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)          => 0.00072556454,
              ((real)f_add_input_nhood_sfd_pct_d < 0.789111256599) => 0.012989699,
                                                                      0.00072556454));

N876_7 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)    => N876_8,
              ((integer)f_prevaddrmedianvalue_d < 88702) => -0.0017061041,
                                                            N876_8));

N876_6 :=__common__( map(trim(C_FOR_SALE) = ''      => -0.0036806352,
              ((real)c_for_sale < 140.5) => 0.0082248417,
                                            -0.0036806352));

N876_5 :=__common__( map(trim(C_HVAL_40K_P) = ''              => -0.0051201143,
              ((real)c_hval_40k_p < 26.6500015259) => -0.00010255237,
                                                      -0.0051201143));

N876_4 :=__common__( map(((real)f_inq_dobs_per_ssn_i <= NULL) => N876_6,
              ((real)f_inq_dobs_per_ssn_i < 1.5)   => N876_5,
                                                      N876_6));

N876_3 :=__common__( if(trim(C_LOWRENT) != '', N876_4, -0.0048795587));

N876_2 :=__common__( if(((real)f_util_adl_count_n < 11.5), N876_3, N876_7));

N876_1 :=__common__( if(((real)f_util_adl_count_n > NULL), N876_2, 0.0076016933));

N877_8 :=__common__( map(trim(C_HH5_P) = ''              => 0.0049093716,
              ((real)c_hh5_p < 13.5500001907) => -0.0048614702,
                                                 0.0049093716));

N877_7 :=__common__( map(trim(C_NEW_HOMES) = ''     => 0.0074941423,
              ((real)c_new_homes < 93.5) => -0.0027412179,
                                            0.0074941423));

N877_6 :=__common__( if(((real)c_easiqlife < 93.5), N877_7, N877_8));

N877_5 :=__common__( if(trim(C_EASIQLIFE) != '', N877_6, -0.0030311048));

N877_4 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => -0.0030899186,
              ((real)f_mos_inq_banko_om_lseen_d < 17.5)  => 0.0024473847,
                                                            -0.0030899186));

N877_3 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => 0.0015060771,
              ((real)c_hist_addr_match_i < 1.5)   => N877_4,
                                                     0.0015060771));

N877_2 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 6.5), N877_3, N877_5));

N877_1 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N877_2, 0.0015720293));

N878_9 :=__common__( map(trim(C_RETIRED2) = ''      => -0.0075394604,
              ((real)c_retired2 < 114.5) => 0.00030173149,
                                            -0.0075394604));

N878_8 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => 0.0070988582,
              ((real)r_c14_addrs_15yr_i < 14.5)  => N878_9,
                                                    0.0070988582));

N878_7 :=__common__( map(trim(C_POP_35_44_P) = ''              => N878_8,
              ((real)c_pop_35_44_p < 10.5500001907) => 0.0048836727,
                                                       N878_8));

N878_6 :=__common__( map(((real)f_inq_highriskcredit_count24_i <= NULL) => -0.0045035619,
              ((real)f_inq_highriskcredit_count24_i < 3.5)   => N878_7,
                                                                -0.0045035619));

N878_5 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), 0.00072048403, N878_6));

N878_4 :=__common__( map(((real)c_mos_since_impulse_ls_d <= NULL) => N878_5,
              ((real)c_mos_since_impulse_ls_d < 29.5)  => -0.0057785677,
                                                          N878_5));

N878_3 :=__common__( if(((real)c_unemp < 2.04999995232), -0.0055091636, N878_4));

N878_2 :=__common__( if(trim(C_UNEMP) != '', N878_3, 0.001273255));

N878_1 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N878_2, -0.0014839997));

N879_9 :=__common__( if(((real)c_born_usa < 99.5), -0.0089311955, 0.00054805518));

N879_8 :=__common__( if(trim(C_BORN_USA) != '', N879_9, -0.0043117349));

N879_7 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => -0.0081141091,
              ((real)f_curraddrcartheftindex_i < 190.5) => 0.0012912214,
                                                           -0.0081141091));

N879_6 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.0064367273,
              ((real)r_d32_criminal_count_i < 4.5)   => N879_7,
                                                        0.0064367273));

N879_5 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => N879_6,
              ((real)f_curraddrmedianincome_d < 15815.5) => 0.010752322,
                                                            N879_6));

N879_4 :=__common__( if(((real)c_med_age < 28.4500007629), N879_5, -0.00038546115));

N879_3 :=__common__( if(trim(C_MED_AGE) != '', N879_4, 0.00021734396));

N879_2 :=__common__( if(((integer)c_dist_input_to_prev_addr_i < 892), N879_3, N879_8));

N879_1 :=__common__( if(((real)c_dist_input_to_prev_addr_i > NULL), N879_2, 0.00036938181));

N880_9 :=__common__( map(trim(C_FINANCE) = ''               => -0.00022080327,
              ((real)c_finance < 0.350000023842) => 0.010391007,
                                                    -0.00022080327));

N880_8 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => N880_9,
              ((real)f_curraddrburglaryindex_i < 94.5)  => -0.0065012087,
                                                           N880_9));

N880_7 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0200716946274), -0.006692249, 0.006415406));

N880_6 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N880_7, 0.003562008));

N880_5 :=__common__( map(trim(C_OLDHOUSE) = ''              => -0.0051817662,
              ((real)c_oldhouse < 99.8500061035) => N880_6,
                                                    -0.0051817662));

N880_4 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.442882657051), N880_5, N880_8));

N880_3 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N880_4, -0.00099146111));

N880_2 :=__common__( if(((real)c_health < 13.9499998093), 0.00078744003, N880_3));

N880_1 :=__common__( if(trim(C_HEALTH) != '', N880_2, -0.0036528501));

N881_8 :=__common__( map(trim(C_POP_65_74_P) = ''              => 0.0017215645,
              ((real)c_pop_65_74_p < 6.64999961853) => -0.0058543158,
                                                       0.0017215645));

N881_7 :=__common__( map(((real)f_corrrisktype_i <= NULL) => 0.0040842106,
              ((real)f_corrrisktype_i < 7.5)   => N881_8,
                                                  0.0040842106));

N881_6 :=__common__( map(trim(C_FOOD) = ''      => N881_7,
              ((real)c_food < 44.75) => 0.0065543478,
                                        N881_7));

N881_5 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)    => N881_6,
              ((integer)f_curraddrmedianvalue_d < 55426) => 0.0094818671,
                                                            N881_6));

N881_4 :=__common__( if(((real)c_food < 37.8499984741), -0.00093187464, N881_5));

N881_3 :=__common__( if(trim(C_FOOD) != '', N881_4, -0.00078280688));

N881_2 :=__common__( if(((real)f_rel_count_i < 2.5), 0.0053387668, N881_3));

N881_1 :=__common__( if(((real)f_rel_count_i > NULL), N881_2, -0.0042566536));

N882_8 :=__common__( map(trim(C_RETAIL) = ''              => -0.00053207651,
              ((real)c_retail < 3.84999990463) => 0.010576571,
                                                  -0.00053207651));

N882_7 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => -0.0087975144,
              ((real)f_srchfraudsrchcount_i < 35.5)  => -0.00055293754,
                                                        -0.0087975144));

N882_6 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => 0.0065002787,
              ((real)f_srchfraudsrchcount_i < 47.5)  => N882_7,
                                                        0.0065002787));

N882_5 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => N882_8,
              ((real)r_c14_addrs_15yr_i < 18.5)  => N882_6,
                                                    N882_8));

N882_4 :=__common__( if(((real)c_wholesale < 19.6500015259), N882_5, 0.0060011609));

N882_3 :=__common__( if(trim(C_WHOLESALE) != '', N882_4, -0.0040947093));

N882_2 :=__common__( if(((real)r_i61_inq_collection_count12_i < 2.5), N882_3, 0.0071110686));

N882_1 :=__common__( if(((real)r_i61_inq_collection_count12_i > NULL), N882_2, 0.016279585));

N883_8 :=__common__( map(trim(C_SPAN_LANG) = ''      => -0.0079624578,
              ((real)c_span_lang < 151.5) => 7.1556559e-005,
                                             -0.0079624578));

N883_7 :=__common__( map(trim(C_HVAL_200K_P) = ''              => N883_8,
              ((real)c_hval_200k_p < 7.64999961853) => 0.0022154981,
                                                       N883_8));

N883_6 :=__common__( map(((real)r_d32_mos_since_fel_ls_d <= NULL) => -0.002087477,
              ((real)r_d32_mos_since_fel_ls_d < 190.5) => -0.0087336024,
                                                          -0.002087477));

N883_5 :=__common__( map(trim(C_BUSINESS) = ''    => -0.00033846904,
              ((real)c_business < 0.5) => 0.008109827,
                                          -0.00033846904));

N883_4 :=__common__( if(((real)f_rel_ageover30_count_d < 7.5), N883_5, N883_6));

N883_3 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N883_4, -0.001537097));

N883_2 :=__common__( if(((integer)c_totsales < 3263), N883_3, N883_7));

N883_1 :=__common__( if(trim(C_TOTSALES) != '', N883_2, 0.0010373698));

N884_8 :=__common__( map(trim(C_FAMMAR18_P) = ''              => 0.0065264251,
              ((real)c_fammar18_p < 53.1500015259) => -3.0133537e-005,
                                                      0.0065264251));

N884_7 :=__common__( map(trim(C_UNEMPL) = ''      => 0.0058102766,
              ((real)c_unempl < 193.5) => N884_8,
                                          0.0058102766));

N884_6 :=__common__( map(trim(C_FAMILIES) = ''      => N884_7,
              ((real)c_families < 130.5) => -0.0047500716,
                                            N884_7));

N884_5 :=__common__( if(((real)f_rel_educationover12_count_d < 0.5), -0.0061351073, N884_6));

N884_4 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N884_5, 0.0033526226));

N884_3 :=__common__( map(trim(C_POP_18_24_P) = ''              => 0.005728421,
              ((real)c_pop_18_24_p < 22.0499992371) => N884_4,
                                                       0.005728421));

N884_2 :=__common__( if(((real)c_pop_45_54_p < 5.05000019073), -0.0054479963, N884_3));

N884_1 :=__common__( if(trim(C_POP_45_54_P) != '', N884_2, 0.0018187303));

N885_8 :=__common__( map(((real)f_prevaddrlenofres_d <= NULL) => -0.0004859969,
              ((real)f_prevaddrlenofres_d < 1.5)   => -0.0066772973,
                                                      -0.0004859969));

N885_7 :=__common__( map(((real)f_divsrchaddrsuspidcount_i <= NULL) => -0.0042064126,
              ((real)f_divsrchaddrsuspidcount_i < 0.5)   => 0.0054262442,
                                                            -0.0042064126));

N885_6 :=__common__( map(trim(C_EXP_PROD) = ''     => -0.0087742983,
              ((real)c_exp_prod < 56.5) => 0.002646217,
                                           -0.0087742983));

N885_5 :=__common__( map(trim(C_FAMMAR_P) = ''              => N885_7,
              ((real)c_fammar_p < 57.4500007629) => N885_6,
                                                    N885_7));

N885_4 :=__common__( if(((real)c_hval_80k_p < 22.25), N885_5, 0.0092552412));

N885_3 :=__common__( if(trim(C_HVAL_80K_P) != '', N885_4, 0.0013565517));

N885_2 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i < 63.5), N885_3, N885_8));

N885_1 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i > NULL), N885_2, -0.00093182338));

N886_9 :=__common__( if(((integer)f_curraddrmedianincome_d < 60265), 0.00081302751, 0.0075440494));

N886_8 :=__common__( if(((real)f_curraddrmedianincome_d > NULL), N886_9, 0.0027044993));

N886_7 :=__common__( map(trim(C_HIGHINC) = ''     => 0.0092437135,
              ((real)c_highinc < 3.75) => -0.0045292006,
                                          0.0092437135));

N886_6 :=__common__( map(trim(C_EMPLOYEES) = ''     => -0.0058106892,
              ((real)c_employees < 70.5) => N886_7,
                                            -0.0058106892));

N886_5 :=__common__( if(((real)r_c13_max_lres_d < 51.5), N886_6, 0.00038163916));

N886_4 :=__common__( if(((real)r_c13_max_lres_d > NULL), N886_5, -0.006149805));

N886_3 :=__common__( map(trim(C_HVAL_150K_P) = ''      => N886_8,
              ((real)c_hval_150k_p < 10.25) => N886_4,
                                               N886_8));

N886_2 :=__common__( if(((real)c_pop_6_11_p < 15.4499998093), N886_3, -0.0071815905));

N886_1 :=__common__( if(trim(C_POP_6_11_P) != '', N886_2, 0.00028268787));

N887_8 :=__common__( map(trim(C_ROBBERY) = ''     => -0.0055297685,
              ((real)c_robbery < 61.5) => 0.00337449,
                                          -0.0055297685));

N887_7 :=__common__( map(trim(C_RETAIL) = ''              => 0.0069789223,
              ((real)c_retail < 33.0499992371) => 0.00052903089,
                                                  0.0069789223));

N887_6 :=__common__( map(trim(C_INC_75K_P) = ''              => N887_8,
              ((real)c_inc_75k_p < 22.5499992371) => N887_7,
                                                     N887_8));

N887_5 :=__common__( map(trim(C_CHILD) = ''              => -0.0042511326,
              ((real)c_child < 29.9500007629) => N887_6,
                                                 -0.0042511326));

N887_4 :=__common__( map(trim(C_MED_AGE) = ''      => N887_5,
              ((real)c_med_age < 29.75) => 0.0029737627,
                                           N887_5));

N887_3 :=__common__( map(trim(C_RETIRED) = ''              => N887_4,
              ((real)c_retired < 4.14999961853) => -0.002769118,
                                                   N887_4));

N887_2 :=__common__( if(((real)r_c13_max_lres_d > NULL), N887_3, 0.0026441006));

N887_1 :=__common__( if(trim(C_RETIRED) != '', N887_2, -0.0017611883));

N888_10 :=__common__( if(((real)c_hh4_p < 3.65000009537), -0.010706047, -0.0014239527));

N888_9 :=__common__( if(trim(C_HH4_P) != '', N888_10, 0.00082075925));

N888_8 :=__common__( if(((real)c_lux_prod < 139.5), 0.0017122988, 0.012124608));

N888_7 :=__common__( if(trim(C_LUX_PROD) != '', N888_8, -0.011814363));

N888_6 :=__common__( map(trim(C_INC_75K_P) = ''              => -0.0040729716,
              ((real)c_inc_75k_p < 10.8500003815) => 0.0059016068,
                                                     -0.0040729716));

N888_5 :=__common__( if(((real)c_hval_400k_p < 1.04999995232), 0.00070348338, N888_6));

N888_4 :=__common__( if(trim(C_HVAL_400K_P) != '', N888_5, -0.00080835371));

N888_3 :=__common__( map(((real)f_prevaddroccupantowned_d <= NULL) => N888_7,
              ((real)f_prevaddroccupantowned_d < 0.5)   => N888_4,
                                                           N888_7));

N888_2 :=__common__( if(((real)r_i60_inq_count12_i < 5.5), N888_3, N888_9));

N888_1 :=__common__( if(((real)r_i60_inq_count12_i > NULL), N888_2, -0.0040730502));

N889_9 :=__common__( map(trim(C_NO_TEENS) = ''     => 0.00076881183,
              ((real)c_no_teens < 52.5) => 0.011628054,
                                           0.00076881183));

N889_8 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N889_9, 0.0075800801));

N889_7 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.0062620691,
              (segment in ['KMART', 'SEARS FLS'])                => N889_8,
                                                                    -0.0062620691));

N889_6 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL) => N889_7,
              ((real)r_a50_pb_total_dollars_d < 31.5)  => -0.00326644,
                                                          N889_7));

N889_5 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 116.5), -0.0014056145, N889_6));

N889_4 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N889_5, -0.0065394606));

N889_3 :=__common__( map(trim(C_RNT500_P) = ''              => -0.00020862073,
              ((real)c_rnt500_p < 25.1500015259) => N889_4,
                                                    -0.00020862073));

N889_2 :=__common__( if(((real)c_rnt500_p < 9.05000019073), -0.0017136289, N889_3));

N889_1 :=__common__( if(trim(C_RNT500_P) != '', N889_2, 0.00030902397));

N890_8 :=__common__( map(trim(C_PRESCHL) = ''     => 0.0033115081,
              ((real)c_preschl < 94.5) => -0.0066681653,
                                          0.0033115081));

N890_7 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => N890_8,
              ((real)r_d32_mos_since_crim_ls_d < 72.5)  => 0.0089835397,
                                                           N890_8));

N890_6 :=__common__( map(trim(C_FOOD) = ''     => -0.0023551351,
              ((real)c_food < 9.75) => N890_7,
                                       -0.0023551351));

N890_5 :=__common__( map(trim(C_INCOLLEGE) = ''              => -0.0097045532,
              ((real)c_incollege < 4.14999961853) => 9.1050613e-005,
                                                     -0.0097045532));

N890_4 :=__common__( if(((real)c_many_cars < 34.5), N890_5, N890_6));

N890_3 :=__common__( if(trim(C_MANY_CARS) != '', N890_4, 0.0039567364));

N890_2 :=__common__( if(((integer)f_estimated_income_d < 30500), N890_3, 0.0009652031));

N890_1 :=__common__( if(((real)f_estimated_income_d > NULL), N890_2, 0.0019445202));

N891_8 :=__common__( map(trim(C_MED_AGE) = ''              => 0.00014831473,
              ((real)c_med_age < 32.6500015259) => 0.0080787644,
                                                   0.00014831473));

N891_7 :=__common__( if(((real)c_addr_lres_6mo_ct_i < 7.5), N891_8, 0.010496386));

N891_6 :=__common__( if(((real)c_addr_lres_6mo_ct_i > NULL), N891_7, 0.015512468));

N891_5 :=__common__( map(trim(C_FAMMAR_P) = ''      => -0.00055848517,
              ((real)c_fammar_p < 31.25) => 0.0065883843,
                                            -0.00055848517));

N891_4 :=__common__( map(trim(C_FAMMAR_P) = ''              => N891_5,
              ((real)c_fammar_p < 26.5499992371) => -0.0038519483,
                                                    N891_5));

N891_3 :=__common__( map(trim(C_POP_45_54_P) = ''              => N891_6,
              ((real)c_pop_45_54_p < 17.8499984741) => N891_4,
                                                       N891_6));

N891_2 :=__common__( if(((real)c_unattach < 82.5), -0.0037165848, N891_3));

N891_1 :=__common__( if(trim(C_UNATTACH) != '', N891_2, -0.0012861397));

N892_9 :=__common__( map(trim(C_SPAN_LANG) = ''     => -0.00066612138,
              ((real)c_span_lang < 64.5) => 0.010383033,
                                            -0.00066612138));

N892_8 :=__common__( map(trim(C_CONSTRUCTION) = ''              => -0.0055330517,
              ((real)c_construction < 4.44999980927) => 0.0060566942,
                                                        -0.0055330517));

N892_7 :=__common__( if(((integer)f_addrchangeincomediff_d < 10823), -0.004317404, 0.00447301));

N892_6 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N892_7, N892_8));

N892_5 :=__common__( map(trim(C_RNT750_P) = ''               => -0.0045461835,
              ((real)c_rnt750_p < 0.449999988079) => 0.0035398741,
                                                     -0.0045461835));

N892_4 :=__common__( map(trim(C_HH2_P) = ''              => N892_5,
              ((real)c_hh2_p < 38.3499984741) => 8.7216614e-005,
                                                 N892_5));

N892_3 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N892_4, N892_6));

N892_2 :=__common__( if(((real)c_rape < 195.5), N892_3, N892_9));

N892_1 :=__common__( if(trim(C_RAPE) != '', N892_2, 0.00057820769));

N893_8 :=__common__( map(trim(C_RICH_FAM) = ''     => -0.0035246906,
              ((real)c_rich_fam < 97.5) => 0.0074871772,
                                           -0.0035246906));

N893_7 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d < 72.5), N893_8, -0.0034742867));

N893_6 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N893_7, -0.011930873));

N893_5 :=__common__( map(trim(C_HH6_P) = ''     => -0.010154571,
              ((real)c_hh6_p < 7.25) => N893_6,
                                        -0.010154571));

N893_4 :=__common__( map(((real)r_phn_pcs_n <= NULL) => N893_5,
              ((real)r_phn_pcs_n < 0.5)   => 0.00050648978,
                                             N893_5));

N893_3 :=__common__( map(trim(C_FAMILIES) = ''      => N893_4,
              ((real)c_families < 125.5) => -0.005586523,
                                            N893_4));

N893_2 :=__common__( if(((real)c_rentocc_p < 3.54999995232), 0.0089217542, N893_3));

N893_1 :=__common__( if(trim(C_RENTOCC_P) != '', N893_2, -0.00126167));

N894_10 :=__common__( map(trim(C_HVAL_400K_P) = ''              => -0.0049870917,
               ((real)c_hval_400k_p < 5.44999980927) => 0.0047784165,
                                                        -0.0049870917));

N894_9 :=__common__( if(((real)c_bel_edu < 118.5), N894_10, -0.0026355512));

N894_8 :=__common__( if(trim(C_BEL_EDU) != '', N894_9, -0.01355864));

N894_7 :=__common__( if(((real)c_inc_125k_p < 12.1499996185), 0.001549015, 0.010041236));

N894_6 :=__common__( if(trim(C_INC_125K_P) != '', N894_7, 0.0051976021));

N894_5 :=__common__( map(((real)f_current_count_d <= NULL) => N894_8,
              ((real)f_current_count_d < 1.5)   => N894_6,
                                                   N894_8));

N894_4 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0395222976804), -0.0050603394, 0.001812789));

N894_3 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N894_4, -0.00052130049));

N894_2 :=__common__( if(((real)f_curraddrburglaryindex_i < 73.5), N894_3, N894_5));

N894_1 :=__common__( if(((real)f_curraddrburglaryindex_i > NULL), N894_2, -0.0018975253));

N895_8 :=__common__( map(trim(C_HVAL_40K_P) = ''              => -0.0092157815,
              ((real)c_hval_40k_p < 5.05000019073) => -0.00062493584,
                                                      -0.0092157815));

N895_7 :=__common__( map(trim(C_POP_25_34_P) = ''      => 0.014336209,
              ((real)c_pop_25_34_p < 16.25) => 0.0053665184,
                                               0.014336209));

N895_6 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => N895_7,
              ((real)r_d30_derog_count_i < 1.5)   => -0.0017200946,
                                                     N895_7));

N895_5 :=__common__( map(((real)f_mos_acc_lseen_d <= NULL) => N895_6,
              ((real)f_mos_acc_lseen_d < 102.5) => -0.0051467457,
                                                   N895_6));

N895_4 :=__common__( map(trim(C_HEALTH) = ''              => -0.0031730249,
              ((real)c_health < 15.4499998093) => N895_5,
                                                  -0.0031730249));

N895_3 :=__common__( if(((real)c_child < 29.8499984741), N895_4, N895_8));

N895_2 :=__common__( if(trim(C_CHILD) != '', N895_3, -0.0039978081));

N895_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N895_2, -2.4097683e-005));

N896_9 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => 0.0061864094,
              ((real)f_mos_inq_banko_om_lseen_d < 19.5)  => -0.002452374,
                                                            0.0061864094));

N896_8 :=__common__( map(trim(C_TRAILER_P) = ''              => -0.0041050437,
              ((real)c_trailer_p < 5.14999961853) => N896_9,
                                                     -0.0041050437));

N896_7 :=__common__( if(((real)r_c13_curr_addr_lres_d < 90.5), -0.00020774613, -0.0080282401));

N896_6 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N896_7, -0.029899083));

N896_5 :=__common__( map(trim(C_HVAL_500K_P) = ''               => -0.0066247234,
              ((real)c_hval_500k_p < 0.949999988079) => N896_6,
                                                        -0.0066247234));

N896_4 :=__common__( if(((real)c_for_sale < 141.5), N896_5, N896_8));

N896_3 :=__common__( if(trim(C_FOR_SALE) != '', N896_4, -0.00040487117));

N896_2 :=__common__( if(((real)f_m_bureau_adl_fs_all_d < 175.5), N896_3, 0.0010240561));

N896_1 :=__common__( if(((real)f_m_bureau_adl_fs_all_d > NULL), N896_2, -0.0041651569));

N897_7 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => 0.010467093,
              ((real)r_l79_adls_per_addr_curr_i < 28.5)  => 0.0010097329,
                                                            0.010467093));

N897_6 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => -0.0018358813,
              ((real)r_d32_mos_since_crim_ls_d < 210.5) => N897_7,
                                                           -0.0018358813));

N897_5 :=__common__( map(((real)f_srchunvrfdaddrcount_i <= NULL) => 0.008612339,
              ((real)f_srchunvrfdaddrcount_i < 0.5)   => N897_6,
                                                         0.008612339));

N897_4 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL)  => -0.0063004957,
              ((integer)f_curraddrcrimeindex_i < 114) => 0.006865374,
                                                         -0.0063004957));

N897_3 :=__common__( map(((real)r_l79_adls_per_addr_c6_i <= NULL) => N897_4,
              ((real)r_l79_adls_per_addr_c6_i < 0.5)   => -0.011958998,
                                                          N897_4));

N897_2 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => N897_5,
              ((real)f_mos_inq_banko_cm_lseen_d < 21.5)  => N897_3,
                                                            N897_5));

N897_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N897_2, 0.00025014968));

N898_9 :=__common__( map(trim(C_EXP_HOMES) = ''      => -0.0043909643,
              ((real)c_exp_homes < 156.5) => 0.0047455421,
                                             -0.0043909643));

N898_8 :=__common__( if(((real)r_f00_dob_score_d > NULL), N898_9, 0.018158369));

N898_7 :=__common__( map(trim(C_MORT_INDX) = ''      => -0.0042878199,
              ((real)c_mort_indx < 134.5) => N898_8,
                                             -0.0042878199));

N898_6 :=__common__( if(((real)c_rentocc_p < 31.75), N898_7, -6.6708546e-005));

N898_5 :=__common__( if(trim(C_RENTOCC_P) != '', N898_6, -0.00088148221));

N898_4 :=__common__( if(((real)c_femdiv_p < 1.65000009537), 0.0047323511, -0.0018435948));

N898_3 :=__common__( if(trim(C_FEMDIV_P) != '', N898_4, -0.0032075318));

N898_2 :=__common__( if(((real)r_c13_max_lres_d < 76.5), N898_3, N898_5));

N898_1 :=__common__( if(((real)r_c13_max_lres_d > NULL), N898_2, 0.0045664176));

N899_8 :=__common__( map(trim(C_RENTAL) = ''      => 0.0014220004,
              ((real)c_rental < 159.5) => -0.0096490181,
                                          0.0014220004));

N899_7 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => 0.0074678969,
              ((real)f_m_bureau_adl_fs_all_d < 80.5)  => -0.00022399358,
                                                         0.0074678969));

N899_6 :=__common__( if(((real)c_unique_addr_count_i < 3.5), N899_7, -0.00034731148));

N899_5 :=__common__( if(((real)c_unique_addr_count_i > NULL), N899_6, -0.0053127771));

N899_4 :=__common__( map(trim(C_INC_15K_P) = ''              => -0.0056390566,
              ((real)c_inc_15k_p < 44.1500015259) => N899_5,
                                                     -0.0056390566));

N899_3 :=__common__( map(trim(C_RAPE) = ''      => 0.0055657306,
              ((real)c_rape < 195.5) => N899_4,
                                        0.0055657306));

N899_2 :=__common__( if(((real)c_low_ed < 82.0500030518), N899_3, N899_8));

N899_1 :=__common__( if(trim(C_LOW_ED) != '', N899_2, -0.0012313777));

N900_9 :=__common__( map(trim(C_INCOLLEGE) = ''              => -0.0039659782,
              ((real)c_incollege < 9.55000019073) => 0.0066199276,
                                                     -0.0039659782));

N900_8 :=__common__( map(((real)f_corrssnnamecount_d <= NULL) => N900_9,
              ((real)f_corrssnnamecount_d < 3.5)   => -0.0041373908,
                                                      N900_9));

N900_7 :=__common__( if(((real)c_totsales < 28312.5), -0.00096018183, N900_8));

N900_6 :=__common__( if(trim(C_TOTSALES) != '', N900_7, 0.0068329619));

N900_5 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), 0.0099729982, -0.0015319905));

N900_4 :=__common__( if(((real)c_no_teens < 129.5), N900_5, 0.011656638));

N900_3 :=__common__( if(trim(C_NO_TEENS) != '', N900_4, 0.00096770197));

N900_2 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.000954199349508), N900_3, N900_6));

N900_1 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N900_2, -0.032714922));

N901_8 :=__common__( map(trim(C_FINANCE) = ''              => 0.0059578758,
              ((real)c_finance < 10.8500003815) => -0.0034883562,
                                                   0.0059578758));

N901_7 :=__common__( map(trim(C_HIGHINC) = ''              => 0.0082293898,
              ((real)c_highinc < 15.6499996185) => -8.022673e-005,
                                                   0.0082293898));

N901_6 :=__common__( map(trim(C_WHITE_COL) = ''      => N901_8,
              ((real)c_white_col < 36.25) => N901_7,
                                             N901_8));

N901_5 :=__common__( map(((real)f_assocsuspicousidcount_i <= NULL) => -0.0050359235,
              ((real)f_assocsuspicousidcount_i < 3.5)   => 0.0056862116,
                                                           -0.0050359235));

N901_4 :=__common__( map(((real)f_mos_liens_unrel_cj_lseen_d <= NULL) => N901_5,
              ((real)f_mos_liens_unrel_cj_lseen_d < 83.5)  => 0.011311455,
                                                              N901_5));

N901_3 :=__common__( if(((real)c_bel_edu < 38.5), N901_4, N901_6));

N901_2 :=__common__( if(trim(C_BEL_EDU) != '', N901_3, 0.0076882459));

N901_1 :=__common__( if(((real)f_crim_rel_under100miles_cnt_i > NULL), N901_2, 0.0011252896));

N902_9 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)   => -0.0006117882,
              ((real)f_curraddrmedianvalue_d < 77835.5) => -0.0099865465,
                                                           -0.0006117882));

N902_8 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d < 0.958147644997), 0.0019135959, N902_9));

N902_7 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d > NULL), N902_8, -0.03735989));

N902_6 :=__common__( map(trim(C_SERV_EMPL) = ''      => -0.013974131,
              ((real)c_serv_empl < 126.5) => -0.0018472661,
                                             -0.013974131));

N902_5 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => -0.0012450943,
              ((real)r_d32_mos_since_crim_ls_d < 28.5)  => 0.0039175215,
                                                           -0.0012450943));

N902_4 :=__common__( if(((real)c_med_age < 45.0499992371), N902_5, N902_6));

N902_3 :=__common__( if(trim(C_MED_AGE) != '', N902_4, -0.00086253225));

N902_2 :=__common__( if(((real)r_c14_addrs_5yr_i < 3.5), N902_3, N902_7));

N902_1 :=__common__( if(((real)r_c14_addrs_5yr_i > NULL), N902_2, 0.0083562429));

N903_9 :=__common__( map(trim(C_HH3_P) = ''              => -0.0095668427,
              ((real)c_hh3_p < 19.5499992371) => 0.00087298409,
                                                 -0.0095668427));

N903_8 :=__common__( map(trim(C_RENTOCC_P) = ''              => 0.0086099998,
              ((real)c_rentocc_p < 17.6500015259) => 0.00023707941,
                                                     0.0086099998));

N903_7 :=__common__( if(((real)c_lowinc < 40.75), N903_8, N903_9));

N903_6 :=__common__( if(trim(C_LOWINC) != '', N903_7, -0.0010620441));

N903_5 :=__common__( map(trim(C_HVAL_125K_P) = ''              => 0.009121873,
              ((real)c_hval_125k_p < 31.5499992371) => -0.0018612201,
                                                       0.009121873));

N903_4 :=__common__( if(((real)c_hhsize < 2.625), N903_5, 0.0032821343));

N903_3 :=__common__( if(trim(C_HHSIZE) != '', N903_4, 0.0056272672));

N903_2 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.134648561478), -0.0015592848, N903_3));

N903_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N903_2, N903_6));

N904_9 :=__common__( map(trim(C_FAMMAR18_P) = ''              => -0.0052561919,
              ((real)c_fammar18_p < 36.1500015259) => 0.0051971214,
                                                      -0.0052561919));

N904_8 :=__common__( map(trim(C_FAMILIES) = ''      => N904_9,
              ((real)c_families < 315.5) => -0.0040858298,
                                            N904_9));

N904_7 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.256242275238), -0.0088358595, N904_8));

N904_6 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N904_7, -0.018195628));

N904_5 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N904_6,
              ((real)c_hist_addr_match_i < 18.5)  => 0.00065533724,
                                                     N904_6));

N904_4 :=__common__( map(trim(C_RELIG_INDX) = ''      => -0.010979926,
              ((real)c_relig_indx < 111.5) => 0.0015765177,
                                              -0.010979926));

N904_3 :=__common__( if(((real)f_mos_liens_unrel_lt_fseen_d < 40.5), N904_4, N904_5));

N904_2 :=__common__( if(((real)f_mos_liens_unrel_lt_fseen_d > NULL), N904_3, -0.0016345985));

N904_1 :=__common__( if(trim(C_INC_75K_P) != '', N904_2, 0.0026450508));

N905_9 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 170.5), 0.011628334, 0.0011010516));

N905_8 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N905_9, 0.016140603));

N905_7 :=__common__( map(((real)f_mos_liens_unrel_ot_lseen_d <= NULL) => -7.3196027e-005,
              ((real)f_mos_liens_unrel_ot_lseen_d < 110.5) => -0.0054146774,
                                                              -7.3196027e-005));

N905_6 :=__common__( if(((real)r_c20_email_count_i < 12.5), N905_7, 0.0079673585));

N905_5 :=__common__( if(((real)r_c20_email_count_i > NULL), N905_6, 0.0022474176));

N905_4 :=__common__( map(trim(C_OLDHOUSE) = ''              => N905_5,
              ((real)c_oldhouse < 4.14999961853) => 0.0076899982,
                                                    N905_5));

N905_3 :=__common__( map(((real)f_recent_disconnects_i <= NULL) => N905_8,
              ((real)f_recent_disconnects_i < 0.5)   => N905_4,
                                                        N905_8));

N905_2 :=__common__( if(((real)c_pop_55_64_p < 2.65000009537), 0.0071369809, N905_3));

N905_1 :=__common__( if(trim(C_POP_55_64_P) != '', N905_2, 0.001728583));

N906_9 :=__common__( map(trim(C_UNEMP) = ''              => -0.0049767094,
              ((real)c_unemp < 12.5500001907) => 0.0036949355,
                                                 -0.0049767094));

N906_8 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => N906_9,
              ((real)r_l79_adls_per_addr_curr_i < 18.5)  => -0.00037518372,
                                                            N906_9));

N906_7 :=__common__( map(trim(C_MED_HVAL) = ''          => 0.0057027872,
              ((integer)c_med_hval < 319808) => N906_8,
                                                0.0057027872));

N906_6 :=__common__( if(((real)c_pop_35_44_p < 23.5499992371), N906_7, -0.0065691123));

N906_5 :=__common__( if(trim(C_POP_35_44_P) != '', N906_6, -0.00044231248));

N906_4 :=__common__( if(((integer)c_med_hval < 102260), 0.00097782983, -0.0064410362));

N906_3 :=__common__( if(trim(C_MED_HVAL) != '', N906_4, -0.0066223404));

N906_2 :=__common__( if(((real)r_c14_addrs_15yr_i < 3.5), N906_3, N906_5));

N906_1 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N906_2, -0.005078659));

N907_8 :=__common__( map(trim(C_PROFESSIONAL) = ''               => 0.0014120996,
              ((real)c_professional < 0.949999988079) => 0.0082372855,
                                                         0.0014120996));

N907_7 :=__common__( map(trim(C_SUB_BUS) = ''      => -0.0013757463,
              ((real)c_sub_bus < 137.5) => N907_8,
                                           -0.0013757463));

N907_6 :=__common__( map(trim(C_BEL_EDU) = ''      => -0.0014092246,
              ((real)c_bel_edu < 154.5) => N907_7,
                                           -0.0014092246));

N907_5 :=__common__( map(trim(C_MURDERS) = ''       => N907_6,
              ((integer)c_murders < 103) => -0.0045856785,
                                            N907_6));

N907_4 :=__common__( map(trim(C_HVAL_80K_P) = ''              => N907_5,
              ((real)c_hval_80k_p < 3.65000009537) => 0.0048634886,
                                                      N907_5));

N907_3 :=__common__( if(((real)c_born_usa < 119.5), -0.0010602151, N907_4));

N907_2 :=__common__( if(trim(C_BORN_USA) != '', N907_3, 0.0017319833));

N907_1 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N907_2, 0.0012833377));

N908_8 :=__common__( map(trim(C_FEMDIV_P) = ''      => -0.005929853,
              ((real)c_femdiv_p < 11.25) => -0.00052509548,
                                            -0.005929853));

N908_7 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => 0.0063398615,
              ((real)f_add_input_nhood_vac_pct_i < 0.393380522728) => N908_8,
                                                                      0.0063398615));

N908_6 :=__common__( map(trim(C_BARGAINS) = ''      => 0.017412154,
              ((real)c_bargains < 118.5) => 0.0040163642,
                                            0.017412154));

N908_5 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i < 167.5), N908_6, -0.00021350947));

N908_4 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i > NULL), N908_5, -0.032129216));

N908_3 :=__common__( map(trim(C_AB_AV_EDU) = ''     => N908_4,
              ((real)c_ab_av_edu < 75.5) => 0.0005984818,
                                            N908_4));

N908_2 :=__common__( if(((real)c_med_rent < 378.5), N908_3, N908_7));

N908_1 :=__common__( if(trim(C_MED_RENT) != '', N908_2, -0.002612852));

N909_8 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)    => -0.0027323799,
              ((real)f_curraddrmedianvalue_d < 132405.5) => 0.0083721367,
                                                            -0.0027323799));

N909_7 :=__common__( map(trim(C_POP_55_64_P) = ''      => 0.0062909672,
              ((real)c_pop_55_64_p < 10.25) => -0.00014073088,
                                               0.0062909672));

N909_6 :=__common__( if(((real)c_serv_empl < 64.5), N909_7, -0.00039959447));

N909_5 :=__common__( if(trim(C_SERV_EMPL) != '', N909_6, -0.00061156908));

N909_4 :=__common__( map(((real)r_e55_college_ind_d <= NULL) => -0.0064779007,
              ((real)r_e55_college_ind_d < 0.5)   => N909_5,
                                                     -0.0064779007));

N909_3 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL)   => -0.0039404864,
              ((integer)f_liens_unrel_cj_total_amt_i < 3330) => N909_4,
                                                                -0.0039404864));

N909_2 :=__common__( if(((real)c_impulse_count_i < 1.5), N909_3, N909_8));

N909_1 :=__common__( if(((real)c_impulse_count_i > NULL), N909_2, -0.0059338521));

N910_8 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL) => 0.0045741951,
              ((real)f_prevaddrmurderindex_i < 114.5) => -0.0046244766,
                                                         0.0045741951));

N910_7 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), -0.018931449, -0.0031390748));

N910_6 :=__common__( map(trim(C_INC_125K_P) = ''     => N910_8,
              ((real)c_inc_125k_p < 3.25) => N910_7,
                                             N910_8));

N910_5 :=__common__( map(trim(C_INCOLLEGE) = ''              => -0.0051576874,
              ((real)c_incollege < 17.1500015259) => 0.0010982876,
                                                     -0.0051576874));

N910_4 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i < 4.5), N910_5, N910_6));

N910_3 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i > NULL), N910_4, -0.0055898308));

N910_2 :=__common__( if(((real)c_inc_75k_p < 32.5499992371), N910_3, 0.0085258674));

N910_1 :=__common__( if(trim(C_INC_75K_P) != '', N910_2, -0.0033154208));

N911_8 :=__common__( map(trim(C_HVAL_175K_P) = ''              => -0.0080732216,
              ((real)c_hval_175k_p < 10.6499996185) => 0.0037940354,
                                                       -0.0080732216));

N911_7 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => N911_8,
              ((real)f_mos_liens_unrel_cj_fseen_d < 165.5) => -0.0067757969,
                                                              N911_8));

N911_6 :=__common__( map(((real)f_inputaddractivephonelist_d <= NULL) => N911_7,
              ((real)f_inputaddractivephonelist_d < 0.5)   => 0.00087748772,
                                                              N911_7));

N911_5 :=__common__( map(trim(C_HH1_P) = ''      => 0.0046416394,
              ((real)c_hh1_p < 30.75) => -0.0075606198,
                                         0.0046416394));

N911_4 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL) => -0.0098181899,
              ((real)f_prevaddrcartheftindex_i < 160.5) => N911_5,
                                                           -0.0098181899));

N911_3 :=__common__( if(((integer)f_curraddrmedianincome_d < 14617), N911_4, N911_6));

N911_2 :=__common__( if(((real)f_curraddrmedianincome_d > NULL), N911_3, 0.0083760014));

N911_1 :=__common__( if(trim(C_EXP_PROD) != '', N911_2, 0.0013169983));

N912_7 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), -0.0066441292, 0.0045446684));

N912_6 :=__common__( if(((real)c_hval_125k_p < 13.4499998093), N912_7, 0.010306364));

N912_5 :=__common__( if(trim(C_HVAL_125K_P) != '', N912_6, 0.015371527));

N912_4 :=__common__( map(trim(C_MURDERS) = ''      => 0.0053746467,
              ((real)c_murders < 196.5) => -0.0002379498,
                                           0.0053746467));

N912_3 :=__common__( if(((real)c_femdiv_p < 0.75), -0.0080284644, N912_4));

N912_2 :=__common__( if(trim(C_FEMDIV_P) != '', N912_3, -0.0015582265));

N912_1 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => N912_5,
              ((real)f_inq_adls_per_phone_i < 1.5)   => N912_2,
                                                        N912_5));

N913_7 :=__common__( map(trim(C_MED_HVAL) = ''        => 0.0065599396,
              ((real)c_med_hval < 90547.5) => -0.0050167871,
                                              0.0065599396));

N913_6 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => 0.012066917,
              ((real)f_add_input_nhood_vac_pct_i < 0.125396966934) => N913_7,
                                                                      0.012066917));

N913_5 :=__common__( map(trim(C_RETIRED2) = ''      => N913_6,
              ((real)c_retired2 < 140.5) => -0.00028908721,
                                            N913_6));

N913_4 :=__common__( map(((real)f_inq_per_addr_i <= NULL) => -0.0065504618,
              ((real)f_inq_per_addr_i < 6.5)   => -0.00099949719,
                                                  -0.0065504618));

N913_3 :=__common__( map(trim(C_PRESCHL) = ''     => N913_5,
              ((real)c_preschl < 85.5) => N913_4,
                                          N913_5));

N913_2 :=__common__( if(((real)c_hval_40k_p < 40.25), N913_3, 0.0061917162));

N913_1 :=__common__( if(trim(C_HVAL_40K_P) != '', N913_2, 0.00072383419));

N914_11 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => 0.00068571001,
               ((real)f_curraddrburglaryindex_i < 183.5) => -0.0097867896,
                                                            0.00068571001));

N914_10 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N914_11, -0.0035843757));

N914_9 :=__common__( map(trim(C_FOR_SALE) = ''      => 0.014175288,
              ((real)c_for_sale < 133.5) => 0.0017207163,
                                            0.014175288));

N914_8 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.368547856808), N914_9, -0.0012180782));

N914_7 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N914_8, 0.011465278));

N914_6 :=__common__( map(trim(C_BIGAPT_P) = ''              => N914_7,
              ((real)c_bigapt_p < 2.84999990463) => -0.0014115903,
                                                    N914_7));

N914_5 :=__common__( if(((real)c_pop_25_34_p < 24.8499984741), N914_6, -0.0083137713));

N914_4 :=__common__( if(trim(C_POP_25_34_P) != '', N914_5, -0.0041233736));

N914_3 :=__common__( if(((real)r_pb_order_freq_d > NULL), N914_4, -0.00016826194));

N914_2 :=__common__( if(((real)f_curraddrcrimeindex_i < 194.5), N914_3, N914_10));

N914_1 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N914_2, -0.0034297521));

N915_8 :=__common__( map(((real)r_i61_inq_collection_count12_i <= NULL) => 0.0087971366,
              ((real)r_i61_inq_collection_count12_i < 2.5)   => 0.00011312642,
                                                                0.0087971366));

N915_7 :=__common__( map(((real)f_add_curr_mobility_index_n <= NULL)          => N915_8,
              ((real)f_add_curr_mobility_index_n < 0.221420928836) => 0.0096931503,
                                                                      N915_8));

N915_6 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)            => -0.0079284716,
              ((real)f_add_input_nhood_vac_pct_i < 0.00536196865141) => 0.0020409787,
                                                                        -0.0079284716));

N915_5 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.212401658297), N915_6, N915_7));

N915_4 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N915_5, -0.00015534203));

N915_3 :=__common__( map(trim(C_BLUE_COL) = ''              => 0.0059571148,
              ((real)c_blue_col < 25.5499992371) => N915_4,
                                                    0.0059571148));

N915_2 :=__common__( if(((real)c_newhouse < 185.399993896), N915_3, -0.0077934963));

N915_1 :=__common__( if(trim(C_NEWHOUSE) != '', N915_2, -0.0012720628));

N916_7 :=__common__( map(trim(C_HVAL_175K_P) = ''              => 0.0092956543,
              ((real)c_hval_175k_p < 17.0499992371) => -0.00061200142,
                                                       0.0092956543));

N916_6 :=__common__( map(trim(C_POP_85P_P) = ''              => -0.0034584225,
              ((real)c_pop_85p_p < 1.04999995232) => N916_7,
                                                     -0.0034584225));

N916_5 :=__common__( map(trim(C_POP_0_5_P) = ''              => -0.0068762999,
              ((real)c_pop_0_5_p < 11.9499998093) => N916_6,
                                                     -0.0068762999));

N916_4 :=__common__( map(trim(C_HVAL_150K_P) = ''              => N916_5,
              ((real)c_hval_150k_p < 13.4499998093) => 0.00084506972,
                                                       N916_5));

N916_3 :=__common__( map(trim(C_WHOLESALE) = ''              => 0.0075531041,
              ((real)c_wholesale < 20.8499984741) => N916_4,
                                                     0.0075531041));

N916_2 :=__common__( if(((real)c_hh00 < 1142.5), N916_3, -0.0055376654));

N916_1 :=__common__( if(trim(C_HH00) != '', N916_2, -0.0011370774));

N917_8 :=__common__( map(trim(C_RENTAL) = ''      => -0.00080242276,
              ((real)c_rental < 178.5) => 0.0085739132,
                                          -0.00080242276));

N917_7 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => 0.005506539,
              ((real)r_a50_pb_average_dollars_d < 80.5)  => -0.011152402,
                                                            0.005506539));

N917_6 :=__common__( map(trim(C_CIV_EMP) = ''              => N917_7,
              ((real)c_civ_emp < 58.3499984741) => 0.0076653406,
                                                   N917_7));

N917_5 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL)  => -0.0044431131,
              ((integer)f_curraddrcrimeindex_i < 192) => -0.00011871784,
                                                         -0.0044431131));

N917_4 :=__common__( if(((real)f_inq_banking_count24_i < 1.5), N917_5, N917_6));

N917_3 :=__common__( if(((real)f_inq_banking_count24_i > NULL), N917_4, 0.00037248129));

N917_2 :=__common__( if(((real)c_hh1_p < 51.1500015259), N917_3, N917_8));

N917_1 :=__common__( if(trim(C_HH1_P) != '', N917_2, -0.0021752911));

N918_8 :=__common__( if(((real)f_srchfraudsrchcount_i < 6.5), -0.00030913975, 0.0093375815));

N918_7 :=__common__( if(((real)f_srchfraudsrchcount_i > NULL), N918_8, 0.010502907));

N918_6 :=__common__( map(trim(C_RNT250_P) = ''              => N918_7,
              ((real)c_rnt250_p < 40.3499984741) => -0.00030110031,
                                                    N918_7));

N918_5 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => 0.011687579,
              ((real)f_add_input_mobility_index_n < 0.347150325775) => -0.00018829517,
                                                                       0.011687579));

N918_4 :=__common__( map(trim(C_POPOVER18) = ''      => N918_6,
              ((real)c_popover18 < 523.5) => N918_5,
                                             N918_6));

N918_3 :=__common__( map(trim(C_POP_6_11_P) = ''              => 0.00071437226,
              ((real)c_pop_6_11_p < 9.35000038147) => -0.010347918,
                                                      0.00071437226));

N918_2 :=__common__( if(((real)c_popover18 < 455.5), N918_3, N918_4));

N918_1 :=__common__( if(trim(C_POPOVER18) != '', N918_2, 0.00041878754));

N919_9 :=__common__( map(trim(C_LAR_FAM) = ''     => -0.0041438052,
              ((real)c_lar_fam < 83.5) => 0.0060636106,
                                          -0.0041438052));

N919_8 :=__common__( map(((real)f_fp_prevaddrcrimeindex_i <= NULL) => -0.012367334,
              ((real)f_fp_prevaddrcrimeindex_i < 185.5) => -0.0042479421,
                                                           -0.012367334));

N919_7 :=__common__( map(trim(C_HVAL_125K_P) = ''              => N919_9,
              ((real)c_hval_125k_p < 6.94999980927) => N919_8,
                                                       N919_9));

N919_6 :=__common__( if(((real)f_current_count_d < 2.5), N919_7, 0.0032643397));

N919_5 :=__common__( if(((real)f_current_count_d > NULL), N919_6, 0.012107197));

N919_4 :=__common__( if(((real)f_rel_count_i < 10.5), -0.0017718771, 0.00092956088));

N919_3 :=__common__( if(((real)f_rel_count_i > NULL), N919_4, 0.0016001392));

N919_2 :=__common__( if(((real)c_lowinc < 64.5500030518), N919_3, N919_5));

N919_1 :=__common__( if(trim(C_LOWINC) != '', N919_2, -0.0012164353));

N920_11 :=__common__( if(((real)r_a50_pb_average_dollars_d < 13.5), 0.0066112988, 0.000204615));

N920_10 :=__common__( if(((real)r_a50_pb_average_dollars_d > NULL), N920_11, 0.0041934596));

N920_9 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => 0.004789317,
              ((real)r_c13_max_lres_d < 116.5) => -0.0029317356,
                                                  0.004789317));

N920_8 :=__common__( if(((real)c_pop_55_64_p < 6.64999961853), 0.0069062588, N920_9));

N920_7 :=__common__( if(trim(C_POP_55_64_P) != '', N920_8, 0.0016945478));

N920_6 :=__common__( map(((real)f_prevaddrdwelltype_sfd_n <= NULL) => N920_7,
              ((real)f_prevaddrdwelltype_sfd_n < 0.5)   => -0.0039952219,
                                                           N920_7));

N920_5 :=__common__( if(((real)f_rel_under500miles_cnt_d < 7.5), -0.0061002303, 0.0036803264));

N920_4 :=__common__( if(((real)f_rel_under500miles_cnt_d > NULL), N920_5, -0.030877507));

N920_3 :=__common__( if(((real)r_pb_order_freq_d < 61.5), N920_4, -0.005619711));

N920_2 :=__common__( if(((real)r_pb_order_freq_d > NULL), N920_3, N920_6));

N920_1 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N920_2, N920_10));

N921_7 :=__common__( map(trim(C_MED_INC) = ''     => -0.0035498124,
              ((real)c_med_inc < 38.5) => -0.012226939,
                                          -0.0035498124));

N921_6 :=__common__( map(trim(C_SERV_EMPL) = ''      => N921_7,
              ((real)c_serv_empl < 127.5) => -0.00072840851,
                                             N921_7));

N921_5 :=__common__( if(((real)f_sourcerisktype_i < 4.5), 0.0015255573, N921_6));

N921_4 :=__common__( if(((real)f_sourcerisktype_i > NULL), N921_5, -0.0093791861));

N921_3 :=__common__( if(((real)c_popover25 < 468.5), 0.0046754912, N921_4));

N921_2 :=__common__( if(trim(C_POPOVER25) != '', N921_3, -0.0016489526));

N921_1 :=__common__( map(((real)f_util_add_curr_misc_n <= NULL) => 0.00060635899,
              ((real)f_util_add_curr_misc_n < 0.5)   => N921_2,
                                                        0.00060635899));

N922_9 :=__common__( map(trim(C_WHITE_COL) = ''              => -0.010733545,
              ((real)c_white_col < 28.6500015259) => 0.00023299223,
                                                     -0.010733545));

N922_8 :=__common__( if(((real)c_inc_35k_p < 10.6499996185), 0.0035984782, N922_9));

N922_7 :=__common__( if(trim(C_INC_35K_P) != '', N922_8, -0.020803808));

N922_6 :=__common__( map(trim(C_HH2_P) = ''              => 0.01050288,
              ((real)c_hh2_p < 25.4500007629) => 0.00040102639,
                                                 0.01050288));

N922_5 :=__common__( if(((real)c_easiqlife < 134.5), N922_6, -0.0021078755));

N922_4 :=__common__( if(trim(C_EASIQLIFE) != '', N922_5, 0.024558826));

N922_3 :=__common__( map(((real)r_i60_inq_count12_i <= NULL) => N922_7,
              ((real)r_i60_inq_count12_i < 8.5)   => N922_4,
                                                     N922_7));

N922_2 :=__common__( if(((real)f_srchfraudsrchcountyr_i < 3.5), -0.00043921223, N922_3));

N922_1 :=__common__( if(((real)f_srchfraudsrchcountyr_i > NULL), N922_2, 0.0026475785));

N923_10 :=__common__( if(((real)f_crim_rel_under100miles_cnt_i < 1.5), 0.0042827156, 0.014747944));

N923_9 :=__common__( if(((real)f_crim_rel_under100miles_cnt_i > NULL), N923_10, 0.0028593475));

N923_8 :=__common__( if(((real)c_pop_75_84_p < 4.25), N923_9, -0.0016995284));

N923_7 :=__common__( if(trim(C_POP_75_84_P) != '', N923_8, -0.012307469));

N923_6 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => 0.00029123572,
              ((real)r_c10_m_hdr_fs_d < 81.5)  => N923_7,
                                                  0.00029123572));

N923_5 :=__common__( map(trim(C_MANY_CARS) = ''     => -0.0014599903,
              ((real)c_many_cars < 72.5) => 0.0073123409,
                                            -0.0014599903));

N923_4 :=__common__( if(((real)c_unempl < 101.5), N923_5, -0.0029629499));

N923_3 :=__common__( if(trim(C_UNEMPL) != '', N923_4, -0.0035994287));

N923_2 :=__common__( if(((real)c_dist_input_to_prev_addr_i < 1.5), N923_3, N923_6));

N923_1 :=__common__( if(((real)c_dist_input_to_prev_addr_i > NULL), N923_2, 3.1138978e-005));

N924_11 :=__common__( if(((integer)r_f01_inp_addr_address_score_d < 35), 0.013153484, 0.0025011324));

N924_10 :=__common__( if(((real)r_f01_inp_addr_address_score_d > NULL), N924_11, -0.035702717));

N924_9 :=__common__( map(trim(C_SUB_BUS) = ''      => -0.001852501,
              ((real)c_sub_bus < 122.5) => N924_10,
                                           -0.001852501));

N924_8 :=__common__( map(trim(C_RNT750_P) = ''              => -0.0025337388,
              ((real)c_rnt750_p < 32.0499992371) => N924_9,
                                                    -0.0025337388));

N924_7 :=__common__( if(((real)r_a46_curr_avm_autoval_d < 184479.5), N924_8, -0.011505623));

N924_6 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N924_7, -0.0018506012));

N924_5 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N924_6, -0.0005093235));

N924_4 :=__common__( if(((real)f_addrchangeecontrajindex_d < 3.5), N924_5, 0.0076120945));

N924_3 :=__common__( if(((real)f_addrchangeecontrajindex_d > NULL), N924_4, -0.0015949366));

N924_2 :=__common__( if(((real)c_unattach < 54.5), 0.0069545621, N924_3));

N924_1 :=__common__( if(trim(C_UNATTACH) != '', N924_2, 0.0022024133));

N925_9 :=__common__( if(((real)f_corrrisktype_i < 7.5), -0.008874906, 0.00036301427));

N925_8 :=__common__( if(((real)f_corrrisktype_i > NULL), N925_9, -0.032016262));

N925_7 :=__common__( map(((real)r_phn_cell_n <= NULL) => -0.0038435564,
              ((real)r_phn_cell_n < 0.5)   => 0.0068520406,
                                              -0.0038435564));

N925_6 :=__common__( map(trim(C_NO_TEENS) = ''     => N925_8,
              ((real)c_no_teens < 81.5) => N925_7,
                                           N925_8));

N925_5 :=__common__( map(trim(C_BURGLARY) = ''      => 0.0019154948,
              ((integer)c_burglary < 75) => -0.0023705966,
                                            0.0019154948));

N925_4 :=__common__( if(((real)f_liens_unrel_cj_total_amt_i < 128.5), N925_5, -0.001551584));

N925_3 :=__common__( if(((real)f_liens_unrel_cj_total_amt_i > NULL), N925_4, -0.0071035954));

N925_2 :=__common__( if(((real)c_pop_18_24_p < 15.8500003815), N925_3, N925_6));

N925_1 :=__common__( if(trim(C_POP_18_24_P) != '', N925_2, 0.0038328402));

N926_8 :=__common__( map(((real)f_bus_name_nover_i <= NULL) => -0.0013852559,
              ((real)f_bus_name_nover_i < 0.5)   => 0.0081722327,
                                                    -0.0013852559));

N926_7 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => 0.0061036364,
              ((real)r_d32_mos_since_crim_ls_d < 93.5)  => -0.002890221,
                                                           0.0061036364));

N926_6 :=__common__( map(((real)f_util_adl_count_n <= NULL) => N926_8,
              ((real)f_util_adl_count_n < 4.5)   => N926_7,
                                                    N926_8));

N926_5 :=__common__( map(trim(C_RNT2000_P) = ''              => -0.010824194,
              ((real)c_rnt2000_p < 3.95000004768) => -0.0018418245,
                                                     -0.010824194));

N926_4 :=__common__( if(((real)r_d32_criminal_count_i < 1.5), N926_5, N926_6));

N926_3 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N926_4, 0.014241334));

N926_2 :=__common__( if(((real)c_pop_35_44_p < 13.4499998093), N926_3, 0.0014222921));

N926_1 :=__common__( if(trim(C_POP_35_44_P) != '', N926_2, 0.0014116467));

N927_9 :=__common__( if(((real)f_rel_ageover30_count_d < 6.5), -0.0036776402, 0.0070215269));

N927_8 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N927_9, -0.017906833));

N927_7 :=__common__( map(trim(C_HH2_P) = ''              => -0.0029709218,
              ((real)c_hh2_p < 17.5499992371) => 0.0053399249,
                                                 -0.0029709218));

N927_6 :=__common__( map(trim(C_PROFESSIONAL) = ''              => N927_8,
              ((real)c_professional < 5.05000019073) => N927_7,
                                                        N927_8));

N927_5 :=__common__( map(trim(C_RNT500_P) = ''              => N927_6,
              ((real)c_rnt500_p < 22.0499992371) => 0.0026740458,
                                                    N927_6));

N927_4 :=__common__( if(((real)f_srchphonesrchcount_i < 1.5), N927_5, -0.0013562122));

N927_3 :=__common__( if(((real)f_srchphonesrchcount_i > NULL), N927_4, -0.003435342));

N927_2 :=__common__( if(((real)c_housingcpi < 186.399993896), -0.0066101628, N927_3));

N927_1 :=__common__( if(trim(C_HOUSINGCPI) != '', N927_2, -0.000476359));

N928_10 :=__common__( map(trim(C_INC_50K_P) = ''              => -0.010271751,
               ((real)c_inc_50k_p < 13.1499996185) => 0.0025543442,
                                                      -0.010271751));

N928_9 :=__common__( map(trim(C_LAR_FAM) = ''      => -0.0021676013,
              ((real)c_lar_fam < 108.5) => 0.0077580888,
                                           -0.0021676013));

N928_8 :=__common__( if(((real)c_addr_lres_2mo_ct_i < 1.5), N928_9, N928_10));

N928_7 :=__common__( if(((real)c_addr_lres_2mo_ct_i > NULL), N928_8, -0.0054818417));

N928_6 :=__common__( map(trim(C_ROBBERY) = ''      => -0.0096881348,
              ((real)c_robbery < 163.5) => N928_7,
                                           -0.0096881348));

N928_5 :=__common__( if(((real)c_wholesale < 3.65000009537), N928_6, 0.0082004001));

N928_4 :=__common__( if(trim(C_WHOLESALE) != '', N928_5, 0.0066183482));

N928_3 :=__common__( map(((real)f_assocsuspicousidcount_i <= NULL) => 0.0088425827,
              ((real)f_assocsuspicousidcount_i < 9.5)   => -0.00022154408,
                                                           0.0088425827));

N928_2 :=__common__( if(((real)f_college_income_d > NULL), N928_3, -0.00042080349));

N928_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N928_2, N928_4));

N929_8 :=__common__( map(trim(C_BEL_EDU) = ''     => -0.002374278,
              ((real)c_bel_edu < 99.5) => 0.0028992295,
                                          -0.002374278));

N929_7 :=__common__( map(trim(C_POP_35_44_P) = ''              => -0.0081093003,
              ((real)c_pop_35_44_p < 18.4500007629) => N929_8,
                                                       -0.0081093003));

N929_6 :=__common__( map(trim(C_INC_35K_P) = ''              => 0.012374166,
              ((real)c_inc_35k_p < 16.0499992371) => 0.0015154244,
                                                     0.012374166));

N929_5 :=__common__( map(((real)f_srchunvrfdssncount_i <= NULL) => N929_6,
              ((real)f_srchunvrfdssncount_i < 0.5)   => -0.00040049723,
                                                        N929_6));

N929_4 :=__common__( map(((real)f_inq_communications_count24_i <= NULL) => N929_7,
              ((real)f_inq_communications_count24_i < 1.5)   => N929_5,
                                                                N929_7));

N929_3 :=__common__( if(((real)f_prevaddrmedianincome_d < 18036.5), 0.0030641224, N929_4));

N929_2 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N929_3, -0.00038387612));

N929_1 :=__common__( if(trim(C_CIV_EMP) != '', N929_2, -0.0058143514));

N930_9 :=__common__( if(((real)c_old_homes < 95.5), -0.0092069524, 0.00098154167));

N930_8 :=__common__( if(trim(C_OLD_HOMES) != '', N930_9, -0.013267609));

N930_7 :=__common__( map(((real)f_componentcharrisktype_i <= NULL) => 0.0018053084,
              ((real)f_componentcharrisktype_i < 5.5)   => -0.0055230459,
                                                           0.0018053084));

N930_6 :=__common__( map(trim(C_RNT1000_P) = ''              => N930_7,
              ((real)c_rnt1000_p < 1.04999995232) => 0.00024999029,
                                                     N930_7));

N930_5 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => 0.0071142838,
              ((real)f_prevaddrmedianincome_d < 77821.5) => N930_6,
                                                            0.0071142838));

N930_4 :=__common__( if(((real)c_rental < 102.5), N930_5, 0.00068503497));

N930_3 :=__common__( if(trim(C_RENTAL) != '', N930_4, 0.0010119965));

N930_2 :=__common__( if(((real)r_i60_inq_comm_count12_i < 3.5), N930_3, N930_8));

N930_1 :=__common__( if(((real)r_i60_inq_comm_count12_i > NULL), N930_2, -0.00049622945));

N931_11 :=__common__( if(((real)c_hh00 < 630.5), -9.2799235e-005, -0.0093555835));

N931_10 :=__common__( if(trim(C_HH00) != '', N931_11, -0.012948697));

N931_9 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => 0.0050895797,
              ((real)f_srchssnsrchcount_i < 16.5)  => 0.00026742695,
                                                      0.0050895797));

N931_8 :=__common__( map(((real)f_mos_liens_unrel_sc_fseen_d <= NULL) => N931_9,
              ((real)f_mos_liens_unrel_sc_fseen_d < 41.5)  => -0.0077251856,
                                                              N931_9));

N931_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N931_8, -0.0028651022));

N931_6 :=__common__( map(trim(C_BURGLARY) = ''      => N931_7,
              ((integer)c_burglary < 33) => 0.0095200103,
                                            N931_7));

N931_5 :=__common__( if(((real)c_rnt1500_p < 13.75), N931_6, -0.0082347449));

N931_4 :=__common__( if(trim(C_RNT1500_P) != '', N931_5, -0.0027628541));

N931_3 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), -7.0135716e-005, N931_4));

N931_2 :=__common__( if(((real)r_c20_email_domain_isp_count_i < 2.5), N931_3, N931_10));

N931_1 :=__common__( if(((real)r_c20_email_domain_isp_count_i > NULL), N931_2, 0.0069963336));

N932_10 :=__common__( if(((real)f_varrisktype_i < 2.5), -0.0005248008, -0.0092163509));

N932_9 :=__common__( if(((real)f_varrisktype_i > NULL), N932_10, -0.030128606));

N932_8 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.073414310813), 0.014741696, 0.0028064148));

N932_7 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N932_8, 0.0020448533));

N932_6 :=__common__( map((segment in ['SEARS FLS', 'SEARS SHO'])        => -0.0028714655,
              (segment in ['KMART', 'RETAIL', 'SEARS AUTO']) => N932_7,
                                                                N932_7));

N932_5 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => N932_6,
              ((real)f_inq_per_ssn_i < 5.5)   => -0.00070153626,
                                                 N932_6));

N932_4 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => 0.006214787,
              ((real)f_add_input_mobility_index_n < 0.442244708538) => -0.00061255688,
                                                                       0.006214787));

N932_3 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N932_4, N932_5));

N932_2 :=__common__( if(((real)c_hh7p_p < 6.94999980927), N932_3, N932_9));

N932_1 :=__common__( if(trim(C_HH7P_P) != '', N932_2, 0.0020774781));

N933_9 :=__common__( map(trim(C_HH5_P) = ''              => 0.00095583715,
              ((real)c_hh5_p < 5.85000038147) => 0.010233061,
                                                 0.00095583715));

N933_8 :=__common__( map(trim(C_VACANT_P) = ''              => N933_9,
              ((real)c_vacant_p < 7.35000038147) => -0.0039796906,
                                                    N933_9));

N933_7 :=__common__( map(((real)f_assocsuspicousidcount_i <= NULL) => -0.00018565015,
              ((real)f_assocsuspicousidcount_i < 0.5)   => N933_8,
                                                           -0.00018565015));

N933_6 :=__common__( map(trim(C_ASSAULT) = ''      => N933_7,
              ((integer)c_assault < 13) => -0.0087478761,
                                           N933_7));

N933_5 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N933_6, 0.00065582419));

N933_4 :=__common__( if(((real)r_c13_max_lres_d < 10.5), -0.0068227264, N933_5));

N933_3 :=__common__( if(((real)r_c13_max_lres_d > NULL), N933_4, 0.0051359694));

N933_2 :=__common__( if(((real)c_rest_indx < 167.5), N933_3, 0.0058495653));

N933_1 :=__common__( if(trim(C_REST_INDX) != '', N933_2, 0.0038237142));

N934_8 :=__common__( map(((real)f_varrisktype_i <= NULL) => 0.011670594,
              ((real)f_varrisktype_i < 4.5)   => 0.0031964031,
                                                 0.011670594));

N934_7 :=__common__( map(((real)f_fp_prevaddrcrimeindex_i <= NULL)  => N934_8,
              ((integer)f_fp_prevaddrcrimeindex_i < 136) => -8.037785e-005,
                                                            N934_8));

N934_6 :=__common__( map(((real)f_crim_rel_under100miles_cnt_i <= NULL) => -0.0053998913,
              ((real)f_crim_rel_under100miles_cnt_i < 7.5)   => -2.6650533e-005,
                                                                -0.0053998913));

N934_5 :=__common__( map(trim(C_FAMMAR_P) = ''              => N934_7,
              ((real)c_fammar_p < 57.3499984741) => N934_6,
                                                    N934_7));

N934_4 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i < 12.5), N934_5, 0.0066693998));

N934_3 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i > NULL), N934_4, 0.00083943617));

N934_2 :=__common__( if(((real)c_famotf18_p < 6.64999961853), -0.003238346, N934_3));

N934_1 :=__common__( if(trim(C_FAMOTF18_P) != '', N934_2, -0.0019515206));

N935_9 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.437363386154), -0.0033849747, 0.0065809468));

N935_8 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N935_9, -0.022213681));

N935_7 :=__common__( map(trim(C_OLD_HOMES) = ''      => N935_8,
              ((real)c_old_homes < 154.5) => 0.00077245686,
                                             N935_8));

N935_6 :=__common__( map(trim(C_OLD_HOMES) = ''      => 0.0063614346,
              ((real)c_old_homes < 102.5) => -0.0022280347,
                                             0.0063614346));

N935_5 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => N935_6,
              ((real)f_mos_inq_banko_cm_fseen_d < 61.5)  => -0.0058522353,
                                                            N935_6));

N935_4 :=__common__( if(((real)f_inq_count24_i < 10.5), N935_5, -0.0086973569));

N935_3 :=__common__( if(((real)f_inq_count24_i > NULL), N935_4, 0.016570188));

N935_2 :=__common__( if(((real)c_pop_75_84_p < 0.850000023842), N935_3, N935_7));

N935_1 :=__common__( if(trim(C_POP_75_84_P) != '', N935_2, -0.0024065236));

N936_11 :=__common__( map(trim(C_BLUE_EMPL) = ''      => -0.0039953808,
               ((real)c_blue_empl < 181.5) => 0.00058184296,
                                              -0.0039953808));

N936_10 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N936_11, 0.0025621371));

N936_9 :=__common__( if(((real)c_white_col < 11.25), 0.0074289875, N936_10));

N936_8 :=__common__( if(trim(C_WHITE_COL) != '', N936_9, 0.00093668347));

N936_7 :=__common__( map(((real)c_addr_lres_6mo_ct_i <= NULL) => -0.0017005888,
              ((real)c_addr_lres_6mo_ct_i < 2.5)   => -0.010922239,
                                                      -0.0017005888));

N936_6 :=__common__( if(((integer)c_assault < 82), 0.0056877989, N936_7));

N936_5 :=__common__( if(trim(C_ASSAULT) != '', N936_6, 0.010801516));

N936_4 :=__common__( map(((real)f_estimated_income_d <= NULL)    => -0.00694647,
              ((integer)f_estimated_income_d < 28500) => 0.0035449988,
                                                         -0.00694647));

N936_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N936_4, N936_5));

N936_2 :=__common__( if(((real)f_mos_liens_unrel_sc_fseen_d < 150.5), N936_3, N936_8));

N936_1 :=__common__( if(((real)f_mos_liens_unrel_sc_fseen_d > NULL), N936_2, 0.0027309473));

N937_10 :=__common__( if(((real)c_hval_125k_p < 6.35000038147), -0.010558963, 0.0012495555));

N937_9 :=__common__( if(trim(C_HVAL_125K_P) != '', N937_10, 0.0027803458));

N937_8 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL) => -0.01253764,
              ((real)f_fp_prevaddrburglaryindex_i < 158.5) => N937_9,
                                                              -0.01253764));

N937_7 :=__common__( map(((real)f_liens_unrel_sc_total_amt_i <= NULL) => 0.0038661892,
              ((real)f_liens_unrel_sc_total_amt_i < 480.5) => N937_8,
                                                              0.0038661892));

N937_6 :=__common__( map(((real)f_rel_ageover40_count_d <= NULL) => 0.0049338772,
              ((real)f_rel_ageover40_count_d < 10.5)  => -0.00041283607,
                                                         0.0049338772));

N937_5 :=__common__( map(trim(C_RETIRED) = ''     => N937_6,
              ((real)c_retired < 1.75) => 0.0067092919,
                                          N937_6));

N937_4 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N937_5, -0.0060801516));

N937_3 :=__common__( if(trim(C_RETIRED) != '', N937_4, 0.00060508159));

N937_2 :=__common__( if(((real)f_rel_criminal_count_i < 13.5), N937_3, N937_7));

N937_1 :=__common__( if(((real)f_rel_criminal_count_i > NULL), N937_2, 0.0047185739));

N938_8 :=__common__( map(trim(C_INCOLLEGE) = ''     => 0.00051193748,
              ((real)c_incollege < 3.75) => 0.012026604,
                                            0.00051193748));

N938_7 :=__common__( if(((real)c_dist_best_to_prev_addr_i < 9.5), N938_8, -0.0031228587));

N938_6 :=__common__( if(((real)c_dist_best_to_prev_addr_i > NULL), N938_7, 0.035378697));

N938_5 :=__common__( map(trim(C_INC_25K_P) = ''      => N938_6,
              ((real)c_inc_25k_p < 21.75) => -0.00028688769,
                                             N938_6));

N938_4 :=__common__( map((fp_segment in ['5 Derog'])                                                                               => -0.012174246,
              (fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '4 Bureau Only', '6 Recent Activity', '7 Other']) => -0.0016525519,
                                                                                                                           -0.0016525519));

N938_3 :=__common__( map(trim(C_APT20) = ''     => -0.00043195512,
              ((real)c_apt20 < 91.5) => N938_4,
                                        -0.00043195512));

N938_2 :=__common__( if(((real)c_fammar_p < 26.3499984741), N938_3, N938_5));

N938_1 :=__common__( if(trim(C_FAMMAR_P) != '', N938_2, 0.0010360177));

N939_9 :=__common__( map(trim(C_HVAL_80K_P) = ''              => -0.0050275769,
              ((real)c_hval_80k_p < 10.5500001907) => 0.0029943995,
                                                      -0.0050275769));

N939_8 :=__common__( map(((real)c_unique_addr_count_i <= NULL) => 0.001057931,
              ((real)c_unique_addr_count_i < 9.5)   => 0.0065132139,
                                                       0.001057931));

N939_7 :=__common__( if(((real)c_no_labfor < 132.5), N939_8, N939_9));

N939_6 :=__common__( if(trim(C_NO_LABFOR) != '', N939_7, 0.012463107));

N939_5 :=__common__( map(trim(C_RNT750_P) = ''              => 0.011873124,
              ((real)c_rnt750_p < 40.3499984741) => 0.0005403909,
                                                    0.011873124));

N939_4 :=__common__( if(((real)c_inc_15k_p < 31.1500015259), -0.0015089472, N939_5));

N939_3 :=__common__( if(trim(C_INC_15K_P) != '', N939_4, -0.0040645009));

N939_2 :=__common__( if(((real)f_rel_felony_count_i < 1.5), N939_3, N939_6));

N939_1 :=__common__( if(((real)f_rel_felony_count_i > NULL), N939_2, 0.0028945331));

N940_9 :=__common__( map(trim(C_LUX_PROD) = ''     => 0.011185807,
              ((real)c_lux_prod < 77.5) => 0.00024285395,
                                           0.011185807));

N940_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.128119438887), 0.0013004107, -0.0037888041));

N940_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N940_8, -0.0055635349));

N940_6 :=__common__( map(trim(C_SPAN_LANG) = ''      => -0.0017279813,
              ((real)c_span_lang < 105.5) => N940_7,
                                             -0.0017279813));

N940_5 :=__common__( map(trim(C_TRANSPORT) = ''              => -0.0062581707,
              ((real)c_transport < 21.8499984741) => N940_6,
                                                     -0.0062581707));

N940_4 :=__common__( if(((real)r_d31_bk_filing_count_i < 2.5), N940_5, 0.0067154643));

N940_3 :=__common__( if(((real)r_d31_bk_filing_count_i > NULL), N940_4, -0.0051914791));

N940_2 :=__common__( if(((real)c_housingcpi < 241.75), N940_3, N940_9));

N940_1 :=__common__( if(trim(C_HOUSINGCPI) != '', N940_2, 0.00039456974));

N941_8 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)         => -0.010950853,
              ((real)f_add_curr_nhood_sfd_pct_d < 0.75649535656) => 0.0024777393,
                                                                    -0.010950853));

N941_7 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL) => -0.0027284328,
              ((real)f_prevaddrmurderindex_i < 121.5) => -0.010997193,
                                                         -0.0027284328));

N941_6 :=__common__( map(trim(C_HH2_P) = ''              => 0.0034946571,
              ((real)c_hh2_p < 34.5499992371) => N941_7,
                                                 0.0034946571));

N941_5 :=__common__( map(trim(C_YOUNG) = ''              => N941_6,
              ((real)c_young < 33.9500007629) => 0.00055216382,
                                                 N941_6));

N941_4 :=__common__( if(((real)c_pop_25_34_p < 27.1500015259), N941_5, 0.0057152738));

N941_3 :=__common__( if(trim(C_POP_25_34_P) != '', N941_4, -0.0019504387));

N941_2 :=__common__( if(((real)r_i60_inq_comm_count12_i < 3.5), N941_3, N941_8));

N941_1 :=__common__( if(((real)r_i60_inq_comm_count12_i > NULL), N941_2, 0.00042189912));

N942_8 :=__common__( map((fp_segment in ['7 Other'])                                                                               => -0.01444294,
              (fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '4 Bureau Only', '5 Derog', '6 Recent Activity']) => 0.0028889013,
                                                                                                                           0.0028889013));

N942_7 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => N942_8,
              ((real)f_mos_inq_banko_om_lseen_d < 29.5)  => 0.0092291646,
                                                            N942_8));

N942_6 :=__common__( map(((real)r_d31_mostrec_bk_i <= NULL) => -0.0061443462,
              ((real)r_d31_mostrec_bk_i < 1.5)   => -8.5069558e-005,
                                                    -0.0061443462));

N942_5 :=__common__( map(trim(C_EXP_PROD) = ''      => -0.0061079716,
              ((real)c_exp_prod < 169.5) => N942_6,
                                            -0.0061079716));

N942_4 :=__common__( if(((real)r_d31_attr_bankruptcy_recency_d < 79.5), N942_5, N942_7));

N942_3 :=__common__( if(((real)r_d31_attr_bankruptcy_recency_d > NULL), N942_4, 0.0077764005));

N942_2 :=__common__( if(((real)c_lowinc < 82.3500061035), N942_3, 0.0057721385));

N942_1 :=__common__( if(trim(C_LOWINC) != '', N942_2, -0.003021855));

N943_9 :=__common__( map(trim(C_RELIG_INDX) = ''      => 0.0092995712,
              ((real)c_relig_indx < 178.5) => 0.0009122914,
                                              0.0092995712));

N943_8 :=__common__( map(trim(C_EXP_PROD) = ''     => N943_9,
              ((real)c_exp_prod < 12.5) => 0.0098437817,
                                           N943_9));

N943_7 :=__common__( map(trim(C_FAMILIES) = ''      => -6.335966e-005,
              ((real)c_families < 261.5) => N943_8,
                                            -6.335966e-005));

N943_6 :=__common__( if(((real)c_occunit_p < 68.8500061035), -0.0090162022, N943_7));

N943_5 :=__common__( if(trim(C_OCCUNIT_P) != '', N943_6, 0.0019136812));

N943_4 :=__common__( if(((real)c_unempl < 98.5), -0.0057615088, -0.00052682776));

N943_3 :=__common__( if(trim(C_UNEMPL) != '', N943_4, -0.0068599044));

N943_2 :=__common__( if(((real)r_c14_addrs_15yr_i < 6.5), N943_3, N943_5));

N943_1 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N943_2, 0.0041859955));

N944_10 :=__common__( if(((real)c_old_homes < 142.5), 0.0020203177, -0.0013735502));

N944_9 :=__common__( if(trim(C_OLD_HOMES) != '', N944_10, 0.0044956217));

N944_8 :=__common__( if(((real)r_l72_add_vacant_i < 0.5), N944_9, -0.006372031));

N944_7 :=__common__( if(((real)r_l72_add_vacant_i > NULL), N944_8, -0.030408006));

N944_6 :=__common__( if(((integer)r_f01_inp_addr_address_score_d < 11), 0.0044547259, -0.0035086369));

N944_5 :=__common__( if(((real)r_f01_inp_addr_address_score_d > NULL), N944_6, 0.0048188089));

N944_4 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => 0.0068364859,
              ((real)f_srchfraudsrchcount_i < 1.5)   => -0.0019733634,
                                                        0.0068364859));

N944_3 :=__common__( map(((real)c_comb_age_d <= NULL) => N944_5,
              ((real)c_comb_age_d < 23.5)  => N944_4,
                                              N944_5));

N944_2 :=__common__( if(((real)f_assoccredbureaucount_i < 0.5), N944_3, N944_7));

N944_1 :=__common__( if(((real)f_assoccredbureaucount_i > NULL), N944_2, -0.0084042965));

N945_10 :=__common__( if(((real)c_lowrent < 10.6499996185), -0.0070997307, 0.0018561208));

N945_9 :=__common__( if(trim(C_LOWRENT) != '', N945_10, -0.013575332));

N945_8 :=__common__( map(trim(C_TOTSALES) = ''       => 0.011460056,
              ((integer)c_totsales < 591) => 0.00026687089,
                                             0.011460056));

N945_7 :=__common__( if(((real)c_lowrent < 66.4499969482), N945_8, -0.002681711));

N945_6 :=__common__( if(trim(C_LOWRENT) != '', N945_7, 0.0064097248));

N945_5 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => N945_9,
              ((real)r_c21_m_bureau_adl_fs_d < 195.5) => N945_6,
                                                         N945_9));

N945_4 :=__common__( if(((real)c_white_col < 12.4499998093), 0.0062774631, -0.0010263526));

N945_3 :=__common__( if(trim(C_WHITE_COL) != '', N945_4, -0.0023796126));

N945_2 :=__common__( if(((real)f_corraddrnamecount_d < 6.5), N945_3, N945_5));

N945_1 :=__common__( if(((real)f_corraddrnamecount_d > NULL), N945_2, 0.0010384441));

N946_10 :=__common__( if(((real)c_femdiv_p < 6.55000019073), 0.0062092919, -0.0012786688));

N946_9 :=__common__( if(trim(C_FEMDIV_P) != '', N946_10, 0.027522152));

N946_8 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => -0.00061111333,
              ((real)r_d32_mos_since_crim_ls_d < 212.5) => -0.012109095,
                                                           -0.00061111333));

N946_7 :=__common__( if(((real)c_pop_0_5_p < 11.25), N946_8, 0.004882294));

N946_6 :=__common__( if(trim(C_POP_0_5_P) != '', N946_7, -0.0080458305));

N946_5 :=__common__( map((fp_segment in ['3 New DID', '4 Bureau Only', '6 Recent Activity', '7 Other']) => N946_6,
              (fp_segment in ['1 SSN Prob', '2 NAS 479', '5 Derog'])                         => N946_9,
                                                                                                N946_6));

N946_4 :=__common__( if(((real)c_pop_18_24_p < 24.5499992371), -0.00075063099, 0.0068247115));

N946_3 :=__common__( if(trim(C_POP_18_24_P) != '', N946_4, 0.0034216403));

N946_2 :=__common__( if(((integer)f_prevaddrmedianvalue_d < 186880), N946_3, N946_5));

N946_1 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N946_2, 0.0021927056));

N947_11 :=__common__( if(((real)c_blue_empl < 114.5), -0.00039827012, 0.013514238));

N947_10 :=__common__( if(trim(C_BLUE_EMPL) != '', N947_11, 0.0075471962));

N947_9 :=__common__( if(((real)f_rel_incomeover25_count_d > NULL), N947_10, 0.10487334));

N947_8 :=__common__( map(trim(C_REST_INDX) = ''     => 0.0080043104,
              ((real)c_rest_indx < 72.5) => -0.0028235395,
                                            0.0080043104));

N947_7 :=__common__( if(((real)c_rest_indx < 97.5), N947_8, -0.0062132098));

N947_6 :=__common__( if(trim(C_REST_INDX) != '', N947_7, -0.0048701295));

N947_5 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 238.5), N947_6, N947_9));

N947_4 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N947_5, 0.0058891987));

N947_3 :=__common__( if(((real)c_many_cars < 58.5), 0.0014366074, -0.00087960974));

N947_2 :=__common__( if(trim(C_MANY_CARS) != '', N947_3, 0.0074165244));

N947_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N947_2, N947_4));

N948_10 :=__common__( map(trim(C_LOW_ED) = ''              => -0.0078622583,
               ((real)c_low_ed < 63.8499984741) => -0.00020790293,
                                                   -0.0078622583));

N948_9 :=__common__( if(((real)c_low_hval < 53.75), N948_10, 0.0075355309));

N948_8 :=__common__( if(trim(C_LOW_HVAL) != '', N948_9, -0.00015393193));

N948_7 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i < 1.5), 0.003250461, N948_8));

N948_6 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i > NULL), N948_7, 0.0024091019));

N948_5 :=__common__( map(trim(C_RAPE) = ''      => 0.0094542024,
              ((real)c_rape < 185.5) => -4.1962239e-005,
                                        0.0094542024));

N948_4 :=__common__( if(((real)c_hval_250k_p < 1.84999990463), -0.0029050919, N948_5));

N948_3 :=__common__( if(trim(C_HVAL_250K_P) != '', N948_4, 0.0020264353));

N948_2 :=__common__( if(((real)f_add_input_nhood_vac_pct_i < 0.0975973159075), N948_3, N948_6));

N948_1 :=__common__( if(((real)f_add_input_nhood_vac_pct_i > NULL), N948_2, -0.006801645));

N949_9 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => 0.0049087378,
              ((real)f_add_curr_nhood_vac_pct_i < 0.200840651989) => -0.0034464805,
                                                                     0.0049087378));

N949_8 :=__common__( map(trim(C_LAR_FAM) = ''     => 0.00069281185,
              ((real)c_lar_fam < 60.5) => N949_9,
                                          0.00069281185));

N949_7 :=__common__( map(((real)f_srchunvrfdssncount_i <= NULL) => 0.0064106173,
              ((real)f_srchunvrfdssncount_i < 1.5)   => N949_8,
                                                        0.0064106173));

N949_6 :=__common__( map(((real)f_add_curr_nhood_bus_pct_i <= NULL)            => N949_7,
              ((real)f_add_curr_nhood_bus_pct_i < 0.00429568625987) => -0.0060984808,
                                                                       N949_7));

N949_5 :=__common__( if(((real)c_hh6_p < 13.0500001907), N949_6, 0.0073891668));

N949_4 :=__common__( if(trim(C_HH6_P) != '', N949_5, -0.0066080268));

N949_3 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N949_4, -0.00042655082));

N949_2 :=__common__( if(((real)f_rel_educationover8_count_d < 41.5), N949_3, -0.0064647924));

N949_1 :=__common__( if(((real)f_rel_educationover8_count_d > NULL), N949_2, -0.00047881156));

N950_9 :=__common__( map(trim(C_HH6_P) = ''                => 0.0037125226,
              ((real)c_hh6_p < 0.0500000007451) => -0.0025004443,
                                                   0.0037125226));

N950_8 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N950_9, 0.00082400195));

N950_7 :=__common__( map(trim(C_LOWINC) = ''              => N950_8,
              ((real)c_lowinc < 30.6500015259) => 0.009951379,
                                                  N950_8));

N950_6 :=__common__( map(((real)f_rel_bankrupt_count_i <= NULL) => -0.0043817262,
              ((real)f_rel_bankrupt_count_i < 1.5)   => 0.0020668576,
                                                        -0.0043817262));

N950_5 :=__common__( if(((real)f_assoccredbureaucount_i < 3.5), N950_6, 0.0064388395));

N950_4 :=__common__( if(((real)f_assoccredbureaucount_i > NULL), N950_5, -0.012829276));

N950_3 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => -0.0068386909,
              ((real)f_add_input_nhood_vac_pct_i < 0.0577073097229) => N950_4,
                                                                       -0.0068386909));

N950_2 :=__common__( if(((real)c_lowinc < 29.5499992371), N950_3, N950_7));

N950_1 :=__common__( if(trim(C_LOWINC) != '', N950_2, -0.0038661845));

N951_10 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)          => -0.00081938572,
               ((real)f_add_input_nhood_sfd_pct_d < 0.981898069382) => 0.0091183825,
                                                                       -0.00081938572));

N951_9 :=__common__( if(((real)c_civ_emp < 64.75), N951_10, -0.0041850516));

N951_8 :=__common__( if(trim(C_CIV_EMP) != '', N951_9, 0.0059984429));

N951_7 :=__common__( map(((real)f_util_add_input_misc_n <= NULL) => N951_8,
              ((real)f_util_add_input_misc_n < 0.5)   => -0.0054875586,
                                                         N951_8));

N951_6 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.0931038782001), N951_7, -0.0071015436));

N951_5 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N951_6, 0.0042686198));

N951_4 :=__common__( if(((real)f_addrchangeincomediff_d < -24323.5), -0.0054624039, 0.0022509331));

N951_3 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N951_4, 0.00020584071));

N951_2 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.131445452571), -0.0016107939, N951_3));

N951_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N951_2, N951_5));

N952_8 :=__common__( map(trim(C_INC_200K_P) = ''              => -0.00060293504,
              ((real)c_inc_200k_p < 6.35000038147) => -0.011179743,
                                                      -0.00060293504));

N952_7 :=__common__( map(trim(C_HVAL_125K_P) = ''              => -0.008750572,
              ((real)c_hval_125k_p < 9.64999961853) => 0.0010210199,
                                                       -0.008750572));

N952_6 :=__common__( map(trim(C_UNEMPL) = ''      => N952_7,
              ((real)c_unempl < 188.5) => 0.00051377139,
                                          N952_7));

N952_5 :=__common__( map(trim(C_INC_150K_P) = ''              => N952_8,
              ((real)c_inc_150k_p < 8.85000038147) => N952_6,
                                                      N952_8));

N952_4 :=__common__( if(((real)c_hh5_p < 20.0499992371), N952_5, -0.0061957364));

N952_3 :=__common__( if(trim(C_HH5_P) != '', N952_4, 0.0004721752));

N952_2 :=__common__( if(((real)r_d31_bk_filing_count_i < 2.5), N952_3, 0.0077708665));

N952_1 :=__common__( if(((real)r_d31_bk_filing_count_i > NULL), N952_2, -0.0035567192));

N953_9 :=__common__( map(trim(C_POP_6_11_P) = ''              => -0.0094433303,
              ((real)c_pop_6_11_p < 10.3500003815) => 0.00085952659,
                                                      -0.0094433303));

N953_8 :=__common__( map(trim(C_OLD_HOMES) = ''      => N953_9,
              ((integer)c_old_homes < 29) => 0.006875008,
                                             N953_9));

N953_7 :=__common__( map(trim(C_LUX_PROD) = ''      => 0.0027312758,
              ((real)c_lux_prod < 102.5) => 0.012864505,
                                            0.0027312758));

N953_6 :=__common__( if(((integer)f_curraddrcrimeindex_i < 59), N953_7, N953_8));

N953_5 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N953_6, 0.013114338));

N953_4 :=__common__( if(((real)r_c14_addrs_15yr_i < 4.5), -0.003053915, 0.0002035064));

N953_3 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N953_4, 0.00068997577));

N953_2 :=__common__( if(((real)c_rnt1250_p < 10.3500003815), N953_3, N953_5));

N953_1 :=__common__( if(trim(C_RNT1250_P) != '', N953_2, 0.0033150218));

N954_9 :=__common__( if(((real)f_rel_incomeover75_count_d < 2.5), -0.003186576, 0.0060527411));

N954_8 :=__common__( if(((real)f_rel_incomeover75_count_d > NULL), N954_9, -0.00054566538));

N954_7 :=__common__( map(((real)f_adl_util_misc_n <= NULL) => N954_8,
              ((real)f_adl_util_misc_n < 0.5)   => 0.0027443881,
                                                   N954_8));

N954_6 :=__common__( if(((real)c_wholesale < 5.14999961853), N954_7, -0.0063998841));

N954_5 :=__common__( if(trim(C_WHOLESALE) != '', N954_6, -0.0017839388));

N954_4 :=__common__( map(((real)f_inq_count24_i <= NULL) => -0.0051301858,
              ((real)f_inq_count24_i < 13.5)  => 0.0040588807,
                                                 -0.0051301858));

N954_3 :=__common__( map(trim(C_LOW_ED) = ''              => 0.0042343465,
              ((real)c_low_ed < 77.5500030518) => -0.0011410643,
                                                  0.0042343465));

N954_2 :=__common__( if(((real)f_addrchangeincomediff_d < 9786.5), N954_3, N954_4));

N954_1 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N954_2, N954_5));

N955_9 :=__common__( map(trim(C_FEMDIV_P) = ''              => -0.0010130132,
              ((real)c_femdiv_p < 5.35000038147) => 0.0090593087,
                                                    -0.0010130132));

N955_8 :=__common__( map(trim(C_CONSTRUCTION) = ''              => -0.0054804081,
              ((real)c_construction < 21.5499992371) => 0.0010902718,
                                                        -0.0054804081));

N955_7 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.106012180448), 0.0021041172, -0.0041414597));

N955_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N955_7, -0.0010879158));

N955_5 :=__common__( map(trim(C_CHILD) = ''              => N955_8,
              ((real)c_child < 23.0499992371) => N955_6,
                                                 N955_8));

N955_4 :=__common__( if(((real)c_construction < 32.25), N955_5, N955_9));

N955_3 :=__common__( if(trim(C_CONSTRUCTION) != '', N955_4, 0.00071906052));

N955_2 :=__common__( if(((real)f_inq_auto_count24_i < 4.5), N955_3, -0.010344169));

N955_1 :=__common__( if(((real)f_inq_auto_count24_i > NULL), N955_2, -1.0308325e-005));

N956_10 :=__common__( map(trim(C_FAMMAR_P) = ''      => 0.0015267613,
               ((real)c_fammar_p < 30.75) => 0.010631739,
                                             0.0015267613));

N956_9 :=__common__( if(((real)r_a50_pb_average_dollars_d < 133.5), 0.0022500215, -0.0069960934));

N956_8 :=__common__( if(((real)r_a50_pb_average_dollars_d > NULL), N956_9, -0.031135987));

N956_7 :=__common__( if(((real)c_inc_75k_p < 11.1499996185), N956_8, N956_10));

N956_6 :=__common__( if(trim(C_INC_75K_P) != '', N956_7, 0.0098778119));

N956_5 :=__common__( map(((real)f_rel_count_i <= NULL) => 0.0095473897,
              ((real)f_rel_count_i < 30.5)  => -0.00088310392,
                                               0.0095473897));

N956_4 :=__common__( if(((real)f_rel_under500miles_cnt_d < 26.5), N956_5, -0.0063284838));

N956_3 :=__common__( if(((real)f_rel_under500miles_cnt_d > NULL), N956_4, -0.0010295512));

N956_2 :=__common__( if(((real)r_l79_adls_per_addr_c6_i < 1.5), N956_3, N956_6));

N956_1 :=__common__( if(((real)r_l79_adls_per_addr_c6_i > NULL), N956_2, -0.034345036));

N957_8 :=__common__( if(((real)f_srchaddrsrchcount_i < 0.5), 0.0040569298, -0.0046870092));

N957_7 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N957_8, -0.0057361927));

N957_6 :=__common__( map(trim(C_BURGLARY) = ''      => N957_7,
              ((real)c_burglary < 167.5) => -9.0290306e-005,
                                            N957_7));

N957_5 :=__common__( map(trim(C_RETIRED2) = ''     => 0.01160473,
              ((real)c_retired2 < 99.5) => 0.0032472736,
                                           0.01160473));

N957_4 :=__common__( map(trim(C_HH2_P) = ''              => -0.0040304872,
              ((real)c_hh2_p < 38.0499992371) => N957_5,
                                                 -0.0040304872));

N957_3 :=__common__( map(trim(C_FOOD) = ''      => -0.00018703261,
              ((real)c_food < 13.25) => N957_4,
                                        -0.00018703261));

N957_2 :=__common__( if(((real)c_hval_125k_p < 1.45000004768), N957_3, N957_6));

N957_1 :=__common__( if(trim(C_HVAL_125K_P) != '', N957_2, 0.00021870546));

N958_9 :=__common__( map(trim(C_POP_6_11_P) = ''      => -0.0081586931,
              ((real)c_pop_6_11_p < 12.25) => -0.00042321504,
                                              -0.0081586931));

N958_8 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 122.5), N958_9, 0.0015763742));

N958_7 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N958_8, 0.0088282879));

N958_6 :=__common__( if(((real)f_addrchangeincomediff_d < 478.5), 0.0034318966, -0.0050522126));

N958_5 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N958_6, 0.0011357617));

N958_4 :=__common__( map(trim(C_HVAL_125K_P) = ''              => N958_5,
              ((real)c_hval_125k_p < 3.95000004768) => -0.0056879484,
                                                       N958_5));

N958_3 :=__common__( map(trim(C_POP_75_84_P) = ''              => N958_7,
              ((real)c_pop_75_84_p < 1.15000009537) => N958_4,
                                                       N958_7));

N958_2 :=__common__( if(((real)c_many_cars < 7.5), -0.0091274603, N958_3));

N958_1 :=__common__( if(trim(C_MANY_CARS) != '', N958_2, -0.00064267244));

N959_10 :=__common__( if(((real)c_rest_indx < 64.5), -0.0047977748, 0.0060130741));

N959_9 :=__common__( if(trim(C_REST_INDX) != '', N959_10, 0.0020713178));

N959_8 :=__common__( map(((real)r_i60_inq_comm_count12_i <= NULL) => -0.008602335,
              ((real)r_i60_inq_comm_count12_i < 3.5)   => -0.0010846216,
                                                          -0.008602335));

N959_7 :=__common__( map(trim(C_NEW_HOMES) = ''      => 0.0034858475,
              ((real)c_new_homes < 119.5) => -0.0031595788,
                                             0.0034858475));

N959_6 :=__common__( if(((real)c_old_homes < 119.5), N959_7, 0.0037732181));

N959_5 :=__common__( if(trim(C_OLD_HOMES) != '', N959_6, -0.0070880248));

N959_4 :=__common__( if(((real)f_rel_incomeover50_count_d < 1.5), N959_5, N959_8));

N959_3 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N959_4, 0.0036745608));

N959_2 :=__common__( if(((real)c_addr_lres_6mo_ct_i < 8.5), N959_3, N959_9));

N959_1 :=__common__( if(((real)c_addr_lres_6mo_ct_i > NULL), N959_2, 0.0021346543));

N960_8 :=__common__( map(trim(C_POP_12_17_P) = ''              => -0.0068523564,
              ((real)c_pop_12_17_p < 13.6499996185) => -0.001026977,
                                                       -0.0068523564));

N960_7 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL) => N960_8,
              ((integer)f_fp_prevaddrburglaryindex_i < 39) => 0.004019273,
                                                              N960_8));

N960_6 :=__common__( map(((real)f_rel_bankrupt_count_i <= NULL) => N960_7,
              ((real)f_rel_bankrupt_count_i < 1.5)   => 0.0013646864,
                                                        N960_7));

N960_5 :=__common__( map(((real)f_componentcharrisktype_i <= NULL) => 0.0066127693,
              ((real)f_componentcharrisktype_i < 7.5)   => N960_6,
                                                           0.0066127693));

N960_4 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)          => 0.0020623616,
              ((real)f_add_input_nhood_sfd_pct_d < 0.843391001225) => -0.008542053,
                                                                      0.0020623616));

N960_3 :=__common__( if(((real)c_pop_35_44_p < 5.55000019073), N960_4, N960_5));

N960_2 :=__common__( if(trim(C_POP_35_44_P) != '', N960_3, -0.0059957538));

N960_1 :=__common__( if(((real)f_prevaddrmurderindex_i > NULL), N960_2, -0.0072305243));

N961_8 :=__common__( map(((real)c_inf_fname_verd_d <= NULL) => -0.002978861,
              ((real)c_inf_fname_verd_d < 0.5)   => 0.0044205634,
                                                    -0.002978861));

N961_7 :=__common__( map(trim(C_BLUE_COL) = ''      => 0.00048765265,
              ((real)c_blue_col < 15.75) => -0.0087892103,
                                            0.00048765265));

N961_6 :=__common__( map(trim(C_FAMILIES) = ''      => -0.00077249993,
              ((real)c_families < 178.5) => 0.009309667,
                                            -0.00077249993));

N961_5 :=__common__( map(trim(C_BLUE_COL) = ''              => N961_7,
              ((real)c_blue_col < 12.3500003815) => N961_6,
                                                    N961_7));

N961_4 :=__common__( if(((integer)f_prevaddrmedianvalue_d < 90410), N961_5, N961_8));

N961_3 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N961_4, -0.004402274));

N961_2 :=__common__( if(((real)c_retail < 2.15000009537), N961_3, -0.00058761775));

N961_1 :=__common__( if(trim(C_RETAIL) != '', N961_2, 0.0023378301));

N962_9 :=__common__( map(trim(C_INCOLLEGE) = ''              => 0.005879039,
              ((real)c_incollege < 7.14999961853) => -0.0014848604,
                                                     0.005879039));

N962_8 :=__common__( map(trim(C_INC_100K_P) = ''              => N962_9,
              ((real)c_inc_100k_p < 5.55000019073) => -0.0050146076,
                                                      N962_9));

N962_7 :=__common__( if(((real)c_hval_60k_p < 8.94999980927), 0.0010084391, N962_8));

N962_6 :=__common__( if(trim(C_HVAL_60K_P) != '', N962_7, 0.0012527437));

N962_5 :=__common__( if(((real)c_housingcpi < 190.850006104), 0.0052956382, -0.0063890619));

N962_4 :=__common__( if(trim(C_HOUSINGCPI) != '', N962_5, 0.00020812925));

N962_3 :=__common__( map(((real)f_mos_liens_rel_cj_lseen_d <= NULL) => N962_6,
              ((real)f_mos_liens_rel_cj_lseen_d < 142.5) => N962_4,
                                                            N962_6));

N962_2 :=__common__( if(((real)f_util_adl_count_n < 14.5), N962_3, 0.0063012166));

N962_1 :=__common__( if(((real)f_util_adl_count_n > NULL), N962_2, 0.0038956477));

N963_9 :=__common__( map(trim(C_PRESCHL) = ''     => -0.0060252861,
              ((real)c_preschl < 68.5) => 0.0045613821,
                                          -0.0060252861));

N963_8 :=__common__( map(trim(C_LUX_PROD) = ''     => N963_9,
              ((real)c_lux_prod < 75.5) => 0.0027302533,
                                           N963_9));

N963_7 :=__common__( map(trim(C_RNT250_P) = ''              => -0.0080243109,
              ((real)c_rnt250_p < 28.8499984741) => N963_8,
                                                    -0.0080243109));

N963_6 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i < 52.5), 0.007594311, N963_7));

N963_5 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i > NULL), N963_6, -0.03233675));

N963_4 :=__common__( map(trim(C_BORN_USA) = ''     => N963_5,
              ((real)c_born_usa < 83.5) => -0.0033233268,
                                           N963_5));

N963_3 :=__common__( if(((real)c_newhouse < 90.8000030518), N963_4, 0.0093717421));

N963_2 :=__common__( if(trim(C_NEWHOUSE) != '', N963_3, 0.011471875));

N963_1 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N963_2, 0.00063025559));

N964_9 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)         => 0.0064995866,
              ((real)f_add_curr_nhood_sfd_pct_d < 0.93694794178) => -0.003507074,
                                                                    0.0064995866));

N964_8 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N964_9, 0.0010162605));

N964_7 :=__common__( map(trim(C_POP_12_17_P) = ''     => N964_8,
              ((real)c_pop_12_17_p < 6.25) => 0.012349916,
                                              N964_8));

N964_6 :=__common__( map(trim(C_FAMMAR18_P) = ''              => 0.0018890478,
              ((real)c_fammar18_p < 40.5499992371) => -0.0018128715,
                                                      0.0018890478));

N964_5 :=__common__( map(((real)c_inf_lname_verd_d <= NULL) => 0.0022162614,
              ((real)c_inf_lname_verd_d < 0.5)   => N964_6,
                                                    0.0022162614));

N964_4 :=__common__( if(((real)c_rural_p < 68.5999984741), N964_5, N964_7));

N964_3 :=__common__( if(trim(C_RURAL_P) != '', N964_4, -0.0043715557));

N964_2 :=__common__( if(((real)f_add_input_mobility_index_n < 0.59214413166), N964_3, 0.0040326256));

N964_1 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N964_2, -0.00085058808));

N965_8 :=__common__( map(trim(C_POP_12_17_P) = ''     => -0.0037426173,
              ((real)c_pop_12_17_p < 6.25) => 0.0044460733,
                                              -0.0037426173));

N965_7 :=__common__( map(((real)f_inq_per_phone_i <= NULL) => N965_8,
              ((real)f_inq_per_phone_i < 0.5)   => 0.0021791516,
                                                   N965_8));

N965_6 :=__common__( map(trim(C_HVAL_150K_P) = ''              => 0.0093627374,
              ((real)c_hval_150k_p < 25.5499992371) => -4.7248071e-005,
                                                       0.0093627374));

N965_5 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => -0.00038934765,
              ((real)r_c13_avg_lres_d < 57.5)  => -0.0048681142,
                                                  -0.00038934765));

N965_4 :=__common__( map(trim(C_RNT1250_P) = ''              => N965_6,
              ((real)c_rnt1250_p < 0.15000000596) => N965_5,
                                                     N965_6));

N965_3 :=__common__( if(((integer)f_fp_prevaddrcrimeindex_i < 140), N965_4, N965_7));

N965_2 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N965_3, 0.005619996));

N965_1 :=__common__( if(trim(C_RENTAL) != '', N965_2, 0.0024962071));

N966_8 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d < 108.5), -0.00285731, 0.0055297626));

N966_7 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N966_8, -0.033300474));

N966_6 :=__common__( map(trim(C_EXP_PROD) = ''     => -0.0046556686,
              ((real)c_exp_prod < 86.5) => N966_7,
                                           -0.0046556686));

N966_5 :=__common__( map(trim(C_RICH_NFAM) = ''     => -0.0080223593,
              ((real)c_rich_nfam < 91.5) => N966_6,
                                            -0.0080223593));

N966_4 :=__common__( map(trim(C_WORK_HOME) = ''      => 0.0048913308,
              ((real)c_work_home < 138.5) => N966_5,
                                             0.0048913308));

N966_3 :=__common__( map(trim(C_EASIQLIFE) = ''     => 0.0011305525,
              ((real)c_easiqlife < 78.5) => N966_4,
                                            0.0011305525));

N966_2 :=__common__( if(((real)c_bel_edu < 193.5), N966_3, -0.0058678364));

N966_1 :=__common__( if(trim(C_BEL_EDU) != '', N966_2, 0.0026063796));

N967_8 :=__common__( if(((real)c_serv_empl < 106.5), 0.00030620323, 0.0089978356));

N967_7 :=__common__( if(trim(C_SERV_EMPL) != '', N967_8, 0.0023721283));

N967_6 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)     => -0.0033462298,
              ((integer)f_prevaddrmedianvalue_d < 116265) => 0.0076398631,
                                                             -0.0033462298));

N967_5 :=__common__( map(((real)f_rel_count_i <= NULL) => -0.0057131586,
              ((real)f_rel_count_i < 20.5)  => N967_6,
                                               -0.0057131586));

N967_4 :=__common__( map(((real)f_prevaddrlenofres_d <= NULL) => N967_7,
              ((real)f_prevaddrlenofres_d < 39.5)  => N967_5,
                                                      N967_7));

N967_3 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => -0.00068900603,
              ((real)r_a50_pb_average_dollars_d < 44.5)  => N967_4,
                                                            -0.00068900603));

N967_2 :=__common__( if(((real)f_mos_acc_lseen_d < 32.5), 0.0043063478, N967_3));

N967_1 :=__common__( if(((real)f_mos_acc_lseen_d > NULL), N967_2, -0.0027945481));

N968_10 :=__common__( map(((real)c_dist_input_to_prev_addr_i <= NULL) => -0.0021044058,
               ((real)c_dist_input_to_prev_addr_i < 4.5)   => -0.010953901,
                                                              -0.0021044058));

N968_9 :=__common__( map(((real)r_c20_email_domain_free_count_i <= NULL) => N968_10,
              ((real)r_c20_email_domain_free_count_i < 0.5)   => 9.3492068e-005,
                                                                 N968_10));

N968_8 :=__common__( if(((real)f_srchvelocityrisktype_i < 2.5), N968_9, 0.00091957111));

N968_7 :=__common__( if(((real)f_srchvelocityrisktype_i > NULL), N968_8, -0.0043782801));

N968_6 :=__common__( if(((real)c_employees < 221.5), -0.0015617408, 0.0066798989));

N968_5 :=__common__( if(trim(C_EMPLOYEES) != '', N968_6, 0.033829968));

N968_4 :=__common__( if(((real)r_pb_order_freq_d < 84.5), 0.0032862943, -0.0065576191));

N968_3 :=__common__( if(((real)r_pb_order_freq_d > NULL), N968_4, N968_5));

N968_2 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => N968_3,
              ((real)f_curraddrmedianincome_d < 25402.5) => -0.0056203914,
                                                            N968_3));

N968_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N968_2, N968_7));

N969_7 :=__common__( map(trim(C_CPIALL) = ''       => -0.0013242015,
              ((integer)c_cpiall < 224) => 0.010446609,
                                           -0.0013242015));

N969_6 :=__common__( map(trim(C_LUX_PROD) = ''      => -0.0065361866,
              ((real)c_lux_prod < 150.5) => 0.0012131708,
                                            -0.0065361866));

N969_5 :=__common__( map(trim(C_VERY_RICH) = ''      => 0.0084445663,
              ((real)c_very_rich < 177.5) => N969_6,
                                             0.0084445663));

N969_4 :=__common__( map(trim(C_UNEMPL) = ''      => 0.00056036921,
              ((real)c_unempl < 129.5) => -0.0033649385,
                                          0.00056036921));

N969_3 :=__common__( map(trim(C_RELIG_INDX) = ''      => N969_5,
              ((real)c_relig_indx < 101.5) => N969_4,
                                              N969_5));

N969_2 :=__common__( if(((real)c_housingcpi < 241.75), N969_3, N969_7));

N969_1 :=__common__( if(trim(C_HOUSINGCPI) != '', N969_2, 0.0026201215));

N970_8 :=__common__( map(trim(C_POP_25_34_P) = ''      => 0.0020846331,
              ((real)c_pop_25_34_p < 12.75) => 0.011408182,
                                               0.0020846331));

N970_7 :=__common__( map(trim(C_RICH_FAM) = ''     => 0.0020969875,
              ((real)c_rich_fam < 81.5) => -0.0068636969,
                                           0.0020969875));

N970_6 :=__common__( map(((real)r_d32_mos_since_fel_ls_d <= NULL) => 0.00051550376,
              ((real)r_d32_mos_since_fel_ls_d < 81.5)  => -0.0052089955,
                                                          0.00051550376));

N970_5 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i < 194.5), N970_6, N970_7));

N970_4 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N970_5, 0.011304368));

N970_3 :=__common__( map(trim(C_HVAL_175K_P) = ''              => N970_8,
              ((real)c_hval_175k_p < 26.3499984741) => N970_4,
                                                       N970_8));

N970_2 :=__common__( if(((real)c_sub_bus < 189.5), N970_3, -0.0090193253));

N970_1 :=__common__( if(trim(C_SUB_BUS) != '', N970_2, -0.002890526));

N971_8 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => -0.0082824407,
              ((real)f_add_input_mobility_index_n < 0.326928555965) => 0.00092841448,
                                                                       -0.0082824407));

N971_7 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => 0.00020149269,
              ((real)f_mos_inq_banko_cm_lseen_d < 15.5)  => N971_8,
                                                            0.00020149269));

N971_6 :=__common__( if(((real)c_femdiv_p < 0.0500000007451), -0.0073777825, N971_7));

N971_5 :=__common__( if(trim(C_FEMDIV_P) != '', N971_6, -0.00047263008));

N971_4 :=__common__( map(((real)r_i60_inq_mortgage_recency_d <= NULL) => N971_5,
              ((real)r_i60_inq_mortgage_recency_d < 61.5)  => -0.0076324596,
                                                              N971_5));

N971_3 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.00067066792,
              ((real)r_c20_email_count_i < 2.5)   => 0.0091409831,
                                                     -0.00067066792));

N971_2 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d < 12.5), N971_3, N971_4));

N971_1 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d > NULL), N971_2, 0.0050708836));

N972_9 :=__common__( if(((real)f_inq_auto_count24_i < 0.5), 1.104817e-005, -0.0068539096));

N972_8 :=__common__( if(((real)f_inq_auto_count24_i > NULL), N972_9, 0.0017924414));

N972_7 :=__common__( if(((real)c_bargains < 179.5), N972_8, 0.004496034));

N972_6 :=__common__( if(trim(C_BARGAINS) != '', N972_7, -0.0011051417));

N972_5 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)    => -0.0065163861,
              ((real)f_prevaddrmedianvalue_d < 366249.5) => 0.0025387277,
                                                            -0.0065163861));

N972_4 :=__common__( map(trim(C_INC_50K_P) = ''              => N972_5,
              ((real)c_inc_50k_p < 10.5500001907) => -0.0016086713,
                                                     N972_5));

N972_3 :=__common__( map(((real)f_prevaddrageoldest_d <= NULL) => 0.0020222638,
              ((real)f_prevaddrageoldest_d < 70.5)  => -0.0071598117,
                                                       0.0020222638));

N972_2 :=__common__( map(trim(C_UNATTACH) = ''     => N972_4,
              ((real)c_unattach < 83.5) => N972_3,
                                           N972_4));

N972_1 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N972_2, N972_6));

N973_9 :=__common__( map(trim(C_HVAL_40K_P) = ''     => -0.00055640989,
              ((real)c_hval_40k_p < 0.75) => -0.011065456,
                                             -0.00055640989));

N973_8 :=__common__( map(trim(C_RICH_HISP) = ''      => 0.0024924781,
              ((real)c_rich_hisp < 159.5) => N973_9,
                                             0.0024924781));

N973_7 :=__common__( map((segment in ['SEARS AUTO', 'SEARS FLS', 'SEARS SHO']) => -0.0017012071,
              (segment in ['KMART', 'RETAIL'])                      => 0.0040747792,
                                                                       -0.0017012071));

N973_6 :=__common__( map(((real)f_rel_educationover12_count_d <= NULL) => N973_7,
              ((real)f_rel_educationover12_count_d < 15.5)  => -7.4767936e-005,
                                                               N973_7));

N973_5 :=__common__( map(((real)f_liens_unrel_o_total_amt_i <= NULL)   => 0.0083396767,
              ((integer)f_liens_unrel_o_total_amt_i < 1667) => N973_6,
                                                               0.0083396767));

N973_4 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N973_5, 0.0018961531));

N973_3 :=__common__( if(((real)c_hval_1001k_p < 0.25), N973_4, N973_8));

N973_2 :=__common__( if(trim(C_HVAL_1001K_P) != '', N973_3, 0.0022731111));

N973_1 :=__common__( if(((real)f_curraddrcartheftindex_i > NULL), N973_2, 0.00023236533));

N974_12 :=__common__( if(((integer)c_totsales < 5981), 0.0073516079, -0.0040606151));

N974_11 :=__common__( if(trim(C_TOTSALES) != '', N974_12, -0.011198368));

N974_10 :=__common__( map(((real)r_f03_input_add_not_most_rec_i <= NULL) => 0.010008629,
               ((real)r_f03_input_add_not_most_rec_i < 0.5)   => -0.00020735248,
                                                                 0.010008629));

N974_9 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N974_10, N974_11));

N974_8 :=__common__( if(((real)f_rel_incomeover25_count_d < 5.5), 0.0018008375, -0.0029555993));

N974_7 :=__common__( if(((real)f_rel_incomeover25_count_d > NULL), N974_8, -0.0038194427));

N974_6 :=__common__( if(((real)c_bargains < 159.5), N974_7, 0.001239849));

N974_5 :=__common__( if(trim(C_BARGAINS) != '', N974_6, 0.0017210768));

N974_4 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), -0.0023637922, N974_5));

N974_3 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => N974_9,
              ((real)f_curraddrmedianincome_d < 62382.5) => N974_4,
                                                            N974_9));

N974_2 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d < 3.5), 0.0068328359, N974_3));

N974_1 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N974_2, -2.1271322e-005));

N975_8 :=__common__( map(((real)r_i60_inq_hiriskcred_count12_i <= NULL) => -0.011658403,
              ((real)r_i60_inq_hiriskcred_count12_i < 0.5)   => -0.0010078292,
                                                                -0.011658403));

N975_7 :=__common__( map(((real)f_inq_communications_count24_i <= NULL) => N975_8,
              ((real)f_inq_communications_count24_i < 1.5)   => 0.00079270272,
                                                                N975_8));

N975_6 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => -0.0033436267,
              ((real)c_hist_addr_match_i < 4.5)   => 0.0031978265,
                                                     -0.0033436267));

N975_5 :=__common__( map(((real)f_varmsrcssncount_i <= NULL) => 0.0072491321,
              ((real)f_varmsrcssncount_i < 1.5)   => N975_6,
                                                     0.0072491321));

N975_4 :=__common__( if(((real)f_vardobcountnew_i < 0.5), N975_5, N975_7));

N975_3 :=__common__( if(((real)f_vardobcountnew_i > NULL), N975_4, 0.0031385352));

N975_2 :=__common__( if(((real)r_l79_adls_per_addr_c6_i < 1.5), -0.00091173145, N975_3));

N975_1 :=__common__( if(((real)r_l79_adls_per_addr_c6_i > NULL), N975_2, 0.00029203053));

N976_12 :=__common__( map(trim(C_MEDI_INDX) = ''     => 0.010358951,
               ((real)c_medi_indx < 92.5) => 0.00089083932,
                                             0.010358951));

N976_11 :=__common__( map(trim(C_PROFESSIONAL) = ''              => -0.0040274543,
               ((real)c_professional < 1.95000004768) => N976_12,
                                                         -0.0040274543));

N976_10 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N976_11, -0.0032218648));

N976_9 :=__common__( map(trim(C_HOUSINGCPI) = ''              => -0.00077983816,
              ((real)c_housingcpi < 188.050003052) => 0.0059187246,
                                                      -0.00077983816));

N976_8 :=__common__( if(((real)f_addrchangecrimediff_i < 59.5), -0.0028745649, 0.0090246201));

N976_7 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N976_8, -0.00095178171));

N976_6 :=__common__( if(((real)f_rel_incomeover25_count_d < 7.5), 0.0032098022, N976_7));

N976_5 :=__common__( if(((real)f_rel_incomeover25_count_d > NULL), N976_6, -0.001469499));

N976_4 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N976_5, N976_9));

N976_3 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N976_4, N976_10));

N976_2 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)          => N976_3,
              ((real)f_add_input_nhood_sfd_pct_d < 0.241329446435) => -0.0037026207,
                                                                      N976_3));

N976_1 :=__common__( if(trim(C_SFDU_P) != '', N976_2, -0.002191268));

N977_10 :=__common__( if(((real)c_fammar_p < 38.4500007629), 0.006850609, -0.0021883452));

N977_9 :=__common__( if(trim(C_FAMMAR_P) != '', N977_10, 0.00078562507));

N977_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.104611963034), -0.0040734866, 0.0057462555));

N977_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N977_8, -0.026038202));

N977_6 :=__common__( map((fp_segment in ['2 NAS 479', '3 New DID', '4 Bureau Only'])               => -0.012268063,
              (fp_segment in ['1 SSN Prob', '5 Derog', '6 Recent Activity', '7 Other']) => N977_7,
                                                                                           N977_7));

N977_5 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.0074902588,
              ((real)c_comb_age_d < 56.5)  => 7.604276e-006,
                                              -0.0074902588));

N977_4 :=__common__( map(trim(C_MED_HVAL) = ''         => N977_5,
              ((integer)c_med_hval < 47924) => 0.0046205605,
                                               N977_5));

N977_3 :=__common__( if(((real)c_bigapt_p < 16.75), N977_4, N977_6));

N977_2 :=__common__( if(trim(C_BIGAPT_P) != '', N977_3, 0.00039644564));

N977_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N977_2, N977_9));

N978_8 :=__common__( map(trim(C_WHITE_COL) = ''              => 0.0015471188,
              ((real)c_white_col < 19.0499992371) => -0.0059611408,
                                                     0.0015471188));

N978_7 :=__common__( map(((real)f_mos_liens_unrel_cj_lseen_d <= NULL) => N978_8,
              ((real)f_mos_liens_unrel_cj_lseen_d < 22.5)  => 0.0080346676,
                                                              N978_8));

N978_6 :=__common__( map(((real)r_d33_eviction_count_i <= NULL) => 0.0099770068,
              ((real)r_d33_eviction_count_i < 4.5)   => N978_7,
                                                        0.0099770068));

N978_5 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL) => -0.00031204383,
              ((real)r_a50_pb_total_dollars_d < 98.5)  => N978_6,
                                                          -0.00031204383));

N978_4 :=__common__( if(((real)r_c14_addrs_15yr_i < 21.5), N978_5, -0.0064052003));

N978_3 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N978_4, -0.007261061));

N978_2 :=__common__( if(((real)c_hval_150k_p < 34.25), N978_3, 0.0063710325));

N978_1 :=__common__( if(trim(C_HVAL_150K_P) != '', N978_2, -0.0027641389));

N979_11 :=__common__( map(trim(C_WHITE_COL) = ''              => 0.0014270462,
               ((real)c_white_col < 22.6500015259) => -0.0072596447,
                                                      0.0014270462));

N979_10 :=__common__( if(((real)f_corrssnnamecount_d < 6.5), N979_11, 0.0063887955));

N979_9 :=__common__( if(((real)f_corrssnnamecount_d > NULL), N979_10, -0.012216176));

N979_8 :=__common__( if(((real)c_inc_75k_p < 24.0499992371), N979_9, -0.0060172538));

N979_7 :=__common__( if(trim(C_INC_75K_P) != '', N979_8, 0.0029359491));

N979_6 :=__common__( if(((real)c_incollege < 3.65000009537), 0.00066579002, -0.0053074349));

N979_5 :=__common__( if(trim(C_INCOLLEGE) != '', N979_6, 0.0022738421));

N979_4 :=__common__( if(((integer)f_prevaddrmedianvalue_d < 94836), N979_5, 0.0002578794));

N979_3 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N979_4, 0.0029545934));

N979_2 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.169472634792), 0.0010715359, N979_3));

N979_1 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N979_2, N979_7));

N980_10 :=__common__( map(trim(C_HVAL_40K_P) = ''              => -0.0037699314,
               ((real)c_hval_40k_p < 18.5499992371) => 0.0072531498,
                                                       -0.0037699314));

N980_9 :=__common__( map(((real)c_inf_phn_verd_d <= NULL) => -0.0050090289,
              ((real)c_inf_phn_verd_d < 0.5)   => N980_10,
                                                  -0.0050090289));

N980_8 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.23139962554), 0.00068572042, -0.0097335323));

N980_7 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N980_8, -0.0036399648));

N980_6 :=__common__( map(trim(C_NO_CAR) = ''      => N980_9,
              ((real)c_no_car < 156.5) => N980_7,
                                          N980_9));

N980_5 :=__common__( map(((real)f_rel_criminal_count_i <= NULL) => -0.0029524915,
              ((real)f_rel_criminal_count_i < 3.5)   => N980_6,
                                                        -0.0029524915));

N980_4 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N980_5, 1.8512666e-005));

N980_3 :=__common__( if(((integer)f_estimated_income_d < 31500), N980_4, 0.00083534137));

N980_2 :=__common__( if(((real)f_estimated_income_d > NULL), N980_3, -0.0062372709));

N980_1 :=__common__( if(trim(C_BLUE_COL) != '', N980_2, -0.002566973));

N981_9 :=__common__( map(trim(C_OCCUNIT_P) = ''              => 0.0014688036,
              ((real)c_occunit_p < 89.3500061035) => -0.0085649327,
                                                     0.0014688036));

N981_8 :=__common__( map(((real)f_corraddrnamecount_d <= NULL) => 0.0061751077,
              ((real)f_corraddrnamecount_d < 6.5)   => N981_9,
                                                       0.0061751077));

N981_7 :=__common__( if(((real)c_hhsize < 2.91499996185), N981_8, -0.010633672));

N981_6 :=__common__( if(trim(C_HHSIZE) != '', N981_7, 0.0070618143));

N981_5 :=__common__( map(((real)f_inq_count24_i <= NULL) => N981_6,
              ((real)f_inq_count24_i < 5.5)   => 0.0020607131,
                                                 N981_6));

N981_4 :=__common__( if(((real)r_c13_curr_addr_lres_d < 8.5), 0.0041251142, N981_5));

N981_3 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N981_4, -0.031705469));

N981_2 :=__common__( if(((integer)r_f01_inp_addr_address_score_d < 35), N981_3, -0.0011388712));

N981_1 :=__common__( if(((real)r_f01_inp_addr_address_score_d > NULL), N981_2, 0.00033769572));

N982_8 :=__common__( if(((real)c_unique_addr_count_i < 5.5), 0.0018616343, -0.00097563717));

N982_7 :=__common__( if(((real)c_unique_addr_count_i > NULL), N982_8, 0.0022195213));

N982_6 :=__common__( map(trim(C_MANY_CARS) = ''      => -0.010311043,
              ((real)c_many_cars < 179.5) => N982_7,
                                             -0.010311043));

N982_5 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), 0.0037599231, 0.015347562));

N982_4 :=__common__( map(trim(C_UNEMPL) = ''      => 0.00079852348,
              ((real)c_unempl < 171.5) => N982_5,
                                          0.00079852348));

N982_3 :=__common__( map(trim(C_EASIQLIFE) = ''      => -0.007503481,
              ((real)c_easiqlife < 114.5) => N982_4,
                                             -0.007503481));

N982_2 :=__common__( if(((real)c_housingcpi < 188.050003052), N982_3, N982_6));

N982_1 :=__common__( if(trim(C_HOUSINGCPI) != '', N982_2, -0.00068374989));

N983_10 :=__common__( map(trim(C_MANY_CARS) = ''      => -0.004963177,
               ((real)c_many_cars < 163.5) => 0.0013193543,
                                              -0.004963177));

N983_9 :=__common__( if(((real)f_srchfraudsrchcountwk_i < 0.5), N983_10, -0.0056562738));

N983_8 :=__common__( if(((real)f_srchfraudsrchcountwk_i > NULL), N983_9, -0.010900731));

N983_7 :=__common__( map(trim(C_HIGHINC) = ''              => -0.0093111881,
              ((real)c_highinc < 10.8500003815) => 0.0010810984,
                                                   -0.0093111881));

N983_6 :=__common__( if(((real)f_addrchangecrimediff_i < 21.5), -0.0050644221, 0.0038966686));

N983_5 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N983_6, N983_7));

N983_4 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.00650671962649), 0.0071107751, N983_5));

N983_3 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N983_4, -0.00011140681));

N983_2 :=__common__( if(((integer)c_robbery < 73), N983_3, N983_8));

N983_1 :=__common__( if(trim(C_ROBBERY) != '', N983_2, -9.2713265e-005));

N984_8 :=__common__( map(trim(C_UNEMPL) = ''      => -0.0081085159,
              ((real)c_unempl < 125.5) => 0.00021142451,
                                          -0.0081085159));

N984_7 :=__common__( map(trim(C_RNT500_P) = ''              => 0.0097313816,
              ((real)c_rnt500_p < 11.1499996185) => -0.0016635057,
                                                    0.0097313816));

N984_6 :=__common__( map(trim(C_FAMMAR18_P) = ''              => -0.0046989174,
              ((real)c_fammar18_p < 32.9500007629) => N984_7,
                                                      -0.0046989174));

N984_5 :=__common__( if(((integer)c_assault < 120), N984_6, N984_8));

N984_4 :=__common__( if(trim(C_ASSAULT) != '', N984_5, -0.00753741));

N984_3 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.0053910799,
              ((real)f_inq_other_count24_i < 3.5)   => 0.00021637659,
                                                       0.0053910799));

N984_2 :=__common__( if(((real)f_rel_criminal_count_i < 9.5), N984_3, N984_4));

N984_1 :=__common__( if(((real)f_rel_criminal_count_i > NULL), N984_2, -0.0065066872));

N985_10 :=__common__( map(((real)f_divrisktype_i <= NULL) => -0.0063763591,
               ((real)f_divrisktype_i < 1.5)   => 0.0045914476,
                                                  -0.0063763591));

N985_9 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => N985_10,
              ((real)f_mos_inq_banko_cm_fseen_d < 63.5)  => -0.0097369901,
                                                            N985_10));

N985_8 :=__common__( map(((real)f_inq_addrs_per_ssn_i <= NULL) => N985_9,
              ((real)f_inq_addrs_per_ssn_i < 0.5)   => 0.0029275444,
                                                       N985_9));

N985_7 :=__common__( if(((integer)r_f01_inp_addr_address_score_d < 35), 0.0029945312, -0.0024781487));

N985_6 :=__common__( if(((real)r_f01_inp_addr_address_score_d > NULL), N985_7, -0.047341224));

N985_5 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N985_6, N985_8));

N985_4 :=__common__( if(((real)c_femdiv_p < 10.4499998093), N985_5, -0.0074524935));

N985_3 :=__common__( if(trim(C_FEMDIV_P) != '', N985_4, 0.0048306195));

N985_2 :=__common__( if(((real)r_c13_curr_addr_lres_d < 16.5), N985_3, 0.00095370571));

N985_1 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N985_2, -0.00037722655));

N986_11 :=__common__( if(((real)f_crim_rel_under100miles_cnt_i < 4.5), 0.011601162, 0.0012434665));

N986_10 :=__common__( if(((real)f_crim_rel_under100miles_cnt_i > NULL), N986_11, 0.011677115));

N986_9 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => N986_10,
              ((real)r_d32_criminal_count_i < 1.5)   => 0.00080050544,
                                                        N986_10));

N986_8 :=__common__( if(((real)c_span_lang < 150.5), -0.00030607542, -0.0039158458));

N986_7 :=__common__( if(trim(C_SPAN_LANG) != '', N986_8, 0.0043587268));

N986_6 :=__common__( if(((real)f_rel_ageover50_count_d < 2.5), N986_7, 0.0063564253));

N986_5 :=__common__( if(((real)f_rel_ageover50_count_d > NULL), N986_6, 0.0032856144));

N986_4 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.513052582741), N986_5, N986_9));

N986_3 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N986_4, -0.0010986904));

N986_2 :=__common__( if(((real)f_srchcomponentrisktype_i < 2.5), N986_3, 0.0043181675));

N986_1 :=__common__( if(((real)f_srchcomponentrisktype_i > NULL), N986_2, -0.0073266501));

N987_9 :=__common__( if(((real)c_bargains < 196.5), 0.00060379895, -0.0061327082));

N987_8 :=__common__( if(trim(C_BARGAINS) != '', N987_9, 0.0030913615));

N987_7 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => 0.0076175129,
              ((real)f_curraddrburglaryindex_i < 196.5) => N987_8,
                                                           0.0076175129));

N987_6 :=__common__( map(trim(C_INC_25K_P) = ''      => 0.0073778307,
              ((real)c_inc_25k_p < 13.75) => -0.002414008,
                                             0.0073778307));

N987_5 :=__common__( map(((real)r_d32_mos_since_fel_ls_d <= NULL) => -0.0057048896,
              ((real)r_d32_mos_since_fel_ls_d < 133.5) => N987_6,
                                                          -0.0057048896));

N987_4 :=__common__( if(((real)c_inc_50k_p < 17.8499984741), N987_5, -0.0081081094));

N987_3 :=__common__( if(trim(C_INC_50K_P) != '', N987_4, -0.0031551231));

N987_2 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 240.5), N987_3, N987_7));

N987_1 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N987_2, -0.0026548598));

N988_8 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => 0.0072418112,
              ((real)r_d32_mos_since_crim_ls_d < 94.5)  => -0.0020155262,
                                                           0.0072418112));

N988_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N988_8, 0.034188134));

N988_6 :=__common__( map((segment in ['KMART', 'RETAIL'])                      => -0.001873689,
              (segment in ['SEARS AUTO', 'SEARS FLS', 'SEARS SHO']) => 0.0075541535,
                                                                       0.0075541535));

N988_5 :=__common__( map(trim(C_BORN_USA) = ''     => -0.00080321094,
              ((real)c_born_usa < 28.5) => N988_6,
                                           -0.00080321094));

N988_4 :=__common__( map(((real)f_inq_banking_count24_i <= NULL) => 0.0053142485,
              ((real)f_inq_banking_count24_i < 2.5)   => N988_5,
                                                         0.0053142485));

N988_3 :=__common__( if(trim(C_HH1_P) != '', N988_4, 0.00048131569));

N988_2 :=__common__( if(((real)c_impulse_count_i < 1.5), N988_3, N988_7));

N988_1 :=__common__( if(((real)c_impulse_count_i > NULL), N988_2, 0.0070191953));

N989_9 :=__common__( if(((real)c_civ_emp < 53.4500007629), -0.00072215196, 0.0095872992));

N989_8 :=__common__( if(trim(C_CIV_EMP) != '', N989_9, -0.015485386));

N989_7 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => 0.0083025475,
              ((real)f_add_input_mobility_index_n < 0.533176124096) => 0.00084799797,
                                                                       0.0083025475));

N989_6 :=__common__( if(((real)c_inc_75k_p < 27.8499984741), N989_7, 0.011367713));

N989_5 :=__common__( if(trim(C_INC_75K_P) != '', N989_6, -0.029323498));

N989_4 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)            => N989_5,
              ((real)f_add_input_nhood_vac_pct_i < 0.00281958887354) => -0.0047609656,
                                                                        N989_5));

N989_3 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)     => N989_4,
              ((integer)f_prevaddrmedianvalue_d < 154112) => -0.00094170536,
                                                             N989_4));

N989_2 :=__common__( if(((real)f_srchcomponentrisktype_i < 2.5), N989_3, N989_8));

N989_1 :=__common__( if(((real)f_srchcomponentrisktype_i > NULL), N989_2, -0.012205733));

N990_8 :=__common__( if(((real)r_c20_email_domain_isp_count_i < 0.5), -0.010379451, -0.0013751803));

N990_7 :=__common__( if(((real)r_c20_email_domain_isp_count_i > NULL), N990_8, -0.028746096));

N990_6 :=__common__( map(trim(C_INCOLLEGE) = ''     => N990_7,
              ((real)c_incollege < 4.25) => 0.001491522,
                                            N990_7));

N990_5 :=__common__( map(trim(C_AB_AV_EDU) = ''      => 0.0039106328,
              ((real)c_ab_av_edu < 135.5) => -6.2513835e-005,
                                             0.0039106328));

N990_4 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => -0.0060972365,
              ((real)f_add_curr_nhood_vac_pct_i < 0.571006953716) => N990_5,
                                                                     -0.0060972365));

N990_3 :=__common__( map(((real)f_inq_per_addr_i <= NULL) => N990_6,
              ((real)f_inq_per_addr_i < 10.5)  => N990_4,
                                                  N990_6));

N990_2 :=__common__( if(((real)c_retail < 46.75), N990_3, 0.0055550883));

N990_1 :=__common__( if(trim(C_RETAIL) != '', N990_2, -0.0046877429));

N991_8 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => 0.0067210202,
              ((real)f_curraddrburglaryindex_i < 152.5) => -0.0056215322,
                                                           0.0067210202));

N991_7 :=__common__( if(((real)f_rel_incomeover75_count_d < 0.5), 0.013660093, 0.0033549859));

N991_6 :=__common__( if(((real)f_rel_incomeover75_count_d > NULL), N991_7, 0.026587194));

N991_5 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => N991_6,
              ((real)f_mos_inq_banko_om_lseen_d < 16.5)  => 0.00021607245,
                                                            N991_6));

N991_4 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => N991_8,
              ((real)f_mos_inq_banko_cm_fseen_d < 70.5)  => N991_5,
                                                            N991_8));

N991_3 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => N991_4,
              ((real)r_d32_criminal_count_i < 6.5)   => -6.7316336e-005,
                                                        N991_4));

N991_2 :=__common__( if(((real)c_dist_input_to_prev_addr_i < 21.5), N991_3, -0.0023802463));

N991_1 :=__common__( if(((real)c_dist_input_to_prev_addr_i > NULL), N991_2, -0.0017166131));

N992_9 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL) => -0.0067089879,
              ((real)f_prevaddrmurderindex_i < 168.5) => 0.0056553663,
                                                         -0.0067089879));

N992_8 :=__common__( map(trim(C_MED_AGE) = ''              => -0.0046665406,
              ((real)c_med_age < 28.5499992371) => 0.0011975264,
                                                   -0.0046665406));

N992_7 :=__common__( if(((real)c_work_home < 120.5), N992_8, N992_9));

N992_6 :=__common__( if(trim(C_WORK_HOME) != '', N992_7, -0.00049935169));

N992_5 :=__common__( map(((real)f_mos_liens_rel_cj_lseen_d <= NULL) => N992_6,
              ((real)f_mos_liens_rel_cj_lseen_d < 87.5)  => 0.006269112,
                                                            N992_6));

N992_4 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i < -6595.5), 0.0060515288, -0.00060974889));

N992_3 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N992_4, 0.00084355198));

N992_2 :=__common__( if(((real)c_addr_lres_12mo_ct_i < 6.5), N992_3, N992_5));

N992_1 :=__common__( if(((real)c_addr_lres_12mo_ct_i > NULL), N992_2, 0.00078729483));

N993_8 :=__common__( map(trim(C_NO_TEENS) = ''     => 0.0046695381,
              ((real)c_no_teens < 62.5) => -0.0052244469,
                                           0.0046695381));

N993_7 :=__common__( map(trim(C_HVAL_175K_P) = ''              => 0.0077159483,
              ((real)c_hval_175k_p < 4.05000019073) => N993_8,
                                                       0.0077159483));

N993_6 :=__common__( map(trim(C_HVAL_100K_P) = ''              => 0.0094651785,
              ((real)c_hval_100k_p < 36.4500007629) => 0.00081157533,
                                                       0.0094651785));

N993_5 :=__common__( map(trim(C_OWNOCC_P) = ''              => N993_6,
              ((real)c_ownocc_p < 22.0499992371) => -0.003689623,
                                                    N993_6));

N993_4 :=__common__( if(((real)r_c14_addrs_5yr_i < 3.5), N993_5, -0.0014819304));

N993_3 :=__common__( if(((real)r_c14_addrs_5yr_i > NULL), N993_4, 0.002929626));

N993_2 :=__common__( if(((real)c_inc_35k_p < 20.0499992371), N993_3, N993_7));

N993_1 :=__common__( if(trim(C_INC_35K_P) != '', N993_2, 0.00057317346));

N994_8 :=__common__( map(((real)f_prevaddrlenofres_d <= NULL) => -0.0018894561,
              ((real)f_prevaddrlenofres_d < 33.5)  => -0.011339179,
                                                      -0.0018894561));

N994_7 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => -0.00082596534,
              ((real)r_c21_m_bureau_adl_fs_d < 155.5) => 0.0066595534,
                                                         -0.00082596534));

N994_6 :=__common__( map(trim(C_SERV_EMPL) = ''     => N994_7,
              ((real)c_serv_empl < 63.5) => -0.0088178763,
                                            N994_7));

N994_5 :=__common__( map(trim(C_INC_150K_P) = ''              => N994_8,
              ((real)c_inc_150k_p < 3.65000009537) => N994_6,
                                                      N994_8));

N994_4 :=__common__( if(((real)r_a50_pb_total_dollars_d < 53.5), N994_5, 0.00043378066));

N994_3 :=__common__( if(((real)r_a50_pb_total_dollars_d > NULL), N994_4, -0.0092907764));

N994_2 :=__common__( if(((real)c_hval_100k_p < 51.1500015259), N994_3, 0.0078893723));

N994_1 :=__common__( if(trim(C_HVAL_100K_P) != '', N994_2, -0.00074624834));

N995_9 :=__common__( map(((real)f_inq_count24_i <= NULL) => 0.0098380913,
              ((real)f_inq_count24_i < 17.5)  => 0.0019072833,
                                                 0.0098380913));

N995_8 :=__common__( map(trim(C_INFO) = ''              => -0.0064366551,
              ((real)c_info < 2.84999990463) => N995_9,
                                                -0.0064366551));

N995_7 :=__common__( if(((real)r_c14_addrs_10yr_i < 3.5), -0.0022111572, N995_8));

N995_6 :=__common__( if(((real)r_c14_addrs_10yr_i > NULL), N995_7, 0.0098564607));

N995_5 :=__common__( map(trim(C_OLDHOUSE) = ''              => -0.0079323105,
              ((real)c_oldhouse < 644.400024414) => N995_6,
                                                    -0.0079323105));

N995_4 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0472515374422), -0.0013907674, N995_5));

N995_3 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N995_4, -0.0010603608));

N995_2 :=__common__( if(((real)c_famotf18_p < 71.0999984741), N995_3, 0.0059656949));

N995_1 :=__common__( if(trim(C_FAMOTF18_P) != '', N995_2, 0.00031403428));

N996_7 :=__common__( map(trim(C_REST_INDX) = ''     => 0.00094450862,
              ((real)c_rest_indx < 83.5) => 0.0093860573,
                                            0.00094450862));

N996_6 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => -0.0036134972,
              ((real)f_add_curr_nhood_sfd_pct_d < 0.948478102684) => N996_7,
                                                                     -0.0036134972));

N996_5 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS FLS', 'SEARS SHO']) => -0.0051226432,
              (segment in ['KMART'])                                          => 0.0084790306,
                                                                                 -0.0051226432));

N996_4 :=__common__( map(trim(C_RNT1000_P) = ''              => -0.0087438453,
              ((real)c_rnt1000_p < 66.0500030518) => -0.00043895929,
                                                     -0.0087438453));

N996_3 :=__common__( map(trim(C_MIL_EMP) = ''              => N996_5,
              ((real)c_mil_emp < 3.15000009537) => N996_4,
                                                   N996_5));

N996_2 :=__common__( if(((real)c_retail < 31.9500007629), N996_3, N996_6));

N996_1 :=__common__( if(trim(C_RETAIL) != '', N996_2, 0.0030048029));

N997_8 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.00039211705,
              (segment in ['SEARS FLS'])                                  => 0.012374063,
                                                                             -0.00039211705));

N997_7 :=__common__( map(trim(C_BLUE_EMPL) = ''     => -0.00015697012,
              ((real)c_blue_empl < 26.5) => -0.0092401022,
                                            -0.00015697012));

N997_6 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)         => 0.0023071526,
              ((real)f_add_curr_nhood_sfd_pct_d < 0.73128759861) => N997_7,
                                                                    0.0023071526));

N997_5 :=__common__( map(trim(C_ASSAULT) = ''       => N997_6,
              ((integer)c_assault < 102) => -0.0014823681,
                                            N997_6));

N997_4 :=__common__( map(trim(C_RICH_WHT) = ''      => N997_8,
              ((real)c_rich_wht < 175.5) => N997_5,
                                            N997_8));

N997_3 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N997_4, 0.013328582));

N997_2 :=__common__( if(((real)c_newhouse < 173.550003052), N997_3, -0.007218709));

N997_1 :=__common__( if(trim(C_NEWHOUSE) != '', N997_2, 0.0010167062));

N998_9 :=__common__( map(trim(C_POP_75_84_P) = ''              => -0.0014095768,
              ((real)c_pop_75_84_p < 4.05000019073) => 0.0012349513,
                                                       -0.0014095768));

N998_8 :=__common__( map(trim(C_TRANSPORT) = ''     => 0.004897087,
              ((real)c_transport < 9.25) => -0.002868168,
                                            0.004897087));

N998_7 :=__common__( if(((real)c_rnt500_p < 8.94999980927), N998_8, N998_9));

N998_6 :=__common__( if(trim(C_RNT500_P) != '', N998_7, -0.0076349011));

N998_5 :=__common__( if(((real)c_pop_55_64_p < 7.05000019073), 0.0091189592, 6.2090755e-005));

N998_4 :=__common__( if(trim(C_POP_55_64_P) != '', N998_5, 0.010016863));

N998_3 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => N998_6,
              ((real)f_curraddrmurderindex_i < 19.5)  => N998_4,
                                                         N998_6));

N998_2 :=__common__( if(((real)f_srchunvrfdssncount_i < 1.5), N998_3, 0.0056881208));

N998_1 :=__common__( if(((real)f_srchunvrfdssncount_i > NULL), N998_2, -0.0033272238));

N999_9 :=__common__( map(trim(C_INC_125K_P) = ''              => -0.0033915187,
              ((real)c_inc_125k_p < 3.45000004768) => 0.0049666434,
                                                      -0.0033915187));

N999_8 :=__common__( if(((real)c_rest_indx < 64.5), -0.0087214012, N999_9));

N999_7 :=__common__( if(trim(C_REST_INDX) != '', N999_8, -0.0035922515));

N999_6 :=__common__( map(((real)f_varrisktype_i <= NULL) => N999_7,
              ((real)f_varrisktype_i < 3.5)   => 0.0005111699,
                                                 N999_7));

N999_5 :=__common__( map(trim(C_RNT750_P) = ''      => -0.0016767253,
              ((real)c_rnt750_p < 28.25) => 0.0025626212,
                                            -0.0016767253));

N999_4 :=__common__( if(((real)c_unattach < 142.5), N999_5, 0.0054308413));

N999_3 :=__common__( if(trim(C_UNATTACH) != '', N999_4, -0.00021200757));

N999_2 :=__common__( if(((real)f_current_count_d < 0.5), N999_3, N999_6));

N999_1 :=__common__( if(((real)f_current_count_d > NULL), N999_2, 0.00099763897));

N1000_10 :=__common__( map(trim(C_CIV_EMP) = ''              => 0.0049675805,
                ((real)c_civ_emp < 64.4499969482) => -0.001135758,
                                                     0.0049675805));

N1000_9 :=__common__( map(trim(C_ASSAULT) = ''      => 0.0089311178,
               ((real)c_assault < 186.5) => N1000_10,
                                            0.0089311178));

N1000_8 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1000_9, 0.00075719527));

N1000_7 :=__common__( map(((real)r_l70_add_standardized_i <= NULL) => 0.0066409137,
               ((real)r_l70_add_standardized_i < 0.5)   => -0.003007665,
                                                           0.0066409137));

N1000_6 :=__common__( map(trim(C_RETAIL) = ''              => -0.010060887,
               ((real)c_retail < 3.15000009537) => N1000_7,
                                                   -0.010060887));

N1000_5 :=__common__( if(((real)c_popover18 < 596.5), N1000_6, N1000_8));

N1000_4 :=__common__( if(trim(C_POPOVER18) != '', N1000_5, 0.0030597675));

N1000_3 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1000_4, 1.438009e-005));

N1000_2 :=__common__( if(((real)f_inq_adls_per_addr_i < 4.5), N1000_3, 0.0058001117));

N1000_1 :=__common__( if(((real)f_inq_adls_per_addr_i > NULL), N1000_2, -0.011133092));

N1001_8 :=__common__( map(trim(C_HH1_P) = ''              => -0.011731738,
               ((real)c_hh1_p < 32.3000030518) => -0.00059318344,
                                                  -0.011731738));

N1001_7 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => 0.00057524708,
               ((real)f_mos_inq_banko_cm_fseen_d < 44.5)  => 0.0054129212,
                                                             0.00057524708));

N1001_6 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL) => N1001_7,
               ((real)f_fp_prevaddrburglaryindex_i < 30.5)  => 0.0086219579,
                                                               N1001_7));

N1001_5 :=__common__( if(((real)r_c14_addrs_15yr_i < 5.5), -0.0015845612, N1001_6));

N1001_4 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N1001_5, -0.0049639697));

N1001_3 :=__common__( map(trim(C_NEWHOUSE) = ''              => -0.001197239,
               ((real)c_newhouse < 16.0499992371) => N1001_4,
                                                     -0.001197239));

N1001_2 :=__common__( if(((real)c_pop_45_54_p < 22.3499984741), N1001_3, N1001_8));

N1001_1 :=__common__( if(trim(C_POP_45_54_P) != '', N1001_2, -0.00025033143));

N1002_8 :=__common__( map(trim(C_LAR_FAM) = ''     => -0.0051744716,
               ((real)c_lar_fam < 65.5) => 0.0018659777,
                                           -0.0051744716));

N1002_7 :=__common__( map(trim(C_CONSTRUCTION) = ''              => 0.0045388469,
               ((real)c_construction < 18.4500007629) => -0.0021128664,
                                                         0.0045388469));

N1002_6 :=__common__( map(trim(C_FEMDIV_P) = ''              => 0.0045656658,
               ((real)c_femdiv_p < 7.94999980927) => N1002_7,
                                                     0.0045656658));

N1002_5 :=__common__( map(trim(C_NO_LABFOR) = ''     => N1002_6,
               ((real)c_no_labfor < 22.5) => -0.0088715427,
                                             N1002_6));

N1002_4 :=__common__( if(((real)r_pb_order_freq_d > NULL), N1002_5, 0.00052792049));

N1002_3 :=__common__( map(trim(C_HH3_P) = ''              => -0.0060400364,
               ((real)c_hh3_p < 32.5499992371) => N1002_4,
                                                  -0.0060400364));

N1002_2 :=__common__( if(((integer)c_totcrime < 189), N1002_3, N1002_8));

N1002_1 :=__common__( if(trim(C_TOTCRIME) != '', N1002_2, -0.00016374993));

N1003_8 :=__common__( map(trim(C_INCOLLEGE) = ''              => 0.00065726972,
               ((real)c_incollege < 3.54999995232) => 0.01018103,
                                                      0.00065726972));

N1003_7 :=__common__( if(((integer)r_i60_inq_hiriskcred_recency_d < 9), -0.0064642984, -0.0012006476));

N1003_6 :=__common__( if(((real)r_i60_inq_hiriskcred_recency_d > NULL), N1003_7, 0.0020706268));

N1003_5 :=__common__( map(trim(C_POP_75_84_P) = ''              => -0.0057760509,
               ((real)c_pop_75_84_p < 10.4499998093) => 0.00090853408,
                                                        -0.0057760509));

N1003_4 :=__common__( map(((real)c_a49_prop_owned_assessed_tot_d <= NULL)   => -0.006995255,
               ((real)c_a49_prop_owned_assessed_tot_d < 53382.5) => N1003_5,
                                                                    -0.006995255));

N1003_3 :=__common__( map(trim(C_UNEMP) = ''              => N1003_6,
               ((real)c_unemp < 7.64999961853) => N1003_4,
                                                  N1003_6));

N1003_2 :=__common__( if(((real)c_child < 36.9500007629), N1003_3, N1003_8));

N1003_1 :=__common__( if(trim(C_CHILD) != '', N1003_2, -0.0034735512));

N1004_8 :=__common__( map(trim(C_ROBBERY) = ''       => 0.00027739324,
               ((integer)c_robbery < 145) => -0.0039202128,
                                             0.00027739324));

N1004_7 :=__common__( map(trim(C_FAMMAR18_P) = ''              => 0.0029110116,
               ((real)c_fammar18_p < 37.6500015259) => N1004_8,
                                                       0.0029110116));

N1004_6 :=__common__( map(trim(C_WHITE_COL) = ''      => -0.0087849773,
               ((real)c_white_col < 28.75) => 0.0024674764,
                                              -0.0087849773));

N1004_5 :=__common__( map(trim(C_HIGHINC) = ''              => 0.0051368393,
               ((real)c_highinc < 2.45000004768) => N1004_6,
                                                    0.0051368393));

N1004_4 :=__common__( map(((real)f_addrchangeecontrajindex_d <= NULL) => -0.0015616599,
               ((real)f_addrchangeecontrajindex_d < 1.5)   => N1004_5,
                                                              -0.0015616599));

N1004_3 :=__common__( if(((real)c_pop_75_84_p < 2.54999995232), N1004_4, N1004_7));

N1004_2 :=__common__( if(trim(C_POP_75_84_P) != '', N1004_3, 0.001139827));

N1004_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1004_2, 0.00028046625));

N1005_9 :=__common__( map(trim(C_RENTAL) = ''      => 0.0034539136,
               ((real)c_rental < 139.5) => -0.0018469953,
                                           0.0034539136));

N1005_8 :=__common__( if(((integer)f_curraddrcrimeindex_i < 49), -0.0079506157, N1005_9));

N1005_7 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N1005_8, -0.0045107444));

N1005_6 :=__common__( map(trim(C_HH4_P) = ''      => -0.003215904,
               ((real)c_hh4_p < 10.25) => N1005_7,
                                          -0.003215904));

N1005_5 :=__common__( if(((integer)f_curraddrcartheftindex_i < 42), -0.003692598, 0.004270065));

N1005_4 :=__common__( if(((real)f_curraddrcartheftindex_i > NULL), N1005_5, 0.0046904741));

N1005_3 :=__common__( map(trim(C_LARCENY) = ''     => N1005_6,
               ((real)c_larceny < 86.5) => N1005_4,
                                           N1005_6));

N1005_2 :=__common__( if(((real)c_femdiv_p < 3.45000004768), 0.0017349599, N1005_3));

N1005_1 :=__common__( if(trim(C_FEMDIV_P) != '', N1005_2, 0.0029604012));

N1006_9 :=__common__( map(trim(C_SERV_EMPL) = ''     => 0.010175583,
               ((real)c_serv_empl < 96.5) => 0.00057304897,
                                             0.010175583));

N1006_8 :=__common__( if(((real)c_pop_45_54_p < 12.1499996185), N1006_9, 0.00077000925));

N1006_7 :=__common__( if(trim(C_POP_45_54_P) != '', N1006_8, 0.0010246225));

N1006_6 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => -0.0042629748,
               ((real)f_srchssnsrchcount_i < 16.5)  => N1006_7,
                                                       -0.0042629748));

N1006_5 :=__common__( map(trim(C_MED_AGE) = ''              => 0.0065094554,
               ((real)c_med_age < 38.1500015259) => -0.0031855792,
                                                    0.0065094554));

N1006_4 :=__common__( if(((real)c_pop_65_74_p < 10.0500001907), -0.0011468581, N1006_5));

N1006_3 :=__common__( if(trim(C_POP_65_74_P) != '', N1006_4, 0.0017355212));

N1006_2 :=__common__( if(((real)r_d32_criminal_count_i < 4.5), N1006_3, N1006_6));

N1006_1 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N1006_2, 0.0013010244));

N1007_7 :=__common__( map(trim(C_HH1_P) = ''              => 0.0021798974,
               ((real)c_hh1_p < 35.3499984741) => -0.0091232243,
                                                  0.0021798974));

N1007_6 :=__common__( map(trim(C_LAR_FAM) = ''     => 0.0023449224,
               ((real)c_lar_fam < 54.5) => -0.0035127373,
                                           0.0023449224));

N1007_5 :=__common__( map(trim(C_LAR_FAM) = ''     => -0.0045537699,
               ((real)c_lar_fam < 89.5) => 0.0027611608,
                                           -0.0045537699));

N1007_4 :=__common__( map(trim(C_ROBBERY) = ''     => N1007_6,
               ((real)c_robbery < 71.5) => N1007_5,
                                           N1007_6));

N1007_3 :=__common__( map(trim(C_BARGAINS) = ''      => N1007_7,
               ((real)c_bargains < 189.5) => N1007_4,
                                             N1007_7));

N1007_2 :=__common__( map(trim(C_HVAL_400K_P) = ''              => -0.007345074,
               ((real)c_hval_400k_p < 29.0499992371) => N1007_3,
                                                        -0.007345074));

N1007_1 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1007_2, -0.00025939949));

N1008_9 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => 0.0025434476,
               ((real)r_c14_addrs_5yr_i < 5.5)   => -0.0029754023,
                                                    0.0025434476));

N1008_8 :=__common__( map(trim(C_SERV_EMPL) = ''      => N1008_9,
               ((real)c_serv_empl < 162.5) => 0.00091051544,
                                              N1008_9));

N1008_7 :=__common__( if(((real)c_hval_80k_p < 43.4500007629), N1008_8, 0.0051551608));

N1008_6 :=__common__( if(trim(C_HVAL_80K_P) != '', N1008_7, -0.00023022284));

N1008_5 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)         => -0.004429256,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.75946110487) => 0.00788701,
                                                                     -0.004429256));

N1008_4 :=__common__( if(((real)c_pop_6_11_p < 8.75), N1008_5, -0.010027364));

N1008_3 :=__common__( if(trim(C_POP_6_11_P) != '', N1008_4, -0.0010379046));

N1008_2 :=__common__( if(((integer)r_i60_inq_banking_recency_d < 9), N1008_3, N1008_6));

N1008_1 :=__common__( if(((real)r_i60_inq_banking_recency_d > NULL), N1008_2, 0.01139237));

N1009_9 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => 0.0022854237,
               ((real)r_c14_addrs_5yr_i < 6.5)   => -0.0005410804,
                                                    0.0022854237));

N1009_8 :=__common__( if(((real)f_current_count_d < 6.5), N1009_9, -0.006017504));

N1009_7 :=__common__( if(((real)f_current_count_d > NULL), N1009_8, -0.0024430775));

N1009_6 :=__common__( map(trim(C_WHITE_COL) = ''              => N1009_7,
               ((real)c_white_col < 17.1500015259) => -0.0069146534,
                                                      N1009_7));

N1009_5 :=__common__( map(trim(C_FAMILIES) = ''      => 0.0017168777,
               ((real)c_families < 224.5) => 0.012287138,
                                             0.0017168777));

N1009_4 :=__common__( if(((real)f_curraddrcartheftindex_i < 169.5), N1009_5, -0.00061638808));

N1009_3 :=__common__( if(((real)f_curraddrcartheftindex_i > NULL), N1009_4, -0.03296667));

N1009_2 :=__common__( if(((real)c_white_col < 15.5500001907), N1009_3, N1009_6));

N1009_1 :=__common__( if(trim(C_WHITE_COL) != '', N1009_2, 0.001198076));

N1010_9 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)    => 0.0065174417,
               ((integer)f_prevaddrmedianvalue_d < 84905) => -0.0052877967,
                                                             0.0065174417));

N1010_8 :=__common__( map(trim(C_FEMDIV_P) = ''              => N1010_9,
               ((real)c_femdiv_p < 4.35000038147) => 0.0098984138,
                                                     N1010_9));

N1010_7 :=__common__( map(trim(C_POP_45_54_P) = ''              => 1.5375368e-005,
               ((real)c_pop_45_54_p < 7.85000038147) => -0.0076691969,
                                                        1.5375368e-005));

N1010_6 :=__common__( if(((real)f_m_bureau_adl_fs_all_d < 252.5), N1010_7, N1010_8));

N1010_5 :=__common__( if(((real)f_m_bureau_adl_fs_all_d > NULL), N1010_6, -0.0083296571));

N1010_4 :=__common__( if(((real)c_hval_200k_p < 10.5500001907), N1010_5, -0.0048608989));

N1010_3 :=__common__( if(trim(C_HVAL_200K_P) != '', N1010_4, -0.0023753666));

N1010_2 :=__common__( map(trim(C_HVAL_200K_P) = ''              => 0.0097284643,
               ((real)c_hval_200k_p < 21.6500015259) => -0.00031227867,
                                                        0.0097284643));

N1010_1 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1010_2, N1010_3));

N1011_9 :=__common__( map(trim(C_RNT1000_P) = ''              => 0.0097548661,
               ((real)c_rnt1000_p < 3.95000004768) => -2.3623154e-005,
                                                      0.0097548661));

N1011_8 :=__common__( map(trim(C_HH2_P) = ''              => 0.015295046,
               ((real)c_hh2_p < 33.1500015259) => N1011_9,
                                                  0.015295046));

N1011_7 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.108779266477), 0.0010254866, N1011_8));

N1011_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1011_7, 0.0037539288));

N1011_5 :=__common__( if(((real)f_prevaddrlenofres_d < 8.5), -0.0021399945, N1011_6));

N1011_4 :=__common__( if(((real)f_prevaddrlenofres_d > NULL), N1011_5, 0.013422903));

N1011_3 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => -0.002862006,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.961090803146) => N1011_4,
                                                                      -0.002862006));

N1011_2 :=__common__( if(((real)c_no_teens < 20.5), N1011_3, 0.00015121958));

N1011_1 :=__common__( if(trim(C_NO_TEENS) != '', N1011_2, -0.0010476405));

N1012_10 :=__common__( map(trim(C_RETAIL) = ''              => -0.0033574327,
                ((real)c_retail < 1.34999990463) => 0.0056525624,
                                                    -0.0033574327));

N1012_9 :=__common__( if(((real)c_professional < 3.45000004768), N1012_10, 0.0078034236));

N1012_8 :=__common__( if(trim(C_PROFESSIONAL) != '', N1012_9, 0.0010893822));

N1012_7 :=__common__( if(((real)c_newhouse < 18.0499992371), 0.0028207763, -0.005325597));

N1012_6 :=__common__( if(trim(C_NEWHOUSE) != '', N1012_7, 0.0030170582));

N1012_5 :=__common__( if(((real)f_rel_educationover12_count_d < 8.5), N1012_6, 0.0070556304));

N1012_4 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N1012_5, 0.00078516787));

N1012_3 :=__common__( map(((real)c_addr_lres_6mo_ct_i <= NULL) => -0.001059385,
               ((real)c_addr_lres_6mo_ct_i < 0.5)   => N1012_4,
                                                       -0.001059385));

N1012_2 :=__common__( if(((real)f_srchfraudsrchcountmo_i < 0.5), N1012_3, N1012_8));

N1012_1 :=__common__( if(((real)f_srchfraudsrchcountmo_i > NULL), N1012_2, 0.0013712401));

N1013_10 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL) => 0.0018797287,
                ((real)f_prevaddrmurderindex_i < 174.5) => -0.005648586,
                                                           0.0018797287));

N1013_9 :=__common__( if(((real)c_hval_100k_p < 7.25), 0.0096617579, -0.00044838336));

N1013_8 :=__common__( if(trim(C_HVAL_100K_P) != '', N1013_9, -0.0058802856));

N1013_7 :=__common__( if(((real)c_hh3_p < 17.6500015259), 0.0013476965, -0.010474791));

N1013_6 :=__common__( if(trim(C_HH3_P) != '', N1013_7, -0.035175839));

N1013_5 :=__common__( map(((real)f_inq_per_addr_i <= NULL) => N1013_6,
               ((real)f_inq_per_addr_i < 12.5)  => 0.0003328955,
                                                   N1013_6));

N1013_4 :=__common__( map(((real)f_util_adl_count_n <= NULL) => N1013_8,
               ((real)f_util_adl_count_n < 12.5)  => N1013_5,
                                                     N1013_8));

N1013_3 :=__common__( if(((real)f_inq_per_addr_i > NULL), N1013_4, 0.00083583376));

N1013_2 :=__common__( if(((real)f_prevaddrageoldest_d < 149.5), N1013_3, N1013_10));

N1013_1 :=__common__( if(((real)f_prevaddrageoldest_d > NULL), N1013_2, -0.0064340302));

N1014_8 :=__common__( map(trim(C_HH3_P) = ''              => -0.0020234208,
               ((real)c_hh3_p < 18.9500007629) => 0.0077396326,
                                                  -0.0020234208));

N1014_7 :=__common__( map(trim(C_MED_AGE) = ''      => 0.0058251814,
               ((real)c_med_age < 30.75) => -0.0040824381,
                                            0.0058251814));

N1014_6 :=__common__( if(((real)r_a46_curr_avm_autoval_d < 145672.5), -0.0024822437, 0.0047414216));

N1014_5 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N1014_6, -0.0008992126));

N1014_4 :=__common__( map(trim(C_RETAIL) = ''              => N1014_7,
               ((real)c_retail < 32.1500015259) => N1014_5,
                                                   N1014_7));

N1014_3 :=__common__( map(trim(C_FAMOTF18_P) = ''              => N1014_8,
               ((real)c_famotf18_p < 56.9500007629) => N1014_4,
                                                       N1014_8));

N1014_2 :=__common__( if(((real)c_inc_15k_p < 3.84999990463), 0.003639394, N1014_3));

N1014_1 :=__common__( if(trim(C_INC_15K_P) != '', N1014_2, 0.0040141543));

N1015_7 :=__common__( map(trim(C_RNT250_P) = ''              => -0.0021072604,
               ((real)c_rnt250_p < 7.05000019073) => 0.00035969657,
                                                     -0.0021072604));

N1015_6 :=__common__( map(trim(C_RENTOCC_P) = ''              => 0.00010770933,
               ((real)c_rentocc_p < 48.6500015259) => 0.0099161297,
                                                      0.00010770933));

N1015_5 :=__common__( if(((real)c_hhsize < 2.06500005722), N1015_6, N1015_7));

N1015_4 :=__common__( if(trim(C_HHSIZE) != '', N1015_5, -0.0023608576));

N1015_3 :=__common__( if(((real)c_rape < 117.5), -0.00048482965, 0.010082341));

N1015_2 :=__common__( if(trim(C_RAPE) != '', N1015_3, 0.026214093));

N1015_1 :=__common__( map(((real)c_comb_age_d <= NULL) => N1015_4,
               ((real)c_comb_age_d < 21.5)  => N1015_2,
                                               N1015_4));

N1016_7 :=__common__( map(trim(C_POP_25_34_P) = ''              => 0.0027958406,
               ((real)c_pop_25_34_p < 7.55000019073) => 0.010055643,
                                                        0.0027958406));

N1016_6 :=__common__( map(((real)f_corrrisktype_i <= NULL) => 0.0086114209,
               ((real)f_corrrisktype_i < 7.5)   => -0.0013908324,
                                                   0.0086114209));

N1016_5 :=__common__( map(trim(C_HEALTH) = ''              => -0.0086584555,
               ((real)c_health < 19.6500015259) => N1016_6,
                                                   -0.0086584555));

N1016_4 :=__common__( map(trim(C_WHITE_COL) = ''              => N1016_7,
               ((real)c_white_col < 17.4500007629) => N1016_5,
                                                      N1016_7));

N1016_3 :=__common__( map(trim(C_UNEMPL) = ''     => N1016_4,
               ((real)c_unempl < 92.5) => -0.0056197102,
                                          N1016_4));

N1016_2 :=__common__( if(((real)c_no_car < 165.5), -0.00065687929, N1016_3));

N1016_1 :=__common__( if(trim(C_NO_CAR) != '', N1016_2, 0.0013118033));

N1017_9 :=__common__( map(trim(C_REST_INDX) = ''     => 0.0024015842,
               ((real)c_rest_indx < 75.5) => -0.0093190262,
                                             0.0024015842));

N1017_8 :=__common__( map(trim(C_INC_35K_P) = ''     => N1017_9,
               ((real)c_inc_35k_p < 7.75) => -0.013020599,
                                             N1017_9));

N1017_7 :=__common__( if(((real)f_rel_bankrupt_count_i < 3.5), 0.0017533605, N1017_8));

N1017_6 :=__common__( if(((real)f_rel_bankrupt_count_i > NULL), N1017_7, 0.0053721126));

N1017_5 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), 0.00023569832, N1017_6));

N1017_4 :=__common__( map(trim(C_RURAL_P) = ''              => -0.010226904,
               ((real)c_rural_p < 38.5999984741) => -0.00014406851,
                                                    -0.010226904));

N1017_3 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => -0.0096499603,
               ((real)f_inq_per_ssn_i < 8.5)   => N1017_4,
                                                  -0.0096499603));

N1017_2 :=__common__( if(((real)c_popover25 < 677.5), N1017_3, N1017_5));

N1017_1 :=__common__( if(trim(C_POPOVER25) != '', N1017_2, 0.00099470836));

N1018_10 :=__common__( if(((real)c_hh3_p < 16.75), -0.00098950032, 0.0097754057));

N1018_9 :=__common__( if(trim(C_HH3_P) != '', N1018_10, -0.040128246));

N1018_8 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL)  => -0.0079996126,
               ((integer)r_d33_eviction_recency_d < 549) => 0.0026798814,
                                                            -0.0079996126));

N1018_7 :=__common__( map(trim(C_HVAL_175K_P) = ''     => -0.00030650552,
               ((real)c_hval_175k_p < 7.25) => 0.0037560984,
                                               -0.00030650552));

N1018_6 :=__common__( if(((real)c_inc_100k_p < 9.94999980927), -0.00095448929, N1018_7));

N1018_5 :=__common__( if(trim(C_INC_100K_P) != '', N1018_6, -0.0025404168));

N1018_4 :=__common__( if(((integer)f_curraddrmedianvalue_d < 310689), N1018_5, N1018_8));

N1018_3 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N1018_4, 0.0093356824));

N1018_2 :=__common__( if(((real)r_l79_adls_per_addr_c6_i < 4.5), N1018_3, N1018_9));

N1018_1 :=__common__( if(((real)r_l79_adls_per_addr_c6_i > NULL), N1018_2, 0.049519319));

N1019_8 :=__common__( map(trim(C_HEALTH) = ''      => -0.0078237131,
               ((real)c_health < 20.25) => -0.0010352832,
                                           -0.0078237131));

N1019_7 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL) => N1019_8,
               ((integer)r_d33_eviction_recency_d < 30) => 0.0056662766,
                                                           N1019_8));

N1019_6 :=__common__( map(trim(C_FAMILIES) = ''      => 0.0011012843,
               ((real)c_families < 152.5) => 0.0067481007,
                                             0.0011012843));

N1019_5 :=__common__( map(trim(C_HVAL_100K_P) = ''              => N1019_7,
               ((real)c_hval_100k_p < 20.0499992371) => N1019_6,
                                                        N1019_7));

N1019_4 :=__common__( if(((integer)f_prevaddrmurderindex_i < 81), -0.0018905706, N1019_5));

N1019_3 :=__common__( if(((real)f_prevaddrmurderindex_i > NULL), N1019_4, 0.010478709));

N1019_2 :=__common__( if(((real)c_lar_fam < 169.5), N1019_3, -0.0048610954));

N1019_1 :=__common__( if(trim(C_LAR_FAM) != '', N1019_2, 0.0027836315));

N1020_9 :=__common__( map(trim(C_MURDERS) = ''     => -0.005835252,
               ((real)c_murders < 82.5) => 0.003422882,
                                           -0.005835252));

N1020_8 :=__common__( map(trim(C_BEL_EDU) = ''      => 0.0033910385,
               ((real)c_bel_edu < 116.5) => 0.014803315,
                                            0.0033910385));

N1020_7 :=__common__( map(trim(C_ARMFORCE) = ''      => 0.00047996298,
               ((real)c_armforce < 127.5) => N1020_8,
                                             0.00047996298));

N1020_6 :=__common__( if(((real)r_d30_derog_count_i < 3.5), N1020_7, N1020_9));

N1020_5 :=__common__( if(((real)r_d30_derog_count_i > NULL), N1020_6, 0.031540299));

N1020_4 :=__common__( if(((real)f_corrphonelastnamecount_d < 2.5), -0.00057378793, 0.0050690957));

N1020_3 :=__common__( if(((real)f_corrphonelastnamecount_d > NULL), N1020_4, 0.0025589999));

N1020_2 :=__common__( if(((real)c_inc_100k_p < 17.1500015259), N1020_3, N1020_5));

N1020_1 :=__common__( if(trim(C_INC_100K_P) != '', N1020_2, -0.00012388289));

N1021_9 :=__common__( if(((real)f_rel_homeover50_count_d < 3.5), 0.0097939343, 0.00043530989));

N1021_8 :=__common__( if(((real)f_rel_homeover50_count_d > NULL), N1021_9, -0.0029585531));

N1021_7 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => 0.00063510744,
               ((real)r_d32_mos_since_crim_ls_d < 211.5) => 0.010827397,
                                                            0.00063510744));

N1021_6 :=__common__( map(trim(C_CPIALL) = ''              => -0.0012481773,
               ((real)c_cpiall < 209.300003052) => N1021_7,
                                                   -0.0012481773));

N1021_5 :=__common__( map(((real)f_rel_criminal_count_i <= NULL) => -0.0010523294,
               ((real)f_rel_criminal_count_i < 3.5)   => -0.011359166,
                                                         -0.0010523294));

N1021_4 :=__common__( if(((real)c_cpiall < 203.600006104), N1021_5, N1021_6));

N1021_3 :=__common__( if(trim(C_CPIALL) != '', N1021_4, 0.00024431498));

N1021_2 :=__common__( if(((real)f_srchfraudsrchcount_i < 7.5), N1021_3, N1021_8));

N1021_1 :=__common__( if(((real)f_srchfraudsrchcount_i > NULL), N1021_2, -0.00061714738));

N1022_10 :=__common__( map(trim(C_RENTAL) = ''      => 0.0033956702,
                ((real)c_rental < 173.5) => -0.0030181842,
                                            0.0033956702));

N1022_9 :=__common__( map(trim(C_MED_HVAL) = ''         => N1022_10,
               ((integer)c_med_hval < 69403) => 0.0045581058,
                                                N1022_10));

N1022_8 :=__common__( if(((real)c_no_car < 181.5), N1022_9, -0.0053579002));

N1022_7 :=__common__( if(trim(C_NO_CAR) != '', N1022_8, -0.0024513842));

N1022_6 :=__common__( if(((real)c_blue_empl < 46.5), -0.0062415587, 0.0026439729));

N1022_5 :=__common__( if(trim(C_BLUE_EMPL) != '', N1022_6, 0.0018577617));

N1022_4 :=__common__( if(((real)f_addrchangecrimediff_i < 95.5), -0.00028610179, 0.010167477));

N1022_3 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N1022_4, N1022_5));

N1022_2 :=__common__( if(((real)c_addr_lres_12mo_ct_i < 5.5), N1022_3, N1022_7));

N1022_1 :=__common__( if(((real)c_addr_lres_12mo_ct_i > NULL), N1022_2, -0.0027133577));

N1023_11 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => 1.2461815e-005,
                ((real)r_c10_m_hdr_fs_d < 91.5)  => 0.0077608769,
                                                    1.2461815e-005));

N1023_10 :=__common__( if(((real)c_hval_60k_p < 20.75), N1023_11, 0.0067104442));

N1023_9 :=__common__( if(trim(C_HVAL_60K_P) != '', N1023_10, -0.0071879906));

N1023_8 :=__common__( if(((real)f_srchfraudsrchcount_i < 7.5), -0.0010112127, N1023_9));

N1023_7 :=__common__( if(((real)f_srchfraudsrchcount_i > NULL), N1023_8, -0.0041306789));

N1023_6 :=__common__( map(trim(C_HH3_P) = ''      => -0.0008511674,
               ((real)c_hh3_p < 12.25) => 0.011164214,
                                          -0.0008511674));

N1023_5 :=__common__( if(((real)c_pop_25_34_p < 12.5500001907), -0.0043388569, N1023_6));

N1023_4 :=__common__( if(trim(C_POP_25_34_P) != '', N1023_5, -0.011300307));

N1023_3 :=__common__( if(((real)f_componentcharrisktype_i < 5.5), N1023_4, 0.0063108409));

N1023_2 :=__common__( if(((real)f_componentcharrisktype_i > NULL), N1023_3, 0.009856585));

N1023_1 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), N1023_2, N1023_7));

N1024_8 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => -0.0020783086,
               ((real)f_add_input_nhood_vac_pct_i < 0.0490596964955) => 0.0081805694,
                                                                        -0.0020783086));

N1024_7 :=__common__( map(((real)f_assocsuspicousidcount_i <= NULL) => 0.0013069143,
               ((real)f_assocsuspicousidcount_i < 7.5)   => -0.0090843122,
                                                            0.0013069143));

N1024_6 :=__common__( map(trim(C_BURGLARY) = ''      => 0.0075152625,
               ((real)c_burglary < 152.5) => -0.0024859631,
                                             0.0075152625));

N1024_5 :=__common__( if(((real)f_inq_count24_i < 3.5), N1024_6, N1024_7));

N1024_4 :=__common__( if(((real)f_inq_count24_i > NULL), N1024_5, -0.015407011));

N1024_3 :=__common__( map(trim(C_FINANCE) = ''              => N1024_8,
               ((real)c_finance < 2.45000004768) => N1024_4,
                                                    N1024_8));

N1024_2 :=__common__( if(((real)c_hh7p_p < 3.04999995232), 0.00079087298, N1024_3));

N1024_1 :=__common__( if(trim(C_HH7P_P) != '', N1024_2, -0.0037728615));

N1025_8 :=__common__( map(trim(C_HH4_P) = ''              => -0.0028874715,
               ((real)c_hh4_p < 18.1500015259) => 0.0032353946,
                                                  -0.0028874715));

N1025_7 :=__common__( map(trim(C_HIGH_ED) = ''     => -0.003987232,
               ((real)c_high_ed < 3.75) => 0.0034969265,
                                           -0.003987232));

N1025_6 :=__common__( if(((real)f_srchfraudsrchcount_i < 3.5), N1025_7, 0.00031584856));

N1025_5 :=__common__( if(((real)f_srchfraudsrchcount_i > NULL), N1025_6, 0.0009748052));

N1025_4 :=__common__( map(trim(C_HH2_P) = ''              => -0.0053177655,
               ((real)c_hh2_p < 42.5499992371) => N1025_5,
                                                  -0.0053177655));

N1025_3 :=__common__( map(trim(C_FAMILIES) = ''      => 0.0058161917,
               ((real)c_families < 649.5) => N1025_4,
                                             0.0058161917));

N1025_2 :=__common__( if(((real)c_business < 27.5), N1025_3, N1025_8));

N1025_1 :=__common__( if(trim(C_BUSINESS) != '', N1025_2, 0.0018884636));

N1026_8 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => -0.0023536147,
               ((integer)f_curraddrmurderindex_i < 52) => -0.011647692,
                                                          -0.0023536147));

N1026_7 :=__common__( if(((real)f_historical_count_d < 0.5), N1026_8, -0.00028286497));

N1026_6 :=__common__( if(((real)f_historical_count_d > NULL), N1026_7, -0.0066361051));

N1026_5 :=__common__( map(((real)c_comb_age_d <= NULL) => N1026_6,
               ((real)c_comb_age_d < 23.5)  => 0.0025633892,
                                               N1026_6));

N1026_4 :=__common__( map(trim(C_BUSINESS) = ''    => -0.00070062012,
               ((real)c_business < 7.5) => 0.0099161146,
                                           -0.00070062012));

N1026_3 :=__common__( map(trim(C_POP_55_64_P) = ''              => N1026_5,
               ((real)c_pop_55_64_p < 3.15000009537) => N1026_4,
                                                        N1026_5));

N1026_2 :=__common__( if(((real)c_hval_20k_p < 27.8499984741), N1026_3, 0.0067669412));

N1026_1 :=__common__( if(trim(C_HVAL_20K_P) != '', N1026_2, -0.00028295146));

N1027_8 :=__common__( map(((real)f_assocsuspicousidcount_i <= NULL) => 0.0072991142,
               ((real)f_assocsuspicousidcount_i < 17.5)  => -0.00044152862,
                                                            0.0072991142));

N1027_7 :=__common__( if(((real)c_occunit_p < 89.75), -0.011528948, 0.00029255572));

N1027_6 :=__common__( if(trim(C_OCCUNIT_P) != '', N1027_7, 0.001457605));

N1027_5 :=__common__( map(((real)f_fp_prevaddrcrimeindex_i <= NULL) => 0.0048037564,
               ((real)f_fp_prevaddrcrimeindex_i < 155.5) => N1027_6,
                                                            0.0048037564));

N1027_4 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => N1027_5,
               ((real)r_c21_m_bureau_adl_fs_d < 147.5) => 0.0071047688,
                                                          N1027_5));

N1027_3 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => N1027_4,
               ((real)f_srchssnsrchcount_i < 2.5)   => 0.012088292,
                                                       N1027_4));

N1027_2 :=__common__( if(((real)f_mos_liens_unrel_lt_lseen_d < 93.5), N1027_3, N1027_8));

N1027_1 :=__common__( if(((real)f_mos_liens_unrel_lt_lseen_d > NULL), N1027_2, -0.0011884454));

N1028_9 :=__common__( map(trim(C_NEW_HOMES) = ''     => -0.00074216746,
               ((real)c_new_homes < 97.5) => 0.011516539,
                                             -0.00074216746));

N1028_8 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => 0.0014975524,
               ((real)r_c14_addrs_5yr_i < 3.5)   => -0.0022079332,
                                                    0.0014975524));

N1028_7 :=__common__( map(trim(C_RICH_BLK) = ''      => N1028_9,
               ((real)c_rich_blk < 178.5) => N1028_8,
                                             N1028_9));

N1028_6 :=__common__( map(((real)f_srchvelocityrisktype_i <= NULL) => -0.0051024313,
               ((real)f_srchvelocityrisktype_i < 7.5)   => N1028_7,
                                                           -0.0051024313));

N1028_5 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d < 12.5), 0.0073371842, N1028_6));

N1028_4 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d > NULL), N1028_5, 0.0017735472));

N1028_3 :=__common__( if(((real)r_pb_order_freq_d > NULL), 0.00029050427, N1028_4));

N1028_2 :=__common__( if(((real)c_blue_col < 6.44999980927), -0.005191387, N1028_3));

N1028_1 :=__common__( if(trim(C_BLUE_COL) != '', N1028_2, -0.00086131225));

N1029_8 :=__common__( map(trim(C_HIGH_ED) = ''              => -0.0043044768,
               ((real)c_high_ed < 36.8499984741) => 0.0051394172,
                                                    -0.0043044768));

N1029_7 :=__common__( map(trim(C_INC_200K_P) = ''              => N1029_8,
               ((real)c_inc_200k_p < 1.04999995232) => -0.00038524939,
                                                       N1029_8));

N1029_6 :=__common__( map(trim(C_AB_AV_EDU) = ''     => 0.00041878321,
               ((real)c_ab_av_edu < 58.5) => -0.0063807952,
                                             0.00041878321));

N1029_5 :=__common__( map(trim(C_LOWRENT) = ''              => N1029_6,
               ((real)c_lowrent < 65.8500061035) => 0.00029898962,
                                                    N1029_6));

N1029_4 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 211.5), N1029_5, N1029_7));

N1029_3 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N1029_4, 0.00096983448));

N1029_2 :=__common__( if(((real)c_cpiall < 225.850006104), N1029_3, -0.0085562253));

N1029_1 :=__common__( if(trim(C_CPIALL) != '', N1029_2, -0.00010098113));

N1030_8 :=__common__( map(trim(C_BORN_USA) = ''      => -0.0077318647,
               ((real)c_born_usa < 146.5) => 0.0043141607,
                                             -0.0077318647));

N1030_7 :=__common__( map(trim(C_FEMDIV_P) = ''              => 0.00080475947,
               ((real)c_femdiv_p < 5.14999961853) => 0.011121321,
                                                     0.00080475947));

N1030_6 :=__common__( map(trim(C_HH4_P) = ''              => N1030_8,
               ((real)c_hh4_p < 12.0500001907) => N1030_7,
                                                  N1030_8));

N1030_5 :=__common__( map(trim(C_UNEMPL) = ''     => N1030_6,
               ((real)c_unempl < 91.5) => 0.012895168,
                                          N1030_6));

N1030_4 :=__common__( if(((real)c_oldhouse < 329.450012207), N1030_5, -0.0036559517));

N1030_3 :=__common__( if(trim(C_OLDHOUSE) != '', N1030_4, -0.0023739763));

N1030_2 :=__common__( if(((real)f_prevaddrcartheftindex_i < 188.5), -0.00070530145, N1030_3));

N1030_1 :=__common__( if(((real)f_prevaddrcartheftindex_i > NULL), N1030_2, 0.0078167859));

N1031_9 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => -0.0025726292,
               ((real)f_mos_inq_banko_om_fseen_d < 45.5)  => 0.0078319755,
                                                             -0.0025726292));

N1031_8 :=__common__( map(((real)f_util_add_curr_misc_n <= NULL) => N1031_9,
               ((real)f_util_add_curr_misc_n < 0.5)   => -0.0061511259,
                                                         N1031_9));

N1031_7 :=__common__( if(((real)c_hh3_p < 11.3500003815), 0.010023076, N1031_8));

N1031_6 :=__common__( if(trim(C_HH3_P) != '', N1031_7, 0.01200587));

N1031_5 :=__common__( if(((real)c_mort_indx < 67.5), -0.0085064599, -0.0018904848));

N1031_4 :=__common__( if(trim(C_MORT_INDX) != '', N1031_5, -0.0068694732));

N1031_3 :=__common__( map(((real)r_i60_inq_banking_count12_i <= NULL) => N1031_4,
               ((real)r_i60_inq_banking_count12_i < 0.5)   => 0.00013668274,
                                                              N1031_4));

N1031_2 :=__common__( if(((real)f_srchfraudsrchcountmo_i < 0.5), N1031_3, N1031_6));

N1031_1 :=__common__( if(((real)f_srchfraudsrchcountmo_i > NULL), N1031_2, -0.0038459425));

N1032_8 :=__common__( map(trim(C_HHSIZE) = ''              => 0.0098630026,
               ((real)c_hhsize < 2.81500005722) => -0.00011183757,
                                                   0.0098630026));

N1032_7 :=__common__( map(trim(C_POP_18_24_P) = ''              => -0.00624634,
               ((real)c_pop_18_24_p < 16.3499984741) => 0.0018205683,
                                                        -0.00624634));

N1032_6 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 133.5), 0.005475922, -0.0013077633));

N1032_5 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N1032_6, -0.011347788));

N1032_4 :=__common__( map(trim(C_SFDU_P) = ''              => N1032_7,
               ((real)c_sfdu_p < 65.5500030518) => N1032_5,
                                                   N1032_7));

N1032_3 :=__common__( map(trim(C_WHITE_COL) = ''              => -0.0071474984,
               ((real)c_white_col < 51.4500007629) => N1032_4,
                                                      -0.0071474984));

N1032_2 :=__common__( if(((real)c_pop_12_17_p < 15.5500001907), N1032_3, N1032_8));

N1032_1 :=__common__( if(trim(C_POP_12_17_P) != '', N1032_2, 0.0059066275));

N1033_8 :=__common__( map((fp_segment in ['2 NAS 479', '3 New DID', '6 Recent Activity'])       => -0.0040350667,
               (fp_segment in ['1 SSN Prob', '4 Bureau Only', '5 Derog', '7 Other']) => 0.002632924,
                                                                                        0.002632924));

N1033_7 :=__common__( map(trim(C_FAMOTF18_P) = ''              => -0.010473779,
               ((real)c_famotf18_p < 21.9500007629) => 0.0020104335,
                                                       -0.010473779));

N1033_6 :=__common__( map(trim(C_NEW_HOMES) = ''     => N1033_7,
               ((real)c_new_homes < 79.5) => 0.0058914332,
                                             N1033_7));

N1033_5 :=__common__( map(trim(C_POP_65_74_P) = ''              => 0.0065239603,
               ((real)c_pop_65_74_p < 4.64999961853) => N1033_6,
                                                        0.0065239603));

N1033_4 :=__common__( if(((integer)f_addrchangeincomediff_d < -8559), -0.00093457272, N1033_5));

N1033_3 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1033_4, N1033_8));

N1033_2 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i < 136.5), N1033_3, -0.00079822437));

N1033_1 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i > NULL), N1033_2, 0.0011504423));

N1034_8 :=__common__( map(trim(C_EASIQLIFE) = ''     => 0.0010437374,
               ((real)c_easiqlife < 80.5) => -0.0020007996,
                                             0.0010437374));

N1034_7 :=__common__( map(trim(C_NO_CAR) = ''     => N1034_8,
               ((real)c_no_car < 50.5) => -0.0070035774,
                                          N1034_8));

N1034_6 :=__common__( map(trim(C_RAPE) = ''      => N1034_7,
               ((integer)c_rape < 50) => 0.0039870775,
                                         N1034_7));

N1034_5 :=__common__( map(trim(C_CONSTRUCTION) = ''              => -0.0015948914,
               ((real)c_construction < 3.54999995232) => 0.0072633494,
                                                         -0.0015948914));

N1034_4 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.0234458297491), N1034_5, -0.0047696595));

N1034_3 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1034_4, -0.0016941843));

N1034_2 :=__common__( if(((real)c_rentocc_p < 22.3499984741), N1034_3, N1034_6));

N1034_1 :=__common__( if(trim(C_RENTOCC_P) != '', N1034_2, -0.00098941844));

N1035_9 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 139.5), -0.00228699, 0.00078304967));

N1035_8 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N1035_9, -0.0064896407));

N1035_7 :=__common__( map(trim(C_HIGH_ED) = ''      => -0.010694704,
               ((real)c_high_ed < 42.75) => N1035_8,
                                            -0.010694704));

N1035_6 :=__common__( map(trim(C_BIGAPT_P) = ''              => 0.0018480979,
               ((real)c_bigapt_p < 1.65000009537) => N1035_7,
                                                     0.0018480979));

N1035_5 :=__common__( map(trim(C_BLUE_EMPL) = ''     => -0.010453925,
               ((real)c_blue_empl < 69.5) => -0.0015385054,
                                             -0.010453925));

N1035_4 :=__common__( if(((real)c_dist_input_to_prev_addr_i > NULL), N1035_5, -0.0039700838));

N1035_3 :=__common__( map(trim(C_RNT500_P) = ''              => N1035_4,
               ((real)c_rnt500_p < 5.55000019073) => 0.0039075909,
                                                     N1035_4));

N1035_2 :=__common__( if(((real)c_sfdu_p < 23.75), N1035_3, N1035_6));

N1035_1 :=__common__( if(trim(C_SFDU_P) != '', N1035_2, 0.0020432811));

N1036_9 :=__common__( map(trim(C_INC_25K_P) = ''      => 0.0051272905,
               ((real)c_inc_25k_p < 21.75) => 0.00037185529,
                                              0.0051272905));

N1036_8 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => -0.0027897277,
               ((real)f_curraddrmedianincome_d < 28437.5) => 0.0049861451,
                                                             -0.0027897277));

N1036_7 :=__common__( if(((real)r_a50_pb_average_dollars_d < 30.5), -0.0089130384, N1036_8));

N1036_6 :=__common__( if(((real)r_a50_pb_average_dollars_d > NULL), N1036_7, 0.0048782735));

N1036_5 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), -0.0013121374, N1036_6));

N1036_4 :=__common__( map(trim(C_HVAL_750K_P) = ''     => 0.0056534955,
               ((real)c_hval_750k_p < 7.75) => N1036_5,
                                               0.0056534955));

N1036_3 :=__common__( map(trim(C_RNT2000_P) = ''      => -0.0079027935,
               ((real)c_rnt2000_p < 14.75) => N1036_4,
                                              -0.0079027935));

N1036_2 :=__common__( if(((real)c_rnt750_p < 22.9500007629), N1036_3, N1036_9));

N1036_1 :=__common__( if(trim(C_RNT750_P) != '', N1036_2, 0.0018010101));

N1037_8 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => -0.0073526762,
               ((real)r_d30_derog_count_i < 0.5)   => 0.0022021202,
                                                      -0.0073526762));

N1037_7 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => 0.0023291454,
               ((real)f_srchfraudsrchcount_i < 9.5)   => N1037_8,
                                                         0.0023291454));

N1037_6 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => 0.0020522833,
               ((real)r_c10_m_hdr_fs_d < 252.5) => -0.0030438766,
                                                   0.0020522833));

N1037_5 :=__common__( if(((real)f_rel_count_i < 21.5), 0.0015720332, N1037_6));

N1037_4 :=__common__( if(((real)f_rel_count_i > NULL), N1037_5, -0.00066905027));

N1037_3 :=__common__( map(trim(C_UNATTACH) = ''      => N1037_7,
               ((real)c_unattach < 151.5) => N1037_4,
                                             N1037_7));

N1037_2 :=__common__( if(((real)c_hh3_p < 2.84999990463), -0.0060085616, N1037_3));

N1037_1 :=__common__( if(trim(C_HH3_P) != '', N1037_2, 0.0012460958));

N1038_9 :=__common__( if(((real)r_d33_eviction_count_i < 1.5), 0.00073178202, -0.0042291488));

N1038_8 :=__common__( if(((real)r_d33_eviction_count_i > NULL), N1038_9, -0.012882443));

N1038_7 :=__common__( map(trim(C_NEW_HOMES) = ''      => N1038_8,
               ((real)c_new_homes < 140.5) => -0.0098039211,
                                              N1038_8));

N1038_6 :=__common__( if(((real)f_mos_acc_lseen_d < 95.5), -0.0029231165, 0.0014805483));

N1038_5 :=__common__( if(((real)f_mos_acc_lseen_d > NULL), N1038_6, 0.0096787104));

N1038_4 :=__common__( map(trim(C_NEW_HOMES) = ''      => N1038_7,
               ((real)c_new_homes < 136.5) => N1038_5,
                                              N1038_7));

N1038_3 :=__common__( map(trim(C_MED_RENT) = ''        => -0.0075208433,
               ((integer)c_med_rent < 1239) => N1038_4,
                                               -0.0075208433));

N1038_2 :=__common__( if(((real)c_hval_400k_p < 41.1500015259), N1038_3, 0.0089752007));

N1038_1 :=__common__( if(trim(C_HVAL_400K_P) != '', N1038_2, 0.00063829696));

N1039_8 :=__common__( map(trim(C_UNEMP) = ''              => -0.010278374,
               ((real)c_unemp < 5.64999961853) => -0.0012580561,
                                                  -0.010278374));

N1039_7 :=__common__( map(trim(C_VACANT_P) = ''      => 0.0014242207,
               ((real)c_vacant_p < 16.75) => N1039_8,
                                             0.0014242207));

N1039_6 :=__common__( map(((real)f_inq_lnames_per_addr_i <= NULL) => 0.0069733429,
               ((real)f_inq_lnames_per_addr_i < 3.5)   => 0.00080363881,
                                                          0.0069733429));

N1039_5 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => N1039_6,
               ((real)r_c14_addrs_15yr_i < 2.5)   => -0.0037966674,
                                                     N1039_6));

N1039_4 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 51.5), -0.0017313196, N1039_5));

N1039_3 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N1039_4, 0.0052217445));

N1039_2 :=__common__( if(((real)c_rnt500_p < 60.4500007629), N1039_3, N1039_7));

N1039_1 :=__common__( if(trim(C_RNT500_P) != '', N1039_2, 7.3876386e-005));

N1040_10 :=__common__( map(trim(C_HH7P_P) = ''              => 0.0077112051,
                ((real)c_hh7p_p < 3.45000004768) => -0.0029551763,
                                                    0.0077112051));

N1040_9 :=__common__( map(((real)f_assocsuspicousidcount_i <= NULL) => 2.1050811e-005,
               ((real)f_assocsuspicousidcount_i < 4.5)   => 0.011183378,
                                                            2.1050811e-005));

N1040_8 :=__common__( map(((real)f_corraddrphonecount_d <= NULL) => N1040_10,
               ((real)f_corraddrphonecount_d < 0.5)   => N1040_9,
                                                         N1040_10));

N1040_7 :=__common__( if(((real)c_rentocc_p < 58.8499984741), N1040_8, -0.0083013224));

N1040_6 :=__common__( if(trim(C_RENTOCC_P) != '', N1040_7, -0.008150416));

N1040_5 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), N1040_6, -0.00093312111));

N1040_4 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d < 0.993550121784), N1040_5, 0.0044495736));

N1040_3 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d > NULL), N1040_4, -0.035798404));

N1040_2 :=__common__( if(((real)f_curraddrburglaryindex_i < 197.5), N1040_3, 0.0078121507));

N1040_1 :=__common__( if(((real)f_curraddrburglaryindex_i > NULL), N1040_2, -0.0020933966));

N1041_9 :=__common__( map(((real)f_assocsuspicousidcount_i <= NULL) => 0.01052184,
               ((real)f_assocsuspicousidcount_i < 0.5)   => -0.0017921894,
                                                            0.01052184));

N1041_8 :=__common__( map(((real)f_rel_count_i <= NULL) => -0.0006678257,
               ((real)f_rel_count_i < 8.5)   => N1041_9,
                                                -0.0006678257));

N1041_7 :=__common__( if(((real)c_preschl < 174.5), N1041_8, -0.0074337394));

N1041_6 :=__common__( if(trim(C_PRESCHL) != '', N1041_7, 0.0078469016));

N1041_5 :=__common__( map(((real)f_assoccredbureaucount_i <= NULL) => 0.006974621,
               ((real)f_assoccredbureaucount_i < 2.5)   => N1041_6,
                                                           0.006974621));

N1041_4 :=__common__( if(((real)f_add_input_mobility_index_n < 0.278496176004), N1041_5, -0.0006734066));

N1041_3 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1041_4, 6.3616306e-005));

N1041_2 :=__common__( if(((real)f_srchssnsrchcountmo_i < 1.5), N1041_3, -0.0072858649));

N1041_1 :=__common__( if(((real)f_srchssnsrchcountmo_i > NULL), N1041_2, 0.01213101));

N1042_9 :=__common__( if(((real)f_curraddrburglaryindex_i < 79.5), -0.0023512959, 0.00095397312));

N1042_8 :=__common__( if(((real)f_curraddrburglaryindex_i > NULL), N1042_9, 0.0061404866));

N1042_7 :=__common__( map(trim(C_INC_15K_P) = ''              => 0.0070913837,
               ((real)c_inc_15k_p < 33.4000015259) => -0.0032475178,
                                                      0.0070913837));

N1042_6 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL) => -0.0079768081,
               ((real)f_prevaddrcartheftindex_i < 186.5) => N1042_7,
                                                            -0.0079768081));

N1042_5 :=__common__( map(trim(C_WHITE_COL) = ''      => -0.0086687622,
               ((real)c_white_col < 16.25) => N1042_6,
                                              -0.0086687622));

N1042_4 :=__common__( if(((real)f_prevaddrcartheftindex_i > NULL), N1042_5, -0.0059388158));

N1042_3 :=__common__( map(trim(C_RETIRED) = ''      => 0.0031979605,
               ((real)c_retired < 17.25) => N1042_4,
                                            0.0031979605));

N1042_2 :=__common__( if(((real)c_white_col < 18.4500007629), N1042_3, N1042_8));

N1042_1 :=__common__( if(trim(C_WHITE_COL) != '', N1042_2, -0.0014045399));

N1043_9 :=__common__( map(trim(C_WHITE_COL) = ''      => -0.0022671209,
               ((real)c_white_col < 12.75) => 0.0081901925,
                                              -0.0022671209));

N1043_8 :=__common__( if(((real)c_hh2_p < 30.4500007629), N1043_9, 0.00074722237));

N1043_7 :=__common__( if(trim(C_HH2_P) != '', N1043_8, -0.0010775809));

N1043_6 :=__common__( map(trim(C_RELIG_INDX) = ''      => 0.0091397021,
               ((real)c_relig_indx < 151.5) => -0.0024161696,
                                               0.0091397021));

N1043_5 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => N1043_6,
               ((real)r_c13_avg_lres_d < 56.5)  => 0.0069957965,
                                                   N1043_6));

N1043_4 :=__common__( if(((real)c_med_hval < 163808.5), N1043_5, -0.0042641594));

N1043_3 :=__common__( if(trim(C_MED_HVAL) != '', N1043_4, -0.0018710864));

N1043_2 :=__common__( if(((integer)f_prevaddrmedianvalue_d < 56326), N1043_3, N1043_7));

N1043_1 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N1043_2, -0.0083833858));

N1044_9 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.00073324988,
               ((real)f_corrssnaddrcount_d < 3.5)   => -0.012225458,
                                                       -0.00073324988));

N1044_8 :=__common__( map(((real)r_i60_inq_hiriskcred_recency_d <= NULL)  => -0.0025121179,
               ((integer)r_i60_inq_hiriskcred_recency_d < 549) => 0.0082731646,
                                                                  -0.0025121179));

N1044_7 :=__common__( if(((real)c_work_home < 122.5), -0.0018170644, N1044_8));

N1044_6 :=__common__( if(trim(C_WORK_HOME) != '', N1044_7, 0.0047190388));

N1044_5 :=__common__( if(((real)f_rel_under100miles_cnt_d > NULL), N1044_6, -0.00097261506));

N1044_4 :=__common__( map(((real)f_inq_highriskcredit_count24_i <= NULL) => -0.0055887363,
               ((real)f_inq_highriskcredit_count24_i < 5.5)   => N1044_5,
                                                                 -0.0055887363));

N1044_3 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => N1044_9,
               ((real)f_curraddrburglaryindex_i < 152.5) => N1044_4,
                                                            N1044_9));

N1044_2 :=__common__( if(((integer)f_curraddrcartheftindex_i < 105), N1044_3, 0.00083312933));

N1044_1 :=__common__( if(((real)f_curraddrcartheftindex_i > NULL), N1044_2, -0.0035912953));

N1045_11 :=__common__( map(trim(C_REST_INDX) = ''      => -0.0059279992,
                ((real)c_rest_indx < 147.5) => 0.0032406329,
                                               -0.0059279992));

N1045_10 :=__common__( map(trim(C_INC_75K_P) = ''              => N1045_11,
                ((real)c_inc_75k_p < 13.3500003815) => 0.0069514658,
                                                       N1045_11));

N1045_9 :=__common__( if(((real)c_relig_indx < 168.5), -0.00046690629, N1045_10));

N1045_8 :=__common__( if(trim(C_RELIG_INDX) != '', N1045_9, -0.0051155919));

N1045_7 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0298401452601), 0.013755185, 0.0021451959));

N1045_6 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1045_7, -0.00062847503));

N1045_5 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1045_6, 0.00042700595));

N1045_4 :=__common__( if(((real)c_finance < 3.75), N1045_5, -0.0024356163));

N1045_3 :=__common__( if(trim(C_FINANCE) != '', N1045_4, 0.011418946));

N1045_2 :=__common__( if(((real)f_mos_liens_unrel_lt_fseen_d < 79.5), N1045_3, N1045_8));

N1045_1 :=__common__( if(((real)f_mos_liens_unrel_lt_fseen_d > NULL), N1045_2, -0.0021939587));

N1046_8 :=__common__( map(((real)f_inq_highriskcredit_count24_i <= NULL) => -0.0088673178,
               ((real)f_inq_highriskcredit_count24_i < 1.5)   => -0.00096192994,
                                                                 -0.0088673178));

N1046_7 :=__common__( map(trim(C_RICH_FAM) = ''      => 0.00065961789,
               ((real)c_rich_fam < 113.5) => -0.0094148417,
                                             0.00065961789));

N1046_6 :=__common__( map(trim(C_VERY_RICH) = ''     => N1046_7,
               ((real)c_very_rich < 95.5) => 0.0037595348,
                                             N1046_7));

N1046_5 :=__common__( map(trim(C_VACANT_P) = ''              => N1046_8,
               ((real)c_vacant_p < 14.1499996185) => N1046_6,
                                                     N1046_8));

N1046_4 :=__common__( if(((real)c_hval_400k_p < 7.14999961853), N1046_5, -0.005400154));

N1046_3 :=__common__( if(trim(C_HVAL_400K_P) != '', N1046_4, -0.0016848413));

N1046_2 :=__common__( if(((real)f_rel_bankrupt_count_i < 2.5), 0.0010191492, N1046_3));

N1046_1 :=__common__( if(((real)f_rel_bankrupt_count_i > NULL), N1046_2, 0.0027276737));

N1047_9 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => -0.0047505701,
               ((real)f_curraddrmurderindex_i < 93.5)  => 0.0037104975,
                                                          -0.0047505701));

N1047_8 :=__common__( map(trim(C_FINANCE) = ''              => N1047_9,
               ((real)c_finance < 7.64999961853) => 0.0016358254,
                                                    N1047_9));

N1047_7 :=__common__( if(((real)f_rel_ageover30_count_d < 27.5), N1047_8, -0.0047315866));

N1047_6 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N1047_7, 0.002711091));

N1047_5 :=__common__( if(((real)c_rich_asian < 124.5), N1047_6, -0.0048111785));

N1047_4 :=__common__( if(trim(C_RICH_ASIAN) != '', N1047_5, -0.0015846963));

N1047_3 :=__common__( map(((real)f_liens_rel_cj_total_amt_i <= NULL)  => -0.0050996507,
               ((integer)f_liens_rel_cj_total_amt_i < 232) => N1047_4,
                                                              -0.0050996507));

N1047_2 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.625768303871), N1047_3, -0.0055204333));

N1047_1 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1047_2, -0.0022986101));

N1048_8 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => -0.0032556521,
               ((real)r_a50_pb_average_dollars_d < 125.5) => 0.0024001534,
                                                             -0.0032556521));

N1048_7 :=__common__( map(trim(C_FOOD) = ''              => 0.0093882398,
               ((real)c_food < 3.95000004768) => 0.00093703687,
                                                 0.0093882398));

N1048_6 :=__common__( map(trim(C_FOOD) = ''              => N1048_8,
               ((real)c_food < 10.6499996185) => N1048_7,
                                                 N1048_8));

N1048_5 :=__common__( map(trim(C_FOR_SALE) = ''      => N1048_6,
               ((real)c_for_sale < 138.5) => 0.0089956827,
                                             N1048_6));

N1048_4 :=__common__( map(trim(C_TOTSALES) = ''         => -0.0076691895,
               ((integer)c_totsales < 70453) => -0.00068630112,
                                                -0.0076691895));

N1048_3 :=__common__( if(((real)c_for_sale < 132.5), N1048_4, N1048_5));

N1048_2 :=__common__( if(trim(C_FOR_SALE) != '', N1048_3, 0.00036352611));

N1048_1 :=__common__( if(((real)f_addrchangeecontrajindex_d > NULL), N1048_2, -0.00023039263));

N1049_8 :=__common__( map(trim(C_HVAL_300K_P) = ''               => 0.0082288844,
               ((real)c_hval_300k_p < 0.449999988079) => -0.0016343184,
                                                         0.0082288844));

N1049_7 :=__common__( map(trim(C_HH1_P) = ''              => N1049_8,
               ((real)c_hh1_p < 31.6500015259) => -0.0045999181,
                                                  N1049_8));

N1049_6 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL) => 0.0077306512,
               ((real)f_prevaddrmurderindex_i < 181.5) => 0.00045001898,
                                                          0.0077306512));

N1049_5 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i < 180.5), N1049_6, N1049_7));

N1049_4 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N1049_5, 0.0081322597));

N1049_3 :=__common__( map(trim(C_RNT1000_P) = ''              => -0.0084760796,
               ((real)c_rnt1000_p < 67.8500061035) => N1049_4,
                                                      -0.0084760796));

N1049_2 :=__common__( if(((real)c_rich_fam < 173.5), N1049_3, -0.003911217));

N1049_1 :=__common__( if(trim(C_RICH_FAM) != '', N1049_2, 0.00087574356));

N1050_9 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.0021098311,
               ((real)c_comb_age_d < 31.5)  => 0.0091693908,
                                               -0.0021098311));

N1050_8 :=__common__( if(((real)f_srchfraudsrchcount_i < 12.5), -0.0035415705, N1050_9));

N1050_7 :=__common__( if(((real)f_srchfraudsrchcount_i > NULL), N1050_8, -0.0013507283));

N1050_6 :=__common__( map(trim(C_HH3_P) = ''              => 0.0012578166,
               ((real)c_hh3_p < 9.44999980927) => -0.0030350343,
                                                  0.0012578166));

N1050_5 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1050_6, 0.00023837002));

N1050_4 :=__common__( map(trim(C_BIGAPT_P) = ''     => N1050_7,
               ((real)c_bigapt_p < 5.75) => N1050_5,
                                            N1050_7));

N1050_3 :=__common__( map(trim(C_HOUSINGCPI) = ''       => 0.0070451007,
               ((real)c_housingcpi < 241.75) => N1050_4,
                                                0.0070451007));

N1050_2 :=__common__( if(((real)c_rnt1500_p < 20.4500007629), N1050_3, -0.0057729835));

N1050_1 :=__common__( if(trim(C_RNT1500_P) != '', N1050_2, -0.0046264636));

N1051_9 :=__common__( if(((real)f_inq_count24_i < 5.5), -0.00043154457, -0.0092495992));

N1051_8 :=__common__( if(((real)f_inq_count24_i > NULL), N1051_9, 0.010633161));

N1051_7 :=__common__( map(trim(C_NEWHOUSE) = ''              => 0.0038680986,
               ((real)c_newhouse < 43.1999969482) => -0.0025117216,
                                                     0.0038680986));

N1051_6 :=__common__( map(trim(C_HH5_P) = ''              => N1051_7,
               ((real)c_hh5_p < 0.15000000596) => 0.0056252612,
                                                  N1051_7));

N1051_5 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N1051_6, -0.00025567098));

N1051_4 :=__common__( map(trim(C_SFDU_P) = ''      => 0.0077776775,
               ((real)c_sfdu_p < 96.25) => N1051_5,
                                           0.0077776775));

N1051_3 :=__common__( map(trim(C_SFDU_P) = ''              => N1051_8,
               ((real)c_sfdu_p < 97.8500061035) => N1051_4,
                                                   N1051_8));

N1051_2 :=__common__( if(((real)c_pop_75_84_p < 6.44999980927), N1051_3, 0.0025521708));

N1051_1 :=__common__( if(trim(C_POP_75_84_P) != '', N1051_2, 0.0013880021));

N1052_8 :=__common__( map(trim(C_TOTSALES) = ''        => 0.012726905,
               ((integer)c_totsales < 3913) => -0.0014202883,
                                               0.012726905));

N1052_7 :=__common__( map(trim(C_VERY_RICH) = ''     => N1052_8,
               ((real)c_very_rich < 58.5) => -0.0024567225,
                                             N1052_8));

N1052_6 :=__common__( map(((real)r_i60_inq_hiriskcred_recency_d <= NULL) => N1052_7,
               ((integer)r_i60_inq_hiriskcred_recency_d < 9)  => -0.0070470128,
                                                                 N1052_7));

N1052_5 :=__common__( map(trim(C_BIGAPT_P) = ''              => 0.0099539686,
               ((real)c_bigapt_p < 14.0500001907) => N1052_6,
                                                     0.0099539686));

N1052_4 :=__common__( map(trim(C_HVAL_175K_P) = ''                => -0.0010143517,
               ((real)c_hval_175k_p < 0.0500000007451) => 0.0016449341,
                                                          -0.0010143517));

N1052_3 :=__common__( map(trim(C_PROFESSIONAL) = ''              => N1052_5,
               ((real)c_professional < 9.64999961853) => N1052_4,
                                                         N1052_5));

N1052_2 :=__common__( if(((real)f_curraddrmedianincome_d > NULL), N1052_3, 0.00394248));

N1052_1 :=__common__( if(trim(C_PROFESSIONAL) != '', N1052_2, -0.00012323216));

N1053_8 :=__common__( map(trim(C_MED_HVAL) = ''        => -0.0050467808,
               ((real)c_med_hval < 87607.5) => 0.0034555276,
                                               -0.0050467808));

N1053_7 :=__common__( map(trim(C_POP_65_74_P) = ''              => N1053_8,
               ((real)c_pop_65_74_p < 4.35000038147) => -0.008581857,
                                                        N1053_8));

N1053_6 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)    => 0.0037388963,
               ((real)f_prevaddrmedianvalue_d < 152263.5) => N1053_7,
                                                             0.0037388963));

N1053_5 :=__common__( map(trim(C_HH1_P) = ''              => -0.010050941,
               ((real)c_hh1_p < 45.3499984741) => N1053_6,
                                                  -0.010050941));

N1053_4 :=__common__( map(trim(C_POP_35_44_P) = ''              => 0.0013003413,
               ((real)c_pop_35_44_p < 12.3500003815) => N1053_5,
                                                        0.0013003413));

N1053_3 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N1053_4, -0.00038824654));

N1053_2 :=__common__( if(((real)c_inc_200k_p < 12.0500001907), N1053_3, 0.0083607856));

N1053_1 :=__common__( if(trim(C_INC_200K_P) != '', N1053_2, 9.0785298e-005));

N1054_8 :=__common__( map(trim(C_LUX_PROD) = ''     => 0.0082827517,
               ((real)c_lux_prod < 48.5) => -0.0014860446,
                                            0.0082827517));

N1054_7 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => -0.0030505452,
               ((real)r_c21_m_bureau_adl_fs_d < 113.5) => 0.0026878837,
                                                          -0.0030505452));

N1054_6 :=__common__( map(trim(C_POP_75_84_P) = ''              => N1054_8,
               ((real)c_pop_75_84_p < 6.14999961853) => N1054_7,
                                                        N1054_8));

N1054_5 :=__common__( map(((real)c_inf_nothing_found_i <= NULL) => -0.011885053,
               ((real)c_inf_nothing_found_i < 0.5)   => -0.0016495106,
                                                        -0.011885053));

N1054_4 :=__common__( if(((real)c_unemp < 3.34999990463), N1054_5, N1054_6));

N1054_3 :=__common__( if(trim(C_UNEMP) != '', N1054_4, -0.00018884393));

N1054_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 84.5), N1054_3, 0.00068636508));

N1054_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N1054_2, -0.0027285773));

N1055_11 :=__common__( if(((real)c_hval_20k_p < 9.55000019073), 0.0016179766, -0.0024751991));

N1055_10 :=__common__( if(trim(C_HVAL_20K_P) != '', N1055_11, -0.0086176084));

N1055_9 :=__common__( map(trim(C_FAMILIES) = ''      => 0.00025402475,
               ((real)c_families < 331.5) => -0.0050861712,
                                             0.00025402475));

N1055_8 :=__common__( if(((real)c_pop_35_44_p < 6.75), 0.0064935293, N1055_9));

N1055_7 :=__common__( if(trim(C_POP_35_44_P) != '', N1055_8, -0.010873488));

N1055_6 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i < -3148.5), -0.0068526454, 0.0022044496));

N1055_5 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N1055_6, N1055_7));

N1055_4 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 56.5), N1055_5, N1055_10));

N1055_3 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N1055_4, -0.0055184758));

N1055_2 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0044817943126), -0.0052887415, N1055_3));

N1055_1 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1055_2, -0.00069919015));

N1056_9 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => -0.00014387748,
               ((real)r_c14_addrs_10yr_i < 8.5)   => -0.0065389706,
                                                     -0.00014387748));

N1056_8 :=__common__( map(((real)f_inq_count24_i <= NULL) => N1056_9,
               ((real)f_inq_count24_i < 0.5)   => 0.0049633064,
                                                  N1056_9));

N1056_7 :=__common__( if(((real)c_relig_indx < 132.5), N1056_8, 0.0016185919));

N1056_6 :=__common__( if(trim(C_RELIG_INDX) != '', N1056_7, 0.0006744612));

N1056_5 :=__common__( map(trim(C_POP_65_74_P) = ''              => -0.0071834264,
               ((real)c_pop_65_74_p < 13.0500001907) => 0.00066373991,
                                                        -0.0071834264));

N1056_4 :=__common__( if(((real)c_health < 23.8499984741), N1056_5, 0.0045173279));

N1056_3 :=__common__( if(trim(C_HEALTH) != '', N1056_4, 0.0025396273));

N1056_2 :=__common__( if(((real)f_current_count_d < 1.5), N1056_3, N1056_6));

N1056_1 :=__common__( if(((real)f_current_count_d > NULL), N1056_2, 0.0064992672));

N1057_9 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL)  => -0.0095466575,
               ((integer)f_fp_prevaddrburglaryindex_i < 129) => 0.00069596021,
                                                                -0.0095466575));

N1057_8 :=__common__( map(trim(C_RNT500_P) = ''              => 0.0035850652,
               ((real)c_rnt500_p < 14.3500003815) => N1057_9,
                                                     0.0035850652));

N1057_7 :=__common__( if(((real)c_lowrent < 51.3499984741), N1057_8, -0.008111028));

N1057_6 :=__common__( if(trim(C_LOWRENT) != '', N1057_7, -0.0010238093));

N1057_5 :=__common__( if(((real)c_families < 385.5), -0.0064431033, 0.0033662408));

N1057_4 :=__common__( if(trim(C_FAMILIES) != '', N1057_5, 0.010327664));

N1057_3 :=__common__( map(((real)r_d32_mos_since_fel_ls_d <= NULL) => 0.0011990572,
               ((real)r_d32_mos_since_fel_ls_d < 240.5) => N1057_4,
                                                           0.0011990572));

N1057_2 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.473401278257), N1057_3, N1057_6));

N1057_1 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1057_2, -0.00284395));

N1058_9 :=__common__( if(((real)f_rel_bankrupt_count_i < 1.5), 0.014639975, 0.0031008657));

N1058_8 :=__common__( if(((real)f_rel_bankrupt_count_i > NULL), N1058_9, -0.03392176));

N1058_7 :=__common__( if(((real)c_hval_175k_p < 8.25), N1058_8, -0.0017153674));

N1058_6 :=__common__( if(trim(C_HVAL_175K_P) != '', N1058_7, -0.0013660333));

N1058_5 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL)  => -0.000879124,
               ((integer)f_curraddrmurderindex_i < 141) => 0.003031489,
                                                           -0.000879124));

N1058_4 :=__common__( if(((real)f_rel_homeover300_count_d > NULL), N1058_5, 0.0031662436));

N1058_3 :=__common__( if(((real)c_pop_55_64_p < 8.55000019073), N1058_4, -0.0010879001));

N1058_2 :=__common__( if(trim(C_POP_55_64_P) != '', N1058_3, -0.00041318876));

N1058_1 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => N1058_6,
               ((real)f_inq_adls_per_phone_i < 1.5)   => N1058_2,
                                                         N1058_6));

N1059_9 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)         => 0.0024227427,
               ((real)f_add_curr_nhood_vac_pct_i < 0.11186721921) => -0.0046698557,
                                                                     0.0024227427));

N1059_8 :=__common__( map(trim(C_VACANT_P) = ''              => N1059_9,
               ((real)c_vacant_p < 13.9499998093) => -0.0064421089,
                                                     N1059_9));

N1059_7 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.107900209725), -0.004008809, 0.0056869607));

N1059_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1059_7, 0.0012042264));

N1059_5 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => N1059_8,
               ((real)r_a50_pb_average_dollars_d < 85.5)  => N1059_6,
                                                             N1059_8));

N1059_4 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => 0.0019895735,
               ((real)f_srchaddrsrchcount_i < 2.5)   => -0.0011125049,
                                                        0.0019895735));

N1059_3 :=__common__( map(trim(C_LOWINC) = ''      => N1059_5,
               ((real)c_lowinc < 56.25) => N1059_4,
                                           N1059_5));

N1059_2 :=__common__( if(((real)f_curraddrmurderindex_i > NULL), N1059_3, -0.007503432));

N1059_1 :=__common__( if(trim(C_LOWINC) != '', N1059_2, 6.8634679e-005));

N1060_9 :=__common__( map(trim(C_MED_RENT) = ''       => 0.0040295713,
               ((integer)c_med_rent < 871) => -0.0080353912,
                                              0.0040295713));

N1060_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0583113655448), 0.0065029039, 0.017185164));

N1060_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1060_8, 0.011768746));

N1060_6 :=__common__( map(trim(C_ASSAULT) = ''      => -0.0014171526,
               ((real)c_assault < 139.5) => N1060_7,
                                            -0.0014171526));

N1060_5 :=__common__( map(trim(C_RNT1000_P) = ''              => -0.0012004152,
               ((real)c_rnt1000_p < 28.5499992371) => N1060_6,
                                                      -0.0012004152));

N1060_4 :=__common__( if(((real)c_occunit_p < 94.75), N1060_5, N1060_9));

N1060_3 :=__common__( if(trim(C_OCCUNIT_P) != '', N1060_4, 0.0063922434));

N1060_2 :=__common__( if(((real)f_curraddrmedianincome_d < 60528.5), -0.00056526529, N1060_3));

N1060_1 :=__common__( if(((real)f_curraddrmedianincome_d > NULL), N1060_2, -0.0074994649));

N1061_8 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => 0.0054263412,
               ((real)r_c13_max_lres_d < 153.5) => -0.0043296331,
                                                   0.0054263412));

N1061_7 :=__common__( map((fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '4 Bureau Only', '5 Derog']) => N1061_8,
               (fp_segment in ['6 Recent Activity', '7 Other'])                                     => 0.00493801,
                                                                                                       N1061_8));

N1061_6 :=__common__( map(((real)r_phn_cell_n <= NULL) => N1061_7,
               ((real)r_phn_cell_n < 0.5)   => 0.0042682061,
                                               N1061_7));

N1061_5 :=__common__( map(((real)c_dist_input_to_prev_addr_i <= NULL) => 0.008488886,
               ((real)c_dist_input_to_prev_addr_i < 126.5) => N1061_6,
                                                              0.008488886));

N1061_4 :=__common__( map(trim(C_INC_100K_P) = ''              => -0.0066557977,
               ((real)c_inc_100k_p < 16.4500007629) => N1061_5,
                                                       -0.0066557977));

N1061_3 :=__common__( if(((real)c_dist_input_to_prev_addr_i > NULL), N1061_4, -0.0056788781));

N1061_2 :=__common__( if(((real)c_fammar18_p < 19.6500015259), N1061_3, -0.00028915153));

N1061_1 :=__common__( if(trim(C_FAMMAR18_P) != '', N1061_2, -1.7635785e-005));

N1062_9 :=__common__( if(((real)c_unattach < 105.5), 0.0017912666, 0.0098806005));

N1062_8 :=__common__( if(trim(C_UNATTACH) != '', N1062_9, 0.04087473));

N1062_7 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL) => -0.0011354436,
               ((real)f_prevaddrmurderindex_i < 171.5) => N1062_8,
                                                          -0.0011354436));

N1062_6 :=__common__( map(((real)f_wealth_index_d <= NULL) => N1062_7,
               ((real)f_wealth_index_d < 1.5)   => -0.0040693926,
                                                   N1062_7));

N1062_5 :=__common__( if(((real)c_rape < 185.5), -0.00028406671, 0.0036058367));

N1062_4 :=__common__( if(trim(C_RAPE) != '', N1062_5, -0.00029568965));

N1062_3 :=__common__( if(((real)r_l70_inp_addr_dnd_i > NULL), N1062_4, N1062_6));

N1062_2 :=__common__( if(((real)f_rel_homeover50_count_d < 40.5), N1062_3, -0.0071924974));

N1062_1 :=__common__( if(((real)f_rel_homeover50_count_d > NULL), N1062_2, -0.0024884241));

N1063_10 :=__common__( if(((integer)c_edu_indx < 132), 0.00078616519, 0.0077664861));

N1063_9 :=__common__( if(trim(C_EDU_INDX) != '', N1063_10, -0.0033938651));

N1063_8 :=__common__( map(trim(C_INC_125K_P) = ''              => 0.0012883642,
               ((real)c_inc_125k_p < 3.34999990463) => 0.011451491,
                                                       0.0012883642));

N1063_7 :=__common__( map(trim(C_AB_AV_EDU) = ''     => N1063_8,
               ((real)c_ab_av_edu < 41.5) => -0.0047357417,
                                             N1063_8));

N1063_6 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1063_7, 0.0025795236));

N1063_5 :=__common__( map(trim(C_HH1_P) = ''              => -0.0045069635,
               ((real)c_hh1_p < 41.6500015259) => N1063_6,
                                                  -0.0045069635));

N1063_4 :=__common__( if(((real)c_easiqlife < 120.5), N1063_5, -0.0036114151));

N1063_3 :=__common__( if(trim(C_EASIQLIFE) != '', N1063_4, -0.0038937862));

N1063_2 :=__common__( if(((real)f_srchaddrsrchcount_i < 2.5), N1063_3, N1063_9));

N1063_1 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N1063_2, 0.0011974344));

N1064_8 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.006279684,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0621776431799) => -0.007010126,
                                                                       0.006279684));

N1064_7 :=__common__( map(trim(C_OLD_HOMES) = ''     => N1064_8,
               ((real)c_old_homes < 51.5) => 0.0094309029,
                                             N1064_8));

N1064_6 :=__common__( if(((real)r_f03_input_add_not_most_rec_i < 0.5), -0.0033083971, N1064_7));

N1064_5 :=__common__( if(((real)r_f03_input_add_not_most_rec_i > NULL), N1064_6, -0.018264289));

N1064_4 :=__common__( map(trim(C_HVAL_150K_P) = ''              => -0.0087328811,
               ((real)c_hval_150k_p < 19.5499992371) => N1064_5,
                                                        -0.0087328811));

N1064_3 :=__common__( map(trim(C_VERY_RICH) = ''       => N1064_4,
               ((integer)c_very_rich < 135) => 0.00055461618,
                                               N1064_4));

N1064_2 :=__common__( if(((real)c_inc_75k_p < 31.6500015259), N1064_3, 0.0075068899));

N1064_1 :=__common__( if(trim(C_INC_75K_P) != '', N1064_2, -0.00094124239));

N1065_8 :=__common__( map(trim(C_POP_6_11_P) = ''              => -0.0062389072,
               ((real)c_pop_6_11_p < 9.35000038147) => 0.0017739522,
                                                       -0.0062389072));

N1065_7 :=__common__( map((fp_segment in ['3 New DID', '5 Derog', '6 Recent Activity', '7 Other']) => N1065_8,
               (fp_segment in ['1 SSN Prob', '2 NAS 479', '4 Bureau Only'])             => 0.0090388194,
                                                                                           N1065_8));

N1065_6 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.035961471498), 0.0078326241, N1065_7));

N1065_5 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1065_6, -0.01996266));

N1065_4 :=__common__( map(trim(C_BUSINESS) = ''     => -0.011810896,
               ((real)c_business < 53.5) => -0.0016257897,
                                            -0.011810896));

N1065_3 :=__common__( map(((real)f_adl_util_inf_n <= NULL) => N1065_4,
               ((real)f_adl_util_inf_n < 0.5)   => -0.00032129241,
                                                   N1065_4));

N1065_2 :=__common__( if(((real)c_rape < 185.5), N1065_3, N1065_5));

N1065_1 :=__common__( if(trim(C_RAPE) != '', N1065_2, -0.0029277843));

N1066_7 :=__common__( map(trim(C_HVAL_175K_P) = ''              => -0.0027712424,
               ((real)c_hval_175k_p < 6.85000038147) => 0.0083921674,
                                                        -0.0027712424));

N1066_6 :=__common__( map(trim(C_HH4_P) = ''              => N1066_7,
               ((real)c_hh4_p < 6.85000038147) => 0.012255551,
                                                  N1066_7));

N1066_5 :=__common__( map(trim(C_RNT500_P) = ''              => 0.00098107315,
               ((real)c_rnt500_p < 9.14999961853) => -0.0093172057,
                                                     0.00098107315));

N1066_4 :=__common__( map(trim(C_POPOVER18) = ''        => 0.0067512305,
               ((integer)c_popover18 < 1607) => N1066_5,
                                                0.0067512305));

N1066_3 :=__common__( map(trim(C_POP_55_64_P) = ''      => N1066_6,
               ((real)c_pop_55_64_p < 10.25) => N1066_4,
                                                N1066_6));

N1066_2 :=__common__( if(((real)c_serv_empl < 55.5), N1066_3, -0.00077268671));

N1066_1 :=__common__( if(trim(C_SERV_EMPL) != '', N1066_2, 0.00037489564));

N1067_8 :=__common__( map(trim(C_INC_125K_P) = ''      => 0.0078982393,
               ((real)c_inc_125k_p < 11.75) => -0.00062122625,
                                               0.0078982393));

N1067_7 :=__common__( map(trim(C_MED_HHINC) = ''        => -0.0049088234,
               ((real)c_med_hhinc < 67601.5) => N1067_8,
                                                -0.0049088234));

N1067_6 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => 0.010882741,
               ((integer)f_curraddrcartheftindex_i < 55) => 0.0016373577,
                                                            0.010882741));

N1067_5 :=__common__( if(((real)f_assocrisktype_i < 3.5), -0.0033926482, N1067_6));

N1067_4 :=__common__( if(((real)f_assocrisktype_i > NULL), N1067_5, 0.058070391));

N1067_3 :=__common__( map(trim(C_BURGLARY) = ''      => N1067_7,
               ((integer)c_burglary < 49) => N1067_4,
                                             N1067_7));

N1067_2 :=__common__( if(((real)c_hval_400k_p < 33.4500007629), N1067_3, -0.0067408241));

N1067_1 :=__common__( if(trim(C_HVAL_400K_P) != '', N1067_2, -0.00036879371));

N1068_10 :=__common__( if(((real)f_addrchangeincomediff_d < 28172.5), -0.0025525573, 0.0069437569));

N1068_9 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1068_10, -0.0011001505));

N1068_8 :=__common__( if(((real)r_l70_inp_addr_dnd_i > NULL), 0.0036872569, 0.024107931));

N1068_7 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL) => N1068_9,
               ((real)r_i60_inq_auto_recency_d < 61.5)  => N1068_8,
                                                           N1068_9));

N1068_6 :=__common__( if(((real)f_inq_auto_count24_i > NULL), N1068_7, 0.0025439547));

N1068_5 :=__common__( map(trim(C_HVAL_150K_P) = ''      => N1068_6,
               ((real)c_hval_150k_p < 13.25) => 0.0064422728,
                                                N1068_6));

N1068_4 :=__common__( if(((real)f_srchfraudsrchcount_i < 37.5), -0.0004056499, -0.0073985265));

N1068_3 :=__common__( if(((real)f_srchfraudsrchcount_i > NULL), N1068_4, -0.00518832));

N1068_2 :=__common__( if(((real)c_hval_150k_p < 10.25), N1068_3, N1068_5));

N1068_1 :=__common__( if(trim(C_HVAL_150K_P) != '', N1068_2, -0.0026032552));

N1069_8 :=__common__( map(trim(C_FINANCE) = ''               => 0.0082027987,
               ((real)c_finance < 0.949999988079) => -0.00083183958,
                                                     0.0082027987));

N1069_7 :=__common__( if(((real)f_rel_incomeover50_count_d < 8.5), 0.010475402, -0.0026301923));

N1069_6 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N1069_7, 0.016829574));

N1069_5 :=__common__( map(trim(C_HHSIZE) = ''              => -0.0027247457,
               ((real)c_hhsize < 2.82499980927) => -0.00022846582,
                                                   -0.0027247457));

N1069_4 :=__common__( map(trim(C_HIGHRENT) = ''              => N1069_6,
               ((real)c_highrent < 27.1500015259) => N1069_5,
                                                     N1069_6));

N1069_3 :=__common__( map(trim(C_HIGH_HVAL) = ''              => -0.0079719615,
               ((real)c_high_hval < 41.8499984741) => N1069_4,
                                                      -0.0079719615));

N1069_2 :=__common__( if(((real)c_rnt1000_p < 49.8499984741), N1069_3, N1069_8));

N1069_1 :=__common__( if(trim(C_RNT1000_P) != '', N1069_2, 0.0010002434));

N1070_9 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => -0.011693242,
               ((real)f_curraddrmurderindex_i < 163.5) => -0.0027978656,
                                                          -0.011693242));

N1070_8 :=__common__( if(((real)c_retail < 13.5500001907), N1070_9, 0.0035453627));

N1070_7 :=__common__( if(trim(C_RETAIL) != '', N1070_8, -0.0038941329));

N1070_6 :=__common__( map(((real)r_d32_mos_since_fel_ls_d <= NULL) => 0.0006914162,
               ((real)r_d32_mos_since_fel_ls_d < 240.5) => N1070_7,
                                                           0.0006914162));

N1070_5 :=__common__( map(trim(C_HVAL_150K_P) = ''              => -0.0057241722,
               ((real)c_hval_150k_p < 4.05000019073) => 0.0064186833,
                                                        -0.0057241722));

N1070_4 :=__common__( if(((real)c_mort_indx < 67.5), -0.012270549, N1070_5));

N1070_3 :=__common__( if(trim(C_MORT_INDX) != '', N1070_4, -0.0099153976));

N1070_2 :=__common__( if(((integer)r_i60_inq_banking_recency_d < 9), N1070_3, N1070_6));

N1070_1 :=__common__( if(((real)r_i60_inq_banking_recency_d > NULL), N1070_2, 0.00031355436));

N1071_8 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => 0.0048658034,
               ((real)r_c13_max_lres_d < 82.5)  => 0.015869957,
                                                   0.0048658034));

N1071_7 :=__common__( map(trim(C_POP_12_17_P) = ''              => 0.0001800826,
               ((real)c_pop_12_17_p < 10.8500003815) => N1071_8,
                                                        0.0001800826));

N1071_6 :=__common__( map(trim(C_PROFESSIONAL) = ''              => -0.0024955434,
               ((real)c_professional < 6.35000038147) => N1071_7,
                                                         -0.0024955434));

N1071_5 :=__common__( if(((real)f_inq_count24_i < 22.5), N1071_6, -0.0036925908));

N1071_4 :=__common__( if(((real)f_inq_count24_i > NULL), N1071_5, -0.0068094954));

N1071_3 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => N1071_4,
               ((real)f_inq_per_ssn_i < 6.5)   => -0.00017968751,
                                                  N1071_4));

N1071_2 :=__common__( if(((real)c_mort_indx < 170.5), N1071_3, -0.0082268138));

N1071_1 :=__common__( if(trim(C_MORT_INDX) != '', N1071_2, -0.00084545148));

N1072_8 :=__common__( map(trim(C_EXP_PROD) = ''     => 0.00027327693,
               ((real)c_exp_prod < 99.5) => 0.011653515,
                                            0.00027327693));

N1072_7 :=__common__( map(trim(C_EMPLOYEES) = ''     => -0.0034477932,
               ((real)c_employees < 70.5) => -0.011902582,
                                             -0.0034477932));

N1072_6 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => N1072_7,
               ((real)f_add_curr_nhood_vac_pct_i < 0.027066597715) => -0.00040362053,
                                                                      N1072_7));

N1072_5 :=__common__( map(((real)f_rel_count_i <= NULL) => N1072_6,
               ((real)f_rel_count_i < 3.5)   => 0.0036689037,
                                                N1072_6));

N1072_4 :=__common__( if(((real)f_historical_count_d < 0.5), N1072_5, 0.00026719598));

N1072_3 :=__common__( if(((real)f_historical_count_d > NULL), N1072_4, -0.0034202472));

N1072_2 :=__common__( if(((real)c_mil_emp < 3.15000009537), N1072_3, N1072_8));

N1072_1 :=__common__( if(trim(C_MIL_EMP) != '', N1072_2, -0.0019268847));

N1073_9 :=__common__( map(((real)r_l79_adls_per_addr_c6_i <= NULL) => -0.0091398561,
               ((real)r_l79_adls_per_addr_c6_i < 0.5)   => 0.001425537,
                                                           -0.0091398561));

N1073_8 :=__common__( map(((real)f_add_input_nhood_bus_pct_i <= NULL)          => 0.0012123435,
               ((real)f_add_input_nhood_bus_pct_i < 0.012264566496) => -0.0019685824,
                                                                       0.0012123435));

N1073_7 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d < 168.5), -0.0081676881, 2.7523755e-005));

N1073_6 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d > NULL), N1073_7, 0.031406784));

N1073_5 :=__common__( map(trim(C_INC_125K_P) = ''               => N1073_8,
               ((real)c_inc_125k_p < 0.449999988079) => N1073_6,
                                                        N1073_8));

N1073_4 :=__common__( map(trim(C_INC_150K_P) = ''              => N1073_9,
               ((real)c_inc_150k_p < 9.05000019073) => N1073_5,
                                                       N1073_9));

N1073_3 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1073_4, 0.0004577681));

N1073_2 :=__common__( if(((real)c_fammar18_p < 57.1500015259), N1073_3, 0.0088370942));

N1073_1 :=__common__( if(trim(C_FAMMAR18_P) != '', N1073_2, -0.00010491295));

N1074_12 :=__common__( if(((real)c_newhouse < 14.25), 0.008064912, -0.0025418107));

N1074_11 :=__common__( if(trim(C_NEWHOUSE) != '', N1074_12, 0.0033047814));

N1074_10 :=__common__( if(((real)c_many_cars < 124.5), 0.0070154058, -0.002762548));

N1074_9 :=__common__( if(trim(C_MANY_CARS) != '', N1074_10, -0.029295299));

N1074_8 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N1074_9, N1074_11));

N1074_7 :=__common__( map(trim(C_NO_LABFOR) = ''      => 0.0068395,
               ((real)c_no_labfor < 175.5) => -0.0062378693,
                                              0.0068395));

N1074_6 :=__common__( if(((real)f_add_input_mobility_index_n < 0.286508560181), N1074_7, -0.0066554567));

N1074_5 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1074_6, -0.038444869));

N1074_4 :=__common__( if(((real)c_no_labfor < 164.5), 0.00015028548, N1074_5));

N1074_3 :=__common__( if(trim(C_NO_LABFOR) != '', N1074_4, 0.00096478716));

N1074_2 :=__common__( if(((real)f_curraddrmedianincome_d < 62388.5), N1074_3, N1074_8));

N1074_1 :=__common__( if(((real)f_curraddrmedianincome_d > NULL), N1074_2, -0.000756782));

N1075_9 :=__common__( map(trim(C_OWNOCC_P) = ''              => -0.0014363479,
               ((real)c_ownocc_p < 61.1500015259) => 0.0080732353,
                                                     -0.0014363479));

N1075_8 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => N1075_9,
               ((real)r_c14_addrs_15yr_i < 13.5)  => 6.8068902e-005,
                                                     N1075_9));

N1075_7 :=__common__( map(trim(C_RELIG_INDX) = ''      => 0.0098212384,
               ((real)c_relig_indx < 188.5) => N1075_8,
                                               0.0098212384));

N1075_6 :=__common__( if(((real)c_span_lang < 88.5), N1075_7, -0.00076642331));

N1075_5 :=__common__( if(trim(C_SPAN_LANG) != '', N1075_6, 0.0023282331));

N1075_4 :=__common__( if(((real)c_unattach < 103.5), -0.011753829, -0.0006828857));

N1075_3 :=__common__( if(trim(C_UNATTACH) != '', N1075_4, -0.014589606));

N1075_2 :=__common__( if(((real)f_mos_liens_unrel_ot_fseen_d < 106.5), N1075_3, N1075_5));

N1075_1 :=__common__( if(((real)f_mos_liens_unrel_ot_fseen_d > NULL), N1075_2, -0.0044631506));

N1076_8 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => 0.0035979065,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.985122084618) => -0.0041862837,
                                                                      0.0035979065));

N1076_7 :=__common__( map(trim(C_LOWRENT) = ''     => -0.00025768783,
               ((real)c_lowrent < 5.75) => N1076_8,
                                           -0.00025768783));

N1076_6 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)          => 0.011967949,
               ((real)f_add_input_nhood_sfd_pct_d < 0.146146774292) => 0.00028130898,
                                                                       0.011967949));

N1076_5 :=__common__( map(trim(C_OLD_HOMES) = ''      => -0.0025069179,
               ((real)c_old_homes < 125.5) => N1076_6,
                                              -0.0025069179));

N1076_4 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => N1076_7,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.163035780191) => N1076_5,
                                                                      N1076_7));

N1076_3 :=__common__( if(((real)f_mos_liens_rel_cj_fseen_d > NULL), N1076_4, -0.0020533409));

N1076_2 :=__common__( if(((real)c_armforce < 195.5), N1076_3, 0.0059407831));

N1076_1 :=__common__( if(trim(C_ARMFORCE) != '', N1076_2, 0.0033356669));

N1077_8 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => -0.00045356163,
               ((real)r_d32_mos_since_crim_ls_d < 109.5) => -0.010066371,
                                                            -0.00045356163));

N1077_7 :=__common__( map(((real)f_corrrisktype_i <= NULL) => -0.0055942547,
               ((real)f_corrrisktype_i < 7.5)   => 0.0036779664,
                                                   -0.0055942547));

N1077_6 :=__common__( map(trim(C_HVAL_200K_P) = ''              => 0.007911438,
               ((real)c_hval_200k_p < 3.84999990463) => N1077_7,
                                                        0.007911438));

N1077_5 :=__common__( map(trim(C_RETIRED2) = ''     => -0.00010371496,
               ((real)c_retired2 < 39.5) => N1077_6,
                                            -0.00010371496));

N1077_4 :=__common__( if(((real)f_rel_under500miles_cnt_d < 30.5), N1077_5, N1077_8));

N1077_3 :=__common__( if(((real)f_rel_under500miles_cnt_d > NULL), N1077_4, -0.0021786732));

N1077_2 :=__common__( if(((real)c_popover18 < 417.5), 0.0078816872, N1077_3));

N1077_1 :=__common__( if(trim(C_POPOVER18) != '', N1077_2, 0.0019484101));

N1078_9 :=__common__( map(trim(C_RICH_FAM) = ''     => -0.005042355,
               ((real)c_rich_fam < 86.5) => 0.0056519072,
                                            -0.005042355));

N1078_8 :=__common__( if(((real)c_hh1_p < 34.75), N1078_9, 0.011109476));

N1078_7 :=__common__( if(trim(C_HH1_P) != '', N1078_8, 0.014210527));

N1078_6 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)         => -0.011465372,
               ((real)f_add_input_nhood_sfd_pct_d < 0.60389983654) => 0.00029743588,
                                                                      -0.011465372));

N1078_5 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL) => N1078_6,
               ((real)f_curraddrcrimeindex_i < 196.5) => -7.3937829e-005,
                                                         N1078_6));

N1078_4 :=__common__( if(((real)c_inc_35k_p < 23.8499984741), N1078_5, 0.0055487929));

N1078_3 :=__common__( if(trim(C_INC_35K_P) != '', N1078_4, -0.00017523492));

N1078_2 :=__common__( if(((real)f_historical_count_d < 9.5), N1078_3, N1078_7));

N1078_1 :=__common__( if(((real)f_historical_count_d > NULL), N1078_2, -0.0018831183));

N1079_8 :=__common__( map(trim(C_HH4_P) = ''              => -0.00042374603,
               ((real)c_hh4_p < 12.6499996185) => -0.0081765091,
                                                  -0.00042374603));

N1079_7 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => N1079_8,
               ((integer)r_i60_inq_auto_recency_d < 549) => 0.00089570636,
                                                            N1079_8));

N1079_6 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => 0.0095108898,
               ((real)f_prevaddrmedianincome_d < 78094.5) => 0.0009828539,
                                                             0.0095108898));

N1079_5 :=__common__( map(trim(C_HH2_P) = ''              => N1079_6,
               ((real)c_hh2_p < 24.6500015259) => -0.0015113958,
                                                  N1079_6));

N1079_4 :=__common__( map(trim(C_MEDI_INDX) = ''      => -0.0039617932,
               ((real)c_medi_indx < 115.5) => N1079_5,
                                              -0.0039617932));

N1079_3 :=__common__( if(((real)f_varrisktype_i < 4.5), N1079_4, N1079_7));

N1079_2 :=__common__( if(((real)f_varrisktype_i > NULL), N1079_3, 0.0019024569));

N1079_1 :=__common__( if(trim(C_MEDI_INDX) != '', N1079_2, -0.0023474081));

N1080_8 :=__common__( map(((real)f_rel_bankrupt_count_i <= NULL) => 0.014661846,
               ((real)f_rel_bankrupt_count_i < 2.5)   => 0.0028596738,
                                                         0.014661846));

N1080_7 :=__common__( if(((real)f_college_income_d > NULL), N1080_8, 0.00019583819));

N1080_6 :=__common__( map(trim(C_MED_RENT) = ''      => 0.00023914136,
               ((real)c_med_rent < 352.5) => -0.0074548658,
                                             0.00023914136));

N1080_5 :=__common__( if(((real)c_inc_201k_p < 0.0500000007451), N1080_6, 0.0025073329));

N1080_4 :=__common__( if(trim(C_INC_201K_P) != '', N1080_5, 0.0027602257));

N1080_3 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)    => -0.0020786855,
               ((integer)f_prevaddrmedianincome_d < 34396) => N1080_4,
                                                              -0.0020786855));

N1080_2 :=__common__( if(((real)f_corraddrnamecount_d < 6.5), N1080_3, N1080_7));

N1080_1 :=__common__( if(((real)f_corraddrnamecount_d > NULL), N1080_2, 0.0028717076));

N1081_9 :=__common__( map(trim(C_LARCENY) = ''       => -0.010343159,
               ((integer)c_larceny < 152) => 0.0003710183,
                                             -0.010343159));

N1081_8 :=__common__( map(trim(C_HH6_P) = ''     => 0.010595076,
               ((real)c_hh6_p < 1.25) => 0.0012082517,
                                         0.010595076));

N1081_7 :=__common__( if(((real)f_add_input_mobility_index_n < 0.708310782909), 0.0003092542, -0.0066820222));

N1081_6 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1081_7, -0.032187715));

N1081_5 :=__common__( map(trim(C_CHILD) = ''              => N1081_6,
               ((real)c_child < 15.5500001907) => 0.0076153368,
                                                  N1081_6));

N1081_4 :=__common__( if(((real)f_rel_felony_count_i < 6.5), N1081_5, N1081_8));

N1081_3 :=__common__( if(((real)f_rel_felony_count_i > NULL), N1081_4, -0.004842026));

N1081_2 :=__common__( if(((real)c_pop_85p_p < 5.55000019073), N1081_3, N1081_9));

N1081_1 :=__common__( if(trim(C_POP_85P_P) != '', N1081_2, 0.0047374699));

N1082_8 :=__common__( map(trim(C_RNT750_P) = ''              => -0.01487356,
               ((real)c_rnt750_p < 29.8499984741) => -0.0030485688,
                                                     -0.01487356));

N1082_7 :=__common__( map(trim(C_MANY_CARS) = ''     => -0.0015116034,
               ((real)c_many_cars < 28.5) => N1082_8,
                                             -0.0015116034));

N1082_6 :=__common__( if(((real)c_no_labfor < 117.5), 0.00042610664, N1082_7));

N1082_5 :=__common__( if(trim(C_NO_LABFOR) != '', N1082_6, 0.00038649753));

N1082_4 :=__common__( map(((real)f_rel_under500miles_cnt_d <= NULL) => 0.0015766387,
               ((real)f_rel_under500miles_cnt_d < 14.5)  => N1082_5,
                                                            0.0015766387));

N1082_3 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => 0.013120038,
               ((real)f_srchfraudsrchcount_i < 7.5)   => 0.0010551739,
                                                         0.013120038));

N1082_2 :=__common__( if(((real)f_rel_homeover50_count_d < 3.5), N1082_3, N1082_4));

N1082_1 :=__common__( if(((real)f_rel_homeover50_count_d > NULL), N1082_2, -0.0011732759));

N1083_9 :=__common__( map(trim(C_RICH_FAM) = ''     => -0.0055444945,
               ((real)c_rich_fam < 83.5) => 0.0065370804,
                                            -0.0055444945));

N1083_8 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL) => -0.0066065197,
               ((real)r_a50_pb_total_dollars_d < 97.5)  => N1083_9,
                                                           -0.0066065197));

N1083_7 :=__common__( map(trim(C_HH2_P) = ''      => N1083_8,
               ((real)c_hh2_p < 24.25) => 0.0027140944,
                                          N1083_8));

N1083_6 :=__common__( if(((real)f_rel_incomeover50_count_d < 11.5), N1083_7, 0.007019432));

N1083_5 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N1083_6, -0.009699292));

N1083_4 :=__common__( if(((real)c_retired < 15.6499996185), 0.00061724834, N1083_5));

N1083_3 :=__common__( if(trim(C_RETIRED) != '', N1083_4, 0.0044051644));

N1083_2 :=__common__( if(((real)f_srchssnsrchcount_i < 40.5), N1083_3, -0.0069524157));

N1083_1 :=__common__( if(((real)f_srchssnsrchcount_i > NULL), N1083_2, 0.0014448594));

N1084_10 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => 0.00079995492,
                ((real)r_d32_mos_since_crim_ls_d < 67.5)  => -0.0031509685,
                                                             0.00079995492));

N1084_9 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => N1084_10,
               ((real)f_m_bureau_adl_fs_all_d < 76.5)  => -0.0033146721,
                                                          N1084_10));

N1084_8 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.198606789112), 0.001371533, 0.010857482));

N1084_7 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1084_8, 0.0065711676));

N1084_6 :=__common__( if(((real)c_totsales < 13200.5), N1084_7, -0.0039285663));

N1084_5 :=__common__( if(trim(C_TOTSALES) != '', N1084_6, 0.0098660459));

N1084_4 :=__common__( if(((real)r_l80_inp_avm_autoval_d < 61851.5), 0.0078046603, -0.0026706398));

N1084_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1084_4, N1084_5));

N1084_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 29.5), N1084_3, N1084_9));

N1084_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N1084_2, -0.0034011723));

N1085_9 :=__common__( if(((real)f_college_income_d > NULL), 0.015349725, 0.0010433923));

N1085_8 :=__common__( map(trim(C_POP_25_34_P) = ''              => N1085_9,
               ((real)c_pop_25_34_p < 13.3500003815) => -0.0050374524,
                                                        N1085_9));

N1085_7 :=__common__( if(((real)c_totsales < 693.5), 0.008137293, N1085_8));

N1085_6 :=__common__( if(trim(C_TOTSALES) != '', N1085_7, 0.017228119));

N1085_5 :=__common__( map(((real)f_inq_adls_per_addr_i <= NULL) => 0.0050679458,
               ((real)f_inq_adls_per_addr_i < 4.5)   => -0.00080754231,
                                                        0.0050679458));

N1085_4 :=__common__( if(((real)c_inc_50k_p < 5.64999961853), -0.0061593613, N1085_5));

N1085_3 :=__common__( if(trim(C_INC_50K_P) != '', N1085_4, -0.0015424068));

N1085_2 :=__common__( if(((real)r_d34_unrel_liens_ct_i < 6.5), N1085_3, N1085_6));

N1085_1 :=__common__( if(((real)r_d34_unrel_liens_ct_i > NULL), N1085_2, -0.00079985462));

N1086_7 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 67.5), 0.00039720064, -0.0083252141));

N1086_6 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N1086_7, 0.027962602));

N1086_5 :=__common__( map(trim(C_FAMMAR18_P) = ''              => N1086_6,
               ((real)c_fammar18_p < 13.6499996185) => 0.0038035199,
                                                       N1086_6));

N1086_4 :=__common__( map(trim(C_HH5_P) = ''              => 5.2108239e-005,
               ((real)c_hh5_p < 0.15000000596) => 0.0032137976,
                                                  5.2108239e-005));

N1086_3 :=__common__( if(((real)c_young < 35.4500007629), N1086_4, N1086_5));

N1086_2 :=__common__( if(trim(C_YOUNG) != '', N1086_3, -0.0019848328));

N1086_1 :=__common__( map(((real)r_s65_ssn_problem_i <= NULL) => -0.0057320778,
               ((real)r_s65_ssn_problem_i < 0.5)   => N1086_2,
                                                      -0.0057320778));

N1087_8 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), 0.0086088188, -0.0036082483));

N1087_7 :=__common__( map(trim(C_FAMOTF18_P) = ''      => N1087_8,
               ((integer)c_famotf18_p < 29) => -0.010192557,
                                               N1087_8));

N1087_6 :=__common__( if(((real)f_divrisktype_i < 2.5), 0.0028532519, -0.0022238768));

N1087_5 :=__common__( if(((real)f_divrisktype_i > NULL), N1087_6, 0.00013351393));

N1087_4 :=__common__( map(trim(C_NEWHOUSE) = ''              => -0.00018848607,
               ((real)c_newhouse < 5.14999961853) => N1087_5,
                                                     -0.00018848607));

N1087_3 :=__common__( map(trim(C_POP_12_17_P) = ''              => N1087_4,
               ((real)c_pop_12_17_p < 3.04999995232) => -0.0045000544,
                                                        N1087_4));

N1087_2 :=__common__( if(((real)c_burglary < 191.5), N1087_3, N1087_7));

N1087_1 :=__common__( if(trim(C_BURGLARY) != '', N1087_2, 0.00012487638));

N1088_9 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.372821331024), 7.2290383e-005, -0.010969737));

N1088_8 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1088_9, -0.018017242));

N1088_7 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => 0.0019765818,
               ((real)r_c14_addrs_15yr_i < 13.5)  => -0.0015942748,
                                                     0.0019765818));

N1088_6 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)    => N1088_7,
               ((integer)f_curraddrmedianincome_d < 33127) => 0.0018853422,
                                                              N1088_7));

N1088_5 :=__common__( map(trim(C_LOWINC) = ''              => N1088_8,
               ((real)c_lowinc < 75.9499969482) => N1088_6,
                                                   N1088_8));

N1088_4 :=__common__( if(((real)c_bargains < 197.5), N1088_5, -0.0073188226));

N1088_3 :=__common__( if(trim(C_BARGAINS) != '', N1088_4, 0.00054383333));

N1088_2 :=__common__( if(((real)f_srchphonesrchcountwk_i < 0.5), N1088_3, 0.0072070612));

N1088_1 :=__common__( if(((real)f_srchphonesrchcountwk_i > NULL), N1088_2, -0.0008477694));

N1089_8 :=__common__( map(trim(C_VERY_RICH) = ''     => 0.0014471255,
               ((real)c_very_rich < 94.5) => 0.0088769317,
                                             0.0014471255));

N1089_7 :=__common__( map(trim(C_YOUNG) = ''              => -0.0036591828,
               ((real)c_young < 26.0499992371) => N1089_8,
                                                  -0.0036591828));

N1089_6 :=__common__( map(trim(C_OWNOCC_P) = ''              => N1089_7,
               ((real)c_ownocc_p < 68.4499969482) => -0.000744981,
                                                     N1089_7));

N1089_5 :=__common__( map(trim(C_INC_125K_P) = ''              => -0.0038886489,
               ((real)c_inc_125k_p < 10.6499996185) => N1089_6,
                                                       -0.0038886489));

N1089_4 :=__common__( if(((real)f_rel_homeover300_count_d < 9.5), N1089_5, 0.0056051405));

N1089_3 :=__common__( if(((real)f_rel_homeover300_count_d > NULL), N1089_4, -0.00041611434));

N1089_2 :=__common__( if(((real)c_popover18 < 2483.5), N1089_3, 0.005371575));

N1089_1 :=__common__( if(trim(C_POPOVER18) != '', N1089_2, -0.0018204249));

N1090_10 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => 0.004349258,
                ((real)f_add_input_mobility_index_n < 0.379363059998) => -0.0048373457,
                                                                         0.004349258));

N1090_9 :=__common__( if(((real)f_util_adl_count_n < 5.5), N1090_10, -0.010867475));

N1090_8 :=__common__( if(((real)f_util_adl_count_n > NULL), N1090_9, -0.0031456025));

N1090_7 :=__common__( if(((real)r_d34_unrel_lien60_count_i < 3.5), 0.00064732398, -0.0064071479));

N1090_6 :=__common__( if(((real)r_d34_unrel_lien60_count_i > NULL), N1090_7, 0.002781452));

N1090_5 :=__common__( map(trim(C_ARMFORCE) = ''      => 0.0056621779,
               ((real)c_armforce < 138.5) => -0.00067828476,
                                             0.0056621779));

N1090_4 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1090_5, N1090_6));

N1090_3 :=__common__( map(trim(C_SERV_EMPL) = ''      => N1090_8,
               ((real)c_serv_empl < 189.5) => N1090_4,
                                              N1090_8));

N1090_2 :=__common__( if(((real)c_pop_6_11_p < 14.9499998093), N1090_3, -0.0054352432));

N1090_1 :=__common__( if(trim(C_POP_6_11_P) != '', N1090_2, -0.0031592134));

N1091_10 :=__common__( map(((real)f_college_income_d <= NULL) => -0.0003488931,
                ((real)f_college_income_d < 2.5)   => -0.0091385648,
                                                      -0.0003488931));

N1091_9 :=__common__( map(trim(C_BIGAPT_P) = ''      => 0.007615906,
               ((real)c_bigapt_p < 13.25) => N1091_10,
                                             0.007615906));

N1091_8 :=__common__( map(trim(C_POP_65_74_P) = ''     => N1091_9,
               ((real)c_pop_65_74_p < 1.75) => 0.010676669,
                                               N1091_9));

N1091_7 :=__common__( if(((real)f_college_income_d > NULL), N1091_8, -0.00067695452));

N1091_6 :=__common__( if(((real)f_rel_educationover12_count_d < 29.5), N1091_7, 0.0048831164));

N1091_5 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N1091_6, 0.0027831546));

N1091_4 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.105441071093), 0.0014384201, 0.011842916));

N1091_3 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1091_4, 0.0094716606));

N1091_2 :=__common__( if(((real)c_child < 17.3499984741), N1091_3, N1091_5));

N1091_1 :=__common__( if(trim(C_CHILD) != '', N1091_2, -0.00096507765));

N1092_8 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => -0.003206013,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0743509754539) => -0.015755193,
                                                                       -0.003206013));

N1092_7 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL) => -0.0036299556,
               ((real)r_a50_pb_total_dollars_d < 607.5) => 0.0040454708,
                                                           -0.0036299556));

N1092_6 :=__common__( map(trim(C_HIGH_ED) = ''              => -0.01131788,
               ((real)c_high_ed < 26.6500015259) => N1092_7,
                                                    -0.01131788));

N1092_5 :=__common__( if(((real)c_serv_empl < 160.5), N1092_6, N1092_8));

N1092_4 :=__common__( if(trim(C_SERV_EMPL) != '', N1092_5, 0.0011886696));

N1092_3 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)     => 0.0024645369,
               ((integer)f_prevaddrmedianvalue_d < 159399) => N1092_4,
                                                              0.0024645369));

N1092_2 :=__common__( map(((real)f_accident_count_i <= NULL) => N1092_3,
               ((real)f_accident_count_i < 0.5)   => 0.00038307302,
                                                     N1092_3));

N1092_1 :=__common__( if(((real)f_accident_recency_d > NULL), N1092_2, -0.00069405349));

N1093_8 :=__common__( if(((real)c_pop_45_54_p < 14.1499996185), 0.013114438, -0.0019464695));

N1093_7 :=__common__( if(trim(C_POP_45_54_P) != '', N1093_8, -0.029377028));

N1093_6 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => -0.0058476948,
               ((real)c_dist_best_to_prev_addr_i < 1.5)   => -0.00017147796,
                                                             -0.0058476948));

N1093_5 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.0244233831763), 0.0028754898, N1093_6));

N1093_4 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1093_5, -0.00041913085));

N1093_3 :=__common__( if(((real)f_srchaddrsrchcount_i < 14.5), 0.00030560952, N1093_4));

N1093_2 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N1093_3, 0.0013674992));

N1093_1 :=__common__( map(((real)c_a49_prop_sold_purchase_tot_d <= NULL)    => N1093_7,
               ((integer)c_a49_prop_sold_purchase_tot_d < 27600) => N1093_2,
                                                                    N1093_7));

N1094_8 :=__common__( map(trim(C_RETIRED) = ''              => -0.0016579695,
               ((real)c_retired < 9.85000038147) => -0.010455154,
                                                    -0.0016579695));

N1094_7 :=__common__( if(((real)r_i60_inq_count12_i < 4.5), -0.00075816863, N1094_8));

N1094_6 :=__common__( if(((real)r_i60_inq_count12_i > NULL), N1094_7, 0.010765976));

N1094_5 :=__common__( map(trim(C_SUB_BUS) = ''      => N1094_6,
               ((real)c_sub_bus < 127.5) => 0.0007004139,
                                            N1094_6));

N1094_4 :=__common__( map(((real)r_l70_add_standardized_i <= NULL) => -0.0014948983,
               ((real)r_l70_add_standardized_i < 0.5)   => 0.0073037031,
                                                           -0.0014948983));

N1094_3 :=__common__( map(trim(C_SUB_BUS) = ''      => N1094_4,
               ((real)c_sub_bus < 105.5) => -0.0020137683,
                                            N1094_4));

N1094_2 :=__common__( if(((real)c_pop_65_74_p < 2.25), N1094_3, N1094_5));

N1094_1 :=__common__( if(trim(C_POP_65_74_P) != '', N1094_2, 0.0011536825));

N1095_8 :=__common__( map(trim(C_POP_0_5_P) = ''              => 0.0075417302,
               ((real)c_pop_0_5_p < 8.64999961853) => -0.0031811168,
                                                      0.0075417302));

N1095_7 :=__common__( map(trim(C_INC_35K_P) = ''              => 0.010140131,
               ((real)c_inc_35k_p < 10.1499996185) => N1095_8,
                                                      0.010140131));

N1095_6 :=__common__( map(trim(C_YOUNG) = ''              => -0.0040259211,
               ((real)c_young < 27.4500007629) => N1095_7,
                                                  -0.0040259211));

N1095_5 :=__common__( if(((real)c_hval_200k_p < 15.0500001907), N1095_6, 0.012010689));

N1095_4 :=__common__( if(trim(C_HVAL_200K_P) != '', N1095_5, 0.013749518));

N1095_3 :=__common__( map(((real)f_srchunvrfdssncount_i <= NULL) => 0.0050098619,
               ((real)f_srchunvrfdssncount_i < 1.5)   => -0.00036957984,
                                                         0.0050098619));

N1095_2 :=__common__( if(((real)f_curraddrmedianincome_d < 64244.5), N1095_3, N1095_4));

N1095_1 :=__common__( if(((real)f_curraddrmedianincome_d > NULL), N1095_2, -0.0079509005));

N1096_8 :=__common__( map(trim(C_POP_65_74_P) = ''              => 0.00487215,
               ((real)c_pop_65_74_p < 4.94999980927) => -0.004413824,
                                                        0.00487215));

N1096_7 :=__common__( map(trim(C_EASIQLIFE) = ''      => -0.0094731193,
               ((real)c_easiqlife < 126.5) => N1096_8,
                                              -0.0094731193));

N1096_6 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => N1096_7,
               ((real)f_curraddrmurderindex_i < 148.5) => 0.0027408357,
                                                          N1096_7));

N1096_5 :=__common__( map(((real)f_srchunvrfdssncount_i <= NULL) => 0.011614122,
               ((real)f_srchunvrfdssncount_i < 0.5)   => 0.00097145443,
                                                         0.011614122));

N1096_4 :=__common__( if(((real)c_med_rent < 377.5), N1096_5, N1096_6));

N1096_3 :=__common__( if(trim(C_MED_RENT) != '', N1096_4, 0.010975114));

N1096_2 :=__common__( if(((real)f_srchfraudsrchcountyr_i < 2.5), -0.00054212823, N1096_3));

N1096_1 :=__common__( if(((real)f_srchfraudsrchcountyr_i > NULL), N1096_2, -0.00041526628));

N1097_8 :=__common__( map(trim(C_POP_18_24_P) = ''              => -0.013458344,
               ((real)c_pop_18_24_p < 8.44999980927) => -0.0028274363,
                                                        -0.013458344));

N1097_7 :=__common__( map(trim(C_REST_INDX) = ''     => N1097_8,
               ((real)c_rest_indx < 94.5) => 0.0010317183,
                                             N1097_8));

N1097_6 :=__common__( map(trim(C_INC_150K_P) = ''     => 0.0004456898,
               ((real)c_inc_150k_p < 0.25) => -0.0028107114,
                                              0.0004456898));

N1097_5 :=__common__( map(((real)f_divrisktype_i <= NULL) => -0.0074058994,
               ((real)f_divrisktype_i < 5.5)   => N1097_6,
                                                  -0.0074058994));

N1097_4 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i < 12.5), N1097_5, 0.0050286065));

N1097_3 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i > NULL), N1097_4, 0.00055620027));

N1097_2 :=__common__( if(((real)c_new_homes < 184.5), N1097_3, N1097_7));

N1097_1 :=__common__( if(trim(C_NEW_HOMES) != '', N1097_2, -0.0032057465));

N1098_8 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => 0.015355,
               ((real)c_dist_best_to_prev_addr_i < 8.5)   => 0.00064306082,
                                                             0.015355));

N1098_7 :=__common__( map(((real)r_i60_inq_recency_d <= NULL) => 6.2354112e-005,
               ((integer)r_i60_inq_recency_d < 9)  => -0.0090112284,
                                                      6.2354112e-005));

N1098_6 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => 0.00035969296,
               ((real)r_c21_m_bureau_adl_fs_d < 19.5)  => 0.0084797758,
                                                          0.00035969296));

N1098_5 :=__common__( map(trim(C_INC_150K_P) = ''              => -0.0020587064,
               ((real)c_inc_150k_p < 4.35000038147) => N1098_6,
                                                       -0.0020587064));

N1098_4 :=__common__( if(((real)c_wholesale < 10.6499996185), N1098_5, N1098_7));

N1098_3 :=__common__( if(trim(C_WHOLESALE) != '', N1098_4, -0.0022656132));

N1098_2 :=__common__( if(((real)r_mos_since_paw_fseen_d < 76.5), N1098_3, N1098_8));

N1098_1 :=__common__( if(((real)r_mos_since_paw_fseen_d > NULL), N1098_2, -0.0047495202));

N1099_9 :=__common__( map(trim(C_RNT250_P) = ''              => 0.0098296459,
               ((real)c_rnt250_p < 4.55000019073) => -0.00070669287,
                                                     0.0098296459));

N1099_8 :=__common__( if(((real)f_add_input_mobility_index_n < 0.242162287235), 0.012263963, N1099_9));

N1099_7 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1099_8, -0.027377127));

N1099_6 :=__common__( map(trim(C_TOTCRIME) = ''      => -0.010441836,
               ((integer)c_totcrime < 63) => 0.0020230271,
                                             -0.010441836));

N1099_5 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => N1099_6,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.649867296219) => 0.0018496217,
                                                                      N1099_6));

N1099_4 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1099_5, -0.0014475393));

N1099_3 :=__common__( map(trim(C_INC_200K_P) = ''              => N1099_4,
               ((real)c_inc_200k_p < 4.05000019073) => 0.00024398166,
                                                       N1099_4));

N1099_2 :=__common__( if(((real)c_rnt1250_p < 14.6499996185), N1099_3, N1099_7));

N1099_1 :=__common__( if(trim(C_RNT1250_P) != '', N1099_2, -0.0010367007));

N1100_8 :=__common__( map(trim(C_POP_55_64_P) = ''              => 0.0033911551,
               ((real)c_pop_55_64_p < 12.9499998093) => -0.0061265911,
                                                        0.0033911551));

N1100_7 :=__common__( map(trim(C_HVAL_20K_P) = ''     => -0.00045804847,
               ((real)c_hval_20k_p < 0.75) => 0.0071262667,
                                              -0.00045804847));

N1100_6 :=__common__( if(((integer)f_prevaddrmedianincome_d < 61756), -0.00014657716, N1100_7));

N1100_5 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N1100_6, 0.00094875781));

N1100_4 :=__common__( map(trim(C_LUX_PROD) = ''      => -0.0081368066,
               ((real)c_lux_prod < 150.5) => N1100_5,
                                             -0.0081368066));

N1100_3 :=__common__( map(trim(C_INC_200K_P) = ''     => N1100_8,
               ((real)c_inc_200k_p < 5.75) => N1100_4,
                                              N1100_8));

N1100_2 :=__common__( if(((real)c_ab_av_edu < 168.5), N1100_3, 0.0085151919));

N1100_1 :=__common__( if(trim(C_AB_AV_EDU) != '', N1100_2, -0.0017999598));

N1101_9 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL) => -0.0013955428,
               ((real)f_prevaddrmurderindex_i < 164.5) => 0.0026176306,
                                                          -0.0013955428));

N1101_8 :=__common__( if(trim(C_FINANCE) != '', N1101_9, 0.001360348));

N1101_7 :=__common__( map(((real)f_assoccredbureaucount_i <= NULL) => N1101_8,
               ((real)f_assoccredbureaucount_i < 0.5)   => -0.0016862435,
                                                           N1101_8));

N1101_6 :=__common__( map(((real)r_i60_inq_count12_i <= NULL) => 0.0079385079,
               ((real)r_i60_inq_count12_i < 12.5)  => N1101_7,
                                                      0.0079385079));

N1101_5 :=__common__( if(((real)c_burglary < 113.5), 0.013991675, 0.001800936));

N1101_4 :=__common__( if(trim(C_BURGLARY) != '', N1101_5, 0.050339706));

N1101_3 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => N1101_6,
               ((real)r_a50_pb_average_dollars_d < 13.5)  => N1101_4,
                                                             N1101_6));

N1101_2 :=__common__( if(((real)f_divrisktype_i < 2.5), N1101_3, -0.0020003722));

N1101_1 :=__common__( if(((real)f_divrisktype_i > NULL), N1101_2, 0.0057973862));

N1102_9 :=__common__( if(((real)c_retired < 4.14999961853), -0.0025608646, 0.00068909482));

N1102_8 :=__common__( if(trim(C_RETIRED) != '', N1102_9, 0.00011244076));

N1102_7 :=__common__( map(trim(C_UNATTACH) = ''      => 0.0017910375,
               ((real)c_unattach < 125.5) => -0.009316344,
                                             0.0017910375));

N1102_6 :=__common__( if(((real)f_prevaddrstatus_i > NULL), N1102_7, 0.012299455));

N1102_5 :=__common__( map(trim(C_OLD_HOMES) = ''     => N1102_6,
               ((real)c_old_homes < 65.5) => -0.012819855,
                                             N1102_6));

N1102_4 :=__common__( if(((real)c_inc_75k_p < 21.5499992371), N1102_5, 0.0020422256));

N1102_3 :=__common__( if(trim(C_INC_75K_P) != '', N1102_4, 0.007718987));

N1102_2 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d < 39.5), N1102_3, N1102_8));

N1102_1 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d > NULL), N1102_2, 0.0004770925));

N1103_8 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => -0.0037326404,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.853984951973) => 0.0074810092,
                                                                      -0.0037326404));

N1103_7 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)    => -0.00929102,
               ((integer)f_prevaddrmedianincome_d < 39380) => N1103_8,
                                                              -0.00929102));

N1103_6 :=__common__( if(((real)r_d30_derog_count_i < 5.5), N1103_7, -0.0097160662));

N1103_5 :=__common__( if(((real)r_d30_derog_count_i > NULL), N1103_6, 0.012123297));

N1103_4 :=__common__( map(trim(C_VACANT_P) = ''              => 0.00066174987,
               ((real)c_vacant_p < 4.55000019073) => -0.0057513944,
                                                     0.00066174987));

N1103_3 :=__common__( map(trim(C_OLDHOUSE) = ''              => N1103_5,
               ((real)c_oldhouse < 151.050003052) => N1103_4,
                                                     N1103_5));

N1103_2 :=__common__( if(((real)c_sfdu_p < 73.9499969482), 0.00080043788, N1103_3));

N1103_1 :=__common__( if(trim(C_SFDU_P) != '', N1103_2, -0.00025230223));

N1104_8 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL) => -0.0059977642,
               ((real)f_liens_unrel_cj_total_amt_i < 945.5) => 0.0029276349,
                                                               -0.0059977642));

N1104_7 :=__common__( map(trim(C_POP_35_44_P) = ''      => N1104_8,
               ((real)c_pop_35_44_p < 12.25) => -0.0079746233,
                                                N1104_8));

N1104_6 :=__common__( if(((real)f_srchphonesrchcount_i < 5.5), 0.00060913625, N1104_7));

N1104_5 :=__common__( if(((real)f_srchphonesrchcount_i > NULL), N1104_6, 0.0025195227));

N1104_4 :=__common__( map(trim(C_CIV_EMP) = ''              => -0.00063489818,
               ((real)c_civ_emp < 61.1500015259) => 0.012248525,
                                                    -0.00063489818));

N1104_3 :=__common__( map(trim(C_VACANT_P) = ''              => N1104_5,
               ((real)c_vacant_p < 3.54999995232) => N1104_4,
                                                     N1104_5));

N1104_2 :=__common__( if(((real)c_inc_125k_p < 16.3499984741), N1104_3, -0.0072148405));

N1104_1 :=__common__( if(trim(C_INC_125K_P) != '', N1104_2, -1.766591e-005));

N1105_8 :=__common__( map(trim(C_SERV_EMPL) = ''      => 0.0033005516,
               ((real)c_serv_empl < 179.5) => 0.00015247412,
                                              0.0033005516));

N1105_7 :=__common__( map(trim(C_VACANT_P) = ''              => -0.0057500752,
               ((real)c_vacant_p < 13.6499996185) => 0.006826702,
                                                     -0.0057500752));

N1105_6 :=__common__( map(trim(C_BORN_USA) = ''      => N1105_7,
               ((real)c_born_usa < 114.5) => -0.0067593247,
                                             N1105_7));

N1105_5 :=__common__( map(trim(C_POP_45_54_P) = ''              => N1105_8,
               ((real)c_pop_45_54_p < 7.55000019073) => N1105_6,
                                                        N1105_8));

N1105_4 :=__common__( if(((real)r_c13_curr_addr_lres_d < 22.5), -0.011503393, 0.0026366664));

N1105_3 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1105_4, -0.011198968));

N1105_2 :=__common__( if(((real)c_hh4_p < 0.550000011921), N1105_3, N1105_5));

N1105_1 :=__common__( if(trim(C_HH4_P) != '', N1105_2, -0.0012063862));

N1106_8 :=__common__( map(((real)f_historical_count_d <= NULL) => 0.00016330047,
               ((real)f_historical_count_d < 2.5)   => 0.0076306947,
                                                       0.00016330047));

N1106_7 :=__common__( map(trim(C_MORT_INDX) = ''     => 0.00018767649,
               ((real)c_mort_indx < 60.5) => N1106_8,
                                             0.00018767649));

N1106_6 :=__common__( map(trim(C_HH4_P) = ''      => -0.0095257421,
               ((real)c_hh4_p < 25.25) => -0.0006532994,
                                          -0.0095257421));

N1106_5 :=__common__( map(trim(C_HVAL_500K_P) = ''     => -0.0094872595,
               ((real)c_hval_500k_p < 3.75) => N1106_6,
                                               -0.0094872595));

N1106_4 :=__common__( map(trim(C_MED_RENT) = ''      => 0.0027275141,
               ((real)c_med_rent < 803.5) => N1106_5,
                                             0.0027275141));

N1106_3 :=__common__( if(((real)r_c14_addrs_15yr_i < 8.5), N1106_4, N1106_7));

N1106_2 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N1106_3, -0.0034803714));

N1106_1 :=__common__( if(trim(C_HVAL_200K_P) != '', N1106_2, -0.0028641864));

N1107_10 :=__common__( if(((real)c_pop_25_34_p < 13.4499998093), 0.0098836997, -0.00046610244));

N1107_9 :=__common__( if(trim(C_POP_25_34_P) != '', N1107_10, 0.038430957));

N1107_8 :=__common__( map(trim(C_BARGAINS) = ''      => 0.0059119839,
               ((real)c_bargains < 189.5) => -0.0023193647,
                                             0.0059119839));

N1107_7 :=__common__( if(((real)f_addrchangeincomediff_d < -16994.5), 0.0027623418, -0.0019040428));

N1107_6 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1107_7, N1107_8));

N1107_5 :=__common__( map(trim(C_POP_6_11_P) = ''              => N1107_6,
               ((real)c_pop_6_11_p < 6.55000019073) => 0.0011770066,
                                                       N1107_6));

N1107_4 :=__common__( if(((real)c_rich_blk < 197.5), N1107_5, 0.0058984217));

N1107_3 :=__common__( if(trim(C_RICH_BLK) != '', N1107_4, 0.0048997843));

N1107_2 :=__common__( if(((real)f_inq_per_addr_i < 14.5), N1107_3, N1107_9));

N1107_1 :=__common__( if(((real)f_inq_per_addr_i > NULL), N1107_2, -0.011589662));

N1108_7 :=__common__( map(trim(C_CHILD) = ''              => -0.00019819948,
               ((real)c_child < 20.6500015259) => -0.0076210702,
                                                  -0.00019819948));

N1108_6 :=__common__( map(trim(C_LARCENY) = ''      => 0.01171102,
               ((real)c_larceny < 171.5) => 0.002545564,
                                            0.01171102));

N1108_5 :=__common__( map(trim(C_ROBBERY) = ''       => -0.0083324716,
               ((integer)c_robbery < 110) => 0.0046895177,
                                             -0.0083324716));

N1108_4 :=__common__( map(trim(C_NO_CAR) = ''      => N1108_6,
               ((real)c_no_car < 122.5) => N1108_5,
                                           N1108_6));

N1108_3 :=__common__( map(trim(C_CHILD) = ''              => N1108_7,
               ((real)c_child < 19.4500007629) => N1108_4,
                                                  N1108_7));

N1108_2 :=__common__( if(((real)c_serv_empl < 12.5), 0.0076547585, N1108_3));

N1108_1 :=__common__( if(trim(C_SERV_EMPL) != '', N1108_2, -0.0019372355));

N1109_8 :=__common__( map(trim(C_OLD_HOMES) = ''      => -0.0051423804,
               ((real)c_old_homes < 138.5) => 0.0058147478,
                                              -0.0051423804));

N1109_7 :=__common__( map(trim(C_POP_12_17_P) = ''              => -0.00376732,
               ((real)c_pop_12_17_p < 6.94999980927) => N1109_8,
                                                        -0.00376732));

N1109_6 :=__common__( map(trim(C_ASIAN_LANG) = ''      => 0.0044550181,
               ((real)c_asian_lang < 136.5) => 0.00022009858,
                                               0.0044550181));

N1109_5 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N1109_6,
               ((real)c_hist_addr_match_i < 2.5)   => -0.00086780352,
                                                      N1109_6));

N1109_4 :=__common__( map(trim(C_BORN_USA) = ''      => 0.007898175,
               ((real)c_born_usa < 173.5) => N1109_5,
                                             0.007898175));

N1109_3 :=__common__( if(((real)c_born_usa < 177.5), N1109_4, N1109_7));

N1109_2 :=__common__( if(trim(C_BORN_USA) != '', N1109_3, 0.0016666531));

N1109_1 :=__common__( if(((real)f_rel_ageover50_count_d > NULL), N1109_2, -0.0017748834));

N1110_9 :=__common__( map(trim(C_INC_201K_P) = ''              => 0.005639697,
               ((real)c_inc_201k_p < 1.15000009537) => -0.0058828105,
                                                       0.005639697));

N1110_8 :=__common__( map(trim(C_ASIAN_LANG) = ''      => N1110_9,
               ((real)c_asian_lang < 117.5) => 0.008352329,
                                               N1110_9));

N1110_7 :=__common__( map(trim(C_INC_25K_P) = ''              => 0.0054729713,
               ((real)c_inc_25k_p < 14.1499996185) => -0.0041618953,
                                                      0.0054729713));

N1110_6 :=__common__( if(((real)r_c13_max_lres_d < 82.5), N1110_7, N1110_8));

N1110_5 :=__common__( if(((real)r_c13_max_lres_d > NULL), N1110_6, -0.033206105));

N1110_4 :=__common__( if(((real)f_varrisktype_i < 2.5), -0.0015254816, 0.00082362477));

N1110_3 :=__common__( if(((real)f_varrisktype_i > NULL), N1110_4, 0.0021959285));

N1110_2 :=__common__( if(((integer)c_totsales < 21644), N1110_3, N1110_5));

N1110_1 :=__common__( if(trim(C_TOTSALES) != '', N1110_2, -0.00071529472));

N1111_8 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => 0.0050882561,
               ((real)f_curraddrmurderindex_i < 167.5) => -0.003703958,
                                                          0.0050882561));

N1111_7 :=__common__( if(((real)c_old_homes < 145.5), N1111_8, -0.0073960143));

N1111_6 :=__common__( if(trim(C_OLD_HOMES) != '', N1111_7, -0.0001596382));

N1111_5 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL) => 0.0018791563,
               ((real)f_fp_prevaddrburglaryindex_i < 156.5) => 0.007744402,
                                                               0.0018791563));

N1111_4 :=__common__( map(((real)r_c18_invalid_addrs_per_adl_i <= NULL) => N1111_6,
               ((real)r_c18_invalid_addrs_per_adl_i < 1.5)   => N1111_5,
                                                                N1111_6));

N1111_3 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => 0.00014757561,
               ((real)f_curraddrmedianincome_d < 29174.5) => N1111_4,
                                                             0.00014757561));

N1111_2 :=__common__( if(((real)r_d31_mostrec_bk_i < 1.5), N1111_3, -0.0033445917));

N1111_1 :=__common__( if(((real)r_d31_mostrec_bk_i > NULL), N1111_2, 0.0080279466));

N1112_8 :=__common__( map(trim(C_UNEMPL) = ''      => 0.0057877833,
               ((real)c_unempl < 193.5) => -0.0038408818,
                                           0.0057877833));

N1112_7 :=__common__( map(trim(C_RNT1000_P) = ''              => -0.0029275767,
               ((real)c_rnt1000_p < 2.84999990463) => -0.013473836,
                                                      -0.0029275767));

N1112_6 :=__common__( map(trim(C_INC_25K_P) = ''              => N1112_8,
               ((real)c_inc_25k_p < 14.6499996185) => N1112_7,
                                                      N1112_8));

N1112_5 :=__common__( map(((real)c_addr_lres_12mo_ct_i <= NULL) => -0.0005086588,
               ((real)c_addr_lres_12mo_ct_i < 5.5)   => 0.002938861,
                                                        -0.0005086588));

N1112_4 :=__common__( if(((real)f_rel_felony_count_i < 0.5), -0.001015502, N1112_5));

N1112_3 :=__common__( if(((real)f_rel_felony_count_i > NULL), N1112_4, 0.003726057));

N1112_2 :=__common__( if(((real)c_unempl < 185.5), N1112_3, N1112_6));

N1112_1 :=__common__( if(trim(C_UNEMPL) != '', N1112_2, -0.0024645855));

N1113_8 :=__common__( map(trim(C_CHILD) = ''              => 0.0035390586,
               ((real)c_child < 26.0499992371) => -0.0038157981,
                                                  0.0035390586));

N1113_7 :=__common__( map(trim(C_POP_65_74_P) = ''              => -0.0014105251,
               ((real)c_pop_65_74_p < 2.15000009537) => N1113_8,
                                                        -0.0014105251));

N1113_6 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.0074108194,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0963723808527) => -0.0026588388,
                                                                       0.0074108194));

N1113_5 :=__common__( map(((real)f_inq_count24_i <= NULL) => -0.0058442637,
               ((real)f_inq_count24_i < 6.5)   => N1113_6,
                                                  -0.0058442637));

N1113_4 :=__common__( if(((real)f_corrrisktype_i < 7.5), N1113_5, 0.0081187282));

N1113_3 :=__common__( if(((real)f_corrrisktype_i > NULL), N1113_4, -0.032051183));

N1113_2 :=__common__( if(((real)c_white_col < 15.5500001907), N1113_3, N1113_7));

N1113_1 :=__common__( if(trim(C_WHITE_COL) != '', N1113_2, 0.0012999452));

N1114_9 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => -0.00025562483,
               ((real)f_mos_inq_banko_cm_lseen_d < 31.5)  => -0.0086433261,
                                                             -0.00025562483));

N1114_8 :=__common__( if(((real)c_unemp < 5.94999980927), 0.0036478276, N1114_9));

N1114_7 :=__common__( if(trim(C_UNEMP) != '', N1114_8, -0.00029783462));

N1114_6 :=__common__( if(((real)c_unemp < 12.6499996185), 0.0029377318, 0.010948612));

N1114_5 :=__common__( if(trim(C_UNEMP) != '', N1114_6, -0.0049432582));

N1114_4 :=__common__( map(((real)f_srchphonesrchcount_i <= NULL) => N1114_7,
               ((real)f_srchphonesrchcount_i < 0.5)   => N1114_5,
                                                         N1114_7));

N1114_3 :=__common__( map(((real)f_corrphonelastnamecount_d <= NULL) => -0.0013356502,
               ((real)f_corrphonelastnamecount_d < 0.5)   => N1114_4,
                                                             -0.0013356502));

N1114_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 84.5), -0.0015449838, N1114_3));

N1114_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N1114_2, -0.0049218955));

N1115_9 :=__common__( map(trim(C_ASIAN_LANG) = ''      => 0.0010890175,
               ((real)c_asian_lang < 125.5) => -0.008426596,
                                               0.0010890175));

N1115_8 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => N1115_9,
               ((real)f_srchaddrsrchcount_i < 4.5)   => 0.0032104755,
                                                        N1115_9));

N1115_7 :=__common__( map(trim(C_UNATTACH) = ''      => -0.0058377275,
               ((real)c_unattach < 129.5) => N1115_8,
                                             -0.0058377275));

N1115_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0073030795902), -0.005878116, 0.0014637287));

N1115_5 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1115_6, 0.00021544204));

N1115_4 :=__common__( if(((integer)f_curraddrmedianvalue_d < 176539), N1115_5, N1115_7));

N1115_3 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N1115_4, 0.0085557772));

N1115_2 :=__common__( if(((real)c_trailer_p < 46.0499992371), N1115_3, -0.0060425463));

N1115_1 :=__common__( if(trim(C_TRAILER_P) != '', N1115_2, 0.0023697911));

N1116_10 :=__common__( map(trim(C_POP_45_54_P) = ''              => 0.0002030101,
                ((real)c_pop_45_54_p < 14.3500003815) => 0.0069117449,
                                                         0.0002030101));

N1116_9 :=__common__( if(((real)c_professional < 4.85000038147), N1116_10, -0.0027497022));

N1116_8 :=__common__( if(trim(C_PROFESSIONAL) != '', N1116_9, 0.015156737));

N1116_7 :=__common__( map(((real)r_i60_inq_retail_recency_d <= NULL) => N1116_8,
               ((real)r_i60_inq_retail_recency_d < 61.5)  => 0.011178657,
                                                             N1116_8));

N1116_6 :=__common__( if(((real)f_rel_educationover12_count_d < 20.5), N1116_7, -0.0039130103));

N1116_5 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N1116_6, 0.010116164));

N1116_4 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.515044927597), 4.7554433e-005, -0.007478365));

N1116_3 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N1116_4, -0.0066607104));

N1116_2 :=__common__( if(((real)f_srchfraudsrchcountyr_i < 3.5), N1116_3, N1116_5));

N1116_1 :=__common__( if(((real)f_srchfraudsrchcountyr_i > NULL), N1116_2, -0.0012483615));

N1117_8 :=__common__( map(trim(C_SPAN_LANG) = ''      => 0.0087498413,
               ((real)c_span_lang < 100.5) => -0.0015841222,
                                              0.0087498413));

N1117_7 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => N1117_8,
               ((real)r_d32_criminal_count_i < 5.5)   => -0.0027832385,
                                                         N1117_8));

N1117_6 :=__common__( map(trim(C_BURGLARY) = ''      => N1117_7,
               ((real)c_burglary < 157.5) => 0.00050734402,
                                             N1117_7));

N1117_5 :=__common__( map(trim(C_INC_150K_P) = ''     => -0.0063143868,
               ((real)c_inc_150k_p < 4.75) => 0.0056280606,
                                              -0.0063143868));

N1117_4 :=__common__( map(trim(C_HVAL_60K_P) = ''              => -0.0098861603,
               ((real)c_hval_60k_p < 1.65000009537) => N1117_5,
                                                       -0.0098861603));

N1117_3 :=__common__( if(((real)f_curraddrcrimeindex_i < 28.5), N1117_4, N1117_6));

N1117_2 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N1117_3, 0.0013410714));

N1117_1 :=__common__( if(trim(C_FOOD) != '', N1117_2, 0.00021254088));

N1118_8 :=__common__( map(trim(C_LUX_PROD) = ''     => 0.0067941728,
               ((real)c_lux_prod < 61.5) => -0.0017789197,
                                            0.0067941728));

N1118_7 :=__common__( map(trim(C_VACANT_P) = ''      => N1118_8,
               ((real)c_vacant_p < 11.75) => -0.0049608067,
                                             N1118_8));

N1118_6 :=__common__( map(((real)c_unique_addr_count_i <= NULL) => -8.4906069e-005,
               ((real)c_unique_addr_count_i < 3.5)   => 0.0041714495,
                                                        -8.4906069e-005));

N1118_5 :=__common__( map(trim(C_LOW_ED) = ''              => 0.0053341731,
               ((real)c_low_ed < 76.4499969482) => N1118_6,
                                                   0.0053341731));

N1118_4 :=__common__( if(((real)c_inc_25k_p < 18.5499992371), N1118_5, N1118_7));

N1118_3 :=__common__( if(trim(C_INC_25K_P) != '', N1118_4, 0.0026695855));

N1118_2 :=__common__( if(((real)f_current_count_d < 6.5), N1118_3, -0.0053937067));

N1118_1 :=__common__( if(((real)f_current_count_d > NULL), N1118_2, 0.0028717416));

N1119_9 :=__common__( map(trim(C_OLDHOUSE) = ''              => 0.0065657026,
               ((real)c_oldhouse < 264.950012207) => -0.00045121679,
                                                     0.0065657026));

N1119_8 :=__common__( map(trim(C_NO_CAR) = ''     => N1119_9,
               ((real)c_no_car < 19.5) => 0.0085894237,
                                          N1119_9));

N1119_7 :=__common__( map(trim(C_HHSIZE) = ''              => N1119_8,
               ((real)c_hhsize < 2.14499998093) => 0.0077118992,
                                                   N1119_8));

N1119_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1119_7, 0.0049767168));

N1119_5 :=__common__( if(((real)f_liens_unrel_ot_total_amt_i < 782.5), -0.0016598533, 0.0066490607));

N1119_4 :=__common__( if(((real)f_liens_unrel_ot_total_amt_i > NULL), N1119_5, -0.018307801));

N1119_3 :=__common__( map(trim(C_FAMMAR_P) = ''      => 0.0056191205,
               ((real)c_fammar_p < 86.75) => N1119_4,
                                             0.0056191205));

N1119_2 :=__common__( if(((real)c_inc_75k_p < 19.25), N1119_3, N1119_6));

N1119_1 :=__common__( if(trim(C_INC_75K_P) != '', N1119_2, 0.0018681865));

N1120_9 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL) => 0.00077569218,
               ((real)r_a50_pb_total_dollars_d < 18.5)  => -0.0035889267,
                                                           0.00077569218));

N1120_8 :=__common__( if(((real)c_span_lang < 99.5), -0.009382836, 0.0013282985));

N1120_7 :=__common__( if(trim(C_SPAN_LANG) != '', N1120_8, -0.036987168));

N1120_6 :=__common__( map(((real)f_mos_liens_unrel_lt_fseen_d <= NULL) => N1120_9,
               ((real)f_mos_liens_unrel_lt_fseen_d < 48.5)  => N1120_7,
                                                               N1120_9));

N1120_5 :=__common__( if(((real)c_inc_75k_p < 16.5499992371), -0.010318777, 0.00030248064));

N1120_4 :=__common__( if(trim(C_INC_75K_P) != '', N1120_5, -0.013002637));

N1120_3 :=__common__( map(((real)r_i60_inq_retail_recency_d <= NULL) => N1120_6,
               ((real)r_i60_inq_retail_recency_d < 61.5)  => N1120_4,
                                                             N1120_6));

N1120_2 :=__common__( if(((real)c_mos_since_impulse_ls_d < 28.5), -0.0080462022, N1120_3));

N1120_1 :=__common__( if(((real)c_mos_since_impulse_ls_d > NULL), N1120_2, 0.0027606906));

N1121_8 :=__common__( map(((real)f_rel_bankrupt_count_i <= NULL) => 0.0035319855,
               ((real)f_rel_bankrupt_count_i < 4.5)   => -0.0021235786,
                                                         0.0035319855));

N1121_7 :=__common__( map(((real)f_inq_per_phone_i <= NULL) => 0.005824621,
               ((real)f_inq_per_phone_i < 2.5)   => N1121_8,
                                                    0.005824621));

N1121_6 :=__common__( map(trim(C_FAMMAR18_P) = ''              => -0.0077716791,
               ((real)c_fammar18_p < 33.8499984741) => -0.00070054404,
                                                       -0.0077716791));

N1121_5 :=__common__( map(trim(C_NO_TEENS) = ''     => N1121_7,
               ((real)c_no_teens < 45.5) => N1121_6,
                                            N1121_7));

N1121_4 :=__common__( if(((real)f_rel_incomeover25_count_d < 10.5), 0.0013777745, N1121_5));

N1121_3 :=__common__( if(((real)f_rel_incomeover25_count_d > NULL), N1121_4, 0.00084244408));

N1121_2 :=__common__( if(((real)c_food < 80.8500061035), N1121_3, 0.0063148228));

N1121_1 :=__common__( if(trim(C_FOOD) != '', N1121_2, -0.0024316422));

N1122_9 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 9.5), 0.0079504841, 0.00072093707));

N1122_8 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N1122_9, 0.00162114));

N1122_7 :=__common__( if(((real)f_mos_acc_lseen_d < 36.5), 0.0046368836, -0.0017561827));

N1122_6 :=__common__( if(((real)f_mos_acc_lseen_d > NULL), N1122_7, 0.010144621));

N1122_5 :=__common__( map(trim(C_POP_12_17_P) = ''     => N1122_8,
               ((real)c_pop_12_17_p < 9.25) => N1122_6,
                                               N1122_8));

N1122_4 :=__common__( map(trim(C_RETAIL) = ''              => 0.00056840269,
               ((real)c_retail < 7.85000038147) => 0.0097723147,
                                                   0.00056840269));

N1122_3 :=__common__( map(((real)r_l79_adls_per_addr_c6_i <= NULL) => -0.0014487698,
               ((real)r_l79_adls_per_addr_c6_i < 1.5)   => N1122_4,
                                                           -0.0014487698));

N1122_2 :=__common__( if(((real)c_inc_75k_p < 7.64999961853), N1122_3, N1122_5));

N1122_1 :=__common__( if(trim(C_INC_75K_P) != '', N1122_2, -0.00022844702));

N1123_8 :=__common__( map(trim(C_HH5_P) = ''              => -0.0039094386,
               ((real)c_hh5_p < 9.05000019073) => 0.00033397199,
                                                  -0.0039094386));

N1123_7 :=__common__( map(trim(C_HVAL_60K_P) = ''              => -0.0062197234,
               ((real)c_hval_60k_p < 27.8499984741) => N1123_8,
                                                       -0.0062197234));

N1123_6 :=__common__( map(trim(C_HVAL_20K_P) = ''              => 0.0088107245,
               ((real)c_hval_20k_p < 22.3499984741) => N1123_7,
                                                       0.0088107245));

N1123_5 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => 0.0012661757,
               ((real)f_curraddrmedianincome_d < 13986.5) => 0.0083815872,
                                                             0.0012661757));

N1123_4 :=__common__( map(trim(C_POP_35_44_P) = ''              => -0.0067206493,
               ((real)c_pop_35_44_p < 22.6500015259) => N1123_5,
                                                        -0.0067206493));

N1123_3 :=__common__( if(((real)c_serv_empl < 132.5), N1123_4, N1123_6));

N1123_2 :=__common__( if(trim(C_SERV_EMPL) != '', N1123_3, 0.00077790275));

N1123_1 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i > NULL), N1123_2, 0.0010356067));

N1124_8 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => 0.0046701362,
               ((real)r_c14_addrs_15yr_i < 3.5)   => -0.0052654408,
                                                     0.0046701362));

N1124_7 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => N1124_8,
               ((real)r_d32_mos_since_crim_ls_d < 76.5)  => -0.0020732954,
                                                            N1124_8));

N1124_6 :=__common__( map(trim(C_BLUE_COL) = ''              => N1124_7,
               ((real)c_blue_col < 17.0499992371) => -0.0012916846,
                                                     N1124_7));

N1124_5 :=__common__( map(trim(C_POPOVER18) = ''      => N1124_6,
               ((real)c_popover18 < 570.5) => -0.0068059987,
                                              N1124_6));

N1124_4 :=__common__( if(((real)r_a50_pb_average_dollars_d < 6.5), 0.0079935675, N1124_5));

N1124_3 :=__common__( if(((real)r_a50_pb_average_dollars_d > NULL), N1124_4, 0.0047327097));

N1124_2 :=__common__( if(((real)c_pop00 < 734.5), 0.0030533747, N1124_3));

N1124_1 :=__common__( if(trim(C_POP00) != '', N1124_2, 0.0016213768));

N1125_10 :=__common__( if(((real)f_curraddrmurderindex_i < 100.5), 0.008713485, -0.0014420362));

N1125_9 :=__common__( if(((real)f_curraddrmurderindex_i > NULL), N1125_10, -0.020118131));

N1125_8 :=__common__( map(trim(C_NEW_HOMES) = ''      => N1125_9,
               ((real)c_new_homes < 115.5) => -0.0035311453,
                                              N1125_9));

N1125_7 :=__common__( if(((real)f_inq_highriskcredit_count24_i < 0.5), 0.010419062, -0.00044057227));

N1125_6 :=__common__( if(((real)f_inq_highriskcredit_count24_i > NULL), N1125_7, 0.013070872));

N1125_5 :=__common__( map(trim(C_HH00) = ''      => N1125_8,
               ((real)c_hh00 < 414.5) => N1125_6,
                                         N1125_8));

N1125_4 :=__common__( if(((real)c_rape < 190.5), N1125_5, 0.0100783));

N1125_3 :=__common__( if(trim(C_RAPE) != '', N1125_4, -0.012172305));

N1125_2 :=__common__( if(((real)r_l77_apartment_i < 0.5), -0.00094365166, N1125_3));

N1125_1 :=__common__( if(((real)r_l77_apartment_i > NULL), N1125_2, 0.012174387));

N1126_8 :=__common__( map(trim(C_BARGAINS) = ''      => -0.0056436499,
               ((real)c_bargains < 155.5) => 0.0066053943,
                                             -0.0056436499));

N1126_7 :=__common__( map(trim(C_OLD_HOMES) = ''      => -0.0068934848,
               ((real)c_old_homes < 107.5) => 0.00092026911,
                                              -0.0068934848));

N1126_6 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i < 2.5), -0.0024834216, -0.014441102));

N1126_5 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i > NULL), N1126_6, 0.00022594429));

N1126_4 :=__common__( map(trim(C_BIGAPT_P) = ''              => N1126_7,
               ((real)c_bigapt_p < 0.15000000596) => N1126_5,
                                                     N1126_7));

N1126_3 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => N1126_8,
               ((real)r_l79_adls_per_addr_curr_i < 20.5)  => N1126_4,
                                                             N1126_8));

N1126_2 :=__common__( if(((real)c_pop_18_24_p < 14.4499998093), 0.00045637878, N1126_3));

N1126_1 :=__common__( if(trim(C_POP_18_24_P) != '', N1126_2, 0.0028728699));

N1127_9 :=__common__( map(((real)f_inq_per_addr_i <= NULL) => -0.0017178424,
               ((real)f_inq_per_addr_i < 1.5)   => 0.0090397185,
                                                   -0.0017178424));

N1127_8 :=__common__( map(trim(C_LOW_HVAL) = ''      => 0.012880997,
               ((real)c_low_hval < 26.25) => 0.0025700356,
                                             0.012880997));

N1127_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1127_8, -0.0099846634));

N1127_6 :=__common__( map(trim(C_ASSAULT) = ''      => -0.006171744,
               ((real)c_assault < 169.5) => N1127_7,
                                            -0.006171744));

N1127_5 :=__common__( map(trim(C_SFDU_P) = ''              => N1127_6,
               ((real)c_sfdu_p < 80.0500030518) => -0.0015878264,
                                                   N1127_6));

N1127_4 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), 7.8054117e-005, N1127_5));

N1127_3 :=__common__( map(trim(C_MED_AGE) = ''              => N1127_4,
               ((real)c_med_age < 23.3499984741) => -0.0071447599,
                                                    N1127_4));

N1127_2 :=__common__( if(((real)c_pop_18_24_p < 19.3499984741), N1127_3, N1127_9));

N1127_1 :=__common__( if(trim(C_POP_18_24_P) != '', N1127_2, 0.0027932168));

N1128_9 :=__common__( if(((real)c_inc_150k_p < 1.65000009537), -0.0049154636, 0.0015693437));

N1128_8 :=__common__( if(trim(C_INC_150K_P) != '', N1128_9, -0.0022350798));

N1128_7 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => -0.010620252,
               ((real)f_curraddrmedianincome_d < 56208.5) => N1128_8,
                                                             -0.010620252));

N1128_6 :=__common__( map(((real)f_estimated_income_d <= NULL)    => 0.0072978509,
               ((integer)f_estimated_income_d < 54500) => N1128_7,
                                                          0.0072978509));

N1128_5 :=__common__( if(((real)f_rel_homeover200_count_d < 8.5), N1128_6, -0.011856831));

N1128_4 :=__common__( if(((real)f_rel_homeover200_count_d > NULL), N1128_5, 0.00014019256));

N1128_3 :=__common__( map(((real)f_corrrisktype_i <= NULL) => -0.0042335137,
               ((real)f_corrrisktype_i < 8.5)   => 0.0013591212,
                                                   -0.0042335137));

N1128_2 :=__common__( if(((integer)c_hist_addr_match_i < 70), N1128_3, N1128_4));

N1128_1 :=__common__( if(((real)c_hist_addr_match_i > NULL), N1128_2, -0.0038904543));

N1129_9 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.002911655,
               ((real)r_d32_criminal_count_i < 1.5)   => 9.7279533e-005,
                                                         0.002911655));

N1129_8 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.335206478834), -0.0041237079, 0.0029377307));

N1129_7 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1129_8, -0.0067948759));

N1129_6 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => 0.0028094843,
               ((real)f_add_curr_nhood_vac_pct_i < 0.187052801251) => N1129_7,
                                                                      0.0028094843));

N1129_5 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)   => N1129_9,
               ((real)f_curraddrmedianvalue_d < 72795.5) => N1129_6,
                                                            N1129_9));

N1129_4 :=__common__( if(((real)c_bargains < 196.5), N1129_5, -0.0059810907));

N1129_3 :=__common__( if(trim(C_BARGAINS) != '', N1129_4, 0.00029593204));

N1129_2 :=__common__( if(((real)f_corrssnnamecount_d < 8.5), N1129_3, -0.0040186705));

N1129_1 :=__common__( if(((real)f_corrssnnamecount_d > NULL), N1129_2, 0.0039754627));

N1130_8 :=__common__( map(((real)f_inq_communications_count24_i <= NULL) => 0.00096940702,
               ((real)f_inq_communications_count24_i < 1.5)   => 0.015270731,
                                                                 0.00096940702));

N1130_7 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.010214475,
               ((real)c_easiqlife < 130.5) => 0.0018334138,
                                              0.010214475));

N1130_6 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => N1130_7,
               ((real)r_c13_avg_lres_d < 46.5)  => -0.0020115998,
                                                   N1130_7));

N1130_5 :=__common__( if(((real)f_inq_count24_i < 10.5), N1130_6, N1130_8));

N1130_4 :=__common__( if(((real)f_inq_count24_i > NULL), N1130_5, 0.022049161));

N1130_3 :=__common__( map(trim(C_POP_65_74_P) = ''              => N1130_4,
               ((real)c_pop_65_74_p < 6.05000019073) => -0.00042580929,
                                                        N1130_4));

N1130_2 :=__common__( if(((real)c_pop_35_44_p < 12.25), -0.0016748222, N1130_3));

N1130_1 :=__common__( if(trim(C_POP_35_44_P) != '', N1130_2, 0.00051534598));

N1131_10 :=__common__( map(trim(C_POP_18_24_P) = ''              => 0.0041579975,
                ((real)c_pop_18_24_p < 9.55000019073) => -0.0012485837,
                                                         0.0041579975));

N1131_9 :=__common__( map(trim(C_CIV_EMP) = ''              => -0.0017172897,
               ((real)c_civ_emp < 50.0499992371) => 0.0077397605,
                                                    -0.0017172897));

N1131_8 :=__common__( map(trim(C_LOWRENT) = ''      => -0.0091474916,
               ((real)c_lowrent < 57.75) => N1131_9,
                                            -0.0091474916));

N1131_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0159870814532), -0.0077209984, N1131_8));

N1131_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1131_7, 4.2300404e-005));

N1131_5 :=__common__( map(trim(C_HVAL_40K_P) = ''               => N1131_10,
               ((real)c_hval_40k_p < 0.350000023842) => N1131_6,
                                                        N1131_10));

N1131_4 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1131_5, -0.00030385629));

N1131_3 :=__common__( map(((real)f_mos_liens_unrel_sc_fseen_d <= NULL) => N1131_4,
               ((real)f_mos_liens_unrel_sc_fseen_d < 21.5)  => 0.0062516473,
                                                               N1131_4));

N1131_2 :=__common__( if(trim(C_HH2_P) != '', N1131_3, 0.0027549479));

N1131_1 :=__common__( if(((real)r_c20_email_domain_free_count_i > NULL), N1131_2, 0.010110648));

N1132_8 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => -0.0049510111,
               ((real)f_mos_inq_banko_om_fseen_d < 45.5)  => 0.0078973806,
                                                             -0.0049510111));

N1132_7 :=__common__( map(((real)f_corraddrnamecount_d <= NULL) => N1132_8,
               ((real)f_corraddrnamecount_d < 6.5)   => -0.0037080121,
                                                        N1132_8));

N1132_6 :=__common__( map(((real)r_i60_inq_count12_i <= NULL) => N1132_7,
               ((real)r_i60_inq_count12_i < 1.5)   => 0.002349506,
                                                      N1132_7));

N1132_5 :=__common__( map(trim(C_OLD_HOMES) = ''      => 0.0047353484,
               ((real)c_old_homes < 167.5) => -0.0057479512,
                                              0.0047353484));

N1132_4 :=__common__( map(trim(C_FAMMAR18_P) = ''              => 0.00044948904,
               ((real)c_fammar18_p < 10.0500001907) => N1132_5,
                                                       0.00044948904));

N1132_3 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1132_4, N1132_6));

N1132_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 4.5), 0.0062133125, N1132_3));

N1132_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N1132_2, -0.001585812));

N1133_8 :=__common__( map(trim(C_HVAL_100K_P) = ''              => 0.0093307326,
               ((real)c_hval_100k_p < 9.35000038147) => -0.002316581,
                                                        0.0093307326));

N1133_7 :=__common__( map(((real)r_i60_inq_count12_i <= NULL) => N1133_8,
               ((real)r_i60_inq_count12_i < 2.5)   => -0.0051450242,
                                                      N1133_8));

N1133_6 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => N1133_7,
               ((real)f_curraddrmedianincome_d < 28920.5) => -0.0090810363,
                                                             N1133_7));

N1133_5 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => 0.00028938725,
               ((real)r_d32_mos_since_crim_ls_d < 67.5)  => N1133_6,
                                                            0.00028938725));

N1133_4 :=__common__( if(((real)r_d32_criminal_count_i < 4.5), N1133_5, 0.0020953711));

N1133_3 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N1133_4, 0.0014659935));

N1133_2 :=__common__( if(((real)c_mort_indx < 169.5), N1133_3, -0.0083858585));

N1133_1 :=__common__( if(trim(C_MORT_INDX) != '', N1133_2, -0.0073665105));

N1134_8 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL) => -0.0079314923,
               ((real)f_curraddrcrimeindex_i < 102.5) => 0.0015896007,
                                                         -0.0079314923));

N1134_7 :=__common__( map(((real)f_inq_count24_i <= NULL) => 0.010953218,
               ((real)f_inq_count24_i < 5.5)   => 0.0016815668,
                                                  0.010953218));

N1134_6 :=__common__( if(((real)c_hval_750k_p < 7.85000038147), 0.00024546736, N1134_7));

N1134_5 :=__common__( if(trim(C_HVAL_750K_P) != '', N1134_6, 0.0020781215));

N1134_4 :=__common__( map(((real)r_c13_curr_addr_lres_d <= NULL) => -0.0098818337,
               ((real)r_c13_curr_addr_lres_d < 23.5)  => 0.00067426823,
                                                         -0.0098818337));

N1134_3 :=__common__( map(((real)r_i60_inq_mortgage_recency_d <= NULL)  => N1134_5,
               ((integer)r_i60_inq_mortgage_recency_d < 549) => N1134_4,
                                                                N1134_5));

N1134_2 :=__common__( if(((real)c_addr_lres_12mo_ct_i < 13.5), N1134_3, N1134_8));

N1134_1 :=__common__( if(((real)c_addr_lres_12mo_ct_i > NULL), N1134_2, -0.005798471));

N1135_10 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)     => 0.011375491,
                ((integer)f_prevaddrmedianvalue_d < 115801) => 0.0013386937,
                                                               0.011375491));

N1135_9 :=__common__( if(((real)f_prevaddrcartheftindex_i < 174.5), N1135_10, -0.0034816412));

N1135_8 :=__common__( if(((real)f_prevaddrcartheftindex_i > NULL), N1135_9, 0.0063402807));

N1135_7 :=__common__( map(trim(C_UNATTACH) = ''      => -0.0042900045,
               ((real)c_unattach < 150.5) => 0.0030822954,
                                             -0.0042900045));

N1135_6 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.065496712923), N1135_7, -0.0015863037));

N1135_5 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1135_6, 0.0005179551));

N1135_4 :=__common__( if(((real)f_rel_incomeover25_count_d < 11.5), N1135_5, -0.001463698));

N1135_3 :=__common__( if(((real)f_rel_incomeover25_count_d > NULL), N1135_4, 0.0034435214));

N1135_2 :=__common__( if(((real)f_add_input_mobility_index_n < 0.568374872208), N1135_3, N1135_8));

N1135_1 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1135_2, 0.0086944584));

N1136_10 :=__common__( if(((real)c_unemp < 7.25), -0.00055295238, -0.0086603212));

N1136_9 :=__common__( if(trim(C_UNEMP) != '', N1136_10, -0.032087191));

N1136_8 :=__common__( if(((real)c_famotf18_p < 19.9500007629), 1.7563903e-005, 0.01016369));

N1136_7 :=__common__( if(trim(C_FAMOTF18_P) != '', N1136_8, 0.0037039589));

N1136_6 :=__common__( if(((integer)c_assault < 31), 0.0076202713, 0.0002502751));

N1136_5 :=__common__( if(trim(C_ASSAULT) != '', N1136_6, 0.004175193));

N1136_4 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => N1136_5,
               ((real)r_d32_mos_since_crim_ls_d < 157.5) => -0.0016289149,
                                                            N1136_5));

N1136_3 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => N1136_7,
               ((real)r_c14_addrs_15yr_i < 18.5)  => N1136_4,
                                                     N1136_7));

N1136_2 :=__common__( if(((real)r_c20_email_domain_free_count_i < 4.5), N1136_3, N1136_9));

N1136_1 :=__common__( if(((real)r_c20_email_domain_free_count_i > NULL), N1136_2, 0.0033678446));

N1137_9 :=__common__( map((fp_segment in ['2 NAS 479', '5 Derog', '7 Other'])                               => -0.0023301097,
               (fp_segment in ['1 SSN Prob', '3 New DID', '4 Bureau Only', '6 Recent Activity']) => 0.012640558,
                                                                                                    0.012640558));

N1137_8 :=__common__( map(trim(C_POP_25_34_P) = ''              => N1137_9,
               ((real)c_pop_25_34_p < 12.0500001907) => 0.0075331741,
                                                        N1137_9));

N1137_7 :=__common__( if(((real)f_curraddrmurderindex_i < 122.5), -0.0060539188, N1137_8));

N1137_6 :=__common__( if(((real)f_curraddrmurderindex_i > NULL), N1137_7, 0.024008721));

N1137_5 :=__common__( map(trim(C_LUX_PROD) = ''      => 0.012154729,
               ((real)c_lux_prod < 101.5) => N1137_6,
                                             0.012154729));

N1137_4 :=__common__( if(((integer)f_curraddrmedianincome_d < 13010), -0.0051881822, 0.00053435848));

N1137_3 :=__common__( if(((real)f_curraddrmedianincome_d > NULL), N1137_4, -0.0077881299));

N1137_2 :=__common__( if(((real)c_lowrent < 76.4499969482), N1137_3, N1137_5));

N1137_1 :=__common__( if(trim(C_LOWRENT) != '', N1137_2, -0.0013249122));

N1138_9 :=__common__( map(((real)f_add_curr_nhood_bus_pct_i <= NULL)          => -0.00040531335,
               ((real)f_add_curr_nhood_bus_pct_i < 0.035357106477) => 0.0040840022,
                                                                      -0.00040531335));

N1138_8 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => 0.0094156238,
               ((real)r_c14_addrs_5yr_i < 8.5)   => N1138_9,
                                                    0.0094156238));

N1138_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1138_8, 0.0040963388));

N1138_6 :=__common__( map(trim(C_ROBBERY) = ''       => N1138_7,
               ((integer)c_robbery < 145) => -0.00059000593,
                                             N1138_7));

N1138_5 :=__common__( map(trim(C_HVAL_80K_P) = ''              => -0.0045782546,
               ((real)c_hval_80k_p < 0.15000000596) => 0.0053632188,
                                                       -0.0045782546));

N1138_4 :=__common__( if(((integer)f_fp_prevaddrcrimeindex_i < 99), -0.010489815, N1138_5));

N1138_3 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N1138_4, -0.029766163));

N1138_2 :=__common__( if(((real)c_pop_55_64_p < 4.14999961853), N1138_3, N1138_6));

N1138_1 :=__common__( if(trim(C_POP_55_64_P) != '', N1138_2, 0.0014487526));

N1139_9 :=__common__( if(((real)c_inc_15k_p < 12.8500003815), 0.015558747, 0.0041802823));

N1139_8 :=__common__( if(trim(C_INC_15K_P) != '', N1139_9, 0.015201063));

N1139_7 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => 0.0070494242,
               ((real)f_curraddrmurderindex_i < 146.5) => -0.0033200653,
                                                          0.0070494242));

N1139_6 :=__common__( map(((real)r_i60_inq_banking_recency_d <= NULL)  => N1139_8,
               ((integer)r_i60_inq_banking_recency_d < 549) => N1139_7,
                                                               N1139_8));

N1139_5 :=__common__( map(((real)f_adl_util_inf_n <= NULL) => -0.004840308,
               ((real)f_adl_util_inf_n < 0.5)   => N1139_6,
                                                   -0.004840308));

N1139_4 :=__common__( if(((real)r_c15_ssns_per_adl_i < 2.5), -0.00045116803, N1139_5));

N1139_3 :=__common__( if(((real)r_c15_ssns_per_adl_i > NULL), N1139_4, -0.0015806554));

N1139_2 :=__common__( if(((real)f_bus_lname_verd_d < 0.5), N1139_3, -0.0072819851));

N1139_1 :=__common__( if(((real)f_bus_lname_verd_d > NULL), N1139_2, -0.011717109));

N1140_9 :=__common__( map(trim(C_TOTCRIME) = ''      => -0.0022782533,
               ((real)c_totcrime < 144.5) => 0.0038498879,
                                             -0.0022782533));

N1140_8 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => -0.0054032039,
               ((real)f_m_bureau_adl_fs_all_d < 190.5) => 0.0059297191,
                                                          -0.0054032039));

N1140_7 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i < 158.5), -0.0069908528, N1140_8));

N1140_6 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N1140_7, -0.014013035));

N1140_5 :=__common__( map(((real)f_add_input_nhood_bus_pct_i <= NULL)          => N1140_9,
               ((real)f_add_input_nhood_bus_pct_i < 0.120617866516) => N1140_6,
                                                                       N1140_9));

N1140_4 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0809326246381), 0.00091264384, N1140_5));

N1140_3 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1140_4, 0.0014330198));

N1140_2 :=__common__( if(((real)c_pop_12_17_p < 3.25), 0.0053582173, N1140_3));

N1140_1 :=__common__( if(trim(C_POP_12_17_P) != '', N1140_2, 0.00023213691));

N1141_8 :=__common__( map(trim(C_POP_45_54_P) = ''              => -0.001420766,
               ((real)c_pop_45_54_p < 10.8500003815) => 0.00092894982,
                                                        -0.001420766));

N1141_7 :=__common__( map(((real)c_unique_addr_count_i <= NULL) => -0.0080455282,
               ((real)c_unique_addr_count_i < 23.5)  => N1141_8,
                                                        -0.0080455282));

N1141_6 :=__common__( map(trim(C_HH4_P) = ''      => -0.0052299724,
               ((real)c_hh4_p < 10.25) => 0.0072604968,
                                          -0.0052299724));

N1141_5 :=__common__( map(trim(C_HH5_P) = ''              => 0.0087072246,
               ((real)c_hh5_p < 7.35000038147) => N1141_6,
                                                  0.0087072246));

N1141_4 :=__common__( if(((real)f_mos_liens_unrel_lt_fseen_d < 76.5), N1141_5, N1141_7));

N1141_3 :=__common__( if(((real)f_mos_liens_unrel_lt_fseen_d > NULL), N1141_4, -0.0020960319));

N1141_2 :=__common__( if(((real)c_hh6_p < 11.5500001907), N1141_3, 0.0049975189));

N1141_1 :=__common__( if(trim(C_HH6_P) != '', N1141_2, -0.0012708681));

N1142_8 :=__common__( map(trim(C_RENTAL) = ''      => 0.0063579951,
               ((real)c_rental < 159.5) => -0.0037389456,
                                           0.0063579951));

N1142_7 :=__common__( if(((real)f_prevaddrstatus_i > NULL), N1142_8, 0.010568052));

N1142_6 :=__common__( if(((real)c_civ_emp < 46.0499992371), N1142_7, -0.0015877718));

N1142_5 :=__common__( if(trim(C_CIV_EMP) != '', N1142_6, -0.00016869251));

N1142_4 :=__common__( map(((real)c_addr_lres_2mo_ct_i <= NULL) => -0.010365558,
               ((real)c_addr_lres_2mo_ct_i < 2.5)   => 0.00047133131,
                                                       -0.010365558));

N1142_3 :=__common__( map(((real)f_addrchangeincomediff_d <= NULL)     => 0.0014144652,
               ((integer)f_addrchangeincomediff_d < -42306) => -0.0071514933,
                                                               0.0014144652));

N1142_2 :=__common__( map(((real)f_inq_communications_count24_i <= NULL) => N1142_4,
               ((real)f_inq_communications_count24_i < 3.5)   => N1142_3,
                                                                 N1142_4));

N1142_1 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1142_2, N1142_5));

N1143_9 :=__common__( map(trim(C_POP_25_34_P) = ''              => 0.010547212,
               ((real)c_pop_25_34_p < 14.0500001907) => -0.0014448804,
                                                        0.010547212));

N1143_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0287310034037), -0.0061541994, N1143_9));

N1143_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1143_8, 0.0067157052));

N1143_6 :=__common__( map(((real)f_srchunvrfdaddrcount_i <= NULL) => 0.0046138675,
               ((real)f_srchunvrfdaddrcount_i < 0.5)   => -0.0026685913,
                                                          0.0046138675));

N1143_5 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 39.5), -0.0086935565, N1143_6));

N1143_4 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N1143_5, -0.0051323088));

N1143_3 :=__common__( map(trim(C_FINANCE) = ''              => N1143_7,
               ((real)c_finance < 4.85000038147) => N1143_4,
                                                    N1143_7));

N1143_2 :=__common__( if(((real)c_span_lang < 133.5), 0.0010195357, N1143_3));

N1143_1 :=__common__( if(trim(C_SPAN_LANG) != '', N1143_2, -0.0011173615));

N1144_8 :=__common__( map(trim(C_INC_100K_P) = ''      => -0.0015411835,
               ((real)c_inc_100k_p < 16.25) => -0.011837058,
                                               -0.0015411835));

N1144_7 :=__common__( map(trim(C_MANY_CARS) = ''     => N1144_8,
               ((real)c_many_cars < 75.5) => 0.00035543427,
                                             N1144_8));

N1144_6 :=__common__( map(trim(C_RNT250_P) = ''              => -0.011065351,
               ((real)c_rnt250_p < 12.0500001907) => N1144_7,
                                                     -0.011065351));

N1144_5 :=__common__( if(((real)c_lar_fam < 97.5), -0.00035991012, N1144_6));

N1144_4 :=__common__( if(trim(C_LAR_FAM) != '', N1144_5, 0.012074472));

N1144_3 :=__common__( map(((real)r_phn_cell_n <= NULL) => N1144_4,
               ((real)r_phn_cell_n < 0.5)   => 0.0013190501,
                                               N1144_4));

N1144_2 :=__common__( if(((real)f_m_bureau_adl_fs_all_d < 174.5), N1144_3, 0.00095072198));

N1144_1 :=__common__( if(((real)f_m_bureau_adl_fs_all_d > NULL), N1144_2, -0.0030849751));

N1145_9 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL)  => -0.015189198,
               ((integer)f_prevaddrmurderindex_i < 120) => -0.0045164902,
                                                           -0.015189198));

N1145_8 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.0012028358,
               ((real)f_rel_felony_count_i < 1.5)   => N1145_9,
                                                       0.0012028358));

N1145_7 :=__common__( map(trim(C_RNT750_P) = ''              => N1145_8,
               ((real)c_rnt750_p < 55.8499984741) => -0.00027855494,
                                                     N1145_8));

N1145_6 :=__common__( if(((real)c_rnt1000_p < 10.0500001907), 0.0010624772, N1145_7));

N1145_5 :=__common__( if(trim(C_RNT1000_P) != '', N1145_6, -0.0023002654));

N1145_4 :=__common__( if(((real)c_span_lang < 108.5), -0.0092741809, 0.0013582919));

N1145_3 :=__common__( if(trim(C_SPAN_LANG) != '', N1145_4, -0.015577246));

N1145_2 :=__common__( if(((real)f_mos_liens_unrel_lt_lseen_d < 46.5), N1145_3, N1145_5));

N1145_1 :=__common__( if(((real)f_mos_liens_unrel_lt_lseen_d > NULL), N1145_2, 0.0029819057));

N1146_8 :=__common__( map(((real)r_s66_adlperssn_count_i <= NULL) => 0.011387296,
               ((real)r_s66_adlperssn_count_i < 2.5)   => 0.0022073702,
                                                          0.011387296));

N1146_7 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => -0.00010480455,
               ((real)r_c13_max_lres_d < 43.5)  => N1146_8,
                                                   -0.00010480455));

N1146_6 :=__common__( map(((real)f_inq_communications_count24_i <= NULL) => -0.0059417046,
               ((real)f_inq_communications_count24_i < 4.5)   => N1146_7,
                                                                 -0.0059417046));

N1146_5 :=__common__( map(trim(C_POP_75_84_P) = ''              => -0.0036825726,
               ((real)c_pop_75_84_p < 2.54999995232) => 0.00019970895,
                                                        -0.0036825726));

N1146_4 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => N1146_6,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.700510501862) => N1146_5,
                                                                      N1146_6));

N1146_3 :=__common__( if(((real)r_c13_max_lres_d < 286.5), N1146_4, 0.0070026644));

N1146_2 :=__common__( if(((real)r_c13_max_lres_d > NULL), N1146_3, 0.0019511131));

N1146_1 :=__common__( if(trim(C_LARCENY) != '', N1146_2, -0.00049670132));

N1147_8 :=__common__( map(trim(C_HH3_P) = ''              => -0.0081096022,
               ((real)c_hh3_p < 18.1500015259) => -0.00016932861,
                                                  -0.0081096022));

N1147_7 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => 0.0002333499,
               ((real)f_mos_inq_banko_cm_fseen_d < 76.5)  => N1147_8,
                                                             0.0002333499));

N1147_6 :=__common__( map(trim(C_INC_25K_P) = ''      => 0.0083323213,
               ((real)c_inc_25k_p < 20.25) => -0.00094528493,
                                              0.0083323213));

N1147_5 :=__common__( map(trim(C_NO_LABFOR) = ''     => N1147_6,
               ((real)c_no_labfor < 92.5) => 0.010121083,
                                             N1147_6));

N1147_4 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => N1147_5,
               ((real)f_curraddrmurderindex_i < 181.5) => 0.00032623402,
                                                          N1147_5));

N1147_3 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 70.5), N1147_4, N1147_7));

N1147_2 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N1147_3, 0.00098560335));

N1147_1 :=__common__( if(trim(C_INC_25K_P) != '', N1147_2, -0.0016517852));

N1148_9 :=__common__( if(((real)f_rel_incomeover75_count_d < 0.5), 0.0032171401, -0.0052148264));

N1148_8 :=__common__( if(((real)f_rel_incomeover75_count_d > NULL), N1148_9, -0.0071229612));

N1148_7 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 33.5), 0.0082018881, N1148_8));

N1148_6 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N1148_7, -0.030928746));

N1148_5 :=__common__( map(trim(C_LOWRENT) = ''              => -0.0067963533,
               ((real)c_lowrent < 72.4499969482) => 0.00068009047,
                                                    -0.0067963533));

N1148_4 :=__common__( map(trim(C_HVAL_40K_P) = ''              => 0.0097348639,
               ((real)c_hval_40k_p < 14.3500003815) => N1148_5,
                                                       0.0097348639));

N1148_3 :=__common__( map(trim(C_HVAL_80K_P) = ''              => -0.0017443791,
               ((real)c_hval_80k_p < 8.14999961853) => N1148_4,
                                                       -0.0017443791));

N1148_2 :=__common__( if(((real)c_inc_25k_p < 21.75), N1148_3, N1148_6));

N1148_1 :=__common__( if(trim(C_INC_25K_P) != '', N1148_2, -0.0067597849));

N1149_11 :=__common__( if(((real)f_rel_under25miles_cnt_d < 10.5), -0.0094768933, 0.00079264398));

N1149_10 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N1149_11, -0.0029123561));

N1149_9 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1149_10, -0.005560709));

N1149_8 :=__common__( map(trim(C_POP_45_54_P) = ''              => 0.0028817917,
               ((real)c_pop_45_54_p < 18.3499984741) => N1149_9,
                                                        0.0028817917));

N1149_7 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.0028858159,
               ((real)c_easiqlife < 138.5) => N1149_8,
                                              0.0028858159));

N1149_6 :=__common__( if(((real)c_child < 22.75), N1149_7, 0.0011043402));

N1149_5 :=__common__( if(trim(C_CHILD) != '', N1149_6, 0.0026065736));

N1149_4 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d < 0.961203098297), N1149_5, -0.0026981036));

N1149_3 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d > NULL), N1149_4, -0.031634912));

N1149_2 :=__common__( if(((real)f_srchaddrsrchcountwk_i < 0.5), N1149_3, -0.0058080532));

N1149_1 :=__common__( if(((real)f_srchaddrsrchcountwk_i > NULL), N1149_2, 0.0020483705));

N1150_8 :=__common__( map(trim(C_LOWINC) = ''              => 0.0099532911,
               ((real)c_lowinc < 61.3499984741) => 0.0013091968,
                                                   0.0099532911));

N1150_7 :=__common__( map(trim(C_MED_RENT) = ''      => 1.2474524e-005,
               ((real)c_med_rent < 278.5) => N1150_8,
                                             1.2474524e-005));

N1150_6 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => -0.0063755747,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.214786916971) => 0.0032707001,
                                                                      -0.0063755747));

N1150_5 :=__common__( if(((integer)f_curraddrmedianincome_d < 22846), 0.0021180025, N1150_6));

N1150_4 :=__common__( if(((real)f_curraddrmedianincome_d > NULL), N1150_5, -0.0017458264));

N1150_3 :=__common__( map(trim(C_MANY_CARS) = ''     => N1150_7,
               ((real)c_many_cars < 28.5) => N1150_4,
                                             N1150_7));

N1150_2 :=__common__( if(((real)c_employees < 2.5), 0.0043696965, N1150_3));

N1150_1 :=__common__( if(trim(C_EMPLOYEES) != '', N1150_2, -0.0028539923));

N1151_9 :=__common__( if(((real)f_prevaddrcartheftindex_i < 187.5), -0.0013308768, -0.00748915));

N1151_8 :=__common__( if(((real)f_prevaddrcartheftindex_i > NULL), N1151_9, -0.0075464533));

N1151_7 :=__common__( if(((real)r_i60_credit_seeking_i < 1.5), -0.0012056945, 0.0048721984));

N1151_6 :=__common__( if(((real)r_i60_credit_seeking_i > NULL), N1151_7, -0.015371566));

N1151_5 :=__common__( map(trim(C_POP_45_54_P) = ''              => 0.0048372897,
               ((real)c_pop_45_54_p < 15.6499996185) => -0.0073158984,
                                                        0.0048372897));

N1151_4 :=__common__( map(trim(C_CHILD) = ''              => 0.0035568173,
               ((real)c_child < 22.0499992371) => N1151_5,
                                                  0.0035568173));

N1151_3 :=__common__( map(((real)f_adl_util_conv_n <= NULL) => N1151_6,
               ((real)f_adl_util_conv_n < 0.5)   => N1151_4,
                                                    N1151_6));

N1151_2 :=__common__( if(((real)c_hval_150k_p < 12.9499998093), N1151_3, N1151_8));

N1151_1 :=__common__( if(trim(C_HVAL_150K_P) != '', N1151_2, 0.00036155763));

N1152_9 :=__common__( map(trim(C_HH3_P) = ''              => -0.0069214654,
               ((real)c_hh3_p < 16.4500007629) => 0.0034008772,
                                                  -0.0069214654));

N1152_8 :=__common__( map(trim(C_INCOLLEGE) = ''     => -0.010552917,
               ((real)c_incollege < 5.75) => N1152_9,
                                             -0.010552917));

N1152_7 :=__common__( if(((real)c_low_hval < 50.0499992371), 0.00089514549, N1152_8));

N1152_6 :=__common__( if(trim(C_LOW_HVAL) != '', N1152_7, -0.00014524802));

N1152_5 :=__common__( map(((real)r_l80_inp_avm_autoval_d <= NULL)    => -0.00011914399,
               ((integer)r_l80_inp_avm_autoval_d < 32139) => -0.0060408129,
                                                             -0.00011914399));

N1152_4 :=__common__( if(((real)c_hist_addr_match_i < 4.5), 0.0011606385, 0.011447219));

N1152_3 :=__common__( if(((real)c_hist_addr_match_i > NULL), N1152_4, 0.017698647));

N1152_2 :=__common__( if(((real)r_l80_inp_avm_autoval_d < 22192.5), N1152_3, N1152_5));

N1152_1 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1152_2, N1152_6));

N1153_11 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.243117064238), -0.0078118056, -0.0018585239));

N1153_10 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1153_11, -0.0012168134));

N1153_9 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1153_10, -0.00073815815));

N1153_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.124871961772), N1153_9, 0.003843606));

N1153_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1153_8, -0.0056042272));

N1153_6 :=__common__( map(trim(C_ROBBERY) = ''      => 0.0065458179,
               ((real)c_robbery < 193.5) => 0.00023380719,
                                            0.0065458179));

N1153_5 :=__common__( map(trim(C_POP_12_17_P) = ''              => N1153_6,
               ((real)c_pop_12_17_p < 3.15000009537) => -0.0071047229,
                                                        N1153_6));

N1153_4 :=__common__( if(((real)f_add_input_mobility_index_n < 0.413007080555), N1153_5, N1153_7));

N1153_3 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1153_4, -0.029211501));

N1153_2 :=__common__( if(((real)c_hval_80k_p < 45.8000030518), N1153_3, 0.0050864003));

N1153_1 :=__common__( if(trim(C_HVAL_80K_P) != '', N1153_2, -0.0016568415));

N1154_8 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => -0.0029921776,
               ((real)r_d30_derog_count_i < 5.5)   => 0.0066589298,
                                                      -0.0029921776));

N1154_7 :=__common__( map(((real)r_i60_inq_comm_recency_d <= NULL) => -0.0002890661,
               ((real)r_i60_inq_comm_recency_d < 4.5)   => N1154_8,
                                                           -0.0002890661));

N1154_6 :=__common__( map(trim(C_TOTSALES) = ''        => 0.0016183837,
               ((integer)c_totsales < 6174) => -0.0083292881,
                                               0.0016183837));

N1154_5 :=__common__( map(trim(C_HVAL_80K_P) = ''              => 0.0036114391,
               ((real)c_hval_80k_p < 11.6499996185) => N1154_6,
                                                       0.0036114391));

N1154_4 :=__common__( if(((real)c_blue_empl < 153.5), N1154_5, -0.010303566));

N1154_3 :=__common__( if(trim(C_BLUE_EMPL) != '', N1154_4, -0.0045708204));

N1154_2 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 240.5), N1154_3, N1154_7));

N1154_1 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N1154_2, -0.0065420061));

N1155_9 :=__common__( map(((real)r_a46_curr_avm_autoval_d <= NULL)   => -0.00074928279,
               ((real)r_a46_curr_avm_autoval_d < 52004.5) => 0.0073942904,
                                                             -0.00074928279));

N1155_8 :=__common__( map(trim(C_HH1_P) = ''              => -0.0023330738,
               ((real)c_hh1_p < 23.5499992371) => N1155_9,
                                                  -0.0023330738));

N1155_7 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N1155_8, 0.0010516818));

N1155_6 :=__common__( if(((real)r_f00_input_dob_match_level_d < 5.5), 0.0082907532, N1155_7));

N1155_5 :=__common__( if(((real)r_f00_input_dob_match_level_d > NULL), N1155_6, 0.011184233));

N1155_4 :=__common__( map(trim(C_POP_45_54_P) = ''              => N1155_5,
               ((real)c_pop_45_54_p < 5.05000019073) => -0.0068186988,
                                                        N1155_5));

N1155_3 :=__common__( map(trim(C_BLUE_EMPL) = ''      => 0.0055341737,
               ((real)c_blue_empl < 174.5) => -0.0036277288,
                                              0.0055341737));

N1155_2 :=__common__( if(((real)c_white_col < 18.0499992371), N1155_3, N1155_4));

N1155_1 :=__common__( if(trim(C_WHITE_COL) != '', N1155_2, 0.0034529128));

N1156_9 :=__common__( if(((real)c_inc_125k_p < 0.449999988079), -0.0039732346, 0.0011114577));

N1156_8 :=__common__( if(trim(C_INC_125K_P) != '', N1156_9, -0.0030816699));

N1156_7 :=__common__( map(trim(C_RETIRED2) = ''      => 0.0062400425,
               ((real)c_retired2 < 145.5) => -0.002705627,
                                             0.0062400425));

N1156_6 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)    => 0.009308815,
               ((integer)f_curraddrmedianincome_d < 30097) => -0.0017874745,
                                                              0.009308815));

N1156_5 :=__common__( map(trim(C_HIGHINC) = ''               => N1156_7,
               ((real)c_highinc < 0.850000023842) => N1156_6,
                                                     N1156_7));

N1156_4 :=__common__( if(((real)c_pop_6_11_p < 5.75), -0.0063598465, N1156_5));

N1156_3 :=__common__( if(trim(C_POP_6_11_P) != '', N1156_4, 0.0065425546));

N1156_2 :=__common__( if(((real)r_c13_avg_lres_d < 35.5), N1156_3, N1156_8));

N1156_1 :=__common__( if(((real)r_c13_avg_lres_d > NULL), N1156_2, -0.0061292336));

N1157_8 :=__common__( map(trim(C_BARGAINS) = ''      => 0.0010620769,
               ((real)c_bargains < 140.5) => 0.011287502,
                                             0.0010620769));

N1157_7 :=__common__( map(trim(C_MANY_CARS) = ''     => 0.0013033852,
               ((real)c_many_cars < 46.5) => -0.0030899146,
                                             0.0013033852));

N1157_6 :=__common__( map(trim(C_FAMOTF18_P) = ''              => N1157_8,
               ((real)c_famotf18_p < 48.1500015259) => N1157_7,
                                                       N1157_8));

N1157_5 :=__common__( map(((real)r_phn_cell_n <= NULL) => -0.0013039806,
               ((real)r_phn_cell_n < 0.5)   => N1157_6,
                                               -0.0013039806));

N1157_4 :=__common__( if(((real)f_add_input_mobility_index_n < 0.804908514023), N1157_5, 0.005986979));

N1157_3 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1157_4, -0.028873052));

N1157_2 :=__common__( if(((real)c_food < 86.4499969482), N1157_3, -0.0075058673));

N1157_1 :=__common__( if(trim(C_FOOD) != '', N1157_2, 0.001044267));

N1158_8 :=__common__( map(((real)f_inq_count24_i <= NULL) => -0.0056928853,
               ((real)f_inq_count24_i < 5.5)   => 0.002766546,
                                                  -0.0056928853));

N1158_7 :=__common__( map(trim(C_POP_35_44_P) = ''      => 0.0084490473,
               ((real)c_pop_35_44_p < 12.25) => -0.0013011584,
                                                0.0084490473));

N1158_6 :=__common__( map(trim(C_RNT750_P) = ''              => N1158_7,
               ((real)c_rnt750_p < 15.1499996185) => 0.013194621,
                                                     N1158_7));

N1158_5 :=__common__( map(trim(C_INC_125K_P) = ''              => -0.00079105776,
               ((real)c_inc_125k_p < 7.85000038147) => N1158_6,
                                                       -0.00079105776));

N1158_4 :=__common__( if(((real)c_hh3_p < 19.3499984741), N1158_5, N1158_8));

N1158_3 :=__common__( if(trim(C_HH3_P) != '', N1158_4, 0.00048644213));

N1158_2 :=__common__( if(((real)r_d33_eviction_recency_d < 79.5), N1158_3, -0.00032495804));

N1158_1 :=__common__( if(((real)r_d33_eviction_recency_d > NULL), N1158_2, -0.0052547372));

N1159_8 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => -0.0016977801,
               ((real)f_add_input_nhood_vac_pct_i < 0.0404893942177) => 0.012315823,
                                                                        -0.0016977801));

N1159_7 :=__common__( map(trim(C_PRESCHL) = ''      => 0.0034915745,
               ((real)c_preschl < 165.5) => -0.0056937393,
                                            0.0034915745));

N1159_6 :=__common__( map(trim(C_BORN_USA) = ''      => N1159_8,
               ((real)c_born_usa < 135.5) => N1159_7,
                                             N1159_8));

N1159_5 :=__common__( map(trim(C_PROFESSIONAL) = ''              => 0.0063861555,
               ((real)c_professional < 9.44999980927) => N1159_6,
                                                         0.0063861555));

N1159_4 :=__common__( map(trim(C_LAR_FAM) = ''      => 0.0082531716,
               ((real)c_lar_fam < 155.5) => N1159_5,
                                            0.0082531716));

N1159_3 :=__common__( map(trim(C_HVAL_250K_P) = ''              => N1159_4,
               ((real)c_hval_250k_p < 13.3500003815) => -0.00094236957,
                                                        N1159_4));

N1159_2 :=__common__( if(((real)f_estimated_income_d > NULL), N1159_3, 0.0023260427));

N1159_1 :=__common__( if(trim(C_HVAL_250K_P) != '', N1159_2, -0.0015553459));

N1160_8 :=__common__( map(trim(C_SERV_EMPL) = ''      => 0.010148851,
               ((real)c_serv_empl < 156.5) => 0.0017600605,
                                              0.010148851));

N1160_7 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => 0.00085506026,
               ((real)f_curraddrburglaryindex_i < 85.5)  => -0.002793912,
                                                            0.00085506026));

N1160_6 :=__common__( map(trim(C_HVAL_175K_P) = ''              => N1160_8,
               ((real)c_hval_175k_p < 18.9500007629) => N1160_7,
                                                        N1160_8));

N1160_5 :=__common__( map(trim(C_MED_HVAL) = ''         => -0.0013986104,
               ((integer)c_med_hval < 55732) => -0.0080559418,
                                                -0.0013986104));

N1160_4 :=__common__( if(((real)f_srchaddrsrchcount_i < 2.5), N1160_5, N1160_6));

N1160_3 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N1160_4, -0.0016299567));

N1160_2 :=__common__( if(((real)c_hval_750k_p < 8.14999961853), N1160_3, 0.0040104077));

N1160_1 :=__common__( if(trim(C_HVAL_750K_P) != '', N1160_2, 0.0013765945));

N1161_7 :=__common__( map(trim(C_PRESCHL) = ''      => -0.0074156695,
               ((real)c_preschl < 150.5) => 0.00010590166,
                                            -0.0074156695));

N1161_6 :=__common__( map(trim(C_HH00) = ''      => 0.003160819,
               ((real)c_hh00 < 584.5) => N1161_7,
                                         0.003160819));

N1161_5 :=__common__( map(trim(C_OCCUNIT_P) = ''              => 0.0083205959,
               ((real)c_occunit_p < 94.0500030518) => N1161_6,
                                                      0.0083205959));

N1161_4 :=__common__( map(trim(C_BORN_USA) = ''      => 0.0083884521,
               ((real)c_born_usa < 182.5) => N1161_5,
                                             0.0083884521));

N1161_3 :=__common__( map(trim(C_INC_50K_P) = ''      => N1161_4,
               ((real)c_inc_50k_p < 19.25) => -0.00096501197,
                                              N1161_4));

N1161_2 :=__common__( if(((real)c_inc_75k_p < 31.8499984741), N1161_3, 0.007642902));

N1161_1 :=__common__( if(trim(C_INC_75K_P) != '', N1161_2, 0.00048440813));

N1162_9 :=__common__( map(((real)r_i60_inq_hiriskcred_recency_d <= NULL) => 0.005294945,
               ((real)r_i60_inq_hiriskcred_recency_d < 4.5)   => -0.0044042809,
                                                                 0.005294945));

N1162_8 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)         => N1162_9,
               ((real)f_add_input_nhood_sfd_pct_d < 0.62751698494) => 0.012451596,
                                                                      N1162_9));

N1162_7 :=__common__( map(((real)f_srchfraudsrchcountmo_i <= NULL) => N1162_8,
               ((real)f_srchfraudsrchcountmo_i < 0.5)   => 4.5626223e-005,
                                                           N1162_8));

N1162_6 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1162_7, 0.0014604602));

N1162_5 :=__common__( map(trim(C_NO_LABFOR) = ''      => 0.0045490787,
               ((real)c_no_labfor < 121.5) => -0.0063206288,
                                              0.0045490787));

N1162_4 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)          => N1162_6,
               ((real)f_add_input_nhood_sfd_pct_d < 0.227195680141) => N1162_5,
                                                                       N1162_6));

N1162_3 :=__common__( if(trim(C_FINANCE) != '', N1162_4, -0.0017342578));

N1162_2 :=__common__( if(((real)f_rel_ageover30_count_d < 32.5), N1162_3, -0.0058765342));

N1162_1 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N1162_2, 0.0019222062));

N1163_8 :=__common__( map(trim(C_RICH_FAM) = ''      => -0.0015556796,
               ((real)c_rich_fam < 121.5) => 0.0077119798,
                                             -0.0015556796));

N1163_7 :=__common__( map(trim(C_HVAL_40K_P) = ''      => -0.0068124622,
               ((real)c_hval_40k_p < 35.25) => 1.3175503e-005,
                                               -0.0068124622));

N1163_6 :=__common__( map(trim(C_BLUE_COL) = ''              => N1163_7,
               ((real)c_blue_col < 5.44999980927) => -0.006477089,
                                                     N1163_7));

N1163_5 :=__common__( map(((real)r_i60_inq_mortgage_recency_d <= NULL) => N1163_6,
               ((real)r_i60_inq_mortgage_recency_d < 61.5)  => -0.0091892329,
                                                               N1163_6));

N1163_4 :=__common__( if(((real)f_inq_mortgage_count24_i > NULL), N1163_5, -0.0068458377));

N1163_3 :=__common__( map(trim(C_INC_75K_P) = ''      => 0.0078363839,
               ((real)c_inc_75k_p < 32.25) => N1163_4,
                                              0.0078363839));

N1163_2 :=__common__( if(((real)c_inc_125k_p < 12.1499996185), N1163_3, N1163_8));

N1163_1 :=__common__( if(trim(C_INC_125K_P) != '', N1163_2, -0.0028702823));

N1164_8 :=__common__( map(trim(C_RNT1000_P) = ''     => -0.0094723112,
               ((real)c_rnt1000_p < 3.75) => 0.0015745305,
                                             -0.0094723112));

N1164_7 :=__common__( map(trim(C_UNATTACH) = ''      => 0.0090595228,
               ((real)c_unattach < 153.5) => 0.0018365179,
                                             0.0090595228));

N1164_6 :=__common__( map(trim(C_FAMMAR_P) = ''      => -0.0078719329,
               ((real)c_fammar_p < 86.25) => N1164_7,
                                             -0.0078719329));

N1164_5 :=__common__( map(((real)f_corrrisktype_i <= NULL) => N1164_6,
               ((real)f_corrrisktype_i < 7.5)   => -0.00042341643,
                                                   N1164_6));

N1164_4 :=__common__( if(((real)f_rel_count_i < 41.5), N1164_5, N1164_8));

N1164_3 :=__common__( if(((real)f_rel_count_i > NULL), N1164_4, 0.0069904631));

N1164_2 :=__common__( if(((real)c_hh5_p < 20.0499992371), N1164_3, -0.0059561197));

N1164_1 :=__common__( if(trim(C_HH5_P) != '', N1164_2, -0.0028952685));

N1165_10 :=__common__( if(((real)f_rel_incomeover50_count_d < 11.5), -0.0013649519, 0.0083429975));

N1165_9 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N1165_10, 0.0057866476));

N1165_8 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)     => -0.010206437,
               ((integer)f_curraddrmedianvalue_d < 297267) => N1165_9,
                                                              -0.010206437));

N1165_7 :=__common__( map(((real)f_corraddrphonecount_d <= NULL) => N1165_8,
               ((real)f_corraddrphonecount_d < 0.5)   => 0.0012184785,
                                                         N1165_8));

N1165_6 :=__common__( if(((real)f_rel_ageover40_count_d < 3.5), -0.0091904478, 0.0010836368));

N1165_5 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N1165_6, 0.037543756));

N1165_4 :=__common__( if(trim(C_RETIRED2) != '', N1165_5, -0.0063336907));

N1165_3 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL) => N1165_7,
               ((integer)r_i60_inq_auto_recency_d < 9)  => N1165_4,
                                                           N1165_7));

N1165_2 :=__common__( if(((real)f_mos_liens_unrel_sc_fseen_d < 21.5), 0.0080599569, N1165_3));

N1165_1 :=__common__( if(((real)f_mos_liens_unrel_sc_fseen_d > NULL), N1165_2, -0.0018452844));

N1166_10 :=__common__( map(((real)f_assocrisktype_i <= NULL) => 0.0089848725,
                ((real)f_assocrisktype_i < 5.5)   => -0.00028631512,
                                                     0.0089848725));

N1166_9 :=__common__( if(((real)f_rel_incomeover50_count_d < 7.5), N1166_10, -0.0041433892));

N1166_8 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N1166_9, 0.00030505024));

N1166_7 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.0915237888694), N1166_8, -0.0056762104));

N1166_6 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N1166_7, -0.034659464));

N1166_5 :=__common__( map(((real)c_comb_age_d <= NULL) => 0.0020844825,
               ((real)c_comb_age_d < 41.5)  => 0.015486947,
                                               0.0020844825));

N1166_4 :=__common__( map(((real)r_d31_attr_bankruptcy_recency_d <= NULL) => N1166_5,
               ((real)r_d31_attr_bankruptcy_recency_d < 79.5)  => 0.00060357117,
                                                                  N1166_5));

N1166_3 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 70.5), N1166_4, -0.0010953798));

N1166_2 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N1166_3, -0.0049318469));

N1166_1 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1166_2, N1166_6));

N1167_10 :=__common__( if(((real)c_child < 25.0499992371), 0.0041781885, -0.0059629301));

N1167_9 :=__common__( if(trim(C_CHILD) != '', N1167_10, 0.012175921));

N1167_8 :=__common__( map(((real)f_util_adl_count_n <= NULL) => 0.0044221873,
               ((real)f_util_adl_count_n < 4.5)   => N1167_9,
                                                     0.0044221873));

N1167_7 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => N1167_8,
               ((integer)f_curraddrburglaryindex_i < 49) => 0.009908514,
                                                            N1167_8));

N1167_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.242505341768), -0.00030046503, -0.0065330418));

N1167_5 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1167_6, 0.00014228149));

N1167_4 :=__common__( if(((real)f_rel_educationover12_count_d < 27.5), N1167_5, 0.0055628437));

N1167_3 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N1167_4, -0.00088402771));

N1167_2 :=__common__( if(((real)f_inq_other_count24_i < 2.5), N1167_3, N1167_7));

N1167_1 :=__common__( if(((real)f_inq_other_count24_i > NULL), N1167_2, -0.0047215033));

N1168_11 :=__common__( if(((real)c_retail < 31.5499992371), 0.0018819938, 0.0086661112));

N1168_10 :=__common__( if(trim(C_RETAIL) != '', N1168_11, 0.0095853233));

N1168_9 :=__common__( if(((real)c_famotf18_p < 11.4499998093), 0.0034048578, -0.0018021855));

N1168_8 :=__common__( if(trim(C_FAMOTF18_P) != '', N1168_9, 0.0059162311));

N1168_7 :=__common__( if(((real)c_femdiv_p < 7.05000019073), 0.0011330444, 0.012655923));

N1168_6 :=__common__( if(trim(C_FEMDIV_P) != '', N1168_7, 0.014583404));

N1168_5 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => N1168_8,
               ((real)f_srchaddrsrchcount_i < 0.5)   => N1168_6,
                                                        N1168_8));

N1168_4 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i < 3.5), N1168_5, N1168_10));

N1168_3 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i > NULL), N1168_4, -0.0031132239));

N1168_2 :=__common__( if(((integer)f_fp_prevaddrcrimeindex_i < 61), -0.0017911304, N1168_3));

N1168_1 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N1168_2, -0.0067886504));

N1169_9 :=__common__( map(((real)f_addrchangecrimediff_i <= NULL) => 0.0073981407,
               ((integer)f_addrchangecrimediff_i < -1) => -0.0018738254,
                                                          0.0073981407));

N1169_8 :=__common__( map(trim(C_MIL_EMP) = ''                => -0.0068482227,
               ((real)c_mil_emp < 0.0500000007451) => N1169_9,
                                                      -0.0068482227));

N1169_7 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N1169_8, -0.0037306562));

N1169_6 :=__common__( map(((real)f_wealth_index_d <= NULL) => N1169_7,
               ((real)f_wealth_index_d < 1.5)   => -0.0087095428,
                                                   N1169_7));

N1169_5 :=__common__( map(trim(C_INC_150K_P) = ''              => -0.0054239314,
               ((real)c_inc_150k_p < 9.05000019073) => 0.00050115108,
                                                       -0.0054239314));

N1169_4 :=__common__( map((fp_segment in ['1 SSN Prob', '4 Bureau Only', '5 Derog', '6 Recent Activity', '7 Other']) => N1169_5,
               (fp_segment in ['2 NAS 479', '3 New DID'])                                                 => 0.0097463145,
                                                                                                             N1169_5));

N1169_3 :=__common__( if(((real)c_hist_addr_match_i < 21.5), N1169_4, N1169_6));

N1169_2 :=__common__( if(((real)c_hist_addr_match_i > NULL), N1169_3, -0.0013261187));

N1169_1 :=__common__( if(trim(C_MED_HHINC) != '', N1169_2, -0.00051472672));

N1170_8 :=__common__( map(((real)f_fp_prevaddrcrimeindex_i <= NULL) => 0.011721013,
               ((real)f_fp_prevaddrcrimeindex_i < 165.5) => 0.0020410717,
                                                            0.011721013));

N1170_7 :=__common__( map(trim(C_INC_25K_P) = ''              => 0.00031501087,
               ((real)c_inc_25k_p < 17.6500015259) => -0.010322537,
                                                      0.00031501087));

N1170_6 :=__common__( map(trim(C_INC_35K_P) = ''              => N1170_7,
               ((real)c_inc_35k_p < 10.9499998093) => -0.00012570288,
                                                      N1170_7));

N1170_5 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => N1170_6,
               ((real)f_mos_inq_banko_cm_fseen_d < 42.5)  => 0.0038532285,
                                                             N1170_6));

N1170_4 :=__common__( map(trim(C_TRAILER_P) = ''              => N1170_8,
               ((real)c_trailer_p < 1.15000009537) => N1170_5,
                                                      N1170_8));

N1170_3 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N1170_4, -0.00057388349));

N1170_2 :=__common__( if(((real)c_hval_150k_p < 38.4500007629), N1170_3, 0.0066461773));

N1170_1 :=__common__( if(trim(C_HVAL_150K_P) != '', N1170_2, 0.0010767412));

N1171_9 :=__common__( map(trim(C_ROBBERY) = ''      => 0.00027416991,
               ((integer)c_robbery < 83) => 0.011407657,
                                            0.00027416991));

N1171_8 :=__common__( map(trim(C_BLUE_EMPL) = ''     => N1171_9,
               ((real)c_blue_empl < 65.5) => 0.0118214,
                                             N1171_9));

N1171_7 :=__common__( map(((real)f_inq_communications_count24_i <= NULL) => -0.0029180848,
               ((real)f_inq_communications_count24_i < 1.5)   => 0.0011827014,
                                                                 -0.0029180848));

N1171_6 :=__common__( if(((real)f_corraddrnamecount_d < 6.5), N1171_7, N1171_8));

N1171_5 :=__common__( if(((real)f_corraddrnamecount_d > NULL), N1171_6, -0.0066208973));

N1171_4 :=__common__( if(((real)c_pop_12_17_p < 9.25), -0.00077693258, N1171_5));

N1171_3 :=__common__( if(trim(C_POP_12_17_P) != '', N1171_4, -0.0025224453));

N1171_2 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d < 0.998125553131), N1171_3, -0.0080998979));

N1171_1 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d > NULL), N1171_2, 0.032669507));

N1172_8 :=__common__( map(trim(C_POPOVER18) = ''      => 3.552251e-005,
               ((real)c_popover18 < 568.5) => -0.0053074456,
                                              3.552251e-005));

N1172_7 :=__common__( map(((real)r_i60_inq_hiriskcred_count12_i <= NULL) => -0.0067123875,
               ((real)r_i60_inq_hiriskcred_count12_i < 1.5)   => 0.0011796908,
                                                                 -0.0067123875));

N1172_6 :=__common__( map(trim(C_HVAL_80K_P) = ''              => 0.0072314532,
               ((real)c_hval_80k_p < 30.4500007629) => N1172_7,
                                                       0.0072314532));

N1172_5 :=__common__( map(trim(C_MED_AGE) = ''      => N1172_6,
               ((real)c_med_age < 27.75) => 0.0067098769,
                                            N1172_6));

N1172_4 :=__common__( if(((integer)f_curraddrmedianincome_d < 28930), N1172_5, N1172_8));

N1172_3 :=__common__( if(((real)f_curraddrmedianincome_d > NULL), N1172_4, -0.00051512258));

N1172_2 :=__common__( if(((real)c_pop_55_64_p < 4.14999961853), -0.0032083186, N1172_3));

N1172_1 :=__common__( if(trim(C_POP_55_64_P) != '', N1172_2, 0.0017623444));

N1173_9 :=__common__( map(trim(C_VERY_RICH) = ''      => 0.013488263,
               ((real)c_very_rich < 102.5) => 0.0025311933,
                                              0.013488263));

N1173_8 :=__common__( map(((real)r_i60_inq_banking_recency_d <= NULL) => -0.0030957911,
               ((real)r_i60_inq_banking_recency_d < 61.5)  => 0.0055844414,
                                                              -0.0030957911));

N1173_7 :=__common__( if(((real)c_unique_addr_count_i < 15.5), N1173_8, 0.0074485875));

N1173_6 :=__common__( if(((real)c_unique_addr_count_i > NULL), N1173_7, 0.035543874));

N1173_5 :=__common__( map(trim(C_HH3_P) = ''              => N1173_9,
               ((real)c_hh3_p < 20.3499984741) => N1173_6,
                                                  N1173_9));

N1173_4 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.693741500378), 7.1650823e-005, -0.0082041017));

N1173_3 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1173_4, -0.0033876971));

N1173_2 :=__common__( if(((real)c_work_home < 131.5), N1173_3, N1173_5));

N1173_1 :=__common__( if(trim(C_WORK_HOME) != '', N1173_2, -0.00019518772));

N1174_10 :=__common__( map(trim(C_YOUNG) = ''              => 0.01246403,
                ((real)c_young < 24.0499992371) => 0.00076713108,
                                                   0.01246403));

N1174_9 :=__common__( map(trim(C_BLUE_EMPL) = ''      => 0.0065332382,
               ((real)c_blue_empl < 117.5) => -0.0048216911,
                                              0.0065332382));

N1174_8 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), 3.075272e-005, N1174_9));

N1174_7 :=__common__( map(((real)r_l80_inp_avm_autoval_d <= NULL)   => N1174_8,
               ((real)r_l80_inp_avm_autoval_d < 37520.5) => -0.0046541229,
                                                            N1174_8));

N1174_6 :=__common__( map(trim(C_ASSAULT) = ''      => 0.0051781877,
               ((real)c_assault < 182.5) => N1174_7,
                                            0.0051781877));

N1174_5 :=__common__( if(((real)r_d30_derog_count_i < 12.5), N1174_6, N1174_10));

N1174_4 :=__common__( if(((real)r_d30_derog_count_i > NULL), N1174_5, -0.0088446123));

N1174_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1174_4, -0.00069389423));

N1174_2 :=__common__( if(((real)c_hhsize < 2.01499986649), 0.004651539, N1174_3));

N1174_1 :=__common__( if(trim(C_HHSIZE) != '', N1174_2, 0.0011186751));

N1175_9 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => 0.00048108077,
               ((real)r_c10_m_hdr_fs_d < 187.5) => -0.010278456,
                                                   0.00048108077));

N1175_8 :=__common__( map(trim(C_SFDU_P) = ''      => 0.0023278722,
               ((real)c_sfdu_p < 70.75) => -0.0031779562,
                                           0.0023278722));

N1175_7 :=__common__( map(trim(C_SFDU_P) = ''              => -0.0018950701,
               ((real)c_sfdu_p < 60.6500015259) => 0.0071213772,
                                                   -0.0018950701));

N1175_6 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1175_7, N1175_8));

N1175_5 :=__common__( map(trim(C_RENTOCC_P) = ''              => 0.0014441545,
               ((real)c_rentocc_p < 39.4500007629) => N1175_6,
                                                      0.0014441545));

N1175_4 :=__common__( map(((real)f_rel_homeover50_count_d <= NULL) => N1175_5,
               ((real)f_rel_homeover50_count_d < 2.5)   => 0.004756846,
                                                           N1175_5));

N1175_3 :=__common__( if(((real)c_transport < 19.1500015259), N1175_4, N1175_9));

N1175_2 :=__common__( if(trim(C_TRANSPORT) != '', N1175_3, -0.0038017918));

N1175_1 :=__common__( if(((real)f_crim_rel_under100miles_cnt_i > NULL), N1175_2, 0.0027343493));

N1176_10 :=__common__( if(((integer)f_prevaddrmedianincome_d < 45883), 0.011203729, -0.0008329042));

N1176_9 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N1176_10, -0.031594422));

N1176_8 :=__common__( map(trim(C_WHITE_COL) = ''              => N1176_9,
               ((real)c_white_col < 26.6500015259) => -0.0031434427,
                                                      N1176_9));

N1176_7 :=__common__( map(trim(C_NO_LABFOR) = ''     => N1176_8,
               ((real)c_no_labfor < 63.5) => -0.0066598087,
                                             N1176_8));

N1176_6 :=__common__( if(((real)c_blue_empl < 55.5), 0.0074047584, N1176_7));

N1176_5 :=__common__( if(trim(C_BLUE_EMPL) != '', N1176_6, -0.0011866403));

N1176_4 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.522300004959), -0.00030061893, 0.0052755422));

N1176_3 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1176_4, 0.0030166899));

N1176_2 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.589137077332), N1176_3, -0.0031310595));

N1176_1 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1176_2, N1176_5));

N1177_7 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL) => -0.0026626748,
               ((real)r_d33_eviction_recency_d < 79.5)  => 0.0041763061,
                                                           -0.0026626748));

N1177_6 :=__common__( if(((real)c_newhouse < 18.8499984741), 0.00041739943, 0.004161681));

N1177_5 :=__common__( if(trim(C_NEWHOUSE) != '', N1177_6, 0.0091915101));

N1177_4 :=__common__( map(((real)r_d34_unrel_liens_ct_i <= NULL) => -0.001434831,
               ((real)r_d34_unrel_liens_ct_i < 2.5)   => N1177_5,
                                                         -0.001434831));

N1177_3 :=__common__( if(((integer)r_i60_inq_comm_recency_d < 549), N1177_4, N1177_7));

N1177_2 :=__common__( if(((real)r_i60_inq_comm_recency_d > NULL), N1177_3, 0.00086130295));

N1177_1 :=__common__( map(((real)r_s65_ssn_problem_i <= NULL) => -0.0083468538,
               ((real)r_s65_ssn_problem_i < 0.5)   => N1177_2,
                                                      -0.0083468538));

N1178_9 :=__common__( if(((real)f_rel_under500miles_cnt_d < 7.5), -0.0021875167, 0.0099998713));

N1178_8 :=__common__( if(((real)f_rel_under500miles_cnt_d > NULL), N1178_9, 0.012550917));

N1178_7 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => -0.001337002,
               ((real)r_c10_m_hdr_fs_d < 81.5)  => N1178_8,
                                                   -0.001337002));

N1178_6 :=__common__( if(((real)c_lowrent < 91.8500061035), N1178_7, 0.0067905257));

N1178_5 :=__common__( if(trim(C_LOWRENT) != '', N1178_6, 0.00088911682));

N1178_4 :=__common__( map(((real)f_rel_bankrupt_count_i <= NULL) => -0.00061422484,
               ((real)f_rel_bankrupt_count_i < 1.5)   => 0.0056783539,
                                                         -0.00061422484));

N1178_3 :=__common__( map(((real)f_current_count_d <= NULL) => -0.0002441216,
               ((real)f_current_count_d < 0.5)   => N1178_4,
                                                    -0.0002441216));

N1178_2 :=__common__( if(((real)r_c20_email_domain_free_count_i < 0.5), N1178_3, N1178_5));

N1178_1 :=__common__( if(((real)r_c20_email_domain_free_count_i > NULL), N1178_2, 0.0050645427));

N1179_10 :=__common__( if(((real)f_mos_liens_unrel_ot_lseen_d < 53.5), 0.0073009132, -0.00033309816));

N1179_9 :=__common__( if(((real)f_mos_liens_unrel_ot_lseen_d > NULL), N1179_10, 0.0011118269));

N1179_8 :=__common__( map(trim(C_UNATTACH) = ''      => 0.010336694,
               ((real)c_unattach < 127.5) => 0.0017244824,
                                             0.010336694));

N1179_7 :=__common__( map(((real)r_a49_curr_avm_chg_1yr_pct_i <= NULL)         => N1179_8,
               ((real)r_a49_curr_avm_chg_1yr_pct_i < 71.8000030518) => -0.0058954425,
                                                                       N1179_8));

N1179_6 :=__common__( if(((real)c_bigapt_p < 4.25), N1179_7, -0.0039686163));

N1179_5 :=__common__( if(trim(C_BIGAPT_P) != '', N1179_6, 0.004391016));

N1179_4 :=__common__( if(((real)c_pop_6_11_p < 10.5500001907), -0.0084467104, 0.002700995));

N1179_3 :=__common__( if(trim(C_POP_6_11_P) != '', N1179_4, 0.041864905));

N1179_2 :=__common__( map(((real)f_estimated_income_d <= NULL)    => N1179_5,
               ((integer)f_estimated_income_d < 27500) => N1179_3,
                                                          N1179_5));

N1179_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N1179_2, N1179_9));

N1180_9 :=__common__( map(((real)r_c18_invalid_addrs_per_adl_i <= NULL) => 0.00122943,
               ((real)r_c18_invalid_addrs_per_adl_i < 3.5)   => -0.0062752667,
                                                                0.00122943));

N1180_8 :=__common__( if(((real)c_serv_empl < 177.5), N1180_9, 0.0053207219));

N1180_7 :=__common__( if(trim(C_SERV_EMPL) != '', N1180_8, -0.01625536));

N1180_6 :=__common__( map(trim(C_SFDU_P) = ''              => 0.00071793685,
               ((real)c_sfdu_p < 31.1500015259) => 0.0077685546,
                                                   0.00071793685));

N1180_5 :=__common__( map(trim(C_SERV_EMPL) = ''      => -0.0011306939,
               ((real)c_serv_empl < 127.5) => N1180_6,
                                              -0.0011306939));

N1180_4 :=__common__( if(((real)c_hval_20k_p < 22.3499984741), N1180_5, 0.0056606458));

N1180_3 :=__common__( if(trim(C_HVAL_20K_P) != '', N1180_4, 0.0033191107));

N1180_2 :=__common__( if(((real)r_c20_email_count_i < 5.5), N1180_3, N1180_7));

N1180_1 :=__common__( if(((real)r_c20_email_count_i > NULL), N1180_2, -0.00041687577));

N1181_8 :=__common__( map(trim(C_POP_25_34_P) = ''              => -0.0012135854,
               ((real)c_pop_25_34_p < 8.05000019073) => 0.0026936469,
                                                        -0.0012135854));

N1181_7 :=__common__( map(trim(C_HVAL_300K_P) = ''              => 0.0017520398,
               ((real)c_hval_300k_p < 4.05000019073) => N1181_8,
                                                        0.0017520398));

N1181_6 :=__common__( map(((real)c_dist_input_to_prev_addr_i <= NULL) => 0.00035383486,
               ((real)c_dist_input_to_prev_addr_i < 3.5)   => 0.0096749213,
                                                              0.00035383486));

N1181_5 :=__common__( map(trim(C_POP_55_64_P) = ''              => N1181_7,
               ((real)c_pop_55_64_p < 3.15000009537) => N1181_6,
                                                        N1181_7));

N1181_4 :=__common__( if(((real)c_cult_indx < 147.5), N1181_5, -0.00733533));

N1181_3 :=__common__( if(trim(C_CULT_INDX) != '', N1181_4, -0.0047232967));

N1181_2 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i < 197.5), N1181_3, 0.0057424697));

N1181_1 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N1181_2, -0.0060798095));

N1182_8 :=__common__( if(((real)c_rentocc_p < 29.4500007629), -0.0021935368, 0.0076273372));

N1182_7 :=__common__( if(trim(C_RENTOCC_P) != '', N1182_8, 0.02548295));

N1182_6 :=__common__( if(((real)c_bel_edu < 112.5), -0.002565885, 0.0065440921));

N1182_5 :=__common__( if(trim(C_BEL_EDU) != '', N1182_6, -0.0083416998));

N1182_4 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => N1182_5,
               ((real)f_inq_adls_per_phone_i < 1.5)   => -0.00086480215,
                                                         N1182_5));

N1182_3 :=__common__( if(((real)f_inq_collection_count24_i < 2.5), N1182_4, N1182_7));

N1182_2 :=__common__( if(((real)f_inq_collection_count24_i > NULL), N1182_3, -0.0029376719));

N1182_1 :=__common__( map(((real)c_nap_contradictory_i <= NULL) => 0.0071081533,
               ((real)c_nap_contradictory_i < 0.5)   => N1182_2,
                                                        0.0071081533));

N1183_10 :=__common__( if(((real)c_preschl < 175.5), -0.00035609741, 0.0034933264));

N1183_9 :=__common__( if(trim(C_PRESCHL) != '', N1183_10, -0.0010471225));

N1183_8 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), -9.9514072e-005, N1183_9));

N1183_7 :=__common__( map(trim(C_SFDU_P) = ''              => -0.0065866059,
               ((real)c_sfdu_p < 77.5500030518) => 0.0073654176,
                                                   -0.0065866059));

N1183_6 :=__common__( if(((real)c_highinc < 2.54999995232), -0.0066784409, N1183_7));

N1183_5 :=__common__( if(trim(C_HIGHINC) != '', N1183_6, 0.0066903859));

N1183_4 :=__common__( map(((real)c_dist_input_to_prev_addr_i <= NULL) => -0.010366356,
               ((real)c_dist_input_to_prev_addr_i < 23.5)  => N1183_5,
                                                              -0.010366356));

N1183_3 :=__common__( map(((real)r_d32_mos_since_fel_ls_d <= NULL) => N1183_8,
               ((real)r_d32_mos_since_fel_ls_d < 240.5) => N1183_4,
                                                           N1183_8));

N1183_2 :=__common__( if(((real)f_srchphonesrchcountwk_i < 0.5), N1183_3, 0.0080783865));

N1183_1 :=__common__( if(((real)f_srchphonesrchcountwk_i > NULL), N1183_2, 0.003422904));

N1184_7 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)        => 0.011471832,
               ((real)f_add_input_nhood_sfd_pct_d < 0.6861525774) => 0.0041219884,
                                                                     0.011471832));

N1184_6 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => -0.00088561747,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.854415595531) => N1184_7,
                                                                      -0.00088561747));

N1184_5 :=__common__( map(trim(C_HVAL_175K_P) = ''              => -0.0019551585,
               ((real)c_hval_175k_p < 13.1499996185) => N1184_6,
                                                        -0.0019551585));

N1184_4 :=__common__( map(trim(C_UNATTACH) = ''      => N1184_5,
               ((real)c_unattach < 142.5) => 0.00012045145,
                                             N1184_5));

N1184_3 :=__common__( map(trim(C_FOR_SALE) = ''      => -0.0061441475,
               ((real)c_for_sale < 196.5) => N1184_4,
                                             -0.0061441475));

N1184_2 :=__common__( if(((real)c_inc_50k_p < 4.44999980927), -0.0061999202, N1184_3));

N1184_1 :=__common__( if(trim(C_INC_50K_P) != '', N1184_2, 0.001407416));

N1185_9 :=__common__( map(((real)r_d31_attr_bankruptcy_recency_d <= NULL) => 0.0045924243,
               ((integer)r_d31_attr_bankruptcy_recency_d < 9)  => -0.0045497694,
                                                                  0.0045924243));

N1185_8 :=__common__( if(((real)f_rel_incomeover50_count_d < 3.5), N1185_9, 0.0020178144));

N1185_7 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N1185_8, -0.0036744127));

N1185_6 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => 0.0067460399,
               ((real)f_add_curr_nhood_vac_pct_i < 0.340732991695) => N1185_7,
                                                                      0.0067460399));

N1185_5 :=__common__( map(trim(C_MORT_INDX) = ''      => 0.0072274121,
               ((real)c_mort_indx < 141.5) => N1185_6,
                                              0.0072274121));

N1185_4 :=__common__( if(((real)f_addrchangeecontrajindex_d < 1.5), N1185_5, -0.0046885763));

N1185_3 :=__common__( if(((real)f_addrchangeecontrajindex_d > NULL), N1185_4, 0.012322124));

N1185_2 :=__common__( if(((real)c_hval_175k_p < 1.84999990463), N1185_3, 0.0007463016));

N1185_1 :=__common__( if(trim(C_HVAL_175K_P) != '', N1185_2, 0.0012194284));

N1186_8 :=__common__( map(trim(C_FEMDIV_P) = ''              => 0.0014051124,
               ((real)c_femdiv_p < 4.05000019073) => 0.012103645,
                                                     0.0014051124));

N1186_7 :=__common__( map(trim(C_HIGHINC) = ''     => -0.0035781326,
               ((real)c_highinc < 1.75) => 0.0050003569,
                                           -0.0035781326));

N1186_6 :=__common__( map(trim(C_HVAL_150K_P) = ''              => -0.0089486356,
               ((real)c_hval_150k_p < 9.05000019073) => N1186_7,
                                                        -0.0089486356));

N1186_5 :=__common__( map(trim(C_HVAL_60K_P) = ''              => N1186_6,
               ((real)c_hval_60k_p < 8.14999961853) => 0.0011557095,
                                                       N1186_6));

N1186_4 :=__common__( if(((real)c_hval_60k_p < 22.3499984741), N1186_5, N1186_8));

N1186_3 :=__common__( if(trim(C_HVAL_60K_P) != '', N1186_4, 0.0037530893));

N1186_2 :=__common__( if(((real)r_c14_addrs_10yr_i < 6.5), -0.0014090561, N1186_3));

N1186_1 :=__common__( if(((real)r_c14_addrs_10yr_i > NULL), N1186_2, -0.0016165691));

N1187_9 :=__common__( if(((real)f_curraddrcrimeindex_i < 197.5), 0.00018268513, -0.0077186405));

N1187_8 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N1187_9, 0.022286634));

N1187_7 :=__common__( map(trim(C_HH4_P) = ''      => 0.0079962636,
               ((real)c_hh4_p < 22.25) => N1187_8,
                                          0.0079962636));

N1187_6 :=__common__( map(trim(C_RAPE) = ''      => N1187_7,
               ((integer)c_rape < 91) => 0.0041109428,
                                         N1187_7));

N1187_5 :=__common__( map(trim(C_ROBBERY) = ''     => 0.00031861141,
               ((real)c_robbery < 74.5) => -0.0049894714,
                                           0.00031861141));

N1187_4 :=__common__( map(((real)f_srchvelocityrisktype_i <= NULL) => 0.0010500242,
               ((real)f_srchvelocityrisktype_i < 5.5)   => -0.0067128229,
                                                           0.0010500242));

N1187_3 :=__common__( if(((real)r_pb_order_freq_d > NULL), N1187_4, N1187_5));

N1187_2 :=__common__( if(((real)c_hh1_p < 27.0499992371), N1187_3, N1187_6));

N1187_1 :=__common__( if(trim(C_HH1_P) != '', N1187_2, 0.0030437299));

N1188_9 :=__common__( map(((real)f_estimated_income_d <= NULL)    => 0.0014291317,
               ((integer)f_estimated_income_d < 41500) => -0.011039537,
                                                          0.0014291317));

N1188_8 :=__common__( map(trim(C_POP_45_54_P) = ''              => 0.0022697329,
               ((real)c_pop_45_54_p < 8.05000019073) => -0.0028650048,
                                                        0.0022697329));

N1188_7 :=__common__( map(trim(C_POP_12_17_P) = ''              => 0.0089139088,
               ((real)c_pop_12_17_p < 16.1500015259) => N1188_8,
                                                        0.0089139088));

N1188_6 :=__common__( map(trim(C_HVAL_300K_P) = ''      => N1188_9,
               ((real)c_hval_300k_p < 12.25) => N1188_7,
                                                N1188_9));

N1188_5 :=__common__( if(((integer)f_prevaddrmedianincome_d < 39633), N1188_6, -0.00062583845));

N1188_4 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N1188_5, 0.0042295608));

N1188_3 :=__common__( if(trim(C_MANY_CARS) != '', N1188_4, 0.0026677558));

N1188_2 :=__common__( if(((real)r_l70_add_standardized_i < 1.5), N1188_3, -0.0053360342));

N1188_1 :=__common__( if(((real)r_l70_add_standardized_i > NULL), N1188_2, 0.030339917));

N1189_10 :=__common__( if(((real)c_construction < 4.94999980927), -0.004311089, 0.0044014228));

N1189_9 :=__common__( if(trim(C_CONSTRUCTION) != '', N1189_10, 0.039735624));

N1189_8 :=__common__( map(((real)f_util_adl_count_n <= NULL) => N1189_9,
               ((real)f_util_adl_count_n < 2.5)   => -0.0086026748,
                                                     N1189_9));

N1189_7 :=__common__( if(((real)r_c13_curr_addr_lres_d < 114.5), -4.1634027e-005, 0.0040715191));

N1189_6 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1189_7, -0.031843898));

N1189_5 :=__common__( map(trim(C_BLUE_COL) = ''              => -0.0087474942,
               ((real)c_blue_col < 24.0499992371) => N1189_6,
                                                     -0.0087474942));

N1189_4 :=__common__( if(((real)c_blue_empl < 192.5), N1189_5, 0.0066092161));

N1189_3 :=__common__( if(trim(C_BLUE_EMPL) != '', N1189_4, -0.0010334352));

N1189_2 :=__common__( if(((real)f_srchphonesrchcount_i < 7.5), N1189_3, N1189_8));

N1189_1 :=__common__( if(((real)f_srchphonesrchcount_i > NULL), N1189_2, 0.00023335733));

N1190_8 :=__common__( map(trim(C_LOW_HVAL) = ''              => 0.0087237101,
               ((real)c_low_hval < 1.45000004768) => -0.0033537334,
                                                     0.0087237101));

N1190_7 :=__common__( map(trim(C_RETIRED2) = ''     => -0.00065336836,
               ((real)c_retired2 < 80.5) => -0.011046707,
                                            -0.00065336836));

N1190_6 :=__common__( map(trim(C_MANUFACTURING) = ''              => -0.0036271955,
               ((real)c_manufacturing < 12.4499998093) => 7.1335176e-005,
                                                          -0.0036271955));

N1190_5 :=__common__( map(trim(C_POP_18_24_P) = ''              => 0.0062731825,
               ((real)c_pop_18_24_p < 25.6500015259) => N1190_6,
                                                        0.0062731825));

N1190_4 :=__common__( if(((real)c_addr_lres_6mo_ct_i < 10.5), N1190_5, N1190_7));

N1190_3 :=__common__( if(((real)c_addr_lres_6mo_ct_i > NULL), N1190_4, -0.00076342923));

N1190_2 :=__common__( if(((real)c_hval_1001k_p < 2.45000004768), N1190_3, N1190_8));

N1190_1 :=__common__( if(trim(C_HVAL_1001K_P) != '', N1190_2, -0.0013439306));

N1191_8 :=__common__( map(trim(C_HIGH_ED) = ''              => 0.001427905,
               ((real)c_high_ed < 13.6499996185) => -0.010046135,
                                                    0.001427905));

N1191_7 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL) => 0.0044295338,
               ((real)f_curraddrcrimeindex_i < 127.5) => N1191_8,
                                                         0.0044295338));

N1191_6 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => N1191_7,
               ((real)f_add_input_mobility_index_n < 0.278511285782) => 0.0078311431,
                                                                        N1191_7));

N1191_5 :=__common__( if(trim(C_RETIRED) != '', N1191_6, -0.0050125289));

N1191_4 :=__common__( map(((real)f_assoccredbureaucount_i <= NULL) => N1191_5,
               ((real)f_assoccredbureaucount_i < 3.5)   => -0.00034362098,
                                                           N1191_5));

N1191_3 :=__common__( map((segment in ['KMART', 'SEARS SHO'])                => 0.0014421878,
               (segment in ['RETAIL', 'SEARS AUTO', 'SEARS FLS']) => 0.013916561,
                                                                     0.013916561));

N1191_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 5.5), N1191_3, N1191_4));

N1191_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N1191_2, -0.006559184));

N1192_8 :=__common__( map(trim(C_POP_45_54_P) = ''              => -0.00042176701,
               ((real)c_pop_45_54_p < 10.8500003815) => 0.0079910056,
                                                        -0.00042176701));

N1192_7 :=__common__( map(trim(C_POP_65_74_P) = ''              => -0.0065883966,
               ((real)c_pop_65_74_p < 7.64999961853) => N1192_8,
                                                        -0.0065883966));

N1192_6 :=__common__( map(trim(C_HH00) = ''      => N1192_7,
               ((real)c_hh00 < 375.5) => -0.0067841747,
                                         N1192_7));

N1192_5 :=__common__( if(((real)c_hval_20k_p < 7.55000019073), 0.00060571104, N1192_6));

N1192_4 :=__common__( if(trim(C_HVAL_20K_P) != '', N1192_5, -0.0015335612));

N1192_3 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL) => N1192_4,
               ((real)r_a50_pb_total_dollars_d < 21.5)  => -0.003974659,
                                                           N1192_4));

N1192_2 :=__common__( if(((real)f_liens_unrel_cj_total_amt_i < 14126.5), N1192_3, 0.008139032));

N1192_1 :=__common__( if(((real)f_liens_unrel_cj_total_amt_i > NULL), N1192_2, 0.0076709546));

N1193_9 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => 0.0076980797,
               ((real)f_curraddrmedianincome_d < 57642.5) => -0.0010267811,
                                                             0.0076980797));

N1193_8 :=__common__( map(trim(C_INC_50K_P) = ''              => -0.0065811794,
               ((real)c_inc_50k_p < 17.9500007629) => N1193_9,
                                                      -0.0065811794));

N1193_7 :=__common__( if(((real)f_prevaddrcartheftindex_i < 176.5), N1193_8, -0.0086058888));

N1193_6 :=__common__( if(((real)f_prevaddrcartheftindex_i > NULL), N1193_7, -0.019881333));

N1193_5 :=__common__( map(trim(C_RNT500_P) = ''              => -0.0044760207,
               ((real)c_rnt500_p < 57.0499992371) => 0.0033027822,
                                                     -0.0044760207));

N1193_4 :=__common__( if(((real)f_corrssnaddrcount_d < 2.5), N1193_5, -0.000145134));

N1193_3 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N1193_4, 0.00054027548));

N1193_2 :=__common__( if(((real)c_hh2_p < 39.3499984741), N1193_3, N1193_6));

N1193_1 :=__common__( if(trim(C_HH2_P) != '', N1193_2, -0.00018164268));

N1194_9 :=__common__( map(trim(C_CARTHEFT) = ''      => 0.0002410069,
               ((real)c_cartheft < 163.5) => -0.01029935,
                                             0.0002410069));

N1194_8 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => 0.0084240318,
               ((real)f_srchfraudsrchcount_i < 17.5)  => 0.00095121232,
                                                         0.0084240318));

N1194_7 :=__common__( map(((real)r_d34_unrel_liens_ct_i <= NULL) => -0.0004051573,
               ((real)r_d34_unrel_liens_ct_i < 0.5)   => N1194_8,
                                                         -0.0004051573));

N1194_6 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1194_7, -0.0025470796));

N1194_5 :=__common__( map(trim(C_CPIALL) = ''              => -0.0080249208,
               ((real)c_cpiall < 225.450012207) => N1194_6,
                                                   -0.0080249208));

N1194_4 :=__common__( if(((real)f_srchssnsrchcountmo_i < 1.5), N1194_5, -0.0058943737));

N1194_3 :=__common__( if(((real)f_srchssnsrchcountmo_i > NULL), N1194_4, -0.0028024243));

N1194_2 :=__common__( if(((real)c_pop_12_17_p < 16.0499992371), N1194_3, N1194_9));

N1194_1 :=__common__( if(trim(C_POP_12_17_P) != '', N1194_2, 0.0030090752));

N1195_8 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => 0.00029677543,
               ((real)f_srchaddrsrchcount_i < 13.5)  => -0.0074705902,
                                                        0.00029677543));

N1195_7 :=__common__( map(trim(C_RNT500_P) = ''              => 0.0072017818,
               ((real)c_rnt500_p < 22.4500007629) => -0.0040598898,
                                                     0.0072017818));

N1195_6 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => N1195_8,
               ((real)r_a50_pb_average_dollars_d < 66.5)  => N1195_7,
                                                             N1195_8));

N1195_5 :=__common__( map(trim(C_MED_HVAL) = ''          => 0.0058435738,
               ((integer)c_med_hval < 208518) => N1195_6,
                                                 0.0058435738));

N1195_4 :=__common__( if(((real)f_prevaddrstatus_i > NULL), N1195_5, -0.0098550679));

N1195_3 :=__common__( if(((real)f_divrisktype_i < 2.5), 0.00062263667, N1195_4));

N1195_2 :=__common__( if(((real)f_divrisktype_i > NULL), N1195_3, 0.0037128771));

N1195_1 :=__common__( if(trim(C_HIGH_HVAL) != '', N1195_2, -0.002909761));

N1196_9 :=__common__( map(trim(C_WHITE_COL) = ''              => 0.0013375044,
               ((real)c_white_col < 17.8499984741) => -0.0033057075,
                                                      0.0013375044));

N1196_8 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => N1196_9,
               ((integer)f_curraddrcartheftindex_i < 46) => -0.0064214642,
                                                            N1196_9));

N1196_7 :=__common__( if(((integer)f_addrchangevaluediff_d < -116393), -0.0069446958, N1196_8));

N1196_6 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1196_7, -0.00086091385));

N1196_5 :=__common__( map(trim(C_POP_45_54_P) = ''              => -0.0060895508,
               ((real)c_pop_45_54_p < 22.1500015259) => N1196_6,
                                                        -0.0060895508));

N1196_4 :=__common__( if(((real)c_rnt1250_p < 10.3500003815), N1196_5, 0.0019535962));

N1196_3 :=__common__( if(trim(C_RNT1250_P) != '', N1196_4, 0.0042141093));

N1196_2 :=__common__( if(((real)f_inq_banking_count24_i < 3.5), N1196_3, 0.007178179));

N1196_1 :=__common__( if(((real)f_inq_banking_count24_i > NULL), N1196_2, 0.0022922054));

N1197_8 :=__common__( map(trim(C_UNATTACH) = ''      => -0.011270535,
               ((real)c_unattach < 144.5) => -0.002842921,
                                             -0.011270535));

N1197_7 :=__common__( map(trim(C_ASSAULT) = ''      => 0.0061555183,
               ((integer)c_assault < 90) => -0.0057372606,
                                            0.0061555183));

N1197_6 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => N1197_8,
               ((real)f_m_bureau_adl_fs_all_d < 59.5)  => N1197_7,
                                                          N1197_8));

N1197_5 :=__common__( if(((real)f_m_bureau_adl_fs_all_d < 130.5), N1197_6, 0.0011988285));

N1197_4 :=__common__( if(((real)f_m_bureau_adl_fs_all_d > NULL), N1197_5, 0.0075620297));

N1197_3 :=__common__( map(trim(C_HVAL_150K_P) = ''      => 0.0054268559,
               ((real)c_hval_150k_p < 10.25) => N1197_4,
                                                0.0054268559));

N1197_2 :=__common__( if(((real)c_hval_150k_p < 13.4499998093), N1197_3, -0.0016874566));

N1197_1 :=__common__( if(trim(C_HVAL_150K_P) != '', N1197_2, -0.00089858956));

N1198_9 :=__common__( map(trim(C_FAMMAR_P) = ''              => 0.002420362,
               ((real)c_fammar_p < 63.3499984741) => -0.0032089171,
                                                     0.002420362));

N1198_8 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 70.5), 0.0037841646, N1198_9));

N1198_7 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N1198_8, 0.0072772913));

N1198_6 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => 0.00088459574,
               ((real)f_add_input_mobility_index_n < 0.327830046415) => 0.010022478,
                                                                        0.00088459574));

N1198_5 :=__common__( if(((real)f_prevaddrmedianincome_d < 53929.5), N1198_6, -0.0036167238));

N1198_4 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N1198_5, -0.00037394334));

N1198_3 :=__common__( map(trim(C_LAR_FAM) = ''      => N1198_4,
               ((real)c_lar_fam < 155.5) => -0.00088564559,
                                            N1198_4));

N1198_2 :=__common__( if(((real)c_hval_150k_p < 10.4499998093), N1198_3, N1198_7));

N1198_1 :=__common__( if(trim(C_HVAL_150K_P) != '', N1198_2, -0.0029805854));

N1199_9 :=__common__( map(trim(C_LOW_ED) = ''              => 0.0037822538,
               ((real)c_low_ed < 80.4499969482) => 0.012958839,
                                                   0.0037822538));

N1199_8 :=__common__( map(trim(C_UNATTACH) = ''      => N1199_9,
               ((real)c_unattach < 103.5) => -0.000446615,
                                             N1199_9));

N1199_7 :=__common__( if(((real)f_srchunvrfdphonecount_i < 1.5), N1199_8, -0.0030770304));

N1199_6 :=__common__( if(((real)f_srchunvrfdphonecount_i > NULL), N1199_7, 0.0034416914));

N1199_5 :=__common__( if(((real)f_srchvelocityrisktype_i < 2.5), -0.0038169634, 0.0059228098));

N1199_4 :=__common__( if(((real)f_srchvelocityrisktype_i > NULL), N1199_5, -0.031035591));

N1199_3 :=__common__( map(trim(C_INC_15K_P) = ''              => -0.00076635977,
               ((real)c_inc_15k_p < 3.84999990463) => N1199_4,
                                                      -0.00076635977));

N1199_2 :=__common__( if(((real)c_low_ed < 76.5500030518), N1199_3, N1199_6));

N1199_1 :=__common__( if(trim(C_LOW_ED) != '', N1199_2, 0.0012821817));

N1200_9 :=__common__( map(trim(C_POP_0_5_P) = ''              => -0.0019999688,
               ((real)c_pop_0_5_p < 8.85000038147) => -0.010616574,
                                                      -0.0019999688));

N1200_8 :=__common__( map(trim(C_RELIG_INDX) = ''      => -0.0031006,
               ((real)c_relig_indx < 156.5) => 0.0034047165,
                                               -0.0031006));

N1200_7 :=__common__( map(trim(C_RENTOCC_P) = ''      => -0.0036002266,
               ((real)c_rentocc_p < 53.25) => N1200_8,
                                              -0.0036002266));

N1200_6 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 11.5), N1200_7, -0.0072132791));

N1200_5 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N1200_6, -0.021770686));

N1200_4 :=__common__( if(((real)c_hh7p_p < 2.75), N1200_5, N1200_9));

N1200_3 :=__common__( if(trim(C_HH7P_P) != '', N1200_4, -0.014712163));

N1200_2 :=__common__( if(((real)f_current_count_d < 1.5), 0.00063892177, N1200_3));

N1200_1 :=__common__( if(((real)f_current_count_d > NULL), N1200_2, 0.0058243181));

N1201_8 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL)  => -0.0083040467,
               ((integer)f_curraddrmurderindex_i < 108) => 0.0032718005,
                                                           -0.0083040467));

N1201_7 :=__common__( if(((integer)f_fp_prevaddrcrimeindex_i < 116), N1201_8, 0.0098814534));

N1201_6 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N1201_7, -0.0018865609));

N1201_5 :=__common__( map(trim(C_SFDU_P) = ''              => 9.2953233e-005,
               ((real)c_sfdu_p < 46.9500007629) => -0.002741161,
                                                   9.2953233e-005));

N1201_4 :=__common__( map(trim(C_POP_45_54_P) = ''              => -0.0058392949,
               ((real)c_pop_45_54_p < 22.3499984741) => N1201_5,
                                                        -0.0058392949));

N1201_3 :=__common__( map(trim(C_INCOLLEGE) = ''              => 0.0049004912,
               ((real)c_incollege < 14.0500001907) => N1201_4,
                                                      0.0049004912));

N1201_2 :=__common__( if(((real)c_rnt1500_p < 8.05000019073), N1201_3, N1201_6));

N1201_1 :=__common__( if(trim(C_RNT1500_P) != '', N1201_2, 0.0021655926));

N1202_8 :=__common__( map(trim(C_RETAIL) = ''              => -0.0097732264,
               ((real)c_retail < 5.35000038147) => 0.00011808946,
                                                   -0.0097732264));

N1202_7 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.011825714,
               ((real)c_comb_age_d < 47.5)  => -0.0010526308,
                                               -0.011825714));

N1202_6 :=__common__( map(((real)r_c18_invalid_addrs_per_adl_i <= NULL) => -0.0066061572,
               ((real)r_c18_invalid_addrs_per_adl_i < 7.5)   => 0.00082976774,
                                                                -0.0066061572));

N1202_5 :=__common__( map(((real)f_vardobcount_i <= NULL) => N1202_7,
               ((real)f_vardobcount_i < 2.5)   => N1202_6,
                                                  N1202_7));

N1202_4 :=__common__( if(((real)f_curraddrcrimeindex_i < 196.5), N1202_5, N1202_8));

N1202_3 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N1202_4, 0.0047576361));

N1202_2 :=__common__( if(((real)c_inc_100k_p < 1.65000009537), 0.0058218577, N1202_3));

N1202_1 :=__common__( if(trim(C_INC_100K_P) != '', N1202_2, 0.0011821941));

N1203_8 :=__common__( if(((integer)f_addrchangeincomediff_d < 8516), 0.0071313427, -0.0035219962));

N1203_7 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1203_8, 0.0019098533));

N1203_6 :=__common__( map(trim(C_HVAL_400K_P) = ''      => -0.0085827629,
               ((real)c_hval_400k_p < 14.25) => -6.380796e-005,
                                                -0.0085827629));

N1203_5 :=__common__( map(trim(C_HVAL_300K_P) = ''     => N1203_7,
               ((real)c_hval_300k_p < 4.75) => N1203_6,
                                               N1203_7));

N1203_4 :=__common__( map(trim(C_HVAL_1001K_P) = ''               => -0.0066344526,
               ((real)c_hval_1001k_p < 0.449999988079) => -0.00034699356,
                                                          -0.0066344526));

N1203_3 :=__common__( map(trim(C_LOW_ED) = ''              => -0.0073606748,
               ((real)c_low_ed < 58.1500015259) => N1203_4,
                                                   -0.0073606748));

N1203_2 :=__common__( if(((real)c_bel_edu < 112.5), N1203_3, N1203_5));

N1203_1 :=__common__( if(trim(C_BEL_EDU) != '', N1203_2, -0.0012138357));

N1204_10 :=__common__( if(((real)r_a50_pb_total_dollars_d < 304.5), 0.0058177507, -0.0048319705));

N1204_9 :=__common__( if(((real)r_a50_pb_total_dollars_d > NULL), N1204_10, -0.004088822));

N1204_8 :=__common__( map(trim(C_PRESCHL) = ''      => 0.0086433535,
               ((real)c_preschl < 158.5) => N1204_9,
                                            0.0086433535));

N1204_7 :=__common__( if(((integer)r_a46_curr_avm_autoval_d < 26475), 0.0084948272, -0.002537828));

N1204_6 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N1204_7, N1204_8));

N1204_5 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i < 5308.5), -0.00086426141, 0.0065634247));

N1204_4 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i > NULL), N1204_5, 0.002899223));

N1204_3 :=__common__( map(trim(C_HVAL_100K_P) = ''      => N1204_6,
               ((real)c_hval_100k_p < 26.75) => N1204_4,
                                                N1204_6));

N1204_2 :=__common__( if(((real)c_transport < 33.9499969482), N1204_3, 0.0071610823));

N1204_1 :=__common__( if(trim(C_TRANSPORT) != '', N1204_2, 0.0010380756));

N1205_9 :=__common__( if(((real)f_m_bureau_adl_fs_notu_d > NULL), 0.054426432, 0.00028763346));

N1205_8 :=__common__( map(trim(C_POP_35_44_P) = ''              => -0.0043345428,
               ((real)c_pop_35_44_p < 10.5500001907) => 0.0042643732,
                                                        -0.0043345428));

N1205_7 :=__common__( map(trim(C_RETIRED) = ''              => N1205_8,
               ((real)c_retired < 8.64999961853) => 0.0053178263,
                                                    N1205_8));

N1205_6 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)          => 0.0054447108,
               ((real)f_add_input_nhood_sfd_pct_d < 0.962258636951) => -0.0039537934,
                                                                       0.0054447108));

N1205_5 :=__common__( map(trim(C_RELIG_INDX) = ''      => -0.013087946,
               ((real)c_relig_indx < 165.5) => N1205_6,
                                               -0.013087946));

N1205_4 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => N1205_7,
               ((real)f_add_input_nhood_vac_pct_i < 0.0453981310129) => N1205_5,
                                                                        N1205_7));

N1205_3 :=__common__( if(trim(C_RETIRED2) != '', N1205_4, 0.0015591676));

N1205_2 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), 0.00041317469, N1205_3));

N1205_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1205_2, N1205_9));

N1206_8 :=__common__( map(trim(C_HVAL_20K_P) = ''              => 0.0031366645,
               ((real)c_hval_20k_p < 9.44999980927) => -0.0061047153,
                                                       0.0031366645));

N1206_7 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => -0.0021380849,
               ((real)f_srchaddrsrchcount_i < 3.5)   => 0.0069085326,
                                                        -0.0021380849));

N1206_6 :=__common__( if(((real)r_c16_inv_ssn_per_adl_i > NULL), N1206_7, 0.055974768));

N1206_5 :=__common__( map(((real)c_comb_age_d <= NULL) => N1206_8,
               ((real)c_comb_age_d < 29.5)  => N1206_6,
                                               N1206_8));

N1206_4 :=__common__( if(((real)r_c20_email_domain_isp_count_i < 0.5), -0.00051736741, 0.0021859256));

N1206_3 :=__common__( if(((real)r_c20_email_domain_isp_count_i > NULL), N1206_4, -0.00363063));

N1206_2 :=__common__( if(((real)c_pop_0_5_p < 12.4499998093), N1206_3, N1206_5));

N1206_1 :=__common__( if(trim(C_POP_0_5_P) != '', N1206_2, 0.0006782983));

N1207_9 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.0060322218,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0518858805299) => -0.0018555429,
                                                                       0.0060322218));

N1207_8 :=__common__( map(trim(C_RNT750_P) = ''              => N1207_9,
               ((real)c_rnt750_p < 1.95000004768) => -0.0060602672,
                                                     N1207_9));

N1207_7 :=__common__( map(trim(C_CIV_EMP) = ''      => 0.011039935,
               ((real)c_civ_emp < 66.25) => N1207_8,
                                            0.011039935));

N1207_6 :=__common__( if(((real)r_a50_pb_average_dollars_d < 33.5), -0.0092487403, -0.00033537293));

N1207_5 :=__common__( if(((real)r_a50_pb_average_dollars_d > NULL), N1207_6, -0.0099268055));

N1207_4 :=__common__( if(((real)c_food < 21.5499992371), N1207_5, N1207_7));

N1207_3 :=__common__( if(trim(C_FOOD) != '', N1207_4, 0.0005181137));

N1207_2 :=__common__( map(trim(C_BLUE_COL) = ''              => 0.0089377767,
               ((real)c_blue_col < 25.5499992371) => 0.00048123622,
                                                     0.0089377767));

N1207_1 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1207_2, N1207_3));

N1208_9 :=__common__( if(((real)r_i60_inq_comm_count12_i < 1.5), -0.00049384123, -0.0039124983));

N1208_8 :=__common__( if(((real)r_i60_inq_comm_count12_i > NULL), N1208_9, 0.00025226926));

N1208_7 :=__common__( map(trim(C_RNT1250_P) = ''              => 0.0031607382,
               ((real)c_rnt1250_p < 2.04999995232) => -0.0087547548,
                                                      0.0031607382));

N1208_6 :=__common__( map(trim(C_SFDU_P) = ''      => 0.00011232667,
               ((real)c_sfdu_p < 18.25) => 0.0087752738,
                                           0.00011232667));

N1208_5 :=__common__( map(trim(C_HOUSINGCPI) = ''              => N1208_6,
               ((real)c_housingcpi < 208.950012207) => 0.0058485442,
                                                       N1208_6));

N1208_4 :=__common__( if(((real)f_divrisktype_i < 2.5), N1208_5, N1208_7));

N1208_3 :=__common__( if(((real)f_divrisktype_i > NULL), N1208_4, 0.0037953272));

N1208_2 :=__common__( if(((real)c_blue_empl < 75.5), N1208_3, N1208_8));

N1208_1 :=__common__( if(trim(C_BLUE_EMPL) != '', N1208_2, 0.004294577));

N1209_10 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.350883722305), -7.6320825e-005, 0.0039564398));

N1209_9 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1209_10, -0.0073250874));

N1209_8 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1209_9, 0.0042022454));

N1209_7 :=__common__( map(trim(C_HIGH_HVAL) = ''                => -0.011147731,
               ((real)c_high_hval < 0.0500000007451) => -0.0020971835,
                                                        -0.011147731));

N1209_6 :=__common__( if(((real)f_curraddrcartheftindex_i < 110.5), 0.0010029986, N1209_7));

N1209_5 :=__common__( if(((real)f_curraddrcartheftindex_i > NULL), N1209_6, -0.010560338));

N1209_4 :=__common__( map((fp_segment in ['3 New DID', '4 Bureau Only', '5 Derog', '6 Recent Activity', '7 Other']) => N1209_5,
               (fp_segment in ['1 SSN Prob', '2 NAS 479'])                                               => 0.006081129,
                                                                                                            N1209_5));

N1209_3 :=__common__( map(trim(C_INC_35K_P) = ''     => N1209_8,
               ((real)c_inc_35k_p < 8.75) => N1209_4,
                                             N1209_8));

N1209_2 :=__common__( if(((real)c_pop_18_24_p < 10.8500003815), N1209_3, -0.0011400531));

N1209_1 :=__common__( if(trim(C_POP_18_24_P) != '', N1209_2, -0.0031065402));

N1210_8 :=__common__( map(trim(C_UNATTACH) = ''      => -0.0029725226,
               ((real)c_unattach < 147.5) => 0.0062650466,
                                             -0.0029725226));

N1210_7 :=__common__( map((fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '4 Bureau Only', '6 Recent Activity']) => -0.015307244,
               (fp_segment in ['5 Derog', '7 Other'])                                                         => -0.0027889598,
                                                                                                                 -0.015307244));

N1210_6 :=__common__( map(((real)f_estimated_income_d <= NULL)    => 0.00072670668,
               ((integer)f_estimated_income_d < 27500) => N1210_7,
                                                          0.00072670668));

N1210_5 :=__common__( map(trim(C_OLDHOUSE) = ''       => N1210_8,
               ((real)c_oldhouse < 190.25) => N1210_6,
                                              N1210_8));

N1210_4 :=__common__( if(((real)f_curraddrcrimeindex_i < 128.5), N1210_5, -0.0012778036));

N1210_3 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N1210_4, -0.0029239386));

N1210_2 :=__common__( if(((real)c_civ_emp < 34.25), 0.0055429055, N1210_3));

N1210_1 :=__common__( if(trim(C_CIV_EMP) != '', N1210_2, 0.0010479983));

N1211_8 :=__common__( map(trim(C_RENTAL) = ''      => 0.00093095287,
               ((real)c_rental < 101.5) => 0.012110919,
                                           0.00093095287));

N1211_7 :=__common__( if(((integer)f_prevaddrmedianvalue_d < 194035), -0.00043947427, N1211_8));

N1211_6 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N1211_7, -0.0030878718));

N1211_5 :=__common__( map(((real)c_a49_prop_owned_purchase_tot_d <= NULL)   => 0.0090599132,
               ((integer)c_a49_prop_owned_purchase_tot_d < 1400) => N1211_6,
                                                                    0.0090599132));

N1211_4 :=__common__( map(trim(C_HIGH_ED) = ''              => -0.0016206679,
               ((real)c_high_ed < 13.8500003815) => N1211_5,
                                                    -0.0016206679));

N1211_3 :=__common__( map(trim(C_HVAL_150K_P) = ''              => 0.0058172947,
               ((real)c_hval_150k_p < 34.3499984741) => N1211_4,
                                                        0.0058172947));

N1211_2 :=__common__( if(((real)c_asian_lang < 188.5), N1211_3, -0.0068463111));

N1211_1 :=__common__( if(trim(C_ASIAN_LANG) != '', N1211_2, 0.00071014782));

N1212_8 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => -3.3833832e-006,
               ((real)f_inq_per_ssn_i < 1.5)   => 0.011414321,
                                                  -3.3833832e-006));

N1212_7 :=__common__( map(trim(C_INC_15K_P) = ''              => -0.0027947391,
               ((real)c_inc_15k_p < 11.0500001907) => N1212_8,
                                                      -0.0027947391));

N1212_6 :=__common__( map(trim(C_HVAL_150K_P) = ''              => -0.0038564853,
               ((real)c_hval_150k_p < 3.95000004768) => N1212_7,
                                                        -0.0038564853));

N1212_5 :=__common__( map(trim(C_MED_AGE) = ''              => 0.0025039335,
               ((real)c_med_age < 26.1500015259) => -0.0035305971,
                                                    0.0025039335));

N1212_4 :=__common__( if(((integer)f_estimated_income_d < 37500), N1212_5, N1212_6));

N1212_3 :=__common__( if(((real)f_estimated_income_d > NULL), N1212_4, -0.012689014));

N1212_2 :=__common__( if(((real)c_rental < 145.5), N1212_3, -0.0013062399));

N1212_1 :=__common__( if(trim(C_RENTAL) != '', N1212_2, -0.0030113803));

N1213_8 :=__common__( map(trim(C_CHILD) = ''              => 0.0024474387,
               ((real)c_child < 23.9500007629) => -0.00076016372,
                                                  0.0024474387));

N1213_7 :=__common__( map(trim(C_RAPE) = ''      => -0.0022018467,
               ((real)c_rape < 177.5) => N1213_8,
                                         -0.0022018467));

N1213_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1213_7, 0.0014145159));

N1213_5 :=__common__( map(trim(C_HIGH_ED) = ''      => -0.0081208402,
               ((real)c_high_ed < 50.75) => N1213_6,
                                            -0.0081208402));

N1213_4 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.0031733073,
               ((real)c_comb_age_d < 26.5)  => 0.0046975355,
                                               -0.0031733073));

N1213_3 :=__common__( map(trim(C_HH5_P) = ''              => -0.011174675,
               ((real)c_hh5_p < 14.4499998093) => N1213_4,
                                                  -0.011174675));

N1213_2 :=__common__( if(((real)c_retired2 < 38.5), N1213_3, N1213_5));

N1213_1 :=__common__( if(trim(C_RETIRED2) != '', N1213_2, 0.0016081036));

N1214_8 :=__common__( map(trim(C_FAMILIES) = ''      => -0.00065199015,
               ((real)c_families < 210.5) => -0.0059069617,
                                             -0.00065199015));

N1214_7 :=__common__( map(trim(C_HVAL_125K_P) = ''              => 0.01041564,
               ((real)c_hval_125k_p < 7.35000038147) => 2.7216772e-005,
                                                        0.01041564));

N1214_6 :=__common__( if(((integer)f_estimated_income_d < 23500), N1214_7, -0.00021927408));

N1214_5 :=__common__( if(((real)f_estimated_income_d > NULL), N1214_6, -0.00017656717));

N1214_4 :=__common__( map(trim(C_VERY_RICH) = ''      => 0.0070508174,
               ((real)c_very_rich < 174.5) => N1214_5,
                                              0.0070508174));

N1214_3 :=__common__( map(((real)f_inq_per_phone_i <= NULL) => 0.0088567356,
               ((real)f_inq_per_phone_i < 6.5)   => N1214_4,
                                                    0.0088567356));

N1214_2 :=__common__( if(((real)c_trailer_p < 0.350000023842), N1214_3, N1214_8));

N1214_1 :=__common__( if(trim(C_TRAILER_P) != '', N1214_2, -0.00022265572));

N1215_8 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.010418707,
               ((real)c_sub_bus < 127.5) => -0.00020153165,
                                            0.010418707));

N1215_7 :=__common__( map(trim(C_EASIQLIFE) = ''      => N1215_8,
               ((real)c_easiqlife < 131.5) => -0.0027496737,
                                              N1215_8));

N1215_6 :=__common__( map(trim(C_INC_100K_P) = ''              => -0.00258819,
               ((real)c_inc_100k_p < 9.85000038147) => -0.0094177797,
                                                       -0.00258819));

N1215_5 :=__common__( if(((integer)f_curraddrmedianincome_d < 28841), 0.0035318447, N1215_6));

N1215_4 :=__common__( if(((real)f_curraddrmedianincome_d > NULL), N1215_5, 0.0083019608));

N1215_3 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => N1215_4,
               (segment in ['SEARS FLS'])                                  => N1215_7,
                                                                              N1215_4));

N1215_2 :=__common__( if(((real)c_rnt1000_p < 19.25), 0.00066303028, N1215_3));

N1215_1 :=__common__( if(trim(C_RNT1000_P) != '', N1215_2, 0.00031089794));

N1216_9 :=__common__( map(((real)f_addrchangevaluediff_d <= NULL)      => 0.00097697903,
               ((integer)f_addrchangevaluediff_d < -153911) => -0.0080722577,
                                                               0.00097697903));

N1216_8 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)          => -0.0047108987,
               ((real)f_add_input_nhood_sfd_pct_d < 0.959386765957) => N1216_9,
                                                                       -0.0047108987));

N1216_7 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1216_8, 0.00053132886));

N1216_6 :=__common__( if(((real)f_liens_rel_cj_total_amt_i < 2250.5), N1216_7, -0.0086058894));

N1216_5 :=__common__( if(((real)f_liens_rel_cj_total_amt_i > NULL), N1216_6, 0.0035351534));

N1216_4 :=__common__( map(trim(C_POPOVER18) = ''       => -0.0076720585,
               ((real)c_popover18 < 2302.5) => N1216_5,
                                               -0.0076720585));

N1216_3 :=__common__( map(trim(C_HVAL_300K_P) = ''      => 0.011300498,
               ((real)c_hval_300k_p < 12.25) => 0.0012010011,
                                                0.011300498));

N1216_2 :=__common__( if(((real)c_oldhouse < 31.9500007629), N1216_3, N1216_4));

N1216_1 :=__common__( if(trim(C_OLDHOUSE) != '', N1216_2, -0.00047929892));

N1217_8 :=__common__( map(trim(C_FOOD) = ''              => 0.0071568777,
               ((real)c_food < 56.8000030518) => -0.0016702269,
                                                 0.0071568777));

N1217_7 :=__common__( map(trim(C_UNEMPL) = ''     => N1217_8,
               ((real)c_unempl < 55.5) => 0.0088279519,
                                          N1217_8));

N1217_6 :=__common__( map(trim(C_INC_75K_P) = ''              => -0.0024413618,
               ((real)c_inc_75k_p < 21.5499992371) => 0.0079232701,
                                                      -0.0024413618));

N1217_5 :=__common__( if(((real)c_rnt750_p < 11.4499998093), N1217_6, N1217_7));

N1217_4 :=__common__( if(trim(C_RNT750_P) != '', N1217_5, -0.0086873949));

N1217_3 :=__common__( map(((real)f_assocrisktype_i <= NULL) => N1217_4,
               ((real)f_assocrisktype_i < 5.5)   => -0.0018163468,
                                                    N1217_4));

N1217_2 :=__common__( if(((integer)f_curraddrmedianvalue_d < 83164), 0.0021238677, N1217_3));

N1217_1 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N1217_2, -0.0055140681));

N1218_9 :=__common__( map(((real)f_inq_dobs_per_ssn_i <= NULL) => 0.0090534773,
               ((real)f_inq_dobs_per_ssn_i < 0.5)   => 0.00056005139,
                                                       0.0090534773));

N1218_8 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => 0.0070952607,
               ((real)r_c14_addrs_15yr_i < 19.5)  => -6.8388397e-005,
                                                     0.0070952607));

N1218_7 :=__common__( if(((real)c_finance < 8.25), N1218_8, N1218_9));

N1218_6 :=__common__( if(trim(C_FINANCE) != '', N1218_7, -0.00038257268));

N1218_5 :=__common__( if(((real)c_hh3_p < 19.9500007629), 0.0031762961, -0.0047024945));

N1218_4 :=__common__( if(trim(C_HH3_P) != '', N1218_5, 0.0055203949));

N1218_3 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL) => N1218_4,
               ((real)f_prevaddrcartheftindex_i < 155.5) => -0.0031548729,
                                                            N1218_4));

N1218_2 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 66.5), N1218_3, N1218_6));

N1218_1 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N1218_2, -0.0011270585));

N1219_8 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => -0.0067693808,
               ((real)r_d30_derog_count_i < 5.5)   => 0.0039383083,
                                                      -0.0067693808));

N1219_7 :=__common__( map(((real)c_nap_fname_verd_d <= NULL) => 0.0072680584,
               ((real)c_nap_fname_verd_d < 0.5)   => N1219_8,
                                                     0.0072680584));

N1219_6 :=__common__( map(trim(C_RNT500_P) = ''      => 0.01181769,
               ((real)c_rnt500_p < 47.25) => N1219_7,
                                             0.01181769));

N1219_5 :=__common__( map(trim(C_RETIRED) = ''              => 0.0053295046,
               ((real)c_retired < 12.6499996185) => -0.0049506466,
                                                    0.0053295046));

N1219_4 :=__common__( if(((real)c_pop_45_54_p < 11.75), N1219_5, N1219_6));

N1219_3 :=__common__( if(trim(C_POP_45_54_P) != '', N1219_4, 0.0018451912));

N1219_2 :=__common__( if(((real)f_historical_count_d < 5.5), -5.3027413e-006, N1219_3));

N1219_1 :=__common__( if(((real)f_historical_count_d > NULL), N1219_2, -0.0049357068));

N1220_11 :=__common__( if(((real)f_prevaddrstatus_i < 2.5), 0.011538896, -0.0020262605));

N1220_10 :=__common__( if(((real)f_prevaddrstatus_i > NULL), N1220_11, 0.0043416707));

N1220_9 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0638877674937), N1220_10, 9.2163508e-005));

N1220_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1220_9, 0.0081961377));

N1220_7 :=__common__( map(trim(C_WORK_HOME) = ''     => N1220_8,
               ((real)c_work_home < 94.5) => 0.0010016024,
                                             N1220_8));

N1220_6 :=__common__( if(((real)f_rel_incomeover50_count_d < 6.5), N1220_7, -0.0010648909));

N1220_5 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N1220_6, 0.0023224809));

N1220_4 :=__common__( if(((real)c_hh1_p < 31.0499992371), N1220_5, -0.00091160993));

N1220_3 :=__common__( if(trim(C_HH1_P) != '', N1220_4, -0.0016752953));

N1220_2 :=__common__( if(((real)r_c18_inv_add_per_adl_c6_i < 0.5), N1220_3, -0.0045274868));

N1220_1 :=__common__( if(((real)r_c18_inv_add_per_adl_c6_i > NULL), N1220_2, -0.0017122509));

N1221_10 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.0542137883604), 0.0048031103, -0.0051509954));

N1221_9 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1221_10, 0.0015599161));

N1221_8 :=__common__( map(((real)f_divssnidmsrcurelcount_i <= NULL) => N1221_9,
               ((real)f_divssnidmsrcurelcount_i < 0.5)   => -0.010887791,
                                                            N1221_9));

N1221_7 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => 0.00078871485,
               ((real)f_curraddrmedianincome_d < 13412.5) => -0.004539094,
                                                             0.00078871485));

N1221_6 :=__common__( if(trim(C_UNEMPL) != '', N1221_7, 0.0046761475));

N1221_5 :=__common__( if(((real)f_corrssnaddrcount_d < 5.5), N1221_6, N1221_8));

N1221_4 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N1221_5, -0.0042602794));

N1221_3 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => -0.0080573138,
               ((real)f_add_curr_nhood_vac_pct_i < 0.490805208683) => N1221_4,
                                                                      -0.0080573138));

N1221_2 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.854403972626), N1221_3, 0.0072709121));

N1221_1 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N1221_2, 0.012912055));

N1222_8 :=__common__( map(trim(C_POP_6_11_P) = ''     => 0.0084207241,
               ((real)c_pop_6_11_p < 8.25) => -0.0024088723,
                                              0.0084207241));

N1222_7 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)   => -0.010569002,
               ((real)f_prevaddrmedianvalue_d < 71899.5) => -0.0011498848,
                                                            -0.010569002));

N1222_6 :=__common__( map(trim(C_RNT750_P) = ''              => -0.00016005674,
               ((real)c_rnt750_p < 38.3499984741) => N1222_7,
                                                     -0.00016005674));

N1222_5 :=__common__( map(trim(C_POP_6_11_P) = ''              => N1222_6,
               ((real)c_pop_6_11_p < 9.64999961853) => -0.00097626183,
                                                       N1222_6));

N1222_4 :=__common__( map(trim(C_HVAL_20K_P) = ''     => N1222_5,
               ((real)c_hval_20k_p < 0.75) => -4.6359615e-005,
                                              N1222_5));

N1222_3 :=__common__( if(((real)f_srchaddrsrchcount_i < 36.5), N1222_4, N1222_8));

N1222_2 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N1222_3, 0.0047105173));

N1222_1 :=__common__( if(trim(C_SERV_EMPL) != '', N1222_2, 0.0021521542));

N1223_9 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i < 0.5), 0.0070762634, -0.00057313303));

N1223_8 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i > NULL), N1223_9, 0.010317914));

N1223_7 :=__common__( map(trim(C_HVAL_400K_P) = ''              => 0.0085465775,
               ((real)c_hval_400k_p < 2.65000009537) => N1223_8,
                                                        0.0085465775));

N1223_6 :=__common__( if(((real)f_prevaddrmedianincome_d < 30509.5), 0.0066848853, -0.0017014926));

N1223_5 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N1223_6, -0.031873647));

N1223_4 :=__common__( map(trim(C_RNT500_P) = ''              => N1223_7,
               ((real)c_rnt500_p < 8.35000038147) => N1223_5,
                                                     N1223_7));

N1223_3 :=__common__( map(trim(C_FOOD) = ''              => N1223_4,
               ((real)c_food < 4.05000019073) => -0.0023811058,
                                                 N1223_4));

N1223_2 :=__common__( if(((real)c_hval_200k_p < 3.75), -0.0010728617, N1223_3));

N1223_1 :=__common__( if(trim(C_HVAL_200K_P) != '', N1223_2, 0.0022512563));

N1224_8 :=__common__( map(trim(C_OCCUNIT_P) = ''              => 0.0092011829,
               ((real)c_occunit_p < 84.4499969482) => -0.00081156187,
                                                      0.0092011829));

N1224_7 :=__common__( map(trim(C_FAMMAR18_P) = ''              => -0.0029693173,
               ((real)c_fammar18_p < 34.6500015259) => N1224_8,
                                                       -0.0029693173));

N1224_6 :=__common__( map(trim(C_VERY_RICH) = ''      => -0.0029491105,
               ((real)c_very_rich < 101.5) => N1224_7,
                                              -0.0029491105));

N1224_5 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)    => N1224_6,
               ((integer)f_prevaddrmedianvalue_d < 56866) => 0.010128971,
                                                             N1224_6));

N1224_4 :=__common__( if(((real)f_srchfraudsrchcountyr_i < 3.5), -0.00017553583, N1224_5));

N1224_3 :=__common__( if(((real)f_srchfraudsrchcountyr_i > NULL), N1224_4, 0.0014241542));

N1224_2 :=__common__( if(((real)c_med_rent < 1263.5), N1224_3, -0.008108012));

N1224_1 :=__common__( if(trim(C_MED_RENT) != '', N1224_2, 0.0082739009));

N1225_7 :=__common__( map(trim(C_NO_LABFOR) = ''     => 0.0072338747,
               ((real)c_no_labfor < 56.5) => -0.0017495336,
                                             0.0072338747));

N1225_6 :=__common__( map(trim(C_RNT500_P) = ''              => 0.0010888146,
               ((real)c_rnt500_p < 9.44999980927) => -0.0017581237,
                                                     0.0010888146));

N1225_5 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.0065722018,
               ((real)c_comb_age_d < 56.5)  => N1225_6,
                                               -0.0065722018));

N1225_4 :=__common__( map(trim(C_RNT1500_P) = ''              => N1225_7,
               ((real)c_rnt1500_p < 6.55000019073) => N1225_5,
                                                      N1225_7));

N1225_3 :=__common__( map(trim(C_HH2_P) = ''              => 0.0077768949,
               ((real)c_hh2_p < 49.1500015259) => N1225_4,
                                                  0.0077768949));

N1225_2 :=__common__( if(((real)c_pop_55_64_p < 15.1499996185), N1225_3, -0.0025953497));

N1225_1 :=__common__( if(trim(C_POP_55_64_P) != '', N1225_2, 0.0001962285));

N1226_10 :=__common__( if(((real)c_pop_45_54_p < 21.6500015259), 0.00028243395, -0.0043510623));

N1226_9 :=__common__( if(trim(C_POP_45_54_P) != '', N1226_10, -0.0023852004));

N1226_8 :=__common__( if(((real)f_inq_per_addr_i < 19.5), N1226_9, 0.0076213652));

N1226_7 :=__common__( if(((real)f_inq_per_addr_i > NULL), N1226_8, 0.0080092419));

N1226_6 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => N1226_7,
               ((real)r_c21_m_bureau_adl_fs_d < 64.5)  => -0.0079820717,
                                                          N1226_7));

N1226_5 :=__common__( map(trim(C_SERV_EMPL) = ''      => 0.012835506,
               ((real)c_serv_empl < 139.5) => 0.0016361769,
                                              0.012835506));

N1226_4 :=__common__( if(((real)c_bel_edu < 169.5), N1226_5, -0.0044266166));

N1226_3 :=__common__( if(trim(C_BEL_EDU) != '', N1226_4, 0.014232741));

N1226_2 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 52.5), N1226_3, N1226_6));

N1226_1 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N1226_2, 0.0031959854));

N1227_7 :=__common__( map(trim(C_CARTHEFT) = ''      => -0.004512303,
               ((integer)c_cartheft < 48) => 0.0051410681,
                                             -0.004512303));

N1227_6 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)         => 0.010552268,
               ((real)f_add_curr_nhood_vac_pct_i < 0.02391827479) => 0.00091173871,
                                                                     0.010552268));

N1227_5 :=__common__( map(trim(C_POP_35_44_P) = ''              => 0.001494628,
               ((real)c_pop_35_44_p < 14.3500003815) => N1227_6,
                                                        0.001494628));

N1227_4 :=__common__( map(trim(C_NEWHOUSE) = ''              => N1227_5,
               ((real)c_newhouse < 8.85000038147) => 0.00014223779,
                                                     N1227_5));

N1227_3 :=__common__( map(trim(C_POP_75_84_P) = ''              => -0.00022260703,
               ((real)c_pop_75_84_p < 1.84999990463) => N1227_4,
                                                        -0.00022260703));

N1227_2 :=__common__( if(((real)c_rich_nfam < 162.5), N1227_3, N1227_7));

N1227_1 :=__common__( if(trim(C_RICH_NFAM) != '', N1227_2, -0.0030502055));

N1228_8 :=__common__( map(trim(C_RNT1000_P) = ''              => -0.013228902,
               ((real)c_rnt1000_p < 28.8499984741) => -0.002992534,
                                                      -0.013228902));

N1228_7 :=__common__( map(((real)c_comb_age_d <= NULL) => N1228_8,
               ((real)c_comb_age_d < 31.5)  => 0.0015310088,
                                               N1228_8));

N1228_6 :=__common__( map(trim(C_SFDU_P) = ''              => -0.005172557,
               ((real)c_sfdu_p < 97.3500061035) => 0.0019907222,
                                                   -0.005172557));

N1228_5 :=__common__( map(trim(C_HH6_P) = ''               => N1228_6,
               ((real)c_hh6_p < 0.649999976158) => -0.00076905934,
                                                   N1228_6));

N1228_4 :=__common__( if(((real)c_rnt1250_p < 18.6500015259), N1228_5, N1228_7));

N1228_3 :=__common__( if(trim(C_RNT1250_P) != '', N1228_4, 0.00021341056));

N1228_2 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 19.5), 0.0056244373, N1228_3));

N1228_1 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N1228_2, 0.0039497143));

N1229_8 :=__common__( map(trim(C_EASIQLIFE) = ''     => 0.0050868009,
               ((real)c_easiqlife < 77.5) => -0.0017530166,
                                             0.0050868009));

N1229_7 :=__common__( map(trim(C_POP_65_74_P) = ''              => N1229_8,
               ((real)c_pop_65_74_p < 2.84999990463) => -0.0036758217,
                                                        N1229_8));

N1229_6 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL) => -0.00035395678,
               ((real)f_fp_prevaddrburglaryindex_i < 82.5)  => N1229_7,
                                                               -0.00035395678));

N1229_5 :=__common__( map(((real)c_unique_addr_count_i <= NULL) => -0.0067598996,
               ((real)c_unique_addr_count_i < 7.5)   => 0.0014491094,
                                                        -0.0067598996));

N1229_4 :=__common__( if(((real)c_mort_indx < 39.5), N1229_5, N1229_6));

N1229_3 :=__common__( if(trim(C_MORT_INDX) != '', N1229_4, -0.00051345069));

N1229_2 :=__common__( if(((real)f_divrisktype_i < 5.5), N1229_3, -0.006725585));

N1229_1 :=__common__( if(((real)f_divrisktype_i > NULL), N1229_2, 0.0075769223));

N1230_7 :=__common__( if(((real)c_totcrime < 89.5), 0.0078229978, 7.9347638e-005));

N1230_6 :=__common__( if(trim(C_TOTCRIME) != '', N1230_7, 0.0020019505));

N1230_5 :=__common__( map(((real)f_estimated_income_d <= NULL)    => -0.0029275715,
               ((integer)f_estimated_income_d < 26500) => -0.012326275,
                                                          -0.0029275715));

N1230_4 :=__common__( map(((real)f_mos_liens_unrel_lt_lseen_d <= NULL) => N1230_5,
               ((real)f_mos_liens_unrel_lt_lseen_d < 135.5) => 0.0039441422,
                                                               N1230_5));

N1230_3 :=__common__( if(((real)f_addrchangeecontrajindex_d < 1.5), 0.00025360286, N1230_4));

N1230_2 :=__common__( if(((real)f_addrchangeecontrajindex_d > NULL), N1230_3, 3.6177774e-005));

N1230_1 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => N1230_6,
               ((real)f_inq_per_ssn_i < 5.5)   => N1230_2,
                                                  N1230_6));

N1231_8 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => 0.010218097,
               ((real)r_c13_max_lres_d < 134.5) => -0.0017049419,
                                                   0.010218097));

N1231_7 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => 0.0016076189,
               ((real)r_c14_addrs_5yr_i < 4.5)   => -0.010477099,
                                                    0.0016076189));

N1231_6 :=__common__( map(trim(C_BORN_USA) = ''      => N1231_8,
               ((real)c_born_usa < 125.5) => N1231_7,
                                             N1231_8));

N1231_5 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1231_6, -0.0060266463));

N1231_4 :=__common__( map(trim(C_HEALTH) = ''              => -0.0016329065,
               ((real)c_health < 19.8499984741) => 0.0010483985,
                                                   -0.0016329065));

N1231_3 :=__common__( map(trim(C_MANUFACTURING) = ''              => 0.008282756,
               ((real)c_manufacturing < 1.84999990463) => N1231_4,
                                                          0.008282756));

N1231_2 :=__common__( if(((real)c_manufacturing < 3.54999995232), N1231_3, N1231_5));

N1231_1 :=__common__( if(trim(C_MANUFACTURING) != '', N1231_2, 0.00038420661));

N1232_8 :=__common__( map(((real)f_historical_count_d <= NULL) => -0.0031458209,
               ((real)f_historical_count_d < 3.5)   => 0.0046570375,
                                                       -0.0031458209));

N1232_7 :=__common__( map(((real)c_dist_input_to_prev_addr_i <= NULL) => -0.0073529328,
               ((real)c_dist_input_to_prev_addr_i < 26.5)  => N1232_8,
                                                              -0.0073529328));

N1232_6 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => N1232_7,
               ((real)f_curraddrburglaryindex_i < 178.5) => 0.0080867438,
                                                            N1232_7));

N1232_5 :=__common__( map(trim(C_RETIRED) = ''              => -0.0044771972,
               ((real)c_retired < 16.1500015259) => N1232_6,
                                                    -0.0044771972));

N1232_4 :=__common__( map(trim(C_LAR_FAM) = ''      => 0.0072004599,
               ((real)c_lar_fam < 132.5) => N1232_5,
                                            0.0072004599));

N1232_3 :=__common__( if(((real)f_curraddrburglaryindex_i < 170.5), -0.00071742135, N1232_4));

N1232_2 :=__common__( if(((real)f_curraddrburglaryindex_i > NULL), N1232_3, 0.0034356239));

N1232_1 :=__common__( if(trim(C_TRAILER_P) != '', N1232_2, -0.0023984194));

N1233_10 :=__common__( map(trim(C_EASIQLIFE) = ''     => 0.00026528349,
                ((real)c_easiqlife < 70.5) => -0.010107412,
                                              0.00026528349));

N1233_9 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => 0.0063167813,
               ((real)f_srchaddrsrchcount_i < 4.5)   => -0.0042702354,
                                                        0.0063167813));

N1233_8 :=__common__( map(((real)f_rel_ageover20_count_d <= NULL) => -0.0044827045,
               ((real)f_rel_ageover20_count_d < 27.5)  => 0.0030311069,
                                                          -0.0044827045));

N1233_7 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1233_8, N1233_9));

N1233_6 :=__common__( if(((real)c_inc_75k_p < 21.9500007629), N1233_7, N1233_10));

N1233_5 :=__common__( if(trim(C_INC_75K_P) != '', N1233_6, -0.0067000901));

N1233_4 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d < 0.827671647072), -0.0011730683, N1233_5));

N1233_3 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d > NULL), N1233_4, -0.0082658492));

N1233_2 :=__common__( if(((real)f_rel_homeover500_count_d < 3.5), N1233_3, 0.0077897716));

N1233_1 :=__common__( if(((real)f_rel_homeover500_count_d > NULL), N1233_2, 0.00049057764));

N1234_9 :=__common__( map(((real)f_mos_liens_unrel_sc_fseen_d <= NULL) => -0.00015686043,
               ((real)f_mos_liens_unrel_sc_fseen_d < 99.5)  => -0.0066889033,
                                                               -0.00015686043));

N1234_8 :=__common__( map(trim(C_HVAL_400K_P) = ''              => 0.0097098137,
               ((real)c_hval_400k_p < 4.64999961853) => 0.0005857992,
                                                        0.0097098137));

N1234_7 :=__common__( map(trim(C_HIGHINC) = ''               => 0.0020858984,
               ((real)c_highinc < 0.449999988079) => 0.0096508193,
                                                     0.0020858984));

N1234_6 :=__common__( if(((integer)f_addrchangevaluediff_d < -72347), -0.0042796199, N1234_7));

N1234_5 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1234_6, N1234_8));

N1234_4 :=__common__( if(((real)c_inc_75k_p < 20.5499992371), N1234_5, -0.0010897077));

N1234_3 :=__common__( if(trim(C_INC_75K_P) != '', N1234_4, 0.00089567918));

N1234_2 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 70.5), N1234_3, N1234_9));

N1234_1 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N1234_2, -0.0017141793));

N1235_8 :=__common__( map(trim(C_LOW_ED) = ''              => 0.0025940267,
               ((real)c_low_ed < 34.1500015259) => -0.0038081518,
                                                   0.0025940267));

N1235_7 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL)  => -0.0065547322,
               ((real)f_liens_unrel_cj_total_amt_i < 5909.5) => -0.00053068778,
                                                                -0.0065547322));

N1235_6 :=__common__( map(trim(C_EMPLOYEES) = ''      => N1235_8,
               ((real)c_employees < 190.5) => N1235_7,
                                              N1235_8));

N1235_5 :=__common__( map(trim(C_FAMILIES) = ''      => -0.0052613796,
               ((real)c_families < 824.5) => N1235_6,
                                             -0.0052613796));

N1235_4 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL)    => 0.0078630308,
               ((integer)f_liens_unrel_cj_total_amt_i < 14844) => N1235_5,
                                                                  0.0078630308));

N1235_3 :=__common__( if(trim(C_FAMILIES) != '', N1235_4, 0.00059370198));

N1235_2 :=__common__( if(((real)f_rel_educationover12_count_d < 31.5), N1235_3, 0.0059969955));

N1235_1 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N1235_2, 0.0011586031));

N1236_9 :=__common__( map(trim(C_BURGLARY) = ''      => -0.0011086674,
               ((real)c_burglary < 170.5) => -0.010225289,
                                             -0.0011086674));

N1236_8 :=__common__( map(((real)f_prevaddrageoldest_d <= NULL) => 0.0027911591,
               ((real)f_prevaddrageoldest_d < 68.5)  => N1236_9,
                                                        0.0027911591));

N1236_7 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL) => 0.007075279,
               ((real)f_prevaddrmurderindex_i < 153.5) => 0.00090728068,
                                                          0.007075279));

N1236_6 :=__common__( map(trim(C_MURDERS) = ''      => N1236_8,
               ((real)c_murders < 164.5) => N1236_7,
                                            N1236_8));

N1236_5 :=__common__( if(((integer)f_liens_unrel_o_total_amt_i < 44), N1236_6, -0.010024755));

N1236_4 :=__common__( if(((real)f_liens_unrel_o_total_amt_i > NULL), N1236_5, 0.0064759609));

N1236_3 :=__common__( if(trim(C_MURDERS) != '', N1236_4, 0.0014168805));

N1236_2 :=__common__( map(trim(C_EASIQLIFE) = ''      => -0.0016192871,
               ((real)c_easiqlife < 125.5) => 0.0012014239,
                                              -0.0016192871));

N1236_1 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N1236_2, N1236_3));

N1237_9 :=__common__( map(trim(C_FAMOTF18_P) = ''              => -0.0039650576,
               ((real)c_famotf18_p < 27.8499984741) => 0.0036182765,
                                                       -0.0039650576));

N1237_8 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => N1237_9,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0207834932953) => -0.0076499505,
                                                                       N1237_9));

N1237_7 :=__common__( if(((integer)f_prevaddrmedianvalue_d < 75445), N1237_8, 0.0013914482));

N1237_6 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N1237_7, -0.0034107947));

N1237_5 :=__common__( map(trim(C_INCOLLEGE) = ''              => 0.0043690545,
               ((real)c_incollege < 8.55000019073) => -0.0057640882,
                                                      0.0043690545));

N1237_4 :=__common__( map(trim(C_HVAL_400K_P) = ''              => N1237_5,
               ((real)c_hval_400k_p < 2.45000004768) => 0.0012025669,
                                                        N1237_5));

N1237_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1237_4, N1237_6));

N1237_2 :=__common__( if(((real)c_hhsize < 3.90500020981), N1237_3, -0.0082558001));

N1237_1 :=__common__( if(trim(C_HHSIZE) != '', N1237_2, -0.00010601498));

N1238_9 :=__common__( if(((real)f_prevaddrcartheftindex_i < 196.5), 0.0012717072, -0.0059018988));

N1238_8 :=__common__( if(((real)f_prevaddrcartheftindex_i > NULL), N1238_9, 0.0066679779));

N1238_7 :=__common__( if(((real)r_d34_unrel_liens_ct_i < 3.5), -0.0010966865, 0.0080139469));

N1238_6 :=__common__( if(((real)r_d34_unrel_liens_ct_i > NULL), N1238_7, -0.032970944));

N1238_5 :=__common__( map(trim(C_INC_75K_P) = ''     => N1238_6,
               ((real)c_inc_75k_p < 7.25) => -0.0062574725,
                                             N1238_6));

N1238_4 :=__common__( map(trim(C_HVAL_400K_P) = ''              => -0.0099810747,
               ((real)c_hval_400k_p < 1.45000004768) => N1238_5,
                                                        -0.0099810747));

N1238_3 :=__common__( map(trim(C_HIGH_ED) = ''              => N1238_8,
               ((real)c_high_ed < 5.55000019073) => N1238_4,
                                                    N1238_8));

N1238_2 :=__common__( if(((real)c_for_sale < 168.5), N1238_3, -0.0022019974));

N1238_1 :=__common__( if(trim(C_FOR_SALE) != '', N1238_2, -0.0022028303));

N1239_9 :=__common__( map(trim(C_VACANT_P) = ''              => 0.0028004885,
               ((real)c_vacant_p < 17.8499984741) => -0.0076671495,
                                                     0.0028004885));

N1239_8 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.346241146326), -0.0038174814, 0.0068776256));

N1239_7 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1239_8, -0.01596953));

N1239_6 :=__common__( map(trim(C_OCCUNIT_P) = ''              => 0.0089536277,
               ((real)c_occunit_p < 89.3500061035) => N1239_7,
                                                      0.0089536277));

N1239_5 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => N1239_9,
               ((real)f_add_input_nhood_vac_pct_i < 0.116913467646) => N1239_6,
                                                                       N1239_9));

N1239_4 :=__common__( if(((integer)f_estimated_income_d < 26500), -0.0026243035, 0.00020117221));

N1239_3 :=__common__( if(((real)f_estimated_income_d > NULL), N1239_4, -0.0098744894));

N1239_2 :=__common__( if(((real)c_assault < 182.5), N1239_3, N1239_5));

N1239_1 :=__common__( if(trim(C_ASSAULT) != '', N1239_2, -0.0021643731));

N1240_8 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => -0.0015794508,
               ((real)f_mos_inq_banko_om_fseen_d < 33.5)  => 0.00099331935,
                                                             -0.0015794508));

N1240_7 :=__common__( map((fp_segment in ['2 NAS 479', '3 New DID', '5 Derog', '6 Recent Activity', '7 Other']) => N1240_8,
               (fp_segment in ['1 SSN Prob', '4 Bureau Only'])                                       => 0.0041884203,
                                                                                                        N1240_8));

N1240_6 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 81.5), -0.0053304192, N1240_7));

N1240_5 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N1240_6, -0.0015754903));

N1240_4 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)         => -0.0036272219,
               ((real)f_add_input_mobility_index_n < 0.28008890152) => 0.0080845494,
                                                                       -0.0036272219));

N1240_3 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => 0.0091258443,
               ((real)f_add_input_mobility_index_n < 0.389244168997) => N1240_4,
                                                                        0.0091258443));

N1240_2 :=__common__( if(((real)c_born_usa < 25.5), N1240_3, N1240_5));

N1240_1 :=__common__( if(trim(C_BORN_USA) != '', N1240_2, 0.0027741843));

N1241_8 :=__common__( map(trim(C_INC_35K_P) = ''              => -0.011576089,
               ((real)c_inc_35k_p < 11.9499998093) => -0.002739747,
                                                      -0.011576089));

N1241_7 :=__common__( map(trim(C_BIGAPT_P) = ''              => 0.0013818263,
               ((real)c_bigapt_p < 1.65000009537) => N1241_8,
                                                     0.0013818263));

N1241_6 :=__common__( map(trim(C_INC_201K_P) = ''              => N1241_7,
               ((real)c_inc_201k_p < 2.65000009537) => 0.00041561615,
                                                       N1241_7));

N1241_5 :=__common__( map(trim(C_RETIRED2) = ''     => N1241_6,
               ((real)c_retired2 < 23.5) => -0.0070241561,
                                            N1241_6));

N1241_4 :=__common__( map(trim(C_RETIRED) = ''              => N1241_5,
               ((real)c_retired < 2.04999995232) => 0.0053844713,
                                                    N1241_5));

N1241_3 :=__common__( if(((real)c_unique_addr_count_i < 1.5), -0.0059506901, N1241_4));

N1241_2 :=__common__( if(((real)c_unique_addr_count_i > NULL), N1241_3, -0.0031461243));

N1241_1 :=__common__( if(trim(C_INC_50K_P) != '', N1241_2, 0.0026477447));

N1242_10 :=__common__( map(trim(C_HHSIZE) = ''              => -0.010588202,
                ((real)c_hhsize < 2.55499982834) => -0.0018836666,
                                                    -0.010588202));

N1242_9 :=__common__( if(((real)c_lar_fam < 116.5), N1242_10, 0.0023573514));

N1242_8 :=__common__( if(trim(C_LAR_FAM) != '', N1242_9, -0.0067204064));

N1242_7 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d < 22.5), -0.0087203814, 0.00049162749));

N1242_6 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d > NULL), N1242_7, -0.0299843));

N1242_5 :=__common__( map(trim(C_MANY_CARS) = ''     => 0.0024863512,
               ((real)c_many_cars < 31.5) => N1242_6,
                                             0.0024863512));

N1242_4 :=__common__( if(((real)c_newhouse < 5.64999961853), N1242_5, -0.00082078213));

N1242_3 :=__common__( if(trim(C_NEWHOUSE) != '', N1242_4, -0.00056074435));

N1242_2 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.262645214796), N1242_3, N1242_8));

N1242_1 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N1242_2, 0.05752892));

N1243_8 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)    => 0.00072724374,
               ((real)f_curraddrmedianvalue_d < 103939.5) => 0.01076708,
                                                             0.00072724374));

N1243_7 :=__common__( map(trim(C_INC_50K_P) = ''              => 0.0081231298,
               ((real)c_inc_50k_p < 27.6500015259) => -0.00019563168,
                                                      0.0081231298));

N1243_6 :=__common__( map(trim(C_NO_LABFOR) = ''     => -0.0082148257,
               ((real)c_no_labfor < 89.5) => 0.0007101442,
                                             -0.0082148257));

N1243_5 :=__common__( map(trim(C_POP_12_17_P) = ''              => 0.0023757856,
               ((real)c_pop_12_17_p < 12.0500001907) => N1243_6,
                                                        0.0023757856));

N1243_4 :=__common__( if(((real)c_inc_150k_p < 0.0500000007451), N1243_5, N1243_7));

N1243_3 :=__common__( if(trim(C_INC_150K_P) != '', N1243_4, -0.0035867685));

N1243_2 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i < 12.5), N1243_3, N1243_8));

N1243_1 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i > NULL), N1243_2, -0.00068354251));

N1244_9 :=__common__( map(trim(C_NO_LABFOR) = ''      => 0.0038811817,
               ((real)c_no_labfor < 112.5) => -0.0043942775,
                                              0.0038811817));

N1244_8 :=__common__( map(trim(C_HHSIZE) = ''              => 0.0085454741,
               ((real)c_hhsize < 2.64499998093) => -0.001722274,
                                                   0.0085454741));

N1244_7 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => N1244_9,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.619104623795) => N1244_8,
                                                                      N1244_9));

N1244_6 :=__common__( map(trim(C_WORK_HOME) = ''     => -0.0057990439,
               ((real)c_work_home < 92.5) => N1244_7,
                                             -0.0057990439));

N1244_5 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.271324515343), -0.010262533, N1244_6));

N1244_4 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1244_5, -0.0025946704));

N1244_3 :=__common__( if(((real)c_pop_0_5_p < 12.4499998093), -9.7233318e-006, N1244_4));

N1244_2 :=__common__( if(trim(C_POP_0_5_P) != '', N1244_3, 0.0045020659));

N1244_1 :=__common__( if(((real)r_mos_since_paw_fseen_d > NULL), N1244_2, -0.0018136133));

N1245_10 :=__common__( map(trim(C_RNT250_P) = ''              => -0.0037556266,
                ((real)c_rnt250_p < 6.64999961853) => 0.0070110842,
                                                      -0.0037556266));

N1245_9 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => -0.0038003239,
               ((real)f_add_input_mobility_index_n < 0.283285915852) => 0.00097606748,
                                                                        -0.0038003239));

N1245_8 :=__common__( if(((real)f_rel_under100miles_cnt_d < 19.5), N1245_9, N1245_10));

N1245_7 :=__common__( if(((real)f_rel_under100miles_cnt_d > NULL), N1245_8, -0.0053466369));

N1245_6 :=__common__( if(((real)c_inc_125k_p < 3.34999990463), 0.0016249328, N1245_7));

N1245_5 :=__common__( if(trim(C_INC_125K_P) != '', N1245_6, -0.0018428573));

N1245_4 :=__common__( map(trim(C_POP_75_84_P) = ''     => 0.00065453099,
               ((real)c_pop_75_84_p < 2.75) => 0.0095371772,
                                               0.00065453099));

N1245_3 :=__common__( if(((real)c_born_usa < 182.5), -0.0010978923, N1245_4));

N1245_2 :=__common__( if(trim(C_BORN_USA) != '', N1245_3, -0.012957004));

N1245_1 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1245_2, N1245_5));

N1246_9 :=__common__( if(((real)r_l70_inp_addr_dnd_i > NULL), -0.0029338887, 0.013480551));

N1246_8 :=__common__( map(trim(C_HH2_P) = ''              => N1246_9,
               ((real)c_hh2_p < 32.4500007629) => -0.0089428425,
                                                  N1246_9));

N1246_7 :=__common__( map(trim(C_POP_55_64_P) = ''      => N1246_8,
               ((real)c_pop_55_64_p < 15.25) => -0.00024856123,
                                                N1246_8));

N1246_6 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => -0.0042850763,
               ((real)r_c13_avg_lres_d < 74.5)  => 0.0066263595,
                                                   -0.0042850763));

N1246_5 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N1246_6, 0.0023043882));

N1246_4 :=__common__( if(((real)c_pop_18_24_p < 5.05000019073), N1246_5, N1246_7));

N1246_3 :=__common__( if(trim(C_POP_18_24_P) != '', N1246_4, 0.00016185702));

N1246_2 :=__common__( if(((real)c_mos_since_impulse_ls_d < 28.5), -0.0075654208, N1246_3));

N1246_1 :=__common__( if(((real)c_mos_since_impulse_ls_d > NULL), N1246_2, -0.0056666878));

N1247_8 :=__common__( if(((real)r_c14_addrs_15yr_i < 4.5), -0.0031301873, 0.007275489));

N1247_7 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N1247_8, -0.0013253263));

N1247_6 :=__common__( map(trim(C_POP_0_5_P) = ''              => N1247_7,
               ((real)c_pop_0_5_p < 6.44999980927) => -0.00075723252,
                                                      N1247_7));

N1247_5 :=__common__( map(trim(C_HVAL_250K_P) = ''              => 0.010781663,
               ((real)c_hval_250k_p < 20.6500015259) => 0.0019393152,
                                                        0.010781663));

N1247_4 :=__common__( map(trim(C_EMPLOYEES) = ''      => N1247_5,
               ((real)c_employees < 657.5) => -0.00018859172,
                                              N1247_5));

N1247_3 :=__common__( map(trim(C_POP_85P_P) = ''              => N1247_6,
               ((real)c_pop_85p_p < 2.45000004768) => N1247_4,
                                                      N1247_6));

N1247_2 :=__common__( if(((real)c_pop_35_44_p < 23.6500015259), N1247_3, -0.0057356603));

N1247_1 :=__common__( if(trim(C_POP_35_44_P) != '', N1247_2, 0.0017809134));

N1248_9 :=__common__( map(trim(C_POP_6_11_P) = ''              => 0.0033513023,
               ((real)c_pop_6_11_p < 6.55000019073) => 0.013094374,
                                                       0.0033513023));

N1248_8 :=__common__( map(((real)f_estimated_income_d <= NULL)    => -0.0014641874,
               ((integer)f_estimated_income_d < 37500) => 0.01017566,
                                                          -0.0014641874));

N1248_7 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0672019720078), -0.007076336, 0.0044116757));

N1248_6 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1248_7, -0.034014095));

N1248_5 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)    => N1248_8,
               ((integer)f_curraddrmedianincome_d < 46497) => N1248_6,
                                                              N1248_8));

N1248_4 :=__common__( if(((real)c_bel_edu < 141.5), N1248_5, N1248_9));

N1248_3 :=__common__( if(trim(C_BEL_EDU) != '', N1248_4, 0.0059264468));

N1248_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 42.5), N1248_3, -0.00037655709));

N1248_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N1248_2, 0.0057199889));

N1249_8 :=__common__( map(((real)f_mos_acc_lseen_d <= NULL) => 0.004278658,
               ((real)f_mos_acc_lseen_d < 128.5) => -0.0044568527,
                                                    0.004278658));

N1249_7 :=__common__( map(trim(C_CONSTRUCTION) = ''              => 0.012156122,
               ((real)c_construction < 17.5499992371) => N1249_8,
                                                         0.012156122));

N1249_6 :=__common__( map(trim(C_BLUE_COL) = ''      => -0.0027821562,
               ((real)c_blue_col < 19.25) => N1249_7,
                                             -0.0027821562));

N1249_5 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => -0.0073477964,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.943797707558) => 0.00024420085,
                                                                      -0.0073477964));

N1249_4 :=__common__( map(((real)r_i60_inq_hiriskcred_recency_d <= NULL) => N1249_6,
               ((real)r_i60_inq_hiriskcred_recency_d < 61.5)  => N1249_5,
                                                                 N1249_6));

N1249_3 :=__common__( if(((real)f_inq_highriskcredit_count24_i > NULL), N1249_4, 0.019511455));

N1249_2 :=__common__( if(((real)c_med_yearblt < 1965.5), N1249_3, -0.0011037642));

N1249_1 :=__common__( if(trim(C_MED_YEARBLT) != '', N1249_2, -0.00077979809));

N1250_10 :=__common__( if(((real)c_incollege < 0.25), 0.0067001231, 0.0005175081));

N1250_9 :=__common__( if(trim(C_INCOLLEGE) != '', N1250_10, 0.0021692138));

N1250_8 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i < 4.5), N1250_9, -0.0032272277));

N1250_7 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i > NULL), N1250_8, 0.00026276062));

N1250_6 :=__common__( map(((real)r_c13_curr_addr_lres_d <= NULL) => 0.00973257,
               ((real)r_c13_curr_addr_lres_d < 46.5)  => -0.0011890523,
                                                         0.00973257));

N1250_5 :=__common__( map(trim(C_CARTHEFT) = ''      => 0.012368207,
               ((real)c_cartheft < 163.5) => N1250_6,
                                             0.012368207));

N1250_4 :=__common__( if(((real)c_rnt250_p < 8.85000038147), N1250_5, -0.0026958478));

N1250_3 :=__common__( if(trim(C_RNT250_P) != '', N1250_4, -0.012375011));

N1250_2 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => N1250_3,
               ((real)r_c10_m_hdr_fs_d < 123.5) => -0.0036144066,
                                                   N1250_3));

N1250_1 :=__common__( if(((real)f_college_income_d > NULL), N1250_2, N1250_7));

N1251_8 :=__common__( map(trim(C_RNT500_P) = ''      => -0.0015854466,
               ((real)c_rnt500_p < 12.25) => -0.011712873,
                                             -0.0015854466));

N1251_7 :=__common__( if(((real)f_curraddractivephonelist_d > NULL), N1251_8, 0.039378007));

N1251_6 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => -0.0031515706,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0310646742582) => 0.0055280913,
                                                                       -0.0031515706));

N1251_5 :=__common__( map(trim(C_YOUNG) = ''      => N1251_6,
               ((real)c_young < 21.75) => 0.0048287041,
                                          N1251_6));

N1251_4 :=__common__( map(trim(C_BARGAINS) = ''      => N1251_7,
               ((real)c_bargains < 170.5) => N1251_5,
                                             N1251_7));

N1251_3 :=__common__( if(((real)c_pop_65_74_p < 10.75), N1251_4, -0.0086102103));

N1251_2 :=__common__( if(trim(C_POP_65_74_P) != '', N1251_3, 0.00099940302));

N1251_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N1251_2, 0.00018968216));

N1252_8 :=__common__( map(trim(C_FAMMAR_P) = ''              => -0.00013230861,
               ((real)c_fammar_p < 85.8500061035) => -0.012328902,
                                                     -0.00013230861));

N1252_7 :=__common__( map(trim(C_OLD_HOMES) = ''     => 0.0001140099,
               ((real)c_old_homes < 70.5) => -0.009864347,
                                             0.0001140099));

N1252_6 :=__common__( map(trim(C_INC_125K_P) = ''              => 0.0033738416,
               ((real)c_inc_125k_p < 7.35000038147) => N1252_7,
                                                       0.0033738416));

N1252_5 :=__common__( map(trim(C_FAMMAR_P) = ''              => N1252_8,
               ((real)c_fammar_p < 75.8500061035) => N1252_6,
                                                     N1252_8));

N1252_4 :=__common__( if(((real)c_bigapt_p < 1.34999990463), N1252_5, 0.0049489708));

N1252_3 :=__common__( if(trim(C_BIGAPT_P) != '', N1252_4, -0.0011636344));

N1252_2 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d < 0.961232423782), 0.00054002623, N1252_3));

N1252_1 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d > NULL), N1252_2, 0.0018328713));

N1253_9 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => -0.013944585,
               ((real)f_rel_felony_count_i < 2.5)   => -0.0036552167,
                                                       -0.013944585));

N1253_8 :=__common__( if(((real)c_inc_75k_p < 10.1499996185), 0.0033364919, -0.0045279614));

N1253_7 :=__common__( if(trim(C_INC_75K_P) != '', N1253_8, 0.0057243864));

N1253_6 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N1253_7,
               ((real)f_sourcerisktype_i < 5.5)   => 0.0014348767,
                                                     N1253_7));

N1253_5 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => N1253_9,
               ((real)f_mos_inq_banko_om_fseen_d < 34.5)  => N1253_6,
                                                             N1253_9));

N1253_4 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 38.5), N1253_5, 0.00047266114));

N1253_3 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N1253_4, 0.0077315459));

N1253_2 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d < 0.993327736855), N1253_3, 0.0061551495));

N1253_1 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d > NULL), N1253_2, 0.0049519036));

N1254_9 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => -0.005508386,
               ((real)r_l79_adls_per_addr_curr_i < 4.5)   => 0.0057464944,
                                                             -0.005508386));

N1254_8 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.339584290981), -0.0067665475, -0.00045264124));

N1254_7 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1254_8, -0.0041256734));

N1254_6 :=__common__( map(trim(C_VACANT_P) = ''              => N1254_9,
               ((real)c_vacant_p < 17.0499992371) => N1254_7,
                                                     N1254_9));

N1254_5 :=__common__( map(((real)f_estimated_income_d <= NULL)    => -0.0017043852,
               ((integer)f_estimated_income_d < 30500) => 0.0093676167,
                                                          -0.0017043852));

N1254_4 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.268685936928), N1254_5, N1254_6));

N1254_3 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1254_4, 0.015099968));

N1254_2 :=__common__( if(((real)c_pop_12_17_p < 10.8500003815), 0.00057703487, N1254_3));

N1254_1 :=__common__( if(trim(C_POP_12_17_P) != '', N1254_2, -0.0021421706));

N1255_8 :=__common__( map(trim(C_MURDERS) = ''      => 0.0104448,
               ((integer)c_murders < 57) => 0.00044745729,
                                            0.0104448));

N1255_7 :=__common__( map(trim(C_OLDHOUSE) = ''              => -0.0027910991,
               ((real)c_oldhouse < 380.450012207) => 0.00080466348,
                                                     -0.0027910991));

N1255_6 :=__common__( map(trim(C_HH3_P) = ''              => -0.0065809733,
               ((real)c_hh3_p < 16.9500007629) => 0.0038050546,
                                                  -0.0065809733));

N1255_5 :=__common__( map(trim(C_POPOVER25) = ''       => -0.010586416,
               ((real)c_popover25 < 1110.5) => N1255_6,
                                               -0.010586416));

N1255_4 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d < 37.5), N1255_5, N1255_7));

N1255_3 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d > NULL), N1255_4, 0.0090165078));

N1255_2 :=__common__( if(((real)c_inc_200k_p < 8.75), N1255_3, N1255_8));

N1255_1 :=__common__( if(trim(C_INC_200K_P) != '', N1255_2, 0.00017787638));

N1256_11 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.435608148575), -0.0085816383, 0.0020455871));

N1256_10 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1256_11, -0.0016325601));

N1256_9 :=__common__( if(((real)c_hval_125k_p < 0.449999988079), 0.0027706815, -0.0016044554));

N1256_8 :=__common__( if(trim(C_HVAL_125K_P) != '', N1256_9, -0.0033208157));

N1256_7 :=__common__( if(((real)f_rel_under25miles_cnt_d < 13.5), N1256_8, 0.0018394244));

N1256_6 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N1256_7, -0.00079257804));

N1256_5 :=__common__( if(((real)c_retired2 < 97.5), -0.0077370674, 0.0016775229));

N1256_4 :=__common__( if(trim(C_RETIRED2) != '', N1256_5, -0.0087567105));

N1256_3 :=__common__( map(((real)f_estimated_income_d <= NULL)    => N1256_6,
               ((integer)f_estimated_income_d < 23500) => N1256_4,
                                                          N1256_6));

N1256_2 :=__common__( if(((real)f_curraddrcrimeindex_i < 194.5), N1256_3, N1256_10));

N1256_1 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N1256_2, 0.0014360059));

N1257_7 :=__common__( map(trim(C_HVAL_175K_P) = ''     => 0.002646487,
               ((real)c_hval_175k_p < 3.75) => 0.012357714,
                                               0.002646487));

N1257_6 :=__common__( map(trim(C_POPOVER25) = ''      => -0.0026901627,
               ((real)c_popover25 < 714.5) => 0.0055077608,
                                              -0.0026901627));

N1257_5 :=__common__( map(trim(C_FINANCE) = ''              => N1257_7,
               ((real)c_finance < 6.14999961853) => N1257_6,
                                                    N1257_7));

N1257_4 :=__common__( map(trim(C_ASIAN_LANG) = ''      => 0.0035249784,
               ((real)c_asian_lang < 126.5) => -0.00080133038,
                                               0.0035249784));

N1257_3 :=__common__( map(trim(C_LAR_FAM) = ''      => N1257_4,
               ((real)c_lar_fam < 110.5) => -0.0017942243,
                                            N1257_4));

N1257_2 :=__common__( if(((real)c_professional < 9.55000019073), N1257_3, N1257_5));

N1257_1 :=__common__( if(trim(C_PROFESSIONAL) != '', N1257_2, 0.00017764777));

N1258_8 :=__common__( map(trim(C_HH4_P) = ''              => 8.365135e-005,
               ((real)c_hh4_p < 4.05000019073) => 0.0045599528,
                                                  8.365135e-005));

N1258_7 :=__common__( map(trim(C_HH4_P) = ''               => N1258_8,
               ((real)c_hh4_p < 0.550000011921) => -0.0046496906,
                                                   N1258_8));

N1258_6 :=__common__( map(trim(C_HH1_P) = ''              => -0.00511379,
               ((real)c_hh1_p < 55.6500015259) => N1258_7,
                                                  -0.00511379));

N1258_5 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.004818618,
               ((real)r_c14_addrs_10yr_i < 15.5)  => N1258_6,
                                                     0.004818618));

N1258_4 :=__common__( if(((real)c_asian_lang < 186.5), N1258_5, -0.0058859676));

N1258_3 :=__common__( if(trim(C_ASIAN_LANG) != '', N1258_4, 0.00093389902));

N1258_2 :=__common__( if(((real)f_assocsuspicousidcount_i < 17.5), N1258_3, 0.0060151581));

N1258_1 :=__common__( if(((real)f_assocsuspicousidcount_i > NULL), N1258_2, 0.0023310721));

N1259_10 :=__common__( if(((real)c_med_rent < 383.5), 0.0035264716, -0.0056339509));

N1259_9 :=__common__( if(trim(C_MED_RENT) != '', N1259_10, -0.009737481));

N1259_8 :=__common__( if(((real)f_addrchangeincomediff_d < -3883.5), -0.00076016252, 0.0090405415));

N1259_7 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1259_8, 0.0027719223));

N1259_6 :=__common__( map(trim(C_HH3_P) = ''              => -0.001757037,
               ((real)c_hh3_p < 18.6500015259) => N1259_7,
                                                  -0.001757037));

N1259_5 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => N1259_6,
               ((real)r_c13_avg_lres_d < 21.5)  => 0.010425963,
                                                   N1259_6));

N1259_4 :=__common__( if(((real)c_rich_fam < 109.5), N1259_5, -0.0025759213));

N1259_3 :=__common__( if(trim(C_RICH_FAM) != '', N1259_4, 0.00037494176));

N1259_2 :=__common__( if(((real)r_pb_order_freq_d < 30.5), N1259_3, N1259_9));

N1259_1 :=__common__( if(((real)r_pb_order_freq_d > NULL), N1259_2, -0.00013362324));

N1260_9 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.362751692533), 0.005325343, -0.0017459467));

N1260_8 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1260_9, 0.022254021));

N1260_7 :=__common__( map(((real)f_mos_liens_unrel_sc_fseen_d <= NULL) => N1260_8,
               ((real)f_mos_liens_unrel_sc_fseen_d < 125.5) => 0.011884627,
                                                               N1260_8));

N1260_6 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => -0.0033461569,
               ((real)r_c21_m_bureau_adl_fs_d < 285.5) => N1260_7,
                                                          -0.0033461569));

N1260_5 :=__common__( if(((real)c_newhouse < 156.149993896), -0.00049008492, 0.009140869));

N1260_4 :=__common__( if(trim(C_NEWHOUSE) != '', N1260_5, 0.0036929188));

N1260_3 :=__common__( map(((real)f_historical_count_d <= NULL) => N1260_6,
               ((real)f_historical_count_d < 5.5)   => N1260_4,
                                                       N1260_6));

N1260_2 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 64.5), 0.006496183, N1260_3));

N1260_1 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N1260_2, 0.0027034879));

N1261_10 :=__common__( map(trim(C_REST_INDX) = ''     => 0.00018377149,
                ((real)c_rest_indx < 83.5) => 0.0075728149,
                                              0.00018377149));

N1261_9 :=__common__( map(trim(C_RICH_FAM) = ''      => -0.0062769387,
               ((real)c_rich_fam < 150.5) => N1261_10,
                                             -0.0062769387));

N1261_8 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), 0.0020030369, N1261_9));

N1261_7 :=__common__( map(trim(C_POP_6_11_P) = ''              => N1261_8,
               ((real)c_pop_6_11_p < 4.55000019073) => -0.0057242838,
                                                       N1261_8));

N1261_6 :=__common__( map(((real)f_historical_count_d <= NULL) => -0.0010271804,
               ((real)f_historical_count_d < 2.5)   => N1261_7,
                                                       -0.0010271804));

N1261_5 :=__common__( if(((real)f_curraddrmedianvalue_d < 57541.5), -0.002769958, N1261_6));

N1261_4 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N1261_5, -0.002752799));

N1261_3 :=__common__( if(((real)f_add_input_mobility_index_n < 0.591669142246), N1261_4, 0.0040664492));

N1261_2 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1261_3, -0.033054285));

N1261_1 :=__common__( if(trim(C_LAR_FAM) != '', N1261_2, -0.0048373335));

N1262_6 :=__common__( map(trim(C_RNT250_P) = ''               => -0.0045946123,
               ((real)c_rnt250_p < 0.550000011921) => 0.0026864492,
                                                      -0.0045946123));

N1262_5 :=__common__( map(trim(C_POP_18_24_P) = ''              => 0.012600894,
               ((real)c_pop_18_24_p < 12.0500001907) => 0.0041036769,
                                                        0.012600894));

N1262_4 :=__common__( map(trim(C_WHITE_COL) = ''              => -0.0020097204,
               ((real)c_white_col < 38.0499992371) => N1262_5,
                                                      -0.0020097204));

N1262_3 :=__common__( if(((real)c_unemp < 6.94999980927), N1262_4, N1262_6));

N1262_2 :=__common__( if(trim(C_UNEMP) != '', N1262_3, 0.033339861));

N1262_1 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => N1262_2,
               ((real)r_l79_adls_per_addr_curr_i < 25.5)  => -0.00066962322,
                                                             N1262_2));

N1263_8 :=__common__( map(trim(C_POP_75_84_P) = ''     => -0.0024207103,
               ((real)c_pop_75_84_p < 1.75) => -0.011986426,
                                               -0.0024207103));

N1263_7 :=__common__( map(trim(C_HVAL_125K_P) = ''              => -0.0046371505,
               ((real)c_hval_125k_p < 13.6499996185) => 0.0018155553,
                                                        -0.0046371505));

N1263_6 :=__common__( map(((real)f_inq_highriskcredit_count24_i <= NULL) => N1263_8,
               ((real)f_inq_highriskcredit_count24_i < 1.5)   => N1263_7,
                                                                 N1263_8));

N1263_5 :=__common__( map(((real)f_srchunvrfdphonecount_i <= NULL) => 0.0047701172,
               ((real)f_srchunvrfdphonecount_i < 2.5)   => 0.00025058198,
                                                           0.0047701172));

N1263_4 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i < 165.5), N1263_5, N1263_6));

N1263_3 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N1263_4, 0.0015775629));

N1263_2 :=__common__( if(((real)c_hh1_p < 48.3499984741), N1263_3, 0.0033691236));

N1263_1 :=__common__( if(trim(C_HH1_P) != '', N1263_2, 0.0012347374));

N1264_8 :=__common__( map(trim(C_UNATTACH) = ''      => -0.0094554189,
               ((real)c_unattach < 157.5) => -0.00036132839,
                                             -0.0094554189));

N1264_7 :=__common__( map(trim(C_APT20) = ''      => 0.0067148799,
               ((real)c_apt20 < 178.5) => N1264_8,
                                          0.0067148799));

N1264_6 :=__common__( map(trim(C_NEWHOUSE) = ''              => -0.006934719,
               ((real)c_newhouse < 94.4499969482) => N1264_7,
                                                     -0.006934719));

N1264_5 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)    => 0.0032503541,
               ((integer)f_curraddrmedianincome_d < 32062) => -0.0016164598,
                                                              0.0032503541));

N1264_4 :=__common__( if(((real)f_curraddrburglaryindex_i < 187.5), N1264_5, 0.0065826022));

N1264_3 :=__common__( if(((real)f_curraddrburglaryindex_i > NULL), N1264_4, 0.0047976295));

N1264_2 :=__common__( if(((real)c_fammar18_p < 17.9500007629), N1264_3, N1264_6));

N1264_1 :=__common__( if(trim(C_FAMMAR18_P) != '', N1264_2, 0.0023895684));

N1265_10 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL) => -0.00075339452,
                ((real)r_a50_pb_total_dollars_d < 278.5) => 0.0091436094,
                                                            -0.00075339452));

N1265_9 :=__common__( if(((real)c_pop_35_44_p < 14.3500003815), 0.00041016467, -0.0094781937));

N1265_8 :=__common__( if(trim(C_POP_35_44_P) != '', N1265_9, -0.031291049));

N1265_7 :=__common__( map(((real)f_mos_liens_unrel_cj_lseen_d <= NULL) => 7.6286074e-005,
               ((real)f_mos_liens_unrel_cj_lseen_d < 6.5)   => 0.0049093954,
                                                               7.6286074e-005));

N1265_6 :=__common__( if(((real)c_inc_50k_p < 4.05000019073), -0.0075085289, N1265_7));

N1265_5 :=__common__( if(trim(C_INC_50K_P) != '', N1265_6, -0.0032111522));

N1265_4 :=__common__( if(((real)f_rel_incomeover100_count_d < 1.5), N1265_5, N1265_8));

N1265_3 :=__common__( if(((real)f_rel_incomeover100_count_d > NULL), N1265_4, 0.0041676674));

N1265_2 :=__common__( if(((real)f_inq_collection_count24_i < 2.5), N1265_3, N1265_10));

N1265_1 :=__common__( if(((real)f_inq_collection_count24_i > NULL), N1265_2, -0.0029453628));

N1266_8 :=__common__( map(trim(C_FEMDIV_P) = ''              => -0.0017617434,
               ((real)c_femdiv_p < 4.35000038147) => -0.011153954,
                                                     -0.0017617434));

N1266_7 :=__common__( map(trim(C_WHOLESALE) = ''              => -0.0022777698,
               ((real)c_wholesale < 4.94999980927) => 0.00087790085,
                                                      -0.0022777698));

N1266_6 :=__common__( map(((real)f_liens_unrel_ot_total_amt_i <= NULL)  => -0.0085855866,
               ((real)f_liens_unrel_ot_total_amt_i < 2114.5) => N1266_7,
                                                                -0.0085855866));

N1266_5 :=__common__( if(((real)f_rel_felony_count_i < 6.5), N1266_6, 0.0054884927));

N1266_4 :=__common__( if(((real)f_rel_felony_count_i > NULL), N1266_5, 5.8278811e-005));

N1266_3 :=__common__( map(trim(C_RETIRED) = ''              => N1266_4,
               ((real)c_retired < 1.84999990463) => 0.0075741755,
                                                    N1266_4));

N1266_2 :=__common__( if(((real)c_pop_85p_p < 5.05000019073), N1266_3, N1266_8));

N1266_1 :=__common__( if(trim(C_POP_85P_P) != '', N1266_2, -0.0026914127));

N1267_8 :=__common__( map(trim(C_POP_18_24_P) = ''              => -0.010432232,
               ((real)c_pop_18_24_p < 5.05000019073) => -0.00074162797,
                                                        -0.010432232));

N1267_7 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => 0.0021844775,
               ((real)r_l79_adls_per_addr_curr_i < 14.5)  => N1267_8,
                                                             0.0021844775));

N1267_6 :=__common__( map(trim(C_POP_75_84_P) = ''              => 0.0048950259,
               ((real)c_pop_75_84_p < 7.44999980927) => 0.00012102301,
                                                        0.0048950259));

N1267_5 :=__common__( map(((real)c_dist_input_to_prev_addr_i <= NULL) => -0.00413315,
               ((real)c_dist_input_to_prev_addr_i < 688.5) => N1267_6,
                                                              -0.00413315));

N1267_4 :=__common__( map(trim(C_POP_75_84_P) = ''              => N1267_7,
               ((real)c_pop_75_84_p < 8.94999980927) => N1267_5,
                                                        N1267_7));

N1267_3 :=__common__( if(((integer)f_curraddrmedianvalue_d < 411777), N1267_4, 0.0057037431));

N1267_2 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N1267_3, -0.0029900933));

N1267_1 :=__common__( if(trim(C_POP_75_84_P) != '', N1267_2, -0.00016563192));

N1268_9 :=__common__( if(((real)c_popover25 < 802.5), 0.008646643, -0.0004345115));

N1268_8 :=__common__( if(trim(C_POPOVER25) != '', N1268_9, 0.047103241));

N1268_7 :=__common__( map(trim(C_ASIAN_LANG) = ''      => -0.0079171294,
               ((real)c_asian_lang < 188.5) => 0.00048971729,
                                               -0.0079171294));

N1268_6 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => 0.0068794238,
               ((real)f_add_input_nhood_vac_pct_i < 0.271538078785) => -0.0024899692,
                                                                       0.0068794238));

N1268_5 :=__common__( map(((real)f_corraddrphonecount_d <= NULL) => -0.0082033311,
               ((real)f_corraddrphonecount_d < 0.5)   => N1268_6,
                                                         -0.0082033311));

N1268_4 :=__common__( if(((real)c_easiqlife < 66.5), N1268_5, N1268_7));

N1268_3 :=__common__( if(trim(C_EASIQLIFE) != '', N1268_4, -0.0013997952));

N1268_2 :=__common__( if(((real)r_d34_unrel_liens_ct_i < 8.5), N1268_3, N1268_8));

N1268_1 :=__common__( if(((real)r_d34_unrel_liens_ct_i > NULL), N1268_2, 0.0021367899));

N1269_10 :=__common__( map(trim(C_FOR_SALE) = ''      => 0.013083988,
                ((real)c_for_sale < 133.5) => 0.00065059533,
                                              0.013083988));

N1269_9 :=__common__( map(trim(C_HVAL_40K_P) = ''               => N1269_10,
               ((real)c_hval_40k_p < 0.350000023842) => -0.0019923812,
                                                        N1269_10));

N1269_8 :=__common__( if(((real)c_families < 671.5), -0.0013741979, N1269_9));

N1269_7 :=__common__( if(trim(C_FAMILIES) != '', N1269_8, 0.0073672102));

N1269_6 :=__common__( map(trim(C_POP_12_17_P) = ''              => 0.0015881926,
               ((real)c_pop_12_17_p < 7.55000019073) => 0.010942699,
                                                        0.0015881926));

N1269_5 :=__common__( if(((real)c_hh5_p < 1.34999990463), -0.0046579618, N1269_6));

N1269_4 :=__common__( if(trim(C_HH5_P) != '', N1269_5, -0.014816859));

N1269_3 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1269_4, 0.0022833274));

N1269_2 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.0187259688973), N1269_3, N1269_7));

N1269_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1269_2, 0.0002020349));

N1270_7 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => -0.002485374,
               ((real)r_d32_mos_since_crim_ls_d < 129.5) => 0.0090343052,
                                                            -0.002485374));

N1270_6 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.0091063564,
               ((real)r_c14_addrs_10yr_i < 7.5)   => N1270_7,
                                                     0.0091063564));

N1270_5 :=__common__( map(trim(C_HIGH_ED) = ''              => -0.0077459476,
               ((real)c_high_ed < 13.0500001907) => 0.0018318719,
                                                    -0.0077459476));

N1270_4 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => N1270_6,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.663919329643) => N1270_5,
                                                                      N1270_6));

N1270_3 :=__common__( map(trim(C_INC_50K_P) = ''              => 0.0011534796,
               ((real)c_inc_50k_p < 17.9500007629) => -0.0013822373,
                                                      0.0011534796));

N1270_2 :=__common__( if(((real)c_hval_100k_p < 25.8499984741), N1270_3, N1270_4));

N1270_1 :=__common__( if(trim(C_HVAL_100K_P) != '', N1270_2, -0.003809296));

N1271_8 :=__common__( map(trim(C_CONSTRUCTION) = ''              => 0.0011506752,
               ((real)c_construction < 4.85000038147) => -0.0047202966,
                                                         0.0011506752));

N1271_7 :=__common__( map(trim(C_MED_RENT) = ''      => N1271_8,
               ((real)c_med_rent < 381.5) => 0.0050417933,
                                             N1271_8));

N1271_6 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => 0.0031120856,
               ((real)f_mos_liens_unrel_cj_fseen_d < 144.5) => -0.0085076397,
                                                               0.0031120856));

N1271_5 :=__common__( map(trim(C_TRAILER_P) = ''              => -0.011287611,
               ((real)c_trailer_p < 2.45000004768) => N1271_6,
                                                      -0.011287611));

N1271_4 :=__common__( if(((real)c_occunit_p < 85.25), N1271_5, N1271_7));

N1271_3 :=__common__( if(trim(C_OCCUNIT_P) != '', N1271_4, -0.0054498603));

N1271_2 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 6.5), 0.00053123145, N1271_3));

N1271_1 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N1271_2, 0.00059125602));

N1272_9 :=__common__( map(trim(C_MED_HVAL) = ''          => -0.0024289278,
               ((integer)c_med_hval < 308731) => -0.01325249,
                                                 -0.0024289278));

N1272_8 :=__common__( map(trim(C_WHOLESALE) = ''               => 0.0012230283,
               ((real)c_wholesale < 0.350000023842) => N1272_9,
                                                       0.0012230283));

N1272_7 :=__common__( if(((real)c_lowinc < 47.4500007629), N1272_8, 0.0048192529));

N1272_6 :=__common__( if(trim(C_LOWINC) != '', N1272_7, -0.019824345));

N1272_5 :=__common__( map(((real)r_c20_email_count_i <= NULL) => 0.001805706,
               ((real)r_c20_email_count_i < 1.5)   => -0.0077005068,
                                                      0.001805706));

N1272_4 :=__common__( if(((real)c_span_lang < 179.5), 0.00089824657, N1272_5));

N1272_3 :=__common__( if(trim(C_SPAN_LANG) != '', N1272_4, 0.00078692695));

N1272_2 :=__common__( if(((real)f_wealth_index_d < 3.5), N1272_3, N1272_6));

N1272_1 :=__common__( if(((real)f_wealth_index_d > NULL), N1272_2, -0.006282941));

N1273_9 :=__common__( if(((real)c_hh1_p < 32.8499984741), -0.00013812542, 0.009708482));

N1273_8 :=__common__( if(trim(C_HH1_P) != '', N1273_9, 0.0076746463));

N1273_7 :=__common__( if(((real)f_historical_count_d < 5.5), -0.0016693101, N1273_8));

N1273_6 :=__common__( if(((real)f_historical_count_d > NULL), N1273_7, -0.0061936998));

N1273_5 :=__common__( map(trim(C_CIV_EMP) = ''              => 0.0087108944,
               ((real)c_civ_emp < 62.5499992371) => 0.0016628184,
                                                    0.0087108944));

N1273_4 :=__common__( map(trim(C_ROBBERY) = ''      => -0.0060497153,
               ((real)c_robbery < 189.5) => 0.00020716217,
                                            -0.0060497153));

N1273_3 :=__common__( map(((real)f_addrchangecrimediff_i <= NULL) => N1273_5,
               ((real)f_addrchangecrimediff_i < 22.5)  => N1273_4,
                                                          N1273_5));

N1273_2 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => -0.0053058947,
               ((real)f_srchaddrsrchcount_i < 28.5)  => N1273_3,
                                                        -0.0053058947));

N1273_1 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N1273_2, N1273_6));

ENDMACRO;