//Epic Loan Systems custom payment score.  Note - uses 'returncode' and 'pay_frequency' fields from the customer file as variables.

import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVC1210_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE, BOOLEAN xmlPreScreenOptOut = FALSE, STRING retcode, STRING payfreq ) := FUNCTION

  RVC_DEBUG := false;

  #if(RVC_DEBUG)
    layout_debug := record
      integer  sysdate                          ;  //sysdate;
			boolean  iv_add_apt                       ;  //iv_add_apt;
			integer  _reported_dob                    ;  //_reported_dob;
			integer  reported_age                     ;  //reported_age;
			integer  iv_combined_age                  ;  //iv_combined_age;
			integer  first_seen_li                    ;  //first_seen_li;
			integer  first_seen_l2                    ;  //first_seen_l2;
			integer  src_liens_adl_fseen              ;  //src_liens_adl_fseen;
			integer  _src_liens_adl_fseen             ;  //_src_liens_adl_fseen;
			integer  iv_mos_src_liens_adl_fseen       ;  //iv_mos_src_liens_adl_fseen;
			integer  iv_inp_addr_avm_change_3yr       ;  //iv_inp_addr_avm_change_3yr;
			integer  bst_addr_date_first_seen         ;  //bst_addr_date_first_seen;
			integer  iv_mos_since_bst_addr_fseen      ;  //iv_mos_since_bst_addr_fseen;
			integer  iv_bst_addr_building_area        ;  //iv_bst_addr_building_area;
			integer  iv_dist_bst_addr_to_prv_addr     ;  //iv_dist_bst_addr_to_prv_addr;
			integer  iv_addrs_5yr                     ;  //iv_addrs_5yr;
			integer  iv_ssns_per_adl                  ;  //iv_ssns_per_adl;
			integer  iv_phones_per_sfd_addr           ;  //iv_phones_per_sfd_addr;
			integer  iv_inq_auto_recency              ;  //iv_inq_auto_recency;
			integer  iv_inq_highriskcredit_recency    ;  //iv_inq_highriskcredit_recency;
			integer  iv_derog_diff                    ;  //iv_derog_diff;
			string   iv_bk_disposition_lvl            ;  //iv_bk_disposition_lvl;
			integer  iv_bk_disposed_historical_count  ;  //iv_bk_disposed_historical_count;
			integer  iv_liens_unrel_lt_ct             ;  //iv_liens_unrel_lt_ct;
			integer  iv_liens_unrel_ot_ct             ;  //iv_liens_unrel_ot_ct;
			string   iv_ams_file_type                 ;  //iv_ams_file_type;
			integer  iv_wealth_index                  ;  //iv_wealth_index;
			integer  iv_estimated_income              ;  //iv_estimated_income;
			integer  iv_pb_total_orders               ;  //iv_pb_total_orders;
			real     ep_subscore0                     ;  //ep_subscore0;
			real     ep_subscore1                     ;  //ep_subscore1;
			real     ep_subscore2                     ;  //ep_subscore2;
			real     ep_subscore3                     ;  //ep_subscore3;
			real     ep_subscore4                     ;  //ep_subscore4;
			real     ep_subscore5                     ;  //ep_subscore5;
			real     ep_subscore6                     ;  //ep_subscore6;
			real     ep_subscore7                     ;  //ep_subscore7;
			real     ep_subscore8                     ;  //ep_subscore8;
			real     ep_subscore9                     ;  //ep_subscore9;
			real     ep_subscore10                    ;  //ep_subscore10;
			real     ep_subscore11                    ;  //ep_subscore11;
			real     ep_subscore12                    ;  //ep_subscore12;
			real     ep_subscore13                    ;  //ep_subscore13;
			real     ep_subscore14                    ;  //ep_subscore14;
			real     ep_subscore15                    ;  //ep_subscore15;
			real     ep_subscore16                    ;  //ep_subscore16;
			real     ep_subscore17                    ;  //ep_subscore17;
			real     ep_subscore18                    ;  //ep_subscore18;
			real     ep_subscore19                    ;  //ep_subscore19;
			real     ep_subscore20                    ;  //ep_subscore20;
			real     ep_rawscore                      ;  //ep_rawscore;
			real     ep_lnoddsscore                   ;  //ep_lnoddsscore;
			real     ep_probscore                     ;  //ep_probscore;
			boolean  ssn_deceased                     ;  //ssn_deceased;
			boolean  riskview_222s                    ;  //riskview_222s;
			integer  base                             ;  //base;
			integer  point                            ;  //point;
			real     odds                             ;  //odds;
			integer  rvc1210_1_0                      ;  //rvc1210_1_0;
			boolean  glrc97                           ;  //glrc97;
			boolean  glrc98_1                         ;  //glrc98_1;
			boolean  glrc98_2                         ;  //glrc98_2;
			boolean  glrc9c                           ;  //glrc9c;
			boolean  glrc9d                           ;  //glrc9d;
			boolean  glrc9i                           ;  //glrc9i;
			boolean  glrc9m                           ;  //glrc9m;
			boolean  glrc9q_1                         ;  //glrc9q_1;
			boolean  glrc9q_2                         ;  //glrc9q_2;
			boolean  glrc9w                           ;  //glrc9w;
			boolean  glrc9y                           ;  //glrc9y;
			boolean  glrcms                           ;  //glrcms;
			boolean  glrcbl                           ;  //glrcbl;
			boolean  criminal_flag                    ;  //criminal_flag;
			boolean  lien_unrel_flag                  ;  //lien_unrel_flag;
			boolean  bankruptcy_flag                  ;  //bankruptcy_flag;
			real     divptslost_iv_derog_diff         ;  //divptslost_iv_derog_diff;
			real     rcvalue97_1                      ;  //rcvalue97_1;
			real     rcvalue97                        ;  //rcvalue97;
			real     rcvalue98_1                      ;  //rcvalue98_1;
			real     rcvalue98_2                      ;  //rcvalue98_2;
			real     rcvalue98_3                      ;  //rcvalue98_3;
			real     rcvalue98_4                      ;  //rcvalue98_4;
			real     rcvalue98                        ;  //rcvalue98;
			real     rcvalue9c_1                      ;  //rcvalue9c_1;
			real     rcvalue9c                        ;  //rcvalue9c;
			real     rcvalue9d_1                      ;  //rcvalue9d_1;
			real     rcvalue9d                        ;  //rcvalue9d;
			real     rcvalue9i_1                      ;  //rcvalue9i_1;
			real     rcvalue9i                        ;  //rcvalue9i;
			real     rcvalue9m_1                      ;  //rcvalue9m_1;
			real     rcvalue9m_2                      ;  //rcvalue9m_2;
			real     rcvalue9m                        ;  //rcvalue9m;
			real     rcvalue9q_1                      ;  //rcvalue9q_1;
			real     rcvalue9q_2                      ;  //rcvalue9q_2;
			real     rcvalue9q                        ;  //rcvalue9q;
			real     rcvalue9w_1                      ;  //rcvalue9w_1;
			real     rcvalue9w_2                      ;  //rcvalue9w_2;
			real     rcvalue9w                        ;  //rcvalue9w;
			real     rcvalue9y_1                      ;  //rcvalue9y_1;
			real     rcvalue9y                        ;  //rcvalue9y;
			real     rcvaluems_1                      ;  //rcvaluems_1;
			real     rcvaluems                        ;  //rcvaluems;
			real     rcvaluebl_1                      ;  //rcvaluebl_1;
			real     rcvaluebl_2                      ;  //rcvaluebl_2;
			real     rcvaluebl_3                      ;  //rcvaluebl_3;
			real     rcvaluebl_4                      ;  //rcvaluebl_4;
			real     rcvaluebl_5                      ;  //rcvaluebl_5;
			real     rcvaluebl                        ;  //rcvaluebl;
			string   rc1                              ;  //rc1;
			string   rc2                              ;  //rc2;
			string   rc3                              ;  //rc3;
			string   rc4                              ;  //rc4;
			string   rc5                              ;  //rc5;
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
		returncode                       := retcode; 
		pay_frequency                    := payfreq; 
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
		addrpop                          := le.input_validation.address;
		ssnlength                        := le.input_validation.ssn_length;
		dobpop                           := le.input_validation.dateofbirth;
		age                              := le.name_verification.age;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_avm_automated_valuation     := le.avm.Input_Address_Information.avm_automated_valuation;
		add1_avm_automated_valuation_4   := le.avm.Input_Address_Information.avm_automated_valuation4;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
		add1_building_area               := le.address_verification.input_address_information.building_area;
		add1_pop                         := le.addrpop;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
		add2_building_area               := le.address_verification.address_history_1.building_area;
		add2_date_first_seen             := le.address_verification.address_history_1.date_first_seen;
		addrs_5yr                        := le.other_address_info.addrs_last_5years;
		unique_addr_count                := le.address_history_summary.unique_addr_cnt;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		phones_per_addr                  := le.velocity_counters.phones_per_addr;
		inq_auto_count                   := le.acc_logs.auto.counttotal;
		inq_auto_count01                 := le.acc_logs.auto.count01;
		inq_auto_count03                 := le.acc_logs.auto.count03;
		inq_auto_count06                 := le.acc_logs.auto.count06;
		inq_auto_count12                 := le.acc_logs.auto.count12;
		inq_auto_count24                 := le.acc_logs.auto.count24;
		inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
		inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
		inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
		inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
		inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
		inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
		pb_total_orders                  := le.ibehavior.total_number_of_orders;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_num_nonderogs               := le.source_verification.num_nonderogs;
		bankrupt                         := le.bjl.bankrupt;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
		liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
		criminal_count                   := le.bjl.criminal_count;
		ams_age                          := (integer)le.student.age;
		ams_college_code                 := le.student.college_code;
		ams_college_type                 := le.student.college_type;
		ams_file_type                    := le.student.file_type2;  //fyi - converted code had 'file_type', changed to 'file_type2' 
		wealth_index                     := le.wealth_indicator;
		input_dob_age            				 := (integer)le.shell_input.age;
		inferred_age                     := le.inferred_age;
		reported_dob                     := le.reported_dob;
		estimated_income                 := le.estimated_income;

