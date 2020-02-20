IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT, Std,riskview;

EXPORT RVG1809_1_0(GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

MODEL_DEBUG        := FALSE;
  
#if(MODEL_DEBUG)
Layout_Debug := RECORD
INTEGER sysdate;
INTEGER rv_i60_inq_hiriskcred_recency;
INTEGER rv_d31_bk_disposed_hist_count;
INTEGER iv_inq_count01;
INTEGER iv_wealth_index;
INTEGER rv_i60_inq_count12;
INTEGER rv_i60_inq_peradl_count12;
INTEGER rv_d34_attr_unrel_liens_recency;
INTEGER _header_first_seen;
INTEGER rv_c10_m_hdr_fs;
INTEGER rv_c12_num_nonderogs;
BOOLEAN _nap_ver;
BOOLEAN _inf_ver;
INTEGER iv_phn_addr_verified;
INTEGER rv_s66_adlperssn_count;
INTEGER rv_c23_email_domain_free_cnt;
INTEGER rv_i60_inq_other_recency;
INTEGER rv_i60_inq_other_count12;
INTEGER rv_c12_source_profile_index;
INTEGER rv_c14_addrs_5yr;
REAL uta_edit_model_v01_w;
REAL uta_edit_model_aa_dist_01;
STRING uta_edit_model_aa_code_01;
REAL uta_edit_model_v02_w;
REAL uta_edit_model_aa_dist_02;
STRING uta_edit_model_aa_code_02;
REAL uta_edit_model_v03_w;
REAL uta_edit_model_aa_dist_03;
STRING uta_edit_model_aa_code_03;
REAL uta_edit_model_v04_w;
REAL uta_edit_model_aa_dist_04;
STRING uta_edit_model_aa_code_04;
REAL uta_edit_model_v05_w;
REAL uta_edit_model_aa_dist_05;
STRING uta_edit_model_aa_code_05;
REAL uta_edit_model_v06_w;
REAL uta_edit_model_aa_dist_06;
STRING uta_edit_model_aa_code_06;
REAL uta_edit_model_v07_w;
REAL uta_edit_model_aa_dist_07;
STRING uta_edit_model_aa_code_07;
REAL uta_edit_model_v08_w;
REAL uta_edit_model_aa_dist_08;
STRING uta_edit_model_aa_code_08;
REAL uta_edit_model_v09_w;
REAL uta_edit_model_aa_dist_09;
STRING uta_edit_model_aa_code_09;
REAL uta_edit_model_v10_w;
REAL uta_edit_model_aa_dist_10;
STRING uta_edit_model_aa_code_10;
REAL uta_edit_model_v11_w;
REAL uta_edit_model_aa_dist_11;
STRING uta_edit_model_aa_code_11;
REAL uta_edit_model_v12_w;
REAL uta_edit_model_aa_dist_12;
STRING uta_edit_model_aa_code_12;
REAL uta_edit_model_v13_w;
REAL uta_edit_model_aa_dist_13;
STRING uta_edit_model_aa_code_13;
REAL uta_edit_model_v14_w;
REAL uta_edit_model_aa_dist_14;
STRING uta_edit_model_aa_code_14;
REAL uta_edit_model_v15_w;
REAL uta_edit_model_aa_dist_15;
STRING uta_edit_model_aa_code_15;
REAL uta_edit_model_v16_w;
REAL uta_edit_model_aa_dist_16;
STRING uta_edit_model_aa_code_16;
REAL uta_edit_model_rcvaluea46;
REAL uta_edit_model_rcvaluec14;
REAL uta_edit_model_rcvaluec26;
REAL uta_edit_model_rcvaluec12;
REAL uta_edit_model_rcvaluea41;
REAL uta_edit_model_rcvaluea42;
REAL uta_edit_model_rcvaluea47;
REAL uta_edit_model_rcvalued34;
REAL uta_edit_model_rcvalues65;
REAL uta_edit_model_rcvaluei60;
REAL uta_edit_model_rcvalued31;
REAL uta_edit_model_rcvaluec23;
REAL uta_edit_model_rcvalues66;
REAL uta_edit_model_rcvaluea50;
REAL uta_edit_model_rcvaluec10;
REAL uta_edit_model_rcvaluea40;
REAL uta_edit_model_rcvaluea51;
REAL uta_edit_model_lgt;
STRING r_rc1;
STRING r_rc2;
STRING r_rc3;
STRING r_rc4;
STRING r_rc5;
STRING r_rc6;
STRING r_rc7;
STRING r_rc8;
STRING r_rc9;
STRING r_rc10;
STRING r_rc11;
STRING r_rc12;
STRING r_rc13;
STRING r_rc14;
STRING r_rc15;
STRING r_rc16;
REAL r_vl1;
REAL r_vl2;
REAL r_vl3;
REAL r_vl4;
REAL r_vl5;
REAL r_vl6;
REAL r_vl7;
REAL r_vl8;
REAL r_vl9;
REAL r_vl10;
REAL r_vl11;
REAL r_vl12;
REAL r_vl13;
REAL r_vl14;
REAL r_vl15;
REAL r_vl16;
STRING _rc_inq;
BOOLEAN iv_rv5_deceased;
INTEGER iv_rv5_unscorable;
INTEGER base;
INTEGER pts;
REAL odds;
INTEGER rvg1809_1_0;
STRING rc3;
STRING rc5;
STRING rc1;
STRING rc4;
STRING rc2;
Risk_Indicators.Layout_Boca_Shell clam;
			
END;
		
Layout_Debug doModel(clam le) := TRANSFORM
#else
Models.Layout_ModelOut doModel(clam le) := TRANSFORM
#end


	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	truedid                          := le.truedid;
	nap_summary                      := le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_decsflag                      := (INTEGER)le.iid.decsflag;
	hdr_source_profile_index         := le.source_profile_index;
	ver_sources                      := le.header_summary.ver_sources;
	ssnlength                        := (INTEGER)le.input_validation.ssn_length;
	add_curr_pop                     := (INTEGER)le.addrPop2;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	header_first_seen                := le.ssn_verification.header_first_seen;
	adls_per_ssn                     := le.SSN_Verification.adlPerSSN_count;
	inq_count01                      := le.acc_logs.inquiries.count01;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_other_count                  := le.acc_logs.other.counttotal;
	inq_other_count01                := le.acc_logs.other.count01;
	inq_other_count03                := le.acc_logs.other.count03;
	inq_other_count06                := le.acc_logs.other.count06;
	inq_other_count12                := le.acc_logs.other.count12;
	inq_other_count24                := le.acc_logs.other.count24;
	inq_peradl                       := le.acc_logs.inquiryperadl;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	email_domain_free_count          := le.email_summary.email_domain_free_ct;
	attr_num_unrel_liens30           := le.bjl.liens_unreleased_count30;
	attr_num_unrel_liens90           := le.bjl.liens_unreleased_count90;
	attr_num_unrel_liens180          := le.bjl.liens_unreleased_count180;
	attr_num_unrel_liens12           := le.bjl.liens_unreleased_count12;
	attr_num_unrel_liens24           := le.bjl.liens_unreleased_count24;
	attr_num_unrel_liens36           := le.bjl.liens_unreleased_count36;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
	liens_historical_unrel_count     := le.bjl.liens_historical_unreleased_count;
	wealth_index                     := (INTEGER)le.wealth_indicator;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */
NULL := -999999999;


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01'));

rv_i60_inq_hiriskcred_recency := map(
    not(truedid)               => NULL,
    inq_highRiskCredit_count01 > 0 => 1,
    inq_highRiskCredit_count03 > 0 => 3,
    inq_highRiskCredit_count06 > 0 => 6,
    inq_highRiskCredit_count12 > 0=> 12,
    inq_highriskcredit_count24  > 0 => 24,
    inq_highRiskCredit_count  > 0   => 99,
                                  0);

rv_d31_bk_disposed_hist_count := if(not(truedid), NULL, min(if(bk_disposed_historical_count = NULL, -NULL, bk_disposed_historical_count), 999));

iv_inq_count01 := if(not(truedid), NULL, min(if(inq_count01 = NULL, -NULL, inq_count01), 999));

iv_wealth_index := if(not(truedid), NULL, wealth_index);

rv_i60_inq_count12 := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));

rv_i60_inq_peradl_count12 := if(not(truedid), NULL, min(if(Inq_PerADL = NULL, -NULL, Inq_PerADL), 999));

rv_d34_attr_unrel_liens_recency := map(
    not(truedid)                     => NULL,
    attr_num_unrel_liens30  > 0          => 1,
    attr_num_unrel_liens90  > 0         => 3,
    attr_num_unrel_liens180  > 0          => 6,
    attr_num_unrel_liens12  > 0          => 12,
    attr_num_unrel_liens24  > 0          => 24,
    attr_num_unrel_liens36  > 0           => 36,
    attr_num_unrel_liens60  > 0          => 60,
    liens_historical_unrel_count > 0 => 99,
                                        999);

_header_first_seen := common.sas_date((string)(header_first_seen));

rv_c10_m_hdr_fs := map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => -1,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));

rv_c12_num_nonderogs := if(not(truedid), NULL, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 4));

_nap_ver := (nap_summary in [6, 10, 11, 12]);

