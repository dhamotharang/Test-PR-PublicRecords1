//Strategic Link Consulting Score - FCRA 4.1

import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVG1401_2_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVG_DEBUG := FALSE;

  #if(RVG_DEBUG)
    layout_debug := record
		  integer sysdate;                                                        
			integer ver_src_ba_pos;                                                 
			boolean ver_src_ba;                                                     
			integer ver_src_ds_pos;                                                 
			boolean ver_src_ds;                                                     
			integer ver_src_l2_pos;                                                 
			boolean ver_src_l2;                                                     
			integer bureau_adl_tn_fseen_pos;                                        
			string bureau_adl_fseen_tn;                                            
			integer _bureau_adl_fseen_tn;                                           
			integer bureau_adl_ts_fseen_pos;                                        
			string bureau_adl_fseen_ts;                                            
			integer _bureau_adl_fseen_ts;                                           
			integer bureau_adl_tu_fseen_pos;                                        
			string bureau_adl_fseen_tu;                                            
			integer _bureau_adl_fseen_tu;                                           
			integer bureau_adl_en_fseen_pos;                                        
			string bureau_adl_fseen_en;                                            
			integer _bureau_adl_fseen_en;                                           
			integer bureau_adl_eq_fseen_pos;                                        
			string bureau_adl_fseen_eq;                                            
			integer _bureau_adl_fseen_eq;                                           
			integer iv_sr001_m_bureau_adl_fs;                                       
			integer iv_ms001_ssns_per_adl;                                          
			integer iv_pv001_inp_avm_autoval;                                       
			integer prop_adl_p_fseen_pos;                                           
			string prop_adl_fseen_p;                                               
			integer _prop_adl_fseen_p;                                              
			integer _src_prop_adl_fseen;                                            
			integer iv_pl001_m_snc_prop_adl_fs;                                     
			integer iv_in001_estimated_income;                                      
			integer iv_inp_addr_address_score;                                      
			integer iv_prop_sold_assessed_total;                                    
			integer iv_addrs_10yr;                                                  
			integer iv_inq_auto_count12;                                            
			integer iv_inq_highriskcredit_recency;                                  
			string iv_paw_dead_bus_x_active_phn;                                   
			boolean ver_phn_inf;                                                    
			boolean ver_phn_nap;                                                    
			integer inf_phn_ver_lvl;                                                
			integer nap_phn_ver_lvl;                                                
			string iv_nap_phn_ver_x_inf_phn_ver;                                   
			integer _reported_dob;                                                  
			integer reported_age;                                                   
			integer _combined_age;                                                  
			boolean evidence_of_college;                                            
			string iv_college_attendance_x_age;                                    
			string iv_prof_license_category;                                       
			string iv_vp091_phnzip_mismatch;                                       
			integer iv_pb_average_dollars;                                          
			integer cs_pct_addrs_le_12mo;                                           
			integer _gong_did_last_seen;                                            
			integer _gong_did_first_seen;                                           
			integer cs_gong_duration;                                               
			integer bureau_adl_vo_fseen_pos;                                        
			string bureau_adl_fseen_vo;                                            
			integer _bureau_adl_fseen_vo;                                           
			integer _src_bureau_adl_fseen;                                          
			integer mth_ver_src_fdate_vo;                                           
			integer bureau_adl_vo_lseen_pos;                                        
			string bureau_adl_lseen_vo;                                            
			integer _bureau_adl_lseen_vo;                                           
			integer mth_ver_src_ldate_vo;                                           
			boolean mth_ver_src_fdate_vo60;                                         
			boolean mth_ver_src_ldate_vo0;                                          
			integer bureau_adl_w_lseen_pos;                                         
			string bureau_adl_lseen_w;                                             
			integer _bureau_adl_lseen_w;                                            
			integer mth_ver_src_ldate_w;                                            
			boolean mth_ver_src_ldate_w0;                                           
			integer bureau_adl_wp_lseen_pos;                                        
			string bureau_adl_lseen_wp;                                            
			integer _bureau_adl_lseen_wp;                                           
			integer _src_bureau_adl_lseen;                                          
			integer mth_ver_src_ldate_wp;                                           
			boolean mth_ver_src_ldate_wp0;                                          
			integer _paw_first_seen;                                                
			integer mth_paw_first_seen;                                             
			integer mth_paw_first_seen2;                                            
			boolean ver_src_am;                                                     
			boolean ver_src_e1;                                                     
			boolean ver_src_e2;                                                     
			boolean ver_src_e3;                                                     
			boolean ver_src_pl;                                                     
			boolean ver_src_w;                                                      
			boolean paw_dead_business_count_gt3;                                    
			boolean paw_active_phone_count_0;                                       
			integer _infutor_first_seen;                                            
			integer mth_infutor_first_seen;                                         
			integer _infutor_last_seen;                                             
			integer mth_infutor_last_seen;                                          
			integer infutor_i;                                                      
			integer infutor_im;                                                     
			integer white_pages_adl_wp_fseen_pos;                                   
			string white_pages_adl_fseen_wp;                                       
			integer _white_pages_adl_fseen_wp;                                      
			integer _src_white_pages_adl_fseen;                                     
			integer iv_sr001_m_wp_adl_fs;                                           
			integer src_m_wp_adl_fs;                                                
			integer src_m_hdr_fs;                                                   
			real source_mod6;                                                    
			real iv_sr001_source_profile;                                        
			integer iv_de001_eviction_recency;                                      
			boolean email_src_im;                                                   
			integer iv_ds001_impulse_count;                                         
			string iv_in001_wealth_index;                                          
			string iv_nap_status;                                                  
			integer iv_prv_addr_assessed_total_val;                                 
			integer iv_avg_prop_assess_purch_amt;                                   
			integer iv_credit_seeking;                                              
			string iv_rec_vehx_level;                                              
			integer iv_attr_rel_liens_recency;                                      
			integer iv_non_derog_count;                                             
			string iv_criminal_x_felony;                                           
			integer iv_pb_total_orders;                                             
			integer cs_outstanding_liens_ct;                                        
			string iv_vp002_phn_disconnected;                                      
			integer _header_first_seen;                                             
			integer iv_sr001_m_hdr_fs;                                              
			integer iv_bst_addr_mortgage_amount;                                    
			integer iv_prv_addr_avm_auto_val;                                       
			integer iv_prop_owned_assessed_total;                                   
			integer iv_paw_active_phone_count;                                      
			integer iv_attr_addrs_recency;                                          
			integer iv_attr_purchase_recency;                                       
			string iv_vp003_phn_invalid;                                           
			string add_ec1;                                                        
			string add_ec3;                                                        
			string add_ec4;                                                        
			string iv_va100_add_problem;                                           
			integer iv_pv001_bst_avm_autoval;                                       
			integer bureau_addr_tn_fseen_pos;                                       
			string bureau_addr_fseen_tn;                                           
			integer _bureau_addr_fseen_tn;                                          
			integer bureau_addr_ts_fseen_pos;                                       
			string bureau_addr_fseen_ts;                                           
			integer _bureau_addr_fseen_ts;                                          
			integer bureau_addr_tu_fseen_pos;                                       
			string bureau_addr_fseen_tu;                                           
			integer _bureau_addr_fseen_tu;                                          
			integer bureau_addr_en_fseen_pos;                                       
			string bureau_addr_fseen_en;                                           
			integer _bureau_addr_fseen_en;                                          
			integer bureau_addr_eq_fseen_pos;                                       
			string bureau_addr_fseen_eq;                                           
			integer _bureau_addr_fseen_eq;                                          
			integer _src_bureau_addr_fseen;                                         
			integer iv_mos_src_bureau_addr_fseen;                                   
			integer prv_addr_date_last_seen;                                        
			integer iv_mos_since_prv_addr_lseen;                                    
			integer cs_bst_to_avg_lres_ratio;                                       
			real new_derog_a_subscore0;                                          
			real new_derog_a_subscore1;                                          
			real new_derog_a_subscore2;                                          
			real new_derog_a_subscore3;                                          
			real new_derog_a_subscore4;                                          
			real new_derog_a_subscore5;                                          
			real new_derog_a_subscore6;                                          
			real new_derog_a_subscore7;                                          
			real new_derog_a_subscore8;                                          
			real new_derog_a_subscore9;                                          
			real new_derog_a_subscore10;                                         
			real new_derog_a_subscore11;                                         
			real new_derog_a_subscore12;                                         
			real new_derog_a_subscore13;                                         
			real new_derog_a_subscore14;                                         
			real new_derog_a_subscore15;                                         
			real new_derog_a_subscore16;                                         
			real new_derog_a_subscore17;                                         
			real new_derog_a_subscore18;                                         
			real new_derog_a_subscore19;                                         
			real new_derog_a_subscore20;                                         
			real new_derog_a_subscore21;                                         
			real new_derog_a_subscore22;                                         
			real new_derog_a_subscore23;                                         
			real new_derog_a_subscore24;                                         
			real new_derog_a_subscore25;                                         
			real new_derog_a_subscore26;                                         
			real new_derog_a_subscore27;                                         
			real new_derog_a_subscore28;                                         
			real new_derog_a_scaledscore;                                        
			real new_owner_a_subscore0;                                          
			real new_owner_a_subscore1;                                          
			real new_owner_a_subscore2;                                          
			real new_owner_a_subscore3;                                          
			real new_owner_a_subscore4;                                          
			real new_owner_a_subscore5;                                          
			real new_owner_a_subscore6;                                          
			real new_owner_a_subscore7;                                          
			real new_owner_a_subscore8;                                          
			real new_owner_a_subscore9;                                          
			real new_owner_a_subscore10;                                         
			real new_owner_a_subscore11;                                         
			real new_owner_a_subscore12;                                         
			real new_owner_a_subscore13;                                         
			real new_owner_a_subscore14;                                         
			real new_owner_a_subscore15;                                         
			real new_owner_a_subscore16;                                         
			real new_owner_a_subscore17;                                         
			real new_owner_a_subscore18;                                         
			real new_owner_a_subscore19;                                         
			real new_owner_a_subscore20;                                         
			real new_owner_a_subscore21;                                         
			real new_owner_a_scaledscore;                                        
			real new_other_a_subscore0;                                          
			real new_other_a_subscore1;                                          
			real new_other_a_subscore2;                                          
			real new_other_a_subscore3;                                          
			real new_other_a_subscore4;                                          
			real new_other_a_subscore5;                                          
			real new_other_a_subscore6;                                          
			real new_other_a_subscore7;                                          
			real new_other_a_subscore8;                                          
			real new_other_a_subscore9;                                          
			real new_other_a_subscore10;                                         
			real new_other_a_subscore11;                                         
			real new_other_a_subscore12;                                         
			real new_other_a_subscore13;                                         
			real new_other_a_subscore14;                                         
			real new_other_a_subscore15;                                         
			real new_other_a_subscore16;                                         
			real new_other_a_subscore17;                                         
			real new_other_a_subscore18;                                         
			real new_other_a_subscore19;                                         
			real new_other_a_subscore20;                                         
			real new_other_a_subscore21;                                         
			real new_other_a_subscore22;                                         
			real new_other_a_scaledscore;                                        
			boolean source_tot_l2;                                                  
			boolean source_tot_li;                                                  
			boolean source_tot_ds;                                                  
			boolean source_tot_ba;                                                  
			integer pk_impulse_count;                                               
			boolean bs_attr_derog_flag;                                             
			boolean bs_attr_eviction_flag;                                          
			boolean prop_owner;                                                     
			boolean segment_d;                                                      
			boolean segment_y;                                                      
			boolean segment_o;                                                      
			integer _rvg1401_2_0;                                                   
			boolean bk_flag;                                                        
			boolean lien_rec_unrel_flag;                                            
			boolean lien_hist_unrel_flag;                                           
			boolean lien_flag;                                                      
			boolean ssn_deceased;                                                   
			boolean scored_222s;                                                    
			integer rvg1401_2_0;                                                    
			string rc1_d;                                                          
			string rc2_d;                                                          
			string rc3_d;                                                          
			string rc4_d;                                                          
			string rc5_d;                                                          
			string rc1_o;                                                          
			string rc2_o;                                                          
			string rc3_o;                                                          
			string rc4_o;                                                          
			string rc5_o;                                                          
			string rc1_oth;                                                        
			string rc2_oth;                                                        
			string rc3_oth;                                                        
			string rc4_oth;                                                        
			string rc5_oth;                                                        
			boolean glrc25_d;                                                       
			boolean glrc36_d;                                                       
			boolean glrc97_d;                                                       
			boolean glrc98_d;                                                       
			boolean glrc9c_d;                                                       
			boolean glrc9d_d;                                                       
			boolean glrc9e_d;                                                       
			boolean glrc9h_d;                                                       
			boolean glrc9i_d;                                                       
			boolean glrc9q_d;                                                       
			boolean glrc9r_d;                                                       
			boolean glrc9t_d;                                                       
			boolean glrc9w_d;                                                       
			// boolean glrc9y_d;                                                       
			boolean glrcev_d;                                                       
			boolean glrcms_d;                                                       
			boolean glrcpv_d;                                                       
			boolean glrcbl_d;                                                       
			boolean crim_f_d;                                                       
			boolean lien_f_d;                                                       
			boolean eviction_f_d;                                                   
			boolean impulse_f_d;                                                    
			boolean bk_f_d;                                                         
			integer derog_contributions_d;                                          
			real rcvalue97_0_d;                                                  
			real rcvalue98_0_d;                                                  
			real rcvalueev_0_d;                                                  
			real rcvalue9h_0_d;                                                  
			real rcvalue9w_0_d;                                                  
			real rcvalue9w_d;                                                    
			real rcvalue9q_1_d;                                                  
			real rcvalue9q_2_d;                                                  
			real rcvalue9q_3_d;                                                  
			real rcvalue9q_d;                                                    
			real rcvalue97_1_d;                                                  
			real rcvalue97_d;                                                    
			real rcvalue9c_1_d;                                                  
			real rcvalue9d_1_d;                                                  
			real rcvalue9d_2_d;                                                  
			real rcvalue9c_d;                                                    
			real rcvalue9d_d;                                                    
			real rcvalue9r_1_d;                                                  
			real rcvalue9r_2_d;                                                  
			real rcvalue9r_3_d;                                                  
			real rcvalue9r_d;                                                    
			real rcvaluems_1_d;                                                  
			real rcvaluems_d;                                                    
			real rcvalue98_1_d;                                                  
			real rcvalue98_d;                                                    
			real rcvalue25_1_d;                                                  
			real rcvalue25_d;                                                    
			real rcvaluebl_1_d;                                                  
			real rcvaluebl_2_d;                                                  
			real rcvaluebl_3_d;                                                  
			real rcvaluebl_d;                                                    
			real rcvalue36_1_d;                                                  
			real rcvalue36_d;                                                    
			real rcvalue9y_1_d;                                                  
			real rcvalue9y_d;                                                    
			real rcvaluepv_1_d;                                                  
			real rcvaluepv_2_d;                                                  
			real rcvaluepv_3_d;                                                  
			real rcvaluepv_4_d;                                                  
			real rcvaluepv_d;                                                    
			real rcvalue9e_1_d;                                                  
			real rcvalue9e_2_d;                                                  
			real rcvalue9e_3_d;                                                  
			real rcvalue9e_4_d;                                                  
			real rcvalue9e_d;                                                    
			real rcvalue9h_1_d;                                                  
			real rcvalue9h_d;                                                    
			real rcvalue9t_1_d;                                                  
			real rcvalue9t_d;                                                    
			real rcvalue9i_1_d;                                                  
			real rcvalue9i_d;                                                    
			real rcvalueev_1_d;                                                  
			real rcvalueev_d;                                                    
			boolean glrc16_o;                                                       
			boolean glrc25_o;                                                       
			boolean glrc36_o;                                                       
			boolean glrc9c_o;                                                       
			boolean glrc9d_o;                                                       
			boolean glrc9e_o;                                                       
			boolean glrc9i_o;                                                       
			boolean glrc9q_o;                                                       
			boolean glrc9r_o;                                                       
			boolean glrc9t_o;                                                       
			// boolean glrc9y_o;                                                       
			boolean glrcpv_o;                                                       
			boolean glrcbl_o;                                                       
			real rcvalue9q_1_o;                                                  
			real rcvalue9q_2_o;                                                  
			real rcvalue9q_o;                                                    
			real rcvalue9y_1_o;                                                  
			real rcvalue9y_o;                                                    
			real rcvalue36_1_o;                                                  
			real rcvalue36_o;                                                    
			real rcvalue25_1_o;                                                  
			real rcvalue25_o;                                                    
			real rcvaluepv_1_o;                                                  
			real rcvaluepv_2_o;                                                  
			real rcvaluepv_3_o;                                                  
			real rcvaluepv_o;                                                    
			real rcvalue9e_1_o;                                                  
			real rcvalue9e_2_o;                                                  
			real rcvalue9e_3_o;                                                  
			real rcvalue9e_o;                                                    
			real rcvalue16_1_o;                                                  
			real rcvalue16_o;                                                    
			real rcvaluebl_1_o;                                                  
			real rcvaluebl_2_o;                                                  
			real rcvaluebl_3_o;                                                  
			real rcvaluebl_o;                                                    
			real rcvalue9r_1_o;                                                  
			real rcvalue9r_2_o;                                                  
			real rcvalue9r_3_o;                                                  
			real rcvalue9r_o;                                                    
			real rcvalue9i_1_o;                                                  
			real rcvalue9i_o;                                                    
			real rcvalue9c_1_o;                                                  
			real rcvalue9c_2_o;                                                  
			real rcvalue9d_1_o;                                                  
			real rcvalue9c_o;                                                    
			real rcvalue9d_o;                                                    
			real rcvalue9t_1_o;                                                  
			real rcvalue9t_o;                                                    
			boolean glrc16_oth;                                                     
			boolean glrc36_oth;                                                     
			boolean glrc9a_oth;                                                     
			boolean glrc9c_oth;                                                     
			boolean glrc9d_oth;                                                     
			boolean glrc9e_oth;                                                     
			boolean glrc9i_oth;                                                     
			boolean glrc9q_oth;                                                     
			boolean glrc9r_oth;                                                     
			boolean glrc9t_oth;                                                     
			boolean glrc9u_oth;                                                     
			// boolean glrc9y_oth;                                                     
			boolean glrcms_oth;                                                     
			boolean glrcpv_oth;                                                     
			boolean glrcbl_oth;                                                     
			real rcvalue9a_0_oth;                                                
			real rcvalue9a_oth;                                                  
			real rcvalue9q_1_oth;                                                
			real rcvalue9q_2_oth;                                                
			real rcvalue9q_oth;                                                  
			real rcvaluebl_1_oth;                                                
			real rcvaluebl_oth;                                                  
			real rcvalue9y_1_oth;                                                
			real rcvalue9y_oth;                                                  
			real rcvalue9c_1_oth;                                                
			real rcvalue9c_2_oth;                                                
			real rcvalue9d_1_oth;                                                
			real rcvalue9e_1_oth;                                                
			real rcvalue9e_2_oth;                                                
			real rcvalue9e_3_oth;                                                
			real rcvalue9c_3_oth;                                                
			real rcvalue9d_2_oth;                                                
			real rcvalue9e_4_oth;                                                
			real rcvalue9d_3_oth;                                                
			real rcvalue9c_oth;                                                  
			real rcvalue9d_oth;                                                  
			real rcvalue9e_oth;                                                  
			real rcvaluems_1_oth;                                                
			real rcvaluems_oth;                                                  
			real rcvalue9r_1_oth;                                                
			real rcvalue9r_2_oth;                                                
			real rcvalue9r_3_oth;                                                
			real rcvalue9r_4_oth;                                                
			real rcvalue9r_oth;                                                  
			real rcvaluepv_1_oth;                                                
			real rcvaluepv_oth;                                                  
			real rcvalue36_1_oth;                                                
			real rcvalue36_oth;                                                  
			real rcvalue9i_1_oth;                                                
			real rcvalue9i_oth;                                                  
			real rcvalue9t_1_oth;                                                
			real rcvalue9t_oth;                                                  
			real rcvalue16_1_oth;                                                
			real rcvalue16_oth;                                                  
			real rcvalue9u_1_oth;                                                
			real rcvalue9u_oth;                                                  
			string rc1;                                                           
			string rc2;                                                            
			string rc3; 
			string rc4; 
			string rc5;                                                                                                                                
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
	truedid                          := le.truedid;
	out_z5                           := le.shell_input.z5;
	out_addr_status                  := le.shell_input.addr_status;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_status                       := le.iid.nap_status;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_phonezipflag                  := le.iid.phonezipflag;
	rc_pwphonezipflag                := le.iid.pwphonezipflag;
	rc_hriskaddrflag                 := le.iid.hriskaddrflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_bansflag                      := le.iid.bansflag;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_phonetype                     := le.iid.phonetype;
	rc_ziptypeflag                   := le.iid.ziptypeflag;
	rc_statezipflag                  := le.iid.statezipflag;
	rc_cityzipflag                   := le.iid.cityzipflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_addr_sources                 := le.header_summary.ver_addr_sources;
	ver_addr_sources_first_seen      := le.header_summary.ver_addr_sources_first_seen_date;
	addrpop                          := le.input_validation.address;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	age                              := le.name_verification.age;
	add1_address_score               := le.address_verification.input_address_information.address_score;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_lres                        := le.lres;
	add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
	add1_advo_throw_back             := le.advo_input_addr.throw_back_indicator;
	add1_advo_seasonal_delivery      := le.advo_input_addr.seasonal_delivery_indicator;
	add1_advo_college                := le.advo_input_addr.college_indicator;
	add1_advo_drop                   := le.advo_input_addr.drop_indicator;
	add1_advo_res_or_business        := le.advo_input_addr.residential_or_business_ind;
	add1_advo_mixed_address_usage    := le.advo_input_addr.mixed_address_usage;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_mortgage_amount             := le.address_verification.input_address_information.mortgage_amount;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_owned_assessed_total    := le.address_verification.owned.property_owned_assessed_total;
	property_owned_assessed_count    := le.address_verification.owned.property_owned_assessed_count;
	property_sold_total              := le.address_verification.sold.property_total;
	property_sold_assessed_total     := le.address_verification.sold.property_owned_assessed_total;
	add2_lres                        := le.lres2;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add2_mortgage_amount             := le.address_verification.address_history_1.mortgage_amount;
	add2_assessed_total_value        := le.address_verification.address_history_1.assessed_total_value;
	add2_date_last_seen              := le.address_verification.address_history_1.date_last_seen;
	add3_avm_automated_valuation     := le.avm.address_history_2.avm_automated_valuation;
	add3_assessed_total_value        := le.address_verification.address_history_2.assessed_total_value;
	add3_date_last_seen              := le.address_verification.address_history_2.date_last_seen;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	avg_mo_per_addr                  := le.address_history_summary.avg_mo_per_addr;
	addr_lres_12mo_count             := le.address_history_summary.lres_12mo_count;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	header_first_seen                := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_auto_count03                 := le.acc_logs.auto.count03;
	inq_auto_count12                 := le.acc_logs.auto.count12;
	inq_banking_count03              := le.acc_logs.banking.count03;
	inq_mortgage_count03             := le.acc_logs.mortgage.count03;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_retail_count03               := le.acc_logs.retail.count03;
	inq_communications_count03       := le.acc_logs.communications.count03;
	pb_average_dollars               := le.ibehavior.average_amount_per_order;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	paw_first_seen                   := le.employment.first_seen_date;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	infutor_last_seen                := le.infutor_phone.infutor_date_last_seen;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	email_source_list                := le.email_summary.email_source_list;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_date_first_purchase         := le.other_address_info.date_first_purchase;
	attr_num_purchase30              := le.other_address_info.num_purchase30;
	attr_num_purchase90              := le.other_address_info.num_purchase90;
	attr_num_purchase180             := le.other_address_info.num_purchase180;
	attr_num_purchase12              := le.other_address_info.num_purchase12;
	attr_num_purchase24              := le.other_address_info.num_purchase24;
	attr_num_purchase36              := le.other_address_info.num_purchase36;
	attr_num_purchase60              := le.other_address_info.num_purchase60;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_num_rel_liens30             := le.bjl.liens_released_count30;
	attr_num_rel_liens90             := le.bjl.liens_released_count90;
	attr_num_rel_liens180            := le.bjl.liens_released_count180;
	attr_num_rel_liens12             := le.bjl.liens_released_count12;
	attr_num_rel_liens24             := le.bjl.liens_released_count24;
	attr_num_rel_liens36             := le.bjl.liens_released_count36;
	attr_num_rel_liens60             := le.bjl.liens_released_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_recent_released_count      := le.bjl.liens_recent_released_count;
	liens_historical_released_count  := le.bjl.liens_historical_released_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	ams_age                          := le.student.age;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	prof_license_category            := le.professional_license.plcategory;
	wealth_index                     := le.wealth_indicator;
	input_dob_age                    := le.shell_input.age;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	reported_dob                     := le.reported_dob;
	estimated_income                 := le.estimated_income;

	NULL := -999999999;

	BOOLEAN indexw(string source, string target, string delim) :=
		(source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

	sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

	ver_src_ba_pos := Models.Common.findw_cpp(ver_sources, 'BA' , ' ,', 'ie');

	ver_src_ba := ver_src_ba_pos > 0;

	ver_src_ds_pos := Models.Common.findw_cpp(ver_sources, 'DS' , ' ,', 'ie');

	ver_src_ds := ver_src_ds_pos > 0;

	ver_src_l2_pos := Models.Common.findw_cpp(ver_sources, 'L2' , ' ,', 'ie');

	ver_src_l2 := ver_src_l2_pos > 0;

	bureau_adl_tn_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E');

	bureau_adl_fseen_tn := if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos, ','));

	_bureau_adl_fseen_tn := common.sas_date((string)(bureau_adl_fseen_tn));

	bureau_adl_ts_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E');

	bureau_adl_fseen_ts := if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos, ','));

	_bureau_adl_fseen_ts := common.sas_date((string)(bureau_adl_fseen_ts));

	bureau_adl_tu_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E');

	bureau_adl_fseen_tu := if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos, ','));

	_bureau_adl_fseen_tu := common.sas_date((string)(bureau_adl_fseen_tu));

	bureau_adl_en_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E');

	bureau_adl_fseen_en := if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ','));

	_bureau_adl_fseen_en := common.sas_date((string)(bureau_adl_fseen_en));

	bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

	bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

	_bureau_adl_fseen_eq := common.sas_date((string)(bureau_adl_fseen_eq));

	_src_bureau_adl_fseen_1 := min(if(_bureau_adl_fseen_tn = NULL, -NULL, _bureau_adl_fseen_tn), if(_bureau_adl_fseen_ts = NULL, -NULL, _bureau_adl_fseen_ts), if(_bureau_adl_fseen_tu = NULL, -NULL, _bureau_adl_fseen_tu), if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

	iv_sr001_m_bureau_adl_fs := map(
			not(truedid)                     => NULL,
			_src_bureau_adl_fseen_1 = 999999 => -1,
																					if ((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12))));

	iv_ms001_ssns_per_adl := map(
			not(truedid)     => NULL,
			ssns_per_adl = 0 => 1,
													ssns_per_adl);

	iv_pv001_inp_avm_autoval := if(not(add1_pop), NULL, add1_avm_automated_valuation);

	prop_adl_p_fseen_pos := Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E');

	prop_adl_fseen_p := if(prop_adl_p_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, prop_adl_p_fseen_pos, ','));

	_prop_adl_fseen_p := common.sas_date((string)(prop_adl_fseen_p));

	_src_prop_adl_fseen := _prop_adl_fseen_p;

	iv_pl001_m_snc_prop_adl_fs := map(
			not(truedid)               => NULL,
			_src_prop_adl_fseen = NULL => -1,
																		if ((sysdate - _src_prop_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_prop_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_prop_adl_fseen) / (365.25 / 12))));

	iv_in001_estimated_income := if(not(truedid), NULL, estimated_income);

	iv_inp_addr_address_score := if(not(add1_pop and truedid), NULL, add1_address_score);

	iv_prop_sold_assessed_total := if(not(truedid or add1_pop), NULL, property_sold_assessed_total);

	iv_addrs_10yr := map(
			not(truedid)          => NULL,
			unique_addr_count = 0 => -1,
															 addrs_10yr);

	iv_inq_auto_count12 := if(not(truedid), NULL, inq_auto_count12);

	iv_inq_highriskcredit_recency := map(
			not(truedid)               => NULL,
			inq_highRiskCredit_count01 >0 => 1,
			inq_highRiskCredit_count03 >0 => 3,
			inq_highRiskCredit_count06 >0 => 6,
			inq_highRiskCredit_count12 >0 => 12,
			inq_highRiskCredit_count24 >0 => 24,
			inq_highRiskCredit_count >0   => 99,
																		0);

	iv_paw_dead_bus_x_active_phn := if(not(truedid), '   ', trim((string) min(if(paw_dead_business_count = NULL, -NULL, paw_dead_business_count), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string) min(if(paw_active_phone_count = NULL, -NULL, paw_active_phone_count), 3), LEFT, RIGHT));

	ver_phn_inf := (infutor_nap in [4, 6, 7, 9, 10, 11, 12]);

	ver_phn_nap := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

	inf_phn_ver_lvl := map(
			ver_phn_inf     => 3,
			infutor_nap = 1 => 1,
			infutor_nap = 0 => 0,
												 2);

	nap_phn_ver_lvl := map(
			ver_phn_nap     => 3,
			nap_summary = 1 => 1,
			nap_summary = 0 => 0,
												 2);

	iv_nap_phn_ver_x_inf_phn_ver := map(
			not(addrpop or hphnpop) => '   ',
			not(hphnpop)            => ' -1',
																 trim((string) nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string) inf_phn_ver_lvl, LEFT, RIGHT));

	_reported_dob := common.sas_date((string)(reported_dob));

	reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

	_combined_age := map(
			age > 0           					=> age,
			(integer) input_dob_age > 0 => (integer) input_dob_age,
			inferred_age > 0  		 			=> inferred_age,
			reported_age > 0  		 			=> reported_age,
			(integer) ams_age > 0 			=> (integer) ams_age,
													 -1);

	evidence_of_college := not(ams_college_code = '') or not(ams_college_type = '');
	
	clg(boolean iscollege, integer age) := if(iscollege, 'Y','N') + (string)((integer)(min(age, 60) / 10) * 10);

	iv_college_attendance_x_age := map(
			not(truedid or dobpop) => '',
			_combined_age = -1     => '',
		clg(evidence_of_college, _combined_age) );
		
	iv_prof_license_category := map(
			not(truedid)                 => '  ',
			prof_license_category = '' 	 => '-1',
			prof_license_category);

	iv_vp091_phnzip_mismatch := map(
			not(hphnpop and not(out_z5 = ''))          => ' ',
			rc_phonezipflag = '1' or rc_pwphonezipflag = '1' => '1',
			rc_phonezipflag = '0' or rc_pwphonezipflag = '0' => '0',
																											' ');

	iv_pb_average_dollars := map(
			not(truedid)              => NULL,
			pb_average_dollars = ''	  => -1,
			(integer) pb_average_dollars);

	cs_pct_addrs_le_12mo := map(
			not(truedid)                 => NULL,
			addr_lres_12mo_count = -9999 => -1,
			addr_lres_12mo_count / unique_addr_count * 100);

	_gong_did_last_seen := common.sas_date((string)(gong_did_last_seen));

	_gong_did_first_seen := common.sas_date((string)(gong_did_first_seen));

	cs_gong_duration := map(
			not(truedid)                                                         => NULL,
			not(_gong_did_last_seen = NULL) and not(_gong_did_first_seen = NULL) => if ((_gong_did_last_seen - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((_gong_did_last_seen - _gong_did_first_seen) / (365.25 / 12)), roundup((_gong_did_last_seen - _gong_did_first_seen) / (365.25 / 12))),
																																							-1);

	bureau_adl_vo_fseen_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E');

	bureau_adl_fseen_vo := if(bureau_adl_vo_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_vo_fseen_pos, ','));

	_bureau_adl_fseen_vo := common.sas_date((string)(bureau_adl_fseen_vo));

	_src_bureau_adl_fseen := _bureau_adl_fseen_vo;

	mth_ver_src_fdate_vo := map(
			not(truedid)                 => NULL,
			_src_bureau_adl_fseen = NULL => -1,
			_src_bureau_adl_fseen <= 0 	 => 0,
																			if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))));

	bureau_adl_vo_lseen_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E');

	bureau_adl_lseen_vo := if(bureau_adl_vo_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_vo_lseen_pos, ','));

	_bureau_adl_lseen_vo := common.sas_date((string)(bureau_adl_lseen_vo));

	_src_bureau_adl_lseen_2 := _bureau_adl_lseen_vo;

	mth_ver_src_ldate_vo := map(
			not(truedid)                   => NULL,
			_src_bureau_adl_lseen_2 = NULL => -1,
																				if ((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12))));

	mth_ver_src_fdate_vo60 := mth_ver_src_fdate_vo > 60;

	mth_ver_src_ldate_vo0 := mth_ver_src_ldate_vo = 0;

	bureau_adl_w_lseen_pos := Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E');

	bureau_adl_lseen_w := if(bureau_adl_w_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_w_lseen_pos, ','));

	_bureau_adl_lseen_w := common.sas_date((string)(bureau_adl_lseen_w));

	_src_bureau_adl_lseen_1 := _bureau_adl_lseen_w;

	mth_ver_src_ldate_w := map(
			not(truedid)                   => NULL,
			_src_bureau_adl_lseen_1 = NULL => -1,
																				if ((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12))));

	mth_ver_src_ldate_w0 := mth_ver_src_ldate_w = 0;

	bureau_adl_wp_lseen_pos := Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E');

	bureau_adl_lseen_wp := if(bureau_adl_wp_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_wp_lseen_pos, ','));

	_bureau_adl_lseen_wp := common.sas_date((string)(bureau_adl_lseen_wp));

	_src_bureau_adl_lseen := _bureau_adl_lseen_wp;

	mth_ver_src_ldate_wp := map(
			not(truedid)                 => NULL,
			_src_bureau_adl_lseen = NULL => -1,
																			if ((sysdate - _src_bureau_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen) / (365.25 / 12))));

	mth_ver_src_ldate_wp0 := mth_ver_src_ldate_wp = 0;

	_paw_first_seen := common.sas_date((string)(PAW_first_seen));

	mth_paw_first_seen := map(
			not(truedid)           => NULL,
			_paw_first_seen = NULL => -1,
																if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen) / (365.25 / 12)), roundup((sysdate - _paw_first_seen) / (365.25 / 12))));

	mth_paw_first_seen2 := if(mth_paw_first_seen = NULL or mth_paw_first_seen < 6, 6, min(360, if(mth_paw_first_seen = NULL, -NULL, mth_paw_first_seen)));

	ver_src_am := Models.Common.findw_cpp(ver_sources, 'AM' , ', ', 'E') > 0;

	ver_src_e1 := Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E') > 0;

	ver_src_e2 := Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E') > 0;

	ver_src_e3 := Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E') > 0;

	ver_src_pl := Models.Common.findw_cpp(ver_sources, 'PL' , ', ', 'E') > 0;

	ver_src_w := Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E') > 0;

	paw_dead_business_count_gt3 := paw_dead_business_count > 3;

	paw_active_phone_count_0 := paw_active_phone_count <= 0;

	_infutor_first_seen := common.sas_date((string)(infutor_first_seen));

	mth_infutor_first_seen := map(
			not(truedid)               => NULL,
			_infutor_first_seen = NULL => NULL,
																		if ((sysdate - _infutor_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_first_seen) / (365.25 / 12)), roundup((sysdate - _infutor_first_seen) / (365.25 / 12))));

	_infutor_last_seen := common.sas_date((string)(infutor_last_seen));

	mth_infutor_last_seen := map(
			not(truedid)              => NULL,
			_infutor_last_seen = NULL => NULL,
																	 if ((sysdate - _infutor_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_last_seen) / (365.25 / 12)), roundup((sysdate - _infutor_last_seen) / (365.25 / 12))));

	infutor_i := map(
			infutor_nap = 12 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 1,
			infutor_nap = 12                                                                 => 4,
			infutor_nap = 11 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 3,
			infutor_nap = 11                                                                 => 5,
			infutor_nap >= 7 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 6,
			infutor_nap >= 7                                                                 => 7,
			(infutor_nap in [1, 6])                                                          => 8,
			(infutor_nap in [0])                                                             => 2,
																																													7);

	infutor_im := map(
			infutor_i = 1 => 7.77,
			infutor_i = 2 => 8.06,
			infutor_i = 3 => 8.38,
			infutor_i = 4 => 8.96,
			infutor_i = 5 => 9.35,
			infutor_i = 6 => 10.19,
			infutor_i = 7 => 13.13,
			infutor_i = 8 => 14.77,
											 9.03);

	white_pages_adl_wp_fseen_pos := Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E');

	white_pages_adl_fseen_wp := if(white_pages_adl_wp_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, white_pages_adl_wp_fseen_pos, ','));

	_white_pages_adl_fseen_wp := common.sas_date((string)(white_pages_adl_fseen_wp));

	_src_white_pages_adl_fseen := _white_pages_adl_fseen_wp;

	iv_sr001_m_wp_adl_fs := map(
			not(truedid)                      => NULL,
			_src_white_pages_adl_fseen = NULL => -1,
																					 if ((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12))));

	src_m_wp_adl_fs := map(
			iv_sr001_m_wp_adl_fs = NULL => -1,
			iv_sr001_m_wp_adl_fs = -1   => 10,
			iv_sr001_m_wp_adl_fs >= 24  => 24,
																		 iv_sr001_m_wp_adl_fs);

	_header_first_seen_1 := common.sas_date((string)(header_first_seen));

	iv_sr001_m_hdr_fs_1 := map(
			not(truedid)                     => NULL,
			not(_header_first_seen_1 = NULL) => if ((sysdate - _header_first_seen_1) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen_1) / (365.25 / 12)), roundup((sysdate - _header_first_seen_1) / (365.25 / 12))),
																					-1);

	src_m_hdr_fs := map(
			iv_sr001_m_hdr_fs_1 = NULL => 15,
			iv_sr001_m_hdr_fs_1 = -1   => 40,
			iv_sr001_m_hdr_fs_1 >= 260 => 260,
																		iv_sr001_m_hdr_fs_1);

	source_mod6_1 := -2.350792319 +
			(integer)ver_src_am * -0.611853123 +
			(integer)ver_src_e1 * -0.208450798 +
			(integer)ver_src_e2 * -0.23159296 +
			(integer)ver_src_e3 * -0.415443106 +
			(integer)ver_src_pl * -0.275168358 +
			(integer)mth_ver_src_fdate_vo60 * -0.119660071 +
			(integer)mth_ver_src_ldate_vo0 * -0.322346162 +
			(integer)ver_src_w * -0.232332713 +
			(integer)mth_ver_src_ldate_w0 * -0.371580672 +
			(integer)mth_ver_src_ldate_wp0 * -0.149556634 +
			mth_paw_first_seen2 * -0.002615342 +
			(integer)paw_dead_business_count_gt3 * 1.3423068152 +
			(integer)paw_active_phone_count_0 * 0.3754685927 +
			infutor_im * 0.061827139 +
			src_m_wp_adl_fs * -0.006650973 +
			src_m_hdr_fs * -0.004903484;

	source_mod6 := exp(source_mod6_1) / (1 + exp(source_mod6_1));

	source_temp := round(500 * source_mod6/0.1) * 0.1;
	iv_sr001_source_profile := if(not(truedid), NULL, max((real)0, round((100 - source_temp) * 10) / 10));	
	
	iv_de001_eviction_recency := map(
			not(truedid)                                                => NULL,
			(boolean) attr_eviction_count90                                       => 3,
			(boolean) attr_eviction_count180                                      => 6,
			(boolean) attr_eviction_count12                                       => 12,
			(boolean)attr_eviction_count24 and attr_eviction_count >= 2 => 24,
			(boolean) attr_eviction_count24                                       => 25,
			(boolean)attr_eviction_count36 and attr_eviction_count >= 2 => 36,
			(boolean) attr_eviction_count36                                       => 37,
			(boolean)attr_eviction_count60 and attr_eviction_count >= 2 => 60,
			(boolean) attr_eviction_count60                                       => 61,
			attr_eviction_count >= 2                                    => 98,
			attr_eviction_count >= 1                                    => 99,
																																		 0);

	email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

	iv_ds001_impulse_count := map(
			not(truedid)                        => NULL,
			impulse_count = 0 and email_src_im  => 1,
																								impulse_count);

	iv_in001_wealth_index := if(not(truedid), ' ', (string)wealth_index);

	iv_nap_status := if(not(hphnpop or addrpop), ' ', nap_status);

	iv_prv_addr_assessed_total_val := map(
			not(truedid)     => NULL,
			add1_isbestmatch => add2_assessed_total_value,
													add3_assessed_total_value);

	iv_avg_prop_assess_purch_amt := map(
			not(truedid or add1_pop)          => NULL,
			property_owned_assessed_count > 0 => property_owned_assessed_total / property_owned_assessed_count,
																					 -1);

	iv_credit_seeking := if(not(truedid), NULL, if(max(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)), min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)), min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)), min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)), min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))) = NULL, NULL, sum(if(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)) = NULL, 0, min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03))), if(min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)) = NULL, 0, min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03))), if(min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)) = NULL, 0, min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03))), if(min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)) = NULL, 0, min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03))), if(min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03)) = NULL, 0, min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))))));

	iv_rec_vehx_level := map(
			not(truedid)                                   => '  ',
			attr_num_aircraft > 0 and watercraft_count > 0 => 'AW',
			attr_num_aircraft > 0                          => 'AO',
			watercraft_count > 0                           => trim('W', LEFT, RIGHT) + trim((string) min(if(watercraft_count = NULL, -NULL, watercraft_count), 3), LEFT, RIGHT),
																												'XX');

	iv_attr_rel_liens_recency := map(
			not(truedid)                        => NULL,
			(boolean) attr_num_rel_liens30                => 1,
			(boolean) attr_num_rel_liens90                => 3,
			(boolean) attr_num_rel_liens180               => 6,
			(boolean) attr_num_rel_liens12                => 12,
			(boolean) attr_num_rel_liens24                => 24,
			(boolean) attr_num_rel_liens36                => 36,
			(boolean) attr_num_rel_liens60                => 60,
			liens_historical_released_count > 0 => 99,
																						 0);

	iv_non_derog_count := if(not(truedid), NULL, attr_num_nonderogs);

	iv_criminal_x_felony := if(not(truedid), '   ', trim((string) min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string) min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

	iv_pb_total_orders := map(
			not(truedid)           => NULL,
			pb_total_orders = '' => -1,
			(integer) pb_total_orders);

	cs_outstanding_liens_ct := if(not(truedid), NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) - if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))));

	iv_vp002_phn_disconnected := map(
			not(hphnpop)                                                             => ' ',
			(integer) rc_hriskphoneflag = 5 or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D' => '1',
																																									'0');

	_header_first_seen := common.sas_date((string)(header_first_seen));

	iv_sr001_m_hdr_fs := map(
			not(truedid)                   => NULL,
			not(_header_first_seen = NULL) => if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))),
																				-1);

	iv_bst_addr_mortgage_amount := map(
			not(truedid)     => NULL,
			add1_isbestmatch => add1_mortgage_amount,
													add2_mortgage_amount);

	iv_prv_addr_avm_auto_val := map(
			not(truedid)     => NULL,
			add1_isbestmatch => add2_avm_automated_valuation,
													add3_avm_automated_valuation);

	iv_prop_owned_assessed_total := if(not(truedid or add1_pop), NULL, property_owned_assessed_total);

	iv_paw_active_phone_count := if(not(truedid), NULL, paw_active_phone_count);

	iv_attr_addrs_recency := map(
			not(truedid)      => NULL,
			(boolean) attr_addrs_last30 => 1,
			(boolean) attr_addrs_last90 => 3,
			(boolean) attr_addrs_last12 => 12,
			(boolean) attr_addrs_last24 => 24,
			(boolean) attr_addrs_last36 => 36,
			(boolean) addrs_5yr         => 60,
			(boolean) addrs_10yr        => 120,
			(boolean) addrs_15yr        => 180,
			addrs_per_adl > 0 => 999,
													 0);

	iv_attr_purchase_recency := map(
			not(truedid)                 => NULL,
			(boolean) attr_num_purchase30          => 1,
			(boolean) attr_num_purchase90          => 3,
			(boolean) attr_num_purchase180         => 6,
			(boolean) attr_num_purchase12          => 12,
			(boolean) attr_num_purchase24          => 24,
			(boolean) attr_num_purchase36          => 36,
			(boolean) attr_num_purchase60          => 60,
			attr_date_first_purchase > 0 => 99,
																			0);

	iv_vp003_phn_invalid := map(
			not(hphnpop)                                                    => ' ',
			(integer) rc_phonevalflag = 0 or (integer) rc_hphonevalflag = 0 or (integer) rc_phonetype = 5 => '1',
																																				 '0');

	add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];

	add_ec3 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3];

	add_ec4 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4];

	iv_va100_add_problem := map(
			not(add1_pop)                                                           => '                        ',
			not(out_z5 = '') and rc_statezipflag = '1'                              => '14 Zip/State Mismatch   ',
			add1_advo_address_vacancy = 'Y'                                         => '13 Vacant               ',
			add1_advo_seasonal_delivery = 'E' or add1_advo_college = 'Y'            => '12 College              ',
			add1_advo_throw_back = 'Y'                                              => '11 Throw Back           ',
			not(out_z5 = '') and rc_statezipflag != '1' and rc_cityzipflag = '1'      => '10 Zip/City Mismatch    ',
			not(out_z5 = '') and (rc_hriskaddrflag = '2' or rc_ziptypeflag = '2')     => '09 Corporate Zip Code   ',
			not(out_z5 = '') and (rc_hriskaddrflag = '3' or rc_ziptypeflag = '3')     => '08 Military Zip         ',
			(add1_advo_res_or_business in ['B', 'D'])                               => '07 Busines              ',
			rc_addrvalflag = 'N'                                                    => '06 Invalid Address      ',
			add1_advo_drop = 'Y'                                                    => '05 Drop Delivery        ',
			rc_hriskaddrflag = '4' or rc_addrcommflag = '2'                             => '04 HiRisk Commercial    ',
			add_ec1 = 'E'                                                           => '03 Standarization Error ',
			add_ec1 != 'E' and add_ec1 = 'S' and (add_ec3 != '0' or add_ec4 != '0') => '02 Address Standardized ',
			not((add1_advo_mixed_address_usage in ['A', '']))                       => '01 Not Curbside Delivery',
																																								 '00 No Address Problems  ');

	iv_pv001_bst_avm_autoval := map(
			not(truedid)     => NULL,
			add1_isbestmatch => add1_avm_automated_valuation,
													add2_avm_automated_valuation);

	bureau_addr_tn_fseen_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TN' , ', ', 'E');

	bureau_addr_fseen_tn := if(bureau_addr_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_tn_fseen_pos, ','));

	_bureau_addr_fseen_tn := common.sas_date((string)(bureau_addr_fseen_tn));

	bureau_addr_ts_fseen_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TS' , ', ', 'E');

	bureau_addr_fseen_ts := if(bureau_addr_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_ts_fseen_pos, ','));

	_bureau_addr_fseen_ts := common.sas_date((string)(bureau_addr_fseen_ts));

	bureau_addr_tu_fseen_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TU' , ', ', 'E');

	bureau_addr_fseen_tu := if(bureau_addr_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_tu_fseen_pos, ','));

	_bureau_addr_fseen_tu := common.sas_date((string)(bureau_addr_fseen_tu));

	bureau_addr_en_fseen_pos := Models.Common.findw_cpp(ver_Addr_sources, 'EN' , ', ', 'E');

	bureau_addr_fseen_en := if(bureau_addr_en_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_en_fseen_pos, ','));

	_bureau_addr_fseen_en := common.sas_date((string)(bureau_addr_fseen_en));

	bureau_addr_eq_fseen_pos := Models.Common.findw_cpp(ver_Addr_sources, 'EQ' , ', ', 'E');

	bureau_addr_fseen_eq := if(bureau_addr_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_eq_fseen_pos, ','));

	_bureau_addr_fseen_eq := common.sas_date((string)(bureau_addr_fseen_eq));

	_src_bureau_addr_fseen := if(max(_bureau_addr_fseen_tn, _bureau_addr_fseen_ts, _bureau_addr_fseen_tu, _bureau_addr_fseen_en, _bureau_addr_fseen_eq) = NULL, NULL, min(if(_bureau_addr_fseen_tn = NULL, -NULL, _bureau_addr_fseen_tn), if(_bureau_addr_fseen_ts = NULL, -NULL, _bureau_addr_fseen_ts), if(_bureau_addr_fseen_tu = NULL, -NULL, _bureau_addr_fseen_tu), if(_bureau_addr_fseen_en = NULL, -NULL, _bureau_addr_fseen_en), if(_bureau_addr_fseen_eq = NULL, -NULL, _bureau_addr_fseen_eq)));

	iv_mos_src_bureau_addr_fseen := map(
			not(truedid)                  => NULL,
			_src_bureau_addr_fseen = NULL => -1,
																			 if ((sysdate - _src_bureau_addr_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_addr_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_addr_fseen) / (365.25 / 12))));

	prv_addr_date_last_seen := if(add1_isbestmatch, common.sas_date((string)(add2_date_last_seen)), common.sas_date((string)(add3_date_last_seen)));

	iv_mos_since_prv_addr_lseen := map(
			not(truedid)                   => NULL,
			prv_addr_date_last_seen = NULL => -1,
																				if ((sysdate - prv_addr_date_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - prv_addr_date_last_seen) / (365.25 / 12)), roundup((sysdate - prv_addr_date_last_seen) / (365.25 / 12))));

	cs_bst_to_avg_lres_ratio := map(
			not(truedid)            => NULL,
			avg_mo_per_addr = -9999 => -1,
			unique_addr_count < 2   => -1,
			add1_isbestmatch        => add1_lres / avg_mo_per_addr,
																 add2_lres / avg_mo_per_addr);

	new_derog_a_subscore0 := map(
			NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => 37.798390,
			1 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 3   => -82.437613,
			3 <= iv_inq_highriskcredit_recency                                         => 7.732654,
																																										-0.000000);

	new_derog_a_subscore1 := map(
			NULL < iv_in001_estimated_income AND iv_in001_estimated_income < 30000   => -30.017130,
			30000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 35000 => -15.266106,
			35000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 40000 => 14.850046,
			40000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 77000 => 32.204983,
			77000 <= iv_in001_estimated_income                                       => 92.422125,
																																									-0.000000);

	new_derog_a_subscore2 := map(
			(iv_criminal_x_felony in [' '])                        => 0.000000,
			(iv_criminal_x_felony in ['0-0'])                      => 5.640182,
			(iv_criminal_x_felony in ['1-0', '2-0'])               => -115.621972,
			(iv_criminal_x_felony in ['1-1', '2-1', '3-0', '3-1']) => -224.914320,
			(iv_criminal_x_felony in ['2-2', '3-2', '3-3'])        => -267.994399,
																																0.000000);

	new_derog_a_subscore3 := map(
			NULL < iv_addrs_10yr AND iv_addrs_10yr < 3 => 36.148105,
			3 <= iv_addrs_10yr AND iv_addrs_10yr < 4   => 26.483609,
			4 <= iv_addrs_10yr AND iv_addrs_10yr < 7   => -11.688948,
			7 <= iv_addrs_10yr                         => -48.836650,
																										0.000000);

	new_derog_a_subscore4 := map(
			NULL < iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs < 0   => -29.121772,
			0 <= iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs < 113   => 2.725835,
			113 <= iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs < 181 => 30.043412,
			181 <= iv_pl001_m_snc_prop_adl_fs                                      => 41.805854,
																																								0.000000);

	new_derog_a_subscore5 := map(
			iv_prof_license_category = '' => 0.000000,
			NULL < (integer) iv_prof_license_category AND (integer)iv_prof_license_category < 2 => -7.434640,
			2 <= (integer)iv_prof_license_category AND (integer)iv_prof_license_category < 4   => 36.931249,
			4 <= (integer)iv_prof_license_category                                    => 123.809057,
																																					0.000000);

	new_derog_a_subscore6 := map(
			NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 11.183609,
			2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -4.824953,
			3 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 5   => -32.655034,
			5 <= iv_ms001_ssns_per_adl                                 => -210.008495,
																																		0.000000);

	new_derog_a_subscore7 := map(
			NULL < cs_outstanding_liens_ct AND cs_outstanding_liens_ct < 1 => 22.561434,
			1 <= cs_outstanding_liens_ct AND cs_outstanding_liens_ct < 3   => -6.444232,
			3 <= cs_outstanding_liens_ct AND cs_outstanding_liens_ct < 5   => -20.628839,
			5 <= cs_outstanding_liens_ct AND cs_outstanding_liens_ct < 7   => -66.490269,
			7 <= cs_outstanding_liens_ct                                   => -76.640924,
																																				0.000000);

	new_derog_a_subscore8 := map(
			NULL < iv_inp_addr_address_score AND iv_inp_addr_address_score < 50  => -83.120552,
			50 <= iv_inp_addr_address_score AND iv_inp_addr_address_score < 100  => -31.748748,
			100 <= iv_inp_addr_address_score AND iv_inp_addr_address_score < 255 => 7.732148,
			255 <= iv_inp_addr_address_score                                     => 0.000000,
																																							0.000000);

	new_derog_a_subscore9 := map(
			NULL < iv_attr_rel_liens_recency AND iv_attr_rel_liens_recency < 1 => -12.799969,
			1 <= iv_attr_rel_liens_recency AND iv_attr_rel_liens_recency < 12  => 57.809893,
			12 <= iv_attr_rel_liens_recency AND iv_attr_rel_liens_recency < 36 => 36.303691,
			36 <= iv_attr_rel_liens_recency AND iv_attr_rel_liens_recency < 99 => 31.108830,
			99 <= iv_attr_rel_liens_recency                                    => 12.929225,
																																						0.000000);

	new_derog_a_subscore10 := map(
			NULL < iv_sr001_source_profile AND iv_sr001_source_profile < 66.5  => -26.612465,
			66.5 <= iv_sr001_source_profile AND iv_sr001_source_profile < 76.2 => -0.059770,
			76.2 <= iv_sr001_source_profile AND iv_sr001_source_profile < 82.5 => 13.972004,
			82.5 <= iv_sr001_source_profile                                    => 33.838102,
																																						0.000000);

	new_derog_a_subscore11 := map(
			(iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                             => 38.186640,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '1-3', '2-3', '3-1', '3-3']) => 5.560415,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0', '1-1', '2-0', '2-1']) => -1.281697,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-0'])                             => -29.969724,
																																							 0.000000);

	new_derog_a_subscore12 := map(
			NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => -26.085395,
			1 <= iv_pb_total_orders AND iv_pb_total_orders < 3   => -3.616341,
			3 <= iv_pb_total_orders                              => 18.541109,
																															0.000000);

	new_derog_a_subscore13 := map(
			NULL < iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 13  => -0.000000,
			13 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 175  => -39.885411,
			175 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 241 => -13.812993,
			241 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 302 => 1.030784,
			302 <= iv_sr001_m_bureau_adl_fs                                    => 16.838583,
																																						-0.000000);

	new_derog_a_subscore14 := map(
			NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt < 1200     => -3.023056,
			1200 <= iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt < 87070   => -25.495509,
			87070 <= iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt < 202450 => 7.882889,
			202450 <= iv_avg_prop_assess_purch_amt                                          => 63.799037,
																																												 0.000000);

	new_derog_a_subscore15 := map(
			NULL < iv_inq_auto_count12 AND iv_inq_auto_count12 < 3 => 4.844351,
			3 <= iv_inq_auto_count12 AND iv_inq_auto_count12 < 5   => -36.799674,
			5 <= iv_inq_auto_count12                               => -64.857632,
																																0.000000);

	new_derog_a_subscore16 := map(
			NULL < iv_credit_seeking AND iv_credit_seeking < 1 => 5.436700,
			1 <= iv_credit_seeking                             => -44.462335,
																														0.000000);

	new_derog_a_subscore17 := map(
			NULL < iv_non_derog_count AND iv_non_derog_count < 2 => -38.920007,
			2 <= iv_non_derog_count AND iv_non_derog_count < 3   => -17.953163,
			3 <= iv_non_derog_count AND iv_non_derog_count < 4   => 5.475135,
			4 <= iv_non_derog_count                              => 11.700290,
																															-0.000000);

	new_derog_a_subscore18 := map(
			NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 7.466002,
			1 <= iv_ds001_impulse_count                                  => -30.259625,
																																			-0.000000);

	new_derog_a_subscore19 := map(
			(iv_paw_dead_bus_x_active_phn in [' '])                                                                                => -0.000000,
			(iv_paw_dead_bus_x_active_phn in ['1-0', '2-0', '3-0'])                                                                => -61.990766,
			(iv_paw_dead_bus_x_active_phn in ['0-0'])                                                                              => 1.233063,
			(iv_paw_dead_bus_x_active_phn in ['0-1', '0-2', '0-3', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3']) => 25.948636,
																																																																-0.000000);

	new_derog_a_subscore20 := map(
			NULL < iv_prop_sold_assessed_total AND iv_prop_sold_assessed_total < 164070 => -2.563000,
			164070 <= iv_prop_sold_assessed_total                                       => 64.751957,
																																										 0.000000);

	new_derog_a_subscore21 := map(
			NULL < iv_prv_addr_assessed_total_val AND iv_prv_addr_assessed_total_val < 144587 => -5.025877,
			144587 <= iv_prv_addr_assessed_total_val                                          => 28.244389,
																																													 -0.000000);

	new_derog_a_subscore22 := map(
			iv_in001_wealth_index = '' => -0.000000,
			NULL < (integer) iv_in001_wealth_index AND (integer) iv_in001_wealth_index < 1 => 6.564656,
			1 <= (integer) iv_in001_wealth_index AND (integer) iv_in001_wealth_index < 3   => -23.910048,
			3 <= (integer) iv_in001_wealth_index AND (integer) iv_in001_wealth_index < 6   => -1.869794,
			6 <= (integer) iv_in001_wealth_index                                 => 68.610474,
																																		-0.000000);

	new_derog_a_subscore23 := map(
			NULL < cs_pct_addrs_le_12mo AND cs_pct_addrs_le_12mo < 0    => 0.000000,
			0 <= cs_pct_addrs_le_12mo AND cs_pct_addrs_le_12mo < 31.25  => 4.532598,
			31.25 <= cs_pct_addrs_le_12mo AND cs_pct_addrs_le_12mo < 50 => -1.495821,
			50 <= cs_pct_addrs_le_12mo AND cs_pct_addrs_le_12mo < 64.7  => -13.280012,
			64.7 <= cs_pct_addrs_le_12mo                                => -41.407701,
																																		 0.000000);

	new_derog_a_subscore24 := map(
			(iv_nap_status in [' ']) => 0.000000,
			(iv_nap_status in ['C']) => 1.677250,
			(iv_nap_status in ['D']) => -55.269394,
																	0.000000);

	new_derog_a_subscore25 := map(
			(iv_college_attendance_x_age in ['N20', 'N30', 'N40', 'N50', 'N60']) => -2.033063,
			(iv_college_attendance_x_age in ['Y20', 'Y30', 'Y40', 'Y50', 'Y60']) => 21.550723,
																																							0.000000);

	new_derog_a_subscore26 := map(
			NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 110766    => -5.236971,
			110766 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 190419 => 7.799774,
			190419 <= iv_pv001_inp_avm_autoval                                       => 8.470360,
																																									0.000000);

	new_derog_a_subscore27 := map(
			NULL < iv_de001_eviction_recency AND iv_de001_eviction_recency < 3 => 2.183982,
			3 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 12  => -18.721882,
			12 <= iv_de001_eviction_recency                                    => -10.352623,
																																						-0.000000);

	new_derog_a_subscore28 := map(
			(iv_rec_vehx_level in [' '])                    => -0.000000,
			(iv_rec_vehx_level in ['AO', 'W1', 'W2', 'W3']) => 37.901222,
			(iv_rec_vehx_level in ['XX'])                   => -0.604664,
																												 -0.000000);

	new_derog_a_scaledscore := new_derog_a_subscore0 +
			new_derog_a_subscore1 +
			new_derog_a_subscore2 +
			new_derog_a_subscore3 +
			new_derog_a_subscore4 +
			new_derog_a_subscore5 +
			new_derog_a_subscore6 +
			new_derog_a_subscore7 +
			new_derog_a_subscore8 +
			new_derog_a_subscore9 +
			new_derog_a_subscore10 +
			new_derog_a_subscore11 +
			new_derog_a_subscore12 +
			new_derog_a_subscore13 +
			new_derog_a_subscore14 +
			new_derog_a_subscore15 +
			new_derog_a_subscore16 +
			new_derog_a_subscore17 +
			new_derog_a_subscore18 +
			new_derog_a_subscore19 +
			new_derog_a_subscore20 +
			new_derog_a_subscore21 +
			new_derog_a_subscore22 +
			new_derog_a_subscore23 +
			new_derog_a_subscore24 +
			new_derog_a_subscore25 +
			new_derog_a_subscore26 +
			new_derog_a_subscore27 +
			new_derog_a_subscore28;

	new_owner_a_subscore0 := map(
			NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => 28.951795,
			1 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 3   => -70.701060,
			3 <= iv_inq_highriskcredit_recency                                         => 27.089480,
																																										0.000000);

	new_owner_a_subscore1 := map(
			NULL < iv_pb_average_dollars AND iv_pb_average_dollars < 0 => -58.454998,
			0 <= iv_pb_average_dollars AND iv_pb_average_dollars < 27  => -45.100028,
			27 <= iv_pb_average_dollars AND iv_pb_average_dollars < 56 => -2.802924,
			56 <= iv_pb_average_dollars                                => 47.579441,
																																		0.000000);

	new_owner_a_subscore2 := map(
			(iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                                     => 0.000000,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1', '2-0', '2-1']) => -37.910635,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '1-3', '2-3', '3-1', '3-3'])        => 13.955373,
			(iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                    => 73.030684,
																																											0.000000);

	new_owner_a_subscore3 := map(
			NULL < iv_inp_addr_address_score AND iv_inp_addr_address_score < 50  => -173.238553,
			50 <= iv_inp_addr_address_score AND iv_inp_addr_address_score < 100  => -88.596641,
			100 <= iv_inp_addr_address_score AND iv_inp_addr_address_score < 255 => 7.800891,
			255 <= iv_inp_addr_address_score                                     => 0.000000,
																																							0.000000);

	new_owner_a_subscore4 := map(
			NULL < iv_attr_addrs_recency AND iv_attr_addrs_recency < 3 => -73.653484,
			3 <= iv_attr_addrs_recency AND iv_attr_addrs_recency < 12  => -38.549408,
			12 <= iv_attr_addrs_recency AND iv_attr_addrs_recency < 60 => -12.334718,
			60 <= iv_attr_addrs_recency                                => 35.944419,
																																		0.000000);

	new_owner_a_subscore5 := map(
			NULL < iv_attr_purchase_recency AND iv_attr_purchase_recency < 1 => -7.067060,
			1 <= iv_attr_purchase_recency AND iv_attr_purchase_recency < 24  => -77.531901,
			24 <= iv_attr_purchase_recency AND iv_attr_purchase_recency < 60 => -56.808905,
			60 <= iv_attr_purchase_recency                                   => 11.647032,
																																					-0.000000);

	new_owner_a_subscore6 := map(
			iv_prof_license_category = '' => 0.000000,
			NULL < (integer) iv_prof_license_category AND (integer) iv_prof_license_category < 2 => -7.781836,
			2 <= (integer) iv_prof_license_category AND (integer) iv_prof_license_category < 4   => 57.915680,
			4 <= (integer) iv_prof_license_category                                    => 83.362178,
																																					0.000000);

	new_owner_a_subscore7 := map(
			NULL < cs_gong_duration AND cs_gong_duration < 0  => -2.328822,
			0 <= cs_gong_duration AND cs_gong_duration < 51   => -33.090823,
			51 <= cs_gong_duration AND cs_gong_duration < 104 => 13.955179,
			104 <= cs_gong_duration                           => 47.470454,
																													 0.000000);

	new_owner_a_subscore8 := map(
			NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 6471      => -0.919828,
			6471 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 112649   => -32.757124,
			112649 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 185688 => -4.126528,
			185688 <= iv_pv001_inp_avm_autoval                                       => 32.205386,
																																									0.000000);

	new_owner_a_subscore9 := map(
			NULL < iv_bst_addr_mortgage_amount AND iv_bst_addr_mortgage_amount < 848       => -4.108251,
			848 <= iv_bst_addr_mortgage_amount AND iv_bst_addr_mortgage_amount < 112917    => -32.926941,
			112917 <= iv_bst_addr_mortgage_amount AND iv_bst_addr_mortgage_amount < 265000 => 17.300348,
			265000 <= iv_bst_addr_mortgage_amount                                          => 51.503163,
																																												0.000000);

	new_owner_a_subscore10 := map(
			(iv_paw_dead_bus_x_active_phn in [' '])                                                                  => -0.000000,
			(iv_paw_dead_bus_x_active_phn in ['1-0', '2-0', '3-0'])                                                  => -101.939369,
			(iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-1', '1-2', '1-3', '2-1', '2-3', '3-1']) => 4.586664,
																																																									-0.000000);

	new_owner_a_subscore11 := map(
			iv_vp091_phnzip_mismatch = '' => 0.000000,
			NULL < (integer) iv_vp091_phnzip_mismatch AND (integer) iv_vp091_phnzip_mismatch < 1 => 3.601085,
			1 <= (integer) iv_vp091_phnzip_mismatch                                    => -117.216183,
																																					0.000000);

	new_owner_a_subscore12 := map(
			NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total < 102650    => -16.348867,
			102650 <= iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total < 178943 => 21.570242,
			178943 <= iv_prop_owned_assessed_total                                           => 25.743158,
																																													-0.000000);

	new_owner_a_subscore13 := map(
			NULL < iv_inq_auto_count12 AND iv_inq_auto_count12 < 3 => 4.048270,
			3 <= iv_inq_auto_count12                               => -80.711622,
																																0.000000);

	new_owner_a_subscore14 := map(
			NULL < iv_in001_estimated_income AND iv_in001_estimated_income < 19999   => -0.000000,
			19999 <= iv_in001_estimated_income AND iv_in001_estimated_income < 29000 => -43.110407,
			29000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 36000 => -10.221498,
			36000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 44000 => 4.699141,
			44000 <= iv_in001_estimated_income                                       => 16.646809,
																																									-0.000000);

	new_owner_a_subscore15 := map(
			NULL < iv_sr001_source_profile AND iv_sr001_source_profile < 45.3  => -87.590776,
			45.3 <= iv_sr001_source_profile AND iv_sr001_source_profile < 57.2 => -34.729970,
			57.2 <= iv_sr001_source_profile AND iv_sr001_source_profile < 68.5 => -11.609820,
			68.5 <= iv_sr001_source_profile AND iv_sr001_source_profile < 77.9 => 4.162218,
			77.9 <= iv_sr001_source_profile                                    => 9.533694,
																																						-0.000000);

	new_owner_a_subscore16 := map(
			NULL < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 127 => -77.465786,
			127 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 250 => -18.438449,
			250 <= iv_sr001_m_hdr_fs                             => 8.819299,
																															-0.000000);

	new_owner_a_subscore17 := map(
			NULL < iv_paw_active_phone_count AND iv_paw_active_phone_count < 2 => -1.912678,
			2 <= iv_paw_active_phone_count                                     => 93.912492,
																																						0.000000);

	new_owner_a_subscore18 := map(
			(iv_college_attendance_x_age in ['N10', 'N20', 'N30', 'N40', 'N50', 'N60']) => -4.497316,
			(iv_college_attendance_x_age in ['Y20', 'Y30', 'Y40', 'Y50', 'Y60'])        => 35.652387,
																																										 0.000000);

	new_owner_a_subscore19 := map(
			NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 3453     => -4.002642,
			3453 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 86900   => -16.517998,
			86900 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 163377 => 4.724342,
			163377 <= iv_prv_addr_avm_auto_val                                      => 24.288786,
																																								 0.000000);

	new_owner_a_subscore20 := map(
			NULL < cs_pct_addrs_le_12mo AND cs_pct_addrs_le_12mo < 0   => 0.000000,
			0 <= cs_pct_addrs_le_12mo AND cs_pct_addrs_le_12mo < 53.84 => 2.522750,
			53.84 <= cs_pct_addrs_le_12mo                              => -46.019401,
																																		0.000000);

	new_owner_a_subscore21 := map(
			iv_vp002_phn_disconnected = '' => 0.000000,
			NULL < (integer) iv_vp002_phn_disconnected AND (integer) iv_vp002_phn_disconnected < 1 => 0.792630,
			1 <= (integer) iv_vp002_phn_disconnected                                     => -48.420586,
																																						0.000000);

	new_owner_a_scaledscore := new_owner_a_subscore0 +
			new_owner_a_subscore1 +
			new_owner_a_subscore2 +
			new_owner_a_subscore3 +
			new_owner_a_subscore4 +
			new_owner_a_subscore5 +
			new_owner_a_subscore6 +
			new_owner_a_subscore7 +
			new_owner_a_subscore8 +
			new_owner_a_subscore9 +
			new_owner_a_subscore10 +
			new_owner_a_subscore11 +
			new_owner_a_subscore12 +
			new_owner_a_subscore13 +
			new_owner_a_subscore14 +
			new_owner_a_subscore15 +
			new_owner_a_subscore16 +
			new_owner_a_subscore17 +
			new_owner_a_subscore18 +
			new_owner_a_subscore19 +
			new_owner_a_subscore20 +
			new_owner_a_subscore21;

	new_other_a_subscore0 := map(
			NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => 46.731441,
			1 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 3   => -94.603300,
			3 <= iv_inq_highriskcredit_recency                                         => -1.670563,
																																										0.000000);

	new_other_a_subscore1 := map(
			NULL < iv_in001_estimated_income AND iv_in001_estimated_income < 31000   => -24.644868,
			31000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 34000 => -16.264070,
			34000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 43000 => 14.681833,
			43000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 64000 => 37.569759,
			64000 <= iv_in001_estimated_income                                       => 95.619913,
																																									0.000000);

	new_other_a_subscore2 := map(
			NULL < iv_pb_average_dollars AND iv_pb_average_dollars < 0 => -24.347481,
			0 <= iv_pb_average_dollars AND iv_pb_average_dollars < 64  => -21.896456,
			64 <= iv_pb_average_dollars                                => 49.457808,
																																		-0.000000);

	new_other_a_subscore3 := map(
			NULL < iv_inq_auto_count12 AND iv_inq_auto_count12 < 1 => 10.384453,
			1 <= iv_inq_auto_count12 AND iv_inq_auto_count12 < 4   => -24.758500,
			4 <= iv_inq_auto_count12 AND iv_inq_auto_count12 < 8   => -100.846868,
			8 <= iv_inq_auto_count12                               => -265.615635,
																																0.000000);

	new_other_a_subscore4 := map(
			NULL < iv_mos_src_bureau_addr_fseen AND iv_mos_src_bureau_addr_fseen < 0 => -71.034195,
			0 <= iv_mos_src_bureau_addr_fseen                                        => 10.323525,
																																									0.000000);

	new_other_a_subscore5 := map(
			NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 12.672966,
			2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -29.888442,
			3 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 4   => -35.344386,
			4 <= iv_ms001_ssns_per_adl                                 => -158.443473,
																																		0.000000);

	new_other_a_subscore6 := map(
			iv_prof_license_category = '' => 0.000000,
			NULL < (integer) iv_prof_license_category AND (integer) iv_prof_license_category < 2 => -6.684437,
			2 <= (integer) iv_prof_license_category                                    => 108.696047,
																																					0.000000);

	new_other_a_subscore7 := map(
			NULL < cs_gong_duration AND cs_gong_duration < 0 => -16.682927,
			0 <= cs_gong_duration AND cs_gong_duration < 8   => -47.542121,
			8 <= cs_gong_duration AND cs_gong_duration < 56  => -2.909430,
			56 <= cs_gong_duration                           => 38.649296,
																													0.000000);

	new_other_a_subscore8 := map(
			NULL < iv_addrs_10yr AND iv_addrs_10yr < 0 => -131.851832,
			0 <= iv_addrs_10yr AND iv_addrs_10yr < 1   => -40.442498,
			1 <= iv_addrs_10yr AND iv_addrs_10yr < 5   => 17.818194,
			5 <= iv_addrs_10yr AND iv_addrs_10yr < 9   => -24.841589,
			9 <= iv_addrs_10yr                         => -48.264706,
																										-0.000000);

	new_other_a_subscore9 := map(
			NULL < iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs < 1 => -9.033343,
			1 <= iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs < 173 => 5.855144,
			173 <= iv_pl001_m_snc_prop_adl_fs                                    => 78.799644,
																																							-0.000000);

	new_other_a_subscore10 := map(
			NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 3192      => 5.081516,
			3192 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 118481   => -44.060638,
			118481 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 262636 => -0.329656,
			262636 <= iv_pv001_bst_avm_autoval                                       => 46.271497,
																																									0.000000);

	new_other_a_subscore11 := map(
			NULL < iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 117 => -69.824485,
			117 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 207 => -20.281734,
			207 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 296 => 0.800518,
			296 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 347 => 13.741007,
			347 <= iv_sr001_m_bureau_adl_fs                                    => 42.891273,
																																						0.000000);

	new_other_a_subscore12 := map(
			NULL < iv_mos_since_prv_addr_lseen AND iv_mos_since_prv_addr_lseen < 0 => -74.871527,
			0 <= iv_mos_since_prv_addr_lseen AND iv_mos_since_prv_addr_lseen < 8   => -6.983048,
			8 <= iv_mos_since_prv_addr_lseen AND iv_mos_since_prv_addr_lseen < 171 => 3.741763,
			171 <= iv_mos_since_prv_addr_lseen                                     => 124.601040,
																																								-0.000000);

	new_other_a_subscore13 := map(
			NULL < cs_bst_to_avg_lres_ratio AND cs_bst_to_avg_lres_ratio < 0.11  => -38.469302,
			0.11 <= cs_bst_to_avg_lres_ratio AND cs_bst_to_avg_lres_ratio < 0.89 => 4.574318,
			0.89 <= cs_bst_to_avg_lres_ratio                                     => 13.823078,
																																							0.000000);

	new_other_a_subscore14 := map(
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-0'])                                                                => -29.004776,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0', '1-1', '1-3', '2-0', '2-1', '2-3', '3-0', '3-1', '3-3']) => -1.887370,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-3'])                                                                => 31.262306,
																																																									0.000000);

	new_other_a_subscore15 := map(
			NULL < iv_prop_sold_assessed_total AND iv_prop_sold_assessed_total < 169400 => -2.880994,
			169400 <= iv_prop_sold_assessed_total                                       => 131.033784,
																																										 0.000000);

	new_other_a_subscore16 := map(
			(iv_paw_dead_bus_x_active_phn in [' '])                                                                                => -0.000000,
			(iv_paw_dead_bus_x_active_phn in ['0-0', '1-0', '1-1', '1-2', '1-3', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => -3.578852,
			(iv_paw_dead_bus_x_active_phn in ['0-1', '0-2', '0-3'])                                                                => 89.185942,
																																																																-0.000000);

	new_other_a_subscore17 := map(
			(iv_college_attendance_x_age in ['N10', 'N20', 'N30', 'N40', 'N50', 'N60']) => -5.439020,
			(iv_college_attendance_x_age in ['Y20', 'Y30', 'Y40', 'Y50', 'Y60'])        => 46.294608,
																																										 -0.000000);

	new_other_a_subscore18 := map(
			iv_vp003_phn_invalid = '' => 0.000000,
			NULL < (integer) iv_vp003_phn_invalid AND (integer) iv_vp003_phn_invalid < 1 => 1.057267,
			1 <= (integer) iv_vp003_phn_invalid                                => -210.640119,
																																	0.000000);

	new_other_a_subscore19 := map(
			iv_vp091_phnzip_mismatch = '' => -0.000000,
			NULL < (integer) iv_vp091_phnzip_mismatch AND (integer) iv_vp091_phnzip_mismatch < 1 => 2.776466,
			1 <= (integer) iv_vp091_phnzip_mismatch                                    => -76.622314,
																																					-0.000000);

	new_other_a_subscore20 := map(
			NULL < iv_sr001_source_profile AND iv_sr001_source_profile < 56.1 => -34.227912,
			56.1 <= iv_sr001_source_profile                                   => 5.947531,
																																					 0.000000);

	new_other_a_subscore21 := map(
			NULL < cs_pct_addrs_le_12mo AND cs_pct_addrs_le_12mo < 68 => 1.899269,
			68 <= cs_pct_addrs_le_12mo                                => -91.296293,
																																	 0.000000);

	new_other_a_subscore22 := map(
			(iv_va100_add_problem in [' '])                                                                                                                                                         => -0.000000,
			(iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '05 Drop Delivery', '09 Corporate Zip Code', '11 Throw Back', '12 College']) => 1.659419,
			(iv_va100_add_problem in ['03 Standarization Error', '04 HiRisk Commercial', '06 Invalid Address', '07 Busines', '10 Zip/City Mismatch', '13 Vacant', '14 Zip/State Mismatch'])         => -41.960380,
																																																																																																 -0.000000);

	new_other_a_scaledscore := new_other_a_subscore0 +
			new_other_a_subscore1 +
			new_other_a_subscore2 +
			new_other_a_subscore3 +
			new_other_a_subscore4 +
			new_other_a_subscore5 +
			new_other_a_subscore6 +
			new_other_a_subscore7 +
			new_other_a_subscore8 +
			new_other_a_subscore9 +
			new_other_a_subscore10 +
			new_other_a_subscore11 +
			new_other_a_subscore12 +
			new_other_a_subscore13 +
			new_other_a_subscore14 +
			new_other_a_subscore15 +
			new_other_a_subscore16 +
			new_other_a_subscore17 +
			new_other_a_subscore18 +
			new_other_a_subscore19 +
			new_other_a_subscore20 +
			new_other_a_subscore21 +
			new_other_a_subscore22;

	lien_rec_unrel_flag_1 := liens_recent_unreleased_count > 0;

	lien_hist_unrel_flag_1 := liens_historical_unreleased_ct > 0;

	source_tot_l2 := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'L2', ',');

	source_tot_li := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'LI', ',');

	lien_flag_1 := source_tot_l2 or source_tot_li or lien_rec_unrel_flag_1 or lien_hist_unrel_flag_1;

	source_tot_ds := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',');

	source_tot_ba := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'BA', ',');

	bk_flag_1 := (rc_bansflag in ['1', '2']) or source_tot_ba or bankrupt or filing_count > 0 or bk_recent_count > 0;

	ssn_deceased_1 := rc_decsflag = '1' or source_tot_ds;

	pk_impulse_count_1 := impulse_count ;

	pk_impulse_count := if(pk_impulse_count_1 > 2, 2, pk_impulse_count_1);

	bs_attr_derog_flag := if(attr_total_number_derogs > 0, 1, 0);

	bs_attr_eviction_flag := if(attr_eviction_count > 0, 1, 0);

	prop_owner := add1_naprop = 4 or property_owned_total > 0;

	segment_d := bs_attr_derog_flag > 0 or 
		lien_flag_1 or 
		bs_attr_eviction_flag > 0 or 
		pk_impulse_count > 0 or 
		bk_flag_1 or 
		ssn_deceased_1;

	segment_y := 0;

	segment_o := not(segment_d or (boolean)segment_y) and prop_owner;

	base_c569_b1 := 681;

	scale_c569_b1 := 1 / 3;

	base_c569_b2 := 725;

	scale_c569_b2 := 1 / 3;

	base_c569_b3 := 678;

	scale_c569_b3 := 1 / 3;

	_rvg1401_2_0 := map(
			segment_d => round(min(if(max(base_c569_b1 + scale_c569_b1 * new_derog_a_scaledscore, (real)501) = NULL, -NULL, max(base_c569_b1 + scale_c569_b1 * new_derog_a_scaledscore, (real)501)), 900)),
			segment_o => round(min(if(max(base_c569_b2 + scale_c569_b2 * new_owner_a_scaledscore, (real)501) = NULL, -NULL, max(base_c569_b2 + scale_c569_b2 * new_owner_a_scaledscore, (real)501)), 900)),
									 round(min(if(max(base_c569_b3 + scale_c569_b3 * new_other_a_scaledscore, (real)501) = NULL, -NULL, max(base_c569_b3 + scale_c569_b3 * new_other_a_scaledscore, (real)501)), 900)));

	bk_flag := (rc_bansflag in ['1', '2']) or ver_src_ba or bankrupt or filing_count > 0 or bk_recent_count > 0;

	lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

	lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

	lien_flag := ver_src_l2 or lien_rec_unrel_flag or lien_hist_unrel_flag;

	ssn_deceased := rc_decsflag = '1' or ver_src_ds ;

	scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 or 90 <= combo_dobscore AND combo_dobscore <= 100 or (integer) input_dob_match_level >= 7 or lien_flag or criminal_count > 0 or bk_flag or ssn_deceased or truedid;

	rvg1401_2_0 := map(
			ssn_deceased		                                                                => 200,
			riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid) => 222,

																																												 _rvg1401_2_0);

	glrc25_d := add1_pop;

	glrc36_d := addrpop and hphnpop and nap_phn_ver_lvl != 3 and inf_phn_ver_lvl != 3;

	glrc97_d := criminal_count > 0;

	glrc98_d := if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct, liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct), if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) > 0;

	glrc9c_d := truedid and add1_lres < 48;

	glrc9d_d := addrs_10yr >= 3;

	glrc9e_d := truedid and add1_pop;

	glrc9h_d := iv_ds001_impulse_count > 0;

	glrc9i_d := age < 30 and not(evidence_of_college);

	glrc9q_d := inq_count12 > 0;

	glrc9r_d := truedid;

	glrc9t_d := (iv_nap_status in ['D']);

	glrc9w_d := (rc_bansflag in ['1', '2']) or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'BA', ',') or bankrupt or filing_count > 0 or bk_recent_count > 0;

	// glrc9y_d := truedid and iv_pb_total_orders < 1;

	glrcev_d := attr_eviction_count > 0;

	glrcms_d := ssns_per_adl > 1;

	glrcpv_d := truedid and addrpop and 0 < add1_avm_automated_valuation AND add1_avm_automated_valuation < 150000;

	glrcbl_d := 0;

	crim_f_d := criminal_count > 0;

	lien_f_d := if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct, liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct), if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) > 0;

	eviction_f_d := attr_eviction_count > 0;

	impulse_f_d := iv_ds001_impulse_count > 0;

	bk_f_d := (rc_bansflag in ['1', '2']) or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'BA', ',') or bankrupt or filing_count > 0 or bk_recent_count > 0;

	derog_contributions_d := 5 * (integer)crim_f_d +
			4 * (integer)lien_f_d +
			3 * (integer)eviction_f_d +
			2 * (integer)impulse_f_d +
			(integer)bk_f_d;

	rcvalue97_0_d := 44 * 3 * 5 * (integer)crim_f_d / derog_contributions_d;

	rcvalue98_0_d := 44 * 3 * 4 / (integer)lien_f_d / derog_contributions_d;

	rcvalueev_0_d := 44 * 3 * 3 / (integer)eviction_f_d / derog_contributions_d;

	rcvalue9h_0_d := 44 * 3 * 2 / (integer)impulse_f_d / derog_contributions_d;

	rcvalue9w_0_d := 44 * 3 * 1 / (integer)bk_f_d / derog_contributions_d;

	rcvalue9w_d := (integer)glrc9w_d * if(max(rcvalue9w_0_d) = NULL, NULL, sum(if(rcvalue9w_0_d = NULL, 0, rcvalue9w_0_d)));

	rcvalue9q_1_d := 37.798390 - new_derog_a_subscore0;

	rcvalue9q_2_d := 4.844351 - new_derog_a_subscore15;

	rcvalue9q_3_d := 5.436700 - new_derog_a_subscore16;

	rcvalue9q_d := (integer)glrc9q_d * if(max(rcvalue9q_1_d, rcvalue9q_2_d, rcvalue9q_3_d) = NULL, NULL, sum(if(rcvalue9q_1_d = NULL, 0, rcvalue9q_1_d), if(rcvalue9q_2_d = NULL, 0, rcvalue9q_2_d), if(rcvalue9q_3_d = NULL, 0, rcvalue9q_3_d)));

	rcvalue97_1_d := 5.640182 - new_derog_a_subscore2;

	rcvalue97_d := (integer)glrc97_d * if(max(rcvalue97_0_d, rcvalue97_1_d) = NULL, NULL, sum(if(rcvalue97_0_d = NULL, 0, rcvalue97_0_d), if(rcvalue97_1_d = NULL, 0, rcvalue97_1_d)));

	rcvalue9c_1_d := if(unique_addr_count = 1, 4.532598 - new_derog_a_subscore23, 0);

	rcvalue9d_1_d := if(unique_addr_count > 1, 4.532598 - new_derog_a_subscore23, 0);

	rcvalue9d_2_d := 36.148105 - new_derog_a_subscore3;

	rcvalue9c_d := (integer)glrc9c_d * if(max(rcvalue9c_1_d) = NULL, NULL, sum(if(rcvalue9c_1_d = NULL, 0, rcvalue9c_1_d)));

	rcvalue9d_d := (integer)glrc9d_d * if(max(rcvalue9d_1_d, rcvalue9d_2_d) = NULL, NULL, sum(if(rcvalue9d_1_d = NULL, 0, rcvalue9d_1_d), if(rcvalue9d_2_d = NULL, 0, rcvalue9d_2_d)));

	rcvalue9r_1_d := 41.805854 - new_derog_a_subscore4;

	rcvalue9r_2_d := 33.838102 - new_derog_a_subscore10;

	rcvalue9r_3_d := 16.838583 - new_derog_a_subscore13;

	rcvalue9r_d := (integer)glrc9r_d * if(max(rcvalue9r_1_d, rcvalue9r_2_d, rcvalue9r_3_d) = NULL, NULL, sum(if(rcvalue9r_1_d = NULL, 0, rcvalue9r_1_d), if(rcvalue9r_2_d = NULL, 0, rcvalue9r_2_d), if(rcvalue9r_3_d = NULL, 0, rcvalue9r_3_d)));

	rcvaluems_1_d := 11.183609 - new_derog_a_subscore6;

	rcvaluems_d := (integer)glrcms_d * if(max(rcvaluems_1_d) = NULL, NULL, sum(if(rcvaluems_1_d = NULL, 0, rcvaluems_1_d)));

	rcvalue98_1_d := 22.561434 - new_derog_a_subscore7;

	rcvalue98_d := (integer)glrc98_d * if(max(rcvalue98_0_d, rcvalue98_1_d) = NULL, NULL, sum(if(rcvalue98_0_d = NULL, 0, rcvalue98_0_d), if(rcvalue98_1_d = NULL, 0, rcvalue98_1_d)));

	rcvalue25_1_d := 7.732148 - new_derog_a_subscore8;

	rcvalue25_d := (integer)glrc25_d * if(max(rcvalue25_1_d) = NULL, NULL, sum(if(rcvalue25_1_d = NULL, 0, rcvalue25_1_d)));

	rcvaluebl_1_d := 57.809893 - new_derog_a_subscore9;

	rcvaluebl_2_d := 92.422125 - new_derog_a_subscore1;

	rcvaluebl_3_d := 64.751957 - new_derog_a_subscore20;

	rcvaluebl_d := glrcbl_d * if(max(rcvaluebl_1_d, rcvaluebl_2_d, rcvaluebl_3_d) = NULL, NULL, sum(if(rcvaluebl_1_d = NULL, 0, rcvaluebl_1_d), if(rcvaluebl_2_d = NULL, 0, rcvaluebl_2_d), if(rcvaluebl_3_d = NULL, 0, rcvaluebl_3_d)));

	rcvalue36_1_d := 38.186640 - new_derog_a_subscore11;

	rcvalue36_d := (integer)glrc36_d * if(max(rcvalue36_1_d) = NULL, NULL, sum(if(rcvalue36_1_d = NULL, 0, rcvalue36_1_d)));

	// rcvalue9y_1_d := 18.541109 - new_derog_a_subscore12;

	// rcvalue9y_d := (integer)glrc9y_d * if(max(rcvalue9y_1_d) = NULL, NULL, sum(if(rcvalue9y_1_d = NULL, 0, rcvalue9y_1_d)));

	rcvaluepv_1_d := 8.470360 - new_derog_a_subscore26;

	rcvaluepv_2_d := 68.610474 - new_derog_a_subscore22;

	rcvaluepv_3_d := 63.799037 - new_derog_a_subscore14;

	rcvaluepv_4_d := 28.244389 - new_derog_a_subscore21;

	rcvaluepv_d := (integer)glrcpv_d * if(max(rcvaluepv_1_d, rcvaluepv_2_d, rcvaluepv_3_d, rcvaluepv_4_d) = NULL, NULL, sum(if(rcvaluepv_1_d = NULL, 0, rcvaluepv_1_d), if(rcvaluepv_2_d = NULL, 0, rcvaluepv_2_d), if(rcvaluepv_3_d = NULL, 0, rcvaluepv_3_d), if(rcvaluepv_4_d = NULL, 0, rcvaluepv_4_d)));

	rcvalue9e_1_d := 11.700290 - new_derog_a_subscore17;

	rcvalue9e_2_d := 25.948636 - new_derog_a_subscore19;

	rcvalue9e_3_d := 37.901222 - new_derog_a_subscore28;

	rcvalue9e_4_d := 123.809057 - new_derog_a_subscore5;

	rcvalue9e_d := (integer)glrc9e_d * if(max(rcvalue9e_1_d, rcvalue9e_2_d, rcvalue9e_3_d, rcvalue9e_4_d) = NULL, NULL, sum(if(rcvalue9e_1_d = NULL, 0, rcvalue9e_1_d), if(rcvalue9e_2_d = NULL, 0, rcvalue9e_2_d), if(rcvalue9e_3_d = NULL, 0, rcvalue9e_3_d), if(rcvalue9e_4_d = NULL, 0, rcvalue9e_4_d)));

	rcvalue9h_1_d := 7.466002 - new_derog_a_subscore18;

	rcvalue9h_d := (integer)glrc9h_d * if(max(rcvalue9h_0_d, rcvalue9h_1_d) = NULL, NULL, sum(if(rcvalue9h_0_d = NULL, 0, rcvalue9h_0_d), if(rcvalue9h_1_d = NULL, 0, rcvalue9h_1_d)));

	rcvalue9t_1_d := 1.677250 - new_derog_a_subscore24;

	rcvalue9t_d := (integer)glrc9t_d * if(max(rcvalue9t_1_d) = NULL, NULL, sum(if(rcvalue9t_1_d = NULL, 0, rcvalue9t_1_d)));

	rcvalue9i_1_d := 21.550723 - new_derog_a_subscore25;

	rcvalue9i_d := (integer)glrc9i_d * if(max(rcvalue9i_1_d) = NULL, NULL, sum(if(rcvalue9i_1_d = NULL, 0, rcvalue9i_1_d)));

	rcvalueev_1_d := 2.183982 - new_derog_a_subscore27;

	rcvalueev_d := (integer)glrcev_d * if(max(rcvalueev_0_d, rcvalueev_1_d) = NULL, NULL, sum(if(rcvalueev_0_d = NULL, 0, rcvalueev_0_d), if(rcvalueev_1_d = NULL, 0, rcvalueev_1_d)));

	glrc16_o := hphnpop and not(out_z5 = '');

	glrc25_o := add1_pop;

	glrc36_o := addrpop and hphnpop and nap_phn_ver_lvl != 3 and inf_phn_ver_lvl != 3;

	glrc9c_o := truedid and add1_lres < 48;

	glrc9d_o := addrs_10yr >= 3;

	glrc9e_o := truedid and add1_pop;

	glrc9i_o := age < 30 and not(evidence_of_college);

	glrc9q_o := inq_count12 > 0;

	glrc9r_o := truedid;

	glrc9t_o := hphnpop;

	// glrc9y_o := truedid and iv_pb_average_dollars < 0;

	glrcpv_o := truedid and addrpop and 0 < add1_avm_automated_valuation AND add1_avm_automated_valuation < 150000;

	glrcbl_o := 0;

	rcvalue9q_1_o := 28.951795 - new_owner_a_subscore0;

	rcvalue9q_2_o := 4.048270 - new_owner_a_subscore13;

	rcvalue9q_o := (integer)glrc9q_o * if(max(rcvalue9q_1_o, rcvalue9q_2_o) = NULL, NULL, sum(if(rcvalue9q_1_o = NULL, 0, rcvalue9q_1_o), if(rcvalue9q_2_o = NULL, 0, rcvalue9q_2_o)));

	// rcvalue9y_1_o := 47.579441 - new_owner_a_subscore1;

	// rcvalue9y_o := (integer)glrc9y_o * if(max(rcvalue9y_1_o) = NULL, NULL, sum(if(rcvalue9y_1_o = NULL, 0, rcvalue9y_1_o)));

	rcvalue36_1_o := 73.030684 - new_owner_a_subscore2;

	rcvalue36_o := (integer)glrc36_o * if(max(rcvalue36_1_o) = NULL, NULL, sum(if(rcvalue36_1_o = NULL, 0, rcvalue36_1_o)));

	rcvalue25_1_o := 7.800891 - new_owner_a_subscore3;

	rcvalue25_o := (integer)glrc25_o * if(max(rcvalue25_1_o) = NULL, NULL, sum(if(rcvalue25_1_o = NULL, 0, rcvalue25_1_o)));

	rcvaluepv_1_o := 32.205386 - new_owner_a_subscore8;

	rcvaluepv_2_o := 25.743158 - new_owner_a_subscore12;

	rcvaluepv_3_o := 24.288786 - new_owner_a_subscore19;

	rcvaluepv_o := (integer)glrcpv_o * if(max(rcvaluepv_1_o, rcvaluepv_2_o, rcvaluepv_3_o) = NULL, NULL, sum(if(rcvaluepv_1_o = NULL, 0, rcvaluepv_1_o), if(rcvaluepv_2_o = NULL, 0, rcvaluepv_2_o), if(rcvaluepv_3_o = NULL, 0, rcvaluepv_3_o)));

	rcvalue9e_1_o := 83.362178 - new_owner_a_subscore6;

	rcvalue9e_2_o := 4.586664 - new_owner_a_subscore10;

	rcvalue9e_3_o := 93.912492 - new_owner_a_subscore17;

	rcvalue9e_o := (integer)glrc9e_o * if(max(rcvalue9e_1_o, rcvalue9e_2_o, rcvalue9e_3_o) = NULL, NULL, sum(if(rcvalue9e_1_o = NULL, 0, rcvalue9e_1_o), if(rcvalue9e_2_o = NULL, 0, rcvalue9e_2_o), if(rcvalue9e_3_o = NULL, 0, rcvalue9e_3_o)));

	rcvalue16_1_o := 3.601085 - new_owner_a_subscore11;

	rcvalue16_o := 0.25 * (integer)glrc16_o * if(max(rcvalue16_1_o) = NULL, NULL, sum(if(rcvalue16_1_o = NULL, 0, rcvalue16_1_o)));

	rcvaluebl_1_o := 16.646809 - new_owner_a_subscore14;

	rcvaluebl_2_o := 51.503163 - new_owner_a_subscore9;

	rcvaluebl_3_o := 11.647032 - new_owner_a_subscore5;

	rcvaluebl_o := glrcbl_o * if(max(rcvaluebl_1_o, rcvaluebl_2_o, rcvaluebl_3_o) = NULL, NULL, sum(if(rcvaluebl_1_o = NULL, 0, rcvaluebl_1_o), if(rcvaluebl_2_o = NULL, 0, rcvaluebl_2_o), if(rcvaluebl_3_o = NULL, 0, rcvaluebl_3_o)));

	rcvalue9r_1_o := 9.533694 - new_owner_a_subscore15;

	rcvalue9r_2_o := 8.819299 - new_owner_a_subscore16;

	rcvalue9r_3_o := 47.470454 - new_owner_a_subscore7;

	rcvalue9r_o := (integer)glrc9r_o * if(max(rcvalue9r_1_o, rcvalue9r_2_o, rcvalue9r_3_o) = NULL, NULL, sum(if(rcvalue9r_1_o = NULL, 0, rcvalue9r_1_o), if(rcvalue9r_2_o = NULL, 0, rcvalue9r_2_o), if(rcvalue9r_3_o = NULL, 0, rcvalue9r_3_o)));

	rcvalue9i_1_o := 35.652387 - new_owner_a_subscore18;

	rcvalue9i_o := (integer)glrc9i_o * if(max(rcvalue9i_1_o) = NULL, NULL, sum(if(rcvalue9i_1_o = NULL, 0, rcvalue9i_1_o)));

	rcvalue9c_1_o := 35.944419 - new_owner_a_subscore4;

	rcvalue9c_2_o := if(unique_addr_count = 1, 2.522750 - new_owner_a_subscore20, 0);

	rcvalue9d_1_o := if(unique_addr_count > 1, 2.522750 - new_owner_a_subscore20, 0);

	rcvalue9c_o := (integer)glrc9c_o * if(max(rcvalue9c_1_o, rcvalue9c_2_o) = NULL, NULL, sum(if(rcvalue9c_1_o = NULL, 0, rcvalue9c_1_o), if(rcvalue9c_2_o = NULL, 0, rcvalue9c_2_o)));

	rcvalue9d_o := (integer)glrc9d_o * if(max(rcvalue9d_1_o) = NULL, NULL, sum(if(rcvalue9d_1_o = NULL, 0, rcvalue9d_1_o)));

	rcvalue9t_1_o := 0.792630 - new_owner_a_subscore21;

	rcvalue9t_o := (integer)glrc9t_o * if(max(rcvalue9t_1_o) = NULL, NULL, sum(if(rcvalue9t_1_o = NULL, 0, rcvalue9t_1_o)));

	glrc16_oth := hphnpop and not(out_z5 = '');

	glrc36_oth := addrpop and hphnpop and nap_phn_ver_lvl != 3 and inf_phn_ver_lvl != 3;

	glrc9a_oth := add1_naprop = 4 or property_owned_total > 0;

	glrc9c_oth := truedid and add1_lres < 48;

	glrc9d_oth := truedid and addrs_10yr > 4;

	glrc9e_oth := truedid and add1_pop;

	glrc9i_oth := age < 30 and not(evidence_of_college);

	glrc9q_oth := inq_count12 > 0;

	glrc9r_oth := truedid;

	glrc9t_oth := hphnpop;

	glrc9u_oth := add1_pop;

	// glrc9y_oth := truedid and iv_pb_average_dollars < 0;

	glrcms_oth := ssns_per_adl > 1;

	glrcpv_oth := truedid and addrpop and 0 < add1_avm_automated_valuation AND add1_avm_automated_valuation < 150000;

	glrcbl_oth := 0;

	rcvalue9a_0_oth := 47 * 3;

	rcvalue9a_oth := (integer)glrc9a_oth * if(max(rcvalue9a_0_oth) = NULL, NULL, sum(if(rcvalue9a_0_oth = NULL, 0, rcvalue9a_0_oth)));

	rcvalue9q_1_oth := 46.731441 - new_other_a_subscore0;

	rcvalue9q_2_oth := 10.384453 - new_other_a_subscore3;

	rcvalue9q_oth := (integer)glrc9q_oth * if(max(rcvalue9q_1_oth, rcvalue9q_2_oth) = NULL, NULL, sum(if(rcvalue9q_1_oth = NULL, 0, rcvalue9q_1_oth), if(rcvalue9q_2_oth = NULL, 0, rcvalue9q_2_oth)));

	rcvaluebl_1_oth := 95.619913 - new_other_a_subscore1;

	rcvaluebl_oth := glrcbl_oth * if(max(rcvaluebl_1_oth) = NULL, NULL, sum(if(rcvaluebl_1_oth = NULL, 0, rcvaluebl_1_oth)));

	rcvalue9y_1_oth := 49.457808 - new_other_a_subscore2;

	// rcvalue9y_oth := (integer)glrc9y_oth * if(max(rcvalue9y_1_oth) = NULL, NULL, sum(if(rcvalue9y_1_oth = NULL, 0, rcvalue9y_1_oth)));

	rcvalue9c_1_oth := 124.601040 - new_other_a_subscore12;

	rcvalue9c_2_oth := 13.823078 - new_other_a_subscore13;

	rcvalue9d_1_oth := 49.457808 - new_other_a_subscore2;

	rcvalue9e_1_oth := 10.323525 - new_other_a_subscore4;

	rcvalue9e_2_oth := 108.696047 - new_other_a_subscore6;

	rcvalue9e_3_oth := 89.185942 - new_other_a_subscore16;

	rcvalue9c_3_oth := if(unique_addr_count = 1, 1.899269 - new_other_a_subscore21, 0);

	rcvalue9d_2_oth := if(unique_addr_count > 1, 1.899269 - new_other_a_subscore21, 0);

	rcvalue9e_4_oth := if(unique_addr_count = 0, 17.818194 - new_other_a_subscore8, 0);

	rcvalue9d_3_oth := if(unique_addr_count = 0, 0, 17.818194 - new_other_a_subscore8);

	rcvalue9c_oth := (integer)glrc9c_oth * if(max(rcvalue9c_1_oth, rcvalue9c_2_oth, rcvalue9c_3_oth) = NULL, NULL, sum(if(rcvalue9c_1_oth = NULL, 0, rcvalue9c_1_oth), if(rcvalue9c_2_oth = NULL, 0, rcvalue9c_2_oth), if(rcvalue9c_3_oth = NULL, 0, rcvalue9c_3_oth)));

	rcvalue9d_oth := (integer)glrc9d_oth * if(max(rcvalue9d_1_oth, rcvalue9d_2_oth, rcvalue9d_3_oth) = NULL, NULL, sum(if(rcvalue9d_1_oth = NULL, 0, rcvalue9d_1_oth), if(rcvalue9d_2_oth = NULL, 0, rcvalue9d_2_oth), if(rcvalue9d_3_oth = NULL, 0, rcvalue9d_3_oth)));

	rcvalue9e_oth := (integer)glrc9e_oth * if(max(rcvalue9e_1_oth, rcvalue9e_2_oth, rcvalue9e_3_oth, rcvalue9e_4_oth) = NULL, NULL, sum(if(rcvalue9e_1_oth = NULL, 0, rcvalue9e_1_oth), if(rcvalue9e_2_oth = NULL, 0, rcvalue9e_2_oth), if(rcvalue9e_3_oth = NULL, 0, rcvalue9e_3_oth), if(rcvalue9e_4_oth = NULL, 0, rcvalue9e_4_oth)));

	rcvaluems_1_oth := 12.672966 - new_other_a_subscore5;

	rcvaluems_oth := (integer)glrcms_oth * if(max(rcvaluems_1_oth) = NULL, NULL, sum(if(rcvaluems_1_oth = NULL, 0, rcvaluems_1_oth)));

	rcvalue9r_1_oth := 78.799644 - new_other_a_subscore9;

	rcvalue9r_2_oth := 42.891273 - new_other_a_subscore11;

	rcvalue9r_3_oth := 5.947531 - new_other_a_subscore20;

	rcvalue9r_4_oth := 38.649296 - new_other_a_subscore7;

	rcvalue9r_oth := (integer)glrc9r_oth * if(max(rcvalue9r_1_oth, rcvalue9r_2_oth, rcvalue9r_3_oth, rcvalue9r_4_oth) = NULL, NULL, sum(if(rcvalue9r_1_oth = NULL, 0, rcvalue9r_1_oth), if(rcvalue9r_2_oth = NULL, 0, rcvalue9r_2_oth), if(rcvalue9r_3_oth = NULL, 0, rcvalue9r_3_oth), if(rcvalue9r_4_oth = NULL, 0, rcvalue9r_4_oth)));

	rcvaluepv_1_oth := 46.271497 - new_other_a_subscore10;

	rcvaluepv_oth := (integer)glrcpv_oth * if(max(rcvaluepv_1_oth) = NULL, NULL, sum(if(rcvaluepv_1_oth = NULL, 0, rcvaluepv_1_oth)));

	rcvalue36_1_oth := 31.262306 - new_other_a_subscore14;

	rcvalue36_oth := (integer)glrc36_oth * if(max(rcvalue36_1_oth) = NULL, NULL, sum(if(rcvalue36_1_oth = NULL, 0, rcvalue36_1_oth)));

	rcvalue9i_1_oth := 46.294608 - new_other_a_subscore17;

	rcvalue9i_oth := (integer)glrc9i_oth * if(max(rcvalue9i_1_oth) = NULL, NULL, sum(if(rcvalue9i_1_oth = NULL, 0, rcvalue9i_1_oth)));

	rcvalue9t_1_oth := 1.057267 - new_other_a_subscore18;

	rcvalue9t_oth := (integer)glrc9t_oth * if(max(rcvalue9t_1_oth) = NULL, NULL, sum(if(rcvalue9t_1_oth = NULL, 0, rcvalue9t_1_oth)));

	rcvalue16_1_oth := 2.776466 - new_other_a_subscore19;

	rcvalue16_oth := 0.25 * (integer)glrc16_oth * if(max(rcvalue16_1_oth) = NULL, NULL, sum(if(rcvalue16_1_oth = NULL, 0, rcvalue16_1_oth)));

	rcvalue9u_1_oth := if(iv_VA100_Add_Problem in ['04 HiRisk Commercial',
									'06 Invalid Address','07 Busines','13 Vacant'],
									1.659419 - new_other_a_subscore22, 0);

	rcvalue9u_oth := (integer)glrc9u_oth * if(max(rcvalue9u_1_oth) = NULL, NULL, sum(if(rcvalue9u_1_oth = NULL, 0, rcvalue9u_1_oth)));

	//*************************************************************************************//
	// I have no idea how the reason code logic gets implemented in ECL, so everything below 
	// probably needs to get changed or replaced.  The methodology for creating the reason codes is
	// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
	// that model code for guidance on implementing reason codes. 
	//*************************************************************************************//
	rc5_d := '';
	rc5_o := '';
	rc5_oth := '';
	
	ds_layout := {STRING rc, REAL value};
	
	rc_dataset_d := DATASET([
			{'9W', RCValue9W_d},
			{'9Q', RCValue9Q_d},
			{'97', RCValue97_d},
			{'9C', RCValue9C_d},
			{'9D', RCValue9D_d},
			{'9R', RCValue9R_d},
			{'MS', RCValueMS_d},
			{'98', RCValue98_d},
			{'25', RCValue25_d},
			{'BL', RCValueBL_d},
			{'36', RCValue36_d},
			// {'9Y', RCValue9Y_d},
			{'PV', RCValuePV_d},
			{'9E', RCValue9E_d},
			{'9H', RCValue9H_d},
			{'9T', RCValue9T_d},
			{'9I', RCValue9I_d},
			{'EV', RCValueEV_d}
			], ds_layout)(value > 0);

	rc_dataset_d_sorted := sort(rc_dataset_d, -rc_dataset_d.value);

	rc1_d := rc_dataset_d_sorted[1].rc;
	rc2_d := rc_dataset_d_sorted[2].rc;
	rc3_d := rc_dataset_d_sorted[3].rc;
	rc4_d := rc_dataset_d_sorted[4].rc;
	//*************************************************************************************//

	rc_dataset_o := DATASET([
			{'9Q', RCValue9Q_o},
			// {'9Y', RCValue9Y_o},
			{'36', RCValue36_o},
			{'25', RCValue25_o},
			{'PV', RCValuePV_o},
			{'9E', RCValue9E_o},
			{'16', RCValue16_o},
			{'BL', RCValueBL_o},
			{'9R', RCValue9R_o},
			{'9I', RCValue9I_o},
			{'9C', RCValue9C_o},
			{'9D', RCValue9D_o},
			{'9T', RCValue9T_o}
			], ds_layout)(value > 0);

	rc_dataset_o_sorted := sort(rc_dataset_o, -rc_dataset_o.value);

	rc1_o := rc_dataset_o_sorted[1].rc;
	rc2_o := rc_dataset_o_sorted[2].rc;
	rc3_o := rc_dataset_o_sorted[3].rc;
	rc4_o := rc_dataset_o_sorted[4].rc;

	//*************************************************************************************//

	rc_dataset_oth := DATASET([
			{'9A', RCValue9A_oth},
			{'9Q', RCValue9Q_oth},
			{'BL', RCValueBL_oth},
			// {'9Y', RCValue9Y_oth},
			{'9C', RCValue9C_oth},
			{'9D', RCValue9D_oth},
			{'9E', RCValue9E_oth},
			{'MS', RCValueMS_oth},
			{'9R', RCValue9R_oth},
			{'PV', RCValuePV_oth},
			{'36', RCValue36_oth},
			{'9I', RCValue9I_oth},
			{'9T', RCValue9T_oth},
			{'16', RCValue16_oth},
			{'9U', RCValue9U_oth}
			], ds_layout)(value > 0);

	rc_dataset_oth_sorted := sort(rc_dataset_oth, -rc_dataset_oth.value);

	rc1_oth := rc_dataset_oth_sorted[1].rc;
	rc2_oth := rc_dataset_oth_sorted[2].rc;
	rc3_oth := rc_dataset_oth_sorted[3].rc;
	rc4_oth := rc_dataset_oth_sorted[4].rc;

	//*************************************************************************************//

	rc_1 := map(
			segment_d => rc_dataset_d_sorted[1],
			segment_o => rc_dataset_o_sorted[1],
									 rc_dataset_oth_sorted[1]);
	rc_2 := map(
			segment_d => rc_dataset_d_sorted[2],
			segment_o => rc_dataset_o_sorted[2],
									 rc_dataset_oth_sorted[2]);

	rc_3 := map(
			segment_d => rc_dataset_d_sorted[3],
			segment_o => rc_dataset_o_sorted[3],
									 rc_dataset_oth_sorted[3]);

	rc_4 := map(
			segment_d => rc_dataset_d_sorted[4],
			segment_o => rc_dataset_o_sorted[4],
									 rc_dataset_oth_sorted[4]);

	rc_5 := map(
			segment_d => rc_dataset_d_sorted[5],
			segment_o => rc_dataset_o_sorted[5],
									 rc_dataset_oth_sorted[5]);

	glrc9q := map(
			segment_d => glrc9q_d,
			segment_o => glrc9q_o,
									 glrc9q_oth);

	rc5_1 := if(GLRC9Q and 
		rc_1.rc != '9Q' and 
		rc_2.rc != '9Q' and 
		rc_3.rc != '9Q' and 
		rc_4.rc != '9Q' and 
		inq_count12 > 0, ROW({'9Q', NULL}, ds_layout),  ROW({'', NULL}, ds_layout));

