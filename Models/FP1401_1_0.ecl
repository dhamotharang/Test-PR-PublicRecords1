/*2014-04-07T22:49:26Z (Frank Allen)
validation complete, ready for production
*/
//Avon - custom Fraudpoint model

import risk_indicators, riskwise, ut, easi, std;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1401_1_0( dataset(risk_indicators.Layout_Boca_Shell) clam,  integer1 num_reasons) := FUNCTION

// FP_DEBUG := false;
	
	// #if(FP_DEBUG)
		// Layout_Debug := RECORD
		// /* Model Input Variables */
	// INTEGER sysdate                          ;
	// BOOLEAN ssnpop                           ;
	// BOOLEAN _derog                           ;
	// STRING avon_fp_segment                   ;
	// STRING iv_vs001_ssn_deceased             ;
	// STRING iv_vs002_ssn_prior_dob            ;
	// STRING iv_vs003_ssn_invalid              ;
	// STRING iv_vp003_phn_invalid              ;
	// STRING iv_vp004_phn_hirisk               ;
	// STRING iv_va001_add_po_box               ;
	// STRING iv_va002_add_invalid              ;
	// STRING iv_va003_add_hirisk_comm          ;
	// INTEGER iv_va040_add_prison_hist         ;
	// INTEGER iv_va060_dist_add_in_bst         ;
	// INTEGER iv_de001_eviction_recency        ;
	// INTEGER bureau_adl_tn_fseen_pos          ;
	// STRING bureau_adl_fseen_tn              ;
	// INTEGER _bureau_adl_fseen_tn             ;
	// INTEGER bureau_adl_ts_fseen_pos          ;
	// STRING bureau_adl_fseen_ts              ;
	// INTEGER _bureau_adl_fseen_ts             ;
	// INTEGER bureau_adl_tu_fseen_pos          ;
	// STRING bureau_adl_fseen_tu              ;
	// INTEGER _bureau_adl_fseen_tu             ;
	// INTEGER bureau_adl_en_fseen_pos          ;
	// STRING bureau_adl_fseen_en              ;
	// INTEGER _bureau_adl_fseen_en             ;
	// INTEGER bureau_adl_eq_fseen_pos          ;
	// STRING bureau_adl_fseen_eq              ;
	// INTEGER _bureau_adl_fseen_eq             ;
	// INTEGER iv_sr001_m_bureau_adl_fs         ;
	// INTEGER bureau_adl_vo_fseen_pos          ;
	// STRING bureau_adl_fseen_vo              ;
	// INTEGER _bureau_adl_fseen_vo             ;
	// INTEGER _src_bureau_adl_fseen            ;
	// INTEGER mth_ver_src_fdate_vo             ;
	// INTEGER bureau_adl_vo_lseen_pos          ;
	// STRING bureau_adl_lseen_vo              ;
	// INTEGER _bureau_adl_lseen_vo             ;
	// INTEGER mth_ver_src_ldate_vo             ;
	// BOOLEAN mth_ver_src_fdate_vo60           ;
	// BOOLEAN mth_ver_src_ldate_vo0            ;
	// INTEGER bureau_adl_w_lseen_pos           ;
	// STRING bureau_adl_lseen_w               ;
	// INTEGER _bureau_adl_lseen_w              ;
	// INTEGER mth_ver_src_ldate_w              ;
	// BOOLEAN mth_ver_src_ldate_w0             ;
	// INTEGER bureau_adl_wp_lseen_pos          ;
	// STRING bureau_adl_lseen_wp              ;
	// INTEGER _bureau_adl_lseen_wp             ;
	// INTEGER _src_bureau_adl_lseen            ;
	// INTEGER mth_ver_src_ldate_wp             ;
	// BOOLEAN mth_ver_src_ldate_wp0            ;
	// INTEGER _paw_first_seen                  ;
	// INTEGER mth_paw_first_seen               ;
	// INTEGER mth_paw_first_seen2              ;
	// BOOLEAN ver_src_am                       ;
	// BOOLEAN ver_src_e1                       ;
	// BOOLEAN ver_src_e2                       ;
	// BOOLEAN ver_src_e3                       ;
	// BOOLEAN ver_src_pl                       ;
	// BOOLEAN ver_src_w                        ;
	// BOOLEAN paw_dead_business_count_gt3      ;
	// BOOLEAN paw_active_phone_count_0         ;
	// INTEGER _infutor_first_seen              ;
	// INTEGER mth_infutor_first_seen           ;
	// INTEGER _infutor_last_seen               ;
	// INTEGER mth_infutor_last_seen            ;
	// INTEGER infutor_i                        ;
	// REAL infutor_im                       ;
	// INTEGER white_pages_adl_wp_fseen_pos     ;
	// STRING white_pages_adl_fseen_wp         ;
	// INTEGER _white_pages_adl_fseen_wp        ;
	// INTEGER _src_white_pages_adl_fseen       ;
	// INTEGER iv_sr001_m_wp_adl_fs             ;
	// INTEGER src_m_wp_adl_fs                  ;
	// INTEGER _header_first_seen               ;
	// INTEGER iv_sr001_m_hdr_fs                ;
	// INTEGER src_m_hdr_fs                     ;
	// REAL source_mod6                      ;
	// REAL iv_sr001_source_profile          ;
	// REAL iv_sr001_source_profile_index    ;
	// INTEGER iv_pv001_inp_avm_autoval         ;
	// STRING iv_po001_inp_addr_naprop         ;
	// STRING iv_ed001_college_ind             ;
	// STRING iv_inp_own_prop_x_addr_naprop    ;
	// STRING iv_bst_own_prop_x_addr_naprop    ;
	// INTEGER iv_avg_lres                      ;
	// INTEGER iv_ssns_per_addr_c6              ;
	// INTEGER iv_inq_communications_recency    ;
	// INTEGER iv_inq_highriskcredit_recency    ;
	// INTEGER iv_inq_highriskcredit_count12    ;
	// BOOLEAN ver_phn_inf                      ;
	// BOOLEAN ver_phn_nap                      ;
	// INTEGER inf_phn_ver_lvl                  ;
	// INTEGER nap_phn_ver_lvl                  ;
	// STRING iv_nap_phn_ver_x_inf_phn_ver     ;
	// STRING iv_rec_vehx_level                ;
	// INTEGER iv_criminal_count                ;
	// STRING iv_criminal_x_felony             ;
	// INTEGER iv_pb_total_dollars              ;
	// INTEGER iv_pb_total_orders               ;
	// STRING nf_fp_idverrisktype              ;
	// STRING nf_fp_varrisktype                ;
	// INTEGER nf_fp_srchfraudsrchcount         ;
	// INTEGER nf_fp_assocsuspicousidcount      ;
	// STRING nf_fp_divrisktype                ;
	// INTEGER nf_fp_srchaddrsrchcount          ;
	// INTEGER nf_fp_srchaddrsrchcountmo        ;
	// INTEGER nf_fp_srchphonesrchcountmo       ;
	// STRING nf_fp_componentcharrisktype      ;
	// INTEGER nf_fp_curraddrmurderindex        ;
	// INTEGER nf_fp_prevaddrcrimeindex         ;
	// REAL s0_subscore0                     ;
	// REAL s0_subscore1                     ;
	// REAL s0_subscore2                     ;
	// REAL s0_subscore3                     ;
	// REAL s0_subscore4                     ;
	// REAL s0_subscore5                     ;
	// REAL s0_subscore6                     ;
	// REAL s0_subscore7                     ;
	// REAL s0_rawscore                      ;
	// REAL s0_lnoddsscore                   ;
	// REAL s0_probscore                     ;
	// REAL s1_subscore0                     ;
	// REAL s1_subscore1                     ;
	// REAL s1_subscore2                     ;
	// REAL s1_subscore3                     ;
	// REAL s1_subscore4                     ;
	// REAL s1_subscore5                     ;
	// REAL s1_subscore6                     ;
	// REAL s1_subscore7                     ;
	// REAL s1_subscore8                     ;
	// REAL s1_subscore9                     ;
	// REAL s1_subscore10                    ;
	// REAL s1_subscore11                    ;
	// REAL s1_rawscore                      ;
	// REAL s1_lnoddsscore                   ;
	// REAL s1_probscore                     ;
	// REAL s2_subscore0                     ;
	// REAL s2_subscore1                     ;
	// REAL s2_subscore2                     ;
	// REAL s2_subscore3                     ;
	// REAL s2_subscore4                     ;
	// REAL s2_subscore5                     ;
	// REAL s2_subscore6                     ;
	// REAL s2_subscore7                     ;
	// REAL s2_subscore8                     ;
	// REAL s2_subscore9                     ;
	// REAL s2_subscore10                    ;
	// REAL s2_subscore11                    ;
	// REAL s2_subscore12                    ;
	// REAL s2_subscore13                    ;
	// REAL s2_rawscore                      ;
	// REAL s2_lnoddsscore                   ;
	// REAL s2_probscore                     ;
	// REAL s3_subscore0                     ;
	// REAL s3_subscore1                     ;
	// REAL s3_subscore2                     ;
	// REAL s3_subscore3                     ;
	// REAL s3_subscore4                     ;
	// REAL s3_subscore5                     ;
	// REAL s3_subscore6                     ;
	// REAL s3_subscore7                     ;
	// REAL s3_subscore8                     ;
	// REAL s3_subscore9                     ;
	// REAL s3_subscore10                    ;
	// REAL s3_subscore11                    ;
	// REAL s3_subscore12                    ;
	// REAL s3_subscore13                    ;
	// REAL s3_subscore14                    ;
	// REAL s3_subscore15                    ;
	// REAL s3_rawscore                      ;
	// REAL s3_lnoddsscore                   ;
	// REAL s3_probscore                     ;
	// REAL probscore                        ;
	// INTEGER base                             ;
	// INTEGER pts                              ;
	// REAL odds                             ;
	// INTEGER fp1401_1_0												;                                
		
			// models.layout_modelout;
			// risk_indicators.Layout_Boca_Shell clam;
		// END;
		// layout_debug doModel( clam le, easi.Key_Easi_Census ri ) :=  TRANSFORM