NULL := -999999999;

INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

iv_add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

_reported_dob := common.sas_date((string)(reported_dob));

reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

iv_combined_age := map(
    not(truedid or dobpop) => NULL,
    age > 0                => age,
    input_dob_age > 0      => input_dob_age,
    inferred_age > 0       => inferred_age,
    reported_age > 0       => reported_age,
    ams_age > 0            => ams_age,
                              -1);

first_seen_li := if(Models.Common.findw_cpp(ver_sources, 'LI' , ', ', 'E') > 0, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'LI' , ', ', 'E'), ','), NULL);

first_seen_l2 := if(Models.Common.findw_cpp(ver_sources, 'L2' , ', ', 'E') > 0, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'L2' , ', ', 'E'), ','), NULL);

src_liens_adl_fseen := if(max(first_seen_li, first_seen_l2) = NULL, NULL, min(if(first_seen_li = NULL, -NULL, first_seen_li), if(first_seen_l2 = NULL, -NULL, first_seen_l2)));

_src_liens_adl_fseen := common.sas_date((string)(src_liens_adl_fseen));

iv_mos_src_liens_adl_fseen := map(
    not(truedid)                => NULL,
    _src_liens_adl_fseen = NULL => -1,
                                   if ((sysdate - _src_liens_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_liens_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_liens_adl_fseen) / (365.25 / 12))));