_inf_ver := (infutor_nap in [6, 10, 11, 12]);

iv_phn_addr_verified := map(
    not(_nap_ver) and not(_inf_ver) => 0,
    not(_nap_ver) and _inf_ver      => 1,
    _nap_ver and not(_inf_ver)      => 2,
                                       3);

rv_s66_adlperssn_count := map(
    not(ssnlength = 9) => NULL,
    adls_per_ssn = 0   => 1,
                          min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999));

rv_c23_email_domain_free_cnt := if(not(truedid), NULL, min(if(email_domain_free_count = NULL, -NULL, email_domain_free_count), 999));

rv_i60_inq_other_recency := map(
    not(truedid)      => NULL,
    (boolean)inq_other_count01 => 1,
    (boolean)inq_other_count03 => 3,
    (boolean)inq_other_count06 => 6,
    (boolean)inq_other_count12 => 12,
    (boolean)inq_other_count24 => 24,
    (boolean)inq_other_count => 99,
                         0);

rv_i60_inq_other_count12 := if(not(truedid), NULL, min(if(inq_other_count12 = NULL, -NULL, inq_other_count12), 999));

rv_c12_source_profile_index := if(not(truedid), NULL, hdr_source_profile_index);

rv_c14_addrs_5yr := map(
    not(truedid)     => NULL,
    add_curr_pop = 0 => -1,
                        min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));

uta_edit_model_v01_w := map(
    rv_i60_inq_hiriskcred_recency = NULL                     => 0,
    (rv_i60_inq_hiriskcred_recency in [0])                 => -0.581384858235898,
    (rv_i60_inq_hiriskcred_recency in [1, 3, 6, 12]) => 0.580626295198755,
                                                                0);

uta_edit_model_aa_code_01_1 := map(
    rv_i60_inq_hiriskcred_recency = NULL                     => '',
    (rv_i60_inq_hiriskcred_recency in [0])                 => '',
    (rv_i60_inq_hiriskcred_recency in [1, 3, 6, 12]) => 'I60',
                                                                'I60');

uta_edit_model_aa_dist_01 := -0.581384858235898 - uta_edit_model_v01_w;

uta_edit_model_aa_code_01 := if(uta_edit_model_aa_dist_01 = 0, '', uta_edit_model_aa_code_01_1);

uta_edit_model_v02_w := map(
    rv_d31_bk_disposed_hist_count = NULL => 0,
    rv_d31_bk_disposed_hist_count = -1   => 0,
    rv_d31_bk_disposed_hist_count <= 0.5 => -0.381859427547051,
                                            0.38207231706781);

uta_edit_model_aa_code_02_1 := map(
    rv_d31_bk_disposed_hist_count = NULL => '',
    rv_d31_bk_disposed_hist_count = -1   => 'C12',
    rv_d31_bk_disposed_hist_count <= 0.5 => '',
                                            'D31');

uta_edit_model_aa_dist_02 := -0.381859427547051 - uta_edit_model_v02_w;

uta_edit_model_aa_code_02 := if(uta_edit_model_aa_dist_02 = 0, '', uta_edit_model_aa_code_02_1);

uta_edit_model_v03_w := map(
    iv_inq_count01 = NULL => 0,
    iv_inq_count01 = -1   => 0,
    iv_inq_count01 <= 0.5 => -0.274115913942596,
    iv_inq_count01 <= 1   => 0.189014722728013,
                             0.418356817081333);

uta_edit_model_aa_code_03_1 := map(
    iv_inq_count01 = NULL => '',
    iv_inq_count01 = -1   => 'C12',
    iv_inq_count01 <= 0.5 => '',
    iv_inq_count01 <= 1   => 'I60',
                             'I60');

uta_edit_model_aa_dist_03 := -0.274115913942596 - uta_edit_model_v03_w;

uta_edit_model_aa_code_03 := if(uta_edit_model_aa_dist_03 = 0, '', uta_edit_model_aa_code_03_1);

uta_edit_model_v04_w := map(
    iv_wealth_index = NULL => 0,
    iv_wealth_index = -1   => 0,
    iv_wealth_index <= 2.5 => 0.232154990053318,
    iv_wealth_index <= 4.5 => 0.063242175212562,
    iv_wealth_index <= 5.5 => -0.127868913386935,
                              -0.229068898649293);

uta_edit_model_aa_code_04_1 := map(
    iv_wealth_index = NULL => '',
    iv_wealth_index = -1   => 'C12',
    iv_wealth_index <= 2.5 => 'A46',
    iv_wealth_index <= 4.5 => 'A46',
    iv_wealth_index <= 5.5 => 'A46',
                              '');

uta_edit_model_aa_dist_04 := -0.229068898649293 - uta_edit_model_v04_w;

uta_edit_model_aa_code_04 := if(uta_edit_model_aa_dist_04 = 0, '', uta_edit_model_aa_code_04_1);

uta_edit_model_v05_w := map(
    rv_i60_inq_count12 = NULL => 0,
    rv_i60_inq_count12 = -1   => 0,
    rv_i60_inq_count12 <= 0.5 => -0.0995699547260309,
    rv_i60_inq_count12 <= 2.5 => -0.0213014586224008,
                                 0.597771267985834);

uta_edit_model_aa_code_05_1 := map(
    rv_i60_inq_count12 = NULL => '',
    rv_i60_inq_count12 = -1   => 'C12',
    rv_i60_inq_count12 <= 0.5 => '',
    rv_i60_inq_count12 <= 2.5 => 'I60',
                                 'I60');

uta_edit_model_aa_dist_05 := -0.0995699547260309 - uta_edit_model_v05_w;

uta_edit_model_aa_code_05 := if(uta_edit_model_aa_dist_05 = 0, '', uta_edit_model_aa_code_05_1);

uta_edit_model_v06_w := map(
    rv_i60_inq_peradl_count12 = NULL => 0,
    rv_i60_inq_peradl_count12 = -1   => 0,
    rv_i60_inq_peradl_count12 <= 1   => -0.204376664597645,
                                        0.20553102890152);

uta_edit_model_aa_code_06_1 := map(
    rv_i60_inq_peradl_count12 = NULL => '',
    rv_i60_inq_peradl_count12 = -1   => 'C12',
    rv_i60_inq_peradl_count12 <= 1   => '',
                                        'I60');

uta_edit_model_aa_dist_06 := -0.204376664597645 - uta_edit_model_v06_w;

uta_edit_model_aa_code_06 := if(uta_edit_model_aa_dist_06 = 0, '', uta_edit_model_aa_code_06_1);

uta_edit_model_v07_w := map(
    rv_d34_attr_unrel_liens_recency = NULL                                             => 0,
    (rv_d34_attr_unrel_liens_recency in [1, 3, 6, 12, 24, 36, 60, 99]) => 0.207272364141127,
    (rv_d34_attr_unrel_liens_recency in [999])                                       => -0.207162987668039,
                                                                                          0);

uta_edit_model_aa_code_07_1 := map(
    rv_d34_attr_unrel_liens_recency = NULL                                             => '',
    (rv_d34_attr_unrel_liens_recency in [1, 3, 6, 12, 24, 36, 60, 99]) => 'D34',
    (rv_d34_attr_unrel_liens_recency in [999])                                       => '',
                                                                                          'D34');

uta_edit_model_aa_dist_07 := -0.207162987668039 - uta_edit_model_v07_w;

uta_edit_model_aa_code_07 := if(uta_edit_model_aa_dist_07 = 0, '', uta_edit_model_aa_code_07_1);

uta_edit_model_v08_w := map(
    rv_c10_m_hdr_fs = NULL   => 0,
    rv_c10_m_hdr_fs = -1     => 0,
    rv_c10_m_hdr_fs <= 294.5 => 0.145562621652616,
                                -0.154015520008438);

uta_edit_model_aa_code_08_1 := map(
    rv_c10_m_hdr_fs = NULL   => '',
    rv_c10_m_hdr_fs = -1     => 'C12',
    rv_c10_m_hdr_fs <= 294.5 => 'C10',
                                '');

uta_edit_model_aa_dist_08 := -0.154015520008438 - uta_edit_model_v08_w;

uta_edit_model_aa_code_08 := if(uta_edit_model_aa_dist_08 = 0, '', uta_edit_model_aa_code_08_1);

uta_edit_model_v09_w := map(
    rv_c12_num_nonderogs = NULL => 0,
    rv_c12_num_nonderogs = -1   => 0,
    rv_c12_num_nonderogs <= 2.5 => 0.164475229996239,
    rv_c12_num_nonderogs <= 3.5 => -0.0538758958432934,
                                   -0.106285781035519);

uta_edit_model_aa_code_09_1 := map(
    rv_c12_num_nonderogs = NULL => '',
    rv_c12_num_nonderogs = -1   => 'C12',
    rv_c12_num_nonderogs <= 2.5 => 'C12',
    rv_c12_num_nonderogs <= 3.5 => 'C12',
                                   '');

uta_edit_model_aa_dist_09 := -0.106285781035519 - uta_edit_model_v09_w;

uta_edit_model_aa_code_09 := if(uta_edit_model_aa_dist_09 = 0, '', uta_edit_model_aa_code_09_1);

