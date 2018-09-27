IMPORT ut, Std, RiskWise, RiskWiseFCRA, Risk_Indicators, riskview;

EXPORT RVA1605_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	MODEL_DEBUG := False;

	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
	 Integer seq;
   Integer sysdate;
   Integer tot_liens;
   Integer tot_liens_w_type;
   Integer has_derog;
   String jd_2seg;
   String rv_f00_addr_not_ver_w_ssn;
   String rv_d32_criminal_x_felony;
   Integer rv_d31_bk_disposed_recent_count;
   Real rv_c21_stl_inq_count;
   Integer rv_d33_eviction_count;
   String iv_d34_liens_unrel_x_rel;
   Integer bureau_adl_eq_fseen_pos;
   String bureau_adl_fseen_eq;
   Integer _bureau_adl_fseen_eq;
   Integer _src_bureau_adl_fseen;
   Real rv_c20_m_bureau_adl_fs;
   Real rv_l80_inp_avm_autoval;
   Integer rv_c13_max_lres;
   String rv_prof_license_flag;
   String rv_e57_br_dead_bus_x_active_phn;
   Real d_subscore0;
   Real d_subscore1;
   Real d_subscore2;
   Real d_subscore3;
   Real d_subscore4;
   Real d_subscore5;
   Real d_subscore6;
   Real d_subscore7;
   Real d_subscore8;
   Real d_subscore9;
   Real d_subscore10;
   Real d_subscore11;
   Real d_subscore12;
   Real d_subscore13;
   Real d_subscore14;
   Real d_subscore15;
   Real d_rawscore;
   Real d_lnoddsscore;
   Real d_probscore;
   String d_aacd_0;
   Real d_dist_0;
   String d_aacd_1;
   Real d_dist_1;
   String d_aacd_2;
   Real d_dist_2;
   String d_aacd_3;
   Real d_dist_3;
   String d_aacd_4;
   Real d_dist_4;
   String d_aacd_5;
   Real d_dist_5;
   String d_aacd_6;
   Real d_dist_6;
   String d_aacd_7;
   Real d_dist_7;
   String d_aacd_8;
   Real d_dist_8;
   String d_aacd_9;
   Real d_dist_9;
   String d_aacd_10;
   Real d_dist_10;
   String d_aacd_11;
   Real d_dist_11;
   String d_aacd_12;
   Real d_dist_12;
   String d_aacd_13;
   Real d_dist_13;
   String d_aacd_14;
   Real d_dist_14;
   String d_aacd_15;
   Real d_dist_15;
   Real d_rcvaluec20;
   Real d_rcvaluec21;
   Real d_rcvaluel80;
   Real d_rcvalued34;
   Real d_rcvalued32;
   Real d_rcvalued33;
   Real d_rcvaluel77;
   Real d_rcvaluea51;
   Real d_rcvaluea50;
   Real d_rcvaluel79;
   Real d_rcvaluei60;
   Real d_rcvaluef00;
   Real d_rcvaluei62;
   Real d_rcvaluec13;
   Real d_rcvaluec12;
   Real d_rcvaluee57;
   Real d_rcvalued31;
   Real d_rcvaluec14;
   String d_rc1;
   String d_rc2;
   String d_rc3;
   String d_rc4;
   Real d_vl1;
   Real d_vl2;
   Real d_vl3;
   Real d_vl4;
   String iv_add_apt;
   Integer _header_first_seen;
   Integer rv_c10_m_hdr_fs;
   Integer rv_c14_addrs_5yr;
   String rv_a41_a42_prop_owner_history;
   Integer rv_i60_inq_hiriskcred_recency;
   Integer rv_i60_inq_comm_recency;
   Integer rv_l79_adls_per_sfd_addr_c6;
   Real rv_a50_pb_total_dollars;
   Integer rv_c13_inp_addr_lres;
   Integer rv_i62_inq_phones_per_adl;
   Real rv_br_active_phone_count;
   Real o_subscore0;
   Real o_subscore1;
   Real o_subscore2;
   Real o_subscore3;
   Real o_subscore4;
   Real o_subscore5;
   Real o_subscore6;
   Real o_subscore7;
   Real o_subscore8;
   Real o_subscore9;
   Real o_rawscore;
   Real o_lnoddsscore;
   Real o_probscore;
   String o_aacd_0;
   Real o_dist_0;
   String o_aacd_1;
   Real o_dist_1;
   String o_aacd_2;
   Real o_dist_2;
   String o_aacd_3;
   Real o_dist_3;
   String o_aacd_4;
   Real o_dist_4;
   String o_aacd_5;
   Real o_dist_5;
   String o_aacd_6;
   Real o_dist_6;
   String o_aacd_7;
   Real o_dist_7;
   String o_aacd_8;
   Real o_dist_8;
   String o_aacd_9;
   Real o_dist_9;
   Real o_rcvaluec12;
   Real o_rcvaluel79;
   Real o_rcvaluel77;
   Real o_rcvaluea50;
   Real o_rcvaluei60;
   Real o_rcvaluei62;
   Real o_rcvaluea41;
   Real o_rcvaluec13;
   Real o_rcvaluea42;
   Real o_rcvaluec10;
   Real o_rcvaluec14;
   String o_rc1;
   String o_rc2;
   String o_rc3;
   String o_rc4;
   Real o_vl1;
   Real o_vl2;
   Real o_vl3;
   Real o_vl4;
   Boolean iv_rv5_deceased;
   String iv_rv5_unscorable;
   Integer base;
   Integer pdo;
   Real odds;
   Integer rva1605_1_0;
   String _rc_seg;
   String _rc_inq;
   String rc1;
   String rc2;
   String rc3;
   String rc4;
   String rc5;

			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	seq															 := le.seq;
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_z5                           := le.shell_input.z5;
	out_addr_status                  := le.shell_input.addr_status;
	out_addr_type                    := le.shell_input.addr_type;
	out_sec_range                    := le.shell_input.sec_range;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_hriskaddrflag                 := le.iid.hriskaddrflag;
	rc_dwelltype 										 := le.iid.dwelltype;
	rc_decsflag                      := le.iid.decsflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_hrisksic                      := le.iid.hrisksic;
	rc_hrisksicphone                 := le.iid.hrisksicphone;
	rc_phonetype                     := le.iid.phonetype;
	rc_ziptypeflag                   := le.iid.ziptypeflag;
	hdr_source_profile_index         := le.source_profile_index;
	ver_sources                      := le.header_summary.ver_sources;
  ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	addrpop													 := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_lres                   := le.lres;
	max_lres												 := le.other_address_info.max_lres;
	add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
	add_input_avm_auto_val					 := le.avm.input_address_information.avm_automated_valuation;
	add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_isbestmatch             := le.address_verification.address_history_1.isbestmatch;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	telcordia_type                   := le.phone_verification.telcordia_type;
	header_first_seen								 := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	adls_per_ssn                     := le.SSN_Verification.adlperssn_count;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	ssns_per_addr_curr               := le.velocity_counters.ssns_per_addr_current;
	adls_per_addr_c6							   := le.velocity_counters.adls_per_addr_created_6months;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	inq_auto_count12                 := le.acc_logs.auto.count12;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_communications_count01       := le.acc_logs.communications.count01;
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_communications_count06       := le.acc_logs.communications.count06;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_communications_count24       := le.acc_logs.communications.count24;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	pb_total_dollars								 := le.ibehavior.total_dollars;
	pb_total_orders                  := (INTEGER)le.ibehavior.total_number_of_orders;
	br_source_count                  := le.employment.source_ct;
	br_dead_business_count					 := le.employment.dead_business_ct;
	br_active_phone_count						 := le.employment.business_active_phone_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count                    := le.impulse.count;
	stl_inq_count12                  := le.impulse.count12;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	bk_dismissed_recent_count        := le.bjl.bk_dismissed_recent_count;
	bk_dismissed_historical_count    := le.bjl.bk_dismissed_historical_count;
	bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
	liens_recent_unreleased_count    := le.BJL.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.BJL.liens_historical_unreleased_count;
	liens_recent_released_count      := le.BJL.liens_recent_released_count;
	liens_historical_released_count  := le.BJL.liens_historical_released_count;
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
	felony_count                     := le.bjl.felony_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	prof_license_flag                := le.professional_license.professional_license_flag;
	input_dob_match_level            := le.dobmatchlevel;

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

tot_liens := if(max(liens_historical_unreleased_ct, liens_recent_unreleased_count, liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct), if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count)));

tot_liens_w_type := if(max(liens_unrel_LT_ct, liens_rel_LT_ct, liens_unrel_SC_ct, liens_rel_SC_ct, liens_unrel_CJ_ct, liens_rel_CJ_ct, liens_unrel_FT_ct, liens_rel_FT_ct, liens_unrel_OT_ct, liens_rel_OT_ct, liens_unrel_ST_ct, liens_rel_ST_ct, liens_unrel_FC_ct, liens_rel_FC_ct, liens_unrel_O_ct, liens_rel_O_ct) = NULL, NULL, sum(if(liens_unrel_LT_ct = NULL, 0, liens_unrel_LT_ct), if(liens_rel_LT_ct = NULL, 0, liens_rel_LT_ct), if(liens_unrel_SC_ct = NULL, 0, liens_unrel_SC_ct), if(liens_rel_SC_ct = NULL, 0, liens_rel_SC_ct), if(liens_unrel_CJ_ct = NULL, 0, liens_unrel_CJ_ct), if(liens_rel_CJ_ct = NULL, 0, liens_rel_CJ_ct), if(liens_unrel_FT_ct = NULL, 0, liens_unrel_FT_ct), if(liens_rel_FT_ct = NULL, 0, liens_rel_FT_ct), if(liens_unrel_OT_ct = NULL, 0, liens_unrel_OT_ct), if(liens_rel_OT_ct = NULL, 0, liens_rel_OT_ct), if(liens_unrel_ST_ct = NULL, 0, liens_unrel_ST_ct), if(liens_rel_ST_ct = NULL, 0, liens_rel_ST_ct), if(liens_unrel_FC_ct = NULL, 0, liens_unrel_FC_ct), if(liens_rel_FC_ct = NULL, 0, liens_rel_FC_ct), if(liens_unrel_O_ct = NULL, 0, liens_unrel_O_ct), if(liens_rel_O_ct = NULL, 0, liens_rel_O_ct)));

has_derog := if(felony_count > 0 or criminal_count > 0 or stl_inq_count12 > 0 or attr_eviction_count > 0 or liens_unrel_CJ_ct > 0 or liens_rel_CJ_ct > 0 or liens_unrel_SC_ct > 0 or liens_rel_SC_ct > 0 or liens_unrel_FC_ct > 0 or liens_rel_FC_ct > 0 or liens_unrel_O_ct > 0 or liens_rel_O_ct > 0 or tot_liens - tot_liens_w_type > 0 or bk_dismissed_recent_count > 0 or bk_dismissed_historical_count > 0, 1, 0);

jd_2seg := if(has_derog = 1, '0 DEROG', '1 OTHER');

