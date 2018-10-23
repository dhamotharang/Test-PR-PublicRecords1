IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT, Std, riskview;

EXPORT RVG1705_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	MODEL_DEBUG        := FALSE;

	#if(MODEL_DEBUG)
Layout_Debug := RECORD
			
			unsigned4 seq;
			INTEGER sysdate; 

        integer inp_naprop_no_truedid         ;// := inp_naprop_no_truedid;
        string iv_rv5_unscorable              ;// := iv_rv5_unscorable;
        string rv_d31_mostrec_bk              ;// := rv_d31_mostrec_bk;
        string rv_d33_eviction_recency        ;// := rv_d33_eviction_recency;
        integer _header_first_seen            ;// := _header_first_seen;
        integer rv_c10_m_hdr_fs               ;// := rv_c10_m_hdr_fs;
        integer rv_c12_source_profile_index   ;// := rv_c12_source_profile_index;
        integer rv_l80_inp_avm_autoval        ;// := rv_l80_inp_avm_autoval;
        integer rv_c14_addrs_10yr             ;// := rv_c14_addrs_10yr;
        string rv_a41_a42_prop_owner_history  ;// := rv_a41_a42_prop_owner_history;
        integer rv_i60_inq_count12            ;// := rv_i60_inq_count12;
        integer rv_i61_inq_collection_recency ;// := rv_i61_inq_collection_recency;
        integer rv_i60_inq_banking_count12    ;// := rv_i60_inq_banking_count12;
        integer rv_i60_inq_hiriskcred_count12 ;// := rv_i60_inq_hiriskcred_count12;
        integer rv_i60_inq_comm_recency       ;// := rv_i60_inq_comm_recency;
        integer rv_d32_attr_felonies_recency  ;// := rv_d32_attr_felonies_recency;
        integer rv_d34_attr_unrel_liens_recency  ;// := rv_d34_attr_unrel_liens_recency;
        real rv_a49_curr_add_avm_pct_chg_2yr  ;// := rv_a49_curr_add_avm_pct_chg_2yr;
        integer rv_i60_inq_other_recency      ;// := rv_i60_inq_other_recency;
        integer rv_i62_inq_ssns_per_adl       ;// := rv_i62_inq_ssns_per_adl;
        integer rv_i62_inq_phones_per_adl     ;// := rv_i62_inq_phones_per_adl;
        real game_subscore0                   ;// := game_subscore0;
        real game_subscore1                   ;// := game_subscore1;
        real game_subscore2                   ;// := game_subscore2;
        real game_subscore3                   ;// := game_subscore3;
        real game_subscore4                   ;// := game_subscore4;
        real game_subscore5                   ;// := game_subscore5;
        real game_subscore6                   ;// := game_subscore6;
        real game_subscore7                   ;// := game_subscore7;
        real game_subscore8                   ;// := game_subscore8;
        real game_subscore9                   ;// := game_subscore9;
        real game_subscore10                  ;// := game_subscore10;
        real game_subscore11                  ;// := game_subscore11;
        real game_subscore12                  ;// := game_subscore12;
        real game_subscore13                  ;// := game_subscore13;
        real game_subscore14                  ;// := game_subscore14;
        real game_subscore15                  ;// := game_subscore15;
        real game_subscore16                  ;// := game_subscore16;
        real game_subscore17                  ;// := game_subscore17;
        real game_subscore18                  ;// := game_subscore18;
        real game_rawscore                    ;// := game_rawscore;
        real game_lnoddsscore                 ;// := game_lnoddsscore;
        real game_probscore                   ;// := game_probscore;
        integer base                          ;// := base;
        integer pts                           ;// := pts;
        real lgt                              ;// := lgt;
        integer deceased                      ;// := deceased;
        integer rvg1705_1_0                   ;// := rvg1705_1_0;
        string game_aacd_0                    ;// := game_aacd_0;
        real game_dist_0                      ;// := game_dist_0;
        string game_aacd_1                    ;// := game_aacd_1;
        real game_dist_1                      ;// := game_dist_1;
        string game_aacd_2                    ;// := game_aacd_2;
        real game_dist_2                      ;// := game_dist_2;
        string game_aacd_3                    ;// := game_aacd_3;
        real game_dist_3                      ;// := game_dist_3;
        string game_aacd_4                    ;// := game_aacd_4;
        real game_dist_4                      ;// := game_dist_4;
        string game_aacd_5                    ;// := game_aacd_5;
        real game_dist_5                      ;// := game_dist_5;
        string game_aacd_6                    ;// := game_aacd_6;
        real game_dist_6                      ;// := game_dist_6;
        string game_aacd_7                    ;// := game_aacd_7;
        real game_dist_7                      ;// := game_dist_7;
        string game_aacd_8                    ;// := game_aacd_8;
        real game_dist_8                      ;// := game_dist_8;
        string game_aacd_9                    ;// := game_aacd_9;
        real game_dist_9                      ;// := game_dist_9;
        string game_aacd_10                   ;// := game_aacd_10;
        real game_dist_10                     ;// := game_dist_10;
        string game_aacd_11                   ;// := game_aacd_11;
        real game_dist_11                     ;// := game_dist_11;
        string game_aacd_12                   ;// := game_aacd_12;
        real game_dist_12                     ;// := game_dist_12;
        string game_aacd_13                   ;// := game_aacd_13;
        real game_dist_13                     ;// := game_dist_13;
        string game_aacd_14                   ;// := game_aacd_14;
        real game_dist_14                     ;// := game_dist_14;
        string game_aacd_15                   ;// := game_aacd_15;
        real game_dist_15                     ;// := game_dist_15;
        string game_aacd_16                   ;// := game_aacd_16;
        real game_dist_16                     ;// := game_dist_16;
        string game_aacd_17                   ;// := game_aacd_17;
        real game_dist_17                     ;// := game_dist_17;
        string game_aacd_18                   ;// := game_aacd_18;
        real game_dist_18                     ;// := game_dist_18;
        real game_rcvaluec12                  ;// := game_rcvaluec12;
        real game_rcvaluel80                  ;// := game_rcvaluel80;
        real game_rcvalued34                  ;// := game_rcvalued34;
        real game_rcvalued32                  ;// := game_rcvalued32;
        real game_rcvalued33                  ;// := game_rcvalued33;
        real game_rcvalued31                  ;// := game_rcvalued31;
        real game_rcvaluea47                  ;// := game_rcvaluea47;
        real game_rcvaluea45                  ;// := game_rcvaluea45;
        real game_rcvaluea42                  ;// := game_rcvaluea42;
        real game_rcvaluei61                  ;// := game_rcvaluei61;
        real game_rcvaluei62                  ;// := game_rcvaluei62;
        real game_rcvaluea41                  ;// := game_rcvaluea41;
        real game_rcvaluei60                  ;// := game_rcvaluei60;
        real game_rcvaluec10                  ;// := game_rcvaluec10;
        real game_rcvaluea49                  ;// := game_rcvaluea49;
        real game_rcvaluec14                  ;// := game_rcvaluec14;
        string _rc_inq                        ;// := _rc_inq;
        string game_rc1                       ;// := game_rc1;
        string game_rc2                       ;// := game_rc2;
        string game_rc3                       ;// := game_rc3;
        string game_rc4                       ;// := game_rc4;
        real game_vl1                         ;// := game_vl1;
        real game_vl2                         ;// := game_vl2;
        real game_vl3                         ;// := game_vl3;
        real game_vl4                         ;// := game_vl4;
        string rc1                            ;// := rc1;
        string rc2                            ;// := rc2;
        string rc3                            ;// := rc3;
        string rc4                            ;// := rc4;
        string rc5                            ;// := rc5;

			Risk_Indicators.Layout_Boca_Shell clam;
		END;
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Models.Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	seq                              := le.seq;
	truedid                          := le.truedid;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_decsflag                      := le.iid.decsflag;
	hdr_source_profile_index         := le.source_profile_index;
	ver_sources                      := le.header_summary.ver_sources;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_lres                    := le.lres2;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_avm_auto_val_3          := le.avm.address_history_1.avm_automated_valuation3;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	header_first_seen                := le.ssn_verification.header_first_seen;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_banking_count12              := le.acc_logs.banking.count12;
	inq_collection_count             := le.acc_logs.collection.counttotal;
	inq_collection_count01           := le.acc_logs.collection.count01;
	inq_collection_count03           := le.acc_logs.collection.count03;
	inq_collection_count06           := le.acc_logs.collection.count06;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_collection_count24           := le.acc_logs.collection.count24;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_communications_count01       := le.acc_logs.communications.count01;
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_communications_count06       := le.acc_logs.communications.count06;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_communications_count24       := le.acc_logs.communications.count24;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_other_count                  := le.acc_logs.other.counttotal;
	inq_other_count01                := le.acc_logs.other.count01;
	inq_other_count03                := le.acc_logs.other.count03;
	inq_other_count06                := le.acc_logs.other.count06;
	inq_other_count12                := le.acc_logs.other.count12;
	inq_other_count24                := le.acc_logs.other.count24;
	inq_ssnsperadl                   := le.acc_logs.inquiryssnsperadl;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	attr_felonies30                  := le.bjl.criminal_count30;
	attr_felonies90                  := le.bjl.criminal_count90;
	attr_felonies180                 := le.bjl.criminal_count180;
	attr_felonies12                  := le.bjl.criminal_count12;
	attr_felonies24                  := le.bjl.criminal_count24;
	attr_felonies36                  := le.bjl.criminal_count36;
	attr_felonies60                  := le.bjl.criminal_count60;
	attr_num_unrel_liens30           := le.bjl.liens_unreleased_count30;
	attr_num_unrel_liens90           := le.bjl.liens_unreleased_count90;
	attr_num_unrel_liens180          := le.bjl.liens_unreleased_count180;
	attr_num_unrel_liens12           := le.bjl.liens_unreleased_count12;
	attr_num_unrel_liens24           := le.bjl.liens_unreleased_count24;
	attr_num_unrel_liens36           := le.bjl.liens_unreleased_count36;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
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
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	felony_count                     := le.bjl.felony_count;



	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

