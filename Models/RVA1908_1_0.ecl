IMPORT Risk_Indicators, Models, STD, UT, MDR;

EXPORT RVA1908_1_0(GROUPED dataset(risk_indicators.Layout_Boca_Shell) clam) := FUNCTION

  MODEL_DEBUG := FALSE;

  #if(MODEL_DEBUG)
  Layout_Debug := RECORD
  INTEGER sysdate;
  INTEGER ver_src_eq_pos;
  STRING _ver_src_fdate_eq;
  INTEGER ver_src_fdate_eq;
  INTEGER college_proflic_br_ind;
  STRING rv_4seg_riskview_5_0_v2;
  INTEGER _felony_last_date;
  INTEGER _criminal_last_date;
  INTEGER rv_d31_bk_dism_recent_count;
  INTEGER rv_a41_a42_prop_owner_history;
  INTEGER rv_d32_criminal_behavior_lvl;
  INTEGER rv_i60_inq_hiriskcred_count12;
  INTEGER rv_d30_derog_count;
  INTEGER rv_c12_inp_addr_source_count;
  INTEGER rv_i62_inq_phones_per_adl;
  INTEGER rv_i60_inq_comm_count12;
  INTEGER rv_i62_inq_addrs_per_adl;
  INTEGER rv_c22_inp_addr_occ_index;
  INTEGER rv_d33_eviction_recency;
  INTEGER rv_f03_input_add_not_most_rec;
  INTEGER rv_c24_prv_addr_lres;
  INTEGER rv_c20_m_bureau_adl_fs;
  INTEGER rv_i60_inq_peradl_count12;
  INTEGER iv_c13_avg_lres;
  INTEGER rv_c12_num_nonderogs;
  INTEGER iv_c22_addr_ver_sources;
  INTEGER rv_s66_adlperssn_count;
  INTEGER rv_f01_inp_addr_address_score;
  INTEGER rv_i60_inq_other_count12;
  INTEGER rv_c14_unverified_addr_count;
  INTEGER rv_i60_credit_seeking;
  REAL mod_1seg_v01_w;
  REAL mod_1seg_aa_dist_01;
  STRING mod_1seg_aa_code_01;
  REAL mod_1seg_v02_w;
  REAL mod_1seg_aa_dist_02;
  STRING mod_1seg_aa_code_02;
  REAL mod_1seg_v03_w;
  REAL mod_1seg_aa_dist_03;
  STRING mod_1seg_aa_code_03;
  REAL mod_1seg_v04_w;
  REAL mod_1seg_aa_dist_04;
  STRING mod_1seg_aa_code_04;
  REAL mod_1seg_v05_w;
  REAL mod_1seg_aa_dist_05;
  STRING mod_1seg_aa_code_05;
  REAL mod_1seg_v06_w;
  REAL mod_1seg_aa_dist_06;
  STRING mod_1seg_aa_code_06;
  REAL mod_1seg_v07_w;
  REAL mod_1seg_aa_dist_07;
  STRING mod_1seg_aa_code_07;
  REAL mod_1seg_v08_w;
  REAL mod_1seg_aa_dist_08;
  STRING mod_1seg_aa_code_08;
  REAL mod_1seg_v09_w;
  REAL mod_1seg_aa_dist_09;
  STRING mod_1seg_aa_code_09;
  REAL mod_1seg_v10_w;
  REAL mod_1seg_aa_dist_10;
  STRING mod_1seg_aa_code_10;
  REAL mod_1seg_v11_w;
  REAL mod_1seg_aa_dist_11;
  STRING mod_1seg_aa_code_11;
  REAL mod_1seg_v12_w;
  REAL mod_1seg_aa_dist_12;
  STRING mod_1seg_aa_code_12;
  REAL mod_1seg_v13_w;
  REAL mod_1seg_aa_dist_13;
  STRING mod_1seg_aa_code_13;
  REAL mod_1seg_v14_w;
  REAL mod_1seg_aa_dist_14;
  STRING mod_1seg_aa_code_14;
  REAL mod_1seg_v15_w;
  REAL mod_1seg_aa_dist_15;
  STRING mod_1seg_aa_code_15;
  REAL mod_1seg_rcvaluei60;
  REAL mod_1seg_rcvalued33;
  REAL mod_1seg_rcvaluea42;
  REAL mod_1seg_rcvalued32;
  REAL mod_1seg_rcvaluec22;
  REAL mod_1seg_rcvaluec12;
  REAL mod_1seg_rcvalued30;
  REAL mod_1seg_rcvaluec24;
  REAL mod_1seg_rcvalued31;
  REAL mod_1seg_rcvalues66;
  REAL mod_1seg_rcvaluei62;
  REAL mod_1seg_rcvaluef03;
  REAL mod_1seg_lgt;
  REAL mod_2seg_v01_w;
  REAL mod_2seg_aa_dist_01;
  STRING mod_2seg_aa_code_01;
  REAL mod_2seg_v02_w;
  REAL mod_2seg_aa_dist_02;
  STRING mod_2seg_aa_code_02;
  REAL mod_2seg_v03_w;
  REAL mod_2seg_aa_dist_03;
  STRING mod_2seg_aa_code_03;
  REAL mod_2seg_v04_w;
  REAL mod_2seg_aa_dist_04;
  STRING mod_2seg_aa_code_04;
  REAL mod_2seg_v05_w;
  REAL mod_2seg_aa_dist_05;
  STRING mod_2seg_aa_code_05;
  REAL mod_2seg_v06_w;
  REAL mod_2seg_aa_dist_06;
  STRING mod_2seg_aa_code_06;
  REAL mod_2seg_v07_w;
  REAL mod_2seg_aa_dist_07;
  STRING mod_2seg_aa_code_07;
  REAL mod_2seg_v08_w;
  REAL mod_2seg_aa_dist_08;
  STRING mod_2seg_aa_code_08;
  REAL mod_2seg_v09_w;
  REAL mod_2seg_aa_dist_09;
  STRING mod_2seg_aa_code_09;
  REAL mod_2seg_v10_w;
  REAL mod_2seg_aa_dist_10;
  STRING mod_2seg_aa_code_10;
  REAL mod_2seg_v11_w;
  REAL mod_2seg_aa_dist_11;
  STRING mod_2seg_aa_code_11;
  REAL mod_2seg_v12_w;
  REAL mod_2seg_aa_dist_12;
  STRING mod_2seg_aa_code_12;
  REAL mod_2seg_v13_w;
  REAL mod_2seg_aa_dist_13;
  STRING mod_2seg_aa_code_13;
  REAL mod_2seg_v14_w;
  REAL mod_2seg_aa_dist_14;
  STRING mod_2seg_aa_code_14;
  REAL mod_2seg_v15_w;
  REAL mod_2seg_aa_dist_15;
  STRING mod_2seg_aa_code_15;
  STRING mod_2seg_aa_code_00;
  REAL mod_2seg_aa_dist_00;
  REAL mod_2seg_rcvaluei60;
  REAL mod_2seg_rcvalued33;
  REAL mod_2seg_rcvalued32;
  REAL mod_2seg_rcvaluea42;
  REAL mod_2seg_rcvaluec20;
  REAL mod_2seg_rcvaluec22;
  REAL mod_2seg_rcvaluec12;
  REAL mod_2seg_rcvalued30;
  REAL mod_2seg_rcvalued31;
  REAL mod_2seg_rcvaluei62;
  REAL mod_2seg_rcvaluef03;
  REAL mod_2seg_lgt;
  REAL mod_3seg_v01_w;
  REAL mod_3seg_aa_dist_01;
  STRING mod_3seg_aa_code_01;
  REAL mod_3seg_v02_w;
  REAL mod_3seg_aa_dist_02;
  STRING mod_3seg_aa_code_02;
  REAL mod_3seg_v03_w;
  REAL mod_3seg_aa_dist_03;
  STRING mod_3seg_aa_code_03;
  REAL mod_3seg_v04_w;
  REAL mod_3seg_aa_dist_04;
  STRING mod_3seg_aa_code_04;
  REAL mod_3seg_v05_w;
  REAL mod_3seg_aa_dist_05;
  STRING mod_3seg_aa_code_05;
  REAL mod_3seg_v06_w;
  REAL mod_3seg_aa_dist_06;
  STRING mod_3seg_aa_code_06;
  REAL mod_3seg_v07_w;
  REAL mod_3seg_aa_dist_07;
  STRING mod_3seg_aa_code_07;
  REAL mod_3seg_v08_w;
  REAL mod_3seg_aa_dist_08;
  STRING mod_3seg_aa_code_08;
  REAL mod_3seg_rcvaluei60;
  REAL mod_3seg_rcvaluec13;
  REAL mod_3seg_rcvaluec12;
  REAL mod_3seg_rcvalues66;
  REAL mod_3seg_rcvaluec22;
  REAL mod_3seg_lgt;
  REAL mod_4seg_v01_w;
  REAL mod_4seg_aa_dist_01;
  STRING mod_4seg_aa_code_01;
  REAL mod_4seg_v02_w;
  REAL mod_4seg_aa_dist_02;
  STRING mod_4seg_aa_code_02;
  REAL mod_4seg_v03_w;
  REAL mod_4seg_aa_dist_03;
  STRING mod_4seg_aa_code_03;
  REAL mod_4seg_v04_w;
  REAL mod_4seg_aa_dist_04;
  STRING mod_4seg_aa_code_04;
  REAL mod_4seg_v05_w;
  REAL mod_4seg_aa_dist_05;
  STRING mod_4seg_aa_code_05;
  REAL mod_4seg_v06_w;
  REAL mod_4seg_aa_dist_06;
  STRING mod_4seg_aa_code_06;
  REAL mod_4seg_v07_w;
  REAL mod_4seg_aa_dist_07;
  STRING mod_4seg_aa_code_07;
  REAL mod_4seg_v08_w;
  REAL mod_4seg_aa_dist_08;
  STRING mod_4seg_aa_code_08;
  REAL mod_4seg_v09_w;
  REAL mod_4seg_aa_dist_09;
  STRING mod_4seg_aa_code_09;
  REAL mod_4seg_v10_w;
  REAL mod_4seg_aa_dist_10;
  STRING mod_4seg_aa_code_10;
  REAL mod_4seg_v11_w;
  REAL mod_4seg_aa_dist_11;
  STRING mod_4seg_aa_code_11;
  REAL mod_4seg_v12_w;
  REAL mod_4seg_aa_dist_12;
  STRING mod_4seg_aa_code_12;
  REAL mod_4seg_v13_w;
  REAL mod_4seg_aa_dist_13;
  STRING mod_4seg_aa_code_13;
  STRING mod_4seg_aa_code_00;
  REAL mod_4seg_aa_dist_00;
  REAL mod_4seg_rcvaluei60;
  REAL mod_4seg_rcvaluec13;
  REAL mod_4seg_rcvaluec14;
  REAL mod_4seg_rcvaluea42;
  REAL mod_4seg_rcvaluef01;
  REAL mod_4seg_rcvaluec12;
  REAL mod_4seg_rcvaluec24;
  REAL mod_4seg_rcvalues66;
  REAL mod_4seg_rcvaluei62;
  REAL mod_4seg_rcvaluef03;
  REAL mod_4seg_lgt;
  STRING seg1_rc1;
  STRING seg1_rc4;
  STRING seg1_rc5;
  STRING seg1_rc2;
  STRING seg1_rc3;
  STRING seg2_rc2;
  STRING seg2_rc3;
  STRING seg2_rc1;
  STRING seg2_rc5;
  STRING seg2_rc4;
  STRING seg3_rc1;
  STRING seg3_rc5;
  STRING seg3_rc3;
  STRING seg3_rc4;
  STRING seg3_rc2;
  STRING _rc_inq;
  STRING seg4_rc1;
  STRING seg4_rc5;
  STRING seg4_rc3;
  STRING seg4_rc4;
  STRING seg4_rc2;
  BOOLEAN iv_rv5_deceased;
  INTEGER iv_rv5_unscorable;
  INTEGER base;
  REAL odds;
  INTEGER point;
  INTEGER rva1908_1_0;
  STRING rc1;
  STRING rc2;
  STRING rc4;
  STRING rc5;
  STRING rc3;
  Risk_Indicators.Layout_Boca_Shell clam;
  END;

  Layout_Debug doModel(clam le) := TRANSFORM
  #else
  Models.Layout_ModelOut doModel(clam le) := TRANSFORM
  #end

  /* ***********************************************************
  *             Model Input Variable Assignments              *
  ************************************************************* */
  ver_sources                      := le.header_summary.ver_sources;
  ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
  truedid                          := le.truedid;
  college_file_type                := le.student.file_type2;
  college_attendance               := le.attended_college;
  prof_license_flag                := le.professional_license.professional_license_flag;
  br_source_count                  := le.employment.source_ct;
  attr_total_number_derogs         := le.total_number_derogs;
  add_input_naprop                 := le.address_verification.input_address_information.naprop;
  property_owned_total             := le.address_verification.owned.property_total;
  felony_last_date                 := le.bjl.last_felony_date;
  criminal_last_date               := le.bjl.last_criminal_date;
  bk_dismissed_recent_count        := le.bjl.bk_dismissed_recent_count;
  add_curr_naprop                  := le.address_verification.address_history_1.naprop;
  add_prev_naprop                  := le.address_verification.address_history_2.naprop;
  felony_count                     := le.bjl.felony_count;
  criminal_count                   := le.bjl.criminal_count;
  inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
  add_input_pop                    := le.addrPop;
  add_input_source_count           := le.address_verification.input_address_information.source_count;
  inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
  inq_communications_count12       := le.acc_logs.communications.count12;
  inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
  add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
  attr_eviction_count90            := le.bjl.eviction_count90;
  attr_eviction_count180           := le.bjl.eviction_count180;
  attr_eviction_count12            := le.bjl.eviction_count12;
  attr_eviction_count24            := le.bjl.eviction_count24;
  attr_eviction_count              := le.bjl.eviction_count;
  attr_eviction_count36            := le.bjl.eviction_count36;
  attr_eviction_count60            := le.bjl.eviction_count60;
  rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
  add_prev_pop                     := le.addrPop3;
  add_prev_lres                    := le.lres3;
  inq_peradl                       := le.acc_logs.inquiryperadl;
  avg_lres                         := le.other_address_info.avg_lres;
  attr_num_nonderogs               := le.source_verification.num_nonderogs;
  rc_addrcount                     := le.iid.addrcount;
  rc_phoneaddrcount                := le.iid.phoneaddrcount;
  rc_phoneaddr_addrcount           := le.iid.phoneaddr_addrcount;
  ssnlength                        := le.input_validation.ssn_length;
  adls_per_ssn                     := le.SSN_Verification.adlperssn_count;
  add_input_address_score          := le.address_verification.input_address_information.address_score;
  inq_other_count12                := le.acc_logs.other.count12;
  unverified_addr_count            := le.address_verification.unverified_addr_count;
  inq_auto_count03                 := le.acc_logs.auto.count03;
  inq_banking_count03              := le.acc_logs.banking.count03;
  inq_mortgage_count03             := le.acc_logs.mortgage.count03;
  inq_retail_count03               := le.acc_logs.retail.count03;
  inq_communications_count03       := le.acc_logs.communications.count03;
  rc_decsflag                      := le.iid.decsflag;
  rc_ssndod                        := le.ssn_verification.validation.deceasedDate;

  /* ***********************************************************
  *   Generated ECL         *
  ************************************************************* */
   
NULL := Models.Common.NULL;

BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(STD.Str.Find(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(STD.Str.Reverse(source)[1..length(target)+1] = STD.Str.Reverse(target) + delim);


sysdate := common.sas_date(if(le.historydate=Models.Common.HistoryDateCurrent, (string8)Std.Date.Today(), (string6)le.historydate+'01'));

ver_src_eq_pos := Models.Common.findw_cpp(ver_sources, MDR.sourceTools.src_Equifax , '  ,', 'ie');

_ver_src_fdate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), '0');

ver_src_fdate_eq := common.sas_date((string)(_ver_src_fdate_eq));

college_proflic_br_ind := map(
    not(truedid)                                                                                                                                           => NULL,
    (college_file_type in ['H', 'C', 'A']) or (boolean)(integer)college_attendance                                                                         => 1,
    if(max((integer)prof_license_flag, br_source_count) = NULL, NULL, sum((integer)prof_license_flag, if(br_source_count = NULL, 0, br_source_count))) > 0 => 1,
                                                                                                                                                              0);

rv_4seg_riskview_5_0_v2 := map(
    not(truedid)                                      => '0 TRUEDID = 0',
    college_proflic_br_ind = 1                       => '1 CRED',
    attr_total_number_derogs > 0                     => '2 DEROG',
    add_input_naprop = 4 or property_owned_total > 0 => '3 OWNER',
                                                        '4 OTHER');

_felony_last_date := common.sas_date((string)(felony_last_date));

_criminal_last_date := common.sas_date((string)(criminal_last_date));

rv_d31_bk_dism_recent_count := if(not(truedid), NULL, min(if(bk_dismissed_recent_count = NULL, -NULL, bk_dismissed_recent_count), 999));

rv_a41_a42_prop_owner_history := map(
    not(truedid)                                                                     => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 2,
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 1,
                                                                                        0);

rv_d32_criminal_behavior_lvl := map(
    not(truedid)                                                                                   => NULL,
    felony_count > 0 and not(_felony_last_date = NULL) and sysdate - _felony_last_date < 365       => 6,
    criminal_count > 0 and not(_criminal_last_date = NULL) and sysdate - _criminal_last_date < 365 => 5,
    felony_count > 0                                                                               => 4,
                                                                                                      min(if(criminal_count = NULL, -NULL, criminal_count), 3));

rv_i60_inq_hiriskcred_count12 := if(not(truedid), NULL, min(if(inq_highriskcredit_count12 = NULL, -NULL, inq_highriskcredit_count12), 999));

rv_d30_derog_count := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));

rv_c12_inp_addr_source_count := if(not((boolean)(integer)add_input_pop and truedid), NULL, min(if(add_input_source_count = NULL, -NULL, add_input_source_count), 999));

rv_i62_inq_phones_per_adl := if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999));

rv_i60_inq_comm_count12 := if(not(truedid), NULL, min(if(inq_communications_count12 = NULL, -NULL, inq_communications_count12), 999));

rv_i62_inq_addrs_per_adl := if(not(truedid), NULL, min(if(inq_addrsperadl = NULL, -NULL, inq_addrsperadl), 999));

rv_c22_inp_addr_occ_index := if(not((boolean)(integer)add_input_pop and truedid), NULL, add_input_occ_index);

rv_d33_eviction_recency := map(
    not(truedid)                                                => NULL,
    (boolean)attr_eviction_count90                                       => 3,
    (boolean)attr_eviction_count180                                      => 6,
    (boolean)attr_eviction_count12                                       => 12,
    (boolean)attr_eviction_count24 and attr_eviction_count >= 2 => 24,
    (boolean)attr_eviction_count24                                       => 25,
    (boolean)attr_eviction_count36 and attr_eviction_count >= 2 => 36,
    (boolean)attr_eviction_count36                                       => 37,
    (boolean)attr_eviction_count60 and attr_eviction_count >= 2 => 60,
    (boolean)attr_eviction_count60                                       => 61,
    attr_eviction_count >= 2                                    => 98,
    attr_eviction_count >= 1                                    => 99,
                                                                   999);

rv_f03_input_add_not_most_rec := if(not(truedid and (boolean)(integer)add_input_pop), NULL, (integer)rc_input_addr_not_most_recent);

rv_c24_prv_addr_lres := if(not(truedid and (boolean)(integer)add_prev_pop), NULL, min(if(add_prev_lres = NULL, -NULL, add_prev_lres), 999));

rv_c20_m_bureau_adl_fs := map(
    not(truedid)            => NULL,
    ver_src_fdate_eq = NULL => -1,
                               min(if(if ((sysdate - ver_src_fdate_eq) / (365.25 / 12) >= 0, truncate((sysdate - ver_src_fdate_eq) / (365.25 / 12)), roundup((sysdate - ver_src_fdate_eq) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - ver_src_fdate_eq) / (365.25 / 12) >= 0, truncate((sysdate - ver_src_fdate_eq) / (365.25 / 12)), roundup((sysdate - ver_src_fdate_eq) / (365.25 / 12)))), 999));

rv_i60_inq_peradl_count12 := if(not(truedid), NULL, min(if(Inq_PerADL = NULL, -NULL, Inq_PerADL), 999));

iv_c13_avg_lres := if(not(truedid), NULL, min(if(avg_lres = NULL, -NULL, avg_lres), 999));

rv_c12_num_nonderogs := if(not(truedid), NULL, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 4));

iv_c22_addr_ver_sources := map(
    not(truedid and (boolean)(integer)add_input_pop)                           => NULL,
    rc_addrcount > 0 and (rc_phoneaddrcount > 0 or rc_phoneaddr_addrcount > 0) => 3,
    rc_addrcount > 0                                                           => 2,
    rc_phoneaddrcount > 0 or rc_phoneaddr_addrcount > 0                        => 1,
                                                                                  0);

rv_s66_adlperssn_count := map(
    not((integer)ssnlength = 9) => NULL,
    adls_per_ssn = 0   => 1,
                          min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999));

rv_f01_inp_addr_address_score := map(
    not((boolean)(integer)add_input_pop and truedid) => NULL,
    add_input_address_score = 255                    => NULL,
                                                        min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));

rv_i60_inq_other_count12 := if(not(truedid), NULL, min(if(inq_other_count12 = NULL, -NULL, inq_other_count12), 999));

rv_c14_unverified_addr_count := if(not(truedid), NULL, min(if(unverified_addr_count = NULL, -NULL, unverified_addr_count), 999));

rv_i60_credit_seeking := if(not(truedid), NULL, if(max(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)), min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)), min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)), min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)), min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))) = NULL, NULL, sum(if(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)) = NULL, 0, min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03))), if(min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)) = NULL, 0, min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03))), if(min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)) = NULL, 0, min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03))), if(min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)) = NULL, 0, min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03))), if(min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03)) = NULL, 0, min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))))));

mod_1seg_v01_w := map(
    rv_d31_bk_dism_recent_count = NULL => 0,
    rv_d31_bk_dism_recent_count = -1   => 0,
    rv_d31_bk_dism_recent_count <= 0.5 => 0.437930922886504,
                                          -0.426181390430953);

mod_1seg_aa_code_01_1 := map(
    rv_d31_bk_dism_recent_count = NULL => '',
    rv_d31_bk_dism_recent_count = -1   => 'C12',
    rv_d31_bk_dism_recent_count <= 0.5 => 'D31',
                                          'D31');

mod_1seg_aa_dist_01 := mod_1seg_v01_w - 0.432266440482962;

mod_1seg_aa_code_01 := if(mod_1seg_aa_dist_01 = 0, '', mod_1seg_aa_code_01_1);

mod_1seg_v02_w := map(
    rv_i60_inq_hiriskcred_count12 = NULL => 0,
    rv_i60_inq_hiriskcred_count12 = -1   => 0,
    rv_i60_inq_hiriskcred_count12 <= 0.5 => 0.216971247325155,
    rv_i60_inq_hiriskcred_count12 <= 1.5 => -0.151545260201242,
    rv_i60_inq_hiriskcred_count12 <= 3.5 => -0.226352345463825,
                                            -0.421021736777287);

mod_1seg_aa_code_02_1 := map(
    rv_i60_inq_hiriskcred_count12 = NULL => '',
    rv_i60_inq_hiriskcred_count12 = -1   => 'C12',
    rv_i60_inq_hiriskcred_count12 <= 0.5 => 'I60',
    rv_i60_inq_hiriskcred_count12 <= 1.5 => 'I60',
    rv_i60_inq_hiriskcred_count12 <= 3.5 => 'I60',
                                            'I60');

mod_1seg_aa_dist_02 := mod_1seg_v02_w - 0.180844814836041;

mod_1seg_aa_code_02 := if(mod_1seg_aa_dist_02 = 0, '', mod_1seg_aa_code_02_1);

