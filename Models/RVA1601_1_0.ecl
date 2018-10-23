IMPORT ut, Std, RiskWise, RiskWiseFCRA, Risk_Indicators, riskview;

EXPORT RVA1601_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	MODEL_DEBUG := False;

	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
	 Integer seq;
	 Integer	 num_dob_match_level;
   Integer	 nas_summary_ver;
   Integer	 nap_summary_ver;
   Integer	 infutor_nap_ver;
   Integer	 dob_ver;
   String	 add_ec1;
   Integer	 addr_validation_problem;
   Integer	 phn_validation_problem;
   Integer	 tot_liens;
   Integer	 tot_liens_w_type;
   Integer	 has_derog;
   String	 rv50_seg_hd_subprime;
   Boolean	 derog_seg;
   Boolean	 owner_seg;
   Boolean	 other_seg;
   Integer sysdate;
   String	 iv_rv5_unscorable;
   String	 rv_f03_input_add_not_most_rec;
   Integer	 _criminal_last_date;
   Integer	 rv_d32_mos_since_crim_ls;
   Integer	 rv_c21_stl_inq_count;
   Integer	 rv_d33_eviction_count;
   Integer	 _header_first_seen;
   Integer	 rv_c10_m_hdr_fs;
   Integer	 rv_f01_inp_addr_not_verified;
   String	 rv_ever_asset_owner;
   Integer	 rv_i60_inq_count12;
   Integer	 rv_i60_inq_hiriskcred_count12;
   Integer	 rv_c13_attr_addrs_recency;
   Integer rv_a49_curr_add_avm_pct_chg_2yr;
   Integer	 rv_f01_inp_addr_address_score;
   Integer	 rv_a46_curr_avm_autoval;
   String	 rv_a41_prop_owner_inp_only;
   Integer	 rv_i62_inq_phones_per_adl;
   Integer	 rv_i60_inq_comm_count12;
   Integer	 rv_a50_pb_average_dollars;
   Integer	 rv_c13_inp_addr_lres;
   Real	 sp2_subscore0;
   Real	 sp2_subscore1;
   Real	 sp2_subscore2;
   Real	 sp2_subscore3;
   Real	 sp2_subscore4;
   Real	 sp2_subscore5;
   Real	 sp2_subscore6;
   Real	 sp2_subscore7;
   Real	 sp2_subscore8;
   Real	 sp2_subscore9;
   Real	 sp2_subscore10;
   Real	 sp2_rawscore;
   Real	 sp2_lnoddsscore;
   Real	 sp2_probscore;
   String	 sp2_aacd_0;
   Real	 sp2_dist_0;
   String	 sp2_aacd_1;
   Real	 sp2_dist_1;
   String	 sp2_aacd_2;
   Real	 sp2_dist_2;
   String	 sp2_aacd_3;
   Real	 sp2_dist_3;
   String	 sp2_aacd_4;
   Real	 sp2_dist_4;
   String	 sp2_aacd_5;
   Real	 sp2_dist_5;
   String	 sp2_aacd_6;
   Real	 sp2_dist_6;
   String	 sp2_aacd_7;
   Real	 sp2_dist_7;
   String	 sp2_aacd_8;
   Real	 sp2_dist_8;
   String	 sp2_aacd_9;
   Real	 sp2_dist_9;
   String	 sp2_aacd_10;
   Real	 sp2_dist_10;
   Real	 sp2_rcvaluec21;
   Real	 sp2_rcvaluef03;
   Real	 sp2_rcvalued32;
   Real	 sp2_rcvalued33;
   Real	 sp2_rcvaluei60;
   Real	 sp2_rcvaluea40;
   Real	 sp2_rcvaluec13;
   Real	 sp2_rcvaluef01;
   Real	 sp2_rcvaluec10;
   Real	 sp2_rcvaluea49;
   Real	 sp3_subscore0;
   Real	 sp3_subscore1;
   Real	 sp3_subscore2;
   Real	 sp3_subscore3;
   Real	 sp3_subscore4;
   Real	 sp3_subscore5;
   Real	 sp3_rawscore;
   Real	 sp3_lnoddsscore;
   Real	 sp3_probscore;
   String	 sp3_aacd_0;
   Real	 sp3_dist_0;
   String	 sp3_aacd_1;
   Real	 sp3_dist_1;
   String	 sp3_aacd_2;
   Real	 sp3_dist_2;
   String	 sp3_aacd_3;
   Real	 sp3_dist_3;
   String	 sp3_aacd_4;
   Real	 sp3_dist_4;
   String	 sp3_aacd_5;
   Real	 sp3_dist_5;
   Real	 sp3_rcvaluea46;
   Real	 sp3_rcvaluei60;
   Real	 sp3_rcvaluei62;
   Real	 sp3_rcvaluea41;
   Real	 sp3_rcvaluef01;
   Real	 sp3_rcvaluec10;
   Real	 sp4_subscore0;
   Real	 sp4_subscore1;
   Real	 sp4_subscore2;
   Real	 sp4_subscore3;
   Real	 sp4_subscore4;
   Real	 sp4_subscore5;
   Real	 sp4_subscore6;
   Real	 sp4_subscore7;
   Real	 sp4_subscore8;
   Real	 sp4_subscore9;
   Real	 sp4_rawscore;
   Real	 sp4_lnoddsscore;
   Real	 sp4_probscore;
   String	 sp4_aacd_0;
   Real	 sp4_dist_0;
   String	 sp4_aacd_1;
   Real	 sp4_dist_1;
   String	 sp4_aacd_2;
   Real	 sp4_dist_2;
   String	 sp4_aacd_3;
   Real	 sp4_dist_3;
   String	 sp4_aacd_4;
   Real	 sp4_dist_4;
   String	 sp4_aacd_5;
   Real	 sp4_dist_5;
   String	 sp4_aacd_6;
   Real	 sp4_dist_6;
   String	 sp4_aacd_7;
   Real	 sp4_dist_7;
   String	 sp4_aacd_8;
   Real	 sp4_dist_8;
   String	 sp4_aacd_9;
   Real	 sp4_dist_9;
   Real	 sp4_rcvaluec21;
   Real	 sp4_rcvaluei62;
   Real	 sp4_rcvaluea46;
   Real	 sp4_rcvaluea50;
   Real	 sp4_rcvaluei60;
   Real	 sp4_rcvaluea40;
   Real	 sp4_rcvaluec13;
   Real	 sp4_rcvaluec10;
   Real	 probscore;
   Integer	 base;
   Real	 pts;
   Real	 odds;
   Integer	 deceased;
   Integer	 rva1601_1_0;
   String	 _rc_seg;
   String	 sp2_rc1;
   String	 sp2_rc2;
   String	 sp2_rc3;
   String	 sp2_rc4;
   Real	 sp2_vl1;
   Real	 sp2_vl2;
   Real	 sp2_vl3;
   Real	 sp2_vl4;
   String	 sp3_rc1;
   String	 sp3_rc2;
   String	 sp3_rc3;
   String	 sp3_rc4;
   Real	 sp3_vl1;
   Real	 sp3_vl2;
   Real	 sp3_vl3;
   Real	 sp3_vl4;
   String	 sp4_rc1;
   String	 sp4_rc2;
   String	 sp4_rc3;
   String	 sp4_rc4;
   Real	 sp4_vl1;
   Real	 sp4_vl2;
   Real	 sp4_vl3;
   Real	 sp4_vl4;
   String	 _rc_inq;
   String	 rc3;
   String	 rc4;
   String	 rc1;
   String	 rc5;
   String	 rc2;

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
	out_z5                           := le.shell_input.z5;
	out_addr_status                  := le.shell_input.addr_status;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_hriskaddrflag                 := le.iid.hriskaddrflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_phonetype                     := le.iid.phonetype;
	rc_ziptypeflag                   := le.iid.ziptypeflag;
	ver_sources                      := le.header_summary.ver_sources;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_lres                   := le.lres;
	add_input_addr_not_verified      := le.address_verification.inputAddr_not_verified;
	add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_lres                    := le.lres2;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_avm_auto_val_3          := le.avm.address_history_1.avm_automated_valuation3;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	telcordia_type                   := le.phone_verification.telcordia_type;
	header_first_seen                := le.ssn_verification.header_first_seen;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	pb_average_dollars               := le.ibehavior.average_amount_per_order;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count                    := le.impulse.count;
	stl_inq_count12                  := le.impulse.count12;
	stl_inq_count24                  := le.impulse.count24;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_eviction_count              := le.bjl.eviction_count;
	bk_dismissed_recent_count        := le.bjl.bk_dismissed_recent_count;
	bk_dismissed_historical_count    := le.bjl.bk_dismissed_historical_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_recent_released_count      := le.bjl.liens_recent_released_count;
	liens_historical_released_count  := le.bjl.liens_historical_released_count;
	liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
	liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
	liens_unrel_ft_ct                := le.liens.liens_unreleased_federal_tax.count;
	liens_rel_ft_ct                  := le.liens.liens_released_federal_tax.count;
	liens_unrel_fc_ct                := le.liens.liens_unreleased_foreclosure.count;
	liens_rel_fc_ct                  := le.liens.liens_released_foreclosure.count;
	liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
	liens_rel_lt_ct                  := le.liens.liens_released_landlord_tenant.count;
	liens_unrel_o_ct                 := le.liens.liens_unreleased_other_lj.count;
	liens_rel_o_ct                   := le.liens.liens_released_other_lj.count;
	liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
	liens_rel_ot_ct                  := le.liens.liens_released_other_tax.count;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	liens_rel_sc_ct                  := le.liens.liens_released_small_claims.count;
	liens_unrel_st_ct                := le.liens.liens_unreleased_suits.count;
	liens_rel_st_ct                  := le.liens.liens_released_suits.count;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_count                     := le.bjl.felony_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	input_dob_match_level            := le.dobmatchlevel;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */


NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

num_dob_match_level := (integer)input_dob_match_level;

nas_summary_ver := if(ssnlength > '0' and (nas_summary in [8, 9, 10, 11, 12]) or (nas_summary in [2, 4, 7]) and (boolean)(integer)add_input_isbestmatch, 1, 0);

nap_summary_ver := if(hphnpop and (nap_summary in [9, 10, 11, 12]), 1, 0);

infutor_nap_ver := if(hphnpop and (infutor_nap in [9, 10, 11, 12]), 1, 0);

dob_ver := if(dobpop and num_dob_match_level >= 5, 1, 0);

add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];

addr_validation_problem := if(add_ec1 = 'E' and not(rc_addrvalflag = 'N') or rc_hriskaddrflag = '4' or rc_addrcommflag = '2' or (add_input_advo_res_or_bus in ['B', 'D']) or not(out_z5 = '') and (rc_hriskaddrflag = '2' or rc_ziptypeflag = '2') or add_input_advo_vacancy = 'Y', 1, 0);

phn_validation_problem := if(rc_hphonetypeflag = 'A' or rc_hriskphoneflag = '2' or rc_hphonetypeflag = '2' or (telcordia_type in ['02', '56', '61']) or rc_phonevalflag = '0' or rc_hphonevalflag = '0' or rc_phonetype = '5' or rc_hriskphoneflag = '6' or rc_hphonetypeflag = '5' or rc_hphonevalflag = '3' or rc_addrcommflag = '1', 1, 0);

tot_liens := if(max(liens_historical_unreleased_ct, liens_recent_unreleased_count, liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct), if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count)));

tot_liens_w_type := if(max(liens_unrel_LT_ct, liens_rel_LT_ct, liens_unrel_SC_ct, liens_rel_SC_ct, liens_unrel_CJ_ct, liens_rel_CJ_ct, liens_unrel_FT_ct, liens_rel_FT_ct, liens_unrel_OT_ct, liens_rel_OT_ct, liens_unrel_ST_ct, liens_rel_ST_ct, liens_unrel_FC_ct, liens_rel_FC_ct, liens_unrel_O_ct, liens_rel_O_ct) = NULL, NULL, sum(if(liens_unrel_LT_ct = NULL, 0, liens_unrel_LT_ct), if(liens_rel_LT_ct = NULL, 0, liens_rel_LT_ct), if(liens_unrel_SC_ct = NULL, 0, liens_unrel_SC_ct), if(liens_rel_SC_ct = NULL, 0, liens_rel_SC_ct), if(liens_unrel_CJ_ct = NULL, 0, liens_unrel_CJ_ct), if(liens_rel_CJ_ct = NULL, 0, liens_rel_CJ_ct), if(liens_unrel_FT_ct = NULL, 0, liens_unrel_FT_ct), if(liens_rel_FT_ct = NULL, 0, liens_rel_FT_ct), if(liens_unrel_OT_ct = NULL, 0, liens_unrel_OT_ct), if(liens_rel_OT_ct = NULL, 0, liens_rel_OT_ct), if(liens_unrel_ST_ct = NULL, 0, liens_unrel_ST_ct), if(liens_rel_ST_ct = NULL, 0, liens_rel_ST_ct), if(liens_unrel_FC_ct = NULL, 0, liens_unrel_FC_ct), if(liens_rel_FC_ct = NULL, 0, liens_rel_FC_ct), if(liens_unrel_O_ct = NULL, 0, liens_unrel_O_ct), if(liens_rel_O_ct = NULL, 0, liens_rel_O_ct)));

has_derog := if(felony_count > 0 or criminal_count > 0 or stl_inq_count24 > 0 or attr_eviction_count > 0 or liens_unrel_CJ_ct > 0 or liens_rel_CJ_ct > 0 or liens_unrel_SC_ct > 0 or liens_rel_SC_ct > 0 or liens_unrel_FC_ct > 0 or liens_rel_FC_ct > 0 or liens_unrel_O_ct > 0 or liens_rel_O_ct > 0 or tot_liens - tot_liens_w_type > 0 or bk_dismissed_recent_count > 0 or bk_dismissed_historical_count > 0, 1, 0);

rv50_seg_hd_subprime := map(
    (Boolean)has_derog                                        => '2 DEROG',
    add_input_naprop = 4 or property_owned_total > 0 => '3 OWNER',
                                                        '4 OTHER');

derog_seg := rv50_seg_hd_subprime = '2 DEROG';

owner_seg := rv50_seg_hd_subprime = '3 OWNER';

other_seg := rv50_seg_hd_subprime = '4 OTHER';

sysdate := common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01'));

iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');

rv_f03_input_add_not_most_rec := if(not(truedid and add_input_pop), ' ', (string)(integer)rc_input_addr_not_most_recent);

_criminal_last_date := common.sas_date((string)(criminal_last_date));

rv_d32_mos_since_crim_ls := map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => -1,
                                  min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240));

rv_c21_stl_inq_count := if(not(truedid), NULL, min(if(STL_Inq_count = NULL, -NULL, STL_Inq_count), 999));

rv_d33_eviction_count := if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999));

_header_first_seen := common.sas_date((string)(header_first_seen));

rv_c10_m_hdr_fs := map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => -1,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));

rv_f01_inp_addr_not_verified := if(not(add_input_pop and truedid), NULL, (Integer)add_input_addr_not_verified);

rv_ever_asset_owner := map(
    not(truedid)                                                                                                                                                                                                 => '',
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 or watercraft_count > 0 or attr_num_aircraft > 0 => '1',
                                                                                                                                                                                                                    '0');

rv_i60_inq_count12 := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));

rv_i60_inq_hiriskcred_count12 := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));

rv_c13_attr_addrs_recency := map(
    not(truedid)      => NULL,
    (Boolean)attr_addrs_last30 => 1,
    (Boolean)attr_addrs_last90 => 3,
    (Boolean)attr_addrs_last12 => 12,
    (Boolean)attr_addrs_last24 => 24,
    (Boolean)attr_addrs_last36 => 36,
    (Boolean)addrs_5yr         => 60,
    (Boolean)addrs_10yr        => 120,
    (Boolean)addrs_15yr        => 180,
     addrs_per_adl > 0 => 999,
                         0);

rv_a49_curr_add_avm_pct_chg_2yr := map(
    not((boolean)(integer)add_curr_pop)                       => NULL,
    add_curr_lres < 12 * 2                                    => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_3 > 0 => add_curr_avm_auto_val / add_curr_avm_auto_val_3,
                                                                 NULL);

rv_f01_inp_addr_address_score := if(not((boolean)(integer)add_input_pop and truedid), NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));

rv_a46_curr_avm_autoval := if(not(truedid), NULL, add_curr_avm_auto_val);

rv_a41_prop_owner_inp_only := map(
    not(truedid)                                => '',
    add_input_naprop = 4 or add_curr_naprop = 4 => '1',
                                                   '0');

rv_i62_inq_phones_per_adl := if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999));

rv_i60_inq_comm_count12 := if(not(truedid), NULL, min(if(inq_communications_count12 = NULL, -NULL, inq_communications_count12), 999));

rv_a50_pb_average_dollars := map(
    not(truedid)              => NULL,
    pb_average_dollars = '' => -1,
                                 (Integer)pb_average_dollars);

rv_c13_inp_addr_lres := if(not((boolean)(integer)add_input_pop and truedid), NULL, min(if(add_input_lres = NULL, -NULL, add_input_lres), 999));

sp2_subscore0 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 0.197856,
    1 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 2   => -0.01078,
    2 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 3   => -0.195651,
    3 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 4   => -0.212444,
    4 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 7   => -0.38195,
    7 <= rv_i60_inq_count12                              => -0.631214,
                                                            0);

sp2_subscore1 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 5   => 0,
    5 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 82    => -0.466309,
    82 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 119  => -0.177247,
    119 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 246 => -0.176517,
    246 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 282 => -0.005452,
    282 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 302 => 0.137356,
    302 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 332 => 0.198734,
    332 <= rv_c10_m_hdr_fs                           => 0.320829,
                                                        0);

