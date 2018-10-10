// RVA1311_3 RVA1311_3 â€“ SAFCO â€“ Southern Auto Finance Company project 4489 - 4.1. shell - FCRA

import risk_indicators, riskwise, RiskWiseFCRA, ut, std, riskview;

export RVA1311_3_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVA_DEBUG := FALSE;

  #if(RVA_DEBUG)
    layout_debug := record
      integer sysdate;                                             
			boolean email_src_im;                                        
			integer iv_ds001_impulse_count;                              
			integer iv_inp_addr_source_count;                            
			string iv_inp_own_prop_x_addr_naprop;                       
			integer bst_addr_avm_auto_val_3;                             
			integer bst_addr_avm_auto_val_1;                             
			real iv_bst_addr_avm_pct_change_2yr;                      
			integer iv_prop_sold_purchase_count;                         
			integer iv_addrs_5yr;                                        
			integer _gong_did_first_seen;                                
			integer iv_mos_since_gong_did_fst_seen;                      
			integer iv_inq_highriskcredit_count12;                       
			integer iv_eviction_count;                                   
			integer iv_liens_unrel_sc_ct;                                
			integer iv_criminal_count;                                   
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
			integer iv_bst_addr_source_count;                            
			integer bst_addr_date_first_seen;                            
			integer iv_mos_since_bst_addr_fseen;                         
			string bst_addr_source_ct;                                  
			integer bst_addr_fseen_mos;                                  
			integer new_bst_addr_var;                                    
			real subscore0;                                           
			real subscore1;                                           
			real subscore2;                                           
			real subscore3;                                           
			real subscore4;                                           
			real subscore5;                                           
			real subscore6;                                           
			real subscore7;                                           
			real subscore8;                                           
			real subscore9;                                           
			real subscore10;                                          
			real subscore11;                                          
			real subscore12;                                          
			real rawscore;                                            
			real lnoddsscore;                                         
			integer base;                                                
			real odds;                                                
			integer point;                                               
			boolean ssn_deceased;                                        
			boolean iv_riskview_222s;                                    
			integer rva1311_3_0;                                         
			boolean glrc97;                                              
			boolean glrc98;                                              
			boolean glrc9a;                                              
			boolean glrc9d;                                              
			boolean glrc9e;                                              
			boolean glrc9f;                                              
			boolean glrc9h;                                              
			boolean glrc9j;                                              
			boolean glrc9p;                                              
			boolean glrcev;                                              
			boolean glrcpv;                                              
			boolean glrcbl;                                              
			real rcvalue97_1;                                         
			real rcvalue97;                                           
			real rcvalue98_1;                                         
			real rcvalue98;                                           
			real rcvalue9a_1;                                         
			real rcvalue9a_2;                                         
			real rcvalue9a;                                           
			real rcvalue9d_1;                                         
			real rcvalue9d;                                           
			real rcvalue9e_1;                                         
			real rcvalue9e_2;                                         
			real rcvalue9e;                                           
			real rcvalue9f_1;                                         
			real rcvalue9f;                                           
			real rcvalue9h_1;                                         
			real rcvalue9h;                                           
			real rcvalue9j_1;                                         
			real rcvalue9j;                                           
			real rcvalue9p_1;                                         
			real rcvalue9p;                                           
			real rcvalueev_1;                                         
			real rcvalueev;                                           
			real rcvaluepv_1;                                         
			real rcvaluepv;                                           
			string rc1;                                                 
			string rc4;                                                 
			string rc2;                                                 
			string rc3;                                                 
			string rc5;                                                 
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
			
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
	truedid                          := le.truedid;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_decsflag                      := le.iid.decsflag;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	addrpop                          := le.input_validation.address;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_avm_automated_valuation_3   := le.avm.input_address_information.avm_automated_valuation3;
	add1_source_count                := le.address_verification.input_address_information.source_count;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	property_sold_purchase_count     := le.address_verification.sold.property_owned_purchase_count;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add2_avm_automated_valuation_3   := le.avm.address_history_1.avm_automated_valuation3;
	add2_source_count                := le.address_verification.address_history_1.source_count;
	add2_date_first_seen             := le.address_verification.address_history_1.date_first_seen;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	header_first_seen                := le.ssn_verification.header_first_seen;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	paw_first_seen                   := le.employment.first_seen_date;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	infutor_last_seen                := le.infutor_phone.infutor_date_last_seen;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	email_source_list                := le.email_summary.email_source_list;
	attr_eviction_count              := le.bjl.eviction_count;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	criminal_count                   := le.bjl.criminal_count;

	NULL := -999999999;

	BOOLEAN indexw(string source, string target, string delim) :=
		(source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

	sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

	email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

	iv_ds001_impulse_count := map(
			not(truedid)                           => NULL,
			impulse_count = 0 and email_src_im => 1,
																								impulse_count);

	iv_inp_addr_source_count := if(not(add1_pop), NULL, add1_source_count);

	iv_inp_own_prop_x_addr_naprop := map(
			not(add1_pop)            => '  ',
			property_owned_total > 0 => (string)(add1_naprop + 10),
																	('0' + (string)add1_naprop)[-2..]);															

	iv_bst_addr_avm_pct_change_2yr_1 := map(
			not(truedid)     => NULL,
			add1_isbestmatch => NULL,
													NULL);

	bst_addr_avm_auto_val_3 := map(
			not(truedid)     => NULL,
			add1_isbestmatch => add1_avm_automated_valuation_3,
													add2_avm_automated_valuation_3);

	bst_addr_avm_auto_val_1 := map(
			not(truedid)     => NULL,
			add1_isbestmatch => add1_avm_automated_valuation,
													add2_avm_automated_valuation);

	iv_bst_addr_avm_pct_change_2yr := if(bst_addr_avm_auto_val_1 > 0 and bst_addr_avm_auto_val_3 > 0, bst_addr_avm_auto_val_1 / bst_addr_avm_auto_val_3, NULL);

	iv_prop_sold_purchase_count := if(not(truedid or add1_pop), NULL, property_sold_purchase_count);

	iv_addrs_5yr := map(
			not(truedid)          => NULL,
			unique_addr_count = 0 => -1,
															 addrs_5yr);

	_gong_did_first_seen := common.sas_date((string)(gong_did_first_seen));

	iv_mos_since_gong_did_fst_seen := map(
			not(truedid)                     => NULL,
			not(_gong_did_first_seen = NULL) => if ((sysdate - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_first_seen) / (365.25 / 12))),
																					-1);

	iv_inq_highriskcredit_count12 := if(not(truedid), NULL, inq_highRiskCredit_count12);

	iv_eviction_count := if(not(truedid), NULL, attr_eviction_count);

	iv_liens_unrel_sc_ct := if(not(truedid), NULL, liens_unrel_SC_ct);

	iv_criminal_count := if(not(truedid), NULL, criminal_count);

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

	iv_bst_addr_source_count := map(
			not(truedid)     => NULL,
			add1_isbestmatch => add1_source_count,
													add2_source_count);

	bst_addr_date_first_seen := if(add1_isbestmatch, common.sas_date((string)(add1_date_first_seen)), common.sas_date((string)(add2_date_first_seen)));

	iv_mos_since_bst_addr_fseen := map(
			not(truedid)                    => NULL,
			bst_addr_date_first_seen = NULL => -1,
																				 if ((sysdate - bst_addr_date_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - bst_addr_date_first_seen) / (365.25 / 12)), roundup((sysdate - bst_addr_date_first_seen) / (365.25 / 12))));

	bst_addr_source_ct := map(
			iv_bst_addr_source_count > 4  => '5+',
			iv_bst_addr_source_count > -1 => '<5',
																			 '');//'.'

	bst_addr_fseen_mos := map(
			iv_mos_since_bst_addr_fseen > 192 => 1,
			iv_mos_since_bst_addr_fseen > 96  => 2,
			iv_mos_since_bst_addr_fseen > 12  => 3,
			iv_mos_since_bst_addr_fseen > 6   => 4,
			iv_mos_since_bst_addr_fseen > -1  => 5,
																					NULL);

	new_bst_addr_var := map(
			bst_addr_source_ct = '5+' and bst_addr_fseen_mos != NULL => 1,
			bst_addr_source_ct = '<5' and bst_addr_fseen_mos = 1    => 2,
			bst_addr_source_ct = '<5' and bst_addr_fseen_mos = 2    => 3,
			bst_addr_source_ct = '<5' and bst_addr_fseen_mos = 3    => 4,
			bst_addr_source_ct = '<5' and bst_addr_fseen_mos = 4    => 5,
			bst_addr_source_ct = '<5' and bst_addr_fseen_mos = 5    => 6,
																																 NULL);

	subscore0 := map(
			NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.068713,
			1 <= iv_ds001_impulse_count AND iv_ds001_impulse_count < 2   => -0.289144,
			2 <= iv_ds001_impulse_count                                  => -0.678366,
																																			-0.000000);

	subscore1 := map(
			NULL < iv_eviction_count AND iv_eviction_count < 1 => 0.066667,
			1 <= iv_eviction_count AND iv_eviction_count < 3   => -0.274181,
			3 <= iv_eviction_count                             => -0.439386,
																														-0.000000);

	subscore2 := map(
			NULL < iv_sr001_source_profile AND iv_sr001_source_profile < 70.6  => -0.094960,
			70.6 <= iv_sr001_source_profile AND iv_sr001_source_profile < 82.9 => 0.073295,
			82.9 <= iv_sr001_source_profile                                    => 0.370114,
																																						-0.000000);

	subscore3 := map(
			NULL < iv_addrs_5yr AND iv_addrs_5yr < 0 => -0.000000,
			0 <= iv_addrs_5yr AND iv_addrs_5yr < 2   => 0.156022,
			2 <= iv_addrs_5yr AND iv_addrs_5yr < 5   => 0.025403,
			5 <= iv_addrs_5yr AND iv_addrs_5yr < 6   => -0.083137,
			6 <= iv_addrs_5yr AND iv_addrs_5yr < 7   => -0.171105,
			7 <= iv_addrs_5yr                        => -0.272672,
																									-0.000000);

	subscore4 := map(
			NULL < iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 1 => 0.037763,
			1 <= iv_inq_highriskcredit_count12                                         => -0.416891,
																																										0.000000);

	subscore5 := map(
			NULL < iv_inp_addr_source_count AND iv_inp_addr_source_count < 1 => -0.202206,
			1 <= iv_inp_addr_source_count AND iv_inp_addr_source_count < 5   => 0.060331,
			5 <= iv_inp_addr_source_count                                    => 0.109030,
																																					-0.000000);

	subscore6 := map(
			NULL < iv_criminal_count AND iv_criminal_count < 1 => 0.031372,
			1 <= iv_criminal_count                             => -0.411373,
																														0.000000);

	subscore7 := map(
			(iv_inp_own_prop_x_addr_naprop in [' '])                    => 0.000000,
			(iv_inp_own_prop_x_addr_naprop in ['01'])                   => -0.087766,
			(iv_inp_own_prop_x_addr_naprop in ['11'])                   => -0.083428,
			(iv_inp_own_prop_x_addr_naprop in ['00', '02', '03', '04']) => 0.025929,
			(iv_inp_own_prop_x_addr_naprop in ['10', '12', '13', '14']) => 0.188680,
																																		 0.000000);

	subscore8 := map(
			NULL < new_bst_addr_var AND new_bst_addr_var < 3 => 0.200533,
			3 <= new_bst_addr_var AND new_bst_addr_var < 4   => 0.089414,
			4 <= new_bst_addr_var AND new_bst_addr_var < 5   => 0.017344,
			5 <= new_bst_addr_var AND new_bst_addr_var < 6   => -0.023530,
			6 <= new_bst_addr_var                            => -0.143862,
																													-0.000000);

	subscore9 := map(
			NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 0 => -0.003995,
			0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 8   => -0.446362,
			8 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 44  => -0.101592,
			44 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 65 => -0.007126,
			65 <= iv_mos_since_gong_did_fst_seen                                         => 0.098220,
																																											-0.000000);

	subscore10 := map(
			NULL < iv_prop_sold_purchase_count AND iv_prop_sold_purchase_count < 1 => -0.024822,
			1 <= iv_prop_sold_purchase_count                                       => 0.312599,
																																								0.000000);

	subscore11 := map(
			NULL < iv_bst_addr_avm_pct_change_2yr AND iv_bst_addr_avm_pct_change_2yr < 0.46  => -0.309639,
			0.46 <= iv_bst_addr_avm_pct_change_2yr AND iv_bst_addr_avm_pct_change_2yr < 0.78 => -0.073191,
			0.78 <= iv_bst_addr_avm_pct_change_2yr                                           => 0.082378,
																																													-0.000000);

	subscore12 := map(
			NULL < iv_liens_unrel_sc_ct AND iv_liens_unrel_sc_ct < 1 => 0.019055,
			1 <= iv_liens_unrel_sc_ct                                => -0.250933,
																																	-0.000000);

	rawscore := subscore0 +
			subscore1 +
			subscore2 +
			subscore3 +
			subscore4 +
			subscore5 +
			subscore6 +
			subscore7 +
			subscore8 +
			subscore9 +
			subscore10 +
			subscore11 +
			subscore12;

	lnoddsscore := rawscore + 1.379565;

	base := 700;

	odds := (1 - 0.2189) / 0.2189;

	point := 40;

	ssn_deceased := rc_decsflag = '1' or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') ;

	iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

	rva1311_3_0 := map(
			ssn_deceased     => 200,
			iv_riskview_222s => 222,
													min(if(max(round(point * (lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));

	glrc97 := criminal_count > 0;

	glrc98 := liens_unrel_SC_ct > 0;

	glrc9a := property_owned_total = 0 and add1_naprop != 4;

	glrc9d := truedid and addrs_5yr > 1;

	glrc9e := truedid and add1_pop and add1_source_count < 5;

	glrc9f := truedid ;

	glrc9h := impulse_count > 0;

	glrc9j := truedid and 0 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 216;

	glrc9p := inq_highRiskCredit_count12 > 0;

	glrcev := attr_eviction_count > 0;

	glrcpv := truedid and addrpop and 0 < add1_avm_automated_valuation AND add1_avm_automated_valuation < 150000;

	glrcbl := 0;

	rcvalue97_1 := (integer)glrc97 * (0.031372 - subscore6);

	rcvalue97 := if(max(rcvalue97_1) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1)));

	rcvalue98_1 := (integer)glrc98 * (0.019055 - subscore12);

	rcvalue98 := if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));

	rcvalue9a_1 := (integer)glrc9a * (0.188680 - subscore7);

	rcvalue9a_2 := (integer)glrc9a * (0.312599 - subscore10);

	rcvalue9a := if(max(rcvalue9a_1, rcvalue9a_2) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1), if(rcvalue9a_2 = NULL, 0, rcvalue9a_2)));

	rcvalue9d_1 := (integer)glrc9d * (0.156022 - subscore3);

	rcvalue9d := if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

	rcvalue9e_1 := (integer)glrc9e * (0.109030 - subscore5);

	rcvalue9e_2 := (integer)glrc9e * (0.200533 - subscore8);

	rcvalue9e := if(max(rcvalue9e_1, rcvalue9e_2) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1), if(rcvalue9e_2 = NULL, 0, rcvalue9e_2)));

	rcvalue9f_1 := (integer)glrc9f * (0.098220 - subscore9);

	rcvalue9f := if(max(rcvalue9f_1) = NULL, NULL, sum(if(rcvalue9f_1 = NULL, 0, rcvalue9f_1)));

	rcvalue9h_1 := (integer)glrc9h * (0.068713 - subscore0);

	rcvalue9h := if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

	rcvalue9j_1 := (integer)glrc9j * (0.370114 - subscore2);

	rcvalue9j := if(max(rcvalue9j_1) = NULL, NULL, sum(if(rcvalue9j_1 = NULL, 0, rcvalue9j_1)));

	rcvalue9p_1 := (integer)glrc9p * (0.037763 - subscore4);

	rcvalue9p := if(max(rcvalue9p_1) = NULL, NULL, sum(if(rcvalue9p_1 = NULL, 0, rcvalue9p_1)));

	rcvalueev_1 := (integer)glrcev * (0.066667 - subscore1);

	rcvalueev := if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

	rcvaluepv_1 := (integer)glrcpv * (0.082378 - subscore11);

	rcvaluepv := if(max(rcvaluepv_1) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1)));
	
	//*************************************************************************************//
	// I have no idea how the reason code logic gets implemented in ECL, so everything below 
	// probably needs to get changed or replaced.  The methodology for creating the reason codes is
	// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
	// that model code for guidance on implementing reason codes. 
	//*************************************************************************************//
			ds_layout := {STRING rc, REAL value};

			rc_dataset := DATASET([
				{'9H', RCValue9H},
				{'PV', RCValuePV},
				{'9D', RCValue9D},
				{'9A', RCValue9A},
				{'9J', RCValue9J},
				{'9E', RCValue9E},
				{'EV', RCValueEV},
				{'98', RCValue98},
				{'97', RCValue97},
				{'9P', RCValue9P},
				{'9F', RCValue9F}
				], ds_layout)(value > 0);

		rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes
		rcs_top := if(count(rcs_top4(rc != ''))=0, DATASET([{'36', NULL}], ds_layout), rcs_top4);
		
		rcs_9p := rcs_top & if(glrc9p and (count(rcs_top4(rc='9P')) =0) AND inq_highRiskCredit_count12 > 0, ROW({'9P', NULL}, ds_layout));

		rcs_override := MAP(
												rva1311_3_0 = 200 => DATASET([{'02', NULL}], ds_layout),
												rva1311_3_0 = 222 => DATASET([{'9X', NULL}], ds_layout),
												rva1311_3_0 = 900 => DATASET([{'  ', NULL}], ds_layout),
												(500 < RVA1311_3_0) and (RVA1311_3_0 <= 720) and 
													(rcs_9p[1].rc!='36') and (rcs_9p[1].rc!='') and (rcs_9p[2].rc='') => DATASET([{rcs_9p[1].rc, NULL}, {'36', NULL}], ds_layout),
												rcs_9p
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
			 self.clam 														 := le;
			 self.sysdate                          := sysdate;                        
			 self.email_src_im                     := email_src_im;                   
			 self.iv_ds001_impulse_count           := iv_ds001_impulse_count;         
			 self.iv_inp_addr_source_count         := iv_inp_addr_source_count;       
			 self.iv_inp_own_prop_x_addr_naprop    := iv_inp_own_prop_x_addr_naprop;  
			 self.bst_addr_avm_auto_val_3          := bst_addr_avm_auto_val_3;        
			 self.bst_addr_avm_auto_val_1          := bst_addr_avm_auto_val_1;        
			 self.iv_bst_addr_avm_pct_change_2yr   := iv_bst_addr_avm_pct_change_2yr; 
			 self.iv_prop_sold_purchase_count      := iv_prop_sold_purchase_count;    
			 self.iv_addrs_5yr                     := iv_addrs_5yr;                   
			 self._gong_did_first_seen             := _gong_did_first_seen;           
			 self.iv_mos_since_gong_did_fst_seen   := iv_mos_since_gong_did_fst_seen; 
			 self.iv_inq_highriskcredit_count12    := iv_inq_highriskcredit_count12;  
			 self.iv_eviction_count                := iv_eviction_count;              
			 self.iv_liens_unrel_sc_ct             := iv_liens_unrel_sc_ct;           
			 self.iv_criminal_count                := iv_criminal_count;              
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
			 self._header_first_seen               := _header_first_seen;             
			 self.iv_sr001_m_hdr_fs                := iv_sr001_m_hdr_fs;              
			 self.src_m_hdr_fs                     := src_m_hdr_fs;                   
			 self.source_mod6                      := source_mod6;                    
			 self.iv_sr001_source_profile          := iv_sr001_source_profile;        
			 self.iv_bst_addr_source_count         := iv_bst_addr_source_count;       
			 self.bst_addr_date_first_seen         := bst_addr_date_first_seen;       
			 self.iv_mos_since_bst_addr_fseen      := iv_mos_since_bst_addr_fseen;    
			 self.bst_addr_source_ct               := bst_addr_source_ct;             
			 self.bst_addr_fseen_mos               := bst_addr_fseen_mos;             
			 self.new_bst_addr_var                 := new_bst_addr_var;               
			 self.subscore0                        := subscore0;                      
			 self.subscore1                        := subscore1;                      
			 self.subscore2                        := subscore2;                      
			 self.subscore3                        := subscore3;                      
			 self.subscore4                        := subscore4;                      
			 self.subscore5                        := subscore5;                      
			 self.subscore6                        := subscore6;                      
			 self.subscore7                        := subscore7;                      
			 self.subscore8                        := subscore8;                      
			 self.subscore9                        := subscore9;                      
			 self.subscore10                       := subscore10;                     
			 self.subscore11                       := subscore11;                     
			 self.subscore12                       := subscore12;                     
			 self.rawscore                         := rawscore;                       
			 self.lnoddsscore                      := lnoddsscore;                    
			 self.base                             := base;                           
			 self.odds                             := odds;                           
			 self.point                            := point;                          
			 self.ssn_deceased                     := ssn_deceased;                   
			 self.iv_riskview_222s                 := iv_riskview_222s;               
			 self.rva1311_3_0                      := rva1311_3_0;                    
			 self.glrc97                           := glrc97;                         
			 self.glrc98                           := glrc98;                         
			 self.glrc9a                           := glrc9a;                         
			 self.glrc9d                           := glrc9d;                         
			 self.glrc9e                           := glrc9e;                         
			 self.glrc9f                           := glrc9f;                         
			 self.glrc9h                           := glrc9h;                         
			 self.glrc9j                           := glrc9j;                         
			 self.glrc9p                           := glrc9p;                         
			 self.glrcev                           := glrcev;                         
			 self.glrcpv                           := glrcpv;                         
			 self.glrcbl                           := glrcbl;                         
			 self.rcvalue97_1                      := rcvalue97_1;                    
			 self.rcvalue97                        := rcvalue97;                      
			 self.rcvalue98_1                      := rcvalue98_1;                    
			 self.rcvalue98                        := rcvalue98;                      
			 self.rcvalue9a_1                      := rcvalue9a_1;                    
			 self.rcvalue9a_2                      := rcvalue9a_2;                    
			 self.rcvalue9a                        := rcvalue9a;                      
			 self.rcvalue9d_1                      := rcvalue9d_1;                    
			 self.rcvalue9d                        := rcvalue9d;                      
			 self.rcvalue9e_1                      := rcvalue9e_1;                    
			 self.rcvalue9e_2                      := rcvalue9e_2;                    
			 self.rcvalue9e                        := rcvalue9e;                      
			 self.rcvalue9f_1                      := rcvalue9f_1;                    
			 self.rcvalue9f                        := rcvalue9f;                      
			 self.rcvalue9h_1                      := rcvalue9h_1;                    
			 self.rcvalue9h                        := rcvalue9h;                      
			 self.rcvalue9j_1                      := rcvalue9j_1;                    
			 self.rcvalue9j                        := rcvalue9j;                      
			 self.rcvalue9p_1                      := rcvalue9p_1;                    
			 self.rcvalue9p                        := rcvalue9p;                      
			 self.rcvalueev_1                      := rcvalueev_1;                    
			 self.rcvalueev                        := rcvalueev;                      
			 self.rcvaluepv_1                      := rcvaluepv_1;                    
			 self.rcvaluepv                        := rcvaluepv;                                                                                  
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
												(string3)rva1311_3_0
											);
		END;

		model := project( clam, doModel(left) );

		return model;
	END;

