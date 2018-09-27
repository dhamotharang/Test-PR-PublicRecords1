//Santander B-Paper Custom Model Refresh

import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVA1305_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE, Boolean isExcepScore = FALSE) := FUNCTION

  RVA_DEBUG := false;

  #if(RVA_DEBUG)
    layout_debug := record
				integer sysdate       ;             
				boolean iv_pots_phone  ;                  
				boolean iv_add_apt    ;                   
				boolean iv_riskview_222s   ;              
				string iv_db001_bankruptcy  ;            
				integer iv_de001_eviction_recency  ;      
				integer bureau_adl_tn_fseen_pos   ;       
				string bureau_adl_fseen_tn       ;       
				integer _bureau_adl_fseen_tn      ;       
				integer bureau_adl_ts_fseen_pos    ;      
				string bureau_adl_fseen_ts       ;       
				integer _bureau_adl_fseen_ts      ;       
				integer bureau_adl_tu_fseen_pos    ;      
				string bureau_adl_fseen_tu        ;      
				integer _bureau_adl_fseen_tu       ;      
				integer bureau_adl_en_fseen_pos    ;      
				string bureau_adl_fseen_en        ;      
				integer _bureau_adl_fseen_en       ;      
				integer bureau_adl_eq_fseen_pos    ;      
				string bureau_adl_fseen_eq        ;      
				integer _bureau_adl_fseen_eq       ;      
				integer _src_bureau_adl_fseen      ;      
				integer iv_sr001_m_bureau_adl_fs   ;      
				integer iv_ms001_ssns_per_adl      ;      
				integer iv_pl002_addrs_15yr        ;      
				integer iv_in001_estimated_income  ;      
				integer lien_adl_li_count_pos      ;      
				integer lien_adl_count_li          ;      
				integer lien_adl_l2_count_pos      ;      
				integer lien_adl_count_l2          ;      
				integer _src_lien_adl_count        ;      
				integer iv_src_liens_adl_count     ;      
				integer iv_inp_addr_address_score  ;      
				integer iv_inp_addr_avm_pct_change_1yr   ;
				integer bst_addr_avm_auto_val_4         ; 
				integer bst_addr_avm_auto_val_1         ; 
				integer iv_bst_addr_avm_pct_change_3yr  ; 
				integer iv_prv_addr_assessed_total_val  ; 
				integer iv_phones_per_sfd_addr_c6       ; 
				integer iv_inq_highriskcredit_count12   ; 
				integer iv_inq_phones_per_adl           ; 
				integer iv_paw_dead_business_count      ; 
				boolean ver_phn_inf                     ; 
				boolean ver_phn_nap                     ; 
				integer inf_phn_ver_lvl                 ; 
				integer nap_phn_ver_lvl                 ; 
				string iv_nap_phn_ver_x_inf_phn_ver    ; 
				integer _impulse_first_seen             ; 
				integer iv_mos_since_impulse_first_seen ; 
				integer iv_email_domain_free_count      ; 
				integer iv_pb_total_dollars             ; 
				integer inp_addr_date_first_seen        ; 
				integer iv_pl001_m_snc_in_addr_fs       ; 
				real t3_subscore0                    ; 
				real t3_subscore1                    ; 
				real t3_subscore2                    ; 
				real t3_subscore3                    ; 
				real t3_subscore4                    ; 
				real t3_subscore5                    ; 
				real t3_subscore6                    ; 
				real t3_subscore7                    ; 
				real t3_subscore8                    ; 
				real t3_subscore9                    ; 
				real t3_subscore10                   ; 
				real t3_subscore11                   ; 
				real t3_subscore12                   ; 
				real t3_subscore13                   ; 
				real t3_subscore14                   ; 
				real t3_subscore15                   ; 
				real t3_subscore16                   ; 
				real t3_subscore17                   ; 
				real t3_subscore18                   ; 
				real t3_rawscore                     ; 
				real t3_lnoddsscore                  ; 
				real t3_probscore                    ; 
				integer base                         ;    
				integer point                        ;    
				real odds  		                       ;    
				integer rva1305_1_0                  ;    
				boolean glrc9h                       ;    
				boolean glrc25                       ;    
				boolean glrc9d                        ;   
				boolean glrcev                       ;    
				boolean glrc98                       ;    
				boolean glrc36                       ;    
				boolean glrc9w                       ;    
				boolean glrc9y                       ;    
				boolean glrcms                       ;    
				boolean glrc9q                       ;    
				boolean glrc9c                       ;    
				boolean glrc9p                       ;    
				boolean glrc9r                       ;    
				boolean glrcpv                       ;    
				boolean glrcbl                       ;    
				real rcvalue9h_1                     ; 
				real rcvalue9h                       ; 
				real rcvalue25_1                     ; 
				real rcvalue25                       ; 
				real rcvalue9d_1                     ; 
				real rcvalue9d                       ; 
				real rcvalueev_1                     ; 
				real rcvalueev                       ; 
				real rcvalue98_1                     ; 
				real rcvalue98                       ; 
				real rcvalue36_1                     ; 
				real rcvalue36                       ; 
				real rcvalue9w_1                     ; 
				real rcvalue9w                       ; 
				real rcvalue9y_1                     ; 
				real rcvalue9y                       ; 
				real rcvaluems_1                     ; 
				real rcvaluems                       ; 
				real rcvalue9q_1                     ; 
				real rcvalue9q                       ; 
				real rcvalue9c_1                     ; 
				real rcvalue9c                       ; 
				real rcvalue9p_1                     ; 
				real rcvalue9p                       ; 
				real rcvalue9r_1                     ; 
				real rcvalue9r                       ; 
				real rcvaluepv_1                     ; 
				real rcvaluepv_2                     ; 
				real rcvaluepv                       ; 
				real rcvaluebl_1                     ; 
				real rcvaluebl_2                     ; 
				real rcvaluebl_3                     ; 
				real rcvaluebl_4                     ; 
				real rcvaluebl                       ; 
				string rc1                           ;   
				string rc2                           ;   
				string rc3                           ;   
				string rc4                           ;   
				string rc5                           ;   
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
			rc_decsflag                      := le.iid.decsflag;
			rc_dwelltype                     := le.iid.dwelltype;
			rc_bansflag                      := le.iid.bansflag;
			combo_dobscore                   := le.iid.combo_dobscore;
			ver_sources                      := le.header_summary.ver_sources;
			ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
			ver_sources_count                := le.header_summary.ver_sources_recordcount;
			addrpop                          := le.input_validation.address;
			ssnlength                        := le.input_validation.ssn_length;
			hphnpop                          := le.input_validation.homephone;
			add1_address_score               := le.address_verification.input_address_information.address_score;
			add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
			add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
			add1_avm_automated_valuation_2   := le.avm.input_address_information.avm_automated_valuation2;
			add1_avm_automated_valuation_4   := le.avm.input_address_information.avm_automated_valuation4;
			add1_naprop                      := le.address_verification.input_address_information.naprop;
			add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
			add1_pop                         := le.addrpop;
			property_owned_total             := le.address_verification.owned.property_total;
			property_sold_total              := le.address_verification.sold.property_total;
			add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
			add2_avm_automated_valuation_4   := le.avm.address_history_1.avm_automated_valuation4;
			add2_assessed_total_value        := le.address_verification.address_history_1.assessed_total_value;
			add3_assessed_total_value        := le.address_verification.address_history_2.assessed_total_value;
			addrs_15yr                       := le.other_address_info.addrs_last_15years;
			telcordia_type                   := le.phone_verification.telcordia_type;
			ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
			phones_per_addr_c6               := le.velocity_counters.phones_per_addr_created_6months;
			inq_count12                      := le.acc_logs.inquiries.count12;
			inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
			inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
			pb_total_dollars                 := le.ibehavior.total_dollars;
			paw_dead_business_count          := le.employment.dead_business_ct;
			infutor_nap                      := le.infutor_phone.infutor_nap;
			impulse_count                    := le.impulse.count;
			impulse_first_seen               := le.impulse.first_seen_date;
			email_domain_free_count          := le.email_summary.email_domain_free_ct;
			attr_addrs_last36                := le.other_address_info.addrs_last36;
			attr_eviction_count              := le.bjl.eviction_count;
			attr_eviction_count90            := le.bjl.eviction_count90;
			attr_eviction_count180           := le.bjl.eviction_count180;
			attr_eviction_count12            := le.bjl.eviction_count12;
			attr_eviction_count24            := le.bjl.eviction_count24;
			attr_eviction_count36            := le.bjl.eviction_count36;
			attr_eviction_count60            := le.bjl.eviction_count60;
			bankrupt                         := le.bjl.bankrupt;
			disposition                      := le.bjl.disposition;
			filing_count                     := le.bjl.filing_count;
			bk_recent_count                  := le.bjl.bk_recent_count;
			liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
			liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
			liens_recent_released_count      := le.bjl.liens_recent_released_count;
			liens_historical_released_count  := le.bjl.liens_historical_released_count;
			criminal_count                   := le.bjl.criminal_count;
			estimated_income                 := le.estimated_income;
			archive_date                     := le.historydate;

	NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