sp2_subscore2 := map(
    NULL < rv_d33_eviction_count AND rv_d33_eviction_count < 1 => 0.084408,
    1 <= rv_d33_eviction_count AND rv_d33_eviction_count < 2   => -0.106422,
    2 <= rv_d33_eviction_count AND rv_d33_eviction_count < 3   => -0.401863,
    3 <= rv_d33_eviction_count                                 => -0.705277,
                                                                  0);

sp2_subscore3 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 0.045965,
    1 <= rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 2   => -0.236572,
    2 <= rv_c21_stl_inq_count                                => -0.733083,
                                                                0);

sp2_subscore4 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 0.032466,
    1 <= rv_i60_inq_hiriskcred_count12                                         => -0.705965,
                                                                                  0);

sp2_subscore5 := map(
    (rv_c13_attr_addrs_recency in [0, 1])                   => -0.447294,
    (rv_c13_attr_addrs_recency in [3, 12, 24, 36, 60, 120]) => -0.004055,
    (rv_c13_attr_addrs_recency in [180, 999])               => 0.232906,
                                                               0);

sp2_subscore6 := map(
    (rv_ever_asset_owner in ['0']) => -0.117645,
    (rv_ever_asset_owner in ['1']) => 0.0745,
                                      0);

sp2_subscore7 := map(
    //(rv_f01_inp_addr_not_verified in [' ']) => 0,
    (rv_f01_inp_addr_not_verified in [0]) => 0.02163,
    (rv_f01_inp_addr_not_verified in [1]) => -0.347026,
                                               0);

sp2_subscore8 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 0 => 0.024891,
    0 <= rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 19  => -0.348441,
    19 <= rv_d32_mos_since_crim_ls                                   => -0.025735,
                                                                        0);

sp2_subscore9 := map(
    (rv_f03_input_add_not_most_rec in [' ']) => 0,
    (rv_f03_input_add_not_most_rec in ['0']) => 0.02264,
    (rv_f03_input_add_not_most_rec in ['1']) => -0.146631,
                                                0);

sp2_subscore10 := map(
    NULL < rv_a49_curr_add_avm_pct_chg_2yr AND rv_a49_curr_add_avm_pct_chg_2yr < 1 => -0.09352,
    1 <= rv_a49_curr_add_avm_pct_chg_2yr                                           => 0.101637,
                                                                                      0);

sp2_rawscore := sp2_subscore0 +
    sp2_subscore1 +
    sp2_subscore2 +
    sp2_subscore3 +
    sp2_subscore4 +
    sp2_subscore5 +
    sp2_subscore6 +
    sp2_subscore7 +
    sp2_subscore8 +
    sp2_subscore9 +
    sp2_subscore10;

sp2_lnoddsscore := sp2_rawscore + 1.382382;

sp2_probscore := exp(sp2_lnoddsscore) / (1 + exp(sp2_lnoddsscore));

sp2_aacd_0 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 'I60',
    1 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 2   => 'I60',
    2 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 3   => 'I60',
    3 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 4   => 'I60',
    4 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 7   => 'I60',
    7 <= rv_i60_inq_count12                              => 'I60',
                                                            '');

sp2_dist_0 := sp2_subscore0 - 0.197856;

sp2_aacd_1 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 5   => 'C10',
    5 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 82    => 'C10',
    82 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 119  => 'C10',
    119 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 246 => 'C10',
    246 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 282 => 'C10',
    282 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 302 => 'C10',
    302 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 332 => 'C10',
    332 <= rv_c10_m_hdr_fs                           => 'C10',
                                                        '');

sp2_dist_1 := sp2_subscore1 - 0.320829;

sp2_aacd_2 := map(
    NULL < rv_d33_eviction_count AND rv_d33_eviction_count < 1 => 'D33',
    1 <= rv_d33_eviction_count AND rv_d33_eviction_count < 2   => 'D33',
    2 <= rv_d33_eviction_count AND rv_d33_eviction_count < 3   => 'D33',
    3 <= rv_d33_eviction_count                                 => 'D33',
                                                                  '');

sp2_dist_2 := sp2_subscore2 - 0.084408;

sp2_aacd_3 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 'C21',
    1 <= rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 2   => 'C21',
    2 <= rv_c21_stl_inq_count                                => 'C21',
                                                                '');

sp2_dist_3 := sp2_subscore3 - 0.045965;

sp2_aacd_4 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 'I60',
    1 <= rv_i60_inq_hiriskcred_count12                                         => 'I60',
                                                                                  '');

sp2_dist_4 := sp2_subscore4 - 0.032466;

sp2_aacd_5 := map(
    (rv_c13_attr_addrs_recency in [0, 1])                   => 'C13',
    (rv_c13_attr_addrs_recency in [3, 12, 24, 36, 60, 120]) => 'C13',
    (rv_c13_attr_addrs_recency in [180, 999])               => 'C13',
                                                               '');

sp2_dist_5 := sp2_subscore5 - 0.232906;

sp2_aacd_6 := map(
    (rv_ever_asset_owner in ['0']) => 'A40',
    (rv_ever_asset_owner in ['1']) => 'A40',
                                      '');

sp2_dist_6 := sp2_subscore6 - 0.0745;

sp2_aacd_7 := map(
    //(rv_f01_inp_addr_not_verified in [' ']) => '',
    (rv_f01_inp_addr_not_verified in [0]) => 'F01',
    (rv_f01_inp_addr_not_verified in [1]) => 'F01',
                                               '');

sp2_dist_7 := sp2_subscore7 - 0.02163;

sp2_aacd_8 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 0 => 'D32',
    0 <= rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 19  => 'D32',
    19 <= rv_d32_mos_since_crim_ls                                   => 'D32',
                                                                        '');

sp2_dist_8 := sp2_subscore8 - 0.024891;

sp2_aacd_9 := map(
    (rv_f03_input_add_not_most_rec in [' ']) => '',
    (rv_f03_input_add_not_most_rec in ['0']) => 'F03',
    (rv_f03_input_add_not_most_rec in ['1']) => 'F03',
                                                '');

sp2_dist_9 := sp2_subscore9 - 0.02264;

sp2_aacd_10 := map(
    NULL < rv_a49_curr_add_avm_pct_chg_2yr AND rv_a49_curr_add_avm_pct_chg_2yr < 1 => 'A49',
    1 <= rv_a49_curr_add_avm_pct_chg_2yr                                           => 'A49',
                                                                                      '');

sp2_dist_10 := sp2_subscore10 - 0.101637;

sp2_rcvaluec21 := (integer)(sp2_aacd_0 = 'C21') * sp2_dist_0 +
    (integer)(sp2_aacd_1 = 'C21') * sp2_dist_1 +
    (integer)(sp2_aacd_2 = 'C21') * sp2_dist_2 +
    (integer)(sp2_aacd_3 = 'C21') * sp2_dist_3 +
    (integer)(sp2_aacd_4 = 'C21') * sp2_dist_4 +
    (integer)(sp2_aacd_5 = 'C21') * sp2_dist_5 +
    (integer)(sp2_aacd_6 = 'C21') * sp2_dist_6 +
    (integer)(sp2_aacd_7 = 'C21') * sp2_dist_7 +
    (integer)(sp2_aacd_8 = 'C21') * sp2_dist_8 +
    (integer)(sp2_aacd_9 = 'C21') * sp2_dist_9 +
    (integer)(sp2_aacd_10 = 'C21') * sp2_dist_10;

sp2_rcvaluef03 := (integer)(sp2_aacd_0 = 'F03') * sp2_dist_0 +
    (integer)(sp2_aacd_1 = 'F03') * sp2_dist_1 +
    (integer)(sp2_aacd_2 = 'F03') * sp2_dist_2 +
    (integer)(sp2_aacd_3 = 'F03') * sp2_dist_3 +
    (integer)(sp2_aacd_4 = 'F03') * sp2_dist_4 +
    (integer)(sp2_aacd_5 = 'F03') * sp2_dist_5 +
    (integer)(sp2_aacd_6 = 'F03') * sp2_dist_6 +
    (integer)(sp2_aacd_7 = 'F03') * sp2_dist_7 +
    (integer)(sp2_aacd_8 = 'F03') * sp2_dist_8 +
    (integer)(sp2_aacd_9 = 'F03') * sp2_dist_9 +
    (integer)(sp2_aacd_10 = 'F03') * sp2_dist_10;

sp2_rcvalued32 := (integer)(sp2_aacd_0 = 'D32') * sp2_dist_0 +
    (integer)(sp2_aacd_1 = 'D32') * sp2_dist_1 +
    (integer)(sp2_aacd_2 = 'D32') * sp2_dist_2 +
    (integer)(sp2_aacd_3 = 'D32') * sp2_dist_3 +
    (integer)(sp2_aacd_4 = 'D32') * sp2_dist_4 +
    (integer)(sp2_aacd_5 = 'D32') * sp2_dist_5 +
    (integer)(sp2_aacd_6 = 'D32') * sp2_dist_6 +
    (integer)(sp2_aacd_7 = 'D32') * sp2_dist_7 +
    (integer)(sp2_aacd_8 = 'D32') * sp2_dist_8 +
    (integer)(sp2_aacd_9 = 'D32') * sp2_dist_9 +
    (integer)(sp2_aacd_10 = 'D32') * sp2_dist_10;