NULL := -999999999;

INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

sysdate := common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01'));

inp_naprop_no_truedid := if(truedid, -1, add_input_naprop);

iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');

rv_d31_mostrec_bk := map(
    not(truedid)                                                         => '',
    contains_i(StringLib.StringToUpperCase(disposition), 'DISMISS') = 1  => '1 - BK DISMISSED ',
    contains_i(StringLib.StringToUpperCase(disposition), 'DISCHARG') = 1 => '2 - BK DISCHARGED',
    (integer)bankrupt = 1 or filing_count > 0                            => '3 - BK OTHER     ',
                                                                            '0 - NO BK        ');

rv_d33_eviction_recency := map(
    not(truedid)                                                => '  ',
    (boolean)attr_eviction_count90                              => '03',
    (boolean)attr_eviction_count180                             => '06',
    (boolean)attr_eviction_count12                              => '12',
    (boolean)attr_eviction_count24 and attr_eviction_count >= 2 => '24',
    (boolean)attr_eviction_count24                              => '25',
    (boolean)attr_eviction_count36 and attr_eviction_count >= 2 => '36',
    (boolean)attr_eviction_count36                              => '37',
    (boolean)attr_eviction_count60 and attr_eviction_count >= 2 => '60',
    (boolean)attr_eviction_count60                              => '61',
    attr_eviction_count >= 2                                    => '98',
    attr_eviction_count >= 1                                    => '99',
                                                                   '00');

_header_first_seen := common.sas_date((string)(header_first_seen));

rv_c10_m_hdr_fs := map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => -1,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));

rv_c12_source_profile_index := if(not(truedid), NULL, hdr_source_profile_index);

rv_l80_inp_avm_autoval := if(not(add_input_pop), NULL, add_input_avm_auto_val);

rv_c14_addrs_10yr := map(
    not(truedid)              => NULL,
    (integer)add_curr_pop = 0 => -1,
                                 min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));

rv_a41_a42_prop_owner_history := map(
    not(truedid)                                                                     => '',
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 'CURRENT',
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 'HISTORICAL',
                                                                                        'NEVER');

rv_i60_inq_count12 := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));

rv_i61_inq_collection_recency := map(
    not(truedid)                    => NULL,
    (boolean)inq_collection_count01 => 1,
    (boolean)inq_collection_count03 => 3,
    (boolean)inq_collection_count06 => 6,
    (boolean)inq_collection_count12 => 12,
    (boolean)inq_collection_count24 => 24,
    (boolean)inq_collection_count   => 99,
                                       0);

rv_i60_inq_banking_count12 := if(not(truedid), NULL, min(if(inq_banking_count12 = NULL, -NULL, inq_banking_count12), 999));

rv_i60_inq_hiriskcred_count12 := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));

rv_i60_inq_comm_recency := map(
    not(truedid)               => NULL,
    (boolean)inq_communications_count01 => 1,
    (boolean)inq_communications_count03 => 3,
    (boolean)inq_communications_count06 => 6,
    (boolean)inq_communications_count12 => 12,
    (boolean)inq_communications_count24 => 24,
    (boolean)inq_communications_count   => 99,
                                  0);

rv_d32_attr_felonies_recency := map(
    not(truedid)     => NULL,
    (boolean)attr_felonies30  => 1,
    (boolean)attr_felonies90  => 3,
    (boolean)attr_felonies180 => 6,
    (boolean)attr_felonies12  => 12,
    (boolean)attr_felonies24  => 24,
    (boolean)attr_felonies36  => 36,
    (boolean)attr_felonies60  => 60,
    felony_count > 0 => 99,
                        0);

rv_d34_attr_unrel_liens_recency := map(
    not(truedid)                       => NULL,
    (boolean)attr_num_unrel_liens30             => 1,
    (boolean)attr_num_unrel_liens90             => 3,
    (boolean)attr_num_unrel_liens180            => 6,
    (boolean)attr_num_unrel_liens12             => 12,
    (boolean)attr_num_unrel_liens24             => 24,
    (boolean)attr_num_unrel_liens36             => 36,
    (boolean)attr_num_unrel_liens60             => 60,
    liens_historical_unreleased_ct > 0 => 99,
                                          0);

rv_a49_curr_add_avm_pct_chg_2yr := map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12 * 2                                    => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_3 > 0 => add_curr_avm_auto_val / add_curr_avm_auto_val_3,
                                                                 NULL);

rv_i60_inq_other_recency := map(
    not(truedid)      => NULL,
    (boolean)inq_other_count01 => 1,
    (boolean)inq_other_count03 => 3,
    (boolean)inq_other_count06 => 6,
    (boolean)inq_other_count12 => 12,
    (boolean)inq_other_count24 => 24,
    (boolean)inq_other_count   => 99,
                         0);

rv_i62_inq_ssns_per_adl := if(not(truedid), NULL, min(if(inq_ssnsperadl = NULL, -NULL, inq_ssnsperadl), 999));

rv_i62_inq_phones_per_adl := if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999));

game_subscore0 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 0.227967,
    1 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 2   => -0.890384,
    2 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 3   => -0.902191,
    3 <= rv_i60_inq_hiriskcred_count12                                         => -1.1028,
                                                                                  0);

game_subscore1 := map(
    (rv_a41_a42_prop_owner_history in [' '])          => 0,
    (rv_a41_a42_prop_owner_history in ['CURRENT'])    => 0.308649,
    (rv_a41_a42_prop_owner_history in ['HISTORICAL']) => -0.019365,
    (rv_a41_a42_prop_owner_history in ['NEVER'])      => -0.537137,
                                                         0);