// sysdate := common.sas_date((string)(archive_date));

iv_pots_phone := (telcordia_type in ['00', '50', '51', '52', '54']);

iv_add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

iv_db001_bankruptcy := map(
    not(truedid or (integer)ssnlength > 0)                    => '                 ',
    (disposition in ['Discharge NA', 'Discharged'])           => '1 - BK Discharged',
    (disposition in ['Dismissed'])                            => '2 - BK Dismissed ',
    (rc_bansflag in ['1', '2']) 
		or bankrupt 
		or contains_i(ver_sources, 'BA') > 0 
		or filing_count > 0 
		or bk_recent_count > 0 																		=> '3 - BK Other     ',
																																 '0 - No BK        ');

iv_de001_eviction_recency := map(
    not(truedid)                                                => NULL,
    attr_eviction_count90  > 0                                       => 3,
    attr_eviction_count180 > 0                                      => 6,
    attr_eviction_count12 > 0                                       => 12,
    (boolean)attr_eviction_count24 and attr_eviction_count >= 2 => 24,
    attr_eviction_count24  > 0                                      => 25,
    (boolean)attr_eviction_count36 and attr_eviction_count >= 2 => 36,
    attr_eviction_count36 > 0                                       => 37,
    (boolean)attr_eviction_count60 and attr_eviction_count >= 2 => 60,
    attr_eviction_count60 > 0                                       => 61,
    attr_eviction_count >= 2                                    => 98,
    attr_eviction_count >= 1                                    => 99,
                                                                   0);