mod_1seg_v03_w := map(
    rv_i62_inq_phones_per_adl = NULL => 0,
    rv_i62_inq_phones_per_adl = -1   => 0,
    rv_i62_inq_phones_per_adl <= 1.5 => 0.177835338914773,
    rv_i62_inq_phones_per_adl <= 2.5 => -0.109803994893046,
    rv_i62_inq_phones_per_adl <= 3.5 => -0.293069147700024,
                                        -0.828237957914089);

mod_1seg_aa_code_03_1 := map(
    rv_i62_inq_phones_per_adl = NULL => '',
    rv_i62_inq_phones_per_adl = -1   => 'C12',
    rv_i62_inq_phones_per_adl <= 1.5 => 'I62',
    rv_i62_inq_phones_per_adl <= 2.5 => 'I62',
    rv_i62_inq_phones_per_adl <= 3.5 => 'I62',
                                        'I62');

mod_1seg_aa_dist_03 := mod_1seg_v03_w - 0.149461060670960;

mod_1seg_aa_code_03 := if(mod_1seg_aa_dist_03 = 0, '', mod_1seg_aa_code_03_1);

mod_1seg_v04_w := map(
    rv_a41_a42_prop_owner_history = NULL => 0,
    rv_a41_a42_prop_owner_history = -1   => 0,
    rv_a41_a42_prop_owner_history <= 0.5 => -0.20007420423801,
    rv_a41_a42_prop_owner_history <= 1.5 => -0.00602870952081607,
                                            0.191571673975229);

mod_1seg_aa_code_04_1 := map(
    rv_a41_a42_prop_owner_history = NULL => '',
    rv_a41_a42_prop_owner_history = -1   => 'C12',
    rv_a41_a42_prop_owner_history <= 0.5 => 'A42',
    rv_a41_a42_prop_owner_history <= 1.5 => 'A42',
                                            'A42');

mod_1seg_aa_dist_04 := mod_1seg_v04_w - 0.009220269786729;

mod_1seg_aa_code_04 := if(mod_1seg_aa_dist_04 = 0, '', mod_1seg_aa_code_04_1);

mod_1seg_v05_w := map(
    rv_d32_criminal_behavior_lvl = NULL => 0,
    rv_d32_criminal_behavior_lvl = -1   => 0,
    rv_d32_criminal_behavior_lvl <= 0.5 => 0.18282278135027,
    rv_d32_criminal_behavior_lvl <= 3.5 => -0.107204155020393,
                                           -0.351982721312275);

mod_1seg_aa_code_05_1 := map(
    rv_d32_criminal_behavior_lvl = NULL => '',
    rv_d32_criminal_behavior_lvl = -1   => 'C12',
    rv_d32_criminal_behavior_lvl <= 0.5 => 'D32',
    rv_d32_criminal_behavior_lvl <= 3.5 => 'D32',
                                           'D32');

mod_1seg_aa_dist_05 := mod_1seg_v05_w - 0.168987148373384;

mod_1seg_aa_code_05 := if(mod_1seg_aa_dist_05 = 0, '', mod_1seg_aa_code_05_1);

mod_1seg_v06_w := map(
    rv_c12_inp_addr_source_count = NULL => 0,
    rv_c12_inp_addr_source_count = -1   => 0,
    rv_c12_inp_addr_source_count <= 0.5 => -0.311536205429246,
    rv_c12_inp_addr_source_count <= 1.5 => -0.0646161934482821,
    rv_c12_inp_addr_source_count <= 2.5 => -0.0439814469792298,
    rv_c12_inp_addr_source_count <= 3.5 => 0.163425078944447,
                                           0.167826526768521);

mod_1seg_aa_code_06_1 := map(
    rv_c12_inp_addr_source_count = NULL => '',
    rv_c12_inp_addr_source_count = -1   => 'C12',
    rv_c12_inp_addr_source_count <= 0.5 => 'C12',
    rv_c12_inp_addr_source_count <= 1.5 => 'C12',
    rv_c12_inp_addr_source_count <= 2.5 => 'C12',
    rv_c12_inp_addr_source_count <= 3.5 => 'C12',
                                           'C12');

mod_1seg_aa_dist_06 := mod_1seg_v06_w - 0.006642229190328;

mod_1seg_aa_code_06 := if(mod_1seg_aa_dist_06 = 0, '', mod_1seg_aa_code_06_1);

mod_1seg_v07_w := map(
    rv_i60_inq_comm_count12 = NULL => 0,
    rv_i60_inq_comm_count12 = -1   => 0,
    rv_i60_inq_comm_count12 <= 0.5 => 0.169355267619452,
    rv_i60_inq_comm_count12 <= 1.5 => -0.133313090593757,
                                      -0.361445281006552);

mod_1seg_aa_code_07_1 := map(
    rv_i60_inq_comm_count12 = NULL => '',
    rv_i60_inq_comm_count12 = -1   => 'C12',
    rv_i60_inq_comm_count12 <= 0.5 => 'I60',
    rv_i60_inq_comm_count12 <= 1.5 => 'I60',
                                      'I60');

mod_1seg_aa_dist_07 := mod_1seg_v07_w - 0.152368264840060;

mod_1seg_aa_code_07 := if(mod_1seg_aa_dist_07 = 0, '', mod_1seg_aa_code_07_1);

mod_1seg_v08_w := map(
    rv_d33_eviction_recency = NULL  => 0,
    rv_d33_eviction_recency = -1    => 0,
    rv_d33_eviction_recency <= 24.5 => -0.521576870022628,
    rv_d33_eviction_recency <= 549  => -0.0804636922502,
                                       0.156089015875306);

mod_1seg_aa_code_08_1 := map(
    rv_d33_eviction_recency = NULL  => '',
    rv_d33_eviction_recency = -1    => 'C12',
    rv_d33_eviction_recency <= 24.5 => 'D33',
    rv_d33_eviction_recency <= 549  => 'D33',
                                       'D33');

mod_1seg_aa_dist_08 := mod_1seg_v08_w - 0.147074531061416;

mod_1seg_aa_code_08 := if(mod_1seg_aa_dist_08 = 0, '', mod_1seg_aa_code_08_1);

mod_1seg_v09_w := map(
    rv_d30_derog_count = NULL => 0,
    rv_d30_derog_count = -1   => 0,
    rv_d30_derog_count <= 0.5 => 0.153390687881183,
    rv_d30_derog_count <= 1.5 => -0.0921392490493616,
    rv_d30_derog_count <= 3.5 => -0.145686293467423,
    rv_d30_derog_count <= 4.5 => -0.211335670645533,
    rv_d30_derog_count <= 6.5 => -0.341921154972552,
                                 -0.553951406200166);

mod_1seg_aa_code_09_1 := map(
    rv_d30_derog_count = NULL => '',
    rv_d30_derog_count = -1   => 'C12',
    rv_d30_derog_count <= 0.5 => 'D30',
    rv_d30_derog_count <= 1.5 => 'D30',
    rv_d30_derog_count <= 3.5 => 'D30',
    rv_d30_derog_count <= 4.5 => 'D30',
    rv_d30_derog_count <= 6.5 => 'D30',
                                 'D30');

mod_1seg_aa_dist_09 := mod_1seg_v09_w - 0.088543487779554;

mod_1seg_aa_code_09 := if(mod_1seg_aa_dist_09 = 0, '', mod_1seg_aa_code_09_1);

mod_1seg_v10_w := map(
    rv_i62_inq_addrs_per_adl = NULL => 0,
    rv_i62_inq_addrs_per_adl = -1   => 0,
    rv_i62_inq_addrs_per_adl <= 0.5 => 0.166032183186104,
    rv_i62_inq_addrs_per_adl <= 1.5 => -0.120796282555883,
                                       -0.124624889815345);

mod_1seg_aa_code_10_1 := map(
    rv_i62_inq_addrs_per_adl = NULL => '',
    rv_i62_inq_addrs_per_adl = -1   => 'C12',
    rv_i62_inq_addrs_per_adl <= 0.5 => 'I62',
    rv_i62_inq_addrs_per_adl <= 1.5 => 'I62',
                                       'I62');

mod_1seg_aa_dist_10 := mod_1seg_v10_w - 0.036557890024380;

mod_1seg_aa_code_10 := if(mod_1seg_aa_dist_10 = 0, '', mod_1seg_aa_code_10_1);

mod_1seg_v11_w := map(
    rv_c22_inp_addr_occ_index = NULL => 0,
    rv_c22_inp_addr_occ_index = -1   => 0,
    rv_c22_inp_addr_occ_index <= 0   => 0,
    rv_c22_inp_addr_occ_index <= 2   => 0.137670035439321,
                                        -0.145486027260501);

mod_1seg_aa_code_11_1 := map(
    rv_c22_inp_addr_occ_index = NULL => '',
    rv_c22_inp_addr_occ_index = -1   => 'C12',
    rv_c22_inp_addr_occ_index <= 0   => 'C22',
    rv_c22_inp_addr_occ_index <= 2   => 'C22',
                                        'C22');

mod_1seg_aa_dist_11 := mod_1seg_v11_w - 0.059823822897050;

mod_1seg_aa_code_11 := if(mod_1seg_aa_dist_11 = 0, '', mod_1seg_aa_code_11_1);

mod_1seg_v12_w := map(
    rv_f03_input_add_not_most_rec = NULL => 0,
    rv_f03_input_add_not_most_rec = -1   => 0,
    rv_f03_input_add_not_most_rec <= 0.5 => 0.117694286527506,
                                            -0.0952203177277673);

mod_1seg_aa_code_12_1 := map(
    rv_f03_input_add_not_most_rec = NULL => '',
    rv_f03_input_add_not_most_rec = -1   => 'C12',
    rv_f03_input_add_not_most_rec <= 0.5 => 'F03',
                                            'F03');

mod_1seg_aa_dist_12 := mod_1seg_v12_w - 0.094232663791796;

mod_1seg_aa_code_12 := if(mod_1seg_aa_dist_12 = 0, '', mod_1seg_aa_code_12_1);

mod_1seg_v13_w := map(
    rv_c24_prv_addr_lres = NULL  => 0,
    rv_c24_prv_addr_lres = -1    => 0,
    rv_c24_prv_addr_lres <= 19.5 => -0.146906104069653,
    rv_c24_prv_addr_lres <= 69.5 => -0.0553009697600402,
    rv_c24_prv_addr_lres <= 89.5 => 0.0358953789144106,
                                    0.127914319248671);

mod_1seg_aa_code_13_1 := map(
    rv_c24_prv_addr_lres = NULL  => '',
    rv_c24_prv_addr_lres = -1    => 'C12',
    rv_c24_prv_addr_lres <= 19.5 => 'C24',
    rv_c24_prv_addr_lres <= 69.5 => 'C24',
    rv_c24_prv_addr_lres <= 89.5 => 'C24',
                                    'C24');

mod_1seg_aa_dist_13 := mod_1seg_v13_w - -0.014261166759683;

mod_1seg_aa_code_13 := if(mod_1seg_aa_dist_13 = 0, '', mod_1seg_aa_code_13_1);

mod_1seg_v14_w := map(
    rv_c12_num_nonderogs = NULL => 0,
    rv_c12_num_nonderogs = -1   => 0,
    rv_c12_num_nonderogs <= 2.5 => -0.11817046738857,
    rv_c12_num_nonderogs <= 3.5 => -0.0108521467088249,
                                   0.106888775187033);

mod_1seg_aa_code_14_1 := map(
    rv_c12_num_nonderogs = NULL => '',
    rv_c12_num_nonderogs = -1   => 'C12',
    rv_c12_num_nonderogs <= 2.5 => 'C12',
    rv_c12_num_nonderogs <= 3.5 => 'C12',
                                   'C12');

mod_1seg_aa_dist_14 := mod_1seg_v14_w - 0.005415264865701;

mod_1seg_aa_code_14 := if(mod_1seg_aa_dist_14 = 0, '', mod_1seg_aa_code_14_1);

mod_1seg_v15_w := map(
    rv_s66_adlperssn_count = NULL => 0,
    rv_s66_adlperssn_count = -1   => 0,
    rv_s66_adlperssn_count <= 1.5 => 0.0760406044798397,
    rv_s66_adlperssn_count <= 2.5 => -0.0437560598233746,
    rv_s66_adlperssn_count <= 3.5 => -0.0759133947658772,
                                     -0.0858217607230207);

mod_1seg_aa_code_15_1 := map(
    rv_s66_adlperssn_count = NULL => '',
    rv_s66_adlperssn_count = -1   => 'C12',
    rv_s66_adlperssn_count <= 1.5 => 'S66',
    rv_s66_adlperssn_count <= 2.5 => 'S66',
    rv_s66_adlperssn_count <= 3.5 => 'S66',
                                     'S66');

mod_1seg_aa_dist_15 := mod_1seg_v15_w - 0.025075780418460;

mod_1seg_aa_code_15 := if(mod_1seg_aa_dist_15 = 0, '', mod_1seg_aa_code_15_1);

mod_1seg_rcvaluei60 := (integer)(mod_1seg_aa_code_01 = 'I60') * mod_1seg_aa_dist_01 +
    (integer)(mod_1seg_aa_code_02 = 'I60') * mod_1seg_aa_dist_02 +
    (integer)(mod_1seg_aa_code_03 = 'I60') * mod_1seg_aa_dist_03 +
    (integer)(mod_1seg_aa_code_04 = 'I60') * mod_1seg_aa_dist_04 +
    (integer)(mod_1seg_aa_code_05 = 'I60') * mod_1seg_aa_dist_05 +
    (integer)(mod_1seg_aa_code_06 = 'I60') * mod_1seg_aa_dist_06 +
    (integer)(mod_1seg_aa_code_07 = 'I60') * mod_1seg_aa_dist_07 +
    (integer)(mod_1seg_aa_code_08 = 'I60') * mod_1seg_aa_dist_08 +
    (integer)(mod_1seg_aa_code_09 = 'I60') * mod_1seg_aa_dist_09 +
    (integer)(mod_1seg_aa_code_10 = 'I60') * mod_1seg_aa_dist_10 +
    (integer)(mod_1seg_aa_code_11 = 'I60') * mod_1seg_aa_dist_11 +
    (integer)(mod_1seg_aa_code_12 = 'I60') * mod_1seg_aa_dist_12 +
    (integer)(mod_1seg_aa_code_13 = 'I60') * mod_1seg_aa_dist_13 +
    (integer)(mod_1seg_aa_code_14 = 'I60') * mod_1seg_aa_dist_14 +
    (integer)(mod_1seg_aa_code_15 = 'I60') * mod_1seg_aa_dist_15;

mod_1seg_rcvalued33 := (integer)(mod_1seg_aa_code_01 = 'D33') * mod_1seg_aa_dist_01 +
    (integer)(mod_1seg_aa_code_02 = 'D33') * mod_1seg_aa_dist_02 +
    (integer)(mod_1seg_aa_code_03 = 'D33') * mod_1seg_aa_dist_03 +
    (integer)(mod_1seg_aa_code_04 = 'D33') * mod_1seg_aa_dist_04 +
    (integer)(mod_1seg_aa_code_05 = 'D33') * mod_1seg_aa_dist_05 +
    (integer)(mod_1seg_aa_code_06 = 'D33') * mod_1seg_aa_dist_06 +
    (integer)(mod_1seg_aa_code_07 = 'D33') * mod_1seg_aa_dist_07 +
    (integer)(mod_1seg_aa_code_08 = 'D33') * mod_1seg_aa_dist_08 +
    (integer)(mod_1seg_aa_code_09 = 'D33') * mod_1seg_aa_dist_09 +
    (integer)(mod_1seg_aa_code_10 = 'D33') * mod_1seg_aa_dist_10 +
    (integer)(mod_1seg_aa_code_11 = 'D33') * mod_1seg_aa_dist_11 +
    (integer)(mod_1seg_aa_code_12 = 'D33') * mod_1seg_aa_dist_12 +
    (integer)(mod_1seg_aa_code_13 = 'D33') * mod_1seg_aa_dist_13 +
    (integer)(mod_1seg_aa_code_14 = 'D33') * mod_1seg_aa_dist_14 +
    (integer)(mod_1seg_aa_code_15 = 'D33') * mod_1seg_aa_dist_15;

mod_1seg_rcvaluea42 := (integer)(mod_1seg_aa_code_01 = 'A42') * mod_1seg_aa_dist_01 +
    (integer)(mod_1seg_aa_code_02 = 'A42') * mod_1seg_aa_dist_02 +
    (integer)(mod_1seg_aa_code_03 = 'A42') * mod_1seg_aa_dist_03 +
    (integer)(mod_1seg_aa_code_04 = 'A42') * mod_1seg_aa_dist_04 +
    (integer)(mod_1seg_aa_code_05 = 'A42') * mod_1seg_aa_dist_05 +
    (integer)(mod_1seg_aa_code_06 = 'A42') * mod_1seg_aa_dist_06 +
    (integer)(mod_1seg_aa_code_07 = 'A42') * mod_1seg_aa_dist_07 +
    (integer)(mod_1seg_aa_code_08 = 'A42') * mod_1seg_aa_dist_08 +
    (integer)(mod_1seg_aa_code_09 = 'A42') * mod_1seg_aa_dist_09 +
    (integer)(mod_1seg_aa_code_10 = 'A42') * mod_1seg_aa_dist_10 +
    (integer)(mod_1seg_aa_code_11 = 'A42') * mod_1seg_aa_dist_11 +
    (integer)(mod_1seg_aa_code_12 = 'A42') * mod_1seg_aa_dist_12 +
    (integer)(mod_1seg_aa_code_13 = 'A42') * mod_1seg_aa_dist_13 +
    (integer)(mod_1seg_aa_code_14 = 'A42') * mod_1seg_aa_dist_14 +
    (integer)(mod_1seg_aa_code_15 = 'A42') * mod_1seg_aa_dist_15;

mod_1seg_rcvalued32 := (integer)(mod_1seg_aa_code_01 = 'D32') * mod_1seg_aa_dist_01 +
    (integer)(mod_1seg_aa_code_02 = 'D32') * mod_1seg_aa_dist_02 +
    (integer)(mod_1seg_aa_code_03 = 'D32') * mod_1seg_aa_dist_03 +
    (integer)(mod_1seg_aa_code_04 = 'D32') * mod_1seg_aa_dist_04 +
    (integer)(mod_1seg_aa_code_05 = 'D32') * mod_1seg_aa_dist_05 +
    (integer)(mod_1seg_aa_code_06 = 'D32') * mod_1seg_aa_dist_06 +
    (integer)(mod_1seg_aa_code_07 = 'D32') * mod_1seg_aa_dist_07 +
    (integer)(mod_1seg_aa_code_08 = 'D32') * mod_1seg_aa_dist_08 +
    (integer)(mod_1seg_aa_code_09 = 'D32') * mod_1seg_aa_dist_09 +
    (integer)(mod_1seg_aa_code_10 = 'D32') * mod_1seg_aa_dist_10 +
    (integer)(mod_1seg_aa_code_11 = 'D32') * mod_1seg_aa_dist_11 +
    (integer)(mod_1seg_aa_code_12 = 'D32') * mod_1seg_aa_dist_12 +
    (integer)(mod_1seg_aa_code_13 = 'D32') * mod_1seg_aa_dist_13 +
    (integer)(mod_1seg_aa_code_14 = 'D32') * mod_1seg_aa_dist_14 +
    (integer)(mod_1seg_aa_code_15 = 'D32') * mod_1seg_aa_dist_15;

mod_1seg_rcvaluec22 := (integer)(mod_1seg_aa_code_01 = 'C22') * mod_1seg_aa_dist_01 +
    (integer)(mod_1seg_aa_code_02 = 'C22') * mod_1seg_aa_dist_02 +
    (integer)(mod_1seg_aa_code_03 = 'C22') * mod_1seg_aa_dist_03 +
    (integer)(mod_1seg_aa_code_04 = 'C22') * mod_1seg_aa_dist_04 +
    (integer)(mod_1seg_aa_code_05 = 'C22') * mod_1seg_aa_dist_05 +
    (integer)(mod_1seg_aa_code_06 = 'C22') * mod_1seg_aa_dist_06 +
    (integer)(mod_1seg_aa_code_07 = 'C22') * mod_1seg_aa_dist_07 +
    (integer)(mod_1seg_aa_code_08 = 'C22') * mod_1seg_aa_dist_08 +
    (integer)(mod_1seg_aa_code_09 = 'C22') * mod_1seg_aa_dist_09 +
    (integer)(mod_1seg_aa_code_10 = 'C22') * mod_1seg_aa_dist_10 +
    (integer)(mod_1seg_aa_code_11 = 'C22') * mod_1seg_aa_dist_11 +
    (integer)(mod_1seg_aa_code_12 = 'C22') * mod_1seg_aa_dist_12 +
    (integer)(mod_1seg_aa_code_13 = 'C22') * mod_1seg_aa_dist_13 +
    (integer)(mod_1seg_aa_code_14 = 'C22') * mod_1seg_aa_dist_14 +
    (integer)(mod_1seg_aa_code_15 = 'C22') * mod_1seg_aa_dist_15;

mod_1seg_rcvaluec12 := (integer)(mod_1seg_aa_code_01 = 'C12') * mod_1seg_aa_dist_01 +
    (integer)(mod_1seg_aa_code_02 = 'C12') * mod_1seg_aa_dist_02 +
    (integer)(mod_1seg_aa_code_03 = 'C12') * mod_1seg_aa_dist_03 +
    (integer)(mod_1seg_aa_code_04 = 'C12') * mod_1seg_aa_dist_04 +
    (integer)(mod_1seg_aa_code_05 = 'C12') * mod_1seg_aa_dist_05 +
    (integer)(mod_1seg_aa_code_06 = 'C12') * mod_1seg_aa_dist_06 +
    (integer)(mod_1seg_aa_code_07 = 'C12') * mod_1seg_aa_dist_07 +
    (integer)(mod_1seg_aa_code_08 = 'C12') * mod_1seg_aa_dist_08 +
    (integer)(mod_1seg_aa_code_09 = 'C12') * mod_1seg_aa_dist_09 +
    (integer)(mod_1seg_aa_code_10 = 'C12') * mod_1seg_aa_dist_10 +
    (integer)(mod_1seg_aa_code_11 = 'C12') * mod_1seg_aa_dist_11 +
    (integer)(mod_1seg_aa_code_12 = 'C12') * mod_1seg_aa_dist_12 +
    (integer)(mod_1seg_aa_code_13 = 'C12') * mod_1seg_aa_dist_13 +
    (integer)(mod_1seg_aa_code_14 = 'C12') * mod_1seg_aa_dist_14 +
    (integer)(mod_1seg_aa_code_15 = 'C12') * mod_1seg_aa_dist_15;

mod_1seg_rcvalued30 := (integer)(mod_1seg_aa_code_01 = 'D30') * mod_1seg_aa_dist_01 +
    (integer)(mod_1seg_aa_code_02 = 'D30') * mod_1seg_aa_dist_02 +
    (integer)(mod_1seg_aa_code_03 = 'D30') * mod_1seg_aa_dist_03 +
    (integer)(mod_1seg_aa_code_04 = 'D30') * mod_1seg_aa_dist_04 +
    (integer)(mod_1seg_aa_code_05 = 'D30') * mod_1seg_aa_dist_05 +
    (integer)(mod_1seg_aa_code_06 = 'D30') * mod_1seg_aa_dist_06 +
    (integer)(mod_1seg_aa_code_07 = 'D30') * mod_1seg_aa_dist_07 +
    (integer)(mod_1seg_aa_code_08 = 'D30') * mod_1seg_aa_dist_08 +
    (integer)(mod_1seg_aa_code_09 = 'D30') * mod_1seg_aa_dist_09 +
    (integer)(mod_1seg_aa_code_10 = 'D30') * mod_1seg_aa_dist_10 +
    (integer)(mod_1seg_aa_code_11 = 'D30') * mod_1seg_aa_dist_11 +
    (integer)(mod_1seg_aa_code_12 = 'D30') * mod_1seg_aa_dist_12 +
    (integer)(mod_1seg_aa_code_13 = 'D30') * mod_1seg_aa_dist_13 +
    (integer)(mod_1seg_aa_code_14 = 'D30') * mod_1seg_aa_dist_14 +
    (integer)(mod_1seg_aa_code_15 = 'D30') * mod_1seg_aa_dist_15;