uta_edit_model_v10_w := map(
    iv_phn_addr_verified = NULL => 0,
    iv_phn_addr_verified = -1   => 0,
    iv_phn_addr_verified <= 0.5 => 0.117467518773213,
    iv_phn_addr_verified <= 1   => -0.0181280238235684,
                                   -0.215916764556363);

uta_edit_model_aa_code_10_1 := map(
    iv_phn_addr_verified = NULL => '',
    iv_phn_addr_verified = -1   => 'C12',
    iv_phn_addr_verified <= 0.5 => 'C26',
    iv_phn_addr_verified <= 1   => 'C26',
                                   '');

uta_edit_model_aa_dist_10 := -0.215916764556363 - uta_edit_model_v10_w;

uta_edit_model_aa_code_10 := if(uta_edit_model_aa_dist_10 = 0, '', uta_edit_model_aa_code_10_1);

uta_edit_model_v11_w := map(
    rv_s66_adlperssn_count = NULL => 0,
    rv_s66_adlperssn_count = -1   => 0,
    rv_s66_adlperssn_count <= 1.5 => -0.23833092088074,
    rv_s66_adlperssn_count <= 2   => 0.129546083472319,
                                     0.233342774543871);

uta_edit_model_aa_code_11_1 := map(
    rv_s66_adlperssn_count = NULL => 'S65',
    rv_s66_adlperssn_count = -1   => 'C12',
    rv_s66_adlperssn_count <= 1.5 => '',
    rv_s66_adlperssn_count <= 2   => 'S66',
                                     'S66');

uta_edit_model_aa_dist_11 := -0.23833092088074 - uta_edit_model_v11_w;

uta_edit_model_aa_code_11 := if(uta_edit_model_aa_dist_11 = 0, '', uta_edit_model_aa_code_11_1);

uta_edit_model_v12_w := map(
    rv_c23_email_domain_free_cnt = NULL => 0,
    rv_c23_email_domain_free_cnt = -1   => 0,
    rv_c23_email_domain_free_cnt <= 0.5 => -0.11017908740068,
    rv_c23_email_domain_free_cnt <= 1.5 => 0.0359315720833493,
                                           0.223887694569461);

uta_edit_model_aa_code_12_1 := map(
    rv_c23_email_domain_free_cnt = NULL => '',
    rv_c23_email_domain_free_cnt = -1   => 'C12',
    rv_c23_email_domain_free_cnt <= 0.5 => '',
    rv_c23_email_domain_free_cnt <= 1.5 => 'C23',
                                           'C23');

uta_edit_model_aa_dist_12 := -0.11017908740068 - uta_edit_model_v12_w;

uta_edit_model_aa_code_12 := if(uta_edit_model_aa_dist_12 = 0, '', uta_edit_model_aa_code_12_1);

uta_edit_model_v13_w := map(
    rv_i60_inq_other_recency = NULL                     => 0,
    (rv_i60_inq_other_recency in [0])                 => -0.142865025622686,
    (rv_i60_inq_other_recency in [1, 3, 6, 12]) => 0.140166995717631,
                                                           0);

uta_edit_model_aa_code_13_1 := map(
    rv_i60_inq_other_recency = NULL                     => '',
    (rv_i60_inq_other_recency in [0])                 => '',
    (rv_i60_inq_other_recency in [1, 3, 6, 12]) => 'I60',
                                                           'I60');

uta_edit_model_aa_dist_13 := -0.142865025622686 - uta_edit_model_v13_w;

uta_edit_model_aa_code_13 := if(uta_edit_model_aa_dist_13 = 0, '', uta_edit_model_aa_code_13_1);

uta_edit_model_v14_w := map(
    rv_i60_inq_other_count12 = NULL => 0,
    rv_i60_inq_other_count12 = -1   => 0,
    rv_i60_inq_other_count12 <= 0.5 => -0.138074141648044,
                                       0.139446652873638);

uta_edit_model_aa_code_14_1 := map(
    rv_i60_inq_other_count12 = NULL => '',
    rv_i60_inq_other_count12 = -1   => 'C12',
    rv_i60_inq_other_count12 <= 0.5 => '',
                                       'I60');

uta_edit_model_aa_dist_14 := -0.138074141648044 - uta_edit_model_v14_w;

uta_edit_model_aa_code_14 := if(uta_edit_model_aa_dist_14 = 0, '', uta_edit_model_aa_code_14_1);

uta_edit_model_v15_w := map(
    rv_c12_source_profile_index = NULL => 0,
    rv_c12_source_profile_index = -1   => 0,
    rv_c12_source_profile_index <= 0   => 0.267814690711777,
    rv_c12_source_profile_index <= 8.5 => 0.0482108695941446,
                                          -0.0800093583504166);

uta_edit_model_aa_code_15_1 := map(
    rv_c12_source_profile_index = NULL => '',
    rv_c12_source_profile_index = -1   => 'C12',
    rv_c12_source_profile_index <= 0   => 'C12',
    rv_c12_source_profile_index <= 8.5 => 'C12',
                                          '');

uta_edit_model_aa_dist_15 := -0.0800093583504166 - uta_edit_model_v15_w;

uta_edit_model_aa_code_15 := if(uta_edit_model_aa_dist_15 = 0, '', uta_edit_model_aa_code_15_1);

uta_edit_model_v16_w := map(
    rv_c14_addrs_5yr = NULL => 0,
    rv_c14_addrs_5yr = -1   => 0,
    rv_c14_addrs_5yr <= 0.5 => -0.0423486640433199,
    rv_c14_addrs_5yr <= 1.5 => -0.0376620799864899,
                               0.132602526598729);

uta_edit_model_aa_code_16_1 := map(
    rv_c14_addrs_5yr = NULL => '',
    rv_c14_addrs_5yr = -1   => 'C12',
    rv_c14_addrs_5yr <= 0.5 => '',
    rv_c14_addrs_5yr <= 1.5 => 'C14',
                               'C14');

uta_edit_model_aa_dist_16 := -0.0423486640433199 - uta_edit_model_v16_w;

uta_edit_model_aa_code_16 := if(uta_edit_model_aa_dist_16 = 0, '', uta_edit_model_aa_code_16_1);

uta_edit_model_rcvaluea46 := (integer)(uta_edit_model_aa_code_01 = 'A46') * uta_edit_model_aa_dist_01 +
    (integer)(uta_edit_model_aa_code_02 = 'A46') * uta_edit_model_aa_dist_02 +
    (integer)(uta_edit_model_aa_code_03 = 'A46') * uta_edit_model_aa_dist_03 +
    (integer)(uta_edit_model_aa_code_04 = 'A46') * uta_edit_model_aa_dist_04 +
    (integer)(uta_edit_model_aa_code_05 = 'A46') * uta_edit_model_aa_dist_05 +
    (integer)(uta_edit_model_aa_code_06 = 'A46') * uta_edit_model_aa_dist_06 +
    (integer)(uta_edit_model_aa_code_07 = 'A46') * uta_edit_model_aa_dist_07 +
    (integer)(uta_edit_model_aa_code_08 = 'A46') * uta_edit_model_aa_dist_08 +
    (integer)(uta_edit_model_aa_code_09 = 'A46') * uta_edit_model_aa_dist_09 +
    (integer)(uta_edit_model_aa_code_10 = 'A46') * uta_edit_model_aa_dist_10 +
    (integer)(uta_edit_model_aa_code_11 = 'A46') * uta_edit_model_aa_dist_11 +
    (integer)(uta_edit_model_aa_code_12 = 'A46') * uta_edit_model_aa_dist_12 +
    (integer)(uta_edit_model_aa_code_13 = 'A46') * uta_edit_model_aa_dist_13 +
    (integer)(uta_edit_model_aa_code_14 = 'A46') * uta_edit_model_aa_dist_14 +
    (integer)(uta_edit_model_aa_code_15 = 'A46') * uta_edit_model_aa_dist_15 +
    (integer)(uta_edit_model_aa_code_16 = 'A46') * uta_edit_model_aa_dist_16;

uta_edit_model_rcvaluec14 := (integer)(uta_edit_model_aa_code_01 = 'C14') * uta_edit_model_aa_dist_01 +
    (integer)(uta_edit_model_aa_code_02 = 'C14') * uta_edit_model_aa_dist_02 +
    (integer)(uta_edit_model_aa_code_03 = 'C14') * uta_edit_model_aa_dist_03 +
    (integer)(uta_edit_model_aa_code_04 = 'C14') * uta_edit_model_aa_dist_04 +
    (integer)(uta_edit_model_aa_code_05 = 'C14') * uta_edit_model_aa_dist_05 +
    (integer)(uta_edit_model_aa_code_06 = 'C14') * uta_edit_model_aa_dist_06 +
    (integer)(uta_edit_model_aa_code_07 = 'C14') * uta_edit_model_aa_dist_07 +
    (integer)(uta_edit_model_aa_code_08 = 'C14') * uta_edit_model_aa_dist_08 +
    (integer)(uta_edit_model_aa_code_09 = 'C14') * uta_edit_model_aa_dist_09 +
    (integer)(uta_edit_model_aa_code_10 = 'C14') * uta_edit_model_aa_dist_10 +
    (integer)(uta_edit_model_aa_code_11 = 'C14') * uta_edit_model_aa_dist_11 +
    (integer)(uta_edit_model_aa_code_12 = 'C14') * uta_edit_model_aa_dist_12 +
    (integer)(uta_edit_model_aa_code_13 = 'C14') * uta_edit_model_aa_dist_13 +
    (integer)(uta_edit_model_aa_code_14 = 'C14') * uta_edit_model_aa_dist_14 +
    (integer)(uta_edit_model_aa_code_15 = 'C14') * uta_edit_model_aa_dist_15 +
    (integer)(uta_edit_model_aa_code_16 = 'C14') * uta_edit_model_aa_dist_16;