bureau_adl_tn_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E');

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

_src_bureau_adl_fseen := min(if(_bureau_adl_fseen_tn = NULL, -NULL, _bureau_adl_fseen_tn), if(_bureau_adl_fseen_ts = NULL, -NULL, _bureau_adl_fseen_ts), if(_bureau_adl_fseen_tu = NULL, -NULL, _bureau_adl_fseen_tu), if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

iv_sr001_m_bureau_adl_fs := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => -1,
                                      if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))));

iv_ms001_ssns_per_adl := map(
    not(truedid)     => NULL,
    ssns_per_adl = 0 => 1,
                        ssns_per_adl);

iv_pl002_addrs_15yr := if(not(truedid), NULL, addrs_15yr);

iv_in001_estimated_income := if(not(truedid), NULL, estimated_income);

lien_adl_li_count_pos := Models.Common.findw_cpp(ver_sources, 'LI' , ', ', 'E');

lien_adl_count_li := if(lien_adl_li_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, lien_adl_li_count_pos, ','));

lien_adl_l2_count_pos := Models.Common.findw_cpp(ver_sources, 'L2' , ', ', 'E');

lien_adl_count_l2 := if(lien_adl_l2_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, lien_adl_l2_count_pos, ','));

_src_lien_adl_count := max(lien_adl_count_li, lien_adl_count_l2, (real)0);

iv_src_liens_adl_count := map(
    not(truedid)               => NULL,
    _src_lien_adl_count = NULL => -1,
                                  _src_lien_adl_count);

iv_inp_addr_address_score := if(not(add1_pop and truedid), NULL, add1_address_score);

iv_inp_addr_avm_pct_change_1yr := map(
    not(add1_pop)                                                           => NULL,
    add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_2 > 0 => add1_avm_automated_valuation / add1_avm_automated_valuation_2,
                                                                               NULL);

bst_addr_avm_auto_val_4 := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation_4,
                        add2_avm_automated_valuation_4);

iv_bst_addr_avm_pct_change_3yr_1 := map(
    not(truedid)     => NULL,
    add1_isbestmatch => NULL,
                        NULL);

bst_addr_avm_auto_val_1 := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

iv_bst_addr_avm_pct_change_3yr := if(bst_addr_avm_auto_val_1 > 0 and bst_addr_avm_auto_val_4 > 0, bst_addr_avm_auto_val_1 / bst_addr_avm_auto_val_4, NULL);

iv_prv_addr_assessed_total_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add2_assessed_total_value,
                        add3_assessed_total_value);

