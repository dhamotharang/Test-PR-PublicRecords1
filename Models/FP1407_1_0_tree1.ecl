EXPORT FP1407_1_0_tree1 := MACRO

N0_8 :=__common__( map(((real)r_ever_asset_owner_d <= NULL) => -0.65669084,
            ((real)r_ever_asset_owner_d < 0.5)   => -0.63858852,
                                                    -0.65669084));

N0_7 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => -0.58383504,
            ((real)r_d32_felony_count_i < 0.5)   => -0.61858072,
                                                    -0.58383504));

N0_6 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.64772126,
            (segment in ['KMART', 'SEARS FLS'])                => N0_7,
                                                                  -0.64772126));

N0_5 :=__common__( if(((real)c_cpiall < 207.350006104), -0.58937811, N0_6));

N0_4 :=__common__( if(trim(C_CPIALL) != '', N0_5, -0.62960925));

N0_3 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N0_4,
            ((real)f_sourcerisktype_i < 4.5)   => -0.63544434,
                                                  N0_4));

N0_2 :=__common__( if(((integer)r_i60_inq_comm_recency_d < 549), N0_3, N0_8));

N0_1 :=__common__( if(((real)r_i60_inq_comm_recency_d > NULL), N0_2, -0.6231354));

N1_8 :=__common__( if(((real)c_fammar_p < 56.9500007629), 0.021478734, -0.0027126164));

N1_7 :=__common__( if(trim(C_FAMMAR_P) != '', N1_8, -0.0095884242));

N1_6 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => N1_7,
            ((real)r_a50_pb_average_dollars_d < 279.5) => -0.01194577,
                                                          N1_7));

N1_5 :=__common__( map(((real)r_ever_asset_owner_d <= NULL) => -0.020892673,
            ((real)r_ever_asset_owner_d < 0.5)   => N1_6,
                                                    -0.020892673));

N1_4 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.0090098141,
            (segment in ['KMART', 'SEARS FLS'])                => 0.029483105,
                                                                  -0.0090098141));

N1_3 :=__common__( map(((real)r_has_paw_source_d <= NULL) => 0.001481316,
            ((real)r_has_paw_source_d < 0.5)   => N1_4,
                                                  0.001481316));

N1_2 :=__common__( if(((real)r_i60_inq_comm_recency_d < 61.5), N1_3, N1_5));

N1_1 :=__common__( if(((real)r_i60_inq_comm_recency_d > NULL), N1_2, -0.0033647486));

N2_8 :=__common__( if(((real)c_fammar_p < 56.0499992371), 0.010125838, -0.0080568415));

N2_7 :=__common__( if(trim(C_FAMMAR_P) != '', N2_8, -0.014598503));

N2_6 :=__common__( map(((real)r_ever_asset_owner_d <= NULL) => -0.020768554,
            ((real)r_ever_asset_owner_d < 0.5)   => N2_7,
                                                    -0.020768554));

N2_5 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.010357514,
            (segment in ['KMART', 'SEARS FLS'])                => 0.039278744,
                                                                  -0.010357514));

N2_4 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL)  => N2_5,
            ((real)r_a50_pb_average_dollars_d < 2582.5) => 0.013868786,
                                                           N2_5));

N2_3 :=__common__( map(((real)f_estimated_income_d <= NULL)    => 0.0030945169,
            ((integer)f_estimated_income_d < 35500) => N2_4,
                                                       0.0030945169));

N2_2 :=__common__( map(((real)r_i60_inq_comm_recency_d <= NULL) => N2_6,
            ((real)r_i60_inq_comm_recency_d < 61.5)  => N2_3,
                                                        N2_6));

N2_1 :=__common__( if(((real)f_inq_communications_count24_i > NULL), N2_2, -0.0040724286));

N3_8 :=__common__( map(((real)r_has_pb_record_d <= NULL) => -0.012322892,
            ((real)r_has_pb_record_d < 0.5)   => 0.0038614983,
                                                 -0.012322892));

N3_7 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => 0.028921002,
            ((real)r_d32_felony_count_i < 0.5)   => N3_8,
                                                    0.028921002));

N3_6 :=__common__( map(((real)r_ever_asset_owner_d <= NULL) => -0.020330859,
            ((real)r_ever_asset_owner_d < 0.5)   => N3_7,
                                                    -0.020330859));

N3_5 :=__common__( if(((real)c_cpiall < 208.5), 0.038678637, 0.016383786));

N3_4 :=__common__( if(trim(C_CPIALL) != '', N3_5, 0.025255499));

N3_3 :=__common__( map(((real)r_has_paw_source_d <= NULL) => 0.0017639946,
            ((real)r_has_paw_source_d < 0.5)   => N3_4,
                                                  0.0017639946));

N3_2 :=__common__( if(((real)r_i60_inq_comm_recency_d < 61.5), N3_3, N3_6));

N3_1 :=__common__( if(((real)r_i60_inq_comm_recency_d > NULL), N3_2, -0.013024905));

N4_8 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => -0.00048243415,
            ((real)f_sourcerisktype_i < 5.5)   => -0.017533623,
                                                  -0.00048243415));

N4_7 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.012919771,
            ((real)f_sourcerisktype_i < 5.5)   => -0.0048446506,
                                                  0.012919771));

N4_6 :=__common__( if(((real)c_cpiall < 208.5), 0.045003643, 0.020285551));

N4_5 :=__common__( if(trim(C_CPIALL) != '', N4_6, 0.025621756));

N4_4 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL)  => N4_5,
            ((integer)r_a50_pb_average_dollars_d < 520) => 0.0098304318,
                                                           N4_5));

N4_3 :=__common__( map(((real)f_estimated_income_d <= NULL)    => N4_7,
            ((integer)f_estimated_income_d < 32500) => N4_4,
                                                       N4_7));

N4_2 :=__common__( if(((integer)r_i60_inq_comm_recency_d < 549), N4_3, N4_8));

N4_1 :=__common__( if(((real)r_i60_inq_comm_recency_d > NULL), N4_2, 0.0064401567));

N5_8 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL)  => 0.02897199,
            ((integer)r_a50_pb_average_dollars_d < 344) => 0.0088141008,
                                                           0.02897199));

N5_7 :=__common__( if(((real)r_pb_order_freq_d > NULL), -0.003092118, 0.0160617));

N5_6 :=__common__( if(((real)c_fammar_p < 60.9500007629), N5_7, -0.0088098679));

N5_5 :=__common__( if(trim(C_FAMMAR_P) != '', N5_6, -0.0082324995));

N5_4 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => 0.028960946,
            ((real)r_d32_felony_count_i < 0.5)   => N5_5,
                                                    0.028960946));

N5_3 :=__common__( map(((real)r_ever_asset_owner_d <= NULL) => -0.018058359,
            ((real)r_ever_asset_owner_d < 0.5)   => N5_4,
                                                    -0.018058359));

N5_2 :=__common__( if(((real)f_inq_communications_count24_i < 1.5), N5_3, N5_8));

N5_1 :=__common__( if(((real)f_inq_communications_count24_i > NULL), N5_2, -0.0012944591));

N6_8 :=__common__( map(((real)r_i60_inq_comm_recency_d <= NULL)  => -0.0092412296,
            ((integer)r_i60_inq_comm_recency_d < 549) => 0.0059174061,
                                                         -0.0092412296));

N6_7 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => 0.026600353,
            ((real)r_d32_felony_count_i < 0.5)   => N6_8,
                                                    0.026600353));

N6_6 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL)  => 0.038823429,
            ((integer)r_a50_pb_average_dollars_d < 385) => 0.013591487,
                                                           0.038823429));

N6_5 :=__common__( map((segment in ['RETAIL', 'SEARS SHO'])              => -0.01114523,
            (segment in ['KMART', 'SEARS AUTO', 'SEARS FLS']) => N6_6,
                                                                 N6_6));

N6_4 :=__common__( if(((real)c_cpiall < 208.5), N6_5, N6_7));

N6_3 :=__common__( if(trim(C_CPIALL) != '', N6_4, -0.0081936757));

N6_2 :=__common__( if(((real)r_ever_asset_owner_d < 0.5), N6_3, -0.014761531));

N6_1 :=__common__( if(((real)r_ever_asset_owner_d > NULL), N6_2, 0.0023893453));

N7_8 :=__common__( if(((real)c_fammar_p < 50.25), 0.013409226, -0.0069943189));

N7_7 :=__common__( if(trim(C_FAMMAR_P) != '', N7_8, -0.0076594055));

N7_6 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.016226802,
            ((real)c_comb_age_d < 37.5)  => N7_7,
                                            -0.016226802));

N7_5 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => 0.019095634,
            ((real)r_d32_felony_count_i < 0.5)   => N7_6,
                                                    0.019095634));

N7_4 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => 0.0065006148,
            ((real)f_corrssnaddrcount_d < 3.5)   => 0.024553817,
                                                    0.0065006148));

N7_3 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.013423043,
            (segment in ['KMART', 'SEARS FLS'])                => N7_4,
                                                                  -0.013423043));

N7_2 :=__common__( if(((real)r_i60_inq_comm_recency_d < 61.5), N7_3, N7_5));

N7_1 :=__common__( if(((real)r_i60_inq_comm_recency_d > NULL), N7_2, -0.00032563188));

N8_8 :=__common__( if(((real)c_fammar_p < 46.3499984741), 0.016489886, -0.0071947032));

N8_7 :=__common__( if(trim(C_FAMMAR_P) != '', N8_8, -0.020326544));

N8_6 :=__common__( if(((real)r_pb_order_freq_d > NULL), -0.017945769, N8_7));

N8_5 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => 0.0086140359,
            ((real)f_corrssnaddrcount_d < 3.5)   => 0.026055963,
                                                    0.0086140359));

N8_4 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.013924201,
            (segment in ['KMART', 'SEARS FLS'])                => N8_5,
                                                                  -0.013924201));

N8_3 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N8_4,
            ((real)f_sourcerisktype_i < 4.5)   => -0.0029916442,
                                                  N8_4));

N8_2 :=__common__( if(((integer)r_i60_inq_comm_recency_d < 549), N8_3, N8_6));

N8_1 :=__common__( if(((real)r_i60_inq_comm_recency_d > NULL), N8_2, -0.0027473008));

N9_9 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => -0.00069972188,
            ((integer)r_i60_inq_auto_recency_d < 549) => -0.015611045,
                                                         -0.00069972188));

N9_8 :=__common__( if(((real)f_varrisktype_i < 4.5), N9_9, 0.017146427));

N9_7 :=__common__( if(((real)f_varrisktype_i > NULL), N9_8, 0.0093030501));

N9_6 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => 0.032848042,
            ((integer)r_i60_inq_auto_recency_d < 549) => 0.0020150129,
                                                         0.032848042));

N9_5 :=__common__( if(((real)r_a50_pb_average_dollars_d < 310.5), 0.0068499113, N9_6));

N9_4 :=__common__( if(((real)r_a50_pb_average_dollars_d > NULL), N9_5, 0.035755623));

N9_3 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.01333312,
            (segment in ['KMART', 'SEARS FLS'])                => N9_4,
                                                                  -0.01333312));

N9_2 :=__common__( if(((real)c_fammar_p < 47.5499992371), N9_3, N9_7));

N9_1 :=__common__( if(trim(C_FAMMAR_P) != '', N9_2, -0.0080369772));

N10_7 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => 0.029177162,
             ((real)r_d32_felony_count_i < 0.5)   => 0.0062415217,
                                                     0.029177162));

N10_6 :=__common__( if(((real)c_cpiall < 207.350006104), 0.033268704, N10_7));

N10_5 :=__common__( if(trim(C_CPIALL) != '', N10_6, -0.0018213036));

N10_4 :=__common__( map(((real)f_estimated_income_d <= NULL)    => -0.0076592958,
             ((integer)f_estimated_income_d < 29500) => 0.0082399695,
                                                        -0.0076592958));

N10_3 :=__common__( if(((real)f_corrrisktype_i < 5.5), N10_4, N10_5));

N10_2 :=__common__( if(((real)f_corrrisktype_i > NULL), N10_3, 0.014793763));

N10_1 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.018430898,
             (segment in ['KMART', 'SEARS FLS'])                => N10_2,
                                                                   -0.018430898));

N11_8 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => 0.03052662,
             ((real)r_d32_felony_count_i < 0.5)   => 0.0037423083,
                                                     0.03052662));

N11_7 :=__common__( map(((real)c_comb_age_d <= NULL) => N11_8,
             ((real)c_comb_age_d < 31.5)  => 0.02461212,
                                             N11_8));

N11_6 :=__common__( map((segment in ['RETAIL', 'SEARS SHO'])              => -0.012604746,
             (segment in ['KMART', 'SEARS AUTO', 'SEARS FLS']) => 0.023825342,
                                                                  0.023825342));

N11_5 :=__common__( if(((real)c_fammar_p < 56.0499992371), N11_6, -0.00080050225));

N11_4 :=__common__( if(trim(C_FAMMAR_P) != '', N11_5, -0.012123155));

N11_3 :=__common__( map(((real)f_corrrisktype_i <= NULL) => N11_4,
             ((real)f_corrrisktype_i < 6.5)   => -0.0077211068,
                                                 N11_4));

N11_2 :=__common__( if(((real)f_inq_communications_count24_i < 1.5), N11_3, N11_7));

N11_1 :=__common__( if(((real)f_inq_communications_count24_i > NULL), N11_2, 0.0055513594));

N12_8 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.0054597174,
             ((real)c_easiqlife < 102.5) => -0.0099146377,
                                            0.0054597174));

N12_7 :=__common__( map(((real)f_srchunvrfdaddrcount_i <= NULL) => 0.025691359,
             ((real)f_srchunvrfdaddrcount_i < 0.5)   => N12_8,
                                                        0.025691359));

N12_6 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N12_7,
             ((real)f_sourcerisktype_i < 5.5)   => -0.010004177,
                                                   N12_7));

N12_5 :=__common__( map(((real)c_comb_age_d <= NULL) => 0.0060960944,
             ((real)c_comb_age_d < 30.5)  => 0.02595602,
                                             0.0060960944));

N12_4 :=__common__( map(trim(C_CPIALL) = ''      => N12_6,
             ((real)c_cpiall < 208.5) => N12_5,
                                         N12_6));

N12_3 :=__common__( if(((real)r_d32_felony_count_i < 0.5), N12_4, 0.022935524));

N12_2 :=__common__( if(((real)r_d32_felony_count_i > NULL), N12_3, 0.003951699));

N12_1 :=__common__( if(trim(C_FAMMAR_P) != '', N12_2, -0.0042223934));

N13_8 :=__common__( map(((real)r_prop_owner_history_d <= NULL) => -0.002264233,
             ((real)r_prop_owner_history_d < 0.5)   => 0.018035504,
                                                       -0.002264233));

N13_7 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => 0.020488329,
             ((integer)r_i60_inq_auto_recency_d < 549) => -0.0030501168,
                                                          0.020488329));

N13_6 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.013950827,
             (segment in ['KMART', 'SEARS FLS'])                => N13_7,
                                                                   -0.013950827));

N13_5 :=__common__( if(((real)c_fammar_p < 66.75), N13_6, -0.0045896328));

N13_4 :=__common__( if(trim(C_FAMMAR_P) != '', N13_5, -0.0054614255));

N13_3 :=__common__( if(((real)r_pb_order_freq_d > NULL), -0.0086460473, N13_4));

N13_2 :=__common__( if(((real)f_inq_communications_count24_i < 1.5), N13_3, N13_8));

N13_1 :=__common__( if(((real)f_inq_communications_count24_i > NULL), N13_2, -0.00046643932));

N14_8 :=__common__( map(trim(C_CPIALL) = ''              => 0.01714546,
             ((real)c_cpiall < 207.350006104) => 0.037682011,
                                                 0.01714546));

N14_7 :=__common__( if(((real)c_no_car < 156.5), 0.006373854, N14_8));

N14_6 :=__common__( if(trim(C_NO_CAR) != '', N14_7, -0.0019552708));

N14_5 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL)   => N14_6,
             ((real)r_a50_pb_total_dollars_d < 10000.5) => -0.0015898071,
                                                           N14_6));

N14_4 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.016861464,
             (segment in ['KMART', 'SEARS FLS'])                => N14_5,
                                                                   -0.016861464));

N14_3 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => N14_4,
             ((integer)r_i60_inq_auto_recency_d < 549) => -0.010798595,
                                                          N14_4));

N14_2 :=__common__( if(((real)f_srchunvrfdaddrcount_i < 0.5), N14_3, 0.020141611));

N14_1 :=__common__( if(((real)f_srchunvrfdaddrcount_i > NULL), N14_2, 0.0072155925));

N15_8 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => 0.021113376,
             ((integer)r_i60_inq_auto_recency_d < 549) => 0.0028838111,
                                                          0.021113376));

N15_7 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.0036938323,
             ((real)f_sourcerisktype_i < 5.5)   => -0.0088803082,
                                                   0.0036938323));

N15_6 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => 0.017554671,
             ((real)r_d32_felony_count_i < 0.5)   => N15_7,
                                                     0.017554671));

N15_5 :=__common__( map(trim(C_UNEMP) = ''              => 0.016452716,
             ((real)c_unemp < 9.35000038147) => N15_6,
                                                0.016452716));

N15_4 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => N15_5,
             ((integer)r_i60_inq_auto_recency_d < 549) => -0.012527902,
                                                          N15_5));

N15_3 :=__common__( if(trim(C_UNEMP) != '', N15_4, -0.003286042));

N15_2 :=__common__( if(((real)f_varrisktype_i < 3.5), N15_3, N15_8));

N15_1 :=__common__( if(((real)f_varrisktype_i > NULL), N15_2, -0.0044528388));

N16_9 :=__common__( map(((real)r_i60_inq_comm_recency_d <= NULL)  => -0.0055341935,
             ((integer)r_i60_inq_comm_recency_d < 549) => 0.0094920717,
                                                          -0.0055341935));

N16_8 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N16_9,
             ((real)f_sourcerisktype_i < 5.5)   => -0.0094246527,
                                                   N16_9));

N16_7 :=__common__( if(((real)r_d32_felony_count_i < 0.5), N16_8, 0.017104907));

N16_6 :=__common__( if(((real)r_d32_felony_count_i > NULL), N16_7, 0.00441059));

N16_5 :=__common__( map(trim(C_NO_CAR) = ''      => 0.027583189,
             ((real)c_no_car < 138.5) => 0.0076681884,
                                         0.027583189));

N16_4 :=__common__( if(((real)r_d31_mostrec_bk_i < 1.5), N16_5, -0.0042834558));

N16_3 :=__common__( if(((real)r_d31_mostrec_bk_i > NULL), N16_4, 0.006722791));

N16_2 :=__common__( if(((real)c_cpiall < 208.5), N16_3, N16_6));

N16_1 :=__common__( if(trim(C_CPIALL) != '', N16_2, -0.0063385218));

N17_8 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => 0.00067192144,
             ((real)f_curraddrmedianincome_d < 33944.5) => 0.013105258,
                                                           0.00067192144));

N17_7 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => 0.021577647,
             ((real)r_d32_felony_count_i < 0.5)   => N17_8,
                                                     0.021577647));

N17_6 :=__common__( if(((real)c_cpiall < 209.300003052), 0.023281236, N17_7));

N17_5 :=__common__( if(trim(C_CPIALL) != '', N17_6, 0.0013847735));

N17_4 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.01385114,
             (segment in ['KMART', 'SEARS FLS'])                => N17_5,
                                                                   -0.01385114));

N17_3 :=__common__( map(((real)f_srchunvrfdssncount_i <= NULL) => 0.0062646269,
             ((real)f_srchunvrfdssncount_i < 0.5)   => -0.0081741488,
                                                       0.0062646269));

N17_2 :=__common__( if(((real)f_corrrisktype_i < 5.5), N17_3, N17_4));

N17_1 :=__common__( if(((real)f_corrrisktype_i > NULL), N17_2, -0.0003952366));

N18_8 :=__common__( map(((real)r_d31_mostrec_bk_i <= NULL) => -0.004088615,
             ((real)r_d31_mostrec_bk_i < 1.5)   => 0.017863781,
                                                   -0.004088615));

N18_7 :=__common__( map((segment in ['RETAIL', 'SEARS SHO'])              => -0.010274704,
             (segment in ['KMART', 'SEARS AUTO', 'SEARS FLS']) => N18_8,
                                                                  N18_8));

N18_6 :=__common__( if(((real)c_unemp < 6.14999961853), -0.0030448254, 0.010433791));

N18_5 :=__common__( if(trim(C_UNEMP) != '', N18_6, -0.0040878801));

N18_4 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => 0.02750677,
             ((real)r_d32_felony_count_i < 0.5)   => N18_5,
                                                     0.02750677));

N18_3 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => -0.0076010799,
             ((real)r_c12_num_nonderogs_d < 6.5)   => N18_4,
                                                      -0.0076010799));

N18_2 :=__common__( if(((real)f_srchunvrfdssncount_i < 0.5), N18_3, N18_7));

N18_1 :=__common__( if(((real)f_srchunvrfdssncount_i > NULL), N18_2, 0.00085340999));

N19_9 :=__common__( if(((real)f_varrisktype_i < 2.5), -0.0095884926, 0.0028794036));

N19_8 :=__common__( if(((real)f_varrisktype_i > NULL), N19_9, -0.025962515));

N19_7 :=__common__( map(trim(C_CPIALL) = ''              => 0.018004169,
             ((real)c_cpiall < 207.350006104) => 0.032623634,
                                                 0.018004169));

N19_6 :=__common__( if(((real)f_corrrisktype_i < 6.5), 0.0083917177, N19_7));

N19_5 :=__common__( if(((real)f_corrrisktype_i > NULL), N19_6, 0.024098593));

N19_4 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.011979643,
             (segment in ['KMART', 'SEARS FLS'])                => N19_5,
                                                                   -0.011979643));

N19_3 :=__common__( map(((real)r_has_paw_source_d <= NULL) => -0.0032086671,
             ((real)r_has_paw_source_d < 0.5)   => N19_4,
                                                   -0.0032086671));

N19_2 :=__common__( if(((real)c_fammar_p < 64.9499969482), N19_3, N19_8));

N19_1 :=__common__( if(trim(C_FAMMAR_P) != '', N19_2, -0.0065801874));

N20_8 :=__common__( if(((real)c_cpiall < 207.350006104), 0.028893422, 0.012324755));

N20_7 :=__common__( if(trim(C_CPIALL) != '', N20_8, -0.003297694));

N20_6 :=__common__( map(((real)f_estimated_income_d <= NULL)    => -0.0046750306,
             ((integer)f_estimated_income_d < 33500) => 0.0086752945,
                                                        -0.0046750306));

N20_5 :=__common__( map(((real)f_corrrisktype_i <= NULL) => N20_7,
             ((real)f_corrrisktype_i < 6.5)   => N20_6,
                                                 N20_7));

N20_4 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.015031337,
             (segment in ['KMART', 'SEARS FLS'])                => N20_5,
                                                                   -0.015031337));

N20_3 :=__common__( map(((real)f_varrisktype_i <= NULL) => 0.015511129,
             ((real)f_varrisktype_i < 6.5)   => -0.010687728,
                                                0.015511129));

N20_2 :=__common__( if(((integer)r_i60_inq_auto_recency_d < 549), N20_3, N20_4));

N20_1 :=__common__( if(((real)r_i60_inq_auto_recency_d > NULL), N20_2, -0.0031363886));

N21_7 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.017497666,
             ((real)f_sourcerisktype_i < 5.5)   => 0.0059386715,
                                                   0.017497666));

N21_6 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => 0.02004028,
             ((real)r_d32_felony_count_i < 0.5)   => -0.0018403029,
                                                     0.02004028));

N21_5 :=__common__( map(((real)f_corrrisktype_i <= NULL) => 0.013466978,
             ((real)f_corrrisktype_i < 6.5)   => N21_6,
                                                 0.013466978));

N21_4 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.014715009,
             (segment in ['KMART', 'SEARS FLS'])                => N21_5,
                                                                   -0.014715009));

N21_3 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL)   => N21_4,
             ((integer)r_a50_pb_average_dollars_d < 2791) => -0.0083650096,
                                                             N21_4));

N21_2 :=__common__( if(((real)f_inq_communications_count24_i < 1.5), N21_3, N21_7));

N21_1 :=__common__( if(((real)f_inq_communications_count24_i > NULL), N21_2, -0.00060101496));

N22_9 :=__common__( map(((real)f_attr_arrest_recency_d <= NULL) => -0.0076306241,
             ((real)f_attr_arrest_recency_d < 99.5)  => 0.017274612,
                                                        -0.0076306241));

N22_8 :=__common__( if(((real)f_varrisktype_i < 4.5), N22_9, 0.010239312));

N22_7 :=__common__( if(((real)f_varrisktype_i > NULL), N22_8, -0.012450746));

N22_6 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.011352218,
             (segment in ['KMART', 'SEARS FLS'])                => 0.014825065,
                                                                   -0.011352218));

N22_5 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.0015167392,
             ((real)c_comb_age_d < 32.5)  => N22_6,
                                             -0.0015167392));

N22_4 :=__common__( if(((real)r_d32_felony_count_i < 0.5), N22_5, 0.02358217));

N22_3 :=__common__( if(((real)r_d32_felony_count_i > NULL), N22_4, 0.0022985046));

N22_2 :=__common__( if(((real)c_fammar_p < 58.9500007629), N22_3, N22_7));

N22_1 :=__common__( if(trim(C_FAMMAR_P) != '', N22_2, -0.0044974378));

N23_10 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i < 1.5), -0.0034758383, 0.0082981077));

N23_9 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i > NULL), N23_10, -0.0029820343));

N23_8 :=__common__( map(((real)f_estimated_income_d <= NULL)    => 0.0064827218,
             ((integer)f_estimated_income_d < 34500) => 0.020259338,
                                                        0.0064827218));

N23_7 :=__common__( if(((real)c_fammar_p < 50.25), N23_8, N23_9));

N23_6 :=__common__( if(trim(C_FAMMAR_P) != '', N23_7, -0.0018015585));

N23_5 :=__common__( if(((real)c_unemp < 7.75), -0.0026575438, 0.011452323));

N23_4 :=__common__( if(trim(C_UNEMP) != '', N23_5, -0.0075176929));

N23_3 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL)  => N23_4,
             ((integer)r_a50_pb_average_dollars_d < 346) => -0.010074632,
                                                            N23_4));

N23_2 :=__common__( if(((real)r_c14_addrs_5yr_i < 3.5), N23_3, N23_6));

N23_1 :=__common__( if(((real)r_c14_addrs_5yr_i > NULL), N23_2, 0.00092444828));

N24_8 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.01976859,
             ((real)f_rel_felony_count_i < 1.5)   => 0.002417697,
                                                     0.01976859));

N24_7 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N24_8,
             ((real)f_sourcerisktype_i < 5.5)   => -0.0046945003,
                                                   N24_8));

N24_6 :=__common__( if(((real)c_cpiall < 208.5), 0.014448268, N24_7));

N24_5 :=__common__( if(trim(C_CPIALL) != '', N24_6, -0.0052893476));

N24_4 :=__common__( map(((real)f_srchunvrfdaddrcount_i <= NULL) => 0.020531601,
             ((real)f_srchunvrfdaddrcount_i < 0.5)   => N24_5,
                                                        0.020531601));

N24_3 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.0141027,
             (segment in ['KMART', 'SEARS FLS'])                => N24_4,
                                                                   -0.0141027));

N24_2 :=__common__( if(((real)r_d31_mostrec_bk_i < 1.5), N24_3, -0.012909315));

N24_1 :=__common__( if(((real)r_d31_mostrec_bk_i > NULL), N24_2, 0.00192137));

N25_9 :=__common__( if(((real)c_unemp < 7.94999980927), 0.010497432, 0.026255727));

N25_8 :=__common__( if(trim(C_UNEMP) != '', N25_9, 0.0010410678));

N25_7 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL)  => -0.0073772568,
             ((integer)r_d33_eviction_recency_d < 549) => 0.0031519172,
                                                          -0.0073772568));

N25_6 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => 0.013697162,
             ((real)f_srchfraudsrchcount_i < 7.5)   => -0.0052017508,
                                                       0.013697162));

N25_5 :=__common__( if(((real)c_unemp < 6.25), N25_6, 0.014720416));

N25_4 :=__common__( if(trim(C_UNEMP) != '', N25_5, 0.013204292));

N25_3 :=__common__( map(((real)c_comb_age_d <= NULL) => N25_7,
             ((real)c_comb_age_d < 28.5)  => N25_4,
                                             N25_7));

N25_2 :=__common__( if(((real)r_d32_felony_count_i < 0.5), N25_3, N25_8));

N25_1 :=__common__( if(((real)r_d32_felony_count_i > NULL), N25_2, -0.011692889));

N26_8 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL)  => 0.014919659,
             ((real)r_a50_pb_total_dollars_d < 7464.5) => 0.0038357917,
                                                          0.014919659));

N26_7 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.0016707121,
             ((real)c_comb_age_d < 41.5)  => 0.014177707,
                                             -0.0016707121));

N26_6 :=__common__( map(((real)f_attr_arrest_recency_d <= NULL) => -0.0032343672,
             ((real)f_attr_arrest_recency_d < 99.5)  => 0.019694559,
                                                        -0.0032343672));

N26_5 :=__common__( if(((real)c_unemp < 7.14999961853), N26_6, N26_7));

N26_4 :=__common__( if(trim(C_UNEMP) != '', N26_5, -0.0087324191));

N26_3 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => N26_4,
             ((real)r_a50_pb_average_dollars_d < 310.5) => -0.0080337166,
                                                           N26_4));

N26_2 :=__common__( if(((real)f_srchunvrfdssncount_i < 0.5), N26_3, N26_8));

N26_1 :=__common__( if(((real)f_srchunvrfdssncount_i > NULL), N26_2, -0.0037386747));

N27_8 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.0052429813,
             (segment in ['KMART', 'SEARS FLS'])                => 0.016705137,
                                                                   -0.0052429813));

N27_7 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL)   => N27_8,
             ((integer)r_a50_pb_total_dollars_d < 6051) => 0.0035918554,
                                                           N27_8));

N27_6 :=__common__( map(((real)f_attr_arrests_i <= NULL) => 0.0206631,
             ((real)f_attr_arrests_i < 0.5)   => -0.0015299181,
                                                 0.0206631));

N27_5 :=__common__( if(((real)c_fammar_p < 39.4500007629), 0.0127544, N27_6));

N27_4 :=__common__( if(trim(C_FAMMAR_P) != '', N27_5, -0.0017908725));

N27_3 :=__common__( map(((real)f_corrphonelastnamecount_d <= NULL) => -0.008345765,
             ((real)f_corrphonelastnamecount_d < 0.5)   => N27_4,
                                                           -0.008345765));

N27_2 :=__common__( if(((real)f_inq_communications_count24_i < 1.5), N27_3, N27_7));

N27_1 :=__common__( if(((real)f_inq_communications_count24_i > NULL), N27_2, 0.0020448505));

N28_7 :=__common__( map(((real)f_corrrisktype_i <= NULL) => 0.00069179922,
             ((real)f_corrrisktype_i < 6.5)   => -0.0091288921,
                                                 0.00069179922));

N28_6 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.0069713744,
             ((real)f_rel_felony_count_i < 2.5)   => N28_7,
                                                     0.0069713744));

N28_5 :=__common__( map(((real)f_varrisktype_i <= NULL) => 0.019966109,
             ((real)f_varrisktype_i < 6.5)   => N28_6,
                                                0.019966109));

N28_4 :=__common__( map(((real)f_varrisktype_i <= NULL) => 0.014521109,
             ((real)f_varrisktype_i < 2.5)   => 0.0037506315,
                                                0.014521109));

N28_3 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => 0.024841505,
             ((real)r_d32_felony_count_i < 0.5)   => N28_4,
                                                     0.024841505));

N28_2 :=__common__( if(((integer)f_estimated_income_d < 28500), N28_3, N28_5));

N28_1 :=__common__( if(((real)f_estimated_income_d > NULL), N28_2, 0.00040449902));

N29_8 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL)  => 0.019520729,
             ((integer)r_a50_pb_average_dollars_d < 274) => 0.0041574576,
                                                            0.019520729));

N29_7 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.0021161447,
             ((real)r_c14_addrs_10yr_i < 8.5)   => -0.0091585921,
                                                   0.0021161447));

N29_6 :=__common__( if(((real)c_fammar_p < 45.9500007629), 0.0115257, -0.00014187561));

N29_5 :=__common__( if(trim(C_FAMMAR_P) != '', N29_6, -0.0025451094));

N29_4 :=__common__( map(((real)c_comb_age_d <= NULL) => N29_7,
             ((real)c_comb_age_d < 32.5)  => N29_5,
                                             N29_7));

N29_3 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => 0.011475523,
             ((real)r_d32_felony_count_i < 0.5)   => N29_4,
                                                     0.011475523));

N29_2 :=__common__( if(((real)f_srchunvrfdaddrcount_i < 0.5), N29_3, N29_8));

N29_1 :=__common__( if(((real)f_srchunvrfdaddrcount_i > NULL), N29_2, 0.0028799768));

N30_8 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => 0.025903112,
             ((real)r_d32_felony_count_i < 0.5)   => 0.010859612,
                                                     0.025903112));

N30_7 :=__common__( if(((real)r_c10_m_hdr_fs_d < 283.5), N30_8, -0.0021717085));

N30_6 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N30_7, -0.0013034586));

N30_5 :=__common__( if(((integer)r_i60_inq_comm_recency_d < 549), 0.0034608379, -0.0073447782));

N30_4 :=__common__( if(((real)r_i60_inq_comm_recency_d > NULL), N30_5, 0.011068406));

N30_3 :=__common__( if(((real)c_unemp < 7.14999961853), N30_4, N30_6));

N30_2 :=__common__( if(trim(C_UNEMP) != '', N30_3, 0.0022895148));

N30_1 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.014308011,
             (segment in ['KMART', 'SEARS FLS'])                => N30_2,
                                                                   -0.014308011));

N31_8 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.015722664,
             ((real)f_sourcerisktype_i < 5.5)   => 0.0016733739,
                                                   0.015722664));

N31_7 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => 0.01270738,
             ((real)f_add_curr_nhood_vac_pct_i < 0.209728047252) => -0.0048061305,
                                                                    0.01270738));

N31_6 :=__common__( map(((real)c_comb_age_d <= NULL) => N31_7,
             ((real)c_comb_age_d < 30.5)  => 0.0095758827,
                                             N31_7));

N31_5 :=__common__( if(((real)c_unemp < 7.05000019073), -0.0067249714, N31_6));

N31_4 :=__common__( if(trim(C_UNEMP) != '', N31_5, -0.0033869791));

N31_3 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => N31_8,
             ((real)f_rel_felony_count_i < 1.5)   => N31_4,
                                                     N31_8));

N31_2 :=__common__( if(((real)f_attr_arrests_i < 0.5), N31_3, 0.019557184));

N31_1 :=__common__( if(((real)f_attr_arrests_i > NULL), N31_2, -0.0083515724));

N32_8 :=__common__( map(trim(C_LOWINC) = ''              => 0.010884651,
             ((real)c_lowinc < 70.9499969482) => -0.0040337195,
                                                 0.010884651));

N32_7 :=__common__( map(((real)f_varrisktype_i <= NULL) => 0.0098272531,
             ((real)f_varrisktype_i < 4.5)   => N32_8,
                                                0.0098272531));

N32_6 :=__common__( map(((real)f_attr_arrests_i <= NULL) => 0.017886729,
             ((real)f_attr_arrests_i < 0.5)   => N32_7,
                                                 0.017886729));

N32_5 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.025630096,
             ((real)r_d32_criminal_count_i < 1.5)   => 0.0082197861,
                                                       0.025630096));

N32_4 :=__common__( if(((real)c_cpiall < 208.5), N32_5, N32_6));

N32_3 :=__common__( if(trim(C_CPIALL) != '', N32_4, -0.0017143002));

N32_2 :=__common__( if(((real)r_d31_mostrec_bk_i < 1.5), N32_3, -0.011161209));

N32_1 :=__common__( if(((real)r_d31_mostrec_bk_i > NULL), N32_2, -0.010922966));

N33_8 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.018529822,
             ((real)f_sourcerisktype_i < 4.5)   => 0.0039611707,
                                                   0.018529822));

N33_7 :=__common__( if(((real)c_construction < 0.550000011921), 0.011426715, -0.0006941449));

N33_6 :=__common__( if(trim(C_CONSTRUCTION) != '', N33_7, -0.010501767));

N33_5 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => N33_8,
             ((real)f_srchfraudsrchcount_i < 3.5)   => N33_6,
                                                       N33_8));

N33_4 :=__common__( map(((real)r_c20_email_domain_isp_count_i <= NULL) => -0.0025489284,
             ((real)r_c20_email_domain_isp_count_i < 0.5)   => N33_5,
                                                               -0.0025489284));

N33_3 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.013449404,
             (segment in ['KMART', 'SEARS FLS'])                => N33_4,
                                                                   -0.013449404));

N33_2 :=__common__( if(((integer)r_i60_inq_auto_recency_d < 549), -0.0068549149, N33_3));

N33_1 :=__common__( if(((real)r_i60_inq_auto_recency_d > NULL), N33_2, 0.0041605148));

N34_7 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.016092164,
             ((real)f_add_curr_nhood_vac_pct_i < 0.0344136059284) => 0.0037137939,
                                                                     0.016092164));

N34_6 :=__common__( map(((real)r_a50_pb_total_orders_d <= NULL) => -0.00052071155,
             ((real)r_a50_pb_total_orders_d < 1.5)   => N34_7,
                                                        -0.00052071155));

N34_5 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => -0.00040684554,
             ((real)r_c14_addrs_5yr_i < 3.5)   => -0.010057802,
                                                  -0.00040684554));

N34_4 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.0099578456,
             ((real)f_rel_felony_count_i < 0.5)   => -0.0013473671,
                                                     0.0099578456));

N34_3 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => N34_5,
             ((real)r_c12_num_nonderogs_d < 6.5)   => N34_4,
                                                      N34_5));

N34_2 :=__common__( if(((real)f_srchunvrfdssncount_i < 0.5), N34_3, N34_6));

N34_1 :=__common__( if(((real)f_srchunvrfdssncount_i > NULL), N34_2, 0.002030353));

N35_8 :=__common__( if(((real)c_retail < 9.85000038147), 0.015676721, 0.0047366692));

N35_7 :=__common__( if(trim(C_RETAIL) != '', N35_8, 0.0023929075));

N35_6 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => -0.0015010024,
             ((real)r_c21_m_bureau_adl_fs_d < 259.5) => N35_7,
                                                        -0.0015010024));

N35_5 :=__common__( map(((real)f_varrisktype_i <= NULL) => 0.011156193,
             ((real)f_varrisktype_i < 2.5)   => 0.0010916598,
                                                0.011156193));

N35_4 :=__common__( map(((real)f_addrchangeecontrajindex_d <= NULL) => -0.0049934125,
             ((real)f_addrchangeecontrajindex_d < 1.5)   => N35_5,
                                                            -0.0049934125));

N35_3 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => N35_4,
             ((integer)r_i60_inq_auto_recency_d < 549) => -0.0095461995,
                                                          N35_4));

N35_2 :=__common__( if(((real)f_rel_felony_count_i < 1.5), N35_3, N35_6));

N35_1 :=__common__( if(((real)f_rel_felony_count_i > NULL), N35_2, -0.0026099177));

N36_7 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => 0.0040645385,
             ((real)f_curraddrmedianincome_d < 30575.5) => 0.014309128,
                                                           0.0040645385));

N36_6 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => -0.0034324137,
             ((real)r_c12_num_nonderogs_d < 7.5)   => N36_7,
                                                      -0.0034324137));

N36_5 :=__common__( if(((real)c_cpiall < 207.350006104), 0.015184624, N36_6));

N36_4 :=__common__( if(trim(C_CPIALL) != '', N36_5, -0.0011587399));

N36_3 :=__common__( if(((real)f_corrphonelastnamecount_d < 0.5), N36_4, -0.0031715619));

N36_2 :=__common__( if(((real)f_corrphonelastnamecount_d > NULL), N36_3, 0.0083416244));

N36_1 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.013953963,
             (segment in ['KMART', 'SEARS FLS'])                => N36_2,
                                                                   -0.013953963));

N37_7 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.0057201532,
             ((real)c_comb_age_d < 39.5)  => 0.0085767246,
                                             -0.0057201532));

N37_6 :=__common__( map(((real)f_inq_lnames_per_addr_i <= NULL) => N37_7,
             ((real)f_inq_lnames_per_addr_i < 1.5)   => -0.0063867285,
                                                        N37_7));

N37_5 :=__common__( map(((real)r_f03_input_add_not_most_rec_i <= NULL) => 0.017759017,
             ((real)r_f03_input_add_not_most_rec_i < 0.5)   => 0.0063400324,
                                                               0.017759017));

N37_4 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => 0.006968839,
             ((real)f_curraddrcartheftindex_i < 139.5) => -0.0039873832,
                                                          0.006968839));

N37_3 :=__common__( map(((real)f_inq_communications_count24_i <= NULL) => N37_5,
             ((real)f_inq_communications_count24_i < 0.5)   => N37_4,
                                                               N37_5));

N37_2 :=__common__( if(((real)f_corrssnaddrcount_d < 3.5), N37_3, N37_6));

N37_1 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N37_2, 0.0020967552));

N38_8 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => 0.0051323039,
             ((real)f_m_bureau_adl_fs_all_d < 184.5) => 0.020309833,
                                                        0.0051323039));

N38_7 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => 0.0041919073,
             (segment in ['SEARS FLS'])                                  => 0.018290927,
                                                                            0.0041919073));

N38_6 :=__common__( if(((real)c_unemp < 7.25), -0.0021028108, N38_7));

N38_5 :=__common__( if(trim(C_UNEMP) != '', N38_6, -0.0016296482));

N38_4 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.0064192148,
             ((real)f_corrssnaddrcount_d < 3.5)   => N38_5,
                                                     -0.0064192148));

N38_3 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => N38_8,
             ((real)r_d32_felony_count_i < 0.5)   => N38_4,
                                                     N38_8));

N38_2 :=__common__( if(((real)f_inq_communications_count24_i < 2.5), N38_3, 0.010139348));

N38_1 :=__common__( if(((real)f_inq_communications_count24_i > NULL), N38_2, 0.0064302966));

N39_8 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.01824662,
             ((real)f_add_curr_nhood_vac_pct_i < 0.0777118429542) => 0.0076803046,
                                                                     0.01824662));

N39_7 :=__common__( if(((real)c_no_car < 140.5), 0.0042009855, N39_8));

N39_6 :=__common__( if(trim(C_NO_CAR) != '', N39_7, 0.0038532405));

N39_5 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => N39_6,
             ((integer)r_i60_inq_auto_recency_d < 549) => -0.0039661183,
                                                          N39_6));

N39_4 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.012732802,
             (segment in ['KMART', 'SEARS FLS'])                => N39_5,
                                                                   -0.012732802));

N39_3 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.0034522916,
             ((real)f_inq_other_count24_i < 1.5)   => -0.0069257213,
                                                      0.0034522916));

N39_2 :=__common__( if(((real)r_a50_pb_average_dollars_d < 2861.5), N39_3, N39_4));

N39_1 :=__common__( if(((real)r_a50_pb_average_dollars_d > NULL), N39_2, -0.011525553));

N40_9 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.0013434311,
             ((real)c_easiqlife < 101.5) => -0.010394799,
                                            0.0013434311));

N40_8 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.009028393,
             ((real)f_rel_felony_count_i < 1.5)   => N40_9,
                                                     0.009028393));

N40_7 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => -0.0080933589,
             ((real)r_c12_num_nonderogs_d < 7.5)   => N40_8,
                                                      -0.0080933589));

N40_6 :=__common__( if(((real)f_attr_arrest_recency_d < 99.5), 0.014414912, N40_7));

N40_5 :=__common__( if(((real)f_attr_arrest_recency_d > NULL), N40_6, -0.017328403));

N40_4 :=__common__( if(((real)r_d32_criminal_count_i < 0.5), 0.0031562645, 0.019501538));

N40_3 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N40_4, 0.023548206));

N40_2 :=__common__( if(((real)c_cpiall < 208.5), N40_3, N40_5));

N40_1 :=__common__( if(trim(C_CPIALL) != '', N40_2, -0.0019341908));

N41_8 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => 0.01162044,
             ((real)r_a50_pb_average_dollars_d < 319.5) => -0.0020853439,
                                                           0.01162044));

N41_7 :=__common__( map(trim(C_CONSTRUCTION) = ''     => -0.010026039,
             ((real)c_construction < 1.75) => -0.0018619275,
                                              -0.010026039));

N41_6 :=__common__( map(((real)f_varrisktype_i <= NULL) => 0.0042017528,
             ((real)f_varrisktype_i < 4.5)   => N41_7,
                                                0.0042017528));

N41_5 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.0042456207,
             ((real)r_d32_criminal_count_i < 3.5)   => N41_6,
                                                       0.0042456207));

N41_4 :=__common__( if(((real)c_unemp < 9.05000019073), N41_5, N41_8));

N41_3 :=__common__( if(trim(C_UNEMP) != '', N41_4, 0.0010803352));

N41_2 :=__common__( if(((real)r_d33_eviction_recency_d < 79.5), 0.0091415789, N41_3));

N41_1 :=__common__( if(((real)r_d33_eviction_recency_d > NULL), N41_2, 0.00067079149));

N42_9 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL) => 0.013049421,
             ((real)r_i60_inq_auto_recency_d < 61.5)  => -0.0013542979,
                                                         0.013049421));

N42_8 :=__common__( if(((real)c_cartheft < 115.5), -0.0014710438, 0.013419667));

N42_7 :=__common__( if(trim(C_CARTHEFT) != '', N42_8, 0.010755471));

N42_6 :=__common__( if(((real)f_inq_adls_per_addr_i < 2.5), -0.0049890134, 0.0052079344));

N42_5 :=__common__( if(((real)f_inq_adls_per_addr_i > NULL), N42_6, -0.030011974));

N42_4 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL) => N42_5,
             ((integer)r_d33_eviction_recency_d < 48) => 0.0075754797,
                                                         N42_5));

N42_3 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => N42_7,
             ((real)r_d32_felony_count_i < 0.5)   => N42_4,
                                                     N42_7));

N42_2 :=__common__( if(((real)f_srchunvrfdaddrcount_i < 0.5), N42_3, N42_9));

N42_1 :=__common__( if(((real)f_srchunvrfdaddrcount_i > NULL), N42_2, 0.0052228341));

N43_8 :=__common__( map(((real)f_attr_arrests_i <= NULL) => 0.01405856,
             ((real)f_attr_arrests_i < 0.5)   => -0.001438486,
                                                 0.01405856));

N43_7 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => 0.0066741526,
             ((real)r_c10_m_hdr_fs_d < 175.5) => 0.016972135,
                                                 0.0066741526));

N43_6 :=__common__( map(trim(C_BORN_USA) = ''      => N43_7,
             ((real)c_born_usa < 114.5) => 0.00093745188,
                                           N43_7));

N43_5 :=__common__( if(((real)c_fammar_p < 50.25), N43_6, N43_8));

N43_4 :=__common__( if(trim(C_FAMMAR_P) != '', N43_5, 0.0030791661));

N43_3 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => N43_4,
             ((integer)r_i60_inq_auto_recency_d < 549) => -0.0078372545,
                                                          N43_4));

N43_2 :=__common__( if(((real)f_varrisktype_i < 6.5), N43_3, 0.016139238));

N43_1 :=__common__( if(((real)f_varrisktype_i > NULL), N43_2, 0.006095027));

N44_8 :=__common__( map(((real)f_estimated_income_d <= NULL)    => -0.0008578942,
             ((integer)f_estimated_income_d < 28500) => 0.0096862941,
                                                        -0.0008578942));

N44_7 :=__common__( if(((real)c_cpiall < 209.300003052), 0.026305886, 0.0090554603));

N44_6 :=__common__( if(trim(C_CPIALL) != '', N44_7, 0.0016023555));

N44_5 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => N44_8,
             ((real)r_d32_mos_since_crim_ls_d < 78.5)  => N44_6,
                                                          N44_8));

N44_4 :=__common__( map(((real)f_inq_ssns_per_addr_i <= NULL) => 0.0037706822,
             ((real)f_inq_ssns_per_addr_i < 2.5)   => -0.0074722809,
                                                      0.0037706822));

N44_3 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => N44_4,
             ((real)f_corrssnaddrcount_d < 2.5)   => 0.003649982,
                                                     N44_4));

N44_2 :=__common__( if(((real)r_f03_input_add_not_most_rec_i < 0.5), N44_3, N44_5));

N44_1 :=__common__( if(((real)r_f03_input_add_not_most_rec_i > NULL), N44_2, 0.00065547833));

N45_8 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.0084862675,
             ((real)f_sourcerisktype_i < 4.5)   => -0.0063995259,
                                                   0.0084862675));

N45_7 :=__common__( map(trim(C_EASIQLIFE) = ''      => N45_8,
             ((real)c_easiqlife < 102.5) => -0.0066971606,
                                            N45_8));

N45_6 :=__common__( map(trim(C_CPIALL) = ''      => N45_7,
             ((real)c_cpiall < 208.5) => 0.01082261,
                                         N45_7));

N45_5 :=__common__( if(((real)c_cartheft < 106.5), -0.0052810348, N45_6));

N45_4 :=__common__( if(trim(C_CARTHEFT) != '', N45_5, -0.0026716847));

N45_3 :=__common__( map(((real)f_varrisktype_i <= NULL) => 0.011392698,
             ((real)f_varrisktype_i < 4.5)   => N45_4,
                                                0.011392698));

N45_2 :=__common__( if(((real)r_d31_mostrec_bk_i < 1.5), N45_3, -0.010739397));

N45_1 :=__common__( if(((real)r_d31_mostrec_bk_i > NULL), N45_2, -0.0053552019));

N46_9 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => 0.0051775932,
             ((real)r_c12_num_nonderogs_d < 6.5)   => 0.013665122,
                                                      0.0051775932));

N46_8 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.0089939363,
             (segment in ['KMART', 'SEARS FLS'])                => N46_9,
                                                                   -0.0089939363));

N46_7 :=__common__( if(((real)c_rural_p < 0.15000000596), N46_8, -0.0049552472));

N46_6 :=__common__( if(trim(C_RURAL_P) != '', N46_7, 0.02050271));

N46_5 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.0050662895,
             ((real)f_corrssnaddrcount_d < 4.5)   => N46_6,
                                                     -0.0050662895));

N46_4 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.0466599054635), -0.0045097507, N46_5));

N46_3 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N46_4, 0.084640637));

N46_2 :=__common__( if(((real)f_attr_arrests_i < 0.5), N46_3, 0.015415961));

N46_1 :=__common__( if(((real)f_attr_arrests_i > NULL), N46_2, -0.0066082792));

N47_10 :=__common__( if(((real)r_c14_addrs_10yr_i < 4.5), -0.011325663, -0.0012712575));

N47_9 :=__common__( if(((real)r_c14_addrs_10yr_i > NULL), N47_10, 0.0043007147));

N47_8 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL)  => 0.011733465,
             ((integer)f_curraddrcartheftindex_i < 127) => 0.0023748131,
                                                           0.011733465));

N47_7 :=__common__( if(((real)c_fammar_p < 45.0499992371), 0.0053385399, -0.0036141383));

N47_6 :=__common__( if(trim(C_FAMMAR_P) != '', N47_7, -0.0013865768));

N47_5 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i < 2.5), N47_6, N47_8));

N47_4 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i > NULL), N47_5, 0.010997191));

N47_3 :=__common__( map(((real)c_comb_age_d <= NULL) => N47_9,
             ((real)c_comb_age_d < 38.5)  => N47_4,
                                             N47_9));

N47_2 :=__common__( if(((real)f_inq_lnames_per_addr_i < 3.5), N47_3, 0.01677536));

N47_1 :=__common__( if(((real)f_inq_lnames_per_addr_i > NULL), N47_2, 0.031617481));

N48_8 :=__common__( map(trim(C_BORN_USA) = ''      => 0.013469443,
             ((real)c_born_usa < 119.5) => 0.0041129968,
                                           0.013469443));

N48_7 :=__common__( if(((real)c_trailer_p < 1.34999990463), N48_8, 0.00022431151));

N48_6 :=__common__( if(trim(C_TRAILER_P) != '', N48_7, -0.0048158189));

N48_5 :=__common__( map(((real)f_addrchangeecontrajindex_d <= NULL) => -0.0028032132,
             ((real)f_addrchangeecontrajindex_d < 1.5)   => N48_6,
                                                            -0.0028032132));

N48_4 :=__common__( map(((real)r_d31_mostrec_bk_i <= NULL) => -0.010326827,
             ((real)r_d31_mostrec_bk_i < 1.5)   => N48_5,
                                                   -0.010326827));

N48_3 :=__common__( map(((real)f_srchunvrfdaddrcount_i <= NULL) => 0.011267877,
             ((real)f_srchunvrfdaddrcount_i < 0.5)   => N48_4,
                                                        0.011267877));

N48_2 :=__common__( if(((real)f_inq_auto_count24_i < 1.5), N48_3, -0.011685783));

N48_1 :=__common__( if(((real)f_inq_auto_count24_i > NULL), N48_2, 0.0078530619));

N49_8 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => 0.01601143,
             ((integer)r_i60_inq_auto_recency_d < 549) => -0.0041227177,
                                                          0.01601143));

N49_7 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => 0.00038463898,
             (segment in ['SEARS FLS'])                                  => N49_8,
                                                                            0.00038463898));

N49_6 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.024008436,
             ((real)r_d32_criminal_count_i < 1.5)   => 0.0082932737,
                                                       0.024008436));

N49_5 :=__common__( map(trim(C_CPIALL) = ''      => N49_7,
             ((real)c_cpiall < 208.5) => N49_6,
                                         N49_7));

N49_4 :=__common__( if(((real)c_fammar_p < 64.9499969482), N49_5, -0.0018778306));

N49_3 :=__common__( if(trim(C_FAMMAR_P) != '', N49_4, -0.007022877));

N49_2 :=__common__( if(((real)f_corraddrphonecount_d < 0.5), N49_3, -0.005202171));

N49_1 :=__common__( if(((real)f_corraddrphonecount_d > NULL), N49_2, -0.0054363444));

N50_7 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.013254251,
             ((real)f_sourcerisktype_i < 3.5)   => -0.0035405278,
                                                   0.013254251));

N50_6 :=__common__( map(((real)r_c20_email_count_i <= NULL) => 0.0026414423,
             ((real)r_c20_email_count_i < 0.5)   => 0.013223996,
                                                    0.0026414423));

N50_5 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.010137849,
             (segment in ['KMART', 'SEARS FLS'])                => N50_6,
                                                                   -0.010137849));

N50_4 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N50_5,
             ((real)c_hist_addr_match_i < 1.5)   => -0.0039264631,
                                                    N50_5));

N50_3 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => -0.0094454115,
             ((real)r_c10_m_hdr_fs_d < 292.5) => N50_4,
                                                 -0.0094454115));

N50_2 :=__common__( if(((real)f_rel_felony_count_i < 3.5), N50_3, N50_7));

N50_1 :=__common__( if(((real)f_rel_felony_count_i > NULL), N50_2, 0.017128692));

N51_8 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.0011464881,
             ((real)f_corrssnaddrcount_d < 2.5)   => 0.007134873,
                                                     -0.0011464881));

N51_7 :=__common__( if(((real)r_l79_adls_per_addr_c6_i < 4.5), N51_8, 0.01747427));

N51_6 :=__common__( if(((real)r_l79_adls_per_addr_c6_i > NULL), N51_7, -0.031048447));

N51_5 :=__common__( map(((real)f_srchunvrfdaddrcount_i <= NULL) => 0.011198052,
             ((real)f_srchunvrfdaddrcount_i < 0.5)   => N51_6,
                                                        0.011198052));

N51_4 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => 0.013215047,
             ((real)r_d32_felony_count_i < 0.5)   => N51_5,
                                                     0.013215047));

N51_3 :=__common__( map(((real)f_inq_auto_count24_i <= NULL) => -0.0089482546,
             ((real)f_inq_auto_count24_i < 1.5)   => N51_4,
                                                     -0.0089482546));

N51_2 :=__common__( if(((integer)r_i60_inq_comm_recency_d < 549), N51_3, -0.0043780844));

N51_1 :=__common__( if(((real)r_i60_inq_comm_recency_d > NULL), N51_2, 0.0040524289));

N52_8 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => 0.0089691873,
             ((integer)r_i60_inq_auto_recency_d < 549) => -0.003100656,
                                                          0.0089691873));

N52_7 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.016031156,
             ((real)f_rel_felony_count_i < 1.5)   => N52_8,
                                                     0.016031156));

N52_6 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => N52_7,
             ((real)f_srchaddrsrchcount_i < 4.5)   => -0.00051184795,
                                                      N52_7));

N52_5 :=__common__( if(((real)f_rel_under25miles_cnt_d < 22.5), 0.0019956019, 0.018062792));

N52_4 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N52_5, -0.031719118));

N52_3 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => N52_4,
             ((real)r_c14_addrs_10yr_i < 9.5)   => -0.0055204693,
                                                   N52_4));

N52_2 :=__common__( if(((real)f_sourcerisktype_i < 5.5), N52_3, N52_6));

N52_1 :=__common__( if(((real)f_sourcerisktype_i > NULL), N52_2, -0.005056144));

N53_9 :=__common__( if(((real)r_c10_m_hdr_fs_d < 281.5), 0.011439002, -0.0018630429));

N53_8 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N53_9, 0.066436708));

N53_7 :=__common__( map((segment in ['RETAIL', 'SEARS SHO'])              => -0.0098095926,
             (segment in ['KMART', 'SEARS AUTO', 'SEARS FLS']) => 0.009323731,
                                                                  0.009323731));

N53_6 :=__common__( if(((real)r_c20_email_count_i < 0.5), N53_7, -0.00024164521));

N53_5 :=__common__( if(((real)r_c20_email_count_i > NULL), N53_6, 0.0052553824));

N53_4 :=__common__( map(((real)r_f03_input_add_not_most_rec_i <= NULL) => 0.00015971048,
             ((real)r_f03_input_add_not_most_rec_i < 0.5)   => -0.0093302623,
                                                               0.00015971048));

N53_3 :=__common__( map((fp_segment in ['6 Recent Activity', '7 Other'])                                     => N53_4,
             (fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '4 Bureau Only', '5 Derog']) => N53_5,
                                                                                                     N53_5));

N53_2 :=__common__( if(((real)f_inq_adls_per_addr_i < 2.5), N53_3, N53_8));

N53_1 :=__common__( if(((real)f_inq_adls_per_addr_i > NULL), N53_2, 0.041141175));

N54_8 :=__common__( map(((real)f_inq_lnames_per_addr_i <= NULL) => 0.016661331,
             ((real)f_inq_lnames_per_addr_i < 1.5)   => 0.0075394002,
                                                        0.016661331));

N54_7 :=__common__( map(((real)r_d31_mostrec_bk_i <= NULL) => -0.0083971692,
             ((real)r_d31_mostrec_bk_i < 1.5)   => N54_8,
                                                   -0.0083971692));

N54_6 :=__common__( if(((real)c_no_car < 138.5), 0.0010066272, N54_7));

N54_5 :=__common__( if(trim(C_NO_CAR) != '', N54_6, -0.00056677495));

N54_4 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.01108903,
             (segment in ['KMART', 'SEARS FLS'])                => N54_5,
                                                                   -0.01108903));

N54_3 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N54_4,
             ((real)f_sourcerisktype_i < 4.5)   => -0.004140889,
                                                   N54_4));

N54_2 :=__common__( if(((real)f_inq_auto_count24_i < 1.5), N54_3, -0.011943389));

N54_1 :=__common__( if(((real)f_inq_auto_count24_i > NULL), N54_2, 0.0020825017));

N55_9 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => -1.2117191e-005,
             ((real)f_rel_felony_count_i < 0.5)   => -0.0074954712,
                                                     -1.2117191e-005));

N55_8 :=__common__( map(((real)f_corrphonelastnamecount_d <= NULL) => 0.0016185863,
             ((real)f_corrphonelastnamecount_d < 0.5)   => 0.010802489,
                                                           0.0016185863));

N55_7 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.0079680045,
             (segment in ['KMART', 'SEARS FLS'])                => N55_8,
                                                                   -0.0079680045));

N55_6 :=__common__( if(((real)c_rural_p < 0.0500000007451), N55_7, -0.0044898502));

N55_5 :=__common__( if(trim(C_RURAL_P) != '', N55_6, 0.0048549096));

N55_4 :=__common__( if(((integer)r_f01_inp_addr_address_score_d < 65), N55_5, N55_9));

N55_3 :=__common__( if(((real)r_f01_inp_addr_address_score_d > NULL), N55_4, 0.0085051685));

N55_2 :=__common__( if(((real)f_inq_lnames_per_addr_i < 3.5), N55_3, 0.013617929));

N55_1 :=__common__( if(((real)f_inq_lnames_per_addr_i > NULL), N55_2, 0.079428039));

N56_9 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => 0.01611837,
             ((real)r_c14_addrs_5yr_i < 8.5)   => 0.0054091577,
                                                  0.01611837));

N56_8 :=__common__( if(((real)f_rel_under25miles_cnt_d < 8.5), -0.00050124005, N56_9));

N56_7 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N56_8, 0.00043932955));

N56_6 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.013321659,
             ((real)f_corrssnaddrcount_d < 4.5)   => -0.0015749679,
                                                     -0.013321659));

N56_5 :=__common__( if(((real)r_l80_inp_avm_autoval_d < 19869.5), 0.0099349709, N56_6));

N56_4 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N56_5, -0.0046455084));

N56_3 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => N56_4,
             ((real)r_d32_mos_since_crim_ls_d < 30.5)  => 0.0079787835,
                                                          N56_4));

N56_2 :=__common__( if(((real)r_c14_addrs_5yr_i < 3.5), N56_3, N56_7));

N56_1 :=__common__( if(((real)r_c14_addrs_5yr_i > NULL), N56_2, 0.0030800558));

N57_8 :=__common__( map(((real)f_inq_adls_per_addr_i <= NULL) => 0.010665039,
             ((real)f_inq_adls_per_addr_i < 3.5)   => -0.0054446544,
                                                      0.010665039));

N57_7 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.0087098521,
             ((real)f_sourcerisktype_i < 6.5)   => -0.00030006436,
                                                   0.0087098521));

N57_6 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.018864086,
             ((real)r_d32_criminal_count_i < 0.5)   => 0.0065517679,
                                                       0.018864086));

N57_5 :=__common__( if(((real)c_cpiall < 208.5), N57_6, N57_7));

N57_4 :=__common__( if(trim(C_CPIALL) != '', N57_5, 0.0032115772));

N57_3 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.010248436,
             (segment in ['KMART', 'SEARS FLS'])                => N57_4,
                                                                   -0.010248436));

N57_2 :=__common__( if(((real)f_corrphonelastnamecount_d < 0.5), N57_3, N57_8));

N57_1 :=__common__( if(((real)f_corrphonelastnamecount_d > NULL), N57_2, 0.0013135472));

N58_9 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 78.5), 0.0026293923, -0.0052529012));

N58_8 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N58_9, -0.017529354));

N58_7 :=__common__( map(((real)f_varrisktype_i <= NULL) => 0.015743603,
             ((real)f_varrisktype_i < 6.5)   => 0.00037565211,
                                                0.015743603));

N58_6 :=__common__( map(((real)f_corrrisktype_i <= NULL) => 0.018823378,
             ((real)f_corrrisktype_i < 7.5)   => 0.0083348166,
                                                 0.018823378));

N58_5 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.010728345,
             (segment in ['KMART', 'SEARS FLS'])                => N58_6,
                                                                   -0.010728345));

N58_4 :=__common__( if(((real)r_c20_email_count_i < 0.5), N58_5, N58_7));

N58_3 :=__common__( if(((real)r_c20_email_count_i > NULL), N58_4, 0.00056648407));

N58_2 :=__common__( if(((real)c_construction < 1.45000004768), N58_3, N58_8));

N58_1 :=__common__( if(trim(C_CONSTRUCTION) != '', N58_2, -0.0013344062));

N59_8 :=__common__( map(((real)f_srchphonesrchcount_i <= NULL) => -0.003358399,
             ((real)f_srchphonesrchcount_i < 2.5)   => 0.0045580606,
                                                       -0.003358399));

N59_7 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => N59_8,
             ((real)f_srchfraudsrchcount_i < 5.5)   => -0.0057421028,
                                                       N59_8));

N59_6 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.0050331956,
             ((real)f_sourcerisktype_i < 5.5)   => -0.0068745274,
                                                   0.0050331956));

N59_5 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.012567261,
             ((real)r_c14_addrs_10yr_i < 8.5)   => N59_6,
                                                   0.012567261));

N59_4 :=__common__( if(((real)c_occunit_p < 82.4499969482), 0.015224109, N59_5));

N59_3 :=__common__( if(trim(C_OCCUNIT_P) != '', N59_4, -0.0078539357));

N59_2 :=__common__( if(((real)r_c20_email_count_i < 0.5), N59_3, N59_7));

N59_1 :=__common__( if(((real)r_c20_email_count_i > NULL), N59_2, -0.0043588221));

N60_8 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.0019939085,
             ((real)r_c14_addrs_10yr_i < 9.5)   => -0.0074848724,
                                                   0.0019939085));

N60_7 :=__common__( map((segment in ['RETAIL', 'SEARS SHO'])              => -0.0060459405,
             (segment in ['KMART', 'SEARS AUTO', 'SEARS FLS']) => 0.01289963,
                                                                  0.01289963));

N60_6 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N60_7,
             ((real)f_sourcerisktype_i < 5.5)   => 0.0031808156,
                                                   N60_7));

N60_5 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => N60_6,
             ((real)f_srchssnsrchcount_i < 1.5)   => -0.00040073289,
                                                     N60_6));

N60_4 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => N60_5,
             ((integer)r_i60_inq_auto_recency_d < 549) => -0.0041298632,
                                                          N60_5));

N60_3 :=__common__( if(trim(C_RURAL_P) != '', N60_4, -0.0011950841));

N60_2 :=__common__( if(((real)r_c20_email_domain_isp_count_i < 0.5), N60_3, N60_8));

N60_1 :=__common__( if(((real)r_c20_email_domain_isp_count_i > NULL), N60_2, 0.0041970403));

N61_8 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.011166183,
             ((real)f_rel_felony_count_i < 1.5)   => 0.0024326996,
                                                     0.011166183));

N61_7 :=__common__( if(((real)c_cpiall < 207.350006104), 0.014087096, N61_8));

N61_6 :=__common__( if(trim(C_CPIALL) != '', N61_7, 0.0051293589));

N61_5 :=__common__( map(((real)f_inq_auto_count24_i <= NULL) => -0.0074514087,
             ((real)f_inq_auto_count24_i < 1.5)   => N61_6,
                                                     -0.0074514087));

N61_4 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.0068747479,
             (segment in ['KMART', 'SEARS FLS'])                => N61_5,
                                                                   -0.0068747479));

N61_3 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => -0.0043797413,
             ((real)r_c10_m_hdr_fs_d < 281.5) => N61_4,
                                                 -0.0043797413));

N61_2 :=__common__( if(((real)c_hist_addr_match_i < 1.5), -0.0037626261, N61_3));

N61_1 :=__common__( if(((real)c_hist_addr_match_i > NULL), N61_2, 0.0012189577));

N62_7 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.0030816917,
             ((real)c_comb_age_d < 36.5)  => 0.0033329017,
                                             -0.0030816917));

N62_6 :=__common__( map(((real)r_i60_inq_hiriskcred_recency_d <= NULL)  => -0.0076526397,
             ((integer)r_i60_inq_hiriskcred_recency_d < 549) => N62_7,
                                                                -0.0076526397));

N62_5 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.011961166,
             ((real)r_d32_criminal_count_i < 0.5)   => 0.002210701,
                                                       0.011961166));

N62_4 :=__common__( map(((real)f_srchunvrfdaddrcount_i <= NULL) => 0.019910956,
             ((real)f_srchunvrfdaddrcount_i < 0.5)   => N62_5,
                                                        0.019910956));

N62_3 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => N62_4,
             ((integer)r_i60_inq_auto_recency_d < 549) => -0.0074076955,
                                                          N62_4));

N62_2 :=__common__( if(((real)r_c20_email_count_i < 0.5), N62_3, N62_6));

N62_1 :=__common__( if(((real)r_c20_email_count_i > NULL), N62_2, 0.0038228085));

N63_8 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => 0.0021607709,
             ((real)f_srchaddrsrchcount_i < 11.5)  => -0.0052868031,
                                                      0.0021607709));

N63_7 :=__common__( map(((real)r_c20_email_count_i <= NULL) => 0.0027744825,
             ((real)r_c20_email_count_i < 0.5)   => 0.014273789,
                                                    0.0027744825));

N63_6 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => N63_7,
             ((real)f_add_curr_nhood_vac_pct_i < 0.062631726265) => -0.0019047923,
                                                                    N63_7));

N63_5 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => N63_6,
             ((real)r_d32_mos_since_crim_ls_d < 126.5) => 0.010739722,
                                                          N63_6));

N63_4 :=__common__( if(((real)c_urban_p < 99.9499969482), -0.0031130569, N63_5));

N63_3 :=__common__( if(trim(C_URBAN_P) != '', N63_4, 0.0042823892));

N63_2 :=__common__( if(((real)f_corrssnaddrcount_d < 3.5), N63_3, N63_8));

N63_1 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N63_2, 0.0015418832));

N64_8 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => 0.0017041912,
             (segment in ['SEARS FLS'])                                  => 0.011645985,
                                                                            0.0017041912));

N64_7 :=__common__( if(((real)f_inq_lnames_per_addr_i < 1.5), N64_8, 0.01218135));

N64_6 :=__common__( if(((real)f_inq_lnames_per_addr_i > NULL), N64_7, -0.032036234));

N64_5 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => N64_6,
             ((real)f_rel_felony_count_i < 0.5)   => -0.00090504727,
                                                     N64_6));

N64_4 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => -0.0067605263,
             ((real)r_c10_m_hdr_fs_d < 304.5) => N64_5,
                                                 -0.0067605263));

N64_3 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => N64_4,
             ((integer)r_i60_inq_auto_recency_d < 549) => -0.0057186589,
                                                          N64_4));

N64_2 :=__common__( if(((real)f_varrisktype_i < 8.5), N64_3, 0.019918708));

N64_1 :=__common__( if(((real)f_varrisktype_i > NULL), N64_2, -0.0023510819));

N65_9 :=__common__( if(((real)c_construction < 1.25), 0.015520824, 0.0042464687));

N65_8 :=__common__( if(trim(C_CONSTRUCTION) != '', N65_9, 0.054406296));

N65_7 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => -0.0029078913,
             ((real)r_c12_num_nonderogs_d < 6.5)   => 0.0042883169,
                                                      -0.0029078913));

N65_6 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL) => N65_7,
             ((real)f_prevaddrcartheftindex_i < 130.5) => -0.0057157043,
                                                          N65_7));

N65_5 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL) => N65_6,
             ((integer)r_d33_eviction_recency_d < 48) => 0.0064674485,
                                                         N65_6));

N65_4 :=__common__( if(((real)f_attr_arrests_i < 0.5), N65_5, 0.011256487));

N65_3 :=__common__( if(((real)f_attr_arrests_i > NULL), N65_4, -0.0046554521));

N65_2 :=__common__( if(((real)r_l79_adls_per_addr_c6_i < 3.5), N65_3, N65_8));

N65_1 :=__common__( if(((real)r_l79_adls_per_addr_c6_i > NULL), N65_2, 0.0435156));

N66_8 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.0353943780065), -0.0032216934, 0.0055201899));

N66_7 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N66_8, -0.031039674));

N66_6 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.011486611,
             ((real)f_sourcerisktype_i < 6.5)   => N66_7,
                                                   0.011486611));

N66_5 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.0047637578,
             ((real)f_corrssnaddrcount_d < 2.5)   => 0.0039809512,
                                                     -0.0047637578));

N66_4 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => N66_6,
             ((real)f_rel_felony_count_i < 0.5)   => N66_5,
                                                     N66_6));

N66_3 :=__common__( map(((real)f_corrphonelastnamecount_d <= NULL) => -0.0050916227,
             ((real)f_corrphonelastnamecount_d < 0.5)   => N66_4,
                                                           -0.0050916227));

N66_2 :=__common__( if(((real)f_divaddrsuspidcountnew_i < 1.5), N66_3, 0.0086833498));

N66_1 :=__common__( if(((real)f_divaddrsuspidcountnew_i > NULL), N66_2, 0.0029212748));

N67_8 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.0055029068,
             ((real)r_d32_criminal_count_i < 6.5)   => -0.0052541564,
                                                       0.0055029068));

N67_7 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => 0.0073276141,
             ((real)r_c14_addrs_5yr_i < 3.5)   => -0.0011313421,
                                                  0.0073276141));

N67_6 :=__common__( map(((real)r_c20_email_count_i <= NULL) => N67_7,
             ((real)r_c20_email_count_i < 0.5)   => 0.01222536,
                                                    N67_7));

N67_5 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL) => -0.0021108195,
             ((integer)r_d33_eviction_recency_d < 48) => 0.0078177181,
                                                         -0.0021108195));

N67_4 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.0619882717729), N67_5, N67_6));

N67_3 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N67_4, 0.0071362009));

N67_2 :=__common__( if(((real)f_addrchangeecontrajindex_d < 1.5), N67_3, N67_8));

N67_1 :=__common__( if(((real)f_addrchangeecontrajindex_d > NULL), N67_2, 0.0023284089));

N68_7 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => 0.0027016851,
             (segment in ['SEARS FLS'])                                  => 0.012504371,
                                                                            0.0027016851));

N68_6 :=__common__( map(trim(C_EASIQLIFE) = ''      => N68_7,
             ((real)c_easiqlife < 102.5) => -0.0036961145,
                                            N68_7));

N68_5 :=__common__( if(((real)r_c12_num_nonderogs_d < 6.5), N68_6, -0.0033126073));

N68_4 :=__common__( if(((real)r_c12_num_nonderogs_d > NULL), N68_5, 0.010113721));

N68_3 :=__common__( if(((real)c_cpiall < 208.5), 0.0075973336, N68_4));

N68_2 :=__common__( if(trim(C_CPIALL) != '', N68_3, -0.00019705565));

N68_1 :=__common__( map(((real)c_inf_fname_verd_d <= NULL) => -0.0076702702,
             ((real)c_inf_fname_verd_d < 0.5)   => N68_2,
                                                   -0.0076702702));

N69_7 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.0093813221,
             ((real)f_inq_other_count24_i < 0.5)   => 0.00036250809,
                                                      0.0093813221));

N69_6 :=__common__( map(((real)r_a50_pb_total_orders_d <= NULL) => -0.0055329443,
             ((real)r_a50_pb_total_orders_d < 2.5)   => N69_7,
                                                        -0.0055329443));

N69_5 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => -0.01030134,
             ((real)f_m_bureau_adl_fs_all_d < 330.5) => 0.0045111831,
                                                        -0.01030134));

N69_4 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)    => -0.0029108741,
             ((integer)f_curraddrmedianincome_d < 33854) => N69_5,
                                                            -0.0029108741));

N69_3 :=__common__( map(((real)c_inf_fname_verd_d <= NULL) => -0.0095217576,
             ((real)c_inf_fname_verd_d < 0.5)   => N69_4,
                                                   -0.0095217576));

N69_2 :=__common__( if(((real)f_srchunvrfdssncount_i < 0.5), N69_3, N69_6));

N69_1 :=__common__( if(((real)f_srchunvrfdssncount_i > NULL), N69_2, -0.0013797642));

N70_10 :=__common__( if(((real)c_famotf18_p < 36.25), -0.0056687122, 0.0012972548));

N70_9 :=__common__( if(trim(C_FAMOTF18_P) != '', N70_10, -0.0058739938));

N70_8 :=__common__( map(((real)f_divaddrsuspidcountnew_i <= NULL) => 0.0057905706,
             ((real)f_divaddrsuspidcountnew_i < 1.5)   => N70_9,
                                                          0.0057905706));

N70_7 :=__common__( if(((real)c_no_car < 145.5), 0.0039112682, 0.013686812));

N70_6 :=__common__( if(trim(C_NO_CAR) != '', N70_7, 0.005052147));

N70_5 :=__common__( map(((real)r_c20_email_count_i <= NULL) => 0.0010639918,
             ((real)r_c20_email_count_i < 0.5)   => N70_6,
                                                    0.0010639918));

N70_4 :=__common__( if(((integer)r_f01_inp_addr_address_score_d < 55), N70_5, N70_8));

N70_3 :=__common__( if(((real)r_f01_inp_addr_address_score_d > NULL), N70_4, 0.0043996209));

N70_2 :=__common__( if(((real)f_inq_lnames_per_addr_i < 3.5), N70_3, 0.012366392));

N70_1 :=__common__( if(((real)f_inq_lnames_per_addr_i > NULL), N70_2, 0.016517842));

N71_8 :=__common__( map(((real)f_attr_arrest_recency_d <= NULL) => 0.0016245565,
             ((real)f_attr_arrest_recency_d < 99.5)  => 0.011391268,
                                                        0.0016245565));

N71_7 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => -0.0032081821,
             ((real)r_c12_num_nonderogs_d < 6.5)   => 0.0071137743,
                                                      -0.0032081821));

N71_6 :=__common__( if(((real)r_l80_inp_avm_autoval_d < 23783.5), 0.016214884, N71_7));

N71_5 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N71_6, N71_8));

N71_4 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL) => -0.004631574,
             ((integer)r_d33_eviction_recency_d < 48) => 0.0045896803,
                                                         -0.004631574));

N71_3 :=__common__( map(((real)f_divaddrsuspidcountnew_i <= NULL) => 0.011465171,
             ((real)f_divaddrsuspidcountnew_i < 2.5)   => N71_4,
                                                          0.011465171));

N71_2 :=__common__( if(((real)r_d32_criminal_count_i < 0.5), N71_3, N71_5));

N71_1 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N71_2, 0.0035447447));

N72_8 :=__common__( if(((real)c_construction < 0.15000000596), 0.0094594639, 0.0021374391));

N72_7 :=__common__( if(trim(C_CONSTRUCTION) != '', N72_8, 0.0056807111));

N72_6 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => -0.0028255999,
             ((real)r_c12_num_nonderogs_d < 7.5)   => N72_7,
                                                      -0.0028255999));

N72_5 :=__common__( map(((real)f_assocrisktype_i <= NULL) => 0.0013511238,
             ((real)f_assocrisktype_i < 7.5)   => -0.0053064744,
                                                  0.0013511238));

N72_4 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => N72_6,
             ((real)f_srchaddrsrchcount_i < 6.5)   => N72_5,
                                                      N72_6));

N72_3 :=__common__( map(((real)f_attr_arrests_i <= NULL) => 0.010567421,
             ((real)f_attr_arrests_i < 0.5)   => N72_4,
                                                 0.010567421));

N72_2 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 127.5), 0.010487358, N72_3));

N72_1 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N72_2, -0.011760928));

N73_9 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i < 1.5), 0.0031441874, 0.012650666));

N73_8 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i > NULL), N73_9, 0.0035858177));

N73_7 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.265117287636), -0.0043832654, 0.0086675542));

N73_6 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N73_7, -0.00061467874));

N73_5 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => N73_6,
             ((real)r_d32_criminal_count_i < 0.5)   => -0.0027154022,
                                                       N73_6));

N73_4 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => N73_8,
             ((real)r_c14_addrs_5yr_i < 4.5)   => N73_5,
                                                  N73_8));

N73_3 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.0040116182,
             ((real)c_comb_age_d < 27.5)  => 0.0035756754,
                                             -0.0040116182));

N73_2 :=__common__( if(((real)c_hist_addr_match_i < 2.5), N73_3, N73_4));

N73_1 :=__common__( if(((real)c_hist_addr_match_i > NULL), N73_2, 0.0049464809));

N74_8 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.0050226436,
             ((real)f_inq_other_count24_i < 0.5)   => -0.005453587,
                                                      0.0050226436));

N74_7 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => 0.01870985,
             ((real)r_d32_felony_count_i < 0.5)   => 0.0057512183,
                                                     0.01870985));

N74_6 :=__common__( if(((real)c_trailer < 121.5), N74_7, N74_8));

N74_5 :=__common__( if(trim(C_TRAILER) != '', N74_6, 0.0075147609));

N74_4 :=__common__( map(((real)f_corrrisktype_i <= NULL) => 0.0045562921,
             ((real)f_corrrisktype_i < 8.5)   => -0.0039668381,
                                                 0.0045562921));

N74_3 :=__common__( map(((real)f_divaddrsuspidcountnew_i <= NULL) => 0.0060584789,
             ((real)f_divaddrsuspidcountnew_i < 1.5)   => N74_4,
                                                          0.0060584789));

N74_2 :=__common__( if(((real)r_f03_input_add_not_most_rec_i < 0.5), N74_3, N74_5));

N74_1 :=__common__( if(((real)r_f03_input_add_not_most_rec_i > NULL), N74_2, -0.0040989805));

N75_7 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)         => 0.012130831,
             ((real)f_add_input_nhood_vac_pct_i < 0.12041965127) => 0.0040431787,
                                                                    0.012130831));

N75_6 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL) => -0.003008861,
             ((real)r_d33_eviction_recency_d < 79.5)  => 0.0073521402,
                                                         -0.003008861));

N75_5 :=__common__( if(((integer)r_a50_pb_average_dollars_d < 297), N75_6, N75_7));

N75_4 :=__common__( if(((real)r_a50_pb_average_dollars_d > NULL), N75_5, 0.019840301));

N75_3 :=__common__( if(((real)c_trailer_p < 1.45000004768), N75_4, -0.0023522038));

N75_2 :=__common__( if(trim(C_TRAILER_P) != '', N75_3, 0.0057725965));

N75_1 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.010729718,
             (segment in ['KMART', 'SEARS FLS'])                => N75_2,
                                                                   -0.010729718));

N76_7 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => 0.01571241,
             ((integer)r_i60_inq_auto_recency_d < 549) => -0.0012738356,
                                                          0.01571241));

N76_6 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => 0.0034129824,
             (segment in ['SEARS FLS'])                                  => N76_7,
                                                                            0.0034129824));

N76_5 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => -0.003358704,
             ((real)r_c12_num_nonderogs_d < 8.5)   => N76_6,
                                                      -0.003358704));

N76_4 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.0071230921,
             ((real)f_corrssnaddrcount_d < 1.5)   => 0.0018837893,
                                                     -0.0071230921));

N76_3 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => 0.00073527856,
             ((real)f_srchaddrsrchcount_i < 5.5)   => N76_4,
                                                      0.00073527856));

N76_2 :=__common__( if(((real)r_f03_input_add_not_most_rec_i < 0.5), N76_3, N76_5));

N76_1 :=__common__( if(((real)r_f03_input_add_not_most_rec_i > NULL), N76_2, -0.00682508));

N77_7 :=__common__( map(((real)r_has_paw_source_d <= NULL) => 0.00011603386,
             ((real)r_has_paw_source_d < 0.5)   => 0.013001917,
                                                   0.00011603386));

N77_6 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.016438356,
             ((real)f_rel_felony_count_i < 3.5)   => 0.0014398187,
                                                     0.016438356));

N77_5 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N77_6,
             ((real)f_sourcerisktype_i < 5.5)   => -0.0040248802,
                                                   N77_6));

N77_4 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => N77_7,
             ((real)r_d32_criminal_count_i < 5.5)   => N77_5,
                                                       N77_7));

N77_3 :=__common__( map(((real)f_varrisktype_i <= NULL) => 0.007807156,
             ((real)f_varrisktype_i < 3.5)   => N77_4,
                                                0.007807156));

N77_2 :=__common__( if(((integer)r_i60_inq_auto_recency_d < 549), -0.0048357603, N77_3));

N77_1 :=__common__( if(((real)r_i60_inq_auto_recency_d > NULL), N77_2, -0.0039330968));

N78_8 :=__common__( map(((real)f_inq_auto_count24_i <= NULL) => -0.0091190713,
             ((real)f_inq_auto_count24_i < 1.5)   => 0.0070394294,
                                                     -0.0091190713));

N78_7 :=__common__( if(((real)c_retail < 10.75), N78_8, -0.00066898238));

N78_6 :=__common__( if(trim(C_RETAIL) != '', N78_7, 0.0062622463));

N78_5 :=__common__( map(((real)r_a50_pb_total_orders_d <= NULL) => -0.0068423351,
             ((real)r_a50_pb_total_orders_d < 2.5)   => N78_6,
                                                        -0.0068423351));

N78_4 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.010590171,
             (segment in ['KMART', 'SEARS FLS'])                => N78_5,
                                                                   -0.010590171));

N78_3 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL)  => N78_4,
             ((integer)f_prevaddrcartheftindex_i < 118) => -0.0045743217,
                                                           N78_4));

N78_2 :=__common__( if(((real)f_srchunvrfdaddrcount_i < 0.5), N78_3, 0.0067980088));

N78_1 :=__common__( if(((real)f_srchunvrfdaddrcount_i > NULL), N78_2, -0.0042238497));

N79_8 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => 0.00047652925,
             ((real)r_c12_num_nonderogs_d < 8.5)   => 0.010624545,
                                                      0.00047652925));

N79_7 :=__common__( if(((real)c_easiqlife < 113.5), -0.0083999121, -0.00064012323));

N79_6 :=__common__( if(trim(C_EASIQLIFE) != '', N79_7, -0.0080918636));

N79_5 :=__common__( map(((real)f_varrisktype_i <= NULL) => 0.010215721,
             ((real)f_varrisktype_i < 6.5)   => -0.001124989,
                                                0.010215721));

N79_4 :=__common__( map(((real)r_c20_email_count_i <= NULL) => N79_5,
             ((real)r_c20_email_count_i < 0.5)   => 0.0062619902,
                                                    N79_5));

N79_3 :=__common__( map(((real)r_i60_inq_comm_recency_d <= NULL)  => N79_6,
             ((integer)r_i60_inq_comm_recency_d < 549) => N79_4,
                                                          N79_6));

N79_2 :=__common__( if(((real)f_rel_felony_count_i < 3.5), N79_3, N79_8));

N79_1 :=__common__( if(((real)f_rel_felony_count_i > NULL), N79_2, -0.012736802));

N80_9 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => 0.012104913,
             ((integer)r_i60_inq_auto_recency_d < 549) => -0.0022988324,
                                                          0.012104913));

N80_8 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => 0.00059037731,
             (segment in ['SEARS FLS'])                                  => N80_9,
                                                                            0.00059037731));

N80_7 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => N80_8,
             ((real)r_c14_addrs_5yr_i < 1.5)   => -0.0063341499,
                                                  N80_8));

N80_6 :=__common__( if(((real)c_hist_addr_match_i < 2.5), -0.0042404192, N80_7));

N80_5 :=__common__( if(((real)c_hist_addr_match_i > NULL), N80_6, -0.00075510955));

N80_4 :=__common__( if(((real)c_lowinc < 82.3500061035), N80_5, 0.013210611));

N80_3 :=__common__( if(trim(C_LOWINC) != '', N80_4, 0.00083571615));

N80_2 :=__common__( if(((real)f_inq_ssns_per_addr_i < 2.5), N80_3, 0.0054058326));

N80_1 :=__common__( if(((real)f_inq_ssns_per_addr_i > NULL), N80_2, 0.016369615));

N81_8 :=__common__( if(((real)f_rel_under25miles_cnt_d < 5.5), 0.001081728, 0.01143673));

N81_7 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N81_8, 0.01354696));

N81_6 :=__common__( map(((real)c_comb_age_d <= NULL) => 0.0016993325,
             ((real)c_comb_age_d < 34.5)  => N81_7,
                                             0.0016993325));

N81_5 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.00074725721,
             ((real)f_corrssnaddrcount_d < 2.5)   => 0.0075047008,
                                                     -0.00074725721));

N81_4 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.00063697441,
             ((real)f_sourcerisktype_i < 6.5)   => -0.0073770615,
                                                   0.00063697441));

N81_3 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL)  => N81_5,
             ((integer)f_prevaddrcartheftindex_i < 123) => N81_4,
                                                           N81_5));

N81_2 :=__common__( if(((real)f_inq_other_count24_i < 1.5), N81_3, N81_6));

N81_1 :=__common__( if(((real)f_inq_other_count24_i > NULL), N81_2, 0.00032361305));

N82_10 :=__common__( if(((real)c_easiqlife < 108.5), -0.010309912, -0.00021884707));

N82_9 :=__common__( if(trim(C_EASIQLIFE) != '', N82_10, -0.00033129572));

N82_8 :=__common__( if(((real)f_add_input_nhood_vac_pct_i < 0.0511115938425), N82_9, 0.0026531425));

N82_7 :=__common__( if(((real)f_add_input_nhood_vac_pct_i > NULL), N82_8, 0.028887529));

N82_6 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.013490313,
             ((real)f_rel_felony_count_i < 4.5)   => N82_7,
                                                     0.013490313));

N82_5 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N82_6,
             ((real)f_sourcerisktype_i < 4.5)   => -0.0067467791,
                                                   N82_6));

N82_4 :=__common__( if(((real)c_cpiall < 208.5), 0.012373438, 0.0023559192));

N82_3 :=__common__( if(trim(C_CPIALL) != '', N82_4, 0.0039292854));

N82_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 105.5), N82_3, N82_5));

N82_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N82_2, 0.0049488788));

N83_8 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => 0.009389402,
             ((real)f_srchaddrsrchcount_i < 6.5)   => 0.001410102,
                                                      0.009389402));

N83_7 :=__common__( map(trim(C_LARCENY) = ''      => 0.0064103896,
             ((real)c_larceny < 130.5) => -0.0050485928,
                                          0.0064103896));

N83_6 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => -0.0051351386,
             ((real)r_d32_mos_since_crim_ls_d < 29.5)  => 0.0031498132,
                                                          -0.0051351386));

N83_5 :=__common__( if(((real)c_born_usa < 172.5), N83_6, N83_7));

N83_4 :=__common__( if(trim(C_BORN_USA) != '', N83_5, -0.0018809195));

N83_3 :=__common__( map(((real)r_i60_inq_comm_recency_d <= NULL) => N83_4,
             ((real)r_i60_inq_comm_recency_d < 4.5)   => 0.0069721657,
                                                         N83_4));

N83_2 :=__common__( if(((real)f_sourcerisktype_i < 6.5), N83_3, N83_8));

N83_1 :=__common__( if(((real)f_sourcerisktype_i > NULL), N83_2, 0.00075012851));

N84_10 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.0086442501,
              ((real)c_sub_bus < 152.5) => 0.0012701815,
                                           0.0086442501));

N84_9 :=__common__( if(((real)r_c12_num_nonderogs_d < 8.5), N84_10, -0.0067839718));

N84_8 :=__common__( if(((real)r_c12_num_nonderogs_d > NULL), N84_9, 0.00030614861));

N84_7 :=__common__( if(((real)f_rel_felony_count_i < 3.5), -0.0082588314, 0.0083338589));

N84_6 :=__common__( if(((real)f_rel_felony_count_i > NULL), N84_7, -0.0015218409));

N84_5 :=__common__( map(trim(C_EASIQLIFE) = ''      => N84_8,
             ((real)c_easiqlife < 100.5) => N84_6,
                                            N84_8));

N84_4 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 200.5), 0.012167112, 0.001851367));

N84_3 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N84_4, 0.025230817));

N84_2 :=__common__( if(((real)c_cpiall < 208.5), N84_3, N84_5));

N84_1 :=__common__( if(trim(C_CPIALL) != '', N84_2, 0.00022570413));

N85_7 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.0091438462,
             ((real)f_sourcerisktype_i < 3.5)   => -0.003747725,
                                                   0.0091438462));

N85_6 :=__common__( if(((real)r_f03_input_add_not_most_rec_i < 0.5), 0.0011008719, N85_7));

N85_5 :=__common__( if(((real)r_f03_input_add_not_most_rec_i > NULL), N85_6, -0.029944642));

N85_4 :=__common__( map(((real)f_attr_arrests_i <= NULL) => 0.010029968,
             ((real)f_attr_arrests_i < 0.5)   => -0.0024771481,
                                                 0.010029968));

N85_3 :=__common__( if(((real)f_prevaddrcartheftindex_i < 129.5), N85_4, N85_5));

N85_2 :=__common__( if(((real)f_prevaddrcartheftindex_i > NULL), N85_3, 0.0079292863));

N85_1 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.009298465,
             (segment in ['KMART', 'SEARS FLS'])                => N85_2,
                                                                   -0.009298465));

N86_8 :=__common__( if(((real)c_easiqlife < 112.5), -0.0023545451, 0.010761755));

N86_7 :=__common__( if(trim(C_EASIQLIFE) != '', N86_8, -0.0048566581));

N86_6 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.0010937067,
             (segment in ['SEARS FLS'])                                  => N86_7,
                                                                            -0.0010937067));

N86_5 :=__common__( map(((real)f_inq_auto_count24_i <= NULL) => -0.010545397,
             ((real)f_inq_auto_count24_i < 1.5)   => N86_6,
                                                     -0.010545397));

N86_4 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.0079244487,
             ((real)f_inq_other_count24_i < 2.5)   => N86_5,
                                                      0.0079244487));

N86_3 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.0057921988,
             ((real)f_corrssnaddrcount_d < 4.5)   => N86_4,
                                                     -0.0057921988));

N86_2 :=__common__( if(((real)f_rel_under25miles_cnt_d < 26.5), N86_3, 0.01045402));

N86_1 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N86_2, 0.010624632));

N87_8 :=__common__( map(((real)f_inq_ssns_per_addr_i <= NULL) => 0.0056476917,
             ((real)f_inq_ssns_per_addr_i < 3.5)   => -0.0042957718,
                                                      0.0056476917));

N87_7 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.016537313,
             ((real)f_sourcerisktype_i < 6.5)   => 0.0030801284,
                                                   0.016537313));

N87_6 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL)  => -0.00056406286,
             ((integer)r_d33_eviction_recency_d < 549) => N87_7,
                                                          -0.00056406286));

N87_5 :=__common__( map(((real)r_c20_email_domain_isp_count_i <= NULL) => -0.0042579133,
             ((real)r_c20_email_domain_isp_count_i < 0.5)   => 0.004190128,
                                                               -0.0042579133));

N87_4 :=__common__( if(((integer)r_l80_inp_avm_autoval_d < 20829), 0.012346333, N87_5));

N87_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N87_4, N87_6));

N87_2 :=__common__( if(((real)f_corrphonelastnamecount_d < 0.5), N87_3, N87_8));

N87_1 :=__common__( if(((real)f_corrphonelastnamecount_d > NULL), N87_2, 0.0040154201));

N88_9 :=__common__( map(((real)r_d31_mostrec_bk_i <= NULL) => -0.011827415,
             ((real)r_d31_mostrec_bk_i < 1.5)   => 0.0030695534,
                                                   -0.011827415));

N88_8 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => -0.0066895443,
             ((real)r_c12_num_nonderogs_d < 8.5)   => N88_9,
                                                      -0.0066895443));

N88_7 :=__common__( map(((real)f_mos_liens_unrel_lt_fseen_d <= NULL) => -0.0081196959,
             ((real)f_mos_liens_unrel_lt_fseen_d < 156.5) => 0.0085657317,
                                                             -0.0081196959));

N88_6 :=__common__( map(trim(C_EASIQLIFE) = ''      => N88_8,
             ((real)c_easiqlife < 100.5) => N88_7,
                                            N88_8));

N88_5 :=__common__( if(((real)r_d31_mostrec_bk_i > NULL), N88_6, 0.0015212188));

N88_4 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 85.5), 0.013659486, 0.0028174811));

N88_3 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N88_4, -0.0038375948));

N88_2 :=__common__( if(((real)c_cpiall < 208.5), N88_3, N88_5));

N88_1 :=__common__( if(trim(C_CPIALL) != '', N88_2, -0.0014774748));

N89_7 :=__common__( map(((real)f_inq_auto_count24_i <= NULL) => -0.0071749751,
             ((real)f_inq_auto_count24_i < 1.5)   => 0.0070874529,
                                                     -0.0071749751));

N89_6 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)    => -6.2396373e-005,
             ((integer)f_prevaddrmedianincome_d < 45688) => N89_7,
                                                            -6.2396373e-005));

N89_5 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N89_6,
             ((real)f_sourcerisktype_i < 3.5)   => -0.0063183178,
                                                   N89_6));

N89_4 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => N89_5,
             ((real)f_srchaddrsrchcount_i < 3.5)   => -0.0025308467,
                                                      N89_5));

N89_3 :=__common__( map(((real)r_d31_mostrec_bk_i <= NULL) => -0.0081262124,
             ((real)r_d31_mostrec_bk_i < 1.5)   => N89_4,
                                                   -0.0081262124));

N89_2 :=__common__( if(((real)f_srchunvrfdssncount_i < 1.5), N89_3, 0.012130497));

N89_1 :=__common__( if(((real)f_srchunvrfdssncount_i > NULL), N89_2, 0.0016306579));

N90_9 :=__common__( if(((real)r_l80_inp_avm_autoval_d < 36569.5), 0.010627125, 0.00044249023));

N90_8 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N90_9, 0.0027291964));

N90_7 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => 0.015529666,
             ((real)r_c14_addrs_5yr_i < 8.5)   => N90_8,
                                                  0.015529666));

N90_6 :=__common__( map(((real)r_d31_mostrec_bk_i <= NULL) => -0.0085658382,
             ((real)r_d31_mostrec_bk_i < 1.5)   => N90_7,
                                                   -0.0085658382));

N90_5 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => -0.0052455151,
             ((real)f_prevaddrmedianincome_d < 36214.5) => 0.00096023091,
                                                           -0.0052455151));

N90_4 :=__common__( if(((real)r_f03_input_add_not_most_rec_i < 0.5), N90_5, N90_6));

N90_3 :=__common__( if(((real)r_f03_input_add_not_most_rec_i > NULL), N90_4, 0.0022938257));

N90_2 :=__common__( if(((real)f_srchunvrfdaddrcount_i < 0.5), N90_3, 0.0062259524));

N90_1 :=__common__( if(((real)f_srchunvrfdaddrcount_i > NULL), N90_2, 0.0029343603));

N91_8 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.0048247354,
             ((real)r_c14_addrs_10yr_i < 9.5)   => -0.0025242587,
                                                   0.0048247354));

N91_7 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.0085567794,
             ((real)f_sourcerisktype_i < 6.5)   => N91_8,
                                                   0.0085567794));

N91_6 :=__common__( map(((real)f_assocrisktype_i <= NULL) => N91_7,
             ((real)f_assocrisktype_i < 4.5)   => -0.003849145,
                                                  N91_7));

N91_5 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.0038627484,
             ((real)f_corrssnaddrcount_d < 2.5)   => 0.004523292,
                                                     -0.0038627484));

N91_4 :=__common__( if(((real)r_l80_inp_avm_autoval_d < 20561.5), 0.0077406603, N91_5));

N91_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N91_4, N91_6));

N91_2 :=__common__( if(((real)f_varrisktype_i < 5.5), N91_3, 0.0069831438));

N91_1 :=__common__( if(((real)f_varrisktype_i > NULL), N91_2, -0.00047039241));

N92_8 :=__common__( map(((real)r_c18_invalid_addrs_per_adl_i <= NULL) => -0.0044643994,
             ((real)r_c18_invalid_addrs_per_adl_i < 4.5)   => 0.008034093,
                                                              -0.0044643994));

N92_7 :=__common__( if(((real)c_cpiall < 208.5), 0.018257448, N92_8));

N92_6 :=__common__( if(trim(C_CPIALL) != '', N92_7, 0.0087015447));

N92_5 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => N92_6,
             ((real)r_d32_criminal_count_i < 1.5)   => 0.00077623303,
                                                       N92_6));

N92_4 :=__common__( map(((real)f_srchvelocityrisktype_i <= NULL) => -0.0013403379,
             ((real)f_srchvelocityrisktype_i < 2.5)   => -0.0086679403,
                                                         -0.0013403379));

N92_3 :=__common__( map(((real)f_divaddrsuspidcountnew_i <= NULL) => 0.010039221,
             ((real)f_divaddrsuspidcountnew_i < 2.5)   => N92_4,
                                                          0.010039221));

N92_2 :=__common__( if(((real)c_hist_addr_match_i < 2.5), N92_3, N92_5));

N92_1 :=__common__( if(((real)c_hist_addr_match_i > NULL), N92_2, -0.0020936359));

N93_7 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => 0.0046469933,
             (segment in ['SEARS FLS'])                                  => 0.014471173,
                                                                            0.0046469933));

N93_6 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.0051616279,
             ((real)r_d32_criminal_count_i < 1.5)   => -0.0014421744,
                                                       0.0051616279));

N93_5 :=__common__( map(((real)r_d33_eviction_count_i <= NULL) => N93_7,
             ((real)r_d33_eviction_count_i < 0.5)   => N93_6,
                                                       N93_7));

N93_4 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.0026498718,
             ((real)f_sourcerisktype_i < 4.5)   => -0.005361254,
                                                   0.0026498718));

N93_3 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)    => -0.0051534256,
             ((integer)f_prevaddrmedianincome_d < 39140) => N93_4,
                                                            -0.0051534256));

N93_2 :=__common__( if(((real)c_hist_addr_match_i < 2.5), N93_3, N93_5));

N93_1 :=__common__( if(((real)c_hist_addr_match_i > NULL), N93_2, -0.00060915162));

N94_8 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.0085088258,
             (segment in ['KMART', 'SEARS FLS'])                => 0.0051938167,
                                                                   -0.0085088258));

N94_7 :=__common__( map(trim(C_URBAN_P) = ''              => N94_8,
             ((real)c_urban_p < 99.9499969482) => -0.0056353844,
                                                  N94_8));

N94_6 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => -0.0058352437,
             ((real)r_c10_m_hdr_fs_d < 285.5) => N94_7,
                                                 -0.0058352437));

N94_5 :=__common__( if(((real)c_retail < 9.85000038147), N94_6, -0.0037386164));

N94_4 :=__common__( if(trim(C_RETAIL) != '', N94_5, -0.002902844));

N94_3 :=__common__( map(((real)f_assocsuspicousidcount_i <= NULL) => 0.016082685,
             ((real)f_assocsuspicousidcount_i < 16.5)  => N94_4,
                                                          0.016082685));

N94_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 42.5), 0.0053470173, N94_3));

N94_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N94_2, 0.00033899037));

N95_7 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => 0.0035192312,
             ((real)r_d32_felony_count_i < 0.5)   => -0.0038250056,
                                                     0.0035192312));

N95_6 :=__common__( map(((real)f_assoccredbureaucount_i <= NULL) => 0.0095848325,
             ((real)f_assoccredbureaucount_i < 5.5)   => N95_7,
                                                         0.0095848325));

N95_5 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => 0.011707873,
             ((real)r_c21_m_bureau_adl_fs_d < 114.5) => -0.0018308026,
                                                        0.011707873));

N95_4 :=__common__( map((fp_segment in ['2 NAS 479', '3 New DID', '4 Bureau Only', '6 Recent Activity', '7 Other']) => N95_5,
             (fp_segment in ['1 SSN Prob', '5 Derog'])                                                   => 0.0089373209,
                                                                                                            N95_5));

N95_3 :=__common__( map(((real)c_comb_age_d <= NULL) => N95_6,
             ((real)c_comb_age_d < 28.5)  => N95_4,
                                             N95_6));

N95_2 :=__common__( if(((real)f_divaddrsuspidcountnew_i < 2.5), N95_3, 0.010953905));

N95_1 :=__common__( if(((real)f_divaddrsuspidcountnew_i > NULL), N95_2, 0.0071415228));

N96_8 :=__common__( map(((real)f_inq_ssns_per_addr_i <= NULL) => 0.014742453,
             ((real)f_inq_ssns_per_addr_i < 2.5)   => 0.003972837,
                                                      0.014742453));

N96_7 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.0027936331,
             ((real)r_c14_addrs_10yr_i < 3.5)   => -0.0055133038,
                                                   0.0027936331));

N96_6 :=__common__( if(((real)c_urban_p < 99.25), -0.006711456, N96_7));

N96_5 :=__common__( if(trim(C_URBAN_P) != '', N96_6, 0.0057473846));

N96_4 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N96_8,
             ((real)f_sourcerisktype_i < 6.5)   => N96_5,
                                                   N96_8));

N96_3 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N96_4,
             ((real)c_hist_addr_match_i < 1.5)   => -0.0040332034,
                                                    N96_4));

N96_2 :=__common__( if(((real)f_rel_felony_count_i < 3.5), N96_3, 0.0057325273));

N96_1 :=__common__( if(((real)f_rel_felony_count_i > NULL), N96_2, -0.0055572886));

N97_8 :=__common__( map(trim(C_FINANCE) = ''              => 0.0033319038,
             ((real)c_finance < 1.54999995232) => 0.0095459925,
                                                  0.0033319038));

N97_7 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N97_8,
             ((real)f_sourcerisktype_i < 4.5)   => 2.44989e-005,
                                                   N97_8));

N97_6 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.007407652,
             (segment in ['KMART', 'SEARS FLS'])                => N97_7,
                                                                   -0.007407652));

N97_5 :=__common__( map(((real)r_c20_email_domain_isp_count_i <= NULL) => -0.00118167,
             ((real)r_c20_email_domain_isp_count_i < 0.5)   => N97_6,
                                                               -0.00118167));

N97_4 :=__common__( if(((real)f_inq_auto_count24_i < 1.5), N97_5, -0.0082622938));

N97_3 :=__common__( if(((real)f_inq_auto_count24_i > NULL), N97_4, 0.010715455));

N97_2 :=__common__( if(((real)c_no_car < 102.5), -0.0033839318, N97_3));

N97_1 :=__common__( if(trim(C_NO_CAR) != '', N97_2, -0.00032197279));

N98_8 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => -0.0010556332,
             ((real)f_srchfraudsrchcount_i < 4.5)   => -0.006806115,
                                                       -0.0010556332));

N98_7 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.013699926,
             ((real)f_add_curr_nhood_vac_pct_i < 0.0404313392937) => 0.00073300429,
                                                                     0.013699926));

N98_6 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => 0.00018562875,
             ((real)f_corrssnaddrcount_d < 3.5)   => N98_7,
                                                     0.00018562875));

N98_5 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.00045565908,
             ((real)r_c20_email_count_i < 0.5)   => N98_6,
                                                    -0.00045565908));

N98_4 :=__common__( if(((real)c_construction < 2.95000004768), N98_5, N98_8));

N98_3 :=__common__( if(trim(C_CONSTRUCTION) != '', N98_4, 0.0012382388));

N98_2 :=__common__( if(((real)r_d32_criminal_count_i < 6.5), N98_3, 0.0054811211));

N98_1 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N98_2, 0.00061210371));

N99_9 :=__common__( if(((real)c_inc_100k_p < 3.25), 0.0050469289, -0.0027906135));

N99_8 :=__common__( if(trim(C_INC_100K_P) != '', N99_9, -0.0023960013));

N99_7 :=__common__( map(((real)f_divaddrsuspidcountnew_i <= NULL) => 0.0093382912,
             ((real)f_divaddrsuspidcountnew_i < 2.5)   => N99_8,
                                                          0.0093382912));

N99_6 :=__common__( map(((real)f_attr_arrests_i <= NULL) => 0.007434091,
             ((real)f_attr_arrests_i < 0.5)   => N99_7,
                                                 0.007434091));

N99_5 :=__common__( if(((real)f_inq_adls_per_addr_i < 4.5), N99_6, 0.011646587));

N99_4 :=__common__( if(((real)f_inq_adls_per_addr_i > NULL), N99_5, 0.027306082));

N99_3 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => 0.013438295,
             ((real)r_c14_addrs_5yr_i < 6.5)   => 0.002497214,
                                                  0.013438295));

N99_2 :=__common__( if(((integer)r_d33_eviction_recency_d < 48), N99_3, N99_4));

N99_1 :=__common__( if(((real)r_d33_eviction_recency_d > NULL), N99_2, -0.0052819825));

N100_9 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL)  => 0.004182418,
              ((integer)f_curraddrcartheftindex_i < 108) => -0.0035054555,
                                                            0.004182418));

N100_8 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.0086025378,
              ((real)f_inq_other_count24_i < 1.5)   => N100_9,
                                                       0.0086025378));

N100_7 :=__common__( if(((real)f_rel_under25miles_cnt_d < 11.5), -0.0023615466, 0.004574148));

N100_6 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N100_7, 0.01153555));

N100_5 :=__common__( if(((real)c_unempl < 192.5), N100_6, 0.012929951));

N100_4 :=__common__( if(trim(C_UNEMPL) != '', N100_5, -0.0041909079));

N100_3 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)    => -0.0039245304,
              ((integer)f_prevaddrmedianincome_d < 35948) => N100_4,
                                                             -0.0039245304));

N100_2 :=__common__( if(((real)r_f03_input_add_not_most_rec_i < 0.5), N100_3, N100_8));

N100_1 :=__common__( if(((real)r_f03_input_add_not_most_rec_i > NULL), N100_2, 0.0081872272));

N101_10 :=__common__( if(((real)c_vacant_p < 16.6500015259), 0.0026062667, 0.014905401));

N101_9 :=__common__( if(trim(C_VACANT_P) != '', N101_10, -0.012953335));

N101_8 :=__common__( if(((real)c_born_usa < 115.5), -0.004566229, 0.0020520407));

N101_7 :=__common__( if(trim(C_BORN_USA) != '', N101_8, 0.0031998567));

N101_6 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => N101_7,
              (segment in ['SEARS FLS'])                                  => N101_9,
                                                                             N101_7));

N101_5 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => N101_6,
              ((integer)r_i60_inq_auto_recency_d < 549) => -0.0051325231,
                                                           N101_6));

N101_4 :=__common__( if(((real)f_varrisktype_i < 7.5), N101_5, 0.012221948));

N101_3 :=__common__( if(((real)f_varrisktype_i > NULL), N101_4, 0.00375925));

N101_2 :=__common__( if(((real)r_l79_adls_per_addr_c6_i < 4.5), N101_3, 0.010000559));

N101_1 :=__common__( if(((real)r_l79_adls_per_addr_c6_i > NULL), N101_2, 0.0068044222));

N102_8 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.020291221,
              ((real)c_easiqlife < 113.5) => 0.0040274523,
                                             0.020291221));

N102_7 :=__common__( map((segment in ['KMART'])                                          => 0.0041556983,
              (segment in ['RETAIL', 'SEARS AUTO', 'SEARS FLS', 'SEARS SHO']) => N102_8,
                                                                                 N102_8));

N102_6 :=__common__( if(((real)c_finance < 1.45000004768), N102_7, 0.00074163351));

N102_5 :=__common__( if(trim(C_FINANCE) != '', N102_6, 0.033861717));

N102_4 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL) => N102_5,
              ((real)f_prevaddrcartheftindex_i < 124.5) => -0.00037003795,
                                                           N102_5));

N102_3 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.0085916753,
              (segment in ['KMART', 'SEARS FLS'])                => N102_4,
                                                                    -0.0085916753));

N102_2 :=__common__( if(((real)r_c20_email_domain_isp_count_i < 0.5), N102_3, -0.0031698088));

N102_1 :=__common__( if(((real)r_c20_email_domain_isp_count_i > NULL), N102_2, -0.0007627527));

N103_9 :=__common__( if(((real)f_rel_under25miles_cnt_d < 12.5), 0.0007597544, 0.0077291896));

N103_8 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N103_9, 0.009030543));

N103_7 :=__common__( map(((real)r_i60_inq_comm_recency_d <= NULL)  => -0.0020435919,
              ((integer)r_i60_inq_comm_recency_d < 549) => 0.0038138453,
                                                           -0.0020435919));

N103_6 :=__common__( map(((real)f_corrphonelastnamecount_d <= NULL) => -0.0041856693,
              ((real)f_corrphonelastnamecount_d < 0.5)   => N103_7,
                                                            -0.0041856693));

N103_5 :=__common__( if(((real)r_phn_pcs_n < 0.5), N103_6, -0.0062221145));

N103_4 :=__common__( if(((real)r_phn_pcs_n > NULL), N103_5, -0.02926288));

N103_3 :=__common__( map(((real)r_f00_input_dob_match_level_d <= NULL) => N103_4,
              ((real)r_f00_input_dob_match_level_d < 5.5)   => 0.012169976,
                                                               N103_4));

N103_2 :=__common__( if(((real)f_srchunvrfdssncount_i < 0.5), N103_3, N103_8));

N103_1 :=__common__( if(((real)f_srchunvrfdssncount_i > NULL), N103_2, -0.0079596823));

N104_8 :=__common__( map(((real)f_rel_incomeover50_count_d <= NULL) => 0.0025397784,
              ((real)f_rel_incomeover50_count_d < 0.5)   => 0.010915283,
                                                            0.0025397784));

N104_7 :=__common__( map(trim(C_BORN_USA) = ''      => 0.0010082883,
              ((real)c_born_usa < 122.5) => -0.0078730846,
                                            0.0010082883));

N104_6 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.0040687866,
              ((real)c_easiqlife < 138.5) => N104_7,
                                             0.0040687866));

N104_5 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => N104_8,
              ((real)f_rel_felony_count_i < 0.5)   => N104_6,
                                                      N104_8));

N104_4 :=__common__( map(((real)c_inf_fname_verd_d <= NULL) => -0.0055944681,
              ((real)c_inf_fname_verd_d < 0.5)   => N104_5,
                                                    -0.0055944681));

N104_3 :=__common__( if(trim(C_CPIALL) != '', N104_4, -0.0016703682));

N104_2 :=__common__( if(((real)f_inq_auto_count24_i < 1.5), N104_3, -0.0090289245));

N104_1 :=__common__( if(((real)f_inq_auto_count24_i > NULL), N104_2, -0.013621174));

N105_7 :=__common__( map(((real)f_fp_prevaddrcrimeindex_i <= NULL)  => 0.0037782214,
              ((integer)f_fp_prevaddrcrimeindex_i < 140) => -0.0021949417,
                                                            0.0037782214));

N105_6 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => N105_7,
              ((real)f_corrssnaddrcount_d < 2.5)   => 0.0070595812,
                                                      N105_7));

N105_5 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => N105_6,
              ((real)f_srchaddrsrchcount_i < 3.5)   => -0.0034528989,
                                                       N105_6));

N105_4 :=__common__( map(((real)f_corrssnnamecount_d <= NULL) => -0.0065223042,
              ((real)f_corrssnnamecount_d < 7.5)   => N105_5,
                                                      -0.0065223042));

N105_3 :=__common__( map(((real)f_attr_arrests_i <= NULL) => 0.0069937767,
              ((real)f_attr_arrests_i < 0.5)   => N105_4,
                                                  0.0069937767));

N105_2 :=__common__( if(((real)f_assoccredbureaucount_i < 5.5), N105_3, 0.011114835));

N105_1 :=__common__( if(((real)f_assoccredbureaucount_i > NULL), N105_2, -0.00096823816));

N106_7 :=__common__( map(((real)f_srchvelocityrisktype_i <= NULL) => 0.0013718566,
              ((real)f_srchvelocityrisktype_i < 4.5)   => -0.0045936366,
                                                          0.0013718566));

N106_6 :=__common__( if(((integer)r_a46_curr_avm_autoval_d < 20271), 0.0077667767, -0.0012821905));

N106_5 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N106_6, N106_7));

N106_4 :=__common__( map(((real)f_attr_arrests_i <= NULL) => 0.008672424,
              ((real)f_attr_arrests_i < 0.5)   => N106_5,
                                                  0.008672424));

N106_3 :=__common__( if(((real)f_rel_felony_count_i < 6.5), N106_4, 0.012128142));

N106_2 :=__common__( if(((real)f_rel_felony_count_i > NULL), N106_3, 0.0025301743));

N106_1 :=__common__( map(((real)c_inf_fname_verd_d <= NULL) => -0.0064440286,
              ((real)c_inf_fname_verd_d < 0.5)   => N106_2,
                                                    -0.0064440286));

N107_8 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.012801286,
              ((real)c_sub_bus < 134.5) => 0.0031698374,
                                           0.012801286));

N107_7 :=__common__( if(((real)c_easiqlife < 116.5), -0.001604857, N107_8));

N107_6 :=__common__( if(trim(C_EASIQLIFE) != '', N107_7, -0.0025973344));

N107_5 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N107_6,
              ((real)f_sourcerisktype_i < 5.5)   => -0.0024604991,
                                                    N107_6));

N107_4 :=__common__( map(((real)c_inf_fname_verd_d <= NULL) => -0.0074852389,
              ((real)c_inf_fname_verd_d < 0.5)   => N107_5,
                                                    -0.0074852389));

N107_3 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.0049956549,
              ((real)f_inq_other_count24_i < 2.5)   => N107_4,
                                                       0.0049956549));

N107_2 :=__common__( if(((real)f_curraddrmurderindex_i < 198.5), N107_3, 0.013919556));

N107_1 :=__common__( if(((real)f_curraddrmurderindex_i > NULL), N107_2, -0.0060384295));

N108_8 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.0055542345,
              ((real)f_add_curr_nhood_vac_pct_i < 0.0464713796973) => 0.00037900934,
                                                                      0.0055542345));

N108_7 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.0024189544,
              ((real)f_corrssnaddrcount_d < 4.5)   => N108_8,
                                                      -0.0024189544));

N108_6 :=__common__( if(((real)c_inc_75k_p < 8.75), 0.010765463, 0.00016236755));

N108_5 :=__common__( if(trim(C_INC_75K_P) != '', N108_6, -0.0058269495));

N108_4 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.0044782366,
              ((real)r_c20_email_count_i < 0.5)   => N108_5,
                                                     -0.0044782366));

N108_3 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => N108_7,
              ((real)f_inq_other_count24_i < 0.5)   => N108_4,
                                                       N108_7));

N108_2 :=__common__( if(((real)f_assocsuspicousidcount_i < 17.5), N108_3, 0.014413742));

N108_1 :=__common__( if(((real)f_assocsuspicousidcount_i > NULL), N108_2, 0.0057166686));

N109_9 :=__common__( if(((real)f_rel_under25miles_cnt_d < 12.5), -0.0031121636, 0.002890926));

N109_8 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N109_9, 0.013983061));

N109_7 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), 0.015240714, 0.001770939));

N109_6 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => N109_7,
              ((real)f_curraddrmedianincome_d < 27962.5) => 0.011434514,
                                                            N109_7));

N109_5 :=__common__( map(((real)c_comb_age_d <= NULL) => N109_8,
              ((real)c_comb_age_d < 29.5)  => N109_6,
                                              N109_8));

N109_4 :=__common__( if(((real)c_trailer_p < 1.34999990463), -0.00045658822, -0.0082551788));

N109_3 :=__common__( if(trim(C_TRAILER_P) != '', N109_4, -0.0029574367));

N109_2 :=__common__( if(((real)f_srchvelocityrisktype_i < 4.5), N109_3, N109_5));

N109_1 :=__common__( if(((real)f_srchvelocityrisktype_i > NULL), N109_2, -0.0040480926));

N110_8 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => 0.00033249599,
              ((real)f_srchfraudsrchcount_i < 3.5)   => -0.0051819577,
                                                        0.00033249599));

N110_7 :=__common__( if(((real)c_unemp < 9.44999980927), 0.0037930775, 0.013878897));

N110_6 :=__common__( if(trim(C_UNEMP) != '', N110_7, 0.0036219873));

N110_5 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.0011822151,
              ((real)f_corrssnaddrcount_d < 3.5)   => N110_6,
                                                      -0.0011822151));

N110_4 :=__common__( map(((real)r_c20_email_count_i <= NULL) => N110_8,
              ((real)r_c20_email_count_i < 0.5)   => N110_5,
                                                     N110_8));

N110_3 :=__common__( map(((real)f_srchcomponentrisktype_i <= NULL) => 0.01002501,
              ((real)f_srchcomponentrisktype_i < 2.5)   => N110_4,
                                                           0.01002501));

N110_2 :=__common__( if(((real)f_inq_auto_count24_i < 1.5), N110_3, -0.0082179586));

N110_1 :=__common__( if(((real)f_inq_auto_count24_i > NULL), N110_2, 0.0094344918));

N111_9 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => 0.0011618411,
              ((real)f_srchfraudsrchcount_i < 10.5)  => -0.0063832242,
                                                        0.0011618411));

N111_8 :=__common__( if(((real)c_pop_75_84_p < 2.54999995232), 0.0084350876, 0.001487647));

N111_7 :=__common__( if(trim(C_POP_75_84_P) != '', N111_8, 0.0004979224));

N111_6 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => -0.0035917178,
              ((real)f_prevaddrmedianincome_d < 34388.5) => 0.0028719594,
                                                            -0.0035917178));

N111_5 :=__common__( if(((real)r_f03_input_add_not_most_rec_i < 0.5), N111_6, N111_7));

N111_4 :=__common__( if(((real)r_f03_input_add_not_most_rec_i > NULL), N111_5, 0.033896106));

N111_3 :=__common__( map(((real)f_divrisktype_i <= NULL) => 0.01230238,
              ((real)f_divrisktype_i < 4.5)   => N111_4,
                                                 0.01230238));

N111_2 :=__common__( if(((real)r_c20_email_domain_isp_count_i < 0.5), N111_3, N111_9));

N111_1 :=__common__( if(((real)r_c20_email_domain_isp_count_i > NULL), N111_2, -0.0013132059));

N112_9 :=__common__( map(((real)f_inq_adls_per_addr_i <= NULL) => 0.011392949,
              ((real)f_inq_adls_per_addr_i < 2.5)   => 0.0027105408,
                                                       0.011392949));

N112_8 :=__common__( if(((real)f_rel_incomeover50_count_d < 3.5), N112_9, -0.0031207016));

N112_7 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N112_8, 0.012126136));

N112_6 :=__common__( map(((real)f_varmsrcssncount_i <= NULL) => 0.0089799675,
              ((real)f_varmsrcssncount_i < 1.5)   => N112_7,
                                                     0.0089799675));

N112_5 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => -0.0033063754,
              ((real)r_c10_m_hdr_fs_d < 285.5) => N112_6,
                                                  -0.0033063754));

N112_4 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.0516914613545), -0.0025787325, N112_5));

N112_3 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N112_4, -0.034020606));

N112_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 18.5), 0.0068562438, N112_3));

N112_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N112_2, 0.0045426842));

N113_8 :=__common__( map(((real)f_srchunvrfdaddrcount_i <= NULL) => 0.013363815,
              ((real)f_srchunvrfdaddrcount_i < 1.5)   => 0.002889274,
                                                         0.013363815));

N113_7 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.0072848182,
              (segment in ['KMART', 'SEARS FLS'])                => N113_8,
                                                                    -0.0072848182));

N113_6 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.0040427941,
              ((real)r_c20_email_count_i < 5.5)   => N113_7,
                                                     -0.0040427941));

N113_5 :=__common__( if(((real)c_cpiall < 224.399993896), N113_6, -0.012318182));

N113_4 :=__common__( if(trim(C_CPIALL) != '', N113_5, 0.0046750084));

N113_3 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => N113_4,
              ((integer)f_curraddrcartheftindex_i < 94) => -0.0037777001,
                                                           N113_4));

N113_2 :=__common__( if(((real)f_assoccredbureaucount_i < 7.5), N113_3, 0.016446818));

N113_1 :=__common__( if(((real)f_assoccredbureaucount_i > NULL), N113_2, 0.00081973991));

N114_9 :=__common__( map(((real)f_add_input_has_mfd_ct_i <= NULL) => 0.0041735728,
              ((real)f_add_input_has_mfd_ct_i < 0.5)   => 0.014264452,
                                                          0.0041735728));

N114_8 :=__common__( map(((real)f_inq_auto_count24_i <= NULL) => -0.0029657721,
              ((real)f_inq_auto_count24_i < 0.5)   => N114_9,
                                                      -0.0029657721));

N114_7 :=__common__( if(((real)c_construction < 1.65000009537), N114_8, -0.00032084326));

N114_6 :=__common__( if(trim(C_CONSTRUCTION) != '', N114_7, 0.0020673147));

N114_5 :=__common__( map(((real)r_d31_mostrec_bk_i <= NULL) => -0.0061862784,
              ((real)r_d31_mostrec_bk_i < 1.5)   => N114_6,
                                                    -0.0061862784));

N114_4 :=__common__( if(((real)r_phn_pcs_n < 0.5), N114_5, -0.004225946));

N114_3 :=__common__( if(((real)r_phn_pcs_n > NULL), N114_4, -0.036005765));

N114_2 :=__common__( if(((real)f_inq_communications_count24_i < 5.5), N114_3, 0.0098570482));

N114_1 :=__common__( if(((real)f_inq_communications_count24_i > NULL), N114_2, -0.0026519106));

N115_8 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.0037734892,
              ((real)f_inq_other_count24_i < 2.5)   => -0.0025398773,
                                                       0.0037734892));

N115_7 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.0037255127,
              ((real)r_d32_criminal_count_i < 5.5)   => N115_8,
                                                        0.0037255127));

N115_6 :=__common__( map(trim(C_HOUSINGCPI) = ''              => 0.012908685,
              ((real)c_housingcpi < 236.350006104) => N115_7,
                                                      0.012908685));

N115_5 :=__common__( map(((real)r_f00_input_dob_match_level_d <= NULL) => N115_6,
              ((real)r_f00_input_dob_match_level_d < 4.5)   => 0.012770024,
                                                               N115_6));

N115_4 :=__common__( if(((real)c_cpiall < 224.399993896), N115_5, -0.013321003));

N115_3 :=__common__( if(trim(C_CPIALL) != '', N115_4, 0.0024430284));

N115_2 :=__common__( if(((real)f_inq_communications_count24_i < 4.5), N115_3, 0.0082147694));

N115_1 :=__common__( if(((real)f_inq_communications_count24_i > NULL), N115_2, -0.0028576768));

N116_7 :=__common__( map(((real)r_d32_felony_count_i <= NULL) => 0.0075153479,
              ((real)r_d32_felony_count_i < 0.5)   => -0.0015557227,
                                                      0.0075153479));

N116_6 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => 0.0074980144,
              ((real)f_add_curr_nhood_vac_pct_i < 0.179700255394) => N116_7,
                                                                     0.0074980144));

N116_5 :=__common__( map(((real)f_inq_lnames_per_addr_i <= NULL) => 0.0057943303,
              ((real)f_inq_lnames_per_addr_i < 1.5)   => N116_6,
                                                         0.0057943303));

N116_4 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => -0.004521848,
              ((real)f_m_bureau_adl_fs_all_d < 297.5) => N116_5,
                                                         -0.004521848));

N116_3 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL) => N116_4,
              ((real)f_prevaddrcartheftindex_i < 95.5)  => -0.0034805628,
                                                           N116_4));

N116_2 :=__common__( if(((real)r_d30_derog_count_i < 16.5), N116_3, 0.0080775215));

N116_1 :=__common__( if(((real)r_d30_derog_count_i > NULL), N116_2, 0.0017280563));

N117_8 :=__common__( map(((real)c_comb_age_d <= NULL) => 0.0011894431,
              ((real)c_comb_age_d < 28.5)  => 0.0070639358,
                                              0.0011894431));

N117_7 :=__common__( if(((real)c_blue_empl < 175.5), 0.0036986226, -0.0096765651));

N117_6 :=__common__( if(trim(C_BLUE_EMPL) != '', N117_7, -0.0036039224));

N117_5 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.0046869502,
              ((real)r_c20_email_count_i < 0.5)   => N117_6,
                                                     -0.0046869502));

N117_4 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => N117_8,
              ((real)f_srchfraudsrchcount_i < 3.5)   => N117_5,
                                                        N117_8));

N117_3 :=__common__( map(((real)r_i60_inq_auto_count12_i <= NULL) => -0.0099181765,
              ((real)r_i60_inq_auto_count12_i < 1.5)   => N117_4,
                                                          -0.0099181765));

N117_2 :=__common__( if(((real)f_liens_rel_cj_total_amt_i < 738.5), N117_3, -0.0090045908));

N117_1 :=__common__( if(((real)f_liens_rel_cj_total_amt_i > NULL), N117_2, -0.0023633464));

N118_9 :=__common__( map(((real)f_assocrisktype_i <= NULL) => 0.0048950944,
              ((real)f_assocrisktype_i < 2.5)   => -0.0037403624,
                                                   0.0048950944));

N118_8 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.00066281616,
              ((real)f_corrssnaddrcount_d < 2.5)   => 0.0098211499,
                                                      -0.00066281616));

N118_7 :=__common__( if(((integer)r_l80_inp_avm_autoval_d < 19550), 0.014305748, N118_8));

N118_6 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N118_7, N118_9));

N118_5 :=__common__( if(((real)f_rel_under25miles_cnt_d < 20.5), -0.00010545405, 0.0098374774));

N118_4 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N118_5, 0.015833176));

N118_3 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => -0.0034879484,
              ((real)f_prevaddrmedianincome_d < 30941.5) => N118_4,
                                                            -0.0034879484));

N118_2 :=__common__( if(((real)c_hist_addr_match_i < 3.5), N118_3, N118_6));

N118_1 :=__common__( if(((real)c_hist_addr_match_i > NULL), N118_2, 0.0027285906));

N119_8 :=__common__( if(((real)c_sub_bus < 151.5), 0.0005869235, 0.0072579718));

N119_7 :=__common__( if(trim(C_SUB_BUS) != '', N119_8, -0.007582018));

N119_6 :=__common__( map(((real)f_divrisktype_i <= NULL) => 0.012659343,
              ((real)f_divrisktype_i < 3.5)   => N119_7,
                                                 0.012659343));

N119_5 :=__common__( map(((real)f_inq_auto_count24_i <= NULL) => -0.007502093,
              ((real)f_inq_auto_count24_i < 1.5)   => N119_6,
                                                      -0.007502093));

N119_4 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => -0.0083994488,
              ((real)f_m_bureau_adl_fs_all_d < 324.5) => N119_5,
                                                         -0.0083994488));

N119_3 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N119_4,
              ((real)c_hist_addr_match_i < 1.5)   => -0.003778383,
                                                     N119_4));

N119_2 :=__common__( if(((real)r_d33_eviction_recency_d < 79.5), 0.0045753766, N119_3));

N119_1 :=__common__( if(((real)r_d33_eviction_recency_d > NULL), N119_2, 0.00097894573));

N120_8 :=__common__( map(trim(C_UNEMP) = ''              => 0.021692928,
              ((real)c_unemp < 6.55000019073) => 0.0082496052,
                                                 0.021692928));

N120_7 :=__common__( if(((integer)r_i60_inq_auto_recency_d < 549), -0.0018286929, N120_8));

N120_6 :=__common__( if(((real)r_i60_inq_auto_recency_d > NULL), N120_7, 0.034512609));

N120_5 :=__common__( map(trim(C_EASIQLIFE) = ''      => N120_6,
              ((real)c_easiqlife < 113.5) => -0.00021668155,
                                             N120_6));

N120_4 :=__common__( map(trim(C_SPAN_LANG) = ''     => -0.0030152121,
              ((real)c_span_lang < 86.5) => 0.0033159696,
                                            -0.0030152121));

N120_3 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => N120_4,
              (segment in ['SEARS FLS'])                                  => N120_5,
                                                                             N120_4));

N120_2 :=__common__( if(((real)c_sub_bus < 110.5), -0.0020747357, N120_3));

N120_1 :=__common__( if(trim(C_SUB_BUS) != '', N120_2, 0.0025267491));

N121_7 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.0064776882,
              ((real)f_rel_felony_count_i < 0.5)   => -0.00081668402,
                                                      0.0064776882));

N121_6 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => -0.0080571778,
              ((real)r_c10_m_hdr_fs_d < 284.5) => 0.0064926543,
                                                  -0.0080571778));

N121_5 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => -0.0035216415,
              ((real)r_d32_mos_since_crim_ls_d < 29.5)  => N121_6,
                                                           -0.0035216415));

N121_4 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N121_7,
              ((real)f_sourcerisktype_i < 6.5)   => N121_5,
                                                    N121_7));

N121_3 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL) => N121_4,
              ((integer)r_d33_eviction_recency_d < 48) => 0.0047432924,
                                                          N121_4));

N121_2 :=__common__( if(((real)f_divaddrsuspidcountnew_i < 2.5), N121_3, 0.0083595891));

N121_1 :=__common__( if(((real)f_divaddrsuspidcountnew_i > NULL), N121_2, 0.0087179393));

N122_8 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.0073889374,
              ((real)f_inq_other_count24_i < 3.5)   => 0.00034830262,
                                                       0.0073889374));

N122_7 :=__common__( map(trim(C_SPAN_LANG) = ''     => -0.0012477189,
              ((real)c_span_lang < 84.5) => 0.0074698761,
                                            -0.0012477189));

N122_6 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => N122_7,
              (segment in ['SEARS FLS'])                                  => 0.010754808,
                                                                             N122_7));

N122_5 :=__common__( map(((real)r_c20_email_count_i <= NULL) => N122_8,
              ((real)r_c20_email_count_i < 0.5)   => N122_6,
                                                     N122_8));

N122_4 :=__common__( if(((real)c_mining < 0.0500000007451), N122_5, -0.0099502706));

N122_3 :=__common__( if(trim(C_MINING) != '', N122_4, -0.0011924955));

N122_2 :=__common__( if(((real)f_corraddrphonecount_d < 0.5), N122_3, -0.0025552281));

N122_1 :=__common__( if(((real)f_corraddrphonecount_d > NULL), N122_2, 0.0022275727));

N123_7 :=__common__( map(((real)r_a50_pb_total_orders_d <= NULL) => -0.0053461679,
              ((real)r_a50_pb_total_orders_d < 3.5)   => 0.0037141188,
                                                         -0.0053461679));

N123_6 :=__common__( if(((real)c_no_labfor < 83.5), 0.013057148, 0.0012702107));

N123_5 :=__common__( if(trim(C_NO_LABFOR) != '', N123_6, -0.0026725102));

N123_4 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => -0.0023979591,
              ((real)f_curraddrmedianincome_d < 27642.5) => N123_5,
                                                            -0.0023979591));

N123_3 :=__common__( if(((real)f_inq_other_count24_i < 0.5), N123_4, N123_7));

N123_2 :=__common__( if(((real)f_inq_other_count24_i > NULL), N123_3, -0.0032888835));

N123_1 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.0080878859,
              (segment in ['KMART', 'SEARS FLS'])                => N123_2,
                                                                    -0.0080878859));

N124_7 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => -0.0021218487,
              ((real)f_srchaddrsrchcount_i < 2.5)   => -0.0079749313,
                                                       -0.0021218487));

N124_6 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => 0.001196388,
              ((real)c_hist_addr_match_i < 4.5)   => N124_7,
                                                     0.001196388));

N124_5 :=__common__( map(((real)f_srchcomponentrisktype_i <= NULL) => 0.0049547791,
              ((real)f_srchcomponentrisktype_i < 1.5)   => N124_6,
                                                           0.0049547791));

N124_4 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => 0.0067330768,
              ((integer)r_i60_inq_auto_recency_d < 549) => -0.0043399203,
                                                           0.0067330768));

N124_3 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => N124_4,
              ((real)f_srchssnsrchcount_i < 0.5)   => -0.0027887034,
                                                      N124_4));

N124_2 :=__common__( if(((real)r_c20_email_count_i < 0.5), N124_3, N124_5));

N124_1 :=__common__( if(((real)r_c20_email_count_i > NULL), N124_2, 0.0069036807));

N125_9 :=__common__( if(((integer)r_a46_curr_avm_autoval_d < 20466), 0.0064804649, -0.0032001417));

N125_8 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N125_9, -0.00023723348));

N125_7 :=__common__( if(((real)r_f03_input_add_not_most_rec_i < 0.5), N125_8, 0.0035211458));

N125_6 :=__common__( if(((real)r_f03_input_add_not_most_rec_i > NULL), N125_7, 0.021624377));

N125_5 :=__common__( map(((real)c_inf_fname_verd_d <= NULL) => -0.0052438489,
              ((real)c_inf_fname_verd_d < 0.5)   => N125_6,
                                                    -0.0052438489));

N125_4 :=__common__( map(((real)f_varrisktype_i <= NULL) => 0.011012253,
              ((real)f_varrisktype_i < 7.5)   => N125_5,
                                                 0.011012253));

N125_3 :=__common__( map(((real)r_c18_invalid_addrs_per_adl_i <= NULL) => -0.0063165141,
              ((real)r_c18_invalid_addrs_per_adl_i < 4.5)   => N125_4,
                                                               -0.0063165141));

N125_2 :=__common__( if(((real)f_assoccredbureaucount_i < 5.5), N125_3, 0.01035876));

N125_1 :=__common__( if(((real)f_assoccredbureaucount_i > NULL), N125_2, -0.0049256585));

N126_10 :=__common__( if(((real)f_rel_under25miles_cnt_d < 28.5), -0.0014239049, 0.010008506));

N126_9 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N126_10, 0.010115627));

N126_8 :=__common__( if(((real)r_f03_input_add_not_most_rec_i < 0.5), 0.0022481865, 0.0098709764));

N126_7 :=__common__( if(((real)r_f03_input_add_not_most_rec_i > NULL), N126_8, -0.029126091));

N126_6 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => N126_9,
              ((real)f_corrssnaddrcount_d < 2.5)   => N126_7,
                                                      N126_9));

N126_5 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => 0.0078082856,
              ((real)r_d30_derog_count_i < 15.5)  => -0.0045901116,
                                                     0.0078082856));

N126_4 :=__common__( if(((real)c_dist_best_to_prev_addr_i < 1.5), N126_5, N126_6));

N126_3 :=__common__( if(((real)c_dist_best_to_prev_addr_i > NULL), N126_4, 0.0028596388));

N126_2 :=__common__( if(((real)r_l79_adls_per_addr_c6_i < 4.5), N126_3, 0.0077285532));

N126_1 :=__common__( if(((real)r_l79_adls_per_addr_c6_i > NULL), N126_2, 0.023016429));

N127_9 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.0044879744,
              ((real)f_inq_other_count24_i < 2.5)   => -0.0028522079,
                                                       0.0044879744));

N127_8 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.011353221,
              ((real)r_d32_criminal_count_i < 1.5)   => 0.0031079029,
                                                        0.011353221));

N127_7 :=__common__( if(((real)c_span_lang < 129.5), N127_8, -0.0016436647));

N127_6 :=__common__( if(trim(C_SPAN_LANG) != '', N127_7, -0.0074894575));

N127_5 :=__common__( if(((real)f_rel_ageover40_count_d < 1.5), N127_6, N127_9));

N127_4 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N127_5, 0.0089749575));

N127_3 :=__common__( map(((real)r_c15_ssns_per_adl_i <= NULL) => 0.0071252216,
              ((real)r_c15_ssns_per_adl_i < 1.5)   => N127_4,
                                                      0.0071252216));

N127_2 :=__common__( if(((real)r_c10_m_hdr_fs_d < 324.5), N127_3, -0.0060353295));

N127_1 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N127_2, -0.0036551383));

N128_8 :=__common__( map(((real)f_rel_under25miles_cnt_d <= NULL) => 0.014964749,
              ((real)f_rel_under25miles_cnt_d < 19.5)  => 0.0025030296,
                                                          0.014964749));

N128_7 :=__common__( map(((real)r_c15_ssns_per_adl_i <= NULL) => N128_8,
              ((real)r_c15_ssns_per_adl_i < 2.5)   => -0.00070344507,
                                                      N128_8));

N128_6 :=__common__( if(((real)c_easiqlife < 113.5), 0.0028677222, 0.01753666));

N128_5 :=__common__( if(trim(C_EASIQLIFE) != '', N128_6, -0.0011224665));

N128_4 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => 0.0026297355,
              (segment in ['SEARS FLS'])                                  => N128_5,
                                                                             0.0026297355));

N128_3 :=__common__( map(((real)r_c18_invalid_addrs_per_adl_i <= NULL) => N128_7,
              ((real)r_c18_invalid_addrs_per_adl_i < 0.5)   => N128_4,
                                                               N128_7));

N128_2 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.033851236105), -0.0020670937, N128_3));

N128_1 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N128_2, 0.022034898));

N129_8 :=__common__( map(trim(C_TRAILER_P) = ''              => -0.0050474098,
              ((real)c_trailer_p < 1.04999995232) => 0.0070197628,
                                                     -0.0050474098));

N129_7 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.017639152,
              ((real)c_sub_bus < 152.5) => N129_8,
                                           0.017639152));

N129_6 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.001898026,
              (segment in ['SEARS FLS'])                                  => N129_7,
                                                                             -0.001898026));

N129_5 :=__common__( map(trim(C_EASIQLIFE) = ''      => N129_6,
              ((real)c_easiqlife < 105.5) => -0.0056112378,
                                             N129_6));

N129_4 :=__common__( if(((real)c_cpiall < 208.5), 0.003351743, N129_5));

N129_3 :=__common__( if(trim(C_CPIALL) != '', N129_4, -0.0040966567));

N129_2 :=__common__( if(((real)f_divaddrsuspidcountnew_i < 1.5), N129_3, 0.0052814134));

N129_1 :=__common__( if(((real)f_divaddrsuspidcountnew_i > NULL), N129_2, 0.0009284427));

N130_9 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL)  => 0.0014570343,
              ((integer)r_d33_eviction_recency_d < 549) => 0.0087548487,
                                                           0.0014570343));

N130_8 :=__common__( map(((real)r_d34_unrel_liens_ct_i <= NULL) => 0.012471745,
              ((real)r_d34_unrel_liens_ct_i < 6.5)   => 0.0010160795,
                                                        0.012471745));

N130_7 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.001492942,
              ((real)f_inq_other_count24_i < 1.5)   => -0.0037791722,
                                                       0.001492942));

N130_6 :=__common__( if(((real)f_rel_under25miles_cnt_d < 19.5), N130_7, N130_8));

N130_5 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N130_6, 0.0081136136));

N130_4 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N130_9,
              ((real)f_sourcerisktype_i < 6.5)   => N130_5,
                                                    N130_9));

N130_3 :=__common__( if(trim(C_CPIALL) != '', N130_4, 0.0016903983));

N130_2 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 65.5), 0.011020898, N130_3));

N130_1 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N130_2, -0.0092572038));

N131_8 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => -0.0063348115,
              ((real)r_c10_m_hdr_fs_d < 301.5) => 0.0026711111,
                                                  -0.0063348115));

N131_7 :=__common__( map(((real)r_c15_ssns_per_adl_i <= NULL) => 0.008407617,
              ((real)r_c15_ssns_per_adl_i < 1.5)   => N131_8,
                                                      0.008407617));

N131_6 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.00076630717,
              (segment in ['SEARS FLS'])                                  => 0.00594352,
                                                                             -0.00076630717));

N131_5 :=__common__( if(((real)c_trailer_p < 0.0500000007451), N131_6, -0.0032291508));

N131_4 :=__common__( if(trim(C_TRAILER_P) != '', N131_5, -0.0039512039));

N131_3 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL) => N131_4,
              ((integer)r_i60_inq_auto_recency_d < 18) => -0.0095778368,
                                                          N131_4));

N131_2 :=__common__( if(((real)f_rel_under25miles_cnt_d < 12.5), N131_3, N131_7));

N131_1 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N131_2, 0.0053233238));

N132_9 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.00066598697,
              ((real)c_easiqlife < 138.5) => -0.0043987834,
                                             0.00066598697));

N132_8 :=__common__( map((segment in ['KMART', 'RETAIL'])                      => 0.00071522427,
              (segment in ['SEARS AUTO', 'SEARS FLS', 'SEARS SHO']) => 0.017904852,
                                                                       0.017904852));

N132_7 :=__common__( if(((real)f_mos_liens_unrel_lt_lseen_d < 93.5), N132_8, N132_9));

N132_6 :=__common__( if(((real)f_mos_liens_unrel_lt_lseen_d > NULL), N132_7, -0.003832275));

N132_5 :=__common__( map(((real)f_rel_under25miles_cnt_d <= NULL) => 0.0041502321,
              ((real)f_rel_under25miles_cnt_d < 14.5)  => -0.003969115,
                                                          0.0041502321));

N132_4 :=__common__( if(((real)f_rel_ageover40_count_d < 2.5), 0.004784629, N132_5));

N132_3 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N132_4, 0.013485234));

N132_2 :=__common__( if(((real)c_span_lang < 95.5), N132_3, N132_6));

N132_1 :=__common__( if(trim(C_SPAN_LANG) != '', N132_2, -0.003239069));

N133_8 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => -0.00023683921,
              ((real)f_m_bureau_adl_fs_all_d < 159.5) => 0.010018509,
                                                         -0.00023683921));

N133_7 :=__common__( map(((real)r_phn_cell_n <= NULL) => -0.0039349655,
              ((real)r_phn_cell_n < 0.5)   => N133_8,
                                              -0.0039349655));

N133_6 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.0014352814,
              ((real)r_c20_email_count_i < 4.5)   => 0.0047617698,
                                                     -0.0014352814));

N133_5 :=__common__( map(((real)f_corrphonelastnamecount_d <= NULL) => N133_7,
              ((real)f_corrphonelastnamecount_d < 0.5)   => N133_6,
                                                            N133_7));

N133_4 :=__common__( if(((real)r_phn_pcs_n < 0.5), N133_5, -0.0026924972));

N133_3 :=__common__( if(((real)r_phn_pcs_n > NULL), N133_4, -0.033656163));

N133_2 :=__common__( if(((integer)r_i60_inq_mortgage_recency_d < 549), -0.0066349218, N133_3));

N133_1 :=__common__( if(((real)r_i60_inq_mortgage_recency_d > NULL), N133_2, -0.00164429));

N134_8 :=__common__( map(((real)c_unique_addr_count_i <= NULL) => 0.0015668712,
              ((real)c_unique_addr_count_i < 5.5)   => 0.009854027,
                                                       0.0015668712));

N134_7 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => -0.00039163957,
              ((real)f_prevaddrmedianincome_d < 29045.5) => 0.0084992967,
                                                            -0.00039163957));

N134_6 :=__common__( if(((real)f_inq_per_phone_i < 0.5), N134_7, -0.00304523));

N134_5 :=__common__( if(((real)f_inq_per_phone_i > NULL), N134_6, -0.037497435));

N134_4 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => N134_5,
              ((real)f_srchfraudsrchcount_i < 4.5)   => -0.0045645363,
                                                        N134_5));

N134_3 :=__common__( map(((real)r_f00_input_dob_match_level_d <= NULL) => N134_4,
              ((real)r_f00_input_dob_match_level_d < 5.5)   => 0.010608592,
                                                               N134_4));

N134_2 :=__common__( if(((real)r_d32_criminal_count_i < 1.5), N134_3, N134_8));

N134_1 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N134_2, 0.0021184415));

N135_9 :=__common__( map(trim(C_CPIALL) = ''              => -0.012114953,
              ((real)c_cpiall < 222.949996948) => 0.0022763662,
                                                  -0.012114953));

N135_8 :=__common__( if(((real)c_child < 23.1500015259), -0.0038566599, N135_9));

N135_7 :=__common__( if(trim(C_CHILD) != '', N135_8, -2.7242814e-005));

N135_6 :=__common__( map(((real)f_attr_arrest_recency_d <= NULL) => N135_7,
              ((real)f_attr_arrest_recency_d < 99.5)  => 0.008566059,
                                                         N135_7));

N135_5 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => -0.0033806385,
              ((real)r_l79_adls_per_addr_curr_i < 2.5)   => N135_6,
                                                            -0.0033806385));

N135_4 :=__common__( if(((real)f_inq_adls_per_addr_i < 4.5), N135_5, 0.010716693));

N135_3 :=__common__( if(((real)f_inq_adls_per_addr_i > NULL), N135_4, 0.068387277));

N135_2 :=__common__( if(((real)f_divaddrsuspidcountnew_i < 1.5), N135_3, 0.0051309227));

N135_1 :=__common__( if(((real)f_divaddrsuspidcountnew_i > NULL), N135_2, 0.0055602249));

N136_10 :=__common__( if(((real)c_construction < 6.85000038147), 0.0013463306, -0.0026238345));

N136_9 :=__common__( if(trim(C_CONSTRUCTION) != '', N136_10, 0.0037195936));

N136_8 :=__common__( if(((real)c_sub_bus < 124.5), 0.0038784423, 0.018107396));

N136_7 :=__common__( if(trim(C_SUB_BUS) != '', N136_8, -0.0070936354));

N136_6 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => 0.001249852,
              (segment in ['SEARS FLS'])                                  => N136_7,
                                                                             0.001249852));

N136_5 :=__common__( map(((real)c_comb_age_d <= NULL) => N136_9,
              ((real)c_comb_age_d < 25.5)  => N136_6,
                                              N136_9));

N136_4 :=__common__( if(((real)r_a44_curr_add_naprop_d < 1.5), N136_5, -0.0056926262));

N136_3 :=__common__( if(((real)r_a44_curr_add_naprop_d > NULL), N136_4, -0.034029105));

N136_2 :=__common__( if(((real)f_curraddrmurderindex_i < 198.5), N136_3, 0.013256956));

N136_1 :=__common__( if(((real)f_curraddrmurderindex_i > NULL), N136_2, 0.0056008874));

N137_10 :=__common__( if(((real)c_sub_bus < 112.5), 0.0024332751, 0.012688182));

N137_9 :=__common__( if(trim(C_SUB_BUS) != '', N137_10, -0.0099583947));

N137_8 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => 0.0016478741,
              (segment in ['SEARS FLS'])                                  => N137_9,
                                                                             0.0016478741));

N137_7 :=__common__( map(((real)f_corraddrphonecount_d <= NULL) => -0.0016916373,
              ((real)f_corraddrphonecount_d < 0.5)   => N137_8,
                                                        -0.0016916373));

N137_6 :=__common__( if(((real)r_phn_pcs_n < 0.5), N137_7, -0.0033441974));

N137_5 :=__common__( if(((real)r_phn_pcs_n > NULL), N137_6, -0.033912696));

N137_4 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i < 4.5), N137_5, -0.0053084879));

N137_3 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i > NULL), N137_4, -0.0015229696));

N137_2 :=__common__( if(((real)r_l79_adls_per_addr_c6_i < 5.5), N137_3, 0.010022464));

N137_1 :=__common__( if(((real)r_l79_adls_per_addr_c6_i > NULL), N137_2, -0.0014427433));

N138_8 :=__common__( map(trim(C_INC_100K_P) = ''              => -0.0030457679,
              ((real)c_inc_100k_p < 12.1499996185) => 0.0074383831,
                                                      -0.0030457679));

N138_7 :=__common__( map(((real)r_d31_mostrec_bk_i <= NULL) => -0.0064690953,
              ((real)r_d31_mostrec_bk_i < 1.5)   => N138_8,
                                                    -0.0064690953));

N138_6 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.0022107276,
              ((real)r_c14_addrs_10yr_i < 3.5)   => -0.0064882488,
                                                    0.0022107276));

N138_5 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N138_6,
              ((real)c_hist_addr_match_i < 2.5)   => -0.003439746,
                                                     N138_6));

N138_4 :=__common__( if(((real)c_born_usa < 173.5), N138_5, N138_7));

N138_3 :=__common__( if(trim(C_BORN_USA) != '', N138_4, -0.0020914699));

N138_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 4.5), 0.010818908, N138_3));

N138_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N138_2, -0.0071027484));

N139_7 :=__common__( map(((real)r_c18_invalid_addrs_per_adl_i <= NULL) => 0.0002165035,
              ((real)r_c18_invalid_addrs_per_adl_i < 0.5)   => 0.0066501404,
                                                               0.0002165035));

N139_6 :=__common__( map(((real)r_s66_adlperssn_count_i <= NULL) => N139_7,
              ((real)r_s66_adlperssn_count_i < 1.5)   => -0.0028549884,
                                                         N139_7));

N139_5 :=__common__( map(((real)f_util_add_curr_misc_n <= NULL) => N139_6,
              ((real)f_util_add_curr_misc_n < 0.5)   => -0.0047336489,
                                                        N139_6));

N139_4 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => 0.011272676,
              ((real)f_mos_inq_banko_om_lseen_d < 30.5)  => -0.00035888309,
                                                            0.011272676));

N139_3 :=__common__( map(((real)r_f03_input_add_not_most_rec_i <= NULL) => 0.0060002184,
              ((real)r_f03_input_add_not_most_rec_i < 0.5)   => N139_4,
                                                                0.0060002184));

N139_2 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 33.5), N139_3, N139_5));

N139_1 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N139_2, -0.0041142667));

N140_9 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.00043980279,
              ((real)c_easiqlife < 102.5) => -0.0070065172,
                                             0.00043980279));

N140_8 :=__common__( map(trim(C_SPAN_LANG) = ''      => -0.008715675,
              ((real)c_span_lang < 142.5) => 0.0065150028,
                                             -0.008715675));

N140_7 :=__common__( if(((real)c_cpiall < 208.5), N140_8, N140_9));

N140_6 :=__common__( if(trim(C_CPIALL) != '', N140_7, -0.00019904771));

N140_5 :=__common__( map(((real)f_inq_retail_count24_i <= NULL) => -0.010186184,
              ((real)f_inq_retail_count24_i < 0.5)   => N140_6,
                                                        -0.010186184));

N140_4 :=__common__( if(((real)f_rel_under25miles_cnt_d < 21.5), 0.0018281097, 0.0093689001));

N140_3 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N140_4, -0.021593623));

N140_2 :=__common__( if(((integer)r_d33_eviction_recency_d < 549), N140_3, N140_5));

N140_1 :=__common__( if(((real)r_d33_eviction_recency_d > NULL), N140_2, -0.0042554287));

N141_8 :=__common__( map(((real)c_inf_contradictory_i <= NULL) => 0.001894119,
              ((real)c_inf_contradictory_i < 0.5)   => -0.0035545587,
                                                       0.001894119));

N141_7 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => -0.00038104605,
              ((real)r_c12_num_nonderogs_d < 6.5)   => 0.0085088478,
                                                       -0.00038104605));

N141_6 :=__common__( map(((real)r_phn_cell_n <= NULL) => N141_8,
              ((real)r_phn_cell_n < 0.5)   => N141_7,
                                              N141_8));

N141_5 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => N141_6,
              ((real)f_mos_inq_banko_om_fseen_d < 32.5)  => 0.0045653193,
                                                            N141_6));

N141_4 :=__common__( if(((real)r_phn_pcs_n < 0.5), N141_5, -0.0032789422));

N141_3 :=__common__( if(((real)r_phn_pcs_n > NULL), N141_4, -0.032240923));

N141_2 :=__common__( if(((real)f_inq_communications_count24_i < 5.5), N141_3, 0.0091199933));

N141_1 :=__common__( if(((real)f_inq_communications_count24_i > NULL), N141_2, 0.0051893277));

N142_8 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.0056818657,
              (segment in ['KMART', 'SEARS FLS'])                => 0.0032980687,
                                                                    -0.0056818657));

N142_7 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => N142_8,
              ((real)f_srchfraudsrchcount_i < 1.5)   => -0.0024448321,
                                                        N142_8));

N142_6 :=__common__( map(((real)f_inq_auto_count24_i <= NULL) => -0.0065443769,
              ((real)f_inq_auto_count24_i < 1.5)   => N142_7,
                                                      -0.0065443769));

N142_5 :=__common__( if(((real)f_inq_lnames_per_addr_i < 3.5), N142_6, 0.0087742413));

N142_4 :=__common__( if(((real)f_inq_lnames_per_addr_i > NULL), N142_5, 0.0054261299));

N142_3 :=__common__( map(((real)r_e55_college_ind_d <= NULL) => -0.0082431476,
              ((real)r_e55_college_ind_d < 0.5)   => N142_4,
                                                     -0.0082431476));

N142_2 :=__common__( if(((real)r_a50_pb_total_orders_d < 2.5), N142_3, -0.0053055026));

N142_1 :=__common__( if(((real)r_a50_pb_total_orders_d > NULL), N142_2, 0.0025820317));

N143_9 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => 0.0013919957,
              ((real)f_srchfraudsrchcount_i < 4.5)   => -0.0028595569,
                                                        0.0013919957));

N143_8 :=__common__( if(((real)f_inq_adls_per_phone_i < 1.5), N143_9, 0.0091458474));

N143_7 :=__common__( if(((real)f_inq_adls_per_phone_i > NULL), N143_8, -0.028243175));

N143_6 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => 0.0022654072,
              ((real)r_d30_derog_count_i < 7.5)   => -0.0052521895,
                                                     0.0022654072));

N143_5 :=__common__( map(((real)f_add_input_has_mfd_ct_i <= NULL) => N143_6,
              ((real)f_add_input_has_mfd_ct_i < 0.5)   => 0.0032063846,
                                                          N143_6));

N143_4 :=__common__( if(((integer)r_l80_inp_avm_autoval_d < 19838), 0.0050398294, N143_5));

N143_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N143_4, N143_7));

N143_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 4.5), 0.0091927392, N143_3));

N143_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N143_2, -0.00049040715));

N144_7 :=__common__( map(((real)f_corrphonelastnamecount_d <= NULL) => -0.001181321,
              ((real)f_corrphonelastnamecount_d < 0.5)   => 0.0045819794,
                                                            -0.001181321));

N144_6 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N144_7, 0.010828813));

N144_5 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.0062102169,
              (segment in ['KMART', 'SEARS FLS'])                => N144_6,
                                                                    -0.0062102169));

N144_4 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => N144_5,
              ((real)r_a50_pb_average_dollars_d < 310.5) => -0.0013337885,
                                                            N144_5));

N144_3 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => 0.007871552,
              ((real)r_d30_derog_count_i < 15.5)  => -0.003637042,
                                                     0.007871552));

N144_2 :=__common__( if(((real)c_dist_input_to_prev_addr_i < 1.5), N144_3, N144_4));

N144_1 :=__common__( if(((real)c_dist_input_to_prev_addr_i > NULL), N144_2, -0.010081616));

N145_8 :=__common__( map(((real)f_varmsrcssnunrelcount_i <= NULL) => 0.0091779018,
              ((real)f_varmsrcssnunrelcount_i < 1.5)   => 0.0014957071,
                                                          0.0091779018));

N145_7 :=__common__( if(((real)f_inq_adls_per_phone_i < 0.5), N145_8, -0.0019714798));

N145_6 :=__common__( if(((real)f_inq_adls_per_phone_i > NULL), N145_7, -0.032374392));

N145_5 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL) => N145_6,
              ((integer)r_d33_eviction_recency_d < 18) => 0.010548702,
                                                          N145_6));

N145_4 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => -0.00044442467,
              ((real)f_sourcerisktype_i < 4.5)   => -0.0063190619,
                                                    -0.00044442467));

N145_3 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => N145_5,
              ((real)f_inq_other_count24_i < 0.5)   => N145_4,
                                                       N145_5));

N145_2 :=__common__( if(((real)r_f00_input_dob_match_level_d < 3.5), 0.012083754, N145_3));

N145_1 :=__common__( if(((real)r_f00_input_dob_match_level_d > NULL), N145_2, -0.0020841561));

N146_7 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.0087272053,
              ((real)f_sourcerisktype_i < 6.5)   => 0.0021102185,
                                                    0.0087272053));

N146_6 :=__common__( map((fp_segment in ['2 NAS 479', '3 New DID', '7 Other'])                           => -0.00072897933,
              (fp_segment in ['1 SSN Prob', '4 Bureau Only', '5 Derog', '6 Recent Activity']) => 0.005838592,
                                                                                                 0.005838592));

N146_5 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N146_6,
              ((real)c_hist_addr_match_i < 3.5)   => -0.0019494337,
                                                     N146_6));

N146_4 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => N146_7,
              ((real)f_srchaddrsrchcount_i < 10.5)  => N146_5,
                                                       N146_7));

N146_3 :=__common__( map(((real)f_liens_rel_cj_total_amt_i <= NULL)  => -0.0073382214,
              ((integer)f_liens_rel_cj_total_amt_i < 379) => N146_4,
                                                             -0.0073382214));

N146_2 :=__common__( if(((real)f_sourcerisktype_i < 2.5), -0.0090343187, N146_3));

N146_1 :=__common__( if(((real)f_sourcerisktype_i > NULL), N146_2, 0.0025359742));

N147_8 :=__common__( map(trim(C_OCCUNIT_P) = ''              => -0.0028933685,
              ((real)c_occunit_p < 80.9499969482) => 0.0064483345,
                                                     -0.0028933685));

N147_7 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => 0.0024575762,
              ((real)f_srchaddrsrchcount_i < 5.5)   => N147_8,
                                                       0.0024575762));

N147_6 :=__common__( map(trim(C_HOUSINGCPI) = ''              => 0.016969616,
              ((real)c_housingcpi < 236.350006104) => N147_7,
                                                      0.016969616));

N147_5 :=__common__( map(trim(C_CPIALL) = ''              => -0.01013062,
              ((real)c_cpiall < 224.399993896) => N147_6,
                                                  -0.01013062));

N147_4 :=__common__( map(((real)r_a50_pb_total_orders_d <= NULL) => -0.005671613,
              ((real)r_a50_pb_total_orders_d < 2.5)   => N147_5,
                                                         -0.005671613));

N147_3 :=__common__( if(trim(C_CPIALL) != '', N147_4, -0.00018674965));

N147_2 :=__common__( if(((real)f_srchcomponentrisktype_i < 2.5), N147_3, 0.0081162584));

N147_1 :=__common__( if(((real)f_srchcomponentrisktype_i > NULL), N147_2, -0.010475219));

N148_7 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.0029512903,
              ((real)f_sourcerisktype_i < 3.5)   => -0.0048621098,
                                                    0.0029512903));

N148_6 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => N148_7,
              ((real)f_srchaddrsrchcount_i < 2.5)   => -0.0027620762,
                                                       N148_7));

N148_5 :=__common__( map(((real)f_mos_liens_rel_cj_fseen_d <= NULL) => N148_6,
              ((real)f_mos_liens_rel_cj_fseen_d < 196.5) => -0.0064248176,
                                                            N148_6));

N148_4 :=__common__( map(((real)f_mos_liens_unrel_lt_lseen_d <= NULL) => N148_5,
              ((real)f_mos_liens_unrel_lt_lseen_d < 137.5) => 0.0051639454,
                                                              N148_5));

N148_3 :=__common__( map(((real)r_f00_input_dob_match_level_d <= NULL) => N148_4,
              ((real)r_f00_input_dob_match_level_d < 3.5)   => 0.012614139,
                                                               N148_4));

N148_2 :=__common__( if(((real)r_i60_inq_retail_recency_d < 61.5), -0.006492343, N148_3));

N148_1 :=__common__( if(((real)r_i60_inq_retail_recency_d > NULL), N148_2, 0.00176043));

N149_9 :=__common__( map(trim(C_RNT750_P) = ''              => 0.0024945911,
              ((real)c_rnt750_p < 11.1499996185) => 0.015476837,
                                                    0.0024945911));

N149_8 :=__common__( map(trim(C_RETAIL) = ''              => -0.0023197059,
              ((real)c_retail < 9.94999980927) => 0.0019092247,
                                                  -0.0023197059));

N149_7 :=__common__( if(((real)r_phn_pcs_n < 0.5), N149_8, -0.0049142528));

N149_6 :=__common__( if(((real)r_phn_pcs_n > NULL), N149_7, -0.030158523));

N149_5 :=__common__( if(((real)f_assoccredbureaucount_i < 4.5), N149_6, N149_9));

N149_4 :=__common__( if(((real)f_assoccredbureaucount_i > NULL), N149_5, -0.0017236705));

N149_3 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => 0.015468588,
              ((real)f_add_curr_nhood_vac_pct_i < 0.189074844122) => 0.0026705516,
                                                                     0.015468588));

N149_2 :=__common__( if(((real)c_med_hhinc < 20350.5), N149_3, N149_4));

N149_1 :=__common__( if(trim(C_MED_HHINC) != '', N149_2, -0.00032039998));

N150_9 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.0015910652,
              ((real)r_c20_email_count_i < 3.5)   => 0.0039637009,
                                                     -0.0015910652));

N150_8 :=__common__( map(trim(C_FAMOTF18_P) = ''              => 0.0034174374,
              ((real)c_famotf18_p < 7.85000038147) => -0.0078384734,
                                                      0.0034174374));

N150_7 :=__common__( if(((real)c_born_usa < 128.5), -0.0031273157, N150_8));

N150_6 :=__common__( if(trim(C_BORN_USA) != '', N150_7, 0.0011734842));

N150_5 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL) => -0.0056883731,
              ((real)f_liens_unrel_cj_total_amt_i < 523.5) => N150_6,
                                                              -0.0056883731));

N150_4 :=__common__( if(((real)f_inq_adls_per_phone_i < 1.5), N150_5, 0.006782621));

N150_3 :=__common__( if(((real)f_inq_adls_per_phone_i > NULL), N150_4, -0.028479327));

N150_2 :=__common__( if(((real)r_f03_input_add_not_most_rec_i < 0.5), N150_3, N150_9));

N150_1 :=__common__( if(((real)r_f03_input_add_not_most_rec_i > NULL), N150_2, 0.0015932534));

N151_8 :=__common__( map(trim(C_ASIAN_LANG) = ''      => 0.010898015,
              ((real)c_asian_lang < 125.5) => -0.00051599542,
                                              0.010898015));

N151_7 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.0027954721,
              ((real)f_corrssnaddrcount_d < 2.5)   => N151_8,
                                                      -0.0027954721));

N151_6 :=__common__( map(trim(C_VACANT_P) = ''              => 0.0055819832,
              ((real)c_vacant_p < 12.0500001907) => 0.00087203698,
                                                    0.0055819832));

N151_5 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)    => N151_7,
              ((integer)f_prevaddrmedianincome_d < 39579) => N151_6,
                                                             N151_7));

N151_4 :=__common__( if(((real)c_trailer_p < 4.35000038147), N151_5, -0.0032289653));

N151_3 :=__common__( if(trim(C_TRAILER_P) != '', N151_4, 0.00036148385));

N151_2 :=__common__( if(((real)f_assoccredbureaucount_i < 5.5), N151_3, 0.0094192635));

N151_1 :=__common__( if(((real)f_assoccredbureaucount_i > NULL), N151_2, 0.0028478859));

N152_9 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => -0.00044989409,
              ((real)r_c21_m_bureau_adl_fs_d < 272.5) => 0.014201402,
                                                         -0.00044989409));

N152_8 :=__common__( map(((real)r_phn_cell_n <= NULL) => -0.0037360438,
              ((real)r_phn_cell_n < 0.5)   => 0.0032512283,
                                              -0.0037360438));

N152_7 :=__common__( if(((real)c_rest_indx < 95.5), 0.0021095622, N152_8));

N152_6 :=__common__( if(trim(C_REST_INDX) != '', N152_7, -3.8462188e-005));

N152_5 :=__common__( map(((real)r_f00_input_dob_match_level_d <= NULL) => N152_6,
              ((real)r_f00_input_dob_match_level_d < 4.5)   => 0.012007611,
                                                               N152_6));

N152_4 :=__common__( if(((real)r_phn_pcs_n < 0.5), N152_5, -0.003819113));

N152_3 :=__common__( if(((real)r_phn_pcs_n > NULL), N152_4, -0.031380899));

N152_2 :=__common__( if(((real)f_varmsrcssncount_i < 2.5), N152_3, N152_9));

N152_1 :=__common__( if(((real)f_varmsrcssncount_i > NULL), N152_2, -0.0026280113));

N153_9 :=__common__( if(((real)c_cpiall < 209.300003052), 0.0099881089, 0.0002170556));

N153_8 :=__common__( if(trim(C_CPIALL) != '', N153_9, 0.0010523487));

N153_7 :=__common__( map(trim(C_POP_18_24_P) = ''      => -0.0081290655,
              ((real)c_pop_18_24_p < 15.75) => -0.0017778632,
                                               -0.0081290655));

N153_6 :=__common__( if(((real)c_pop_12_17_p < 12.6499996185), N153_7, 0.002845364));

N153_5 :=__common__( if(trim(C_POP_12_17_P) != '', N153_6, -0.00077396285));

N153_4 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => N153_8,
              ((real)r_d32_criminal_count_i < 1.5)   => N153_5,
                                                        N153_8));

N153_3 :=__common__( map(((real)f_assocsuspicousidcount_i <= NULL) => 0.012073567,
              ((real)f_assocsuspicousidcount_i < 18.5)  => N153_4,
                                                           0.012073567));

N153_2 :=__common__( if(((real)f_varrisktype_i < 7.5), N153_3, 0.0080371121));

N153_1 :=__common__( if(((real)f_varrisktype_i > NULL), N153_2, 0.003041681));

N154_9 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => 0.0046494772,
              ((real)r_c14_addrs_5yr_i < 2.5)   => -0.0039011755,
                                                   0.0046494772));

N154_8 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N154_9, 0.0010317238));

N154_7 :=__common__( map(((real)f_varmsrcssncount_i <= NULL) => 0.012634298,
              ((real)f_varmsrcssncount_i < 2.5)   => N154_8,
                                                     0.012634298));

N154_6 :=__common__( map(trim(C_NEWHOUSE) = ''              => -0.0018173348,
              ((real)c_newhouse < 4.64999961853) => 0.0032537241,
                                                    -0.0018173348));

N154_5 :=__common__( if(((real)c_born_usa < 110.5), -0.004104369, N154_6));

N154_4 :=__common__( if(trim(C_BORN_USA) != '', N154_5, 0.0047902726));

N154_3 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N154_7,
              ((real)c_hist_addr_match_i < 3.5)   => N154_4,
                                                     N154_7));

N154_2 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 11.5), 0.010258385, N154_3));

N154_1 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N154_2, -0.00036571327));

N155_9 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d < 12.5), -0.0088942099, -0.0014606506));

N155_8 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d > NULL), N155_9, 0.0027467261));

N155_7 :=__common__( map(((real)r_c20_email_count_i <= NULL) => 0.0025699206,
              ((real)r_c20_email_count_i < 0.5)   => 0.011326435,
                                                     0.0025699206));

N155_6 :=__common__( map(((real)c_inf_contradictory_i <= NULL) => N155_7,
              ((real)c_inf_contradictory_i < 0.5)   => 0.00053568119,
                                                       N155_7));

N155_5 :=__common__( if(((real)f_sourcerisktype_i < 5.5), -0.0016019767, N155_6));

N155_4 :=__common__( if(((real)f_sourcerisktype_i > NULL), N155_5, 0.0009824287));

N155_3 :=__common__( map(((real)r_phn_pcs_n <= NULL) => N155_8,
              ((real)r_phn_pcs_n < 0.5)   => N155_4,
                                             N155_8));

N155_2 :=__common__( if(((real)f_inq_adls_per_phone_i < 1.5), N155_3, 0.0066137437));

N155_1 :=__common__( if(((real)f_inq_adls_per_phone_i > NULL), N155_2, -0.028994434));

N156_9 :=__common__( if(((real)f_inq_adls_per_phone_i < 1.5), 0.0038942057, 0.014653655));

N156_8 :=__common__( if(((real)f_inq_adls_per_phone_i > NULL), N156_9, -0.030089211));

N156_7 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i < 1.5), 0.00054630167, N156_8));

N156_6 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i > NULL), N156_7, 0.013422165));

N156_5 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.0020803885,
              ((real)r_c20_email_count_i < 5.5)   => N156_6,
                                                     -0.0020803885));

N156_4 :=__common__( map(((real)r_c18_invalid_addrs_per_adl_i <= NULL) => -0.0029346078,
              ((real)r_c18_invalid_addrs_per_adl_i < 4.5)   => N156_5,
                                                               -0.0029346078));

N156_3 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => N156_4,
              ((real)r_c14_addrs_5yr_i < 0.5)   => -0.006022744,
                                                   N156_4));

N156_2 :=__common__( if(((real)f_srchvelocityrisktype_i < 2.5), -0.0030897459, N156_3));

N156_1 :=__common__( if(((real)f_srchvelocityrisktype_i > NULL), N156_2, -0.0057408085));

N157_7 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => -0.0030959099,
              ((real)f_mos_inq_banko_om_fseen_d < 34.5)  => 0.0020074951,
                                                            -0.0030959099));

N157_6 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => 0.00016904637,
              ((real)f_corrssnaddrcount_d < 3.5)   => 0.0049390887,
                                                      0.00016904637));

N157_5 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL)   => -0.0093680471,
              ((integer)f_liens_unrel_cj_total_amt_i < 7170) => N157_6,
                                                                -0.0093680471));

N157_4 :=__common__( map(((real)r_c20_email_count_i <= NULL) => N157_7,
              ((real)r_c20_email_count_i < 1.5)   => N157_5,
                                                     N157_7));

N157_3 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.006588203,
              (segment in ['KMART', 'SEARS FLS'])                => N157_4,
                                                                    -0.006588203));

N157_2 :=__common__( if(((real)r_e55_college_ind_d < 0.5), N157_3, -0.0072449341));

N157_1 :=__common__( if(((real)r_e55_college_ind_d > NULL), N157_2, -0.00030832261));

N158_9 :=__common__( if(((real)c_born_usa < 182.5), 0.0030338608, 0.016366527));

N158_8 :=__common__( if(trim(C_BORN_USA) != '', N158_9, -0.014551577));

N158_7 :=__common__( if(((real)f_inq_adls_per_phone_i < 0.5), N158_8, -0.0017466028));

N158_6 :=__common__( if(((real)f_inq_adls_per_phone_i > NULL), N158_7, -0.032086361));

N158_5 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => N158_6,
              ((real)f_inq_other_count24_i < 1.5)   => -0.0019945428,
                                                       N158_6));

N158_4 :=__common__( map(((real)f_rel_bankrupt_count_i <= NULL) => -4.632926e-005,
              ((real)f_rel_bankrupt_count_i < 2.5)   => 0.0082477752,
                                                        -4.632926e-005));

N158_3 :=__common__( map(((real)r_s66_adlperssn_count_i <= NULL) => N158_4,
              ((real)r_s66_adlperssn_count_i < 1.5)   => -0.00010172544,
                                                         N158_4));

N158_2 :=__common__( if(((real)f_corrssnaddrcount_d < 2.5), N158_3, N158_5));

N158_1 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N158_2, -0.0029638599));

N159_9 :=__common__( if(((real)f_rel_felony_count_i < 6.5), -0.00045236681, 0.0098821674));

N159_8 :=__common__( if(((real)f_rel_felony_count_i > NULL), N159_9, 0.009465691));

N159_7 :=__common__( if(((real)r_phn_pcs_n < 0.5), -0.0011627453, -0.0071433817));

N159_6 :=__common__( if(((real)r_phn_pcs_n > NULL), N159_7, -0.031645894));

N159_5 :=__common__( if(((real)f_assoccredbureaucount_i < 5.5), N159_6, 0.0089567493));

N159_4 :=__common__( if(((real)f_assoccredbureaucount_i > NULL), N159_5, -0.015146264));

N159_3 :=__common__( if(((integer)r_l80_inp_avm_autoval_d < 11752), 0.007382372, N159_4));

N159_2 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N159_3, N159_8));

N159_1 :=__common__( map(((real)f_inq_lnames_per_addr_i <= NULL) => 0.006263742,
              ((real)f_inq_lnames_per_addr_i < 3.5)   => N159_2,
                                                         0.006263742));

N160_7 :=__common__( map(trim(C_CPIALL) = ''              => 0.014982026,
              ((real)c_cpiall < 205.799987793) => 0.0012549062,
                                                  0.014982026));

N160_6 :=__common__( map(trim(C_CPIALL) = ''      => -0.0011502188,
              ((real)c_cpiall < 208.5) => N160_7,
                                          -0.0011502188));

N160_5 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 18.5), 0.0057155589, N160_6));

N160_4 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N160_5, 0.0046878305));

N160_3 :=__common__( if(((real)c_child < 40.25), N160_4, 0.011385469));

N160_2 :=__common__( if(trim(C_CHILD) != '', N160_3, 0.00093993651));

N160_1 :=__common__( map(((real)c_inf_fname_verd_d <= NULL) => -0.0058035186,
              ((real)c_inf_fname_verd_d < 0.5)   => N160_2,
                                                    -0.0058035186));

N161_8 :=__common__( map(trim(C_POPOVER25) = ''      => -0.0019070344,
              ((real)c_popover25 < 628.5) => -0.0089871161,
                                             -0.0019070344));

N161_7 :=__common__( map(trim(C_MANY_CARS) = ''     => N161_8,
              ((real)c_many_cars < 34.5) => 0.004223737,
                                            N161_8));

N161_6 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => 0.0045263786,
              ((real)c_hist_addr_match_i < 3.5)   => -0.00038731094,
                                                     0.0045263786));

N161_5 :=__common__( if(((real)r_i60_inq_comm_recency_d < 4.5), 0.0082569768, N161_6));

N161_4 :=__common__( if(((real)r_i60_inq_comm_recency_d > NULL), N161_5, 0.014597083));

N161_3 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.0077492845,
              (segment in ['KMART', 'SEARS FLS'])                => N161_4,
                                                                    -0.0077492845));

N161_2 :=__common__( if(((real)c_trailer_p < 0.0500000007451), N161_3, N161_7));

N161_1 :=__common__( if(trim(C_TRAILER_P) != '', N161_2, 0.00050356504));

N162_8 :=__common__( map(((real)r_d33_eviction_count_i <= NULL) => 0.014522563,
              ((real)r_d33_eviction_count_i < 1.5)   => 0.0035233022,
                                                        0.014522563));

N162_7 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => N162_8,
              ((integer)r_i60_inq_auto_recency_d < 549) => -0.0044431069,
                                                           N162_8));

N162_6 :=__common__( if(((real)c_born_usa < 97.5), -0.0048555952, 0.00073929182));

N162_5 :=__common__( if(trim(C_BORN_USA) != '', N162_6, 0.0077450956));

N162_4 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => N162_5,
              (segment in ['SEARS FLS'])                                  => N162_7,
                                                                             N162_5));

N162_3 :=__common__( map(((real)f_mos_liens_rel_cj_lseen_d <= NULL) => N162_4,
              ((real)f_mos_liens_rel_cj_lseen_d < 172.5) => -0.005915418,
                                                            N162_4));

N162_2 :=__common__( if(((real)f_srchunvrfdssncount_i < 1.5), N162_3, 0.0085501157));

N162_1 :=__common__( if(((real)f_srchunvrfdssncount_i > NULL), N162_2, -0.013051734));

N163_10 :=__common__( map(trim(C_RICH_WHT) = ''      => 0.013797904,
               ((real)c_rich_wht < 111.5) => 0.0029887913,
                                             0.013797904));

N163_9 :=__common__( if(((real)c_trailer < 121.5), N163_10, -0.00097305548));

N163_8 :=__common__( if(trim(C_TRAILER) != '', N163_9, 0.0043496557));

N163_7 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => N163_8,
              ((real)r_d30_derog_count_i < 2.5)   => -0.0016578335,
                                                     N163_8));

N163_6 :=__common__( if(((real)c_famotf18_p < 7.94999980927), -0.0076294273, -0.0015595623));

N163_5 :=__common__( if(trim(C_FAMOTF18_P) != '', N163_6, 0.0047448993));

N163_4 :=__common__( if(((real)r_f03_input_add_not_most_rec_i < 0.5), N163_5, N163_7));

N163_3 :=__common__( if(((real)r_f03_input_add_not_most_rec_i > NULL), N163_4, -0.0076811314));

N163_2 :=__common__( if(((real)r_i60_inq_comm_recency_d < 4.5), 0.0046941247, N163_3));

N163_1 :=__common__( if(((real)r_i60_inq_comm_recency_d > NULL), N163_2, -0.0060637332));

N164_8 :=__common__( map(trim(C_OLD_HOMES) = ''      => -0.0084264858,
              ((real)c_old_homes < 141.5) => -0.00061907775,
                                             -0.0084264858));

N164_7 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => 0.00092883875,
              (segment in ['SEARS FLS'])                                  => 0.0061626614,
                                                                             0.00092883875));

N164_6 :=__common__( map(((real)r_a41_prop_owner_inp_only_d <= NULL) => -0.0095218977,
              ((real)r_a41_prop_owner_inp_only_d < 0.5)   => N164_7,
                                                             -0.0095218977));

N164_5 :=__common__( if(((real)c_retail < 9.85000038147), N164_6, N164_8));

N164_4 :=__common__( if(trim(C_RETAIL) != '', N164_5, -0.0071016857));

N164_3 :=__common__( map(((real)r_e55_college_ind_d <= NULL) => -0.0091309984,
              ((real)r_e55_college_ind_d < 0.5)   => N164_4,
                                                     -0.0091309984));

N164_2 :=__common__( if(((real)r_d32_criminal_count_i < 4.5), N164_3, 0.0038366886));

N164_1 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N164_2, 0.0054209913));

N165_9 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), 0.0059246359, -0.0070557016));

N165_8 :=__common__( map(((real)r_c18_invalid_addrs_per_adl_i <= NULL) => -0.0064755147,
              ((real)r_c18_invalid_addrs_per_adl_i < 3.5)   => 0.0071585146,
                                                               -0.0064755147));

N165_7 :=__common__( if(((real)c_old_homes < 53.5), N165_8, -0.0027080964));

N165_6 :=__common__( if(trim(C_OLD_HOMES) != '', N165_7, 0.013129565));

N165_5 :=__common__( if(((real)r_l80_inp_avm_autoval_d < 20449.5), 0.0072734387, N165_6));

N165_4 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N165_5, 0.0012752489));

N165_3 :=__common__( map(((real)c_inf_fname_verd_d <= NULL) => N165_9,
              ((real)c_inf_fname_verd_d < 0.5)   => N165_4,
                                                    N165_9));

N165_2 :=__common__( if(((real)r_d31_mostrec_bk_i < 1.5), N165_3, -0.0052820328));

N165_1 :=__common__( if(((real)r_d31_mostrec_bk_i > NULL), N165_2, -0.0027103605));

N166_9 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => -0.0049585263,
              ((real)f_prevaddrmedianincome_d < 24557.5) => 0.0057794378,
                                                            -0.0049585263));

N166_8 :=__common__( map(trim(C_POP_18_24_P) = ''              => 0.0013481059,
              ((real)c_pop_18_24_p < 2.45000004768) => 0.012061798,
                                                       0.0013481059));

N166_7 :=__common__( map(((real)r_i61_inq_collection_count12_i <= NULL) => 0.011315209,
              ((real)r_i61_inq_collection_count12_i < 1.5)   => N166_8,
                                                                0.011315209));

N166_6 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => N166_9,
              ((real)r_c21_m_bureau_adl_fs_d < 272.5) => N166_7,
                                                         N166_9));

N166_5 :=__common__( if(trim(C_POP_18_24_P) != '', N166_6, 0.0056995134));

N166_4 :=__common__( if(((real)c_easiqlife < 66.5), -0.0073701664, -0.0011241363));

N166_3 :=__common__( if(trim(C_EASIQLIFE) != '', N166_4, 0.013706004));

N166_2 :=__common__( if(((real)c_hist_addr_match_i < 1.5), N166_3, N166_5));

N166_1 :=__common__( if(((real)c_hist_addr_match_i > NULL), N166_2, 0.0095815742));

N167_8 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL) => 0.00027990326,
              ((real)f_liens_unrel_cj_total_amt_i < 106.5) => 0.0053961619,
                                                              0.00027990326));

N167_7 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.012282263,
              ((real)c_sub_bus < 139.5) => -0.0041177268,
                                           0.012282263));

N167_6 :=__common__( map(trim(C_EASIQLIFE) = ''      => N167_7,
              ((real)c_easiqlife < 140.5) => -0.0076408522,
                                             N167_7));

N167_5 :=__common__( if(((real)c_span_lang < 130.5), 0.0014806416, N167_6));

N167_4 :=__common__( if(trim(C_SPAN_LANG) != '', N167_5, 0.00090787024));

N167_3 :=__common__( map((fp_segment in ['2 NAS 479', '4 Bureau Only', '6 Recent Activity', '7 Other']) => N167_4,
              (fp_segment in ['1 SSN Prob', '3 New DID', '5 Derog'])                         => N167_8,
                                                                                                N167_4));

N167_2 :=__common__( if(((real)r_c20_email_count_i < 4.5), N167_3, -0.0034234011));

N167_1 :=__common__( if(((real)r_c20_email_count_i > NULL), N167_2, 1.940971e-006));

N168_10 :=__common__( if(((real)c_hval_80k_p < 2.45000004768), 0.011741212, 0.00026773801));

N168_9 :=__common__( if(trim(C_HVAL_80K_P) != '', N168_10, -0.007181204));

N168_8 :=__common__( if(((real)c_cpiall < 224.399993896), 0.00047998718, -0.011593008));

N168_7 :=__common__( if(trim(C_CPIALL) != '', N168_8, -0.000939202));

N168_6 :=__common__( map(((real)f_mos_liens_rel_cj_lseen_d <= NULL) => N168_7,
              ((real)f_mos_liens_rel_cj_lseen_d < 67.5)  => -0.0088364957,
                                                            N168_7));

N168_5 :=__common__( map(((real)r_c20_email_domain_isp_count_i <= NULL) => -0.0098837447,
              ((real)r_c20_email_domain_isp_count_i < 3.5)   => N168_6,
                                                                -0.0098837447));

N168_4 :=__common__( map(((real)r_c15_ssns_per_adl_i <= NULL) => N168_9,
              ((real)r_c15_ssns_per_adl_i < 1.5)   => N168_5,
                                                      N168_9));

N168_3 :=__common__( if(((real)f_inq_adls_per_phone_i < 1.5), N168_4, 0.0061386421));

N168_2 :=__common__( if(((real)f_inq_adls_per_phone_i > NULL), N168_3, -0.029900054));

N168_1 :=__common__( if(((real)r_c15_ssns_per_adl_i > NULL), N168_2, 0.0035621259));

N169_8 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => 0.015113205,
              ((real)r_c13_avg_lres_d < 39.5)  => 0.0029173982,
                                                  0.015113205));

N169_7 :=__common__( map(((real)c_unique_addr_count_i <= NULL) => 0.0012410752,
              ((real)c_unique_addr_count_i < 5.5)   => 0.0070796659,
                                                       0.0012410752));

N169_6 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => N169_7,
              ((real)f_rel_felony_count_i < 0.5)   => -0.0012047483,
                                                      N169_7));

N169_5 :=__common__( if(trim(C_HVAL_200K_P) != '', N169_6, 0.00014665822));

N169_4 :=__common__( map(((real)f_corrssnnamecount_d <= NULL) => -0.0059627853,
              ((real)f_corrssnnamecount_d < 8.5)   => N169_5,
                                                      -0.0059627853));

N169_3 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => N169_8,
              ((real)r_c14_addrs_5yr_i < 8.5)   => N169_4,
                                                   N169_8));

N169_2 :=__common__( if(((real)r_i60_inq_auto_count12_i < 1.5), N169_3, -0.0091992108));

N169_1 :=__common__( if(((real)r_i60_inq_auto_count12_i > NULL), N169_2, -0.009666692));

N170_8 :=__common__( map(trim(C_TOTCRIME) = ''       => 0.0066769163,
              ((integer)c_totcrime < 140) => 0.019854606,
                                             0.0066769163));

N170_7 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => N170_8,
              ((real)f_add_input_nhood_vac_pct_i < 0.0663317888975) => 0.0010253199,
                                                                       N170_8));

N170_6 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL)  => -0.0015842391,
              ((integer)f_liens_unrel_cj_total_amt_i < 103) => N170_7,
                                                               -0.0015842391));

N170_5 :=__common__( if(((real)c_sub_bus < 151.5), -0.00025381497, N170_6));

N170_4 :=__common__( if(trim(C_SUB_BUS) != '', N170_5, 0.0033712196));

N170_3 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.0032958653,
              ((real)r_c20_email_count_i < 4.5)   => N170_4,
                                                     -0.0032958653));

N170_2 :=__common__( if(((real)f_inq_auto_count24_i < 2.5), N170_3, -0.0088004281));

N170_1 :=__common__( if(((real)f_inq_auto_count24_i > NULL), N170_2, 0.0026645881));

N171_9 :=__common__( map(trim(C_MED_HVAL) = ''         => 0.0021073686,
              ((integer)c_med_hval < 78313) => 0.0127469,
                                               0.0021073686));

N171_8 :=__common__( map(trim(C_PROFESSIONAL) = ''     => -0.0030045928,
              ((real)c_professional < 1.75) => N171_9,
                                               -0.0030045928));

N171_7 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N171_8, 7.9352443e-005));

N171_6 :=__common__( map(trim(C_EASIQLIFE) = ''      => N171_7,
              ((real)c_easiqlife < 100.5) => -0.0042947081,
                                             N171_7));

N171_5 :=__common__( map(trim(C_BLUE_COL) = ''      => -0.0059937505,
              ((real)c_blue_col < 15.75) => 0.0034549269,
                                            -0.0059937505));

N171_4 :=__common__( if(((integer)r_d32_mos_since_crim_ls_d < 219), 0.0082500895, N171_5));

N171_3 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N171_4, 0.036075264));

N171_2 :=__common__( if(((real)c_cpiall < 208.5), N171_3, N171_6));

N171_1 :=__common__( if(trim(C_CPIALL) != '', N171_2, 0.00079943179));

N172_7 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => 0.0052092174,
              ((real)r_d30_derog_count_i < 12.5)  => -0.0042325729,
                                                     0.0052092174));

N172_6 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => 0.0059026217,
              ((real)f_mos_inq_banko_om_lseen_d < 13.5)  => 0.00024604815,
                                                            0.0059026217));

N172_5 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => -0.0011630138,
              ((real)f_mos_inq_banko_om_fseen_d < 33.5)  => N172_6,
                                                            -0.0011630138));

N172_4 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), 0.0077741728, N172_5));

N172_3 :=__common__( map(((real)f_corraddrphonecount_d <= NULL) => N172_7,
              ((real)f_corraddrphonecount_d < 0.5)   => N172_4,
                                                        N172_7));

N172_2 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 57.5), 0.0098605684, N172_3));

N172_1 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N172_2, -0.0029747277));

N173_8 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.011728088,
              ((real)r_c14_addrs_10yr_i < 5.5)   => -0.00089338902,
                                                    0.011728088));

N173_7 :=__common__( if(((real)c_asian_lang < 123.5), 0.0005173693, N173_8));

N173_6 :=__common__( if(trim(C_ASIAN_LANG) != '', N173_7, 0.0029696621));

N173_5 :=__common__( map(((real)f_mos_acc_lseen_d <= NULL) => N173_6,
              ((real)f_mos_acc_lseen_d < 82.5)  => -0.0064819004,
                                                   N173_6));

N173_4 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.00177268,
              ((real)f_corrssnaddrcount_d < 2.5)   => N173_5,
                                                      -0.00177268));

N173_3 :=__common__( map(((real)f_mos_liens_unrel_cj_lseen_d <= NULL) => N173_4,
              ((real)f_mos_liens_unrel_cj_lseen_d < 6.5)   => 0.0066759274,
                                                              N173_4));

N173_2 :=__common__( if(((integer)f_liens_unrel_sc_total_amt_i < 5668), N173_3, 0.010712648));

N173_1 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i > NULL), N173_2, 0.0017849779));

N174_10 :=__common__( map(((real)f_rel_criminal_count_i <= NULL) => 0.0022149389,
               ((real)f_rel_criminal_count_i < 0.5)   => -0.0051777149,
                                                         0.0022149389));

N174_9 :=__common__( if(((real)c_sfdu_p < 95.25), -0.00075521833, 0.0079160091));

N174_8 :=__common__( if(trim(C_SFDU_P) != '', N174_9, 0.031731673));

N174_7 :=__common__( if(((integer)r_l80_inp_avm_autoval_d < 21451), 0.010438659, N174_8));

N174_6 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N174_7, N174_10));

N174_5 :=__common__( if(((real)r_d31_mostrec_bk_i < 1.5), N174_6, -0.0071172));

N174_4 :=__common__( if(((real)r_d31_mostrec_bk_i > NULL), N174_5, 0.004436865));

N174_3 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => 0.0023590826,
              ((real)f_srchfraudsrchcount_i < 3.5)   => -0.0044211465,
                                                        0.0023590826));

N174_2 :=__common__( if(((real)r_pb_order_freq_d < 43.5), N174_3, -0.0056573426));

N174_1 :=__common__( if(((real)r_pb_order_freq_d > NULL), N174_2, N174_4));

N175_10 :=__common__( if(((integer)c_rich_blk < 174), -0.0026601887, 0.0056295239));

N175_9 :=__common__( if(trim(C_RICH_BLK) != '', N175_10, 0.011494151));

N175_8 :=__common__( if(((real)c_rest_indx < 86.5), 0.003785232, -0.0039371545));

N175_7 :=__common__( if(trim(C_REST_INDX) != '', N175_8, -0.0049199272));

N175_6 :=__common__( map(((real)r_s66_adlperssn_count_i <= NULL) => 0.0057005842,
              ((real)r_s66_adlperssn_count_i < 1.5)   => N175_7,
                                                         0.0057005842));

N175_5 :=__common__( if(((real)r_l79_adls_per_addr_curr_i < 0.5), N175_6, N175_9));

N175_4 :=__common__( if(((real)r_l79_adls_per_addr_curr_i > NULL), N175_5, 0.01764139));

N175_3 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => N175_4,
              ((real)r_a50_pb_average_dollars_d < 186.5) => -0.0024347207,
                                                            N175_4));

N175_2 :=__common__( if(((real)r_d30_derog_count_i < 13.5), N175_3, 0.0052171389));

N175_1 :=__common__( if(((real)r_d30_derog_count_i > NULL), N175_2, 0.0027332538));

N176_8 :=__common__( map(trim(C_CONSTRUCTION) = ''              => -0.00062488434,
              ((real)c_construction < 1.65000009537) => 0.0031250761,
                                                        -0.00062488434));

N176_7 :=__common__( map(trim(C_HVAL_80K_P) = ''              => 0.011698184,
              ((real)c_hval_80k_p < 43.4500007629) => N176_8,
                                                      0.011698184));

N176_6 :=__common__( map(trim(C_HH1_P) = ''              => 0.01226862,
              ((real)c_hh1_p < 32.1500015259) => 0.00041624119,
                                                 0.01226862));

N176_5 :=__common__( map(trim(C_TOTSALES) = ''        => -0.0062472729,
              ((integer)c_totsales < 1040) => N176_6,
                                              -0.0062472729));

N176_4 :=__common__( if(((real)r_d32_criminal_count_i < 1.5), -0.0046144268, N176_5));

N176_3 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N176_4, 0.012056839));

N176_2 :=__common__( if(((real)c_popover25 < 624.5), N176_3, N176_7));

N176_1 :=__common__( if(trim(C_POPOVER25) != '', N176_2, -0.0067431411));

N177_8 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => 0.023753773,
              ((real)f_add_input_nhood_vac_pct_i < 0.0605938211083) => 0.0080048099,
                                                                       0.023753773));

N177_7 :=__common__( map(trim(C_SUB_BUS) = ''      => N177_8,
              ((real)c_sub_bus < 131.5) => 0.0030896281,
                                           N177_8));

N177_6 :=__common__( map(trim(C_CIV_EMP) = ''              => -0.0054137926,
              ((real)c_civ_emp < 54.4500007629) => 0.0063249036,
                                                   -0.0054137926));

N177_5 :=__common__( if(((real)c_easiqlife < 116.5), N177_6, N177_7));

N177_4 :=__common__( if(trim(C_EASIQLIFE) != '', N177_5, 0.0006239666));

N177_3 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.00053690672,
              (segment in ['SEARS FLS'])                                  => N177_4,
                                                                             -0.00053690672));

N177_2 :=__common__( if(((real)r_pb_order_freq_d < 42.5), 0.0012340195, -0.0049557381));

N177_1 :=__common__( if(((real)r_pb_order_freq_d > NULL), N177_2, N177_3));

N178_9 :=__common__( if(((real)c_low_hval < 65.1499938965), 0.0028256382, 0.013823647));

N178_8 :=__common__( if(trim(C_LOW_HVAL) != '', N178_9, 0.0052835523));

N178_7 :=__common__( map(((real)f_srchphonesrchcount_i <= NULL) => -0.0021949541,
              ((real)f_srchphonesrchcount_i < 4.5)   => N178_8,
                                                        -0.0021949541));

N178_6 :=__common__( map(trim(C_HIGHRENT) = ''              => 0.0059596182,
              ((real)c_highrent < 9.44999980927) => -0.0043160439,
                                                    0.0059596182));

N178_5 :=__common__( if(((real)c_span_lang < 103.5), 0.0026008284, N178_6));

N178_4 :=__common__( if(trim(C_SPAN_LANG) != '', N178_5, -0.0076901751));

N178_3 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => N178_4,
              ((real)r_a50_pb_average_dollars_d < 141.5) => -0.0047464157,
                                                            N178_4));

N178_2 :=__common__( if(((real)f_srchfraudsrchcount_i < 6.5), N178_3, N178_7));

N178_1 :=__common__( if(((real)f_srchfraudsrchcount_i > NULL), N178_2, -0.0017525417));

N179_8 :=__common__( map(trim(C_OLD_HOMES) = ''      => -0.0045951291,
              ((real)c_old_homes < 131.5) => 0.00106193,
                                             -0.0045951291));

N179_7 :=__common__( map(trim(C_TOTSALES) = ''        => 0.01372831,
              ((integer)c_totsales < 2288) => 0.0023430936,
                                              0.01372831));

N179_6 :=__common__( if(((real)c_retail < 2.15000009537), N179_7, N179_8));

N179_5 :=__common__( if(trim(C_RETAIL) != '', N179_6, 0.0021265916));

N179_4 :=__common__( map(((real)f_mos_liens_rel_ot_fseen_d <= NULL) => -0.0099189457,
              ((real)f_mos_liens_rel_ot_fseen_d < 34.5)  => N179_5,
                                                            -0.0099189457));

N179_3 :=__common__( map(((real)r_phn_pcs_n <= NULL) => -0.002845616,
              ((real)r_phn_pcs_n < 0.5)   => N179_4,
                                             -0.002845616));

N179_2 :=__common__( if(((integer)r_i61_inq_collection_recency_d < 2), 0.011731826, N179_3));

N179_1 :=__common__( if(((real)r_i61_inq_collection_recency_d > NULL), N179_2, 0.004856322));

N180_7 :=__common__( map(((real)c_comb_age_d <= NULL) => 0.0010482837,
              ((real)c_comb_age_d < 25.5)  => 0.00659219,
                                              0.0010482837));

N180_6 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => N180_7,
              ((real)f_srchfraudsrchcount_i < 2.5)   => -0.0019842678,
                                                        N180_7));

N180_5 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL) => N180_6,
              ((real)r_i60_inq_auto_recency_d < 61.5)  => -0.0039523894,
                                                          N180_6));

N180_4 :=__common__( map(((real)r_i60_inq_retail_recency_d <= NULL) => N180_5,
              ((real)r_i60_inq_retail_recency_d < 61.5)  => -0.0063050052,
                                                            N180_5));

N180_3 :=__common__( map(((real)f_varrisktype_i <= NULL) => 0.0069861512,
              ((real)f_varrisktype_i < 7.5)   => N180_4,
                                                 0.0069861512));

N180_2 :=__common__( if(((real)f_rel_count_i < 2.5), 0.0069391275, N180_3));

N180_1 :=__common__( if(((real)f_rel_count_i > NULL), N180_2, 0.0040165678));

N181_8 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i < 0.5), 0.009990396, 0.0015885815));

N181_7 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i > NULL), N181_8, -0.0025260333));

N181_6 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO']) => -0.001224291,
              (segment in ['SEARS FLS', 'SEARS SHO'])        => 0.0044977019,
                                                                -0.001224291));

N181_5 :=__common__( if(((real)c_sub_bus < 118.5), -0.0026777431, N181_6));

N181_4 :=__common__( if(trim(C_SUB_BUS) != '', N181_5, -0.0047420522));

N181_3 :=__common__( if(((real)r_l72_add_vacant_i < 0.5), N181_4, 0.0091938663));

N181_2 :=__common__( if(((real)r_l72_add_vacant_i > NULL), N181_3, -0.027785113));

N181_1 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N181_2, N181_7));

N182_9 :=__common__( map(trim(C_MED_YEARBLT) = ''       => 0.0033577859,
              ((real)c_med_yearblt < 1940.5) => -0.0077505888,
                                                0.0033577859));

N182_8 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => -0.0018791507,
              ((real)r_d32_mos_since_crim_ls_d < 4.5)   => 0.0078812554,
                                                           -0.0018791507));

N182_7 :=__common__( map(((real)r_c15_ssns_per_adl_i <= NULL) => 0.0078917966,
              ((real)r_c15_ssns_per_adl_i < 3.5)   => N182_8,
                                                      0.0078917966));

N182_6 :=__common__( if(((real)c_born_usa < 154.5), N182_7, N182_9));

N182_5 :=__common__( if(trim(C_BORN_USA) != '', N182_6, -0.00028071184));

N182_4 :=__common__( if(((real)c_unempl < 161.5), -0.0032715263, -0.014999033));

N182_3 :=__common__( if(trim(C_UNEMPL) != '', N182_4, 0.017781767));

N182_2 :=__common__( if(((real)r_i60_inq_retail_recency_d < 61.5), N182_3, N182_5));

N182_1 :=__common__( if(((real)r_i60_inq_retail_recency_d > NULL), N182_2, 0.0025460365));

N183_9 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.005235191,
              ((real)f_inq_other_count24_i < 3.5)   => -0.0016884423,
                                                       0.005235191));

N183_8 :=__common__( if(((real)f_rel_incomeover25_count_d < 5.5), 0.0058234869, 0.00059263137));

N183_7 :=__common__( if(((real)f_rel_incomeover25_count_d > NULL), N183_8, 0.010126042));

N183_6 :=__common__( map(trim(C_RETAIL) = ''              => N183_9,
              ((real)c_retail < 5.14999961853) => N183_7,
                                                  N183_9));

N183_5 :=__common__( map(((real)f_assoccredbureaucount_i <= NULL) => 0.0097498791,
              ((real)f_assoccredbureaucount_i < 6.5)   => N183_6,
                                                          0.0097498791));

N183_4 :=__common__( if(((real)c_mining < 1.34999990463), N183_5, -0.013838323));

N183_3 :=__common__( if(trim(C_MINING) != '', N183_4, -0.0022082504));

N183_2 :=__common__( if(((real)r_c10_m_hdr_fs_d < 351.5), N183_3, -0.0081074536));

N183_1 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N183_2, -0.0095270114));

N184_9 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL)  => -0.0051606087,
              ((integer)f_liens_unrel_cj_total_amt_i < 127) => 0.0017495778,
                                                               -0.0051606087));

N184_8 :=__common__( map(trim(C_NO_CAR) = ''      => N184_9,
              ((real)c_no_car < 119.5) => -0.0062898318,
                                          N184_9));

N184_7 :=__common__( map(((real)f_add_curr_mobility_index_n <= NULL)          => 0.0023552998,
              ((real)f_add_curr_mobility_index_n < 0.194602802396) => -0.0090238454,
                                                                      0.0023552998));

N184_6 :=__common__( map(trim(C_BURGLARY) = ''      => N184_8,
              ((real)c_burglary < 136.5) => N184_7,
                                            N184_8));

N184_5 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N184_6, -0.0096070367));

N184_4 :=__common__( if(trim(C_BURGLARY) != '', N184_5, 0.0016800512));

N184_3 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => N184_4,
              ((real)r_d32_mos_since_crim_ls_d < 4.5)   => 0.0082330155,
                                                           N184_4));

N184_2 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d < 3.5), 0.0090884823, N184_3));

N184_1 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N184_2, -0.0031352749));

N185_10 :=__common__( if(((real)r_c13_max_lres_d < 156.5), 0.0079025571, -0.0047206111));

N185_9 :=__common__( if(((real)r_c13_max_lres_d > NULL), N185_10, -0.0023637405));

N185_8 :=__common__( map(trim(C_SPAN_LANG) = ''      => -0.0077212301,
              ((real)c_span_lang < 178.5) => 0.0022645244,
                                             -0.0077212301));

N185_7 :=__common__( if(((real)f_rel_incomeover50_count_d < 1.5), N185_8, -0.0019558108));

N185_6 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N185_7, 0.0029694847));

N185_5 :=__common__( map(trim(C_HOUSINGCPI) = ''              => 0.010075883,
              ((real)c_housingcpi < 236.350006104) => N185_6,
                                                      0.010075883));

N185_4 :=__common__( if(((real)c_cpiall < 224.399993896), N185_5, -0.010396194));

N185_3 :=__common__( if(trim(C_CPIALL) != '', N185_4, 0.0031882217));

N185_2 :=__common__( if(((real)f_inq_adls_per_phone_i < 1.5), N185_3, N185_9));

N185_1 :=__common__( if(((real)f_inq_adls_per_phone_i > NULL), N185_2, -0.030738814));

N186_9 :=__common__( if(((real)r_l79_adls_per_addr_curr_i < 37.5), 0.00045523953, 0.008652284));

N186_8 :=__common__( if(((real)r_l79_adls_per_addr_curr_i > NULL), N186_9, -0.036432687));

N186_7 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), -0.0018123773, 0.0065559538));

N186_6 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.00936079211533), -0.0072372918, N186_7));

N186_5 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N186_6, 0.01652359));

N186_4 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => N186_8,
              ((real)r_d30_derog_count_i < 3.5)   => N186_5,
                                                     N186_8));

N186_3 :=__common__( map(((real)f_srchfraudsrchcountmo_i <= NULL) => 0.0043077254,
              ((real)f_srchfraudsrchcountmo_i < 0.5)   => N186_4,
                                                          0.0043077254));

N186_2 :=__common__( if(((real)f_mos_liens_unrel_lt_fseen_d < 21.5), 0.010446831, N186_3));

N186_1 :=__common__( if(((real)f_mos_liens_unrel_lt_fseen_d > NULL), N186_2, -0.0097116187));

N187_8 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.013826115,
              ((real)c_sub_bus < 126.5) => 0.0038733632,
                                           0.013826115));

N187_7 :=__common__( if(((real)c_easiqlife < 112.5), -0.0024906663, N187_8));

N187_6 :=__common__( if(trim(C_EASIQLIFE) != '', N187_7, 0.0042023235));

N187_5 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.00033200603,
              (segment in ['SEARS FLS'])                                  => N187_6,
                                                                             -0.00033200603));

N187_4 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => N187_5,
              ((real)f_srchssnsrchcount_i < 0.5)   => -0.0044325583,
                                                      N187_5));

N187_3 :=__common__( map(((real)r_i60_inq_auto_count12_i <= NULL) => -0.0050794898,
              ((real)r_i60_inq_auto_count12_i < 0.5)   => N187_4,
                                                          -0.0050794898));

N187_2 :=__common__( if(((real)r_c15_ssns_per_adl_i < 3.5), N187_3, 0.006798304));

N187_1 :=__common__( if(((real)r_c15_ssns_per_adl_i > NULL), N187_2, 0.0038584776));

N188_8 :=__common__( map(((real)f_varmsrcssncount_i <= NULL) => 0.0022210289,
              ((real)f_varmsrcssncount_i < 1.5)   => -0.002231408,
                                                     0.0022210289));

N188_7 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.018325146,
              ((real)c_sub_bus < 119.5) => 0.0047365672,
                                           0.018325146));

N188_6 :=__common__( if(((real)c_easiqlife < 113.5), 3.6543163e-005, N188_7));

N188_5 :=__common__( if(trim(C_EASIQLIFE) != '', N188_6, -0.0040368312));

N188_4 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => 0.00023490688,
              (segment in ['SEARS FLS'])                                  => N188_5,
                                                                             0.00023490688));

N188_3 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => N188_8,
              ((real)f_corrssnaddrcount_d < 2.5)   => N188_4,
                                                      N188_8));

N188_2 :=__common__( if(((integer)f_liens_unrel_sc_total_amt_i < 6672), N188_3, 0.012792027));

N188_1 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i > NULL), N188_2, 0.0039418181));

N189_8 :=__common__( map(trim(C_CONSTRUCTION) = ''              => 0.00092961642,
              ((real)c_construction < 4.85000038147) => 0.0058335022,
                                                        0.00092961642));

N189_7 :=__common__( map(((real)f_corrssnnamecount_d <= NULL) => 2.4890774e-006,
              ((real)f_corrssnnamecount_d < 5.5)   => N189_8,
                                                      2.4890774e-006));

N189_6 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => N189_7,
              ((real)f_curraddrcartheftindex_i < 106.5) => -0.0011181805,
                                                           N189_7));

N189_5 :=__common__( if(((real)c_med_yearblt < 1939.5), -0.0059391557, N189_6));

N189_4 :=__common__( if(trim(C_MED_YEARBLT) != '', N189_5, 0.005321876));

N189_3 :=__common__( map(((real)r_phn_pcs_n <= NULL) => -0.0028735042,
              ((real)r_phn_pcs_n < 0.5)   => N189_4,
                                             -0.0028735042));

N189_2 :=__common__( if(((real)f_rel_felony_count_i < 6.5), N189_3, 0.0080262402));

N189_1 :=__common__( if(((real)f_rel_felony_count_i > NULL), N189_2, 0.0013273547));

N190_9 :=__common__( map(((real)r_phn_pcs_n <= NULL) => -0.0023725087,
              ((real)r_phn_pcs_n < 0.5)   => 0.0026188037,
                                             -0.0023725087));

N190_8 :=__common__( if(((real)c_famotf18_p < 8.35000038147), -0.0040799373, N190_9));

N190_7 :=__common__( if(trim(C_FAMOTF18_P) != '', N190_8, 0.0050089363));

N190_6 :=__common__( map(((real)r_i60_inq_mortgage_recency_d <= NULL)  => N190_7,
              ((integer)r_i60_inq_mortgage_recency_d < 549) => -0.0069759363,
                                                               N190_7));

N190_5 :=__common__( if(((real)f_rel_under25miles_cnt_d < 21.5), -0.004317336, 0.0045224875));

N190_4 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N190_5, -0.0023679666));

N190_3 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => N190_6,
              ((real)c_dist_best_to_prev_addr_i < 1.5)   => N190_4,
                                                            N190_6));

N190_2 :=__common__( if(((real)f_inq_other_count24_i < 2.5), N190_3, 0.0034614417));

N190_1 :=__common__( if(((real)f_inq_other_count24_i > NULL), N190_2, -0.0049064274));

N191_8 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.0055804934,
              ((real)f_corrssnaddrcount_d < 1.5)   => 0.0057120414,
                                                      -0.0055804934));

N191_7 :=__common__( map(trim(C_OCCUNIT_P) = ''              => 0.00042505973,
              ((real)c_occunit_p < 86.1499938965) => 0.0061016449,
                                                     0.00042505973));

N191_6 :=__common__( map(((real)f_inq_auto_count24_i <= NULL) => -0.0090898686,
              ((real)f_inq_auto_count24_i < 1.5)   => N191_7,
                                                      -0.0090898686));

N191_5 :=__common__( if(((real)c_old_homes < 154.5), N191_6, -0.0039559907));

N191_4 :=__common__( if(trim(C_OLD_HOMES) != '', N191_5, -0.0023195195));

N191_3 :=__common__( map(((real)r_c20_email_domain_isp_count_i <= NULL) => N191_8,
              ((real)r_c20_email_domain_isp_count_i < 0.5)   => N191_4,
                                                                N191_8));

N191_2 :=__common__( if(((real)f_rel_under25miles_cnt_d < 12.5), N191_3, 0.0023198428));

N191_1 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N191_2, 0.0051070385));

N192_9 :=__common__( map(trim(C_CHILD) = ''              => 0.0049012138,
              ((real)c_child < 30.9500007629) => -0.00030620448,
                                                 0.0049012138));

N192_8 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => N192_9,
              ((real)r_c14_addrs_10yr_i < 3.5)   => -0.0044282313,
                                                    N192_9));

N192_7 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.419251859188), 0.00072925957, 0.014531401));

N192_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N192_7, 0.0073802456));

N192_5 :=__common__( map(((real)c_comb_age_d <= NULL) => N192_8,
              ((real)c_comb_age_d < 24.5)  => N192_6,
                                              N192_8));

N192_4 :=__common__( if(((real)c_ab_av_edu < 135.5), N192_5, 0.0086354741));

N192_3 :=__common__( if(trim(C_AB_AV_EDU) != '', N192_4, 0.00047428889));

N192_2 :=__common__( if(((real)c_hist_addr_match_i < 1.5), -0.0017519463, N192_3));

N192_1 :=__common__( if(((real)c_hist_addr_match_i > NULL), N192_2, -0.0031124964));

N193_9 :=__common__( map(((real)f_util_adl_count_n <= NULL) => 0.010636126,
              ((real)f_util_adl_count_n < 2.5)   => 0.0032957624,
                                                    0.010636126));

N193_8 :=__common__( map(((real)f_fp_prevaddrcrimeindex_i <= NULL) => N193_9,
              ((real)f_fp_prevaddrcrimeindex_i < 167.5) => 0.0027567953,
                                                           N193_9));

N193_7 :=__common__( if(((real)c_inc_150k_p < 0.449999988079), -0.00078865188, N193_8));

N193_6 :=__common__( if(trim(C_INC_150K_P) != '', N193_7, 0.011386824));

N193_5 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N193_6,
              ((real)f_sourcerisktype_i < 3.5)   => -0.0028592836,
                                                    N193_6));

N193_4 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i < 0.5), -0.0018895921, N193_5));

N193_3 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i > NULL), N193_4, 0.005081538));

N193_2 :=__common__( if(((real)f_corraddrphonecount_d < 0.5), N193_3, -0.002032384));

N193_1 :=__common__( if(((real)f_corraddrphonecount_d > NULL), N193_2, -0.0033927082));

N194_8 :=__common__( map(((real)r_s66_adlperssn_count_i <= NULL) => 0.0087401689,
              ((real)r_s66_adlperssn_count_i < 2.5)   => 0.001548327,
                                                         0.0087401689));

N194_7 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => 0.00060360778,
              (segment in ['SEARS FLS'])                                  => 0.009469164,
                                                                             0.00060360778));

N194_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.442366182804), -0.00088635988, N194_7));

N194_5 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N194_6, 0.0022683288));

N194_4 :=__common__( map(((real)f_liens_rel_cj_total_amt_i <= NULL) => -0.0091312651,
              ((real)f_liens_rel_cj_total_amt_i < 606.5) => N194_5,
                                                            -0.0091312651));

N194_3 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => N194_8,
              ((real)f_inq_other_count24_i < 1.5)   => N194_4,
                                                       N194_8));

N194_2 :=__common__( if(((real)r_e55_college_ind_d < 0.5), N194_3, -0.0072700382));

N194_1 :=__common__( if(((real)r_e55_college_ind_d > NULL), N194_2, 0.0032301144));

N195_10 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => -0.0039645281,
               ((real)r_c12_num_nonderogs_d < 7.5)   => 0.0010832321,
                                                        -0.0039645281));

N195_9 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N195_10, -0.036088751));

N195_8 :=__common__( if(((real)c_span_lang < 179.5), N195_9, -0.010592496));

N195_7 :=__common__( if(trim(C_SPAN_LANG) != '', N195_8, 0.0094655945));

N195_6 :=__common__( map(((real)f_assoccredbureaucount_i <= NULL) => 0.0054665217,
              ((real)f_assoccredbureaucount_i < 2.5)   => 0.00044877893,
                                                          0.0054665217));

N195_5 :=__common__( if(((real)c_pop_35_44_p < 21.6500015259), N195_6, 0.012022109));

N195_4 :=__common__( if(trim(C_POP_35_44_P) != '', N195_5, -0.0036967465));

N195_3 :=__common__( map(((real)f_util_add_curr_misc_n <= NULL) => N195_4,
              ((real)f_util_add_curr_misc_n < 0.5)   => -0.0017544379,
                                                        N195_4));

N195_2 :=__common__( if(((real)f_current_count_d < 1.5), N195_3, N195_7));

N195_1 :=__common__( if(((real)f_current_count_d > NULL), N195_2, 0.0046257476));

N196_7 :=__common__( map(trim(C_RENTOCC_P) = ''              => -0.0047792823,
              ((real)c_rentocc_p < 58.5499992371) => -0.0004233798,
                                                     -0.0047792823));

N196_6 :=__common__( map(trim(C_CHILD) = ''      => 0.0081712107,
              ((real)c_child < 40.25) => N196_7,
                                         0.0081712107));

N196_5 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 133.5), 0.0064424388, N196_6));

N196_4 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N196_5, -0.0038563205));

N196_3 :=__common__( if(((real)c_pop_45_54_p < 15.8500003815), N196_4, 0.002943741));

N196_2 :=__common__( if(trim(C_POP_45_54_P) != '', N196_3, -0.0014647112));

N196_1 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO'])            => -0.0075982904,
              (segment in ['KMART', 'SEARS FLS', 'SEARS SHO']) => N196_2,
                                                                  N196_2));

N197_9 :=__common__( if(((real)f_inq_adls_per_phone_i < 0.5), 0.0014329908, -0.0079646793));

N197_8 :=__common__( if(((real)f_inq_adls_per_phone_i > NULL), N197_9, -0.030210074));

N197_7 :=__common__( map((fp_segment in ['3 New DID', '4 Bureau Only', '6 Recent Activity', '7 Other']) => -0.0023431079,
              (fp_segment in ['1 SSN Prob', '2 NAS 479', '5 Derog'])                         => 0.0008187567,
                                                                                                -0.0023431079));

N197_6 :=__common__( map(((real)f_inq_communications_count24_i <= NULL) => 0.0060687939,
              ((real)f_inq_communications_count24_i < 4.5)   => N197_7,
                                                                0.0060687939));

N197_5 :=__common__( if(((real)f_inq_adls_per_phone_i < 1.5), N197_6, 0.0065157113));

N197_4 :=__common__( if(((real)f_inq_adls_per_phone_i > NULL), N197_5, -0.029024541));

N197_3 :=__common__( map(((real)r_i60_inq_banking_count12_i <= NULL) => N197_8,
              ((real)r_i60_inq_banking_count12_i < 0.5)   => N197_4,
                                                             N197_8));

N197_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 4.5), 0.0075600207, N197_3));

N197_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N197_2, -0.0021489104));

N198_9 :=__common__( if(((real)c_easiqlife < 102.5), 0.00019207795, 0.011416217));

N198_8 :=__common__( if(trim(C_EASIQLIFE) != '', N198_9, -0.0024811235));

N198_7 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => 0.0043203207,
              ((real)f_srchaddrsrchcount_i < 6.5)   => -0.0033158885,
                                                       0.0043203207));

N198_6 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => N198_8,
              ((real)r_c10_m_hdr_fs_d < 156.5) => N198_7,
                                                  N198_8));

N198_5 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N198_6,
              ((real)f_sourcerisktype_i < 6.5)   => -0.0013456164,
                                                    N198_6));

N198_4 :=__common__( if(((real)c_sfdu_p < 63.3499984741), 0.010495123, 0.00067967532));

N198_3 :=__common__( if(trim(C_SFDU_P) != '', N198_4, 0.015761357));

N198_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 13.5), N198_3, N198_5));

N198_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N198_2, 0.0058713347));

N199_8 :=__common__( map(trim(C_EMPLOYEES) = ''      => 0.0037191855,
              ((real)c_employees < 681.5) => -0.0040045593,
                                             0.0037191855));

N199_7 :=__common__( map(((real)f_rel_incomeover50_count_d <= NULL) => 0.001361299,
              ((real)f_rel_incomeover50_count_d < 1.5)   => 0.011920256,
                                                            0.001361299));

N199_6 :=__common__( map(trim(C_RELIG_INDX) = ''      => 0.0057099557,
              ((real)c_relig_indx < 171.5) => -0.00049844151,
                                              0.0057099557));

N199_5 :=__common__( map(trim(C_HVAL_80K_P) = ''              => N199_7,
              ((real)c_hval_80k_p < 31.9500007629) => N199_6,
                                                      N199_7));

N199_4 :=__common__( map(trim(C_FINANCE) = ''              => N199_8,
              ((real)c_finance < 4.05000019073) => N199_5,
                                                   N199_8));

N199_3 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N199_4, 0.00041645403));

N199_2 :=__common__( if(((real)c_bel_edu < 193.5), N199_3, -0.0073546349));

N199_1 :=__common__( if(trim(C_BEL_EDU) != '', N199_2, 0.004075859));

N200_9 :=__common__( if(((real)f_rel_ageover40_count_d < 2.5), 0.0067904905, -0.00034280254));

N200_8 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N200_9, 0.021264038));

N200_7 :=__common__( map(trim(C_LARCENY) = ''      => -0.0063260153,
              ((real)c_larceny < 158.5) => -0.00052792868,
                                           -0.0063260153));

N200_6 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => 0.0026131343,
              ((real)c_hist_addr_match_i < 2.5)   => -0.0018927987,
                                                     0.0026131343));

N200_5 :=__common__( map(trim(C_POP_6_11_P) = ''              => 0.0059592007,
              ((real)c_pop_6_11_p < 11.3500003815) => N200_6,
                                                      0.0059592007));

N200_4 :=__common__( if(((real)c_span_lang < 111.5), N200_5, N200_7));

N200_3 :=__common__( if(trim(C_SPAN_LANG) != '', N200_4, 0.00057511376));

N200_2 :=__common__( if(((real)f_srchunvrfdaddrcount_i < 0.5), N200_3, N200_8));

N200_1 :=__common__( if(((real)f_srchunvrfdaddrcount_i > NULL), N200_2, -0.0061671005));

N201_9 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i < 3.5), -0.00058922192, 0.0058625922));

N201_8 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i > NULL), N201_9, 0.0063677602));

N201_7 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.01508458,
              (segment in ['KMART', 'SEARS FLS'])                => N201_8,
                                                                    -0.01508458));

N201_6 :=__common__( if(((real)c_health < 15.3500003815), -0.0023489483, -0.011930224));

N201_5 :=__common__( if(trim(C_HEALTH) != '', N201_6, -0.0040300852));

N201_4 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => N201_7,
              ((real)f_mos_inq_banko_cm_fseen_d < 74.5)  => N201_5,
                                                            N201_7));

N201_3 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => N201_4,
              ((real)f_mos_inq_banko_cm_fseen_d < 70.5)  => 0.0015207649,
                                                            N201_4));

N201_2 :=__common__( if(((integer)r_i60_inq_mortgage_recency_d < 549), -0.0057227856, N201_3));

N201_1 :=__common__( if(((real)r_i60_inq_mortgage_recency_d > NULL), N201_2, -0.0076590507));

N202_9 :=__common__( map(((real)f_assocrisktype_i <= NULL) => -0.0021269235,
              ((real)f_assocrisktype_i < 2.5)   => -0.0076194857,
                                                   -0.0021269235));

N202_8 :=__common__( if(((real)f_rel_ageover30_count_d < 2.5), 0.0026352987, N202_9));

N202_7 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N202_8, 0.00066680552));

N202_6 :=__common__( map(((real)r_c15_ssns_per_adl_i <= NULL) => 0.0034919725,
              ((real)r_c15_ssns_per_adl_i < 1.5)   => N202_7,
                                                      0.0034919725));

N202_5 :=__common__( map(((real)f_mos_liens_unrel_lt_lseen_d <= NULL)  => N202_6,
              ((integer)f_mos_liens_unrel_lt_lseen_d < 185) => 0.0030738163,
                                                               N202_6));

N202_4 :=__common__( if(((real)f_inq_other_count24_i < 3.5), N202_5, 0.0043380183));

N202_3 :=__common__( if(((real)f_inq_other_count24_i > NULL), N202_4, -0.00097179969));

N202_2 :=__common__( if(((real)c_sfdu_p < 97.6499938965), N202_3, 0.0047658762));

N202_1 :=__common__( if(trim(C_SFDU_P) != '', N202_2, -0.0032747834));

N203_9 :=__common__( map(((real)c_comb_age_d <= NULL) => 0.0026651787,
              ((real)c_comb_age_d < 26.5)  => 0.012077354,
                                              0.0026651787));

N203_8 :=__common__( if(((real)r_prop_owner_history_d > NULL), N203_9, 0.0016074259));

N203_7 :=__common__( map(((real)r_l77_apartment_i <= NULL) => 0.0017864809,
              ((real)r_l77_apartment_i < 0.5)   => -0.0019610594,
                                                   0.0017864809));

N203_6 :=__common__( if(((real)r_d32_felony_count_i < 3.5), N203_7, 0.0082163506));

N203_5 :=__common__( if(((real)r_d32_felony_count_i > NULL), N203_6, 0.0034722258));

N203_4 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => 0.0055674527,
              ((real)r_l79_adls_per_addr_curr_i < 43.5)  => N203_5,
                                                            0.0055674527));

N203_3 :=__common__( map(trim(C_RNT1500_P) = ''              => N203_8,
              ((real)c_rnt1500_p < 4.05000019073) => N203_4,
                                                     N203_8));

N203_2 :=__common__( if(((real)c_cpiall < 224.399993896), N203_3, -0.0092518897));

N203_1 :=__common__( if(trim(C_CPIALL) != '', N203_2, -0.0017946895));

N204_9 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.0058212098,
              ((real)f_corrssnaddrcount_d < 3.5)   => 0.010227,
                                                      -0.0058212098));

N204_8 :=__common__( map(((real)f_srchunvrfdphonecount_i <= NULL) => -0.0052663987,
              ((real)f_srchunvrfdphonecount_i < 0.5)   => N204_9,
                                                          -0.0052663987));

N204_7 :=__common__( if(((real)c_construction < 3.75), 0.0019665912, -0.001890906));

N204_6 :=__common__( if(trim(C_CONSTRUCTION) != '', N204_7, 0.00023067088));

N204_5 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => N204_8,
              ((real)f_inq_adls_per_phone_i < 0.5)   => N204_6,
                                                        N204_8));

N204_4 :=__common__( if(((real)f_inq_adls_per_phone_i < 1.5), N204_5, 0.0054411612));

N204_3 :=__common__( if(((real)f_inq_adls_per_phone_i > NULL), N204_4, -0.029874563));

N204_2 :=__common__( if(((real)f_varrisktype_i < 7.5), N204_3, 0.0078920145));

N204_1 :=__common__( if(((real)f_varrisktype_i > NULL), N204_2, 0.00097344382));

N205_9 :=__common__( if(((real)f_inq_highriskcredit_count24_i < 4.5), -0.00098072863, -0.012644435));

N205_8 :=__common__( if(((real)f_inq_highriskcredit_count24_i > NULL), N205_9, 0.031943668));

N205_7 :=__common__( map(trim(C_EASIQLIFE) = ''     => 0.001817329,
              ((real)c_easiqlife < 66.5) => N205_8,
                                            0.001817329));

N205_6 :=__common__( if(((real)r_c14_addrs_5yr_i < 5.5), -0.00213039, 0.0050797429));

N205_5 :=__common__( if(((real)r_c14_addrs_5yr_i > NULL), N205_6, -0.0051907513));

N205_4 :=__common__( map(trim(C_SUB_BUS) = ''      => N205_5,
              ((real)c_sub_bus < 107.5) => -0.005333175,
                                           N205_5));

N205_3 :=__common__( map(trim(C_BORN_USA) = ''      => N205_7,
              ((real)c_born_usa < 116.5) => N205_4,
                                            N205_7));

N205_2 :=__common__( if(((real)c_oldhouse < 4.14999961853), 0.011420974, N205_3));

N205_1 :=__common__( if(trim(C_OLDHOUSE) != '', N205_2, 0.0024931858));

N206_8 :=__common__( map(((real)c_inf_fname_verd_d <= NULL) => -0.0065499582,
              ((real)c_inf_fname_verd_d < 0.5)   => 0.0031381447,
                                                    -0.0065499582));

N206_7 :=__common__( map(((real)f_rel_homeover150_count_d <= NULL) => -0.0024589225,
              ((real)f_rel_homeover150_count_d < 3.5)   => N206_8,
                                                           -0.0024589225));

N206_6 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => 0.0086187563,
              ((real)r_c14_addrs_15yr_i < 19.5)  => N206_7,
                                                    0.0086187563));

N206_5 :=__common__( if(((real)c_hh1_p < 19.3499984741), -0.0021583945, 0.0078525843));

N206_4 :=__common__( if(trim(C_HH1_P) != '', N206_5, 0.014971274));

N206_3 :=__common__( map(((real)f_rel_ageover40_count_d <= NULL) => N206_6,
              ((real)f_rel_ageover40_count_d < 0.5)   => N206_4,
                                                         N206_6));

N206_2 :=__common__( if(((real)f_rel_felony_count_i < 0.5), -0.0018633363, N206_3));

N206_1 :=__common__( if(((real)f_rel_felony_count_i > NULL), N206_2, 0.0040562954));

N207_8 :=__common__( if(((real)c_larceny < 138.5), 0.0038748977, 0.015214355));

N207_7 :=__common__( if(trim(C_LARCENY) != '', N207_8, 0.012389685));

N207_6 :=__common__( map(((real)c_addr_lres_6mo_ct_i <= NULL) => -0.0013900278,
              ((real)c_addr_lres_6mo_ct_i < 2.5)   => N207_7,
                                                      -0.0013900278));

N207_5 :=__common__( map(((real)f_mos_acc_lseen_d <= NULL) => 0.00019182109,
              ((real)f_mos_acc_lseen_d < 126.5) => -0.0042037561,
                                                   0.00019182109));

N207_4 :=__common__( map(((real)f_mos_liens_rel_cj_lseen_d <= NULL) => N207_5,
              ((real)f_mos_liens_rel_cj_lseen_d < 123.5) => -0.0064728974,
                                                            N207_5));

N207_3 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N207_4, N207_6));

N207_2 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d < 6.5), 0.007893496, N207_3));

N207_1 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N207_2, -0.0021359914));

N208_8 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL) => 0.0014813458,
              ((real)f_curraddrcrimeindex_i < 83.5)  => 0.0094994904,
                                                        0.0014813458));

N208_7 :=__common__( map(trim(C_POP_18_24_P) = ''              => -0.0026915249,
              ((real)c_pop_18_24_p < 15.9499998093) => N208_8,
                                                       -0.0026915249));

N208_6 :=__common__( map(trim(C_ASIAN_LANG) = ''      => 0.0029836812,
              ((real)c_asian_lang < 137.5) => -0.0039593771,
                                              0.0029836812));

N208_5 :=__common__( if(((real)f_curraddrcartheftindex_i < 106.5), N208_6, N208_7));

N208_4 :=__common__( if(((real)f_curraddrcartheftindex_i > NULL), N208_5, -0.0073189673));

N208_3 :=__common__( map(trim(C_CPIALL) = ''              => 0.011268409,
              ((real)c_cpiall < 218.399993896) => N208_4,
                                                  0.011268409));

N208_2 :=__common__( if(((real)c_cpiall < 222.949996948), N208_3, -0.0069854274));

N208_1 :=__common__( if(trim(C_CPIALL) != '', N208_2, -0.0025061832));

N209_9 :=__common__( if(((real)c_pop_75_84_p < 3.65000009537), 0.011008173, 0.00024372296));

N209_8 :=__common__( if(trim(C_POP_75_84_P) != '', N209_9, 0.013102643));

N209_7 :=__common__( if(((real)c_hhsize < 2.49499988556), -0.000623281, 0.0024524762));

N209_6 :=__common__( if(trim(C_HHSIZE) != '', N209_7, 0.00054699073));

N209_5 :=__common__( map(((real)r_i60_inq_banking_recency_d <= NULL) => N209_6,
              ((real)r_i60_inq_banking_recency_d < 4.5)   => -0.0071610819,
                                                             N209_6));

N209_4 :=__common__( map(((real)c_inf_fname_verd_d <= NULL) => -0.0036345121,
              ((real)c_inf_fname_verd_d < 0.5)   => N209_5,
                                                    -0.0036345121));

N209_3 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => N209_4,
              ((real)r_c14_addrs_5yr_i < 0.5)   => -0.0057916581,
                                                   N209_4));

N209_2 :=__common__( if(((real)f_inq_collection_count24_i < 2.5), N209_3, N209_8));

N209_1 :=__common__( if(((real)f_inq_collection_count24_i > NULL), N209_2, 0.0039337071));

N210_8 :=__common__( map(((real)f_mos_liens_rel_cj_lseen_d <= NULL) => 0.0020295944,
              ((real)f_mos_liens_rel_cj_lseen_d < 67.5)  => -0.0071471247,
                                                            0.0020295944));

N210_7 :=__common__( map(trim(C_INC_25K_P) = ''      => -0.0042096152,
              ((real)c_inc_25k_p < 19.25) => N210_8,
                                             -0.0042096152));

N210_6 :=__common__( map(trim(C_INC_100K_P) = ''              => N210_7,
              ((real)c_inc_100k_p < 4.44999980927) => 0.0054355377,
                                                      N210_7));

N210_5 :=__common__( if(((real)c_hval_100k_p < 20.6500015259), N210_6, -0.0021379034));

N210_4 :=__common__( if(trim(C_HVAL_100K_P) != '', N210_5, 0.0044737724));

N210_3 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => -0.00018652047,
              ((real)r_c10_m_hdr_fs_d < 164.5) => -0.0091567108,
                                                  -0.00018652047));

N210_2 :=__common__( if(((real)f_srchssnsrchcount_i < 0.5), N210_3, N210_4));

N210_1 :=__common__( if(((real)f_srchssnsrchcount_i > NULL), N210_2, -0.00076092629));

N211_8 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.01399916,
              ((real)r_c14_addrs_10yr_i < 12.5)  => 0.0032190679,
                                                    0.01399916));

N211_7 :=__common__( map(((real)f_assocsuspicousidcount_i <= NULL) => N211_8,
              ((real)f_assocsuspicousidcount_i < 7.5)   => 0.00048735831,
                                                           N211_8));

N211_6 :=__common__( if(((real)r_l79_adls_per_addr_c6_i < 3.5), N211_7, 0.0094496914));

N211_5 :=__common__( if(((real)r_l79_adls_per_addr_c6_i > NULL), N211_6, 0.028694021));

N211_4 :=__common__( map(((real)c_unique_addr_count_i <= NULL) => 0.0001107753,
              ((real)c_unique_addr_count_i < 3.5)   => 0.0083514892,
                                                       0.0001107753));

N211_3 :=__common__( map(((real)f_inq_lnames_per_addr_i <= NULL) => N211_4,
              ((real)f_inq_lnames_per_addr_i < 1.5)   => -0.0025945703,
                                                         N211_4));

N211_2 :=__common__( if(((real)c_hist_addr_match_i < 2.5), N211_3, N211_5));

N211_1 :=__common__( if(((real)c_hist_addr_match_i > NULL), N211_2, -0.0015055583));

N212_8 :=__common__( map(((real)f_srchcomponentrisktype_i <= NULL) => 0.0063462762,
              ((real)f_srchcomponentrisktype_i < 2.5)   => -0.0017825512,
                                                           0.0063462762));

N212_7 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => 0.0041925611,
              ((real)r_d30_derog_count_i < 13.5)  => N212_8,
                                                     0.0041925611));

N212_6 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => 0.0097055345,
              ((real)r_c21_m_bureau_adl_fs_d < 114.5) => 0.0017956561,
                                                         0.0097055345));

N212_5 :=__common__( map(((real)c_comb_age_d <= NULL) => N212_7,
              ((real)c_comb_age_d < 27.5)  => N212_6,
                                              N212_7));

N212_4 :=__common__( if(((real)r_c13_curr_addr_lres_d < 9.5), -0.0082393992, -0.0014288579));

N212_3 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N212_4, -0.034133341));

N212_2 :=__common__( if(((real)f_srchvelocityrisktype_i < 2.5), N212_3, N212_5));

N212_1 :=__common__( if(((real)f_srchvelocityrisktype_i > NULL), N212_2, 1.3556208e-006));

N213_8 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.00047908837,
              ((real)r_c20_email_count_i < 4.5)   => 0.0090561355,
                                                     -0.00047908837));

N213_7 :=__common__( map(trim(C_SPAN_LANG) = ''      => -0.0088063671,
              ((real)c_span_lang < 191.5) => -0.00024327195,
                                             -0.0088063671));

N213_6 :=__common__( map(trim(C_HVAL_150K_P) = ''              => 0.0058690498,
              ((real)c_hval_150k_p < 27.9500007629) => N213_7,
                                                       0.0058690498));

N213_5 :=__common__( if(((real)c_oldhouse < 4.05000019073), 0.012029531, N213_6));

N213_4 :=__common__( if(trim(C_OLDHOUSE) != '', N213_5, -0.0021687566));

N213_3 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => N213_8,
              ((real)f_inq_other_count24_i < 3.5)   => N213_4,
                                                       N213_8));

N213_2 :=__common__( if(((real)r_c10_m_hdr_fs_d < 324.5), N213_3, -0.0051670896));

N213_1 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N213_2, 0.0054200198));

N214_6 :=__common__( map(((real)r_phn_cell_n <= NULL) => 0.0010642907,
              ((real)r_phn_cell_n < 0.5)   => 0.0070229548,
                                              0.0010642907));

N214_5 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => N214_6,
              ((real)c_dist_best_to_prev_addr_i < 0.5)   => -0.0018510891,
                                                            N214_6));

N214_4 :=__common__( map(((real)r_e55_college_ind_d <= NULL) => -0.0094959653,
              ((real)r_e55_college_ind_d < 0.5)   => N214_5,
                                                     -0.0094959653));

N214_3 :=__common__( if(((real)r_f03_input_add_not_most_rec_i < 0.5), -0.0017495425, N214_4));

N214_2 :=__common__( if(((real)r_f03_input_add_not_most_rec_i > NULL), N214_3, -0.0015640847));

N214_1 :=__common__( map(((real)f_recent_disconnects_i <= NULL) => 0.007369262,
              ((real)f_recent_disconnects_i < 0.5)   => N214_2,
                                                        0.007369262));

N215_9 :=__common__( map(trim(C_WHITE_COL) = ''      => 0.0076463621,
              ((real)c_white_col < 21.75) => 0.00076906231,
                                             0.0076463621));

N215_8 :=__common__( if(((real)f_rel_incomeover50_count_d < 0.5), N215_9, 0.00042073002));

N215_7 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N215_8, 0.0097100144));

N215_6 :=__common__( map(((real)r_i60_inq_retail_recency_d <= NULL) => N215_7,
              ((real)r_i60_inq_retail_recency_d < 61.5)  => -0.0054097699,
                                                            N215_7));

N215_5 :=__common__( if(((real)f_mos_liens_rel_cj_lseen_d < 84.5), -0.0056453262, N215_6));

N215_4 :=__common__( if(((real)f_mos_liens_rel_cj_lseen_d > NULL), N215_5, 0.0063476059));

N215_3 :=__common__( map(trim(C_CPIALL) = ''              => -0.01201385,
              ((real)c_cpiall < 225.450012207) => N215_4,
                                                  -0.01201385));

N215_2 :=__common__( if(((real)c_mining < 1.84999990463), N215_3, -0.014044426));

N215_1 :=__common__( if(trim(C_MINING) != '', N215_2, -0.0016073477));

N216_10 :=__common__( if(((real)c_rich_wht < 164.5), 0.00051776271, 0.0067939289));

N216_9 :=__common__( if(trim(C_RICH_WHT) != '', N216_10, 0.0055321249));

N216_8 :=__common__( map(((real)r_d31_mostrec_bk_i <= NULL) => -0.0045959247,
              ((real)r_d31_mostrec_bk_i < 1.5)   => N216_9,
                                                    -0.0045959247));

N216_7 :=__common__( if(((real)r_phn_pcs_n < 0.5), N216_8, -0.0029455843));

N216_6 :=__common__( if(((real)r_phn_pcs_n > NULL), N216_7, -0.029244874));

N216_5 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d < 0.00216585770249), -0.011040212, N216_6));

N216_4 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d > NULL), N216_5, -0.033720996));

N216_3 :=__common__( map(((real)f_varrisktype_i <= NULL) => 0.0063241507,
              ((real)f_varrisktype_i < 7.5)   => N216_4,
                                                 0.0063241507));

N216_2 :=__common__( if(((real)r_c15_ssns_per_adl_i < 4.5), N216_3, 0.010118111));

N216_1 :=__common__( if(((real)r_c15_ssns_per_adl_i > NULL), N216_2, -0.0039336444));

N217_8 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.0047056765,
              ((real)f_rel_felony_count_i < 0.5)   => -0.001480036,
                                                      0.0047056765));

N217_7 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.0082022737,
              ((real)r_c20_email_count_i < 5.5)   => N217_8,
                                                     -0.0082022737));

N217_6 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => N217_7,
              ((real)f_add_curr_nhood_vac_pct_i < 0.021892817691) => -0.0061922872,
                                                                     N217_7));

N217_5 :=__common__( if(((real)c_trailer_p < 5.35000038147), N217_6, -0.007237614));

N217_4 :=__common__( if(trim(C_TRAILER_P) != '', N217_5, 0.0023430778));

N217_3 :=__common__( map(((real)r_s66_adlperssn_count_i <= NULL) => 0.0012352838,
              ((real)r_s66_adlperssn_count_i < 1.5)   => N217_4,
                                                         0.0012352838));

N217_2 :=__common__( if(((real)c_mos_since_impulse_fs_d < 57.5), 0.0040305153, N217_3));

N217_1 :=__common__( if(((real)c_mos_since_impulse_fs_d > NULL), N217_2, 0.00078268401));

N218_8 :=__common__( map(((real)f_srchfraudsrchcountmo_i <= NULL) => 0.0045265222,
              ((real)f_srchfraudsrchcountmo_i < 0.5)   => -0.0026700219,
                                                          0.0045265222));

N218_7 :=__common__( map(((real)c_inf_contradictory_i <= NULL) => 0.0016545136,
              ((real)c_inf_contradictory_i < 0.5)   => N218_8,
                                                       0.0016545136));

N218_6 :=__common__( if(((real)c_pop_18_24_p < 10.4499998093), 0.011821233, 0.0011048662));

N218_5 :=__common__( if(trim(C_POP_18_24_P) != '', N218_6, 0.014948815));

N218_4 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => 0.0012037005,
              ((real)r_c21_m_bureau_adl_fs_d < 163.5) => N218_5,
                                                         0.0012037005));

N218_3 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), N218_4, N218_7));

N218_2 :=__common__( if(((real)f_varrisktype_i < 8.5), N218_3, 0.0097515198));

N218_1 :=__common__( if(((real)f_varrisktype_i > NULL), N218_2, -0.0079442006));

N219_7 :=__common__( map(((real)f_corraddrphonecount_d <= NULL) => -0.0019333127,
              ((real)f_corraddrphonecount_d < 0.5)   => 0.0026148747,
                                                        -0.0019333127));

N219_6 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => -0.0074376059,
              ((real)f_srchfraudsrchcount_i < 35.5)  => N219_7,
                                                        -0.0074376059));

N219_5 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.0089762561,
              ((real)f_rel_felony_count_i < 6.5)   => N219_6,
                                                      0.0089762561));

N219_4 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL) => N219_5,
              ((real)r_a50_pb_total_dollars_d < 12.5)  => 0.010717566,
                                                          N219_5));

N219_3 :=__common__( map(((real)f_mos_liens_rel_cj_lseen_d <= NULL) => N219_4,
              ((real)f_mos_liens_rel_cj_lseen_d < 59.5)  => -0.0086128482,
                                                            N219_4));

N219_2 :=__common__( if(((integer)f_prevaddrcartheftindex_i < 113), -0.001728907, N219_3));

N219_1 :=__common__( if(((real)f_prevaddrcartheftindex_i > NULL), N219_2, -0.0026443757));

N220_8 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => 9.2100192e-005,
              ((real)r_c10_m_hdr_fs_d < 156.5) => -0.0033707225,
                                                  9.2100192e-005));

N220_7 :=__common__( map(((real)c_addr_lres_12mo_ct_i <= NULL) => 0.00010323042,
              ((real)c_addr_lres_12mo_ct_i < 5.5)   => 0.011076241,
                                                       0.00010323042));

N220_6 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.0436409115791), -0.0022611663, N220_7));

N220_5 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N220_6, 0.0082200084));

N220_4 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.0064213794,
              ((real)f_rel_felony_count_i < 1.5)   => -0.0011004965,
                                                      0.0064213794));

N220_3 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => N220_5,
              ((real)r_d32_criminal_count_i < 0.5)   => N220_4,
                                                        N220_5));

N220_2 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i < 0.5), N220_3, N220_8));

N220_1 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i > NULL), N220_2, 0.0022957362));

N221_8 :=__common__( map(((real)f_srchunvrfdaddrcount_i <= NULL) => 0.0044757434,
              ((real)f_srchunvrfdaddrcount_i < 0.5)   => -0.0031792119,
                                                         0.0044757434));

N221_7 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => 0.0030670302,
              ((real)f_mos_inq_banko_cm_fseen_d < 66.5)  => -0.0014786701,
                                                            0.0030670302));

N221_6 :=__common__( if(((real)c_inc_100k_p < 3.45000004768), 0.0069234566, N221_7));

N221_5 :=__common__( if(trim(C_INC_100K_P) != '', N221_6, 0.0015747809));

N221_4 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => N221_8,
              ((real)f_mos_inq_banko_cm_fseen_d < 70.5)  => N221_5,
                                                            N221_8));

N221_3 :=__common__( map(((real)r_i60_inq_comm_recency_d <= NULL) => N221_4,
              ((real)r_i60_inq_comm_recency_d < 4.5)   => 0.0042510419,
                                                          N221_4));

N221_2 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 16.5), 0.0078871652, N221_3));

N221_1 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N221_2, 0.0053925847));

N222_8 :=__common__( map(trim(C_INC_50K_P) = ''              => 0.010212887,
              ((real)c_inc_50k_p < 18.8499984741) => 0.0024006424,
                                                     0.010212887));

N222_7 :=__common__( map(trim(C_EASIQLIFE) = ''     => N222_8,
              ((real)c_easiqlife < 73.5) => -0.0024780668,
                                            N222_8));

N222_6 :=__common__( map(trim(C_BORN_USA) = ''      => N222_7,
              ((real)c_born_usa < 116.5) => -0.001623418,
                                            N222_7));

N222_5 :=__common__( map(trim(C_POP_35_44_P) = ''              => 0.0059378303,
              ((real)c_pop_35_44_p < 19.3499984741) => N222_6,
                                                       0.0059378303));

N222_4 :=__common__( if(((real)c_burglary < 159.5), N222_5, -0.0018732212));

N222_3 :=__common__( if(trim(C_BURGLARY) != '', N222_4, 0.012684493));

N222_2 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d < 0.00195769686252), -0.0094923439, N222_3));

N222_1 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d > NULL), N222_2, 0.0060855234));

N223_8 :=__common__( map(trim(C_UNATTACH) = ''      => 0.00091274321,
              ((real)c_unattach < 139.5) => -0.0096370657,
                                            0.00091274321));

N223_7 :=__common__( map(((real)f_util_add_curr_misc_n <= NULL) => 0.0046480632,
              ((real)f_util_add_curr_misc_n < 0.5)   => -0.00040314554,
                                                        0.0046480632));

N223_6 :=__common__( map(trim(C_BEL_EDU) = ''      => -0.0074118041,
              ((real)c_bel_edu < 193.5) => N223_7,
                                           -0.0074118041));

N223_5 :=__common__( map(trim(C_FEMDIV_P) = ''              => -0.0066646744,
              ((real)c_femdiv_p < 11.1499996185) => N223_6,
                                                    -0.0066646744));

N223_4 :=__common__( if(((integer)f_prevaddrmedianincome_d < 35431), N223_5, -0.00091669699));

N223_3 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N223_4, 0.0054349057));

N223_2 :=__common__( if(((real)c_old_homes < 181.5), N223_3, N223_8));

N223_1 :=__common__( if(trim(C_OLD_HOMES) != '', N223_2, 0.0015847723));

N224_9 :=__common__( if(((real)c_incollege < 4.85000038147), -0.0012801933, 0.0098817204));

N224_8 :=__common__( if(trim(C_INCOLLEGE) != '', N224_9, -0.0069517326));

N224_7 :=__common__( map(trim(C_EASIQLIFE) = ''     => -0.0020210462,
              ((real)c_easiqlife < 63.5) => -0.0097020791,
                                            -0.0020210462));

N224_6 :=__common__( map(trim(C_LOW_ED) = ''              => -0.0076318117,
              ((real)c_low_ed < 83.3500061035) => 0.00065025754,
                                                  -0.0076318117));

N224_5 :=__common__( map(((real)f_corraddrphonecount_d <= NULL) => N224_7,
              ((real)f_corraddrphonecount_d < 0.5)   => N224_6,
                                                        N224_7));

N224_4 :=__common__( if(trim(C_LOW_ED) != '', N224_5, -0.0013833123));

N224_3 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => N224_8,
              ((real)r_d30_derog_count_i < 16.5)  => N224_4,
                                                     N224_8));

N224_2 :=__common__( if(((real)f_divaddrsuspidcountnew_i < 2.5), N224_3, 0.0060345703));

N224_1 :=__common__( if(((real)f_divaddrsuspidcountnew_i > NULL), N224_2, -0.0019040595));

N225_8 :=__common__( map(((real)r_a44_curr_add_naprop_d <= NULL) => 1.9020529e-005,
              ((real)r_a44_curr_add_naprop_d < 0.5)   => 0.0043709701,
                                                         1.9020529e-005));

N225_7 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.008764889,
              ((real)r_d32_criminal_count_i < 1.5)   => -0.0016861542,
                                                        0.008764889));

N225_6 :=__common__( map(((real)r_phn_pcs_n <= NULL) => -0.0091657448,
              ((real)r_phn_pcs_n < 0.5)   => N225_7,
                                             -0.0091657448));

N225_5 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => 0.0050635356,
              ((real)c_dist_best_to_prev_addr_i < 4.5)   => N225_6,
                                                            0.0050635356));

N225_4 :=__common__( map(((real)f_rel_ageover30_count_d <= NULL) => -0.0024448045,
              ((real)f_rel_ageover30_count_d < 4.5)   => N225_5,
                                                         -0.0024448045));

N225_3 :=__common__( if(trim(C_HVAL_175K_P) != '', N225_4, -0.0051547619));

N225_2 :=__common__( if(((real)f_rel_under25miles_cnt_d < 12.5), N225_3, N225_8));

N225_1 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N225_2, 0.0047591507));

N226_10 :=__common__( if(((real)c_sfdu_p < 96.5500030518), 0.0026567448, 0.013010502));

N226_9 :=__common__( if(trim(C_SFDU_P) != '', N226_10, 0.0091147089));

N226_8 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL)  => N226_9,
              ((real)r_a50_pb_total_dollars_d < 3239.5) => -0.00087258103,
                                                           N226_9));

N226_7 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL) => 0.0046631485,
              ((real)f_prevaddrcartheftindex_i < 184.5) => -0.0016200608,
                                                           0.0046631485));

N226_6 :=__common__( if(((real)c_easiqlife < 78.5), -0.004615221, N226_7));

N226_5 :=__common__( if(trim(C_EASIQLIFE) != '', N226_6, 0.007458688));

N226_4 :=__common__( if(((real)r_f03_input_add_not_most_rec_i < 0.5), N226_5, N226_8));

N226_3 :=__common__( if(((real)r_f03_input_add_not_most_rec_i > NULL), N226_4, -0.014779184));

N226_2 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d < 3.5), 0.0091831304, N226_3));

N226_1 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N226_2, 0.0083498312));

N227_8 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL) => -0.005683024,
              ((real)r_d33_eviction_recency_d < 79.5)  => 0.0064528195,
                                                          -0.005683024));

N227_7 :=__common__( if(((real)c_trailer < 141.5), 0.0086126066, 0.0012283488));

N227_6 :=__common__( if(trim(C_TRAILER) != '', N227_7, -0.016512075));

N227_5 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL) => N227_8,
              ((real)f_liens_unrel_cj_total_amt_i < 757.5) => N227_6,
                                                              N227_8));

N227_4 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => N227_5,
              ((real)f_curraddrcartheftindex_i < 106.5) => -0.00083293299,
                                                           N227_5));

N227_3 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => N227_4,
              ((real)r_c14_addrs_10yr_i < 3.5)   => -0.0047088122,
                                                    N227_4));

N227_2 :=__common__( if(((real)r_f03_input_add_not_most_rec_i < 0.5), -0.0015201485, N227_3));

N227_1 :=__common__( if(((real)r_f03_input_add_not_most_rec_i > NULL), N227_2, -0.0057276382));

N228_8 :=__common__( map(trim(C_MANUFACTURING) = ''     => 0.0071028784,
              ((real)c_manufacturing < 1.25) => -0.0025006082,
                                                0.0071028784));

N228_7 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => 0.0049694836,
              (segment in ['SEARS FLS'])                                  => 0.01675661,
                                                                             0.0049694836));

N228_6 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL) => 0.002298691,
              ((integer)r_d33_eviction_recency_d < 48) => N228_7,
                                                          0.002298691));

N228_5 :=__common__( map(trim(C_RETAIL) = ''              => N228_8,
              ((real)c_retail < 10.0500001907) => N228_6,
                                                  N228_8));

N228_4 :=__common__( if(((real)f_liens_unrel_o_total_amt_i < 626.5), N228_5, -0.0080353618));

N228_3 :=__common__( if(((real)f_liens_unrel_o_total_amt_i > NULL), N228_4, -0.0067786387));

N228_2 :=__common__( if(((real)c_trailer < 120.5), N228_3, -0.0018165663));

N228_1 :=__common__( if(trim(C_TRAILER) != '', N228_2, -0.0032654399));

N229_9 :=__common__( map(trim(C_HEALTH) = ''              => 0.00011244106,
              ((real)c_health < 13.4499998093) => 0.0049974618,
                                                  0.00011244106));

N229_8 :=__common__( map(trim(C_FAMOTF18_P) = ''              => N229_9,
              ((real)c_famotf18_p < 8.35000038147) => -0.0026624701,
                                                      N229_9));

N229_7 :=__common__( if(((real)r_a50_pb_total_orders_d < 2.5), N229_8, -0.0046197935));

N229_6 :=__common__( if(((real)r_a50_pb_total_orders_d > NULL), N229_7, 0.048319038));

N229_5 :=__common__( map(((real)f_mos_liens_unrel_lt_fseen_d <= NULL) => -0.00070541405,
              ((real)f_mos_liens_unrel_lt_fseen_d < 76.5)  => 0.0076837005,
                                                              -0.00070541405));

N229_4 :=__common__( if(((real)c_dist_best_to_prev_addr_i < 1.5), -0.0050927063, N229_5));

N229_3 :=__common__( if(((real)c_dist_best_to_prev_addr_i > NULL), N229_4, -0.0037896484));

N229_2 :=__common__( if(((real)c_born_usa < 116.5), N229_3, N229_6));

N229_1 :=__common__( if(trim(C_BORN_USA) != '', N229_2, -0.0055459991));

N230_10 :=__common__( if(((real)c_rental < 161.5), -0.00058687335, -0.0070896635));

N230_9 :=__common__( if(trim(C_RENTAL) != '', N230_10, -0.0016798596));

N230_8 :=__common__( if(((real)c_serv_empl < 123.5), 0.00087409852, 0.013500214));

N230_7 :=__common__( if(trim(C_SERV_EMPL) != '', N230_8, -0.0020952446));

N230_6 :=__common__( if(((real)f_inq_adls_per_phone_i < 1.5), 0.00048039382, N230_7));

N230_5 :=__common__( if(((real)f_inq_adls_per_phone_i > NULL), N230_6, -0.029201858));

N230_4 :=__common__( map(((real)r_c20_email_count_i <= NULL) => N230_9,
              ((real)r_c20_email_count_i < 3.5)   => N230_5,
                                                     N230_9));

N230_3 :=__common__( map(((real)r_i60_inq_auto_count12_i <= NULL) => -0.0087835137,
              ((real)r_i60_inq_auto_count12_i < 1.5)   => N230_4,
                                                          -0.0087835137));

N230_2 :=__common__( if(((real)c_impulse_count_i < 1.5), N230_3, 0.0058484482));

N230_1 :=__common__( if(((real)c_impulse_count_i > NULL), N230_2, -0.0082227395));

N231_10 :=__common__( map(((real)f_srchunvrfdphonecount_i <= NULL) => -0.002934326,
               ((real)f_srchunvrfdphonecount_i < 0.5)   => 0.0058490096,
                                                           -0.002934326));

N231_9 :=__common__( map(trim(C_LARCENY) = ''      => -0.0078600088,
              ((real)c_larceny < 118.5) => 0.004311659,
                                           -0.0078600088));

N231_8 :=__common__( if(((real)c_span_lang < 170.5), 0.0039116534, N231_9));

N231_7 :=__common__( if(trim(C_SPAN_LANG) != '', N231_8, 0.0047165602));

N231_6 :=__common__( if(((real)f_inq_adls_per_phone_i < 0.5), N231_7, N231_10));

N231_5 :=__common__( if(((real)f_inq_adls_per_phone_i > NULL), N231_6, -0.028732426));

N231_4 :=__common__( if(((real)c_rnt750_p < 6.44999980927), 0.0027734286, -0.0031143611));

N231_3 :=__common__( if(trim(C_RNT750_P) != '', N231_4, -0.004710099));

N231_2 :=__common__( if(((integer)f_prevaddrcartheftindex_i < 123), N231_3, N231_5));

N231_1 :=__common__( if(((real)f_prevaddrcartheftindex_i > NULL), N231_2, -0.0017087521));

N232_9 :=__common__( if(((real)c_born_usa < 189.5), -0.0027807207, 0.0057678558));

N232_8 :=__common__( if(trim(C_BORN_USA) != '', N232_9, -0.001432777));

N232_7 :=__common__( map(((real)r_i60_inq_banking_count12_i <= NULL) => -0.011168617,
              ((real)r_i60_inq_banking_count12_i < 0.5)   => N232_8,
                                                             -0.011168617));

N232_6 :=__common__( map(trim(C_WHITE_COL) = ''              => 0.00053361032,
              ((real)c_white_col < 24.6500015259) => -0.00640922,
                                                     0.00053361032));

N232_5 :=__common__( if(((real)c_hh3_p < 20.8499984741), 0.0012876663, N232_6));

N232_4 :=__common__( if(trim(C_HH3_P) != '', N232_5, -0.0017765773));

N232_3 :=__common__( map(((real)r_i60_inq_hiriskcred_recency_d <= NULL)  => N232_7,
              ((integer)r_i60_inq_hiriskcred_recency_d < 549) => N232_4,
                                                                 N232_7));

N232_2 :=__common__( if(((real)f_rel_count_i < 2.5), 0.0060714953, N232_3));

N232_1 :=__common__( if(((real)f_rel_count_i > NULL), N232_2, -0.0018105151));

N233_9 :=__common__( if(((real)c_many_cars < 36.5), 0.011759415, 0.0015023558));

N233_8 :=__common__( if(trim(C_MANY_CARS) != '', N233_9, -0.010881157));

N233_7 :=__common__( map(((real)f_srchunvrfdphonecount_i <= NULL) => -0.0022584016,
              ((real)f_srchunvrfdphonecount_i < 0.5)   => N233_8,
                                                          -0.0022584016));

N233_6 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)    => N233_7,
              ((integer)f_prevaddrmedianvalue_d < 51231) => 0.0095194326,
                                                            N233_7));

N233_5 :=__common__( map(((real)r_c15_ssns_per_adl_i <= NULL) => 0.0060290395,
              ((real)r_c15_ssns_per_adl_i < 3.5)   => -0.0010304607,
                                                      0.0060290395));

N233_4 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.179700255394), N233_5, N233_6));

N233_3 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N233_4, 0.00028721317));

N233_2 :=__common__( if(((real)f_assocsuspicousidcount_i < 17.5), N233_3, 0.011371908));

N233_1 :=__common__( if(((real)f_assocsuspicousidcount_i > NULL), N233_2, -0.0018072899));

N234_9 :=__common__( map(trim(C_HVAL_150K_P) = ''              => 0.0063914917,
              ((real)c_hval_150k_p < 29.9500007629) => -0.001446984,
                                                       0.0063914917));

N234_8 :=__common__( if(((real)c_unempl < 192.5), N234_9, 0.0062830827));

N234_7 :=__common__( if(trim(C_UNEMPL) != '', N234_8, -0.0025072433));

N234_6 :=__common__( map(((real)f_prevaddrageoldest_d <= NULL) => -5.7347173e-006,
              ((real)f_prevaddrageoldest_d < 68.5)  => 0.012081254,
                                                       -5.7347173e-006));

N234_5 :=__common__( if(((real)c_unemp < 6.64999961853), N234_6, 0.00029567461));

N234_4 :=__common__( if(trim(C_UNEMP) != '', N234_5, 0.021603419));

N234_3 :=__common__( map(((real)r_f03_input_add_not_most_rec_i <= NULL) => N234_4,
              ((real)r_f03_input_add_not_most_rec_i < 0.5)   => 0.00030468227,
                                                                N234_4));

N234_2 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 33.5), N234_3, N234_7));

N234_1 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N234_2, 0.0031878357));

N235_11 :=__common__( if(((real)c_pop_35_44_p < 11.6499996185), -0.001157036, 0.0060047124));

N235_10 :=__common__( if(trim(C_POP_35_44_P) != '', N235_11, 0.0026618692));

N235_9 :=__common__( map(trim(C_POPOVER25) = ''        => -0.010593754,
              ((integer)c_popover25 < 1964) => 0.00018352916,
                                               -0.010593754));

N235_8 :=__common__( if(((real)c_inc_100k_p < 3.45000004768), 0.007934256, N235_9));

N235_7 :=__common__( if(trim(C_INC_100K_P) != '', N235_8, 0.004314085));

N235_6 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => -0.0030823676,
              ((real)f_mos_inq_banko_cm_fseen_d < 70.5)  => N235_7,
                                                            -0.0030823676));

N235_5 :=__common__( if(((real)f_srchunvrfdaddrcount_i < 0.5), N235_6, N235_10));

N235_4 :=__common__( if(((real)f_srchunvrfdaddrcount_i > NULL), N235_5, -0.0029709794));

N235_3 :=__common__( if(((real)f_corraddrphonecount_d < 0.5), 0.0072264631, -0.00029841409));

N235_2 :=__common__( if(((real)f_corraddrphonecount_d > NULL), N235_3, 0.044707718));

N235_1 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), N235_2, N235_4));

N236_8 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)    => -0.0037695615,
              ((integer)f_curraddrmedianincome_d < 15945) => 0.0056085224,
                                                             -0.0037695615));

N236_7 :=__common__( map(((real)r_c13_curr_addr_lres_d <= NULL) => 0.0018516505,
              ((real)r_c13_curr_addr_lres_d < 4.5)   => 0.008313328,
                                                        0.0018516505));

N236_6 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N236_7,
              ((real)c_hist_addr_match_i < 2.5)   => -0.00092324526,
                                                     N236_7));

N236_5 :=__common__( if(((real)c_rentocc_p < 55.3499984741), N236_6, N236_8));

N236_4 :=__common__( if(trim(C_RENTOCC_P) != '', N236_5, 0.0018886481));

N236_3 :=__common__( map((segment in ['KMART'])                                          => 0.0022441976,
              (segment in ['RETAIL', 'SEARS AUTO', 'SEARS FLS', 'SEARS SHO']) => 0.017409512,
                                                                                 0.017409512));

N236_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 5.5), N236_3, N236_4));

N236_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N236_2, 0.0077490296));

N237_9 :=__common__( map(trim(C_UNEMP) = ''              => -0.0083312349,
              ((real)c_unemp < 8.35000038147) => 0.00083003771,
                                                 -0.0083312349));

N237_8 :=__common__( if(((real)f_inq_adls_per_phone_i < 0.5), 0.0025168612, N237_9));

N237_7 :=__common__( if(((real)f_inq_adls_per_phone_i > NULL), N237_8, -0.028727729));

N237_6 :=__common__( map(((real)f_corrphonelastnamecount_d <= NULL) => -0.0020713213,
              ((real)f_corrphonelastnamecount_d < 0.5)   => N237_7,
                                                            -0.0020713213));

N237_5 :=__common__( if(((real)c_hh2_p < 39.25), N237_6, -0.003546428));

N237_4 :=__common__( if(trim(C_HH2_P) != '', N237_5, -0.0014981975));

N237_3 :=__common__( map(((real)r_d31_bk_filing_count_i <= NULL) => 0.0095788994,
              ((real)r_d31_bk_filing_count_i < 2.5)   => N237_4,
                                                         0.0095788994));

N237_2 :=__common__( if(((real)f_srchcomponentrisktype_i < 2.5), N237_3, 0.005862391));

N237_1 :=__common__( if(((real)f_srchcomponentrisktype_i > NULL), N237_2, 8.7671893e-005));

N238_11 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)    => 0.0016747089,
               ((integer)f_prevaddrmedianvalue_d < 90342) => -0.0056875188,
                                                             0.0016747089));

N238_10 :=__common__( map(trim(C_FEMDIV_P) = ''              => 0.0043076712,
               ((real)c_femdiv_p < 2.84999990463) => 0.01508878,
                                                     0.0043076712));

N238_9 :=__common__( if(((real)f_rel_incomeover25_count_d < 5.5), N238_10, 0.0011263892));

N238_8 :=__common__( if(((real)f_rel_incomeover25_count_d > NULL), N238_9, 0.0060812432));

N238_7 :=__common__( if(((real)c_preschl < 174.5), N238_8, N238_11));

N238_6 :=__common__( if(trim(C_PRESCHL) != '', N238_7, 0.014091709));

N238_5 :=__common__( if(((real)c_construction < 5.75), 0.00035220304, -0.0042264307));

N238_4 :=__common__( if(trim(C_CONSTRUCTION) != '', N238_5, 0.00022274547));

N238_3 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i < 124.5), N238_4, N238_6));

N238_2 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N238_3, -0.0059737789));

N238_1 :=__common__( if(((real)r_phn_pcs_n > NULL), N238_2, -0.028365368));

N239_9 :=__common__( map(trim(C_POPOVER25) = ''      => 0.0027690383,
              ((real)c_popover25 < 994.5) => 0.015629948,
                                             0.0027690383));

N239_8 :=__common__( if(((real)c_health < 3.75), -0.0012728393, N239_9));

N239_7 :=__common__( if(trim(C_HEALTH) != '', N239_8, 0.024602143));

N239_6 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => 0.00020924485,
              ((real)c_dist_best_to_prev_addr_i < 1.5)   => -0.0032022422,
                                                            0.00020924485));

N239_5 :=__common__( map(trim(C_RICH_WHT) = ''      => 0.0040854243,
              ((real)c_rich_wht < 162.5) => N239_6,
                                            0.0040854243));

N239_4 :=__common__( if(((real)c_hval_60k_p < 44.8499984741), N239_5, 0.0080438235));

N239_3 :=__common__( if(trim(C_HVAL_60K_P) != '', N239_4, -0.0054857791));

N239_2 :=__common__( if(((real)r_d30_derog_count_i < 16.5), N239_3, N239_7));

N239_1 :=__common__( if(((real)r_d30_derog_count_i > NULL), N239_2, -0.0026653307));

N240_8 :=__common__( if(((real)c_impulse_count_i < 1.5), 0.001513279, 0.011663261));

N240_7 :=__common__( if(((real)c_impulse_count_i > NULL), N240_8, -0.013737682));

N240_6 :=__common__( map(trim(C_RNT250_P) = ''              => 0.011298161,
              ((real)c_rnt250_p < 31.4500007629) => N240_7,
                                                    0.011298161));

N240_5 :=__common__( map(trim(C_YOUNG) = ''              => N240_6,
              ((real)c_young < 24.1500015259) => -0.00070226292,
                                                 N240_6));

N240_4 :=__common__( map(trim(C_RETAIL) = ''              => -0.0067932495,
              ((real)c_retail < 4.85000038147) => -0.0012826572,
                                                  -0.0067932495));

N240_3 :=__common__( map(trim(C_INC_100K_P) = ''              => N240_4,
              ((real)c_inc_100k_p < 1.95000004768) => 0.0049472279,
                                                      N240_4));

N240_2 :=__common__( if(((real)c_popover25 < 658.5), N240_3, N240_5));

N240_1 :=__common__( if(trim(C_POPOVER25) != '', N240_2, -0.0023786113));

N241_8 :=__common__( if(((real)c_rnt1250_p < 26.5499992371), 0.00084797803, 0.01049452));

N241_7 :=__common__( if(trim(C_RNT1250_P) != '', N241_8, -0.0020988852));

N241_6 :=__common__( map(((real)f_inq_retail_count24_i <= NULL) => -0.0056392712,
              ((real)f_inq_retail_count24_i < 0.5)   => N241_7,
                                                        -0.0056392712));

N241_5 :=__common__( map(((real)f_liens_unrel_sc_total_amt_i <= NULL)  => 0.0085848874,
              ((real)f_liens_unrel_sc_total_amt_i < 2741.5) => N241_6,
                                                               0.0085848874));

N241_4 :=__common__( map(((real)f_vardobcountnew_i <= NULL) => -0.0058136502,
              ((real)f_vardobcountnew_i < 0.5)   => 0.0003435977,
                                                    -0.0058136502));

N241_3 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N241_5,
              ((real)c_hist_addr_match_i < 1.5)   => N241_4,
                                                     N241_5));

N241_2 :=__common__( if(((real)r_c10_m_hdr_fs_d < 339.5), N241_3, -0.0058052556));

N241_1 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N241_2, 0.0038211743));

N242_9 :=__common__( if(((real)c_lar_fam < 148.5), -0.0071942728, 0.0069974474));

N242_8 :=__common__( if(trim(C_LAR_FAM) != '', N242_9, -0.021955566));

N242_7 :=__common__( map(trim(C_ASIAN_LANG) = ''      => 0.0022698177,
              ((real)c_asian_lang < 132.5) => -0.0019238278,
                                              0.0022698177));

N242_6 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => 0.0091612417,
              ((real)f_mos_liens_unrel_cj_fseen_d < 97.5)  => -0.0022499305,
                                                              0.0091612417));

N242_5 :=__common__( map(trim(C_POP_6_11_P) = ''      => N242_6,
              ((real)c_pop_6_11_p < 10.25) => 0.00088512352,
                                              N242_6));

N242_4 :=__common__( if(((real)c_span_lang < 86.5), N242_5, N242_7));

N242_3 :=__common__( if(trim(C_SPAN_LANG) != '', N242_4, 0.00077707145));

N242_2 :=__common__( if(((real)f_prevaddrageoldest_d < 149.5), N242_3, N242_8));

N242_1 :=__common__( if(((real)f_prevaddrageoldest_d > NULL), N242_2, -0.0011709809));

N243_8 :=__common__( map(trim(C_URBAN_P) = ''              => -0.0011196799,
              ((real)c_urban_p < 97.5999984741) => -0.011085519,
                                                   -0.0011196799));

N243_7 :=__common__( map(((real)r_d32_mos_since_fel_ls_d <= NULL) => 0.00092640545,
              ((real)r_d32_mos_since_fel_ls_d < 136.5) => 0.0089731817,
                                                          0.00092640545));

N243_6 :=__common__( map(((real)f_current_count_d <= NULL) => N243_8,
              ((real)f_current_count_d < 1.5)   => N243_7,
                                                   N243_8));

N243_5 :=__common__( map(((real)f_liens_unrel_sc_total_amt_i <= NULL)   => 0.0099048935,
              ((integer)f_liens_unrel_sc_total_amt_i < 5008) => N243_6,
                                                                0.0099048935));

N243_4 :=__common__( if(((real)c_rape < 34.5), 0.0083841119, N243_5));

N243_3 :=__common__( if(trim(C_RAPE) != '', N243_4, 0.002873916));

N243_2 :=__common__( if(((integer)f_curraddrburglaryindex_i < 78), -0.0029054935, N243_3));

N243_1 :=__common__( if(((real)f_curraddrburglaryindex_i > NULL), N243_2, 0.0038603549));

N244_9 :=__common__( map(((real)c_addr_lres_6mo_ct_i <= NULL) => 0.0077205196,
              ((real)c_addr_lres_6mo_ct_i < 8.5)   => -0.00088524148,
                                                      0.0077205196));

N244_8 :=__common__( if(((real)c_burglary < 134.5), N244_9, -0.0048434153));

N244_7 :=__common__( if(trim(C_BURGLARY) != '', N244_8, 0.0079511692));

N244_6 :=__common__( map(trim(C_ROBBERY) = ''     => 0.0037773347,
              ((real)c_robbery < 64.5) => 0.017252312,
                                          0.0037773347));

N244_5 :=__common__( if(((real)c_armforce < 129.5), 0.0010034766, N244_6));

N244_4 :=__common__( if(trim(C_ARMFORCE) != '', N244_5, 0.0062236245));

N244_3 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => N244_4,
              ((real)r_c14_addrs_5yr_i < 0.5)   => -0.0050710641,
                                                   N244_4));

N244_2 :=__common__( if(((real)f_rel_incomeover50_count_d < 3.5), N244_3, N244_7));

N244_1 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N244_2, 0.0068541765));

N245_8 :=__common__( map(((real)f_liens_unrel_sc_total_amt_i <= NULL)  => 0.0097891675,
              ((real)f_liens_unrel_sc_total_amt_i < 2698.5) => -0.0017901164,
                                                               0.0097891675));

N245_7 :=__common__( map(trim(C_RELIG_INDX) = ''      => 0.010980289,
              ((real)c_relig_indx < 178.5) => 0.001926698,
                                              0.010980289));

N245_6 :=__common__( map(trim(C_RETIRED2) = ''     => N245_8,
              ((real)c_retired2 < 83.5) => N245_7,
                                           N245_8));

N245_5 :=__common__( if(((real)r_c10_m_hdr_fs_d < 347.5), N245_6, -0.0084374847));

N245_4 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N245_5, 0.0048231781));

N245_3 :=__common__( map(trim(C_BORN_USA) = ''     => N245_4,
              ((real)c_born_usa < 50.5) => -0.0057383382,
                                           N245_4));

N245_2 :=__common__( if(((integer)c_rape < 82), 0.002608483, N245_3));

N245_1 :=__common__( if(trim(C_RAPE) != '', N245_2, -4.6922697e-005));

N246_8 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => 0.0048629287,
              (segment in ['SEARS FLS'])                                  => 0.013463463,
                                                                             0.0048629287));

N246_7 :=__common__( map(trim(C_POP00) = ''      => N246_8,
              ((real)c_pop00 < 944.5) => -0.00085921542,
                                         N246_8));

N246_6 :=__common__( map(((real)c_addr_lres_12mo_ct_i <= NULL) => 0.00031721229,
              ((real)c_addr_lres_12mo_ct_i < 5.5)   => N246_7,
                                                       0.00031721229));

N246_5 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => N246_6,
              ((real)f_rel_felony_count_i < 0.5)   => -0.00071873876,
                                                      N246_6));

N246_4 :=__common__( if(((real)f_mos_acc_lseen_d < 665.5), -0.0025719351, N246_5));

N246_3 :=__common__( if(((real)f_mos_acc_lseen_d > NULL), N246_4, -0.0033108823));

N246_2 :=__common__( if(((real)c_mining < 1.45000004768), N246_3, -0.011694336));

N246_1 :=__common__( if(trim(C_MINING) != '', N246_2, 0.0039656986));

N247_8 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => 0.00067308459,
              (segment in ['SEARS FLS'])                                  => 0.0043804577,
                                                                             0.00067308459));

N247_7 :=__common__( map(trim(C_HVAL_175K_P) = ''              => 0.0095000628,
              ((real)c_hval_175k_p < 25.3499984741) => N247_8,
                                                       0.0095000628));

N247_6 :=__common__( map(((real)f_liens_rel_cj_total_amt_i <= NULL) => -0.0064032556,
              ((real)f_liens_rel_cj_total_amt_i < 743.5) => N247_7,
                                                            -0.0064032556));

N247_5 :=__common__( if(trim(C_HVAL_175K_P) != '', N247_6, 0.00021757344));

N247_4 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => 0.0015385355,
              ((real)f_srchfraudsrchcount_i < 9.5)   => -0.0061263764,
                                                        0.0015385355));

N247_3 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => N247_5,
              ((integer)r_i60_inq_auto_recency_d < 549) => N247_4,
                                                           N247_5));

N247_2 :=__common__( if(((real)r_c20_email_domain_isp_count_i < 2.5), N247_3, -0.0048124193));

N247_1 :=__common__( if(((real)r_c20_email_domain_isp_count_i > NULL), N247_2, -0.00022821989));

N248_9 :=__common__( if(((real)c_unempl < 107.5), 0.0069984785, 0.00043663638));

N248_8 :=__common__( if(trim(C_UNEMPL) != '', N248_9, 0.0079943235));

N248_7 :=__common__( map(trim(C_FEMDIV_P) = ''              => 0.00089237071,
              ((real)c_femdiv_p < 2.15000009537) => 0.0091703234,
                                                    0.00089237071));

N248_6 :=__common__( map(trim(C_ASSAULT) = ''      => -0.0046337127,
              ((real)c_assault < 141.5) => 0.00011795301,
                                           -0.0046337127));

N248_5 :=__common__( if(((real)c_born_usa < 154.5), N248_6, N248_7));

N248_4 :=__common__( if(trim(C_BORN_USA) != '', N248_5, -0.0027011562));

N248_3 :=__common__( map(((real)f_varmsrcssncount_i <= NULL) => N248_8,
              ((real)f_varmsrcssncount_i < 1.5)   => N248_4,
                                                     N248_8));

N248_2 :=__common__( if(((real)r_f00_input_dob_match_level_d < 3.5), 0.0094037862, N248_3));

N248_1 :=__common__( if(((real)r_f00_input_dob_match_level_d > NULL), N248_2, -0.0054947407));

N249_9 :=__common__( map(((real)f_varmsrcssncount_i <= NULL) => 0.0041637587,
              ((real)f_varmsrcssncount_i < 1.5)   => -0.001175062,
                                                     0.0041637587));

N249_8 :=__common__( map(((real)r_d32_mos_since_fel_ls_d <= NULL) => N249_9,
              ((real)r_d32_mos_since_fel_ls_d < 128.5) => 0.0091690081,
                                                          N249_9));

N249_7 :=__common__( if(((real)c_unemp < 14.4499998093), N249_8, -0.0090633848));

N249_6 :=__common__( if(trim(C_UNEMP) != '', N249_7, 0.00045891367));

N249_5 :=__common__( if(((real)f_rel_homeover50_count_d < 3.5), 0.010473453, N249_6));

N249_4 :=__common__( if(((real)f_rel_homeover50_count_d > NULL), N249_5, 0.0050538568));

N249_3 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => N249_4,
              ((real)f_srchfraudsrchcount_i < 7.5)   => -0.0017922719,
                                                        N249_4));

N249_2 :=__common__( if(((real)r_f00_input_dob_match_level_d < 5.5), 0.0077385591, N249_3));

N249_1 :=__common__( if(((real)r_f00_input_dob_match_level_d > NULL), N249_2, 0.0052514071));

N250_8 :=__common__( if(((integer)c_robbery < 70), -0.00470988, -0.0003253236));

N250_7 :=__common__( if(trim(C_ROBBERY) != '', N250_8, -0.0018739159));

N250_6 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.015405195,
              ((real)f_inq_other_count24_i < 1.5)   => 0.0028548252,
                                                       0.015405195));

N250_5 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => 0.0019116188,
              ((real)f_curraddrmurderindex_i < 112.5) => N250_6,
                                                         0.0019116188));

N250_4 :=__common__( map(((real)c_dist_input_to_prev_addr_i <= NULL) => 0.0021490486,
              ((real)c_dist_input_to_prev_addr_i < 2.5)   => -0.0037623867,
                                                             0.0021490486));

N250_3 :=__common__( map(((real)f_srchunvrfdssncount_i <= NULL) => N250_5,
              ((real)f_srchunvrfdssncount_i < 0.5)   => N250_4,
                                                        N250_5));

N250_2 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 34.5), N250_3, N250_7));

N250_1 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N250_2, 0.0032505025));

N251_9 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0183326937258), -0.0053141995, 0.006263412));

N251_8 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N251_9, 9.7718414e-005));

N251_7 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N251_8,
              ((real)c_hist_addr_match_i < 2.5)   => -0.002096369,
                                                     N251_8));

N251_6 :=__common__( map(trim(C_POP00) = ''       => 0.0066515686,
              ((real)c_pop00 < 1506.5) => N251_7,
                                          0.0066515686));

N251_5 :=__common__( map(((real)f_inq_highriskcredit_count24_i <= NULL) => -0.0049504694,
              ((real)f_inq_highriskcredit_count24_i < 7.5)   => N251_6,
                                                                -0.0049504694));

N251_4 :=__common__( if(((real)c_newhouse < 5.14999961853), N251_5, -0.0012505545));

N251_3 :=__common__( if(trim(C_NEWHOUSE) != '', N251_4, -0.0013587588));

N251_2 :=__common__( if(((real)r_f00_input_dob_match_level_d < 5.5), 0.007409516, N251_3));

N251_1 :=__common__( if(((real)r_f00_input_dob_match_level_d > NULL), N251_2, 0.0008628133));

N252_10 :=__common__( map(trim(C_FEMDIV_P) = ''              => 0.011875799,
               ((real)c_femdiv_p < 3.84999990463) => 0.00086311917,
                                                     0.011875799));

N252_9 :=__common__( map(trim(C_HEALTH) = ''      => -0.0043700745,
              ((real)c_health < 21.75) => N252_10,
                                          -0.0043700745));

N252_8 :=__common__( if(((real)c_child < 30.75), -0.00058976318, N252_9));

N252_7 :=__common__( if(trim(C_CHILD) != '', N252_8, -0.0026791075));

N252_6 :=__common__( map(trim(C_MANUFACTURING) = ''              => -0.0087347633,
              ((real)c_manufacturing < 7.14999961853) => 0.0027232061,
                                                         -0.0087347633));

N252_5 :=__common__( if(((real)c_low_ed < 71.75), N252_6, -0.0066706057));

N252_4 :=__common__( if(trim(C_LOW_ED) != '', N252_5, 0.01075308));

N252_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N252_4, N252_7));

N252_2 :=__common__( if(((real)r_pb_order_freq_d < 41.5), 0.00068288337, -0.0041099448));

N252_1 :=__common__( if(((real)r_pb_order_freq_d > NULL), N252_2, N252_3));

N253_8 :=__common__( map(trim(C_HHSIZE) = ''              => 0.0063019524,
              ((real)c_hhsize < 2.69500017166) => -0.0041465972,
                                                  0.0063019524));

N253_7 :=__common__( map(trim(C_RETAIL) = ''              => 0.0046046113,
              ((real)c_retail < 10.6499996185) => 0.013876854,
                                                  0.0046046113));

N253_6 :=__common__( map(trim(C_NO_MOVE) = ''      => N253_8,
              ((real)c_no_move < 102.5) => N253_7,
                                           N253_8));

N253_5 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => N253_6,
              ((real)f_add_input_nhood_vac_pct_i < 0.0246500782669) => -0.00056011465,
                                                                       N253_6));

N253_4 :=__common__( map(trim(C_POP_75_84_P) = ''              => -5.7830187e-005,
              ((real)c_pop_75_84_p < 1.84999990463) => N253_5,
                                                       -5.7830187e-005));

N253_3 :=__common__( if(((real)c_larceny < 174.5), N253_4, -0.0023698132));

N253_2 :=__common__( if(trim(C_LARCENY) != '', N253_3, 0.0032582113));

N253_1 :=__common__( if(((real)r_c20_email_count_i > NULL), N253_2, 0.0051395578));

N254_7 :=__common__( map(trim(C_INC_100K_P) = ''              => -0.0048504193,
              ((real)c_inc_100k_p < 12.5500001907) => 0.00065130089,
                                                      -0.0048504193));

N254_6 :=__common__( map(trim(C_BEL_EDU) = ''      => -0.0066814061,
              ((real)c_bel_edu < 176.5) => N254_7,
                                           -0.0066814061));

N254_5 :=__common__( map(trim(C_POP_45_54_P) = ''              => 0.018309216,
              ((real)c_pop_45_54_p < 13.4499998093) => 0.0040186042,
                                                       0.018309216));

N254_4 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => N254_5,
              ((real)f_add_input_nhood_vac_pct_i < 0.0626140683889) => 0.00097229811,
                                                                       N254_5));

N254_3 :=__common__( map(trim(C_RELIG_INDX) = ''      => N254_4,
              ((real)c_relig_indx < 171.5) => 0.00063502491,
                                              N254_4));

N254_2 :=__common__( if(((real)c_hval_100k_p < 13.9499998093), N254_3, N254_6));

N254_1 :=__common__( if(trim(C_HVAL_100K_P) != '', N254_2, 0.0036915936));

N255_6 :=__common__( map(trim(C_EXP_PROD) = ''     => 0.0066666634,
              ((real)c_exp_prod < 71.5) => 0.0010170618,
                                           0.0066666634));

N255_5 :=__common__( map(trim(C_UNATTACH) = ''     => N255_6,
              ((real)c_unattach < 81.5) => -0.0027963103,
                                           N255_6));

N255_4 :=__common__( if(((real)c_femdiv_p < 5.35000038147), N255_5, -0.00061531404));

N255_3 :=__common__( if(trim(C_FEMDIV_P) != '', N255_4, 0.0024573238));

N255_2 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N255_3,
              ((real)f_sourcerisktype_i < 2.5)   => -0.0081818386,
                                                    N255_3));

N255_1 :=__common__( map(((real)f_util_add_curr_misc_n <= NULL) => N255_2,
              ((real)f_util_add_curr_misc_n < 0.5)   => -0.0023618057,
                                                        N255_2));

N256_10 :=__common__( map(trim(C_FAMMAR18_P) = ''              => -0.0043723723,
               ((real)c_fammar18_p < 14.1499996185) => 0.0016351925,
                                                       -0.0043723723));

N256_9 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.0092707267,
              ((real)r_c14_addrs_10yr_i < 8.5)   => -0.0015163836,
                                                    0.0092707267));

N256_8 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d < 18.5), N256_9, N256_10));

N256_7 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d > NULL), N256_8, -0.00075333007));

N256_6 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 3.5), 0.010649136, 0.0012179486));

N256_5 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N256_6, 0.015786962));

N256_4 :=__common__( if(((real)r_i60_inq_comm_recency_d < 4.5), N256_5, 0.00065750198));

N256_3 :=__common__( if(((real)r_i60_inq_comm_recency_d > NULL), N256_4, -0.0076059211));

N256_2 :=__common__( if(((real)c_hval_125k_p < 14.4499998093), N256_3, N256_7));

N256_1 :=__common__( if(trim(C_HVAL_125K_P) != '', N256_2, -0.0015629092));

N257_9 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => 0.0056797555,
              ((real)f_srchaddrsrchcount_i < 4.5)   => 0.00051451178,
                                                       0.0056797555));

N257_8 :=__common__( if(((real)c_hh2_p < 14.25), 0.0084912404, 5.7058703e-006));

N257_7 :=__common__( if(trim(C_HH2_P) != '', N257_8, 0.0124257));

N257_6 :=__common__( map(((real)f_rel_criminal_count_i <= NULL) => -0.0055302163,
              ((real)f_rel_criminal_count_i < 9.5)   => N257_7,
                                                        -0.0055302163));

N257_5 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)    => N257_9,
              ((integer)f_curraddrmedianincome_d < 39140) => N257_6,
                                                             N257_9));

N257_4 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i < 86.3500061035), 0.0047167881, -0.0048064289));

N257_3 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N257_4, -0.0012782323));

N257_2 :=__common__( if(((real)f_prevaddrcartheftindex_i < 134.5), N257_3, N257_5));

N257_1 :=__common__( if(((real)f_prevaddrcartheftindex_i > NULL), N257_2, -0.00065043112));

N258_9 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => -0.010518421,
              ((real)r_c21_m_bureau_adl_fs_d < 278.5) => -0.00058732494,
                                                         -0.010518421));

N258_8 :=__common__( if(((real)f_rel_ageover20_count_d < 9.5), 0.0045987996, N258_9));

N258_7 :=__common__( if(((real)f_rel_ageover20_count_d > NULL), N258_8, -0.003424373));

N258_6 :=__common__( map(trim(C_HVAL_80K_P) = ''     => N258_7,
              ((real)c_hval_80k_p < 3.75) => 0.0054939726,
                                             N258_7));

N258_5 :=__common__( map(((real)r_i61_inq_collection_count12_i <= NULL) => 0.0068007628,
              ((real)r_i61_inq_collection_count12_i < 1.5)   => -0.0015665738,
                                                                0.0068007628));

N258_4 :=__common__( map(trim(C_FOR_SALE) = ''      => N258_6,
              ((real)c_for_sale < 107.5) => N258_5,
                                            N258_6));

N258_3 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i < 4.5), N258_4, -0.0046786221));

N258_2 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i > NULL), N258_3, -0.0011888957));

N258_1 :=__common__( if(trim(C_FOR_SALE) != '', N258_2, 0.001944872));

N259_8 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.010584485,
              ((real)c_easiqlife < 112.5) => 0.0023235646,
                                             0.010584485));

N259_7 :=__common__( if(((real)c_rental < 93.5), -0.0014301355, N259_8));

N259_6 :=__common__( if(trim(C_RENTAL) != '', N259_7, -0.00030957107));

N259_5 :=__common__( map(((real)r_prop_owner_history_d <= NULL) => -0.0054397595,
              ((real)r_prop_owner_history_d < 0.5)   => N259_6,
                                                        -0.0054397595));

N259_4 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.0003098991,
              (segment in ['SEARS FLS'])                                  => N259_5,
                                                                             -0.0003098991));

N259_3 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS FLS', 'SEARS SHO']) => -0.012252283,
              (segment in ['KMART'])                                          => -0.00023110905,
                                                                                 -0.012252283));

N259_2 :=__common__( map(((real)r_i60_inq_retail_recency_d <= NULL) => N259_4,
              ((real)r_i60_inq_retail_recency_d < 61.5)  => N259_3,
                                                            N259_4));

N259_1 :=__common__( if(((real)f_inq_retail_count24_i > NULL), N259_2, -0.0066994984));

N260_8 :=__common__( map(((real)f_assocsuspicousidcount_i <= NULL) => 0.0096508845,
              ((real)f_assocsuspicousidcount_i < 9.5)   => 0.0015242431,
                                                           0.0096508845));

N260_7 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => N260_8,
              ((real)r_c14_addrs_10yr_i < 8.5)   => -0.00049610585,
                                                    N260_8));

N260_6 :=__common__( map(trim(C_FAMOTF18_P) = ''              => -0.012844381,
              ((real)c_famotf18_p < 45.4500007629) => -0.002856493,
                                                      -0.012844381));

N260_5 :=__common__( map(((real)f_corrssnnamecount_d <= NULL) => N260_6,
              ((real)f_corrssnnamecount_d < 3.5)   => 0.0017504595,
                                                      N260_6));

N260_4 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => N260_7,
              ((real)r_c13_max_lres_d < 54.5)  => N260_5,
                                                  N260_7));

N260_3 :=__common__( if(trim(C_POP_6_11_P) != '', N260_4, 0.00048038313));

N260_2 :=__common__( if(((real)f_curraddrmurderindex_i < 198.5), N260_3, 0.0082444043));

N260_1 :=__common__( if(((real)f_curraddrmurderindex_i > NULL), N260_2, 0.00023881906));

N261_10 :=__common__( if(((real)f_add_input_mobility_index_n < 0.206445917487), 0.0096124975, -0.0013239212));

N261_9 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N261_10, -0.039438481));

N261_8 :=__common__( map(((real)f_fp_prevaddrcrimeindex_i <= NULL)  => 0.0050766274,
              ((integer)f_fp_prevaddrcrimeindex_i < 121) => 0.00045657714,
                                                            0.0050766274));

N261_7 :=__common__( if(((real)c_assault < 129.5), N261_8, N261_9));

N261_6 :=__common__( if(trim(C_ASSAULT) != '', N261_7, -0.0026976621));

N261_5 :=__common__( map(((real)r_s66_adlperssn_count_i <= NULL) => 0.0051085039,
              ((real)r_s66_adlperssn_count_i < 1.5)   => -0.0037887809,
                                                         0.0051085039));

N261_4 :=__common__( if(((real)c_easiqlife < 112.5), -0.0051136394, N261_5));

N261_3 :=__common__( if(trim(C_EASIQLIFE) != '', N261_4, -0.005546179));

N261_2 :=__common__( if(((real)f_assocrisktype_i < 2.5), N261_3, N261_6));

N261_1 :=__common__( if(((real)f_assocrisktype_i > NULL), N261_2, -0.0068691952));

N262_8 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.0035287079,
              ((integer)c_sub_bus < 77) => -0.0043258998,
                                           0.0035287079));

N262_7 :=__common__( map(((real)f_current_count_d <= NULL) => -0.0085978656,
              ((real)f_current_count_d < 2.5)   => N262_8,
                                                   -0.0085978656));

N262_6 :=__common__( map(trim(C_SPAN_LANG) = ''      => N262_7,
              ((real)c_span_lang < 145.5) => 0.0028303846,
                                             N262_7));

N262_5 :=__common__( map(((real)r_i60_inq_auto_count12_i <= NULL) => -0.0043324282,
              ((real)r_i60_inq_auto_count12_i < 0.5)   => N262_6,
                                                          -0.0043324282));

N262_4 :=__common__( if(((real)r_c20_email_count_i < 4.5), N262_5, -0.0029564544));

N262_3 :=__common__( if(((real)r_c20_email_count_i > NULL), N262_4, 0.00028491689));

N262_2 :=__common__( if(((real)c_hh00 < 304.5), -0.0037390305, N262_3));

N262_1 :=__common__( if(trim(C_HH00) != '', N262_2, 0.003115267));

N263_11 :=__common__( if(((real)c_hval_175k_p < 10.1499996185), 0.0022082752, -0.0029494981));

N263_10 :=__common__( if(trim(C_HVAL_175K_P) != '', N263_11, -0.0044265764));

N263_9 :=__common__( if(((real)c_inc_75k_p < 27.5499992371), -0.003677132, 0.007552776));

N263_8 :=__common__( if(trim(C_INC_75K_P) != '', N263_9, -0.0044797085));

N263_7 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => N263_10,
              ((real)r_c10_m_hdr_fs_d < 162.5) => N263_8,
                                                  N263_10));

N263_6 :=__common__( map(trim(C_HH00) = ''      => 0.0077069205,
              ((real)c_hh00 < 404.5) => -0.0027838305,
                                        0.0077069205));

N263_5 :=__common__( if(((real)c_inc_100k_p < 7.44999980927), -0.0040269485, N263_6));

N263_4 :=__common__( if(trim(C_INC_100K_P) != '', N263_5, -0.011501771));

N263_3 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), N263_4, N263_7));

N263_2 :=__common__( if(((real)f_srchaddrsrchcount_i < 18.5), N263_3, 0.0028790148));

N263_1 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N263_2, 0.0049060021));

N264_8 :=__common__( map(((real)f_util_adl_count_n <= NULL) => 0.0056156468,
              ((real)f_util_adl_count_n < 12.5)  => -0.00094545823,
                                                    0.0056156468));

N264_7 :=__common__( map(trim(C_LOW_ED) = ''              => 0.008986841,
              ((real)c_low_ed < 59.8499984741) => 0.00099787747,
                                                  0.008986841));

N264_6 :=__common__( map(((real)f_historical_count_d <= NULL) => N264_7,
              ((real)f_historical_count_d < 0.5)   => -0.0042221061,
                                                      N264_7));

N264_5 :=__common__( map(trim(C_NO_LABFOR) = ''     => N264_6,
              ((real)c_no_labfor < 78.5) => 0.015352388,
                                            N264_6));

N264_4 :=__common__( if(((real)c_born_usa < 95.5), -0.0031986191, N264_5));

N264_3 :=__common__( if(trim(C_BORN_USA) != '', N264_4, -0.0070958067));

N264_2 :=__common__( if(((real)f_rel_incomeover50_count_d < 0.5), N264_3, N264_8));

N264_1 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N264_2, 0.00021227877));

N265_7 :=__common__( map(((real)c_addr_lres_12mo_ct_i <= NULL) => -0.0021674594,
              ((real)c_addr_lres_12mo_ct_i < 5.5)   => 0.0033195495,
                                                       -0.0021674594));

N265_6 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => 0.0027751419,
              ((real)r_d30_derog_count_i < 1.5)   => -0.010259022,
                                                     0.0027751419));

N265_5 :=__common__( if(((real)f_college_income_d > NULL), N265_6, N265_7));

N265_4 :=__common__( map(((real)f_corrrisktype_i <= NULL) => N265_5,
              ((real)f_corrrisktype_i < 4.5)   => -0.0050995711,
                                                  N265_5));

N265_3 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => N265_4,
              ((real)f_mos_inq_banko_cm_fseen_d < 70.5)  => 0.0015672737,
                                                            N265_4));

N265_2 :=__common__( if(((real)f_mos_liens_rel_ot_lseen_d < 115.5), -0.0075826593, N265_3));

N265_1 :=__common__( if(((real)f_mos_liens_rel_ot_lseen_d > NULL), N265_2, -0.0070608517));

N266_9 :=__common__( if(((real)f_curraddractivephonelist_d > NULL), -0.0049230756, 0.013966605));

N266_8 :=__common__( map(trim(C_EASIQLIFE) = ''      => -0.010344855,
              ((real)c_easiqlife < 143.5) => 0.00041877194,
                                             -0.010344855));

N266_7 :=__common__( if(((real)f_rel_homeover150_count_d < 2.5), N266_8, N266_9));

N266_6 :=__common__( if(((real)f_rel_homeover150_count_d > NULL), N266_7, 0.0001494732));

N266_5 :=__common__( map(((real)f_util_adl_count_n <= NULL) => 0.0042021732,
              ((real)f_util_adl_count_n < 5.5)   => -0.00019976249,
                                                    0.0042021732));

N266_4 :=__common__( if(((real)c_hval_80k_p < 4.64999961853), N266_5, N266_6));

N266_3 :=__common__( if(trim(C_HVAL_80K_P) != '', N266_4, -0.00037528734));

N266_2 :=__common__( if(((real)f_rel_bankrupt_count_i < 9.5), N266_3, 0.0085192221));

N266_1 :=__common__( if(((real)f_rel_bankrupt_count_i > NULL), N266_2, -0.0052873096));

N267_9 :=__common__( map(trim(C_HH6_P) = ''              => 0.00085907388,
              ((real)c_hh6_p < 2.65000009537) => -0.0084177157,
                                                 0.00085907388));

N267_8 :=__common__( map(trim(C_RELIG_INDX) = ''      => 0.005392513,
              ((real)c_relig_indx < 170.5) => N267_9,
                                              0.005392513));

N267_7 :=__common__( if(((real)r_phn_pcs_n < 0.5), 0.001114045, -0.0033833184));

N267_6 :=__common__( if(((real)r_phn_pcs_n > NULL), N267_7, -0.028237272));

N267_5 :=__common__( if(((real)f_varmsrcssncount_i < 1.5), N267_6, 0.0038172662));

N267_4 :=__common__( if(((real)f_varmsrcssncount_i > NULL), N267_5, 0.01030257));

N267_3 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.0084312914,
              ((real)c_comb_age_d < 58.5)  => N267_4,
                                              -0.0084312914));

N267_2 :=__common__( if(((real)c_rentocc_p < 63.6500015259), N267_3, N267_8));

N267_1 :=__common__( if(trim(C_RENTOCC_P) != '', N267_2, -0.00098537973));

N268_7 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => 0.0019672768,
              ((integer)f_curraddrmurderindex_i < 98) => 0.015065272,
                                                         0.0019672768));

N268_6 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.0017369544,
              ((real)r_c14_addrs_10yr_i < 2.5)   => -0.0049803659,
                                                    0.0017369544));

N268_5 :=__common__( if(((real)c_rnt1500_p < 7.05000019073), N268_6, N268_7));

N268_4 :=__common__( if(trim(C_RNT1500_P) != '', N268_5, 0.0011376956));

N268_3 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N268_4,
              ((real)c_hist_addr_match_i < 1.5)   => -0.001606832,
                                                     N268_4));

N268_2 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N268_3, 8.461529e-005));

N268_1 :=__common__( map(((real)c_inf_fname_verd_d <= NULL) => -0.0042925124,
              ((real)c_inf_fname_verd_d < 0.5)   => N268_2,
                                                    -0.0042925124));

N269_8 :=__common__( map(trim(C_SPAN_LANG) = ''     => -0.0012555545,
              ((real)c_span_lang < 82.5) => 0.010822782,
                                            -0.0012555545));

N269_7 :=__common__( map(trim(C_MED_AGE) = ''              => 0.011301233,
              ((real)c_med_age < 32.9500007629) => -0.0014198989,
                                                   0.011301233));

N269_6 :=__common__( map(trim(C_SERV_EMPL) = ''      => 0.0070867476,
              ((real)c_serv_empl < 193.5) => -0.00053291548,
                                             0.0070867476));

N269_5 :=__common__( map(trim(C_HH4_P) = ''              => N269_6,
              ((real)c_hh4_p < 1.95000004768) => -0.0061122371,
                                                 N269_6));

N269_4 :=__common__( if(((real)f_rel_criminal_count_i > NULL), N269_5, -0.0016581848));

N269_3 :=__common__( map(trim(C_HVAL_150K_P) = ''              => N269_7,
              ((real)c_hval_150k_p < 27.9500007629) => N269_4,
                                                       N269_7));

N269_2 :=__common__( if(((real)c_lowinc < 77.8500061035), N269_3, N269_8));

N269_1 :=__common__( if(trim(C_LOWINC) != '', N269_2, 0.0043543484));

N270_9 :=__common__( map(trim(C_CONSTRUCTION) = ''              => -0.00022880313,
              ((real)c_construction < 2.95000004768) => 0.0046700414,
                                                        -0.00022880313));

N270_8 :=__common__( map(trim(C_HH00) = ''      => N270_9,
              ((real)c_hh00 < 464.5) => -0.0022159791,
                                        N270_9));

N270_7 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => 0.0052297536,
              ((real)r_l79_adls_per_addr_curr_i < 37.5)  => N270_8,
                                                            0.0052297536));

N270_6 :=__common__( if(((real)c_rentocc_p < 53.25), N270_7, -0.0036178455));

N270_5 :=__common__( if(trim(C_RENTOCC_P) != '', N270_6, 0.0019005374));

N270_4 :=__common__( if(((real)f_curraddrmurderindex_i < 198.5), N270_5, 0.0082864213));

N270_3 :=__common__( if(((real)f_curraddrmurderindex_i > NULL), N270_4, -0.0035528606));

N270_2 :=__common__( if(((real)r_l79_adls_per_addr_c6_i < 5.5), N270_3, 0.007632821));

N270_1 :=__common__( if(((real)r_l79_adls_per_addr_c6_i > NULL), N270_2, 0.019070813));

N271_11 :=__common__( if(((real)c_pop_25_34_p < 12.9499998093), -0.0050225509, 0.0023457855));

N271_10 :=__common__( if(trim(C_POP_25_34_P) != '', N271_11, -0.0084197402));

N271_9 :=__common__( if(((real)f_assocrisktype_i < 3.5), -0.0076939109, N271_10));

N271_8 :=__common__( if(((real)f_assocrisktype_i > NULL), N271_9, 0.023108549));

N271_7 :=__common__( if(((real)r_c20_email_count_i < 6.5), 0.0010938727, -0.0035929543));

N271_6 :=__common__( if(((real)r_c20_email_count_i > NULL), N271_7, 0.0010570836));

N271_5 :=__common__( map(trim(C_VERY_RICH) = ''      => 0.010683751,
              ((real)c_very_rich < 191.5) => N271_6,
                                             0.010683751));

N271_4 :=__common__( if(((real)c_inc_100k_p < 22.25), N271_5, 0.010086686));

N271_3 :=__common__( if(trim(C_INC_100K_P) != '', N271_4, -0.00043981772));

N271_2 :=__common__( if(((real)r_phn_pcs_n < 0.5), N271_3, N271_8));

N271_1 :=__common__( if(((real)r_phn_pcs_n > NULL), N271_2, -0.027919002));

N272_8 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.0022974791,
              ((real)f_add_curr_nhood_vac_pct_i < 0.0634416341782) => -0.0050777625,
                                                                      0.0022974791));

N272_7 :=__common__( map(trim(C_CARTHEFT) = ''      => N272_8,
              ((real)c_cartheft < 128.5) => 0.0046457523,
                                            N272_8));

N272_6 :=__common__( map(trim(C_RNT250_P) = ''              => 0.0080446451,
              ((real)c_rnt250_p < 29.1500015259) => N272_7,
                                                    0.0080446451));

N272_5 :=__common__( map(((real)r_l77_apartment_i <= NULL) => N272_6,
              ((real)r_l77_apartment_i < 0.5)   => -0.0013563392,
                                                   N272_6));

N272_4 :=__common__( if(((integer)r_d33_eviction_recency_d < 18), 0.0053927529, N272_5));

N272_3 :=__common__( if(((real)r_d33_eviction_recency_d > NULL), N272_4, -0.0098486412));

N272_2 :=__common__( if(((real)c_transport < 32.9500007629), N272_3, 0.0096372934));

N272_1 :=__common__( if(trim(C_TRANSPORT) != '', N272_2, -0.00028384884));

N273_10 :=__common__( if(((real)c_many_cars < 31.5), 0.009231413, 2.1519465e-005));

N273_9 :=__common__( if(trim(C_MANY_CARS) != '', N273_10, -0.0095449006));

N273_8 :=__common__( if(((real)f_add_input_nhood_vac_pct_i < 0.124331474304), -0.0017744769, N273_9));

N273_7 :=__common__( if(((real)f_add_input_nhood_vac_pct_i > NULL), N273_8, -0.035863243));

N273_6 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL) => -0.0064993894,
              ((real)f_liens_unrel_cj_total_amt_i < 27.5)  => N273_7,
                                                              -0.0064993894));

N273_5 :=__common__( if(((real)f_rel_educationover12_count_d < 5.5), 0.0064903964, 0.00047397117));

N273_4 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N273_5, -0.014042846));

N273_3 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL)  => N273_6,
              ((integer)r_d33_eviction_recency_d < 549) => N273_4,
                                                           N273_6));

N273_2 :=__common__( if(((real)f_srchphonesrchcountmo_i < 0.5), N273_3, 0.0064071746));

N273_1 :=__common__( if(((real)f_srchphonesrchcountmo_i > NULL), N273_2, 0.00064854244));

N274_8 :=__common__( map(((real)f_rel_criminal_count_i <= NULL) => 0.00039229528,
              ((real)f_rel_criminal_count_i < 5.5)   => 0.0075675446,
                                                        0.00039229528));

N274_7 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.01062908,
              ((real)f_rel_felony_count_i < 3.5)   => 0.0019856643,
                                                      0.01062908));

N274_6 :=__common__( map(trim(C_POPOVER25) = ''      => 0.00074489712,
              ((real)c_popover25 < 779.5) => -0.0071427074,
                                             0.00074489712));

N274_5 :=__common__( map(trim(C_RNT500_P) = ''     => N274_7,
              ((real)c_rnt500_p < 9.75) => N274_6,
                                           N274_7));

N274_4 :=__common__( if(((real)c_pop_75_84_p < 2.84999990463), N274_5, -0.0022997329));

N274_3 :=__common__( if(trim(C_POP_75_84_P) != '', N274_4, 0.0041930898));

N274_2 :=__common__( if(((real)r_d32_criminal_count_i < 4.5), N274_3, N274_8));

N274_1 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N274_2, -0.0045857823));

N275_8 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => -0.0013025587,
              ((real)f_mos_inq_banko_cm_lseen_d < 44.5)  => 0.0043506923,
                                                            -0.0013025587));

N275_7 :=__common__( map(((real)c_comb_age_d <= NULL) => 0.0020804834,
              ((real)c_comb_age_d < 30.5)  => 0.014432196,
                                              0.0020804834));

N275_6 :=__common__( map(trim(C_HIGHRENT) = ''              => N275_7,
              ((real)c_highrent < 9.35000038147) => -0.00064865904,
                                                    N275_7));

N275_5 :=__common__( map(trim(C_BORN_USA) = ''      => 0.0058519373,
              ((real)c_born_usa < 162.5) => N275_6,
                                            0.0058519373));

N275_4 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N275_5, N275_8));

N275_3 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => N275_4,
              ((real)r_a50_pb_average_dollars_d < 145.5) => -0.00088466631,
                                                            N275_4));

N275_2 :=__common__( if(((real)r_d31_mostrec_bk_i < 1.5), N275_3, -0.0039975157));

N275_1 :=__common__( if(((real)r_d31_mostrec_bk_i > NULL), N275_2, -0.0078548218));

N276_9 :=__common__( if(((real)c_pop_45_54_p < 20.0499992371), 0.0020225692, 0.01325312));

N276_8 :=__common__( if(trim(C_POP_45_54_P) != '', N276_9, 0.0042131324));

N276_7 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => 0.00046150383,
              ((real)r_c13_max_lres_d < 78.5)  => -0.0025720568,
                                                  0.00046150383));

N276_6 :=__common__( map(((real)r_s66_adlperssn_count_i <= NULL) => 0.011954396,
              ((real)r_s66_adlperssn_count_i < 1.5)   => 5.2799542e-005,
                                                         0.011954396));

N276_5 :=__common__( map(((real)f_rel_count_i <= NULL) => N276_7,
              ((real)f_rel_count_i < 3.5)   => N276_6,
                                               N276_7));

N276_4 :=__common__( if(((real)c_cpiall < 224.399993896), N276_5, -0.010601279));

N276_3 :=__common__( if(trim(C_CPIALL) != '', N276_4, -0.00026008982));

N276_2 :=__common__( map(((real)r_i61_inq_collection_count12_i <= NULL) => N276_8,
              ((real)r_i61_inq_collection_count12_i < 0.5)   => N276_3,
                                                                N276_8));

N276_1 :=__common__( if(((real)r_i61_inq_collection_recency_d > NULL), N276_2, 0.0070708624));

N277_8 :=__common__( map(trim(C_RNT250_P) = ''      => -0.0043374656,
              ((real)c_rnt250_p < 20.75) => 0.0044203401,
                                            -0.0043374656));

N277_7 :=__common__( if(((real)c_femdiv_p < 2.65000009537), 0.010670986, N277_8));

N277_6 :=__common__( if(trim(C_FEMDIV_P) != '', N277_7, 0.0013138516));

N277_5 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => -0.0017728332,
              ((real)f_prevaddrmedianincome_d < 44386.5) => N277_6,
                                                            -0.0017728332));

N277_4 :=__common__( map(((real)c_inf_contradictory_i <= NULL) => N277_5,
              ((real)c_inf_contradictory_i < 0.5)   => -0.0010028233,
                                                       N277_5));

N277_3 :=__common__( map(((real)f_inq_auto_count24_i <= NULL) => -0.0059327203,
              ((real)f_inq_auto_count24_i < 1.5)   => N277_4,
                                                      -0.0059327203));

N277_2 :=__common__( if(((real)f_inq_collection_count24_i < 2.5), N277_3, 0.0056559377));

N277_1 :=__common__( if(((real)f_inq_collection_count24_i > NULL), N277_2, 0.0029269646));

N278_8 :=__common__( map(trim(C_HVAL_60K_P) = ''              => 0.00048007453,
              ((real)c_hval_60k_p < 4.94999980927) => 0.0081544807,
                                                      0.00048007453));

N278_7 :=__common__( map(trim(C_LOWINC) = ''              => N278_8,
              ((real)c_lowinc < 62.0499992371) => -0.00028603201,
                                                  N278_8));

N278_6 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => N278_7,
              ((real)r_c13_max_lres_d < 19.5)  => -0.0046651079,
                                                  N278_7));

N278_5 :=__common__( map(trim(C_RENTAL) = ''      => -0.013182002,
              ((real)c_rental < 131.5) => 0.000545584,
                                          -0.013182002));

N278_4 :=__common__( if(((real)f_mos_liens_rel_cj_lseen_d < 67.5), N278_5, N278_6));

N278_3 :=__common__( if(((real)f_mos_liens_rel_cj_lseen_d > NULL), N278_4, -0.00024029221));

N278_2 :=__common__( if(((real)c_serv_empl < 194.5), N278_3, 0.0072547797));

N278_1 :=__common__( if(trim(C_SERV_EMPL) != '', N278_2, -0.0035309477));

N279_9 :=__common__( map(trim(C_HH4_P) = ''              => -0.0045612793,
              ((real)c_hh4_p < 9.05000019073) => 0.0065956983,
                                                 -0.0045612793));

N279_8 :=__common__( if(((real)c_inc_150k_p < 1.54999995232), -0.0085282111, N279_9));

N279_7 :=__common__( if(trim(C_INC_150K_P) != '', N279_8, -0.013332252));

N279_6 :=__common__( if(((real)c_femdiv_p < 10.6499996185), 0.00059502301, -0.0045458484));

N279_5 :=__common__( if(trim(C_FEMDIV_P) != '', N279_6, 0.0032813145));

N279_4 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N279_7,
              ((integer)c_hist_addr_match_i < 67) => N279_5,
                                                     N279_7));

N279_3 :=__common__( map(((real)f_corrssnnamecount_d <= NULL) => -0.0017788032,
              ((real)f_corrssnnamecount_d < 5.5)   => 0.0083455091,
                                                      -0.0017788032));

N279_2 :=__common__( if(((real)f_corrssnaddrcount_d < 0.5), N279_3, N279_4));

N279_1 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N279_2, -0.0021661291));

N280_8 :=__common__( map(((real)c_nap_phn_verd_d <= NULL) => 0.00270551,
              ((real)c_nap_phn_verd_d < 0.5)   => -0.0066357056,
                                                  0.00270551));

N280_7 :=__common__( map(trim(C_TOTSALES) = ''        => -0.013583785,
              ((real)c_totsales < 18511.5) => -0.0022364969,
                                              -0.013583785));

N280_6 :=__common__( map(trim(C_NO_CAR) = ''     => 0.00033790821,
              ((real)c_no_car < 55.5) => N280_7,
                                         0.00033790821));

N280_5 :=__common__( map(trim(C_LOWINC) = ''              => N280_6,
              ((real)c_lowinc < 20.1500015259) => 0.0045563259,
                                                  N280_6));

N280_4 :=__common__( map(((real)c_inf_fname_verd_d <= NULL) => N280_8,
              ((real)c_inf_fname_verd_d < 0.5)   => N280_5,
                                                    N280_8));

N280_3 :=__common__( if(trim(C_HVAL_80K_P) != '', N280_4, -0.00094022929));

N280_2 :=__common__( if(((real)r_d31_bk_filing_count_i < 2.5), N280_3, 0.011781548));

N280_1 :=__common__( if(((real)r_d31_bk_filing_count_i > NULL), N280_2, 0.0060431727));

N281_9 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), 0.0040119016, -0.00012242532));

N281_8 :=__common__( map(((real)r_i60_inq_retail_recency_d <= NULL) => N281_9,
              ((real)r_i60_inq_retail_recency_d < 61.5)  => -0.0058512635,
                                                            N281_9));

N281_7 :=__common__( map(((real)r_c18_invalid_addrs_per_adl_i <= NULL) => -0.004246233,
              ((real)r_c18_invalid_addrs_per_adl_i < 4.5)   => N281_8,
                                                               -0.004246233));

N281_6 :=__common__( if(((real)f_rel_homeover150_count_d < 4.5), 0.011775604, 0.0013985415));

N281_5 :=__common__( if(((real)f_rel_homeover150_count_d > NULL), N281_6, 0.016270777));

N281_4 :=__common__( if(((real)c_assault < 166.5), N281_5, -0.005702638));

N281_3 :=__common__( if(trim(C_ASSAULT) != '', N281_4, -0.00088270235));

N281_2 :=__common__( if(((real)c_mos_since_impulse_fs_d < 45.5), N281_3, N281_7));

N281_1 :=__common__( if(((real)c_mos_since_impulse_fs_d > NULL), N281_2, 0.0063493843));

N282_8 :=__common__( map(trim(C_HEALTH) = ''              => -0.0010032129,
              ((real)c_health < 8.64999961853) => 0.0068958097,
                                                  -0.0010032129));

N282_7 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => 0.0040866386,
              ((real)f_m_bureau_adl_fs_all_d < 165.5) => -0.0039880233,
                                                         0.0040866386));

N282_6 :=__common__( map(trim(C_POP_75_84_P) = ''     => N282_7,
              ((real)c_pop_75_84_p < 1.25) => -0.0093158189,
                                              N282_7));

N282_5 :=__common__( if(((real)c_hval_200k_p < 3.15000009537), N282_6, N282_8));

N282_4 :=__common__( if(trim(C_HVAL_200K_P) != '', N282_5, 0.017937017));

N282_3 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => 0.0056995665,
              ((real)f_mos_inq_banko_om_lseen_d < 19.5)  => N282_4,
                                                            0.0056995665));

N282_2 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 32.5), N282_3, -0.00079476632));

N282_1 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N282_2, 0.0094824908));

N283_10 :=__common__( map(trim(C_OLD_HOMES) = ''      => -0.0033832589,
               ((real)c_old_homes < 174.5) => 0.0026414514,
                                              -0.0033832589));

N283_9 :=__common__( if(((real)c_young < 39.75), N283_10, -0.0056504559));

N283_8 :=__common__( if(trim(C_YOUNG) != '', N283_9, 0.0028321994));

N283_7 :=__common__( map(((real)r_a46_curr_avm_autoval_d <= NULL)   => 5.4655139e-005,
              ((real)r_a46_curr_avm_autoval_d < 20277.5) => 0.0065101582,
                                                            5.4655139e-005));

N283_6 :=__common__( if(((real)c_pop_0_5_p < 12.3500003815), N283_7, -0.0048472071));

N283_5 :=__common__( if(trim(C_POP_0_5_P) != '', N283_6, 0.028857186));

N283_4 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N283_5, N283_8));

N283_3 :=__common__( map(((real)r_d31_mostrec_bk_i <= NULL) => -0.0038731944,
              ((real)r_d31_mostrec_bk_i < 1.5)   => N283_4,
                                                    -0.0038731944));

N283_2 :=__common__( if(((real)r_e55_college_ind_d < 0.5), N283_3, -0.0062716818));

N283_1 :=__common__( if(((real)r_e55_college_ind_d > NULL), N283_2, 0.0023606758));

N284_8 :=__common__( map(trim(C_HH3_P) = ''      => 0.0036571395,
              ((real)c_hh3_p < 14.25) => -0.008635308,
                                         0.0036571395));

N284_7 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO']) => N284_8,
              (segment in ['SEARS FLS', 'SEARS SHO'])        => 0.0094217208,
                                                                N284_8));

N284_6 :=__common__( if(trim(C_POP_35_44_P) != '', N284_7, 0.0065844452));

N284_5 :=__common__( map(((real)f_corrrisktype_i <= NULL) => N284_6,
              ((real)f_corrrisktype_i < 8.5)   => -0.0059257797,
                                                  N284_6));

N284_4 :=__common__( map(((real)c_addr_lres_12mo_ct_i <= NULL) => 0.0063684839,
              ((real)c_addr_lres_12mo_ct_i < 14.5)  => 5.9200081e-005,
                                                       0.0063684839));

N284_3 :=__common__( map(((real)r_l72_add_vacant_i <= NULL) => 0.0099279765,
              ((real)r_l72_add_vacant_i < 0.5)   => N284_4,
                                                    0.0099279765));

N284_2 :=__common__( if(((real)c_hist_addr_match_i < 40.5), N284_3, N284_5));

N284_1 :=__common__( if(((real)c_hist_addr_match_i > NULL), N284_2, -0.0035201372));

N285_8 :=__common__( map(trim(C_LOWINC) = ''              => -0.012069601,
              ((real)c_lowinc < 54.0499992371) => 6.221684e-005,
                                                  -0.012069601));

N285_7 :=__common__( map(trim(C_EASIQLIFE) = ''     => 0.0057020459,
              ((real)c_easiqlife < 64.5) => -0.0028073627,
                                            0.0057020459));

N285_6 :=__common__( map(trim(C_SFDU_P) = ''      => N285_7,
              ((real)c_sfdu_p < 26.75) => -0.0056474031,
                                          N285_7));

N285_5 :=__common__( map(trim(C_FOOD) = ''      => N285_6,
              ((real)c_food < 38.75) => -3.1909136e-005,
                                        N285_6));

N285_4 :=__common__( if(((real)c_hval_100k_p < 38.4500007629), N285_5, N285_8));

N285_3 :=__common__( if(trim(C_HVAL_100K_P) != '', N285_4, 0.00076821076));

N285_2 :=__common__( if(((real)f_mos_liens_rel_ot_fseen_d < 59.5), N285_3, -0.0087096735));

N285_1 :=__common__( if(((real)f_mos_liens_rel_ot_fseen_d > NULL), N285_2, -0.0046846703));

N286_8 :=__common__( map(trim(C_RENTOCC_P) = ''              => -0.0048263726,
              ((real)c_rentocc_p < 58.5499992371) => 0.0038779355,
                                                     -0.0048263726));

N286_7 :=__common__( map(trim(C_BURGLARY) = ''      => -0.012771684,
              ((real)c_burglary < 153.5) => -0.0026391432,
                                            -0.012771684));

N286_6 :=__common__( if(((real)f_rel_incomeover50_count_d < 8.5), -4.2602817e-005, N286_7));

N286_5 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N286_6, -0.00043438018));

N286_4 :=__common__( map(((real)r_s66_adlperssn_count_i <= NULL) => N286_8,
              ((real)r_s66_adlperssn_count_i < 2.5)   => N286_5,
                                                         N286_8));

N286_3 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => 0.0044397464,
              ((real)r_l79_adls_per_addr_curr_i < 37.5)  => N286_4,
                                                            0.0044397464));

N286_2 :=__common__( if(((real)c_bel_edu < 193.5), N286_3, -0.0066894845));

N286_1 :=__common__( if(trim(C_BEL_EDU) != '', N286_2, -0.0013307566));

N287_8 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.010984784,
              ((real)f_inq_other_count24_i < 2.5)   => 0.0027056174,
                                                       0.010984784));

N287_7 :=__common__( map(((real)r_d31_mostrec_bk_i <= NULL) => -0.0064588115,
              ((real)r_d31_mostrec_bk_i < 1.5)   => 0.0012374744,
                                                    -0.0064588115));

N287_6 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => N287_8,
              ((real)r_c14_addrs_10yr_i < 8.5)   => N287_7,
                                                    N287_8));

N287_5 :=__common__( map(trim(C_EASIQLIFE) = ''      => -0.0095265006,
              ((real)c_easiqlife < 122.5) => -0.0010226522,
                                             -0.0095265006));

N287_4 :=__common__( if(((real)c_hval_250k_p < 0.15000000596), N287_5, 0.00036883425));

N287_3 :=__common__( if(trim(C_HVAL_250K_P) != '', N287_4, -0.0019239075));

N287_2 :=__common__( if(((real)r_c13_max_lres_d < 77.5), N287_3, N287_6));

N287_1 :=__common__( if(((real)r_c13_max_lres_d > NULL), N287_2, -0.0071682977));

N288_9 :=__common__( if(((real)f_curraddrcartheftindex_i < 53.5), -0.0036193798, 0.0010046793));

N288_8 :=__common__( if(((real)f_curraddrcartheftindex_i > NULL), N288_9, -0.0083249295));

N288_7 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => 0.0057886397,
              ((real)r_l79_adls_per_addr_curr_i < 14.5)  => -0.0017179565,
                                                            0.0057886397));

N288_6 :=__common__( map(trim(C_POP_0_5_P) = ''              => -0.0064279573,
              ((real)c_pop_0_5_p < 12.3500003815) => N288_7,
                                                     -0.0064279573));

N288_5 :=__common__( map(((real)f_inq_highriskcredit_count24_i <= NULL) => -0.011128211,
              ((real)f_inq_highriskcredit_count24_i < 6.5)   => N288_6,
                                                                -0.011128211));

N288_4 :=__common__( if(((real)c_rich_blk < 166.5), N288_5, 0.005890132));

N288_3 :=__common__( if(trim(C_RICH_BLK) != '', N288_4, 0.016542302));

N288_2 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.0086661706,
              ((real)f_corrssnaddrcount_d < 5.5)   => N288_3,
                                                      -0.0086661706));

N288_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N288_2, N288_8));

N289_9 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.013063936,
              ((real)c_sub_bus < 133.5) => 0.0025195434,
                                           0.013063936));

N289_8 :=__common__( if(((real)c_easiqlife < 116.5), -0.0015090108, N289_9));

N289_7 :=__common__( if(trim(C_EASIQLIFE) != '', N289_8, -0.0061134067));

N289_6 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -9.5620147e-005,
              (segment in ['SEARS FLS'])                                  => N289_7,
                                                                             -9.5620147e-005));

N289_5 :=__common__( if(((real)c_rnt750_p < 34.75), -0.00034953514, -0.012137688));

N289_4 :=__common__( if(trim(C_RNT750_P) != '', N289_5, -0.013349579));

N289_3 :=__common__( map(((real)r_i60_inq_retail_recency_d <= NULL) => N289_6,
              ((real)r_i60_inq_retail_recency_d < 61.5)  => N289_4,
                                                            N289_6));

N289_2 :=__common__( if(((real)f_corrssnnamecount_d < 7.5), N289_3, -0.0033665611));

N289_1 :=__common__( if(((real)f_corrssnnamecount_d > NULL), N289_2, -0.0015748541));

N290_9 :=__common__( map(trim(C_WHITE_COL) = ''              => 8.583232e-005,
              ((real)c_white_col < 28.4500007629) => -0.005340045,
                                                     8.583232e-005));

N290_8 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)    => N290_9,
              ((integer)f_curraddrmedianvalue_d < 67755) => 0.0033901222,
                                                            N290_9));

N290_7 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.0063842729,
              ((real)f_sourcerisktype_i < 6.5)   => 0.0015586478,
                                                    0.0063842729));

N290_6 :=__common__( if(((real)f_rel_homeover50_count_d > NULL), N290_7, 0.0049652448));

N290_5 :=__common__( map(((real)r_s66_adlperssn_count_i <= NULL) => N290_6,
              ((real)r_s66_adlperssn_count_i < 1.5)   => -0.00059376915,
                                                         N290_6));

N290_4 :=__common__( if(((real)f_current_count_d < 1.5), N290_5, N290_8));

N290_3 :=__common__( if(((real)f_current_count_d > NULL), N290_4, 0.0059208847));

N290_2 :=__common__( if(((real)c_cpiall < 224.399993896), N290_3, -0.0074150357));

N290_1 :=__common__( if(trim(C_CPIALL) != '', N290_2, -0.00049294709));

N291_9 :=__common__( map((segment in ['RETAIL'])                                        => -0.020788088,
              (segment in ['KMART', 'SEARS AUTO', 'SEARS FLS', 'SEARS SHO']) => 0.013010222,
                                                                                0.013010222));

N291_8 :=__common__( if(((real)c_unempl < 143.5), N291_9, -0.0023679375));

N291_7 :=__common__( if(trim(C_UNEMPL) != '', N291_8, 0.015803128));

N291_6 :=__common__( map(((real)f_divaddrsuspidcountnew_i <= NULL) => 0.0012238571,
              ((real)f_divaddrsuspidcountnew_i < 0.5)   => -0.0037684182,
                                                           0.0012238571));

N291_5 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => N291_6,
              ((real)r_l79_adls_per_addr_curr_i < 1.5)   => 0.0013494922,
                                                            N291_6));

N291_4 :=__common__( map(((real)c_dist_input_to_prev_addr_i <= NULL)  => -0.0056348157,
              ((integer)c_dist_input_to_prev_addr_i < 915) => N291_5,
                                                              -0.0056348157));

N291_3 :=__common__( if(((real)r_l79_adls_per_addr_curr_i > NULL), N291_4, 0.0049806281));

N291_2 :=__common__( if(((real)f_inq_collection_count24_i < 2.5), N291_3, N291_7));

N291_1 :=__common__( if(((real)f_inq_collection_count24_i > NULL), N291_2, -0.00047874976));

N292_8 :=__common__( map(trim(C_RETAIL) = ''              => 0.0083973074,
              ((real)c_retail < 48.8499984741) => -0.00059865368,
                                                  0.0083973074));

N292_7 :=__common__( map(trim(C_HVAL_200K_P) = ''     => 0.011646169,
              ((real)c_hval_200k_p < 8.25) => 0.0014743442,
                                              0.011646169));

N292_6 :=__common__( map(((real)r_i60_inq_comm_recency_d <= NULL) => N292_8,
              ((real)r_i60_inq_comm_recency_d < 4.5)   => N292_7,
                                                          N292_8));

N292_5 :=__common__( if(((real)r_i60_inq_auto_count12_i < 1.5), N292_6, -0.007208801));

N292_4 :=__common__( if(((real)r_i60_inq_auto_count12_i > NULL), N292_5, 0.0061424142));

N292_3 :=__common__( map(((real)r_l72_add_vacant_i <= NULL) => 0.0073147572,
              ((real)r_l72_add_vacant_i < 0.5)   => N292_4,
                                                    0.0073147572));

N292_2 :=__common__( if(((real)c_low_ed < 82.0500030518), N292_3, -0.0064165685));

N292_1 :=__common__( if(trim(C_LOW_ED) != '', N292_2, -0.0015474387));

N293_9 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.0025081952,
              ((real)f_rel_felony_count_i < 0.5)   => -0.0015426704,
                                                      0.0025081952));

N293_8 :=__common__( if(((real)f_curraddrmedianvalue_d < 42628.5), 0.007506667, N293_9));

N293_7 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N293_8, -0.00061952316));

N293_6 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 5.5), 0.0084492758, -0.0010650976));

N293_5 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N293_6, -0.0054637704));

N293_4 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => 0.0018443799,
              ((real)f_add_input_nhood_vac_pct_i < 0.203056320548) => -0.010945949,
                                                                      0.0018443799));

N293_3 :=__common__( map(trim(C_FAMMAR_P) = ''              => N293_5,
              ((real)c_fammar_p < 28.1500015259) => N293_4,
                                                    N293_5));

N293_2 :=__common__( if(((real)c_apt20 < 94.5), N293_3, N293_7));

N293_1 :=__common__( if(trim(C_APT20) != '', N293_2, 0.0033447769));

N294_9 :=__common__( if(((integer)f_prevaddrmedianvalue_d < 186719), -0.0060301069, 0.0096206025));

N294_8 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N294_9, -0.0045538805));

N294_7 :=__common__( map(trim(C_FAMMAR_P) = ''      => N294_8,
              ((real)c_fammar_p < 55.25) => -0.0093207458,
                                            N294_8));

N294_6 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => -0.008680095,
              ((real)c_hist_addr_match_i < 11.5)  => -0.00093941032,
                                                     -0.008680095));

N294_5 :=__common__( if(((real)f_rel_ageover40_count_d < 1.5), 0.0035040052, N294_6));

N294_4 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N294_5, 0.0083949982));

N294_3 :=__common__( map(trim(C_SPAN_LANG) = ''      => N294_7,
              ((real)c_span_lang < 130.5) => N294_4,
                                             N294_7));

N294_2 :=__common__( if(((real)c_femdiv_p < 5.85000038147), 0.0010783161, N294_3));

N294_1 :=__common__( if(trim(C_FEMDIV_P) != '', N294_2, 0.00069925146));

N295_9 :=__common__( map(trim(C_NEWHOUSE) = ''              => 0.0088548463,
              ((real)c_newhouse < 7.05000019073) => 0.00035665711,
                                                    0.0088548463));

N295_8 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => N295_9,
              ((real)f_mos_inq_banko_om_fseen_d < 35.5)  => -0.0017514723,
                                                            N295_9));

N295_7 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL) => -0.0037418821,
              ((real)r_a50_pb_total_dollars_d < 120.5) => 0.0047392749,
                                                          -0.0037418821));

N295_6 :=__common__( if(((real)r_pb_order_freq_d > NULL), N295_7, N295_8));

N295_5 :=__common__( map(trim(C_CHILD) = ''              => -0.001660754,
              ((real)c_child < 19.3499984741) => 0.0039884346,
                                                 -0.001660754));

N295_4 :=__common__( if(((real)f_divrisktype_i < 1.5), N295_5, N295_6));

N295_3 :=__common__( if(((real)f_divrisktype_i > NULL), N295_4, -0.0093437328));

N295_2 :=__common__( if(((real)c_employees < 3.5), 0.0052358999, N295_3));

N295_1 :=__common__( if(trim(C_EMPLOYEES) != '', N295_2, -0.00073170557));

N296_8 :=__common__( if(((real)c_cartheft < 131.5), 0.0014539259, -0.009393874));

N296_7 :=__common__( if(trim(C_CARTHEFT) != '', N296_8, -0.035812158));

N296_6 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => 0.0001106471,
              ((real)r_d30_derog_count_i < 2.5)   => -0.012822444,
                                                     0.0001106471));

N296_5 :=__common__( map(((real)r_c15_ssns_per_adl_i <= NULL) => 0.0061592463,
              ((real)r_c15_ssns_per_adl_i < 3.5)   => -0.0050948562,
                                                      0.0061592463));

N296_4 :=__common__( map(((real)r_c18_invalid_addrs_per_adl_i <= NULL) => N296_5,
              ((real)r_c18_invalid_addrs_per_adl_i < 4.5)   => 0.0013527633,
                                                               N296_5));

N296_3 :=__common__( map(((real)r_e55_college_ind_d <= NULL) => N296_6,
              ((real)r_e55_college_ind_d < 0.5)   => N296_4,
                                                     N296_6));

N296_2 :=__common__( if(((real)f_inq_highriskcredit_count24_i < 11.5), N296_3, N296_7));

N296_1 :=__common__( if(((real)f_inq_highriskcredit_count24_i > NULL), N296_2, 0.00076006779));

N297_9 :=__common__( if(((real)c_rape < 195.5), -0.0016893786, 0.0085330818));

N297_8 :=__common__( if(trim(C_RAPE) != '', N297_9, 0.0079144296));

N297_7 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => 0.0047179473,
              ((real)r_c10_m_hdr_fs_d < 150.5) => -0.0020516566,
                                                  0.0047179473));

N297_6 :=__common__( if(((integer)c_rich_blk < 122), N297_7, 0.0085966871));

N297_5 :=__common__( if(trim(C_RICH_BLK) != '', N297_6, -0.0026876423));

N297_4 :=__common__( map(((real)c_addr_lres_2mo_ct_i <= NULL) => N297_8,
              ((real)c_addr_lres_2mo_ct_i < 0.5)   => N297_5,
                                                      N297_8));

N297_3 :=__common__( map(((real)f_varmsrcssncount_i <= NULL) => 0.003321695,
              ((real)f_varmsrcssncount_i < 1.5)   => N297_4,
                                                     0.003321695));

N297_2 :=__common__( if(((real)f_corrssnnamecount_d < 8.5), N297_3, -0.0043782282));

N297_1 :=__common__( if(((real)f_corrssnnamecount_d > NULL), N297_2, 0.00071486825));

N298_11 :=__common__( map(trim(C_HVAL_1001K_P) = ''              => -0.0061533977,
               ((real)c_hval_1001k_p < 0.15000000596) => 0.00071472273,
                                                         -0.0061533977));

N298_10 :=__common__( if(((real)c_unique_addr_count_i < 17.5), N298_11, 0.0053780051));

N298_9 :=__common__( if(((real)c_unique_addr_count_i > NULL), N298_10, -0.012072214));

N298_8 :=__common__( if(((real)c_popover25 < 361.5), -0.0091837889, N298_9));

N298_7 :=__common__( if(trim(C_POPOVER25) != '', N298_8, -0.0032734425));

N298_6 :=__common__( map(trim(C_HIGH_ED) = ''              => 0.013104931,
              ((real)c_high_ed < 12.9499998093) => 0.0020133787,
                                                   0.013104931));

N298_5 :=__common__( if(((real)c_construction < 2.95000004768), N298_6, -0.0010248411));

N298_4 :=__common__( if(trim(C_CONSTRUCTION) != '', N298_5, -0.0097885765));

N298_3 :=__common__( if(((real)c_addr_lres_2mo_ct_i < 0.5), N298_4, -0.0019954946));

N298_2 :=__common__( if(((real)c_addr_lres_2mo_ct_i > NULL), N298_3, -0.0068640911));

N298_1 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N298_2, N298_7));

N299_9 :=__common__( map(trim(C_HVAL_175K_P) = ''      => 0.00090018457,
              ((real)c_hval_175k_p < 29.75) => 0.01414587,
                                               0.00090018457));

N299_8 :=__common__( map(((real)f_addrchangevaluediff_d <= NULL)     => 0.0013474391,
              ((real)f_addrchangevaluediff_d < -113177.5) => -0.0052079642,
                                                             0.0013474391));

N299_7 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => -0.0089324804,
              ((real)r_c12_num_nonderogs_d < 10.5)  => N299_8,
                                                       -0.0089324804));

N299_6 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N299_7, -0.0015558511));

N299_5 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d < 3.5), 0.0073758724, N299_6));

N299_4 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N299_5, 0.0019549604));

N299_3 :=__common__( map(trim(C_MINING) = ''     => -0.012404162,
              ((real)c_mining < 1.25) => N299_4,
                                         -0.012404162));

N299_2 :=__common__( if(((real)c_hval_175k_p < 25.4500007629), N299_3, N299_9));

N299_1 :=__common__( if(trim(C_HVAL_175K_P) != '', N299_2, -0.0060265984));

N300_9 :=__common__( map(trim(C_HIGH_HVAL) = ''               => -0.0056992989,
              ((real)c_high_hval < 0.449999988079) => -0.00099404077,
                                                      -0.0056992989));

N300_8 :=__common__( if(((real)f_srchphonesrchcountmo_i < 0.5), N300_9, 0.0088737167));

N300_7 :=__common__( if(((real)f_srchphonesrchcountmo_i > NULL), N300_8, -0.0064145316));

N300_6 :=__common__( map(trim(C_INC_201K_P) = ''                => 0.012296828,
              ((real)c_inc_201k_p < 0.0500000007451) => 0.00052576058,
                                                        0.012296828));

N300_5 :=__common__( if(((real)f_curraddrmedianvalue_d < 36670.5), N300_6, 0.0002670459));

N300_4 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N300_5, 0.0067569733));

N300_3 :=__common__( map(trim(C_HVAL_750K_P) = ''              => 0.010346031,
              ((real)c_hval_750k_p < 20.6500015259) => N300_4,
                                                       0.010346031));

N300_2 :=__common__( if(((real)c_construction < 6.85000038147), N300_3, N300_7));

N300_1 :=__common__( if(trim(C_CONSTRUCTION) != '', N300_2, 4.4714179e-005));

N301_8 :=__common__( map(trim(C_UNEMPL) = ''      => -0.0076385304,
              ((real)c_unempl < 147.5) => 0.0041487612,
                                          -0.0076385304));

N301_7 :=__common__( if(((real)c_pop_65_74_p < 4.44999980927), N301_8, -0.0080529565));

N301_6 :=__common__( if(trim(C_POP_65_74_P) != '', N301_7, -0.013629751));

N301_5 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL) => N301_6,
              ((real)r_a50_pb_total_dollars_d < 132.5) => 0.0022650768,
                                                          N301_6));

N301_4 :=__common__( map(((real)f_rel_count_i <= NULL) => 0.0065154323,
              ((real)f_rel_count_i < 30.5)  => 1.3689965e-005,
                                               0.0065154323));

N301_3 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => 0.010448985,
              ((real)f_rel_felony_count_i < 4.5)   => N301_4,
                                                      0.010448985));

N301_2 :=__common__( if(((real)f_rel_criminal_count_i < 9.5), N301_3, N301_5));

N301_1 :=__common__( if(((real)f_rel_criminal_count_i > NULL), N301_2, -0.0024141907));

N302_10 :=__common__( map(((real)f_rel_under25miles_cnt_d <= NULL) => 0.010426077,
               ((real)f_rel_under25miles_cnt_d < 9.5)   => -0.00089520465,
                                                           0.010426077));

N302_9 :=__common__( map(((real)r_s66_adlperssn_count_i <= NULL) => 0.0015055671,
              ((real)r_s66_adlperssn_count_i < 1.5)   => -0.0024264647,
                                                         0.0015055671));

N302_8 :=__common__( map(((real)f_corrphonelastnamecount_d <= NULL) => -0.012615602,
              ((real)f_corrphonelastnamecount_d < 1.5)   => N302_9,
                                                            -0.012615602));

N302_7 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0292400754988), -0.001927118, 0.0078656946));

N302_6 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N302_7, 0.0028224188));

N302_5 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), N302_6, N302_8));

N302_4 :=__common__( if(((real)r_pb_order_freq_d > NULL), -0.00056400505, N302_5));

N302_3 :=__common__( if(((real)c_hh1_p < 50.6500015259), N302_4, N302_10));

N302_2 :=__common__( if(trim(C_HH1_P) != '', N302_3, -0.0014812864));

N302_1 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N302_2, 0.0029124613));

N303_8 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.0084583625,
              ((real)f_add_curr_nhood_vac_pct_i < 0.0269801951945) => -0.0049684506,
                                                                      0.0084583625));

N303_7 :=__common__( map(trim(C_OLDHOUSE) = ''              => -0.0056768067,
              ((real)c_oldhouse < 109.149993896) => N303_8,
                                                    -0.0056768067));

N303_6 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => 0.0013249411,
              ((real)f_mos_inq_banko_cm_fseen_d < 38.5)  => N303_7,
                                                            0.0013249411));

N303_5 :=__common__( map(((real)r_c18_invalid_addrs_per_adl_i <= NULL) => -0.0035365201,
              ((real)r_c18_invalid_addrs_per_adl_i < 4.5)   => N303_6,
                                                               -0.0035365201));

N303_4 :=__common__( if(((real)c_fammar18_p < 2.45000004768), -0.0058204019, N303_5));

N303_3 :=__common__( if(trim(C_FAMMAR18_P) != '', N303_4, -4.2452847e-006));

N303_2 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d < 8.5), 0.010009534, N303_3));

N303_1 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d > NULL), N303_2, 0.00029951189));

N304_9 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)          => 0.00081681991,
              ((real)f_add_input_nhood_sfd_pct_d < 0.786317169666) => 0.010250747,
                                                                      0.00081681991));

N304_8 :=__common__( map(((real)r_phn_cell_n <= NULL) => 0.0093154098,
              ((real)r_phn_cell_n < 0.5)   => 0.00013514153,
                                              0.0093154098));

N304_7 :=__common__( if(trim(C_PROFESSIONAL) != '', N304_8, 0.0019887077));

N304_6 :=__common__( map(((real)r_i60_inq_banking_recency_d <= NULL) => -0.00012231369,
              ((integer)r_i60_inq_banking_recency_d < 9)  => -0.0059253883,
                                                             -0.00012231369));

N304_5 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => N304_6,
              ((real)f_mos_inq_banko_cm_fseen_d < 19.5)  => -0.0069916144,
                                                            N304_6));

N304_4 :=__common__( if(((real)f_inq_adls_per_phone_i < 1.5), N304_5, N304_7));

N304_3 :=__common__( if(((real)f_inq_adls_per_phone_i > NULL), N304_4, -0.027729249));

N304_2 :=__common__( if(((real)f_inq_collection_count24_i < 2.5), N304_3, N304_9));

N304_1 :=__common__( if(((real)f_inq_collection_count24_i > NULL), N304_2, -0.0056920778));

N305_8 :=__common__( map(trim(C_UNEMP) = ''              => 0.00096924156,
              ((real)c_unemp < 4.85000038147) => -0.0061834306,
                                                 0.00096924156));

N305_7 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => 0.0032911949,
              ((real)f_m_bureau_adl_fs_all_d < 135.5) => N305_8,
                                                         0.0032911949));

N305_6 :=__common__( map(trim(C_NEW_HOMES) = ''      => -0.0017791826,
              ((real)c_new_homes < 135.5) => N305_7,
                                             -0.0017791826));

N305_5 :=__common__( map(((real)r_i60_inq_count12_i <= NULL) => 0.00032756393,
              ((real)r_i60_inq_count12_i < 2.5)   => 0.012443162,
                                                     0.00032756393));

N305_4 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), N305_5, N305_6));

N305_3 :=__common__( if(((real)f_corraddrphonecount_d < 0.5), N305_4, -0.0020542094));

N305_2 :=__common__( if(((real)f_corraddrphonecount_d > NULL), N305_3, 0.0021200289));

N305_1 :=__common__( if(trim(C_RETIRED2) != '', N305_2, 0.0023927048));

N306_10 :=__common__( map(trim(C_HHSIZE) = ''              => 0.0070156558,
               ((real)c_hhsize < 2.55499982834) => -0.00047866665,
                                                   0.0070156558));

N306_9 :=__common__( if(((real)c_pop_55_64_p < 6.75), N306_10, 0.00081747594));

N306_8 :=__common__( if(trim(C_POP_55_64_P) != '', N306_9, 0.0049607085));

N306_7 :=__common__( map(((real)f_adl_util_inf_n <= NULL) => -0.0026118786,
              ((real)f_adl_util_inf_n < 0.5)   => N306_8,
                                                  -0.0026118786));

N306_6 :=__common__( if(((real)r_phn_pcs_n < 0.5), -0.0011544569, -0.0067474641));

N306_5 :=__common__( if(((real)r_phn_pcs_n > NULL), N306_6, -0.027747456));

N306_4 :=__common__( if(((real)c_lowinc < 74.1499938965), N306_5, 0.0067438387));

N306_3 :=__common__( if(trim(C_LOWINC) != '', N306_4, -0.003786195));

N306_2 :=__common__( if(((real)f_assocrisktype_i < 3.5), N306_3, N306_7));

N306_1 :=__common__( if(((real)f_assocrisktype_i > NULL), N306_2, -0.0042639087));

N307_8 :=__common__( map(trim(C_UNATTACH) = ''      => -0.012126643,
              ((real)c_unattach < 151.5) => -0.002578682,
                                            -0.012126643));

N307_7 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => -0.0025518695,
              ((real)f_mos_inq_banko_cm_fseen_d < 70.5)  => 0.0056170389,
                                                            -0.0025518695));

N307_6 :=__common__( map(trim(C_HH2_P) = ''              => N307_7,
              ((real)c_hh2_p < 17.3499984741) => 0.012807804,
                                                 N307_7));

N307_5 :=__common__( if(((real)r_i60_inq_hiriskcred_count12_i < 0.5), N307_6, -0.0037384582));

N307_4 :=__common__( if(((real)r_i60_inq_hiriskcred_count12_i > NULL), N307_5, 0.0047084987));

N307_3 :=__common__( map(trim(C_SPAN_LANG) = ''     => N307_8,
              ((real)c_span_lang < 82.5) => N307_4,
                                            N307_8));

N307_2 :=__common__( if(((real)c_assault < 138.5), 0.0013146, N307_3));

N307_1 :=__common__( if(trim(C_ASSAULT) != '', N307_2, 0.0065340522));

N308_8 :=__common__( map(trim(C_HVAL_400K_P) = ''     => 0.004987027,
              ((real)c_hval_400k_p < 0.25) => 0.019623084,
                                              0.004987027));

N308_7 :=__common__( map(trim(C_EXP_PROD) = ''     => N308_8,
              ((real)c_exp_prod < 76.5) => -0.00020970061,
                                           N308_8));

N308_6 :=__common__( map(trim(C_HVAL_150K_P) = ''              => 0.0070331398,
              ((real)c_hval_150k_p < 25.5499992371) => -0.0016381312,
                                                       0.0070331398));

N308_5 :=__common__( map(trim(C_RAPE) = ''       => N308_7,
              ((integer)c_rape < 140) => N308_6,
                                         N308_7));

N308_4 :=__common__( if(((real)c_old_homes < 83.5), N308_5, -0.0026248042));

N308_3 :=__common__( if(trim(C_OLD_HOMES) != '', N308_4, 0.00030680533));

N308_2 :=__common__( if(((real)f_rel_incomeover50_count_d < 1.5), 0.0018262031, N308_3));

N308_1 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N308_2, 0.0032589929));

N309_10 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => 0.0081964807,
               ((real)f_add_input_nhood_vac_pct_i < 0.0780145525932) => 0.00043806632,
                                                                        0.0081964807));

N309_9 :=__common__( if(((real)f_rel_under25miles_cnt_d < 22.5), -0.00095972014, 0.0086963438));

N309_8 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N309_9, 0.0043988315));

N309_7 :=__common__( map(trim(C_BEL_EDU) = ''      => -0.0048907234,
              ((real)c_bel_edu < 154.5) => N309_8,
                                           -0.0048907234));

N309_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.269672334194), N309_7, 0.0016927216));

N309_5 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N309_6, -0.00031255373));

N309_4 :=__common__( if(((real)f_srchaddrsrchcount_i < 22.5), N309_5, N309_10));

N309_3 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N309_4, 0.0024374541));

N309_2 :=__common__( if(((real)c_fammar18_p < 2.45000004768), -0.0051752214, N309_3));

N309_1 :=__common__( if(trim(C_FAMMAR18_P) != '', N309_2, -0.00092342106));

N310_7 :=__common__( map(((real)f_addrchangeecontrajindex_d <= NULL) => 7.3139489e-005,
              ((real)f_addrchangeecontrajindex_d < 1.5)   => 0.011945312,
                                                             7.3139489e-005));

N310_6 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL) => -0.0061087947,
              ((real)f_liens_unrel_cj_total_amt_i < 357.5) => 0.0058930932,
                                                              -0.0061087947));

N310_5 :=__common__( map(trim(C_BLUE_COL) = ''              => -0.0042615402,
              ((real)c_blue_col < 10.0500001907) => N310_6,
                                                    -0.0042615402));

N310_4 :=__common__( map(trim(C_UNEMP) = ''              => N310_5,
              ((real)c_unemp < 6.94999980927) => 0.00063859869,
                                                 N310_5));

N310_3 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => N310_7,
              ((real)f_inq_adls_per_phone_i < 1.5)   => N310_4,
                                                        N310_7));

N310_2 :=__common__( if(((integer)f_addrchangevaluediff_d < 107658), N310_3, 0.0073601218));

N310_1 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N310_2, -0.001563013));

N311_9 :=__common__( map(trim(C_SFDU_P) = ''      => 0.0049462198,
              ((real)c_sfdu_p < 61.75) => 0.017757882,
                                          0.0049462198));

N311_8 :=__common__( if(((real)c_highinc < 2.95000004768), -0.0016757081, N311_9));

N311_7 :=__common__( if(trim(C_HIGHINC) != '', N311_8, 0.050446997));

N311_6 :=__common__( map(((real)f_inq_per_addr_i <= NULL) => -0.0038810267,
              ((real)f_inq_per_addr_i < 8.5)   => N311_7,
                                                  -0.0038810267));

N311_5 :=__common__( map(((real)r_d31_bk_filing_count_i <= NULL) => 0.010739777,
              ((real)r_d31_bk_filing_count_i < 2.5)   => -0.00045914552,
                                                         0.010739777));

N311_4 :=__common__( map(((real)f_srchfraudsrchcountmo_i <= NULL) => N311_6,
              ((real)f_srchfraudsrchcountmo_i < 0.5)   => N311_5,
                                                          N311_6));

N311_3 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N311_4, 0.0014375432));

N311_2 :=__common__( if(((real)r_c14_addrs_5yr_i < 0.5), -0.005141558, N311_3));

N311_1 :=__common__( if(((real)r_c14_addrs_5yr_i > NULL), N311_2, -0.002403939));

N312_8 :=__common__( map(trim(C_UNEMPL) = ''     => -0.0011968131,
              ((real)c_unempl < 70.5) => -0.011835791,
                                         -0.0011968131));

N312_7 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO']) => 0.0024125094,
              (segment in ['SEARS FLS', 'SEARS SHO'])        => 0.012816994,
                                                                0.0024125094));

N312_6 :=__common__( map(((real)f_corrrisktype_i <= NULL) => N312_7,
              ((real)f_corrrisktype_i < 8.5)   => 0.00074973753,
                                                  N312_7));

N312_5 :=__common__( if(((real)c_rentocc_p < 55.6500015259), N312_6, N312_8));

N312_4 :=__common__( if(trim(C_RENTOCC_P) != '', N312_5, 0.0011111796));

N312_3 :=__common__( map(((real)c_unique_addr_count_i <= NULL) => -0.00061842016,
              ((real)c_unique_addr_count_i < 12.5)  => -0.010967096,
                                                       -0.00061842016));

N312_2 :=__common__( if(((integer)r_i60_inq_mortgage_recency_d < 549), N312_3, N312_4));

N312_1 :=__common__( if(((real)r_i60_inq_mortgage_recency_d > NULL), N312_2, 0.00071061272));

N313_8 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL) => -1.4143484e-005,
              ((real)r_i60_inq_auto_recency_d < 61.5)  => -0.0090854692,
                                                          -1.4143484e-005));

N313_7 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)   => N313_8,
              ((real)f_prevaddrmedianvalue_d < 49821.5) => 0.0063570204,
                                                           N313_8));

N313_6 :=__common__( map(trim(C_TRANSPORT) = ''              => 0.0079393062,
              ((real)c_transport < 7.64999961853) => N313_7,
                                                     0.0079393062));

N313_5 :=__common__( if(((real)f_rel_homeover50_count_d < 3.5), 0.0094728383, N313_6));

N313_4 :=__common__( if(((real)f_rel_homeover50_count_d > NULL), N313_5, 0.0029494699));

N313_3 :=__common__( map(trim(C_RETAIL) = ''              => 0.0095555474,
              ((real)c_retail < 32.1999969482) => N313_4,
                                                  0.0095555474));

N313_2 :=__common__( if(((real)c_born_usa < 154.5), -0.00029732671, N313_3));

N313_1 :=__common__( if(trim(C_BORN_USA) != '', N313_2, -0.00029210051));

N314_8 :=__common__( map(trim(C_OLDHOUSE) = ''      => -0.0044952306,
              ((real)c_oldhouse < 196.5) => 0.006401249,
                                            -0.0044952306));

N314_7 :=__common__( map(((real)f_assoccredbureaucount_i <= NULL) => N314_8,
              ((real)f_assoccredbureaucount_i < 3.5)   => -0.0018712532,
                                                          N314_8));

N314_6 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)         => 0.0073308724,
              ((real)f_add_curr_nhood_vac_pct_i < 0.21465715766) => 0.0017636503,
                                                                    0.0073308724));

N314_5 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => -0.0076040628,
              ((real)r_c10_m_hdr_fs_d < 362.5) => N314_6,
                                                  -0.0076040628));

N314_4 :=__common__( if(((real)f_rel_ageover40_count_d < 2.5), N314_5, N314_7));

N314_3 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N314_4, 0.0010802572));

N314_2 :=__common__( if(((real)c_span_lang < 193.5), N314_3, -0.0078215723));

N314_1 :=__common__( if(trim(C_SPAN_LANG) != '', N314_2, 0.00070320681));

N315_10 :=__common__( if(((real)c_hh1_p < 30.1500015259), -0.0012887632, 0.011178801));

N315_9 :=__common__( if(trim(C_HH1_P) != '', N315_10, -0.01930756));

N315_8 :=__common__( if(((real)c_hh00 < 295.5), -0.010056728, -0.0021756557));

N315_7 :=__common__( if(trim(C_HH00) != '', N315_8, 0.0038249572));

N315_6 :=__common__( map(((real)c_addr_lres_6mo_ct_i <= NULL) => N315_9,
              ((real)c_addr_lres_6mo_ct_i < 9.5)   => N315_7,
                                                      N315_9));

N315_5 :=__common__( map(trim(C_SPAN_LANG) = ''      => -0.0073862059,
              ((real)c_span_lang < 191.5) => 0.001869323,
                                             -0.0073862059));

N315_4 :=__common__( if(((real)c_health < 69.1499938965), N315_5, -0.0066173762));

N315_3 :=__common__( if(trim(C_HEALTH) != '', N315_4, 0.0033290063));

N315_2 :=__common__( if(((real)f_rel_incomeover50_count_d < 4.5), N315_3, N315_6));

N315_1 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N315_2, 0.0018293881));

N316_7 :=__common__( map(trim(C_CONSTRUCTION) = ''              => 0.015672282,
              ((real)c_construction < 0.40000000596) => 0.0016240922,
                                                        0.015672282));

N316_6 :=__common__( map(trim(C_HVAL_125K_P) = ''              => 0.005796737,
              ((real)c_hval_125k_p < 10.3500003815) => -0.002788667,
                                                       0.005796737));

N316_5 :=__common__( map(trim(C_SPAN_LANG) = ''      => -0.0078294689,
              ((real)c_span_lang < 155.5) => N316_6,
                                             -0.0078294689));

N316_4 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.0042515413,
              ((real)c_easiqlife < 136.5) => N316_5,
                                             0.0042515413));

N316_3 :=__common__( map(trim(C_BORN_USA) = ''      => N316_7,
              ((real)c_born_usa < 155.5) => N316_4,
                                            N316_7));

N316_2 :=__common__( if(((real)c_hval_80k_p < 2.15000009537), N316_3, -0.00086831524));

N316_1 :=__common__( if(trim(C_HVAL_80K_P) != '', N316_2, 0.002453241));

N317_7 :=__common__( map(trim(C_HHSIZE) = ''              => -0.006355047,
              ((real)c_hhsize < 2.23500013351) => 0.0060515792,
                                                  -0.006355047));

N317_6 :=__common__( map(trim(C_VACANT_P) = ''              => 0.0077546243,
              ((real)c_vacant_p < 17.6500015259) => N317_7,
                                                    0.0077546243));

N317_5 :=__common__( map(trim(C_CHILD) = ''              => -0.0044264876,
              ((real)c_child < 19.3499984741) => 0.0030555042,
                                                 -0.0044264876));

N317_4 :=__common__( map(trim(C_ASSAULT) = ''      => N317_6,
              ((real)c_assault < 180.5) => N317_5,
                                           N317_6));

N317_3 :=__common__( map(trim(C_POPOVER25) = ''       => -0.0057506478,
              ((real)c_popover25 < 1812.5) => 0.0015267444,
                                              -0.0057506478));

N317_2 :=__common__( if(((real)c_retired2 < 95.5), N317_3, N317_4));

N317_1 :=__common__( if(trim(C_RETIRED2) != '', N317_2, -0.0012790566));

N318_10 :=__common__( if(((real)f_rel_incomeover50_count_d < 0.5), 0.0070344473, 0.0011433804));

N318_9 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N318_10, -0.015990729));

N318_8 :=__common__( if(((real)c_hval_150k_p < 8.35000038147), 0.0016337093, -0.002769569));

N318_7 :=__common__( if(trim(C_HVAL_150K_P) != '', N318_8, 0.009263212));

N318_6 :=__common__( map(((real)r_phn_pcs_n <= NULL) => -0.009722206,
              ((real)r_phn_pcs_n < 0.5)   => -0.0028871654,
                                             -0.009722206));

N318_5 :=__common__( map(((real)f_mos_liens_unrel_cj_lseen_d <= NULL) => N318_6,
              ((real)f_mos_liens_unrel_cj_lseen_d < 21.5)  => 0.0053700354,
                                                              N318_6));

N318_4 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d < 0.688390612602), N318_5, N318_7));

N318_3 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d > NULL), N318_4, 0.018432761));

N318_2 :=__common__( if(((real)f_srchfraudsrchcount_i < 9.5), N318_3, N318_9));

N318_1 :=__common__( if(((real)f_srchfraudsrchcount_i > NULL), N318_2, -0.0084361453));

N319_8 :=__common__( map(trim(C_POP_0_5_P) = ''              => 0.0099679176,
              ((real)c_pop_0_5_p < 9.05000019073) => 0.0013415478,
                                                     0.0099679176));

N319_7 :=__common__( map(trim(C_POP_12_17_P) = ''              => -0.0095769916,
              ((real)c_pop_12_17_p < 10.8500003815) => 0.00057801444,
                                                       -0.0095769916));

N319_6 :=__common__( map(trim(C_NO_TEENS) = ''     => N319_7,
              ((real)c_no_teens < 26.5) => 0.0057019075,
                                           N319_7));

N319_5 :=__common__( map(((real)r_l77_apartment_i <= NULL) => N319_8,
              ((real)r_l77_apartment_i < 0.5)   => N319_6,
                                                   N319_8));

N319_4 :=__common__( if(((real)c_serv_empl < 137.5), N319_5, -0.00094916499));

N319_3 :=__common__( if(trim(C_SERV_EMPL) != '', N319_4, 0.0059178571));

N319_2 :=__common__( if(((integer)f_prevaddrcartheftindex_i < 113), -0.0017284825, N319_3));

N319_1 :=__common__( if(((real)f_prevaddrcartheftindex_i > NULL), N319_2, 0.0045199403));

N320_8 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.0037708878,
              ((real)c_sub_bus < 118.5) => -0.00095962402,
                                           0.0037708878));

N320_7 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.0036623731,
              ((real)r_c20_email_count_i < 3.5)   => N320_8,
                                                     -0.0036623731));

N320_6 :=__common__( map(trim(C_MIL_EMP) = ''              => 0.0076578367,
              ((real)c_mil_emp < 1.54999995232) => N320_7,
                                                   0.0076578367));

N320_5 :=__common__( map(trim(C_SPAN_LANG) = ''      => 0.015403437,
              ((real)c_span_lang < 108.5) => 0.00037484998,
                                             0.015403437));

N320_4 :=__common__( map(((real)c_mos_since_impulse_fs_d <= NULL) => N320_6,
              ((real)c_mos_since_impulse_fs_d < 46.5)  => N320_5,
                                                          N320_6));

N320_3 :=__common__( map(trim(C_POP_35_44_P) = ''              => N320_4,
              ((real)c_pop_35_44_p < 13.4499998093) => -0.001341947,
                                                       N320_4));

N320_2 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N320_3, 0.0043993688));

N320_1 :=__common__( if(trim(C_POP_35_44_P) != '', N320_2, 0.0060050873));

N321_8 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => 0.0088761963,
              ((real)f_curraddrburglaryindex_i < 184.5) => 0.0010237488,
                                                           0.0088761963));

N321_7 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => -0.0013785229,
              ((real)f_mos_inq_banko_cm_lseen_d < 13.5)  => 0.0076266027,
                                                            -0.0013785229));

N321_6 :=__common__( map(trim(C_WHOLESALE) = ''              => -0.0066009355,
              ((real)c_wholesale < 4.55000019073) => N321_7,
                                                     -0.0066009355));

N321_5 :=__common__( if(((real)c_for_sale < 104.5), N321_6, N321_8));

N321_4 :=__common__( if(trim(C_FOR_SALE) != '', N321_5, 0.0016071675));

N321_3 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => 0.0035134881,
              ((real)r_c13_max_lres_d < 115.5) => N321_4,
                                                  0.0035134881));

N321_2 :=__common__( if(((real)r_c13_avg_lres_d < 97.5), N321_3, -0.0030382609));

N321_1 :=__common__( if(((real)r_c13_avg_lres_d > NULL), N321_2, 0.00074318295));

N322_9 :=__common__( map(((real)f_inq_count24_i <= NULL) => -0.011492748,
              ((real)f_inq_count24_i < 6.5)   => -0.0017094604,
                                                 -0.011492748));

N322_8 :=__common__( map(trim(C_LOW_ED) = ''              => 0.0035057286,
              ((real)c_low_ed < 52.9500007629) => 0.014674054,
                                                  0.0035057286));

N322_7 :=__common__( map(trim(C_INCOLLEGE) = ''     => 0.00023300512,
              ((real)c_incollege < 3.75) => N322_8,
                                            0.00023300512));

N322_6 :=__common__( if(((real)c_born_usa < 154.5), -0.00042352617, N322_7));

N322_5 :=__common__( if(trim(C_BORN_USA) != '', N322_6, -0.0064993727));

N322_4 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N322_5, -0.0034041524));

N322_3 :=__common__( map(((real)r_i60_inq_mortgage_recency_d <= NULL) => N322_4,
              ((real)r_i60_inq_mortgage_recency_d < 61.5)  => -0.0089237283,
                                                              N322_4));

N322_2 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 14.5), N322_3, N322_9));

N322_1 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N322_2, 0.0020484689));

N323_8 :=__common__( map(((real)c_comb_age_d <= NULL) => 0.0015016131,
              ((real)c_comb_age_d < 28.5)  => 0.0080742925,
                                              0.0015016131));

N323_7 :=__common__( map(trim(C_BIGAPT_P) = ''     => 0.011680892,
              ((real)c_bigapt_p < 2.25) => 2.4878481e-005,
                                           0.011680892));

N323_6 :=__common__( map(trim(C_FOOD) = ''      => -0.0028102737,
              ((real)c_food < 11.25) => N323_7,
                                        -0.0028102737));

N323_5 :=__common__( if(((real)c_new_homes < 149.5), N323_6, -0.0087018035));

N323_4 :=__common__( if(trim(C_NEW_HOMES) != '', N323_5, 0.0005377077));

N323_3 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => N323_8,
              ((real)f_m_bureau_adl_fs_all_d < 110.5) => N323_4,
                                                         N323_8));

N323_2 :=__common__( if(((integer)f_curraddrcartheftindex_i < 105), -0.0017259867, N323_3));

N323_1 :=__common__( if(((real)f_curraddrcartheftindex_i > NULL), N323_2, 0.0051337137));

N324_10 :=__common__( if(((real)c_hval_125k_p < 6.35000038147), 0.0010148827, 0.0092228387));

N324_9 :=__common__( if(trim(C_HVAL_125K_P) != '', N324_10, 0.015946623));

N324_8 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => -0.0022691465,
              ((real)r_c12_num_nonderogs_d < 6.5)   => 0.0074731051,
                                                       -0.0022691465));

N324_7 :=__common__( if(((real)f_rel_under25miles_cnt_d < 6.5), -0.0047844368, N324_8));

N324_6 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N324_7, 0.0076030493));

N324_5 :=__common__( map((fp_segment in ['2 NAS 479', '4 Bureau Only', '6 Recent Activity', '7 Other']) => N324_6,
              (fp_segment in ['1 SSN Prob', '3 New DID', '5 Derog'])                         => N324_9,
                                                                                                N324_6));

N324_4 :=__common__( if(((real)r_l77_apartment_i < 0.5), -0.00042144335, N324_5));

N324_3 :=__common__( if(((real)r_l77_apartment_i > NULL), N324_4, -0.0074241317));

N324_2 :=__common__( if(((real)f_mos_liens_rel_cj_lseen_d < 61.5), -0.0069020043, N324_3));

N324_1 :=__common__( if(((real)f_mos_liens_rel_cj_lseen_d > NULL), N324_2, 0.00032404782));

N325_8 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL)  => 0.0054430631,
              ((integer)f_curraddrcrimeindex_i < 114) => -0.0051058106,
                                                         0.0054430631));

N325_7 :=__common__( if(((real)c_exp_prod < 84.5), N325_8, 0.0091346929));

N325_6 :=__common__( if(trim(C_EXP_PROD) != '', N325_7, 0.018457539));

N325_5 :=__common__( map(((real)f_mos_acc_lseen_d <= NULL) => N325_6,
              ((real)f_mos_acc_lseen_d < 234.5) => -0.0028445808,
                                                   N325_6));

N325_4 :=__common__( map(((real)f_inq_auto_count24_i <= NULL) => -0.0097548565,
              ((real)f_inq_auto_count24_i < 3.5)   => 0.00026452263,
                                                      -0.0097548565));

N325_3 :=__common__( map(((real)f_varmsrcssnunrelcount_i <= NULL) => N325_5,
              ((real)f_varmsrcssnunrelcount_i < 1.5)   => N325_4,
                                                          N325_5));

N325_2 :=__common__( if(((real)f_prevaddrageoldest_d < 231.5), N325_3, -0.0093876427));

N325_1 :=__common__( if(((real)f_prevaddrageoldest_d > NULL), N325_2, -0.00061395019));

N326_8 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => 0.0041147734,
              (segment in ['SEARS FLS'])                                  => 0.017250908,
                                                                             0.0041147734));

N326_7 :=__common__( map(((real)c_addr_lres_6mo_ct_i <= NULL) => -0.00018065947,
              ((real)c_addr_lres_6mo_ct_i < 2.5)   => N326_8,
                                                      -0.00018065947));

N326_6 :=__common__( map(trim(C_UNEMP) = ''              => 0.00051729261,
              ((real)c_unemp < 12.3500003815) => -0.010060605,
                                                 0.00051729261));

N326_5 :=__common__( map(trim(C_HVAL_100K_P) = ''              => N326_6,
              ((real)c_hval_100k_p < 7.55000019073) => -0.00030698617,
                                                       N326_6));

N326_4 :=__common__( if(((real)c_no_car < 181.5), 0.00056649988, N326_5));

N326_3 :=__common__( if(trim(C_NO_CAR) != '', N326_4, -0.00040164751));

N326_2 :=__common__( if(((real)r_d32_felony_count_i < 0.5), N326_3, N326_7));

N326_1 :=__common__( if(((real)r_d32_felony_count_i > NULL), N326_2, -0.0080158026));

N327_9 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL)  => -0.010141431,
              ((integer)r_d32_mos_since_crim_ls_d < 214) => 0.00091950757,
                                                            -0.010141431));

N327_8 :=__common__( if(((real)c_easiqlife < 65.5), N327_9, -0.0009930773));

N327_7 :=__common__( if(trim(C_EASIQLIFE) != '', N327_8, 0.0081828313));

N327_6 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.0058010388,
              ((real)f_add_curr_nhood_vac_pct_i < 0.0326863452792) => -0.0035469869,
                                                                      0.0058010388));

N327_5 :=__common__( if(((real)f_curraddractivephonelist_d > NULL), N327_6, 0.023151274));

N327_4 :=__common__( if(((real)c_cpiall < 208.5), N327_5, 0.00019465974));

N327_3 :=__common__( if(trim(C_CPIALL) != '', N327_4, -0.0023434926));

N327_2 :=__common__( if(((real)r_l79_adls_per_addr_curr_i < 1.5), N327_3, N327_7));

N327_1 :=__common__( if(((real)r_l79_adls_per_addr_curr_i > NULL), N327_2, 0.061519407));

N328_7 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.00062823986,
              ((real)r_c20_email_count_i < 1.5)   => 0.012096482,
                                                     -0.00062823986));

N328_6 :=__common__( map(((real)c_addr_lres_12mo_ct_i <= NULL) => -0.0018013905,
              ((real)c_addr_lres_12mo_ct_i < 5.5)   => 0.004559796,
                                                       -0.0018013905));

N328_5 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.012000674,
              ((real)f_inq_other_count24_i < 3.5)   => N328_6,
                                                       0.012000674));

N328_4 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => N328_5,
              ((real)f_rel_felony_count_i < 1.5)   => -0.00087842456,
                                                      N328_5));

N328_3 :=__common__( map(((real)f_attr_arrests_i <= NULL) => N328_7,
              ((real)f_attr_arrests_i < 0.5)   => N328_4,
                                                  N328_7));

N328_2 :=__common__( if(((real)f_rel_criminal_count_i < 9.5), N328_3, -0.0029345489));

N328_1 :=__common__( if(((real)f_rel_criminal_count_i > NULL), N328_2, -0.0041381354));

N329_9 :=__common__( map(trim(C_RELIG_INDX) = ''      => 0.010959699,
              ((real)c_relig_indx < 141.5) => -0.0042841248,
                                              0.010959699));

N329_8 :=__common__( map(trim(C_POP_85P_P) = ''              => N329_9,
              ((real)c_pop_85p_p < 2.45000004768) => -0.0046863318,
                                                     N329_9));

N329_7 :=__common__( map(((real)f_corrssnnamecount_d <= NULL) => 0.00025377441,
              ((real)f_corrssnnamecount_d < 4.5)   => 0.0058666037,
                                                      0.00025377441));

N329_6 :=__common__( map(trim(C_ROBBERY) = ''      => N329_7,
              ((integer)c_robbery < 76) => -0.0034311132,
                                           N329_7));

N329_5 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0807042866945), N329_6, N329_8));

N329_4 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N329_5, 0.0043990028));

N329_3 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N329_4, -0.0008794077));

N329_2 :=__common__( if(((real)f_util_adl_count_n < 12.5), N329_3, 0.0054418507));

N329_1 :=__common__( if(((real)f_util_adl_count_n > NULL), N329_2, -0.00083012597));

N330_8 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.015714853,
              ((real)c_easiqlife < 117.5) => 0.0038807812,
                                             0.015714853));

N330_7 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => -0.0027229796,
              ((real)f_add_input_mobility_index_n < 0.357074320316) => N330_8,
                                                                       -0.0027229796));

N330_6 :=__common__( map(((real)f_inq_highriskcredit_count24_i <= NULL) => -0.0097726592,
              ((real)f_inq_highriskcredit_count24_i < 3.5)   => -0.00093344634,
                                                                -0.0097726592));

N330_5 :=__common__( map(trim(C_INC_150K_P) = ''     => 0.00060282547,
              ((real)c_inc_150k_p < 0.25) => N330_6,
                                             0.00060282547));

N330_4 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.00429491978139), -0.0065019285, N330_5));

N330_3 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N330_4, -0.0041053332));

N330_2 :=__common__( if(((real)c_transport < 14.4499998093), N330_3, N330_7));

N330_1 :=__common__( if(trim(C_TRANSPORT) != '', N330_2, 0.0045489168));

N331_8 :=__common__( map(trim(C_ARMFORCE) = ''      => 0.0094336179,
              ((real)c_armforce < 195.5) => -0.00048899353,
                                            0.0094336179));

N331_7 :=__common__( map(trim(C_PRESCHL) = ''      => -0.0012140424,
              ((real)c_preschl < 159.5) => 0.0092335742,
                                           -0.0012140424));

N331_6 :=__common__( map(trim(C_POP_18_24_P) = ''              => 0.00063799406,
              ((real)c_pop_18_24_p < 8.44999980927) => N331_7,
                                                       0.00063799406));

N331_5 :=__common__( if(((real)f_prevaddrmedianincome_d < 26123.5), N331_6, N331_8));

N331_4 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N331_5, 0.0081660015));

N331_3 :=__common__( map(trim(C_EMPLOYEES) = ''       => 0.0044836231,
              ((integer)c_employees < 616) => -0.0042117669,
                                              0.0044836231));

N331_2 :=__common__( if(((real)c_pop_75_84_p < 1.04999995232), N331_3, N331_4));

N331_1 :=__common__( if(trim(C_POP_75_84_P) != '', N331_2, 0.0012718873));

N332_9 :=__common__( if(((real)r_c10_m_hdr_fs_d < 171.5), 0.012654756, -0.00024746887));

N332_8 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N332_9, 0.018480813));

N332_7 :=__common__( map(trim(C_RNT750_P) = ''              => -0.0017635747,
              ((real)c_rnt750_p < 0.10000000149) => 0.0022208876,
                                                    -0.0017635747));

N332_6 :=__common__( map(trim(C_MURDERS) = ''      => -0.0034275341,
              ((real)c_murders < 165.5) => 0.0038675645,
                                           -0.0034275341));

N332_5 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => 0.008858276,
              ((real)f_curraddrburglaryindex_i < 186.5) => N332_6,
                                                           0.008858276));

N332_4 :=__common__( if(((integer)f_prevaddrmedianincome_d < 22739), N332_5, N332_7));

N332_3 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N332_4, 0.0034611158));

N332_2 :=__common__( if(((real)c_hval_200k_p < 20.6500015259), N332_3, N332_8));

N332_1 :=__common__( if(trim(C_HVAL_200K_P) != '', N332_2, 0.0010554799));

N333_10 :=__common__( if(((real)c_hval_200k_p < 1.34999990463), 0.0069395194, -0.0019388464));

N333_9 :=__common__( if(trim(C_HVAL_200K_P) != '', N333_10, -0.0045767191));

N333_8 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.0464009679854), -0.0062393182, 0.0023381865));

N333_7 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N333_8, 0.023143195));

N333_6 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), -0.0012013839, N333_7));

N333_5 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => N333_9,
              ((real)f_rel_felony_count_i < 2.5)   => N333_6,
                                                      N333_9));

N333_4 :=__common__( map(((real)c_addr_lres_6mo_ct_i <= NULL) => 0.0036193782,
              ((real)c_addr_lres_6mo_ct_i < 7.5)   => -0.005743809,
                                                      0.0036193782));

N333_3 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => N333_5,
              ((real)f_mos_inq_banko_om_fseen_d < 35.5)  => N333_4,
                                                            N333_5));

N333_2 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 32.5), 0.0016341294, N333_3));

N333_1 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N333_2, 0.0012481415));

N334_10 :=__common__( if(((real)c_rnt1000_p < 17.1500015259), 0.0044709984, -0.001335298));

N334_9 :=__common__( if(trim(C_RNT1000_P) != '', N334_10, -0.011309273));

N334_8 :=__common__( if(((integer)r_l80_inp_avm_autoval_d < 70998), 0.0094782956, -0.0022576137));

N334_7 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N334_8, 0.0068605002));

N334_6 :=__common__( map(((real)f_adl_util_inf_n <= NULL) => -0.0048519235,
              ((real)f_adl_util_inf_n < 0.5)   => N334_7,
                                                  -0.0048519235));

N334_5 :=__common__( map(((real)f_assocrisktype_i <= NULL) => N334_6,
              ((real)f_assocrisktype_i < 3.5)   => -0.0029610947,
                                                   N334_6));

N334_4 :=__common__( if(((real)c_hist_addr_match_i < 6.5), -0.0016505439, N334_5));

N334_3 :=__common__( if(((real)c_hist_addr_match_i > NULL), N334_4, -0.0052416852));

N334_2 :=__common__( if(((real)r_l77_apartment_i < 0.5), N334_3, N334_9));

N334_1 :=__common__( if(((real)r_l77_apartment_i > NULL), N334_2, -0.03730141));

N335_8 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => 0.0015807987,
              ((real)r_c14_addrs_15yr_i < 5.5)   => -0.0028425765,
                                                    0.0015807987));

N335_7 :=__common__( map(((real)f_srchunvrfdssncount_i <= NULL) => 0.0048638002,
              ((real)f_srchunvrfdssncount_i < 0.5)   => -0.0040308833,
                                                        0.0048638002));

N335_6 :=__common__( if(((real)c_inc_150k_p < 1.84999990463), N335_7, 0.0060173831));

N335_5 :=__common__( if(trim(C_INC_150K_P) != '', N335_6, 0.005785134));

N335_4 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => -0.0032524118,
              ((real)f_curraddrmedianincome_d < 29138.5) => N335_5,
                                                            -0.0032524118));

N335_3 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => N335_8,
              ((real)r_c13_max_lres_d < 91.5)  => N335_4,
                                                  N335_8));

N335_2 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 14.5), 0.0082654334, N335_3));

N335_1 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N335_2, 0.004572396));

N336_8 :=__common__( map(trim(C_RELIG_INDX) = ''      => 0.0010413697,
              ((real)c_relig_indx < 108.5) => -0.0034805751,
                                              0.0010413697));

N336_7 :=__common__( map(trim(C_NO_TEENS) = ''     => -0.012489099,
              ((real)c_no_teens < 62.5) => -0.0019516887,
                                           -0.012489099));

N336_6 :=__common__( map(trim(C_INC_125K_P) = ''     => N336_8,
              ((real)c_inc_125k_p < 1.25) => N336_7,
                                             N336_8));

N336_5 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => 0.0072971347,
              ((real)f_mos_inq_banko_cm_lseen_d < 63.5)  => 4.5459498e-005,
                                                            0.0072971347));

N336_4 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 70.5), N336_5, N336_6));

N336_3 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N336_4, 0.0038561669));

N336_2 :=__common__( if(((real)c_low_hval < 80.1499938965), N336_3, 0.007712412));

N336_1 :=__common__( if(trim(C_LOW_HVAL) != '', N336_2, 0.0018064507));

N337_8 :=__common__( map(trim(C_CIV_EMP) = ''      => 0.00099428022,
              ((real)c_civ_emp < 52.25) => -0.0068510291,
                                           0.00099428022));

N337_7 :=__common__( if(((integer)r_i60_inq_hiriskcred_recency_d < 18), N337_8, 0.00094442432));

N337_6 :=__common__( if(((real)r_i60_inq_hiriskcred_recency_d > NULL), N337_7, 0.026685392));

N337_5 :=__common__( map(trim(C_POPOVER25) = ''      => 0.0030268303,
              ((real)c_popover25 < 898.5) => N337_6,
                                             0.0030268303));

N337_4 :=__common__( map(trim(C_OWNOCC_P) = ''              => 0.00046847739,
              ((real)c_ownocc_p < 47.5499992371) => -0.0085440953,
                                                    0.00046847739));

N337_3 :=__common__( map(trim(C_BURGLARY) = ''      => -0.0085585431,
              ((real)c_burglary < 152.5) => N337_4,
                                            -0.0085585431));

N337_2 :=__common__( if(((real)c_no_car < 87.5), N337_3, N337_5));

N337_1 :=__common__( if(trim(C_NO_CAR) != '', N337_2, -0.0013808691));

N338_12 :=__common__( if(((real)c_bargains < 85.5), -0.0062906688, 0.0013465648));

N338_11 :=__common__( if(trim(C_BARGAINS) != '', N338_12, 0.0058954635));

N338_10 :=__common__( if(((real)c_rnt250_p < 4.94999980927), -0.0032602255, -0.011907));

N338_9 :=__common__( if(trim(C_RNT250_P) != '', N338_10, -0.030539284));

N338_8 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d < 13.5), N338_9, N338_11));

N338_7 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d > NULL), N338_8, 0.018821985));

N338_6 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 68.5), -2.0230807e-005, 0.011144467));

N338_5 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N338_6, 0.028890053));

N338_4 :=__common__( if(((real)c_hval_175k_p < 26.25), 0.00029421444, N338_5));

N338_3 :=__common__( if(trim(C_HVAL_175K_P) != '', N338_4, -0.00063776316));

N338_2 :=__common__( if(((real)r_phn_pcs_n < 0.5), N338_3, N338_7));

N338_1 :=__common__( if(((real)r_phn_pcs_n > NULL), N338_2, -0.027718725));

N339_8 :=__common__( if(((real)c_easiqlife < 51.5), -0.0094481548, -0.0002670997));

N339_7 :=__common__( if(trim(C_EASIQLIFE) != '', N339_8, -0.003126438));

N339_6 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.127984523773), 0.0044440813, -0.0082633783));

N339_5 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N339_6, 0.0080056602));

N339_4 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => 0.0091290207,
              ((real)r_d30_derog_count_i < 0.5)   => N339_5,
                                                     0.0091290207));

N339_3 :=__common__( if(((real)f_m_bureau_adl_fs_all_d < 65.5), N339_4, 0.011456875));

N339_2 :=__common__( if(((real)f_m_bureau_adl_fs_all_d > NULL), N339_3, 0.013597235));

N339_1 :=__common__( map(((real)c_comb_age_d <= NULL) => N339_7,
              ((real)c_comb_age_d < 23.5)  => N339_2,
                                              N339_7));

N340_7 :=__common__( if(((real)f_add_input_mobility_index_n < 0.445263624191), -0.0049312113, 0.0048327411));

N340_6 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N340_7, 0.0056415045));

N340_5 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)    => -0.0017530525,
              ((integer)f_prevaddrmedianincome_d < 34186) => -0.0094873821,
                                                             -0.0017530525));

N340_4 :=__common__( map(trim(C_LOW_ED) = ''              => 0.0039988909,
              ((real)c_low_ed < 69.9499969482) => N340_5,
                                                  0.0039988909));

N340_3 :=__common__( if(((real)c_pop_75_84_p < 0.949999988079), N340_4, 0.00090065256));

N340_2 :=__common__( if(trim(C_POP_75_84_P) != '', N340_3, -0.00082914373));

N340_1 :=__common__( if(((real)f_prevaddrstatus_i > NULL), N340_2, N340_6));

N341_8 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i < 1.5), 0.0023290788, -0.010199559));

N341_7 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i > NULL), N341_8, 0.032350928));

N341_6 :=__common__( map(trim(C_RETAIL) = ''              => -0.014633455,
              ((real)c_retail < 7.94999980927) => N341_7,
                                                  -0.014633455));

N341_5 :=__common__( map(trim(C_CARTHEFT) = ''       => 0.0025886783,
              ((integer)c_cartheft < 147) => -0.0039332572,
                                             0.0025886783));

N341_4 :=__common__( map(trim(C_YOUNG) = ''              => N341_6,
              ((real)c_young < 29.1500015259) => N341_5,
                                                 N341_6));

N341_3 :=__common__( map(trim(C_POPOVER25) = ''      => 0.001487581,
              ((real)c_popover25 < 622.5) => N341_4,
                                             0.001487581));

N341_2 :=__common__( if(((real)c_housingcpi < 186.399993896), -0.007893345, N341_3));

N341_1 :=__common__( if(trim(C_HOUSINGCPI) != '', N341_2, -0.0035001474));

N342_8 :=__common__( if(((real)f_rel_under100miles_cnt_d < 11.5), 0.00015882081, 0.011339431));

N342_7 :=__common__( if(((real)f_rel_under100miles_cnt_d > NULL), N342_8, -0.001381788));

N342_6 :=__common__( map(trim(C_HH1_P) = ''              => 0.010431133,
              ((real)c_hh1_p < 26.9500007629) => -0.00015508653,
                                                 0.010431133));

N342_5 :=__common__( if(((real)c_pop_18_24_p < 5.55000019073), N342_6, -0.00018010644));

N342_4 :=__common__( if(trim(C_POP_18_24_P) != '', N342_5, 0.011922605));

N342_3 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 32.5), N342_4, -0.0017625958));

N342_2 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N342_3, -0.010119518));

N342_1 :=__common__( map(((real)f_recent_disconnects_i <= NULL) => N342_7,
              ((real)f_recent_disconnects_i < 0.5)   => N342_2,
                                                        N342_7));

N343_8 :=__common__( map(trim(C_TOTSALES) = ''         => 0.0052950118,
              ((integer)c_totsales < 24019) => -0.0051044762,
                                               0.0052950118));

N343_7 :=__common__( map(trim(C_CHILD) = ''      => 0.0043674741,
              ((real)c_child < 37.25) => N343_8,
                                         0.0043674741));

N343_6 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => 0.0071097094,
              ((real)r_d30_derog_count_i < 14.5)  => -0.00029323059,
                                                     0.0071097094));

N343_5 :=__common__( map(((real)r_c20_email_domain_free_count_i <= NULL) => N343_6,
              ((real)r_c20_email_domain_free_count_i < 0.5)   => 0.0037043566,
                                                                 N343_6));

N343_4 :=__common__( if(((real)c_preschl < 178.5), N343_5, N343_7));

N343_3 :=__common__( if(trim(C_PRESCHL) != '', N343_4, -0.0046341777));

N343_2 :=__common__( if(((integer)f_mos_acc_lseen_d < 215), -0.0031277971, N343_3));

N343_1 :=__common__( if(((real)f_mos_acc_lseen_d > NULL), N343_2, -0.0068422183));

N344_9 :=__common__( map(((real)f_inq_collection_count24_i <= NULL) => 0.0069291877,
              ((real)f_inq_collection_count24_i < 2.5)   => -4.7161655e-005,
                                                            0.0069291877));

N344_8 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), 0.00040656767, -0.0054942735));

N344_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0184248797596), N344_8, N344_9));

N344_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N344_7, -0.0013965423));

N344_5 :=__common__( if(((real)c_lux_prod < 72.5), 0.010983401, -0.0011952906));

N344_4 :=__common__( if(trim(C_LUX_PROD) != '', N344_5, -0.0036097489));

N344_3 :=__common__( map(((real)c_mos_since_impulse_ls_d <= NULL) => N344_6,
              ((real)c_mos_since_impulse_ls_d < 37.5)  => N344_4,
                                                          N344_6));

N344_2 :=__common__( if(((real)f_srchssnsrchcount_i < 40.5), N344_3, -0.0079925569));

N344_1 :=__common__( if(((real)f_srchssnsrchcount_i > NULL), N344_2, -0.006695271));

N345_7 :=__common__( map(trim(C_RETAIL) = ''              => -0.01241691,
              ((real)c_retail < 6.05000019073) => -0.00053032649,
                                                  -0.01241691));

N345_6 :=__common__( map(trim(C_HHSIZE) = ''              => -0.01277659,
              ((real)c_hhsize < 2.27500009537) => 0.00057392642,
                                                  -0.01277659));

N345_5 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)          => 0.00046219599,
              ((real)f_add_input_nhood_sfd_pct_d < 0.116027712822) => N345_6,
                                                                      0.00046219599));

N345_4 :=__common__( map(trim(C_LOW_ED) = ''              => N345_7,
              ((real)c_low_ed < 82.0500030518) => N345_5,
                                                  N345_7));

N345_3 :=__common__( map(trim(C_POP_6_11_P) = ''              => 0.012809883,
              ((real)c_pop_6_11_p < 8.35000038147) => 0.00095259426,
                                                      0.012809883));

N345_2 :=__common__( if(((real)c_pop_18_24_p < 2.15000009537), N345_3, N345_4));

N345_1 :=__common__( if(trim(C_POP_18_24_P) != '', N345_2, -0.0010953769));

N346_8 :=__common__( map(trim(C_BEL_EDU) = ''      => -0.010603097,
              ((real)c_bel_edu < 191.5) => -0.0016662764,
                                           -0.010603097));

N346_7 :=__common__( map(trim(C_FOOD) = ''              => -0.010688607,
              ((real)c_food < 21.4500007629) => -0.00012022216,
                                                -0.010688607));

N346_6 :=__common__( map(trim(C_UNEMP) = ''     => 0.0011435286,
              ((real)c_unemp < 3.25) => N346_7,
                                        0.0011435286));

N346_5 :=__common__( if(((real)r_i60_inq_retail_count12_i < 0.5), N346_6, -0.0085384756));

N346_4 :=__common__( if(((real)r_i60_inq_retail_count12_i > NULL), N346_5, -0.011978477));

N346_3 :=__common__( map(trim(C_LOW_HVAL) = ''              => 0.0083480214,
              ((real)c_low_hval < 68.4499969482) => N346_4,
                                                    0.0083480214));

N346_2 :=__common__( if(((real)c_femdiv_p < 5.35000038147), N346_3, N346_8));

N346_1 :=__common__( if(trim(C_FEMDIV_P) != '', N346_2, -0.0013605607));

N347_7 :=__common__( map(((real)f_inq_per_addr_i <= NULL) => 0.0077415179,
              ((real)f_inq_per_addr_i < 16.5)  => -0.0011418649,
                                                  0.0077415179));

N347_6 :=__common__( map(((real)r_s66_adlperssn_count_i <= NULL) => 0.002562652,
              ((real)r_s66_adlperssn_count_i < 2.5)   => N347_7,
                                                         0.002562652));

N347_5 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => 0.012430183,
              ((real)f_add_input_nhood_vac_pct_i < 0.185106724501) => 0.0016678646,
                                                                      0.012430183));

N347_4 :=__common__( map(trim(C_INC_100K_P) = ''              => N347_6,
              ((real)c_inc_100k_p < 3.34999990463) => N347_5,
                                                      N347_6));

N347_3 :=__common__( map(trim(C_RENTOCC_P) = ''      => -0.0037539576,
              ((real)c_rentocc_p < 64.25) => N347_4,
                                             -0.0037539576));

N347_2 :=__common__( if(((integer)c_larceny < 192), N347_3, -0.0050112015));

N347_1 :=__common__( if(trim(C_LARCENY) != '', N347_2, 0.00033964285));

N348_9 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)          => 0.016543939,
              ((real)f_add_input_nhood_sfd_pct_d < 0.584484577179) => 0.0039012121,
                                                                      0.016543939));

N348_8 :=__common__( map(trim(C_POP_65_74_P) = ''     => 0.0011927066,
              ((real)c_pop_65_74_p < 5.75) => N348_9,
                                              0.0011927066));

N348_7 :=__common__( map(trim(C_HVAL_40K_P) = ''              => -0.0024425953,
              ((real)c_hval_40k_p < 1.15000009537) => 0.0023484385,
                                                      -0.0024425953));

N348_6 :=__common__( if(((real)f_rel_under25miles_cnt_d < 17.5), N348_7, N348_8));

N348_5 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N348_6, 0.0039883238));

N348_4 :=__common__( if(((real)r_c20_email_domain_free_count_i < 5.5), -0.0005700025, -0.0088589928));

N348_3 :=__common__( if(((real)r_c20_email_domain_free_count_i > NULL), N348_4, -0.001555514));

N348_2 :=__common__( if(((real)c_bigapt_p < 1.34999990463), N348_3, N348_5));

N348_1 :=__common__( if(trim(C_BIGAPT_P) != '', N348_2, -0.00086929122));

N349_8 :=__common__( map(trim(C_BLUE_EMPL) = ''      => 0.014385123,
              ((real)c_blue_empl < 164.5) => 0.0017576176,
                                             0.014385123));

N349_7 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), N349_8, -0.00072103248));

N349_6 :=__common__( if(((real)f_inq_collection_count24_i < 2.5), N349_7, 0.0065008403));

N349_5 :=__common__( if(((real)f_inq_collection_count24_i > NULL), N349_6, 0.0020796786));

N349_4 :=__common__( map(trim(C_SFDU_P) = ''              => 0.0057732784,
              ((real)c_sfdu_p < 99.4499969482) => -0.0041061802,
                                                  0.0057732784));

N349_3 :=__common__( map(trim(C_HH1_P) = ''              => N349_5,
              ((real)c_hh1_p < 18.5499992371) => N349_4,
                                                 N349_5));

N349_2 :=__common__( if(((real)c_inc_100k_p < 23.1500015259), N349_3, 0.0096332019));

N349_1 :=__common__( if(trim(C_INC_100K_P) != '', N349_2, 0.002828374));

N350_10 :=__common__( if(((real)c_hval_100k_p < 2.54999995232), 0.0067768236, -0.0010519295));

N350_9 :=__common__( if(trim(C_HVAL_100K_P) != '', N350_10, -0.00056001332));

N350_8 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.003815315,
              (segment in ['SEARS FLS'])                                  => 0.0010926484,
                                                                             -0.003815315));

N350_7 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)   => N350_8,
              ((real)f_prevaddrmedianvalue_d < 51712.5) => 0.0033008605,
                                                           N350_8));

N350_6 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => 0.00053631872,
              ((real)r_a50_pb_average_dollars_d < 30.5)  => 0.0075661723,
                                                            0.00053631872));

N350_5 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => N350_7,
              ((real)f_mos_inq_banko_om_fseen_d < 34.5)  => N350_6,
                                                            N350_7));

N350_4 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), 0.0011150586, N350_5));

N350_3 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N350_4, N350_9));

N350_2 :=__common__( if(((real)f_mos_liens_rel_ot_lseen_d < 91.5), -0.0080750063, N350_3));

N350_1 :=__common__( if(((real)f_mos_liens_rel_ot_lseen_d > NULL), N350_2, 0.00051377575));

N351_9 :=__common__( if(((real)f_inq_adls_per_phone_i < 0.5), 0.0025425612, -0.0012096501));

N351_8 :=__common__( if(((real)f_inq_adls_per_phone_i > NULL), N351_9, -0.027536524));

N351_7 :=__common__( if(trim(C_ASSAULT) != '', N351_8, 0.00021122625));

N351_6 :=__common__( map(((real)f_add_curr_mobility_index_n <= NULL)          => -0.0071938231,
              ((real)f_add_curr_mobility_index_n < 0.693741500378) => N351_7,
                                                                      -0.0071938231));

N351_5 :=__common__( map(((real)f_divaddrsuspidcountnew_i <= NULL) => 0.0064823622,
              ((real)f_divaddrsuspidcountnew_i < 1.5)   => N351_6,
                                                           0.0064823622));

N351_4 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL) => -0.0019011258,
              ((integer)f_fp_prevaddrburglaryindex_i < 39) => 0.0040486837,
                                                              -0.0019011258));

N351_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N351_4, N351_5));

N351_2 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.183834046125), -0.0074418848, N351_3));

N351_1 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N351_2, -0.0051869641));

N352_8 :=__common__( map(((real)f_srchunvrfdphonecount_i <= NULL) => -0.0022457497,
              ((real)f_srchunvrfdphonecount_i < 0.5)   => 0.00068875146,
                                                          -0.0022457497));

N352_7 :=__common__( map(trim(C_INC_35K_P) = ''              => 0.0084724539,
              ((real)c_inc_35k_p < 25.4500007629) => N352_8,
                                                     0.0084724539));

N352_6 :=__common__( map(trim(C_HH1_P) = ''              => 0.0054173477,
              ((real)c_hh1_p < 51.1500015259) => N352_7,
                                                 0.0054173477));

N352_5 :=__common__( map(((real)f_rel_count_i <= NULL) => N352_6,
              ((real)f_rel_count_i < 3.5)   => 0.0058446753,
                                               N352_6));

N352_4 :=__common__( if(((real)f_corrssnnamecount_d < 1.5), -0.0059974735, N352_5));

N352_3 :=__common__( if(((real)f_corrssnnamecount_d > NULL), N352_4, 0.0017769406));

N352_2 :=__common__( if(((real)c_serv_empl < 192.5), N352_3, 0.0060314188));

N352_1 :=__common__( if(trim(C_SERV_EMPL) != '', N352_2, -0.0019124544));

N353_8 :=__common__( map(trim(C_WORK_HOME) = ''     => -0.00099373903,
              ((real)c_work_home < 87.5) => 0.008033697,
                                            -0.00099373903));

N353_7 :=__common__( map(trim(C_EASIQLIFE) = ''     => N353_8,
              ((real)c_easiqlife < 64.5) => -0.0041409012,
                                            N353_8));

N353_6 :=__common__( map(trim(C_LOWINC) = ''              => -0.0071276723,
              ((real)c_lowinc < 69.4499969482) => N353_7,
                                                  -0.0071276723));

N353_5 :=__common__( map(trim(C_POP_18_24_P) = ''              => -0.0053431306,
              ((real)c_pop_18_24_p < 11.8500003815) => N353_6,
                                                       -0.0053431306));

N353_4 :=__common__( if(((real)c_addr_lres_2mo_ct_i < 1.5), 0.0031942894, N353_5));

N353_3 :=__common__( if(((real)c_addr_lres_2mo_ct_i > NULL), N353_4, 0.021415317));

N353_2 :=__common__( if(((real)c_born_usa < 119.5), -0.0010892355, N353_3));

N353_1 :=__common__( if(trim(C_BORN_USA) != '', N353_2, -0.004801462));

N354_8 :=__common__( map(trim(C_RAPE) = ''      => -0.00074758302,
              ((integer)c_rape < 91) => 0.0031429829,
                                        -0.00074758302));

N354_7 :=__common__( map(trim(C_HVAL_80K_P) = ''              => 0.0077899591,
              ((real)c_hval_80k_p < 43.6500015259) => N354_8,
                                                      0.0077899591));

N354_6 :=__common__( map(trim(C_FOOD) = ''              => -0.0076893604,
              ((real)c_food < 27.8499984741) => -0.0015143915,
                                                -0.0076893604));

N354_5 :=__common__( map(trim(C_HEALTH) = ''              => N354_6,
              ((real)c_health < 4.35000038147) => 0.0005117917,
                                                  N354_6));

N354_4 :=__common__( if(((real)r_c13_curr_addr_lres_d < 13.5), N354_5, N354_7));

N354_3 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N354_4, -0.0020284241));

N354_2 :=__common__( if(((real)c_oldhouse < 4.44999980927), 0.0098540554, N354_3));

N354_1 :=__common__( if(trim(C_OLDHOUSE) != '', N354_2, -0.0046348004));

N355_8 :=__common__( map(trim(C_CARTHEFT) = ''      => 0.0012179433,
              ((real)c_cartheft < 106.5) => -0.0018562032,
                                            0.0012179433));

N355_7 :=__common__( map(trim(C_HVAL_175K_P) = ''              => 0.0059076251,
              ((real)c_hval_175k_p < 26.0499992371) => N355_8,
                                                       0.0059076251));

N355_6 :=__common__( map(((real)f_liens_rel_cj_total_amt_i <= NULL) => -0.0061723225,
              ((real)f_liens_rel_cj_total_amt_i < 732.5) => N355_7,
                                                            -0.0061723225));

N355_5 :=__common__( map(trim(C_LARCENY) = ''      => -0.0086939254,
              ((real)c_larceny < 197.5) => N355_6,
                                           -0.0086939254));

N355_4 :=__common__( if(((real)f_srchcomponentrisktype_i < 2.5), N355_5, 0.0055200019));

N355_3 :=__common__( if(((real)f_srchcomponentrisktype_i > NULL), N355_4, -0.0044881902));

N355_2 :=__common__( if(((real)c_bel_edu < 193.5), N355_3, -0.0073509949));

N355_1 :=__common__( if(trim(C_BEL_EDU) != '', N355_2, -0.0016732518));

N356_8 :=__common__( map(trim(C_RNT500_P) = ''              => -0.0073255575,
              ((real)c_rnt500_p < 34.0499992371) => -0.00049344314,
                                                    -0.0073255575));

N356_7 :=__common__( map(trim(C_NO_CAR) = ''      => 0.0061150141,
              ((real)c_no_car < 164.5) => -0.0010369869,
                                          0.0061150141));

N356_6 :=__common__( if(((real)c_inc_15k_p < 20.75), N356_7, N356_8));

N356_5 :=__common__( if(trim(C_INC_15K_P) != '', N356_6, -0.0026067577));

N356_4 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL)   => -0.0020245058,
              ((integer)f_liens_unrel_cj_total_amt_i < 1207) => 0.010028886,
                                                                -0.0020245058));

N356_3 :=__common__( map(((real)f_liens_unrel_sc_total_amt_i <= NULL)  => N356_4,
              ((real)f_liens_unrel_sc_total_amt_i < 1899.5) => 0.00065274344,
                                                               N356_4));

N356_2 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 70.5), N356_3, N356_5));

N356_1 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N356_2, 0.0031778267));

N357_8 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), 0.0043593857, -0.0047853007));

N357_7 :=__common__( if(((real)f_prevaddrmedianincome_d < 38801.5), 0.0018082855, N357_8));

N357_6 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N357_7, -0.0059534257));

N357_5 :=__common__( map(trim(C_POPOVER25) = ''      => N357_6,
              ((real)c_popover25 < 644.5) => -0.007329484,
                                             N357_6));

N357_4 :=__common__( map(trim(C_RELIG_INDX) = ''      => 0.0078692493,
              ((real)c_relig_indx < 177.5) => 0.00080544407,
                                              0.0078692493));

N357_3 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.0097637257,
              ((real)c_comb_age_d < 58.5)  => N357_4,
                                              -0.0097637257));

N357_2 :=__common__( if(((real)c_finance < 1.45000004768), N357_3, N357_5));

N357_1 :=__common__( if(trim(C_FINANCE) != '', N357_2, -0.001046058));

N358_11 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.00477327266708), -0.0090021936, 0.00094765993));

N358_10 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N358_11, -0.0068168316));

N358_9 :=__common__( if(((real)c_pop_75_84_p < 9.05000019073), N358_10, -0.0061442538));

N358_8 :=__common__( if(trim(C_POP_75_84_P) != '', N358_9, 0.0018177319));

N358_7 :=__common__( map(((real)f_srchunvrfdssncount_i <= NULL) => 0.0019357914,
              ((real)f_srchunvrfdssncount_i < 0.5)   => -0.0025522347,
                                                        0.0019357914));

N358_6 :=__common__( map(trim(C_HH1_P) = ''              => -0.008760493,
              ((real)c_hh1_p < 43.5499992371) => N358_7,
                                                 -0.008760493));

N358_5 :=__common__( if(((real)c_assault < 191.5), N358_6, 0.0071732931));

N358_4 :=__common__( if(trim(C_ASSAULT) != '', N358_5, -0.010730386));

N358_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N358_4, N358_8));

N358_2 :=__common__( if(((integer)f_liens_unrel_sc_total_amt_i < 6729), N358_3, 0.0085341685));

N358_1 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i > NULL), N358_2, 0.00050717676));

N359_10 :=__common__( if(((real)f_prevaddrmedianvalue_d < 98258.5), -0.0020460719, 0.0091167148));

N359_9 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N359_10, 0.022018922));

N359_8 :=__common__( map(trim(C_POP_55_64_P) = ''              => -0.00074222728,
              ((real)c_pop_55_64_p < 5.14999961853) => 0.00506319,
                                                       -0.00074222728));

N359_7 :=__common__( map(trim(C_LAR_FAM) = ''      => 0.0057218809,
              ((real)c_lar_fam < 157.5) => -0.0036893779,
                                           0.0057218809));

N359_6 :=__common__( if(((real)r_l80_inp_avm_autoval_d < 54705.5), 0.0024954623, N359_7));

N359_5 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N359_6, N359_8));

N359_4 :=__common__( if(((integer)r_i60_inq_auto_recency_d < 9), -0.0066200313, N359_5));

N359_3 :=__common__( if(((real)r_i60_inq_auto_recency_d > NULL), N359_4, -0.0023665427));

N359_2 :=__common__( if(((real)c_rich_wht < 173.5), N359_3, N359_9));

N359_1 :=__common__( if(trim(C_RICH_WHT) != '', N359_2, -0.0024366712));

N360_8 :=__common__( if(((real)r_a50_pb_average_dollars_d < 65.5), 0.0011211614, 0.012270173));

N360_7 :=__common__( if(((real)r_a50_pb_average_dollars_d > NULL), N360_8, 0.0090356278));

N360_6 :=__common__( map(trim(C_OLD_HOMES) = ''     => 0.0014379127,
              ((real)c_old_homes < 60.5) => N360_7,
                                            0.0014379127));

N360_5 :=__common__( map(trim(C_HVAL_60K_P) = ''              => 0.0059870556,
              ((real)c_hval_60k_p < 35.6500015259) => -0.0023538692,
                                                      0.0059870556));

N360_4 :=__common__( map(trim(C_APT20) = ''      => 0.0035103747,
              ((real)c_apt20 < 129.5) => N360_5,
                                         0.0035103747));

N360_3 :=__common__( map(trim(C_LUX_PROD) = ''     => N360_6,
              ((real)c_lux_prod < 68.5) => N360_4,
                                           N360_6));

N360_2 :=__common__( if(((real)c_professional < 1.34999990463), N360_3, -0.0019086806));

N360_1 :=__common__( if(trim(C_PROFESSIONAL) != '', N360_2, 0.0074182687));

N361_9 :=__common__( map(trim(C_HVAL_125K_P) = ''      => 0.00076739356,
              ((real)c_hval_125k_p < 10.25) => 0.010434695,
                                               0.00076739356));

N361_8 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => 0.009007848,
              ((real)f_srchfraudsrchcount_i < 8.5)   => -0.004707139,
                                                        0.009007848));

N361_7 :=__common__( if(((real)f_componentcharrisktype_i < 4.5), N361_8, N361_9));

N361_6 :=__common__( if(((real)f_componentcharrisktype_i > NULL), N361_7, 0.022898855));

N361_5 :=__common__( map(trim(C_FEMDIV_P) = ''              => 0.00020686346,
              ((real)c_femdiv_p < 2.65000009537) => N361_6,
                                                    0.00020686346));

N361_4 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.100621499121), 0.00062755954, -0.0085964403));

N361_3 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N361_4, -0.0049789853));

N361_2 :=__common__( if(((real)c_unattach < 80.5), N361_3, N361_5));

N361_1 :=__common__( if(trim(C_UNATTACH) != '', N361_2, 0.0018636644));

N362_8 :=__common__( map(((real)r_i60_inq_hiriskcred_recency_d <= NULL) => 0.00097444082,
              ((real)r_i60_inq_hiriskcred_recency_d < 61.5)  => -0.011863955,
                                                                0.00097444082));

N362_7 :=__common__( map(((real)f_prevaddrdwelltype_apt_n <= NULL) => 0.0067342503,
              ((real)f_prevaddrdwelltype_apt_n < 0.5)   => -0.0037131375,
                                                           0.0067342503));

N362_6 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS FLS', 'SEARS SHO']) => N362_7,
              (segment in ['KMART'])                                          => 0.0043482893,
                                                                                 N362_7));

N362_5 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => N362_6,
              ((real)f_inq_per_ssn_i < 3.5)   => -0.00042172137,
                                                 N362_6));

N362_4 :=__common__( if(((real)c_unemp < 14.75), N362_5, N362_8));

N362_3 :=__common__( if(trim(C_UNEMP) != '', N362_4, 0.00017791539));

N362_2 :=__common__( if(((real)r_f00_input_dob_match_level_d < 3.5), 0.0091063511, N362_3));

N362_1 :=__common__( if(((real)r_f00_input_dob_match_level_d > NULL), N362_2, 0.0065439307));

N363_7 :=__common__( map(trim(C_INCOLLEGE) = ''              => 0.013180743,
              ((real)c_incollege < 4.94999980927) => 0.00062935229,
                                                     0.013180743));

N363_6 :=__common__( map(trim(C_HIGHINC) = ''              => -0.00014239541,
              ((real)c_highinc < 2.54999995232) => -0.003902579,
                                                   -0.00014239541));

N363_5 :=__common__( map(trim(C_POP00) = ''       => 0.0063391075,
              ((real)c_pop00 < 1193.5) => 0.00062096236,
                                          0.0063391075));

N363_4 :=__common__( map(trim(C_FINANCE) = ''              => -0.0017221792,
              ((real)c_finance < 2.04999995232) => N363_5,
                                                   -0.0017221792));

N363_3 :=__common__( map(trim(C_NEWHOUSE) = ''              => N363_6,
              ((real)c_newhouse < 5.14999961853) => N363_4,
                                                    N363_6));

N363_2 :=__common__( if(((real)c_construction < 38.25), N363_3, N363_7));

N363_1 :=__common__( if(trim(C_CONSTRUCTION) != '', N363_2, -0.0033498442));

N364_7 :=__common__( map(trim(C_BIGAPT_P) = ''              => 0.0048608234,
              ((real)c_bigapt_p < 21.5499992371) => -0.0033053667,
                                                    0.0048608234));

N364_6 :=__common__( map(trim(C_UNATTACH) = ''      => N364_7,
              ((real)c_unattach < 105.5) => 0.0069730577,
                                            N364_7));

N364_5 :=__common__( map(trim(C_HH4_P) = ''              => -0.0093351242,
              ((real)c_hh4_p < 16.6500015259) => N364_6,
                                                 -0.0093351242));

N364_4 :=__common__( map(trim(C_LOW_ED) = ''              => -0.0070012249,
              ((real)c_low_ed < 82.3500061035) => 0.0012776243,
                                                  -0.0070012249));

N364_3 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.0049994854,
              ((real)c_comb_age_d < 51.5)  => N364_4,
                                              -0.0049994854));

N364_2 :=__common__( if(((real)c_larceny < 174.5), N364_3, N364_5));

N364_1 :=__common__( if(trim(C_LARCENY) != '', N364_2, -6.9622915e-005));

N365_12 :=__common__( if(((real)c_amus_indx < 120.5), 0.00028845889, -0.005715095));

N365_11 :=__common__( if(trim(C_AMUS_INDX) != '', N365_12, 0.000610882));

N365_10 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d < 7.5), 0.0070802164, N365_11));

N365_9 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N365_10, 0.0014069166));

N365_8 :=__common__( map(((real)c_inf_fname_verd_d <= NULL) => -0.0042916087,
              ((real)c_inf_fname_verd_d < 0.5)   => N365_9,
                                                    -0.0042916087));

N365_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0162089187652), -0.012044643, 0.00041609519));

N365_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N365_7, 0.0043558029));

N365_5 :=__common__( if(((real)c_white_col < 22.8499984741), -0.0021940938, 0.0071848));

N365_4 :=__common__( if(trim(C_WHITE_COL) != '', N365_5, 0.019906407));

N365_3 :=__common__( if(((real)f_corrssnnamecount_d < 5.5), N365_4, N365_6));

N365_2 :=__common__( if(((real)f_corrssnnamecount_d > NULL), N365_3, -0.012068904));

N365_1 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), N365_2, N365_8));

N366_11 :=__common__( if(((integer)r_i60_inq_hiriskcred_recency_d < 549), -0.00017770965, -0.0051001757));

N366_10 :=__common__( if(((real)r_i60_inq_hiriskcred_recency_d > NULL), N366_11, -0.012530314));

N366_9 :=__common__( if(((real)f_rel_incomeover50_count_d < 1.5), 0.0057844129, -0.0048433073));

N366_8 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N366_9, 0.0080048086));

N366_7 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N366_8, -0.0021198811));

N366_6 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => N366_7,
              ((real)f_mos_inq_banko_cm_fseen_d < 70.5)  => 0.0026469544,
                                                            N366_7));

N366_5 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => 0.0065372833,
              ((real)f_prevaddrmedianincome_d < 60989.5) => N366_6,
                                                            0.0065372833));

N366_4 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 284.5), N366_5, -0.0031161095));

N366_3 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N366_4, 0.011729442));

N366_2 :=__common__( if(((real)c_trailer < 113.5), N366_3, N366_10));

N366_1 :=__common__( if(trim(C_TRAILER) != '', N366_2, 0.002778891));

N367_8 :=__common__( if(((real)f_srchfraudsrchcount_i < 17.5), -0.0035283984, 0.0042512315));

N367_7 :=__common__( if(((real)f_srchfraudsrchcount_i > NULL), N367_8, -0.020600483));

N367_6 :=__common__( map(trim(C_NEW_HOMES) = ''      => N367_7,
              ((real)c_new_homes < 138.5) => 0.0012642703,
                                             N367_7));

N367_5 :=__common__( map(trim(C_OCCUNIT_P) = ''              => -0.0093151405,
              ((real)c_occunit_p < 87.8500061035) => -0.00051910674,
                                                     -0.0093151405));

N367_4 :=__common__( map(trim(C_MANY_CARS) = ''     => N367_6,
              ((real)c_many_cars < 28.5) => N367_5,
                                            N367_6));

N367_3 :=__common__( map(trim(C_INC_100K_P) = ''              => N367_4,
              ((real)c_inc_100k_p < 2.95000004768) => 0.0049161687,
                                                      N367_4));

N367_2 :=__common__( if(((real)c_low_ed < 79.1499938965), N367_3, -0.0047243767));

N367_1 :=__common__( if(trim(C_LOW_ED) != '', N367_2, 0.0016686619));

N368_8 :=__common__( if(((real)r_c12_num_nonderogs_d < 10.5), 0.001102328, -0.0069196866));

N368_7 :=__common__( if(((real)r_c12_num_nonderogs_d > NULL), N368_8, -0.0036230669));

N368_6 :=__common__( map(trim(C_SPAN_LANG) = ''      => -0.0065591281,
              ((real)c_span_lang < 102.5) => -0.00038757498,
                                             -0.0065591281));

N368_5 :=__common__( map(trim(C_INC_35K_P) = ''      => 0.0063136157,
              ((real)c_inc_35k_p < 22.75) => N368_6,
                                             0.0063136157));

N368_4 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N368_5, 0.0067644583));

N368_3 :=__common__( map(trim(C_MED_AGE) = ''              => N368_4,
              ((real)c_med_age < 26.0499992371) => -0.0078931132,
                                                   N368_4));

N368_2 :=__common__( if(((real)c_inc_200k_p < 0.25), N368_3, N368_7));

N368_1 :=__common__( if(trim(C_INC_200K_P) != '', N368_2, -0.00052725893));

N369_9 :=__common__( map(((real)f_mos_liens_rel_cj_lseen_d <= NULL) => 0.0013913122,
              ((real)f_mos_liens_rel_cj_lseen_d < 127.5) => -0.0039667472,
                                                            0.0013913122));

N369_8 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N369_9, 0.0021945488));

N369_7 :=__common__( map(trim(C_BURGLARY) = ''      => -0.0068834424,
              ((real)c_burglary < 195.5) => N369_8,
                                            -0.0068834424));

N369_6 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => -0.0080874052,
              ((real)f_mos_inq_banko_cm_lseen_d < 22.5)  => 0.0045960815,
                                                            -0.0080874052));

N369_5 :=__common__( map(((real)r_i60_inq_mortgage_recency_d <= NULL)  => N369_7,
              ((integer)r_i60_inq_mortgage_recency_d < 549) => N369_6,
                                                               N369_7));

N369_4 :=__common__( if(trim(C_BURGLARY) != '', N369_5, 0.001415427));

N369_3 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => 0.0014492534,
              ((real)f_inq_per_ssn_i < 3.5)   => -0.010826381,
                                                 0.0014492534));

N369_2 :=__common__( if(((real)r_i60_inq_retail_recency_d < 61.5), N369_3, N369_4));

N369_1 :=__common__( if(((real)r_i60_inq_retail_recency_d > NULL), N369_2, 0.0045626462));

N370_8 :=__common__( map(trim(C_HVAL_125K_P) = ''              => -0.0055004495,
              ((real)c_hval_125k_p < 6.64999961853) => 0.0051761086,
                                                       -0.0055004495));

N370_7 :=__common__( map(trim(C_POPOVER18) = ''      => 0.011065304,
              ((real)c_popover18 < 974.5) => N370_8,
                                             0.011065304));

N370_6 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.008950597,
              ((real)f_add_curr_nhood_vac_pct_i < 0.0501141399145) => -0.0017524295,
                                                                      0.008950597));

N370_5 :=__common__( map(trim(C_BARGAINS) = ''      => N370_6,
              ((real)c_bargains < 178.5) => -0.0030810665,
                                            N370_6));

N370_4 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => -0.0022132554,
              ((real)f_add_curr_nhood_vac_pct_i < 0.0693611651659) => 0.0017239819,
                                                                      -0.0022132554));

N370_3 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N370_4, N370_5));

N370_2 :=__common__( if(((real)c_hval_80k_p < 33.25), N370_3, N370_7));

N370_1 :=__common__( if(trim(C_HVAL_80K_P) != '', N370_2, -0.0036184948));

N371_8 :=__common__( map(((real)f_rel_criminal_count_i <= NULL) => 0.00059454417,
              ((real)f_rel_criminal_count_i < 2.5)   => 0.0088466304,
                                                        0.00059454417));

N371_7 :=__common__( map(trim(C_FEMDIV_P) = ''     => -0.0010380579,
              ((real)c_femdiv_p < 3.25) => 0.0038795372,
                                           -0.0010380579));

N371_6 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => -0.0012062919,
              ((real)r_c13_avg_lres_d < 65.5)  => -0.0084527422,
                                                  -0.0012062919));

N371_5 :=__common__( map(trim(C_HHSIZE) = ''              => N371_6,
              ((real)c_hhsize < 2.26499986649) => 0.0034648103,
                                                  N371_6));

N371_4 :=__common__( if(((real)c_popover25 < 613.5), N371_5, N371_7));

N371_3 :=__common__( if(trim(C_POPOVER25) != '', N371_4, 0.0016654995));

N371_2 :=__common__( if(((real)r_d32_criminal_count_i < 1.5), N371_3, N371_8));

N371_1 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N371_2, -0.0035514908));

N372_8 :=__common__( if(((real)c_hh4_p < 8.14999961853), 0.014184843, 0.0031103091));

N372_7 :=__common__( if(trim(C_HH4_P) != '', N372_8, 0.0048695666));

N372_6 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => 0.0093073621,
              ((real)f_m_bureau_adl_fs_all_d < 80.5)  => -0.00047099902,
                                                         0.0093073621));

N372_5 :=__common__( if(((real)c_blue_empl < 161.5), N372_6, -0.010053807));

N372_4 :=__common__( if(trim(C_BLUE_EMPL) != '', N372_5, -0.0023817285));

N372_3 :=__common__( if(((real)f_rel_felony_count_i < 0.5), N372_4, N372_7));

N372_2 :=__common__( if(((real)f_rel_felony_count_i > NULL), N372_3, 0.015516387));

N372_1 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.00066727426,
              ((real)c_comb_age_d < 25.5)  => N372_2,
                                              -0.00066727426));

N373_8 :=__common__( map(((real)f_liens_unrel_sc_total_amt_i <= NULL)   => 0.0085330956,
              ((integer)f_liens_unrel_sc_total_amt_i < 5043) => -0.00079111878,
                                                                0.0085330956));

N373_7 :=__common__( map(((real)r_s66_adlperssn_count_i <= NULL) => 0.013513189,
              ((real)r_s66_adlperssn_count_i < 1.5)   => 0.0021719219,
                                                         0.013513189));

N373_6 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => 0.0026681368,
              ((integer)f_curraddrcartheftindex_i < 91) => -0.0041966633,
                                                           0.0026681368));

N373_5 :=__common__( map(trim(C_HVAL_400K_P) = ''     => N373_7,
              ((real)c_hval_400k_p < 8.75) => N373_6,
                                              N373_7));

N373_4 :=__common__( if(((real)r_c20_email_count_i < 0.5), N373_5, N373_8));

N373_3 :=__common__( if(((real)r_c20_email_count_i > NULL), N373_4, 0.0055665264));

N373_2 :=__common__( if(((real)c_vacant_p < 5.25), -0.0040089138, N373_3));

N373_1 :=__common__( if(trim(C_VACANT_P) != '', N373_2, -0.00042667771));

N374_9 :=__common__( if(((real)c_hval_125k_p < 24.4500007629), -0.0019245872, 0.0076357098));

N374_8 :=__common__( if(trim(C_HVAL_125K_P) != '', N374_9, -0.0010400092));

N374_7 :=__common__( if(((integer)r_a46_curr_avm_autoval_d < 56788), 0.0049790486, -0.0041753008));

N374_6 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N374_7, N374_8));

N374_5 :=__common__( map(trim(C_POP00) = ''       => 0.0045003436,
              ((real)c_pop00 < 2258.5) => -0.00043381291,
                                          0.0045003436));

N374_4 :=__common__( map(((real)f_divaddrsuspidcountnew_i <= NULL) => 0.0050207136,
              ((real)f_divaddrsuspidcountnew_i < 1.5)   => N374_5,
                                                           0.0050207136));

N374_3 :=__common__( map(((real)f_util_adl_count_n <= NULL) => 0.0031354707,
              ((real)f_util_adl_count_n < 6.5)   => -0.0069213862,
                                                    0.0031354707));

N374_2 :=__common__( if(((real)f_addrchangeincomediff_d < -22884.5), N374_3, N374_4));

N374_1 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N374_2, N374_6));

N375_9 :=__common__( map(trim(C_FAMOTF18_P) = ''              => -0.0093255897,
              ((real)c_famotf18_p < 33.8499984741) => -0.0020633655,
                                                      -0.0093255897));

N375_8 :=__common__( map(trim(C_INC_75K_P) = ''              => N375_9,
              ((real)c_inc_75k_p < 9.44999980927) => 0.0061956991,
                                                     N375_9));

N375_7 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => 0.0013626881,
              ((real)r_d32_mos_since_crim_ls_d < 25.5)  => 0.010391275,
                                                           0.0013626881));

N375_6 :=__common__( map(trim(C_ASIAN_LANG) = ''      => 0.0055614935,
              ((real)c_asian_lang < 124.5) => -0.0054031105,
                                              0.0055614935));

N375_5 :=__common__( if(((real)c_dist_best_to_prev_addr_i < 2.5), N375_6, N375_7));

N375_4 :=__common__( if(((real)c_dist_best_to_prev_addr_i > NULL), N375_5, 0.0031902874));

N375_3 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), 0.00073693895, N375_4));

N375_2 :=__common__( if(((real)c_wholesale < 2.04999995232), N375_3, N375_8));

N375_1 :=__common__( if(trim(C_WHOLESALE) != '', N375_2, -0.0025081373));

N376_9 :=__common__( if(((real)r_l79_adls_per_addr_curr_i < 39.5), 0.00077603485, 0.0055273418));

N376_8 :=__common__( if(((real)r_l79_adls_per_addr_curr_i > NULL), N376_9, -0.030236822));

N376_7 :=__common__( map(trim(C_LARCENY) = ''      => -0.0014191199,
              ((real)c_larceny < 142.5) => 0.011511706,
                                           -0.0014191199));

N376_6 :=__common__( map(trim(C_SERV_EMPL) = ''      => N376_7,
              ((real)c_serv_empl < 180.5) => -0.0024568025,
                                             N376_7));

N376_5 :=__common__( map(trim(C_INC_125K_P) = ''      => 0.0070632064,
              ((real)c_inc_125k_p < 13.75) => N376_6,
                                              0.0070632064));

N376_4 :=__common__( if(((integer)c_totsales < 106872), N376_5, -0.011970255));

N376_3 :=__common__( if(trim(C_TOTSALES) != '', N376_4, 0.001962419));

N376_2 :=__common__( if(((real)f_prevaddrcartheftindex_i < 110.5), N376_3, N376_8));

N376_1 :=__common__( if(((real)f_prevaddrcartheftindex_i > NULL), N376_2, -0.0093403804));

N377_8 :=__common__( map(trim(C_RENTAL) = ''      => 0.0055909534,
              ((real)c_rental < 184.5) => -0.0050910923,
                                          0.0055909534));

N377_7 :=__common__( if(((real)c_addr_lres_6mo_ct_i < 1.5), 0.0058611549, 8.3020415e-005));

N377_6 :=__common__( if(((real)c_addr_lres_6mo_ct_i > NULL), N377_7, -0.017245547));

N377_5 :=__common__( map(trim(C_POP_6_11_P) = ''              => N377_6,
              ((real)c_pop_6_11_p < 8.64999961853) => -0.0010572966,
                                                      N377_6));

N377_4 :=__common__( map(trim(C_SPAN_LANG) = ''      => N377_8,
              ((real)c_span_lang < 163.5) => N377_5,
                                             N377_8));

N377_3 :=__common__( map(trim(C_HOUSINGCPI) = ''              => 0.0093934397,
              ((real)c_housingcpi < 238.450012207) => N377_4,
                                                      0.0093934397));

N377_2 :=__common__( if(((real)c_cpiall < 225.450012207), N377_3, -0.010068853));

N377_1 :=__common__( if(trim(C_CPIALL) != '', N377_2, 0.0068460609));

N378_8 :=__common__( map(((real)f_varrisktype_i <= NULL) => 0.00042486711,
              ((real)f_varrisktype_i < 4.5)   => 0.010489527,
                                                 0.00042486711));

N378_7 :=__common__( if(((real)c_no_teens < 91.5), -0.0046569362, 0.0052724995));

N378_6 :=__common__( if(trim(C_NO_TEENS) != '', N378_7, 0.0068263993));

N378_5 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => N378_8,
              ((real)r_c14_addrs_15yr_i < 10.5)  => N378_6,
                                                    N378_8));

N378_4 :=__common__( map(((real)f_rel_ageover30_count_d <= NULL) => -0.0020841337,
              ((real)f_rel_ageover30_count_d < 7.5)   => 0.0010537619,
                                                         -0.0020841337));

N378_3 :=__common__( map(((real)f_rel_under25miles_cnt_d <= NULL) => 0.0046351929,
              ((real)f_rel_under25miles_cnt_d < 25.5)  => N378_4,
                                                          0.0046351929));

N378_2 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => N378_5,
              ((real)f_inq_other_count24_i < 2.5)   => N378_3,
                                                       N378_5));

N378_1 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N378_2, 0.0052299763));

N379_10 :=__common__( if(((real)f_rel_under25miles_cnt_d < 4.5), -0.011829786, -0.0015314414));

N379_9 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N379_10, -0.0031485684));

N379_8 :=__common__( map(((real)r_c20_email_domain_isp_count_i <= NULL) => -0.0063340292,
              ((real)r_c20_email_domain_isp_count_i < 3.5)   => 0.000400998,
                                                                -0.0063340292));

N379_7 :=__common__( if(((real)f_rel_ageover30_count_d < 1.5), 0.0057249088, N379_8));

N379_6 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N379_7, 0.0049072915));

N379_5 :=__common__( map(trim(C_HVAL_40K_P) = ''              => N379_9,
              ((real)c_hval_40k_p < 17.5499992371) => N379_6,
                                                      N379_9));

N379_4 :=__common__( map(trim(C_HH6_P) = ''      => 0.0078011657,
              ((real)c_hh6_p < 13.25) => N379_5,
                                         0.0078011657));

N379_3 :=__common__( if(((real)f_liens_rel_cj_total_amt_i < 742.5), N379_4, -0.0060267724));

N379_2 :=__common__( if(((real)f_liens_rel_cj_total_amt_i > NULL), N379_3, 0.0043777767));

N379_1 :=__common__( if(trim(C_HH6_P) != '', N379_2, -0.0010190416));

N380_9 :=__common__( if(((real)c_unattach < 151.5), 0.0014520127, -0.0045267579));

N380_8 :=__common__( if(trim(C_UNATTACH) != '', N380_9, 0.00057277449));

N380_7 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => 0.012608586,
              ((real)f_mos_inq_banko_om_lseen_d < 30.5)  => -0.00013952361,
                                                            0.012608586));

N380_6 :=__common__( map(((real)c_comb_age_d <= NULL) => N380_8,
              ((real)c_comb_age_d < 27.5)  => N380_7,
                                              N380_8));

N380_5 :=__common__( if(((real)c_hval_40k_p < 9.25), 0.0017845834, -0.0068436122));

N380_4 :=__common__( if(trim(C_HVAL_40K_P) != '', N380_5, 0.013707543));

N380_3 :=__common__( map((fp_segment in ['2 NAS 479', '3 New DID', '4 Bureau Only', '6 Recent Activity']) => -0.0047176921,
              (fp_segment in ['1 SSN Prob', '5 Derog', '7 Other'])                             => N380_4,
                                                                                                  -0.0047176921));

N380_2 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 114.5), N380_3, N380_6));

N380_1 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N380_2, -0.0012853478));

N381_9 :=__common__( map(trim(C_HH2_P) = ''              => 0.00020300278,
              ((real)c_hh2_p < 34.5499992371) => 0.011482299,
                                                 0.00020300278));

N381_8 :=__common__( if(((real)c_white_col < 26.5499992371), -0.00073017201, N381_9));

N381_7 :=__common__( if(trim(C_WHITE_COL) != '', N381_8, 0.026861075));

N381_6 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL)  => 0.009236975,
              ((real)r_a50_pb_total_dollars_d < 5449.5) => -0.00118807,
                                                           0.009236975));

N381_5 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => -0.00077154603,
              ((real)r_c21_m_bureau_adl_fs_d < 11.5)  => 0.0079171323,
                                                         -0.00077154603));

N381_4 :=__common__( if(((real)c_hval_175k_p < 24.4500007629), N381_5, N381_6));

N381_3 :=__common__( if(trim(C_HVAL_175K_P) != '', N381_4, -9.6900678e-006));

N381_2 :=__common__( if(((real)f_srchfraudsrchcountmo_i < 0.5), N381_3, N381_7));

N381_1 :=__common__( if(((real)f_srchfraudsrchcountmo_i > NULL), N381_2, 0.0015593489));

N382_9 :=__common__( if(((real)c_unemp < 5.14999961853), 0.00083228365, -0.0041934996));

N382_8 :=__common__( if(trim(C_UNEMP) != '', N382_9, -0.0076630454));

N382_7 :=__common__( map(trim(C_RNT750_P) = ''     => 0.0091808014,
              ((real)c_rnt750_p < 44.5) => 0.0007644211,
                                           0.0091808014));

N382_6 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => 0.0097139658,
              ((real)f_sourcerisktype_i < 6.5)   => N382_7,
                                                    0.0097139658));

N382_5 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL)  => 0.00052115949,
              ((integer)r_d33_eviction_recency_d < 549) => N382_6,
                                                           0.00052115949));

N382_4 :=__common__( if(((real)c_easiqlife < 70.5), -0.0025469159, N382_5));

N382_3 :=__common__( if(trim(C_EASIQLIFE) != '', N382_4, -0.00032488876));

N382_2 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 6.5), N382_3, N382_8));

N382_1 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N382_2, -0.0014640602));

N383_8 :=__common__( map(trim(C_HIGH_ED) = ''              => 0.0021697753,
              ((real)c_high_ed < 11.9499998093) => 0.0078328588,
                                                   0.0021697753));

N383_7 :=__common__( map((segment in ['RETAIL', 'SEARS SHO'])              => -0.0080114302,
              (segment in ['KMART', 'SEARS AUTO', 'SEARS FLS']) => N383_8,
                                                                   N383_8));

N383_6 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => N383_7,
              ((integer)r_i60_inq_auto_recency_d < 549) => -0.0053142442,
                                                           N383_7));

N383_5 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.0002086449,
              ((real)r_c20_email_count_i < 0.5)   => N383_6,
                                                     -0.0002086449));

N383_4 :=__common__( if(((real)c_rentocc_p < 55.3499984741), N383_5, -0.002209795));

N383_3 :=__common__( if(trim(C_RENTOCC_P) != '', N383_4, 0.0014621542));

N383_2 :=__common__( if(((real)r_d31_bk_filing_count_i < 2.5), N383_3, 0.0093881371));

N383_1 :=__common__( if(((real)r_d31_bk_filing_count_i > NULL), N383_2, 0.0027435698));

N384_8 :=__common__( map(trim(C_RNT500_P) = ''              => 0.012194722,
              ((real)c_rnt500_p < 10.5500001907) => 7.898771e-005,
                                                    0.012194722));

N384_7 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL) => 0.013291446,
              ((real)f_curraddrcrimeindex_i < 152.5) => 0.0014464566,
                                                        0.013291446));

N384_6 :=__common__( map(((real)f_srchphonesrchcount_i <= NULL) => -0.0024038157,
              ((real)f_srchphonesrchcount_i < 0.5)   => N384_7,
                                                        -0.0024038157));

N384_5 :=__common__( if(((real)r_d32_criminal_count_i < 0.5), N384_6, N384_8));

N384_4 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N384_5, 0.0098522026));

N384_3 :=__common__( map(trim(C_SPAN_LANG) = ''      => -0.0054202242,
              ((real)c_span_lang < 143.5) => N384_4,
                                             -0.0054202242));

N384_2 :=__common__( if(((real)c_cpiall < 208.5), N384_3, -0.00053610268));

N384_1 :=__common__( if(trim(C_CPIALL) != '', N384_2, 0.0027393782));

N385_9 :=__common__( map(((real)f_assocrisktype_i <= NULL) => -0.0013656775,
              ((real)f_assocrisktype_i < 4.5)   => -0.010491462,
                                                   -0.0013656775));

N385_8 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)    => 0.0015884177,
              ((real)f_prevaddrmedianvalue_d < 117029.5) => -0.0031460235,
                                                            0.0015884177));

N385_7 :=__common__( if(((real)c_span_lang < 88.5), 0.002601442, N385_8));

N385_6 :=__common__( if(trim(C_SPAN_LANG) != '', N385_7, -0.0016707303));

N385_5 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 6.5), N385_6, N385_9));

N385_4 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N385_5, -0.0010191256));

N385_3 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => -0.00033039075,
              ((real)f_add_input_nhood_vac_pct_i < 0.0537379197776) => 0.012624666,
                                                                       -0.00033039075));

N385_2 :=__common__( if(((real)r_a50_pb_average_dollars_d < 13.5), N385_3, N385_4));

N385_1 :=__common__( if(((real)r_a50_pb_average_dollars_d > NULL), N385_2, 0.0026081149));

N386_10 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => -0.0033841207,
               ((real)f_mos_inq_banko_om_fseen_d < 34.5)  => 0.0008303059,
                                                             -0.0033841207));

N386_9 :=__common__( if(((real)c_inc_50k_p < 20.6500015259), N386_10, 0.0030029021));

N386_8 :=__common__( if(trim(C_INC_50K_P) != '', N386_9, -0.0038765768));

N386_7 :=__common__( if(((real)c_hval_80k_p < 9.05000019073), 0.0021649673, -0.0048922317));

N386_6 :=__common__( if(trim(C_HVAL_80K_P) != '', N386_7, 0.0075617457));

N386_5 :=__common__( if(((real)c_easiqlife < 102.5), -0.00091619577, 0.0086466212));

N386_4 :=__common__( if(trim(C_EASIQLIFE) != '', N386_5, 0.00030501398));

N386_3 :=__common__( map(((real)f_adl_util_conv_n <= NULL) => N386_6,
              ((real)f_adl_util_conv_n < 0.5)   => N386_4,
                                                   N386_6));

N386_2 :=__common__( if(((real)f_corrssnaddrcount_d < 2.5), N386_3, N386_8));

N386_1 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N386_2, 0.0095045291));

N387_11 :=__common__( if(((real)c_many_cars < 49.5), 0.01261, 0.00081852616));

N387_10 :=__common__( if(trim(C_MANY_CARS) != '', N387_11, 0.014573827));

N387_9 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => -0.001200312,
              ((real)r_a50_pb_average_dollars_d < 17.5)  => N387_10,
                                                            -0.001200312));

N387_8 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N387_9, 0.00015787751));

N387_7 :=__common__( if(((real)f_varmsrcssncount_i < 2.5), N387_8, 0.005401321));

N387_6 :=__common__( if(((real)f_varmsrcssncount_i > NULL), N387_7, 0.0029746199));

N387_5 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), -0.013441919, -0.00044679286));

N387_4 :=__common__( if(((real)c_easiqlife < 80.5), N387_5, 0.00093471323));

N387_3 :=__common__( if(trim(C_EASIQLIFE) != '', N387_4, -0.0015072166));

N387_2 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i < 3.5), N387_3, 0.0078625164));

N387_1 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), N387_2, N387_6));

N388_7 :=__common__( map(trim(C_HHSIZE) = ''              => -0.0047815043,
              ((real)c_hhsize < 2.80499982834) => 0.0050831079,
                                                  -0.0047815043));

N388_6 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => 0.010330076,
              ((real)f_m_bureau_adl_fs_all_d < 217.5) => N388_7,
                                                         0.010330076));

N388_5 :=__common__( map(trim(C_MINING) = ''               => -0.0087580291,
              ((real)c_mining < 0.350000023842) => 0.00049405939,
                                                   -0.0087580291));

N388_4 :=__common__( map(trim(C_SPAN_LANG) = ''      => -0.0074465422,
              ((real)c_span_lang < 191.5) => N388_5,
                                             -0.0074465422));

N388_3 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => N388_6,
              ((real)r_l79_adls_per_addr_curr_i < 37.5)  => N388_4,
                                                            N388_6));

N388_2 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.0066312694,
              ((real)c_comb_age_d < 56.5)  => N388_3,
                                              -0.0066312694));

N388_1 :=__common__( if(trim(C_MINING) != '', N388_2, 0.0029565371));

N389_8 :=__common__( map(trim(C_POPOVER25) = ''      => -0.00022316414,
              ((real)c_popover25 < 658.5) => -0.0061397409,
                                             -0.00022316414));

N389_7 :=__common__( map(trim(C_NO_LABFOR) = ''     => 0.0013293679,
              ((real)c_no_labfor < 19.5) => -0.0098928937,
                                            0.0013293679));

N389_6 :=__common__( map(trim(C_FAMMAR18_P) = ''              => N389_7,
              ((real)c_fammar18_p < 3.84999990463) => -0.0072699214,
                                                      N389_7));

N389_5 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.011819853,
              ((real)r_d32_criminal_count_i < 2.5)   => 0.0031219314,
                                                        0.011819853));

N389_4 :=__common__( if(((real)f_rel_incomeover25_count_d < 5.5), N389_5, N389_6));

N389_3 :=__common__( if(((real)f_rel_incomeover25_count_d > NULL), N389_4, 0.00085871485));

N389_2 :=__common__( if(((real)c_retail < 10.4499998093), N389_3, N389_8));

N389_1 :=__common__( if(trim(C_RETAIL) != '', N389_2, -0.0022216691));

N390_9 :=__common__( map(((real)f_vardobcountnew_i <= NULL) => 0.00018466291,
              ((real)f_vardobcountnew_i < 0.5)   => 0.013222145,
                                                    0.00018466291));

N390_8 :=__common__( map(((real)r_i60_inq_recency_d <= NULL) => N390_9,
              ((real)r_i60_inq_recency_d < 4.5)   => -0.0041430426,
                                                     N390_9));

N390_7 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.00081751471,
              ((real)f_add_curr_nhood_vac_pct_i < 0.0765243247151) => -0.0088310852,
                                                                      0.00081751471));

N390_6 :=__common__( if(((real)c_pop_35_44_p < 13.6499996185), N390_7, N390_8));

N390_5 :=__common__( if(trim(C_POP_35_44_P) != '', N390_6, 0.011063197));

N390_4 :=__common__( if(((real)r_c13_avg_lres_d < 37.5), N390_5, 0.0034890816));

N390_3 :=__common__( if(((real)r_c13_avg_lres_d > NULL), N390_4, -0.010300176));

N390_2 :=__common__( if(((real)r_l79_adls_per_addr_c6_i < 1.5), -0.00088743544, N390_3));

N390_1 :=__common__( if(((real)r_l79_adls_per_addr_c6_i > NULL), N390_2, 0.0099328691));

N391_9 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => 0.0080381348,
              ((real)f_corrssnaddrcount_d < 3.5)   => -0.0032344455,
                                                      0.0080381348));

N391_8 :=__common__( map(((real)r_c20_email_count_i <= NULL) => N391_9,
              ((real)r_c20_email_count_i < 2.5)   => 0.010673543,
                                                     N391_9));

N391_7 :=__common__( map(((real)f_rel_under25miles_cnt_d <= NULL) => 0.0010322654,
              ((real)f_rel_under25miles_cnt_d < 4.5)   => -0.0026159247,
                                                          0.0010322654));

N391_6 :=__common__( if(((real)c_hval_175k_p < 26.0499992371), N391_7, 0.006704573));

N391_5 :=__common__( if(trim(C_HVAL_175K_P) != '', N391_6, -0.0023861905));

N391_4 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N391_5, 0.0016761796));

N391_3 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => N391_8,
              ((real)f_inq_other_count24_i < 3.5)   => N391_4,
                                                       N391_8));

N391_2 :=__common__( if(((real)r_a44_curr_add_naprop_d < 1.5), N391_3, -0.0044440627));

N391_1 :=__common__( if(((real)r_a44_curr_add_naprop_d > NULL), N391_2, -0.0029896747));

N392_9 :=__common__( map((fp_segment in ['2 NAS 479', '3 New DID', '5 Derog'])                           => -0.0069258126,
              (fp_segment in ['1 SSN Prob', '4 Bureau Only', '6 Recent Activity', '7 Other']) => 0.0067945758,
                                                                                                 0.0067945758));

N392_8 :=__common__( if(((real)f_rel_ageover30_count_d < 7.5), 0.0019635637, -0.0011331943));

N392_7 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N392_8, -0.00041209646));

N392_6 :=__common__( if(((real)c_cpiall < 222.949996948), N392_7, -0.0084044034));

N392_5 :=__common__( if(trim(C_CPIALL) != '', N392_6, -0.0038815245));

N392_4 :=__common__( map((fp_segment in ['3 New DID', '4 Bureau Only', '5 Derog', '6 Recent Activity', '7 Other']) => N392_5,
              (fp_segment in ['1 SSN Prob', '2 NAS 479'])                                               => 0.011106012,
                                                                                                           N392_5));

N392_3 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N392_9,
              ((integer)c_hist_addr_match_i < 28) => N392_4,
                                                     N392_9));

N392_2 :=__common__( if(((real)f_corrssnaddrcount_d < 0.5), 0.004112409, N392_3));

N392_1 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N392_2, -0.0017179406));

N393_9 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.0178694240749), 0.0090130474, -0.0011188929));

N393_8 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N393_9, 0.0016652809));

N393_7 :=__common__( if(((real)c_hh7p_p < 3.04999995232), N393_8, -0.0066678008));

N393_6 :=__common__( if(trim(C_HH7P_P) != '', N393_7, 0.0045244035));

N393_5 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => 0.0017650542,
              ((real)c_dist_best_to_prev_addr_i < 1.5)   => N393_6,
                                                            0.0017650542));

N393_4 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.0073725196,
              ((real)r_d32_criminal_count_i < 16.5)  => N393_5,
                                                        0.0073725196));

N393_3 :=__common__( map(((real)r_i60_inq_mortgage_recency_d <= NULL)  => N393_4,
              ((integer)r_i60_inq_mortgage_recency_d < 549) => -0.0047070718,
                                                               N393_4));

N393_2 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0162844359875), -0.002705707, N393_3));

N393_1 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N393_2, -0.0013273772));

N394_8 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => 0.00035667869,
              ((real)r_c21_m_bureau_adl_fs_d < 170.5) => 0.0087121354,
                                                         0.00035667869));

N394_7 :=__common__( if(((real)c_sub_bus < 167.5), -0.0043881529, 0.0032888711));

N394_6 :=__common__( if(trim(C_SUB_BUS) != '', N394_7, -0.0031718644));

N394_5 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => N394_8,
              ((real)f_m_bureau_adl_fs_all_d < 166.5) => N394_6,
                                                         N394_8));

N394_4 :=__common__( map(((real)r_phn_pcs_n <= NULL) => -0.0026034952,
              ((real)r_phn_pcs_n < 0.5)   => 0.0034651989,
                                             -0.0026034952));

N394_3 :=__common__( map(((real)r_c18_invalid_addrs_per_adl_i <= NULL) => N394_5,
              ((real)r_c18_invalid_addrs_per_adl_i < 0.5)   => N394_4,
                                                               N394_5));

N394_2 :=__common__( if(((real)f_liens_unrel_o_total_amt_i < 1315.5), N394_3, -0.0075037717));

N394_1 :=__common__( if(((real)f_liens_unrel_o_total_amt_i > NULL), N394_2, 0.0023038021));

N395_9 :=__common__( map(trim(C_SUB_BUS) = ''      => -0.003701438,
              ((real)c_sub_bus < 123.5) => 0.0035185232,
                                           -0.003701438));

N395_8 :=__common__( map(((real)f_componentcharrisktype_i <= NULL) => 0.0067839463,
              ((real)f_componentcharrisktype_i < 5.5)   => N395_9,
                                                           0.0067839463));

N395_7 :=__common__( if(((real)c_pop_45_54_p < 15.9499998093), -0.00079344073, N395_8));

N395_6 :=__common__( if(trim(C_POP_45_54_P) != '', N395_7, -0.00036570638));

N395_5 :=__common__( map(trim(C_OLD_HOMES) = ''      => -0.011209939,
              ((real)c_old_homes < 164.5) => -0.00097359514,
                                             -0.011209939));

N395_4 :=__common__( if(((real)c_white_col < 18.1500015259), -0.010727127, N395_5));

N395_3 :=__common__( if(trim(C_WHITE_COL) != '', N395_4, 0.0047849671));

N395_2 :=__common__( if(((real)f_historical_count_d < 0.5), N395_3, N395_6));

N395_1 :=__common__( if(((real)f_historical_count_d > NULL), N395_2, 0.0043795361));

N396_8 :=__common__( map(trim(C_BIGAPT_P) = ''              => 0.0063380564,
              ((real)c_bigapt_p < 1.34999990463) => -0.0044919945,
                                                    0.0063380564));

N396_7 :=__common__( map(trim(C_RETIRED2) = ''      => -0.0091576846,
              ((real)c_retired2 < 126.5) => N396_8,
                                            -0.0091576846));

N396_6 :=__common__( if(((real)f_rel_under100miles_cnt_d < 18.5), N396_7, 0.0081631656));

N396_5 :=__common__( if(((real)f_rel_under100miles_cnt_d > NULL), N396_6, -0.008862432));

N396_4 :=__common__( map(trim(C_MEDI_INDX) = ''      => N396_5,
              ((real)c_medi_indx < 101.5) => 0.0070380055,
                                             N396_5));

N396_3 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), -0.00098108402, 0.0035169983));

N396_2 :=__common__( if(((real)c_relig_indx < 167.5), N396_3, N396_4));

N396_1 :=__common__( if(trim(C_RELIG_INDX) != '', N396_2, 0.00095341181));

N397_8 :=__common__( map(((real)f_srchunvrfdssncount_i <= NULL) => 0.0042304691,
              ((real)f_srchunvrfdssncount_i < 0.5)   => -0.00022924074,
                                                        0.0042304691));

N397_7 :=__common__( map(((real)f_inq_count24_i <= NULL) => -0.0097650851,
              ((real)f_inq_count24_i < 3.5)   => -0.0034508061,
                                                 -0.0097650851));

N397_6 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 4.693288e-005,
              ((real)f_add_curr_nhood_vac_pct_i < 0.0956356823444) => N397_7,
                                                                      4.693288e-005));

N397_5 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => 0.00017208259,
              ((real)f_m_bureau_adl_fs_all_d < 175.5) => N397_6,
                                                         0.00017208259));

N397_4 :=__common__( if(((real)c_oldhouse < 20.75), 0.0074689847, N397_5));

N397_3 :=__common__( if(trim(C_OLDHOUSE) != '', N397_4, -0.0044688998));

N397_2 :=__common__( if(((real)f_srchfraudsrchcount_i < 7.5), N397_3, N397_8));

N397_1 :=__common__( if(((real)f_srchfraudsrchcount_i > NULL), N397_2, -0.0049310438));

N398_9 :=__common__( map(trim(C_HH5_P) = ''              => 0.005728198,
              ((real)c_hh5_p < 6.64999961853) => -0.0018906086,
                                                 0.005728198));

N398_8 :=__common__( map(trim(C_CIV_EMP) = ''              => N398_9,
              ((real)c_civ_emp < 41.9500007629) => -0.01012239,
                                                   N398_9));

N398_7 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0247963294387), -0.0067463807, N398_8));

N398_6 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N398_7, 0.0030437504));

N398_5 :=__common__( map(trim(C_BIGAPT_P) = ''              => 0.004378197,
              ((real)c_bigapt_p < 14.6499996185) => 0.0001139393,
                                                    0.004378197));

N398_4 :=__common__( if(((real)f_liens_unrel_cj_total_amt_i < 721.5), N398_5, N398_6));

N398_3 :=__common__( if(((real)f_liens_unrel_cj_total_amt_i > NULL), N398_4, -0.0020179358));

N398_2 :=__common__( if(((real)c_civ_emp < 74.6499938965), N398_3, -0.010236397));

N398_1 :=__common__( if(trim(C_CIV_EMP) != '', N398_2, 0.00090562446));

N399_8 :=__common__( map(((real)r_c20_email_count_i <= NULL) => -0.0003201993,
              ((real)r_c20_email_count_i < 0.5)   => 0.0029443829,
                                                     -0.0003201993));

N399_7 :=__common__( map(trim(C_HVAL_150K_P) = ''              => 0.0073929594,
              ((real)c_hval_150k_p < 2.95000004768) => -0.0032573984,
                                                       0.0073929594));

N399_6 :=__common__( map(trim(C_OLD_HOMES) = ''     => N399_7,
              ((real)c_old_homes < 59.5) => -0.0064933778,
                                            N399_7));

N399_5 :=__common__( map(trim(C_BLUE_EMPL) = ''      => N399_6,
              ((real)c_blue_empl < 128.5) => -0.0055821116,
                                             N399_6));

N399_4 :=__common__( if(((real)c_sfdu_p < 96.6499938965), N399_5, 0.0053679442));

N399_3 :=__common__( if(trim(C_SFDU_P) != '', N399_4, -0.0010333187));

N399_2 :=__common__( if(((real)r_c13_max_lres_d < 54.5), N399_3, N399_8));

N399_1 :=__common__( if(((real)r_c13_max_lres_d > NULL), N399_2, -0.0098501874));

N400_9 :=__common__( map(trim(C_HH7P_P) = ''              => -0.009942085,
              ((real)c_hh7p_p < 1.34999990463) => -0.0011841715,
                                                  -0.009942085));

N400_8 :=__common__( if(((real)c_rnt500_p < 57.6500015259), -0.00017828223, N400_9));

N400_7 :=__common__( if(trim(C_RNT500_P) != '', N400_8, 0.002699699));

N400_6 :=__common__( if(((real)f_curraddractivephonelist_d > NULL), N400_7, 0.0037461513));

N400_5 :=__common__( map(((real)r_c15_ssns_per_adl_i <= NULL) => 0.0085960356,
              ((real)r_c15_ssns_per_adl_i < 4.5)   => N400_6,
                                                      0.0085960356));

N400_4 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => N400_5,
              ((real)r_a50_pb_average_dollars_d < 7.5)   => 0.007790072,
                                                            N400_5));

N400_3 :=__common__( map(((real)f_srchphonesrchcountwk_i <= NULL) => 0.0077106361,
              ((real)f_srchphonesrchcountwk_i < 0.5)   => N400_4,
                                                          0.0077106361));

N400_2 :=__common__( if(((real)r_c15_ssns_per_adl_c6_i < 0.5), N400_3, 0.0086865304));

N400_1 :=__common__( if(((real)r_c15_ssns_per_adl_c6_i > NULL), N400_2, 0.0031338945));

N401_8 :=__common__( map((fp_segment in ['7 Other'])                                                                               => -0.0074308849,
              (fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '4 Bureau Only', '5 Derog', '6 Recent Activity']) => 0.0070059017,
                                                                                                                           0.0070059017));

N401_7 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => N401_8,
              ((real)r_c13_max_lres_d < 56.5)  => -0.0068608453,
                                                  N401_8));

N401_6 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => 0.0086969297,
              ((real)f_mos_inq_banko_cm_lseen_d < 35.5)  => N401_7,
                                                            0.0086969297));

N401_5 :=__common__( if(((real)c_low_ed < 66.5500030518), 0.00020306854, N401_6));

N401_4 :=__common__( if(trim(C_LOW_ED) != '', N401_5, 0.0060177418));

N401_3 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => -0.0015497686,
              ((real)f_mos_inq_banko_cm_fseen_d < 70.5)  => N401_4,
                                                            -0.0015497686));

N401_2 :=__common__( if(((real)f_prevaddrageoldest_d < 146.5), N401_3, -0.0045416714));

N401_1 :=__common__( if(((real)f_prevaddrageoldest_d > NULL), N401_2, 0.0033196054));

N402_9 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d < 28.5), 0.010687224, -0.00011305704));

N402_8 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d > NULL), N402_9, 0.027172683));

N402_7 :=__common__( if(((real)f_srchaddrsrchcount_i < 13.5), -0.00012260352, 0.0088604036));

N402_6 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N402_7, 0.00086894558));

N402_5 :=__common__( map(trim(C_RELIG_INDX) = ''      => N402_6,
              ((real)c_relig_indx < 169.5) => -0.0013132463,
                                              N402_6));

N402_4 :=__common__( map(trim(C_HVAL_175K_P) = ''              => N402_8,
              ((real)c_hval_175k_p < 25.4500007629) => N402_5,
                                                       N402_8));

N402_3 :=__common__( map(trim(C_CIV_EMP) = ''              => N402_4,
              ((real)c_civ_emp < 33.8499984741) => 0.0071552116,
                                                   N402_4));

N402_2 :=__common__( if(((real)c_health < 86.25), N402_3, -0.0074698891));

N402_1 :=__common__( if(trim(C_HEALTH) != '', N402_2, 0.0038304317));

N403_9 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => 0.0011428132,
              ((real)f_prevaddrmedianincome_d < 33224.5) => -0.0084448287,
                                                            0.0011428132));

N403_8 :=__common__( map(trim(C_FOOD) = ''              => N403_9,
              ((real)c_food < 13.0500001907) => 0.0067947884,
                                                N403_9));

N403_7 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N403_8, 0.0014922677));

N403_6 :=__common__( map(((real)c_unique_addr_count_i <= NULL) => -0.0018937031,
              ((real)c_unique_addr_count_i < 3.5)   => 0.002604348,
                                                       -0.0018937031));

N403_5 :=__common__( map(trim(C_SPAN_LANG) = ''      => -0.011888012,
              ((real)c_span_lang < 191.5) => N403_6,
                                             -0.011888012));

N403_4 :=__common__( if(((real)c_hist_addr_match_i < 3.5), N403_5, N403_7));

N403_3 :=__common__( if(((real)c_hist_addr_match_i > NULL), N403_4, 0.0050263986));

N403_2 :=__common__( if(((real)c_hh1_p < 51.1500015259), N403_3, 0.005448246));

N403_1 :=__common__( if(trim(C_HH1_P) != '', N403_2, 0.0022979194));

N404_9 :=__common__( map(((real)c_comb_age_d <= NULL) => 0.0005286197,
              ((real)c_comb_age_d < 24.5)  => 0.0094843903,
                                              0.0005286197));

N404_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.106449201703), -0.00071632001, -0.008563598));

N404_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N404_8, -0.0039202633));

N404_6 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 96.5), N404_7, N404_9));

N404_5 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N404_6, 0.0015352672));

N404_4 :=__common__( map(trim(C_EMPLOYEES) = ''       => 0.006208378,
              ((integer)c_employees < 742) => N404_5,
                                              0.006208378));

N404_3 :=__common__( map(trim(C_EDU_INDX) = ''      => -0.0036668272,
              ((real)c_edu_indx < 100.5) => N404_4,
                                            -0.0036668272));

N404_2 :=__common__( if(((real)c_fammar18_p < 2.45000004768), -0.0052694581, N404_3));

N404_1 :=__common__( if(trim(C_FAMMAR18_P) != '', N404_2, -0.0011578043));

N405_8 :=__common__( map(trim(C_FAMOTF18_P) = ''              => -0.0087987572,
              ((real)c_famotf18_p < 35.1500015259) => 0.00047586153,
                                                      -0.0087987572));

N405_7 :=__common__( map((fp_segment in ['2 NAS 479', '3 New DID'])                                                 => -0.0033997986,
              (fp_segment in ['1 SSN Prob', '4 Bureau Only', '5 Derog', '6 Recent Activity', '7 Other']) => 0.01085374,
                                                                                                            0.01085374));

N405_6 :=__common__( map(trim(C_SERV_EMPL) = ''      => -0.00071609387,
              ((real)c_serv_empl < 159.5) => N405_7,
                                             -0.00071609387));

N405_5 :=__common__( map(((real)r_l77_apartment_i <= NULL) => N405_6,
              ((real)r_l77_apartment_i < 0.5)   => 0.0014170825,
                                                   N405_6));

N405_4 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.081618539989), N405_5, N405_8));

N405_3 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N405_4, -0.0025294416));

N405_2 :=__common__( if(((real)c_pop00 < 1381.5), -0.00096415833, N405_3));

N405_1 :=__common__( if(trim(C_POP00) != '', N405_2, -0.0027121715));

ENDMACRO;