game_subscore2 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 1 => 0.254166,
    1 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2   => 0.185981,
    2 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 3   => -0.319872,
    3 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 4   => -0.457346,
    4 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 6   => -0.521758,
    6 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 8   => -0.63466,
    8 <= rv_c14_addrs_10yr                             => -0.637227,
                                                          0);

game_subscore3 := map(
    (rv_d31_mostrec_bk in [' '])                 => 0,
    (rv_d31_mostrec_bk in ['0 - NO BK'])         => 0.11234,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])  => -1.398568,
    (rv_d31_mostrec_bk in ['2 - BK DISCHARGED']) => -0.158312,
    (rv_d31_mostrec_bk in ['3 - BK OTHER'])      => -1.347299,
                                                    0);

game_subscore4 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 0   => 0,
    0 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 164   => -0.793857,
    164 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 278 => -0.34695,
    278 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 337 => 0.092067,
    337 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 364 => 0.094345,
    364 <= rv_c10_m_hdr_fs                           => 0.209778,
                                                        0);

game_subscore5 := map(
    (rv_d34_attr_unrel_liens_recency in [0])          => 0.091761,
    (rv_d34_attr_unrel_liens_recency in [1, 3, 6])    => -1.115737,
    (rv_d34_attr_unrel_liens_recency in [12])         => -0.918423,
    (rv_d34_attr_unrel_liens_recency in [24])         => -0.821555,
    (rv_d34_attr_unrel_liens_recency in [36, 60, 99]) => -0.352638,
                                                         0);

game_subscore6 := map(
    NULL < inp_naprop_no_truedid AND inp_naprop_no_truedid < 0 => -0.04087,
    0 <= inp_naprop_no_truedid AND inp_naprop_no_truedid < 4   => -0.216213,
    4 <= inp_naprop_no_truedid                                 => 0.725837,
                                                                  0);

game_subscore7 := map(
    (rv_d33_eviction_recency in ['00'])                               => 0.059454,
    (rv_d33_eviction_recency in ['01', '03', '06', '12'])             => -1.137076,
    (rv_d33_eviction_recency in ['24', '25', '36', '37', '60', '61']) => -0.766359,
    (rv_d33_eviction_recency in ['98', '99'])                         => -0.600133,
                                                                         0);

game_subscore8 := map(
    NULL < rv_c12_source_profile_index AND rv_c12_source_profile_index < 5 => -0.225669,
    5 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 6   => -0.010306,
    6 <= rv_c12_source_profile_index                                       => 0.088062,
                                                                              0);

game_subscore9 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1         => -0.022855,
    1 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 47538       => -0.33715,
    47538 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 76314   => -0.163482,
    76314 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 110003  => -0.132598,
    110003 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 167062 => 0.110267,
    167062 <= rv_l80_inp_avm_autoval                                     => 0.204345,
                                                                            0);

game_subscore10 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 0.042877,
    1 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 2   => 0.037128,
    2 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 3   => -0.301452,
    3 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 4   => -0.369937,
    4 <= rv_i60_inq_count12                              => -0.424723,
                                                            0);

game_subscore11 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 2 => 0.036872,
    2 <= rv_i62_inq_ssns_per_adl                                   => -0.419863,
                                                                      0);

game_subscore12 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 0.051695,
    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => -0.003653,
    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => -0.24257,
    3 <= rv_i62_inq_phones_per_adl                                     => -0.301273,
                                                                          0);

game_subscore13 := map(
    (rv_i60_inq_other_recency in [0])    => 0.027059,
    (rv_i60_inq_other_recency in [1, 3]) => -0.815182,
    (rv_i60_inq_other_recency in [6])    => -0.488906,
    (rv_i60_inq_other_recency in [12])   => -0.234894,
                                            0);

game_subscore14 := map(
    NULL < rv_i60_inq_banking_count12 AND rv_i60_inq_banking_count12 < 1 => 0.02086,
    1 <= rv_i60_inq_banking_count12                                      => -0.581968,
                                                                            0);

game_subscore15 := map(
    (rv_i61_inq_collection_recency in [0])           => 0.013076,
    (rv_i61_inq_collection_recency in [1, 3, 6, 12]) => -0.646426,
                                                        0);

game_subscore16 := map(
    (rv_d32_attr_felonies_recency in [0])                           => 0.008736,
    (rv_d32_attr_felonies_recency in [1, 3, 6, 12, 24, 36, 60, 99]) => -1.115975,
                                                                       0);

game_subscore17 := map(
    NULL < rv_a49_curr_add_avm_pct_chg_2yr AND rv_a49_curr_add_avm_pct_chg_2yr < 0.68  => -0.033061,
    0.68 <= rv_a49_curr_add_avm_pct_chg_2yr AND rv_a49_curr_add_avm_pct_chg_2yr < 1.74 => -0.027107,
    1.74 <= rv_a49_curr_add_avm_pct_chg_2yr                                            => 0.723905,
                                                                                          0);

game_subscore18 := map(
    (rv_i60_inq_comm_recency in [0])       => 0.008449,
    (rv_i60_inq_comm_recency in [1, 3, 6]) => -0.403143,
    (rv_i60_inq_comm_recency in [12])      => -0.217581,
                                              0);

game_rawscore := game_subscore0 +
    game_subscore1 +
    game_subscore2 +
    game_subscore3 +
    game_subscore4 +
    game_subscore5 +
    game_subscore6 +
    game_subscore7 +
    game_subscore8 +
    game_subscore9 +
    game_subscore10 +
    game_subscore11 +
    game_subscore12 +
    game_subscore13 +
    game_subscore14 +
    game_subscore15 +
    game_subscore16 +
    game_subscore17 +
    game_subscore18;

game_lnoddsscore := game_rawscore + 3.277145;

game_probscore := exp(game_lnoddsscore) / (1 + exp(game_lnoddsscore));

base := 750;

pts := 50;

lgt := ln(31.980132);

deceased := map(
    rc_decsflag = '1'                                                        => 1,
    rc_ssndod != 0                                                         => 1,
    contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 => 2,
                                                                              0);

rvg1705_1_0 := map(
    deceased > 0          => 200,
    iv_rv5_unscorable = '1' => 222,
                             min(if(max(round(base + pts * (game_lnoddsscore - lgt) / ln(2)), 501) = NULL, -NULL, max(round(base + pts * (game_lnoddsscore - lgt) / ln(2)), 501)), 900));

game_aacd_0 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => '',
    1 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 2   => 'I60',
    2 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 3   => 'I60',
    3 <= rv_i60_inq_hiriskcred_count12                                         => 'I60',
                                                                                  '');

game_dist_0 := game_subscore0 - 0.227967;

game_aacd_1 := map(
    (rv_a41_a42_prop_owner_history in [' '])          => 'A41',
    (rv_a41_a42_prop_owner_history in ['CURRENT'])    => '',
    (rv_a41_a42_prop_owner_history in ['HISTORICAL']) => 'A42',
    (rv_a41_a42_prop_owner_history in ['NEVER'])      => 'A41',
                                                         '');

game_dist_1 := game_subscore1 - 0.308649;

game_aacd_2 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 1 => '',
    1 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2   => 'C14',
    2 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 3   => 'C14',
    3 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 4   => 'C14',
    4 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 6   => 'C14',
    6 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 8   => 'C14',
    8 <= rv_c14_addrs_10yr                             => 'C14',
                                                          '');

game_dist_2 := game_subscore2 - 0.254166;