iv_add_apt_1 := if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0');

iv_rv5_unscorable_2 := if(riskview.constants.noscore(nas_summary,nap_summary, add_input_naprop, le.truedid) , '1', '0');

rv_f00_addr_not_ver_w_ssn := if(not(truedid and (integer) ssnlength > 0), ' ', (String) (Integer) (nas_summary in [4, 7, 9]));

rv_d32_criminal_x_felony := if(not(truedid), '', trim((String)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((String)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

rv_d31_bk_disposed_recent_count := if(not(truedid), NULL, min(if(bk_disposed_recent_count = NULL, -NULL, bk_disposed_recent_count), 999));

rv_c21_stl_inq_count := if(not(truedid), NULL, min(if(STL_Inq_count = NULL, -NULL, STL_Inq_count), 999));

rv_d33_eviction_count := if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999));

iv_d34_liens_unrel_x_rel := if(not(truedid), '   ', trim((String)min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((String)min(if(if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) = NULL, -NULL, if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count)))), 2), LEFT, RIGHT));

bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'); 

bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

_bureau_adl_fseen_eq := common.sas_date((string)(bureau_adl_fseen_eq));

_src_bureau_adl_fseen := min(if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

rv_c20_m_bureau_adl_fs := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => -1,
                                      min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999));

rv_l80_inp_avm_autoval := if(not(add_input_pop), NULL, add_input_avm_auto_val);

rv_c13_max_lres := if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999));

rv_c14_addrs_5yr_1 := map(
    not(truedid)     => NULL,
    not add_curr_pop => -1,
                        min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));

rv_prof_license_flag := if(not(truedid), ' ', (string)(integer) prof_license_flag);

rv_i60_inq_hiriskcred_recency_1 := map(
    not(truedid)               => NULL,
   (Boolean) inq_highRiskCredit_count01 => 1,
   (Boolean) inq_highRiskCredit_count03 => 3,
   (Boolean) inq_highRiskCredit_count06 => 6,
   (Boolean) inq_highRiskCredit_count12 => 12,
   (Boolean) inq_highRiskCredit_count24 => 24,
   (Boolean) inq_highRiskCredit_count   => 99,
                                  0);

rv_l79_adls_per_sfd_addr_c6_1 := map(
    not(addrpop)       => NULL,
    iv_add_apt_1 = '1' => -1,
                          min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));

rv_a50_pb_total_dollars_1 := map(
    not(truedid)            => NULL,
    pb_total_dollars = '' => -1,
                              (Real) pb_total_dollars);

rv_i62_inq_phones_per_adl_1 := if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999));

rv_e57_br_dead_bus_x_active_phn := if(not(truedid), '   ', trim((String)min(if(br_dead_business_count = NULL, -NULL, br_dead_business_count), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((String)min(if(br_active_phone_count = NULL, -NULL, br_active_phone_count), 3), LEFT, RIGHT));

d_subscore0 := map(
    (rv_d32_criminal_x_felony in [' '])                               => 0,
    (rv_d32_criminal_x_felony in ['0-0'])                             => 0.087032,
    (rv_d32_criminal_x_felony in ['1-0', '2-0'])                      => -0.261478,
    (rv_d32_criminal_x_felony in ['3-0'])                             => -0.36805,
    (rv_d32_criminal_x_felony in ['1-1'])                             => -0.666314,
    (rv_d32_criminal_x_felony in ['2-1', '2-2', '3-1', '3-2', '3-3']) => -0.752906,
                                                                         0);

d_subscore1 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 23  => -0.550759,
    23 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 47   => -0.222599,
    47 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 97   => -0.175331,
    97 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 146  => -0.127462,
    146 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 176 => -0.107301,
    176 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 198 => -0.043819,
    198 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 233 => -0.002262,
    233 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 278 => 0.108075,
    278 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 318 => 0.1319,
    318 <= rv_c20_m_bureau_adl_fs                                  => 0.276916,
                                                                      0);

d_subscore2 := map(
    NULL < rv_c14_addrs_5yr_1 AND rv_c14_addrs_5yr_1 < 1 => 0.229065,
    1 <= rv_c14_addrs_5yr_1 AND rv_c14_addrs_5yr_1 < 2   => 0.087993,
    2 <= rv_c14_addrs_5yr_1 AND rv_c14_addrs_5yr_1 < 3   => 0.019966,
    3 <= rv_c14_addrs_5yr_1 AND rv_c14_addrs_5yr_1 < 4   => -0.096019,
    4 <= rv_c14_addrs_5yr_1 AND rv_c14_addrs_5yr_1 < 5   => -0.121334,
    5 <= rv_c14_addrs_5yr_1 AND rv_c14_addrs_5yr_1 < 6   => -0.176108,
    6 <= rv_c14_addrs_5yr_1                              => -0.287261,
                                                            0);

d_subscore3 := map(
    NULL < rv_i62_inq_phones_per_adl_1 AND rv_i62_inq_phones_per_adl_1 < 1 => 0.084802,
    1 <= rv_i62_inq_phones_per_adl_1 AND rv_i62_inq_phones_per_adl_1 < 2   => 0.022133,
    2 <= rv_i62_inq_phones_per_adl_1 AND rv_i62_inq_phones_per_adl_1 < 3   => -0.20362,
    3 <= rv_i62_inq_phones_per_adl_1 AND rv_i62_inq_phones_per_adl_1 < 4   => -0.386673,
    4 <= rv_i62_inq_phones_per_adl_1                                       => -0.54672,
                                                                              0);

d_subscore4 := map(
    (rv_f00_addr_not_ver_w_ssn in [' ']) => 0,
    (rv_f00_addr_not_ver_w_ssn in ['0']) => 0.088898,
    (rv_f00_addr_not_ver_w_ssn in ['1']) => -0.190019,
                                            0);

d_subscore5 := map(
    NULL < rv_d33_eviction_count AND rv_d33_eviction_count < 1 => 0.105829,
    1 <= rv_d33_eviction_count AND rv_d33_eviction_count < 3   => -0.025425,
    3 <= rv_d33_eviction_count AND rv_d33_eviction_count < 7   => -0.215489,
    7 <= rv_d33_eviction_count                                 => -0.261937,
                                                                  0);

d_subscore6 := map(
    NULL < rv_i60_inq_hiriskcred_recency_1 AND rv_i60_inq_hiriskcred_recency_1 < 1 => 0.03316,
    1 <= rv_i60_inq_hiriskcred_recency_1 AND rv_i60_inq_hiriskcred_recency_1 < 6   => -0.367469,
    6 <= rv_i60_inq_hiriskcred_recency_1 AND rv_i60_inq_hiriskcred_recency_1 < 12  => -0.214551,
    12 <= rv_i60_inq_hiriskcred_recency_1                                          => -0.025011,
                                                                                      0);

d_subscore7 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 0.036251,
    1 <= rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 2   => -0.044812,
    2 <= rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 3   => -0.288861,
    3 <= rv_c21_stl_inq_count                                => -0.398476,
                                                                0);

d_subscore8 := map(
    (iv_d34_liens_unrel_x_rel in [' '])                                                    => 0,
    (iv_d34_liens_unrel_x_rel in ['0-0'])                                                  => -0.057439,
    (iv_d34_liens_unrel_x_rel in ['1-0', '2-0', '3-0'])                                    => -0.012528,
    (iv_d34_liens_unrel_x_rel in ['0-1', '0-2', '1-1', '1-2', '2-1', '2-2', '3-1', '3-2']) => 0.227066,
                                                                                              0);

d_subscore9 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 6 => -0.399028,
    6 <= rv_c13_max_lres AND rv_c13_max_lres < 18  => -0.216036,
    18 <= rv_c13_max_lres AND rv_c13_max_lres < 28 => -0.111388,
    28 <= rv_c13_max_lres AND rv_c13_max_lres < 44 => -0.052267,
    44 <= rv_c13_max_lres AND rv_c13_max_lres < 46 => -0.006078,
    46 <= rv_c13_max_lres AND rv_c13_max_lres < 52 => 0.016725,
    52 <= rv_c13_max_lres                          => 0.039295,
                                                      0);

d_subscore10 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6_1 AND rv_l79_adls_per_sfd_addr_c6_1 < 0 => 0.03671,
    0 <= rv_l79_adls_per_sfd_addr_c6_1 AND rv_l79_adls_per_sfd_addr_c6_1 < 1   => 0.044594,
    1 <= rv_l79_adls_per_sfd_addr_c6_1 AND rv_l79_adls_per_sfd_addr_c6_1 < 2   => -0.029024,
    2 <= rv_l79_adls_per_sfd_addr_c6_1 AND rv_l79_adls_per_sfd_addr_c6_1 < 4   => -0.108548,
    4 <= rv_l79_adls_per_sfd_addr_c6_1                                         => -0.351661,
                                                                                  0);

d_subscore11 := map(
    NULL < rv_d31_bk_disposed_recent_count AND rv_d31_bk_disposed_recent_count < 1 => -0.010534,
    1 <= rv_d31_bk_disposed_recent_count                                           => 0.286572,
                                                                                      0);

d_subscore12 := map(
    NULL < rv_a50_pb_total_dollars_1 AND rv_a50_pb_total_dollars_1 < 0   => -0.0315,
    0 <= rv_a50_pb_total_dollars_1 AND rv_a50_pb_total_dollars_1 < 18    => -0.044991,
    18 <= rv_a50_pb_total_dollars_1 AND rv_a50_pb_total_dollars_1 < 36   => -0.011067,
    36 <= rv_a50_pb_total_dollars_1 AND rv_a50_pb_total_dollars_1 < 108  => 0.017173,
    108 <= rv_a50_pb_total_dollars_1 AND rv_a50_pb_total_dollars_1 < 177 => 0.035227,
    177 <= rv_a50_pb_total_dollars_1                                     => 0.12131,
                                                                            0);

