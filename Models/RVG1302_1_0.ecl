//Progressive Finance Custom Score

import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVG1302_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVG_DEBUG := false;

  #if(RVG_DEBUG)
    layout_debug := record
			integer sysdate                          ; // sysdate;
			boolean iv_pots_phone                    ; // iv_pots_phone;
			boolean iv_add_apt                       ; // iv_add_apt;
			boolean iv_riskview_222s                 ; // iv_riskview_222s;
			string  iv_db001_bankruptcy              ; // iv_db001_bankruptcy;
			integer iv_de001_eviction_recency        ; // iv_de001_eviction_recency;
			boolean email_src_im                     ; // email_src_im;
			integer iv_ds001_impulse_count           ; // iv_ds001_impulse_count;
			integer iv_ms001_ssns_per_adl            ; // iv_ms001_ssns_per_adl;
			integer _in_dob                          ; // _in_dob;
			real    yr_in_dob                        ; // yr_in_dob;
			integer yr_in_dob_int                    ; // yr_in_dob_int;
			integer age_estimate                     ; // age_estimate;
			integer iv_ag001_age                     ; // iv_ag001_age;
			integer iv_addrs_5yr                     ; // iv_addrs_5yr;
			integer iv_hist_addr_match               ; // iv_hist_addr_match;
			integer iv_max_ids_per_sfd_addr          ; // iv_max_ids_per_sfd_addr;
			integer iv_inq_recency                   ; // iv_inq_recency;
			integer iv_inq_highriskcredit_count12    ; // iv_inq_highriskcredit_count12;
			integer iv_paw_active_phone_count        ; // iv_paw_active_phone_count;
			boolean ver_phn_inf                      ; // ver_phn_inf;
			boolean ver_phn_nap                      ; // ver_phn_nap;
			integer inf_phn_ver_lvl                  ; // inf_phn_ver_lvl;
			integer nap_phn_ver_lvl                  ; // nap_phn_ver_lvl;
			string  iv_nap_phn_ver_x_inf_phn_ver     ; // iv_nap_phn_ver_x_inf_phn_ver;
			integer iv_email_domain_free_count       ; // iv_email_domain_free_count;
			integer iv_attr_purchase_recency         ; // iv_attr_purchase_recency;
			integer iv_derog_diff                    ; // iv_derog_diff;
			integer iv_felony_count                  ; // iv_felony_count;
			string  iv_ams_college_code              ; // iv_ams_college_code;
			integer iv_pb_total_dollars              ; // iv_pb_total_dollars;
			real    a_subscore0                      ; // a_subscore0;
			real    a_subscore1                      ; // a_subscore1;
			real    a_subscore2                      ; // a_subscore2;
			real    a_subscore3                      ; // a_subscore3;
			real    a_subscore4                      ; // a_subscore4;
			real    a_subscore5                      ; // a_subscore5;
			real    a_subscore6                      ; // a_subscore6;
			real    a_subscore7                      ; // a_subscore7;
			real    a_subscore8                      ; // a_subscore8;
			real    a_subscore9                      ; // a_subscore9;
			real    a_subscore10                     ; // a_subscore10;
			real    a_subscore11                     ; // a_subscore11;
			real    a_subscore12                     ; // a_subscore12;
			real    a_subscore13                     ; // a_subscore13;
			real    a_subscore14                     ; // a_subscore14;
			real    a_subscore15                     ; // a_subscore15;
			real    a_subscore16                     ; // a_subscore16;
			real    a_subscore17                     ; // a_subscore17;
			real    a_rawscore                       ; // a_rawscore;
			real    a_lnoddsscore                      ; // a_lnoddsscore;
			real    a_probscore                      ; // a_probscore;
			integer base                             ; // base;
			integer point                             ; // point;
			real    odds                             ; // odds;
			integer rvg1302_1_0                      ; // rvg1302_1_0;
			boolean glrc9w                           ; // glrc9w;
			boolean glrc97                           ; // glrc97;
			integer glrc36                           ; // glrc36;
			boolean glrcev                           ; // glrcev;
			boolean glrc9h                           ; // glrc9h;
			boolean glrcms                           ; // glrcms;
			boolean glrc9g                           ; // glrc9g;
			boolean glrc9d                           ; // glrc9d;
			boolean glrc99                           ; // glrc99;
			boolean glrc9k                           ; // glrc9k;
			boolean glrc9q                           ; // glrc9q;
			boolean glrc9p                           ; // glrc9p;
			boolean glrc98                           ; // glrc98;
			boolean glrc9i                           ; // glrc9i;
			boolean glrc9y                           ; // glrc9y;
			integer glrcbl                           ; // glrcbl;
			boolean bk_flag                          ; // bk_flag;
			boolean crim_flag                        ; // crim_flag;
			boolean lien_flag                        ; // lien_flag;
			real    rcvalue9h_1                      ; // rcvalue9h_1;
			real    rcvalue9h                        ; // rcvalue9h;
			real    rcvaluems_1                      ; // rcvaluems_1;
			real    rcvaluems                        ; // rcvaluems;
			real    rcvalue36_1                      ; // rcvalue36_1;
			real    rcvalue36                        ; // rcvalue36;
			real    rcvalueev_1                      ; // rcvalueev_1;
			real    rcvalueev                        ; // rcvalueev;
			real    rcvalue9d_1                      ; // rcvalue9d_1;
			real    rcvalue9d                        ; // rcvalue9d;
			real    rcvalue9g_1                      ; // rcvalue9g_1;
			real    rcvalue9g                        ; // rcvalue9g;
			real    rcvalue9p_1                      ; // rcvalue9p_1;
			real    rcvalue9p                        ; // rcvalue9p;
			real    rcvalue9q_1                      ; // rcvalue9q_1;
			real    rcvalue9q                        ; // rcvalue9q;
			real    rcvalue9k_1                      ; // rcvalue9k_1;
			real    rcvalue9k                        ; // rcvalue9k;
			real    rcvalue9y_1                      ; // rcvalue9y_1;
			real    rcvalue9y                        ; // rcvalue9y;
			real    rcvalue99_1                      ; // rcvalue99_1;
			real    rcvalue99                        ; // rcvalue99;
			real    rcvalue9i_1                      ; // rcvalue9i_1;
			real    rcvalue9i                        ; // rcvalue9i;
			real    rcvalue98_1                      ; // rcvalue98_1;
			real    rcvalue98                        ; // rcvalue98;
			real    rcvalue9w_1                      ; // rcvalue9w_1;
			real    rcvalue9w_2                      ; // rcvalue9w_2;
			real    rcvalue9w                        ; // rcvalue9w;
			real    rcvalue97_1                      ; // rcvalue97_1;
			real    rcvalue97_2                      ; // rcvalue97_2;
			real    rcvalue97                        ; // rcvalue97;
			real    rcvaluebl_1                      ; // rcvaluebl_1;
			real    rcvaluebl_2                      ; // rcvaluebl_2;
			real    rcvaluebl_3                      ; // rcvaluebl_3;
			real    rcvaluebl                        ; // rcvaluebl;
			string  rc1                              ; // rc1;
			string  rc2                              ; // rc2;
			string  rc3                              ; // rc3;
			string  rc4                              ; // rc4;
			string  rc5                              ; // rc5;
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
		rc_decsflag                      := le.iid.decsflag;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		combo_dobscore                   := le.iid.combo_dobscore;
		ver_sources                      := le.header_summary.ver_sources;
		addrpop                          := le.input_validation.address;
		ssnlength                        := le.input_validation.ssn_length;
		dobpop                           := le.input_validation.dateofbirth;
		hphnpop                          := le.input_validation.homephone;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_pop                         := le.addrpop;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		addrs_5yr                        := le.other_address_info.addrs_last_5years;
		unique_addr_count                := le.address_history_summary.unique_addr_cnt;
		hist_addr_match                  := le.address_history_summary.hist_addr_match;
		telcordia_type                   := le.phone_verification.telcordia_type;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		adls_per_addr                    := le.velocity_counters.adls_per_addr;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		inq_count                        := le.acc_logs.inquiries.counttotal;
		inq_count01                      := le.acc_logs.inquiries.count01;
		inq_count03                      := le.acc_logs.inquiries.count03;
		inq_count06                      := le.acc_logs.inquiries.count06;
		inq_count12                      := le.acc_logs.inquiries.count12;
		inq_count24                      := le.acc_logs.inquiries.count24;
		inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
		pb_total_dollars                 := le.ibehavior.total_dollars;
		paw_active_phone_count           := le.employment.business_active_phone_ct;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		email_domain_free_count          := le.email_summary.email_domain_free_ct;
		email_source_list                := le.email_summary.email_source_list;
		attr_date_first_purchase         := le.other_address_info.date_first_purchase;
		attr_num_purchase30              := le.other_address_info.num_purchase30;
		attr_num_purchase90              := le.other_address_info.num_purchase90;
		attr_num_purchase180             := le.other_address_info.num_purchase180;
		attr_num_purchase12              := le.other_address_info.num_purchase12;
		attr_num_purchase24              := le.other_address_info.num_purchase24;
		attr_num_purchase36              := le.other_address_info.num_purchase36;
		attr_num_purchase60              := le.other_address_info.num_purchase60;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_eviction_count              := le.bjl.eviction_count;
		attr_eviction_count90            := le.bjl.eviction_count90;
		attr_eviction_count180           := le.bjl.eviction_count180;
		attr_eviction_count12            := le.bjl.eviction_count12;
		attr_eviction_count24            := le.bjl.eviction_count24;
		attr_eviction_count36            := le.bjl.eviction_count36;
		attr_eviction_count60            := le.bjl.eviction_count60;
		attr_num_nonderogs               := le.source_verification.num_nonderogs;
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
		inferred_age                     := le.inferred_age;

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

iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

iv_db001_bankruptcy := map(
    not(truedid or (integer)ssnlength > 0)                                                                                      => '                 ',
    (disposition in ['Discharge NA', 'Discharged'])                                                                             => '1 - BK Discharged',
    (disposition in ['Dismissed'])                                                                                              => '2 - BK Dismissed ',
    (rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 		=> '3 - BK Other     ',
                                                                                                                                   '0 - No BK        ');

iv_de001_eviction_recency := map(
    not(truedid)                                                  => NULL,
    attr_eviction_count90  >0                                     => 3,
    attr_eviction_count180 >0                                     => 6,
    attr_eviction_count12  >0                                     => 12,
    attr_eviction_count24  >0 and attr_eviction_count >= 2 				=> 24,
    attr_eviction_count24  >0                                     => 25,
    attr_eviction_count36  >0 and attr_eviction_count >= 2 				=> 36,
    attr_eviction_count36  >0                                    	=> 37,
    attr_eviction_count60  >0 and attr_eviction_count >= 2 				=> 60,
    attr_eviction_count60  >0                                     => 61,
    attr_eviction_count 	 >= 2                                   => 98,
    attr_eviction_count 	 >= 1                                   => 99,
																																		 0);

email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

iv_ds001_impulse_count := map(
    not(truedid)                           => NULL,
    impulse_count = 0 and email_src_im 		 => 1,
                                              impulse_count);

iv_ms001_ssns_per_adl := map(
    not(truedid)     => NULL,
    ssns_per_adl = 0 => 1,
                        ssns_per_adl);

_in_dob := common.sas_date((string)(in_dob));

// yr_in_dob := if(in_dob = NULL, -1, (sysdate - _in_dob) / 365.25);
yr_in_dob := map(in_dob = ''			=> -1, 
								 in_dob = '0'			=> 0, 
																		 (sysdate - _in_dob) / 365.25);

yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

age_estimate := map(
    yr_in_dob_int > 0 => yr_in_dob_int,
    inferred_age > 0  => inferred_age,
                         -1);

iv_ag001_age := if(not(truedid or dobpop), NULL, min(62, if(age_estimate = NULL, -NULL, age_estimate)));

iv_addrs_5yr := map(
    not(truedid)          => NULL,
    unique_addr_count = 0 => -1,
                             addrs_5yr);

iv_hist_addr_match := map(
    not(truedid)            => NULL,
    hist_addr_match = -9999 => -1,
                               hist_addr_match);

iv_max_ids_per_sfd_addr := map(
    not(add1_pop) => NULL,
    iv_add_apt    => -1,
                     max(adls_per_addr, ssns_per_addr));

iv_inq_recency := map(
    not(truedid) 		=> NULL,
    inq_count01 >0 	=> 1,
    inq_count03 >0  => 3,
    inq_count06 >0  => 6,
    inq_count12 >0  => 12,
    inq_count24 >0  => 24,
    inq_count   >0  => 99,
											 0);

iv_inq_highriskcredit_count12 := if(not(truedid), NULL, inq_highRiskCredit_count12);

iv_paw_active_phone_count := if(not(truedid), NULL, paw_active_phone_count);

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

iv_email_domain_free_count := if(not(truedid), NULL, email_domain_free_count);

iv_attr_purchase_recency := map(
    not(truedid)                 		=> NULL,
    attr_num_purchase30    >0       => 1,
    attr_num_purchase90    >0       => 3,
    attr_num_purchase180   >0       => 6,
    attr_num_purchase12    >0       => 12,
    attr_num_purchase24    >0       => 24,
    attr_num_purchase36    >0       => 36,
    attr_num_purchase60    >0       => 60,
    attr_date_first_purchase > 0 		=> 99,
																			 0);

iv_derog_diff := if(not(truedid), NULL, min(if(max(attr_num_nonderogs - attr_total_number_derogs, -10) = NULL, -NULL, max(attr_num_nonderogs - attr_total_number_derogs, -10)), 10));

iv_felony_count := if(not(truedid), NULL, felony_count);

iv_ams_college_code := map(
    not(truedid)            => '',
    ams_college_code = ''	  => '-1',
                               ams_college_code);

iv_pb_total_dollars := map(
    not(truedid)            								=> NULL,
    pb_total_dollars = ''										=> -1,
    // (integer)pb_total_dollars = NULL				=> -1,
    // (integer)pb_total_dollars = 0						=> 0,
																							 (integer)pb_total_dollars);

a_subscore0 := map(
    NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.123277,
    1 <= iv_ds001_impulse_count AND iv_ds001_impulse_count < 2   => -0.524561,
    2 <= iv_ds001_impulse_count AND iv_ds001_impulse_count < 3   => -1.242995,
    3 <= iv_ds001_impulse_count                                  => -1.381314,
                                                                    -0.000000);

a_subscore1 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 0.111484,
    2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -0.025010,
    3 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 4   => -0.154721,
    4 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 5   => -0.523248,
    5 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 6   => -0.902940,
    6 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 7   => -1.330867,
    7 <= iv_ms001_ssns_per_adl                                 => -1.991199,
                                                                  0.000000);