uta_edit_model_rcvaluec26 := (integer)(uta_edit_model_aa_code_01 = 'C26') * uta_edit_model_aa_dist_01 +
    (integer)(uta_edit_model_aa_code_02 = 'C26') * uta_edit_model_aa_dist_02 +
    (integer)(uta_edit_model_aa_code_03 = 'C26') * uta_edit_model_aa_dist_03 +
    (integer)(uta_edit_model_aa_code_04 = 'C26') * uta_edit_model_aa_dist_04 +
    (integer)(uta_edit_model_aa_code_05 = 'C26') * uta_edit_model_aa_dist_05 +
    (integer)(uta_edit_model_aa_code_06 = 'C26') * uta_edit_model_aa_dist_06 +
    (integer)(uta_edit_model_aa_code_07 = 'C26') * uta_edit_model_aa_dist_07 +
    (integer)(uta_edit_model_aa_code_08 = 'C26') * uta_edit_model_aa_dist_08 +
    (integer)(uta_edit_model_aa_code_09 = 'C26') * uta_edit_model_aa_dist_09 +
    (integer)(uta_edit_model_aa_code_10 = 'C26') * uta_edit_model_aa_dist_10 +
    (integer)(uta_edit_model_aa_code_11 = 'C26') * uta_edit_model_aa_dist_11 +
    (integer)(uta_edit_model_aa_code_12 = 'C26') * uta_edit_model_aa_dist_12 +
    (integer)(uta_edit_model_aa_code_13 = 'C26') * uta_edit_model_aa_dist_13 +
    (integer)(uta_edit_model_aa_code_14 = 'C26') * uta_edit_model_aa_dist_14 +
    (integer)(uta_edit_model_aa_code_15 = 'C26') * uta_edit_model_aa_dist_15 +
    (integer)(uta_edit_model_aa_code_16 = 'C26') * uta_edit_model_aa_dist_16;

uta_edit_model_rcvaluec12 := (integer)(uta_edit_model_aa_code_01 = 'C12') * uta_edit_model_aa_dist_01 +
    (integer)(uta_edit_model_aa_code_02 = 'C12') * uta_edit_model_aa_dist_02 +
    (integer)(uta_edit_model_aa_code_03 = 'C12') * uta_edit_model_aa_dist_03 +
    (integer)(uta_edit_model_aa_code_04 = 'C12') * uta_edit_model_aa_dist_04 +
    (integer)(uta_edit_model_aa_code_05 = 'C12') * uta_edit_model_aa_dist_05 +
    (integer)(uta_edit_model_aa_code_06 = 'C12') * uta_edit_model_aa_dist_06 +
    (integer)(uta_edit_model_aa_code_07 = 'C12') * uta_edit_model_aa_dist_07 +
    (integer)(uta_edit_model_aa_code_08 = 'C12') * uta_edit_model_aa_dist_08 +
    (integer)(uta_edit_model_aa_code_09 = 'C12') * uta_edit_model_aa_dist_09 +
    (integer)(uta_edit_model_aa_code_10 = 'C12') * uta_edit_model_aa_dist_10 +
    (integer)(uta_edit_model_aa_code_11 = 'C12') * uta_edit_model_aa_dist_11 +
    (integer)(uta_edit_model_aa_code_12 = 'C12') * uta_edit_model_aa_dist_12 +
    (integer)(uta_edit_model_aa_code_13 = 'C12') * uta_edit_model_aa_dist_13 +
    (integer)(uta_edit_model_aa_code_14 = 'C12') * uta_edit_model_aa_dist_14 +
    (integer)(uta_edit_model_aa_code_15 = 'C12') * uta_edit_model_aa_dist_15 +
    (integer)(uta_edit_model_aa_code_16 = 'C12') * uta_edit_model_aa_dist_16;

uta_edit_model_rcvaluea41 := (integer)(uta_edit_model_aa_code_01 = 'A41') * uta_edit_model_aa_dist_01 +
    (integer)(uta_edit_model_aa_code_02 = 'A41') * uta_edit_model_aa_dist_02 +
    (integer)(uta_edit_model_aa_code_03 = 'A41') * uta_edit_model_aa_dist_03 +
    (integer)(uta_edit_model_aa_code_04 = 'A41') * uta_edit_model_aa_dist_04 +
    (integer)(uta_edit_model_aa_code_05 = 'A41') * uta_edit_model_aa_dist_05 +
    (integer)(uta_edit_model_aa_code_06 = 'A41') * uta_edit_model_aa_dist_06 +
    (integer)(uta_edit_model_aa_code_07 = 'A41') * uta_edit_model_aa_dist_07 +
    (integer)(uta_edit_model_aa_code_08 = 'A41') * uta_edit_model_aa_dist_08 +
    (integer)(uta_edit_model_aa_code_09 = 'A41') * uta_edit_model_aa_dist_09 +
    (integer)(uta_edit_model_aa_code_10 = 'A41') * uta_edit_model_aa_dist_10 +
    (integer)(uta_edit_model_aa_code_11 = 'A41') * uta_edit_model_aa_dist_11 +
    (integer)(uta_edit_model_aa_code_12 = 'A41') * uta_edit_model_aa_dist_12 +
    (integer)(uta_edit_model_aa_code_13 = 'A41') * uta_edit_model_aa_dist_13 +
    (integer)(uta_edit_model_aa_code_14 = 'A41') * uta_edit_model_aa_dist_14 +
    (integer)(uta_edit_model_aa_code_15 = 'A41') * uta_edit_model_aa_dist_15 +
    (integer)(uta_edit_model_aa_code_16 = 'A41') * uta_edit_model_aa_dist_16;

uta_edit_model_rcvaluea42 := (integer)(uta_edit_model_aa_code_01 = 'A42') * uta_edit_model_aa_dist_01 +
    (integer)(uta_edit_model_aa_code_02 = 'A42') * uta_edit_model_aa_dist_02 +
    (integer)(uta_edit_model_aa_code_03 = 'A42') * uta_edit_model_aa_dist_03 +
    (integer)(uta_edit_model_aa_code_04 = 'A42') * uta_edit_model_aa_dist_04 +
    (integer)(uta_edit_model_aa_code_05 = 'A42') * uta_edit_model_aa_dist_05 +
    (integer)(uta_edit_model_aa_code_06 = 'A42') * uta_edit_model_aa_dist_06 +
    (integer)(uta_edit_model_aa_code_07 = 'A42') * uta_edit_model_aa_dist_07 +
    (integer)(uta_edit_model_aa_code_08 = 'A42') * uta_edit_model_aa_dist_08 +
    (integer)(uta_edit_model_aa_code_09 = 'A42') * uta_edit_model_aa_dist_09 +
    (integer)(uta_edit_model_aa_code_10 = 'A42') * uta_edit_model_aa_dist_10 +
    (integer)(uta_edit_model_aa_code_11 = 'A42') * uta_edit_model_aa_dist_11 +
    (integer)(uta_edit_model_aa_code_12 = 'A42') * uta_edit_model_aa_dist_12 +
    (integer)(uta_edit_model_aa_code_13 = 'A42') * uta_edit_model_aa_dist_13 +
    (integer)(uta_edit_model_aa_code_14 = 'A42') * uta_edit_model_aa_dist_14 +
    (integer)(uta_edit_model_aa_code_15 = 'A42') * uta_edit_model_aa_dist_15 +
    (integer)(uta_edit_model_aa_code_16 = 'A42') * uta_edit_model_aa_dist_16;

uta_edit_model_rcvaluea47 := (integer)(uta_edit_model_aa_code_01 = 'A47') * uta_edit_model_aa_dist_01 +
    (integer)(uta_edit_model_aa_code_02 = 'A47') * uta_edit_model_aa_dist_02 +
    (integer)(uta_edit_model_aa_code_03 = 'A47') * uta_edit_model_aa_dist_03 +
    (integer)(uta_edit_model_aa_code_04 = 'A47') * uta_edit_model_aa_dist_04 +
    (integer)(uta_edit_model_aa_code_05 = 'A47') * uta_edit_model_aa_dist_05 +
    (integer)(uta_edit_model_aa_code_06 = 'A47') * uta_edit_model_aa_dist_06 +
    (integer)(uta_edit_model_aa_code_07 = 'A47') * uta_edit_model_aa_dist_07 +
    (integer)(uta_edit_model_aa_code_08 = 'A47') * uta_edit_model_aa_dist_08 +
    (integer)(uta_edit_model_aa_code_09 = 'A47') * uta_edit_model_aa_dist_09 +
    (integer)(uta_edit_model_aa_code_10 = 'A47') * uta_edit_model_aa_dist_10 +
    (integer)(uta_edit_model_aa_code_11 = 'A47') * uta_edit_model_aa_dist_11 +
    (integer)(uta_edit_model_aa_code_12 = 'A47') * uta_edit_model_aa_dist_12 +
    (integer)(uta_edit_model_aa_code_13 = 'A47') * uta_edit_model_aa_dist_13 +
    (integer)(uta_edit_model_aa_code_14 = 'A47') * uta_edit_model_aa_dist_14 +
    (integer)(uta_edit_model_aa_code_15 = 'A47') * uta_edit_model_aa_dist_15 +
    (integer)(uta_edit_model_aa_code_16 = 'A47') * uta_edit_model_aa_dist_16;