game_aacd_3 := map(
    (rv_d31_mostrec_bk in [' '])                 => '',
    (rv_d31_mostrec_bk in ['0 - NO BK'])         => '',
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])  => 'D31',
    (rv_d31_mostrec_bk in ['2 - BK DISCHARGED']) => 'D31',
    (rv_d31_mostrec_bk in ['3 - BK OTHER'])      => 'D31',
                                                    '');

game_dist_3 := game_subscore3 - 0.11234;

game_aacd_4 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 0   => '',
    0 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 164   => 'C10',
    164 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 278 => 'C10',
    278 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 337 => 'C10',
    337 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 364 => 'C10',
    364 <= rv_c10_m_hdr_fs                           => '',
                                                        '');

game_dist_4 := game_subscore4 - 0.209778;

game_aacd_5 := map(
    (rv_d34_attr_unrel_liens_recency in [0])          => '',
    (rv_d34_attr_unrel_liens_recency in [1, 3, 6])    => 'D34',
    (rv_d34_attr_unrel_liens_recency in [12])         => 'D34',
    (rv_d34_attr_unrel_liens_recency in [24])         => 'D34',
    (rv_d34_attr_unrel_liens_recency in [36, 60, 99]) => 'D34',
                                                         '');

game_dist_5 := game_subscore5 - 0.091761;

game_aacd_6 := map(
    NULL < inp_naprop_no_truedid AND inp_naprop_no_truedid < 0 => '',
    0 <= inp_naprop_no_truedid AND inp_naprop_no_truedid < 4   => 'A45',
    4 <= inp_naprop_no_truedid                                 => '',
                                                                  '');

game_dist_6 := game_subscore6 - 0.725837;

game_aacd_7 := map(
    (rv_d33_eviction_recency in ['00'])                               => '',
    (rv_d33_eviction_recency in ['01', '03', '06', '12'])             => 'D33',
    (rv_d33_eviction_recency in ['24', '25', '36', '37', '60', '61']) => 'D33',
    (rv_d33_eviction_recency in ['98', '99'])                         => 'D33',
                                                                         '');

game_dist_7 := game_subscore7 - 0.059454;

game_aacd_8 := map(
    NULL < rv_c12_source_profile_index AND rv_c12_source_profile_index < 5 => 'C12',
    5 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 6   => 'C12',
    6 <= rv_c12_source_profile_index                                       => '',
                                                                              '');

game_dist_8 := game_subscore8 - 0.088062;

game_aacd_9 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1         => 'L80',
    1 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 47538       => 'L80',
    47538 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 76314   => 'L80',
    76314 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 110003  => 'L80',
    110003 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 167062 => 'L80',
    167062 <= rv_l80_inp_avm_autoval                                     => '',
                                                                            '');

game_dist_9 := game_subscore9 - 0.204345;

game_aacd_10 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => '',
    1 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 2   => 'I60',
    2 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 3   => 'I60',
    3 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 4   => 'I60',
    4 <= rv_i60_inq_count12                              => 'I60',
                                                            '');

game_dist_10 := game_subscore10 - 0.042877;

game_aacd_11 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 2 => '',
    2 <= rv_i62_inq_ssns_per_adl                                   => 'I62',
                                                                      '');

game_dist_11 := game_subscore11 - 0.036872;

game_aacd_12 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => '',
    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => 'I62',
    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => 'I62',
    3 <= rv_i62_inq_phones_per_adl                                     => 'I62',
                                                                          '');

game_dist_12 := game_subscore12 - 0.051695;

game_aacd_13 := map(
    (rv_i60_inq_other_recency in [0])    => '',
    (rv_i60_inq_other_recency in [1, 3]) => 'I60',
    (rv_i60_inq_other_recency in [6])    => 'I60',
    (rv_i60_inq_other_recency in [12])   => 'I60',
                                            '');

game_dist_13 := game_subscore13 - 0.027059;

game_aacd_14 := map(
    NULL < rv_i60_inq_banking_count12 AND rv_i60_inq_banking_count12 < 1 => '',
    1 <= rv_i60_inq_banking_count12                                      => 'I60',
                                                                            '');

game_dist_14 := game_subscore14 - 0.02086;

game_aacd_15 := map(
    (rv_i61_inq_collection_recency in [0])           => '',
    (rv_i61_inq_collection_recency in [1, 3, 6, 12]) => 'I61',
                                                        '');

game_dist_15 := game_subscore15 - 0.013076;

game_aacd_16 := map(
    (rv_d32_attr_felonies_recency in [0])                           => '',
    (rv_d32_attr_felonies_recency in [1, 3, 6, 12, 24, 36, 60, 99]) => 'D32',
                                                                       '');

game_dist_16 := game_subscore16 - 0.008736;

game_aacd_17 := map(
    NULL < rv_a49_curr_add_avm_pct_chg_2yr AND rv_a49_curr_add_avm_pct_chg_2yr < 0.68  => 'A49',
    0.68 <= rv_a49_curr_add_avm_pct_chg_2yr AND rv_a49_curr_add_avm_pct_chg_2yr < 1.74 => 'A47',
    1.74 <= rv_a49_curr_add_avm_pct_chg_2yr                                            => 'A49',
                                                                                          'C12');

game_dist_17 := game_subscore17 - 0.723905;

game_aacd_18 := map(
    (rv_i60_inq_comm_recency in [0])       => '',
    (rv_i60_inq_comm_recency in [1, 3, 6]) => 'I60',
    (rv_i60_inq_comm_recency in [12])      => 'I60',
                                              '');

game_dist_18 := game_subscore18 - 0.008449;

game_rcvaluec12 := (integer)(game_aacd_0 = 'C12') * game_dist_0 +
    (integer)(game_aacd_1 = 'C12') * game_dist_1 +
    (integer)(game_aacd_2 = 'C12') * game_dist_2 +
    (integer)(game_aacd_3 = 'C12') * game_dist_3 +
    (integer)(game_aacd_4 = 'C12') * game_dist_4 +
    (integer)(game_aacd_5 = 'C12') * game_dist_5 +
    (integer)(game_aacd_6 = 'C12') * game_dist_6 +
    (integer)(game_aacd_7 = 'C12') * game_dist_7 +
    (integer)(game_aacd_8 = 'C12') * game_dist_8 +
    (integer)(game_aacd_9 = 'C12') * game_dist_9 +
    (integer)(game_aacd_10 = 'C12') * game_dist_10 +
    (integer)(game_aacd_11 = 'C12') * game_dist_11 +
    (integer)(game_aacd_12 = 'C12') * game_dist_12 +
    (integer)(game_aacd_13 = 'C12') * game_dist_13 +
    (integer)(game_aacd_14 = 'C12') * game_dist_14 +
    (integer)(game_aacd_15 = 'C12') * game_dist_15 +
    (integer)(game_aacd_16 = 'C12') * game_dist_16 +
    (integer)(game_aacd_17 = 'C12') * game_dist_17 +
    (integer)(game_aacd_18 = 'C12') * game_dist_18;

game_rcvaluel80 := (integer)(game_aacd_0 = 'L80') * game_dist_0 +
    (integer)(game_aacd_1 = 'L80') * game_dist_1 +
    (integer)(game_aacd_2 = 'L80') * game_dist_2 +
    (integer)(game_aacd_3 = 'L80') * game_dist_3 +
    (integer)(game_aacd_4 = 'L80') * game_dist_4 +
    (integer)(game_aacd_5 = 'L80') * game_dist_5 +
    (integer)(game_aacd_6 = 'L80') * game_dist_6 +
    (integer)(game_aacd_7 = 'L80') * game_dist_7 +
    (integer)(game_aacd_8 = 'L80') * game_dist_8 +
    (integer)(game_aacd_9 = 'L80') * game_dist_9 +
    (integer)(game_aacd_10 = 'L80') * game_dist_10 +
    (integer)(game_aacd_11 = 'L80') * game_dist_11 +
    (integer)(game_aacd_12 = 'L80') * game_dist_12 +
    (integer)(game_aacd_13 = 'L80') * game_dist_13 +
    (integer)(game_aacd_14 = 'L80') * game_dist_14 +
    (integer)(game_aacd_15 = 'L80') * game_dist_15 +
    (integer)(game_aacd_16 = 'L80') * game_dist_16 +
    (integer)(game_aacd_17 = 'L80') * game_dist_17 +
    (integer)(game_aacd_18 = 'L80') * game_dist_18;