a_subscore2 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['Other'])                                        => 0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1', '0-0', '0-1', '1-0', '1-1', '1-3', '2-1']) => -0.101778,
    (iv_nap_phn_ver_x_inf_phn_ver in ['2-0'])                                          => -0.092128,
    (iv_nap_phn_ver_x_inf_phn_ver in ['2-3', '3-1', '3-3'])                            => 0.133078,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3'])                                          => 0.200806,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                          => 0.274400,
                                                                                          0.000000);

a_subscore3 := map(
    NULL < iv_de001_eviction_recency AND iv_de001_eviction_recency < 3 => 0.080553,
    3 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 25  => -0.561287,
    25 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 61 => -0.354567,
    61 <= iv_de001_eviction_recency                                    => -0.108257,
                                                                          -0.000000);

a_subscore4 := map(
    NULL < iv_derog_diff AND iv_derog_diff < -4 => -0.452700,
    -4 <= iv_derog_diff AND iv_derog_diff < -2  => -0.256222,
    -2 <= iv_derog_diff AND iv_derog_diff < 0   => -0.164649,
    0 <= iv_derog_diff AND iv_derog_diff < 1    => -0.101758,
    1 <= iv_derog_diff AND iv_derog_diff < 2    => -0.060982,
    2 <= iv_derog_diff AND iv_derog_diff < 3    => 0.057069,
    3 <= iv_derog_diff AND iv_derog_diff < 4    => 0.088045,
    4 <= iv_derog_diff AND iv_derog_diff < 5    => 0.187687,
    5 <= iv_derog_diff                          => 0.253655,
                                                   0.000000);

