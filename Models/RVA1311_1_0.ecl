// RVA1311_1 Coastal Credit 4534 - 4.1. shell - FCRA

import risk_indicators, riskwise, RiskWiseFCRA, ut, std, riskview;

export RVA1311_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVA_DEBUG := FALSE;

  #if(RVA_DEBUG)
    layout_debug := record
			INTEGER sysdate;                                                   
			boolean iv_pots_phone;                                             
			boolean iv_add_apt;                                                
			boolean iv_ssn_deceased;                                           
			boolean iv_riskview_222s;                                          
			INTEGER iv_vs099_addr_not_ver_w_ssn;                               
			string iv_vs100_ssn_problem;                                      
			integer iv_de001_eviction_recency;                                 
			boolean email_src_im;                                              
			INTEGER iv_ds001_impulse_count;                                    
			INTEGER iv_dl001_unrel_lien60_count;                               
			INTEGER bureau_adl_vo_fseen_pos;                                   
			string bureau_adl_fseen_vo;                                       
			INTEGER _bureau_adl_fseen_vo;                                      
			INTEGER _src_bureau_adl_fseen;                                     
			INTEGER mth_ver_src_fdate_vo;                                      
			INTEGER bureau_adl_vo_lseen_pos;                                   
			string bureau_adl_lseen_vo;                                       
			INTEGER _bureau_adl_lseen_vo;                                      
			INTEGER mth_ver_src_ldate_vo;                                      
			boolean mth_ver_src_fdate_vo60;                                    
			boolean mth_ver_src_ldate_vo0;                                     
			INTEGER bureau_adl_w_lseen_pos;                                    
			string bureau_adl_lseen_w;                                        
			INTEGER _bureau_adl_lseen_w;                                       
			INTEGER mth_ver_src_ldate_w;                                       
			boolean mth_ver_src_ldate_w0;                                      
			INTEGER bureau_adl_wp_lseen_pos;                                   
			string bureau_adl_lseen_wp;                                       
			INTEGER _bureau_adl_lseen_wp;                                      
			INTEGER _src_bureau_adl_lseen;                                     
			INTEGER mth_ver_src_ldate_wp;                                      
			boolean mth_ver_src_ldate_wp0;                                     
			INTEGER _paw_first_seen;                                           
			INTEGER mth_paw_first_seen;                                        
			INTEGER mth_paw_first_seen2;                                       
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
			INTEGER _infutor_first_seen;                                       
			INTEGER mth_infutor_first_seen;                                    
			INTEGER _infutor_last_seen;                                        
			INTEGER mth_infutor_last_seen;                                     
			INTEGER infutor_i;                                                 
			real infutor_im;                                                
			INTEGER white_pages_adl_wp_fseen_pos;                              
			string white_pages_adl_fseen_wp;                                  
			INTEGER _white_pages_adl_fseen_wp;                                 
			INTEGER _src_white_pages_adl_fseen;                                
			INTEGER iv_sr001_m_wp_adl_fs;                                      
			INTEGER src_m_wp_adl_fs;                                           
			INTEGER _header_first_seen;                                        
			INTEGER iv_sr001_m_hdr_fs;                                         
			INTEGER src_m_hdr_fs;                                              
			real source_mod6;                                               
			real iv_sr001_source_profile;                                   
			INTEGER iv_sr001_source_profile_index;                             
			INTEGER iv_mi001_adlperssn_count;                                  
			INTEGER _in_dob;                                                   
			real yr_in_dob;                                                 
			INTEGER yr_in_dob_int;                                             
			INTEGER age_estimate;                                              
			INTEGER iv_ag001_age;                                              
			INTEGER iv_pl002_avg_mo_per_addr;                                  
			string iv_input_addr_not_most_recent;                             
			string iv_bst_addr_financing_type;                                
			INTEGER iv_addrs_10yr;                                             
			INTEGER _gong_did_first_seen;                                      
			INTEGER iv_mos_since_gong_did_fst_seen;                            
			INTEGER iv_inq_auto_count12;                                       
			INTEGER iv_inq_highriskcredit_recency;                             
			INTEGER iv_attr_purchase_recency;                                  
			INTEGER iv_non_derog_count;                                        
			INTEGER iv_released_liens_ct;                                      
			string iv_criminal_x_felony;                                      
			INTEGER _reported_dob;                                             
			real reported_age;                                              
			INTEGER _combined_age;                                             
			boolean evidence_of_college;                                       
			string iv_college_attendance_x_age;                               
			INTEGER iv_pb_total_orders;                                        
			INTEGER cs_curr_to_avg_lres_ratio;                                 
			REAL civ_subscore0;                                             
			REAL civ_subscore1;                                             
			REAL civ_subscore2;                                             
			REAL civ_subscore3;                                             
			REAL civ_subscore4;                                             
			REAL civ_subscore5;                                             
			REAL civ_subscore6;                                             
			REAL civ_subscore7;                                             
			REAL civ_subscore8;                                             
			REAL civ_subscore9;                                             
			REAL civ_subscore10;                                            
			REAL civ_subscore11;                                            
			REAL civ_subscore12;                                            
			REAL civ_subscore13;                                            
			REAL civ_subscore14;                                            
			REAL civ_subscore15;                                            
			REAL civ_subscore16;                                            
			REAL civ_subscore17;                                            
			REAL civ_subscore18;                                            
			REAL civ_subscore19;                                            
			REAL civ_subscore20;                                            
			REAL civ_subscore21;                                            
			REAL civ_rawscore;                                              
			REAL civ_lnoddsscore;                                           
			REAL civ_probscore;                                             
			INTEGER point;                                                     
			INTEGER base;                                                      
			REAL odds;                                                      
			INTEGER _civ_transformed_score;                                    
			BOOLEAN bk_flag;                                                   
			BOOLEAN lien_rec_unrel_flag;                                       
			BOOLEAN lien_hist_unrel_flag;                                      
			BOOLEAN lien_flag;                                                 
			BOOLEAN ssn_deceased;                                              
			BOOLEAN scored_222s;                                               
			INTEGER rva1311_1_0;                                               
			BOOLEAN glrc24;                                                                                                      
			BOOLEAN glrc97;                                                    
			BOOLEAN glrc98;                                                    
			BOOLEAN glrc99;                                                    
			BOOLEAN glrc9a;                                                    
			BOOLEAN glrc9c;                                                    
			BOOLEAN glrc9d;                                                    
			BOOLEAN glrc9e;                                                    
			BOOLEAN glrc9f;                                                    
			BOOLEAN glrc9h;                                                    
			BOOLEAN glrc9i;                                                    
			BOOLEAN glrc9q;                                                    
			BOOLEAN glrc9r;                                                    
			BOOLEAN glrc9v;                                                    
			// BOOLEAN glrc9y;                                                    
			BOOLEAN glrcev;                                                    
			BOOLEAN glrcmi;                                                    
			BOOLEAN glrcbl;                                                    
			// REAL rcvalue9y_1;                                               
			// REAL rcvalue9y;                                                 
			REAL rcvalue9q_1;                                               
			REAL rcvalue9q;                                                 
			REAL rcvalue24_1;                                               
			REAL rcvalue24;                                                 
			REAL rcvalue9d_1;                                               
			REAL rcvalue9d_2;                                               
			REAL rcvalue9d;                                                 
			REAL rcvalue98_1;                                               
			REAL rcvalue98;                                                 
			REAL rcvalue9f_1;                                               
			REAL rcvalue9f;                                                 
			REAL rcvalue9r_1;                                               
			REAL rcvalue9r_2;                                               
			REAL rcvalue9r;                                                 
			REAL rcvaluebl_1;                                               
			REAL rcvaluebl_2;                                               
			REAL rcvaluebl_3;                                               
			REAL rcvaluebl;                                                 
			REAL rcvalueev_1;                                               
			REAL rcvalueev;                                                 
			REAL rcvalue9a_1;                                               
			REAL rcvalue9a;                                                 
			REAL rcvalue99_1;                                               
			REAL rcvalue99;                                                 
			REAL rcvalue9e_1;                                               
			REAL rcvalue9e;                                                 
			REAL rcvaluemi_1;                                               
			REAL rcvaluemi;                                                 
			REAL rcvalue9h_1;                                               
			REAL rcvalue9h;                                                 
			REAL rcvalue9i_1;                                               
			REAL rcvalue9i;                                                 
			REAL rcvalue9c_1;                                               
			REAL rcvalue9c;                                                 
			REAL rcvalue97_1;                                               
			REAL rcvalue97;                                                 
			REAL rcvalue9v_1;                                               
			REAL rcvalue9v;                                                 
			STRING rc4;                                                       
			STRING rc2;                                                       
			STRING rc3;                                                       
			STRING rc5;                                                       
			STRING rc1;                                                       

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
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnvalflag                    := le.iid.socsvalflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	age                              := le.name_verification.age;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_lres                        := le.lres;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_financing_type              := le.address_verification.input_address_information.type_financing;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	add2_lres                        := le.lres2;
	add2_financing_type              := le.address_verification.address_history_1.type_financing;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	avg_mo_per_addr                  := le.address_history_summary.avg_mo_per_addr;
	telcordia_type                   := le.phone_verification.telcordia_type;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	header_first_seen                := le.ssn_verification.header_first_seen;
	inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
	adlperssn_count                  := le.ssn_verification.adlperssn_count;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	invalid_ssns_per_adl_c6          := le.velocity_counters.invalid_ssns_per_adl_created_6months;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_auto_count12                 := le.acc_logs.auto.count12;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	paw_first_seen                   := le.employment.first_seen_date;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	infutor_last_seen                := le.infutor_phone.infutor_date_last_seen;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	email_source_list                := le.email_summary.email_source_list;
	attr_date_first_purchase         := le.other_address_info.date_first_purchase;
	attr_num_purchase30              := le.other_address_info.num_purchase30;
	attr_num_purchase90              := le.other_address_info.num_purchase90;
	attr_num_purchase180             := le.other_address_info.num_purchase180;
	attr_num_purchase12              := le.other_address_info.num_purchase12;
	attr_num_purchase24              := le.other_address_info.num_purchase24;
	attr_num_purchase36              := le.other_address_info.num_purchase36;
	attr_num_purchase60              := le.other_address_info.num_purchase60;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
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
	ams_age                          := le.student.age;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	input_dob_age                    := le.shell_input.age;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	reported_dob                     := le.reported_dob;
	archive_date                     := le.historydate;

	NULL := -999999999;


	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

	BOOLEAN indexw(string source, string target, string delim) :=
		(source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

	sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

	iv_pots_phone := (telcordia_type in ['00', '50', '51', '52', '54']);

	iv_add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

	iv_ssn_deceased := rc_decsflag = '1' or 
			indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',');

	iv_riskview_222s := (nas_summary <= 4 and 
		nap_summary <= 4 AND
		add1_naprop <= 3 and 
		not(if(max(property_owned_total, property_sold_total) = NULL, NULL, 
		sum(if(property_owned_total = NULL, 0, property_owned_total), 
		if(property_sold_total = NULL, 0, property_sold_total))) > 0 or 
		90 <= combo_dobscore AND combo_dobscore <= 100 or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'L2', ',') OR
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'LI', ',') or
		liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0 or 
		criminal_count > 0 or (rc_bansflag in ['1', '2']) or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'BA', ',')  or
		bankrupt or 
		filing_count > 0 or 
		bk_recent_count > 0 or
		rc_decsflag = '1' or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') or
		truedid)) 
    or le.truedid=false;

	iv_vs099_addr_not_ver_w_ssn := if(not(truedid and (integer) ssnlength > 0), null, (integer)(nas_summary in [4, 7, 9]));

	iv_vs100_ssn_problem := map(
			not((integer) ssnlength > 0)   => ' ',
			dobpop and (rc_ssndobflag = '1' or rc_pwssndobflag = '1') or 
			truedid and invalid_ssns_per_adl >= 2 or 
			truedid and invalid_ssns_per_adl_c6 >= 1   => '2',
			rc_decsflag = '1' or 
			contains_i(ver_sources, 'DE') >0 or contains_i(ver_sources, 'DS') >0 or 
			rc_ssnvalflag = '1' or 
			(rc_pwssnvalflag in ['1', '2', '3']) or 
			(inputssncharflag in ['1', '2', '3']) or 
			truedid and invalid_ssns_per_adl >= 1                          => '1',
			rc_decsflag = '0' or dobpop and 
			(rc_ssndobflag = '0' or rc_pwssndobflag = '0') or 
			rc_ssnvalflag = '0' or (rc_pwssnvalflag in ['0', '4', '5']) or 
			(inputssncharflag in ['0', '4', '5']) or 
			truedid and 
			invalid_ssns_per_adl = 0 or 
			truedid and 
			invalid_ssns_per_adl_c6 = 0 => '0',
			 ' ');

	iv_de001_eviction_recency := map(
			not(truedid)                                                => NULL,
			(boolean) attr_eviction_count90                                       => 3,
			(boolean) attr_eviction_count180                                      => 6,
			(boolean) attr_eviction_count12                                       => 12,
			(boolean) attr_eviction_count24 and attr_eviction_count >= 2 => 24,
			(boolean) attr_eviction_count24                                       => 25,
			(boolean) attr_eviction_count36 and attr_eviction_count >= 2 => 36,
			(boolean) attr_eviction_count36                                       => 37,
			(boolean) attr_eviction_count60 and attr_eviction_count >= 2 => 60,
			(boolean) attr_eviction_count60                                       => 61,
			attr_eviction_count >= 2                                    => 98,
			attr_eviction_count >=1                                    => 99,
																																		 0);

	email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

	iv_ds001_impulse_count := map(
			not(truedid)                           => NULL,
			impulse_count = 0 and email_src_im => 1,
																								impulse_count);

	iv_dl001_unrel_lien60_count := if(not(truedid), NULL, attr_num_unrel_liens60);

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

	ver_src_ba := Models.Common.findw_cpp(ver_sources, 'BA', '  ,', 'ie') > 0;

	ver_src_l2 := Models.Common.findw_cpp(ver_sources, 'L2', '  ,', 'ie') > 0;

	ver_src_li := Models.Common.findw_cpp(ver_sources, 'LI', '  ,', 'ie') > 0;

	ver_src_ds := Models.Common.findw_cpp(ver_sources, 'DS', '  ,', 'ie') > 0;

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

	_in_dob := common.sas_date((string)(in_dob));

	yr_in_dob :=   map(
								in_dob = ''  => -1, 
								in_dob = '0' => 0, 
								(integer) _in_dob = NULL => 0, 
								(sysdate - _in_dob) / 365.25);   

	yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

	age_estimate := map(
			yr_in_dob_int > 0 => yr_in_dob_int,
			inferred_age > 0  => inferred_age,
													 -1);

	iv_ag001_age := if(not(truedid or dobpop), NULL, min(62, if(age_estimate = NULL, -NULL, age_estimate)));

	iv_pl002_avg_mo_per_addr := map(
			not(truedid)            => NULL,
			avg_mo_per_addr = -9999 => -1,
			unique_addr_count = 0   => -1,
																 avg_mo_per_addr);

	iv_input_addr_not_most_recent := if(not(truedid), '', if(rc_input_addr_not_most_recent, '1', '0'));

	iv_bst_addr_financing_type_c34 := if(add1_financing_type = '', 'NONE ', add1_financing_type);

	iv_bst_addr_financing_type_c35 := if(add2_financing_type = '', 'NONE ', add2_financing_type);

	iv_bst_addr_financing_type := map(
			not(truedid)     => '     ',
			add1_isbestmatch => iv_bst_addr_financing_type_c34,
													iv_bst_addr_financing_type_c35);

	iv_addrs_10yr := map(
			not(truedid)          => NULL,
			unique_addr_count = 0 => -1,
															 addrs_10yr);

	_gong_did_first_seen := common.sas_date((string)(gong_did_first_seen));

	iv_mos_since_gong_did_fst_seen := map(
			not(truedid)                     => NULL,
			not(_gong_did_first_seen = NULL) => if ((sysdate - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_first_seen) / (365.25 / 12))),
																					-1);

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

	iv_non_derog_count := if(not(truedid), NULL, attr_num_nonderogs);

	iv_released_liens_ct := if(not(truedid), NULL, if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))));

	iv_criminal_x_felony := if(not(truedid), '   ', 
	trim((string) min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + 
	trim(' - ', LEFT, RIGHT) + trim((string) min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

	_reported_dob := common.sas_date((string)(reported_dob));

	reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

	_combined_age := map(
			age > 0           => age,
			(integer) input_dob_age > 0 => (integer) input_dob_age,
			inferred_age > 0  => inferred_age,
			reported_age > 0  => reported_age,
			(integer) ams_age > 0 => (integer) ams_age,
													 -1);

	evidence_of_college := not(ams_college_code = '') or not(ams_college_type = '');
	
	clg(boolean iscollege, integer age) := if(iscollege, 'Y','N') + (string)((integer)(min(age, 60) / 10) * 10);

	iv_college_attendance_x_age := map(
			not(truedid or dobpop) => '',
			_combined_age = -1     => '',
			clg(evidence_of_college, _combined_age) );
			
	iv_pb_total_orders := map(
			not(truedid)           => NULL,
			pb_total_orders = '' => -1,
			(integer) pb_total_orders);

	cs_curr_to_avg_lres_ratio := map(
			not(truedid)            => NULL,
			avg_mo_per_addr = -9999 => -1,
			unique_addr_count < 2   => -1,
			add1_isbestmatch        => add1_lres / avg_mo_per_addr,
																 add2_lres / avg_mo_per_addr);

	civ_subscore0 := map(
			NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => 0.098182,
			1 <= iv_pb_total_orders AND iv_pb_total_orders < 4   => -0.434040,
			4 <= iv_pb_total_orders                              => -0.646713,
																															0.000000);

	civ_subscore1 := map(
			NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => -0.062174,
			1 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 6   => 0.545294,
			6 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 12  => 0.244355,
			12 <= iv_inq_highriskcredit_recency                                        => 0.161709,
																																										0.000000);

	civ_subscore2 := map(
			NULL < (integer) iv_vs099_addr_not_ver_w_ssn AND 
			(integer) iv_vs099_addr_not_ver_w_ssn < 1      => -0.176022,
			1 <= (integer) iv_vs099_addr_not_ver_w_ssn     => 0.143309,
																												0.000000);

	civ_subscore3 := map(
			NULL < iv_addrs_10yr AND iv_addrs_10yr < 0 => -0.206939,
			0 <= iv_addrs_10yr AND iv_addrs_10yr < 2   => -0.233621,
			2 <= iv_addrs_10yr AND iv_addrs_10yr < 4   => -0.121306,
			4 <= iv_addrs_10yr AND iv_addrs_10yr < 7   => -0.045531,
			7 <= iv_addrs_10yr AND iv_addrs_10yr < 8   => 0.119463,
			8 <= iv_addrs_10yr AND iv_addrs_10yr < 10  => 0.192440,
			10 <= iv_addrs_10yr AND iv_addrs_10yr < 11 => 0.213274,
			11 <= iv_addrs_10yr AND iv_addrs_10yr < 12 => 0.330714,
			12 <= iv_addrs_10yr                        => 0.477893,
																										0.000000);

	civ_subscore4 := map(
			NULL < iv_dl001_unrel_lien60_count AND iv_dl001_unrel_lien60_count < 1 => -0.107297,
			1 <= iv_dl001_unrel_lien60_count AND iv_dl001_unrel_lien60_count < 3   => 0.072414,
			3 <= iv_dl001_unrel_lien60_count AND iv_dl001_unrel_lien60_count < 5   => 0.274677,
			5 <= iv_dl001_unrel_lien60_count                                       => 0.406767,
																																								0.000000);

	civ_subscore5 := map(
			NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 0 => 0.031978,
			0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 22  => 0.174706,
			22 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 29 => 0.145373,
			29 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 43 => -0.016006,
			43 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 59 => -0.182170,
			59 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 78 => -0.288960,
			78 <= iv_mos_since_gong_did_fst_seen                                         => -0.414431,
																																											0.000000);

	civ_subscore6 := map(
			NULL < iv_ag001_age AND iv_ag001_age < 25 => 0.323066,
			25 <= iv_ag001_age AND iv_ag001_age < 62  => -0.023808,
			62 <= iv_ag001_age                        => -0.510416,
																									 0.000000);

	civ_subscore7 := map(
			NULL < iv_inq_auto_count12 AND iv_inq_auto_count12 < 1 => 0.101621,
			1 <= iv_inq_auto_count12 AND iv_inq_auto_count12 < 2   => -0.086563,
			2 <= iv_inq_auto_count12                               => -0.213860,
																																0.000000);

	civ_subscore8 := map(
			NULL < iv_de001_eviction_recency AND iv_de001_eviction_recency < 3 => -0.054816,
			3 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 24  => 0.476701,
			24 <= iv_de001_eviction_recency                                    => 0.116612,
																																						0.000000);

	civ_subscore9 := map(
			NULL < iv_attr_purchase_recency AND iv_attr_purchase_recency < 1 => 0.037922,
			1 <= iv_attr_purchase_recency AND iv_attr_purchase_recency < 99  => -0.071054,
			99 <= iv_attr_purchase_recency                                   => -0.218497,
																																					0.000000);

	civ_subscore10 := map(
		iv_input_addr_not_most_recent = '' => 0.000000,
		  (integer) iv_input_addr_not_most_recent <= 0 => -0.030532,
	    (integer) iv_input_addr_not_most_recent >= 1 => 0.213818,
	                                              0.000000);

	civ_subscore11 := map(
			NULL < iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 7 => 0.023291,
			7 <= iv_sr001_source_profile_index                                         => -0.244985,
																																										0.000000);

	civ_subscore12 := map(
			NULL < iv_released_liens_ct AND iv_released_liens_ct < 1 => 0.030420,
			1 <= iv_released_liens_ct                                => -0.172568,
																																	0.000000);

	civ_subscore13 := map(
			NULL < iv_non_derog_count AND iv_non_derog_count < 1 => 0.000000,
			1 <= iv_non_derog_count AND iv_non_derog_count < 2   => 0.137132,
			2 <= iv_non_derog_count AND iv_non_derog_count < 3   => -0.023471,
			3 <= iv_non_derog_count                              => -0.043292,
																															0.000000);

	civ_subscore14 := map(
			NULL < iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 2 => -0.047191,
			2 <= iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 5   => 0.036280,
			5 <= iv_mi001_adlperssn_count                                    => 0.426784,
																																					0.000000);

	civ_subscore15 := map(
			NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => -0.015481,
			1 <= iv_ds001_impulse_count                                  => 0.296971,
																																			0.000000);

	civ_subscore16 := map(
			(iv_college_attendance_x_age in ['N10', 'N20', 'N30', 'N40', 'N50', 'N60']) => 0.014228,
			(iv_college_attendance_x_age in ['Y10', 'Y20', 'Y30', 'Y40', 'Y50', 'Y60']) => -0.327868,
																																										 0.000000);

	civ_subscore17 := map(
			NULL < cs_curr_to_avg_lres_ratio AND cs_curr_to_avg_lres_ratio < 0    => -0.110829,
			0 <= cs_curr_to_avg_lres_ratio AND cs_curr_to_avg_lres_ratio < 0.2    => 0.124833,
			0.2 <= cs_curr_to_avg_lres_ratio AND cs_curr_to_avg_lres_ratio < 2.06 => 0.008223,
			2.06 <= cs_curr_to_avg_lres_ratio                                     => -0.035032,
																																							 0.000000);

	civ_subscore18 := map(
			NULL < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr < 1  => -0.000000,
			1 <= iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr < 35   => 0.029605,
			35 <= iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr < 133 => -0.017229,
			133 <= iv_pl002_avg_mo_per_addr                                   => -0.214151,
																																					 0.000000);

	civ_subscore19 := map(
			(iv_criminal_x_felony in [' '])                                      => -0.000000,
			(iv_criminal_x_felony in ['0-0'])                                    => -0.010604,
			(iv_criminal_x_felony in ['1-0', '2-0', '3-0'])                      => 0.109507,
			(iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => 0.241536,
																																							0.000000);

	civ_subscore20 := map(
			(iv_bst_addr_financing_type in [' '])    => 0.000000,
			(iv_bst_addr_financing_type in ['OTH'])  => 0.000000,
			(iv_bst_addr_financing_type in ['ADJ'])  => 0.191134,
			(iv_bst_addr_financing_type in ['NONE']) => -0.004709,
			(iv_bst_addr_financing_type in ['CNV'])  => -0.086762,
																									0.000000);

	civ_subscore21 := map(
			iv_vs100_ssn_problem = '' => 0.000000, 
			NULL < (integer) iv_vs100_ssn_problem AND 
			(integer) iv_vs100_ssn_problem < 1    => -0.001571,
			1 <= (integer) iv_vs100_ssn_problem   => 0.075868,
																					     0.000000);

	civ_rawscore := civ_subscore0 +
			civ_subscore1 +
			civ_subscore2 +
			civ_subscore3 +
			civ_subscore4 +
			civ_subscore5 +
			civ_subscore6 +
			civ_subscore7 +
			civ_subscore8 +
			civ_subscore9 +
			civ_subscore10 +
			civ_subscore11 +
			civ_subscore12 +
			civ_subscore13 +
			civ_subscore14 +
			civ_subscore15 +
			civ_subscore16 +
			civ_subscore17 +
			civ_subscore18 +
			civ_subscore19 +
			civ_subscore20 +
			civ_subscore21;

	civ_lnoddsscore := civ_rawscore + -1.066584;

	civ_probscore := exp(civ_lnoddsscore) / (1 + exp(civ_lnoddsscore));

	point := 40;

	base := 700;

	odds := .2419 / .7581;

	_civ_transformed_score := round(point * (-civ_lnoddsscore + ln(odds)) / ln(2) + base);

	rva1311_1_0_1 := min(if(max(round(_civ_transformed_score), 501) = NULL, -NULL, max(round(_civ_transformed_score), 501)), 900);

	bk_flag := (rc_bansflag in ['1', '2']) or ver_src_BA or bankrupt or filing_count > 0 or bk_recent_count > 0;

	lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

	lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

	lien_flag := ver_src_L2 or lien_rec_unrel_flag or lien_hist_unrel_flag;

	ssn_deceased := rc_decsflag = '1' or ver_src_ds;

	scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, 
		sum(if(property_owned_total = NULL, 0, property_owned_total), 
			if(property_sold_total = NULL, 0, property_sold_total))) > 0 Or
			 (90 <= combo_dobscore AND 
			combo_dobscore <= 100 or 
			(integer) input_dob_match_level >= 7 or lien_flag or 
			criminal_count > 0 or
			bk_flag or ssn_deceased or truedid );

	rva1311_1_0 := map(
			ssn_deceased 		                                                                => 200,
			riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid) => 222,
																																												 rva1311_1_0_1);

	glrc24 := (integer) iv_vs099_addr_not_ver_w_ssn > 0;

	glrc97 := truedid and criminal_count > 0;

	glrc98 := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

	glrc99 := (integer) iv_input_addr_not_most_recent > 0;
 
	glrc9a := property_owned_total = 0;

	glrc9c := truedid and (avg_mo_per_addr != -9999) and unique_addr_count >= 2; 

	glrc9d := truedid and (iv_addrs_10yr >= 4 or -1 < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr < 133);

	glrc9e := truedid and add1_pop and attr_num_nonderogs < 3;

	glrc9f := (integer) hphnpop > 0;

	glrc9h := iv_ds001_impulse_count > 0;

	glrc9i := age < 30 and not(evidence_of_college);

	glrc9q := iv_inq_highriskcredit_recency > 0;

	glrc9r := truedid;

	glrc9v := (integer) iv_vs100_ssn_problem > 0 and (integer) ssnlength > 0;

	// glrc9y := truedid and iv_pb_total_orders > -1;

	glrcev := attr_eviction_count > 0;

	glrcmi := adlperssn_count > 1;

	glrcbl := 0;

	// rcvalue9y_1 := -(-0.646713 - civ_subscore0);

	// rcvalue9y := (integer)glrc9y * if(max(rcvalue9y_1) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1)));

	rcvalue9q_1 := -(-0.062174 - civ_subscore1);

	rcvalue9q := (integer)glrc9q * if(max(rcvalue9q_1) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1)));

	rcvalue24_1 := -(-0.176022 - civ_subscore2);

	rcvalue24 := (integer)glrc24 * if(max(rcvalue24_1) = NULL, NULL, sum(if(rcvalue24_1 = NULL, 0, rcvalue24_1)));

	rcvalue9d_1 := -(-0.233621 - civ_subscore3);

	rcvalue9d_2 := -(-0.214151 - civ_subscore18);

	rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1, rcvalue9d_2) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1), if(rcvalue9d_2 = NULL, 0, rcvalue9d_2)));

	rcvalue98_1 := -(-0.107297 - civ_subscore4);

	rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));

	rcvalue9f_1 := -(-0.414431 - civ_subscore5);

	rcvalue9f := (integer)glrc9f * if(max(rcvalue9f_1) = NULL, NULL, sum(if(rcvalue9f_1 = NULL, 0, rcvalue9f_1)));

	rcvalue9r_1 := -(-0.510416 - civ_subscore6);

	rcvalue9r_2 := -(-0.244985 - civ_subscore11);

	rcvalue9r := (integer)glrc9r * if(max(rcvalue9r_1, rcvalue9r_2) = NULL, NULL, sum(if(rcvalue9r_1 = NULL, 0, rcvalue9r_1), if(rcvalue9r_2 = NULL, 0, rcvalue9r_2)));

	rcvaluebl_1 := -(-0.213860 - civ_subscore7);

	rcvaluebl_2 := -(-0.172568 - civ_subscore12);

	rcvaluebl_3 := -(-0.086762 - civ_subscore20);

	rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3)));

	rcvalueev_1 := -(-0.054816 - civ_subscore8);

	rcvalueev := (integer)glrcev * if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

	rcvalue9a_1 := -(-0.218497 - civ_subscore9);

	rcvalue9a := (integer)glrc9a * if(max(rcvalue9a_1) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1)));

	rcvalue99_1 := -(-0.030532 - civ_subscore10);

	rcvalue99 := (integer)glrc99 * if(max(rcvalue99_1) = NULL, NULL, sum(if(rcvalue99_1 = NULL, 0, rcvalue99_1)));

	rcvalue9e_1 := -(-0.043292 - civ_subscore13);

	rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1)));

	rcvaluemi_1 := -(-0.047191 - civ_subscore14);

	rcvaluemi := (integer)glrcmi * if(max(rcvaluemi_1) = NULL, NULL, sum(if(rcvaluemi_1 = NULL, 0, rcvaluemi_1)));

	rcvalue9h_1 := -(-0.015481 - civ_subscore15);

	rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

	rcvalue9i_1 := -(-0.327868 - civ_subscore16);

	rcvalue9i := (integer)glrc9i * if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));

	rcvalue9c_1 := -(-0.035032 - civ_subscore17);

	rcvalue9c := (integer)glrc9c * if(max(rcvalue9c_1) = NULL, NULL, sum(if(rcvalue9c_1 = NULL, 0, rcvalue9c_1)));

	rcvalue97_1 := -(-0.010604 - civ_subscore19);

	rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1)));

	rcvalue9v_1 := -(-0.001571 - civ_subscore21);

	rcvalue9v := (integer)glrc9v * if(max(rcvalue9v_1) = NULL, NULL, sum(if(rcvalue9v_1 = NULL, 0, rcvalue9v_1)));