mod_1seg_rcvaluec24 := (integer)(mod_1seg_aa_code_01 = 'C24') * mod_1seg_aa_dist_01 +
    (integer)(mod_1seg_aa_code_02 = 'C24') * mod_1seg_aa_dist_02 +
    (integer)(mod_1seg_aa_code_03 = 'C24') * mod_1seg_aa_dist_03 +
    (integer)(mod_1seg_aa_code_04 = 'C24') * mod_1seg_aa_dist_04 +
    (integer)(mod_1seg_aa_code_05 = 'C24') * mod_1seg_aa_dist_05 +
    (integer)(mod_1seg_aa_code_06 = 'C24') * mod_1seg_aa_dist_06 +
    (integer)(mod_1seg_aa_code_07 = 'C24') * mod_1seg_aa_dist_07 +
    (integer)(mod_1seg_aa_code_08 = 'C24') * mod_1seg_aa_dist_08 +
    (integer)(mod_1seg_aa_code_09 = 'C24') * mod_1seg_aa_dist_09 +
    (integer)(mod_1seg_aa_code_10 = 'C24') * mod_1seg_aa_dist_10 +
    (integer)(mod_1seg_aa_code_11 = 'C24') * mod_1seg_aa_dist_11 +
    (integer)(mod_1seg_aa_code_12 = 'C24') * mod_1seg_aa_dist_12 +
    (integer)(mod_1seg_aa_code_13 = 'C24') * mod_1seg_aa_dist_13 +
    (integer)(mod_1seg_aa_code_14 = 'C24') * mod_1seg_aa_dist_14 +
    (integer)(mod_1seg_aa_code_15 = 'C24') * mod_1seg_aa_dist_15;

mod_1seg_rcvalued31 := (integer)(mod_1seg_aa_code_01 = 'D31') * mod_1seg_aa_dist_01 +
    (integer)(mod_1seg_aa_code_02 = 'D31') * mod_1seg_aa_dist_02 +
    (integer)(mod_1seg_aa_code_03 = 'D31') * mod_1seg_aa_dist_03 +
    (integer)(mod_1seg_aa_code_04 = 'D31') * mod_1seg_aa_dist_04 +
    (integer)(mod_1seg_aa_code_05 = 'D31') * mod_1seg_aa_dist_05 +
    (integer)(mod_1seg_aa_code_06 = 'D31') * mod_1seg_aa_dist_06 +
    (integer)(mod_1seg_aa_code_07 = 'D31') * mod_1seg_aa_dist_07 +
    (integer)(mod_1seg_aa_code_08 = 'D31') * mod_1seg_aa_dist_08 +
    (integer)(mod_1seg_aa_code_09 = 'D31') * mod_1seg_aa_dist_09 +
    (integer)(mod_1seg_aa_code_10 = 'D31') * mod_1seg_aa_dist_10 +
    (integer)(mod_1seg_aa_code_11 = 'D31') * mod_1seg_aa_dist_11 +
    (integer)(mod_1seg_aa_code_12 = 'D31') * mod_1seg_aa_dist_12 +
    (integer)(mod_1seg_aa_code_13 = 'D31') * mod_1seg_aa_dist_13 +
    (integer)(mod_1seg_aa_code_14 = 'D31') * mod_1seg_aa_dist_14 +
    (integer)(mod_1seg_aa_code_15 = 'D31') * mod_1seg_aa_dist_15;

mod_1seg_rcvalues66 := (integer)(mod_1seg_aa_code_01 = 'S66') * mod_1seg_aa_dist_01 +
    (integer)(mod_1seg_aa_code_02 = 'S66') * mod_1seg_aa_dist_02 +
    (integer)(mod_1seg_aa_code_03 = 'S66') * mod_1seg_aa_dist_03 +
    (integer)(mod_1seg_aa_code_04 = 'S66') * mod_1seg_aa_dist_04 +
    (integer)(mod_1seg_aa_code_05 = 'S66') * mod_1seg_aa_dist_05 +
    (integer)(mod_1seg_aa_code_06 = 'S66') * mod_1seg_aa_dist_06 +
    (integer)(mod_1seg_aa_code_07 = 'S66') * mod_1seg_aa_dist_07 +
    (integer)(mod_1seg_aa_code_08 = 'S66') * mod_1seg_aa_dist_08 +
    (integer)(mod_1seg_aa_code_09 = 'S66') * mod_1seg_aa_dist_09 +
    (integer)(mod_1seg_aa_code_10 = 'S66') * mod_1seg_aa_dist_10 +
    (integer)(mod_1seg_aa_code_11 = 'S66') * mod_1seg_aa_dist_11 +
    (integer)(mod_1seg_aa_code_12 = 'S66') * mod_1seg_aa_dist_12 +
    (integer)(mod_1seg_aa_code_13 = 'S66') * mod_1seg_aa_dist_13 +
    (integer)(mod_1seg_aa_code_14 = 'S66') * mod_1seg_aa_dist_14 +
    (integer)(mod_1seg_aa_code_15 = 'S66') * mod_1seg_aa_dist_15;

mod_1seg_rcvaluei62 := (integer)(mod_1seg_aa_code_01 = 'I62') * mod_1seg_aa_dist_01 +
    (integer)(mod_1seg_aa_code_02 = 'I62') * mod_1seg_aa_dist_02 +
    (integer)(mod_1seg_aa_code_03 = 'I62') * mod_1seg_aa_dist_03 +
    (integer)(mod_1seg_aa_code_04 = 'I62') * mod_1seg_aa_dist_04 +
    (integer)(mod_1seg_aa_code_05 = 'I62') * mod_1seg_aa_dist_05 +
    (integer)(mod_1seg_aa_code_06 = 'I62') * mod_1seg_aa_dist_06 +
    (integer)(mod_1seg_aa_code_07 = 'I62') * mod_1seg_aa_dist_07 +
    (integer)(mod_1seg_aa_code_08 = 'I62') * mod_1seg_aa_dist_08 +
    (integer)(mod_1seg_aa_code_09 = 'I62') * mod_1seg_aa_dist_09 +
    (integer)(mod_1seg_aa_code_10 = 'I62') * mod_1seg_aa_dist_10 +
    (integer)(mod_1seg_aa_code_11 = 'I62') * mod_1seg_aa_dist_11 +
    (integer)(mod_1seg_aa_code_12 = 'I62') * mod_1seg_aa_dist_12 +
    (integer)(mod_1seg_aa_code_13 = 'I62') * mod_1seg_aa_dist_13 +
    (integer)(mod_1seg_aa_code_14 = 'I62') * mod_1seg_aa_dist_14 +
    (integer)(mod_1seg_aa_code_15 = 'I62') * mod_1seg_aa_dist_15;

mod_1seg_rcvaluef03 := (integer)(mod_1seg_aa_code_01 = 'F03') * mod_1seg_aa_dist_01 +
    (integer)(mod_1seg_aa_code_02 = 'F03') * mod_1seg_aa_dist_02 +
    (integer)(mod_1seg_aa_code_03 = 'F03') * mod_1seg_aa_dist_03 +
    (integer)(mod_1seg_aa_code_04 = 'F03') * mod_1seg_aa_dist_04 +
    (integer)(mod_1seg_aa_code_05 = 'F03') * mod_1seg_aa_dist_05 +
    (integer)(mod_1seg_aa_code_06 = 'F03') * mod_1seg_aa_dist_06 +
    (integer)(mod_1seg_aa_code_07 = 'F03') * mod_1seg_aa_dist_07 +
    (integer)(mod_1seg_aa_code_08 = 'F03') * mod_1seg_aa_dist_08 +
    (integer)(mod_1seg_aa_code_09 = 'F03') * mod_1seg_aa_dist_09 +
    (integer)(mod_1seg_aa_code_10 = 'F03') * mod_1seg_aa_dist_10 +
    (integer)(mod_1seg_aa_code_11 = 'F03') * mod_1seg_aa_dist_11 +
    (integer)(mod_1seg_aa_code_12 = 'F03') * mod_1seg_aa_dist_12 +
    (integer)(mod_1seg_aa_code_13 = 'F03') * mod_1seg_aa_dist_13 +
    (integer)(mod_1seg_aa_code_14 = 'F03') * mod_1seg_aa_dist_14 +
    (integer)(mod_1seg_aa_code_15 = 'F03') * mod_1seg_aa_dist_15;

mod_1seg_lgt := 2.0660903283345 +
    mod_1seg_v01_w +
    mod_1seg_v02_w +
    mod_1seg_v03_w +
    mod_1seg_v04_w +
    mod_1seg_v05_w +
    mod_1seg_v06_w +
    mod_1seg_v07_w +
    mod_1seg_v08_w +
    mod_1seg_v09_w +
    mod_1seg_v10_w +
    mod_1seg_v11_w +
    mod_1seg_v12_w +
    mod_1seg_v13_w +
    mod_1seg_v14_w +
    mod_1seg_v15_w;

mod_2seg_v01_w := map(
    rv_d31_bk_dism_recent_count = NULL => 0,
    rv_d31_bk_dism_recent_count = -1   => 0,
    rv_d31_bk_dism_recent_count <= 0.5 => 0.317884227197603,
                                          -0.31626838274051);

mod_2seg_aa_code_01_1 := map(
    rv_d31_bk_dism_recent_count = NULL => '',
    rv_d31_bk_dism_recent_count = -1   => 'C12',
    rv_d31_bk_dism_recent_count <= 0.5 => 'D31',
                                          'D31');

mod_2seg_aa_dist_01 := mod_2seg_v01_w - 0.305579154722325;

mod_2seg_aa_code_01 := if(mod_2seg_aa_dist_01 = 0, '', mod_2seg_aa_code_01_1);

mod_2seg_v02_w := map(
    rv_d32_criminal_behavior_lvl = NULL => 0,
    rv_d32_criminal_behavior_lvl = -1   => 0,
    rv_d32_criminal_behavior_lvl <= 0.5 => 0.240514927872275,
    rv_d32_criminal_behavior_lvl <= 2.5 => -0.0394773223169053,
    rv_d32_criminal_behavior_lvl <= 3.5 => -0.217168644854498,
    rv_d32_criminal_behavior_lvl <= 5.5 => -0.429600350767194,
                                           -0.821870727884569);

mod_2seg_aa_code_02_1 := map(
    rv_d32_criminal_behavior_lvl = NULL => '',
    rv_d32_criminal_behavior_lvl = -1   => 'C12',
    rv_d32_criminal_behavior_lvl <= 0.5 => 'D32',
    rv_d32_criminal_behavior_lvl <= 2.5 => 'D32',
    rv_d32_criminal_behavior_lvl <= 3.5 => 'D32',
    rv_d32_criminal_behavior_lvl <= 5.5 => 'D32',
                                           'D32');

mod_2seg_aa_dist_02 := mod_2seg_v02_w - 0.154435326688941;

mod_2seg_aa_code_02 := if(mod_2seg_aa_dist_02 = 0, '', mod_2seg_aa_code_02_1);

mod_2seg_v03_w := map(
    rv_d33_eviction_recency = NULL  => 0,
    rv_d33_eviction_recency = -1    => 0,
    rv_d33_eviction_recency <= 4.5  => -0.826921330117289,
    rv_d33_eviction_recency <= 9    => -0.654038840136491,
    rv_d33_eviction_recency <= 98.5 => -0.18099769653096,
    rv_d33_eviction_recency <= 549  => -0.0309257786475861,
                                       0.184446781286827);

mod_2seg_aa_code_03_1 := map(
    rv_d33_eviction_recency = NULL  => '',
    rv_d33_eviction_recency = -1    => 'C12',
    rv_d33_eviction_recency <= 4.5  => 'D33',
    rv_d33_eviction_recency <= 9    => 'D33',
    rv_d33_eviction_recency <= 98.5 => 'D33',
    rv_d33_eviction_recency <= 549  => 'D33',
                                       'D33');

mod_2seg_aa_dist_03 := mod_2seg_v03_w - 0.139808431100236;

mod_2seg_aa_code_03 := if(mod_2seg_aa_dist_03 = 0, '', mod_2seg_aa_code_03_1);

mod_2seg_v04_w := map(
    rv_c22_inp_addr_occ_index = NULL => 0,
    rv_c22_inp_addr_occ_index = -1   => 0,
    rv_c22_inp_addr_occ_index <= 0   => 0,
    rv_c22_inp_addr_occ_index <= 2   => 0.145703636935495,
                                        -0.148061550443185);

mod_2seg_aa_code_04_1 := map(
    rv_c22_inp_addr_occ_index = NULL => '',
    rv_c22_inp_addr_occ_index = -1   => 'C12',
    rv_c22_inp_addr_occ_index <= 0   => 'C22',
    rv_c22_inp_addr_occ_index <= 2   => 'C22',
                                        'C22');

mod_2seg_aa_dist_04 := mod_2seg_v04_w - 0.054940337211827;

mod_2seg_aa_code_04 := if(mod_2seg_aa_dist_04 = 0, '', mod_2seg_aa_code_04_1);

mod_2seg_v05_w := map(
    rv_i60_inq_hiriskcred_count12 = NULL => 0,
    rv_i60_inq_hiriskcred_count12 = -1   => 0,
    rv_i60_inq_hiriskcred_count12 <= 0.5 => 0.149451859050674,
    rv_i60_inq_hiriskcred_count12 <= 1.5 => -0.10245308336608,
    rv_i60_inq_hiriskcred_count12 <= 4.5 => -0.186531308630459,
                                            -0.269557735601571);

mod_2seg_aa_code_05_1 := map(
    rv_i60_inq_hiriskcred_count12 = NULL => '',
    rv_i60_inq_hiriskcred_count12 = -1   => 'C12',
    rv_i60_inq_hiriskcred_count12 <= 0.5 => 'I60',
    rv_i60_inq_hiriskcred_count12 <= 1.5 => 'I60',
    rv_i60_inq_hiriskcred_count12 <= 4.5 => 'I60',
                                            'I60');

mod_2seg_aa_dist_05 := mod_2seg_v05_w - 0.116731474997533;

mod_2seg_aa_code_05 := if(mod_2seg_aa_dist_05 = 0, '', mod_2seg_aa_code_05_1);

mod_2seg_v06_w := map(
    rv_i60_inq_comm_count12 = NULL => 0,
    rv_i60_inq_comm_count12 = -1   => 0,
    rv_i60_inq_comm_count12 <= 0.5 => 0.136516489643234,
    rv_i60_inq_comm_count12 <= 1.5 => -0.0671798326362739,
                                      -0.448096340779819);

mod_2seg_aa_code_06_1 := map(
    rv_i60_inq_comm_count12 = NULL => '',
    rv_i60_inq_comm_count12 = -1   => 'C12',
    rv_i60_inq_comm_count12 <= 0.5 => 'I60',
    rv_i60_inq_comm_count12 <= 1.5 => 'I60',
                                      'I60');

mod_2seg_aa_dist_06 := mod_2seg_v06_w - 0.119397153433641;

mod_2seg_aa_code_06 := if(mod_2seg_aa_dist_06 = 0, '', mod_2seg_aa_code_06_1);

mod_2seg_v07_w := map(
    rv_c12_inp_addr_source_count = NULL => 0,
    rv_c12_inp_addr_source_count = -1   => 0,
    rv_c12_inp_addr_source_count <= 0.5 => -0.205636970771351,
    rv_c12_inp_addr_source_count <= 1.5 => -0.0346483025587135,
    rv_c12_inp_addr_source_count <= 2.5 => 0.0592967809461054,
    rv_c12_inp_addr_source_count <= 3.5 => 0.0935884609332455,
                                           0.10031452875834);

mod_2seg_aa_code_07_1 := map(
    rv_c12_inp_addr_source_count = NULL => '',
    rv_c12_inp_addr_source_count = -1   => 'C12',
    rv_c12_inp_addr_source_count <= 0.5 => 'C12',
    rv_c12_inp_addr_source_count <= 1.5 => 'C12',
    rv_c12_inp_addr_source_count <= 2.5 => 'C12',
    rv_c12_inp_addr_source_count <= 3.5 => 'C12',
                                           'C12');

mod_2seg_aa_dist_07 := mod_2seg_v07_w - -0.000200623149035;

mod_2seg_aa_code_07 := if(mod_2seg_aa_dist_07 = 0, '', mod_2seg_aa_code_07_1);

mod_2seg_v08_w := map(
    rv_a41_a42_prop_owner_history = NULL => 0,
    rv_a41_a42_prop_owner_history = -1   => 0,
    rv_a41_a42_prop_owner_history <= 0.5 => -0.113886858264617,
                                            0.113745977847943);

mod_2seg_aa_code_08_1 := map(
    rv_a41_a42_prop_owner_history = NULL => '',
    rv_a41_a42_prop_owner_history = -1   => 'C12',
    rv_a41_a42_prop_owner_history <= 0.5 => 'A42',
                                            'A42');

mod_2seg_aa_dist_08 := mod_2seg_v08_w - -0.001277907634299;

mod_2seg_aa_code_08 := if(mod_2seg_aa_dist_08 = 0, '', mod_2seg_aa_code_08_1);

mod_2seg_v09_w := map(
    rv_c20_m_bureau_adl_fs = NULL   => 0,
    rv_c20_m_bureau_adl_fs = -1     => 0,
    rv_c20_m_bureau_adl_fs <= 34.5  => -0.423875866563664,
    rv_c20_m_bureau_adl_fs <= 44.5  => -0.192972995316863,
    rv_c20_m_bureau_adl_fs <= 74.5  => -0.159128361540933,
    rv_c20_m_bureau_adl_fs <= 139.5 => -0.115609615617945,
    rv_c20_m_bureau_adl_fs <= 176.5 => -0.077911941114628,
    rv_c20_m_bureau_adl_fs <= 205.5 => -0.0194155434765991,
    rv_c20_m_bureau_adl_fs <= 267.5 => 0.0246111571428954,
    rv_c20_m_bureau_adl_fs <= 384.5 => 0.0686592071141753,
                                       0.0859518945712595);

mod_2seg_aa_code_09_1 := map(
    rv_c20_m_bureau_adl_fs = NULL   => '',
    rv_c20_m_bureau_adl_fs = -1     => 'C12',
    rv_c20_m_bureau_adl_fs <= 34.5  => 'C20',
    rv_c20_m_bureau_adl_fs <= 44.5  => 'C20',
    rv_c20_m_bureau_adl_fs <= 74.5  => 'C20',
    rv_c20_m_bureau_adl_fs <= 139.5 => 'C20',
    rv_c20_m_bureau_adl_fs <= 176.5 => 'C20',
    rv_c20_m_bureau_adl_fs <= 205.5 => 'C20',
    rv_c20_m_bureau_adl_fs <= 267.5 => 'C20',
    rv_c20_m_bureau_adl_fs <= 384.5 => 'C20',
                                       'C20');

mod_2seg_aa_dist_09 := mod_2seg_v09_w - 0.010403984124505;

mod_2seg_aa_code_09 := if(mod_2seg_aa_dist_09 = 0, '', mod_2seg_aa_code_09_1);

mod_2seg_v10_w := map(
    rv_i60_credit_seeking = NULL => 0,
    rv_i60_credit_seeking = -1   => 0,
    rv_i60_credit_seeking <= 1.5 => 0.0924346180556494,
    rv_i60_credit_seeking <= 2.5 => -0.0721300383566206,
    rv_i60_credit_seeking <= 3.5 => -0.0950947162589676,
                                    -0.479750353447411);

mod_2seg_aa_code_10_1 := map(
    rv_i60_credit_seeking = NULL => '',
    rv_i60_credit_seeking = -1   => 'C12',
    rv_i60_credit_seeking <= 1.5 => 'I60',
    rv_i60_credit_seeking <= 2.5 => 'I60',
    rv_i60_credit_seeking <= 3.5 => 'I60',
                                    'I60');

mod_2seg_aa_dist_10 := mod_2seg_v10_w - 0.076702351943529;

mod_2seg_aa_code_10 := if(mod_2seg_aa_dist_10 = 0, '', mod_2seg_aa_code_10_1);

mod_2seg_v11_w := map(
    rv_i62_inq_phones_per_adl = NULL => 0,
    rv_i62_inq_phones_per_adl = -1   => 0,
    rv_i62_inq_phones_per_adl <= 1.5 => 0.0591361679224691,
    rv_i62_inq_phones_per_adl <= 2.5 => -0.000233141949901117,
    rv_i62_inq_phones_per_adl <= 3.5 => -0.124072183344069,
                                        -0.603854909844439);

mod_2seg_aa_code_11_1 := map(
    rv_i62_inq_phones_per_adl = NULL => '',
    rv_i62_inq_phones_per_adl = -1   => 'C12',
    rv_i62_inq_phones_per_adl <= 1.5 => 'I62',
    rv_i62_inq_phones_per_adl <= 2.5 => 'I62',
    rv_i62_inq_phones_per_adl <= 3.5 => 'I62',
                                        'I62');

mod_2seg_aa_dist_11 := mod_2seg_v11_w - 0.045494757028886;

mod_2seg_aa_code_11 := if(mod_2seg_aa_dist_11 = 0, '', mod_2seg_aa_code_11_1);

mod_2seg_v12_w := map(
    rv_f03_input_add_not_most_rec = NULL => 0,
    rv_f03_input_add_not_most_rec = -1   => 0,
    rv_f03_input_add_not_most_rec <= 0.5 => 0.0909249368072198,
                                            -0.090590246024558);

mod_2seg_aa_code_12_1 := map(
    rv_f03_input_add_not_most_rec = NULL => '',
    rv_f03_input_add_not_most_rec = -1   => 'C12',
    rv_f03_input_add_not_most_rec <= 0.5 => 'F03',
                                            'F03');

mod_2seg_aa_dist_12 := mod_2seg_v12_w - 0.073147834500382;

mod_2seg_aa_code_12 := if(mod_2seg_aa_dist_12 = 0, '', mod_2seg_aa_code_12_1);

mod_2seg_v13_w := map(
    rv_c12_num_nonderogs = NULL => 0,
    rv_c12_num_nonderogs = -1   => 0,
    rv_c12_num_nonderogs <= 1.5 => -0.102722928448693,
    rv_c12_num_nonderogs <= 2.5 => -0.0140248957533652,
    rv_c12_num_nonderogs <= 3.5 => 0.032336362079066,
                                   0.100076383594709);

mod_2seg_aa_code_13_1 := map(
    rv_c12_num_nonderogs = NULL => '',
    rv_c12_num_nonderogs = -1   => 'C12',
    rv_c12_num_nonderogs <= 1.5 => 'C12',
    rv_c12_num_nonderogs <= 2.5 => 'C12',
    rv_c12_num_nonderogs <= 3.5 => 'C12',
                                   'C12');

mod_2seg_aa_dist_13 := mod_2seg_v13_w - -0.000747328720925;

mod_2seg_aa_code_13 := if(mod_2seg_aa_dist_13 = 0, '', mod_2seg_aa_code_13_1);

mod_2seg_v14_w := map(
    rv_d30_derog_count = NULL => 0,
    rv_d30_derog_count = -1   => 0,
    rv_d30_derog_count <= 1.5 => 0.0560743820093023,
    rv_d30_derog_count <= 3.5 => -0.0277529453306505,
                                 -0.127940898944523);

mod_2seg_aa_code_14_1 := map(
    rv_d30_derog_count = NULL => '',
    rv_d30_derog_count = -1   => 'C12',
    rv_d30_derog_count <= 1.5 => 'D30',
    rv_d30_derog_count <= 3.5 => 'D30',
                                 'D30');

mod_2seg_aa_dist_14 := mod_2seg_v14_w - 0.023808492013372;

mod_2seg_aa_code_14 := if(mod_2seg_aa_dist_14 = 0, '', mod_2seg_aa_code_14_1);

mod_2seg_v15_w := map(
    rv_i62_inq_addrs_per_adl = NULL => 0,
    rv_i62_inq_addrs_per_adl = -1   => 0,
    rv_i62_inq_addrs_per_adl <= 0.5 => 0.0376165330984012,
    rv_i62_inq_addrs_per_adl <= 1.5 => -0.00255721889385709,
    rv_i62_inq_addrs_per_adl <= 2.5 => -0.0109597467659405,
    rv_i62_inq_addrs_per_adl <= 3.5 => -0.154741149972177,
                                       -0.161363112644467);

