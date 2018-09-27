//Santander D-Paper Custom Model Refresh

import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVA1304_2_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVA_DEBUG := false;

  #if(RVA_DEBUG)
    layout_debug := record
			integer sysdate                          ; //sysdate;
			boolean iv_pots_phone                    ; //iv_pots_phone;
			boolean iv_add_apt                       ; //iv_add_apt;
			boolean iv_riskview_222s                 ; //iv_riskview_222s;
			string  iv_db001_bankruptcy              ; //iv_db001_bankruptcy;
			integer iv_de001_eviction_recency        ; //iv_de001_eviction_recency;
			boolean email_src_im                     ; //email_src_im;
			integer iv_ds001_impulse_count           ; //iv_ds001_impulse_count;
			integer _in_dob                          ; //_in_dob;
			real    yr_in_dob                        ; //yr_in_dob;
			integer yr_in_dob_int                    ; //yr_in_dob_int;
			integer age_estimate                     ; //age_estimate;
			integer iv_ag001_age                     ; //iv_ag001_age;
			integer iv_pv001_inp_avm_autoval         ; //iv_pv001_inp_avm_autoval;
			integer iv_pl002_addrs_per_adl_c6        ; //iv_pl002_addrs_per_adl_c6;
			integer iv_src_property_adl_count        ; //iv_src_property_adl_count;
			integer iv_addr_non_phn_src_ct           ; //iv_addr_non_phn_src_ct;
			integer iv_addrs_5yr                     ; //iv_addrs_5yr;
			integer iv_addrs_per_adl                 ; //iv_addrs_per_adl;
			integer iv_credit_seeking                ; //iv_credit_seeking;
			boolean ver_phn_inf                      ; //ver_phn_inf;
			boolean ver_phn_nap                      ; //ver_phn_nap;
			integer inf_phn_ver_lvl                  ; //inf_phn_ver_lvl;
			integer nap_phn_ver_lvl                  ; //nap_phn_ver_lvl;
			string  iv_nap_phn_ver_x_inf_phn_ver     ; //iv_nap_phn_ver_x_inf_phn_ver;
			integer iv_email_domain_free_count       ; //iv_email_domain_free_count;
			integer iv_attr_purchase_recency         ; //iv_attr_purchase_recency;
			integer iv_derog_ratio                   ; //iv_derog_ratio;
			integer iv_unreleased_liens_ct           ; //iv_unreleased_liens_ct;
			integer iv_liens_rel_cj_ct               ; //iv_liens_rel_cj_ct;
			string  iv_criminal_x_felony             ; //iv_criminal_x_felony;
			string  iv_prof_license_category         ; //iv_prof_license_category;
			real    dri_subscore0                    ; //dri_subscore0;
			real    dri_subscore1                    ; //dri_subscore1;
			real    dri_subscore2                    ; //dri_subscore2;
			real    dri_subscore3                    ; //dri_subscore3;
			real    dri_subscore4                    ; //dri_subscore4;
			real    dri_subscore5                    ; //dri_subscore5;
			real    dri_subscore6                    ; //dri_subscore6;
			real    dri_subscore7                    ; //dri_subscore7;
			real    dri_subscore8                    ; //dri_subscore8;
			real    dri_subscore9                    ; //dri_subscore9;
			real    dri_subscore10                   ; //dri_subscore10;
			real    dri_subscore11                   ; //dri_subscore11;
			real    dri_subscore12                   ; //dri_subscore12;
			real    dri_subscore13                   ; //dri_subscore13;
			real    dri_subscore14                   ; //dri_subscore14;
			real    dri_subscore15                   ; //dri_subscore15;
			real    dri_subscore16                   ; //dri_subscore16;
			real    dri_subscore17                   ; //dri_subscore17;
			real    dri_subscore18                   ; //dri_subscore18;
			real    dri_rawscore                     ; //dri_rawscore;
			real    dri_lnoddsscore                  ; //dri_lnoddsscore;
			real    dri_probscore                    ; //dri_probscore;
			integer dbase                            ; //dbase;
			integer dpts                             ; //dpts;
			real    dlogit                           ; //dlogit;
			integer rva1304_2_0                      ; //rva1304_2_0;
			boolean glrc9w                           ; //glrc9w;
			boolean glrcev                           ; //glrcev;
			boolean glrc9h                           ; //glrc9h;
			boolean glrc9g                           ; //glrc9g;
			boolean glrcpv                           ; //glrcpv;
			boolean glrc9d                           ; //glrc9d;
			boolean glrc9e                           ; //glrc9e;
			boolean glrc9o                           ; //glrc9o;
			boolean glrc98                           ; //glrc98;
			boolean glrc97                           ; //glrc97;
			boolean glrcbl                           ; //glrcbl;
			boolean criminal_flag                    ; //criminal_flag;
			boolean lien_unrel_flag                  ; //lien_unrel_flag;
			boolean bankruptcy_flag                  ; //bankruptcy_flag;
			boolean impulse_flag                     ; //impulse_flag;
			boolean eviction_flag                    ; //eviction_flag;
			integer derog_flag_sum                   ; //derog_flag_sum;
			real    divptslost_iv_derog_ratio        ; //divptslost_iv_derog_ratio;
			real    rcvalue9w_1                      ; //rcvalue9w_1;
			real    rcvalue9w_2                      ; //rcvalue9w_2;
			real    rcvalue9w                        ; //rcvalue9w;
			real    rcvalueev_1                      ; //rcvalueev_1;
			real    rcvalueev_2                      ; //rcvalueev_2;
			real    rcvalueev                        ; //rcvalueev;
			real    rcvalue9h_1                      ; //rcvalue9h_1;
			real    rcvalue9h_2                      ; //rcvalue9h_2;
			real    rcvalue9h                        ; //rcvalue9h;
			real    rcvalue9g_1                      ; //rcvalue9g_1;
			real    rcvalue9g                        ; //rcvalue9g;
			real    rcvaluepv_1                      ; //rcvaluepv_1;
			real    rcvaluepv                        ; //rcvaluepv;
			real    rcvalue9d_1                      ; //rcvalue9d_1;
			real    rcvalue9d_2                      ; //rcvalue9d_2;
			real    rcvalue9d_3                      ; //rcvalue9d_3;
			real    rcvalue9d                        ; //rcvalue9d;
			real    rcvalue9e_1                      ; //rcvalue9e_1;
			real    rcvalue9e                        ; //rcvalue9e;
			real    rcvalue9o_1                      ; //rcvalue9o_1;
			real    rcvalue9o                        ; //rcvalue9o;
			real    rcvalue98_1                      ; //rcvalue98_1;
			real    rcvalue98_2                      ; //rcvalue98_2;
			real    rcvalue98_3                      ; //rcvalue98_3;
			real    rcvalue98                        ; //rcvalue98;
			real    rcvalue97_1                      ; //rcvalue97_1;
			real    rcvalue97_2                      ; //rcvalue97_2;
			real    rcvalue97                        ; //rcvalue97;
			real    rcvaluebl_1                      ; //rcvaluebl_1;
			real    rcvaluebl_2                      ; //rcvaluebl_2;
			real    rcvaluebl_3                      ; //rcvaluebl_3;
			real    rcvaluebl_4                      ; //rcvaluebl_4;
			real    rcvaluebl_5                      ; //rcvaluebl_5;
			real    rcvaluebl                        ; //rcvaluebl;
			string  rc1                              ; //rc1;
			string  rc2                              ; //rc2;
			string  rc3                              ; //rc3;
			string  rc4                              ; //rc4;
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
		rc_addrcount                     := le.iid.addrcount;
		combo_dobscore                   := le.iid.combo_dobscore;
		ver_sources                      := le.header_summary.ver_sources;
		ver_sources_count                := le.header_summary.ver_sources_recordcount;
		addrpop                          := le.input_validation.address;
		ssnlength                        := le.input_validation.ssn_length;
		dobpop                           := le.input_validation.dateofbirth;
		hphnpop                          := le.input_validation.homephone;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_pop                         := le.addrpop;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		addrs_5yr                        := le.other_address_info.addrs_last_5years;
		unique_addr_count                := le.address_history_summary.unique_addr_cnt;
		telcordia_type                   := le.phone_verification.telcordia_type;
		addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
		addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
		inq_auto_count03                 := le.acc_logs.auto.count03;
		inq_banking_count03              := le.acc_logs.banking.count03;
		inq_mortgage_count03             := le.acc_logs.mortgage.count03;
		inq_retail_count03               := le.acc_logs.retail.count03;
		inq_communications_count03       := le.acc_logs.communications.count03;
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
		liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
		criminal_count                   := le.bjl.criminal_count;
		felony_count                     := le.bjl.felony_count;
		prof_license_category            := le.professional_license.plcategory;
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
    not(truedid)                                                		=> NULL,
    attr_eviction_count90 > 0                                      	=> 3,
    attr_eviction_count180 > 0                                     	=> 6,
    attr_eviction_count12 > 0                                      	=> 12,
    (boolean)attr_eviction_count24 and attr_eviction_count >= 2			=> 24,
    attr_eviction_count24 > 0                                      	=> 25,
    (boolean)attr_eviction_count36 and attr_eviction_count >= 2 		=> 36,
    attr_eviction_count36 > 0                                      	=> 37,
    (boolean)attr_eviction_count60 and attr_eviction_count >= 2 		=> 60,
    attr_eviction_count60 > 0                                      	=> 61,
    attr_eviction_count >= 2                                    		=> 98,
    attr_eviction_count >= 1                                    		=> 99,
																																			 0);