uta_edit_model_rcvalued34 := (integer)(uta_edit_model_aa_code_01 = 'D34') * uta_edit_model_aa_dist_01 +
    (integer)(uta_edit_model_aa_code_02 = 'D34') * uta_edit_model_aa_dist_02 +
    (integer)(uta_edit_model_aa_code_03 = 'D34') * uta_edit_model_aa_dist_03 +
    (integer)(uta_edit_model_aa_code_04 = 'D34') * uta_edit_model_aa_dist_04 +
    (integer)(uta_edit_model_aa_code_05 = 'D34') * uta_edit_model_aa_dist_05 +
    (integer)(uta_edit_model_aa_code_06 = 'D34') * uta_edit_model_aa_dist_06 +
    (integer)(uta_edit_model_aa_code_07 = 'D34') * uta_edit_model_aa_dist_07 +
    (integer)(uta_edit_model_aa_code_08 = 'D34') * uta_edit_model_aa_dist_08 +
    (integer)(uta_edit_model_aa_code_09 = 'D34') * uta_edit_model_aa_dist_09 +
    (integer)(uta_edit_model_aa_code_10 = 'D34') * uta_edit_model_aa_dist_10 +
    (integer)(uta_edit_model_aa_code_11 = 'D34') * uta_edit_model_aa_dist_11 +
    (integer)(uta_edit_model_aa_code_12 = 'D34') * uta_edit_model_aa_dist_12 +
    (integer)(uta_edit_model_aa_code_13 = 'D34') * uta_edit_model_aa_dist_13 +
    (integer)(uta_edit_model_aa_code_14 = 'D34') * uta_edit_model_aa_dist_14 +
    (integer)(uta_edit_model_aa_code_15 = 'D34') * uta_edit_model_aa_dist_15 +
    (integer)(uta_edit_model_aa_code_16 = 'D34') * uta_edit_model_aa_dist_16;

uta_edit_model_rcvalues65 := (integer)(uta_edit_model_aa_code_01 = 'S65') * uta_edit_model_aa_dist_01 +
    (integer)(uta_edit_model_aa_code_02 = 'S65') * uta_edit_model_aa_dist_02 +
    (integer)(uta_edit_model_aa_code_03 = 'S65') * uta_edit_model_aa_dist_03 +
    (integer)(uta_edit_model_aa_code_04 = 'S65') * uta_edit_model_aa_dist_04 +
    (integer)(uta_edit_model_aa_code_05 = 'S65') * uta_edit_model_aa_dist_05 +
    (integer)(uta_edit_model_aa_code_06 = 'S65') * uta_edit_model_aa_dist_06 +
    (integer)(uta_edit_model_aa_code_07 = 'S65') * uta_edit_model_aa_dist_07 +
    (integer)(uta_edit_model_aa_code_08 = 'S65') * uta_edit_model_aa_dist_08 +
    (integer)(uta_edit_model_aa_code_09 = 'S65') * uta_edit_model_aa_dist_09 +
    (integer)(uta_edit_model_aa_code_10 = 'S65') * uta_edit_model_aa_dist_10 +
    (integer)(uta_edit_model_aa_code_11 = 'S65') * uta_edit_model_aa_dist_11 +
    (integer)(uta_edit_model_aa_code_12 = 'S65') * uta_edit_model_aa_dist_12 +
    (integer)(uta_edit_model_aa_code_13 = 'S65') * uta_edit_model_aa_dist_13 +
    (integer)(uta_edit_model_aa_code_14 = 'S65') * uta_edit_model_aa_dist_14 +
    (integer)(uta_edit_model_aa_code_15 = 'S65') * uta_edit_model_aa_dist_15 +
    (integer)(uta_edit_model_aa_code_16 = 'S65') * uta_edit_model_aa_dist_16;

uta_edit_model_rcvaluei60 := (integer)(uta_edit_model_aa_code_01 = 'I60') * uta_edit_model_aa_dist_01 +
    (integer)(uta_edit_model_aa_code_02 = 'I60') * uta_edit_model_aa_dist_02 +
    (integer)(uta_edit_model_aa_code_03 = 'I60') * uta_edit_model_aa_dist_03 +
    (integer)(uta_edit_model_aa_code_04 = 'I60') * uta_edit_model_aa_dist_04 +
    (integer)(uta_edit_model_aa_code_05 = 'I60') * uta_edit_model_aa_dist_05 +
    (integer)(uta_edit_model_aa_code_06 = 'I60') * uta_edit_model_aa_dist_06 +
    (integer)(uta_edit_model_aa_code_07 = 'I60') * uta_edit_model_aa_dist_07 +
    (integer)(uta_edit_model_aa_code_08 = 'I60') * uta_edit_model_aa_dist_08 +
    (integer)(uta_edit_model_aa_code_09 = 'I60') * uta_edit_model_aa_dist_09 +
    (integer)(uta_edit_model_aa_code_10 = 'I60') * uta_edit_model_aa_dist_10 +
    (integer)(uta_edit_model_aa_code_11 = 'I60') * uta_edit_model_aa_dist_11 +
    (integer)(uta_edit_model_aa_code_12 = 'I60') * uta_edit_model_aa_dist_12 +
    (integer)(uta_edit_model_aa_code_13 = 'I60') * uta_edit_model_aa_dist_13 +
    (integer)(uta_edit_model_aa_code_14 = 'I60') * uta_edit_model_aa_dist_14 +
    (integer)(uta_edit_model_aa_code_15 = 'I60') * uta_edit_model_aa_dist_15 +
    (integer)(uta_edit_model_aa_code_16 = 'I60') * uta_edit_model_aa_dist_16;

uta_edit_model_rcvalued31 := (integer)(uta_edit_model_aa_code_01 = 'D31') * uta_edit_model_aa_dist_01 +
    (integer)(uta_edit_model_aa_code_02 = 'D31') * uta_edit_model_aa_dist_02 +
    (integer)(uta_edit_model_aa_code_03 = 'D31') * uta_edit_model_aa_dist_03 +
    (integer)(uta_edit_model_aa_code_04 = 'D31') * uta_edit_model_aa_dist_04 +
    (integer)(uta_edit_model_aa_code_05 = 'D31') * uta_edit_model_aa_dist_05 +
    (integer)(uta_edit_model_aa_code_06 = 'D31') * uta_edit_model_aa_dist_06 +
    (integer)(uta_edit_model_aa_code_07 = 'D31') * uta_edit_model_aa_dist_07 +
    (integer)(uta_edit_model_aa_code_08 = 'D31') * uta_edit_model_aa_dist_08 +
    (integer)(uta_edit_model_aa_code_09 = 'D31') * uta_edit_model_aa_dist_09 +
    (integer)(uta_edit_model_aa_code_10 = 'D31') * uta_edit_model_aa_dist_10 +
    (integer)(uta_edit_model_aa_code_11 = 'D31') * uta_edit_model_aa_dist_11 +
    (integer)(uta_edit_model_aa_code_12 = 'D31') * uta_edit_model_aa_dist_12 +
    (integer)(uta_edit_model_aa_code_13 = 'D31') * uta_edit_model_aa_dist_13 +
    (integer)(uta_edit_model_aa_code_14 = 'D31') * uta_edit_model_aa_dist_14 +
    (integer)(uta_edit_model_aa_code_15 = 'D31') * uta_edit_model_aa_dist_15 +
    (integer)(uta_edit_model_aa_code_16 = 'D31') * uta_edit_model_aa_dist_16;

uta_edit_model_rcvaluec23 := (integer)(uta_edit_model_aa_code_01 = 'C23') * uta_edit_model_aa_dist_01 +
    (integer)(uta_edit_model_aa_code_02 = 'C23') * uta_edit_model_aa_dist_02 +
    (integer)(uta_edit_model_aa_code_03 = 'C23') * uta_edit_model_aa_dist_03 +
    (integer)(uta_edit_model_aa_code_04 = 'C23') * uta_edit_model_aa_dist_04 +
    (integer)(uta_edit_model_aa_code_05 = 'C23') * uta_edit_model_aa_dist_05 +
    (integer)(uta_edit_model_aa_code_06 = 'C23') * uta_edit_model_aa_dist_06 +
    (integer)(uta_edit_model_aa_code_07 = 'C23') * uta_edit_model_aa_dist_07 +
    (integer)(uta_edit_model_aa_code_08 = 'C23') * uta_edit_model_aa_dist_08 +
    (integer)(uta_edit_model_aa_code_09 = 'C23') * uta_edit_model_aa_dist_09 +
    (integer)(uta_edit_model_aa_code_10 = 'C23') * uta_edit_model_aa_dist_10 +
    (integer)(uta_edit_model_aa_code_11 = 'C23') * uta_edit_model_aa_dist_11 +
    (integer)(uta_edit_model_aa_code_12 = 'C23') * uta_edit_model_aa_dist_12 +
    (integer)(uta_edit_model_aa_code_13 = 'C23') * uta_edit_model_aa_dist_13 +
    (integer)(uta_edit_model_aa_code_14 = 'C23') * uta_edit_model_aa_dist_14 +
    (integer)(uta_edit_model_aa_code_15 = 'C23') * uta_edit_model_aa_dist_15 +
    (integer)(uta_edit_model_aa_code_16 = 'C23') * uta_edit_model_aa_dist_16;