d_subscore13 := map(
    (rv_e57_br_dead_bus_x_active_phn in [' '])                                                                                => 0,
    (rv_e57_br_dead_bus_x_active_phn in ['0-0'])                                                                              => -0.002929,
    (rv_e57_br_dead_bus_x_active_phn in ['0-1', '0-2', '0-3', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3']) => 0.362148,
    (rv_e57_br_dead_bus_x_active_phn in ['1-0', '2-0', '3-0'])                                                                => -0.117931,
                                                                                                                                 0);

d_subscore14 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1         => -0.006395,
    1 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 12885       => -0.128895,
    12885 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 151632  => -0.003061,
    151632 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 217287 => 0.160005,
    217287 <= rv_l80_inp_avm_autoval                                     => 0.192591,
                                                                            0);

d_subscore15 := map(
    (rv_prof_license_flag in [' ']) => 0,
    (rv_prof_license_flag in ['0']) => -0.009784,
    (rv_prof_license_flag in ['1']) => 0.167414,
                                       0);

d_rawscore := d_subscore0 +
    d_subscore1 +
    d_subscore2 +
    d_subscore3 +
    d_subscore4 +
    d_subscore5 +
    d_subscore6 +
    d_subscore7 +
    d_subscore8 +
    d_subscore9 +
    d_subscore10 +
    d_subscore11 +
    d_subscore12 +
    d_subscore13 +
    d_subscore14 +
    d_subscore15;

d_lnoddsscore := d_rawscore + 0.271338;

d_probscore := exp(d_lnoddsscore) / (1 + exp(d_lnoddsscore));

d_aacd_0 := map(
    (rv_d32_criminal_x_felony in [' '])                               => '',
    (rv_d32_criminal_x_felony in ['0-0'])                             => 'D32',
    (rv_d32_criminal_x_felony in ['1-0', '2-0'])                      => 'D32',
    (rv_d32_criminal_x_felony in ['3-0'])                             => 'D32',
    (rv_d32_criminal_x_felony in ['1-1'])                             => 'D32',
    (rv_d32_criminal_x_felony in ['2-1', '2-2', '3-1', '3-2', '3-3']) => 'D32',
                                                                         '');

d_dist_0 := d_subscore0 - 0.087032;

d_aacd_1 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 23  => 'C20',
    23 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 47   => 'C20',
    47 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 97   => 'C20',
    97 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 146  => 'C20',
    146 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 176 => 'C20',
    176 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 198 => 'C20',
    198 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 233 => 'C20',
    233 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 278 => 'C20',
    278 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 318 => 'C20',
    318 <= rv_c20_m_bureau_adl_fs                                  => 'C20',
                                                                      '');

d_dist_1 := d_subscore1 - 0.276916;

d_aacd_2 := map(
    NULL < rv_c14_addrs_5yr_1 AND rv_c14_addrs_5yr_1 < 1 => 'C14',
    1 <= rv_c14_addrs_5yr_1 AND rv_c14_addrs_5yr_1 < 2   => 'C14',
    2 <= rv_c14_addrs_5yr_1 AND rv_c14_addrs_5yr_1 < 3   => 'C14',
    3 <= rv_c14_addrs_5yr_1 AND rv_c14_addrs_5yr_1 < 4   => 'C14',
    4 <= rv_c14_addrs_5yr_1 AND rv_c14_addrs_5yr_1 < 5   => 'C14',
    5 <= rv_c14_addrs_5yr_1 AND rv_c14_addrs_5yr_1 < 6   => 'C14',
    6 <= rv_c14_addrs_5yr_1                              => 'C14',
                                                            '');

d_dist_2 := d_subscore2 - 0.229065;

d_aacd_3 := map(
    NULL < rv_i62_inq_phones_per_adl_1 AND rv_i62_inq_phones_per_adl_1 < 1 => 'I62',
    1 <= rv_i62_inq_phones_per_adl_1 AND rv_i62_inq_phones_per_adl_1 < 2   => 'I62',
    2 <= rv_i62_inq_phones_per_adl_1 AND rv_i62_inq_phones_per_adl_1 < 3   => 'I62',
    3 <= rv_i62_inq_phones_per_adl_1 AND rv_i62_inq_phones_per_adl_1 < 4   => 'I62',
    4 <= rv_i62_inq_phones_per_adl_1                                       => 'I62',
                                                                              '');

d_dist_3 := d_subscore3 - 0.084802;

d_aacd_4 := map(
    (rv_f00_addr_not_ver_w_ssn in [' ']) => '',
    (rv_f00_addr_not_ver_w_ssn in ['0']) => 'F00',
    (rv_f00_addr_not_ver_w_ssn in ['1']) => 'F00',
                                            '');

d_dist_4 := d_subscore4 - 0.088898;

d_aacd_5 := map(
    NULL < rv_d33_eviction_count AND rv_d33_eviction_count < 1 => 'D33',
    1 <= rv_d33_eviction_count AND rv_d33_eviction_count < 3   => 'D33',
    3 <= rv_d33_eviction_count AND rv_d33_eviction_count < 7   => 'D33',
    7 <= rv_d33_eviction_count                                 => 'D33',
                                                                  '');

d_dist_5 := d_subscore5 - 0.105829;

d_aacd_6 := map(
    NULL < rv_i60_inq_hiriskcred_recency_1 AND rv_i60_inq_hiriskcred_recency_1 < 1 => 'I60',
    1 <= rv_i60_inq_hiriskcred_recency_1 AND rv_i60_inq_hiriskcred_recency_1 < 6   => 'I60',
    6 <= rv_i60_inq_hiriskcred_recency_1 AND rv_i60_inq_hiriskcred_recency_1 < 12  => 'I60',
    12 <= rv_i60_inq_hiriskcred_recency_1                                          => 'I60',
                                                                                      '');

d_dist_6 := d_subscore6 - 0.03316;

d_aacd_7 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 'C21',
    1 <= rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 2   => 'C21',
    2 <= rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 3   => 'C21',
    3 <= rv_c21_stl_inq_count                                => 'C21',
                                                                '');

d_dist_7 := d_subscore7 - 0.036251;

d_aacd_8 := map(
    (iv_d34_liens_unrel_x_rel in [' '])                                                    => '',
    (iv_d34_liens_unrel_x_rel in ['0-0'])                                                  => 'D34',
    (iv_d34_liens_unrel_x_rel in ['1-0', '2-0', '3-0'])                                    => 'D34',
    (iv_d34_liens_unrel_x_rel in ['0-1', '0-2', '1-1', '1-2', '2-1', '2-2', '3-1', '3-2']) => 'D34',
                                                                                              '');

d_dist_8 := d_subscore8 - 0.227066;

d_aacd_9 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 6 => 'C13',
    6 <= rv_c13_max_lres AND rv_c13_max_lres < 18  => 'C13',
    18 <= rv_c13_max_lres AND rv_c13_max_lres < 28 => 'C13',
    28 <= rv_c13_max_lres AND rv_c13_max_lres < 44 => 'C13',
    44 <= rv_c13_max_lres AND rv_c13_max_lres < 46 => 'C13',
    46 <= rv_c13_max_lres AND rv_c13_max_lres < 52 => 'C13',
    52 <= rv_c13_max_lres                          => 'C13',
                                                      '');

d_dist_9 := d_subscore9 - 0.039295;

d_aacd_10 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6_1 AND rv_l79_adls_per_sfd_addr_c6_1 < 0 => 'L77',
    0 <= rv_l79_adls_per_sfd_addr_c6_1 AND rv_l79_adls_per_sfd_addr_c6_1 < 1   => 'L79',
    1 <= rv_l79_adls_per_sfd_addr_c6_1 AND rv_l79_adls_per_sfd_addr_c6_1 < 2   => 'L79',
    2 <= rv_l79_adls_per_sfd_addr_c6_1 AND rv_l79_adls_per_sfd_addr_c6_1 < 4   => 'L79',
    4 <= rv_l79_adls_per_sfd_addr_c6_1                                         => 'L79',
                                                                                  '');

d_dist_10 := d_subscore10 - 0.044594;

d_aacd_11 := map(
    NULL < rv_d31_bk_disposed_recent_count AND rv_d31_bk_disposed_recent_count < 1 => 'D31',
    1 <= rv_d31_bk_disposed_recent_count                                           => 'D31',
                                                                                      '');

d_dist_11 := d_subscore11 - 0.286572;

d_aacd_12 := map(
    NULL < rv_a50_pb_total_dollars_1 AND rv_a50_pb_total_dollars_1 < 0   => 'A50',
    0 <= rv_a50_pb_total_dollars_1 AND rv_a50_pb_total_dollars_1 < 18    => 'A50',
    18 <= rv_a50_pb_total_dollars_1 AND rv_a50_pb_total_dollars_1 < 36   => 'A50',
    36 <= rv_a50_pb_total_dollars_1 AND rv_a50_pb_total_dollars_1 < 108  => 'A50',
    108 <= rv_a50_pb_total_dollars_1 AND rv_a50_pb_total_dollars_1 < 177 => 'A50',
    177 <= rv_a50_pb_total_dollars_1                                     => 'A50',
                                                                            '');

// d_dist_12 := d_subscore12 - 0.12131;
d_dist_12 := 0;

d_aacd_13 := map(
    (rv_e57_br_dead_bus_x_active_phn in [' '])                                             => 'E57',
    (rv_e57_br_dead_bus_x_active_phn in ['0-0'])                                           => 'E57',
    (rv_e57_br_dead_bus_x_active_phn in ['0-1', '0-2', '0-3', '1-1', '1-2', '2-1', '3-3']) => 'E57',
    (rv_e57_br_dead_bus_x_active_phn in ['1-0', '2-0', '3-0'])                             => 'E57',
                                                                                              '');

d_dist_13 := d_subscore13 - 0.362148;

d_aacd_14 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 3800      => 'A51',
    3800 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 12885    => 'L80',
    12885 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 151632  => 'L80',
    151632 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 217287 => 'L80',
    217287 <= rv_l80_inp_avm_autoval                                     => 'L80',
                                                                            '');

d_dist_14 := d_subscore14 - 0.192591;

d_aacd_15 := map(
    (rv_prof_license_flag in [' ']) => '',
    (rv_prof_license_flag in ['0']) => 'C12',
    (rv_prof_license_flag in ['1']) => 'C12',
                                       '');

d_dist_15 := d_subscore15 - 0.167414;

d_rcvaluec20 := (integer)(d_aacd_0 = 'C20') * d_dist_0 +
    (integer)(d_aacd_1 = 'C20') * d_dist_1 +
    (integer)(d_aacd_2 = 'C20') * d_dist_2 +
    (integer)(d_aacd_3 = 'C20') * d_dist_3 +
    (integer)(d_aacd_4 = 'C20') * d_dist_4 +
    (integer)(d_aacd_5 = 'C20') * d_dist_5 +
    (integer)(d_aacd_6 = 'C20') * d_dist_6 +
    (integer)(d_aacd_7 = 'C20') * d_dist_7 +
    (integer)(d_aacd_8 = 'C20') * d_dist_8 +
    (integer)(d_aacd_9 = 'C20') * d_dist_9 +
    (integer)(d_aacd_10 = 'C20') * d_dist_10 +
    (integer)(d_aacd_11 = 'C20') * d_dist_11 +
    (integer)(d_aacd_12 = 'C20') * d_dist_12 +
    (integer)(d_aacd_13 = 'C20') * d_dist_13 +
    (integer)(d_aacd_14 = 'C20') * d_dist_14 +
    (integer)(d_aacd_15 = 'C20') * d_dist_15;

d_rcvaluec21 := (integer)(d_aacd_0 = 'C21') * d_dist_0 +
    (integer)(d_aacd_1 = 'C21') * d_dist_1 +
    (integer)(d_aacd_2 = 'C21') * d_dist_2 +
    (integer)(d_aacd_3 = 'C21') * d_dist_3 +
    (integer)(d_aacd_4 = 'C21') * d_dist_4 +
    (integer)(d_aacd_5 = 'C21') * d_dist_5 +
    (integer)(d_aacd_6 = 'C21') * d_dist_6 +
    (integer)(d_aacd_7 = 'C21') * d_dist_7 +
    (integer)(d_aacd_8 = 'C21') * d_dist_8 +
    (integer)(d_aacd_9 = 'C21') * d_dist_9 +
    (integer)(d_aacd_10 = 'C21') * d_dist_10 +
    (integer)(d_aacd_11 = 'C21') * d_dist_11 +
    (integer)(d_aacd_12 = 'C21') * d_dist_12 +
    (integer)(d_aacd_13 = 'C21') * d_dist_13 +
    (integer)(d_aacd_14 = 'C21') * d_dist_14 +
    (integer)(d_aacd_15 = 'C21') * d_dist_15;