mod_2seg_aa_code_15_1 := map(
    rv_i62_inq_addrs_per_adl = NULL => '',
    rv_i62_inq_addrs_per_adl = -1   => 'C12',
    rv_i62_inq_addrs_per_adl <= 0.5 => 'I62',
    rv_i62_inq_addrs_per_adl <= 1.5 => 'I62',
    rv_i62_inq_addrs_per_adl <= 2.5 => 'I62',
    rv_i62_inq_addrs_per_adl <= 3.5 => 'I62',
                                       'I62');

mod_2seg_aa_dist_15 := mod_2seg_v15_w - 0.007018513385240;

mod_2seg_aa_code_15 := if(mod_2seg_aa_dist_15 = 0, '', mod_2seg_aa_code_15_1);

mod_2seg_aa_code_00 := 'D30';

mod_2seg_aa_dist_00 := 2.7105644736 - 3.0666707304;

mod_2seg_rcvaluei60 := (integer)(mod_2seg_aa_code_00 = 'I60') * mod_2seg_aa_dist_00 +
    (integer)(mod_2seg_aa_code_01 = 'I60') * mod_2seg_aa_dist_01 +
    (integer)(mod_2seg_aa_code_02 = 'I60') * mod_2seg_aa_dist_02 +
    (integer)(mod_2seg_aa_code_03 = 'I60') * mod_2seg_aa_dist_03 +
    (integer)(mod_2seg_aa_code_04 = 'I60') * mod_2seg_aa_dist_04 +
    (integer)(mod_2seg_aa_code_05 = 'I60') * mod_2seg_aa_dist_05 +
    (integer)(mod_2seg_aa_code_06 = 'I60') * mod_2seg_aa_dist_06 +
    (integer)(mod_2seg_aa_code_07 = 'I60') * mod_2seg_aa_dist_07 +
    (integer)(mod_2seg_aa_code_08 = 'I60') * mod_2seg_aa_dist_08 +
    (integer)(mod_2seg_aa_code_09 = 'I60') * mod_2seg_aa_dist_09 +
    (integer)(mod_2seg_aa_code_10 = 'I60') * mod_2seg_aa_dist_10 +
    (integer)(mod_2seg_aa_code_11 = 'I60') * mod_2seg_aa_dist_11 +
    (integer)(mod_2seg_aa_code_12 = 'I60') * mod_2seg_aa_dist_12 +
    (integer)(mod_2seg_aa_code_13 = 'I60') * mod_2seg_aa_dist_13 +
    (integer)(mod_2seg_aa_code_14 = 'I60') * mod_2seg_aa_dist_14 +
    (integer)(mod_2seg_aa_code_15 = 'I60') * mod_2seg_aa_dist_15;

mod_2seg_rcvalued33 := (integer)(mod_2seg_aa_code_00 = 'D33') * mod_2seg_aa_dist_00 +
    (integer)(mod_2seg_aa_code_01 = 'D33') * mod_2seg_aa_dist_01 +
    (integer)(mod_2seg_aa_code_02 = 'D33') * mod_2seg_aa_dist_02 +
    (integer)(mod_2seg_aa_code_03 = 'D33') * mod_2seg_aa_dist_03 +
    (integer)(mod_2seg_aa_code_04 = 'D33') * mod_2seg_aa_dist_04 +
    (integer)(mod_2seg_aa_code_05 = 'D33') * mod_2seg_aa_dist_05 +
    (integer)(mod_2seg_aa_code_06 = 'D33') * mod_2seg_aa_dist_06 +
    (integer)(mod_2seg_aa_code_07 = 'D33') * mod_2seg_aa_dist_07 +
    (integer)(mod_2seg_aa_code_08 = 'D33') * mod_2seg_aa_dist_08 +
    (integer)(mod_2seg_aa_code_09 = 'D33') * mod_2seg_aa_dist_09 +
    (integer)(mod_2seg_aa_code_10 = 'D33') * mod_2seg_aa_dist_10 +
    (integer)(mod_2seg_aa_code_11 = 'D33') * mod_2seg_aa_dist_11 +
    (integer)(mod_2seg_aa_code_12 = 'D33') * mod_2seg_aa_dist_12 +
    (integer)(mod_2seg_aa_code_13 = 'D33') * mod_2seg_aa_dist_13 +
    (integer)(mod_2seg_aa_code_14 = 'D33') * mod_2seg_aa_dist_14 +
    (integer)(mod_2seg_aa_code_15 = 'D33') * mod_2seg_aa_dist_15;

mod_2seg_rcvalued32 := (integer)(mod_2seg_aa_code_00 = 'D32') * mod_2seg_aa_dist_00 +
    (integer)(mod_2seg_aa_code_01 = 'D32') * mod_2seg_aa_dist_01 +
    (integer)(mod_2seg_aa_code_02 = 'D32') * mod_2seg_aa_dist_02 +
    (integer)(mod_2seg_aa_code_03 = 'D32') * mod_2seg_aa_dist_03 +
    (integer)(mod_2seg_aa_code_04 = 'D32') * mod_2seg_aa_dist_04 +
    (integer)(mod_2seg_aa_code_05 = 'D32') * mod_2seg_aa_dist_05 +
    (integer)(mod_2seg_aa_code_06 = 'D32') * mod_2seg_aa_dist_06 +
    (integer)(mod_2seg_aa_code_07 = 'D32') * mod_2seg_aa_dist_07 +
    (integer)(mod_2seg_aa_code_08 = 'D32') * mod_2seg_aa_dist_08 +
    (integer)(mod_2seg_aa_code_09 = 'D32') * mod_2seg_aa_dist_09 +
    (integer)(mod_2seg_aa_code_10 = 'D32') * mod_2seg_aa_dist_10 +
    (integer)(mod_2seg_aa_code_11 = 'D32') * mod_2seg_aa_dist_11 +
    (integer)(mod_2seg_aa_code_12 = 'D32') * mod_2seg_aa_dist_12 +
    (integer)(mod_2seg_aa_code_13 = 'D32') * mod_2seg_aa_dist_13 +
    (integer)(mod_2seg_aa_code_14 = 'D32') * mod_2seg_aa_dist_14 +
    (integer)(mod_2seg_aa_code_15 = 'D32') * mod_2seg_aa_dist_15;

mod_2seg_rcvaluea42 := (integer)(mod_2seg_aa_code_00 = 'A42') * mod_2seg_aa_dist_00 +
    (integer)(mod_2seg_aa_code_01 = 'A42') * mod_2seg_aa_dist_01 +
    (integer)(mod_2seg_aa_code_02 = 'A42') * mod_2seg_aa_dist_02 +
    (integer)(mod_2seg_aa_code_03 = 'A42') * mod_2seg_aa_dist_03 +
    (integer)(mod_2seg_aa_code_04 = 'A42') * mod_2seg_aa_dist_04 +
    (integer)(mod_2seg_aa_code_05 = 'A42') * mod_2seg_aa_dist_05 +
    (integer)(mod_2seg_aa_code_06 = 'A42') * mod_2seg_aa_dist_06 +
    (integer)(mod_2seg_aa_code_07 = 'A42') * mod_2seg_aa_dist_07 +
    (integer)(mod_2seg_aa_code_08 = 'A42') * mod_2seg_aa_dist_08 +
    (integer)(mod_2seg_aa_code_09 = 'A42') * mod_2seg_aa_dist_09 +
    (integer)(mod_2seg_aa_code_10 = 'A42') * mod_2seg_aa_dist_10 +
    (integer)(mod_2seg_aa_code_11 = 'A42') * mod_2seg_aa_dist_11 +
    (integer)(mod_2seg_aa_code_12 = 'A42') * mod_2seg_aa_dist_12 +
    (integer)(mod_2seg_aa_code_13 = 'A42') * mod_2seg_aa_dist_13 +
    (integer)(mod_2seg_aa_code_14 = 'A42') * mod_2seg_aa_dist_14 +
    (integer)(mod_2seg_aa_code_15 = 'A42') * mod_2seg_aa_dist_15;

mod_2seg_rcvaluec20 := (integer)(mod_2seg_aa_code_00 = 'C20') * mod_2seg_aa_dist_00 +
    (integer)(mod_2seg_aa_code_01 = 'C20') * mod_2seg_aa_dist_01 +
    (integer)(mod_2seg_aa_code_02 = 'C20') * mod_2seg_aa_dist_02 +
    (integer)(mod_2seg_aa_code_03 = 'C20') * mod_2seg_aa_dist_03 +
    (integer)(mod_2seg_aa_code_04 = 'C20') * mod_2seg_aa_dist_04 +
    (integer)(mod_2seg_aa_code_05 = 'C20') * mod_2seg_aa_dist_05 +
    (integer)(mod_2seg_aa_code_06 = 'C20') * mod_2seg_aa_dist_06 +
    (integer)(mod_2seg_aa_code_07 = 'C20') * mod_2seg_aa_dist_07 +
    (integer)(mod_2seg_aa_code_08 = 'C20') * mod_2seg_aa_dist_08 +
    (integer)(mod_2seg_aa_code_09 = 'C20') * mod_2seg_aa_dist_09 +
    (integer)(mod_2seg_aa_code_10 = 'C20') * mod_2seg_aa_dist_10 +
    (integer)(mod_2seg_aa_code_11 = 'C20') * mod_2seg_aa_dist_11 +
    (integer)(mod_2seg_aa_code_12 = 'C20') * mod_2seg_aa_dist_12 +
    (integer)(mod_2seg_aa_code_13 = 'C20') * mod_2seg_aa_dist_13 +
    (integer)(mod_2seg_aa_code_14 = 'C20') * mod_2seg_aa_dist_14 +
    (integer)(mod_2seg_aa_code_15 = 'C20') * mod_2seg_aa_dist_15;

mod_2seg_rcvaluec22 := (integer)(mod_2seg_aa_code_00 = 'C22') * mod_2seg_aa_dist_00 +
    (integer)(mod_2seg_aa_code_01 = 'C22') * mod_2seg_aa_dist_01 +
    (integer)(mod_2seg_aa_code_02 = 'C22') * mod_2seg_aa_dist_02 +
    (integer)(mod_2seg_aa_code_03 = 'C22') * mod_2seg_aa_dist_03 +
    (integer)(mod_2seg_aa_code_04 = 'C22') * mod_2seg_aa_dist_04 +
    (integer)(mod_2seg_aa_code_05 = 'C22') * mod_2seg_aa_dist_05 +
    (integer)(mod_2seg_aa_code_06 = 'C22') * mod_2seg_aa_dist_06 +
    (integer)(mod_2seg_aa_code_07 = 'C22') * mod_2seg_aa_dist_07 +
    (integer)(mod_2seg_aa_code_08 = 'C22') * mod_2seg_aa_dist_08 +
    (integer)(mod_2seg_aa_code_09 = 'C22') * mod_2seg_aa_dist_09 +
    (integer)(mod_2seg_aa_code_10 = 'C22') * mod_2seg_aa_dist_10 +
    (integer)(mod_2seg_aa_code_11 = 'C22') * mod_2seg_aa_dist_11 +
    (integer)(mod_2seg_aa_code_12 = 'C22') * mod_2seg_aa_dist_12 +
    (integer)(mod_2seg_aa_code_13 = 'C22') * mod_2seg_aa_dist_13 +
    (integer)(mod_2seg_aa_code_14 = 'C22') * mod_2seg_aa_dist_14 +
    (integer)(mod_2seg_aa_code_15 = 'C22') * mod_2seg_aa_dist_15;

mod_2seg_rcvaluec12 := (integer)(mod_2seg_aa_code_00 = 'C12') * mod_2seg_aa_dist_00 +
    (integer)(mod_2seg_aa_code_01 = 'C12') * mod_2seg_aa_dist_01 +
    (integer)(mod_2seg_aa_code_02 = 'C12') * mod_2seg_aa_dist_02 +
    (integer)(mod_2seg_aa_code_03 = 'C12') * mod_2seg_aa_dist_03 +
    (integer)(mod_2seg_aa_code_04 = 'C12') * mod_2seg_aa_dist_04 +
    (integer)(mod_2seg_aa_code_05 = 'C12') * mod_2seg_aa_dist_05 +
    (integer)(mod_2seg_aa_code_06 = 'C12') * mod_2seg_aa_dist_06 +
    (integer)(mod_2seg_aa_code_07 = 'C12') * mod_2seg_aa_dist_07 +
    (integer)(mod_2seg_aa_code_08 = 'C12') * mod_2seg_aa_dist_08 +
    (integer)(mod_2seg_aa_code_09 = 'C12') * mod_2seg_aa_dist_09 +
    (integer)(mod_2seg_aa_code_10 = 'C12') * mod_2seg_aa_dist_10 +
    (integer)(mod_2seg_aa_code_11 = 'C12') * mod_2seg_aa_dist_11 +
    (integer)(mod_2seg_aa_code_12 = 'C12') * mod_2seg_aa_dist_12 +
    (integer)(mod_2seg_aa_code_13 = 'C12') * mod_2seg_aa_dist_13 +
    (integer)(mod_2seg_aa_code_14 = 'C12') * mod_2seg_aa_dist_14 +
    (integer)(mod_2seg_aa_code_15 = 'C12') * mod_2seg_aa_dist_15;

mod_2seg_rcvalued30 := (integer)(mod_2seg_aa_code_00 = 'D30') * mod_2seg_aa_dist_00 +
    (integer)(mod_2seg_aa_code_01 = 'D30') * mod_2seg_aa_dist_01 +
    (integer)(mod_2seg_aa_code_02 = 'D30') * mod_2seg_aa_dist_02 +
    (integer)(mod_2seg_aa_code_03 = 'D30') * mod_2seg_aa_dist_03 +
    (integer)(mod_2seg_aa_code_04 = 'D30') * mod_2seg_aa_dist_04 +
    (integer)(mod_2seg_aa_code_05 = 'D30') * mod_2seg_aa_dist_05 +
    (integer)(mod_2seg_aa_code_06 = 'D30') * mod_2seg_aa_dist_06 +
    (integer)(mod_2seg_aa_code_07 = 'D30') * mod_2seg_aa_dist_07 +
    (integer)(mod_2seg_aa_code_08 = 'D30') * mod_2seg_aa_dist_08 +
    (integer)(mod_2seg_aa_code_09 = 'D30') * mod_2seg_aa_dist_09 +
    (integer)(mod_2seg_aa_code_10 = 'D30') * mod_2seg_aa_dist_10 +
    (integer)(mod_2seg_aa_code_11 = 'D30') * mod_2seg_aa_dist_11 +
    (integer)(mod_2seg_aa_code_12 = 'D30') * mod_2seg_aa_dist_12 +
    (integer)(mod_2seg_aa_code_13 = 'D30') * mod_2seg_aa_dist_13 +
    (integer)(mod_2seg_aa_code_14 = 'D30') * mod_2seg_aa_dist_14 +
    (integer)(mod_2seg_aa_code_15 = 'D30') * mod_2seg_aa_dist_15;

mod_2seg_rcvalued31 := (integer)(mod_2seg_aa_code_00 = 'D31') * mod_2seg_aa_dist_00 +
    (integer)(mod_2seg_aa_code_01 = 'D31') * mod_2seg_aa_dist_01 +
    (integer)(mod_2seg_aa_code_02 = 'D31') * mod_2seg_aa_dist_02 +
    (integer)(mod_2seg_aa_code_03 = 'D31') * mod_2seg_aa_dist_03 +
    (integer)(mod_2seg_aa_code_04 = 'D31') * mod_2seg_aa_dist_04 +
    (integer)(mod_2seg_aa_code_05 = 'D31') * mod_2seg_aa_dist_05 +
    (integer)(mod_2seg_aa_code_06 = 'D31') * mod_2seg_aa_dist_06 +
    (integer)(mod_2seg_aa_code_07 = 'D31') * mod_2seg_aa_dist_07 +
    (integer)(mod_2seg_aa_code_08 = 'D31') * mod_2seg_aa_dist_08 +
    (integer)(mod_2seg_aa_code_09 = 'D31') * mod_2seg_aa_dist_09 +
    (integer)(mod_2seg_aa_code_10 = 'D31') * mod_2seg_aa_dist_10 +
    (integer)(mod_2seg_aa_code_11 = 'D31') * mod_2seg_aa_dist_11 +
    (integer)(mod_2seg_aa_code_12 = 'D31') * mod_2seg_aa_dist_12 +
    (integer)(mod_2seg_aa_code_13 = 'D31') * mod_2seg_aa_dist_13 +
    (integer)(mod_2seg_aa_code_14 = 'D31') * mod_2seg_aa_dist_14 +
    (integer)(mod_2seg_aa_code_15 = 'D31') * mod_2seg_aa_dist_15;

mod_2seg_rcvaluei62 := (integer)(mod_2seg_aa_code_00 = 'I62') * mod_2seg_aa_dist_00 +
    (integer)(mod_2seg_aa_code_01 = 'I62') * mod_2seg_aa_dist_01 +
    (integer)(mod_2seg_aa_code_02 = 'I62') * mod_2seg_aa_dist_02 +
    (integer)(mod_2seg_aa_code_03 = 'I62') * mod_2seg_aa_dist_03 +
    (integer)(mod_2seg_aa_code_04 = 'I62') * mod_2seg_aa_dist_04 +
    (integer)(mod_2seg_aa_code_05 = 'I62') * mod_2seg_aa_dist_05 +
    (integer)(mod_2seg_aa_code_06 = 'I62') * mod_2seg_aa_dist_06 +
    (integer)(mod_2seg_aa_code_07 = 'I62') * mod_2seg_aa_dist_07 +
    (integer)(mod_2seg_aa_code_08 = 'I62') * mod_2seg_aa_dist_08 +
    (integer)(mod_2seg_aa_code_09 = 'I62') * mod_2seg_aa_dist_09 +
    (integer)(mod_2seg_aa_code_10 = 'I62') * mod_2seg_aa_dist_10 +
    (integer)(mod_2seg_aa_code_11 = 'I62') * mod_2seg_aa_dist_11 +
    (integer)(mod_2seg_aa_code_12 = 'I62') * mod_2seg_aa_dist_12 +
    (integer)(mod_2seg_aa_code_13 = 'I62') * mod_2seg_aa_dist_13 +
    (integer)(mod_2seg_aa_code_14 = 'I62') * mod_2seg_aa_dist_14 +
    (integer)(mod_2seg_aa_code_15 = 'I62') * mod_2seg_aa_dist_15;

mod_2seg_rcvaluef03 := (integer)(mod_2seg_aa_code_00 = 'F03') * mod_2seg_aa_dist_00 +
    (integer)(mod_2seg_aa_code_01 = 'F03') * mod_2seg_aa_dist_01 +
    (integer)(mod_2seg_aa_code_02 = 'F03') * mod_2seg_aa_dist_02 +
    (integer)(mod_2seg_aa_code_03 = 'F03') * mod_2seg_aa_dist_03 +
    (integer)(mod_2seg_aa_code_04 = 'F03') * mod_2seg_aa_dist_04 +
    (integer)(mod_2seg_aa_code_05 = 'F03') * mod_2seg_aa_dist_05 +
    (integer)(mod_2seg_aa_code_06 = 'F03') * mod_2seg_aa_dist_06 +
    (integer)(mod_2seg_aa_code_07 = 'F03') * mod_2seg_aa_dist_07 +
    (integer)(mod_2seg_aa_code_08 = 'F03') * mod_2seg_aa_dist_08 +
    (integer)(mod_2seg_aa_code_09 = 'F03') * mod_2seg_aa_dist_09 +
    (integer)(mod_2seg_aa_code_10 = 'F03') * mod_2seg_aa_dist_10 +
    (integer)(mod_2seg_aa_code_11 = 'F03') * mod_2seg_aa_dist_11 +
    (integer)(mod_2seg_aa_code_12 = 'F03') * mod_2seg_aa_dist_12 +
    (integer)(mod_2seg_aa_code_13 = 'F03') * mod_2seg_aa_dist_13 +
    (integer)(mod_2seg_aa_code_14 = 'F03') * mod_2seg_aa_dist_14 +
    (integer)(mod_2seg_aa_code_15 = 'F03') * mod_2seg_aa_dist_15;

mod_2seg_lgt := 1.72673003150525 +
    mod_2seg_v01_w +
    mod_2seg_v02_w +
    mod_2seg_v03_w +
    mod_2seg_v04_w +
    mod_2seg_v05_w +
    mod_2seg_v06_w +
    mod_2seg_v07_w +
    mod_2seg_v08_w +
    mod_2seg_v09_w +
    mod_2seg_v10_w +
    mod_2seg_v11_w +
    mod_2seg_v12_w +
    mod_2seg_v13_w +
    mod_2seg_v14_w +
    mod_2seg_v15_w;

mod_3seg_v01_w := map(
    rv_i60_inq_peradl_count12 = NULL  => 0,
    rv_i60_inq_peradl_count12 = -1    => 0,
    rv_i60_inq_peradl_count12 <= 0.5  => 0.295356170189595,
    rv_i60_inq_peradl_count12 <= 1.5  => 0.037364693626217,
    rv_i60_inq_peradl_count12 <= 2.5  => -0.165805307097362,
    rv_i60_inq_peradl_count12 <= 3.5  => -0.369732623370384,
    rv_i60_inq_peradl_count12 <= 6.5  => -0.384447646741991,
    rv_i60_inq_peradl_count12 <= 11.5 => -0.500161742854668,
                                         -0.644429339352506);

mod_3seg_aa_code_01_1 := map(
    rv_i60_inq_peradl_count12 = NULL  => '',
    rv_i60_inq_peradl_count12 = -1    => 'C12',
    rv_i60_inq_peradl_count12 <= 0.5  => 'I60',
    rv_i60_inq_peradl_count12 <= 1.5  => 'I60',
    rv_i60_inq_peradl_count12 <= 2.5  => 'I60',
    rv_i60_inq_peradl_count12 <= 3.5  => 'I60',
    rv_i60_inq_peradl_count12 <= 6.5  => 'I60',
    rv_i60_inq_peradl_count12 <= 11.5 => 'I60',
                                         'I60');

mod_3seg_aa_dist_01 := mod_3seg_v01_w - 0.132641449915786;

mod_3seg_aa_code_01 := if(mod_3seg_aa_dist_01 = 0, '', mod_3seg_aa_code_01_1);

mod_3seg_v02_w := map(
    rv_i60_inq_hiriskcred_count12 = NULL => 0,
    rv_i60_inq_hiriskcred_count12 = -1   => 0,
    rv_i60_inq_hiriskcred_count12 <= 0.5 => 0.242463181469599,
    rv_i60_inq_hiriskcred_count12 <= 2.5 => -0.187913373663137,
                                            -0.519350128853428);

mod_3seg_aa_code_02_1 := map(
    rv_i60_inq_hiriskcred_count12 = NULL => '',
    rv_i60_inq_hiriskcred_count12 = -1   => 'C12',
    rv_i60_inq_hiriskcred_count12 <= 0.5 => 'I60',
    rv_i60_inq_hiriskcred_count12 <= 2.5 => 'I60',
                                            'I60');

mod_3seg_aa_dist_02 := mod_3seg_v02_w - 0.220253915209267;

mod_3seg_aa_code_02 := if(mod_3seg_aa_dist_02 = 0, '', mod_3seg_aa_code_02_1);

mod_3seg_v03_w := map(
    rv_c12_inp_addr_source_count = NULL => 0,
    rv_c12_inp_addr_source_count = -1   => 0,
    rv_c12_inp_addr_source_count <= 0.5 => -0.335288355563995,
    rv_c12_inp_addr_source_count <= 1.5 => -0.281672595118002,
    rv_c12_inp_addr_source_count <= 2.5 => 0.00271933025316115,
    rv_c12_inp_addr_source_count <= 4.5 => 0.100137813867834,
                                           0.303582559263485);

mod_3seg_aa_code_03_1 := map(
    rv_c12_inp_addr_source_count = NULL => '',
    rv_c12_inp_addr_source_count = -1   => 'C12',
    rv_c12_inp_addr_source_count <= 0.5 => 'C12',
    rv_c12_inp_addr_source_count <= 1.5 => 'C12',
    rv_c12_inp_addr_source_count <= 2.5 => 'C12',
    rv_c12_inp_addr_source_count <= 4.5 => 'C12',
                                           'C12');