iv_inp_addr_avm_change_3yr := map(
    not(add1_pop)                                                           => NULL,
    add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_4 > 0 => add1_avm_automated_valuation - add1_avm_automated_valuation_4,
                                                                               NULL);

bst_addr_date_first_seen := if(add1_isbestmatch, common.sas_date((string)(add1_date_first_seen)), common.sas_date((string)(add2_date_first_seen)));

iv_mos_since_bst_addr_fseen := map(
    not(truedid)                    => NULL,
    bst_addr_date_first_seen = NULL => -1,
                                       if ((sysdate - bst_addr_date_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - bst_addr_date_first_seen) / (365.25 / 12)), roundup((sysdate - bst_addr_date_first_seen) / (365.25 / 12))));

iv_bst_addr_building_area := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_building_area,
                        add2_building_area);

iv_dist_bst_addr_to_prv_addr := map(
    not(truedid)     => NULL,
    add1_isbestmatch => dist_a1toa2,
                        dist_a2toa3);

iv_addrs_5yr := map(
    not(truedid)          => NULL,
    unique_addr_count = 0 => -1,
                             addrs_5yr);

iv_ssns_per_adl := if(not(truedid), NULL, ssns_per_adl);

iv_phones_per_sfd_addr := map(
    not(add1_pop) => NULL,
    iv_add_apt    => -1,
                     phones_per_addr);

iv_inq_auto_recency := map(
    not(truedid)     			=> NULL,
    inq_auto_count01 >0		=> 1,
    inq_auto_count03 >0		=> 3,
    inq_auto_count06 >0		=> 6,
    inq_auto_count12 >0		=> 12,
    inq_auto_count24 >0		=> 24,
    inq_auto_count   >0		=> 99,
														 0);

iv_inq_highriskcredit_recency := map(
    not(truedid)               			=> NULL,
    inq_highRiskCredit_count01 >0		=> 1,
    inq_highRiskCredit_count03 >0		=> 3,
    inq_highRiskCredit_count06 >0		=> 6,
    inq_highRiskCredit_count12 >0		=> 12,
    inq_highRiskCredit_count24 >0		=> 24,
    inq_highRiskCredit_count   >0		=> 99,
																			 0);

iv_derog_diff := if(not(truedid), NULL, min(if(max(attr_num_nonderogs - attr_total_number_derogs, -10) = NULL, -NULL, max(attr_num_nonderogs - attr_total_number_derogs, -10)), 10));