d_rcvaluel80 := (integer)(d_aacd_0 = 'L80') * d_dist_0 +
    (integer)(d_aacd_1 = 'L80') * d_dist_1 +
    (integer)(d_aacd_2 = 'L80') * d_dist_2 +
    (integer)(d_aacd_3 = 'L80') * d_dist_3 +
    (integer)(d_aacd_4 = 'L80') * d_dist_4 +
    (integer)(d_aacd_5 = 'L80') * d_dist_5 +
    (integer)(d_aacd_6 = 'L80') * d_dist_6 +
    (integer)(d_aacd_7 = 'L80') * d_dist_7 +
    (integer)(d_aacd_8 = 'L80') * d_dist_8 +
    (integer)(d_aacd_9 = 'L80') * d_dist_9 +
    (integer)(d_aacd_10 = 'L80') * d_dist_10 +
    (integer)(d_aacd_11 = 'L80') * d_dist_11 +
    (integer)(d_aacd_12 = 'L80') * d_dist_12 +
    (integer)(d_aacd_13 = 'L80') * d_dist_13 +
    (integer)(d_aacd_14 = 'L80') * d_dist_14 +
    (integer)(d_aacd_15 = 'L80') * d_dist_15;

d_rcvalued34 := (integer)(d_aacd_0 = 'D34') * d_dist_0 +
    (integer)(d_aacd_1 = 'D34') * d_dist_1 +
    (integer)(d_aacd_2 = 'D34') * d_dist_2 +
    (integer)(d_aacd_3 = 'D34') * d_dist_3 +
    (integer)(d_aacd_4 = 'D34') * d_dist_4 +
    (integer)(d_aacd_5 = 'D34') * d_dist_5 +
    (integer)(d_aacd_6 = 'D34') * d_dist_6 +
    (integer)(d_aacd_7 = 'D34') * d_dist_7 +
    (integer)(d_aacd_8 = 'D34') * d_dist_8 +
    (integer)(d_aacd_9 = 'D34') * d_dist_9 +
    (integer)(d_aacd_10 = 'D34') * d_dist_10 +
    (integer)(d_aacd_11 = 'D34') * d_dist_11 +
    (integer)(d_aacd_12 = 'D34') * d_dist_12 +
    (integer)(d_aacd_13 = 'D34') * d_dist_13 +
    (integer)(d_aacd_14 = 'D34') * d_dist_14 +
    (integer)(d_aacd_15 = 'D34') * d_dist_15;

d_rcvalued32 := (integer)(d_aacd_0 = 'D32') * d_dist_0 +
    (integer)(d_aacd_1 = 'D32') * d_dist_1 +
    (integer)(d_aacd_2 = 'D32') * d_dist_2 +
    (integer)(d_aacd_3 = 'D32') * d_dist_3 +
    (integer)(d_aacd_4 = 'D32') * d_dist_4 +
    (integer)(d_aacd_5 = 'D32') * d_dist_5 +
    (integer)(d_aacd_6 = 'D32') * d_dist_6 +
    (integer)(d_aacd_7 = 'D32') * d_dist_7 +
    (integer)(d_aacd_8 = 'D32') * d_dist_8 +
    (integer)(d_aacd_9 = 'D32') * d_dist_9 +
    (integer)(d_aacd_10 = 'D32') * d_dist_10 +
    (integer)(d_aacd_11 = 'D32') * d_dist_11 +
    (integer)(d_aacd_12 = 'D32') * d_dist_12 +
    (integer)(d_aacd_13 = 'D32') * d_dist_13 +
    (integer)(d_aacd_14 = 'D32') * d_dist_14 +
    (integer)(d_aacd_15 = 'D32') * d_dist_15;

d_rcvalued33 := (integer)(d_aacd_0 = 'D33') * d_dist_0 +
    (integer)(d_aacd_1 = 'D33') * d_dist_1 +
    (integer)(d_aacd_2 = 'D33') * d_dist_2 +
    (integer)(d_aacd_3 = 'D33') * d_dist_3 +
    (integer)(d_aacd_4 = 'D33') * d_dist_4 +
    (integer)(d_aacd_5 = 'D33') * d_dist_5 +
    (integer)(d_aacd_6 = 'D33') * d_dist_6 +
    (integer)(d_aacd_7 = 'D33') * d_dist_7 +
    (integer)(d_aacd_8 = 'D33') * d_dist_8 +
    (integer)(d_aacd_9 = 'D33') * d_dist_9 +
    (integer)(d_aacd_10 = 'D33') * d_dist_10 +
    (integer)(d_aacd_11 = 'D33') * d_dist_11 +
    (integer)(d_aacd_12 = 'D33') * d_dist_12 +
    (integer)(d_aacd_13 = 'D33') * d_dist_13 +
    (integer)(d_aacd_14 = 'D33') * d_dist_14 +
    (integer)(d_aacd_15 = 'D33') * d_dist_15;

d_rcvaluel77 := (integer)(d_aacd_0 = 'L77') * d_dist_0 +
    (integer)(d_aacd_1 = 'L77') * d_dist_1 +
    (integer)(d_aacd_2 = 'L77') * d_dist_2 +
    (integer)(d_aacd_3 = 'L77') * d_dist_3 +
    (integer)(d_aacd_4 = 'L77') * d_dist_4 +
    (integer)(d_aacd_5 = 'L77') * d_dist_5 +
    (integer)(d_aacd_6 = 'L77') * d_dist_6 +
    (integer)(d_aacd_7 = 'L77') * d_dist_7 +
    (integer)(d_aacd_8 = 'L77') * d_dist_8 +
    (integer)(d_aacd_9 = 'L77') * d_dist_9 +
    (integer)(d_aacd_10 = 'L77') * d_dist_10 +
    (integer)(d_aacd_11 = 'L77') * d_dist_11 +
    (integer)(d_aacd_12 = 'L77') * d_dist_12 +
    (integer)(d_aacd_13 = 'L77') * d_dist_13 +
    (integer)(d_aacd_14 = 'L77') * d_dist_14 +
    (integer)(d_aacd_15 = 'L77') * d_dist_15;

d_rcvaluea51 := (integer)(d_aacd_0 = 'A51') * d_dist_0 +
    (integer)(d_aacd_1 = 'A51') * d_dist_1 +
    (integer)(d_aacd_2 = 'A51') * d_dist_2 +
    (integer)(d_aacd_3 = 'A51') * d_dist_3 +
    (integer)(d_aacd_4 = 'A51') * d_dist_4 +
    (integer)(d_aacd_5 = 'A51') * d_dist_5 +
    (integer)(d_aacd_6 = 'A51') * d_dist_6 +
    (integer)(d_aacd_7 = 'A51') * d_dist_7 +
    (integer)(d_aacd_8 = 'A51') * d_dist_8 +
    (integer)(d_aacd_9 = 'A51') * d_dist_9 +
    (integer)(d_aacd_10 = 'A51') * d_dist_10 +
    (integer)(d_aacd_11 = 'A51') * d_dist_11 +
    (integer)(d_aacd_12 = 'A51') * d_dist_12 +
    (integer)(d_aacd_13 = 'A51') * d_dist_13 +
    (integer)(d_aacd_14 = 'A51') * d_dist_14 +
    (integer)(d_aacd_15 = 'A51') * d_dist_15;

d_rcvaluea50 := (integer)(d_aacd_0 = 'A50') * d_dist_0 +
    (integer)(d_aacd_1 = 'A50') * d_dist_1 +
    (integer)(d_aacd_2 = 'A50') * d_dist_2 +
    (integer)(d_aacd_3 = 'A50') * d_dist_3 +
    (integer)(d_aacd_4 = 'A50') * d_dist_4 +
    (integer)(d_aacd_5 = 'A50') * d_dist_5 +
    (integer)(d_aacd_6 = 'A50') * d_dist_6 +
    (integer)(d_aacd_7 = 'A50') * d_dist_7 +
    (integer)(d_aacd_8 = 'A50') * d_dist_8 +
    (integer)(d_aacd_9 = 'A50') * d_dist_9 +
    (integer)(d_aacd_10 = 'A50') * d_dist_10 +
    (integer)(d_aacd_11 = 'A50') * d_dist_11 +
    (integer)(d_aacd_12 = 'A50') * d_dist_12 +
    (integer)(d_aacd_13 = 'A50') * d_dist_13 +
    (integer)(d_aacd_14 = 'A50') * d_dist_14 +
    (integer)(d_aacd_15 = 'A50') * d_dist_15;

d_rcvaluel79 := (integer)(d_aacd_0 = 'L79') * d_dist_0 +
    (integer)(d_aacd_1 = 'L79') * d_dist_1 +
    (integer)(d_aacd_2 = 'L79') * d_dist_2 +
    (integer)(d_aacd_3 = 'L79') * d_dist_3 +
    (integer)(d_aacd_4 = 'L79') * d_dist_4 +
    (integer)(d_aacd_5 = 'L79') * d_dist_5 +
    (integer)(d_aacd_6 = 'L79') * d_dist_6 +
    (integer)(d_aacd_7 = 'L79') * d_dist_7 +
    (integer)(d_aacd_8 = 'L79') * d_dist_8 +
    (integer)(d_aacd_9 = 'L79') * d_dist_9 +
    (integer)(d_aacd_10 = 'L79') * d_dist_10 +
    (integer)(d_aacd_11 = 'L79') * d_dist_11 +
    (integer)(d_aacd_12 = 'L79') * d_dist_12 +
    (integer)(d_aacd_13 = 'L79') * d_dist_13 +
    (integer)(d_aacd_14 = 'L79') * d_dist_14 +
    (integer)(d_aacd_15 = 'L79') * d_dist_15;

d_rcvaluei60 := (integer)(d_aacd_0 = 'I60') * d_dist_0 +
    (integer)(d_aacd_1 = 'I60') * d_dist_1 +
    (integer)(d_aacd_2 = 'I60') * d_dist_2 +
    (integer)(d_aacd_3 = 'I60') * d_dist_3 +
    (integer)(d_aacd_4 = 'I60') * d_dist_4 +
    (integer)(d_aacd_5 = 'I60') * d_dist_5 +
    (integer)(d_aacd_6 = 'I60') * d_dist_6 +
    (integer)(d_aacd_7 = 'I60') * d_dist_7 +
    (integer)(d_aacd_8 = 'I60') * d_dist_8 +
    (integer)(d_aacd_9 = 'I60') * d_dist_9 +
    (integer)(d_aacd_10 = 'I60') * d_dist_10 +
    (integer)(d_aacd_11 = 'I60') * d_dist_11 +
    (integer)(d_aacd_12 = 'I60') * d_dist_12 +
    (integer)(d_aacd_13 = 'I60') * d_dist_13 +
    (integer)(d_aacd_14 = 'I60') * d_dist_14 +
    (integer)(d_aacd_15 = 'I60') * d_dist_15;