sp2_rcvalued33 := (integer)(sp2_aacd_0 = 'D33') * sp2_dist_0 +
    (integer)(sp2_aacd_1 = 'D33') * sp2_dist_1 +
    (integer)(sp2_aacd_2 = 'D33') * sp2_dist_2 +
    (integer)(sp2_aacd_3 = 'D33') * sp2_dist_3 +
    (integer)(sp2_aacd_4 = 'D33') * sp2_dist_4 +
    (integer)(sp2_aacd_5 = 'D33') * sp2_dist_5 +
    (integer)(sp2_aacd_6 = 'D33') * sp2_dist_6 +
    (integer)(sp2_aacd_7 = 'D33') * sp2_dist_7 +
    (integer)(sp2_aacd_8 = 'D33') * sp2_dist_8 +
    (integer)(sp2_aacd_9 = 'D33') * sp2_dist_9 +
    (integer)(sp2_aacd_10 = 'D33') * sp2_dist_10;

sp2_rcvaluei60 := (integer)(sp2_aacd_0 = 'I60') * sp2_dist_0 +
    (integer)(sp2_aacd_1 = 'I60') * sp2_dist_1 +
    (integer)(sp2_aacd_2 = 'I60') * sp2_dist_2 +
    (integer)(sp2_aacd_3 = 'I60') * sp2_dist_3 +
    (integer)(sp2_aacd_4 = 'I60') * sp2_dist_4 +
    (integer)(sp2_aacd_5 = 'I60') * sp2_dist_5 +
    (integer)(sp2_aacd_6 = 'I60') * sp2_dist_6 +
    (integer)(sp2_aacd_7 = 'I60') * sp2_dist_7 +
    (integer)(sp2_aacd_8 = 'I60') * sp2_dist_8 +
    (integer)(sp2_aacd_9 = 'I60') * sp2_dist_9 +
    (integer)(sp2_aacd_10 = 'I60') * sp2_dist_10;

sp2_rcvaluea40 := (integer)(sp2_aacd_0 = 'A40') * sp2_dist_0 +
    (integer)(sp2_aacd_1 = 'A40') * sp2_dist_1 +
    (integer)(sp2_aacd_2 = 'A40') * sp2_dist_2 +
    (integer)(sp2_aacd_3 = 'A40') * sp2_dist_3 +
    (integer)(sp2_aacd_4 = 'A40') * sp2_dist_4 +
    (integer)(sp2_aacd_5 = 'A40') * sp2_dist_5 +
    (integer)(sp2_aacd_6 = 'A40') * sp2_dist_6 +
    (integer)(sp2_aacd_7 = 'A40') * sp2_dist_7 +
    (integer)(sp2_aacd_8 = 'A40') * sp2_dist_8 +
    (integer)(sp2_aacd_9 = 'A40') * sp2_dist_9 +
    (integer)(sp2_aacd_10 = 'A40') * sp2_dist_10;

sp2_rcvaluec13 := (integer)(sp2_aacd_0 = 'C13') * sp2_dist_0 +
    (integer)(sp2_aacd_1 = 'C13') * sp2_dist_1 +
    (integer)(sp2_aacd_2 = 'C13') * sp2_dist_2 +
    (integer)(sp2_aacd_3 = 'C13') * sp2_dist_3 +
    (integer)(sp2_aacd_4 = 'C13') * sp2_dist_4 +
    (integer)(sp2_aacd_5 = 'C13') * sp2_dist_5 +
    (integer)(sp2_aacd_6 = 'C13') * sp2_dist_6 +
    (integer)(sp2_aacd_7 = 'C13') * sp2_dist_7 +
    (integer)(sp2_aacd_8 = 'C13') * sp2_dist_8 +
    (integer)(sp2_aacd_9 = 'C13') * sp2_dist_9 +
    (integer)(sp2_aacd_10 = 'C13') * sp2_dist_10;

sp2_rcvaluef01 := (integer)(sp2_aacd_0 = 'F01') * sp2_dist_0 +
    (integer)(sp2_aacd_1 = 'F01') * sp2_dist_1 +
    (integer)(sp2_aacd_2 = 'F01') * sp2_dist_2 +
    (integer)(sp2_aacd_3 = 'F01') * sp2_dist_3 +
    (integer)(sp2_aacd_4 = 'F01') * sp2_dist_4 +
    (integer)(sp2_aacd_5 = 'F01') * sp2_dist_5 +
    (integer)(sp2_aacd_6 = 'F01') * sp2_dist_6 +
    (integer)(sp2_aacd_7 = 'F01') * sp2_dist_7 +
    (integer)(sp2_aacd_8 = 'F01') * sp2_dist_8 +
    (integer)(sp2_aacd_9 = 'F01') * sp2_dist_9 +
    (integer)(sp2_aacd_10 = 'F01') * sp2_dist_10;

sp2_rcvaluec10 := (integer)(sp2_aacd_0 = 'C10') * sp2_dist_0 +
    (integer)(sp2_aacd_1 = 'C10') * sp2_dist_1 +
    (integer)(sp2_aacd_2 = 'C10') * sp2_dist_2 +
    (integer)(sp2_aacd_3 = 'C10') * sp2_dist_3 +
    (integer)(sp2_aacd_4 = 'C10') * sp2_dist_4 +
    (integer)(sp2_aacd_5 = 'C10') * sp2_dist_5 +
    (integer)(sp2_aacd_6 = 'C10') * sp2_dist_6 +
    (integer)(sp2_aacd_7 = 'C10') * sp2_dist_7 +
    (integer)(sp2_aacd_8 = 'C10') * sp2_dist_8 +
    (integer)(sp2_aacd_9 = 'C10') * sp2_dist_9 +
    (integer)(sp2_aacd_10 = 'C10') * sp2_dist_10;

sp2_rcvaluea49 := (integer)(sp2_aacd_0 = 'A49') * sp2_dist_0 +
    (integer)(sp2_aacd_1 = 'A49') * sp2_dist_1 +
    (integer)(sp2_aacd_2 = 'A49') * sp2_dist_2 +
    (integer)(sp2_aacd_3 = 'A49') * sp2_dist_3 +
    (integer)(sp2_aacd_4 = 'A49') * sp2_dist_4 +
    (integer)(sp2_aacd_5 = 'A49') * sp2_dist_5 +
    (integer)(sp2_aacd_6 = 'A49') * sp2_dist_6 +
    (integer)(sp2_aacd_7 = 'A49') * sp2_dist_7 +
    (integer)(sp2_aacd_8 = 'A49') * sp2_dist_8 +
    (integer)(sp2_aacd_9 = 'A49') * sp2_dist_9 +
    (integer)(sp2_aacd_10 = 'A49') * sp2_dist_10;

sp3_subscore0 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 155 => -0.472725,
    155 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 216 => -0.302696,
    216 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 276 => -0.081487,
    276 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 293 => 0.171273,
    293 <= rv_c10_m_hdr_fs                           => 0.231161,
                                                        0);

sp3_subscore1 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 0.150872,
    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => -0.146246,
    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => -0.365569,
    3 <= rv_i62_inq_phones_per_adl                                     => -0.816043,
                                                                          0);

sp3_subscore2 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 41380     => -0.087108,
    41380 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 87913   => -0.049145,
    87913 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 173860  => -0.004706,
    173860 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 269560 => 0.304296,
    269560 <= rv_a46_curr_avm_autoval                                      => 0.447508,
                                                                              0);

sp3_subscore3 := map(
    (rv_a41_prop_owner_inp_only in [' ']) => 0,
    (rv_a41_prop_owner_inp_only in ['0']) => -0.176311,
    (rv_a41_prop_owner_inp_only in ['1']) => 0.089898,
                                             0);

sp3_subscore4 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100 => -0.192575,
    100 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 255 => 0.028301,
    255 <= rv_f01_inp_addr_address_score                                         => 0,
                                                                                    0);

sp3_subscore5 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 0.011567,
    1 <= rv_i60_inq_hiriskcred_count12                                         => -0.481611,
                                                                                  0);

sp3_rawscore := sp3_subscore0 +
    sp3_subscore1 +
    sp3_subscore2 +
    sp3_subscore3 +
    sp3_subscore4 +
    sp3_subscore5;

sp3_lnoddsscore := sp3_rawscore + 1.810065;

sp3_probscore := exp(sp3_lnoddsscore) / (1 + exp(sp3_lnoddsscore));

sp3_aacd_0 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 155 => 'C10',
    155 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 216 => 'C10',
    216 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 276 => 'C10',
    276 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 293 => 'C10',
    293 <= rv_c10_m_hdr_fs                           => 'C10',
                                                        'C10');

sp3_dist_0 := sp3_subscore0 - 0.231161;

sp3_aacd_1 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 'I62',
    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => 'I62',
    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => 'I62',
    3 <= rv_i62_inq_phones_per_adl                                     => 'I62',
                                                                          '');