iv_bk_disposition_lvl := map(
    not(truedid or (integer)ssnlength > 0)                                                                                               => '          ',
    (disposition in ['Discharge NA', 'Discharged'])                                                                             => 'Discharged',
    (disposition in ['Dismissed'])                                                                                              => 'Dismissed ',
    (rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => 'OtherBK  ',
                                                                                                                                   'No BK');

iv_bk_disposed_historical_count := if(not(truedid), NULL, bk_disposed_historical_count);

iv_liens_unrel_lt_ct := if(not(truedid), NULL, liens_unrel_LT_ct);

iv_liens_unrel_ot_ct := if(not(truedid), NULL, liens_unrel_OT_ct);

iv_ams_file_type := map(
    not(truedid)         					=> '  ',
    ams_file_type = '' 						=> '-1',
																			ams_file_type);

iv_wealth_index := if(not(truedid), NULL, (integer)wealth_index);

iv_estimated_income := if(not(truedid), NULL, estimated_income);

iv_pb_total_orders := map(
    not(truedid)           					=> NULL,
    pb_total_orders = '' 						=> -1,
																			 (integer)pb_total_orders);

ep_subscore0 := map(
    (returncode in ['Other'])                                                                                                                      => 0.000000,
    (returncode in ['C01', 'C02', 'C03', 'C05', 'C06', 'R00', 'R02', 'R03', 'R04', 'R06', 'R07', 'R08', 'R09', 'R10', 'R16', 'R20', 'R51', 'VDD']) => -0.289654,
    (returncode in ['R01'])                                                                                                                        => 0.062818,
    (returncode in ['NULL'])                                                                                                                       => 3.595066,
                                                                                                                                                      0.000000);

ep_subscore1 := map(
    (pay_frequency in ['Other'])                   => 0.000000,
    (pay_frequency in ['Monthly', 'Semi-Monthly']) => -0.194581,
    (pay_frequency in ['Bi-Weekly'])               => -0.076984,
    (pay_frequency in ['Weekly'])                  => 0.764131,
                                                      0.000000);

ep_subscore2 := map(
    (iv_bk_disposition_lvl in ['Other'])      => -0.000000,
    (iv_bk_disposition_lvl in ['Dismissed'])  => -0.237773,
    (iv_bk_disposition_lvl in ['No BK'])      => -0.040542,
    (iv_bk_disposition_lvl in ['Discharged']) => 0.183430,
    (iv_bk_disposition_lvl in ['OtherBK'])    => 0.346039,
                                                 -0.000000);

ep_subscore3 := map(
    NULL < iv_inq_auto_recency AND iv_inq_auto_recency < 1 => 0.047854,
    1 <= iv_inq_auto_recency AND iv_inq_auto_recency < 6   => -0.208451,
    6 <= iv_inq_auto_recency AND iv_inq_auto_recency < 12  => -0.170033,
    12 <= iv_inq_auto_recency                              => -0.033364,
                                                              0.000000);

ep_subscore4 := map(
    NULL < iv_bst_addr_building_area AND iv_bst_addr_building_area < 1797  => 0.025385,
    1797 <= iv_bst_addr_building_area AND iv_bst_addr_building_area < 2058 => -0.330823,
    2058 <= iv_bst_addr_building_area AND iv_bst_addr_building_area < 2613 => -0.215148,
    2613 <= iv_bst_addr_building_area                                      => 0.027355,
                                                                              -0.000000);

ep_subscore5 := map(
    NULL < iv_mos_since_bst_addr_fseen AND iv_mos_since_bst_addr_fseen < 0  => 0.000000,
    0 <= iv_mos_since_bst_addr_fseen AND iv_mos_since_bst_addr_fseen < 13   => -0.128237,
    13 <= iv_mos_since_bst_addr_fseen AND iv_mos_since_bst_addr_fseen < 37  => 0.034884,
    37 <= iv_mos_since_bst_addr_fseen AND iv_mos_since_bst_addr_fseen < 178 => 0.037967,
    178 <= iv_mos_since_bst_addr_fseen                                      => 0.134715,
                                                                               0.000000);

ep_subscore6 := map(
    NULL < iv_addrs_5yr AND iv_addrs_5yr < 0 => 0.000000,
    0 <= iv_addrs_5yr AND iv_addrs_5yr < 4   => 0.055642,
    4 <= iv_addrs_5yr AND iv_addrs_5yr < 5   => -0.071500,
    5 <= iv_addrs_5yr                        => -0.122365,
                                                0.000000);

ep_subscore7 := map(
    NULL < iv_mos_src_liens_adl_fseen AND iv_mos_src_liens_adl_fseen < 0 => 0.009608,
    0 <= iv_mos_src_liens_adl_fseen AND iv_mos_src_liens_adl_fseen < 18  => 0.116651,
    18 <= iv_mos_src_liens_adl_fseen AND iv_mos_src_liens_adl_fseen < 74 => 0.013403,
    74 <= iv_mos_src_liens_adl_fseen                                     => -0.222961,
                                                                            0.000000);

ep_subscore8 := map(
    NULL < iv_phones_per_sfd_addr AND iv_phones_per_sfd_addr < 1 => -0.031621,
    1 <= iv_phones_per_sfd_addr AND iv_phones_per_sfd_addr < 2   => 0.109213,
    2 <= iv_phones_per_sfd_addr                                  => -0.134394,
                                                                    0.000000);

ep_subscore9 := map(
    NULL < iv_derog_diff AND iv_derog_diff < -2 => -0.046595,
    -2 <= iv_derog_diff AND iv_derog_diff < 5   => -0.007078,
    5 <= iv_derog_diff                          => 0.422025,
                                                   -0.000000);

ep_subscore10 := map(
    NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => 0.020812,
    1 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 6   => -0.087689,
    6 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 12  => -0.028591,
    12 <= iv_inq_highriskcredit_recency                                        => 0.229562,
                                                                                  -0.000000);

ep_subscore11 := map(
    NULL < iv_ssns_per_adl AND iv_ssns_per_adl < 2 => 0.047291,
    2 <= iv_ssns_per_adl AND iv_ssns_per_adl < 3   => -0.080817,
    3 <= iv_ssns_per_adl                           => -0.105884,
                                                      0.000000);

ep_subscore12 := map(
    NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => -0.061442,
    1 <= iv_pb_total_orders AND iv_pb_total_orders < 4   => 0.039091,
    4 <= iv_pb_total_orders AND iv_pb_total_orders < 14  => 0.043739,
    14 <= iv_pb_total_orders                             => 0.177890,
                                                            0.000000);

ep_subscore13 := map(
    NULL < iv_wealth_index AND iv_wealth_index < 1 => 0.014417,
    1 <= iv_wealth_index AND iv_wealth_index < 2   => -0.155639,
    2 <= iv_wealth_index AND iv_wealth_index < 4   => -0.017162,
    4 <= iv_wealth_index AND iv_wealth_index < 5   => -0.016967,
    5 <= iv_wealth_index                           => 0.247168,
                                                      0.000000);

ep_subscore14 := map(
    NULL < iv_dist_bst_addr_to_prv_addr AND iv_dist_bst_addr_to_prv_addr < 546   => -0.014699,
    546 <= iv_dist_bst_addr_to_prv_addr AND iv_dist_bst_addr_to_prv_addr < 1407  => 0.136706,
    1407 <= iv_dist_bst_addr_to_prv_addr AND iv_dist_bst_addr_to_prv_addr < 9999 => 0.323411,
    9999 <= iv_dist_bst_addr_to_prv_addr                                         => 0.000000,
                                                                                    0.000000);

ep_subscore15 := map(
    NULL < iv_inp_addr_avm_change_3yr AND iv_inp_addr_avm_change_3yr < -100630    => -0.212641,
    -100630 <= iv_inp_addr_avm_change_3yr AND iv_inp_addr_avm_change_3yr < -42099 => -0.059975,
    -42099 <= iv_inp_addr_avm_change_3yr AND iv_inp_addr_avm_change_3yr < -7693   => 0.028484,
    -7693 <= iv_inp_addr_avm_change_3yr                                           => 0.101296,
                                                                                     0.000000);

ep_subscore16 := map(
    (iv_ams_file_type in ['Other'])             => -0.000000,
    (iv_ams_file_type in ['-1', 'A', 'C', 'H']) => 0.021046,
    (iv_ams_file_type in ['M'])                 => -0.135104,
                                                   -0.000000);

ep_subscore17 := map(
    NULL < iv_bk_disposed_historical_count AND iv_bk_disposed_historical_count < 1 => -0.018667,
    1 <= iv_bk_disposed_historical_count                                           => 0.097753,
                                                                                      0.000000);

ep_subscore18 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 35000 => -0.019656,
    35000 <= iv_estimated_income                               => 0.077106,
                                                                  0.000000);