d_rcvaluef00 := (integer)(d_aacd_0 = 'F00') * d_dist_0 +
    (integer)(d_aacd_1 = 'F00') * d_dist_1 +
    (integer)(d_aacd_2 = 'F00') * d_dist_2 +
    (integer)(d_aacd_3 = 'F00') * d_dist_3 +
    (integer)(d_aacd_4 = 'F00') * d_dist_4 +
    (integer)(d_aacd_5 = 'F00') * d_dist_5 +
    (integer)(d_aacd_6 = 'F00') * d_dist_6 +
    (integer)(d_aacd_7 = 'F00') * d_dist_7 +
    (integer)(d_aacd_8 = 'F00') * d_dist_8 +
    (integer)(d_aacd_9 = 'F00') * d_dist_9 +
    (integer)(d_aacd_10 = 'F00') * d_dist_10 +
    (integer)(d_aacd_11 = 'F00') * d_dist_11 +
    (integer)(d_aacd_12 = 'F00') * d_dist_12 +
    (integer)(d_aacd_13 = 'F00') * d_dist_13 +
    (integer)(d_aacd_14 = 'F00') * d_dist_14 +
    (integer)(d_aacd_15 = 'F00') * d_dist_15;

d_rcvaluei62 := (integer)(d_aacd_0 = 'I62') * d_dist_0 +
    (integer)(d_aacd_1 = 'I62') * d_dist_1 +
    (integer)(d_aacd_2 = 'I62') * d_dist_2 +
    (integer)(d_aacd_3 = 'I62') * d_dist_3 +
    (integer)(d_aacd_4 = 'I62') * d_dist_4 +
    (integer)(d_aacd_5 = 'I62') * d_dist_5 +
    (integer)(d_aacd_6 = 'I62') * d_dist_6 +
    (integer)(d_aacd_7 = 'I62') * d_dist_7 +
    (integer)(d_aacd_8 = 'I62') * d_dist_8 +
    (integer)(d_aacd_9 = 'I62') * d_dist_9 +
    (integer)(d_aacd_10 = 'I62') * d_dist_10 +
    (integer)(d_aacd_11 = 'I62') * d_dist_11 +
    (integer)(d_aacd_12 = 'I62') * d_dist_12 +
    (integer)(d_aacd_13 = 'I62') * d_dist_13 +
    (integer)(d_aacd_14 = 'I62') * d_dist_14 +
    (integer)(d_aacd_15 = 'I62') * d_dist_15;

d_rcvaluec13 := (integer)(d_aacd_0 = 'C13') * d_dist_0 +
    (integer)(d_aacd_1 = 'C13') * d_dist_1 +
    (integer)(d_aacd_2 = 'C13') * d_dist_2 +
    (integer)(d_aacd_3 = 'C13') * d_dist_3 +
    (integer)(d_aacd_4 = 'C13') * d_dist_4 +
    (integer)(d_aacd_5 = 'C13') * d_dist_5 +
    (integer)(d_aacd_6 = 'C13') * d_dist_6 +
    (integer)(d_aacd_7 = 'C13') * d_dist_7 +
    (integer)(d_aacd_8 = 'C13') * d_dist_8 +
    (integer)(d_aacd_9 = 'C13') * d_dist_9 +
    (integer)(d_aacd_10 = 'C13') * d_dist_10 +
    (integer)(d_aacd_11 = 'C13') * d_dist_11 +
    (integer)(d_aacd_12 = 'C13') * d_dist_12 +
    (integer)(d_aacd_13 = 'C13') * d_dist_13 +
    (integer)(d_aacd_14 = 'C13') * d_dist_14 +
    (integer)(d_aacd_15 = 'C13') * d_dist_15;

d_rcvaluec12 := (integer)(d_aacd_0 = 'C12') * d_dist_0 +
    (integer)(d_aacd_1 = 'C12') * d_dist_1 +
    (integer)(d_aacd_2 = 'C12') * d_dist_2 +
    (integer)(d_aacd_3 = 'C12') * d_dist_3 +
    (integer)(d_aacd_4 = 'C12') * d_dist_4 +
    (integer)(d_aacd_5 = 'C12') * d_dist_5 +
    (integer)(d_aacd_6 = 'C12') * d_dist_6 +
    (integer)(d_aacd_7 = 'C12') * d_dist_7 +
    (integer)(d_aacd_8 = 'C12') * d_dist_8 +
    (integer)(d_aacd_9 = 'C12') * d_dist_9 +
    (integer)(d_aacd_10 = 'C12') * d_dist_10 +
    (integer)(d_aacd_11 = 'C12') * d_dist_11 +
    (integer)(d_aacd_12 = 'C12') * d_dist_12 +
    (integer)(d_aacd_13 = 'C12') * d_dist_13 +
    (integer)(d_aacd_14 = 'C12') * d_dist_14 +
    (integer)(d_aacd_15 = 'C12') * d_dist_15;

d_rcvaluee57 := (integer)(d_aacd_0 = 'E57') * d_dist_0 +
    (integer)(d_aacd_1 = 'E57') * d_dist_1 +
    (integer)(d_aacd_2 = 'E57') * d_dist_2 +
    (integer)(d_aacd_3 = 'E57') * d_dist_3 +
    (integer)(d_aacd_4 = 'E57') * d_dist_4 +
    (integer)(d_aacd_5 = 'E57') * d_dist_5 +
    (integer)(d_aacd_6 = 'E57') * d_dist_6 +
    (integer)(d_aacd_7 = 'E57') * d_dist_7 +
    (integer)(d_aacd_8 = 'E57') * d_dist_8 +
    (integer)(d_aacd_9 = 'E57') * d_dist_9 +
    (integer)(d_aacd_10 = 'E57') * d_dist_10 +
    (integer)(d_aacd_11 = 'E57') * d_dist_11 +
    (integer)(d_aacd_12 = 'E57') * d_dist_12 +
    (integer)(d_aacd_13 = 'E57') * d_dist_13 +
    (integer)(d_aacd_14 = 'E57') * d_dist_14 +
    (integer)(d_aacd_15 = 'E57') * d_dist_15;

d_rcvalued31 := (integer)(d_aacd_0 = 'D31') * d_dist_0 +
    (integer)(d_aacd_1 = 'D31') * d_dist_1 +
    (integer)(d_aacd_2 = 'D31') * d_dist_2 +
    (integer)(d_aacd_3 = 'D31') * d_dist_3 +
    (integer)(d_aacd_4 = 'D31') * d_dist_4 +
    (integer)(d_aacd_5 = 'D31') * d_dist_5 +
    (integer)(d_aacd_6 = 'D31') * d_dist_6 +
    (integer)(d_aacd_7 = 'D31') * d_dist_7 +
    (integer)(d_aacd_8 = 'D31') * d_dist_8 +
    (integer)(d_aacd_9 = 'D31') * d_dist_9 +
    (integer)(d_aacd_10 = 'D31') * d_dist_10 +
    (integer)(d_aacd_11 = 'D31') * d_dist_11 +
    (integer)(d_aacd_12 = 'D31') * d_dist_12 +
    (integer)(d_aacd_13 = 'D31') * d_dist_13 +
    (integer)(d_aacd_14 = 'D31') * d_dist_14 +
    (integer)(d_aacd_15 = 'D31') * d_dist_15;

d_rcvaluec14 := (integer)(d_aacd_0 = 'C14') * d_dist_0 +
    (integer)(d_aacd_1 = 'C14') * d_dist_1 +
    (integer)(d_aacd_2 = 'C14') * d_dist_2 +
    (integer)(d_aacd_3 = 'C14') * d_dist_3 +
    (integer)(d_aacd_4 = 'C14') * d_dist_4 +
    (integer)(d_aacd_5 = 'C14') * d_dist_5 +
    (integer)(d_aacd_6 = 'C14') * d_dist_6 +
    (integer)(d_aacd_7 = 'C14') * d_dist_7 +
    (integer)(d_aacd_8 = 'C14') * d_dist_8 +
    (integer)(d_aacd_9 = 'C14') * d_dist_9 +
    (integer)(d_aacd_10 = 'C14') * d_dist_10 +
    (integer)(d_aacd_11 = 'C14') * d_dist_11 +
    (integer)(d_aacd_12 = 'C14') * d_dist_12 +
    (integer)(d_aacd_13 = 'C14') * d_dist_13 +
    (integer)(d_aacd_14 = 'C14') * d_dist_14 +
    (integer)(d_aacd_15 = 'C14') * d_dist_15;


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};


 
//*************************************************************************************//
rc_dataset_d := DATASET([
    {'C20', d_rcvalueC20},
    {'C21', d_rcvalueC21},
    {'L80', d_rcvalueL80},
    {'D34', d_rcvalueD34},
    {'D32', d_rcvalueD32},
    {'D33', d_rcvalueD33},
    {'L77', d_rcvalueL77},
    {'A51', d_rcvalueA51},
    {'A50', d_rcvalueA50},
    {'L79', d_rcvalueL79},
    {'I60', d_rcvalueI60},
    {'F00', d_rcvalueF00},
    {'I62', d_rcvalueI62},
    {'C13', d_rcvalueC13},
    {'C12', d_rcvalueC12},
    {'E57', d_rcvalueE57},
    {'D31', d_rcvalueD31},
    {'C14', d_rcvalueC14}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_d_sorted := sort(rc_dataset_d, rc_dataset_d.value);

d_rc1 := rc_dataset_d_sorted[1].rc;
d_rc2 := rc_dataset_d_sorted[2].rc;
d_rc3 := rc_dataset_d_sorted[3].rc;
d_rc4 := rc_dataset_d_sorted[4].rc;

d_vl1 := rc_dataset_d_sorted[1].value;
d_vl2 := rc_dataset_d_sorted[2].value;
d_vl3 := rc_dataset_d_sorted[3].value;
d_vl4 := rc_dataset_d_sorted[4].value;
//*************************************************************************************//


iv_add_apt := if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0');

iv_rv5_unscorable_1 := if(riskview.constants.noscore(nas_summary,nap_summary, add_input_naprop, le.truedid) , '1', '0');

_header_first_seen := common.sas_date((string)(header_first_seen));

rv_c10_m_hdr_fs := map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => -1,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));

rv_c14_addrs_5yr := map(
    not(truedid)     => NULL,
    not add_curr_pop => -1,
                        min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));

rv_a41_a42_prop_owner_history := map(
    not(truedid)                                                                     => '',
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 'CURRENT',
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 'HISTORICAL',
                                                                                        'NEVER');