email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

iv_ds001_impulse_count := map(
    not(truedid)                           => NULL,
    impulse_count = 0 and email_src_im 		 => 1,
                                              impulse_count);

_in_dob := common.sas_date((string)(in_dob));

yr_in_dob := if(in_dob = '0', 0, if(in_dob = '', -1, (sysdate - _in_dob) / 365.25));

yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

age_estimate := map(
    yr_in_dob_int > 0 => yr_in_dob_int,
    inferred_age > 0  => inferred_age,
                         -1);

iv_ag001_age := if(not(truedid or dobpop), NULL, min(62, if(age_estimate = NULL, -NULL, age_estimate)));

iv_pv001_inp_avm_autoval := if(not(add1_pop), NULL, add1_avm_automated_valuation);

iv_pl002_addrs_per_adl_c6 := if(not(truedid), NULL, addrs_per_adl_c6);

iv_src_property_adl_count := if(not(truedid), 
																NULL, 
																max(if(max((integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E'), ',')) = NULL, 
																			 NULL, 
																			 sum(if((integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E'), ',') = NULL, 
																							0, 
																							(integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E'), ',')))), 0));

iv_addr_non_phn_src_ct := if(not(truedid) and add1_pop, NULL, rc_addrcount);

iv_addrs_5yr := map(
    not(truedid)          => NULL,
    unique_addr_count = 0 => -1,
                             addrs_5yr);

iv_addrs_per_adl := if(not(truedid), NULL, addrs_per_adl);

iv_credit_seeking := if(not(truedid), NULL, if(max(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)), min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)), min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)), min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)), min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))) = NULL, NULL, sum(if(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)) = NULL, 0, min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03))), if(min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)) = NULL, 0, min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03))), if(min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)) = NULL, 0, min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03))), if(min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)) = NULL, 0, min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03))), if(min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03)) = NULL, 0, min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))))));

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
    not(truedid)                   => NULL,
    attr_num_purchase30  >0        => 1,
    attr_num_purchase90  >0        => 3,
    attr_num_purchase180 >0        => 6,
    attr_num_purchase12  >0        => 12,
    attr_num_purchase24  >0        => 24,
    attr_num_purchase36  >0        => 36,
    attr_num_purchase60  >0        => 60,
    attr_date_first_purchase > 0   => 99,
                                      0);