a_subscore5 := map(
    NULL < iv_addrs_5yr AND iv_addrs_5yr < 0 => -0.000000,
    0 <= iv_addrs_5yr AND iv_addrs_5yr < 2   => 0.168334,
    2 <= iv_addrs_5yr AND iv_addrs_5yr < 3   => 0.145235,
    3 <= iv_addrs_5yr AND iv_addrs_5yr < 4   => 0.042977,
    4 <= iv_addrs_5yr AND iv_addrs_5yr < 5   => 0.003792,
    5 <= iv_addrs_5yr AND iv_addrs_5yr < 6   => -0.073917,
    6 <= iv_addrs_5yr AND iv_addrs_5yr < 7   => -0.140064,
    7 <= iv_addrs_5yr AND iv_addrs_5yr < 8   => -0.363721,
    8 <= iv_addrs_5yr AND iv_addrs_5yr < 10  => -0.385682,
    10 <= iv_addrs_5yr                       => -0.914791,
                                                -0.000000);

a_subscore6 := map(
    NULL < iv_ag001_age AND iv_ag001_age < 1 => -0.000000,
    1 <= iv_ag001_age AND iv_ag001_age < 23  => -0.723840,
    23 <= iv_ag001_age AND iv_ag001_age < 25 => -0.432448,
    25 <= iv_ag001_age AND iv_ag001_age < 43 => -0.033833,
    43 <= iv_ag001_age AND iv_ag001_age < 49 => 0.195287,
    49 <= iv_ag001_age AND iv_ag001_age < 55 => 0.204041,
    55 <= iv_ag001_age                       => 0.209598,
                                                -0.000000);

a_subscore7 := map(
    NULL < iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 1 => 0.038629,
    1 <= iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 2   => -0.370897,
    2 <= iv_inq_highriskcredit_count12                                         => -0.481726,
                                                                                  -0.000000);