ep_subscore19 := map(
    NULL < iv_liens_unrel_ot_ct AND iv_liens_unrel_ot_ct < 1 => 0.005360,
    1 <= iv_liens_unrel_ot_ct                                => -0.049457,
                                                                -0.000000);

ep_subscore20 := map(
    NULL < iv_liens_unrel_lt_ct AND iv_liens_unrel_lt_ct < 1 => 0.003600,
    1 <= iv_liens_unrel_lt_ct                                => -0.037917,
                                                                0.000000);

ep_rawscore := ep_subscore0 +
    ep_subscore1 +
    ep_subscore2 +
    ep_subscore3 +
    ep_subscore4 +
    ep_subscore5 +
    ep_subscore6 +
    ep_subscore7 +
    ep_subscore8 +
    ep_subscore9 +
    ep_subscore10 +
    ep_subscore11 +
    ep_subscore12 +
    ep_subscore13 +
    ep_subscore14 +
    ep_subscore15 +
    ep_subscore16 +
    ep_subscore17 +
    ep_subscore18 +
    ep_subscore19 +
    ep_subscore20;

ep_lnoddsscore := ep_rawscore + -1.042998;

ep_probscore := exp(ep_lnoddsscore) / (1 + exp(ep_lnoddsscore));

ssn_deceased := rc_decsflag = '1' or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',');