mod_3seg_aa_dist_03 := mod_3seg_v03_w - 0.018352274003348;

mod_3seg_aa_code_03 := if(mod_3seg_aa_dist_03 = 0, '', mod_3seg_aa_code_03_1);

mod_3seg_v04_w := map(
    iv_c13_avg_lres = NULL   => 0,
    iv_c13_avg_lres = -1     => 0,
    iv_c13_avg_lres <= 18.5  => -0.38563963847367,
    iv_c13_avg_lres <= 38.5  => -0.221635388504596,
    iv_c13_avg_lres <= 61.5  => -0.0302263326587231,
    iv_c13_avg_lres <= 119.5 => 0.0267381749977849,
    iv_c13_avg_lres <= 355.5 => 0.135514390101829,
                                0.260569072817679);

mod_3seg_aa_code_04_1 := map(
    iv_c13_avg_lres = NULL   => '',
    iv_c13_avg_lres = -1     => 'C12',
    iv_c13_avg_lres <= 18.5  => 'C13',
    iv_c13_avg_lres <= 38.5  => 'C13',
    iv_c13_avg_lres <= 61.5  => 'C13',
    iv_c13_avg_lres <= 119.5 => 'C13',
    iv_c13_avg_lres <= 355.5 => 'C13',
                                'C13');

mod_3seg_aa_dist_04 := mod_3seg_v04_w - 0.009818020374847;

mod_3seg_aa_code_04 := if(mod_3seg_aa_dist_04 = 0, '', mod_3seg_aa_code_04_1);

mod_3seg_v05_w := map(
    rv_i60_inq_comm_count12 = NULL => 0,
    rv_i60_inq_comm_count12 = -1   => 0,
    rv_i60_inq_comm_count12 <= 0.5 => 0.147684389327568,
                                      -0.1514683789078);

mod_3seg_aa_code_05_1 := map(
    rv_i60_inq_comm_count12 = NULL => '',
    rv_i60_inq_comm_count12 = -1   => 'C12',
    rv_i60_inq_comm_count12 <= 0.5 => 'I60',
                                      'I60');

mod_3seg_aa_dist_05 := mod_3seg_v05_w - 0.139883990907447;

mod_3seg_aa_code_05 := if(mod_3seg_aa_dist_05 = 0, '', mod_3seg_aa_code_05_1);

mod_3seg_v06_w := map(
    rv_c12_num_nonderogs = NULL => 0,
    rv_c12_num_nonderogs = -1   => 0,
    rv_c12_num_nonderogs <= 1.5 => -0.215765598729425,
    rv_c12_num_nonderogs <= 3.5 => -0.118706715127933,
                                   0.15478017305561);

mod_3seg_aa_code_06_1 := map(
    rv_c12_num_nonderogs = NULL => '',
    rv_c12_num_nonderogs = -1   => 'C12',
    rv_c12_num_nonderogs <= 1.5 => 'C12',
    rv_c12_num_nonderogs <= 3.5 => 'C12',
                                   'C12');

mod_3seg_aa_dist_06 := mod_3seg_v06_w - -0.048064064008505;

mod_3seg_aa_code_06 := if(mod_3seg_aa_dist_06 = 0, '', mod_3seg_aa_code_06_1);

mod_3seg_v07_w := map(
    iv_c22_addr_ver_sources = NULL => 0,
    iv_c22_addr_ver_sources = -1   => 0,
    iv_c22_addr_ver_sources <= 1.5 => -0.233464991248531,
    iv_c22_addr_ver_sources <= 2.5 => -0.0330152339408251,
                                      0.132450237105215);

mod_3seg_aa_code_07_1 := map(
    iv_c22_addr_ver_sources = NULL => '',
    iv_c22_addr_ver_sources = -1   => 'C12',
    iv_c22_addr_ver_sources <= 1.5 => 'C22',
    iv_c22_addr_ver_sources <= 2.5 => 'C22',
                                      'C22');

mod_3seg_aa_dist_07 := mod_3seg_v07_w - 0.000733846671826;

mod_3seg_aa_code_07 := if(mod_3seg_aa_dist_07 = 0, '', mod_3seg_aa_code_07_1);

mod_3seg_v08_w := map(
    rv_s66_adlperssn_count = NULL => 0,
    rv_s66_adlperssn_count = -1   => 0,
    rv_s66_adlperssn_count <= 1.5 => 0.0952791293829527,
    rv_s66_adlperssn_count <= 2.5 => -0.043845868481858,
    rv_s66_adlperssn_count <= 3.5 => -0.104154967620993,
                                     -0.157697410931589);

mod_3seg_aa_code_08_1 := map(
    rv_s66_adlperssn_count = NULL => '',
    rv_s66_adlperssn_count = -1   => 'C12',
    rv_s66_adlperssn_count <= 1.5 => 'S66',
    rv_s66_adlperssn_count <= 2.5 => 'S66',
    rv_s66_adlperssn_count <= 3.5 => 'S66',
                                     'S66');

mod_3seg_aa_dist_08 := mod_3seg_v08_w - 0.028575445761254;

mod_3seg_aa_code_08 := if(mod_3seg_aa_dist_08 = 0, '', mod_3seg_aa_code_08_1);

mod_3seg_rcvaluei60 := (integer)(mod_3seg_aa_code_01 = 'I60') * mod_3seg_aa_dist_01 +
    (integer)(mod_3seg_aa_code_02 = 'I60') * mod_3seg_aa_dist_02 +
    (integer)(mod_3seg_aa_code_03 = 'I60') * mod_3seg_aa_dist_03 +
    (integer)(mod_3seg_aa_code_04 = 'I60') * mod_3seg_aa_dist_04 +
    (integer)(mod_3seg_aa_code_05 = 'I60') * mod_3seg_aa_dist_05 +
    (integer)(mod_3seg_aa_code_06 = 'I60') * mod_3seg_aa_dist_06 +
    (integer)(mod_3seg_aa_code_07 = 'I60') * mod_3seg_aa_dist_07 +
    (integer)(mod_3seg_aa_code_08 = 'I60') * mod_3seg_aa_dist_08;

mod_3seg_rcvaluec13 := (integer)(mod_3seg_aa_code_01 = 'C13') * mod_3seg_aa_dist_01 +
    (integer)(mod_3seg_aa_code_02 = 'C13') * mod_3seg_aa_dist_02 +
    (integer)(mod_3seg_aa_code_03 = 'C13') * mod_3seg_aa_dist_03 +
    (integer)(mod_3seg_aa_code_04 = 'C13') * mod_3seg_aa_dist_04 +
    (integer)(mod_3seg_aa_code_05 = 'C13') * mod_3seg_aa_dist_05 +
    (integer)(mod_3seg_aa_code_06 = 'C13') * mod_3seg_aa_dist_06 +
    (integer)(mod_3seg_aa_code_07 = 'C13') * mod_3seg_aa_dist_07 +
    (integer)(mod_3seg_aa_code_08 = 'C13') * mod_3seg_aa_dist_08;

mod_3seg_rcvaluec12 := (integer)(mod_3seg_aa_code_01 = 'C12') * mod_3seg_aa_dist_01 +
    (integer)(mod_3seg_aa_code_02 = 'C12') * mod_3seg_aa_dist_02 +
    (integer)(mod_3seg_aa_code_03 = 'C12') * mod_3seg_aa_dist_03 +
    (integer)(mod_3seg_aa_code_04 = 'C12') * mod_3seg_aa_dist_04 +
    (integer)(mod_3seg_aa_code_05 = 'C12') * mod_3seg_aa_dist_05 +
    (integer)(mod_3seg_aa_code_06 = 'C12') * mod_3seg_aa_dist_06 +
    (integer)(mod_3seg_aa_code_07 = 'C12') * mod_3seg_aa_dist_07 +
    (integer)(mod_3seg_aa_code_08 = 'C12') * mod_3seg_aa_dist_08;

mod_3seg_rcvalues66 := (integer)(mod_3seg_aa_code_01 = 'S66') * mod_3seg_aa_dist_01 +
    (integer)(mod_3seg_aa_code_02 = 'S66') * mod_3seg_aa_dist_02 +
    (integer)(mod_3seg_aa_code_03 = 'S66') * mod_3seg_aa_dist_03 +
    (integer)(mod_3seg_aa_code_04 = 'S66') * mod_3seg_aa_dist_04 +
    (integer)(mod_3seg_aa_code_05 = 'S66') * mod_3seg_aa_dist_05 +
    (integer)(mod_3seg_aa_code_06 = 'S66') * mod_3seg_aa_dist_06 +
    (integer)(mod_3seg_aa_code_07 = 'S66') * mod_3seg_aa_dist_07 +
    (integer)(mod_3seg_aa_code_08 = 'S66') * mod_3seg_aa_dist_08;

mod_3seg_rcvaluec22 := (integer)(mod_3seg_aa_code_01 = 'C22') * mod_3seg_aa_dist_01 +
    (integer)(mod_3seg_aa_code_02 = 'C22') * mod_3seg_aa_dist_02 +
    (integer)(mod_3seg_aa_code_03 = 'C22') * mod_3seg_aa_dist_03 +
    (integer)(mod_3seg_aa_code_04 = 'C22') * mod_3seg_aa_dist_04 +
    (integer)(mod_3seg_aa_code_05 = 'C22') * mod_3seg_aa_dist_05 +
    (integer)(mod_3seg_aa_code_06 = 'C22') * mod_3seg_aa_dist_06 +
    (integer)(mod_3seg_aa_code_07 = 'C22') * mod_3seg_aa_dist_07 +
    (integer)(mod_3seg_aa_code_08 = 'C22') * mod_3seg_aa_dist_08;

mod_3seg_lgt := 3.39423543115582 +
    mod_3seg_v01_w +
    mod_3seg_v02_w +
    mod_3seg_v03_w +
    mod_3seg_v04_w +
    mod_3seg_v05_w +
    mod_3seg_v06_w +
    mod_3seg_v07_w +
    mod_3seg_v08_w;

mod_4seg_v01_w := map(
    rv_f01_inp_addr_address_score = NULL => 0,
    rv_f01_inp_addr_address_score = -1   => 0,
    rv_f01_inp_addr_address_score <= 5   => -0.433986519434718,
    rv_f01_inp_addr_address_score <= 25  => -0.298808685197101,
    rv_f01_inp_addr_address_score <= 45  => -0.259916606430612,
    rv_f01_inp_addr_address_score <= 55  => -0.181228550849801,
    rv_f01_inp_addr_address_score <= 95  => 0.111813983369269,
                                            0.207249570226088);

mod_4seg_aa_code_01_1 := map(
    rv_f01_inp_addr_address_score = NULL => '',
    rv_f01_inp_addr_address_score = -1   => 'C12',
    rv_f01_inp_addr_address_score <= 5   => 'F01',
    rv_f01_inp_addr_address_score <= 25  => 'F01',
    rv_f01_inp_addr_address_score <= 45  => 'F01',
    rv_f01_inp_addr_address_score <= 55  => 'F01',
    rv_f01_inp_addr_address_score <= 95  => 'F01',
                                            'F01');

mod_4seg_aa_dist_01 := mod_4seg_v01_w - 0.077143320877703;

mod_4seg_aa_code_01 := if(mod_4seg_aa_dist_01 = 0, '', mod_4seg_aa_code_01_1);

mod_4seg_v02_w := map(
    rv_i60_inq_hiriskcred_count12 = NULL => 0,
    rv_i60_inq_hiriskcred_count12 = -1   => 0,
    rv_i60_inq_hiriskcred_count12 <= 0.5 => 0.192710206235719,
    rv_i60_inq_hiriskcred_count12 <= 1.5 => -0.131083199129421,
    rv_i60_inq_hiriskcred_count12 <= 4.5 => -0.273232626941831,
                                            -0.328658779076749);

mod_4seg_aa_code_02_1 := map(
    rv_i60_inq_hiriskcred_count12 = NULL => '',
    rv_i60_inq_hiriskcred_count12 = -1   => 'C12',
    rv_i60_inq_hiriskcred_count12 <= 0.5 => 'I60',
    rv_i60_inq_hiriskcred_count12 <= 1.5 => 'I60',
    rv_i60_inq_hiriskcred_count12 <= 4.5 => 'I60',
                                            'I60');

mod_4seg_aa_dist_02 := mod_4seg_v02_w - 0.165445102962025;

mod_4seg_aa_code_02 := if(mod_4seg_aa_dist_02 = 0, '', mod_4seg_aa_code_02_1);

mod_4seg_v03_w := map(
    rv_i60_inq_comm_count12 = NULL => 0,
    rv_i60_inq_comm_count12 = -1   => 0,
    rv_i60_inq_comm_count12 <= 0.5 => 0.137173926086035,
    rv_i60_inq_comm_count12 <= 1.5 => -0.0931588473083642,
    rv_i60_inq_comm_count12 <= 2.5 => -0.302087449738621,
                                      -0.388748279592098);

mod_4seg_aa_code_03_1 := map(
    rv_i60_inq_comm_count12 = NULL => '',
    rv_i60_inq_comm_count12 = -1   => 'C12',
    rv_i60_inq_comm_count12 <= 0.5 => 'I60',
    rv_i60_inq_comm_count12 <= 1.5 => 'I60',
    rv_i60_inq_comm_count12 <= 2.5 => 'I60',
                                      'I60');

mod_4seg_aa_dist_03 := mod_4seg_v03_w - 0.115192940144222;

mod_4seg_aa_code_03 := if(mod_4seg_aa_dist_03 = 0, '', mod_4seg_aa_code_03_1);

mod_4seg_v04_w := map(
    rv_a41_a42_prop_owner_history = NULL => 0,
    rv_a41_a42_prop_owner_history = -1   => 0,
    rv_a41_a42_prop_owner_history <= 0.5 => -0.143241579660133,
                                            0.139243412209865);

mod_4seg_aa_code_04_1 := map(
    rv_a41_a42_prop_owner_history = NULL => '',
    rv_a41_a42_prop_owner_history = -1   => 'C12',
    rv_a41_a42_prop_owner_history <= 0.5 => 'A42',
                                            'A42');

mod_4seg_aa_dist_04 := mod_4seg_v04_w - -0.110817570067156;

mod_4seg_aa_code_04 := if(mod_4seg_aa_dist_04 = 0, '', mod_4seg_aa_code_04_1);

mod_4seg_v05_w := map(
    iv_c13_avg_lres = NULL  => 0,
    iv_c13_avg_lres = -1    => 0,
    iv_c13_avg_lres <= 0.5  => -0.315167453007455,
    iv_c13_avg_lres <= 9.5  => -0.201119065656299,
    iv_c13_avg_lres <= 11.5 => -0.1702938288192,
    iv_c13_avg_lres <= 14.5 => -0.137692792303926,
    iv_c13_avg_lres <= 19.5 => -0.107867218111511,
    iv_c13_avg_lres <= 27.5 => -0.0526754269815725,
    iv_c13_avg_lres <= 65.5 => 0.025264754874215,
    iv_c13_avg_lres <= 80.5 => 0.121512164573682,
                               0.23400320552356);

mod_4seg_aa_code_05_1 := map(
    iv_c13_avg_lres = NULL  => '',
    iv_c13_avg_lres = -1    => 'C12',
    iv_c13_avg_lres <= 0.5  => 'C13',
    iv_c13_avg_lres <= 9.5  => 'C13',
    iv_c13_avg_lres <= 11.5 => 'C13',
    iv_c13_avg_lres <= 14.5 => 'C13',
    iv_c13_avg_lres <= 19.5 => 'C13',
    iv_c13_avg_lres <= 27.5 => 'C13',
    iv_c13_avg_lres <= 65.5 => 'C13',
    iv_c13_avg_lres <= 80.5 => 'C13',
                               'C13');

mod_4seg_aa_dist_05 := mod_4seg_v05_w - 0.003484184302998;

mod_4seg_aa_code_05 := if(mod_4seg_aa_dist_05 = 0, '', mod_4seg_aa_code_05_1);

mod_4seg_v06_w := map(
    rv_i62_inq_phones_per_adl = NULL => 0,
    rv_i62_inq_phones_per_adl = -1   => 0,
    rv_i62_inq_phones_per_adl <= 0.5 => 0.0408202478296804,
    rv_i62_inq_phones_per_adl <= 1.5 => 0.0358482957202632,
    rv_i62_inq_phones_per_adl <= 2.5 => -0.123501952970982,
    rv_i62_inq_phones_per_adl <= 3.5 => -0.429459597531808,
                                        -0.76826989128546);

mod_4seg_aa_code_06_1 := map(
    rv_i62_inq_phones_per_adl = NULL => '',
    rv_i62_inq_phones_per_adl = -1   => 'C12',
    rv_i62_inq_phones_per_adl <= 0.5 => 'I62',
    rv_i62_inq_phones_per_adl <= 1.5 => 'I62',
    rv_i62_inq_phones_per_adl <= 2.5 => 'I62',
    rv_i62_inq_phones_per_adl <= 3.5 => 'I62',
                                        'I62');

mod_4seg_aa_dist_06 := mod_4seg_v06_w - 0.016942438106812;

mod_4seg_aa_code_06 := if(mod_4seg_aa_dist_06 = 0, '', mod_4seg_aa_code_06_1);

mod_4seg_v07_w := map(
    rv_f03_input_add_not_most_rec = NULL => 0,
    rv_f03_input_add_not_most_rec = -1   => 0,
    rv_f03_input_add_not_most_rec <= 0.5 => 0.111303491714623,
                                            -0.105405786317624);

mod_4seg_aa_code_07_1 := map(
    rv_f03_input_add_not_most_rec = NULL => '',
    rv_f03_input_add_not_most_rec = -1   => 'C12',
    rv_f03_input_add_not_most_rec <= 0.5 => 'F03',
                                            'F03');

mod_4seg_aa_dist_07 := mod_4seg_v07_w - 0.092670474269300;

mod_4seg_aa_code_07 := if(mod_4seg_aa_dist_07 = 0, '', mod_4seg_aa_code_07_1);

mod_4seg_v08_w := map(
    rv_i60_inq_other_count12 = NULL => 0,
    rv_i60_inq_other_count12 = -1   => 0,
    rv_i60_inq_other_count12 <= 0.5 => 0.102552679701445,
    rv_i60_inq_other_count12 <= 1.5 => -0.0638435883139208,
                                       -0.191808284144307);

mod_4seg_aa_code_08_1 := map(
    rv_i60_inq_other_count12 = NULL => '',
    rv_i60_inq_other_count12 = -1   => 'C12',
    rv_i60_inq_other_count12 <= 0.5 => 'I60',
    rv_i60_inq_other_count12 <= 1.5 => 'I60',
                                       'I60');

mod_4seg_aa_dist_08 := mod_4seg_v08_w - 0.079861174127450;

mod_4seg_aa_code_08 := if(mod_4seg_aa_dist_08 = 0, '', mod_4seg_aa_code_08_1);

mod_4seg_v09_w := map(
    rv_c12_num_nonderogs = NULL => 0,
    rv_c12_num_nonderogs = -1   => 0,
    rv_c12_num_nonderogs <= 2.5 => -0.0985347970585336,
    rv_c12_num_nonderogs <= 3.5 => 0.0578033215497907,
                                   0.180819189429437);

mod_4seg_aa_code_09_1 := map(
    rv_c12_num_nonderogs = NULL => '',
    rv_c12_num_nonderogs = -1   => 'C12',
    rv_c12_num_nonderogs <= 2.5 => 'C12',
    rv_c12_num_nonderogs <= 3.5 => 'C12',
                                   'C12');

mod_4seg_aa_dist_09 := mod_4seg_v09_w - -0.058321013846041;

mod_4seg_aa_code_09 := if(mod_4seg_aa_dist_09 = 0, '', mod_4seg_aa_code_09_1);

mod_4seg_v10_w := map(
    rv_s66_adlperssn_count = NULL => 0,
    rv_s66_adlperssn_count = -1   => 0,
    rv_s66_adlperssn_count <= 1.5 => 0.0987514104904147,
    rv_s66_adlperssn_count <= 2.5 => -0.0521582607695852,
    rv_s66_adlperssn_count <= 4.5 => -0.120093151571741,
                                     -0.254251943843476);

mod_4seg_aa_code_10_1 := map(
    rv_s66_adlperssn_count = NULL => '',
    rv_s66_adlperssn_count = -1   => 'C12',
    rv_s66_adlperssn_count <= 1.5 => 'S66',
    rv_s66_adlperssn_count <= 2.5 => 'S66',
    rv_s66_adlperssn_count <= 4.5 => 'S66',
                                     'S66');

mod_4seg_aa_dist_10 := mod_4seg_v10_w - 0.039458017947728;

mod_4seg_aa_code_10 := if(mod_4seg_aa_dist_10 = 0, '', mod_4seg_aa_code_10_1);

mod_4seg_v11_w := map(
    rv_c24_prv_addr_lres = NULL   => 0,
    rv_c24_prv_addr_lres = -1     => 0,
    rv_c24_prv_addr_lres <= 6.5   => -0.179391607318084,
    rv_c24_prv_addr_lres <= 8.5   => -0.117494232639158,
    rv_c24_prv_addr_lres <= 13.5  => -0.0896752277413831,
    rv_c24_prv_addr_lres <= 80.5  => -0.0681291231905933,
    rv_c24_prv_addr_lres <= 223.5 => -0.000633055158299913,
                                     0.0994306711663347);

mod_4seg_aa_code_11_1 := map(
    rv_c24_prv_addr_lres = NULL   => '',
    rv_c24_prv_addr_lres = -1     => 'C12',
    rv_c24_prv_addr_lres <= 6.5   => 'C24',
    rv_c24_prv_addr_lres <= 8.5   => 'C24',
    rv_c24_prv_addr_lres <= 13.5  => 'C24',
    rv_c24_prv_addr_lres <= 80.5  => 'C24',
    rv_c24_prv_addr_lres <= 223.5 => 'C24',
                                     'C24');

mod_4seg_aa_dist_11 := mod_4seg_v11_w - -0.059816596426015;

mod_4seg_aa_code_11 := if(mod_4seg_aa_dist_11 = 0, '', mod_4seg_aa_code_11_1);

mod_4seg_v12_w := map(
    rv_c14_unverified_addr_count = NULL => 0,
    rv_c14_unverified_addr_count = -1   => 0,
    rv_c14_unverified_addr_count <= 0.5 => 0.0942792012876607,
    rv_c14_unverified_addr_count <= 4.5 => -0.0608738691250172,
                                           -0.15089746708368);

mod_4seg_aa_code_12_1 := map(
    rv_c14_unverified_addr_count = NULL => '',
    rv_c14_unverified_addr_count = -1   => 'C12',
    rv_c14_unverified_addr_count <= 0.5 => 'C14',
    rv_c14_unverified_addr_count <= 4.5 => 'C14',
                                           'C14');

mod_4seg_aa_dist_12 := mod_4seg_v12_w - 0.026380404246132;

mod_4seg_aa_code_12 := if(mod_4seg_aa_dist_12 = 0, '', mod_4seg_aa_code_12_1);

mod_4seg_v13_w := map(
    rv_i60_credit_seeking = NULL => 0,
    rv_i60_credit_seeking = -1   => 0,
    rv_i60_credit_seeking <= 1.5 => 0.0563493180257992,
    rv_i60_credit_seeking <= 2.5 => -0.0178831728081235,
    rv_i60_credit_seeking <= 3.5 => -0.190657146118505,
                                    -0.403008056942988);

mod_4seg_aa_code_13_1 := map(
    rv_i60_credit_seeking = NULL => '',
    rv_i60_credit_seeking = -1   => 'C12',
    rv_i60_credit_seeking <= 1.5 => 'I60',
    rv_i60_credit_seeking <= 2.5 => 'I60',
    rv_i60_credit_seeking <= 3.5 => 'I60',
                                    'I60');

mod_4seg_aa_dist_13 := mod_4seg_v13_w - 0.047941450789216;