a_subscore8 := map(
    NULL < iv_inq_recency AND iv_inq_recency < 1 => 0.052361,
    1 <= iv_inq_recency AND iv_inq_recency < 3   => -0.327566,
    3 <= iv_inq_recency AND iv_inq_recency < 6   => -0.252963,
    6 <= iv_inq_recency AND iv_inq_recency < 12  => -0.041428,
    12 <= iv_inq_recency                         => -0.008172,
                                                    -0.000000);

a_subscore9 := map(
    (iv_db001_bankruptcy in ['0 - No BK'])         => -0.029991,
    (iv_db001_bankruptcy in ['1 - BK Discharged']) => 0.194894,
    (iv_db001_bankruptcy in ['3 - BK Other'])      => 0.124058,
    (iv_db001_bankruptcy in ['2 - BK Dismissed'])  => -0.257338,
                                                      -0.000000);

a_subscore10 := map(
    NULL < iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 0 => -0.126082,
    0 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 1   => 0.160031,
    1 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 3   => 0.317116,
    3 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 6   => 0.234256,
    6 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 10  => 0.140893,
    10 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 12 => 0.121360,
    12 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 16 => 0.090524,
    16 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 20 => 0.005548,
    20 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 31 => -0.061984,
    31 <= iv_max_ids_per_sfd_addr                                  => -0.127864,
                                                                      0.000000);

a_subscore11 := map(
    NULL < iv_pb_total_dollars AND iv_pb_total_dollars < 51  => -0.078544,
    51 <= iv_pb_total_dollars AND iv_pb_total_dollars < 129  => 0.088458,
    129 <= iv_pb_total_dollars AND iv_pb_total_dollars < 465 => 0.202163,
    465 <= iv_pb_total_dollars                               => 0.206462,
                                                                0.000000);

a_subscore12 := map(
    NULL < iv_attr_purchase_recency AND iv_attr_purchase_recency < 1 => -0.048422,
    1 <= iv_attr_purchase_recency AND iv_attr_purchase_recency < 12  => 0.272895,
    12 <= iv_attr_purchase_recency AND iv_attr_purchase_recency < 24 => 0.261323,
    24 <= iv_attr_purchase_recency AND iv_attr_purchase_recency < 36 => 0.133063,
    36 <= iv_attr_purchase_recency AND iv_attr_purchase_recency < 99 => 0.118322,
    99 <= iv_attr_purchase_recency                                   => 0.077032,
                                                                        0.000000);

a_subscore13 := map(
    NULL < iv_hist_addr_match AND iv_hist_addr_match < 0 => 0.008953,
    0 <= iv_hist_addr_match AND iv_hist_addr_match < 2   => 0.056141,
    2 <= iv_hist_addr_match AND iv_hist_addr_match < 3   => -0.200542,
    3 <= iv_hist_addr_match                              => -0.329637,
                                                            -0.000000);

a_subscore14 := map(
    (iv_ams_college_code in ['Other'])  => 0.000000,
    (iv_ams_college_code in ['-1'])     => -0.008807,
    (iv_ams_college_code in ['2'])      => -0.042714,
    (iv_ams_college_code in ['1', '4']) => 0.180216,
                                           0.000000);

a_subscore15 := map(
    NULL < iv_felony_count AND iv_felony_count < 1 => 0.012243,
    1 <= iv_felony_count                           => -1.030893,
                                                      0.000000);

a_subscore16 := map(
    NULL < iv_email_domain_free_count AND iv_email_domain_free_count < 1 => 0.015119,
    1 <= iv_email_domain_free_count AND iv_email_domain_free_count < 2   => 0.014898,
    2 <= iv_email_domain_free_count AND iv_email_domain_free_count < 3   => 0.000828,
    3 <= iv_email_domain_free_count                                      => -0.074263,
                                                                            -0.000000);

a_subscore17 := map(
    NULL < iv_paw_active_phone_count AND iv_paw_active_phone_count < 1 => -0.009412,
    1 <= iv_paw_active_phone_count                                     => 0.363292,
                                                                          -0.000000);

a_rawscore := a_subscore0 +
    a_subscore1 +
    a_subscore2 +
    a_subscore3 +
    a_subscore4 +
    a_subscore5 +
    a_subscore6 +
    a_subscore7 +
    a_subscore8 +
    a_subscore9 +
    a_subscore10 +
    a_subscore11 +
    a_subscore12 +
    a_subscore13 +
    a_subscore14 +
    a_subscore15 +
    a_subscore16 +
    a_subscore17;

a_lnoddsscore := a_rawscore + 1.910709;

a_probscore := exp(a_lnoddsscore) / (1 + exp(a_lnoddsscore));

base := 600;

point := 40;