iv_derog_ratio := map(
    not(truedid)                                            => NULL,
    attr_num_nonderogs = 0 and attr_total_number_derogs = 0 => -1,
    attr_num_nonderogs > 0 and attr_total_number_derogs = 0 => 100 + 10 * min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 10),
                                                               if (attr_total_number_derogs / if(max(attr_num_nonderogs, attr_total_number_derogs) = NULL, NULL, sum(if(attr_num_nonderogs = NULL, 0, attr_num_nonderogs), if(attr_total_number_derogs = NULL, 0, attr_total_number_derogs))) * 10 >= 0, roundup(attr_total_number_derogs / if(max(attr_num_nonderogs, attr_total_number_derogs) = NULL, NULL, sum(if(attr_num_nonderogs = NULL, 0, attr_num_nonderogs), if(attr_total_number_derogs = NULL, 0, attr_total_number_derogs))) * 10), truncate(attr_total_number_derogs / if(max(attr_num_nonderogs, attr_total_number_derogs) = NULL, NULL, sum(if(attr_num_nonderogs = NULL, 0, attr_num_nonderogs), if(attr_total_number_derogs = NULL, 0, attr_total_number_derogs))) * 10)) * 10);

iv_unreleased_liens_ct := if(not(truedid), NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))));

iv_liens_rel_cj_ct := if(not(truedid), NULL, liens_rel_CJ_ct);

