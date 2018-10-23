IMPORT ut, Std, RiskWise, RiskWiseFCRA, Risk_Indicators, riskview;

EXPORT RVG1802_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	MODEL_DEBUG := False;

	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
	                  unsigned seq                             ;
                    integer  sysdate                          ;  //:= sysdate;
                    string  iv_add_apt                       ;  //:= iv_add_apt;
                    integer  rv_d32_criminal_count            ;  //:= rv_d32_criminal_count;
                    integer  rv_a46_curr_avm_autoval          ;  //:= rv_a46_curr_avm_autoval;
                    integer  rv_d33_eviction_count            ;  //:= rv_d33_eviction_count;
                    string  rv_d31_all_bk                    ;  //:= rv_d31_all_bk;
                    integer  rv_i62_inq_phones_per_adl        ;  //:= rv_i62_inq_phones_per_adl;
                    integer  _in_dob                          ;  //:= _in_dob;
                    integer  yr_in_dob                        ;  //:= yr_in_dob;
                    integer  yr_in_dob_int                    ;  //:= yr_in_dob_int;
                    integer  rv_comb_age                      ;  //:= rv_comb_age;
                    integer  rv_i60_inq_other_count12         ;  //:= rv_i60_inq_other_count12;
                    integer  rv_a41_a42_prop_owner_history    ;  //:= rv_a41_a42_prop_owner_history;
                    integer  rv_e55_college_ind               ;  //:= rv_e55_college_ind;
                    integer  rv_e57_prof_license_br_flag      ;  //:= rv_e57_prof_license_br_flag;
                    integer  rv_l79_adls_per_sfd_addr         ;  //:= rv_l79_adls_per_sfd_addr;
                    integer  rv_d34_unrel_lien60_count        ;  //:= rv_d34_unrel_lien60_count;
                    integer  rv_f03_address_match             ;  //:= rv_f03_address_match;
                    integer  rv_i60_inq_comm_count12          ;  //:= rv_i60_inq_comm_count12;
                    integer  _header_first_seen               ;  //:= _header_first_seen;
                    integer  rv_c10_m_hdr_fs                  ;  //:= rv_c10_m_hdr_fs;
                    integer  rv_f00_addr_not_ver_w_ssn        ;  //:= rv_f00_addr_not_ver_w_ssn;
                    integer  rv_i60_inq_count12               ;  //:= rv_i60_inq_count12;
                    integer  rv_i62_inq_addrsperadl_count12   ;  //:= rv_i62_inq_addrsperadl_count12;
                    real  infparf_v01_w                    ;  //:= infparf_v01_w;
                    string  infparf_aa_code_01               ;  //:= infparf_aa_code_01;
                    real  infparf_aa_dist_01               ;  //:= infparf_aa_dist_01;
                    real  infparf_v02_w                    ;  //:= infparf_v02_w;
                    string  infparf_aa_code_02               ;  //:= infparf_aa_code_02;
                    real  infparf_aa_dist_02               ;  //:= infparf_aa_dist_02;
                    real  infparf_v03_w                    ;  //:= infparf_v03_w;
                    string  infparf_aa_code_03               ;  //:= infparf_aa_code_03;
                    real  infparf_aa_dist_03               ;  //:= infparf_aa_dist_03;
                    real  infparf_v04_w                    ;  //:= infparf_v04_w;
                    string  infparf_aa_code_04               ;  //:= infparf_aa_code_04;
                    real  infparf_aa_dist_04               ;  //:= infparf_aa_dist_04;
                    real  infparf_v05_w                    ;  //:= infparf_v05_w;
                    string  infparf_aa_code_05               ;  //:= infparf_aa_code_05;
                    real  infparf_aa_dist_05               ;  //:= infparf_aa_dist_05;
                    real  infparf_v06_w                    ;  //:= infparf_v06_w;
                    string  infparf_aa_code_06               ;  //:= infparf_aa_code_06;
                    real  infparf_aa_dist_06               ;  //:= infparf_aa_dist_06;
                    real  infparf_v07_w                    ;  //:= infparf_v07_w;
                    string  infparf_aa_code_07               ;  //:= infparf_aa_code_07;
                    real  infparf_aa_dist_07               ;  //:= infparf_aa_dist_07;
                    real  infparf_v08_w                    ;  //:= infparf_v08_w;
                    string  infparf_aa_code_08               ;  //:= infparf_aa_code_08;
                    real  infparf_aa_dist_08               ;  //:= infparf_aa_dist_08;
                    real  infparf_v09_w                    ;  //:= infparf_v09_w;
                    string  infparf_aa_code_09               ;  //:= infparf_aa_code_09;
                    real  infparf_aa_dist_09               ;  //:= infparf_aa_dist_09;
                    real  infparf_v10_w                    ;  //:= infparf_v10_w;
                    string  infparf_aa_code_10               ;  //:= infparf_aa_code_10;
                    real  infparf_aa_dist_10               ;  //:= infparf_aa_dist_10;
                    real  infparf_v11_w                    ;  //:= infparf_v11_w;
                    string  infparf_aa_code_11               ;  //:= infparf_aa_code_11;
                    real  infparf_aa_dist_11               ;  //:= infparf_aa_dist_11;
                    real  infparf_v12_w                    ;  //:= infparf_v12_w;
                    string  infparf_aa_code_12               ;  //:= infparf_aa_code_12;
                    real  infparf_aa_dist_12               ;  //:= infparf_aa_dist_12;
                    real  infparf_v13_w                    ;  //:= infparf_v13_w;
                    string  infparf_aa_code_13               ;  //:= infparf_aa_code_13;
                    real  infparf_aa_dist_13               ;  //:= infparf_aa_dist_13;
                    real  infparf_v14_w                    ;  //:= infparf_v14_w;
                    string  infparf_aa_code_14               ;  //:= infparf_aa_code_14;
                    real  infparf_aa_dist_14               ;  //:= infparf_aa_dist_14;
                    real  infparf_v15_w                    ;  //:= infparf_v15_w;
                    string  infparf_aa_code_15               ;  //:= infparf_aa_code_15;
                    real  infparf_aa_dist_15               ;  //:= infparf_aa_dist_15;
                    real  infparf_v16_w                    ;  //:= infparf_v16_w;
                    string  infparf_aa_code_16               ;  //:= infparf_aa_code_16;
                    real  infparf_aa_dist_16               ;  //:= infparf_aa_dist_16;
                    real  infparf_v17_w                    ;  //:= infparf_v17_w;
                    string  infparf_aa_code_17               ;  //:= infparf_aa_code_17;
                    real  infparf_aa_dist_17               ;  //:= infparf_aa_dist_17;
                    real  infparf_v18_w                    ;  //:= infparf_v18_w;
                    string  infparf_aa_code_18               ;  //:= infparf_aa_code_18;
                    real  infparf_aa_dist_18               ;  //:= infparf_aa_dist_18;
                    real  infparf_rcvaluel79               ;  //:= infparf_rcvaluel79;
                    real  infparf_rcvaluef03               ;  //:= infparf_rcvaluef03;
                    real  infparf_rcvalued34               ;  //:= infparf_rcvalued34;
                    real  infparf_rcvalued32               ;  //:= infparf_rcvalued32;
                    real  infparf_rcvalued33               ;  //:= infparf_rcvalued33;
                    real  infparf_rcvalued31               ;  //:= infparf_rcvalued31;
                    real  infparf_rcvaluea46               ;  //:= infparf_rcvaluea46;
                    real  infparf_rcvaluei60               ;  //:= infparf_rcvaluei60;
                    real  infparf_rcvaluef00               ;  //:= infparf_rcvaluef00;
                    real  infparf_rcvaluei62               ;  //:= infparf_rcvaluei62;
                    real  infparf_rcvaluea41               ;  //:= infparf_rcvaluea41;
                    real  infparf_rcvaluee55               ;  //:= infparf_rcvaluee55;
                    real  infparf_rcvaluea42               ;  //:= infparf_rcvaluea42;
                    real  infparf_rcvaluee57               ;  //:= infparf_rcvaluee57;
                    real  infparf_rcvaluec10               ;  //:= infparf_rcvaluec10;
                    real  infparf_lgt                      ;  //:= infparf_lgt;
                    string  r_rc1                            ;  //:= r_rc1;
                    string  r_rc2                            ;  //:= r_rc2;
                    string  r_rc3                            ;  //:= r_rc3;
                    string  r_rc4                            ;  //:= r_rc4;
                    string  r_rc5                            ;  //:= r_rc5;
                    string  r_rc6                            ;  //:= r_rc6;
                    string  r_rc7                            ;  //:= r_rc7;
                    string  r_rc8                            ;  //:= r_rc8;
                    string  r_rc9                            ;  //:= r_rc9;
                    string  r_rc10                           ;  //:= r_rc10;
                    string  r_rc11                           ;  //:= r_rc11;
                    string  r_rc12                           ;  //:= r_rc12;
                    string  r_rc13                           ;  //:= r_rc13;
                    string  r_rc14                           ;  //:= r_rc14;
                    string  r_rc15                           ;  //:= r_rc15;
                    string  r_rc16                           ;  //:= r_rc16;
                    string  r_rc17                           ;  //:= r_rc17;
                    string  r_rc18                           ;  //:= r_rc18;
                    real  r_vl1                            ;  //:= r_vl1;
                    real  r_vl2                            ;  //:= r_vl2;
                    real  r_vl3                            ;  //:= r_vl3;
                    real  r_vl4                            ;  //:= r_vl4;
                    real  r_vl5                            ;  //:= r_vl5;
                    real  r_vl6                            ;  //:= r_vl6;
                    real  r_vl7                            ;  //:= r_vl7;
                    real  r_vl8                            ;  //:= r_vl8;
                    real  r_vl9                            ;  //:= r_vl9;
                    real  r_vl10                           ;  //:= r_vl10;
                    real  r_vl11                           ;  //;= r_vl11;
                    real  r_vl12                           ;  //;= r_vl12;
                    real  r_vl13                           ;  //;= r_vl13;
                    real  r_vl14                           ;  //;= r_vl14;
                    real  r_vl15                           ;  //;= r_vl15;
                    real  r_vl16                           ;  //;= r_vl16;
                    real  r_vl17                           ;  //;= r_vl17;
                    real  r_vl18                           ;  //;= r_vl18;
                    boolean  iv_rv5_deceased                  ;  //;= iv_rv5_deceased;
                    string  iv_rv5_unscorable                ;  //;= iv_rv5_unscorable;
                    integer  rvg1802_1_0                      ;  //;= rvg1802_1_0;
                    string  _rc_inq                          ;  //;= _rc_inq;
                    string  rc5                              ;  //:= rc5;
                    string  rc2                              ;  //:= rc2;
                    string  rc3                              ;  //:= rc3;
                    string  rc4                              ;  //:= rc4;
                    string  rc1                              ;  //:= rc1;

			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_decsflag                      := le.iid.decsflag;
	rc_dwelltype                     := le.iid.dwelltype;
	ver_sources                      := le.header_summary.ver_sources;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_isbestmatch             := le.address_verification.address_history_1.isbestmatch;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	header_first_seen                := le.ssn_verification.header_first_seen;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_other_count12                := le.acc_logs.other.count12;
	inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	br_source_count                  := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_dismissed_recent_count        := le.bjl.bk_dismissed_recent_count;
	bk_dismissed_historical_count    := le.bjl.bk_dismissed_historical_count;
	bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
	bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
	criminal_count                   := le.bjl.criminal_count;
	college_file_type                := le.student.file_type2;
	college_attendance               := le.attended_college;
	prof_license_flag                := le.professional_license.professional_license_flag;
	inferred_age                     := le.inferred_age;

	
	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */


NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

//sysdate := common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01'));
sysdate := common.sas_date(if(le.historydate=999999, (string)std.Date.Today(), (string6)le.historydate+'01'));

iv_add_apt := if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0');

rv_d32_criminal_count := if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999));

rv_a46_curr_avm_autoval := if(not(truedid), NULL, add_curr_avm_auto_val);

rv_d33_eviction_count := if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999));

rv_d31_all_bk := map(
    not(truedid)                                                                                                                                                                                                                                                                                                   => '',
    contains_i(StringLib.StringToUpperCase(disposition), 'DISMISS') = 1 or if(max(bk_dismissed_recent_count, bk_dismissed_historical_count) = NULL, NULL, sum(if(bk_dismissed_recent_count = NULL, 0, bk_dismissed_recent_count), if(bk_dismissed_historical_count = NULL, 0, bk_dismissed_historical_count))) > 0 => '1 - BK DISMISSED',
    contains_i(StringLib.StringToUpperCase(disposition), 'DISCHARG') = 1 or if(max(bk_disposed_recent_count, bk_disposed_historical_count) = NULL, NULL, sum(if(bk_disposed_recent_count = NULL, 0, bk_disposed_recent_count), if(bk_disposed_historical_count = NULL, 0, bk_disposed_historical_count))) > 0      => '2 - BK DISCHARGED',
 //   bankrupt = 1 or filing_count > 0                                                                                                                                                                                                                                                                               => '3 - BK OTHER',
       bankrupt  or filing_count > 0                                                                                                                                                                                                                                                                               => '3 - BK OTHER',
                                                                                                                                                                                                                                                                                                                      '0 - NO BK');

rv_i62_inq_phones_per_adl := if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999));

_in_dob := common.sas_date((string)(in_dob));

yr_in_dob := if(_in_dob = NULL, -1, (sysdate - _in_dob) / 365.25);

yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

rv_comb_age := map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                                    NULL);

rv_i60_inq_other_count12 := if(not(truedid), NULL, min(if(inq_other_count12 = NULL, -NULL, inq_other_count12), 999));

rv_a41_a42_prop_owner_history := map(
    not(truedid)                                                                     => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 2,
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 1,
                                                                                        0);

rv_e55_college_ind := map(
    not(truedid)                                                 => NULL,
    (college_file_type in ['H', 'C', 'A']) or college_attendance => 1,
                                                                    0);

rv_e57_prof_license_br_flag := if(not(truedid), NULL, (integer)(if(max((integer)prof_license_flag, br_source_count) = NULL, NULL, sum((integer)prof_license_flag, if(br_source_count = NULL, 0, br_source_count))) > 0));

rv_l79_adls_per_sfd_addr := map(
    not(addrpop)   => NULL,
    iv_add_apt = '1' => -1,
                      min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

rv_d34_unrel_lien60_count := if(not(truedid), NULL, min(if(attr_num_unrel_liens60 = NULL, -NULL, attr_num_unrel_liens60), 999));

rv_f03_address_match := map(
    not(truedid)                                => NULL,
    add_input_isbestmatch                       => 4,
    not(add_input_pop) and add_curr_isbestmatch => 3,
    add_input_pop and add_curr_isbestmatch      => 2,
    add_curr_pop                                => 1,
    add_input_pop                               => 0,
                                                   NULL);

rv_i60_inq_comm_count12 := if(not(truedid), NULL, min(if(inq_communications_count12 = NULL, -NULL, inq_communications_count12), 999));

_header_first_seen := common.sas_date((string)(header_first_seen));

rv_c10_m_hdr_fs := map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => -1,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));

rv_f00_addr_not_ver_w_ssn := if(not(truedid and (integer)ssnlength > 0), NULL, (integer)(nas_summary in [4, 7, 9]));

rv_i60_inq_count12 := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));

rv_i62_inq_addrsperadl_count12 := if(not(truedid), NULL, min(if(Inq_AddrsPerADL = NULL, -NULL, Inq_AddrsPerADL), 999));

infparf_v01_w := map(
    rv_d32_criminal_count = NULL => 0,
    rv_d32_criminal_count = -1   => 0,
    rv_d32_criminal_count <= 0.5 => -0.160098110898014,
    rv_d32_criminal_count <= 1.5 => 0.118878815895709,
    rv_d32_criminal_count <= 3.5 => 0.275068847135288,
    rv_d32_criminal_count <= 5.5 => 0.410153278908298,
                                    0.525910693015319);

infparf_aa_code_01 := map(
    rv_d32_criminal_count = NULL => '',
    rv_d32_criminal_count = -1   => '',
    rv_d32_criminal_count <= 0.5 => '',
    rv_d32_criminal_count <= 1.5 => 'D32',
    rv_d32_criminal_count <= 3.5 => 'D32',
    rv_d32_criminal_count <= 5.5 => 'D32',
                                    'D32');

infparf_aa_dist_01 := -0.160098110898014 - infparf_v01_w;

infparf_v02_w := map(
    rv_a46_curr_avm_autoval = NULL      => 0,
    rv_a46_curr_avm_autoval = -1        => 0,
    rv_a46_curr_avm_autoval <= 124095.5 => 0.132859331073657,
    rv_a46_curr_avm_autoval <= 134957.5 => 0.0879082398455478,
    rv_a46_curr_avm_autoval <= 165050   => -0.00560156559516089,
    rv_a46_curr_avm_autoval <= 221068.5 => -0.0473120167603182,
    rv_a46_curr_avm_autoval <= 370673   => -0.12389189284346,
                                           -0.154947092825459);

infparf_aa_code_02 := map(
    rv_a46_curr_avm_autoval = NULL      => '',
    rv_a46_curr_avm_autoval = -1        => '',
    rv_a46_curr_avm_autoval <= 124095.5 => 'A46',
    rv_a46_curr_avm_autoval <= 134957.5 => 'A46',
    rv_a46_curr_avm_autoval <= 165050   => 'A46',
    rv_a46_curr_avm_autoval <= 221068.5 => 'A46',
    rv_a46_curr_avm_autoval <= 370673   => 'A46',
                                           '');

infparf_aa_dist_02 := -0.154947092825459 - infparf_v02_w;