mod_4seg_aa_code_13 := if(mod_4seg_aa_dist_13 = 0, '', mod_4seg_aa_code_13_1);

mod_4seg_aa_code_00 := 'A42';

mod_4seg_aa_dist_00 := 2.7974800781 - 3.0666707304;

mod_4seg_rcvaluei60 := (integer)(mod_4seg_aa_code_00 = 'I60') * mod_4seg_aa_dist_00 +
    (integer)(mod_4seg_aa_code_01 = 'I60') * mod_4seg_aa_dist_01 +
    (integer)(mod_4seg_aa_code_02 = 'I60') * mod_4seg_aa_dist_02 +
    (integer)(mod_4seg_aa_code_03 = 'I60') * mod_4seg_aa_dist_03 +
    (integer)(mod_4seg_aa_code_04 = 'I60') * mod_4seg_aa_dist_04 +
    (integer)(mod_4seg_aa_code_05 = 'I60') * mod_4seg_aa_dist_05 +
    (integer)(mod_4seg_aa_code_06 = 'I60') * mod_4seg_aa_dist_06 +
    (integer)(mod_4seg_aa_code_07 = 'I60') * mod_4seg_aa_dist_07 +
    (integer)(mod_4seg_aa_code_08 = 'I60') * mod_4seg_aa_dist_08 +
    (integer)(mod_4seg_aa_code_09 = 'I60') * mod_4seg_aa_dist_09 +
    (integer)(mod_4seg_aa_code_10 = 'I60') * mod_4seg_aa_dist_10 +
    (integer)(mod_4seg_aa_code_11 = 'I60') * mod_4seg_aa_dist_11 +
    (integer)(mod_4seg_aa_code_12 = 'I60') * mod_4seg_aa_dist_12 +
    (integer)(mod_4seg_aa_code_13 = 'I60') * mod_4seg_aa_dist_13;

mod_4seg_rcvaluec13 := (integer)(mod_4seg_aa_code_00 = 'C13') * mod_4seg_aa_dist_00 +
    (integer)(mod_4seg_aa_code_01 = 'C13') * mod_4seg_aa_dist_01 +
    (integer)(mod_4seg_aa_code_02 = 'C13') * mod_4seg_aa_dist_02 +
    (integer)(mod_4seg_aa_code_03 = 'C13') * mod_4seg_aa_dist_03 +
    (integer)(mod_4seg_aa_code_04 = 'C13') * mod_4seg_aa_dist_04 +
    (integer)(mod_4seg_aa_code_05 = 'C13') * mod_4seg_aa_dist_05 +
    (integer)(mod_4seg_aa_code_06 = 'C13') * mod_4seg_aa_dist_06 +
    (integer)(mod_4seg_aa_code_07 = 'C13') * mod_4seg_aa_dist_07 +
    (integer)(mod_4seg_aa_code_08 = 'C13') * mod_4seg_aa_dist_08 +
    (integer)(mod_4seg_aa_code_09 = 'C13') * mod_4seg_aa_dist_09 +
    (integer)(mod_4seg_aa_code_10 = 'C13') * mod_4seg_aa_dist_10 +
    (integer)(mod_4seg_aa_code_11 = 'C13') * mod_4seg_aa_dist_11 +
    (integer)(mod_4seg_aa_code_12 = 'C13') * mod_4seg_aa_dist_12 +
    (integer)(mod_4seg_aa_code_13 = 'C13') * mod_4seg_aa_dist_13;

mod_4seg_rcvaluec14 := (integer)(mod_4seg_aa_code_00 = 'C14') * mod_4seg_aa_dist_00 +
    (integer)(mod_4seg_aa_code_01 = 'C14') * mod_4seg_aa_dist_01 +
    (integer)(mod_4seg_aa_code_02 = 'C14') * mod_4seg_aa_dist_02 +
    (integer)(mod_4seg_aa_code_03 = 'C14') * mod_4seg_aa_dist_03 +
    (integer)(mod_4seg_aa_code_04 = 'C14') * mod_4seg_aa_dist_04 +
    (integer)(mod_4seg_aa_code_05 = 'C14') * mod_4seg_aa_dist_05 +
    (integer)(mod_4seg_aa_code_06 = 'C14') * mod_4seg_aa_dist_06 +
    (integer)(mod_4seg_aa_code_07 = 'C14') * mod_4seg_aa_dist_07 +
    (integer)(mod_4seg_aa_code_08 = 'C14') * mod_4seg_aa_dist_08 +
    (integer)(mod_4seg_aa_code_09 = 'C14') * mod_4seg_aa_dist_09 +
    (integer)(mod_4seg_aa_code_10 = 'C14') * mod_4seg_aa_dist_10 +
    (integer)(mod_4seg_aa_code_11 = 'C14') * mod_4seg_aa_dist_11 +
    (integer)(mod_4seg_aa_code_12 = 'C14') * mod_4seg_aa_dist_12 +
    (integer)(mod_4seg_aa_code_13 = 'C14') * mod_4seg_aa_dist_13;

mod_4seg_rcvaluea42 := (integer)(mod_4seg_aa_code_00 = 'A42') * mod_4seg_aa_dist_00 +
    (integer)(mod_4seg_aa_code_01 = 'A42') * mod_4seg_aa_dist_01 +
    (integer)(mod_4seg_aa_code_02 = 'A42') * mod_4seg_aa_dist_02 +
    (integer)(mod_4seg_aa_code_03 = 'A42') * mod_4seg_aa_dist_03 +
    (integer)(mod_4seg_aa_code_04 = 'A42') * mod_4seg_aa_dist_04 +
    (integer)(mod_4seg_aa_code_05 = 'A42') * mod_4seg_aa_dist_05 +
    (integer)(mod_4seg_aa_code_06 = 'A42') * mod_4seg_aa_dist_06 +
    (integer)(mod_4seg_aa_code_07 = 'A42') * mod_4seg_aa_dist_07 +
    (integer)(mod_4seg_aa_code_08 = 'A42') * mod_4seg_aa_dist_08 +
    (integer)(mod_4seg_aa_code_09 = 'A42') * mod_4seg_aa_dist_09 +
    (integer)(mod_4seg_aa_code_10 = 'A42') * mod_4seg_aa_dist_10 +
    (integer)(mod_4seg_aa_code_11 = 'A42') * mod_4seg_aa_dist_11 +
    (integer)(mod_4seg_aa_code_12 = 'A42') * mod_4seg_aa_dist_12 +
    (integer)(mod_4seg_aa_code_13 = 'A42') * mod_4seg_aa_dist_13;

mod_4seg_rcvaluef01 := (integer)(mod_4seg_aa_code_00 = 'F01') * mod_4seg_aa_dist_00 +
    (integer)(mod_4seg_aa_code_01 = 'F01') * mod_4seg_aa_dist_01 +
    (integer)(mod_4seg_aa_code_02 = 'F01') * mod_4seg_aa_dist_02 +
    (integer)(mod_4seg_aa_code_03 = 'F01') * mod_4seg_aa_dist_03 +
    (integer)(mod_4seg_aa_code_04 = 'F01') * mod_4seg_aa_dist_04 +
    (integer)(mod_4seg_aa_code_05 = 'F01') * mod_4seg_aa_dist_05 +
    (integer)(mod_4seg_aa_code_06 = 'F01') * mod_4seg_aa_dist_06 +
    (integer)(mod_4seg_aa_code_07 = 'F01') * mod_4seg_aa_dist_07 +
    (integer)(mod_4seg_aa_code_08 = 'F01') * mod_4seg_aa_dist_08 +
    (integer)(mod_4seg_aa_code_09 = 'F01') * mod_4seg_aa_dist_09 +
    (integer)(mod_4seg_aa_code_10 = 'F01') * mod_4seg_aa_dist_10 +
    (integer)(mod_4seg_aa_code_11 = 'F01') * mod_4seg_aa_dist_11 +
    (integer)(mod_4seg_aa_code_12 = 'F01') * mod_4seg_aa_dist_12 +
    (integer)(mod_4seg_aa_code_13 = 'F01') * mod_4seg_aa_dist_13;

mod_4seg_rcvaluec12 := (integer)(mod_4seg_aa_code_00 = 'C12') * mod_4seg_aa_dist_00 +
    (integer)(mod_4seg_aa_code_01 = 'C12') * mod_4seg_aa_dist_01 +
    (integer)(mod_4seg_aa_code_02 = 'C12') * mod_4seg_aa_dist_02 +
    (integer)(mod_4seg_aa_code_03 = 'C12') * mod_4seg_aa_dist_03 +
    (integer)(mod_4seg_aa_code_04 = 'C12') * mod_4seg_aa_dist_04 +
    (integer)(mod_4seg_aa_code_05 = 'C12') * mod_4seg_aa_dist_05 +
    (integer)(mod_4seg_aa_code_06 = 'C12') * mod_4seg_aa_dist_06 +
    (integer)(mod_4seg_aa_code_07 = 'C12') * mod_4seg_aa_dist_07 +
    (integer)(mod_4seg_aa_code_08 = 'C12') * mod_4seg_aa_dist_08 +
    (integer)(mod_4seg_aa_code_09 = 'C12') * mod_4seg_aa_dist_09 +
    (integer)(mod_4seg_aa_code_10 = 'C12') * mod_4seg_aa_dist_10 +
    (integer)(mod_4seg_aa_code_11 = 'C12') * mod_4seg_aa_dist_11 +
    (integer)(mod_4seg_aa_code_12 = 'C12') * mod_4seg_aa_dist_12 +
    (integer)(mod_4seg_aa_code_13 = 'C12') * mod_4seg_aa_dist_13;

mod_4seg_rcvaluec24 := (integer)(mod_4seg_aa_code_00 = 'C24') * mod_4seg_aa_dist_00 +
    (integer)(mod_4seg_aa_code_01 = 'C24') * mod_4seg_aa_dist_01 +
    (integer)(mod_4seg_aa_code_02 = 'C24') * mod_4seg_aa_dist_02 +
    (integer)(mod_4seg_aa_code_03 = 'C24') * mod_4seg_aa_dist_03 +
    (integer)(mod_4seg_aa_code_04 = 'C24') * mod_4seg_aa_dist_04 +
    (integer)(mod_4seg_aa_code_05 = 'C24') * mod_4seg_aa_dist_05 +
    (integer)(mod_4seg_aa_code_06 = 'C24') * mod_4seg_aa_dist_06 +
    (integer)(mod_4seg_aa_code_07 = 'C24') * mod_4seg_aa_dist_07 +
    (integer)(mod_4seg_aa_code_08 = 'C24') * mod_4seg_aa_dist_08 +
    (integer)(mod_4seg_aa_code_09 = 'C24') * mod_4seg_aa_dist_09 +
    (integer)(mod_4seg_aa_code_10 = 'C24') * mod_4seg_aa_dist_10 +
    (integer)(mod_4seg_aa_code_11 = 'C24') * mod_4seg_aa_dist_11 +
    (integer)(mod_4seg_aa_code_12 = 'C24') * mod_4seg_aa_dist_12 +
    (integer)(mod_4seg_aa_code_13 = 'C24') * mod_4seg_aa_dist_13;

mod_4seg_rcvalues66 := (integer)(mod_4seg_aa_code_00 = 'S66') * mod_4seg_aa_dist_00 +
    (integer)(mod_4seg_aa_code_01 = 'S66') * mod_4seg_aa_dist_01 +
    (integer)(mod_4seg_aa_code_02 = 'S66') * mod_4seg_aa_dist_02 +
    (integer)(mod_4seg_aa_code_03 = 'S66') * mod_4seg_aa_dist_03 +
    (integer)(mod_4seg_aa_code_04 = 'S66') * mod_4seg_aa_dist_04 +
    (integer)(mod_4seg_aa_code_05 = 'S66') * mod_4seg_aa_dist_05 +
    (integer)(mod_4seg_aa_code_06 = 'S66') * mod_4seg_aa_dist_06 +
    (integer)(mod_4seg_aa_code_07 = 'S66') * mod_4seg_aa_dist_07 +
    (integer)(mod_4seg_aa_code_08 = 'S66') * mod_4seg_aa_dist_08 +
    (integer)(mod_4seg_aa_code_09 = 'S66') * mod_4seg_aa_dist_09 +
    (integer)(mod_4seg_aa_code_10 = 'S66') * mod_4seg_aa_dist_10 +
    (integer)(mod_4seg_aa_code_11 = 'S66') * mod_4seg_aa_dist_11 +
    (integer)(mod_4seg_aa_code_12 = 'S66') * mod_4seg_aa_dist_12 +
    (integer)(mod_4seg_aa_code_13 = 'S66') * mod_4seg_aa_dist_13;

mod_4seg_rcvaluei62 := (integer)(mod_4seg_aa_code_00 = 'I62') * mod_4seg_aa_dist_00 +
    (integer)(mod_4seg_aa_code_01 = 'I62') * mod_4seg_aa_dist_01 +
    (integer)(mod_4seg_aa_code_02 = 'I62') * mod_4seg_aa_dist_02 +
    (integer)(mod_4seg_aa_code_03 = 'I62') * mod_4seg_aa_dist_03 +
    (integer)(mod_4seg_aa_code_04 = 'I62') * mod_4seg_aa_dist_04 +
    (integer)(mod_4seg_aa_code_05 = 'I62') * mod_4seg_aa_dist_05 +
    (integer)(mod_4seg_aa_code_06 = 'I62') * mod_4seg_aa_dist_06 +
    (integer)(mod_4seg_aa_code_07 = 'I62') * mod_4seg_aa_dist_07 +
    (integer)(mod_4seg_aa_code_08 = 'I62') * mod_4seg_aa_dist_08 +
    (integer)(mod_4seg_aa_code_09 = 'I62') * mod_4seg_aa_dist_09 +
    (integer)(mod_4seg_aa_code_10 = 'I62') * mod_4seg_aa_dist_10 +
    (integer)(mod_4seg_aa_code_11 = 'I62') * mod_4seg_aa_dist_11 +
    (integer)(mod_4seg_aa_code_12 = 'I62') * mod_4seg_aa_dist_12 +
    (integer)(mod_4seg_aa_code_13 = 'I62') * mod_4seg_aa_dist_13;

mod_4seg_rcvaluef03 := (integer)(mod_4seg_aa_code_00 = 'F03') * mod_4seg_aa_dist_00 +
    (integer)(mod_4seg_aa_code_01 = 'F03') * mod_4seg_aa_dist_01 +
    (integer)(mod_4seg_aa_code_02 = 'F03') * mod_4seg_aa_dist_02 +
    (integer)(mod_4seg_aa_code_03 = 'F03') * mod_4seg_aa_dist_03 +
    (integer)(mod_4seg_aa_code_04 = 'F03') * mod_4seg_aa_dist_04 +
    (integer)(mod_4seg_aa_code_05 = 'F03') * mod_4seg_aa_dist_05 +
    (integer)(mod_4seg_aa_code_06 = 'F03') * mod_4seg_aa_dist_06 +
    (integer)(mod_4seg_aa_code_07 = 'F03') * mod_4seg_aa_dist_07 +
    (integer)(mod_4seg_aa_code_08 = 'F03') * mod_4seg_aa_dist_08 +
    (integer)(mod_4seg_aa_code_09 = 'F03') * mod_4seg_aa_dist_09 +
    (integer)(mod_4seg_aa_code_10 = 'F03') * mod_4seg_aa_dist_10 +
    (integer)(mod_4seg_aa_code_11 = 'F03') * mod_4seg_aa_dist_11 +
    (integer)(mod_4seg_aa_code_12 = 'F03') * mod_4seg_aa_dist_12 +
    (integer)(mod_4seg_aa_code_13 = 'F03') * mod_4seg_aa_dist_13;