iv_phones_per_sfd_addr_c6 := map(
    not(add1_pop)    => NULL,
    iv_add_apt       => -1,
                        phones_per_addr_c6);

iv_inq_highriskcredit_count12 := if(not(truedid), NULL, inq_highRiskCredit_count12);

iv_inq_phones_per_adl := if(not(truedid), NULL, inq_phonesperadl);

iv_paw_dead_business_count := if(not(truedid), NULL, paw_dead_business_count);

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
     trim((string)nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)inf_phn_ver_lvl, LEFT, RIGHT));

_impulse_first_seen := common.sas_date((string)(impulse_first_seen));


iv_mos_since_impulse_first_seen := map( 
    not(truedid)                    => NULL,
    not(_impulse_first_seen = NULL) => if ((sysdate - _impulse_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _impulse_first_seen) / (365.25 / 12)), roundup((sysdate - _impulse_first_seen) / (365.25 / 12))),
                                       -1);

iv_email_domain_free_count := if(not(truedid), NULL, email_domain_free_count);

iv_pb_total_dollars := map(
    not(truedid)            							=> NULL,
    pb_total_dollars = '' 								=> -1,
																					(integer)pb_total_dollars);

inp_addr_date_first_seen := common.sas_date((string)(add1_date_first_seen));

iv_pl001_m_snc_in_addr_fs := map(
    not(add1_pop)                   => NULL,
    inp_addr_date_first_seen = NULL => -1,
                                       if ((sysdate - inp_addr_date_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - inp_addr_date_first_seen) / (365.25 / 12)), roundup((sysdate - inp_addr_date_first_seen) / (365.25 / 12))));

t3_subscore0 := map(
    NULL < iv_mos_since_impulse_first_seen AND iv_mos_since_impulse_first_seen < 0 => 0.038312,
    0 <= iv_mos_since_impulse_first_seen AND iv_mos_since_impulse_first_seen < 6   => -0.622695,
    6 <= iv_mos_since_impulse_first_seen                                           => -0.333395,
                                                                                      -0.000000);

t3_subscore1 := map(
    NULL < iv_inp_addr_address_score AND iv_inp_addr_address_score < 12 => -0.416819,
    12 <= iv_inp_addr_address_score AND iv_inp_addr_address_score < 20  => -0.209734,
    20 <= iv_inp_addr_address_score AND iv_inp_addr_address_score < 60  => -0.134381,
    60 <= iv_inp_addr_address_score AND iv_inp_addr_address_score < 255 => 0.072313,
    255 <= iv_inp_addr_address_score                                    => 0.000000,
                                                                           0.000000);

t3_subscore2 := map(
    NULL < iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 2 => 0.288497,
    2 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 5   => 0.083003,
    5 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 7   => -0.004667,
    7 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 17  => -0.068464,
    17 <= iv_pl002_addrs_15yr                              => -0.398982,
                                                              0.000000);

t3_subscore3 := map(
    NULL < iv_de001_eviction_recency AND iv_de001_eviction_recency < 3 => 0.039093,
    3 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 12  => -0.583093,
    12 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 25 => -0.284492,
    25 <= iv_de001_eviction_recency                                    => -0.083238,
                                                                          0.000000);

t3_subscore4 := map(
    0 <= iv_src_liens_adl_count AND iv_src_liens_adl_count < 1 => 0.072149,
    1 <= iv_src_liens_adl_count AND iv_src_liens_adl_count < 5 => -0.126480,
    5 <= iv_src_liens_adl_count                                => -0.527184,
                                                                  -0.000000);

t3_subscore5 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                              => 0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1', '1-3']) => -0.077960,
    (iv_nap_phn_ver_x_inf_phn_ver in ['2-0', '2-1', '2-3', '3-1', '3-3']) => -0.006949,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3'])                             => 0.172481,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                             => 0.264339,
                                                                             0.000000);

t3_subscore6 := map(
    (iv_db001_bankruptcy in ['1 - BK Discharged']) => 0.235294,
    (iv_db001_bankruptcy in ['0 - No BK'])         => -0.014930,
    (iv_db001_bankruptcy in ['3 - BK Other'])      => -0.157237,
    (iv_db001_bankruptcy in ['2 - BK Dismissed'])  => -0.250028,
                                                      -0.000000);