game_rcvalued34 := (integer)(game_aacd_0 = 'D34') * game_dist_0 +
    (integer)(game_aacd_1 = 'D34') * game_dist_1 +
    (integer)(game_aacd_2 = 'D34') * game_dist_2 +
    (integer)(game_aacd_3 = 'D34') * game_dist_3 +
    (integer)(game_aacd_4 = 'D34') * game_dist_4 +
    (integer)(game_aacd_5 = 'D34') * game_dist_5 +
    (integer)(game_aacd_6 = 'D34') * game_dist_6 +
    (integer)(game_aacd_7 = 'D34') * game_dist_7 +
    (integer)(game_aacd_8 = 'D34') * game_dist_8 +
    (integer)(game_aacd_9 = 'D34') * game_dist_9 +
    (integer)(game_aacd_10 = 'D34') * game_dist_10 +
    (integer)(game_aacd_11 = 'D34') * game_dist_11 +
    (integer)(game_aacd_12 = 'D34') * game_dist_12 +
    (integer)(game_aacd_13 = 'D34') * game_dist_13 +
    (integer)(game_aacd_14 = 'D34') * game_dist_14 +
    (integer)(game_aacd_15 = 'D34') * game_dist_15 +
    (integer)(game_aacd_16 = 'D34') * game_dist_16 +
    (integer)(game_aacd_17 = 'D34') * game_dist_17 +
    (integer)(game_aacd_18 = 'D34') * game_dist_18;

game_rcvalued32 := (integer)(game_aacd_0 = 'D32') * game_dist_0 +
    (integer)(game_aacd_1 = 'D32') * game_dist_1 +
    (integer)(game_aacd_2 = 'D32') * game_dist_2 +
    (integer)(game_aacd_3 = 'D32') * game_dist_3 +
    (integer)(game_aacd_4 = 'D32') * game_dist_4 +
    (integer)(game_aacd_5 = 'D32') * game_dist_5 +
    (integer)(game_aacd_6 = 'D32') * game_dist_6 +
    (integer)(game_aacd_7 = 'D32') * game_dist_7 +
    (integer)(game_aacd_8 = 'D32') * game_dist_8 +
    (integer)(game_aacd_9 = 'D32') * game_dist_9 +
    (integer)(game_aacd_10 = 'D32') * game_dist_10 +
    (integer)(game_aacd_11 = 'D32') * game_dist_11 +
    (integer)(game_aacd_12 = 'D32') * game_dist_12 +
    (integer)(game_aacd_13 = 'D32') * game_dist_13 +
    (integer)(game_aacd_14 = 'D32') * game_dist_14 +
    (integer)(game_aacd_15 = 'D32') * game_dist_15 +
    (integer)(game_aacd_16 = 'D32') * game_dist_16 +
    (integer)(game_aacd_17 = 'D32') * game_dist_17 +
    (integer)(game_aacd_18 = 'D32') * game_dist_18;

game_rcvalued33 := (integer)(game_aacd_0 = 'D33') * game_dist_0 +
    (integer)(game_aacd_1 = 'D33') * game_dist_1 +
    (integer)(game_aacd_2 = 'D33') * game_dist_2 +
    (integer)(game_aacd_3 = 'D33') * game_dist_3 +
    (integer)(game_aacd_4 = 'D33') * game_dist_4 +
    (integer)(game_aacd_5 = 'D33') * game_dist_5 +
    (integer)(game_aacd_6 = 'D33') * game_dist_6 +
    (integer)(game_aacd_7 = 'D33') * game_dist_7 +
    (integer)(game_aacd_8 = 'D33') * game_dist_8 +
    (integer)(game_aacd_9 = 'D33') * game_dist_9 +
    (integer)(game_aacd_10 = 'D33') * game_dist_10 +
    (integer)(game_aacd_11 = 'D33') * game_dist_11 +
    (integer)(game_aacd_12 = 'D33') * game_dist_12 +
    (integer)(game_aacd_13 = 'D33') * game_dist_13 +
    (integer)(game_aacd_14 = 'D33') * game_dist_14 +
    (integer)(game_aacd_15 = 'D33') * game_dist_15 +
    (integer)(game_aacd_16 = 'D33') * game_dist_16 +
    (integer)(game_aacd_17 = 'D33') * game_dist_17 +
    (integer)(game_aacd_18 = 'D33') * game_dist_18;

game_rcvalued31 := (integer)(game_aacd_0 = 'D31') * game_dist_0 +
    (integer)(game_aacd_1 = 'D31') * game_dist_1 +
    (integer)(game_aacd_2 = 'D31') * game_dist_2 +
    (integer)(game_aacd_3 = 'D31') * game_dist_3 +
    (integer)(game_aacd_4 = 'D31') * game_dist_4 +
    (integer)(game_aacd_5 = 'D31') * game_dist_5 +
    (integer)(game_aacd_6 = 'D31') * game_dist_6 +
    (integer)(game_aacd_7 = 'D31') * game_dist_7 +
    (integer)(game_aacd_8 = 'D31') * game_dist_8 +
    (integer)(game_aacd_9 = 'D31') * game_dist_9 +
    (integer)(game_aacd_10 = 'D31') * game_dist_10 +
    (integer)(game_aacd_11 = 'D31') * game_dist_11 +
    (integer)(game_aacd_12 = 'D31') * game_dist_12 +
    (integer)(game_aacd_13 = 'D31') * game_dist_13 +
    (integer)(game_aacd_14 = 'D31') * game_dist_14 +
    (integer)(game_aacd_15 = 'D31') * game_dist_15 +
    (integer)(game_aacd_16 = 'D31') * game_dist_16 +
    (integer)(game_aacd_17 = 'D31') * game_dist_17 +
    (integer)(game_aacd_18 = 'D31') * game_dist_18;

game_rcvaluea47 := (integer)(game_aacd_0 = 'A47') * game_dist_0 +
    (integer)(game_aacd_1 = 'A47') * game_dist_1 +
    (integer)(game_aacd_2 = 'A47') * game_dist_2 +
    (integer)(game_aacd_3 = 'A47') * game_dist_3 +
    (integer)(game_aacd_4 = 'A47') * game_dist_4 +
    (integer)(game_aacd_5 = 'A47') * game_dist_5 +
    (integer)(game_aacd_6 = 'A47') * game_dist_6 +
    (integer)(game_aacd_7 = 'A47') * game_dist_7 +
    (integer)(game_aacd_8 = 'A47') * game_dist_8 +
    (integer)(game_aacd_9 = 'A47') * game_dist_9 +
    (integer)(game_aacd_10 = 'A47') * game_dist_10 +
    (integer)(game_aacd_11 = 'A47') * game_dist_11 +
    (integer)(game_aacd_12 = 'A47') * game_dist_12 +
    (integer)(game_aacd_13 = 'A47') * game_dist_13 +
    (integer)(game_aacd_14 = 'A47') * game_dist_14 +
    (integer)(game_aacd_15 = 'A47') * game_dist_15 +
    (integer)(game_aacd_16 = 'A47') * game_dist_16 +
    (integer)(game_aacd_17 = 'A47') * game_dist_17 +
    (integer)(game_aacd_18 = 'A47') * game_dist_18;