sp3_dist_1 := sp3_subscore1 - 0.150872;

sp3_aacd_2 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 41380     => 'A46',
    41380 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 87913   => 'A46',
    87913 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 173860  => 'A46',
    173860 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 269560 => 'A46',
    269560 <= rv_a46_curr_avm_autoval                                      => 'A46',
                                                                              '');

sp3_dist_2 := sp3_subscore2 - 0.447508;

sp3_aacd_3 := map(
    (rv_a41_prop_owner_inp_only in [' ']) => '',
    (rv_a41_prop_owner_inp_only in ['0']) => 'A41',
    (rv_a41_prop_owner_inp_only in ['1']) => 'A41',
                                             '');

sp3_dist_3 := sp3_subscore3 - 0.089898;

sp3_aacd_4 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100 => 'F01',
    100 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 255 => 'F01',
    255 <= rv_f01_inp_addr_address_score                                         => 'F01',
                                                                                    '');

sp3_dist_4 := sp3_subscore4 - 0.028301;

sp3_aacd_5 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 'I60',
    1 <= rv_i60_inq_hiriskcred_count12                                         => 'I60',
                                                                                  '');

sp3_dist_5 := sp3_subscore5 - 0.011567;

sp3_rcvaluea46 := (integer)(sp3_aacd_0 = 'A46') * sp3_dist_0 +
    (integer)(sp3_aacd_1 = 'A46') * sp3_dist_1 +
    (integer)(sp3_aacd_2 = 'A46') * sp3_dist_2 +
    (integer)(sp3_aacd_3 = 'A46') * sp3_dist_3 +
    (integer)(sp3_aacd_4 = 'A46') * sp3_dist_4 +
    (integer)(sp3_aacd_5 = 'A46') * sp3_dist_5;

sp3_rcvaluei60 := (integer)(sp3_aacd_0 = 'I60') * sp3_dist_0 +
    (integer)(sp3_aacd_1 = 'I60') * sp3_dist_1 +
    (integer)(sp3_aacd_2 = 'I60') * sp3_dist_2 +
    (integer)(sp3_aacd_3 = 'I60') * sp3_dist_3 +
    (integer)(sp3_aacd_4 = 'I60') * sp3_dist_4 +
    (integer)(sp3_aacd_5 = 'I60') * sp3_dist_5;

sp3_rcvaluei62 := (integer)(sp3_aacd_0 = 'I62') * sp3_dist_0 +
    (integer)(sp3_aacd_1 = 'I62') * sp3_dist_1 +
    (integer)(sp3_aacd_2 = 'I62') * sp3_dist_2 +
    (integer)(sp3_aacd_3 = 'I62') * sp3_dist_3 +
    (integer)(sp3_aacd_4 = 'I62') * sp3_dist_4 +
    (integer)(sp3_aacd_5 = 'I62') * sp3_dist_5;

sp3_rcvaluea41 := (integer)(sp3_aacd_0 = 'A41') * sp3_dist_0 +
    (integer)(sp3_aacd_1 = 'A41') * sp3_dist_1 +
    (integer)(sp3_aacd_2 = 'A41') * sp3_dist_2 +
    (integer)(sp3_aacd_3 = 'A41') * sp3_dist_3 +
    (integer)(sp3_aacd_4 = 'A41') * sp3_dist_4 +
    (integer)(sp3_aacd_5 = 'A41') * sp3_dist_5;

sp3_rcvaluef01 := (integer)(sp3_aacd_0 = 'F01') * sp3_dist_0 +
    (integer)(sp3_aacd_1 = 'F01') * sp3_dist_1 +
    (integer)(sp3_aacd_2 = 'F01') * sp3_dist_2 +
    (integer)(sp3_aacd_3 = 'F01') * sp3_dist_3 +
    (integer)(sp3_aacd_4 = 'F01') * sp3_dist_4 +
    (integer)(sp3_aacd_5 = 'F01') * sp3_dist_5;

sp3_rcvaluec10 := (integer)(sp3_aacd_0 = 'C10') * sp3_dist_0 +
    (integer)(sp3_aacd_1 = 'C10') * sp3_dist_1 +
    (integer)(sp3_aacd_2 = 'C10') * sp3_dist_2 +
    (integer)(sp3_aacd_3 = 'C10') * sp3_dist_3 +
    (integer)(sp3_aacd_4 = 'C10') * sp3_dist_4 +
    (integer)(sp3_aacd_5 = 'C10') * sp3_dist_5;

sp4_subscore0 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 0.194276,
    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => -0.146648,
    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => -0.534914,
    3 <= rv_i62_inq_phones_per_adl                                     => -0.635906,
                                                                          0);

sp4_subscore1 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 0   => 0,
    0 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 94    => -0.135457,
    94 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 193  => -0.127228,
    193 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 311 => -0.027284,
    311 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 329 => 0.285529,
    329 <= rv_c10_m_hdr_fs                           => 0.502021,
                                                        0);

sp4_subscore2 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 70142    => -0.083847,
    70142 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 118990 => 0.036939,
    118990 <= rv_a46_curr_avm_autoval                                     => 0.221683,
                                                                             0);

sp4_subscore3 := map(
    (rv_ever_asset_owner in [' ']) => 0,
    (rv_ever_asset_owner in ['0']) => -0.071165,
    (rv_ever_asset_owner in ['1']) => 0.205602,
                                      0);

sp4_subscore4 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 0.021078,
    1 <= rv_i60_inq_hiriskcred_count12                                         => -0.658549,
                                                                                  0);

sp4_subscore5 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 0.027526,
    1 <= rv_c21_stl_inq_count                                => -0.419685,
                                                                0);

sp4_subscore6 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 3 => -0.170741,
    3 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 6   => -0.016263,
    6 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 13  => 0.038185,
    13 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 29 => 0.072218,
    29 <= rv_c13_inp_addr_lres                               => 0.073157,
                                                                0);

sp4_subscore7 := map(
    (rv_c13_attr_addrs_recency in [0, 1, 3])    => -0.128398,
    (rv_c13_attr_addrs_recency in [12, 24, 36]) => -0.026825,
    (rv_c13_attr_addrs_recency in [60, 120])    => 0.0439,
    (rv_c13_attr_addrs_recency in [180, 999])   => 0.232426,
                                                   0);

sp4_subscore8 := map(
    NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 0 => -0.082275,
    0 <= rv_a50_pb_average_dollars                                     => 0.078032,
                                                                          0);

sp4_subscore9 := map(
    NULL < rv_i60_inq_comm_count12 AND rv_i60_inq_comm_count12 < 1 => 0.009525,
    1 <= rv_i60_inq_comm_count12                                   => -0.423215,
                                                                      0);

sp4_rawscore := sp4_subscore0 +
    sp4_subscore1 +
    sp4_subscore2 +
    sp4_subscore3 +
    sp4_subscore4 +
    sp4_subscore5 +
    sp4_subscore6 +
    sp4_subscore7 +
    sp4_subscore8 +
    sp4_subscore9;

sp4_lnoddsscore := sp4_rawscore + 1.519368;

sp4_probscore := exp(sp4_lnoddsscore) / (1 + exp(sp4_lnoddsscore));

sp4_aacd_0 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 'I62',
    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => 'I62',
    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => 'I62',
    3 <= rv_i62_inq_phones_per_adl                                     => 'I62',
                                                                          '');

sp4_dist_0 := sp4_subscore0 - 0.194276;

sp4_aacd_1 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 0   => 'C10',
    0 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 94    => 'C10',
    94 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 193  => 'C10',
    193 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 311 => 'C10',
    311 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 329 => 'C10',
    329 <= rv_c10_m_hdr_fs                           => 'C10',
                                                        'C10');

sp4_dist_1 := sp4_subscore1 - 0.502021;

sp4_aacd_2 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 70142    => 'A46',
    70142 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 118990 => 'A46',
    118990 <= rv_a46_curr_avm_autoval                                     => 'A46',
                                                                             '');

sp4_dist_2 := sp4_subscore2 - 0.221683;

sp4_aacd_3 := map(
    (rv_ever_asset_owner in [' ']) => '',
    (rv_ever_asset_owner in ['0']) => 'A40',
    (rv_ever_asset_owner in ['1']) => 'A40',
                                      '');

sp4_dist_3 := sp4_subscore3 - 0.205602;

sp4_aacd_4 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 'I60',
    1 <= rv_i60_inq_hiriskcred_count12                                         => 'I60',
                                                                                  '');

sp4_dist_4 := sp4_subscore4 - 0.021078;

sp4_aacd_5 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 'C21',
    1 <= rv_c21_stl_inq_count                                => 'C21',
                                                                '');

sp4_dist_5 := sp4_subscore5 - 0.027526;

sp4_aacd_6 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 3 => 'C13',
    3 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 6   => 'C13',
    6 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 13  => 'C13',
    13 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 29 => 'C13',
    29 <= rv_c13_inp_addr_lres                               => 'C13',
                                                                '');

sp4_dist_6 := sp4_subscore6 - 0.073157;