mod_4seg_lgt := 2.44741263518079 +
    mod_4seg_v01_w +
    mod_4seg_v02_w +
    mod_4seg_v03_w +
    mod_4seg_v04_w +
    mod_4seg_v05_w +
    mod_4seg_v06_w +
    mod_4seg_v07_w +
    mod_4seg_v08_w +
    mod_4seg_v09_w +
    mod_4seg_v10_w +
    mod_4seg_v11_w +
    mod_4seg_v12_w +
    mod_4seg_v13_w;


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};


 
//*************************************************************************************//
rc_dataset_mod_1seg := DATASET([
    {'I60', mod_1seg_rcvalueI60},
    {'D33', mod_1seg_rcvalueD33},
    {'A42', mod_1seg_rcvalueA42},
    {'D32', mod_1seg_rcvalueD32},
    {'C22', mod_1seg_rcvalueC22},
    {'C12', mod_1seg_rcvalueC12},
    {'D30', mod_1seg_rcvalueD30},
    {'C24', mod_1seg_rcvalueC24},
    {'D31', mod_1seg_rcvalueD31},
    {'S66', mod_1seg_rcvalueS66},
    {'I62', mod_1seg_rcvalueI62},
    {'F03', mod_1seg_rcvalueF03}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_mod_1seg_sorted := sort(rc_dataset_mod_1seg, rc_dataset_mod_1seg.value);

seg1_r_rc1 := rc_dataset_mod_1seg_sorted[1].rc;
seg1_r_rc2 := rc_dataset_mod_1seg_sorted[2].rc;
seg1_r_rc3 := rc_dataset_mod_1seg_sorted[3].rc;
seg1_r_rc4 := rc_dataset_mod_1seg_sorted[4].rc;
seg1_r_rc5 := rc_dataset_mod_1seg_sorted[5].rc;
seg1_r_rc6 := rc_dataset_mod_1seg_sorted[6].rc;
seg1_r_rc7 := rc_dataset_mod_1seg_sorted[7].rc;
seg1_r_rc8 := rc_dataset_mod_1seg_sorted[8].rc;
seg1_r_rc9 := rc_dataset_mod_1seg_sorted[9].rc;
seg1_r_rc10 := rc_dataset_mod_1seg_sorted[10].rc;
seg1_r_rc11 := rc_dataset_mod_1seg_sorted[11].rc;
seg1_r_rc12 := rc_dataset_mod_1seg_sorted[12].rc;
seg1_r_rc13 := rc_dataset_mod_1seg_sorted[13].rc;
seg1_r_rc14 := rc_dataset_mod_1seg_sorted[14].rc;
seg1_r_rc15 := rc_dataset_mod_1seg_sorted[15].rc;


seg1_r_vl1 := rc_dataset_mod_1seg_sorted[1].value;
seg1_r_vl2 := rc_dataset_mod_1seg_sorted[2].value;
seg1_r_vl3 := rc_dataset_mod_1seg_sorted[3].value;
seg1_r_vl4 := rc_dataset_mod_1seg_sorted[4].value;
seg1_r_vl5 := rc_dataset_mod_1seg_sorted[5].value;
seg1_r_vl6 := rc_dataset_mod_1seg_sorted[6].value;
seg1_r_vl7 := rc_dataset_mod_1seg_sorted[7].value;
seg1_r_vl8 := rc_dataset_mod_1seg_sorted[8].value;
seg1_r_vl9 := rc_dataset_mod_1seg_sorted[9].value;
seg1_r_vl10 := rc_dataset_mod_1seg_sorted[10].value;
seg1_r_vl11 := rc_dataset_mod_1seg_sorted[11].value;
seg1_r_vl12 := rc_dataset_mod_1seg_sorted[12].value;
seg1_r_vl13 := rc_dataset_mod_1seg_sorted[13].value;
seg1_r_vl14 := rc_dataset_mod_1seg_sorted[14].value;
seg1_r_vl15 := rc_dataset_mod_1seg_sorted[15].value;
//*************************************************************************************//

 
//*************************************************************************************//
rc_dataset_mod_2seg := DATASET([
    {'I60', mod_2seg_rcvalueI60},
    {'D33', mod_2seg_rcvalueD33},
    {'D32', mod_2seg_rcvalueD32},
    {'A42', mod_2seg_rcvalueA42},
    {'C20', mod_2seg_rcvalueC20},
    {'C22', mod_2seg_rcvalueC22},
    {'C12', mod_2seg_rcvalueC12},
    {'D30', mod_2seg_rcvalueD30},
    {'D31', mod_2seg_rcvalueD31},
    {'I62', mod_2seg_rcvalueI62},
    {'F03', mod_2seg_rcvalueF03}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_mod_2seg_sorted := sort(rc_dataset_mod_2seg, rc_dataset_mod_2seg.value);

seg2_r_rc1 := rc_dataset_mod_2seg_sorted[1].rc;
seg2_r_rc2 := rc_dataset_mod_2seg_sorted[2].rc;
seg2_r_rc3 := rc_dataset_mod_2seg_sorted[3].rc;
seg2_r_rc4 := rc_dataset_mod_2seg_sorted[4].rc;
seg2_r_rc5 := rc_dataset_mod_2seg_sorted[5].rc;
seg2_r_rc6 := rc_dataset_mod_2seg_sorted[6].rc;
seg2_r_rc7 := rc_dataset_mod_2seg_sorted[7].rc;
seg2_r_rc8 := rc_dataset_mod_2seg_sorted[8].rc;
seg2_r_rc9 := rc_dataset_mod_2seg_sorted[9].rc;
seg2_r_rc10 := rc_dataset_mod_2seg_sorted[10].rc;
seg2_r_rc11 := rc_dataset_mod_2seg_sorted[11].rc;
seg2_r_rc12 := rc_dataset_mod_2seg_sorted[12].rc;
seg2_r_rc13 := rc_dataset_mod_2seg_sorted[13].rc;
seg2_r_rc14 := rc_dataset_mod_2seg_sorted[14].rc;
seg2_r_rc15 := rc_dataset_mod_2seg_sorted[15].rc;


seg2_r_vl1 := rc_dataset_mod_2seg_sorted[1].value;
seg2_r_vl2 := rc_dataset_mod_2seg_sorted[2].value;
seg2_r_vl3 := rc_dataset_mod_2seg_sorted[3].value;
seg2_r_vl4 := rc_dataset_mod_2seg_sorted[4].value;
seg2_r_vl5 := rc_dataset_mod_2seg_sorted[5].value;
seg2_r_vl6 := rc_dataset_mod_2seg_sorted[6].value;
seg2_r_vl7 := rc_dataset_mod_2seg_sorted[7].value;
seg2_r_vl8 := rc_dataset_mod_2seg_sorted[8].value;
seg2_r_vl9 := rc_dataset_mod_2seg_sorted[9].value;
seg2_r_vl10 := rc_dataset_mod_2seg_sorted[10].value;
seg2_r_vl11 := rc_dataset_mod_2seg_sorted[11].value;
seg2_r_vl12 := rc_dataset_mod_2seg_sorted[12].value;
seg2_r_vl13 := rc_dataset_mod_2seg_sorted[13].value;
seg2_r_vl14 := rc_dataset_mod_2seg_sorted[14].value;
seg2_r_vl15 := rc_dataset_mod_2seg_sorted[15].value;
//*************************************************************************************//

 
//*************************************************************************************//
rc_dataset_mod_3seg := DATASET([
    {'I60', mod_3seg_rcvalueI60},
    {'C13', mod_3seg_rcvalueC13},
    {'C12', mod_3seg_rcvalueC12},
    {'S66', mod_3seg_rcvalueS66},
    {'C22', mod_3seg_rcvalueC22}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_mod_3seg_sorted := sort(rc_dataset_mod_3seg, rc_dataset_mod_3seg.value);

seg3_r_rc1 := rc_dataset_mod_3seg_sorted[1].rc;
seg3_r_rc2 := rc_dataset_mod_3seg_sorted[2].rc;
seg3_r_rc3 := rc_dataset_mod_3seg_sorted[3].rc;
seg3_r_rc4 := rc_dataset_mod_3seg_sorted[4].rc;
seg3_r_rc5 := rc_dataset_mod_3seg_sorted[5].rc;
seg3_r_rc6 := rc_dataset_mod_3seg_sorted[6].rc;
seg3_r_rc7 := rc_dataset_mod_3seg_sorted[7].rc;
seg3_r_rc8 := rc_dataset_mod_3seg_sorted[8].rc;
seg3_r_rc9 := rc_dataset_mod_3seg_sorted[9].rc;
seg3_r_rc10 := rc_dataset_mod_3seg_sorted[10].rc;
seg3_r_rc11 := rc_dataset_mod_3seg_sorted[11].rc;
seg3_r_rc12 := rc_dataset_mod_3seg_sorted[12].rc;
seg3_r_rc13 := rc_dataset_mod_3seg_sorted[13].rc;
seg3_r_rc14 := rc_dataset_mod_3seg_sorted[14].rc;
seg3_r_rc15 := rc_dataset_mod_3seg_sorted[15].rc;


seg3_r_vl1 := rc_dataset_mod_3seg_sorted[1].value;
seg3_r_vl2 := rc_dataset_mod_3seg_sorted[2].value;
seg3_r_vl3 := rc_dataset_mod_3seg_sorted[3].value;
seg3_r_vl4 := rc_dataset_mod_3seg_sorted[4].value;
seg3_r_vl5 := rc_dataset_mod_3seg_sorted[5].value;
seg3_r_vl6 := rc_dataset_mod_3seg_sorted[6].value;
seg3_r_vl7 := rc_dataset_mod_3seg_sorted[7].value;
seg3_r_vl8 := rc_dataset_mod_3seg_sorted[8].value;
seg3_r_vl9 := rc_dataset_mod_3seg_sorted[9].value;
seg3_r_vl10 := rc_dataset_mod_3seg_sorted[10].value;
seg3_r_vl11 := rc_dataset_mod_3seg_sorted[11].value;
seg3_r_vl12 := rc_dataset_mod_3seg_sorted[12].value;
seg3_r_vl13 := rc_dataset_mod_3seg_sorted[13].value;
seg3_r_vl14 := rc_dataset_mod_3seg_sorted[14].value;
seg3_r_vl15 := rc_dataset_mod_3seg_sorted[15].value;
//*************************************************************************************//

 
//*************************************************************************************//
rc_dataset_mod_4seg := DATASET([
    {'I60', mod_4seg_rcvalueI60},
    {'C13', mod_4seg_rcvalueC13},
    {'C14', mod_4seg_rcvalueC14},
    {'A42', mod_4seg_rcvalueA42},
    {'F01', mod_4seg_rcvalueF01},
    {'C12', mod_4seg_rcvalueC12},
    {'C24', mod_4seg_rcvalueC24},
    {'S66', mod_4seg_rcvalueS66},
    {'I62', mod_4seg_rcvalueI62},
    {'F03', mod_4seg_rcvalueF03}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_mod_4seg_sorted := sort(rc_dataset_mod_4seg, rc_dataset_mod_4seg.value);

seg4_r_rc1 := rc_dataset_mod_4seg_sorted[1].rc;
seg4_r_rc2 := rc_dataset_mod_4seg_sorted[2].rc;
seg4_r_rc3 := rc_dataset_mod_4seg_sorted[3].rc;
seg4_r_rc4 := rc_dataset_mod_4seg_sorted[4].rc;
seg4_r_rc5 := rc_dataset_mod_4seg_sorted[5].rc;
seg4_r_rc6 := rc_dataset_mod_4seg_sorted[6].rc;
seg4_r_rc7 := rc_dataset_mod_4seg_sorted[7].rc;
seg4_r_rc8 := rc_dataset_mod_4seg_sorted[8].rc;
seg4_r_rc9 := rc_dataset_mod_4seg_sorted[9].rc;
seg4_r_rc10 := rc_dataset_mod_4seg_sorted[10].rc;
seg4_r_rc11 := rc_dataset_mod_4seg_sorted[11].rc;
seg4_r_rc12 := rc_dataset_mod_4seg_sorted[12].rc;
seg4_r_rc13 := rc_dataset_mod_4seg_sorted[13].rc;
seg4_r_rc14 := rc_dataset_mod_4seg_sorted[14].rc;
seg4_r_rc15 := rc_dataset_mod_4seg_sorted[15].rc;


seg4_r_vl1 := rc_dataset_mod_4seg_sorted[1].value;
seg4_r_vl2 := rc_dataset_mod_4seg_sorted[2].value;
seg4_r_vl3 := rc_dataset_mod_4seg_sorted[3].value;
seg4_r_vl4 := rc_dataset_mod_4seg_sorted[4].value;
seg4_r_vl5 := rc_dataset_mod_4seg_sorted[5].value;
seg4_r_vl6 := rc_dataset_mod_4seg_sorted[6].value;
seg4_r_vl7 := rc_dataset_mod_4seg_sorted[7].value;
seg4_r_vl8 := rc_dataset_mod_4seg_sorted[8].value;
seg4_r_vl9 := rc_dataset_mod_4seg_sorted[9].value;
seg4_r_vl10 := rc_dataset_mod_4seg_sorted[10].value;
seg4_r_vl11 := rc_dataset_mod_4seg_sorted[11].value;
seg4_r_vl12 := rc_dataset_mod_4seg_sorted[12].value;
seg4_r_vl13 := rc_dataset_mod_4seg_sorted[13].value;
seg4_r_vl14 := rc_dataset_mod_4seg_sorted[14].value;
seg4_r_vl15 := rc_dataset_mod_4seg_sorted[15].value;
//*************************************************************************************//

seg1_rc1_1 := seg1_r_rc1;

seg1_rc2_1 := seg1_r_rc2;

seg1_rc3_1 := seg1_r_rc3;

seg1_rc4_1 := seg1_r_rc4;

_rc_inq_3 := map(
    seg1_r_rc1 = 'I60' or seg1_r_rc2 = 'I60' or seg1_r_rc3 = 'I60' or seg1_r_rc4 = 'I60' or seg1_r_rc5 = 'I60' or seg1_r_rc6 = 'I60' or seg1_r_rc7 = 'I60' or seg1_r_rc8 = 'I60' or seg1_r_rc9 = 'I60' or seg1_r_rc10 = 'I60' or seg1_r_rc11 = 'I60' or seg1_r_rc12 = 'I60' or seg1_r_rc13 = 'I60' or seg1_r_rc14 = 'I60' or seg1_r_rc15 = 'I60' => 'I60',
    seg1_r_rc1 = 'I61' or seg1_r_rc2 = 'I61' or seg1_r_rc3 = 'I61' or seg1_r_rc4 = 'I61' or seg1_r_rc5 = 'I61' or seg1_r_rc6 = 'I61' or seg1_r_rc7 = 'I61' or seg1_r_rc8 = 'I61' or seg1_r_rc9 = 'I61' or seg1_r_rc10 = 'I61' or seg1_r_rc11 = 'I61' or seg1_r_rc12 = 'I61' or seg1_r_rc13 = 'I61' or seg1_r_rc14 = 'I61' or seg1_r_rc15 = 'I61' => 'I61',
    seg1_r_rc1 = 'I62' or seg1_r_rc2 = 'I62' or seg1_r_rc3 = 'I62' or seg1_r_rc4 = 'I62' or seg1_r_rc5 = 'I62' or seg1_r_rc6 = 'I62' or seg1_r_rc7 = 'I62' or seg1_r_rc8 = 'I62' or seg1_r_rc9 = 'I62' or seg1_r_rc10 = 'I62' or seg1_r_rc11 = 'I62' or seg1_r_rc12 = 'I62' or seg1_r_rc13 = 'I62' or seg1_r_rc14 = 'I62' or seg1_r_rc15 = 'I62' => 'I62',
                                                                                                                                                                                                                                                                                                                                                    '');

seg1_rc5_c330 := map(
    trim(seg1_rc1_1, LEFT, RIGHT) = '' => '',
    trim(seg1_rc2_1, LEFT, RIGHT) = '' => '',
    trim(seg1_rc3_1, LEFT, RIGHT) = '' => '',
    trim(seg1_rc4_1, LEFT, RIGHT) = '' => '',
                                          _rc_inq_3);

seg1_rc2_c330 := map(
    trim(seg1_rc1_1, LEFT, RIGHT) = '' => '',
    trim(seg1_rc2_1, LEFT, RIGHT) = '' => _rc_inq_3,
    trim(seg1_rc3_1, LEFT, RIGHT) = '' => '',
    trim(seg1_rc4_1, LEFT, RIGHT) = '' => '',
                                          '');

seg1_rc4_c330 := map(
    trim(seg1_rc1_1, LEFT, RIGHT) = '' => '',
    trim(seg1_rc2_1, LEFT, RIGHT) = '' => '',
    trim(seg1_rc3_1, LEFT, RIGHT) = '' => '',
    trim(seg1_rc4_1, LEFT, RIGHT) = '' => _rc_inq_3,
                                          '');

seg1_rc3_c330 := map(
    trim(seg1_rc1_1, LEFT, RIGHT) = '' => '',
    trim(seg1_rc2_1, LEFT, RIGHT) = '' => '',
    trim(seg1_rc3_1, LEFT, RIGHT) = '' => _rc_inq_3,
    trim(seg1_rc4_1, LEFT, RIGHT) = '' => '',
                                          '');

seg1_rc1_c330 := map(
    trim(seg1_rc1_1, LEFT, RIGHT) = '' => _rc_inq_3,
    trim(seg1_rc2_1, LEFT, RIGHT) = '' => '',
    trim(seg1_rc3_1, LEFT, RIGHT) = '' => '',
    trim(seg1_rc4_1, LEFT, RIGHT) = '' => '',
                                          '');

seg1_rc1 := if(seg1_rc1_c330 != '' and not((seg1_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg1_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg1_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg1_rc4_1 in ['I60', 'I61', 'I62'])), seg1_rc1_c330, seg1_rc1_1);

seg1_rc3 := if(seg1_rc3_c330 != '' and not((seg1_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg1_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg1_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg1_rc4_1 in ['I60', 'I61', 'I62'])), seg1_rc3_c330, seg1_rc3_1);

seg1_rc2 := if(seg1_rc2_c330 != '' and not((seg1_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg1_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg1_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg1_rc4_1 in ['I60', 'I61', 'I62'])), seg1_rc2_c330, seg1_rc2_1);

seg1_rc5 := if(seg1_rc5_c330 != '' and not((seg1_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg1_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg1_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg1_rc4_1 in ['I60', 'I61', 'I62'])), seg1_rc5_c330, '');

seg1_rc4 := if(seg1_rc4_c330 != '' and not((seg1_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg1_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg1_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg1_rc4_1 in ['I60', 'I61', 'I62'])), seg1_rc4_c330, seg1_rc4_1);

seg2_rc1_1 := seg2_r_rc1;

seg2_rc2_1 := seg2_r_rc2;

seg2_rc3_1 := seg2_r_rc3;

seg2_rc4_1 := seg2_r_rc4;

_rc_inq_2 := map(
    seg2_r_rc1 = 'I60' or seg2_r_rc2 = 'I60' or seg2_r_rc3 = 'I60' or seg2_r_rc4 = 'I60' or seg2_r_rc5 = 'I60' or seg2_r_rc6 = 'I60' or seg2_r_rc7 = 'I60' or seg2_r_rc8 = 'I60' or seg2_r_rc9 = 'I60' or seg2_r_rc10 = 'I60' or seg2_r_rc11 = 'I60' or seg2_r_rc12 = 'I60' or seg2_r_rc13 = 'I60' or seg2_r_rc14 = 'I60' or seg2_r_rc15 = 'I60' => 'I60',
    seg2_r_rc1 = 'I61' or seg2_r_rc2 = 'I61' or seg2_r_rc3 = 'I61' or seg2_r_rc4 = 'I61' or seg2_r_rc5 = 'I61' or seg2_r_rc6 = 'I61' or seg2_r_rc7 = 'I61' or seg2_r_rc8 = 'I61' or seg2_r_rc9 = 'I61' or seg2_r_rc10 = 'I61' or seg2_r_rc11 = 'I61' or seg2_r_rc12 = 'I61' or seg2_r_rc13 = 'I61' or seg2_r_rc14 = 'I61' or seg2_r_rc15 = 'I61' => 'I61',
    seg2_r_rc1 = 'I62' or seg2_r_rc2 = 'I62' or seg2_r_rc3 = 'I62' or seg2_r_rc4 = 'I62' or seg2_r_rc5 = 'I62' or seg2_r_rc6 = 'I62' or seg2_r_rc7 = 'I62' or seg2_r_rc8 = 'I62' or seg2_r_rc9 = 'I62' or seg2_r_rc10 = 'I62' or seg2_r_rc11 = 'I62' or seg2_r_rc12 = 'I62' or seg2_r_rc13 = 'I62' or seg2_r_rc14 = 'I62' or seg2_r_rc15 = 'I62' => 'I62',
                                                                                                                                                                                                                                                                                                                                                                           '');

seg2_rc4_c333 := map(
    trim(seg2_rc1_1, LEFT, RIGHT) = '' => '',
    trim(seg2_rc2_1, LEFT, RIGHT) = '' => '',
    trim(seg2_rc3_1, LEFT, RIGHT) = '' => '',
    trim(seg2_rc4_1, LEFT, RIGHT) = '' => _rc_inq_2,
                                          '');

seg2_rc1_c333 := map(
    trim(seg2_rc1_1, LEFT, RIGHT) = '' => _rc_inq_2,
    trim(seg2_rc2_1, LEFT, RIGHT) = '' => '',
    trim(seg2_rc3_1, LEFT, RIGHT) = '' => '',
    trim(seg2_rc4_1, LEFT, RIGHT) = '' => '',
                                          '');

seg2_rc3_c333 := map(
    trim(seg2_rc1_1, LEFT, RIGHT) = '' => '',
    trim(seg2_rc2_1, LEFT, RIGHT) = '' => '',
    trim(seg2_rc3_1, LEFT, RIGHT) = '' => _rc_inq_2,
    trim(seg2_rc4_1, LEFT, RIGHT) = '' => '',
                                          '');

seg2_rc5_c333 := map(
    trim(seg2_rc1_1, LEFT, RIGHT) = '' => '',
    trim(seg2_rc2_1, LEFT, RIGHT) = '' => '',
    trim(seg2_rc3_1, LEFT, RIGHT) = '' => '',
    trim(seg2_rc4_1, LEFT, RIGHT) = '' => '',
                                          _rc_inq_2);

seg2_rc2_c333 := map(
    trim(seg2_rc1_1, LEFT, RIGHT) = '' => '',
    trim(seg2_rc2_1, LEFT, RIGHT) = '' => _rc_inq_2,
    trim(seg2_rc3_1, LEFT, RIGHT) = '' => '',
    trim(seg2_rc4_1, LEFT, RIGHT) = '' => '',
                                          '');

seg2_rc1 := if(seg2_rc1_c333 != '' and not((seg2_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg2_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg2_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg2_rc4_1 in ['I60', 'I61', 'I62'])), seg2_rc1_c333, seg2_rc1_1);

seg2_rc4 := if(seg2_rc4_c333 != '' and not((seg2_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg2_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg2_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg2_rc4_1 in ['I60', 'I61', 'I62'])), seg2_rc4_c333, seg2_rc4_1);

seg2_rc2 := if(seg2_rc2_c333 != '' and not((seg2_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg2_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg2_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg2_rc4_1 in ['I60', 'I61', 'I62'])), seg2_rc2_c333, seg2_rc2_1);

seg2_rc5 := if(seg2_rc5_c333 != '' and not((seg2_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg2_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg2_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg2_rc4_1 in ['I60', 'I61', 'I62'])), seg2_rc5_c333, '');

seg2_rc3 := if(seg2_rc3_c333 != '' and not((seg2_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg2_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg2_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg2_rc4_1 in ['I60', 'I61', 'I62'])), seg2_rc3_c333, seg2_rc3_1);

seg3_rc1_1 := seg3_r_rc1;

seg3_rc2_1 := seg3_r_rc2;

seg3_rc3_1 := seg3_r_rc3;

seg3_rc4_1 := seg3_r_rc4;

_rc_inq_1 := map(
    seg3_r_rc1 = 'I60' or seg3_r_rc2 = 'I60' or seg3_r_rc3 = 'I60' or seg3_r_rc4 = 'I60' or seg3_r_rc5 = 'I60' or seg3_r_rc6 = 'I60' or seg3_r_rc7 = 'I60' or seg3_r_rc8 = 'I60' => 'I60',
    seg3_r_rc1 = 'I61' or seg3_r_rc2 = 'I61' or seg3_r_rc3 = 'I61' or seg3_r_rc4 = 'I61' or seg3_r_rc5 = 'I61' or seg3_r_rc6 = 'I61' or seg3_r_rc7 = 'I61' or seg3_r_rc8 = 'I61' => 'I61',
    seg3_r_rc1 = 'I62' or seg3_r_rc2 = 'I62' or seg3_r_rc3 = 'I62' or seg3_r_rc4 = 'I62' or seg3_r_rc5 = 'I62' or seg3_r_rc6 = 'I62' or seg3_r_rc7 = 'I62' or seg3_r_rc8 = 'I62' => 'I62',
                                                                                                                                                                                    '');

seg3_rc2_c336 := map(
    trim(seg3_rc1_1, LEFT, RIGHT) = '' => '',
    trim(seg3_rc2_1, LEFT, RIGHT) = '' => _rc_inq_1,
    trim(seg3_rc3_1, LEFT, RIGHT) = '' => '',
    trim(seg3_rc4_1, LEFT, RIGHT) = '' => '',
                                          '');

seg3_rc5_c336 := map(
    trim(seg3_rc1_1, LEFT, RIGHT) = '' => '',
    trim(seg3_rc2_1, LEFT, RIGHT) = '' => '',
    trim(seg3_rc3_1, LEFT, RIGHT) = '' => '',
    trim(seg3_rc4_1, LEFT, RIGHT) = '' => '',
                                          _rc_inq_1);

seg3_rc3_c336 := map(
    trim(seg3_rc1_1, LEFT, RIGHT) = '' => '',
    trim(seg3_rc2_1, LEFT, RIGHT) = '' => '',
    trim(seg3_rc3_1, LEFT, RIGHT) = '' => _rc_inq_1,
    trim(seg3_rc4_1, LEFT, RIGHT) = '' => '',
                                          '');

seg3_rc1_c336 := map(
    trim(seg3_rc1_1, LEFT, RIGHT) = '' => _rc_inq_1,
    trim(seg3_rc2_1, LEFT, RIGHT) = '' => '',
    trim(seg3_rc3_1, LEFT, RIGHT) = '' => '',
    trim(seg3_rc4_1, LEFT, RIGHT) = '' => '',
                                          '');

seg3_rc4_c336 := map(
    trim(seg3_rc1_1, LEFT, RIGHT) = '' => '',
    trim(seg3_rc2_1, LEFT, RIGHT) = '' => '',
    trim(seg3_rc3_1, LEFT, RIGHT) = '' => '',
    trim(seg3_rc4_1, LEFT, RIGHT) = '' => _rc_inq_1,
                                          '');

seg3_rc5 := if(seg3_rc5_c336 != '' and not((seg3_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg3_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg3_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg3_rc4_1 in ['I60', 'I61', 'I62'])), seg3_rc5_c336, '');

seg3_rc3 := if(seg3_rc3_c336 != '' and not((seg3_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg3_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg3_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg3_rc4_1 in ['I60', 'I61', 'I62'])), seg3_rc3_c336, seg3_rc3_1);

seg3_rc4 := if(seg3_rc4_c336 != '' and not((seg3_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg3_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg3_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg3_rc4_1 in ['I60', 'I61', 'I62'])), seg3_rc4_c336, seg3_rc4_1);

seg3_rc1 := if(seg3_rc1_c336 != '' and not((seg3_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg3_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg3_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg3_rc4_1 in ['I60', 'I61', 'I62'])), seg3_rc1_c336, seg3_rc1_1);

seg3_rc2 := if(seg3_rc2_c336 != '' and not((seg3_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg3_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg3_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg3_rc4_1 in ['I60', 'I61', 'I62'])), seg3_rc2_c336, seg3_rc2_1);

seg4_rc1_1 := seg4_r_rc1;

seg4_rc2_1 := seg4_r_rc2;

seg4_rc3_1 := seg4_r_rc3;

seg4_rc4_1 := seg4_r_rc4;

_rc_inq := map(
    seg4_r_rc1 = 'I60' or seg4_r_rc2 = 'I60' or seg4_r_rc3 = 'I60' or seg4_r_rc4 = 'I60' or seg4_r_rc5 = 'I60' or seg4_r_rc6 = 'I60' or seg4_r_rc7 = 'I60' or seg4_r_rc8 = 'I60' or seg4_r_rc9 = 'I60' or seg4_r_rc10 = 'I60' or seg4_r_rc11 = 'I60' or seg4_r_rc12 = 'I60' or seg4_r_rc13 = 'I60' or seg4_r_rc14 = 'I60' => 'I60',
    seg4_r_rc1 = 'I61' or seg4_r_rc2 = 'I61' or seg4_r_rc3 = 'I61' or seg4_r_rc4 = 'I61' or seg4_r_rc5 = 'I61' or seg4_r_rc6 = 'I61' or seg4_r_rc7 = 'I61' or seg4_r_rc8 = 'I61' or seg4_r_rc9 = 'I61' or seg4_r_rc10 = 'I61' or seg4_r_rc11 = 'I61' or seg4_r_rc12 = 'I61' or seg4_r_rc13 = 'I61' or seg4_r_rc14 = 'I61' => 'I61',
    seg4_r_rc1 = 'I62' or seg4_r_rc2 = 'I62' or seg4_r_rc3 = 'I62' or seg4_r_rc4 = 'I62' or seg4_r_rc5 = 'I62' or seg4_r_rc6 = 'I62' or seg4_r_rc7 = 'I62' or seg4_r_rc8 = 'I62' or seg4_r_rc9 = 'I62' or seg4_r_rc10 = 'I62' or seg4_r_rc11 = 'I62' or seg4_r_rc12 = 'I62' or seg4_r_rc13 = 'I62' or seg4_r_rc14 = 'I62' => 'I62',
                                                                                                                                                                                                                                                                                                                             '');

seg4_rc1_c339 := map(
    trim(seg4_rc1_1, LEFT, RIGHT) = '' => _rc_inq,
    trim(seg4_rc2_1, LEFT, RIGHT) = '' => '',
    trim(seg4_rc3_1, LEFT, RIGHT) = '' => '',
    trim(seg4_rc4_1, LEFT, RIGHT) = '' => '',
                                          '');

seg4_rc2_c339 := map(
    trim(seg4_rc1_1, LEFT, RIGHT) = '' => '',
    trim(seg4_rc2_1, LEFT, RIGHT) = '' => _rc_inq,
    trim(seg4_rc3_1, LEFT, RIGHT) = '' => '',
    trim(seg4_rc4_1, LEFT, RIGHT) = '' => '',
                                          '');

seg4_rc4_c339 := map(
    trim(seg4_rc1_1, LEFT, RIGHT) = '' => '',
    trim(seg4_rc2_1, LEFT, RIGHT) = '' => '',
    trim(seg4_rc3_1, LEFT, RIGHT) = '' => '',
    trim(seg4_rc4_1, LEFT, RIGHT) = '' => _rc_inq,
                                          '');

seg4_rc5_c339 := map(
    trim(seg4_rc1_1, LEFT, RIGHT) = '' => '',
    trim(seg4_rc2_1, LEFT, RIGHT) = '' => '',
    trim(seg4_rc3_1, LEFT, RIGHT) = '' => '',
    trim(seg4_rc4_1, LEFT, RIGHT) = '' => '',
                                          _rc_inq);

seg4_rc3_c339 := map(
    trim(seg4_rc1_1, LEFT, RIGHT) = '' => '',
    trim(seg4_rc2_1, LEFT, RIGHT) = '' => '',
    trim(seg4_rc3_1, LEFT, RIGHT) = '' => _rc_inq,
    trim(seg4_rc4_1, LEFT, RIGHT) = '' => '',
                                          '');

seg4_rc2 := if(seg4_rc2_c339 != '' and not((seg4_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg4_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg4_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg4_rc4_1 in ['I60', 'I61', 'I62'])), seg4_rc2_c339, seg4_rc2_1);

seg4_rc4 := if(seg4_rc4_c339 != '' and not((seg4_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg4_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg4_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg4_rc4_1 in ['I60', 'I61', 'I62'])), seg4_rc4_c339, seg4_rc4_1);

seg4_rc1 := if(seg4_rc1_c339 != '' and not((seg4_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg4_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg4_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg4_rc4_1 in ['I60', 'I61', 'I62'])), seg4_rc1_c339, seg4_rc1_1);

seg4_rc3 := if(seg4_rc3_c339 != '' and not((seg4_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg4_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg4_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg4_rc4_1 in ['I60', 'I61', 'I62'])), seg4_rc3_c339, seg4_rc3_1);

seg4_rc5 := if(seg4_rc5_c339 != '' and not((seg4_rc1_1 in ['I60', 'I61', 'I62'])) and not((seg4_rc2_1 in ['I60', 'I61', 'I62'])) and not((seg4_rc3_1 in ['I60', 'I61', 'I62'])) and not((seg4_rc4_1 in ['I60', 'I61', 'I62'])), seg4_rc5_c339, '');

rc4_1 := map(
    rv_4seg_riskview_5_0_v2 = '1 CRED'  => seg1_rc4,
    rv_4seg_riskview_5_0_v2 = '2 DEROG' => seg2_rc4,
    rv_4seg_riskview_5_0_v2 = '3 OWNER' => seg3_rc4,
                                           seg4_rc4);

rc3_1 := map(
    rv_4seg_riskview_5_0_v2 = '1 CRED'  => seg1_rc3,
    rv_4seg_riskview_5_0_v2 = '2 DEROG' => seg2_rc3,
    rv_4seg_riskview_5_0_v2 = '3 OWNER' => seg3_rc3,
                                           seg4_rc3);

rc5_1 := map(
    rv_4seg_riskview_5_0_v2 = '1 CRED'  => seg1_rc5,
    rv_4seg_riskview_5_0_v2 = '2 DEROG' => seg2_rc5,
    rv_4seg_riskview_5_0_v2 = '3 OWNER' => seg3_rc5,
                                           seg4_rc5);

rc1_1 := map(
    rv_4seg_riskview_5_0_v2 = '1 CRED'  => seg1_rc1,
    rv_4seg_riskview_5_0_v2 = '2 DEROG' => seg2_rc1,
    rv_4seg_riskview_5_0_v2 = '3 OWNER' => seg3_rc1,
                                           seg4_rc1);

rc2_1 := map(
    rv_4seg_riskview_5_0_v2 = '1 CRED'  => seg1_rc2,
    rv_4seg_riskview_5_0_v2 = '2 DEROG' => seg2_rc2,
    rv_4seg_riskview_5_0_v2 = '3 OWNER' => seg3_rc2,
                                           seg4_rc2);

iv_rv5_deceased := rc_decsflag = '1' or rc_ssndod != 0 or (INTEGER)indexw(STD.Str.ToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0 or (INTEGER)indexw(STD.Str.ToUpperCase(trim(ver_sources, ALL)), 'DE', ',') > 0;

iv_rv5_unscorable := if(not(truedid), 1, 0);

base := 700;

odds := (1 - 0.0446) / 0.0446;

point := 40;

rva1908_1_0 := map(
    iv_rv5_deceased                 => 200,
    iv_rv5_unscorable = 1               => 222,
    rv_4seg_riskview_5_0_v2 = '1 CRED'  => min(if(max(round(point * (mod_1seg_lgt - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (mod_1seg_lgt - ln(odds)) / ln(2) + base), 501)), 900),
    rv_4seg_riskview_5_0_v2 = '2 DEROG' => min(if(max(round(point * (mod_2seg_lgt - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (mod_2seg_lgt - ln(odds)) / ln(2) + base), 501)), 900),
    rv_4seg_riskview_5_0_v2 = '3 OWNER' => min(if(max(round(point * (mod_3seg_lgt - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (mod_3seg_lgt - ln(odds)) / ln(2) + base), 501)), 900),
                                           min(if(max(round(point * (mod_4seg_lgt - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (mod_4seg_lgt - ln(odds)) / ln(2) + base), 501)), 900));

rc2 := if((rva1908_1_0 in [200, 222, 900]), '', rc2_1);

rc1 := if((rva1908_1_0 in [200, 222, 900]), '', rc1_1);

rc3 := if((rva1908_1_0 in [200, 222, 900]), '', rc3_1);

rc4 := if((rva1908_1_0 in [200, 222, 900]), '', rc4_1);

rc5 := if((rva1908_1_0 in [200, 222, 900]), '', rc5_1);
//*************************************************************************************//
//     RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
	
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVA1908_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVA1908_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVA1908_1_0 = 900 => DATASET([{'00'}], HRILayout),
																							 DATASET([], HRILayout)
													);
reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout);
// If we have score overrides use them, else use the normal reason codes
reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
										reasonsOverrides, 
										reasons) (HRI NOT IN ['', '00']);
zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5); // Keep up to 5 reason codes

//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

#if(MODEL_DEBUG)
self.sysdate                          := sysdate;
self.ver_src_eq_pos                   := ver_src_eq_pos;
self._ver_src_fdate_eq                := _ver_src_fdate_eq;
self.ver_src_fdate_eq                 := ver_src_fdate_eq;
self.college_proflic_br_ind           := college_proflic_br_ind;
self.rv_4seg_riskview_5_0_v2          := rv_4seg_riskview_5_0_v2;
self._felony_last_date                := _felony_last_date;
self._criminal_last_date              := _criminal_last_date;
self.rv_d31_bk_dism_recent_count      := rv_d31_bk_dism_recent_count;
self.rv_a41_a42_prop_owner_history    := rv_a41_a42_prop_owner_history;
self.rv_d32_criminal_behavior_lvl     := rv_d32_criminal_behavior_lvl;
self.rv_i60_inq_hiriskcred_count12    := rv_i60_inq_hiriskcred_count12;
self.rv_d30_derog_count               := rv_d30_derog_count;
self.rv_c12_inp_addr_source_count     := rv_c12_inp_addr_source_count;
self.rv_i62_inq_phones_per_adl        := rv_i62_inq_phones_per_adl;
self.rv_i60_inq_comm_count12          := rv_i60_inq_comm_count12;
self.rv_i62_inq_addrs_per_adl         := rv_i62_inq_addrs_per_adl;
self.rv_c22_inp_addr_occ_index        := rv_c22_inp_addr_occ_index;
self.rv_d33_eviction_recency          := rv_d33_eviction_recency;
self.rv_f03_input_add_not_most_rec    := rv_f03_input_add_not_most_rec;
self.rv_c24_prv_addr_lres             := rv_c24_prv_addr_lres;
self.rv_c20_m_bureau_adl_fs           := rv_c20_m_bureau_adl_fs;
self.rv_i60_inq_peradl_count12        := rv_i60_inq_peradl_count12;
self.iv_c13_avg_lres                  := iv_c13_avg_lres;
self.rv_c12_num_nonderogs             := rv_c12_num_nonderogs;
self.iv_c22_addr_ver_sources          := iv_c22_addr_ver_sources;
self.rv_s66_adlperssn_count           := rv_s66_adlperssn_count;
self.rv_f01_inp_addr_address_score    := rv_f01_inp_addr_address_score;
self.rv_i60_inq_other_count12         := rv_i60_inq_other_count12;
self.rv_c14_unverified_addr_count     := rv_c14_unverified_addr_count;
self.rv_i60_credit_seeking            := rv_i60_credit_seeking;
self.mod_1seg_v01_w                   := mod_1seg_v01_w;
self.mod_1seg_aa_dist_01              := mod_1seg_aa_dist_01;
self.mod_1seg_aa_code_01              := mod_1seg_aa_code_01;
self.mod_1seg_v02_w                   := mod_1seg_v02_w;
self.mod_1seg_aa_dist_02              := mod_1seg_aa_dist_02;
self.mod_1seg_aa_code_02              := mod_1seg_aa_code_02;
self.mod_1seg_v03_w                   := mod_1seg_v03_w;
self.mod_1seg_aa_dist_03              := mod_1seg_aa_dist_03;
self.mod_1seg_aa_code_03              := mod_1seg_aa_code_03;
self.mod_1seg_v04_w                   := mod_1seg_v04_w;
self.mod_1seg_aa_dist_04              := mod_1seg_aa_dist_04;
self.mod_1seg_aa_code_04              := mod_1seg_aa_code_04;
self.mod_1seg_v05_w                   := mod_1seg_v05_w;
self.mod_1seg_aa_dist_05              := mod_1seg_aa_dist_05;
self.mod_1seg_aa_code_05              := mod_1seg_aa_code_05;
self.mod_1seg_v06_w                   := mod_1seg_v06_w;
self.mod_1seg_aa_dist_06              := mod_1seg_aa_dist_06;
self.mod_1seg_aa_code_06              := mod_1seg_aa_code_06;
self.mod_1seg_v07_w                   := mod_1seg_v07_w;
self.mod_1seg_aa_dist_07              := mod_1seg_aa_dist_07;
self.mod_1seg_aa_code_07              := mod_1seg_aa_code_07;
self.mod_1seg_v08_w                   := mod_1seg_v08_w;
self.mod_1seg_aa_dist_08              := mod_1seg_aa_dist_08;
self.mod_1seg_aa_code_08              := mod_1seg_aa_code_08;
self.mod_1seg_v09_w                   := mod_1seg_v09_w;
self.mod_1seg_aa_dist_09              := mod_1seg_aa_dist_09;
self.mod_1seg_aa_code_09              := mod_1seg_aa_code_09;
self.mod_1seg_v10_w                   := mod_1seg_v10_w;
self.mod_1seg_aa_dist_10              := mod_1seg_aa_dist_10;
self.mod_1seg_aa_code_10              := mod_1seg_aa_code_10;
self.mod_1seg_v11_w                   := mod_1seg_v11_w;
self.mod_1seg_aa_dist_11              := mod_1seg_aa_dist_11;
self.mod_1seg_aa_code_11              := mod_1seg_aa_code_11;
self.mod_1seg_v12_w                   := mod_1seg_v12_w;
self.mod_1seg_aa_dist_12              := mod_1seg_aa_dist_12;
self.mod_1seg_aa_code_12              := mod_1seg_aa_code_12;
self.mod_1seg_v13_w                   := mod_1seg_v13_w;
self.mod_1seg_aa_dist_13              := mod_1seg_aa_dist_13;
self.mod_1seg_aa_code_13              := mod_1seg_aa_code_13;
self.mod_1seg_v14_w                   := mod_1seg_v14_w;
self.mod_1seg_aa_dist_14              := mod_1seg_aa_dist_14;
self.mod_1seg_aa_code_14              := mod_1seg_aa_code_14;
self.mod_1seg_v15_w                   := mod_1seg_v15_w;
self.mod_1seg_aa_dist_15              := mod_1seg_aa_dist_15;
self.mod_1seg_aa_code_15              := mod_1seg_aa_code_15;
self.mod_1seg_rcvaluei60              := mod_1seg_rcvaluei60;
self.mod_1seg_rcvalued33              := mod_1seg_rcvalued33;
self.mod_1seg_rcvaluea42              := mod_1seg_rcvaluea42;
self.mod_1seg_rcvalued32              := mod_1seg_rcvalued32;
self.mod_1seg_rcvaluec22              := mod_1seg_rcvaluec22;
self.mod_1seg_rcvaluec12              := mod_1seg_rcvaluec12;
self.mod_1seg_rcvalued30              := mod_1seg_rcvalued30;
self.mod_1seg_rcvaluec24              := mod_1seg_rcvaluec24;
self.mod_1seg_rcvalued31              := mod_1seg_rcvalued31;
self.mod_1seg_rcvalues66              := mod_1seg_rcvalues66;
self.mod_1seg_rcvaluei62              := mod_1seg_rcvaluei62;
self.mod_1seg_rcvaluef03              := mod_1seg_rcvaluef03;
self.mod_1seg_lgt                     := mod_1seg_lgt;
self.mod_2seg_v01_w                   := mod_2seg_v01_w;
self.mod_2seg_aa_dist_01              := mod_2seg_aa_dist_01;
self.mod_2seg_aa_code_01              := mod_2seg_aa_code_01;
self.mod_2seg_v02_w                   := mod_2seg_v02_w;
self.mod_2seg_aa_dist_02              := mod_2seg_aa_dist_02;
self.mod_2seg_aa_code_02              := mod_2seg_aa_code_02;
self.mod_2seg_v03_w                   := mod_2seg_v03_w;
self.mod_2seg_aa_dist_03              := mod_2seg_aa_dist_03;
self.mod_2seg_aa_code_03              := mod_2seg_aa_code_03;
self.mod_2seg_v04_w                   := mod_2seg_v04_w;
self.mod_2seg_aa_dist_04              := mod_2seg_aa_dist_04;
self.mod_2seg_aa_code_04              := mod_2seg_aa_code_04;
self.mod_2seg_v05_w                   := mod_2seg_v05_w;
self.mod_2seg_aa_dist_05              := mod_2seg_aa_dist_05;
self.mod_2seg_aa_code_05              := mod_2seg_aa_code_05;
self.mod_2seg_v06_w                   := mod_2seg_v06_w;
self.mod_2seg_aa_dist_06              := mod_2seg_aa_dist_06;
self.mod_2seg_aa_code_06              := mod_2seg_aa_code_06;
self.mod_2seg_v07_w                   := mod_2seg_v07_w;
self.mod_2seg_aa_dist_07              := mod_2seg_aa_dist_07;
self.mod_2seg_aa_code_07              := mod_2seg_aa_code_07;
self.mod_2seg_v08_w                   := mod_2seg_v08_w;
self.mod_2seg_aa_dist_08              := mod_2seg_aa_dist_08;
self.mod_2seg_aa_code_08              := mod_2seg_aa_code_08;
self.mod_2seg_v09_w                   := mod_2seg_v09_w;
self.mod_2seg_aa_dist_09              := mod_2seg_aa_dist_09;
self.mod_2seg_aa_code_09              := mod_2seg_aa_code_09;
self.mod_2seg_v10_w                   := mod_2seg_v10_w;
self.mod_2seg_aa_dist_10              := mod_2seg_aa_dist_10;
self.mod_2seg_aa_code_10              := mod_2seg_aa_code_10;
self.mod_2seg_v11_w                   := mod_2seg_v11_w;
self.mod_2seg_aa_dist_11              := mod_2seg_aa_dist_11;
self.mod_2seg_aa_code_11              := mod_2seg_aa_code_11;
self.mod_2seg_v12_w                   := mod_2seg_v12_w;
self.mod_2seg_aa_dist_12              := mod_2seg_aa_dist_12;
self.mod_2seg_aa_code_12              := mod_2seg_aa_code_12;
self.mod_2seg_v13_w                   := mod_2seg_v13_w;
self.mod_2seg_aa_dist_13              := mod_2seg_aa_dist_13;
self.mod_2seg_aa_code_13              := mod_2seg_aa_code_13;
self.mod_2seg_v14_w                   := mod_2seg_v14_w;
self.mod_2seg_aa_dist_14              := mod_2seg_aa_dist_14;
self.mod_2seg_aa_code_14              := mod_2seg_aa_code_14;
self.mod_2seg_v15_w                   := mod_2seg_v15_w;
self.mod_2seg_aa_dist_15              := mod_2seg_aa_dist_15;
self.mod_2seg_aa_code_15              := mod_2seg_aa_code_15;
self.mod_2seg_aa_code_00              := mod_2seg_aa_code_00;
self.mod_2seg_aa_dist_00              := mod_2seg_aa_dist_00;
self.mod_2seg_rcvaluei60              := mod_2seg_rcvaluei60;
self.mod_2seg_rcvalued33              := mod_2seg_rcvalued33;
self.mod_2seg_rcvalued32              := mod_2seg_rcvalued32;
self.mod_2seg_rcvaluea42              := mod_2seg_rcvaluea42;
self.mod_2seg_rcvaluec20              := mod_2seg_rcvaluec20;
self.mod_2seg_rcvaluec22              := mod_2seg_rcvaluec22;
self.mod_2seg_rcvaluec12              := mod_2seg_rcvaluec12;
self.mod_2seg_rcvalued30              := mod_2seg_rcvalued30;
self.mod_2seg_rcvalued31              := mod_2seg_rcvalued31;
self.mod_2seg_rcvaluei62              := mod_2seg_rcvaluei62;
self.mod_2seg_rcvaluef03              := mod_2seg_rcvaluef03;
self.mod_2seg_lgt                     := mod_2seg_lgt;
self.mod_3seg_v01_w                   := mod_3seg_v01_w;
self.mod_3seg_aa_dist_01              := mod_3seg_aa_dist_01;
self.mod_3seg_aa_code_01              := mod_3seg_aa_code_01;
self.mod_3seg_v02_w                   := mod_3seg_v02_w;
self.mod_3seg_aa_dist_02              := mod_3seg_aa_dist_02;
self.mod_3seg_aa_code_02              := mod_3seg_aa_code_02;
self.mod_3seg_v03_w                   := mod_3seg_v03_w;
self.mod_3seg_aa_dist_03              := mod_3seg_aa_dist_03;
self.mod_3seg_aa_code_03              := mod_3seg_aa_code_03;
self.mod_3seg_v04_w                   := mod_3seg_v04_w;
self.mod_3seg_aa_dist_04              := mod_3seg_aa_dist_04;
self.mod_3seg_aa_code_04              := mod_3seg_aa_code_04;
self.mod_3seg_v05_w                   := mod_3seg_v05_w;
self.mod_3seg_aa_dist_05              := mod_3seg_aa_dist_05;
self.mod_3seg_aa_code_05              := mod_3seg_aa_code_05;
self.mod_3seg_v06_w                   := mod_3seg_v06_w;
self.mod_3seg_aa_dist_06              := mod_3seg_aa_dist_06;
self.mod_3seg_aa_code_06              := mod_3seg_aa_code_06;
self.mod_3seg_v07_w                   := mod_3seg_v07_w;
self.mod_3seg_aa_dist_07              := mod_3seg_aa_dist_07;
self.mod_3seg_aa_code_07              := mod_3seg_aa_code_07;
self.mod_3seg_v08_w                   := mod_3seg_v08_w;
self.mod_3seg_aa_dist_08              := mod_3seg_aa_dist_08;
self.mod_3seg_aa_code_08              := mod_3seg_aa_code_08;
self.mod_3seg_rcvaluei60              := mod_3seg_rcvaluei60;
self.mod_3seg_rcvaluec13              := mod_3seg_rcvaluec13;
self.mod_3seg_rcvaluec12              := mod_3seg_rcvaluec12;
self.mod_3seg_rcvalues66              := mod_3seg_rcvalues66;
self.mod_3seg_rcvaluec22              := mod_3seg_rcvaluec22;
self.mod_3seg_lgt                     := mod_3seg_lgt;
self.mod_4seg_v01_w                   := mod_4seg_v01_w;
self.mod_4seg_aa_dist_01              := mod_4seg_aa_dist_01;
self.mod_4seg_aa_code_01              := mod_4seg_aa_code_01;
self.mod_4seg_v02_w                   := mod_4seg_v02_w;
self.mod_4seg_aa_dist_02              := mod_4seg_aa_dist_02;
self.mod_4seg_aa_code_02              := mod_4seg_aa_code_02;
self.mod_4seg_v03_w                   := mod_4seg_v03_w;
self.mod_4seg_aa_dist_03              := mod_4seg_aa_dist_03;
self.mod_4seg_aa_code_03              := mod_4seg_aa_code_03;
self.mod_4seg_v04_w                   := mod_4seg_v04_w;
self.mod_4seg_aa_dist_04              := mod_4seg_aa_dist_04;
self.mod_4seg_aa_code_04              := mod_4seg_aa_code_04;
self.mod_4seg_v05_w                   := mod_4seg_v05_w;
self.mod_4seg_aa_dist_05              := mod_4seg_aa_dist_05;
self.mod_4seg_aa_code_05              := mod_4seg_aa_code_05;
self.mod_4seg_v06_w                   := mod_4seg_v06_w;
self.mod_4seg_aa_dist_06              := mod_4seg_aa_dist_06;
self.mod_4seg_aa_code_06              := mod_4seg_aa_code_06;
self.mod_4seg_v07_w                   := mod_4seg_v07_w;
self.mod_4seg_aa_dist_07              := mod_4seg_aa_dist_07;
self.mod_4seg_aa_code_07              := mod_4seg_aa_code_07;
self.mod_4seg_v08_w                   := mod_4seg_v08_w;
self.mod_4seg_aa_dist_08              := mod_4seg_aa_dist_08;
self.mod_4seg_aa_code_08              := mod_4seg_aa_code_08;
self.mod_4seg_v09_w                   := mod_4seg_v09_w;
self.mod_4seg_aa_dist_09              := mod_4seg_aa_dist_09;
self.mod_4seg_aa_code_09              := mod_4seg_aa_code_09;
self.mod_4seg_v10_w                   := mod_4seg_v10_w;
self.mod_4seg_aa_dist_10              := mod_4seg_aa_dist_10;
self.mod_4seg_aa_code_10              := mod_4seg_aa_code_10;
self.mod_4seg_v11_w                   := mod_4seg_v11_w;
self.mod_4seg_aa_dist_11              := mod_4seg_aa_dist_11;
self.mod_4seg_aa_code_11              := mod_4seg_aa_code_11;
self.mod_4seg_v12_w                   := mod_4seg_v12_w;
self.mod_4seg_aa_dist_12              := mod_4seg_aa_dist_12;
self.mod_4seg_aa_code_12              := mod_4seg_aa_code_12;
self.mod_4seg_v13_w                   := mod_4seg_v13_w;
self.mod_4seg_aa_dist_13              := mod_4seg_aa_dist_13;
self.mod_4seg_aa_code_13              := mod_4seg_aa_code_13;
self.mod_4seg_aa_code_00              := mod_4seg_aa_code_00;
self.mod_4seg_aa_dist_00              := mod_4seg_aa_dist_00;
self.mod_4seg_rcvaluei60              := mod_4seg_rcvaluei60;
self.mod_4seg_rcvaluec13              := mod_4seg_rcvaluec13;
self.mod_4seg_rcvaluec14              := mod_4seg_rcvaluec14;
self.mod_4seg_rcvaluea42              := mod_4seg_rcvaluea42;
self.mod_4seg_rcvaluef01              := mod_4seg_rcvaluef01;
self.mod_4seg_rcvaluec12              := mod_4seg_rcvaluec12;
self.mod_4seg_rcvaluec24              := mod_4seg_rcvaluec24;
self.mod_4seg_rcvalues66              := mod_4seg_rcvalues66;
self.mod_4seg_rcvaluei62              := mod_4seg_rcvaluei62;
self.mod_4seg_rcvaluef03              := mod_4seg_rcvaluef03;
self.mod_4seg_lgt                     := mod_4seg_lgt;
self.seg1_rc1                         := seg1_rc1;
self.seg1_rc4                         := seg1_rc4;
self.seg1_rc5                         := seg1_rc5;
self.seg1_rc2                         := seg1_rc2;
self.seg1_rc3                         := seg1_rc3;
self.seg2_rc2                         := seg2_rc2;
self.seg2_rc3                         := seg2_rc3;
self.seg2_rc1                         := seg2_rc1;
self.seg2_rc5                         := seg2_rc5;
self.seg2_rc4                         := seg2_rc4;
self.seg3_rc1                         := seg3_rc1;
self.seg3_rc5                         := seg3_rc5;
self.seg3_rc3                         := seg3_rc3;
self.seg3_rc4                         := seg3_rc4;
self.seg3_rc2                         := seg3_rc2;
self._rc_inq                          := _rc_inq;
self.seg4_rc1                         := seg4_rc1;
self.seg4_rc5                         := seg4_rc5;
self.seg4_rc3                         := seg4_rc3;
self.seg4_rc4                         := seg4_rc4;
self.seg4_rc2                         := seg4_rc2;
self.iv_rv5_deceased                  := iv_rv5_deceased;
self.iv_rv5_unscorable                := iv_rv5_unscorable;
self.base                             := base;
self.odds                             := odds;
self.point                            := point;
self.rva1908_1_0                      := rva1908_1_0;
self.rc1                              := rc1;
self.rc2                              := rc2;
self.rc4                              := rc4;
self.rc5                              := rc5;
self.rc3                              := rc3;
self.clam                           := le;

#else
	self.ri 		:= PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
	self.score 	:= (STRING3)rva1908_1_0;
    self.seq 		:= le.seq;
#end
  
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
  
END;