iv_criminal_x_felony := if(not(truedid), '   ', trim((string)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

iv_prof_license_category := map(
    not(truedid)                 => '  ',
    prof_license_category = ''	 => '-1',
                                    prof_license_category);

dri_subscore0 := map(
    (iv_db001_bankruptcy in ['2 - BK Dismissed'])                               => -0.373710,
    (iv_db001_bankruptcy in ['0 - No BK', '1 - BK Discharged', '3 - BK Other']) => 0.014698,
                                                                                   0.000000);

dri_subscore1 := map(
    NULL < iv_de001_eviction_recency AND iv_de001_eviction_recency < 3 => 0.021448,
    3 <= iv_de001_eviction_recency                                     => -0.164853,
                                                                          0.000000);

dri_subscore2 := map(
    NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.055261,
    1 <= iv_ds001_impulse_count                                  => -0.534047,
                                                                    0.000000);

dri_subscore3 := map(
    NULL < iv_ag001_age AND iv_ag001_age < 41 => -0.080281,
    41 <= iv_ag001_age AND iv_ag001_age < 47  => -0.039416,
    47 <= iv_ag001_age AND iv_ag001_age < 55  => 0.139637,
    55 <= iv_ag001_age                        => 0.256480,
                                                 -0.000000);

dri_subscore4 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 4208   => -0.020819,
    4208 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 57787 => -0.153076,
    57787 <= iv_pv001_inp_avm_autoval                                     => 0.061799,
                                                                             0.000000);

dri_subscore5 := map(
    NULL < iv_pl002_addrs_per_adl_c6 AND iv_pl002_addrs_per_adl_c6 < 1 => 0.022012,
    1 <= iv_pl002_addrs_per_adl_c6 AND iv_pl002_addrs_per_adl_c6 < 2   => -0.012590,
    2 <= iv_pl002_addrs_per_adl_c6                                     => -0.096236,
                                                                          0.000000);

dri_subscore6 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count < 5 => -0.019806,
    5 <= iv_src_property_adl_count                                     => 0.282156,
                                                                          0.000000);

dri_subscore7 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 1 => -0.127143,
    1 <= iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 2   => 0.014278,
    2 <= iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 3   => 0.053265,
    3 <= iv_addr_non_phn_src_ct                                  => 0.112937,
                                                                    0.000000);

dri_subscore8 := map(
    NULL < iv_addrs_5yr AND iv_addrs_5yr < 4 => 0.026750,
    4 <= iv_addrs_5yr AND iv_addrs_5yr < 5   => -0.024922,
    5 <= iv_addrs_5yr AND iv_addrs_5yr < 6   => -0.044890,
    6 <= iv_addrs_5yr                        => -0.086754,
                                                0.000000);

dri_subscore9 := map(
    NULL < iv_addrs_per_adl AND iv_addrs_per_adl < 2 => 0.367001,
    2 <= iv_addrs_per_adl AND iv_addrs_per_adl < 3   => 0.157083,
    3 <= iv_addrs_per_adl AND iv_addrs_per_adl < 12  => -0.000105,
    12 <= iv_addrs_per_adl                           => -0.047400,
                                                        0.000000);

dri_subscore10 := map(
    NULL < iv_credit_seeking AND iv_credit_seeking < 1 => 0.035966,
    1 <= iv_credit_seeking                             => -0.136857,
                                                          0.000000);

dri_subscore11 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                                     => -0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1', '2-0', '2-1']) => -0.056964,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-3'])                                    => -0.053639,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '1-3', '2-3', '3-1'])               => 0.071840,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                    => 0.307321,
                                                                                    -0.000000);

