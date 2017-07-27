EXPORT FP1407_1_0_tree4 := MACRO

N1274_9 :=__common__( map(((real)f_corrrisktype_i <= NULL) => 0.013087696,
               ((real)f_corrrisktype_i < 7.5)   => 0.0042963377,
                                                   0.013087696));

N1274_8 :=__common__( map(((real)r_c20_email_count_i <= NULL) => 1.0287601e-005,
               ((real)r_c20_email_count_i < 2.5)   => N1274_9,
                                                      1.0287601e-005));

N1274_7 :=__common__( map(trim(C_INC_125K_P) = ''              => -0.0062852547,
               ((real)c_inc_125k_p < 15.5500001907) => N1274_8,
                                                       -0.0062852547));

N1274_6 :=__common__( if(((real)r_c13_curr_addr_lres_d < 111.5), -0.0013354813, 0.0029157319));

N1274_5 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1274_6, -0.029962072));

N1274_4 :=__common__( if(((integer)f_curraddrmedianincome_d < 62525), N1274_5, N1274_7));

N1274_3 :=__common__( if(((real)f_curraddrmedianincome_d > NULL), N1274_4, 0.00097092225));

N1274_2 :=__common__( if(((real)c_sfdu_p < 34.8499984741), 0.0030769508, N1274_3));

N1274_1 :=__common__( if(trim(C_SFDU_P) != '', N1274_2, -0.0034367513));

N1275_7 :=__common__( map(trim(C_RAPE) = ''      => -0.00017413306,
               ((real)c_rape < 177.5) => 0.0049144917,
                                         -0.00017413306));

N1275_6 :=__common__( map(trim(C_LARCENY) = ''      => -7.8821476e-005,
               ((real)c_larceny < 164.5) => -0.012358986,
                                            -7.8821476e-005));

N1275_5 :=__common__( map((fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '6 Recent Activity', '7 Other']) => -0.0021027174,
               (fp_segment in ['4 Bureau Only', '5 Derog'])                                             => 0.0031803319,
                                                                                                           -0.0021027174));

N1275_4 :=__common__( map(trim(C_MURDERS) = ''       => N1275_6,
               ((integer)c_murders < 145) => N1275_5,
                                             N1275_6));

N1275_3 :=__common__( map(trim(C_RAPE) = ''      => N1275_7,
               ((real)c_rape < 130.5) => N1275_4,
                                         N1275_7));

N1275_2 :=__common__( if(((real)c_serv_empl < 132.5), N1275_3, -0.00085159261));

N1275_1 :=__common__( if(trim(C_SERV_EMPL) != '', N1275_2, 0.0014960285));

N1276_9 :=__common__( if(((real)f_inq_other_count24_i < 0.5), 0.0010737285, 0.011378407));

N1276_8 :=__common__( if(((real)f_inq_other_count24_i > NULL), N1276_9, 0.077254154));

N1276_7 :=__common__( map(trim(C_SPAN_LANG) = ''     => -1.9835502e-005,
               ((real)c_span_lang < 83.5) => N1276_8,
                                             -1.9835502e-005));

N1276_6 :=__common__( map(((real)f_historical_count_d <= NULL) => -0.012629876,
               ((real)f_historical_count_d < 3.5)   => -0.0012064237,
                                                       -0.012629876));

N1276_5 :=__common__( map(trim(C_RETIRED2) = ''     => -0.0036222363,
               ((real)c_retired2 < 97.5) => 0.0019519942,
                                            -0.0036222363));

N1276_4 :=__common__( map(((real)f_inq_lnames_per_addr_i <= NULL) => N1276_6,
               ((real)f_inq_lnames_per_addr_i < 2.5)   => N1276_5,
                                                          N1276_6));

N1276_3 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N1276_4, 0.00031302463));

N1276_2 :=__common__( if(((real)c_femdiv_p < 9.25), N1276_3, N1276_7));

N1276_1 :=__common__( if(trim(C_FEMDIV_P) != '', N1276_2, 0.00033049624));

N1277_9 :=__common__( if(((integer)r_i60_inq_hiriskcred_recency_d < 18), -0.012549083, -0.0034572746));

N1277_8 :=__common__( if(((real)r_i60_inq_hiriskcred_recency_d > NULL), N1277_9, -0.0068184674));

N1277_7 :=__common__( map(trim(C_HH1_P) = ''      => N1277_8,
               ((real)c_hh1_p < 38.75) => -0.0012116873,
                                          N1277_8));

N1277_6 :=__common__( if(((real)r_a50_pb_total_dollars_d < 89.5), 0.0089742582, -0.0009112756));

N1277_5 :=__common__( if(((real)r_a50_pb_total_dollars_d > NULL), N1277_6, 0.0028402007));

N1277_4 :=__common__( map(trim(C_MED_AGE) = ''              => N1277_7,
               ((real)c_med_age < 28.4500007629) => N1277_5,
                                                    N1277_7));

N1277_3 :=__common__( map(trim(C_YOUNG) = ''              => N1277_4,
               ((real)c_young < 12.3500003815) => 0.0073247032,
                                                  N1277_4));

N1277_2 :=__common__( if(((real)c_inc_75k_p < 12.9499998093), N1277_3, 0.0010739864));

N1277_1 :=__common__( if(trim(C_INC_75K_P) != '', N1277_2, 0.0034339441));

N1278_9 :=__common__( map(trim(C_HH00) = ''      => -0.00059592874,
               ((real)c_hh00 < 480.5) => 0.0074729945,
                                         -0.00059592874));

N1278_8 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => N1278_9,
               ((real)f_curraddrmurderindex_i < 121.5) => 0.013932078,
                                                          N1278_9));

N1278_7 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => N1278_8,
               ((real)f_mos_inq_banko_om_lseen_d < 18.5)  => -0.00067527351,
                                                             N1278_8));

N1278_6 :=__common__( if(((real)c_inc_50k_p < 10.75), -0.0020252006, N1278_7));

N1278_5 :=__common__( if(trim(C_INC_50K_P) != '', N1278_6, 0.01004292));

N1278_4 :=__common__( if(((real)c_rnt1000_p < 27.3499984741), -0.0010488279, 0.0018022396));

N1278_3 :=__common__( if(trim(C_RNT1000_P) != '', N1278_4, -2.9612046e-005));

N1278_2 :=__common__( if(((real)f_prevaddrmurderindex_i < 181.5), N1278_3, N1278_5));

N1278_1 :=__common__( if(((real)f_prevaddrmurderindex_i > NULL), N1278_2, -0.010605249));

N1279_6 :=__common__( map(trim(C_HH4_P) = ''      => 0.011520382,
               ((real)c_hh4_p < 13.25) => 0.0025094814,
                                          0.011520382));

N1279_5 :=__common__( map(trim(C_SPAN_LANG) = ''      => 0.0049082125,
               ((real)c_span_lang < 127.5) => -0.0047910187,
                                              0.0049082125));

N1279_4 :=__common__( if(((real)c_inc_200k_p < 1.15000009537), N1279_5, N1279_6));

N1279_3 :=__common__( if(trim(C_INC_200K_P) != '', N1279_4, 0.0064362767));

N1279_2 :=__common__( map(((real)r_l79_adls_per_addr_c6_i <= NULL) => 0.0011191314,
               ((real)r_l79_adls_per_addr_c6_i < 1.5)   => -0.0012575733,
                                                           0.0011191314));

N1279_1 :=__common__( if(((real)r_l70_inp_addr_dnd_i > NULL), N1279_2, N1279_3));

N1280_10 :=__common__( if(((real)f_curraddrcrimeindex_i < 190.5), 0.00021107483, -0.004488516));

N1280_9 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N1280_10, 0.0028933522));

N1280_8 :=__common__( if(((real)c_inc_50k_p < 8.64999961853), 0.0035408875, N1280_9));

N1280_7 :=__common__( if(trim(C_INC_50K_P) != '', N1280_8, 0.0011736454));

N1280_6 :=__common__( if(((real)c_hval_80k_p < 2.25), 0.0056234519, -0.0018759933));

N1280_5 :=__common__( if(trim(C_HVAL_80K_P) != '', N1280_6, 0.02526387));

N1280_4 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)     => 0.0099691904,
               ((integer)f_prevaddrmedianvalue_d < 191714) => N1280_5,
                                                              0.0099691904));

N1280_3 :=__common__( map(((real)r_a46_curr_avm_autoval_d <= NULL)   => -0.0051999113,
               ((real)r_a46_curr_avm_autoval_d < 96656.5) => N1280_4,
                                                             -0.0051999113));

N1280_2 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)             => N1280_3,
               ((real)f_add_curr_nhood_vac_pct_i < 0.000380435260013) => 0.0086323012,
                                                                         N1280_3));

N1280_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N1280_2, N1280_7));

N1281_9 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => -0.00025501138,
               ((real)r_c21_m_bureau_adl_fs_d < 130.5) => -0.0086571356,
                                                          -0.00025501138));

N1281_8 :=__common__( if(((real)f_add_input_mobility_index_n < 0.433807849884), N1281_9, 0.0052505367));

N1281_7 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1281_8, -0.0015348245));

N1281_6 :=__common__( map(((real)r_i60_inq_hiriskcred_count12_i <= NULL) => N1281_7,
               ((real)r_i60_inq_hiriskcred_count12_i < 1.5)   => 0.0018801145,
                                                                 N1281_7));

N1281_5 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => N1281_6,
               ((real)f_srchssnsrchcount_i < 0.5)   => -0.002374934,
                                                       N1281_6));

N1281_4 :=__common__( if(((real)c_no_labfor < 119.5), -0.0077965933, 0.0021966429));

N1281_3 :=__common__( if(trim(C_NO_LABFOR) != '', N1281_4, -0.0099587093));

N1281_2 :=__common__( if(((integer)r_i60_inq_banking_recency_d < 9), N1281_3, N1281_5));

N1281_1 :=__common__( if(((real)r_i60_inq_banking_recency_d > NULL), N1281_2, -0.00079618774));

N1282_8 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)   => -0.0016464972,
               ((real)f_prevaddrmedianvalue_d < 56769.5) => 0.003233649,
                                                            -0.0016464972));

N1282_7 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.596704006195), 0.0011513849, 0.0099312712));

N1282_6 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1282_7, 0.0048837209));

N1282_5 :=__common__( if(trim(C_HIGH_ED) != '', N1282_6, -0.0059201458));

N1282_4 :=__common__( map(((real)c_unique_addr_count_i <= NULL) => N1282_8,
               ((real)c_unique_addr_count_i < 9.5)   => N1282_5,
                                                        N1282_8));

N1282_3 :=__common__( if(((real)c_hh2_p < 25.75), -0.005970323, -0.00055317152));

N1282_2 :=__common__( if(trim(C_HH2_P) != '', N1282_3, -0.00052099028));

N1282_1 :=__common__( map((fp_segment in ['2 NAS 479', '3 New DID', '6 Recent Activity'])       => N1282_2,
               (fp_segment in ['1 SSN Prob', '4 Bureau Only', '5 Derog', '7 Other']) => N1282_4,
                                                                                        N1282_4));

N1283_8 :=__common__( map(trim(C_HH4_P) = ''              => -0.0038510242,
               ((real)c_hh4_p < 6.85000038147) => 0.0052694013,
                                                  -0.0038510242));

N1283_7 :=__common__( map(trim(C_POP_55_64_P) = ''              => -0.01141818,
               ((real)c_pop_55_64_p < 12.9499998093) => N1283_8,
                                                        -0.01141818));

N1283_6 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => -0.0066136802,
               ((real)f_add_input_mobility_index_n < 0.453534185886) => 0.0024756542,
                                                                        -0.0066136802));

N1283_5 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0425206013024), N1283_6, N1283_7));

N1283_4 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1283_5, -0.00021908087));

N1283_3 :=__common__( map(trim(C_NEW_HOMES) = ''      => N1283_4,
               ((real)c_new_homes < 148.5) => 0.00086770256,
                                              N1283_4));

N1283_2 :=__common__( if(((real)c_hh3_p < 3.34999990463), -0.0053799863, N1283_3));

N1283_1 :=__common__( if(trim(C_HH3_P) != '', N1283_2, 0.0015266597));

N1284_10 :=__common__( if(((real)c_manufacturing < 34.6500015259), 0.00012642953, 0.0072907676));

N1284_9 :=__common__( if(trim(C_MANUFACTURING) != '', N1284_10, -0.0049851607));

N1284_8 :=__common__( map(trim(C_RETIRED2) = ''     => -0.004686257,
               ((real)c_retired2 < 77.5) => 0.0068066517,
                                            -0.004686257));

N1284_7 :=__common__( if(((real)c_hh4_p < 17.4500007629), N1284_8, -0.011449335));

N1284_6 :=__common__( if(trim(C_HH4_P) != '', N1284_7, 0.0055324376));

N1284_5 :=__common__( map(trim(C_INC_50K_P) = ''              => -0.0008445972,
               ((real)c_inc_50k_p < 13.6499996185) => -0.0079694603,
                                                      -0.0008445972));

N1284_4 :=__common__( if(((real)f_addrchangeincomediff_d < -18024.5), 0.0046055537, N1284_5));

N1284_3 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1284_4, N1284_6));

N1284_2 :=__common__( if(((real)f_historical_count_d < 0.5), N1284_3, N1284_9));

N1284_1 :=__common__( if(((real)f_historical_count_d > NULL), N1284_2, -0.00095259742));

N1285_9 :=__common__( map((fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '4 Bureau Only', '6 Recent Activity', '7 Other']) => -0.0043324975,
               (fp_segment in ['5 Derog'])                                                                               => 0.0061564629,
                                                                                                                            -0.0043324975));

N1285_8 :=__common__( if(((real)c_rental < 112.5), -0.0065811156, N1285_9));

N1285_7 :=__common__( if(trim(C_RENTAL) != '', N1285_8, 0.029654719));

N1285_6 :=__common__( map(((real)f_mos_acc_lseen_d <= NULL) => N1285_7,
               ((real)f_mos_acc_lseen_d < 234.5) => -0.011149305,
                                                    N1285_7));

N1285_5 :=__common__( if(((real)c_rape < 144.5), 0.0010744685, 0.010240478));

N1285_4 :=__common__( if(trim(C_RAPE) != '', N1285_5, -0.014367465));

N1285_3 :=__common__( map(((real)f_rel_under25miles_cnt_d <= NULL) => N1285_4,
               ((real)f_rel_under25miles_cnt_d < 19.5)  => 0.00031331246,
                                                           N1285_4));

N1285_2 :=__common__( if(((real)f_rel_ageover20_count_d < 27.5), N1285_3, N1285_6));

N1285_1 :=__common__( if(((real)f_rel_ageover20_count_d > NULL), N1285_2, -0.00020382796));

N1286_10 :=__common__( if(((real)c_hhsize < 2.70499992371), -0.002211288, 0.010427466));

N1286_9 :=__common__( if(trim(C_HHSIZE) != '', N1286_10, -0.043904826));

N1286_8 :=__common__( map(((real)c_inf_addr_verd_d <= NULL) => 0.0052952212,
               ((real)c_inf_addr_verd_d < 0.5)   => -0.001223258,
                                                    0.0052952212));

N1286_7 :=__common__( map(trim(C_MIL_EMP) = ''              => 0.0084839775,
               ((real)c_mil_emp < 2.34999990463) => -0.0011354519,
                                                    0.0084839775));

N1286_6 :=__common__( map(trim(C_HH1_P) = ''              => -0.0090156095,
               ((real)c_hh1_p < 42.4500007629) => N1286_7,
                                                  -0.0090156095));

N1286_5 :=__common__( if(((real)c_assault < 180.5), N1286_6, 0.0060751751));

N1286_4 :=__common__( if(trim(C_ASSAULT) != '', N1286_5, -0.0086259395));

N1286_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1286_4, N1286_8));

N1286_2 :=__common__( if(((real)r_l79_adls_per_addr_c6_i < 4.5), N1286_3, N1286_9));

N1286_1 :=__common__( if(((real)r_l79_adls_per_addr_c6_i > NULL), N1286_2, 0.015075429));

N1287_9 :=__common__( map(((real)r_i60_inq_comm_count12_i <= NULL) => -0.0066027511,
               ((real)r_i60_inq_comm_count12_i < 1.5)   => 0.0012494782,
                                                           -0.0066027511));

N1287_8 :=__common__( map(trim(C_HH2_P) = ''      => -0.0080577666,
               ((real)c_hh2_p < 39.25) => N1287_9,
                                          -0.0080577666));

N1287_7 :=__common__( map(trim(C_RNT1000_P) = ''              => 0.002455841,
               ((real)c_rnt1000_p < 11.5500001907) => N1287_8,
                                                      0.002455841));

N1287_6 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), 0.00015745454, N1287_7));

N1287_5 :=__common__( map(trim(C_HVAL_500K_P) = ''              => -0.0086737864,
               ((real)c_hval_500k_p < 28.5499992371) => N1287_6,
                                                        -0.0086737864));

N1287_4 :=__common__( map(trim(C_SFDU_P) = ''      => -0.010975267,
               ((real)c_sfdu_p < 72.25) => 0.00042247682,
                                           -0.010975267));

N1287_3 :=__common__( map(((real)r_d32_mos_since_fel_ls_d <= NULL) => N1287_5,
               ((real)r_d32_mos_since_fel_ls_d < 111.5) => N1287_4,
                                                           N1287_5));

N1287_2 :=__common__( if(trim(C_HVAL_500K_P) != '', N1287_3, -0.0010700401));

N1287_1 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N1287_2, -0.006980039));

N1288_8 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.001311434,
               ((real)c_easiqlife < 126.5) => 0.0086819154,
                                              0.001311434));

N1288_7 :=__common__( map(trim(C_EMPLOYEES) = ''     => N1288_8,
               ((real)c_employees < 21.5) => -0.0028842668,
                                             N1288_8));

N1288_6 :=__common__( map(trim(C_HVAL_40K_P) = ''              => N1288_7,
               ((real)c_hval_40k_p < 6.05000019073) => -4.8292212e-005,
                                                       N1288_7));

N1288_5 :=__common__( map(trim(C_FEMDIV_P) = ''              => -0.0013318696,
               ((real)c_femdiv_p < 5.44999980927) => N1288_6,
                                                     -0.0013318696));

N1288_4 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.00341896340251), -0.0080644062, N1288_5));

N1288_3 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1288_4, -8.8404898e-005));

N1288_2 :=__common__( if(((real)c_popover25 < 342.5), -0.0080715947, N1288_3));

N1288_1 :=__common__( if(trim(C_POPOVER25) != '', N1288_2, -0.0031261659));

N1289_10 :=__common__( map(((real)f_mos_acc_lseen_d <= NULL) => 0.00071109285,
                ((real)f_mos_acc_lseen_d < 10.5)  => -0.0085148348,
                                                     0.00071109285));

N1289_9 :=__common__( if(((real)r_l78_no_phone_at_addr_vel_i < 0.5), N1289_10, -0.0025782354));

N1289_8 :=__common__( if(((real)r_l78_no_phone_at_addr_vel_i > NULL), N1289_9, -0.031619597));

N1289_7 :=__common__( map(((real)r_has_pb_record_d <= NULL) => 0.0024254955,
               ((real)r_has_pb_record_d < 0.5)   => 0.013080972,
                                                    0.0024254955));

N1289_6 :=__common__( if(((real)c_families < 389.5), -0.00024747989, N1289_7));

N1289_5 :=__common__( if(trim(C_FAMILIES) != '', N1289_6, -0.00044722044));

N1289_4 :=__common__( if(((real)f_prevaddrstatus_i > NULL), N1289_5, 0.004708633));

N1289_3 :=__common__( map(((real)f_prevaddrageoldest_d <= NULL) => N1289_8,
               ((real)f_prevaddrageoldest_d < 8.5)   => N1289_4,
                                                        N1289_8));

N1289_2 :=__common__( if(((real)r_c10_m_hdr_fs_d < 21.5), -0.0075929972, N1289_3));

N1289_1 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N1289_2, 0.0043290495));

N1290_9 :=__common__( if(((real)r_c13_max_lres_d < 217.5), 0.00086251006, -0.0072476658));

N1290_8 :=__common__( if(((real)r_c13_max_lres_d > NULL), N1290_9, 0.0082240411));

N1290_7 :=__common__( map(trim(C_HVAL_150K_P) = ''              => N1290_8,
               ((real)c_hval_150k_p < 11.8500003815) => 0.0064050611,
                                                        N1290_8));

N1290_6 :=__common__( map(trim(C_MIL_EMP) = ''              => -0.0069241872,
               ((real)c_mil_emp < 1.15000009537) => -0.00052468484,
                                                    -0.0069241872));

N1290_5 :=__common__( map(trim(C_VACANT_P) = ''              => 0.0054145879,
               ((real)c_vacant_p < 23.6500015259) => -0.0019388719,
                                                     0.0054145879));

N1290_4 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1290_5, N1290_6));

N1290_3 :=__common__( map(trim(C_POP_35_44_P) = ''              => -0.0095686311,
               ((real)c_pop_35_44_p < 24.0499992371) => N1290_4,
                                                        -0.0095686311));

N1290_2 :=__common__( if(((real)c_hval_150k_p < 10.25), N1290_3, N1290_7));

N1290_1 :=__common__( if(trim(C_HVAL_150K_P) != '', N1290_2, 0.0003195945));

N1291_8 :=__common__( map(trim(C_APT20) = ''      => -0.0076206602,
               ((real)c_apt20 < 145.5) => -3.8644844e-007,
                                          -0.0076206602));

N1291_7 :=__common__( map(((real)c_mos_since_impulse_fs_d <= NULL) => N1291_8,
               ((real)c_mos_since_impulse_fs_d < 51.5)  => 0.0074075896,
                                                           N1291_8));

N1291_6 :=__common__( map(trim(C_INC_200K_P) = ''               => N1291_7,
               ((real)c_inc_200k_p < 0.350000023842) => -0.0073273015,
                                                        N1291_7));

N1291_5 :=__common__( if(((real)c_unempl < 96.5), N1291_6, 0.00024177222));

N1291_4 :=__common__( if(trim(C_UNEMPL) != '', N1291_5, -0.002071065));

N1291_3 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)    => 0.0047114333,
               ((integer)f_prevaddrmedianincome_d < 78358) => N1291_4,
                                                              0.0047114333));

N1291_2 :=__common__( if(((real)f_mos_liens_rel_cj_fseen_d < 55.5), 0.0063981329, N1291_3));

N1291_1 :=__common__( if(((real)f_mos_liens_rel_cj_fseen_d > NULL), N1291_2, -0.0029528439));

N1292_8 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => 0.0020511653,
               ((real)r_d30_derog_count_i < 2.5)   => -0.00055719454,
                                                      0.0020511653));

N1292_7 :=__common__( if(((real)f_liens_unrel_cj_total_amt_i < 11026.5), N1292_8, -0.0056655299));

N1292_6 :=__common__( if(((real)f_liens_unrel_cj_total_amt_i > NULL), N1292_7, -0.0041507954));

N1292_5 :=__common__( map(trim(C_CHILD) = ''              => -0.010081492,
               ((real)c_child < 31.5499992371) => -0.0014404243,
                                                  -0.010081492));

N1292_4 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)            => N1292_6,
               ((real)f_add_input_nhood_vac_pct_i < 0.00552995875478) => N1292_5,
                                                                         N1292_6));

N1292_3 :=__common__( map(trim(C_RENTOCC_P) = ''      => -0.0056177948,
               ((real)c_rentocc_p < 77.75) => N1292_4,
                                              -0.0056177948));

N1292_2 :=__common__( if(((real)c_inc_75k_p < 3.45000004768), 0.0066107734, N1292_3));

N1292_1 :=__common__( if(trim(C_INC_75K_P) != '', N1292_2, -0.0021356342));

N1293_8 :=__common__( if(((real)c_hval_200k_p < 2.15000009537), 0.0004987921, -0.01109181));

N1293_7 :=__common__( if(trim(C_HVAL_200K_P) != '', N1293_8, -0.0011516024));

N1293_6 :=__common__( map(((real)f_mos_liens_unrel_cj_lseen_d <= NULL) => 0.0010420855,
               ((real)f_mos_liens_unrel_cj_lseen_d < 47.5)  => 0.009806717,
                                                               0.0010420855));

N1293_5 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)   => -0.00063577873,
               ((real)f_curraddrmedianvalue_d < 37348.5) => 0.0038637361,
                                                            -0.00063577873));

N1293_4 :=__common__( if(trim(C_RICH_HISP) != '', N1293_5, -0.0011851449));

N1293_3 :=__common__( if(((real)f_rel_incomeover25_count_d < 25.5), N1293_4, N1293_6));

N1293_2 :=__common__( if(((real)f_rel_incomeover25_count_d > NULL), N1293_3, 0.00016923516));

N1293_1 :=__common__( map(((real)f_inq_per_phone_i <= NULL) => N1293_7,
               ((real)f_inq_per_phone_i < 5.5)   => N1293_2,
                                                    N1293_7));

N1294_8 :=__common__( map(((real)c_addr_lres_12mo_ct_i <= NULL) => 0.0011147014,
               ((real)c_addr_lres_12mo_ct_i < 5.5)   => 0.0058543849,
                                                        0.0011147014));

N1294_7 :=__common__( map(trim(C_EXP_HOMES) = ''      => -0.0046710683,
               ((real)c_exp_homes < 163.5) => N1294_8,
                                              -0.0046710683));

N1294_6 :=__common__( map(trim(C_FOOD) = ''              => N1294_7,
               ((real)c_food < 4.55000019073) => -0.0018671596,
                                                 N1294_7));

N1294_5 :=__common__( map(trim(C_HVAL_200K_P) = ''              => N1294_6,
               ((real)c_hval_200k_p < 3.84999990463) => -0.00067130544,
                                                        N1294_6));

N1294_4 :=__common__( map(trim(C_HVAL_80K_P) = ''              => 0.0044269565,
               ((real)c_hval_80k_p < 40.1500015259) => N1294_5,
                                                       0.0044269565));

N1294_3 :=__common__( map(((real)r_a50_pb_total_orders_d <= NULL) => -0.0043781655,
               ((real)r_a50_pb_total_orders_d < 5.5)   => N1294_4,
                                                          -0.0043781655));

N1294_2 :=__common__( if(trim(C_HVAL_200K_P) != '', N1294_3, 0.0046531258));

N1294_1 :=__common__( if(((real)r_a50_pb_total_orders_d > NULL), N1294_2, -0.00013617997));

N1295_9 :=__common__( if(((real)f_corrrisktype_i < 8.5), 0.0003463561, 0.0053725373));

N1295_8 :=__common__( if(((real)f_corrrisktype_i > NULL), N1295_9, -0.0066685776));

N1295_7 :=__common__( map(trim(C_POP00) = ''        => -0.0062547668,
               ((integer)c_pop00 < 1963) => -0.00029705845,
                                            -0.0062547668));

N1295_6 :=__common__( map(((real)r_e55_college_ind_d <= NULL) => -0.0096280219,
               ((real)r_e55_college_ind_d < 0.5)   => N1295_7,
                                                      -0.0096280219));

N1295_5 :=__common__( map(trim(C_POPOVER18) = ''        => 0.006719303,
               ((integer)c_popover18 < 1824) => N1295_6,
                                                0.006719303));

N1295_4 :=__common__( if(((real)f_srchcountwk_i < 0.5), N1295_5, -0.0094733956));

N1295_3 :=__common__( if(((real)f_srchcountwk_i > NULL), N1295_4, 0.0004607557));

N1295_2 :=__common__( if(((real)c_inc_200k_p < 1.04999995232), N1295_3, N1295_8));

N1295_1 :=__common__( if(trim(C_INC_200K_P) != '', N1295_2, -0.00082061219));

N1296_8 :=__common__( map(trim(C_LOW_ED) = ''              => 0.0033032785,
               ((real)c_low_ed < 77.4499969482) => -0.0043886569,
                                                   0.0033032785));

N1296_7 :=__common__( map(trim(C_INC_200K_P) = ''              => 0.00078020552,
               ((real)c_inc_200k_p < 1.04999995232) => N1296_8,
                                                       0.00078020552));

N1296_6 :=__common__( map(trim(C_TOTSALES) = ''       => 0.00078355962,
               ((real)c_totsales < 1463.5) => N1296_7,
                                              0.00078355962));

N1296_5 :=__common__( if(((integer)f_estimated_income_d < 28500), 0.00093928612, 0.010892456));

N1296_4 :=__common__( if(((real)f_estimated_income_d > NULL), N1296_5, 0.081285752));

N1296_3 :=__common__( map(trim(C_POP_45_54_P) = ''              => N1296_4,
               ((real)c_pop_45_54_p < 8.55000019073) => -0.0033254291,
                                                        N1296_4));

N1296_2 :=__common__( if(((real)c_med_hhinc < 19515.5), N1296_3, N1296_6));

N1296_1 :=__common__( if(trim(C_MED_HHINC) != '', N1296_2, -0.0017811914));

N1297_10 :=__common__( if(((real)c_hval_175k_p < 9.55000019073), 0.0089419924, -0.0016493258));

N1297_9 :=__common__( if(trim(C_HVAL_175K_P) != '', N1297_10, 0.024015274));

N1297_8 :=__common__( map(((real)r_c13_curr_addr_lres_d <= NULL) => 0.0014943994,
               ((real)r_c13_curr_addr_lres_d < 29.5)  => -0.0050463524,
                                                         0.0014943994));

N1297_7 :=__common__( map(trim(C_HH7P_P) = ''     => -0.0020638352,
               ((real)c_hh7p_p < 1.75) => 0.0053727979,
                                          -0.0020638352));

N1297_6 :=__common__( map(trim(C_MANY_CARS) = ''     => -0.00049398535,
               ((real)c_many_cars < 54.5) => N1297_7,
                                             -0.00049398535));

N1297_5 :=__common__( if(((real)c_unemp < 9.14999961853), N1297_6, N1297_8));

N1297_4 :=__common__( if(trim(C_UNEMP) != '', N1297_5, -0.0020713658));

N1297_3 :=__common__( if(((real)f_srchfraudsrchcount_i < 28.5), N1297_4, N1297_9));

N1297_2 :=__common__( if(((real)f_srchfraudsrchcount_i > NULL), N1297_3, -0.0041210102));

N1297_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), -0.0001121516, N1297_2));

N1298_8 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.016489659,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0258803330362) => 0.0046957776,
                                                                       0.016489659));

N1298_7 :=__common__( map(trim(C_POP_65_74_P) = ''              => N1298_8,
               ((real)c_pop_65_74_p < 3.34999990463) => 0.001529807,
                                                        N1298_8));

N1298_6 :=__common__( map(trim(C_AB_AV_EDU) = ''     => 0.00014736446,
               ((real)c_ab_av_edu < 85.5) => N1298_7,
                                             0.00014736446));

N1298_5 :=__common__( map(trim(C_LOWRENT) = ''              => -0.0039643442,
               ((real)c_lowrent < 53.5499992371) => N1298_6,
                                                    -0.0039643442));

N1298_4 :=__common__( if(((real)c_fammar18_p < 38.75), -0.00029738528, N1298_5));

N1298_3 :=__common__( if(trim(C_FAMMAR18_P) != '', N1298_4, 0.0012453714));

N1298_2 :=__common__( if(((real)f_srchssnsrchcount_i < 40.5), N1298_3, -0.0066022426));

N1298_1 :=__common__( if(((real)f_srchssnsrchcount_i > NULL), N1298_2, -0.00047576303));

N1299_7 :=__common__( map(trim(C_INC_150K_P) = ''              => -0.0082466925,
               ((real)c_inc_150k_p < 2.15000009537) => -0.0013058294,
                                                       -0.0082466925));

N1299_6 :=__common__( map(trim(C_INFO) = ''              => 0.0037178758,
               ((real)c_info < 0.15000000596) => N1299_7,
                                                 0.0037178758));

N1299_5 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => -0.0095775635,
               ((real)f_add_input_nhood_vac_pct_i < 0.190107196569) => N1299_6,
                                                                       -0.0095775635));

N1299_4 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)            => N1299_5,
               ((real)f_add_curr_nhood_vac_pct_i < 0.00769559759647) => 0.0050129242,
                                                                        N1299_5));

N1299_3 :=__common__( map(trim(C_POP_18_24_P) = ''     => 0.0010906623,
               ((real)c_pop_18_24_p < 4.75) => -0.0025583186,
                                               0.0010906623));

N1299_2 :=__common__( if(((real)c_rentocc_p < 53.8499984741), N1299_3, N1299_4));

N1299_1 :=__common__( if(trim(C_RENTOCC_P) != '', N1299_2, 0.0021602504));

N1300_9 :=__common__( if(((real)f_mos_acc_lseen_d < 9.5), -0.0068990255, 0.0010339413));

N1300_8 :=__common__( if(((real)f_mos_acc_lseen_d > NULL), N1300_9, 0.0085586258));

N1300_7 :=__common__( map(trim(C_INC_35K_P) = ''              => 0.0013320934,
               ((real)c_inc_35k_p < 8.64999961853) => -0.0053446548,
                                                      0.0013320934));

N1300_6 :=__common__( map(trim(C_POPOVER18) = ''       => N1300_7,
               ((integer)c_popover18 < 798) => -0.0061726869,
                                               N1300_7));

N1300_5 :=__common__( map(trim(C_INC_125K_P) = ''               => N1300_6,
               ((real)c_inc_125k_p < 0.649999976158) => 0.0065427281,
                                                        N1300_6));

N1300_4 :=__common__( if(((real)f_srchaddrsrchcountmo_i < 0.5), N1300_5, -0.008034005));

N1300_3 :=__common__( if(((real)f_srchaddrsrchcountmo_i > NULL), N1300_4, 0.0027240242));

N1300_2 :=__common__( if(((real)c_retired < 6.25), N1300_3, N1300_8));

N1300_1 :=__common__( if(trim(C_RETIRED) != '', N1300_2, -0.0033211026));

N1301_8 :=__common__( map(((real)f_liens_unrel_sc_total_amt_i <= NULL)   => 0.0053047401,
               ((integer)f_liens_unrel_sc_total_amt_i < 1174) => -0.0033787599,
                                                                 0.0053047401));

N1301_7 :=__common__( map(trim(C_INC_50K_P) = ''              => 0.00026539265,
               ((real)c_inc_50k_p < 5.55000019073) => -0.0061811478,
                                                      0.00026539265));

N1301_6 :=__common__( if(((real)c_relig_indx < 189.5), N1301_7, 0.0065128493));

N1301_5 :=__common__( if(trim(C_RELIG_INDX) != '', N1301_6, 0.0013656946));

N1301_4 :=__common__( map(((real)f_divaddrsuspidcountnew_i <= NULL) => 0.0071821555,
               ((real)f_divaddrsuspidcountnew_i < 2.5)   => N1301_5,
                                                            0.0071821555));

N1301_3 :=__common__( map(((real)f_assocsuspicousidcount_i <= NULL) => 0.005496783,
               ((real)f_assocsuspicousidcount_i < 9.5)   => N1301_4,
                                                            0.005496783));

N1301_2 :=__common__( if(((real)f_rel_criminal_count_i < 9.5), N1301_3, N1301_8));

N1301_1 :=__common__( if(((real)f_rel_criminal_count_i > NULL), N1301_2, 0.0051910356));

N1302_9 :=__common__( map(trim(C_NEW_HOMES) = ''      => 0.0013183297,
               ((real)c_new_homes < 117.5) => 0.0094452751,
                                              0.0013183297));

N1302_8 :=__common__( map(trim(C_LOW_ED) = ''              => -0.0025691813,
               ((real)c_low_ed < 67.9499969482) => N1302_9,
                                                   -0.0025691813));

N1302_7 :=__common__( if(((real)f_m_bureau_adl_fs_all_d < 103.5), N1302_8, 0.0002861474));

N1302_6 :=__common__( if(((real)f_m_bureau_adl_fs_all_d > NULL), N1302_7, 0.012929374));

N1302_5 :=__common__( map(trim(C_HH4_P) = ''     => N1302_6,
               ((real)c_hh4_p < 2.25) => -0.0052990964,
                                         N1302_6));

N1302_4 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0819803923368), N1302_5, -0.0018724206));

N1302_3 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1302_4, -0.00072719678));

N1302_2 :=__common__( if(((real)c_hh1_p < 60.5499992371), N1302_3, 0.0080629436));

N1302_1 :=__common__( if(trim(C_HH1_P) != '', N1302_2, 0.0029079382));

N1303_9 :=__common__( map(trim(C_EMPLOYEES) = ''      => 0.0043614628,
               ((real)c_employees < 286.5) => 0.00032013179,
                                              0.0043614628));

N1303_8 :=__common__( if(((real)f_curraddractivephonelist_d < 0.5), N1303_9, -0.0037491981));

N1303_7 :=__common__( if(((real)f_curraddractivephonelist_d > NULL), N1303_8, 0.0025570659));

N1303_6 :=__common__( map(trim(C_POP_0_5_P) = ''     => N1303_7,
               ((real)c_pop_0_5_p < 6.75) => -0.0015285365,
                                             N1303_7));

N1303_5 :=__common__( if(((integer)f_curraddrmurderindex_i < 111), 0.0014161732, -0.011474463));

N1303_4 :=__common__( if(((real)f_curraddrmurderindex_i > NULL), N1303_5, -0.027488032));

N1303_3 :=__common__( map(trim(C_HH1_P) = ''              => N1303_6,
               ((real)c_hh1_p < 9.55000019073) => N1303_4,
                                                  N1303_6));

N1303_2 :=__common__( if(((real)c_totsales < 79572.5), N1303_3, -0.0048780938));

N1303_1 :=__common__( if(trim(C_TOTSALES) != '', N1303_2, -0.0013710895));

N1304_8 :=__common__( map(trim(C_ASIAN_LANG) = ''      => 0.0098152161,
               ((real)c_asian_lang < 153.5) => 0.00057736486,
                                               0.0098152161));

N1304_7 :=__common__( map(trim(C_BARGAINS) = ''      => -0.0062467067,
               ((real)c_bargains < 154.5) => 0.0035993637,
                                             -0.0062467067));

N1304_6 :=__common__( map(trim(C_HH5_P) = ''              => -0.0099709113,
               ((real)c_hh5_p < 8.85000038147) => N1304_7,
                                                  -0.0099709113));

N1304_5 :=__common__( if(((real)r_c14_addrs_10yr_i < 13.5), 0.00022546819, N1304_6));

N1304_4 :=__common__( if(((real)r_c14_addrs_10yr_i > NULL), N1304_5, -0.005033604));

N1304_3 :=__common__( map(trim(C_CONSTRUCTION) = ''              => 0.0065366023,
               ((real)c_construction < 56.3499984741) => N1304_4,
                                                         0.0065366023));

N1304_2 :=__common__( if(((real)c_housingcpi < 241.75), N1304_3, N1304_8));

N1304_1 :=__common__( if(trim(C_HOUSINGCPI) != '', N1304_2, 0.0028997884));

N1305_8 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => -0.010998195,
               ((real)f_add_input_mobility_index_n < 0.437720894814) => -0.0011101232,
                                                                        -0.010998195));

N1305_7 :=__common__( map(trim(C_INC_75K_P) = ''              => -0.0034131256,
               ((real)c_inc_75k_p < 22.5499992371) => 0.0019482,
                                                      -0.0034131256));

N1305_6 :=__common__( map(trim(C_HH4_P) = ''              => 0.0045525356,
               ((real)c_hh4_p < 22.1500015259) => -0.00075309372,
                                                  0.0045525356));

N1305_5 :=__common__( map(trim(C_INC_75K_P) = ''      => 0.0039052894,
               ((real)c_inc_75k_p < 23.75) => N1305_6,
                                              0.0039052894));

N1305_4 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1305_5, N1305_7));

N1305_3 :=__common__( map(trim(C_HEALTH) = ''              => -0.0052641001,
               ((real)c_health < 67.0500030518) => N1305_4,
                                                   -0.0052641001));

N1305_2 :=__common__( if(((real)c_totsales < 56717.5), N1305_3, N1305_8));

N1305_1 :=__common__( if(trim(C_TOTSALES) != '', N1305_2, 0.0023687621));

N1306_8 :=__common__( map(trim(C_INC_50K_P) = ''              => -0.00063989875,
               ((real)c_inc_50k_p < 16.0499992371) => -0.0073320162,
                                                      -0.00063989875));

N1306_7 :=__common__( map(trim(C_FAMOTF18_P) = ''              => N1306_8,
               ((real)c_famotf18_p < 16.1500015259) => 0.0020555365,
                                                       N1306_8));

N1306_6 :=__common__( map(((real)r_i60_inq_comm_count12_i <= NULL) => N1306_7,
               ((real)r_i60_inq_comm_count12_i < 1.5)   => -4.6908933e-005,
                                                           N1306_7));

N1306_5 :=__common__( if(((real)c_inc_15k_p < 1.34999990463), 0.0068459623, N1306_6));

N1306_4 :=__common__( if(trim(C_INC_15K_P) != '', N1306_5, 2.5285072e-005));

N1306_3 :=__common__( map(((real)f_rel_incomeover50_count_d <= NULL) => 0.0080990384,
               ((real)f_rel_incomeover50_count_d < 21.5)  => N1306_4,
                                                             0.0080990384));

N1306_2 :=__common__( if(((real)f_rel_under25miles_cnt_d < 0.5), 0.007501702, N1306_3));

N1306_1 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N1306_2, 0.0010467903));

N1307_8 :=__common__( map(((real)r_i60_inq_banking_recency_d <= NULL)  => 0.011019271,
               ((integer)r_i60_inq_banking_recency_d < 549) => -0.00014781958,
                                                               0.011019271));

N1307_7 :=__common__( if(((real)c_rich_wht < 112.5), 0.00016191781, 0.0083761497));

N1307_6 :=__common__( if(trim(C_RICH_WHT) != '', N1307_7, 0.0055814882));

N1307_5 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => N1307_6,
               ((real)r_c14_addrs_5yr_i < 6.5)   => -0.00040748375,
                                                    N1307_6));

N1307_4 :=__common__( map((fp_segment in ['5 Derog', '6 Recent Activity'])                                     => -0.010728569,
               (fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '4 Bureau Only', '7 Other']) => -0.001330481,
                                                                                                       -0.001330481));

N1307_3 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => N1307_5,
               ((real)r_c13_max_lres_d < 19.5)  => N1307_4,
                                                   N1307_5));

N1307_2 :=__common__( if(((real)r_c14_addrs_15yr_i < 18.5), N1307_3, N1307_8));

N1307_1 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N1307_2, 0.00098510545));

N1308_9 :=__common__( map(trim(C_FINANCE) = ''              => -0.011395995,
               ((real)c_finance < 5.44999980927) => 1.4458602e-005,
                                                    -0.011395995));

N1308_8 :=__common__( if(((real)f_addrchangecrimediff_i < 3.5), N1308_9, 0.0049032165));

N1308_7 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N1308_8, 0.00056230148));

N1308_6 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => 0.0066987152,
               ((real)r_c14_addrs_5yr_i < 6.5)   => N1308_7,
                                                    0.0066987152));

N1308_5 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), 0.001002771, N1308_6));

N1308_4 :=__common__( map(((real)c_mos_since_impulse_ls_d <= NULL) => N1308_5,
               ((real)c_mos_since_impulse_ls_d < 51.5)  => -0.0045960146,
                                                           N1308_5));

N1308_3 :=__common__( map(((real)f_divssnidmsrcurelcount_i <= NULL) => 0.0078165557,
               ((real)f_divssnidmsrcurelcount_i < 1.5)   => N1308_4,
                                                            0.0078165557));

N1308_2 :=__common__( if(((real)f_corrssnnamecount_d < 4.5), N1308_3, -0.00074781141));

N1308_1 :=__common__( if(((real)f_corrssnnamecount_d > NULL), N1308_2, -0.00034089014));

N1309_9 :=__common__( map(trim(C_NO_CAR) = ''      => -0.010700341,
               ((real)c_no_car < 107.5) => -0.00073830317,
                                           -0.010700341));

N1309_8 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => N1309_9,
               ((real)f_srchssnsrchcount_i < 13.5)  => -0.000595203,
                                                       N1309_9));

N1309_7 :=__common__( if(((real)c_rich_nfam < 167.5), N1309_8, 0.0054244681));

N1309_6 :=__common__( if(trim(C_RICH_NFAM) != '', N1309_7, -0.015360243));

N1309_5 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => 0.00062308329,
               ((real)r_d32_mos_since_crim_ls_d < 222.5) => 0.010553713,
                                                            0.00062308329));

N1309_4 :=__common__( if(((integer)r_l80_inp_avm_autoval_d < 20511), N1309_5, N1309_6));

N1309_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1309_4, -0.00073413306));

N1309_2 :=__common__( if(((real)f_util_adl_count_n < 11.5), N1309_3, 0.0042626626));

N1309_1 :=__common__( if(((real)f_util_adl_count_n > NULL), N1309_2, 0.0096120752));

N1310_8 :=__common__( map(((real)f_varrisktype_i <= NULL) => 0.007641944,
               ((real)f_varrisktype_i < 2.5)   => 1.1555145e-005,
                                                  0.007641944));

N1310_7 :=__common__( map(trim(C_HIGHINC) = ''              => N1310_8,
               ((real)c_highinc < 4.35000038147) => -0.0033806166,
                                                    N1310_8));

N1310_6 :=__common__( if(((real)r_i60_inq_recency_d < 4.5), -0.0043808192, N1310_7));

N1310_5 :=__common__( if(((real)r_i60_inq_recency_d > NULL), N1310_6, -0.0069475848));

N1310_4 :=__common__( map(trim(C_BARGAINS) = ''      => 0.0032585292,
               ((real)c_bargains < 165.5) => -0.0072453493,
                                             0.0032585292));

N1310_3 :=__common__( map(trim(C_RICH_NFAM) = ''      => N1310_4,
               ((real)c_rich_nfam < 162.5) => 0.0016004934,
                                              N1310_4));

N1310_2 :=__common__( if(((real)c_pop_35_44_p < 15.6499996185), N1310_3, N1310_5));

N1310_1 :=__common__( if(trim(C_POP_35_44_P) != '', N1310_2, 0.00097080096));

N1311_8 :=__common__( map(((real)f_util_adl_count_n <= NULL) => 0.011684956,
               ((real)f_util_adl_count_n < 8.5)   => 0.0022937615,
                                                     0.011684956));

N1311_7 :=__common__( map(trim(C_ASSAULT) = ''      => N1311_8,
               ((integer)c_assault < 82) => -0.0019410902,
                                            N1311_8));

N1311_6 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => -0.0011161067,
               ((real)f_add_input_nhood_vac_pct_i < 0.0296882800758) => N1311_7,
                                                                        -0.0011161067));

N1311_5 :=__common__( if(((real)r_c14_addrs_15yr_i < 21.5), N1311_6, -0.0065336764));

N1311_4 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N1311_5, -0.0045570742));

N1311_3 :=__common__( map(trim(C_RENTAL) = ''     => -0.002424222,
               ((real)c_rental < 65.5) => 0.011206405,
                                          -0.002424222));

N1311_2 :=__common__( if(((real)c_bargains < 24.5), N1311_3, N1311_4));

N1311_1 :=__common__( if(trim(C_BARGAINS) != '', N1311_2, 0.00072361586));

N1312_7 :=__common__( map(trim(C_APT20) = ''      => 0.0065356286,
               ((real)c_apt20 < 106.5) => -0.0041850286,
                                          0.0065356286));

N1312_6 :=__common__( map(trim(C_HVAL_100K_P) = ''     => 0.0094694453,
               ((real)c_hval_100k_p < 5.75) => 0.00055322255,
                                               0.0094694453));

N1312_5 :=__common__( map(trim(C_CONSTRUCTION) = ''              => N1312_7,
               ((real)c_construction < 6.55000019073) => N1312_6,
                                                         N1312_7));

N1312_4 :=__common__( map(trim(C_POP_25_34_P) = ''              => 0.0018155141,
               ((real)c_pop_25_34_p < 7.85000038147) => -0.0038700905,
                                                        0.0018155141));

N1312_3 :=__common__( map(((real)r_phn_cell_n <= NULL) => -0.0011970753,
               ((real)r_phn_cell_n < 0.5)   => N1312_4,
                                               -0.0011970753));

N1312_2 :=__common__( if(((real)c_transport < 6.05000019073), N1312_3, N1312_5));

N1312_1 :=__common__( if(trim(C_TRANSPORT) != '', N1312_2, 0.0029528317));

N1313_8 :=__common__( map(((real)f_inq_per_phone_i <= NULL) => -0.0022901719,
               ((real)f_inq_per_phone_i < 0.5)   => 0.0037581562,
                                                    -0.0022901719));

N1313_7 :=__common__( map(trim(C_NO_LABFOR) = ''     => N1313_8,
               ((real)c_no_labfor < 88.5) => -0.0025283186,
                                             N1313_8));

N1313_6 :=__common__( map(((real)r_i60_inq_count12_i <= NULL) => 0.0090311336,
               ((real)r_i60_inq_count12_i < 10.5)  => N1313_7,
                                                      0.0090311336));

N1313_5 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => 0.0038898866,
               ((real)r_c21_m_bureau_adl_fs_d < 267.5) => -0.0047515013,
                                                          0.0038898866));

N1313_4 :=__common__( if(((real)c_child < 24.0499992371), N1313_5, N1313_6));

N1313_3 :=__common__( if(trim(C_CHILD) != '', N1313_4, -0.00076047229));

N1313_2 :=__common__( if(((real)f_rel_under100miles_cnt_d < 12.5), N1313_3, 0.0013457513));

N1313_1 :=__common__( if(((real)f_rel_under100miles_cnt_d > NULL), N1313_2, -0.002021397));

N1314_9 :=__common__( if(((real)f_historical_count_d < 2.5), -0.00042648558, -0.010087246));

N1314_8 :=__common__( if(((real)f_historical_count_d > NULL), N1314_9, 0.026348007));

N1314_7 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => -0.00027542669,
               ((real)r_c13_avg_lres_d < 9.5)   => 0.0048358698,
                                                   -0.00027542669));

N1314_6 :=__common__( map(trim(C_WHITE_COL) = ''              => -0.013102911,
               ((real)c_white_col < 37.0499992371) => -0.00090559431,
                                                      -0.013102911));

N1314_5 :=__common__( if(((integer)f_curraddrcrimeindex_i < 15), N1314_6, N1314_7));

N1314_4 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N1314_5, -0.0099460942));

N1314_3 :=__common__( map(trim(C_HH5_P) = ''              => 0.0055144072,
               ((real)c_hh5_p < 15.1499996185) => N1314_4,
                                                  0.0055144072));

N1314_2 :=__common__( if(((real)c_hh5_p < 17.75), N1314_3, N1314_8));

N1314_1 :=__common__( if(trim(C_HH5_P) != '', N1314_2, 0.00092739112));

N1315_9 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d < 0.782930374146), 0.0016484228, -0.0091889241));

N1315_8 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d > NULL), N1315_9, -0.033165872));

N1315_7 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => 0.0045589047,
               ((real)f_curraddrmedianincome_d < 29456.5) => 0.014061751,
                                                             0.0045589047));

N1315_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0240888223052), -0.00096925916, N1315_7));

N1315_5 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1315_6, 0.021823371));

N1315_4 :=__common__( map(((real)f_util_adl_count_n <= NULL) => N1315_5,
               ((real)f_util_adl_count_n < 5.5)   => 0.00013483736,
                                                     N1315_5));

N1315_3 :=__common__( map(((real)f_srchfraudsrchcountyr_i <= NULL) => N1315_4,
               ((real)f_srchfraudsrchcountyr_i < 2.5)   => -0.00037533784,
                                                           N1315_4));

N1315_2 :=__common__( if(((real)r_c14_addrs_15yr_i < 17.5), N1315_3, N1315_8));

N1315_1 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N1315_2, -0.002456937));

N1316_9 :=__common__( if(((real)r_d34_unrel_liens_ct_i < 1.5), 0.012188124, 0.00033090948));

N1316_8 :=__common__( if(((real)r_d34_unrel_liens_ct_i > NULL), N1316_9, 0.009382721));

N1316_7 :=__common__( map(trim(C_HVAL_125K_P) = ''     => N1316_8,
               ((real)c_hval_125k_p < 3.75) => -0.0039916245,
                                               N1316_8));

N1316_6 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)    => 0.004707164,
               ((real)f_prevaddrmedianvalue_d < 112995.5) => -0.0027329182,
                                                             0.004707164));

N1316_5 :=__common__( map(trim(C_SFDU_P) = ''              => 0.0069732255,
               ((real)c_sfdu_p < 83.1499938965) => N1316_6,
                                                   0.0069732255));

N1316_4 :=__common__( if(((real)f_rel_incomeover25_count_d < 5.5), N1316_5, -0.00098043573));

N1316_3 :=__common__( if(((real)f_rel_incomeover25_count_d > NULL), N1316_4, -0.0012685227));

N1316_2 :=__common__( if(((real)c_pop00 < 2852.5), N1316_3, N1316_7));

N1316_1 :=__common__( if(trim(C_POP00) != '', N1316_2, -0.00089954511));

N1317_7 :=__common__( map(trim(C_POP_45_54_P) = ''      => 0.0005063196,
               ((real)c_pop_45_54_p < 10.75) => 0.008889931,
                                                0.0005063196));

N1317_6 :=__common__( map(trim(C_POP_65_74_P) = ''              => N1317_7,
               ((real)c_pop_65_74_p < 3.95000004768) => -0.004803301,
                                                        N1317_7));

N1317_5 :=__common__( map(trim(C_HVAL_125K_P) = ''              => -0.0093294427,
               ((real)c_hval_125k_p < 20.1500015259) => N1317_6,
                                                        -0.0093294427));

N1317_4 :=__common__( map(trim(C_UNEMPL) = ''      => 0.0035849622,
               ((real)c_unempl < 156.5) => N1317_5,
                                           0.0035849622));

N1317_3 :=__common__( map(trim(C_POP_18_24_P) = ''              => -0.0013336169,
               ((real)c_pop_18_24_p < 4.44999980927) => 0.0031222759,
                                                        -0.0013336169));

N1317_2 :=__common__( if(((real)c_hval_80k_p < 16.4500007629), N1317_3, N1317_4));

N1317_1 :=__common__( if(trim(C_HVAL_80K_P) != '', N1317_2, 0.00078412881));

N1318_10 :=__common__( map(trim(C_RELIG_INDX) = ''      => -0.0064383235,
                ((real)c_relig_indx < 146.5) => 0.0034536171,
                                                -0.0064383235));

N1318_9 :=__common__( if(((real)c_hval_400k_p < 1.95000004768), N1318_10, -0.0058409187));

N1318_8 :=__common__( if(trim(C_HVAL_400K_P) != '', N1318_9, -0.0070769414));

N1318_7 :=__common__( if(((real)c_assault < 117.5), 0.011608972, 0.00080403831));

N1318_6 :=__common__( if(trim(C_ASSAULT) != '', N1318_7, -0.012031389));

N1318_5 :=__common__( map(((real)f_inq_highriskcredit_count24_i <= NULL) => N1318_6,
               ((real)f_inq_highriskcredit_count24_i < 8.5)   => 8.4589542e-005,
                                                                 N1318_6));

N1318_4 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i < -21309.5), -0.0083736459, -0.00016282442));

N1318_3 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N1318_4, N1318_5));

N1318_2 :=__common__( if(((real)f_rel_incomeover50_count_d < 9.5), N1318_3, N1318_8));

N1318_1 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N1318_2, 0.00079596349));

N1319_8 :=__common__( map(trim(C_INC_50K_P) = ''      => 0.013574024,
               ((real)c_inc_50k_p < 16.25) => 0.0032264736,
                                              0.013574024));

N1319_7 :=__common__( if(((real)f_rel_incomeover50_count_d < 3.5), 0.0041292511, -0.0081512441));

N1319_6 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N1319_7, 0.0024144408));

N1319_5 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0428028479218), N1319_6, N1319_8));

N1319_4 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1319_5, -0.0063986413));

N1319_3 :=__common__( if(((real)c_employees < 12.5), N1319_4, -0.00022124908));

N1319_2 :=__common__( if(trim(C_EMPLOYEES) != '', N1319_3, 0.0023448251));

N1319_1 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.0062943873,
               ((real)c_comb_age_d < 58.5)  => N1319_2,
                                               -0.0062943873));

N1320_8 :=__common__( map(trim(C_SERV_EMPL) = ''      => 0.0003705175,
               ((real)c_serv_empl < 121.5) => 0.0084982274,
                                              0.0003705175));

N1320_7 :=__common__( map(((real)r_i60_inq_count12_i <= NULL) => -0.004340833,
               ((real)r_i60_inq_count12_i < 2.5)   => N1320_8,
                                                      -0.004340833));

N1320_6 :=__common__( map(((real)f_inq_count24_i <= NULL) => 0.0088012913,
               ((real)f_inq_count24_i < 7.5)   => N1320_7,
                                                  0.0088012913));

N1320_5 :=__common__( if(((real)c_mos_since_impulse_ls_d < 60.5), -0.0047613043, N1320_6));

N1320_4 :=__common__( if(((real)c_mos_since_impulse_ls_d > NULL), N1320_5, 0.026619706));

N1320_3 :=__common__( map(trim(C_ASSAULT) = ''      => N1320_4,
               ((real)c_assault < 182.5) => -0.00058558356,
                                            N1320_4));

N1320_2 :=__common__( if(((real)c_retail < 52.1500015259), N1320_3, 0.0066761994));

N1320_1 :=__common__( if(trim(C_RETAIL) != '', N1320_2, 0.0016381663));

N1321_8 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => -0.0040863671,
               ((real)f_add_curr_nhood_vac_pct_i < 0.147526919842) => -0.00046939246,
                                                                      -0.0040863671));

N1321_7 :=__common__( map(((real)f_rel_under500miles_cnt_d <= NULL) => -0.0002144086,
               ((real)f_rel_under500miles_cnt_d < 9.5)   => 0.011064366,
                                                            -0.0002144086));

N1321_6 :=__common__( map(((real)f_assocsuspicousidcount_i <= NULL) => N1321_7,
               ((real)f_assocsuspicousidcount_i < 1.5)   => -0.0061780156,
                                                            N1321_7));

N1321_5 :=__common__( map(trim(C_REST_INDX) = ''      => 0.010851528,
               ((real)c_rest_indx < 137.5) => N1321_6,
                                              0.010851528));

N1321_4 :=__common__( if(((real)f_util_adl_count_n < 0.5), N1321_5, N1321_8));

N1321_3 :=__common__( if(((real)f_util_adl_count_n > NULL), N1321_4, 0.0037409079));

N1321_2 :=__common__( if(((real)c_rnt500_p < 49.0499992371), N1321_3, 0.0022966788));

N1321_1 :=__common__( if(trim(C_RNT500_P) != '', N1321_2, -0.004265838));

N1322_8 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => -0.0039085743,
               ((real)r_d32_mos_since_crim_ls_d < 13.5)  => 0.0076176712,
                                                            -0.0039085743));

N1322_7 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => -0.0014981514,
               ((real)f_curraddrburglaryindex_i < 144.5) => -0.013123276,
                                                            -0.0014981514));

N1322_6 :=__common__( map(trim(C_INCOLLEGE) = ''              => N1322_8,
               ((real)c_incollege < 4.85000038147) => N1322_7,
                                                      N1322_8));

N1322_5 :=__common__( map(trim(C_HVAL_40K_P) = ''              => -0.0059009415,
               ((real)c_hval_40k_p < 33.3499984741) => 0.00018394006,
                                                       -0.0059009415));

N1322_4 :=__common__( map(trim(C_EXP_HOMES) = ''      => 0.0074408159,
               ((real)c_exp_homes < 178.5) => N1322_5,
                                              0.0074408159));

N1322_3 :=__common__( if(((real)r_d32_criminal_count_i < 9.5), N1322_4, N1322_6));

N1322_2 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N1322_3, -0.0018518877));

N1322_1 :=__common__( if(trim(C_HH1_P) != '', N1322_2, -0.0024840595));

N1323_8 :=__common__( map(((real)f_add_curr_nhood_mfd_pct_i <= NULL)          => 0.0099221986,
               ((real)f_add_curr_nhood_mfd_pct_i < 0.228554278612) => 0.0015998824,
                                                                      0.0099221986));

N1323_7 :=__common__( map(trim(C_FAMOTF18_P) = ''              => 0.0077355525,
               ((real)c_famotf18_p < 58.0499992371) => -0.00023863982,
                                                       0.0077355525));

N1323_6 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => -0.006201306,
               ((real)r_c14_addrs_5yr_i < 6.5)   => N1323_7,
                                                    -0.006201306));

N1323_5 :=__common__( map(trim(C_LOWINC) = ''              => N1323_6,
               ((real)c_lowinc < 23.1500015259) => 0.0068778921,
                                                   N1323_6));

N1323_4 :=__common__( map(trim(C_FOOD) = ''              => N1323_8,
               ((real)c_food < 6.85000038147) => N1323_5,
                                                 N1323_8));

N1323_3 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1323_4, 0.001731574));

N1323_2 :=__common__( if(((real)c_food < 12.5500001907), N1323_3, -0.00077929741));

N1323_1 :=__common__( if(trim(C_FOOD) != '', N1323_2, 0.0026850127));

N1324_9 :=__common__( map(trim(C_POP_0_5_P) = ''              => 0.0053699204,
               ((real)c_pop_0_5_p < 16.8499984741) => -0.00040967731,
                                                      0.0053699204));

N1324_8 :=__common__( map(trim(C_POP_0_5_P) = ''              => -0.0067139553,
               ((real)c_pop_0_5_p < 13.0500001907) => 0.00085919163,
                                                      -0.0067139553));

N1324_7 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => N1324_8,
               ((real)f_curraddrmurderindex_i < 28.5)  => 0.0085399799,
                                                          N1324_8));

N1324_6 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N1324_7, N1324_9));

N1324_5 :=__common__( if(((real)f_prevaddrlenofres_d < 227.5), N1324_6, -0.0083151591));

N1324_4 :=__common__( if(((real)f_prevaddrlenofres_d > NULL), N1324_5, 0.003662914));

N1324_3 :=__common__( map(((real)r_phn_cell_n <= NULL) => 0.008292852,
               ((real)r_phn_cell_n < 0.5)   => -0.0012181027,
                                               0.008292852));

N1324_2 :=__common__( if(((real)c_occunit_p < 73.5500030518), N1324_3, N1324_4));

N1324_1 :=__common__( if(trim(C_OCCUNIT_P) != '', N1324_2, 0.00011375229));

N1325_8 :=__common__( map(trim(C_SERV_EMPL) = ''     => -0.0068906975,
               ((real)c_serv_empl < 69.5) => 0.0021645461,
                                             -0.0068906975));

N1325_7 :=__common__( if(((real)c_inc_35k_p < 17.9500007629), N1325_8, 0.0033145728));

N1325_6 :=__common__( if(trim(C_INC_35K_P) != '', N1325_7, -0.0028350199));

N1325_5 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => -0.012190917,
               ((real)f_m_bureau_adl_fs_all_d < 312.5) => N1325_6,
                                                          -0.012190917));

N1325_4 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => N1325_5,
               ((real)f_mos_inq_banko_cm_lseen_d < 17.5)  => 0.0043844312,
                                                             N1325_5));

N1325_3 :=__common__( map(((real)f_mos_liens_unrel_lt_lseen_d <= NULL) => N1325_4,
               ((real)f_mos_liens_unrel_lt_lseen_d < 95.5)  => 0.0064900259,
                                                               N1325_4));

N1325_2 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.147561848164), 0.0008510891, N1325_3));

N1325_1 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N1325_2, 0.019867379));

N1326_10 :=__common__( if(((real)f_rel_under100miles_cnt_d < 14.5), 0.0028242903, -0.0039999551));

N1326_9 :=__common__( if(((real)f_rel_under100miles_cnt_d > NULL), N1326_10, 0.0037763421));

N1326_8 :=__common__( if(((real)f_prevaddrmedianvalue_d < 51809.5), 0.0080178731, N1326_9));

N1326_7 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N1326_8, 0.018287712));

N1326_6 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)    => 0.0059803757,
               ((integer)f_curraddrmedianincome_d < 79849) => -0.00068672299,
                                                              0.0059803757));

N1326_5 :=__common__( map(((real)f_mos_liens_unrel_lt_lseen_d <= NULL) => -0.0025948034,
               ((integer)f_mos_liens_unrel_lt_lseen_d < 60) => -0.011030835,
                                                               -0.0025948034));

N1326_4 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d < 49.5), N1326_5, N1326_6));

N1326_3 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d > NULL), N1326_4, -0.0052888643));

N1326_2 :=__common__( if(((real)c_rental < 181.5), N1326_3, N1326_7));

N1326_1 :=__common__( if(trim(C_RENTAL) != '', N1326_2, 0.0012567113));

N1327_8 :=__common__( map(trim(C_FEMDIV_P) = ''              => 0.00089232818,
               ((real)c_femdiv_p < 3.04999995232) => -0.01120216,
                                                     0.00089232818));

N1327_7 :=__common__( map(trim(C_HVAL_200K_P) = ''              => 0.0048280729,
               ((real)c_hval_200k_p < 10.8500003815) => -0.0040608341,
                                                        0.0048280729));

N1327_6 :=__common__( if(((real)f_componentcharrisktype_i < 3.5), N1327_7, 0.00065115884));

N1327_5 :=__common__( if(((real)f_componentcharrisktype_i > NULL), N1327_6, 0.0067519557));

N1327_4 :=__common__( map(trim(C_LAR_FAM) = ''      => N1327_8,
               ((real)c_lar_fam < 169.5) => N1327_5,
                                            N1327_8));

N1327_3 :=__common__( map(((real)c_a49_prop_sold_assessed_tot_d <= NULL)    => -0.0082977488,
               ((integer)c_a49_prop_sold_assessed_tot_d < 89417) => N1327_4,
                                                                    -0.0082977488));

N1327_2 :=__common__( if(((real)c_hh3_p < 36.6500015259), N1327_3, 0.0071571902));

N1327_1 :=__common__( if(trim(C_HH3_P) != '', N1327_2, -0.0018886708));

N1328_8 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL)  => -0.0022381489,
               ((integer)f_curraddrcrimeindex_i < 182) => 0.0078064912,
                                                          -0.0022381489));

N1328_7 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => N1328_8,
               ((real)f_inq_per_ssn_i < 1.5)   => 9.3860162e-006,
                                                  N1328_8));

N1328_6 :=__common__( map(trim(C_CONSTRUCTION) = ''              => N1328_7,
               ((real)c_construction < 3.65000009537) => -0.00058293903,
                                                         N1328_7));

N1328_5 :=__common__( map(trim(C_CIV_EMP) = ''              => -0.001400492,
               ((real)c_civ_emp < 57.1500015259) => N1328_6,
                                                    -0.001400492));

N1328_4 :=__common__( if(((real)c_professional < 24.0499992371), N1328_5, 0.005714155));

N1328_3 :=__common__( if(trim(C_PROFESSIONAL) != '', N1328_4, 0.0049681712));

N1328_2 :=__common__( if(((real)f_mos_liens_rel_ot_fseen_d < 52.5), N1328_3, -0.0079462831));

N1328_1 :=__common__( if(((real)f_mos_liens_rel_ot_fseen_d > NULL), N1328_2, -0.00058949341));

N1329_10 :=__common__( if(((real)c_larceny < 59.5), 0.0055419303, 0.00025041823));

N1329_9 :=__common__( if(trim(C_LARCENY) != '', N1329_10, 0.0037616218));

N1329_8 :=__common__( map(trim(C_HEALTH) = ''              => 0.0013581176,
               ((real)c_health < 15.9499998093) => -0.0078241524,
                                                   0.0013581176));

N1329_7 :=__common__( map(((real)f_rel_ageover40_count_d <= NULL) => 0.0024181218,
               ((real)f_rel_ageover40_count_d < 4.5)   => N1329_8,
                                                          0.0024181218));

N1329_6 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => -0.0012103719,
               ((integer)r_i60_inq_auto_recency_d < 549) => 0.0069334454,
                                                            -0.0012103719));

N1329_5 :=__common__( map(trim(C_LAR_FAM) = ''      => N1329_7,
               ((real)c_lar_fam < 104.5) => N1329_6,
                                            N1329_7));

N1329_4 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N1329_5, -0.010762634));

N1329_3 :=__common__( if(trim(C_LAR_FAM) != '', N1329_4, -0.0054317223));

N1329_2 :=__common__( if(((real)f_curraddrburglaryindex_i < 91.5), N1329_3, N1329_9));

N1329_1 :=__common__( if(((real)f_curraddrburglaryindex_i > NULL), N1329_2, 0.00049324155));

N1330_10 :=__common__( map(trim(C_INCOLLEGE) = ''              => 0.0090772365,
                ((real)c_incollege < 3.45000004768) => -0.0015443862,
                                                       0.0090772365));

N1330_9 :=__common__( if(((real)c_easiqlife < 107.5), N1330_10, 0.00072949327));

N1330_8 :=__common__( if(trim(C_EASIQLIFE) != '', N1330_9, -0.005857443));

N1330_7 :=__common__( if(((real)r_c13_curr_addr_lres_d < 10.5), N1330_8, -0.0003450079));

N1330_6 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1330_7, -0.030635092));

N1330_5 :=__common__( map(trim(C_HVAL_40K_P) = ''              => -0.0011770139,
               ((real)c_hval_40k_p < 3.84999990463) => -0.012456748,
                                                       -0.0011770139));

N1330_4 :=__common__( if(((integer)r_l80_inp_avm_autoval_d < 32030), N1330_5, -0.00030611538));

N1330_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1330_4, -0.0015593008));

N1330_2 :=__common__( if(((real)c_hist_addr_match_i < 1.5), N1330_3, N1330_6));

N1330_1 :=__common__( if(((real)c_hist_addr_match_i > NULL), N1330_2, -0.002943492));

N1331_9 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => -0.00041478608,
               ((real)f_rel_felony_count_i < 0.5)   => 0.010767073,
                                                       -0.00041478608));

N1331_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1331_9, 0.042233361));

N1331_7 :=__common__( map(trim(C_SERV_EMPL) = ''      => -0.0035297581,
               ((real)c_serv_empl < 142.5) => 0.0049203578,
                                              -0.0035297581));

N1331_6 :=__common__( if(((integer)r_a46_curr_avm_autoval_d < 69734), 0.0066077609, -0.0048241622));

N1331_5 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N1331_6, N1331_7));

N1331_4 :=__common__( if(((real)c_inc_50k_p < 9.05000019073), N1331_5, -0.0007978621));

N1331_3 :=__common__( if(trim(C_INC_50K_P) != '', N1331_4, -0.0042279814));

N1331_2 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 351.5), N1331_3, N1331_8));

N1331_1 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N1331_2, -0.0016777042));

N1332_8 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)   => 0.0087874915,
               ((real)f_curraddrmedianvalue_d < 89398.5) => -0.0013937256,
                                                            0.0087874915));

N1332_7 :=__common__( map(trim(C_HH6_P) = ''              => -0.0025370781,
               ((real)c_hh6_p < 1.84999990463) => N1332_8,
                                                  -0.0025370781));

N1332_6 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)          => N1332_7,
               ((real)f_add_input_nhood_sfd_pct_d < 0.451582193375) => -0.0082255971,
                                                                       N1332_7));

N1332_5 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => 0.0015250481,
               ((real)r_c14_addrs_15yr_i < 10.5)  => 0.011356002,
                                                     0.0015250481));

N1332_4 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 222.5), N1332_5, N1332_6));

N1332_3 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N1332_4, 0.013075468));

N1332_2 :=__common__( if(((real)c_cpiall < 208.5), N1332_3, -0.00015019867));

N1332_1 :=__common__( if(trim(C_CPIALL) != '', N1332_2, -0.00037826676));

N1333_8 :=__common__( map(trim(C_HVAL_80K_P) = ''              => 1.6722565e-005,
               ((real)c_hval_80k_p < 7.94999980927) => 0.0054495181,
                                                       1.6722565e-005));

N1333_7 :=__common__( map(trim(C_HH00) = ''      => -0.00056256027,
               ((real)c_hh00 < 430.5) => N1333_8,
                                         -0.00056256027));

N1333_6 :=__common__( map(trim(C_HH2_P) = ''              => -0.0024729553,
               ((real)c_hh2_p < 16.5499992371) => 0.0063245363,
                                                  -0.0024729553));

N1333_5 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => N1333_7,
               ((real)f_mos_liens_unrel_cj_fseen_d < 98.5)  => N1333_6,
                                                               N1333_7));

N1333_4 :=__common__( if(((real)c_fammar18_p < 57.75), N1333_5, 0.0074755661));

N1333_3 :=__common__( if(trim(C_FAMMAR18_P) != '', N1333_4, 0.0003871479));

N1333_2 :=__common__( if(((real)r_c20_email_domain_free_count_i < 6.5), N1333_3, -0.0074829802));

N1333_1 :=__common__( if(((real)r_c20_email_domain_free_count_i > NULL), N1333_2, 0.0037525052));

N1334_10 :=__common__( map(trim(C_CONSTRUCTION) = ''              => -0.0024711589,
                ((real)c_construction < 4.14999961853) => -0.012907751,
                                                          -0.0024711589));

N1334_9 :=__common__( if(((real)c_assault < 154.5), N1334_10, 0.0015275104));

N1334_8 :=__common__( if(trim(C_ASSAULT) != '', N1334_9, -0.0083061868));

N1334_7 :=__common__( map(trim(C_RNT750_P) = ''              => -0.007351515,
               ((real)c_rnt750_p < 15.8500003815) => 0.0023707006,
                                                     -0.007351515));

N1334_6 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N1334_7, 0.0020544788));

N1334_5 :=__common__( map(trim(C_HH4_P) = ''     => 0.0010172476,
               ((real)c_hh4_p < 2.25) => N1334_6,
                                         0.0010172476));

N1334_4 :=__common__( if(((real)c_hh5_p < 19.0499992371), N1334_5, -0.0043017648));

N1334_3 :=__common__( if(trim(C_HH5_P) != '', N1334_4, 0.0022149847));

N1334_2 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.295937120914), N1334_3, N1334_8));

N1334_1 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N1334_2, 0.0050149076));

N1335_8 :=__common__( map(trim(C_MED_AGE) = ''              => -0.010444906,
               ((real)c_med_age < 37.0499992371) => -0.0019403825,
                                                    -0.010444906));

N1335_7 :=__common__( map(trim(C_MEDI_INDX) = ''      => N1335_8,
               ((real)c_medi_indx < 110.5) => -0.00048420331,
                                              N1335_8));

N1335_6 :=__common__( map(trim(C_TOTCRIME) = ''      => -0.0096139943,
               ((real)c_totcrime < 172.5) => -0.00032139627,
                                             -0.0096139943));

N1335_5 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d < 14.5), N1335_6, 0.0015595906));

N1335_4 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d > NULL), N1335_5, 0.00045827379));

N1335_3 :=__common__( map(trim(C_HVAL_80K_P) = ''      => 0.0062927093,
               ((real)c_hval_80k_p < 33.25) => N1335_4,
                                               0.0062927093));

N1335_2 :=__common__( map(((real)r_phn_cell_n <= NULL) => N1335_7,
               ((real)r_phn_cell_n < 0.5)   => N1335_3,
                                               N1335_7));

N1335_1 :=__common__( if(trim(C_YOUNG) != '', N1335_2, 0.0003976115));

N1336_8 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL) => 0.0016697309,
               ((real)r_a50_pb_total_dollars_d < 234.5) => -0.001283355,
                                                           0.0016697309));

N1336_7 :=__common__( map(trim(C_BIGAPT_P) = ''              => -0.006912627,
               ((real)c_bigapt_p < 35.8499984741) => N1336_8,
                                                     -0.006912627));

N1336_6 :=__common__( map(trim(C_LOWRENT) = ''      => 0.0001633028,
               ((real)c_lowrent < 50.75) => 0.010303283,
                                            0.0001633028));

N1336_5 :=__common__( map(trim(C_POPOVER25) = ''      => N1336_7,
               ((real)c_popover25 < 554.5) => N1336_6,
                                              N1336_7));

N1336_4 :=__common__( if(((real)c_pop00 < 863.5), -0.0024740967, N1336_5));

N1336_3 :=__common__( if(trim(C_POP00) != '', N1336_4, 0.0031881179));

N1336_2 :=__common__( if(((real)f_rel_under100miles_cnt_d < 30.5), N1336_3, -0.0044778016));

N1336_1 :=__common__( if(((real)f_rel_under100miles_cnt_d > NULL), N1336_2, 0.00058180535));

N1337_9 :=__common__( if(((real)c_hval_60k_p < 28.0499992371), 0.00097516814, 0.0074911738));

N1337_8 :=__common__( if(trim(C_HVAL_60K_P) != '', N1337_9, -0.0026934065));

N1337_7 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)    => N1337_8,
               ((integer)f_curraddrmedianvalue_d < 29554) => -0.0053606932,
                                                             N1337_8));

N1337_6 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => 0.0034019554,
               ((real)f_srchfraudsrchcount_i < 23.5)  => -0.002652243,
                                                         0.0034019554));

N1337_5 :=__common__( if(((real)c_fammar18_p < 44.8499984741), N1337_6, 0.0038326167));

N1337_4 :=__common__( if(trim(C_FAMMAR18_P) != '', N1337_5, 0.0013509062));

N1337_3 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => 0.0066194156,
               ((real)r_c13_max_lres_d < 252.5) => N1337_4,
                                                   0.0066194156));

N1337_2 :=__common__( if(((real)c_dist_best_to_prev_addr_i < 4.5), N1337_3, N1337_7));

N1337_1 :=__common__( if(((real)c_dist_best_to_prev_addr_i > NULL), N1337_2, -0.0058823428));

N1338_9 :=__common__( map(trim(C_INC_50K_P) = ''              => 0.0021888616,
               ((real)c_inc_50k_p < 17.0499992371) => -0.0012586717,
                                                      0.0021888616));

N1338_8 :=__common__( map(trim(C_POP_55_64_P) = ''              => -0.0031221714,
               ((real)c_pop_55_64_p < 13.5500001907) => N1338_9,
                                                        -0.0031221714));

N1338_7 :=__common__( if(((integer)f_addrchangevaluediff_d < -13590), -0.0011456376, 0.0089590304));

N1338_6 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1338_7, 0.0042005826));

N1338_5 :=__common__( map(trim(C_RNT1250_P) = ''     => -0.0055383191,
               ((real)c_rnt1250_p < 0.75) => N1338_6,
                                             -0.0055383191));

N1338_4 :=__common__( if(((real)c_pop_35_44_p < 7.35000038147), N1338_5, N1338_8));

N1338_3 :=__common__( if(trim(C_POP_35_44_P) != '', N1338_4, -8.630512e-005));

N1338_2 :=__common__( if(((integer)f_liens_unrel_ot_total_amt_i < 1048), N1338_3, 0.0070060046));

N1338_1 :=__common__( if(((real)f_liens_unrel_ot_total_amt_i > NULL), N1338_2, -0.004043475));

N1339_10 :=__common__( if(((real)c_pop_25_34_p < 13.6499996185), 0.0089823524, -0.0012392112));

N1339_9 :=__common__( if(trim(C_POP_25_34_P) != '', N1339_10, 0.031144583));

N1339_8 :=__common__( map(trim(C_ROBBERY) = ''      => -0.0060086386,
               ((real)c_robbery < 164.5) => 0.0019400821,
                                            -0.0060086386));

N1339_7 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => 0.0067030735,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.893057823181) => N1339_8,
                                                                      0.0067030735));

N1339_6 :=__common__( map(((real)f_assoccredbureaucount_i <= NULL) => N1339_7,
               ((real)f_assoccredbureaucount_i < 2.5)   => -0.00045686814,
                                                           N1339_7));

N1339_5 :=__common__( if(trim(C_FEMDIV_P) != '', N1339_6, -0.0012188587));

N1339_4 :=__common__( if(((real)c_unique_addr_count_i < 23.5), N1339_5, -0.0062534973));

N1339_3 :=__common__( if(((real)c_unique_addr_count_i > NULL), N1339_4, -0.0018016764));

N1339_2 :=__common__( if(((real)f_inq_lnames_per_addr_i < 3.5), N1339_3, N1339_9));

N1339_1 :=__common__( if(((real)f_inq_lnames_per_addr_i > NULL), N1339_2, 0.022731783));

N1340_8 :=__common__( map(trim(C_HH5_P) = ''              => 0.0081706875,
               ((real)c_hh5_p < 11.4499998093) => 1.2534488e-005,
                                                  0.0081706875));

N1340_7 :=__common__( map(((real)f_fp_prevaddrcrimeindex_i <= NULL) => 0.0081432104,
               ((real)f_fp_prevaddrcrimeindex_i < 172.5) => N1340_8,
                                                            0.0081432104));

N1340_6 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 103.5), N1340_7, -0.00022724329));

N1340_5 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N1340_6, -0.0049875565));

N1340_4 :=__common__( map(trim(C_CHILD) = ''      => 0.0066987599,
               ((real)c_child < 36.75) => -0.0021280172,
                                          0.0066987599));

N1340_3 :=__common__( map(trim(C_HH4_P) = ''      => -0.0083809401,
               ((real)c_hh4_p < 20.25) => N1340_4,
                                          -0.0083809401));

N1340_2 :=__common__( if(((real)c_high_ed < 5.55000019073), N1340_3, N1340_5));

N1340_1 :=__common__( if(trim(C_HIGH_ED) != '', N1340_2, -0.00068479272));

N1341_11 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0231410749257), -0.0059048376, 0.0016122771));

N1341_10 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1341_11, -0.0082000788));

N1341_9 :=__common__( map(trim(C_HVAL_200K_P) = ''              => 0.0088083418,
               ((real)c_hval_200k_p < 8.14999961853) => -0.00086947749,
                                                        0.0088083418));

N1341_8 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N1341_9, N1341_10));

N1341_7 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => 0.012758325,
               ((real)r_c13_avg_lres_d < 42.5)  => 0.0011193589,
                                                   0.012758325));

N1341_6 :=__common__( if(((real)c_med_age < 27.5499992371), N1341_7, N1341_8));

N1341_5 :=__common__( if(trim(C_MED_AGE) != '', N1341_6, -0.0069392554));

N1341_4 :=__common__( if(((real)c_bel_edu < 193.5), -0.00066856707, -0.0083480557));

N1341_3 :=__common__( if(trim(C_BEL_EDU) != '', N1341_4, -0.0040445376));

N1341_2 :=__common__( if(((real)f_util_adl_count_n < 5.5), N1341_3, N1341_5));

N1341_1 :=__common__( if(((real)f_util_adl_count_n > NULL), N1341_2, 0.0011065417));

N1342_8 :=__common__( map(trim(C_EMPLOYEES) = ''     => -0.0011386624,
               ((real)c_employees < 35.5) => -0.0097608437,
                                             -0.0011386624));

N1342_7 :=__common__( map(trim(C_ROBBERY) = ''       => 0.00071381217,
               ((integer)c_robbery < 145) => -0.0042337368,
                                             0.00071381217));

N1342_6 :=__common__( if(((real)f_mos_liens_rel_cj_fseen_d < 115.5), 0.0064554308, N1342_7));

N1342_5 :=__common__( if(((real)f_mos_liens_rel_cj_fseen_d > NULL), N1342_6, 0.021744466));

N1342_4 :=__common__( map(trim(C_POP_35_44_P) = ''              => 0.00095731777,
               ((real)c_pop_35_44_p < 11.3500003815) => N1342_5,
                                                        0.00095731777));

N1342_3 :=__common__( map(trim(C_FEMDIV_P) = ''              => 0.0073855595,
               ((real)c_femdiv_p < 13.5500001907) => N1342_4,
                                                     0.0073855595));

N1342_2 :=__common__( if(((real)c_hh3_p < 31.25), N1342_3, N1342_8));

N1342_1 :=__common__( if(trim(C_HH3_P) != '', N1342_2, 0.00018602758));

N1343_7 :=__common__( if(((real)c_cpiall < 203.600006104), 0.011570082, 0.0020815655));

N1343_6 :=__common__( if(trim(C_CPIALL) != '', N1343_7, 0.0067503298));

N1343_5 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS FLS', 'SEARS SHO']) => -0.0026778598,
               (segment in ['KMART'])                                          => N1343_6,
                                                                                  -0.0026778598));

N1343_4 :=__common__( map(((real)c_dist_input_to_prev_addr_i <= NULL) => -0.010334726,
               ((real)c_dist_input_to_prev_addr_i < 6.5)   => -0.0015081705,
                                                              -0.010334726));

N1343_3 :=__common__( if(((real)f_varrisktype_i < 5.5), -0.00069441072, N1343_4));

N1343_2 :=__common__( if(((real)f_varrisktype_i > NULL), N1343_3, -0.002775666));

N1343_1 :=__common__( map(((real)r_has_paw_source_d <= NULL) => N1343_5,
               ((real)r_has_paw_source_d < 0.5)   => N1343_2,
                                                     N1343_5));

N1344_9 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), 0.0029715287, -0.0030970265));

N1344_8 :=__common__( map(trim(C_NEW_HOMES) = ''      => -0.00059900159,
               ((real)c_new_homes < 103.5) => 0.0096655803,
                                              -0.00059900159));

N1344_7 :=__common__( map(trim(C_OWNOCC_P) = ''              => N1344_8,
               ((real)c_ownocc_p < 57.9500007629) => 0.012742272,
                                                     N1344_8));

N1344_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.00946298055351), -0.0023412036, N1344_7));

N1344_5 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1344_6, 0.01059309));

N1344_4 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.0294571556151), N1344_5, 0.00010013412));

N1344_3 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1344_4, 0.0002746079));

N1344_2 :=__common__( if(((real)c_rnt500_p < 44.25), N1344_3, N1344_9));

N1344_1 :=__common__( if(trim(C_RNT500_P) != '', N1344_2, 0.0032649008));

N1345_8 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => 0.011111706,
               ((real)r_c10_m_hdr_fs_d < 198.5) => 0.0019389935,
                                                   0.011111706));

N1345_7 :=__common__( map(trim(C_CONSTRUCTION) = ''              => -0.0054162242,
               ((real)c_construction < 7.64999961853) => 0.0045658475,
                                                         -0.0054162242));

N1345_6 :=__common__( map(trim(C_HVAL_60K_P) = ''      => -0.0059464356,
               ((real)c_hval_60k_p < 25.25) => N1345_7,
                                               -0.0059464356));

N1345_5 :=__common__( if(((real)f_inq_communications_count24_i < 1.5), N1345_6, N1345_8));

N1345_4 :=__common__( if(((real)f_inq_communications_count24_i > NULL), N1345_5, 0.034670375));

N1345_3 :=__common__( map(trim(C_FAMMAR18_P) = ''              => -7.9706901e-005,
               ((real)c_fammar18_p < 4.14999961853) => -0.0060486364,
                                                       -7.9706901e-005));

N1345_2 :=__common__( if(((real)c_assault < 182.5), N1345_3, N1345_4));

N1345_1 :=__common__( if(trim(C_ASSAULT) != '', N1345_2, -0.00046775922));

N1346_10 :=__common__( map(trim(C_MURDERS) = ''      => -0.0024536363,
                ((real)c_murders < 165.5) => 0.00513462,
                                             -0.0024536363));

N1346_9 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => N1346_10,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0164037905633) => -0.0058183443,
                                                                       N1346_10));

N1346_8 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)    => -0.0073910907,
               ((integer)f_prevaddrmedianincome_d < 49280) => N1346_9,
                                                              -0.0073910907));

N1346_7 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), -0.0011559637, N1346_8));

N1346_6 :=__common__( if(((real)f_rel_under25miles_cnt_d < 1.5), -0.0058839231, 0.0015532206));

N1346_5 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N1346_6, 0.00073474403));

N1346_4 :=__common__( if(((real)c_hval_100k_p < 8.05000019073), N1346_5, N1346_7));

N1346_3 :=__common__( if(trim(C_HVAL_100K_P) != '', N1346_4, 0.0056925297));

N1346_2 :=__common__( if(((real)f_liens_rel_cj_total_amt_i < 2250.5), N1346_3, -0.0084315074));

N1346_1 :=__common__( if(((real)f_liens_rel_cj_total_amt_i > NULL), N1346_2, -0.0068249051));

N1347_8 :=__common__( map(trim(C_AB_AV_EDU) = ''      => 0.0011405835,
               ((real)c_ab_av_edu < 123.5) => -0.0092854035,
                                              0.0011405835));

N1347_7 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.0051167509,
               ((real)c_sub_bus < 131.5) => N1347_8,
                                            0.0051167509));

N1347_6 :=__common__( map(trim(C_MED_RENT) = ''      => -0.0071064474,
               ((real)c_med_rent < 389.5) => 0.0024044689,
                                             -0.0071064474));

N1347_5 :=__common__( map(trim(C_INCOLLEGE) = ''              => N1347_7,
               ((real)c_incollege < 7.14999961853) => N1347_6,
                                                      N1347_7));

N1347_4 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 305.5), N1347_5, 0.0046430126));

N1347_3 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N1347_4, -0.017663686));

N1347_2 :=__common__( if(((real)c_ab_av_edu < 102.5), 0.00029727486, N1347_3));

N1347_1 :=__common__( if(trim(C_AB_AV_EDU) != '', N1347_2, -0.0010724885));

N1348_8 :=__common__( map(((real)f_rel_count_i <= NULL) => 0.0065216458,
               ((real)f_rel_count_i < 19.5)  => -0.0031344024,
                                                0.0065216458));

N1348_7 :=__common__( map(((real)c_addr_lres_2mo_ct_i <= NULL) => 0.0087654978,
               ((real)c_addr_lres_2mo_ct_i < 1.5)   => -0.0040167462,
                                                       0.0087654978));

N1348_6 :=__common__( map(trim(C_UNEMP) = ''              => -0.0055601818,
               ((real)c_unemp < 7.55000019073) => N1348_7,
                                                  -0.0055601818));

N1348_5 :=__common__( map(trim(C_HH3_P) = ''              => N1348_6,
               ((real)c_hh3_p < 9.14999961853) => -0.0090660182,
                                                  N1348_6));

N1348_4 :=__common__( if(((real)r_d32_criminal_count_i < 1.5), N1348_5, N1348_8));

N1348_3 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N1348_4, 0.036016911));

N1348_2 :=__common__( if(((real)c_hh00 < 354.5), N1348_3, 0.00043936657));

N1348_1 :=__common__( if(trim(C_HH00) != '', N1348_2, -0.0013721088));

N1349_9 :=__common__( map(trim(C_HVAL_100K_P) = ''              => -0.0036215837,
               ((real)c_hval_100k_p < 10.5500001907) => 0.0064818122,
                                                        -0.0036215837));

N1349_8 :=__common__( if(((real)f_curraddrcrimeindex_i < 172.5), N1349_9, 0.010082887));

N1349_7 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N1349_8, -0.031097345));

N1349_6 :=__common__( map(trim(C_SERV_EMPL) = ''     => -0.0011262475,
               ((real)c_serv_empl < 27.5) => -0.0090834168,
                                             -0.0011262475));

N1349_5 :=__common__( map(trim(C_OLDHOUSE) = ''              => -0.00030473078,
               ((real)c_oldhouse < 31.9500007629) => 0.0070325671,
                                                     -0.00030473078));

N1349_4 :=__common__( if(((real)f_inq_communications_count24_i < 0.5), N1349_5, N1349_6));

N1349_3 :=__common__( if(((real)f_inq_communications_count24_i > NULL), N1349_4, -0.0012190185));

N1349_2 :=__common__( if(((real)c_food < 60.3499984741), N1349_3, N1349_7));

N1349_1 :=__common__( if(trim(C_FOOD) != '', N1349_2, -0.0011796627));

N1350_8 :=__common__( map(trim(C_ROBBERY) = ''      => -0.00096259889,
               ((real)c_robbery < 179.5) => 0.0066193975,
                                            -0.00096259889));

N1350_7 :=__common__( map(trim(C_PROFESSIONAL) = ''              => -0.00089509836,
               ((real)c_professional < 7.05000019073) => N1350_8,
                                                         -0.00089509836));

N1350_6 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL)  => -0.0059049135,
               ((integer)r_a50_pb_average_dollars_d < 126) => 0.0039717847,
                                                              -0.0059049135));

N1350_5 :=__common__( map(trim(C_BLUE_EMPL) = ''     => N1350_7,
               ((real)c_blue_empl < 57.5) => N1350_6,
                                             N1350_7));

N1350_4 :=__common__( if(((real)c_easiqlife < 144.5), N1350_5, -0.0055143604));

N1350_3 :=__common__( if(trim(C_EASIQLIFE) != '', N1350_4, -0.002211976));

N1350_2 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d < 76.5), N1350_3, -0.00038572317));

N1350_1 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N1350_2, -2.1825347e-005));

N1351_8 :=__common__( map(trim(C_POP_35_44_P) = ''              => 0.0070882425,
               ((real)c_pop_35_44_p < 15.3500003815) => -0.0021548298,
                                                        0.0070882425));

N1351_7 :=__common__( map(((real)f_util_add_input_conv_n <= NULL) => -0.0047366312,
               ((real)f_util_add_input_conv_n < 0.5)   => N1351_8,
                                                          -0.0047366312));

N1351_6 :=__common__( map(((real)f_prevaddrageoldest_d <= NULL) => -0.00051450506,
               ((real)f_prevaddrageoldest_d < 58.5)  => 0.0050452719,
                                                        -0.00051450506));

N1351_5 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N1351_6,
               ((real)c_hist_addr_match_i < 3.5)   => -0.00013284758,
                                                      N1351_6));

N1351_4 :=__common__( if(((real)c_hist_addr_match_i < 21.5), N1351_5, N1351_7));

N1351_3 :=__common__( if(((real)c_hist_addr_match_i > NULL), N1351_4, -0.0030489504));

N1351_2 :=__common__( if(((real)c_pop_45_54_p < 25.3499984741), N1351_3, 0.0083596659));

N1351_1 :=__common__( if(trim(C_POP_45_54_P) != '', N1351_2, -0.0010389116));

N1352_9 :=__common__( map(trim(C_RENTOCC_P) = ''              => 0.0078834741,
               ((real)c_rentocc_p < 24.5499992371) => -0.0050348217,
                                                      0.0078834741));

N1352_8 :=__common__( map(trim(C_RAPE) = ''      => 0.0057260817,
               ((real)c_rape < 130.5) => -0.0019620043,
                                         0.0057260817));

N1352_7 :=__common__( map((fp_segment in ['1 SSN Prob', '2 NAS 479', '4 Bureau Only', '5 Derog']) => -0.0024080376,
               (fp_segment in ['3 New DID', '6 Recent Activity', '7 Other'])           => N1352_8,
                                                                                          -0.0024080376));

N1352_6 :=__common__( map(((real)f_fp_prevaddrcrimeindex_i <= NULL) => N1352_7,
               ((real)f_fp_prevaddrcrimeindex_i < 64.5)  => -0.0060762928,
                                                            N1352_7));

N1352_5 :=__common__( if(((real)f_rel_incomeover100_count_d < 0.5), N1352_6, N1352_9));

N1352_4 :=__common__( if(((real)f_rel_incomeover100_count_d > NULL), N1352_5, -6.0411413e-005));

N1352_3 :=__common__( map(((real)r_i60_inq_comm_recency_d <= NULL) => 0.00068981046,
               ((real)r_i60_inq_comm_recency_d < 61.5)  => N1352_4,
                                                           0.00068981046));

N1352_2 :=__common__( if(((real)f_inq_communications_count24_i > NULL), N1352_3, 0.0086565644));

N1352_1 :=__common__( if(trim(C_POP_55_64_P) != '', N1352_2, -0.0014855324));

N1353_9 :=__common__( map(((real)f_corrssnnamecount_d <= NULL) => 0.001520955,
               ((real)f_corrssnnamecount_d < 5.5)   => 0.011961746,
                                                       0.001520955));

N1353_8 :=__common__( map(trim(C_MED_AGE) = ''              => N1353_9,
               ((real)c_med_age < 40.9500007629) => -0.0031515295,
                                                    N1353_9));

N1353_7 :=__common__( map(((real)f_varmsrcssnunrelcount_i <= NULL) => -0.0067101089,
               ((real)f_varmsrcssnunrelcount_i < 1.5)   => -0.00078234052,
                                                           -0.0067101089));

N1353_6 :=__common__( map(trim(C_HVAL_60K_P) = ''                => N1353_7,
               ((real)c_hval_60k_p < 0.0500000007451) => 0.0010657551,
                                                         N1353_7));

N1353_5 :=__common__( if(((real)c_pop_65_74_p < 11.0500001907), N1353_6, N1353_8));

N1353_4 :=__common__( if(trim(C_POP_65_74_P) != '', N1353_5, -0.0016207539));

N1353_3 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), -4.1661396e-005, N1353_4));

N1353_2 :=__common__( if(((real)f_rel_under25miles_cnt_d < 0.5), 0.0065401174, N1353_3));

N1353_1 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N1353_2, -0.0021014449));

N1354_8 :=__common__( map(((real)f_prevaddroccupantowned_d <= NULL) => -0.0049170118,
               ((real)f_prevaddroccupantowned_d < 0.5)   => 0.0016626419,
                                                            -0.0049170118));

N1354_7 :=__common__( map(((real)f_assocsuspicousidcount_i <= NULL) => 0.0020778614,
               ((real)f_assocsuspicousidcount_i < 3.5)   => 0.010733917,
                                                            0.0020778614));

N1354_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.033162266016), N1354_7, N1354_8));

N1354_5 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1354_6, 0.0040261368));

N1354_4 :=__common__( map(trim(C_PROFESSIONAL) = ''              => -0.0062881086,
               ((real)c_professional < 16.0499992371) => 0.00049675152,
                                                         -0.0062881086));

N1354_3 :=__common__( map(trim(C_BURGLARY) = ''      => -0.0036877172,
               ((real)c_burglary < 167.5) => N1354_4,
                                             -0.0036877172));

N1354_2 :=__common__( if(((real)c_murders < 181.5), N1354_3, N1354_5));

N1354_1 :=__common__( if(trim(C_MURDERS) != '', N1354_2, 0.0041547696));

N1355_7 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => -0.011422361,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0309906005859) => -4.5261101e-005,
                                                                       -0.011422361));

N1355_6 :=__common__( map(trim(C_SFDU_P) = ''      => 0.010396044,
               ((real)c_sfdu_p < 62.25) => -0.0013123186,
                                           0.010396044));

N1355_5 :=__common__( if(((integer)f_prevaddrmedianvalue_d < 186880), -0.0010272986, N1355_6));

N1355_4 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N1355_5, 0.0093767885));

N1355_3 :=__common__( if(((real)c_hval_400k_p < 13.6499996185), N1355_4, N1355_7));

N1355_2 :=__common__( if(trim(C_HVAL_400K_P) != '', N1355_3, -0.0015572405));

N1355_1 :=__common__( map(((real)c_inf_nothing_found_i <= NULL) => N1355_2,
               ((real)c_inf_nothing_found_i < 0.5)   => 0.001238726,
                                                        N1355_2));

N1356_9 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0666469186544), -0.0058439559, 0.00094073157));

N1356_8 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1356_9, -0.008204088));

N1356_7 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.256167769432), N1356_8, -0.00011043125));

N1356_6 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1356_7, 0.0014414522));

N1356_5 :=__common__( map(trim(C_POP_12_17_P) = ''              => -0.0076657121,
               ((real)c_pop_12_17_p < 8.44999980927) => 0.0035960399,
                                                        -0.0076657121));

N1356_4 :=__common__( map(trim(C_POP_75_84_P) = ''     => N1356_5,
               ((real)c_pop_75_84_p < 2.75) => 0.0084615926,
                                               N1356_5));

N1356_3 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => 0.012283678,
               ((real)r_l79_adls_per_addr_curr_i < 13.5)  => N1356_4,
                                                             0.012283678));

N1356_2 :=__common__( if(((real)c_urban_p < 0.15000000596), N1356_3, N1356_6));

N1356_1 :=__common__( if(trim(C_URBAN_P) != '', N1356_2, 0.00037375526));

N1357_9 :=__common__( map(trim(C_NO_TEENS) = ''     => -0.00063999651,
               ((real)c_no_teens < 71.5) => 0.009464221,
                                            -0.00063999651));

N1357_8 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0484892837703), N1357_9, -0.0031002172));

N1357_7 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1357_8, 0.0043674395));

N1357_6 :=__common__( map(((real)r_d33_eviction_count_i <= NULL) => -0.011051322,
               ((real)r_d33_eviction_count_i < 2.5)   => -0.0031304665,
                                                         -0.011051322));

N1357_5 :=__common__( if(((real)c_old_homes < 107.5), N1357_6, N1357_7));

N1357_4 :=__common__( if(trim(C_OLD_HOMES) != '', N1357_5, -0.0052701329));

N1357_3 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => 0.0056476122,
               ((real)r_d30_derog_count_i < 15.5)  => N1357_4,
                                                      0.0056476122));

N1357_2 :=__common__( if(((real)c_dist_input_to_prev_addr_i < 1.5), N1357_3, 0.00069416411));

N1357_1 :=__common__( if(((real)c_dist_input_to_prev_addr_i > NULL), N1357_2, 0.0030535679));

N1358_9 :=__common__( if(((real)f_rel_educationover12_count_d < 7.5), -0.0040623097, 0.005822469));

N1358_8 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N1358_9, -0.0010573713));

N1358_7 :=__common__( map(((real)r_d33_eviction_count_i <= NULL) => -0.006530335,
               ((real)r_d33_eviction_count_i < 1.5)   => N1358_8,
                                                         -0.006530335));

N1358_6 :=__common__( map(trim(C_MANY_CARS) = ''     => -0.006853591,
               ((real)c_many_cars < 61.5) => N1358_7,
                                             -0.006853591));

N1358_5 :=__common__( if(((real)c_fammar18_p < 35.25), N1358_6, 0.0032125383));

N1358_4 :=__common__( if(trim(C_FAMMAR18_P) != '', N1358_5, 0.0057302592));

N1358_3 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL)  => 0.0015862193,
               ((integer)f_curraddrcrimeindex_i < 138) => -0.00083435053,
                                                          0.0015862193));

N1358_2 :=__common__( if(((real)r_i60_inq_comm_count12_i < 1.5), N1358_3, N1358_4));

N1358_1 :=__common__( if(((real)r_i60_inq_comm_count12_i > NULL), N1358_2, 0.0072203126));

N1359_9 :=__common__( map(trim(C_POP_85P_P) = ''               => 0.010939388,
               ((real)c_pop_85p_p < 0.350000023842) => 0.0018412174,
                                                       0.010939388));

N1359_8 :=__common__( if(((real)r_c14_addrs_15yr_i < 5.5), -0.0010175537, N1359_9));

N1359_7 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N1359_8, 0.026576869));

N1359_6 :=__common__( map(trim(C_LOWRENT) = ''      => N1359_7,
               ((real)c_lowrent < 42.75) => 0.00067131975,
                                            N1359_7));

N1359_5 :=__common__( if(((real)r_c13_avg_lres_d < 21.5), 0.0040235197, -0.00169457));

N1359_4 :=__common__( if(((real)r_c13_avg_lres_d > NULL), N1359_5, 0.0088017597));

N1359_3 :=__common__( map(trim(C_MED_RENT) = ''      => N1359_6,
               ((real)c_med_rent < 455.5) => N1359_4,
                                             N1359_6));

N1359_2 :=__common__( if(((real)c_hval_400k_p < 33.4500007629), N1359_3, -0.0051499988));

N1359_1 :=__common__( if(trim(C_HVAL_400K_P) != '', N1359_2, 0.0037333929));

N1360_8 :=__common__( map(trim(C_POP00) = ''       => -0.012090072,
               ((real)c_pop00 < 1448.5) => -0.00039996598,
                                           -0.012090072));

N1360_7 :=__common__( map(trim(C_RNT750_P) = ''              => N1360_8,
               ((real)c_rnt750_p < 30.5499992371) => 0.0022672784,
                                                     N1360_8));

N1360_6 :=__common__( map(((real)r_l79_adls_per_addr_c6_i <= NULL) => -0.010066961,
               ((real)r_l79_adls_per_addr_c6_i < 2.5)   => N1360_7,
                                                           -0.010066961));

N1360_5 :=__common__( if(((real)c_unemp < 8.85000038147), N1360_6, 0.0037435597));

N1360_4 :=__common__( if(trim(C_UNEMP) != '', N1360_5, -0.0026532791));

N1360_3 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => -0.010918421,
               ((real)r_c10_m_hdr_fs_d < 284.5) => N1360_4,
                                                   -0.010918421));

N1360_2 :=__common__( if(((real)r_c14_addrs_15yr_i < 4.5), N1360_3, 0.00067659966));

N1360_1 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N1360_2, -0.012222084));

N1361_8 :=__common__( if(((real)f_college_income_d > NULL), 0.0070836519, -0.0067143489));

N1361_7 :=__common__( map(trim(C_HVAL_80K_P) = ''              => 0.0036867551,
               ((real)c_hval_80k_p < 1.65000009537) => -0.0020187759,
                                                       0.0036867551));

N1361_6 :=__common__( map(trim(C_INC_15K_P) = ''      => -0.0068629605,
               ((real)c_inc_15k_p < 37.25) => N1361_7,
                                              -0.0068629605));

N1361_5 :=__common__( if(((real)c_low_ed < 69.9499969482), N1361_6, 0.0060129053));

N1361_4 :=__common__( if(trim(C_LOW_ED) != '', N1361_5, -0.0097640485));

N1361_3 :=__common__( map(((real)f_prevaddrageoldest_d <= NULL) => N1361_4,
               ((real)f_prevaddrageoldest_d < 68.5)  => -6.5832601e-005,
                                                        N1361_4));

N1361_2 :=__common__( if(((real)r_c13_curr_addr_lres_d < 168.5), N1361_3, N1361_8));

N1361_1 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1361_2, -0.013531902));

N1362_8 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => 0.0038490234,
               ((real)r_c14_addrs_5yr_i < 1.5)   => -0.0045181519,
                                                    0.0038490234));

N1362_7 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)    => N1362_8,
               ((real)f_prevaddrmedianvalue_d < 198520.5) => -0.00061124494,
                                                             N1362_8));

N1362_6 :=__common__( map(trim(C_HVAL_80K_P) = ''              => 0.014897561,
               ((real)c_hval_80k_p < 7.05000019073) => 0.0022504726,
                                                       0.014897561));

N1362_5 :=__common__( map(trim(C_HIGH_ED) = ''              => N1362_6,
               ((real)c_high_ed < 8.85000038147) => -0.0041601547,
                                                    N1362_6));

N1362_4 :=__common__( map(((real)c_unique_addr_count_i <= NULL) => N1362_7,
               ((real)c_unique_addr_count_i < 2.5)   => N1362_5,
                                                        N1362_7));

N1362_3 :=__common__( if(trim(C_LOW_ED) != '', N1362_4, 0.0049155303));

N1362_2 :=__common__( if(((real)f_inq_highriskcredit_count24_i < 16.5), N1362_3, -0.0056107155));

N1362_1 :=__common__( if(((real)f_inq_highriskcredit_count24_i > NULL), N1362_2, 0.0028000016));

N1363_8 :=__common__( map(trim(C_BLUE_EMPL) = ''     => -0.0036739671,
               ((real)c_blue_empl < 48.5) => 0.0058984374,
                                             -0.0036739671));

N1363_7 :=__common__( map(trim(C_AB_AV_EDU) = ''     => N1363_8,
               ((real)c_ab_av_edu < 41.5) => -0.009643294,
                                             N1363_8));

N1363_6 :=__common__( if(((real)c_born_usa < 173.5), N1363_7, 0.0032016471));

N1363_5 :=__common__( if(trim(C_BORN_USA) != '', N1363_6, -0.013320825));

N1363_4 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.013167155,
               ((real)r_d32_criminal_count_i < 0.5)   => 0.0005385873,
                                                         0.013167155));

N1363_3 :=__common__( map(((real)r_a49_curr_avm_chg_1yr_i <= NULL)     => N1363_4,
               ((integer)r_a49_curr_avm_chg_1yr_i < -30041) => -0.0049349674,
                                                               N1363_4));

N1363_2 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i < -10084.5), N1363_3, N1363_5));

N1363_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N1363_2, -2.7576297e-005));

N1364_9 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.0116788577288), -0.011095666, -0.0015529379));

N1364_8 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1364_9, -0.0017192982));

N1364_7 :=__common__( map(trim(C_RNT750_P) = ''              => 0.0028312171,
               ((real)c_rnt750_p < 39.1500015259) => -0.00078162397,
                                                     0.0028312171));

N1364_6 :=__common__( map(trim(C_TRAILER_P) = ''              => 0.0077284942,
               ((real)c_trailer_p < 39.4000015259) => N1364_7,
                                                      0.0077284942));

N1364_5 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => N1364_6,
               ((real)f_srchaddrsrchcount_i < 2.5)   => -0.0022082105,
                                                        N1364_6));

N1364_4 :=__common__( if(((real)c_hval_100k_p < 18.0499992371), N1364_5, N1364_8));

N1364_3 :=__common__( if(trim(C_HVAL_100K_P) != '', N1364_4, 0.0036478299));

N1364_2 :=__common__( if(((real)f_inq_banking_count24_i < 3.5), N1364_3, 0.0069342858));

N1364_1 :=__common__( if(((real)f_inq_banking_count24_i > NULL), N1364_2, -0.0031666165));

N1365_9 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL) => -0.0024447686,
               ((real)f_prevaddrmurderindex_i < 113.5) => -0.010879536,
                                                          -0.0024447686));

N1365_8 :=__common__( map(trim(C_SERV_EMPL) = ''     => N1365_9,
               ((real)c_serv_empl < 68.5) => 0.0030412895,
                                             N1365_9));

N1365_7 :=__common__( map(((real)f_inq_highriskcredit_count24_i <= NULL) => N1365_8,
               ((real)f_inq_highriskcredit_count24_i < 7.5)   => 0.00011712504,
                                                                 N1365_8));

N1365_6 :=__common__( map(((real)r_i60_inq_count12_i <= NULL) => 0.01186984,
               ((real)r_i60_inq_count12_i < 2.5)   => 0.0022598079,
                                                      0.01186984));

N1365_5 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.403866767883), N1365_6, -0.0035145888));

N1365_4 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1365_5, 0.008907515));

N1365_3 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => N1365_7,
               ((integer)f_curraddrcartheftindex_i < 26) => N1365_4,
                                                            N1365_7));

N1365_2 :=__common__( if(trim(C_HH1_P) != '', N1365_3, -0.00033757467));

N1365_1 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N1365_2, 0.0070374996));

N1366_8 :=__common__( map(((real)f_prevaddroccupantowned_d <= NULL) => -0.011486434,
               ((real)f_prevaddroccupantowned_d < 0.5)   => 0.00026455185,
                                                            -0.011486434));

N1366_7 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL) => 0.010375925,
               ((real)f_fp_prevaddrburglaryindex_i < 107.5) => -0.0012112511,
                                                               0.010375925));

N1366_6 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => N1366_7,
               ((real)f_prevaddrmedianincome_d < 45878.5) => -0.0029328666,
                                                             N1366_7));

N1366_5 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => 0.00012642103,
               ((real)f_prevaddrmedianincome_d < 13571.5) => 0.0045045871,
                                                             0.00012642103));

N1366_4 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => 0.0071671929,
               ((real)f_add_input_nhood_vac_pct_i < 0.641255140305) => N1366_5,
                                                                       0.0071671929));

N1366_3 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1366_4, N1366_6));

N1366_2 :=__common__( if(((integer)f_liens_unrel_cj_total_amt_i < 8767), N1366_3, N1366_8));

N1366_1 :=__common__( if(((real)f_liens_unrel_cj_total_amt_i > NULL), N1366_2, -0.0057533214));

N1367_7 :=__common__( map(trim(C_HH5_P) = ''              => -0.0016838433,
               ((real)c_hh5_p < 0.15000000596) => 0.0026085479,
                                                  -0.0016838433));

N1367_6 :=__common__( map(trim(C_RELIG_INDX) = ''     => N1367_7,
               ((real)c_relig_indx < 84.5) => 0.0013345878,
                                              N1367_7));

N1367_5 :=__common__( map(trim(C_RNT250_P) = ''              => 1.6512852e-005,
               ((real)c_rnt250_p < 46.9500007629) => 0.0089606037,
                                                     1.6512852e-005));

N1367_4 :=__common__( map(trim(C_MED_RENT) = ''      => N1367_6,
               ((real)c_med_rent < 278.5) => N1367_5,
                                             N1367_6));

N1367_3 :=__common__( map(trim(C_POP_55_64_P) = ''              => 5.4037859e-005,
               ((real)c_pop_55_64_p < 10.8500003815) => -0.008379683,
                                                        5.4037859e-005));

N1367_2 :=__common__( if(((real)c_serv_empl < 29.5), N1367_3, N1367_4));

N1367_1 :=__common__( if(trim(C_SERV_EMPL) != '', N1367_2, 0.0001808557));

N1368_8 :=__common__( map(trim(C_BIGAPT_P) = ''               => 0.0002702294,
               ((real)c_bigapt_p < 0.649999976158) => -0.0075123306,
                                                      0.0002702294));

N1368_7 :=__common__( map(trim(C_RICH_NFAM) = ''      => N1368_8,
               ((real)c_rich_nfam < 166.5) => 0.0011851057,
                                              N1368_8));

N1368_6 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => -0.00569757,
               ((real)f_curraddrmurderindex_i < 175.5) => 0.0006978364,
                                                          -0.00569757));

N1368_5 :=__common__( map(trim(C_SFDU_P) = ''              => -0.010741367,
               ((real)c_sfdu_p < 89.5500030518) => N1368_6,
                                                   -0.010741367));

N1368_4 :=__common__( if(((real)r_d33_eviction_count_i < 2.5), N1368_5, 0.0058694836));

N1368_3 :=__common__( if(((real)r_d33_eviction_count_i > NULL), N1368_4, -0.009058005));

N1368_2 :=__common__( if(((real)c_med_hval < 64535.5), N1368_3, N1368_7));

N1368_1 :=__common__( if(trim(C_MED_HVAL) != '', N1368_2, 0.00068523971));

N1369_8 :=__common__( map(trim(C_HH2_P) = ''              => 0.0044438436,
               ((real)c_hh2_p < 40.8499984741) => -0.0039353356,
                                                  0.0044438436));

N1369_7 :=__common__( map(trim(C_SFDU_P) = ''              => -0.00026214228,
               ((real)c_sfdu_p < 53.0499992371) => -0.0054441729,
                                                   -0.00026214228));

N1369_6 :=__common__( map(trim(C_POP_35_44_P) = ''              => N1369_7,
               ((real)c_pop_35_44_p < 15.6499996185) => 0.0010401723,
                                                        N1369_7));

N1369_5 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 6.5), 0.0067348345, N1369_6));

N1369_4 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N1369_5, 0.0031224306));

N1369_3 :=__common__( map(((real)f_inq_ssns_per_addr_i <= NULL) => -0.0046338904,
               ((real)f_inq_ssns_per_addr_i < 4.5)   => N1369_4,
                                                        -0.0046338904));

N1369_2 :=__common__( if(((real)c_pop_18_24_p < 15.25), N1369_3, N1369_8));

N1369_1 :=__common__( if(trim(C_POP_18_24_P) != '', N1369_2, -0.0015481158));

N1370_10 :=__common__( if(((real)c_inc_35k_p < 12.75), 0.00089589766, 0.0099077493));

N1370_9 :=__common__( if(trim(C_INC_35K_P) != '', N1370_10, -0.0031307073));

N1370_8 :=__common__( if(((real)f_rel_educationover8_count_d < 25.5), 9.2834738e-005, N1370_9));

N1370_7 :=__common__( if(((real)f_rel_educationover8_count_d > NULL), N1370_8, -0.0023696801));

N1370_6 :=__common__( map(trim(C_HEALTH) = ''     => -0.00012825629,
               ((real)c_health < 1.75) => -0.0072823653,
                                          -0.00012825629));

N1370_5 :=__common__( map(((real)f_srchfraudsrchcountyr_i <= NULL) => 0.0027926165,
               ((real)f_srchfraudsrchcountyr_i < 1.5)   => N1370_6,
                                                           0.0027926165));

N1370_4 :=__common__( if(((real)c_highinc < 2.54999995232), -0.0047092883, N1370_5));

N1370_3 :=__common__( if(trim(C_HIGHINC) != '', N1370_4, -0.0090725578));

N1370_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 95.5), N1370_3, N1370_7));

N1370_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N1370_2, -0.0011505361));

N1371_9 :=__common__( if(((real)f_rel_ageover30_count_d < 7.5), 0.010376502, -0.002544344));

N1371_8 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N1371_9, -0.0061492939));

N1371_7 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => 0.0031243437,
               ((real)f_add_curr_nhood_vac_pct_i < 0.210441142321) => -0.0057660932,
                                                                      0.0031243437));

N1371_6 :=__common__( if(((real)r_d33_eviction_recency_d < 79.5), 0.0017213163, N1371_7));

N1371_5 :=__common__( if(((real)r_d33_eviction_recency_d > NULL), N1371_6, -0.0063825734));

N1371_4 :=__common__( map(trim(C_BIGAPT_P) = ''      => N1371_8,
               ((real)c_bigapt_p < 19.25) => N1371_5,
                                             N1371_8));

N1371_3 :=__common__( map(trim(C_HVAL_40K_P) = ''              => 0.0037190596,
               ((real)c_hval_40k_p < 13.4499998093) => 0.00045442236,
                                                       0.0037190596));

N1371_2 :=__common__( if(((real)c_hh1_p < 38.5499992371), N1371_3, N1371_4));

N1371_1 :=__common__( if(trim(C_HH1_P) != '', N1371_2, -0.0037435655));

N1372_9 :=__common__( map(trim(C_RNT250_P) = ''                => -0.00070733131,
               ((real)c_rnt250_p < 0.0500000007451) => 0.010036389,
                                                       -0.00070733131));

N1372_8 :=__common__( map(trim(C_HVAL_300K_P) = ''               => 0.008823834,
               ((real)c_hval_300k_p < 0.949999988079) => -0.0017296513,
                                                         0.008823834));

N1372_7 :=__common__( map(((real)f_prevaddrdwelltype_apt_n <= NULL) => N1372_8,
               ((real)f_prevaddrdwelltype_apt_n < 0.5)   => -0.0021470506,
                                                            N1372_8));

N1372_6 :=__common__( if(((real)c_hval_125k_p < 23.3499984741), N1372_7, N1372_9));

N1372_5 :=__common__( if(trim(C_HVAL_125K_P) != '', N1372_6, 0.0027030734));

N1372_4 :=__common__( map(((real)r_d33_eviction_count_i <= NULL) => -0.0056114369,
               ((real)r_d33_eviction_count_i < 6.5)   => 0.00088108669,
                                                         -0.0056114369));

N1372_3 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1372_4, N1372_5));

N1372_2 :=__common__( if(((real)f_rel_criminal_count_i < 20.5), N1372_3, -0.0071285802));

N1372_1 :=__common__( if(((real)f_rel_criminal_count_i > NULL), N1372_2, -0.0030698345));

N1373_7 :=__common__( map(trim(C_EASIQLIFE) = ''     => -0.0010804101,
               ((real)c_easiqlife < 88.5) => 0.0079189552,
                                             -0.0010804101));

N1373_6 :=__common__( map(trim(C_POP_25_34_P) = ''              => -0.0093353845,
               ((real)c_pop_25_34_p < 21.5499992371) => N1373_7,
                                                        -0.0093353845));

N1373_5 :=__common__( map(trim(C_HVAL_125K_P) = ''              => -0.0077621852,
               ((real)c_hval_125k_p < 19.0499992371) => N1373_6,
                                                        -0.0077621852));

N1373_4 :=__common__( map(trim(C_HVAL_250K_P) = ''              => -0.0092487846,
               ((real)c_hval_250k_p < 22.9500007629) => N1373_5,
                                                        -0.0092487846));

N1373_3 :=__common__( map(trim(C_APT20) = ''      => 0.0093352045,
               ((real)c_apt20 < 175.5) => N1373_4,
                                          0.0093352045));

N1373_2 :=__common__( if(((real)c_high_hval < 0.0500000007451), 0.0011923532, N1373_3));

N1373_1 :=__common__( if(trim(C_HIGH_HVAL) != '', N1373_2, 0.00024055496));

N1374_8 :=__common__( map(trim(C_HEALTH) = ''              => 0.0067825537,
               ((real)c_health < 12.6499996185) => -1.7301226e-005,
                                                   0.0067825537));

N1374_7 :=__common__( map(trim(C_HH1_P) = ''              => -0.0038539746,
               ((real)c_hh1_p < 38.6500015259) => N1374_8,
                                                  -0.0038539746));

N1374_6 :=__common__( map(trim(C_WHOLESALE) = ''              => -0.0047879164,
               ((real)c_wholesale < 2.04999995232) => N1374_7,
                                                      -0.0047879164));

N1374_5 :=__common__( map(trim(C_CHILD) = ''              => -0.0064015582,
               ((real)c_child < 34.5499992371) => N1374_6,
                                                  -0.0064015582));

N1374_4 :=__common__( map(trim(C_POP_45_54_P) = ''              => -0.0041111387,
               ((real)c_pop_45_54_p < 19.8499984741) => 0.00072951724,
                                                        -0.0041111387));

N1374_3 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1374_4, N1374_5));

N1374_2 :=__common__( if(((real)c_hval_125k_p < 39.5499992371), N1374_3, 0.0054053514));

N1374_1 :=__common__( if(trim(C_HVAL_125K_P) != '', N1374_2, 0.0012118435));

N1375_7 :=__common__( map(((real)f_divaddrsuspidcountnew_i <= NULL) => 0.0028549815,
               ((real)f_divaddrsuspidcountnew_i < 1.5)   => -0.0043112228,
                                                            0.0028549815));

N1375_6 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => -0.0011071356,
               ((real)r_c12_num_nonderogs_d < 6.5)   => 0.0090912432,
                                                        -0.0011071356));

N1375_5 :=__common__( if(((real)f_srchunvrfdphonecount_i < 0.5), N1375_6, N1375_7));

N1375_4 :=__common__( if(((real)f_srchunvrfdphonecount_i > NULL), N1375_5, -0.02001887));

N1375_3 :=__common__( if(((real)c_popover25 < 361.5), -0.0080397309, 0.00075170643));

N1375_2 :=__common__( if(trim(C_POPOVER25) != '', N1375_3, -0.0027599468));

N1375_1 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => N1375_4,
               ((real)f_inq_adls_per_phone_i < 0.5)   => N1375_2,
                                                         N1375_4));

N1376_11 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => -0.0076471864,
                ((real)f_curraddrburglaryindex_i < 137.5) => 0.0012662676,
                                                             -0.0076471864));

N1376_10 :=__common__( if(trim(C_LOW_ED) != '', N1376_11, -0.0096261501));

N1376_9 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => 0.0068072527,
               ((real)f_mos_inq_banko_cm_lseen_d < 46.5)  => N1376_10,
                                                             0.0068072527));

N1376_8 :=__common__( if(((real)f_prevaddrstatus_i < 2.5), N1376_9, -0.0077110866));

N1376_7 :=__common__( if(((real)f_prevaddrstatus_i > NULL), N1376_8, -0.0076770694));

N1376_6 :=__common__( if(((real)c_wholesale < 16.75), -0.0010942024, 0.0088600484));

N1376_5 :=__common__( if(trim(C_WHOLESALE) != '', N1376_6, -0.0047982822));

N1376_4 :=__common__( if(((real)f_rel_under500miles_cnt_d < 13.5), N1376_5, 0.0014224695));

N1376_3 :=__common__( if(((real)f_rel_under500miles_cnt_d > NULL), N1376_4, 0.0023028012));

N1376_2 :=__common__( if(((real)r_i60_inq_count12_i < 7.5), N1376_3, N1376_7));

N1376_1 :=__common__( if(((real)r_i60_inq_count12_i > NULL), N1376_2, -0.0020068773));

N1377_9 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => -0.0054214676,
               ((real)r_c21_m_bureau_adl_fs_d < 191.5) => 0.0046201746,
                                                          -0.0054214676));

N1377_8 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 120.5), -0.0094110219, N1377_9));

N1377_7 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N1377_8, 0.00020636055));

N1377_6 :=__common__( map(trim(C_INCOLLEGE) = ''              => 0.0021333553,
               ((real)c_incollege < 6.55000019073) => -0.0060834977,
                                                      0.0021333553));

N1377_5 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1377_6, -0.002611104));

N1377_4 :=__common__( map(trim(C_INC_35K_P) = ''              => 0.00083829072,
               ((real)c_inc_35k_p < 5.94999980927) => N1377_5,
                                                      0.00083829072));

N1377_3 :=__common__( map(trim(C_INC_200K_P) = ''              => 0.0088433916,
               ((real)c_inc_200k_p < 11.6499996185) => N1377_4,
                                                       0.0088433916));

N1377_2 :=__common__( if(((real)c_inc_50k_p < 23.8499984741), N1377_3, N1377_7));

N1377_1 :=__common__( if(trim(C_INC_50K_P) != '', N1377_2, 0.0010023314));

N1378_9 :=__common__( map(((real)f_srchphonesrchcount_i <= NULL) => 0.008142357,
               ((real)f_srchphonesrchcount_i < 1.5)   => -0.00066150036,
                                                         0.008142357));

N1378_8 :=__common__( map(trim(C_FAMMAR_P) = ''              => N1378_9,
               ((real)c_fammar_p < 37.8499984741) => 0.012326853,
                                                     N1378_9));

N1378_7 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => 0.0018222357,
               ((real)f_add_curr_nhood_vac_pct_i < 0.033458955586) => -0.0045660299,
                                                                      0.0018222357));

N1378_6 :=__common__( map(trim(C_PROFESSIONAL) = ''              => N1378_8,
               ((real)c_professional < 3.45000004768) => N1378_7,
                                                         N1378_8));

N1378_5 :=__common__( if(((integer)f_addrchangeincomediff_d < -19971), -0.0043135219, N1378_6));

N1378_4 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1378_5, -0.001522853));

N1378_3 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), -6.3227748e-005, N1378_4));

N1378_2 :=__common__( if(((real)r_c13_avg_lres_d < 158.5), N1378_3, 0.0071830319));

N1378_1 :=__common__( if(((real)r_c13_avg_lres_d > NULL), N1378_2, 0.002391474));

N1379_9 :=__common__( if(((real)c_fammar18_p < 26.75), -0.0048014057, 0.00038031681));

N1379_8 :=__common__( if(trim(C_FAMMAR18_P) != '', N1379_9, 0.0031994024));

N1379_7 :=__common__( map(((real)f_estimated_income_d <= NULL)    => 0.0011102307,
               ((integer)f_estimated_income_d < 29500) => -0.0082752001,
                                                          0.0011102307));

N1379_6 :=__common__( map(trim(C_NO_LABFOR) = ''      => N1379_7,
               ((real)c_no_labfor < 162.5) => 0.0012267601,
                                              N1379_7));

N1379_5 :=__common__( if(((real)c_unempl < 67.5), -0.0048893606, N1379_6));

N1379_4 :=__common__( if(trim(C_UNEMPL) != '', N1379_5, -0.001438626));

N1379_3 :=__common__( map(((real)f_inq_count24_i <= NULL) => 0.0035919097,
               ((real)f_inq_count24_i < 10.5)  => N1379_4,
                                                  0.0035919097));

N1379_2 :=__common__( if(((real)f_rel_homeover50_count_d < 20.5), N1379_3, N1379_8));

N1379_1 :=__common__( if(((real)f_rel_homeover50_count_d > NULL), N1379_2, 0.0039977701));

N1380_10 :=__common__( map(trim(C_OLDHOUSE) = ''              => 0.00085108103,
                ((real)c_oldhouse < 163.199996948) => -0.011188084,
                                                      0.00085108103));

N1380_9 :=__common__( if(((real)c_for_sale < 191.5), 0.00077227001, N1380_10));

N1380_8 :=__common__( if(trim(C_FOR_SALE) != '', N1380_9, -0.0040345355));

N1380_7 :=__common__( if(((real)f_addrchangecrimediff_i < 5.5), -0.0080157495, 0.0044596891));

N1380_6 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N1380_7, -0.0041428157));

N1380_5 :=__common__( map(((real)r_a44_curr_add_naprop_d <= NULL) => 0.0039655466,
               ((real)r_a44_curr_add_naprop_d < 0.5)   => N1380_6,
                                                          0.0039655466));

N1380_4 :=__common__( if(((real)c_pop_45_54_p < 13.25), N1380_5, -0.0049548286));

N1380_3 :=__common__( if(trim(C_POP_45_54_P) != '', N1380_4, 0.0013309702));

N1380_2 :=__common__( if(((real)f_srchaddrsrchcount_i < 1.5), N1380_3, N1380_8));

N1380_1 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N1380_2, -0.0036201371));

N1381_10 :=__common__( map(trim(C_UNATTACH) = ''      => -0.00015735279,
                ((real)c_unattach < 122.5) => -0.00516339,
                                              -0.00015735279));

N1381_9 :=__common__( map(trim(C_RNT750_P) = ''              => 0.007492371,
               ((real)c_rnt750_p < 68.9499969482) => N1381_10,
                                                     0.007492371));

N1381_8 :=__common__( if(((real)c_rental < 148.5), 0.0015697581, N1381_9));

N1381_7 :=__common__( if(trim(C_RENTAL) != '', N1381_8, -0.00031433365));

N1381_6 :=__common__( map(trim(C_RETIRED2) = ''     => -0.0014823242,
               ((real)c_retired2 < 88.5) => 0.010509498,
                                            -0.0014823242));

N1381_5 :=__common__( if(((real)c_pop_45_54_p < 8.85000038147), N1381_6, -0.00018992249));

N1381_4 :=__common__( if(trim(C_POP_45_54_P) != '', N1381_5, -0.0097370634));

N1381_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1381_4, N1381_7));

N1381_2 :=__common__( if(((real)c_mos_since_impulse_ls_d < 28.5), -0.0077309511, N1381_3));

N1381_1 :=__common__( if(((real)c_mos_since_impulse_ls_d > NULL), N1381_2, -0.0013646949));

N1382_8 :=__common__( map(trim(C_INCOLLEGE) = ''              => -0.0049836027,
               ((real)c_incollege < 7.14999961853) => 0.0049688893,
                                                      -0.0049836027));

N1382_7 :=__common__( map(trim(C_EASIQLIFE) = ''     => N1382_8,
               ((real)c_easiqlife < 98.5) => 0.010892488,
                                             N1382_8));

N1382_6 :=__common__( map(trim(C_MURDERS) = ''      => -7.9910211e-005,
               ((integer)c_murders < 37) => N1382_7,
                                            -7.9910211e-005));

N1382_5 :=__common__( map(trim(C_BARGAINS) = ''     => N1382_6,
               ((real)c_bargains < 22.5) => 0.0051812198,
                                            N1382_6));

N1382_4 :=__common__( if(((real)f_prevaddrmedianvalue_d < 130118.5), -0.0082615814, 0.00015826927));

N1382_3 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N1382_4, 0.013119064));

N1382_2 :=__common__( if(((real)c_retired < 3.04999995232), N1382_3, N1382_5));

N1382_1 :=__common__( if(trim(C_RETIRED) != '', N1382_2, -0.0013753908));

N1383_9 :=__common__( map(((real)f_prevaddrageoldest_d <= NULL) => -0.00069732003,
               ((real)f_prevaddrageoldest_d < 9.5)   => -0.0084562392,
                                                        -0.00069732003));

N1383_8 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => N1383_9,
               ((real)f_add_curr_nhood_vac_pct_i < 0.155508875847) => 0.0012464915,
                                                                      N1383_9));

N1383_7 :=__common__( if(((real)c_oldhouse < 1054.09997559), N1383_8, 0.0083087243));

N1383_6 :=__common__( if(trim(C_OLDHOUSE) != '', N1383_7, 0.0062286783));

N1383_5 :=__common__( if(((real)c_construction < 5.35000038147), -0.008487906, -0.000447289));

N1383_4 :=__common__( if(trim(C_CONSTRUCTION) != '', N1383_5, -0.0098769023));

N1383_3 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => 0.0029356775,
               ((real)r_c13_max_lres_d < 145.5) => N1383_4,
                                                   0.0029356775));

N1383_2 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 240.5), N1383_3, N1383_6));

N1383_1 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N1383_2, -0.0072296475));

N1384_8 :=__common__( map(((real)c_inf_nothing_found_i <= NULL) => -0.00079301856,
               ((real)c_inf_nothing_found_i < 0.5)   => -0.01243363,
                                                        -0.00079301856));

N1384_7 :=__common__( map(trim(C_FAMMAR18_P) = ''              => N1384_8,
               ((real)c_fammar18_p < 16.1500015259) => 0.0024610523,
                                                       N1384_8));

N1384_6 :=__common__( map(((real)f_historical_count_d <= NULL) => 0.0010300681,
               ((real)f_historical_count_d < 0.5)   => -0.0017956842,
                                                       0.0010300681));

N1384_5 :=__common__( map(trim(C_HVAL_60K_P) = ''              => 0.010634773,
               ((real)c_hval_60k_p < 5.64999961853) => 0.00096057295,
                                                       0.010634773));

N1384_4 :=__common__( if(((real)f_curraddrmedianvalue_d < 37261.5), N1384_5, N1384_6));

N1384_3 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N1384_4, -0.0018751914));

N1384_2 :=__common__( if(((real)c_pop_45_54_p < 21.6500015259), N1384_3, N1384_7));

N1384_1 :=__common__( if(trim(C_POP_45_54_P) != '', N1384_2, 0.0018924754));

N1385_9 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0163722801954), -0.004825365, 0.00056540499));

N1385_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1385_9, -0.00046150446));

N1385_7 :=__common__( map(trim(C_LOW_ED) = ''              => 0.0064772363,
               ((real)c_low_ed < 70.5500030518) => N1385_8,
                                                   0.0064772363));

N1385_6 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.0069392096,
               ((real)r_d32_criminal_count_i < 11.5)  => N1385_7,
                                                         0.0069392096));

N1385_5 :=__common__( if(((real)f_rel_educationover8_count_d < 36.5), N1385_6, -0.010101825));

N1385_4 :=__common__( if(((real)f_rel_educationover8_count_d > NULL), N1385_5, 0.0033159291));

N1385_3 :=__common__( map(trim(C_INCOLLEGE) = ''              => N1385_4,
               ((real)c_incollege < 4.94999980927) => -0.0019704736,
                                                      N1385_4));

N1385_2 :=__common__( if(((real)c_med_rent < 157.5), 0.0072701027, N1385_3));

N1385_1 :=__common__( if(trim(C_MED_RENT) != '', N1385_2, 0.00018401345));

N1386_9 :=__common__( map(trim(C_INC_15K_P) = ''              => -0.0015817172,
               ((real)c_inc_15k_p < 22.8499984741) => 0.00979553,
                                                      -0.0015817172));

N1386_8 :=__common__( map(trim(C_RETAIL) = ''      => 0.0045445318,
               ((real)c_retail < 41.75) => -0.00046458815,
                                           0.0045445318));

N1386_7 :=__common__( if(((real)c_rnt500_p < 73.0500030518), N1386_8, N1386_9));

N1386_6 :=__common__( if(trim(C_RNT500_P) != '', N1386_7, -0.002173225));

N1386_5 :=__common__( map(trim(C_FOOD) = ''              => -0.0022819961,
               ((real)c_food < 19.0499992371) => -0.013593837,
                                                 -0.0022819961));

N1386_4 :=__common__( if(((real)c_born_usa < 72.5), 0.0026530974, N1386_5));

N1386_3 :=__common__( if(trim(C_BORN_USA) != '', N1386_4, 0.0037058145));

N1386_2 :=__common__( if(((real)f_mos_liens_unrel_lt_lseen_d < 47.5), N1386_3, N1386_6));

N1386_1 :=__common__( if(((real)f_mos_liens_unrel_lt_lseen_d > NULL), N1386_2, 0.00087245112));

N1387_9 :=__common__( map(((real)r_d34_unrel_liens_ct_i <= NULL) => 0.0049208252,
               ((real)r_d34_unrel_liens_ct_i < 3.5)   => -0.0012129318,
                                                         0.0049208252));

N1387_8 :=__common__( if(((integer)f_curraddrcrimeindex_i < 82), 0.0072659991, N1387_9));

N1387_7 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N1387_8, -0.0010542668));

N1387_6 :=__common__( map(trim(C_HVAL_150K_P) = ''      => 0.0056547772,
               ((real)c_hval_150k_p < 28.25) => -0.0015049131,
                                                0.0056547772));

N1387_5 :=__common__( map(trim(C_POP_0_5_P) = ''              => N1387_7,
               ((real)c_pop_0_5_p < 10.8500003815) => N1387_6,
                                                      N1387_7));

N1387_4 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.0092742908746), 0.0043136454, N1387_5));

N1387_3 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1387_4, -0.0002940453));

N1387_2 :=__common__( if(((real)c_hh3_p < 29.9500007629), N1387_3, 0.0043807217));

N1387_1 :=__common__( if(trim(C_HH3_P) != '', N1387_2, -0.0032003279));

N1388_8 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.0072177471,
               ((real)r_c14_addrs_10yr_i < 4.5)   => -0.0026072644,
                                                     0.0072177471));

N1388_7 :=__common__( map(trim(C_EMPLOYEES) = ''      => -0.005055537,
               ((real)c_employees < 258.5) => N1388_8,
                                              -0.005055537));

N1388_6 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => 0.0014867104,
               ((real)r_c13_max_lres_d < 134.5) => -0.0058942597,
                                                   0.0014867104));

N1388_5 :=__common__( map(trim(C_POP_65_74_P) = ''              => N1388_7,
               ((real)c_pop_65_74_p < 5.05000019073) => N1388_6,
                                                        N1388_7));

N1388_4 :=__common__( if(((real)c_hh4_p < 17.5499992371), 0.00066754126, N1388_5));

N1388_3 :=__common__( if(trim(C_HH4_P) != '', N1388_4, -0.0019158511));

N1388_2 :=__common__( if(((real)r_d31_bk_filing_count_i < 2.5), N1388_3, 0.0082525972));

N1388_1 :=__common__( if(((real)r_d31_bk_filing_count_i > NULL), N1388_2, 0.0089651649));

N1389_10 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => -0.0010042257,
                ((real)r_c13_avg_lres_d < 54.5)  => 0.0092025095,
                                                    -0.0010042257));

N1389_9 :=__common__( if(((real)c_pop_6_11_p < 8.85000038147), -0.0011800973, 0.010830901));

N1389_8 :=__common__( if(trim(C_POP_6_11_P) != '', N1389_9, -0.0079164872));

N1389_7 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL) => -0.00022864334,
               ((real)f_curraddrcrimeindex_i < 32.5)  => -0.0045167905,
                                                         -0.00022864334));

N1389_6 :=__common__( if(trim(C_NEW_HOMES) != '', N1389_7, 0.00011455392));

N1389_5 :=__common__( map(((real)f_varmsrcssncount_i <= NULL) => N1389_8,
               ((real)f_varmsrcssncount_i < 2.5)   => N1389_6,
                                                      N1389_8));

N1389_4 :=__common__( if(((real)c_mos_since_impulse_ls_d < 28.5), -0.0073506832, N1389_5));

N1389_3 :=__common__( if(((real)c_mos_since_impulse_ls_d > NULL), N1389_4, -0.00011192607));

N1389_2 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d < 0.993349552155), N1389_3, N1389_10));

N1389_1 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d > NULL), N1389_2, 0.0031464987));

N1390_11 :=__common__( if(((real)f_curraddrmedianvalue_d < 93450.5), -0.010908539, 0.0044300457));

N1390_10 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N1390_11, 0.0060038785));

N1390_9 :=__common__( if(((integer)r_a49_curr_avm_chg_1yr_i < -6195), 0.0083300172, -0.0024943023));

N1390_8 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N1390_9, 0.0010485614));

N1390_7 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.00695048319176), -0.0085591329, N1390_8));

N1390_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1390_7, N1390_10));

N1390_5 :=__common__( if(((real)f_curraddrmedianvalue_d < 76958.5), 0.011145974, 0.0013258042));

N1390_4 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N1390_5, -0.032924008));

N1390_3 :=__common__( map(trim(C_MORT_INDX) = ''     => N1390_6,
               ((real)c_mort_indx < 62.5) => N1390_4,
                                             N1390_6));

N1390_2 :=__common__( if(((real)c_hval_100k_p < 11.5500001907), -0.0013320171, N1390_3));

N1390_1 :=__common__( if(trim(C_HVAL_100K_P) != '', N1390_2, -0.0020096704));

N1391_8 :=__common__( map(trim(C_POP_35_44_P) = ''              => 0.00041545799,
               ((real)c_pop_35_44_p < 10.8500003815) => -0.0080888418,
                                                        0.00041545799));

N1391_7 :=__common__( map(trim(C_TOTCRIME) = ''      => N1391_8,
               ((real)c_totcrime < 101.5) => -0.013263913,
                                             N1391_8));

N1391_6 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => N1391_7,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0694329664111) => 0.00018063697,
                                                                       N1391_7));

N1391_5 :=__common__( map(trim(C_RENTAL) = ''      => 0.0054330064,
               ((real)c_rental < 184.5) => N1391_6,
                                           0.0054330064));

N1391_4 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N1391_5, 0.00011884618));

N1391_3 :=__common__( map(trim(C_BEL_EDU) = ''     => N1391_4,
               ((real)c_bel_edu < 45.5) => -0.0086773801,
                                           N1391_4));

N1391_2 :=__common__( if(((real)c_bel_edu < 38.5), 0.0040775192, N1391_3));

N1391_1 :=__common__( if(trim(C_BEL_EDU) != '', N1391_2, -1.9234563e-006));

N1392_10 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)   => 0.0072509265,
                ((real)f_prevaddrmedianvalue_d < 89196.5) => -0.0022930917,
                                                             0.0072509265));

N1392_9 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => -0.0063736049,
               ((real)f_mos_liens_unrel_cj_fseen_d < 88.5)  => -6.3384606e-005,
                                                               -0.0063736049));

N1392_8 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.228419005871), 0.0035859782, N1392_9));

N1392_7 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1392_8, -0.028138259));

N1392_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.170263692737), N1392_7, 0.0037253431));

N1392_5 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1392_6, 0.0028146719));

N1392_4 :=__common__( if(((real)r_c13_max_lres_d < 148.5), N1392_5, N1392_10));

N1392_3 :=__common__( if(((real)r_c13_max_lres_d > NULL), N1392_4, -0.0017562024));

N1392_2 :=__common__( if(((real)c_inc_35k_p < 14.3500003815), 0.00045325187, N1392_3));

N1392_1 :=__common__( if(trim(C_INC_35K_P) != '', N1392_2, 0.0010578467));

N1393_9 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => -0.00014943172,
               ((real)f_mos_liens_unrel_cj_fseen_d < 274.5) => -0.0080419069,
                                                               -0.00014943172));

N1393_8 :=__common__( if(((real)c_dist_best_to_prev_addr_i < 0.5), 0.0033134867, N1393_9));

N1393_7 :=__common__( if(((real)c_dist_best_to_prev_addr_i > NULL), N1393_8, 0.02410158));

N1393_6 :=__common__( map(trim(C_TOTCRIME) = ''       => N1393_7,
               ((integer)c_totcrime < 142) => -0.0081361854,
                                              N1393_7));

N1393_5 :=__common__( if(((real)c_larceny < 158.5), 0.0001424283, N1393_6));

N1393_4 :=__common__( if(trim(C_LARCENY) != '', N1393_5, -0.0039737003));

N1393_3 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.0011726753,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0805822983384) => N1393_4,
                                                                       0.0011726753));

N1393_2 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d < 0.994023025036), N1393_3, 0.0063822156));

N1393_1 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d > NULL), N1393_2, -0.014179214));

N1394_10 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.177215278149), 0.016328869, 0.0022615116));

N1394_9 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1394_10, 0.0018912688));

N1394_8 :=__common__( map(trim(C_FOR_SALE) = ''      => N1394_9,
               ((real)c_for_sale < 104.5) => 0.0010160458,
                                             N1394_9));

N1394_7 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => -0.0068040653,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0273895002902) => 0.0026575266,
                                                                       -0.0068040653));

N1394_6 :=__common__( if(((real)f_prevaddrlenofres_d < 13.5), N1394_7, N1394_8));

N1394_5 :=__common__( if(((real)f_prevaddrlenofres_d > NULL), N1394_6, 0.0010130578));

N1394_4 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i < 12.5), -0.0012706016, 0.0044247869));

N1394_3 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i > NULL), N1394_4, -0.002778892));

N1394_2 :=__common__( if(((real)c_high_hval < 2.65000009537), N1394_3, N1394_5));

N1394_1 :=__common__( if(trim(C_HIGH_HVAL) != '', N1394_2, -0.0029100907));

N1395_6 :=__common__( map(trim(C_FOOD) = ''              => 0.0050942551,
               ((real)c_food < 21.5499992371) => -0.0078814485,
                                                 0.0050942551));

N1395_5 :=__common__( map(trim(C_POP_65_74_P) = ''     => -0.0032871433,
               ((real)c_pop_65_74_p < 5.25) => 0.0070912108,
                                               -0.0032871433));

N1395_4 :=__common__( map(trim(C_UNEMP) = ''              => N1395_5,
               ((real)c_unemp < 5.44999980927) => 0.01278978,
                                                  N1395_5));

N1395_3 :=__common__( if(((real)c_easiqlife < 134.5), N1395_4, N1395_6));

N1395_2 :=__common__( if(trim(C_EASIQLIFE) != '', N1395_3, 0.021981291));

N1395_1 :=__common__( map(((real)f_util_add_curr_inf_n <= NULL) => N1395_2,
               ((real)f_util_add_curr_inf_n < 0.5)   => -0.00045040312,
                                                        N1395_2));

N1396_9 :=__common__( if(((real)c_dist_best_to_prev_addr_i < 7.5), 0.0016701648, 0.0099506564));

N1396_8 :=__common__( if(((real)c_dist_best_to_prev_addr_i > NULL), N1396_9, 0.02581521));

N1396_7 :=__common__( map(trim(C_EASIQLIFE) = ''     => -0.0095255375,
               ((real)c_easiqlife < 86.5) => 0.00252236,
                                             -0.0095255375));

N1396_6 :=__common__( map(trim(C_POP00) = ''       => 0.0039285255,
               ((real)c_pop00 < 1129.5) => N1396_7,
                                           0.0039285255));

N1396_5 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d < 27.5), -0.0057535332, N1396_6));

N1396_4 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N1396_5, 0.0053864648));

N1396_3 :=__common__( map(trim(C_UNATTACH) = ''      => N1396_8,
               ((real)c_unattach < 125.5) => N1396_4,
                                             N1396_8));

N1396_2 :=__common__( if(((real)c_pop_55_64_p < 6.75), N1396_3, -0.00035553087));

N1396_1 :=__common__( if(trim(C_POP_55_64_P) != '', N1396_2, 0.00013395724));

N1397_9 :=__common__( map(((real)f_estimated_income_d <= NULL)    => -0.0010166017,
               ((integer)f_estimated_income_d < 23500) => 0.0061096816,
                                                          -0.0010166017));

N1397_8 :=__common__( map(((real)f_divrisktype_i <= NULL) => -0.0047499435,
               ((real)f_divrisktype_i < 2.5)   => N1397_9,
                                                  -0.0047499435));

N1397_7 :=__common__( map(trim(C_RENTAL) = ''      => -0.0085523509,
               ((real)c_rental < 114.5) => 0.0013291186,
                                           -0.0085523509));

N1397_6 :=__common__( if(((real)f_addrchangecrimediff_i < -14.5), N1397_7, 0.0018341204));

N1397_5 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N1397_6, -0.0013993405));

N1397_4 :=__common__( if(((real)c_white_col < 32.9500007629), N1397_5, 0.0039680297));

N1397_3 :=__common__( if(trim(C_WHITE_COL) != '', N1397_4, -0.006270666));

N1397_2 :=__common__( if(((real)f_rel_ageover40_count_d < 1.5), N1397_3, N1397_8));

N1397_1 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N1397_2, -0.00035709092));

N1398_9 :=__common__( map(trim(C_HH1_P) = ''              => -0.0089886016,
               ((real)c_hh1_p < 23.4500007629) => 0.0014080429,
                                                  -0.0089886016));

N1398_8 :=__common__( map(((real)f_util_add_curr_misc_n <= NULL) => -0.0006243936,
               ((real)f_util_add_curr_misc_n < 0.5)   => N1398_9,
                                                         -0.0006243936));

N1398_7 :=__common__( if(trim(C_INC_15K_P) != '', N1398_8, -0.0011502689));

N1398_6 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)   => 0.00037438662,
               ((real)f_prevaddrmedianvalue_d < 76123.5) => N1398_7,
                                                            0.00037438662));

N1398_5 :=__common__( map(trim(C_POP_75_84_P) = ''              => 0.0032981116,
               ((real)c_pop_75_84_p < 3.15000009537) => 0.013220443,
                                                        0.0032981116));

N1398_4 :=__common__( if(((real)c_hval_100k_p < 6.14999961853), -0.001618011, N1398_5));

N1398_3 :=__common__( if(trim(C_HVAL_100K_P) != '', N1398_4, 0.0046585612));

N1398_2 :=__common__( if(((integer)f_prevaddrmedianincome_d < 13291), N1398_3, N1398_6));

N1398_1 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N1398_2, 0.00076434143));

N1399_9 :=__common__( map(((real)f_util_adl_count_n <= NULL) => -0.0028061803,
               ((real)f_util_adl_count_n < 0.5)   => 0.0060560219,
                                                     -0.0028061803));

N1399_8 :=__common__( map(trim(C_LUX_PROD) = ''     => 0.0027572263,
               ((real)c_lux_prod < 47.5) => 0.012306297,
                                            0.0027572263));

N1399_7 :=__common__( map(trim(C_PRESCHL) = ''      => -0.004732375,
               ((real)c_preschl < 158.5) => 0.0019404645,
                                            -0.004732375));

N1399_6 :=__common__( map(trim(C_HH00) = ''      => N1399_8,
               ((real)c_hh00 < 434.5) => N1399_7,
                                         N1399_8));

N1399_5 :=__common__( if(((real)c_retail < 9.94999980927), N1399_6, N1399_9));

N1399_4 :=__common__( if(trim(C_RETAIL) != '', N1399_5, -0.018728003));

N1399_3 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1399_4, -0.00014867766));

N1399_2 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.744120955467), N1399_3, -0.0069992482));

N1399_1 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1399_2, 0.00034240351));

N1400_10 :=__common__( if(((real)c_rnt1000_p < 31.4500007629), 0.0038196521, -0.0039018957));

N1400_9 :=__common__( if(trim(C_RNT1000_P) != '', N1400_10, 0.0088462601));

N1400_8 :=__common__( map(((real)f_idverrisktype_i <= NULL) => -0.0033969013,
               ((real)f_idverrisktype_i < 2.5)   => N1400_9,
                                                    -0.0033969013));

N1400_7 :=__common__( if(((integer)r_l80_inp_avm_autoval_d < 19718), 0.0057122398, N1400_8));

N1400_6 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1400_7, 0.00036034176));

N1400_5 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => -0.0060026333,
               ((real)r_l79_adls_per_addr_curr_i < 4.5)   => -0.00015284777,
                                                             -0.0060026333));

N1400_4 :=__common__( if(((real)r_c13_curr_addr_lres_d < 7.5), N1400_5, N1400_6));

N1400_3 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1400_4, -0.011649053));

N1400_2 :=__common__( if(((real)f_corrssnaddrcount_d < 6.5), N1400_3, -0.0078553641));

N1400_1 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N1400_2, 0.008981891));

N1401_10 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.368870139122), 0.001372544, 0.0078067145));

N1401_9 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1401_10, -0.0034370282));

N1401_8 :=__common__( map(trim(C_UNATTACH) = ''      => -0.0027952001,
               ((real)c_unattach < 129.5) => N1401_9,
                                             -0.0027952001));

N1401_7 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0598375536501), -0.0078475987, 0.0010877287));

N1401_6 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1401_7, -0.0013155136));

N1401_5 :=__common__( map(trim(C_HVAL_250K_P) = ''     => N1401_6,
               ((real)c_hval_250k_p < 8.75) => -0.00018874448,
                                               N1401_6));

N1401_4 :=__common__( if(((real)c_hval_250k_p < 13.25), N1401_5, N1401_8));

N1401_3 :=__common__( if(trim(C_HVAL_250K_P) != '', N1401_4, -0.0040075031));

N1401_2 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 64.5), 0.0058052732, N1401_3));

N1401_1 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N1401_2, 0.0073450609));

N1402_9 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.357894957066), 0.003449462, -0.0063186833));

N1402_8 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1402_9, -0.018538895));

N1402_7 :=__common__( map(trim(C_POPOVER25) = ''      => -0.0084176878,
               ((real)c_popover25 < 771.5) => N1402_8,
                                              -0.0084176878));

N1402_6 :=__common__( map(trim(C_OLD_HOMES) = ''      => -0.0029344602,
               ((real)c_old_homes < 135.5) => 0.0054499423,
                                              -0.0029344602));

N1402_5 :=__common__( map(((real)f_varrisktype_i <= NULL) => N1402_7,
               ((real)f_varrisktype_i < 1.5)   => N1402_6,
                                                  N1402_7));

N1402_4 :=__common__( if(((real)f_corraddrnamecount_d < 2.5), -0.0079410869, N1402_5));

N1402_3 :=__common__( if(((real)f_corraddrnamecount_d > NULL), N1402_4, -0.0053001394));

N1402_2 :=__common__( if(((real)c_high_ed < 5.35000038147), N1402_3, 0.00033710548));

N1402_1 :=__common__( if(trim(C_HIGH_ED) != '', N1402_2, -0.0017378269));

N1403_8 :=__common__( map(trim(C_LOW_ED) = ''              => 0.00046291936,
               ((real)c_low_ed < 57.8499984741) => 0.0094938566,
                                                   0.00046291936));

N1403_7 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => N1403_8,
               ((real)r_c13_avg_lres_d < 41.5)  => -0.0054623375,
                                                   N1403_8));

N1403_6 :=__common__( if(((real)f_curraddrburglaryindex_i < 144.5), -0.005344871, N1403_7));

N1403_5 :=__common__( if(((real)f_curraddrburglaryindex_i > NULL), N1403_6, -0.017169379));

N1403_4 :=__common__( map(trim(C_BORN_USA) = ''      => 0.0041624136,
               ((real)c_born_usa < 154.5) => 0.00020744078,
                                             0.0041624136));

N1403_3 :=__common__( map(trim(C_BORN_USA) = ''      => N1403_5,
               ((real)c_born_usa < 175.5) => N1403_4,
                                             N1403_5));

N1403_2 :=__common__( if(((real)c_cpiall < 225.450012207), N1403_3, -0.0078199939));

N1403_1 :=__common__( if(trim(C_CPIALL) != '', N1403_2, 0.0013654722));

N1404_9 :=__common__( map(trim(C_BIGAPT_P) = ''              => -0.0010046386,
               ((real)c_bigapt_p < 2.84999990463) => 0.010887892,
                                                     -0.0010046386));

N1404_8 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => 0.0059717637,
               ((real)r_c14_addrs_5yr_i < 5.5)   => -0.0027991253,
                                                    0.0059717637));

N1404_7 :=__common__( map(((real)f_corraddrnamecount_d <= NULL) => 0.0051882605,
               ((real)f_corraddrnamecount_d < 4.5)   => N1404_8,
                                                        0.0051882605));

N1404_6 :=__common__( map(trim(C_INC_75K_P) = ''              => -0.0039268741,
               ((real)c_inc_75k_p < 22.5499992371) => N1404_7,
                                                      -0.0039268741));

N1404_5 :=__common__( if(((real)r_a50_pb_total_dollars_d < 46.5), -0.0046944665, N1404_6));

N1404_4 :=__common__( if(((real)r_a50_pb_total_dollars_d > NULL), N1404_5, 0.0044687768));

N1404_3 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), 4.8399885e-005, N1404_4));

N1404_2 :=__common__( if(((real)c_serv_empl < 192.5), N1404_3, N1404_9));

N1404_1 :=__common__( if(trim(C_SERV_EMPL) != '', N1404_2, 0.0010684762));

N1405_10 :=__common__( if(((real)c_hval_200k_p < 8.25), 0.0021393211, -0.0063047182));

N1405_9 :=__common__( if(trim(C_HVAL_200K_P) != '', N1405_10, -0.032728106));

N1405_8 :=__common__( map(trim(C_PRESCHL) = ''      => -0.0071537917,
               ((real)c_preschl < 182.5) => 0.0012166071,
                                            -0.0071537917));

N1405_7 :=__common__( map(trim(C_CHILD) = ''              => 0.0076308578,
               ((real)c_child < 34.1500015259) => N1405_8,
                                                  0.0076308578));

N1405_6 :=__common__( if(((real)c_inc_201k_p < 4.55000019073), N1405_7, 0.011332135));

N1405_5 :=__common__( if(trim(C_INC_201K_P) != '', N1405_6, 0.0065673493));

N1405_4 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.004311001,
               ((real)c_comb_age_d < 47.5)  => N1405_5,
                                               -0.004311001));

N1405_3 :=__common__( if(((real)r_a46_curr_avm_autoval_d < 187742.5), N1405_4, -0.0074455382));

N1405_2 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N1405_3, N1405_9));

N1405_1 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1405_2, 0.00064869131));

N1406_9 :=__common__( map(trim(C_INC_50K_P) = ''              => -0.0072515408,
               ((real)c_inc_50k_p < 19.6500015259) => 0.00064515888,
                                                      -0.0072515408));

N1406_8 :=__common__( map(trim(C_HVAL_175K_P) = ''              => -0.0043683252,
               ((real)c_hval_175k_p < 6.85000038147) => 0.0067891827,
                                                        -0.0043683252));

N1406_7 :=__common__( map(trim(C_RETIRED) = ''              => -0.0039477079,
               ((real)c_retired < 11.1499996185) => 0.0055372684,
                                                    -0.0039477079));

N1406_6 :=__common__( if(((integer)f_addrchangeincomediff_d < 8385), N1406_7, 0.011972028));

N1406_5 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1406_6, N1406_8));

N1406_4 :=__common__( if(((real)c_food < 20.4500007629), N1406_5, N1406_9));

N1406_3 :=__common__( if(trim(C_FOOD) != '', N1406_4, 0.0031995746));

N1406_2 :=__common__( if(((real)r_c20_email_count_i < 0.5), N1406_3, -0.00066989224));

N1406_1 :=__common__( if(((real)r_c20_email_count_i > NULL), N1406_2, 0.0038150418));

N1407_10 :=__common__( if(((real)c_hh3_p < 16.4500007629), -0.0018117644, 0.00064294843));

N1407_9 :=__common__( if(trim(C_HH3_P) != '', N1407_10, -0.0022394267));

N1407_8 :=__common__( map(trim(C_HH7P_P) = ''               => -0.0050467876,
               ((real)c_hh7p_p < 0.550000011921) => 0.0035420349,
                                                    -0.0050467876));

N1407_7 :=__common__( if(((real)c_incollege < 7.25), N1407_8, 0.0088998323));

N1407_6 :=__common__( if(trim(C_INCOLLEGE) != '', N1407_7, 0.0068664754));

N1407_5 :=__common__( map(((real)r_i60_inq_comm_recency_d <= NULL) => N1407_9,
               ((real)r_i60_inq_comm_recency_d < 4.5)   => N1407_6,
                                                           N1407_9));

N1407_4 :=__common__( if(((real)c_span_lang < 125.5), -0.0086135447, 0.0021396997));

N1407_3 :=__common__( if(trim(C_SPAN_LANG) != '', N1407_4, -0.0003960425));

N1407_2 :=__common__( if(((real)f_mos_liens_unrel_lt_lseen_d < 40.5), N1407_3, N1407_5));

N1407_1 :=__common__( if(((real)f_mos_liens_unrel_lt_lseen_d > NULL), N1407_2, -0.0055531542));

N1408_9 :=__common__( if(((real)c_pop_45_54_p < 6.44999980927), -0.010190775, -0.0017869443));

N1408_8 :=__common__( if(trim(C_POP_45_54_P) != '', N1408_9, -0.0075261126));

N1408_7 :=__common__( map(((real)f_estimated_income_d <= NULL)    => 0.0096954866,
               ((integer)f_estimated_income_d < 29500) => -0.00017877337,
                                                          0.0096954866));

N1408_6 :=__common__( map(trim(C_BUSINESS) = ''    => 0.0001510211,
               ((real)c_business < 2.5) => N1408_7,
                                           0.0001510211));

N1408_5 :=__common__( if(((real)c_born_usa < 25.5), 0.0087219032, N1408_6));

N1408_4 :=__common__( if(trim(C_BORN_USA) != '', N1408_5, 0.0083228803));

N1408_3 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => N1408_4,
               ((real)r_c10_m_hdr_fs_d < 122.5) => -0.0021603297,
                                                   N1408_4));

N1408_2 :=__common__( if(((real)f_current_count_d < 1.5), N1408_3, N1408_8));

N1408_1 :=__common__( if(((real)f_current_count_d > NULL), N1408_2, -0.0041322708));

N1409_9 :=__common__( if(((real)r_c13_curr_addr_lres_d < 191.5), 0.0018032086, -0.0077180822));

N1409_8 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1409_9, -0.0050235254));

N1409_7 :=__common__( map(trim(C_NEWHOUSE) = ''              => 0.0017844405,
               ((real)c_newhouse < 41.5499992371) => -0.0021980945,
                                                     0.0017844405));

N1409_6 :=__common__( map(trim(C_PROFESSIONAL) = ''              => -0.0088016753,
               ((real)c_professional < 16.6500015259) => N1409_7,
                                                         -0.0088016753));

N1409_5 :=__common__( if(((real)f_mos_acc_lseen_d < 19.5), 0.0049447691, N1409_6));

N1409_4 :=__common__( if(((real)f_mos_acc_lseen_d > NULL), N1409_5, 0.0031161426));

N1409_3 :=__common__( map(trim(C_VERY_RICH) = ''      => 0.0073252796,
               ((real)c_very_rich < 178.5) => N1409_4,
                                              0.0073252796));

N1409_2 :=__common__( if(((real)c_pop_45_54_p < 13.0500001907), N1409_3, N1409_8));

N1409_1 :=__common__( if(trim(C_POP_45_54_P) != '', N1409_2, 0.0023013011));

N1410_7 :=__common__( map(trim(C_MEDI_INDX) = ''      => -5.7835297e-005,
               ((real)c_medi_indx < 108.5) => 0.011171446,
                                              -5.7835297e-005));

N1410_6 :=__common__( map(trim(C_HVAL_150K_P) = ''              => N1410_7,
               ((real)c_hval_150k_p < 4.94999980927) => -0.001496713,
                                                        N1410_7));

N1410_5 :=__common__( map(trim(C_HVAL_40K_P) = ''              => N1410_6,
               ((real)c_hval_40k_p < 3.04999995232) => -0.0010579032,
                                                       N1410_6));

N1410_4 :=__common__( map(trim(C_FAMOTF18_P) = ''              => -0.0031293754,
               ((real)c_famotf18_p < 28.0499992371) => N1410_5,
                                                       -0.0031293754));

N1410_3 :=__common__( map(trim(C_RELIG_INDX) = ''      => 0.0061565528,
               ((real)c_relig_indx < 169.5) => 0.00077250241,
                                               0.0061565528));

N1410_2 :=__common__( if(((real)c_professional < 1.15000009537), N1410_3, N1410_4));

N1410_1 :=__common__( if(trim(C_PROFESSIONAL) != '', N1410_2, 0.0057340873));

N1411_10 :=__common__( map(trim(C_RENTAL) = ''      => 1.6891112e-005,
                ((real)c_rental < 132.5) => 0.0083468308,
                                            1.6891112e-005));

N1411_9 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), 0.0017778749, N1411_10));

N1411_8 :=__common__( map(trim(C_CHILD) = ''      => -0.00036841479,
               ((real)c_child < 26.75) => -0.010592065,
                                          -0.00036841479));

N1411_7 :=__common__( map(trim(C_POP_55_64_P) = ''              => 0.0053125147,
               ((real)c_pop_55_64_p < 12.9499998093) => N1411_8,
                                                        0.0053125147));

N1411_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0206712968647), N1411_7, N1411_9));

N1411_5 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1411_6, 0.0027625485));

N1411_4 :=__common__( if(((real)c_incollege < 0.75), -0.0067771733, N1411_5));

N1411_3 :=__common__( if(trim(C_INCOLLEGE) != '', N1411_4, 0.00032451099));

N1411_2 :=__common__( if(((real)c_hist_addr_match_i < 3.5), -0.00075700511, N1411_3));

N1411_1 :=__common__( if(((real)c_hist_addr_match_i > NULL), N1411_2, -0.001717989));

N1412_8 :=__common__( map(((real)r_c13_curr_addr_lres_d <= NULL) => -0.00013884124,
               ((real)r_c13_curr_addr_lres_d < 21.5)  => 0.010210753,
                                                         -0.00013884124));

N1412_7 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => -0.0010625399,
               ((real)r_d32_mos_since_crim_ls_d < 219.5) => 0.0082232833,
                                                            -0.0010625399));

N1412_6 :=__common__( map(((real)r_a50_pb_total_orders_d <= NULL) => 0.0016376357,
               ((real)r_a50_pb_total_orders_d < 1.5)   => -0.00567216,
                                                          0.0016376357));

N1412_5 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => N1412_7,
               ((real)r_l79_adls_per_addr_curr_i < 19.5)  => N1412_6,
                                                             N1412_7));

N1412_4 :=__common__( if(((real)c_hh1_p < 38.75), 0.00025099921, N1412_5));

N1412_3 :=__common__( if(trim(C_HH1_P) != '', N1412_4, 0.00017697048));

N1412_2 :=__common__( if(((real)f_rel_felony_count_i < 6.5), N1412_3, N1412_8));

N1412_1 :=__common__( if(((real)f_rel_felony_count_i > NULL), N1412_2, -0.00068230281));

N1413_9 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => -0.0028812123,
               ((real)r_c13_avg_lres_d < 49.5)  => -0.01286337,
                                                   -0.0028812123));

N1413_8 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => N1413_9,
               ((real)f_add_curr_nhood_vac_pct_i < 0.147935390472) => -0.00093583787,
                                                                      N1413_9));

N1413_7 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => N1413_8,
               ((real)f_inq_per_ssn_i < 0.5)   => 0.0051029169,
                                                  N1413_8));

N1413_6 :=__common__( if(trim(C_RELIG_INDX) != '', N1413_7, -0.0039603537));

N1413_5 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => N1413_6,
               ((real)f_inq_adls_per_phone_i < 0.5)   => 0.0009084723,
                                                         N1413_6));

N1413_4 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.652587711811), N1413_5, -0.0061580827));

N1413_3 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N1413_4, -0.0068374885));

N1413_2 :=__common__( if(((real)r_i60_inq_count12_i < 17.5), N1413_3, 0.0064699815));

N1413_1 :=__common__( if(((real)r_i60_inq_count12_i > NULL), N1413_2, 0.00055248367));

N1414_9 :=__common__( if(((real)c_ab_av_edu < 75.5), 0.011571968, 0.00073869818));

N1414_8 :=__common__( if(trim(C_AB_AV_EDU) != '', N1414_9, 0.0052027493));

N1414_7 :=__common__( map(trim(C_NEWHOUSE) = ''              => -0.0092265574,
               ((real)c_newhouse < 5.14999961853) => 0.0049245222,
                                                     -0.0092265574));

N1414_6 :=__common__( map(trim(C_NO_CAR) = ''     => 0.0007899621,
               ((real)c_no_car < 48.5) => N1414_7,
                                          0.0007899621));

N1414_5 :=__common__( map(trim(C_OLDHOUSE) = ''      => N1414_6,
               ((real)c_oldhouse < 32.75) => 0.0047206585,
                                             N1414_6));

N1414_4 :=__common__( if(((integer)c_assault < 13), -0.0068183092, N1414_5));

N1414_3 :=__common__( if(trim(C_ASSAULT) != '', N1414_4, 0.00058200191));

N1414_2 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d < 0.992846906185), N1414_3, N1414_8));

N1414_1 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d > NULL), N1414_2, 0.0041713812));

N1415_9 :=__common__( map(trim(C_NEWHOUSE) = ''              => 0.0065707136,
               ((real)c_newhouse < 18.5499992371) => -0.0044451184,
                                                     0.0065707136));

N1415_8 :=__common__( map(trim(C_UNATTACH) = ''      => 0.010113435,
               ((real)c_unattach < 108.5) => 0.0015953152,
                                             0.010113435));

N1415_7 :=__common__( if(((real)c_employees < 123.5), N1415_8, N1415_9));

N1415_6 :=__common__( if(trim(C_EMPLOYEES) != '', N1415_7, 0.013678065));

N1415_5 :=__common__( map(((real)f_rel_bankrupt_count_i <= NULL) => -0.0046127891,
               ((real)f_rel_bankrupt_count_i < 4.5)   => N1415_6,
                                                         -0.0046127891));

N1415_4 :=__common__( if(((real)c_health < 61.8000030518), -0.00038522874, -0.0067049544));

N1415_3 :=__common__( if(trim(C_HEALTH) != '', N1415_4, 0.00053072067));

N1415_2 :=__common__( if(((real)f_srchunvrfdaddrcount_i < 0.5), N1415_3, N1415_5));

N1415_1 :=__common__( if(((real)f_srchunvrfdaddrcount_i > NULL), N1415_2, -0.0028700733));

N1416_8 :=__common__( map(trim(C_CONSTRUCTION) = ''              => 0.0097471756,
               ((real)c_construction < 24.2999992371) => -2.8303753e-005,
                                                         0.0097471756));

N1416_7 :=__common__( map(trim(C_INC_75K_P) = ''              => N1416_8,
               ((real)c_inc_75k_p < 19.3499984741) => -0.002006401,
                                                      N1416_8));

N1416_6 :=__common__( map(trim(C_INCOLLEGE) = ''     => -0.0015755604,
               ((real)c_incollege < 5.25) => 0.010250477,
                                             -0.0015755604));

N1416_5 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 34.5), N1416_6, N1416_7));

N1416_4 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N1416_5, -0.011977832));

N1416_3 :=__common__( map(trim(C_LARCENY) = ''      => 0.0095609961,
               ((real)c_larceny < 178.5) => 0.0012848484,
                                            0.0095609961));

N1416_2 :=__common__( if(((real)c_rape < 92.5), N1416_3, N1416_4));

N1416_1 :=__common__( if(trim(C_RAPE) != '', N1416_2, -0.003729602));

N1417_8 :=__common__( map(((real)f_historical_count_d <= NULL) => 0.00046280026,
               ((real)f_historical_count_d < 1.5)   => 0.0089150884,
                                                       0.00046280026));

N1417_7 :=__common__( map(((real)f_prevaddrageoldest_d <= NULL) => 0.00015257371,
               ((real)f_prevaddrageoldest_d < 41.5)  => 0.010695937,
                                                        0.00015257371));

N1417_6 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => N1417_7,
               ((integer)f_curraddrcartheftindex_i < 86) => -0.0055627305,
                                                            N1417_7));

N1417_5 :=__common__( if(((real)c_many_cars < 103.5), -0.0041404223, N1417_6));

N1417_4 :=__common__( if(trim(C_MANY_CARS) != '', N1417_5, -0.0060410291));

N1417_3 :=__common__( map((fp_segment in ['4 Bureau Only', '7 Other'])                                             => N1417_4,
               (fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '5 Derog', '6 Recent Activity']) => 4.5524678e-005,
                                                                                                           4.5524678e-005));

N1417_2 :=__common__( if(((real)f_divaddrsuspidcountnew_i < 2.5), N1417_3, N1417_8));

N1417_1 :=__common__( if(((real)f_divaddrsuspidcountnew_i > NULL), N1417_2, -0.0068887664));

N1418_13 :=__common__( if(((real)c_rnt1250_p < 3.95000004768), 0.010074086, -0.00014257085));

N1418_12 :=__common__( if(trim(C_RNT1250_P) != '', N1418_13, 0.024826722));

N1418_11 :=__common__( map(trim(C_BORN_USA) = ''      => -0.0045525727,
                ((real)c_born_usa < 190.5) => 0.0011543558,
                                              -0.0045525727));

N1418_10 :=__common__( if(((real)f_addrchangevaluediff_d < -6247.5), -0.007258449, 0.0044607458));

N1418_9 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1418_10, 0.0023479721));

N1418_8 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.31142616272), -0.0055180215, N1418_9));

N1418_7 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1418_8, 0.0019343958));

N1418_6 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => N1418_11,
               ((real)f_m_bureau_adl_fs_all_d < 122.5) => N1418_7,
                                                          N1418_11));

N1418_5 :=__common__( if(trim(C_BORN_USA) != '', N1418_6, -0.0036202069));

N1418_4 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N1418_5, 0.0023554145));

N1418_3 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), 9.9510213e-005, N1418_4));

N1418_2 :=__common__( if(((integer)f_prevaddrmedianincome_d < 77338), N1418_3, N1418_12));

N1418_1 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N1418_2, -0.0039446682));

N1419_9 :=__common__( map(trim(C_RICH_YOUNG) = ''       => -0.0078351973,
               ((integer)c_rich_young < 146) => -0.00041465179,
                                                -0.0078351973));

N1419_8 :=__common__( map(((real)f_addrchangeincomediff_d <= NULL)    => -0.0068573123,
               ((real)f_addrchangeincomediff_d < -11907.5) => 0.0034414149,
                                                              -0.0068573123));

N1419_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1419_8, 0.092096969));

N1419_6 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1419_7, -0.0033328232));

N1419_5 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)          => 0.0054637195,
               ((real)f_add_input_nhood_sfd_pct_d < 0.770025074482) => N1419_6,
                                                                       0.0054637195));

N1419_4 :=__common__( if(((real)c_addr_lres_12mo_ct_i < 1.5), 0.0091307468, N1419_5));

N1419_3 :=__common__( if(((real)c_addr_lres_12mo_ct_i > NULL), N1419_4, -0.013373196));

N1419_2 :=__common__( if(((real)c_inc_75k_p < 8.75), N1419_3, N1419_9));

N1419_1 :=__common__( if(trim(C_INC_75K_P) != '', N1419_2, 0.00094152204));

N1420_8 :=__common__( map(trim(C_HVAL_400K_P) = ''              => -0.002529153,
               ((real)c_hval_400k_p < 8.64999961853) => 0.001437632,
                                                        -0.002529153));

N1420_7 :=__common__( map(trim(C_PRESCHL) = ''     => N1420_8,
               ((real)c_preschl < 14.5) => 0.008152423,
                                           N1420_8));

N1420_6 :=__common__( map(trim(C_BLUE_EMPL) = ''     => N1420_7,
               ((real)c_blue_empl < 23.5) => -0.0076896294,
                                             N1420_7));

N1420_5 :=__common__( map(trim(C_EASIQLIFE) = ''      => -0.0036259106,
               ((real)c_easiqlife < 120.5) => 1.2937412e-005,
                                              -0.0036259106));

N1420_4 :=__common__( if(((real)c_pop_45_54_p < 13.1499996185), N1420_5, N1420_6));

N1420_3 :=__common__( if(trim(C_POP_45_54_P) != '', N1420_4, -0.0007432588));

N1420_2 :=__common__( if(((real)r_d31_bk_filing_count_i < 2.5), N1420_3, 0.0073968073));

N1420_1 :=__common__( if(((real)r_d31_bk_filing_count_i > NULL), N1420_2, -0.008663408));

N1421_10 :=__common__( if(((real)c_health < 8.44999980927), 0.0011205609, 0.010845327));

N1421_9 :=__common__( if(trim(C_HEALTH) != '', N1421_10, 0.0049937662));

N1421_8 :=__common__( if(((real)c_low_ed < 50.6500015259), 0.00088929535, -0.0034687695));

N1421_7 :=__common__( if(trim(C_LOW_ED) != '', N1421_8, 0.0029361676));

N1421_6 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.011203079,
               ((real)r_c14_addrs_10yr_i < 10.5)  => 0.0021604655,
                                                     0.011203079));

N1421_5 :=__common__( if(((real)c_lowrent < 3.75), N1421_6, -0.00024737689));

N1421_4 :=__common__( if(trim(C_LOWRENT) != '', N1421_5, -0.0019589013));

N1421_3 :=__common__( map(((real)f_srchphonesrchcount_i <= NULL) => N1421_7,
               ((real)f_srchphonesrchcount_i < 1.5)   => N1421_4,
                                                         N1421_7));

N1421_2 :=__common__( if(((real)f_srchphonesrchcountmo_i < 0.5), N1421_3, N1421_9));

N1421_1 :=__common__( if(((real)f_srchphonesrchcountmo_i > NULL), N1421_2, 0.00074129141));

N1422_9 :=__common__( if(((real)c_med_rent < 192.5), 0.006352525, -0.00014176638));

N1422_8 :=__common__( if(trim(C_MED_RENT) != '', N1422_9, 0.0012470526));

N1422_7 :=__common__( map(trim(C_POP_65_74_P) = ''              => 0.0059368523,
               ((real)c_pop_65_74_p < 5.94999980927) => -0.0028317152,
                                                        0.0059368523));

N1422_6 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => N1422_7,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0565865561366) => 0.0099110835,
                                                                       N1422_7));

N1422_5 :=__common__( map(trim(C_RNT750_P) = ''      => 0.009334441,
               ((real)c_rnt750_p < 39.25) => -0.0033823052,
                                             0.009334441));

N1422_4 :=__common__( map(((real)r_a49_curr_avm_chg_1yr_i <= NULL)    => -0.0046039517,
               ((integer)r_a49_curr_avm_chg_1yr_i < -6610) => N1422_5,
                                                              -0.0046039517));

N1422_3 :=__common__( if(((real)c_unattach < 133.5), N1422_4, N1422_6));

N1422_2 :=__common__( if(trim(C_UNATTACH) != '', N1422_3, -0.0060483056));

N1422_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N1422_2, N1422_8));

N1423_8 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => -0.00056503582,
               ((real)f_add_input_mobility_index_n < 0.265462636948) => 0.0053934245,
                                                                        -0.00056503582));

N1423_7 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => -0.0023060427,
               ((real)f_mos_inq_banko_cm_fseen_d < 69.5)  => N1423_8,
                                                             -0.0023060427));

N1423_6 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL)  => -0.0031054864,
               ((integer)f_liens_unrel_cj_total_amt_i < 350) => 0.0072284252,
                                                                -0.0031054864));

N1423_5 :=__common__( map(trim(C_HH2_P) = ''              => N1423_7,
               ((real)c_hh2_p < 17.8499984741) => N1423_6,
                                                  N1423_7));

N1423_4 :=__common__( if(((real)c_pop_12_17_p < 12.25), N1423_5, 0.0033144599));

N1423_3 :=__common__( if(trim(C_POP_12_17_P) != '', N1423_4, 0.00042625747));

N1423_2 :=__common__( if(((real)f_varrisktype_i < 3.5), N1423_3, -0.0018610776));

N1423_1 :=__common__( if(((real)f_varrisktype_i > NULL), N1423_2, -0.0080592452));

N1424_9 :=__common__( map(((real)f_addrchangeecontrajindex_d <= NULL) => -0.0054338,
               ((real)f_addrchangeecontrajindex_d < 1.5)   => 0.0053299641,
                                                              -0.0054338));

N1424_8 :=__common__( map(trim(C_INC_25K_P) = ''              => 0.0052145386,
               ((real)c_inc_25k_p < 10.5500001907) => N1424_9,
                                                      0.0052145386));

N1424_7 :=__common__( map(((real)r_prop_owner_history_d <= NULL) => -0.0066312426,
               ((real)r_prop_owner_history_d < 0.5)   => N1424_8,
                                                         -0.0066312426));

N1424_6 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N1424_7, -0.00035706292));

N1424_5 :=__common__( map(trim(C_POP_35_44_P) = ''              => 0.0076717317,
               ((real)c_pop_35_44_p < 19.5499992371) => N1424_6,
                                                        0.0076717317));

N1424_4 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d < 63.5), -0.000405883, N1424_5));

N1424_3 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d > NULL), N1424_4, 0.0092899954));

N1424_2 :=__common__( if(((real)c_exp_prod < 176.5), N1424_3, -0.006099217));

N1424_1 :=__common__( if(trim(C_EXP_PROD) != '', N1424_2, 0.0014874881));

N1425_8 :=__common__( map(trim(C_BEL_EDU) = ''     => -0.0044875501,
               ((real)c_bel_edu < 79.5) => 0.004713817,
                                           -0.0044875501));

N1425_7 :=__common__( map(trim(C_POP_55_64_P) = ''              => N1425_8,
               ((real)c_pop_55_64_p < 15.1499996185) => 0.001244929,
                                                        N1425_8));

N1425_6 :=__common__( if(((real)f_m_bureau_adl_fs_all_d < 347.5), N1425_7, -0.0045033331));

N1425_5 :=__common__( if(((real)f_m_bureau_adl_fs_all_d > NULL), N1425_6, 0.0072509622));

N1425_4 :=__common__( map(trim(C_EASIQLIFE) = ''      => -0.00080158983,
               ((real)c_easiqlife < 120.5) => -0.0090409167,
                                              -0.00080158983));

N1425_3 :=__common__( map(trim(C_LOW_ED) = ''              => 0.0010430072,
               ((real)c_low_ed < 69.8500061035) => N1425_4,
                                                   0.0010430072));

N1425_2 :=__common__( if(((real)c_med_rent < 321.5), N1425_3, N1425_5));

N1425_1 :=__common__( if(trim(C_MED_RENT) != '', N1425_2, 0.002107755));

N1426_8 :=__common__( map(trim(C_FINANCE) = ''              => 0.0069248484,
               ((real)c_finance < 5.35000038147) => -0.00017913103,
                                                    0.0069248484));

N1426_7 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL)  => 0.0097785519,
               ((real)f_liens_unrel_cj_total_amt_i < 9335.5) => N1426_8,
                                                                0.0097785519));

N1426_6 :=__common__( map(trim(C_RELIG_INDX) = ''     => -0.0013376134,
               ((real)c_relig_indx < 89.5) => N1426_7,
                                              -0.0013376134));

N1426_5 :=__common__( if(((real)r_pb_order_freq_d > NULL), -0.0057347724, 0.0078549533));

N1426_4 :=__common__( map(trim(C_HHSIZE) = ''              => -0.0025900817,
               ((real)c_hhsize < 2.96500015259) => N1426_5,
                                                   -0.0025900817));

N1426_3 :=__common__( if(((real)r_c12_num_nonderogs_d < 3.5), N1426_4, N1426_6));

N1426_2 :=__common__( if(((real)r_c12_num_nonderogs_d > NULL), N1426_3, 0.0094796782));

N1426_1 :=__common__( if(trim(C_CHILD) != '', N1426_2, 0.0048081204));

N1427_8 :=__common__( map(trim(C_BLUE_EMPL) = ''      => -0.0092670097,
               ((real)c_blue_empl < 131.5) => -0.00021433948,
                                              -0.0092670097));

N1427_7 :=__common__( map(trim(C_ROBBERY) = ''     => 0.0084715822,
               ((real)c_robbery < 84.5) => -0.0023956184,
                                           0.0084715822));

N1427_6 :=__common__( map(trim(C_RNT1000_P) = ''      => N1427_7,
               ((real)c_rnt1000_p < 42.75) => -0.00020146101,
                                              N1427_7));

N1427_5 :=__common__( map(trim(C_HH6_P) = ''              => N1427_8,
               ((real)c_hh6_p < 7.94999980927) => N1427_6,
                                                  N1427_8));

N1427_4 :=__common__( if(((real)r_c13_curr_addr_lres_d < 114.5), N1427_5, 0.0034076785));

N1427_3 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1427_4, -0.0025814822));

N1427_2 :=__common__( if(((real)c_popover25 < 1957.5), N1427_3, -0.0047018436));

N1427_1 :=__common__( if(trim(C_POPOVER25) != '', N1427_2, 0.00046723317));

N1428_8 :=__common__( map(trim(C_FINANCE) = ''              => -0.0046567982,
               ((real)c_finance < 3.34999990463) => 0.0074402239,
                                                    -0.0046567982));

N1428_7 :=__common__( map(((real)f_inq_lnames_per_addr_i <= NULL) => N1428_8,
               ((real)f_inq_lnames_per_addr_i < 2.5)   => -0.00038709144,
                                                          N1428_8));

N1428_6 :=__common__( map(trim(C_ROBBERY) = ''       => -0.0081554236,
               ((integer)c_robbery < 120) => 0.001528444,
                                             -0.0081554236));

N1428_5 :=__common__( map(trim(C_MORT_INDX) = ''     => N1428_6,
               ((real)c_mort_indx < 58.5) => 0.0066457239,
                                             N1428_6));

N1428_4 :=__common__( map(trim(C_LOW_HVAL) = ''              => 0.0076653753,
               ((real)c_low_hval < 12.5500001907) => N1428_5,
                                                     0.0076653753));

N1428_3 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => -0.0043686272,
               ((real)f_add_input_nhood_vac_pct_i < 0.0836569219828) => N1428_4,
                                                                        -0.0043686272));

N1428_2 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N1428_3, N1428_7));

N1428_1 :=__common__( if(trim(C_EDU_INDX) != '', N1428_2, 0.0043235099));

N1429_9 :=__common__( if(((real)f_rel_homeover200_count_d < 4.5), -0.00096835769, -0.011324143));

N1429_8 :=__common__( if(((real)f_rel_homeover200_count_d > NULL), N1429_9, -0.0072985471));

N1429_7 :=__common__( map(trim(C_POP_75_84_P) = ''              => 0.0055177233,
               ((real)c_pop_75_84_p < 7.44999980927) => 0.00084616489,
                                                        0.0055177233));

N1429_6 :=__common__( map(trim(C_HVAL_100K_P) = ''              => -0.0042461119,
               ((real)c_hval_100k_p < 33.4500007629) => N1429_7,
                                                        -0.0042461119));

N1429_5 :=__common__( if(((real)r_c14_addr_stability_v2_d < 5.5), N1429_6, -0.001956299));

N1429_4 :=__common__( if(((real)r_c14_addr_stability_v2_d > NULL), N1429_5, 0.0074325717));

N1429_3 :=__common__( map(trim(C_NEWHOUSE) = ''              => -0.0069691443,
               ((real)c_newhouse < 170.600006104) => N1429_4,
                                                     -0.0069691443));

N1429_2 :=__common__( if(((real)c_exp_prod < 148.5), N1429_3, N1429_8));

N1429_1 :=__common__( if(trim(C_EXP_PROD) != '', N1429_2, -0.0018813879));

N1430_9 :=__common__( map(((real)r_c20_email_domain_free_count_i <= NULL) => 0.0029279144,
               ((real)r_c20_email_domain_free_count_i < 2.5)   => -0.0029347787,
                                                                  0.0029279144));

N1430_8 :=__common__( map(((real)f_corraddrphonecount_d <= NULL) => N1430_9,
               ((real)f_corraddrphonecount_d < 0.5)   => 0.00084400328,
                                                         N1430_9));

N1430_7 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 64.5), 0.0063709609, N1430_8));

N1430_6 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N1430_7, 0.011887259));

N1430_5 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => -0.0057415114,
               ((integer)f_curraddrcartheftindex_i < 91) => 0.0059943755,
                                                            -0.0057415114));

N1430_4 :=__common__( if(((real)f_corrssnnamecount_d < 4.5), -0.0083526909, N1430_5));

N1430_3 :=__common__( if(((real)f_corrssnnamecount_d > NULL), N1430_4, -0.032057395));

N1430_2 :=__common__( if(((real)c_low_ed < 31.6500015259), N1430_3, N1430_6));

N1430_1 :=__common__( if(trim(C_LOW_ED) != '', N1430_2, 0.00045407803));

N1431_7 :=__common__( map(trim(C_NEWHOUSE) = ''     => 0.00084207698,
               ((real)c_newhouse < 2.75) => 0.0094772962,
                                            0.00084207698));

N1431_6 :=__common__( map(trim(C_PROFESSIONAL) = ''              => -0.0056512883,
               ((real)c_professional < 19.9500007629) => N1431_7,
                                                         -0.0056512883));

N1431_5 :=__common__( map(trim(C_RENTAL) = ''      => 0.0019102952,
               ((real)c_rental < 181.5) => -0.0043361658,
                                           0.0019102952));

N1431_4 :=__common__( map(trim(C_INC_25K_P) = ''              => N1431_5,
               ((real)c_inc_25k_p < 10.8500003815) => 0.0026112291,
                                                      N1431_5));

N1431_3 :=__common__( map(trim(C_WHITE_COL) = ''              => -0.0084499833,
               ((real)c_white_col < 39.5499992371) => N1431_4,
                                                      -0.0084499833));

N1431_2 :=__common__( if(((real)c_newhouse < 2.15000009537), N1431_3, N1431_6));

N1431_1 :=__common__( if(trim(C_NEWHOUSE) != '', N1431_2, -0.0011863626));

N1432_7 :=__common__( map(((real)c_inf_fname_verd_d <= NULL) => -0.010710788,
               ((real)c_inf_fname_verd_d < 0.5)   => -0.0010204264,
                                                     -0.010710788));

N1432_6 :=__common__( map(trim(C_UNEMPL) = ''      => -0.009537543,
               ((real)c_unempl < 173.5) => N1432_7,
                                           -0.009537543));

N1432_5 :=__common__( map(trim(C_MANY_CARS) = ''     => N1432_6,
               ((real)c_many_cars < 38.5) => 0.0016893901,
                                             N1432_6));

N1432_4 :=__common__( map(trim(C_YOUNG) = ''              => N1432_5,
               ((real)c_young < 14.0500001907) => 0.0060824627,
                                                  N1432_5));

N1432_3 :=__common__( map(trim(C_FEMDIV_P) = ''              => 0.0008240064,
               ((real)c_femdiv_p < 3.95000004768) => N1432_4,
                                                     0.0008240064));

N1432_2 :=__common__( if(((real)c_no_car < 194.5), N1432_3, 0.0077868435));

N1432_1 :=__common__( if(trim(C_NO_CAR) != '', N1432_2, -0.00082811562));

N1433_11 :=__common__( if(((real)c_inc_100k_p < 11.5500001907), 0.0028118959, -0.0042596886));

N1433_10 :=__common__( if(trim(C_INC_100K_P) != '', N1433_11, 0.017844909));

N1433_9 :=__common__( map(((real)c_comb_age_d <= NULL) => N1433_10,
               ((real)c_comb_age_d < 27.5)  => 0.0067068939,
                                               N1433_10));

N1433_8 :=__common__( if(((real)c_young < 28.1500015259), -0.0027302353, -0.013922865));

N1433_7 :=__common__( if(trim(C_YOUNG) != '', N1433_8, -0.0026259656));

N1433_6 :=__common__( if(((real)f_prevaddrmurderindex_i < 137.5), -0.00035382571, N1433_7));

N1433_5 :=__common__( if(((real)f_prevaddrmurderindex_i > NULL), N1433_6, 0.0032841593));

N1433_4 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.0652901977301), N1433_5, N1433_9));

N1433_3 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N1433_4, -0.0070313327));

N1433_2 :=__common__( if(((real)f_addrchangecrimediff_i < -13.5), -0.0018422384, 0.0011414276));

N1433_1 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N1433_2, N1433_3));

N1434_9 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => 0.014637402,
               ((real)r_c10_m_hdr_fs_d < 154.5) => 0.00173273,
                                                   0.014637402));

N1434_8 :=__common__( if(((integer)f_estimated_income_d < 37500), N1434_9, -0.0014903921));

N1434_7 :=__common__( if(((real)f_estimated_income_d > NULL), N1434_8, -0.00083707559));

N1434_6 :=__common__( map(trim(C_NO_CAR) = ''     => -0.00089458515,
               ((real)c_no_car < 37.5) => -0.010543546,
                                          -0.00089458515));

N1434_5 :=__common__( if(((real)c_rnt1000_p < 25.1500015259), N1434_6, N1434_7));

N1434_4 :=__common__( if(trim(C_RNT1000_P) != '', N1434_5, -0.0045709956));

N1434_3 :=__common__( map(trim(C_HVAL_200K_P) = ''              => -0.011334108,
               ((real)c_hval_200k_p < 12.1499996185) => -0.0014013842,
                                                        -0.011334108));

N1434_2 :=__common__( if(((real)f_addrchangevaluediff_d < 61909.5), 0.00071939988, N1434_3));

N1434_1 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1434_2, N1434_4));

N1435_9 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => 0.01039628,
               ((real)r_c13_avg_lres_d < 67.5)  => 0.0014136842,
                                                   0.01039628));

N1435_8 :=__common__( if(((integer)f_prevaddrmedianincome_d < 38573), N1435_9, -0.0023899926));

N1435_7 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N1435_8, -0.029758811));

N1435_6 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => 0.0018447444,
               ((real)f_mos_inq_banko_cm_lseen_d < 60.5)  => -0.0027988842,
                                                             0.0018447444));

N1435_5 :=__common__( map(trim(C_CHILD) = ''      => N1435_6,
               ((real)c_child < 22.25) => -0.0062185652,
                                          N1435_6));

N1435_4 :=__common__( if(((integer)f_estimated_income_d < 31500), N1435_5, 0.00033991212));

N1435_3 :=__common__( if(((real)f_estimated_income_d > NULL), N1435_4, 0.00036476595));

N1435_2 :=__common__( if(((real)c_low_ed < 76.8500061035), N1435_3, N1435_7));

N1435_1 :=__common__( if(trim(C_LOW_ED) != '', N1435_2, -0.0033911843));

N1436_10 :=__common__( map(((real)f_fp_prevaddrcrimeindex_i <= NULL)  => 0.0089411154,
                ((integer)f_fp_prevaddrcrimeindex_i < 138) => -0.0023381841,
                                                              0.0089411154));

N1436_9 :=__common__( if(((real)c_food < 4.25), -0.003676189, 0.007583157));

N1436_8 :=__common__( if(trim(C_FOOD) != '', N1436_9, 0.001327469));

N1436_7 :=__common__( if(((real)c_inc_35k_p < 2.75), 0.0067849042, -0.0010819811));

N1436_6 :=__common__( if(trim(C_INC_35K_P) != '', N1436_7, -0.0067562512));

N1436_5 :=__common__( map(((real)c_a49_prop_owned_assessed_tot_d <= NULL)    => N1436_8,
               ((integer)c_a49_prop_owned_assessed_tot_d < 35850) => N1436_6,
                                                                     N1436_8));

N1436_4 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 19.5), 0.0051801821, N1436_5));

N1436_3 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N1436_4, -0.0074809718));

N1436_2 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.396280765533), N1436_3, N1436_10));

N1436_1 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N1436_2, -0.032126691));

N1437_10 :=__common__( if(((real)f_corrssnaddrcount_d < 3.5), 0.0092387919, 0.00020186269));

N1437_9 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N1437_10, 0.021197763));

N1437_8 :=__common__( map(trim(C_HIGH_ED) = ''              => -0.0075631181,
               ((real)c_high_ed < 6.94999980927) => 0.0024952316,
                                                    -0.0075631181));

N1437_7 :=__common__( map(trim(C_HIGH_ED) = ''              => N1437_9,
               ((real)c_high_ed < 12.1499996185) => N1437_8,
                                                    N1437_9));

N1437_6 :=__common__( if(((real)c_finance < 4.14999961853), N1437_7, -0.0059218468));

N1437_5 :=__common__( if(trim(C_FINANCE) != '', N1437_6, 0.0016206257));

N1437_4 :=__common__( map(trim(C_POP_35_44_P) = ''      => -0.0069772464,
               ((real)c_pop_35_44_p < 23.75) => -3.1918539e-005,
                                                -0.0069772464));

N1437_3 :=__common__( if(((real)c_inc_200k_p < 8.94999980927), N1437_4, 0.0068235175));

N1437_2 :=__common__( if(trim(C_INC_200K_P) != '', N1437_3, -0.001465735));

N1437_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1437_2, N1437_5));

N1438_8 :=__common__( map(((real)f_corrssnnamecount_d <= NULL) => -0.0043300941,
               ((real)f_corrssnnamecount_d < 8.5)   => 0.0046874994,
                                                       -0.0043300941));

N1438_7 :=__common__( map(trim(C_HH2_P) = ''              => -0.0029642859,
               ((real)c_hh2_p < 35.3499984741) => N1438_8,
                                                  -0.0029642859));

N1438_6 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 220.5), -0.0017730365, N1438_7));

N1438_5 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N1438_6, 0.0052626035));

N1438_4 :=__common__( map(trim(C_HVAL_200K_P) = ''     => 0.0015449403,
               ((real)c_hval_200k_p < 3.25) => N1438_5,
                                               0.0015449403));

N1438_3 :=__common__( map(trim(C_HIGH_ED) = ''              => -0.0089801362,
               ((real)c_high_ed < 51.3000030518) => N1438_4,
                                                    -0.0089801362));

N1438_2 :=__common__( if(((real)c_pop_25_34_p < 29.8499984741), N1438_3, 0.0080001176));

N1438_1 :=__common__( if(trim(C_POP_25_34_P) != '', N1438_2, 0.005238545));

N1439_8 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => -0.010058945,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.857462286949) => -0.0024869833,
                                                                      -0.010058945));

N1439_7 :=__common__( map(trim(C_ASSAULT) = ''       => -0.00032242157,
               ((integer)c_assault < 120) => 0.0059353057,
                                             -0.00032242157));

N1439_6 :=__common__( if(((real)c_hh3_p < 26.4500007629), N1439_7, -0.0064183583));

N1439_5 :=__common__( if(trim(C_HH3_P) != '', N1439_6, -0.034818525));

N1439_4 :=__common__( map(((real)r_i60_inq_count12_i <= NULL) => N1439_8,
               ((real)r_i60_inq_count12_i < 3.5)   => N1439_5,
                                                      N1439_8));

N1439_3 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.0029227437,
               ((real)f_inq_other_count24_i < 1.5)   => -5.2176879e-005,
                                                        0.0029227437));

N1439_2 :=__common__( if(((real)f_curraddrcrimeindex_i < 159.5), N1439_3, N1439_4));

N1439_1 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N1439_2, 0.0023716805));

N1440_7 :=__common__( map(trim(C_OLD_HOMES) = ''      => 0.0044852379,
               ((real)c_old_homes < 120.5) => -0.005323577,
                                              0.0044852379));

N1440_6 :=__common__( map(trim(C_SPAN_LANG) = ''     => -0.0076263592,
               ((real)c_span_lang < 79.5) => N1440_7,
                                             -0.0076263592));

N1440_5 :=__common__( map(trim(C_WHITE_COL) = ''              => -0.0028141609,
               ((real)c_white_col < 24.0499992371) => 0.0056701687,
                                                      -0.0028141609));

N1440_4 :=__common__( map(trim(C_FAMILIES) = ''      => 0.010086811,
               ((real)c_families < 167.5) => N1440_5,
                                             0.010086811));

N1440_3 :=__common__( map(trim(C_FAMILIES) = ''      => 0.00028396223,
               ((real)c_families < 182.5) => N1440_4,
                                             0.00028396223));

N1440_2 :=__common__( if(((real)c_low_hval < 57.0499992371), N1440_3, N1440_6));

N1440_1 :=__common__( if(trim(C_LOW_HVAL) != '', N1440_2, -0.00075471412));

N1441_9 :=__common__( if(((real)r_c10_m_hdr_fs_d < 171.5), 0.00044234738, -0.0088641378));

N1441_8 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N1441_9, -0.015559103));

N1441_7 :=__common__( map(trim(C_RETIRED2) = ''     => 0.0065650556,
               ((real)c_retired2 < 63.5) => -0.00078204668,
                                            0.0065650556));

N1441_6 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.12823869288), -0.00014967824, 0.0047490513));

N1441_5 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1441_6, -7.5752721e-005));

N1441_4 :=__common__( map(trim(C_PRESCHL) = ''      => -0.0018031803,
               ((real)c_preschl < 145.5) => N1441_5,
                                            -0.0018031803));

N1441_3 :=__common__( map(trim(C_LAR_FAM) = ''      => N1441_7,
               ((real)c_lar_fam < 155.5) => N1441_4,
                                            N1441_7));

N1441_2 :=__common__( if(((real)c_work_home < 166.5), N1441_3, N1441_8));

N1441_1 :=__common__( if(trim(C_WORK_HOME) != '', N1441_2, 0.0031025568));

N1442_8 :=__common__( map(trim(C_CARTHEFT) = ''      => 0.0028870359,
               ((real)c_cartheft < 174.5) => -0.00045709264,
                                             0.0028870359));

N1442_7 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => 0.0019857673,
               ((real)f_mos_inq_banko_om_lseen_d < 28.5)  => 0.012231621,
                                                             0.0019857673));

N1442_6 :=__common__( map(trim(C_INC_15K_P) = ''              => N1442_8,
               ((real)c_inc_15k_p < 5.44999980927) => N1442_7,
                                                      N1442_8));

N1442_5 :=__common__( if(((real)c_serv_empl < 188.5), N1442_6, -0.004559495));

N1442_4 :=__common__( if(trim(C_SERV_EMPL) != '', N1442_5, 0.0021845711));

N1442_3 :=__common__( map(((real)f_attr_arrest_recency_d <= NULL) => N1442_4,
               ((real)f_attr_arrest_recency_d < 79.5)  => -0.0069785368,
                                                          N1442_4));

N1442_2 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i < 113.5), -0.0016309686, N1442_3));

N1442_1 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i > NULL), N1442_2, -0.003454453));

N1443_10 :=__common__( map(((real)f_fp_prevaddrcrimeindex_i <= NULL) => 0.010186591,
                ((real)f_fp_prevaddrcrimeindex_i < 154.5) => 0.0024355294,
                                                             0.010186591));

N1443_9 :=__common__( map(trim(C_HEALTH) = ''              => N1443_10,
               ((real)c_health < 8.44999980927) => -0.00061195697,
                                                   N1443_10));

N1443_8 :=__common__( if(((real)c_fammar_p < 30.25), -0.0038720965, N1443_9));

N1443_7 :=__common__( if(trim(C_FAMMAR_P) != '', N1443_8, -0.00080329581));

N1443_6 :=__common__( if(((real)c_sfdu_p < 65.3500061035), 0.0024683744, -0.010150471));

N1443_5 :=__common__( if(trim(C_SFDU_P) != '', N1443_6, -0.018404602));

N1443_4 :=__common__( if(((real)c_mos_since_impulse_fs_d < 55.5), N1443_5, N1443_7));

N1443_3 :=__common__( if(((real)c_mos_since_impulse_fs_d > NULL), N1443_4, -0.0058751333));

N1443_2 :=__common__( map(((real)r_prop_owner_history_d <= NULL) => -0.0034099972,
               ((real)r_prop_owner_history_d < 0.5)   => 0.00078966028,
                                                         -0.0034099972));

N1443_1 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1443_2, N1443_3));

N1444_7 :=__common__( map(((real)f_mos_liens_unrel_lt_lseen_d <= NULL) => 0.0030421511,
               ((real)f_mos_liens_unrel_lt_lseen_d < 99.5)  => -0.0040089079,
                                                               0.0030421511));

N1444_6 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => N1444_7,
               ((real)f_inq_per_ssn_i < 1.5)   => -0.0011100098,
                                                  N1444_7));

N1444_5 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N1444_6, 0.022537506));

N1444_4 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => 0.0087214301,
               ((real)f_add_input_nhood_vac_pct_i < 0.0743882656097) => -0.00066558175,
                                                                        0.0087214301));

N1444_3 :=__common__( if(((real)c_easiqlife < 131.5), -0.0039880863, N1444_4));

N1444_2 :=__common__( if(trim(C_EASIQLIFE) != '', N1444_3, -0.0041712203));

N1444_1 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS FLS', 'SEARS SHO']) => N1444_2,
               (segment in ['KMART'])                                          => N1444_5,
                                                                                  N1444_2));

N1445_9 :=__common__( if(((real)r_d34_unrel_lien60_count_i < 0.5), 0.00086398587, 0.0053342332));

N1445_8 :=__common__( if(((real)r_d34_unrel_lien60_count_i > NULL), N1445_9, -0.002152266));

N1445_7 :=__common__( map(trim(C_HIGH_ED) = ''              => -0.00044470674,
               ((real)c_high_ed < 17.9500007629) => N1445_8,
                                                    -0.00044470674));

N1445_6 :=__common__( if(((integer)r_f01_inp_addr_address_score_d < 95), 0.0058256973, -0.0061583062));

N1445_5 :=__common__( if(((real)r_f01_inp_addr_address_score_d > NULL), N1445_6, 0.029035023));

N1445_4 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => -0.0079493619,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.746489644051) => N1445_5,
                                                                      -0.0079493619));

N1445_3 :=__common__( map(trim(C_RETIRED2) = ''     => N1445_7,
               ((real)c_retired2 < 34.5) => N1445_4,
                                            N1445_7));

N1445_2 :=__common__( if(((real)c_med_rent < 440.5), -0.0019516464, N1445_3));

N1445_1 :=__common__( if(trim(C_MED_RENT) != '', N1445_2, -0.0016531601));

N1446_8 :=__common__( if(((real)f_prevaddrstatus_i > NULL), 0.0028016795, 0.01974071));

N1446_7 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => N1446_8,
               ((real)f_add_input_mobility_index_n < 0.337031573057) => -0.0037869419,
                                                                        N1446_8));

N1446_6 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.0590413957834), 0.010953083, N1446_7));

N1446_5 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1446_6, -0.0027660318));

N1446_4 :=__common__( map(trim(C_HVAL_100K_P) = ''              => 0.0076205351,
               ((real)c_hval_100k_p < 42.6500015259) => -0.00021192724,
                                                        0.0076205351));

N1446_3 :=__common__( map(trim(C_LOWINC) = ''              => -0.0033366997,
               ((real)c_lowinc < 66.5500030518) => N1446_4,
                                                   -0.0033366997));

N1446_2 :=__common__( if(((real)c_inc_25k_p < 22.8499984741), N1446_3, N1446_5));

N1446_1 :=__common__( if(trim(C_INC_25K_P) != '', N1446_2, -0.0027000434));

N1447_9 :=__common__( map(trim(C_BLUE_COL) = ''              => -0.00025221208,
               ((real)c_blue_col < 10.0500001907) => 0.0031723685,
                                                     -0.00025221208));

N1447_8 :=__common__( if(((integer)f_curraddrmedianvalue_d < 31956), 0.0068076043, N1447_9));

N1447_7 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N1447_8, 0.00030394557));

N1447_6 :=__common__( map(trim(C_CPIALL) = ''              => -0.0011540579,
               ((real)c_cpiall < 203.600006104) => -0.0068753911,
                                                   -0.0011540579));

N1447_5 :=__common__( map(trim(C_HVAL_60K_P) = ''     => 0.0093685381,
               ((real)c_hval_60k_p < 5.75) => 0.00011540115,
                                              0.0093685381));

N1447_4 :=__common__( if(((real)c_mos_since_impulse_fs_d < 55.5), N1447_5, N1447_6));

N1447_3 :=__common__( if(((real)c_mos_since_impulse_fs_d > NULL), N1447_4, -0.008532811));

N1447_2 :=__common__( if(((real)c_hh1_p < 27.0499992371), N1447_3, N1447_7));

N1447_1 :=__common__( if(trim(C_HH1_P) != '', N1447_2, 0.0061690986));

N1448_9 :=__common__( if(((real)c_hh1_p < 26.3499984741), 0.0094883007, 0.0002558452));

N1448_8 :=__common__( if(trim(C_HH1_P) != '', N1448_9, 0.0053730048));

N1448_7 :=__common__( map(trim(C_INC_15K_P) = ''              => 0.0029543674,
               ((real)c_inc_15k_p < 12.4499998093) => 0.012892771,
                                                      0.0029543674));

N1448_6 :=__common__( if(((real)c_lux_prod < 78.5), N1448_7, -0.0012262146));

N1448_5 :=__common__( if(trim(C_LUX_PROD) != '', N1448_6, 0.018883374));

N1448_4 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => -0.0035943541,
               ((real)c_hist_addr_match_i < 8.5)   => N1448_5,
                                                      -0.0035943541));

N1448_3 :=__common__( map(((real)f_mos_liens_unrel_sc_fseen_d <= NULL) => -0.00064129941,
               ((real)f_mos_liens_unrel_sc_fseen_d < 238.5) => N1448_4,
                                                               -0.00064129941));

N1448_2 :=__common__( if(((real)f_crim_rel_under100miles_cnt_i < 13.5), N1448_3, N1448_8));

N1448_1 :=__common__( if(((real)f_crim_rel_under100miles_cnt_i > NULL), N1448_2, -0.0018455743));

N1449_10 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.677649378777), 0.00223623, 0.010361137));

N1449_9 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1449_10, 0.0037496505));

N1449_8 :=__common__( map(trim(C_CIV_EMP) = ''              => N1449_9,
               ((real)c_civ_emp < 39.9500007629) => -0.0045506135,
                                                    N1449_9));

N1449_7 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => N1449_8,
               ((real)f_curraddrcartheftindex_i < 178.5) => -0.00068451764,
                                                            N1449_8));

N1449_6 :=__common__( if(((real)c_wholesale < 2.25), N1449_7, -0.0028203273));

N1449_5 :=__common__( if(trim(C_WHOLESALE) != '', N1449_6, 0.0023898005));

N1449_4 :=__common__( if(((real)f_rel_educationover12_count_d < 6.5), 0.00097632875, 0.0099502682));

N1449_3 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N1449_4, 0.0056675807));

N1449_2 :=__common__( if(((real)c_addr_lres_12mo_ct_i < 0.5), N1449_3, N1449_5));

N1449_1 :=__common__( if(((real)c_addr_lres_12mo_ct_i > NULL), N1449_2, -0.0025861718));

N1450_8 :=__common__( map(trim(C_INC_15K_P) = ''              => -0.010260022,
               ((real)c_inc_15k_p < 29.0499992371) => -0.0027608986,
                                                      -0.010260022));

N1450_7 :=__common__( map(((real)r_d32_criminal_count_i <= NULL) => 0.0045003348,
               ((real)r_d32_criminal_count_i < 2.5)   => -0.0056417387,
                                                         0.0045003348));

N1450_6 :=__common__( map(trim(C_INC_125K_P) = ''     => 0.0066466574,
               ((real)c_inc_125k_p < 0.75) => -0.0016141744,
                                              0.0066466574));

N1450_5 :=__common__( if(((real)f_rel_under100miles_cnt_d < 10.5), N1450_6, N1450_7));

N1450_4 :=__common__( if(((real)f_rel_under100miles_cnt_d > NULL), N1450_5, 0.004131972));

N1450_3 :=__common__( map(trim(C_INC_125K_P) = ''              => N1450_8,
               ((real)c_inc_125k_p < 3.15000009537) => N1450_4,
                                                       N1450_8));

N1450_2 :=__common__( if(((real)c_popover25 < 659.5), N1450_3, 0.00037835428));

N1450_1 :=__common__( if(trim(C_POPOVER25) != '', N1450_2, 0.0031128536));

N1451_11 :=__common__( if(((real)f_rel_educationover12_count_d < 31.5), 0.00013798339, 0.0068950224));

N1451_10 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N1451_11, -0.0030267768));

N1451_9 :=__common__( if(((real)c_mos_since_impulse_fs_d < 35.5), 0.0056324579, N1451_10));

N1451_8 :=__common__( if(((real)c_mos_since_impulse_fs_d > NULL), N1451_9, -0.0031102917));

N1451_7 :=__common__( if(((real)c_low_ed < 82.1499938965), N1451_8, -0.0050591917));

N1451_6 :=__common__( if(trim(C_LOW_ED) != '', N1451_7, 0.00023980319));

N1451_5 :=__common__( map(trim(C_LOWINC) = ''              => 0.00040084193,
               ((real)c_lowinc < 60.1500015259) => -0.010948828,
                                                   0.00040084193));

N1451_4 :=__common__( if(((real)c_femdiv_p < 7.05000019073), N1451_5, 0.0021890916));

N1451_3 :=__common__( if(trim(C_FEMDIV_P) != '', N1451_4, 0.0024162453));

N1451_2 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d < 0.235328555107), N1451_3, N1451_6));

N1451_1 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d > NULL), N1451_2, -0.011934361));

N1452_9 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)         => 0.012031861,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.70365023613) => 0.0032146527,
                                                                     0.012031861));

N1452_8 :=__common__( if(((real)f_srchaddrsrchcount_i < 1.5), -0.0024895259, N1452_9));

N1452_7 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N1452_8, -0.032403857));

N1452_6 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL) => -0.0022185193,
               ((integer)f_fp_prevaddrburglaryindex_i < 41) => 0.0090585139,
                                                               -0.0022185193));

N1452_5 :=__common__( map(trim(C_OCCUNIT_P) = ''              => N1452_6,
               ((real)c_occunit_p < 88.6499938965) => 0.0083000046,
                                                      N1452_6));

N1452_4 :=__common__( if(((real)f_rel_incomeover75_count_d < 2.5), -0.00058746841, N1452_5));

N1452_3 :=__common__( if(((real)f_rel_incomeover75_count_d > NULL), N1452_4, -0.0023151233));

N1452_2 :=__common__( if(((real)c_hh1_p < 49.9500007629), N1452_3, N1452_7));

N1452_1 :=__common__( if(trim(C_HH1_P) != '', N1452_2, -0.0014263439));

N1453_8 :=__common__( map(trim(C_POP_6_11_P) = ''              => 0.0015725511,
               ((real)c_pop_6_11_p < 6.94999980927) => 0.014414975,
                                                       0.0015725511));

N1453_7 :=__common__( map(trim(C_BIGAPT_P) = ''              => 0.00062923935,
               ((real)c_bigapt_p < 1.84999990463) => 0.013125361,
                                                     0.00062923935));

N1453_6 :=__common__( map(((real)f_inq_per_phone_i <= NULL) => N1453_7,
               ((real)f_inq_per_phone_i < 1.5)   => 4.1579086e-005,
                                                    N1453_7));

N1453_5 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0134443081915), 0.0090032016, N1453_6));

N1453_4 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1453_5, 0.00092458202));

N1453_3 :=__common__( map(trim(C_NO_TEENS) = ''      => N1453_4,
               ((real)c_no_teens < 130.5) => -0.00049822798,
                                             N1453_4));

N1453_2 :=__common__( if(((real)c_rnt1000_p < 46.8499984741), N1453_3, N1453_8));

N1453_1 :=__common__( if(trim(C_RNT1000_P) != '', N1453_2, -0.0010651527));

N1454_8 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL) => 0.0013488028,
               ((real)f_prevaddrcartheftindex_i < 166.5) => -0.0046812123,
                                                            0.0013488028));

N1454_7 :=__common__( map(trim(C_LOWINC) = ''              => N1454_8,
               ((real)c_lowinc < 12.4499998093) => 0.0065821394,
                                                   N1454_8));

N1454_6 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => -0.00073915138,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.756052494049) => 0.0082891637,
                                                                      -0.00073915138));

N1454_5 :=__common__( map(trim(C_CPIALL) = ''      => N1454_7,
               ((real)c_cpiall < 208.5) => N1454_6,
                                           N1454_7));

N1454_4 :=__common__( if(((real)f_srchaddrsrchcount_i < 26.5), N1454_5, -0.0079834749));

N1454_3 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N1454_4, -0.0095107123));

N1454_2 :=__common__( if(((real)c_bel_edu < 112.5), N1454_3, 0.00069638974));

N1454_1 :=__common__( if(trim(C_BEL_EDU) != '', N1454_2, -0.0003656271));

N1455_8 :=__common__( map(trim(C_RENTAL) = ''      => 0.0041859537,
               ((real)c_rental < 193.5) => -0.00096702888,
                                           0.0041859537));

N1455_7 :=__common__( map(trim(C_HOUSINGCPI) = ''              => 0.0056248852,
               ((real)c_housingcpi < 195.149993896) => -0.0033128331,
                                                       0.0056248852));

N1455_6 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 188.5), 0.009744528, N1455_7));

N1455_5 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N1455_6, 0.0087967378));

N1455_4 :=__common__( map(trim(C_TRAILER_P) = ''              => -0.0023928352,
               ((real)c_trailer_p < 1.65000009537) => N1455_5,
                                                      -0.0023928352));

N1455_3 :=__common__( map(trim(C_INC_75K_P) = ''     => N1455_4,
               ((real)c_inc_75k_p < 5.25) => -0.0044387358,
                                             N1455_4));

N1455_2 :=__common__( if(((real)c_families < 189.5), N1455_3, N1455_8));

N1455_1 :=__common__( if(trim(C_FAMILIES) != '', N1455_2, -0.0036025588));

N1456_9 :=__common__( map(trim(C_BLUE_COL) = ''              => 0.0021674767,
               ((real)c_blue_col < 11.0500001907) => 0.011712802,
                                                     0.0021674767));

N1456_8 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)    => -0.0066769688,
               ((real)f_curraddrmedianvalue_d < 131821.5) => N1456_9,
                                                             -0.0066769688));

N1456_7 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.437212944031), N1456_8, 0.011111032));

N1456_6 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1456_7, 0.0035137275));

N1456_5 :=__common__( if(((real)c_pop_18_24_p < 8.55000019073), 0.0046887795, -0.0051887067));

N1456_4 :=__common__( if(trim(C_POP_18_24_P) != '', N1456_5, 0.016221222));

N1456_3 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => N1456_6,
               ((real)f_add_input_nhood_vac_pct_i < 0.066876642406) => N1456_4,
                                                                       N1456_6));

N1456_2 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.109784588218), -0.00087174569, N1456_3));

N1456_1 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1456_2, 0.00090348475));

N1457_8 :=__common__( map(trim(C_TOTSALES) = ''         => 0.00092625922,
               ((real)c_totsales < 105505.5) => 0.0095921515,
                                                0.00092625922));

N1457_7 :=__common__( map(trim(C_RELIG_INDX) = ''      => 0.011405407,
               ((real)c_relig_indx < 168.5) => 0.00087138231,
                                               0.011405407));

N1457_6 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => N1457_7,
               ((real)f_inq_per_ssn_i < 4.5)   => -0.00086208591,
                                                  N1457_7));

N1457_5 :=__common__( map(((real)c_addr_lres_12mo_ct_i <= NULL) => -0.0033677638,
               ((real)c_addr_lres_12mo_ct_i < 10.5)  => N1457_6,
                                                        -0.0033677638));

N1457_4 :=__common__( if(((integer)c_employees < 2604), N1457_5, N1457_8));

N1457_3 :=__common__( if(trim(C_EMPLOYEES) != '', N1457_4, 0.0030261049));

N1457_2 :=__common__( if(((real)c_addr_lres_2mo_ct_i < 6.5), N1457_3, 0.0056705341));

N1457_1 :=__common__( if(((real)c_addr_lres_2mo_ct_i > NULL), N1457_2, 0.0013415666));

N1458_9 :=__common__( map(trim(C_HEALTH) = ''              => -0.0065201615,
               ((real)c_health < 19.1500015259) => -0.0011957173,
                                                   -0.0065201615));

N1458_8 :=__common__( if(((real)f_rel_bankrupt_count_i < 0.5), 0.0090300334, -0.0022486232));

N1458_7 :=__common__( if(((real)f_rel_bankrupt_count_i > NULL), N1458_8, -0.0049833121));

N1458_6 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)           => 0.00035347348,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.0672264695168) => 0.0086736671,
                                                                       0.00035347348));

N1458_5 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1458_6, N1458_7));

N1458_4 :=__common__( map(trim(C_POPOVER18) = ''      => N1458_5,
               ((real)c_popover18 < 411.5) => 0.0084090338,
                                              N1458_5));

N1458_3 :=__common__( map(trim(C_MANUFACTURING) = ''      => -0.0047475693,
               ((real)c_manufacturing < 17.75) => N1458_4,
                                                  -0.0047475693));

N1458_2 :=__common__( if(((real)c_inc_125k_p < 7.55000019073), N1458_3, N1458_9));

N1458_1 :=__common__( if(trim(C_INC_125K_P) != '', N1458_2, -0.0017836773));

N1459_8 :=__common__( map(trim(C_CHILD) = ''              => 0.0068716746,
               ((real)c_child < 30.9500007629) => -0.0017098532,
                                                  0.0068716746));

N1459_7 :=__common__( map(trim(C_CHILD) = ''              => 0.0058190717,
               ((real)c_child < 32.5499992371) => -0.0032390249,
                                                  0.0058190717));

N1459_6 :=__common__( map(trim(C_BORN_USA) = ''     => 0.0027353496,
               ((real)c_born_usa < 93.5) => N1459_7,
                                            0.0027353496));

N1459_5 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1459_6, -0.00052928704));

N1459_4 :=__common__( map(trim(C_INCOLLEGE) = ''              => 0.0097401451,
               ((real)c_incollege < 12.8500003815) => N1459_5,
                                                      0.0097401451));

N1459_3 :=__common__( map(trim(C_NO_CAR) = ''      => -0.0010696212,
               ((real)c_no_car < 127.5) => N1459_4,
                                           -0.0010696212));

N1459_2 :=__common__( if(((real)c_preschl < 193.5), N1459_3, N1459_8));

N1459_1 :=__common__( if(trim(C_PRESCHL) != '', N1459_2, 0.002924807));

N1460_9 :=__common__( map(trim(C_LOW_ED) = ''              => -0.0074647543,
               ((real)c_low_ed < 68.0500030518) => -0.0007062651,
                                                   -0.0074647543));

N1460_8 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 4.5), 0.0023319941, -0.0056369469));

N1460_7 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N1460_8, -0.0013519395));

N1460_6 :=__common__( map(((real)r_i60_inq_banking_recency_d <= NULL)  => 0.0035873568,
               ((integer)r_i60_inq_banking_recency_d < 549) => N1460_7,
                                                               0.0035873568));

N1460_5 :=__common__( map(trim(C_AB_AV_EDU) = ''     => N1460_9,
               ((real)c_ab_av_edu < 60.5) => N1460_6,
                                             N1460_9));

N1460_4 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 27.5), -0.0067766705, N1460_5));

N1460_3 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N1460_4, -0.0062930302));

N1460_2 :=__common__( if(((real)c_hh4_p < 10.1499996185), 0.0015832845, N1460_3));

N1460_1 :=__common__( if(trim(C_HH4_P) != '', N1460_2, 0.00093772602));

N1461_9 :=__common__( map(((real)f_corraddrnamecount_d <= NULL) => 0.0093493043,
               ((real)f_corraddrnamecount_d < 4.5)   => -0.001291779,
                                                        0.0093493043));

N1461_8 :=__common__( map(trim(C_FAMOTF18_P) = ''              => -0.0068856112,
               ((real)c_famotf18_p < 33.5499992371) => -0.00040628778,
                                                       -0.0068856112));

N1461_7 :=__common__( map(trim(C_NEW_HOMES) = ''      => -0.006590969,
               ((real)c_new_homes < 188.5) => 0.0017615771,
                                              -0.006590969));

N1461_6 :=__common__( if(((real)c_many_cars < 82.5), N1461_7, N1461_8));

N1461_5 :=__common__( if(trim(C_MANY_CARS) != '', N1461_6, 0.0034111562));

N1461_4 :=__common__( if(((real)f_inq_per_addr_i < 6.5), N1461_5, -0.0026543527));

N1461_3 :=__common__( if(((real)f_inq_per_addr_i > NULL), N1461_4, 0.023733417));

N1461_2 :=__common__( if(((real)f_accident_count_i < 1.5), N1461_3, N1461_9));

N1461_1 :=__common__( if(((real)f_accident_count_i > NULL), N1461_2, 0.0036016389));

N1462_9 :=__common__( map(trim(C_HVAL_125K_P) = ''              => -0.0021654283,
               ((real)c_hval_125k_p < 14.8500003815) => 0.001987254,
                                                        -0.0021654283));

N1462_8 :=__common__( if(((real)f_rel_count_i < 3.5), 0.0081293284, N1462_9));

N1462_7 :=__common__( if(((real)f_rel_count_i > NULL), N1462_8, -0.00044998179));

N1462_6 :=__common__( map(trim(C_HOUSINGCPI) = ''      => N1462_7,
               ((real)c_housingcpi < 197.5) => -0.0096378969,
                                               N1462_7));

N1462_5 :=__common__( map(((real)f_varmsrcssnunrelcount_i <= NULL) => 0.0027095214,
               ((real)f_varmsrcssnunrelcount_i < 1.5)   => -0.0037873107,
                                                           0.0027095214));

N1462_4 :=__common__( if(((real)f_sourcerisktype_i < 4.5), 0.002378951, N1462_5));

N1462_3 :=__common__( if(((real)f_sourcerisktype_i > NULL), N1462_4, -0.00016656273));

N1462_2 :=__common__( if(((real)c_easiqlife < 116.5), N1462_3, N1462_6));

N1462_1 :=__common__( if(trim(C_EASIQLIFE) != '', N1462_2, 0.0041569778));

N1463_8 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => -0.0069164776,
               ((real)f_sourcerisktype_i < 5.5)   => 0.0023261301,
                                                     -0.0069164776));

N1463_7 :=__common__( map(trim(C_SPAN_LANG) = ''     => N1463_8,
               ((real)c_span_lang < 49.5) => 0.0081347928,
                                             N1463_8));

N1463_6 :=__common__( map(trim(C_VACANT_P) = ''              => -0.0042536079,
               ((real)c_vacant_p < 15.4499998093) => N1463_7,
                                                     -0.0042536079));

N1463_5 :=__common__( if(((real)c_hval_100k_p < 7.35000038147), -0.0041589711, N1463_6));

N1463_4 :=__common__( if(trim(C_HVAL_100K_P) != '', N1463_5, 0.0022346859));

N1463_3 :=__common__( map(((real)f_rel_count_i <= NULL) => N1463_4,
               ((real)f_rel_count_i < 21.5)  => 0.00064957169,
                                                N1463_4));

N1463_2 :=__common__( if(((real)f_prevaddrmedianvalue_d < 459783.5), N1463_3, 0.0086988921));

N1463_1 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N1463_2, 0.002203973));

N1464_8 :=__common__( map(trim(C_ARMFORCE) = ''      => 0.0044252027,
               ((real)c_armforce < 127.5) => -0.0050585353,
                                             0.0044252027));

N1464_7 :=__common__( map(trim(C_RNT1000_P) = ''              => N1464_8,
               ((real)c_rnt1000_p < 21.6500015259) => 0.0050520816,
                                                      N1464_8));

N1464_6 :=__common__( map(trim(C_HVAL_200K_P) = ''              => N1464_7,
               ((real)c_hval_200k_p < 12.3500003815) => -0.00059706035,
                                                        N1464_7));

N1464_5 :=__common__( map(trim(C_RNT1000_P) = ''              => 0.0074651339,
               ((real)c_rnt1000_p < 14.6499996185) => -0.0021788676,
                                                      0.0074651339));

N1464_4 :=__common__( map(trim(C_HVAL_100K_P) = ''      => 0.0099502101,
               ((real)c_hval_100k_p < 16.75) => N1464_5,
                                                0.0099502101));

N1464_3 :=__common__( if(((real)f_prevaddrmedianincome_d < 12151.5), N1464_4, N1464_6));

N1464_2 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N1464_3, -0.0021601761));

N1464_1 :=__common__( if(trim(C_PROFESSIONAL) != '', N1464_2, -0.0043707083));

N1465_10 :=__common__( map(trim(C_HH00) = ''      => 0.0076366793,
                ((real)c_hh00 < 446.5) => -0.0014540463,
                                          0.0076366793));

N1465_9 :=__common__( if(((real)c_pop_45_54_p < 12.8500003815), -0.0031977653, N1465_10));

N1465_8 :=__common__( if(trim(C_POP_45_54_P) != '', N1465_9, -0.0044991528));

N1465_7 :=__common__( map(((real)f_inq_per_phone_i <= NULL) => -0.008788994,
               ((real)f_inq_per_phone_i < 2.5)   => N1465_8,
                                                    -0.008788994));

N1465_6 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i < 2.5), 0.0038133252, -0.0039756554));

N1465_5 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i > NULL), N1465_6, 0.0026184595));

N1465_4 :=__common__( if(((real)c_blue_col < 15.3500003815), N1465_5, -0.0056779163));

N1465_3 :=__common__( if(trim(C_BLUE_COL) != '', N1465_4, 0.0038853617));

N1465_2 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.0338367819786), N1465_3, 0.00012502757));

N1465_1 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1465_2, N1465_7));

N1466_8 :=__common__( map(trim(C_PRESCHL) = ''     => -0.00014627607,
               ((real)c_preschl < 59.5) => 0.010380322,
                                           -0.00014627607));

N1466_7 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => N1466_8,
               ((real)r_d32_mos_since_crim_ls_d < 53.5)  => 0.011790587,
                                                            N1466_8));

N1466_6 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO', 'SEARS SHO']) => -0.00032004076,
               (segment in ['SEARS FLS'])                                  => N1466_7,
                                                                              -0.00032004076));

N1466_5 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d < 33.5), -0.0011929309, N1466_6));

N1466_4 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d > NULL), N1466_5, -0.0059001129));

N1466_3 :=__common__( map(trim(C_MANY_CARS) = ''      => -0.0018192693,
               ((real)c_many_cars < 141.5) => 0.0091292234,
                                              -0.0018192693));

N1466_2 :=__common__( if(((real)c_larceny < 22.5), N1466_3, N1466_4));

N1466_1 :=__common__( if(trim(C_LARCENY) != '', N1466_2, -0.0020311817));

N1467_9 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.00087833706,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0596410930157) => 0.012526174,
                                                                       0.00087833706));

N1467_8 :=__common__( if(((real)c_rnt500_p < 10.5500001907), -0.0022638483, N1467_9));

N1467_7 :=__common__( if(trim(C_RNT500_P) != '', N1467_8, -0.0018911427));

N1467_6 :=__common__( map(trim(C_HVAL_100K_P) = ''              => -0.0038169902,
               ((real)c_hval_100k_p < 12.6499996185) => 0.0055880898,
                                                        -0.0038169902));

N1467_5 :=__common__( map(((real)r_d30_derog_count_i <= NULL) => N1467_6,
               ((real)r_d30_derog_count_i < 0.5)   => -0.0069372764,
                                                      N1467_6));

N1467_4 :=__common__( if(((real)c_pop_0_5_p < 5.75), -0.01027698, N1467_5));

N1467_3 :=__common__( if(trim(C_POP_0_5_P) != '', N1467_4, -0.0045549268));

N1467_2 :=__common__( map(((real)f_corraddrnamecount_d <= NULL) => N1467_7,
               ((real)f_corraddrnamecount_d < 5.5)   => N1467_3,
                                                        N1467_7));

N1467_1 :=__common__( if(((real)f_college_income_d > NULL), N1467_2, 0.00071137064));

N1468_9 :=__common__( map(trim(C_TOTSALES) = ''        => 0.00069017051,
               ((integer)c_totsales < 4104) => 0.007262785,
                                               0.00069017051));

N1468_8 :=__common__( if(((real)f_mos_liens_unrel_sc_fseen_d < 89.5), 0.0046290953, -0.0035152493));

N1468_7 :=__common__( if(((real)f_mos_liens_unrel_sc_fseen_d > NULL), N1468_8, 0.0066691961));

N1468_6 :=__common__( if(((real)f_prevaddrmedianincome_d < 52469.5), -0.0012003259, 0.0058554609));

N1468_5 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N1468_6, 0.0076050088));

N1468_4 :=__common__( map(trim(C_HVAL_60K_P) = ''      => 0.0087924686,
               ((real)c_hval_60k_p < 33.75) => N1468_5,
                                               0.0087924686));

N1468_3 :=__common__( map(trim(C_SPAN_LANG) = ''     => N1468_7,
               ((real)c_span_lang < 89.5) => N1468_4,
                                             N1468_7));

N1468_2 :=__common__( if(((integer)c_totsales < 3260), N1468_3, N1468_9));

N1468_1 :=__common__( if(trim(C_TOTSALES) != '', N1468_2, 0.0011346833));

N1469_8 :=__common__( map(trim(C_HVAL_150K_P) = ''      => -0.0048260231,
               ((real)c_hval_150k_p < 20.25) => 0.0052660412,
                                                -0.0048260231));

N1469_7 :=__common__( if(((real)r_i61_inq_collection_recency_d < 61.5), N1469_8, 0.00018586498));

N1469_6 :=__common__( if(((real)r_i61_inq_collection_recency_d > NULL), N1469_7, 0.0019655353));

N1469_5 :=__common__( map(trim(C_MEDI_INDX) = ''      => -0.0060094898,
               ((real)c_medi_indx < 110.5) => N1469_6,
                                              -0.0060094898));

N1469_4 :=__common__( map(trim(C_EMPLOYEES) = ''       => 0.0095654681,
               ((integer)c_employees < 547) => N1469_5,
                                               0.0095654681));

N1469_3 :=__common__( map(trim(C_POP_18_24_P) = ''              => N1469_4,
               ((real)c_pop_18_24_p < 2.45000004768) => -0.0075969696,
                                                        N1469_4));

N1469_2 :=__common__( if(((real)c_food < 21.25), -0.0012572783, N1469_3));

N1469_1 :=__common__( if(trim(C_FOOD) != '', N1469_2, 0.0004096153));

N1470_8 :=__common__( map(trim(C_HEALTH) = ''              => 0.0087074317,
               ((real)c_health < 7.05000019073) => -0.0037328075,
                                                   0.0087074317));

N1470_7 :=__common__( map(trim(C_MED_HHINC) = ''         => N1470_8,
               ((integer)c_med_hhinc < 51813) => 0.010759325,
                                                 N1470_8));

N1470_6 :=__common__( map(trim(C_INC_25K_P) = ''              => -0.0029716762,
               ((real)c_inc_25k_p < 15.1499996185) => N1470_7,
                                                      -0.0029716762));

N1470_5 :=__common__( if(((real)f_rel_bankrupt_count_i < 5.5), -7.7320944e-005, 0.0033473183));

N1470_4 :=__common__( if(((real)f_rel_bankrupt_count_i > NULL), N1470_5, 0.0015953671));

N1470_3 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => N1470_6,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.977701067924) => N1470_4,
                                                                      N1470_6));

N1470_2 :=__common__( if(((real)c_pop_6_11_p < 2.75), -0.0065246754, N1470_3));

N1470_1 :=__common__( if(trim(C_POP_6_11_P) != '', N1470_2, -0.0055765282));

N1471_10 :=__common__( map(((real)f_srchunvrfdssncount_i <= NULL) => 0.0038664152,
                ((real)f_srchunvrfdssncount_i < 0.5)   => -0.0045321411,
                                                          0.0038664152));

N1471_9 :=__common__( if(((real)c_unique_addr_count_i < 5.5), 0.0059352418, N1471_10));

N1471_8 :=__common__( if(((real)c_unique_addr_count_i > NULL), N1471_9, 0.0070884369));

N1471_7 :=__common__( if(((real)c_hh4_p < 10.6499996185), -0.00011213934, 0.010014373));

N1471_6 :=__common__( if(trim(C_HH4_P) != '', N1471_7, 0.064108378));

N1471_5 :=__common__( map(trim(C_HH7P_P) = ''              => -0.0034792791,
               ((real)c_hh7p_p < 2.65000009537) => 0.003977512,
                                                   -0.0034792791));

N1471_4 :=__common__( if(((real)c_cpiall < 208.5), N1471_5, -0.0010330635));

N1471_3 :=__common__( if(trim(C_CPIALL) != '', N1471_4, 0.0078406315));

N1471_2 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.731559276581), N1471_3, N1471_6));

N1471_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1471_2, N1471_8));

N1472_8 :=__common__( map(trim(C_WORK_HOME) = ''     => -0.0027325348,
               ((real)c_work_home < 63.5) => 0.0081236463,
                                             -0.0027325348));

N1472_7 :=__common__( map(((real)f_inq_communications_count24_i <= NULL) => -0.0087338575,
               ((real)f_inq_communications_count24_i < 3.5)   => -0.0017354936,
                                                                 -0.0087338575));

N1472_6 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => 0.0055902369,
               ((real)r_c13_max_lres_d < 191.5) => N1472_7,
                                                   0.0055902369));

N1472_5 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)          => -0.009658202,
               ((real)f_add_input_nhood_sfd_pct_d < 0.969331502914) => N1472_6,
                                                                       -0.009658202));

N1472_4 :=__common__( if(((real)f_inq_other_count24_i < 2.5), N1472_5, N1472_8));

N1472_3 :=__common__( if(((real)f_inq_other_count24_i > NULL), N1472_4, 0.0071482768));

N1472_2 :=__common__( if(((real)c_inc_35k_p < 14.3500003815), 0.0006829639, N1472_3));

N1472_1 :=__common__( if(trim(C_INC_35K_P) != '', N1472_2, 0.0022581667));

N1473_7 :=__common__( map((fp_segment in ['4 Bureau Only', '7 Other'])                                             => -0.010824751,
               (fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '5 Derog', '6 Recent Activity']) => 0.0033230333,
                                                                                                           0.0033230333));

N1473_6 :=__common__( map(trim(C_LUX_PROD) = ''     => -0.011067914,
               ((real)c_lux_prod < 49.5) => N1473_7,
                                            -0.011067914));

N1473_5 :=__common__( map(trim(C_HVAL_300K_P) = ''              => -0.0015228652,
               ((real)c_hval_300k_p < 2.95000004768) => 0.0090867605,
                                                        -0.0015228652));

N1473_4 :=__common__( map(trim(C_VERY_RICH) = ''      => 0.0015257699,
               ((real)c_very_rich < 115.5) => -0.00068611355,
                                              0.0015257699));

N1473_3 :=__common__( map(trim(C_MED_AGE) = ''              => N1473_5,
               ((real)c_med_age < 47.1500015259) => N1473_4,
                                                    N1473_5));

N1473_2 :=__common__( if(((real)c_inc_35k_p < 20.9500007629), N1473_3, N1473_6));

N1473_1 :=__common__( if(trim(C_INC_35K_P) != '', N1473_2, -0.00059872553));

N1474_10 :=__common__( map(trim(C_HH3_P) = ''              => -0.0005292831,
                ((real)c_hh3_p < 3.95000004768) => -0.0088723992,
                                                   -0.0005292831));

N1474_9 :=__common__( if(((real)f_srchssnsrchcount_i < 43.5), N1474_10, 0.0074345386));

N1474_8 :=__common__( if(((real)f_srchssnsrchcount_i > NULL), N1474_9, -0.0086049952));

N1474_7 :=__common__( map(trim(C_RENTOCC_P) = ''              => 0.0057800913,
               ((real)c_rentocc_p < 58.0499992371) => -0.0020913816,
                                                      0.0057800913));

N1474_6 :=__common__( if(((real)f_rel_under100miles_cnt_d < 5.5), 0.0069656281, N1474_7));

N1474_5 :=__common__( if(((real)f_rel_under100miles_cnt_d > NULL), N1474_6, -0.00088295216));

N1474_4 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 64.5), 0.0080869743, N1474_5));

N1474_3 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N1474_4, -0.014912733));

N1474_2 :=__common__( if(((real)c_families < 189.5), N1474_3, N1474_8));

N1474_1 :=__common__( if(trim(C_FAMILIES) != '', N1474_2, 0.00024539677));

N1475_9 :=__common__( map(trim(C_RETIRED2) = ''     => -0.0050706783,
               ((real)c_retired2 < 59.5) => 0.0023751167,
                                            -0.0050706783));

N1475_8 :=__common__( if(((real)f_rel_ageover50_count_d < 0.5), 1.351147e-005, 0.0048181558));

N1475_7 :=__common__( if(((real)f_rel_ageover50_count_d > NULL), N1475_8, 0.00099766713));

N1475_6 :=__common__( map(trim(C_FAMILIES) = ''      => N1475_7,
               ((real)c_families < 179.5) => 0.008720597,
                                             N1475_7));

N1475_5 :=__common__( map(trim(C_OLDHOUSE) = ''       => N1475_9,
               ((real)c_oldhouse < 203.25) => N1475_6,
                                              N1475_9));

N1475_4 :=__common__( if(((real)c_inc_35k_p < 19.9500007629), N1475_5, 0.0061705391));

N1475_3 :=__common__( if(trim(C_INC_35K_P) != '', N1475_4, -0.0004768322));

N1475_2 :=__common__( if(((real)r_c14_addrs_5yr_i < 3.5), -0.00082476601, N1475_3));

N1475_1 :=__common__( if(((real)r_c14_addrs_5yr_i > NULL), N1475_2, 0.0033896308));

N1476_11 :=__common__( map(trim(C_RENTOCC_P) = ''              => -0.0081786639,
                ((real)c_rentocc_p < 29.4500007629) => 0.00324782,
                                                       -0.0081786639));

N1476_10 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0242167208344), 0.0077085501, N1476_11));

N1476_9 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1476_10, -0.0078659687));

N1476_8 :=__common__( if(((real)c_dist_input_to_prev_addr_i < 13.5), N1476_9, -0.0087537457));

N1476_7 :=__common__( if(((real)c_dist_input_to_prev_addr_i > NULL), N1476_8, 0.0054108552));

N1476_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.257012784481), 0.0012048564, 0.0082733946));

N1476_5 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1476_6, -5.9084317e-005));

N1476_4 :=__common__( if(((real)f_srchaddrsrchcount_i < 0.5), N1476_5, 0.00023598792));

N1476_3 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N1476_4, 0.0013502889));

N1476_2 :=__common__( if(((real)c_amus_indx < 116.5), N1476_3, N1476_7));

N1476_1 :=__common__( if(trim(C_AMUS_INDX) != '', N1476_2, 0.0021879985));

N1477_9 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL) => -0.0085440518,
               ((real)f_prevaddrcartheftindex_i < 173.5) => 0.00083662032,
                                                            -0.0085440518));

N1477_8 :=__common__( if(((real)c_retail < 22.8499984741), N1477_9, 0.0077425132));

N1477_7 :=__common__( if(trim(C_RETAIL) != '', N1477_8, 0.0072144972));

N1477_6 :=__common__( if(((real)c_hval_175k_p < 3.25), -0.0018922158, -0.0095963782));

N1477_5 :=__common__( if(trim(C_HVAL_175K_P) != '', N1477_6, -0.021309534));

N1477_4 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)    => N1477_7,
               ((integer)f_curraddrmedianvalue_d < 97604) => N1477_5,
                                                             N1477_7));

N1477_3 :=__common__( map(((real)r_i60_inq_comm_count12_i <= NULL) => 0.0041502796,
               ((real)r_i60_inq_comm_count12_i < 1.5)   => N1477_4,
                                                           0.0041502796));

N1477_2 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.0087051426,
               ((real)f_inq_other_count24_i < 3.5)   => N1477_3,
                                                        0.0087051426));

N1477_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N1477_2, 0.00022570834));

N1478_10 :=__common__( map(trim(C_INC_15K_P) = ''              => -0.005768323,
                ((real)c_inc_15k_p < 25.1500015259) => 0.0018166628,
                                                       -0.005768323));

N1478_9 :=__common__( map(trim(C_ROBBERY) = ''     => N1478_10,
               ((real)c_robbery < 56.5) => -0.0087529437,
                                           N1478_10));

N1478_8 :=__common__( if(((real)f_rel_under25miles_cnt_d < 20.5), N1478_9, -0.0087146909));

N1478_7 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N1478_8, -0.002221121));

N1478_6 :=__common__( if(((real)c_pop_45_54_p < 8.85000038147), 0.0037768412, N1478_7));

N1478_5 :=__common__( if(trim(C_POP_45_54_P) != '', N1478_6, 0.0078874379));

N1478_4 :=__common__( if(((real)f_inq_per_addr_i < 5.5), 0.00053025864, N1478_5));

N1478_3 :=__common__( if(((real)f_inq_per_addr_i > NULL), N1478_4, 0.0058918664));

N1478_2 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i < 4218.5), N1478_3, -0.0052001065));

N1478_1 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i > NULL), N1478_2, -0.00074598783));

N1479_8 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => 0.0082237542,
               ((real)c_dist_best_to_prev_addr_i < 13.5)  => -0.0001840705,
                                                             0.0082237542));

N1479_7 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => 0.0031472639,
               ((real)f_srchaddrsrchcount_i < 5.5)   => 0.014222856,
                                                        0.0031472639));

N1479_6 :=__common__( map(trim(C_WHITE_COL) = ''      => N1479_8,
               ((real)c_white_col < 17.75) => N1479_7,
                                              N1479_8));

N1479_5 :=__common__( if(((real)r_i60_inq_hiriskcred_count12_i < 0.5), N1479_6, -0.0018258932));

N1479_4 :=__common__( if(((real)r_i60_inq_hiriskcred_count12_i > NULL), N1479_5, 0.0080131311));

N1479_3 :=__common__( map(trim(C_FAMMAR_P) = ''              => 0.00048665409,
               ((real)c_fammar_p < 49.3499984741) => -0.0019996059,
                                                     0.00048665409));

N1479_2 :=__common__( if(((real)c_vacant_p < 17.6500015259), N1479_3, N1479_4));

N1479_1 :=__common__( if(trim(C_VACANT_P) != '', N1479_2, -0.00093384468));

N1480_9 :=__common__( map(trim(C_POPOVER25) = ''       => 0.002050516,
               ((real)c_popover25 < 1415.5) => 0.012765799,
                                               0.002050516));

N1480_8 :=__common__( if(((real)r_c14_addrs_10yr_i < 9.5), -0.0024254072, 0.0079223283));

N1480_7 :=__common__( if(((real)r_c14_addrs_10yr_i > NULL), N1480_8, -0.001752825));

N1480_6 :=__common__( map(trim(C_HVAL_125K_P) = ''     => N1480_9,
               ((real)c_hval_125k_p < 9.75) => N1480_7,
                                               N1480_9));

N1480_5 :=__common__( map(trim(C_TOTSALES) = ''        => N1480_6,
               ((real)c_totsales < 10670.5) => 0.00089424388,
                                               N1480_6));

N1480_4 :=__common__( if(((real)f_srchssnsrchcount_i < 34.5), -0.00027945312, -0.009626698));

N1480_3 :=__common__( if(((real)f_srchssnsrchcount_i > NULL), N1480_4, -0.014094779));

N1480_2 :=__common__( if(((real)c_pop_45_54_p < 13.1499996185), N1480_3, N1480_5));

N1480_1 :=__common__( if(trim(C_POP_45_54_P) != '', N1480_2, 0.00041498498));

N1481_9 :=__common__( map(trim(C_HVAL_1001K_P) = ''                => -0.0048149653,
               ((real)c_hval_1001k_p < 0.0500000007451) => -7.2479677e-006,
                                                           -0.0048149653));

N1481_8 :=__common__( if(((real)c_young < 14.1499996185), -0.0044956691, N1481_9));

N1481_7 :=__common__( if(trim(C_YOUNG) != '', N1481_8, 0.0022926955));

N1481_6 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => N1481_7,
               ((real)f_prevaddrmedianincome_d < 12937.5) => 0.003264513,
                                                             N1481_7));

N1481_5 :=__common__( map(trim(C_MED_RENT) = ''      => 0.0067338071,
               ((real)c_med_rent < 696.5) => -0.003915103,
                                             0.0067338071));

N1481_4 :=__common__( if(((real)c_med_rent < 485.5), 0.0089296819, N1481_5));

N1481_3 :=__common__( if(trim(C_MED_RENT) != '', N1481_4, 0.0090424988));

N1481_2 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 32.5), N1481_3, N1481_6));

N1481_1 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N1481_2, 0.00034036136));

N1482_8 :=__common__( if(((real)c_dist_best_to_prev_addr_i < 3.5), -0.0018621258, 0.004736039));

N1482_7 :=__common__( if(((real)c_dist_best_to_prev_addr_i > NULL), N1482_8, 0.043106675));

N1482_6 :=__common__( map(trim(C_HEALTH) = ''              => 0.0089202092,
               ((real)c_health < 22.0499992371) => N1482_7,
                                                   0.0089202092));

N1482_5 :=__common__( map(trim(C_INC_100K_P) = ''      => -0.0011594406,
               ((real)c_inc_100k_p < 11.75) => N1482_6,
                                               -0.0011594406));

N1482_4 :=__common__( map(trim(C_POP_45_54_P) = ''              => -7.723181e-005,
               ((real)c_pop_45_54_p < 10.8500003815) => N1482_5,
                                                        -7.723181e-005));

N1482_3 :=__common__( map(trim(C_FEMDIV_P) = ''               => N1482_4,
               ((real)c_femdiv_p < 0.850000023842) => -0.0054419086,
                                                      N1482_4));

N1482_2 :=__common__( if(((real)c_fammar_p < 12.6499996185), -0.0056827349, N1482_3));

N1482_1 :=__common__( if(trim(C_FAMMAR_P) != '', N1482_2, 0.00097981661));

N1483_9 :=__common__( if(((real)c_pop_85p_p < 1.45000004768), -0.0029595866, 0.0017746696));

N1483_8 :=__common__( if(trim(C_POP_85P_P) != '', N1483_9, -0.0024372757));

N1483_7 :=__common__( map(trim(C_INC_25K_P) = ''              => 0.0020880748,
               ((real)c_inc_25k_p < 19.6500015259) => 0.010710012,
                                                      0.0020880748));

N1483_6 :=__common__( map(trim(C_INC_150K_P) = ''              => 0.00011892964,
               ((real)c_inc_150k_p < 1.95000004768) => N1483_7,
                                                       0.00011892964));

N1483_5 :=__common__( map(((real)f_prevaddrlenofres_d <= NULL) => N1483_6,
               ((real)f_prevaddrlenofres_d < 8.5)   => -0.0041377954,
                                                       N1483_6));

N1483_4 :=__common__( if(((real)c_med_age < 29.0499992371), N1483_5, 0.00020840478));

N1483_3 :=__common__( if(trim(C_MED_AGE) != '', N1483_4, -0.00090535128));

N1483_2 :=__common__( if(((real)f_addrchangeecontrajindex_d < 1.5), N1483_3, N1483_8));

N1483_1 :=__common__( if(((real)f_addrchangeecontrajindex_d > NULL), N1483_2, -0.0013582564));

N1484_8 :=__common__( map((fp_segment in ['3 New DID', '4 Bureau Only'])                                         => -0.022091931,
               (fp_segment in ['1 SSN Prob', '2 NAS 479', '5 Derog', '6 Recent Activity', '7 Other']) => 0.0047484719,
                                                                                                         0.0047484719));

N1484_7 :=__common__( map(trim(C_BURGLARY) = ''      => -0.012033964,
               ((real)c_burglary < 145.5) => -0.003224037,
                                             -0.012033964));

N1484_6 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.0036884843,
               ((real)r_c14_addrs_10yr_i < 11.5)  => N1484_7,
                                                     0.0036884843));

N1484_5 :=__common__( map(trim(C_NO_CAR) = ''      => N1484_8,
               ((real)c_no_car < 163.5) => N1484_6,
                                           N1484_8));

N1484_4 :=__common__( if(((real)c_hval_200k_p < 9.85000038147), 0.0013678756, N1484_5));

N1484_3 :=__common__( if(trim(C_HVAL_200K_P) != '', N1484_4, 0.0013685675));

N1484_2 :=__common__( if(((real)f_curraddrcrimeindex_i < 197.5), N1484_3, -0.0057643008));

N1484_1 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N1484_2, 0.0028575636));

N1485_8 :=__common__( map(trim(C_UNATTACH) = ''      => 0.0082768354,
               ((real)c_unattach < 128.5) => -0.0014605225,
                                             0.0082768354));

N1485_7 :=__common__( map(trim(C_MED_AGE) = ''              => N1485_8,
               ((real)c_med_age < 35.9500007629) => -0.0050339093,
                                                    N1485_8));

N1485_6 :=__common__( map(trim(C_RETAIL) = ''              => N1485_7,
               ((real)c_retail < 23.8499984741) => 0.00020948021,
                                                   N1485_7));

N1485_5 :=__common__( if(((integer)f_estimated_income_d < 29500), 0.0016723115, 0.011879935));

N1485_4 :=__common__( if(((real)f_estimated_income_d > NULL), N1485_5, 0.0015483502));

N1485_3 :=__common__( map(trim(C_FEMDIV_P) = ''              => -0.00083940942,
               ((real)c_femdiv_p < 4.94999980927) => N1485_4,
                                                     -0.00083940942));

N1485_2 :=__common__( if(((real)c_med_hhinc < 19701.5), N1485_3, N1485_6));

N1485_1 :=__common__( if(trim(C_MED_HHINC) != '', N1485_2, 0.0019455748));

N1486_8 :=__common__( map(trim(C_LOW_ED) = ''              => 0.010107944,
               ((real)c_low_ed < 62.5499992371) => 0.0006557557,
                                                   0.010107944));

N1486_7 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.0036329457,
               ((real)f_inq_other_count24_i < 0.5)   => -5.7190296e-005,
                                                        0.0036329457));

N1486_6 :=__common__( map(trim(C_BLUE_EMPL) = ''      => -0.0061013024,
               ((real)c_blue_empl < 183.5) => N1486_7,
                                              -0.0061013024));

N1486_5 :=__common__( map(((real)c_addr_lres_2mo_ct_i <= NULL) => -0.0013372001,
               ((real)c_addr_lres_2mo_ct_i < 1.5)   => N1486_6,
                                                       -0.0013372001));

N1486_4 :=__common__( if(((real)f_prevaddrlenofres_d < 1.5), -0.003727974, N1486_5));

N1486_3 :=__common__( if(((real)f_prevaddrlenofres_d > NULL), N1486_4, 0.0033762626));

N1486_2 :=__common__( if(((real)c_serv_empl < 192.5), N1486_3, N1486_8));

N1486_1 :=__common__( if(trim(C_SERV_EMPL) != '', N1486_2, 0.0032132174));

N1487_8 :=__common__( if(((real)r_c14_addr_stability_v2_d > NULL), 0.00090538695, 0.031200823));

N1487_7 :=__common__( map((fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '4 Bureau Only', '5 Derog', '7 Other']) => 0.0052181963,
               (fp_segment in ['6 Recent Activity'])                                                           => 0.024367058,
                                                                                                                  0.0052181963));

N1487_6 :=__common__( map(trim(C_REST_INDX) = ''      => -0.0033964117,
               ((real)c_rest_indx < 109.5) => N1487_7,
                                              -0.0033964117));

N1487_5 :=__common__( if(((real)f_mos_liens_rel_cj_lseen_d < 76.5), 0.0062075244, -0.002206761));

N1487_4 :=__common__( if(((real)f_mos_liens_rel_cj_lseen_d > NULL), N1487_5, -0.013696749));

N1487_3 :=__common__( map(trim(C_RETIRED2) = ''      => N1487_6,
               ((real)c_retired2 < 138.5) => N1487_4,
                                             N1487_6));

N1487_2 :=__common__( if(((real)c_rental < 123.5), N1487_3, N1487_8));

N1487_1 :=__common__( if(trim(C_RENTAL) != '', N1487_2, -0.0038100583));

N1488_8 :=__common__( map(trim(C_RENTOCC_P) = ''              => 0.0034349655,
               ((real)c_rentocc_p < 28.6500015259) => -8.4029409e-006,
                                                      0.0034349655));

N1488_7 :=__common__( map(trim(C_PRESCHL) = ''      => 0.010229277,
               ((real)c_preschl < 158.5) => 0.0020175181,
                                            0.010229277));

N1488_6 :=__common__( map(((real)r_c18_invalid_addrs_per_adl_i <= NULL) => 0.00045852243,
               ((real)r_c18_invalid_addrs_per_adl_i < 0.5)   => N1488_7,
                                                                0.00045852243));

N1488_5 :=__common__( if(((real)r_i60_inq_count12_i < 2.5), N1488_6, -0.0023250692));

N1488_4 :=__common__( if(((real)r_i60_inq_count12_i > NULL), N1488_5, -0.014550011));

N1488_3 :=__common__( map(trim(C_UNEMP) = ''              => N1488_4,
               ((real)c_unemp < 6.44999980927) => -0.0034019612,
                                                  N1488_4));

N1488_2 :=__common__( if(((real)c_ownocc_p < 51.5499992371), N1488_3, N1488_8));

N1488_1 :=__common__( if(trim(C_OWNOCC_P) != '', N1488_2, -0.00251669));

N1489_7 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => -0.0020249147,
               ((real)f_rel_felony_count_i < 0.5)   => 0.0077837501,
                                                       -0.0020249147));

N1489_6 :=__common__( map(trim(C_RAPE) = ''      => N1489_7,
               ((real)c_rape < 121.5) => -0.0048072492,
                                         N1489_7));

N1489_5 :=__common__( map(trim(C_OLD_HOMES) = ''      => -0.01163737,
               ((real)c_old_homes < 133.5) => N1489_6,
                                              -0.01163737));

N1489_4 :=__common__( map(trim(C_TOTCRIME) = ''      => 0.00021988636,
               ((integer)c_totcrime < 24) => 0.0073704655,
                                             0.00021988636));

N1489_3 :=__common__( map(trim(C_MANY_CARS) = ''      => N1489_5,
               ((real)c_many_cars < 135.5) => N1489_4,
                                              N1489_5));

N1489_2 :=__common__( if(((real)c_professional < 19.8499984741), N1489_3, -0.0051191719));

N1489_1 :=__common__( if(trim(C_PROFESSIONAL) != '', N1489_2, 0.0020985846));

N1490_9 :=__common__( map(trim(C_INC_200K_P) = ''     => 0.0025356511,
               ((real)c_inc_200k_p < 1.25) => 0.012434773,
                                              0.0025356511));

N1490_8 :=__common__( if(((real)f_mos_liens_unrel_lt_fseen_d < 171.5), N1490_9, 0.001490541));

N1490_7 :=__common__( if(((real)f_mos_liens_unrel_lt_fseen_d > NULL), N1490_8, 0.0050709494));

N1490_6 :=__common__( map(trim(C_POP_85P_P) = ''              => -0.0068299842,
               ((real)c_pop_85p_p < 5.05000019073) => 0.00017402583,
                                                      -0.0068299842));

N1490_5 :=__common__( if(((real)f_srchfraudsrchcount_i < 37.5), N1490_6, -0.0089379996));

N1490_4 :=__common__( if(((real)f_srchfraudsrchcount_i > NULL), N1490_5, -0.032675542));

N1490_3 :=__common__( map(trim(C_FOR_SALE) = ''      => N1490_7,
               ((real)c_for_sale < 109.5) => N1490_4,
                                             N1490_7));

N1490_2 :=__common__( if(((real)c_inc_75k_p < 21.9500007629), N1490_3, -0.0019490281));

N1490_1 :=__common__( if(trim(C_INC_75K_P) != '', N1490_2, -0.00050068351));

N1491_6 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => -0.0038292726,
               ((real)r_c13_avg_lres_d < 58.5)  => -0.012927615,
                                                   -0.0038292726));

N1491_5 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => N1491_6,
               ((real)r_c13_max_lres_d < 52.5)  => 0.0020289095,
                                                   N1491_6));

N1491_4 :=__common__( if(((integer)f_liens_unrel_sc_total_amt_i < 199), N1491_5, 0.0052309354));

N1491_3 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i > NULL), N1491_4, 0.0012396439));

N1491_2 :=__common__( map(((real)c_addr_lres_6mo_ct_i <= NULL) => -0.006494251,
               ((real)c_addr_lres_6mo_ct_i < 12.5)  => 0.00070383894,
                                                       -0.006494251));

N1491_1 :=__common__( if(((real)f_prevaddrstatus_i > NULL), N1491_2, N1491_3));

N1492_9 :=__common__( map(trim(C_HVAL_80K_P) = ''      => -0.004749796,
               ((real)c_hval_80k_p < 14.75) => 0.0065055482,
                                               -0.004749796));

N1492_8 :=__common__( map(trim(C_MED_HVAL) = ''          => -0.0065043149,
               ((integer)c_med_hval < 158738) => N1492_9,
                                                 -0.0065043149));

N1492_7 :=__common__( if(((real)c_no_teens < 38.5), -0.009125737, N1492_8));

N1492_6 :=__common__( if(trim(C_NO_TEENS) != '', N1492_7, -0.01437675));

N1492_5 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => 0.0019630393,
               ((real)r_c13_avg_lres_d < 30.5)  => N1492_6,
                                                   0.0019630393));

N1492_4 :=__common__( if(((real)c_unattach < 150.5), -0.00066425508, -0.0052851598));

N1492_3 :=__common__( if(trim(C_UNATTACH) != '', N1492_4, -0.0069487032));

N1492_2 :=__common__( if(((real)f_assocrisktype_i < 5.5), N1492_3, N1492_5));

N1492_1 :=__common__( if(((real)f_assocrisktype_i > NULL), N1492_2, -0.00036998508));

N1493_10 :=__common__( map(trim(C_HH7P_P) = ''     => 0.01166303,
                ((real)c_hh7p_p < 0.25) => 0.0012890747,
                                           0.01166303));

N1493_9 :=__common__( if(((real)c_unattach < 96.5), -0.0029125639, N1493_10));

N1493_8 :=__common__( if(trim(C_UNATTACH) != '', N1493_9, 0.01950584));

N1493_7 :=__common__( if(((real)r_c13_avg_lres_d < 66.5), N1493_8, -0.0030561928));

N1493_6 :=__common__( if(((real)r_c13_avg_lres_d > NULL), N1493_7, -0.0045365787));

N1493_5 :=__common__( map(trim(C_INCOLLEGE) = ''              => 0.0019427166,
               ((real)c_incollege < 1.34999990463) => -0.0031259381,
                                                      0.0019427166));

N1493_4 :=__common__( if(((real)c_inc_35k_p < 7.75), -0.0016803239, N1493_5));

N1493_3 :=__common__( if(trim(C_INC_35K_P) != '', N1493_4, -0.0015887681));

N1493_2 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.00924000982195), -0.0037193347, N1493_3));

N1493_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1493_2, N1493_6));

N1494_8 :=__common__( map(((real)f_prevaddrageoldest_d <= NULL) => -0.0098813852,
               ((real)f_prevaddrageoldest_d < 82.5)  => 0.00011185274,
                                                        -0.0098813852));

N1494_7 :=__common__( map(trim(C_HVAL_400K_P) = ''              => 0.0074402938,
               ((real)c_hval_400k_p < 17.6500015259) => N1494_8,
                                                        0.0074402938));

N1494_6 :=__common__( if(((real)c_addr_lres_12mo_ct_i < 2.5), 0.0076825971, N1494_7));

N1494_5 :=__common__( if(((real)c_addr_lres_12mo_ct_i > NULL), N1494_6, -0.009626228));

N1494_4 :=__common__( map(trim(C_INC_75K_P) = ''              => N1494_5,
               ((real)c_inc_75k_p < 15.1499996185) => 0.0078788017,
                                                      N1494_5));

N1494_3 :=__common__( map(trim(C_LUX_PROD) = ''      => -0.0076037969,
               ((real)c_lux_prod < 154.5) => -4.3734942e-005,
                                             -0.0076037969));

N1494_2 :=__common__( if(((real)c_white_col < 40.1500015259), N1494_3, N1494_4));

N1494_1 :=__common__( if(trim(C_WHITE_COL) != '', N1494_2, -0.0029067794));

N1495_8 :=__common__( map(trim(C_HVAL_250K_P) = ''              => -0.0010220205,
               ((real)c_hval_250k_p < 7.55000019073) => 0.0097441323,
                                                        -0.0010220205));

N1495_7 :=__common__( map(trim(C_HVAL_40K_P) = ''              => 0.0015249411,
               ((real)c_hval_40k_p < 3.84999990463) => -0.0069360579,
                                                       0.0015249411));

N1495_6 :=__common__( map(trim(C_RAPE) = ''      => 0.0004624372,
               ((real)c_rape < 146.5) => 0.0068088575,
                                         0.0004624372));

N1495_5 :=__common__( if(((real)f_curraddrmurderindex_i < 180.5), -0.0004305835, N1495_6));

N1495_4 :=__common__( if(((real)f_curraddrmurderindex_i > NULL), N1495_5, 0.0030424145));

N1495_3 :=__common__( map(trim(C_HH7P_P) = ''              => N1495_7,
               ((real)c_hh7p_p < 6.85000038147) => N1495_4,
                                                   N1495_7));

N1495_2 :=__common__( if(((real)c_employees < 3498.5), N1495_3, N1495_8));

N1495_1 :=__common__( if(trim(C_EMPLOYEES) != '', N1495_2, -0.0014074436));

N1496_10 :=__common__( if(((real)f_corrphonelastnamecount_d < 0.5), -0.0010717017, 0.0013408753));

N1496_9 :=__common__( if(((real)f_corrphonelastnamecount_d > NULL), N1496_10, 0.0074291965));

N1496_8 :=__common__( map(trim(C_INC_200K_P) = ''               => -0.0061367429,
               ((real)c_inc_200k_p < 0.550000011921) => 0.0017365903,
                                                        -0.0061367429));

N1496_7 :=__common__( map(trim(C_RNT750_P) = ''              => N1496_8,
               ((real)c_rnt750_p < 13.5500001907) => 0.0049403191,
                                                     N1496_8));

N1496_6 :=__common__( if(((real)f_rel_incomeover75_count_d < 1.5), N1496_7, 0.0069663382));

N1496_5 :=__common__( if(((real)f_rel_incomeover75_count_d > NULL), N1496_6, 0.0014188277));

N1496_4 :=__common__( if(((real)f_current_count_d < 3.5), N1496_5, 0.011005059));

N1496_3 :=__common__( if(((real)f_current_count_d > NULL), N1496_4, -0.0051364556));

N1496_2 :=__common__( if(((real)c_pop_6_11_p < 5.85000038147), N1496_3, N1496_9));

N1496_1 :=__common__( if(trim(C_POP_6_11_P) != '', N1496_2, 0.0024068178));

N1497_10 :=__common__( if(((integer)r_i60_inq_banking_recency_d < 549), 0.00085730143, 0.012845652));

N1497_9 :=__common__( if(((real)r_i60_inq_banking_recency_d > NULL), N1497_10, 0.026126923));

N1497_8 :=__common__( map(trim(C_INC_35K_P) = ''              => N1497_9,
               ((real)c_inc_35k_p < 6.64999961853) => -0.00069995971,
                                                      N1497_9));

N1497_7 :=__common__( if(((real)f_rel_under500miles_cnt_d < 22.5), -0.00069662274, 0.0083630634));

N1497_6 :=__common__( if(((real)f_rel_under500miles_cnt_d > NULL), N1497_7, -0.016994098));

N1497_5 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => 0.0038916457,
               ((real)r_l79_adls_per_addr_curr_i < 36.5)  => -0.005682304,
                                                             0.0038916457));

N1497_4 :=__common__( map(((real)f_estimated_income_d <= NULL)    => N1497_6,
               ((integer)f_estimated_income_d < 30500) => N1497_5,
                                                          N1497_6));

N1497_3 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N1497_4, -0.0010131694));

N1497_2 :=__common__( if(((real)c_inc_125k_p < 12.1499996185), N1497_3, N1497_8));

N1497_1 :=__common__( if(trim(C_INC_125K_P) != '', N1497_2, -0.0048378851));

N1498_9 :=__common__( map(trim(C_PROFESSIONAL) = ''              => 0.003409995,
               ((real)c_professional < 8.85000038147) => -0.00095072449,
                                                         0.003409995));

N1498_8 :=__common__( map(trim(C_UNEMPL) = ''      => -0.0011201045,
               ((real)c_unempl < 138.5) => 0.0038043332,
                                           -0.0011201045));

N1498_7 :=__common__( map(trim(C_HEALTH) = ''              => 0.0091776424,
               ((real)c_health < 37.0499992371) => N1498_8,
                                                   0.0091776424));

N1498_6 :=__common__( if(((real)c_femdiv_p < 3.34999990463), N1498_7, N1498_9));

N1498_5 :=__common__( if(trim(C_FEMDIV_P) != '', N1498_6, 0.0022262145));

N1498_4 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.215262025595), N1498_5, -0.0048666723));

N1498_3 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1498_4, 0.003839054));

N1498_2 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.507460951805), N1498_3, -0.0038241587));

N1498_1 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1498_2, -0.00043618699));

N1499_9 :=__common__( map(((real)f_mos_liens_unrel_cj_lseen_d <= NULL) => -0.0081288482,
               ((real)f_mos_liens_unrel_cj_lseen_d < 50.5)  => -0.00025145351,
                                                               -0.0081288482));

N1499_8 :=__common__( map(trim(C_FAMMAR18_P) = ''      => 0.0035872888,
               ((real)c_fammar18_p < 32.25) => N1499_9,
                                               0.0035872888));

N1499_7 :=__common__( map(((real)r_d34_unrel_lien60_count_i <= NULL) => N1499_8,
               ((real)r_d34_unrel_lien60_count_i < 0.5)   => 0.0023933881,
                                                             N1499_8));

N1499_6 :=__common__( if(trim(C_INC_125K_P) != '', N1499_7, 0.0050795858));

N1499_5 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => N1499_6,
               ((real)r_c10_m_hdr_fs_d < 38.5)  => -0.0045699672,
                                                   N1499_6));

N1499_4 :=__common__( if(((real)c_hh5_p < 3.25), -0.0038825347, 0.00022142185));

N1499_3 :=__common__( if(trim(C_HH5_P) != '', N1499_4, 0.0063707131));

N1499_2 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 66.5), N1499_3, N1499_5));

N1499_1 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N1499_2, 0.010730683));

N1500_9 :=__common__( map(trim(C_OWNOCC_P) = ''              => 0.0013286352,
               ((real)c_ownocc_p < 45.3499984741) => -0.0013279068,
                                                     0.0013286352));

N1500_8 :=__common__( map(((real)f_srchunvrfddobcount_i <= NULL) => 0.0051958048,
               ((real)f_srchunvrfddobcount_i < 0.5)   => -0.0028004438,
                                                         0.0051958048));

N1500_7 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i < -4804.5), 0.00043757823, -0.0081944181));

N1500_6 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N1500_7, N1500_8));

N1500_5 :=__common__( map(trim(C_FOOD) = ''              => -0.0031465274,
               ((real)c_food < 14.2000007629) => 0.011137026,
                                                 -0.0031465274));

N1500_4 :=__common__( if(((real)f_sourcerisktype_i < 3.5), N1500_5, N1500_6));

N1500_3 :=__common__( if(((real)f_sourcerisktype_i > NULL), N1500_4, 0.0045638864));

N1500_2 :=__common__( if(((real)c_easiqlife < 83.5), N1500_3, N1500_9));

N1500_1 :=__common__( if(trim(C_EASIQLIFE) != '', N1500_2, -0.0014284252));

N1501_7 :=__common__( map(trim(C_MORT_INDX) = ''     => 0.00091958966,
               ((real)c_mort_indx < 45.5) => -0.003739726,
                                             0.00091958966));

N1501_6 :=__common__( map(trim(C_MIL_EMP) = ''              => 0.0067124007,
               ((real)c_mil_emp < 3.34999990463) => N1501_7,
                                                    0.0067124007));

N1501_5 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)          => N1501_6,
               ((real)f_add_input_nhood_sfd_pct_d < 0.207645446062) => -0.0059755566,
                                                                       N1501_6));

N1501_4 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), 0.0021057157, -0.0057779877));

N1501_3 :=__common__( map(trim(C_UNEMPL) = ''      => N1501_4,
               ((real)c_unempl < 149.5) => -0.0061205549,
                                           N1501_4));

N1501_2 :=__common__( if(((real)c_many_cars < 30.5), N1501_3, N1501_5));

N1501_1 :=__common__( if(trim(C_MANY_CARS) != '', N1501_2, -1.0896566e-005));

N1502_9 :=__common__( map(trim(C_NO_TEENS) = ''      => 0.0054118375,
               ((real)c_no_teens < 139.5) => 0.00084010338,
                                             0.0054118375));

N1502_8 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => 0.005275491,
               ((real)f_add_input_nhood_vac_pct_i < 0.211885422468) => -0.0033755911,
                                                                       0.005275491));

N1502_7 :=__common__( if(((real)c_exp_prod < 30.5), N1502_8, N1502_9));

N1502_6 :=__common__( if(trim(C_EXP_PROD) != '', N1502_7, 0.009232793));

N1502_5 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => N1502_6,
               ((real)f_mos_inq_banko_cm_fseen_d < 27.5)  => -0.0057966019,
                                                             N1502_6));

N1502_4 :=__common__( if(((real)c_pop_65_74_p < 8.55000019073), -0.00078949181, -0.0061358977));

N1502_3 :=__common__( if(trim(C_POP_65_74_P) != '', N1502_4, -0.0020951546));

N1502_2 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i < 116.5), N1502_3, N1502_5));

N1502_1 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i > NULL), N1502_2, 0.0047256265));

N1503_9 :=__common__( map(trim(C_LARCENY) = ''      => -0.0069770305,
               ((real)c_larceny < 193.5) => -0.00065590147,
                                            -0.0069770305));

N1503_8 :=__common__( map(trim(C_RETIRED2) = ''     => -0.0059330749,
               ((real)c_retired2 < 74.5) => 0.0037386326,
                                            -0.0059330749));

N1503_7 :=__common__( if(((real)f_rel_ageover40_count_d < 2.5), 0.0085886557, 0.0010830228));

N1503_6 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N1503_7, 0.0018403828));

N1503_5 :=__common__( map(trim(C_HIGHINC) = ''              => -0.001130644,
               ((real)c_highinc < 6.85000038147) => N1503_6,
                                                    -0.001130644));

N1503_4 :=__common__( if(((real)r_d30_derog_count_i < 4.5), N1503_5, N1503_8));

N1503_3 :=__common__( if(((real)r_d30_derog_count_i > NULL), N1503_4, 0.016881952));

N1503_2 :=__common__( if(((real)c_pop_35_44_p < 9.64999961853), N1503_3, N1503_9));

N1503_1 :=__common__( if(trim(C_POP_35_44_P) != '', N1503_2, -0.003630411));

N1504_8 :=__common__( map(trim(C_POP_45_54_P) = ''              => -0.0020137251,
               ((real)c_pop_45_54_p < 11.0500001907) => 0.0058511821,
                                                        -0.0020137251));

N1504_7 :=__common__( map(trim(C_HVAL_20K_P) = ''              => -0.0059085303,
               ((real)c_hval_20k_p < 11.0500001907) => N1504_8,
                                                       -0.0059085303));

N1504_6 :=__common__( map(trim(C_POP_85P_P) = ''              => -0.0099474371,
               ((real)c_pop_85p_p < 3.45000004768) => N1504_7,
                                                      -0.0099474371));

N1504_5 :=__common__( map(trim(C_RNT1000_P) = ''              => 0.0055894178,
               ((real)c_rnt1000_p < 16.6500015259) => N1504_6,
                                                      0.0055894178));

N1504_4 :=__common__( map(trim(C_HVAL_40K_P) = ''     => N1504_5,
               ((real)c_hval_40k_p < 9.75) => 0.00067306836,
                                              N1504_5));

N1504_3 :=__common__( map(((real)f_liens_unrel_ot_total_amt_i <= NULL)  => -0.0072629332,
               ((real)f_liens_unrel_ot_total_amt_i < 2100.5) => N1504_4,
                                                                -0.0072629332));

N1504_2 :=__common__( if(trim(C_HVAL_40K_P) != '', N1504_3, 0.0050978999));

N1504_1 :=__common__( if(((real)f_liens_unrel_ot_total_amt_i > NULL), N1504_2, -0.0084414066));

N1505_9 :=__common__( map(trim(C_HVAL_125K_P) = ''              => 0.0094572469,
               ((real)c_hval_125k_p < 8.44999980927) => -0.0017196533,
                                                        0.0094572469));

N1505_8 :=__common__( map(trim(C_HVAL_100K_P) = ''      => -0.0098205818,
               ((real)c_hval_100k_p < 18.75) => -0.0014501288,
                                                -0.0098205818));

N1505_7 :=__common__( if(((real)c_pop_25_34_p < 15.9499998093), N1505_8, N1505_9));

N1505_6 :=__common__( if(trim(C_POP_25_34_P) != '', N1505_7, -0.0098164305));

N1505_5 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => N1505_6,
               ((real)f_curraddrcartheftindex_i < 137.5) => -0.011124829,
                                                            N1505_6));

N1505_4 :=__common__( if(((real)c_families < 143.5), -0.0052167736, 0.00066210014));

N1505_3 :=__common__( if(trim(C_FAMILIES) != '', N1505_4, 0.0017748485));

N1505_2 :=__common__( if(((real)f_curraddrburglaryindex_i < 181.5), N1505_3, N1505_5));

N1505_1 :=__common__( if(((real)f_curraddrburglaryindex_i > NULL), N1505_2, -0.001093389));

N1506_9 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => 0.00062750177,
               ((real)f_mos_liens_unrel_cj_fseen_d < 95.5)  => -0.0035698328,
                                                               0.00062750177));

N1506_8 :=__common__( map(trim(C_EXP_PROD) = ''      => -0.0048882166,
               ((real)c_exp_prod < 113.5) => N1506_9,
                                             -0.0048882166));

N1506_7 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => N1506_8,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0503803640604) => 0.00054409328,
                                                                       N1506_8));

N1506_6 :=__common__( if(trim(C_POP_18_24_P) != '', N1506_7, -0.0032122955));

N1506_5 :=__common__( map(((real)c_nap_addr_verd_d <= NULL) => 0.0025782078,
               ((real)c_nap_addr_verd_d < 0.5)   => 0.011562766,
                                                    0.0025782078));

N1506_4 :=__common__( if(((real)c_construction < 7.44999980927), N1506_5, -0.0030941744));

N1506_3 :=__common__( if(trim(C_CONSTRUCTION) != '', N1506_4, 0.0069673486));

N1506_2 :=__common__( if(((real)f_assocsuspicousidcount_i < 0.5), N1506_3, N1506_6));

N1506_1 :=__common__( if(((real)f_assocsuspicousidcount_i > NULL), N1506_2, -0.0012438792));

N1507_9 :=__common__( if(((real)f_historical_count_d < 1.5), -0.0026074065, 0.0068359538));

N1507_8 :=__common__( if(((real)f_historical_count_d > NULL), N1507_9, 0.027009058));

N1507_7 :=__common__( if(((real)c_child < 19.4500007629), N1507_8, -0.0011171226));

N1507_6 :=__common__( if(trim(C_CHILD) != '', N1507_7, -0.00033766193));

N1507_5 :=__common__( map(trim(C_HH2_P) = ''              => 0.0085711741,
               ((real)c_hh2_p < 45.3499984741) => 0.00025145644,
                                                  0.0085711741));

N1507_4 :=__common__( if(((real)r_c13_avg_lres_d < 80.5), N1507_5, 0.009499524));

N1507_3 :=__common__( if(((real)r_c13_avg_lres_d > NULL), N1507_4, 0.027026653));

N1507_2 :=__common__( if(trim(C_HH2_P) != '', N1507_3, -0.0063815713));

N1507_1 :=__common__( map(((real)c_comb_age_d <= NULL) => N1507_6,
               ((real)c_comb_age_d < 28.5)  => N1507_2,
                                               N1507_6));

N1508_9 :=__common__( if(((real)c_med_age < 32.4500007629), -0.0093834088, -4.7466438e-005));

N1508_8 :=__common__( if(trim(C_MED_AGE) != '', N1508_9, -0.015727962));

N1508_7 :=__common__( map(trim(C_LOW_ED) = ''              => 0.0027234853,
               ((real)c_low_ed < 62.6500015259) => -0.0069974618,
                                                   0.0027234853));

N1508_6 :=__common__( map(trim(C_LOWRENT) = ''              => 0.00050957401,
               ((real)c_lowrent < 19.5499992371) => N1508_7,
                                                    0.00050957401));

N1508_5 :=__common__( if(((real)c_newhouse < 2.45000004768), N1508_6, 0.00083388139));

N1508_4 :=__common__( if(trim(C_NEWHOUSE) != '', N1508_5, -0.001817897));

N1508_3 :=__common__( map(((real)f_mos_liens_unrel_lt_fseen_d <= NULL) => N1508_4,
               ((real)f_mos_liens_unrel_lt_fseen_d < 25.5)  => 0.0071138475,
                                                               N1508_4));

N1508_2 :=__common__( if(((real)r_f00_dob_score_d > NULL), N1508_3, N1508_8));

N1508_1 :=__common__( if(((real)r_f00_input_dob_match_level_d > NULL), N1508_2, 0.00053104355));

N1509_11 :=__common__( if(((real)c_hh5_p < 20.1500015259), 5.4688655e-006, -0.0081869039));

N1509_10 :=__common__( if(trim(C_HH5_P) != '', N1509_11, 0.0070183455));

N1509_9 :=__common__( if(((real)f_rel_ageover40_count_d < 1.5), -0.0019820322, 0.0067316002));

N1509_8 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N1509_9, 0.0070297439));

N1509_7 :=__common__( if(((real)c_inc_15k_p < 14.3500003815), 0.012269667, N1509_8));

N1509_6 :=__common__( if(trim(C_INC_15K_P) != '', N1509_7, 0.0058010849));

N1509_5 :=__common__( if(((real)c_civ_emp < 59.1500015259), 0.0034405681, -0.0075632396));

N1509_4 :=__common__( if(trim(C_CIV_EMP) != '', N1509_5, -0.0017457812));

N1509_3 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL)  => N1509_6,
               ((integer)f_curraddrcartheftindex_i < 105) => N1509_4,
                                                             N1509_6));

N1509_2 :=__common__( if(((real)f_prevaddrmedianvalue_d < 56846.5), N1509_3, N1509_10));

N1509_1 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N1509_2, 0.0015857442));

N1510_8 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => 0.01003566,
               ((real)f_srchaddrsrchcount_i < 13.5)  => 0.0016338812,
                                                        0.01003566));

N1510_7 :=__common__( map(trim(C_RNT1250_P) = ''              => N1510_8,
               ((real)c_rnt1250_p < 4.94999980927) => -0.0003302288,
                                                      N1510_8));

N1510_6 :=__common__( map(trim(C_POP_35_44_P) = ''              => N1510_7,
               ((real)c_pop_35_44_p < 14.0500001907) => -0.0013969446,
                                                        N1510_7));

N1510_5 :=__common__( map(trim(C_WHITE_COL) = ''      => -0.0077113618,
               ((real)c_white_col < 51.75) => N1510_6,
                                              -0.0077113618));

N1510_4 :=__common__( if(((real)r_d32_felony_count_i < 2.5), N1510_5, 0.0046098344));

N1510_3 :=__common__( if(((real)r_d32_felony_count_i > NULL), N1510_4, -0.0049505209));

N1510_2 :=__common__( if(((real)c_professional < 25.0499992371), N1510_3, 0.0067193556));

N1510_1 :=__common__( if(trim(C_PROFESSIONAL) != '', N1510_2, 0.001570042));

N1511_9 :=__common__( map(trim(C_INC_75K_P) = ''              => 0.0065903438,
               ((real)c_inc_75k_p < 12.9499998093) => -0.0024134494,
                                                      0.0065903438));

N1511_8 :=__common__( map(trim(C_POP_25_34_P) = ''              => -0.013724557,
               ((real)c_pop_25_34_p < 15.4499998093) => -0.0026902133,
                                                        -0.013724557));

N1511_7 :=__common__( map(trim(C_RNT1000_P) = ''              => 0.0022435975,
               ((real)c_rnt1000_p < 24.5499992371) => N1511_8,
                                                      0.0022435975));

N1511_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.094731926918), 0.0052446543, -0.0034395953));

N1511_5 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1511_6, 0.001520876));

N1511_4 :=__common__( if(((real)c_child < 28.8499984741), N1511_5, N1511_7));

N1511_3 :=__common__( if(trim(C_CHILD) != '', N1511_4, -0.0093954464));

N1511_2 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => N1511_9,
               ((real)r_l79_adls_per_addr_curr_i < 25.5)  => N1511_3,
                                                             N1511_9));

N1511_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N1511_2, 1.5973886e-005));

N1512_8 :=__common__( map((fp_segment in ['2 NAS 479', '3 New DID', '4 Bureau Only', '5 Derog', '7 Other']) => -0.006795047,
               (fp_segment in ['1 SSN Prob', '6 Recent Activity'])                               => 0.011492737,
                                                                                                    -0.006795047));

N1512_7 :=__common__( map(trim(C_LOW_ED) = ''              => 0.0035597271,
               ((real)c_low_ed < 70.4499969482) => N1512_8,
                                                   0.0035597271));

N1512_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.118302896619), N1512_7, 0.0061369209));

N1512_5 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1512_6, -0.0007280994));

N1512_4 :=__common__( map(trim(C_POP_75_84_P) = ''     => 0.0069739621,
               ((real)c_pop_75_84_p < 6.75) => N1512_5,
                                               0.0069739621));

N1512_3 :=__common__( map(trim(C_HVAL_125K_P) = ''              => 0.0096807061,
               ((real)c_hval_125k_p < 26.1000003815) => N1512_4,
                                                        0.0096807061));

N1512_2 :=__common__( if(((real)c_families < 192.5), N1512_3, -0.00029539633));

N1512_1 :=__common__( if(trim(C_FAMILIES) != '', N1512_2, 0.00097929544));

N1513_9 :=__common__( map(trim(C_INC_75K_P) = ''              => 0.0011670901,
               ((real)c_inc_75k_p < 17.6500015259) => -0.0092638448,
                                                      0.0011670901));

N1513_8 :=__common__( if(((real)r_c10_m_hdr_fs_d < 203.5), 0.011166869, 0.00085926154));

N1513_7 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N1513_8, 0.009832961));

N1513_6 :=__common__( map(trim(C_BUSINESS) = ''    => -0.0058030119,
               ((real)c_business < 5.5) => 0.0056871528,
                                           -0.0058030119));

N1513_5 :=__common__( map(trim(C_HEALTH) = ''              => N1513_7,
               ((real)c_health < 8.05000019073) => N1513_6,
                                                   N1513_7));

N1513_4 :=__common__( if(((real)c_hval_80k_p < 13.5500001907), N1513_5, N1513_9));

N1513_3 :=__common__( if(trim(C_HVAL_80K_P) != '', N1513_4, -0.0035712989));

N1513_2 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.0015305139,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0815262645483) => -0.00075741753,
                                                                       0.0015305139));

N1513_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1513_2, N1513_3));

N1514_7 :=__common__( map(trim(C_INCOLLEGE) = ''              => 0.0026495461,
               ((real)c_incollege < 8.55000019073) => -0.0097800583,
                                                      0.0026495461));

N1514_6 :=__common__( map(trim(C_OCCUNIT_P) = ''              => -0.0098919471,
               ((real)c_occunit_p < 83.1499938965) => 0.0028801995,
                                                      -0.0098919471));

N1514_5 :=__common__( map(trim(C_HH1_P) = ''              => N1514_6,
               ((real)c_hh1_p < 36.9500007629) => -0.00091089191,
                                                  N1514_6));

N1514_4 :=__common__( map(trim(C_NO_LABFOR) = ''      => 0.0056217798,
               ((real)c_no_labfor < 176.5) => N1514_5,
                                              0.0056217798));

N1514_3 :=__common__( map(trim(C_POP_35_44_P) = ''              => 0.00062370659,
               ((real)c_pop_35_44_p < 10.0500001907) => N1514_4,
                                                        0.00062370659));

N1514_2 :=__common__( if(((real)c_civ_emp < 70.8500061035), N1514_3, N1514_7));

N1514_1 :=__common__( if(trim(C_CIV_EMP) != '', N1514_2, 0.00054950264));

N1515_8 :=__common__( map(trim(C_HVAL_80K_P) = ''              => -0.0039046603,
               ((real)c_hval_80k_p < 18.4500007629) => 0.0049290021,
                                                       -0.0039046603));

N1515_7 :=__common__( map(trim(C_POP_18_24_P) = ''              => -0.0011046282,
               ((real)c_pop_18_24_p < 4.44999980927) => N1515_8,
                                                        -0.0011046282));

N1515_6 :=__common__( map(((real)f_assocsuspicousidcount_i <= NULL) => 0.0090926613,
               ((real)f_assocsuspicousidcount_i < 4.5)   => -0.00013013135,
                                                            0.0090926613));

N1515_5 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => N1515_7,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.178790003061) => N1515_6,
                                                                      N1515_7));

N1515_4 :=__common__( if(((real)f_inq_banking_count24_i < 2.5), N1515_5, 0.0049461119));

N1515_3 :=__common__( if(((real)f_inq_banking_count24_i > NULL), N1515_4, -0.0015717124));

N1515_2 :=__common__( if(((real)c_hh7p_p < 10.0500001907), N1515_3, 0.0057596146));

N1515_1 :=__common__( if(trim(C_HH7P_P) != '', N1515_2, 0.0028022226));

N1516_8 :=__common__( map(trim(C_OLD_HOMES) = ''     => 0.0018844933,
               ((real)c_old_homes < 68.5) => 0.012504096,
                                             0.0018844933));

N1516_7 :=__common__( map(trim(C_WORK_HOME) = ''     => -0.003209167,
               ((real)c_work_home < 66.5) => 0.0015252058,
                                             -0.003209167));

N1516_6 :=__common__( map(trim(C_INC_201K_P) = ''              => 0.0070746901,
               ((real)c_inc_201k_p < 4.44999980927) => N1516_7,
                                                       0.0070746901));

N1516_5 :=__common__( if(((real)c_inc_75k_p < 24.1500015259), N1516_6, N1516_8));

N1516_4 :=__common__( if(trim(C_INC_75K_P) != '', N1516_5, -0.0021537712));

N1516_3 :=__common__( map(((real)c_addr_lres_6mo_ct_i <= NULL) => -0.00087338504,
               ((real)c_addr_lres_6mo_ct_i < 1.5)   => N1516_4,
                                                       -0.00087338504));

N1516_2 :=__common__( if(((real)r_c10_m_hdr_fs_d < 378.5), N1516_3, -0.0093826274));

N1516_1 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N1516_2, 0.0058457241));

N1517_9 :=__common__( if(((real)f_wealth_index_d < 2.5), -0.0018641266, 0.00047412453));

N1517_8 :=__common__( if(((real)f_wealth_index_d > NULL), N1517_9, -0.0029761879));

N1517_7 :=__common__( map(trim(C_INC_50K_P) = ''              => N1517_8,
               ((real)c_inc_50k_p < 4.64999961853) => 0.0067868549,
                                                      N1517_8));

N1517_6 :=__common__( map(trim(C_POPOVER18) = ''      => N1517_7,
               ((real)c_popover18 < 585.5) => -0.0051577644,
                                              N1517_7));

N1517_5 :=__common__( map(trim(C_POP_35_44_P) = ''              => 0.0051282216,
               ((real)c_pop_35_44_p < 22.6500015259) => N1517_6,
                                                        0.0051282216));

N1517_4 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d < 33.5), -0.0040226308, 0.0076559304));

N1517_3 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d > NULL), N1517_4, 0.00083175371));

N1517_2 :=__common__( if(((real)c_pop00 < 698.5), N1517_3, N1517_5));

N1517_1 :=__common__( if(trim(C_POP00) != '', N1517_2, -0.0011184677));

N1518_9 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)    => -0.012865776,
               ((real)f_curraddrmedianvalue_d < 103834.5) => 0.0026657326,
                                                             -0.012865776));

N1518_8 :=__common__( map(((real)r_i60_inq_banking_recency_d <= NULL) => -0.00013711429,
               ((real)r_i60_inq_banking_recency_d < 61.5)  => 0.0028651463,
                                                              -0.00013711429));

N1518_7 :=__common__( if(((real)c_transport < 19.1500015259), N1518_8, N1518_9));

N1518_6 :=__common__( if(trim(C_TRANSPORT) != '', N1518_7, 0.0023692202));

N1518_5 :=__common__( map(trim(C_INC_200K_P) = ''              => -0.0018136641,
               ((real)c_inc_200k_p < 1.65000009537) => -0.0091424331,
                                                       -0.0018136641));

N1518_4 :=__common__( if(((real)c_pop_45_54_p < 10.9499998093), 0.0023208127, N1518_5));

N1518_3 :=__common__( if(trim(C_POP_45_54_P) != '', N1518_4, -0.0069971108));

N1518_2 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 240.5), N1518_3, N1518_6));

N1518_1 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N1518_2, -0.0021200772));

N1519_10 :=__common__( if(((real)c_inc_35k_p < 23.5499992371), -0.00097360476, 0.0077203305));

N1519_9 :=__common__( if(trim(C_INC_35K_P) != '', N1519_10, 2.9002206e-005));

N1519_8 :=__common__( if(((real)c_femdiv_p < 3.95000004768), -0.0052644277, 0.0032846266));

N1519_7 :=__common__( if(trim(C_FEMDIV_P) != '', N1519_8, -0.0072757029));

N1519_6 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => -0.0069691852,
               ((real)f_inq_adls_per_phone_i < 0.5)   => N1519_7,
                                                         -0.0069691852));

N1519_5 :=__common__( if(((real)c_rnt500_p < 22.3499984741), 0.00094662737, 0.0048891381));

N1519_4 :=__common__( if(trim(C_RNT500_P) != '', N1519_5, 0.0056906802));

N1519_3 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL) => N1519_6,
               ((real)f_fp_prevaddrburglaryindex_i < 161.5) => N1519_4,
                                                               N1519_6));

N1519_2 :=__common__( if(((real)f_corrssnnamecount_d < 4.5), N1519_3, N1519_9));

N1519_1 :=__common__( if(((real)f_corrssnnamecount_d > NULL), N1519_2, -0.0044320421));

N1520_8 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => 0.0010903462,
               ((real)r_d32_mos_since_crim_ls_d < 240.5) => 0.010176799,
                                                            0.0010903462));

N1520_7 :=__common__( map(((real)r_c14_addrs_per_adl_c6_i <= NULL) => -0.002536803,
               ((real)r_c14_addrs_per_adl_c6_i < 0.5)   => N1520_8,
                                                           -0.002536803));

N1520_6 :=__common__( map(trim(C_TOTSALES) = ''        => -4.4791931e-005,
               ((integer)c_totsales < 2611) => -0.010959281,
                                               -4.4791931e-005));

N1520_5 :=__common__( map(((real)f_rel_count_i <= NULL) => N1520_6,
               ((real)f_rel_count_i < 40.5)  => -0.00026691422,
                                                N1520_6));

N1520_4 :=__common__( map(((real)f_mos_liens_unrel_lt_lseen_d <= NULL) => N1520_5,
               ((real)f_mos_liens_unrel_lt_lseen_d < 50.5)  => -0.0043980148,
                                                               N1520_5));

N1520_3 :=__common__( if(((real)c_pop_6_11_p < 12.9499998093), N1520_4, N1520_7));

N1520_2 :=__common__( if(trim(C_POP_6_11_P) != '', N1520_3, -0.0021781771));

N1520_1 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N1520_2, -0.0003386867));

N1521_9 :=__common__( map(trim(C_HVAL_250K_P) = ''              => 0.0081294585,
               ((real)c_hval_250k_p < 11.9499998093) => -0.0014166353,
                                                        0.0081294585));

N1521_8 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => -0.01011274,
               ((real)c_dist_best_to_prev_addr_i < 73.5)  => N1521_9,
                                                             -0.01011274));

N1521_7 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.38686260581), N1521_8, -0.0071573988));

N1521_6 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1521_7, -0.019361152));

N1521_5 :=__common__( map(trim(C_INC_25K_P) = ''              => 0.0058305978,
               ((real)c_inc_25k_p < 15.8500003815) => N1521_6,
                                                      0.0058305978));

N1521_4 :=__common__( if(((real)c_larceny < 158.5), N1521_5, -0.0078858847));

N1521_3 :=__common__( if(trim(C_LARCENY) != '', N1521_4, -0.0033503849));

N1521_2 :=__common__( if(((integer)f_curraddrburglaryindex_i < 72), N1521_3, 0.00068273972));

N1521_1 :=__common__( if(((real)f_curraddrburglaryindex_i > NULL), N1521_2, -0.0012565193));

N1522_10 :=__common__( if(((real)c_old_homes < 92.5), 0.0032590357, -0.000595869));

N1522_9 :=__common__( if(trim(C_OLD_HOMES) != '', N1522_10, -0.0011709175));

N1522_8 :=__common__( map(((real)f_rel_criminal_count_i <= NULL) => 0.010100606,
               ((real)f_rel_criminal_count_i < 4.5)   => -0.00012038512,
                                                         0.010100606));

N1522_7 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => N1522_8,
               ((real)f_srchfraudsrchcount_i < 11.5)  => 6.026375e-005,
                                                         N1522_8));

N1522_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0357036627829), N1522_7, -0.0018027522));

N1522_5 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1522_6, 0.0019476241));

N1522_4 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d < 0.990565001965), N1522_5, -0.0084161597));

N1522_3 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d > NULL), N1522_4, -0.042432129));

N1522_2 :=__common__( if(((real)c_dist_best_to_prev_addr_i < 7.5), N1522_3, N1522_9));

N1522_1 :=__common__( if(((real)c_dist_best_to_prev_addr_i > NULL), N1522_2, -0.0082651181));

N1523_8 :=__common__( map(trim(C_HVAL_20K_P) = ''              => 0.013587163,
               ((real)c_hval_20k_p < 2.15000009537) => 0.0010322758,
                                                       0.013587163));

N1523_7 :=__common__( map(((real)c_inf_addr_verd_d <= NULL) => N1523_8,
               ((real)c_inf_addr_verd_d < 0.5)   => -0.0011302821,
                                                    N1523_8));

N1523_6 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)    => -0.0026638858,
               ((integer)f_prevaddrmedianincome_d < 45129) => 0.0017146289,
                                                              -0.0026638858));

N1523_5 :=__common__( map(trim(C_FAMMAR_P) = ''              => 0.010127247,
               ((real)c_fammar_p < 60.5499992371) => 0.0018416629,
                                                     0.010127247));

N1523_4 :=__common__( if(((real)f_curraddrcrimeindex_i < 92.5), N1523_5, N1523_6));

N1523_3 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N1523_4, 0.016283303));

N1523_2 :=__common__( if(((real)c_many_cars < 68.5), N1523_3, N1523_7));

N1523_1 :=__common__( if(trim(C_MANY_CARS) != '', N1523_2, 0.00094405933));

N1524_10 :=__common__( if(((real)c_hh7p_p < 5.35000038147), -0.00055840545, 0.0043838773));

N1524_9 :=__common__( if(trim(C_HH7P_P) != '', N1524_10, 0.001407708));

N1524_8 :=__common__( if(((real)f_inq_per_addr_i < 4.5), N1524_9, 0.0024498477));

N1524_7 :=__common__( if(((real)f_inq_per_addr_i > NULL), N1524_8, -0.012871308));

N1524_6 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => -0.0028848023,
               ((real)r_c21_m_bureau_adl_fs_d < 166.5) => -0.011948455,
                                                          -0.0028848023));

N1524_5 :=__common__( map(trim(C_OLDHOUSE) = ''       => 0.0018931999,
               ((real)c_oldhouse < 231.75) => N1524_6,
                                              0.0018931999));

N1524_4 :=__common__( if(((real)c_employees < 603.5), N1524_5, 0.0055908619));

N1524_3 :=__common__( if(trim(C_EMPLOYEES) != '', N1524_4, -0.0031813322));

N1524_2 :=__common__( if(((real)f_srchssnsrchcount_i < 0.5), N1524_3, N1524_7));

N1524_1 :=__common__( if(((real)f_srchssnsrchcount_i > NULL), N1524_2, 0.0082015177));

N1525_9 :=__common__( if(((real)f_srchaddrsrchcount_i < 36.5), -0.00099138291, 0.0071012497));

N1525_8 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N1525_9, -0.00096076497));

N1525_7 :=__common__( map(trim(C_LOW_HVAL) = ''              => -0.0065607116,
               ((real)c_low_hval < 51.8499984741) => 0.0025426418,
                                                     -0.0065607116));

N1525_6 :=__common__( map(trim(C_POP_85P_P) = ''              => N1525_7,
               ((real)c_pop_85p_p < 1.04999995232) => -0.0037597655,
                                                      N1525_7));

N1525_5 :=__common__( map(trim(C_HEALTH) = ''              => -0.00090080407,
               ((real)c_health < 10.9499998093) => 0.0029318095,
                                                   -0.00090080407));

N1525_4 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0580225810409), N1525_5, N1525_6));

N1525_3 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1525_4, -0.0016857057));

N1525_2 :=__common__( map(trim(C_RAPE) = ''     => N1525_3,
               ((real)c_rape < 23.5) => -0.005436515,
                                        N1525_3));

N1525_1 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1525_2, N1525_8));

N1526_9 :=__common__( map(trim(C_CIV_EMP) = ''              => 0.0010891012,
               ((real)c_civ_emp < 60.6500015259) => 0.011777715,
                                                    0.0010891012));

N1526_8 :=__common__( map(trim(C_VACANT_P) = ''              => -0.00010217522,
               ((real)c_vacant_p < 6.85000038147) => N1526_9,
                                                     -0.00010217522));

N1526_7 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1526_8, -0.0021225418));

N1526_6 :=__common__( map(trim(C_RELIG_INDX) = ''      => 0.0069706307,
               ((real)c_relig_indx < 169.5) => N1526_7,
                                               0.0069706307));

N1526_5 :=__common__( map(trim(C_SFDU_P) = ''              => 0.0066056617,
               ((real)c_sfdu_p < 56.4500007629) => -0.0019020896,
                                                   0.0066056617));

N1526_4 :=__common__( if(((real)f_corrrisktype_i < 8.5), -0.0010443273, N1526_5));

N1526_3 :=__common__( if(((real)f_corrrisktype_i > NULL), N1526_4, -0.011367852));

N1526_2 :=__common__( if(((real)c_inc_50k_p < 17.9500007629), N1526_3, N1526_6));

N1526_1 :=__common__( if(trim(C_INC_50K_P) != '', N1526_2, -0.0033056339));

N1527_10 :=__common__( if(((real)r_d32_felony_count_i < 1.5), -0.0018102461, 0.0049564185));

N1527_9 :=__common__( if(((real)r_d32_felony_count_i > NULL), N1527_10, -0.011714911));

N1527_8 :=__common__( if(((real)r_c13_curr_addr_lres_d < 1.5), 0.0072878551, -0.00060780505));

N1527_7 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1527_8, -0.029672429));

N1527_6 :=__common__( map(((real)c_impulse_count_i <= NULL) => 0.0065757656,
               ((real)c_impulse_count_i < 1.5)   => N1527_7,
                                                    0.0065757656));

N1527_5 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => 0.004911528,
               ((real)r_l79_adls_per_addr_curr_i < 36.5)  => N1527_6,
                                                             0.004911528));

N1527_4 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 355.5), N1527_5, 0.010315156));

N1527_3 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N1527_4, 0.0031561615));

N1527_2 :=__common__( if(((real)c_rich_fam < 92.5), N1527_3, N1527_9));

N1527_1 :=__common__( if(trim(C_RICH_FAM) != '', N1527_2, 0.0018553427));

N1528_9 :=__common__( map(trim(C_LARCENY) = ''     => -0.00032898466,
               ((real)c_larceny < 88.5) => 0.012330649,
                                           -0.00032898466));

N1528_8 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1528_9, -0.0011404784));

N1528_7 :=__common__( map(trim(C_NEW_HOMES) = ''      => -0.0055890286,
               ((real)c_new_homes < 184.5) => -0.00031722628,
                                              -0.0055890286));

N1528_6 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => N1528_7,
               ((integer)f_curraddrmurderindex_i < 17) => 0.0042610267,
                                                          N1528_7));

N1528_5 :=__common__( map(trim(C_HIGH_ED) = ''      => -0.0059103925,
               ((real)c_high_ed < 34.75) => N1528_6,
                                            -0.0059103925));

N1528_4 :=__common__( if(((real)c_ab_av_edu < 139.5), N1528_5, N1528_8));

N1528_3 :=__common__( if(trim(C_AB_AV_EDU) != '', N1528_4, 0.00098335075));

N1528_2 :=__common__( if(((real)r_c13_max_lres_d < 309.5), N1528_3, 0.0080997662));

N1528_1 :=__common__( if(((real)r_c13_max_lres_d > NULL), N1528_2, -0.00048828716));

N1529_7 :=__common__( map(trim(C_MORT_INDX) = ''      => -0.0070608286,
               ((real)c_mort_indx < 132.5) => 3.6870564e-005,
                                              -0.0070608286));

N1529_6 :=__common__( map(trim(C_NO_LABFOR) = ''     => 0.0022427227,
               ((real)c_no_labfor < 23.5) => -0.0054144737,
                                             0.0022427227));

N1529_5 :=__common__( map(trim(C_RICH_FAM) = ''      => N1529_7,
               ((real)c_rich_fam < 134.5) => N1529_6,
                                             N1529_7));

N1529_4 :=__common__( map(trim(C_RETAIL) = ''     => -0.0081304331,
               ((real)c_retail < 1.25) => 0.0017390579,
                                          -0.0081304331));

N1529_3 :=__common__( map(trim(C_POP_55_64_P) = ''              => N1529_5,
               ((real)c_pop_55_64_p < 4.14999961853) => N1529_4,
                                                        N1529_5));

N1529_2 :=__common__( if(((real)c_hh3_p < 22.6500015259), N1529_3, -0.0017879198));

N1529_1 :=__common__( if(trim(C_HH3_P) != '', N1529_2, 0.00055059984));

N1530_8 :=__common__( map(trim(C_INC_25K_P) = ''              => -0.0026373444,
               ((real)c_inc_25k_p < 15.5500001907) => 0.0014688271,
                                                      -0.0026373444));

N1530_7 :=__common__( map(((real)r_c20_email_count_i <= NULL) => 0.00047161895,
               ((real)r_c20_email_count_i < 1.5)   => -0.011691533,
                                                      0.00047161895));

N1530_6 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i < 0.5), 0.0042750909, N1530_7));

N1530_5 :=__common__( if(((real)r_c18_invalid_addrs_per_adl_i > NULL), N1530_6, 0.041488972));

N1530_4 :=__common__( map(trim(C_INC_75K_P) = ''              => -0.011650726,
               ((real)c_inc_75k_p < 13.8500003815) => N1530_5,
                                                      -0.011650726));

N1530_3 :=__common__( map(trim(C_INC_50K_P) = ''              => N1530_8,
               ((real)c_inc_50k_p < 10.8500003815) => N1530_4,
                                                      N1530_8));

N1530_2 :=__common__( if(((real)c_highinc < 2.54999995232), N1530_3, 0.00049481803));

N1530_1 :=__common__( if(trim(C_HIGHINC) != '', N1530_2, 0.00028900847));

N1531_8 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => 0.0010293223,
               ((real)f_mos_inq_banko_cm_lseen_d < 13.5)  => 0.0088011631,
                                                             0.0010293223));

N1531_7 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => N1531_8,
               ((integer)f_curraddrcartheftindex_i < 62) => -0.0041349028,
                                                            N1531_8));

N1531_6 :=__common__( map(((real)f_current_count_d <= NULL) => -0.0020062872,
               ((real)f_current_count_d < 1.5)   => N1531_7,
                                                    -0.0020062872));

N1531_5 :=__common__( if(((real)f_curraddractivephonelist_d < 0.5), N1531_6, -0.004164497));

N1531_4 :=__common__( if(((real)f_curraddractivephonelist_d > NULL), N1531_5, -0.0014368688));

N1531_3 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)   => 0.002479023,
               ((real)f_curraddrmedianincome_d < 62370.5) => N1531_4,
                                                             0.002479023));

N1531_2 :=__common__( if(((real)f_mos_liens_unrel_sc_fseen_d < 22.5), 0.0066390905, N1531_3));

N1531_1 :=__common__( if(((real)f_mos_liens_unrel_sc_fseen_d > NULL), N1531_2, 0.0027604222));

N1532_9 :=__common__( if(((real)c_inc_50k_p < 7.94999980927), -0.0043583647, 0.0028446413));

N1532_8 :=__common__( if(trim(C_INC_50K_P) != '', N1532_9, 0.0060461074));

N1532_7 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL)  => -0.0065340969,
               ((real)f_liens_unrel_cj_total_amt_i < 6969.5) => N1532_8,
                                                                -0.0065340969));

N1532_6 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL) => 0.010226354,
               ((real)f_liens_unrel_cj_total_amt_i < 692.5) => -4.1034421e-005,
                                                               0.010226354));

N1532_5 :=__common__( map(trim(C_FOOD) = ''      => 0.0016888279,
               ((real)c_food < 37.75) => -0.0019137004,
                                         0.0016888279));

N1532_4 :=__common__( if(((real)c_mil_emp < 1.04999995232), N1532_5, N1532_6));

N1532_3 :=__common__( if(trim(C_MIL_EMP) != '', N1532_4, -0.0037718937));

N1532_2 :=__common__( if(((real)f_prevaddroccupantowned_d < 0.5), N1532_3, N1532_7));

N1532_1 :=__common__( if(((real)f_prevaddroccupantowned_d > NULL), N1532_2, 0.0037109677));

N1533_11 :=__common__( if(((real)c_bargains < 54.5), -0.0049108991, 0.00083649483));

N1533_10 :=__common__( if(trim(C_BARGAINS) != '', N1533_11, 0.0026851716));

N1533_9 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0168872028589), -0.0050908017, 0.0017270091));

N1533_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1533_9, -5.4667939e-005));

N1533_7 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)             => N1533_8,
               ((real)f_add_curr_nhood_vac_pct_i < 0.000119274809549) => 0.0090312553,
                                                                         N1533_8));

N1533_6 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1533_7, N1533_10));

N1533_5 :=__common__( map(((real)f_corrssnnamecount_d <= NULL) => N1533_6,
               ((real)f_corrssnnamecount_d < 1.5)   => -0.0050090146,
                                                       N1533_6));

N1533_4 :=__common__( if(((real)f_divrisktype_i < 4.5), N1533_5, 0.0075057669));

N1533_3 :=__common__( if(((real)f_divrisktype_i > NULL), N1533_4, 0.0041417812));

N1533_2 :=__common__( if(((real)f_inq_per_addr_i < 6.5), N1533_3, -0.0020702684));

N1533_1 :=__common__( if(((real)f_inq_per_addr_i > NULL), N1533_2, 0.009037545));

N1534_8 :=__common__( map(((real)f_estimated_income_d <= NULL)    => -0.00087374759,
               ((integer)f_estimated_income_d < 41500) => 0.0093625675,
                                                          -0.00087374759));

N1534_7 :=__common__( map(trim(C_EXP_HOMES) = ''      => N1534_8,
               ((real)c_exp_homes < 167.5) => -0.0008640789,
                                              N1534_8));

N1534_6 :=__common__( map(trim(C_OLD_HOMES) = ''     => 0.00065823076,
               ((real)c_old_homes < 59.5) => 0.011538306,
                                             0.00065823076));

N1534_5 :=__common__( if(((real)c_addr_lres_12mo_ct_i < 0.5), N1534_6, N1534_7));

N1534_4 :=__common__( if(((real)c_addr_lres_12mo_ct_i > NULL), N1534_5, 0.0014584337));

N1534_3 :=__common__( map(trim(C_RNT1250_P) = ''              => -0.0081424625,
               ((real)c_rnt1250_p < 41.5999984741) => N1534_4,
                                                      -0.0081424625));

N1534_2 :=__common__( if(((real)c_child < 37.25), N1534_3, 0.004481535));

N1534_1 :=__common__( if(trim(C_CHILD) != '', N1534_2, 0.00079381098));

N1535_10 :=__common__( if(((integer)f_addrchangevaluediff_d < -663), -0.0035831013, 0.0079598536));

N1535_9 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1535_10, -0.00091736841));

N1535_8 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => N1535_9,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.745966672897) => 0.0078539436,
                                                                      N1535_9));

N1535_7 :=__common__( map(((real)f_srchphonesrchcount_i <= NULL) => -0.0051797469,
               ((real)f_srchphonesrchcount_i < 7.5)   => N1535_8,
                                                         -0.0051797469));

N1535_6 :=__common__( map(trim(C_REST_INDX) = ''      => -0.0040304239,
               ((real)c_rest_indx < 118.5) => 0.0048716736,
                                              -0.0040304239));

N1535_5 :=__common__( if(((real)c_hh3_p < 19.25), -0.0021106069, N1535_6));

N1535_4 :=__common__( if(trim(C_HH3_P) != '', N1535_5, 0.0027061959));

N1535_3 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), -0.00052482602, N1535_4));

N1535_2 :=__common__( if(((real)r_c15_ssns_per_adl_i < 2.5), N1535_3, N1535_7));

N1535_1 :=__common__( if(((real)r_c15_ssns_per_adl_i > NULL), N1535_2, -0.00043091728));

N1536_9 :=__common__( map(trim(C_UNEMPL) = ''     => 0.00051668864,
               ((real)c_unempl < 72.5) => 0.0044551347,
                                          0.00051668864));

N1536_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.00492005655542), -0.0050276091, N1536_9));

N1536_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1536_8, -0.0026010506));

N1536_6 :=__common__( if(((real)f_curraddrcrimeindex_i < 92.5), 0.0061707429, -0.0027364901));

N1536_5 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N1536_6, 0.0075547418));

N1536_4 :=__common__( map(trim(C_CARTHEFT) = ''      => -0.012304915,
               ((real)c_cartheft < 135.5) => -0.0034490302,
                                             -0.012304915));

N1536_3 :=__common__( map(trim(C_LOW_ED) = ''              => N1536_5,
               ((real)c_low_ed < 53.8499984741) => N1536_4,
                                                   N1536_5));

N1536_2 :=__common__( if(((real)c_born_usa < 50.5), N1536_3, N1536_7));

N1536_1 :=__common__( if(trim(C_BORN_USA) != '', N1536_2, 0.0021247318));

N1537_9 :=__common__( if(((real)f_m_bureau_adl_fs_all_d < 132.5), 0.0046243777, -0.0054342467));

N1537_8 :=__common__( if(((real)f_m_bureau_adl_fs_all_d > NULL), N1537_9, 0.0083221812));

N1537_7 :=__common__( map(trim(C_INC_75K_P) = ''      => 0.014491264,
               ((real)c_inc_75k_p < 24.75) => 0.0033161395,
                                              0.014491264));

N1537_6 :=__common__( if(((real)f_rel_criminal_count_i < 1.5), -0.0021691272, N1537_7));

N1537_5 :=__common__( if(((real)f_rel_criminal_count_i > NULL), N1537_6, 0.0049160118));

N1537_4 :=__common__( map(trim(C_RNT1000_P) = ''              => N1537_8,
               ((real)c_rnt1000_p < 29.8499984741) => N1537_5,
                                                      N1537_8));

N1537_3 :=__common__( map(trim(C_BIGAPT_P) = ''     => N1537_4,
               ((real)c_bigapt_p < 1.25) => -0.00059969097,
                                            N1537_4));

N1537_2 :=__common__( if(((real)c_popover18 < 459.5), -0.0054435721, N1537_3));

N1537_1 :=__common__( if(trim(C_POPOVER18) != '', N1537_2, -0.0039330218));

N1538_9 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0412124246359), 0.0037925162, -0.0021188934));

N1538_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1538_9, 0.00033665346));

N1538_7 :=__common__( map(trim(C_MANY_CARS) = ''     => N1538_8,
               ((real)c_many_cars < 77.5) => 0.0048632043,
                                             N1538_8));

N1538_6 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => -0.0057656329,
               ((real)f_m_bureau_adl_fs_all_d < 83.5)  => 0.0024612815,
                                                          -0.0057656329));

N1538_5 :=__common__( map(trim(C_MORT_INDX) = ''      => 0.0050379024,
               ((real)c_mort_indx < 124.5) => N1538_6,
                                              0.0050379024));

N1538_4 :=__common__( if(((real)c_exp_prod < 45.5), N1538_5, N1538_7));

N1538_3 :=__common__( if(trim(C_EXP_PROD) != '', N1538_4, 0.0028460412));

N1538_2 :=__common__( if(((real)f_corrssnnamecount_d < 4.5), N1538_3, -0.0011618732));

N1538_1 :=__common__( if(((real)f_corrssnnamecount_d > NULL), N1538_2, -0.0092123104));

N1539_8 :=__common__( map(trim(C_MED_YEARBLT) = ''       => 0.0087672713,
               ((real)c_med_yearblt < 1977.5) => 0.00047575506,
                                                 0.0087672713));

N1539_7 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)     => -0.0056119296,
               ((integer)f_prevaddrmedianvalue_d < 132824) => N1539_8,
                                                              -0.0056119296));

N1539_6 :=__common__( if(((integer)f_mos_liens_unrel_lt_lseen_d < 147), 0.0097894755, N1539_7));

N1539_5 :=__common__( if(((real)f_mos_liens_unrel_lt_lseen_d > NULL), N1539_6, 0.023344468));

N1539_4 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)            => -0.00066032044,
               ((real)f_add_curr_nhood_vac_pct_i < 0.00936176627874) => 0.0061060803,
                                                                        -0.00066032044));

N1539_3 :=__common__( map(trim(C_EXP_PROD) = ''      => N1539_4,
               ((real)c_exp_prod < 116.5) => -0.0017548814,
                                             N1539_4));

N1539_2 :=__common__( if(((real)c_rnt500_p < 49.1500015259), N1539_3, N1539_5));

N1539_1 :=__common__( if(trim(C_RNT500_P) != '', N1539_2, 0.0021809718));

N1540_9 :=__common__( map(trim(C_HVAL_300K_P) = ''              => -0.011485917,
               ((real)c_hval_300k_p < 7.44999980927) => -0.0021545011,
                                                        -0.011485917));

N1540_8 :=__common__( map(trim(C_RENTOCC_P) = ''      => 0.0043093153,
               ((real)c_rentocc_p < 24.25) => -0.0012476934,
                                              0.0043093153));

N1540_7 :=__common__( map(trim(C_HH00) = ''      => N1540_8,
               ((real)c_hh00 < 341.5) => -0.0053752658,
                                         N1540_8));

N1540_6 :=__common__( if(((real)c_famotf18_p < 26.1500015259), N1540_7, N1540_9));

N1540_5 :=__common__( if(trim(C_FAMOTF18_P) != '', N1540_6, -0.0056403268));

N1540_4 :=__common__( if(((real)r_c13_curr_addr_lres_d < 18.5), N1540_5, 0.00095533507));

N1540_3 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1540_4, -0.029183811));

N1540_2 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 16.5), N1540_3, -0.0053454386));

N1540_1 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N1540_2, -0.0026525168));

N1541_10 :=__common__( map(((real)f_inq_count24_i <= NULL) => -0.010960133,
                ((real)f_inq_count24_i < 14.5)  => -0.0020942091,
                                                   -0.010960133));

N1541_9 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d < 70.5), 0.0042587057, N1541_10));

N1541_8 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d > NULL), N1541_9, 0.0010752838));

N1541_7 :=__common__( if(((real)c_blue_empl < 139.5), 0.0011868563, N1541_8));

N1541_6 :=__common__( if(trim(C_BLUE_EMPL) != '', N1541_7, -0.00011805611));

N1541_5 :=__common__( map(trim(C_HVAL_60K_P) = ''              => 0.0066643423,
               ((real)c_hval_60k_p < 5.94999980927) => -0.002516366,
                                                       0.0066643423));

N1541_4 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => 0.011668436,
               ((real)c_dist_best_to_prev_addr_i < 29.5)  => N1541_5,
                                                             0.011668436));

N1541_3 :=__common__( if(((real)c_mort_indx < 87.5), N1541_4, -0.0019457583));

N1541_2 :=__common__( if(trim(C_MORT_INDX) != '', N1541_3, -0.013831404));

N1541_1 :=__common__( if(((real)f_college_income_d > NULL), N1541_2, N1541_6));

N1542_9 :=__common__( map(trim(C_RENTAL) = ''      => -0.0099309385,
               ((real)c_rental < 122.5) => 0.0016068464,
                                           -0.0099309385));

N1542_8 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i < 185.5), 0.00074958496, 0.00886939));

N1542_7 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N1542_8, -0.031413537));

N1542_6 :=__common__( map(trim(C_FAMILIES) = ''      => -0.00052283158,
               ((real)c_families < 179.5) => N1542_7,
                                             -0.00052283158));

N1542_5 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.24905988574), N1542_6, 0.0062139428));

N1542_4 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1542_5, 6.2672784e-005));

N1542_3 :=__common__( map(trim(C_FOOD) = ''              => N1542_9,
               ((real)c_food < 69.5500030518) => N1542_4,
                                                 N1542_9));

N1542_2 :=__common__( if(((real)c_inc_150k_p < 9.85000038147), N1542_3, -0.006073843));

N1542_1 :=__common__( if(trim(C_INC_150K_P) != '', N1542_2, 0.0010692489));

N1543_9 :=__common__( if(((real)c_old_homes < 40.5), -0.0010941123, 0.0016587913));

N1543_8 :=__common__( if(trim(C_OLD_HOMES) != '', N1543_9, -0.0044667559));

N1543_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), -0.003994341, 0.026115985));

N1543_6 :=__common__( if(((real)c_hh3_p < 18.8499984741), N1543_7, 0.00699521));

N1543_5 :=__common__( if(trim(C_HH3_P) != '', N1543_6, 0.0044317179));

N1543_4 :=__common__( map(((real)c_nap_lname_verd_d <= NULL) => N1543_5,
               ((real)c_nap_lname_verd_d < 0.5)   => -0.0066683254,
                                                     N1543_5));

N1543_3 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => N1543_8,
               ((real)f_m_bureau_adl_fs_all_d < 77.5)  => N1543_4,
                                                          N1543_8));

N1543_2 :=__common__( if(((real)f_mos_liens_unrel_lt_lseen_d < 28.5), -0.0046846559, N1543_3));

N1543_1 :=__common__( if(((real)f_mos_liens_unrel_lt_lseen_d > NULL), N1543_2, 0.0090326451));

N1544_8 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => 0.0036529929,
               ((real)f_add_input_mobility_index_n < 0.457870215178) => -0.0020185522,
                                                                        0.0036529929));

N1544_7 :=__common__( map(((real)r_d32_mos_since_crim_ls_d <= NULL) => 0.0010886158,
               ((real)r_d32_mos_since_crim_ls_d < 151.5) => N1544_8,
                                                            0.0010886158));

N1544_6 :=__common__( map(trim(C_BORN_USA) = ''     => N1544_7,
               ((real)c_born_usa < 16.5) => 0.0062241526,
                                            N1544_7));

N1544_5 :=__common__( map(trim(C_SUB_BUS) = ''      => -0.0072635391,
               ((real)c_sub_bus < 189.5) => N1544_6,
                                            -0.0072635391));

N1544_4 :=__common__( if(((real)f_rel_educationover12_count_d < 0.5), -0.0061453352, N1544_5));

N1544_3 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N1544_4, -0.0015146129));

N1544_2 :=__common__( if(((real)c_oldhouse < 1033.25), N1544_3, 0.005886245));

N1544_1 :=__common__( if(trim(C_OLDHOUSE) != '', N1544_2, 0.0031834582));

N1545_11 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.248279333115), -0.00015964354, -0.0059300091));

N1545_10 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1545_11, -0.003348619));

N1545_9 :=__common__( map(((real)r_l79_adls_per_addr_c6_i <= NULL) => -0.0050167995,
               ((real)r_l79_adls_per_addr_c6_i < 0.5)   => 0.0070688502,
                                                           -0.0050167995));

N1545_8 :=__common__( if(((real)c_dist_best_to_prev_addr_i < 3.5), 0.0068362741, N1545_9));

N1545_7 :=__common__( if(((real)c_dist_best_to_prev_addr_i > NULL), N1545_8, 0.025244787));

N1545_6 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.651309907436), N1545_7, -0.0054610527));

N1545_5 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1545_6, 0.0013858198));

N1545_4 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0066599319689), 0.011560699, N1545_5));

N1545_3 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1545_4, 0.0055242271));

N1545_2 :=__common__( if(((real)c_retired < 4.75), N1545_3, N1545_10));

N1545_1 :=__common__( if(trim(C_RETIRED) != '', N1545_2, -0.0033933464));

N1546_9 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL) => 0.0025090254,
               ((real)f_prevaddrcartheftindex_i < 103.5) => -0.003676014,
                                                            0.0025090254));

N1546_8 :=__common__( map(trim(C_HH2_P) = ''              => N1546_9,
               ((real)c_hh2_p < 23.3499984741) => -0.004979702,
                                                  N1546_9));

N1546_7 :=__common__( map(trim(C_POP_18_24_P) = ''              => 0.0017124016,
               ((real)c_pop_18_24_p < 8.55000019073) => N1546_8,
                                                        0.0017124016));

N1546_6 :=__common__( if(((real)f_rel_felony_count_i < 7.5), N1546_7, 0.007468876));

N1546_5 :=__common__( if(((real)f_rel_felony_count_i > NULL), N1546_6, -0.002954935));

N1546_4 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d < 55.5), -0.0080612761, -0.00070004344));

N1546_3 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d > NULL), N1546_4, -0.0083858826));

N1546_2 :=__common__( if(((real)c_famotf18_p < 12.3500003815), N1546_3, N1546_5));

N1546_1 :=__common__( if(trim(C_FAMOTF18_P) != '', N1546_2, 0.00082199662));

N1547_9 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => -8.8712478e-005,
               ((real)f_srchaddrsrchcount_i < 10.5)  => -0.0075282094,
                                                        -8.8712478e-005));

N1547_8 :=__common__( if(((real)c_incollege < 9.35000038147), N1547_9, 0.0048042202));

N1547_7 :=__common__( if(trim(C_INCOLLEGE) != '', N1547_8, -0.028087277));

N1547_6 :=__common__( map(((real)r_i60_inq_banking_count12_i <= NULL) => N1547_7,
               ((real)r_i60_inq_banking_count12_i < 0.5)   => 0.00028783698,
                                                              N1547_7));

N1547_5 :=__common__( map(((real)f_varrisktype_i <= NULL) => 0.0044347571,
               ((real)f_varrisktype_i < 7.5)   => N1547_6,
                                                  0.0044347571));

N1547_4 :=__common__( if(((real)f_add_input_mobility_index_n < 0.401520192623), 0.007433283, -0.0014779475));

N1547_3 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1547_4, 0.023292027));

N1547_2 :=__common__( if(((real)f_corrssnaddrcount_d < 0.5), N1547_3, N1547_5));

N1547_1 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N1547_2, 0.00091608643));

N1548_10 :=__common__( if(((real)c_hh6_p < 8.25), -0.0022947223, 0.0049630154));

N1548_9 :=__common__( if(trim(C_HH6_P) != '', N1548_10, -0.0038749094));

N1548_8 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), 0.00066599904, 0.045096576));

N1548_7 :=__common__( map(((real)r_l80_inp_avm_autoval_d <= NULL)    => -0.007787069,
               ((real)r_l80_inp_avm_autoval_d < 129501.5) => N1548_8,
                                                             -0.007787069));

N1548_6 :=__common__( map(trim(C_OLDHOUSE) = ''      => N1548_7,
               ((integer)c_oldhouse < 32) => 0.0065337431,
                                             N1548_7));

N1548_5 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1548_6, 0.0013147964));

N1548_4 :=__common__( if(((real)c_rich_old < 175.5), N1548_5, -0.0073344677));

N1548_3 :=__common__( if(trim(C_RICH_OLD) != '', N1548_4, 0.0012239946));

N1548_2 :=__common__( if(((real)r_c13_max_lres_d < 123.5), N1548_3, N1548_9));

N1548_1 :=__common__( if(((real)r_c13_max_lres_d > NULL), N1548_2, -0.0021275599));

N1549_9 :=__common__( if(((real)f_rel_incomeover25_count_d < 25.5), -0.002036133, 0.0057151449));

N1549_8 :=__common__( if(((real)f_rel_incomeover25_count_d > NULL), N1549_9, -0.011024107));

N1549_7 :=__common__( map(trim(C_LARCENY) = ''     => -0.00056209527,
               ((real)c_larceny < 86.5) => 0.0026251591,
                                           -0.00056209527));

N1549_6 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.00010770685,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0876275449991) => 0.011957619,
                                                                       0.00010770685));

N1549_5 :=__common__( if(((integer)f_estimated_income_d < 23500), N1549_6, N1549_7));

N1549_4 :=__common__( if(((real)f_estimated_income_d > NULL), N1549_5, -0.0010459445));

N1549_3 :=__common__( map(trim(C_CHILD) = ''              => N1549_8,
               ((real)c_child < 30.1500015259) => N1549_4,
                                                  N1549_8));

N1549_2 :=__common__( if(((real)c_hval_1001k_p < 4.75), N1549_3, 0.0066763086));

N1549_1 :=__common__( if(trim(C_HVAL_1001K_P) != '', N1549_2, 0.00031279761));

N1550_11 :=__common__( if(((real)c_hval_150k_p < 7.44999980927), 0.0077322311, -0.0032311964));

N1550_10 :=__common__( if(trim(C_HVAL_150K_P) != '', N1550_11, 0.023962826));

N1550_9 :=__common__( map(((real)f_liens_unrel_cj_total_amt_i <= NULL) => -0.0066755687,
               ((real)f_liens_unrel_cj_total_amt_i < 533.5) => N1550_10,
                                                               -0.0066755687));

N1550_8 :=__common__( if(((real)f_corraddrnamecount_d < 4.5), -0.0067313774, N1550_9));

N1550_7 :=__common__( if(((real)f_corraddrnamecount_d > NULL), N1550_8, -0.030148244));

N1550_6 :=__common__( if(((real)f_add_input_mobility_index_n < 0.735688328743), 3.4925775e-005, 0.0066087431));

N1550_5 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1550_6, 0.0065157198));

N1550_4 :=__common__( map(((real)c_inf_phn_verd_d <= NULL) => N1550_7,
               ((real)c_inf_phn_verd_d < 0.5)   => N1550_5,
                                                   N1550_7));

N1550_3 :=__common__( if(((real)f_m_bureau_adl_fs_all_d < 120.5), 0.0057797642, -0.00040716288));

N1550_2 :=__common__( if(((real)f_m_bureau_adl_fs_all_d > NULL), N1550_3, -0.012348091));

N1550_1 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), N1550_2, N1550_4));

N1551_8 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => 0.00043344695,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.488488644361) => 0.0093417063,
                                                                      0.00043344695));

N1551_7 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => N1551_8,
               ((real)c_dist_best_to_prev_addr_i < 9.5)   => -0.0026431641,
                                                             N1551_8));

N1551_6 :=__common__( map(trim(C_POP_35_44_P) = ''      => 0.0011620204,
               ((real)c_pop_35_44_p < 12.75) => N1551_7,
                                                0.0011620204));

N1551_5 :=__common__( map(((real)f_mos_liens_rel_ot_fseen_d <= NULL) => -0.0064331341,
               ((real)f_mos_liens_rel_ot_fseen_d < 24.5)  => N1551_6,
                                                             -0.0064331341));

N1551_4 :=__common__( if(((real)r_c10_m_hdr_fs_d < 35.5), -0.0056819154, N1551_5));

N1551_3 :=__common__( if(((real)r_c10_m_hdr_fs_d > NULL), N1551_4, -0.0045617886));

N1551_2 :=__common__( if(((real)c_pop_18_24_p < 2.75), 0.0042881298, N1551_3));

N1551_1 :=__common__( if(trim(C_POP_18_24_P) != '', N1551_2, -0.0095678257));

N1552_9 :=__common__( map(trim(C_INC_125K_P) = ''              => 0.0081202128,
               ((real)c_inc_125k_p < 2.95000004768) => 0.0012572843,
                                                       0.0081202128));

N1552_8 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.150465726852), N1552_9, -0.0043256094));

N1552_7 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1552_8, 0.0025640557));

N1552_6 :=__common__( map(trim(C_INC_125K_P) = ''              => -0.0010082392,
               ((real)c_inc_125k_p < 3.34999990463) => N1552_7,
                                                       -0.0010082392));

N1552_5 :=__common__( if(((real)f_add_input_mobility_index_n < 0.586230933666), N1552_6, 0.0046440626));

N1552_4 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1552_5, -0.033062685));

N1552_3 :=__common__( map(trim(C_HH7P_P) = ''              => 0.0053914868,
               ((real)c_hh7p_p < 9.85000038147) => N1552_4,
                                                   0.0053914868));

N1552_2 :=__common__( map(((real)r_l70_add_standardized_i <= NULL) => -0.0060828455,
               ((real)r_l70_add_standardized_i < 1.5)   => N1552_3,
                                                           -0.0060828455));

N1552_1 :=__common__( if(trim(C_MEDI_INDX) != '', N1552_2, -0.00057316677));

N1553_8 :=__common__( map(trim(C_MED_RENT) = ''      => 0.0027766739,
               ((real)c_med_rent < 617.5) => 0.01551607,
                                             0.0027766739));

N1553_7 :=__common__( map(trim(C_HIGH_ED) = ''              => N1553_8,
               ((real)c_high_ed < 26.9500007629) => 0.00086544322,
                                                    N1553_8));

N1553_6 :=__common__( map(trim(C_INC_35K_P) = ''              => N1553_7,
               ((real)c_inc_35k_p < 5.55000019073) => -0.0048718672,
                                                      N1553_7));

N1553_5 :=__common__( if(((real)f_rel_under25miles_cnt_d < 9.5), -0.0010402961, N1553_6));

N1553_4 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N1553_5, 0.0022594224));

N1553_3 :=__common__( map(trim(C_HVAL_175K_P) = ''              => -0.0065135645,
               ((real)c_hval_175k_p < 33.8499984741) => N1553_4,
                                                        -0.0065135645));

N1553_2 :=__common__( if(((real)c_apt20 < 185.5), N1553_3, 0.0054423051));

N1553_1 :=__common__( if(trim(C_APT20) != '', N1553_2, -0.00015891891));

N1554_8 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => -0.0104518,
               ((real)f_add_input_mobility_index_n < 0.318435251713) => -0.00046889526,
                                                                        -0.0104518));

N1554_7 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => 0.0032860718,
               ((real)f_inq_adls_per_phone_i < 0.5)   => N1554_8,
                                                         0.0032860718));

N1554_6 :=__common__( map(((real)f_rel_homeover300_count_d <= NULL) => 0.0075207721,
               ((real)f_rel_homeover300_count_d < 2.5)   => N1554_7,
                                                            0.0075207721));

N1554_5 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL) => 0.0072182925,
               ((real)f_prevaddrmurderindex_i < 161.5) => N1554_6,
                                                          0.0072182925));

N1554_4 :=__common__( if(((real)f_rel_ageover40_count_d < 7.5), N1554_5, 0.014830699));

N1554_3 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N1554_4, 0.0025273062));

N1554_2 :=__common__( if(((real)c_popover25 < 1467.5), -0.00046834963, N1554_3));

N1554_1 :=__common__( if(trim(C_POPOVER25) != '', N1554_2, 0.00054070872));

N1555_10 :=__common__( map(trim(C_HIGHINC) = ''              => 0.0067548828,
                ((real)c_highinc < 9.64999961853) => -0.0038030447,
                                                     0.0067548828));

N1555_9 :=__common__( if(((real)c_food < 36.4500007629), N1555_10, -0.01189177));

N1555_8 :=__common__( if(trim(C_FOOD) != '', N1555_9, -0.012739919));

N1555_7 :=__common__( map(trim(C_SERV_EMPL) = ''      => 0.0061575814,
               ((real)c_serv_empl < 150.5) => -0.0036644708,
                                              0.0061575814));

N1555_6 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.286486625671), 0.011141267, N1555_7));

N1555_5 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1555_6, 0.0086940283));

N1555_4 :=__common__( if(((real)c_hval_40k_p < 20.8499984741), -0.00042313292, N1555_5));

N1555_3 :=__common__( if(trim(C_HVAL_40K_P) != '', N1555_4, 0.0046001767));

N1555_2 :=__common__( if(((real)f_prevaddrageoldest_d < 146.5), N1555_3, N1555_8));

N1555_1 :=__common__( if(((real)f_prevaddrageoldest_d > NULL), N1555_2, 0.0025749212));

N1556_10 :=__common__( map(trim(C_HIGHINC) = ''              => 0.0011653102,
                ((real)c_highinc < 4.64999961853) => 0.0094864855,
                                                     0.0011653102));

N1556_9 :=__common__( if(((real)c_pop00 < 2255.5), -0.00046177426, N1556_10));

N1556_8 :=__common__( if(trim(C_POP00) != '', N1556_9, 0.0031109505));

N1556_7 :=__common__( map(trim(C_OLD_HOMES) = ''      => 0.0079813031,
               ((real)c_old_homes < 120.5) => -0.0012358944,
                                              0.0079813031));

N1556_6 :=__common__( map(trim(C_INC_125K_P) = ''              => 0.0010029897,
               ((real)c_inc_125k_p < 5.14999961853) => -0.0034577144,
                                                       0.0010029897));

N1556_5 :=__common__( if(((real)c_cartheft < 175.5), N1556_6, N1556_7));

N1556_4 :=__common__( if(trim(C_CARTHEFT) != '', N1556_5, 0.015256123));

N1556_3 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N1556_4, N1556_8));

N1556_2 :=__common__( if(((integer)r_i60_inq_retail_recency_d < 9), 0.008344301, N1556_3));

N1556_1 :=__common__( if(((real)r_i60_inq_retail_recency_d > NULL), N1556_2, -0.0020885297));

N1557_8 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => -0.0067114208,
               ((real)f_mos_inq_banko_om_fseen_d < 35.5)  => 0.0033073082,
                                                             -0.0067114208));

N1557_7 :=__common__( map(trim(C_UNEMPL) = ''      => -0.0092383367,
               ((real)c_unempl < 162.5) => N1557_8,
                                           -0.0092383367));

N1557_6 :=__common__( map(trim(C_SERV_EMPL) = ''      => -0.0028968061,
               ((real)c_serv_empl < 127.5) => 0.0020748079,
                                              -0.0028968061));

N1557_5 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => N1557_7,
               ((real)f_add_input_nhood_vac_pct_i < 0.0886270403862) => N1557_6,
                                                                        N1557_7));

N1557_4 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => 0.00064287737,
               ((real)f_m_bureau_adl_fs_all_d < 22.5)  => -0.00697814,
                                                          0.00064287737));

N1557_3 :=__common__( map(trim(C_INCOLLEGE) = ''              => N1557_5,
               ((real)c_incollege < 7.85000038147) => N1557_4,
                                                      N1557_5));

N1557_2 :=__common__( if(((real)f_liens_unrel_ft_total_amt_i > NULL), N1557_3, -0.00058192269));

N1557_1 :=__common__( if(trim(C_INCOLLEGE) != '', N1557_2, -0.0024740757));

N1558_9 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => -0.0014835815,
               ((real)f_prevaddrmedianincome_d < 33503.5) => 0.0067767873,
                                                             -0.0014835815));

N1558_8 :=__common__( if(((real)f_util_adl_count_n < 6.5), N1558_9, -0.0081566907));

N1558_7 :=__common__( if(((real)f_util_adl_count_n > NULL), N1558_8, -0.031428304));

N1558_6 :=__common__( map(trim(C_BUSINESS) = ''     => 0.0076441831,
               ((real)c_business < 30.5) => N1558_7,
                                            0.0076441831));

N1558_5 :=__common__( map(((real)f_add_input_nhood_mfd_pct_i <= NULL)           => -0.00028418272,
               ((real)f_add_input_nhood_mfd_pct_i < 0.0047558657825) => 0.0084563463,
                                                                        -0.00028418272));

N1558_4 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.00328272534534), -0.0082972606, N1558_5));

N1558_3 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1558_4, N1558_6));

N1558_2 :=__common__( if(((integer)c_totsales < 196725), N1558_3, 0.0072317762));

N1558_1 :=__common__( if(trim(C_TOTSALES) != '', N1558_2, 0.0022556127));

N1559_8 :=__common__( map(((real)f_current_count_d <= NULL) => 0.0050079515,
               ((real)f_current_count_d < 0.5)   => -0.0048814377,
                                                    0.0050079515));

N1559_7 :=__common__( if(((real)f_assocrisktype_i < 6.5), N1559_8, -0.0084824876));

N1559_6 :=__common__( if(((real)f_assocrisktype_i > NULL), N1559_7, -0.034307152));

N1559_5 :=__common__( map(((real)c_comb_age_d <= NULL) => 0.00047695703,
               ((real)c_comb_age_d < 21.5)  => 0.0058213071,
                                               0.00047695703));

N1559_4 :=__common__( map(trim(C_LOWINC) = ''      => N1559_6,
               ((real)c_lowinc < 74.25) => N1559_5,
                                           N1559_6));

N1559_3 :=__common__( map(trim(C_LAR_FAM) = ''      => -0.0071891952,
               ((real)c_lar_fam < 121.5) => -0.00013385225,
                                            -0.0071891952));

N1559_2 :=__common__( if(((real)c_no_car < 48.5), N1559_3, N1559_4));

N1559_1 :=__common__( if(trim(C_NO_CAR) != '', N1559_2, -0.00017397334));

N1560_9 :=__common__( map(trim(C_EXP_PROD) = ''     => 0.0083197891,
               ((real)c_exp_prod < 48.5) => -0.0039413895,
                                            0.0083197891));

N1560_8 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => 0.0049332295,
               ((real)f_add_curr_nhood_vac_pct_i < 0.239955157042) => -0.0030488071,
                                                                      0.0049332295));

N1560_7 :=__common__( map(trim(C_INC_50K_P) = ''      => N1560_9,
               ((real)c_inc_50k_p < 19.75) => N1560_8,
                                              N1560_9));

N1560_6 :=__common__( if(((integer)f_liens_unrel_o_total_amt_i < 44), N1560_7, -0.011315429));

N1560_5 :=__common__( if(((real)f_liens_unrel_o_total_amt_i > NULL), N1560_6, 0.0032275405));

N1560_4 :=__common__( if(((real)c_burglary < 43.5), 0.0064903297, N1560_5));

N1560_3 :=__common__( if(trim(C_BURGLARY) != '', N1560_4, -0.0015407981));

N1560_2 :=__common__( map(trim(C_POP_25_34_P) = ''              => -0.0042416813,
               ((real)c_pop_25_34_p < 22.6500015259) => 0.00039426461,
                                                        -0.0042416813));

N1560_1 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1560_2, N1560_3));

N1561_8 :=__common__( map(trim(C_RNT250_P) = ''              => -0.0054198782,
               ((real)c_rnt250_p < 47.1500015259) => 0.0003631578,
                                                     -0.0054198782));

N1561_7 :=__common__( map(trim(C_WORK_HOME) = ''     => 0.0061792421,
               ((real)c_work_home < 85.5) => -0.0043381779,
                                             0.0061792421));

N1561_6 :=__common__( map(((real)f_srchaddrsrchcount_i <= NULL) => 0.0062772203,
               ((real)f_srchaddrsrchcount_i < 11.5)  => N1561_7,
                                                        0.0062772203));

N1561_5 :=__common__( map(((real)c_nap_fname_verd_d <= NULL) => 0.012975373,
               ((real)c_nap_fname_verd_d < 0.5)   => 0.0029608033,
                                                     0.012975373));

N1561_4 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d < 121.5), N1561_5, N1561_6));

N1561_3 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d > NULL), N1561_4, 0.004813157));

N1561_2 :=__common__( if(((real)c_hh5_p < 0.15000000596), N1561_3, N1561_8));

N1561_1 :=__common__( if(trim(C_HH5_P) != '', N1561_2, 0.0027274957));

N1562_8 :=__common__( map(trim(C_UNEMP) = ''     => -0.011559953,
               ((real)c_unemp < 6.25) => -0.0025803092,
                                         -0.011559953));

N1562_7 :=__common__( if(((real)c_rental < 162.5), -0.00051634946, N1562_8));

N1562_6 :=__common__( if(trim(C_RENTAL) != '', N1562_7, 0.0044707145));

N1562_5 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => 0.00046114572,
               ((integer)f_curraddrburglaryindex_i < 78) => N1562_6,
                                                            0.00046114572));

N1562_4 :=__common__( map(trim(C_NEWHOUSE) = ''      => 0.011698458,
               ((real)c_newhouse < 12.75) => 0.0030590474,
                                             0.011698458));

N1562_3 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1562_4, -0.0013941473));

N1562_2 :=__common__( if(((real)f_corrssnaddrcount_d < 0.5), N1562_3, N1562_5));

N1562_1 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N1562_2, 0.00047146936));

N1563_8 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)    => -0.0047486566,
               ((integer)f_prevaddrmedianincome_d < 43778) => 0.0041135766,
                                                              -0.0047486566));

N1563_7 :=__common__( map(trim(C_CIV_EMP) = ''              => N1563_8,
               ((real)c_civ_emp < 58.4500007629) => -0.0065666921,
                                                    N1563_8));

N1563_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1563_7, -0.0029742462));

N1563_5 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => -0.0030998046,
               ((real)r_l79_adls_per_addr_curr_i < 14.5)  => 0.0069733093,
                                                             -0.0030998046));

N1563_4 :=__common__( map(trim(C_MED_AGE) = ''              => N1563_5,
               ((real)c_med_age < 28.4500007629) => -0.0041785371,
                                                    N1563_5));

N1563_3 :=__common__( map(trim(C_POP_65_74_P) = ''              => N1563_6,
               ((real)c_pop_65_74_p < 3.95000004768) => N1563_4,
                                                        N1563_6));

N1563_2 :=__common__( if(((real)c_hval_150k_p < 14.1499996185), 0.0005283556, N1563_3));

N1563_1 :=__common__( if(trim(C_HVAL_150K_P) != '', N1563_2, 0.0040541978));

N1564_9 :=__common__( map(((real)r_i61_inq_collection_recency_d <= NULL)  => 0.0060458548,
               ((integer)r_i61_inq_collection_recency_d < 549) => -0.00087471337,
                                                                  0.0060458548));

N1564_8 :=__common__( map(trim(C_FAMMAR18_P) = ''              => 0.0025239359,
               ((real)c_fammar18_p < 38.4500007629) => -0.0064620807,
                                                       0.0025239359));

N1564_7 :=__common__( map(trim(C_TOTSALES) = ''       => N1564_9,
               ((real)c_totsales < 2473.5) => N1564_8,
                                              N1564_9));

N1564_6 :=__common__( if(((real)c_span_lang < 105.5), 0.0017527143, N1564_7));

N1564_5 :=__common__( if(trim(C_SPAN_LANG) != '', N1564_6, 0.00043625367));

N1564_4 :=__common__( if(((real)c_inc_35k_p < 20.1500015259), -0.0021255106, 0.0048312051));

N1564_3 :=__common__( if(trim(C_INC_35K_P) != '', N1564_4, 0.0033267336));

N1564_2 :=__common__( if(((real)r_c13_curr_addr_lres_d < 11.5), N1564_3, N1564_5));

N1564_1 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1564_2, -0.0097192095));

N1565_8 :=__common__( map(trim(C_FAMILIES) = ''      => -0.0042350832,
               ((real)c_families < 357.5) => 0.0015123002,
                                             -0.0042350832));

N1565_7 :=__common__( map(trim(C_HOUSINGCPI) = ''              => N1565_8,
               ((real)c_housingcpi < 188.050003052) => 0.0072552946,
                                                       N1565_8));

N1565_6 :=__common__( map(trim(C_LUX_PROD) = ''     => 0.0075514398,
               ((real)c_lux_prod < 48.5) => -0.0034986474,
                                            0.0075514398));

N1565_5 :=__common__( map(trim(C_MED_AGE) = ''              => -0.004600185,
               ((real)c_med_age < 28.4500007629) => N1565_6,
                                                    -0.004600185));

N1565_4 :=__common__( if(((real)r_c12_num_nonderogs_d < 6.5), N1565_5, N1565_7));

N1565_3 :=__common__( if(((real)r_c12_num_nonderogs_d > NULL), N1565_4, 0.0029090921));

N1565_2 :=__common__( if(((real)c_blue_empl < 95.5), N1565_3, 0.0010362813));

N1565_1 :=__common__( if(trim(C_BLUE_EMPL) != '', N1565_2, -0.0035042491));

N1566_8 :=__common__( map(((real)f_prevaddrlenofres_d <= NULL) => -0.0019124311,
               ((real)f_prevaddrlenofres_d < 115.5) => 0.0053083824,
                                                       -0.0019124311));

N1566_7 :=__common__( map(trim(C_POP_45_54_P) = ''              => -0.00034376213,
               ((real)c_pop_45_54_p < 14.4499998093) => N1566_8,
                                                        -0.00034376213));

N1566_6 :=__common__( map(trim(C_BLUE_COL) = ''              => N1566_7,
               ((real)c_blue_col < 15.6499996185) => -0.00035657629,
                                                     N1566_7));

N1566_5 :=__common__( if(((real)f_rel_under25miles_cnt_d < 3.5), -0.0023029905, N1566_6));

N1566_4 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N1566_5, -0.0015423912));

N1566_3 :=__common__( map(trim(C_RNT1000_P) = ''              => -0.0073072707,
               ((real)c_rnt1000_p < 67.0500030518) => N1566_4,
                                                      -0.0073072707));

N1566_2 :=__common__( if(((real)c_ab_av_edu < 164.5), N1566_3, 0.0079002897));

N1566_1 :=__common__( if(trim(C_AB_AV_EDU) != '', N1566_2, 0.0031890207));

N1567_9 :=__common__( if(((real)f_add_input_mobility_index_n < 0.428271770477), -0.002827108, 0.0060193998));

N1567_8 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1567_9, -0.027786722));

N1567_7 :=__common__( map(trim(C_OCCUNIT_P) = ''      => N1567_8,
               ((real)c_occunit_p < 82.25) => -0.0094002065,
                                              N1567_8));

N1567_6 :=__common__( map(trim(C_WORK_HOME) = ''     => 0.0024030683,
               ((real)c_work_home < 94.5) => -0.0025927067,
                                             0.0024030683));

N1567_5 :=__common__( map(trim(C_POP_55_64_P) = ''              => N1567_6,
               ((real)c_pop_55_64_p < 4.05000019073) => -0.0088455844,
                                                        N1567_6));

N1567_4 :=__common__( map(trim(C_FOOD) = ''      => N1567_5,
               ((real)c_food < 30.75) => 0.0010334146,
                                         N1567_5));

N1567_3 :=__common__( map(((real)f_srchvelocityrisktype_i <= NULL) => N1567_7,
               ((real)f_srchvelocityrisktype_i < 7.5)   => N1567_4,
                                                           N1567_7));

N1567_2 :=__common__( if(trim(C_CONSTRUCTION) != '', N1567_3, 0.0023694417));

N1567_1 :=__common__( if(((real)f_srchvelocityrisktype_i > NULL), N1567_2, -0.0016332678));

N1568_8 :=__common__( map((fp_segment in ['3 New DID', '4 Bureau Only', '7 Other'])                   => -0.0034769469,
               (fp_segment in ['1 SSN Prob', '2 NAS 479', '5 Derog', '6 Recent Activity']) => 0.0068487101,
                                                                                              0.0068487101));

N1568_7 :=__common__( map(((real)f_inq_communications_count24_i <= NULL) => -0.0095643709,
               ((real)f_inq_communications_count24_i < 1.5)   => 7.8099034e-005,
                                                                 -0.0095643709));

N1568_6 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => N1568_7,
               ((real)r_c14_addrs_10yr_i < 14.5)  => -3.6085429e-006,
                                                     N1568_7));

N1568_5 :=__common__( if(((real)r_c13_max_lres_d < 12.5), 0.0051179765, N1568_6));

N1568_4 :=__common__( if(((real)r_c13_max_lres_d > NULL), N1568_5, 0.0055137587));

N1568_3 :=__common__( map(trim(C_HH6_P) = ''              => -0.0045271494,
               ((real)c_hh6_p < 9.64999961853) => N1568_4,
                                                  -0.0045271494));

N1568_2 :=__common__( if(((real)c_low_hval < 69.1499938965), N1568_3, N1568_8));

N1568_1 :=__common__( if(trim(C_LOW_HVAL) != '', N1568_2, -0.0014223455));

N1569_8 :=__common__( map(trim(C_SERV_EMPL) = ''      => -0.003474637,
               ((real)c_serv_empl < 139.5) => 0.0073231126,
                                              -0.003474637));

N1569_7 :=__common__( map(((real)f_util_add_input_misc_n <= NULL) => -0.0043241402,
               ((real)f_util_add_input_misc_n < 0.5)   => N1569_8,
                                                          -0.0043241402));

N1569_6 :=__common__( map(trim(C_NEW_HOMES) = ''      => 0.011727036,
               ((real)c_new_homes < 137.5) => 0.0010985653,
                                              0.011727036));

N1569_5 :=__common__( map(trim(C_VACANT_P) = ''              => N1569_6,
               ((real)c_vacant_p < 6.85000038147) => -0.0066586982,
                                                     N1569_6));

N1569_4 :=__common__( if(((real)r_a46_curr_avm_autoval_d < 32889.5), -0.006178293, N1569_5));

N1569_3 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N1569_4, N1569_7));

N1569_2 :=__common__( if(((real)c_hval_125k_p < 15.3500003815), 0.00065507793, N1569_3));

N1569_1 :=__common__( if(trim(C_HVAL_125K_P) != '', N1569_2, -0.0016293771));

N1570_8 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => 0.0028449639,
               ((real)f_mos_inq_banko_cm_fseen_d < 67.5)  => 0.015733197,
                                                             0.0028449639));

N1570_7 :=__common__( map(trim(C_INC_150K_P) = ''              => 0.00010108393,
               ((real)c_inc_150k_p < 1.15000009537) => N1570_8,
                                                       0.00010108393));

N1570_6 :=__common__( map(((real)f_wealth_index_d <= NULL) => N1570_7,
               ((real)f_wealth_index_d < 2.5)   => -0.00079924499,
                                                   N1570_7));

N1570_5 :=__common__( map(((real)r_d32_mos_since_fel_ls_d <= NULL) => N1570_6,
               ((real)r_d32_mos_since_fel_ls_d < 240.5) => -0.0049515008,
                                                           N1570_6));

N1570_4 :=__common__( if(((real)f_rel_criminal_count_i < 0.5), -0.0058877751, N1570_5));

N1570_3 :=__common__( if(((real)f_rel_criminal_count_i > NULL), N1570_4, 0.0070509722));

N1570_2 :=__common__( if(((real)c_inc_200k_p < 1.04999995232), N1570_3, 0.0015663142));

N1570_1 :=__common__( if(trim(C_INC_200K_P) != '', N1570_2, -0.002879569));

N1571_11 :=__common__( if(((real)r_c13_curr_addr_lres_d < 32.5), 0.013318858, -0.00044606531));

N1571_10 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1571_11, -0.035597779));

N1571_9 :=__common__( if(((real)f_rel_under500miles_cnt_d < 6.5), 0.0070500869, -0.0032666509));

N1571_8 :=__common__( if(((real)f_rel_under500miles_cnt_d > NULL), N1571_9, 0.0047400051));

N1571_7 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d < 37.5), 0.008258917, N1571_8));

N1571_6 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N1571_7, 0.0037380252));

N1571_5 :=__common__( map(trim(C_NEW_HOMES) = ''      => N1571_10,
               ((real)c_new_homes < 140.5) => N1571_6,
                                              N1571_10));

N1571_4 :=__common__( if(((real)f_current_count_d < 0.5), 0.0008521796, -0.0015650925));

N1571_3 :=__common__( if(((real)f_current_count_d > NULL), N1571_4, -0.0032963054));

N1571_2 :=__common__( if(((real)c_rnt500_p < 54.4500007629), N1571_3, N1571_5));

N1571_1 :=__common__( if(trim(C_RNT500_P) != '', N1571_2, -0.0034489888));

N1572_10 :=__common__( if(((real)f_prevaddrmedianvalue_d < 127158.5), 0.010431311, -0.0012998882));

N1572_9 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N1572_10, -0.031577686));

N1572_8 :=__common__( map(((real)r_l79_adls_per_addr_c6_i <= NULL) => 0.0090161639,
               ((real)r_l79_adls_per_addr_c6_i < 0.5)   => -0.0011614993,
                                                           0.0090161639));

N1572_7 :=__common__( if(((real)c_hist_addr_match_i < 4.5), -0.0033128658, N1572_8));

N1572_6 :=__common__( if(((real)c_hist_addr_match_i > NULL), N1572_7, 0.0091457496));

N1572_5 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => N1572_6,
               ((real)f_add_input_nhood_vac_pct_i < 0.0127932354808) => -0.010294059,
                                                                        N1572_6));

N1572_4 :=__common__( if(((real)f_add_input_mobility_index_n < 0.413309037685), 0.00020722766, N1572_5));

N1572_3 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1572_4, -0.034891784));

N1572_2 :=__common__( if(((real)c_hval_150k_p < 33.25), N1572_3, N1572_9));

N1572_1 :=__common__( if(trim(C_HVAL_150K_P) != '', N1572_2, -0.0061714839));

N1573_8 :=__common__( map(trim(C_FAMMAR18_P) = ''              => 0.0046619236,
               ((real)c_fammar18_p < 35.3499984741) => -0.0070039404,
                                                       0.0046619236));

N1573_7 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)     => N1573_8,
               ((integer)f_curraddrmedianvalue_d < 226525) => 0.0062685075,
                                                              N1573_8));

N1573_6 :=__common__( map(trim(C_HVAL_400K_P) = ''              => N1573_7,
               ((real)c_hval_400k_p < 2.95000004768) => -0.0035316065,
                                                        N1573_7));

N1573_5 :=__common__( map(((real)f_inq_count24_i <= NULL) => -0.004344115,
               ((real)f_inq_count24_i < 4.5)   => N1573_6,
                                                  -0.004344115));

N1573_4 :=__common__( if(((real)f_curraddrmedianvalue_d < 134653.5), 0.00055936208, N1573_5));

N1573_3 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N1573_4, 0.0070277783));

N1573_2 :=__common__( if(((real)c_hval_400k_p < 40.9500007629), N1573_3, 0.00870603));

N1573_1 :=__common__( if(trim(C_HVAL_400K_P) != '', N1573_2, -0.0013677504));

N1574_9 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => -0.00017859465,
               ((real)f_curraddrcartheftindex_i < 141.5) => -0.0093716558,
                                                            -0.00017859465));

N1574_8 :=__common__( if(((real)f_corraddrnamecount_d < 1.5), N1574_9, 0.00054873271));

N1574_7 :=__common__( if(((real)f_corraddrnamecount_d > NULL), N1574_8, 0.012437373));

N1574_6 :=__common__( map(trim(C_NEW_HOMES) = ''     => 0.0025920511,
               ((real)c_new_homes < 57.5) => 0.014798678,
                                             0.0025920511));

N1574_5 :=__common__( if(((real)r_c13_curr_addr_lres_d < 18.5), -0.00054274125, N1574_6));

N1574_4 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1574_5, 0.012164339));

N1574_3 :=__common__( map(trim(C_FEMDIV_P) = ''              => N1574_7,
               ((real)c_femdiv_p < 2.04999995232) => N1574_4,
                                                     N1574_7));

N1574_2 :=__common__( if(((real)c_highinc < 8.14999961853), N1574_3, -0.0017869761));

N1574_1 :=__common__( if(trim(C_HIGHINC) != '', N1574_2, -0.0010716517));

N1575_9 :=__common__( map(trim(C_TRANSPORT) = ''              => 0.012324946,
               ((real)c_transport < 4.14999961853) => 0.0032607255,
                                                      0.012324946));

N1575_8 :=__common__( if(((real)f_curraddrcartheftindex_i < 155.5), N1575_9, -0.0037295336));

N1575_7 :=__common__( if(((real)f_curraddrcartheftindex_i > NULL), N1575_8, 0.024514969));

N1575_6 :=__common__( map(trim(C_MEDI_INDX) = ''     => 0.0070737849,
               ((real)c_medi_indx < 96.5) => -0.0063385982,
                                             0.0070737849));

N1575_5 :=__common__( map(trim(C_ASSAULT) = ''      => N1575_6,
               ((integer)c_assault < 85) => -0.0081267459,
                                            N1575_6));

N1575_4 :=__common__( if(((real)f_curraddrmurderindex_i < 44.5), N1575_5, 0.00017569501));

N1575_3 :=__common__( if(((real)f_curraddrmurderindex_i > NULL), N1575_4, 0.0055746507));

N1575_2 :=__common__( if(((real)c_inc_100k_p < 16.75), N1575_3, N1575_7));

N1575_1 :=__common__( if(trim(C_INC_100K_P) != '', N1575_2, 0.00063841571));

N1576_8 :=__common__( map(trim(C_HVAL_125K_P) = ''              => 0.00065330203,
               ((real)c_hval_125k_p < 10.7000007629) => -0.0092975121,
                                                        0.00065330203));

N1576_7 :=__common__( map(trim(C_HH5_P) = ''              => -0.0085558977,
               ((real)c_hh5_p < 3.65000009537) => -0.00047832963,
                                                  -0.0085558977));

N1576_6 :=__common__( map(trim(C_PRESCHL) = ''     => -0.00044965361,
               ((real)c_preschl < 92.5) => N1576_7,
                                           -0.00044965361));

N1576_5 :=__common__( map(((real)c_nap_lname_verd_d <= NULL) => 0.00032630678,
               ((real)c_nap_lname_verd_d < 0.5)   => N1576_6,
                                                     0.00032630678));

N1576_4 :=__common__( if(((real)f_add_input_mobility_index_n < 0.642124414444), N1576_5, N1576_8));

N1576_3 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1576_4, -0.034228582));

N1576_2 :=__common__( if(((real)c_hval_80k_p < 40.25), N1576_3, 0.0035771048));

N1576_1 :=__common__( if(trim(C_HVAL_80K_P) != '', N1576_2, 0.0012362304));

N1577_9 :=__common__( map(trim(C_UNEMPL) = ''      => 0.0018663284,
               ((real)c_unempl < 142.5) => -0.0074327397,
                                           0.0018663284));

N1577_8 :=__common__( map(trim(C_HIGHINC) = ''              => 0.0065652196,
               ((real)c_highinc < 4.85000038147) => N1577_9,
                                                    0.0065652196));

N1577_7 :=__common__( if(((real)f_rel_incomeover75_count_d > NULL), N1577_8, -0.010207373));

N1577_6 :=__common__( map(((real)c_addr_lres_6mo_ct_i <= NULL) => -0.0044055743,
               ((real)c_addr_lres_6mo_ct_i < 2.5)   => N1577_7,
                                                       -0.0044055743));

N1577_5 :=__common__( map(((real)f_mos_liens_unrel_lt_fseen_d <= NULL) => N1577_6,
               ((real)f_mos_liens_unrel_lt_fseen_d < 124.5) => 0.0053561098,
                                                               N1577_6));

N1577_4 :=__common__( if(((real)c_pop_25_34_p < 7.75), -0.0073178589, N1577_5));

N1577_3 :=__common__( if(trim(C_POP_25_34_P) != '', N1577_4, -0.0076371416));

N1577_2 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i < 169.5), 0.00010631798, N1577_3));

N1577_1 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N1577_2, -0.0081126889));

N1578_9 :=__common__( if(((real)r_c13_curr_addr_lres_d < 17.5), -0.0016898258, 0.0083791466));

N1578_8 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1578_9, 0.012673155));

N1578_7 :=__common__( map(trim(C_FAMOTF18_P) = ''              => N1578_8,
               ((real)c_famotf18_p < 15.9499998093) => 0.013562073,
                                                       N1578_8));

N1578_6 :=__common__( map(trim(C_MURDERS) = ''      => N1578_7,
               ((integer)c_murders < 65) => -0.0019462751,
                                            N1578_7));

N1578_5 :=__common__( map(trim(C_INC_50K_P) = ''              => N1578_6,
               ((real)c_inc_50k_p < 9.44999980927) => -0.0030510356,
                                                      N1578_6));

N1578_4 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL)  => -0.0040901322,
               ((integer)f_curraddrmurderindex_i < 127) => 0.0026128851,
                                                           -0.0040901322));

N1578_3 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N1578_4, -0.00042283191));

N1578_2 :=__common__( if(((real)c_hh5_p < 13.0500001907), N1578_3, N1578_5));

N1578_1 :=__common__( if(trim(C_HH5_P) != '', N1578_2, -0.004852784));

N1579_8 :=__common__( map(trim(C_MED_YEARBLT) = ''       => 0.014515783,
               ((real)c_med_yearblt < 1970.5) => 0.0038970221,
                                                 0.014515783));

N1579_7 :=__common__( map(trim(C_HVAL_200K_P) = ''               => -0.00094537788,
               ((real)c_hval_200k_p < 0.350000023842) => N1579_8,
                                                         -0.00094537788));

N1579_6 :=__common__( map(trim(C_POP00) = ''      => N1579_7,
               ((real)c_pop00 < 869.5) => -0.0050364959,
                                          N1579_7));

N1579_5 :=__common__( map(trim(C_POP_55_64_P) = ''              => N1579_6,
               ((real)c_pop_55_64_p < 5.44999980927) => 0.008914628,
                                                        N1579_6));

N1579_4 :=__common__( if(((real)c_pop_45_54_p < 17.3499984741), -0.0008334014, N1579_5));

N1579_3 :=__common__( if(trim(C_POP_45_54_P) != '', N1579_4, 0.008277827));

N1579_2 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 6.5), 0.0051327896, N1579_3));

N1579_1 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N1579_2, 0.00045078135));

N1580_8 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => -0.0018691338,
               ((real)r_c10_m_hdr_fs_d < 197.5) => 0.0058192703,
                                                   -0.0018691338));

N1580_7 :=__common__( map(trim(C_HHSIZE) = ''              => N1580_8,
               ((real)c_hhsize < 2.45499992371) => -0.0045838338,
                                                   N1580_8));

N1580_6 :=__common__( map(trim(C_BUSINESS) = ''     => 0.0074050171,
               ((real)c_business < 31.5) => N1580_7,
                                            0.0074050171));

N1580_5 :=__common__( map(trim(C_LAR_FAM) = ''      => 0.0086268984,
               ((real)c_lar_fam < 145.5) => N1580_6,
                                            0.0086268984));

N1580_4 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i < 1163.5), N1580_5, -0.0051557356));

N1580_3 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i > NULL), N1580_4, 0.018561691));

N1580_2 :=__common__( if(((real)c_serv_empl < 172.5), -0.00073021311, N1580_3));

N1580_1 :=__common__( if(trim(C_SERV_EMPL) != '', N1580_2, 0.00057881424));

N1581_8 :=__common__( map((segment in ['SEARS FLS', 'SEARS SHO'])        => -0.0041820816,
               (segment in ['KMART', 'RETAIL', 'SEARS AUTO']) => 0.0035651439,
                                                                 0.0035651439));

N1581_7 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => N1581_8,
               ((real)f_srchfraudsrchcount_i < 18.5)  => -0.0055836644,
                                                         N1581_8));

N1581_6 :=__common__( map(trim(C_EMPLOYEES) = ''     => N1581_7,
               ((real)c_employees < 21.5) => -0.0079278742,
                                             N1581_7));

N1581_5 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => N1581_6,
               ((real)f_srchssnsrchcount_i < 13.5)  => 0.0012558979,
                                                       N1581_6));

N1581_4 :=__common__( if(((real)c_occunit_p < 94.25), N1581_5, -0.0019777717));

N1581_3 :=__common__( if(trim(C_OCCUNIT_P) != '', N1581_4, -0.00089886639));

N1581_2 :=__common__( if(((real)f_rel_ageover30_count_d < 33.5), N1581_3, -0.006119032));

N1581_1 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N1581_2, -0.001102337));

N1582_9 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => -0.0027354341,
               ((real)f_m_bureau_adl_fs_all_d < 253.5) => 0.0093362443,
                                                          -0.0027354341));

N1582_8 :=__common__( if(((real)c_hh2_p < 23.25), 0.015182752, N1582_9));

N1582_7 :=__common__( if(trim(C_HH2_P) != '', N1582_8, -0.028803537));

N1582_6 :=__common__( map(trim(C_ROBBERY) = ''      => 0.0039705093,
               ((real)c_robbery < 163.5) => -0.0044871578,
                                            0.0039705093));

N1582_5 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => N1582_6,
               ((real)f_mos_inq_banko_om_lseen_d < 12.5)  => -0.0087992087,
                                                             N1582_6));

N1582_4 :=__common__( if(((real)c_rnt500_p < 58.4500007629), 8.8037238e-005, N1582_5));

N1582_3 :=__common__( if(trim(C_RNT500_P) != '', N1582_4, 0.00079404663));

N1582_2 :=__common__( if(((real)r_d31_attr_bankruptcy_recency_d < 79.5), N1582_3, N1582_7));

N1582_1 :=__common__( if(((real)r_d31_attr_bankruptcy_recency_d > NULL), N1582_2, 0.0089510572));

N1583_8 :=__common__( map(trim(C_BURGLARY) = ''      => 0.0032919746,
               ((integer)c_burglary < 96) => -0.0034315204,
                                             0.0032919746));

N1583_7 :=__common__( map(trim(C_HIGH_HVAL) = ''              => 0.011449462,
               ((real)c_high_hval < 6.35000038147) => N1583_8,
                                                      0.011449462));

N1583_6 :=__common__( map(trim(C_TRAILER_P) = ''              => -0.0012405898,
               ((real)c_trailer_p < 13.3500003815) => N1583_7,
                                                      -0.0012405898));

N1583_5 :=__common__( map(trim(C_FAMOTF18_P) = ''              => N1583_6,
               ((real)c_famotf18_p < 3.34999990463) => -0.0073489431,
                                                       N1583_6));

N1583_4 :=__common__( if(((real)f_srchssnsrchcount_i < 19.5), N1583_5, -0.0035419565));

N1583_3 :=__common__( if(((real)f_srchssnsrchcount_i > NULL), N1583_4, -0.013723023));

N1583_2 :=__common__( if(((real)c_vacant_p < 11.4499998093), -0.0012471482, N1583_3));

N1583_1 :=__common__( if(trim(C_VACANT_P) != '', N1583_2, -0.0006253494));

N1584_8 :=__common__( if(((real)r_d30_derog_count_i < 4.5), 0.0016629716, -0.0077137245));

N1584_7 :=__common__( if(((real)r_d30_derog_count_i > NULL), N1584_8, 0.029634209));

N1584_6 :=__common__( map(trim(C_TOTSALES) = ''       => -0.0022738164,
               ((real)c_totsales < 1337.5) => 0.0039328285,
                                              -0.0022738164));

N1584_5 :=__common__( map(trim(C_HVAL_40K_P) = ''              => -0.0058611078,
               ((real)c_hval_40k_p < 21.6500015259) => N1584_6,
                                                       -0.0058611078));

N1584_4 :=__common__( map(trim(C_INC_75K_P) = ''              => 0.0057770147,
               ((real)c_inc_75k_p < 14.6499996185) => N1584_5,
                                                      0.0057770147));

N1584_3 :=__common__( map(trim(C_MED_HHINC) = ''         => N1584_7,
               ((integer)c_med_hhinc < 44909) => N1584_4,
                                                 N1584_7));

N1584_2 :=__common__( if(((real)c_families < 276.5), N1584_3, -0.00072292793));

N1584_1 :=__common__( if(trim(C_FAMILIES) != '', N1584_2, 0.0025124204));

N1585_7 :=__common__( map(trim(C_EMPLOYEES) = ''     => -0.0089588074,
               ((real)c_employees < 86.5) => 0.0041850043,
                                             -0.0089588074));

N1585_6 :=__common__( map(trim(C_MED_AGE) = ''              => N1585_7,
               ((real)c_med_age < 44.6500015259) => 0.0034648457,
                                                    N1585_7));

N1585_5 :=__common__( map(trim(C_RENTOCC_P) = ''              => -0.013576901,
               ((real)c_rentocc_p < 57.4000015259) => -0.0026858598,
                                                      -0.013576901));

N1585_4 :=__common__( map(trim(C_POP_0_5_P) = ''      => -0.0005487336,
               ((real)c_pop_0_5_p < 11.75) => N1585_5,
                                              -0.0005487336));

N1585_3 :=__common__( map(trim(C_CARTHEFT) = ''      => N1585_4,
               ((real)c_cartheft < 190.5) => -0.00010532535,
                                             N1585_4));

N1585_2 :=__common__( if(((real)c_pop_85p_p < 2.45000004768), N1585_3, N1585_6));

N1585_1 :=__common__( if(trim(C_POP_85P_P) != '', N1585_2, 0.0040339047));

N1586_7 :=__common__( map(trim(C_HVAL_300K_P) = ''              => -0.0036788675,
               ((real)c_hval_300k_p < 6.64999961853) => 0.007879568,
                                                        -0.0036788675));

N1586_6 :=__common__( map(trim(C_RICH_WHT) = ''      => 0.010639357,
               ((real)c_rich_wht < 165.5) => 0.00045119438,
                                             0.010639357));

N1586_5 :=__common__( map(trim(C_RURAL_P) = ''              => -0.0076219881,
               ((real)c_rural_p < 4.35000038147) => N1586_6,
                                                    -0.0076219881));

N1586_4 :=__common__( map(trim(C_RNT1000_P) = ''              => N1586_5,
               ((real)c_rnt1000_p < 29.0499992371) => 0.012432435,
                                                      N1586_5));

N1586_3 :=__common__( map(trim(C_RNT1000_P) = ''              => N1586_4,
               ((real)c_rnt1000_p < 26.8499984741) => -0.00077540939,
                                                      N1586_4));

N1586_2 :=__common__( if(((real)c_employees < 2930.5), N1586_3, N1586_7));

N1586_1 :=__common__( if(trim(C_EMPLOYEES) != '', N1586_2, 1.4765361e-005));

N1587_8 :=__common__( map(trim(C_SERV_EMPL) = ''      => 0.0026882601,
               ((real)c_serv_empl < 171.5) => -0.0058716839,
                                              0.0026882601));

N1587_7 :=__common__( map(trim(C_BORN_USA) = ''      => N1587_8,
               ((real)c_born_usa < 176.5) => -0.00029809341,
                                             N1587_8));

N1587_6 :=__common__( map(trim(C_RENTOCC_P) = ''              => -0.0095885082,
               ((real)c_rentocc_p < 77.4499969482) => N1587_7,
                                                      -0.0095885082));

N1587_5 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => -0.0035278908,
               ((real)f_mos_inq_banko_cm_lseen_d < 70.5)  => 0.0050604224,
                                                             -0.0035278908));

N1587_4 :=__common__( if(((real)c_exp_prod < 21.5), N1587_5, N1587_6));

N1587_3 :=__common__( if(trim(C_EXP_PROD) != '', N1587_4, -0.0015833793));

N1587_2 :=__common__( if(((real)r_mos_since_paw_fseen_d < 67.5), N1587_3, 0.0055000991));

N1587_1 :=__common__( if(((real)r_mos_since_paw_fseen_d > NULL), N1587_2, 0.00019425809));

N1588_8 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => -0.0066884147,
               ((real)r_c14_addrs_15yr_i < 20.5)  => 0.0012694713,
                                                     -0.0066884147));

N1588_7 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)    => -0.0026604126,
               ((integer)f_curraddrmedianvalue_d < 27342) => 0.0045491332,
                                                             -0.0026604126));

N1588_6 :=__common__( map(((real)r_d32_mos_since_fel_ls_d <= NULL)  => N1588_7,
               ((integer)r_d32_mos_since_fel_ls_d < 175) => 0.0049720257,
                                                            N1588_7));

N1588_5 :=__common__( map(((real)f_srchfraudsrchcountyr_i <= NULL) => 0.0054419146,
               ((real)f_srchfraudsrchcountyr_i < 5.5)   => N1588_6,
                                                           0.0054419146));

N1588_4 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.00664121750742), -0.010499583, N1588_5));

N1588_3 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1588_4, -0.0040606868));

N1588_2 :=__common__( if(((integer)f_prevaddrmedianvalue_d < 87853), N1588_3, N1588_8));

N1588_1 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N1588_2, -0.010084481));

N1589_10 :=__common__( if(((real)c_bel_edu < 138.5), 0.011118867, -0.00013106187));

N1589_9 :=__common__( if(trim(C_BEL_EDU) != '', N1589_10, 0.01101963));

N1589_8 :=__common__( map(trim(C_WHITE_COL) = ''              => 0.0073762847,
               ((real)c_white_col < 40.0499992371) => 0.00058038999,
                                                      0.0073762847));

N1589_7 :=__common__( if(((real)c_born_usa < 106.5), -0.0013290055, N1589_8));

N1589_6 :=__common__( if(trim(C_BORN_USA) != '', N1589_7, 0.00012664938));

N1589_5 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => 0.0080753161,
               ((real)f_m_bureau_adl_fs_all_d < 366.5) => N1589_6,
                                                          0.0080753161));

N1589_4 :=__common__( if(((real)f_inq_other_count24_i < 5.5), N1589_5, -0.0067072583));

N1589_3 :=__common__( if(((real)f_inq_other_count24_i > NULL), N1589_4, -0.00069855669));

N1589_2 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => N1589_9,
               ((real)f_inq_adls_per_phone_i < 1.5)   => N1589_3,
                                                         N1589_9));

N1589_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), -0.00058165386, N1589_2));

N1590_8 :=__common__( map(trim(C_BARGAINS) = ''      => -0.0039380375,
               ((real)c_bargains < 125.5) => 0.0049792034,
                                             -0.0039380375));

N1590_7 :=__common__( map(trim(C_INC_50K_P) = ''              => N1590_8,
               ((real)c_inc_50k_p < 13.4499998093) => -0.0072879767,
                                                      N1590_8));

N1590_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.143859431148), N1590_7, 0.001099433));

N1590_5 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1590_6, -0.0017720579));

N1590_4 :=__common__( map(trim(C_HH5_P) = ''      => 0.0109505,
               ((real)c_hh5_p < 16.25) => 0.0018021686,
                                          0.0109505));

N1590_3 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => N1590_5,
               ((real)f_curraddrburglaryindex_i < 134.5) => N1590_4,
                                                            N1590_5));

N1590_2 :=__common__( if(((integer)f_addrchangeincomediff_d < 32498), N1590_3, -0.0056065147));

N1590_1 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1590_2, -0.00042202507));

N1591_9 :=__common__( map(trim(C_RENTOCC_P) = ''              => 0.004441764,
               ((real)c_rentocc_p < 35.6500015259) => -0.0042290638,
                                                      0.004441764));

N1591_8 :=__common__( map(trim(C_RNT750_P) = ''              => N1591_9,
               ((real)c_rnt750_p < 17.8499984741) => 0.0095206702,
                                                     N1591_9));

N1591_7 :=__common__( map(trim(C_OLD_HOMES) = ''     => N1591_8,
               ((real)c_old_homes < 45.5) => -0.0057747982,
                                             N1591_8));

N1591_6 :=__common__( if(((real)f_prevaddrlenofres_d < 4.5), 0.0092957867, N1591_7));

N1591_5 :=__common__( if(((real)f_prevaddrlenofres_d > NULL), N1591_6, 0.0035628888));

N1591_4 :=__common__( if(((real)c_cpiall < 209.300003052), N1591_5, -0.00070258481));

N1591_3 :=__common__( if(trim(C_CPIALL) != '', N1591_4, -0.0006621998));

N1591_2 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => -0.00078476801,
               ((real)f_curraddrmurderindex_i < 28.5)  => 0.007259419,
                                                          -0.00078476801));

N1591_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N1591_2, N1591_3));

N1592_10 :=__common__( map(((real)f_mos_liens_unrel_sc_fseen_d <= NULL) => 0.00087161092,
                ((real)f_mos_liens_unrel_sc_fseen_d < 61.5)  => -0.0081982762,
                                                                0.00087161092));

N1592_9 :=__common__( map(trim(C_FAMMAR_P) = ''              => -0.002222866,
               ((real)c_fammar_p < 46.0499992371) => -0.01124294,
                                                     -0.002222866));

N1592_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0187764056027), N1592_9, N1592_10));

N1592_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1592_8, -0.0019090101));

N1592_6 :=__common__( if(((real)c_incollege < 6.05000019073), 0.0013495416, N1592_7));

N1592_5 :=__common__( if(trim(C_INCOLLEGE) != '', N1592_6, -0.0003706944));

N1592_4 :=__common__( if(((real)c_retired < 13.25), -0.0081032751, 0.0026708866));

N1592_3 :=__common__( if(trim(C_RETIRED) != '', N1592_4, -0.018048946));

N1592_2 :=__common__( if(((integer)r_i60_inq_auto_recency_d < 9), N1592_3, N1592_5));

N1592_1 :=__common__( if(((real)r_i60_inq_auto_recency_d > NULL), N1592_2, -0.00037730361));

N1593_8 :=__common__( map(trim(C_CARTHEFT) = ''      => 0.010820317,
               ((real)c_cartheft < 179.5) => 0.00027761654,
                                             0.010820317));

N1593_7 :=__common__( map(trim(C_HVAL_200K_P) = ''              => 0.015029653,
               ((real)c_hval_200k_p < 6.35000038147) => N1593_8,
                                                        0.015029653));

N1593_6 :=__common__( map(trim(C_LAR_FAM) = ''      => -0.00010396149,
               ((real)c_lar_fam < 125.5) => N1593_7,
                                            -0.00010396149));

N1593_5 :=__common__( map(((real)f_idverrisktype_i <= NULL) => -0.00021263497,
               ((real)f_idverrisktype_i < 2.5)   => N1593_6,
                                                    -0.00021263497));

N1593_4 :=__common__( if(((real)c_relig_indx < 164.5), N1593_5, -0.0034268009));

N1593_3 :=__common__( if(trim(C_RELIG_INDX) != '', N1593_4, 0.0044499237));

N1593_2 :=__common__( if(((real)f_util_adl_count_n < 5.5), -0.00060851912, N1593_3));

N1593_1 :=__common__( if(((real)f_util_adl_count_n > NULL), N1593_2, -0.0039062276));

N1594_7 :=__common__( map((fp_segment in ['2 NAS 479', '4 Bureau Only', '7 Other'])                   => 0.00084778296,
               (fp_segment in ['1 SSN Prob', '3 New DID', '5 Derog', '6 Recent Activity']) => 0.011725494,
                                                                                              0.011725494));

N1594_6 :=__common__( map(trim(C_CONSTRUCTION) = ''              => -0.0027628142,
               ((real)c_construction < 7.14999961853) => N1594_7,
                                                         -0.0027628142));

N1594_5 :=__common__( if(((real)f_liens_unrel_cj_total_amt_i < 430.5), N1594_6, -0.0045899084));

N1594_4 :=__common__( if(((real)f_liens_unrel_cj_total_amt_i > NULL), N1594_5, -0.030243714));

N1594_3 :=__common__( if(((integer)c_rich_old < 100), N1594_4, 0.01063352));

N1594_2 :=__common__( if(trim(C_RICH_OLD) != '', N1594_3, -0.013442262));

N1594_1 :=__common__( map(((real)c_inf_lname_verd_d <= NULL) => N1594_2,
               ((real)c_inf_lname_verd_d < 0.5)   => -0.00015583339,
                                                     N1594_2));

N1595_8 :=__common__( map(trim(C_HOUSINGCPI) = ''              => -0.00029116012,
               ((real)c_housingcpi < 213.100006104) => -0.008627234,
                                                       -0.00029116012));

N1595_7 :=__common__( map(trim(C_POP_12_17_P) = ''              => 0.0042889269,
               ((real)c_pop_12_17_p < 11.4499998093) => N1595_8,
                                                        0.0042889269));

N1595_6 :=__common__( map(trim(C_INC_15K_P) = ''              => -0.00093074761,
               ((real)c_inc_15k_p < 10.5500001907) => 0.0073010686,
                                                      -0.00093074761));

N1595_5 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i < 161.5), N1595_6, 0.008087305));

N1595_4 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N1595_5, -0.010629649));

N1595_3 :=__common__( map(((real)f_inq_dobs_per_ssn_i <= NULL) => N1595_7,
               ((real)f_inq_dobs_per_ssn_i < 0.5)   => N1595_4,
                                                       N1595_7));

N1595_2 :=__common__( if(((real)c_pop_55_64_p < 6.75), N1595_3, -0.00067488574));

N1595_1 :=__common__( if(trim(C_POP_55_64_P) != '', N1595_2, 0.00090613615));

N1596_9 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => -0.0062882564,
               ((real)f_mos_inq_banko_om_fseen_d < 34.5)  => 0.0043240432,
                                                             -0.0062882564));

N1596_8 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => -0.0019663515,
               ((real)f_curraddrmurderindex_i < 169.5) => 0.0053509897,
                                                          -0.0019663515));

N1596_7 :=__common__( map(trim(C_CONSTRUCTION) = ''              => N1596_9,
               ((real)c_construction < 1.34999990463) => N1596_8,
                                                         N1596_9));

N1596_6 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => N1596_7,
               ((real)f_mos_inq_banko_om_lseen_d < 9.5)   => -0.0056754512,
                                                             N1596_7));

N1596_5 :=__common__( map(trim(C_INC_200K_P) = ''     => 0.001567193,
               ((real)c_inc_200k_p < 0.25) => N1596_6,
                                              0.001567193));

N1596_4 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1596_5, -0.00030272572));

N1596_3 :=__common__( map(((real)f_srchaddrsrchcountwk_i <= NULL) => -0.0048264961,
               ((real)f_srchaddrsrchcountwk_i < 0.5)   => N1596_4,
                                                          -0.0048264961));

N1596_2 :=__common__( if(trim(C_INC_200K_P) != '', N1596_3, 0.00024182889));

N1596_1 :=__common__( if(((real)f_srchaddrsrchcountwk_i > NULL), N1596_2, 0.0082933729));

N1597_9 :=__common__( if(((real)f_rel_ageover20_count_d < 4.5), 0.007582507, -0.00050084587));

N1597_8 :=__common__( if(((real)f_rel_ageover20_count_d > NULL), N1597_9, 0.009374225));

N1597_7 :=__common__( map(trim(C_HH3_P) = ''              => -0.0063833536,
               ((real)c_hh3_p < 15.0500001907) => 0.0060016274,
                                                  -0.0063833536));

N1597_6 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), 0.012365107, 0.0039114174));

N1597_5 :=__common__( if(((real)c_food < 24.75), N1597_6, N1597_7));

N1597_4 :=__common__( if(trim(C_FOOD) != '', N1597_5, 0.010380501));

N1597_3 :=__common__( map(((real)c_nap_addr_verd_d <= NULL) => N1597_8,
               ((real)c_nap_addr_verd_d < 0.5)   => N1597_4,
                                                    N1597_8));

N1597_2 :=__common__( if(((real)r_f03_input_add_not_most_rec_i < 0.5), -0.00068039331, N1597_3));

N1597_1 :=__common__( if(((real)r_f03_input_add_not_most_rec_i > NULL), N1597_2, -0.0030463419));

N1598_8 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)         => 0.010427881,
               ((real)f_add_input_mobility_index_n < 0.37197303772) => 0.00018655446,
                                                                       0.010427881));

N1598_7 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => N1598_8,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0561838038266) => -0.0054619642,
                                                                       N1598_8));

N1598_6 :=__common__( map(trim(C_LOW_ED) = ''              => -0.0042803476,
               ((real)c_low_ed < 57.4500007629) => -0.0144144,
                                                   -0.0042803476));

N1598_5 :=__common__( map(trim(C_ASSAULT) = ''      => N1598_6,
               ((real)c_assault < 117.5) => 0.00062099698,
                                            N1598_6));

N1598_4 :=__common__( if(((real)c_hval_250k_p < 3.65000009537), N1598_5, N1598_7));

N1598_3 :=__common__( if(trim(C_HVAL_250K_P) != '', N1598_4, 0.0064492029));

N1598_2 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.128010988235), 0.00074860258, N1598_3));

N1598_1 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1598_2, -0.00030503722));

N1599_8 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => -0.0015951418,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0589148700237) => -0.011708788,
                                                                       -0.0015951418));

N1599_7 :=__common__( map(((real)r_c14_addrs_15yr_i <= NULL) => -0.0038274228,
               ((real)r_c14_addrs_15yr_i < 6.5)   => 0.0047386919,
                                                     -0.0038274228));

N1599_6 :=__common__( map(trim(C_BARGAINS) = ''      => 0.0064339311,
               ((real)c_bargains < 174.5) => N1599_7,
                                             0.0064339311));

N1599_5 :=__common__( map(trim(C_HVAL_125K_P) = ''               => N1599_6,
               ((real)c_hval_125k_p < 0.949999988079) => -0.0079093378,
                                                         N1599_6));

N1599_4 :=__common__( if(((real)f_curraddrburglaryindex_i < 152.5), N1599_5, N1599_8));

N1599_3 :=__common__( if(((real)f_curraddrburglaryindex_i > NULL), N1599_4, -0.015835603));

N1599_2 :=__common__( if(((real)c_hval_175k_p < 13.6499996185), 0.00046029445, N1599_3));

N1599_1 :=__common__( if(trim(C_HVAL_175K_P) != '', N1599_2, 0.00086275634));

N1600_9 :=__common__( map(trim(C_ROBBERY) = ''      => 0.0013910198,
               ((real)c_robbery < 132.5) => -0.0063661512,
                                            0.0013910198));

N1600_8 :=__common__( if(((real)f_curraddrcrimeindex_i < 175.5), N1600_9, 0.0052507702));

N1600_7 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N1600_8, 0.012023619));

N1600_6 :=__common__( map(trim(C_INC_15K_P) = ''              => -0.0091927403,
               ((real)c_inc_15k_p < 24.8499984741) => N1600_7,
                                                      -0.0091927403));

N1600_5 :=__common__( if(((real)c_inc_50k_p < 16.0499992371), 0.0015419494, N1600_6));

N1600_4 :=__common__( if(trim(C_INC_50K_P) != '', N1600_5, 0.0017946912));

N1600_3 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => -0.003306055,
               ((integer)f_curraddrmurderindex_i < 92) => 0.0040107699,
                                                          -0.003306055));

N1600_2 :=__common__( if(((integer)f_addrchangeincomediff_d < -6975), N1600_3, 0.0010724442));

N1600_1 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1600_2, N1600_4));

N1601_8 :=__common__( map(trim(C_HH1_P) = ''              => 0.0080727434,
               ((real)c_hh1_p < 37.6500015259) => -0.0019205689,
                                                  0.0080727434));

N1601_7 :=__common__( if(((real)f_m_bureau_adl_fs_all_d < 116.5), N1601_8, 0.010932297));

N1601_6 :=__common__( if(((real)f_m_bureau_adl_fs_all_d > NULL), N1601_7, 0.013701708));

N1601_5 :=__common__( map(trim(C_RNT750_P) = ''      => -0.0062439978,
               ((real)c_rnt750_p < 55.75) => N1601_6,
                                             -0.0062439978));

N1601_4 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.0027890367,
               ((real)c_comb_age_d < 29.5)  => N1601_5,
                                               -0.0027890367));

N1601_3 :=__common__( map(trim(C_CONSTRUCTION) = ''              => 0.00012094036,
               ((real)c_construction < 0.15000000596) => 0.0034373721,
                                                         0.00012094036));

N1601_2 :=__common__( if(((real)c_sub_bus < 137.5), N1601_3, N1601_4));

N1601_1 :=__common__( if(trim(C_SUB_BUS) != '', N1601_2, -0.0061567286));

N1602_7 :=__common__( map(trim(C_INC_125K_P) = ''              => -0.0047843242,
               ((real)c_inc_125k_p < 5.44999980927) => 0.0033776664,
                                                       -0.0047843242));

N1602_6 :=__common__( map(trim(C_HVAL_100K_P) = ''               => N1602_7,
               ((real)c_hval_100k_p < 0.850000023842) => 0.0074905556,
                                                         N1602_7));

N1602_5 :=__common__( map(trim(C_APT20) = ''      => 0.0075679683,
               ((real)c_apt20 < 146.5) => -0.0026386331,
                                          0.0075679683));

N1602_4 :=__common__( map(trim(C_POP_12_17_P) = ''      => 0.0093817049,
               ((real)c_pop_12_17_p < 12.25) => N1602_5,
                                                0.0093817049));

N1602_3 :=__common__( map(trim(C_INC_125K_P) = ''              => -0.00078770939,
               ((real)c_inc_125k_p < 1.04999995232) => N1602_4,
                                                       -0.00078770939));

N1602_2 :=__common__( if(((real)c_health < 27.25), N1602_3, N1602_6));

N1602_1 :=__common__( if(trim(C_HEALTH) != '', N1602_2, 0.00044125401));

N1603_8 :=__common__( map(((real)f_componentcharrisktype_i <= NULL) => 0.0065711105,
               ((real)f_componentcharrisktype_i < 7.5)   => -0.00079945317,
                                                            0.0065711105));

N1603_7 :=__common__( map(trim(C_UNEMPL) = ''      => 0.0060705286,
               ((real)c_unempl < 126.5) => -0.0018075082,
                                           0.0060705286));

N1603_6 :=__common__( if(((real)f_srchaddrsrchcount_i < 0.5), N1603_7, N1603_8));

N1603_5 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N1603_6, 0.003934306));

N1603_4 :=__common__( map(trim(C_PROFESSIONAL) = ''              => -0.0073175459,
               ((real)c_professional < 19.0499992371) => N1603_5,
                                                         -0.0073175459));

N1603_3 :=__common__( map(trim(C_PROFESSIONAL) = ''      => 0.006090351,
               ((real)c_professional < 26.25) => N1603_4,
                                                 0.006090351));

N1603_2 :=__common__( if(((integer)c_med_hhinc < 14075), 0.0067091506, N1603_3));

N1603_1 :=__common__( if(trim(C_MED_HHINC) != '', N1603_2, -0.0015237172));

N1604_8 :=__common__( map(trim(C_INC_200K_P) = ''              => -0.0026840953,
               ((real)c_inc_200k_p < 1.95000004768) => -0.0098857122,
                                                       -0.0026840953));

N1604_7 :=__common__( map(trim(C_APT20) = ''     => N1604_8,
               ((real)c_apt20 < 96.5) => -0.0003615385,
                                         N1604_8));

N1604_6 :=__common__( if(((real)f_curraddrmedianvalue_d < 88383.5), -0.0094655741, 0.00099282705));

N1604_5 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N1604_6, -0.029736264));

N1604_4 :=__common__( map(trim(C_TOTSALES) = ''        => -0.0034554716,
               ((real)c_totsales < 45846.5) => 0.0015508697,
                                               -0.0034554716));

N1604_3 :=__common__( map(trim(C_HVAL_100K_P) = ''              => N1604_5,
               ((real)c_hval_100k_p < 38.5499992371) => N1604_4,
                                                        N1604_5));

N1604_2 :=__common__( if(((real)c_inc_125k_p < 7.55000019073), N1604_3, N1604_7));

N1604_1 :=__common__( if(trim(C_INC_125K_P) != '', N1604_2, -7.4853615e-006));

N1605_9 :=__common__( map(trim(C_CONSTRUCTION) = ''              => 0.0094772918,
               ((real)c_construction < 11.9499998093) => -0.00049352542,
                                                         0.0094772918));

N1605_8 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL)  => -0.0049825009,
               ((integer)f_prevaddrmurderindex_i < 145) => N1605_9,
                                                           -0.0049825009));

N1605_7 :=__common__( map(((real)f_divsrchaddrsuspidcount_i <= NULL) => 0.0056591331,
               ((real)f_divsrchaddrsuspidcount_i < 0.5)   => N1605_8,
                                                             0.0056591331));

N1605_6 :=__common__( if(((real)c_femdiv_p < 2.45000004768), 0.0081900932, N1605_7));

N1605_5 :=__common__( if(trim(C_FEMDIV_P) != '', N1605_6, 0.0071580629));

N1605_4 :=__common__( if(((real)r_l79_adls_per_addr_c6_i < 5.5), -0.00097078833, 0.0063249483));

N1605_3 :=__common__( if(((real)r_l79_adls_per_addr_c6_i > NULL), N1605_4, -0.037533689));

N1605_2 :=__common__( map(((real)r_i61_inq_collection_count12_i <= NULL) => N1605_5,
               ((real)r_i61_inq_collection_count12_i < 0.5)   => N1605_3,
                                                                 N1605_5));

N1605_1 :=__common__( if(((real)r_i61_inq_collection_recency_d > NULL), N1605_2, -0.0128142));

N1606_9 :=__common__( map(trim(C_HHSIZE) = ''              => 0.0012409047,
               ((real)c_hhsize < 2.92500019073) => -0.0085352579,
                                                   0.0012409047));

N1606_8 :=__common__( map(trim(C_CHILD) = ''              => N1606_9,
               ((real)c_child < 22.4500007629) => 0.0015242674,
                                                  N1606_9));

N1606_7 :=__common__( if(((real)c_lowinc < 38.6500015259), N1606_8, -0.0002396489));

N1606_6 :=__common__( if(trim(C_LOWINC) != '', N1606_7, -0.012489056));

N1606_5 :=__common__( if(((real)f_inq_per_addr_i < 2.5), -0.00042738137, 0.0029201981));

N1606_4 :=__common__( if(((real)f_inq_per_addr_i > NULL), N1606_5, -0.010326137));

N1606_3 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL) => N1606_6,
               ((real)f_fp_prevaddrburglaryindex_i < 134.5) => N1606_4,
                                                               N1606_6));

N1606_2 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d < 6.5), 0.0055394754, N1606_3));

N1606_1 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N1606_2, -0.0045010404));

N1607_8 :=__common__( map(trim(C_INC_125K_P) = ''              => 0.0084422849,
               ((real)c_inc_125k_p < 4.35000038147) => -0.0015217536,
                                                       0.0084422849));

N1607_7 :=__common__( map(trim(C_TOTCRIME) = ''      => N1607_8,
               ((real)c_totcrime < 174.5) => -0.0043921484,
                                             N1607_8));

N1607_6 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => -0.00017343009,
               ((real)f_mos_inq_banko_om_fseen_d < 31.5)  => 0.0092774663,
                                                             -0.00017343009));

N1607_5 :=__common__( map(trim(C_POP_12_17_P) = ''              => N1607_7,
               ((real)c_pop_12_17_p < 5.94999980927) => N1607_6,
                                                        N1607_7));

N1607_4 :=__common__( if(((real)f_prevaddrcartheftindex_i < 165.5), 0.00074186107, N1607_5));

N1607_3 :=__common__( if(((real)f_prevaddrcartheftindex_i > NULL), N1607_4, -0.0023230677));

N1607_2 :=__common__( if(((real)c_health < 74.1499938965), N1607_3, 0.0059963873));

N1607_1 :=__common__( if(trim(C_HEALTH) != '', N1607_2, 0.0026279417));

N1608_9 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 70.5), 0.00079002115, -0.0092572282));

N1608_8 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N1608_9, -0.015944405));

N1608_7 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => -0.0094124112,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0542999133468) => 0.0053213351,
                                                                       -0.0094124112));

N1608_6 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => N1608_7,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.938184142113) => 0.003850117,
                                                                      N1608_7));

N1608_5 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1608_6, 3.8317514e-005));

N1608_4 :=__common__( map(trim(C_FAMILIES) = ''      => 0.000114232,
               ((real)c_families < 251.5) => N1608_5,
                                             0.000114232));

N1608_3 :=__common__( map(trim(C_INC_15K_P) = ''              => -0.0027007236,
               ((real)c_inc_15k_p < 40.8499984741) => N1608_4,
                                                      -0.0027007236));

N1608_2 :=__common__( if(((real)c_hh6_p < 9.35000038147), N1608_3, N1608_8));

N1608_1 :=__common__( if(trim(C_HH6_P) != '', N1608_2, 0.0017553443));

N1609_8 :=__common__( map(trim(C_HVAL_200K_P) = ''              => -0.0067155741,
               ((real)c_hval_200k_p < 19.1500015259) => 0.0007261814,
                                                        -0.0067155741));

N1609_7 :=__common__( map(trim(C_HVAL_20K_P) = ''              => 0.0068322523,
               ((real)c_hval_20k_p < 15.9499998093) => N1609_8,
                                                       0.0068322523));

N1609_6 :=__common__( map(((real)f_mos_liens_unrel_lt_fseen_d <= NULL) => N1609_7,
               ((real)f_mos_liens_unrel_lt_fseen_d < 79.5)  => 0.0087914,
                                                               N1609_7));

N1609_5 :=__common__( if(((real)f_mos_liens_unrel_lt_fseen_d < 40.5), -0.0067727424, N1609_6));

N1609_4 :=__common__( if(((real)f_mos_liens_unrel_lt_fseen_d > NULL), N1609_5, 0.00676435));

N1609_3 :=__common__( map(trim(C_TOTSALES) = ''       => N1609_4,
               ((real)c_totsales < 3260.5) => -0.0011744202,
                                              N1609_4));

N1609_2 :=__common__( if(((real)c_pop_6_11_p < 13.8500003815), N1609_3, 0.0036603309));

N1609_1 :=__common__( if(trim(C_POP_6_11_P) != '', N1609_2, -0.003394345));

N1610_9 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL)  => -0.007037599,
               ((integer)f_prevaddrcartheftindex_i < 147) => 0.0031288238,
                                                             -0.007037599));

N1610_8 :=__common__( map(trim(C_EMPLOYEES) = ''      => N1610_9,
               ((real)c_employees < 120.5) => 0.0075286359,
                                              N1610_9));

N1610_7 :=__common__( if(((real)c_hh2_p < 22.25), -0.0060123262, N1610_8));

N1610_6 :=__common__( if(trim(C_HH2_P) != '', N1610_7, 0.0003659666));

N1610_5 :=__common__( if(((real)f_rel_homeover200_count_d < 9.5), N1610_6, 0.011825998));

N1610_4 :=__common__( if(((real)f_rel_homeover200_count_d > NULL), N1610_5, -0.0037092737));

N1610_3 :=__common__( map(((real)r_c15_ssns_per_adl_i <= NULL) => N1610_4,
               ((real)r_c15_ssns_per_adl_i < 1.5)   => -0.00058915578,
                                                       N1610_4));

N1610_2 :=__common__( if(((real)r_c20_email_count_i < 12.5), N1610_3, 0.0084674141));

N1610_1 :=__common__( if(((real)r_c20_email_count_i > NULL), N1610_2, -0.0040970006));

N1611_7 :=__common__( map(trim(C_HH3_P) = ''              => -0.0016815969,
               ((real)c_hh3_p < 19.6500015259) => 0.0072509753,
                                                  -0.0016815969));

N1611_6 :=__common__( if(((real)f_college_income_d > NULL), -0.024934184, 0.0055171794));

N1611_5 :=__common__( if(((real)r_f00_dob_score_d > NULL), -0.00051836768, N1611_6));

N1611_4 :=__common__( map(trim(C_FAMOTF18_P) = ''              => N1611_7,
               ((real)c_famotf18_p < 58.6500015259) => N1611_5,
                                                       N1611_7));

N1611_3 :=__common__( map(trim(C_HH7P_P) = ''              => 0.0053023581,
               ((real)c_hh7p_p < 10.0500001907) => N1611_4,
                                                   0.0053023581));

N1611_2 :=__common__( if(((integer)c_burglary < 16), -0.0081882275, N1611_3));

N1611_1 :=__common__( if(trim(C_BURGLARY) != '', N1611_2, -0.0049610578));

N1612_7 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => 0.0087949849,
               ((real)f_m_bureau_adl_fs_all_d < 116.5) => 0.00042419219,
                                                          0.0087949849));

N1612_6 :=__common__( if(((real)f_m_bureau_adl_fs_all_d < 151.5), N1612_7, -0.0048615016));

N1612_5 :=__common__( if(((real)f_m_bureau_adl_fs_all_d > NULL), N1612_6, 0.0052810824));

N1612_4 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.01072318,
               ((real)c_easiqlife < 112.5) => 0.00056119904,
                                              0.01072318));

N1612_3 :=__common__( if(((real)c_retired < 4.75), N1612_4, N1612_5));

N1612_2 :=__common__( if(trim(C_RETIRED) != '', N1612_3, -0.0024721993));

N1612_1 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.00069548309,
               ((real)c_comb_age_d < 28.5)  => N1612_2,
                                               -0.00069548309));

N1613_10 :=__common__( if(((real)f_rel_homeover200_count_d < 0.5), 2.3980299e-006, -0.0082242353));

N1613_9 :=__common__( if(((real)f_rel_homeover200_count_d > NULL), N1613_10, 0.0057224192));

N1613_8 :=__common__( map(((real)c_nap_addr_verd_d <= NULL) => N1613_9,
               ((real)c_nap_addr_verd_d < 0.5)   => 0.0036463434,
                                                    N1613_9));

N1613_7 :=__common__( if(((real)f_srchphonesrchcount_i < 3.5), N1613_8, -0.0074768273));

N1613_6 :=__common__( if(((real)f_srchphonesrchcount_i > NULL), N1613_7, 0.026452824));

N1613_5 :=__common__( map(trim(C_TOTCRIME) = ''      => N1613_6,
               ((real)c_totcrime < 119.5) => -0.01035146,
                                             N1613_6));

N1613_4 :=__common__( map(trim(C_WHITE_COL) = ''              => 0.00068273144,
               ((real)c_white_col < 17.3499984741) => -0.003017413,
                                                      0.00068273144));

N1613_3 :=__common__( if(((real)f_util_adl_count_n > NULL), N1613_4, -0.00068767074));

N1613_2 :=__common__( if(((real)c_born_usa < 179.5), N1613_3, N1613_5));

N1613_1 :=__common__( if(trim(C_BORN_USA) != '', N1613_2, 0.0044142197));

N1614_9 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => -0.0028008848,
               ((real)r_c21_m_bureau_adl_fs_d < 272.5) => 0.0016684974,
                                                          -0.0028008848));

N1614_8 :=__common__( if(((integer)f_curraddrmedianvalue_d < 55163), 0.0049596441, N1614_9));

N1614_7 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N1614_8, 0.0080864666));

N1614_6 :=__common__( map(trim(C_MANY_CARS) = ''     => N1614_7,
               ((real)c_many_cars < 28.5) => -0.0019841658,
                                             N1614_7));

N1614_5 :=__common__( if(((integer)f_prevaddrmedianvalue_d < 145609), -0.0043260749, 0.0017790757));

N1614_4 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N1614_5, 0.001154559));

N1614_3 :=__common__( map(trim(C_CHILD) = ''      => N1614_6,
               ((real)c_child < 21.75) => N1614_4,
                                          N1614_6));

N1614_2 :=__common__( if(((real)c_hhsize < 3.90500020981), N1614_3, -0.0084420629));

N1614_1 :=__common__( if(trim(C_HHSIZE) != '', N1614_2, -0.0010316173));

N1615_8 :=__common__( map(((real)f_corrrisktype_i <= NULL) => 0.0069125738,
               ((real)f_corrrisktype_i < 8.5)   => -0.0013294299,
                                                   0.0069125738));

N1615_7 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => -0.0057160135,
               ((real)f_inq_other_count24_i < 1.5)   => N1615_8,
                                                        -0.0057160135));

N1615_6 :=__common__( map(((real)f_util_add_input_misc_n <= NULL) => 0.00082096007,
               ((real)f_util_add_input_misc_n < 0.5)   => N1615_7,
                                                          0.00082096007));

N1615_5 :=__common__( if(((real)f_rel_homeover150_count_d > NULL), N1615_6, -0.00052817831));

N1615_4 :=__common__( map(trim(C_POP_25_34_P) = ''              => 0.0067687322,
               ((real)c_pop_25_34_p < 28.1500015259) => N1615_5,
                                                        0.0067687322));

N1615_3 :=__common__( map(trim(C_OLDHOUSE) = ''      => N1615_4,
               ((real)c_oldhouse < 20.25) => 0.0050457048,
                                             N1615_4));

N1615_2 :=__common__( if(((real)c_rentocc_p < 83.3500061035), N1615_3, -0.0055745885));

N1615_1 :=__common__( if(trim(C_RENTOCC_P) != '', N1615_2, -0.0018477084));

N1616_9 :=__common__( if(((real)c_fammar18_p < 29.3499984741), -0.008658172, 0.00072395843));

N1616_8 :=__common__( if(trim(C_FAMMAR18_P) != '', N1616_9, 0.0045994735));

N1616_7 :=__common__( map(trim(C_ROBBERY) = ''      => 0.0013947113,
               ((integer)c_robbery < 63) => 0.011475915,
                                            0.0013947113));

N1616_6 :=__common__( map(trim(C_FOOD) = ''              => -0.003727063,
               ((real)c_food < 32.3499984741) => N1616_7,
                                                 -0.003727063));

N1616_5 :=__common__( map(trim(C_WORK_HOME) = ''     => -0.0028092118,
               ((real)c_work_home < 73.5) => N1616_6,
                                             -0.0028092118));

N1616_4 :=__common__( if(((real)c_occunit_p < 91.0500030518), 0.0013811554, N1616_5));

N1616_3 :=__common__( if(trim(C_OCCUNIT_P) != '', N1616_4, 0.0021882359));

N1616_2 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.620858430862), N1616_3, N1616_8));

N1616_1 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1616_2, 0.0010451455));

N1617_9 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d < 112.5), -0.0063684974, 0.0016034594));

N1617_8 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d > NULL), N1617_9, 0.016409539));

N1617_7 :=__common__( map(trim(C_PRESCHL) = ''     => N1617_8,
               ((real)c_preschl < 50.5) => 0.0066348853,
                                           N1617_8));

N1617_6 :=__common__( map(trim(C_POPOVER25) = ''      => -0.0051429749,
               ((real)c_popover25 < 790.5) => N1617_7,
                                              -0.0051429749));

N1617_5 :=__common__( map(trim(C_ASSAULT) = ''      => N1617_6,
               ((real)c_assault < 129.5) => 0.0024905765,
                                            N1617_6));

N1617_4 :=__common__( if(((real)c_inc_201k_p < 2.25), N1617_5, -0.0042496593));

N1617_3 :=__common__( if(trim(C_INC_201K_P) != '', N1617_4, -0.009418048));

N1617_2 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0373503603041), 0.0013697508, N1617_3));

N1617_1 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1617_2, -0.00042544395));

N1618_9 :=__common__( map(trim(C_RAPE) = ''      => 0.0043863692,
               ((real)c_rape < 147.5) => -0.0027345351,
                                         0.0043863692));

N1618_8 :=__common__( if(((real)c_retail < 28.1500015259), N1618_9, -0.0094646646));

N1618_7 :=__common__( if(trim(C_RETAIL) != '', N1618_8, 0.0013516382));

N1618_6 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => 0.0004639679,
               ((real)f_add_input_nhood_vac_pct_i < 0.142579391599) => -0.0085777843,
                                                                       0.0004639679));

N1618_5 :=__common__( map(trim(C_FEMDIV_P) = ''              => -0.0018009002,
               ((real)c_femdiv_p < 8.85000038147) => 0.0017013505,
                                                     -0.0018009002));

N1618_4 :=__common__( if(((real)c_vacant_p < 22.1500015259), N1618_5, N1618_6));

N1618_3 :=__common__( if(trim(C_VACANT_P) != '', N1618_4, -3.1246235e-005));

N1618_2 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d < 0.961106657982), N1618_3, N1618_7));

N1618_1 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d > NULL), N1618_2, -0.001278832));

N1619_9 :=__common__( if(((real)f_assoccredbureaucount_i < 1.5), 0.00052356358, 0.008245188));

N1619_8 :=__common__( if(((real)f_assoccredbureaucount_i > NULL), N1619_9, -0.011042314));

N1619_7 :=__common__( map(trim(C_HVAL_100K_P) = ''      => -0.0031810072,
               ((real)c_hval_100k_p < 16.75) => 0.00094645402,
                                                -0.0031810072));

N1619_6 :=__common__( if(((real)f_rel_count_i < 14.5), 0.00036977808, 0.0068662852));

N1619_5 :=__common__( if(((real)f_rel_count_i > NULL), N1619_6, 0.016416863));

N1619_4 :=__common__( map(trim(C_UNEMPL) = ''      => N1619_7,
               ((real)c_unempl < 107.5) => N1619_5,
                                           N1619_7));

N1619_3 :=__common__( map(trim(C_HH1_P) = ''              => N1619_4,
               ((real)c_hh1_p < 27.0499992371) => -0.0015120548,
                                                  N1619_4));

N1619_2 :=__common__( if(((real)c_rnt250_p < 36.1500015259), N1619_3, N1619_8));

N1619_1 :=__common__( if(trim(C_RNT250_P) != '', N1619_2, -0.00032150421));

N1620_9 :=__common__( if(((real)f_m_bureau_adl_fs_all_d < 347.5), -0.00016360951, -0.0072998069));

N1620_8 :=__common__( if(((real)f_m_bureau_adl_fs_all_d > NULL), N1620_9, -0.00020019493));

N1620_7 :=__common__( map(trim(C_INC_25K_P) = ''              => 0.0087701647,
               ((real)c_inc_25k_p < 11.9499998093) => 0.00078520366,
                                                      0.0087701647));

N1620_6 :=__common__( map(trim(C_INC_100K_P) = ''              => -0.0064098936,
               ((real)c_inc_100k_p < 15.0500001907) => 0.0017537959,
                                                       -0.0064098936));

N1620_5 :=__common__( if(((real)f_rel_educationover12_count_d < 12.5), N1620_6, N1620_7));

N1620_4 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N1620_5, -0.00015776907));

N1620_3 :=__common__( map(trim(C_FAMILIES) = ''      => N1620_8,
               ((real)c_families < 252.5) => N1620_4,
                                             N1620_8));

N1620_2 :=__common__( if(((real)c_med_hval < 40611.5), -0.0051537978, N1620_3));

N1620_1 :=__common__( if(trim(C_MED_HVAL) != '', N1620_2, 0.0021211314));

N1621_9 :=__common__( map(trim(C_HH5_P) = ''              => -0.0071159534,
               ((real)c_hh5_p < 9.05000019073) => -0.00055291202,
                                                  -0.0071159534));

N1621_8 :=__common__( map(((real)f_fp_prevaddrcrimeindex_i <= NULL) => 0.0011084179,
               ((real)f_fp_prevaddrcrimeindex_i < 105.5) => N1621_9,
                                                            0.0011084179));

N1621_7 :=__common__( if(((integer)c_assault < 37), 0.0052169729, N1621_8));

N1621_6 :=__common__( if(trim(C_ASSAULT) != '', N1621_7, 1.8099095e-005));

N1621_5 :=__common__( if(((real)c_femdiv_p < 8.55000019073), -0.0032582251, 0.0031807559));

N1621_4 :=__common__( if(trim(C_FEMDIV_P) != '', N1621_5, -0.0072637435));

N1621_3 :=__common__( map(((real)f_rel_criminal_count_i <= NULL) => N1621_4,
               ((real)f_rel_criminal_count_i < 1.5)   => 0.0045705417,
                                                         N1621_4));

N1621_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 90.5), N1621_3, N1621_6));

N1621_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N1621_2, -0.0020763222));

N1622_8 :=__common__( map(((real)f_srchfraudsrchcountyr_i <= NULL) => 0.00021076149,
               ((real)f_srchfraudsrchcountyr_i < 0.5)   => 0.011138368,
                                                           0.00021076149));

N1622_7 :=__common__( map(trim(C_RNT250_P) = ''              => 0.0010732637,
               ((real)c_rnt250_p < 2.95000004768) => -0.0085274777,
                                                     0.0010732637));

N1622_6 :=__common__( map(trim(C_POP_18_24_P) = ''      => 0.0036850845,
               ((real)c_pop_18_24_p < 12.25) => N1622_7,
                                                0.0036850845));

N1622_5 :=__common__( map(((real)f_util_adl_count_n <= NULL) => 0.0080915985,
               ((real)f_util_adl_count_n < 8.5)   => N1622_6,
                                                     0.0080915985));

N1622_4 :=__common__( if(((real)c_fammar_p < 33.8499984741), N1622_5, -0.00082779111));

N1622_3 :=__common__( if(trim(C_FAMMAR_P) != '', N1622_4, 0.0053398265));

N1622_2 :=__common__( if(((real)f_prevaddrlenofres_d < 191.5), N1622_3, N1622_8));

N1622_1 :=__common__( if(((real)f_prevaddrlenofres_d > NULL), N1622_2, -0.0067753827));

N1623_8 :=__common__( map(trim(C_ASSAULT) = ''     => 0.010081266,
               ((real)c_assault < 97.5) => 0.00052427035,
                                           0.010081266));

N1623_7 :=__common__( map(trim(C_POP_75_84_P) = ''              => 0.0086644866,
               ((real)c_pop_75_84_p < 5.05000019073) => 0.00018075395,
                                                        0.0086644866));

N1623_6 :=__common__( map(((real)f_rel_bankrupt_count_i <= NULL) => -0.0063218849,
               ((real)f_rel_bankrupt_count_i < 7.5)   => -0.00047599559,
                                                         -0.0063218849));

N1623_5 :=__common__( if(((real)c_unique_addr_count_i < 17.5), N1623_6, N1623_7));

N1623_4 :=__common__( if(((real)c_unique_addr_count_i > NULL), N1623_5, -0.0097298975));

N1623_3 :=__common__( map(trim(C_POP_6_11_P) = ''              => N1623_4,
               ((real)c_pop_6_11_p < 2.84999990463) => -0.0075052274,
                                                       N1623_4));

N1623_2 :=__common__( if(((real)c_hval_150k_p < 32.9500007629), N1623_3, N1623_8));

N1623_1 :=__common__( if(trim(C_HVAL_150K_P) != '', N1623_2, -0.0018284546));

N1624_10 :=__common__( if(((real)r_d32_criminal_count_i < 0.5), -0.0027980827, -1.4425673e-005));

N1624_9 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N1624_10, -0.003081023));

N1624_8 :=__common__( if(((real)f_add_input_mobility_index_n < 0.193549543619), 0.0061152214, N1624_9));

N1624_7 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1624_8, -0.033620935));

N1624_6 :=__common__( map(trim(C_TRAILER) = ''      => -0.01137209,
               ((real)c_trailer < 176.5) => -0.001165395,
                                            -0.01137209));

N1624_5 :=__common__( if(((real)f_srchphonesrchcount_i < 4.5), N1624_6, 0.0058343538));

N1624_4 :=__common__( if(((real)f_srchphonesrchcount_i > NULL), N1624_5, -0.0085282642));

N1624_3 :=__common__( map(trim(C_HH00) = ''      => N1624_4,
               ((real)c_hh00 < 586.5) => 0.0032311013,
                                         N1624_4));

N1624_2 :=__common__( if(((real)c_robbery < 93.5), N1624_3, N1624_7));

N1624_1 :=__common__( if(trim(C_ROBBERY) != '', N1624_2, 0.0020043241));

N1625_8 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => 0.0036676381,
               ((real)f_prevaddrmedianincome_d < 32107.5) => -0.00020006362,
                                                             0.0036676381));

N1625_7 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => N1625_8,
               ((real)f_mos_liens_unrel_cj_fseen_d < 46.5)  => -0.0039574048,
                                                               N1625_8));

N1625_6 :=__common__( map(trim(C_CARTHEFT) = ''      => N1625_7,
               ((real)c_cartheft < 144.5) => -0.0013721742,
                                             N1625_7));

N1625_5 :=__common__( map(trim(C_RNT1000_P) = ''              => 0.0044994336,
               ((real)c_rnt1000_p < 48.6500015259) => N1625_6,
                                                      0.0044994336));

N1625_4 :=__common__( if(((real)f_inq_count24_i < 23.5), N1625_5, 0.0053212916));

N1625_3 :=__common__( if(((real)f_inq_count24_i > NULL), N1625_4, -0.011874038));

N1625_2 :=__common__( if(((real)c_rentocc_p < 65.5500030518), N1625_3, -0.0028788997));

N1625_1 :=__common__( if(trim(C_RENTOCC_P) != '', N1625_2, 0.0026231207));

N1626_8 :=__common__( if(((real)f_mos_acc_lseen_d < 44.5), 0.0028755106, -0.00073152714));

N1626_7 :=__common__( if(((real)f_mos_acc_lseen_d > NULL), N1626_8, -0.0024008023));

N1626_6 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL)  => -0.00097039884,
               ((integer)f_curraddrmurderindex_i < 131) => 0.011123234,
                                                           -0.00097039884));

N1626_5 :=__common__( map(trim(C_BARGAINS) = ''     => N1626_7,
               ((real)c_bargains < 22.5) => N1626_6,
                                            N1626_7));

N1626_4 :=__common__( map(trim(C_POP_18_24_P) = ''              => N1626_5,
               ((real)c_pop_18_24_p < 1.45000004768) => 0.0072306303,
                                                        N1626_5));

N1626_3 :=__common__( map(trim(C_POP_35_44_P) = ''              => -0.0057257265,
               ((real)c_pop_35_44_p < 23.6500015259) => N1626_4,
                                                        -0.0057257265));

N1626_2 :=__common__( if(((real)c_mil_emp < 4.55000019073), N1626_3, 0.0052763329));

N1626_1 :=__common__( if(trim(C_MIL_EMP) != '', N1626_2, 0.00054332299));

N1627_8 :=__common__( map(trim(C_HH3_P) = ''              => 0.00018493471,
               ((real)c_hh3_p < 15.1499996185) => 0.0077181995,
                                                  0.00018493471));

N1627_7 :=__common__( map(((real)r_c13_curr_addr_lres_d <= NULL) => 0.003394428,
               ((real)r_c13_curr_addr_lres_d < 13.5)  => -0.0010875815,
                                                         0.003394428));

N1627_6 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 33.5), N1627_7, -0.00096552111));

N1627_5 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N1627_6, 0.0078654962));

N1627_4 :=__common__( map(trim(C_RICH_BLK) = ''      => 0.0069218084,
               ((real)c_rich_blk < 197.5) => N1627_5,
                                             0.0069218084));

N1627_3 :=__common__( map(trim(C_LOWRENT) = ''              => N1627_8,
               ((real)c_lowrent < 82.1499938965) => N1627_4,
                                                    N1627_8));

N1627_2 :=__common__( if(((real)c_pop_45_54_p < 22.25), N1627_3, -0.0049189162));

N1627_1 :=__common__( if(trim(C_POP_45_54_P) != '', N1627_2, -0.0011682641));

N1628_8 :=__common__( map(trim(C_BURGLARY) = ''      => 0.0056014632,
               ((real)c_burglary < 144.5) => -0.0029347719,
                                             0.0056014632));

N1628_7 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => N1628_8,
               ((real)f_mos_inq_banko_om_lseen_d < 16.5)  => -0.0058104421,
                                                             N1628_8));

N1628_6 :=__common__( map(trim(C_FAMMAR18_P) = ''      => 0.013273515,
               ((real)c_fammar18_p < 41.75) => 0.0037144107,
                                               0.013273515));

N1628_5 :=__common__( map(trim(C_BEL_EDU) = ''      => N1628_7,
               ((real)c_bel_edu < 129.5) => N1628_6,
                                            N1628_7));

N1628_4 :=__common__( map(trim(C_POP_65_74_P) = ''              => -0.00013021576,
               ((real)c_pop_65_74_p < 4.05000019073) => N1628_5,
                                                        -0.00013021576));

N1628_3 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => N1628_4,
               ((real)f_rel_felony_count_i < 0.5)   => -0.0012789815,
                                                       N1628_4));

N1628_2 :=__common__( if(trim(C_BEL_EDU) != '', N1628_3, 0.001561997));

N1628_1 :=__common__( if(((real)f_rel_felony_count_i > NULL), N1628_2, 0.0014580696));

N1629_9 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => 0.00095580914,
               ((real)f_mos_inq_banko_cm_fseen_d < 48.5)  => 0.0088648701,
                                                             0.00095580914));

N1629_8 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => N1629_9,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.526058912277) => -0.0038105561,
                                                                      N1629_9));

N1629_7 :=__common__( if(((real)c_femdiv_p < 2.45000004768), 0.0098925463, N1629_8));

N1629_6 :=__common__( if(trim(C_FEMDIV_P) != '', N1629_7, -0.0015488592));

N1629_5 :=__common__( map(trim(C_POP_65_74_P) = ''              => 0.0040485229,
               ((real)c_pop_65_74_p < 11.6499996185) => -0.0022664386,
                                                        0.0040485229));

N1629_4 :=__common__( if(((real)c_hval_300k_p < 4.85000038147), N1629_5, 0.0012752281));

N1629_3 :=__common__( if(trim(C_HVAL_300K_P) != '', N1629_4, -0.0043371153));

N1629_2 :=__common__( if(((real)r_i61_inq_collection_count12_i < 0.5), N1629_3, N1629_6));

N1629_1 :=__common__( if(((real)r_i61_inq_collection_count12_i > NULL), N1629_2, 0.0014647679));

N1630_11 :=__common__( if(((real)c_hval_60k_p < 0.550000011921), 0.0027264239, -0.0021862082));

N1630_10 :=__common__( if(trim(C_HVAL_60K_P) != '', N1630_11, -0.0033231499));

N1630_9 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => -0.00025141507,
               ((real)f_mos_inq_banko_om_lseen_d < 5.5)   => 0.0089393803,
                                                             -0.00025141507));

N1630_8 :=__common__( map(trim(C_POP_45_54_P) = ''      => -0.0021032313,
               ((real)c_pop_45_54_p < 12.25) => N1630_9,
                                                -0.0021032313));

N1630_7 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N1630_8, N1630_10));

N1630_6 :=__common__( if(((real)c_trailer_p < 0.0500000007451), 0.0080733291, -0.0031095606));

N1630_5 :=__common__( if(trim(C_TRAILER_P) != '', N1630_6, -0.0031045951));

N1630_4 :=__common__( map(trim(C_HH7P_P) = ''              => -0.0048728422,
               ((real)c_hh7p_p < 1.34999990463) => 0.005710443,
                                                   -0.0048728422));

N1630_3 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1630_4, N1630_5));

N1630_2 :=__common__( map(((real)c_comb_age_d <= NULL) => N1630_7,
               ((real)c_comb_age_d < 23.5)  => N1630_3,
                                               N1630_7));

N1630_1 :=__common__( if(((real)f_corrssnnamecount_d > NULL), N1630_2, -4.3839165e-005));

N1631_8 :=__common__( map(((real)f_current_count_d <= NULL) => 0.0029761437,
               ((real)f_current_count_d < 1.5)   => -0.0072773806,
                                                    0.0029761437));

N1631_7 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL) => N1631_8,
               ((integer)f_prevaddrcartheftindex_i < 94) => 0.0042517219,
                                                            N1631_8));

N1631_6 :=__common__( map(trim(C_HVAL_20K_P) = ''              => -0.0098684999,
               ((real)c_hval_20k_p < 6.64999961853) => N1631_7,
                                                       -0.0098684999));

N1631_5 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d < 49.5), N1631_6, 0.00033202908));

N1631_4 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d > NULL), N1631_5, 0.0037440705));

N1631_3 :=__common__( map(trim(C_NEW_HOMES) = ''      => -0.0096870577,
               ((real)c_new_homes < 194.5) => N1631_4,
                                              -0.0096870577));

N1631_2 :=__common__( if(((real)c_inc_25k_p < 4.44999980927), 0.0034151169, N1631_3));

N1631_1 :=__common__( if(trim(C_INC_25K_P) != '', N1631_2, -0.0013298042));

N1632_9 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => 0.010434835,
               ((real)c_dist_best_to_prev_addr_i < 22.5)  => 0.0034220428,
                                                             0.010434835));

N1632_8 :=__common__( if(((real)r_c13_curr_addr_lres_d < 24.5), N1632_9, 0.00096506015));

N1632_7 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1632_8, -0.02857165));

N1632_6 :=__common__( map(trim(C_NEWHOUSE) = ''               => N1632_7,
               ((real)c_newhouse < 0.350000023842) => -0.00087661912,
                                                      N1632_7));

N1632_5 :=__common__( map(trim(C_INC_25K_P) = ''              => N1632_6,
               ((real)c_inc_25k_p < 12.0500001907) => -0.00053932195,
                                                      N1632_6));

N1632_4 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => -0.00075787904,
               ((real)f_mos_inq_banko_om_fseen_d < 27.5)  => -0.0088231281,
                                                             -0.00075787904));

N1632_3 :=__common__( map(((real)f_mos_liens_unrel_sc_fseen_d <= NULL) => N1632_5,
               ((real)f_mos_liens_unrel_sc_fseen_d < 104.5) => N1632_4,
                                                               N1632_5));

N1632_2 :=__common__( if(trim(C_INC_25K_P) != '', N1632_3, 0.0040250201));

N1632_1 :=__common__( if(((real)f_mos_liens_unrel_sc_fseen_d > NULL), N1632_2, 0.0034222802));

N1633_9 :=__common__( map(trim(C_HH3_P) = ''              => 0.0095251431,
               ((real)c_hh3_p < 20.8499984741) => -0.00028302197,
                                                  0.0095251431));

N1633_8 :=__common__( map(((real)f_rel_under500miles_cnt_d <= NULL) => N1633_9,
               ((real)f_rel_under500miles_cnt_d < 10.5)  => -0.0036938964,
                                                            N1633_9));

N1633_7 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)         => 0.0082252978,
               ((real)f_add_input_mobility_index_n < 0.59153676033) => N1633_8,
                                                                       0.0082252978));

N1633_6 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 6.5), N1633_7, -0.0055944752));

N1633_5 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N1633_6, -0.0080660906));

N1633_4 :=__common__( if(((real)c_child < 24.25), N1633_5, 0.00042626557));

N1633_3 :=__common__( if(trim(C_CHILD) != '', N1633_4, -0.0017343838));

N1633_2 :=__common__( if(((integer)r_i60_inq_retail_recency_d < 9), 0.0070210443, N1633_3));

N1633_1 :=__common__( if(((real)r_i60_inq_retail_recency_d > NULL), N1633_2, -0.0059892928));

N1634_9 :=__common__( if(((real)c_families < 385.5), -0.0087037229, 0.0016238078));

N1634_8 :=__common__( if(trim(C_FAMILIES) != '', N1634_9, -0.0077136536));

N1634_7 :=__common__( if(((real)c_hval_40k_p < 28.1500015259), 0.0009080524, -0.0041871456));

N1634_6 :=__common__( if(trim(C_HVAL_40K_P) != '', N1634_7, 0.0057428403));

N1634_5 :=__common__( map(((real)r_s65_ssn_problem_i <= NULL) => -0.0068055394,
               ((real)r_s65_ssn_problem_i < 0.5)   => N1634_6,
                                                      -0.0068055394));

N1634_4 :=__common__( map(((real)r_c18_inv_add_per_adl_c6_i <= NULL) => N1634_8,
               ((real)r_c18_inv_add_per_adl_c6_i < 0.5)   => N1634_5,
                                                             N1634_8));

N1634_3 :=__common__( map(((real)f_addrchangeecontrajindex_d <= NULL) => 0.0023671791,
               ((real)f_addrchangeecontrajindex_d < 1.5)   => -0.0081289638,
                                                              0.0023671791));

N1634_2 :=__common__( map(((real)r_i60_inq_retail_recency_d <= NULL) => N1634_4,
               ((real)r_i60_inq_retail_recency_d < 61.5)  => N1634_3,
                                                             N1634_4));

N1634_1 :=__common__( if(((real)f_inq_retail_count24_i > NULL), N1634_2, 0.0017249909));

N1635_9 :=__common__( map(trim(C_HVAL_40K_P) = ''              => -0.0069871872,
               ((real)c_hval_40k_p < 22.1500015259) => 0.0011451498,
                                                       -0.0069871872));

N1635_8 :=__common__( map(trim(C_UNEMP) = ''              => 0.0039771846,
               ((real)c_unemp < 6.64999961853) => -0.0058858624,
                                                  0.0039771846));

N1635_7 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.389028191566), N1635_8, -0.0081306352));

N1635_6 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1635_7, 0.00013359543));

N1635_5 :=__common__( map(trim(C_POP_55_64_P) = ''              => N1635_9,
               ((real)c_pop_55_64_p < 5.94999980927) => N1635_6,
                                                        N1635_9));

N1635_4 :=__common__( if(((real)c_incollege < 3.75), 0.002341166, N1635_5));

N1635_3 :=__common__( if(trim(C_INCOLLEGE) != '', N1635_4, -0.0020263252));

N1635_2 :=__common__( if(((real)r_c20_email_domain_free_count_i < 3.5), N1635_3, -0.0025832637));

N1635_1 :=__common__( if(((real)r_c20_email_domain_free_count_i > NULL), N1635_2, -0.0049284759));

N1636_9 :=__common__( if(((real)r_c13_curr_addr_lres_d < 38.5), -0.0091556284, 0.001223357));

N1636_8 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1636_9, 0.018322554));

N1636_7 :=__common__( map(trim(C_EXP_PROD) = ''     => -0.00031501943,
               ((real)c_exp_prod < 27.5) => N1636_8,
                                            -0.00031501943));

N1636_6 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.297627151012), -0.0021500258, 0.0080225186));

N1636_5 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1636_6, 0.021047009));

N1636_4 :=__common__( map(trim(C_TOTSALES) = ''        => N1636_5,
               ((real)c_totsales < 32478.5) => 0.00045824988,
                                               N1636_5));

N1636_3 :=__common__( map(trim(C_HH6_P) = ''              => N1636_7,
               ((real)c_hh6_p < 1.84999990463) => N1636_4,
                                                  N1636_7));

N1636_2 :=__common__( if(((real)c_health < 86.6499938965), N1636_3, -0.0065460119));

N1636_1 :=__common__( if(trim(C_HEALTH) != '', N1636_2, 0.0016970393));

N1637_8 :=__common__( map(trim(C_SPAN_LANG) = ''     => -0.001714126,
               ((real)c_span_lang < 94.5) => 0.0031432321,
                                             -0.001714126));

N1637_7 :=__common__( map(trim(C_RNT500_P) = ''              => -0.0065223508,
               ((real)c_rnt500_p < 56.8499984741) => N1637_8,
                                                     -0.0065223508));

N1637_6 :=__common__( map(((real)r_d33_eviction_count_i <= NULL) => 0.0064532271,
               ((real)r_d33_eviction_count_i < 6.5)   => N1637_7,
                                                         0.0064532271));

N1637_5 :=__common__( map(trim(C_TRAILER_P) = ''              => 0.0057577957,
               ((real)c_trailer_p < 7.64999961853) => N1637_6,
                                                      0.0057577957));

N1637_4 :=__common__( if(((real)r_c14_addrs_15yr_i < 11.5), -0.00050649804, N1637_5));

N1637_3 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N1637_4, -0.0018554452));

N1637_2 :=__common__( if(((real)c_rnt1500_p < 29.8499984741), N1637_3, -0.0091884514));

N1637_1 :=__common__( if(trim(C_RNT1500_P) != '', N1637_2, -0.0024749078));

N1638_9 :=__common__( if(((real)c_low_ed < 84.3500061035), -8.526818e-005, -0.0079833661));

N1638_8 :=__common__( if(trim(C_LOW_ED) != '', N1638_9, -7.9671918e-005));

N1638_7 :=__common__( map(trim(C_INC_125K_P) = ''     => 0.010771246,
               ((real)c_inc_125k_p < 4.25) => -0.00077305294,
                                              0.010771246));

N1638_6 :=__common__( map(trim(C_HVAL_250K_P) = ''              => -0.0020463349,
               ((real)c_hval_250k_p < 7.44999980927) => N1638_7,
                                                        -0.0020463349));

N1638_5 :=__common__( if(((real)c_ownocc_p < 26.75), 0.011069183, N1638_6));

N1638_4 :=__common__( if(trim(C_OWNOCC_P) != '', N1638_5, -0.015817185));

N1638_3 :=__common__( map(((real)r_i60_inq_hiriskcred_count12_i <= NULL) => -0.0052061842,
               ((real)r_i60_inq_hiriskcred_count12_i < 2.5)   => N1638_4,
                                                                 -0.0052061842));

N1638_2 :=__common__( if(((real)f_mos_liens_unrel_lt_lseen_d < 135.5), N1638_3, N1638_8));

N1638_1 :=__common__( if(((real)f_mos_liens_unrel_lt_lseen_d > NULL), N1638_2, 0.012513123));

N1639_10 :=__common__( if(((real)c_no_labfor < 161.5), 0.0014325919, -0.0041272892));

N1639_9 :=__common__( if(trim(C_NO_LABFOR) != '', N1639_10, 0.002753423));

N1639_8 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.0391603708267), 0.001430083, 0.013114539));

N1639_7 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1639_8, 0.015476017));

N1639_6 :=__common__( map(trim(C_MED_AGE) = ''      => N1639_7,
               ((real)c_med_age < 35.75) => -0.00033615156,
                                            N1639_7));

N1639_5 :=__common__( map(trim(C_RURAL_P) = ''              => N1639_6,
               ((real)c_rural_p < 23.9500007629) => 0.00036305443,
                                                    N1639_6));

N1639_4 :=__common__( map(((real)r_c13_curr_addr_lres_d <= NULL) => -0.0031024716,
               ((real)r_c13_curr_addr_lres_d < 84.5)  => N1639_5,
                                                         -0.0031024716));

N1639_3 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1639_4, N1639_9));

N1639_2 :=__common__( if(((real)f_sourcerisktype_i < 2.5), -0.0056495486, N1639_3));

N1639_1 :=__common__( if(((real)f_sourcerisktype_i > NULL), N1639_2, 0.0032372284));

N1640_11 :=__common__( if(((real)f_bus_name_nover_i < 0.5), 0.003901788, -0.0025531866));

N1640_10 :=__common__( if(((real)f_bus_name_nover_i > NULL), N1640_11, -0.039888076));

N1640_9 :=__common__( map(((real)c_addr_lres_12mo_ct_i <= NULL) => -0.0018548428,
               ((real)c_addr_lres_12mo_ct_i < 9.5)   => 0.0081941237,
                                                        -0.0018548428));

N1640_8 :=__common__( if(((real)c_robbery < 160.5), N1640_9, -0.0061237505));

N1640_7 :=__common__( if(trim(C_ROBBERY) != '', N1640_8, 0.020332269));

N1640_6 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N1640_7, N1640_10));

N1640_5 :=__common__( map(trim(C_BORN_USA) = ''      => 0.0042816537,
               ((real)c_born_usa < 193.5) => -0.00096620819,
                                             0.0042816537));

N1640_4 :=__common__( if(((real)c_rentocc_p < 77.8500061035), N1640_5, -0.0077597645));

N1640_3 :=__common__( if(trim(C_RENTOCC_P) != '', N1640_4, -0.0058160915));

N1640_2 :=__common__( if(((real)f_util_adl_count_n < 6.5), N1640_3, N1640_6));

N1640_1 :=__common__( if(((real)f_util_adl_count_n > NULL), N1640_2, -0.0023343268));

N1641_8 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => -0.00064316719,
               ((real)f_m_bureau_adl_fs_all_d < 226.5) => -0.005625665,
                                                          -0.00064316719));

N1641_7 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => -0.003714557,
               ((real)f_rel_felony_count_i < 2.5)   => 0.005902575,
                                                       -0.003714557));

N1641_6 :=__common__( map(trim(C_CHILD) = ''              => N1641_8,
               ((real)c_child < 23.6500015259) => N1641_7,
                                                  N1641_8));

N1641_5 :=__common__( map(((real)f_divaddrsuspidcountnew_i <= NULL) => 0.0028289907,
               ((real)f_divaddrsuspidcountnew_i < 0.5)   => -0.00033607793,
                                                            0.0028289907));

N1641_4 :=__common__( if(((real)f_rel_count_i < 21.5), N1641_5, N1641_6));

N1641_3 :=__common__( if(((real)f_rel_count_i > NULL), N1641_4, 0.0030378721));

N1641_2 :=__common__( if(((real)c_no_car < 194.5), N1641_3, 0.0071277915));

N1641_1 :=__common__( if(trim(C_NO_CAR) != '', N1641_2, 0.0012550927));

N1642_9 :=__common__( if(((real)c_families < 133.5), -0.0084839005, -0.00076642188));

N1642_8 :=__common__( if(trim(C_FAMILIES) != '', N1642_9, 0.00098945077));

N1642_7 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => 0.0013667577,
               ((real)f_mos_liens_unrel_cj_fseen_d < 41.5)  => 0.0087464382,
                                                               0.0013667577));

N1642_6 :=__common__( if(((real)c_inc_125k_p < 3.65000009537), 0.0054369468, -0.004392098));

N1642_5 :=__common__( if(trim(C_INC_125K_P) != '', N1642_6, 0.006171439));

N1642_4 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => N1642_5,
               ((real)f_mos_inq_banko_om_lseen_d < 29.5)  => -0.0071900848,
                                                             N1642_5));

N1642_3 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => N1642_7,
               ((real)r_c13_max_lres_d < 51.5)  => N1642_4,
                                                   N1642_7));

N1642_2 :=__common__( if(((integer)f_prevaddrmedianincome_d < 30928), N1642_3, N1642_8));

N1642_1 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N1642_2, -0.0061535174));

N1643_8 :=__common__( map(trim(C_FOR_SALE) = ''       => 0.0019454587,
               ((integer)c_for_sale < 112) => -0.011066518,
                                              0.0019454587));

N1643_7 :=__common__( map(trim(C_LAR_FAM) = ''     => 0.0097544065,
               ((real)c_lar_fam < 90.5) => 0.0013077411,
                                           0.0097544065));

N1643_6 :=__common__( if(((real)r_c20_email_domain_free_count_i < 0.5), -0.00098630688, N1643_7));

N1643_5 :=__common__( if(((real)r_c20_email_domain_free_count_i > NULL), N1643_6, 0.020536467));

N1643_4 :=__common__( map(trim(C_TRAILER) = ''      => -0.0065866525,
               ((real)c_trailer < 148.5) => N1643_5,
                                            -0.0065866525));

N1643_3 :=__common__( map(trim(C_HVAL_100K_P) = ''              => N1643_4,
               ((real)c_hval_100k_p < 26.8499984741) => -0.0005389574,
                                                        N1643_4));

N1643_2 :=__common__( if(((real)c_retail < 42.1500015259), N1643_3, N1643_8));

N1643_1 :=__common__( if(trim(C_RETAIL) != '', N1643_2, -4.5667884e-005));

N1644_8 :=__common__( map(trim(C_HH2_P) = ''      => -0.0013092668,
               ((real)c_hh2_p < 34.75) => -0.0097814144,
                                          -0.0013092668));

N1644_7 :=__common__( map(trim(C_SERV_EMPL) = ''     => N1644_8,
               ((real)c_serv_empl < 59.5) => 0.0017823529,
                                             N1644_8));

N1644_6 :=__common__( map(((real)f_assocsuspicousidcount_i <= NULL) => 0.0074301261,
               ((real)f_assocsuspicousidcount_i < 16.5)  => 0.00027982867,
                                                            0.0074301261));

N1644_5 :=__common__( if(((real)f_inq_highriskcredit_count24_i < 7.5), N1644_6, -0.0031839871));

N1644_4 :=__common__( if(((real)f_inq_highriskcredit_count24_i > NULL), N1644_5, 0.0078469298));

N1644_3 :=__common__( map(trim(C_VERY_RICH) = ''      => 0.0081810821,
               ((real)c_very_rich < 191.5) => N1644_4,
                                              0.0081810821));

N1644_2 :=__common__( if(((real)c_many_cars < 137.5), N1644_3, N1644_7));

N1644_1 :=__common__( if(trim(C_MANY_CARS) != '', N1644_2, 0.0026423622));

N1645_7 :=__common__( map(trim(C_POPOVER18) = ''      => 0.0019289905,
               ((real)c_popover18 < 753.5) => -0.007595748,
                                              0.0019289905));

N1645_6 :=__common__( map(trim(C_BLUE_COL) = ''              => 0.0026373289,
               ((real)c_blue_col < 6.55000019073) => -0.004029559,
                                                     0.0026373289));

N1645_5 :=__common__( map(trim(C_RNT500_P) = ''              => N1645_7,
               ((real)c_rnt500_p < 62.1500015259) => N1645_6,
                                                     N1645_7));

N1645_4 :=__common__( map(trim(C_INC_50K_P) = ''              => -0.002318663,
               ((real)c_inc_50k_p < 22.0499992371) => N1645_5,
                                                      -0.002318663));

N1645_3 :=__common__( map(trim(C_NEW_HOMES) = ''      => -0.00095220754,
               ((real)c_new_homes < 137.5) => N1645_4,
                                              -0.00095220754));

N1645_2 :=__common__( if(((real)c_hh4_p < 31.25), N1645_3, -0.0067023591));

N1645_1 :=__common__( if(trim(C_HH4_P) != '', N1645_2, -0.0044565197));

N1646_10 :=__common__( if(((real)c_inc_25k_p < 24.75), 0.0037290319, -0.0042309454));

N1646_9 :=__common__( if(trim(C_INC_25K_P) != '', N1646_10, -0.0064651305));

N1646_8 :=__common__( if(((real)c_occunit_p < 87.3500061035), -0.010624098, -0.0013741416));

N1646_7 :=__common__( if(trim(C_OCCUNIT_P) != '', N1646_8, -0.00095462153));

N1646_6 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => N1646_7,
               ((real)f_curraddrcartheftindex_i < 157.5) => 0.0014484563,
                                                            N1646_7));

N1646_5 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => N1646_9,
               ((real)f_add_input_nhood_vac_pct_i < 0.0664853453636) => N1646_6,
                                                                        N1646_9));

N1646_4 :=__common__( if(((real)f_rel_educationover8_count_d < 36.5), N1646_5, -0.0075385465));

N1646_3 :=__common__( if(((real)f_rel_educationover8_count_d > NULL), N1646_4, 0.00098251189));

N1646_2 :=__common__( if(((real)r_l79_adls_per_addr_curr_i < 5.5), N1646_3, -0.0013088337));

N1646_1 :=__common__( if(((real)r_l79_adls_per_addr_curr_i > NULL), N1646_2, -0.0054528322));

N1647_7 :=__common__( map(((real)f_addrchangecrimediff_i <= NULL) => 0.013160209,
               ((real)f_addrchangecrimediff_i < -8.5)  => -7.181956e-005,
                                                          0.013160209));

N1647_6 :=__common__( map(trim(C_MED_RENT) = ''      => N1647_7,
               ((real)c_med_rent < 579.5) => 0.00064133185,
                                             N1647_7));

N1647_5 :=__common__( map(trim(C_EASIQLIFE) = ''      => -0.0028606062,
               ((real)c_easiqlife < 121.5) => N1647_6,
                                              -0.0028606062));

N1647_4 :=__common__( map(trim(C_VERY_RICH) = ''      => 0.0060247855,
               ((real)c_very_rich < 103.5) => N1647_5,
                                              0.0060247855));

N1647_3 :=__common__( map(trim(C_NO_TEENS) = ''      => -0.0018093159,
               ((real)c_no_teens < 113.5) => N1647_4,
                                             -0.0018093159));

N1647_2 :=__common__( if(((integer)f_addrchangeincomediff_d < 15852), N1647_3, -0.0022768269));

N1647_1 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1647_2, -0.00015245726));

N1648_11 :=__common__( if(((real)c_professional < 6.75), -0.0036039266, 0.0037559662));

N1648_10 :=__common__( if(trim(C_PROFESSIONAL) != '', N1648_11, -0.014792566));

N1648_9 :=__common__( if(((real)f_util_adl_count_n < 1.5), N1648_10, 0.0012295499));

N1648_8 :=__common__( if(((real)f_util_adl_count_n > NULL), N1648_9, -0.0086614535));

N1648_7 :=__common__( if(((real)c_inc_75k_p < 17.4500007629), 0.013945869, 0.0017826377));

N1648_6 :=__common__( if(trim(C_INC_75K_P) != '', N1648_7, -0.028924892));

N1648_5 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)    => N1648_6,
               ((integer)f_curraddrmedianincome_d < 37650) => -0.0018579958,
                                                              N1648_6));

N1648_4 :=__common__( map(((real)f_srchfraudsrchcountyr_i <= NULL) => N1648_5,
               ((real)f_srchfraudsrchcountyr_i < 2.5)   => -0.0019097415,
                                                           N1648_5));

N1648_3 :=__common__( if(((real)f_util_adl_count_n < 0.5), 0.0043477762, N1648_4));

N1648_2 :=__common__( if(((real)f_util_adl_count_n > NULL), N1648_3, -0.012462813));

N1648_1 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1648_2, N1648_8));

N1649_9 :=__common__( if(((real)f_addrchangecrimediff_i < 37.5), 0.0010164124, -0.0074880813));

N1649_8 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N1649_9, -0.0019979645));

N1649_7 :=__common__( map(trim(C_SFDU_P) = ''              => 0.0070820438,
               ((real)c_sfdu_p < 90.9499969482) => N1649_8,
                                                   0.0070820438));

N1649_6 :=__common__( map(trim(C_RAPE) = ''      => 0.0060267672,
               ((real)c_rape < 174.5) => N1649_7,
                                         0.0060267672));

N1649_5 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)   => N1649_6,
               ((real)f_prevaddrmedianvalue_d < 69439.5) => -0.003468686,
                                                            N1649_6));

N1649_4 :=__common__( if(((real)c_med_hhinc < 51996.5), N1649_5, -0.0038677895));

N1649_3 :=__common__( if(trim(C_MED_HHINC) != '', N1649_4, -0.0026005713));

N1649_2 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 43.5), N1649_3, 0.0009301831));

N1649_1 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N1649_2, 0.00091206548));

N1650_8 :=__common__( map(trim(C_SERV_EMPL) = ''      => 0.0043572352,
               ((real)c_serv_empl < 135.5) => -0.0065456577,
                                              0.0043572352));

N1650_7 :=__common__( map(trim(C_BEL_EDU) = ''      => N1650_8,
               ((real)c_bel_edu < 139.5) => -0.0096365442,
                                            N1650_8));

N1650_6 :=__common__( map(trim(C_CONSTRUCTION) = ''     => 0.00085958475,
               ((real)c_construction < 4.75) => N1650_7,
                                                0.00085958475));

N1650_5 :=__common__( map(((real)f_sourcerisktype_i <= NULL) => N1650_6,
               ((real)f_sourcerisktype_i < 4.5)   => 0.001951901,
                                                     N1650_6));

N1650_4 :=__common__( if(((real)c_bargains < 191.5), N1650_5, -0.0083527079));

N1650_3 :=__common__( if(trim(C_BARGAINS) != '', N1650_4, -0.010609112));

N1650_2 :=__common__( if(((real)f_rel_criminal_count_i < 6.5), 0.00097329775, N1650_3));

N1650_1 :=__common__( if(((real)f_rel_criminal_count_i > NULL), N1650_2, -0.0034269525));

N1651_10 :=__common__( map(trim(C_HH6_P) = ''     => 0.0097400308,
                ((real)c_hh6_p < 1.75) => 0.0020654725,
                                          0.0097400308));

N1651_9 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0144665511325), 0.0083474252, -0.0018763011));

N1651_8 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1651_9, 0.002804455));

N1651_7 :=__common__( if(((real)c_bargains < 144.5), N1651_8, N1651_10));

N1651_6 :=__common__( if(trim(C_BARGAINS) != '', N1651_7, 0.004434801));

N1651_5 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => N1651_6,
               ((real)r_c13_avg_lres_d < 67.5)  => -0.00079724817,
                                                   N1651_6));

N1651_4 :=__common__( if(((real)c_child < 26.0499992371), 0.00060757976, -0.0089170859));

N1651_3 :=__common__( if(trim(C_CHILD) != '', N1651_4, -0.018495126));

N1651_2 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.00954816769809), N1651_3, N1651_5));

N1651_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1651_2, 0.0010139308));

N1652_9 :=__common__( map(trim(C_UNEMP) = ''              => -0.010622657,
               ((real)c_unemp < 4.85000038147) => -0.001406091,
                                                  -0.010622657));

N1652_8 :=__common__( map(trim(C_RNT1000_P) = ''      => 0.0025762501,
               ((real)c_rnt1000_p < 24.25) => N1652_9,
                                              0.0025762501));

N1652_7 :=__common__( map(trim(C_HH00) = ''      => N1652_8,
               ((real)c_hh00 < 480.5) => 0.0048487226,
                                         N1652_8));

N1652_6 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d < 80.5), -0.0087707026, N1652_7));

N1652_5 :=__common__( if(((real)f_mos_liens_unrel_cj_fseen_d > NULL), N1652_6, -0.0077387858));

N1652_4 :=__common__( if(((real)f_curraddrburglaryindex_i < 191.5), 0.00065897573, -0.0036096213));

N1652_3 :=__common__( if(((real)f_curraddrburglaryindex_i > NULL), N1652_4, 0.0018731835));

N1652_2 :=__common__( if(((real)c_rich_blk < 180.5), N1652_3, N1652_5));

N1652_1 :=__common__( if(trim(C_RICH_BLK) != '', N1652_2, 0.0013456518));

N1653_11 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0801280140877), 0.0024447671, -0.0052510681));

N1653_10 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1653_11, -0.020869734));

N1653_9 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1653_10, 0.0052650586));

N1653_8 :=__common__( map(trim(C_RETAIL) = ''              => -0.0070344188,
               ((real)c_retail < 13.6499996185) => N1653_9,
                                                   -0.0070344188));

N1653_7 :=__common__( map(trim(C_CHILD) = ''              => N1653_8,
               ((real)c_child < 30.3499984741) => 0.0015170504,
                                                  N1653_8));

N1653_6 :=__common__( if(((real)c_wholesale < 7.85000038147), N1653_7, 0.0056942965));

N1653_5 :=__common__( if(trim(C_WHOLESALE) != '', N1653_6, 0.0062669428));

N1653_4 :=__common__( if(((real)f_addrchangevaluediff_d < 699.5), -0.003973825, 0.0016099196));

N1653_3 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1653_4, -0.00053853606));

N1653_2 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i < 113.5), N1653_3, N1653_5));

N1653_1 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i > NULL), N1653_2, 0.0074120811));

N1654_11 :=__common__( if(((real)f_rel_incomeover50_count_d < 0.5), 0.0023146938, -0.0059369061));

N1654_10 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N1654_11, -0.0055866693));

N1654_9 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL) => 0.0048366897,
               ((real)f_fp_prevaddrburglaryindex_i < 186.5) => N1654_10,
                                                               0.0048366897));

N1654_8 :=__common__( if(((real)c_hh4_p < 18.25), N1654_9, 0.002495698));

N1654_7 :=__common__( if(trim(C_HH4_P) != '', N1654_8, 0.0092312856));

N1654_6 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0377727486193), 0.0087973731, 0.0010198264));

N1654_5 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1654_6, 0.01902494));

N1654_4 :=__common__( if(((real)c_oldhouse < 334.450012207), 2.406431e-005, N1654_5));

N1654_3 :=__common__( if(trim(C_OLDHOUSE) != '', N1654_4, 0.0045515695));

N1654_2 :=__common__( if(((real)f_srchaddrsrchcount_i < 14.5), N1654_3, N1654_7));

N1654_1 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N1654_2, -0.0012066859));

N1655_8 :=__common__( map(((real)f_util_adl_count_n <= NULL) => 0.0095113392,
               ((real)f_util_adl_count_n < 4.5)   => -0.00086427405,
                                                     0.0095113392));

N1655_7 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL) => -0.0025290552,
               ((real)f_prevaddrcartheftindex_i < 72.5)  => -0.012026604,
                                                            -0.0025290552));

N1655_6 :=__common__( map(trim(C_LOWRENT) = ''              => N1655_7,
               ((real)c_lowrent < 3.04999995232) => 0.00064356159,
                                                    N1655_7));

N1655_5 :=__common__( if(((real)c_hval_400k_p < 12.5500001907), 1.3444701e-005, N1655_6));

N1655_4 :=__common__( if(trim(C_HVAL_400K_P) != '', N1655_5, 0.0057294005));

N1655_3 :=__common__( map(((real)f_liens_rel_cj_total_amt_i <= NULL) => N1655_8,
               ((real)f_liens_rel_cj_total_amt_i < 840.5) => N1655_4,
                                                             N1655_8));

N1655_2 :=__common__( if(((real)f_mos_liens_unrel_lt_lseen_d < 21.5), 0.0056603635, N1655_3));

N1655_1 :=__common__( if(((real)f_mos_liens_unrel_lt_lseen_d > NULL), N1655_2, 0.0019177764));

N1656_7 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => -0.012260096,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.909251689911) => 0.0014736581,
                                                                      -0.012260096));

N1656_6 :=__common__( map(trim(C_URBAN_P) = ''     => N1656_7,
               ((real)c_urban_p < 0.25) => 0.0029609468,
                                           N1656_7));

N1656_5 :=__common__( map(trim(C_LOW_HVAL) = ''      => N1656_6,
               ((real)c_low_hval < 24.75) => -0.0095001083,
                                             N1656_6));

N1656_4 :=__common__( map(trim(C_ROBBERY) = ''      => 8.426237e-005,
               ((integer)c_robbery < 73) => -0.0040128543,
                                            8.426237e-005));

N1656_3 :=__common__( map(trim(C_LARCENY) = ''     => N1656_4,
               ((real)c_larceny < 86.5) => 0.0021803411,
                                           N1656_4));

N1656_2 :=__common__( if(((real)c_trailer_p < 25.5499992371), N1656_3, N1656_5));

N1656_1 :=__common__( if(trim(C_TRAILER_P) != '', N1656_2, -0.0021871662));

N1657_10 :=__common__( if(((real)r_c20_email_domain_free_count_i < 0.5), 0.011084675, 0.00095613822));

N1657_9 :=__common__( if(((real)r_c20_email_domain_free_count_i > NULL), N1657_10, -0.028938511));

N1657_8 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => -0.0094974311,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.959930181503) => -0.00037815659,
                                                                      -0.0094974311));

N1657_7 :=__common__( map(((real)f_mos_liens_unrel_cj_lseen_d <= NULL) => N1657_8,
               ((real)f_mos_liens_unrel_cj_lseen_d < 19.5)  => 0.0065061378,
                                                               N1657_8));

N1657_6 :=__common__( map(trim(C_EASIQLIFE) = ''     => N1657_7,
               ((real)c_easiqlife < 70.5) => -0.0053892793,
                                             N1657_7));

N1657_5 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), -0.0022128592, N1657_6));

N1657_4 :=__common__( map(trim(C_RICH_FAM) = ''      => 0.00043436368,
               ((integer)c_rich_fam < 41) => N1657_5,
                                             0.00043436368));

N1657_3 :=__common__( if(((real)f_srchfraudsrchcount_i > NULL), N1657_4, 0.00068559815));

N1657_2 :=__common__( if(((real)c_trailer_p < 39.1500015259), N1657_3, N1657_9));

N1657_1 :=__common__( if(trim(C_TRAILER_P) != '', N1657_2, -0.0014738284));

N1658_9 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => 0.0081773746,
               ((real)f_srchfraudsrchcount_i < 4.5)   => -0.0011163361,
                                                         0.0081773746));

N1658_8 :=__common__( map(((real)f_add_curr_nhood_bus_pct_i <= NULL)           => 0.011643568,
               ((real)f_add_curr_nhood_bus_pct_i < 0.0608819276094) => N1658_9,
                                                                       0.011643568));

N1658_7 :=__common__( map(((real)f_corraddrnamecount_d <= NULL) => -0.00013576452,
               ((real)f_corraddrnamecount_d < 6.5)   => N1658_8,
                                                        -0.00013576452));

N1658_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1658_7, -0.0050132639));

N1658_5 :=__common__( map(trim(C_INCOLLEGE) = ''     => -0.002654423,
               ((real)c_incollege < 8.75) => N1658_6,
                                             -0.002654423));

N1658_4 :=__common__( if(((real)c_inc_150k_p < 4.44999980927), N1658_5, -0.0036175402));

N1658_3 :=__common__( if(trim(C_INC_150K_P) != '', N1658_4, -0.0066969021));

N1658_2 :=__common__( if(((real)f_prevaddrmedianincome_d < 19906.5), N1658_3, -0.00055459619));

N1658_1 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N1658_2, 0.00037536143));

N1659_9 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)    => 0.0017093065,
               ((real)f_curraddrmedianvalue_d < 108257.5) => 0.011913346,
                                                             0.0017093065));

N1659_8 :=__common__( map(((real)f_prevaddrlenofres_d <= NULL) => 0.00046812961,
               ((real)f_prevaddrlenofres_d < 21.5)  => N1659_9,
                                                       0.00046812961));

N1659_7 :=__common__( map(trim(C_HH2_P) = ''      => -0.00065219827,
               ((real)c_hh2_p < 24.25) => N1659_8,
                                          -0.00065219827));

N1659_6 :=__common__( if(((real)c_fammar_p < 19.1500015259), -0.0057740406, N1659_7));

N1659_5 :=__common__( if(trim(C_FAMMAR_P) != '', N1659_6, 0.0027669886));

N1659_4 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), -0.00025380644, N1659_5));

N1659_3 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => 0.0052263854,
               ((real)r_c21_m_bureau_adl_fs_d < 342.5) => N1659_4,
                                                          0.0052263854));

N1659_2 :=__common__( if(((real)r_d31_mostrec_bk_i < 1.5), N1659_3, -0.0035679813));

N1659_1 :=__common__( if(((real)r_d31_mostrec_bk_i > NULL), N1659_2, -0.0080878623));

N1660_8 :=__common__( map(trim(C_HH00) = ''      => 0.00038598366,
               ((real)c_hh00 < 316.5) => -0.0071518584,
                                         0.00038598366));

N1660_7 :=__common__( map(trim(C_POP_35_44_P) = ''      => 0.010148884,
               ((real)c_pop_35_44_p < 18.75) => 0.0036815995,
                                                0.010148884));

N1660_6 :=__common__( map(trim(C_MED_HHINC) = ''        => N1660_7,
               ((real)c_med_hhinc < 28398.5) => -0.00071817026,
                                                N1660_7));

N1660_5 :=__common__( map(trim(C_AB_AV_EDU) = ''     => N1660_8,
               ((real)c_ab_av_edu < 70.5) => N1660_6,
                                             N1660_8));

N1660_4 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 56.5), -0.00086923218, N1660_5));

N1660_3 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N1660_4, 0.0033939306));

N1660_2 :=__common__( if(((real)c_for_sale < 195.5), N1660_3, -0.0050336918));

N1660_1 :=__common__( if(trim(C_FOR_SALE) != '', N1660_2, -7.852707e-005));

N1661_9 :=__common__( map(trim(C_RETIRED2) = ''     => -0.0039353503,
               ((real)c_retired2 < 85.5) => 0.0052727264,
                                            -0.0039353503));

N1661_8 :=__common__( map(trim(C_HH6_P) = ''              => 0.0063049519,
               ((real)c_hh6_p < 0.15000000596) => N1661_9,
                                                  0.0063049519));

N1661_7 :=__common__( if(((real)f_prevaddrmedianincome_d < 18258.5), 0.011787154, N1661_8));

N1661_6 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N1661_7, -0.0045045321));

N1661_5 :=__common__( map(trim(C_HIGH_ED) = ''              => -0.00096080705,
               ((real)c_high_ed < 12.8500003815) => N1661_6,
                                                    -0.00096080705));

N1661_4 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1661_5, 0.0025243955));

N1661_3 :=__common__( map(trim(C_INC_15K_P) = ''              => -0.0039406216,
               ((real)c_inc_15k_p < 40.1500015259) => N1661_4,
                                                      -0.0039406216));

N1661_2 :=__common__( if(((real)c_hval_60k_p < 11.6499996185), -0.00019595663, N1661_3));

N1661_1 :=__common__( if(trim(C_HVAL_60K_P) != '', N1661_2, -0.0026806374));

N1662_8 :=__common__( map(trim(C_HH4_P) = ''              => -0.00091032471,
               ((real)c_hh4_p < 10.3500003815) => 0.0081717032,
                                                  -0.00091032471));

N1662_7 :=__common__( map(trim(C_RELIG_INDX) = ''      => -0.0079023919,
               ((real)c_relig_indx < 118.5) => 0.0004895259,
                                               -0.0079023919));

N1662_6 :=__common__( map(((real)r_c14_addrs_5yr_i <= NULL) => -0.011386628,
               ((real)r_c14_addrs_5yr_i < 5.5)   => N1662_7,
                                                    -0.011386628));

N1662_5 :=__common__( map(trim(C_RNT500_P) = ''              => 0.0026828393,
               ((real)c_rnt500_p < 51.4500007629) => N1662_6,
                                                     0.0026828393));

N1662_4 :=__common__( if(((real)c_incollege < 7.05000019073), N1662_5, N1662_8));

N1662_3 :=__common__( if(trim(C_INCOLLEGE) != '', N1662_4, 0.0076630431));

N1662_2 :=__common__( if(((integer)r_i60_inq_comm_recency_d < 9), N1662_3, 0.00085065951));

N1662_1 :=__common__( if(((real)r_i60_inq_comm_recency_d > NULL), N1662_2, -0.0037777628));

N1663_9 :=__common__( map(trim(C_HVAL_125K_P) = ''              => -0.00079520855,
               ((real)c_hval_125k_p < 4.64999961853) => -0.0072223413,
                                                        -0.00079520855));

N1663_8 :=__common__( map(((real)f_srchunvrfdaddrcount_i <= NULL) => 0.0044361216,
               ((real)f_srchunvrfdaddrcount_i < 0.5)   => N1663_9,
                                                          0.0044361216));

N1663_7 :=__common__( map(((real)c_unique_addr_count_i <= NULL) => 0.0069114279,
               ((real)c_unique_addr_count_i < 17.5)  => 0.00060546192,
                                                        0.0069114279));

N1663_6 :=__common__( map(((real)f_vardobcount_i <= NULL) => N1663_8,
               ((real)f_vardobcount_i < 1.5)   => N1663_7,
                                                  N1663_8));

N1663_5 :=__common__( if(((real)c_transport < 19.1500015259), N1663_6, -0.0080968104));

N1663_4 :=__common__( if(trim(C_TRANSPORT) != '', N1663_5, -0.0016650122));

N1663_3 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), 6.6853762e-005, N1663_4));

N1663_2 :=__common__( if(((real)r_c14_addrs_15yr_i < 21.5), N1663_3, -0.0071133369));

N1663_1 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N1663_2, 0.0038746632));

N1664_8 :=__common__( map(trim(C_RETIRED2) = ''     => 0.0010657322,
               ((real)c_retired2 < 73.5) => -0.010521905,
                                            0.0010657322));

N1664_7 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => 0.0046411061,
               ((real)r_l79_adls_per_addr_curr_i < 20.5)  => N1664_8,
                                                             0.0046411061));

N1664_6 :=__common__( map(trim(C_HIGH_HVAL) = ''              => 0.0093597719,
               ((real)c_high_hval < 2.84999990463) => N1664_7,
                                                      0.0093597719));

N1664_5 :=__common__( if(((real)f_divaddrsuspidcountnew_i < 1.5), -0.00093418014, N1664_6));

N1664_4 :=__common__( if(((real)f_divaddrsuspidcountnew_i > NULL), N1664_5, 0.00048693015));

N1664_3 :=__common__( map(trim(C_INC_200K_P) = ''                => 0.0072851479,
               ((real)c_inc_200k_p < 0.0500000007451) => -0.0010252326,
                                                         0.0072851479));

N1664_2 :=__common__( if(((real)c_exp_prod < 14.5), N1664_3, N1664_4));

N1664_1 :=__common__( if(trim(C_EXP_PROD) != '', N1664_2, 0.0020680789));

N1665_9 :=__common__( map(trim(C_RNT1000_P) = ''              => -0.00203857,
               ((real)c_rnt1000_p < 18.6500015259) => 0.0075916494,
                                                      -0.00203857));

N1665_8 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL) => -0.0030959681,
               ((real)f_prevaddrcartheftindex_i < 180.5) => N1665_9,
                                                            -0.0030959681));

N1665_7 :=__common__( if(((real)r_a50_pb_total_orders_d < 1.5), -0.00054649416, N1665_8));

N1665_6 :=__common__( if(((real)r_a50_pb_total_orders_d > NULL), N1665_7, 0.0014234434));

N1665_5 :=__common__( map(trim(C_POP_85P_P) = ''              => -0.0089402089,
               ((real)c_pop_85p_p < 2.65000009537) => -0.0018287122,
                                                      -0.0089402089));

N1665_4 :=__common__( if(((real)f_prevaddrmedianvalue_d < 58344.5), 0.0030766667, N1665_5));

N1665_3 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N1665_4, -0.0059487732));

N1665_2 :=__common__( if(((real)c_pop_0_5_p < 5.35000038147), N1665_3, N1665_6));

N1665_1 :=__common__( if(trim(C_POP_0_5_P) != '', N1665_2, 0.00032348553));

N1666_9 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.164658337831), -0.00077056595, -0.0094781658));

N1666_8 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1666_9, 0.00094550672));

N1666_7 :=__common__( map(trim(C_HH2_P) = ''              => 0.010205352,
               ((real)c_hh2_p < 49.6500015259) => 0.00048458428,
                                                  0.010205352));

N1666_6 :=__common__( map(trim(C_POP_12_17_P) = ''              => -0.0049553635,
               ((real)c_pop_12_17_p < 7.64999961853) => 0.0028520642,
                                                        -0.0049553635));

N1666_5 :=__common__( if(((real)c_young < 16.1500015259), N1666_6, N1666_7));

N1666_4 :=__common__( if(trim(C_YOUNG) != '', N1666_5, 0.0044188159));

N1666_3 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => 0.006877126,
               ((real)f_add_curr_nhood_vac_pct_i < 0.231205463409) => N1666_4,
                                                                      0.006877126));

N1666_2 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.27352976799), N1666_3, N1666_8));

N1666_1 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N1666_2, 2.1043041e-007));

N1667_9 :=__common__( if(((real)r_c13_curr_addr_lres_d < 22.5), 0.0088121319, -0.00024440952));

N1667_8 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1667_9, 0.00093959592));

N1667_7 :=__common__( map(trim(C_HH7P_P) = ''              => -0.0067368619,
               ((real)c_hh7p_p < 1.54999995232) => -0.00044173826,
                                                   -0.0067368619));

N1667_6 :=__common__( map(trim(C_HIGH_ED) = ''              => -3.3147021e-005,
               ((real)c_high_ed < 5.35000038147) => N1667_7,
                                                    -3.3147021e-005));

N1667_5 :=__common__( if(((real)f_mos_liens_unrel_ot_lseen_d < 35.5), 0.0071191347, N1667_6));

N1667_4 :=__common__( if(((real)f_mos_liens_unrel_ot_lseen_d > NULL), N1667_5, -0.0065435657));

N1667_3 :=__common__( map(trim(C_NO_LABFOR) = ''      => N1667_8,
               ((real)c_no_labfor < 175.5) => N1667_4,
                                              N1667_8));

N1667_2 :=__common__( if(((integer)c_assault < 13), -0.0080230579, N1667_3));

N1667_1 :=__common__( if(trim(C_ASSAULT) != '', N1667_2, 0.0014428918));

N1668_9 :=__common__( map(trim(C_OLDHOUSE) = ''       => -0.0091291858,
               ((real)c_oldhouse < 158.75) => -0.0019363169,
                                              -0.0091291858));

N1668_8 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 68.5), N1668_9, 0.00037130815));

N1668_7 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N1668_8, -0.010414099));

N1668_6 :=__common__( map(trim(C_LARCENY) = ''       => 0.0049478178,
               ((integer)c_larceny < 189) => N1668_7,
                                             0.0049478178));

N1668_5 :=__common__( map(((real)r_l70_add_standardized_i <= NULL) => N1668_6,
               ((real)r_l70_add_standardized_i < 0.5)   => 0.00096476295,
                                                           N1668_6));

N1668_4 :=__common__( map(trim(C_MED_AGE) = ''              => -0.0081488445,
               ((real)c_med_age < 38.9500007629) => 0.00099120981,
                                                    -0.0081488445));

N1668_3 :=__common__( if(((real)f_historical_count_d > NULL), N1668_4, 0.012462682));

N1668_2 :=__common__( if(((real)c_preschl < 17.5), N1668_3, N1668_5));

N1668_1 :=__common__( if(trim(C_PRESCHL) != '', N1668_2, 0.001854499));

N1669_8 :=__common__( map(trim(C_RNT250_P) = ''               => 0.0073614125,
               ((real)c_rnt250_p < 0.449999988079) => -0.0015293311,
                                                      0.0073614125));

N1669_7 :=__common__( map(trim(C_BLUE_EMPL) = ''     => -0.00052428802,
               ((real)c_blue_empl < 28.5) => -0.0054198757,
                                             -0.00052428802));

N1669_6 :=__common__( map(trim(C_HVAL_100K_P) = ''      => 0.0066695663,
               ((real)c_hval_100k_p < 47.75) => N1669_7,
                                                0.0066695663));

N1669_5 :=__common__( map(trim(C_OWNOCC_P) = ''              => 0.0044321541,
               ((real)c_ownocc_p < 84.5500030518) => N1669_6,
                                                     0.0044321541));

N1669_4 :=__common__( map(((real)f_mos_liens_unrel_sc_fseen_d <= NULL) => N1669_5,
               ((real)f_mos_liens_unrel_sc_fseen_d < 36.5)  => -0.0067620772,
                                                               N1669_5));

N1669_3 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i < 2552.5), N1669_4, N1669_8));

N1669_2 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i > NULL), N1669_3, 0.0017743961));

N1669_1 :=__common__( if(trim(C_OWNOCC_P) != '', N1669_2, 0.0022133048));

N1670_9 :=__common__( if(((real)f_add_input_nhood_vac_pct_i < 0.0585521943867), 0.0079717849, -0.0020143418));

N1670_8 :=__common__( if(((real)f_add_input_nhood_vac_pct_i > NULL), N1670_9, -0.030101793));

N1670_7 :=__common__( map(((real)r_d33_eviction_count_i <= NULL) => N1670_8,
               ((real)r_d33_eviction_count_i < 1.5)   => -0.0025187226,
                                                         N1670_8));

N1670_6 :=__common__( map(trim(C_EASIQLIFE) = ''      => -0.00097603902,
               ((real)c_easiqlife < 125.5) => 0.0016754993,
                                              -0.00097603902));

N1670_5 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => N1670_6,
               ((real)f_m_bureau_adl_fs_all_d < 40.5)  => -0.0058744305,
                                                          N1670_6));

N1670_4 :=__common__( if(((integer)c_med_hval < 371612), N1670_5, 0.0081291253));

N1670_3 :=__common__( if(trim(C_MED_HVAL) != '', N1670_4, 0.0070773436));

N1670_2 :=__common__( if(((integer)r_i60_inq_comm_recency_d < 549), N1670_3, N1670_7));

N1670_1 :=__common__( if(((real)r_i60_inq_comm_recency_d > NULL), N1670_2, -0.0061861514));

N1671_8 :=__common__( map(trim(C_POP_25_34_P) = ''     => -0.0084296498,
               ((real)c_pop_25_34_p < 8.25) => 0.0023477738,
                                               -0.0084296498));

N1671_7 :=__common__( map(trim(C_INC_100K_P) = ''              => 0.0030856205,
               ((real)c_inc_100k_p < 16.0499992371) => -9.7014919e-005,
                                                       0.0030856205));

N1671_6 :=__common__( if(((real)c_pop_55_64_p < 17.4500007629), N1671_7, N1671_8));

N1671_5 :=__common__( if(trim(C_POP_55_64_P) != '', N1671_6, 0.00067263384));

N1671_4 :=__common__( map(((real)f_divssnidmsrcurelcount_i <= NULL) => 0.00077636929,
               ((real)f_divssnidmsrcurelcount_i < 0.5)   => -0.0082292062,
                                                            0.00077636929));

N1671_3 :=__common__( map(((real)f_corraddrnamecount_d <= NULL) => N1671_4,
               ((real)f_corraddrnamecount_d < 2.5)   => -0.010215189,
                                                        N1671_4));

N1671_2 :=__common__( if(((real)f_mos_acc_lseen_d < 80.5), N1671_3, N1671_5));

N1671_1 :=__common__( if(((real)f_mos_acc_lseen_d > NULL), N1671_2, 0.0043176667));

N1672_8 :=__common__( map(trim(C_POP_6_11_P) = ''              => 0.00018943838,
               ((real)c_pop_6_11_p < 7.55000019073) => -0.010218223,
                                                       0.00018943838));

N1672_7 :=__common__( map(((real)f_estimated_income_d <= NULL)    => 0.0030838449,
               ((integer)f_estimated_income_d < 35500) => N1672_8,
                                                          0.0030838449));

N1672_6 :=__common__( map(trim(C_HVAL_100K_P) = ''              => 0.0066250486,
               ((real)c_hval_100k_p < 18.5499992371) => N1672_7,
                                                        0.0066250486));

N1672_5 :=__common__( map(trim(C_HH4_P) = ''              => -0.0037772956,
               ((real)c_hh4_p < 12.8500003815) => N1672_6,
                                                  -0.0037772956));

N1672_4 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => 0.0015705932,
               ((integer)f_curraddrmurderindex_i < 48) => -0.00211749,
                                                          0.0015705932));

N1672_3 :=__common__( if(((real)c_dist_input_to_prev_addr_i < 16.5), N1672_4, N1672_5));

N1672_2 :=__common__( if(((real)c_dist_input_to_prev_addr_i > NULL), N1672_3, 0.0028864687));

N1672_1 :=__common__( if(trim(C_SUB_BUS) != '', N1672_2, 0.0043111798));

N1673_9 :=__common__( map(trim(C_POP_55_64_P) = ''     => 0.002726772,
               ((real)c_pop_55_64_p < 6.75) => 0.012073228,
                                               0.002726772));

N1673_8 :=__common__( if(((real)f_corraddrnamecount_d < 3.5), -0.0038954848, N1673_9));

N1673_7 :=__common__( if(((real)f_corraddrnamecount_d > NULL), N1673_8, 0.042026404));

N1673_6 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => -0.00034306375,
               ((real)r_c21_m_bureau_adl_fs_d < 155.5) => -0.01048824,
                                                          -0.00034306375));

N1673_5 :=__common__( map(trim(C_INC_25K_P) = ''              => 0.0028942828,
               ((real)c_inc_25k_p < 23.5499992371) => -0.00064308448,
                                                      0.0028942828));

N1673_4 :=__common__( if(((real)r_e55_college_ind_d < 0.5), N1673_5, N1673_6));

N1673_3 :=__common__( if(((real)r_e55_college_ind_d > NULL), N1673_4, -0.010222801));

N1673_2 :=__common__( if(((real)c_hh5_p < 15.8500003815), N1673_3, N1673_7));

N1673_1 :=__common__( if(trim(C_HH5_P) != '', N1673_2, 0.0013945098));

N1674_10 :=__common__( map(((real)f_addrchangevaluediff_d <= NULL)    => -0.004972542,
                ((integer)f_addrchangevaluediff_d < 53347) => 0.0023206621,
                                                              -0.004972542));

N1674_9 :=__common__( map(trim(C_RETIRED) = ''              => N1674_10,
               ((real)c_retired < 5.44999980927) => -0.0051467118,
                                                    N1674_10));

N1674_8 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1674_9, -0.00035991829));

N1674_7 :=__common__( if(((real)c_totcrime < 190.5), N1674_8, -0.0053328265));

N1674_6 :=__common__( if(trim(C_TOTCRIME) != '', N1674_7, 0.0063878065));

N1674_5 :=__common__( map(((real)f_assocsuspicousidcount_i <= NULL) => N1674_6,
               ((real)f_assocsuspicousidcount_i < 3.5)   => 0.0021693888,
                                                            N1674_6));

N1674_4 :=__common__( if(((real)f_prevaddrmedianvalue_d < 79933.5), -0.0068015848, -0.00026041606));

N1674_3 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N1674_4, 0.0025576434));

N1674_2 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i < 0.0172331295907), N1674_3, N1674_5));

N1674_1 :=__common__( if(((real)f_add_curr_nhood_vac_pct_i > NULL), N1674_2, 0.0084067816));

N1675_8 :=__common__( map(trim(C_POPOVER25) = ''      => 0.010813421,
               ((real)c_popover25 < 961.5) => 0.0014830156,
                                              0.010813421));

N1675_7 :=__common__( map(trim(C_CARTHEFT) = ''      => N1675_8,
               ((real)c_cartheft < 103.5) => -0.0024304866,
                                             N1675_8));

N1675_6 :=__common__( if(((real)f_corrssnaddrcount_d < 4.5), N1675_7, -0.0069063597));

N1675_5 :=__common__( if(((real)f_corrssnaddrcount_d > NULL), N1675_6, -0.030368455));

N1675_4 :=__common__( map((segment in ['KMART', 'RETAIL', 'SEARS AUTO']) => -0.0033914872,
               (segment in ['SEARS FLS', 'SEARS SHO'])        => N1675_5,
                                                                 -0.0033914872));

N1675_3 :=__common__( map(trim(C_URBAN_P) = ''     => N1675_4,
               ((real)c_urban_p < 0.25) => 0.0075895924,
                                           N1675_4));

N1675_2 :=__common__( if(((real)c_rnt500_p < 14.4499998093), N1675_3, 0.0011177563));

N1675_1 :=__common__( if(trim(C_RNT500_P) != '', N1675_2, 0.0012945549));

N1676_8 :=__common__( map(trim(C_INCOLLEGE) = ''              => -0.011200078,
               ((real)c_incollege < 6.14999961853) => 0.00064632021,
                                                      -0.011200078));

N1676_7 :=__common__( map(trim(C_BLUE_EMPL) = ''      => 0.0024763572,
               ((real)c_blue_empl < 161.5) => -0.0026392877,
                                              0.0024763572));

N1676_6 :=__common__( map(trim(C_HVAL_400K_P) = ''              => -0.010960338,
               ((real)c_hval_400k_p < 17.5499992371) => N1676_7,
                                                        -0.010960338));

N1676_5 :=__common__( if(((real)r_c13_max_lres_d < 99.5), N1676_6, 0.000482447));

N1676_4 :=__common__( if(((real)r_c13_max_lres_d > NULL), N1676_5, 0.0064921963));

N1676_3 :=__common__( map(trim(C_ASIAN_LANG) = ''      => 0.0014157248,
               ((real)c_asian_lang < 127.5) => N1676_4,
                                               0.0014157248));

N1676_2 :=__common__( if(((real)c_hval_250k_p < 28.6500015259), N1676_3, N1676_8));

N1676_1 :=__common__( if(trim(C_HVAL_250K_P) != '', N1676_2, -0.002808814));

N1677_8 :=__common__( map(trim(C_POP00) = ''      => 0.00067863603,
               ((real)c_pop00 < 587.5) => -0.0063728349,
                                          0.00067863603));

N1677_7 :=__common__( map(trim(C_RICH_FAM) = ''      => -0.010864641,
               ((real)c_rich_fam < 107.5) => -0.0012432307,
                                             -0.010864641));

N1677_6 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL) => -0.0063390994,
               ((real)f_curraddrcrimeindex_i < 145.5) => 0.0011053476,
                                                         -0.0063390994));

N1677_5 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => N1677_7,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0595871731639) => N1677_6,
                                                                       N1677_7));

N1677_4 :=__common__( if(((real)c_famotf18_p < 12.3500003815), N1677_5, N1677_8));

N1677_3 :=__common__( if(trim(C_FAMOTF18_P) != '', N1677_4, 0.002500628));

N1677_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 4.5), 0.0052996479, N1677_3));

N1677_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N1677_2, 0.0036685415));

N1678_10 :=__common__( map(trim(C_HVAL_175K_P) = ''              => 0.0012313212,
                ((real)c_hval_175k_p < 6.35000038147) => 0.012818237,
                                                         0.0012313212));

N1678_9 :=__common__( if(((real)r_c14_addr_stability_v2_d < 4.5), N1678_10, -0.0023957194));

N1678_8 :=__common__( if(((real)r_c14_addr_stability_v2_d > NULL), N1678_9, -0.029894989));

N1678_7 :=__common__( map(trim(C_OLD_HOMES) = ''      => -0.0093832759,
               ((real)c_old_homes < 118.5) => N1678_8,
                                              -0.0093832759));

N1678_6 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.37928879261), N1678_7, 0.0097926765));

N1678_5 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1678_6, -0.0046239082));

N1678_4 :=__common__( if(((real)r_c14_addrs_10yr_i < 11.5), -0.00062595839, -0.0037843477));

N1678_3 :=__common__( if(((real)r_c14_addrs_10yr_i > NULL), N1678_4, -0.0061586859));

N1678_2 :=__common__( if(((real)c_ownocc_p < 76.0500030518), N1678_3, N1678_5));

N1678_1 :=__common__( if(trim(C_OWNOCC_P) != '', N1678_2, 0.0015965631));

N1679_10 :=__common__( map(trim(C_OCCUNIT_P) = ''              => -0.0037827269,
                ((real)c_occunit_p < 91.4499969482) => 0.0024270273,
                                                       -0.0037827269));

N1679_9 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_i > NULL), N1679_10, 0.00041755539));

N1679_8 :=__common__( map(trim(C_HHSIZE) = ''              => 0.0026580918,
               ((real)c_hhsize < 2.60500001907) => -0.0066969877,
                                                   0.0026580918));

N1679_7 :=__common__( map(trim(C_AB_AV_EDU) = ''     => 0.006564531,
               ((real)c_ab_av_edu < 86.5) => N1679_8,
                                             0.006564531));

N1679_6 :=__common__( map(trim(C_BLUE_COL) = ''              => N1679_7,
               ((real)c_blue_col < 11.1499996185) => -0.0065583904,
                                                     N1679_7));

N1679_5 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1679_6, -0.00051241917));

N1679_4 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i < 3.5), N1679_5, 0.0065111444));

N1679_3 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), N1679_4, N1679_9));

N1679_2 :=__common__( if(((real)c_inc_35k_p < 23.8499984741), N1679_3, -0.0053738967));

N1679_1 :=__common__( if(trim(C_INC_35K_P) != '', N1679_2, 0.0018952457));

N1680_8 :=__common__( map(trim(C_RELIG_INDX) = ''      => -0.0023221737,
               ((real)c_relig_indx < 118.5) => 0.010481759,
                                               -0.0023221737));

N1680_7 :=__common__( map(trim(C_BLUE_EMPL) = ''     => N1680_8,
               ((real)c_blue_empl < 89.5) => -0.0044398565,
                                             N1680_8));

N1680_6 :=__common__( if(((real)r_c20_email_count_i < 0.5), 0.01229774, 0.0041390213));

N1680_5 :=__common__( if(((real)r_c20_email_count_i > NULL), N1680_6, 0.023726909));

N1680_4 :=__common__( map(trim(C_FOOD) = ''              => N1680_7,
               ((real)c_food < 19.0499992371) => N1680_5,
                                                 N1680_7));

N1680_3 :=__common__( map(trim(C_HH4_P) = ''      => 0.0001843024,
               ((real)c_hh4_p < 10.25) => N1680_4,
                                          0.0001843024));

N1680_2 :=__common__( if(((real)c_for_sale < 130.5), -0.00083281885, N1680_3));

N1680_1 :=__common__( if(trim(C_FOR_SALE) != '', N1680_2, -0.0030303556));

N1681_9 :=__common__( map(trim(C_HH6_P) = ''              => -0.0063440072,
               ((real)c_hh6_p < 6.14999961853) => 0.00336862,
                                                  -0.0063440072));

N1681_8 :=__common__( map(((real)f_mos_liens_unrel_lt_fseen_d <= NULL) => 0.00041208291,
               ((real)f_mos_liens_unrel_lt_fseen_d < 162.5) => 0.0089152708,
                                                               0.00041208291));

N1681_7 :=__common__( if(((integer)r_l80_inp_avm_autoval_d < 12962), 0.0082374108, -0.00048996438));

N1681_6 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1681_7, N1681_8));

N1681_5 :=__common__( if(((real)r_i60_inq_hiriskcred_recency_d < 61.5), -0.0019732122, N1681_6));

N1681_4 :=__common__( if(((real)r_i60_inq_hiriskcred_recency_d > NULL), N1681_5, 0.0014309834));

N1681_3 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => N1681_9,
               ((real)f_inq_per_ssn_i < 5.5)   => N1681_4,
                                                  N1681_9));

N1681_2 :=__common__( if(((real)c_agriculture < 2.34999990463), N1681_3, -0.007574365));

N1681_1 :=__common__( if(trim(C_AGRICULTURE) != '', N1681_2, -0.0017588304));

N1682_11 :=__common__( if(((real)r_c14_addrs_15yr_i < 8.5), 0.011895384, 0.00049282524));

N1682_10 :=__common__( if(((real)r_c14_addrs_15yr_i > NULL), N1682_11, 0.00492101));

N1682_9 :=__common__( map(trim(C_MANY_CARS) = ''      => -0.0035542989,
               ((real)c_many_cars < 119.5) => N1682_10,
                                              -0.0035542989));

N1682_8 :=__common__( if(((real)c_child < 26.9500007629), N1682_9, -0.0030790456));

N1682_7 :=__common__( if(trim(C_CHILD) != '', N1682_8, -0.0012873888));

N1682_6 :=__common__( if(((real)c_pop_65_74_p < 13.8500003815), -9.1812193e-005, -0.0062595668));

N1682_5 :=__common__( if(trim(C_POP_65_74_P) != '', N1682_6, -0.0035903842));

N1682_4 :=__common__( if(((real)f_rel_educationover12_count_d < 7.5), -0.00015241443, 0.0095239789));

N1682_3 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N1682_4, 0.01790699));

N1682_2 :=__common__( map(((real)f_estimated_income_d <= NULL)    => N1682_5,
               ((integer)f_estimated_income_d < 22500) => N1682_3,
                                                          N1682_5));

N1682_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1682_2, N1682_7));

N1683_9 :=__common__( map(trim(C_MEDI_INDX) = ''      => 0.009018932,
               ((real)c_medi_indx < 112.5) => -0.00062976658,
                                              0.009018932));

N1683_8 :=__common__( map(trim(C_HEALTH) = ''              => -0.0027873044,
               ((real)c_health < 11.3500003815) => 0.0039044114,
                                                   -0.0027873044));

N1683_7 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i < 9.5), N1683_8, -0.0068926148));

N1683_6 :=__common__( if(((real)f_crim_rel_under500miles_cnt_i > NULL), N1683_7, 0.0035109311));

N1683_5 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => 0.0057946306,
               ((real)f_srchfraudsrchcount_i < 9.5)   => N1683_6,
                                                         0.0057946306));

N1683_4 :=__common__( if(((real)f_addrchangecrimediff_i < 38.5), N1683_5, -0.0023192995));

N1683_3 :=__common__( if(((real)f_addrchangecrimediff_i > NULL), N1683_4, N1683_9));

N1683_2 :=__common__( if(((real)c_rape < 122.5), -0.0017062579, N1683_3));

N1683_1 :=__common__( if(trim(C_RAPE) != '', N1683_2, 4.6961815e-005));

N1684_10 :=__common__( if(((real)c_rentocc_p < 12.1499996185), 0.0045862687, -0.0016333735));

N1684_9 :=__common__( if(trim(C_RENTOCC_P) != '', N1684_10, -0.0037281273));

N1684_8 :=__common__( map(trim(C_NO_CAR) = ''      => -0.0016235887,
               ((real)c_no_car < 157.5) => 0.010836318,
                                           -0.0016235887));

N1684_7 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.111782975495), -0.0047344619, N1684_8));

N1684_6 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1684_7, -0.00016977693));

N1684_5 :=__common__( map(trim(C_FOOD) = ''              => 0.0025883638,
               ((real)c_food < 3.34999990463) => N1684_6,
                                                 0.0025883638));

N1684_4 :=__common__( if(((real)c_hval_175k_p < 22.9500007629), N1684_5, -0.0045029932));

N1684_3 :=__common__( if(trim(C_HVAL_175K_P) != '', N1684_4, -0.0015104271));

N1684_2 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d < 45.5), N1684_3, N1684_9));

N1684_1 :=__common__( if(((real)f_mos_inq_banko_cm_lseen_d > NULL), N1684_2, 0.0013396807));

N1685_11 :=__common__( if(((integer)f_mos_inq_banko_om_fseen_d < 49), 0.002592757, 0.014259617));

N1685_10 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N1685_11, 0.030532042));

N1685_9 :=__common__( if(((real)c_famotf18_p < 46.1500015259), 0.0004320635, N1685_10));

N1685_8 :=__common__( if(trim(C_FAMOTF18_P) != '', N1685_9, -0.012521776));

N1685_7 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => 0.011619471,
               ((real)f_srchssnsrchcount_i < 4.5)   => 0.0022967008,
                                                       0.011619471));

N1685_6 :=__common__( if(((integer)r_i60_inq_banking_recency_d < 549), -0.0019287077, N1685_7));

N1685_5 :=__common__( if(((real)r_i60_inq_banking_recency_d > NULL), N1685_6, 0.0088502179));

N1685_4 :=__common__( if(((real)c_inc_100k_p < 16.0499992371), -0.0012588144, N1685_5));

N1685_3 :=__common__( if(trim(C_INC_100K_P) != '', N1685_4, -0.0029944724));

N1685_2 :=__common__( if(((real)r_l77_apartment_i < 0.5), N1685_3, N1685_8));

N1685_1 :=__common__( if(((real)r_l77_apartment_i > NULL), N1685_2, -0.034638137));

N1686_9 :=__common__( map(trim(C_RENTOCC_P) = ''      => -0.0086742538,
               ((real)c_rentocc_p < 19.75) => 0.0029009329,
                                              -0.0086742538));

N1686_8 :=__common__( map(trim(C_RENTOCC_P) = ''              => 0.007549074,
               ((real)c_rentocc_p < 14.1499996185) => -0.0032416037,
                                                      0.007549074));

N1686_7 :=__common__( map(trim(C_HH6_P) = ''              => N1686_9,
               ((real)c_hh6_p < 2.04999995232) => N1686_8,
                                                  N1686_9));

N1686_6 :=__common__( if(((real)f_rel_count_i < 8.5), 0.0097209075, N1686_7));

N1686_5 :=__common__( if(((real)f_rel_count_i > NULL), N1686_6, -0.02947025));

N1686_4 :=__common__( map(trim(C_RURAL_P) = ''              => N1686_5,
               ((real)c_rural_p < 24.5499992371) => 0.00036616091,
                                                    N1686_5));

N1686_3 :=__common__( if(trim(C_URBAN_P) != '', N1686_4, -0.010715815));

N1686_2 :=__common__( map(((real)r_l70_add_invalid_i <= NULL) => -0.0059362312,
               ((real)r_l70_add_invalid_i < 0.5)   => N1686_3,
                                                      -0.0059362312));

N1686_1 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1686_2, 0.0026842877));

N1687_11 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 144.5), -0.010193845, -0.0016564754));

N1687_10 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N1687_11, 0.00027391403));

N1687_9 :=__common__( if(((real)c_hh3_p < 26.5499992371), 0.00059913926, N1687_10));

N1687_8 :=__common__( if(trim(C_HH3_P) != '', N1687_9, 0.00088927032));

N1687_7 :=__common__( map(((real)c_comb_age_d <= NULL) => -0.0018925832,
               ((real)c_comb_age_d < 32.5)  => 0.0054991995,
                                               -0.0018925832));

N1687_6 :=__common__( map(trim(C_NO_TEENS) = ''     => N1687_7,
               ((real)c_no_teens < 29.5) => 0.01086257,
                                            N1687_7));

N1687_5 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.377423286438), N1687_6, -0.003363961));

N1687_4 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1687_5, 0.0024409081));

N1687_3 :=__common__( if(((real)c_hval_80k_p < 8.05000019073), N1687_4, -0.0019209939));

N1687_2 :=__common__( if(trim(C_HVAL_80K_P) != '', N1687_3, -0.0086133648));

N1687_1 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N1687_2, N1687_8));

N1688_7 :=__common__( map(trim(C_NO_TEENS) = ''     => -0.0011793795,
               ((real)c_no_teens < 35.5) => 0.0055070228,
                                            -0.0011793795));

N1688_6 :=__common__( map(trim(C_HH3_P) = ''              => -0.006910552,
               ((real)c_hh3_p < 25.8499984741) => N1688_7,
                                                  -0.006910552));

N1688_5 :=__common__( map(trim(C_HH7P_P) = ''              => -0.0053257283,
               ((real)c_hh7p_p < 2.04999995232) => N1688_6,
                                                   -0.0053257283));

N1688_4 :=__common__( map(trim(C_FAMMAR_P) = ''              => 0.0027717034,
               ((real)c_fammar_p < 73.0500030518) => -0.0081014835,
                                                     0.0027717034));

N1688_3 :=__common__( map(trim(C_POP_18_24_P) = ''     => 0.00081990786,
               ((real)c_pop_18_24_p < 3.25) => N1688_4,
                                               0.00081990786));

N1688_2 :=__common__( if(((real)c_low_ed < 70.8500061035), N1688_3, N1688_5));

N1688_1 :=__common__( if(trim(C_LOW_ED) != '', N1688_2, -0.002307186));

N1689_8 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)          => 0.0051403009,
               ((real)f_add_curr_nhood_vac_pct_i < 0.209728047252) => -0.001849553,
                                                                      0.0051403009));

N1689_7 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => -0.002787748,
               ((real)r_c13_max_lres_d < 68.5)  => 0.0061692556,
                                                   -0.002787748));

N1689_6 :=__common__( if(((real)f_srchaddrsrchcount_i < 6.5), 0.0070495159, N1689_7));

N1689_5 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N1689_6, 0.014312015));

N1689_4 :=__common__( map(trim(C_NO_CAR) = ''      => N1689_8,
               ((real)c_no_car < 180.5) => N1689_5,
                                           N1689_8));

N1689_3 :=__common__( map(trim(C_HH2_P) = ''              => -0.0063651599,
               ((real)c_hh2_p < 44.6500015259) => N1689_4,
                                                  -0.0063651599));

N1689_2 :=__common__( if(((real)c_no_car < 164.5), -0.0012305257, N1689_3));

N1689_1 :=__common__( if(trim(C_NO_CAR) != '', N1689_2, 0.0002251228));

N1690_9 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.200431257486), 0.0092907857, 0.0013717857));

N1690_8 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1690_9, 0.0079935853));

N1690_7 :=__common__( map(trim(C_POP_0_5_P) = ''     => 0.0042195171,
               ((real)c_pop_0_5_p < 6.75) => -0.0020175546,
                                             0.0042195171));

N1690_6 :=__common__( map(trim(C_PRESCHL) = ''      => -0.0063760833,
               ((real)c_preschl < 179.5) => N1690_7,
                                            -0.0063760833));

N1690_5 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => N1690_8,
               ((real)f_add_input_mobility_index_n < 0.363408654928) => N1690_6,
                                                                        N1690_8));

N1690_4 :=__common__( map(((real)f_mos_liens_unrel_cj_lseen_d <= NULL) => N1690_5,
               ((real)f_mos_liens_unrel_cj_lseen_d < 18.5)  => -0.0047304934,
                                                               N1690_5));

N1690_3 :=__common__( if(((real)c_for_sale < 155.5), -0.00072540018, N1690_4));

N1690_2 :=__common__( if(trim(C_FOR_SALE) != '', N1690_3, -5.4666429e-005));

N1690_1 :=__common__( if(((real)f_rel_felony_count_i > NULL), N1690_2, -0.0082758935));

N1691_9 :=__common__( map(trim(C_INC_50K_P) = ''              => 0.00093940376,
               ((real)c_inc_50k_p < 15.9499998093) => 0.012120127,
                                                      0.00093940376));

N1691_8 :=__common__( if(((integer)f_prevaddrmedianincome_d < 33101), -0.0017570149, N1691_9));

N1691_7 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N1691_8, 0.046908252));

N1691_6 :=__common__( map(trim(C_URBAN_P) = ''     => 5.3796161e-005,
               ((real)c_urban_p < 95.5) => -0.011967847,
                                           5.3796161e-005));

N1691_5 :=__common__( map(trim(C_CIV_EMP) = ''              => N1691_6,
               ((real)c_civ_emp < 53.9500007629) => 0.0060340155,
                                                    N1691_6));

N1691_4 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N1691_5, -0.0021558558));

N1691_3 :=__common__( map(trim(C_HVAL_200K_P) = ''     => N1691_4,
               ((real)c_hval_200k_p < 5.75) => 0.00059384198,
                                               N1691_4));

N1691_2 :=__common__( if(((real)c_hh2_p < 45.75), N1691_3, N1691_7));

N1691_1 :=__common__( if(trim(C_HH2_P) != '', N1691_2, 0.0048360501));

N1692_8 :=__common__( map(trim(C_SPAN_LANG) = ''      => 0.012525205,
               ((real)c_span_lang < 153.5) => 0.0019740973,
                                              0.012525205));

N1692_7 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)    => N1692_8,
               ((integer)f_curraddrmedianincome_d < 62443) => 0.000245634,
                                                              N1692_8));

N1692_6 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 19.5), -0.0055990909, N1692_7));

N1692_5 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N1692_6, 0.0095654403));

N1692_4 :=__common__( map(trim(C_FAMMAR18_P) = ''              => -0.0053682568,
               ((real)c_fammar18_p < 50.8499984741) => N1692_5,
                                                       -0.0053682568));

N1692_3 :=__common__( map(trim(C_WHOLESALE) = ''              => -0.0039041444,
               ((real)c_wholesale < 10.6499996185) => N1692_4,
                                                      -0.0039041444));

N1692_2 :=__common__( if(((real)c_hval_750k_p < 16.5499992371), N1692_3, 0.0056224383));

N1692_1 :=__common__( if(trim(C_HVAL_750K_P) != '', N1692_2, -0.0010708473));

N1693_9 :=__common__( map(trim(C_POP_55_64_P) = ''              => 0.010630897,
               ((real)c_pop_55_64_p < 11.9499998093) => -0.00045979647,
                                                        0.010630897));

N1693_8 :=__common__( if(((real)c_retired < 22.8499984741), -0.000446955, N1693_9));

N1693_7 :=__common__( if(trim(C_RETIRED) != '', N1693_8, -0.001533017));

N1693_6 :=__common__( if(((real)c_hhsize < 2.71500015259), -0.011873553, 0.0019314864));

N1693_5 :=__common__( if(trim(C_HHSIZE) != '', N1693_6, 0.016740225));

N1693_4 :=__common__( map(((real)f_inq_other_count24_i <= NULL) => 0.0051075716,
               ((real)f_inq_other_count24_i < 2.5)   => -0.0018947395,
                                                        0.0051075716));

N1693_3 :=__common__( map(((real)r_a49_curr_avm_chg_1yr_pct_i <= NULL)         => 0.0065390764,
               ((real)r_a49_curr_avm_chg_1yr_pct_i < 108.649993896) => N1693_4,
                                                                       0.0065390764));

N1693_2 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i < 123.25), N1693_3, N1693_5));

N1693_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N1693_2, N1693_7));

N1694_8 :=__common__( if(((real)f_mos_acc_lseen_d < 37.5), 0.006109214, -0.0023875691));

N1694_7 :=__common__( if(((real)f_mos_acc_lseen_d > NULL), N1694_8, -0.020536691));

N1694_6 :=__common__( map(trim(C_SERV_EMPL) = ''      => -0.01032438,
               ((real)c_serv_empl < 190.5) => N1694_7,
                                              -0.01032438));

N1694_5 :=__common__( map(trim(C_PROFESSIONAL) = ''               => -0.001580964,
               ((real)c_professional < 0.449999988079) => 0.0018774055,
                                                          -0.001580964));

N1694_4 :=__common__( map(trim(C_HVAL_40K_P) = ''              => 0.0072346656,
               ((real)c_hval_40k_p < 20.4500007629) => N1694_5,
                                                       0.0072346656));

N1694_3 :=__common__( map(trim(C_UNEMP) = ''              => N1694_6,
               ((real)c_unemp < 7.44999980927) => N1694_4,
                                                  N1694_6));

N1694_2 :=__common__( if(((real)c_pop_65_74_p < 2.45000004768), 0.0022397293, N1694_3));

N1694_1 :=__common__( if(trim(C_POP_65_74_P) != '', N1694_2, 0.0016957112));

N1695_8 :=__common__( map(((real)r_c13_max_lres_d <= NULL) => 0.0053154956,
               ((real)r_c13_max_lres_d < 121.5) => -0.0036822544,
                                                   0.0053154956));

N1695_7 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d < 56.5), -0.0086004633, N1695_8));

N1695_6 :=__common__( if(((real)f_mos_inq_banko_cm_fseen_d > NULL), N1695_7, 0.013705465));

N1695_5 :=__common__( map(trim(C_LUX_PROD) = ''      => 0.0084105714,
               ((real)c_lux_prod < 125.5) => N1695_6,
                                             0.0084105714));

N1695_4 :=__common__( map(trim(C_HOUSINGCPI) = ''              => N1695_5,
               ((real)c_housingcpi < 199.399993896) => -0.0089482926,
                                                       N1695_5));

N1695_3 :=__common__( map(trim(C_FEMDIV_P) = ''              => 0.0033106596,
               ((real)c_femdiv_p < 8.55000019073) => 0.00017133051,
                                                     0.0033106596));

N1695_2 :=__common__( if(((real)c_wholesale < 5.35000038147), N1695_3, N1695_4));

N1695_1 :=__common__( if(trim(C_WHOLESALE) != '', N1695_2, 0.0024504409));

N1696_10 :=__common__( map(trim(C_MURDERS) = ''      => 0.010703506,
                ((real)c_murders < 109.5) => -0.0022434602,
                                             0.010703506));

N1696_9 :=__common__( map(trim(C_HEALTH) = ''              => 0.013247503,
               ((real)c_health < 17.3499984741) => 0.0029175534,
                                                   0.013247503));

N1696_8 :=__common__( map(trim(C_FAMOTF18_P) = ''              => -0.0024542687,
               ((real)c_famotf18_p < 29.5499992371) => N1696_9,
                                                       -0.0024542687));

N1696_7 :=__common__( map(trim(C_PROFESSIONAL) = ''              => N1696_8,
               ((real)c_professional < 8.94999980927) => -0.00026748417,
                                                         N1696_8));

N1696_6 :=__common__( if(((real)f_rel_ageover20_count_d > NULL), N1696_7, -0.00054672897));

N1696_5 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1696_6, -0.029462233));

N1696_4 :=__common__( if(((real)c_construction < 39.1500015259), N1696_5, N1696_10));

N1696_3 :=__common__( if(trim(C_CONSTRUCTION) != '', N1696_4, -0.0020674672));

N1696_2 :=__common__( if(((real)f_addrchangeecontrajindex_d < 3.5), N1696_3, 0.0077738785));

N1696_1 :=__common__( if(((real)f_addrchangeecontrajindex_d > NULL), N1696_2, 0.0061233414));

N1697_9 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => 0.0067141574,
               ((real)r_c13_avg_lres_d < 54.5)  => -0.0018316725,
                                                   0.0067141574));

N1697_8 :=__common__( if(((integer)f_fp_prevaddrburglaryindex_i < 35), 0.013240782, N1697_9));

N1697_7 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i > NULL), N1697_8, 0.013476777));

N1697_6 :=__common__( map(trim(C_BLUE_EMPL) = ''      => -0.0078705158,
               ((real)c_blue_empl < 106.5) => 0.0025402923,
                                              -0.0078705158));

N1697_5 :=__common__( map(trim(C_RICH_FAM) = ''      => N1697_6,
               ((real)c_rich_fam < 156.5) => 0.0018019518,
                                             N1697_6));

N1697_4 :=__common__( if(((real)r_c14_addrs_10yr_i < 6.5), -0.0010689095, N1697_5));

N1697_3 :=__common__( if(((real)r_c14_addrs_10yr_i > NULL), N1697_4, -0.0023570322));

N1697_2 :=__common__( if(((real)c_inc_100k_p < 18.1500015259), N1697_3, N1697_7));

N1697_1 :=__common__( if(trim(C_INC_100K_P) != '', N1697_2, 0.0005979166));

N1698_8 :=__common__( map(trim(C_RNT500_P) = ''              => -0.0023411274,
               ((real)c_rnt500_p < 19.5499992371) => 0.0025847054,
                                                     -0.0023411274));

N1698_7 :=__common__( map(trim(C_HH5_P) = ''              => 0.003949622,
               ((real)c_hh5_p < 8.05000019073) => N1698_8,
                                                  0.003949622));

N1698_6 :=__common__( map(((real)f_corrssnnamecount_d <= NULL) => N1698_7,
               ((real)f_corrssnnamecount_d < 1.5)   => -0.0082276144,
                                                       N1698_7));

N1698_5 :=__common__( map(trim(C_INC_35K_P) = ''              => 0.0050174712,
               ((real)c_inc_35k_p < 22.0499992371) => -0.001423533,
                                                      0.0050174712));

N1698_4 :=__common__( if(((real)c_for_sale < 101.5), N1698_5, N1698_6));

N1698_3 :=__common__( if(trim(C_FOR_SALE) != '', N1698_4, 0.0020636643));

N1698_2 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 61.5), 0.006009864, N1698_3));

N1698_1 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N1698_2, 0.0068036083));

N1699_8 :=__common__( map(trim(C_RETIRED) = ''              => -0.00071501787,
               ((real)c_retired < 4.14999961853) => -0.008235885,
                                                    -0.00071501787));

N1699_7 :=__common__( map(trim(C_UNEMP) = ''     => -0.0067550024,
               ((real)c_unemp < 4.75) => 0.0019886365,
                                         -0.0067550024));

N1699_6 :=__common__( if(((real)f_varrisktype_i < 4.5), 0.0010404054, N1699_7));

N1699_5 :=__common__( if(((real)f_varrisktype_i > NULL), N1699_6, -0.011362626));

N1699_4 :=__common__( map(trim(C_POP_55_64_P) = ''              => 0.00053970339,
               ((real)c_pop_55_64_p < 9.05000019073) => 0.0083287215,
                                                        0.00053970339));

N1699_3 :=__common__( map(trim(C_CIV_EMP) = ''              => N1699_5,
               ((real)c_civ_emp < 47.9500007629) => N1699_4,
                                                    N1699_5));

N1699_2 :=__common__( if(((real)c_hval_40k_p < 2.15000009537), N1699_3, N1699_8));

N1699_1 :=__common__( if(trim(C_HVAL_40K_P) != '', N1699_2, -0.00053497513));

N1700_8 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => 0.0027172595,
               ((real)f_add_input_mobility_index_n < 0.398363471031) => -0.0095553962,
                                                                        0.0027172595));

N1700_7 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.0003438564,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0310995969921) => 0.0071666936,
                                                                       0.0003438564));

N1700_6 :=__common__( map(trim(C_BORN_USA) = ''     => N1700_7,
               ((real)c_born_usa < 41.5) => -0.0049282705,
                                            N1700_7));

N1700_5 :=__common__( map(trim(C_MORT_INDX) = ''      => -0.0058872485,
               ((real)c_mort_indx < 124.5) => N1700_6,
                                              -0.0058872485));

N1700_4 :=__common__( map(trim(C_ASSAULT) = ''      => 0.0070991865,
               ((real)c_assault < 177.5) => N1700_5,
                                            0.0070991865));

N1700_3 :=__common__( if(((real)c_pop_0_5_p < 12.5500001907), N1700_4, N1700_8));

N1700_2 :=__common__( if(trim(C_POP_0_5_P) != '', N1700_3, -0.0012405838));

N1700_1 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N1700_2, -0.00021010907));

N1701_8 :=__common__( map(trim(C_INC_50K_P) = ''              => 0.0030810359,
               ((real)c_inc_50k_p < 17.9500007629) => -0.0052428992,
                                                      0.0030810359));

N1701_7 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d < 40.5), 0.0081017159, -0.00094401455));

N1701_6 :=__common__( if(((real)f_mos_inq_banko_om_fseen_d > NULL), N1701_7, 0.038111487));

N1701_5 :=__common__( map(trim(C_HH2_P) = ''              => -0.0055132109,
               ((real)c_hh2_p < 42.1500015259) => N1701_6,
                                                  -0.0055132109));

N1701_4 :=__common__( map(trim(C_AB_AV_EDU) = ''      => 0.012818794,
               ((real)c_ab_av_edu < 128.5) => N1701_5,
                                              0.012818794));

N1701_3 :=__common__( map(trim(C_MED_AGE) = ''              => N1701_4,
               ((real)c_med_age < 42.3499984741) => -0.0005625308,
                                                    N1701_4));

N1701_2 :=__common__( if(((real)c_rich_nfam < 159.5), N1701_3, N1701_8));

N1701_1 :=__common__( if(trim(C_RICH_NFAM) != '', N1701_2, -0.00022040947));

N1702_12 :=__common__( if(((real)f_srchaddrsrchcount_i < 18.5), -0.0021028945, 0.0064277425));

N1702_11 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N1702_12, -0.030859802));

N1702_10 :=__common__( if(((real)c_hh4_p < 6.55000019073), 0.0095356899, N1702_11));

N1702_9 :=__common__( if(trim(C_HH4_P) != '', N1702_10, 0.0066750107));

N1702_8 :=__common__( map(trim(C_POP_45_54_P) = ''              => 0.0026721265,
               ((real)c_pop_45_54_p < 16.0499992371) => -0.0039081297,
                                                        0.0026721265));

N1702_7 :=__common__( if(((real)c_armforce < 120.5), N1702_8, 0.0033460246));

N1702_6 :=__common__( if(trim(C_ARMFORCE) != '', N1702_7, -0.029830915));

N1702_5 :=__common__( map(((real)f_estimated_income_d <= NULL)    => N1702_6,
               ((integer)f_estimated_income_d < 22500) => 0.0066262886,
                                                          N1702_6));

N1702_4 :=__common__( if(((integer)f_curraddrcrimeindex_i < 187), N1702_5, 0.0072710426));

N1702_3 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N1702_4, -0.011918971));

N1702_2 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1702_3, -9.3578304e-005));

N1702_1 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1702_2, N1702_9));

N1703_8 :=__common__( map(((real)f_assoccredbureaucount_i <= NULL) => 0.0055710868,
               ((real)f_assoccredbureaucount_i < 2.5)   => -0.0042290427,
                                                           0.0055710868));

N1703_7 :=__common__( map(((real)f_add_curr_nhood_vac_pct_i <= NULL)           => 0.011594089,
               ((real)f_add_curr_nhood_vac_pct_i < 0.0263207145035) => 0.0020343376,
                                                                       0.011594089));

N1703_6 :=__common__( if(((real)f_rel_under25miles_cnt_d < 9.5), N1703_7, N1703_8));

N1703_5 :=__common__( if(((real)f_rel_under25miles_cnt_d > NULL), N1703_6, 0.0035416011));

N1703_4 :=__common__( map(trim(C_MORT_INDX) = ''      => -0.007521918,
               ((real)c_mort_indx < 167.5) => 0.0001279864,
                                              -0.007521918));

N1703_3 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => 0.0054363646,
               ((real)r_l79_adls_per_addr_curr_i < 49.5)  => N1703_4,
                                                             0.0054363646));

N1703_2 :=__common__( if(((real)c_hh4_p < 22.9500007629), N1703_3, N1703_5));

N1703_1 :=__common__( if(trim(C_HH4_P) != '', N1703_2, -0.0056847599));

N1704_8 :=__common__( map(trim(C_RELIG_INDX) = ''     => 0.0072871332,
               ((real)c_relig_indx < 92.5) => -0.0014269713,
                                              0.0072871332));

N1704_7 :=__common__( map(trim(C_OLD_HOMES) = ''      => -0.0042477776,
               ((real)c_old_homes < 149.5) => N1704_8,
                                              -0.0042477776));

N1704_6 :=__common__( map(trim(C_EASIQLIFE) = ''      => -0.0046687158,
               ((real)c_easiqlife < 125.5) => N1704_7,
                                              -0.0046687158));

N1704_5 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL) => N1704_6,
               ((real)f_fp_prevaddrburglaryindex_i < 66.5)  => 0.0072436137,
                                                               N1704_6));

N1704_4 :=__common__( map(trim(C_HHSIZE) = ''              => 0.01158223,
               ((real)c_hhsize < 3.08500003815) => N1704_5,
                                                   0.01158223));

N1704_3 :=__common__( if(((real)f_rel_ageover50_count_d < 0.5), -0.00034971266, N1704_4));

N1704_2 :=__common__( if(((real)f_rel_ageover50_count_d > NULL), N1704_3, -0.0039049623));

N1704_1 :=__common__( if(trim(C_FOOD) != '', N1704_2, 4.673268e-005));

N1705_9 :=__common__( map(trim(C_HH1_P) = ''              => -0.0087270385,
               ((real)c_hh1_p < 37.4500007629) => 0.00063665748,
                                                  -0.0087270385));

N1705_8 :=__common__( if(((real)f_addrchangeincomediff_d < 13624.5), 0.0010210169, -0.0053461985));

N1705_7 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1705_8, N1705_9));

N1705_6 :=__common__( map(trim(C_TOTSALES) = ''        => 0.0054637986,
               ((integer)c_totsales < 1748) => 0.00034439646,
                                               0.0054637986));

N1705_5 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => -0.0029422971,
               ((real)f_add_input_nhood_vac_pct_i < 0.215256720781) => N1705_6,
                                                                       -0.0029422971));

N1705_4 :=__common__( if(((integer)f_prevaddrmedianincome_d < 34294), N1705_5, N1705_7));

N1705_3 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N1705_4, 0.0013597455));

N1705_2 :=__common__( if(((real)c_larceny < 175.5), N1705_3, -0.0018649492));

N1705_1 :=__common__( if(trim(C_LARCENY) != '', N1705_2, 0.00038028521));

N1706_8 :=__common__( if(((real)f_prevaddrageoldest_d < 4.5), 0.0082451436, 0.0010877207));

N1706_7 :=__common__( if(((real)f_prevaddrageoldest_d > NULL), N1706_8, -0.014451268));

N1706_6 :=__common__( map(trim(C_BORN_USA) = ''      => -0.0037758564,
               ((real)c_born_usa < 176.5) => -0.00036963043,
                                             -0.0037758564));

N1706_5 :=__common__( map(trim(C_FEMDIV_P) = ''     => N1706_6,
               ((real)c_femdiv_p < 1.75) => 0.0042091472,
                                            N1706_6));

N1706_4 :=__common__( map(trim(C_INC_50K_P) = ''              => N1706_7,
               ((real)c_inc_50k_p < 17.8499984741) => N1706_5,
                                                      N1706_7));

N1706_3 :=__common__( map(trim(C_INC_50K_P) = ''              => -0.010156663,
               ((real)c_inc_50k_p < 13.3500003815) => 0.00012828114,
                                                      -0.010156663));

N1706_2 :=__common__( if(((real)c_hh4_p < 0.649999976158), N1706_3, N1706_4));

N1706_1 :=__common__( if(trim(C_HH4_P) != '', N1706_2, 0.00052770987));

N1707_8 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => -0.00057184232,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.165028035641) => 0.0042129117,
                                                                      -0.00057184232));

N1707_7 :=__common__( map(((real)f_divssnidmsrcurelcount_i <= NULL) => 0.00071393878,
               ((real)f_divssnidmsrcurelcount_i < 0.5)   => 0.0074238815,
                                                            0.00071393878));

N1707_6 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)    => -0.0047149324,
               ((real)f_curraddrmedianvalue_d < 148207.5) => N1707_7,
                                                             -0.0047149324));

N1707_5 :=__common__( map(trim(C_HVAL_60K_P) = ''              => 0.01196803,
               ((real)c_hval_60k_p < 13.6499996185) => 0.00082958439,
                                                       0.01196803));

N1707_4 :=__common__( if(((real)f_prevaddrmedianvalue_d < 49908.5), N1707_5, N1707_6));

N1707_3 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N1707_4, 0.038592675));

N1707_2 :=__common__( if(((real)c_inc_150k_p < 0.550000011921), N1707_3, N1707_8));

N1707_1 :=__common__( if(trim(C_INC_150K_P) != '', N1707_2, 0.0022453163));

N1708_9 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d < 16.5), 0.0095085405, 0.000496283));

N1708_8 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d > NULL), N1708_9, -0.0038323202));

N1708_7 :=__common__( map(trim(C_INC_100K_P) = ''              => N1708_8,
               ((real)c_inc_100k_p < 4.64999961853) => 0.012749451,
                                                       N1708_8));

N1708_6 :=__common__( map(trim(C_CHILD) = ''              => N1708_7,
               ((real)c_child < 22.9500007629) => -0.00020655246,
                                                  N1708_7));

N1708_5 :=__common__( map(((real)f_inq_per_phone_i <= NULL) => -0.0037308468,
               ((real)f_inq_per_phone_i < 1.5)   => N1708_6,
                                                    -0.0037308468));

N1708_4 :=__common__( if(((real)f_mos_liens_unrel_sc_fseen_d < 48.5), 0.0037687855, -0.0011644247));

N1708_3 :=__common__( if(((real)f_mos_liens_unrel_sc_fseen_d > NULL), N1708_4, 0.0059916211));

N1708_2 :=__common__( if(((real)c_pop_85p_p < 2.34999990463), N1708_3, N1708_5));

N1708_1 :=__common__( if(trim(C_POP_85P_P) != '', N1708_2, 0.0012320221));

N1709_10 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL)  => 0.0070253368,
                ((integer)r_d33_eviction_recency_d < 549) => -0.0042093736,
                                                             0.0070253368));

N1709_9 :=__common__( if(((real)c_inc_125k_p < 9.94999980927), -0.0013951219, N1709_10));

N1709_8 :=__common__( if(trim(C_INC_125K_P) != '', N1709_9, 0.0025222093));

N1709_7 :=__common__( if(((real)f_rel_ageover40_count_d < 12.5), N1709_8, 0.0067337608));

N1709_6 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N1709_7, -0.00028523354));

N1709_5 :=__common__( map(trim(C_PROFESSIONAL) = ''              => -0.0072107683,
               ((real)c_professional < 4.94999980927) => 0.0016435432,
                                                         -0.0072107683));

N1709_4 :=__common__( map(trim(C_RENTAL) = ''      => 0.0065143128,
               ((real)c_rental < 158.5) => N1709_5,
                                           0.0065143128));

N1709_3 :=__common__( if(((real)c_hval_150k_p < 2.84999990463), N1709_4, -0.0020184187));

N1709_2 :=__common__( if(trim(C_HVAL_150K_P) != '', N1709_3, -0.0081611574));

N1709_1 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1709_2, N1709_6));

N1710_8 :=__common__( if(((real)c_hh7p_p < 6.35000038147), 0.00050219767, -0.0060738648));

N1710_7 :=__common__( if(trim(C_HH7P_P) != '', N1710_8, -0.0031408435));

N1710_6 :=__common__( map(((real)f_current_count_d <= NULL) => -0.012908362,
               ((real)f_current_count_d < 0.5)   => -0.0018783767,
                                                    -0.012908362));

N1710_5 :=__common__( map(trim(C_CIV_EMP) = ''              => N1710_6,
               ((real)c_civ_emp < 57.4500007629) => 0.00016577946,
                                                    N1710_6));

N1710_4 :=__common__( map(((real)r_i60_inq_auto_recency_d <= NULL)  => N1710_5,
               ((integer)r_i60_inq_auto_recency_d < 549) => 0.0020783127,
                                                            N1710_5));

N1710_3 :=__common__( map(((real)f_mos_inq_banko_om_lseen_d <= NULL) => 0.0011114306,
               ((real)f_mos_inq_banko_om_lseen_d < 13.5)  => N1710_4,
                                                             0.0011114306));

N1710_2 :=__common__( map(trim(C_POP_45_54_P) = ''              => -0.0084875263,
               ((real)c_pop_45_54_p < 23.9500007629) => N1710_3,
                                                        -0.0084875263));

N1710_1 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1710_2, N1710_7));

N1711_11 :=__common__( if(((real)f_rel_homeover150_count_d < 1.5), 0.0048175638, -0.0056885012));

N1711_10 :=__common__( if(((real)f_rel_homeover150_count_d > NULL), N1711_11, -0.001634852));

N1711_9 :=__common__( if(((real)c_hval_100k_p < 2.45000004768), 0.009175147, N1711_10));

N1711_8 :=__common__( if(trim(C_HVAL_100K_P) != '', N1711_9, 0.01845312));

N1711_7 :=__common__( if(((integer)f_prevaddrcartheftindex_i < 113), -0.0034796234, N1711_8));

N1711_6 :=__common__( if(((real)f_prevaddrcartheftindex_i > NULL), N1711_7, -0.0042633004));

N1711_5 :=__common__( map(trim(C_LOWINC) = ''              => 0.0049107472,
               ((real)c_lowinc < 77.9499969482) => 0.0002047895,
                                                   0.0049107472));

N1711_4 :=__common__( if(((integer)c_larceny < 12), -0.0075154949, N1711_5));

N1711_3 :=__common__( if(trim(C_LARCENY) != '', N1711_4, -0.0011457348));

N1711_2 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.00327333109453), -0.0073254335, N1711_3));

N1711_1 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1711_2, N1711_6));

N1712_9 :=__common__( if(((real)f_prevaddrstatus_i > NULL), -0.00019553014, -0.0067553623));

N1712_8 :=__common__( map(trim(C_POPOVER18) = ''      => N1712_9,
               ((real)c_popover18 < 496.5) => -0.0079483159,
                                              N1712_9));

N1712_7 :=__common__( map(trim(C_LOW_HVAL) = ''              => 0.0054158827,
               ((real)c_low_hval < 61.8499984741) => N1712_8,
                                                     0.0054158827));

N1712_6 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i < 166.5), 0.0023119219, -0.0011202304));

N1712_5 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i > NULL), N1712_6, 0.0082443403));

N1712_4 :=__common__( map(trim(C_RNT1250_P) = ''              => -0.0037120726,
               ((real)c_rnt1250_p < 23.0499992371) => N1712_5,
                                                      -0.0037120726));

N1712_3 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1712_4, 0.0019788385));

N1712_2 :=__common__( if(((real)c_sub_bus < 137.5), N1712_3, N1712_7));

N1712_1 :=__common__( if(trim(C_SUB_BUS) != '', N1712_2, -0.0015309175));

N1713_8 :=__common__( map(trim(C_RAPE) = ''     => 0.0047723004,
               ((real)c_rape < 67.5) => -0.0036411218,
                                        0.0047723004));

N1713_7 :=__common__( map(((real)c_hist_addr_match_i <= NULL) => N1713_8,
               ((real)c_hist_addr_match_i < 5.5)   => -0.00082903176,
                                                      N1713_8));

N1713_6 :=__common__( map(trim(C_AMUS_INDX) = ''      => 0.0082841632,
               ((real)c_amus_indx < 119.5) => N1713_7,
                                              0.0082841632));

N1713_5 :=__common__( map(trim(C_HEALTH) = ''              => -0.0014429663,
               ((real)c_health < 5.64999961853) => N1713_6,
                                                   -0.0014429663));

N1713_4 :=__common__( if(((real)c_hval_80k_p < 46.9500007629), N1713_5, 0.0048246931));

N1713_3 :=__common__( if(trim(C_HVAL_80K_P) != '', N1713_4, -0.0017604033));

N1713_2 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 22.5), 0.0056526625, N1713_3));

N1713_1 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N1713_2, -4.2115196e-005));

N1714_9 :=__common__( map(trim(C_YOUNG) = ''              => -0.0034437749,
               ((real)c_young < 25.8499984741) => 0.0068964308,
                                                  -0.0034437749));

N1714_8 :=__common__( map(trim(C_FAMOTF18_P) = ''      => N1714_9,
               ((real)c_famotf18_p < 27.25) => 0.01102635,
                                               N1714_9));

N1714_7 :=__common__( if(((real)c_serv_empl < 92.5), -0.0013864901, N1714_8));

N1714_6 :=__common__( if(trim(C_SERV_EMPL) != '', N1714_7, 0.0037863564));

N1714_5 :=__common__( map(((real)f_rel_homeover150_count_d <= NULL) => -0.0054767909,
               ((real)f_rel_homeover150_count_d < 13.5)  => N1714_6,
                                                            -0.0054767909));

N1714_4 :=__common__( if(((real)c_rest_indx < 150.5), -0.00077045848, 0.0032092832));

N1714_3 :=__common__( if(trim(C_REST_INDX) != '', N1714_4, 0.0016055474));

N1714_2 :=__common__( if(((real)f_rel_felony_count_i < 3.5), N1714_3, N1714_5));

N1714_1 :=__common__( if(((real)f_rel_felony_count_i > NULL), N1714_2, -0.0043648243));

N1715_9 :=__common__( map(trim(C_TRAILER_P) = ''              => 0.010307612,
               ((real)c_trailer_p < 1.54999995232) => -0.00015109113,
                                                      0.010307612));

N1715_8 :=__common__( map(trim(C_INC_15K_P) = ''     => -0.0022296183,
               ((real)c_inc_15k_p < 8.75) => N1715_9,
                                             -0.0022296183));

N1715_7 :=__common__( map(((real)f_add_input_nhood_sfd_pct_d <= NULL)          => 0.0096291304,
               ((real)f_add_input_nhood_sfd_pct_d < 0.782304763794) => 0.00043802487,
                                                                       0.0096291304));

N1715_6 :=__common__( if(((real)c_exp_prod < 37.5), N1715_7, N1715_8));

N1715_5 :=__common__( if(trim(C_EXP_PROD) != '', N1715_6, 0.0075935828));

N1715_4 :=__common__( map(((real)f_srchfraudsrchcount_i <= NULL) => -0.0078364186,
               ((real)f_srchfraudsrchcount_i < 23.5)  => N1715_5,
                                                         -0.0078364186));

N1715_3 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N1715_4, 0.00046661859));

N1715_2 :=__common__( if(((real)r_mos_since_paw_fseen_d < 123.5), N1715_3, -0.007225223));

N1715_1 :=__common__( if(((real)r_mos_since_paw_fseen_d > NULL), N1715_2, -0.0034839847));

N1716_8 :=__common__( map(trim(C_RICH_BLK) = ''      => -0.0034835613,
               ((real)c_rich_blk < 179.5) => 0.0021913264,
                                             -0.0034835613));

N1716_7 :=__common__( map(trim(C_POPOVER25) = ''      => N1716_8,
               ((real)c_popover25 < 656.5) => -0.002915194,
                                              N1716_8));

N1716_6 :=__common__( map(trim(C_HVAL_175K_P) = ''              => 0.0064721242,
               ((real)c_hval_175k_p < 25.0499992371) => N1716_7,
                                                        0.0064721242));

N1716_5 :=__common__( map(trim(C_NO_MOVE) = ''      => 0.0073382279,
               ((real)c_no_move < 186.5) => N1716_6,
                                            0.0073382279));

N1716_4 :=__common__( map(trim(C_HH6_P) = ''              => -0.0064472543,
               ((real)c_hh6_p < 9.64999961853) => N1716_5,
                                                  -0.0064472543));

N1716_3 :=__common__( map(trim(C_MED_HVAL) = ''         => -0.00021535592,
               ((integer)c_med_hval < 45982) => 0.0084389407,
                                                -0.00021535592));

N1716_2 :=__common__( if(((real)r_pb_order_freq_d > NULL), N1716_3, N1716_4));

N1716_1 :=__common__( if(trim(C_HH5_P) != '', N1716_2, 0.0031000293));

N1717_8 :=__common__( map(trim(C_BLUE_EMPL) = ''     => 0.00027333865,
               ((real)c_blue_empl < 98.5) => -0.0036866734,
                                             0.00027333865));

N1717_7 :=__common__( map(trim(C_NEWHOUSE) = ''              => 0.0004778587,
               ((real)c_newhouse < 10.8500003815) => 0.0070961469,
                                                     0.0004778587));

N1717_6 :=__common__( if(((real)r_d32_criminal_count_i < 2.5), -0.00016551963, N1717_7));

N1717_5 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N1717_6, 0.0096334528));

N1717_4 :=__common__( map(trim(C_FINANCE) = ''               => N1717_8,
               ((real)c_finance < 0.350000023842) => N1717_5,
                                                     N1717_8));

N1717_3 :=__common__( map(trim(C_RNT1250_P) = ''              => 0.0049791576,
               ((real)c_rnt1250_p < 33.0499992371) => N1717_4,
                                                      0.0049791576));

N1717_2 :=__common__( if(((real)c_hval_1000k_p < 3.65000009537), N1717_3, -0.0052926333));

N1717_1 :=__common__( if(trim(C_HVAL_1000K_P) != '', N1717_2, -0.00061685459));

N1718_9 :=__common__( map(trim(C_HEALTH) = ''      => 0.0084743108,
               ((real)c_health < 13.25) => -0.0011278509,
                                           0.0084743108));

N1718_8 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1718_9, 0.0042132926));

N1718_7 :=__common__( map(trim(C_MED_RENT) = ''      => N1718_8,
               ((real)c_med_rent < 456.5) => -0.003736581,
                                             N1718_8));

N1718_6 :=__common__( map(trim(C_MED_HVAL) = ''        => -0.014307342,
               ((real)c_med_hval < 88833.5) => -0.0038551107,
                                               -0.014307342));

N1718_5 :=__common__( map(trim(C_FAMOTF18_P) = ''              => N1718_6,
               ((real)c_famotf18_p < 28.0499992371) => -0.0011472159,
                                                       N1718_6));

N1718_4 :=__common__( if(((real)r_c13_curr_addr_lres_d < 14.5), N1718_5, N1718_7));

N1718_3 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1718_4, -0.017455197));

N1718_2 :=__common__( if(((real)c_food < 31.25), 0.00049107658, N1718_3));

N1718_1 :=__common__( if(trim(C_FOOD) != '', N1718_2, -0.00023162129));

N1719_9 :=__common__( map(trim(C_HIGH_ED) = ''              => 0.0015933613,
               ((real)c_high_ed < 17.1500015259) => -0.0090347098,
                                                    0.0015933613));

N1719_8 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL) => 0.00040890227,
               ((integer)f_prevaddrmurderindex_i < 75) => -0.0073359694,
                                                          0.00040890227));

N1719_7 :=__common__( map(((real)c_addr_lres_12mo_ct_i <= NULL) => N1719_9,
               ((real)c_addr_lres_12mo_ct_i < 7.5)   => N1719_8,
                                                        N1719_9));

N1719_6 :=__common__( if(((integer)r_d31_attr_bankruptcy_recency_d < 18), N1719_7, 0.0063855615));

N1719_5 :=__common__( if(((real)r_d31_attr_bankruptcy_recency_d > NULL), N1719_6, 0.0066220645));

N1719_4 :=__common__( if(((real)f_mos_acc_lseen_d < 37.5), 0.0062668865, 0.0006112293));

N1719_3 :=__common__( if(((real)f_mos_acc_lseen_d > NULL), N1719_4, 0.011236864));

N1719_2 :=__common__( if(((real)c_inc_35k_p < 14.5500001907), N1719_3, N1719_5));

N1719_1 :=__common__( if(trim(C_INC_35K_P) != '', N1719_2, -0.0045214968));

N1720_8 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => -0.0019471101,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.743106305599) => -0.012685589,
                                                                      -0.0019471101));

N1720_7 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL) => N1720_8,
               ((real)r_a50_pb_total_dollars_d < 76.5)  => 0.0037791423,
                                                           N1720_8));

N1720_6 :=__common__( if(((real)r_f00_dob_score_d > NULL), N1720_7, -0.042551198));

N1720_5 :=__common__( if(((real)r_d33_eviction_count_i < 5.5), 0.000168444, N1720_6));

N1720_4 :=__common__( if(((real)r_d33_eviction_count_i > NULL), N1720_5, 0.0056537007));

N1720_3 :=__common__( map(trim(C_TRAILER_P) = ''              => -0.0061816027,
               ((real)c_trailer_p < 48.3499984741) => N1720_4,
                                                      -0.0061816027));

N1720_2 :=__common__( if(((real)c_rape < 196.5), N1720_3, 0.0049687957));

N1720_1 :=__common__( if(trim(C_RAPE) != '', N1720_2, -0.004250131));

N1721_10 :=__common__( if(((real)f_rel_ageover30_count_d < 8.5), 0.0024207557, 0.01153001));

N1721_9 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N1721_10, 0.0086290408));

N1721_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1721_9, 0.0043517452));

N1721_7 :=__common__( map(trim(C_BEL_EDU) = ''      => 0.010102843,
               ((real)c_bel_edu < 115.5) => 0.00032340818,
                                            0.010102843));

N1721_6 :=__common__( map(trim(C_RNT1000_P) = ''              => N1721_7,
               ((real)c_rnt1000_p < 8.94999980927) => -0.00093743078,
                                                      N1721_7));

N1721_5 :=__common__( if(((real)c_hval_500k_p < 1.54999995232), N1721_6, -0.0072319291));

N1721_4 :=__common__( if(trim(C_HVAL_500K_P) != '', N1721_5, 0.010809449));

N1721_3 :=__common__( map(((real)f_prevaddrmedianvalue_d <= NULL)     => N1721_8,
               ((integer)f_prevaddrmedianvalue_d < 136690) => N1721_4,
                                                              N1721_8));

N1721_2 :=__common__( if(((real)f_m_bureau_adl_fs_all_d < 108.5), N1721_3, -0.00015925923));

N1721_1 :=__common__( if(((real)f_m_bureau_adl_fs_all_d > NULL), N1721_2, 0.00040306604));

N1722_9 :=__common__( map(((real)r_l79_adls_per_addr_curr_i <= NULL) => 0.00017139575,
               ((real)r_l79_adls_per_addr_curr_i < 0.5)   => 0.0096111315,
                                                             0.00017139575));

N1722_8 :=__common__( if(((real)f_add_input_nhood_bus_pct_i < 0.0636609271169), 0.0031333646, -0.0070286374));

N1722_7 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1722_8, 0.011994919));

N1722_6 :=__common__( map(trim(C_ASSAULT) = ''      => -0.0086776812,
               ((real)c_assault < 179.5) => N1722_7,
                                            -0.0086776812));

N1722_5 :=__common__( map(trim(C_POP_45_54_P) = ''              => 0.00049656477,
               ((real)c_pop_45_54_p < 7.55000019073) => N1722_6,
                                                        0.00049656477));

N1722_4 :=__common__( if(((real)c_unempl < 193.5), N1722_5, N1722_9));

N1722_3 :=__common__( if(trim(C_UNEMPL) != '', N1722_4, -0.00079121441));

N1722_2 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d < 0.995944559574), N1722_3, -0.0059002819));

N1722_1 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d > NULL), N1722_2, -0.03056947));

N1723_8 :=__common__( map(trim(C_POP_75_84_P) = ''              => -0.0052320957,
               ((real)c_pop_75_84_p < 4.55000019073) => 0.0055317601,
                                                        -0.0052320957));

N1723_7 :=__common__( map(trim(C_HVAL_400K_P) = ''               => 0.0012718698,
               ((real)c_hval_400k_p < 0.949999988079) => -0.0073801377,
                                                         0.0012718698));

N1723_6 :=__common__( map(((real)c_dist_best_to_prev_addr_i <= NULL) => N1723_8,
               ((real)c_dist_best_to_prev_addr_i < 8.5)   => N1723_7,
                                                             N1723_8));

N1723_5 :=__common__( map(trim(C_SERV_EMPL) = ''      => 0.0048575996,
               ((real)c_serv_empl < 183.5) => N1723_6,
                                              0.0048575996));

N1723_4 :=__common__( if(((real)c_rape < 176.5), 0.00031770153, N1723_5));

N1723_3 :=__common__( if(trim(C_RAPE) != '', N1723_4, -0.0030670777));

N1723_2 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d < 22.5), 0.005928959, N1723_3));

N1723_1 :=__common__( if(((real)r_c21_m_bureau_adl_fs_d > NULL), N1723_2, -0.020280965));

N1724_8 :=__common__( map(trim(C_PRESCHL) = ''     => 0.003094946,
               ((real)c_preschl < 89.5) => -0.0069634074,
                                           0.003094946));

N1724_7 :=__common__( map(((real)f_curraddrmedianvalue_d <= NULL)    => 0.012066681,
               ((real)f_curraddrmedianvalue_d < 171243.5) => N1724_8,
                                                             0.012066681));

N1724_6 :=__common__( map(trim(C_WHITE_COL) = ''              => -0.010046737,
               ((real)c_white_col < 27.9500007629) => 0.0017327696,
                                                      -0.010046737));

N1724_5 :=__common__( map(trim(C_HVAL_125K_P) = ''              => N1724_7,
               ((real)c_hval_125k_p < 1.95000004768) => N1724_6,
                                                        N1724_7));

N1724_4 :=__common__( if(((real)c_pop_45_54_p < 17.4500007629), N1724_5, 0.0078732772));

N1724_3 :=__common__( if(trim(C_POP_45_54_P) != '', N1724_4, -0.0041300605));

N1724_2 :=__common__( if(((real)c_addr_lres_6mo_ct_i < 6.5), -0.00037351197, N1724_3));

N1724_1 :=__common__( if(((real)c_addr_lres_6mo_ct_i > NULL), N1724_2, -0.0059417936));

N1725_10 :=__common__( map(trim(C_FINANCE) = ''               => 0.0044423009,
                ((real)c_finance < 0.949999988079) => -0.0075876601,
                                                      0.0044423009));

N1725_9 :=__common__( if(((real)r_l70_inp_addr_dnd_i > NULL), 0.0011510549, 0.016281709));

N1725_8 :=__common__( map(trim(C_INC_35K_P) = ''              => 0.013590184,
               ((real)c_inc_35k_p < 8.05000019073) => N1725_9,
                                                      0.013590184));

N1725_7 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1725_8, 0.017545061));

N1725_6 :=__common__( if(((real)r_c14_addr_stability_v2_d < 4.5), N1725_7, N1725_10));

N1725_5 :=__common__( if(((real)r_c14_addr_stability_v2_d > NULL), N1725_6, -0.010204024));

N1725_4 :=__common__( if(((real)f_srchunvrfdphonecount_i < 3.5), -0.00078373901, 0.0039511048));

N1725_3 :=__common__( if(((real)f_srchunvrfdphonecount_i > NULL), N1725_4, 0.0025603853));

N1725_2 :=__common__( if(((real)c_inc_125k_p < 12.0500001907), N1725_3, N1725_5));

N1725_1 :=__common__( if(trim(C_INC_125K_P) != '', N1725_2, 0.0020716817));

N1726_9 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL) => -0.0082884961,
               ((real)f_curraddrcrimeindex_i < 119.5) => 0.0013656256,
                                                         -0.0082884961));

N1726_8 :=__common__( if(((real)f_srchssnsrchcount_i < 14.5), 0.00030724933, N1726_9));

N1726_7 :=__common__( if(((real)f_srchssnsrchcount_i > NULL), N1726_8, 0.0033856713));

N1726_6 :=__common__( map(trim(C_CHILD) = ''              => N1726_7,
               ((real)c_child < 16.6500015259) => 0.007823277,
                                                  N1726_7));

N1726_5 :=__common__( map(trim(C_ROBBERY) = ''      => -0.0011187927,
               ((integer)c_robbery < 19) => 0.0081969355,
                                            -0.0011187927));

N1726_4 :=__common__( if(((real)r_pb_order_freq_d > NULL), N1726_5, N1726_6));

N1726_3 :=__common__( map(trim(C_BIGAPT_P) = ''      => -0.0070376883,
               ((real)c_bigapt_p < 41.75) => N1726_4,
                                             -0.0070376883));

N1726_2 :=__common__( if(((real)c_hh3_p < 36.75), N1726_3, 0.0063277905));

N1726_1 :=__common__( if(trim(C_HH3_P) != '', N1726_2, -0.00051351637));

N1727_9 :=__common__( if(((real)r_c14_addrs_5yr_i < 2.5), 0.011293353, 0.00069084152));

N1727_8 :=__common__( if(((real)r_c14_addrs_5yr_i > NULL), N1727_9, -0.038382622));

N1727_7 :=__common__( map(trim(C_LOW_HVAL) = ''      => 0.0075194843,
               ((real)c_low_hval < 48.25) => 0.00042926403,
                                             0.0075194843));

N1727_6 :=__common__( map(trim(C_ASSAULT) = ''      => -0.0036137468,
               ((real)c_assault < 175.5) => N1727_7,
                                            -0.0036137468));

N1727_5 :=__common__( if(((integer)f_curraddrmedianvalue_d < 33909), -0.0061598281, N1727_6));

N1727_4 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N1727_5, -0.0041096328));

N1727_3 :=__common__( map(trim(C_RNT250_P) = ''              => N1727_8,
               ((real)c_rnt250_p < 37.6500015259) => N1727_4,
                                                     N1727_8));

N1727_2 :=__common__( if(((real)c_popover25 < 619.5), -0.0019394533, N1727_3));

N1727_1 :=__common__( if(trim(C_POPOVER25) != '', N1727_2, -0.003367568));

N1728_9 :=__common__( if(((real)f_srchaddrsrchcount_i < 45.5), 0.0005670037, 0.0080693688));

N1728_8 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N1728_9, 0.013708995));

N1728_7 :=__common__( map(trim(C_HH3_P) = ''              => -0.0011365331,
               ((real)c_hh3_p < 17.0499992371) => 0.0090972302,
                                                  -0.0011365331));

N1728_6 :=__common__( map(trim(C_POP_65_74_P) = ''     => -0.0037412252,
               ((real)c_pop_65_74_p < 3.75) => N1728_7,
                                               -0.0037412252));

N1728_5 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d < 14.5), -0.0066147972, N1728_6));

N1728_4 :=__common__( if(((real)f_mos_inq_banko_om_lseen_d > NULL), N1728_5, -0.013770077));

N1728_3 :=__common__( map(trim(C_HHSIZE) = ''              => N1728_4,
               ((real)c_hhsize < 2.21500015259) => 0.0044341378,
                                                   N1728_4));

N1728_2 :=__common__( if(((real)c_lowinc < 31.1500015259), N1728_3, N1728_8));

N1728_1 :=__common__( if(trim(C_LOWINC) != '', N1728_2, -0.0013853778));

N1729_10 :=__common__( map(((real)f_mos_liens_rel_cj_lseen_d <= NULL) => -0.0028055773,
                ((real)f_mos_liens_rel_cj_lseen_d < 79.5)  => 0.0056397794,
                                                              -0.0028055773));

N1729_9 :=__common__( map(trim(C_INC_50K_P) = ''              => -0.0028980614,
               ((real)c_inc_50k_p < 13.1499996185) => 0.0097173931,
                                                      -0.0028980614));

N1729_8 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.46580722928), 0.00086855575, 0.0060162478));

N1729_7 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1729_8, -0.0040440135));

N1729_6 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1729_7, N1729_9));

N1729_5 :=__common__( if(((real)c_high_ed < 17.4500007629), N1729_6, -0.0013872403));

N1729_4 :=__common__( if(trim(C_HIGH_ED) != '', N1729_5, -0.00058955077));

N1729_3 :=__common__( map(((real)f_srchfraudsrchcountmo_i <= NULL) => 0.0056063178,
               ((real)f_srchfraudsrchcountmo_i < 0.5)   => N1729_4,
                                                           0.0056063178));

N1729_2 :=__common__( if(((real)r_i60_inq_count12_i < 4.5), N1729_3, N1729_10));

N1729_1 :=__common__( if(((real)r_i60_inq_count12_i > NULL), N1729_2, 8.0961741e-005));

N1730_8 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i < 0.0866309255362), 0.005079267, -0.00079365838));

N1730_7 :=__common__( if(((real)f_add_input_nhood_mfd_pct_i > NULL), N1730_8, 0.0013609978));

N1730_6 :=__common__( map(trim(C_MEDI_INDX) = ''      => -0.0059261819,
               ((real)c_medi_indx < 113.5) => N1730_7,
                                              -0.0059261819));

N1730_5 :=__common__( if(((real)c_ownocc_p < 15.4499998093), 0.0088280416, N1730_6));

N1730_4 :=__common__( if(trim(C_OWNOCC_P) != '', N1730_5, 0.0024939465));

N1730_3 :=__common__( if(((real)f_liens_unrel_ot_total_amt_i < 396.5), N1730_4, 0.010992481));

N1730_2 :=__common__( if(((real)f_liens_unrel_ot_total_amt_i > NULL), N1730_3, -0.005242599));

N1730_1 :=__common__( map(((real)f_inq_per_ssn_i <= NULL) => N1730_2,
               ((real)f_inq_per_ssn_i < 3.5)   => -0.0008038468,
                                                  N1730_2));

N1731_8 :=__common__( if(((real)r_c14_addrs_10yr_i < 8.5), 0.0077800469, -0.0032251642));

N1731_7 :=__common__( if(((real)r_c14_addrs_10yr_i > NULL), N1731_8, -0.028293608));

N1731_6 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.0073519808,
               ((real)c_sub_bus < 119.5) => -0.00056864292,
                                            0.0073519808));

N1731_5 :=__common__( map(trim(C_POP_35_44_P) = ''              => -0.0022508669,
               ((real)c_pop_35_44_p < 15.6499996185) => 4.2955202e-005,
                                                        -0.0022508669));

N1731_4 :=__common__( map(((real)f_inq_adls_per_phone_i <= NULL) => N1731_6,
               ((real)f_inq_adls_per_phone_i < 1.5)   => N1731_5,
                                                         N1731_6));

N1731_3 :=__common__( map(trim(C_INC_150K_P) = ''              => -0.0068383332,
               ((real)c_inc_150k_p < 10.0500001907) => N1731_4,
                                                       -0.0068383332));

N1731_2 :=__common__( if(((real)c_very_rich < 177.5), N1731_3, N1731_7));

N1731_1 :=__common__( if(trim(C_VERY_RICH) != '', N1731_2, 0.0010571978));

N1732_8 :=__common__( map(trim(C_RENTAL) = ''      => -0.0005949268,
               ((real)c_rental < 146.5) => -0.011386183,
                                           -0.0005949268));

N1732_7 :=__common__( if(((real)c_hval_80k_p < 26.6500015259), 0.00014225317, N1732_8));

N1732_6 :=__common__( if(trim(C_HVAL_80K_P) != '', N1732_7, -0.0050500598));

N1732_5 :=__common__( map(((real)f_util_adl_count_n <= NULL) => 0.00029541947,
               ((real)f_util_adl_count_n < 2.5)   => -0.005798014,
                                                     0.00029541947));

N1732_4 :=__common__( map(trim(C_ASIAN_LANG) = ''      => -0.004454679,
               ((real)c_asian_lang < 168.5) => 0.0017181074,
                                               -0.004454679));

N1732_3 :=__common__( map(trim(C_RENTAL) = ''      => N1732_5,
               ((real)c_rental < 175.5) => N1732_4,
                                           N1732_5));

N1732_2 :=__common__( map(((real)r_d32_mos_since_fel_ls_d <= NULL) => N1732_3,
               ((real)r_d32_mos_since_fel_ls_d < 81.5)  => -0.0071064698,
                                                           N1732_3));

N1732_1 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1732_2, N1732_6));

N1733_8 :=__common__( map(trim(C_SPAN_LANG) = ''      => -0.0093829451,
               ((real)c_span_lang < 125.5) => 0.0019874167,
                                              -0.0093829451));

N1733_7 :=__common__( map(((real)f_prevaddrcartheftindex_i <= NULL)  => 0.00060530265,
               ((integer)f_prevaddrcartheftindex_i < 127) => 0.0075386933,
                                                             0.00060530265));

N1733_6 :=__common__( map(trim(C_RAPE) = ''     => N1733_7,
               ((real)c_rape < 60.5) => -0.0048574517,
                                        N1733_7));

N1733_5 :=__common__( map(trim(C_HVAL_150K_P) = ''              => 0.0092123939,
               ((real)c_hval_150k_p < 15.0500001907) => N1733_6,
                                                        0.0092123939));

N1733_4 :=__common__( if(((real)c_hval_125k_p < 18.9500007629), N1733_5, N1733_8));

N1733_3 :=__common__( if(trim(C_HVAL_125K_P) != '', N1733_4, 0.0034789175));

N1733_2 :=__common__( if(((real)r_d32_criminal_count_i < 3.5), -0.00035110712, N1733_3));

N1733_1 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N1733_2, 0.0002665412));

N1734_8 :=__common__( map(trim(C_WHITE_COL) = ''              => -3.0135011e-005,
               ((real)c_white_col < 20.4500007629) => 0.010755374,
                                                      -3.0135011e-005));

N1734_7 :=__common__( map(trim(C_RETIRED2) = ''     => 0.0020373601,
               ((real)c_retired2 < 46.5) => -0.0031706954,
                                            0.0020373601));

N1734_6 :=__common__( map(trim(C_HH4_P) = ''              => N1734_7,
               ((real)c_hh4_p < 13.1499996185) => -0.0017236036,
                                                  N1734_7));

N1734_5 :=__common__( map(trim(C_BLUE_COL) = ''      => N1734_8,
               ((real)c_blue_col < 23.25) => N1734_6,
                                             N1734_8));

N1734_4 :=__common__( if(((integer)c_popover18 < 2635), N1734_5, 0.0073640976));

N1734_3 :=__common__( if(trim(C_POPOVER18) != '', N1734_4, 0.0035061556));

N1734_2 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i < 61.75), -0.0071169531, -0.00010914632));

N1734_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N1734_2, N1734_3));

N1735_9 :=__common__( if(((real)c_rest_indx < 151.5), 0.0012006169, 0.0091542326));

N1735_8 :=__common__( if(trim(C_REST_INDX) != '', N1735_9, 0.0050996145));

N1735_7 :=__common__( map(trim(C_RETIRED) = ''     => 0.00015707686,
               ((real)c_retired < 3.75) => 0.0076240533,
                                           0.00015707686));

N1735_6 :=__common__( map(trim(C_INC_15K_P) = ''              => 0.0012570897,
               ((real)c_inc_15k_p < 36.8499984741) => -0.0039597156,
                                                      0.0012570897));

N1735_5 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)    => 0.0058973969,
               ((integer)f_prevaddrmedianincome_d < 65034) => N1735_6,
                                                              0.0058973969));

N1735_4 :=__common__( if(((real)c_ownocc_p < 45.0499992371), N1735_5, N1735_7));

N1735_3 :=__common__( if(trim(C_OWNOCC_P) != '', N1735_4, -0.0061548374));

N1735_2 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.114943742752), N1735_3, N1735_8));

N1735_1 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1735_2, 0.0018135918));

N1736_10 :=__common__( if(((real)c_inc_15k_p < 34.75), 0.0021261686, -0.0032386427));

N1736_9 :=__common__( if(trim(C_INC_15K_P) != '', N1736_10, 0.0065130283));

N1736_8 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => -0.001398673,
               ((real)f_prevaddrmedianincome_d < 41754.5) => -0.0081650809,
                                                             -0.001398673));

N1736_7 :=__common__( map(trim(C_RENTOCC_P) = ''      => 0.00028610601,
               ((real)c_rentocc_p < 39.75) => N1736_8,
                                              0.00028610601));

N1736_6 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1736_7, -0.0021632224));

N1736_5 :=__common__( map(trim(C_HVAL_80K_P) = ''              => 0.0050986545,
               ((real)c_hval_80k_p < 43.4500007629) => N1736_6,
                                                       0.0050986545));

N1736_4 :=__common__( if(((real)c_unemp < 5.25), 0.00098659193, N1736_5));

N1736_3 :=__common__( if(trim(C_UNEMP) != '', N1736_4, 0.0014338802));

N1736_2 :=__common__( if(((real)f_prevaddrageoldest_d < 68.5), N1736_3, N1736_9));

N1736_1 :=__common__( if(((real)f_prevaddrageoldest_d > NULL), N1736_2, -0.00017354066));

N1737_8 :=__common__( map(trim(C_BARGAINS) = ''      => 0.002564944,
               ((real)c_bargains < 116.5) => -0.0066743544,
                                             0.002564944));

N1737_7 :=__common__( if(((real)r_i60_inq_count12_i < 3.5), N1737_8, -0.011085322));

N1737_6 :=__common__( if(((real)r_i60_inq_count12_i > NULL), N1737_7, -0.030213892));

N1737_5 :=__common__( map(trim(C_HVAL_20K_P) = ''                => -0.0075211391,
               ((real)c_hval_20k_p < 0.0500000007451) => 0.0014030555,
                                                         -0.0075211391));

N1737_4 :=__common__( map(trim(C_TOTCRIME) = ''      => 0.0064289279,
               ((integer)c_totcrime < 76) => N1737_5,
                                             0.0064289279));

N1737_3 :=__common__( map(trim(C_LARCENY) = ''     => N1737_6,
               ((real)c_larceny < 99.5) => N1737_4,
                                           N1737_6));

N1737_2 :=__common__( if(((real)c_inc_200k_p < 4.25), 0.00042747854, N1737_3));

N1737_1 :=__common__( if(trim(C_INC_200K_P) != '', N1737_2, -0.0029528549));

N1738_7 :=__common__( map(trim(C_CIV_EMP) = ''              => 0.0065462572,
               ((real)c_civ_emp < 59.6500015259) => -0.0042610859,
                                                    0.0065462572));

N1738_6 :=__common__( map(trim(C_NEWHOUSE) = ''              => -0.011741531,
               ((real)c_newhouse < 3.95000004768) => -0.0023839931,
                                                     -0.011741531));

N1738_5 :=__common__( map(trim(C_HH3_P) = ''              => N1738_7,
               ((real)c_hh3_p < 19.0499992371) => N1738_6,
                                                  N1738_7));

N1738_4 :=__common__( map(trim(C_NO_CAR) = ''      => 0.0036930957,
               ((real)c_no_car < 104.5) => -6.2601605e-005,
                                           0.0036930957));

N1738_3 :=__common__( map(trim(C_LUX_PROD) = ''     => N1738_4,
               ((real)c_lux_prod < 70.5) => -0.00016591784,
                                            N1738_4));

N1738_2 :=__common__( if(((real)c_sfdu_p < 97.4499969482), N1738_3, N1738_5));

N1738_1 :=__common__( if(trim(C_SFDU_P) != '', N1738_2, 0.002169099));

N1739_10 :=__common__( map(trim(C_INC_200K_P) = ''              => -0.0066256944,
                ((real)c_inc_200k_p < 1.95000004768) => 0.0052841379,
                                                        -0.0066256944));

N1739_9 :=__common__( map(trim(C_HIGHINC) = ''              => -0.0020128736,
               ((real)c_highinc < 2.65000009537) => -0.0090017139,
                                                    -0.0020128736));

N1739_8 :=__common__( if(((real)c_popover25 < 982.5), N1739_9, N1739_10));

N1739_7 :=__common__( if(trim(C_POPOVER25) != '', N1739_8, -0.0092913369));

N1739_6 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => 0.002998059,
               ((real)r_c13_avg_lres_d < 96.5)  => N1739_7,
                                                   0.002998059));

N1739_5 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i < 165.5), 0.00074329744, N1739_6));

N1739_4 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N1739_5, 0.010704427));

N1739_3 :=__common__( if(((real)f_curraddrmurderindex_i < 180.5), -0.00070584133, 0.0042324902));

N1739_2 :=__common__( if(((real)f_curraddrmurderindex_i > NULL), N1739_3, -0.0033713054));

N1739_1 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1739_2, N1739_4));

N1740_9 :=__common__( map(trim(C_RETAIL) = ''              => 0.01030956,
               ((real)c_retail < 23.0499992371) => 0.0012752723,
                                                   0.01030956));

N1740_8 :=__common__( map(((real)f_mos_inq_banko_om_fseen_d <= NULL) => -4.9761974e-005,
               ((real)f_mos_inq_banko_om_fseen_d < 6.5)   => 0.0060831685,
                                                             -4.9761974e-005));

N1740_7 :=__common__( map(trim(C_POP_75_84_P) = ''              => N1740_9,
               ((real)c_pop_75_84_p < 6.14999961853) => N1740_8,
                                                        N1740_9));

N1740_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0728112235665), -0.0084025927, 0.0009104743));

N1740_5 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1740_6, 0.0020521866));

N1740_4 :=__common__( map(trim(C_FINANCE) = ''     => 0.0021219798,
               ((real)c_finance < 2.75) => N1740_5,
                                           0.0021219798));

N1740_3 :=__common__( map(((real)f_prevaddrlenofres_d <= NULL) => N1740_7,
               ((real)f_prevaddrlenofres_d < 1.5)   => N1740_4,
                                                       N1740_7));

N1740_2 :=__common__( if(trim(C_RETIRED2) != '', N1740_3, 0.0019348328));

N1740_1 :=__common__( if(((real)f_prevaddrlenofres_d > NULL), N1740_2, -0.011423049));

N1741_9 :=__common__( map(trim(C_HVAL_200K_P) = ''     => -0.0041089631,
               ((real)c_hval_200k_p < 6.75) => 0.0054983193,
                                               -0.0041089631));

N1741_8 :=__common__( map(((real)r_i60_inq_recency_d <= NULL) => -0.0021990771,
               ((real)r_i60_inq_recency_d < 4.5)   => -0.0085679864,
                                                      -0.0021990771));

N1741_7 :=__common__( if(((real)c_dist_input_to_prev_addr_i < 8.5), N1741_8, N1741_9));

N1741_6 :=__common__( if(((real)c_dist_input_to_prev_addr_i > NULL), N1741_7, -0.0066665905));

N1741_5 :=__common__( map(trim(C_LOWRENT) = ''              => 0.00038141467,
               ((real)c_lowrent < 5.85000038147) => N1741_6,
                                                    0.00038141467));

N1741_4 :=__common__( if(((real)f_add_input_nhood_bus_pct_i > NULL), N1741_5, -9.8980497e-005));

N1741_3 :=__common__( map(trim(C_HVAL_300K_P) = ''              => 0.0075065582,
               ((real)c_hval_300k_p < 25.4500007629) => N1741_4,
                                                        0.0075065582));

N1741_2 :=__common__( if(((real)c_inc_35k_p < 3.15000009537), 0.0055478815, N1741_3));

N1741_1 :=__common__( if(trim(C_INC_35K_P) != '', N1741_2, 0.0022496114));

N1742_8 :=__common__( map(trim(C_POP_18_24_P) = ''              => 0.0025439597,
               ((real)c_pop_18_24_p < 12.3500003815) => -0.0067897728,
                                                        0.0025439597));

N1742_7 :=__common__( map(trim(C_RENTAL) = ''      => -0.0052083105,
               ((real)c_rental < 189.5) => 0.0023934267,
                                           -0.0052083105));

N1742_6 :=__common__( map(trim(C_HVAL_200K_P) = ''     => N1742_8,
               ((real)c_hval_200k_p < 1.25) => N1742_7,
                                               N1742_8));

N1742_5 :=__common__( if(((real)c_hval_175k_p < 3.65000009537), N1742_6, 0.0022707078));

N1742_4 :=__common__( if(trim(C_HVAL_175K_P) != '', N1742_5, 0.0084101387));

N1742_3 :=__common__( map(((real)f_srchfraudsrchcountmo_i <= NULL) => -0.006049091,
               ((real)f_srchfraudsrchcountmo_i < 1.5)   => N1742_4,
                                                           -0.006049091));

N1742_2 :=__common__( if(((real)f_rel_homeover50_count_d < 8.5), -0.0013384306, N1742_3));

N1742_1 :=__common__( if(((real)f_rel_homeover50_count_d > NULL), N1742_2, 8.6617451e-005));

N1743_9 :=__common__( map(((real)f_historical_count_d <= NULL) => 0.0041654839,
               ((real)f_historical_count_d < 3.5)   => -0.0044049479,
                                                       0.0041654839));

N1743_8 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => 0.0071116455,
               ((real)f_srchssnsrchcount_i < 5.5)   => 0.00092357252,
                                                       0.0071116455));

N1743_7 :=__common__( map(((real)f_rel_bankrupt_count_i <= NULL) => N1743_9,
               ((real)f_rel_bankrupt_count_i < 2.5)   => N1743_8,
                                                         N1743_9));

N1743_6 :=__common__( if(((real)c_popover18 < 567.5), -0.004464631, N1743_7));

N1743_5 :=__common__( if(trim(C_POPOVER18) != '', N1743_6, 0.0025714789));

N1743_4 :=__common__( if(((real)f_attr_arrest_recency_d < 79.5), -0.0075154731, -0.0008951054));

N1743_3 :=__common__( if(((real)f_attr_arrest_recency_d > NULL), N1743_4, -0.0056676514));

N1743_2 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d < 0.896805226803), N1743_3, N1743_5));

N1743_1 :=__common__( if(((real)f_add_curr_nhood_sfd_pct_d > NULL), N1743_2, 0.0013316656));

N1744_9 :=__common__( map(((real)f_mos_liens_unrel_cj_lseen_d <= NULL) => -0.0059493643,
               ((real)f_mos_liens_unrel_cj_lseen_d < 21.5)  => 0.0032154654,
                                                               -0.0059493643));

N1744_8 :=__common__( map(trim(C_UNEMPL) = ''      => -0.0090749404,
               ((real)c_unempl < 165.5) => N1744_9,
                                           -0.0090749404));

N1744_7 :=__common__( map(trim(C_FAMMAR18_P) = ''               => 0.00029829787,
               ((real)c_fammar18_p < 0.300000011921) => -0.0054803885,
                                                        0.00029829787));

N1744_6 :=__common__( map(((real)r_d34_unrel_lien60_count_i <= NULL) => N1744_8,
               ((real)r_d34_unrel_lien60_count_i < 2.5)   => N1744_7,
                                                             N1744_8));

N1744_5 :=__common__( if(trim(C_FAMMAR18_P) != '', N1744_6, -0.0040889398));

N1744_4 :=__common__( if(((real)f_rel_ageover30_count_d < 22.5), 0.0028976231, -0.0048261824));

N1744_3 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N1744_4, -0.0017177384));

N1744_2 :=__common__( if(((real)r_d32_mos_since_crim_ls_d < 44.5), N1744_3, N1744_5));

N1744_1 :=__common__( if(((real)r_d32_mos_since_crim_ls_d > NULL), N1744_2, -0.00091499132));

N1745_9 :=__common__( if(((real)r_c13_avg_lres_d < 133.5), 0.0020203436, -0.0050040008));

N1745_8 :=__common__( if(((real)r_c13_avg_lres_d > NULL), N1745_9, 0.0056165857));

N1745_7 :=__common__( if(((real)f_rel_count_i < 3.5), 0.0055780352, -0.0020450943));

N1745_6 :=__common__( if(((real)f_rel_count_i > NULL), N1745_7, -0.0073122963));

N1745_5 :=__common__( map(trim(C_RELIG_INDX) = ''     => N1745_6,
               ((real)c_relig_indx < 84.5) => 0.0013430814,
                                              N1745_6));

N1745_4 :=__common__( map(trim(C_HVAL_40K_P) = ''     => N1745_8,
               ((real)c_hval_40k_p < 3.75) => N1745_5,
                                              N1745_8));

N1745_3 :=__common__( map(trim(C_MANUFACTURING) = ''      => -0.0062474257,
               ((real)c_manufacturing < 46.25) => N1745_4,
                                                  -0.0062474257));

N1745_2 :=__common__( if(((real)c_edu_indx < 136.5), N1745_3, -0.0060951689));

N1745_1 :=__common__( if(trim(C_EDU_INDX) != '', N1745_2, -0.00055614734));

N1746_8 :=__common__( map(trim(C_LAR_FAM) = ''      => 0.010662915,
               ((real)c_lar_fam < 113.5) => -0.00019577311,
                                            0.010662915));

N1746_7 :=__common__( map(((real)f_add_input_mobility_index_n <= NULL)          => -0.004279707,
               ((real)f_add_input_mobility_index_n < 0.425687074661) => 0.0033653333,
                                                                        -0.004279707));

N1746_6 :=__common__( map(trim(C_CARTHEFT) = ''      => N1746_7,
               ((real)c_cartheft < 175.5) => -0.0024931006,
                                             N1746_7));

N1746_5 :=__common__( map(((real)f_srchfraudsrchcountyr_i <= NULL) => 0.00064575812,
               ((real)f_srchfraudsrchcountyr_i < 1.5)   => N1746_6,
                                                           0.00064575812));

N1746_4 :=__common__( if(((integer)f_liens_unrel_sc_total_amt_i < 5601), N1746_5, 0.0055768725));

N1746_3 :=__common__( if(((real)f_liens_unrel_sc_total_amt_i > NULL), N1746_4, 0.0013514808));

N1746_2 :=__common__( if(((real)c_employees < 4454.5), N1746_3, N1746_8));

N1746_1 :=__common__( if(trim(C_EMPLOYEES) != '', N1746_2, 0.0031491367));

N1747_8 :=__common__( map(((real)c_comb_age_d <= NULL) => -6.0549797e-005,
               ((real)c_comb_age_d < 39.5)  => 0.010646157,
                                               -6.0549797e-005));

N1747_7 :=__common__( map((fp_segment in ['1 SSN Prob', '4 Bureau Only'])                                       => -0.013054517,
               (fp_segment in ['2 NAS 479', '3 New DID', '5 Derog', '6 Recent Activity', '7 Other']) => 0.011194511,
                                                                                                        0.011194511));

N1747_6 :=__common__( map(trim(C_NO_CAR) = ''      => 0.00041651325,
               ((real)c_no_car < 128.5) => N1747_7,
                                           0.00041651325));

N1747_5 :=__common__( map(trim(C_INC_25K_P) = ''              => N1747_6,
               ((real)c_inc_25k_p < 13.8500003815) => -0.00018031189,
                                                      N1747_6));

N1747_4 :=__common__( if(((real)c_hval_125k_p < 9.94999980927), -0.00069815446, N1747_5));

N1747_3 :=__common__( if(trim(C_HVAL_125K_P) != '', N1747_4, 0.0010600511));

N1747_2 :=__common__( if(((integer)f_liens_rel_cj_total_amt_i < 1152), N1747_3, N1747_8));

N1747_1 :=__common__( if(((real)f_liens_rel_cj_total_amt_i > NULL), N1747_2, -0.0014710156));

N1748_8 :=__common__( map(((real)r_c14_addr_stability_v2_d <= NULL) => 0.0077407657,
               ((real)r_c14_addr_stability_v2_d < 2.5)   => -0.00070463167,
                                                            0.0077407657));

N1748_7 :=__common__( map(((real)f_rel_felony_count_i <= NULL) => N1748_8,
               ((real)f_rel_felony_count_i < 3.5)   => 0.00036554576,
                                                       N1748_8));

N1748_6 :=__common__( if(((real)f_srchaddrsrchcount_i < 19.5), N1748_7, -0.002873292));

N1748_5 :=__common__( if(((real)f_srchaddrsrchcount_i > NULL), N1748_6, -0.013523146));

N1748_4 :=__common__( map(trim(C_HVAL_20K_P) = ''              => 0.0074953895,
               ((real)c_hval_20k_p < 23.8499984741) => N1748_5,
                                                       0.0074953895));

N1748_3 :=__common__( map(trim(C_ROBBERY) = ''      => N1748_4,
               ((integer)c_robbery < 19) => 0.0088479133,
                                            N1748_4));

N1748_2 :=__common__( if(((real)c_serv_empl < 100.5), -0.00086258108, N1748_3));

N1748_1 :=__common__( if(trim(C_SERV_EMPL) != '', N1748_2, -0.0048219938));

N1749_8 :=__common__( map(trim(C_OWNOCC_P) = ''              => 0.0042199561,
               ((real)c_ownocc_p < 46.0999984741) => -0.0074059199,
                                                     0.0042199561));

N1749_7 :=__common__( map(trim(C_POP_55_64_P) = ''              => -0.0097376053,
               ((real)c_pop_55_64_p < 9.14999961853) => N1749_8,
                                                        -0.0097376053));

N1749_6 :=__common__( map(trim(C_POP_45_54_P) = ''              => -0.0016600384,
               ((real)c_pop_45_54_p < 11.0500001907) => 0.006823764,
                                                        -0.0016600384));

N1749_5 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.334186136723), N1749_6, N1749_7));

N1749_4 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1749_5, -0.0032234014));

N1749_3 :=__common__( map(trim(C_CPIALL) = ''              => -0.0068094677,
               ((real)c_cpiall < 224.399993896) => 0.00080741772,
                                                   -0.0068094677));

N1749_2 :=__common__( if(((real)c_blue_empl < 158.5), N1749_3, N1749_4));

N1749_1 :=__common__( if(trim(C_BLUE_EMPL) != '', N1749_2, -0.00057717829));

N1750_9 :=__common__( map(((real)f_add_curr_mobility_index_n <= NULL)          => -0.0013505568,
               ((real)f_add_curr_mobility_index_n < 0.426960766315) => 0.0099152407,
                                                                       -0.0013505568));

N1750_8 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => 0.00060531462,
               ((real)f_mos_liens_unrel_cj_fseen_d < 144.5) => N1750_9,
                                                               0.00060531462));

N1750_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0101993530989), 0.011429753, N1750_8));

N1750_6 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1750_7, 0.0082027877));

N1750_5 :=__common__( if(((integer)f_prevaddrmedianvalue_d < 82616), -0.00049329412, N1750_6));

N1750_4 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N1750_5, -0.0031161039));

N1750_3 :=__common__( map(trim(C_HH4_P) = ''              => -0.0021984778,
               ((real)c_hh4_p < 17.9500007629) => N1750_4,
                                                  -0.0021984778));

N1750_2 :=__common__( if(((real)c_young < 25.5499992371), -0.001081781, N1750_3));

N1750_1 :=__common__( if(trim(C_YOUNG) != '', N1750_2, 0.0003492496));

N1751_9 :=__common__( map(((real)f_inq_per_addr_i <= NULL) => -0.0021683681,
               ((real)f_inq_per_addr_i < 6.5)   => 0.0067494924,
                                                   -0.0021683681));

N1751_8 :=__common__( map(((real)f_prevaddrageoldest_d <= NULL) => -0.0021037054,
               ((real)f_prevaddrageoldest_d < 98.5)  => N1751_9,
                                                        -0.0021037054));

N1751_7 :=__common__( if(((real)f_divssnidmsrcurelcount_i < 0.5), -0.0031480572, N1751_8));

N1751_6 :=__common__( if(((real)f_divssnidmsrcurelcount_i > NULL), N1751_7, 0.0061882717));

N1751_5 :=__common__( map(trim(C_POP_75_84_P) = ''              => -0.00053036266,
               ((real)c_pop_75_84_p < 2.95000004768) => 0.0084944209,
                                                        -0.00053036266));

N1751_4 :=__common__( if(((real)r_c13_curr_addr_lres_d < 112.5), -0.00098005756, N1751_5));

N1751_3 :=__common__( if(((real)r_c13_curr_addr_lres_d > NULL), N1751_4, 0.0046349621));

N1751_2 :=__common__( if(((real)c_pop_45_54_p < 17.25), N1751_3, N1751_6));

N1751_1 :=__common__( if(trim(C_POP_45_54_P) != '', N1751_2, 0.0039068699));

N1752_8 :=__common__( map(trim(C_BEL_EDU) = ''      => 0.0018701901,
               ((real)c_bel_edu < 142.5) => 0.012130613,
                                            0.0018701901));

N1752_7 :=__common__( map(trim(C_CHILD) = ''              => 0.00043945047,
               ((real)c_child < 26.0499992371) => 0.011042725,
                                                  0.00043945047));

N1752_6 :=__common__( map(trim(C_FOOD) = ''      => N1752_7,
               ((real)c_food < 54.25) => -0.0012835484,
                                         N1752_7));

N1752_5 :=__common__( map(trim(C_HVAL_400K_P) = ''              => 0.0035813878,
               ((real)c_hval_400k_p < 3.54999995232) => N1752_6,
                                                        0.0035813878));

N1752_4 :=__common__( if(((real)c_hval_40k_p < 19.1500015259), N1752_5, N1752_8));

N1752_3 :=__common__( if(trim(C_HVAL_40K_P) != '', N1752_4, 0.0058673269));

N1752_2 :=__common__( if(((integer)f_fp_prevaddrcrimeindex_i < 99), -0.0015107988, N1752_3));

N1752_1 :=__common__( if(((real)f_fp_prevaddrcrimeindex_i > NULL), N1752_2, 0.00067264581));

N1753_9 :=__common__( map(((real)r_i60_inq_count12_i <= NULL) => -0.0025447798,
               ((real)r_i60_inq_count12_i < 4.5)   => 0.00018470509,
                                                      -0.0025447798));

N1753_8 :=__common__( map(((real)f_inq_count24_i <= NULL) => 0.0057269228,
               ((real)f_inq_count24_i < 24.5)  => N1753_9,
                                                  0.0057269228));

N1753_7 :=__common__( map(((real)f_rel_ageover30_count_d <= NULL) => -0.0035086886,
               ((real)f_rel_ageover30_count_d < 22.5)  => N1753_8,
                                                          -0.0035086886));

N1753_6 :=__common__( map(trim(C_BLUE_COL) = ''              => N1753_7,
               ((real)c_blue_col < 4.64999961853) => -0.0074308338,
                                                     N1753_7));

N1753_5 :=__common__( if(((real)c_totcrime < 197.5), N1753_6, -0.0058677619));

N1753_4 :=__common__( if(trim(C_TOTCRIME) != '', N1753_5, -0.0031218283));

N1753_3 :=__common__( if(((real)f_rel_ageover30_count_d > NULL), N1753_4, 0.0023419949));

N1753_2 :=__common__( if(((integer)f_liens_unrel_o_total_amt_i < 2197), N1753_3, 0.0077596842));

N1753_1 :=__common__( if(((real)f_liens_unrel_o_total_amt_i > NULL), N1753_2, 0.0040530395));

N1754_8 :=__common__( map(trim(C_RELIG_INDX) = ''      => 0.0048886581,
               ((real)c_relig_indx < 136.5) => -0.0049709722,
                                               0.0048886581));

N1754_7 :=__common__( map(trim(C_RICH_FAM) = ''     => N1754_8,
               ((real)c_rich_fam < 59.5) => -0.0082011428,
                                            N1754_8));

N1754_6 :=__common__( map(((real)r_c13_avg_lres_d <= NULL) => N1754_7,
               ((real)r_c13_avg_lres_d < 21.5)  => 0.0056002074,
                                                   N1754_7));

N1754_5 :=__common__( map(((real)f_srchssnsrchcount_i <= NULL) => N1754_6,
               ((real)f_srchssnsrchcount_i < 18.5)  => 0.00016944092,
                                                       N1754_6));

N1754_4 :=__common__( if(((real)f_liens_unrel_cj_total_amt_i < 14119.5), N1754_5, 0.0069281783));

N1754_3 :=__common__( if(((real)f_liens_unrel_cj_total_amt_i > NULL), N1754_4, -0.002189431));

N1754_2 :=__common__( if(((real)c_hh6_p < 10.9499998093), N1754_3, 0.0051488981));

N1754_1 :=__common__( if(trim(C_HH6_P) != '', N1754_2, 0.00072503849));

N1755_9 :=__common__( map(trim(C_ROBBERY) = ''      => -0.00074197125,
               ((real)c_robbery < 149.5) => -0.0092118962,
                                            -0.00074197125));

N1755_8 :=__common__( map(trim(C_HH4_P) = ''              => -0.0042656391,
               ((real)c_hh4_p < 9.55000019073) => 0.0067712357,
                                                  -0.0042656391));

N1755_7 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), -0.0007660718, N1755_8));

N1755_6 :=__common__( map(trim(C_POP_12_17_P) = ''              => N1755_9,
               ((real)c_pop_12_17_p < 14.0500001907) => N1755_7,
                                                        N1755_9));

N1755_5 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => N1755_6,
               ((real)f_prevaddrmedianincome_d < 12373.5) => 0.0040136266,
                                                             N1755_6));

N1755_4 :=__common__( if(((real)f_srchphonesrchcount_i < 17.5), N1755_5, 0.0075021783));

N1755_3 :=__common__( if(((real)f_srchphonesrchcount_i > NULL), N1755_4, -0.00030636396));

N1755_2 :=__common__( if(((real)c_hval_200k_p < 4.05000019073), N1755_3, 0.0017404617));

N1755_1 :=__common__( if(trim(C_HVAL_200K_P) != '', N1755_2, 0.0040166619));

N1756_8 :=__common__( map(trim(C_POP_75_84_P) = ''              => 0.0079581027,
               ((real)c_pop_75_84_p < 11.8500003815) => -0.00019623225,
                                                        0.0079581027));

N1756_7 :=__common__( map(trim(C_BORN_USA) = ''      => -0.00062994344,
               ((real)c_born_usa < 158.5) => 0.009814329,
                                             -0.00062994344));

N1756_6 :=__common__( map(trim(C_EASIQLIFE) = ''     => N1756_8,
               ((real)c_easiqlife < 87.5) => N1756_7,
                                             N1756_8));

N1756_5 :=__common__( map(trim(C_BARGAINS) = ''      => 0.0081357199,
               ((real)c_bargains < 181.5) => -0.0015123616,
                                             0.0081357199));

N1756_4 :=__common__( if(((real)f_prevaddrlenofres_d < 31.5), N1756_5, -0.0038751255));

N1756_3 :=__common__( if(((real)f_prevaddrlenofres_d > NULL), N1756_4, -0.0062226187));

N1756_2 :=__common__( if(((real)c_easiqlife < 80.5), N1756_3, N1756_6));

N1756_1 :=__common__( if(trim(C_EASIQLIFE) != '', N1756_2, 0.0022393595));

N1757_10 :=__common__( if(((real)f_rel_incomeover25_count_d < 7.5), -0.007131392, 0.0004529385));

N1757_9 :=__common__( if(((real)f_rel_incomeover25_count_d > NULL), N1757_10, 0.0047407981));

N1757_8 :=__common__( map(trim(C_RETIRED2) = ''     => N1757_9,
               ((real)c_retired2 < 49.5) => 0.0052452204,
                                            N1757_9));

N1757_7 :=__common__( if(((real)f_addrchangeincomediff_d < 11109.5), -0.00042147769, -0.0060603748));

N1757_6 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1757_7, N1757_8));

N1757_5 :=__common__( map(((real)r_a50_pb_average_dollars_d <= NULL) => 0.0068997147,
               ((real)r_a50_pb_average_dollars_d < 184.5) => -0.00038596802,
                                                             0.0068997147));

N1757_4 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i < 0.406275302172), -5.5710687e-005, N1757_5));

N1757_3 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1757_4, -0.00012674632));

N1757_2 :=__common__( if(((real)c_serv_empl < 132.5), N1757_3, N1757_6));

N1757_1 :=__common__( if(trim(C_SERV_EMPL) != '', N1757_2, -0.00066523574));

N1758_10 :=__common__( if(((real)c_young < 30.6500015259), -0.0013076311, 0.0068286777));

N1758_9 :=__common__( if(trim(C_YOUNG) != '', N1758_10, -0.0014764798));

N1758_8 :=__common__( if(((real)c_professional < 3.54999995232), 0.00051161954, 0.0099991417));

N1758_7 :=__common__( if(trim(C_PROFESSIONAL) != '', N1758_8, 0.012383918));

N1758_6 :=__common__( map(((real)f_curraddrmedianincome_d <= NULL)    => -0.0021263727,
               ((integer)f_curraddrmedianincome_d < 35679) => N1758_7,
                                                              -0.0021263727));

N1758_5 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i < 0.5), -0.0061198349, N1758_6));

N1758_4 :=__common__( if(((real)f_crim_rel_under25miles_cnt_i > NULL), N1758_5, -0.010421221));

N1758_3 :=__common__( map(((real)f_srchaddrsrchcountmo_i <= NULL) => -0.0088104398,
               ((real)f_srchaddrsrchcountmo_i < 0.5)   => N1758_4,
                                                          -0.0088104398));

N1758_2 :=__common__( if(((real)f_prevaddrstatus_i < 2.5), 0.0007802815, N1758_3));

N1758_1 :=__common__( if(((real)f_prevaddrstatus_i > NULL), N1758_2, N1758_9));

N1759_8 :=__common__( map(trim(c_child) = ''              => -0.00090299915,
               ((real)c_child < 25.5499992371) => 0.011299148,
                                                  -0.00090299915));

N1759_7 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => N1759_8,
               ((real)f_add_input_nhood_vac_pct_i < 0.0172166787088) => -0.0041205095,
                                                                        N1759_8));

N1759_6 :=__common__( map(trim(C_HVAL_80K_P) = ''              => -0.0061092698,
               ((real)c_hval_80k_p < 8.94999980927) => N1759_7,
                                                       -0.0061092698));

N1759_5 :=__common__( if(((integer)c_assault < 135), N1759_6, 0.004105245));

N1759_4 :=__common__( if(trim(C_ASSAULT) != '', N1759_5, 0.010130517));

N1759_3 :=__common__( map(((real)r_c13_curr_addr_lres_d <= NULL) => N1759_4,
               ((real)r_c13_curr_addr_lres_d < 18.5)  => -0.0057202946,
                                                         N1759_4));

N1759_2 :=__common__( map(((real)f_util_adl_count_n <= NULL) => 0.0064985597,
               ((real)f_util_adl_count_n < 8.5)   => N1759_3,
                                                     0.0064985597));

N1759_1 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N1759_2, -5.0801118e-006));

N1760_11 :=__common__( if(((real)c_transport < 20.6000003815), 0.00019308298, -0.0081836122));

N1760_10 :=__common__( if(trim(C_TRANSPORT) != '', N1760_11, -0.0050260981));

N1760_9 :=__common__( map(((real)f_add_curr_nhood_bus_pct_i <= NULL)           => -0.0024791587,
               ((real)f_add_curr_nhood_bus_pct_i < 0.0928098112345) => 0.0020155785,
                                                                       -0.0024791587));

N1760_8 :=__common__( map(((real)r_d34_unrel_liens_ct_i <= NULL) => 0.0070101052,
               ((real)r_d34_unrel_liens_ct_i < 7.5)   => N1760_9,
                                                         0.0070101052));

N1760_7 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1760_8, 0.00032691097));

N1760_6 :=__common__( map(trim(C_UNATTACH) = ''     => N1760_7,
               ((real)c_unattach < 71.5) => -0.0058717248,
                                            N1760_7));

N1760_5 :=__common__( if(((real)f_rel_felony_count_i < 0.5), -0.0083557547, 0.0018509324));

N1760_4 :=__common__( if(((real)f_rel_felony_count_i > NULL), N1760_5, -0.030058261));

N1760_3 :=__common__( if(((real)c_born_usa < 40.5), N1760_4, N1760_6));

N1760_2 :=__common__( if(trim(C_BORN_USA) != '', N1760_3, -0.012022653));

N1760_1 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1760_2, N1760_10));

N1761_9 :=__common__( map(trim(C_PROFESSIONAL) = ''              => -0.010751462,
               ((real)c_professional < 10.6499996185) => -0.0011535505,
                                                         -0.010751462));

N1761_8 :=__common__( map(((real)f_prevaddrmedianincome_d <= NULL)   => N1761_9,
               ((real)f_prevaddrmedianincome_d < 54728.5) => 0.0010907145,
                                                             N1761_9));

N1761_7 :=__common__( map(trim(C_VACANT_P) = ''     => 0.012295221,
               ((real)c_vacant_p < 8.75) => 0.0017585777,
                                            0.012295221));

N1761_6 :=__common__( map(trim(C_PRESCHL) = ''      => -0.0039674183,
               ((real)c_preschl < 168.5) => 0.00042376506,
                                            -0.0039674183));

N1761_5 :=__common__( map(trim(C_LUX_PROD) = ''      => N1761_7,
               ((real)c_lux_prod < 129.5) => N1761_6,
                                             N1761_7));

N1761_4 :=__common__( if(((real)r_a46_curr_avm_autoval_d > NULL), N1761_5, N1761_8));

N1761_3 :=__common__( if(trim(C_INC_35K_P) != '', N1761_4, 0.0046335921));

N1761_2 :=__common__( if(((real)r_d32_criminal_count_i < 20.5), N1761_3, -0.0053319615));

N1761_1 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N1761_2, 0.00054086606));

N1762_9 :=__common__( map(((real)c_inf_nothing_found_i <= NULL) => -0.00069078503,
               ((real)c_inf_nothing_found_i < 0.5)   => -0.011349014,
                                                        -0.00069078503));

N1762_8 :=__common__( if(((real)c_bargains < 122.5), 0.0016696272, N1762_9));

N1762_7 :=__common__( if(trim(C_BARGAINS) != '', N1762_8, 0.026207801));

N1762_6 :=__common__( map(((real)r_c12_num_nonderogs_d <= NULL) => N1762_7,
               ((real)r_c12_num_nonderogs_d < 5.5)   => -0.01012818,
                                                        N1762_7));

N1762_5 :=__common__( if(((real)c_amus_indx < 117.5), 0.00028266538, -0.0082562727));

N1762_4 :=__common__( if(trim(C_AMUS_INDX) != '', N1762_5, -0.017728028));

N1762_3 :=__common__( map(((real)r_i60_inq_count12_i <= NULL) => N1762_6,
               ((real)r_i60_inq_count12_i < 3.5)   => N1762_4,
                                                      N1762_6));

N1762_2 :=__common__( if(((real)f_curraddrcrimeindex_i < 160.5), 0.00041220775, N1762_3));

N1762_1 :=__common__( if(((real)f_curraddrcrimeindex_i > NULL), N1762_2, -0.0010734132));

N1763_9 :=__common__( if(((real)r_d34_unrel_liens_ct_i < 1.5), 0.0028852916, -0.0014107683));

N1763_8 :=__common__( if(((real)r_d34_unrel_liens_ct_i > NULL), N1763_9, -0.012088919));

N1763_7 :=__common__( map(trim(C_EASIQLIFE) = ''      => N1763_8,
               ((real)c_easiqlife < 117.5) => -0.00061866291,
                                              N1763_8));

N1763_6 :=__common__( map(trim(C_YOUNG) = ''              => -0.0067179571,
               ((real)c_young < 46.3499984741) => N1763_7,
                                                  -0.0067179571));

N1763_5 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d < 65.5), 0.00098435695, -0.0069972246));

N1763_4 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N1763_5, -0.010643036));

N1763_3 :=__common__( map(trim(C_NO_LABFOR) = ''     => N1763_4,
               ((real)c_no_labfor < 32.5) => 0.0050948269,
                                             N1763_4));

N1763_2 :=__common__( if(((integer)c_robbery < 43), N1763_3, N1763_6));

N1763_1 :=__common__( if(trim(C_ROBBERY) != '', N1763_2, -0.00075439051));

N1764_8 :=__common__( map(((real)f_mos_inq_banko_cm_lseen_d <= NULL) => 0.0060132774,
               ((real)f_mos_inq_banko_cm_lseen_d < 47.5)  => -0.0065780824,
                                                             0.0060132774));

N1764_7 :=__common__( if(((real)f_rel_count_i < 32.5), 0.00085476573, N1764_8));

N1764_6 :=__common__( if(((real)f_rel_count_i > NULL), N1764_7, 0.00057655849));

N1764_5 :=__common__( map(trim(C_CARTHEFT) = ''     => N1764_6,
               ((real)c_cartheft < 51.5) => 0.0097073984,
                                            N1764_6));

N1764_4 :=__common__( map(trim(C_RICH_FAM) = ''      => 4.4758215e-005,
               ((real)c_rich_fam < 119.5) => -0.0074540183,
                                             4.4758215e-005));

N1764_3 :=__common__( map(trim(C_HEALTH) = ''              => 0.0002074774,
               ((real)c_health < 4.85000038147) => N1764_4,
                                                   0.0002074774));

N1764_2 :=__common__( if(((real)c_burglary < 94.5), N1764_3, N1764_5));

N1764_1 :=__common__( if(trim(C_BURGLARY) != '', N1764_2, 0.0059907526));

N1765_7 :=__common__( map(trim(C_MORT_INDX) = ''     => 0.011369577,
               ((real)c_mort_indx < 97.5) => 0.00048814607,
                                             0.011369577));

N1765_6 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => -0.0026087753,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.895601987839) => 0.0079343519,
                                                                      -0.0026087753));

N1765_5 :=__common__( map(trim(C_FEMDIV_P) = ''               => -0.00035668997,
               ((real)c_femdiv_p < 0.850000023842) => -0.0060795738,
                                                      -0.00035668997));

N1765_4 :=__common__( map(((real)c_a49_prop_owned_assessed_tot_d <= NULL)     => 0.006867464,
               ((integer)c_a49_prop_owned_assessed_tot_d < 104970) => N1765_5,
                                                                      0.006867464));

N1765_3 :=__common__( map(trim(C_INC_75K_P) = ''              => N1765_6,
               ((real)c_inc_75k_p < 28.1500015259) => N1765_4,
                                                      N1765_6));

N1765_2 :=__common__( if(((real)c_rnt500_p < 74.3500061035), N1765_3, N1765_7));

N1765_1 :=__common__( if(trim(C_RNT500_P) != '', N1765_2, -0.0015033493));

N1766_8 :=__common__( map(trim(C_INC_75K_P) = ''              => -0.0027592331,
               ((real)c_inc_75k_p < 15.1499996185) => 0.006391831,
                                                      -0.0027592331));

N1766_7 :=__common__( map(trim(C_WHOLESALE) = ''              => 0.010547124,
               ((real)c_wholesale < 3.95000004768) => N1766_8,
                                                      0.010547124));

N1766_6 :=__common__( map(trim(C_HVAL_150K_P) = ''     => -0.013192895,
               ((real)c_hval_150k_p < 5.75) => -0.0014254204,
                                               -0.013192895));

N1766_5 :=__common__( map(trim(C_HVAL_20K_P) = ''     => N1766_6,
               ((real)c_hval_20k_p < 8.75) => 0.00049630834,
                                              N1766_6));

N1766_4 :=__common__( map(((real)r_a50_pb_total_dollars_d <= NULL) => -0.0010438833,
               ((real)r_a50_pb_total_dollars_d < 72.5)  => 0.0025231846,
                                                           -0.0010438833));

N1766_3 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1766_4, N1766_5));

N1766_2 :=__common__( if(((real)c_rest_indx < 152.5), N1766_3, N1766_7));

N1766_1 :=__common__( if(trim(C_REST_INDX) != '', N1766_2, 0.0011609961));

N1767_11 :=__common__( map((fp_segment in ['7 Other'])                                                                               => -0.0048600308,
                (fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '4 Bureau Only', '5 Derog', '6 Recent Activity']) => 0.006530946,
                                                                                                                             0.006530946));

N1767_10 :=__common__( if(((real)c_unempl < 193.5), -0.00034260595, 0.0071240119));

N1767_9 :=__common__( if(trim(C_UNEMPL) != '', N1767_10, -0.006173709));

N1767_8 :=__common__( if(((real)c_rnt500_p < 43.6500015259), -0.0017153229, -0.0085014758));

N1767_7 :=__common__( if(trim(C_RNT500_P) != '', N1767_8, -0.018191545));

N1767_6 :=__common__( if(((real)f_rel_ageover40_count_d < 0.5), 0.0024904284, N1767_7));

N1767_5 :=__common__( if(((real)f_rel_ageover40_count_d > NULL), N1767_6, -0.0056155656));

N1767_4 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N1767_5, N1767_9));

N1767_3 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL) => N1767_11,
               ((real)f_prevaddrmurderindex_i < 196.5) => N1767_4,
                                                          N1767_11));

N1767_2 :=__common__( if(((integer)r_i60_inq_retail_recency_d < 9), 0.0079994633, N1767_3));

N1767_1 :=__common__( if(((real)r_i60_inq_retail_recency_d > NULL), N1767_2, 0.0043203218));

N1768_9 :=__common__( map(((real)f_curraddrcartheftindex_i <= NULL) => 0.0089200697,
               ((real)f_curraddrcartheftindex_i < 168.5) => -0.0010766558,
                                                            0.0089200697));

N1768_8 :=__common__( map(trim(C_BORN_USA) = ''      => -0.004817056,
               ((real)c_born_usa < 127.5) => 0.0035561923,
                                             -0.004817056));

N1768_7 :=__common__( map(trim(C_CARTHEFT) = ''       => -0.0051155993,
               ((integer)c_cartheft < 100) => N1768_8,
                                              -0.0051155993));

N1768_6 :=__common__( map(trim(C_LOW_ED) = ''              => N1768_9,
               ((real)c_low_ed < 69.1499938965) => N1768_7,
                                                   N1768_9));

N1768_5 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1768_6, -0.00022555109));

N1768_4 :=__common__( map(trim(C_TOTSALES) = ''       => N1768_5,
               ((real)c_totsales < 3736.5) => 0.00065473736,
                                              N1768_5));

N1768_3 :=__common__( if(((real)f_liens_rel_cj_total_amt_i < 2250.5), N1768_4, -0.0079149307));

N1768_2 :=__common__( if(((real)f_liens_rel_cj_total_amt_i > NULL), N1768_3, -0.0015580504));

N1768_1 :=__common__( if(trim(C_FINANCE) != '', N1768_2, 0.00041270543));

N1769_8 :=__common__( map(((real)f_prevaddrageoldest_d <= NULL) => -0.0039289431,
               ((real)f_prevaddrageoldest_d < 35.5)  => 0.0055688115,
                                                        -0.0039289431));

N1769_7 :=__common__( map(trim(C_RNT750_P) = ''              => -0.0067721478,
               ((real)c_rnt750_p < 26.6500015259) => N1769_8,
                                                     -0.0067721478));

N1769_6 :=__common__( if(((real)f_curraddrcartheftindex_i < 190.5), 0.00011361886, N1769_7));

N1769_5 :=__common__( if(((real)f_curraddrcartheftindex_i > NULL), N1769_6, -0.0028445314));

N1769_4 :=__common__( map(trim(C_FAMMAR18_P) = ''              => 0.007198194,
               ((real)c_fammar18_p < 26.7999992371) => -0.003064249,
                                                       0.007198194));

N1769_3 :=__common__( map(trim(C_MURDERS) = ''      => 0.010317011,
               ((real)c_murders < 171.5) => N1769_4,
                                            0.010317011));

N1769_2 :=__common__( if(((real)c_employees < 3.5), N1769_3, N1769_5));

N1769_1 :=__common__( if(trim(C_EMPLOYEES) != '', N1769_2, -0.0012577641));

N1770_9 :=__common__( if(((real)f_prevaddrcartheftindex_i < 195.5), -0.00017161696, 0.0057920176));

N1770_8 :=__common__( if(((real)f_prevaddrcartheftindex_i > NULL), N1770_9, 0.0062473913));

N1770_7 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => 0.0081865186,
               ((real)f_add_input_nhood_vac_pct_i < 0.522578001022) => N1770_8,
                                                                       0.0081865186));

N1770_6 :=__common__( map(trim(C_ARMFORCE) = ''      => -0.0070500306,
               ((real)c_armforce < 121.5) => -0.00066147469,
                                             -0.0070500306));

N1770_5 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL) => -0.0066706476,
               ((real)f_prevaddrmurderindex_i < 190.5) => N1770_6,
                                                          -0.0066706476));

N1770_4 :=__common__( map(((real)f_attr_arrests_i <= NULL) => 0.0052249273,
               ((real)f_attr_arrests_i < 0.5)   => N1770_5,
                                                   0.0052249273));

N1770_3 :=__common__( if(((real)f_attr_arrest_recency_d > NULL), N1770_4, 0.018073936));

N1770_2 :=__common__( if(((real)c_white_col < 22.6500015259), N1770_3, N1770_7));

N1770_1 :=__common__( if(trim(C_WHITE_COL) != '', N1770_2, -0.0016799652));

N1771_9 :=__common__( if(((real)r_pb_order_freq_d < 2.5), -0.0012761121, 0.012622546));

N1771_8 :=__common__( if(((real)r_pb_order_freq_d > NULL), N1771_9, 0.0030316892));

N1771_7 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)         => -0.0029121758,
               ((real)f_add_input_nhood_vac_pct_i < 0.11481141299) => N1771_8,
                                                                      -0.0029121758));

N1771_6 :=__common__( map(((real)c_dist_input_to_prev_addr_i <= NULL) => -0.0063244237,
               ((real)c_dist_input_to_prev_addr_i < 10.5)  => 0.002952172,
                                                              -0.0063244237));

N1771_5 :=__common__( map(trim(C_POP_65_74_P) = ''              => -0.0054749494,
               ((real)c_pop_65_74_p < 3.95000004768) => N1771_6,
                                                        -0.0054749494));

N1771_4 :=__common__( if(((real)c_no_labfor < 118.5), N1771_5, N1771_7));

N1771_3 :=__common__( if(trim(C_NO_LABFOR) != '', N1771_4, 0.014356946));

N1771_2 :=__common__( if(((real)f_rel_count_i < 21.5), 0.0010627293, N1771_3));

N1771_1 :=__common__( if(((real)f_rel_count_i > NULL), N1771_2, -0.0095588469));

N1772_9 :=__common__( map(trim(C_POP_75_84_P) = ''     => -0.006687384,
               ((real)c_pop_75_84_p < 9.75) => 0.00032307436,
                                               -0.006687384));

N1772_8 :=__common__( if(((real)c_pop_6_11_p < 14.6499996185), N1772_9, -0.0074391019));

N1772_7 :=__common__( if(trim(C_POP_6_11_P) != '', N1772_8, -0.004138528));

N1772_6 :=__common__( map(((real)f_srchfraudsrchcountyr_i <= NULL) => 0.0039740015,
               ((real)f_srchfraudsrchcountyr_i < 0.5)   => -0.001832903,
                                                           0.0039740015));

N1772_5 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => -0.0052366498,
               ((real)r_c10_m_hdr_fs_d < 288.5) => N1772_6,
                                                   -0.0052366498));

N1772_4 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i < 141.850006104), N1772_5, -0.0081929332));

N1772_3 :=__common__( if(((real)r_a49_curr_avm_chg_1yr_pct_i > NULL), N1772_4, N1772_7));

N1772_2 :=__common__( if(((real)r_a50_pb_total_orders_d < 1.5), N1772_3, 0.0026750108));

N1772_1 :=__common__( if(((real)r_a50_pb_total_orders_d > NULL), N1772_2, -0.0027387622));

N1773_10 :=__common__( if(((real)c_pop_65_74_p < 6.25), -0.00045470993, -0.010136721));

N1773_9 :=__common__( if(trim(C_POP_65_74_P) != '', N1773_10, -0.02907784));

N1773_8 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d < 0.990999102592), 0.0011616282, -0.0052773901));

N1773_7 :=__common__( if(((real)f_add_input_nhood_sfd_pct_d > NULL), N1773_8, 0.04842848));

N1773_6 :=__common__( if(((real)c_armforce < 139.5), -0.00093327305, -0.0081005405));

N1773_5 :=__common__( if(trim(C_ARMFORCE) != '', N1773_6, -0.00046866082));

N1773_4 :=__common__( map(((real)f_fp_prevaddrcrimeindex_i <= NULL) => N1773_7,
               ((integer)f_fp_prevaddrcrimeindex_i < 56) => N1773_5,
                                                            N1773_7));

N1773_3 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => N1773_9,
               ((real)f_curraddrburglaryindex_i < 192.5) => N1773_4,
                                                            N1773_9));

N1773_2 :=__common__( if(((real)f_rel_under100miles_cnt_d < 37.5), N1773_3, 0.0065634697));

N1773_1 :=__common__( if(((real)f_rel_under100miles_cnt_d > NULL), N1773_2, 0.0029819932));

N1774_8 :=__common__( map(trim(C_NEWHOUSE) = ''      => 0.0019835536,
               ((real)c_newhouse < 32.75) => -0.00094608302,
                                             0.0019835536));

N1774_7 :=__common__( map(((real)f_fp_prevaddrcrimeindex_i <= NULL) => N1774_8,
               ((real)f_fp_prevaddrcrimeindex_i < 52.5)  => -0.0051535581,
                                                            N1774_8));

N1774_6 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => 0.011469262,
               ((real)f_mos_inq_banko_cm_fseen_d < 68.5)  => 0.001855804,
                                                             0.011469262));

N1774_5 :=__common__( map(((real)r_c21_m_bureau_adl_fs_d <= NULL) => N1774_6,
               ((real)r_c21_m_bureau_adl_fs_d < 124.5) => -0.0010218392,
                                                          N1774_6));

N1774_4 :=__common__( map(trim(C_UNEMPL) = ''     => N1774_5,
               ((real)c_unempl < 73.5) => -0.0057082184,
                                          N1774_5));

N1774_3 :=__common__( if(((integer)f_fp_prevaddrburglaryindex_i < 41), N1774_4, N1774_7));

N1774_2 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i > NULL), N1774_3, -0.0051886642));

N1774_1 :=__common__( if(trim(C_OWNOCC_P) != '', N1774_2, -0.0045371617));

N1775_8 :=__common__( map(((real)f_inq_count24_i <= NULL) => -0.0046398664,
               ((real)f_inq_count24_i < 13.5)  => 0.00485465,
                                                  -0.0046398664));

N1775_7 :=__common__( map(trim(C_MANY_CARS) = ''     => N1775_8,
               ((real)c_many_cars < 63.5) => 0.0093612189,
                                             N1775_8));

N1775_6 :=__common__( map(trim(C_EASIQLIFE) = ''      => -0.0059052702,
               ((real)c_easiqlife < 140.5) => N1775_7,
                                              -0.0059052702));

N1775_5 :=__common__( map(trim(C_CONSTRUCTION) = ''              => 0.0095492576,
               ((real)c_construction < 11.5500001907) => N1775_6,
                                                         0.0095492576));

N1775_4 :=__common__( if(((real)c_high_ed < 8.35000038147), -0.0029310948, N1775_5));

N1775_3 :=__common__( if(trim(C_HIGH_ED) != '', N1775_4, 0.013964795));

N1775_2 :=__common__( if(((real)f_srchfraudsrchcountyr_i < 3.5), -0.0003574281, N1775_3));

N1775_1 :=__common__( if(((real)f_srchfraudsrchcountyr_i > NULL), N1775_2, 0.00097743956));

N1776_9 :=__common__( map(trim(C_INC_50K_P) = ''              => -0.0029299085,
               ((real)c_inc_50k_p < 11.5500001907) => 0.0055685398,
                                                      -0.0029299085));

N1776_8 :=__common__( map(trim(C_FAMMAR_P) = ''              => N1776_9,
               ((real)c_fammar_p < 45.0499992371) => 0.0074002649,
                                                     N1776_9));

N1776_7 :=__common__( if(((real)c_unique_addr_count_i < 3.5), N1776_8, -0.00099061722));

N1776_6 :=__common__( if(((real)c_unique_addr_count_i > NULL), N1776_7, 0.0063540903));

N1776_5 :=__common__( map(trim(C_RETIRED) = ''              => N1776_6,
               ((real)c_retired < 2.34999990463) => -0.0068959716,
                                                    N1776_6));

N1776_4 :=__common__( if(((real)r_d34_unrel_liens_ct_i < 1.5), 0.0075474791, -0.0013546193));

N1776_3 :=__common__( if(((real)r_d34_unrel_liens_ct_i > NULL), N1776_4, 0.095782146));

N1776_2 :=__common__( if(((real)c_med_age < 24.0499992371), N1776_3, N1776_5));

N1776_1 :=__common__( if(trim(C_MED_AGE) != '', N1776_2, 7.7449753e-006));

N1777_8 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => 0.0053199091,
               ((real)f_corrssnaddrcount_d < 3.5)   => -0.0042166972,
                                                       0.0053199091));

N1777_7 :=__common__( map((segment in ['RETAIL', 'SEARS AUTO', 'SEARS FLS', 'SEARS SHO']) => -0.0072981155,
               (segment in ['KMART'])                                          => N1777_8,
                                                                                  -0.0072981155));

N1777_6 :=__common__( if(((real)c_cpiall < 203.600006104), N1777_7, 0.00087119716));

N1777_5 :=__common__( if(trim(C_CPIALL) != '', N1777_6, -0.001799164));

N1777_4 :=__common__( map(((real)r_c20_email_domain_free_count_i <= NULL) => -0.0048576732,
               ((real)r_c20_email_domain_free_count_i < 0.5)   => 0.0059902127,
                                                                  -0.0048576732));

N1777_3 :=__common__( map(((real)f_prevaddrageoldest_d <= NULL) => -0.011191267,
               ((real)f_prevaddrageoldest_d < 101.5) => N1777_4,
                                                        -0.011191267));

N1777_2 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.212283611298), N1777_3, N1777_5));

N1777_1 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1777_2, -0.0024087039));

N1778_9 :=__common__( map(((real)f_curraddrmurderindex_i <= NULL) => -0.00017302406,
               ((real)f_curraddrmurderindex_i < 149.5) => 0.010489231,
                                                          -0.00017302406));

N1778_8 :=__common__( map(trim(C_RAPE) = ''      => N1778_9,
               ((real)c_rape < 143.5) => -0.00075018997,
                                         N1778_9));

N1778_7 :=__common__( map(trim(C_UNEMP) = ''              => N1778_8,
               ((real)c_unemp < 4.35000038147) => -0.0035349828,
                                                  N1778_8));

N1778_6 :=__common__( map(((real)r_d33_eviction_recency_d <= NULL) => N1778_7,
               ((integer)r_d33_eviction_recency_d < 30) => 0.0082051228,
                                                           N1778_7));

N1778_5 :=__common__( if(((real)r_a50_pb_average_dollars_d < 31.5), -0.0046392086, N1778_6));

N1778_4 :=__common__( if(((real)r_a50_pb_average_dollars_d > NULL), N1778_5, 0.0086212331));

N1778_3 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), 0.00011223981, N1778_4));

N1778_2 :=__common__( if(((real)c_med_rent < 1203.5), N1778_3, -0.0069785434));

N1778_1 :=__common__( if(trim(C_MED_RENT) != '', N1778_2, -0.00096745504));

N1779_8 :=__common__( map(((real)f_prevaddroccupantowned_d <= NULL) => 0.002153365,
               ((real)f_prevaddroccupantowned_d < 0.5)   => -0.00021141557,
                                                            0.002153365));

N1779_7 :=__common__( map(trim(C_FOOD) = ''              => -0.0089492714,
               ((real)c_food < 21.1500015259) => 0.0037668809,
                                                 -0.0089492714));

N1779_6 :=__common__( map(trim(C_BLUE_COL) = ''              => N1779_7,
               ((real)c_blue_col < 14.0500001907) => -0.010051436,
                                                     N1779_7));

N1779_5 :=__common__( if(((real)f_curraddractivephonelist_d > NULL), N1779_6, 0.023017031));

N1779_4 :=__common__( if(((real)c_no_car < 169.5), N1779_5, 0.0026107528));

N1779_3 :=__common__( if(trim(C_NO_CAR) != '', N1779_4, 0.0027645294));

N1779_2 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d < 20.5), N1779_3, N1779_8));

N1779_1 :=__common__( if(((real)f_mos_liens_unrel_cj_lseen_d > NULL), N1779_2, -0.00022596336));

N1780_8 :=__common__( map(((real)r_i60_inq_banking_recency_d <= NULL)  => -0.0085983993,
               ((integer)r_i60_inq_banking_recency_d < 549) => 0.00023195038,
                                                               -0.0085983993));

N1780_7 :=__common__( map(trim(C_OLD_HOMES) = ''      => 0.0039722856,
               ((real)c_old_homes < 152.5) => N1780_8,
                                              0.0039722856));

N1780_6 :=__common__( map(((real)f_varrisktype_i <= NULL) => -0.01042036,
               ((real)f_varrisktype_i < 3.5)   => N1780_7,
                                                  -0.01042036));

N1780_5 :=__common__( map(((real)f_rel_ageover40_count_d <= NULL) => N1780_6,
               ((real)f_rel_ageover40_count_d < 0.5)   => 0.0031784751,
                                                          N1780_6));

N1780_4 :=__common__( if(((real)c_inc_125k_p < 1.15000009537), N1780_5, 6.2195368e-006));

N1780_3 :=__common__( if(trim(C_INC_125K_P) != '', N1780_4, 0.0048732606));

N1780_2 :=__common__( if(((real)f_rel_homeover50_count_d < 2.5), 0.0036040066, N1780_3));

N1780_1 :=__common__( if(((real)f_rel_homeover50_count_d > NULL), N1780_2, -0.0023022323));

N1781_7 :=__common__( map(trim(C_NO_LABFOR) = ''      => -0.0063236826,
               ((real)c_no_labfor < 175.5) => -0.00033663444,
                                              -0.0063236826));

N1781_6 :=__common__( map(trim(C_FEMDIV_P) = ''              => 0.0026176043,
               ((real)c_femdiv_p < 2.95000004768) => 0.011355431,
                                                     0.0026176043));

N1781_5 :=__common__( map(trim(C_HH7P_P) = ''              => -0.0042075809,
               ((real)c_hh7p_p < 1.95000004768) => N1781_6,
                                                   -0.0042075809));

N1781_4 :=__common__( map(trim(C_BLUE_EMPL) = ''     => N1781_7,
               ((real)c_blue_empl < 41.5) => N1781_5,
                                             N1781_7));

N1781_3 :=__common__( map(trim(C_INC_25K_P) = ''              => 0.0057745041,
               ((real)c_inc_25k_p < 10.1499996185) => -0.0020182576,
                                                      0.0057745041));

N1781_2 :=__common__( if(((real)c_popover18 < 523.5), N1781_3, N1781_4));

N1781_1 :=__common__( if(trim(C_POPOVER18) != '', N1781_2, -0.00080728582));

N1782_8 :=__common__( map(trim(C_UNEMPL) = ''      => 0.0075794207,
               ((real)c_unempl < 118.5) => -0.00084228624,
                                           0.0075794207));

N1782_7 :=__common__( map(trim(C_WHITE_COL) = ''              => 0.0012161782,
               ((real)c_white_col < 33.8499984741) => -0.0045734805,
                                                      0.0012161782));

N1782_6 :=__common__( map(((real)r_c10_m_hdr_fs_d <= NULL) => -0.0053806416,
               ((real)r_c10_m_hdr_fs_d < 347.5) => 0.0012156447,
                                                   -0.0053806416));

N1782_5 :=__common__( if(((integer)f_prevaddrmedianvalue_d < 35635), -0.0035932631, N1782_6));

N1782_4 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N1782_5, 0.0030966116));

N1782_3 :=__common__( map(trim(C_RICH_FAM) = ''      => N1782_7,
               ((real)c_rich_fam < 134.5) => N1782_4,
                                             N1782_7));

N1782_2 :=__common__( if(((real)c_hval_150k_p < 27.9500007629), N1782_3, N1782_8));

N1782_1 :=__common__( if(trim(C_HVAL_150K_P) != '', N1782_2, 0.0020014392));

N1783_8 :=__common__( map(trim(C_EXP_PROD) = ''     => 0.011723055,
               ((real)c_exp_prod < 93.5) => -0.0012429148,
                                            0.011723055));

N1783_7 :=__common__( map(trim(C_POP_25_34_P) = ''      => 0.00075574164,
               ((real)c_pop_25_34_p < 13.75) => -0.011160712,
                                                0.00075574164));

N1783_6 :=__common__( map(trim(C_UNEMP) = ''     => 9.9151562e-005,
               ((real)c_unemp < 2.25) => N1783_7,
                                         9.9151562e-005));

N1783_5 :=__common__( map(((real)f_historical_count_d <= NULL) => -0.0068961875,
               ((real)f_historical_count_d < 12.5)  => N1783_6,
                                                       -0.0068961875));

N1783_4 :=__common__( if(((real)r_mos_since_paw_fseen_d < 76.5), N1783_5, N1783_8));

N1783_3 :=__common__( if(((real)r_mos_since_paw_fseen_d > NULL), N1783_4, -6.7980912e-005));

N1783_2 :=__common__( if(((real)c_hh1_p < 7.85000038147), 0.0063883375, N1783_3));

N1783_1 :=__common__( if(trim(C_HH1_P) != '', N1783_2, -0.00043240462));

N1784_10 :=__common__( if(((real)c_hh2_p < 29.75), 0.0090534188, -0.00057291138));

N1784_9 :=__common__( if(trim(C_HH2_P) != '', N1784_10, -0.015133886));

N1784_8 :=__common__( map(trim(C_VACANT_P) = ''              => 0.00076516501,
               ((real)c_vacant_p < 16.4500007629) => -0.004776629,
                                                     0.00076516501));

N1784_7 :=__common__( map(trim(C_FAMMAR_P) = ''              => 0.00056761151,
               ((real)c_fammar_p < 49.1500015259) => N1784_8,
                                                     0.00056761151));

N1784_6 :=__common__( map(trim(C_POP_65_74_P) = ''              => -0.0010986683,
               ((real)c_pop_65_74_p < 1.04999995232) => 0.0076399115,
                                                        -0.0010986683));

N1784_5 :=__common__( if(((real)r_pb_order_freq_d > NULL), N1784_6, N1784_7));

N1784_4 :=__common__( if(((real)c_mil_emp < 5.75), N1784_5, 0.00680487));

N1784_3 :=__common__( if(trim(C_MIL_EMP) != '', N1784_4, -0.0037744934));

N1784_2 :=__common__( if(((real)f_add_input_nhood_vac_pct_i < 0.380497515202), N1784_3, N1784_9));

N1784_1 :=__common__( if(((real)f_add_input_nhood_vac_pct_i > NULL), N1784_2, 0.0010653134));

N1785_8 :=__common__( map(trim(C_RETAIL) = ''              => 0.0005226458,
               ((real)c_retail < 2.15000009537) => 0.0079197313,
                                                   0.0005226458));

N1785_7 :=__common__( map(trim(C_INC_200K_P) = ''              => -0.0010461599,
               ((real)c_inc_200k_p < 1.15000009537) => -0.0062795923,
                                                       -0.0010461599));

N1785_6 :=__common__( map(trim(C_FAMILIES) = ''      => N1785_7,
               ((real)c_families < 178.5) => 0.0022552348,
                                             N1785_7));

N1785_5 :=__common__( map(trim(C_POP_12_17_P) = ''              => 0.0021778927,
               ((real)c_pop_12_17_p < 11.4499998093) => N1785_6,
                                                        0.0021778927));

N1785_4 :=__common__( if(((real)r_d32_mos_since_fel_ls_d < 161.5), -0.00779142, N1785_5));

N1785_3 :=__common__( if(((real)r_d32_mos_since_fel_ls_d > NULL), N1785_4, 0.0010655788));

N1785_2 :=__common__( if(((real)c_totsales < 1842.5), N1785_3, N1785_8));

N1785_1 :=__common__( if(trim(C_TOTSALES) != '', N1785_2, 0.0019616892));

N1786_7 :=__common__( map(trim(C_OLD_HOMES) = ''     => -0.00082017868,
               ((real)c_old_homes < 44.5) => 0.0024338194,
                                             -0.00082017868));

N1786_6 :=__common__( map(trim(C_LOW_ED) = ''              => N1786_7,
               ((real)c_low_ed < 34.1500015259) => -0.0040619804,
                                                   N1786_7));

N1786_5 :=__common__( map(((real)f_inq_lnames_per_ssn_i <= NULL) => 0.0090499403,
               ((real)f_inq_lnames_per_ssn_i < 1.5)   => 0.00071804022,
                                                         0.0090499403));

N1786_4 :=__common__( map(trim(C_REST_INDX) = ''     => 0.011355381,
               ((real)c_rest_indx < 87.5) => 0.00090975631,
                                             0.011355381));

N1786_3 :=__common__( map(trim(C_HOUSINGCPI) = ''              => N1786_5,
               ((real)c_housingcpi < 188.050003052) => N1786_4,
                                                       N1786_5));

N1786_2 :=__common__( if(((real)c_easiqlife < 97.5), N1786_3, N1786_6));

N1786_1 :=__common__( if(trim(C_EASIQLIFE) != '', N1786_2, -0.001344029));

N1787_8 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => -0.0074173497,
               ((real)f_add_input_nhood_vac_pct_i < 0.156122669578) => 0.00072704911,
                                                                       -0.0074173497));

N1787_7 :=__common__( map(trim(C_LARCENY) = ''      => -0.0094506488,
               ((real)c_larceny < 153.5) => -0.0019775372,
                                            -0.0094506488));

N1787_6 :=__common__( map(trim(C_CIV_EMP) = ''              => N1787_7,
               ((real)c_civ_emp < 50.6500015259) => 0.0026986836,
                                                    N1787_7));

N1787_5 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => N1787_6,
               ((real)f_curraddrburglaryindex_i < 115.5) => 0.00079897995,
                                                            N1787_6));

N1787_4 :=__common__( if(((real)f_curraddrmedianvalue_d < 136157.5), 0.0010879791, N1787_5));

N1787_3 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N1787_4, 0.0048445489));

N1787_2 :=__common__( if(((real)c_unemp < 13.8500003815), N1787_3, N1787_8));

N1787_1 :=__common__( if(trim(C_UNEMP) != '', N1787_2, -0.0015977872));

N1788_10 :=__common__( if(((real)f_add_input_mobility_index_n < 0.378410547972), 0.00058674921, -0.001813241));

N1788_9 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1788_10, -0.031040929));

N1788_8 :=__common__( map(trim(C_POP_25_34_P) = ''              => 0.0057344817,
               ((real)c_pop_25_34_p < 27.1500015259) => N1788_9,
                                                        0.0057344817));

N1788_7 :=__common__( map(((real)r_c14_addrs_10yr_i <= NULL) => 0.0075411347,
               ((real)r_c14_addrs_10yr_i < 6.5)   => -0.0010431962,
                                                     0.0075411347));

N1788_6 :=__common__( if(((real)f_add_curr_mobility_index_n < 0.37171459198), N1788_7, 0.010480165));

N1788_5 :=__common__( if(((real)f_add_curr_mobility_index_n > NULL), N1788_6, -0.02871818));

N1788_4 :=__common__( if(((real)f_rel_incomeover50_count_d < 7.5), N1788_5, -0.0033658002));

N1788_3 :=__common__( if(((real)f_rel_incomeover50_count_d > NULL), N1788_4, -0.0031869548));

N1788_2 :=__common__( if(((real)c_preschl < 35.5), N1788_3, N1788_8));

N1788_1 :=__common__( if(trim(C_PRESCHL) != '', N1788_2, -0.00094242192));

N1789_8 :=__common__( map(((real)r_d34_unrel_liens_ct_i <= NULL) => 0.00081152903,
               ((real)r_d34_unrel_liens_ct_i < 0.5)   => 0.0085542692,
                                                         0.00081152903));

N1789_7 :=__common__( map(trim(C_HVAL_250K_P) = ''              => -0.0059174372,
               ((real)c_hval_250k_p < 2.34999990463) => 0.0029007748,
                                                        -0.0059174372));

N1789_6 :=__common__( map(trim(C_POP_85P_P) = ''               => N1789_7,
               ((real)c_pop_85p_p < 0.550000011921) => -0.0098420103,
                                                       N1789_7));

N1789_5 :=__common__( map(((real)f_m_bureau_adl_fs_all_d <= NULL) => 0.0016419253,
               ((real)f_m_bureau_adl_fs_all_d < 230.5) => N1789_6,
                                                          0.0016419253));

N1789_4 :=__common__( if(((real)c_bigapt_p < 10.75), 0.00025655325, N1789_5));

N1789_3 :=__common__( if(trim(C_BIGAPT_P) != '', N1789_4, -0.0025984602));

N1789_2 :=__common__( if(((real)f_attr_arrests_i < 0.5), N1789_3, N1789_8));

N1789_1 :=__common__( if(((real)f_attr_arrests_i > NULL), N1789_2, -0.0023752066));

N1790_8 :=__common__( map(trim(C_RENTOCC_P) = ''      => -0.0110357,
               ((real)c_rentocc_p < 52.25) => -0.0012673179,
                                              -0.0110357));

N1790_7 :=__common__( map((fp_segment in ['4 Bureau Only', '5 Derog', '7 Other'])                       => N1790_8,
               (fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '6 Recent Activity']) => 0.0064543058,
                                                                                                0.0064543058));

N1790_6 :=__common__( map(((real)f_prevaddrmurderindex_i <= NULL) => N1790_7,
               ((real)f_prevaddrmurderindex_i < 190.5) => 0.002188952,
                                                          N1790_7));

N1790_5 :=__common__( if(((real)c_impulse_count_i < 1.5), N1790_6, 0.0087608572));

N1790_4 :=__common__( if(((real)c_impulse_count_i > NULL), N1790_5, -0.0034708276));

N1790_3 :=__common__( map(trim(C_POP_35_44_P) = ''              => -0.0049219425,
               ((real)c_pop_35_44_p < 20.9500007629) => N1790_4,
                                                        -0.0049219425));

N1790_2 :=__common__( if(((real)c_med_rent < 521.5), N1790_3, -0.00087054547));

N1790_1 :=__common__( if(trim(C_MED_RENT) != '', N1790_2, 0.0021848898));

N1791_9 :=__common__( map(((real)f_fp_prevaddrburglaryindex_i <= NULL) => 0.0037809845,
               ((real)f_fp_prevaddrburglaryindex_i < 149.5) => 0.00025635097,
                                                               0.0037809845));

N1791_8 :=__common__( map(trim(C_HH2_P) = ''              => N1791_9,
               ((real)c_hh2_p < 21.3499984741) => -0.0021151091,
                                                  N1791_9));

N1791_7 :=__common__( if(((real)f_add_input_mobility_index_n < 0.815343439579), N1791_8, 0.0094548839));

N1791_6 :=__common__( if(((real)f_add_input_mobility_index_n > NULL), N1791_7, -0.032177091));

N1791_5 :=__common__( map(trim(C_VACANT_P) = ''              => -0.0047617085,
               ((real)c_vacant_p < 24.5499992371) => N1791_6,
                                                     -0.0047617085));

N1791_4 :=__common__( if(((real)c_hval_40k_p < 8.44999980927), N1791_5, -0.0014693024));

N1791_3 :=__common__( if(trim(C_HVAL_40K_P) != '', N1791_4, -0.0015993938));

N1791_2 :=__common__( if(((integer)f_curraddrmedianvalue_d < 426795), N1791_3, -0.0071275381));

N1791_1 :=__common__( if(((real)f_curraddrmedianvalue_d > NULL), N1791_2, 0.00022403317));

N1792_8 :=__common__( map(trim(C_INC_50K_P) = ''      => -0.0010422173,
               ((real)c_inc_50k_p < 11.25) => -0.010808104,
                                              -0.0010422173));

N1792_7 :=__common__( map(((real)c_dist_input_to_prev_addr_i <= NULL) => N1792_8,
               ((real)c_dist_input_to_prev_addr_i < 22.5)  => 0.00063325695,
                                                              N1792_8));

N1792_6 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1792_7, -6.3260962e-006));

N1792_5 :=__common__( map(trim(C_ASSAULT) = ''       => 0.0034513274,
               ((integer)c_assault < 135) => 0.017166899,
                                             0.0034513274));

N1792_4 :=__common__( map(trim(C_HH00) = ''      => N1792_5,
               ((real)c_hh00 < 368.5) => 0.00027687692,
                                         N1792_5));

N1792_3 :=__common__( map(trim(C_LAR_FAM) = ''      => -0.0021677814,
               ((real)c_lar_fam < 102.5) => N1792_4,
                                            -0.0021677814));

N1792_2 :=__common__( if(((real)c_young < 14.4499998093), N1792_3, N1792_6));

N1792_1 :=__common__( if(trim(C_YOUNG) != '', N1792_2, 0.0040769283));

N1793_8 :=__common__( map(trim(C_OLDHOUSE) = ''              => 0.0016691246,
               ((real)c_oldhouse < 236.600006104) => -0.0037508727,
                                                     0.0016691246));

N1793_7 :=__common__( map(trim(C_PRESCHL) = ''      => N1793_8,
               ((real)c_preschl < 146.5) => 0.00026744447,
                                            N1793_8));

N1793_6 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)         => N1793_7,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.15796802938) => 0.0048351943,
                                                                     N1793_7));

N1793_5 :=__common__( map(trim(C_PRESCHL) = ''     => N1793_6,
               ((real)c_preschl < 17.5) => -0.0079184693,
                                           N1793_6));

N1793_4 :=__common__( if(((real)f_srchunvrfdaddrcount_i < 0.5), 0.00074437755, 0.0069952862));

N1793_3 :=__common__( if(((real)f_srchunvrfdaddrcount_i > NULL), N1793_4, 0.025118406));

N1793_2 :=__common__( if(((real)c_mort_indx < 61.5), N1793_3, N1793_5));

N1793_1 :=__common__( if(trim(C_MORT_INDX) != '', N1793_2, 0.0028572173));

N1794_8 :=__common__( map((fp_segment in ['2 NAS 479', '3 New DID', '4 Bureau Only', '6 Recent Activity', '7 Other']) => -0.00091933016,
               (fp_segment in ['1 SSN Prob', '5 Derog'])                                                   => 0.0015988561,
                                                                                                              -0.00091933016));

N1794_7 :=__common__( if(((real)c_addr_lres_12mo_ct_i < 16.5), N1794_8, 0.0080843152));

N1794_6 :=__common__( if(((real)c_addr_lres_12mo_ct_i > NULL), N1794_7, -0.0038303907));

N1794_5 :=__common__( map(trim(C_MED_HHINC) = ''        => -0.0063969318,
               ((real)c_med_hhinc < 68097.5) => N1794_6,
                                                -0.0063969318));

N1794_4 :=__common__( map(trim(C_HVAL_400K_P) = ''              => -0.0027859245,
               ((real)c_hval_400k_p < 9.05000019073) => N1794_5,
                                                        -0.0027859245));

N1794_3 :=__common__( map(trim(C_RAPE) = ''     => 0.0071020299,
               ((real)c_rape < 28.5) => -0.00081864845,
                                        0.0071020299));

N1794_2 :=__common__( if(((integer)c_totcrime < 47), N1794_3, N1794_4));

N1794_1 :=__common__( if(trim(C_TOTCRIME) != '', N1794_2, -0.00085212878));

N1795_7 :=__common__( map(trim(C_INC_75K_P) = ''              => -0.0055275286,
               ((real)c_inc_75k_p < 18.1500015259) => 0.004854447,
                                                      -0.0055275286));

N1795_6 :=__common__( map(trim(C_BARGAINS) = ''      => -0.0084227898,
               ((real)c_bargains < 145.5) => N1795_7,
                                             -0.0084227898));

N1795_5 :=__common__( map(trim(C_HVAL_1001K_P) = ''     => N1795_6,
               ((real)c_hval_1001k_p < 0.25) => -4.9096172e-006,
                                                N1795_6));

N1795_4 :=__common__( map(trim(C_PRESCHL) = ''      => 0.0054660572,
               ((real)c_preschl < 118.5) => -0.0039890491,
                                            0.0054660572));

N1795_3 :=__common__( map(trim(C_HVAL_300K_P) = ''               => N1795_4,
               ((real)c_hval_300k_p < 0.449999988079) => 0.01004046,
                                                         N1795_4));

N1795_2 :=__common__( if(((integer)c_burglary < 37), N1795_3, N1795_5));

N1795_1 :=__common__( if(trim(C_BURGLARY) != '', N1795_2, 0.0022472325));

N1796_8 :=__common__( map(((real)f_corrssnaddrcount_d <= NULL) => -0.0031213313,
               ((real)f_corrssnaddrcount_d < 4.5)   => 0.0059891866,
                                                       -0.0031213313));

N1796_7 :=__common__( map(trim(C_INC_200K_P) = ''              => 0.0047424595,
               ((real)c_inc_200k_p < 1.65000009537) => -0.0053866333,
                                                       0.0047424595));

N1796_6 :=__common__( map(trim(C_EXP_PROD) = ''     => N1796_7,
               ((real)c_exp_prod < 44.5) => -0.010835733,
                                            N1796_7));

N1796_5 :=__common__( map(trim(C_HH5_P) = ''              => N1796_8,
               ((real)c_hh5_p < 4.55000019073) => N1796_6,
                                                  N1796_8));

N1796_4 :=__common__( if(((real)c_hh4_p < 15.25), N1796_5, -0.005197266));

N1796_3 :=__common__( if(trim(C_HH4_P) != '', N1796_4, 0.0073949294));

N1796_2 :=__common__( if(((real)f_corraddrphonecount_d < 0.5), 0.00056274171, N1796_3));

N1796_1 :=__common__( if(((real)f_corraddrphonecount_d > NULL), N1796_2, -0.0024937247));

N1797_10 :=__common__( map(trim(C_MED_RENT) = ''      => 0.0039732327,
                ((real)c_med_rent < 545.5) => -0.0046545019,
                                              0.0039732327));

N1797_9 :=__common__( if(((real)c_pop_75_84_p < 2.15000009537), -0.0069037439, N1797_10));

N1797_8 :=__common__( if(trim(C_POP_75_84_P) != '', N1797_9, 0.020239753));

N1797_7 :=__common__( map(trim(C_INC_50K_P) = ''              => 0.0088328362,
               ((real)c_inc_50k_p < 18.8499984741) => 0.0014538388,
                                                      0.0088328362));

N1797_6 :=__common__( map(trim(C_SPAN_LANG) = ''     => -0.0026313345,
               ((real)c_span_lang < 39.5) => 0.0034363502,
                                             -0.0026313345));

N1797_5 :=__common__( if(((real)c_employees < 180.5), N1797_6, N1797_7));

N1797_4 :=__common__( if(trim(C_EMPLOYEES) != '', N1797_5, 0.0011212401));

N1797_3 :=__common__( map(((real)r_i60_inq_comm_count12_i <= NULL) => N1797_8,
               ((real)r_i60_inq_comm_count12_i < 0.5)   => N1797_4,
                                                           N1797_8));

N1797_2 :=__common__( if(((real)r_i60_inq_comm_recency_d > NULL), N1797_3, 0.0030939034));

N1797_1 :=__common__( if(((real)r_pb_order_freq_d > NULL), 0.00011919796, N1797_2));

N1798_10 :=__common__( if(((integer)f_prevaddrmedianvalue_d < 94053), 0.0013730605, -0.0022633027));

N1798_9 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N1798_10, -0.0092367886));

N1798_8 :=__common__( map(trim(C_FOOD) = ''              => -0.0029261396,
               ((real)c_food < 10.8500003815) => -0.013265426,
                                                 -0.0029261396));

N1798_7 :=__common__( map(trim(C_INC_125K_P) = ''              => N1798_9,
               ((real)c_inc_125k_p < 4.05000019073) => N1798_8,
                                                       N1798_9));

N1798_6 :=__common__( map(trim(C_INC_125K_P) = ''              => N1798_7,
               ((real)c_inc_125k_p < 3.34999990463) => 0.00086559963,
                                                       N1798_7));

N1798_5 :=__common__( if(((real)c_finance < 15.25), N1798_6, 0.0053387818));

N1798_4 :=__common__( if(trim(C_FINANCE) != '', N1798_5, 0.0013387152));

N1798_3 :=__common__( if(((real)c_rental < 184.5), -0.00049593713, 0.0076873553));

N1798_2 :=__common__( if(trim(C_RENTAL) != '', N1798_3, 0.0026296297));

N1798_1 :=__common__( if(((real)r_p88_phn_dst_to_inp_add_i > NULL), N1798_2, N1798_4));

N1799_8 :=__common__( map(trim(C_LOWRENT) = ''      => 0.0084568011,
               ((real)c_lowrent < 87.75) => 0.00086801222,
                                            0.0084568011));

N1799_7 :=__common__( map(trim(C_PRESCHL) = ''     => -0.0018591874,
               ((real)c_preschl < 39.5) => 0.0067284255,
                                           -0.0018591874));

N1799_6 :=__common__( if(((integer)r_d31_attr_bankruptcy_recency_d < 30), N1799_7, 0.0081825597));

N1799_5 :=__common__( if(((real)r_d31_attr_bankruptcy_recency_d > NULL), N1799_6, 0.0037677445));

N1799_4 :=__common__( map(trim(C_CARTHEFT) = ''      => N1799_5,
               ((real)c_cartheft < 162.5) => -0.0040382539,
                                             N1799_5));

N1799_3 :=__common__( map(trim(C_HVAL_300K_P) = ''              => 0.0030354878,
               ((real)c_hval_300k_p < 3.84999990463) => N1799_4,
                                                        0.0030354878));

N1799_2 :=__common__( if(((real)c_popover18 < 894.5), N1799_3, N1799_8));

N1799_1 :=__common__( if(trim(C_POPOVER18) != '', N1799_2, -0.00041743469));

N1800_9 :=__common__( map(((real)f_mos_liens_unrel_cj_fseen_d <= NULL) => -0.0001147793,
               ((real)f_mos_liens_unrel_cj_fseen_d < 126.5) => -0.012573223,
                                                               -0.0001147793));

N1800_8 :=__common__( if(((real)f_varmsrcssnunrelcount_i < 0.5), N1800_9, 0.0012578646));

N1800_7 :=__common__( if(((real)f_varmsrcssnunrelcount_i > NULL), N1800_8, 0.0054613427));

N1800_6 :=__common__( map(trim(C_POP_35_44_P) = ''      => 0.010613343,
               ((real)c_pop_35_44_p < 13.75) => -0.00023186982,
                                                0.010613343));

N1800_5 :=__common__( map(trim(C_LOWRENT) = ''              => N1800_6,
               ((real)c_lowrent < 12.1499996185) => -0.0017478234,
                                                    N1800_6));

N1800_4 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0103770336136), 0.0090707772, N1800_5));

N1800_3 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1800_4, 0.013404323));

N1800_2 :=__common__( map(trim(C_RNT1250_P) = ''              => N1800_3,
               ((real)c_rnt1250_p < 4.35000038147) => -0.00061528811,
                                                      N1800_3));

N1800_1 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1800_2, N1800_7));

N1801_8 :=__common__( map(((real)f_corraddrnamecount_d <= NULL) => 0.0033353476,
               ((real)f_corraddrnamecount_d < 2.5)   => -0.0040789599,
                                                        0.0033353476));

N1801_7 :=__common__( map(trim(C_CHILD) = ''              => -0.0060707317,
               ((real)c_child < 24.1500015259) => 0.003237243,
                                                  -0.0060707317));

N1801_6 :=__common__( map(trim(C_CARTHEFT) = ''      => N1801_8,
               ((real)c_cartheft < 153.5) => N1801_7,
                                             N1801_8));

N1801_5 :=__common__( map(trim(C_HVAL_400K_P) = ''               => 0.0071624139,
               ((real)c_hval_400k_p < 0.649999976158) => N1801_6,
                                                         0.0071624139));

N1801_4 :=__common__( if(((integer)f_fp_prevaddrburglaryindex_i < 75), 0.0069200789, N1801_5));

N1801_3 :=__common__( if(((real)f_fp_prevaddrburglaryindex_i > NULL), N1801_4, -0.014191637));

N1801_2 :=__common__( if(((real)c_hval_80k_p < 17.75), -0.00074121465, N1801_3));

N1801_1 :=__common__( if(trim(C_HVAL_80K_P) != '', N1801_2, -0.0023105583));

N1802_9 :=__common__( if(((real)c_rnt250_p < 46.6500015259), -0.00060458982, -0.0075950059));

N1802_8 :=__common__( if(trim(C_RNT250_P) != '', N1802_9, -0.0025272022));

N1802_7 :=__common__( map(trim(C_ASSAULT) = ''      => -0.0054047656,
               ((real)c_assault < 129.5) => 0.00099589634,
                                            -0.0054047656));

N1802_6 :=__common__( map(trim(C_RICH_FAM) = ''      => -0.0068129008,
               ((real)c_rich_fam < 176.5) => 0.0022189304,
                                             -0.0068129008));

N1802_5 :=__common__( map(trim(C_HH00) = ''      => 0.0084994281,
               ((real)c_hh00 < 859.5) => N1802_6,
                                         0.0084994281));

N1802_4 :=__common__( if(((real)c_rnt1000_p < 15.4499998093), N1802_5, N1802_7));

N1802_3 :=__common__( if(trim(C_RNT1000_P) != '', N1802_4, -0.00099248323));

N1802_2 :=__common__( if(((real)f_inq_per_addr_i < 1.5), N1802_3, N1802_8));

N1802_1 :=__common__( if(((real)f_inq_per_addr_i > NULL), N1802_2, 0.0074735768));

N1803_8 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)           => 0.0029944134,
               ((real)f_add_input_nhood_vac_pct_i < 0.0804545804858) => -0.0079283046,
                                                                        0.0029944134));

N1803_7 :=__common__( map((fp_segment in ['1 SSN Prob', '2 NAS 479', '4 Bureau Only', '7 Other']) => -0.012625136,
               (fp_segment in ['3 New DID', '5 Derog', '6 Recent Activity'])           => N1803_8,
                                                                                          -0.012625136));

N1803_6 :=__common__( map(trim(C_RNT500_P) = ''              => N1803_7,
               ((real)c_rnt500_p < 11.0500001907) => 0.00051844946,
                                                     N1803_7));

N1803_5 :=__common__( map(trim(C_BUSINESS) = ''    => N1803_6,
               ((real)c_business < 7.5) => 0.0006698296,
                                           N1803_6));

N1803_4 :=__common__( if(((real)c_no_teens < 36.5), N1803_5, 0.00078519889));

N1803_3 :=__common__( if(trim(C_NO_TEENS) != '', N1803_4, 0.00050773099));

N1803_2 :=__common__( if(((real)r_i61_inq_collection_count12_i < 2.5), N1803_3, 0.0078799968));

N1803_1 :=__common__( if(((real)r_i61_inq_collection_count12_i > NULL), N1803_2, -0.0018242272));

N1804_8 :=__common__( map(((real)f_curraddrburglaryindex_i <= NULL) => 0.0036523463,
               ((integer)f_curraddrburglaryindex_i < 93) => -0.007172349,
                                                            0.0036523463));

N1804_7 :=__common__( map(trim(C_CONSTRUCTION) = ''               => N1804_8,
               ((real)c_construction < 0.449999988079) => 0.007334638,
                                                          N1804_8));

N1804_6 :=__common__( map(((real)f_mos_inq_banko_cm_fseen_d <= NULL) => 0.0010472461,
               ((real)f_mos_inq_banko_cm_fseen_d < 67.5)  => -0.0040206446,
                                                             0.0010472461));

N1804_5 :=__common__( map(trim(C_HH2_P) = ''              => N1804_7,
               ((real)c_hh2_p < 24.4500007629) => N1804_6,
                                                  N1804_7));

N1804_4 :=__common__( if(((real)r_d32_criminal_count_i < 3.5), N1804_5, 0.0046183319));

N1804_3 :=__common__( if(((real)r_d32_criminal_count_i > NULL), N1804_4, 0.00066346407));

N1804_2 :=__common__( if(((real)c_hh2_p < 28.1500015259), N1804_3, -0.00061783087));

N1804_1 :=__common__( if(trim(C_HH2_P) != '', N1804_2, -0.0027980928));

N1805_10 :=__common__( map(trim(C_RETIRED) = ''              => 0.0043565925,
                ((real)c_retired < 14.5500001907) => -0.001866238,
                                                     0.0043565925));

N1805_9 :=__common__( map(trim(C_LOWINC) = ''      => -0.007114586,
               ((real)c_lowinc < 54.25) => N1805_10,
                                           -0.007114586));

N1805_8 :=__common__( if(((real)c_newhouse < 43.3499984741), N1805_9, 0.0047812577));

N1805_7 :=__common__( if(trim(C_NEWHOUSE) != '', N1805_8, -0.016456845));

N1805_6 :=__common__( if(((integer)r_l80_inp_avm_autoval_d < 19832), 0.0055142466, N1805_7));

N1805_5 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1805_6, 0.00096223376));

N1805_4 :=__common__( map(trim(C_RETAIL) = ''      => 0.0052378704,
               ((real)c_retail < 31.25) => -0.002905202,
                                           0.0052378704));

N1805_3 :=__common__( if(((real)f_addrchangeincomediff_d > NULL), N1805_4, -0.0013276673));

N1805_2 :=__common__( if(((real)f_prevaddrmedianvalue_d < 75384.5), N1805_3, N1805_5));

N1805_1 :=__common__( if(((real)f_prevaddrmedianvalue_d > NULL), N1805_2, -0.0083599467));

N1806_9 :=__common__( if(((real)c_inc_35k_p < 12.0500001907), -0.0013856852, 0.009975169));

N1806_8 :=__common__( if(trim(C_INC_35K_P) != '', N1806_9, -0.035688077));

N1806_7 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL) => N1806_8,
               ((real)f_curraddrcrimeindex_i < 193.5) => -0.00020715001,
                                                         N1806_8));

N1806_6 :=__common__( map(trim(C_HVAL_125K_P) = ''              => -0.013353222,
               ((real)c_hval_125k_p < 13.6499996185) => -0.0045643023,
                                                        -0.013353222));

N1806_5 :=__common__( if(((real)c_pop_75_84_p < 2.04999995232), 0.0009608272, N1806_6));

N1806_4 :=__common__( if(trim(C_POP_75_84_P) != '', N1806_5, -0.034196454));

N1806_3 :=__common__( map(((real)f_add_input_nhood_vac_pct_i <= NULL)          => N1806_4,
               ((real)f_add_input_nhood_vac_pct_i < 0.020356759429) => 0.0027543857,
                                                                       N1806_4));

N1806_2 :=__common__( if(((real)f_mos_acc_lseen_d < 67.5), N1806_3, N1806_7));

N1806_1 :=__common__( if(((real)f_mos_acc_lseen_d > NULL), N1806_2, 0.0026399986));

N1807_10 :=__common__( map(trim(C_EMPLOYEES) = ''       => -0.006524486,
                ((real)c_employees < 6174.5) => 0.0010077784,
                                                -0.006524486));

N1807_9 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i < 0.0662742257118), -0.0078292344, 0.0032234441));

N1807_8 :=__common__( if(((real)f_add_curr_nhood_bus_pct_i > NULL), N1807_9, -0.012289007));

N1807_7 :=__common__( if(((integer)r_i60_inq_banking_recency_d < 9), N1807_8, N1807_10));

N1807_6 :=__common__( if(((real)r_i60_inq_banking_recency_d > NULL), N1807_7, -0.0013445742));

N1807_5 :=__common__( map(trim(C_OLDHOUSE) = ''       => -0.0059009984,
               ((real)c_oldhouse < 127.25) => 0.0024966349,
                                              -0.0059009984));

N1807_4 :=__common__( if(((real)f_prevaddrmedianincome_d < 45605.5), N1807_5, 0.0026442483));

N1807_3 :=__common__( if(((real)f_prevaddrmedianincome_d > NULL), N1807_4, -0.0025905037));

N1807_2 :=__common__( if(((real)c_inc_125k_p < 1.25), N1807_3, N1807_6));

N1807_1 :=__common__( if(trim(C_INC_125K_P) != '', N1807_2, 0.00051626964));

N1808_9 :=__common__( if(((real)c_cartheft < 106.5), -0.0017986362, 0.012054226));

N1808_8 :=__common__( if(trim(C_CARTHEFT) != '', N1808_9, 0.0060116885));

N1808_7 :=__common__( map(trim(C_CHILD) = ''              => 0.0073207881,
               ((real)c_child < 24.5499992371) => -0.002414911,
                                                  0.0073207881));

N1808_6 :=__common__( if(((real)c_inc_25k_p < 11.0500001907), N1808_7, -0.0028444371));

N1808_5 :=__common__( if(trim(C_INC_25K_P) != '', N1808_6, -0.011732964));

N1808_4 :=__common__( if(((real)f_addrchangevaluediff_d < -107353.5), -0.0091777762, 0.00040342168));

N1808_3 :=__common__( if(((real)f_addrchangevaluediff_d > NULL), N1808_4, N1808_5));

N1808_2 :=__common__( if(((real)r_l80_inp_avm_autoval_d > NULL), N1808_3, -5.7612154e-005));

N1808_1 :=__common__( map(((real)c_a49_prop_sold_purchase_tot_d <= NULL)    => N1808_8,
               ((integer)c_a49_prop_sold_purchase_tot_d < 26886) => N1808_2,
                                                                    N1808_8));

N1809_7 :=__common__( map(trim(C_NEWHOUSE) = ''              => -0.0074098635,
               ((real)c_newhouse < 21.0499992371) => 0.00223137,
                                                     -0.0074098635));

N1809_6 :=__common__( map(trim(C_YOUNG) = ''      => 0.0047269672,
               ((real)c_young < 19.25) => -0.0026067251,
                                          0.0047269672));

N1809_5 :=__common__( map(trim(C_FAMMAR18_P) = ''              => 0.012320062,
               ((real)c_fammar18_p < 40.9500007629) => N1809_6,
                                                       0.012320062));

N1809_4 :=__common__( map(trim(C_SPAN_LANG) = ''      => N1809_7,
               ((real)c_span_lang < 150.5) => N1809_5,
                                              N1809_7));

N1809_3 :=__common__( map(trim(C_VERY_RICH) = ''      => -0.0024131564,
               ((real)c_very_rich < 126.5) => N1809_4,
                                              -0.0024131564));

N1809_2 :=__common__( if(((real)c_rnt750_p < 42.0499992371), -0.00078384911, N1809_3));

N1809_1 :=__common__( if(trim(C_RNT750_P) != '', N1809_2, -0.0021737992));

N1810_8 :=__common__( map(trim(C_FAMMAR18_P) = ''              => -0.0044515697,
               ((real)c_fammar18_p < 35.1500015259) => 0.0028976351,
                                                       -0.0044515697));

N1810_7 :=__common__( map(trim(C_HEALTH) = ''              => 0.015177508,
               ((real)c_health < 6.35000038147) => 0.0016510724,
                                                   0.015177508));

N1810_6 :=__common__( map(trim(C_HH1_P) = ''              => N1810_8,
               ((real)c_hh1_p < 17.5499992371) => N1810_7,
                                                  N1810_8));

N1810_5 :=__common__( map(((real)f_add_curr_nhood_sfd_pct_d <= NULL)          => N1810_6,
               ((real)f_add_curr_nhood_sfd_pct_d < 0.386560291052) => -0.0051898953,
                                                                      N1810_6));

N1810_4 :=__common__( if(((real)f_add_curr_nhood_mfd_pct_i > NULL), N1810_5, -0.0011337422));

N1810_3 :=__common__( map(trim(C_BIGAPT_P) = ''              => 0.0087516095,
               ((real)c_bigapt_p < 17.1500015259) => N1810_4,
                                                     0.0087516095));

N1810_2 :=__common__( if(((real)c_work_home < 113.5), -0.00059971339, N1810_3));

N1810_1 :=__common__( if(trim(C_WORK_HOME) != '', N1810_2, 0.0015735257));

N1811_9 :=__common__( if(((real)f_rel_incomeover25_count_d < 12.5), 0.0035249477, -0.0090697476));

N1811_8 :=__common__( if(((real)f_rel_incomeover25_count_d > NULL), N1811_9, -0.029309865));

N1811_7 :=__common__( map(trim(C_LOW_ED) = ''              => -0.0020765762,
               ((real)c_low_ed < 70.4499969482) => 0.00084007601,
                                                   -0.0020765762));

N1811_6 :=__common__( map(trim(C_TOTCRIME) = ''       => -0.0078988184,
               ((integer)c_totcrime < 192) => N1811_7,
                                              -0.0078988184));

N1811_5 :=__common__( map(trim(C_ASSAULT) = ''      => 0.0034785846,
               ((real)c_assault < 191.5) => N1811_6,
                                            0.0034785846));

N1811_4 :=__common__( if(((real)f_liens_unrel_cj_total_amt_i < 8514.5), N1811_5, N1811_8));

N1811_3 :=__common__( if(((real)f_liens_unrel_cj_total_amt_i > NULL), N1811_4, -0.0019617409));

N1811_2 :=__common__( if(((real)c_vacant_p < 34.25), N1811_3, -0.0069172175));

N1811_1 :=__common__( if(trim(C_VACANT_P) != '', N1811_2, -0.0024048917));

N1812_8 :=__common__( map(((real)f_curraddrcrimeindex_i <= NULL)  => 0.0085323653,
               ((integer)f_curraddrcrimeindex_i < 136) => 0.0010333335,
                                                          0.0085323653));

N1812_7 :=__common__( map(trim(C_HH7P_P) = ''              => 0.006988742,
               ((real)c_hh7p_p < 9.44999980927) => -0.00034664763,
                                                   0.006988742));

N1812_6 :=__common__( map(trim(C_RNT1000_P) = ''              => N1812_8,
               ((real)c_rnt1000_p < 34.8499984741) => N1812_7,
                                                      N1812_8));

N1812_5 :=__common__( map(trim(C_RETAIL) = ''              => 0.0048902745,
               ((real)c_retail < 15.6499996185) => -0.0059949195,
                                                   0.0048902745));

N1812_4 :=__common__( if(((real)c_retired < 3.45000004768), N1812_5, N1812_6));

N1812_3 :=__common__( if(trim(C_RETIRED) != '', N1812_4, -0.003676586));

N1812_2 :=__common__( if(((real)r_c20_email_count_i < 12.5), N1812_3, 0.0068820991));

N1812_1 :=__common__( if(((real)r_c20_email_count_i > NULL), N1812_2, 0.011021547));

N1813_10 :=__common__( if(((real)c_med_rent < 555.5), 0.00025219527, -0.010067841));

N1813_9 :=__common__( if(trim(C_MED_RENT) != '', N1813_10, -0.042107595));

N1813_8 :=__common__( if(((real)c_business < 4.5), 0.0018941422, -0.00037566236));

N1813_7 :=__common__( if(trim(C_BUSINESS) != '', N1813_8, -0.0012924948));

N1813_6 :=__common__( if(((real)f_rel_educationover12_count_d < 31.5), N1813_7, 0.0068644809));

N1813_5 :=__common__( if(((real)f_rel_educationover12_count_d > NULL), N1813_6, -0.00051380596));

N1813_4 :=__common__( map(((real)f_inq_auto_count24_i <= NULL) => -0.0079404118,
               ((real)f_inq_auto_count24_i < 3.5)   => N1813_5,
                                                       -0.0079404118));

N1813_3 :=__common__( map(((real)f_inq_count24_i <= NULL) => 0.0071294166,
               ((real)f_inq_count24_i < 23.5)  => N1813_4,
                                                  0.0071294166));

N1813_2 :=__common__( if(((real)f_srchssnsrchcount_i < 32.5), N1813_3, N1813_9));

N1813_1 :=__common__( if(((real)f_srchssnsrchcount_i > NULL), N1813_2, -0.0009226966));

ENDMACRO;