infparf_v03_w := map(
    rv_d33_eviction_count = NULL => 0,
    rv_d33_eviction_count = -1   => 0,
    rv_d33_eviction_count <= 0.5 => -0.104749404275335,
    rv_d33_eviction_count <= 1.5 => 0.0611378337815625,
    rv_d33_eviction_count <= 6.5 => 0.229106259108732,
                                    0.326071585890986);

infparf_aa_code_03 := map(
    rv_d33_eviction_count = NULL => '',
    rv_d33_eviction_count = -1   => '',
    rv_d33_eviction_count <= 0.5 => '',
    rv_d33_eviction_count <= 1.5 => 'D33',
    rv_d33_eviction_count <= 6.5 => 'D33',
                                    'D33');

infparf_aa_dist_03 := -0.104749404275335 - infparf_v03_w;

infparf_v04_w := map(
    (rv_d31_all_bk in [' '])                          => 0,
   // rv_d31_all_bk = NULL                             => 0,
    (rv_d31_all_bk in ['0 - NO BK', '3 - BK OTHER']) => 0.105776953609945,
    (rv_d31_all_bk in ['1 - BK DISMISSED'])          => 0.177790487226466,
    (rv_d31_all_bk in ['2 - BK DISCHARGED'])         => -0.151198844346218,
                                                        0);

infparf_aa_code_04 := map(
//    rv_d31_all_bk = NULL                             => '',
   ( rv_d31_all_bk in [''])                            => '',
//    rv_d31_all_bk = NULL                             => '',
    (rv_d31_all_bk in [''])                             => '',
//    (rv_d31_all_bk in ['0 - NO BK', '3 - BK OTHER']) => '',
    (rv_d31_all_bk in ['0 - NO BK', '3 - BK OTHER']) => '',
    (rv_d31_all_bk in ['1 - BK DISMISSED'])          => 'D31',
   // (rv_d31_all_bk in ['2 - BK DISCHARGED'])         => '',
    (rv_d31_all_bk in ['2 - BK DISCHARGED'])         => '',
                                                      '');
         

infparf_aa_dist_04 := -0.151198844346218 - infparf_v04_w;

infparf_v05_w := map(
    rv_i62_inq_phones_per_adl = NULL => 0,
    rv_i62_inq_phones_per_adl = -1   => 0,
    rv_i62_inq_phones_per_adl <= 1.5 => -0.0911008697404685,
    rv_i62_inq_phones_per_adl <= 2.5 => 0.0627817136385587,
    rv_i62_inq_phones_per_adl <= 4.5 => 0.17384714877042,
                                        0.336121888229542);

infparf_aa_code_05 := map(
    rv_i62_inq_phones_per_adl = NULL => '',
    rv_i62_inq_phones_per_adl = -1   => '',
    rv_i62_inq_phones_per_adl <= 1.5 => '',
    rv_i62_inq_phones_per_adl <= 2.5 => 'I62',
    rv_i62_inq_phones_per_adl <= 4.5 => 'I62',
                                        'I62');

infparf_aa_dist_05 := -0.0911008697404685 - infparf_v05_w;

infparf_v06_w := map(
    rv_comb_age = NULL  => 0,
    rv_comb_age = -1    => 0,
    rv_comb_age <= 17   => 0,
    rv_comb_age <= 23.5 => 0.109398418241836,
    rv_comb_age <= 33.5 => 0.0735270903226119,
    rv_comb_age <= 39.5 => 0.0151626719117928,
    rv_comb_age <= 56.5 => -0.0225318641127738,
    rv_comb_age <= 61.5 => -0.0512784359072734,
                           -0.235608659219194);

infparf_aa_code_06 := map(
    rv_comb_age = NULL  => 'C10',
    rv_comb_age = -1    => 'C10',
    rv_comb_age <= 17   => 'C10',
    rv_comb_age <= 23.5 => 'C10',
    rv_comb_age <= 33.5 => 'C10',
    rv_comb_age <= 39.5 => 'C10',
    rv_comb_age <= 56.5 => 'C10',
    rv_comb_age <= 61.5 => 'C10',
                           '');

infparf_aa_dist_06 := -0.235608659219194 - infparf_v06_w;

infparf_v07_w := map(
    rv_i60_inq_other_count12 = NULL => 0,
    rv_i60_inq_other_count12 = -1   => 0,
    rv_i60_inq_other_count12 <= 0.5 => -0.0721702923587725,
    rv_i60_inq_other_count12 <= 2.5 => 0.106835274294211,
                                       0.129628072332839);

infparf_aa_code_07 := map(
    rv_i60_inq_other_count12 = NULL => '',
    rv_i60_inq_other_count12 = -1   => '',
    rv_i60_inq_other_count12 <= 0.5 => '',
    rv_i60_inq_other_count12 <= 2.5 => 'I60',
                                       'I60');

infparf_aa_dist_07 := -0.0721702923587725 - infparf_v07_w;

infparf_v08_w := map(
    rv_a41_a42_prop_owner_history = NULL => 0,
    rv_a41_a42_prop_owner_history = -1   => 0,
    rv_a41_a42_prop_owner_history <= 0.5 => 0.0823338700560719,
    rv_a41_a42_prop_owner_history <= 1.5 => -0.0200969701043844,
                                            -0.0662681994988606);

infparf_aa_code_08 := map(
    rv_a41_a42_prop_owner_history = NULL => 'A41',
    rv_a41_a42_prop_owner_history = -1   => 'A41',
    rv_a41_a42_prop_owner_history <= 0.5 => 'A41',
    rv_a41_a42_prop_owner_history <= 1.5 => 'A42',
                                            '');

infparf_aa_dist_08 := -0.0662681994988606 - infparf_v08_w;

infparf_v09_w := map(
    rv_e55_college_ind = NULL => 0,
    rv_e55_college_ind = -1   => 0,
    rv_e55_college_ind <= 0.5 => 0.0793547956564662,
                                 -0.0452561202662779);

infparf_aa_code_09 := map(
    rv_e55_college_ind = NULL => '',
    rv_e55_college_ind = -1   => 'E55',
    rv_e55_college_ind <= 0.5 => 'E55',
                                 '');

infparf_aa_dist_09 := -0.0452561202662779 - infparf_v09_w;

infparf_v10_w := map(
    rv_e57_prof_license_br_flag = NULL => 0,
    rv_e57_prof_license_br_flag = -1   => 0,
    rv_e57_prof_license_br_flag <= 0.5 => 0.0659948280014541,
                                          -0.0337911916673598);

infparf_aa_code_10 := map(
    rv_e57_prof_license_br_flag = NULL => '',
    rv_e57_prof_license_br_flag = -1   => '',
    rv_e57_prof_license_br_flag <= 0.5 => 'E57',
                                          '');

infparf_aa_dist_10 := -0.0337911916673598 - infparf_v10_w;

infparf_v11_w := map(
    rv_l79_adls_per_sfd_addr = NULL => 0,
    rv_l79_adls_per_sfd_addr = -1   => -0.0627580362536214,
    rv_l79_adls_per_sfd_addr <= 3.5 => -0.00864450385241693,
    rv_l79_adls_per_sfd_addr <= 5.5 => 0.0585417764005426,
    rv_l79_adls_per_sfd_addr <= 8.5 => 0.11243937213974,
                                       0.210273074639642);

infparf_aa_code_11 := map(
    rv_l79_adls_per_sfd_addr = NULL => '',
    rv_l79_adls_per_sfd_addr = -1   => '',
    rv_l79_adls_per_sfd_addr <= 3.5 => '',
    rv_l79_adls_per_sfd_addr <= 5.5 => 'L79',
    rv_l79_adls_per_sfd_addr <= 8.5 => 'L79',
                                       'L79');

infparf_aa_dist_11 := -0.00864450385241693 - infparf_v11_w;

infparf_v12_w := map(
    rv_d34_unrel_lien60_count = NULL => 0,
    rv_d34_unrel_lien60_count = -1   => 0,
    rv_d34_unrel_lien60_count <= 0.5 => -0.0479830752942192,
                                        0.0924757656050195);

infparf_aa_code_12 := map(
    rv_d34_unrel_lien60_count = NULL => '',
    rv_d34_unrel_lien60_count = -1   => '',
    rv_d34_unrel_lien60_count <= 0.5 => '',
                                        'D34');

infparf_aa_dist_12 := -0.0479830752942192 - infparf_v12_w;

infparf_v13_w := map(
    rv_f03_address_match = NULL => 0,
    rv_f03_address_match = -1   => 0,
    rv_f03_address_match <= 2.5 => 0.0632987025278983,
                                   -0.0393526215619474);

infparf_aa_code_13 := map(
    rv_f03_address_match = NULL => '',
    rv_f03_address_match = -1   => '',
    rv_f03_address_match <= 2.5 => 'F03',
                                   '');

infparf_aa_dist_13 := -0.0393526215619474 - infparf_v13_w;

infparf_v14_w := map(
    rv_i60_inq_comm_count12 = NULL => 0,
    rv_i60_inq_comm_count12 = -1   => 0,
    rv_i60_inq_comm_count12 <= 0.5 => -0.0313996300785634,
                                      0.0837244141529566);

