// RVR1311_1_0 - Target - 4.1. shell - FCRA 

import risk_indicators, riskwise, RiskWiseFCRA, ut, std, riskview;

export RVR1311_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVR_DEBUG := false;

  #if(RVR_DEBUG)
    layout_debug := record
			integer sysdate;
			string iv_vs099_addr_not_ver_w_ssn;                                    
			string iv_db001_bankruptcy;                                            
			boolean email_src_im;                                                   
			integer iv_ds001_impulse_count;                                         
			integer _in_dob;                                                        
			real yr_in_dob;                                                      
			integer yr_in_dob_int;                                                  
			integer age_estimate;                                                   
			integer iv_ag001_age;                                                   
			integer iv_pv001_bst_avm_autoval;                                       
			integer prop_adl_p_lseen_pos;                                           
			string prop_adl_lseen_p;                                               
			integer _prop_adl_lseen_p;                                              
			integer _src_prop_adl_lseen;                                            
			integer iv_mos_src_property_adl_lseen;                                  
			integer iv_inq_recency;                                                 
			integer iv_inq_highriskcredit_count12;                                  
			integer iv_paw_source_count;                                            
			boolean ver_phn_inf;                                                    
			boolean ver_phn_nap;                                                    
			integer inf_phn_ver_lvl;                                                
			integer nap_phn_ver_lvl;                                                
			string iv_nap_phn_ver_x_inf_phn_ver;                                   
			integer iv_attr_addrs_recency;                                          
			integer iv_unreleased_liens_ct;                                         
			integer iv_criminal_count;                                              
			integer iv_ms001_ssns_per_adl;                                          
			integer iv_pv001_inp_avm_autoval;                                       
			string iv_po001_inp_addr_naprop;                                       
			integer prop_adl_p_count_pos;                                           
			integer prop_adl_count_p;                                               
			integer _src_prop_adl_count;                                            
			integer iv_src_property_adl_count;                                      
			string iv_best_match_address;                                          
			integer iv_prv_addr_avm_auto_val;                                       
			integer iv_ssns_per_adl_c6;                                             
			integer iv_email_domain_edu_count;                                      
			string iv_ams_college_tier;                                            
			integer iv_pb_total_orders;                                             
			string iv_in001_wealth_index;                                          
			integer iv_iq001_inq_count12;                                           
			integer iv_addrs_10yr;                                                  
			integer iv_max_ids_per_addr;                                            
			string iv_ams_college_code;                                            
			real sum_dols;                                                       
			real pct_offline_dols;                                               
			real pct_retail_dols;                                                
			real pct_online_dols;                                                
			string iv_pb_profile;                                                  
			real d_subscore0;                                                    
			real d_subscore1;                                                    
			real d_subscore2;                                                    
			real d_subscore3;                                                    
			real d_subscore4;                                                    
			real d_subscore5;                                                    
			real d_subscore6;                                                    
			real d_subscore7;                                                    
			real d_subscore8;                                                    
			real d_subscore9;                                                    
			real d_subscore10;                                                   
			real d_subscore11;                                                   
			real d_subscore12;                                                   
			real d_rawscore;                                                     
			real d_lnoddsscore;                                                  
			real y_subscore0;                                                    
			real y_subscore1;                                                    
			real y_subscore2;                                                    
			real y_subscore3;                                                    
			real y_subscore4;                                                    
			real y_subscore5;                                                    
			real y_subscore6;                                                    
			real y_subscore7;                                                    
			real y_subscore8;                                                    
			real y_subscore9;                                                    
			real y_subscore10;                                                   
			real y_subscore11;                                                   
			real y_subscore12;                                                   
			real y_rawscore;                                                     
			real y_lnoddsscore;                                                  
			real o_subscore0;                                                    
			real o_subscore1;                                                    
			real o_subscore2;                                                    
			real o_subscore3;                                                    
			real o_subscore4;                                                    
			real o_subscore5;                                                    
			real o_subscore6;                                                    
			real o_subscore7;                                                    
			real o_subscore8;                                                    
			real o_subscore9;                                                    
			real o_subscore10;                                                   
			real o_subscore11;                                                   
			real o_rawscore;                                                     
			real o_lnoddsscore;                                                  
			integer bureau_adl_eq_fseen_pos;                                        
			string bureau_adl_fseen_eq;                                            
			integer _bureau_adl_fseen_eq;                                           
			integer mos_bureau_adl_fs;                                              
			string ln_segment;                                                     
			real lnoddsscore;                                                    
			integer base;                                                           
			real odds;                                                           
			integer point;                                                          
			boolean ssn_deceased;                                                   
			boolean iv_riskview_222s;                                               
			integer rvr1311_1;                                                      
			boolean propsrc;                                                        
			boolean d_glrc25;                                                       
			boolean d_glrc97;                                                       
			boolean d_glrc98;                                                       
			boolean d_glrc9a;                                                       
			boolean d_glrc9b;                                                       
			boolean d_glrc9d;                                                       
			boolean d_glrc9e;                                                       
			boolean d_glrc9h;                                                       
			boolean d_glrc9p;                                                       
			boolean d_glrc9q;                                                       
			boolean d_glrc9r;                                                       
			boolean d_glrc9w;                                                       
			boolean d_glrcpv;                                                       
			boolean d_glrcbl;                                                       
			boolean y_glrc99;                                                       
			boolean y_glrc9a;                                                       
			boolean y_glrc9b;                                                       
			boolean y_glrc9e;                                                       
			boolean y_glrc9i;                                                       
			boolean y_glrc9q;                                                       
			boolean y_glrc9r;                                                       
			boolean y_glrc9v;                                                       
			// boolean y_glrc9y;                                                       
			boolean y_glrcms;                                                       
			boolean y_glrcpv;                                                       
			boolean y_glrcbl;                                                       
			boolean o_glrc9a;                                                       
			boolean o_glrc9b;                                                       
			boolean o_glrc9d;                                                       
			boolean o_glrc9e;                                                       
			boolean o_glrc9i;                                                       
			boolean o_glrc9q;                                                       
			boolean o_glrc9r;    
			boolean o_glrcms;                                                       
			boolean o_glrcpv;    
			// boolean o_glrc9y;
			boolean o_glrcbl;                                                       
			boolean bk;                                                             
			boolean eviction;                                                       
			boolean lien;                                                           
			boolean pdl;                                                            
			integer derogsum;                                                       
			real s_glrc97;                                                       
			real s_glrc98;                                                       
			real s_glrc9h;                                                       
			boolean s_glrc9r;                                                       
			real s_glrc9w;                                                       
			real s_glrcev;                                                       
			real rcvalue25_1;                                                    
			real rcvalue25;                                                      
			real rcvalue97_1;                                                    
			real rcvalue97_2;                                                    
			real rcvalue97;                                                      
			real rcvalue98_1;                                                    
			real rcvalue98_2;                                                    
			real rcvalue98;                                                      
			real rcvalue99_1;                                                    
			real rcvalue99;                                                      
			real rcvalue9a_1;                                                    
			real rcvalue9a_2;                                                    
			real rcvalue9a_3;                                                    
			real rcvalue9a_4;                                                    
			real rcvalue9a;                                                      
			real rcvalue9b_1;                                                    
			real rcvalue9b_2;                                                    
			real rcvalue9b_3;                                                    
			real rcvalue9b;                                                      
			real rcvalue9d_1;                                                    
			real rcvalue9d_2;                                                    
			real rcvalue9d;                                                      
			real rcvalue9e_1;                                                    
			real rcvalue9e_2;                                                    
			real rcvalue9e_3;
			real rcvalue9e_4;
			real rcvalue9e_5;
			real rcvalue9e;                                                      
			real rcvalue9h_1;                                                    
			real rcvalue9h_2;                                                    
			real rcvalue9h;                                                      
			//real rcvalue9i_1;                                                    
			//real rcvalue9i_2;                                                    
			//real rcvalue9i;                                                      
			real rcvalue9p_1;                                                    
			real rcvalue9p;                                                      
			real rcvalue9q_1;                                                    
			real rcvalue9q_2;                                                    
			real rcvalue9q_3;                                                    
			real rcvalue9q;                                                      
			real rcvalue9r_1;                                                    
			real rcvalue9r_2;                                                    
			real rcvalue9r_3;                                                    
			real rcvalue9r_4;                                                    
			real rcvalue9r;                                                      
			real rcvalue9v_1;                                                    
			real rcvalue9v;                                                      
			real rcvalue9w_1;                                                    
			real rcvalue9w_2;                                                    
			real rcvalue9w;                                                      
			// real rcvalue9y_1;                                                    
			// real rcvalue9y_2;                                                    
			// real rcvalue9y;                                                      
			real rcvalueev_1;                                                    
			real rcvalueev;                                                      
			real rcvaluems_1;                                                    
			real rcvaluems_2;                                                    
			real rcvaluems;                                                      
			real rcvaluepv_1;                                                    
			real rcvaluepv_2;                                                    
			real rcvaluepv_3;                                                    
			real rcvaluepv_4;                                                    
			real rcvaluepv;                                                      
			real rcvaluebl_1;                                                    
			real rcvaluebl_2;                                                    
			real rcvaluebl_3;                                                    
			real rcvaluebl_4;                                                    
			real rcvaluebl;                                                      
			boolean glrc9q;                                                         
			string rc1;                                                            
			string rc4;                                                            
			string rc2;                                                            
			string rc3;                                                            
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
			
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
	
	truedid                          := le.truedid;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_decsflag                      := le.iid.decsflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_source_count                := le.address_verification.input_address_information.source_count;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	add2_isbestmatch                 := le.address_verification.address_history_1.isbestmatch;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add3_isbestmatch                 := le.address_verification.address_history_2.isbestmatch;
	add3_avm_automated_valuation     := le.avm.address_history_2.avm_automated_valuation;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	adls_per_addr                    := le.velocity_counters.adls_per_addr;
	ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	inq_count01                      := le.acc_logs.inquiries.count01;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count06                      := le.acc_logs.inquiries.count06;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	pb_number_of_sources             := le.ibehavior.number_of_sources;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	pb_offline_dollars               := le.ibehavior.offline_dollars;
	pb_online_dollars                := le.ibehavior.online_dollars;
	pb_retail_dollars                := le.ibehavior.retail_dollars;
	paw_source_count                 := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	email_domain_edu_count           := le.email_summary.email_domain_edu_ct;
	email_source_list                := le.email_summary.email_source_list;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_eviction_count              := le.bjl.eviction_count;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	ams_college_code                 := le.student.college_code;
	ams_college_tier                 := le.student.college_tier;
	wealth_index                     := le.wealth_indicator;
	inferred_age                     := le.inferred_age;


	NULL := -999999999;


	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


	BOOLEAN indexw(string source, string target, string delim) :=
		(source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

	sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

	iv_vs099_addr_not_ver_w_ssn := if(not(truedid and (integer) ssnlength > 0), ' ', (string)(integer)(nas_summary in [4, 7, 9]));

	iv_db001_bankruptcy := map(
			not(truedid or (integer) ssnlength > 0)                                                                                               => '                 ',
			(disposition in ['Discharge NA', 'Discharged'])                                                                             => '1 - BK Discharged',
			(disposition in ['Dismissed'])                                                                                              => '2 - BK Dismissed ',
			(rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => '3 - BK Other     ',
																																																																		 '0 - No BK        ');

	email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

	iv_ds001_impulse_count := map(
			not(truedid)                           => NULL,
			impulse_count = 0 and email_src_im  => 1,
																								impulse_count);

	_in_dob := common.sas_date((string)(in_dob));

	yr_in_dob := map(in_dob = '' => -1, in_dob = '0' => 0, _in_dob = NULL => 0, (sysdate - _in_dob) / 365.25);

	yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

	age_estimate := map(
			yr_in_dob_int > 0 => yr_in_dob_int,
			inferred_age > 0  => inferred_age,
													 -1);

	iv_ag001_age := if(not(truedid or dobpop), NULL, min(62, if(age_estimate = NULL, -NULL, age_estimate)));

	iv_pv001_bst_avm_autoval := map(
			not(truedid)     => NULL,
			add1_isbestmatch => add1_avm_automated_valuation,
													add2_avm_automated_valuation);

	prop_adl_p_lseen_pos := Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E');

	prop_adl_lseen_p := if(prop_adl_p_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, prop_adl_p_lseen_pos, ','));

	_prop_adl_lseen_p := common.sas_date((string)(prop_adl_lseen_p));

	_src_prop_adl_lseen := _prop_adl_lseen_p;

	iv_mos_src_property_adl_lseen := map(
			not(truedid)               => NULL,
			_src_prop_adl_lseen = NULL => -1,
																		if ((sysdate - _src_prop_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_prop_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_prop_adl_lseen) / (365.25 / 12))));

	iv_inq_recency := map(
			not(truedid) => NULL,
			(boolean) inq_count01  => 1,
			(boolean) inq_count03  => 3,
			(boolean) inq_count06  => 6,
			(boolean) inq_count12  => 12,
											0);

	iv_inq_highriskcredit_count12 := if(not(truedid), NULL, inq_highRiskCredit_count12);

	iv_paw_source_count := if(not(truedid), NULL, paw_source_count);

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

	iv_unreleased_liens_ct := if(not(truedid), NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))));

	iv_criminal_count := if(not(truedid), NULL, criminal_count);

	iv_ms001_ssns_per_adl := map(
			not(truedid)     => NULL,
			ssns_per_adl = 0 => 1,
													ssns_per_adl);

	iv_pv001_inp_avm_autoval := if(not(add1_pop), NULL, add1_avm_automated_valuation);

	iv_po001_inp_addr_naprop := if(not(add1_pop), ' ', (string)add1_naprop);

	prop_adl_p_count_pos := Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E');

	prop_adl_count_p := if(prop_adl_p_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, prop_adl_p_count_pos, ','));

	_src_prop_adl_count := max(prop_adl_count_p, (real)0);

	iv_src_property_adl_count := map(
			not(truedid)               => NULL,
			_src_prop_adl_count = NULL => -1,
																		_src_prop_adl_count);

	iv_best_match_address := map(
			add1_isbestmatch => 'ADD1',
			add2_isbestmatch => 'ADD2',
			add3_isbestmatch => 'ADD3',
													'NONE');

	iv_prv_addr_avm_auto_val := map(
			not(truedid)     => NULL,
			add1_isbestmatch => add2_avm_automated_valuation,
													add3_avm_automated_valuation);

	iv_ssns_per_adl_c6 := if(not(truedid), NULL, ssns_per_adl_c6);

	iv_email_domain_edu_count := if(not(truedid), NULL, email_domain_EDU_count);

	iv_ams_college_tier := map(
			not(truedid)            => '  ',
			ams_college_tier = ''		=> '-1',
																 ams_college_tier);

	iv_pb_total_orders := map(
			not(truedid)           => NULL,
			pb_total_orders = '' => -1,
			(integer)	pb_total_orders);

	iv_in001_wealth_index := if(not(truedid), ' ', (string)wealth_index);

	iv_iq001_inq_count12 := if(not(truedid), NULL, inq_count12);

	iv_addrs_10yr := map(
			not(truedid)          => NULL,
			unique_addr_count = 0 => -1,
															 addrs_10yr);

	iv_max_ids_per_addr := if(not(add1_pop), NULL, max(adls_per_addr, ssns_per_addr));

	iv_ams_college_code := map(
			not(truedid)            => '  ',
			(string) ams_college_code = '' => '-1',
																 trim((string)ams_college_code, LEFT));

	sum_dols := if(max((real) pb_offline_dollars, 
				(real) pb_online_dollars, 
				(real) pb_retail_dollars) = NULL, 
				NULL, sum(if((real) pb_offline_dollars = NULL, 0, 
				(real) pb_offline_dollars), if((real) pb_online_dollars = NULL, 0, (real) pb_online_dollars), 
				if((real) pb_retail_dollars = NULL, 0, (real) pb_retail_dollars)));

	pct_offline_dols := if(sum_dols > 0, (real) pb_offline_dollars / sum_dols, -1);

	pct_retail_dols := if(sum_dols > 0, (real) pb_retail_dollars / sum_dols, -1);

	pct_online_dols := if(sum_dols > 0, (real) pb_online_dollars / sum_dols, -1);

	iv_pb_profile := map(
			not(truedid)                => '                 ',
			pb_number_of_sources = '' => '0 No Purch Data  ',
			pct_offline_dols > .50      => '1 Offline Shopper',
			pct_online_dols > .50       => '2 Online Shopper ',
			pct_retail_dols > .50       => '3 Retail Shopper ',
																		 '4 Other');

	d_subscore0 := map(
			NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.133021,
			1 <= iv_ds001_impulse_count                                  => -0.990463,
																																			-0.000000);

	d_subscore1 := map(
			NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen < 0 => -0.241781,
			0 <= iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen < 36  => 0.624982,
			36 <= iv_mos_src_property_adl_lseen                                        => 0.021128,
																																										-0.000000);

	d_subscore2 := map(
			NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 1 => 0.279534,
			1 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 2   => -0.065659,
			2 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 3   => -0.234266,
			3 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 4   => -0.549698,
			4 <= iv_unreleased_liens_ct                                  => -0.615978,
																																			0.000000);

	d_subscore3 := map(
			NULL < iv_ag001_age AND iv_ag001_age < 18 => 0.000000,
			18 <= iv_ag001_age AND iv_ag001_age < 25  => -0.811813,
			25 <= iv_ag001_age AND iv_ag001_age < 30  => -0.276408,
			30 <= iv_ag001_age AND iv_ag001_age < 37  => -0.109162,
			37 <= iv_ag001_age AND iv_ag001_age < 44  => -0.107658,
			44 <= iv_ag001_age AND iv_ag001_age < 51  => 0.014617,
			51 <= iv_ag001_age AND iv_ag001_age < 59  => 0.151325,
			59 <= iv_ag001_age                        => 0.573178,
																									 0.000000);

	d_subscore4 := map(
			(iv_inq_recency in [1, 3])  => -0.620445,
			(iv_inq_recency in [6, 12]) => -0.213190,
			(iv_inq_recency in [0])     => 0.104982,
																		 0.000000);

	d_subscore5 := map(
			NULL < iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 1 => 0.058434,
			1 <= iv_inq_highriskcredit_count12                                         => -1.117576,
																																										0.000000);

	d_subscore6 := map(
			(iv_attr_addrs_recency in [1])                        => -0.326056,
			(iv_attr_addrs_recency in [3])                        => -0.163903,
			(iv_attr_addrs_recency in [12])                       => -0.113089,
			(iv_attr_addrs_recency in [24])                       => 0.154265,
			(iv_attr_addrs_recency in [0, 36, 60, 120, 180, 999]) => 0.225267,
																															 -0.000000);

	d_subscore7 := map(
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1', '1-3', '2-0', '2-1']) => -0.150674,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3', '3-1', '3-3'])                      => 0.061576,
			(iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                           => 0.423801,
																																														 -0.000000);

	d_subscore8 := map(
			(iv_db001_bankruptcy in ['1 - BK Discharged'])         => 0.156508,
			(iv_db001_bankruptcy in ['0 - No BK', '3 - BK Other']) => -0.071996,
			(iv_db001_bankruptcy in ['2 - BK Dismissed'])          => -0.652767,
																																0.000000);

	d_subscore9 := map(
			NULL < iv_paw_source_count AND iv_paw_source_count < 1 => -0.060414,
			1 <= iv_paw_source_count                               => 0.400033,
																																0.000000);

	d_subscore10 := map(
			(iv_vs099_addr_not_ver_w_ssn in [' ']) => -0.000000,
			(iv_vs099_addr_not_ver_w_ssn in ['0']) => 0.052646,
			(iv_vs099_addr_not_ver_w_ssn in ['1']) => -0.385538,
																								-0.000000);

	d_subscore11 := map(
			NULL < iv_criminal_count AND iv_criminal_count < 1 => 0.038001,
			1 <= iv_criminal_count                             => -0.358100,
																														0.000000);

	d_subscore12 := map(
			NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 1         => -0.036058,
			1 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 57327       => -0.188599,
			57327 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 151586  => -0.036981,
			151586 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 385098 => 0.095135,
			385098 <= iv_pv001_bst_avm_autoval                                       => 0.401526,
																																									-0.000000);

	d_rawscore := d_subscore0 +
			d_subscore1 +
			d_subscore2 +
			d_subscore3 +
			d_subscore4 +
			d_subscore5 +
			d_subscore6 +
			d_subscore7 +
			d_subscore8 +
			d_subscore9 +
			d_subscore10 +
			d_subscore11 +
			d_subscore12;

	d_lnoddsscore := d_rawscore + 1.835866;

	y_subscore0 := map(
			NULL < iv_ag001_age AND iv_ag001_age < 18 => 0.000000,
			18 <= iv_ag001_age AND iv_ag001_age < 21  => -1.267791,
			21 <= iv_ag001_age AND iv_ag001_age < 23  => -0.713849,
			23 <= iv_ag001_age AND iv_ag001_age < 25  => -0.236732,
			25 <= iv_ag001_age AND iv_ag001_age < 29  => -0.003323,
			29 <= iv_ag001_age AND iv_ag001_age < 32  => 0.178227,
			32 <= iv_ag001_age AND iv_ag001_age < 36  => 0.195821,
			36 <= iv_ag001_age                        => 0.700907,
																									 0.000000);

	y_subscore1 := map(
			(iv_inq_recency in [1, 3])  => -1.302017,
			(iv_inq_recency in [6, 12]) => -0.756595,
			(iv_inq_recency in [0])     => 0.136782,
																		 0.000000);

	y_subscore2 := map(
			(iv_ams_college_tier in [' '])       => 0.000000,
			(iv_ams_college_tier in ['0'])       => 0.000000,
			(iv_ams_college_tier in ['1', '2'])  => 1.478591,
			(iv_ams_college_tier in ['3'])       => 0.966809,
			(iv_ams_college_tier in ['4'])       => 0.652055,
			(iv_ams_college_tier in ['5'])       => 0.147106,
			(iv_ams_college_tier in ['-1', '6']) => -0.117116,
																							0.000000);

	y_subscore3 := map(
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1', '1-3', '2-0', '2-1']) => -0.163249,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3'])                                    => 0.067118,
			(iv_nap_phn_ver_x_inf_phn_ver in ['3-1', '3-3'])                                    => 0.150872,
			(iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                           => 0.668832,
																																														 0.000000);

	y_subscore4 := map(
			(iv_po001_inp_addr_naprop in [' '])      => -0.000000,
			(iv_po001_inp_addr_naprop in ['0', '1']) => -0.163789,
			(iv_po001_inp_addr_naprop in ['2', '3']) => 0.138248,
			(iv_po001_inp_addr_naprop in ['4'])      => 0.397431,
																									-0.000000);

	y_subscore5 := map(
			NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => -0.157771,
			1 <= iv_pb_total_orders AND iv_pb_total_orders < 2   => -0.040207,
			2 <= iv_pb_total_orders AND iv_pb_total_orders < 3   => 0.143172,
			3 <= iv_pb_total_orders AND iv_pb_total_orders < 4   => 0.233338,
			4 <= iv_pb_total_orders                              => 0.424370,
																															-0.000000);

	y_subscore6 := map(
			NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 1         => 0.015321,
			1 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 59417       => -0.528640,
			59417 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 97850   => -0.267905,
			97850 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 157241  => -0.105325,
			157241 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 310112 => 0.076916,
			310112 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 467158 => 0.343645,
			467158 <= iv_pv001_inp_avm_autoval                                       => 0.387318,
																																									0.000000);

	y_subscore7 := map(
			NULL < iv_src_property_adl_count AND iv_src_property_adl_count < 1 => -0.107852,
			1 <= iv_src_property_adl_count                                     => 0.336390,
																																						-0.000000);

	y_subscore8 := map(
			(iv_best_match_address in ['ADD1'])                 => 0.124712,
			(iv_best_match_address in ['ADD2', 'ADD3', 'NONE']) => -0.261033,
																														 -0.000000);

	y_subscore9 := map(
			NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 1         => 0.021680,
			1 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 67389       => -0.529870,
			67389 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 87812   => -0.226900,
			87812 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 182283  => -0.092054,
			182283 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 281531 => 0.074576,
			281531 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 436783 => 0.202046,
			436783 <= iv_prv_addr_avm_auto_val                                       => 0.453360,
																																									0.000000);

	y_subscore10 := map(
			NULL < iv_ssns_per_adl_c6 AND iv_ssns_per_adl_c6 < 1 => 0.025249,
			1 <= iv_ssns_per_adl_c6                              => -0.928145,
																															-0.000000);

	y_subscore11 := map(
			NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 0.030779,
			2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -0.229069,
			3 <= iv_ms001_ssns_per_adl                                 => -0.528802,
																																		0.000000);

	y_subscore12 := map(
			NULL < iv_email_domain_edu_count AND iv_email_domain_edu_count < 1 => -0.015697,
			1 <= iv_email_domain_edu_count                                     => 0.533978,
																																						-0.000000);

	y_rawscore := y_subscore0 +
			y_subscore1 +
			y_subscore2 +
			y_subscore3 +
			y_subscore4 +
			y_subscore5 +
			y_subscore6 +
			y_subscore7 +
			y_subscore8 +
			y_subscore9 +
			y_subscore10 +
			y_subscore11 +
			y_subscore12;

	y_lnoddsscore := y_rawscore + 2.359284;

	o_subscore0 := map(
			NULL < iv_ag001_age AND iv_ag001_age < 18 => -0.000000,
			18 <= iv_ag001_age AND iv_ag001_age < 36  => -0.487322,
			36 <= iv_ag001_age AND iv_ag001_age < 40  => -0.379729,
			40 <= iv_ag001_age AND iv_ag001_age < 48  => -0.348867,
			48 <= iv_ag001_age AND iv_ag001_age < 53  => -0.098589,
			53 <= iv_ag001_age AND iv_ag001_age < 59  => 0.119760,
			59 <= iv_ag001_age AND iv_ag001_age < 62  => 0.413261,
			62 <= iv_ag001_age                        => 0.528900,
																									 -0.000000);

	o_subscore1 := map(
			NULL < iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 1 => 0.138887,
			1 <= iv_iq001_inq_count12                                => -1.456711,
																																	-0.000000);

	o_subscore2 := map(
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1', '1-3', '2-0', '2-1']) => -0.342175,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3', '3-1', '3-3'])                      => -0.088620,
			(iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                           => 0.592875,
																																														 0.000000);

	o_subscore3 := map(
			NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen < 0 => -0.378602,
			0 <= iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen < 9   => 0.612026,
			9 <= iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen < 18  => 0.249273,
			18 <= iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen < 35 => 0.125144,
			35 <= iv_mos_src_property_adl_lseen                                        => -0.018750,
																																										-0.000000);

	o_subscore4 := map(
			NULL < iv_max_ids_per_addr AND iv_max_ids_per_addr < 1 => -0.271855,
			1 <= iv_max_ids_per_addr AND iv_max_ids_per_addr < 6   => 0.502554,
			6 <= iv_max_ids_per_addr AND iv_max_ids_per_addr < 8   => 0.208882,
			8 <= iv_max_ids_per_addr AND iv_max_ids_per_addr < 11  => 0.053273,
			11 <= iv_max_ids_per_addr AND iv_max_ids_per_addr < 15 => -0.094063,
			15 <= iv_max_ids_per_addr AND iv_max_ids_per_addr < 20 => -0.142451,
			20 <= iv_max_ids_per_addr AND iv_max_ids_per_addr < 36 => -0.206539,
			36 <= iv_max_ids_per_addr                              => -0.455058,
																																0.000000);

	o_subscore5 := map(
			NULL < iv_addrs_10yr AND iv_addrs_10yr < 0 => -0.000000,
			0 <= iv_addrs_10yr AND iv_addrs_10yr < 2   => 0.369883,
			2 <= iv_addrs_10yr AND iv_addrs_10yr < 3   => 0.046898,
			3 <= iv_addrs_10yr AND iv_addrs_10yr < 4   => -0.082795,
			4 <= iv_addrs_10yr AND iv_addrs_10yr < 6   => -0.190440,
			6 <= iv_addrs_10yr AND iv_addrs_10yr < 8   => -0.267606,
			8 <= iv_addrs_10yr                         => -0.272903,
																										-0.000000);

	o_subscore6 := map(
			(iv_po001_inp_addr_naprop in [' '])      => -0.000000,
			(iv_po001_inp_addr_naprop in ['1'])      => -0.274737,
			(iv_po001_inp_addr_naprop in ['0'])      => -0.214904,
			(iv_po001_inp_addr_naprop in ['2', '3']) => 0.033081,
			(iv_po001_inp_addr_naprop in ['4'])      => 0.200786,
																									-0.000000);

	o_subscore7 := map(
			NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 1         => -0.031015,
			1 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 47481       => -0.616126,
			47481 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 88847   => -0.323054,
			88847 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 123346  => -0.160582,
			123346 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 206832 => -0.041978,
			206832 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 348245 => 0.149820,
			348245 <= iv_pv001_inp_avm_autoval                                       => 0.369029,
																																									0.000000);

	o_subscore8 := map(
			(iv_in001_wealth_index in ['0']) => -0.080794,
			(iv_in001_wealth_index in ['1']) => -0.690066,
			(iv_in001_wealth_index in ['2']) => -0.254304,
			(iv_in001_wealth_index in ['3']) => -0.111860,
			(iv_in001_wealth_index in ['4']) => 0.158882,
			(iv_in001_wealth_index in ['5']) => 0.248899,
			(iv_in001_wealth_index in ['6']) => 0.438671,
																					-0.000000);

	o_subscore9 := map(
			(iv_pb_profile in ['0 No Purch Data'])             => -0.251774,
			(iv_pb_profile in ['1 Offline Shopper'])           => -0.024115,
			(iv_pb_profile in ['2 Online Shopper'])            => 0.150391,
			(iv_pb_profile in ['3 Retail Shopper', '4 Other']) => 0.268709,
																														0.000000);

	o_subscore10 := map(
			(iv_ams_college_code in ['-1', '2']) => -0.035030,
			(iv_ams_college_code in ['1', '4'])  => 0.564950,
																							-0.000000);

	o_subscore11 := map(
			NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 0.069265,
			2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -0.212988,
			3 <= iv_ms001_ssns_per_adl                                 => -0.348778,
																																		-0.000000);

	o_rawscore := o_subscore0 +
			o_subscore1 +
			o_subscore2 +
			o_subscore3 +
			o_subscore4 +
			o_subscore5 +
			o_subscore6 +
			o_subscore7 +
			o_subscore8 +
			o_subscore9 +
			o_subscore10 +
			o_subscore11;

	o_lnoddsscore := if(o_rawscore + 3.493564 = -1, -1, o_rawscore + 3.493564);

	bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

	bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

	_bureau_adl_fseen_eq := common.sas_date((string)(bureau_adl_fseen_eq));

	mos_bureau_adl_fs := if(bureau_adl_eq_fseen_pos = 0, -1, if(_bureau_adl_fseen_eq = NULL, 0, 
			if ((sysdate - _bureau_adl_fseen_eq) / (365.25 / 12) >= 0, truncate((sysdate - _bureau_adl_fseen_eq) / (365.25 / 12)), roundup((sysdate - _bureau_adl_fseen_eq) / (365.25 / 12)))));

	ln_segment := map(
			filing_count > 0 or attr_eviction_count > 0 or criminal_count > 0 or felony_count > 0 or liens_historical_unreleased_ct > 0 or liens_recent_unreleased_count > 0 or impulse_count > 0 => '1 Derog',
			mos_bureau_adl_fs <= 180                                                                                                                                                              => '2 Young',
																																																																																															 '3 Old NonDerog');

	lnoddsscore := map(
			trim(ln_segment, LEFT, RIGHT) = '1 Derog'        => d_lnoddsscore,
			trim(ln_segment, LEFT, RIGHT) = '2 Young'        => y_lnoddsscore,
			trim(ln_segment, LEFT, RIGHT) = '3 Old NonDerog' => o_lnoddsscore,
																													NULL);

	base := 700;

	odds := (1 - 0.057) / 0.057;

	point := 35;

	ssn_deceased := rc_decsflag = '1' or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') ;

	iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

	rvr1311_1 := map(
			ssn_deceased     => 200,
			iv_riskview_222s => 222,
													min(if(max(round(point * (lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));

	propsrc := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'P', ',');

	d_glrc25 := trim(ln_segment, LEFT, RIGHT) = '1 Derog' and addrpop and (integer) ssnlength > 0 and (nas_summary in [4, 7, 9]);

	d_glrc97 := trim(ln_segment, LEFT, RIGHT) = '1 Derog' and truedid and criminal_count > 0;

	d_glrc98 := trim(ln_segment, LEFT, RIGHT) = '1 Derog' and truedid and (liens_historical_unreleased_ct > 0 or liens_recent_unreleased_count > 0);

	d_glrc9a := trim(ln_segment, LEFT, RIGHT) = '1 Derog' and truedid and property_owned_total = 0 and propsrc = false ;

	d_glrc9b := trim(ln_segment, LEFT, RIGHT) = '1 Derog' and truedid and property_owned_total = 0 and propsrc;

	d_glrc9d := trim(ln_segment, LEFT, RIGHT) = '1 Derog' and truedid and attr_addrs_last24 > 0;

	d_glrc9e := trim(ln_segment, LEFT, RIGHT) = '1 Derog' and hphnpop and addrpop and add1_source_count < 2;
 
	d_glrc9h := trim(ln_segment, LEFT, RIGHT) = '1 Derog' and truedid and impulse_count > 0;

	d_glrc9p := trim(ln_segment, LEFT, RIGHT) = '1 Derog' and truedid and inq_highriskcredit_count12 > 0;

	d_glrc9q := trim(ln_segment, LEFT, RIGHT) = '1 Derog' and truedid and inq_count12 > 0;

	d_glrc9r := trim(ln_segment, LEFT, RIGHT) = '1 Derog' and truedid and mos_bureau_adl_fs <= 300;

	d_glrc9w := trim(ln_segment, LEFT, RIGHT) = '1 Derog' and truedid and filing_count > 0;

	d_glrcpv := trim(ln_segment, LEFT, RIGHT) = '1 Derog' and truedid and addrpop and 0 < add1_avm_automated_valuation AND add1_avm_automated_valuation <= 175000;

	d_glrcbl := 0;

	y_glrc99 := trim(ln_segment, LEFT, RIGHT) = '2 Young' and truedid and addrpop and rc_input_addr_not_most_recent;

	y_glrc9a := trim(ln_segment, LEFT, RIGHT) = '2 Young' and truedid and addrpop and property_owned_total = 0 and propsrc = false;

	y_glrc9b := trim(ln_segment, LEFT, RIGHT) = '2 Young' and truedid and property_owned_total = 0 and propsrc;

	y_glrc9e := trim(ln_segment, LEFT, RIGHT) = '2 Young' and hphnpop and addrpop and add1_source_count < 2;  

	y_glrc9i := trim(ln_segment, LEFT, RIGHT) = '2 Young' and truedid and not((ams_college_code in ['1', '2', '4'])) and 18 <= iv_ag001_age AND iv_ag001_age <= 30;

	y_glrc9q := trim(ln_segment, LEFT, RIGHT) = '2 Young' and truedid and inq_count12 > 0;

	y_glrc9r := 0;

	y_glrc9v := trim(ln_segment, LEFT, RIGHT) = '2 Young' and truedid and ssns_per_adl_c6 > 0 and rc_pwssnvalflag = '4';

	// y_glrc9y := trim(ln_segment, LEFT, RIGHT) = '2 Young' and truedid and pb_total_orders = '';

	y_glrcms := trim(ln_segment, LEFT, RIGHT) = '2 Young' and truedid and ssns_per_adl > 2;

	y_glrcpv := trim(ln_segment, LEFT, RIGHT) = '2 Young' and truedid and addrpop and 0 < add1_avm_automated_valuation AND add1_avm_automated_valuation <= 175000;

	y_glrcbl := 0;

	o_glrc9a := trim(ln_segment, LEFT, RIGHT) = '3 Old NonDerog' and truedid and addrpop and property_owned_total = 0 and propsrc = false;

	o_glrc9b := trim(ln_segment, LEFT, RIGHT) = '3 Old NonDerog' and truedid and property_owned_total = 0 and propsrc;

	o_glrc9d := trim(ln_segment, LEFT, RIGHT) = '3 Old NonDerog' and truedid and addrs_10yr > 2;

	o_glrc9e := trim(ln_segment, LEFT, RIGHT) = '3 Old NonDerog' and hphnpop and addrpop and add1_source_count < 2;

	o_glrc9i := trim(ln_segment, LEFT, RIGHT) = '3 Old NonDerog' and truedid and not((ams_college_code in ['1', '2', '4'])) and 18 <= iv_ag001_age AND iv_ag001_age <= 30;

	o_glrc9q := trim(ln_segment, LEFT, RIGHT) = '3 Old NonDerog' and truedid and inq_count12 > 0;

	o_glrc9r := trim(ln_segment, LEFT, RIGHT) = '3 Old NonDerog' and truedid and mos_bureau_adl_fs <= 300;

	// o_glrc9y := trim(ln_segment, LEFT, RIGHT) = '3 Old NonDerog' and truedid and pb_total_orders = '';

	o_glrcms := trim(ln_segment, LEFT, RIGHT) = '3 Old NonDerog' and truedid  and ssns_per_adl > 2;

	o_glrcpv := trim(ln_segment, LEFT, RIGHT) = '3 Old NonDerog' and truedid and addrpop and 0 < add1_avm_automated_valuation AND add1_avm_automated_valuation <= 200000;

	o_glrcbl := 0;

	bk := filing_count > 0;

	eviction := attr_eviction_count > 0;

	lien := liens_historical_unreleased_ct > 0 or liens_recent_unreleased_count > 0;

	pdl := impulse_count > 0;

	derogsum := if(max((integer)bk, (integer)eviction, (integer)lien, (integer)pdl) = NULL, NULL, sum((integer)bk, (integer)eviction, (integer)lien, (integer)pdl));

	s_glrc97 := if(derogsum > 0, (integer)(trim(ln_segment, LEFT, RIGHT) = '1 Derog' and truedid and criminal_count > 0) / derogsum, 0);

	s_glrc98 := if(derogsum > 0, (integer)(trim(ln_segment, LEFT, RIGHT) = '1 Derog' and truedid and (liens_historical_unreleased_ct > 0 or liens_recent_unreleased_count > 0)) / derogsum, 0);

	s_glrc9h := if(derogsum > 0, (integer)(trim(ln_segment, LEFT, RIGHT) = '1 Derog' and truedid and impulse_count > 0) / derogsum, 0);

	s_glrc9r := trim(ln_segment, LEFT, RIGHT) = '2 Young' and truedid and mos_bureau_adl_fs <= 180;

	s_glrc9w := if(derogsum > 0, (integer)(trim(ln_segment, LEFT, RIGHT) = '1 Derog' and truedid and filing_count > 0) / derogsum, 0);

	s_glrcev := if(derogsum > 0, (integer)(trim(ln_segment, LEFT, RIGHT) = '1 Derog' and truedid and attr_eviction_count > 0) / derogsum, 0);

	rcvalue25_1 := (integer)d_glrc25 * (0.052646 - d_subscore10);

	rcvalue25 := if(max(rcvalue25_1) = NULL, NULL, sum(if(rcvalue25_1 = NULL, 0, rcvalue25_1)));

	rcvalue97_1 := (integer)d_glrc97 * (0.038001 - d_subscore11);

	rcvalue97_2 := s_glrc97 * (3.5472 - 1.8747);

	rcvalue97 := if(max(rcvalue97_1, rcvalue97_2) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1), if(rcvalue97_2 = NULL, 0, rcvalue97_2)));

	rcvalue98_1 := (integer)d_glrc98 * (0.279534 - d_subscore2);

	rcvalue98_2 := s_glrc98 * (3.5472 - 1.8747);

	rcvalue98 := if(max(rcvalue98_1, rcvalue98_2) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1), if(rcvalue98_2 = NULL, 0, rcvalue98_2)));

	rcvalue99_1 := (integer)y_glrc99 * (0.124712 - y_subscore8);

	rcvalue99 := if(max(rcvalue99_1) = NULL, NULL, sum(if(rcvalue99_1 = NULL, 0, rcvalue99_1)));

	rcvalue9a_1 := (integer)d_glrc9a * (0.624982 - d_subscore1);

	rcvalue9a_2 := (integer)y_glrc9a * (0.397431 - y_subscore4);

	rcvalue9a_3 := (integer)o_glrc9a * (0.612026 - o_subscore3);

	rcvalue9a_4 := (integer)o_glrc9a * (0.200786 - o_subscore6);

	rcvalue9a := if(max(rcvalue9a_1, rcvalue9a_2, rcvalue9a_3, rcvalue9a_4) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1), if(rcvalue9a_2 = NULL, 0, rcvalue9a_2), if(rcvalue9a_3 = NULL, 0, rcvalue9a_3), if(rcvalue9a_4 = NULL, 0, rcvalue9a_4)));

	rcvalue9b_1 := (integer)d_glrc9b * (0.624982 - d_subscore1);

	rcvalue9b_2 := (integer)y_glrc9b * (0.33639 - y_subscore7);

	rcvalue9b_3 := (integer)o_glrc9b * (0.612026 - o_subscore3);

	rcvalue9b := if(max(rcvalue9b_1, rcvalue9b_2, rcvalue9b_3) = NULL, NULL, sum(if(rcvalue9b_1 = NULL, 0, rcvalue9b_1), if(rcvalue9b_2 = NULL, 0, rcvalue9b_2), if(rcvalue9b_3 = NULL, 0, rcvalue9b_3)));

	rcvalue9d_1 := (integer)d_glrc9d * (0.225267 - d_subscore6);

	rcvalue9d_2 := (integer)o_glrc9d * (0.369883 - o_subscore5);

	rcvalue9d := if(max(rcvalue9d_1, rcvalue9d_2) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1), if(rcvalue9d_2 = NULL, 0, rcvalue9d_2)));

	rcvalue9e_1 := (integer)d_glrc9e * (0.423801 - d_subscore7);

	rcvalue9e_2 := (integer)y_glrc9e * (0.668832 - y_subscore3);

	rcvalue9e_3 := (integer)o_glrc9e * (0.592875 - o_subscore2);

	rcvalue9e_4 := (integer)y_glrc9i*(0.652055 - y_subscore2);      /* iv_ams_college_tier */

	rcvalue9e_5 := (integer)o_glrc9i*(0.56495 - o_subscore10);      /* iv_ams_college_code */

	rcvalue9e := if(max(rcvalue9e_1, rcvalue9e_2, rcvalue9e_3, rcvalue9e_4, rcvalue9e_5) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1), if(rcvalue9e_2 = NULL, 0, rcvalue9e_2), if(rcvalue9e_3 = NULL, 0, rcvalue9e_3), if(rcvalue9e_4 = NULL, 0, rcvalue9e_4), if(rcvalue9e_5 = NULL, 0, rcvalue9e_5)));

	rcvalue9h_1 := (integer)d_glrc9h * (0.133021 - d_subscore0);

	rcvalue9h_2 := s_glrc9h * (3.5472 - 1.8747);

	rcvalue9h := if(max(rcvalue9h_1, rcvalue9h_2) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1), if(rcvalue9h_2 = NULL, 0, rcvalue9h_2)));