dri_subscore12 := map(
    NULL < iv_email_domain_free_count AND iv_email_domain_free_count < 2 => 0.018970,
    2 <= iv_email_domain_free_count AND iv_email_domain_free_count < 3   => -0.038337,
    3 <= iv_email_domain_free_count AND iv_email_domain_free_count < 4   => -0.042696,
    4 <= iv_email_domain_free_count                                      => -0.100044,
                                                                            0.000000);

dri_subscore13 := map(
    NULL < iv_attr_purchase_recency AND iv_attr_purchase_recency < 1 => -0.029547,
    1 <= iv_attr_purchase_recency                                    => 0.058914,
                                                                        0.000000);

dri_subscore14 := map(
    NULL < iv_derog_ratio AND iv_derog_ratio < 30  => 0.163174,
    30 <= iv_derog_ratio AND iv_derog_ratio < 40   => 0.082751,
    40 <= iv_derog_ratio AND iv_derog_ratio < 110  => -0.029821,
    110 <= iv_derog_ratio AND iv_derog_ratio < 150 => -0.026851,
    150 <= iv_derog_ratio                          => 0.050141,
                                                      0.000000);

dri_subscore15 := map(
    NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 1 => 0.085276,
    1 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 2   => -0.081171,
    2 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 3   => -0.119733,
    3 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 5   => -0.187432,
    5 <= iv_unreleased_liens_ct                                  => -0.384768,
                                                                    0.000000);

dri_subscore16 := map(
    NULL < iv_liens_rel_cj_ct AND iv_liens_rel_cj_ct < 1 => 0.004554,
    1 <= iv_liens_rel_cj_ct                              => -0.062534,
                                                            0.000000);

dri_subscore17 := map(
    (iv_criminal_x_felony in ['Other'])                                  => 0.000000,
    (iv_criminal_x_felony in ['0-0'])                                    => 0.011526,
    (iv_criminal_x_felony in ['1-0', '2-0'])                             => -0.122332,
    (iv_criminal_x_felony in ['3-0'])                                    => -0.255535,
    (iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => -0.327980,
                                                                            0.000000);

dri_subscore18 := map(
    (iv_prof_license_category in ['Other', '-1']) => -0.000784,
    (iv_prof_license_category in ['0', '1', '2']) => 0.002457,
    (iv_prof_license_category in ['3'])           => 0.004761,
    (iv_prof_license_category in ['4'])           => 0.010793,
    (iv_prof_license_category in ['5'])           => 0.142596,
                                                     0.000000);

dri_rawscore := dri_subscore0 +
    dri_subscore1 +
    dri_subscore2 +
    dri_subscore3 +
    dri_subscore4 +
    dri_subscore5 +
    dri_subscore6 +
    dri_subscore7 +
    dri_subscore8 +
    dri_subscore9 +
    dri_subscore10 +
    dri_subscore11 +
    dri_subscore12 +
    dri_subscore13 +
    dri_subscore14 +
    dri_subscore15 +
    dri_subscore16 +
    dri_subscore17 +
    dri_subscore18;

dri_lnoddsscore := dri_rawscore + 1.372836;

dri_probscore := exp(dri_lnoddsscore) / (1 + exp(dri_lnoddsscore));

dbase := 570;

dpts := 50;

dlogit := ln(.80 / .20);

rva1304_2_0 := map(
    rc_decsflag = '1'  => 200,
    iv_riskview_222s 	 => 222,
													round(min(if(max(dpts * (dri_lnoddsscore - dlogit) / ln(2) + dbase, (real)501) = NULL, -NULL, max(dpts * (dri_lnoddsscore - dlogit) / ln(2) + dbase, (real)501)), 900)));

// rc5 := '';

glrc9w := truedid and iv_db001_bankruptcy != '0 - No BK        ';

glrcev := truedid and attr_eviction_count > 0;

glrc9h := truedid and impulse_count > 0;

glrc9g := truedid and iv_ag001_age > 0 and iv_ag001_age < 30;

glrcpv := truedid and iv_pv001_inp_avm_autoval > 0;

glrc9d := truedid and iv_pl002_addrs_per_adl_c6 > 0 or iv_addrs_5yr > 2;

glrc9e := add1_pop and truedid;

glrc9o := hphnpop and add1_pop and (nap_summary in [0, 1, 2, 3, 4]);

glrc98 := truedid and (liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0);

glrc97 := truedid and criminal_count > 0;

glrcbl := 0;

criminal_flag := criminal_count > 0;

lien_unrel_flag := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

bankruptcy_flag := (rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0;

impulse_flag := impulse_count > 0;

eviction_flag := attr_eviction_count > 0;

derog_flag_sum := if(max((integer)criminal_flag, (integer)lien_unrel_flag, (integer)bankruptcy_flag, (integer)impulse_flag, (integer)eviction_flag) = 0, 0, sum((integer)criminal_flag, (integer)lien_unrel_flag, (integer)bankruptcy_flag, (integer)impulse_flag, (integer)eviction_flag));

divptslost_iv_derog_ratio := map(
		not(truedid)				 => 0,
    derog_flag_sum = 0   => 0,
    iv_derog_ratio > 100 => 0,
                            (iv_derog_ratio - dri_subscore14) / derog_flag_sum);

rcvalue9w_1 := 0.014698 - dri_subscore0;

rcvalue9w_2 := divptslost_iv_derog_ratio * (integer)bankruptcy_flag;

rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1, rcvalue9w_2) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1), if(rcvalue9w_2 = NULL, 0, rcvalue9w_2)));