// #else
		models.layout_modelout doModel( clam le, easi.Key_Easi_Census ri  ) := TRANSFORM
// #end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	c_low_hval                       := ri.low_hval;
	c_med_hval                       := ri.med_hval;
	c_vacant_p                       := ri.vacant_p;
	truedid                          := le.truedid;
	out_z5                           := le.shell_input.z5;
	out_addr_type                    := le.shell_input.addr_type;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_hriskaddrflag                 := le.iid.hriskaddrflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnvalflag                    := le.iid.socsvalflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_phonetype                     := le.iid.phonetype;
	rc_ziptypeflag                   := le.iid.ziptypeflag;
	rc_zipclass                      := le.iid.zipclass;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	addrpop                          := le.input_validation.address;
	ssnlength                        := (Integer)le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	dist_a1toa2                      := le.address_verification.distance_in_2_h1;
	add2_naprop                      := le.address_verification.address_history_1.naprop;
	avg_lres                         := le.other_address_info.avg_lres;
	addrs_prison_history             := le.other_address_info.isprison;
	header_first_seen                := le.ssn_verification.header_first_seen;
	inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_communications_count01       := le.acc_logs.communications.count01;
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_communications_count06       := le.acc_logs.communications.count06;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_communications_count24       := le.acc_logs.communications.count24;
	pb_total_dollars                 := le.ibehavior.total_dollars;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	paw_first_seen                   := le.employment.first_seen_date;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	infutor_last_seen                := le.infutor_phone.infutor_date_last_seen;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	fp_idverrisktype                 := le.fdattributesv2.idverrisklevel;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_srchfraudsrchcount            := le.fdattributesv2.searchfraudsearchcount;
	fp_assocsuspicousidcount         := le.fdattributesv2.assocsuspicousidentitiescount;
	fp_divrisktype                   := le.fdattributesv2.divrisklevel;
	fp_srchaddrsrchcount             := le.fdattributesv2.searchaddrsearchcount;
	fp_srchaddrsrchcountmo           := le.fdattributesv2.searchaddrsearchcountmonth;
	fp_srchphonesrchcountmo          := le.fdattributesv2.searchphonesearchcountmonth;
	fp_componentcharrisktype         := le.fdattributesv2.componentcharrisklevel;
	fp_curraddrmurderindex           := le.fdattributesv2.curraddrmurderindex;
	fp_prevaddrcrimeindex            := le.fdattributesv2.prevaddrcrimeindex;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	ams_class                        := le.student.class;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	ams_income_level_code            := le.student.income_level_code;
	ams_file_type                    := le.student.file_type2;
	ams_college_tier                 := le.student.college_tier;
	ams_college_major                := le.student.college_major;


/* ***********************************************************
*                    Generated ECL                          *
************************************************************** */

NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

sysdate := __common__( common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01')) );

ssnpop := __common__( (INTEGER)ssnlength > 0 );

_derog := __common__( (INTEGER)felony_count > 0 or 
					(INTEGER)addrs_prison_history > 0 or 
					(INTEGER)attr_num_unrel_liens60 > 0 or 
					(INTEGER)attr_eviction_count > 0 or 
					(INTEGER)impulse_count > 0 );

avon_fp_segment := __common__( map(
    (INTEGER)ssnpop = 0        => '0 No SSN ',
    (nas_summary in [4, 7, 9]) => '1 NAS 479',
    _derog                     => '2 Derog  ',
                                  '3 Other  ') );

iv_vs001_ssn_deceased := __common__( map(
    not(truedid or (ssnlength > 0))										   => ' ',
    (INTEGER)rc_decsflag = 1                                               => '1',
    contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 => '1',
    (INTEGER)rc_decsflag = 0                                               => '0',
																			  ' ') );

iv_vs002_ssn_prior_dob := __common__( map(
    not((INTEGER)ssnlength > 0 and dobpop)            			=> ' ',
    (INTEGER)rc_ssndobflag = 1 or (INTEGER)rc_pwssndobflag = 1 	=> '1',
    (INTEGER)rc_ssndobflag = 0 or (INTEGER)rc_pwssndobflag = 0 	=> '0',
																   ' ') );

iv_vs003_ssn_invalid := __common__( map(
    not((INTEGER)ssnlength > 0)                                                                                 => ' ',
    (INTEGER)rc_ssnvalflag = 1 or (rc_pwssnvalflag in ['1', '2', '3']) or (inputssncharflag in ['1', '2', '3']) => '1',
    (INTEGER)rc_ssnvalflag = 0 or (rc_pwssnvalflag in ['0', '4', '5']) or (inputssncharflag in ['0', '4', '5']) => '0',
																												   ' ') );

iv_vp003_phn_invalid := __common__( map(
    not(hphnpop)                                                    						   => ' ',
    (INTEGER)rc_phonevalflag = 0 or (INTEGER)rc_hphonevalflag = 0 or (INTEGER)rc_phonetype = 5 => '1',
																								  '0') );

iv_vp004_phn_hirisk := __common__( map(
    not(hphnpop)                                                                                    						   => ' ',
    (INTEGER)rc_hriskphoneflag = 6 or rc_hphonetypeflag = '5' or (INTEGER)rc_hphonevalflag = 3 or (INTEGER)rc_addrcommflag = 1 => '1',
																																  '0') );
	
iv_va001_add_po_box := __common__( map(
    not(add1_pop or out_z5 != '')                   				 			 => ' ',
    (INTEGER)rc_hriskaddrflag = 1 or 
		(INTEGER)rc_ziptypeflag = 1 or 
		StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'E' or 
		StringLib.StringToUpperCase(trim(rc_zipclass, LEFT, RIGHT)) = 'P' or 
		StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'P' 	 => '1',
																					'0') );

iv_va002_add_invalid := __common__( map(
    not(add1_pop)                                       => ' ',
    trim(trim(rc_addrvalflag, LEFT), LEFT, RIGHT) = 'N' => '1',
                                                           '0') );

iv_va003_add_hirisk_comm := __common__( map(
    not(add1_pop)                               				  => ' ',
    (INTEGER)rc_hriskaddrflag = 4 or (INTEGER)rc_addrcommflag = 2 => '1',
																	 '0') );

iv_va040_add_prison_hist := __common__( if(not(truedid), NULL, (INTEGER)addrs_prison_history) );

iv_va060_dist_add_in_bst := __common__( map(
    not(truedid)       => NULL,
    add1_isbestmatch   => 0,
    dist_a1toa2 = 9999 => NULL,
                          dist_a1toa2) );

iv_de001_eviction_recency := __common__( map(
    not(truedid)                                                => NULL,
    (boolean)attr_eviction_count90                              => 3,
    (boolean)attr_eviction_count180                             => 6,
    (boolean)attr_eviction_count12                              => 12,
    (boolean)attr_eviction_count24 and attr_eviction_count >= 2 => 24,
    (boolean)attr_eviction_count24                              => 25,
    (boolean)attr_eviction_count36 and attr_eviction_count >= 2 => 36,
    (boolean)attr_eviction_count36                              => 37,
    (boolean)attr_eviction_count60 and attr_eviction_count >= 2 => 60,
    (boolean)attr_eviction_count60                              => 61,
    attr_eviction_count >= 2                                    => 98,
    attr_eviction_count >= 1                                    => 99,
                                                                   0) );

bureau_adl_tn_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E') );

bureau_adl_fseen_tn := __common__( if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos, ',')) );

_bureau_adl_fseen_tn := __common__( common.sas_date((string)(bureau_adl_fseen_tn)) );

bureau_adl_ts_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E') );

bureau_adl_fseen_ts := __common__( if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos, ',')) );

_bureau_adl_fseen_ts := __common__( common.sas_date((string)(bureau_adl_fseen_ts)) );

bureau_adl_tu_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E') );

bureau_adl_fseen_tu := __common__( if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos, ',')) );

_bureau_adl_fseen_tu := __common__( common.sas_date((string)(bureau_adl_fseen_tu)) );

bureau_adl_en_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E') );

bureau_adl_fseen_en := __common__( if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ',')) );

_bureau_adl_fseen_en := __common__( common.sas_date((string)(bureau_adl_fseen_en)) );

bureau_adl_eq_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E') );

bureau_adl_fseen_eq := __common__( if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ',')) );

_bureau_adl_fseen_eq := __common__( common.sas_date((string)(bureau_adl_fseen_eq)) );