/*
rc_dataset_sorted := sort(rc_dataset, -rc_dataset.value);

rc1_2 := rc_dataset_sorted[1].rc;
rc2_1 := rc_dataset_sorted[2].rc;
rc3_1 := rc_dataset_sorted[3].rc;
rc4_1 := rc_dataset_sorted[4].rc;

rc5_1 := if(glrc9q > 0 & rc1_2 != '9Q' & rc2_1 != '9Q' & rc3_1 != '9Q' & rc4_1 != '9Q' & inq_count12 > 0, '9Q', '');

rc1_1 := map(
    rva1311_1_0 = 200 => '02',
    rva1311_1_0 = 222 => '9X',
                         rc1_2);

rc4 := map(
    rva1311_1_0 = 200 => '',
    rva1311_1_0 = 222 => '',
                         rc4_1);

rc2 := map(
    rva1311_1_0 = 200 => '',
    rva1311_1_0 = 222 => '',
                         rc2_1);

rc3 := map(
    rva1311_1_0 = 200 => '',
    rva1311_1_0 = 222 => '',
                         rc3_1);

rc5 := map(
    rva1311_1_0 = 200 => '',
    rva1311_1_0 = 222 => '',
                         rc5_1);

rc1 := if(rc1_1 = '' and rva1311_1_0 != 900, '36', rc1_1);
*/


		//*************************************************************************************//
		// I have no idea how the reason code logic gets implemented in ECL, so everything below 
		// probably needs to get changed or replaced.  The methodology for creating the reason codes is
		// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
		// that model code for guidance on implementing reason codes. 
		//*************************************************************************************//

		ds_layout := {STRING rc, REAL value};

		rc_dataset := DATASET([
			// {'9Y', RCValue9Y},
			{'9Q', RCValue9Q},
			{'24', RCValue24},
			{'9D', RCValue9D},
			{'98', RCValue98},
			{'9F', RCValue9F},
			{'9R', RCValue9R},
			{'BL', RCValueBL},
			{'EV', RCValueEV},
			{'9A', RCValue9A},
			{'99', RCValue99},
			{'9E', RCValue9E},
			{'MI', RCValueMI},
			{'9H', RCValue9H},
			{'9I', RCValue9I},
			{'9C', RCValue9C},
			{'97', RCValue97},
			{'9V', RCValue9V}
    ], ds_layout)(value > 0);

	rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes
	rcs_top := if(count(rcs_top4(rc != ''))=0, DATASET([{'36', NULL}], ds_layout), rcs_top4);
	
	rcs_9q := rcs_top & if(glrc9q AND (count(rcs_top4(rc='9Q')) =0) AND inq_count12 > 0, ROW({'9Q', NULL}, ds_layout));

	rcs_override := MAP(
											rva1311_1_0 = 200 => DATASET([{'02', NULL}], ds_layout),
											rva1311_1_0 = 222 => DATASET([{'9X', NULL}], ds_layout),
											rva1311_1_0 = 900 => DATASET([{'  ', NULL}], ds_layout),
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
		self.clam															:= le;
		self.sysdate                          := sysdate;                                              
		self.iv_pots_phone                    := iv_pots_phone;                                        
		self.iv_add_apt                       := iv_add_apt;                                           
		self.iv_ssn_deceased                  := iv_ssn_deceased;                                      
		self.iv_riskview_222s                 := iv_riskview_222s;                                     
		self.iv_vs099_addr_not_ver_w_ssn      := iv_vs099_addr_not_ver_w_ssn;                          
		self.iv_vs100_ssn_problem             := iv_vs100_ssn_problem;                                 
		self.iv_de001_eviction_recency        := iv_de001_eviction_recency;                            
		self.email_src_im                     := email_src_im;                                         
		self.iv_ds001_impulse_count           := iv_ds001_impulse_count;                               
		self.iv_dl001_unrel_lien60_count      := iv_dl001_unrel_lien60_count;                          
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
		self._in_dob                          := _in_dob;                                              
		self.yr_in_dob                        := yr_in_dob;                                            
		self.yr_in_dob_int                    := yr_in_dob_int;                                        
		self.age_estimate                     := age_estimate;                                         
		self.iv_ag001_age                     := iv_ag001_age;                                         
		self.iv_pl002_avg_mo_per_addr         := iv_pl002_avg_mo_per_addr;                             
		self.iv_input_addr_not_most_recent    := iv_input_addr_not_most_recent;                        
		self.iv_bst_addr_financing_type       := iv_bst_addr_financing_type;                           
		self.iv_addrs_10yr                    := iv_addrs_10yr;                                        
		self._gong_did_first_seen             := _gong_did_first_seen;                                 
		self.iv_mos_since_gong_did_fst_seen   := iv_mos_since_gong_did_fst_seen;                       
		self.iv_inq_auto_count12              := iv_inq_auto_count12;                                  
		self.iv_inq_highriskcredit_recency    := iv_inq_highriskcredit_recency;                        
		self.iv_attr_purchase_recency         := iv_attr_purchase_recency;                             
		self.iv_non_derog_count               := iv_non_derog_count;                                   
		self.iv_released_liens_ct             := iv_released_liens_ct;                                 
		self.iv_criminal_x_felony             := iv_criminal_x_felony;                                 
		self._reported_dob                    := _reported_dob;                                        
		self.reported_age                     := reported_age;                                         
		self._combined_age                    := _combined_age;                                        
		self.evidence_of_college              := evidence_of_college;                                  
		self.iv_college_attendance_x_age      := iv_college_attendance_x_age;                          
		self.iv_pb_total_orders               := iv_pb_total_orders;                                   
		self.cs_curr_to_avg_lres_ratio        := cs_curr_to_avg_lres_ratio;                            
		self.civ_subscore0                    := civ_subscore0;                                        
		self.civ_subscore1                    := civ_subscore1;                                        
		self.civ_subscore2                    := civ_subscore2;                                        
		self.civ_subscore3                    := civ_subscore3;                                        
		self.civ_subscore4                    := civ_subscore4;                                        
		self.civ_subscore5                    := civ_subscore5;                                        
		self.civ_subscore6                    := civ_subscore6;                                        
		self.civ_subscore7                    := civ_subscore7;                                        
		self.civ_subscore8                    := civ_subscore8;                                        
		self.civ_subscore9                    := civ_subscore9;                                        
		self.civ_subscore10                   := civ_subscore10;                                       
		self.civ_subscore11                   := civ_subscore11;                                       
		self.civ_subscore12                   := civ_subscore12;                                       
		self.civ_subscore13                   := civ_subscore13;                                       
		self.civ_subscore14                   := civ_subscore14;                                       
		self.civ_subscore15                   := civ_subscore15;                                       
		self.civ_subscore16                   := civ_subscore16;                                       
		self.civ_subscore17                   := civ_subscore17;                                       
		self.civ_subscore18                   := civ_subscore18;                                       
		self.civ_subscore19                   := civ_subscore19;                                       
		self.civ_subscore20                   := civ_subscore20;                                       
		self.civ_subscore21                   := civ_subscore21;                                       
		self.civ_rawscore                     := civ_rawscore;                                         
		self.civ_lnoddsscore                  := civ_lnoddsscore;                                      
		self.civ_probscore                    := civ_probscore;                                        
		self.point                            := point;                                                
		self.base                             := base;                                                 
		self.odds                             := odds;                                                 
		self._civ_transformed_score           := _civ_transformed_score;                               
		self.bk_flag                          := bk_flag;                                              
		self.lien_rec_unrel_flag              := lien_rec_unrel_flag;                                  
		self.lien_hist_unrel_flag             := lien_hist_unrel_flag;                                 
		self.lien_flag                        := lien_flag;                                            
		self.ssn_deceased                     := ssn_deceased;                                         
		self.scored_222s                      := scored_222s;                                          
		self.rva1311_1_0                      := rva1311_1_0;                                          
		self.glrc24                           := glrc24;                                               
		self.glrc97                           := glrc97;                                               
		self.glrc98                           := glrc98;                                               
		self.glrc99                           := glrc99;                                               
		self.glrc9a                           := glrc9a;                                               
		self.glrc9c                           := glrc9c;                                               
		self.glrc9d                           := glrc9d;                                               
		self.glrc9e                           := glrc9e;                                               
		self.glrc9f                           := glrc9f;                                               
		self.glrc9h                           := glrc9h;                                               
		self.glrc9i                           := glrc9i;                                               
		self.glrc9q                           := glrc9q;                                               
		self.glrc9r                           := glrc9r;                                               
		self.glrc9v                           := glrc9v;                                               
		// self.glrc9y                           := glrc9y;                                               
		self.glrcev                           := glrcev;                                               
		self.glrcmi                           := glrcmi;                                               
		self.glrcbl                           := glrcbl;                                               
		// self.rcvalue9y_1                      := rcvalue9y_1;                                          
		// self.rcvalue9y                        := rcvalue9y;                                            
		self.rcvalue9q_1                      := rcvalue9q_1;                                          
		self.rcvalue9q                        := rcvalue9q;                                            
		self.rcvalue24_1                      := rcvalue24_1;                                          
		self.rcvalue24                        := rcvalue24;                                            
		self.rcvalue9d_1                      := rcvalue9d_1;                                          
		self.rcvalue9d_2                      := rcvalue9d_2;                                          
		self.rcvalue9d                        := rcvalue9d;                                            
		self.rcvalue98_1                      := rcvalue98_1;                                          
		self.rcvalue98                        := rcvalue98;                                            
		self.rcvalue9f_1                      := rcvalue9f_1;                                          
		self.rcvalue9f                        := rcvalue9f;                                            
		self.rcvalue9r_1                      := rcvalue9r_1;                                          
		self.rcvalue9r_2                      := rcvalue9r_2;                                          
		self.rcvalue9r                        := rcvalue9r;                                            
		self.rcvaluebl_1                      := rcvaluebl_1;                                          
		self.rcvaluebl_2                      := rcvaluebl_2;                                          
		self.rcvaluebl_3                      := rcvaluebl_3;                                          
		self.rcvaluebl                        := rcvaluebl;                                            
		self.rcvalueev_1                      := rcvalueev_1;                                          
		self.rcvalueev                        := rcvalueev;                                            
		self.rcvalue9a_1                      := rcvalue9a_1;                                          
		self.rcvalue9a                        := rcvalue9a;                                            
		self.rcvalue99_1                      := rcvalue99_1;                                          
		self.rcvalue99                        := rcvalue99;                                            
		self.rcvalue9e_1                      := rcvalue9e_1;                                          
		self.rcvalue9e                        := rcvalue9e;                                            
		self.rcvaluemi_1                      := rcvaluemi_1;                                          
		self.rcvaluemi                        := rcvaluemi;                                            
		self.rcvalue9h_1                      := rcvalue9h_1;                                          
		self.rcvalue9h                        := rcvalue9h;                                            
		self.rcvalue9i_1                      := rcvalue9i_1;                                          
		self.rcvalue9i                        := rcvalue9i;                                            
		self.rcvalue9c_1                      := rcvalue9c_1;                                          
		self.rcvalue9c                        := rcvalue9c;                                            
		self.rcvalue97_1                      := rcvalue97_1;                                          
		self.rcvalue97                        := rcvalue97;                                            
		self.rcvalue9v_1                      := rcvalue9v_1;                                          
		self.rcvalue9v                        := rcvalue9v;                                            
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
											(string3)rva1311_1_0
										);
	END;

	model := project( clam, doModel(left) );

	return model;
END;