uta_edit_model_rcvalues66 := (integer)(uta_edit_model_aa_code_01 = 'S66') * uta_edit_model_aa_dist_01 +
    (integer)(uta_edit_model_aa_code_02 = 'S66') * uta_edit_model_aa_dist_02 +
    (integer)(uta_edit_model_aa_code_03 = 'S66') * uta_edit_model_aa_dist_03 +
    (integer)(uta_edit_model_aa_code_04 = 'S66') * uta_edit_model_aa_dist_04 +
    (integer)(uta_edit_model_aa_code_05 = 'S66') * uta_edit_model_aa_dist_05 +
    (integer)(uta_edit_model_aa_code_06 = 'S66') * uta_edit_model_aa_dist_06 +
    (integer)(uta_edit_model_aa_code_07 = 'S66') * uta_edit_model_aa_dist_07 +
    (integer)(uta_edit_model_aa_code_08 = 'S66') * uta_edit_model_aa_dist_08 +
    (integer)(uta_edit_model_aa_code_09 = 'S66') * uta_edit_model_aa_dist_09 +
    (integer)(uta_edit_model_aa_code_10 = 'S66') * uta_edit_model_aa_dist_10 +
    (integer)(uta_edit_model_aa_code_11 = 'S66') * uta_edit_model_aa_dist_11 +
    (integer)(uta_edit_model_aa_code_12 = 'S66') * uta_edit_model_aa_dist_12 +
    (integer)(uta_edit_model_aa_code_13 = 'S66') * uta_edit_model_aa_dist_13 +
    (integer)(uta_edit_model_aa_code_14 = 'S66') * uta_edit_model_aa_dist_14 +
    (integer)(uta_edit_model_aa_code_15 = 'S66') * uta_edit_model_aa_dist_15 +
    (integer)(uta_edit_model_aa_code_16 = 'S66') * uta_edit_model_aa_dist_16;

uta_edit_model_rcvaluea50 := (integer)(uta_edit_model_aa_code_01 = 'A50') * uta_edit_model_aa_dist_01 +
    (integer)(uta_edit_model_aa_code_02 = 'A50') * uta_edit_model_aa_dist_02 +
    (integer)(uta_edit_model_aa_code_03 = 'A50') * uta_edit_model_aa_dist_03 +
    (integer)(uta_edit_model_aa_code_04 = 'A50') * uta_edit_model_aa_dist_04 +
    (integer)(uta_edit_model_aa_code_05 = 'A50') * uta_edit_model_aa_dist_05 +
    (integer)(uta_edit_model_aa_code_06 = 'A50') * uta_edit_model_aa_dist_06 +
    (integer)(uta_edit_model_aa_code_07 = 'A50') * uta_edit_model_aa_dist_07 +
    (integer)(uta_edit_model_aa_code_08 = 'A50') * uta_edit_model_aa_dist_08 +
    (integer)(uta_edit_model_aa_code_09 = 'A50') * uta_edit_model_aa_dist_09 +
    (integer)(uta_edit_model_aa_code_10 = 'A50') * uta_edit_model_aa_dist_10 +
    (integer)(uta_edit_model_aa_code_11 = 'A50') * uta_edit_model_aa_dist_11 +
    (integer)(uta_edit_model_aa_code_12 = 'A50') * uta_edit_model_aa_dist_12 +
    (integer)(uta_edit_model_aa_code_13 = 'A50') * uta_edit_model_aa_dist_13 +
    (integer)(uta_edit_model_aa_code_14 = 'A50') * uta_edit_model_aa_dist_14 +
    (integer)(uta_edit_model_aa_code_15 = 'A50') * uta_edit_model_aa_dist_15 +
    (integer)(uta_edit_model_aa_code_16 = 'A50') * uta_edit_model_aa_dist_16;

uta_edit_model_rcvaluec10 := (integer)(uta_edit_model_aa_code_01 = 'C10') * uta_edit_model_aa_dist_01 +
    (integer)(uta_edit_model_aa_code_02 = 'C10') * uta_edit_model_aa_dist_02 +
    (integer)(uta_edit_model_aa_code_03 = 'C10') * uta_edit_model_aa_dist_03 +
    (integer)(uta_edit_model_aa_code_04 = 'C10') * uta_edit_model_aa_dist_04 +
    (integer)(uta_edit_model_aa_code_05 = 'C10') * uta_edit_model_aa_dist_05 +
    (integer)(uta_edit_model_aa_code_06 = 'C10') * uta_edit_model_aa_dist_06 +
    (integer)(uta_edit_model_aa_code_07 = 'C10') * uta_edit_model_aa_dist_07 +
    (integer)(uta_edit_model_aa_code_08 = 'C10') * uta_edit_model_aa_dist_08 +
    (integer)(uta_edit_model_aa_code_09 = 'C10') * uta_edit_model_aa_dist_09 +
    (integer)(uta_edit_model_aa_code_10 = 'C10') * uta_edit_model_aa_dist_10 +
    (integer)(uta_edit_model_aa_code_11 = 'C10') * uta_edit_model_aa_dist_11 +
    (integer)(uta_edit_model_aa_code_12 = 'C10') * uta_edit_model_aa_dist_12 +
    (integer)(uta_edit_model_aa_code_13 = 'C10') * uta_edit_model_aa_dist_13 +
    (integer)(uta_edit_model_aa_code_14 = 'C10') * uta_edit_model_aa_dist_14 +
    (integer)(uta_edit_model_aa_code_15 = 'C10') * uta_edit_model_aa_dist_15 +
    (integer)(uta_edit_model_aa_code_16 = 'C10') * uta_edit_model_aa_dist_16;

uta_edit_model_rcvaluea40 := (integer)(uta_edit_model_aa_code_01 = 'A40') * uta_edit_model_aa_dist_01 +
    (integer)(uta_edit_model_aa_code_02 = 'A40') * uta_edit_model_aa_dist_02 +
    (integer)(uta_edit_model_aa_code_03 = 'A40') * uta_edit_model_aa_dist_03 +
    (integer)(uta_edit_model_aa_code_04 = 'A40') * uta_edit_model_aa_dist_04 +
    (integer)(uta_edit_model_aa_code_05 = 'A40') * uta_edit_model_aa_dist_05 +
    (integer)(uta_edit_model_aa_code_06 = 'A40') * uta_edit_model_aa_dist_06 +
    (integer)(uta_edit_model_aa_code_07 = 'A40') * uta_edit_model_aa_dist_07 +
    (integer)(uta_edit_model_aa_code_08 = 'A40') * uta_edit_model_aa_dist_08 +
    (integer)(uta_edit_model_aa_code_09 = 'A40') * uta_edit_model_aa_dist_09 +
    (integer)(uta_edit_model_aa_code_10 = 'A40') * uta_edit_model_aa_dist_10 +
    (integer)(uta_edit_model_aa_code_11 = 'A40') * uta_edit_model_aa_dist_11 +
    (integer)(uta_edit_model_aa_code_12 = 'A40') * uta_edit_model_aa_dist_12 +
    (integer)(uta_edit_model_aa_code_13 = 'A40') * uta_edit_model_aa_dist_13 +
    (integer)(uta_edit_model_aa_code_14 = 'A40') * uta_edit_model_aa_dist_14 +
    (integer)(uta_edit_model_aa_code_15 = 'A40') * uta_edit_model_aa_dist_15 +
    (integer)(uta_edit_model_aa_code_16 = 'A40') * uta_edit_model_aa_dist_16;