rcvalueev_1 := 0.021448 - dri_subscore1;

rcvalueev_2 := divptslost_iv_derog_ratio * (integer)eviction_flag;

rcvalueev := (integer)glrcev * if(max(rcvalueev_1, rcvalueev_2) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1), if(rcvalueev_2 = NULL, 0, rcvalueev_2)));

rcvalue9h_1 := 0.055261 - dri_subscore2;

rcvalue9h_2 := divptslost_iv_derog_ratio * (integer)impulse_flag;

rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1, rcvalue9h_2) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1), if(rcvalue9h_2 = NULL, 0, rcvalue9h_2)));

rcvalue9g_1 := 0.256480 - dri_subscore3;

rcvalue9g := (integer)glrc9g * if(max(rcvalue9g_1) = NULL, NULL, sum(if(rcvalue9g_1 = NULL, 0, rcvalue9g_1)));

rcvaluepv_1 := 0.061799 - dri_subscore4;

rcvaluepv := (integer)glrcpv * if(max(rcvaluepv_1) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1)));

rcvalue9d_1 := 0.022012 - dri_subscore5;

rcvalue9d_2 := 0.026750 - dri_subscore8;

rcvalue9d_3 := 0.367001 - dri_subscore9;

rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1, rcvalue9d_2, rcvalue9d_3) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1), if(rcvalue9d_2 = NULL, 0, rcvalue9d_2), if(rcvalue9d_3 = NULL, 0, rcvalue9d_3)));

rcvalue9e_1 := 0.112937 - dri_subscore7;

rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1)));

rcvalue9o_1 := 0.058914 - dri_subscore11;

rcvalue9o := (integer)glrc9o * if(max(rcvalue9o_1) = NULL, NULL, sum(if(rcvalue9o_1 = NULL, 0, rcvalue9o_1)));

rcvalue98_1 := 0.085276 - dri_subscore15;

rcvalue98_2 := 0.004554 - dri_subscore16;

rcvalue98_3 := divptslost_iv_derog_ratio * (integer)lien_unrel_flag;

rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1, rcvalue98_2, rcvalue98_3) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1), if(rcvalue98_2 = NULL, 0, rcvalue98_2), if(rcvalue98_3 = NULL, 0, rcvalue98_3)));

rcvalue97_1 := 0.011526 - dri_subscore17;

rcvalue97_2 := divptslost_iv_derog_ratio * (integer)criminal_flag;

rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1, rcvalue97_2) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1), if(rcvalue97_2 = NULL, 0, rcvalue97_2)));

rcvaluebl_1 := 0.282156 - dri_subscore6;

rcvaluebl_2 := 0.035966 - dri_subscore10;

rcvaluebl_3 := 0.018970 - dri_subscore12;

rcvaluebl_4 := 0.096292 - dri_subscore13;

rcvaluebl_5 := 0.142596 - dri_subscore18;

rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3, rcvaluebl_4, rcvaluebl_5) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3), if(rcvaluebl_4 = NULL, 0, rcvaluebl_4), if(rcvaluebl_5 = NULL, 0, rcvaluebl_5)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
	{'9W', RCValue9W},
	{'EV', RCValueEV},
	{'9H', RCValue9H},
	{'9G', RCValue9G},
	{'PV', RCValuePV},
	{'9D', RCValue9D},
	{'9E', RCValue9E},
	{'9O', RCValue9O},
	{'98', RCValue98},
	{'97', RCValue97},
	{'BL', RCValueBL}
    ], ds_layout)(value > 0);

	rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes
	
	rcs_9p1 := rcs_top4[1];
	rcs_9p2 := IF(rcs_top4[2].rc = '' and rcs_top4[1].rc not in ['', '36'] and 500 < rva1304_2_0 AND rva1304_2_0 < 550, 		//If only one reason code is set and it's not '36', set RC2 to '36'
								ROW({'36', NULL}, ds_layout), 
								rcs_top4[2]);
	rcs_9p3 := rcs_top4[3];
	rcs_9p4 := rcs_top4[4];
	
	rcs_9p := rcs_9p1 & rcs_9p2 & rcs_9p3 & rcs_9p4;

	rcs_override := MAP(
											rva1304_2_0 = 200 => DATASET([{'02', NULL}], ds_layout),
											rva1304_2_0 = 222 => DATASET([{'9X', NULL}], ds_layout),
											rva1304_2_0 = 900 => DATASET([{'  ', NULL}], ds_layout),
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
						inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
						rcs_final
						);
					
	zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
	
	reasons := CHOOSEN(ri & zeros, 4); // Keep up to 4 reason codes