infparf_aa_code_14 := map(
    rv_i60_inq_comm_count12 = NULL => '',
    rv_i60_inq_comm_count12 = -1   => '',
    rv_i60_inq_comm_count12 <= 0.5 => '',
                                      'I60');

infparf_aa_dist_14 := -0.0313996300785634 - infparf_v14_w;

infparf_v15_w := map(
    rv_c10_m_hdr_fs = NULL   => 0,
    rv_c10_m_hdr_fs = -1     => 0.181319986962699,
    rv_c10_m_hdr_fs <= 49.5  => 0.0976179214205743,
    rv_c10_m_hdr_fs <= 69.5  => 0.0600548532296996,
    rv_c10_m_hdr_fs <= 378.5 => 0.0118719455346725,
    rv_c10_m_hdr_fs <= 405.5 => -0.0270008979369209,
                                -0.0877427398992061);

infparf_aa_code_15 := map(
    rv_c10_m_hdr_fs = NULL   => 'C10',
    rv_c10_m_hdr_fs = -1     => 'C10',
    rv_c10_m_hdr_fs <= 49.5  => 'C10',
    rv_c10_m_hdr_fs <= 69.5  => 'C10',
    rv_c10_m_hdr_fs <= 378.5 => 'C10',
    rv_c10_m_hdr_fs <= 405.5 => 'C10',
                                'C10');

infparf_aa_dist_15 := -0.0877427398992061 - infparf_v15_w;

infparf_v16_w := map(
    rv_f00_addr_not_ver_w_ssn = NULL => 0,
    rv_f00_addr_not_ver_w_ssn = -1   => 0,
    rv_f00_addr_not_ver_w_ssn <= 0.5 => -0.0276613817902477,
                                        0.0661513974506065);

infparf_aa_code_16 := map(
    rv_f00_addr_not_ver_w_ssn = NULL => '',
    rv_f00_addr_not_ver_w_ssn = -1   => '',
    rv_f00_addr_not_ver_w_ssn <= 0.5 => '',
                                        'F00');

infparf_aa_dist_16 := -0.0276613817902477 - infparf_v16_w;

infparf_v17_w := map(
    rv_i60_inq_count12 = NULL  => 0,
    rv_i60_inq_count12 = -1    => 0,
    rv_i60_inq_count12 <= 7.5  => -0.0188590206582419,
    rv_i60_inq_count12 <= 11.5 => 0.0605271354375221,
                                  0.151059451509018);

infparf_aa_code_17 := map(
    rv_i60_inq_count12 = NULL  => '',
    rv_i60_inq_count12 = -1    => '',
    rv_i60_inq_count12 <= 7.5  => '',
    rv_i60_inq_count12 <= 11.5 => 'I60',
                                  'I60');

infparf_aa_dist_17 := -0.0188590206582419 - infparf_v17_w;

infparf_v18_w := map(
    rv_i62_inq_addrsperadl_count12 = NULL => 0,
    rv_i62_inq_addrsperadl_count12 = -1   => 0,
    rv_i62_inq_addrsperadl_count12 <= 1.5 => -0.0127047030654686,
    rv_i62_inq_addrsperadl_count12 <= 2.5 => -0.00552132883504921,
                                             0.0910320580459076);

infparf_aa_code_18 := map(
    rv_i62_inq_addrsperadl_count12 = NULL => '',
    rv_i62_inq_addrsperadl_count12 = -1   => '',
    rv_i62_inq_addrsperadl_count12 <= 1.5 => '',
    rv_i62_inq_addrsperadl_count12 <= 2.5 => 'I62',
                                             'I62');

infparf_aa_dist_18 := -0.0127047030654686 - infparf_v18_w;

infparf_rcvaluel79 := (integer)(infparf_aa_code_01 = 'L79') * infparf_aa_dist_01 +
    (integer)(infparf_aa_code_02 = 'L79') * infparf_aa_dist_02 +
    (integer)(infparf_aa_code_03 = 'L79') * infparf_aa_dist_03 +
    (integer)(infparf_aa_code_04 = 'L79') * infparf_aa_dist_04 +
    (integer)(infparf_aa_code_05 = 'L79') * infparf_aa_dist_05 +
    (integer)(infparf_aa_code_06 = 'L79') * infparf_aa_dist_06 +
    (integer)(infparf_aa_code_07 = 'L79') * infparf_aa_dist_07 +
    (integer)(infparf_aa_code_08 = 'L79') * infparf_aa_dist_08 +
    (integer)(infparf_aa_code_09 = 'L79') * infparf_aa_dist_09 +
    (integer)(infparf_aa_code_10 = 'L79') * infparf_aa_dist_10 +
    (integer)(infparf_aa_code_11 = 'L79') * infparf_aa_dist_11 +
    (integer)(infparf_aa_code_12 = 'L79') * infparf_aa_dist_12 +
    (integer)(infparf_aa_code_13 = 'L79') * infparf_aa_dist_13 +
    (integer)(infparf_aa_code_14 = 'L79') * infparf_aa_dist_14 +
    (integer)(infparf_aa_code_15 = 'L79') * infparf_aa_dist_15 +
    (integer)(infparf_aa_code_16 = 'L79') * infparf_aa_dist_16 +
    (integer)(infparf_aa_code_17 = 'L79') * infparf_aa_dist_17 +
    (integer)(infparf_aa_code_18 = 'L79') * infparf_aa_dist_18;

infparf_rcvaluef03 := (integer)(infparf_aa_code_01 = 'F03') * infparf_aa_dist_01 +
    (integer)(infparf_aa_code_02 = 'F03') * infparf_aa_dist_02 +
    (integer)(infparf_aa_code_03 = 'F03') * infparf_aa_dist_03 +
    (integer)(infparf_aa_code_04 = 'F03') * infparf_aa_dist_04 +
    (integer)(infparf_aa_code_05 = 'F03') * infparf_aa_dist_05 +
    (integer)(infparf_aa_code_06 = 'F03') * infparf_aa_dist_06 +
    (integer)(infparf_aa_code_07 = 'F03') * infparf_aa_dist_07 +
    (integer)(infparf_aa_code_08 = 'F03') * infparf_aa_dist_08 +
    (integer)(infparf_aa_code_09 = 'F03') * infparf_aa_dist_09 +
    (integer)(infparf_aa_code_10 = 'F03') * infparf_aa_dist_10 +
    (integer)(infparf_aa_code_11 = 'F03') * infparf_aa_dist_11 +
    (integer)(infparf_aa_code_12 = 'F03') * infparf_aa_dist_12 +
    (integer)(infparf_aa_code_13 = 'F03') * infparf_aa_dist_13 +
    (integer)(infparf_aa_code_14 = 'F03') * infparf_aa_dist_14 +
    (integer)(infparf_aa_code_15 = 'F03') * infparf_aa_dist_15 +
    (integer)(infparf_aa_code_16 = 'F03') * infparf_aa_dist_16 +
    (integer)(infparf_aa_code_17 = 'F03') * infparf_aa_dist_17 +
    (integer)(infparf_aa_code_18 = 'F03') * infparf_aa_dist_18;

infparf_rcvalued34 := (integer)(infparf_aa_code_01 = 'D34') * infparf_aa_dist_01 +
    (integer)(infparf_aa_code_02 = 'D34') * infparf_aa_dist_02 +
    (integer)(infparf_aa_code_03 = 'D34') * infparf_aa_dist_03 +
    (integer)(infparf_aa_code_04 = 'D34') * infparf_aa_dist_04 +
    (integer)(infparf_aa_code_05 = 'D34') * infparf_aa_dist_05 +
    (integer)(infparf_aa_code_06 = 'D34') * infparf_aa_dist_06 +
    (integer)(infparf_aa_code_07 = 'D34') * infparf_aa_dist_07 +
    (integer)(infparf_aa_code_08 = 'D34') * infparf_aa_dist_08 +
    (integer)(infparf_aa_code_09 = 'D34') * infparf_aa_dist_09 +
    (integer)(infparf_aa_code_10 = 'D34') * infparf_aa_dist_10 +
    (integer)(infparf_aa_code_11 = 'D34') * infparf_aa_dist_11 +
    (integer)(infparf_aa_code_12 = 'D34') * infparf_aa_dist_12 +
    (integer)(infparf_aa_code_13 = 'D34') * infparf_aa_dist_13 +
    (integer)(infparf_aa_code_14 = 'D34') * infparf_aa_dist_14 +
    (integer)(infparf_aa_code_15 = 'D34') * infparf_aa_dist_15 +
    (integer)(infparf_aa_code_16 = 'D34') * infparf_aa_dist_16 +
    (integer)(infparf_aa_code_17 = 'D34') * infparf_aa_dist_17 +
    (integer)(infparf_aa_code_18 = 'D34') * infparf_aa_dist_18;