uta_edit_model_rcvaluea51 := (integer)(uta_edit_model_aa_code_01 = 'A51') * uta_edit_model_aa_dist_01 +
    (integer)(uta_edit_model_aa_code_02 = 'A51') * uta_edit_model_aa_dist_02 +
    (integer)(uta_edit_model_aa_code_03 = 'A51') * uta_edit_model_aa_dist_03 +
    (integer)(uta_edit_model_aa_code_04 = 'A51') * uta_edit_model_aa_dist_04 +
    (integer)(uta_edit_model_aa_code_05 = 'A51') * uta_edit_model_aa_dist_05 +
    (integer)(uta_edit_model_aa_code_06 = 'A51') * uta_edit_model_aa_dist_06 +
    (integer)(uta_edit_model_aa_code_07 = 'A51') * uta_edit_model_aa_dist_07 +
    (integer)(uta_edit_model_aa_code_08 = 'A51') * uta_edit_model_aa_dist_08 +
    (integer)(uta_edit_model_aa_code_09 = 'A51') * uta_edit_model_aa_dist_09 +
    (integer)(uta_edit_model_aa_code_10 = 'A51') * uta_edit_model_aa_dist_10 +
    (integer)(uta_edit_model_aa_code_11 = 'A51') * uta_edit_model_aa_dist_11 +
    (integer)(uta_edit_model_aa_code_12 = 'A51') * uta_edit_model_aa_dist_12 +
    (integer)(uta_edit_model_aa_code_13 = 'A51') * uta_edit_model_aa_dist_13 +
    (integer)(uta_edit_model_aa_code_14 = 'A51') * uta_edit_model_aa_dist_14 +
    (integer)(uta_edit_model_aa_code_15 = 'A51') * uta_edit_model_aa_dist_15 +
    (integer)(uta_edit_model_aa_code_16 = 'A51') * uta_edit_model_aa_dist_16;

uta_edit_model_lgt := -2.53452939475986 +
    uta_edit_model_v01_w +
    uta_edit_model_v02_w +
    uta_edit_model_v03_w +
    uta_edit_model_v04_w +
    uta_edit_model_v05_w +
    uta_edit_model_v06_w +
    uta_edit_model_v07_w +
    uta_edit_model_v08_w +
    uta_edit_model_v09_w +
    uta_edit_model_v10_w +
    uta_edit_model_v11_w +
    uta_edit_model_v12_w +
    uta_edit_model_v13_w +
    uta_edit_model_v14_w +
    uta_edit_model_v15_w +
    uta_edit_model_v16_w;


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
 