_src_bureau_adl_fseen_1 := __common__( min(if(_bureau_adl_fseen_tn = NULL, -NULL, _bureau_adl_fseen_tn),
															 if(_bureau_adl_fseen_ts = NULL, -NULL, _bureau_adl_fseen_ts),
															 if(_bureau_adl_fseen_tu = NULL, -NULL, _bureau_adl_fseen_tu),
															 if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en),
															 if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq),
																	999999) );

iv_sr001_m_bureau_adl_fs := __common__( map(
    not(truedid)                     => NULL,
    _src_bureau_adl_fseen_1 = 999999 => -1,
                                        if ((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12)))) );

_header_first_seen_1 := __common__( common.sas_date((string)(header_first_seen)) );

iv_sr001_m_hdr_fs_1 := __common__( map(
    not(truedid)                     => NULL,
    not(_header_first_seen_1 = NULL) => if ((sysdate - _header_first_seen_1) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen_1) / (365.25 / 12)), roundup((sysdate - _header_first_seen_1) / (365.25 / 12))),
                                        -1) );

bureau_adl_vo_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E') );

bureau_adl_fseen_vo := __common__( if(bureau_adl_vo_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_vo_fseen_pos, ',')) );

_bureau_adl_fseen_vo := __common__( common.sas_date((string)(bureau_adl_fseen_vo)) );

_src_bureau_adl_fseen := __common__( _bureau_adl_fseen_vo );

mth_ver_src_fdate_vo := __common__( map(
    not(truedid)                 => NULL,
    _src_bureau_adl_fseen = NULL => -1,
    if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0,
			truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)),
			roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))) );

bureau_adl_vo_lseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E') );

bureau_adl_lseen_vo := __common__( if(bureau_adl_vo_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_vo_lseen_pos, ',')) );

_bureau_adl_lseen_vo := __common__( common.sas_date((string)(bureau_adl_lseen_vo)) );

_src_bureau_adl_lseen_2 := __common__( _bureau_adl_lseen_vo );

mth_ver_src_ldate_vo := __common__( map(
    not(truedid)                   => NULL,
    _src_bureau_adl_lseen_2 = NULL => -1,
                                      if ((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12)))) );

mth_ver_src_fdate_vo60 := __common__( mth_ver_src_fdate_vo > 60 );

mth_ver_src_ldate_vo0 := __common__( mth_ver_src_ldate_vo = 0 );

bureau_adl_w_lseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E') );

bureau_adl_lseen_w := __common__( if(bureau_adl_w_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_w_lseen_pos, ',')) );

_bureau_adl_lseen_w := __common__( common.sas_date((string)(bureau_adl_lseen_w)) );

_src_bureau_adl_lseen_1 := __common__( _bureau_adl_lseen_w );

mth_ver_src_ldate_w := __common__( map(
    not(truedid)                   => NULL,
    _src_bureau_adl_lseen_1 = NULL => -1,
                                      if ((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12)))) );

mth_ver_src_ldate_w0 := __common__( mth_ver_src_ldate_w = 0 );

bureau_adl_wp_lseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E') );

bureau_adl_lseen_wp := __common__( if(bureau_adl_wp_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_wp_lseen_pos, ',')) );

_bureau_adl_lseen_wp := __common__( common.sas_date((string)(bureau_adl_lseen_wp)) );

_src_bureau_adl_lseen := __common__( _bureau_adl_lseen_wp );

mth_ver_src_ldate_wp := __common__( map(
    not(truedid)                 => NULL,
    _src_bureau_adl_lseen = NULL => -1,
                                    if ((sysdate - _src_bureau_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen) / (365.25 / 12)))) );

mth_ver_src_ldate_wp0 := __common__( mth_ver_src_ldate_wp = 0 );

_paw_first_seen := __common__( common.sas_date1800s((string)(PAW_first_seen)) );

mth_paw_first_seen := __common__( map(
    not(truedid)           => NULL,
    _paw_first_seen = NULL => -1,
                              if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen) / (365.25 / 12)), roundup((sysdate - _paw_first_seen) / (365.25 / 12)))) );

mth_paw_first_seen2 := __common__( if(mth_paw_first_seen = NULL or mth_paw_first_seen < 6, 6, min(360, if(mth_paw_first_seen = NULL, -NULL, mth_paw_first_seen))) );

ver_src_am := __common__( Models.Common.findw_cpp(ver_sources, 'AM' , ', ', 'E') > 0 );

ver_src_e1 := __common__( Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E') > 0 );

ver_src_e2 := __common__( Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E') > 0 );

ver_src_e3 := __common__( Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E') > 0 );

ver_src_pl := __common__( Models.Common.findw_cpp(ver_sources, 'PL' , ', ', 'E') > 0 );

ver_src_w := __common__( Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E') > 0 );

paw_dead_business_count_gt3 := __common__( paw_dead_business_count > 3 );

paw_active_phone_count_0 := __common__( paw_active_phone_count <= 0 );

_infutor_first_seen := __common__( common.sas_date((string)(infutor_first_seen)) );

mth_infutor_first_seen := __common__( map(
    not(truedid)               => NULL,
    _infutor_first_seen = NULL => NULL,
                                  if ((sysdate - _infutor_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_first_seen) / (365.25 / 12)), roundup((sysdate - _infutor_first_seen) / (365.25 / 12)))) );

_infutor_last_seen := __common__( common.sas_date((string)(infutor_last_seen)) );

mth_infutor_last_seen := __common__( map(
    not(truedid)              => NULL,
    _infutor_last_seen = NULL => NULL,
                                 if ((sysdate - _infutor_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_last_seen) / (365.25 / 12)), roundup((sysdate - _infutor_last_seen) / (365.25 / 12)))) );

infutor_i := __common__( map(
    infutor_nap = 12 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 1,
    infutor_nap = 12                                                                 => 4,
    infutor_nap = 11 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 3,
    infutor_nap = 11                                                                 => 5,
    infutor_nap >= 7 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 6,
    infutor_nap >= 7                                                                 => 7,
    (infutor_nap in [1, 6])                                                          => 8,
    (infutor_nap in [0])                                                             => 2,
                                                                                        7) );

infutor_im := __common__( map(
    infutor_i = 1 => 7.77,
    infutor_i = 2 => 8.06,
    infutor_i = 3 => 8.38,
    infutor_i = 4 => 8.96,
    infutor_i = 5 => 9.35,
    infutor_i = 6 => 10.19,
    infutor_i = 7 => 13.13,
    infutor_i = 8 => 14.77,
                     9.03) );

white_pages_adl_wp_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E') );

white_pages_adl_fseen_wp := __common__( if(white_pages_adl_wp_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, white_pages_adl_wp_fseen_pos, ',')) );

_white_pages_adl_fseen_wp := __common__( common.sas_date((string)(white_pages_adl_fseen_wp)) );

_src_white_pages_adl_fseen := __common__( _white_pages_adl_fseen_wp );

iv_sr001_m_wp_adl_fs := __common__( map(
    not(truedid)                      => NULL,
    _src_white_pages_adl_fseen = NULL => -1,
                                         if ((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12)))) );

src_m_wp_adl_fs := __common__( map(
    iv_sr001_m_wp_adl_fs = NULL => -1,
    iv_sr001_m_wp_adl_fs = -1   => 10,
    iv_sr001_m_wp_adl_fs >= 24  => 24,
                                   iv_sr001_m_wp_adl_fs) );

_header_first_seen := __common__( common.sas_date((string)(header_first_seen)) );

iv_sr001_m_hdr_fs := __common__( map(
    not(truedid)                   => NULL,
    not(_header_first_seen = NULL) => if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))),
                                      -1) );

src_m_hdr_fs := __common__( map(
    iv_sr001_m_hdr_fs = NULL => 15,
    iv_sr001_m_hdr_fs = -1   => 40,
    iv_sr001_m_hdr_fs >= 260 => 260,
                                iv_sr001_m_hdr_fs) );

source_mod6_1 := __common__( -2.350792319 +
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
    src_m_hdr_fs * -0.004903484 );

source_mod6 := __common__( exp(source_mod6_1) / (1 + exp(source_mod6_1)) );

// iv_sr001_source_profile := __common__( if(not(truedid), NULL, max((real)0, round(100 - 500 * source_mod6/0.1)*0.1)) );
source_profile_temp := __common__( (100 - (500 * source_mod6)) );
iv_sr001_source_profile := __common__( if(not(truedid), NULL, max(0, round(source_profile_temp * 10) / 10)) );

iv_sr001_source_profile_index := __common__( map(
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
                                     9) );

iv_pv001_inp_avm_autoval := __common__( if(not(add1_pop), NULL, add1_avm_automated_valuation) );

iv_po001_inp_addr_naprop := __common__( if(not(add1_pop), ' ', (string)add1_naprop) );

iv_ed001_college_ind := __common__( map(
    not(truedid)                                    => ' ',
    ams_college_code != '' or 
		ams_college_type != '' or 
		// ams_college_tier >= 0 or 
		ams_college_tier != '' or 
		ams_college_major != '' or 
		(ams_file_type in ['H', 'C', 'A'])             => '1',
    ams_file_type = 'M'                            => '0',
    ams_class != '' or 
		ams_income_level_code != ''     => '1',
																									'0') );

