//Strategic Link Consulting Score - FCRA 4.1

import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVG1401_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVG_DEBUG := FALSE;

  #if(RVG_DEBUG)
    layout_debug := record
			integer sysdate;               
			boolean ver_src_ba_pos;        
			boolean ver_src_ba;            
			boolean ver_src_ds_pos;        
			boolean ver_src_ds;            
			boolean ver_src_l2_pos;        
			boolean ver_src_l2;            
			string iv_vp002_phn_disconnected;
			integer bureau_adl_tn_fseen_pos  ;
			string bureau_adl_fseen_tn;   
			integer _bureau_adl_fseen_tn;  
			integer bureau_adl_ts_fseen_pos;
			string bureau_adl_fseen_ts;   
			integer _bureau_adl_fseen_ts;  
			integer bureau_adl_tu_fseen_pos  ;
			string bureau_adl_fseen_tu;   
			integer _bureau_adl_fseen_tu;  
			integer bureau_adl_en_fseen_pos ;
			string bureau_adl_fseen_en;   
			integer _bureau_adl_fseen_en;  
			integer bureau_adl_eq_fseen_pos ;
			string bureau_adl_fseen_eq;   
			integer _bureau_adl_fseen_eq;  
			real iv_sr001_m_bureau_adl_fs;
			integer iv_ms001_ssns_per_adl; 
			integer iv_pv001_bst_avm_autoval;
			boolean prop_adl_p_fseen_pos;  
			string prop_adl_fseen_p;      
			integer _prop_adl_fseen_p;     
			integer _src_prop_adl_fseen;   
			real iv_pl001_m_snc_prop_adl_fs;
			integer iv_in001_estimated_income;
			integer emerge_adl_em_count_pos;
			integer emerge_adl_count_em;   
			integer emerge_adl_e1_count_pos;
			integer emerge_adl_count_e1;   
			integer emerge_adl_e2_count_pos;
			integer emerge_adl_count_e2;   
			integer emerge_adl_e3_count_pos ;
			integer emerge_adl_count_e3;   
			integer emerge_adl_e4_count_pos ;
			integer emerge_adl_count_e4;   
			integer iv_src_emerge_adl_count;
			integer iv_prv_addr_avm_auto_val;
			integer iv_prop_owned_purchase_total;
			integer iv_prop_sold_purchase_total;
			integer iv_paw_source_count;   
			boolean ver_phn_inf;           
			boolean ver_phn_nap;           
			integer inf_phn_ver_lvl;       
			integer nap_phn_ver_lvl;       
			string iv_nap_phn_ver_x_inf_phn_ver;
			integer iv_email_count;        
			string iv_rec_vehx_level;     
			integer iv_eviction_count;     
			integer iv_filing_count;       
			integer _reported_dob;         
			real reported_age;          
			integer _combined_age;         
			boolean evidence_of_college;   
			string iv_college_attendance_x_age;
			string iv_prof_license_category;
			integer sum_dols;              
			real pct_offline_dols;      
			real pct_retail_dols;       
			real pct_online_dols;       
			string iv_pb_profile;         
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
			real cs_pct_addrs_le_12mo;  
			real cs_outstanding_liens_ct;
			real vip_a_subscore0;       
			real vip_a_subscore1;       
			real vip_a_subscore2;       
			real vip_a_subscore3;       
			real vip_a_subscore4;       
			real vip_a_subscore5;       
			real vip_a_subscore6;       
			real vip_a_subscore7;       
			real vip_a_subscore8;       
			real vip_a_subscore9;       
			real vip_a_subscore10;      
			real vip_a_subscore11;      
			real vip_a_subscore12;      
			real vip_a_subscore13;      
			real vip_a_subscore14;      
			real vip_a_subscore15;      
			real vip_a_subscore16;      
			real vip_a_subscore17;      
			real vip_a_subscore18;      
			real vip_a_subscore19;      
			real vip_a_subscore20;      
			real vip_a_subscore21;      
			real vip_a_scaledscore;     
			integer base;                  
			real scale;                 
			integer _rvg1401_1_0;          
			boolean bk_flag;               
			boolean lien_rec_unrel_flag;   
			boolean lien_hist_unrel_flag;  
			boolean lien_flag;             
			boolean ssn_deceased;          
			boolean scored_222s;           
			integer rvg1401_1_0;           
			boolean glrc36;                
			boolean glrc98;                
			boolean glrc9c;                
			boolean glrc9d;                
			boolean glrc9e;                
			boolean glrc9i;                
			boolean glrc9r;                
			boolean glrc9t;                
			boolean glrc9w;                
			// boolean glrc9y;                
			boolean glrcev;                
			boolean glrcms;                
			boolean glrcpv;                
			boolean glrcbl;                
			real rcvaluepv_1;           
			real rcvaluepv_2;           
			real rcvaluepv_3;           
			real rcvaluepv;             
			real rcvalue9r_1;           
			real rcvalue9r_2;           
			real rcvalue9r_3;           
			real rcvalue9r;             
			real rcvalue9e_1;           
			real rcvalue9e_2;           
			real rcvalue9e_3;           
			real rcvalue9e_4;           
			real rcvalue9e;             
			real rcvaluebl_1;           
			real rcvaluebl_2;           
			real rcvaluebl_3;           
			real rcvaluebl;             
			// real rcvalue9y_1;           
			// real rcvalue9y;             
			real rcvaluems_1;           
			real rcvaluems;             
			real rcvalue9t_1;           
			real rcvalue9t;             
			real rcvalue36_1;           
			real rcvalue36;             
			real rcvalue9w_1;           
			real rcvalue9w;             
			real rcvalue9d_1;           
			real rcvalue9c_1;           
			real rcvalue9c;             
			real rcvalue9d;             
			real rcvalueev_1;           
			real rcvalueev;             
			real rcvalue9i_1;           
			real rcvalue9i;             
			real rcvalue98_1;           
			real rcvalue98;             
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
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_status                       := le.iid.nap_status;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	addrpop                          := le.input_validation.address;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	age                              := le.name_verification.age;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_lres                        := le.lres;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_owned_purchase_total    := le.address_verification.owned.property_owned_purchase_total;
	property_sold_total              := le.address_verification.sold.property_total;
	property_sold_purchase_total     := le.address_verification.sold.property_owned_purchase_total;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add3_avm_automated_valuation     := le.avm.address_history_2.avm_automated_valuation;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	addr_lres_12mo_count             := le.address_history_summary.lres_12mo_count;
	header_first_seen                := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	inq_count12                      := le.acc_logs.inquiries.count12;
	pb_number_of_sources             := le.ibehavior.number_of_sources;
	pb_offline_dollars               := le.ibehavior.offline_dollars;
	pb_online_dollars                := le.ibehavior.online_dollars;
	pb_retail_dollars                := le.ibehavior.retail_dollars;
	paw_first_seen                   := le.employment.first_seen_date;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	paw_source_count                 := le.employment.source_ct;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	infutor_last_seen                := le.infutor_phone.infutor_date_last_seen;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	email_count                      := le.email_summary.email_ct;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_eviction_count              := le.bjl.eviction_count;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_recent_released_count      := le.bjl.liens_recent_released_count;
	liens_historical_released_count  := le.bjl.liens_historical_released_count;
	criminal_count                   := le.bjl.criminal_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	ams_age                          := le.student.age;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	prof_license_category            := le.professional_license.plcategory;
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


	INTEGER year(integer sas_date) :=
		if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));

	sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

	ver_src_ba_pos := Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie');

	ver_src_ba := ver_src_ba_pos > 0;

	ver_src_ds_pos := Models.Common.findw_cpp(ver_sources, 'DS' , '  ,', 'ie');

	ver_src_ds := ver_src_ds_pos > 0;

	ver_src_l2_pos := Models.Common.findw_cpp(ver_sources, 'L2' , '  ,', 'ie');

	ver_src_l2 := ver_src_l2_pos > 0;

	iv_vp002_phn_disconnected := map(
			not(hphnpop)                                                             => ' ',
			rc_hriskphoneflag = '5' or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D' => '1',
																																									'0');

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

	iv_pv001_bst_avm_autoval := map(
			not(truedid)     => NULL,
			add1_isbestmatch => add1_avm_automated_valuation,
													add2_avm_automated_valuation);

	prop_adl_p_fseen_pos := Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E');

	prop_adl_fseen_p := if(prop_adl_p_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, prop_adl_p_fseen_pos, ','));

	_prop_adl_fseen_p := common.sas_date((string)(prop_adl_fseen_p));

	_src_prop_adl_fseen := _prop_adl_fseen_p;

	iv_pl001_m_snc_prop_adl_fs := map(
			not(truedid)               => NULL,
			_src_prop_adl_fseen = NULL => -1,
																		if ((sysdate - _src_prop_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_prop_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_prop_adl_fseen) / (365.25 / 12))));

	iv_in001_estimated_income := if(not(truedid), NULL, estimated_income);

	emerge_adl_em_count_pos := Models.Common.findw_cpp(ver_sources, 'EM' , ', ', 'E');

	emerge_adl_count_em := if(emerge_adl_em_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_em_count_pos, ','));

	emerge_adl_e1_count_pos := Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E');

	emerge_adl_count_e1 := if(emerge_adl_e1_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_e1_count_pos, ','));

	emerge_adl_e2_count_pos := Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E');

	emerge_adl_count_e2 := if(emerge_adl_e2_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_e2_count_pos, ','));

	emerge_adl_e3_count_pos := Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E');

	emerge_adl_count_e3 := if(emerge_adl_e3_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_e3_count_pos, ','));

	emerge_adl_e4_count_pos := Models.Common.findw_cpp(ver_sources, 'E4' , ', ', 'E');

	emerge_adl_count_e4 := if(emerge_adl_e4_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_e4_count_pos, ','));

	iv_src_emerge_adl_count := if(not(truedid), NULL, max(if(max(emerge_adl_count_em, emerge_adl_count_e1, emerge_adl_count_e2, emerge_adl_count_e3, emerge_adl_count_e4) = NULL, NULL, sum(if(emerge_adl_count_em = NULL, 0, emerge_adl_count_em), if(emerge_adl_count_e1 = NULL, 0, emerge_adl_count_e1), if(emerge_adl_count_e2 = NULL, 0, emerge_adl_count_e2), if(emerge_adl_count_e3 = NULL, 0, emerge_adl_count_e3), if(emerge_adl_count_e4 = NULL, 0, emerge_adl_count_e4))), (real)0));

	iv_prv_addr_avm_auto_val := map(
			not(truedid)     => NULL,
			add1_isbestmatch => add2_avm_automated_valuation,
													add3_avm_automated_valuation);

	iv_prop_owned_purchase_total := if(not(truedid or add1_pop), NULL, property_owned_purchase_total);

	iv_prop_sold_purchase_total := if(not(truedid or add1_pop), NULL, property_sold_purchase_total);

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

	iv_email_count := if(not(truedid), NULL, email_count);

	iv_rec_vehx_level := map(
			not(truedid)                                   => '  ',
			attr_num_aircraft > 0 and watercraft_count > 0 => 'AW',
			attr_num_aircraft > 0                          => 'AO',
			watercraft_count > 0                           => trim('W', LEFT, RIGHT) + trim((string) min(if(watercraft_count = NULL, -NULL, watercraft_count), 3), LEFT, RIGHT),
																												'XX');

	iv_eviction_count := if(not(truedid), NULL, attr_eviction_count);

	iv_filing_count := if(not(truedid), NULL, filing_count);

	_reported_dob := common.sas_date((string)(reported_dob));

	reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

	_combined_age := map(
			age > 0          					 => age,
			(integer) input_dob_age > 0 => (integer) input_dob_age,
			inferred_age > 0      			=> inferred_age,
			reported_age > 0      			=> reported_age,
			(integer) ams_age > 0  			=> (integer) ams_age,
													 -1);

	evidence_of_college := not(ams_college_code = '') or not(ams_college_type = '');
	
	clg(boolean iscollege, integer age) := if(iscollege, 'Y','N') + (string)((integer)(min(age, 60) / 10) * 10);

	iv_college_attendance_x_age := map(
			not(truedid or dobpop) => '',
			_combined_age = -1     => '',
		clg(evidence_of_college, _combined_age) );
	
	iv_prof_license_category := map(
			not(truedid)                 => '  ',
			prof_license_category = '' => '-1',
			prof_license_category);

	sum_dols := if(max((integer) pb_offline_dollars, (integer) pb_online_dollars, (integer) pb_retail_dollars) = NULL, NULL, 
			sum(if((integer) pb_offline_dollars = NULL, 0, (integer) pb_offline_dollars), 
			if((integer) pb_online_dollars = NULL, 0, (integer) pb_online_dollars), 
			if((integer) pb_retail_dollars = NULL, 0, (integer) pb_retail_dollars)));

	pct_offline_dols := if(sum_dols > 0, (integer) pb_offline_dollars / sum_dols, -1);

	pct_retail_dols := if(sum_dols > 0, (integer) pb_retail_dollars / sum_dols, -1);

	pct_online_dols := if(sum_dols > 0, (integer) pb_online_dollars / sum_dols, -1);

	iv_pb_profile := map(
			not(truedid)                => '                 ',
			(integer) pb_number_of_sources = NULL => '0 No Purch Data  ',
			(string) pb_number_of_sources = '' => '0 No Purch Data  ',
			pct_offline_dols > .50      => '1 Offline Shopper',
			pct_online_dols > .50       => '2 Online Shopper ',
			pct_retail_dols > .50       => '3 Retail Shopper ',
																		 '4 Other');

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

	cs_pct_addrs_le_12mo := map(
			not(truedid)                 => NULL,
			addr_lres_12mo_count = -9999 => -1,
																			addr_lres_12mo_count / unique_addr_count * 100);

	cs_outstanding_liens_ct := if(not(truedid), NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) - if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))));

	vip_a_subscore0 := map(
			NULL < iv_in001_estimated_income AND iv_in001_estimated_income < 24000   => -51.614598,
			24000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 38000 => -21.449153,
			38000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 65000 => 25.852779,
			65000 <= iv_in001_estimated_income                                       => 58.937380,
																																									0.000000);

	vip_a_subscore1 := map(
			iv_prof_license_category = '' => 0.000000,
		  iv_prof_license_category = '-1' => -5.233899,
			NULL < (integer) iv_prof_license_category AND (integer) iv_prof_license_category < 4 => -5.233899,
			4 <= (integer) iv_prof_license_category                                    => 112.323007,
																																					0.000000);

	vip_a_subscore2 := map(
			NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 4208     => -13.389242,
			4208 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 63913   => -33.664331,
			63913 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 164003 => -6.201808,
			164003 <= iv_pv001_bst_avm_autoval                                      => 36.084841,
																																								 0.000000);

	vip_a_subscore3 := map(
			NULL < iv_sr001_source_profile AND iv_sr001_source_profile < 54.7  => -27.940173,
			54.7 <= iv_sr001_source_profile AND iv_sr001_source_profile < 80.2 => -4.274537,
			80.2 <= iv_sr001_source_profile AND iv_sr001_source_profile < 88.5 => 14.745442,
			88.5 <= iv_sr001_source_profile                                    => 127.782535,
																																						-0.000000);

	vip_a_subscore4 := map(
			NULL < iv_email_count AND iv_email_count < 1 => 23.217552,
			1 <= iv_email_count AND iv_email_count < 5   => 2.482006,
			5 <= iv_email_count AND iv_email_count < 10  => -13.658061,
			10 <= iv_email_count                         => -116.455500,
																											0.000000);

	vip_a_subscore5 := map(
			(iv_pb_profile in [' '])                 => -0.000000,
			(iv_pb_profile in ['0 No Purch Data'])   => -28.780341,
			(iv_pb_profile in ['1 Offline Shopper']) => -3.703102,
			(iv_pb_profile in ['2 Online Shopper'])  => 15.630433,
			(iv_pb_profile in ['3 Retail Shopper'])  => 21.078546,
			(iv_pb_profile in ['4 Other'])           => 48.407119,
																									-0.000000);

	vip_a_subscore6 := map(
			NULL < iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs < 1   => -19.239740,
			1 <= iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs < 129   => 2.390113,
			129 <= iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs < 262 => 16.854940,
			262 <= iv_pl001_m_snc_prop_adl_fs                                      => 56.583522,
																																								0.000000);

	vip_a_subscore7 := map(
			NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 9.922663,
			2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -10.121023,
			3 <= iv_ms001_ssns_per_adl                                 => -55.066518,
																																		-0.000000);

	vip_a_subscore8 := map(
			NULL < iv_paw_source_count AND iv_paw_source_count < 1 => -6.750063,
			1 <= iv_paw_source_count                               => 32.936337,
																																0.000000);

	vip_a_subscore9 := map(
			NULL < iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 176 => -30.166196,
			176 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 204 => -20.124895,
			204 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 242 => -7.635401,
			242 <= iv_sr001_m_bureau_adl_fs                                    => 9.791654,
																																						0.000000);

	vip_a_subscore10 := map(
			NULL < iv_src_emerge_adl_count AND iv_src_emerge_adl_count < 1 => -6.971468,
			1 <= iv_src_emerge_adl_count                                   => 28.489003,
																																				0.000000);

	vip_a_subscore11 := map(
			iv_vp002_phn_disconnected = '' =>  0.000000,
			iv_vp002_phn_disconnected = '-1' =>  1.647292,
			NULL < (integer) iv_vp002_phn_disconnected AND (integer) iv_vp002_phn_disconnected < 1 => 1.647292,
			1 <= (integer) iv_vp002_phn_disconnected                                     => -118.886266,
																																						0.000000);

	vip_a_subscore12 := map(
			NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 5143      => 2.555583,
			5143 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 128391   => -25.262859,
			128391 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 301517 => 7.117229,
			301517 <= iv_prv_addr_avm_auto_val                                       => 27.909816,
																																									-0.000000);

	vip_a_subscore13 := map(
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-0'])                                                         => -27.380126,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0', '1-1', '1-3', '2-0', '2-1', '2-3', '3-1', '3-3']) => 2.171157,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-3'])                                                         => 10.205185,
			(iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                                         => 14.785535,
																																																					 0.000000);

	vip_a_subscore14 := map(
			NULL < iv_filing_count AND iv_filing_count < 1 => 5.449708,
			1 <= iv_filing_count AND iv_filing_count < 2   => -24.626837,
			2 <= iv_filing_count                           => -63.190460,
																												-0.000000);

	vip_a_subscore15 := map(
			NULL < iv_prop_sold_purchase_total AND iv_prop_sold_purchase_total < 535000 => -0.733524,
			535000 <= iv_prop_sold_purchase_total                                       => 51.661028,
																																										 0.000000);

	vip_a_subscore16 := map(
			NULL < iv_prop_owned_purchase_total AND iv_prop_owned_purchase_total < 171500 => -1.656411,
			171500 <= iv_prop_owned_purchase_total                                        => 20.429074,
																																											 -0.000000);

	vip_a_subscore17 := map(
			NULL < cs_pct_addrs_le_12mo AND cs_pct_addrs_le_12mo < 0   => 0.000000,
			0 <= cs_pct_addrs_le_12mo AND cs_pct_addrs_le_12mo < 26.66 => 3.875376,
			26.66 <= cs_pct_addrs_le_12mo                              => -5.667320,
																																		0.000000);

	vip_a_subscore18 := map(
			(iv_rec_vehx_level in [' '])              => 0.000000,
			(iv_rec_vehx_level in ['W1', 'W2', 'W3']) => 36.680943,
			(iv_rec_vehx_level in ['XX'])             => -0.615703,
																									 0.000000);

	vip_a_subscore19 := map(
			NULL < iv_eviction_count AND iv_eviction_count < 1 => 1.279353,
			1 <= iv_eviction_count                             => -15.694723,
																														-0.000000);

	vip_a_subscore20 := map(
			(iv_college_attendance_x_age in ['N20', 'N30', 'N40', 'N50', 'N60']) => -1.399841,
			(iv_college_attendance_x_age in ['Y20', 'Y30', 'Y40', 'Y50', 'Y60']) => 10.615959,
																																							0.000000);

	vip_a_subscore21 := map(
			NULL < cs_outstanding_liens_ct AND cs_outstanding_liens_ct < 1 => 1.119280,
			1 <= cs_outstanding_liens_ct AND cs_outstanding_liens_ct < 6   => -1.724250,
			6 <= cs_outstanding_liens_ct                                   => -19.460991,
																																				0.000000);

	vip_a_scaledscore := vip_a_subscore0 +
			vip_a_subscore1 +
			vip_a_subscore2 +
			vip_a_subscore3 +
			vip_a_subscore4 +
			vip_a_subscore5 +
			vip_a_subscore6 +
			vip_a_subscore7 +
			vip_a_subscore8 +
			vip_a_subscore9 +
			vip_a_subscore10 +
			vip_a_subscore11 +
			vip_a_subscore12 +
			vip_a_subscore13 +
			vip_a_subscore14 +
			vip_a_subscore15 +
			vip_a_subscore16 +
			vip_a_subscore17 +
			vip_a_subscore18 +
			vip_a_subscore19 +
			vip_a_subscore20 +
			vip_a_subscore21;

	base := 694;

	scale := 0.55;

	_rvg1401_1_0 := round(min(if(max(base + scale * vip_a_scaledscore, (real)501) = NULL, -NULL, max(base + scale * vip_a_scaledscore, (real)501)), 900));

	bk_flag := (rc_bansflag in ['1', '2']) or ver_src_ba or bankrupt or filing_count > 0 or bk_recent_count > 0;

	lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

	lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

	lien_flag := ver_src_l2 or lien_rec_unrel_flag or lien_hist_unrel_flag;

	ssn_deceased := rc_decsflag = '1' or ver_src_ds;

	scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if( property_sold_total = NULL, 0, property_sold_total))) > 0 or 90 <= combo_dobscore AND combo_dobscore <= 100 or (integer) input_dob_match_level >= 7 or lien_flag or criminal_count > 0 or bk_flag or ssn_deceased or truedid;

	rvg1401_1_0 := map(
			ssn_deceased 			                                                              => 200,
			riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid) => 222,
																																												 _rvg1401_1_0);

	glrc36 := addrpop and hphnpop and nap_phn_ver_lvl != 3 and inf_phn_ver_lvl != 3;

	glrc98 := if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct, liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct), if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) > 0;

	glrc9c := truedid and add1_lres < 48;

	glrc9d := addrs_10yr >= 3;

	glrc9e := truedid and add1_pop;

	glrc9i := age < 30 and not(evidence_of_college);

	glrc9r := truedid;

	glrc9t := hphnpop;

	glrc9w := filing_count > 0;

	// glrc9y := (iv_pb_profile in ['0 No Purch Data']);

	glrcev := attr_eviction_count > 0;

	glrcms := ssns_per_adl > 1;

	glrcpv := truedid and addrpop and 0 < add1_avm_automated_valuation AND add1_avm_automated_valuation < 150000;

	glrcbl := 0;

	rcvaluepv_1 := 36.084841 - vip_a_subscore2;

	rcvaluepv_2 := 27.909816 - vip_a_subscore12;

	rcvaluepv_3 := 20.429074 - vip_a_subscore16;

	rcvaluepv := (integer)glrcpv * if(max(rcvaluepv_1, rcvaluepv_2, rcvaluepv_3) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1), if(rcvaluepv_2 = NULL, 0, rcvaluepv_2), if(rcvaluepv_3 = NULL, 0, rcvaluepv_3)));

	rcvalue9r_1 := 127.782535 - vip_a_subscore3;

	rcvalue9r_2 := 56.583522 - vip_a_subscore6;

	rcvalue9r_3 := 9.791654 - vip_a_subscore9;

	rcvalue9r := (integer)glrc9r * if(max(rcvalue9r_1, rcvalue9r_2, rcvalue9r_3) = NULL, NULL, sum(if(rcvalue9r_1 = NULL, 0, rcvalue9r_1), if(rcvalue9r_2 = NULL, 0, rcvalue9r_2), if(rcvalue9r_3 = NULL, 0, rcvalue9r_3)));

	rcvalue9e_1 := 32.936337 - vip_a_subscore8;

	rcvalue9e_2 := 28.489003 - vip_a_subscore10;

	rcvalue9e_3 := 112.323007 - vip_a_subscore1;

	rcvalue9e_4 := 36.680943 - vip_a_subscore18;

	rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1, rcvalue9e_2, rcvalue9e_3, rcvalue9e_4) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1), if(rcvalue9e_2 = NULL, 0, rcvalue9e_2), if(rcvalue9e_3 = NULL, 0, rcvalue9e_3), if(rcvalue9e_4 = NULL, 0, rcvalue9e_4)));

	rcvaluebl_1 := 23.217552 - vip_a_subscore4;

	rcvaluebl_2 := 58.937380 - vip_a_subscore0;

	rcvaluebl_3 := 51.661028 - vip_a_subscore15;

	rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3)));

	// rcvalue9y_1 := 48.407119 - vip_a_subscore5;

	// rcvalue9y := (integer)glrc9y * if(max(rcvalue9y_1) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1)));

	rcvaluems_1 := 9.922663 - vip_a_subscore7;

	rcvaluems := (integer)glrcms * if(max(rcvaluems_1) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1)));

	rcvalue9t_1 := 1.647292 - vip_a_subscore11;

	rcvalue9t := (integer)glrc9t * if(max(rcvalue9t_1) = NULL, NULL, sum(if(rcvalue9t_1 = NULL, 0, rcvalue9t_1)));

	rcvalue36_1 := 14.785535 - vip_a_subscore13;

	rcvalue36 := (integer)glrc36 * if(max(rcvalue36_1) = NULL, NULL, sum(if(rcvalue36_1 = NULL, 0, rcvalue36_1)));

	rcvalue9w_1 := 5.449708 - vip_a_subscore14;

	rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1)));

	rcvalue9d_1 := map(
			unique_addr_count = 1 => NULL,
			unique_addr_count = 0 => 0.000000,
															 3.875376 - vip_a_subscore17);

	rcvalue9c_1 := map(
			unique_addr_count = 1 => 3.875376 - vip_a_subscore17,
															 NULL);

	rcvalue9c := (integer)glrc9c * if(max(rcvalue9c_1) = NULL, NULL, sum(if(rcvalue9c_1 = NULL, 0, rcvalue9c_1)));

	rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

	rcvalueev_1 := 1.279353 - vip_a_subscore19;

	rcvalueev := (integer)glrcev * if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

	rcvalue9i_1 := 10.615959 - vip_a_subscore20;

	rcvalue9i := (integer)glrc9i * if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));

	rcvalue98_1 := 1.119280 - vip_a_subscore21;

	rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

	ds_layout := {STRING rc, REAL value};
	rc_dataset := DATASET([
			{'PV', RCValuePV},
			{'9R', RCValue9R},
			{'9E', RCValue9E},
			{'BL', RCValueBL},
			// {'9Y', RCValue9Y},
			{'MS', RCValueMS},
			{'9T', RCValue9T},
			{'36', RCValue36},
			{'9W', RCValue9W},
			{'9C', RCValue9C},
			{'9D', RCValue9D},
			{'EV', RCValueEV},
			{'9I', RCValue9I},
			{'98', RCValue98}
			], ds_layout)(value > 0);
		
	rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes

	glrc9q := inq_count12 > 0;	
	
	rcs_9q1 := rcs_top4[1];
	rcs_9q2 := rcs_top4[2];
	rcs_9q3 := rcs_top4[3];
	rcs_9q4 := rcs_top4[4];
	rcs_9q5 := IF((count(rcs_top4(rc='9Q')) =0) AND inq_count12 > 0, ROW({'9Q', NULL}, ds_layout));																				// If so - make it the 5th reason code.
		
	rcs_9q := rcs_9q1 & rcs_9q2 & rcs_9q3 & rcs_9q4 & rcs_9q5;

	rcs_override := MAP(
											rvg1401_1_0 = 200 							=> DATASET([{'02', NULL}], ds_layout),
											rvg1401_1_0 = 222 							=> DATASET([{'9X', NULL}], ds_layout),
											rvg1401_1_0 = 900 							=> DATASET([{'  ', NULL}], ds_layout),
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
				self.iv_vp002_phn_disconnected        := iv_vp002_phn_disconnected;
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
				self.iv_pv001_bst_avm_autoval         := iv_pv001_bst_avm_autoval;
				self.prop_adl_p_fseen_pos             := prop_adl_p_fseen_pos;
				self.prop_adl_fseen_p                 := prop_adl_fseen_p;
				self._prop_adl_fseen_p                := _prop_adl_fseen_p;
				self._src_prop_adl_fseen              := _src_prop_adl_fseen;
				self.iv_pl001_m_snc_prop_adl_fs       := iv_pl001_m_snc_prop_adl_fs;
				self.iv_in001_estimated_income        := iv_in001_estimated_income;
				self.emerge_adl_em_count_pos          := emerge_adl_em_count_pos;
				self.emerge_adl_count_em              := emerge_adl_count_em;
				self.emerge_adl_e1_count_pos          := emerge_adl_e1_count_pos;
				self.emerge_adl_count_e1              := emerge_adl_count_e1;
				self.emerge_adl_e2_count_pos          := emerge_adl_e2_count_pos;
				self.emerge_adl_count_e2              := emerge_adl_count_e2;
				self.emerge_adl_e3_count_pos          := emerge_adl_e3_count_pos;
				self.emerge_adl_count_e3              := emerge_adl_count_e3;
				self.emerge_adl_e4_count_pos          := emerge_adl_e4_count_pos;
				self.emerge_adl_count_e4              := emerge_adl_count_e4;
				self.iv_src_emerge_adl_count          := iv_src_emerge_adl_count;
				self.iv_prv_addr_avm_auto_val         := iv_prv_addr_avm_auto_val;
				self.iv_prop_owned_purchase_total     := iv_prop_owned_purchase_total;
				self.iv_prop_sold_purchase_total      := iv_prop_sold_purchase_total;
				self.iv_paw_source_count              := iv_paw_source_count;
				self.ver_phn_inf                      := ver_phn_inf;
				self.ver_phn_nap                      := ver_phn_nap;
				self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
				self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
				self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
				self.iv_email_count                   := iv_email_count;
				self.iv_rec_vehx_level                := iv_rec_vehx_level;
				self.iv_eviction_count                := iv_eviction_count;
				self.iv_filing_count                  := iv_filing_count;
				self._reported_dob                    := _reported_dob;
				self.reported_age                     := reported_age;
				self._combined_age                    := _combined_age;
				self.evidence_of_college              := evidence_of_college;
				self.iv_college_attendance_x_age      := iv_college_attendance_x_age;
				self.iv_prof_license_category         := iv_prof_license_category;
				self.sum_dols                         := sum_dols;
				self.pct_offline_dols                 := pct_offline_dols;
				self.pct_retail_dols                  := pct_retail_dols;
				self.pct_online_dols                  := pct_online_dols;
				self.iv_pb_profile                    := iv_pb_profile;
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
				self.cs_pct_addrs_le_12mo             := cs_pct_addrs_le_12mo;
				self.cs_outstanding_liens_ct          := cs_outstanding_liens_ct;
				self.vip_a_subscore0                  := vip_a_subscore0;
				self.vip_a_subscore1                  := vip_a_subscore1;
				self.vip_a_subscore2                  := vip_a_subscore2;
				self.vip_a_subscore3                  := vip_a_subscore3;
				self.vip_a_subscore4                  := vip_a_subscore4;
				self.vip_a_subscore5                  := vip_a_subscore5;
				self.vip_a_subscore6                  := vip_a_subscore6;
				self.vip_a_subscore7                  := vip_a_subscore7;
				self.vip_a_subscore8                  := vip_a_subscore8;
				self.vip_a_subscore9                  := vip_a_subscore9;
				self.vip_a_subscore10                 := vip_a_subscore10;
				self.vip_a_subscore11                 := vip_a_subscore11;
				self.vip_a_subscore12                 := vip_a_subscore12;
				self.vip_a_subscore13                 := vip_a_subscore13;
				self.vip_a_subscore14                 := vip_a_subscore14;
				self.vip_a_subscore15                 := vip_a_subscore15;
				self.vip_a_subscore16                 := vip_a_subscore16;
				self.vip_a_subscore17                 := vip_a_subscore17;
				self.vip_a_subscore18                 := vip_a_subscore18;
				self.vip_a_subscore19                 := vip_a_subscore19;
				self.vip_a_subscore20                 := vip_a_subscore20;
				self.vip_a_subscore21                 := vip_a_subscore21;
				self.vip_a_scaledscore                := vip_a_scaledscore;
				self.base                             := base;
				self.scale                            := scale;
				self._rvg1401_1_0                     := _rvg1401_1_0;
				self.bk_flag                          := bk_flag;
				self.lien_rec_unrel_flag              := lien_rec_unrel_flag;
				self.lien_hist_unrel_flag             := lien_hist_unrel_flag;
				self.lien_flag                        := lien_flag;
				self.ssn_deceased                     := ssn_deceased;
				self.scored_222s                      := scored_222s;
				self.rvg1401_1_0                      := rvg1401_1_0;
				self.glrc36                           := glrc36;
				self.glrc98                           := glrc98;
				self.glrc9c                           := glrc9c;
				self.glrc9d                           := glrc9d;
				self.glrc9e                           := glrc9e;
				self.glrc9i                           := glrc9i;
				self.glrc9r                           := glrc9r;
				self.glrc9t                           := glrc9t;
				self.glrc9w                           := glrc9w;
				// self.glrc9y                           := glrc9y;
				self.glrcev                           := glrcev;
				self.glrcms                           := glrcms;
				self.glrcpv                           := glrcpv;
				self.glrcbl                           := glrcbl;
				self.rcvaluepv_1                      := rcvaluepv_1;
				self.rcvaluepv_2                      := rcvaluepv_2;
				self.rcvaluepv_3                      := rcvaluepv_3;
				self.rcvaluepv                        := rcvaluepv;
				self.rcvalue9r_1                      := rcvalue9r_1;
				self.rcvalue9r_2                      := rcvalue9r_2;
				self.rcvalue9r_3                      := rcvalue9r_3;
				self.rcvalue9r                        := rcvalue9r;
				self.rcvalue9e_1                      := rcvalue9e_1;
				self.rcvalue9e_2                      := rcvalue9e_2;
				self.rcvalue9e_3                      := rcvalue9e_3;
				self.rcvalue9e_4                      := rcvalue9e_4;
				self.rcvalue9e                        := rcvalue9e;
				self.rcvaluebl_1                      := rcvaluebl_1;
				self.rcvaluebl_2                      := rcvaluebl_2;
				self.rcvaluebl_3                      := rcvaluebl_3;
				self.rcvaluebl                        := rcvaluebl;
				// self.rcvalue9y_1                      := rcvalue9y_1;
				// self.rcvalue9y                        := rcvalue9y;
				self.rcvaluems_1                      := rcvaluems_1;
				self.rcvaluems                        := rcvaluems;
				self.rcvalue9t_1                      := rcvalue9t_1;
				self.rcvalue9t                        := rcvalue9t;
				self.rcvalue36_1                      := rcvalue36_1;
				self.rcvalue36                        := rcvalue36;
				self.rcvalue9w_1                      := rcvalue9w_1;
				self.rcvalue9w                        := rcvalue9w;
				self.rcvalue9d_1                      := rcvalue9d_1;
				self.rcvalue9c_1                      := rcvalue9c_1;
				self.rcvalue9c                        := rcvalue9c;
				self.rcvalue9d                        := rcvalue9d;
				self.rcvalueev_1                      := rcvalueev_1;
				self.rcvalueev                        := rcvalueev;
				self.rcvalue9i_1                      := rcvalue9i_1;
				self.rcvalue9i                        := rcvalue9i;
				self.rcvalue98_1                      := rcvalue98_1;
				self.rcvalue98                        := rcvalue98;
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
											(string3)RVG1401_1_0
										);
END;

		model := project( clam, doModel(left) );

		return model;
END;