riskview_222s := 	riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

base := 700;

point := 40;

odds := .2483 / (1 - .2483);

rvc1210_1_0 := map(
    ssn_deceased  => 200,
    riskview_222s => 222,
                     min(if(max(round(point * (ln(ep_probscore / (1 - ep_probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (ln(ep_probscore / (1 - ep_probscore)) - ln(odds)) / ln(2) + base), 501)), 900));

glrc97 := criminal_count > 0;

glrc98_1 := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'L2', ',') or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'LI', ',') or liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

glrc98_2 := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

glrc9c := addrpop;

glrc9d := truedid and addrs_5yr > 0;

glrc9i := 18 <= iv_combined_age AND iv_combined_age <= 25 and ams_college_code = '' and ams_college_type = '';

glrc9m := (integer)wealth_index < 6;

glrc9q_1 := inq_auto_count12 > 0;

glrc9q_2 := 0 < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 12;

glrc9w := (rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0;

glrc9y := (integer)pb_total_orders < 1;

glrcms := truedid and ssns_per_adl > 2;

glrcbl := 0;

criminal_flag := criminal_count > 0;

lien_unrel_flag := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

bankruptcy_flag := (rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0;

divptslost_iv_derog_diff := if(if(max((integer)criminal_flag, (integer)lien_unrel_flag, (integer)bankruptcy_flag) = NULL, NULL, sum((integer)criminal_flag, (integer)lien_unrel_flag, (integer)bankruptcy_flag)) = 0, 0, (0.422025 - ep_subscore9) / if(max((integer)criminal_flag, (integer)lien_unrel_flag, (integer)bankruptcy_flag) = NULL, NULL, sum((integer)criminal_flag, (integer)lien_unrel_flag, (integer)bankruptcy_flag)));

rcvalue97_1 := (integer)criminal_flag * divptslost_iv_derog_diff;

rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1)));

rcvalue98_1 := 0.116651 - ep_subscore7;

rcvalue98_2 := (integer)lien_unrel_flag * divptslost_iv_derog_diff;

rcvalue98_3 := 0.014372 - ep_subscore19;

rcvalue98_4 := 0.001368 - ep_subscore20;

rcvalue98 := (integer)glrc98_1 * if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1))) + (integer)glrc98_2 * if(max(rcvalue98_2, rcvalue98_3, rcvalue98_4) = NULL, NULL, sum(if(rcvalue98_2 = NULL, 0, rcvalue98_2), if(rcvalue98_3 = NULL, 0, rcvalue98_3), if(rcvalue98_4 = NULL, 0, rcvalue98_4)));

rcvalue9c_1 := 0.134715 - ep_subscore5;

rcvalue9c := (integer)glrc9c * if(max(rcvalue9c_1) = NULL, NULL, sum(if(rcvalue9c_1 = NULL, 0, rcvalue9c_1)));

rcvalue9d_1 := 0.055642 - ep_subscore6;

rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

rcvalue9i_1 := 0.021046 - ep_subscore16;

rcvalue9i := (integer)glrc9i * if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));

rcvalue9m_1 := 0.247168 - ep_subscore13;

rcvalue9m_2 := 0.077106 - ep_subscore18;

rcvalue9m := (integer)glrc9m * if(max(rcvalue9m_1, rcvalue9m_2) = NULL, NULL, sum(if(rcvalue9m_1 = NULL, 0, rcvalue9m_1), if(rcvalue9m_2 = NULL, 0, rcvalue9m_2)));

rcvalue9q_1 := 0.047854 - ep_subscore3;

rcvalue9q_2 := 0.229562 - ep_subscore10;

rcvalue9q := (integer)glrc9q_1 * if(max(rcvalue9q_1) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1))) + (integer)glrc9q_2 * if(max(rcvalue9q_2) = NULL, NULL, sum(if(rcvalue9q_2 = NULL, 0, rcvalue9q_2)));

rcvalue9w_1 := 0.346039 - ep_subscore2;