//*************************************************************************************//
rc_dataset_uta_edit_model := DATASET([
    {'A46', uta_edit_model_rcvalueA46},
    {'C14', uta_edit_model_rcvalueC14},
    {'C26', uta_edit_model_rcvalueC26},
    {'C12', uta_edit_model_rcvalueC12},
    {'A41', uta_edit_model_rcvalueA41},
    {'A42', uta_edit_model_rcvalueA42},
    {'A47', uta_edit_model_rcvalueA47},
    {'D34', uta_edit_model_rcvalueD34},
    {'S65', uta_edit_model_rcvalueS65},
    {'I60', uta_edit_model_rcvalueI60},
    {'D31', uta_edit_model_rcvalueD31},
    {'C23', uta_edit_model_rcvalueC23},
    {'S66', uta_edit_model_rcvalueS66},
    {'A50', uta_edit_model_rcvalueA50},
    {'C10', uta_edit_model_rcvalueC10},
    {'A40', uta_edit_model_rcvalueA40},
    {'A51', uta_edit_model_rcvalueA51}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_uta_edit_model_sorted := sort(rc_dataset_uta_edit_model, rc_dataset_uta_edit_model.value);

r_rc1 := rc_dataset_uta_edit_model_sorted[1].rc;
r_rc2 := rc_dataset_uta_edit_model_sorted[2].rc;
r_rc3 := rc_dataset_uta_edit_model_sorted[3].rc;
r_rc4 := rc_dataset_uta_edit_model_sorted[4].rc;
r_rc5 := rc_dataset_uta_edit_model_sorted[5].rc;
r_rc6 := rc_dataset_uta_edit_model_sorted[6].rc;
r_rc7 := rc_dataset_uta_edit_model_sorted[7].rc;
r_rc8 := rc_dataset_uta_edit_model_sorted[8].rc;
r_rc9 := rc_dataset_uta_edit_model_sorted[9].rc;
r_rc10 := rc_dataset_uta_edit_model_sorted[10].rc;
r_rc11 := rc_dataset_uta_edit_model_sorted[11].rc;
r_rc12 := rc_dataset_uta_edit_model_sorted[12].rc;
r_rc13 := rc_dataset_uta_edit_model_sorted[13].rc;
r_rc14 := rc_dataset_uta_edit_model_sorted[14].rc;
r_rc15 := rc_dataset_uta_edit_model_sorted[15].rc;
r_rc16 := rc_dataset_uta_edit_model_sorted[16].rc;


r_vl1 := rc_dataset_uta_edit_model_sorted[1].value;
r_vl2 := rc_dataset_uta_edit_model_sorted[2].value;
r_vl3 := rc_dataset_uta_edit_model_sorted[3].value;
r_vl4 := rc_dataset_uta_edit_model_sorted[4].value;
r_vl5 := rc_dataset_uta_edit_model_sorted[5].value;
r_vl6 := rc_dataset_uta_edit_model_sorted[6].value;
r_vl7 := rc_dataset_uta_edit_model_sorted[7].value;
r_vl8 := rc_dataset_uta_edit_model_sorted[8].value;
r_vl9 := rc_dataset_uta_edit_model_sorted[9].value;
r_vl10 := rc_dataset_uta_edit_model_sorted[10].value;
r_vl11 := rc_dataset_uta_edit_model_sorted[11].value;
r_vl12 := rc_dataset_uta_edit_model_sorted[12].value;
r_vl13 := rc_dataset_uta_edit_model_sorted[13].value;
r_vl14 := rc_dataset_uta_edit_model_sorted[14].value;
r_vl15 := rc_dataset_uta_edit_model_sorted[15].value;
r_vl16 := rc_dataset_uta_edit_model_sorted[16].value;
//*************************************************************************************//

rc1_2 := r_rc1;

rc2_2 := r_rc2;

rc3_2 := r_rc3;

rc4_2 := r_rc4;

_rc_inq := if(r_rc1 = 'I60' or r_rc2 = 'I60' or r_rc3 = 'I60' or r_rc4 = 'I60' or r_rc5 = 'I60' or r_rc6 = 'I60' or r_rc7 = 'I60' or r_rc8 = 'I60' or r_rc9 = 'I60' or r_rc10 = 'I60' or r_rc11 = 'I60' or r_rc12 = 'I60' or r_rc13 = 'I60' or r_rc14 = 'I60' or r_rc15 = 'I60' or r_rc16 = 'I60', 'I60', '');

rc2_c67 := map(
    trim(rc1_2, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     '');

rc5_c67 := map(
    trim(rc1_2, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     _rc_inq);

rc4_c67 := map(
    trim(rc1_2, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => _rc_inq,
                                     '');

rc3_c67 := map(
    trim(rc1_2, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => _rc_inq,
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     '');

rc1_c67 := map(
    trim(rc1_2, LEFT, RIGHT) = '' => _rc_inq,
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     '');

rc1_1 := if(rc1_c67 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc1_c67, rc1_2);

rc3_1 := if(rc3_c67 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc3_c67, rc3_2);

rc4_1 := if(rc4_c67 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc4_c67, rc4_2);

rc5_1 := if(rc5_c67 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc5_c67, '');

rc2_1 := if(rc2_c67 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc2_c67, rc2_2);

iv_rv5_deceased := rc_decsflag = 1 or rc_ssndod != 0 or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',');

iv_rv5_unscorable := if(truedid, 0, 1);

base := 650;

pts := -40;

odds := 0.0143634546329545;

rvg1809_1_0 := map(
    iv_rv5_deceased   => 200,
    iv_rv5_unscorable = 1 => 222,
                             min(if(max(round(pts * (uta_edit_model_lgt - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (uta_edit_model_lgt - ln(odds)) / ln(2) + base), 501)), 900));

rc4 := if((rvg1809_1_0 in [200, 222, 900]), '', rc4_1);

rc5 := if((rvg1809_1_0 in [200, 222, 900]), '', rc5_1);

rc3 := if((rvg1809_1_0 in [200, 222, 900]), '', rc3_1);

rc1 := if((rvg1809_1_0 in [200, 222, 900]), '', rc1_1);

rc2 := if((rvg1809_1_0 in [200, 222, 900]), '', rc2_1);

//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVG1809_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVG1809_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVG1809_1_0 = 900 => DATASET([{'00'}], HRILayout),
																				 			 DATASET([], HRILayout)
													);
reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout);
// If we have score overrides use them, else use the normal reason codes
reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
										reasonsOverrides, 
										reasons) (HRI <> '');
zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5);                             // Keep up to 5 reason codes

//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(MODEL_DEBUG)
self.sysdate   :=   sysdate									;
self.rv_i60_inq_hiriskcred_recency   :=   rv_i60_inq_hiriskcred_recency;
self.rv_d31_bk_disposed_hist_count   :=   rv_d31_bk_disposed_hist_count;
self.iv_inq_count01   :=   iv_inq_count01;
self.iv_wealth_index   :=   iv_wealth_index;
self.rv_i60_inq_count12   :=   rv_i60_inq_count12;
self.rv_i60_inq_peradl_count12   :=   rv_i60_inq_peradl_count12;
self.rv_d34_attr_unrel_liens_recency   :=   rv_d34_attr_unrel_liens_recency;
self._header_first_seen   :=   _header_first_seen;
self.rv_c10_m_hdr_fs   :=   rv_c10_m_hdr_fs;
self.rv_c12_num_nonderogs   :=   rv_c12_num_nonderogs;
self._nap_ver   :=   _nap_ver;
self._inf_ver   :=   _inf_ver;
self.iv_phn_addr_verified   :=   iv_phn_addr_verified;
self.rv_s66_adlperssn_count   :=   rv_s66_adlperssn_count;
self.rv_c23_email_domain_free_cnt   :=   rv_c23_email_domain_free_cnt;
self.rv_i60_inq_other_recency   :=   rv_i60_inq_other_recency;
self.rv_i60_inq_other_count12   :=   rv_i60_inq_other_count12;
self.rv_c12_source_profile_index   :=   rv_c12_source_profile_index;
self.rv_c14_addrs_5yr   :=   rv_c14_addrs_5yr;
self.uta_edit_model_v01_w   :=   uta_edit_model_v01_w;
self.uta_edit_model_aa_dist_01   :=   uta_edit_model_aa_dist_01;
self.uta_edit_model_aa_code_01   :=   uta_edit_model_aa_code_01;
self.uta_edit_model_v02_w   :=   uta_edit_model_v02_w;
self.uta_edit_model_aa_dist_02   :=   uta_edit_model_aa_dist_02;
self.uta_edit_model_aa_code_02   :=   uta_edit_model_aa_code_02;
self.uta_edit_model_v03_w   :=   uta_edit_model_v03_w;
self.uta_edit_model_aa_dist_03   :=   uta_edit_model_aa_dist_03;
self.uta_edit_model_aa_code_03   :=   uta_edit_model_aa_code_03;
self.uta_edit_model_v04_w   :=   uta_edit_model_v04_w;
self.uta_edit_model_aa_dist_04   :=   uta_edit_model_aa_dist_04;
self.uta_edit_model_aa_code_04   :=   uta_edit_model_aa_code_04;
self.uta_edit_model_v05_w   :=   uta_edit_model_v05_w;
self.uta_edit_model_aa_dist_05   :=   uta_edit_model_aa_dist_05;
self.uta_edit_model_aa_code_05   :=   uta_edit_model_aa_code_05;
self.uta_edit_model_v06_w   :=   uta_edit_model_v06_w;
self.uta_edit_model_aa_dist_06   :=   uta_edit_model_aa_dist_06;
self.uta_edit_model_aa_code_06   :=   uta_edit_model_aa_code_06;
self.uta_edit_model_v07_w   :=   uta_edit_model_v07_w;
self.uta_edit_model_aa_dist_07   :=   uta_edit_model_aa_dist_07;
self.uta_edit_model_aa_code_07   :=   uta_edit_model_aa_code_07;
self.uta_edit_model_v08_w   :=   uta_edit_model_v08_w;
self.uta_edit_model_aa_dist_08   :=   uta_edit_model_aa_dist_08;
self.uta_edit_model_aa_code_08   :=   uta_edit_model_aa_code_08;
self.uta_edit_model_v09_w   :=   uta_edit_model_v09_w;
self.uta_edit_model_aa_dist_09   :=   uta_edit_model_aa_dist_09;
self.uta_edit_model_aa_code_09   :=   uta_edit_model_aa_code_09;
self.uta_edit_model_v10_w   :=   uta_edit_model_v10_w;
self.uta_edit_model_aa_dist_10   :=   uta_edit_model_aa_dist_10;
self.uta_edit_model_aa_code_10   :=   uta_edit_model_aa_code_10;
self.uta_edit_model_v11_w   :=   uta_edit_model_v11_w;
self.uta_edit_model_aa_dist_11   :=   uta_edit_model_aa_dist_11;
self.uta_edit_model_aa_code_11   :=   uta_edit_model_aa_code_11;
self.uta_edit_model_v12_w   :=   uta_edit_model_v12_w;
self.uta_edit_model_aa_dist_12   :=   uta_edit_model_aa_dist_12;
self.uta_edit_model_aa_code_12   :=   uta_edit_model_aa_code_12;
self.uta_edit_model_v13_w   :=   uta_edit_model_v13_w;
self.uta_edit_model_aa_dist_13   :=   uta_edit_model_aa_dist_13;
self.uta_edit_model_aa_code_13   :=   uta_edit_model_aa_code_13;
self.uta_edit_model_v14_w   :=   uta_edit_model_v14_w;
self.uta_edit_model_aa_dist_14   :=   uta_edit_model_aa_dist_14;
self.uta_edit_model_aa_code_14   :=   uta_edit_model_aa_code_14;
self.uta_edit_model_v15_w   :=   uta_edit_model_v15_w;
self.uta_edit_model_aa_dist_15   :=   uta_edit_model_aa_dist_15;
self.uta_edit_model_aa_code_15   :=   uta_edit_model_aa_code_15;
self.uta_edit_model_v16_w   :=   uta_edit_model_v16_w;
self.uta_edit_model_aa_dist_16   :=   uta_edit_model_aa_dist_16;
self.uta_edit_model_aa_code_16   :=   uta_edit_model_aa_code_16;
self.uta_edit_model_rcvaluea46   :=   uta_edit_model_rcvaluea46;
self.uta_edit_model_rcvaluec14   :=   uta_edit_model_rcvaluec14;
self.uta_edit_model_rcvaluec26   :=   uta_edit_model_rcvaluec26;
self.uta_edit_model_rcvaluec12   :=   uta_edit_model_rcvaluec12;
self.uta_edit_model_rcvaluea41   :=   uta_edit_model_rcvaluea41;
self.uta_edit_model_rcvaluea42   :=   uta_edit_model_rcvaluea42;
self.uta_edit_model_rcvaluea47   :=   uta_edit_model_rcvaluea47;
self.uta_edit_model_rcvalued34   :=   uta_edit_model_rcvalued34;
self.uta_edit_model_rcvalues65   :=   uta_edit_model_rcvalues65;
self.uta_edit_model_rcvaluei60   :=   uta_edit_model_rcvaluei60;
self.uta_edit_model_rcvalued31   :=   uta_edit_model_rcvalued31;
self.uta_edit_model_rcvaluec23   :=   uta_edit_model_rcvaluec23;
self.uta_edit_model_rcvalues66   :=   uta_edit_model_rcvalues66;
self.uta_edit_model_rcvaluea50   :=   uta_edit_model_rcvaluea50;
self.uta_edit_model_rcvaluec10   :=   uta_edit_model_rcvaluec10;
self.uta_edit_model_rcvaluea40   :=   uta_edit_model_rcvaluea40;
self.uta_edit_model_rcvaluea51   :=   uta_edit_model_rcvaluea51;
self.uta_edit_model_lgt   :=   uta_edit_model_lgt;
self.r_rc1   :=   r_rc1;
self.r_rc2   :=   r_rc2;
self.r_rc3   :=   r_rc3;
self.r_rc4   :=   r_rc4;
self.r_rc5   :=   r_rc5;
self.r_rc6   :=   r_rc6;
self.r_rc7   :=   r_rc7;
self.r_rc8   :=   r_rc8;
self.r_rc9   :=   r_rc9;
self.r_rc10   :=   r_rc10;
self.r_rc11   :=   r_rc11;
self.r_rc12   :=   r_rc12;
self.r_rc13   :=   r_rc13;
self.r_rc14   :=   r_rc14;
self.r_rc15   :=   r_rc15;
self.r_rc16   :=   r_rc16;
self.r_vl1   :=   IF(r_vl1 = 0, NULL, r_vl1);
self.r_vl2   :=    IF(r_vl2 = 0, NULL, r_vl2);
self.r_vl3   :=    IF(r_vl3 = 0, NULL, r_vl3);
self.r_vl4   :=    IF(r_vl4 = 0, NULL, r_vl4);
self.r_vl5   :=   IF(r_vl5 = 0, NULL, r_vl5);
self.r_vl6   :=    IF(r_vl6 = 0, NULL, r_vl6);
self.r_vl7   :=    IF(r_vl7 = 0, NULL, r_vl7);
self.r_vl8   :=    IF(r_vl8 = 0, NULL, r_vl8);
self.r_vl9   :=    IF(r_vl9 = 0, NULL, r_vl9);
self.r_vl10   :=    IF(r_vl10 = 0, NULL, r_vl10);
self.r_vl11   :=    IF(r_vl11 = 0, NULL, r_vl11);
self.r_vl12   :=    IF(r_vl12 = 0, NULL, r_vl12);
self.r_vl13   :=    IF(r_vl13 = 0, NULL, r_vl13);
self.r_vl14   :=    IF(r_vl14 = 0, NULL, r_vl14);
self.r_vl15   :=    IF(r_vl15 = 0, NULL, r_vl15);
self.r_vl16   :=    IF(r_vl16 = 0, NULL, r_vl16);
self._rc_inq   :=   _rc_inq;
self.iv_rv5_deceased   :=   iv_rv5_deceased;
self.iv_rv5_unscorable   :=   iv_rv5_unscorable;
self.base   :=   base;
self.pts   :=   pts;
self.odds   :=   odds;
self.rvg1809_1_0   :=   rvg1809_1_0;
self.rc3   :=   rc3;
self.rc5   :=   rc5;
self.rc1   :=   rc1;
self.rc4   :=   rc4;
self.rc2   :=   rc2;
SELF.clam := le;
#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)RVG1809_1_0;
		SELF.seq := le.seq;
	#end
	END;

	
	model := PROJECT(clam, doModel(LEFT));
	RETURN(model);
END;