infparf_rcvalued32 := (integer)(infparf_aa_code_01 = 'D32') * infparf_aa_dist_01 +
    (integer)(infparf_aa_code_02 = 'D32') * infparf_aa_dist_02 +
    (integer)(infparf_aa_code_03 = 'D32') * infparf_aa_dist_03 +
    (integer)(infparf_aa_code_04 = 'D32') * infparf_aa_dist_04 +
    (integer)(infparf_aa_code_05 = 'D32') * infparf_aa_dist_05 +
    (integer)(infparf_aa_code_06 = 'D32') * infparf_aa_dist_06 +
    (integer)(infparf_aa_code_07 = 'D32') * infparf_aa_dist_07 +
    (integer)(infparf_aa_code_08 = 'D32') * infparf_aa_dist_08 +
    (integer)(infparf_aa_code_09 = 'D32') * infparf_aa_dist_09 +
    (integer)(infparf_aa_code_10 = 'D32') * infparf_aa_dist_10 +
    (integer)(infparf_aa_code_11 = 'D32') * infparf_aa_dist_11 +
    (integer)(infparf_aa_code_12 = 'D32') * infparf_aa_dist_12 +
    (integer)(infparf_aa_code_13 = 'D32') * infparf_aa_dist_13 +
    (integer)(infparf_aa_code_14 = 'D32') * infparf_aa_dist_14 +
    (integer)(infparf_aa_code_15 = 'D32') * infparf_aa_dist_15 +
    (integer)(infparf_aa_code_16 = 'D32') * infparf_aa_dist_16 +
    (integer)(infparf_aa_code_17 = 'D32') * infparf_aa_dist_17 +
    (integer)(infparf_aa_code_18 = 'D32') * infparf_aa_dist_18;

infparf_rcvalued33 := (integer)(infparf_aa_code_01 = 'D33') * infparf_aa_dist_01 +
    (integer)(infparf_aa_code_02 = 'D33') * infparf_aa_dist_02 +
    (integer)(infparf_aa_code_03 = 'D33') * infparf_aa_dist_03 +
    (integer)(infparf_aa_code_04 = 'D33') * infparf_aa_dist_04 +
    (integer)(infparf_aa_code_05 = 'D33') * infparf_aa_dist_05 +
    (integer)(infparf_aa_code_06 = 'D33') * infparf_aa_dist_06 +
    (integer)(infparf_aa_code_07 = 'D33') * infparf_aa_dist_07 +
    (integer)(infparf_aa_code_08 = 'D33') * infparf_aa_dist_08 +
    (integer)(infparf_aa_code_09 = 'D33') * infparf_aa_dist_09 +
    (integer)(infparf_aa_code_10 = 'D33') * infparf_aa_dist_10 +
    (integer)(infparf_aa_code_11 = 'D33') * infparf_aa_dist_11 +
    (integer)(infparf_aa_code_12 = 'D33') * infparf_aa_dist_12 +
    (integer)(infparf_aa_code_13 = 'D33') * infparf_aa_dist_13 +
    (integer)(infparf_aa_code_14 = 'D33') * infparf_aa_dist_14 +
    (integer)(infparf_aa_code_15 = 'D33') * infparf_aa_dist_15 +
    (integer)(infparf_aa_code_16 = 'D33') * infparf_aa_dist_16 +
    (integer)(infparf_aa_code_17 = 'D33') * infparf_aa_dist_17 +
    (integer)(infparf_aa_code_18 = 'D33') * infparf_aa_dist_18;

infparf_rcvalued31 := (integer)(infparf_aa_code_01 = 'D31') * infparf_aa_dist_01 +
    (integer)(infparf_aa_code_02 = 'D31') * infparf_aa_dist_02 +
    (integer)(infparf_aa_code_03 = 'D31') * infparf_aa_dist_03 +
    (integer)(infparf_aa_code_04 = 'D31') * infparf_aa_dist_04 +
    (integer)(infparf_aa_code_05 = 'D31') * infparf_aa_dist_05 +
    (integer)(infparf_aa_code_06 = 'D31') * infparf_aa_dist_06 +
    (integer)(infparf_aa_code_07 = 'D31') * infparf_aa_dist_07 +
    (integer)(infparf_aa_code_08 = 'D31') * infparf_aa_dist_08 +
    (integer)(infparf_aa_code_09 = 'D31') * infparf_aa_dist_09 +
    (integer)(infparf_aa_code_10 = 'D31') * infparf_aa_dist_10 +
    (integer)(infparf_aa_code_11 = 'D31') * infparf_aa_dist_11 +
    (integer)(infparf_aa_code_12 = 'D31') * infparf_aa_dist_12 +
    (integer)(infparf_aa_code_13 = 'D31') * infparf_aa_dist_13 +
    (integer)(infparf_aa_code_14 = 'D31') * infparf_aa_dist_14 +
    (integer)(infparf_aa_code_15 = 'D31') * infparf_aa_dist_15 +
    (integer)(infparf_aa_code_16 = 'D31') * infparf_aa_dist_16 +
    (integer)(infparf_aa_code_17 = 'D31') * infparf_aa_dist_17 +
    (integer)(infparf_aa_code_18 = 'D31') * infparf_aa_dist_18;

infparf_rcvaluea46 := (integer)(infparf_aa_code_01 = 'A46') * infparf_aa_dist_01 +
    (integer)(infparf_aa_code_02 = 'A46') * infparf_aa_dist_02 +
    (integer)(infparf_aa_code_03 = 'A46') * infparf_aa_dist_03 +
    (integer)(infparf_aa_code_04 = 'A46') * infparf_aa_dist_04 +
    (integer)(infparf_aa_code_05 = 'A46') * infparf_aa_dist_05 +
    (integer)(infparf_aa_code_06 = 'A46') * infparf_aa_dist_06 +
    (integer)(infparf_aa_code_07 = 'A46') * infparf_aa_dist_07 +
    (integer)(infparf_aa_code_08 = 'A46') * infparf_aa_dist_08 +
    (integer)(infparf_aa_code_09 = 'A46') * infparf_aa_dist_09 +
    (integer)(infparf_aa_code_10 = 'A46') * infparf_aa_dist_10 +
    (integer)(infparf_aa_code_11 = 'A46') * infparf_aa_dist_11 +
    (integer)(infparf_aa_code_12 = 'A46') * infparf_aa_dist_12 +
    (integer)(infparf_aa_code_13 = 'A46') * infparf_aa_dist_13 +
    (integer)(infparf_aa_code_14 = 'A46') * infparf_aa_dist_14 +
    (integer)(infparf_aa_code_15 = 'A46') * infparf_aa_dist_15 +
    (integer)(infparf_aa_code_16 = 'A46') * infparf_aa_dist_16 +
    (integer)(infparf_aa_code_17 = 'A46') * infparf_aa_dist_17 +
    (integer)(infparf_aa_code_18 = 'A46') * infparf_aa_dist_18;

infparf_rcvaluei60 := (integer)(infparf_aa_code_01 = 'I60') * infparf_aa_dist_01 +
    (integer)(infparf_aa_code_02 = 'I60') * infparf_aa_dist_02 +
    (integer)(infparf_aa_code_03 = 'I60') * infparf_aa_dist_03 +
    (integer)(infparf_aa_code_04 = 'I60') * infparf_aa_dist_04 +
    (integer)(infparf_aa_code_05 = 'I60') * infparf_aa_dist_05 +
    (integer)(infparf_aa_code_06 = 'I60') * infparf_aa_dist_06 +
    (integer)(infparf_aa_code_07 = 'I60') * infparf_aa_dist_07 +
    (integer)(infparf_aa_code_08 = 'I60') * infparf_aa_dist_08 +
    (integer)(infparf_aa_code_09 = 'I60') * infparf_aa_dist_09 +
    (integer)(infparf_aa_code_10 = 'I60') * infparf_aa_dist_10 +
    (integer)(infparf_aa_code_11 = 'I60') * infparf_aa_dist_11 +
    (integer)(infparf_aa_code_12 = 'I60') * infparf_aa_dist_12 +
    (integer)(infparf_aa_code_13 = 'I60') * infparf_aa_dist_13 +
    (integer)(infparf_aa_code_14 = 'I60') * infparf_aa_dist_14 +
    (integer)(infparf_aa_code_15 = 'I60') * infparf_aa_dist_15 +
    (integer)(infparf_aa_code_16 = 'I60') * infparf_aa_dist_16 +
    (integer)(infparf_aa_code_17 = 'I60') * infparf_aa_dist_17 +
    (integer)(infparf_aa_code_18 = 'I60') * infparf_aa_dist_18;

