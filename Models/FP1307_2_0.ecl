//project: 4287 - 4.1 Shell
import risk_indicators, riskwise, ut, easi;

bs_with_ip :=  record
	risk_indicators.Layout_Boca_Shell bs;
	riskwise.Layout_IP2O ip;
end;


export FP1307_2_0( dataset(bs_with_ip) clam_ip,  integer1 num_reasons, boolean criminal) := FUNCTION

	FP_DEBUG := FALSE;

	#if(FP_DEBUG)
	Layout_Debug := RECORD
		INTEGER sysdate;                                                      
		STRING iv_vp002_phn_disconnected;                                    
		STRING iv_va012_add_curbside_del;                                    
		INTEGER iv_po001_prop_own_tot;                                        
		INTEGER iv_in001_estimated_income;                                    
		INTEGER iv_max_lres;                                                  
		INTEGER iv_avg_num_sources_per_addr;                                  
		INTEGER iv_inq_collection_recency;                                    
		INTEGER iv_inq_communications_count12;                                
		INTEGER iv_inq_ssns_per_addr;                                         
		INTEGER iv_paw_active_phone_count;                                    
		INTEGER iv_liens_unrel_cj_ct;                                         
		STRING iv_ams_college_tier;                                          
		STRING nf_fp_sourcerisktype;                                         
		REAL s1_subscore0;                                                 
		REAL s1_subscore1;                                                 
		REAL s1_subscore2;                                                 
		REAL s1_subscore3;                                                 
		REAL s1_subscore4;                                                 
		REAL s1_subscore5;                                                 
		REAL s1_subscore6;                                                 
		REAL s1_subscore7;                                                 
		REAL s1_subscore8;                                                 
		REAL s1_subscore9;                                                 
		REAL s1_subscore10;                                                
		REAL s1_subscore11;                                                
		REAL s1_subscore12;                                                
		REAL s1_subscore13;                                                
		REAL s1_subscore14;                                                
		REAL s1_subscore15;                                                
		REAL s1_subscore16;                                                
		REAL s1_subscore17;                                                
		REAL s1_rawscore;                                                  
		REAL s1_lnoddsscore;                                               
		REAL s1_probscore;                                                 
		STRING iv_vp091_phnzip_mismatch;                                     
		INTEGER iv_va040_add_prison_hist;                                     
		INTEGER iv_ms001_ssns_per_adl;                                        
		INTEGER bureau_ssn_tn_fseen_pos;                                      
		STRING bureau_ssn_fseen_tn;                                          
		INTEGER _bureau_ssn_fseen_tn;                                         
		INTEGER bureau_ssn_ts_fseen_pos;                                      
		STRING bureau_ssn_fseen_ts;                                          
		INTEGER _bureau_ssn_fseen_ts;                                         
		INTEGER bureau_ssn_tu_fseen_pos;                                      
		STRING bureau_ssn_fseen_tu;                                          
		INTEGER _bureau_ssn_fseen_tu;                                         
		INTEGER bureau_ssn_en_fseen_pos;                                      
		STRING bureau_ssn_fseen_en;                                          
		INTEGER _bureau_ssn_fseen_en;                                         
		INTEGER bureau_ssn_eq_fseen_pos;                                      
		STRING bureau_ssn_fseen_eq;                                          
		INTEGER _bureau_ssn_fseen_eq;                                         
		INTEGER _src_bureau_ssn_fseen;                                        
		INTEGER iv_mos_src_bureau_ssn_fseen;                                  
		INTEGER prop_adl_p_count_pos;                                         
		INTEGER prop_adl_count_p;                                             
		INTEGER _src_prop_adl_count;                                          
		INTEGER iv_src_property_adl_count;                                    
		INTEGER _gong_did_first_seen;                                         
		INTEGER iv_mos_since_gong_did_fst_seen;                               
		INTEGER iv_inq_recency;                                               
		INTEGER iv_inq_highriskcredit_recency;                                
		INTEGER iv_inq_per_addr;                                              
		BOOLEAN ver_phn_inf;                                                  
		BOOLEAN ver_phn_nap;                                                  
		INTEGER inf_phn_ver_lvl;                                              
		INTEGER nap_phn_ver_lvl;                                              
		STRING iv_nap_phn_ver_x_inf_phn_ver;                                 
		INTEGER iv_released_liens_ct;                                         
		INTEGER iv_criminal_count;                                            
		INTEGER nf_pct_rel_with_felony;                                       
		STRING iv_ams_college_code;                                          
		STRING nf_fp_varrisktype;                                            
		REAL s2_subscore0;                                                 
		REAL s2_subscore1;                                                 
		REAL s2_subscore2;                                                 
		REAL s2_subscore3;                                                 
		REAL s2_subscore4;                                                 
		REAL s2_subscore5;                                                 
		REAL s2_subscore6;                                                 
		REAL s2_subscore7;                                                 
		REAL s2_subscore8;                                                 
		REAL s2_subscore9;                                                 
		REAL s2_subscore10;                                                
		REAL s2_subscore11;                                                
		REAL s2_subscore12;                                                
		REAL s2_subscore13;                                                
		REAL s2_subscore14;                                                
		REAL s2_subscore15;                                                
		REAL s2_subscore16;                                                
		REAL s2_rawscore;                                                  
		REAL s2_lnoddsscore;                                               
		REAL s2_probscore;                                                 
		INTEGER ver_src_cnt;                                                  
		INTEGER ver_src_tn_pos;                                               
		BOOLEAN ver_src_tn;                                                   
		INTEGER ver_src_ds_pos;                                               
		BOOLEAN ver_src_ds;                                                   
		INTEGER ver_src_en_pos;                                               
		BOOLEAN ver_src_en;                                                   
		INTEGER ver_src_eq_pos;                                               
		BOOLEAN ver_src_eq;                                                   
		INTEGER ver_src_tu_pos;                                               
		BOOLEAN ver_src_tu;                                                   
		BOOLEAN ssnpop;                                                       
		BOOLEAN _derog;                                                       
		INTEGER credit_source_cnt;                                            
		BOOLEAN bureauonly2;                                                  
		STRING uv_segment3;                                                  
		INTEGER _segment;                                                     
		REAL probscore;                                                    
		INTEGER base;                                                         
		REAL odds;                                                         
		INTEGER point;                                                        
		BOOLEAN or_decsssn;                                                   
		BOOLEAN or_ssnpriordob;                                               
		BOOLEAN or_prisonaddr;                                                
		BOOLEAN or_prisonphone;                                               
		BOOLEAN or_hraddr;                                                    
		BOOLEAN or_hrphone;                                                   
		BOOLEAN or_invalidssn;                                                
		BOOLEAN or_invalidaddr;                                               
		BOOLEAN or_invalidphone;                                              
		INTEGER fp1307_2;                                                     
		BOOLEAN stolenid;                                                     
		INTEGER stolidindex;                                                  
		BOOLEAN syntheticid;                                                  
		INTEGER synthidindex;                                                 
		BOOLEAN inq_notver;                                                   
		BOOLEAN other_notver;                                                 
		BOOLEAN ssn_adl_prob;                                                 
		BOOLEAN adl_ssn_prob;                                                 
		BOOLEAN veloprob;                                                     
		BOOLEAN manipid;                                                      
		INTEGER manipidindex;                                                 
		BOOLEAN suspactivity;                                                 
		INTEGER suspactindex;                                                 
		BOOLEAN vulnvictim;                                                   
		INTEGER vulnvicindex;                                                 
		BOOLEAN friendly;                                                     
		INTEGER friendfrdindex;                                                                                           
		//models.layout_modelout;
		risk_indicators.Layout_Boca_Shell clam;
		models.layouts.layout_fp1109;
	END;
		layout_debug doModel( clam_ip le, easi.Key_Easi_Census ri ) :=  TRANSFORM
	#else
		models.layouts.layout_fp1109 doModel( clam_ip le, easi.Key_Easi_Census ri  ) := TRANSFORM
	#end
	truedid                          := le.bs.truedid;
	out_z5                           := le.bs.shell_input.z5;
	nas_summary                      := le.bs.iid.nas_summary;
	nap_summary                      := le.bs.iid.nap_summary;
	nap_type                         := le.bs.iid.nap_type;
	nap_status                       := le.bs.iid.nap_status;
	rc_hriskphoneflag                := le.bs.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.bs.iid.hphonetypeflag;
	rc_phonevalflag                  := le.bs.iid.phonevalflag;
	rc_hphonevalflag                 := le.bs.iid.hphonevalflag;
	rc_phonezipflag                  := le.bs.iid.phonezipflag;
	rc_pwphonezipflag                := le.bs.iid.pwphonezipflag;
	rc_hriskaddrflag                 := le.bs.iid.hriskaddrflag;
	rc_decsflag                      := le.bs.iid.decsflag;
	rc_ssndobflag                    := le.bs.iid.socsdobflag;
	rc_pwssndobflag                  := le.bs.iid.pwsocsdobflag;
	rc_ssnvalflag                    := le.bs.iid.socsvalflag;
	rc_pwssnvalflag                  := le.bs.iid.pwsocsvalflag;
	rc_addrvalflag                   := le.bs.iid.addrvalflag;
	rc_addrcommflag                  := le.bs.iid.addrcommflag;
	rc_hrisksic                      := le.bs.iid.hrisksic;
	rc_hrisksicphone                 := le.bs.iid.hrisksicphone;
	ver_sources                      := le.bs.header_summary.ver_sources;
	ver_sources_count                := le.bs.header_summary.ver_sources_recordcount;
	ver_ssn_sources                  := le.bs.header_summary.ver_ssn_sources;
	ver_ssn_sources_first_seen       := le.bs.header_summary.ver_ssn_sources_first_seen_date;
	addrpop                          := le.bs.input_validation.address;
	ssnlength                        := le.bs.input_validation.ssn_length;
	dobpop                           := le.bs.input_validation.dateofbirth;
	hphnpop                          := le.bs.input_validation.homephone;
	add1_advo_mixed_address_usage    := le.bs.advo_input_addr.mixed_address_usage;
	add1_pop                         := le.bs.addrpop;
	property_owned_total             := le.bs.address_verification.owned.property_total;
	max_lres                         := le.bs.other_address_info.max_lres;
	addrs_prison_history             := le.bs.other_address_info.isprison;
	unique_addr_count                := le.bs.address_history_summary.unique_addr_cnt;
	addr_count2                      := le.bs.address_history_summary.addr_count2;
	addr_count_ge3                   := le.bs.address_history_summary.addr_count3;
	addr_count_ge6                   := le.bs.address_history_summary.addr_count6;
	addr_count_ge10                  := le.bs.address_history_summary.addr_count10;
	gong_did_first_seen              := le.bs.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	ssns_per_adl                     := le.bs.velocity_counters.ssns_per_adl;
	adlperssn_count                  := le.bs.ssn_verification.adlperssn_count;
	ssns_per_adl_c6                  := le.bs.velocity_counters.ssns_per_adl_created_6months;
	adls_per_ssn_c6                  := le.bs.velocity_counters.adls_per_ssn_created_6months;
	inq_addr_ver_count               := le.bs.acc_logs.inquiry_addr_ver_ct;
	inq_fname_ver_count              := le.bs.acc_logs.inquiry_fname_ver_ct;
	inq_lname_ver_count              := le.bs.acc_logs.inquiry_lname_ver_ct;
	inq_ssn_ver_count                := le.bs.acc_logs.inquiry_ssn_ver_ct;
	inq_dob_ver_count                := le.bs.acc_logs.inquiry_dob_ver_ct;
	inq_phone_ver_count              := le.bs.acc_logs.inquiry_phone_ver_ct;
	inq_count                        := le.bs.acc_logs.inquiries.counttotal;
	inq_count01                      := le.bs.acc_logs.inquiries.count01;
	inq_count03                      := le.bs.acc_logs.inquiries.count03;
	inq_count06                      := le.bs.acc_logs.inquiries.count06;
	inq_count12                      := le.bs.acc_logs.inquiries.count12;
	inq_count24                      := le.bs.acc_logs.inquiries.count24;
	inq_collection_count             := le.bs.acc_logs.collection.counttotal;
	inq_collection_count01           := le.bs.acc_logs.collection.count01;
	inq_collection_count03           := le.bs.acc_logs.collection.count03;
	inq_collection_count06           := le.bs.acc_logs.collection.count06;
	inq_collection_count12           := le.bs.acc_logs.collection.count12;
	inq_collection_count24           := le.bs.acc_logs.collection.count24;
	inq_highriskcredit_count         := le.bs.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.bs.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.bs.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.bs.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.bs.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.bs.acc_logs.highriskcredit.count24;
	inq_communications_count12       := le.bs.acc_logs.communications.count12;
	inq_peraddr                      := le.bs.acc_logs.inquiryperaddr;
	inq_ssnsperaddr                  := le.bs.acc_logs.inquiryssnsperaddr;
	paw_active_phone_count           := le.bs.employment.business_active_phone_ct;
	infutor_nap                      := le.bs.infutor_phone.infutor_nap;
	impulse_count                    := le.bs.impulse.count;
	attr_num_unrel_liens60           := le.bs.bjl.liens_unreleased_count60;
	attr_eviction_count              := le.bs.bjl.eviction_count;
	fp_sourcerisktype                := le.bs.fdattributesv2.sourcerisklevel;
	fp_varrisktype                   := le.bs.fdattributesv2.variationrisklevel;
	liens_recent_released_count      := le.bs.bjl.liens_recent_released_count;
	liens_historical_released_count  := le.bs.bjl.liens_historical_released_count;
	liens_unrel_cj_ct                := le.bs.liens.liens_unreleased_civil_judgment.count;
	criminal_count                   := le.bs.bjl.criminal_count;
	felony_count                     := le.bs.bjl.felony_count;
	rel_count                        := le.bs.relatives.relative_count;
	rel_felony_count                 := le.bs.relatives.relative_felony_count;
	rel_count_addr                   := le.bs.relatives.relatives_at_input_address;
	ams_college_code                 := le.bs.student.college_code;
	ams_college_tier                 := le.bs.student.college_tier;
	inferred_age                     := le.bs.inferred_age;
	estimated_income                 := le.bs.estimated_income;
	c_fammar_p                       := ri.fammar_p;
	c_unemp                          := ri.unemp;

	NULL := __common__( -999999999);

	sysdate := __common__( common.sas_date(if(le.bs.historydate=999999, (string)ut.getdate, (string6)le.bs.historydate+'01')));

	iv_vp002_phn_disconnected := __common__( map(
			not(hphnpop)                                                             => ' ',
			rc_hriskphoneflag ='5' or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D' => '1',
																																									'0'));

	iv_va012_add_curbside_del := __common__( map(
			not(add1_pop)                                => '                   ',
			(add1_advo_mixed_address_usage in ['A', '']) => '0 Curbside Delivery',
																											'1 Not Curb Delivery'));

	iv_po001_prop_own_tot := __common__( if(not(truedid or add1_pop), NULL, property_owned_total));

	iv_in001_estimated_income := __common__( if(not(truedid), NULL, estimated_income));

	iv_max_lres := __common__( if(not(truedid), NULL, max_lres));

	iv_avg_num_sources_per_addr := __common__( map(
			not(truedid)          => NULL,
			unique_addr_count = 0 => -1,
				(integer) (sum(
				(unique_addr_count - sum(addr_count2,addr_count_ge3)),
				(addr_count2     *  2), 
				(addr_count_ge3  *  3),
				(addr_count_ge6  *  6),
				(addr_count_ge10 * 10)
				) /
				sum(
				(unique_addr_count - sum(addr_count2,addr_count_ge3)),
				addr_count2      ,
				addr_count_ge3   ,
				addr_count_ge6   ,
				addr_count_ge10
				))));

	iv_inq_recency_1 := __common__( map(
			not(truedid) => NULL,
			inq_count01 >0  => 1,
			inq_count03 >0 => 3,
			inq_count06 >0 => 6,
			inq_count12 >0 => 12,
			inq_count24 >0 => 24,
			inq_count   >0 => 99,
											0));

	iv_inq_collection_recency := __common__( map(
			not(truedid)           => NULL,
			inq_collection_count01 >0 => 1,
			inq_collection_count03 >0  => 3,
			inq_collection_count06 >0  => 6,
			inq_collection_count12 >0  => 12,
			inq_collection_count24 >0  => 24,
			inq_collection_count   >0  => 99,
																0));

	iv_inq_highriskcredit_recency_1 := __common__( map(
			not(truedid)               => NULL,
			inq_highRiskCredit_count01  >0 => 1,
			inq_highRiskCredit_count03  >0 => 3,
			inq_highRiskCredit_count06  >0 => 6,
			inq_highRiskCredit_count12  >0 => 12,
			inq_highRiskCredit_count24  >0 => 24,
			inq_highRiskCredit_count    >0 => 99,
																		0));

	iv_inq_communications_count12 := __common__( if(not(truedid), NULL, inq_communications_count12));

	iv_inq_ssns_per_addr := __common__( if(not(add1_pop), NULL, inq_ssnsperaddr));

	iv_paw_active_phone_count := __common__( if(not(truedid), NULL, paw_active_phone_count));

	ver_phn_inf := __common__( (infutor_nap in [4, 6, 7, 9, 10, 11, 12]));

	ver_phn_nap := __common__( (nap_summary in [4, 6, 7, 9, 10, 11, 12]));

	inf_phn_ver_lvl_1 := __common__( map(
			ver_phn_inf     => 3,
			infutor_nap = 1=> 1,
			infutor_nap = 0 => 0,
												 2));

	nap_phn_ver_lvl_1 := __common__( map(
			ver_phn_nap     => 3,
			nap_summary = 1 => 1,
			nap_summary = 0 => 0,
												 2));

	iv_nap_phn_ver_x_inf_phn_ver_1 := __common__( map(
			not(addrpop or hphnpop) => '   ',
			not(hphnpop)            => ' -1',
																 trim((string) nap_phn_ver_lvl_1, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string) inf_phn_ver_lvl_1, LEFT, RIGHT)));

	iv_liens_unrel_cj_ct := __common__( if(not(truedid), NULL, liens_unrel_CJ_ct));

	iv_criminal_count_1 := __common__( if(not(truedid), NULL, criminal_count));

	nf_pct_rel_with_felony_1 := __common__( map(
			not(truedid)  => NULL,
			rel_count > 0 => truncate(rel_felony_count / rel_count * 10) * 10,
											 -1));

	iv_ams_college_tier := __common__( map(
			not(truedid)            => '  ',
			ams_college_tier = '' => '-1',
																 ams_college_tier));

	nf_fp_sourcerisktype := __common__( if(not(truedid) or fp_sourcerisktype = '', '', fp_sourcerisktype));

	s1_subscore0 := __common__( map(
			NULL < iv_criminal_count_1 AND iv_criminal_count_1 < 1 => 0.219545,
			1 <= iv_criminal_count_1 AND iv_criminal_count_1 < 3   => -0.329808,
			3 <= iv_criminal_count_1                               => -1.073777,
																																0.000000));

	s1_subscore1 := __common__( map(
			(iv_inq_highriskcredit_recency_1 in [1, 3, 6, 12, 24, 99]) => -0.655144,
			(iv_inq_highriskcredit_recency_1 in [0])                   => 0.173510,
																																		0.000000));

	s1_subscore2 := __common__( map(
			NULL < iv_max_lres AND iv_max_lres < 1   => -0.000000,
			1 <= iv_max_lres AND iv_max_lres < 21    => -0.427959,
			21 <= iv_max_lres AND iv_max_lres < 63   => -0.361511,
			63 <= iv_max_lres AND iv_max_lres < 174  => 0.081116,
			174 <= iv_max_lres AND iv_max_lres < 270 => 0.161195,
			270 <= iv_max_lres                       => 0.525087,
																									-0.000000));

	s1_subscore3 := __common__( map(
			0 < iv_in001_estimated_income AND iv_in001_estimated_income < 29000      => -0.491593,
			29000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 31000 => -0.202510,
			31000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 36000 => -0.196052,
			36000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 58000 => -0.013819,
			58000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 79000 => 0.164747,
			79000 <= iv_in001_estimated_income                                       => 0.315339,
																																									0.000000));

	s1_subscore4 := __common__( map(
			(iv_inq_collection_recency in [1, 3, 6, 12]) => -0.478399,
			(iv_inq_collection_recency in [24])          => -0.325297,
			(iv_inq_collection_recency in [99])          => -0.009248,
			(iv_inq_collection_recency in [0])           => 0.218227,
																											0.000000));

	s1_subscore5 := __common__( map(
			(nf_fp_sourcerisktype in ['Other'])  => 0.000000,
			(nf_fp_sourcerisktype in ['1'])      => 1.213974,
			(nf_fp_sourcerisktype in ['2'])      => 0.639329,
			(nf_fp_sourcerisktype in ['3', '4']) => 0.116877,
			(nf_fp_sourcerisktype in ['5', '6']) => -0.064251,
			(nf_fp_sourcerisktype in ['7'])      => -0.180246,
			(nf_fp_sourcerisktype in ['8', '9']) => -0.912983,
																							0.000000));

	s1_subscore6 := __common__( map(
			NULL < iv_inq_ssns_per_addr AND iv_inq_ssns_per_addr < 1 => 0.164709,
			1 <= iv_inq_ssns_per_addr AND iv_inq_ssns_per_addr < 2   => -0.038015,
			2 <= iv_inq_ssns_per_addr AND iv_inq_ssns_per_addr < 3   => -0.116685,
			3 <= iv_inq_ssns_per_addr                                => -0.746799,
																																	0.000000));

	s1_subscore7 := __common__( map(
			(iv_inq_recency_1 in [1])                   => -0.666135,
			(iv_inq_recency_1 in [0, 3, 6, 12, 24, 99]) => 0.086363,
																										 0.000000));

	s1_subscore8 := __common__( map(
			NULL < iv_inq_communications_count12 AND iv_inq_communications_count12 < 1 => 0.078823,
			1 <= iv_inq_communications_count12                                         => -0.576908,
																																										-0.000000));

	s1_subscore9 := __common__( map(
			(iv_nap_phn_ver_x_inf_phn_ver_1 in ['-1'])                                     => 0.000000,
			(iv_nap_phn_ver_x_inf_phn_ver_1 in ['0-0', '0-1', '1-0', '1-1', '2-0', '2-1']) => -0.144430,
			(iv_nap_phn_ver_x_inf_phn_ver_1 in ['1-3', '2-3', '3-1'])                      => 0.007738,
			(iv_nap_phn_ver_x_inf_phn_ver_1 in ['3-3'])                                    => 0.101059,
			(iv_nap_phn_ver_x_inf_phn_ver_1 in ['0-3', '3-0'])                             => 0.356498,
																																												0.000000));

	s1_subscore10 := __common__( map(
			(iv_va012_add_curbside_del in ['0 Curbside Delivery']) => 0.215908,
			(iv_va012_add_curbside_del in ['1 Not Curb Delivery']) => -0.162050,
																																0.000000));

	s1_subscore11 := __common__( map(
			NULL < iv_po001_prop_own_tot AND iv_po001_prop_own_tot < 1 => -0.118195,
			1 <= iv_po001_prop_own_tot                                 => 0.254134,
																																		0.000000));

	s1_subscore12 := __common__( map(
			NULL < iv_paw_active_phone_count AND iv_paw_active_phone_count < 1 => -0.060821,
			1 <= iv_paw_active_phone_count                                     => 0.745621,
																																						-0.000000));

	s1_subscore13 := __common__( map(
			NULL < iv_avg_num_sources_per_addr AND iv_avg_num_sources_per_addr < 3 => -0.222931,
			3 <= iv_avg_num_sources_per_addr AND iv_avg_num_sources_per_addr < 4   => 0.034287,
			4 <= iv_avg_num_sources_per_addr AND iv_avg_num_sources_per_addr < 5   => 0.090492,
			5 <= iv_avg_num_sources_per_addr                                       => 0.201654,
																																								0.000000));

	s1_subscore14 := __common__( map(
			(iv_vp002_phn_disconnected in ['Other']) => 0.000000,
			(iv_vp002_phn_disconnected in ['0'])     => 0.032027,
			(iv_vp002_phn_disconnected in ['1'])     => -1.186763,
																									0.000000));

	s1_subscore15 := __common__( map(
			NULL < iv_liens_unrel_cj_ct AND iv_liens_unrel_cj_ct < 1 => 0.045644,
			1 <= iv_liens_unrel_cj_ct                                => -0.776157,
																																	0.000000));

	s1_subscore16 := __common__( map(
			(iv_ams_college_tier in ['Other'])                  => 0.000000,
			(iv_ams_college_tier in ['-1', '0', '4', '5', '6']) => -0.034119,
			(iv_ams_college_tier in ['1', '2', '3'])            => 0.919702,
																														 0.000000));

	s1_subscore17 := __common__( map(
			NULL < nf_pct_rel_with_felony_1 AND nf_pct_rel_with_felony_1 < 0 => 0.000000,
			0 <= nf_pct_rel_with_felony_1 AND nf_pct_rel_with_felony_1 < 10  => 0.039861,
			10 <= nf_pct_rel_with_felony_1                                   => -0.313496,
																																					0.000000));

	s1_rawscore := __common__( s1_subscore0 +
			s1_subscore1 +
			s1_subscore2 +
			s1_subscore3 +
			s1_subscore4 +
			s1_subscore5 +
			s1_subscore6 +
			s1_subscore7 +
			s1_subscore8 +
			s1_subscore9 +
			s1_subscore10 +
			s1_subscore11 +
			s1_subscore12 +
			s1_subscore13 +
			s1_subscore14 +
			s1_subscore15 +
			s1_subscore16 +
			s1_subscore17);

	s1_lnoddsscore := __common__( s1_rawscore + 5.091689);

	s1_probscore := __common__( exp(s1_lnoddsscore) / (1 + exp(s1_lnoddsscore)));

	iv_vp091_phnzip_mismatch := __common__( map(
			not(hphnpop and not(out_z5 = ''))          => ' ',
			rc_phonezipflag = '1' or rc_pwphonezipflag = '1' => '1',
			rc_phonezipflag = '0' or rc_pwphonezipflag = '0' => '0',
																											' '));

	iv_va040_add_prison_hist := __common__( if(not(truedid), NULL, (INTEGER) addrs_prison_history));

	iv_ms001_ssns_per_adl := __common__( map(
			not(truedid)     => NULL,
			ssns_per_adl = 0 => 1,
													ssns_per_adl));

	bureau_ssn_tn_fseen_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'TN' , ', ', 'E'));

	bureau_ssn_fseen_tn := __common__( if(bureau_ssn_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_tn_fseen_pos, ',')));

	_bureau_ssn_fseen_tn := __common__( common.sas_date((string)(bureau_ssn_fseen_tn)));

	bureau_ssn_ts_fseen_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'TS' , ', ', 'E'));

	bureau_ssn_fseen_ts := __common__( if(bureau_ssn_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_ts_fseen_pos, ',')));

	_bureau_ssn_fseen_ts := __common__( common.sas_date((string)(bureau_ssn_fseen_ts)));

	bureau_ssn_tu_fseen_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'TU' , ', ', 'E'));

	bureau_ssn_fseen_tu := __common__( if(bureau_ssn_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_tu_fseen_pos, ',')));

	_bureau_ssn_fseen_tu := __common__( common.sas_date((string)(bureau_ssn_fseen_tu)));

	bureau_ssn_en_fseen_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'EN' , ', ', 'E'));

	bureau_ssn_fseen_en := __common__( if(bureau_ssn_en_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_en_fseen_pos, ',')));

	_bureau_ssn_fseen_en := __common__( common.sas_date((string)(bureau_ssn_fseen_en)));

	bureau_ssn_eq_fseen_pos := __common__( Models.Common.findw_cpp(ver_ssn_sources, 'EQ' , ', ', 'E'));

	bureau_ssn_fseen_eq := __common__( if(bureau_ssn_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_eq_fseen_pos, ',')));

	_bureau_ssn_fseen_eq := __common__( common.sas_date((string)(bureau_ssn_fseen_eq)));

	_src_bureau_ssn_fseen := __common__( if(max(_bureau_ssn_fseen_tn, _bureau_ssn_fseen_ts, _bureau_ssn_fseen_tu, _bureau_ssn_fseen_en, _bureau_ssn_fseen_eq) = NULL, NULL, min(if(_bureau_ssn_fseen_tn = NULL, -NULL, _bureau_ssn_fseen_tn), if(_bureau_ssn_fseen_ts = NULL, -NULL, _bureau_ssn_fseen_ts), if(_bureau_ssn_fseen_tu = NULL, -NULL, _bureau_ssn_fseen_tu), if(_bureau_ssn_fseen_en = NULL, -NULL, _bureau_ssn_fseen_en), if(_bureau_ssn_fseen_eq = NULL, -NULL, _bureau_ssn_fseen_eq))));

	iv_mos_src_bureau_ssn_fseen := __common__( map(
			not(truedid)                 => NULL,
			_src_bureau_ssn_fseen = NULL => -1,
																			if ((sysdate - _src_bureau_ssn_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_ssn_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_ssn_fseen) / (365.25 / 12)))));

	prop_adl_p_count_pos := __common__( Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E'));

	prop_adl_count_p := __common__( if(prop_adl_p_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, prop_adl_p_count_pos, ',')));

	_src_prop_adl_count := __common__( max(prop_adl_count_p, (real)0));

	iv_src_property_adl_count := __common__( map(
			not(truedid)               => NULL,
			_src_prop_adl_count = NULL => -1,
																		_src_prop_adl_count));

	_gong_did_first_seen := __common__( common.sas_date((string)(gong_did_first_seen)));

	iv_mos_since_gong_did_fst_seen := __common__( map(
			not(truedid)                     => NULL,
			not(_gong_did_first_seen = NULL) => if ((sysdate - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_first_seen) / (365.25 / 12))),
																					-1));

	iv_inq_recency := __common__( map(
			not(truedid) => NULL,
			inq_count01 > 0 => 1,
			inq_count03 > 0 => 3,
			inq_count06 > 0 => 6,
			inq_count12 > 0 => 12,
			inq_count24 > 0 => 24,
			inq_count   > 0 => 99,
											0));

	iv_inq_highriskcredit_recency := __common__( map(
			not(truedid)               => NULL,
			inq_highRiskCredit_count01  > 0 => 1,
			inq_highRiskCredit_count03  > 0 => 3,
			inq_highRiskCredit_count06  > 0 => 6,
			inq_highRiskCredit_count12  > 0 => 12,
			inq_highRiskCredit_count24  > 0 => 24,
			inq_highRiskCredit_count    > 0  => 99,
																		0));

	iv_inq_per_addr := __common__( if(not(add1_pop), NULL, inq_peraddr));

	inf_phn_ver_lvl := __common__( map(
			ver_phn_inf     => 3,
			infutor_nap = 1 => 1,
			infutor_nap = 0 => 0,
												 2));

	nap_phn_ver_lvl := __common__( map(
			ver_phn_nap     => 3,
			nap_summary = 1 => 1,
			nap_summary = 0 => 0,
												 2));

	iv_nap_phn_ver_x_inf_phn_ver := __common__( map(
			not(addrpop or hphnpop) => '   ',
			not(hphnpop)            => ' -1',
																 trim((STRING) nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((STRING) inf_phn_ver_lvl, LEFT, RIGHT)));

	iv_released_liens_ct := __common__( if(not(truedid), NULL, liens_recent_released_count + liens_historical_released_count));

	iv_criminal_count := __common__( if(not(truedid), NULL, criminal_count));

	nf_pct_rel_with_felony := __common__( map(
			not(truedid)  => NULL,
			rel_count > 0 => truncate(rel_felony_count / rel_count * 10) * 10,
											 -1));

	iv_ams_college_code := __common__( map(
			not(truedid)            => '  ',
			ams_college_code = '' => '-1',
																 ams_college_code));

	nf_fp_varrisktype := __common__( if(not(truedid) or (INTEGER) fp_varrisktype = NULL, '', (STRING) fp_varrisktype));

	s2_subscore0 := __common__( map(
			NULL < iv_criminal_count AND iv_criminal_count < 1 => 0.248124,
			1 <= iv_criminal_count AND iv_criminal_count < 2   => -0.102336,
			2 <= iv_criminal_count AND iv_criminal_count < 3   => -0.138759,
			3 <= iv_criminal_count AND iv_criminal_count < 7   => -0.432933,
			7 <= iv_criminal_count                             => -0.817726,
																														0.000000));

	s2_subscore1 := __common__( map(
			(iv_inq_highriskcredit_recency in [1, 3, 6, 12, 24]) => -0.402203,
			(iv_inq_highriskcredit_recency in [99])              => -0.070645,
			(iv_inq_highriskcredit_recency in [0])               => 0.250423,
																															-0.000000));

	s2_subscore2 := __common__( map(
			(iv_inq_recency in [1])         => -0.521973,
			(iv_inq_recency in [3])         => -0.183968,
			(iv_inq_recency in [6, 12, 24]) => 0.179773,
			(iv_inq_recency in [0, 99])     => 0.254414,
																				 -0.000000));

	s2_subscore3 := __common__( map(
			(string) c_fammar_p = '' => 0.000000,
			NULL < (REAL) c_fammar_p AND (real) c_fammar_p < 0     => 0.000000,
			0 <= (REAL) c_fammar_p AND (REAL) c_fammar_p < 31.9    => -0.441864,
			31.9 <= (REAL) c_fammar_p AND (REAL) c_fammar_p < 48   => -0.438092,
			48 <= (REAL) c_fammar_p AND (REAL) c_fammar_p < 56.9   => 0.002688,
			56.9 <= (REAL) c_fammar_p AND (REAL) c_fammar_p < 76.2 => 0.079926,
			76.2 <= (REAL) c_fammar_p AND (REAL) c_fammar_p < 90.7 => 0.172969,
			90.7 <= (REAL) c_fammar_p                       => 0.476362,
																									0.000000));

	s2_subscore4 := __common__( map(
			(nf_fp_varrisktype in ['Other'])       => -0.000000,
			(nf_fp_varrisktype in ['-1'])          => -0.000000,
			(nf_fp_varrisktype in ['1'])           => 0.235295,
			(nf_fp_varrisktype in ['2'])           => -0.119558,
			(nf_fp_varrisktype in ['3', '4'])      => -0.179772,
			(nf_fp_varrisktype in ['5', '6'])      => -0.380441,
			(nf_fp_varrisktype in ['7', '8', '9']) => -0.741899,
																								-0.000000));

	s2_subscore5 := __common__( map(
			NULL < iv_inq_per_addr AND iv_inq_per_addr < 3 => 0.121492,
			3 <= iv_inq_per_addr AND iv_inq_per_addr < 4   => 0.015571,
			4 <= iv_inq_per_addr AND iv_inq_per_addr < 6   => -0.003474,
			6 <= iv_inq_per_addr AND iv_inq_per_addr < 14  => -0.406898,
			14 <= iv_inq_per_addr                          => -0.638338,
																												-0.000000));

	s2_subscore6 := __common__( map(
			NULL < iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 0   => -1.185243,
			0 <= iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 16    => -0.426202,
			16 <= iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 37   => -0.306094,
			37 <= iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 208  => -0.045462,
			208 <= iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen < 323 => 0.212364,
			323 <= iv_mos_src_bureau_ssn_fseen                                       => 0.268619,
																																									0.000000));

	s2_subscore7 := __common__( map(
			(string) c_unemp = '' => 0.000000,
			NULL < (REAL) c_unemp AND (REAL) c_unemp < 0    => -0.000000,
			0 <= (REAL) c_unemp AND (REAL) c_unemp < 3.5    => 0.228484,
			3.5 <= (REAL) c_unemp AND (REAL) c_unemp < 8.5  => 0.033991,
			8.5 <= (REAL) c_unemp AND (REAL) c_unemp < 11.8 => -0.332615,
			11.8 <= (REAL) c_unemp                   => -0.445299,
																					 -0.000000));

	s2_subscore8 := __common__( map(
			(iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                       => 0.000000,
			(iv_nap_phn_ver_x_inf_phn_ver in ['1-0', '1-1'])               => -1.311961,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-3'])        => -0.145478,
			(iv_nap_phn_ver_x_inf_phn_ver in ['2-0', '2-1'])               => 0.033956,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3', '3-1', '3-3']) => 0.135086,
			(iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                      => 0.343495,
																																				0.000000));

	s2_subscore9 := __common__( map(
			NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3 => 0.057952,
			3 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 4   => -0.120518,
			4 <= iv_ms001_ssns_per_adl                                 => -0.911638,
																																		0.000000));

	s2_subscore10 := __common__( map(
			NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 0   => 0.011270,
			0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 61    => -0.246837,
			61 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 102  => -0.020397,
			102 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 124 => 0.125194,
			124 <= iv_mos_since_gong_did_fst_seen                                          => 0.336382,
																																												0.000000));

	s2_subscore11 := __common__( map(
			NULL < nf_pct_rel_with_felony AND nf_pct_rel_with_felony < 0 => 0.000000,
			0 <= nf_pct_rel_with_felony AND nf_pct_rel_with_felony < 10  => 0.065661,
			10 <= nf_pct_rel_with_felony                                 => -0.299758,
																																			0.000000));

	s2_subscore12 := __common__( map(
			(iv_vp091_phnzip_mismatch in ['Other']) => -0.000000,
			(iv_vp091_phnzip_mismatch in ['0'])     => 0.032554,
			(iv_vp091_phnzip_mismatch in ['1'])     => -0.712972,
																								 -0.000000));

	s2_subscore13 := __common__( map(
			NULL < iv_src_property_adl_count AND iv_src_property_adl_count < 1 => -0.077547,
			1 <= iv_src_property_adl_count                                     => 0.218702,
																																						0.000000));

	s2_subscore14 := __common__( map(
			NULL < iv_released_liens_ct AND iv_released_liens_ct < 1 => -0.074616,
			1 <= iv_released_liens_ct                                => 0.283419,
																																	0.000000));

	s2_subscore15 := __common__( map(
			NULL < iv_va040_add_prison_hist AND iv_va040_add_prison_hist < 1 => 0.021602,
			1 <= iv_va040_add_prison_hist                                    => -0.915520,
																																					0.000000));

	s2_subscore16 := __common__( map(
			(iv_ams_college_code in ['Other'])   => 0.000000,
			(iv_ams_college_code in ['-1', '2']) => -0.027758,
			(iv_ams_college_code in ['1', '4'])  => 0.458788,
																							0.000000));

	s2_rawscore := __common__( s2_subscore0 +
			s2_subscore1 +
			s2_subscore2 +
			s2_subscore3 +
			s2_subscore4 +
			s2_subscore5 +
			s2_subscore6 +
			s2_subscore7 +
			s2_subscore8 +
			s2_subscore9 +
			s2_subscore10 +
			s2_subscore11 +
			s2_subscore12 +
			s2_subscore13 +
			s2_subscore14 +
			s2_subscore15 +
			s2_subscore16);

	s2_lnoddsscore := __common__( s2_rawscore + 3.358790);

	s2_probscore := __common__( exp(s2_lnoddsscore) / (1 + exp(s2_lnoddsscore)));

	ver_src_cnt := __common__( Models.Common.countw((string)(ver_sources), ' !$%&()*+,-./);<^|'));

	ver_src_tn_pos := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , '  ,', 'ie'));

	ver_src_tn := __common__( ver_src_tn_pos > 0);

	ver_src_ds_pos := __common__( Models.Common.findw_cpp(ver_sources, 'DS' , '  ,', 'ie'));

	ver_src_ds := __common__( ver_src_ds_pos > 0);

	ver_src_en_pos := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , '  ,', 'ie'));

	ver_src_en := __common__( ver_src_en_pos > 0);

	ver_src_eq_pos := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , '  ,', 'ie'));

	ver_src_eq := __common__( ver_src_eq_pos > 0);

	ver_src_tu_pos := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , '  ,', 'ie'));

	ver_src_tu := __common__( ver_src_tu_pos > 0);

	ssnpop := __common__( (INTEGER) ssnlength > 0);

	_derog := __common__( felony_count > 0 or addrs_prison_history or attr_num_unrel_liens60 > 0 or attr_eviction_count > 0 or impulse_count > 0);

	credit_source_cnt := __common__( if(max((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn, (integer)ver_src_tu) = NULL, NULL, sum((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn, (integer)ver_src_tu)));

	bureauonly2 := __common__( credit_source_cnt > 0 AND credit_source_cnt = ver_src_cnt AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6])));

	uv_segment3 := __common__( map(
			NOT(ssnpop) 	                                                                => '0 noSSN',
			ver_src_ds or rc_decsflag = '1' or rc_ssndobflag = '1' or rc_pwssndobflag = '1' => '1 ssnprob',
			(nas_summary in [4, 7, 9])                                                    => '2 nas479',
			nap_summary <= 4 and nas_summary <= 4 or ver_src_cnt = 0                      => '3 newdid',
			bureauonly2                                                                   => '4 bureauonly',
			_derog                                                                        => '5 derog',
			Inq_count03 > 0                                                               => '6 recentActivity',
																																											 '7 other'));

	_segment := __common__( map(
			uv_segment3 = '0 noSSN'                               => 0,
			not((uv_segment3 in ['6 recentActivity', '7 other'])) => 2,
																															 1));

	probscore := __common__( if((_segment in [0, 2]), s2_probscore, s1_probscore));

	base := __common__( 650);

	odds := __common__( (1 - 0.016) / 0.016);

	point := __common__( 30);

	fp1307_2_9 := __common__( min(if(max(round(point * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 300) = NULL, -NULL, max(round(point * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 300)), 999));

	or_decsssn := __common__( (INTEGER) ssnlength > 0 and rc_decsflag = '1');

	or_ssnpriordob := __common__( (INTEGER) ssnlength > 0 and dobpop and rc_ssndobflag = '1');

	or_prisonaddr := __common__( rc_hrisksic = '2225');

	or_prisonphone := __common__( hphnpop and rc_hrisksicphone = '2225');

	or_hraddr := __common__( rc_hriskaddrflag = '4' or rc_addrcommflag = '2');

	or_hrphone := __common__( hphnpop and (rc_hriskphoneflag = '6' or rc_hphonetypeflag = '5' or rc_hphonevalflag = '3' or rc_addrcommflag = '1'));

	or_invalidssn := __common__( (INTEGER) ssnlength > 0 and (rc_ssnvalflag = '1' or (rc_pwssnvalflag in ['1', '2', '3'])));

	or_invalidaddr := __common__( rc_addrvalflag != 'V');

	or_invalidphone := __common__( hphnpop and (rc_phonevalflag = '0' or rc_hphonevalflag = '0'));

	fp1307_2_8 := __common__( if(or_decsssn, min(if(fp1307_2_9 = NULL, -NULL, fp1307_2_9), 575), fp1307_2_9));

	fp1307_2_7 := __common__( if(or_ssnpriordob, min(if(fp1307_2_8 = NULL, -NULL, fp1307_2_8), 575), fp1307_2_8));

	fp1307_2_6 := __common__( if(or_prisonaddr, min(if(fp1307_2_7 = NULL, -NULL, fp1307_2_7), 575), fp1307_2_7));

	fp1307_2_5 := __common__( if(or_prisonphone, min(if(fp1307_2_6 = NULL, -NULL, fp1307_2_6), 575), fp1307_2_6));

	fp1307_2_4 := __common__( if(or_hraddr, min(if(fp1307_2_5 = NULL, -NULL, fp1307_2_5), 620), fp1307_2_5));

	fp1307_2_3 := __common__( if(or_hrphone, min(if(fp1307_2_4 = NULL, -NULL, fp1307_2_4), 620), fp1307_2_4));

	fp1307_2_2 := __common__( if(or_invalidssn, min(if(fp1307_2_3 = NULL, -NULL, fp1307_2_3), 620), fp1307_2_3));

	fp1307_2_1 := __common__( if(or_invalidaddr, min(if(fp1307_2_2 = NULL, -NULL, fp1307_2_2), 620), fp1307_2_2));

	fp1307_2 := __common__( if(or_invalidphone, min(if(fp1307_2_1 = NULL, -NULL, fp1307_2_1), 620), fp1307_2_1));

	stolenid := __common__( (uv_segment3 in ['1 ssnprob', '2 nas479', '6 recentActivity']));

	stolidindex := __common__( map(
			NOT(stolenid)   => 1,
			fp1307_2 <= 530 => 9,
			fp1307_2 <= 560 => 8,
			fp1307_2 <= 580 => 7,
			fp1307_2 <= 620 => 6,
			fp1307_2 <= 650 => 5,
			fp1307_2 <= 680 => 4,
			fp1307_2 <= 710 => 3,
												 2));

	syntheticid := __common__( (uv_segment3 in ['1 ssnprob', '3 newdid', '4 bureauonly']));

	synthidindex := __common__( map(
			NOT(syntheticid) => 1,
			fp1307_2 <= 540  => 9,
			fp1307_2 <= 590  => 8,
			fp1307_2 <= 610  => 7,
			fp1307_2 <= 620  => 6,
			fp1307_2 <= 630  => 5,
			fp1307_2 <= 640  => 4,
			fp1307_2 <= 660  => 3,
													2));

	inq_notver := __common__( uv_segment3 = '6 recentActivity' AND (inq_addr_ver_count = 0 or inq_fname_ver_count = 0 or inq_lname_ver_count = 0 or inq_ssn_ver_count = 0 or inq_dob_ver_count = 0 or inq_phone_ver_count = 0));

	other_notver := __common__( uv_segment3 = '7 other' AND (nas_summary != 12 or nap_summary = 1));

	ssn_adl_prob := __common__( ssns_per_adl >= 3 or ssns_per_adl_c6 >= 2);

	adl_ssn_prob := __common__( adlperssn_count >= 2 or adls_per_ssn_c6 >= 2);

	veloprob := __common__( (uv_segment3 in ['6 recentActivity', '7 other']) AND not(inq_notver) AND not(other_notver) AND (ssn_adl_prob or adl_ssn_prob));

	manipid := __common__( inq_notver or other_notver or veloprob);

	manipidindex := __common__( map(
			NOT(manipid)    => 1,
			fp1307_2 <= 550 => 9,
			fp1307_2 <= 570 => 8,
			fp1307_2 <= 620 => 7,
			fp1307_2 <= 650 => 6,
			fp1307_2 <= 680 => 5,
			fp1307_2 <= 710 => 4,
			fp1307_2 <= 750 => 3,
												 2));

	suspactivity := __common__( uv_segment3 = '5 derog');

	suspactindex := __common__( map(
			NOT(suspactivity) => 1,
			fp1307_2 <= 510   => 9,
			fp1307_2 <= 540   => 8,
			fp1307_2 <= 600   => 7,
			fp1307_2 <= 630   => 6,
			fp1307_2 <= 660   => 5,
			fp1307_2 <= 680   => 4,
			fp1307_2 <= 720   => 3,
													 2));

	vulnvictim := __common__( inferred_age <= 17 or inferred_age >= 70);

	vulnvicindex := __common__( map(
			NOT(vulnvictim) => 1,
			fp1307_2 <= 590 => 9,
			fp1307_2 <= 620 => 8,
			fp1307_2 <= 630 => 7,
			fp1307_2 <= 650 => 6,
			fp1307_2 <= 690 => 5,
			fp1307_2 <= 720 => 4,
			fp1307_2 <= 750 => 3,
												 2));

	friendly := __common__( rel_felony_count > 0 or rel_count_addr > 1 or inferred_age >= 70);

	friendfrdindex := __common__( map(
			NOT(friendly)   => 1,
			fp1307_2 <= 510 => 9,
			fp1307_2 <= 540 => 8,
			fp1307_2 <= 560 => 7,
			fp1307_2 <= 580 => 6,
			fp1307_2 <= 620 => 5,
			fp1307_2 <= 640 => 4,
			fp1307_2 <= 680 => 3,
												 2));


	#if(FP_DEBUG)
		/* Model Input Variables */
			self.clam							  							:= le.bs;
			self.sysdate                          := sysdate;                                          
			self.iv_vp002_phn_disconnected        := iv_vp002_phn_disconnected;                        
			self.iv_va012_add_curbside_del        := iv_va012_add_curbside_del;                        
			self.iv_po001_prop_own_tot            := iv_po001_prop_own_tot;                            
			self.iv_in001_estimated_income        := iv_in001_estimated_income;                        
			self.iv_max_lres                      := iv_max_lres;                                      
			self.iv_avg_num_sources_per_addr      := iv_avg_num_sources_per_addr;                      
			self.iv_inq_collection_recency        := iv_inq_collection_recency;                        
			self.iv_inq_communications_count12    := iv_inq_communications_count12;                    
			self.iv_inq_ssns_per_addr             := iv_inq_ssns_per_addr;                             
			self.iv_paw_active_phone_count        := iv_paw_active_phone_count;                        
			self.iv_liens_unrel_cj_ct             := iv_liens_unrel_cj_ct;                             
			self.iv_ams_college_tier              := iv_ams_college_tier;                              
			self.nf_fp_sourcerisktype             := nf_fp_sourcerisktype;                             
			self.s1_subscore0                     := s1_subscore0;                                     
			self.s1_subscore1                     := s1_subscore1;                                     
			self.s1_subscore2                     := s1_subscore2;                                     
			self.s1_subscore3                     := s1_subscore3;                                     
			self.s1_subscore4                     := s1_subscore4;                                     
			self.s1_subscore5                     := s1_subscore5;                                     
			self.s1_subscore6                     := s1_subscore6;                                     
			self.s1_subscore7                     := s1_subscore7;                                     
			self.s1_subscore8                     := s1_subscore8;                                     
			self.s1_subscore9                     := s1_subscore9;                                     
			self.s1_subscore10                    := s1_subscore10;                                    
			self.s1_subscore11                    := s1_subscore11;                                    
			self.s1_subscore12                    := s1_subscore12;                                    
			self.s1_subscore13                    := s1_subscore13;                                    
			self.s1_subscore14                    := s1_subscore14;                                    
			self.s1_subscore15                    := s1_subscore15;                                    
			self.s1_subscore16                    := s1_subscore16;                                    
			self.s1_subscore17                    := s1_subscore17;                                    
			self.s1_rawscore                      := s1_rawscore;                                      
			self.s1_lnoddsscore                   := s1_lnoddsscore;                                   
			self.s1_probscore                     := s1_probscore;                                     
			self.iv_vp091_phnzip_mismatch         := iv_vp091_phnzip_mismatch;                         
			self.iv_va040_add_prison_hist         := iv_va040_add_prison_hist;                         
			self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;                            
			self.bureau_ssn_tn_fseen_pos          := bureau_ssn_tn_fseen_pos;                          
			self.bureau_ssn_fseen_tn              := bureau_ssn_fseen_tn;                              
			self._bureau_ssn_fseen_tn             := _bureau_ssn_fseen_tn;                             
			self.bureau_ssn_ts_fseen_pos          := bureau_ssn_ts_fseen_pos;                          
			self.bureau_ssn_fseen_ts              := bureau_ssn_fseen_ts;                              
			self._bureau_ssn_fseen_ts             := _bureau_ssn_fseen_ts;                             
			self.bureau_ssn_tu_fseen_pos          := bureau_ssn_tu_fseen_pos;                          
			self.bureau_ssn_fseen_tu              := bureau_ssn_fseen_tu;                              
			self._bureau_ssn_fseen_tu             := _bureau_ssn_fseen_tu;                             
			self.bureau_ssn_en_fseen_pos          := bureau_ssn_en_fseen_pos;                          
			self.bureau_ssn_fseen_en              := bureau_ssn_fseen_en;                              
			self._bureau_ssn_fseen_en             := _bureau_ssn_fseen_en;                             
			self.bureau_ssn_eq_fseen_pos          := bureau_ssn_eq_fseen_pos;                          
			self.bureau_ssn_fseen_eq              := bureau_ssn_fseen_eq;                              
			self._bureau_ssn_fseen_eq             := _bureau_ssn_fseen_eq;                             
			self._src_bureau_ssn_fseen            := _src_bureau_ssn_fseen;                            
			self.iv_mos_src_bureau_ssn_fseen      := iv_mos_src_bureau_ssn_fseen;                      
			self.prop_adl_p_count_pos             := prop_adl_p_count_pos;                             
			self.prop_adl_count_p                 := prop_adl_count_p;                                 
			self._src_prop_adl_count              := _src_prop_adl_count;                              
			self.iv_src_property_adl_count        := iv_src_property_adl_count;                        
			self._gong_did_first_seen             := _gong_did_first_seen;                             
			self.iv_mos_since_gong_did_fst_seen   := iv_mos_since_gong_did_fst_seen;                   
			self.iv_inq_recency                   := iv_inq_recency;                                   
			self.iv_inq_highriskcredit_recency    := iv_inq_highriskcredit_recency;                    
			self.iv_inq_per_addr                  := iv_inq_per_addr;                                  
			self.ver_phn_inf                      := ver_phn_inf;                                      
			self.ver_phn_nap                      := ver_phn_nap;                                      
			self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;                                  
			self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;                                  
			self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;                     
			self.iv_released_liens_ct             := iv_released_liens_ct;                             
			self.iv_criminal_count                := iv_criminal_count;                                
			self.nf_pct_rel_with_felony           := nf_pct_rel_with_felony;                           
			self.iv_ams_college_code              := iv_ams_college_code;                              
			self.nf_fp_varrisktype                := nf_fp_varrisktype;                                
			self.s2_subscore0                     := s2_subscore0;                                     
			self.s2_subscore1                     := s2_subscore1;                                     
			self.s2_subscore2                     := s2_subscore2;                                     
			self.s2_subscore3                     := s2_subscore3;                                     
			self.s2_subscore4                     := s2_subscore4;                                     
			self.s2_subscore5                     := s2_subscore5;                                     
			self.s2_subscore6                     := s2_subscore6;                                     
			self.s2_subscore7                     := s2_subscore7;                                     
			self.s2_subscore8                     := s2_subscore8;                                     
			self.s2_subscore9                     := s2_subscore9;                                     
			self.s2_subscore10                    := s2_subscore10;                                    
			self.s2_subscore11                    := s2_subscore11;                                    
			self.s2_subscore12                    := s2_subscore12;                                    
			self.s2_subscore13                    := s2_subscore13;                                    
			self.s2_subscore14                    := s2_subscore14;                                    
			self.s2_subscore15                    := s2_subscore15;                                    
			self.s2_subscore16                    := s2_subscore16;                                    
			self.s2_rawscore                      := s2_rawscore;                                      
			self.s2_lnoddsscore                   := s2_lnoddsscore;                                   
			self.s2_probscore                     := s2_probscore;                                     
			self.ver_src_cnt                      := ver_src_cnt;                                      
			self.ver_src_tn_pos                   := ver_src_tn_pos;                                   
			self.ver_src_tn                       := ver_src_tn;                                       
			self.ver_src_ds_pos                   := ver_src_ds_pos;                                   
			self.ver_src_ds                       := ver_src_ds;                                       
			self.ver_src_en_pos                   := ver_src_en_pos;                                   
			self.ver_src_en                       := ver_src_en;                                       
			self.ver_src_eq_pos                   := ver_src_eq_pos;                                   
			self.ver_src_eq                       := ver_src_eq;                                       
			self.ver_src_tu_pos                   := ver_src_tu_pos;                                   
			self.ver_src_tu                       := ver_src_tu;                                       
			self.ssnpop                           := ssnpop;                                           
			self._derog                           := _derog;                                           
			self.credit_source_cnt                := credit_source_cnt;                                
			self.bureauonly2                      := bureauonly2;                                      
			self.uv_segment3                      := uv_segment3;                                      
			self._segment                         := _segment;                                         
			self.probscore                        := probscore;                                        
			self.base                             := base;                                             
			self.odds                             := odds;                                             
			self.point                            := point;                                            
			self.or_decsssn                       := or_decsssn;                                       
			self.or_ssnpriordob                   := or_ssnpriordob;                                   
			self.or_prisonaddr                    := or_prisonaddr;                                    
			self.or_prisonphone                   := or_prisonphone;                                   
			self.or_hraddr                        := or_hraddr;                                        
			self.or_hrphone                       := or_hrphone;                                       
			self.or_invalidssn                    := or_invalidssn;                                    
			self.or_invalidaddr                   := or_invalidaddr;                                   
			self.or_invalidphone                  := or_invalidphone;                                  
			self.fp1307_2                         := fp1307_2;                                         
			self.stolenid                         := stolenid;                                         
			self.stolidindex                      := stolidindex;                                      
			self.syntheticid                      := syntheticid;                                      
			self.synthidindex                     := synthidindex;                                     
			self.inq_notver                       := inq_notver;                                       
			self.other_notver                     := other_notver;                                     
			self.ssn_adl_prob                     := ssn_adl_prob;                                     
			self.adl_ssn_prob                     := adl_ssn_prob;                                     
			self.veloprob                         := veloprob;                                         
			self.manipid                          := manipid;                                          
			self.manipidindex                     := manipidindex;                                     
			self.suspactivity                     := suspactivity;                                     
			self.suspactindex                     := suspactindex;                                     
			self.vulnvictim                       := vulnvictim;                                       
			self.vulnvicindex                     := vulnvicindex;                                     
			self.friendly                         := friendly;                                         
			self.friendfrdindex                   := friendfrdindex;                                   
			#end
		self.seq := le.bs.seq;
		ritmp :=  Models.fraudpoint_reasons(le.bs, le.ip, num_reasons, criminal );
		reasons := Models.Common.checkFraudPointRC34(FP1307_2, ritmp, num_reasons);
		self.ri := reasons;
		self.score := (string)fp1307_2;
		
		self.StolenIdentityIndex        := (string1)stolidindex;
		self.SyntheticIdentityIndex     := (string1)synthidindex;
		self.ManipulatedIdentityIndex   := (string1)manipidindex;
		self.VulnerableVictimIndex      := (string1)vulnvicindex;
		self.FriendlyFraudIndex         := (string1)friendfrdindex;
		self.SuspiciousActivityIndex    := (string1)suspactindex;
	END;

	model :=   join(clam_ip, Easi.Key_Easi_Census,
		left.bs.shell_input.st<>''
			and left.bs.shell_input.county <>''
			and left.bs.shell_input.geo_blk <> ''
			and keyed(right.geolink=left.bs.shell_input.st+left.bs.shell_input.county+left.bs.shell_input.geo_blk),
		doModel(left, right), left outer,
		atmost(RiskWise.max_atmost)
		,keep(1)
		);
	return model;
END;