iv_inp_own_prop_x_addr_naprop := __common__( map(
    not(add1_pop)            => '  ',
    property_owned_total > 0 => Intformat((INTEGER)add1_naprop + 10, 2, 1)[1..2],
                                Intformat((Integer)add1_naprop, 2, 1)[1..2]) );

iv_bst_own_prop_x_addr_naprop_c46 := __common__( if(property_owned_total > 0, (string)(add1_naprop + 10), Intformat((Integer)add1_naprop, 2, 1)[1..2]) );

iv_bst_own_prop_x_addr_naprop_c47 := __common__( if(property_owned_total > 0, (string)(add2_naprop + 10), Intformat((Integer)add2_naprop, 2, 1)[1..2]) );

iv_bst_own_prop_x_addr_naprop := __common__( map(
    not(truedid)     => '  ',
    add1_isbestmatch => iv_bst_own_prop_x_addr_naprop_c46,
                        iv_bst_own_prop_x_addr_naprop_c47) );

iv_avg_lres := __common__( if(not(truedid), NULL, avg_lres) );

iv_ssns_per_addr_c6 := __common__( if(not(add1_pop), NULL, ssns_per_addr_c6) );

iv_inq_communications_recency := __common__( map(
    not(truedid)               => NULL,
    (Boolean)inq_communications_count01 => 1,
    (Boolean)inq_communications_count03 => 3,
    (Boolean)inq_communications_count06 => 6,
    (Boolean)inq_communications_count12 => 12,
    (Boolean)inq_communications_count24 => 24,
    (Boolean)inq_communications_count   => 99,
																					 0) );

iv_inq_highriskcredit_recency := __common__( map(
    not(truedid)               => NULL,
    (Boolean)inq_highRiskCredit_count01 => 1,
    (Boolean)inq_highRiskCredit_count03 => 3,
    (Boolean)inq_highRiskCredit_count06 => 6,
    (Boolean)inq_highRiskCredit_count12 => 12,
    (Boolean)inq_highRiskCredit_count24 => 24,
    (Boolean)inq_highRiskCredit_count   => 99,
																					 0) );

iv_inq_highriskcredit_count12 := __common__( if(not(truedid), NULL, inq_highRiskCredit_count12) );

ver_phn_inf := __common__( (infutor_nap in [4, 6, 7, 9, 10, 11, 12]) );

ver_phn_nap := __common__( (nap_summary in [4, 6, 7, 9, 10, 11, 12]) );

inf_phn_ver_lvl := __common__( map(
    ver_phn_inf     => 3,
    infutor_nap = 1 => 1,
    infutor_nap = 0 => 0,
                       2) );

nap_phn_ver_lvl := __common__( map(
    ver_phn_nap     => 3,
    nap_summary = 1 => 1,
    nap_summary = 0 => 0,
                       2) );

iv_nap_phn_ver_x_inf_phn_ver := __common__( map(
    not(addrpop or hphnpop) => '   ',
    not(hphnpop)            => ' -1',
                               trim((string)nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)inf_phn_ver_lvl, LEFT, RIGHT)) );

iv_rec_vehx_level := __common__( map(
    not(truedid)                                   => '  ',
    attr_num_aircraft > 0 and watercraft_count > 0 => 'AW',
    attr_num_aircraft > 0                          => 'AO',
    watercraft_count > 0                           => trim('W', LEFT, RIGHT) + trim((string)min(if(watercraft_count = NULL, -NULL, watercraft_count), 3), LEFT, RIGHT),
                                                      'XX') );

iv_criminal_count := __common__( if(not(truedid), NULL, criminal_count) );

iv_criminal_x_felony := __common__( if(not(truedid), '   ', trim((string)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT)) );

iv_pb_total_dollars := __common__( map(
    not(truedid)          => NULL,
    pb_total_dollars = '' => -1,
                       (Integer)pb_total_dollars) );

iv_pb_total_orders := __common__( map(
    not(truedid)         => NULL,
    pb_total_orders = '' => -1,
                      (Integer)pb_total_orders) );

nf_fp_idverrisktype := __common__( if(not(truedid) or (Integer)fp_idverrisktype = NULL, '  ', trim((string)fp_idverrisktype, LEFT)) );

nf_fp_varrisktype := __common__( if(not(truedid) or (Integer)fp_varrisktype = NULL, '  ', trim((string)fp_varrisktype, LEFT)) );

nf_fp_srchfraudsrchcount := __common__( if(not(truedid), NULL, (Integer)fp_srchfraudsrchcount) );

nf_fp_assocsuspicousidcount := __common__( if(not(truedid), NULL, (Integer)fp_assocsuspicousidcount) );

nf_fp_divrisktype := __common__( if(not(truedid) or (Integer)fp_divrisktype = NULL, '  ', trim((string)fp_divrisktype, LEFT)) );

nf_fp_srchaddrsrchcount := __common__( if(not(truedid), NULL, (Integer)fp_srchaddrsrchcount) );

nf_fp_srchaddrsrchcountmo := __common__( if(not(truedid), NULL, (Integer)fp_srchaddrsrchcountmo) );

nf_fp_srchphonesrchcountmo := __common__( if(not(truedid), NULL, (Integer)fp_srchphonesrchcountmo) );

nf_fp_componentcharrisktype := __common__( if(not(truedid) or (Integer)fp_componentcharrisktype = NULL, '  ', trim((string)fp_componentcharrisktype, LEFT)) );

nf_fp_curraddrmurderindex := __common__( if(not(truedid), NULL, (Integer)fp_curraddrmurderindex) );

nf_fp_prevaddrcrimeindex := __common__( if(not(truedid), NULL, (Integer)fp_prevaddrcrimeindex) );

s0_subscore0 := __common__( map(
		c_low_hval != '' and NULL < (Real)c_low_hval AND (Real)c_low_hval < 4.5		=> 0.241032,
    4.5 <= (Real)c_low_hval AND (Real)c_low_hval < 35.7  											=> 0.061828,
    35.7 <= (Real)c_low_hval AND (Real)c_low_hval < 58.7 											=> -0.514270,
    58.7 <= (Real)c_low_hval                       			 											=> -0.881704, 
																																								 0.000000) );

s0_subscore1 := __common__( map(
    (iv_inp_own_prop_x_addr_naprop in [' '])                          => 0.000000,
    (iv_inp_own_prop_x_addr_naprop in ['00', '10'])                   => -0.117769,
    (iv_inp_own_prop_x_addr_naprop in ['01', '11'])                   => -0.114336,
    (iv_inp_own_prop_x_addr_naprop in ['02', '03', '04', '12', '13']) => 0.220343,
    (iv_inp_own_prop_x_addr_naprop in ['14'])                         => 1.486630,
                                                                         0.000000) );

s0_subscore2 := __common__( map(
    (iv_va001_add_po_box in ['0']) => 0.057804,
    (iv_va001_add_po_box in ['1']) => -0.600249,
                                      -0.000000) );

s0_subscore3 := __common__( map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                              => -0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0'])                             => -0.258460,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0', '1-1'])               => -0.170754,
    (iv_nap_phn_ver_x_inf_phn_ver in ['2-0', '2-1'])                      => 0.048467,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '1-3', '2-3', '3-1', '3-3']) => 0.259253,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                             => 0.739603,
                                                                             -0.000000) );

s0_subscore4 := __common__( map(
    NULL < nf_fp_srchphonesrchcountmo AND nf_fp_srchphonesrchcountmo < 0 => -0.000000,
    0 <= nf_fp_srchphonesrchcountmo AND nf_fp_srchphonesrchcountmo < 1   => 0.307915,
    1 <= nf_fp_srchphonesrchcountmo AND nf_fp_srchphonesrchcountmo < 2   => 0.043391,
    2 <= nf_fp_srchphonesrchcountmo AND nf_fp_srchphonesrchcountmo < 3   => -0.325595,
    3 <= nf_fp_srchphonesrchcountmo                                      => -0.616525,
                                                                            -0.000000) );

s0_subscore5 := __common__( map(
    c_vacant_p != '' and NULL < (Real)c_vacant_p AND (Real)c_vacant_p < 4.7		=> 0.257534,
    4.7 <= (Real)c_vacant_p AND (Real)c_vacant_p < 6     											=> 0.230729,
    6 <= (Real)c_vacant_p AND (Real)c_vacant_p < 11.2    											=> 0.043072,
    11.2 <= (Real)c_vacant_p AND (Real)c_vacant_p < 13.5 											=> -0.284640,
    13.5 <= (Real)c_vacant_p                       			 											=> -0.306563,
																																								 0.000000) );

s0_subscore6 := __common__( map(
    NULL < iv_va060_dist_add_in_bst AND iv_va060_dist_add_in_bst < 1 => 0.148509,
    1 <= iv_va060_dist_add_in_bst AND iv_va060_dist_add_in_bst < 5   => 0.036113,
    5 <= iv_va060_dist_add_in_bst AND iv_va060_dist_add_in_bst < 182 => -0.208611,
    182 <= iv_va060_dist_add_in_bst                                  => -0.439913,
                                                                        -0.000000) );

s0_subscore7 := __common__( map(
    NULL < iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 1 => 0.034009,
    1 <= iv_inq_highriskcredit_count12                                         => -0.517662,
                                                                                  -0.000000) );