t3_subscore7 := map(
    NULL < iv_pb_total_dollars AND iv_pb_total_dollars < 92 => -0.049405,
    92 <= iv_pb_total_dollars AND iv_pb_total_dollars < 254 => 0.144556,
    254 <= iv_pb_total_dollars                              => 0.172539,
                                                               -0.000000);

t3_subscore8 := map(
    NULL < iv_email_domain_free_count AND iv_email_domain_free_count < 1 => 0.072811,
    1 <= iv_email_domain_free_count AND iv_email_domain_free_count < 2   => -0.037966,
    2 <= iv_email_domain_free_count                                      => -0.118843,
                                                                            -0.000000);

t3_subscore9 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 0.048554,
    2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -0.068681,
    3 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 4   => -0.109100,
    4 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 5   => -0.170492,
    5 <= iv_ms001_ssns_per_adl                                 => -0.312776,
                                                                  0.000000);

t3_subscore10 := map(
    NULL < iv_inp_addr_avm_pct_change_1yr AND iv_inp_addr_avm_pct_change_1yr < 0.92 => -0.080609,
    0.92 <= iv_inp_addr_avm_pct_change_1yr                                          => 0.137134,
                                                                                       -0.000000);

t3_subscore11 := map(
    NULL < iv_inq_phones_per_adl AND iv_inq_phones_per_adl < 1 => 0.056689,
    1 <= iv_inq_phones_per_adl AND iv_inq_phones_per_adl < 2   => -0.088464,
    2 <= iv_inq_phones_per_adl                                 => -0.122417,
                                                                  0.000000);

t3_subscore12 := map(
    NULL < iv_prv_addr_assessed_total_val AND iv_prv_addr_assessed_total_val < 1  => -0.003261,
    1 <= iv_prv_addr_assessed_total_val AND iv_prv_addr_assessed_total_val < 5680 => -0.453855,
    5680 <= iv_prv_addr_assessed_total_val                                        => 0.026539,
                                                                                     0.000000);

t3_subscore13 := map(
    NULL < iv_phones_per_sfd_addr_c6 AND iv_phones_per_sfd_addr_c6 < 0 => 0.074183,
    0 <= iv_phones_per_sfd_addr_c6 AND iv_phones_per_sfd_addr_c6 < 1   => -0.002903,
    1 <= iv_phones_per_sfd_addr_c6                                     => -0.179175,
                                                                          0.000000);

t3_subscore14 := map(
    NULL < iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 1 => 0.024205,
    1 <= iv_inq_highriskcredit_count12                                         => -0.194493,
                                                                                  -0.000000);

t3_subscore15 := map(
    NULL < iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 265 => -0.029815,
    265 <= iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs < 296 => 0.096294,
    296 <= iv_sr001_m_bureau_adl_fs                                    => 0.188715,
                                                                          0.000000);

t3_subscore16 := map(
    NULL < iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr < 0.34  => -0.288351,
    0.34 <= iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr < 0.42 => -0.061783,
    0.42 <= iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr < 1.05 => 0.000561,
    1.05 <= iv_bst_addr_avm_pct_change_3yr                                           => 0.227559,
                                                                                        0.000000);

t3_subscore17 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income < 20000   => -0.278748,
    20000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 26000 => -0.041827,
    26000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 33000 => 0.007817,
    33000 <= iv_in001_estimated_income                                       => 0.048138,
                                                                                0.000000);

t3_subscore18 := map(
    NULL < iv_paw_dead_business_count AND iv_paw_dead_business_count < 1 => 0.011711,
    1 <= iv_paw_dead_business_count                                      => -0.187235,
                                                                            0.000000);

t3_rawscore := t3_subscore0 +
    t3_subscore1 +
    t3_subscore2 +
    t3_subscore3 +
    t3_subscore4 +
    t3_subscore5 +
    t3_subscore6 +
    t3_subscore7 +
    t3_subscore8 +
    t3_subscore9 +
    t3_subscore10 +
    t3_subscore11 +
    t3_subscore12 +
    t3_subscore13 +
    t3_subscore14 +
    t3_subscore15 +
    t3_subscore16 +
    t3_subscore17 +
    t3_subscore18;

t3_lnoddsscore := t3_rawscore + 1.233129;

t3_probscore := exp(t3_lnoddsscore) / (1 + exp(t3_lnoddsscore));

base := 680;

point := 60;

odds := (1 - 0.224) / 0.224;