rv_i60_inq_hiriskcred_recency := map(
    not(truedid)               => NULL,
   (Boolean)  inq_highRiskCredit_count01 => 1,
   (Boolean) inq_highRiskCredit_count03 => 3,
   (Boolean) inq_highRiskCredit_count06 => 6,
   (Boolean) inq_highRiskCredit_count12 => 12,
   (Boolean) inq_highRiskCredit_count24 => 24,
   (Boolean) inq_highRiskCredit_count   => 99,
                                  0);

rv_i60_inq_comm_recency := map(
    not(truedid)               => NULL,
   (Boolean) inq_communications_count01 => 1,
   (Boolean) inq_communications_count03 => 3,
   (Boolean) inq_communications_count06 => 6,
   (Boolean) inq_communications_count12 => 12,
   (Boolean) inq_communications_count24 => 24,
   (Boolean) inq_communications_count   => 99,
                                  0);

rv_l79_adls_per_sfd_addr_c6 := map(
    not(addrpop)     => NULL,
    iv_add_apt = '1' => -1,
                        min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));

rv_a50_pb_total_dollars := map(
    not(truedid)            => NULL,
    pb_total_dollars = ''  => -1,
                               (Real)pb_total_dollars);

rv_c13_inp_addr_lres := if(not(add_input_pop and truedid), NULL, min(if(add_input_lres = NULL, -NULL, add_input_lres), 999));

rv_i62_inq_phones_per_adl := if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999));

rv_br_active_phone_count := if(not(truedid), NULL, min(if(br_active_phone_count = NULL, -NULL, br_active_phone_count), 999));

o_subscore0 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 24  => -0.418529,
    24 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 33   => -0.269295,
    33 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 99   => -0.075521,
    99 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 199  => -0.044322,
    199 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 258 => 0.137977,
    258 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 310 => 0.208689,
    310 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 395 => 0.267903,
    395 <= rv_c10_m_hdr_fs                           => 0.321824,
                                                        0);

o_subscore1 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 1   => -0.196661,
    1 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 2     => -0.16685,
    2 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 3     => 0.067914,
    3 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 15    => 0.078907,
    15 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 32   => 0.089424,
    32 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 69   => 0.107432,
    69 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 182  => 0.115352,
    182 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 300 => 0.192074,
    300 <= rv_c13_inp_addr_lres                                => 0.219485,
                                                                  0);

o_subscore2 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 0.087552,
    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => -0.029489,
    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => -0.24706,
    3 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 4   => -0.369289,
    4 <= rv_i62_inq_phones_per_adl                                     => -0.566552,
                                                                          0);

o_subscore3 := map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 1 => 0.17968,
    1 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2   => 0.024429,
    2 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 3   => -0.043767,
    3 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 5   => -0.141097,
    5 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 6   => -0.229168,
    6 <= rv_c14_addrs_5yr                            => -0.360432,
                                                        0);

o_subscore4 := map(
    NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 0 => -0.077111,
    0 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 39  => -0.01252,
    39 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 86 => 0.09355,
    86 <= rv_a50_pb_total_dollars                                  => 0.183062,
                                                                      0);

o_subscore5 := map(
    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 0.030583,
    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 6   => -0.380699,
    6 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 12  => -0.325717,
    12 <= rv_i60_inq_hiriskcred_recency                                        => -0.130162,
                                                                                  0);

o_subscore6 := map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 1 => 0.026653,
    1 <= rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 6   => -0.291811,
    6 <= rv_i60_inq_comm_recency                                   => -0.195884,
                                                                      0);

o_subscore7 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 < 0 => 0.082067,
    0 <= rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 < 1   => -0.00384,
    1 <= rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 < 3   => -0.068373,
    3 <= rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 < 5   => -0.089692,
    5 <= rv_l79_adls_per_sfd_addr_c6                                       => -0.123816,
                                                                              0);

o_subscore8 := map(
    (rv_a41_a42_prop_owner_history in [' '])          => 0,
    (rv_a41_a42_prop_owner_history in ['NEVER'])      => -0.0219,
    (rv_a41_a42_prop_owner_history in ['HISTORICAL']) => 0.076463,
    (rv_a41_a42_prop_owner_history in ['CURRENT'])    => 0.089432,
                                                         0);

o_subscore9 := map(
    NULL < rv_br_active_phone_count AND rv_br_active_phone_count < 1 => -0.003883,
    1 <= rv_br_active_phone_count                                    => 0.412922,
                                                                        0);

o_rawscore := o_subscore0 +
    o_subscore1 +
    o_subscore2 +
    o_subscore3 +
    o_subscore4 +
    o_subscore5 +
    o_subscore6 +
    o_subscore7 +
    o_subscore8 +
    o_subscore9;

o_lnoddsscore := o_rawscore + 0.452166;

o_probscore := exp(o_lnoddsscore) / (1 + exp(o_lnoddsscore));

o_aacd_0 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 24  => 'C10',
    24 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 33   => 'C10',
    33 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 99   => 'C10',
    99 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 199  => 'C10',
    199 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 258 => 'C10',
    258 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 310 => 'C10',
    310 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 395 => 'C10',
    395 <= rv_c10_m_hdr_fs                           => 'C10',
                                                        '');

o_dist_0 := o_subscore0 - 0.321824;

o_aacd_1 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 1   => 'C13',
    1 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 2     => 'C13',
    2 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 3     => 'C13',
    3 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 15    => 'C13',
    15 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 32   => 'C13',
    32 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 69   => 'C13',
    69 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 182  => 'C13',
    182 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 300 => 'C13',
    300 <= rv_c13_inp_addr_lres                                => 'C13',
                                                                  '');

o_dist_1 := o_subscore1 - 0.219485;

o_aacd_2 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 'I62',
    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => 'I62',
    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => 'I62',
    3 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 4   => 'I62',
    4 <= rv_i62_inq_phones_per_adl                                     => 'I62',
                                                                          '');

o_dist_2 := o_subscore2 - 0.087552;

o_aacd_3 := map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 1 => 'C14',
    1 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2   => 'C14',
    2 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 3   => 'C14',
    3 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 5   => 'C14',
    5 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 6   => 'C14',
    6 <= rv_c14_addrs_5yr                            => 'C14',
                                                        '');

o_dist_3 := o_subscore3 - 0.17968;

o_aacd_4 := map(
    NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 0 => 'A50',
    0 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 39  => 'A50',
    39 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 86 => 'A50',
    86 <= rv_a50_pb_total_dollars                                  => 'A50',
                                                                      '');

// o_dist_4 := o_subscore4 - 0.183062;
o_dist_4 := 0;

o_aacd_5 := map(
    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 'I60',
    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 6   => 'I60',
    6 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 12  => 'I60',
    12 <= rv_i60_inq_hiriskcred_recency                                        => 'I60',
                                                                                  '');

o_dist_5 := o_subscore5 - 0.030583;

o_aacd_6 := map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 1 => 'I60',
    1 <= rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 6   => 'I60',
    6 <= rv_i60_inq_comm_recency                                   => 'I60',
                                                                      '');

o_dist_6 := o_subscore6 - 0.026653;

o_aacd_7 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 < 0 => 'L77',
    0 <= rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 < 1   => 'L79',
    1 <= rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 < 3   => 'L79',
    3 <= rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 < 5   => 'L79',
    5 <= rv_l79_adls_per_sfd_addr_c6                                       => 'L79',
                                                                              '');

o_dist_7 := o_subscore7 - 0.082067;

o_aacd_8 := map(
    (rv_a41_a42_prop_owner_history in [' '])          => '',
    (rv_a41_a42_prop_owner_history in ['NEVER'])      => 'A41',
    (rv_a41_a42_prop_owner_history in ['HISTORICAL']) => 'A42',
    (rv_a41_a42_prop_owner_history in ['CURRENT'])    => 'A41',
                                                         '');

o_dist_8 := o_subscore8 - 0.089432;

o_aacd_9 := map(
    NULL < rv_br_active_phone_count AND rv_br_active_phone_count < 1 => 'C12',
    1 <= rv_br_active_phone_count                                    => 'C12',
                                                                        '');

o_dist_9 := o_subscore9 - 0.412922;

o_rcvaluec12 := (integer)(o_aacd_0 = 'C12') * o_dist_0 +
    (integer)(o_aacd_1 = 'C12') * o_dist_1 +
    (integer)(o_aacd_2 = 'C12') * o_dist_2 +
    (integer)(o_aacd_3 = 'C12') * o_dist_3 +
    (integer)(o_aacd_4 = 'C12') * o_dist_4 +
    (integer)(o_aacd_5 = 'C12') * o_dist_5 +
    (integer)(o_aacd_6 = 'C12') * o_dist_6 +
    (integer)(o_aacd_7 = 'C12') * o_dist_7 +
    (integer)(o_aacd_8 = 'C12') * o_dist_8 +
    (integer)(o_aacd_9 = 'C12') * o_dist_9;

o_rcvaluel79 := (integer)(o_aacd_0 = 'L79') * o_dist_0 +
    (integer)(o_aacd_1 = 'L79') * o_dist_1 +
    (integer)(o_aacd_2 = 'L79') * o_dist_2 +
    (integer)(o_aacd_3 = 'L79') * o_dist_3 +
    (integer)(o_aacd_4 = 'L79') * o_dist_4 +
    (integer)(o_aacd_5 = 'L79') * o_dist_5 +
    (integer)(o_aacd_6 = 'L79') * o_dist_6 +
    (integer)(o_aacd_7 = 'L79') * o_dist_7 +
    (integer)(o_aacd_8 = 'L79') * o_dist_8 +
    (integer)(o_aacd_9 = 'L79') * o_dist_9;

o_rcvaluel77 := (integer)(o_aacd_0 = 'L77') * o_dist_0 +
    (integer)(o_aacd_1 = 'L77') * o_dist_1 +
    (integer)(o_aacd_2 = 'L77') * o_dist_2 +
    (integer)(o_aacd_3 = 'L77') * o_dist_3 +
    (integer)(o_aacd_4 = 'L77') * o_dist_4 +
    (integer)(o_aacd_5 = 'L77') * o_dist_5 +
    (integer)(o_aacd_6 = 'L77') * o_dist_6 +
    (integer)(o_aacd_7 = 'L77') * o_dist_7 +
    (integer)(o_aacd_8 = 'L77') * o_dist_8 +
    (integer)(o_aacd_9 = 'L77') * o_dist_9;

o_rcvaluea50 := (integer)(o_aacd_0 = 'A50') * o_dist_0 +
    (integer)(o_aacd_1 = 'A50') * o_dist_1 +
    (integer)(o_aacd_2 = 'A50') * o_dist_2 +
    (integer)(o_aacd_3 = 'A50') * o_dist_3 +
    (integer)(o_aacd_4 = 'A50') * o_dist_4 +
    (integer)(o_aacd_5 = 'A50') * o_dist_5 +
    (integer)(o_aacd_6 = 'A50') * o_dist_6 +
    (integer)(o_aacd_7 = 'A50') * o_dist_7 +
    (integer)(o_aacd_8 = 'A50') * o_dist_8 +
    (integer)(o_aacd_9 = 'A50') * o_dist_9;