infparf_rcvaluef00 := (integer)(infparf_aa_code_01 = 'F00') * infparf_aa_dist_01 +
    (integer)(infparf_aa_code_02 = 'F00') * infparf_aa_dist_02 +
    (integer)(infparf_aa_code_03 = 'F00') * infparf_aa_dist_03 +
    (integer)(infparf_aa_code_04 = 'F00') * infparf_aa_dist_04 +
    (integer)(infparf_aa_code_05 = 'F00') * infparf_aa_dist_05 +
    (integer)(infparf_aa_code_06 = 'F00') * infparf_aa_dist_06 +
    (integer)(infparf_aa_code_07 = 'F00') * infparf_aa_dist_07 +
    (integer)(infparf_aa_code_08 = 'F00') * infparf_aa_dist_08 +
    (integer)(infparf_aa_code_09 = 'F00') * infparf_aa_dist_09 +
    (integer)(infparf_aa_code_10 = 'F00') * infparf_aa_dist_10 +
    (integer)(infparf_aa_code_11 = 'F00') * infparf_aa_dist_11 +
    (integer)(infparf_aa_code_12 = 'F00') * infparf_aa_dist_12 +
    (integer)(infparf_aa_code_13 = 'F00') * infparf_aa_dist_13 +
    (integer)(infparf_aa_code_14 = 'F00') * infparf_aa_dist_14 +
    (integer)(infparf_aa_code_15 = 'F00') * infparf_aa_dist_15 +
    (integer)(infparf_aa_code_16 = 'F00') * infparf_aa_dist_16 +
    (integer)(infparf_aa_code_17 = 'F00') * infparf_aa_dist_17 +
    (integer)(infparf_aa_code_18 = 'F00') * infparf_aa_dist_18;

infparf_rcvaluei62 := (integer)(infparf_aa_code_01 = 'I62') * infparf_aa_dist_01 +
    (integer)(infparf_aa_code_02 = 'I62') * infparf_aa_dist_02 +
    (integer)(infparf_aa_code_03 = 'I62') * infparf_aa_dist_03 +
    (integer)(infparf_aa_code_04 = 'I62') * infparf_aa_dist_04 +
    (integer)(infparf_aa_code_05 = 'I62') * infparf_aa_dist_05 +
    (integer)(infparf_aa_code_06 = 'I62') * infparf_aa_dist_06 +
    (integer)(infparf_aa_code_07 = 'I62') * infparf_aa_dist_07 +
    (integer)(infparf_aa_code_08 = 'I62') * infparf_aa_dist_08 +
    (integer)(infparf_aa_code_09 = 'I62') * infparf_aa_dist_09 +
    (integer)(infparf_aa_code_10 = 'I62') * infparf_aa_dist_10 +
    (integer)(infparf_aa_code_11 = 'I62') * infparf_aa_dist_11 +
    (integer)(infparf_aa_code_12 = 'I62') * infparf_aa_dist_12 +
    (integer)(infparf_aa_code_13 = 'I62') * infparf_aa_dist_13 +
    (integer)(infparf_aa_code_14 = 'I62') * infparf_aa_dist_14 +
    (integer)(infparf_aa_code_15 = 'I62') * infparf_aa_dist_15 +
    (integer)(infparf_aa_code_16 = 'I62') * infparf_aa_dist_16 +
    (integer)(infparf_aa_code_17 = 'I62') * infparf_aa_dist_17 +
    (integer)(infparf_aa_code_18 = 'I62') * infparf_aa_dist_18;

infparf_rcvaluea41 := (integer)(infparf_aa_code_01 = 'A41') * infparf_aa_dist_01 +
    (integer)(infparf_aa_code_02 = 'A41') * infparf_aa_dist_02 +
    (integer)(infparf_aa_code_03 = 'A41') * infparf_aa_dist_03 +
    (integer)(infparf_aa_code_04 = 'A41') * infparf_aa_dist_04 +
    (integer)(infparf_aa_code_05 = 'A41') * infparf_aa_dist_05 +
    (integer)(infparf_aa_code_06 = 'A41') * infparf_aa_dist_06 +
    (integer)(infparf_aa_code_07 = 'A41') * infparf_aa_dist_07 +
    (integer)(infparf_aa_code_08 = 'A41') * infparf_aa_dist_08 +
    (integer)(infparf_aa_code_09 = 'A41') * infparf_aa_dist_09 +
    (integer)(infparf_aa_code_10 = 'A41') * infparf_aa_dist_10 +
    (integer)(infparf_aa_code_11 = 'A41') * infparf_aa_dist_11 +
    (integer)(infparf_aa_code_12 = 'A41') * infparf_aa_dist_12 +
    (integer)(infparf_aa_code_13 = 'A41') * infparf_aa_dist_13 +
    (integer)(infparf_aa_code_14 = 'A41') * infparf_aa_dist_14 +
    (integer)(infparf_aa_code_15 = 'A41') * infparf_aa_dist_15 +
    (integer)(infparf_aa_code_16 = 'A41') * infparf_aa_dist_16 +
    (integer)(infparf_aa_code_17 = 'A41') * infparf_aa_dist_17 +
    (integer)(infparf_aa_code_18 = 'A41') * infparf_aa_dist_18;

infparf_rcvaluee55 := (integer)(infparf_aa_code_01 = 'E55') * infparf_aa_dist_01 +
    (integer)(infparf_aa_code_02 = 'E55') * infparf_aa_dist_02 +
    (integer)(infparf_aa_code_03 = 'E55') * infparf_aa_dist_03 +
    (integer)(infparf_aa_code_04 = 'E55') * infparf_aa_dist_04 +
    (integer)(infparf_aa_code_05 = 'E55') * infparf_aa_dist_05 +
    (integer)(infparf_aa_code_06 = 'E55') * infparf_aa_dist_06 +
    (integer)(infparf_aa_code_07 = 'E55') * infparf_aa_dist_07 +
    (integer)(infparf_aa_code_08 = 'E55') * infparf_aa_dist_08 +
    (integer)(infparf_aa_code_09 = 'E55') * infparf_aa_dist_09 +
    (integer)(infparf_aa_code_10 = 'E55') * infparf_aa_dist_10 +
    (integer)(infparf_aa_code_11 = 'E55') * infparf_aa_dist_11 +
    (integer)(infparf_aa_code_12 = 'E55') * infparf_aa_dist_12 +
    (integer)(infparf_aa_code_13 = 'E55') * infparf_aa_dist_13 +
    (integer)(infparf_aa_code_14 = 'E55') * infparf_aa_dist_14 +
    (integer)(infparf_aa_code_15 = 'E55') * infparf_aa_dist_15 +
    (integer)(infparf_aa_code_16 = 'E55') * infparf_aa_dist_16 +
    (integer)(infparf_aa_code_17 = 'E55') * infparf_aa_dist_17 +
    (integer)(infparf_aa_code_18 = 'E55') * infparf_aa_dist_18;

infparf_rcvaluea42 := (integer)(infparf_aa_code_01 = 'A42') * infparf_aa_dist_01 +
    (integer)(infparf_aa_code_02 = 'A42') * infparf_aa_dist_02 +
    (integer)(infparf_aa_code_03 = 'A42') * infparf_aa_dist_03 +
    (integer)(infparf_aa_code_04 = 'A42') * infparf_aa_dist_04 +
    (integer)(infparf_aa_code_05 = 'A42') * infparf_aa_dist_05 +
    (integer)(infparf_aa_code_06 = 'A42') * infparf_aa_dist_06 +
    (integer)(infparf_aa_code_07 = 'A42') * infparf_aa_dist_07 +
    (integer)(infparf_aa_code_08 = 'A42') * infparf_aa_dist_08 +
    (integer)(infparf_aa_code_09 = 'A42') * infparf_aa_dist_09 +
    (integer)(infparf_aa_code_10 = 'A42') * infparf_aa_dist_10 +
    (integer)(infparf_aa_code_11 = 'A42') * infparf_aa_dist_11 +
    (integer)(infparf_aa_code_12 = 'A42') * infparf_aa_dist_12 +
    (integer)(infparf_aa_code_13 = 'A42') * infparf_aa_dist_13 +
    (integer)(infparf_aa_code_14 = 'A42') * infparf_aa_dist_14 +
    (integer)(infparf_aa_code_15 = 'A42') * infparf_aa_dist_15 +
    (integer)(infparf_aa_code_16 = 'A42') * infparf_aa_dist_16 +
    (integer)(infparf_aa_code_17 = 'A42') * infparf_aa_dist_17 +
    (integer)(infparf_aa_code_18 = 'A42') * infparf_aa_dist_18;

infparf_rcvaluee57 := (integer)(infparf_aa_code_01 = 'E57') * infparf_aa_dist_01 +
    (integer)(infparf_aa_code_02 = 'E57') * infparf_aa_dist_02 +
    (integer)(infparf_aa_code_03 = 'E57') * infparf_aa_dist_03 +
    (integer)(infparf_aa_code_04 = 'E57') * infparf_aa_dist_04 +
    (integer)(infparf_aa_code_05 = 'E57') * infparf_aa_dist_05 +
    (integer)(infparf_aa_code_06 = 'E57') * infparf_aa_dist_06 +
    (integer)(infparf_aa_code_07 = 'E57') * infparf_aa_dist_07 +
    (integer)(infparf_aa_code_08 = 'E57') * infparf_aa_dist_08 +
    (integer)(infparf_aa_code_09 = 'E57') * infparf_aa_dist_09 +
    (integer)(infparf_aa_code_10 = 'E57') * infparf_aa_dist_10 +
    (integer)(infparf_aa_code_11 = 'E57') * infparf_aa_dist_11 +
    (integer)(infparf_aa_code_12 = 'E57') * infparf_aa_dist_12 +
    (integer)(infparf_aa_code_13 = 'E57') * infparf_aa_dist_13 +
    (integer)(infparf_aa_code_14 = 'E57') * infparf_aa_dist_14 +
    (integer)(infparf_aa_code_15 = 'E57') * infparf_aa_dist_15 +
    (integer)(infparf_aa_code_16 = 'E57') * infparf_aa_dist_16 +
    (integer)(infparf_aa_code_17 = 'E57') * infparf_aa_dist_17 +
    (integer)(infparf_aa_code_18 = 'E57') * infparf_aa_dist_18;