game_rcvaluea45 := (integer)(game_aacd_0 = 'A45') * game_dist_0 +
    (integer)(game_aacd_1 = 'A45') * game_dist_1 +
    (integer)(game_aacd_2 = 'A45') * game_dist_2 +
    (integer)(game_aacd_3 = 'A45') * game_dist_3 +
    (integer)(game_aacd_4 = 'A45') * game_dist_4 +
    (integer)(game_aacd_5 = 'A45') * game_dist_5 +
    (integer)(game_aacd_6 = 'A45') * game_dist_6 +
    (integer)(game_aacd_7 = 'A45') * game_dist_7 +
    (integer)(game_aacd_8 = 'A45') * game_dist_8 +
    (integer)(game_aacd_9 = 'A45') * game_dist_9 +
    (integer)(game_aacd_10 = 'A45') * game_dist_10 +
    (integer)(game_aacd_11 = 'A45') * game_dist_11 +
    (integer)(game_aacd_12 = 'A45') * game_dist_12 +
    (integer)(game_aacd_13 = 'A45') * game_dist_13 +
    (integer)(game_aacd_14 = 'A45') * game_dist_14 +
    (integer)(game_aacd_15 = 'A45') * game_dist_15 +
    (integer)(game_aacd_16 = 'A45') * game_dist_16 +
    (integer)(game_aacd_17 = 'A45') * game_dist_17 +
    (integer)(game_aacd_18 = 'A45') * game_dist_18;

game_rcvaluea42 := (integer)(game_aacd_0 = 'A42') * game_dist_0 +
    (integer)(game_aacd_1 = 'A42') * game_dist_1 +
    (integer)(game_aacd_2 = 'A42') * game_dist_2 +
    (integer)(game_aacd_3 = 'A42') * game_dist_3 +
    (integer)(game_aacd_4 = 'A42') * game_dist_4 +
    (integer)(game_aacd_5 = 'A42') * game_dist_5 +
    (integer)(game_aacd_6 = 'A42') * game_dist_6 +
    (integer)(game_aacd_7 = 'A42') * game_dist_7 +
    (integer)(game_aacd_8 = 'A42') * game_dist_8 +
    (integer)(game_aacd_9 = 'A42') * game_dist_9 +
    (integer)(game_aacd_10 = 'A42') * game_dist_10 +
    (integer)(game_aacd_11 = 'A42') * game_dist_11 +
    (integer)(game_aacd_12 = 'A42') * game_dist_12 +
    (integer)(game_aacd_13 = 'A42') * game_dist_13 +
    (integer)(game_aacd_14 = 'A42') * game_dist_14 +
    (integer)(game_aacd_15 = 'A42') * game_dist_15 +
    (integer)(game_aacd_16 = 'A42') * game_dist_16 +
    (integer)(game_aacd_17 = 'A42') * game_dist_17 +
    (integer)(game_aacd_18 = 'A42') * game_dist_18;

game_rcvaluei61 := (integer)(game_aacd_0 = 'I61') * game_dist_0 +
    (integer)(game_aacd_1 = 'I61') * game_dist_1 +
    (integer)(game_aacd_2 = 'I61') * game_dist_2 +
    (integer)(game_aacd_3 = 'I61') * game_dist_3 +
    (integer)(game_aacd_4 = 'I61') * game_dist_4 +
    (integer)(game_aacd_5 = 'I61') * game_dist_5 +
    (integer)(game_aacd_6 = 'I61') * game_dist_6 +
    (integer)(game_aacd_7 = 'I61') * game_dist_7 +
    (integer)(game_aacd_8 = 'I61') * game_dist_8 +
    (integer)(game_aacd_9 = 'I61') * game_dist_9 +
    (integer)(game_aacd_10 = 'I61') * game_dist_10 +
    (integer)(game_aacd_11 = 'I61') * game_dist_11 +
    (integer)(game_aacd_12 = 'I61') * game_dist_12 +
    (integer)(game_aacd_13 = 'I61') * game_dist_13 +
    (integer)(game_aacd_14 = 'I61') * game_dist_14 +
    (integer)(game_aacd_15 = 'I61') * game_dist_15 +
    (integer)(game_aacd_16 = 'I61') * game_dist_16 +
    (integer)(game_aacd_17 = 'I61') * game_dist_17 +
    (integer)(game_aacd_18 = 'I61') * game_dist_18;

game_rcvaluei62 := (integer)(game_aacd_0 = 'I62') * game_dist_0 +
    (integer)(game_aacd_1 = 'I62') * game_dist_1 +
    (integer)(game_aacd_2 = 'I62') * game_dist_2 +
    (integer)(game_aacd_3 = 'I62') * game_dist_3 +
    (integer)(game_aacd_4 = 'I62') * game_dist_4 +
    (integer)(game_aacd_5 = 'I62') * game_dist_5 +
    (integer)(game_aacd_6 = 'I62') * game_dist_6 +
    (integer)(game_aacd_7 = 'I62') * game_dist_7 +
    (integer)(game_aacd_8 = 'I62') * game_dist_8 +
    (integer)(game_aacd_9 = 'I62') * game_dist_9 +
    (integer)(game_aacd_10 = 'I62') * game_dist_10 +
    (integer)(game_aacd_11 = 'I62') * game_dist_11 +
    (integer)(game_aacd_12 = 'I62') * game_dist_12 +
    (integer)(game_aacd_13 = 'I62') * game_dist_13 +
    (integer)(game_aacd_14 = 'I62') * game_dist_14 +
    (integer)(game_aacd_15 = 'I62') * game_dist_15 +
    (integer)(game_aacd_16 = 'I62') * game_dist_16 +
    (integer)(game_aacd_17 = 'I62') * game_dist_17 +
    (integer)(game_aacd_18 = 'I62') * game_dist_18;

game_rcvaluea41 := (integer)(game_aacd_0 = 'A41') * game_dist_0 +
    (integer)(game_aacd_1 = 'A41') * game_dist_1 +
    (integer)(game_aacd_2 = 'A41') * game_dist_2 +
    (integer)(game_aacd_3 = 'A41') * game_dist_3 +
    (integer)(game_aacd_4 = 'A41') * game_dist_4 +
    (integer)(game_aacd_5 = 'A41') * game_dist_5 +
    (integer)(game_aacd_6 = 'A41') * game_dist_6 +
    (integer)(game_aacd_7 = 'A41') * game_dist_7 +
    (integer)(game_aacd_8 = 'A41') * game_dist_8 +
    (integer)(game_aacd_9 = 'A41') * game_dist_9 +
    (integer)(game_aacd_10 = 'A41') * game_dist_10 +
    (integer)(game_aacd_11 = 'A41') * game_dist_11 +
    (integer)(game_aacd_12 = 'A41') * game_dist_12 +
    (integer)(game_aacd_13 = 'A41') * game_dist_13 +
    (integer)(game_aacd_14 = 'A41') * game_dist_14 +
    (integer)(game_aacd_15 = 'A41') * game_dist_15 +
    (integer)(game_aacd_16 = 'A41') * game_dist_16 +
    (integer)(game_aacd_17 = 'A41') * game_dist_17 +
    (integer)(game_aacd_18 = 'A41') * game_dist_18;