odds := (1 - 0.123) / 0.123;

rvg1302_1_0 := map(
    rc_decsflag = '1'	=> 200,
    iv_riskview_222s 	=> 222,
                         max(min(if(round(point * (ln(a_probscore / (1 - a_probscore)) - ln(odds)) / ln(2) + base) = NULL, -NULL, round(point * (ln(a_probscore / (1 - a_probscore)) - ln(odds)) / ln(2) + base)), 900), 501));

rc1_3 := '';

rc2_3 := '';

rc3_2 := '';

rc4_2 := '';

rc5_3 := '';

glrc9w := (truedid or (integer)ssnlength > 0) and filing_count > 0;

glrc97 := truedid and (criminal_count > 0 or felony_count > 0);

glrc36 := 1;

glrcev := truedid and attr_eviction_count > 0;

glrc9h := truedid and (impulse_count > 0 or email_src_im);

glrcms := truedid and ssns_per_adl > 2;

glrc9g := truedid and dobpop and 0 < iv_ag001_age AND iv_ag001_age < 25;

glrc9d := truedid and unique_addr_count > 0;

glrc99 := truedid and hist_addr_match > 1;

glrc9k := iv_add_apt;

glrc9q := truedid and inq_count > 0;

glrc9p := truedid and inq_highRiskCredit_count12 > 0;

glrc98 := truedid and (liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0);

glrc9i := truedid and 0 < iv_ag001_age AND iv_ag001_age < 30 and ams_college_tier = '';  // (integer)ams_college_tier < 0);

glrc9y := truedid and (integer)pb_total_dollars < 1;

glrcbl := 0;

bk_flag := filing_count > 0;

crim_flag := criminal_count > 0;

lien_flag := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

rcvalue9h_1 := 0.123277 - a_subscore0;

rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

rcvaluems_1 := 0.111484 - a_subscore1;

rcvaluems := (integer)glrcms * if(max(rcvaluems_1) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1)));

rcvalue36_1 := 0.274400 - a_subscore2;

rcvalue36 := glrc36 * if(max(rcvalue36_1) = NULL, NULL, sum(if(rcvalue36_1 = NULL, 0, rcvalue36_1)));

rcvalueev_1 := 0.080553 - a_subscore3;

rcvalueev := (integer)glrcev * if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

rcvalue9d_1 := 0.168334 - a_subscore5;

rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

rcvalue9g_1 := 0.209598 - a_subscore6;

rcvalue9g := (integer)glrc9g * if(max(rcvalue9g_1) = NULL, NULL, sum(if(rcvalue9g_1 = NULL, 0, rcvalue9g_1)));

rcvalue9p_1 := 0.038629 - a_subscore7;

rcvalue9p := (integer)glrc9p * if(max(rcvalue9p_1) = NULL, NULL, sum(if(rcvalue9p_1 = NULL, 0, rcvalue9p_1)));

rcvalue9q_1 := 0.052361 - a_subscore8;

rcvalue9q := (integer)glrc9q * if(max(rcvalue9q_1) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1)));

rcvalue9k_1 := 0.317116 - a_subscore10;

rcvalue9k := (integer)glrc9k * if(max(rcvalue9k_1) = NULL, NULL, sum(if(rcvalue9k_1 = NULL, 0, rcvalue9k_1)));

rcvalue9y_1 := 0.206462 - a_subscore11;

// rcvalue9y := (integer)glrc9y * if(max(rcvalue9y_1) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1)));
rcvalue9y := 0;

rcvalue99_1 := 0.056141 - a_subscore13;

rcvalue99 := (integer)glrc99 * if(max(rcvalue99_1) = NULL, NULL, sum(if(rcvalue99_1 = NULL, 0, rcvalue99_1)));

rcvalue9i_1 := 0.180216 - a_subscore14;

rcvalue9i := (integer)glrc9i * if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));

rcvalue98_1 := if(lien_flag, (integer)lien_flag / if(max((integer)bk_flag, (integer)crim_flag, (integer)lien_flag) = NULL, NULL, sum((integer)bk_flag, (integer)crim_flag, (integer)lien_flag)) * (0.253655 - a_subscore4), 0);

rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));

rcvalue9w_1 := if(bk_flag, (integer)bk_flag / if(max((integer)bk_flag, (integer)crim_flag, (integer)lien_flag) = NULL, NULL, sum((integer)bk_flag, (integer)crim_flag, (integer)lien_flag)) * (0.253655 - a_subscore4), 0);

rcvalue9w_2 := 0.194894 - a_subscore9;

rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1, rcvalue9w_2) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1), if(rcvalue9w_2 = NULL, 0, rcvalue9w_2)));