/*
	rcvalue9i_1 := (integer)y_glrc9i * (0.652055 - y_subscore2);

	rcvalue9i_2 := (integer)o_glrc9i * (0.56495 - o_subscore10);

	rcvalue9i := if(max(rcvalue9i_1, rcvalue9i_2) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1), if(rcvalue9i_2 = NULL, 0, rcvalue9i_2)));
*/
	rcvalue9p_1 := (integer)d_glrc9p * (0.058434 - d_subscore5);

	rcvalue9p := if(max(rcvalue9p_1) = NULL, NULL, sum(if(rcvalue9p_1 = NULL, 0, rcvalue9p_1)));

	rcvalue9q_1 := (integer)d_glrc9q * (0.104982 - d_subscore4);

	rcvalue9q_2 := (integer)y_glrc9q * (0.136782 - y_subscore1);

	rcvalue9q_3 := (integer)o_glrc9q * (0.138887 - o_subscore1);

	rcvalue9q := if(max(rcvalue9q_1, rcvalue9q_2, rcvalue9q_3) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1), if(rcvalue9q_2 = NULL, 0, rcvalue9q_2), if(rcvalue9q_3 = NULL, 0, rcvalue9q_3)));

	rcvalue9r_1 := (integer)d_glrc9r * (0.573178 - d_subscore3);

	rcvalue9r_2 := y_glrc9r * (0.700907 - y_subscore0);

	rcvalue9r_3 := (integer)o_glrc9r * (0.5289 - o_subscore0);

	rcvalue9r_4 := (integer)s_glrc9r * (3.5472 - 3.0000);

	rcvalue9r := if(max(rcvalue9r_1, rcvalue9r_2, rcvalue9r_3, rcvalue9r_4) = NULL, NULL, sum(if(rcvalue9r_1 = NULL, 0, rcvalue9r_1), if(rcvalue9r_2 = NULL, 0, rcvalue9r_2), if(rcvalue9r_3 = NULL, 0, rcvalue9r_3), if(rcvalue9r_4 = NULL, 0, rcvalue9r_4)));

	rcvalue9v_1 := (integer)y_glrc9v * (0.025249 - y_subscore10);

	rcvalue9v := if(max(rcvalue9v_1) = NULL, NULL, sum(if(rcvalue9v_1 = NULL, 0, rcvalue9v_1)));

	rcvalue9w_1 := (integer)d_glrc9w * (0.156508 - d_subscore8);

	rcvalue9w_2 := s_glrc9w * (3.5472 - 1.8747);

	rcvalue9w := if(max(rcvalue9w_1, rcvalue9w_2) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1), if(rcvalue9w_2 = NULL, 0, rcvalue9w_2)));

	// rcvalue9y_1 := (integer)y_glrc9y * (0.42437 - y_subscore5);

	// rcvalue9y_2 := (integer)o_glrc9y * (0.268709 - o_subscore9);

	// rcvalue9y := if(max(rcvalue9y_1, rcvalue9y_2) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1), if(rcvalue9y_2 = NULL, 0, rcvalue9y_2)));

	rcvalueev_1 := s_glrcev * (3.5472 - 1.8747);

	rcvalueev := if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

	rcvaluems_1 := (integer)y_glrcms * (0.030779 - y_subscore11);

	rcvaluems_2 := (integer)o_glrcms * (0.069265 - o_subscore11);

	rcvaluems := if(max(rcvaluems_1, rcvaluems_2) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1), if(rcvaluems_2 = NULL, 0, rcvaluems_2)));

	rcvaluepv_1 := (integer)d_glrcpv * (0.401526 - d_subscore12);

	rcvaluepv_2 := (integer)y_glrcpv * (0.387318 - y_subscore6);

	rcvaluepv_3 := (integer)o_glrcpv * (0.369029 - o_subscore7);

	rcvaluepv_4 := (integer)o_glrcpv * (0.438671 - o_subscore8);

	rcvaluepv := if(max(rcvaluepv_1, rcvaluepv_2, rcvaluepv_3, rcvaluepv_4) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1), if(rcvaluepv_2 = NULL, 0, rcvaluepv_2), if(rcvaluepv_3 = NULL, 0, rcvaluepv_3), if(rcvaluepv_4 = NULL, 0, rcvaluepv_4)));

	rcvaluebl_1 := d_glrcbl * (0.400033 - d_subscore9);

	rcvaluebl_2 := y_glrcbl * (0.45336 - y_subscore9);

	rcvaluebl_3 := y_glrcbl * (0.533978 - y_subscore12);

	rcvaluebl_4 := o_glrcbl * (0.502554 - o_subscore4);

	rcvaluebl := if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3, rcvaluebl_4) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3), if(rcvaluebl_4 = NULL, 0, rcvaluebl_4)));

	//*************************************************************************************//
	// IMPORTANT NOTE:  Only select reason codes when their associated value is > 0.
	// This means that the 'BL' reason code should never be selected and no reason code
	//   with a value <= 0 should ever be selected.
	// I'll leave the implementation details to the Engineers.
	//*************************************************************************************//
		ds_layout := {STRING rc, REAL value};

		rc_dataset := DATASET([
			{'25', RCValue25},
			{'97', RCValue97},
			{'98', RCValue98},
			{'99', RCValue99},
			{'9A', RCValue9A},
			{'9B', RCValue9B},
			{'9D', RCValue9D},
			{'9E', RCValue9E},
			{'9H', RCValue9H},
			//{'9I', RCValue9I},
			{'9P', RCValue9P},
			{'9Q', RCValue9Q},
			{'9R', RCValue9R},
			{'9V', RCValue9V},
			{'9W', RCValue9W},
			// {'9Y', RCValue9Y},
			{'EV', RCValueEV},
			{'MS', RCValueMS},
			{'PV', RCValuePV},
			{'BL', RCValueBL}
			], ds_layout)(value > 0);

	glrc9q := truedid and inq_count12 > 0;			
	
	rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top 4 reason codes
	
	rcs_9p1 := if(count(rcs_top4)<1, ROW({'36', NULL}, ds_layout), rcs_top4[1]);
	rcs_9p2 := IF(count(rcs_top4)<2,
									if( rcs_9p1.rc not in ['', '36'] and 500 < rvr1311_1 AND rvr1311_1 <= 760, 
											ROW({'36', NULL}, ds_layout), 
								  if( rcs_9p1.rc in ['36'] and 500 < rvr1311_1 AND rvr1311_1 <= 760, 
											ROW({'9E', NULL}, ds_layout),rcs_top4[2])),
											rcs_top4[2]);
	rcs_9p3 := rcs_top4[3];
	rcs_9p4 := IF(glrc9q and inq_count12 > 0 AND NOT EXISTS(rcs_top4 (rc in ['9Q'])),  	// Check to see if RC 9Q is a part of the score, but not in the first 4 RC's
								ROW({'9Q', NULL}, ds_layout), rcs_top4[4]); 																				// If so - make it the 5th reason code.
	
	
	rcs_9p := rcs_9p1 & rcs_9p2 & rcs_9p3 & rcs_9p4 ;
	
	rcs_override := MAP(
											rvr1311_1 = 200 							=> DATASET([{'02', NULL}], ds_layout),
											rvr1311_1 = 222 							=> DATASET([{'9X', NULL}], ds_layout),
											rvr1311_1 = 900 							=> DATASET([{'  ', NULL}], ds_layout),
											NOT EXISTS(rcs_9p(rc != '')) 	=> DATASET([{'36', NULL}], ds_layout),
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
		
		reasons := CHOOSEN(ri & zeros, 4); // Keep up to 4 reason codes


	//Intermediate variables
		#if(RVR_DEBUG)
			self.clam														 := le;
	    self.sysdate                          := sysdate;                                                        
			self.iv_vs099_addr_not_ver_w_ssn      := iv_vs099_addr_not_ver_w_ssn;                                    
			self.iv_db001_bankruptcy              := iv_db001_bankruptcy;                                            
			self.email_src_im                     := email_src_im;                                                   
			self.iv_ds001_impulse_count           := iv_ds001_impulse_count;                                         
			self._in_dob                          := _in_dob;                                                        
			self.yr_in_dob                        := yr_in_dob;                                                      
			self.yr_in_dob_int                    := yr_in_dob_int;                                                  
			self.age_estimate                     := age_estimate;                                                   
			self.iv_ag001_age                     := iv_ag001_age;                                                   
			self.iv_pv001_bst_avm_autoval         := iv_pv001_bst_avm_autoval;                                       
			self.prop_adl_p_lseen_pos             := prop_adl_p_lseen_pos;                                           
			self.prop_adl_lseen_p                 := prop_adl_lseen_p;                                               
			self._prop_adl_lseen_p                := _prop_adl_lseen_p;                                              
			self._src_prop_adl_lseen              := _src_prop_adl_lseen;                                            
			self.iv_mos_src_property_adl_lseen    := iv_mos_src_property_adl_lseen;                                  
			self.iv_inq_recency                   := iv_inq_recency;                                                 
			self.iv_inq_highriskcredit_count12    := iv_inq_highriskcredit_count12;                                  
			self.iv_paw_source_count              := iv_paw_source_count;                                            
			self.ver_phn_inf                      := ver_phn_inf;                                                    
			self.ver_phn_nap                      := ver_phn_nap;                                                    
			self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;                                                
			self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;                                                
			self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;                                   
			self.iv_attr_addrs_recency            := iv_attr_addrs_recency;                                          
			self.iv_unreleased_liens_ct           := iv_unreleased_liens_ct;                                         
			self.iv_criminal_count                := iv_criminal_count;                                              
			self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;                                          
			self.iv_pv001_inp_avm_autoval         := iv_pv001_inp_avm_autoval;                                       
			self.iv_po001_inp_addr_naprop         := iv_po001_inp_addr_naprop;                                       
			self.prop_adl_p_count_pos             := prop_adl_p_count_pos;                                           
			self.prop_adl_count_p                 := prop_adl_count_p;                                               
			self._src_prop_adl_count              := _src_prop_adl_count;                                            
			self.iv_src_property_adl_count        := iv_src_property_adl_count;                                      
			self.iv_best_match_address            := iv_best_match_address;                                          
			self.iv_prv_addr_avm_auto_val         := iv_prv_addr_avm_auto_val;                                       
			self.iv_ssns_per_adl_c6               := iv_ssns_per_adl_c6;                                             
			self.iv_email_domain_edu_count        := iv_email_domain_edu_count;                                      
			self.iv_ams_college_tier              := iv_ams_college_tier;                                            
			self.iv_pb_total_orders               := iv_pb_total_orders;                                             
			self.iv_in001_wealth_index            := iv_in001_wealth_index;                                          
			self.iv_iq001_inq_count12             := iv_iq001_inq_count12;                                           
			self.iv_addrs_10yr                    := iv_addrs_10yr;                                                  
			self.iv_max_ids_per_addr              := iv_max_ids_per_addr;                                            
			self.iv_ams_college_code              := iv_ams_college_code;                                            
			self.sum_dols                         := sum_dols;                                                       
			self.pct_offline_dols                 := pct_offline_dols;                                               
			self.pct_retail_dols                  := pct_retail_dols;                                                
			self.pct_online_dols                  := pct_online_dols;                                                
			self.iv_pb_profile                    := iv_pb_profile;                                                  
			self.d_subscore0                      := d_subscore0;                                                    
			self.d_subscore1                      := d_subscore1;                                                    
			self.d_subscore2                      := d_subscore2;                                                    
			self.d_subscore3                      := d_subscore3;                                                    
			self.d_subscore4                      := d_subscore4;                                                    
			self.d_subscore5                      := d_subscore5;                                                    
			self.d_subscore6                      := d_subscore6;                                                    
			self.d_subscore7                      := d_subscore7;                                                    
			self.d_subscore8                      := d_subscore8;                                                    
			self.d_subscore9                      := d_subscore9;                                                    
			self.d_subscore10                     := d_subscore10;                                                   
			self.d_subscore11                     := d_subscore11;                                                   
			self.d_subscore12                     := d_subscore12;                                                   
			self.d_rawscore                       := d_rawscore;                                                     
			self.d_lnoddsscore                    := d_lnoddsscore;                                                  
			self.y_subscore0                      := y_subscore0;                                                    
			self.y_subscore1                      := y_subscore1;                                                    
			self.y_subscore2                      := y_subscore2;                                                    
			self.y_subscore3                      := y_subscore3;                                                    
			self.y_subscore4                      := y_subscore4;                                                    
			self.y_subscore5                      := y_subscore5;                                                    
			self.y_subscore6                      := y_subscore6;                                                    
			self.y_subscore7                      := y_subscore7;                                                    
			self.y_subscore8                      := y_subscore8;                                                    
			self.y_subscore9                      := y_subscore9;                                                    
			self.y_subscore10                     := y_subscore10;                                                   
			self.y_subscore11                     := y_subscore11;                                                   
			self.y_subscore12                     := y_subscore12;                                                   
			self.y_rawscore                       := y_rawscore;                                                     
			self.y_lnoddsscore                    := y_lnoddsscore;                                                  
			self.o_subscore0                      := o_subscore0;                                                    
			self.o_subscore1                      := o_subscore1;                                                    
			self.o_subscore2                      := o_subscore2;                                                    
			self.o_subscore3                      := o_subscore3;                                                    
			self.o_subscore4                      := o_subscore4;                                                    
			self.o_subscore5                      := o_subscore5;                                                    
			self.o_subscore6                      := o_subscore6;                                                    
			self.o_subscore7                      := o_subscore7;                                                    
			self.o_subscore8                      := o_subscore8;                                                    
			self.o_subscore9                      := o_subscore9;                                                    
			self.o_subscore10                     := o_subscore10;                                                   
			self.o_subscore11                     := o_subscore11;                                                   
			self.o_rawscore                       := o_rawscore;                                                     
			self.o_lnoddsscore                    := o_lnoddsscore;                                                  
			self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;                                        
			self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;                                            
			self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;                                           
			self.mos_bureau_adl_fs                := mos_bureau_adl_fs;                                              
			self.ln_segment                       := ln_segment;                                                     
			self.lnoddsscore                      := lnoddsscore;                                                    
			self.base                             := base;                                                           
			self.odds                             := odds;                                                           
			self.point                            := point;                                                          
			self.ssn_deceased                     := ssn_deceased;                                                   
			self.iv_riskview_222s                 := iv_riskview_222s;                                               
			self.rvr1311_1                        := rvr1311_1;                                                      
			self.propsrc                          := propsrc;                                                        
			self.d_glrc25                         := d_glrc25;                                                       
			self.d_glrc97                         := d_glrc97;                                                       
			self.d_glrc98                         := d_glrc98;                                                       
			self.d_glrc9a                         := d_glrc9a;                                                       
			self.d_glrc9b                         := d_glrc9b;                                                       
			self.d_glrc9d                         := d_glrc9d;                                                       
			self.d_glrc9e                         := d_glrc9e;                                                       
			self.d_glrc9h                         := d_glrc9h;                                                       
			self.d_glrc9p                         := d_glrc9p;                                                       
			self.d_glrc9q                         := d_glrc9q;                                                       
			self.d_glrc9r                         := d_glrc9r;                                                       
			self.d_glrc9w                         := d_glrc9w;                                                       
			self.d_glrcpv                         := d_glrcpv;                                                       
			self.d_glrcbl                         := d_glrcbl;                                                       
			self.y_glrc99                         := y_glrc99;                                                       
			self.y_glrc9a                         := y_glrc9a;                                                       
			self.y_glrc9b                         := y_glrc9b;                                                       
			self.y_glrc9e                         := y_glrc9e;                                                       
			self.y_glrc9i                         := y_glrc9i;                                                       
			self.y_glrc9q                         := y_glrc9q;                                                       
			self.y_glrc9r                         := y_glrc9r;                                                       
			self.y_glrc9v                         := y_glrc9v;                                                       
			// self.y_glrc9y                         := y_glrc9y;                                                       
			self.y_glrcms                         := y_glrcms;                                                       
			self.y_glrcpv                         := y_glrcpv;                                                       
			self.y_glrcbl                         := y_glrcbl;                                                       
			self.o_glrc9a                         := o_glrc9a;                                                       
			self.o_glrc9b                         := o_glrc9b;                                                       
			self.o_glrc9d                         := o_glrc9d;                                                       
			self.o_glrc9e                         := o_glrc9e;                                                       
			self.o_glrc9i                         := o_glrc9i;                                                       
			self.o_glrc9q                         := o_glrc9q;                                                       
			self.o_glrc9r                         := o_glrc9r;                                                       
			// self.o_glrc9y                         := o_glrc9y;                                                       
			self.o_glrcms                         := o_glrcms;                                                       
			self.o_glrcpv                         := o_glrcpv;                                                       
			self.o_glrcbl                         := o_glrcbl;                                                       
			self.bk                               := bk;                                                             
			self.eviction                         := eviction;                                                       
			self.lien                             := lien;                                                           
			self.pdl                              := pdl;                                                            
			self.derogsum                         := derogsum;                                                       
			self.s_glrc97                         := s_glrc97;                                                       
			self.s_glrc98                         := s_glrc98;                                                       
			self.s_glrc9h                         := s_glrc9h;                                                       
			self.s_glrc9r                         := s_glrc9r;                                                       
			self.s_glrc9w                         := s_glrc9w;                                                       
			self.s_glrcev                         := s_glrcev;                                                       
			self.rcvalue25_1                      := rcvalue25_1;                                                    
			self.rcvalue25                        := rcvalue25;                                                      
			self.rcvalue97_1                      := rcvalue97_1;                                                    
			self.rcvalue97_2                      := rcvalue97_2;                                                    
			self.rcvalue97                        := rcvalue97;                                                      
			self.rcvalue98_1                      := rcvalue98_1;                                                    
			self.rcvalue98_2                      := rcvalue98_2;                                                    
			self.rcvalue98                        := rcvalue98;                                                      
			self.rcvalue99_1                      := rcvalue99_1;                                                    
			self.rcvalue99                        := rcvalue99;                                                      
			self.rcvalue9a_1                      := rcvalue9a_1;                                                    
			self.rcvalue9a_2                      := rcvalue9a_2;                                                    
			self.rcvalue9a_3                      := rcvalue9a_3;                                                    
			self.rcvalue9a_4                      := rcvalue9a_4;                                                    
			self.rcvalue9a                        := rcvalue9a;                                                      
			self.rcvalue9b_1                      := rcvalue9b_1;                                                    
			self.rcvalue9b_2                      := rcvalue9b_2;                                                    
			self.rcvalue9b_3                      := rcvalue9b_3;                                                    
			self.rcvalue9b                        := rcvalue9b;                                                      
			self.rcvalue9d_1                      := rcvalue9d_1;                                                    
			self.rcvalue9d_2                      := rcvalue9d_2;                                                    
			self.rcvalue9d                        := rcvalue9d;                                                      
			self.rcvalue9e_1                      := rcvalue9e_1;                                                    
			self.rcvalue9e_2                      := rcvalue9e_2;                                                    
			self.rcvalue9e_3                      := rcvalue9e_3;    
			self.rcvalue9e_4											:= rcvalue9e_4;
			self.rcvalue9e_5											:= rcvalue9e_5;
			self.rcvalue9e                        := rcvalue9e;                                                      
			self.rcvalue9h_1                      := rcvalue9h_1;                                                    
			self.rcvalue9h_2                      := rcvalue9h_2;                                                    
			self.rcvalue9h                        := rcvalue9h;                                                      
			//self.rcvalue9i_1                      := rcvalue9i_1;                                                    
			//self.rcvalue9i_2                      := rcvalue9i_2;                                                    
			//self.rcvalue9i                        := rcvalue9i;                                                      
			self.rcvalue9p_1                      := rcvalue9p_1;                                                    
			self.rcvalue9p                        := rcvalue9p;                                                      
			self.rcvalue9q_1                      := rcvalue9q_1;                                                    
			self.rcvalue9q_2                      := rcvalue9q_2;                                                    
			self.rcvalue9q_3                      := rcvalue9q_3;                                                    
			self.rcvalue9q                        := rcvalue9q;                                                      
			self.rcvalue9r_1                      := rcvalue9r_1;                                                    
			self.rcvalue9r_2                      := rcvalue9r_2;                                                    
			self.rcvalue9r_3                      := rcvalue9r_3;                                                    
			self.rcvalue9r_4                      := rcvalue9r_4;                                                    
			self.rcvalue9r                        := rcvalue9r;                                                      
			self.rcvalue9v_1                      := rcvalue9v_1;                                                    
			self.rcvalue9v                        := rcvalue9v;                                                      
			self.rcvalue9w_1                      := rcvalue9w_1;                                                    
			self.rcvalue9w_2                      := rcvalue9w_2;                                                    
			self.rcvalue9w                        := rcvalue9w;                                                      
			// self.rcvalue9y_1                      := rcvalue9y_1;                                                    
			// self.rcvalue9y_2                      := rcvalue9y_2;                                                    
			// self.rcvalue9y                        := rcvalue9y;                                                      
			self.rcvalueev_1                      := rcvalueev_1;                                                    
			self.rcvalueev                        := rcvalueev;                                                      
			self.rcvaluems_1                      := rcvaluems_1;                                                    
			self.rcvaluems_2                      := rcvaluems_2;                                                    
			self.rcvaluems                        := rcvaluems;                                                      
			self.rcvaluepv_1                      := rcvaluepv_1;                                                    
			self.rcvaluepv_2                      := rcvaluepv_2;                                                    
			self.rcvaluepv_3                      := rcvaluepv_3;                                                    
			self.rcvaluepv_4                      := rcvaluepv_4;                                                    
			self.rcvaluepv                        := rcvaluepv;                                                      
			self.rcvaluebl_1                      := rcvaluebl_1;                                                    
			self.rcvaluebl_2                      := rcvaluebl_2;                                                    
			self.rcvaluebl_3                      := rcvaluebl_3;                                                    
			self.rcvaluebl_4                      := rcvaluebl_4;                                                    
			self.rcvaluebl                        := rcvaluebl;                                                      
			self.glrc9q                           := glrc9q;                                                                                   
		   self.rc1                              := rcs_override[1].rc;
		   self.rc2                              := rcs_override[2].rc;
		   self.rc3                              := rcs_override[3].rc;
			 self.rc4                              := rcs_override[4].rc;
//			 self.rc5                              := rcs_override[5].rc;  //don't want the fifth reason code                                       

		#end
			SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																								SELF.hri := if(LEFT.hri='', '00', left.hri),
																								SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																						));
			self.seq := le.seq;
			
			self.score := MAP(
												reasons[1].hri IN ['91','92','93','94'] 			=> (STRING3)((INTEGER)reasons[1].hri + 10),
												reasons[1].hri='35' => '100',
												(string3) rvr1311_1
											);
		END;

		model := project( clam, doModel(left) );

		return model;
	END;