game_rcvaluei60 := (integer)(game_aacd_0 = 'I60') * game_dist_0 +
    (integer)(game_aacd_1 = 'I60') * game_dist_1 +
    (integer)(game_aacd_2 = 'I60') * game_dist_2 +
    (integer)(game_aacd_3 = 'I60') * game_dist_3 +
    (integer)(game_aacd_4 = 'I60') * game_dist_4 +
    (integer)(game_aacd_5 = 'I60') * game_dist_5 +
    (integer)(game_aacd_6 = 'I60') * game_dist_6 +
    (integer)(game_aacd_7 = 'I60') * game_dist_7 +
    (integer)(game_aacd_8 = 'I60') * game_dist_8 +
    (integer)(game_aacd_9 = 'I60') * game_dist_9 +
    (integer)(game_aacd_10 = 'I60') * game_dist_10 +
    (integer)(game_aacd_11 = 'I60') * game_dist_11 +
    (integer)(game_aacd_12 = 'I60') * game_dist_12 +
    (integer)(game_aacd_13 = 'I60') * game_dist_13 +
    (integer)(game_aacd_14 = 'I60') * game_dist_14 +
    (integer)(game_aacd_15 = 'I60') * game_dist_15 +
    (integer)(game_aacd_16 = 'I60') * game_dist_16 +
    (integer)(game_aacd_17 = 'I60') * game_dist_17 +
    (integer)(game_aacd_18 = 'I60') * game_dist_18;

game_rcvaluec10 := (integer)(game_aacd_0 = 'C10') * game_dist_0 +
    (integer)(game_aacd_1 = 'C10') * game_dist_1 +
    (integer)(game_aacd_2 = 'C10') * game_dist_2 +
    (integer)(game_aacd_3 = 'C10') * game_dist_3 +
    (integer)(game_aacd_4 = 'C10') * game_dist_4 +
    (integer)(game_aacd_5 = 'C10') * game_dist_5 +
    (integer)(game_aacd_6 = 'C10') * game_dist_6 +
    (integer)(game_aacd_7 = 'C10') * game_dist_7 +
    (integer)(game_aacd_8 = 'C10') * game_dist_8 +
    (integer)(game_aacd_9 = 'C10') * game_dist_9 +
    (integer)(game_aacd_10 = 'C10') * game_dist_10 +
    (integer)(game_aacd_11 = 'C10') * game_dist_11 +
    (integer)(game_aacd_12 = 'C10') * game_dist_12 +
    (integer)(game_aacd_13 = 'C10') * game_dist_13 +
    (integer)(game_aacd_14 = 'C10') * game_dist_14 +
    (integer)(game_aacd_15 = 'C10') * game_dist_15 +
    (integer)(game_aacd_16 = 'C10') * game_dist_16 +
    (integer)(game_aacd_17 = 'C10') * game_dist_17 +
    (integer)(game_aacd_18 = 'C10') * game_dist_18;

game_rcvaluea49 := (integer)(game_aacd_0 = 'A49') * game_dist_0 +
    (integer)(game_aacd_1 = 'A49') * game_dist_1 +
    (integer)(game_aacd_2 = 'A49') * game_dist_2 +
    (integer)(game_aacd_3 = 'A49') * game_dist_3 +
    (integer)(game_aacd_4 = 'A49') * game_dist_4 +
    (integer)(game_aacd_5 = 'A49') * game_dist_5 +
    (integer)(game_aacd_6 = 'A49') * game_dist_6 +
    (integer)(game_aacd_7 = 'A49') * game_dist_7 +
    (integer)(game_aacd_8 = 'A49') * game_dist_8 +
    (integer)(game_aacd_9 = 'A49') * game_dist_9 +
    (integer)(game_aacd_10 = 'A49') * game_dist_10 +
    (integer)(game_aacd_11 = 'A49') * game_dist_11 +
    (integer)(game_aacd_12 = 'A49') * game_dist_12 +
    (integer)(game_aacd_13 = 'A49') * game_dist_13 +
    (integer)(game_aacd_14 = 'A49') * game_dist_14 +
    (integer)(game_aacd_15 = 'A49') * game_dist_15 +
    (integer)(game_aacd_16 = 'A49') * game_dist_16 +
    (integer)(game_aacd_17 = 'A49') * game_dist_17 +
    (integer)(game_aacd_18 = 'A49') * game_dist_18;

game_rcvaluec14 := (integer)(game_aacd_0 = 'C14') * game_dist_0 +
    (integer)(game_aacd_1 = 'C14') * game_dist_1 +
    (integer)(game_aacd_2 = 'C14') * game_dist_2 +
    (integer)(game_aacd_3 = 'C14') * game_dist_3 +
    (integer)(game_aacd_4 = 'C14') * game_dist_4 +
    (integer)(game_aacd_5 = 'C14') * game_dist_5 +
    (integer)(game_aacd_6 = 'C14') * game_dist_6 +
    (integer)(game_aacd_7 = 'C14') * game_dist_7 +
    (integer)(game_aacd_8 = 'C14') * game_dist_8 +
    (integer)(game_aacd_9 = 'C14') * game_dist_9 +
    (integer)(game_aacd_10 = 'C14') * game_dist_10 +
    (integer)(game_aacd_11 = 'C14') * game_dist_11 +
    (integer)(game_aacd_12 = 'C14') * game_dist_12 +
    (integer)(game_aacd_13 = 'C14') * game_dist_13 +
    (integer)(game_aacd_14 = 'C14') * game_dist_14 +
    (integer)(game_aacd_15 = 'C14') * game_dist_15 +
    (integer)(game_aacd_16 = 'C14') * game_dist_16 +
    (integer)(game_aacd_17 = 'C14') * game_dist_17 +
    (integer)(game_aacd_18 = 'C14') * game_dist_18;