rcvalue97_1 := if(crim_flag, (integer)crim_flag / if(max((integer)bk_flag, (integer)crim_flag, (integer)lien_flag) = NULL, NULL, sum((integer)bk_flag, (integer)crim_flag, (integer)lien_flag)) * (0.253655 - a_subscore4), 0);

rcvalue97_2 := 0.012243 - a_subscore15;

rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1, rcvalue97_2) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1), if(rcvalue97_2 = NULL, 0, rcvalue97_2)));

rcvaluebl_1 := 0.363292 - a_subscore17;

rcvaluebl_2 := 0.015119 - a_subscore16;

rcvaluebl_3 := 0.272895 - a_subscore12;

rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
	{'9H', rcvalue9h},
	{'MS', rcvaluems},
	{'36', rcvalue36},
	{'EV', rcvalueev},
	{'9D', rcvalue9d},
	{'9G', rcvalue9g},
	{'9P', rcvalue9p},
	{'9Q', rcvalue9q},
	{'9K', rcvalue9k},
	{'9Y', rcvalue9y},
	{'99', rcvalue99},
	{'9I', rcvalue9i},
	{'98', rcvalue98},
	{'9W', rcvalue9w},
	{'97', rcvalue97},
	{'BL', rcvaluebl}
    ], ds_layout)(value > 0);

	rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes
	
	rcs_9p1 := rcs_top4[1];
	rcs_9p2 := IF(rcs_top4[2].rc = '' and rcs_top4[1].rc not in ['', '36'], 		//If only one reason code is set and it's not '36', set RC2 to '36'
								ROW({'36', NULL}, ds_layout), 
								rcs_top4[2]);
	rcs_9p3 := rcs_top4[3];
	rcs_9p4 := rcs_top4[4];
	rcs_9p5 := IF(glrc9p and inq_highRiskCredit_count12 > 0 AND NOT EXISTS(rcs_top4 (rc = '9P')),  	// Check to see if RC 9P is a part of the score, but not in the first 4 RC's
								ROW({'9P', NULL}, ds_layout)); 																										// If so - make it the 5th reason code.
	
	
	rcs_9p := rcs_9p1 & rcs_9p2 & rcs_9p3 & rcs_9p4 & rcs_9p5;

	rcs_override := MAP(
											rvg1302_1_0 = 200 => DATASET([{'02', NULL}], ds_layout),
											rvg1302_1_0 = 222 => DATASET([{'9X', NULL}], ds_layout),
											rvg1302_1_0 = 900 => DATASET([{'  ', NULL}], ds_layout),
											NOT EXISTS(rcs_9p(rc != '')) => DATASET([{'36', NULL}], ds_layout),
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
						inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
						rcs_final
						);
					
	zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
	
	reasons := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes

//Intermediate variables
	#if(RVG_DEBUG)
	  self.clam															:= le;
		self.sysdate                          := sysdate;
		self.iv_pots_phone                    := iv_pots_phone;
		self.iv_add_apt                       := iv_add_apt;
		self.iv_riskview_222s                 := iv_riskview_222s;
		self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
		self.iv_de001_eviction_recency        := iv_de001_eviction_recency;
		self.email_src_im                     := email_src_im;
		self.iv_ds001_impulse_count           := iv_ds001_impulse_count;
		self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;
		self._in_dob                          := _in_dob;
		self.yr_in_dob                        := yr_in_dob;
		self.yr_in_dob_int                    := yr_in_dob_int;
		self.age_estimate                     := age_estimate;
		self.iv_ag001_age                     := iv_ag001_age;
		self.iv_addrs_5yr                     := iv_addrs_5yr;
		self.iv_hist_addr_match               := iv_hist_addr_match;
		self.iv_max_ids_per_sfd_addr          := iv_max_ids_per_sfd_addr;
		self.iv_inq_recency                   := iv_inq_recency;
		self.iv_inq_highriskcredit_count12    := iv_inq_highriskcredit_count12;
		self.iv_paw_active_phone_count        := iv_paw_active_phone_count;
		self.ver_phn_inf                      := ver_phn_inf;
		self.ver_phn_nap                      := ver_phn_nap;
		self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
		self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
		self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
		self.iv_email_domain_free_count       := iv_email_domain_free_count;
		self.iv_attr_purchase_recency         := iv_attr_purchase_recency;
		self.iv_derog_diff                    := iv_derog_diff;
		self.iv_felony_count                  := iv_felony_count;
		self.iv_ams_college_code              := iv_ams_college_code;
		self.iv_pb_total_dollars              := iv_pb_total_dollars;
		self.a_subscore0                      := a_subscore0;
		self.a_subscore1                      := a_subscore1;
		self.a_subscore2                      := a_subscore2;
		self.a_subscore3                      := a_subscore3;
		self.a_subscore4                      := a_subscore4;
		self.a_subscore5                      := a_subscore5;
		self.a_subscore6                      := a_subscore6;
		self.a_subscore7                      := a_subscore7;
		self.a_subscore8                      := a_subscore8;
		self.a_subscore9                      := a_subscore9;
		self.a_subscore10                     := a_subscore10;
		self.a_subscore11                     := a_subscore11;
		self.a_subscore12                     := a_subscore12;
		self.a_subscore13                     := a_subscore13;
		self.a_subscore14                     := a_subscore14;
		self.a_subscore15                     := a_subscore15;
		self.a_subscore16                     := a_subscore16;
		self.a_subscore17                     := a_subscore17;
		self.a_rawscore                       := a_rawscore;
		self.a_lnoddsscore                    := a_lnoddsscore;
		self.a_probscore                      := a_probscore;
		self.base                             := base;
		self.point                            := point;
		self.odds                             := odds;
		self.rvg1302_1_0                      := rvg1302_1_0;
		self.glrc9w                           := glrc9w;
		self.glrc97                           := glrc97;
		self.glrc36                           := glrc36;
		self.glrcev                           := glrcev;
		self.glrc9h                           := glrc9h;
		self.glrcms                           := glrcms;
		self.glrc9g                           := glrc9g;
		self.glrc9d                           := glrc9d;
		self.glrc99                           := glrc99;
		self.glrc9k                           := glrc9k;
		self.glrc9q                           := glrc9q;
		self.glrc9p                           := glrc9p;
		self.glrc98                           := glrc98;
		self.glrc9i                           := glrc9i;
		self.glrc9y                           := glrc9y;
		self.glrcbl                           := glrcbl;
		self.bk_flag                          := bk_flag;
		self.crim_flag                        := crim_flag;
		self.lien_flag                        := lien_flag;
		self.rcvalue9h_1                      := rcvalue9h_1;
		self.rcvalue9h                        := rcvalue9h;
		self.rcvaluems_1                      := rcvaluems_1;
		self.rcvaluems                        := rcvaluems;
		self.rcvalue36_1                      := rcvalue36_1;
		self.rcvalue36                        := rcvalue36;
		self.rcvalueev_1                      := rcvalueev_1;
		self.rcvalueev                        := rcvalueev;
		self.rcvalue9d_1                      := rcvalue9d_1;
		self.rcvalue9d                        := rcvalue9d;
		self.rcvalue9g_1                      := rcvalue9g_1;
		self.rcvalue9g                        := rcvalue9g;
		self.rcvalue9p_1                      := rcvalue9p_1;
		self.rcvalue9p                        := rcvalue9p;
		self.rcvalue9q_1                      := rcvalue9q_1;
		self.rcvalue9q                        := rcvalue9q;
		self.rcvalue9k_1                      := rcvalue9k_1;
		self.rcvalue9k                        := rcvalue9k;
		self.rcvalue9y_1                      := rcvalue9y_1;
		self.rcvalue9y                        := rcvalue9y;
		self.rcvalue99_1                      := rcvalue99_1;
		self.rcvalue99                        := rcvalue99;
		self.rcvalue9i_1                      := rcvalue9i_1;
		self.rcvalue9i                        := rcvalue9i;
		self.rcvalue98_1                      := rcvalue98_1;
		self.rcvalue98                        := rcvalue98;
		self.rcvalue9w_1                      := rcvalue9w_1;
		self.rcvalue9w_2                      := rcvalue9w_2;
		self.rcvalue9w                        := rcvalue9w;
		self.rcvalue97_1                      := rcvalue97_1;
		self.rcvalue97_2                      := rcvalue97_2;
		self.rcvalue97                        := rcvalue97;
		self.rcvaluebl_1                      := rcvaluebl_1;
		self.rcvaluebl_2                      := rcvaluebl_2;
		self.rcvaluebl_3                      := rcvaluebl_3;
		self.rcvaluebl                        := rcvaluebl;
		self.rc1                              := reasons[1].hri;
		self.rc2                              := reasons[2].hri;
		self.rc3                              := reasons[3].hri;
		self.rc4                              := reasons[4].hri;
		self.rc5                              := reasons[5].hri;
	#end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		
		self.score := MAP(
											reasons[1].hri IN ['91','92','93','94'] 			=> (STRING3)((INTEGER)reasons[1].hri + 10),
											reasons[1].hri='35' => '100',
											(string3)RVG1302_1_0
										);
END;

		model := project( clam, doModel(left) );

		return model;
END;