rva1305_1_0 := map(
    rc_decsflag = '1'  => 200,
    iv_riskview_222s 		=> 222,
                        max(min(if(round(point * (ln(t3_probscore / (1 - t3_probscore)) - ln(odds)) / ln(2) + base) = NULL, -NULL, round(point * (ln(t3_probscore / (1 - t3_probscore)) - ln(odds)) / ln(2) + base)), 900), 501));

rc5_3 := '';

glrc9h := impulse_count > 0;

glrc25 := addrpop;

glrc9d := attr_addrs_last36 > 0;

glrcev := attr_eviction_count > 0;

glrc98 := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0 or liens_recent_released_count > 0 or liens_historical_released_count > 0;

glrc36 := 1;

glrc9w := filing_count > 0;

glrc9y := truedid and trim(pb_total_dollars) = '';

glrcms := ssns_per_adl > 1;

glrc9q := inq_count12 > 0;

glrc9c := not(iv_add_apt) and iv_pl001_m_snc_in_addr_fs < 6;

glrc9p := inq_count12 > 0;

glrc9r := truedid;

glrcpv :=  add1_avm_automated_valuation >= 1 AND add1_avm_automated_valuation <= 75000;

glrcbl := 0;

rcvalue9h_1 := 0.038312 - t3_subscore0;

rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

rcvalue25_1 := 0.072313 - t3_subscore1;

rcvalue25 := (integer)glrc25 * if(max(rcvalue25_1) = NULL, NULL, sum(if(rcvalue25_1 = NULL, 0, rcvalue25_1)));

rcvalue9d_1 := 0.288497 - t3_subscore2;

rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

rcvalueev_1 := 0.039093 - t3_subscore3;

rcvalueev := (integer)glrcev * if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

rcvalue98_1 := 0.072149 - t3_subscore4;

rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));

rcvalue36_1 := 0.264339 - t3_subscore5;

rcvalue36 := glrc36 * if(max(rcvalue36_1) = NULL, NULL, sum(if(rcvalue36_1 = NULL, 0, rcvalue36_1)));

rcvalue9w_1 := 0.235294 - t3_subscore6;

rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1)));

rcvalue9y_1 := 0.172539 - t3_subscore7;

// rcvalue9y := (integer)glrc9y * if(max(rcvalue9y_1) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1)));
rcvalue9y := 0;

rcvaluems_1 := 0.048554 - t3_subscore9;

rcvaluems := (integer)glrcms * if(max(rcvaluems_1) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1)));

rcvalue9q_1 := 0.056689 - t3_subscore11;

rcvalue9q := (integer)glrc9q * if(max(rcvalue9q_1) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1)));

rcvalue9c_1 := 0.074183 - t3_subscore13;

rcvalue9c := (integer)glrc9c * if(max(rcvalue9c_1) = NULL, NULL, sum(if(rcvalue9c_1 = NULL, 0, rcvalue9c_1)));

rcvalue9p_1 := 0.024205 - t3_subscore14;

rcvalue9p := (integer)glrc9p * if(max(rcvalue9p_1) = NULL, NULL, sum(if(rcvalue9p_1 = NULL, 0, rcvalue9p_1)));

rcvalue9r_1 := 0.188715 - t3_subscore15;

rcvalue9r := (integer)glrc9r * if(max(rcvalue9r_1) = NULL, NULL, sum(if(rcvalue9r_1 = NULL, 0, rcvalue9r_1)));

rcvaluepv_1 := if(add1_avm_automated_valuation_2 > 0, 0.137134 - t3_subscore10, 0);

rcvaluepv_2 := if(add1_avm_automated_valuation_4 > 0, 0.227559 - t3_subscore16, 0);

rcvaluepv := (integer)glrcpv * if(max(rcvaluepv_1, rcvaluepv_2) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1), if(rcvaluepv_2 = NULL, 0, rcvaluepv_2))) * 0.5;

rcvaluebl_1 := 0.072811 - t3_subscore8;

rcvaluebl_2 := 0.026539 - t3_subscore12;

rcvaluebl_3 := 0.048138 - t3_subscore17;

rcvaluebl_4 := 0.011711 - t3_subscore18;

rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3, rcvaluebl_4) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3), if(rcvaluebl_4 = NULL, 0, rcvaluebl_4)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};