o_rcvaluei60 := (integer)(o_aacd_0 = 'I60') * o_dist_0 +
    (integer)(o_aacd_1 = 'I60') * o_dist_1 +
    (integer)(o_aacd_2 = 'I60') * o_dist_2 +
    (integer)(o_aacd_3 = 'I60') * o_dist_3 +
    (integer)(o_aacd_4 = 'I60') * o_dist_4 +
    (integer)(o_aacd_5 = 'I60') * o_dist_5 +
    (integer)(o_aacd_6 = 'I60') * o_dist_6 +
    (integer)(o_aacd_7 = 'I60') * o_dist_7 +
    (integer)(o_aacd_8 = 'I60') * o_dist_8 +
    (integer)(o_aacd_9 = 'I60') * o_dist_9;

o_rcvaluei62 := (integer)(o_aacd_0 = 'I62') * o_dist_0 +
    (integer)(o_aacd_1 = 'I62') * o_dist_1 +
    (integer)(o_aacd_2 = 'I62') * o_dist_2 +
    (integer)(o_aacd_3 = 'I62') * o_dist_3 +
    (integer)(o_aacd_4 = 'I62') * o_dist_4 +
    (integer)(o_aacd_5 = 'I62') * o_dist_5 +
    (integer)(o_aacd_6 = 'I62') * o_dist_6 +
    (integer)(o_aacd_7 = 'I62') * o_dist_7 +
    (integer)(o_aacd_8 = 'I62') * o_dist_8 +
    (integer)(o_aacd_9 = 'I62') * o_dist_9;

o_rcvaluea41 := (integer)(o_aacd_0 = 'A41') * o_dist_0 +
    (integer)(o_aacd_1 = 'A41') * o_dist_1 +
    (integer)(o_aacd_2 = 'A41') * o_dist_2 +
    (integer)(o_aacd_3 = 'A41') * o_dist_3 +
    (integer)(o_aacd_4 = 'A41') * o_dist_4 +
    (integer)(o_aacd_5 = 'A41') * o_dist_5 +
    (integer)(o_aacd_6 = 'A41') * o_dist_6 +
    (integer)(o_aacd_7 = 'A41') * o_dist_7 +
    (integer)(o_aacd_8 = 'A41') * o_dist_8 +
    (integer)(o_aacd_9 = 'A41') * o_dist_9;

o_rcvaluec13 := (integer)(o_aacd_0 = 'C13') * o_dist_0 +
    (integer)(o_aacd_1 = 'C13') * o_dist_1 +
    (integer)(o_aacd_2 = 'C13') * o_dist_2 +
    (integer)(o_aacd_3 = 'C13') * o_dist_3 +
    (integer)(o_aacd_4 = 'C13') * o_dist_4 +
    (integer)(o_aacd_5 = 'C13') * o_dist_5 +
    (integer)(o_aacd_6 = 'C13') * o_dist_6 +
    (integer)(o_aacd_7 = 'C13') * o_dist_7 +
    (integer)(o_aacd_8 = 'C13') * o_dist_8 +
    (integer)(o_aacd_9 = 'C13') * o_dist_9;

o_rcvaluea42 := (integer)(o_aacd_0 = 'A42') * o_dist_0 +
    (integer)(o_aacd_1 = 'A42') * o_dist_1 +
    (integer)(o_aacd_2 = 'A42') * o_dist_2 +
    (integer)(o_aacd_3 = 'A42') * o_dist_3 +
    (integer)(o_aacd_4 = 'A42') * o_dist_4 +
    (integer)(o_aacd_5 = 'A42') * o_dist_5 +
    (integer)(o_aacd_6 = 'A42') * o_dist_6 +
    (integer)(o_aacd_7 = 'A42') * o_dist_7 +
    (integer)(o_aacd_8 = 'A42') * o_dist_8 +
    (integer)(o_aacd_9 = 'A42') * o_dist_9;

o_rcvaluec10 := (integer)(o_aacd_0 = 'C10') * o_dist_0 +
    (integer)(o_aacd_1 = 'C10') * o_dist_1 +
    (integer)(o_aacd_2 = 'C10') * o_dist_2 +
    (integer)(o_aacd_3 = 'C10') * o_dist_3 +
    (integer)(o_aacd_4 = 'C10') * o_dist_4 +
    (integer)(o_aacd_5 = 'C10') * o_dist_5 +
    (integer)(o_aacd_6 = 'C10') * o_dist_6 +
    (integer)(o_aacd_7 = 'C10') * o_dist_7 +
    (integer)(o_aacd_8 = 'C10') * o_dist_8 +
    (integer)(o_aacd_9 = 'C10') * o_dist_9;

o_rcvaluec14 := (integer)(o_aacd_0 = 'C14') * o_dist_0 +
    (integer)(o_aacd_1 = 'C14') * o_dist_1 +
    (integer)(o_aacd_2 = 'C14') * o_dist_2 +
    (integer)(o_aacd_3 = 'C14') * o_dist_3 +
    (integer)(o_aacd_4 = 'C14') * o_dist_4 +
    (integer)(o_aacd_5 = 'C14') * o_dist_5 +
    (integer)(o_aacd_6 = 'C14') * o_dist_6 +
    (integer)(o_aacd_7 = 'C14') * o_dist_7 +
    (integer)(o_aacd_8 = 'C14') * o_dist_8 +
    (integer)(o_aacd_9 = 'C14') * o_dist_9;


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//
//*************************************************************************************//
 
//*************************************************************************************//
rc_dataset_o := DATASET([
    {'C12', o_rcvalueC12},
    {'L79', o_rcvalueL79},
    {'L77', o_rcvalueL77},
    {'A50', o_rcvalueA50},
    {'I60', o_rcvalueI60},
    {'I62', o_rcvalueI62},
    {'A41', o_rcvalueA41},
    {'C13', o_rcvalueC13},
    {'A42', o_rcvalueA42},
    {'C10', o_rcvalueC10},
    {'C14', o_rcvalueC14}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_o_sorted := sort(rc_dataset_o, rc_dataset_o.value);

o_rc1 := rc_dataset_o_sorted[1].rc;
o_rc2 := rc_dataset_o_sorted[2].rc;
o_rc3 := rc_dataset_o_sorted[3].rc;
o_rc4 := rc_dataset_o_sorted[4].rc;

o_vl1 := rc_dataset_o_sorted[1].value;
o_vl2 := rc_dataset_o_sorted[2].value;
o_vl3 := rc_dataset_o_sorted[3].value;
o_vl4 := rc_dataset_o_sorted[4].value;
//*************************************************************************************//


iv_rv5_deceased := rc_decsflag = '1' or rc_ssndod != 0 or (Integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0 or (Integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',') > 0;

iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid) , '1', '0');

base := 700;

pdo := 40;

odds := (1 - 0.378) / 0.378;

rva1605_1_0 := map(
    iv_rv5_deceased         => 200,
    iv_rv5_unscorable = '1' => 222,
    jd_2seg = '0 DEROG'     => max(min(if(round(pdo * (ln(d_probscore / (1 - d_probscore)) - ln(odds)) / ln(2) + base) = NULL, -NULL, round(pdo * (ln(d_probscore / (1 - d_probscore)) - ln(odds)) / ln(2) + base)), 900), 501),
                               max(min(if(round(pdo * (ln(o_probscore / (1 - o_probscore)) - ln(odds)) / ln(2) + base) = NULL, -NULL, round(pdo * (ln(o_probscore / (1 - o_probscore)) - ln(odds)) / ln(2) + base)), 900), 501));

rc1_5 := '';

rc2_4 := '';

rc3_4 := '';

rc4_4 := '';

rc5_2 := '';

rc3_3 := if(jd_2seg = '0 DEROG', d_rc3, o_rc3);

rc2_3 := if(jd_2seg = '0 DEROG', d_rc2, o_rc2);

rc1_4 := if(jd_2seg = '0 DEROG', d_rc1, o_rc1);

rc4_3 := if(jd_2seg = '0 DEROG', d_rc4, o_rc4);

rc1_3 := if(trim((string)rc1_4, ALL) = '', 'C10', rc1_4);

_rc_seg := if(jd_2seg = '0 DEROG', 'D30', '   ');

rc3_c92 := map(
    trim((string)rc1_3, LEFT, RIGHT) = '' => '',
    trim((string)rc2_3, LEFT, RIGHT) = '' => '',
    trim((string)rc3_3, LEFT, RIGHT) = '' => _rc_seg,
                                             rc3_3);

rc2_c92 := map(
    trim((string)rc1_3, LEFT, RIGHT) = '' => '',
    trim((string)rc2_3, LEFT, RIGHT) = '' => _rc_seg,
    trim((string)rc3_3, LEFT, RIGHT) = '' => '',
                                             rc2_3);

rc4_c92 := map(
    trim((string)rc1_3, LEFT, RIGHT) = '' => '',
    trim((string)rc2_3, LEFT, RIGHT) = '' => '',
    trim((string)rc3_3, LEFT, RIGHT) = '' => '',
                                             _rc_seg);

rc1_c92 := map(
    trim((string)rc1_3, LEFT, RIGHT) = '' => _rc_seg,
    trim((string)rc2_3, LEFT, RIGHT) = '' => '',
    trim((string)rc3_3, LEFT, RIGHT) = '' => '',
                                             rc1_4);
rc1_2 := if(rc1_4 != '', rc1_4, if(jd_2seg = '0 DEROG' and not((rc1_3 in ['D31', 'D32', 'D33', 'D34'])) and not((rc2_3 in ['D31', 'D32', 'D33', 'D34'])) and not((rc3_3 in ['D31', 'D32', 'D33', 'D34'])), rc1_c92, rc1_3));

rc2_2 := if(rc2_3 != '', rc2_3, if(jd_2seg = '0 DEROG' and not((rc1_3 in ['D31', 'D32', 'D33', 'D34'])) and not((rc2_3 in ['D31', 'D32', 'D33', 'D34'])) and not((rc3_3 in ['D31', 'D32', 'D33', 'D34'])), rc2_c92, rc2_3));

rc3_2 := if(rc3_3 != '', rc3_3, if(jd_2seg = '0 DEROG' and not((rc1_3 in ['D31', 'D32', 'D33', 'D34'])) and not((rc2_3 in ['D31', 'D32', 'D33', 'D34'])) and not((rc3_3 in ['D31', 'D32', 'D33', 'D34'])), rc3_c92, rc3_3));

rc4_2 := if(rc4_3 != '', rc4_3, if(jd_2seg = '0 DEROG' and not((rc1_3 in ['D31', 'D32', 'D33', 'D34'])) and not((rc2_3 in ['D31', 'D32', 'D33', 'D34'])) and not((rc3_3 in ['D31', 'D32', 'D33', 'D34'])), rc4_c92, rc4_3));

_rc_inq := map(
    jd_2seg = '0 DEROG' and rv_i62_inq_phones_per_adl > 0     => 'I62',
    jd_2seg = '0 DEROG' and rv_i60_inq_hiriskcred_recency > 0 => 'I60',
    jd_2seg = '1 OTHER' and rv_i62_inq_phones_per_adl > 0     => 'I62',
    jd_2seg = '1 OTHER' and rv_i60_inq_hiriskcred_recency > 0 => 'I60',
    jd_2seg = '1 OTHER' and rv_i60_inq_comm_recency > 0       => 'I60',
                                                                 '   ');

rc4_c95 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => _rc_inq,
                                             rc4_2);