s0_rawscore := __common__( s0_subscore0 +
    s0_subscore1 +
    s0_subscore2 +
    s0_subscore3 +
    s0_subscore4 +
    s0_subscore5 +
    s0_subscore6 +
    s0_subscore7 );

s0_lnoddsscore := __common__( s0_rawscore + 0.221824 );

s0_probscore := __common__( exp(s0_lnoddsscore) / (1 + exp(s0_lnoddsscore)) );

s1_subscore0 := __common__( map(
    NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => 0.244863,
    1 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 12  => -0.589269,
    12 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 24 => -0.367521,
    24 <= iv_inq_highriskcredit_recency                                        => -0.195603,
                                                                                  -0.000000) );

s1_subscore1 := __common__( map(
    NULL < iv_inq_communications_recency AND iv_inq_communications_recency < 1 => 0.160684,
    1 <= iv_inq_communications_recency AND iv_inq_communications_recency < 99  => -0.292429,
    99 <= iv_inq_communications_recency                                        => -0.179074,
                                                                                  -0.000000) );

s1_subscore2 := __common__( map(
    NULL < nf_fp_srchaddrsrchcountmo AND nf_fp_srchaddrsrchcountmo < 0 => 0.000000,
    0 <= nf_fp_srchaddrsrchcountmo AND nf_fp_srchaddrsrchcountmo < 1   => 0.322258,
    1 <= nf_fp_srchaddrsrchcountmo AND nf_fp_srchaddrsrchcountmo < 2   => -0.110657,
    2 <= nf_fp_srchaddrsrchcountmo AND nf_fp_srchaddrsrchcountmo < 3   => -0.358598,
    3 <= nf_fp_srchaddrsrchcountmo                                     => -0.369359,
                                                                          0.000000) );

s1_subscore3 := __common__( map(
    (iv_criminal_x_felony in ['0-0'])                                    => 0.101097,
    (iv_criminal_x_felony in ['1-0', '2-0'])                             => -0.137219,
    (iv_criminal_x_felony in ['3-0'])                                    => -0.401547,
    (iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => -0.846233,
                                                                            -0.000000) );

s1_subscore4 := __common__( map(
    (iv_bst_own_prop_x_addr_naprop in ['00', '01', '02', '03', '11']) => -0.062937,
    (iv_bst_own_prop_x_addr_naprop in ['04', '10', '12', '13'])       => 0.357867,
    (iv_bst_own_prop_x_addr_naprop in ['14'])                         => 0.738566,
                                                                         -0.000000) );

s1_subscore5 := __common__( map(
    (iv_nap_phn_ver_x_inf_phn_ver in [' '])                                                    => -0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                                                   => -0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0'])                                                  => -0.095609,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0', '1-1', '1-3', '2-0', '2-1', '3-1', '3-3']) => -0.073660,
    (iv_nap_phn_ver_x_inf_phn_ver in ['2-3', '3-0'])                                           => 0.292840,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3'])                                                  => 0.334804,
                                                                                                  -0.000000) );

s1_subscore6 := __common__( map(
    NULL < (Integer)c_med_hval AND (Integer)c_med_hval < 5000      => -0.000000,
    5000 <= (Integer)c_med_hval AND (Integer)c_med_hval < 72288    => -0.304791,
    72288 <= (Integer)c_med_hval AND (Integer)c_med_hval < 115402  => -0.091446,
    115402 <= (Integer)c_med_hval AND (Integer)c_med_hval < 188730 => 0.026579,
    188730 <= (Integer)c_med_hval AND (Integer)c_med_hval < 364130 => 0.122956,
    364130 <= (Integer)c_med_hval                         				 => 0.399373,
																																			-0.000000) );

s1_subscore7 := __common__( map(
    NULL < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 0   => 0.000000,
    0 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 185   => -0.067448,
    185 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 317 => 0.014220,
    317 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 386 => 0.193219,
    386 <= iv_sr001_m_hdr_fs                             => 0.523906,
                                                            0.000000) );

s1_subscore8 := __common__( map(
    NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => -0.041820,
    1 <= iv_pb_total_orders AND iv_pb_total_orders < 2   => -0.024445,
    2 <= iv_pb_total_orders AND iv_pb_total_orders < 4   => 0.031978,
    4 <= iv_pb_total_orders AND iv_pb_total_orders < 11  => 0.070866,
    11 <= iv_pb_total_orders                             => 0.469268,
                                                            0.000000) );

s1_subscore9 := __common__( map(
    NULL < nf_fp_prevaddrcrimeindex AND nf_fp_prevaddrcrimeindex < 0   => 0.080958,
    0 <= nf_fp_prevaddrcrimeindex AND nf_fp_prevaddrcrimeindex < 34    => 0.216044,
    34 <= nf_fp_prevaddrcrimeindex AND nf_fp_prevaddrcrimeindex < 81   => 0.080972,
    81 <= nf_fp_prevaddrcrimeindex AND nf_fp_prevaddrcrimeindex < 118  => 0.029716,
    118 <= nf_fp_prevaddrcrimeindex AND nf_fp_prevaddrcrimeindex < 149 => -0.044080,
    149 <= nf_fp_prevaddrcrimeindex AND nf_fp_prevaddrcrimeindex < 190 => -0.073132,
    190 <= nf_fp_prevaddrcrimeindex                                    => -0.326989,
                                                                          0.000000) );

s1_subscore10 := __common__( map(
    (iv_ed001_college_ind in ['0']) => -0.021561,
    (iv_ed001_college_ind in ['1']) => 0.314220,
                                       -0.000000) );

s1_subscore11 := __common__( map(
    (nf_fp_componentcharrisktype in ['1', '2'])           => 0.118020,
    (nf_fp_componentcharrisktype in ['3'])                => 0.112560,
    (nf_fp_componentcharrisktype in ['4'])                => 0.061516,
    (nf_fp_componentcharrisktype in ['5'])                => -0.058881,
    (nf_fp_componentcharrisktype in ['6', '7', '8', '9']) => -0.083854,
                                                             -0.000000) );

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
    s1_subscore11 );

s1_lnoddsscore := __common__( s1_rawscore + 0.234281 );

s1_probscore := __common__( exp(s1_lnoddsscore) / (1 + exp(s1_lnoddsscore)) );

s2_subscore0 := __common__( map(
    NULL < iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 1   => -0.000000,
    1 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 92    => -0.174832,
    92 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 173  => -0.139768,
    173 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 254 => -0.087408,
    254 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 316 => -0.036044,
    316 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 374 => 0.279977,
    374 <= iv_sr001_m_bureau_adl_fs                                    => 0.471630,
                                                                          -0.000000) );

s2_subscore1 := __common__( map(
    NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => 0.213411,
    1 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 6   => -0.168825,
    6 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 24  => -0.150946,
    24 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 99 => -0.150787,
    99 <= iv_inq_highriskcredit_recency                                        => -0.075930,
                                                                                  0.000000) );

s2_subscore2 := __common__( map(
    NULL < iv_pb_total_dollars AND iv_pb_total_dollars < 0  => -0.169913,
    0 <= iv_pb_total_dollars AND iv_pb_total_dollars < 59   => -0.038049,
    59 <= iv_pb_total_dollars AND iv_pb_total_dollars < 740 => 0.094347,
    740 <= iv_pb_total_dollars                              => 0.287896,
                                                               -0.000000) );

s2_subscore3 := __common__( map(
    NULL < iv_inq_communications_recency AND iv_inq_communications_recency < 1 => 0.100593,
    1 <= iv_inq_communications_recency AND iv_inq_communications_recency < 24  => -0.155439,
    24 <= iv_inq_communications_recency AND iv_inq_communications_recency < 99 => -0.152653,
    99 <= iv_inq_communications_recency                                        => -0.047376,
                                                                                  0.000000) );

s2_subscore4 := __common__( map(
    (nf_fp_componentcharrisktype in [' '])           => 0.000000,
    (nf_fp_componentcharrisktype in ['1'])           => 0.618439,
    (nf_fp_componentcharrisktype in ['2', '3'])      => 0.130655,
    (nf_fp_componentcharrisktype in ['4', '5'])      => -0.012128,
    (nf_fp_componentcharrisktype in ['6'])           => -0.092245,
    (nf_fp_componentcharrisktype in ['7', '8', '9']) => -0.343859,
                                                        0.000000) );

s2_subscore5 := __common__( map(
    NULL < nf_fp_srchfraudsrchcount AND nf_fp_srchfraudsrchcount < 7 => 0.095757,
    7 <= nf_fp_srchfraudsrchcount AND nf_fp_srchfraudsrchcount < 11  => -0.075463,
    11 <= nf_fp_srchfraudsrchcount AND nf_fp_srchfraudsrchcount < 19 => -0.081235,
    19 <= nf_fp_srchfraudsrchcount                                   => -0.175137,
                                                                        -0.000000) );

s2_subscore6 := __common__( map(
    (iv_po001_inp_addr_naprop in ['1'])      => -0.172164,
    (iv_po001_inp_addr_naprop in ['0'])      => 0.007985,
    (iv_po001_inp_addr_naprop in ['2', '3']) => 0.072838,
    (iv_po001_inp_addr_naprop in ['4'])      => 0.426745,
                                                -0.000000) );