rcvalue9w_2 := (integer)bankruptcy_flag * divptslost_iv_derog_diff;

rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1, rcvalue9w_2) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1), if(rcvalue9w_2 = NULL, 0, rcvalue9w_2)));

// rcvalue9y_1 := 0.17789 - ep_subscore12;
rcvalue9y_1 := 0;  // hard code this to 0 for iBehavior reason codes to stop returning

rcvalue9y := (integer)glrc9y * if(max(rcvalue9y_1) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1)));

rcvaluems_1 := 0.047291 - ep_subscore11;

rcvaluems := (integer)glrcms * if(max(rcvaluems_1) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1)));

rcvaluebl_1 := 0.027355 - ep_subscore4;

rcvaluebl_2 := 0.109213 - ep_subscore8;

rcvaluebl_3 := 0.323411 - ep_subscore14;

rcvaluebl_4 := 0.101296 - ep_subscore15;

rcvaluebl_5 := 0.097753 - ep_subscore17;

rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3, rcvaluebl_4, rcvaluebl_5) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3), if(rcvaluebl_4 = NULL, 0, rcvaluebl_4), if(rcvaluebl_5 = NULL, 0, rcvaluebl_5)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
	{'97', RCValue97},
	{'98', RCValue98},
	{'9C', RCValue9C},
	{'9D', RCValue9D},
	{'9I', RCValue9I},
	{'9M', RCValue9M},
	{'9Q', RCValue9Q},
	{'9W', RCValue9W},
	{'9Y', RCValue9Y},
	{'MS', RCValueMS},
	{'BL', RCValueBL}
    ], ds_layout)(value > 0);

	rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes

	rcs_9q1 := rcs_top4[1];
	rcs_9q2 := rcs_top4[2];
	rcs_9q3 := rcs_top4[3];
	rcs_9q4 := rcs_top4[4];
	rcs_9q5 := IF((glrc9q_1 or glrc9q_2) AND NOT EXISTS(rcs_top4 (rc = '9Q')),  // Check to see if RC 9Q is a part of the score, but not in the first 4 RC's
								DATASET([{'9Q', NULL}], ds_layout)); 													// If so - make it the 5th reason code.
	
	rcs_9q := rcs_9q1 & rcs_9q2  & rcs_9q3 & rcs_9q4 & rcs_9q5;
	rcs_override := MAP(
											rvc1210_1_0 = 200 => DATASET([{'02', NULL}], ds_layout),
											rvc1210_1_0 = 222 => DATASET([{'9X', NULL}], ds_layout),
											rvc1210_1_0 = 900 => DATASET([{'  ', NULL}], ds_layout),
											NOT EXISTS(rcs_9q(rc != '')) => DATASET([{'36', NULL}], ds_layout),
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

	#if(RVC_DEBUG)
	  self.clam															:= le;
		self.sysdate                          := sysdate;
		self.iv_add_apt                       := iv_add_apt;
		self._reported_dob                    := _reported_dob;
		self.reported_age                     := reported_age;
		self.iv_combined_age                  := iv_combined_age;
		self.first_seen_li                    := first_seen_li;
		self.first_seen_l2                    := first_seen_l2;
		self.src_liens_adl_fseen              := src_liens_adl_fseen;
		self._src_liens_adl_fseen             := _src_liens_adl_fseen;
		self.iv_mos_src_liens_adl_fseen       := iv_mos_src_liens_adl_fseen;
		self.iv_inp_addr_avm_change_3yr       := iv_inp_addr_avm_change_3yr;
		self.bst_addr_date_first_seen         := bst_addr_date_first_seen;
		self.iv_mos_since_bst_addr_fseen      := iv_mos_since_bst_addr_fseen;
		self.iv_bst_addr_building_area        := iv_bst_addr_building_area;
		self.iv_dist_bst_addr_to_prv_addr     := iv_dist_bst_addr_to_prv_addr;
		self.iv_addrs_5yr                     := iv_addrs_5yr;
		self.iv_ssns_per_adl                  := iv_ssns_per_adl;
		self.iv_phones_per_sfd_addr           := iv_phones_per_sfd_addr;
		self.iv_inq_auto_recency              := iv_inq_auto_recency;
		self.iv_inq_highriskcredit_recency    := iv_inq_highriskcredit_recency;
		self.iv_derog_diff                    := iv_derog_diff;
		self.iv_bk_disposition_lvl            := iv_bk_disposition_lvl;
		self.iv_bk_disposed_historical_count  := iv_bk_disposed_historical_count;
		self.iv_liens_unrel_lt_ct             := iv_liens_unrel_lt_ct;
		self.iv_liens_unrel_ot_ct             := iv_liens_unrel_ot_ct;
		self.iv_ams_file_type                 := iv_ams_file_type;
		self.iv_wealth_index                  := iv_wealth_index;
		self.iv_estimated_income              := iv_estimated_income;
		self.iv_pb_total_orders               := iv_pb_total_orders;
		self.ep_subscore0                     := ep_subscore0;
		self.ep_subscore1                     := ep_subscore1;
		self.ep_subscore2                     := ep_subscore2;
		self.ep_subscore3                     := ep_subscore3;
		self.ep_subscore4                     := ep_subscore4;
		self.ep_subscore5                     := ep_subscore5;
		self.ep_subscore6                     := ep_subscore6;
		self.ep_subscore7                     := ep_subscore7;
		self.ep_subscore8                     := ep_subscore8;
		self.ep_subscore9                     := ep_subscore9;
		self.ep_subscore10                    := ep_subscore10;
		self.ep_subscore11                    := ep_subscore11;
		self.ep_subscore12                    := ep_subscore12;
		self.ep_subscore13                    := ep_subscore13;
		self.ep_subscore14                    := ep_subscore14;
		self.ep_subscore15                    := ep_subscore15;
		self.ep_subscore16                    := ep_subscore16;
		self.ep_subscore17                    := ep_subscore17;
		self.ep_subscore18                    := ep_subscore18;
		self.ep_subscore19                    := ep_subscore19;
		self.ep_subscore20                    := ep_subscore20;
		self.ep_rawscore                      := ep_rawscore;
		self.ep_lnoddsscore                   := ep_lnoddsscore;
		self.ep_probscore                     := ep_probscore;
		self.ssn_deceased                     := ssn_deceased;
		self.riskview_222s                    := riskview_222s;
		self.base                             := base;
		self.point                            := point;
		self.odds                             := odds;
		self.rvc1210_1_0                      := rvc1210_1_0;
		self.glrc97                           := glrc97;
		self.glrc98_1                         := glrc98_1;
		self.glrc98_2                         := glrc98_2;
		self.glrc9c                           := glrc9c;
		self.glrc9d                           := glrc9d;
		self.glrc9i                           := glrc9i;
		self.glrc9m                           := glrc9m;
		self.glrc9q_1                         := glrc9q_1;
		self.glrc9q_2                         := glrc9q_2;
		self.glrc9w                           := glrc9w;
		self.glrc9y                           := glrc9y;
		self.glrcms                           := glrcms;
		self.glrcbl                           := glrcbl;
		self.criminal_flag                    := criminal_flag;
		self.lien_unrel_flag                  := lien_unrel_flag;
		self.bankruptcy_flag                  := bankruptcy_flag;
		self.divptslost_iv_derog_diff         := divptslost_iv_derog_diff;
		self.rcvalue97_1                      := rcvalue97_1;
		self.rcvalue97                        := rcvalue97;
		self.rcvalue98_1                      := rcvalue98_1;
		self.rcvalue98_2                      := rcvalue98_2;
		self.rcvalue98_3                      := rcvalue98_3;
		self.rcvalue98_4                      := rcvalue98_4;
		self.rcvalue98                        := rcvalue98;
		self.rcvalue9c_1                      := rcvalue9c_1;
		self.rcvalue9c                        := rcvalue9c;
		self.rcvalue9d_1                      := rcvalue9d_1;
		self.rcvalue9d                        := rcvalue9d;
		self.rcvalue9i_1                      := rcvalue9i_1;
		self.rcvalue9i                        := rcvalue9i;
		self.rcvalue9m_1                      := rcvalue9m_1;
		self.rcvalue9m_2                      := rcvalue9m_2;
		self.rcvalue9m                        := rcvalue9m;
		self.rcvalue9q_1                      := rcvalue9q_1;
		self.rcvalue9q_2                      := rcvalue9q_2;
		self.rcvalue9q                        := rcvalue9q;
		self.rcvalue9w_1                      := rcvalue9w_1;
		self.rcvalue9w_2                      := rcvalue9w_2;
		self.rcvalue9w                        := rcvalue9w;
		self.rcvalue9y_1                      := rcvalue9y_1;
		self.rcvalue9y                        := rcvalue9y;
		self.rcvaluems_1                      := rcvaluems_1;
		self.rcvaluems                        := rcvaluems;
		self.rcvaluebl_1                      := rcvaluebl_1;
		self.rcvaluebl_2                      := rcvaluebl_2;
		self.rcvaluebl_3                      := rcvaluebl_3;
		self.rcvaluebl_4                      := rcvaluebl_4;
		self.rcvaluebl_5                      := rcvaluebl_5;
		self.rcvaluebl                        := rcvaluebl;
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
											(string3)RVC1210_1_0
										);
END;

		model := project( clam, doModel(left) );

		return model;
END;