rc_dataset := DATASET([
    {'9H', RCValue9H},
    {'25', RCValue25},
    {'9D', RCValue9D},
    {'EV', RCValueEV},
    {'98', RCValue98},
    {'36', RCValue36},
    {'9W', RCValue9W},
    {'9Y', RCValue9Y},
    {'MS', RCValueMS},
    {'9Q', RCValue9Q},
    {'9C', RCValue9C},
    {'9P', RCValue9P},
    {'9R', RCValue9R},
    {'PV', RCValuePV},
    {'BL', RCValueBL}
    ], ds_layout) (value>0);

rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes


	rcs_9p1 := rcs_top4[1];
	rcs_9p2 := IF(rcs_top4[2].rc = '' and rcs_top4[1].rc not in ['', '36'] , 		//If only one reason code is set and it's not '36', set RC2 to '36'
								ROW({'36', NULL}, ds_layout), 
								rcs_top4[2]);
	rcs_9p3 := rcs_top4[3];
	rcs_9p4 := rcs_top4[4];
	rcs_9p5 := IF(glrc9q and rcvalue9q > 0 AND NOT EXISTS(rcs_top4 (rc in ['9Q', '9P'])),  	// Check to see if RC 9Q is a part of the score, but not in the first 4 RC's
								ROW({'9Q', NULL}, ds_layout)); 
	
	rcs_9p := rcs_9p1 & rcs_9p2 & rcs_9p3 & rcs_9p4 & rcs_9p5;;


	rcs_override := MAP(
											rva1305_1_0 = 200 							=> DATASET([{'02', NULL}], ds_layout),
											rva1305_1_0 = 222 							=> DATASET([{'9X', NULL}], ds_layout),
											rva1305_1_0 = 900 							=> DATASET([{'  ', NULL}], ds_layout),
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
					
	zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
	
	reasons := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes


//Intermediate variables
	#if(RVA_DEBUG)
				self.clam															:= le;
				self.sysdate                          := sysdate;
				self.iv_pots_phone                    := iv_pots_phone;
				self.iv_add_apt                       := iv_add_apt;
				self.iv_riskview_222s                 := iv_riskview_222s;
				self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
				self.iv_de001_eviction_recency        := iv_de001_eviction_recency;
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
				self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
				self.iv_sr001_m_bureau_adl_fs         := iv_sr001_m_bureau_adl_fs;
				self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;
				self.iv_pl002_addrs_15yr              := iv_pl002_addrs_15yr;
				self.iv_in001_estimated_income        := iv_in001_estimated_income;
				self.lien_adl_li_count_pos            := lien_adl_li_count_pos;
				self.lien_adl_count_li                := lien_adl_count_li;
				self.lien_adl_l2_count_pos            := lien_adl_l2_count_pos;
				self.lien_adl_count_l2                := lien_adl_count_l2;
				self._src_lien_adl_count              := _src_lien_adl_count;
				self.iv_src_liens_adl_count           := iv_src_liens_adl_count;
				self.iv_inp_addr_address_score        := iv_inp_addr_address_score;
				self.iv_inp_addr_avm_pct_change_1yr   := iv_inp_addr_avm_pct_change_1yr;
				self.bst_addr_avm_auto_val_4          := bst_addr_avm_auto_val_4;
				self.bst_addr_avm_auto_val_1          := bst_addr_avm_auto_val_1;
				self.iv_bst_addr_avm_pct_change_3yr   := iv_bst_addr_avm_pct_change_3yr;
				self.iv_prv_addr_assessed_total_val   := iv_prv_addr_assessed_total_val;
				self.iv_phones_per_sfd_addr_c6        := iv_phones_per_sfd_addr_c6;
				self.iv_inq_highriskcredit_count12    := iv_inq_highriskcredit_count12;
				self.iv_inq_phones_per_adl            := iv_inq_phones_per_adl;
				self.iv_paw_dead_business_count       := iv_paw_dead_business_count;
				self.ver_phn_inf                      := ver_phn_inf;
				self.ver_phn_nap                      := ver_phn_nap;
				self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
				self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
				self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
				self._impulse_first_seen              := _impulse_first_seen;
				self.iv_mos_since_impulse_first_seen  := iv_mos_since_impulse_first_seen;
				self.iv_email_domain_free_count       := iv_email_domain_free_count;
				self.iv_pb_total_dollars              := iv_pb_total_dollars;
				self.inp_addr_date_first_seen         := inp_addr_date_first_seen;
				self.iv_pl001_m_snc_in_addr_fs        := iv_pl001_m_snc_in_addr_fs;
				self.t3_subscore0                     := t3_subscore0;
				self.t3_subscore1                     := t3_subscore1;
				self.t3_subscore2                     := t3_subscore2;
				self.t3_subscore3                     := t3_subscore3;
				self.t3_subscore4                     := t3_subscore4;
				self.t3_subscore5                     := t3_subscore5;
				self.t3_subscore6                     := t3_subscore6;
				self.t3_subscore7                     := t3_subscore7;
				self.t3_subscore8                     := t3_subscore8;
				self.t3_subscore9                     := t3_subscore9;
				self.t3_subscore10                    := t3_subscore10;
				self.t3_subscore11                    := t3_subscore11;
				self.t3_subscore12                    := t3_subscore12;
				self.t3_subscore13                    := t3_subscore13;
				self.t3_subscore14                    := t3_subscore14;
				self.t3_subscore15                    := t3_subscore15;
				self.t3_subscore16                    := t3_subscore16;
				self.t3_subscore17                    := t3_subscore17;
				self.t3_subscore18                    := t3_subscore18;
				self.t3_rawscore                      := t3_rawscore;
				self.t3_lnoddsscore                   := t3_lnoddsscore;
				self.t3_probscore                     := t3_probscore;
				self.base                             := base;
				self.point                            := point;
				self.odds                             := odds;
				self.rva1305_1_0                      := rva1305_1_0;
				self.glrc9h                           := glrc9h;
				self.glrc25                           := glrc25;
				self.glrc9d                           := glrc9d;
				self.glrcev                           := glrcev;
				self.glrc98                           := glrc98;
				self.glrc36                           := glrc36;
				self.glrc9w                           := glrc9w;
				self.glrc9y                           := glrc9y;
				self.glrcms                           := glrcms;
				self.glrc9q                           := glrc9q;
				self.glrc9c                           := glrc9c;
				self.glrc9p                           := glrc9p;
				self.glrc9r                           := glrc9r;
				self.glrcpv                           := glrcpv;
				self.glrcbl                           := glrcbl;
				self.rcvalue9h_1                      := rcvalue9h_1;
				self.rcvalue9h                        := rcvalue9h;
				self.rcvalue25_1                      := rcvalue25_1;
				self.rcvalue25                        := rcvalue25;
				self.rcvalue9d_1                      := rcvalue9d_1;
				self.rcvalue9d                        := rcvalue9d;
				self.rcvalueev_1                      := rcvalueev_1;
				self.rcvalueev                        := rcvalueev;
				self.rcvalue98_1                      := rcvalue98_1;
				self.rcvalue98                        := rcvalue98;
				self.rcvalue36_1                      := rcvalue36_1;
				self.rcvalue36                        := rcvalue36;
				self.rcvalue9w_1                      := rcvalue9w_1;
				self.rcvalue9w                        := rcvalue9w;
				self.rcvalue9y_1                      := rcvalue9y_1;
				self.rcvalue9y                        := rcvalue9y;
				self.rcvaluems_1                      := rcvaluems_1;
				self.rcvaluems                        := rcvaluems;
				self.rcvalue9q_1                      := rcvalue9q_1;
				self.rcvalue9q                        := rcvalue9q;
				self.rcvalue9c_1                      := rcvalue9c_1;
				self.rcvalue9c                        := rcvalue9c;
				self.rcvalue9p_1                      := rcvalue9p_1;
				self.rcvalue9p                        := rcvalue9p;
				self.rcvalue9r_1                      := rcvalue9r_1;
				self.rcvalue9r                        := rcvalue9r;
				self.rcvaluepv_1                      := rcvaluepv_1;
				self.rcvaluepv_2                      := rcvaluepv_2;
				self.rcvaluepv                        := rcvaluepv;
				self.rcvaluebl_1                      := rcvaluebl_1;
				self.rcvaluebl_2                      := rcvaluebl_2;
				self.rcvaluebl_3                      := rcvaluebl_3;
				self.rcvaluebl_4                      := rcvaluebl_4;
				self.rcvaluebl                        := rcvaluebl;
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
											reasons[1].hri IN ['92','93','94'] and isExcepScore			=> (string3)RVA1305_1_0,
											reasons[1].hri IN ['91','92','93','94'] 								=> (STRING3)((INTEGER)reasons[1].hri + 10),
											reasons[1].hri='35' 																		=> '100',
																																									(string3)RVA1305_1_0
										);
END;

		model := project( clam, doModel(left) );


		return model;
		

END;