s2_subscore7 := __common__( map(
    (nf_fp_varrisktype in [' '])                => 0.000000,
    (nf_fp_varrisktype in ['-1'])               => 0.000000,
    (nf_fp_varrisktype in ['1', '2'])           => 0.184041,
    (nf_fp_varrisktype in ['3'])                => 0.009762,
    (nf_fp_varrisktype in ['4', '5'])           => -0.109741,
    (nf_fp_varrisktype in ['6', '7', '8', '9']) => -0.228564,
                                                   0.000000) );

s2_subscore8 := __common__( map(
    (iv_criminal_x_felony in [' '])                                      => 0.000000,
    (iv_criminal_x_felony in ['0-0'])                                    => 0.023937,
    (iv_criminal_x_felony in ['1-0', '2-0'])                             => 0.019744,
    (iv_criminal_x_felony in ['3-0'])                                    => -0.092964,
    (iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => -0.115675,
                                                                            0.000000) );

s2_subscore9 := __common__( map(
    (iv_rec_vehx_level in [' '])                          => 0.000000,
    (iv_rec_vehx_level in ['XX'])                         => -0.006911,
    (iv_rec_vehx_level in ['W1', 'W2', 'W3', 'AW', 'AO']) => 0.545663,
                                                             0.000000) );

s2_subscore10 := __common__( map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                                            => -0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0'])                                           => -0.139833,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0', '1-1', '1-3', '2-0', '2-1', '3-1']) => -0.018838,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '3-3'])                                    => 0.002924,
    (iv_nap_phn_ver_x_inf_phn_ver in ['2-3', '3-0'])                                    => 0.146224,
                                                                                           -0.000000) );

s2_subscore11 := __common__( map(
    NULL < nf_fp_assocsuspicousidcount AND nf_fp_assocsuspicousidcount < 1 => 0.204111,
    1 <= nf_fp_assocsuspicousidcount AND nf_fp_assocsuspicousidcount < 4   => 0.075402,
    4 <= nf_fp_assocsuspicousidcount AND nf_fp_assocsuspicousidcount < 7   => 0.008893,
    7 <= nf_fp_assocsuspicousidcount AND nf_fp_assocsuspicousidcount < 15  => -0.021971,
    15 <= nf_fp_assocsuspicousidcount                                      => -0.238176,
                                                                              0.000000) );

s2_subscore12 := __common__( map(
    NULL < iv_ssns_per_addr_c6 AND iv_ssns_per_addr_c6 < 1 => 0.102775,
    1 <= iv_ssns_per_addr_c6 AND iv_ssns_per_addr_c6 < 2   => -0.095058,
    2 <= iv_ssns_per_addr_c6 AND iv_ssns_per_addr_c6 < 3   => -0.099773,
    3 <= iv_ssns_per_addr_c6 AND iv_ssns_per_addr_c6 < 4   => -0.225080,
    4 <= iv_ssns_per_addr_c6                               => -0.279074,
                                                              0.000000) );

s2_subscore13 := __common__( map(
    NULL < iv_de001_eviction_recency AND iv_de001_eviction_recency < 1 => 0.085210,
    1 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 37  => -0.295142,
    37 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 61 => -0.177072,
    61 <= iv_de001_eviction_recency                                    => -0.022437,
                                                                          -0.000000) );

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
    s2_subscore13 );

s2_lnoddsscore := __common__( s2_rawscore + 0.145981 );

s2_probscore := __common__( exp(s2_lnoddsscore) / (1 + exp(s2_lnoddsscore)) );

s3_subscore0 := __common__( map(
    NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => 0.149478,
    1 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 12  => -0.468795,
    12 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 24 => -0.307556,
    24 <= iv_inq_highriskcredit_recency                                        => -0.306718,
                                                                                  0.000000) );

s3_subscore1 := __common__( map(
    (iv_inp_own_prop_x_addr_naprop in [' '])              => -0.000000,
    (iv_inp_own_prop_x_addr_naprop in ['01'])             => -0.223765,
    (iv_inp_own_prop_x_addr_naprop in ['00'])             => -0.219034,
    (iv_inp_own_prop_x_addr_naprop in ['02', '03', '11']) => 0.113772,
    (iv_inp_own_prop_x_addr_naprop in ['10', '12', '13']) => 0.217645,
    (iv_inp_own_prop_x_addr_naprop in ['04', '14'])       => 0.443605,
                                                             -0.000000) );

s3_subscore2 := __common__( map(
    NULL < iv_inq_communications_recency AND iv_inq_communications_recency < 1 => 0.084437,
    1 <= iv_inq_communications_recency AND iv_inq_communications_recency < 24  => -0.241843,
    24 <= iv_inq_communications_recency AND iv_inq_communications_recency < 99 => -0.239243,
    99 <= iv_inq_communications_recency                                        => -0.184376,
                                                                                  -0.000000) );

s3_subscore3 := __common__( map(
    NULL < nf_fp_assocsuspicousidcount AND nf_fp_assocsuspicousidcount < 1 => 0.161413,
    1 <= nf_fp_assocsuspicousidcount AND nf_fp_assocsuspicousidcount < 2   => 0.179736,
    2 <= nf_fp_assocsuspicousidcount AND nf_fp_assocsuspicousidcount < 5   => 0.006201,
    5 <= nf_fp_assocsuspicousidcount AND nf_fp_assocsuspicousidcount < 8   => -0.102077,
    8 <= nf_fp_assocsuspicousidcount AND nf_fp_assocsuspicousidcount < 16  => -0.151782,
    16 <= nf_fp_assocsuspicousidcount AND nf_fp_assocsuspicousidcount < 21 => -0.379921,
    21 <= nf_fp_assocsuspicousidcount                                      => -0.397209,
                                                                              0.000000) );

s3_subscore4 := __common__( map(
    NULL < iv_pb_total_dollars AND iv_pb_total_dollars < 0    => -0.150176,
    0 <= iv_pb_total_dollars AND iv_pb_total_dollars < 69     => 0.011381,
    69 <= iv_pb_total_dollars AND iv_pb_total_dollars < 281   => 0.118352,
    281 <= iv_pb_total_dollars AND iv_pb_total_dollars < 603  => 0.128363,
    603 <= iv_pb_total_dollars AND iv_pb_total_dollars < 1163 => 0.288057,
    1163 <= iv_pb_total_dollars                               => 0.384968,
                                                                 -0.000000) );

s3_subscore5 := __common__( map(
    c_med_hval != '' and NULL < (Integer)c_med_hval AND (Integer)c_med_hval < 61689		=> -0.209596,
    61689 <= (Integer)c_med_hval AND (Integer)c_med_hval < 90739   										=> -0.170398,
    90739 <= (Integer)c_med_hval AND (Integer)c_med_hval < 109722 										=> -0.141111,
    109722 <= (Integer)c_med_hval AND (Integer)c_med_hval < 153636 										=> 0.005192,
    153636 <= (Integer)c_med_hval AND (Integer)c_med_hval < 213958 										=> 0.072053,
    213958 <= (Integer)c_med_hval AND (Integer)c_med_hval < 360976 										=> 0.125948,
    360976 <= (Integer)c_med_hval                         				 										=> 0.263259,
																																												 -0.000000) );

s3_subscore6 := __common__( map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                       => 0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1']) => -0.152464,
    (iv_nap_phn_ver_x_inf_phn_ver in ['1-3', '2-0', '2-1', '3-1']) => -0.041435,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3', '3-3'])        => 0.109393,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                      => 0.276625,
                                                                      0.000000) );

s3_subscore7 := __common__( map(
    NULL < nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 0 => 0.000000,
    0 <= nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 1   => -0.151000,
    1 <= nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 3   => 0.124570,
    3 <= nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 6   => 0.047615,
    6 <= nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 11  => -0.074340,
    11 <= nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 28 => -0.077595,
    28 <= nf_fp_srchaddrsrchcount                                  => -0.292412,
                                                                      0.000000) );

s3_subscore8 := __common__( map(
    NULL < iv_avg_lres AND iv_avg_lres < 26  => -0.134116,
    26 <= iv_avg_lres AND iv_avg_lres < 57   => -0.037614,
    57 <= iv_avg_lres AND iv_avg_lres < 102  => -0.034724,
    102 <= iv_avg_lres AND iv_avg_lres < 155 => 0.050304,
    155 <= iv_avg_lres AND iv_avg_lres < 225 => 0.125680,
    225 <= iv_avg_lres                       => 0.308742,
                                                -0.000000) );

s3_subscore9 := __common__( map(
    NULL < iv_criminal_count AND iv_criminal_count < 1 => 0.026555,
    1 <= iv_criminal_count AND iv_criminal_count < 4   => -0.091930,
    4 <= iv_criminal_count                             => -0.318202,
                                                          0.000000) );

s3_subscore10 := __common__( map(
    NULL < nf_fp_curraddrmurderindex AND nf_fp_curraddrmurderindex < 0   => 0.000000,
    0 <= nf_fp_curraddrmurderindex AND nf_fp_curraddrmurderindex < 7     => 0.109213,
    7 <= nf_fp_curraddrmurderindex AND nf_fp_curraddrmurderindex < 88    => 0.075509,
    88 <= nf_fp_curraddrmurderindex AND nf_fp_curraddrmurderindex < 119  => 0.009533,
    119 <= nf_fp_curraddrmurderindex AND nf_fp_curraddrmurderindex < 153 => -0.025433,
    153 <= nf_fp_curraddrmurderindex AND nf_fp_curraddrmurderindex < 176 => -0.043633,
    176 <= nf_fp_curraddrmurderindex                                     => -0.159774,
                                                                            0.000000) );