sp4_aacd_7 := map(
    (rv_c13_attr_addrs_recency in [0, 1, 3])    => 'C13',
    (rv_c13_attr_addrs_recency in [12, 24, 36]) => 'C13',
    (rv_c13_attr_addrs_recency in [60, 120])    => 'C13',
    (rv_c13_attr_addrs_recency in [180, 999])   => 'C13',
                                                   '');

sp4_dist_7 := sp4_subscore7 - 0.232426;

sp4_aacd_8 := map(
    NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 0 => 'A50',
    0 <= rv_a50_pb_average_dollars                                     => 'A50',
                                                                          '');

// sp4_dist_8 := sp4_subscore8 - 0.078032;
sp4_dist_8 := 0;

sp4_aacd_9 := map(
    NULL < rv_i60_inq_comm_count12 AND rv_i60_inq_comm_count12 < 1 => 'I60',
    1 <= rv_i60_inq_comm_count12                                   => 'I60',
                                                                      '');

sp4_dist_9 := sp4_subscore9 - 0.009525;

sp4_rcvaluec21 := (integer)(sp4_aacd_0 = 'C21') * sp4_dist_0 +
    (integer)(sp4_aacd_1 = 'C21') * sp4_dist_1 +
    (integer)(sp4_aacd_2 = 'C21') * sp4_dist_2 +
    (integer)(sp4_aacd_3 = 'C21') * sp4_dist_3 +
    (integer)(sp4_aacd_4 = 'C21') * sp4_dist_4 +
    (integer)(sp4_aacd_5 = 'C21') * sp4_dist_5 +
    (integer)(sp4_aacd_6 = 'C21') * sp4_dist_6 +
    (integer)(sp4_aacd_7 = 'C21') * sp4_dist_7 +
    (integer)(sp4_aacd_8 = 'C21') * sp4_dist_8 +
    (integer)(sp4_aacd_9 = 'C21') * sp4_dist_9;

sp4_rcvaluei62 := (integer)(sp4_aacd_0 = 'I62') * sp4_dist_0 +
    (integer)(sp4_aacd_1 = 'I62') * sp4_dist_1 +
    (integer)(sp4_aacd_2 = 'I62') * sp4_dist_2 +
    (integer)(sp4_aacd_3 = 'I62') * sp4_dist_3 +
    (integer)(sp4_aacd_4 = 'I62') * sp4_dist_4 +
    (integer)(sp4_aacd_5 = 'I62') * sp4_dist_5 +
    (integer)(sp4_aacd_6 = 'I62') * sp4_dist_6 +
    (integer)(sp4_aacd_7 = 'I62') * sp4_dist_7 +
    (integer)(sp4_aacd_8 = 'I62') * sp4_dist_8 +
    (integer)(sp4_aacd_9 = 'I62') * sp4_dist_9;

sp4_rcvaluea46 := (integer)(sp4_aacd_0 = 'A46') * sp4_dist_0 +
    (integer)(sp4_aacd_1 = 'A46') * sp4_dist_1 +
    (integer)(sp4_aacd_2 = 'A46') * sp4_dist_2 +
    (integer)(sp4_aacd_3 = 'A46') * sp4_dist_3 +
    (integer)(sp4_aacd_4 = 'A46') * sp4_dist_4 +
    (integer)(sp4_aacd_5 = 'A46') * sp4_dist_5 +
    (integer)(sp4_aacd_6 = 'A46') * sp4_dist_6 +
    (integer)(sp4_aacd_7 = 'A46') * sp4_dist_7 +
    (integer)(sp4_aacd_8 = 'A46') * sp4_dist_8 +
    (integer)(sp4_aacd_9 = 'A46') * sp4_dist_9;

sp4_rcvaluea50 := (integer)(sp4_aacd_0 = 'A50') * sp4_dist_0 +
    (integer)(sp4_aacd_1 = 'A50') * sp4_dist_1 +
    (integer)(sp4_aacd_2 = 'A50') * sp4_dist_2 +
    (integer)(sp4_aacd_3 = 'A50') * sp4_dist_3 +
    (integer)(sp4_aacd_4 = 'A50') * sp4_dist_4 +
    (integer)(sp4_aacd_5 = 'A50') * sp4_dist_5 +
    (integer)(sp4_aacd_6 = 'A50') * sp4_dist_6 +
    (integer)(sp4_aacd_7 = 'A50') * sp4_dist_7 +
    (integer)(sp4_aacd_8 = 'A50') * sp4_dist_8 +
    (integer)(sp4_aacd_9 = 'A50') * sp4_dist_9;

sp4_rcvaluei60 := (integer)(sp4_aacd_0 = 'I60') * sp4_dist_0 +
    (integer)(sp4_aacd_1 = 'I60') * sp4_dist_1 +
    (integer)(sp4_aacd_2 = 'I60') * sp4_dist_2 +
    (integer)(sp4_aacd_3 = 'I60') * sp4_dist_3 +
    (integer)(sp4_aacd_4 = 'I60') * sp4_dist_4 +
    (integer)(sp4_aacd_5 = 'I60') * sp4_dist_5 +
    (integer)(sp4_aacd_6 = 'I60') * sp4_dist_6 +
    (integer)(sp4_aacd_7 = 'I60') * sp4_dist_7 +
    (integer)(sp4_aacd_8 = 'I60') * sp4_dist_8 +
    (integer)(sp4_aacd_9 = 'I60') * sp4_dist_9;

sp4_rcvaluea40 := (integer)(sp4_aacd_0 = 'A40') * sp4_dist_0 +
    (integer)(sp4_aacd_1 = 'A40') * sp4_dist_1 +
    (integer)(sp4_aacd_2 = 'A40') * sp4_dist_2 +
    (integer)(sp4_aacd_3 = 'A40') * sp4_dist_3 +
    (integer)(sp4_aacd_4 = 'A40') * sp4_dist_4 +
    (integer)(sp4_aacd_5 = 'A40') * sp4_dist_5 +
    (integer)(sp4_aacd_6 = 'A40') * sp4_dist_6 +
    (integer)(sp4_aacd_7 = 'A40') * sp4_dist_7 +
    (integer)(sp4_aacd_8 = 'A40') * sp4_dist_8 +
    (integer)(sp4_aacd_9 = 'A40') * sp4_dist_9;

sp4_rcvaluec13 := (integer)(sp4_aacd_0 = 'C13') * sp4_dist_0 +
    (integer)(sp4_aacd_1 = 'C13') * sp4_dist_1 +
    (integer)(sp4_aacd_2 = 'C13') * sp4_dist_2 +
    (integer)(sp4_aacd_3 = 'C13') * sp4_dist_3 +
    (integer)(sp4_aacd_4 = 'C13') * sp4_dist_4 +
    (integer)(sp4_aacd_5 = 'C13') * sp4_dist_5 +
    (integer)(sp4_aacd_6 = 'C13') * sp4_dist_6 +
    (integer)(sp4_aacd_7 = 'C13') * sp4_dist_7 +
    (integer)(sp4_aacd_8 = 'C13') * sp4_dist_8 +
    (integer)(sp4_aacd_9 = 'C13') * sp4_dist_9;

sp4_rcvaluec10 := (integer)(sp4_aacd_0 = 'C10') * sp4_dist_0 +
    (integer)(sp4_aacd_1 = 'C10') * sp4_dist_1 +
    (integer)(sp4_aacd_2 = 'C10') * sp4_dist_2 +
    (integer)(sp4_aacd_3 = 'C10') * sp4_dist_3 +
    (integer)(sp4_aacd_4 = 'C10') * sp4_dist_4 +
    (integer)(sp4_aacd_5 = 'C10') * sp4_dist_5 +
    (integer)(sp4_aacd_6 = 'C10') * sp4_dist_6 +
    (integer)(sp4_aacd_7 = 'C10') * sp4_dist_7 +
    (integer)(sp4_aacd_8 = 'C10') * sp4_dist_8 +
    (integer)(sp4_aacd_9 = 'C10') * sp4_dist_9;

probscore := if(max((integer)derog_seg * sp2_probscore, (integer)owner_seg * sp3_probscore, (integer)other_seg * sp4_probscore) = NULL, NULL, sum(if((integer)derog_seg * sp2_probscore = NULL, 0, (integer)derog_seg * sp2_probscore), if((integer)owner_seg * sp3_probscore = NULL, 0, (integer)owner_seg * sp3_probscore), if((integer)other_seg * sp4_probscore = NULL, 0, (integer)other_seg * sp4_probscore)));

base := 700;

pts := 50;

odds := (1 - .064) / .064;

deceased := map(
    rc_decsflag = '1'                                                        => 1,
    rc_ssndod != 0                                                         => 1,
    contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 => 2,
                                                                              0);