infparf_rcvaluec10 := (integer)(infparf_aa_code_01 = 'C10') * infparf_aa_dist_01 +
    (integer)(infparf_aa_code_02 = 'C10') * infparf_aa_dist_02 +
    (integer)(infparf_aa_code_03 = 'C10') * infparf_aa_dist_03 +
    (integer)(infparf_aa_code_04 = 'C10') * infparf_aa_dist_04 +
    (integer)(infparf_aa_code_05 = 'C10') * infparf_aa_dist_05 +
    (integer)(infparf_aa_code_06 = 'C10') * infparf_aa_dist_06 +
    (integer)(infparf_aa_code_07 = 'C10') * infparf_aa_dist_07 +
    (integer)(infparf_aa_code_08 = 'C10') * infparf_aa_dist_08 +
    (integer)(infparf_aa_code_09 = 'C10') * infparf_aa_dist_09 +
    (integer)(infparf_aa_code_10 = 'C10') * infparf_aa_dist_10 +
    (integer)(infparf_aa_code_11 = 'C10') * infparf_aa_dist_11 +
    (integer)(infparf_aa_code_12 = 'C10') * infparf_aa_dist_12 +
    (integer)(infparf_aa_code_13 = 'C10') * infparf_aa_dist_13 +
    (integer)(infparf_aa_code_14 = 'C10') * infparf_aa_dist_14 +
    (integer)(infparf_aa_code_15 = 'C10') * infparf_aa_dist_15 +
    (integer)(infparf_aa_code_16 = 'C10') * infparf_aa_dist_16 +
    (integer)(infparf_aa_code_17 = 'C10') * infparf_aa_dist_17 +
    (integer)(infparf_aa_code_18 = 'C10') * infparf_aa_dist_18;