s3_subscore11 := __common__( map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 1         => -0.016852,
    1 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 67768       => -0.096598,
    67768 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 169544  => 0.015686,
    169544 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 280080 => 0.053264,
    280080 <= iv_pv001_inp_avm_autoval                                       => 0.335180,
                                                                                0.000000) );

s3_subscore12 := __common__( map(
    (nf_fp_divrisktype in [' '])           => 0.000000,
    (nf_fp_divrisktype in ['1'])           => 0.101418,
    (nf_fp_divrisktype in ['2'])           => -0.075429,
    (nf_fp_divrisktype in ['3'])           => -0.171350,
    (nf_fp_divrisktype in ['4', '5', '6']) => -0.313068,
    (nf_fp_divrisktype in ['7', '8', '9']) => -0.662796,
                                              0.000000) );

s3_subscore13 := __common__( map(
    NULL < iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 0 => -0.000000,
    0 <= iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 4   => -0.029272,
    4 <= iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 5   => -0.011250,
    5 <= iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 6   => -0.010669,
    6 <= iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 7   => 0.044404,
    7 <= iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 8   => 0.047632,
    8 <= iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 9   => 0.052819,
    9 <= iv_sr001_source_profile_index                                         => 0.056578,
                                                                                  -0.000000) );

s3_subscore14 := __common__( map(
    (nf_fp_varrisktype in [' '])                => 0.000000,
    (nf_fp_varrisktype in ['-1'])               => -0.400332,
    (nf_fp_varrisktype in ['1', '2', '3'])      => 0.049710,
    (nf_fp_varrisktype in ['4', '5'])           => -0.075511,
    (nf_fp_varrisktype in ['6', '7', '8', '9']) => -0.121355,
                                                   0.000000) );

s3_subscore15 := __common__( map(
    (nf_fp_idverrisktype in [' '])                => -0.000000,
    (nf_fp_idverrisktype in ['1'])                => 0.139099,
    (nf_fp_idverrisktype in ['2'])                => 0.113088,
    (nf_fp_idverrisktype in ['3', '4', '5'])      => -0.059948,
    (nf_fp_idverrisktype in ['6', '7', '8', '9']) => -0.556355,
                                                     -0.000000) );

s3_rawscore := __common__( s3_subscore0 +
    s3_subscore1 +
    s3_subscore2 +
    s3_subscore3 +
    s3_subscore4 +
    s3_subscore5 +
    s3_subscore6 +
    s3_subscore7 +
    s3_subscore8 +
    s3_subscore9 +
    s3_subscore10 +
    s3_subscore11 +
    s3_subscore12 +
    s3_subscore13 +
    s3_subscore14 +
    s3_subscore15 );

s3_lnoddsscore := __common__( s3_rawscore + 0.914858 );

s3_probscore := __common__( exp(s3_lnoddsscore) / (1 + exp(s3_lnoddsscore)) );

probscore := __common__( map(
    avon_fp_segment = '0 No SSN'  => s0_probscore,
    avon_fp_segment = '1 NAS 479' => s1_probscore,
    avon_fp_segment = '2 Derog'   => s2_probscore,
                                     s3_probscore) );

base := __common__( 700 );

pts := __common__( 50 );

odds := __common__( (1 - .3645) / .3645 );