//Intermediate variables
	#if(RVA_DEBUG)
	  self.clam															:= le;
		self.sysdate                          := sysdate;
		self.iv_pots_phone                    := iv_pots_phone;
		self.iv_add_apt                       := iv_add_apt;
		self.iv_riskview_222s                 := iv_riskview_222s;
		self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
		self.iv_de001_eviction_recency        := iv_de001_eviction_recency;
		self.email_src_im                     := email_src_im;
		self.iv_ds001_impulse_count           := iv_ds001_impulse_count;
		self._in_dob                          := _in_dob;
		self.yr_in_dob                        := yr_in_dob;
		self.yr_in_dob_int                    := yr_in_dob_int;
		self.age_estimate                     := age_estimate;
		self.iv_ag001_age                     := iv_ag001_age;
		self.iv_pv001_inp_avm_autoval         := iv_pv001_inp_avm_autoval;
		self.iv_pl002_addrs_per_adl_c6        := iv_pl002_addrs_per_adl_c6;
		self.iv_src_property_adl_count        := iv_src_property_adl_count;
		self.iv_addr_non_phn_src_ct           := iv_addr_non_phn_src_ct;
		self.iv_addrs_5yr                     := iv_addrs_5yr;
		self.iv_addrs_per_adl                 := iv_addrs_per_adl;
		self.iv_credit_seeking                := iv_credit_seeking;
		self.ver_phn_inf                      := ver_phn_inf;
		self.ver_phn_nap                      := ver_phn_nap;
		self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
		self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
		self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
		self.iv_email_domain_free_count       := iv_email_domain_free_count;
		self.iv_attr_purchase_recency         := iv_attr_purchase_recency;
		self.iv_derog_ratio                   := iv_derog_ratio;
		self.iv_unreleased_liens_ct           := iv_unreleased_liens_ct;
		self.iv_liens_rel_cj_ct               := iv_liens_rel_cj_ct;
		self.iv_criminal_x_felony             := iv_criminal_x_felony;
		self.iv_prof_license_category         := iv_prof_license_category;
		self.dri_subscore0                    := dri_subscore0;
		self.dri_subscore1                    := dri_subscore1;
		self.dri_subscore2                    := dri_subscore2;
		self.dri_subscore3                    := dri_subscore3;
		self.dri_subscore4                    := dri_subscore4;
		self.dri_subscore5                    := dri_subscore5;
		self.dri_subscore6                    := dri_subscore6;
		self.dri_subscore7                    := dri_subscore7;
		self.dri_subscore8                    := dri_subscore8;
		self.dri_subscore9                    := dri_subscore9;
		self.dri_subscore10                   := dri_subscore10;
		self.dri_subscore11                   := dri_subscore11;
		self.dri_subscore12                   := dri_subscore12;
		self.dri_subscore13                   := dri_subscore13;
		self.dri_subscore14                   := dri_subscore14;
		self.dri_subscore15                   := dri_subscore15;
		self.dri_subscore16                   := dri_subscore16;
		self.dri_subscore17                   := dri_subscore17;
		self.dri_subscore18                   := dri_subscore18;
		self.dri_rawscore                     := dri_rawscore;
		self.dri_lnoddsscore                  := dri_lnoddsscore;
		self.dri_probscore                    := dri_probscore;
		self.dbase                            := dbase;
		self.dpts                             := dpts;
		self.dlogit                           := dlogit;
		self.rva1304_2_0                      := rva1304_2_0;
		// self.rc5                              := rc5;
		self.glrc9w                           := glrc9w;
		self.glrcev                           := glrcev;
		self.glrc9h                           := glrc9h;
		self.glrc9g                           := glrc9g;
		self.glrcpv                           := glrcpv;
		self.glrc9d                           := glrc9d;
		self.glrc9e                           := glrc9e;
		self.glrc9o                           := glrc9o;
		self.glrc98                           := glrc98;
		self.glrc97                           := glrc97;
		self.glrcbl                           := glrcbl;
		self.criminal_flag                    := criminal_flag;
		self.lien_unrel_flag                  := lien_unrel_flag;
		self.bankruptcy_flag                  := bankruptcy_flag;
		self.impulse_flag                     := impulse_flag;
		self.eviction_flag                    := eviction_flag;
		self.derog_flag_sum                   := derog_flag_sum;
		self.divptslost_iv_derog_ratio        := divptslost_iv_derog_ratio;
		self.rcvalue9w_1                      := rcvalue9w_1;
		self.rcvalue9w_2                      := rcvalue9w_2;
		self.rcvalue9w                        := rcvalue9w;
		self.rcvalueev_1                      := rcvalueev_1;
		self.rcvalueev_2                      := rcvalueev_2;
		self.rcvalueev                        := rcvalueev;
		self.rcvalue9h_1                      := rcvalue9h_1;
		self.rcvalue9h_2                      := rcvalue9h_2;
		self.rcvalue9h                        := rcvalue9h;
		self.rcvalue9g_1                      := rcvalue9g_1;
		self.rcvalue9g                        := rcvalue9g;
		self.rcvaluepv_1                      := rcvaluepv_1;
		self.rcvaluepv                        := rcvaluepv;
		self.rcvalue9d_1                      := rcvalue9d_1;
		self.rcvalue9d_2                      := rcvalue9d_2;
		self.rcvalue9d_3                      := rcvalue9d_3;
		self.rcvalue9d                        := rcvalue9d;
		self.rcvalue9e_1                      := rcvalue9e_1;
		self.rcvalue9e                        := rcvalue9e;
		self.rcvalue9o_1                      := rcvalue9o_1;
		self.rcvalue9o                        := rcvalue9o;
		self.rcvalue98_1                      := rcvalue98_1;
		self.rcvalue98_2                      := rcvalue98_2;
		self.rcvalue98_3                      := rcvalue98_3;
		self.rcvalue98                        := rcvalue98;
		self.rcvalue97_1                      := rcvalue97_1;
		self.rcvalue97_2                      := rcvalue97_2;
		self.rcvalue97                        := rcvalue97;
		self.rcvaluebl_1                      := rcvaluebl_1;
		self.rcvaluebl_2                      := rcvaluebl_2;
		self.rcvaluebl_3                      := rcvaluebl_3;
		self.rcvaluebl_4                      := rcvaluebl_4;
		self.rcvaluebl_5                      := rcvaluebl_5;
		self.rcvaluebl                        := rcvaluebl;
		self.rc1                              := if(reasons[1].hri = '00', '', reasons[1].hri);
		self.rc2                              := if(reasons[2].hri = '00', '', reasons[2].hri);
		self.rc3                              := if(reasons[3].hri = '00', '', reasons[3].hri);
		self.rc4                              := if(reasons[4].hri = '00', '', reasons[4].hri);
	#end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		
		self.score := MAP(
											reasons[1].hri IN ['91','92','93','94'] 			=> (STRING3)((INTEGER)reasons[1].hri + 10),
											reasons[1].hri='35' => '100',
											(string3)RVA1304_2_0
										);
END;

		model := project( clam, doModel(left) );

		return model;
END;