rc1_c95 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             rc1_2);

rc2_c95 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             rc2_2);

rc5_c95 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             _rc_inq);

rc3_c95 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             rc3_2);

rc1_1 := if(rc1_c95 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc1_c95, rc1_2);

rc4_1 := if(rc4_c95 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc4_c95, rc4_2);

rc2_1 := if(rc2_c95 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc2_c95, rc2_2);

rc5_1 := if(rc5_c95 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc5_c95, rc5_2);

rc3_1 := if(rc3_c95 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc3_c95, rc3_2);

rc2 := if((rva1605_1_0 in [200, 222]), '', rc2_1);

rc1 := if((rva1605_1_0 in [200, 222]), '', rc1_1);

rc4 := if((rva1605_1_0 in [200, 222]), '', rc4_1);

rc3 := if((rva1605_1_0 in [200, 222]), '', rc3_1);

rc5 := if((rva1605_1_0 in [200, 222]), '', rc5_1);

//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
	
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVA1605_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVA1605_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVA1605_1_0 = 900 => DATASET([{'00'}], HRILayout),
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
		/* Model Input Variables */
		self.seq              := le.seq;
    self.sysdate          := sysdate;
    self.tot_liens        := tot_liens;
    self.tot_liens_w_type                 := tot_liens_w_type;
    self.has_derog        := has_derog;
    self.jd_2seg          := jd_2seg;
    self.rv_f00_addr_not_ver_w_ssn        := rv_f00_addr_not_ver_w_ssn;
    self.rv_d32_criminal_x_felony         := rv_d32_criminal_x_felony;
    self.rv_d31_bk_disposed_recent_count  := rv_d31_bk_disposed_recent_count;
    self.rv_c21_stl_inq_count             := rv_c21_stl_inq_count;
    self.rv_d33_eviction_count            := rv_d33_eviction_count;
    self.iv_d34_liens_unrel_x_rel         := iv_d34_liens_unrel_x_rel;
    self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
    self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
    self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
    self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
    self.rv_c20_m_bureau_adl_fs           := rv_c20_m_bureau_adl_fs;
    self.rv_l80_inp_avm_autoval           := rv_l80_inp_avm_autoval;
    self.rv_c13_max_lres                  := rv_c13_max_lres;
    self.rv_prof_license_flag             := rv_prof_license_flag;
    self.rv_e57_br_dead_bus_x_active_phn  := rv_e57_br_dead_bus_x_active_phn;
    self.d_subscore0      := d_subscore0;
    self.d_subscore1      := d_subscore1;
    self.d_subscore2      := d_subscore2;
    self.d_subscore3      := d_subscore3;
    self.d_subscore4      := d_subscore4;
    self.d_subscore5      := d_subscore5;
    self.d_subscore6      := d_subscore6;
    self.d_subscore7      := d_subscore7;
    self.d_subscore8      := d_subscore8;
    self.d_subscore9      := d_subscore9;
    self.d_subscore10     := d_subscore10;
    self.d_subscore11     := d_subscore11;
    self.d_subscore12     := d_subscore12;
    self.d_subscore13     := d_subscore13;
    self.d_subscore14     := d_subscore14;
    self.d_subscore15     := d_subscore15;
    self.d_rawscore       := d_rawscore;
    self.d_lnoddsscore    := d_lnoddsscore;
    self.d_probscore      := d_probscore;
    self.d_aacd_0         := d_aacd_0;
    self.d_dist_0         := d_dist_0;
    self.d_aacd_1         := d_aacd_1;
    self.d_dist_1         := d_dist_1;
    self.d_aacd_2         := d_aacd_2;
    self.d_dist_2         := d_dist_2;
    self.d_aacd_3         := d_aacd_3;
    self.d_dist_3         := d_dist_3;
    self.d_aacd_4         := d_aacd_4;
    self.d_dist_4         := d_dist_4;
    self.d_aacd_5         := d_aacd_5;
    self.d_dist_5         := d_dist_5;
    self.d_aacd_6         := d_aacd_6;
    self.d_dist_6         := d_dist_6;
    self.d_aacd_7         := d_aacd_7;
    self.d_dist_7         := d_dist_7;
    self.d_aacd_8         := d_aacd_8;
    self.d_dist_8         := d_dist_8;
    self.d_aacd_9         := d_aacd_9;
    self.d_dist_9         := d_dist_9;
    self.d_aacd_10        := d_aacd_10;
    self.d_dist_10        := d_dist_10;
    self.d_aacd_11        := d_aacd_11;
    self.d_dist_11        := d_dist_11;
    self.d_aacd_12        := d_aacd_12;
    self.d_dist_12        := d_dist_12;
    self.d_aacd_13        := d_aacd_13;
    self.d_dist_13        := d_dist_13;
    self.d_aacd_14        := d_aacd_14;
    self.d_dist_14        := d_dist_14;
    self.d_aacd_15        := d_aacd_15;
    self.d_dist_15        := d_dist_15;
    self.d_rcvaluec20     := d_rcvaluec20;
    self.d_rcvaluec21     := d_rcvaluec21;
    self.d_rcvaluel80     := d_rcvaluel80;
    self.d_rcvalued34     := d_rcvalued34;
    self.d_rcvalued32     := d_rcvalued32;
    self.d_rcvalued33     := d_rcvalued33;
    self.d_rcvaluel77     := d_rcvaluel77;
    self.d_rcvaluea51     := d_rcvaluea51;
    self.d_rcvaluea50     := d_rcvaluea50;
    self.d_rcvaluel79     := d_rcvaluel79;
    self.d_rcvaluei60     := d_rcvaluei60;
    self.d_rcvaluef00     := d_rcvaluef00;
    self.d_rcvaluei62     := d_rcvaluei62;
    self.d_rcvaluec13     := d_rcvaluec13;
    self.d_rcvaluec12     := d_rcvaluec12;
    self.d_rcvaluee57     := d_rcvaluee57;
    self.d_rcvalued31     := d_rcvalued31;
    self.d_rcvaluec14     := d_rcvaluec14;
    self.d_rc1            := d_rc1;
    self.d_rc2            := d_rc2;
    self.d_rc3            := d_rc3;
    self.d_rc4            := d_rc4;
    self.d_vl1            := d_vl1;
    self.d_vl2            := d_vl2;
    self.d_vl3            := d_vl3;
    self.d_vl4            := d_vl4;
    self.iv_add_apt       := iv_add_apt;
    self._header_first_seen               := _header_first_seen;
    self.rv_c10_m_hdr_fs                  := rv_c10_m_hdr_fs;
    self.rv_c14_addrs_5yr                 := rv_c14_addrs_5yr;
    self.rv_a41_a42_prop_owner_history    := rv_a41_a42_prop_owner_history;
    self.rv_i60_inq_hiriskcred_recency    := rv_i60_inq_hiriskcred_recency;
    self.rv_i60_inq_comm_recency          := rv_i60_inq_comm_recency;
    self.rv_l79_adls_per_sfd_addr_c6      := rv_l79_adls_per_sfd_addr_c6;
    self.rv_a50_pb_total_dollars          := rv_a50_pb_total_dollars;
    self.rv_c13_inp_addr_lres             := rv_c13_inp_addr_lres;
    self.rv_i62_inq_phones_per_adl        := rv_i62_inq_phones_per_adl;
    self.rv_br_active_phone_count         := rv_br_active_phone_count;
    self.o_subscore0      := o_subscore0;
    self.o_subscore1      := o_subscore1;
    self.o_subscore2      := o_subscore2;
    self.o_subscore3      := o_subscore3;
    self.o_subscore4      := o_subscore4;
    self.o_subscore5      := o_subscore5;
    self.o_subscore6      := o_subscore6;
    self.o_subscore7      := o_subscore7;
    self.o_subscore8      := o_subscore8;
    self.o_subscore9      := o_subscore9;
    self.o_rawscore       := o_rawscore;
    self.o_lnoddsscore    := o_lnoddsscore;
    self.o_probscore      := o_probscore;
    self.o_aacd_0         := o_aacd_0;
    self.o_dist_0         := o_dist_0;
    self.o_aacd_1         := o_aacd_1;
    self.o_dist_1         := o_dist_1;
    self.o_aacd_2         := o_aacd_2;
    self.o_dist_2         := o_dist_2;
    self.o_aacd_3         := o_aacd_3;
    self.o_dist_3         := o_dist_3;
    self.o_aacd_4         := o_aacd_4;
    self.o_dist_4         := o_dist_4;
    self.o_aacd_5         := o_aacd_5;
    self.o_dist_5         := o_dist_5;
    self.o_aacd_6         := o_aacd_6;
    self.o_dist_6         := o_dist_6;
    self.o_aacd_7         := o_aacd_7;
    self.o_dist_7         := o_dist_7;
    self.o_aacd_8         := o_aacd_8;
    self.o_dist_8         := o_dist_8;
    self.o_aacd_9         := o_aacd_9;
    self.o_dist_9         := o_dist_9;
    self.o_rcvaluec12     := o_rcvaluec12;
    self.o_rcvaluel79     := o_rcvaluel79;
    self.o_rcvaluel77     := o_rcvaluel77;
    self.o_rcvaluea50     := o_rcvaluea50;
    self.o_rcvaluei60     := o_rcvaluei60;
    self.o_rcvaluei62     := o_rcvaluei62;
    self.o_rcvaluea41     := o_rcvaluea41;
    self.o_rcvaluec13     := o_rcvaluec13;
    self.o_rcvaluea42     := o_rcvaluea42;
    self.o_rcvaluec10     := o_rcvaluec10;
    self.o_rcvaluec14     := o_rcvaluec14;
    self.o_rc1            := o_rc1;
    self.o_rc2            := o_rc2;
    self.o_rc3            := o_rc3;
    self.o_rc4            := o_rc4;
    self.o_vl1            := o_vl1;
    self.o_vl2            := o_vl2;
    self.o_vl3            := o_vl3;
    self.o_vl4            := o_vl4;
    self.iv_rv5_deceased                  := iv_rv5_deceased;
    self.iv_rv5_unscorable                := iv_rv5_unscorable;
    self.base             := base;
    self.pdo              := pdo;
    self.odds             := odds;
    self.rva1605_1_0      := rva1605_1_0;
    self._rc_seg          := _rc_seg;
    self._rc_inq          := _rc_inq;
    self.rc5              := rc5;
    self.rc3              := rc3;
    self.rc4              := rc4;
    self.rc2              := rc2;
    self.rc1              := rc1;

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rva1605_1_0;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));
	

	RETURN(model);
END;