//////////////////////////////////////////////////////////////////////////

	rcs_9q_1 := rc_1 + 
		rc_2 + 
		rc_3 + 
		rc_4 + 
		if(rc5_1.rc = '9Q', rc5_1) ; 
	
	rcs_9q_1_1 := if(rvg1401_2_0 != 900 and rcs_9q_1[1].rc = '', ROW({'36', NULL}, ds_layout),	rcs_9q_1[1]);
	
	rcs_9q := rcs_9q_1_1 +  rcs_9q_1[2] + rcs_9q_1[3] + rcs_9q_1[4] + rcs_9q_1[5];		

//////////////////overrides
	rcs_override := MAP(
											rvg1401_2_0 = 200 							=> DATASET([{'02', NULL}], ds_layout),
											rvg1401_2_0 = 222 							=> DATASET([{'9X', NULL}], ds_layout),
											rvg1401_2_0 = 900 							=> DATASET([{'  ', NULL}], ds_layout),
											rcs_9q
										 );

	riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);

	rcs_final := PROJECT(rcs_override, TRANSFORM(Risk_Indicators.Layout_Desc,
				SELF.hri := LEFT.rc,
				SELF.desc := Risk_Indicators.getHRIDesc(LEFT.rc)
			));

	inCalif := isCalifornia AND (
				(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
				+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
				+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
			
	ri := MAP(
						riTemp[1].hri <> '00' => riTemp,
						inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
						rcs_final
						);
					
	zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
	
	reasons := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes

//Intermediate variables
	#if(RVG_DEBUG)
		self.clam															:= le;
		self.sysdate                          := sysdate;                                             
		self.ver_src_ba_pos                   := ver_src_ba_pos;                                      
		self.ver_src_ba                       := ver_src_ba;                                          
		self.ver_src_ds_pos                   := ver_src_ds_pos;                                      
		self.ver_src_ds                       := ver_src_ds;                                          
		self.ver_src_l2_pos                   := ver_src_l2_pos;                                      
		self.ver_src_l2                       := ver_src_l2;                                          
		self.bureau_adl_tn_fseen_pos          := bureau_adl_tn_fseen_pos;                             
		self.bureau_adl_fseen_tn              := bureau_adl_fseen_tn;                                 
		self._bureau_adl_fseen_tn             := _bureau_adl_fseen_tn;                                
		self.bureau_adl_ts_fseen_pos          := bureau_adl_ts_fseen_pos;                             
		self.bureau_adl_fseen_ts              := bureau_adl_fseen_ts;                                 
		self._bureau_adl_fseen_ts             := _bureau_adl_fseen_ts;                                
		self.bureau_adl_tu_fseen_pos          := bureau_adl_tu_fseen_pos;                             
		self.bureau_adl_fseen_tu              := bureau_adl_fseen_tu;                                 
		self._bureau_adl_fseen_tu             := _bureau_adl_fseen_tu;                                
		self.bureau_adl_en_fseen_pos          := bureau_adl_en_fseen_pos;                             
		self.bureau_adl_fseen_en              := bureau_adl_fseen_en;                                 
		self._bureau_adl_fseen_en             := _bureau_adl_fseen_en;                                
		self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;                             
		self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;                                 
		self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;                                
		self.iv_sr001_m_bureau_adl_fs         := iv_sr001_m_bureau_adl_fs;                            
		self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;                               
		self.iv_pv001_inp_avm_autoval         := iv_pv001_inp_avm_autoval;                            
		self.prop_adl_p_fseen_pos             := prop_adl_p_fseen_pos;                                
		self.prop_adl_fseen_p                 := prop_adl_fseen_p;                                    
		self._prop_adl_fseen_p                := _prop_adl_fseen_p;                                   
		self._src_prop_adl_fseen              := _src_prop_adl_fseen;                                 
		self.iv_pl001_m_snc_prop_adl_fs       := iv_pl001_m_snc_prop_adl_fs;                          
		self.iv_in001_estimated_income        := iv_in001_estimated_income;                           
		self.iv_inp_addr_address_score        := iv_inp_addr_address_score;                           
		self.iv_prop_sold_assessed_total      := iv_prop_sold_assessed_total;                         
		self.iv_addrs_10yr                    := iv_addrs_10yr;                                       
		self.iv_inq_auto_count12              := iv_inq_auto_count12;                                 
		self.iv_inq_highriskcredit_recency    := iv_inq_highriskcredit_recency;                       
		self.iv_paw_dead_bus_x_active_phn     := iv_paw_dead_bus_x_active_phn;                        
		self.ver_phn_inf                      := ver_phn_inf;                                         
		self.ver_phn_nap                      := ver_phn_nap;                                         
		self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;                                     
		self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;                                     
		self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;                        
		self._reported_dob                    := _reported_dob;                                       
		self.reported_age                     := reported_age;                                        
		self._combined_age                    := _combined_age;                                       
		self.evidence_of_college              := evidence_of_college;                                 
		self.iv_college_attendance_x_age      := iv_college_attendance_x_age;                         
		self.iv_prof_license_category         := iv_prof_license_category;                            
		self.iv_vp091_phnzip_mismatch         := iv_vp091_phnzip_mismatch;                            
		self.iv_pb_average_dollars            := iv_pb_average_dollars;                               
		self.cs_pct_addrs_le_12mo             := cs_pct_addrs_le_12mo;                                
		self._gong_did_last_seen              := _gong_did_last_seen;                                 
		self._gong_did_first_seen             := _gong_did_first_seen;                                
		self.cs_gong_duration                 := cs_gong_duration;                                    
		self.bureau_adl_vo_fseen_pos          := bureau_adl_vo_fseen_pos;                             
		self.bureau_adl_fseen_vo              := bureau_adl_fseen_vo;                                 
		self._bureau_adl_fseen_vo             := _bureau_adl_fseen_vo;                                
		self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;                               
		self.mth_ver_src_fdate_vo             := mth_ver_src_fdate_vo;                                
		self.bureau_adl_vo_lseen_pos          := bureau_adl_vo_lseen_pos;                             
		self.bureau_adl_lseen_vo              := bureau_adl_lseen_vo;                                 
		self._bureau_adl_lseen_vo             := _bureau_adl_lseen_vo;                                
		self.mth_ver_src_ldate_vo             := mth_ver_src_ldate_vo;                                
		self.mth_ver_src_fdate_vo60           := mth_ver_src_fdate_vo60;                              
		self.mth_ver_src_ldate_vo0            := mth_ver_src_ldate_vo0;                               
		self.bureau_adl_w_lseen_pos           := bureau_adl_w_lseen_pos;                              
		self.bureau_adl_lseen_w               := bureau_adl_lseen_w;                                  
		self._bureau_adl_lseen_w              := _bureau_adl_lseen_w;                                 
		self.mth_ver_src_ldate_w              := mth_ver_src_ldate_w;                                 
		self.mth_ver_src_ldate_w0             := mth_ver_src_ldate_w0;                                
		self.bureau_adl_wp_lseen_pos          := bureau_adl_wp_lseen_pos;                             
		self.bureau_adl_lseen_wp              := bureau_adl_lseen_wp;                                 
		self._bureau_adl_lseen_wp             := _bureau_adl_lseen_wp;                                
		self._src_bureau_adl_lseen            := _src_bureau_adl_lseen;                               
		self.mth_ver_src_ldate_wp             := mth_ver_src_ldate_wp;                                
		self.mth_ver_src_ldate_wp0            := mth_ver_src_ldate_wp0;                               
		self._paw_first_seen                  := _paw_first_seen;                                     
		self.mth_paw_first_seen               := mth_paw_first_seen;                                  
		self.mth_paw_first_seen2              := mth_paw_first_seen2;                                 
		self.ver_src_am                       := ver_src_am;                                          
		self.ver_src_e1                       := ver_src_e1;                                          
		self.ver_src_e2                       := ver_src_e2;                                          
		self.ver_src_e3                       := ver_src_e3;                                          
		self.ver_src_pl                       := ver_src_pl;                                          
		self.ver_src_w                        := ver_src_w;                                           
		self.paw_dead_business_count_gt3      := paw_dead_business_count_gt3;                         
		self.paw_active_phone_count_0         := paw_active_phone_count_0;                            
		self._infutor_first_seen              := _infutor_first_seen;                                 
		self.mth_infutor_first_seen           := mth_infutor_first_seen;                              
		self._infutor_last_seen               := _infutor_last_seen;                                  
		self.mth_infutor_last_seen            := mth_infutor_last_seen;                               
		self.infutor_i                        := infutor_i;                                           
		self.infutor_im                       := infutor_im;                                          
		self.white_pages_adl_wp_fseen_pos     := white_pages_adl_wp_fseen_pos;                        
		self.white_pages_adl_fseen_wp         := white_pages_adl_fseen_wp;                            
		self._white_pages_adl_fseen_wp        := _white_pages_adl_fseen_wp;                           
		self._src_white_pages_adl_fseen       := _src_white_pages_adl_fseen;                          
		self.iv_sr001_m_wp_adl_fs             := iv_sr001_m_wp_adl_fs;                                
		self.src_m_wp_adl_fs                  := src_m_wp_adl_fs;                                     
		self.src_m_hdr_fs                     := src_m_hdr_fs;                                        
		self.source_mod6                      := source_mod6;                                         
		self.iv_sr001_source_profile          := iv_sr001_source_profile;                             
		self.iv_de001_eviction_recency        := iv_de001_eviction_recency;                           
		self.email_src_im                     := email_src_im;                                        
		self.iv_ds001_impulse_count           := iv_ds001_impulse_count;                              
		self.iv_in001_wealth_index            := iv_in001_wealth_index;                               
		self.iv_nap_status                    := iv_nap_status;                                       
		self.iv_prv_addr_assessed_total_val   := iv_prv_addr_assessed_total_val;                      
		self.iv_avg_prop_assess_purch_amt     := iv_avg_prop_assess_purch_amt;                        
		self.iv_credit_seeking                := iv_credit_seeking;                                   
		self.iv_rec_vehx_level                := iv_rec_vehx_level;                                   
		self.iv_attr_rel_liens_recency        := iv_attr_rel_liens_recency;                           
		self.iv_non_derog_count               := iv_non_derog_count;                                  
		self.iv_criminal_x_felony             := iv_criminal_x_felony;                                
		self.iv_pb_total_orders               := iv_pb_total_orders;                                  
		self.cs_outstanding_liens_ct          := cs_outstanding_liens_ct;                             
		self.iv_vp002_phn_disconnected        := iv_vp002_phn_disconnected;                           
		self._header_first_seen               := _header_first_seen;                                  
		self.iv_sr001_m_hdr_fs                := iv_sr001_m_hdr_fs;                                   
		self.iv_bst_addr_mortgage_amount      := iv_bst_addr_mortgage_amount;                         
		self.iv_prv_addr_avm_auto_val         := iv_prv_addr_avm_auto_val;                            
		self.iv_prop_owned_assessed_total     := iv_prop_owned_assessed_total;                        
		self.iv_paw_active_phone_count        := iv_paw_active_phone_count;                           
		self.iv_attr_addrs_recency            := iv_attr_addrs_recency;                               
		self.iv_attr_purchase_recency         := iv_attr_purchase_recency;                            
		self.iv_vp003_phn_invalid             := iv_vp003_phn_invalid;                                
		self.add_ec1                          := add_ec1;                                             
		self.add_ec3                          := add_ec3;                                             
		self.add_ec4                          := add_ec4;                                             
		self.iv_va100_add_problem             := iv_va100_add_problem;                                
		self.iv_pv001_bst_avm_autoval         := iv_pv001_bst_avm_autoval;                            
		self.bureau_addr_tn_fseen_pos         := bureau_addr_tn_fseen_pos;                            
		self.bureau_addr_fseen_tn             := bureau_addr_fseen_tn;                                
		self._bureau_addr_fseen_tn            := _bureau_addr_fseen_tn;                               
		self.bureau_addr_ts_fseen_pos         := bureau_addr_ts_fseen_pos;                            
		self.bureau_addr_fseen_ts             := bureau_addr_fseen_ts;                                
		self._bureau_addr_fseen_ts            := _bureau_addr_fseen_ts;                               
		self.bureau_addr_tu_fseen_pos         := bureau_addr_tu_fseen_pos;                            
		self.bureau_addr_fseen_tu             := bureau_addr_fseen_tu;                                
		self._bureau_addr_fseen_tu            := _bureau_addr_fseen_tu;                               
		self.bureau_addr_en_fseen_pos         := bureau_addr_en_fseen_pos;                            
		self.bureau_addr_fseen_en             := bureau_addr_fseen_en;                                
		self._bureau_addr_fseen_en            := _bureau_addr_fseen_en;                               
		self.bureau_addr_eq_fseen_pos         := bureau_addr_eq_fseen_pos;                            
		self.bureau_addr_fseen_eq             := bureau_addr_fseen_eq;                                
		self._bureau_addr_fseen_eq            := _bureau_addr_fseen_eq;                               
		self._src_bureau_addr_fseen           := _src_bureau_addr_fseen;                              
		self.iv_mos_src_bureau_addr_fseen     := iv_mos_src_bureau_addr_fseen;                        
		self.prv_addr_date_last_seen          := prv_addr_date_last_seen;                             
		self.iv_mos_since_prv_addr_lseen      := iv_mos_since_prv_addr_lseen;                         
		self.cs_bst_to_avg_lres_ratio         := cs_bst_to_avg_lres_ratio;                            
		self.new_derog_a_subscore0            := new_derog_a_subscore0;                               
		self.new_derog_a_subscore1            := new_derog_a_subscore1;                               
		self.new_derog_a_subscore2            := new_derog_a_subscore2;                               
		self.new_derog_a_subscore3            := new_derog_a_subscore3;                               
		self.new_derog_a_subscore4            := new_derog_a_subscore4;                               
		self.new_derog_a_subscore5            := new_derog_a_subscore5;                               
		self.new_derog_a_subscore6            := new_derog_a_subscore6;                               
		self.new_derog_a_subscore7            := new_derog_a_subscore7;                               
		self.new_derog_a_subscore8            := new_derog_a_subscore8;                               
		self.new_derog_a_subscore9            := new_derog_a_subscore9;                               
		self.new_derog_a_subscore10           := new_derog_a_subscore10;                              
		self.new_derog_a_subscore11           := new_derog_a_subscore11;                              
		self.new_derog_a_subscore12           := new_derog_a_subscore12;                              
		self.new_derog_a_subscore13           := new_derog_a_subscore13;                              
		self.new_derog_a_subscore14           := new_derog_a_subscore14;                              
		self.new_derog_a_subscore15           := new_derog_a_subscore15;                              
		self.new_derog_a_subscore16           := new_derog_a_subscore16;                              
		self.new_derog_a_subscore17           := new_derog_a_subscore17;                              
		self.new_derog_a_subscore18           := new_derog_a_subscore18;                              
		self.new_derog_a_subscore19           := new_derog_a_subscore19;                              
		self.new_derog_a_subscore20           := new_derog_a_subscore20;                              
		self.new_derog_a_subscore21           := new_derog_a_subscore21;                              
		self.new_derog_a_subscore22           := new_derog_a_subscore22;                              
		self.new_derog_a_subscore23           := new_derog_a_subscore23;                              
		self.new_derog_a_subscore24           := new_derog_a_subscore24;                              
		self.new_derog_a_subscore25           := new_derog_a_subscore25;                              
		self.new_derog_a_subscore26           := new_derog_a_subscore26;                              
		self.new_derog_a_subscore27           := new_derog_a_subscore27;                              
		self.new_derog_a_subscore28           := new_derog_a_subscore28;                              
		self.new_derog_a_scaledscore          := new_derog_a_scaledscore;                             
		self.new_owner_a_subscore0            := new_owner_a_subscore0;                               
		self.new_owner_a_subscore1            := new_owner_a_subscore1;                               
		self.new_owner_a_subscore2            := new_owner_a_subscore2;                               
		self.new_owner_a_subscore3            := new_owner_a_subscore3;                               
		self.new_owner_a_subscore4            := new_owner_a_subscore4;                               
		self.new_owner_a_subscore5            := new_owner_a_subscore5;                               
		self.new_owner_a_subscore6            := new_owner_a_subscore6;                               
		self.new_owner_a_subscore7            := new_owner_a_subscore7;                               
		self.new_owner_a_subscore8            := new_owner_a_subscore8;                               
		self.new_owner_a_subscore9            := new_owner_a_subscore9;                               
		self.new_owner_a_subscore10           := new_owner_a_subscore10;                              
		self.new_owner_a_subscore11           := new_owner_a_subscore11;                              
		self.new_owner_a_subscore12           := new_owner_a_subscore12;                              
		self.new_owner_a_subscore13           := new_owner_a_subscore13;                              
		self.new_owner_a_subscore14           := new_owner_a_subscore14;                              
		self.new_owner_a_subscore15           := new_owner_a_subscore15;                              
		self.new_owner_a_subscore16           := new_owner_a_subscore16;                              
		self.new_owner_a_subscore17           := new_owner_a_subscore17;                              
		self.new_owner_a_subscore18           := new_owner_a_subscore18;                              
		self.new_owner_a_subscore19           := new_owner_a_subscore19;                              
		self.new_owner_a_subscore20           := new_owner_a_subscore20;                              
		self.new_owner_a_subscore21           := new_owner_a_subscore21;                              
		self.new_owner_a_scaledscore          := new_owner_a_scaledscore;                             
		self.new_other_a_subscore0            := new_other_a_subscore0;                               
		self.new_other_a_subscore1            := new_other_a_subscore1;                               
		self.new_other_a_subscore2            := new_other_a_subscore2;                               
		self.new_other_a_subscore3            := new_other_a_subscore3;                               
		self.new_other_a_subscore4            := new_other_a_subscore4;                               
		self.new_other_a_subscore5            := new_other_a_subscore5;                               
		self.new_other_a_subscore6            := new_other_a_subscore6;                               
		self.new_other_a_subscore7            := new_other_a_subscore7;                               
		self.new_other_a_subscore8            := new_other_a_subscore8;                               
		self.new_other_a_subscore9            := new_other_a_subscore9;                               
		self.new_other_a_subscore10           := new_other_a_subscore10;                              
		self.new_other_a_subscore11           := new_other_a_subscore11;                              
		self.new_other_a_subscore12           := new_other_a_subscore12;                              
		self.new_other_a_subscore13           := new_other_a_subscore13;                              
		self.new_other_a_subscore14           := new_other_a_subscore14;                              
		self.new_other_a_subscore15           := new_other_a_subscore15;                              
		self.new_other_a_subscore16           := new_other_a_subscore16;                              
		self.new_other_a_subscore17           := new_other_a_subscore17;                              
		self.new_other_a_subscore18           := new_other_a_subscore18;                              
		self.new_other_a_subscore19           := new_other_a_subscore19;                              
		self.new_other_a_subscore20           := new_other_a_subscore20;                              
		self.new_other_a_subscore21           := new_other_a_subscore21;                              
		self.new_other_a_subscore22           := new_other_a_subscore22;                              
		self.new_other_a_scaledscore          := new_other_a_scaledscore;                             
		self.source_tot_l2                    := source_tot_l2;                                       
		self.source_tot_li                    := source_tot_li;                                       
		self.source_tot_ds                    := source_tot_ds;                                       
		self.source_tot_ba                    := source_tot_ba;                                       
		self.pk_impulse_count                 := pk_impulse_count;                                    
		self.bs_attr_derog_flag               := bs_attr_derog_flag;                                  
		self.bs_attr_eviction_flag            := bs_attr_eviction_flag;                               
		self.prop_owner                       := prop_owner;                                          
		self.segment_d                        := segment_d;                                           
		self.segment_y                        := segment_y;                                           
		self.segment_o                        := segment_o;                                           
		self._rvg1401_2_0                     := _rvg1401_2_0;                                        
		self.bk_flag                          := bk_flag;                                             
		self.lien_rec_unrel_flag              := lien_rec_unrel_flag;                                 
		self.lien_hist_unrel_flag             := lien_hist_unrel_flag;                                
		self.lien_flag                        := lien_flag;                                           
		self.ssn_deceased                     := ssn_deceased;                                        
		self.scored_222s                      := scored_222s;                                         
		self.rvg1401_2_0                      := rvg1401_2_0;                                         
		self.rc1_d                            := rc1_d;                                               
		self.rc2_d                            := rc2_d;                                               
		self.rc3_d                            := rc3_d;                                               
		self.rc4_d                            := rc4_d;                                               
		self.rc5_d                            := rc5_d;                                               
		self.rc1_o                            := rc1_o;                                               
		self.rc2_o                            := rc2_o;                                               
		self.rc3_o                            := rc3_o;                                               
		self.rc4_o                            := rc4_o;                                               
		self.rc5_o                            := rc5_o;                                               
		self.rc1_oth                          := rc1_oth;                                             
		self.rc2_oth                          := rc2_oth;                                             
		self.rc3_oth                          := rc3_oth;                                             
		self.rc4_oth                          := rc4_oth;                                             
		self.rc5_oth                          := rc5_oth;                                             
		self.glrc25_d                         := glrc25_d;                                            
		self.glrc36_d                         := glrc36_d;                                            
		self.glrc97_d                         := glrc97_d;                                            
		self.glrc98_d                         := glrc98_d;                                            
		self.glrc9c_d                         := glrc9c_d;                                            
		self.glrc9d_d                         := glrc9d_d;                                            
		self.glrc9e_d                         := glrc9e_d;                                            
		self.glrc9h_d                         := glrc9h_d;                                            
		self.glrc9i_d                         := glrc9i_d;                                            
		self.glrc9q_d                         := glrc9q_d;                                            
		self.glrc9r_d                         := glrc9r_d;                                            
		self.glrc9t_d                         := glrc9t_d;                                            
		self.glrc9w_d                         := glrc9w_d;                                            
		// self.glrc9y_d                         := glrc9y_d;                                            
		self.glrcev_d                         := glrcev_d;                                            
		self.glrcms_d                         := glrcms_d;                                            
		self.glrcpv_d                         := glrcpv_d;                                            
		self.glrcbl_d                         := glrcbl_d;                                            
		self.crim_f_d                         := crim_f_d;                                            
		self.lien_f_d                         := lien_f_d;                                            
		self.eviction_f_d                     := eviction_f_d;                                        
		self.impulse_f_d                      := impulse_f_d;                                         
		self.bk_f_d                           := bk_f_d;                                              
		self.derog_contributions_d            := derog_contributions_d;                               
		self.rcvalue97_0_d                    := rcvalue97_0_d;                                       
		self.rcvalue98_0_d                    := rcvalue98_0_d;                                       
		self.rcvalueev_0_d                    := rcvalueev_0_d;                                       
		self.rcvalue9h_0_d                    := rcvalue9h_0_d;                                       
		self.rcvalue9w_0_d                    := rcvalue9w_0_d;                                       
		self.rcvalue9w_d                      := rcvalue9w_d;                                         
		self.rcvalue9q_1_d                    := rcvalue9q_1_d;                                       
		self.rcvalue9q_2_d                    := rcvalue9q_2_d;                                       
		self.rcvalue9q_3_d                    := rcvalue9q_3_d;                                       
		self.rcvalue9q_d                      := rcvalue9q_d;                                         
		self.rcvalue97_1_d                    := rcvalue97_1_d;                                       
		self.rcvalue97_d                      := rcvalue97_d;                                         
		self.rcvalue9c_1_d                    := rcvalue9c_1_d;                                       
		self.rcvalue9d_1_d                    := rcvalue9d_1_d;                                       
		self.rcvalue9d_2_d                    := rcvalue9d_2_d;                                       
		self.rcvalue9c_d                      := rcvalue9c_d;                                         
		self.rcvalue9d_d                      := rcvalue9d_d;                                         
		self.rcvalue9r_1_d                    := rcvalue9r_1_d;                                       
		self.rcvalue9r_2_d                    := rcvalue9r_2_d;                                       
		self.rcvalue9r_3_d                    := rcvalue9r_3_d;                                       
		self.rcvalue9r_d                      := rcvalue9r_d;                                         
		self.rcvaluems_1_d                    := rcvaluems_1_d;                                       
		self.rcvaluems_d                      := rcvaluems_d;                                         
		self.rcvalue98_1_d                    := rcvalue98_1_d;                                       
		self.rcvalue98_d                      := rcvalue98_d;                                         
		self.rcvalue25_1_d                    := rcvalue25_1_d;                                       
		self.rcvalue25_d                      := rcvalue25_d;                                         
		self.rcvaluebl_1_d                    := rcvaluebl_1_d;                                       
		self.rcvaluebl_2_d                    := rcvaluebl_2_d;                                       
		self.rcvaluebl_3_d                    := rcvaluebl_3_d;                                       
		self.rcvaluebl_d                      := rcvaluebl_d;                                         
		self.rcvalue36_1_d                    := rcvalue36_1_d;                                       
		self.rcvalue36_d                      := rcvalue36_d;                                         
		self.rcvalue9y_1_d                    := rcvalue9y_1_d;                                       
		self.rcvalue9y_d                      := rcvalue9y_d;                                         
		self.rcvaluepv_1_d                    := rcvaluepv_1_d;                                       
		self.rcvaluepv_2_d                    := rcvaluepv_2_d;                                       
		self.rcvaluepv_3_d                    := rcvaluepv_3_d;                                       
		self.rcvaluepv_4_d                    := rcvaluepv_4_d;                                       
		self.rcvaluepv_d                      := rcvaluepv_d;                                         
		self.rcvalue9e_1_d                    := rcvalue9e_1_d;                                       
		self.rcvalue9e_2_d                    := rcvalue9e_2_d;                                       
		self.rcvalue9e_3_d                    := rcvalue9e_3_d;                                       
		self.rcvalue9e_4_d                    := rcvalue9e_4_d;                                       
		self.rcvalue9e_d                      := rcvalue9e_d;                                         
		self.rcvalue9h_1_d                    := rcvalue9h_1_d;                                       
		self.rcvalue9h_d                      := rcvalue9h_d;                                         
		self.rcvalue9t_1_d                    := rcvalue9t_1_d;                                       
		self.rcvalue9t_d                      := rcvalue9t_d;                                         
		self.rcvalue9i_1_d                    := rcvalue9i_1_d;                                       
		self.rcvalue9i_d                      := rcvalue9i_d;                                         
		self.rcvalueev_1_d                    := rcvalueev_1_d;                                       
		self.rcvalueev_d                      := rcvalueev_d;                                         
		self.glrc16_o                         := glrc16_o;                                            
		self.glrc25_o                         := glrc25_o;                                            
		self.glrc36_o                         := glrc36_o;                                            
		self.glrc9c_o                         := glrc9c_o;                                            
		self.glrc9d_o                         := glrc9d_o;                                            
		self.glrc9e_o                         := glrc9e_o;                                            
		self.glrc9i_o                         := glrc9i_o;                                            
		self.glrc9q_o                         := glrc9q_o;                                            
		self.glrc9r_o                         := glrc9r_o;                                            
		self.glrc9t_o                         := glrc9t_o;                                            
		// self.glrc9y_o                         := glrc9y_o;                                            
		self.glrcpv_o                         := glrcpv_o;                                            
		self.glrcbl_o                         := glrcbl_o;                                            
		self.rcvalue9q_1_o                    := rcvalue9q_1_o;                                       
		self.rcvalue9q_2_o                    := rcvalue9q_2_o;                                       
		self.rcvalue9q_o                      := rcvalue9q_o;                                         
		self.rcvalue9y_1_o                    := rcvalue9y_1_o;                                       
		self.rcvalue9y_o                      := rcvalue9y_o;                                         
		self.rcvalue36_1_o                    := rcvalue36_1_o;                                       
		self.rcvalue36_o                      := rcvalue36_o;                                         
		self.rcvalue25_1_o                    := rcvalue25_1_o;                                       
		self.rcvalue25_o                      := rcvalue25_o;                                         
		self.rcvaluepv_1_o                    := rcvaluepv_1_o;                                       
		self.rcvaluepv_2_o                    := rcvaluepv_2_o;                                       
		self.rcvaluepv_3_o                    := rcvaluepv_3_o;                                       
		self.rcvaluepv_o                      := rcvaluepv_o;                                         
		self.rcvalue9e_1_o                    := rcvalue9e_1_o;                                       
		self.rcvalue9e_2_o                    := rcvalue9e_2_o;                                       
		self.rcvalue9e_3_o                    := rcvalue9e_3_o;                                       
		self.rcvalue9e_o                      := rcvalue9e_o;                                         
		self.rcvalue16_1_o                    := rcvalue16_1_o;                                       
		self.rcvalue16_o                      := rcvalue16_o;                                         
		self.rcvaluebl_1_o                    := rcvaluebl_1_o;                                       
		self.rcvaluebl_2_o                    := rcvaluebl_2_o;                                       
		self.rcvaluebl_3_o                    := rcvaluebl_3_o;                                       
		self.rcvaluebl_o                      := rcvaluebl_o;                                         
		self.rcvalue9r_1_o                    := rcvalue9r_1_o;                                       
		self.rcvalue9r_2_o                    := rcvalue9r_2_o;                                       
		self.rcvalue9r_3_o                    := rcvalue9r_3_o;                                       
		self.rcvalue9r_o                      := rcvalue9r_o;                                         
		self.rcvalue9i_1_o                    := rcvalue9i_1_o;                                       
		self.rcvalue9i_o                      := rcvalue9i_o;                                         
		self.rcvalue9c_1_o                    := rcvalue9c_1_o;                                       
		self.rcvalue9c_2_o                    := rcvalue9c_2_o;                                       
		self.rcvalue9d_1_o                    := rcvalue9d_1_o;                                       
		self.rcvalue9c_o                      := rcvalue9c_o;                                         
		self.rcvalue9d_o                      := rcvalue9d_o;                                         
		self.rcvalue9t_1_o                    := rcvalue9t_1_o;                                       
		self.rcvalue9t_o                      := rcvalue9t_o;                                         
		self.glrc16_oth                       := glrc16_oth;                                          
		self.glrc36_oth                       := glrc36_oth;                                          
		self.glrc9a_oth                       := glrc9a_oth;                                          
		self.glrc9c_oth                       := glrc9c_oth;                                          
		self.glrc9d_oth                       := glrc9d_oth;                                          
		self.glrc9e_oth                       := glrc9e_oth;                                          
		self.glrc9i_oth                       := glrc9i_oth;                                          
		self.glrc9q_oth                       := glrc9q_oth;                                          
		self.glrc9r_oth                       := glrc9r_oth;                                          
		self.glrc9t_oth                       := glrc9t_oth;                                          
		self.glrc9u_oth                       := glrc9u_oth;                                          
		// self.glrc9y_oth                       := glrc9y_oth;                                          
		self.glrcms_oth                       := glrcms_oth;                                          
		self.glrcpv_oth                       := glrcpv_oth;                                          
		self.glrcbl_oth                       := glrcbl_oth;                                          
		self.rcvalue9a_0_oth                  := rcvalue9a_0_oth;                                     
		self.rcvalue9a_oth                    := rcvalue9a_oth;                                       
		self.rcvalue9q_1_oth                  := rcvalue9q_1_oth;                                     
		self.rcvalue9q_2_oth                  := rcvalue9q_2_oth;                                     
		self.rcvalue9q_oth                    := rcvalue9q_oth;                                       
		self.rcvaluebl_1_oth                  := rcvaluebl_1_oth;                                     
		self.rcvaluebl_oth                    := rcvaluebl_oth;                                       
		self.rcvalue9y_1_oth                  := rcvalue9y_1_oth;                                     
		self.rcvalue9y_oth                    := rcvalue9y_oth;                                       
		self.rcvalue9c_1_oth                  := rcvalue9c_1_oth;                                     
		self.rcvalue9c_2_oth                  := rcvalue9c_2_oth;                                     
		self.rcvalue9d_1_oth                  := rcvalue9d_1_oth;                                     
		self.rcvalue9e_1_oth                  := rcvalue9e_1_oth;                                     
		self.rcvalue9e_2_oth                  := rcvalue9e_2_oth;                                     
		self.rcvalue9e_3_oth                  := rcvalue9e_3_oth;                                     
		self.rcvalue9c_3_oth                  := rcvalue9c_3_oth;                                     
		self.rcvalue9d_2_oth                  := rcvalue9d_2_oth;                                     
		self.rcvalue9e_4_oth                  := rcvalue9e_4_oth;                                     
		self.rcvalue9d_3_oth                  := rcvalue9d_3_oth;                                     
		self.rcvalue9c_oth                    := rcvalue9c_oth;                                       
		self.rcvalue9d_oth                    := rcvalue9d_oth;                                       
		self.rcvalue9e_oth                    := rcvalue9e_oth;                                       
		self.rcvaluems_1_oth                  := rcvaluems_1_oth;                                     
		self.rcvaluems_oth                    := rcvaluems_oth;                                       
		self.rcvalue9r_1_oth                  := rcvalue9r_1_oth;                                     
		self.rcvalue9r_2_oth                  := rcvalue9r_2_oth;                                     
		self.rcvalue9r_3_oth                  := rcvalue9r_3_oth;                                     
		self.rcvalue9r_4_oth                  := rcvalue9r_4_oth;                                     
		self.rcvalue9r_oth                    := rcvalue9r_oth;                                       
		self.rcvaluepv_1_oth                  := rcvaluepv_1_oth;                                     
		self.rcvaluepv_oth                    := rcvaluepv_oth;                                       
		self.rcvalue36_1_oth                  := rcvalue36_1_oth;                                     
		self.rcvalue36_oth                    := rcvalue36_oth;                                       
		self.rcvalue9i_1_oth                  := rcvalue9i_1_oth;                                     
		self.rcvalue9i_oth                    := rcvalue9i_oth;                                       
		self.rcvalue9t_1_oth                  := rcvalue9t_1_oth;                                     
		self.rcvalue9t_oth                    := rcvalue9t_oth;                                       
		self.rcvalue16_1_oth                  := rcvalue16_1_oth;                                     
		self.rcvalue16_oth                    := rcvalue16_oth;                                       
		self.rcvalue9u_1_oth                  := rcvalue9u_1_oth;                                     
		self.rcvalue9u_oth                    := rcvalue9u_oth;                                       
		self.rc1                              := if(reasons[1].hri = '00', '', reasons[1].hri);
		self.rc2                              := if(reasons[2].hri = '00', '', reasons[2].hri);
		self.rc3                              := if(reasons[3].hri = '00', '', reasons[3].hri);
		self.rc4                              := if(reasons[4].hri = '00', '', reasons[4].hri);
		self.rc5                              := if(reasons[5].hri = '00', '', reasons[5].hri);                                              
	#end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		
		self.score := MAP(
											reasons[1].hri IN ['91','92','93','94'] 			=> (STRING3)((INTEGER)reasons[1].hri + 10),
											reasons[1].hri='35' => '100',
											(string3)RVG1401_2_0
										);
END;

		model := project( clam, doModel(left) );

		return model;
END;