fp1401_1_0_8 := __common__( min(if(max(round(pts * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 300) = NULL, -NULL, max(round(pts * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 300)), 999) );

fp1401_1_0_7 := __common__( if(iv_vs001_ssn_deceased = '1', min(if(fp1401_1_0_8 = NULL, -NULL, fp1401_1_0_8), 740), fp1401_1_0_8) );

fp1401_1_0_6 := __common__( if(iv_vs002_ssn_prior_dob = '1', min(if(fp1401_1_0_7 = NULL, -NULL, fp1401_1_0_7), 740), fp1401_1_0_7) );

fp1401_1_0_5 := __common__( if(iv_va040_add_prison_hist = 1, min(if(fp1401_1_0_6 = NULL, -NULL, fp1401_1_0_6), 599), fp1401_1_0_6) );

fp1401_1_0_4 := __common__( if(iv_va003_add_hirisk_comm = '1', min(if(fp1401_1_0_5 = NULL, -NULL, fp1401_1_0_5), 740), fp1401_1_0_5) );

fp1401_1_0_3 := __common__( if(iv_vp004_phn_hirisk = '1', min(if(fp1401_1_0_4 = NULL, -NULL, fp1401_1_0_4), 740), fp1401_1_0_4) );

fp1401_1_0_2 := __common__( if(iv_vs003_ssn_invalid = '1', min(if(fp1401_1_0_3 = NULL, -NULL, fp1401_1_0_3), 740), fp1401_1_0_3) );

fp1401_1_0_1 := __common__( if(iv_va002_add_invalid = '1', min(if(fp1401_1_0_2 = NULL, -NULL, fp1401_1_0_2), 740), fp1401_1_0_2) );

fp1401_1_0 := __common__( if(iv_vp003_phn_invalid = '1', min(if(fp1401_1_0_1 = NULL, -NULL, fp1401_1_0_1), 740), fp1401_1_0_1) );

// #if(FP_DEBUG)
		// /* Model Input Variables */
	// self.clam															:= le;
	// self.sysdate                          := sysdate;
	// self.ssnpop                           := ssnpop;
	// self._derog                           := _derog;
	// self.avon_fp_segment                  := avon_fp_segment;
	// self.iv_vs001_ssn_deceased            := iv_vs001_ssn_deceased;
	// self.iv_vs002_ssn_prior_dob           := iv_vs002_ssn_prior_dob;
	// self.iv_vs003_ssn_invalid             := iv_vs003_ssn_invalid;
	// self.iv_vp003_phn_invalid             := iv_vp003_phn_invalid;
	// self.iv_vp004_phn_hirisk              := iv_vp004_phn_hirisk;
	// self.iv_va001_add_po_box              := iv_va001_add_po_box;
	// self.iv_va002_add_invalid             := iv_va002_add_invalid;
	// self.iv_va003_add_hirisk_comm         := iv_va003_add_hirisk_comm;
	// self.iv_va040_add_prison_hist         := iv_va040_add_prison_hist;
	// self.iv_va060_dist_add_in_bst         := iv_va060_dist_add_in_bst;
	// self.iv_de001_eviction_recency        := iv_de001_eviction_recency;
	// self.bureau_adl_tn_fseen_pos          := bureau_adl_tn_fseen_pos;
	// self.bureau_adl_fseen_tn              := bureau_adl_fseen_tn;
	// self._bureau_adl_fseen_tn             := _bureau_adl_fseen_tn;
	// self.bureau_adl_ts_fseen_pos          := bureau_adl_ts_fseen_pos;
	// self.bureau_adl_fseen_ts              := bureau_adl_fseen_ts;
	// self._bureau_adl_fseen_ts             := _bureau_adl_fseen_ts;
	// self.bureau_adl_tu_fseen_pos          := bureau_adl_tu_fseen_pos;
	// self.bureau_adl_fseen_tu              := bureau_adl_fseen_tu;
	// self._bureau_adl_fseen_tu             := _bureau_adl_fseen_tu;
	// self.bureau_adl_en_fseen_pos          := bureau_adl_en_fseen_pos;
	// self.bureau_adl_fseen_en              := bureau_adl_fseen_en;
	// self._bureau_adl_fseen_en             := _bureau_adl_fseen_en;
	// self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
	// self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
	// self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
	// self.iv_sr001_m_bureau_adl_fs         := iv_sr001_m_bureau_adl_fs;
	// self.bureau_adl_vo_fseen_pos          := bureau_adl_vo_fseen_pos;
	// self.bureau_adl_fseen_vo              := bureau_adl_fseen_vo;
	// self._bureau_adl_fseen_vo             := _bureau_adl_fseen_vo;
	// self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
	// self.mth_ver_src_fdate_vo             := mth_ver_src_fdate_vo;
	// self.bureau_adl_vo_lseen_pos          := bureau_adl_vo_lseen_pos;
	// self.bureau_adl_lseen_vo              := bureau_adl_lseen_vo;
	// self._bureau_adl_lseen_vo             := _bureau_adl_lseen_vo;
	// self.mth_ver_src_ldate_vo             := mth_ver_src_ldate_vo;
	// self.mth_ver_src_fdate_vo60           := mth_ver_src_fdate_vo60;
	// self.mth_ver_src_ldate_vo0            := mth_ver_src_ldate_vo0;
	// self.bureau_adl_w_lseen_pos           := bureau_adl_w_lseen_pos;
	// self.bureau_adl_lseen_w               := bureau_adl_lseen_w;
	// self._bureau_adl_lseen_w              := _bureau_adl_lseen_w;
	// self.mth_ver_src_ldate_w              := mth_ver_src_ldate_w;
	// self.mth_ver_src_ldate_w0             := mth_ver_src_ldate_w0;
	// self.bureau_adl_wp_lseen_pos          := bureau_adl_wp_lseen_pos;
	// self.bureau_adl_lseen_wp              := bureau_adl_lseen_wp;
	// self._bureau_adl_lseen_wp             := _bureau_adl_lseen_wp;
	// self._src_bureau_adl_lseen            := _src_bureau_adl_lseen;
	// self.mth_ver_src_ldate_wp             := mth_ver_src_ldate_wp;
	// self.mth_ver_src_ldate_wp0            := mth_ver_src_ldate_wp0;
	// self._paw_first_seen                  := _paw_first_seen;
	// self.mth_paw_first_seen               := mth_paw_first_seen;
	// self.mth_paw_first_seen2              := mth_paw_first_seen2;
	// self.ver_src_am                       := ver_src_am;
	// self.ver_src_e1                       := ver_src_e1;
	// self.ver_src_e2                       := ver_src_e2;
	// self.ver_src_e3                       := ver_src_e3;
	// self.ver_src_pl                       := ver_src_pl;
	// self.ver_src_w                        := ver_src_w;
	// self.paw_dead_business_count_gt3      := paw_dead_business_count_gt3;
	// self.paw_active_phone_count_0         := paw_active_phone_count_0;
	// self._infutor_first_seen              := _infutor_first_seen;
	// self.mth_infutor_first_seen           := mth_infutor_first_seen;
	// self._infutor_last_seen               := _infutor_last_seen;
	// self.mth_infutor_last_seen            := mth_infutor_last_seen;
	// self.infutor_i                        := infutor_i;
	// self.infutor_im                       := infutor_im;
	// self.white_pages_adl_wp_fseen_pos     := white_pages_adl_wp_fseen_pos;
	// self.white_pages_adl_fseen_wp         := white_pages_adl_fseen_wp;
	// self._white_pages_adl_fseen_wp        := _white_pages_adl_fseen_wp;
	// self._src_white_pages_adl_fseen       := _src_white_pages_adl_fseen;
	// self.iv_sr001_m_wp_adl_fs             := iv_sr001_m_wp_adl_fs;
	// self.src_m_wp_adl_fs                  := src_m_wp_adl_fs;
	// self._header_first_seen               := _header_first_seen;
	// self.iv_sr001_m_hdr_fs                := iv_sr001_m_hdr_fs;
	// self.src_m_hdr_fs                     := src_m_hdr_fs;
	// self.source_mod6                      := source_mod6;
	// self.iv_sr001_source_profile          := iv_sr001_source_profile;
	// self.iv_sr001_source_profile_index    := iv_sr001_source_profile_index;
	// self.iv_pv001_inp_avm_autoval         := iv_pv001_inp_avm_autoval;
	// self.iv_po001_inp_addr_naprop         := iv_po001_inp_addr_naprop;
	// self.iv_ed001_college_ind             := iv_ed001_college_ind;
	// self.iv_inp_own_prop_x_addr_naprop    := iv_inp_own_prop_x_addr_naprop;
	// self.iv_bst_own_prop_x_addr_naprop    := iv_bst_own_prop_x_addr_naprop;
	// self.iv_avg_lres                      := iv_avg_lres;
	// self.iv_ssns_per_addr_c6              := iv_ssns_per_addr_c6;
	// self.iv_inq_communications_recency    := iv_inq_communications_recency;
	// self.iv_inq_highriskcredit_recency    := iv_inq_highriskcredit_recency;
	// self.iv_inq_highriskcredit_count12    := iv_inq_highriskcredit_count12;
	// self.ver_phn_inf                      := ver_phn_inf;
	// self.ver_phn_nap                      := ver_phn_nap;
	// self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
	// self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
	// self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
	// self.iv_rec_vehx_level                := iv_rec_vehx_level;
	// self.iv_criminal_count                := iv_criminal_count;
	// self.iv_criminal_x_felony             := iv_criminal_x_felony;
	// self.iv_pb_total_dollars              := iv_pb_total_dollars;
	// self.iv_pb_total_orders               := iv_pb_total_orders;
	// self.nf_fp_idverrisktype              := nf_fp_idverrisktype;
	// self.nf_fp_varrisktype                := nf_fp_varrisktype;
	// self.nf_fp_srchfraudsrchcount         := nf_fp_srchfraudsrchcount;
	// self.nf_fp_assocsuspicousidcount      := nf_fp_assocsuspicousidcount;
	// self.nf_fp_divrisktype                := nf_fp_divrisktype;
	// self.nf_fp_srchaddrsrchcount          := nf_fp_srchaddrsrchcount;
	// self.nf_fp_srchaddrsrchcountmo        := nf_fp_srchaddrsrchcountmo;
	// self.nf_fp_srchphonesrchcountmo       := nf_fp_srchphonesrchcountmo;
	// self.nf_fp_componentcharrisktype      := nf_fp_componentcharrisktype;
	// self.nf_fp_curraddrmurderindex        := nf_fp_curraddrmurderindex;
	// self.nf_fp_prevaddrcrimeindex         := nf_fp_prevaddrcrimeindex;
	// self.s0_subscore0                     := s0_subscore0;
	// self.s0_subscore1                     := s0_subscore1;
	// self.s0_subscore2                     := s0_subscore2;
	// self.s0_subscore3                     := s0_subscore3;
	// self.s0_subscore4                     := s0_subscore4;
	// self.s0_subscore5                     := s0_subscore5;
	// self.s0_subscore6                     := s0_subscore6;
	// self.s0_subscore7                     := s0_subscore7;
	// self.s0_rawscore                      := s0_rawscore;
	// self.s0_lnoddsscore                   := s0_lnoddsscore;
	// self.s0_probscore                     := s0_probscore;
	// self.s1_subscore0                     := s1_subscore0;
	// self.s1_subscore1                     := s1_subscore1;
	// self.s1_subscore2                     := s1_subscore2;
	// self.s1_subscore3                     := s1_subscore3;
	// self.s1_subscore4                     := s1_subscore4;
	// self.s1_subscore5                     := s1_subscore5;
	// self.s1_subscore6                     := s1_subscore6;
	// self.s1_subscore7                     := s1_subscore7;
	// self.s1_subscore8                     := s1_subscore8;
	// self.s1_subscore9                     := s1_subscore9;
	// self.s1_subscore10                    := s1_subscore10;
	// self.s1_subscore11                    := s1_subscore11;
	// self.s1_rawscore                      := s1_rawscore;
	// self.s1_lnoddsscore                   := s1_lnoddsscore;
	// self.s1_probscore                     := s1_probscore;
	// self.s2_subscore0                     := s2_subscore0;
	// self.s2_subscore1                     := s2_subscore1;
	// self.s2_subscore2                     := s2_subscore2;
	// self.s2_subscore3                     := s2_subscore3;
	// self.s2_subscore4                     := s2_subscore4;
	// self.s2_subscore5                     := s2_subscore5;
	// self.s2_subscore6                     := s2_subscore6;
	// self.s2_subscore7                     := s2_subscore7;
	// self.s2_subscore8                     := s2_subscore8;
	// self.s2_subscore9                     := s2_subscore9;
	// self.s2_subscore10                    := s2_subscore10;
	// self.s2_subscore11                    := s2_subscore11;
	// self.s2_subscore12                    := s2_subscore12;
	// self.s2_subscore13                    := s2_subscore13;
	// self.s2_rawscore                      := s2_rawscore;
	// self.s2_lnoddsscore                   := s2_lnoddsscore;
	// self.s2_probscore                     := s2_probscore;
	// self.s3_subscore0                     := s3_subscore0;
	// self.s3_subscore1                     := s3_subscore1;
	// self.s3_subscore2                     := s3_subscore2;
	// self.s3_subscore3                     := s3_subscore3;
	// self.s3_subscore4                     := s3_subscore4;
	// self.s3_subscore5                     := s3_subscore5;
	// self.s3_subscore6                     := s3_subscore6;
	// self.s3_subscore7                     := s3_subscore7;
	// self.s3_subscore8                     := s3_subscore8;
	// self.s3_subscore9                     := s3_subscore9;
	// self.s3_subscore10                    := s3_subscore10;
	// self.s3_subscore11                    := s3_subscore11;
	// self.s3_subscore12                    := s3_subscore12;
	// self.s3_subscore13                    := s3_subscore13;
	// self.s3_subscore14                    := s3_subscore14;
	// self.s3_subscore15                    := s3_subscore15;
	// self.s3_rawscore                      := s3_rawscore;
	// self.s3_lnoddsscore                   := s3_lnoddsscore;
	// self.s3_probscore                     := s3_probscore;
	// self.probscore                        := probscore;
	// self.base                             := base;
	// self.pts                              := pts;
	// self.odds                             := odds;
	// self.fp1401_1_0												:= fp1401_1_0;
// #end
	self.seq := le.seq;
	ritmp :=  Models.fraudpoint_reasons(le, blank_ip, num_reasons );
	reasons := Models.Common.checkFraudPointRC34(FP1401_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)fp1401_1_0;
	self := [];
END;

model :=   join(clam, Easi.Key_Easi_Census,
	left.shell_input.st<>''
		and left.shell_input.county <>''
		and left.shell_input.geo_blk <> ''
		and keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
	doModel(left, right), left outer,
	atmost(RiskWise.max_atmost)
	,keep(1)
);
	return model;
END;