infparf_lgt := -0.359909585009968 +
    infparf_v01_w +
    infparf_v02_w +
    infparf_v03_w +
    infparf_v04_w +
    infparf_v05_w +
    infparf_v06_w +
    infparf_v07_w +
    infparf_v08_w +
    infparf_v09_w +
    infparf_v10_w +
    infparf_v11_w +
    infparf_v12_w +
    infparf_v13_w +
    infparf_v14_w +
    infparf_v15_w +
    infparf_v16_w +
    infparf_v17_w +
    infparf_v18_w;


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};

 
//*************************************************************************************//
rc_dataset_r := DATASET([
    {'L79', infparf_rcvalueL79},
    {'F03', infparf_rcvalueF03},
    {'D34', infparf_rcvalueD34},
    {'D32', infparf_rcvalueD32},
    {'D33', infparf_rcvalueD33},
    {'D31', infparf_rcvalueD31},
    {'A46', infparf_rcvalueA46},
    {'I60', infparf_rcvalueI60},
    {'F00', infparf_rcvalueF00},
    {'I62', infparf_rcvalueI62},
    {'A41', infparf_rcvalueA41},
    {'E55', infparf_rcvalueE55},
    {'A42', infparf_rcvalueA42},
    {'E57', infparf_rcvalueE57},
    {'C10', infparf_rcvalueC10}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_r_sorted := sort(rc_dataset_r, rc_dataset_r.value);

r_rc1 := rc_dataset_r_sorted[1].rc;
r_rc2 := rc_dataset_r_sorted[2].rc;
r_rc3 := rc_dataset_r_sorted[3].rc;
r_rc4 := rc_dataset_r_sorted[4].rc;
r_rc5 := rc_dataset_r_sorted[5].rc;
r_rc6 := rc_dataset_r_sorted[6].rc;
r_rc7 := rc_dataset_r_sorted[7].rc;
r_rc8 := rc_dataset_r_sorted[8].rc;
r_rc9 := rc_dataset_r_sorted[9].rc;
r_rc10 := rc_dataset_r_sorted[10].rc;
r_rc11 := rc_dataset_r_sorted[11].rc;
r_rc12 := rc_dataset_r_sorted[12].rc;
r_rc13 := rc_dataset_r_sorted[13].rc;
r_rc14 := rc_dataset_r_sorted[14].rc;
r_rc15 := rc_dataset_r_sorted[15].rc;
r_rc16 := rc_dataset_r_sorted[16].rc;
r_rc17 := rc_dataset_r_sorted[17].rc;
r_rc18 := rc_dataset_r_sorted[18].rc;

r_vl1 := rc_dataset_r_sorted[1].value;
r_vl2 := rc_dataset_r_sorted[2].value;
r_vl3 := rc_dataset_r_sorted[3].value;
r_vl4 := rc_dataset_r_sorted[4].value;
r_vl5 := rc_dataset_r_sorted[5].value;
r_vl6 := rc_dataset_r_sorted[6].value;
r_vl7 := rc_dataset_r_sorted[7].value;
r_vl8 := rc_dataset_r_sorted[8].value;
r_vl9 := rc_dataset_r_sorted[9].value;
r_vl10 := rc_dataset_r_sorted[10].value;
r_vl11 := rc_dataset_r_sorted[11].value;
r_vl12 := rc_dataset_r_sorted[12].value;
r_vl13 := rc_dataset_r_sorted[13].value;
r_vl14 := rc_dataset_r_sorted[14].value;
r_vl15 := rc_dataset_r_sorted[15].value;
r_vl16 := rc_dataset_r_sorted[16].value;
r_vl17 := rc_dataset_r_sorted[17].value;
r_vl18 := rc_dataset_r_sorted[18].value;
//*************************************************************************************//

iv_rv5_deceased := (integer)rc_decsflag = 1 or (integer)rc_ssndod != 0 or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0 or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',') > 0;

iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');

rvg1802_1_0 := map(
    (integer)iv_rv5_deceased > 0     => 200,
    (integer)iv_rv5_unscorable = 1 => 222,
                               round(max((real)501, min(900, if(650 - 80 * (infparf_lgt - ln((36619 - 14158) / 14158)) / ln(2) = NULL, -NULL, 650 - 80 * (infparf_lgt - ln((36619 - 14158) / 14158)) / ln(2))))));

_rc_inq := map(
    infparf_rcvaluei60 < 0 => 'I60',
    infparf_rcvaluei62 < 0 => 'I62',
                              '');

rc1_3 := r_rc1;

rc2_2 := r_rc2;

rc3_2 := r_rc3;

rc4_2 := r_rc4;

rc3_c209 := map(
    trim(trim((string)rc1_3, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc3_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,
    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => '',
                                                         '');

rc2_c209 := map(
    trim(trim((string)rc1_3, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,
    trim(trim((string)rc3_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => '',
                                                         '');

rc1_c209 := map(
    trim(trim((string)rc1_3, LEFT), LEFT, RIGHT) = '' => _rc_inq,
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc3_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => '',
                                                         '');

rc4_c209 := map(
    trim(trim((string)rc1_3, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc3_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,
                                                         '');

rc5_c209 := map(
    trim(trim((string)rc1_3, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc3_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => '',
                                                         _rc_inq);

rc5_1 := if(rc5_c209 != '' and not((rc1_3 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc5_c209, '');

rc2_1 := if(rc2_c209 !='' and not((rc1_3 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc2_c209, rc2_2);

rc3_1 := if(rc3_c209 != '' and not((rc1_3 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc3_c209, rc3_2);

rc4_1 := if(rc4_c209 != '' and not((rc1_3 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc4_c209, rc4_2);

rc1_2 := if(rc1_c209 != '' and not((rc1_3 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc1_c209, rc1_3);

rc1_1 := if(rc1_2 = '', 'C12', rc1_2);

rc5 := if((rvg1802_1_0 in [200, 222, 900]), '', rc5_1);

rc2 := if((rvg1802_1_0 in [200, 222, 900]), '', rc2_1);

rc3 := if((rvg1802_1_0 in [200, 222, 900]), '', rc3_1);

rc4 := if((rvg1802_1_0 in [200, 222, 900]), '', rc4_1);

rc1 := if((rvg1802_1_0 in [200, 222, 900]), '', rc1_1);




//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
	
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVG1802_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVG1802_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVG1802_1_0 = 900 => DATASET([{'00'}], HRILayout),
																							 DATASET([], HRILayout)
													);
reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout);
// If we have score overrides use them, else use the normal reason codes
reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
										reasonsOverrides, 
										reasons) (HRI NOT IN ['', '00']);
zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasonsFinalTemp, 5); // Keep up to 5 reason codes

//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(MODEL_DEBUG)
		/* Model Input Variables */
                    self.seq                              := le.seq;
                    self.sysdate                          := sysdate;
                    self.iv_add_apt                       := iv_add_apt;
                    self.rv_d32_criminal_count            := rv_d32_criminal_count;
                    self.rv_a46_curr_avm_autoval          := rv_a46_curr_avm_autoval;
                    self.rv_d33_eviction_count            := rv_d33_eviction_count;
                    self.rv_d31_all_bk                    := rv_d31_all_bk;
                    self.rv_i62_inq_phones_per_adl        := rv_i62_inq_phones_per_adl;
                    self._in_dob                          := _in_dob;
                    self.yr_in_dob                        := yr_in_dob;
                    self.yr_in_dob_int                    := yr_in_dob_int;
                    self.rv_comb_age                      := rv_comb_age;
                    self.rv_i60_inq_other_count12         := rv_i60_inq_other_count12;
                    self.rv_a41_a42_prop_owner_history    := rv_a41_a42_prop_owner_history;
                    self.rv_e55_college_ind               := rv_e55_college_ind;
                    self.rv_e57_prof_license_br_flag      := rv_e57_prof_license_br_flag;
                    self.rv_l79_adls_per_sfd_addr         := rv_l79_adls_per_sfd_addr;
                    self.rv_d34_unrel_lien60_count        := rv_d34_unrel_lien60_count;
                    self.rv_f03_address_match             := rv_f03_address_match;
                    self.rv_i60_inq_comm_count12          := rv_i60_inq_comm_count12;
                    self._header_first_seen               := _header_first_seen;
                    self.rv_c10_m_hdr_fs                  := rv_c10_m_hdr_fs;
                    self.rv_f00_addr_not_ver_w_ssn        := rv_f00_addr_not_ver_w_ssn;
                    self.rv_i60_inq_count12               := rv_i60_inq_count12;
                    self.rv_i62_inq_addrsperadl_count12   := rv_i62_inq_addrsperadl_count12;
                    self.infparf_v01_w                    := infparf_v01_w;
                    self.infparf_aa_code_01               := infparf_aa_code_01;
                    self.infparf_aa_dist_01               := infparf_aa_dist_01;
                    self.infparf_v02_w                    := infparf_v02_w;
                    self.infparf_aa_code_02               := infparf_aa_code_02;
                    self.infparf_aa_dist_02               := infparf_aa_dist_02;
                    self.infparf_v03_w                    := infparf_v03_w;
                    self.infparf_aa_code_03               := infparf_aa_code_03;
                    self.infparf_aa_dist_03               := infparf_aa_dist_03;
                    self.infparf_v04_w                    := infparf_v04_w;
                    self.infparf_aa_code_04               := infparf_aa_code_04;
                    self.infparf_aa_dist_04               := infparf_aa_dist_04;
                    self.infparf_v05_w                    := infparf_v05_w;
                    self.infparf_aa_code_05               := infparf_aa_code_05;
                    self.infparf_aa_dist_05               := infparf_aa_dist_05;
                    self.infparf_v06_w                    := infparf_v06_w;
                    self.infparf_aa_code_06               := infparf_aa_code_06;
                    self.infparf_aa_dist_06               := infparf_aa_dist_06;
                    self.infparf_v07_w                    := infparf_v07_w;
                    self.infparf_aa_code_07               := infparf_aa_code_07;
                    self.infparf_aa_dist_07               := infparf_aa_dist_07;
                    self.infparf_v08_w                    := infparf_v08_w;
                    self.infparf_aa_code_08               := infparf_aa_code_08;
                    self.infparf_aa_dist_08               := infparf_aa_dist_08;
                    self.infparf_v09_w                    := infparf_v09_w;
                    self.infparf_aa_code_09               := infparf_aa_code_09;
                    self.infparf_aa_dist_09               := infparf_aa_dist_09;
                    self.infparf_v10_w                    := infparf_v10_w;
                    self.infparf_aa_code_10               := infparf_aa_code_10;
                    self.infparf_aa_dist_10               := infparf_aa_dist_10;
                    self.infparf_v11_w                    := infparf_v11_w;
                    self.infparf_aa_code_11               := infparf_aa_code_11;
                    self.infparf_aa_dist_11               := infparf_aa_dist_11;
                    self.infparf_v12_w                    := infparf_v12_w;
                    self.infparf_aa_code_12               := infparf_aa_code_12;
                    self.infparf_aa_dist_12               := infparf_aa_dist_12;
                    self.infparf_v13_w                    := infparf_v13_w;
                    self.infparf_aa_code_13               := infparf_aa_code_13;
                    self.infparf_aa_dist_13               := infparf_aa_dist_13;
                    self.infparf_v14_w                    := infparf_v14_w;
                    self.infparf_aa_code_14               := infparf_aa_code_14;
                    self.infparf_aa_dist_14               := infparf_aa_dist_14;
                    self.infparf_v15_w                    := infparf_v15_w;
                    self.infparf_aa_code_15               := infparf_aa_code_15;
                    self.infparf_aa_dist_15               := infparf_aa_dist_15;
                    self.infparf_v16_w                    := infparf_v16_w;
                    self.infparf_aa_code_16               := infparf_aa_code_16;
                    self.infparf_aa_dist_16               := infparf_aa_dist_16;
                    self.infparf_v17_w                    := infparf_v17_w;
                    self.infparf_aa_code_17               := infparf_aa_code_17;
                    self.infparf_aa_dist_17               := infparf_aa_dist_17;
                    self.infparf_v18_w                    := infparf_v18_w;
                    self.infparf_aa_code_18               := infparf_aa_code_18;
                    self.infparf_aa_dist_18               := infparf_aa_dist_18;
                    self.infparf_rcvaluel79               := infparf_rcvaluel79;
                    self.infparf_rcvaluef03               := infparf_rcvaluef03;
                    self.infparf_rcvalued34               := infparf_rcvalued34;
                    self.infparf_rcvalued32               := infparf_rcvalued32;
                    self.infparf_rcvalued33               := infparf_rcvalued33;
                    self.infparf_rcvalued31               := infparf_rcvalued31;
                    self.infparf_rcvaluea46               := infparf_rcvaluea46;
                    self.infparf_rcvaluei60               := infparf_rcvaluei60;
                    self.infparf_rcvaluef00               := infparf_rcvaluef00;
                    self.infparf_rcvaluei62               := infparf_rcvaluei62;
                    self.infparf_rcvaluea41               := infparf_rcvaluea41;
                    self.infparf_rcvaluee55               := infparf_rcvaluee55;
                    self.infparf_rcvaluea42               := infparf_rcvaluea42;
                    self.infparf_rcvaluee57               := infparf_rcvaluee57;
                    self.infparf_rcvaluec10               := infparf_rcvaluec10;
                    self.infparf_lgt                      := infparf_lgt;
                    self.r_rc1                            := r_rc1;
                    self.r_rc2                            := r_rc2;
                    self.r_rc3                            := r_rc3;
                    self.r_rc4                            := r_rc4;
                    self.r_rc5                            := r_rc5;
                    self.r_rc6                            := r_rc6;
                    self.r_rc7                            := r_rc7;
                    self.r_rc8                            := r_rc8;
                    self.r_rc9                            := r_rc9;
                    self.r_rc10                           := r_rc10;
                    self.r_rc11                           := r_rc11;
                    self.r_rc12                           := r_rc12;
                    self.r_rc13                           := r_rc13;
                    self.r_rc14                           := r_rc14;
                    self.r_rc15                           := r_rc15;
                    self.r_rc16                           := r_rc16;
                    self.r_rc17                           := r_rc17;
                    self.r_rc18                           := r_rc18;
                    self.r_vl1                            := r_vl1;
                    self.r_vl2                            := r_vl2;
                    self.r_vl3                            := r_vl3;
                    self.r_vl4                            := r_vl4;
                    self.r_vl5                            := r_vl5;
                    self.r_vl6                            := r_vl6;
                    self.r_vl7                            := r_vl7;
                    self.r_vl8                            := r_vl8;
                    self.r_vl9                            := r_vl9;
                    self.r_vl10                           := r_vl10;
                    self.r_vl11                           := r_vl11;
                    self.r_vl12                           := r_vl12;
                    self.r_vl13                           := r_vl13;
                    self.r_vl14                           := r_vl14;
                    self.r_vl15                           := r_vl15;
                    self.r_vl16                           := r_vl16;
                    self.r_vl17                           := r_vl17;
                    self.r_vl18                           := r_vl18;
                    self.iv_rv5_deceased                  := iv_rv5_deceased;
                    self.iv_rv5_unscorable                := iv_rv5_unscorable;
                    self.rvg1802_1_0                      := rvg1802_1_0;
                    self._rc_inq                          := _rc_inq;
                    self.rc5                              := rc5;
                    self.rc2                              := rc2;
                    self.rc3                              := rc3;
                    self.rc4                              := rc4;
                    self.rc1                              := rc1;

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvg1802_1_0;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));
	

	RETURN(model);
END;



