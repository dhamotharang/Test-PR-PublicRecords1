// RVA1311_2 Coastal Credit 4534 - 4.1. shell - FCRA - Military

import risk_indicators, riskwise, RiskWiseFCRA, ut, std, riskview;

export RVA1311_2_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVA_DEBUG := FALSE;

  #if(RVA_DEBUG)
    layout_debug := record
			integer sysdate;                                          
			boolean iv_pots_phone;                                    
			boolean iv_add_apt;                                       
			boolean iv_ssn_deceased;                                  
			boolean iv_riskview_222s;                                 
			string iv_va007_add_vacant;                                  		
			integer _criminal_last_date;                                  		
			integer iv_dc001_mos_since_crim_ls;                           		
			integer iv_de001_eviction_recency;                        
			boolean email_src_im;                                     
			integer iv_ds001_impulse_count;                           
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
			boolean ver_src_ba;                                       
			boolean ver_src_l2;                                       
			boolean ver_src_li;                                       
			boolean ver_src_ds;                                       
			boolean paw_dead_business_count_gt3;                      
			boolean paw_active_phone_count_0;                         
			integer _infutor_first_seen;                              
			integer mth_infutor_first_seen;                           
			integer _infutor_last_seen;                               
			integer mth_infutor_last_seen;                            
			integer infutor_i;                                        
			real infutor_im;                                          
			integer white_pages_adl_wp_fseen_pos;                     
			string white_pages_adl_fseen_wp;                          
			integer _white_pages_adl_fseen_wp;                        
			integer _src_white_pages_adl_fseen;                       
			integer iv_sr001_m_wp_adl_fs;                             
			integer src_m_wp_adl_fs;                                  
			integer _header_first_seen;                               
			integer iv_sr001_m_hdr_fs;                                
			integer src_m_hdr_fs;                                     
			real source_mod6;                                         
			real iv_sr001_source_profile;                             
			integer iv_sr001_source_profile_index;                    
			integer iv_mi001_adlperssn_count;                         
			integer prop_adl_p_fseen_pos;                                 		
			string prop_adl_fseen_p;                                     		
			integer _prop_adl_fseen_p;                                    		
			integer _src_prop_adl_fseen;                                  		
			integer iv_pl001_m_snc_prop_adl_fs;                       
			integer iv_pl002_avg_mo_per_addr;                         
			string iv_input_addr_not_most_recent;                    
			integer bureau_lname_tn_fseen_pos;                            		
			string bureau_lname_fseen_tn;                                		
			integer _bureau_lname_fseen_tn;                               		
			integer bureau_lname_ts_fseen_pos;                            		
			string bureau_lname_fseen_ts;                                		
			integer _bureau_lname_fseen_ts;                               		
			integer bureau_lname_tu_fseen_pos;                            		
			string bureau_lname_fseen_tu;                                		
			integer _bureau_lname_fseen_tu;                               		
			integer bureau_lname_en_fseen_pos;                            		
			string bureau_lname_fseen_en;                                		
			integer _bureau_lname_fseen_en;                               		
			integer bureau_lname_eq_fseen_pos;                            		
			string bureau_lname_fseen_eq;                                		
			integer _bureau_lname_fseen_eq;                               		
			integer _src_bureau_lname_fseen;                              		
			integer iv_mos_src_bureau_lname_fseen;                    
			integer iv_dist_inp_addr_to_prv_addr;                     
			integer iv_phones_per_apt_addr_c6;                        
			integer iv_inq_auto_count12;                              
			integer iv_inq_highriskcredit_recency;                    
			integer iv_inq_communications_count12;                    
			integer iv_non_derog_count;                               
			string iv_criminal_x_felony;                              
			integer _reported_dob;                                    
			real reported_age;                                        
			integer _combined_age;                                    
			boolean evidence_of_college;                              
			string iv_college_attendance_x_age;                       
			integer iv_pb_average_dollars;                                		
			integer _gong_did_first_seen;                             
			integer cs_gong_duration;                                     		
			real mil_subscore0;                                       
			real mil_subscore1;                                       
			real mil_subscore2;                                       
			real mil_subscore3;                                       
			real mil_subscore4;                                       
			real mil_subscore5;                                       
			real mil_subscore6;                                       
			real mil_subscore7;                                       
			real mil_subscore8;                                       
			real mil_subscore9;                                       
			real mil_subscore10;                                      
			real mil_subscore11;                                      
			real mil_subscore12;                                      
			real mil_subscore13;                                      
			real mil_subscore14;                                      
			real mil_subscore15;                                      
			real mil_subscore16;                                      
			real mil_subscore17;                                      
			real mil_subscore18;                                      
			real mil_subscore19;                                      
			real mil_rawscore;                                        
			real mil_lnoddsscore;                                     
			real mil_probscore;                                       
			integer point;                                            
			integer base;                                             
			real odds;                                                
			integer _mil_transformed_score;                               		
			boolean bk_flag;                                          
			boolean lien_rec_unrel_flag;                              
			boolean lien_hist_unrel_flag;                             
			boolean lien_flag;                                        
			boolean ssn_deceased;                                     
			boolean scored_222s;                                      
			INTEGER rva1311_2_0;                                      
			boolean glrc25;                                           
			boolean glrc97;                                           
			boolean glrc99;                                           
			boolean glrc9a;                                           
			boolean glrc9d;                                           
			boolean glrc9e;                                           
			boolean glrc9f;                                           
			boolean glrc9h;                                           
			boolean glrc9i;                                           
			boolean glrc9q;                                           
			boolean glrc9r;                                           
			boolean glrc9y;                                           
			boolean glrcev;                                           
			boolean glrcmi;                                           
			boolean glrcbl;                                           
			real rcvaluebl_1;                                         
			real rcvaluebl_2;                                         
			real rcvaluebl_3;                                         
			real rcvaluebl;                                           
			real rcvalue9h_1;                                         
			real rcvalue9h;                                           
			real rcvalue9q_1;                                         
			real rcvalue9q_2;                                         
			real rcvalue9q;                                           
			integer _gong_did_last_seen;                                  		
			integer iv_mos_since_gong_did_lst_seen;                       		
			real rcvalue9r_1;                                         
			real rcvalue9r_2;                                         
			real rcvalue9r_3;                                         
			real rcvalue9r;                                           
			real rcvalue9f_1;                                         
			real rcvalue9f;                                           
			real rcvalueev_1;                                         
			real rcvalueev;                                           
			real rcvalue99_1;                                         
			real rcvalue99;                                           
			// real rcvalue9y_1;                                         
			// real rcvalue9y;                                           
			real rcvalue9d_1;                                         
			real rcvalue9d;                                           
			real rcvalue9a_1;                                         
			real rcvalue9a;                                           
			real rcvaluemi_1;                                         
			real rcvaluemi;                                           
			real rcvalue25_1;                                         
			real rcvalue25;                                           
			real rcvalue9i_1;                                         
			real rcvalue9i;                                           
			real rcvalue97_1;                                         
			real rcvalue97_2;                                         
			real rcvalue97;                                           
			real rcvalue9e_1;                                         
			real rcvalue9e;                                           
			string rc4;                                               
			string rc2;                                               
			string rc3;                                               
			string rc5;                                               
			string rc1;                                               
                      

			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
			
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_decsflag                      := le.iid.decsflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	combo_addrcount                  := le.iid.combo_addrcount;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_lname_sources                := le.header_summary.ver_lname_sources;
	ver_lname_sources_first_seen     := le.header_summary.ver_lname_sources_first_seen_date;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	age                              := le.name_verification.age;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	dist_a1toa2                      := le.address_verification.distance_in_2_h1;
	dist_a1toa3                      := le.address_verification.distance_in_2_h2;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	avg_mo_per_addr                  := le.address_history_summary.avg_mo_per_addr;
	telcordia_type                   := le.phone_verification.telcordia_type;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	header_first_seen                := le.ssn_verification.header_first_seen;
	adlperssn_count                  := le.ssn_verification.adlperssn_count;
	phones_per_addr_c6               := le.velocity_counters.phones_per_addr_created_6months;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_auto_count12                 := le.acc_logs.auto.count12;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_communications_count12       := le.acc_logs.communications.count12;
	pb_average_dollars               := le.ibehavior.average_amount_per_order;
	paw_first_seen                   := le.employment.first_seen_date;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	infutor_last_seen                := le.infutor_phone.infutor_date_last_seen;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	email_source_list                := le.email_summary.email_source_list;
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
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_count                     := le.bjl.felony_count;
	ams_age                          := le.student.age;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	input_dob_age                    := le.shell_input.age;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	reported_dob                     := le.reported_dob;


	NULL := -999999999;


	BOOLEAN indexw(string source, string target, string delim) :=
		(source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

	sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

	iv_pots_phone := (telcordia_type in ['00', '50', '51', '52', '54']);

	iv_add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

	iv_ssn_deceased := rc_decsflag = '1' or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',');

	iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

	iv_va007_add_vacant := map(
			not(add1_pop)                                                  => ' ',
			trim(trim(add1_advo_address_vacancy, LEFT), LEFT, RIGHT) = 'Y' => '1',
																																				'0');

	_criminal_last_date := common.sas_date((string)(criminal_last_date));

	iv_dc001_mos_since_crim_ls := map(
			not(truedid)               => NULL,
			_criminal_last_date = NULL => -1,
																		min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240));

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
			not(truedid)                           => NULL,
			impulse_count = 0 and email_src_im		 => 1,
																								impulse_count);

	bureau_adl_vo_fseen_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E');

	bureau_adl_fseen_vo := if(bureau_adl_vo_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_vo_fseen_pos, ','));

	_bureau_adl_fseen_vo := common.sas_date((string)(bureau_adl_fseen_vo));

	_src_bureau_adl_fseen := _bureau_adl_fseen_vo;

	mth_ver_src_fdate_vo := map(
			not(truedid)                 => NULL,
			_src_bureau_adl_fseen = NULL => -1,
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

	_paw_first_seen := common.sas_date((string)paw_first_seen);

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

	ver_src_ba := Models.Common.findw_cpp(ver_sources, 'BA' , ', ', 'E') > 0;

	ver_src_l2 := Models.Common.findw_cpp(ver_sources, 'L2' , ', ', 'E') > 0;

	ver_src_li := Models.Common.findw_cpp(ver_sources, 'LI' , ', ', 'E') > 0;

	ver_src_ds := Models.Common.findw_cpp(ver_sources, 'DS' , ', ', 'E') > 0;

	paw_dead_business_count_gt3 := paw_dead_business_count > 3;

	paw_active_phone_count_0 := paw_active_phone_count <= 0;

	_infutor_first_seen := common.sas_date((string)infutor_first_seen);

	mth_infutor_first_seen := map(
			not(truedid)               => NULL,
			_infutor_first_seen = NULL => NULL,
																		if ((sysdate - _infutor_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_first_seen) / (365.25 / 12)), roundup((sysdate - _infutor_first_seen) / (365.25 / 12))));

	_infutor_last_seen := common.sas_date((string)infutor_last_seen);

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

	_header_first_seen := common.sas_date((string)(header_first_seen));

	iv_sr001_m_hdr_fs := map(
			not(truedid)                   => NULL,
			not(_header_first_seen = NULL) => if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))),
																				-1);

	src_m_hdr_fs := map(
			iv_sr001_m_hdr_fs = NULL => 15,
			iv_sr001_m_hdr_fs = -1   => 40,
			iv_sr001_m_hdr_fs >= 260 => 260,
																	iv_sr001_m_hdr_fs);

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

	iv_sr001_source_profile_index := map(
			not(truedid)                  => -1,
			iv_sr001_source_profile <= 9  => 0,
			iv_sr001_source_profile <= 18 => 1,
			iv_sr001_source_profile <= 23 => 2,
			iv_sr001_source_profile <= 35 => 3,
			iv_sr001_source_profile <= 60 => 4,
			iv_sr001_source_profile <= 72 => 5,
			iv_sr001_source_profile <= 79 => 6,
			iv_sr001_source_profile <= 82 => 7,
			iv_sr001_source_profile <= 86 => 8,
																			 9);

	iv_mi001_adlperssn_count := map(
			not((integer) ssnlength > 0)  => NULL,
			adlperssn_count = 0 => 1,
														 adlperssn_count);

	prop_adl_p_fseen_pos := Models.Common.findw_cpp(ver_sources, 'P', ', ', 'E');

	prop_adl_fseen_p := if(prop_adl_p_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, prop_adl_p_fseen_pos, ','));

	_prop_adl_fseen_p := common.sas_date((string)(prop_adl_fseen_p));

	_src_prop_adl_fseen := _prop_adl_fseen_p;

	iv_pl001_m_snc_prop_adl_fs := map(
			not(truedid)               => NULL,
			_src_prop_adl_fseen = NULL => -1,
																		if ((sysdate - _src_prop_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_prop_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_prop_adl_fseen) / (365.25 / 12))));

	iv_pl002_avg_mo_per_addr := map(
			not(truedid)            => NULL,
			avg_mo_per_addr = -9999 => -1,
			unique_addr_count = 0   => -1,
																 avg_mo_per_addr);

	iv_input_addr_not_most_recent := if(not(truedid), '', (string)(integer)rc_input_addr_not_most_recent);

	bureau_lname_tn_fseen_pos := Models.Common.findw_cpp(ver_Lname_sources, 'TN' , ', ', 'E');

	bureau_lname_fseen_tn := if(bureau_lname_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_tn_fseen_pos, ','));

	_bureau_lname_fseen_tn := common.sas_date((string)(bureau_lname_fseen_tn));

	bureau_lname_ts_fseen_pos := Models.Common.findw_cpp(ver_Lname_sources, 'TS' , ', ', 'E');

	bureau_lname_fseen_ts := if(bureau_lname_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_ts_fseen_pos, ','));

	_bureau_lname_fseen_ts := common.sas_date((string)(bureau_lname_fseen_ts));

	bureau_lname_tu_fseen_pos := Models.Common.findw_cpp(ver_Lname_sources, 'TU' , ', ', 'E');

	bureau_lname_fseen_tu := if(bureau_lname_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_tu_fseen_pos, ','));

	_bureau_lname_fseen_tu := common.sas_date((string)(bureau_lname_fseen_tu));

	bureau_lname_en_fseen_pos := Models.Common.findw_cpp(ver_Lname_sources, 'EN' , ', ', 'E');

	bureau_lname_fseen_en := if(bureau_lname_en_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_en_fseen_pos, ','));

	_bureau_lname_fseen_en := common.sas_date((string)(bureau_lname_fseen_en));

	bureau_lname_eq_fseen_pos := Models.Common.findw_cpp(ver_Lname_sources, 'EQ' , ', ', 'E');

	bureau_lname_fseen_eq := if(bureau_lname_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_eq_fseen_pos, ','));

	_bureau_lname_fseen_eq := common.sas_date((string)(bureau_lname_fseen_eq));

	_src_bureau_lname_fseen := if(max(_bureau_lname_fseen_tn, _bureau_lname_fseen_ts, _bureau_lname_fseen_tu, _bureau_lname_fseen_en, _bureau_lname_fseen_eq) = NULL, NULL, min(if(_bureau_lname_fseen_tn = NULL, -NULL, _bureau_lname_fseen_tn), if(_bureau_lname_fseen_ts = NULL, -NULL, _bureau_lname_fseen_ts), if(_bureau_lname_fseen_tu = NULL, -NULL, _bureau_lname_fseen_tu), if(_bureau_lname_fseen_en = NULL, -NULL, _bureau_lname_fseen_en), if(_bureau_lname_fseen_eq = NULL, -NULL, _bureau_lname_fseen_eq)));

	iv_mos_src_bureau_lname_fseen := map(
			not(truedid)                   => NULL,
			_src_bureau_lname_fseen = NULL => -1,
																				if ((sysdate - _src_bureau_lname_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_lname_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_lname_fseen) / (365.25 / 12))));

	iv_dist_inp_addr_to_prv_addr := map(
			not(truedid)     => NULL,
			add1_isbestmatch => dist_a1toa2,
													dist_a1toa3);

	iv_phones_per_apt_addr_c6 := map(
			not(add1_pop)    => NULL,
			(integer) iv_add_apt = 0 => -1,
			(integer) phones_per_addr_c6);

	iv_inq_auto_count12 := if(not(truedid), NULL, inq_auto_count12);

	iv_inq_highriskcredit_recency := map(
			not(truedid)               => NULL,
			(boolean) inq_highRiskCredit_count01 => 1,
			(boolean) inq_highRiskCredit_count03 => 3,
			(boolean) inq_highRiskCredit_count06 => 6,
			(boolean) inq_highRiskCredit_count12 => 12,
			(boolean) inq_highRiskCredit_count24 => 24,
			(boolean) inq_highRiskCredit_count   => 99,
																		0);

	iv_inq_communications_count12 := if(not(truedid), NULL, inq_communications_count12);

	iv_non_derog_count := if(not(truedid), NULL, attr_num_nonderogs);

	iv_criminal_x_felony := if(not(truedid), '   ', trim((string) min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string) min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

	_reported_dob := common.sas_date((string)(reported_dob));

	reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

	_combined_age := map(
			age > 0           => age,
			(integer) input_dob_age > 0 => (integer) input_dob_age,
			inferred_age > 0  		=> inferred_age,
			reported_age > 0  		=> reported_age,
			(integer) ams_age > 0 => (integer) ams_age,
													 -1);

	evidence_of_college := not(ams_college_code = '') or not(ams_college_type = '');

	clg(boolean iscollege, integer age) := if(iscollege, 'Y','N') + (string)((integer)(min(age, 60) / 10) * 10);

	iv_college_attendance_x_age := map(
				not(truedid or dobpop) => '',
				_combined_age = -1     => '',
				clg(evidence_of_college, _combined_age) );

	iv_pb_average_dollars := map(
    not(truedid)              => NULL,
		pb_average_dollars = ''   => -1,
   (integer) pb_average_dollars = NULL => -1,
			(integer) pb_average_dollars);
																 
	_gong_did_last_seen_1 := common.sas_date((string)(gong_did_last_seen));

	_gong_did_first_seen := common.sas_date((string)(gong_did_first_seen));

	cs_gong_duration := map(
			not(truedid)                                                           => NULL,
			not(_gong_did_last_seen_1 = NULL) and not(_gong_did_first_seen = NULL) => if ((_gong_did_last_seen_1 - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((_gong_did_last_seen_1 - _gong_did_first_seen) / (365.25 / 12)), roundup((_gong_did_last_seen_1 - _gong_did_first_seen) / (365.25 / 12))),
																																								-1);

	mil_subscore0 := map(
			NULL < iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr < 1    => 0.429071,
			1 <= iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr < 85     => 0.365498,
			85 <= iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr < 370   => 0.074847,
			370 <= iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr < 9999 => -0.242537,
			9999 <= iv_dist_inp_addr_to_prv_addr                                        => 0.009901,
																																										 0.000000);

	mil_subscore1 := map(
			NULL < iv_phones_per_apt_addr_c6 AND iv_phones_per_apt_addr_c6 < 0 => 0.120210,
			0 <= iv_phones_per_apt_addr_c6 AND iv_phones_per_apt_addr_c6 < 1   => -0.365068,
			1 <= iv_phones_per_apt_addr_c6 AND iv_phones_per_apt_addr_c6 < 2   => -0.180645,
			2 <= iv_phones_per_apt_addr_c6 AND iv_phones_per_apt_addr_c6 < 3   => -0.157452,
			3 <= iv_phones_per_apt_addr_c6                                     => 0.031976,
																																						0.000000);

	mil_subscore2 := map(
			NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => -0.043176,
			1 <= iv_ds001_impulse_count AND iv_ds001_impulse_count < 2   => 0.307560,
			2 <= iv_ds001_impulse_count                                  => 0.973046,
																																			0.000000);

	mil_subscore3 := map(
			NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => -0.039818,
			1 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 6   => 0.649556,
			6 <= iv_inq_highriskcredit_recency                                         => 0.361446,
																																										0.000000);

	mil_subscore4 := map(
			NULL < iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 1 => 0.000000,
			1 <= iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 3   => 0.317243,
			3 <= iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 5   => -0.021189,
			5 <= iv_sr001_source_profile_index                                         => -0.173240,
																																										0.000000);

	mil_subscore5 := map(
			NULL < cs_gong_duration AND cs_gong_duration < 0 => -0.032784,
			0 <= cs_gong_duration AND cs_gong_duration < 1   => 0.481131,
			1 <= cs_gong_duration AND cs_gong_duration < 11  => 0.195579,
			11 <= cs_gong_duration AND cs_gong_duration < 38 => -0.074630,
			38 <= cs_gong_duration AND cs_gong_duration < 54 => -0.120860,
			54 <= cs_gong_duration                           => -0.339130,
																													0.000000);

	mil_subscore6 := map(
			NULL < iv_de001_eviction_recency AND iv_de001_eviction_recency < 3 => -0.034066,
			3 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 6   => 0.869261,
			6 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 25  => 0.371150,
			25 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 37 => 0.068878,
			37 <= iv_de001_eviction_recency                                    => 0.042140,
																																						0.000000);

	mil_subscore7 := map(
			iv_input_addr_not_most_recent = '' => 0.000000,
		  (integer) iv_input_addr_not_most_recent <= 0 => -0.033871,
	    (integer) iv_input_addr_not_most_recent >= 1 => 0.356425,
	                                              -0.000000);
	mil_subscore8 := map(
			iv_pb_average_dollars = NULL 														   => 0.000000,
			iv_pb_average_dollars < 0  																 => 0.046510,
			iv_pb_average_dollars < 26 																 => -0.0771960, 
			26 <= iv_pb_average_dollars                                => -0.276614,
																																	0.000000);

	mil_subscore9 := map(
			NULL < iv_mos_src_bureau_lname_fseen AND iv_mos_src_bureau_lname_fseen < 0  => 0.000000,
			0 <= iv_mos_src_bureau_lname_fseen AND iv_mos_src_bureau_lname_fseen < 84   => 0.076719,
			84 <= iv_mos_src_bureau_lname_fseen AND iv_mos_src_bureau_lname_fseen < 147 => -0.097474,
			147 <= iv_mos_src_bureau_lname_fseen                                        => -0.197333,
																																										 0.000000);

	mil_subscore10 := map(
			NULL < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr < 1 => -0.072794,
			1 <= iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr < 17  => 0.056163,
			17 <= iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr < 68 => -0.012826,
			68 <= iv_pl002_avg_mo_per_addr                                   => -0.380282,
																																					0.000000);

	mil_subscore11 := map(
			NULL < iv_inq_communications_count12 AND iv_inq_communications_count12 < 1 => -0.017934,
			1 <= iv_inq_communications_count12                                         => 0.270159,
																																										0.000000);

	mil_subscore12 := map(
			NULL < iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs < 0 => 0.018355,
			0 <= iv_pl001_m_snc_prop_adl_fs                                      => -0.229382,
																																							0.000000);

	mil_subscore13 := map(
			NULL < iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 2 => -0.038370,
			2 <= iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 3   => 0.014994,
			3 <= iv_mi001_adlperssn_count                                    => 0.168618,
																																					0.000000);

	mil_subscore14 := map(
			iv_va007_add_vacant = '' => 0.000000,
			NULL < (integer) iv_va007_add_vacant AND (integer) iv_va007_add_vacant < 1 => -0.008077,
			1 <= (integer) iv_va007_add_vacant                               => 0.516155,
																																0.000000);

	mil_subscore15 := map(
			(iv_college_attendance_x_age in ['N10', 'N20', 'N30', 'N40', 'N50', 'N60']) => 0.013316,
			(iv_college_attendance_x_age in ['Y10', 'Y20', 'Y30', 'Y40'])               => -0.246484,
																																										 0.000000);

	mil_subscore16 := map(
			(iv_criminal_x_felony in [' '])                        => 0.000000,
			(iv_criminal_x_felony in ['0-0'])                      => -0.010832,
			(iv_criminal_x_felony in ['1-0', '2-0', '3-0'])        => 0.168814,
			(iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1']) => 0.718293,
																																0.000000);

	mil_subscore17 := map(
			NULL < iv_dc001_mos_since_crim_ls AND iv_dc001_mos_since_crim_ls < 0 => -0.009152,
			0 <= iv_dc001_mos_since_crim_ls AND iv_dc001_mos_since_crim_ls < 43  => 0.291792,
			43 <= iv_dc001_mos_since_crim_ls                                     => -0.003398,
																																							0.000000);

	mil_subscore18 := map(
			NULL < iv_inq_auto_count12 AND iv_inq_auto_count12 < 1 => 0.025601,
			1 <= iv_inq_auto_count12                               => -0.054953,
																																0.000000);

	mil_subscore19 := map(
			NULL < iv_non_derog_count AND iv_non_derog_count < 2 => 0.049075,
			2 <= iv_non_derog_count                              => -0.020626,
																															0.000000);

	mil_rawscore := mil_subscore0 +
			mil_subscore1 +
			mil_subscore2 +
			mil_subscore3 +
			mil_subscore4 +
			mil_subscore5 +
			mil_subscore6 +
			mil_subscore7 +
			mil_subscore8 +
			mil_subscore9 +
			mil_subscore10 +
			mil_subscore11 +
			mil_subscore12 +
			mil_subscore13 +
			mil_subscore14 +
			mil_subscore15 +
			mil_subscore16 +
			mil_subscore17 +
			mil_subscore18 +
			mil_subscore19;

	mil_lnoddsscore := mil_rawscore + -1.279073;

	mil_probscore := exp(mil_lnoddsscore) / (1 + exp(mil_lnoddsscore));

	point := 40;

	base := 700;

	odds := .2419 / .7581;

	_mil_transformed_score := round(point * (-mil_lnoddsscore + ln(odds)) / ln(2) + base);

	rva1311_2_0_1 := min(if(max(round(_mil_transformed_score), 501) = NULL, -NULL, max(round(_mil_transformed_score), 501)), 900);

	bk_flag := (rc_bansflag in ['1', '2']) or ver_src_BA or bankrupt or filing_count > 0 or bk_recent_count > 0;

	lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

	lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

	lien_flag := ver_src_L2 or lien_rec_unrel_flag or lien_hist_unrel_flag;

	ssn_deceased := rc_decsflag = '1' or ver_src_ds;

	scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, 
		sum(if(property_owned_total = NULL, 0, property_owned_total), 
			if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR 
			(90 <= combo_dobscore AND 
			combo_dobscore <= 100 or
			(integer) input_dob_match_level >= 7 or 
			lien_flag or criminal_count > 0 or
			bk_flag or 
			ssn_deceased  or 
			truedid);

	rva1311_2_0 := map(
			ssn_deceased 		                                                                => 200,
			(nas_summary <= 4 and nap_summary <= 4 and add1_naprop <= 3 AND not(scored_222s)) or le.truedid=false => 222,
																																												 rva1311_2_0_1);

	glrc25 := combo_addrcount < 1;

	glrc97 := criminal_count > 0;

	glrc99 := (integer) iv_input_addr_not_most_recent > 0;

	glrc9a := iv_pl001_m_snc_prop_adl_fs < 0;

	glrc9d := truedid and iv_pl002_avg_mo_per_addr != -1;

	glrc9e := truedid and attr_num_nonderogs < 2;

	glrc9f := truedid and not(gong_did_last_seen = '') and not(gong_did_first_seen = '');

	glrc9h := iv_ds001_impulse_count > 0;

	glrc9i := age < 30 and not(evidence_of_college);

	glrc9q := iv_inq_highriskcredit_recency > 0 or iv_inq_communications_count12 > 0;

	glrc9r := truedid;

	// glrc9y := truedid and iv_pb_average_dollars > -1;

	glrcev := attr_eviction_count > 0;

	glrcmi := adlperssn_count > 1;

	glrcbl := 0;

	rcvaluebl_1 := -(-0.242537 - mil_subscore0);

	rcvaluebl_2 := -(-0.365068 - mil_subscore1);

	rcvaluebl_3 := -(-0.054953 - mil_subscore18);

	rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3)));

	rcvalue9h_1 := -(-0.043176 - mil_subscore2);

	rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

	rcvalue9q_1 := -(-0.039818 - mil_subscore3);

	rcvalue9q_2 := -(-0.017934 - mil_subscore11);

	rcvalue9q := (integer)glrc9q * if(max(rcvalue9q_1, rcvalue9q_2) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1), if(rcvalue9q_2 = NULL, 0, rcvalue9q_2)));

	_gong_did_last_seen := common.sas_date((string)(gong_did_last_seen));

	iv_mos_since_gong_did_lst_seen_1 := if(not(truedid), NULL, NULL);

	iv_mos_since_gong_did_lst_seen := if(not(_gong_did_last_seen = NULL), if ((sysdate - _gong_did_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_last_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_last_seen) / (365.25 / 12))), -1);

	rcvalue9r_1 := -(-0.173240 - mil_subscore4);

	rcvalue9r_2 := if(iv_mos_since_gong_did_lst_seen > 3, -(-0.339130 - mil_subscore5), 0);

	rcvalue9r_3 := -(-0.197333 - mil_subscore9);

	rcvalue9r := (integer)glrc9r * if(max(rcvalue9r_1, rcvalue9r_2, rcvalue9r_3) = NULL, NULL, sum(if(rcvalue9r_1 = NULL, 0, rcvalue9r_1), if(rcvalue9r_2 = NULL, 0, rcvalue9r_2), if(rcvalue9r_3 = NULL, 0, rcvalue9r_3)));

	rcvalue9f_1 := if(iv_mos_since_gong_did_lst_seen <= 3, -(-0.339130 - mil_subscore5), 0);

	rcvalue9f := (integer)glrc9f * if(max(rcvalue9f_1) = NULL, NULL, sum(if(rcvalue9f_1 = NULL, 0, rcvalue9f_1)));

	rcvalueev_1 := -(-0.034066 - mil_subscore6);

	rcvalueev := (integer)glrcev * if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

	rcvalue99_1 := -(-0.033871 - mil_subscore7);

	rcvalue99 := (integer)glrc99 * if(max(rcvalue99_1) = NULL, NULL, sum(if(rcvalue99_1 = NULL, 0, rcvalue99_1)));

	// rcvalue9y_1 := -(-0.276614 - mil_subscore8);

	// rcvalue9y := (integer)glrc9y * if(max(rcvalue9y_1) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1)));

	rcvalue9d_1 := -(-0.380282 - mil_subscore10);

	rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

	rcvalue9a_1 := -(-0.229382 - mil_subscore12);

	rcvalue9a := (integer)glrc9a * if(max(rcvalue9a_1) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1)));

	rcvaluemi_1 := -(-0.038370 - mil_subscore13);

	rcvaluemi := (integer)glrcmi * if(max(rcvaluemi_1) = NULL, NULL, sum(if(rcvaluemi_1 = NULL, 0, rcvaluemi_1)));

	rcvalue25_1 := -(-0.008077 - mil_subscore14);

	rcvalue25 := (integer)glrc25 * if(max(rcvalue25_1) = NULL, NULL, sum(if(rcvalue25_1 = NULL, 0, rcvalue25_1)));

	rcvalue9i_1 := -(-0.246484 - mil_subscore15);

	rcvalue9i := (integer)glrc9i * if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));

	rcvalue97_1 := -(-0.010832 - mil_subscore16);

	rcvalue97_2 := -(-0.009152 - mil_subscore17);

	rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1, rcvalue97_2) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1), if(rcvalue97_2 = NULL, 0, rcvalue97_2)));

	rcvalue9e_1 := -(-0.020626 - mil_subscore19);

	rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1)));

		//*************************************************************************************//
		// I have no idea how the reason code logic gets implemented in ECL, so everything below 
		// probably needs to get changed or replaced.  The methodology for creating the reason codes is
		// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
		// that model code for guidance on implementing reason codes. 
		//*************************************************************************************//

			ds_layout := {STRING rc, REAL value};

			rc_dataset := DATASET([
				{'BL', RCValueBL},
				{'9H', RCValue9H},
				{'9Q', RCValue9Q},
				{'9R', RCValue9R},
				{'9F', RCValue9F},
				{'EV', RCValueEV},
				{'99', RCValue99},
				// {'9Y', RCValue9Y},
				{'9D', RCValue9D},
				{'9A', RCValue9A},
				{'MI', RCValueMI},
				{'25', RCValue25},
				{'9I', RCValue9I},
				{'97', RCValue97},
				{'9E', RCValue9E}
				], ds_layout)(value > 0);

		rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes
		rcs_top := if(count(rcs_top4(rc != ''))=0, DATASET([{'36', NULL}], ds_layout), rcs_top4);
		
		rcs_9q := rcs_top & if(glrc9q AND (count(rcs_top4(rc='9Q')) =0) AND inq_count12 > 0, ROW({'9Q', NULL}, ds_layout));

		rcs_override := MAP(
												rva1311_2_0 = 200 => DATASET([{'02', NULL}], ds_layout),
												rva1311_2_0 = 222 => DATASET([{'9X', NULL}], ds_layout),
												rva1311_2_0 = 900 => DATASET([{'  ', NULL}], ds_layout),
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
							inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
							rcs_final
							);
						
		zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
		
		reasons := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes


	//Intermediate variables
		#if(RVA_DEBUG)
			 self.clam														 := le;
			 self.sysdate                          := sysdate;                                         
			 self.iv_pots_phone                    := iv_pots_phone;                                   
			 self.iv_add_apt                       := iv_add_apt;                                      
			 self.iv_ssn_deceased                  := iv_ssn_deceased;                                 
			 self.iv_riskview_222s                 := iv_riskview_222s;                                
			 self.iv_va007_add_vacant              := iv_va007_add_vacant;                             
			 self._criminal_last_date              := _criminal_last_date;                             
			 self.iv_dc001_mos_since_crim_ls       := iv_dc001_mos_since_crim_ls;                      
			 self.iv_de001_eviction_recency        := iv_de001_eviction_recency;                       
			 self.email_src_im                     := email_src_im;                                    
			 self.iv_ds001_impulse_count           := iv_ds001_impulse_count;                          
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
			 self.ver_src_ba                       := ver_src_ba;                                      
			 self.ver_src_l2                       := ver_src_l2;                                      
			 self.ver_src_li                       := ver_src_li;                                      
			 self.ver_src_ds                       := ver_src_ds;                                      
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
			 self._header_first_seen               := _header_first_seen;                              
			 self.iv_sr001_m_hdr_fs                := iv_sr001_m_hdr_fs;                               
			 self.src_m_hdr_fs                     := src_m_hdr_fs;                                    
			 self.source_mod6                      := source_mod6;                                     
			 self.iv_sr001_source_profile          := iv_sr001_source_profile;                         
			 self.iv_sr001_source_profile_index    := iv_sr001_source_profile_index;                   
			 self.iv_mi001_adlperssn_count         := iv_mi001_adlperssn_count;                        
			 self.prop_adl_p_fseen_pos             := prop_adl_p_fseen_pos;                            
			 self.prop_adl_fseen_p                 := prop_adl_fseen_p;                                
			 self._prop_adl_fseen_p                := _prop_adl_fseen_p;                               
			 self._src_prop_adl_fseen              := _src_prop_adl_fseen;                             
			 self.iv_pl001_m_snc_prop_adl_fs       := iv_pl001_m_snc_prop_adl_fs;                      
			 self.iv_pl002_avg_mo_per_addr         := iv_pl002_avg_mo_per_addr;                        
			 self.iv_input_addr_not_most_recent    := iv_input_addr_not_most_recent;                   
			 self.bureau_lname_tn_fseen_pos        := bureau_lname_tn_fseen_pos;                       
			 self.bureau_lname_fseen_tn            := bureau_lname_fseen_tn;                           
			 self._bureau_lname_fseen_tn           := _bureau_lname_fseen_tn;                          
			 self.bureau_lname_ts_fseen_pos        := bureau_lname_ts_fseen_pos;                       
			 self.bureau_lname_fseen_ts            := bureau_lname_fseen_ts;                           
			 self._bureau_lname_fseen_ts           := _bureau_lname_fseen_ts;                          
			 self.bureau_lname_tu_fseen_pos        := bureau_lname_tu_fseen_pos;                       
			 self.bureau_lname_fseen_tu            := bureau_lname_fseen_tu;                           
			 self._bureau_lname_fseen_tu           := _bureau_lname_fseen_tu;                          
			 self.bureau_lname_en_fseen_pos        := bureau_lname_en_fseen_pos;                       
			 self.bureau_lname_fseen_en            := bureau_lname_fseen_en;                           
			 self._bureau_lname_fseen_en           := _bureau_lname_fseen_en;                          
			 self.bureau_lname_eq_fseen_pos        := bureau_lname_eq_fseen_pos;                       
			 self.bureau_lname_fseen_eq            := bureau_lname_fseen_eq;                           
			 self._bureau_lname_fseen_eq           := _bureau_lname_fseen_eq;                          
			 self._src_bureau_lname_fseen          := _src_bureau_lname_fseen;                         
			 self.iv_mos_src_bureau_lname_fseen    := iv_mos_src_bureau_lname_fseen;                   
			 self.iv_dist_inp_addr_to_prv_addr     := iv_dist_inp_addr_to_prv_addr;                    
			 self.iv_phones_per_apt_addr_c6        := iv_phones_per_apt_addr_c6;                       
			 self.iv_inq_auto_count12              := iv_inq_auto_count12;                             
			 self.iv_inq_highriskcredit_recency    := iv_inq_highriskcredit_recency;                   
			 self.iv_inq_communications_count12    := iv_inq_communications_count12;                   
			 self.iv_non_derog_count               := iv_non_derog_count;                              
			 self.iv_criminal_x_felony             := iv_criminal_x_felony;                            
			 self._reported_dob                    := _reported_dob;                                   
			 self.reported_age                     := reported_age;                                    
			 self._combined_age                    := _combined_age;                                   
			 self.evidence_of_college              := evidence_of_college;                             
			 self.iv_college_attendance_x_age      := iv_college_attendance_x_age;                     
			 self.iv_pb_average_dollars            := iv_pb_average_dollars;                           
			 self._gong_did_first_seen             := _gong_did_first_seen;                            
			 self.cs_gong_duration                 := cs_gong_duration;                                
			 self.mil_subscore0                    := mil_subscore0;                                   
			 self.mil_subscore1                    := mil_subscore1;                                   
			 self.mil_subscore2                    := mil_subscore2;                                   
			 self.mil_subscore3                    := mil_subscore3;                                   
			 self.mil_subscore4                    := mil_subscore4;                                   
			 self.mil_subscore5                    := mil_subscore5;                                   
			 self.mil_subscore6                    := mil_subscore6;                                   
			 self.mil_subscore7                    := mil_subscore7;                                   
			 self.mil_subscore8                    := mil_subscore8;                                   
			 self.mil_subscore9                    := mil_subscore9;                                   
			 self.mil_subscore10                   := mil_subscore10;                                  
			 self.mil_subscore11                   := mil_subscore11;                                  
			 self.mil_subscore12                   := mil_subscore12;                                  
			 self.mil_subscore13                   := mil_subscore13;                                  
			 self.mil_subscore14                   := mil_subscore14;                                  
			 self.mil_subscore15                   := mil_subscore15;                                  
			 self.mil_subscore16                   := mil_subscore16;                                  
			 self.mil_subscore17                   := mil_subscore17;                                  
			 self.mil_subscore18                   := mil_subscore18;                                  
			 self.mil_subscore19                   := mil_subscore19;                                  
			 self.mil_rawscore                     := mil_rawscore;                                    
			 self.mil_lnoddsscore                  := mil_lnoddsscore;                                 
			 self.mil_probscore                    := mil_probscore;                                   
			 self.point                            := point;                                           
			 self.base                             := base;                                            
			 self.odds                             := odds;                                            
			 self._mil_transformed_score           := _mil_transformed_score;                          
			 self.bk_flag                          := bk_flag;                                         
			 self.lien_rec_unrel_flag              := lien_rec_unrel_flag;                             
			 self.lien_hist_unrel_flag             := lien_hist_unrel_flag;                            
			 self.lien_flag                        := lien_flag;                                       
			 self.ssn_deceased                     := ssn_deceased;                                    
			 self.scored_222s                      := scored_222s;                                     
			 self.rva1311_2_0                      := rva1311_2_0;                                     
			 self.glrc25                           := glrc25;                                          
			 self.glrc97                           := glrc97;                                          
			 self.glrc99                           := glrc99;                                          
			 self.glrc9a                           := glrc9a;                                          
			 self.glrc9d                           := glrc9d;                                          
			 self.glrc9e                           := glrc9e;                                          
			 self.glrc9f                           := glrc9f;                                          
			 self.glrc9h                           := glrc9h;                                          
			 self.glrc9i                           := glrc9i;                                          
			 self.glrc9q                           := glrc9q;                                          
			 self.glrc9r                           := glrc9r;                                          
			 // self.glrc9y                           := glrc9y;                                          
			 self.glrcev                           := glrcev;                                          
			 self.glrcmi                           := glrcmi;                                          
			 self.glrcbl                           := glrcbl;                                          
			 self.rcvaluebl_1                      := rcvaluebl_1;                                     
			 self.rcvaluebl_2                      := rcvaluebl_2;                                     
			 self.rcvaluebl_3                      := rcvaluebl_3;                                     
			 self.rcvaluebl                        := rcvaluebl;                                       
			 self.rcvalue9h_1                      := rcvalue9h_1;                                     
			 self.rcvalue9h                        := rcvalue9h;                                       
			 self.rcvalue9q_1                      := rcvalue9q_1;                                     
			 self.rcvalue9q_2                      := rcvalue9q_2;                                     
			 self.rcvalue9q                        := rcvalue9q;                                       
			 self._gong_did_last_seen              := _gong_did_last_seen;                             
			 self.iv_mos_since_gong_did_lst_seen   := iv_mos_since_gong_did_lst_seen;                  
			 self.rcvalue9r_1                      := rcvalue9r_1;                                     
			 self.rcvalue9r_2                      := rcvalue9r_2;                                     
			 self.rcvalue9r_3                      := rcvalue9r_3;                                     
			 self.rcvalue9r                        := rcvalue9r;                                       
			 self.rcvalue9f_1                      := rcvalue9f_1;                                     
			 self.rcvalue9f                        := rcvalue9f;                                       
			 self.rcvalueev_1                      := rcvalueev_1;                                     
			 self.rcvalueev                        := rcvalueev;                                       
			 self.rcvalue99_1                      := rcvalue99_1;                                     
			 self.rcvalue99                        := rcvalue99;                                       
			 // self.rcvalue9y_1                      := rcvalue9y_1;                                     
			 // self.rcvalue9y                        := rcvalue9y;                                       
			 self.rcvalue9d_1                      := rcvalue9d_1;                                     
			 self.rcvalue9d                        := rcvalue9d;                                       
			 self.rcvalue9a_1                      := rcvalue9a_1;                                     
			 self.rcvalue9a                        := rcvalue9a;                                       
			 self.rcvaluemi_1                      := rcvaluemi_1;                                     
			 self.rcvaluemi                        := rcvaluemi;                                       
			 self.rcvalue25_1                      := rcvalue25_1;                                     
			 self.rcvalue25                        := rcvalue25;                                       
			 self.rcvalue9i_1                      := rcvalue9i_1;                                     
			 self.rcvalue9i                        := rcvalue9i;                                       
			 self.rcvalue97_1                      := rcvalue97_1;                                     
			 self.rcvalue97_2                      := rcvalue97_2;                                     
			 self.rcvalue97                        := rcvalue97;                                       
			 self.rcvalue9e_1                      := rcvalue9e_1;                                     
			 self.rcvalue9e                        := rcvalue9e;                                       
		   self.rc1                              := rcs_override[1].rc;
		   self.rc2                              := rcs_override[2].rc;
		   self.rc3                              := rcs_override[3].rc;
			 self.rc4                              := rcs_override[4].rc;
			 self.rc5                              := rcs_override[5].rc;                                         

		#end
			SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																								SELF.hri := if(LEFT.hri='', '00', left.hri),
																								SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																						));
			self.seq := le.seq;
			
			self.score := MAP(
												reasons[1].hri IN ['91','92','93','94'] 			=> (STRING3)((INTEGER)reasons[1].hri + 10),
												reasons[1].hri='35' => '100',
												(string3)rva1311_2_0
											);
		END;

		model := project( clam, doModel(left) );

		return model;
	END;