_rc_inq := map(
    rv_i60_inq_count12 > 0            => 'I60',
    rv_i61_inq_collection_recency > 0 => 'I61',
    rv_i60_inq_banking_count12 > 0    => 'I60',
    rv_i60_inq_hiriskcred_count12 > 0 => 'I60',
    rv_i60_inq_comm_recency > 0       => 'I60',
    rv_i60_inq_other_recency > 0      => 'I60',
    rv_i62_inq_ssns_per_adl > 1       => 'I62',
    rv_i62_inq_phones_per_adl > 0     => 'I62',
                                         '');


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};

 
//*************************************************************************************//
rc_dataset_game := DATASET([
    {'C12', game_rcvalueC12},
    {'L80', game_rcvalueL80},
    {'D34', game_rcvalueD34},
    {'D32', game_rcvalueD32},
    {'D33', game_rcvalueD33},
    {'D31', game_rcvalueD31},
    {'A47', game_rcvalueA47},
    {'A45', game_rcvalueA45},
    {'A42', game_rcvalueA42},
    {'I61', game_rcvalueI61},
    {'I62', game_rcvalueI62},
    {'A41', game_rcvalueA41},
    {'I60', game_rcvalueI60},
    {'C10', game_rcvalueC10},
    {'A49', game_rcvalueA49},
    {'C14', game_rcvalueC14}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_game_sorted := sort(rc_dataset_game, rc_dataset_game.value);

game_rc1 := rc_dataset_game_sorted[1].rc;
game_rc2 := rc_dataset_game_sorted[2].rc;
game_rc3 := rc_dataset_game_sorted[3].rc;
game_rc4 := rc_dataset_game_sorted[4].rc;

game_vl1 := rc_dataset_game_sorted[1].value;
game_vl2 := rc_dataset_game_sorted[2].value;
game_vl3 := rc_dataset_game_sorted[3].value;
game_vl4 := rc_dataset_game_sorted[4].value;
//*************************************************************************************//

rc1_2 := game_rc1;

rc2_2 := game_rc2;

rc3_2 := game_rc3;

rc4_2 := game_rc4;

rc2_c64 := map(
    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,
    trim(trim((string)rc3_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => '',
                                                         '');

rc1_c64 := map(
    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc3_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => '',
                                                         '');

rc4_c64 := map(
    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc3_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,
                                                         '');

rc3_c64 := map(
    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc3_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,
    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => '',
                                                         '');

rc5_c64 := map(
    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc3_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => '',
                                                         _rc_inq);

rc5_1 := if(rc5_c64 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc5_c64, '');

rc3_1 := if(rc3_c64 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc3_c64, rc3_2);

rc1_1 := if(rc1_c64 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc1_c64, rc1_2);

rc4_1 := if(rc4_c64 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc4_c64, rc4_2);

rc2_1 := if(rc2_c64 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc2_c64, rc2_2);

rc5 := if((rvg1705_1_0 in [200, 222]), '', rc5_1);

rc2 := if((rvg1705_1_0 in [200, 222]), '', rc2_1);

rc1 := if((rvg1705_1_0 in [200, 222]), '', rc1_1);

rc4 := if((rvg1705_1_0 in [200, 222]), '', rc4_1);

rc3 := if((rvg1705_1_0 in [200, 222]), '', rc3_1);



	//*************************************************************************************//
	//                     RiskView Version 5 - RVT1608_2 Score Overrides
	//*************************************************************************************//
	// Deceased = 200
	// Unscorable = 222
	// Score Range: 501 - 900
	//*************************************************************************************//


//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVG1705_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVG1705_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVG1705_1_0 = 900 => DATASET([{'00'}], HRILayout),
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
		
		SELF.seq     := seq;
    self.sysdate := sysdate;
		
        self.inp_naprop_no_truedid            := inp_naprop_no_truedid;
        self.iv_rv5_unscorable                := iv_rv5_unscorable;
        self.rv_d31_mostrec_bk                := rv_d31_mostrec_bk;
        self.rv_d33_eviction_recency          := rv_d33_eviction_recency;
        self._header_first_seen               := _header_first_seen;
        self.rv_c10_m_hdr_fs                  := rv_c10_m_hdr_fs;
        self.rv_c12_source_profile_index      := rv_c12_source_profile_index;
        self.rv_l80_inp_avm_autoval           := rv_l80_inp_avm_autoval;
        self.rv_c14_addrs_10yr                := rv_c14_addrs_10yr;
        self.rv_a41_a42_prop_owner_history    := rv_a41_a42_prop_owner_history;
        self.rv_i60_inq_count12               := rv_i60_inq_count12;
        self.rv_i61_inq_collection_recency    := rv_i61_inq_collection_recency;
        self.rv_i60_inq_banking_count12       := rv_i60_inq_banking_count12;
        self.rv_i60_inq_hiriskcred_count12    := rv_i60_inq_hiriskcred_count12;
        self.rv_i60_inq_comm_recency          := rv_i60_inq_comm_recency;
        self.rv_d32_attr_felonies_recency     := rv_d32_attr_felonies_recency;
        self.rv_d34_attr_unrel_liens_recency  := rv_d34_attr_unrel_liens_recency;
        self.rv_a49_curr_add_avm_pct_chg_2yr  := rv_a49_curr_add_avm_pct_chg_2yr;
        self.rv_i60_inq_other_recency         := rv_i60_inq_other_recency;
        self.rv_i62_inq_ssns_per_adl          := rv_i62_inq_ssns_per_adl;
        self.rv_i62_inq_phones_per_adl        := rv_i62_inq_phones_per_adl;
        self.game_subscore0                   := game_subscore0;
        self.game_subscore1                   := game_subscore1;
        self.game_subscore2                   := game_subscore2;
        self.game_subscore3                   := game_subscore3;
        self.game_subscore4                   := game_subscore4;
        self.game_subscore5                   := game_subscore5;
        self.game_subscore6                   := game_subscore6;
        self.game_subscore7                   := game_subscore7;
        self.game_subscore8                   := game_subscore8;
        self.game_subscore9                   := game_subscore9;
        self.game_subscore10                  := game_subscore10;
        self.game_subscore11                  := game_subscore11;
        self.game_subscore12                  := game_subscore12;
        self.game_subscore13                  := game_subscore13;
        self.game_subscore14                  := game_subscore14;
        self.game_subscore15                  := game_subscore15;
        self.game_subscore16                  := game_subscore16;
        self.game_subscore17                  := game_subscore17;
        self.game_subscore18                  := game_subscore18;
        self.game_rawscore                    := game_rawscore;
        self.game_lnoddsscore                 := game_lnoddsscore;
        self.game_probscore                   := game_probscore;
        self.base                             := base;
        self.pts                              := pts;
        self.lgt                              := lgt;
        self.deceased                         := deceased;
        self.rvg1705_1_0                      := rvg1705_1_0;
        self.game_aacd_0                      := game_aacd_0;
        self.game_dist_0                      := game_dist_0;
        self.game_aacd_1                      := game_aacd_1;
        self.game_dist_1                      := game_dist_1;
        self.game_aacd_2                      := game_aacd_2;
        self.game_dist_2                      := game_dist_2;
        self.game_aacd_3                      := game_aacd_3;
        self.game_dist_3                      := game_dist_3;
        self.game_aacd_4                      := game_aacd_4;
        self.game_dist_4                      := game_dist_4;
        self.game_aacd_5                      := game_aacd_5;
        self.game_dist_5                      := game_dist_5;
        self.game_aacd_6                      := game_aacd_6;
        self.game_dist_6                      := game_dist_6;
        self.game_aacd_7                      := game_aacd_7;
        self.game_dist_7                      := game_dist_7;
        self.game_aacd_8                      := game_aacd_8;
        self.game_dist_8                      := game_dist_8;
        self.game_aacd_9                      := game_aacd_9;
        self.game_dist_9                      := game_dist_9;
        self.game_aacd_10                     := game_aacd_10;
        self.game_dist_10                     := game_dist_10;
        self.game_aacd_11                     := game_aacd_11;
        self.game_dist_11                     := game_dist_11;
        self.game_aacd_12                     := game_aacd_12;
        self.game_dist_12                     := game_dist_12;
        self.game_aacd_13                     := game_aacd_13;
        self.game_dist_13                     := game_dist_13;
        self.game_aacd_14                     := game_aacd_14;
        self.game_dist_14                     := game_dist_14;
        self.game_aacd_15                     := game_aacd_15;
        self.game_dist_15                     := game_dist_15;
        self.game_aacd_16                     := game_aacd_16;
        self.game_dist_16                     := game_dist_16;
        self.game_aacd_17                     := game_aacd_17;
        self.game_dist_17                     := game_dist_17;
        self.game_aacd_18                     := game_aacd_18;
        self.game_dist_18                     := game_dist_18;
        self.game_rcvaluec12                  := game_rcvaluec12;
        self.game_rcvaluel80                  := game_rcvaluel80;
        self.game_rcvalued34                  := game_rcvalued34;
        self.game_rcvalued32                  := game_rcvalued32;
        self.game_rcvalued33                  := game_rcvalued33;
        self.game_rcvalued31                  := game_rcvalued31;
        self.game_rcvaluea47                  := game_rcvaluea47;
        self.game_rcvaluea45                  := game_rcvaluea45;
        self.game_rcvaluea42                  := game_rcvaluea42;
        self.game_rcvaluei61                  := game_rcvaluei61;
        self.game_rcvaluei62                  := game_rcvaluei62;
        self.game_rcvaluea41                  := game_rcvaluea41;
        self.game_rcvaluei60                  := game_rcvaluei60;
        self.game_rcvaluec10                  := game_rcvaluec10;
        self.game_rcvaluea49                  := game_rcvaluea49;
        self.game_rcvaluec14                  := game_rcvaluec14;
        self._rc_inq                          := _rc_inq;
        self.game_rc1                         := game_rc1;
        self.game_rc2                         := game_rc2;
        self.game_rc3                         := game_rc3;
        self.game_rc4                         := game_rc4;
        self.game_vl1                         := game_vl1;
        self.game_vl2                         := game_vl2;
        self.game_vl3                         := game_vl3;
        self.game_vl4                         := game_vl4;
        self.rc4                              := rc4;
        self.rc3                              := rc3;
        self.rc1                              := rc1;
        self.rc2                              := rc2;
        self.rc5                              := rc5;

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvg1705_1_0;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;