rva1601_1_0 := map(
    deceased > 0          => 200,
    iv_rv5_unscorable = '1' => 222,
                             min(if(max(round(pts * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 501)), 900));

_rc_seg_c88 := map(
    felony_count > 0 or criminal_count > 0                                                                                                                                                                                         => 'D32',
    stl_inq_count12 > 0                                                                                                                                                                                                            => 'C21',
    attr_eviction_count > 0                                                                                                                                                                                                        => 'D33',
    liens_unrel_CJ_ct > 0 or liens_rel_CJ_ct > 0 or liens_unrel_SC_ct > 0 or liens_rel_SC_ct > 0 or liens_unrel_FC_ct > 0 or liens_rel_FC_ct > 0 or liens_unrel_O_ct > 0 or liens_rel_O_ct > 0 or tot_liens - tot_liens_w_type > 0 => 'D34',
    bk_dismissed_recent_count     > 0 or bk_dismissed_historical_count > 0                                                                                                                                                          => 'D31',
																																																																																																																			'');

_rc_seg := map(
    derog_seg => _rc_seg_c88,
    owner_seg => 'C12',
									'');


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};


 
//*************************************************************************************//
rc_dataset_sp2 := DATASET([
    {'C21', sp2_rcvalueC21},
    {'F03', sp2_rcvalueF03},
    {'D32', sp2_rcvalueD32},
    {'D33', sp2_rcvalueD33},
    {'I60', sp2_rcvalueI60},
    {'A40', sp2_rcvalueA40},
    {'C13', sp2_rcvalueC13},
    {'F01', sp2_rcvalueF01},
    {'C10', sp2_rcvalueC10},
    {'A49', sp2_rcvalueA49}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_sp2_sorted := sort(rc_dataset_sp2, rc_dataset_sp2.value);

sp2_rc1 := rc_dataset_sp2_sorted[1].rc;
sp2_rc2 := rc_dataset_sp2_sorted[2].rc;
sp2_rc3 := rc_dataset_sp2_sorted[3].rc;
sp2_rc4 := rc_dataset_sp2_sorted[4].rc;

sp2_vl1 := rc_dataset_sp2_sorted[1].value;
sp2_vl2 := rc_dataset_sp2_sorted[2].value;
sp2_vl3 := rc_dataset_sp2_sorted[3].value;
sp2_vl4 := rc_dataset_sp2_sorted[4].value;
//*************************************************************************************//

 
//*************************************************************************************//
rc_dataset_sp3 := DATASET([
    {'A46', sp3_rcvalueA46},
    {'I60', sp3_rcvalueI60},
    {'I62', sp3_rcvalueI62},
    {'A41', sp3_rcvalueA41},
    {'F01', sp3_rcvalueF01},
    {'C10', sp3_rcvalueC10}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_sp3_sorted := sort(rc_dataset_sp3, rc_dataset_sp3.value);

sp3_rc1 := rc_dataset_sp3_sorted[1].rc;
sp3_rc2 := rc_dataset_sp3_sorted[2].rc;
sp3_rc3 := rc_dataset_sp3_sorted[3].rc;
sp3_rc4 := rc_dataset_sp3_sorted[4].rc;

sp3_vl1 := rc_dataset_sp3_sorted[1].value;
sp3_vl2 := rc_dataset_sp3_sorted[2].value;
sp3_vl3 := rc_dataset_sp3_sorted[3].value;
sp3_vl4 := rc_dataset_sp3_sorted[4].value;
//*************************************************************************************//

 
//*************************************************************************************//
rc_dataset_sp4 := DATASET([
    {'C21', sp4_rcvalueC21},
    {'I62', sp4_rcvalueI62},
    {'A46', sp4_rcvalueA46},
    {'A50', sp4_rcvalueA50},
    {'I60', sp4_rcvalueI60},
    {'A40', sp4_rcvalueA40},
    {'C13', sp4_rcvalueC13},
    {'C10', sp4_rcvalueC10}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_sp4_sorted := sort(rc_dataset_sp4, rc_dataset_sp4.value);

sp4_rc1 := rc_dataset_sp4_sorted[1].rc;
sp4_rc2 := rc_dataset_sp4_sorted[2].rc;
sp4_rc3 := rc_dataset_sp4_sorted[3].rc;
sp4_rc4 := rc_dataset_sp4_sorted[4].rc;

sp4_vl1 := rc_dataset_sp4_sorted[1].value;
sp4_vl2 := rc_dataset_sp4_sorted[2].value;
sp4_vl3 := rc_dataset_sp4_sorted[3].value;
sp4_vl4 := rc_dataset_sp4_sorted[4].value;
//*************************************************************************************//

rc3_2 := map(
    derog_seg => sp2_rc3,
    owner_seg => sp3_rc3,
                 sp4_rc3);

rc4_2 := map(
    derog_seg => sp2_rc4,
    owner_seg => sp3_rc4,
                 sp4_rc4);

rc1_3 := map(
    derog_seg => sp2_rc1,
    owner_seg => sp3_rc1,
                 sp4_rc1);

rc2_2 := map(
    derog_seg => sp2_rc2,
    owner_seg => sp3_rc2,
                 sp4_rc2);

rc1_2 := if(trim(rc1_3, ALL) = '', _rc_seg, rc1_3);

_rc_inq := map(
    derog_seg and rv_i60_inq_hiriskcred_count12 > 0 => 'I60',
    derog_seg and rv_i60_inq_count12 > 0            => 'I60',
    owner_seg and rv_i62_inq_phones_per_adl > 0     => 'I62',
    owner_seg and rv_i60_inq_hiriskcred_count12 > 0 => 'I60',
    other_seg and rv_i62_inq_phones_per_adl > 0     => 'I62',
    other_seg and rv_i60_inq_hiriskcred_count12 > 0 => 'I60',
    other_seg and rv_i60_inq_comm_count12 > 0       => 'I60',
                                                       '');

rc5_c93 := map(
    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim(rc2_2, LEFT), LEFT, RIGHT) = ''         => '',
    trim(trim(rc3_2, LEFT), LEFT, RIGHT) = ''         => '',
    trim(trim(rc4_2, LEFT), LEFT, RIGHT) = ''         => '',
                                                         _rc_inq);

rc5_1 := if(not((rc1_2 in ['I60', 'I62'])) and not((rc2_2 in ['I60', 'I62'])) and not((rc3_2 in ['I60', 'I62'])) and not((rc4_2 in ['I60', 'I62'])), rc5_c93, '');

rc3 := if((rva1601_1_0 in [200, 222]), '', rc3_2);

rc4 := if((rva1601_1_0 in [200, 222]), '', rc4_2);

rc1 := if((rva1601_1_0 in [200, 222]), '', rc1_2);

rc2 := if((rva1601_1_0 in [200, 222]), '', rc2_2);

rc5 := if((rva1601_1_0 in [200, 222]), '', rc5_1);


//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
	
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVA1601_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVA1601_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVA1601_1_0 = 900 => DATASET([{'00'}], HRILayout),
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
	 self.num_dob_match_level              := num_dob_match_level;
   self.nas_summary_ver                  := nas_summary_ver;
   self.nap_summary_ver                  := nap_summary_ver;
   self.infutor_nap_ver                  := infutor_nap_ver;
   self.dob_ver                          := dob_ver;
   self.add_ec1                          := add_ec1;
   self.addr_validation_problem          := addr_validation_problem;
   self.phn_validation_problem           := phn_validation_problem;
   self.tot_liens                        := tot_liens;
   self.tot_liens_w_type                 := tot_liens_w_type;
   self.has_derog                        := has_derog;
   self.rv50_seg_hd_subprime             := rv50_seg_hd_subprime;
   self.derog_seg                        := derog_seg;
   self.owner_seg                        := owner_seg;
   self.other_seg                        := other_seg;
   self.sysdate                          := sysdate;
   self.iv_rv5_unscorable                := iv_rv5_unscorable;
   self.rv_f03_input_add_not_most_rec    := rv_f03_input_add_not_most_rec;
   self._criminal_last_date              := _criminal_last_date;
   self.rv_d32_mos_since_crim_ls         := rv_d32_mos_since_crim_ls;
   self.rv_c21_stl_inq_count             := rv_c21_stl_inq_count;
   self.rv_d33_eviction_count            := rv_d33_eviction_count;
   self._header_first_seen               := _header_first_seen;
   self.rv_c10_m_hdr_fs                  := rv_c10_m_hdr_fs;
   self.rv_f01_inp_addr_not_verified     := rv_f01_inp_addr_not_verified;
   self.rv_ever_asset_owner              := rv_ever_asset_owner;
   self.rv_i60_inq_count12               := rv_i60_inq_count12;
   self.rv_i60_inq_hiriskcred_count12    := rv_i60_inq_hiriskcred_count12;
   self.rv_c13_attr_addrs_recency        := rv_c13_attr_addrs_recency;
   self.rv_a49_curr_add_avm_pct_chg_2yr  := rv_a49_curr_add_avm_pct_chg_2yr;
   self.rv_f01_inp_addr_address_score    := rv_f01_inp_addr_address_score;
   self.rv_a46_curr_avm_autoval          := rv_a46_curr_avm_autoval;
   self.rv_a41_prop_owner_inp_only       := rv_a41_prop_owner_inp_only;
   self.rv_i62_inq_phones_per_adl        := rv_i62_inq_phones_per_adl;
   self.rv_i60_inq_comm_count12          := rv_i60_inq_comm_count12;
   self.rv_a50_pb_average_dollars        := rv_a50_pb_average_dollars;
   self.rv_c13_inp_addr_lres             := rv_c13_inp_addr_lres;
   self.sp2_subscore0   := sp2_subscore0;
   self.sp2_subscore1   := sp2_subscore1;
   self.sp2_subscore2   := sp2_subscore2;
   self.sp2_subscore3   := sp2_subscore3;
   self.sp2_subscore4   := sp2_subscore4;
   self.sp2_subscore5   := sp2_subscore5;
   self.sp2_subscore6   := sp2_subscore6;
   self.sp2_subscore7   := sp2_subscore7;
   self.sp2_subscore8   := sp2_subscore8;
   self.sp2_subscore9   := sp2_subscore9;
   self.sp2_subscore10                   := sp2_subscore10;
   self.sp2_rawscore                     := sp2_rawscore;
   self.sp2_lnoddsscore                  := sp2_lnoddsscore;
   self.sp2_probscore   := sp2_probscore;
   self.sp2_aacd_0      := sp2_aacd_0;
   self.sp2_dist_0      := sp2_dist_0;
   self.sp2_aacd_1      := sp2_aacd_1;
   self.sp2_dist_1      := sp2_dist_1;
   self.sp2_aacd_2      := sp2_aacd_2;
   self.sp2_dist_2      := sp2_dist_2;
   self.sp2_aacd_3      := sp2_aacd_3;
   self.sp2_dist_3      := sp2_dist_3;
   self.sp2_aacd_4      := sp2_aacd_4;
   self.sp2_dist_4      := sp2_dist_4;
   self.sp2_aacd_5      := sp2_aacd_5;
   self.sp2_dist_5      := sp2_dist_5;
   self.sp2_aacd_6      := sp2_aacd_6;
   self.sp2_dist_6      := sp2_dist_6;
   self.sp2_aacd_7      := sp2_aacd_7;
   self.sp2_dist_7      := sp2_dist_7;
   self.sp2_aacd_8      := sp2_aacd_8;
   self.sp2_dist_8      := sp2_dist_8;
   self.sp2_aacd_9      := sp2_aacd_9;
   self.sp2_dist_9      := sp2_dist_9;
   self.sp2_aacd_10     := sp2_aacd_10;
   self.sp2_dist_10     := sp2_dist_10;
   self.sp2_rcvaluec21                   := sp2_rcvaluec21;
   self.sp2_rcvaluef03                   := sp2_rcvaluef03;
   self.sp2_rcvalued32                   := sp2_rcvalued32;
   self.sp2_rcvalued33                   := sp2_rcvalued33;
   self.sp2_rcvaluei60                   := sp2_rcvaluei60;
   self.sp2_rcvaluea40                   := sp2_rcvaluea40;
   self.sp2_rcvaluec13                   := sp2_rcvaluec13;
   self.sp2_rcvaluef01                   := sp2_rcvaluef01;
   self.sp2_rcvaluec10                   := sp2_rcvaluec10;
   self.sp2_rcvaluea49                   := sp2_rcvaluea49;
   self.sp3_subscore0   := sp3_subscore0;
   self.sp3_subscore1   := sp3_subscore1;
   self.sp3_subscore2   := sp3_subscore2;
   self.sp3_subscore3   := sp3_subscore3;
   self.sp3_subscore4   := sp3_subscore4;
   self.sp3_subscore5   := sp3_subscore5;
   self.sp3_rawscore    := sp3_rawscore;
   self.sp3_lnoddsscore                  := sp3_lnoddsscore;
   self.sp3_probscore   := sp3_probscore;
   self.sp3_aacd_0      := sp3_aacd_0;
   self.sp3_dist_0      := sp3_dist_0;
   self.sp3_aacd_1      := sp3_aacd_1;
   self.sp3_dist_1      := sp3_dist_1;
   self.sp3_aacd_2      := sp3_aacd_2;
   self.sp3_dist_2      := sp3_dist_2;
   self.sp3_aacd_3      := sp3_aacd_3;
   self.sp3_dist_3      := sp3_dist_3;
   self.sp3_aacd_4      := sp3_aacd_4;
   self.sp3_dist_4      := sp3_dist_4;
   self.sp3_aacd_5      := sp3_aacd_5;
   self.sp3_dist_5      := sp3_dist_5;
   self.sp3_rcvaluea46                   := sp3_rcvaluea46;
   self.sp3_rcvaluei60                   := sp3_rcvaluei60;
   self.sp3_rcvaluei62                   := sp3_rcvaluei62;
   self.sp3_rcvaluea41                   := sp3_rcvaluea41;
   self.sp3_rcvaluef01                   := sp3_rcvaluef01;
   self.sp3_rcvaluec10                   := sp3_rcvaluec10;
   self.sp4_subscore0   := sp4_subscore0;
   self.sp4_subscore1   := sp4_subscore1;
   self.sp4_subscore2   := sp4_subscore2;
   self.sp4_subscore3   := sp4_subscore3;
   self.sp4_subscore4   := sp4_subscore4;
   self.sp4_subscore5   := sp4_subscore5;
   self.sp4_subscore6   := sp4_subscore6;
   self.sp4_subscore7   := sp4_subscore7;
   self.sp4_subscore8   := sp4_subscore8;
   self.sp4_subscore9   := sp4_subscore9;
   self.sp4_rawscore    := sp4_rawscore;
   self.sp4_lnoddsscore                  := sp4_lnoddsscore;
   self.sp4_probscore   := sp4_probscore;
   self.sp4_aacd_0      := sp4_aacd_0;
   self.sp4_dist_0      := sp4_dist_0;
   self.sp4_aacd_1      := sp4_aacd_1;
   self.sp4_dist_1      := sp4_dist_1;
   self.sp4_aacd_2      := sp4_aacd_2;
   self.sp4_dist_2      := sp4_dist_2;
   self.sp4_aacd_3      := sp4_aacd_3;
   self.sp4_dist_3      := sp4_dist_3;
   self.sp4_aacd_4      := sp4_aacd_4;
   self.sp4_dist_4      := sp4_dist_4;
   self.sp4_aacd_5      := sp4_aacd_5;
   self.sp4_dist_5      := sp4_dist_5;
   self.sp4_aacd_6      := sp4_aacd_6;
   self.sp4_dist_6      := sp4_dist_6;
   self.sp4_aacd_7      := sp4_aacd_7;
   self.sp4_dist_7      := sp4_dist_7;
   self.sp4_aacd_8      := sp4_aacd_8;
   self.sp4_dist_8      := sp4_dist_8;
   self.sp4_aacd_9      := sp4_aacd_9;
   self.sp4_dist_9      := sp4_dist_9;
   self.sp4_rcvaluec21                   := sp4_rcvaluec21;
   self.sp4_rcvaluei62                   := sp4_rcvaluei62;
   self.sp4_rcvaluea46                   := sp4_rcvaluea46;
   self.sp4_rcvaluea50                   := sp4_rcvaluea50;
   self.sp4_rcvaluei60                   := sp4_rcvaluei60;
   self.sp4_rcvaluea40                   := sp4_rcvaluea40;
   self.sp4_rcvaluec13                   := sp4_rcvaluec13;
   self.sp4_rcvaluec10                   := sp4_rcvaluec10;
   self.probscore       := probscore;
   self.base            := base;
   self.pts             := pts;
   self.odds            := odds;
   self.deceased        := deceased;
   self.rva1601_1_0     := rva1601_1_0;
   self._rc_seg         := _rc_seg;
   self.sp2_rc1         := sp2_rc1;
   self.sp2_rc2         := sp2_rc2;
   self.sp2_rc3         := sp2_rc3;
   self.sp2_rc4         := sp2_rc4;
   self.sp2_vl1         := sp2_vl1;
   self.sp2_vl2         := sp2_vl2;
   self.sp2_vl3         := sp2_vl3;
   self.sp2_vl4         := sp2_vl4;
   self.sp3_rc1         := sp3_rc1;
   self.sp3_rc2         := sp3_rc2;
   self.sp3_rc3         := sp3_rc3;
   self.sp3_rc4         := sp3_rc4;
   self.sp3_vl1         := sp3_vl1;
   self.sp3_vl2         := sp3_vl2;
   self.sp3_vl3         := sp3_vl3;
   self.sp3_vl4         := sp3_vl4;
   self.sp4_rc1         := sp4_rc1;
   self.sp4_rc2         := sp4_rc2;
   self.sp4_rc3         := sp4_rc3;
   self.sp4_rc4         := sp4_rc4;
   self.sp4_vl1         := sp4_vl1;
   self.sp4_vl2         := sp4_vl2;
   self.sp4_vl3         := sp4_vl3;
   self.sp4_vl4         := sp4_vl4;
   self._rc_inq         := _rc_inq;
   self.rc3             := rc3;
   self.rc4             := rc4;
   self.rc1             := rc1;
   self.rc5             := rc5;
   self.rc2             := rc2;

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rva1601_1_0;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));
	

	RETURN(model);
END;



